         nam   pause
         ttl   program module       

* Disassembled 2010/01/24 10:24:12 by Disasm v1.5 (C) 1988 by RML

         ifp1
         use   /dd/defs/defsfile
         endc
tylg     set   Prgrm+Objct   
atrv     set   ReEnt+rev
rev      set   $01
         mod   eom,name,tylg,atrv,start,size
u0000    rmb   1
u0001    rmb   1
u0002    rmb   402
size     equ   .
name     equ   *
         fcs   /pause/
L0012    fcb   $0A 
         fcb   $0D 
start    equ   *
L0014    lda   ,x+
         cmpa  #$22
         beq   L0028
         cmpa  #$0D
         bne   L0014
         leax  >L0065,pcr
         ldy   #$001C
         bra   L0041
L0028    clr   u0001,u
         stx   u0002,u
L002C    lda   ,x+
         cmpa  #$22
         beq   L003A
         cmpa  #$0D
         beq   L003A
         inc   u0001,u
         bra   L002C
L003A    ldb   u0001,u
         clra  
         tfr   d,y
         ldx   u0002,u
L0041    lda   #$01
         os9   I$Write  
         bcs   L0062
         clra  
         ldy   #$0001
         leax  ,u
         os9   I$Read   
         bcs   L0062
         lda   #$01
         leax  >L0012,pcr
         ldy   #$0002
         os9   I$WritLn 
         clrb  
L0062    os9   F$Exit   
L0065    negb  
         aim   #$65,>$7373
         bra   L00CD
         jmp   -$07,s
         bra   L00DB
         eim   #$79,$00,y
         lsr   >$6F20
         com   $0F,s
         jmp   -$0C,s
         rol   $0E,s
         eim   #$65,>$2E2E
         bgt   L008F
         emod
eom      equ   *
         end
