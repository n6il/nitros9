********************************************************************
* GrfDrv - OS-9 Level Two graphics driver
*
* $Id$
*
* Ed.    Comments                                       Who YY/MM/DD
* ------------------------------------------------------------------
*   6    From OS-9 Level Two Version 3
*
*

         nam   GrfDrv
         ttl   OS-9 Level Two graphics driver

* Disassembled 02/07/06 13:10:20 by Disasm v1.6 (C) 1988 by RML

         ifp1
         use   defsfile
         endc

tylg     set   Systm+Objct   
atrv     set   ReEnt+rev
rev      set   $01
edition  set   6

         mod   eom,name,tylg,atrv,start,size
u0000    rmb   0
size     equ   .

         fcb   $07 

name     fcs   /GrfDrv/
         fcb   edition

start    pshs  b,a
         tfr   u,d
         tfr   a,dp
         leax  >L0029,pcr
         ldb   $01,s
         ldd   b,x
         leax  d,x
         puls  b,a
         jmp   ,x

L0029    fcb   $6E
         fdb   $8400,$6000,$b901
         fdb   $4303,$3103,$3503,$cf04,$8504,$b206,$ce05,$4e06
         fdb   $2906,$0405,$7505,$bd06,$1305,$d406,$3106,$5305
         fdb   $f706,$c106,$c606,$ca07,$d609,$1f0a,$150a,$4d0a
         fdb   $7f0b,$9b0d,$fa0e,$3b10,$2a10,$3113,$6110,$3d13
         fdb   $df13,$c615,$4415,$5016,$7417,$7917,$c118,$3117
         fdb   $d01b,$f116,$7a17,$bc18,$2c15,$0b0d,$382b,$5386
         fdb   $ff97,$3830,$c901,$80c6,$ff10

L0099    std   -$10,x
         leax  <$40,x
         leay  -$01,y
         bne   L0099
         leax  >$0980,u
         clrb  
         ldy   #$0010
L00AB    stb   $01,x
         leax  <$20,x
         leay  -$01,y
         bne   L00AB
         leax  >$0087,u
         clra  
         clrb  
         std   ,x
         ldd   #$333E
         std   $02,x
         std   $06,x
         std   $08,x
         std   $0A,x
         std   $0C,x
         std   $0E,x
         tfr   pc,d
         lsra  
         lsra  
         lsra  
         lsra  
         anda  #$0E
         ldy   <$004A
         leay  <$40,y
         ldd   a,y
         std   $04,x
         ldy   <$00A1
         stx   $02,y
         tfr   u,d
         addd  #$0B80
         addd  #$0018
         std   <$3B,u
         clra  
         clrb  
         std   <$30,u
         std   <$2E,u
         stb   <$32,u
         stb   <$35,u
         stb   <$39,u
         stb   <$3A,u
         std   <$3D,u
         std   <$3F,u
L0107    clra  
         rts   
L0109    clr   <$0038
         clr   <$007D
         ldb   <$0032
         beq   L011A
         ldx   <$0033
         lbsr  L0AB9
         bcc   L0109
         bra   L011B
L011A    clrb  
L011B    bra   L011D
L011D    pshs  cc
         orcc  #$50
         ldx   >$1007
         clr   >$1002
         clra  
         tfr   a,dp
         puls  a
         jmp   [>$00A9]
L0130    pshs  y,x,b,a
         ldx   -$10,y
         stx   $02,s
L0136    ldd   <$16,y
         std   <$0064
         ldd   $0F,y
         std   <$0066
         ldd   <$14,y
         std   <$0068
         ldd   $06,y
         std   <$0061
         ldd   <$1B,y
         std   <$006A
         ldd   <$1D,y
         std   <$006C
         ldb   ,x
         stb   <$0060
         ldb   $04,x
         stb   <$0063
         ldb   $01,x
L015C    leax  >$0087,u
         ldy   #$FFA8
         clra  
         std   $08,x
         stb   $04,y
         incb  
         std   $0A,x
         stb   $05,y
         incb  
         std   $0C,x
         stb   $06,y
         incb  
         std   $0E,x
         stb   $07,y
         puls  pc,y,x,b,a
L017A    pshs  y,x,b,a
         bra   L015C
L017E    pshs  y,x,b,a
         ldx   -$10,y
         bra   L0136
L0184    bsr   L0130
         lbra  L1525
L0189    pshs  x
         leax  >$0087,u
         clr   $02,x
         stb   $03,x
         ldx   #$FFA8
         stb   $01,x
         puls  pc,x
L019A    pshs  a
         os9   F$AllRAM 
         puls  pc,a
L01A1    pshs  a
         os9   F$AlHRAM 
         puls  pc,a
L01A8    os9   F$DelRAM 
         rts   
         bsr   L01D7
         bcs   L01D4
         lda   <$0060
         cmpa  #$FF
         bne   L01BF
         bsr   L0210
         bcs   L01D4
         lbsr  L1525
         bra   L01C4
L01BF    lbsr  L027D
         bcs   L01D4
L01C4    lbsr  L0130
         lbsr  L0387
         lda   #$FF
         sta   -$0E,y
         ldb   $08,y
         lbsr  L13E8
         clrb  
L01D4    lbra  L011D
L01D7    lda   <$0060
         cmpa  #$FF
         bne   L01E1
         ldx   -$10,y
         lda   ,x
L01E1    leax  >L0209,pcr
         anda  #$0F
         ldb   -$0B,y
         bmi   L0205
         cmpb  a,x
         bgt   L0205
         addb  -$09,y
         cmpb  a,x
         bgt   L0205
         ldb   -$0A,y
         bmi   L0205
         cmpb  #$18
         bgt   L0205
         addb  -$08,y
         cmpb  #$18
         bgt   L0205
         clrb  
         rts   
L0205    comb  
         ldb   #$BD
         rts   
L0209    neg   <$0050
         bvc   L025D
         bvc   L025F
         bvc   L0221
         stx   <$0099
         leax  >$0190,u
         ldb   #$20
         stb   <$009B
L021B    ldd   -$10,x
         bmi   L0230
         cmpd  -$10,y
         bne   L0230
         lda   -$0E,x
         bpl   L0230
         cmpx  <$0099
         beq   L0230
         bsr   L0239
         bcs   L0238
L0230    leax  <$40,x
         dec   <$009B
         bne   L021B
         clrb  
L0238    rts   
L0239    lda   $09,x
         bita  #$01
         beq   L0277
         lda   -$0B,y
         cmpa  <$26,x
         bge   L024F
         adda  -$09,y
         cmpa  <$26,x
         bgt   L025B
         bra   L0277
L024F    ldb   <$26,x
         addb  <$28,x
         stb   <$0097
         cmpa  <$0097
         bge   L0277
L025B    lda   -$0A,y
L025D    cmpa  <$27,x
         bge   L026B
         adda  -$08,y
         cmpa  <$27,x
         bgt   L0279
         bra   L0277
L026B    ldb   <$27,x
         addb  <$29,x
         stb   <$0097
         cmpa  <$0097
         blt   L0279
L0277    clrb  
         rts   
L0279    comb  
         ldb   #$C3
         rts   
L027D    bsr   L029C
         bcs   L029B
         stx   -$10,y
         ldb   <$0060
         stb   ,x
         bsr   L02B0
         bcs   L029B
         ldb   <$005A
         stb   $05,x
         lbsr  L07D4
         stb   $06,x
         lbsr  L0353
         lbsr  L072B
L029A    clrb  
L029B    rts   
L029C    leax  >$0980,u
         ldb   #$10
L02A2    tst   $01,x
         beq   L029A
         leax  <$20,x
         decb  
         bne   L02A2
         comb  
         ldb   #$C1
         rts   
L02B0    pshs  y
         ldb   <$0060
         bpl   L02D0
         leay  >$0980,u
         lda   #$10
L02BC    tst   ,y
         bpl   L02C8
         ldb   $01,y
         beq   L02C8
         bsr   L031C
         bcc   L02FA
L02C8    leay  <$20,y
         deca  
         bne   L02BC
         ldb   <$0060
L02D0    leay  >L030E,pcr
         andb  #$0F
         ldb   b,y
         lbsr  L01A1
         bcs   L030C
         ldy   #$8000
         pshs  y,b
         lbsr  L017A
         ldy   #$8000
         ldb   #$FF
L02EC    stb   ,y
         leay  >$0800,y
         cmpy  #$A000
         bcs   L02EC
         puls  y,b
L02FA    stb   $01,x
         sty   $02,x
         lda   <$0060
         anda  #$0F
         leay  >L0315,pcr
         lda   a,y
         sta   $04,x
         clrb  
L030C    puls  pc,y
L030E    neg   <$0002
         aim   #$04,<$0004
         oim   #$01,<$0000
         negb  
         negb  
         suba  ,y+
         suba  -$10,u
L031C    pshs  y,x,b,a
         lbsr  L017A
         ldy   #$8000
         ldb   #$FF
L0327    cmpb  ,y
         beq   L0337
L032B    leay  >$0800,y
         cmpy  #$A000
         bcs   L0327
         bra   L0350
L0337    lda   <$0060
         cmpa  #$84
         beq   L034A
         leax  >$0800,y
         cmpx  #$A000
         bcc   L0350
         cmpb  ,x
         bne   L032B
L034A    clrb  
         puls  x,b,a
         leas  $02,s
         rts   
L0350    comb  
         puls  pc,y,x,b,a
L0353    pshs  y,x
         stb   <$0097
         stb   <$0098
         tst   ,x
         bpl   L0361
         lda   #$20
         sta   <$0097
L0361    ldy   $02,x
         lda   ,x
         anda  #$0F
         lsla  
         leax  >L0379,pcr
         ldx   a,x
         ldd   <$0097
L0371    std   ,y++
         leax  -$01,x
         bne   L0371
         puls  pc,y,x
L0379    neg   <$0000
         tfr   s,d
         tfr   s,d
         fcb   $3E >
         suba  #$3E
         suba  #$07
         subb  <$0003
         eorb  -$0C,y
         clrd  
         clrb  
         sta   <$18,y
         sta   $0A,y
         sta   $0E,y
         leax  >L1FE9,pcr
         stx   <$14,y
         leax  >L1FDE,pcr
         stx   <$16,y
         lda   #$89
         sta   $09,y
         ldb   $06,y
         lbsr  L078D
         stb   $06,y
         stb   <$0061
         ldb   $07,y
         lbsr  L078D
         stb   $07,y
         stb   <$0062
         lbsr  L07DE
         puls  x
         ldd   $02,x
         bsr   L03CD
         clr   $0B,y
         ldd   #$C801
         std   <$0057
         lbsr  L067D
         bcs   L03CB
L03CB    clrb  
         rts   
L03CD    lbsr  L05BA
         ldd   -$0D,y
         std   <$24,y
         ldd   -$0B,y
         std   <$26,y
         ldd   -$09,y
         std   <$28,y
         rts   
         ldb   $09,y
         tsta  
         beq   L03E9
         orb   #$01
         bra   L03EB
L03E9    andb  #$FE
L03EB    stb   $09,y
         bra   L0421
         lbsr  L0184
         ldd   #$FFFF
         std   -$10,y
         bsr   L0424
         bcs   L0419
         bsr   L043C
         cmpy  <$002E
         bne   L0419
         ldd   #$0000
         std   <$002E
         std   <$0030
         ldx   #$FFB0
         ldd   #$163F
         stb   >$FF9A
L0412    stb   ,x+
         deca  
         bhi   L0412
         bra   L0421
L0419    ldb   $06,x
         stb   <$0062
         lbsr  L13E8
         clrb  
L0421    lbra  L011D
L0424    pshs  y
         leay  >$0190,u
         ldb   #$20
L042C    cmpx  -$10,y
         beq   L0439
         leay  <$40,y
         decb  
         bne   L042C
         clrb  
         bra   L043A
L0439    comb  
L043A    puls  pc,y
L043C    pshs  y
         lda   ,x
         bpl   L0469
         ldy   $02,x
         ldb   #$FF
         stb   ,y
         cmpa  #$85
         bne   L0453
         leay  >$0800,y
         stb   ,y
L0453    ldy   #$8000
L0457    cmpb  ,y
         bne   L047F
         leay  >$0800,y
         cmpy  #$A000
         bcs   L0457
         ldb   #$01
         bra   L046F
L0469    leay  >L030E,pcr
         ldb   a,y
L046F    pshs  x,b
         clra  
         ldb   $01,x
         tfr   d,x
         puls  b
         lbsr  L01A8
         bcs   L0482
         puls  x
L047F    clrb  
         stb   $01,x
L0482    puls  pc,y
         pshs  y
         ldb   -$0E,y
         lda   #$40
         mul   
         leay  >$0190,u
         leay  d,y
         lbsr  L0184
         tfr   y,d
         ldy   ,s
         std   ,s
         bsr   L04C5
         bcs   L04C2
         ldd   -$10,x
         std   -$10,y
         lbsr  L017E
         bsr   L04F4
         tst   <$0059
         beq   L04B8
         lbsr  L0544
         bcs   L04C2
         ldb   $07,y
         stb   <$0062
         lbsr  L13E8
L04B8    puls  x
         cmpx  <$002E
         bne   L04C1
         sty   <$002E
L04C1    clrb  
L04C2    lbra  L011D
L04C5    bsr   L04E2
L04C7    ldb   -$0B,y
         bmi   L04DF
         addb  -$09,y
         cmpb  <$28,x
         bhi   L04DF
         ldb   -$0A,y
         bmi   L04DF
         addb  -$08,y
         cmpb  <$29,x
         bhi   L04DF
         clrb  
         rts   
L04DF    lbra  L0205
L04E2    tfr   y,x
L04E4    ldb   -$0E,x
         bmi   L04F3
         leax  >$0190,u
         lda   #$40
         mul   
         leax  d,x
         bra   L04E4
L04F3    rts   
L04F4    clra  
         clrb  
         sta   <$11,y
         lda   $09,x
         sta   $09,y
         lbsr  L07DE
         lda   $08,x
         anda  #$C0
         ora   $08,y
         sta   $08,y
         lda   $0A,x
         sta   $0A,y
         ldd   <$14,x
         std   <$14,y
         lda   $0E,x
         sta   $0E,y
         ldd   <$16,x
         std   <$16,y
         lda   $0B,x
         sta   $0B,y
         ldd   $0C,x
         std   $0C,y
         ldb   <$18,x
         stb   <$18,y
         ldd   <$19,x
         std   <$19,y
         ldb   $06,y
         lbsr  L078D
         stb   $06,y
         ldb   $07,y
         lbsr  L078D
         stb   $07,y
         ldd   -$0D,x
         lbsr  L03CD
         rts   
L0544    pshs  x
         clra  
         ldb   -$09,y
         tst   <$0060
         bmi   L0552
         lslb  
         lslb  
         rola  
         lslb  
         rola  
L0552    std   <$004F
         clra  
         ldb   -$08,y
         tst   <$0060
         bmi   L055E
         lslb  
         lslb  
         lslb  
L055E    std   <$0051
         clra  
         clrb  
         std   <$0047
         lbsr  L0C4D
         puls  pc,x
         lbsr  L0184
         cmpy  <$002E
         bne   L0583
         pshs  y
         ldb   -$0E,y
         lda   #$40
         mul   
         leay  >$0190,u
         leay  d,y
         sty   <$002E
         puls  y
L0583    ldb   <$11,y
         beq   L059B
         lbsr  L0189
         stb   <$007D
         ldd   <$12,y
         std   <$007E
         lbsr  L0D49
         lbsr  L0988
         lbsr  L0AB9
L059B    ldd   #$FFFF
         std   -$10,y
         bra   L05B6
L05A2    comb  
         ldb   #$C0
         bra   L05B7
         lbsr  L0184
         tfr   y,x
         lbsr  L04C7
         bcs   L05B7
         ldd   <$24,y
         bsr   L05BA
L05B6    clrb  
L05B7    lbra  L011D
L05BA    pshs  x,b,a
         ldb   <$0060
         andb  #$0F
         leax  >L061A,pcr
         ldb   b,x
         stb   $03,y
         lda   -$09,y
         mul   
         stb   $02,y
         clra  
         ldb   <$0063
         tst   <$0060
         bmi   L05DA
         lslb  
         rola  
         lslb  
         rola  
         lslb  
         rola  
L05DA    std   $04,y
         ldb   -$0A,y
         ldx   $04,y
         lbsr  L1EA9
         std   <$0097
         lda   -$0B,y
         ldb   $03,y
         mul   
         addd  ,s++
         addd  <$0097
         std   -$0D,y
         lbsr  L124B
         ldb   <$0060
         bmi   L05F9
         bsr   L0621
L05F9    clra  
         ldb   -$09,y
         tst   <$0060
         bmi   L0603
         lda   #$08
         mul   
L0603    subd  #$0001
         std   <$1B,y
         clra  
         ldb   -$08,y
         tst   <$0060
         bmi   L0613
         lda   #$08
         mul   
L0613    subb  #$01
         std   <$1D,y
         puls  pc,x
L061A    neg   <$0001
         aim   #$02,<$0004
         aim   #$02,<$0034
         clrd  
         ldb   -$09,y
         tfr   d,x
         lda   #$03
         mul   
         pshs  b
         ldb   #$33
         lbsr  L1E87
         addb  ,s+
         stb   -$07,y
         clra  
         ldb   -$08,y
         tfr   d,x
         lda   #$0A
         mul   
         pshs  b
         ldb   #$AB
         lbsr  L1E87
         addb  ,s+
         stb   -$06,y
         puls  pc,x
         ldb   <$0057
         bne   L0657
         stb   $0E,y
         leax  >L1FDE,pcr
         bra   L066F
L0657    lbsr  L098E
         bcs   L0673
         stb   $0E,y
         leax  <$20,x
         stx   $0F,y
         ldx   -$10,y
         ldb   ,x
         leax  >L1FF4,pcr
         ldb   b,x
         leax  b,x
L066F    stx   <$16,y
L0672    clrb  
L0673    lbra  L011D
         lbsr  L0184
         bsr   L067D
         bra   L0673
L067D    ldb   <$0057
         bne   L0685
         stb   $0B,y
         bra   L06BF
L0685    lbsr  L1031
         lbsr  L098E
         bcs   L06BF
         pshs  x,b
         ldd   $07,x
         cmpd  #$0006
         beq   L069D
         cmpd  #$0008
         bne   L06C0
L069D    ldd   $09,x
         cmpd  #$0008
         bne   L06C0
         stb   $0B,x
         ldd   $07,x
         cmpd  <$006E
         beq   L06B8
         tst   $0B,y
         beq   L06B8
         lbsr  L12B9
         lbsr  L12A4
L06B8    puls  x,b
         stb   $0B,y
         stx   $0C,y
         clrb  
L06BF    rts   
L06C0    puls  x,b
         ldb   #$C2
         coma  
         rts   
         lbsr  L0184
         ldb   <$0057
         bne   L06D2
         stb   <$18,y
         bra   L0673
L06D2    lbsr  L098E
         bcs   L0673
         stb   <$18,y
         stx   <$19,y
         bra   L0672
         leax  >L06FC,pcr
         ldb   $0A,y
         cmpb  #$03
         bhi   L06F7
         lslb  
         ldd   b,x
         leax  >L06FC,pcr
         leax  d,x
         stx   <$14,y
         bra   L0711
L06F7    comb  
         ldb   #$BB
         bra   L0712
L06FC    fcb   $18 
         std   -$08,x
         addb  -$08,x
         sbcb  >$18E7
         ldb   $09,y
         tsta  
         bne   L070D
         orb   #$80
         bra   L070F
L070D    andb  #$7F
L070F    stb   $09,y
L0711    clrb  
L0712    lbra  L011D
         ldb   <$0086
         ldx   -$10,y
         leax  <$10,x
         lda   <$005A
         anda  #$0F
         stb   a,x
         bra   L0711
         ldx   -$10,y
         bsr   L072B
         lbra  L011D
L072B    pshs  y,x
         leax  <$10,x
         ldy   >$1019
         clra  
L0735    ldb   ,y+
         stb   a,x
         inca  
         cmpa  #$0F
         ble   L0735
         puls  pc,y,x
         ldb   <$005A
         ldx   -$10,y
         stb   $05,x
         bra   L0789
         ldx   -$10,y
         ldb   ,x
         stb   <$0060
         ldb   <$005A
         bsr   L078D
         stb   $06,y
         ldb   $09,y
         bitb  #$04
         bne   L0779
L075A    ldb   <$005A
         lslb  
         lslb  
         lslb  
         andb  #$38
         lda   $08,y
         anda  #$C7
         bra   L0783
         ldx   -$10,y
         ldb   ,x
         stb   <$0060
         ldb   <$005A
         bsr   L078D
         stb   $07,y
         ldb   $09,y
         bitb  #$04
         bne   L075A
L0779    ldb   <$005A
         ldb   <$005A
         andb  #$07
         lda   $08,y
         anda  #$F8
L0783    stb   <$0097
         ora   <$0097
         sta   $08,y
L0789    clrb  
         lbra  L011D
L078D    pshs  x,a
         lda   <$0060
         bmi   L079F
         leax  >L07A1,pcr
         lda   a,x
         leax  a,x
         andb  ,x+
         ldb   b,x
L079F    puls  pc,x,a
L07A1    neg   <$0005
         lsl   <$0008
         tst   <$0001
         neg   <$00FF
         com   <$0000
         fcb   $55 U
         ora   [>$0F00]
         fcb   $11 
         bhi   L07E6
         lsra  
         fcb   $55 U
         ror   -$09,s
         eora  #$99
         ora   [d,y]
         ldd   #$DDEE
         stu   >$3412
         leax  >L07CD,pcr
         lda   <$0060
         anda  #$0F
         andb  a,x
         puls  pc,x,a
L07CD    neg   <$0007
         asr   <$0001
         com   <$0003
         asr   <$006D
         anda  #$2A
         com   <$00C4
         asr   <$0039
         bsr   L078D
         rts   
L07DE    ldb   $06,y
         andb  #$07
         lslb  
         lslb  
         lslb  
         lda   $07,y
         anda  #$07
         sta   <$0097
         orb   <$0097
         stb   $08,y
         rts   
         ldb   $09,y
         tsta  
         bne   L07F9
         andb  #$EF
         bra   L07FB
L07F9    orb   #$10
L07FB    bra   L0815
         ldb   $09,y
         tsta  
         bne   L0806
         andb  #$F7
         bra   L0808
L0806    orb   #$08
L0808    bra   L0815
         ldb   $09,y
         tsta  
         bne   L0813
         andb  #$DF
         bra   L0815
L0813    orb   #$20
L0815    stb   $09,y
         lbra  L1521
         pshs  y
         ldy   <$002E
         beq   L0824
         lbsr  L0184
L0824    ldb   >$1000
         stb   >$1001
         ldy   ,s
         lbsr  L0130
         sty   <$002E
         stx   <$0030
         tfr   x,y
         lda   $01,y
         ldx   $02,y
         lbsr  L091B
         ldx   #$FF90
         ldb   >$0090
         andb  #$7F
         stb   >$0090
         stb   ,x
         leax  >L08BE,pcr
         ldb   ,y
         andb  #$0F
         lslb  
         abx   
         lda   >$0098
         anda  #$78
         ora   ,x+
         ldb   ,x
         ldx   #$FF90
         sta   >$0098
         sta   $08,x
         stb   >$0099
         stb   $09,x
         ldd   <$0082
         lsra  
         rorb  
         ror   <$0084
         lsra  
         rorb  
         ror   <$0084
         lsra  
         rorb  
         ror   <$0084
         clra  
         sta   >$009C
         sta   $0C,x
         stb   >$009D
         stb   $0D,x
         ldb   <$0084
         stb   >$009E
         stb   $0E,x
         ldb   #$00
         stb   >$009F
         stb   $0F,x
         ldb   $05,y
         leay  <$10,y
         ldb   b,y
         stb   >$009A
         bsr   L08CC
         stb   $0A,x
         ldx   #$FFB0
         lda   #$10
L08A5    ldb   ,y+
         bsr   L08CC
         stb   ,x+
         deca  
         bhi   L08A5
         puls  y
         ldd   <$003D
         std   <$005B
         ldd   <$003F
         std   <$005D
         lbsr  L1554
         lbra  L1521
L08BE    neg   <$0000
         suba  #$14
         suba  #$15
         suba  #$1D
         suba  #$1E
         com   <$0015
         com   <$0005
L08CC    pshs  x
         tst   >$1009
         bne   L08D9
         leax  >L08DB,pcr
         ldb   b,x
L08D9    puls  pc,x

L08DB    fdb   $3404,$d699,$c101,$2221
         fdb   $dcb7,$9397,$841f,$dd9b,$2717,$dcb7,$939b,$d3b7
         fdb   $1f01,$e6e4,$db99,$5a9d,$bc8d,$22dc,$9b93,$b5ed
         fdb   $059e,$b735,$049d,$bc96,$99a7,$0f4f,$3934

L090E    leau  $05,y
         puls  y,b
         pshs  y
         rti   
         leay  -$02,y
         pulu  y,x,dp,cc
         swi   
         fcb   $30 0
L091B    clrb  
         lsra  
         rorb  
         lsra  
         rorb  
L0920    lsra  
         rorb  
         std   <$0082
         clr   <$0084
         tfr   x,d
         suba  #$80
         addd  <$0083
         std   <$0083
         bcc   L0932
         inc   <$0082
L0932    rts   
         bsr   L0938
         lbra  L011D
L0938    ldd   <$0080
         addd  #$001F
         andb  #$E0
         std   <$0080
         ldb   <$0057
         cmpb  #$FF
         beq   L094F
         tst   <$0032
         beq   L094F
         bsr   L098E
         bcc   L0986
L094F    ldd   <$0080
         cmpd  #$2000
         bhi   L0961
         bsr   L09D6
         bcs   L0961
         lda   #$01
         sta   $0F,x
         bra   L0966
L0961    lbsr  L0A09
         bcs   L0985
L0966    stb   <$007D
         stx   <$007E
         lbsr  L0A60
         ldb   <$0057
         stb   $03,x
         ldb   <$0058
         stb   $04,x
         ldd   <$0080
         std   $05,x
         clra  
         clrb  
         std   $07,x
         std   $09,x
         stb   $0C,x
         stb   $0D,x
         stb   $0E,x
L0985    rts   
L0986    bra   L09CB
L0988    leax  >L09A2,pcr
         bra   L0992
L098E    leax  >L09AC,pcr
L0992    stx   <$00A1
         bsr   L09CF
         ldb   <$0032
         beq   L09CB
         ldx   <$0033
         bra   L09C4
L099E    jmp   [>$00A1,u]
L09A2    cmpb  <$11,y
         bne   L09BA
         cmpx  <$12,y
         bra   L09B8
L09AC    lda   <$0057
         cmpa  $03,x
         bne   L09BA
         lda   <$0058
         beq   L09C9
         cmpa  $04,x
L09B8    beq   L09C9
L09BA    stb   <$007D
         stx   <$007E
         ldb   ,x
         beq   L09CB
         ldx   $01,x
L09C4    lbsr  L0189
         bra   L099E
L09C9    clra  
         rts   
L09CB    comb  
         ldb   #$C2
         rts   
L09CF    clra  
         clrb  
         stb   <$007D
         std   <$007E
         rts   
L09D6    pshs  y,b
         ldy   <$0080
         leax  >L0B45,pcr
         stx   <$00A1
         lbsr  L0B32
         bcs   L0A07
         stb   ,s
         ldd   $05,x
         subd  <$0080
         bne   L09FC
         pshs  x
         lbsr  L0A80
         puls  x
         ldb   ,s
         lbsr  L0189
         bra   L0A06
L09FC    subd  #$0020
         std   $05,x
         leax  <$20,x
         leax  d,x
L0A06    clra  
L0A07    puls  pc,y,b
L0A09    ldd   <$0080
         addd  #$0020
         std   <$0097
         addd  #$1FFF
         lsra  
         lsra  
         lsra  
         lsra  
         lsra  
         tfr   a,b
         stb   <$0099
         lbsr  L019A
         bcs   L0A5F
         pshs  b
         ldb   <$0099
         cmpb  #$01
         bhi   L0A52
         ldd   #$2000
         subd  <$0097
         anda  #$1F
         std   <$009B
         beq   L0A52
         subd  #$0020
         ldd   #$2000
         subd  <$009B
         addd  #$2000
         tfr   d,x
         ldb   ,s
         addb  <$0099
         decb  
         lbsr  L0189
         bsr   L0A70
         ldd   <$009B
         subd  #$0020
         std   $05,x
L0A52    ldx   #$2000
         puls  b
         lbsr  L0189
         lda   <$0099
         sta   $0F,x
         clra  
L0A5F    rts   
L0A60    pshs  b,a
         lda   <$0032
         sta   ,x
         stb   <$0032
         ldd   <$0033
         std   $01,x
         stx   <$0033
         puls  pc,b,a
L0A70    pshs  b,a
         lda   <$0035
         sta   ,x
         stb   <$0035
         ldd   <$0036
         std   $01,x
         stx   <$0036
         puls  pc,b,a
L0A80    pshs  y,a
         lda   ,x
         ldy   $01,x
         ldx   <$007E
         ldb   <$007D
         bne   L0A94
         sta   <$0035
         sty   <$0036
         bra   L0A9C
L0A94    lbsr  L0189
         sta   ,x
         sty   $01,x
L0A9C    puls  pc,y,a
         ldb   #$01
         stb   <$0097
L0AA2    lbsr  L098E
         bcs   L0AB1
         clr   <$0097
         bsr   L0AB9
         bcs   L0AB6
         ldb   <$0058
         beq   L0AA2
L0AB1    lda   <$0097
         bne   L0AB6
         clrb  
L0AB6    lbra  L011D
L0AB9    pshs  y,x,b
         lda   $0F,x
         sta   <$009F
         lda   ,x
         ldy   $01,x
         ldb   <$007D
         bne   L0ACF
         sta   <$0032
         sty   <$0033
         bra   L0AD9
L0ACF    lbsr  L0189
         ldx   <$007E
         sta   ,x
         sty   $01,x
L0AD9    ldb   ,s
         lda   <$009F
         cmpa  #$01
         bgt   L0B03
         tfr   b,a
         bsr   L0B0D
         bcc   L0AF9
         leax  >L0B59,pcr
         stx   <$00A1
         ldx   $01,s
         bsr   L0B32
         lbsr  L0189
         lbsr  L0A70
         bra   L0B0B
L0AF9    leax  >L0B83,pcr
         stx   <$00A1
         ldx   $01,s
         bsr   L0B32
L0B03    clra  
         tfr   d,x
         ldb   <$009F
         lbsr  L01A8
L0B0B    puls  pc,y,x,b
L0B0D    pshs  x,b
         ldb   <$0032
         beq   L0B2C
         cmpa  <$0032
         beq   L0B2F
         ldx   <$0033
         bra   L0B27
L0B1B    cmpa  ,x
         beq   L0B2F
         tst   ,x
         beq   L0B2C
         ldb   ,x
         ldx   $01,x
L0B27    lbsr  L0189
         bra   L0B1B
L0B2C    clrb  
         puls  pc,x,b
L0B2F    comb  
         puls  pc,x,b
L0B32    pshs  u,x,b,a
L0B34    lbsr  L09CF
         ldb   <$0035
         beq   L0B98
         ldx   <$0036
         bra   L0B91
L0B3F    ldu   $04,s
         jmp   [>$00A1,u]
L0B45    cmpy  $05,x
         bhi   L0B87
         bra   L0B9B
L0B4C    tfr   u,d
         addd  $05,u
         addd  #$0020
         stx   ,--s
         cmpd  ,s++
         rts   
L0B59    cmpb  $01,s
         bne   L0B87
         ldu   $02,s
         ldb   ,x
         stb   ,u
         ldd   $01,x
         std   $01,u
         exg   x,u
         bsr   L0B4C
         beq   L0B73
         exg   x,u
         bsr   L0B4C
         bne   L0B87
L0B73    stu   $02,s
         ldd   $05,u
         addd  $05,x
         addd  #$0020
         std   $05,u
L0B7E    lbsr  L0A80
         bra   L0B34
L0B83    cmpb  ,s
         beq   L0B7E
L0B87    stb   <$007D
         stx   <$007E
         ldb   ,x
         beq   L0B98
         ldx   $01,x
L0B91    ldu   $04,s
         lbsr  L0189
         bra   L0B3F
L0B98    comb  
         puls  pc,u,x,b,a
L0B9B    stb   $01,s
         stx   $02,s
         clrb  
         puls  pc,u,x,b,a
         lbsr  L098E
         bcs   L0BB5
         pshs  b
         ldd   <$1F,y
         cmpd  $05,x
         bhi   L0BDA
         puls  b
         bra   L0BC3
L0BB5    ldd   <$1F,y
         std   <$0080
         lbsr  L0938
         lbcs  L0C4A
         ldb   <$007D
L0BC3    stb   <$21,y
         clra  
         clrb  
         std   <$0047
         ldb   <$0060
         lbsr  L0C8E
         lbsr  L0CD1
         leax  <$20,x
         stx   <$22,y
         bra   L0C44
L0BDA    bra   L0C47
         pshs  y
         ldb   <$21,y
         stb   <$0097
         lbsr  L0189
         ldx   <$22,y
         leay  >$0100,u
L0BED    ldb   ,y+
         stb   ,x+
         deca  
         beq   L0C05
         cmpx  #$4000
         bcs   L0BED
         inc   <$0097
         ldb   <$0097
         lbsr  L0189
         ldx   #$2000
         bra   L0BED
L0C05    puls  y
         ldb   <$0097
         stb   <$21,y
         stx   <$22,y
         bra   L0C44
         lbsr  L1E29
         bcs   L0C4A
         lbsr  L1E34
         bcs   L0C4A
         lbsr  L0184
         bsr   L0C6E
         lbsr  L098E
         bcc   L0C2C
         lbsr  L0938
         bcc   L0C37
         bra   L0C4A
L0C2C    stb   <$007D
         stx   <$007E
         ldd   <$0080
         cmpd  $05,x
         bhi   L0C47
L0C37    lbsr  L0CD1
         lbsr  L1ED4
         stx   <$0072
         ldx   <$007E
         lbsr  L0CED
L0C44    clrb  
         bra   L0C4A
L0C47    comb  
         ldb   #$BF
L0C4A    lbra  L011D
L0C4D    ldd   -$0D,y
         std   <$0072
         bsr   L0C6E
         ldd   #$FFFF
         std   <$0057
         lbsr  L0938
         bcs   L0C6D
         ldb   <$007D
         stb   <$11,y
         ldd   <$007E
         std   <$12,y
         bsr   L0CD1
         lbsr  L0CED
         clrb  
L0C6D    rts   
L0C6E    pshs  x
         ldb   <$0060
         bpl   L0C7B
         ldd   <$004F
         lslb  
         stb   <$0009
         bra   L0C7D
L0C7B    bsr   L0C8E
L0C7D    ldb   <$0009
         ldx   <$0051
         lbsr  L1EA9
         std   <$0080
         ldb   <$0063
         subb  <$0009
         stb   <$000A
         puls  pc,x
L0C8E    cmpb  #$04
         bne   L0C96
         ldb   #$01
         bra   L0CA0
L0C96    cmpb  #$01
         beq   L0C9E
         ldb   #$03
         bra   L0CA0
L0C9E    ldb   #$07
L0CA0    stb   <$0097
         ldb   <$0048
         comb  
         andb  <$0097
         incb  
         stb   <$0006
         clra  
         cmpd  <$004F
         bge   L0CBB
         ldb   <$0050
         subb  <$0006
         andb  <$0097
         bne   L0CBB
         ldb   <$0097
         incb  
L0CBB    stb   <$0007
         clra  
         ldb   <$0048
         andb  <$0097
         addd  <$004F
         addb  <$0097
         adca  #$00
L0CC8    lsra  
         rorb  
         lsr   <$0097
         bne   L0CC8
         stb   <$0009
         rts   
L0CD1    ldd   <$004F
         std   $07,x
         ldd   <$0051
         std   $09,x
         ldb   <$0060
         stb   $0E,x
         ldb   <$0006
         stb   $0C,x
         ldb   <$0007
         stb   $0D,x
         ldb   <$0009
         stb   $0B,x
         clra  
         std   <$004F
         rts   
L0CED    pshs  y
         leay  <$20,x
         ldx   <$0072
L0CF4    lda   <$0050
L0CF6    ldb   ,x+
         stb   ,y+
         cmpy  #$4000
         bcs   L0D0B
         inc   <$007D
         ldb   <$007D
         lbsr  L0189
         ldy   #$2000
L0D0B    deca  
         bne   L0CF6
         ldb   <$000A
         abx   
         dec   <$0052
         bne   L0CF4
         puls  pc,y
         lbsr  L0184
         lbsr  L098E
         bcs   L0D46
         stb   <$007D
         stx   <$007E
         ldd   $07,x
         std   <$004F
         ldd   $09,x
         std   <$0051
         lbsr  L1E29
         bcs   L0D46
         lbsr  L1E34
         bcs   L0D46
         lbsr  L1ED4
         stx   <$0072
         stb   <$0074
         ldy   <$007E
         lbsr  L0E2B
         lbsr  L0EC4
         clrb  
L0D46    lbra  L011D
L0D49    pshs  y
         leax  >L1FDE,pcr
         stx   <$0064
         leax  >L1FE9,pcr
         stx   <$0068
         ldd   -$0D,y
         std   <$0072
         clra  
         clrb  
         std   <$0047
         ldy   <$007E
         bsr   L0D71
         bcs   L0D6C
         lbsr  L0DF0
         clrb  
         puls  pc,y
L0D6C    comb  
         ldb   #$BE
         puls  pc,y
L0D71    pshs  x
         ldb   <$0060
         cmpb  $0E,y
         bne   L0DA9
         tstb  
         bpl   L0D84
         ldb   #$FF
         stb   <$0000
         stb   <$0001
         bra   L0D9E
L0D84    leax  >L0DB6,pcr
         lda   <$0048
         coma  
         anda  b,x
         inca  
         cmpa  $0C,y
         bne   L0DA9
         bsr   L0DAC
         sta   <$0000
         ldb   $0E,y
         lda   $0D,y
         bsr   L0DAC
         sta   <$0001
L0D9E    bsr   L0DE7
         ldb   <$0063
         subb  <$0050
         stb   <$0097
         clrb  
         puls  pc,x
L0DA9    comb  
         puls  pc,x
L0DAC    leax  >L0DBB,pcr
         ldb   b,x
         abx   
         lda   a,x
         rts   
L0DB6    neg   <$0007
         com   <$0003
         oim   #$00,<$0005
         jmp   <$000E
         sync  
         neg   <$0001
         com   <$0007
         clr   <$001F
         swi   
         fcb   $7F ÿ
         stu   >$0003
         clr   <$003F
         stu   >$000F
         stu   >$0005
         jmp   <$000E
         sync  
         neg   <$0080
         subb  #$E0
         subb  >$F8FC
         ldu   >$FF00
         subb  #$F0
         ldd   >$FF00
         subb  >$FFE6
         bmi   L0DC1
         negb  
         ldb   $0A,y
         stb   <$0052
         rts   
L0DF0    pshs  y
         leay  <$20,y
         ldx   <$0072
L0DF7    ldb   <$0050
         stb   <$0099
L0DFB    ldb   <$0099
         cmpb  <$0050
         bne   L0E05
         ldb   <$0000
         bra   L0E0F
L0E05    cmpb  #$01
         bne   L0E0D
         ldb   <$0001
         bra   L0E0F
L0E0D    ldb   #$FF
L0E0F    lda   ,y+
         lbsr  L1F9B
         leax  $01,x
         cmpy  #$4000
         bcs   L0E1E
         bsr   L0E9C
L0E1E    dec   <$0099
         bne   L0DFB
         ldb   <$0097
         abx   
         dec   <$0052
         bne   L0DF7
         puls  pc,y
L0E2B    pshs  y
         ldd   <$006A
         subd  <$0047
         addd  #$0001
         std   <$009B
         ldb   <$006D
         subb  <$004A
         bra   L0E57
L0E3C    pshs  y
         lda   <$0060
         anda  #$01
         beq   L0E49
         ldd   #$027F
         bra   L0E4C
L0E49    ldd   #$013F
L0E4C    subd  <$003D
         addd  #$0001
         std   <$009B
         ldb   #$BF
         subb  <$0040
L0E57    incb  
         stb   <$00A0
         lbsr  L1F2B
         bsr   L0DE7
         ldb   $0C,y
         stb   <$0006
         ldb   $0D,y
         stb   <$0007
         leax  >L07A1,pcr
         ldb   <$0060
         ldb   b,x
         abx   
         lda   ,x+
         stx   <$0002
         leax  >L0EA8,pcr
         ldb   $0E,y
         ldb   b,x
         abx   
         ldb   ,x
         leay  b,x
         sty   <$00A3
         anda  $01,x
         sta   <$0008
         ldb   $02,x
         stb   <$0005
         ldb   <$0006
         addb  #$02
         ldb   b,x
         leay  b,x
         sty   <$00A1
         sty   <$00A5
         puls  pc,y
L0E9C    inc   <$007D
         ldb   <$007D
         lbsr  L0189
         ldy   #$2000
         rts   
L0EA8    neg   <$0005
         fcb   $10 
         fcb   $10 
         lbsr  L6FB0
         lsl   <$0062
         fcb   $5B [
         incb  
         tstb  
         fcb   $5E ^
         clrb  
         neg   $01,s
         fcb   $55 U
         com   <$0004
         asrb  
         fcb   $51 Q
         comb  
         fcb   $55 U
         inca  
         clr   <$0002
         negb  
         inca  
L0EC4    leay  <$20,y
         pshs  y
         ldx   <$0072
L0ECB    stx   <$0072
         ldd   <$009B
         std   <$009D
         lda   <$0050
         sta   <$0004
         ldb   <$0006
         stb   <$0097
         ldd   <$00A5
         std   <$00A1
         ldb   <$0074
L0EDF    ldy   ,s
         cmpy  #$4000
         bcs   L0EEE
         stb   <$0099
         bsr   L0E9C
         ldb   <$0099
L0EEE    lda   ,y+
         sty   ,s
         ldy   <$0002
         pshs  y
         leay  >L0F0F,pcr
         cmpy  <$00A1
         puls  y
         beq   L0F04
         lsla  
L0F04    jmp   [>$00A1,u]
         rola  
         rola  
         rola  
         rola  
         rola  
         rola  
         rola  
L0F0F    pshs  b,a,cc
         ldd   <$009D
         beq   L0F28
         subd  #$0001
         std   <$009D
         ldd   $01,s
         anda  <$0008
         lda   a,y
         lbsr  L1F9B
         lbsr  L1F4B
         stb   $02,s
L0F28    dec   <$0097
         beq   L0F32
         puls  b,a,cc
         jmp   [>$00A3,u]
L0F32    leas  $03,s
         dec   <$0004
         beq   L0F4E
         lda   <$0004
         cmpa  #$01
         beq   L0F42
         lda   <$0005
         bra   L0F44
L0F42    lda   <$0007
L0F44    sta   <$0097
         ldy   <$00A3
         sty   <$00A1
         bra   L0EDF
L0F4E    ldx   <$0072
         ldb   <$0063
         abx   
         dec   <$00A0
         beq   L0F5D
         dec   <$0052
         lbne  L0ECB
L0F5D    puls  pc,y
         lbsr  L098E
         bcs   L0FA7
         stb   <$0097
         ldb   $0F,x
         stb   <$0099
         ldd   $05,x
         std   <$009B
         leax  <$20,x
         tfr   x,d
         anda  #$1F
         std   <$009D
         bra   L0FA6
         lbsr  L0184
         tsta  
         bpl   L0F99
         cmpa  #$BF
         bhi   L0F8F
         anda  #$EF
         suba  #$90
         cmpa  #$1A
         bcc   L0F99
L0F8B    lda   #$2E
         bra   L0F99
L0F8F    anda  #$DF
         suba  #$C1
         bmi   L0F8B
         cmpa  #$19
         bhi   L0F8B
L0F99    ldb   <$0060
         bpl   L0FA1
         bsr   L0FAA
         bra   L0FA3
L0FA1    bsr   L0FDC
L0FA3    lbsr  L1284
L0FA6    clrb  
L0FA7    lbra  L011D
L0FAA    cmpa  #$60
         bne   L0FB0
         lda   #$27
L0FB0    cmpa  #$5F
         bne   L0FB6
         lda   #$7F
L0FB6    cmpa  #$5E
         bne   L0FBC
         lda   #$60
L0FBC    ldx   -$05,y
         tst   $09,y
         bmi   L0FD0
         ldb   $01,x
         andb  #$07
         stb   $01,x
         ldb   $08,y
         andb  #$F8
         orb   $01,x
         bra   L0FD2
L0FD0    ldb   $08,y
L0FD2    std   ,x
         ldd   #$0001
         std   <$006E
         std   <$0070
         rts   
L0FDC    pshs  y,a
         ldb   $09,y
         stb   <$000E
         bitb  #$04
         beq   L0FEC
         ldd   <$0061
         exg   a,b
         std   <$0061
L0FEC    bsr   L1031
         bcs   L0FFA
         lda   ,s
         ldb   $0B,x
         mul   
         cmpd  $05,x
         bcs   L1000
L0FFA    leax  >L1029,pcr
         bra   L1005
L1000    addd  #$0020
         leax  d,x
L1005    ldb   <$0060
         cmpb  #$01
         bne   L101B
         ldb   <$006F
         cmpb  #$08
         bne   L101B
         ldb   <$000E
         bitb  #$10
         bne   L101B
         bsr   L105E
         bra   L1027
L101B    leay  >L110F,pcr
         sty   <$00A9
         ldy   $01,s
         bsr   L109C
L1027    puls  pc,y,a
L1029    neg   <$0000
         neg   <$0000
         neg   <$0000
         fcb   $10 
         neg   <$0034
         aim   #$D6,<$0060
         bpl   L1040
         ldd   #$0001
         std   <$006E
         std   <$0070
         bra   L105C
L1040    ldb   $0B,y
         bne   L104E
         ldd   #$0008
         std   <$006E
         std   <$0070
         comb  
         bra   L105C
L104E    lbsr  L0189
         ldx   $0C,y
         ldd   $07,x
         std   <$006E
         ldd   $09,x
         std   <$0070
         clrb  
L105C    puls  pc,a
L105E    ldy   -$05,y
         exg   x,y
         lda   <$0071
         deca  
         sta   <$0097
L1068    lda   ,y+
         ldb   <$000E
         bitb  #$20
         beq   L1073
         lsra  
         ora   -$01,y
L1073    tfr   a,b
         coma  
         tst   <$000E
         bmi   L107E
         anda  ,x
         bra   L1080
L107E    anda  <$0062
L1080    sta   ,x
         andb  <$0061
         orb   ,x
         stb   ,x
         ldb   <$0063
         abx   
         dec   <$0097
         bmi   L109B
         bne   L1068
         ldb   <$000E
         bitb  #$40
         beq   L1068
         lda   #$FF
         bra   L1073
L109B    rts   
L109C    pshs  x
         leax  >L10FF,pcr
         stx   <$0010
         ldx   ,s
         ldb   <$000E
         bitb  #$10
         beq   L10D4
         ldb   <$0071
         decb  
         clra  
L10B0    ora   b,x
         decb  
         bpl   L10B0
         tsta  
         bne   L10BC
         lsr   <$006F
         bra   L10D4
L10BC    ldb   #$FF
L10BE    incb  
         lsla  
         bcc   L10BE
         leax  >L1151,pcr
         ldb   b,x
         leax  b,x
         stx   <$0010
         ldb   #$01
L10CE    incb  
         lsla  
         bcs   L10CE
         stb   <$006F
L10D4    puls  x
         ldb   -$03,y
         stb   <$000F
         ldy   -$05,y
         exg   x,y
         lda   <$0071
         deca  
         sta   <$0099
         stx   <$000C
         lbsr  L1F2B
         ldx   <$000C
L10EB    lda   ,y+
         ldb   <$000E
         bitb  #$20
         beq   L10F6
         lsra  
         ora   -$01,y
L10F6    jmp   [<$10,u]
         lsla  
         lsla  
         lsla  
         lsla  
         lsla  
         lsla  
L10FF    sta   <$000B
L1101    lda   <$006F
         sta   <$0097
         ldb   <$000F
         stx   <$000C
L1109    pshs  b
         jmp   [>$00A9,u]
L110F    lsl   <$000B
         bcs   L111B
L1113    lda   <$000E
         bpl   L112E
         lda   <$0062
         bra   L111D
L111B    lda   <$0061
L111D    comb  
         andb  ,x
         stb   ,x
         anda  ,s
         ora   ,x
         sta   ,x
         bra   L112E
L112A    eorb  ,x
         stb   ,x
L112E    dec   <$0097
         beq   L1139
         puls  b
         lbsr  L1F4B
         bra   L1109
L1139    puls  b
         ldx   <$000C
         ldb   <$0063
         abx   
         dec   <$0099
         bmi   L1150
         bne   L10EB
         lda   <$000E
         bita  #$40
         beq   L10EB
         lda   #$FF
         bra   L10FF
L1150    rts   
L1151    ldx   w,y
         jsr   <L1101,pcr
         ora   >-$5756,y
         lbsr  L0184
         lbsr  L1031
         bsr   L1164
         bra   L11C0
L1164    cmpa  #$01
         lbeq  L124B
         cmpa  #$08
         lbeq  L1263
         cmpa  #$06
         lbeq  L1284
         cmpa  #$09
         lbeq  L1299
         cmpa  #$0A
         lbeq  L12A4
         cmpa  #$0D
         lbeq  L12B9
         cmpa  #$03
         lbeq  L13C3
         cmpa  #$04
         lbeq  L13D0
         cmpa  #$0B
         lbeq  L13FE
         cmpa  #$0C
         lbeq  L13E8
         rts   
         lbsr  L0184
         lbsr  L1031
         bsr   L11AB
         bra   L11C0
L11AB    cmpa  #$20
         lbeq  L1511
         cmpa  #$21
         lbeq  L1509
         rts   
         lbsr  L0184
         lbsr  L1031
         bsr   L11C3
L11C0    lbra  L1521
L11C3    cmpa  #$20
         lbeq  L14B9
         cmpa  #$21
         lbeq  L14D5
         cmpa  #$22
         lbeq  L14E1
         cmpa  #$23
         lbeq  L14EE
         cmpa  #$24
         lbeq  L14FB
         cmpa  #$25
         lbeq  L1502
         cmpa  #$30
         lbeq  L1302
         cmpa  #$31
         lbeq  L1336
         rts   
         lbsr  L0184
         lbsr  L1031
         clra  
         ldb   <$0047
         subd  #$0020
         tfr   d,x
         ldb   <$006F
         lbsr  L1EA9
         std   <$0047
         addd  <$006E
         subd  #$0001
         cmpd  <$1B,y
         bhi   L1238
         clra  
         ldb   <$0049
         subd  #$0020
         tfr   d,x
         ldb   <$0071
         lbsr  L1EA9
         std   <$0049
         addd  <$0070
         subd  #$0001
         cmpd  <$1D,y
         bhi   L1238
         ldd   <$0047
         std   -$02,y
         ldd   <$0049
         std   ,y
         bsr   L123B
L1238    lbra  L1521
L123B    ldd   -$02,y
         std   <$0047
         ldd   ,y
         std   <$0049
         lbsr  L1ED4
         stx   -$05,y
         stb   -$03,y
         rts   
L124B    clra  
         clrb  
         std   -$02,y
         std   ,y
         ldd   -$0D,y
         std   -$05,y
         leax  >L1F3B,pcr
         ldb   <$0060
         bmi   L1262
         lslb  
         ldb   b,x
         stb   -$03,y
L1262    rts   
L1263    ldd   -$02,y
         subd  <$006E
         std   -$02,y
         bpl   L123B
         ldd   <$1B,y
         subd  <$006E
         addd  #$0001
         std   -$02,y
         ldd   ,y
         subd  <$0070
         std   ,y
         bpl   L123B
         clra  
         clrb  
         std   -$02,y
         std   ,y
         rts   
L1284    ldd   -$02,y
         addd  <$006E
         std   -$02,y
         addd  <$006E
         subd  #$0001
         cmpd  <$1B,y
         bls   L123B
         bsr   L12B9
         bra   L12A4
L1299    ldd   ,y
         subd  <$0070
         bmi   L12A3
         std   ,y
         bsr   L123B
L12A3    rts   
L12A4    ldd   ,y
         addd  <$0070
         tfr   d,x
         addd  <$0070
         subd  #$0001
         cmpd  <$1D,y
         bhi   L12C0
         stx   ,y
         bra   L123B
L12B9    clra  
         clrb  
         std   -$02,y
         lbra  L123B
L12C0    pshs  y
         ldb   $02,y
         lbsr  L13AE
         std   <$0097
         clra  
         ldb   <$0063
         std   <$0099
         ldd   ,y
         std   <$009D
         lda   -$08,y
         deca  
         sta   <$009B
         beq   L12FB
         ldx   -$0D,y
         ldd   $04,y
         tfr   x,y
         leax  d,x
         tst   <$0060
         bmi   L12EC
         lda   <$009B
         lsla  
         lsla  
         lsla  
         sta   <$009B
L12EC    ldd   <$0097
         lbsr  L137B
         ldd   <$0099
         leax  d,x
         leay  d,y
         dec   <$009B
         bne   L12EC
L12FB    puls  y
         ldd   <$009D
L12FF    lbra  L13C5
L1302    pshs  y
         ldd   ,y
         std   <$009D
         ldb   $02,y
         lbsr  L13AE
         std   <$0097
         clra  
         ldb   <$0063
         nega  
         negb  
         sbca  #$00
         std   <$0099
         ldb   -$08,y
         decb  
         lda   <$0071
         mul   
         tfr   b,a
         deca  
         subb  $01,y
         cmpb  <$0071
         bcs   L12FB
         stb   <$009B
         ldb   <$0063
         mul   
         addd  -$0D,y
         tfr   d,x
         addd  $04,y
         tfr   d,y
         bra   L12EC
L1336    pshs  y
         ldb   $02,y
         bsr   L13AE
         std   <$0097
         clra  
         ldb   <$0063
         std   <$0099
         lda   -$08,y
         deca  
         tst   <$0060
         bmi   L134D
         lsla  
         lsla  
         lsla  
L134D    suba  $01,y
         bhi   L1357
         puls  y
         ldd   ,y
         bra   L12FF
L1357    sta   <$009B
         ldd   <$1D,y
         subd  <$0070
         addd  #$0001
         std   <$009D
         lda   <$0063
         ldb   $01,y
         mul   
         addd  -$0D,y
         tfr   d,x
         ldd   $04,y
         tfr   x,y
         leax  d,x
         lbra  L12EC
         pshs  u,y,x,dp,cc
         bsr   L13AE
         bra   L137D
L137B    pshs  u,y,x,dp,cc
L137D    pshs  a
         tstb  
         beq   L1389
L1382    lda   ,x+
         sta   ,y+
         decb  
         bne   L1382
L1389    puls  b
         tstb  
         beq   L13AC
         orcc  #$50
         stb   >$1006
         sts   >$1003
         tfr   x,u
         tfr   y,s
         leas  $07,s
L139D    pulu  y,x,dp,b,a
         pshs  y,x,dp,b,a
         leas  $0E,s
         dec   >$1006
         bne   L139D
         lds   >$1003
L13AC    puls  pc,u,y,x,dp,cc
L13AE    tfr   b,a
         lsra  
         lsra  
         lsra  
         andb  #$07
         pshs  a
         addb  ,s+
L13B9    cmpb  #$07
         blt   L13C2
         subb  #$07
         inca  
         bra   L13B9
L13C2    rts   
L13C3    ldd   ,y
L13C5    std   <$0049
         clra  
         clrb  
         std   <$0047
         ldd   <$1B,y
         bra   L13DD
L13D0    ldd   -$02,y
         std   <$0047
         ldd   ,y
         std   <$0049
         ldd   <$1B,y
         subd  -$02,y
L13DD    addd  #$0001
         std   <$004F
         ldd   <$0070
         std   <$0051
         bra   L1420
L13E8    lbsr  L124B
         clra  
         clrb  
         std   <$0047
         std   <$0049
         ldd   <$1B,y
         addd  #$0001
         std   <$004F
         ldd   <$1D,y
         bra   L1419
L13FE    bsr   L13D0
         clra  
         clrb  
         std   <$0047
         ldd   ,y
         addd  <$0070
         std   <$0049
         ldd   <$1B,y
         addd  #$0001
         std   <$004F
         ldd   <$1D,y
         subd  <$0049
         ble   L142A
L1419    addd  #$0001
         std   <$0051
         bra   L1420
L1420    ldb   <$0060
         bpl   L1428
         bsr   L142B
         bra   L142A
L1428    bsr   L1456
L142A    rts   
L142B    pshs  y
         lbsr  L1ED4
         lda   #$20
         ldb   $08,y
         andb  #$38
         orb   <$0062
         std   <$0097
         ldb   <$0063
         subb  <$0050
         subb  <$0050
         stb   <$0099
L1442    ldy   <$004F
         ldd   <$0097
L1447    std   ,x++
         leay  -$01,y
         bne   L1447
         ldb   <$0099
         abx   
         dec   <$0052
         bne   L1442
         puls  pc,y
L1456    ldb   <$0060
         leax  >L0DB6,pcr
         lda   <$0048
         coma  
         anda  b,x
         inca  
         sta   <$0097
         leax  >L0DBB,pcr
         ldb   b,x
         abx   
         lda   a,x
         sta   <$0012
         clra  
         ldb   <$0060
         tfr   d,x
         ldd   <$004F
         subb  <$0097
         sbca  #$00
         lsra  
         rorb  
         cmpx  #$0004
         beq   L148A
         lsra  
         rorb  
         cmpx  #$0001
         bne   L148A
         lsra  
         rorb  
L148A    stb   <$0097
         ldb   <$0063
         subb  <$0097
         subb  #$01
         stb   <$0099
         lbsr  L1ED4
L1497    lda   <$0012
         tfr   a,b
         coma  
         anda  ,x
         sta   ,x
         andb  <$0062
         orb   ,x
         stb   ,x+
         lda   <$0097
         beq   L14B1
         ldb   <$0062
L14AC    stb   ,x+
         deca  
         bne   L14AC
L14B1    ldb   <$0099
         abx   
         dec   <$0052
         bne   L1497
         rts   
L14B9    ldb   $09,y
         bitb  #$04
         bne   L14D4
         orb   #$04
         stb   $09,y
L14C3    lda   $08,y
         lbsr  L15CC
         pshs  b,a
         ldb   $08,y
         andb  #$C0
         orb   ,s+
         orb   ,s+
         stb   $08,y
L14D4    rts   
L14D5    ldb   $09,y
         bitb  #$04
         beq   L14D4
         andb  #$FB
         stb   $09,y
         bra   L14C3
L14E1    ldb   $08,y
         orb   #$40
         stb   $08,y
         ldb   $09,y
         orb   #$40
         stb   $09,y
         rts   
L14EE    ldb   $08,y
         andb  #$BF
         stb   $08,y
         ldb   $09,y
         andb  #$BF
         stb   $09,y
         rts   
L14FB    ldb   $08,y
         orb   #$80
         stb   $08,y
         rts   
L1502    ldb   $08,y
         andb  #$7F
         stb   $08,y
         rts   
L1509    ldb   $09,y
         andb  #$FD
         stb   $09,y
         bra   L157C
L1511    ldb   $09,y
         orb   #$02
         stb   $09,y
         bra   L1593
         lbsr  L0130
         bsr   L157C
         lbsr  L15D9
L1521    clrb  
         lbra  L011D
L1525    pshs  y,x,b,a
         bsr   L1593
         lbsr  L15FC
         ldb   >$1000
         stb   >$1001
         puls  pc,y,x,b,a
         lbsr  L0130
         cmpy  <$002E
         bne   L1552
         ldd   <$005B
         cmpd  <$003D
         bne   L154A
         ldd   <$005D
         cmpd  <$003F
         beq   L1552
L154A    lbsr  L15FC
         bsr   L1554
         lbsr  L15D9
L1552    bra   L1521
L1554    ldd   <$0047
         pshs  b,a
         ldd   <$0049
         pshs  b,a
         ldd   <$005B
         std   <$0047
         std   <$003D
         ldd   <$005D
         std   <$0049
         std   <$003F
         ldx   -$10,y
         ldd   $02,x
         lbsr  L1ED6
         stx   <$0041
         stb   <$0043
         puls  b,a
         std   <$0049
         puls  b,a
         std   <$0047
         rts   
L157C    lbsr  L1031
         cmpy  <$002E
         bne   L1592
         ldb   $09,y
         bitb  #$02
         bne   L1592
         ldb   <$0039
         bne   L1592
         bsr   L15A4
         inc   <$0039
L1592    rts   
L1593    lbsr  L1031
         cmpy  <$002E
         bne   L15A3
         ldb   <$0039
         beq   L15A3
         bsr   L15A4
         clr   <$0039
L15A3    rts   
L15A4    pshs  y
         ldx   -$05,y
         ldb   <$0060
         bpl   L15BE
         lda   $01,x
         bsr   L15CC
         pshs  b,a
         ldb   $01,x
         andb  #$C0
         orb   ,s+
         orb   ,s+
         stb   $01,x
         bra   L15CA
L15BE    leax  >L112A,pcr
         stx   <$00A9
         clrb  
         stb   <$000E
         lbsr  L109C
L15CA    puls  pc,y
L15CC    tfr   a,b
         anda  #$38
         lsra  
         lsra  
         lsra  
         andb  #$07
         lslb  
         lslb  
         lslb  
         rts   
L15D9    pshs  y,x
         ldx   -$10,y
         cmpx  <$0030
         bne   L15FA
         ldb   <$003A
         bne   L15FA
         ldb   <$18,y
         stb   <$0044
         beq   L15FA
         lbsr  L0189
         ldy   <$19,y
         sty   <$0045
         bsr   L1618
         inc   <$003A
L15FA    puls  pc,y,x
L15FC    pshs  y,x
         ldx   -$10,y
         cmpx  <$0030
         bne   L1616
         ldb   <$003A
         beq   L1616
         ldb   <$0044
         beq   L15FA
         lbsr  L0189
         ldy   <$0045
         bsr   L1618
         clr   <$003A
L1616    puls  pc,y,x
L1618    ldb   <$0060
         bmi   L164E
         ldd   <$004F
         ldx   <$0051
         pshs  x,b,a
         ldd   <$0064
         ldx   <$0068
         pshs  x,b,a
         ldd   <$0041
         std   <$0072
         ldb   <$0043
         stb   <$0074
         leax  >L1FDE,pcr
         stx   <$0064
         leax  >L1FE3,pcr
         stx   <$0068
         lbsr  L0E3C
         lbsr  L0EC4
         puls  x,b,a
         std   <$0064
         stx   <$0068
         puls  x,b,a
         std   <$004F
         stx   <$0051
L164E    rts   
         lbsr  L1E29
         bcs   L16A1
         ldb   $0E,y
         beq   L165B
         lbsr  L0189
L165B    lbsr  L0184
         ldb   <$0060
         lbmi  L05A2
         lbsr  L1ED4
         lda   <$0061
         lbsr  L1F9B
         bra   L16A0
         lbsr  L0184
         ldb   <$0060
         lbmi  L05A2
         ldb   $0E,y
         beq   L167E
         lbsr  L0189
L167E    lbsr  L1E29
         bcs   L16A1
         lbsr  L1E30
         bcs   L16A1
         ldd   <$0049
         cmpd  <$004D
         bne   L1693
         bsr   L16A4
         bra   L16A0
L1693    ldd   <$0047
         cmpd  <$004B
         bne   L169E
         bsr   L16EC
         bra   L16A0
L169E    bsr   L171C
L16A0    clrb  
L16A1    lbra  L011D
L16A4    bsr   L16BC
L16A6    ldd   <$004B
         subd  <$0047
         addd  #$0001
         std   <$0099
         lbsr  L1F2B
         lbsr  L1ED4
         lda   <$0061
         ldy   <$0099
         bra   L16CA
L16BC    ldd   <$004B
         cmpd  <$0047
         bge   L16C9
L16C3    ldx   <$0047
         std   <$0047
         stx   <$004B
L16C9    rts   
L16CA    leas  -$02,s
         pshs  x,b,a
         leax  >L16E7,pcr
         ldb   <$0060
         clra  
         ldb   b,x
         std   $04,s
         puls  x,b,a
L16DB    lbsr  L1F9B
         lbsr  L1F45
         leay  -$01,y
         bne   L16DB
         puls  pc,b,a
L16E7    neg   <$0008
         lsr   <$0004
         aim   #$8D,<$0020
L16EE    ldd   <$004D
         subb  <$004A
         incb  
         std   <$0099
         lbsr  L1ED4
         stb   <$0097
         lda   <$0061
         ldy   <$0099
L16FF    ldb   <$0097
         lbsr  L1F9B
         ldb   <$0063
         abx   
         inc   <$004A
         leay  -$01,y
         bne   L16FF
         rts   
L170E    ldd   <$004D
         cmpd  <$0049
         bge   L171B
L1715    ldx   <$0049
         std   <$0049
         stx   <$004D
L171B    rts   
L171C    ldd   <$004B
         cmpd  <$0047
         bge   L172B
         bsr   L16C3
         ldd   <$004D
         bsr   L1715
         ldd   <$004B
L172B    subd  <$0047
         std   <$0013
         ldb   <$0063
         clra  
         std   <$0017
         ldd   <$004D
         subd  <$0049
         std   <$0015
         bpl   L174A
         nega  
         negb  
         sbca  #$00
         std   <$0015
         ldd   <$0017
         nega  
         negb  
         sbca  #$00
         std   <$0017
L174A    ldd   #$0000
         std   <$0075
         lbsr  L1F2B
         lbsr  L1ED4
         stb   <$0074
L1757    ldb   <$0074
         lda   <$0061
         lbsr  L1F9B
         ldd   <$0075
         bpl   L1774
         addd  <$0013
         std   <$0075
         ldd   <$0017
         leax  d,x
         bmi   L1770
         inc   <$004A
         bra   L177F
L1770    dec   <$004A
         bra   L177F
L1774    subd  <$0015
         std   <$0075
         ldb   <$0074
         lbsr  L1F45
         stb   <$0074
L177F    ldd   <$0047
         cmpd  <$004B
         ble   L1757
         rts   
         lbsr  L0184
         ldb   <$0060
         lbmi  L05A2
         ldb   $0E,y
         beq   L1797
         lbsr  L0189
L1797    lbsr  L1E29
         bcs   L17F0
         lbsr  L1E30
         bcs   L17F0
         lbsr  L16BC
         lbsr  L170E
         leas  -$0A,s
         sty   ,s
         ldd   <$0047
         std   $02,s
         ldd   <$0049
         std   $04,s
         ldd   <$004B
         std   $06,s
         ldd   <$004D
         std   $08,s
         lbsr  L16A6
         ldd   $02,s
         std   <$0047
         ldd   $08,s
         std   <$004D
         ldy   ,s
         lbsr  L16EE
         ldd   $06,s
         std   <$0047
         ldd   $04,s
         std   <$0049
         ldy   ,s
         lbsr  L16EE
         ldd   $02,s
         std   <$0047
         ldd   $06,s
         std   <$004B
         ldd   $08,s
         std   <$0049
         ldy   ,s
         lbsr  L16A6
         leas  $0A,s
         clrb  
L17F0    bra   L184A
         lbsr  L0184
         ldb   <$0060
         lbmi  L05A2
         ldb   $0E,y
         beq   L1802
         lbsr  L0189
L1802    lbsr  L1E29
         bcs   L184A
         lbsr  L1E30
         bcs   L184A
         lbsr  L16BC
         lbsr  L170E
         ldd   <$004B
         std   <$0099
         ldd   <$004B
         subd  <$0047
         addd  #$0001
         std   <$009B
         lbsr  L1F2B
         lbsr  L1ED4
         lda   <$0061
         std   <$009D
         ldd   <$004D
         subb  <$004A
         incb  
         tfr   d,y
L1830    pshs  y,x
         ldy   <$009B
         ldd   <$009D
         lbsr  L16CA
         puls  y,x
         ldb   <$0063
         abx   
         inc   <$004A
         ldd   <$0099
         std   <$0047
         leay  -$01,y
         bne   L1830
         clrb  
L184A    lbra  L011D
         lbsr  L0184
         ldb   <$0060
         lbmi  L05A2
         ldd   <$0053
         lsra  
         rorb  
         std   <$0055
         bra   L18BB
         lbsr  L0184
         ldb   <$0060
         lbmi  L05A2
         lbsr  L1E38
         bcs   L184A
         lbsr  L1E57
         bcs   L184A
         ldd   <$0020
         cmpd  <$0024
         bne   L1889
         leax  >L1ABF,pcr
         ldd   <$0022
         cmpd  <$0026
         blt   L18AE
         leax  >L1AC6,pcr
         bra   L18AE
L1889    ldx   <$0022
         cmpx  <$0026
         bne   L189E
         leax  >L1ACD,pcr
         cmpd  <$0024
         blt   L18AE
         leax  >L1AD3,pcr
         bra   L18AE
L189E    leax  >L1AD9,pcr
         ldd   <$0020
         subd  <$0024
         std   <$0097
         ldd   <$0022
         subd  <$0026
         std   <$0099
L18AE    stx   <$00A1
         bra   L18C1
         lbsr  L0184
         ldb   <$0060
         lbmi  L05A2
L18BB    leax  >L1ADD,pcr
         stx   <$00A1
L18C1    ldb   $0E,y
         beq   L18C8
         lbsr  L0189
L18C8    lbsr  L1E29
         lbcs  L1A97
         lbsr  L1E5B
         lbcs  L1A97
         ldd   <$0047
         std   <$0018
         ldd   <$0049
         std   <$001A
         clra  
         clrb  
         std   <$001C
         ldd   <$0055
         std   <$001E
         leas  <-$3E,s
         sty   <$3C,s
         leax  $05,s
         ldd   <$0053
         lbsr  L1B54
         lbsr  L1BC4
         tfr   x,y
         leax  <$14,s
         ldd   <$0055
         lbsr  L1BD4
         leax  $0A,s
         lbsr  L1B5D
         lbsr  L1C03
         tfr   x,y
         leax  $0F,s
         lbsr  L1B5D
         lbsr  L1C03
         leax  <$19,s
         ldd   <$0055
         lbsr  L1B54
         lbsr  L1BC4
         tfr   x,y
         leax  <$1E,s
         lbsr  L1B5D
         lbsr  L1C03
         tfr   x,y
         leax  <$23,s
         lbsr  L1B5D
         lbsr  L1C03
         leax  <$28,s
         clra  
         clrb  
         lbsr  L1B54
         leax  <$2D,s
         ldd   <$001E
         lbsr  L1B54
         subd  #$0001
         lbsr  L1BC4
         leay  $0A,s
         lbsr  L1BD9
         leay  $05,s
         lbsr  L1B9D
         leax  ,s
         lbsr  L1B5D
         lbsr  L1C37
         ldd   #$0001
         lbsr  L1B86
         leay  <$1E,s
         lbsr  L1BD9
         tfr   x,y
         leax  <$2D,s
         lbsr  L1B9D
         leax  <$32,s
         leay  $0F,s
         lbsr  L1B5D
         lbsr  L1C37
         ldd   <$001E
         lbsr  L1BC4
         leax  <$37,s
         leay  <$1E,s
         lbsr  L1B5D
L1989    leax  <$14,s
         leay  <$28,s
         lbsr  L1C54
         ble   L19DE
         lbsr  L1A9A
         tst   <$2D,s
         bmi   L19BB
         leax  <$32,s
         leay  $0F,s
         lbsr  L1B9D
         tfr   x,y
         leax  <$2D,s
         lbsr  L1B9D
         leax  <$14,s
         leay  $05,s
         lbsr  L1BB5
         ldd   <$001E
         subd  #$0001
         std   <$001E
L19BB    leax  <$37,s
         leay  <$23,s
         lbsr  L1B9D
         tfr   x,y
         leax  <$2D,s
         lbsr  L1B9D
         leax  <$28,s
         leay  <$19,s
         lbsr  L1B9D
         ldd   <$001C
         addd  #$0001
         std   <$001C
         bra   L1989
L19DE    leax  <$2D,s
         ldd   <$001C
         lbsr  L1B54
         addd  #$0001
         lbsr  L1BC4
         leay  <$1E,s
         lbsr  L1BD9
         leax  ,s
         ldd   <$001E
         lbsr  L1B54
         subd  #$0002
         lbsr  L1BC4
         ldd   #$0001
         lbsr  L1B86
         leay  $0A,s
         lbsr  L1BD9
         tfr   x,y
         leax  <$2D,s
         lbsr  L1B9D
         leax  ,s
         leay  $0A,s
         lbsr  L1B5D
         lbsr  L1C37
         ldd   #$0001
         lbsr  L1B86
         leay  <$19,s
         lbsr  L1BD9
         tfr   x,y
         leax  <$2D,s
         lbsr  L1B9D
         leax  <$32,s
         leay  <$23,s
         lbsr  L1B5D
         ldd   <$001C
         lbsr  L1BC4
         leax  <$37,s
         leay  $0F,s
         lbsr  L1B5D
         lbsr  L1C37
         ldd   <$001E
         lbsr  L1BC4
         leay  $0A,s
         lbsr  L1B9D
L1A53    ldd   <$001E
         cmpd  #$FFFF
         beq   L1A93
         bsr   L1A9A
         tst   <$2D,s
         bpl   L1A7A
         leax  <$32,s
         leay  <$23,s
         lbsr  L1B9D
         tfr   x,y
         leax  <$2D,s
         lbsr  L1B9D
         ldd   <$001C
         addd  #$0001
         std   <$001C
L1A7A    leax  <$37,s
         leay  $0F,s
         lbsr  L1B9D
         tfr   x,y
         leax  <$2D,s
         lbsr  L1B9D
         ldd   <$001E
         subd  #$0001
         std   <$001E
         bra   L1A53
L1A93    leas  <$3E,s
         clrb  
L1A97    lbra  L011D
L1A9A    ldy   <$3E,s
         ldd   <$001C
         ldx   <$001E
         bsr   L1AB9
         nega  
         negb  
         sbca  #$00
         bsr   L1AB9
         exg   d,x
         nega  
         negb  
         sbca  #$00
         exg   d,x
         bsr   L1AB9
         ldd   <$001C
         bsr   L1AB9
         rts   
L1AB9    pshs  x,b,a
         jmp   [>$00A1,u]
L1ABF    cmpd  <$0020
         bge   L1ADD
         bra   L1AFF
L1AC6    cmpd  <$0020
         ble   L1ADD
         bra   L1AFF
L1ACD    cmpx  <$0022
         ble   L1ADD
         bra   L1AFF
L1AD3    cmpx  <$0022
         bge   L1ADD
         bra   L1AFF
L1AD9    bsr   L1B01
         bgt   L1AFF
L1ADD    addd  <$0018
         bmi   L1AFF
         cmpd  <$1B,y
         bhi   L1AFF
         std   <$0047
         tfr   x,d
         addd  <$001A
         bmi   L1AFF
         cmpd  <$1D,y
         bhi   L1AFF
         std   <$0049
         lbsr  L1ED4
         lda   <$0061
         lbsr  L1F9B
L1AFF    puls  pc,x,b,a
L1B01    pshs  x,b,a
         tfr   x,d
         subd  <$0026
         ldx   <$0097
         bsr   L1B1F
         pshs  x,b
         ldd   $03,s
         subd  <$0024
         ldx   <$0099
         bsr   L1B1F
         cmpb  ,s
         bne   L1B1B
         cmpx  $01,s
L1B1B    leas  $03,s
         puls  pc,x,b,a
L1B1F    pshs  x,b,a
         lda   $03,s
         mul   
         pshs  b,a
         lda   $05,s
         ldb   $02,s
         mul   
         addb  ,s+
         adca  #$00
         pshs  b,a
         ldd   $04,s
         mul   
         addd  ,s
         std   ,s
         lda   $05,s
         ldb   $03,s
         mul   
         addb  ,s
         ldx   $01,s
         tst   $03,s
         bpl   L1B49
         neg   $06,s
         addb  $06,s
L1B49    tst   $05,s
         bpl   L1B51
         neg   $04,s
         addb  $04,s
L1B51    leas  $07,s
         rts   
L1B54    clr   ,x
         clr   $01,x
         clr   $02,x
         std   $03,x
         rts   
L1B5D    pshs  b,a
         ldd   ,y
         std   ,x
         ldd   $02,y
         std   $02,x
         ldb   $04,y
         stb   $04,x
         puls  pc,b,a
         exg   x,y
         bsr   L1B5D
         exg   x,y
         rts   
L1B74    exg   y,u
         exg   x,y
         bsr   L1B5D
         exg   x,y
         exg   y,u
         rts   
L1B7F    exg   x,u
         bsr   L1B5D
         exg   x,u
         rts   
L1B86    pshs  b,a
         addd  $03,x
         std   $03,x
         ldd   #$0000
         adcb  $02,x
         adca  $01,x
         std   $01,x
         ldb   #$00
         adcb  ,x
         stb   ,x
         puls  pc,b,a
L1B9D    pshs  b,a
         ldd   $03,x
         addd  $03,y
         std   $03,x
         ldd   $01,x
         adcb  $02,y
         adca  $01,y
         std   $01,x
         ldb   ,x
         adcb  ,y
         stb   ,x
         puls  pc,b,a
L1BB5    exg   x,y
         bsr   L1C37
         exg   x,y
         bsr   L1B9D
         exg   x,y
         bsr   L1C37
         exg   x,y
         rts   
L1BC4    pshs  y,b,a
         clra  
         clrb  
         pshs  b,a
         pshs  b
         tfr   s,y
         bsr   L1BD9
         leas  $03,s
         puls  pc,y,b,a
L1BD4    lbsr  L1B54
         bra   L1BD9
L1BD9    pshs  u,y,b,a
         leas  -$0A,s
         tfr   s,u
         bsr   L1B7F
         tfr   u,y
         leau  $05,u
         bsr   L1B74
         ldd   #$0000
         lbsr  L1B54
         bra   L1BF1
L1BEF    bsr   L1C0E
L1BF1    bsr   L1C19
         beq   L1BFB
         bcc   L1BEF
         bsr   L1B9D
         bra   L1BEF
L1BFB    bcc   L1BFF
         bsr   L1B9D
L1BFF    leas  $0A,s
         puls  pc,u,y,b,a
L1C03    lsl   $04,x
         rol   $03,x
         rol   $02,x
         rol   $01,x
         rol   ,x
         rts   
L1C0E    lsl   $04,y
         rol   $03,y
         rol   $02,y
         rol   $01,y
         rol   ,y
         rts   
L1C19    lsr   ,u
         bne   L1C2C
         ror   $01,u
         bne   L1C2E
         ror   $02,u
         bne   L1C30
         ror   $03,u
         bne   L1C32
         ror   $04,u
         rts   
L1C2C    ror   $01,u
L1C2E    ror   $02,u
L1C30    ror   $03,u
L1C32    ror   $04,u
         andcc #$FB
         rts   
L1C37    com   ,x
         com   $01,x
         com   $02,x
         com   $03,x
         com   $04,x
         inc   $04,x
         bne   L1C53
         inc   $03,x
         bne   L1C53
         inc   $02,x
         bne   L1C53
         inc   $01,x
         bne   L1C53
         inc   ,x
L1C53    rts   
L1C54    pshs  b,a
         ldd   ,x
         cmpd  ,y
         bne   L1C73
         ldd   $02,x
         cmpd  $02,y
         bne   L1C6A
         ldb   $04,x
         cmpb  $04,y
         beq   L1C73
L1C6A    bhi   L1C70
         lda   #$08
         bra   L1C71
L1C70    clra  
L1C71    tfr   a,cc
L1C73    puls  pc,b,a
         lbsr  L0184
         ldb   <$0060
         lbmi  L05A2
         ldb   $0E,y
         beq   L1C85
         lbsr  L0189
L1C85    ldb   #$01
         stb   <$002A
         lbsr  L1E29
         bcs   L1CE7
         lbsr  L1ED4
         stx   <$0072
         stb   <$0074
         lbsr  L1F8B
         sta   <$0028
         leax  >L07A1,pcr
         ldb   <$0060
         ldb   b,x
         leax  b,x
         anda  ,x+
         ldb   a,x
         stb   <$0029
         cmpb  $06,y
         beq   L1CDF
         clrb  
         pshs  b
         lbsr  L1F2B
         lbsr  L1F5A
         ldx   <$0072
         bra   L1CEE
L1CBB    tst   >$101B
         beq   L1CE4
         ldb   ,s+
         beq   L1CDF
         stb   <$002B
         addb  ,s+
         cmpb  <$1E,y
         bhi   L1CEA
         stb   <$004A
         puls  b,a
         std   <$0047
         puls  b,a
         std   <$004B
         lbsr  L1ED4
         stb   <$0074
         lbra  L1D6A
L1CDF    clrb  
         ldb   <$002A
         bne   L1CE7
L1CE4    ldb   #$BA
         coma  
L1CE7    lbra  L011D
L1CEA    leas  $04,s
         bra   L1CBB
L1CEE    ldb   <$0074
L1CF0    lbsr  L1F74
         bsr   L1D3E
         beq   L1CFC
         lbsr  L1F8B
         beq   L1CF0
L1CFC    lbsr  L1F45
         pshs  b
         ldd   <$0047
         std   <$009B
         puls  b
L1D07    bsr   L1D52
         bsr   L1D48
         bhi   L1D12
         lbsr  L1F8B
         beq   L1D07
L1D12    lbsr  L1F74
         lbsr  L1E21
         beq   L1D28
         ldd   <$0047
         pshs  b,a
         ldd   <$009B
         pshs  b,a
         ldb   <$004A
         lda   #$FF
         pshs  b,a
L1D28    lbsr  L1E21
         beq   L1CBB
         ldd   <$0047
         pshs  b,a
         ldd   <$009B
         pshs  b,a
         ldb   <$004A
         lda   #$01
         pshs  b,a
         lbra  L1CBB
L1D3E    pshs  b,a
         ldd   <$0047
         cmpd  #$FFFF
         puls  pc,b,a
L1D48    pshs  b,a
         ldd   <$0047
         cmpd  <$1B,y
         puls  pc,b,a
L1D52    lda   ,x
         sta   ,-s
         lda   <$0061
         lbsr  L1F9B
         lda   ,x
         cmpa  ,s+
         beq   L1D66
         lda   #$FF
         sta   >$101B
L1D66    lbsr  L1F45
         rts   
L1D6A    ldd   <$0047
         subd  #$0002
         std   <$009B
         ldb   <$0074
L1D73    lbsr  L1F8B
         bne   L1D7F
         lbsr  L1F74
         bsr   L1D3E
         bne   L1D73
L1D7F    lbsr  L1F45
         stb   <$0074
         ldd   <$0047
         cmpd  <$004B
         lbgt  L1CBB
         ldb   <$0074
         lbsr  L1F8B
         bne   L1D7F
         ldd   <$0047
         cmpd  <$009B
         bgt   L1DB3
         lbsr  L1E21
         beq   L1DB3
         ldd   <$009B
         pshs  b,a
         ldd   <$0047
         bpl   L1DAA
         clra  
         clrb  
L1DAA    pshs  b,a
         ldb   <$004A
         lda   <$002B
         nega  
         pshs  b,a
L1DB3    ldd   <$0047
         std   <$009B
         ldb   <$0074
L1DB9    lbsr  L1F8B
         bne   L1DC4
         bsr   L1D52
         bsr   L1D48
         bls   L1DB9
L1DC4    lbsr  L1F74
         stb   <$0074
         bsr   L1E21
         beq   L1DDD
         ldd   <$0047
         pshs  b,a
         ldd   <$009B
         pshs  b,a
         ldb   <$004A
         lda   <$002B
         pshs  b,a
         ldb   <$0074
L1DDD    lbsr  L1F45
         stb   <$0074
         lbsr  L1D48
         bgt   L1DF7
         ldd   <$0047
         cmpd  <$004B
         bgt   L1DF7
         ldb   <$0074
         lbsr  L1F8B
         bne   L1DDD
         bra   L1DB3
L1DF7    cmps  <$003B
         bhi   L1DFE
         clr   <$002A
L1DFE    ldd   <$0047
         subd  #$0001
         std   <$0047
         ldd   <$004B
         addd  #$0002
         cmpd  <$0047
         bhi   L1E1E
         leas  -$02,s
         pshs  b,a
         ldd   <$0047
         std   $02,s
         ldb   <$004A
         lda   <$002B
         nega  
         pshs  b,a
L1E1E    lbra  L1CBB
L1E21    cmps  <$003B
         bhi   L1E28
         clr   <$002A
L1E28    rts   
L1E29    ldb   #$47
L1E2B    bsr   L1E5F
         lbra  L1EB9
L1E30    ldb   #$4B
         bra   L1E2B
L1E34    ldb   #$4F
         bra   L1E2B
L1E38    ldb   #$20
L1E3A    bsr   L1E5F
         ldd   #$027F
         bsr   L1E46
         bcs   L1E56
         ldd   #$00BF
L1E46    pshs  b,a
         ldd   ,x++
         bpl   L1E50
         nega  
         negb  
         sbca  #$00
L1E50    cmpd  ,s++
         bgt   L1ED0
         clrb  
L1E56    rts   
L1E57    ldb   #$24
         bra   L1E3A
L1E5B    ldb   #$53
         bra   L1E3A
L1E5F    tfr   u,x
         abx   
         lda   $09,y
         bita  #$08
         beq   L1E6C
         ldd   -$07,y
         bne   L1E6D
L1E6C    rts   
L1E6D    pshs  y,x,b,a
         tfr   x,y
         ldx   ,y
         ldb   ,s
         beq   L1E7B
         bsr   L1E87
         std   ,y
L1E7B    ldx   $02,y
         ldb   $01,s
         beq   L1E85
         bsr   L1E87
         std   $02,y
L1E85    puls  y,x,b,a
L1E87    pshs  x,b
         leas  -$02,s
         lda   $04,s
         mul   
         cmpb  #$CD
         pshs  cc
         exg   a,b
         clra  
         puls  cc
         bcs   L1E9C
         addd  #$0001
L1E9C    std   ,s
         lda   $03,s
         ldb   $02,s
         mul   
         addd  ,s
         leas  $03,s
         puls  pc,x
L1EA9    pshs  x
         lda   ,s
         stb   ,s
         mul   
         stb   ,-s
         ldd   $01,s
         mul   
         adda  ,s+
         puls  pc,x
L1EB9    ldd   ,x
         bmi   L1ED0
         cmpd  <$1B,y
         bgt   L1ED0
         ldd   $02,x
         bmi   L1ED0
         cmpd  <$1D,y
         bgt   L1ED0
         andcc #$FE
         rts   
L1ED0    comb  
         ldb   #$BD
         rts   
L1ED4    ldd   -$0D,y
L1ED6    pshs  y,b,a
         lda   <$004A
         ldb   <$0063
         mul   
         addd  ,s++
         tfr   d,x
         ldb   <$0060
         bpl   L1EEC
         ldd   <$0047
         lslb  
         leax  d,x
         puls  pc,y
L1EEC    cmpb  #$04
         bne   L1EF8
         ldd   <$0047
         leay  >L1F28,pcr
         bra   L1F0E
L1EF8    cmpb  #$01
         beq   L1F04
         ldd   <$0047
         leay  >L1F23,pcr
         bra   L1F0C
L1F04    ldd   <$0047
         leay  >L1F1A,pcr
         lsra  
         rorb  
L1F0C    lsra  
         rorb  
L1F0E    lsra  
         rorb  
         leax  d,x
         ldb   <$0048
         andb  ,y+
         ldb   b,y
         puls  pc,y
L1F1A    asr   <$0080
         nega  
         bra   L1F2F
         lsl   <$0004
         aim   #$01,<$0003
         subb  #$30
         inc   <$0003
L1F28    oim   #$F0,<$000F
L1F2B    lda   <$0060
         leax  >L1F3B,pcr
         lsla  
         ldd   a,x
         sta   <$0079
         leax  b,x
         stx   <$0077
         rts   
L1F3B    neg   <$0000
         suba  #$19
         subb  #$18
         subb  #$18
         subb  >$160C
         lsla  
         bne   L1F4B
         inc   <$0047
L1F4B    lsrb  
         bcs   L1F55
         jmp   [<$77,u]
         lsrb  
         lsrb  
         lsrb  
         rts   
L1F55    ldb   <$0079
         leax  $01,x
         rts   
L1F5A    lda   <$0060
         leax  >L1F6A,pcr
         lsla  
         ldd   a,x
         sta   <$007C
         leax  b,x
         stx   <$007A
         rts   
L1F6A    neg   <$0000
         oim   #$1B,<$0003
         orcc  #$03
         orcc  #$0F
         fcb   $18 
L1F74    tst   <$0048
         bne   L1F7A
         dec   <$0047
L1F7A    dec   <$0048
         lslb  
         bcs   L1F86
         jmp   [<$7A,u]
         lslb  
         lslb  
         lslb  
         rts   
L1F86    ldb   <$007C
         leax  -$01,x
         rts   
L1F8B    pshs  b
         tfr   b,a
         anda  ,x
L1F91    lsrb  
         bcs   L1F97
         lsra  
         bra   L1F91
L1F97    cmpa  <$0028
         puls  pc,b
L1F9B    pshs  b,a
         jmp   [<$64,u]
         pshs  x,b
         bsr   L1FD5
         abx   
         ldb   <$0048
         lsrb  
         lsrb  
         lsrb  
         andb  #$03
         bra   L1FC8
         pshs  x,b
         bsr   L1FD5
         lslb  
         abx   
         ldb   <$0048
         lsrb  
         lsrb  
         andb  #$07
         bra   L1FC8
         pshs  x,b
         bsr   L1FD5
         lslb  
         lslb  
         abx   
         ldb   <$0048
         lsrb  
         andb  #$0F
L1FC8    ldb   b,x
         andb  ,s+
         ldx   ,s++
         pshs  b
         anda  ,s+
         jmp   [<$68,u]
L1FD5    ldx   <$0066
         ldb   <$004A
         andb  #$07
         lslb  
         lslb  
         rts   
L1FDE    anda  $01,s
         jmp   [<$68,u]
L1FE3    eora  ,x
         bra   L1FF0
         anda  ,x
L1FE9    comb  
         andb  ,x
         stb   ,x
         ora   ,x
L1FF0    sta   ,x
         puls  pc,b,a
L1FF4    neg   <$00AC
         ora   >$BAC8
         emod
eom      equ   *
