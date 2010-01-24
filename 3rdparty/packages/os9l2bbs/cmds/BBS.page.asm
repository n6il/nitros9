         nam   BBS.page
         ttl   program module       

* Disassembled 2010/01/24 10:53:41 by Disasm v1.5 (C) 1988 by RML

         ifp1
         use   /dd/defs/defsfile
         endc
tylg     set   Prgrm+Objct   
atrv     set   ReEnt+rev
rev      set   $01
         mod   eom,name,tylg,atrv,start,size
u0000    rmb   8
u0008    rmb   41
u0031    rmb   463
u0200    rmb   1
u0201    rmb   1
u0202    rmb   1
u0203    rmb   1
u0204    rmb   2
u0206    rmb   2
u0208    rmb   2
u020A    rmb   2
u020C    rmb   1
u020D    rmb   1
u020E    rmb   2
u0210    rmb   2
u0212    rmb   64
u0252    rmb   64
u0292    rmb   1
u0293    rmb   64
u02D3    rmb   200
u039B    rmb   200
u0463    rmb   600
size     equ   .
name     equ   *
         fcs   /BBS.page/
L0015    fcb   $00 
         fcb   $00 
L0017    fcb   $2F /
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
         fcb   $61 a
         fcb   $6C l
         fcb   $69 i
         fcb   $61 a
         fcb   $73 s
         fcb   $0D 
L0029    fcb   $55 U
         fcb   $73 s
         fcb   $65 e
         fcb   $72 r
         fcb   $20 
         fcb   $6E n
         fcb   $6F o
         fcb   $74 t
         fcb   $20 
         fcb   $63 c
         fcb   $75 u
         fcb   $72 r
         fcb   $72 r
         fcb   $65 e
         fcb   $6E n
         fcb   $74 t
         fcb   $6C l
         fcb   $79 y
         fcb   $20 
         fcb   $6F o
         fcb   $6E n
         fcb   $2D -
         fcb   $6C l
         fcb   $69 i
         fcb   $6E n
         fcb   $65 e
         fcb   $21 !
         fcb   $0D 
L0045    fcb   $55 U
         fcb   $73 s
         fcb   $65 e
         fcb   $72 r
         fcb   $20 
         fcb   $6E n
         fcb   $6F o
         fcb   $74 t
         fcb   $20 
         fcb   $69 i
         fcb   $6E n
         fcb   $20 
         fcb   $74 t
         fcb   $68 h
         fcb   $65 e
         fcb   $20 
         fcb   $61 a
         fcb   $6C l
         fcb   $69 i
         fcb   $61 a
         fcb   $73 s
         fcb   $20 
         fcb   $6C l
         fcb   $69 i
         fcb   $73 s
         fcb   $74 t
         fcb   $21 !
         fcb   $0D 
L0061    fcb   $55 U
         fcb   $73 s
         fcb   $65 e
         fcb   $72 r
         fcb   $20 
         fcb   $6E n
         fcb   $61 a
         fcb   $6D m
         fcb   $65 e
         fcb   $20 
         fcb   $74 t
         fcb   $6F o
         fcb   $20 
         fcb   $70 p
         fcb   $61 a
         fcb   $67 g
         fcb   $65 e
         fcb   $3A :
L0073    fcb   $53 S
         fcb   $65 e
         fcb   $6E n
         fcb   $64 d
         fcb   $69 i
         fcb   $6E n
         fcb   $67 g
         fcb   $20 
         fcb   $6D m
         fcb   $65 e
         fcb   $73 s
         fcb   $73 s
         fcb   $61 a
         fcb   $67 g
         fcb   $65 e
         fcb   $20 
         fcb   $6E n
         fcb   $6F o
         fcb   $77 w
         fcb   $2E .
         fcb   $2E .
         fcb   $2E .
         fcb   $0D 
L008A    fcb   $4D M
         fcb   $65 e
         fcb   $73 s
         fcb   $73 s
         fcb   $61 a
         fcb   $67 g
         fcb   $65 e
         fcb   $20 
         fcb   $72 r
         fcb   $65 e
         fcb   $63 c
         fcb   $69 i
         fcb   $65 e
         fcb   $76 v
         fcb   $65 e
         fcb   $64 d
         fcb   $20 
         fcb   $62 b
         fcb   $79 y
         fcb   $20 
         fcb   $75 u
         fcb   $73 s
         fcb   $65 e
         fcb   $72 r
         fcb   $0D 
L00A3    fcb   $45 E
         fcb   $6E n
         fcb   $74 t
         fcb   $65 e
         fcb   $72 r
         fcb   $20 
         fcb   $6D m
         fcb   $65 e
         fcb   $73 s
         fcb   $73 s
         fcb   $61 a
         fcb   $67 g
         fcb   $65 e
         fcb   $20 
         fcb   $74 t
         fcb   $6F o
         fcb   $20 
         fcb   $73 s
         fcb   $65 e
         fcb   $6E n
         fcb   $64 d
         fcb   $3A :
L00B9    fcb   $07 
         fcb   $07 
         fcb   $07 
         fcb   $07 
         fcb   $50 P
         fcb   $61 a
         fcb   $67 g
         fcb   $65 e
         fcb   $20 
         fcb   $66 f
         fcb   $72 r
         fcb   $6F o
         fcb   $6D m
         fcb   $20 
start    equ   *
         leax  >L0061,pcr
         ldy   #$0012
         lda   #$01
         os9   I$Write  
         lbcs  L034A
         leax  >u039B,u
         ldy   #$00C8
         clra  
         os9   I$ReadLn 
         lbcs  L034A
         leax  >L0017,pcr
         lda   #$01
         os9   I$Open   
         lbcs  L034A
         sta   >u0200,u
L00F9    leax  >u02D3,u
         ldy   #$00C8
         lda   >u0200,u
         os9   I$ReadLn 
         lbcs  L0134
         leay  >u039B,u
L0110    lda   ,x
         cmpa  #$2C
         beq   L011E
         anda  #$DF
         sta   ,x+
         cmpa  #$0D
         bne   L0110
L011E    leax  >u02D3,u
         leay  >u039B,u
L0126    lda   ,y+
         cmpa  #$0D
         beq   L0144
         anda  #$DF
         cmpa  ,x+
         bne   L00F9
         bra   L0126
L0134    leax  >L0045,pcr
         ldy   #$00C8
         lda   #$01
         os9   I$WritLn 
         lbra  L0349
L0144    lda   ,x+
         cmpa  #$2C
         bne   L00F9
         lbsr  L034D
         std   >u020A,u
         lda   >u0200,u
         pshs  u
         ldu   #$0000
         ldx   #$0000
         os9   I$Seek   
         lbcs  L034A
         os9   F$ID     
         sty   >u0210,u
L016C    leax  >u0463,u
         ldy   #$00C8
         lda   >u0200,u
         os9   I$ReadLn 
         lbcs  L034A
L017F    lda   ,x+
         cmpa  #$2C
         bne   L017F
         lda   #$0D
         sta   -$01,x
         lbsr  L034D
         cmpd  >u0210,u
         bne   L016C
         clr   >u0202,u
L0197    lda   >u0202,u
         inca  
         sta   >u0202,u
         beq   L01B4
         leax  ,u
         os9   F$GPrDsc 
         bcs   L0197
         ldd   u0008,u
         cmpd  >u020A,u
         bne   L0197
         bra   L01C4
L01B4    leax  >L0029,pcr
         ldy   #$00C8
         lda   #$01
         os9   I$WritLn 
         lbra  L0349
L01C4    lbsr  L0245
         leax  >L00A3,pcr
         ldy   #$0016
         lda   #$01
         os9   I$Write  
         leax  >u02D3,u
         ldy   #$00C8
         clra  
         os9   I$ReadLn 
         lbcs  L034A
         leax  >L0073,pcr
         ldy   #$00C8
         lda   #$01
         os9   I$WritLn 
         lda   #$2F
         sta   >u0292,u
         leax  >u0292,u
         lda   #$02
         os9   I$Open   
         lbcs  L034A
         sta   >u0201,u
         leax  >L00B9,pcr
         ldy   #$000E
         lda   >u0201,u
         os9   I$Write  
         leax  >u0463,u
         ldy   #$00C8
         os9   I$WritLn 
         leax  >u02D3,u
         ldy   #$00C8
         lda   >u0201,u
         os9   I$WritLn 
         lbcs  L034A
         leax  >L008A,pcr
         ldy   #$00C8
         lda   #$01
         os9   I$WritLn 
         lbra  L0349
L0245    leax  >L0015,pcr
         tfr   x,d
         ldx   #$004C
         ldy   #$0002
         pshs  u
         leau  >u0212,u
         os9   F$CpyMem 
         lbcs  L034A
         puls  u
         leax  >L0015,pcr
         tfr   x,d
         ldx   >u0212,u
         ldy   #$0040
         pshs  u
         leau  >u0212,u
         os9   F$CpyMem 
         puls  u
         leax  >u0212,u
         tfr   x,d
         ldx   #$0088
         ldy   #$0002
         pshs  u
         leau  >u0204,u
         os9   F$CpyMem 
         lbcs  L034A
         puls  u
         leax  >u0212,u
         tfr   x,d
         ldx   >u0204,u
         ldy   #$0040
         pshs  u
         leau  >u0252,u
         os9   F$CpyMem 
         lbcs  L034A
         puls  u
         ldb   <u0031,u
         lsrb  
         lsrb  
         leax  >u0252,u
         lda   b,x
         pshs  a
         ldb   <u0031,u
         andb  #$03
         lda   #$40
         mul   
         puls  a
         addb  #$03
         tfr   d,x
         leay  >u0212,u
         tfr   y,d
         ldy   #$0002
         pshs  u
         leau  >u0206,u
         os9   F$CpyMem 
         puls  u
         ldx   >u0206,u
         leax  $04,x
         leay  >u0212,u
         tfr   y,d
         ldy   #$0002
         pshs  u
         leau  >u0206,u
         os9   F$CpyMem 
         puls  u
         leax  >u0212,u
         tfr   x,d
         ldx   >u0206,u
         leax  $04,x
         ldy   #$0002
         pshs  u
         leau  >u0208,u
         os9   F$CpyMem 
         puls  u
         ldx   >u0206,u
         ldd   >u0208,u
         leax  d,x
         leay  >u0212,u
         tfr   y,d
         ldy   #$0040
         pshs  u
         leau  >u0293,u
         os9   F$CpyMem 
         puls  u
         leax  >u0293,u
L033C    lda   ,x+
         bpl   L033C
         anda  #$7F
         sta   -$01,x
         lda   #$0D
         sta   ,x
         rts   
L0349    clrb  
L034A    os9   F$Exit   
L034D    pshs  y
L034F    lda   ,x+
         cmpa  #$0D
         lbeq  L043E
         cmpa  #$30
         bcs   L034F
         cmpa  #$39
         bhi   L034F
         leax  -$01,x
L0361    lda   ,x+
         cmpa  #$30
         bcs   L036D
         cmpa  #$39
         bhi   L036D
         bra   L0361
L036D    pshs  x
         leax  -$01,x
         clr   >u020C,u
         clr   >u020D,u
         ldd   #$0001
         std   >u020E,u
L0380    lda   ,-x
         cmpa  #$30
         bcs   L03CA
         cmpa  #$39
         bhi   L03CA
         suba  #$30
         sta   >u0203,u
         ldd   #$0000
L0393    tst   >u0203,u
         beq   L03A3
         addd  >u020E,u
         dec   >u0203,u
         bra   L0393
L03A3    addd  >u020C,u
         std   >u020C,u
         lda   #$0A
         sta   >u0203,u
         ldd   #$0000
L03B4    tst   >u0203,u
         beq   L03C4
         addd  >u020E,u
         dec   >u0203,u
         bra   L03B4
L03C4    std   >u020E,u
         bra   L0380
L03CA    ldd   >u020C,u
         puls  x
         puls  pc,y
         std   >u020C,u
         lda   #$30
         sta   ,x
         sta   $01,x
         sta   $02,x
         sta   $03,x
         sta   $04,x
         ldd   #$2710
         std   >u020E,u
         ldd   >u020C,u
         lbsr  L0429
         ldd   #$03E8
         std   >u020E,u
         ldd   >u020C,u
         bsr   L0429
         ldd   #$0064
         std   >u020E,u
         ldd   >u020C,u
         bsr   L0429
         ldd   #$000A
         std   >u020E,u
         ldd   >u020C,u
         bsr   L0429
         ldd   #$0001
         std   >u020E,u
         ldd   >u020C,u
         bsr   L0429
         lda   #$0D
         sta   ,x
         rts   
L0429    subd  >u020E,u
         bcs   L0433
         inc   ,x
         bra   L0429
L0433    addd  >u020E,u
         std   >u020C,u
         leax  $01,x
         rts   
L043E    ldb   #$01
         lbra  L034A
         emod
eom      equ   *
         end
