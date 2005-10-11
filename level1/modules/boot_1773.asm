********************************************************************
* Boot - WD1773 Boot module
*
* $Id$
*
* Edt/Rev  YYYY/MM/DD  Modified by
* Comment
* ------------------------------------------------------------------
*   4      1985/??/??   
* Original Tandy distribution version.
*
*   6      1998/10/12  Boisy G. Pitre
* Obtained from L2 Upgrade archive, has 6ms step rate and disk timeout
* changes.
*
*   6r2    2003/05/18  Boisy G. Pitre
* Added '.' output for each sector for OS-9 L2 and NitrOS9 for
* Mark Marlette (a special request :).
*
*   6r3    2003/08/31  Robert Gault
* Put BLOB-stop code in place, changed orb #$30 to orb #$28
*
*   6r4    2004/02/17  Rodney Hamilton
* Minor optimizations, improvements in source comments
*
*   7      2005/10/10  Boisy G. Pitre
* Added fragmented bootfile support

         nam   Boot
         ttl   WD1773 Boot module

         IFP1
         use   defsfile
         ENDC

* FDC Control Register bits at $FF40
HALTENA  equ   %10000000
SIDESEL  equ   %01000000	DRVSEL3 if no DS drives
DDEN     equ   %00100000
READY    equ   %00010000	READY for Tandy WD1773-based controllers
MOTON    equ   %00001000
DRVSEL2  equ   %00000100
DRVSEL1  equ   %00000010
DRVSEL0  equ   %00000001

* Default Boot is from drive 0
BootDr   set DRVSEL0
         IFEQ  DNum-1
BootDr   set DRVSEL1		Alternate boot from drive 1
         ENDC
         IFEQ  DNum-2
BootDr   set DRVSEL2		Alternate boot from drive 2
         ENDC
         IFEQ  DNum-3
BootDr   set SIDESEL		Alternate boot from drive 3
         ENDC

* WD17x3 DPort offsets
CONTROL  equ   0
CMDREG   equ   8+0		write-only
STATREG  equ   CMDREG		read-only
TRACKREG equ   8+1
SECTREG  equ   8+2
DATAREG  equ   8+3

* Sector Size
SECTSIZE equ   256

* Step Rates:
*	$00  = 6ms
*	$01  = 12ms
*	$02  = 20ms
*	$03  = 30ms
STEP     set   $00

tylg     set   Systm+Objct
atrv     set   ReEnt+rev
rev      set   $00
edition  set   7

         mod   eom,name,tylg,atrv,start,size

* NOTE: these are U-stack offsets, not DP
seglist  rmb   2						pointer to segment list
blockloc rmb   2                       pointer to memory requested
blockimg rmb   2                       duplicate of the above
bootloc  rmb   3                       sector pointer; not byte pointer
bootsize rmb   2                       size in bytes
drvsel   rmb   1
currtrak rmb   1
ddtks    rmb   1		no. of sectors per track
dblsided rmb   1
side     rmb   1		side 2 flag
size     equ   .

name     fcs   /Boot/
         fcb   edition

start    orcc  #IntMasks  ensure IRQs are off (necessary?)
         leas  -size,s   
         tfr   s,u        get pointer to data area
         pshs  u          save pointer to data area
                         
* Device Specific Init
         lbsr  HWInit    
*         bcs   error2    
                         
* Request memory for LSN0
         ldd   #256       get sector/fd buffer
         os9   F$SRqMem   get it!
         bcs   error2    
         bsr   getpntr    restore U to point to our statics
                         
* Read LSN0
         clrb             MSB sector
         ldx   #0         LSW sector
         lbsr  HWRead     read LSN 0
         bcs   error      branch if error
                         
         ifgt  Level-1   
         lda   #'0        --- loaded in LSN0'
         jsr   <D.BtBug   ---
         endc            
                         
* Pull relevant values from LSN0
         lda   DD.TKS,x    number of tracks on this disk
         sta   ddtks,u 
         lda   DD.FMT,x    disk format byte
         sta   dblsided,u 
         lda   DD.BT,x    os9boot pointer
         sta   bootloc,u 
         ldd   DD.BT+1,x  LSW of 24 bit address
         std   bootloc+1,u
         ldd   DD.BSZ,x   os9boot size in bytes
         std   bootsize,u
         beq   FragBoot   if zero, do frag boot
* Old style boot -- make a fake FD segment
         leax  FD.SEG,x  
         addd  #$00FF		round up to next page
         exg   a,b
         std   FDSL.B,x   save file size
         lda   bootloc,u 
         sta   FDSL.A,x  
         ldd   bootloc+1,u
         std   FDSL.A+1,x save LSN of file (contiguous)
         clr   FDSL.S,x   make next segment entry 0
         clr   FDSL.S+1,x
         clr   FDSL.S+2,x
         ldd   bootsize,u
         bra   GrabBootMem
                         
Back2Krn ldx   blockimg,u pointer to start of os9boot in memory
         clrb             clear carry
         ldd   bootsize,u
error2   leas  2+size,s   reset the stack    same as PULS U
         rts              return to kernel
                         
* Error point - return allocated memory and then return to kernel
error                    
* Return memory allocated for sector buffers
         ldd   #256      
         ldu   blockloc,u
         os9   F$SRtMem  
         bra   error2    
                         
* Routine to save off alloced mem from F$SRqMem into blockloc,u and restore
* the statics pointer in U
getpntr  tfr   u,d        save pointer to requested memory
         ldu   2,s        recover pointer to data stack
         std   blockloc,u
ret      rts             
                         
* NEW! Fragmented boot support!
FragBoot ldb   bootloc,u  MSB fd sector location
         ldx   bootloc+1,u LSW fd sector location
         lbsr  HWRead     get fd sector
         ldd   FD.SIZ+2,x get file size (we skip first two bytes)
         std   bootsize,u
         leax  FD.SEG,x   point to segment table
                         
GrabBootMem                 
         ifgt  Level-1   
         os9   F$BtMem   
         else            
         os9   F$SRqMem  
         endc            
         bcs   error     
         bsr   getpntr   
         std   blockimg,u
                         
* Get os9boot into memory
BootLoop stx   seglist,u  update segment list
         ldb   FDSL.A,x   MSB sector location
BL2      ldx   FDSL.A+1,x LSW sector location
         bne   BL3       
         tstb            
         beq   Back2Krn  
BL3      lbsr  HWRead    
         inc   blockloc,u point to next input sector in mem
                         
         ifgt  Level-1   
         lda   #'.        Show .'
         jsr   <D.BtBug  
         endc            
                         
         ldx   seglist,u  get pointer to segment list
         dec   FDSL.B+1,x get segment size
         beq   NextSeg    if <=0, get next segment
                         
         ldd   FDSL.A+1,x update sector location by one to 24bit word
         addd  #1        
         std   FDSL.A+1,x
         ldb   FDSL.A,x  
         adcb  #0        
         stb   FDSL.A,x  
         bra   BL2       
                         
NextSeg  leax  FDSL.S,x   advance to next segment entry
         bra   BootLoop  
                         


************************************************************
************************************************************
*              Hardware-Specific Booter Area               *
************************************************************
************************************************************

* Device Specific Init
* HWInit - Initialize the device
HWInit
         ldy   Address,pcr				get hardware address
         lda   #%11010000		($D0) Force Interrupt (stops any command in progress)
         sta   CMDREG,y			write command to command register
         lbsr  Delay2			delay 54~
         lda   STATREG,y		clear status register
         lda   #$FF
         sta   currtrak,u		set current track to 255
         leax  >NMIRtn,pcr		point to NMI routine
         IFGT  Level-1
         stx   <D.NMI			save address
         ELSE
         stx   >D.XNMI+1		save address
         lda   #$7E
         sta   >D.XNMI
         ENDC
         lda   #MOTON+BootDr	turn on drive motor
         sta   CONTROL,y

* MOTOR ON spin-up delay loop (~307 mSec)
         IFGT  Level-1
         ldd   #50000
         ELSE
         ldd   #25000
         ENDC
         IFNE  H6309
         nop
         ENDC
L003A    nop
         nop
         IFNE  H6309
         nop
         nop
         nop
         ENDC
         subd  #$0001
         bne   L003A
		 rts


L00B7    lda   #DDEN+MOTON+BootDr	permit alternate drives
         sta   drvsel,u			save drive selection byte
         clr   currtrak,u		clear current track
         lda   #$05
         lbsr  L0170
         ldb   #0+STEP		RESTORE cmd
         lbra  L0195

*
* HWRead - Read a 256 byte sector from the device
*   Entry: Y = hardware address
*          B = bits 23-16 of LSN
*          X = bits 15-0  of LSN
* 		   blockloc,u = ptr to 256 byte sector
*   Exit:  X = ptr to data (i.e. ptr in blockloc,u)
*
* Read a sector from the 1773
* Entry: B,X = LSN to read
HWRead   lda   #$91
         bsr   L00DF		else branch subroutine
         bcs   L00D6		branch if error
         ldx   blockloc,u	get buffer pointer in X for caller
         clrb
L00D6    rts

L00D7    bcc   L00DF
         pshs  x,b,a
         bsr   L00B7
         puls  x,b,a
L00DF    pshs  x,b,a		save LSN, command
         bsr   L00EA
         puls  x,b,a		restore LSN, command
         bcc   L00D6		branch if OK
         lsra
         bne   L00D7
L00EA    bsr   L013C
         bcs   L00D6		if error, return to caller
         ldx   blockloc,u	get address of buffer to fill
         orcc  #IntMasks	mask interrupts
         pshs  x			save X
         ldx   #$FFFF
         ldb   #%10000000	($80) READ SECTOR command
         stb   CMDREG,y		write to command register
         ldb   drvsel,u		(DDEN+MOTORON+BootDr)
* NOTE: The 1773 FDC multiplexes the write precomp enable and ready
* signals on the ENP/RDY pin, so the READY bit must always be ON for
* read and seek commands.  (from the FD502 FDC Service Manual)
         orb   #DDEN+READY	set DDEN+READY bits ($30)
         tst   side,u		are we on side 2?
         beq   L0107
         orb   #SIDESEL		set side 2 bit
L0107    stb   CONTROL,y
         lbsr  Delay2		delay 54~
         orb   #HALTENA		HALT enable ($80)
*         lda   #%00000010	RESTORE cmd ($02)
*L0111    bita  >DPort+STATREG
*         bne   L0123
*         leay  -$01,y
*         bne   L0111
*         lda   drvsel,u
*         sta   >DPort+CONTROL
*         puls  y
*         bra   L0138
         stb   CONTROL,y
         nop
         nop
*         bra   L0123

         ldx   ,s			get X saved earlier
* Sector READ Loop
L0123    lda   DATAREG,y	read from WD DATA register
         sta   ,x+
*         stb   >DPort+CONTROL
         nop
         bra   L0123
* RVH NOTE: This ONLY works for double density boot disks!  The Tandy
* controllers internally gate HALT enable with the DDEN bit, which
* means that reading a single-density boot disk will not generate the
* NMI signal needed to exit the read loop!  Single-density disks must
* use a polled I/O loop instead.

NMIRtn   leas  R$Size,s		adjust stack
         puls  x
         ldb   STATREG,y	read WD STATUS register
         bitb  #$9C			any errors?
*         bitb  #$04		LOST DATA bit set?
         beq   RetOK		branch if not
*         beq   ChkErr		branch if not
L0138    comb				else we will return error
         ldb   #E$Read
RetOK    rts

L013C    lda   #MOTON+BootDr	permit alternate drives
         sta   drvsel,u		save byte to static mem
         clr   side,u		start on side 1
         tfr   x,d
         cmpd  #$0000
         beq   L016C
         clr   ,-s			clear space on stack
         tst   dblsided,u	double sided disk?
         beq   L0162		branch if not
         bra   L0158
* Double-sided code
L0152    com   side,u		flag side 2
         bne   L0158
         inc   ,s
L0158    subb  ddtks,u		
         sbca  #$00
         bcc   L0152
         bra   L0168
L0160    inc   ,s
L0162    subb  ddtks,u
         sbca  #$00
         bcc   L0160
L0168    addb  #18			add sectors per track
         puls  a			get current track indicator off of stack
L016C    incb
         stb   SECTREG,y	save in sector register
L0170    ldb   currtrak,u	get current track in B
         stb   TRACKREG,y	save in track register
         cmpa  currtrak,u	same as A?
         beq   L018D		branch if so
         sta   currtrak,u
         sta   DATAREG,y
         ldb   #$10+STEP	SEEK command
         bsr   L0195		send command to controller
         pshs  x
* Seek Delay
         ldx   #$222E		delay ~39 mSec (78mS L1)
L0187    leax  -$01,x
         bne   L0187
         puls  x
L018D    clrb
         rts

*ChkErr   bitb  #$98		evaluate WD status (READY, RNF, CRC err)
*         bne   L0138
*         clrb
*         rts

L0195    bsr   L01A8		issue FDC cmd, wait 54~
L0197    ldb   STATREG,y
         bitb  #$01		still BUSY?
         bne   L0197		loop until command completes
         rts

* Entry: B = command byte
L019F    lda   drvsel,u
         sta   CONTROL,y
         stb   CMDREG,y
         rts

* issue command and wait 54 clocks
* Controller requires a min delay of 14uS (DD) or 28uS (SD)
* following a command write before status register is valid
L01A8 
         bsr   L019F
* Delay branches
* 54 clock delay including bsr (=30uS/L2,60us/L1)
Delay2  
         IFNE  H6309
         nop
         nop
         ENDC
         lbsr  Delay3
Delay3 
         IFNE  H6309
         nop
         nop
         ENDC
         lbsr  Delay4
Delay4 
         IFNE  H6309
         nop
         ENDC
         rts

         IFGT  Level-1
* Filler to get $1D0
Filler   fill  $39,$1D0-3-2-1-*
         ENDC

Address  fdb   DPort
WhichDrv fcb   0

         emod
eom      equ   *
         end
