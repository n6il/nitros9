********************************************************************
* List - List a text file
*
* $Id$
*
* Ed.    Comments                                       Who YY/MM/DD
* ------------------------------------------------------------------
*   5    From Tandy OS-9 Level One VR 02.00.00

         nam   List
         ttl   List a text file

* Disassembled 98/09/10 23:16:25 by Disasm v1.6 (C) 1988 by RML

         ifp1
         use   defsfile
         endc

tylg     set   Prgrm+Objct   
atrv     set   ReEnt+rev
rev      set   $01
edition  set   5

         mod   eom,name,tylg,atrv,start,size
u0000    rmb   1
ParmPtr  rmb   2
u0003    rmb   650
size     equ   .

name     fcs   /List/
         fcb   edition

start    stx   <ParmPtr
         lda   #1
         os9   I$Open   
         bcs   L0049
         sta   <u0000
         stx   <ParmPtr
L001F    lda   <u0000
         leax  u0003,u
         ldy   #200
         os9   I$ReadLn 
         bcs   L0035
         lda   #1
         os9   I$WritLn 
         bcc   L001F
         bra   L0049
L0035    cmpb  #E$EOF
         bne   L0049
         lda   <u0000
         os9   I$Close  
         bcs   L0049
         ldx   <ParmPtr
         lda   ,x
         cmpa  #C$CR
         bne   start
         clrb  
L0049    os9   F$Exit   

         emod
eom      equ   *
         end
