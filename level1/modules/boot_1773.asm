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

         nam   Boot
         ttl   WD1773 Boot module

         IFP1
         use   defsfile
         use   rbfdefs
         ENDC

* Sector Size
SECTSIZE equ   256


* Step Rate:
*      $00  = 6ms
*      $01  =
*      $02  =
*      $03  = 30ms
STEP     set   $00

*Drive value & number
*        $01 = 0
*        $02 = 1
*        $03 = 2
BootDr   set $01

tylg     set   Systm+Objct
atrv     set   ReEnt+rev
rev      set   $03
edition  set   6

         mod   eom,name,tylg,atrv,start,size

drvsel   rmb   1
buffptr  rmb   2
currtrak rmb   1
*ddfmt    rmb   1
ddtks    rmb   1		no. of sectors per track
*ddtot    rmb   1
dblsided rmb   1
side     rmb   1
size     equ   .

name     fcs   /Boot/
         fcb   edition

start    clra			clear A
         ldb   #size		get our 'stack' size
MakeStak pshs  a		save 0 on stack
         decb			and continue...
         bne   MakeStak		until we've created our stack

         tfr   s,u		put 'stack statics' in U
         ldx   #DPort+8
         lda   #$D0
         sta   ,x
         lbsr  Delay2		delay a bit
         lda   ,x
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
         lda   #$08+BootDr	permit alternate drives
         sta   >DPort

* delay loop
         IFGT  Level-1
         ldd   #$C350
         ELSE
         ldd   #$61A8
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
         lda   <DD.FMT,y		get format byte of LSN0
*         sta   ddfmt,u			save it for ???
         anda  #FMT.SIDE		keep side bit
         sta   dblsided,u		and save it
         lda   DD.TKS,y			get sectors per track
         sta   ddtks,u			and save
         ldd   <DD.BSZ,y		get bootfile size
         std   ,s			save on stack
         ldx   <DD.BT+1,y		get start sector of bootfile
         pshs  x			push on the stack
         ldd   #SECTSIZE		load D with sector size
         ldu   buffptr,u		and point to the buffer pointer
         os9   F$SRtMem			return the memory
         ldd   $02,s			get the bootfile size
         IFGT  Level-1
         os9   F$BtMem
         ELSE
         os9   F$SRqMem			get the memory from the system
         ENDC
         puls  x			pull bootfile start sector off stack
         bcs   L00AA			branch if error
         stu   $02,s			save pointer to bootfile mem on stack
         tfr   u,d			transfer to D for later store
         ldu   $06,s			restore original U
*         ldd   $02,s			get pointer to bootfile mem
         std   buffptr,u		and save pointer
         ldd   ,s			get bootfile size
         beq   L00A3			branch if zero

* this loop reads a sector at a time from the bootfile
* X = start sector
* D = bootfile size
L0091    pshs  x,b,a			save params
         clrb
         bsr   ReadSect			read sector
         bcs   L00A8			branch if error
         IFGT  Level-1
         lda   #'.			dump out a period for boot debugging
         jsr   <D.BtBug			do the debug stuff     
         ENDC
         puls  x,b,a			get params
         inc   buffptr,u		point to next 256 bytes
         leax  1,x			move to next sector
         subd  #SECTSIZE		subtract sector bytes from size
         bhi   L0091			continue if more space
L00A3    clrb
         puls  b,a
         bra   L00AC
L00A8    leas  $04,s
L00AA    leas  $02,s
L00AC    puls  u,y,x
         leas  size,s		clean up stack
         clr   >DPort		shut off floppy disk
         rts

L00B7    lda   #$28+BootDr    permit alternate drives
         sta   drvsel,u
         clr   currtrak,u
         lda   #$05
         lbsr  L0170
         ldb   #STEP
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
         puls  x,b,a		get LSN, command
         bcc   L00D6		branch if OK
         lsra
         bne   L00D7
L00EA    bsr   L013C
         bcs   L00D6		if error, return to caller
         ldx   buffptr,u	get address of buffer to fill
         orcc  #IntMasks	mask interrupts
         pshs  y		save Y
         ldy   #$FFFF
         ldb   #$80 
         stb   >DPort+8 
         ldb   drvsel,u
* Notes on the next line:
* The byte in question comes after telling the controller that it should
* read a sector. RegB is then loaded (ldb drvsel,u) which means it is set to $29
* (%00101001) or the default boot drive if sub L00B7 has been run. At this
* point an orb #$30 or orb #%00110000 means that write precomp and double
* density flags are or'd in. This does not make any sense at all for a
* read command. I suppose the command may not even be needed but $28 just
* ensures that motor on and double density are set.
*         orb   #$28		was $30 which RG thinks is an error
* 09/02/03: Futher investigation shows that the OS-9 Level One Booter will
* FAIL if orb #$28 is used.  It does not fail if orb #$30 is used. ????
         orb   #$30		was $30 which RG thinks is an error
         tst   side,u
         beq   L0107
         orb   #$40
L0107    stb   >DPort
         lbsr  Delay2
         orb   #$80
*         lda   #$02
*L0111    bita  >DPort+8
*         bne   L0123
*         leay  -$01,y
*         bne   L0111
*         lda   drvsel,u
*         sta   >DPort
*         puls  y
*         bra   L0138
         stb   >DPort
         nop
         nop
         bra   L0123
L0123    lda   >DPort+$0B
         sta   ,x+
*         stb   >DPort
         nop
         bra   L0123

NMIRtn   leas  R$Size,s		adjust stack
         puls  y
         ldb   >DPort+8
         bitb  #$04
         beq   L018F
L0138    comb
         ldb   #E$Read
         rts

L013C    lda   #$08+BootDr	permit alternate drives
         sta   drvsel,u
         clr   side,u		assume side 0
         tfr   x,d
         cmpd  #$0000
         beq   L016C
         clr   ,-s		clear space on stack
         tst   dblsided,u	disk double sided?
         beq   L0162		branch if not
         bra   L0158
* Double-sided code
L0152    com   side,u
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
         stb   >DPort+$0A
L0170    ldb   currtrak,u
         stb   >DPort+$09
         cmpa  currtrak,u
         beq   L018D
         sta   currtrak,u
         sta   >DPort+$0B
         ldb   #$10+STEP
         bsr   L0195
         pshs  x
         ldx   #$222E
L0187    leax  -$01,x
         bne   L0187
         puls  x
L018D    clrb
         rts
L018F    bitb  #$98
         bne   L0138
         clrb
         rts
L0195    bsr   Delay1
L0197    ldb   >DPort+8
         bitb  #$01
         bne   L0197
         rts
L019F    lda   drvsel,u
         sta   >DPort
         stb   >DPort+$08
         rts

* Delay branches
Delay1 
         IFNE  H6309
         nop
         ENDC
         bsr   L019F
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

