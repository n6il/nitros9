********************************************************************
* Tee - Split output to multiple devices
*
* $Id$
*
* Ed.    Comments                                       Who YY/MM/DD
* ------------------------------------------------------------------
* 2      Original Tandy distribution version

         nam   Tee
         ttl   Split output to multiple devices

* Disassembled 98/09/14 23:50:52 by Disasm v1.6 (C) 1988 by RML

         ifp1
         use   defsfile
         endc

tylg     set   Prgrm+Objct   
atrv     set   ReEnt+rev
rev      set   $01
edition  set   2

         mod   eom,name,tylg,atrv,start,size

u0000    rmb   1
u0001    rmb   13
u000E    rmb   1
u000F    rmb   706
size     equ   .

name     fcs   /Tee/
         fcb   edition

start    clrb  
         clr   u000E,u
         cmpy  #$0000
         lbeq  L0076
         leay  u0001,u
* Kill any spaces or commas
L001E    lda   ,x+
         cmpa  #C$SPAC
         beq   L001E
         cmpa  #C$COMA
         beq   L001E
         cmpa  #C$CR
         lbeq  L0042
         leax  -$01,x
         lda   #WRITE.
         ldb   #PREAD.+UPDAT.
         os9   I$Create 
         bcs   L0077
         ldb   u000E,u
         sta   b,y
         incb  
         stb   u000E,u
         bra   L001E
L0042    stb   u000E,u
L0044    clra  
         leax  u000F,u
         ldy   #256
         os9   I$ReadLn 
         bcc   L0057
         cmpb  #E$EOF
         beq   L0076
         coma  
         bra   L0077
L0057    inca  
         os9   I$WritLn 
         tst   u000E,u
         beq   L0044
         clrb  
L0060    leay  u0001,u
         lda   b,y
         leax  u000F,u
         ldy   #256
         os9   I$WritLn 
         bcs   L0077
         incb  
         cmpb  u000E,u
         bne   L0060
         bra   L0044
L0076    clrb  
L0077    os9   F$Exit   

         emod
eom      equ   *
         end
