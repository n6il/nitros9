********************************************************************
* oscode - OS-9 Level One V2 bootstrap code
*
* $Id$
*
* Ed.    Comments                                       Who YY/MM/DD
* ------------------------------------------------------------------
*        From Tandy OS-9 Level One VR 02.00.00
*        Also put in conditionals for the Dragon 64

         ifp1
         use   defsfile
         endc

ScrnLoc  equ   $8000
OS9Start equ   $EF00
OS9Size  equ   $0F80

* Initial code executed upon booting up to OS-9

Start    fcc   /OS/
         bra   L2620

         fdb   $1204
BootMsg  fcc   /OS/
         fcb   $79
         fcb   $60
	 fcb   $72
         fcb   $6E
	 fcb   $70
	 fcb   $71
*        fcc   /BOOT/
BootMLen equ   *-BootMsg

L2620    clr   PIA.U4+3

         ifne  Dragon64
         clr   PIA.U4+1			added for Dragon, works on CoCo
         endc

         sta   $FFDF                   turn off ROM
* locate Boot Text Screen at $8000
         ldb   #$06
         ldx   #$FFC6
L262B    sta   ,x++
         decb
         bne   L262B
         sta   1,x

* Clear VDG screen
         ldx   #ScrnLoc
         ldy   #512
         lda   #$60
L263B    sta   ,x+
         leay  -1,y
         bne   L263B

* Copy "OS9 BOOT" to screen area
         ldx   #ScrnLoc+$10C
         leay  <BootMsg,pcr
         ldb   #BootMLen
L2649    lda   ,y+
         sta   ,x+
         decb
         bne   L2649

         ifne  Dragon64
         tst   <$72
         else
         ldd   #$1212
         cmpd  <$0078
         endc

         beq   L266E
         leau  >Start,pcr
         ldx   #OS9Size
         ldy   #OS9Start
L2663    lda   ,u+
         sta   ,y+
         leax  -1,x
         bne   L2663
         jmp   >OS9Start+L266E
L266E    leax  <eoc,pcr
         ldd   $09,x
         jmp   d,x

eoc      equ   *
         end

