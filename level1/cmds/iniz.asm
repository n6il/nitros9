********************************************************************
* Iniz - Initialize a device
*
* $Id$
*
* Ed.    Comments                                       Who YY/MM/DD
* ------------------------------------------------------------------
* 2      Original Tandy/Microware version               BGP 02/07/05

         nam   Iniz
         ttl   Initialize a device

* Disassembled 02/07/05 21:52:55 by Disasm v1.6 (C) 1988 by RML

         ifp1
         use   defsfile
         endc

tylg     set   Prgrm+Objct   
atrv     set   ReEnt+rev
rev      set   $01

         mod   eom,name,tylg,atrv,start,size
u0000    rmb   2
u0002    rmb   330
size     equ   .

name     fcs   /Iniz/
         fcb   $02 

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
L003F    stx   <u0000
         clra  
         os9   I$Attach 
         bcs   L0054
         lda   ,x+
         cmpa  #',
         beq   L003F
         lda   ,-x
         cmpa  #C$CR
         bne   L003F
         rts   
L0054    pshs  b
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

