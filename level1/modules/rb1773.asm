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

         nam   rb1773
         ttl   Western Digital 1773 Disk Controller Driver

         IFP1
         use   defsfile
         ENDC

tylg     set   Drivr+Objct   
atrv     set   ReEnt+rev
rev      set   $01
edition  set   11

         IFGT  Level-1

* Configuration Settings
N.Drives equ   4		number of drives to support
TC9      equ   0              Set to 1 for TC9 special slowdowns
PRECOMP  equ   0              Set to 1 to turn on write precompensation

* WD-17X3 Definitions
WD_Cmd   equ   $08
WD_Stat  equ   WD_Cmd
WD_Trak  equ   $09
WD_Sect  equ   $0A
WD_Data  equ   $0B

         mod   eom,name,tylg,atrv,start,size

u0000    rmb   DRVBEG+(DRVMEM*N.Drives)
u00A7    rmb   2              Last drive table accessed (ptr)
u00A9    rmb   1              Bit mask for control reg (drive #, side,etc)
u00AA    rmb   1
sectbuf  rmb   2              Ptr to 512 byte sector buffer
u00AD    rmb   1
u00AE    rmb   1
FBlock   rmb   2              block number for format
         IFGT  Level-1
FTask    rmb   1              task number for format
         ENDC
u00B1    rmb   2              Vi.Cnt word for VIRQ
u00B3    rmb   2              Vi.Rst word for VIRQ
u00B5    rmb   1              Vi.Stat byte for VIRQ (drive motor timeout)
u00B6    rmb   2              OS9's logical sector #
u00B8    rmb   1              PCDOS (512 byte sector) sector #
size     equ   .

         fcb   DIR.+SHARE.+PEXEC.+PWRIT.+PREAD.+EXEC.+UPDAT.

name     equ   *
         IFEQ  Level-1
         fcs   /CCDisk/
         ELSE
         fcs   /rb1773/
         ENDC
         fcb   edition

VIRQCnt  fdb   $00F0          Initial count for VIRQ (240)

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
         lda   #$D0           force Interrupt command
         sta   ,x             send to FDC
         lbsr  L0406          time delay for ~ 108 cycles
         lda   ,x             eat status register
         ldd   #$FF*256+N.Drives  'invalid' value & # of drives
         sta   >u00B8,u       set 512 byte sector # to bogus value
         sta   >u00B8+1,u
         leax  DRVBEG,u       point to start of drive tables
L004B    sta   ,x             DD.TOT MSB to bogus value
         sta   <V.TRAK,x      init current track # to bogus value
         leax  <DRVMEM,x      point to next drive table
         decb                 done all 4 drives yet?
         bne   L004B          no, init them all
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
Term     leay  >u00B1,u       Point to VIRQ packet
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
         os9   F$IRQ          Remove IRQ
         pshs  u              Save device mem ptr
         ldu   >sectbuf,u     Get pointer to sector buffer
         ldd   #512           Return sector buffer memory
         os9   F$SRtMem 
         puls  u              Restore device mem ptr
         clr   >DPort         shut off drive motors
         IFEQ  Level-1
         clr   >D.DskTmr      Clear out drive motor timeout flag
         ELSE
         clr   <D.MotOn       Clear out drive motor timeout flag
         ENDC
L00AB    rts                  return

* Check if 512 byte sector conversion needed
* Entry: B:X=LSN
*          U=Static mem ptr
*          Y=Path dsc. ptr
* Exit:    X=New LSN (same as original for 256 byte sectors, 1/2 of original
*            for 512 byte sectors
L00AC    pshs  x,b            Save LSN
         stx   >u00B6,u       Save OS9 LSN
         lda   <PD.TYP,y      Get device type from path dsc.
         anda  #%00000100     Mask out all but 512 byte sector flag
         bne   L00BB          512 byte sectors, go process
L00CA    puls  pc,x,b         Restore LSN & return

* 512 byte sector processing goes here
L00BB    puls  x,b            Get back LSN
         clrb                 Clear carry for rotate (also high byte of LSN)
         tfr   x,d            Move to mathable register
         IFNE  H6309
         rord                 Divide LSN by 2
         ELSE
         rora
         rorb
         ENDC
         tfr   d,x            Move new LSN back to X
         stx   >u00B8,u       Save 'physical' LSN (for controller)
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
Read     bsr   L00AC          Go check for 512 byte sector/adjust if needed
         lda   #%10010001     Error flags (see Disto SCII source)
         pshs  x              Preserve sector #
         lbsr  L0162          Go read the sector
         puls  x              Restore sector #
         bcs   L00AB          If error, exit
         pshs  y,x            Save path dsc ptr & LSN
         leax  ,x             LSN0?
         bne   L012D          No, go calculate normally
         puls  y,x            Yes, restore path dsc ptr & LSN
         lda   <PD.TYP,y      Get type from path dsc.
         bita  #TYP.NSF       Standard OS-9 format?
         beq   L00F0          Yes, skip ahead
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
         ldd   >u00B6,u       Get OS9's LSN (twice of the 'real' 512 sector)
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
*         lda   >u00A9,u       get current drive settings
*         ora   #%00001000     turn drive motor on
*         sta   >DPort         send to controller
*         puls  y,cc           restore regs
*         lbra  L03E0          exit with Read Error
*** Blobstop fixes
         stb   >DPort         send command to FDC
         nop                  allow HALT to take effect
         nop
         bra   L0197          and a bit more time
* Read loop - exited with NMI
* Entry: X=ptr to sector buffer
*        B=Control register settings
L0197    lda   >DPort+WD_Data get byte from controller
         sta   ,x+            store into sector buffer
*         stb   >DPort        drive info
         nop               -- blobstop fix
         bra   L0197          Keep reading until sector done

L01A1    orcc  #IntMasks      Shut off IRQ & FIRQ
         stb   >DPort+WD_Cmd  Send command
*         ldy   #$FFFF
         ldb   #%00101000     Double density & motor on
         orb   >u00A9,u       Merge with current drive settings
         stb   >DPort         Send to control register
         ldb   #%10101000     Enable halt, double density & motor on
         orb   >u00A9,u       Merge that with current drive settings
         lbra  L0406          Time delay to wait for command to settle
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
Write    lbsr  L00AC          Go adjust LSN for 512 byte sector if needed
         lda   #%1001001      Retry flags for I/O errors (see Disto SCII source)
L01C4    pshs  x,d            Preserve LSN, retries
         bsr   L01E8          Go write the sector
         puls  x,d            Restore LSN, retries
         bcs   L01D8          Error writing, go to write retry handler
         tst   <PD.VFY,y      No error, do we want physical verify?
         bne   L01D6          No, exit without error
         lbsr  verify         Go re-read & verify 32 out of 256 bytes
         bcs   L01D8          Error on verify, go to write retry handler
L01D6    clrb                 No error & return
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
         ldd   >u00B6,u       Get OS9 LSN
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
*L0224    pshs  y,cc           Preserve path dsc. ptr & CC
L0224     lbsr  L01A1          Send command to controller (including delay)
*** Commented out for blobstop fixes
*L0229    bita  >DPort+WD_Stat Controller done yet?
*         bne   L0240          Yes, go write sector out
*         leay  -$01,y         No, bump wait counter
*         bne   L0229          Still more tries, continue
*         lda   >u00A9,u       Get current drive control register settings
*         ora   #%00001000     Drive motor on (but drive select off)
*         sta   >DPort         Send to controller
*         puls  y,cc           Restore regs
*         lbra  L03AF          Check for errors from status register

         IFGT  Level-1
*** added blobstop
         lda   FBlock+1,u      get the block number for format
         beq   L0230           if not format, don't do anything
         sta   >$FFA1          otherwise map the block in
         ENDC

L0230    stb   >DPort          send command to FDC
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
*         stb   >DPort        Set up to read next byte
         bra   L0240          Go read it

* NMI routine
NMISvc   leas  R$Size,s       Eat register stack
*         puls  y,cc           Get path dsc. ptr & CC
         IFGT  Level-1
         ldx   <D.SysDAT  get pointer to system DAT image
         lda   3,x        get block number 1
         sta   >$FFA1     map it back into memory
         andcc #^IntMasks turn IRQ's on again
         ELSE
*         puls  y,cc           Get path dsc. ptr & CC
         ENDC
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
         ldd   >u00B6,u       Get OS9's sector #
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
         lda   >u00A9,u       Get control register settings
         ora   #%01000000     Set side 2 (drive 3) select
         sta   >u00A9,u       Save it back
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
         ldb   >u00A9,u
         orb   #%00010000     Turn on Write precomp
         stb   >u00A9,u
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
         stb   >u00A9,u       Save mask
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
         std   >u00B1,u       Save it
         bra   L03E6          Wait for controller to finish previous command

* Send command to FDC
L03F7    lda   #%00001000     Mask in Drive motor on bit
         ora   >u00A9,u       Merge in drive/side selects
         sta   >DPort         Turn the drive motor on & select drive
         stb   >DPort+WD_Cmd  Save command & return
L0403    rts   

L0404    bsr   L03F7          Go send command to controller

* This loop has been changed from nested LBSRs to timing loop.
* People with crystal upgrades should modify the loop counter
* to get a 58+ us delay time.  MINIMUM 58us.
L0406    pshs  a          14 cycles, plus 3*loop counter
         lda   #29        (only do about a 100 cycle delay for now)
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

         IFEQ   Level-1

         ldd   #$1A00         Size of buffer to hold entire track image
         os9   F$SRqMem       Request memory from system
         bcs   L0489          Error requesting, exit with it
         stu   >FBlock,x

         ELSE

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

         ENDC

         puls  u,y
         pshs  u,y
         lbsr  L0376          Go check drive #/wait for it to spin up
         ldx   PD.RGS,y       Get caller's register stack ptr
         ldb   R$Y+1,x        Get caller's side/density
         bitb  #$01           Check side
         beq   L0465          Side 1, skip ahead
         com   >u00AD,u
         ldb   >u00A9,u       Get current control register settings
         orb   #%01000000     Mask in side 2
         stb   >u00A9,u       Save updated control register
L0465    lda   R$U+1,x        Get caller's track #
         ldx   >u00A7,u       Get current drive table ptr
         lbsr  L02A5          
         bcs   L0489
         ldb   #$F0           Write track command?
*---
         IFEQ  Level-1
         ldx   >FBlock,u
         ELSE
         ldx   #$2000     start writing from block 1
         ENDC

         lbsr  L0224          Go write the track
L0479    ldu   2,s
         pshs  b,cc           Preserve error

         IFEQ  Level-1

         ldu   >FBlock,u       Get ptr to track buffer
         ldd   #$1A00         Return track buffer
         os9   F$SRtMem 

         ELSE

         ldb   >FTask,u   point to task
         os9   F$RelTsk   release the task
         fcb   $8C        skip 2 bytes

         ENDC

* format comes here when block allocation passes, but task allocation
* gives error.  So er de-allocate the block.
FError   
         IFGT  Level-1
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
         std   >u00B1,u       Save it
         lda   >u00A9,u       ?Get drive?
         ora   #%00001000     Turn drive motor on for that drive
         sta   >DPort         Send drive motor on command to FDC
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
         leay  >u00B1,u       Point to packet
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
L0509    sta   >DPort
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

         ELSE

*****************************************************************
*    NewDisk -- copyright 1985 by Dave Lewis.
*    Released to public domain January, 1986
*    Permission granted to copy and redistribute provided this
*      header is included with all copies.
*
* This program is intended to replace the CCDisk module in the
*   OS9Boot file on the OS-9 system disk. It is far more
*   versatile than the disk driver provided with Color Computer
*   OS-9, and is also slightly smaller (20 bytes or so).
*   Some of its features are:
*
*  -Uses the device descriptor to set head step rate. Original
*     had 30mS hard-coded in.
*  -Handles double-sided disks.
*  -Gets its track and side information from the disk so you
*     can read and write disks in any format the drive can
*     physically handle. You can use 40-track double sided disks
*     and still read/write 35-track single side disks.
*  -Performs some tests before attempting to use the disk.
*     The original CCDisk would hang the system if you tried to
*     access a drive without a disk in it (I know, I know - you
*     don't have to say `DUMMY!' - but it happens). You can
*     hang this one too but not as easily.
*  -An 80-track double sided disk holds 720Kbytes of data.
*     That's four and a half 35-track single siders.
*  -All of this stuff is completely transparent once NewDisk is
*     installed. NewDisk automatically senses the disk format
*     and conforms to it. (within limits -- don't use non-OS9
*     formats)
*
* One problem -- this program is not complete in itself. If you
*   want to boot from a double-sided disk you will need my
*   version of OS9Gen which will generate a double-sided system
*   disk. Don't try it with the stock version; you'll have to
*   reformat the disk to clean it up afterwards.
*****************************************************************
*           Copyright 1985 by Dave Lewis.
*
* UUCP address is loral!dml; in S. Cal. use ihnp4!sdcc3!loral
*
* I'm releasing this program to public domain. Copy it, share
*   it, but don't you DARE sell it! I worked hard on it. Include
*   this header with all copies.
*
* If you like this program, send me 5 bucks to encourage me to
*   write more stuff - or at least to release it. If you send
*   me 10 bucks I'll send you a good (Dysan) double side disk
*   formatted 35 track single side with both sourcecode and
*   executable binary files of the following:
*
*   - NewDisk -- single or double sided disks, any number of
*       tracks within reason, step rate set in device descriptor
*   - OS9Gen -- rewritten version that automatically senses for
*       single/double sided disk and puts all the boot data in
*       the right places. Also enters the kernel file in the
*       root directory, which makes Dcheck happy.
*   - Separate -- breaks up your bootfile into its component
*       modules for modification. Replace or remove any module
*       individually.
*   - Diskdescr -- sourcecode for an OS-9 disk device descriptor
*       with EQUates at the beginning for step rate, #tracks,
*       and single or double sided.
*   - Documentation and procedure files for installing all of
*       the above in most common system configurations.
*   - Other stuff I've written that you may find useful.
*
*   Send to:
*             Dave Lewis
*             4417 Idaho  Apt. 4
*             San Diego CA 92116
*****************************************************************
*
*
*  Copyright 1985 by Dave Lewis
*                4417 Idaho apt. 4
*                San Diego, CA 92116
*  Released to public domain January, 1986
*
*
*
N.DRIVES EQU 3 Number of drives supported
DISKRUN  EQU $70 Disk run time after access
NMIVECT  EQU $109 NMI jump vector in RAM
COMDREG  EQU $FF48 1793 Command register (write)
STATREG  EQU $FF48 1793 Status register (read)
TRAKREG  EQU $FF49 1793 Track register
SECTREG  EQU $FF4A 1793 Sector register
DATAREG  EQU $FF4B 1793 Data register
*
         MOD eom,NAME,tylg,atrv,EXEC,STORG
         FCB $FF Mode byte -- all modes
NAME     FCS 'rb1773'
         FCB 4 Version number
*
         RMB DRVBEG Storage common to all drives
TABL.ORG RMB DRVMEM Drive 0 parameter table
         RMB DRVMEM Drive 1 parameter table
         RMB DRVMEM Drive 2 parameter table
DRV.ACT  RMB 2 Active drive's table origin
DPRT.IMG RMB 1 Drive control port image byte
DRVS.RDY RMB 1 Drive ready flags
Q.SEEK   RMB 1 Same drive/track flag
STORG    EQU . Total storage required
*
*  Function dispatch vectors
*
EXEC     LBRA INIT Initialize variables
         LBRA READ Read one sector
         LBRA WRITE Write one sector
         LBRA RETNOERR GETSTA call is not used
         LBRA SETSTA Two oddball calls
         LBRA RETNOERR TERM call is not used
*
INIT     CLR >D.DSKTMR Zero disk rundown timer
         LDA #$D0 `Force interrupt' command
         STA >COMDREG
         LDA #$FF
         LDB #N.DRIVES Number of drives
         STB V.NDRV,U
         LEAX TABL.ORG,U Origin of first drive table
INI.TBL  STA DD.TOT+1,X Make total sectors nonzero
         STA V.TRAK,X Force first seek to track 0
         CLR DD.FMT,X Make it see a 1-sided disk
         LEAX DRVMEM,X Go to next drive table
         DECB Test for last table done
         BNE INI.TBL Loop if not finished
         LEAX NMI.SVC,PCR Get address of NMI routine
         STX >NMIVECT+1 NMI Jump vector operand
         LDA #$7E Jump opcode
         STA >NMIVECT NMI Jump vector opcode
         LDA >STATREG Clear interrupt condition
RETNOERR CLRB
         RTS
*
ERR.WPRT COMB Set carry flag
         LDB #E$WP Set error code
         RTS
ERR.SEEK COMB Set carry flag
         LDB #E$SEEK Set error code
         RTS
ERR.CRC  COMB Set carry flag
         LDB #E$CRC Set error code
         RTS
ERR.READ COMB Set carry flag
         LDB #E$READ Set error code
         RTS
*
* All disk controller commands exit via NMI. The service routine
*   returns control to the address on top of stack after registers
*   have been dumped off.
*
NMI.SVC  LEAS R$SIZE,S Dump registers off stack
         LDA >STATREG Get status condition
STAT.TST LSLA Test status register bit 7
         LBCS ERR.NRDY Status = Not Ready if set
         LSLA Test bit 6
         BCS ERR.WPRT Status = Write Protect if set
         LSLA Test bit 5
         LBCS ERR.WRT Status = Write Fault if set
         LSLA Test bit 4
         BCS ERR.SEEK Status = Record Not Found
         LSLA Test bit 3
         BCS ERR.CRC Status = CRC Error if set
         LSLA Test bit 2
         BCS ERR.READ Status = Lost Data if set
         CLRB No error if all 0
RETURN1  RTS
*
READ     TSTB If LSN is greater than 65,536
         BNE ERR.SECT   return a sector error
         LDA #$A4 Set retry control byte
         CMPX #0 Is it sector 0?
         BNE READ2 If not, just read the data
         BSR READ2 If sector 0, read it and
         BCS RETURN1   update drive table
         PSHS Y,X Save X and Y
         LDX PD.BUF,Y Point to data buffer
         LDY DRV.ACT,U Point to active drive's table
         LDB #DD.RES+1 Counter and offset pointer
SEC0LOOP LDA B,X Get byte from buffer
         STA B,Y Store in drive table
         DECB Decrement loop index
         BPL SEC0LOOP Loop until B < 0
         CLRB No error
         PULS X,Y,PC Pull and return
*
WRITE    TSTB If LSN is greater than 65,536
         BNE ERR.SECT   return a sector error
         LDA #$A4 Set retry control byte
         PSHS X,A,CC Save registers
         LBSR DSKSTART Start and select drive
         BCS EXIT.ERR Exit if error
REWRITE  LDX 2,S Get LSN off stack
         LBSR SEEK Position head at sector
         BCS RETRY.WR Try again if seek error
         BSR WRITE2 Write the sector
         BCS RETRY.WR Try again if write error
         TST PD.VFY,Y Check verify flag
         BNE EXIT.NER Exit without verify if off
         BSR VERIFY Verify sector just written
         BCC EXIT.NER Exit if no error
RETRY.WR LDA 1,S Get retry control byte
         LSRA Indicate another try
         STA 1,S Put updated byte back
         BEQ EXIT.ERR If zero, no more chances
         BCC REWRITE If bit 0 was 0, don't home
         BSR HOME Home and start all over
         BCC REWRITE If it homed OK, try again
EXIT.ERR PULS CC Restore interrupt masks
         COMA Set carry for error
         BRA CCDEXIT Finish exit
*
EXIT.NER PULS CC Restore interrupt masks
         CLRB Clear carry -- no error
CCDEXIT  LDA #8 Spindle motor control bit
         STA >DPORT Deselect disk drive
         PULS A,X,PC Pull and return
*
ERR.SECT COMB Set carry flag for error
         LDB #E$SECT Set error code
         RTS
*
READ2    PSHS X,A,CC CC is on top of stack
         LBSR DSKSTART Start drives and test
         BCS EXIT.ERR Abort if not ready
REREAD   LDX 2,S Recover LSN from stack
         LBSR SEEK Position head at sector
         BCS RETRY.RD Try again if seek error
         BSR READ3 Read the sector
         BCC EXIT.NER Read OK, return data
RETRY.RD LDA 1,S Get retry control byte
         LSRA Indicate another try
         STA 1,S Put updated byte back
         BEQ EXIT.ERR If it was all 0, quit
         BCC REREAD If bit 0 was 0, don't home
         BSR HOME Home and start all over
         BCC REREAD If it won't home, quit now
         BRA EXIT.ERR Exit with an error
*
WRITE2   LDA #$A2 `Write sector' command
         BSR RWCMDX Execute command
WAITWDRQ BITA >STATREG Wait until controller is
         BEQ WAITWDRQ   ready to transfer data
*
WRTLOOP  LDA ,X+ Get byte from data buffer
         STA >DATAREG Put it in data register
         STB >DPORT Activate DRQ halt function
         BRA WRTLOOP Loop until interrupted
*
VERIFY   LDA #$82 `Read sector' command
         BSR RWCMDX Execute command
WAITVDRQ BITA >STATREG Wait until controller is
         BEQ WAITVDRQ   ready to transfer data
*
VFYLOOP  LDA >DATAREG Get read data byte
         STB >DPORT Activate DRQ halt function
         CMPA ,X+ Compare to source data
         BEQ VFYLOOP Loop until interrupt if equal
*
         ANDB #$7F Mask off DRQ halt bit
         STB >DPORT Disable DRQ halt function
         LBSR KILLCOMD Abort read command
ERR.WRT  COMB Set carry flag
         LDB #E$WRITE Set error code
         RTS
*
SS.HOME  PSHS X,A,CC Set up stack for exit
         BSR HOME Home drive
         BRA SS.EXIT Skip to empty-stack exit
SS.EXIT4 LEAS 2,S Exit w/4 bytes on stack
SS.EXIT2 LEAS 2,S Exit w/2 bytes on stack
SS.EXIT  BCS EXIT.ERR Exit with error
         BRA EXIT.NER Exit with no error
*
HOME     LBSR DSKSTART Start and select drive
         BCS RETURN2 Return if error
         LDX DRV.ACT,U Point to active drive's table
         CLR V.TRAK,X Set track number to zero
         LDD #$43C Home, verify, allow 3 seconds
         LBSR STEPEX Execute stepping command
RETURN2  RTS
*
SETSTA   LDX PD.RGS,Y Point to caller's stack
         LDB R$B,X Get stacked B register
         CMPB #SS.RESET `Home' call
         BEQ SS.HOME Execute Home sequence
         CMPB #SS.WTRK `Write track' call, used by
         BEQ WRT.TRAK   the Format utility
         COMB If not one of those, it's an
         LDB #E$UNKSVC   illegal setsta call
         RTS
*
READ3    LDA #$82 Read sector command
         BSR RWCMDX Set up for sector read
WAITRDRQ BITA >STATREG Wait for controller to find
         BEQ WAITRDRQ   sector and start reading
*
READLOOP LDA >DATAREG Get data from controller
         STA ,X+ Store in sector buffer
         STB >DPORT Activate DRQ halt function
         BRA READLOOP Loop until interrupted
*
RWCMDX   LDX PD.BUF,Y Point to sector buffer
         LDB DPRT.IMG,U Do a side verify using the
         BITB #$40   DPORT image byte as a side
         BEQ WTKCMDX   select indicator
         ORA #8 Compare for side 1
WTKCMDX  STA >COMDREG Issue command to controller
         LDB #$A8 Set up DRQ halt function
         ORB DPRT.IMG,U OR in select bits
         LDA #2 DRQ bit in status register
         RTS
*
* Write an entire track -- used by Format
*
WRT.TRAK PSHS X,A,CC Set up stack for exit
         LDA R$U+1,X Get track number
         LDB R$Y+1,X Get side select bit
         LDX R$X,X Get track buffer address
         PSHS X,D Save 'em
         LBSR DSKSTART Start and select drive
         BCS SS.EXIT4 Exit if error
         PULS D Get track number and side
         LDX DRV.ACT,U Get drive table address
         BSR SID.PCMP Get drive ready to go
         TST Q.SEEK,U Different drive/track?
         BNE WRT.TRK2 If not, no need to seek
         LDD #$103C Seek, allow 3 seconds
         LBSR STEPEX Execute stepping command
         BCS SS.EXIT2 Exit if error
WRT.TRK2 PULS X Retrieve track buffer address
         LDA #$F0 `Write track' command
         BSR WTKCMDX Execute write track command
         LBSR WAITWDRQ Just like a Write Sector
         LBRA SS.EXIT Return to caller
*
SID.PCMP LSRB Bit 0 of B is set for
         BCC SIDE.ONE   side 2 of disk
         LDB DPRT.IMG,U Get drive control image byte
         ORB #$40 Side 2 select bit
         STB DPRT.IMG,U Activate side 2 select
SIDE.ONE CMPA PD.CYL+1,Y If track number exceeds #
         LBHI ERR.SECT   of tracks, return error
SD.PCMP2 LDB PD.DNS,Y Check track density of drive
         LSRB Shift bit 1 (TPI bit) into
         LSRB   carry flag (1 = 96 TPI)
         LDB #20 Precomp starts at track 21
         BCC FORTYTKS   on 48 TPI drives, track 41
         LSLB   on 96 TPI drives
FORTYTKS PSHS B Put B where it can be used
         CMPA ,S+ Does it need precomp?
         BLS NOPRECMP No, skip next step
         LDB DPRT.IMG,U Get drive control image byte
         ORB #$10 Write precompensation bit
         STB DPRT.IMG,U Activate precompensation
NOPRECMP LDB V.TRAK,X Get current track number
         STB >TRAKREG Update disk controller
         CMPA V.TRAK,X Same track as last access?
         BEQ SAMETRAK If so, leave flag set
         CLR Q.SEEK,U Clear same drive/track flag
SAMETRAK STA V.TRAK,X Update track number
         STA >DATAREG Set destination track
         LDB DPRT.IMG,U Get disk control byte
         STB >DPORT Update control port
         RTS
*
* Translate logical sector number (LSN) to physical side, track
*   and sector, activate write precompensation if necessary,
*   and execute seek command. If any error occurs, return error
*   number to calling routine.
*
SEEK     LDD PD.SCT,Y Get #sectors per track
         PSHS X,D Put LSN and sec/trk on stack
         LDD 2,S Get LSN off stack
         CLR 2,S Set up track counter
FINDTRAK INC 2,S Increment track counter
         SUBD ,S Subtract sectors in one track
         BPL FINDTRAK Loop if LSN still positive
         ADDD ,S++ Restore sector number
         INCB Sector numbers start at 1
         STB 1,S Save sector number
         PULS A Get track number
         DECA Compensate for extra count
         LDX DRV.ACT,U Get active table address
         LDB DD.FMT,X See if disk is double sided
         BITB #1 Test #sides bit
         BEQ SEEK2 If one-sided, skip next step
         LSRA Divide track number by 2
         ROLB Put remainder in B bit 0
SEEK2    BSR SID.PCMP Set up precomp and side sel
         PULS B Get sector number
         STB >SECTREG Set destination sector
         TST Q.SEEK,U Same drive/track?
         BNE COMDEXIT If so, no need to seek
         LDD #$143C Seek with verify, allow 3 sec
         BRA STEPEX Execute stepping command
*
* Execute command in A and wait for it to finish. If it runs
*   normally or aborts with an error it will exit through NMI;
*   if it takes an unreasonable amount of time this routine
*   will abort it and set the carry flag. If the command
*   involves head movement, use STEPEX to set step rate.
* On entry, A contains command code and B contains time limit
*   in 50-millisecond increments.
*
STEPEX   PSHS A Put raw command on stack
         LDA PD.STP,Y Get step rate code
         EORA #3 Convert to 1793's format
         ORA ,S+ Combine with raw command
COMDEX   STA >COMDREG Execute command in A
         CLRA Clear carry flag
         BSR WAIT50MS Wait while command runs
         BCC COMDEXIT Exit if no error
         CMPB #E$NOTRDY Test for the three valid
         BEQ KCEXIT   error codes for a Type 1
         CMPB #E$SEEK   disk controller command --
         BEQ KCEXIT   home, seek or force int-
         CMPB #E$CRC   errupt -- and return the
         BEQ KCEXIT   errors
COMDEXIT CLRB No error, clear carry
         RTS
*
WAIT50MS LDX #$15D8 Almost exactly 50 mSec delay
WAITIMER LEAX -1,X Wait specified time for disk
         BNE WAITIMER   controller to issue NMI
         DECB   signaling command completed
         BNE WAIT50MS   or aborted with error
KILLCOMD LDA #$D0 Force interrupt, NMI disabled
         STA >COMDREG Abort command in progress
ERR.NRDY LDB #E$NOTRDY Set error code
KCEXIT   COMA Set carry to flag error
         RTS
*
*
* Get selected drive ready to read or write. If spindle motors are
*   stopped, start them and wait until they're up to operating
*   speed. Check drive number and select drive if number is valid.
*   Monitor index pulses to ensure door is closed, disk inserted
*   and turning, etc. Return appropriate error code if any of
*   these conditions can't be met.
*
DSKSTART TST >D.DSKTMR Are drives already running?
         BNE SPINRDY If so, no need to wait
         CLR DRVS.RDY,U No drives are ready
         LDD #$80B Motor on, wait 550 mSec
         STA >DPORT Start spindle motors
         BSR WAIT50MS Wait for motors to start
SPINRDY  LDA PD.DRV,Y Get drive number
         CMPA V.NDRV,U Test for valid drive #
         BHS ERR.UNIT Return error if not
         LEAX TABL.ORG,U Compute address of active
         LDB #DRVMEM   drive's parameter table
         MUL   TABL.ORG + (D# * tablesize)
         LEAX D,X Add computed offset to origin
         LDA PD.DRV,Y Get drive number again
         LSLA Set corresponding drv select
         BNE NOTDRV0   bit -- 1 for D1, 2 for D2
         INCA Set bit 0 for drive 0
NOTDRV0  TFR A,B Copy select bit
         ORB #$28 Enable double density
         ORCC #INTMASKS Disable IRQ and FIRQ
         STB >DPORT Enable drive
         STB DPRT.IMG,U Set image byte
         CLR Q.SEEK,U Clear same drive/track flag
         CMPX DRV.ACT,U Is this the same drive?
         BNE NEWDRIVE If not, leave flag zeroed
         LDB #$FF Indicate successive accesses
         STB Q.SEEK,U   to the same drive.
NEWDRIVE STX DRV.ACT,U Store table address
         BITA DRVS.RDY,U Has this drive been ready
         BNE DRVRDY   since the motors started?
         PSHS A Save drive select bit
         LDD #$D405 Force int, allow 250 mSec
         BSR COMDEX Look for index pulse
         PSHS CC Save carry flag condition
         BSR KILLCOMD Clear index-pulse NMI state
         PULS CC,A Restore carry flag and A
         BCS RETURN3 Error if no index pulse
DRVRDY   ORA DRVS.RDY,U Set corresponding drive
         STA DRVS.RDY,U   ready flag
         LDA #DISKRUN Restart disk rundown timer
         STA >D.DSKTMR
         LDA >STATREG Clear interrupt condition
         CLRB Return no error
RETURN3  RTS
*
ERR.UNIT COMB Set carry flag
         LDB E$UNIT Set error code
         RTS
*
         ENDC

         emod
eom      equ   *
         end
