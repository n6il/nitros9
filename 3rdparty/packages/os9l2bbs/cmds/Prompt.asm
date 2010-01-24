         nam   Prompt
         ttl   program module       

* Disassembled 2010/01/24 10:46:32 by Disasm v1.5 (C) 1988 by RML

         ifp1
         use   /dd/defs/defsfile
         endc
tylg     set   Prgrm+Objct   
atrv     set   ReEnt+rev
rev      set   $01
         mod   eom,name,tylg,atrv,start,size
u0000    rmb   2
u0002    rmb   2
u0004    rmb   2
u0006    rmb   2
u0008    rmb   600
size     equ   .
name     equ   *
         fcs   /Prompt/
start    equ   *
         stx   u0006,u
L0015    lda   ,x+
         cmpa  #$20
         beq   L0021
         cmpa  #$0D
         beq   L0021
         bra   L0015
L0021    lda   #$0D
         sta   -$01,x
         leay  u0008,u
         clr   ,u
L0029    lda   ,x+
         cmpa  #$22
         beq   L003A
         sta   ,y+
         inc   ,u
         cmpa  #$0D
         bne   L0029
         lbra  L007A
L003A    stx   u0002,u
         clrb  
L003D    lda   ,x+
         cmpa  #$0D
         beq   L004A
         cmpa  #$22
         beq   L004A
         incb  
         bra   L003D
L004A    stx   u0004,u
         ldx   u0002,u
         clra  
         pshs  y
         tfr   d,y
         lda   #$01
         os9   I$Write  
         ldx   ,s
         ldy   #$0050
         clra  
         os9   I$ReadLn 
         leay  -$01,y
         tfr   y,d
         puls  y
         leay  d,y
         addb  ,u
         stb   ,u
         ldx   u0004,u
L0070    lda   ,x+
         sta   ,y+
         inc   ,u
         cmpa  #$0D
         bne   L0070
L007A    ldx   u0006,u
         ldb   ,u
         clra  
         tfr   d,y
         lda   #$11
         ldb   #$03
         pshs  u
         leau  u0008,u
         os9   F$Fork   
         lbcs  L009A
         os9   F$Wait   
         lbcs  L009A
         puls  u
         clrb  
L009A    os9   F$Exit   
         emod
eom      equ   *
         end
