********************************************************************
* oscode - OS-9 Level One V2 bootstrap code
*
* $Id$
*
* Ed.    Comments                                       Who YY/MM/DD
* ------------------------------------------------------------------
*        From Tandy OS-9 Level One VR 02.00.00

         ifp1
         use   defsfile
         endc

* Initial code executed upon booting up to OS-9
         org   $2600

Start    fcc   /OS/
         bra   L2620

         fdb   $1204
BootMsg  fcc   /OSy/
         fcb   $60
         fcc   /BOOT/

L2620    clr   PIA.U4+3
         sta   $FFDF                   turn off ROM
* locate Boot Text Screen at $8000
         ldb   #$06
         ldx   #$FFC6
L262B    sta   ,x++
         decb
         bne   L262B
         sta   1,x

* clear screen at $8000
         ldx   #$8000
         ldy   #$0200
         lda   #$60
L263B    sta   ,x+
         leay  -1,y
         bne   L263B

* Copy "OS9 BOOT" to screen area
         ldx   #$810C
         leay  <BootMsg,pcr
         ldb   #$08
L2649    lda   ,y+
         sta   ,x+
         decb
         bne   L2649

         ldd   #$1212
         cmpd  <$0078
         beq   L266E
         leau  >Start,pcr
         ldx   #$0F80
         ldy   #$EF00
L2663    lda   ,u+
         sta   ,y+
         leax  -1,x
         bne   L2663
         jmp   >$EF5C
L266E    leax  <eoc,pcr
         ldd   $09,x
         jmp   d,x

eoc      equ   *
         end

