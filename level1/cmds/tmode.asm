********************************************************************
* Tmode - Change terminal operating mode
*
* $Id$
*
* Ed.    Comments                                       Who YY/MM/DD
* ------------------------------------------------------------------
*  9     Original Microware distribution version

         nam   Tmode
         ttl   Change terminal operating mode

* Disassembled 02/04/03 22:38:23 by Disasm v1.6 (C) 1988 by RML

         ifp1
         use   os9defs
         endc
tylg     set   Prgrm+Objct   
atrv     set   ReEnt+rev
rev      set   $01
         mod   eom,name,tylg,atrv,start,size
u0000    rmb   1
u0001    rmb   1
u0002    rmb   2
u0004    rmb   1
u0005    rmb   1
u0006    rmb   27
u0021    rmb   5
u0026    rmb   536
size     equ   .
name     equ   *
         fcs   /Tmode/
         fcb   $09 
         fcb   $00 
         fcb   $17 
L0015    fcb   $FF 
         fcb   $01 
         fcb   $01 
         fcb   $01 
         fcb   $75 u
         fcb   $70 p
         fcb   $E3 c
         fcb   $FF 
         fcb   $01 
         fcb   $02 
         fcb   $01 
         fcb   $62 b
         fcb   $73 s
         fcb   $E2 b
         fcb   $FF 
         fcb   $00 
         fcb   $03 
         fcb   $00 
         fcb   $62 b
         fcb   $73 s
         fcb   $EC l
         fcb   $FF 
         fcb   $01 
         fcb   $04 
         fcb   $01 
         fcb   $65 e
         fcb   $63 c
         fcb   $68 h
         fcb   $EF o
         fcb   $FF 
         fcb   $01 
         fcb   $05 
         fcb   $01 
         fcb   $6C l
         fcb   $E6 f
         fcb   $00 
         fcb   $00 
         fcb   $06 
         fcb   $00 
         fcb   $6E n
         fcb   $75 u
         fcb   $6C l
         fcb   $EC l
         fcb   $FF 
         fcb   $01 
         fcb   $07 
         fcb   $01 
         fcb   $70 p
         fcb   $61 a
         fcb   $75 u
         fcb   $73 s
         fcb   $E5 e
         fcb   $00 
         fcb   $18 
         fcb   $08 
         fcb   $00 
         fcb   $70 p
         fcb   $61 a
         fcb   $E7 g
         fcb   $01 
         fcb   $08 
         fcb   $09 
         fcb   $00 
         fcb   $62 b
         fcb   $73 s
         fcb   $F0 p
         fcb   $01 
         fcb   $18 
         fcb   $0A 
         fcb   $00 
         fcb   $64 d
         fcb   $65 e
         fcb   $EC l
         fcb   $01 
         fcb   $0D 
         fcb   $0B 
         fcb   $00 
         fcb   $65 e
         fcb   $6F o
         fcb   $F2 r
         fcb   $01 
         fcb   $1B 
         fcb   $0C 
         fcb   $00 
         fcb   $65 e
         fcb   $6F o
         fcb   $E6 f
         fcb   $01 
         fcb   $04 
         fcb   $0D 
         fcb   $00 
         fcb   $72 r
         fcb   $65 e
         fcb   $70 p
         fcb   $72 r
         fcb   $69 i
         fcb   $6E n
         fcb   $F4 t
         fcb   $01 
         fcb   $01 
         fcb   $0E 
         fcb   $00 
         fcb   $64 d
         fcb   $75 u
         fcb   $F0 p
         fcb   $01 
         fcb   $17 
         fcb   $0F 
         fcb   $00 
         fcb   $70 p
         fcb   $73 s
         fcb   $E3 c
         fcb   $01 
         fcb   $03 
         fcb   $10 
         fcb   $00 
         fcb   $61 a
         fcb   $62 b
         fcb   $6F o
         fcb   $72 r
         fcb   $F4 t
         fcb   $01 
         fcb   $05 
         fcb   $11 
         fcb   $00 
         fcb   $71 q
         fcb   $75 u
         fcb   $69 i
         fcb   $F4 t
         fcb   $01 
         fcb   $08 
         fcb   $12 
         fcb   $00 
         fcb   $62 b
         fcb   $73 s
         fcb   $E5 e
         fcb   $01 
         fcb   $07 
         fcb   $13 
         fcb   $00 
         fcb   $62 b
         fcb   $65 e
         fcb   $6C l
         fcb   $EC l
         fcb   $01 
         fcb   $15 
         fcb   $14 
         fcb   $00 
         fcb   $74 t
         fcb   $79 y
         fcb   $70 p
         fcb   $E5 e
         fcb   $00 
         fcb   $02 
         fcb   $15 
         fcb   $00 
         fcb   $62 b
         fcb   $61 a
         fcb   $75 u
         fcb   $E4 d
         fcb   $01 
         fcb   $11 
         fcb   $18 
         fcb   $00 
         fcb   $78 x
         fcb   $6F o
         fcb   $EE n
         fcb   $01 
         fcb   $13 
         fcb   $19 
         fcb   $00 
         fcb   $78 x
         fcb   $6F o
         fcb   $66 f
         fcb   $E6 f
start    equ   *
         leay  ,x
         bsr   L0101
         clra  
         cmpb  #$2E
         bne   L00D9
         leay  $01,y
         lda   ,y+
         suba  #$30
         cmpa  #$10
         lbcc  L015F
L00D9    sta   <u0000
         ldb   #$00
         leax  u0006,u
         os9   I$GetStt 
         bcs   L00FE
         bsr   L0101
         cmpb  #$0D
         lbeq  L01CE
L00EC    bsr   L0112
         bcs   L015F
         cmpb  #$0D
         bne   L00EC
         lda   <u0000
         ldb   #$00
         os9   I$SetStt 
         bcs   L00FE
         clrb  
L00FE    os9   F$Exit   
L0101    ldb   ,y+
         cmpb  #$2C
         bne   L0109
L0107    ldb   ,y+
L0109    cmpb  #$20
         beq   L0107
         leay  -$01,y
         andcc #$FE
         rts   
L0112    clr   <u0001
         lda   ,y
         cmpa  #$2D
         bne   L011E
         inc   <u0001
         leay  $01,y
L011E    sty   <u0002
         leax  >L0015,pcr
         lbsr  L02AE
         bcs   L015F
         lda   ,x
         bpl   L013A
L012E    ldb   $01,x
L0130    lda   $02,x
         eorb  <u0001
         leax  u0006,u
         stb   a,x
         bra   L0101
L013A    tst   <u0001
         bne   L015F
         ldb   ,y
         cmpb  #$3D
         bne   L012E
         leay  $01,y
         tsta  
         bne   L0188
         clrb  
L014A    lda   ,y
         suba  #$30
         cmpa  #$09
         bhi   L019F
         pshs  a
         leay  $01,y
         lda   #$0A
         mul   
         addb  ,s+
         adca  #$00
         beq   L014A
L015F    leax  <L0170,pcr
         ldy   #$000E
         bsr   L0182
         ldx   <u0002
         bsr   L017E
         clrb  
         os9   F$Exit   
L0170    comb  
         rolb  
         fcb   $4E N
         lsrb  
         fcb   $41 A
         lslb  
         bra   L01BD
         aim   #$72,>$6F72
         abx   
         bra   L018F
         ldx   #$0050
L0182    lda   #$01
         os9   I$WritLn 
         rts   
L0188    bsr   L01AF
         bcs   L015F
         pshs  b
         bsr   L01AF
         puls  a
         bcc   L0197
         clrb  
         exg   a,b
L0197    lsla  
         lsla  
         lsla  
         lsla  
         pshs  a
         addb  ,s+
L019F    lda   ,y
         cmpa  #$20
         beq   L0130
         cmpa  #$0D
         beq   L0130
         cmpa  #$2C
         beq   L0130
         bra   L015F
L01AF    ldb   ,y
         subb  #$30
         cmpb  #$09
         bls   L01C7
         cmpb  #$31
         bcs   L01BD
         subb  #$20
L01BD    subb  #$07
         cmpb  #$0F
         bhi   L01CC
         cmpb  #$0A
         bcs   L01CC
L01C7    andcc #$FE
         leay  $01,y
         rts   
L01CC    comb  
         rts   
L01CE    clr   <u0004
         lda   #$2F
         lbsr  L028C
         ldx   <u0021,u
         ldx   $04,x
         ldd   $04,x
         leax  d,x
         bsr   L0227
         lda   #$0D
         lbsr  L028C
         leax  >L0015,pcr
         leay  u0006,u
         clrb  
L01EC    lda   b,y
         bsr   L01FE
         incb  
         cmpb  #$20
         bcs   L01EC
         lda   #$0D
         lbsr  L028C
         clrb  
         os9   F$Exit   
L01FE    pshs  u,y,x,b,a
         ldy   -$02,x
L0203    cmpb  $02,x
         beq   L0213
         leax  $04,x
L0209    lda   ,x+
         bpl   L0209
         leay  -$01,y
         bne   L0203
         puls  pc,u,y,x,b,a
L0213    bsr   L028A
         tst   ,x
         bpl   L023B
         lda   ,s
         cmpa  $03,x
         beq   L0223
         lda   #$2D
         bsr   L028C
L0223    bsr   L022B
         puls  pc,u,y,x,b,a
L0227    pshs  x
         bra   L022F
L022B    pshs  x
         leax  $04,x
L022F    lda   ,x
         anda  #$7F
         bsr   L028C
         lda   ,x+
         bpl   L022F
         puls  pc,x
L023B    bsr   L022B
         lda   #$3D
         bsr   L028C
         tst   ,x
         bne   L026E
         ldb   ,s
         lda   #$2F
         clr   <u0005
L024B    inca  
         subb  #$64
         bcc   L024B
         bsr   L0263
         lda   #$3A
L0254    deca  
         addb  #$0A
         bcc   L0254
         bsr   L0263
         tfr   b,a
         adda  #$30
         bsr   L028C
         puls  pc,u,y,x,b,a
L0263    inc   <u0005
         cmpa  #$30
         bne   L028C
         dec   <u0005
         bne   L028C
         rts   
L026E    lda   ,s
         anda  #$F0
         lsra  
         lsra  
         lsra  
         lsra  
         bsr   L0280
         lda   ,s
         anda  #$0F
         bsr   L0280
         puls  pc,u,y,x,b,a
L0280    adda  #$30
         cmpa  #$39
         bls   L028C
         adda  #$07
         bra   L028C
L028A    lda   #$20
L028C    pshs  y,x,b,a
         leax  <u0026,u
         ldb   <u0004
         sta   b,x
         cmpa  #$0D
         beq   L02A6
         incb  
         cmpb  #$16
         bcs   L02AA
         cmpa  #$20
         bne   L02AA
         lda   #$0D
         sta   b,x
L02A6    lbsr  L017E
         clrb  
L02AA    stb   <u0004
         puls  pc,y,x,b,a
L02AE    pshs  u,y,x
         ldu   -$02,x
L02B2    ldy   $02,s
         stx   ,s
         leax  $04,x
L02B9    lda   ,x+
         eora  ,y+
         anda  #$DF
         lsla  
         bne   L02CA
         bcc   L02B9
         sty   $02,s
         clra  
         puls  pc,u,y,x
L02CA    leax  -$01,x
L02CC    lda   ,x+
         bpl   L02CC
         leau  -u0001,u
         cmpu  #$0000
         bne   L02B2
         coma  
         puls  pc,u,y,x
         emod
eom      equ   *
