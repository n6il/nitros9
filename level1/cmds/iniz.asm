********************************************************************
* Iniz - Initialize a device
*
* $Id$
*
* Ed.    Comments                                       Who YY/MM/DD
* ------------------------------------------------------------------
*   3    From Tandy OS-9 Level Two VR 02.00.01

         nam   Iniz
         ttl   Initialize a device

* Disassembled 98/09/10 22:56:37 by Disasm v1.6 (C) 1988 by RML

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

name     fcs   /Iniz/
         fcb   edition

start    lda   ,x
         cmpa  #C$CR
         beq   L001E
         bsr   L003F
         bra   L002E
L001C    bsr   L003F
L001E    bsr   L0032
         bcs   L002A
         lda   ,x
         cmpa  #C$CR
         bne   L001C
         ldb   #E$EOF
L002A    cmpb  #E$EOF
         bne   L002E
L002E    clrb  
         os9   F$Exit   
L0032    clra  
         leax  u0002,u
         ldy   #80
         os9   I$ReadLn 
         bcc   L003E
L003E    rts   
L003F    lda   #C$SPAC
L0041    cmpa  ,x+
         beq   L0041
         leax  -$01,x
         stx   <u0000
         lda   #PDELIM
         cmpa  ,x
         bne   L0051
         leax  1,x
L0051    clra  
         os9   I$Attach 
         bcs   L0064
         lda   ,x+
         cmpa  #C$COMA
         beq   L003F
         lda   ,-x
         cmpa  #C$CR
         bne   L003F
         rts   
L0064    pshs  b
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
