         nam   BBS.download
         ttl   program module       

* Disassembled 2010/01/24 10:31:43 by Disasm v1.5 (C) 1988 by RML

         ifp1
         use   /dd/defs/defsfile
         endc
tylg     set   Prgrm+Objct   
atrv     set   ReEnt+rev
rev      set   $01
         mod   eom,name,tylg,atrv,start,size
u0000    rmb   1
u0001    rmb   1
u0002    rmb   2
u0004    rmb   2
u0006    rmb   2
u0008    rmb   6
u000E    rmb   2
u0010    rmb   2
u0012    rmb   2
u0014    rmb   416
size     equ   .
name     equ   *
         fcs   /BBS.download/
         fcb   $45 E
         fcb   $6E n
         fcb   $74 t
         fcb   $65 e
         fcb   $72 r
         fcb   $20 
         fcb   $79 y
         fcb   $6F o
         fcb   $75 u
         fcb   $72 r
         fcb   $20 
         fcb   $64 d
         fcb   $6F o
         fcb   $77 w
         fcb   $6E n
         fcb   $6C l
         fcb   $6F o
         fcb   $61 a
         fcb   $64 d
         fcb   $20 
         fcb   $70 p
         fcb   $72 r
         fcb   $6F o
         fcb   $74 t
         fcb   $6F o
         fcb   $63 c
         fcb   $6F o
         fcb   $6C l
         fcb   $0D 
L0036    fcb   $0A 
         fcb   $0D 
         fcb   $5B [
         fcb   $41 A
         fcb   $5D ]
         fcb   $20 
         fcb   $41 A
         fcb   $73 s
         fcb   $63 c
         fcb   $69 i
         fcb   $69 i
         fcb   $0A 
         fcb   $0D 
         fcb   $5B [
         fcb   $58 X
         fcb   $5D ]
         fcb   $20 
         fcb   $78 x
         fcb   $6D m
         fcb   $6F o
         fcb   $64 d
         fcb   $65 e
         fcb   $6D m
         fcb   $0A 
         fcb   $0D 
         fcb   $5B [
         fcb   $43 C
         fcb   $5D ]
         fcb   $20 
         fcb   $78 x
         fcb   $6D m
         fcb   $6F o
         fcb   $64 d
         fcb   $65 e
         fcb   $6D m
         fcb   $20 
         fcb   $28 (
         fcb   $43 C
         fcb   $52 R
         fcb   $43 C
         fcb   $29 )
         fcb   $0A 
         fcb   $0D 
         fcb   $5B [
         fcb   $59 Y
         fcb   $5D ]
         fcb   $20 
         fcb   $79 y
         fcb   $6D m
         fcb   $6F o
         fcb   $64 d
         fcb   $65 e
         fcb   $6D m
         fcb   $0A 
         fcb   $0D 
         fcb   $5B [
         fcb   $51 Q
         fcb   $5D ]
         fcb   $20 
         fcb   $71 q
         fcb   $75 u
         fcb   $69 i
         fcb   $74 t
         fcb   $0A 
         fcb   $0D 
         fcb   $50 P
         fcb   $72 r
         fcb   $6F o
         fcb   $74 t
         fcb   $6F o
         fcb   $63 c
         fcb   $6F o
         fcb   $6C l
         fcb   $3F ?
L0080    fcb   $64 d
         fcb   $6C l
         fcb   $6F o
         fcb   $61 a
         fcb   $64 d
         fcb   $78 x
         fcb   $0D 
L0087    fcb   $64 d
         fcb   $6C l
         fcb   $6F o
         fcb   $61 a
         fcb   $64 d
         fcb   $78 x
         fcb   $63 c
         fcb   $0D 
L008F    fcb   $64 d
         fcb   $6C l
         fcb   $6F o
         fcb   $61 a
         fcb   $64 d
         fcb   $79 y
         fcb   $0D 
         fcb   $64 d
         fcb   $6C l
         fcb   $6F o
         fcb   $61 a
         fcb   $64 d
         fcb   $79 y
         fcb   $62 b
         fcb   $0D 
L009E    fcb   $44 D
         fcb   $6C l
         fcb   $6F o
         fcb   $61 a
         fcb   $64 d
         fcb   $61 a
         fcb   $0D 
L00A5    fcb   $0D 
         fcb   $0A 
L00A7    fcb   $2F /
         fcb   $64 d
         fcb   $64 d
         fcb   $2F /
         fcb   $62 b
         fcb   $62 b
         fcb   $73 s
         fcb   $2F /
         fcb   $42 B
         fcb   $42 B
         fcb   $53 S
         fcb   $2E .
         fcb   $75 u
         fcb   $73 s
         fcb   $65 e
         fcb   $72 r
         fcb   $73 s
         fcb   $74 t
         fcb   $61 a
         fcb   $74 t
         fcb   $73 s
         fcb   $0D 
start    equ   *
         lda   ,x
         cmpa  #$0D
         beq   L00CC
         lda   #$01
         os9   I$ChgDir 
         lbcs  L01F6
L00CC    leax  >L0036,pcr
         ldy   #$004A
         lda   #$01
         os9   I$Write  
         leax  ,u
         ldy   #$0001
         clra  
         os9   I$Read   
         leax  >L00A5,pcr
         ldy   #$0001
         lda   #$01
         os9   I$Write  
         lda   ,u
         anda  #$DF
         cmpa  #$41
         beq   L011E
         cmpa  #$58
         beq   L010C
         cmpa  #$59
         beq   L0112
         cmpa  #$43
         beq   L0118
         cmpa  #$51
         lbeq  L01F5
         bra   L00CC
L010C    leax  >L0080,pcr
         bra   L0124
L0112    leax  >L008F,pcr
         bra   L0124
L0118    leax  >L0087,pcr
         bra   L0124
L011E    leax  >L009E,pcr
         bra   L0124
L0124    ldy   #$0001
         lda   #$11
         ldb   #$03
         pshs  u
         leau  >L00A5,pcr
         os9   F$Fork   
         lbcs  L01F6
         clrb  
         os9   F$Wait   
         lbcs  L01F6
         cmpb  #$00
         lbne  L01F6
         puls  u
         leax  >L00A7,pcr
         lda   #$03
         os9   I$Open   
         bcc   L015D
         ldb   #$1B
         os9   I$Create 
         lbcs  L01F6
L015D    sta   u0001,u
         os9   F$ID     
         sty   u0002,u
L0165    leax  u0004,u
         ldy   #$0020
         lda   u0001,u
         os9   I$Read   
         bcs   L017B
         ldd   u0004,u
         cmpd  u0002,u
         bne   L0165
         bra   L0184
L017B    cmpb  #$D3
         lbne  L01F6
         lbra  L01C1
L0184    ldd   <u0012,u
         addd  #$0001
         std   <u0012,u
         lda   u0001,u
         ldb   #$05
         pshs  u
         os9   I$GetStt 
         tfr   u,d
         subd  #$0020
         bge   L019F
         leax  -$01,x
L019F    ldu   ,s
         tfr   d,y
         lda   u0001,u
         tfr   y,u
         os9   I$Seek   
         lbcs  L01F6
         puls  u
         leax  u0004,u
         ldy   #$0020
         lda   u0001,u
         os9   I$Write  
         os9   I$Close  
         lbra  L01F5
L01C1    leax  u0004,u
         ldd   #$0001
         std   u0006,u
         std   <u0010,u
         ldd   #$0000
         std   u000E,u
         std   <u0014,u
         std   <u0012,u
         ldd   u0002,u
         std   u0004,u
         leax  u0008,u
         os9   F$Time   
         lbcs  L01F6
         leax  u0004,u
         ldy   #$0020
         lda   u0001,u
         os9   I$Write  
         os9   I$Close  
         lbcs  L01F6
L01F5    clrb  
L01F6    os9   F$Exit   
         emod
eom      equ   *
         end
