********************************************************************
* VDGInt - CoCo 3 VDG I/O module
*
* $Id$
*
* Ed.    Comments                                       Who YY/MM/DD
* ------------------------------------------------------------------

         nam   VDGInt
         ttl   CoCo 3 VDG I/O module

* Disassembled 98/09/31 12:15:57 by Disasm v1.6 (C) 1988 by RML

         ifp1
         use   defsfile
         endc

tylg     set   Systm+Objct   
atrv     set   ReEnt+rev
rev      set   $01
edition  set   3

         mod   eom,name,tylg,atrv,start,size

u0000    rmb   0
size     equ   .

         fcb   $07 

name     fcs   /VDGInt/
         fcb   edition

start    lbra  L0076
         lbra  L016A
         lbra  L045F
         lbra  L0522
         lbra  L004A
         cmpa  #$00
         bne   L0035
         ldb   <$37,u
         lbne  L066E
         ldd   <$44,u
         lbra  L0396
L0035    cmpa  #$01
         beq   L003B
         clrb  
         rts   
L003B    ldx   <$00A5
         leax  <$54,x
         ldd   ,x
         std   $04,x
         ldd   $02,x
         std   $06,x
         clrb  
         rts   
L004A    pshs  u,y,x
         ldb   #$03
L004E    pshs  b
         lbsr  L063B
         lbsr  L065B
         puls  b
         decb  
         bne   L004E
         clr   <$1E,u
         ldd   #$0200
         ldu   <$38,u
         beq   L0069
         os9   F$SRtMem 
L0069    ldb   #$E1
         leax  <$1F,u
         clra  
L006F    sta   ,x+
         decb  
         bne   L006F
         bra   L00D5

L0076    pshs  u,y,x
         bsr   L00D8
         lda   #$AF
         sta   <$41,u
         pshs  u
         ldd   #768
         os9   F$SRqMem 
         tfr   u,d
         tfr   u,x
         bita  #$01
         beq   L0095
         leax  >$0100,x
         bra   L0099
L0095    leau  >$0200,u
L0099    ldd   #256
         os9   F$SRtMem 
         puls  u
         stx   <$38,u
         stx   <$3C,u
         leax  >$0200,x
         stx   <$3A,u
         lda   #$60
         sta   <$3E,u
         sta   <$40,u
         lbsr  L02E6
         inc   <$1E,u
         ldd   <$1F,u
         lbsr  L054C
         leax  <$7C,u
         stx   <$2F,u
         stx   <$31,u
         ldu   <$00A5
         ldb   <$24,u
         orb   #$02
         stb   <$24,u
L00D5    clrb  
         puls  pc,u,y,x
L00D8    pshs  u,y,x,b,a
         lda   #$08
         sta   <$7B,u
         leax  >L011A,pcr
         leay  <$6B,u
L00E6    leau  >L00F8,pcr
L00EA    pshs  u
         leau  >L012A,pcr
         ldb   #$10
L00F2    lda   ,x+
         jmp   [,s]
L00F6    lda   a,u
L00F8    sta   ,y+
         decb  
         bne   L00F2
         leas  $02,s
L00FF    puls  pc,u,y,x,b,a
L0101    pshs  u,y,x,b,a
         lda   >$100A
         beq   L00FF
         leax  <$6B,u
         ldy   #$FFB0
         lda   >$1009
         bne   L00E6
         leau  >L00F6,pcr
         bra   L00EA
L011A    fdb   $1236,$0924,$3f1b
         fdb   $2d26,$0012,$003f,$0012,$0026
L012A    fdb   $000c,$020e,$0709
         fdb   $0510,$1c2c,$0d1d,$0b1b,$0a2b,$2211,$1221,$0301
         fdb   $1332,$1e2d,$1f2e,$0f3c,$2f3d,$1708,$1506,$2716
         fdb   $2636,$192a,$1a3a,$1829,$2838,$1404
         fcb   $23
L015D    leau  $05,y
         puls  y,b
         pshs  y
         rti   
         leay  -$02,y
         pulu  y,x,dp,cc
         swi   
         fcb   $30 0
L016A    cmpa  #$0E
         bls   L01CF
         cmpa  #$1B
         lbeq  L01FA
         cmpa  #$1F
         lbls  L01CD
         tsta  
         bmi   L01BA
         ldb   <$35,u
         beq   L019A
         cmpa  #$5E
         bne   L018A
         lda   #$00
         bra   L01BA
L018A    cmpa  #$5F
         bne   L0192
         lda   #$1F
         bra   L01BA
L0192    cmpa  #$60
         bne   L01AA
         lda   #$67
         bra   L01BA
L019A    cmpa  #$7C
         bne   L01A2
         lda   #$21
         bra   L01BA
L01A2    cmpa  #$7E
         bne   L01AA
         lda   #$2D
         bra   L01BA
L01AA    cmpa  #$60
         bcs   L01B2
         suba  #$60
         bra   L01BA
L01B2    cmpa  #$40
         bcs   L01B8
         suba  #$40
L01B8    eora  #$40
L01BA    ldx   <$3C,u
         sta   ,x+
         stx   <$3C,u
         cmpx  <$3A,u
         bcs   L01CA
         lbsr  L0273
L01CA    lbsr  L029C
L01CD    clrb  
         rts   
L01CF    leax  >L01D8,pcr
         lsla  
         ldd   a,x
         jmp   d,x
L01D8    fdb   $fff5,$011b,$0160,$0199
         fdb   $018b,$012f,$00fc,$fff5,$00ee,$01ab,$00d5,$010a
         fdb   $010e,$00bb,$01bc,$53c6,$f539 
L01FA    ldx   <$2F,u
         lda   ,x
         cmpa  #$30
         bne   L0209
         lbsr  L00D8
         lbra  L026E
L0209    cmpa  #$31
         lbeq  L0258
         cmpa  #$21
         lbne  L01CD
         ldx   $06,y
         lda   $01,x
         ldx   <$0050
         cmpa  >$00AC,x
         beq   L0249
         ldb   >$00AC,x
         sta   >$00AC,x
         pshs  y
         bsr   L024A
         ldy   $02,y
         ldx   <$00A5
         cmpy  <$20,x
         puls  y
         bne   L0248
         inc   <$23,u
         ldy   <$20,x
         sty   <$22,x
         stu   <$20,x
L0248    clrb  
L0249    rts   
L024A    leax  <$30,x
         lda   b,x
         ldx   <$0088
         os9   F$Find64 
         ldy   $03,y
         rts   
L0258    leax  <L0260,pcr
         ldb   #$02
         lbra  L0457
L0260    ldx   <$2F,u
         ldd   ,x
         anda  #$0F
         andb  #$3F
         leax  <$6B,u
         stb   a,x
L026E    inc   <$23,u
         clrb  
         rts   
L0273    ldx   <$38,u
         leax  <$20,x
L0279    ldd   ,x++
         std   <-$22,x
         cmpx  <$3A,u
         bcs   L0279
         leax  <-$20,x
         stx   <$3C,u
         lda   #$20
         ldb   #$60
L028D    stb   ,x+
         deca  
         bne   L028D
         rts   
L0293    bsr   L02FD
         tfr   x,d
         andb  #$E0
         stb   <$3D,u
L029C    ldx   <$3C,u
         lda   ,x
         sta   <$3E,u
         lda   <$41,u
         beq   L02AB
L02A9    sta   ,x
L02AB    clrb  
         rts   
         bsr   L02FD
         leax  <$20,x
         cmpx  <$3A,u
         bcs   L02C1
         leax  <-$20,x
         pshs  x
         lbsr  L0273
         puls  x
L02C1    stx   <$3C,u
         bra   L029C
         bsr   L02FD
         cmpx  <$38,u
         bls   L02D2
         leax  -$01,x
         stx   <$3C,u
L02D2    bra   L029C
         bsr   L02FD
         leax  $01,x
         cmpx  <$3A,u
         bcc   L02E0
         stx   <$3C,u
L02E0    bra   L029C
         bsr   L02FD
         bra   L02E8
L02E6    bsr   L02F3
L02E8    lda   #$60
L02EA    sta   ,x+
         cmpx  <$3A,u
         bcs   L02EA
         bra   L029C
L02F3    bsr   L02FD
         ldx   <$38,u
         stx   <$3C,u
         bra   L029C
L02FD    ldx   <$3C,u
         lda   <$3E,u
         sta   ,x
         clrb  
         rts   
         lda   <$7C,u
         suba  #$20
         bne   L0313
         sta   <$41,u
         bra   L02FD
L0313    cmpa  #$0B
         bge   L02AB
         cmpa  #$01
         bgt   L031F
         lda   #$AF
         bra   L032F
L031F    cmpa  #$02
         bgt   L0327
         lda   #$A0
         bra   L032F
L0327    subb  #$03
         lsla  
         lsla  
         lsla  
         lsla  
         ora   #$8F
L032F    sta   <$41,u
         ldx   <$3C,u
         lbra  L02A9
         ldb   #$02
         leax  <L0340,pcr
         lbra  L0457
L0340    bsr   L02FD
         ldb   <$7D,u
         subb  #$20
         lda   #$20
         mul   
         addb  <$7C,u
         adca  #$00
         subd  #$0020
         addd  <$38,u
         cmpd  <$3A,u
         lbcc  L02AB
         std   <$3C,u
         lbra  L029C
         bsr   L02FD
         tfr   x,d
         andb  #$1F
         pshs  b
         ldb   #$20
         subb  ,s+
         bra   L0376
         lbsr  L0293
         ldb   #$20
L0376    lda   #$60
         ldx   <$3C,u
L037B    sta   ,x+
         decb  
         bne   L037B
         lbra  L029C
         lbsr  L02FD
         leax  <-$20,x
         cmpx  <$38,u
         bcs   L0391
         stx   <$3C,u
L0391    lbra  L029C
         clra  
         clrb  
L0396    pshs  x,a
         stb   <$45,u
         clr   <$37,u
         lda   >PIA1Base+2
         anda  #$07
         ora   ,s+
         tstb  
         bne   L03AD
         anda  #$EF
         ora   <$35,u
L03AD    sta   <$44,u
         tst   >$100A
         lbeq  L0440
         sta   >PIA1Base+2
         tstb  
         bne   L03CB
         stb   >$FFC0
         stb   >$FFC2
         stb   >$FFC4
         lda   <$38,u
         bra   L03D7
L03CB    stb   >$FFC0
         stb   >$FFC3
         stb   >$FFC5
         lda   <$47,u
L03D7    lbsr  L0101
         ldb   <$0090
         orb   #$80
         stb   <$0090
         stb   >$FF90
         ldb   <$0098
         andb  #$78
         stb   >$FF98
         stb   <$0098
         clrb  
         stb   >$FF99
         stb   <$0099
         stb   >BordReg
         stb   <$009A
         tfr   a,b
         andb  #$1F
         pshs  b
         anda  #$E0
         lsra  
         lsra  
         lsra  
         lsra  
         ldx   <$004C
         leax  a,x
         ldb   $01,x
         pshs  b
         andb  #$38
         lslb  
         lslb  
         stb   <$009D
         stb   >$FF9D
         clrb  
         stb   <$009E
         stb   >$FF9E
         ldb   #$0F
         stb   <$009C
         stb   >$FF9C
         puls  a
         lsla  
         lsla  
         lsla  
         lsla  
         lsla  
         ora   ,s+
         ldb   #$07
         ldx   #$FFC6
         lsra  
L0430    lsra  
         bcs   L0439
         sta   ,x+
         leax  $01,x
         bra   L043D
L0439    leax  $01,x
         sta   ,x+
L043D    decb  
         bne   L0430
L0440    clrb  
         puls  pc,x
         pshs  x,b,a
         clra  
         ldb   $02,s
         ldx   <$004E
         leax  d,x
         puls  b,a
L044E    sta   ,x+
         decb  
         bne   L044E
         puls  pc,x
         ldb   #$01
L0457    stb   <$2C,u
         stx   <$2D,u
         clrb  
         rts   
L045F    ldx   $06,y
         cmpa  #$1C
         beq   L049B
         cmpa  #$26
         beq   L0477
         cmpa  #$25
         beq   L04C7
         cmpa  #$91
         lbeq  L0484
         comb  
         ldb   #$D0
         rts   
L0477    clra  
         ldb   <$42,u
         std   $04,x
         ldb   <$43,u
         std   $06,x
         clrb  
         rts   
L0484    pshs  u,y,x
         leay  <$6B,u
         ldu   $04,x
         ldx   <$0050
         ldb   $06,x
         clra  
         tfr   y,x
         ldy   #$0010
         os9   F$Move   
         puls  pc,u,y,x
L049B    ldd   <$38,u
         anda  #$E0
         lsra  
         lsra  
         lsra  
         lsra  
         ldy   <$004C
         ldd   a,y
         lbsr  L06E1
         bcs   L0521
         pshs  b,a
         ldd   <$38,u
         anda  #$1F
         addd  ,s
         std   $04,x
         ldd   <$3C,u
         anda  #$1F
         addd  ,s++
         std   $06,x
         lda   <$21,u
         bra   L051E
L04C7    ldd   <$3C,u
         subd  <$38,u
         pshs  b,a
         clra  
         andb  #$1F
         addb  #$20
         std   $04,x
         puls  b,a
         lsra  
         rolb  
         rolb  
         rolb  
         rolb  
         clra  
         andb  #$0F
         addb  #$20
         std   $06,x
         ldb   <$35,u
         lda   <$3E,u
         bmi   L051E
         cmpa  #$60
         bcc   L0509
         cmpa  #$20
         bcc   L050D
         tstb  
         beq   L0507
         cmpa  #$00
         bne   L04FF
         lda   #$5E
         bra   L051E
L04FF    cmpa  #$1F
         bne   L0507
         lda   #$5F
         bra   L051E
L0507    ora   #$20
L0509    eora  #$40
         bra   L051E
L050D    tstb  
         bne   L051E
         cmpa  #$21
         bne   L0518
         lda   #$7C
         bra   L051E
L0518    cmpa  #$2D
         bne   L051E
         lda   #$7E
L051E    sta   $01,x
         clrb  
L0521    rts   
L0522    ldx   $06,y
         cmpa  #$28
         beq   L054A
         cmpa  #$8F
         lbeq  L05B9
         cmpa  #$8C
         lbeq  L062F
         cmpa  #$8E
         lbeq  L05F3
         cmpa  #$8B
         lbeq  L056A
         cmpa  #$8D
         lbeq  L0647
         comb  
         ldb   #$D0
         rts   
L054A    ldd   $06,x
L054C    ldb   #$10
         bita  #$01
         bne   L0553
         clrb  
L0553    stb   <$35,u
         ldd   #$2010
         inc   <$23,u
         std   <$42,u
         rts   
L0560    fdb   $1402,$1502,$1602 
         fdb   $1d04,$1e04
L056A    ldb   $05,x
         cmpb  #$04
         bhi   L05B5
         lda   #$03
         pshs  y,x,b,a
         lda   #$03
         ldb   #$03
         leay  <$4D,u
         lbsr  L06C7
         bcs   L05AF
         sta   ,s
         ldb   $01,s
         stb   $02,y
         leax  >L0560,pcr
         lslb  
         leax  b,x
         ldb   $01,x
         stb   $01,y
         lbsr  L06DD
         bcs   L05AF
         stb   ,y
         lda   $01,x
         ldy   $02,s
         tst   $04,y
         bne   L05A6
         lbsr  L06E3
         bcs   L05AF
L05A6    ldx   $02,s
         std   $04,x
         ldb   ,s
         clra  
         std   $06,x
L05AF    leas  $02,s
         puls  pc,y,x
L05B3    leas  $02,s
L05B5    comb  
         ldb   #$BB
         rts   
L05B9    pshs  x
         ldb   $06,x
         bmi   L05C8
         bsr   L05DE
         bcs   L05DC
         lbsr  L06FF
         bcs   L05DC
L05C8    ldx   ,s
         ldb   $07,x
         bmi   L05DB
         bsr   L05DE
         bcs   L05DC
         lbsr  L06E3
         bcs   L05DC
         ldx   ,s
         std   $04,x
L05DB    clrb  
L05DC    puls  pc,x
L05DE    beq   L05F1
         cmpb  #$03
         bhi   L05F1
         bsr   L063B
         beq   L05F1
         ldb   ,x
         beq   L05F1
         lda   $01,x
         andcc #^Carry
         rts   
L05F1    bra   L05B5
L05F3    ldd   $04,x
         pshs  b,a
         cmpd  #$0004
         bhi   L05B3
         leax  >L0560,pcr
         lslb  
         incb  
         lda   b,x
         sta   ,s
         ldx   $06,y
         bsr   L061B
         bcs   L05B3
         lda   ,s
         cmpa  $01,x
         bhi   L05B3
         lda   $01,s
         sta   $02,x
         leas  $02,s
         bra   L0633
L061B    ldd   $06,x
         bmi   L05B5
         beq   L0633
         cmpd  #$0003
         bgt   L05B5
         bsr   L063B
         lda   ,x
         beq   L05B5
         clra  
         rts   
L062F    bsr   L061B
         bcs   L063A
L0633    stb   <$37,u
         inc   <$23,u
         clrb  
L063A    rts   
L063B    pshs  b,a
         leax  <$4A,u
         lda   #$03
         mul   
         leax  b,x
         puls  pc,b,a
L0647    tst   $06,x
         bne   L05F1
         ldb   $07,x
         cmpb  <$37,u
         beq   L05F1
         tstb  
         lbsr  L05DE
         bcs   L05F1
         lbsr  L06FF
L065B    lda   $01,x
         ldb   ,x
         beq   L066D
         pshs  a
         clra  
         sta   ,x
         tfr   d,x
         puls  b
         os9   F$DelRAM 
L066D    rts   
L066E    cmpb  #$03
         bhi   L06C6
         bsr   L063B
         ldb   ,x
         beq   L06C6
         ldb   $02,x
         cmpb  #$04
         bhi   L06C6
         lslb  
         pshs  x
         leax  >L0560,pcr
         ldb   b,x
         puls  x
         stb   >$FF99
         stb   >$0099
         lda   >$0090
         anda  #$7F
         sta   >$0090
         sta   >$FF90
         lda   >$0098
         ora   #$80
         anda  #$F8
         sta   >$0098
         sta   >$FF98
         clr   >$009A
         clr   >BordReg
         lda   ,x
         lsla  
         lsla  
         sta   >$009D
         sta   >$FF9D
         clr   >$009E
         clr   >$FF9E
         clr   >$009C
         clr   >$FF9C
         lbsr  L0101
L06C6    rts   
L06C7    clr   ,-s
         inc   ,s
L06CB    tst   ,y
         beq   L06D9
         leay  b,y
         inc   ,s
         deca  
         bne   L06CB
         comb  
         ldb   #$CB
L06D9    puls  pc,a
         ldb   #$01
L06DD    os9   F$AlHRAM 
         rts   
L06E1    lda   #$01
L06E3    pshs  u,x,b,a
         bsr   L0710
         bcc   L06F9
         clra  
         ldb   $01,s
         tfr   d,x
         ldb   ,s
         os9   F$MapBlk 
         stb   $01,s
         tfr   u,d
         bcs   L06FD
L06F9    leas  $02,s
         puls  pc,u,x
L06FD    puls  pc,u,x,b,a
L06FF    pshs  y,x,a
         bsr   L0710
         bcs   L070E
         ldd   #$333E
L0708    std   ,x++
         dec   ,s
         bne   L0708
L070E    puls  pc,y,x,a
L0710    pshs  b,a
         lda   #$08
         sta   $01,s
         ldx   <$0050
         leax  <$50,x
         clra  
         addb  ,s
         decb  
L071F    cmpd  ,--x
         beq   L072A
         dec   $01,s
         bne   L071F
         bra   L0743
L072A    dec   $01,s
         dec   ,s
         beq   L0738
         decb  
         cmpd  ,--x
         beq   L072A
         bra   L0743
L0738    lda   $01,s
         lsla  
         lsla  
         lsla  
         lsla  
         lsla  
         clrb  
         leas  $02,s
         rts   
L0743    puls  b,a
         comb  
         ldb   #E$BPAddr
         rts   

         emod
eom      equ   *
         end
