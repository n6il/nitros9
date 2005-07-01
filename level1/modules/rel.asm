********************************************************************
* REL - Relocation routine
*
* $Id$
*
* Edt/Rev  YYYY/MM/DD  Modified by
* Comment
* ------------------------------------------------------------------
*   5r5    2003/07/31  Boisy G. Pitre
* Back ported NitrOS-9 REL to OS-9 Level Two.
*
*          2004/11/09  P.Harvey-Smith
* Added code to flip Dragon Alpha into text mode on boot.
* 
* 	   2005/07/01  Charles Youse
* Removed level 2 REL code and moved it into a separate source file.

         nam   REL
         ttl   Relocation routine

         IFP1
         use   defsfile
         ENDC

XX.Size  equ   6          number of bytes before REL actually starts
Offset   equ   Bt.Start+XX.Size
ScStart  equ   $8000      screen start in memory

tylg     set   Systm+Objct   
atrv     set   ReEnt+rev
rev      set   $05
edition  set   5

********************************************************************
* Any changes to the next 3 lines requires changes in XX.Size, above
         fcc   /OS/       sync bytes
         bra   Start+XX.Size  execution start
         fdb   $1205      filler bytes

Begin    mod   eom,name,tylg,atrv,start,size

         org   0
size     equ   .          REL doesn't require any memory

name     fcs   /REL/
         fcb   edition

start    clr   PIA0Base+3

         IFNE  Dragon64
         clr   PIA0Base+1		added for Dragon, works on CoCo
         ENDC

         sta   $FFDF                   turn off ROM
* locate Boot Text Screen at $8000
         ldb   #$06
         ldx   #$FFC6
L262B    sta   ,x++
         decb
         bne   L262B
         sta   1,x

	 IFNE	DragonAlpha
	 clr	$ffc0		* Reset to text mode if Dragon Alpha
	 clr	$ffc2
	 clr	$ffc4
	
	 lda	$ff22
	 anda	#$07
	 sta	$ff22
	 ENDC

* Clear VDG screen
         ldx   #ScStart
         ldy   #512
         lda   #$60
L263B    sta   ,x+
         leay  -1,y
         bne   L263B

* Copy "OS9 BOOT" to screen area
         ldx   #ScStart+$10A
         leay  <BootMsg,pcr
         ldb   #BootMLen
L2649    lda   ,y+
         sta   ,x+
         decb
         bne   L2649

         IFNE  Dragon64
         tst   <$72
         ELSE
         ldd   #$1212
         cmpd  <$0078
         ENDC

         beq   L266E
         leau  >Begin-XX.Size,pcr
         ldx   #Bt.Size
         ldy   #Bt.Start
L2663    lda   ,u+
         sta   ,y+
         leax  -1,x
         bne   L2663
         jmp   >Offset+L266E
L266E    leax  <eom,pcr
         ldd   M$Exec,x
         jmp   d,x

BootMsg  fcc   /NITROSy/
         fcb   $60
         fcc   /BOOT/
BootMLen equ   *-BootMsg

         emod
eom      equ   *
         end
