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
rev      set   $04
edition  set   6

         mod   eom,name,tylg,atrv,start,size

* NOTE: these are U-stack offsets, not DP
drvsel   rmb   1
buffptr  rmb   2
currtrak rmb   1
*ddfmt    rmb   1
ddtks    rmb   1		no. of sectors per track
*ddtot    rmb   1
dblsided rmb   1
side     rmb   1		side 2 flag
size     equ   .

name     fcs   /Boot/
         fcb   edition

start    clra			clear A
         ldb   #size		get our 'stack' size
MakeStak pshs  a		save 0 on stack
         decb			and continue...
         bne   MakeStak		until we've created our stack

         tfr   s,u		put 'stack statics' in U
*         ldx   #DPort
         lda   #%11010000	($D0) Force Interrupt (stops any command in progress)
         sta   >DPort+CMDREG	write command to command register
*         sta   CMDREG,x		write command to command register
         lbsr  Delay2		delay 54~
         lda   >DPort+STATREG	clear status register
*         lda   STATREG,x	read status register
         lda   #$FF
         sta   currtrak,u	set current track to 255
         leax  >NMIRtn,pcr	point to NMI routine
         IFGT  Level-1
         stx   <D.NMI		save address
         ELSE
         stx   >D.XNMI+1	save address
         lda   #$7E
         sta   >D.XNMI
         ENDC
         lda   #MOTON+BootDr	turn on drive motor
         sta   >DPort+CONTROL

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

* search for memory to use as a sector buffer
         pshs  u,y,x,b,a	save regs
         ldd   #SECTSIZE	get sector size in D
         os9   F$SRqMem		request that much memory
         bcs   L00AA		branch if there is an error
         tfr   u,d		move pointer to D temporarily
         ldu   $06,s		restore U (saved earlier)
         std   buffptr,u	save alloced mem pointer in statics
         clrb

* go get LSN0
         ldx   #$0000		we want LSN0
         bsr   ReadSect		go get it
         bcs   L00AA		branch if error

* From LSN0, we get various pieces of info.
*         ldd   DD.TOT+1,y
*         std   ddtot,u
         lda   <DD.FMT,y	get format byte of LSN0
*         sta   ddfmt,u		save it for ???
         anda  #FMT.SIDE	keep side bit
         sta   dblsided,u	and save it
         lda   DD.TKS,y		get sectors per track
         sta   ddtks,u		and save
         ldd   <DD.BSZ,y	get bootfile size
         std   ,s		save on stack
         ldx   <DD.BT+1,y	get start sector of bootfile
         pshs  x		push on the stack
         ldd   #SECTSIZE	load D with sector size
         ldu   buffptr,u	and point to the buffer pointer
         os9   F$SRtMem		return the memory
         ldd   $02,s		get the bootfile size
         IFGT  Level-1
         os9   F$BtMem
         ELSE
         os9   F$SRqMem		get the memory from the system
         ENDC
         puls  x		pull bootfile start sector off stack
         bcs   L00AA		branch if error
         stu   2,s		save pointer to bootfile mem on stack
         stu   8+buffptr,s	also save to buffptr,u
         ldu   6,s		reload original U
*         ldd   2,s		get pointer to bootfile mem
*         std   buffptr,u	and save pointer
         ldd   ,s		get bootfile size
         beq   L00A3		branch if zero

* this loop reads a sector at a time from the bootfile
* X = start sector
* D = bootfile size
L0091    pshs  x,b,a		save params
         clrb
         bsr   ReadSect		read sector
         bcs   L00A8		branch if error
         IFGT  Level-1
         lda   #'.		dump out a period for boot debugging
         jsr   <D.BtBug		do the debug stuff     
         ENDC
         puls  x,b,a		restore params
* RVH NOTE: the next 3 lines assume sector size=256=LSN size?
         inc   buffptr,u	point to next 256 bytes
         leax  1,x		move to next sector
         subd  #SECTSIZE	subtract sector bytes from size
         bhi   L0091		continue if more space
L00A3    clrb
         puls  b,a
         bra   L00AC
L00A8    leas  $04,s
L00AA    leas  $02,s
L00AC    puls  u,y,x
         leas  size,s		clean up stack
         clr   >DPort+CONTROL	shut off floppy disk
         rts

L00B7    lda   #DDEN+MOTON+BootDr	permit alternate drives
         sta   drvsel,u			save drive selection byte
         clr   currtrak,u		clear current track
         lda   #$05
         lbsr  L0170
         ldb   #0+STEP		RESTORE cmd
         lbra  L0195

* Read a sector from the 1773
* Entry: X = LSN to read
ReadSect lda   #$91
         cmpx  #$0000		LSN0?
         bne   L00DF		branch if not
         bsr   L00DF		else branch subroutine
         bcs   L00D6		branch if error
         ldy   buffptr,u	get buffer pointer in Y for caller
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
         ldx   buffptr,u	get address of buffer to fill
         orcc  #IntMasks	mask interrupts
         pshs  y		save Y
         ldy   #$FFFF
         ldb   #%10000000	($80) READ SECTOR command
         stb   >DPort+CMDREG	write to command register
         ldb   drvsel,u		(DDEN+MOTORON+BootDr)
* NOTE: The 1773 FDC multiplexes the write precomp enable and ready
* signals on the ENP/RDY pin, so the READY bit must always be ON for
* read and seek commands.  (from the FD502 FDC Service Manual)
         orb   #DDEN+READY	set DDEN+READY bits ($30)
         tst   side,u		are we on side 2?
         beq   L0107
         orb   #SIDESEL		set side 2 bit
L0107    stb   >DPort+CONTROL
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
         stb   >DPort+CONTROL
         nop
         nop
         bra   L0123

* Sector READ Loop
L0123    lda   >DPort+DATAREG	read from WD DATA register
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
         puls  y
         ldb   >DPort+STATREG	read WD STATUS register
         bitb  #$9C		any errors?
*         bitb  #$04		LOST DATA bit set?
         beq   RetOK		branch if not
*         beq   ChkErr		branch if not
L0138    comb			else we will return error
         ldb   #E$Read
RetOK    rts

L013C    lda   #MOTON+BootDr	permit alternate drives
         sta   drvsel,u		save byte to static mem
         clr   side,u		start on side 1
         tfr   x,d
         cmpd  #$0000
         beq   L016C
         clr   ,-s		clear space on stack
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
L0168    addb  #18		add sectors per track
         puls  a		get current track indicator off of stack
L016C    incb
         stb   >DPort+SECTREG	save in sector register
L0170    ldb   currtrak,u	get current track in B
         stb   >DPort+TRACKREG	save in track register
         cmpa  currtrak,u	same as A?
         beq   L018D		branch if so
         sta   currtrak,u
         sta   >DPort+DATAREG
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
L0197    ldb   >DPort+STATREG
         bitb  #$01		still BUSY?
         bne   L0197		loop until command completes
         rts

* Entry: B = command byte
L019F    lda   drvsel,u
         sta   >DPort+CONTROL
         stb   >DPort+CMDREG
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
Filler   fill  $39,$1D0-3-*
         ENDC

         emod
eom      equ   *
         end
