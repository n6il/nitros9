         nam   BBS.list
         ttl   program module       

* Disassembled 2010/01/24 10:32:36 by Disasm v1.5 (C) 1988 by RML

         ifp1
         use   /dd/defs/defsfile
         endc
tylg     set   Prgrm+Objct   
atrv     set   ReEnt+rev
rev      set   $01
         mod   eom,name,tylg,atrv,start,size
u0000    rmb   1
u0001    rmb   600
size     equ   .
name     equ   *
         fcs   /BBS.list/
start    equ   *
         lda   #$01
         os9   I$Open   
         lbcs  L004A
         sta   ,u
L0020    lda   ,u
         leax  u0001,u
         ldy   #$00C8
         os9   I$ReadLn 
         bcs   L0049
         lda   #$01
         os9   I$WritLn 
         clra  
         ldb   #$01
         os9   I$GetStt 
         bcs   L0020
         ldy   #$0001
         leax  u0001,u
         os9   I$Read   
         lda   ,x
         cmpa  #$20
         bne   L0020
L0049    clrb  
L004A    os9   F$Exit   
         emod
eom      equ   *
         end
