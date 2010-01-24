         nam   DLD.read
         ttl   program module       

* Disassembled 2010/01/24 10:40:22 by Disasm v1.5 (C) 1988 by RML

         ifp1
         use   defsfile
         endc
tylg     set   Prgrm+Objct   
atrv     set   ReEnt+rev
rev      set   $01
         mod   eom,name,tylg,atrv,start,size
u0000    rmb   1
u0001    rmb   1
u0002    rmb   80
u0052    rmb   27
u006D    rmb   27
u0088    rmb   2
u008A    rmb   2
u008C    rmb   1
u008D    rmb   464
size     equ   .
name     equ   *
         fcs   /DLD.read/
L0015    fcb   $44 D
         fcb   $4C L
         fcb   $44 D
         fcb   $2E .
         fcb   $6C l
         fcb   $73 s
         fcb   $74 t
         fcb   $0D 
L001D    fcb   $44 D
         fcb   $4C L
         fcb   $44 D
         fcb   $2E .
         fcb   $64 d
         fcb   $73 s
         fcb   $63 c
         fcb   $0D 
L0025    fcb   $45 E
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
         fcb   $72 r
         fcb   $65 e
         fcb   $61 a
         fcb   $64 d
         fcb   $3A :
L003C    fcb   $46 F
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
L0050    fcb   $0A 
         fcb   $0D 
         fcb   $4E N
         fcb   $61 a
         fcb   $6D m
         fcb   $65 e
         fcb   $3A :
L0057    fcb   $44 D
         fcb   $65 e
         fcb   $73 s
         fcb   $63 c
         fcb   $3A :
L005C    fcb   $2D -
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
start    equ   *
         lda   ,x
         cmpa  #$0D
         beq   L00AA
         lda   #$01
         os9   I$ChgDir 
         lbcs  L01A7
L00AA    leax  >L0015,pcr
         lda   #$01
         os9   I$Open   
         lbcs  L01A7
         sta   ,u
         leax  >L001D,pcr
         lda   #$01
         os9   I$Open   
         lbcs  L01A7
         sta   u0001,u
L00C8    leax  >L0025,pcr
         ldy   #$0017
         lda   #$01
         os9   I$Write  
         leax  <u0052,u
         ldy   #$001B
         clra  
         os9   I$ReadLn 
         lbcs  L00C8
         cmpy  #$0001
         lble  L01A6
L00EC    lda   ,x
         anda  #$DF
         sta   ,x+
         cmpa  #$0D
         bne   L00EC
L00F6    leax  <u006D,u
         lda   ,u
         ldy   #$0060
         clrb  
         os9   I$Read   
         lbcs  L0120
         tst   >u008C,u
         beq   L00F6
         leay  <u0052,u
L0110    lda   ,y
         cmpa  #$0D
         beq   L0136
         lda   ,x+
         anda  #$DF
         cmpa  ,y+
         bne   L00F6
         bra   L0110
L0120    cmpb  #$D3
         lbne  L01A7
         leax  >L003C,pcr
         ldy   #$00C8
         lda   #$01
         os9   I$WritLn 
         lbra  L01A6
L0136    leax  >L0050,pcr
         ldy   #$0007
         lda   #$01
         os9   I$Write  
         leax  <u006D,u
         ldy   #$001E
         os9   I$WritLn 
         leax  >L0057,pcr
         ldy   #$0005
         os9   I$Write  
         leax  >u008D,u
         ldy   #$0041
         os9   I$WritLn 
         leax  >L005C,pcr
         ldy   #$0041
         os9   I$WritLn 
         lda   u0001,u
         ldx   >u0088,u
         pshs  u
         ldu   >u008A,u
         os9   I$Seek   
         puls  u
L017F    lda   u0001,u
         leax  u0002,u
         ldy   #$00C8
         os9   I$ReadLn 
         lbcs  L01A7
         lda   #$01
         os9   I$WritLn 
         cmpy  #$0001
         bgt   L017F
         leax  >L005C,pcr
         ldy   #$0041
         lda   #$01
         os9   I$WritLn 
L01A6    clrb  
L01A7    os9   F$Exit   
         emod
eom      equ   *
         end
