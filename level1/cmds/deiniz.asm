********************************************************************
* DeIniz - Deinitialize a device
*
* $Id$
*
* Ed.    Comments                                       Who YY/MM/DD
* ------------------------------------------------------------------
* 3      From OS-9 Level Two Vr. 2.00.01

         nam   DeIniz
         ttl   Deinitialize a device

* Disassembled 98/09/10 22:57:23 by Disasm v1.6 (C) 1988 by RML

         ifp1
         use   defsfile
         endc

tylg     set   Prgrm+Objct   
atrv     set   ReEnt+rev
rev      set   $01
edition  set   3

         mod   eom,name,tylg,atrv,start,size
u0000    rmb   2
u0002    rmb   330
size     equ   .

name     fcs   /DeIniz/
         fcb   edition

start    lda   ,x
         cmpa  #C$CR
         beq   L0020
         bsr   L0041
         bra   L0030
L001E    bsr   L0041
L0020    bsr   L0034
         bcs   L002C
         lda   ,x
         cmpa  #C$CR
         bne   L001E
         ldb   #E$EOF
L002C    cmpb  #E$EOF
         bne   L0030
L0030    clrb  
         os9   F$Exit   
L0034    clra  
         leax  u0002,u
         ldy   #80
         os9   I$ReadLn 
         bcc   L0040
L0040    rts   
L0041    lda   #C$SPAC
L0043    cmpa  ,x+
         beq   L0043
         leax  -1,x
         stx   <u0000
         lda   #PDELIM
         cmpa  ,x
         bne   L0053
         leax  1,x
L0053    clra  
         os9   I$Attach 
         bcs   L0070
         os9   I$Detach 
         bcs   L0070
         os9   I$Detach 
         bcs   L0070
         lda   ,x+
         cmpa  #C$COMA
         beq   L0041
         lda   ,-x
         cmpa  #C$CR
         bne   L0041
         rts   
L0070    pshs  b
         lda   #$02
         ldx   <u0000
         ldy   #80
         os9   I$WritLn 
         puls  b
         os9   F$PErr   
         rts   

         emod
eom      equ   *
         end
