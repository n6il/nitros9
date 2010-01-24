         nam   menu
         ttl   program module       

* Disassembled 2010/01/24 10:43:57 by Disasm v1.5 (C) 1988 by RML

         ifp1
         use   defsfile
         endc
tylg     set   Prgrm+Objct   
atrv     set   ReEnt+rev
rev      set   $01
         mod   eom,name,tylg,atrv,start,size
u0000    rmb   1
u0001    rmb   1
u0002    rmb   1
u0003    rmb   1
u0004    rmb   1
u0005    rmb   2
u0007    rmb   2
u0009    rmb   2
u000B    rmb   1
u000C    rmb   1
u000D    rmb   2
u000F    rmb   2
u0011    rmb   2
u0013    rmb   2
u0015    rmb   4
u0019    rmb   4
u001D    rmb   1
u001E    rmb   1
u001F    rmb   1
u0020    rmb   1
u0021    rmb   16
u0031    rmb   8
u0039    rmb   3
u003C    rmb   3
u003F    rmb   3
u0042    rmb   3
u0045    rmb   9
u004E    rmb   23
u0065    rmb   32
u0085    rmb   206
u0153    rmb   40
u017B    rmb   120
u01F3    rmb   3200
u0E73    rmb   2
u0E75    rmb   80
u0EC5    rmb   4450
size     equ   .
name     equ   *
         fcs   /menu/
         fcc   /Copyright (C) 1988/
         fcc   /By Keith Alphonso/
         fcc   /Licenced to Alpha Software Technologies/
         fcc   /All rights reserved/

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
L007C    fcb   $73 s
         fcb   $68 h
         fcb   $65 e
         fcb   $6C l
         fcb   $6C l
         fcb   $0D 
L0082    fcb   $55 U
         fcb   $73 s
         fcb   $61 a
         fcb   $67 g
         fcb   $65 e
         fcb   $20 
         fcb   $69 i
         fcb   $73 s
         fcb   $3A :
         fcb   $0A 
         fcb   $4D M
         fcb   $45 E
         fcb   $4E N
         fcb   $55 U
         fcb   $20 
         fcb   $3C <
         fcb   $6D m
         fcb   $65 e
         fcb   $6E n
         fcb   $75 u
         fcb   $6E n
         fcb   $61 a
         fcb   $6D m
         fcb   $65 e
         fcb   $3E >
         fcb   $20 
         fcb   $3C <
         fcb   $63 c
         fcb   $6D m
         fcb   $64 d
         fcb   $6E n
         fcb   $61 a
         fcb   $6D m
         fcb   $65 e
         fcb   $3E >
         fcb   $0A 
         fcb   $0D 
L00A7    fcb   $0A 
         fcb   $0A 
         fcb   $0D 
L00AA    fcb   $53 S
         fcb   $6F o
         fcb   $72 r
         fcb   $72 r
         fcb   $79 y
         fcb   $2C ,
         fcb   $20 
         fcb   $79 y
         fcb   $6F o
         fcb   $75 u
         fcb   $20 
         fcb   $64 d
         fcb   $6F o
         fcb   $20 
         fcb   $6E n
         fcb   $6F o
         fcb   $74 t
         fcb   $20 
         fcb   $68 h
         fcb   $61 a
         fcb   $76 v
         fcb   $65 e
         fcb   $20 
         fcb   $61 a
         fcb   $63 c
         fcb   $63 c
         fcb   $65 e
         fcb   $73 s
         fcb   $73 s
         fcb   $20 
         fcb   $74 t
         fcb   $6F o
         fcb   $20 
         fcb   $74 t
         fcb   $68 h
         fcb   $61 a
         fcb   $74 t
         fcb   $20 
         fcb   $6F o
         fcb   $70 p
         fcb   $74 t
         fcb   $69 i
         fcb   $6F o
         fcb   $6E n
         fcb   $0D 
L00D7    fcb   $41 A
         fcb   $20 
         fcb   $75 u
         fcb   $73 s
         fcb   $65 e
         fcb   $72 r
         fcb   $20 
         fcb   $70 p
         fcb   $72 r
         fcb   $69 i
         fcb   $6F o
         fcb   $72 r
         fcb   $69 i
         fcb   $74 t
         fcb   $79 y
         fcb   $20 
         fcb   $6C l
         fcb   $65 e
         fcb   $76 v
         fcb   $65 e
         fcb   $6C l
         fcb   $20 
         fcb   $68 h
         fcb   $61 a
         fcb   $73 s
         fcb   $20 
         fcb   $62 b
         fcb   $65 e
         fcb   $65 e
         fcb   $6E n
         fcb   $20 
         fcb   $73 s
         fcb   $70 p
         fcb   $65 e
         fcb   $63 c
         fcb   $69 i
         fcb   $66 f
         fcb   $69 i
         fcb   $65 e
         fcb   $64 d
         fcb   $20 
         fcb   $69 i
         fcb   $6E n
         fcb   $63 c
         fcb   $6F o
         fcb   $72 r
         fcb   $72 r
         fcb   $65 e
         fcb   $63 c
         fcb   $74 t
         fcb   $6C l
         fcb   $79 y
         fcb   $21 !
         fcb   $0D 
L010D    fcb   $2F /
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
L0123    fcb   $49 I
         fcb   $27 '
         fcb   $6D m
         fcb   $20 
         fcb   $73 s
         fcb   $6F o
         fcb   $72 r
         fcb   $72 r
         fcb   $79 y
         fcb   $2C ,
         fcb   $20 
         fcb   $62 b
         fcb   $75 u
         fcb   $74 t
         fcb   $20 
         fcb   $79 y
         fcb   $6F o
         fcb   $75 u
         fcb   $72 r
         fcb   $20 
         fcb   $74 t
         fcb   $69 i
         fcb   $6D m
         fcb   $65 e
         fcb   $20 
         fcb   $68 h
         fcb   $61 a
         fcb   $73 s
         fcb   $20 
         fcb   $65 e
         fcb   $78 x
         fcb   $70 p
         fcb   $69 i
         fcb   $72 r
         fcb   $65 e
         fcb   $64 d
         fcb   $21 !
         fcb   $0D 
L0149    fcb   $57 W
         fcb   $41 A
         fcb   $52 R
         fcb   $4E N
         fcb   $49 I
         fcb   $4E N
         fcb   $47 G
         fcb   $21 !
         fcb   $21 !
         fcb   $20 
         fcb   $20 
         fcb   $59 Y
         fcb   $6F o
         fcb   $75 u
         fcb   $20 
         fcb   $68 h
         fcb   $61 a
         fcb   $76 v
         fcb   $65 e
         fcb   $20 
         fcb   $6F o
         fcb   $6E n
         fcb   $6C l
         fcb   $79 y
         fcb   $20 
         fcb   $61 a
         fcb   $20 
         fcb   $66 f
         fcb   $65 e
         fcb   $77 w
         fcb   $20 
         fcb   $6D m
         fcb   $69 i
         fcb   $6E n
         fcb   $75 u
         fcb   $74 t
         fcb   $65 e
         fcb   $73 s
         fcb   $20 
         fcb   $6C l
         fcb   $65 e
         fcb   $66 f
         fcb   $74 t
         fcb   $20 
         fcb   $6F o
         fcb   $6E n
         fcb   $6C l
         fcb   $69 i
         fcb   $6E n
         fcb   $65 e
         fcb   $21 !
         fcb   $0D 
L017D    fcb   $1F 
         fcb   $1C 
         fcb   $1F 
         fcb   $1E 
         fcb   $1F 
         fcb   $1E 
         fcb   $1F 
         fcb   $1F 
         fcb   $1E 
         fcb   $1F 
         fcb   $1E 
         fcb   $1F 
start    equ   *
         pshs  u,y,x,b,a
         os9   F$ID     
         sty   <u0013,u
         puls  u,y,x,b,a
         ldd   #$0A0D
         std   >u0E73,u
         sty   u000B,u
         leay  <u0045,u
L01A1    lda   ,x+
         cmpx  u000B,u
         lbhi  L0586
         sta   ,y+
         cmpa  #$20
         bne   L01A1
         lda   #$0D
         sta   -$01,y
         leay  <u0065,u
L01B6    lda   ,x+
         cmpx  u000B,u
         lbhi  L0586
         sta   ,y+
         cmpa  #$0D
         bne   L01B6
         leax  >L010D,pcr
         lda   #$01
         os9   I$Open   
         lbcs  L027C
         sta   ,u
L01D3    leax  <u0019,u
         ldy   #$0020
         lda   ,u
         os9   I$Read   
         bcs   L01EC
         ldd   <u0013,u
         cmpd  <u0019,u
         bne   L01D3
         bra   L01F4
L01EC    lda   ,u
         os9   I$Close  
         lbra  L027C
L01F4    ldd   <u0031,u
         cmpd  #$0000
         lbeq  L0277
         ldb   <u0021,u
         clra  
         addd  <u0031,u
         cmpd  #$003C
         bcs   L0263
L020C    subd  #$003C
         pshs  b,a
         lda   <u0020,u
         inca  
         cmpa  #$18
         bcs   L0258
         clr   <u0020,u
         lda   <u001F,u
         inca  
         leax  >L017D,pcr
         ldb   <u001E,u
         decb  
         leax  b,x
         cmpa  ,x
         bcs   L0253
         lda   #$01
         sta   <u001F,u
         lda   <u001E,u
         inca  
         cmpa  #$0C
         blt   L024E
         lda   #$01
         sta   <u001E,u
         lda   <u001D,u
         inca  
         cmpa  #$64
         bcs   L0249
         clra  
L0249    sta   <u001D,u
         bra   L025B
L024E    sta   <u001E,u
         bra   L025B
L0253    sta   <u001F,u
         bra   L025B
L0258    sta   <u0020,u
L025B    puls  b,a
         cmpd  #$003C
         bcc   L020C
L0263    stb   <u0021,u
         lda   #$06
         leax  <u001D,u
         leay  <u003F,u
L026E    ldb   ,x+
         stb   ,y+
         deca  
         bne   L026E
         bra   L027C
L0277    lda   #$65
         sta   <u003F,u
L027C    leax  >u0153,u
         stx   u0005,u
         leax  >u01F3,u
         stx   u0007,u
         leax  >u017B,u
         stx   u0009,u
         leax  <u0065,u
         lda   #$01
         os9   I$Open   
         lbcs  L0594
         sta   u0002,u
L029C    ldx   u0005,u
         ldy   #$0001
         os9   I$Read   
         ldb   ,x
         cmpb  #$2F
         beq   L02F4
         cmpb  #$3E
         lbeq  L03AB
         cmpb  #$3C
         lbeq  L03AB
         cmpb  #$3D
         lbeq  L03AB
         ldy   u0009,u
         pshs  b,a
         lda   #$2D
         sta   ,y+
         ldd   #$FFFF
         std   ,y++
         puls  b,a
         sty   u0009,u
L02D0    cmpb  #$61
         bcs   L02D8
         andb  #$DF
         stb   ,x
L02D8    leax  $01,x
         stx   u0005,u
         ldx   u0007,u
         ldy   #$0050
         os9   I$ReadLn 
         lbcs  L0594
         sty   <$4E,x
         leax  <$50,x
         stx   u0007,u
         bra   L029C
L02F4    leax  >u0E75,u
         ldy   #$0050
         os9   I$ReadLn 
         lbcs  L0594
         sty   <u0011,u
         ldx   u0005,u
         lda   #$FF
         sta   ,x
         lda   u0002,u
         os9   I$Close  
         lbcs  L0594
         leax  <u0045,u
         lda   #$01
         os9   I$Open   
         lbcs  L0594
         sta   u0001,u
         leax  >u0EC5,u
         ldy   #$0FA0
         lda   u0001,u
         os9   I$Read   
         sty   <u0015,u
         lbcs  L0594
         os9   I$Close  
         stx   u000B,u
         tfr   y,d
         leax  d,x
         stx   u000F,u
         ldx   u000B,u
         ldy   #$0001
L034A    pshs  x
         lda   #$01
         ldb   #$01
         os9   I$GetStt 
         lbcc  L0440
         ldy   <u0015,u
         ldx   ,s
L035D    lda   ,x+
         cmpa  #$0D
         beq   L0374
         leay  -$01,y
         bne   L035D
         puls  x
         lda   #$01
         ldy   <u0015,u
         os9   I$Write  
         bra   L037F
L0374    puls  x
         lda   #$01
         ldy   <u0015,u
         os9   I$WritLn 
L037F    lbcs  L0594
         pshs  y
         ldd   <u0015,u
         subd  ,s
         std   <u0015,u
         cmpd  #$0000
         ble   L03A8
         puls  b,a
         leax  d,x
         lda   #$01
         ldb   #$01
         os9   I$GetStt 
         lbcc  L0440
         cmpx  u000F,u
         bhi   L03A8
         bra   L034A
L03A8    lbra  L03F9
L03AB    pshs  x,a
         ldy   u0009,u
         stb   ,y+
         leax  >u0085,u
         pshs  y
         ldy   #$0006
         os9   I$Read   
         leax  >u0085,u
         lbsr  L0597
         puls  y
         std   ,y++
         sty   u0009,u
         puls  x,a
         ldy   #$0001
         os9   I$Read   
         ldb   ,x
         lbra  L02D0
L03DB    leax  >L0123,pcr
         ldy   #$00C8
         lda   #$01
         os9   I$WritLn 
         lbra  L0582
L03EB    leax  >L0149,pcr
         ldy   #$00C8
         lda   #$01
         os9   I$WritLn 
         rts   
L03F9    leax  <u0039,u
         os9   F$Time   
         ldb   #$06
         leax  <u0039,u
         leay  <u003F,u
L0407    lda   ,x+
         cmpa  ,y+
         lbhi  L03DB
         bcs   L0414
         decb  
         bne   L0407
L0414    cmpb  #$03
         bgt   L0431
         ldd   <u003C,u
         addb  #$05
         cmpb  #$3C
         bcs   L0429
         subb  #$3C
         inca  
         cmpa  #$18
         bcs   L0429
         clra  
L0429    cmpd  <u0042,u
         bls   L0431
         bsr   L03EB
L0431    leax  >u0E75,u
         ldy   <u0011,u
         leay  -$01,y
         lda   #$01
         os9   I$Write  
L0440    leax  u0003,u
         ldy   #$0001
         clra  
         os9   I$Read   
         ldy   #$0002
         lda   #$01
         pshs  x
         leax  >L00A7,pcr
         os9   I$WritLn 
         puls  x
         lda   ,x
         cmpa  #$3F
         lbeq  L027C
         cmpa  #$61
         bcs   L046B
         anda  #$DF
         sta   ,x
L046B    lda   ,x
         leax  >u0153,u
         clrb  
L0472    tst   ,x
         bmi   L03F9
         cmpa  ,x+
         beq   L0482
         incb  
         cmpb  #$28
         bls   L0472
         lbra  L03F9
L0482    pshs  b
         lda   #$03
         mul   
         leax  >u017B,u
         leax  d,x
         lda   ,x+
         cmpa  #$3C
         beq   L04DF
         cmpa  #$3E
         beq   L04EF
         cmpa  #$3D
         beq   L04FF
L049B    puls  b
         lda   #$50
         mul   
         pshs  u
         leau  >u01F3,u
         leau  d,u
         lda   u0001,u
         anda  #$DF
         cmpa  #$43
         bne   L04CC
         lda   u0002,u
         anda  #$DF
         cmpa  #$48
         bne   L04CC
         lda   u0003,u
         anda  #$DF
         cmpa  #$4D
         lbeq  L0557
         cmpa  #$58
         lbeq  L0549
         cmpa  #$44
         beq   L053B
L04CC    lda   u0001,u
         anda  #$DF
         cmpa  #$45
         bne   L051F
         lda   u0002,u
         anda  #$DF
         cmpa  #$58
         bne   L051F
         lbra  L0582
L04DF    ldd   <u0013,u
         lbeq  L049B
         cmpd  ,x
         lbcs  L049B
         bra   L050D
L04EF    ldd   <u0013,u
         lbeq  L049B
         cmpd  ,x
         lbhi  L049B
         bra   L050D
L04FF    ldd   <u0013,u
         lbeq  L049B
         cmpd  ,x
         lbeq  L049B
L050D    leax  >L00AA,pcr
         ldy   #$00C8
         lda   #$01
         os9   I$WritLn 
         puls  b
         lbra  L03F9
L051F    ldy   <u004E,u
         leax  >L007C,pcr
         ldb   #$03
         lda   #$11
         os9   F$Fork   
         puls  u
         bcc   L0535
         os9   F$PErr   
L0535    os9   F$Wait   
         lbra  L03F9
L053B    tfr   u,x
         puls  u
         leax  $04,x
         lda   #$01
         os9   I$ChgDir 
         lbra  L027C
L0549    tfr   u,x
         puls  u
         leax  $04,x
         lda   #$04
         os9   I$ChgDir 
         lbra  L027C
L0557    tfr   u,x
         puls  u
         leay  <u0045,u
         leax  $04,x
L0560    lda   ,x+
         cmpa  #$20
         beq   L0560
         leax  -$01,x
L0568    lda   ,x+
         sta   ,y+
         cmpa  #$20
         bne   L0568
         lda   #$0D
         sta   -$01,y
         leay  <u0065,u
L0577    lda   ,x+
         sta   ,y+
         cmpa  #$0D
         bne   L0577
         lbra  L027C
L0582    clrb  
         os9   F$Exit   
L0586    leax  >L0082,pcr
         ldy   #$00C8
         lda   #$01
         os9   I$WritLn 
         clrb  
L0594    os9   F$Exit   
L0597    pshs  y
L0599    lda   ,x+
         cmpa  #$0D
         lbeq  L064E
         cmpa  #$30
         bcs   L0599
         cmpa  #$39
         bhi   L0599
         leax  -$01,x
L05AB    lda   ,x+
         cmpa  #$30
         bcs   L05B7
         cmpa  #$39
         bhi   L05B7
         bra   L05AB
L05B7    pshs  x
         leax  -$01,x
         clr   u000B,u
         clr   u000C,u
         ldd   #$0001
         std   u000D,u
L05C4    lda   ,-x
         cmpa  #$30
         bcs   L05F8
         cmpa  #$39
         bhi   L05F8
         suba  #$30
         sta   u0004,u
         ldd   #$0000
L05D5    tst   u0004,u
         beq   L05DF
         addd  u000D,u
         dec   u0004,u
         bra   L05D5
L05DF    addd  u000B,u
         std   u000B,u
         lda   #$0A
         sta   u0004,u
         ldd   #$0000
L05EA    tst   u0004,u
         beq   L05F4
         addd  u000D,u
         dec   u0004,u
         bra   L05EA
L05F4    std   u000D,u
         bra   L05C4
L05F8    ldd   u000B,u
         puls  x
         puls  pc,y
         std   u000B,u
         lda   #$30
         sta   ,x
         sta   $01,x
         sta   $02,x
         sta   $03,x
         sta   $04,x
         ldd   #$2710
         std   u000D,u
         ldd   u000B,u
         lbsr  L063F
         ldd   #$03E8
         std   u000D,u
         ldd   u000B,u
         bsr   L063F
         ldd   #$0064
         std   u000D,u
         ldd   u000B,u
         bsr   L063F
         ldd   #$000A
         std   u000D,u
         ldd   u000B,u
         bsr   L063F
         ldd   #$0001
         std   u000D,u
         ldd   u000B,u
         bsr   L063F
         lda   #$0D
         sta   ,x
         rts   
L063F    subd  u000D,u
         bcs   L0647
         inc   ,x
         bra   L063F
L0647    addd  u000D,u
         std   u000B,u
         leax  $01,x
         rts   
L064E    leax  >L00D7,pcr
         ldy   #$00C8
         lda   #$01
         os9   I$WritLn 
         lda   #$01
         lbra  L0594
         emod
eom      equ   *
         end
