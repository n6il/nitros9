********************************************************************
* Merge - Copy and combine files to standard output
*
* $Id$
*
* Ed.    Comments                                       Who YY/MM/DD
* ------------------------------------------------------------------
*  4     Original Microware distribution version

         nam   Merge
         ttl   Copy and combine files to standard output

* Disassembled 02/04/03 23:06:27 by Disasm v1.6 (C) 1988 by RML

         ifp1
         use   os9defs
         endc
tylg     set   Prgrm+Objct   
atrv     set   ReEnt+rev
rev      set   $01
         mod   eom,name,tylg,atrv,start,size
u0000    rmb   1
u0001    rmb   2
u0003    rmb   2
u0005    rmb   2
u0007    rmb   2496
size     equ   .
name     equ   *
         fcs   /Merge/
         fcb   $04 
start    equ   *
         pshs  u
         stx   <u0001
         tfr   x,d
         subd  #$0107
         subd  ,s++
         std   <u0005
         leau  u0007,u
         stu   <u0003
L0024    ldx   <u0001
         bsr   L005C
         clrb  
         cmpa  #$0D
         beq   L0059
         lda   #$01
         os9   I$Open   
         bcs   L0059
         sta   <u0000
         stx   <u0001
L0038    lda   <u0000
         ldy   <u0005
         ldx   <u0003
         os9   I$Read   
         bcs   L004D
         lda   #$01
         os9   I$Write  
         bcc   L0038
         bra   L0059
L004D    cmpb  #$D3
         bne   L0058
         lda   <u0000
         os9   I$Close  
         bcc   L0024
L0058    coma  
L0059    os9   F$Exit   
L005C    lda   ,x+
         cmpa  #$20
         beq   L005C
         leax  -$01,x
         rts   
         emod
eom      equ   *
