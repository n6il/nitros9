********************************************************************
* rb1773 - Western Digital 1773 Disk Controller Driver
*
* A lot of references to **.CYL or <u00B6 using 16 bit registers can be
* changed to 8 bit registers with a +1 offset, since track #'s >255 are
* ignored
*
* NOTE: 512 bytes is reserved as a physical sector buffer. Any reads/
*  writes are done from this buffer to the controller. Copies of the 256
*  byte chunk needed are done by a block memory move
*
* Disto Super Controller II Registers:
*
* $FF74   RW.Dat  --- R/W Buffer data #1
* $FF75       mirror of $FF74
* $FF76   RW.Ctrl --- Write  D0 = 0  FDC Write Op #2
*                               = 1  FDC Read Op  #2
*                            D1 = 0  Normal Mode
*                               = 1  Buffered I/O Mode
*                            D2 = 0  Normal NMI
*                               = 1  Masked NMI
*                            D3 = 0  No FIRQ (Masked)
*                               = 1  Enabled FIRQ
*                     Read   D7 = FDC INT Status (Inverted)
* $FF77       mirror of $FF76
*        #1: any write to $FF76-$FF77 clears Buffer counter
*        #2: in buffered mode only
*
* $Id$
*
* Edt/Rev  YYYY/MM/DD  Modified by
* Comment
* ------------------------------------------------------------------
*  11      1993/05/12  ???
* Special opts for TC9 to slow controller reads and writes TFM's
* between sector buffers & in drive table init/copies.
* Changed software timing loop (drive spin-up) to F$Sleep for 32 ticks
* Shrunk (slowed slightly) error returns
* Added blobstop code
*
*  11r1    2003/09/03  Boisy G. Pitre
* Added code to sense if HW is present or not and return error if not.
*
*   1r0    2004/05/20  Boisy G. Pitre
* Restarted edition due to name change; backported to Level 1

         nam   rb1773
         ttl   Western Digital 1773 Disk Controller Driver

         IFP1
         use   defsfile
         ENDC

tylg     set   Drivr+Objct   
atrv     set   ReEnt+rev
rev      set   $00
edition  set   1

* Configuration Settings
N.Drives equ   4              number of drives to support
TC9      equ   0              Set to 1 for TC9 special slowdowns
PRECOMP  equ   0              Set to 1 to turn on write precompensation

* WD-17X3 Definitions
CtrlReg  equ   $00		Control register for Tandy controllers; not part of WD
WD_Cmd   equ   $08
WD_Stat  equ   WD_Cmd
WD_Trak  equ   $09
WD_Sect  equ   $0A
WD_Data  equ   $0B

* WD-17X3 Commands
S$FrcInt equ   $D0

* Control Register Definitions
C_HALT   equ   %10000000	Halt line to CPU is active when set
C_SIDSEL equ   %01000000	Side select (0 = front side, 1 = back side)
C_DBLDNS equ   %00100000	Density (0 = single, 1 = double)
C_WPRCMP equ   %00010000	Write precompensation (0 = off, 1 = on)
C_MOTOR  equ   %00001000	Drive motor (0 = off, 1 = on)
C_DRV2   equ   %00000100	Drive 2 selected when set
C_DRV1   equ   %00000010	Drive 1 selected when set
C_DRV0   equ   %00000001	Drive 0 selected when set

         mod   eom,name,tylg,atrv,start,size

u0000    rmb   DRVBEG+(DRVMEM*N.Drives)
u00A7    rmb   2              Last drive table accessed (ptr)
CtlImg   rmb   1              Bit mask for control reg (drive #, side,etc)
u00AA    rmb   1
sectbuf  rmb   2              Ptr to 512 byte sector buffer
u00AD    rmb   1
u00AE    rmb   1
FBlock   rmb   2              block number for format
         IFGT  Level-1
FTask    rmb   1              task number for format
         ENDC
VIRQPak  rmb   2              Vi.Cnt word for VIRQ
u00B3    rmb   2              Vi.Rst word for VIRQ
u00B5    rmb   1              Vi.Stat byte for VIRQ (drive motor timeout)
loglsn   rmb   2              OS9's logical sector #
physlsn  rmb   1              PCDOS (512 byte sector) sector #
size     equ   .

         fcb   DIR.+SHARE.+PEXEC.+PWRIT.+PREAD.+EXEC.+UPDAT.

name     fcs   /rb1773/
         fcb   edition

VIRQCnt  fdb   TkPerSec*4     Initial count for VIRQ (4 seconds)

IRQPkt   fcb   $00            Normal bits (flip byte)
         fcb   $01            Bit 1 is interrupt request flag (Mask byte)
         fcb   10             Priority byte

* Init
*
* Entry:
*    Y  = address of device descriptor
*    U  = address of device memory area
*
* Exit:
*    CC = carry set on error
*    B  = error code
*     
* New code added 09/03/2003 by Boisy G. Pitre
* Write a pattern to $FF4B and read it back to verify that the hardware
* does exist.
Init     ldx   V.PORT,u       get Base port address
         lda   WD_Data,x      get byte at FDC Data register
         coma                 complement it to modify it
         sta   WD_Data,x      write it
         clrb
Init2    decb                 delay a bit...
         bmi   Init2
         suba  WD_Data,x      read it back
         lbne  NoHW           if not zero, we didn't read what we wrote
**
         IFEQ  Level-1
         clr   >D.DskTmr      flag drive motor as not running
         ELSE
         clr   <D.MotOn       flag drive motor as not running
         ENDC
         leax  WD_Stat,x      point to Status/Command register
         lda   #S$FrcInt      "Force Interrupt" command
         sta   ,x             send to FDC
         lbsr  FDCDelay       time delay for ~ 108 cycles
         lda   ,x             eat status register
         ldd   #$FF*256+N.Drives  'invalid' value & # of drives
         sta   >physlsn,u     set 512 byte sector # to bogus value
         sta   >physlsn+1,u
         leax  DRVBEG,u       point to start of drive tables
l@       sta   ,x             DD.TOT MSB to bogus value
         sta   <V.TRAK,x      init current track # to bogus value
         leax  <DRVMEM,x      point to next drive table
         decb                 done all drives yet?
         bne   l@             no, init them all
         leax  >NMISvc,pc     point to NMI service routine
         IFGT  Level-1
         stx   <D.NMI         install as system NMI
         ELSE
         stx   >D.XNMI+1	NMI jump vector operand
         lda   #$7E		JMP code
         sta   >D.XNMI		NMI jump vector opcode
         ENDC
         pshs  y              save device dsc. ptr
         leay  >u00B5,u       point to Vi.Stat in VIRQ packet
         tfr   y,d            make it the status register ptr for IRQ
         leay  >IRQSvc,pc     point to IRQ service routine
         leax  >IRQPkt,pc     point to IRQ packet
         os9   F$IRQ          install IRQ
         puls  y              Get back device dsc. ptr
         bcs   Return         If we can't install IRQ, exit
 IFNE SCII
 lda MPI.Slct
 sta mpislot,u
 ldd #RW.Ctrl
 leay SC2vec,pcr
 os9  F$IRQ
 bcs Return
 pshs cc
 orcc #IntMasks
 lda $FF23
* disable FIRQ from cart. set flag on falling edge of CART
 anda #$FC
 sta $FF23
 lda $FF22
 lda D.IRQER
 ora #1 enable CART IRQ
 sta D.IRQER .. save in IRQENR shadow
 sta IRQENR .. and actual register
 puls cc
 ENDC
         ldd   #512           Request 512 byte sector buffer
         pshs  u              Preserve device mem ptr
         os9   F$SRqMem       Request sector buffer
         tfr   u,x            Move ptr to sector buffer to x
         puls  u              Restore device mem ptr
         bcs   Return         If error, exit with it
         stx   >sectbuf,u     Save ptr to sector buffer

* GetStat
*
* Entry:
*    A  = function code
*    Y  = address of path descriptor
*    U  = address of device memory area
*
* Exit:
*    CC = carry set on error
*    B  = error code
*
GetStat  clrb                 no GetStt calls - return, no error, ignore
Return   rts   

* Term
*
* Entry:
*    U  = address of device memory area
*
* Exit:
*    CC = carry set on error
*    B  = error code
*
Term     leay  >VIRQPak,u       Point to VIRQ packet
         IFNE  H6309
         tfr   0,x            "remove"
         ELSE
         ldx   #$0000
         ENDC
         os9   F$VIRQ         Remove VIRQ
         IFNE  H6309
         tfr   0,x            "remove"
         ELSE
         ldx   #$0000
         ENDC
         leay  >IRQSvc,pc     point to IRQ service routine
         os9   F$IRQ          Remove IRQ
 IFNE  SCII
 IFNE  H6309
 tfr   0,x            "remove"
 ELSE
 ldx   #$0000
 ENDC
 leay  SC2vec,pcr
 os9   F$IRQ          Remove IRQ
 ENDC
         pshs  u              Save device mem ptr
         ldu   >sectbuf,u     Get pointer to sector buffer
         ldd   #512           Return sector buffer memory
         os9   F$SRtMem 
         puls  u              Restore device mem ptr
         clr   >DPort+CtrlReg shut off drive motors
         IFEQ  Level-1
         clr   >D.DskTmr      Clear out drive motor timeout flag
         ELSE
         clr   <D.MotOn       Clear out drive motor timeout flag
         ENDC
ex       rts                  return

* Check if 512 byte sector conversion needed
* Entry: B:X=LSN
*          U=Static mem ptr
*          Y=Path dsc. ptr
* Exit:    X=New LSN (same as original for 256 byte sectors, 1/2 of original
*            for 512 byte sectors
Chk512   pshs  x,b            save LSN
         stx   >loglsn,u      save OS9 LSN
         lda   <PD.TYP,y      get device type from path dsc.
         anda  #%00000100     mask out all but 512 byte sector flag
         bne   Log2Phys       512 byte sectors, go process
L00CA    puls  pc,x,b         restore LSN & return
* 512 byte sector processing goes here
Log2Phys puls  x,b            Get back LSN
         clrb                 Clear carry for rotate (also high byte of LSN)
         tfr   x,d            Move to mathable register
         IFNE  H6309
         rord                 Divide LSN by 2
         ELSE
         rora
         rorb
         ENDC
         tfr   d,x            Move new LSN back to X
         stx   >physlsn,u     Save 'physical' LSN (for controller)
         clrb                 No error & return
         rts   

start    lbra  Init
         bra   Read
         nop
         lbra  Write
         bra   GetStat
         nop
         lbra  SetStat
         bra   Term
         nop

* Read
*
* Entry:
*    B  = MSB of LSN
*    X  = LSB of LSN
*    Y  = address of path descriptor
*    U  = address of device memory area
*
* Exit:
*    CC = carry set on error
*    B  = error code
*
Read     bsr   Chk512         go check for 512 byte sector/adjust if needed
         lda   #%10010001     error flags (see Disto SCII source)
         pshs  x              preserve sector #
         lbsr  L0162          go read the sector
         puls  x              restore sector #
         bcs   ex             if error, exit
         pshs  y,x            save path dsc ptr & LSN
         leax  ,x             LSN0?
         bne   L012D          no, go calculate normally
         puls  y,x            yes, restore path dsc ptr & LSN
         lda   <PD.TYP,y      get type from path dsc.
         bita  #TYP.NSF       standard OS-9 format?
         beq   L00F0          yes, skip ahead
         lbsr  L051A
         pshs  y,x            save path dsc ptr
         bra   L012D

* LSN0, standard OS-9 format
L00F0    ldx   >sectbuf,u     Get ptr to sector buffer
         pshs  y,x            Preserve path dsc. ptr & sector buffer ptr
         ldy   >u00A7,u       Get last drive table accessed ptr
         IFNE  H6309
         ldw   #DD.SIZ        # bytes to copy from new LSN0 to drive table
         tfm   x+,y+          Copy them
         ELSE
         ldb   #DD.SIZ
L00F0Lp  lda   ,x+
         sta   ,y+
         decb
         bne   L00F0Lp
         ENDC
         ldy   >u00A7,u       Get drive table ptr back
         lda   <DD.FMT,y      Get format for disk in drive
         ldy   2,s            restore path descriptor pointer
         ldb   <PD.DNS,y      Get path's density settings
         bita  #FMT.DNS       Disk in drive double density?
         beq   L0115          No, all drives can read single, skip ahead
         bitb  #DNS.MFM       Can our path dsc. handle double density?
         beq   erbtyp         No, illegal
L0115    bita  #FMT.TDNS      Is new disk 96 tpi?
         beq   L011D          No, all drives handle 48 tpi, so skip ahead
         bitb  #DNS.DTD       Can path dsc. handle 96 tpi?
         beq   erbtyp         No, illegal
L011D    bita  #FMT.SIDE      Is new disk double sided?
         beq   L0128          No, all drives handle single sided, we're done
         lda   <PD.SID,y      Get # sides path dsc. can handle
         suba  #2             sides higher or equal to 2?
         blo   erbtyp         Yes, exit with illegal type error
L0128    clrb                 No error
*        puls  y,x            ??? 2 USELESS LINES?
*        pshs  y,x
* LSN's other than 0 come straight here
L012D    ldy   2,s            Get path dsc. ptr back??
         ldx   PD.BUF,y       Get path dsc. buffer ptr
         lda   <PD.TYP,y      Get path dsc. disk type
         ldy   >sectbuf,u     Get ptr to sector buffer
         IFNE  H6309
         ldw   #256           OS9 sector size (even if physical was 512)
         ENDC
         anda  #%00000100     Mask out all but 512 byte sector flag
         beq   L014B          If normal sector, just copy it
         ldd   >loglsn,u       Get OS9's LSN (twice of the 'real' 512 sector)
         andb  #$01           Mask out all but odd/even sector indicator
         beq   L014B          Even, use 1st half of 512 byte sector
         IFNE  H6309
         addr  w,y            Odd, bump sector buffer ptr to 2nd half
         ELSE
         leay  256,y
         ENDC
L014B    equ   *
         IFNE  H6309
         tfm   y+,x+          Copy from physical sector buffer to PD buffer
         puls  pc,y,x         restore path dsc & sector buffer ptrs & return
         ELSE
         pshs  d
         clrb
L014BLp  lda   ,y+
         sta   ,x+
         decb
         bne   L014BLp
         puls  pc,y,x,d       restore path dsc & sector buffer ptrs & return
         ENDC

erbtyp   comb  
         ldb   #E$BTyp        Error - wrong type error
         puls  pc,y,x

* Read error - retry handler
L0159    bcc   L0162          Normal retry, try reading again
         pshs  x,d            Preserve regs
         lbsr  sktrk0         Seek to track 0 (attempt to recalibrate)
         puls  x,d            Restore regs & try reading again

L0162    pshs  x,d            Preserve regs
         bsr   L016F          Go read sector
         puls  x,d            Restore regs (A=retry flags)
         bcc   L01D7          No error, return
         lsra                 Shift retry flags
         bne   L0159          Still more retries allowed, go do them
* otherwise, final try before we give up
L016F    lbsr  L02AC          Do double-step/precomp etc. if needed, seek
         bcs   L01D7          Error somewhere, exit with it
L0176    ldx   >sectbuf,u     Get physical sector buffer ptr
*         pshs  y,cc           Preserve timeout timer & CC
         ldb   #$80           Read sector command
         bsr   L01A1          Send to controller & time delay to let it settle
*** Next few lines are commented out for blobstop patches
*L0180    bita  >DPort+WD_Stat check status register
*         bne   L0197          eat it & start reading sector
*         leay  -1,y           bump timeout timer down
*         bne   L0180          keep trying until it reaches 0 or sector read
*         lda   >CtlImg,u       get current drive settings
*         ora   #C_MOTOR       turn drive motor on
*         sta   >DPort+CtrlReg send to controller
*         puls  y,cc           restore regs
*         lbra  L03E0          exit with Read Error
*** Blobstop fixes
         stb   >DPort+CtrlReg send B to control register
         nop                  allow HALT to take effect
         nop
         bra   L0197          and a bit more time
* Read loop - exited with NMI
* Entry: X=ptr to sector buffer
*        B=Control register settings
L0197    lda   >DPort+WD_Data get byte from controller
         sta   ,x+            store into sector buffer
*         stb   >DPort+CtrlReg drive info
         nop               -- blobstop fix
         bra   L0197          Keep reading until sector done

L01A1    orcc  #IntMasks      Shut off IRQ & FIRQ
         stb   >DPort+WD_Cmd  Send command
*         ldy   #$FFFF
         ldb   #C_DBLDNS+C_MOTOR  Double density & motor on
*         ldb   #%00101000     Double density & motor on
         orb   >CtlImg,u       Merge with current drive settings
         stb   >DPort+CtrlReg Send to control register
         ldb   #C_HALT+C_DBLDNS+C_MOTOR Enable halt, double density & motor on
*         ldb   #%10101000     Enable halt, double density & motor on
         orb   >CtlImg,u       Merge that with current drive settings
         lbra  FDCDelay        Time delay to wait for command to settle
*         lda   #$02
*L01BE    rts   

* Write
*
* Entry:
*    B  = MSB of LSN
*    X  = LSB of LSN
*    Y  = address of path descriptor
*    U  = address of device memory area
*
* Exit:
*    CC = carry set on error
*    B  = error code
*
Write    lbsr  Chk512         go adjust LSN for 512 byte sector if needed
         lda   #%1001001      retry flags for I/O errors (see Disto SCII source)
L01C4    pshs  x,d            preserve LSN, retries
         bsr   L01E8          go write the sector
         puls  x,d            restore LSN, retries
         bcs   L01D8          error writing, go to write retry handler
         tst   <PD.VFY,y      no error, do we want physical verify?
         bne   L01D6          no, exit without error
         lbsr  verify         go re-read & verify 32 out of 256 bytes
         bcs   L01D8          error on verify, go to write retry handler
L01D6    clrb                 no error & return
L01D7    rts   

* Write error retry handler
L01D8    lsra                 Shift retry flags
         lbeq  L03AF          Too many retries, exit with error
         bcc   L01C4          Normal retry, attemp to re-write sector
         pshs  x,d            Preserve flags & sector #
         lbsr  sktrk0         Seek to track 0 (attempt to recalibrate)
         puls  x,d            Restore flags & sector #
         bra   L01C4          Try re-writing now

* 512 byte sector write here
L01E8    lbsr  L02AC          Go do double-step/write precomp if needed
         bcs   L01D7          Error, exit with it
         pshs  y,d            Preserve path dsc. ptr & LSN
         lda   <PD.TYP,y      Get device type
         anda  #%00000100     512 byte sector?
         beq   L020D          No, skip ahead
         lda   #$91           ??? appears to be useless
         lbsr  L0176          Go read the sector in
         ldd   >loglsn,u       Get OS9 LSN
         andb  #$01           Even or odd?
         beq   L020D          Even, skip ahead
         ldx   >sectbuf,u     Get physical sector buffer ptr
         leax  >$0100,x       Point to 2nd half
         bra   L0211          Copy caller's buffer to 2nd half of sector

L020D    ldx   >sectbuf,u     Get physical sector buffer ptr

L0211    ldy   PD.BUF,y       Get path dsc. buffer ptr
         IFNE  H6309
         ldw   #256           Copy write buffer to sector buffer
         tfm   y+,x+
         ELSE
         clrb
L0211Lp  lda   ,y+
         sta   ,x+
         decb
         bne   L0211Lp
         ENDC
         puls  y,d             Get path dsc. ptr & LSN back
         ldx   >sectbuf,u      Get physical sector buffer ptr again
         ldb   #$A0            Write sector command

* Format track comes here with B=$F0 (write track)
*WrTrk    pshs  y,cc           Preserve path dsc. ptr & CC
WrTrk     lbsr  L01A1          Send command to controller (including delay)
*** Commented out for blobstop fixes
*L0229    bita  >DPort+WD_Stat Controller done yet?
*         bne   L0240          Yes, go write sector out
*         leay  -$01,y         No, bump wait counter
*         bne   L0229          Still more tries, continue
*         lda   >CtlImg,u       Get current drive control register settings
*         ora   #C_MOTOR       Drive motor on (but drive select off)
*         sta   >DPort+CtrlReg Send to controller
*         puls  y,cc           Restore regs
*         lbra  L03AF          Check for errors from status register

         IFGT  Level-1
*** added blobstop
         lda   FBlock+1,u      get the block number for format
         beq   L0230           if not format, don't do anything
         sta   >$FFA1          otherwise map the block in
         ENDC
L0230    stb   >DPort+CtrlReg  send data to control register
         bra   L0240           wait a bit for HALT to enable

* Write sector routine (Entry: B= drive/side select) (NMI will break out)
L0240    nop               --- wait a bit more
         lda   ,x+             Get byte from write buffer
         sta   >DPort+WD_Data  Save to FDC's data register
* EAT 2 CYCLES: TC9 ONLY (TRY 1 CYCLE AND SEE HOW IT WORKS)
         IFEQ TC9-1
         nop
         nop
         ENDC
*         stb   >DPort+CtrlReg Set up to read next byte
         bra   L0240          Go read it

* NMI routine
NMISvc   leas  R$Size,s       Eat register stack
*         puls  y,cc           Get path dsc. ptr & CC
         IFGT  Level-1
         ldx   <D.SysDAT  get pointer to system DAT image
         lda   3,x        get block number 1
         sta   >$FFA1     map it back into memory
         ENDC
         andcc #^IntMasks turn IRQ's on again
         ldb   >DPort+WD_Stat  Get status register
         bitb  #%00000100     Did we lose data in the transfer?
*         lbne  L03E0          Yes, exit with Read Error
         lbeq  L03B2          Otherwise, check for drive errors
         comb             -- blobstop error code
         ldb   #E$DevBsy  -- device busy
         rts              -- and exit

verify   pshs  x,d
         ldx   PD.BUF,y       Get write buffer ptr
         pshs  x              Preserve it
         ldx   >sectbuf,u     Get sector buffer ptr
         stx   PD.BUF,y       Save as write buffer ptr
         ldx   4,s
         lbsr  L016F          Go read sector we just wrote
         puls  x              Get original write buffer ptr
         stx   PD.BUF,y       Restore path dsc. version
         bcs   L02A3          If error reading, exit with it
         pshs  u,y            Preserve device mem, path dsc. ptrs
         ldb   <PD.TYP,y      Get type from path dsc.
         ldy   >sectbuf,u     Get sector buffer ptr
         andb  #%00000100     512 byte sector?
         beq   L028D          No, skip ahead
         ldd   >loglsn,u       Get OS9's sector #
         andb  #$01           Odd/even sector?
         beq   L028D          Even; compare first half
         leay  >$0100,y       Odd, compare second half
L028D    tfr   x,u            Move PD.BUF ptr to U (since cmpx is faster)
         lda   #32            # of 'spotty' checks to do
L028F    ldx   ,u             Get 2 bytes from original write buffer
         cmpx  ,y             Same as corresponding bytes in re-read sector?
         bne   L029F          No, error & return
         leau  8,u            Skip next 6 bytes
         leay  8,y
         deca                 Done our 'spotty' check?
         bne   L028F          No, continue
         fcb   $8C            skip the next 2 bytes

L029F    orcc  #Carry
L02A1    puls  u,y
L02A3    puls  pc,x,d

L02A5    pshs  a              Save Caller's track #
         ldb   <V.TRAK,x      Get track # drive is currently on
         bra   L02E9          Go save it to controller & continue

L02AC    lbsr  L0376          Go set up controller for drive, spin motor up
         bsr   L032B          Get track/sector # (A=Trk, B=Sector)
         pshs  a              Save track #
         lda   >u00AD,u       Get side 1/2 flag
         beq   L02C4          Side 1, skip ahead
         lda   >CtlImg,u       Get control register settings
         ora   #C_SIDSEL      Set side 2 (drive 3) select
*         ora   #%01000000     Set side 2 (drive 3) select
         sta   >CtlImg,u       Save it back
L02C4    lda   <PD.TYP,y      Get drive type settings
         bita  #%00000010     ??? (Base 0/1 for sector #?)
         bne   L02CC          Skip ahead
         incb                 Bump sector # up by 1
L02CC    stb   >DPort+WD_Sect Save into Sector register
         ldx   >u00A7,u       Get last drive table accessed
         ldb   <V.TRAK,x      Get current track # on device
         lda   <DD.FMT,x      Get drive format specs
         lsra                 Shift track & bit densities to match PD
         eora  <PD.DNS,y      Check for differences with path densities
         anda  #%00000010     Keep only 48/96 tpi differences
         pshs  a              Save differences
         lda   1,s            Get track # back
         tst   ,s+            Are tpi's different?
         beq   L02E9          No, continue normally
         lsla                 Yes, multiply track # by 2 ('double-step')
         lslb                 Multiply current track # by 2 ('double-step')
L02E9    stb   >DPort+WD_Trak Save current track # onto controller

* From here to the line before L0307 is for write precomp, but is not used.
* Unless write precomp is needed, all of this is useless
* I think most (if not all) drives do NOT need precomp
         IFEQ  PRECOMP-1
         ldb   #21            Pre-comp track #
         pshs  b              Save it
         ldb   <PD.DNS,y      Get current density settings
         andb  #%00000010     Just want to check track density
         beq   L02F9          48 tpi, skip ahead
         lsl   ,s             Multiply pre-comp value by 2 ('double-step')
L02F9    cmpa  ,s+            Is track # high enough to warrant precomp?
         bls   L0307          No, continue normally
         ldb   >CtlImg,u
         orb   #C_WRPCMP     Turn on Write precomp
*         orb   #%00010000     Turn on Write precomp
         stb   >CtlImg,u
         ENDC

L0307    ldb   >u00AA,u       ??? Get flag (same drive flag?)
         bne   L0314          no, skip ahead
         ldb   ,s             get track #
         cmpb  <V.TRAK,x      same as current track on this drive?
         beq   L0321          yes, skip ahead
L0314    sta   >DPort+WD_Data save track # to data register
         ldb   <PD.STP,y      get stepping rate
         andb  #%00000011     just keep usable settings (6-30 ms)
         eorb  #%00011011     set proper bits for controller
         lbsr  L03E4          send command to controller & time delay
L0321    puls  a              get track # back
         sta   <V.TRAK,x      save as current track #
         sta   >DPort+WD_Trak save to controller
         clrb                 no error & return
         rts   

* Entry: B:X LSN
* Exit:  A=Track #
*        B=Sector #
*   <u00AD=00 = Head 1 , $FF = Head 2
L032B    tstb                 Sector # > 65535?
         bne   L033F          Yes, illegal for floppy
         tfr   x,d            Move sector # to D
         leax  ,x         LSN 0?
         beq   L0371          Yes, exit this routine
         ldx   >u00A7,u       Get previous drive table ptr
         cmpd  DD.TOT+1,x     Within range of drive spec?
         blo   L0343          Yes, go calculate track/sector #'s
L033F    comb                 Exit with Bad sector # error
         ldb   #E$Sect
         rts   

* Calculate track/sector #'s?
L0343    stb   >u00AE,u       Save LSB of LSN
         clr   ,-s            Clear track # on stack
         ldb   <DD.FMT,x      Get drive format
         lsrb                 Shift out # sides into carry
         ldb   >u00AE,u       Get LSB of LSN again
         bcc   L0367          Single sided drive, skip ahead
         bra   L035D          Double sided drive, skip ahead
* Double sided drive handling here
L0355    com   >u00AD,u       ???? Odd/even sector track flag?
         bne   L035D          Odd, so don't bump track # up
         inc   ,s             Bump up track #

L035D    subb  DD.TKS,x       Subtract # sectors/track
         sbca  #$00
         bcc   L0355          Still more sectors left, continue
         bra   L036D          Wrapped, skip ahead
* Single sided drive handling here
L0365    inc   ,s             Bump track # up

L0367    subb  DD.TKS,x       Subtract # sectors/track
         sbca  #$00
         bcc   L0365          Still more, go bump the track up
L036D    addb  $03,x          Bump sector # back up from negative value
         puls  a              Get the track #
L0371    rts                  A=track #, B=Sector #, <u00AD=Odd

* Drive control register bit mask table
L0372    fcb   $01            Drive 0
         fcb   $02            Drive 1
         fcb   $04            Drive 2
         fcb   $40            Drive 3 / Side select

L0376    clr   >u00AA,u       ???

chkdrv   lda   <PD.DRV,y      Get drive # requested
         cmpa  #4             Drive 0-3?
         blo   L0385          Yes, continue normally
NoHW     comb                 Illegal drive # error
         ldb   #E$Unit
         rts   

* Entry: A=drive #, X=LSN (Physical, not OS9 logical if PCDOS disk)
L0385    pshs  x,d            Save sector #, drive # & B???
         leax  >L0372,pc      Point to drive bit mask table
         ldb   a,x            Get bit mask for drive # we want
         stb   >CtlImg,u       Save mask
         leax  DRVBEG,u       Point to beginning of drive tables
         ldb   #DRVMEM        Get size of each drive table
         mul                  Calculate offset to drive table we want
         leax  d,x            Point to it
         cmpx  >u00A7,u       Same as Last drive table accessed?
         beq   L03A6          Yes, skip ahead
         stx   >u00A7,u       Save new drive table ptr
         com   >u00AA,u       ??? Set flag
L03A6    clr   >u00AD,u       Set side (head) flag to side 1
         lbsr  L04B3          Go set up VIRQ to wait for drive motor
         puls  pc,x,d         Restore sector #,drive #,B & return

L03AF    ldb   >DPort+WD_Stat Get status register from FDC
L03B2    bitb  #%11111000     Any of the error bits set?
         beq   L03CA          No, exit without error
         aslb             Drive not ready?
         bcs   L03CC          Yes, use that error code
         aslb             Write protect error?
         bcs   L03D0          Yes, use that error code
         aslb             Write fault error?
         bcs   L03D4          Yes, use that error code
         aslb             Sector not found?
         bcs   L03D8          Yes, use Seek error code
         aslb             CRC error?
         bcs   L03DC          Yes, use that error code
L03CA    clrb                 No error & return
         rts   

L03CC    ldb   #E$NotRdy      not ready
         fcb   $8C        skip 2 bytes

L03D0    ldb   #E$WP          write protect
         fcb   $8C        skip 2 bytes

L03D4    ldb   #E$Write       write error
         fcb   $8C

L03D8    ldb   #E$Seek        seek error
         fcb   $8C

L03DC    ldb   #E$CRC         CRC error
*         fcb   $8C

*L03E0    ldb   #E$Read        Read error
         orcc  #Carry         set carry
         rts   

L03E4    bsr   L0404          Send command to controller & waste some time
L03E6    ldb   >DPort+WD_Stat Check FDC status register
         bitb  #$01           Is controller still busy?
         beq   L0403          No, exit
         ldd   >VIRQCnt,pc    Get initial count value for drive motor speed
         std   >VIRQPak,u       Save it
         bra   L03E6          Wait for controller to finish previous command

* Send command to FDC
L03F7    lda   #C_MOTOR
*        lda   #%00001000     Mask in Drive motor on bit
         ora   >CtlImg,u       Merge in drive/side selects
         sta   >DPort+CtrlReg Turn the drive motor on & select drive
         stb   >DPort+WD_Cmd  Save command & return
L0403    rts   

L0404    bsr   L03F7          Go send command to controller

* This loop has been changed from nested LBSRs to timing loop.
* People with crystal upgrades should modify the loop counter
* to get a 58+ us delay time.  MINIMUM 58us.
FDCDelay
         pshs  a          14 cycles, plus 3*loop counter
         IFEQ  Level-1
         lda   #18        (only do about a 100 cycle delay for now)
         ELSE
         lda   #29        (only do about a 100 cycle delay for now)
         ENDC
L0409    deca             for total ~63 us delay (123 cycles max.)
         bne   L0409
         puls  a,pc       restore register and exit

* SetStat
*
* Entry:
*    A  = function code
*    Y  = address of path descriptor
*    U  = address of device memory area
*
* Exit:
*    CC = carry set on error
*    B  = error code
*
SetStat  ldx   PD.RGS,y       Get caller's register stack ptr
         ldb   R$B,x          Get function code
         cmpb  #SS.WTrk       Write track?
         beq   SSWTrk         Yes, go do it
         cmpb  #SS.Reset      Restore head to track 0?
         lbeq  sktrk0         Yes, go do it --- beq
         comb                 set carry for error
         ldb   #E$UnkSvc      return illegal service request error
         rts   

SSWTrk   pshs  u,y            preserve register stack & descriptor

* Level 2 Code
         IFGT   Level-1

*--- new code
         ldb   #1         1 block to allocate
         os9   F$AllRAM   allocate some RAM
         bcs   L0489      error out if at all
         leax  >FBlock,u   point to 'my' DAT image
         std   ,x         save a copy of the block
         os9   F$ResTsk   reserve a task number for the copy
         bcs   FError     error out
         stb   2,x        save temporary task number in FTask,u
         lslb             2 bytes per entry
         ldu   <D.TskIPt  get task image table pointer
         stx   b,u        save pointer to the task's DAT image
         lsrb             get the right number again
         IFNE  H6309
         tfr   0,u        destination is address 0
         ELSE
         ldu   #$0000
         ENDC
*--- end new code

         ldx   2,s            get pointer to descriptor
*         stu   >FBlock,x
         ldx   <D.Proc        Get current process ptr
         lda   P$Task,x       Get task # for current process
*         ldb   <D.SysTsk      Get system task #
         ldy   ,s
         ldx   PD.RGS,y       Get register stack ptr
         ldx   R$X,x          Get ptr to caller's track buffer
         ldy   #$1A00         Size of track buffer
         os9   F$Move         Copy from caller to temporary task
         bcs   L0479          Error copying, exit
         puls  u,y
         pshs  u,y

         ENDC
* End of Level 2 Code

         lbsr  L0376          Go check drive #/wait for it to spin up
         ldx   PD.RGS,y       Get caller's register stack ptr
         ldb   R$Y+1,x        Get caller's side/density
         bitb  #$01           Check side
         beq   L0465          Side 1, skip ahead
         com   >u00AD,u
         ldb   >CtlImg,u       Get current control register settings
*         orb   #%01000000     Mask in side 2
         orb   #C_SIDSEL      Mask in side 2
         stb   >CtlImg,u       Save updated control register
L0465    lda   R$U+1,x        Get caller's track #
         ldx   >u00A7,u       Get current drive table ptr
         lbsr  L02A5          
         bcs   L0489
         ldb   #$F0           Write track command?
*---
         IFEQ  Level-1
         ldx   PD.RGS,y
         ldx   R$X,x
         ELSE
         ldx   #$2000     start writing from block 1
         ENDC

         lbsr  WrTrk          Go write the track

         IFGT  Level-1
L0479    ldu   2,s
         pshs  b,cc           Preserve error
         ldb   >FTask,u   point to task
         os9   F$RelTsk   release the task
         fcb   $8C        skip 2 bytes

* format comes here when block allocation passes, but task allocation
* gives error.  So er de-allocate the block.
FError   
         pshs  b,cc       save error code, cc
         ldx   >FBlock,u   point to block
         ldb   #1         1 block to return
         os9   F$DelRAM   de-allocate image RAM blocks
         clr   FBlock+1,u ensure that the block # in FBlock is zero.
         puls  b,cc           Restore error
         ENDC

L0489    puls  pc,u,y         Restore regs & return

* seek the head to track 0
sktrk0   lbsr  chkdrv
         ldx   >u00A7,u
         clr   <$15,x
         lda   #$05
L0497    ldb   <PD.STP,y
         andb  #%00000011     Just keep usable settings (6-30 ms)
         eorb  #%01001011     Set proper bits for controller
         pshs  a
         lbsr  L03E4
         puls  a
         deca  
         bne   L0497
         ldb   <PD.STP,y
         andb  #%00000011     Just keep usable settings (6-30 ms)
         eorb  #%00001011     Set proper bits for controller
         lbra  L03E4

L04B3    pshs  y,x,d          Preserve regs
         ldd   >VIRQCnt,pc    Get VIRQ initial count value
         std   >VIRQPak,u       Save it
         lda   >CtlImg,u       ?Get drive?
         ora   #C_MOTOR       Turn drive motor on for that drive
*         ora   #%00001000     Turn drive motor on for that drive
         sta   >DPort+CtrlReg Send drive motor on command to FDC
         IFEQ  Level-1
         lda   >D.DskTmr      Get VIRQ flag
         ELSE
         lda   <D.MotOn       Get VIRQ flag
         ENDC
         bmi   L04DE          Not installed yet, try installing it
         bne   L04E0          Drive already up to speed, exit without error

* Drive motor speed timing loop (could be F$Sleep call now) (was over .5 sec)
         ldx   #32            wait for 32 ticks
         os9   F$Sleep

L04DE    bsr   InsVIRQ        Install VIRQ to wait for drive motors
L04E0    clrb                 No error & return
         puls  pc,y,x,d

InsVIRQ  lda   #$01           Flag drive motor is up to speed
         IFEQ  Level-1
         sta   >D.DskTmr
         ELSE
         sta   <D.MotOn
         ENDC
         ldx   #$0001         Install VIRQ entry
         leay  >VIRQPak,u       Point to packet
         clr   Vi.Stat,y      Reset Status byte
         ldd   >VIRQCnt,pc    Get initial VIRQ count value
         os9   F$VIRQ         Install VIRQ
         bcc   VIRQOut        No error, exit
         lda   #$80           Flag that VIRQ wasn't installed
         IFEQ  Level-1
         sta   >D.DskTmr
         ELSE
         sta   <D.MotOn
         ENDC
VIRQOut  clra  
         rts   

* IRQ service routine for VIRQ (drive motor time)
* Entry: U=Ptr to VIRQ memory area
IRQSvc   pshs  a
         lda   <D.DMAReq
         beq   L0509
         bsr   InsVIRQ
         bra   IRQOut
L0509    sta   >DPort+CtrlReg
         IFNE  H6309
         aim   #$FE,>u00B5,u
         ELSE
         lda   u00B5,u
         anda  #$FE
         sta   u00B5,u
         ENDC
*         fdb   u00B5      --- so changes in data size won't affect anything
         IFEQ  Level-1
         clr   >D.DskTmr
         ELSE
         clr   <D.MotOn
         ENDC
IRQOut   puls  pc,a

* Non-OS9 format goes here
* Entry: X=LSN
*        Y=Path dsc. ptr
*        U=Device mem ptr
L051A    pshs  x              Preserve Logical sector #
         ldx   >u00A7,u       Get last drive table accessed ptr
         clra
         pshs  x,a            Save ptr & NUL byte
         IFNE  H6309
         ldw   #$14           Clear 20 bytes
         tfm   s,x+
         ELSE
         ldb   #$14
L051ALp  clr   ,x+
         decb
         bne   L051ALp
         ENDC
         puls  x,a            Eat NUL & get back drive table ptr
         ldb   <PD.CYL+1,y    Get # cylinders on drive (ignores high byte)
         lda   <PD.SID,y      Get # sides
         mul                  Calculate # tracks on drive (1 per head)
         IFNE  H6309
         decd                 Adjust to ignore track 0
         ELSE
         subd  #$0001
         ENDC
         lda   <PD.SCT+1,y    Get # sectors/track
         sta   DD.TKS,x       Save in drive table
         sta   <DD.SPT+1,x    Save in other copy in drive table
         mul                  Calculate # sectors on drive (minus track 0)
         pshs  x              Preserve drive table ptr
         tfr   d,x            Move # sectors on drive to X
         lda   <PD.T0S+1,y    Get # sectors on track 0
         leax  a,x            Add that many sectors to total
         lda   <PD.TYP,y      Get device type settings
         anda  #%00000100     Mask out all but 512 byte sector flag
         beq   L0550          Not 512 byte sector, skip ahead
         IFNE  H6309
         addr  x,x        Multiply by 2 (convert to 256 byte OS9 sectors)
         ELSE
         tfr   x,d
         leax  d,x
         ENDC
L0550    tfr   x,d            Move # sectors to D
         puls  x              Get back drive table ptr
         std   DD.TOT+1,x     Save # sectors allowed on drive
         lda   #UPDAT.+EXEC.  Owner's read/write/exec attributes
         sta   DD.ATT,x       Set attributes for disk
         lda   <PD.DNS,y      Get density settings
         lsla                 Shift for DD.FMT
         pshs  a              Preserve it a sec
         lda   <PD.SID,y      Get # sides
         deca                 Adjust to base 0
         ora   ,s+            Merge with density settings
         sta   <DD.FMT,x      Save in device table
         clrb                 No error?
         puls  pc,x           Restore original LSN & return

         emod
eom      equ   *
         end
