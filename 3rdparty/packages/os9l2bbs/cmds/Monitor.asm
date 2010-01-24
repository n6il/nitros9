         nam   Monitor
         ttl   program module       

* Disassembled 2010/01/24 10:44:34 by Disasm v1.5 (C) 1988 by RML

         ifp1
         use   /dd/defs/defsfile
         endc
tylg     set   Prgrm+Objct   
atrv     set   ReEnt+rev
rev      set   $01
         mod   eom,name,tylg,atrv,start,size
u0000    rmb   1
u0001    rmb   1
u0002    rmb   1
u0003    rmb   1
u0004    rmb   2
u0006    rmb   2
u0008    rmb   32
u0028    rmb   255
u0127    rmb   1
u0128    rmb   712
size     equ   .
name     equ   *
         fcs   /Monitor/
         fcb   $43 C
         fcb   $6F o
         fcb   $70 p
         fcb   $79 y
         fcb   $72 r
         fcb   $69 i
         fcb   $67 g
         fcb   $68 h
         fcb   $74 t
         fcb   $20 
         fcb   $28 (
         fcb   $43 C
         fcb   $29 )
         fcb   $20 
         fcb   $31 1
         fcb   $39 9
         fcb   $38 8
         fcb   $38 8
         fcb   $42 B
         fcb   $79 y
         fcb   $20 
         fcb   $4B K
         fcb   $65 e
         fcb   $69 i
         fcb   $74 t
         fcb   $68 h
         fcb   $20 
         fcb   $41 A
         fcb   $6C l
         fcb   $70 p
         fcb   $68 h
         fcb   $6F o
         fcb   $6E n
         fcb   $73 s
         fcb   $6F o
         fcb   $4C L
         fcb   $69 i
         fcb   $63 c
         fcb   $65 e
         fcb   $6E n
         fcb   $63 c
         fcb   $65 e
         fcb   $64 d
         fcb   $20 
         fcb   $74 t
         fcb   $6F o
         fcb   $20 
         fcb   $41 A
         fcb   $6C l
         fcb   $70 p
         fcb   $68 h
         fcb   $61 a
         fcb   $20 
         fcb   $53 S
         fcb   $6F o
         fcb   $66 f
         fcb   $74 t
         fcb   $77 w
         fcb   $61 a
         fcb   $72 r
         fcb   $65 e
         fcb   $20 
         fcb   $54 T
         fcb   $65 e
         fcb   $63 c
         fcb   $68 h
         fcb   $6E n
         fcb   $6F o
         fcb   $6C l
         fcb   $6F o
         fcb   $67 g
         fcb   $69 i
         fcb   $65 e
         fcb   $73 s
         fcb   $41 A
         fcb   $6C l
         fcb   $6C l
         fcb   $20 
         fcb   $72 r
         fcb   $69 i
         fcb   $67 g
         fcb   $68 h
         fcb   $74 t
         fcb   $73 s
         fcb   $20 
         fcb   $72 r
         fcb   $65 e
         fcb   $73 s
         fcb   $65 e
         fcb   $72 r
         fcb   $76 v
         fcb   $65 e
         fcb   $64 d
         fcb   $EC l
         fcb   $E6 f
         fcb   $EA j
         fcb   $F5 u
         fcb   $E9 i
         fcb   $A0 
         fcb   $E2 b
         fcb   $ED m
         fcb   $F1 q
         fcb   $E9 i
         fcb   $F0 p
         fcb   $EF o
         fcb   $F4 t
         fcb   $F0 p
start    equ   *
         lda   ,x
         cmpa  #$0D
         beq   L00A0
         clra  
         os9   I$Close  
         inca  
         os9   I$Close  
         inca  
         os9   I$Close  
         lda   #$03
         os9   I$Open   
         lbcs  L0106
         os9   I$Dup    
         os9   I$Dup    
L00A0    clra  
         ldb   #$0E
         leax  u0008,u
         os9   I$GetStt 
         lbcs  L0106
         lda   #$F1
         pshs  u
         os9   F$Link   
         lbcs  L0106
         tfr   u,y
         puls  u
         ldx   $0F,y
         leax  $01,x
         stx   u0004,u
L00C1    ldx   #$0001
         os9   F$Sleep  
         ldx   u0004,u
         lda   ,x
         bita  #$20
         beq   L00C1
         os9   F$ID     
         sta   u0002,u
         leax  >u0127,u
         os9   F$GPrDsc 
         lda   >u0128,u
         sta   ,u
         lda   #$FF
         sta   u0001,u
         clr   u0003,u
         leax  <u0028,u
         stx   u0006,u
L00EC    lda   u0001,u
L00EE    leax  >u0127,u
         os9   F$GPrDsc 
         bcs   L0117
         lda   >u0128,u
         cmpa  ,u
         beq   L0109
         cmpa  #$00
         beq   L0117
         bra   L00EE
L0105    clrb  
L0106    os9   F$Exit   
L0109    lda   u0001,u
         cmpa  u0002,u
         beq   L0117
         ldx   u0006,u
         sta   ,x+
         stx   u0006,u
         inc   u0003,u
L0117    dec   u0001,u
         cmpa  #$03
         beq   L011F
         bra   L00EC
L011F    leax  <u0028,u
L0122    tst   u0003,u
         lbeq  L0105
         dec   u0003,u
         lda   ,x+
         clrb  
L012D    os9   F$Send   
         bcc   L0122
         pshs  x,a
         ldx   #$0001
         os9   F$Sleep  
         puls  x,a
         bra   L012D
         emod
eom      equ   *
         end
