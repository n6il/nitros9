********************************************************************
* oscode - OS-9 Level One V2 bootstrap code
*
* $Id$
*
* Ed.    Comments                                       Who YY/MM/DD
* ------------------------------------------------------------------
*        From Tandy OS-9 Level One VR 02.00.00
*        Also put in conditionals for the Dragon 64

         IFP1
         use   defsfile
         ENDC

ScrnLoc  equ   $8000

* Initial code executed upon booting up to OS-9

Start    fcc   /OS/
         bra   L2620

         fdb   $1204
BootMsg  fcc   /OSy/
         fcb   $60
         fcc   /BOOT/
BootMLen equ   *-BootMsg

L2620    clr   PIA0Base+3

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

         IFNE  Dragon64
         tst   <$72
         ELSE
         ldd   #$1212
         cmpd  <$0078
         ENDC

         beq   L266E
         leau  >Start,pcr
         ldx   #$FE80-Bt.Start
         ldy   #Bt.Start
L2663    lda   ,u+
         sta   ,y+
         leax  -1,x
         bne   L2663
         jmp   >Bt.Start+L266E
L266E    leax  <eoc,pcr
         ldd   $09,x
         jmp   d,x

eoc      equ   *
         end

