********************************************************************
* go51 - The 51 column by 24 line video display
*
* $Id$
*
* Ed.    Comments                                       Who YY/MM/DD
* ------------------------------------------------------------------
*   1    From Dragon OS-9 Level One VR 01.02.00

         nam   go51
         ttl   The 51 column by 24 line video display

* Disassembled 02/07/06 21:10:42 by Disasm v1.6 (C) 1988 by RML

         ifp1
         use   defsfile
         endc

tylg     set   Prgrm+Objct   
atrv     set   ReEnt+rev
rev      set   $01
edition  set   1

         mod   eom,name,tylg,atrv,start,size

u0000    rmb   2
u0002    rmb   2
u0004    rmb   2
OptBuf   rmb   32
size     equ   .

name     fcs   /go51/
         fcb   edition

IOMod    fcs   /KBVDIO/
Driver   fcs   /drvr51/
Desc     fcs   /term/

start    leax  >IOMod,pcr
         lbsr  DoLink
         lbcs  Bye
         stx   ,u
         lbsr  DoUnlink
         leax  >Driver,pcr
         lbsr  DoLink
         lbcs  Bye
         stx   u0002,u
         ldd   $02,x
         std   u0004,u
         pshs  u,cc
         orcc  #IntMasks
         ldx   >D.AltIRQ
         stx   >$0032
         ldy   ,u
         ldx   u0004,u
         ldu   u0002,u
L0054    lda   ,u+
         sta   ,y+
         leax  -$01,x
         bne   L0054
         ldx   #$FF00
         lda   $01,x
         ora   #$30
         anda  #$F7
         sta   $01,x
         lda   $03,x
         anda  #$F6
         ora   #$30
         sta   $03,x
         ldx   #$FF20
         lda   $03,x
         ora   #$38
         sta   $03,x
         puls  u,cc
         ldx   u0002,u
         lbsr  DoUnlink
         ldx   ,u
         ldd   $04,x
         leax  d,x
         leay  >IOMod,pcr
         ldb   #$06
L008B    lda   ,y+
         sta   ,x+
         decb  
         bne   L008B
         lda   #$01
         ldb   #SS.Opt
         leax  OptBuf,u
         os9   I$GetStt 
         bcs   Bye
         clr   (PD.UPC-PD.OPT),x
         lda   #24
         sta   (PD.PAG-PD.OPT),x
         lda   #$01
         ldb   #SS.Opt
         os9   I$SetStt 
         bcs   Bye
         leax  >Desc,pcr
         lda   #Devic+Objct
         pshs  u
         os9   F$Link   
         tfr   u,x
         puls  u
         bcs   Bye
         clr   <$13,x
         lda   #$18
         sta   <$1A,x
         bsr   DoUnlink
         clrb  
Bye      os9   F$Exit   

DoLink   pshs  u
         lda   #Drivr+Objct
         os9   F$Link   
         tfr   u,x
         puls  pc,u

DoUnlink pshs  u
         tfr   x,u
         os9   F$UnLink 
         puls  pc,u

         emod
eom      equ   *
         end
