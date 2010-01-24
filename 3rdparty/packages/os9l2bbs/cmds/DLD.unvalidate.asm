         nam   DLD.unvalidate
         ttl   program module       

* Disassembled 2010/01/24 10:40:41 by Disasm v1.5 (C) 1988 by RML

         ifp1
         use   /dd/defs/defsfile
         endc
tylg     set   Prgrm+Objct   
atrv     set   ReEnt+rev
rev      set   $01
         mod   eom,name,tylg,atrv,start,size
u0000    rmb   2
u0002    rmb   2
u0004    rmb   82
u0056    rmb   27
u0071    rmb   31
u0090    rmb   465
size     equ   .
name     equ   *
         fcs   /DLD.unvalidate/
L001B    fcb   $44 D
         fcb   $4C L
         fcb   $44 D
         fcb   $2E .
         fcb   $6C l
         fcb   $73 s
         fcb   $74 t
         fcb   $0D 
         fcb   $44 D
         fcb   $4C L
         fcb   $44 D
         fcb   $2E .
         fcb   $64 d
         fcb   $73 s
         fcb   $63 c
         fcb   $0D 
L002B    fcb   $45 E
         fcb   $6E n
         fcb   $74 t
         fcb   $65 e
         fcb   $72 r
         fcb   $20 
         fcb   $66 f
         fcb   $69 i
         fcb   $6C l
         fcb   $65 e
         fcb   $6E n
         fcb   $61 a
         fcb   $6D m
         fcb   $65 e
         fcb   $20 
         fcb   $74 t
         fcb   $6F o
         fcb   $20 
         fcb   $75 u
         fcb   $6E n
         fcb   $76 v
         fcb   $61 a
         fcb   $6C l
         fcb   $69 i
         fcb   $64 d
         fcb   $61 a
         fcb   $74 t
         fcb   $65 e
         fcb   $3A :
L0048    fcb   $46 F
         fcb   $69 i
         fcb   $6C l
         fcb   $65 e
         fcb   $6E n
         fcb   $61 a
         fcb   $6D m
         fcb   $65 e
         fcb   $20 
         fcb   $6E n
         fcb   $6F o
         fcb   $74 t
         fcb   $20 
         fcb   $66 f
         fcb   $6F o
         fcb   $75 u
         fcb   $6E n
         fcb   $64 d
         fcb   $2E .
         fcb   $0D 
         fcb   $0A 
         fcb   $0D 
         fcb   $4E N
         fcb   $61 a
         fcb   $6D m
         fcb   $65 e
         fcb   $3A :
         fcb   $44 D
         fcb   $65 e
         fcb   $73 s
         fcb   $63 c
         fcb   $3A :
         fcb   $2D -
         fcb   $2D -
         fcb   $2D -
         fcb   $2D -
         fcb   $2D -
         fcb   $2D -
         fcb   $2D -
         fcb   $2D -
         fcb   $2D -
         fcb   $2D -
         fcb   $2D -
         fcb   $2D -
         fcb   $2D -
         fcb   $2D -
         fcb   $2D -
         fcb   $2D -
         fcb   $2D -
         fcb   $2D -
         fcb   $2D -
         fcb   $2D -
         fcb   $2D -
         fcb   $2D -
         fcb   $2D -
         fcb   $2D -
         fcb   $2D -
         fcb   $2D -
         fcb   $2D -
         fcb   $2D -
         fcb   $2D -
         fcb   $2D -
         fcb   $2D -
         fcb   $2D -
         fcb   $2D -
         fcb   $2D -
         fcb   $2D -
         fcb   $2D -
         fcb   $2D -
         fcb   $2D -
         fcb   $2D -
         fcb   $2D -
         fcb   $2D -
         fcb   $2D -
         fcb   $2D -
         fcb   $2D -
         fcb   $2D -
         fcb   $2D -
         fcb   $2D -
         fcb   $2D -
         fcb   $2D -
         fcb   $2D -
         fcb   $2D -
         fcb   $2D -
         fcb   $2D -
         fcb   $2D -
         fcb   $2D -
         fcb   $2D -
         fcb   $2D -
         fcb   $2D -
         fcb   $2D -
         fcb   $2D -
         fcb   $2D -
         fcb   $2D -
         fcb   $0D 
L00A7    fcb   $46 F
         fcb   $69 i
         fcb   $6C l
         fcb   $65 e
         fcb   $20 
         fcb   $75 u
         fcb   $6E n
         fcb   $76 v
         fcb   $61 a
         fcb   $6C l
         fcb   $69 i
         fcb   $64 d
         fcb   $61 a
         fcb   $74 t
         fcb   $65 e
         fcb   $64 d
         fcb   $2E .
         fcb   $0D 
start    equ   *
         lda   ,x
         cmpa  #$0D
         beq   L00C8
         lda   #$01
         os9   I$ChgDir 
         lbcs  L018A
L00C8    leax  >L001B,pcr
         lda   #$03
         os9   I$Open   
         lbcs  L018A
         sta   ,u
L00D7    leax  >L002B,pcr
         ldy   #$001D
         lda   #$01
         os9   I$Write  
         leax  <u0056,u
         ldy   #$001B
         clra  
         os9   I$ReadLn 
         lbcs  L00D7
         cmpy  #$0001
         lble  L0189
L00FB    lda   ,x
         anda  #$DF
         sta   ,x+
         cmpa  #$0D
         bne   L00FB
L0105    lda   ,u
         ldb   #$05
         pshs  u
         os9   I$GetStt 
         lbcs  L018A
         tfr   u,y
         puls  u
         stx   u0002,u
         sty   u0004,u
         leax  <u0071,u
         lda   ,u
         ldy   #$0060
         clrb  
         os9   I$Read   
         lbcs  L0145
         tst   >u0090,u
         beq   L0105
         leay  <u0056,u
L0135    lda   ,y
         cmpa  #$0D
         beq   L015B
         lda   ,x+
         anda  #$DF
         cmpa  ,y+
         bne   L0105
         bra   L0135
L0145    cmpb  #$D3
         lbne  L018A
         leax  >L0048,pcr
         ldy   #$00C8
         lda   #$01
         os9   I$WritLn 
         lbra  L0189
L015B    clr   >u0090,u
         ldx   u0002,u
         lda   ,u
         pshs  u
         ldu   u0004,u
         os9   I$Seek   
         lbcs  L018A
         puls  u
         leax  <u0071,u
         ldy   #$0060
         lda   ,u
         os9   I$Write  
         leax  >L00A7,pcr
         ldy   #$00C8
         lda   #$01
         os9   I$WritLn 
L0189    clrb  
L018A    os9   F$Exit   
         emod
eom      equ   *
         end
