         nam   BBS.create
         ttl   program module       

* Disassembled 2010/01/24 10:30:58 by Disasm v1.5 (C) 1988 by RML

         ifp1
         use   /dd/defs/defsfile
         endc
tylg     set   Prgrm+Objct   
atrv     set   ReEnt+rev
rev      set   $01
         mod   eom,name,tylg,atrv,start,size
u0000    rmb   1
u0001    rmb   1
u0002    rmb   264
size     equ   .
name     equ   *
         fcs   /BBS.create/
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
L0082    fcb   $42 B
         fcb   $42 B
         fcb   $53 S
         fcb   $2E .
         fcb   $6D m
         fcb   $73 s
         fcb   $67 g
         fcb   $2E .
         fcb   $69 i
         fcb   $6E n
         fcb   $78 x
         fcb   $0D 
L008E    fcb   $42 B
         fcb   $42 B
         fcb   $53 S
         fcb   $2E .
         fcb   $6D m
         fcb   $73 s
         fcb   $67 g
         fcb   $0D 
start    equ   *
         leax  >L0082,pcr
         lda   #$0B
         tfr   a,b
         os9   I$Create 
         lbcs  L00D8
         sta   ,u
         leax  >L008E,pcr
         lda   #$0B
         tfr   a,b
         os9   I$Create 
         lbcs  L00D8
         sta   u0001,u
         leax  u0002,u
         ldd   #$0000
         std   ,x
         std   $02,x
         std   $04,x
         lda   ,u
         ldy   #$0040
         os9   I$Write  
         lbcs  L00D8
         os9   I$Close  
         lbcs  L00D8
         clrb  
L00D8    os9   F$Exit   
         emod
eom      equ   *
         end
