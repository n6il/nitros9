         nam   GrfDrv
         ttl   OS9 System Module    

*  Disassembled 03/09/13 23:38:06 by Disasm v1.6 (C) 1988 by RML
*  Disassembly by R.Gault with tables from SF project for nlevel2
*  Patched rountine for >512K RAM just before L0762 9/15/03 RG


         ifp1
         use   defsfile
         endc
tylg     set   Systm+Objct   
atrv     set   ReEnt+rev
rev      set   $01
         mod   eom,name,tylg,atrv,start,size
u0000    rmb   0
size     equ   .
         fcb   $07 
name     equ   *
         fcs   /GrfDrv/
         fcb   $12 
start    equ   *
         ldx   #$40F4
         pshs  x,b,a
         tfr   u,d
         tfr   a,dp
         leax  <L002b,pcr
         ldb   $01,s
         ldd   b,x
         leax  d,x
         puls  b,a
         jmp   ,x
L002b    fdb L008B-L002b     *  fcb $00,$60
         fdb L00E4-L002b  *$00,$b9
         fdb L016E-L002b  *$01,$43
         fdb L035C-L002b  *$03,$31
         fdb L0360-L002b  *$03,$35
         fdb L03FA-L002b  *$03,$cf
         fdb L04B0-L002b  *$04,$85
         fdb L04DD-L002b  *$04,$b2
         fdb L06F9-L002b  *$06,$ce
         fdb L0579-L002b  *$05,$4e
         fdb L0654-L002b  *$06,$29
         fdb L062F-L002b  *$06,$04
         fdb L05A0-L002b  *$05,$75
         fdb L05E8-L002b  *$05,$bd
         fdb L063E-L002b  *$06,$13
         fdb L05FF-L002b  *$05,$d4
         fdb L065C-L002b  *$06,$31
         fdb L067E-L002b  *$06,$53
         fdb L0622-L002b  *$05,$f7
         fdb L06EC-L002b  *$06,$c1
         fdb L06F1-L002b  *$06,$c6
         fdb L06F5-L002b  *$06,$ca
         fdb L0801-L002b  *$07,$d6
         fdb L094A-L002b  *$09,$1f
         fdb L0A40-L002b  *$0a,$15
         fdb L0A78-L002b  *$0a,$4d
         fdb L0AAA-L002b  *$0a,$7f
         fdb L0BC6-L002b  *$0b,$9b
         fdb L0E25-L002b  *$0d,$fa
         fdb L0E66-L002b  *$0e,$3b
         fdb L1055-L002b  *$10,$2a
         fdb L105C-L002b  *$10,$31
         fdb L138C-L002b  *$13,$61
         fdb L1068-L002b  *$10,$3d
         fdb L140A-L002b  *$13,$df
         fdb L13F1-L002b  *$13,$c6
         fdb L156F-L002b  *$15,$44
         fdb L157B-L002b  *$15,$50
         fdb L169F-L002b  *$16,$74
         fdb L17A4-L002b  *$17,$79
         fdb L17EC-L002b  *$17,$c1
         fdb L185C-L002b  *$18,$31
         fdb L17FB-L002b  *$17,$d0
         fdb L1C1C-L002b  *$1b,$f1
         fdb L16A5-L002b  *$16,$7a
         fdb L17E7-L002b  *$17,$bc
         fdb L1857-L002b  *$18,$2c
         fdb L1536-L002b  *$15,$0b
L008B    tst   <$38
         bmi   L00E2
         lda   #$FF
         sta   <$0038
         leax  >$0180,u
         ldb   #$FF
         ldy   #$0020
L009D    std   ,x
L009F    leax  <$40,x
         leay  -$01,y
         bne   L009D
         leay  <$10,y
L00A9    clr   $01,x
         leax  <$20,x
         leay  -$01,y
         bne   L00A9
         leax  <$18,x
         stx   <$003B
         clra  
         clrb  
         std   <$0030
         std   <$002E
         stb   <$0032
         stb   <$0035
         std   <$0039
         std   <$003D
         std   <$003F
         incb  
         std   <$00B3
         ldb   #$20
         std   <$00B5
         exg   a,b
         std   <$00B7
         lda   #$7E
         ldx   #$414F
         sta   <$00B9
         stx   <$00BA
         ldx   #$4154
         sta   <$00BC
         stx   <$00BD
L00E2    clrb  
         rts   
L00E4    clr   <$0038
         clr   <$007D
         ldb   <$0032
         beq   L00F3
         ldx   <$0033
         lbsr  L0963
         bcc   L00E4
L00F3    rts   
L00F4    pshs  cc
         orcc  #$50
         ldx   >$1007
         clr   >$1002
         clra  
         tfr   a,dp
         puls  a
         jmp   [>$00A9]
L0107    pshs  y,x,b,a
         ldx   -$10,y
         stx   $02,s
L010D    leay  $0F,y
         ldd   $07,y
         std   <$0064
         ldd   $05,y
         std   <$0068
         ldd   -$09,y
         std   <$0061
         ldd   $0C,y
         std   <$006A
         ldd   $0E,y
         std   <$006C
         ldb   ,x
         andb  #$8F
         stb   <$0060
         ldb   $04,x
         stb   <$0063
         ldb   $01,x
L012F    leax  >$008F,u
         ldy   #$FFAC
         clra  
L0138    std   ,x++
         stb   ,y+
         incb  
         cmpy  #$FFAF
         bls   L0138
         puls  pc,y,x,b,a
L0145    pshs  y,x,b,a
         bra   L012F
L0149    pshs  y,x,b,a
         ldx   -$10,y
         bra   L010D
         bsr   L0107
         lbra  L13FB
         clr   <$0089
         stb   <$008A
         stb   >$FFA9
         rts   
L015C    pshs  a
         os9   F$AllRAM 
         puls  pc,a
L0163    pshs  a
         os9   F$AlHRAM 
         puls  pc,a
L016A    os9   F$DelRAM 
         rts   
L016E    bsr   L0198
         bcs   L0197
         lda   <$0060
         cmpa  #$FF
         bne   L0182
         lda   [<-$10,y]
         sta   <$0060
         lbsr  L13FB
         bra   L0187
L0182    lbsr  L01D5
         bcs   L0197
L0187    lbsr  L0107
         lbsr  L02EE
         lda   #$FF
         sta   -$0E,y
         ldb   $08,y
         lbsr  L129C
         clrb  
L0197    rts   
L0198    lda   <$0060
         cmpa  #$FF
         bne   L01A1
         lda   [<-$10,y]
L01A1    leax  <L01CF,pcr
         anda  #$01
         ldb   -$0B,y
         cmpb  a,x
         bhi   L01CB
         addb  -$09,y
         cmpb  a,x
         bhi   L01CB
         lda   [<-$10,y]
         anda  #$30
         ldb   #$10
         mul   
         ldb   -$0A,y
         leax  <L01D1,pcr
         cmpb  a,x
         bhi   L01CB
         addb  -$08,y
         cmpb  a,x
         bhi   L01CB
         clrb  
         rts   
L01CB    comb  
         ldb   #$BD
         rts   
L01CF    fcb   40,80
L01D1    fcb   $18,$19,$46,$46 
L01D5    bsr   L01F4
         bcs   L01F3
         stx   -$10,y
         ldb   <$0060
         stb   ,x
         bsr   L0208
         bcs   L01F3
         ldb   <$005A
         stb   $05,x
         lbsr  L06D2
         stb   $06,x
         lbsr  L02A0
         lbsr  L0640
L01F2    clrb  
L01F3    rts   
L01F4    leax  >$0980,u
         ldb   #$10
L01FA    tst   $01,x
         beq   L01F2
         leax  <$20,x
         decb  
         bne   L01FA
         comb  
         ldb   #$C1
         rts   
L0208    pshs  y
         ldb   <$0060
         bpl   L0228
         leay  >$0980,u
         lda   #$10
L0214    tst   ,y
         bpl   L0220
         ldb   $01,y
         beq   L0220
         bsr   L026F
         bcc   L0247
L0220    leay  <$20,y
         deca  
         bne   L0214
         ldb   <$0060
L0228    leay  <L0262,pcr
         andb  #$0F
         ldb   b,y
         lbsr  L0163
         bcs   L0258
         ldy   #$8000
         pshs  y,b
         lbsr  L0145
         ldb   #$FF
L023F    stb   ,y
         bsr   L025A
         bcs   L023F
         puls  y,b
L0247    stb   $01,x
         sty   $02,x
         lda   <$0060
         anda  #$0F
         leay  <L0268,pcr
         lda   a,y
         sta   $04,x
         clrb  
L0258    puls  pc,y
L025A    leay  >$0800,y
         cmpy  #$A000
L0262    rts   
L0263    fcb   $02,$02,$04,$04,$01
L0268    fcb   $01,$50,$50,$a0,$a0,$a0,$50
L026F    pshs  y,x,b,a
         lbsr  L0145
         ldy   #$8000
         ldb   #$FF
L027A    cmpb  ,y
         beq   L0285
L027E    bsr   L025A
         bcs   L027A
L0282    comb  
         puls  pc,y,x,b,a
L0285    lda   <$0060
         anda  #$8F
         cmpa  #$86
         beq   L029A
         leax  >$0800,y
         cmpx  #$A000
         bcc   L0282
         cmpb  ,x
         bne   L027E
L029A    clrb  
         puls  x,b,a
         leas  $02,s
         rts   
L02A0    pshs  y,x
         stb   <$0097
         stb   <$0098
         lda   ,x
         bpl   L02AE
         ldb   #$20
         stb   <$0097
L02AE    pshs  x
         ldd   -$0B,y
         bne   L02C9
         ldb   ,x
         leax  >L01CF,pcr
         andb  #$01
         abx   
         ldd   -$09,y
         cmpa  ,x
         bne   L02C9
         cmpb  #$18
         bne   L02C9
         puls  pc,y,x,b,a
L02C9    puls  x
         ldy   $02,x
         lda   ,x
         anda  #$0F
         lsla  
         leax  <L02E0,pcr
         ldx   a,x
         ldd   <$0097
L02DA    std   ,y++
         leax  -$01,x
         bne   L02DA
L02E0    puls  pc,y,x
L02E2    fdb   $1F40
         fdb   $1F40
         fdb   $3E80
         fdb   $3E80
         fdb   $07D0
         fdb   $03E8
L02EE    pshs  x
         clra
         sta   <$18,y
         sta   $0A,y
         sta   $0E,y
         ldx   #$5F9A
         stx   <$14,y
         ldx   #$5F83
         stx   <$16,y
         lda   #$89
         sta   $09,y
         bsr   L0325
         stb   <$0061
         bsr   L032F
         stb   <$0062
         lbsr  L06DC
         puls  x
         ldd   $02,x
         bsr   L0337
         clr   $0B,y
         ldd   #$C801
         std   <$0057
         lbsr  L05A2
         clrb  
         rts   
L0325    ldb   $06,y
         lbsr  L0698
         stb   $06,y
         rts   
L032D    bsr   L0325
L032F    ldb   $07,y
         lbsr  L0698
         stb   $07,y
         rts   
L0337    lbsr  L04ED
         ldd   -$0D,y
         std   <$24,y
         ldd   -$0B,y
         std   <$26,y
         clr   -$0B,y
         clr   -$0A,y
         ldd   -$09,y
         std   <$28,y
         rts   
L034E    tsta  
         beq   L0355
         orb   $09,y
         bra   L0358
L0355    comb  
         andb  $09,y
L0358    stb   $09,y
         bra   L038E
L035C    ldb   #$01
         bra   L034E
L0360    jsr   <$00B9
         ldd   #$FFFE
         std   -$10,y
         bsr   L0390
         bcs   L0387
         bsr   L03A8
         cmpy  <$002E
         bne   L038E
         clra  
         clrb  
         std   <$002E
         std   <$0030
         ldx   #$FFB0
         ldd   #$1008
         stb   >$FF9A
L0381    stb   ,x+
         deca  
         bhi   L0381
         rts   
L0387    ldb   $06,x
         stb   <$0062
         lbsr  L129C
L038E    clrb  
         rts   
L0390    pshs  y
         leay  >$0190,u
         ldb   #$20
L0398    cmpx  -$10,y
         beq   L03A5
         leay  <$40,y
         decb  
         bne   L0398
         clrb  
         bra   L03A6
L03A5    comb  
L03A6    puls  pc,y
L03A8    pshs  y
         lda   ,x
         bpl   L03D0
         ldy   $02,x
         ldb   #$FF
         stb   ,y
         anda  #$CF
         cmpa  #$85
         bne   L03BF
         stb   >$0800,y
L03BF    ldy   #$8000
L03C3    cmpb  ,y
         bne   L03E6
         lbsr  L025A
         bcs   L03C3
         ldb   #$01
         bra   L03D8
L03D0    anda  #$0F
         leay  >L0262,pcr
         ldb   a,y
L03D8    pshs  x,b
         clra  
         ldb   $01,x
         tfr   d,x
         puls  b
         lbsr  L016A
         puls  x
L03E6    clr   $01,x
         puls  pc,y
L03EA    puls  b,a
         pshs  y,b,a
         ldb   -$0E,y
         lda   #$40
         mul   
         leay  >$0190,u
         leay  d,y
         rts   
L03FA    bsr   L03EA
         jsr   <$00B9
         tfr   y,d
         ldy   ,s
         std   ,s
         bsr   L042D
         bcs   L042B
         ldd   -$10,x
         std   -$10,y
         lbsr  L0149
         bsr   L045C
         tst   <$0059
         beq   L0421
         bsr   L048E
         bcs   L042B
         ldb   $07,y
         stb   <$0062
         lbsr  L129C
L0421    ldx   ,s
         cmpx  <$002E
         bne   L042A
         sty   <$002E
L042A    clrb  
L042B    puls  pc,x
L042D    bsr   L044A
L042F    ldb   -$0B,y
         bmi   L0447
         addb  -$09,y
         cmpb  <$28,x
         bhi   L0447
         ldb   -$0A,y
         bmi   L0447
         addb  -$08,y
         cmpb  <$29,x
         bhi   L0447
         clrb  
         rts   
L0447    lbra  L01CB
L044A    tfr   y,x
L044C    ldb   -$0E,x
         bmi   L045B
         leax  >$0190,u
         lda   #$40
         mul   
         leax  d,x
         bra   L044C
L045B    rts   
L045C    clr   <$11,y
         lda   $09,x
         sta   $09,y
         lbsr  L06DC
         lda   $08,x
         anda  #$C0
         ora   $08,y
         sta   $08,y
         ldd   #$050A
         bsr   L0481
         ldd   #$0714
         bsr   L0481
         lbsr  L032D
         ldd   -$0D,x
         lbsr  L0337
         rts   
L0481    pshs  a
L0483    lda   b,x
         sta   b,y
         incb  
         dec   ,s
         bne   L0483
         puls  pc,a
L048E    pshs  x
         clra  
         ldb   -$09,y
         tst   <$0060
         bmi   L049A
         lda   #$08
         mul   
L049A    std   <$004F
         clra  
         ldb   -$08,y
         tst   <$0060
         bmi   L04A6
         lslb  
         lslb  
         lslb  
L04A6    std   <$0051
         clrb  
         std   <$0047
         lbsr  L0AF5
         puls  pc,x
L04B0    jsr   <$00B9
         cmpy  <$002E
         bne   L04BF
         lbsr  L03EA
         sty   <$002E
         puls  y
L04BF    ldb   <$11,y
         beq   L04D6
         jsr   <$00BC
         stb   <$007D
         ldd   <$12,y
         std   <$007E
         lbsr  L0C01
         lbsr  L084C
         lbsr  L0963
L04D6    ldd   #$FFFF
         std   -$10,y
         bra   L04EB
L04DD    jsr   <$00B9
         tfr   y,x
         lbsr  L042F
         bcs   L04EC
         ldd   <$24,y
         bsr   L04ED
L04EB    clrb  
L04EC    rts   
L04ED    pshs  x,b,a
         ldb   <$0060
         andb  #$0F
         leax  >L0548,pcr
         ldb   b,x
         stb   $03,y
         lda   -$09,y
         mul   
         stb   $02,y
         clra  
         ldb   <$0063
         tst   <$0060
         bmi   L050A
         lda   #$08
         mul   
L050A    std   $04,y
         ldb   -$0A,y
         ldx   $04,y
         lbsr  L1E21
         std   <$0097
         lda   -$0B,y
         ldb   $03,y
         mul   
         addd  ,s++
         addd  <$0097
         std   -$0D,y
         lbsr  L10A7
         ldb   <$0060
         bmi   L0529
         bsr   L054F
L0529    clra  
         ldb   -$09,y
         tst   <$0060
         bmi   L0533
         lda   #$08
         mul   
L0533    subd  <$00B3
         std   <$1B,y
         clra  
         ldb   -$08,y
         tst   <$0060
         bmi   L0542
         lda   #$08
         mul   
L0542    subb  #$01
         std   <$1D,y
         puls  pc,x
L0548    equ   *-1
L0549    fcb   1,2
         fcb   2,4
         fcb   2,2
L054F    pshs  x
         clra  
         ldb   -$09,y
         tfr   d,x
         lda   #$03
         mul   
         pshs  b
         ldb   #$33
         lbsr  L1E00
         addb  ,s+
         stb   -$07,y
         clra  
         ldb   -$08,y
         tfr   d,x
         lda   #$0A
         mul   
         pshs  b
         ldb   #$AB
         lbsr  L1E00
         addb  ,s+
         stb   -$06,y
         puls  pc,x
L0579    ldb   <$0057
         bne   L0584
         stb   $0E,y
         ldx   #$5F83
         bra   L059B
L0584    lbsr  L0851
         bcs   L059F
         stb   $0E,y
         leax  <$20,x
         stx   $0F,y
         ldx   -$10,y
         ldb   ,x
         ldx   #$5F0A
         ldb   b,x
         leax  b,x
L059B    stx   <$16,y
L059E    clrb  
L059F    rts   
L05A0    jsr   <$00B9
L05A2    ldb   <$0057
         bne   L05A9
         stb   $0B,y
         rts   
L05A9    lbsr  L0F31
         lbsr  L0851
         bcs   L05E2
         pshs  x,b
         ldd   $07,x
         tsta  
         bne   L05E3
         cmpb  #$06
         beq   L05C0
         cmpb  #$08
         bne   L05E3
L05C0    ldd   $09,x
         cmpd  #$0008
         bne   L05E3
         stb   $0B,x
         ldd   $07,x
         cmpd  <$006E
         beq   L05DB
         tst   $0B,y
         beq   L05DB
         lbsr  L112D
         lbsr  L1119
L05DB    puls  x,b
         stb   $0B,y
         stx   $0C,y
         clrb  
L05E2    rts   
L05E3    ldb   #$C2
         coma  
         puls  pc,x,a
L05E8    jsr   <$00B9
         ldb   <$0057
         bne   L05F2
         stb   <$18,y
         rts   
L05F2    lbsr  L0851
         bcs   L059F
         stb   <$18,y
         stx   <$19,y
         bra   L059E
L05FF    leax  <L0616,pcr
         ldb   $0A,y
         cmpb  #$05
         bhi   L0612
         lslb  
         ldd   b,x
         leax  d,x
         stx   <$14,y
         bra   L062D
L0612    comb  
         ldb   #$BB
         rts   
L0616    fdb   $1984
         fdb   $1982
         fdb   $1989
         fdb   $197E
         fdb   $1972
         fdb   $1976
L0622    ldb   9,y
         orb   #$80
         tsta  
         beq   L062B
         andb  #$7F
L062B    stb   $09,y
L062D    clrb  
         rts   
L062F    ldb   <$0086
         ldx   -$10,y
         leax  <$10,x
         lda   <$005A
         anda  #$0F
         stb   a,x
         bra   L062D
L063E    ldx   -$10,y
L0640    pshs  y,x
         leay  <$10,x
         ldx   >$1019
         clra  
L0649    ldb   ,x+
         stb   a,y
         inca  
         cmpa  #$0F
         ble   L0649
         puls  pc,y,x
L0654    ldb   <$005A
         ldx   -$10,y
         stb   $05,x
         bra   L0696
L065C    bsr   L0673
         stb   $06,y
         ldb   $09,y
         bitb  #$04
         bne   L0688
L0666    ldb   <$005A
         lslb  
         lslb  
         lslb  
         andb  #$38
         lda   $08,y
         anda  #$C7
         bra   L0690
L0673    ldx   -$10,y
         ldb   ,x
         stb   <$0060
         ldb   <$005A
         bsr   L0698
         rts   
L067E    bsr   L0673
         stb   $07,y
         ldb   $09,y
         bitb  #$04
         bne   L0666
L0688    ldb   <$005A
         andb  #$07
         lda   $08,y
         anda  #$F8
L0690    stb   <$0097
         ora   <$0097
         sta   $08,y
L0696    clrb  
         rts   
L0698    pshs  x,a
         lda   <$0060
         bmi   L06A2
         tfr   b,a
         bsr   L06AC
L06A2    puls  pc,x,a
L06A4    leax  <L06B4,pcr
         ldb   <$0060
         ldb   b,x
         rts   
L06AC    bsr   L06A4
         leax  b,x
         anda  ,x+
         ldb   a,x
L06B4    rts   
L06B5    fcb   L06B9-L06B4
         fcb   L06BC-L06B4
         fcb   L06BC-L06B4
         fcb   L06C1-L06b4
L06B9    fcb   1
         fcb   0,$FF
L06BC    fcb   3
         fcb   0,$55,$AA,$FF
L06C1    fcb   15
         fcb   0,$11,$22,$33,$44,$55,$66,$77
         fcb   $88,$99,$AA,$BB,$CC,$DD,$EE,$FF
L06D2    tst   ,x
         bpl   L06D9
         andb  #$07
         rts   
L06D9    bsr   L0698
         rts   
L06DC    ldd   $06,y
         anda  #$07
         lsla  
         lsla  
         lsla  
         andb  #$07
         stb   <$0097
         ora   <$0097
         sta   $08,y
         rts   
L06EC    ldb   #$10
L06EE    lbra  L034E
L06F1    ldb   #$08
         bra   L06EE
L06F5    ldb   #$20
         bra   L06EE
L06F9    ldx   <$002E
         pshs  y,x
         ldy   -$10,y
         lda   $01,y
         ldx   $02,y
         lbsr  L07E9
         ldx   #$FF90
         ldb   >$0090
         andb  #$7F
         stb   >$0090
         stb   ,x
         leax  <L078D,pcr
         ldb   ,y
         andb  #$0F
         lslb  
         abx   
         lda   >$0098
         anda  #$78
         ora   ,x+
         ldb   ,y
         andb  #$10
         lslb  
         orb   ,x
         ldx   #$FF90
         std   >$0098
         std   $08,x
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
         sta   $0B,x      !!!!!!!!!!!new instruction!!!!!!!!!! RG
         clra  
         std   >$009C
         std   $0C,x
         lda   <$0084
         clrb  
         std   >$009E
         std   $0E,x
         ldb   $05,y
         leay  <$10,y
         ldb   b,y
         stb   >$009A
         bsr   L079B
         stb   $0A,x
         ldx   #$FFB0
         lda   #$10
L0762    ldb   ,y+
         bsr   L079B
         stb   ,x+
         deca  
         bhi   L0762
         ldy   ,s++
         beq   L0772
         jsr   <$00B9
L0772    puls  y
         lbsr  L0107
         sty   <$002E
         stx   <$0030
         ldb   >$1000
         stb   >$1001
         ldd   <$003D
         std   <$005B
         ldd   <$003F
         std   <$005D
         lbsr  L142A
L078D    clrb  
         rts   
         suba  #$14
         suba  #$15
         suba  #$1D
         suba  #$1E
         com   <$0015
         com   <$0005
L079B    pshs  x
         tst   >$1009
         bne   L07A7
         leax  <L07A9,pcr
         ldb   b,x
L07A7    puls  pc,x
L07A9    fcb   $00,$0C,$02,$0E,$07,$09,$05,$10
         fcb   $1c,$2c,$0d,$1d,$0b,$1b,$0a,$2b
         fcb   $22,$11,$12,$21,$03,$01,$13,$32
         fcb   $1e,$2d,$1f,$2e,$0f,$3c,$2f,$3d
         fcb   $17,$08,$15,$06,$27,$16,$26,$36
         fcb   $19,$2a,$1a,$3a,$18,$29,$28,$38
         fcb   $14,$04,$23,$33,$25,$35,$24,$34
         fcb   $20,$3b,$31,$3e,$37,$39,$3f,$30
L07E9    clrb  
         lsra  
         rorb  
         lsra  
         rorb  
L07EE    lsra  
         rorb  
         std   <$0082
         clr   <$0084
         tfr   x,d
         suba  #$80
         addd  <$0083
         std   <$0083
         bcc   L0800
         inc   <$0082
L0800    rts   
L0801    ldd   <$0080
         addd  #$001F
L0806    andb  #$E0
         std   <$0080
         ldb   <$0057
         cmpb  #$FF
         beq   L0818
         tst   <$0032
         beq   L0818
         bsr   L0851
         bcc   L0848
L0818    ldd   <$0080
         cmpd  <$00B7
         bhi   L0829
         bsr   L0891
         bcs   L0829
         lda   #$01
         sta   $0F,x
         bra   L082E
L0829    lbsr  L08C1
         bcs   L0847
L082E    stb   <$007D
         stx   <$007E
         lbsr  L090D
         ldd   <$0057
         std   $03,x
         ldd   <$0080
         std   $05,x
         clra  
         clrb  
         std   $07,x
         std   $09,x
         std   $0C,x
         stb   $0E,x
L0847    rts   
L0848    comb  
         ldb   #$C2
         rts   
L084C    leax  <L0860,pcr
         bra   L0854
L0851    leax  <L086A,pcr
L0854    stx   <$00A1
         bsr   L088A
         ldb   <$0032
         beq   L0848
         ldx   <$0033
         bra   L0882
L0860    cmpb  <$11,y
         bne   L0878
         cmpx  <$12,y
         bra   L0876
L086A    lda   <$0057
         cmpa  $03,x
         bne   L0878
         lda   <$0058
         beq   L0888
         cmpa  $04,x
L0876    beq   L0888
L0878    stb   <$007D
         stx   <$007E
         ldb   ,x
         beq   L0848
         ldx   $01,x
L0882    jsr   <$00BC
         jmp   [>$00A1,u]
L0888    clra  
         rts   
L088A    clra  
         clrb  
         stb   <$007D
         std   <$007E
         rts   
L0891    pshs  y,b
         ldy   <$0080
         ldx   #$49E2
         stx   <$00A1
         lbsr  L09D5
         bcs   L08BF
         stb   ,s
         ldd   $05,x
         subd  <$0080
         bne   L08B5
         pshs  x
         lbsr  L092D
         puls  x
         ldb   ,s
         jsr   <$00BC
         bra   L08BE
L08B5    subd  <$00B5
         std   $05,x
         leax  <$20,x
         leax  d,x
L08BE    clra  
L08BF    puls  pc,y,b
L08C1    ldd   <$0080
         addd  <$00B5
         std   <$0097
         addd  #$1FFF
         lsra  
         lsra  
         lsra  
         lsra  
         lsra  
         tfr   a,b
         stb   <$0099
         lbsr  L015C
         bcs   L090C
         pshs  b
         ldb   <$0099
         cmpb  #$01
         bhi   L0901
         ldd   <$00B7
         subd  <$0097
         anda  #$1F
         std   <$009B
         beq   L0901
         ldd   <$00B7
         subd  <$009B
         addd  <$00B7
         tfr   d,x
         ldb   ,s
         addb  <$0099
         decb  
         jsr   <$00BC
         bsr   L091D
         ldd   <$009B
         subd  <$00B5
         std   $05,x
L0901    ldx   <$00B7
         puls  b
         jsr   <$00BC
         lda   <$0099
         sta   $0F,x
         clra  
L090C    rts   
L090D    pshs  b,a
         lda   <$0032
         sta   ,x
         stb   <$0032
         ldd   <$0033
         std   $01,x
         stx   <$0033
         puls  pc,b,a
L091D    pshs  b,a
         lda   <$0035
         sta   ,x
         stb   <$0035
         ldd   <$0036
         std   $01,x
         stx   <$0036
         puls  pc,b,a
L092D    pshs  y,a
         lda   ,x
         ldy   $01,x
         ldx   <$007E
         ldb   <$007D
         bne   L0941
         sta   <$0035
         sty   <$0036
         bra   L0948
L0941    jsr   <$00BC
         sta   ,x
         sty   $01,x
L0948    puls  pc,y,a
L094A    ldb   #$01
         stb   <$0097
L094E    lbsr  L0851
         bcs   L095D
         clr   <$0097
         bsr   L0963
         bcs   L0962
         ldb   <$0058
         beq   L094E
L095D    lda   <$0097
         bne   L0962
         clrb  
L0962    rts   
L0963    pshs  y,x,b
         lda   $0F,x
         sta   <$009F
         lda   ,x
         ldy   $01,x
         ldb   <$007D
         bne   L0979
         sta   <$0032
         sty   <$0033
         bra   L0982
L0979    jsr   <$00BC
         ldx   <$007E
         sta   ,x
         sty   $01,x
L0982    ldb   ,s
         lda   <$009F
         cmpa  #$01
         bgt   L09A9
         tfr   b,a
         bsr   L09B3
         bcc   L09A0
         leax  <L09FA,pcr
         stx   <$00A1
         ldx   $01,s
         bsr   L09D5
         jsr   <$00BC
         lbsr  L091D
         bra   L09B1
L09A0    ldx   #$4A23
         stx   <$00A1
         ldx   $01,s
         bsr   L09D5
L09A9    clra  
         tfr   d,x
         ldb   <$009F
         lbsr  L016A
L09B1    puls  pc,y,x,b
L09B3    pshs  x,b
         ldb   <$0032
         beq   L09CF
         cmpa  <$0032
         beq   L09D2
         ldx   <$0033
L09BF    jsr   <$00BC
         cmpa  ,x
         beq   L09D2
         tst   ,x
         beq   L09CF
         ldb   ,x
         ldx   $01,x
         bra   L09BF
L09CF    clrb  
         puls  pc,x,b
L09D2    comb  
         puls  pc,x,b
L09D5    pshs  u,x,b,a
L09D7    lbsr  L088A
         ldb   <$0035
         beq   L0A3D
         ldx   <$0036
         bra   L0A33
         cmpy  $05,x
         bhi   L0A27
         stb   $01,s
         stx   $02,s
         clrb  
         puls  pc,u,x,b,a
L09EE    tfr   u,d
         addd  $05,u
         addd  <$00B5
         stx   ,--s
         cmpd  ,s++
         rts   
L09FA    cmpb  $01,s
         bne   L0A27
         ldu   $02,s
         ldb   ,x
         stb   ,u
         ldd   $01,x
         std   $01,u
         exg   x,u
         bsr   L09EE
         beq   L0A14
         exg   x,u
         bsr   L09EE
         bne   L0A27
L0A14    stu   $02,s
         ldd   $05,u
         addd  $05,x
         addd  <$00B5
         std   $05,u
L0A1E    lbsr  L092D
         bra   L09D7
         cmpb  ,s
         beq   L0A1E
L0A27    ldb   <$008A
         stb   <$007D
         stx   <$007E
         ldb   ,x
         beq   L0A3D
         ldx   $01,x
L0A33    ldu   $04,s
         jsr   <$00BC
         ldu   $04,s
         jmp   [>$00A1,u]
L0A3D    comb  
         puls  pc,u,x,b,a
L0A40    lbsr  L0851
         bcs   L0A54
         pshs  b
         ldd   <$1F,y
         cmpd  $05,x
         puls  b
         bls   L0A61
         lbra  L0AF1
L0A54    ldd   <$1F,y
         std   <$0080
         lbsr  L0801
         bcc   L0A5F
         rts   
L0A5F    ldb   <$007D
L0A61    stb   <$21,y
         clra  
         clrb  
         std   <$0047
         ldb   <$0060
         lbsr  L0B36
         lbsr  L0B74
         leax  <$20,x
         stx   <$22,y
         bra   L0AEF
L0A78    pshs  y
         ldb   <$21,y
         stb   <$0097
         jsr   <$00BC
         ldx   <$22,y
         leay  >$0100,u
L0A88    ldb   ,y+
         stb   ,x+
         deca  
         beq   L0A9E
         cmpx  #$4000
         bcs   L0A88
         inc   <$0097
         ldb   <$0097
         jsr   <$00BC
         ldx   <$00B7
         bra   L0A88
L0A9E    puls  y
         ldb   <$0097
         stb   <$21,y
         stx   <$22,y
         bra   L0AEF
L0AAA    lbsr  L1DA2
         bcs   L0AF4
         lbsr  L1DAD
         ldd   ,x
         subd  <$00B3
         cmpd  <$1B,y
L0ABA    lbhi  L1E44
         ldd   $02,x
         subd  <$00B3
         cmpd  <$1D,y
         bhi   L0ABA
         jsr   <$00B9
         bsr   L0B16
         lbsr  L0851
         bcc   L0AD7
         lbsr  L0801
         bcc   L0AE2
         rts   
L0AD7    stb   <$007D
         stx   <$007E
         ldd   <$0080
         cmpd  $05,x
         bhi   L0AF1
L0AE2    lbsr  L0B74
         lbsr  L1E48
         stx   <$0072
         ldx   <$007E
         lbsr  L0B98
L0AEF    clrb  
         rts   
L0AF1    comb  
         ldb   #$BF
L0AF4    rts   
L0AF5    ldd   -$0D,y
         std   <$0072
         bsr   L0B16
         ldd   #$FFFF
         std   <$0057
         lbsr  L0801
         bcs   L0B15
         ldb   <$007D
         stb   <$11,y
         ldd   <$007E
         std   <$12,y
         bsr   L0B74
         lbsr  L0B98
         clrb  
L0B15    rts   
L0B16    pshs  x
         ldb   <$0060
         bpl   L0B23
         ldd   <$004F
         lslb  
         stb   <$0009
         bra   L0B25
L0B23    bsr   L0B36
L0B25    ldb   <$0009
         ldx   <$0051
         lbsr  L1E21
         std   <$0080
         ldb   <$0063
         subb  <$0009
         stb   <$000A
         puls  pc,x
L0B36    lda   #$07
         decb  
         beq   L0B43
         lda   #$01
         cmpb  #$03
         beq   L0B43
         lda   #$03
L0B43    sta   <$0097
         ldb   <$0048
         comb  
         andb  <$0097
         incb  
         stb   <$0006
         clra  
         cmpd  <$004F
         bge   L0B5E
         ldb   <$0050
         subb  <$0006
         andb  <$0097
         bne   L0B5E
         ldb   <$0097
         incb  
L0B5E    stb   <$0007
         clra  
         ldb   <$0048
         andb  <$0097
         addd  <$004F
         addb  <$0097
         adca  #$00
L0B6B    lsra  
         rorb  
         lsr   <$0097
         bne   L0B6B
         stb   <$0009
         rts   
L0B74    ldd   <$004F
         std   $07,x
         ldd   <$0051
         std   $09,x
         ldb   <$0060
         stb   $0E,x
         ldd   <$0006
         std   $0C,x
         ldb   <$0009
         stb   $0B,x
         clra  
         std   <$004F
         rts   
L0B8C    tfr   y,x
         lda   <$0097
         sta   <$000A
         lda   #$01
         sta   <$0099
         bra   L0B9A
L0B98    clr   <$0099
L0B9A    pshs  y
         leay  <$20,x
         ldx   <$0072
L0BA1    lda   <$0050
L0BA3    tst   <$0099
         bne   L0BAD
         ldb   ,x+
         stb   ,y+
         bra   L0BB1
L0BAD    ldb   ,y+
         stb   ,x+
L0BB1    cmpy  #$4000
         bcs   L0BBA
         lbsr  L0D63
L0BBA    deca  
         bne   L0BA3
         ldb   <$000A
         abx   
         dec   <$0052
         bne   L0BA1
         puls  pc,y
L0BC6    jsr   <$00B9
         lbsr  L1F65
         lbsr  L0851
         bcs   L0C00
         stb   <$007D
         stx   <$007E
         ldd   $07,x
         std   <$004F
         ldd   $09,x
         std   <$0051
         lbsr  L1DA2
         bcs   L0C00
         lbsr  L1DAD
         lbsr  L1E48
         stx   <$0072
         stb   <$0074
         ldy   <$007E
         lda   #$01
         bsr   L0C1D
         bcs   L0BF9
         lbsr  L0CAE
         bra   L0BFF
L0BF9    lbsr  L0D00
         lbsr  L0D88
L0BFF    clrb  
L0C00    rts   
L0C01    pshs  y
         ldd   -$0D,y
         std   <$0072
         clra  
         clrb  
         std   <$0047
         ldy   <$007E
         bsr   L0C1D
         bcs   L0C18
         lbsr  L0B8C
         clrb  
         puls  pc,y
L0C18    comb  
         ldb   #$BE
         puls  pc,y
L0C1D    pshs  x
         ldb   <$0060
         cmpb  $0E,y
         bne   L0C6C
         tstb  
         bpl   L0C30
         ldb   #$FF
         stb   <$0000
         stb   <$0001
         bra   L0C61
L0C30    tsta  
         beq   L0C4A
         ldd   <$0047
         addd  $07,y
         subd  #$0001
         cmpd  <$006A
         bhi   L0C6C
         ldb   $0A,y
         addb  <$004A
         decb  
         cmpb  <$006D
         bhi   L0C6C
         ldb   <$0060
L0C4A    leax  <L0C79-1,pcr
         lda   <$0048
         coma  
         anda  b,x
         inca  
         cmpa  $0C,y
         bne   L0C6C
         bsr   L0C6F
         sta   <$0000
         ldd   $0D,y
         bsr   L0C6F
         stb   <$0001
L0C61    bsr   L0C9D
         ldb   <$0063
         subb  <$0050
         stb   <$0097
         clrb  
         puls  pc,x
L0C6C    comb  
         puls  pc,x
L0C6F    leax  <L0C7D-1,pcr
         ldb   b,x
         abx   
         lsla  
         ldd   a,x
L0C78    rts   
L0C79    fcb   7,3,3,1
L0C7D    fcb   L0C81-(L0C7D+1)
         fcb   L0C91-(L0C7D+1)
         fcb   L0C91-(L0C7D+1)
         fcb   L0C99-(L0C7D+1)

* 2 color masks (2 bytes/entry)
L0C81    fcb   %00000001,%10000000
         fcb   %00000011,%11000000
         fcb   %00000111,%11100000
         fcb   %00001111,%11110000
         fcb   %00011111,%11111000
         fcb   %00111111,%11111100
         fcb   %01111111,%11111110
         fcb   %11111111,%11111111
         
* 4 color masks
L0C91    fcb   %00000011,%11000000
         fcb   %00001111,%11110000
         fcb   %00111111,%11111100
         fcb   %11111111,%11111111
 
* 16 color masks
L0C99    fcb   %00001111,%11110000
         fcb   %11111111,%11111111
 
L0C9D    ldd   $0A,y
         stb   <$0050
         sta   <$0052
         rts   
L0CA4    ldd   <$0047
         std   <$00AB
         ldx   <$0072
         leay  <$20,y
         rts   
L0CAE    lbsr  L0E3F
         pshs  y
         bsr   L0CA4
         inc   <$0097
         dec   <$0050
L0CB9    ldd   <$00AB
         std   <$0047
         ldb   <$0000
         lda   <$0050
         beq   L0CE8
         sta   <$0099
         bra   L0CC9
L0CC7    ldb   #$FF
L0CC9    lda   ,y+
         lbsr  L1F06
         ldd   <$0047
         addb  <$0005
         bcc   L0CD5
         inca  
L0CD5    std   <$0047
         leax  $01,x
         cmpy  #$4000
         bcs   L0CE2
         lbsr  L0D63
L0CE2    dec   <$0099
         bne   L0CC7
         ldb   <$0001
L0CE8    lda   ,y+
         lbsr  L1F06
         cmpy  #$4000
         bcs   L0CF5
         bsr   L0D63
L0CF5    ldb   <$0097
         abx   
         inc   <$004A
         dec   <$0052
         bne   L0CB9
         puls  pc,y
L0D00    pshs  y
         ldd   <$006A
         subd  <$0047
         addd  <$00B3
         std   <$009B
         ldb   <$006D
         subb  <$004A
         bra   L0D27
L0D10    pshs  y
         lda   <$0060
         lsra  
         ldd   #$027F
         bcs   L0D1D
         ldd   #$013F
L0D1D    subd  <$003D
         addd  <$00B3
         std   <$009B
         ldb   #$BF
         subb  <$0040
L0D27    incb  
         stb   <$00A0
         lbsr  L1E9C
         lbsr  L0C9D
         ldd   $0C,y
         std   <$0006
         lbsr  L06A4
         abx   
         lda   ,x+
         stx   <$0002
         leax  <L0D6D-1,pcr
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
L0D63    inc   <$007D
         ldb   <$007D
         jsr   <$00BC
         ldy   <$00B7
L0D6C    rts

* Index to proper tables for GP buffer's original screen types
L0D6D    fcb   L0D71-(L0D6D-1) Type 5 (2 color)
         fcb   L0D7C-(L0D6D-1) Type 6 (4 color)
         fcb   L0D7C-(L0D6D-1) Type 7 (4 color)
         fcb   L0D83-(L0D6D-1) Type 8 (16 color)
* All of following tables' references to pixel # are based on 1 being the
*  far left pixel in the byte
* Vector table for GP buffer's taken from 2 color screens
L0D71    fcb   L0DD3-L0D71    <$00A3 vector
         fcb   %00000001      Bit mask for 1 pixel
         fcb   8              # pixels /byte
         fcb   L0DD4-L0D71    Shift for 1st pixel
         fcb   L0DCD-L0D71    Shift for 2nd pixel
         fcb   L0DCE-L0D71    Shift for 3rd pixel
         fcb   L0DCF-L0D71    Shift for 4th pixel
         fcb   L0DD0-L0D71    Shift for 5th pixel
         fcb   L0DD1-L0D71    Shift for 6th pixel
         fcb   L0DD2-L0D71    Shift for 7th pixel
         fcb   L0DD3-L0D71    Shift for 8th pixel
* Vector table for GP buffer's taken from 4 color screens
L0D7C    fcb   L0DD2-L0D7C <$00A3 vector
         fcb   %00000011      Bit mask for 1 pixel
         fcb   4              # pixels/byte
         fcb   L0DD4-L0D7C Shift for 1st pixel
         fcb   L0DCE-L0D7C Shift for 2nd pixel
         fcb   L0DD0-L0D7C Shift for 3rd pixel
         fcb   L0DD2-L0D7C Shift for 4th pixel
* Vector table for GP buffer's taken from 16 color screens
L0D83    fcb   L0DD0-L0D83    <$00A3 vector
         fcb   %00001111      Bit mask for 1 pixel
         fcb   2              # pixels/byte
         fcb   L0DD4-L0D83    Shift for 1st pixel
         fcb   L0DD0-L0D83    Shift for 2nd pixel
  
L0D88    lbsr  L0CA4
         pshs  y
L0D8D    stx   <$0072
         ldd   <$00AB
         std   <$0047
         ldd   <$009B
         std   <$009D
         lda   <$0050
         sta   <$0004
         ldb   <$0006
         stb   <$0097
         ldd   <$00A5
         std   <$00A1
         ldb   <$0074
L0DA5    ldy   ,s
         cmpy  #$4000
         bcs   L0DB4
         stb   <$0099
         bsr   L0D63
         ldb   <$0099
L0DB4    lda   ,y+
         sty   ,s
         ldy   <$0002
         pshs  y
         leay  <L0DD4,pcr
         cmpy  <$00A1
         puls  y
         beq   L0DD4
         lsla  
         jmp   [>$00A1,u]
L0DCD    rola  EDA
L0DCE    rola  EDB
L0DCF    rola  EDC
L0DD0    rola  EDD
L0DD1    rola  EDE
L0DD2    rola  EDF
L0DD3    rola  EE0
L0DD4    pshs  b,a,cc
         ldd   <$009D
         beq   L0DEC
         subd  <$00B3
         std   <$009D
         ldd   $01,s
         anda  <$0008
         lda   a,y
         lbsr  L1F06
         lbsr  L1EB3
         stb   $02,s
L0DEC    dec   <$0097
         beq   L0DF6
         puls  b,a,cc
         jmp   [>$00A3,u]
L0DF6    leas  $03,s
         dec   <$0004
         beq   L0E12
         lda   <$0004
         cmpa  #$01
         beq   L0E06
         lda   <$0005
         bra   L0E08
L0E06    lda   <$0007
L0E08    sta   <$0097
         ldy   <$00A3
         sty   <$00A1
         bra   L0DA5
L0E12    ldx   <$0072
         ldb   <$0063
         abx   
         dec   <$00A0
         beq   L0E23
         inc   <$004A
         dec   <$0052
         lbne  L0D8D
L0E23    puls  pc,y
L0E25    lbsr  L0851
         bcs   L0E9F
         stb   <$0097
         ldb   $0F,x
         stb   <$0099
         ldd   $05,x
         std   <$009B
         leax  <$20,x
         tfr   x,d
         anda  #$1F
         std   <$009D
         bra   L0E9E
L0E3F    ldb   <$0060
         leax  >L15C3,pcr
         lda   b,x
         tfr   a,b
         cmpd  $0C,y
         bne   L0E63
         leax  >L1F83,pcr
         cmpx  <$0064
         bne   L0E63
         leax  >L1F9A,pcr
         cmpx  <$0068
         bne   L0E63
         leas  $02,s
         lbra  L0B8C
L0E63    sta   <$0005
         rts   
L0E66    ldb   <$2A,y
         rorb  
         bcc   L0E6E
         clrb  
         rts   
L0E6E    lbsr  L0107
         tsta  
         bpl   L0E8E
         cmpa  #$BF
         bhi   L0E84
         anda  #$EF
         suba  #$90
         cmpa  #$1A
         bcc   L0E8E
L0E80    lda   #$2E
         bra   L0E8E
L0E84    anda  #$DF
         suba  #$C1
         bmi   L0E80
         cmpa  #$19
         bhi   L0E80
L0E8E    ldb   <$0060
         bpl   L0E96
         bsr   L0EA0
         bra   L0E9B
L0E96    lbsr  L13FB
         bsr   L0EDE
L0E9B    lbsr  L10D0
L0E9E    clrb  
L0E9F    rts   
L0EA0    cmpa  #$60
         bne   L0EA6
         lda   #$27
L0EA6    cmpa  #$5F
         bne   L0EAC
         lda   #$7F
L0EAC    cmpa  #$5E
         bne   L0EB2
         lda   #$60
L0EB2    ldx   -$05,y
         tst   $09,y
         bmi   L0EC6
         ldb   $01,x
         andb  #$07
         stb   $01,x
         ldb   $08,y
         andb  #$F8
         orb   $01,x
         bra   L0EC8
L0EC6    ldb   $08,y
L0EC8    std   ,x
         ldd   <$00B3
         std   <$006E
         std   <$0070
         cmpy  <$002E
         bne   L0EDD
         sta   <$0039
         ldb   >$1000
         stb   >$1001
L0EDD    rts   
L0EDE    pshs  y,a
         ldb   $09,y
         stb   <$000E
         bitb  #$04
         beq   L0EEE
         ldd   <$0061
         exg   a,b
         std   <$0061
L0EEE    bsr   L0F31
         bcs   L0EFC
         lda   ,s
         ldb   $0B,x
         mul   
         cmpd  $05,x
         bcs   L0F01
L0EFC    leax  <L0F29,pcr
         bra   L0F05
L0F01    addd  <$00B5
         leax  d,x
L0F05    ldb   <$0060
         cmpb  #$01
         bne   L0F1B
         ldb   <$006F
         cmpb  #$08
         bne   L0F1B
         ldb   <$000E
         bitb  #$10
         bne   L0F1B
         bsr   L0F5C
         bra   L0F27
L0F1B    leay  >L100B,pcr
         sty   <$00A9
         ldy   $01,s
         bsr   L0F9A
L0F27    puls  pc,y,a
L0F29    fdb   0
         fdb   0
         fdb   0
         fdb   $1000
L0F31    pshs  a
         ldb   <$60
         bpl   L0F3F
         ldd   <$00B3
         std   <$006E
         std   <$0070
         bra   L0F5A
L0F3F    ldb   $0B,y
         bne   L0F4D
         ldd   #$0008
         std   <$006E
         std   <$0070
         comb  
         bra   L0F5A
L0F4D    jsr   <$00BC
         ldx   $0C,y
         ldd   $07,x
         std   <$006E
         ldd   $09,x
         std   <$0070
         clrb  
L0F5A    puls  pc,a
L0F5C    ldy   -$05,y
         exg   x,y
         lda   <$0071
         deca  
         sta   <$0097
L0F66    lda   ,y+
         ldb   <$000E
         bitb  #$20
         beq   L0F71
         lsra  
         ora   -$01,y
L0F71    tfr   a,b
         coma  
         tst   <$000E
         bmi   L0F7C
         anda  ,x
         bra   L0F7E
L0F7C    anda  <$0062
L0F7E    sta   ,x
         andb  <$0061
         orb   ,x
         stb   ,x
         ldb   <$0063
         abx   
         dec   <$0097
         bmi   L0F99
         bne   L0F66
         ldb   <$000E
         bitb  #$40
         beq   L0F66
         lda   #$FF
         bra   L0F71
L0F99    rts   
L0F9A    pshs  x
         leax  <L0FFB,pcr
         stx   <$0010
         ldx   ,s
         ldb   <$000E
         bitb  #$10
         beq   L0FD0
         ldb   <$0071
         decb  
         clra  
L0FAD    ora   b,x
         decb  
         bpl   L0FAD
         tsta  
         bne   L0FB9
         lsr   <$006F
         bra   L0FD0
L0FB9    ldb   #$FF
L0FBB    incb  
         lsla  
         bcc   L0FBB
         ldx   #$504C
         ldb   b,x
         leax  b,x
         stx   <$0010
         ldb   #$01
L0FCA    incb  
         lsla  
         bcs   L0FCA
         stb   <$006F
L0FD0    puls  x
         ldb   -$03,y
         stb   <$000F
         ldy   -$05,y
         exg   x,y
         lda   <$0071
         deca  
         sta   <$0099
         stx   <$000C
         lbsr  L1E9C
         ldx   <$000C
L0FE7    lda   ,y+
         ldb   <$000E
         bitb  #$20
         beq   L0FF2
         lsra  
         ora   -$01,y
L0FF2    jmp   [<$10,u]
         lsla  
         lsla  
         lsla  
         lsla  
         lsla  
         lsla  
L0FFB    sta   <$000B
L0FFD    lda   <$006F
         sta   <$0097
         ldb   <$000F
         stx   <$000C
L1005    pshs  b
         jmp   [>$00A9,u]
L100B    lsl   <$000B
         bcs   L1017
         lda   <$000E
         bpl   L102A
         lda   <$0062
         bra   L1019
L1017    lda   <$0061
L1019    comb  
         andb  ,x
         stb   ,x
         anda  ,s
         ora   ,x
         sta   ,x
         bra   L102A
         eorb  ,x
         stb   ,x
L102A    dec   <$0097
         beq   L1035
         puls  b
         lbsr  L1EB9
         bra   L1005
L1035    puls  b
         ldx   <$000C
         ldb   <$0063
         abx   
         dec   <$0099
         bmi   L104C
         bne   L0FE7
         lda   <$000E
         bita  #$40
         beq   L0FE7
         lda   #$FF
         bra   L0FFB
L104C    rts   
L104D    fcb   $AF,$AE,$AD,$AC,$AB,$AA,$A9,$AB
L1055    bsr   L1063
         lbsr  L10FF
         bra   L10A5
L105C    bsr   L1063
         lbsr  L1485
         bra   L10A5
L1063    jsr   <$00B9
         lbra  L0F31
L1068    bsr   L1063
         clra  
         ldb   <$0047
         subd  <$00B5
         tfr   d,x
         ldb   <$006F
         lbsr  L1E21
         std   <$0047
         addd  <$006E
         subd  <$00B3
         cmpd  <$1B,y
         bhi   L10A5
         clra  
         ldb   <$0049
         subd  <$00B5
         tfr   d,x
         ldb   <$0071
         lbsr  L1E21
         std   <$0049
         addd  <$0070
         subd  <$00B3
         cmpd  <$1D,y
         bhi   L10A5
         ldd   <$0047
L109C    std   -$02,y
         ldd   <$0049
         std   ,y
         lbsr  L1131
L10A5    clrb  
         rts   
L10A7    clra  
         clrb  
         std   ,y
         lbra  L112D
L10AE    ldd   -$02,y
         subd  <$006E
         std   -$02,y
         lbpl  L1139
         ldd   <$1B,y
         subd  <$006E
         addd  <$00B3
         std   -$02,y
         ldd   ,y
         subd  <$0070
         std   ,y
         bpl   L1139
         clra  
         clrb  
         std   -$02,y
         std   ,y
         rts   
L10D0    ldd   -$02,y
         tfr   d,x
         addd  <$006E
         std   -$02,y
         addd  <$006E
         subd  <$00B3
         cmpd  <$1B,y
         bls   L1139
         lda   <$2A,y
         bpl   L10F0
         stx   -$02,y
         ora   #$01
         sta   <$2A,y
         bra   L1139
L10F0    bsr   L112D
         bra   L1119
L10F4    ldd   ,y
         subd  <$0070
         bmi   L10FE
         std   ,y
         bsr   L1139
L10FE    rts   
L10FF    cmpa  #$0D
         beq   L112D
         cmpa  #$01
         beq   L10A7
         cmpa  #$08
         beq   L10AE
         cmpa  #$06
         beq   L10D0
         cmpa  #$09
         beq   L10F4
         cmpa  #$0A
         lbne  L1267
L1119    ldd   ,y
         addd  <$0070
         tfr   d,x
         addd  <$0070
         subd  <$00B3
         cmpd  <$1D,y
         bhi   L1149
         stx   ,y
         bra   L1139
L112D    clra  
         clrb  
         std   -$02,y
L1131    lda   <$2A,y
         anda  #$FE
         sta   <$2A,y
L1139    ldd   -$02,y
         std   <$0047
         ldd   ,y
         std   <$0049
         lbsr  L1E48
         stx   -$05,y
         stb   -$03,y
         rts   
L1149    pshs  y
         ldb   $02,y
         lbsr  L1252
         std   <$0097
         clra  
         ldb   <$0063
         std   <$0099
         ldd   ,y
         std   <$009D
         lda   -$08,y
         deca  
         sta   <$009B
         beq   L1184
         ldx   -$0D,y
         ldd   $04,y
         tfr   x,y
         leax  d,x
         tst   <$0060
         bmi   L1175
         lda   <$009B
         lsla  
         lsla  
         lsla  
         sta   <$009B
L1175    ldd   <$0097
         lbsr  L121F
         ldd   <$0099
         leax  d,x
         leay  d,y
         dec   <$009B
         bne   L1175
L1184    puls  y
         ldd   <$009D
L1188    lbra  L127A
L118B    lda   #$80
         ora   <$2A,y
         bra   L1197
L1192    lda   #$7E
         anda  <$2A,y
L1197    sta   <$2A,y
         clrb  
         rts   
L119C    cmpa  #$26
         beq   L118B
         cmpa  #$27
         beq   L1192
         cmpa  #$30
         beq   L11AD
         cmpa  #$31
         beq   L11E1
         rts   
L11AD    pshs  y
         ldd   ,y
         std   <$009D
         ldb   $02,y
         lbsr  L1252
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
         bcs   L1184
         stb   <$009B
         ldb   <$0063
         mul   
         addd  -$0D,y
         tfr   d,x
         addd  $04,y
         tfr   d,y
         bra   L1175
L11E1    pshs  y
         ldb   $02,y
         bsr   L1252
         std   <$0097
         clra  
         ldb   <$0063
         std   <$0099
         lda   -$08,y
         deca  
         tst   <$0060
         bmi   L11F8
         lsla  
         lsla  
         lsla  
L11F8    suba  $01,y
         bhi   L1202
         puls  y
         ldd   ,y
         bra   L1188
L1202    sta   <$009B
         ldd   <$1D,y
         subd  <$0070
         addd  <$00B3
         std   <$009D
         lda   <$0063
         ldb   $01,y
         mul   
         addd  -$0D,y
         tfr   d,x
         ldd   $04,y
         tfr   x,y
         leax  d,x
         lbra  L1175
L121F    pshs  u,y,x,dp,cc
         pshs  a
         tstb  
         beq   L122D
L1226    lda   ,x+
         sta   ,y+
         decb  
         bne   L1226
L122D    puls  b
         tstb  
         beq   L1250
         orcc  #$50
         stb   >$1006
         sts   >$1003
         tfr   x,u
         tfr   y,s
         leas  $07,s
L1241    pulu  y,x,dp,b,a
         pshs  y,x,dp,b,a
         leas  $0E,s
         dec   >$1006
         bne   L1241
         lds   >$1003
L1250    puls  pc,u,y,x,dp,cc
L1252    tfr   b,a
         lsra  
         lsra  
         lsra  
         andb  #$07
         pshs  a
         addb  ,s+
L125D    cmpb  #$07
         blt   L1266
         subb  #$07
         inca  
         bra   L125D
L1266    rts   
L1267    cmpa  #$03
         beq   L1278
         cmpa  #$04
         beq   L1285
         cmpa  #$0B
         beq   L12B4
         cmpa  #$0C
         beq   L129C
         rts   
L1278    ldd   ,y
L127A    std   <$0049
         clra  
         clrb  
         std   <$0047
         ldd   <$1B,y
         bra   L1292
L1285    ldd   -$02,y
         std   <$0047
         ldd   ,y
         std   <$0049
         ldd   <$1B,y
         subd  -$02,y
L1292    addd  <$00B3
         std   <$004F
         ldd   <$0070
         std   <$0051
         bra   L12C8
L129C    lbsr  L10A7
         clra  
         clrb  
         std   <$0047
         bsr   L12A7
         bra   L12C4
L12A7    std   <$0049
         ldd   <$1B,y
         addd  <$00B3
         std   <$004F
         ldd   <$1D,y
         rts   
L12B4    bsr   L1285
         clra  
         clrb  
         std   <$0047
         ldd   ,y
         addd  <$0070
         bsr   L12A7
         subd  <$0049
         bmi   L12CE
L12C4    addd  <$00B3
         std   <$0051
L12C8    ldb   <$0060
         bmi   L12CF
         bsr   L12FA
L12CE    rts   
L12CF    pshs  y
         lbsr  L1E48
         lda   #$20
         ldb   $08,y
         andb  #$38
         orb   <$0062
         std   <$0097
         ldb   <$0063
         subb  <$0050
         subb  <$0050
         stb   <$0099
L12E6    ldy   <$004F
         ldd   <$0097
L12EB    std   ,x++
         leay  -$01,y
         bne   L12EB
         ldb   <$0099
         abx   
         dec   <$0052
         bne   L12E6
         puls  pc,y
L12FA    ldb   <$0060
         ldx   #$4C78
         lda   <$0048
         coma  
         anda  b,x
         inca  
         sta   <$0097
         ldx   #$4C7C
         ldb   b,x
         abx   
         lsla  
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
         beq   L132C
         lsra  
         rorb  
         cmpx  <$00B3
         bne   L132C
         lsra  
         rorb  
L132C    stb   <$0097
         ldb   <$0063
         subb  <$0097
         subb  #$01
         stb   <$0099
         lbsr  L1E48
         lda   <$0012
         inca  
         beq   L1360
L133E    lda   <$0012
         tfr   a,b
         coma  
         anda  ,x
         sta   ,x
         andb  <$0062
         orb   ,x
         stb   ,x+
         lda   <$0097
         beq   L1358
         ldb   <$0062
L1353    stb   ,x+
         deca  
         bne   L1353
L1358    ldb   <$0099
         abx   
         dec   <$0052
         bne   L133E
         rts   
L1360    pshs  u
         lda   <$0062
         tfr   a,b
         tfr   d,u
         ldb   <$0097
         incb  
         clr   <$0097
         lsrb  
         stb   <$0012
         bcc   L1374
         inc   <$0097
L1374    ldb   <$0097
         beq   L137A
         sta   ,x+
L137A    ldb   <$0012
         beq   L1383
L137E    stu   ,x++
         decb  
         bne   L137E
L1383    ldb   <$0099
         abx   
         dec   <$0052
         bne   L1374
         puls  pc,u
L138C    lbsr  L1063
         bsr   L1393
         clrb  
         rts   
L1393    cmpa  #$21
         beq   L13C9
         cmpa  #$22
         beq   L13D3
         cmpa  #$23
         beq   L13DB
         cmpa  #$24
         beq   L13E4
         cmpa  #$25
         beq   L13EA
         cmpa  #$20
         lbne  L119C
         ldb   $09,y
         bitb  #$04
         bne   L13C8
         orb   #$04
L13B5    stb   $09,y
         lda   $08,y
         lbsr  L14B4
         pshs  b,a
         ldb   $08,y
         andb  #$C0
         orb   ,s+
         orb   ,s+
         stb   $08,y
L13C8    rts   
L13C9    ldb   $09,y
         bitb  #$04
         beq   L13C8
         andb  #$FB
         bra   L13B5
L13D3    ldd   $08,y
         ora   #$40
         orb   #$40
         bra   L13E1
L13DB    ldd   $08,y
         anda  #$BF
         andb  #$BF
L13E1    std   $08,y
         rts   
L13E4    ldb   $08,y
         orb   #$80
         bra   L13EE
L13EA    ldb   $08,y
         andb  #$7F
L13EE    stb   $08,y
         rts   
L13F1    lbsr  L0107
         bsr   L1454
         lbsr  L14C1
L13F9    clrb  
         rts   
L13FB    pshs  y,x,b,a
         bsr   L146D
         lbsr  L14E3
         ldb   >$1000
         stb   >$1001
         puls  pc,y,x,b,a
L140A    lbsr  L0107
         cmpy  <$002E
         bne   L1428
         ldd   <$005B
         cmpd  <$003D
         bne   L1420
         ldd   <$005D
         cmpd  <$003F
         beq   L1428
L1420    lbsr  L14E3
         bsr   L142A
         lbsr  L14C1
L1428    bra   L13F9
L142A    ldd   <$0047
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
         lbsr  L1E4A
         stx   <$0041
         stb   <$0043
         puls  b,a
         std   <$0049
         puls  b,a
         std   <$0047
         rts   
L1452    bsr   L147E
L1454    lbsr  L0F31
         cmpy  <$002E
         bne   L146A
         ldb   $09,y
         bitb  #$02
         bne   L146A
         ldb   <$0039
         bne   L146A
         bsr   L148E
         inc   <$0039
L146A    rts   
L146B    bsr   L147E
L146D    lbsr  L0F31
         cmpy  <$002E
         bne   L147D
         ldb   <$0039
         beq   L147D
         bsr   L148E
         clr   <$0039
L147D    rts   
L147E    eora  #$21
         ldb   #$02
         lbra  L034E
L1485    cmpa  #$20
         beq   L146B
         cmpa  #$21
         beq   L1452
         rts   
L148E    pshs  y
         ldx   -$05,y
         ldb   <$0060
         bpl   L14A8
         lda   $01,x
         bsr   L14B4
         pshs  b,a
         ldb   $01,x
         andb  #$C0
         orb   ,s+
         orb   ,s+
         stb   $01,x
         bra   L14B2
L14A8    ldx   #$5026
         stx   <$00A9
         clr   <$000E
         lbsr  L0F9A
L14B2    puls  pc,y
L14B4    tfr   a,b
         anda  #$38
         lsra  
         lsra  
         lsra  
         andb  #$07
         lslb  
         lslb  
         lslb  
         rts   
L14C1    pshs  y,x
         ldx   -$10,y
         cmpx  <$0030
         bne   L14E1
         ldb   <$003A
         bne   L14E1
         ldb   <$18,y
         stb   <$0044
         beq   L14E1
         jsr   <$00BC
         ldy   <$19,y
         sty   <$0045
         bsr   L14FE
         inc   <$003A
L14E1    puls  pc,y,x
L14E3    pshs  y,x
         ldx   -$10,y
         cmpx  <$0030
         bne   L14FC
         ldb   <$003A
         beq   L14FC
         ldb   <$0044
         beq   L14E1
         jsr   <$00BC
         ldy   <$0045
         bsr   L14FE
         clr   <$003A
L14FC    puls  pc,y,x
L14FE    ldb   <$0060
         bmi   L1535
         lda   <$004A
         ldx   <$0047
         pshs  x,a
         ldd   <$004F
         ldx   <$0051
         pshs  x,b,a
         ldd   <$0064
         pshs  b,a
         ldd   <$0041
         std   <$0072
         ldb   <$0043
         stb   <$0074
         ldx   #$5FA5
         stx   <$0064
         lbsr  L0D10
         lbsr  L0D88
         puls  b,a
         std   <$0064
         puls  x,b,a
         std   <$004F
         stx   <$0051
         puls  x,a
         sta   <$004A
         stx   <$0047
L1535    rts   
L1536    clr   <$0047
         clr   <$0049
         ldd   -$05,y
         subd  -$0D,y
L153E    cmpd  $04,y
         bcs   L1549
         subd  $04,y
         inc   <$0049
         bra   L153E
L1549    lda   [<-$10,y]
         cmpa  #$01
         beq   L1556
         lsrb  
         cmpa  #$04
         bne   L1556
         lsrb  
L1556    stb   <$0048
         rts   
L1559    tst   ,y
         bpl   L1562
L155D    comb  
         ldb   #$C0
         puls  pc,x
L1562    lbsr  L1DA2
         bcc   L1569
         puls  pc,x
L1569    jsr   <$00B9
         lbra  L1F65
         rts   
L156F    bsr   L1559
         lbsr  L1E48
         lda   <$0061
         lbsr  L1F06
         bra   L159B
L157B    bsr   L1559
         lbsr  L1DA9
         bcs   L159C
         ldd   <$0049
         cmpd  <$004D
         bne   L158D
         bsr   L159D
         bra   L159B
L158D    ldd   <$0047
         cmpd  <$004B
         bne   L1598
         bsr   L1607
         bra   L159B
L1598    lbsr  L1637
L159B    clrb  
L159C    rts   
L159D    bsr   L15B6
L159F    ldd   <$004B
         subd  <$0047
         addd  <$00B3
         std   <$0099
         bsr   L15B0
         lda   <$0061
         ldy   <$0099
         bra   L15C8
L15B0    lbsr  L1E9C
         lbra  L1E48
L15B6    ldd   <$004B
         cmpd  <$0047
         bge   L15C3
L15BD    ldx   <$0047
         std   <$0047
         stx   <$004B
L15C3    rts   
         lsl   <$0004
         lsr   <$0002
L15C8    pshs  u,y,x,b,a
         sta   $06,s
         leax  <L15C3,pcr
         ldb   <$0060
         clra  
         ldb   b,x
         std   $04,s
         puls  x,b,a
         bra   L15DC
L15DA    ldb   <$0079
L15DC    lbsr  L1F06
         leay  -$01,y
         beq   L1605
         lbsr  L1EB3
         bpl   L15DC
L15E8    cmpy  ,s
         bcs   L15DA
         ldb   #$FF
         lbsr  L1F06
         ldb   $01,s
         negb  
         leay  b,y
         beq   L1605
         leax  $01,x
         ldd   ,s
         addd  <$0047
         std   <$0047
         lda   $02,s
         bra   L15E8
L1605    puls  pc,x,b,a
L1607    bsr   L1629
L1609    ldd   <$004D
         subb  <$004A
         incb  
         std   <$0099
         lbsr  L1E48
         stb   <$0097
         lda   <$0061
         ldy   <$0099
L161A    ldb   <$0097
         lbsr  L1F06
         ldb   <$0063
         abx   
         inc   <$004A
         leay  -$01,y
         bne   L161A
         rts   
L1629    ldd   <$004D
         cmpd  <$0049
         bge   L1636
L1630    ldx   <$0049
         std   <$0049
         stx   <$004D
L1636    rts   
L1637    ldd   <$004B
         cmpd  <$0047
         bge   L1647
         lbsr  L15BD
         ldd   <$004D
         bsr   L1630
         ldd   <$004B
L1647    subd  <$0047
         std   <$0013
         ldb   <$0063
         clra  
         std   <$0017
         ldd   <$004D
         subd  <$0049
         std   <$0015
         bpl   L1666
         nega  
         negb  
         sbca  #$00
         std   <$0015
         ldd   <$0017
         nega  
         negb  
         sbca  #$00
         std   <$0017
L1666    clra  
         clrb  
         std   <$0075
         lbsr  L15B0
         stb   <$0074
L166F    ldb   <$0074
         lda   <$0061
         lbsr  L1F06
         ldd   <$0075
         bpl   L168C
         addd  <$0013
         std   <$0075
         ldd   <$0017
         leax  d,x
         bmi   L1688
         inc   <$004A
         bra   L1697
L1688    dec   <$004A
         bra   L1697
L168C    subd  <$0015
         std   <$0075
         ldb   <$0074
         lbsr  L1EB3
         stb   <$0074
L1697    ldd   <$0047
         cmpd  <$004B
         ble   L166F
         rts   
L169F    clra  
         clrb  
         std   <$0053
         std   <$0055
L16A5    lbsr  L1559
L16A8    lbsr  L1DA9
         bcc   L16AE
         rts   
L16AE    lbsr  L15B6
L16B1    lbsr  L1629
L16B4    lbsr  L1DD4
         leas  <-$1A,s
         sty   ,s
         ldd   <$0053
         std   $0A,s
         ldd   <$0055
         std   $0C,s
         ldd   <$0047
         std   $02,s
         addd  <$0053
         std   $0E,s
         std   <$0047
         ldd   <$0049
         std   $04,s
         addd  <$0055
         std   <$12,s
         ldd   <$004B
         std   $06,s
         subd  <$0053
         std   <$10,s
         std   <$004B
         ldd   <$004D
         std   $08,s
         subd  <$0055
         std   <$14,s
         lbsr  L159F
         ldd   $0E,s
         std   <$0047
         ldd   $08,s
         std   <$0049
         ldy   ,s
         lbsr  L159F
         ldd   $02,s
         std   <$0047
         ldd   <$12,s
         std   <$0049
         ldd   <$14,s
         std   <$004D
         ldy   ,s
         lbsr  L1609
         ldd   <$12,s
         std   <$0049
         ldd   $06,s
         std   <$0047
         ldy   ,s
         lbsr  L1609
         ldb   <$0054
         beq   L1786
         lda   #$FF
         sta   <$00AD
         negb  
         std   <$16,s
         ldb   <$0056
         negb  
         std   <$18,s
         bsr   L1791
         ldd   $0E,s
         std   <$0047
         ldd   <$12,s
         std   <$0049
         ldd   <$16,s
         std   <$0020
         ldd   <$18,s
         std   <$0026
         bsr   L178C
         ldd   <$10,s
         std   <$0047
         ldd   <$12,s
         std   <$0049
         ldd   <$18,s
         std   <$0022
         ldd   <$0053
         std   <$0024
         bsr   L178C
         ldd   $0E,s
         std   <$0047
         ldd   <$14,s
         std   <$0049
         ldd   <$0055
         std   <$0022
         ldd   <$16,s
         std   <$0024
         bsr   L178C
         ldd   <$10,s
         std   <$0047
         ldd   <$14,s
         std   <$0049
         ldd   <$0053
         std   <$0020
         ldd   <$0055
         std   <$0026
         bsr   L178C
L1786    leas  <$1A,s
         clr   <$00AD
         rts   
L178C    ldy   $02,s
         bsr   L1807
L1791    clra  
         clrb  
         std   <$0020
         std   <$0022
         std   <$0024
         std   <$0026
         ldd   $0C,s
         std   <$0053
         ldd   $0E,s
         std   <$0055
         rts   
L17A4    lbsr  L1559
         lbsr  L1DA9
         bcs   L17E6
         lbsr  L15B6
         lbsr  L1629
         ldd   <$0047
         std   <$0099
         ldd   <$004B
         subd  <$0047
         addd  <$00B3
         std   <$009B
         lbsr  L15B0
         lda   <$0061
         std   <$009D
         ldd   <$004D
         subb  <$004A
         incb  
         tfr   d,y
L17CC    pshs  y,x
         ldy   <$009B
         ldd   <$009D
         lbsr  L15C8
         puls  y,x
         ldb   <$0063
         abx   
         inc   <$004A
         ldd   <$0099
         std   <$0047
         leay  -$01,y
         bne   L17CC
         clrb  
L17E6    rts   
L17E7    ldx   #$5BDB
         bra   L17EF
L17EC    ldx   #$5A13
L17EF    stx   <$002C
         bsr   L1822
         ldd   <$0053
         lsra  
         rorb  
         std   <$0055
         bra   L1863
L17FB    bsr   L1822
         lbsr  L1DB1
         bcs   L17E6
         lbsr  L1DD0
         bcs   L17E6
L1807    ldx   #$5A13
         stx   <$002C
         ldd   <$0020
         cmpd  <$0024
         bne   L182B
         ldx   #$5A34
         ldd   <$0022
         cmpd  <$0026
         blt   L184D
         ldx   #$5A39
         bra   L184D
L1822    jsr   <$00B9
         ldb   <$0060
         lbmi  L155D
L182A    rts   
L182B    ldx   <$0022
         cmpx  <$0026
         bne   L183E
         ldx   #$5A3E
         cmpd  <$0024
         blt   L184D
         ldx   #$5A44
         bra   L184D
L183E    ldx   #$5A4A
         ldd   <$0020
         subd  <$0024
         std   <$0097
         ldd   <$0022
         subd  <$0026
         std   <$0099
L184D    stx   <$00A1
         bra   L1868
L1851    lbsr  L1ACE
         lbra  L1B69
L1857    ldx   #$5BDB
         bra   L185F
L185C    ldx   #$5A13
L185F    stx   <$002C
         bsr   L1822
L1863    ldx   #$5A4E
         stx   <$00A1
L1868    lbsr  L1F65
         tst   <$00AD
         bne   L1879
         lbsr  L1DA2
         bcs   L182A
         lbsr  L1DD4
         bcs   L182A
L1879    ldd   <$0047
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
         lbsr  L1AC5
         lbsr  L1B2E
         tfr   x,y
         leax  <$14,s
         ldd   <$0055
         lbsr  L1B3E
         leax  $0A,s
         bsr   L1851
         tfr   x,y
         leax  $0F,s
         bsr   L1851
         leax  <$19,s
         ldd   <$0055
         lbsr  L1AC5
         lbsr  L1B2E
         tfr   x,y
         leax  <$1E,s
         bsr   L1851
         tfr   x,y
         leax  <$23,s
         bsr   L1851
         leax  <$28,s
         clra  
         clrb  
         lbsr  L1AC5
         leax  <$2D,s
         ldd   <$001E
         lbsr  L1AC5
         subd  <$00B3
         lbsr  L1B2E
         leay  $0A,s
         lbsr  L1B40
         leay  $05,s
         bsr   L1960
         leax  ,s
         bsr   L1963
         ldd   <$00B3
         lbsr  L1AF0
         leay  <$1E,s
         lbsr  L1B40
         tfr   x,y
         leax  <$2D,s
         bsr   L1960
         leax  <$32,s
         leay  $0F,s
         bsr   L1963
         ldd   <$001E
         bsr   L195D
         leax  <$37,s
         leay  <$1E,s
         lbsr  L1ACE
L190F    leax  <$14,s
         leay  <$28,s
         lbsr  L1BBA
         ble   L1969
         lbsr  L1A0C
         tst   <$2D,s
         bmi   L193E
         leax  <$32,s
         leay  $0F,s
         bsr   L1960
         tfr   x,y
         leax  <$2D,s
         bsr   L1960
         leax  <$14,s
         leay  $05,s
         lbsr  L1B1F
         ldd   <$001E
         subd  <$00B3
         std   <$001E
L193E    leax  <$37,s
         leay  <$23,s
         bsr   L1960
         tfr   x,y
         leax  <$2D,s
         bsr   L1960
         leax  <$28,s
         leay  <$19,s
         bsr   L1960
         ldd   <$001C
         addd  <$00B3
         std   <$001C
         bra   L190F
L195D    lbra  L1B2E
L1960    lbra  L1B07
L1963    lbsr  L1ACE
         lbra  L1B9D
L1969    leax  <$2D,s
         ldd   <$001C
         lbsr  L1AC5
         addd  <$00B3
         bsr   L195D
         leay  <$1E,s
         lbsr  L1B40
         leax  ,s
         ldd   <$001E
         lbsr  L1AC5
         subd  #$0002
         bsr   L195D
         ldd   <$00B3
         lbsr  L1AF0
         leay  $0A,s
         lbsr  L1B40
         tfr   x,y
         leax  <$2D,s
         bsr   L1960
         leax  ,s
         leay  $0A,s
         bsr   L1963
         ldd   <$00B3
         lbsr  L1AF0
         leay  <$19,s
         lbsr  L1B40
         tfr   x,y
         leax  <$2D,s
         bsr   L1960
         leax  <$32,s
         leay  <$23,s
         lbsr  L1ACE
         ldd   <$001C
         bsr   L195D
         leax  <$37,s
         leay  $0F,s
         bsr   L1963
         ldd   <$001E
         bsr   L195D
         leay  $0A,s
         bsr   L1960
L19CC    ldd   <$001E
         addd  <$00B3
         beq   L1A07
         bsr   L1A0C
         tst   <$2D,s
         bpl   L19EE
         leax  <$32,s
         leay  <$23,s
         bsr   L1A04
         tfr   x,y
         leax  <$2D,s
         bsr   L1A04
         ldd   <$001C
         addd  <$00B3
         std   <$001C
L19EE    leax  <$37,s
         leay  $0F,s
         bsr   L1A04
         tfr   x,y
         leax  <$2D,s
         bsr   L1A04
         ldd   <$001E
         subd  <$00B3
         std   <$001E
         bra   L19CC
L1A04    lbra  L1B07
L1A07    leas  <$3E,s
         clrb  
         rts   
L1A0C    ldy   <$3E,s
         jmp   [<$2C,u]
         ldd   <$001C
         ldx   <$001E
         bsr   L1A2E
         nega  
         negb  
         sbca  #$00
         bsr   L1A2E
         exg   d,x
         nega  
         negb  
         sbca  #$00
         exg   d,x
         bsr   L1A2E
         ldd   <$001C
         bsr   L1A2E
         rts   
L1A2E    pshs  x,b,a
         jmp   [>$00A1,u]
         cmpd  <$0020
         bra   L1A46
         cmpd  <$0020
         bra   L1A40
         cmpx  <$0022
L1A40    ble   L1A4E
         bra   L1A70
         cmpx  <$0022
L1A46    bge   L1A4E
         bra   L1A70
         bsr   L1A72
         bgt   L1A70
L1A4E    addd  <$0018
         bmi   L1A70
         cmpd  <$1B,y
         bhi   L1A70
         std   <$0047
         tfr   x,d
         addd  <$001A
         bmi   L1A70
         cmpd  <$1D,y
         bhi   L1A70
         std   <$0049
         lbsr  L1E48
         lda   <$0061
         lbsr  L1F06
L1A70    puls  pc,x,b,a
L1A72    pshs  x,b,a
         tfr   x,d
         subd  <$0026
         ldx   <$0097
         bsr   L1A90
         pshs  x,b
         ldd   $03,s
         subd  <$0024
         ldx   <$0099
         bsr   L1A90
         cmpb  ,s
         bne   L1A8C
         cmpx  $01,s
L1A8C    leas  $03,s
         puls  pc,x,b,a
L1A90    pshs  x,b,a
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
         bpl   L1ABA
         neg   $06,s
         addb  $06,s
L1ABA    tst   $05,s
         bpl   L1AC2
         neg   $04,s
         addb  $04,s
L1AC2    leas  $07,s
         rts   
L1AC5    clr   ,x
         clr   $01,x
         clr   $02,x
         std   $03,x
         rts   
L1ACE    pshs  b,a
         ldd   ,y
         std   ,x
         ldd   $02,y
         std   $02,x
         ldb   $04,y
         stb   $04,x
         puls  pc,b,a
L1ADE    exg   y,u
         exg   x,y
         bsr   L1ACE
         exg   x,y
         exg   y,u
         rts   
L1AE9    exg   x,u
         bsr   L1ACE
         exg   x,u
         rts   
L1AF0    pshs  b,a
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
L1B07    pshs  b,a
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
L1B1F    exg   x,y
         bsr   L1B9D
         exg   x,y
         bsr   L1B07
         exg   x,y
         bsr   L1B9D
         exg   x,y
         rts   
L1B2E    pshs  y,b,a
         clra  
         clrb  
         pshs  b,a
         pshs  b
         tfr   s,y
         bsr   L1B40
         leas  $03,s
         puls  pc,y,b,a
L1B3E    bsr   L1AC5
L1B40    pshs  u,y,b,a
         leas  -$0A,s
         tfr   s,u
         bsr   L1AE9
         tfr   u,y
         leau  $05,u
         bsr   L1ADE
         clra  
         clrb  
         lbsr  L1AC5
         bra   L1B57
L1B55    bsr   L1B74
L1B57    bsr   L1B7F
         beq   L1B61
         bcc   L1B55
         bsr   L1B07
         bra   L1B55
L1B61    bcc   L1B65
         bsr   L1B07
L1B65    leas  $0A,s
         puls  pc,u,y,b,a
L1B69    lsl   $04,x
         rol   $03,x
         rol   $02,x
         rol   $01,x
         rol   ,x
         rts   
L1B74    lsl   $04,y
         rol   $03,y
         rol   $02,y
         rol   $01,y
         rol   ,y
         rts   
L1B7F    lsr   ,u
         bne   L1B92
         ror   $01,u
         bne   L1B94
         ror   $02,u
         bne   L1B96
         ror   $03,u
         bne   L1B98
         ror   $04,u
         rts   
L1B92    ror   $01,u
L1B94    ror   $02,u
L1B96    ror   $03,u
L1B98    ror   $04,u
         andcc #$FB
         rts   
L1B9D    com   ,x
         com   $01,x
         com   $02,x
         com   $03,x
         com   $04,x
         inc   $04,x
         bne   L1BB9
         inc   $03,x
         bne   L1BB9
         inc   $02,x
         bne   L1BB9
         inc   $01,x
         bne   L1BB9
         inc   ,x
L1BB9    rts   
L1BBA    pshs  b,a
         ldd   ,x
         cmpd  ,y
         bne   L1BD9
         ldd   $02,x
         cmpd  $02,y
         bne   L1BD0
         ldb   $04,x
         cmpb  $04,y
         beq   L1BD9
L1BD0    bhi   L1BD6
         lda   #$08
         bra   L1BD7
L1BD6    clra  
L1BD7    tfr   a,cc
L1BD9    puls  pc,b,a
         ldd   <$0018
         addd  <$001C
         cmpd  <$1B,y
         bls   L1BE8
         ldd   <$1B,y
L1BE8    pshs  y,b,a
         std   <$004B
         ldd   <$0018
         subd  <$001C
         bpl   L1BF4
         clra  
         clrb  
L1BF4    pshs  b,a
         std   <$0047
         ldd   <$001A
         subd  <$001E
         bpl   L1C00
         clra  
         clrb  
L1C00    bsr   L1C15
         puls  y,x,b,a
         std   <$0047
         stx   <$004B
         ldd   <$001A
         addd  <$001E
         cmpd  <$1D,y
         bls   L1C15
         ldd   <$1D,y
L1C15    std   <$0049
         std   <$004D
         lbra  L159F
L1C1C    lbsr  L1559
         ldb   #$01
         stb   <$002A
         lbsr  L1E48
         stx   <$0072
         stb   <$0074
         lbsr  L1EF6
         sta   <$0028
         lbsr  L06AC
         cmpb  $06,y
         beq   L1C67
         clrb  
         pshs  b
         lbsr  L1E9C
         lbsr  L1EC8
         ldx   <$0072
         bra   L1C76
L1C43    tst   >$101B
         beq   L1C6C
         ldb   ,s+
         beq   L1C67
         stb   <$002B
         addb  ,s+
         cmpb  <$1E,y
         bhi   L1C72
         stb   <$004A
         puls  b,a
         std   <$0047
         puls  b,a
         std   <$004B
         lbsr  L1E48
         stb   <$0074
         lbra  L1CEE
L1C67    clrb  
         ldb   <$002A
         bne   L1C6F
L1C6C    ldb   #$BA
         coma  
L1C6F    lbra  L00F4
L1C72    leas  $04,s
         bra   L1C43
L1C76    ldb   <$0074
L1C78    lbsr  L1EDF
         bsr   L1CC4
         beq   L1C84
         lbsr  L1EF6
         beq   L1C78
L1C84    lbsr  L1EB3
         pshs  b
         ldd   <$0047
         std   <$009B
         puls  b
L1C8F    bsr   L1CD6
         bsr   L1CCC
         bhi   L1C9A
         lbsr  L1EF6
         beq   L1C8F
L1C9A    lbsr  L1EDF
         lbsr  L1D9A
         beq   L1CA8
         bsr   L1CB5
         lda   #$FF
         pshs  b,a
L1CA8    lbsr  L1D9A
         beq   L1C43
         bsr   L1CB5
         lda   #$01
         pshs  b,a
L1CB3    bra   L1C43
L1CB5    puls  b,a
         pshs  y,x,b,a
         ldd   <$0047
         std   $04,s
         ldd   <$009B
         std   $02,s
         ldb   <$004A
         rts   
L1CC4    pshs  b,a
         ldd   <$0047
         addd  <$00B3
         puls  pc,b,a
L1CCC    pshs  b,a
         ldd   <$0047
         cmpd  <$1B,y
         puls  pc,b,a
L1CD6    lda   ,x
         sta   ,-s
         lda   <$0061
         lbsr  L1F06
         lda   ,x
         cmpa  ,s+
         beq   L1CEA
         lda   #$FF
         sta   >$101B
L1CEA    lbsr  L1EB3
         rts   
L1CEE    ldd   <$0047
         subd  #$0002
         std   <$009B
         ldb   <$0074
L1CF7    lbsr  L1EF6
         bne   L1D03
         lbsr  L1EDF
         bsr   L1CC4
         bne   L1CF7
L1D03    lbsr  L1EB3
         stb   <$0074
         ldd   <$0047
         cmpd  <$004B
         bhi   L1CB3
         ldb   <$0074
         lbsr  L1EF6
         bne   L1D03
         ldd   <$0047
         cmpd  <$009B
         bgt   L1D34
         bsr   L1D9A
         beq   L1D34
         ldd   <$009B
         pshs  b,a
         ldd   <$0047
         bpl   L1D2B
         clra  
         clrb  
L1D2B    pshs  b,a
         ldb   <$004A
         lda   <$002B
         nega  
         pshs  b,a
L1D34    ldd   <$0047
         std   <$009B
         ldb   <$0074
L1D3A    lbsr  L1EF6
         bne   L1D45
         bsr   L1CD6
         bsr   L1CCC
         bls   L1D3A
L1D45    lbsr  L1EDF
         stb   <$0074
         bsr   L1D9A
         beq   L1D57
         lbsr  L1CB5
         lda   <$002B
         pshs  b,a
         ldb   <$0074
L1D57    lbsr  L1EB3
         stb   <$0074
         lbsr  L1CCC
         bgt   L1D71
         ldd   <$0047
         cmpd  <$004B
         bgt   L1D71
         ldb   <$0074
         lbsr  L1EF6
         bne   L1D57
         bra   L1D34
L1D71    cmps  <$003B
         bhi   L1D78
         clr   <$002A
L1D78    ldd   <$0047
         subd  <$00B3
         std   <$0047
         ldd   <$004B
         addd  #$0002
         cmpd  <$0047
         bhi   L1D97
         leas  -$02,s
         pshs  b,a
         ldd   <$0047
         std   $02,s
         ldb   <$004A
         lda   <$002B
         nega  
         pshs  b,a
L1D97    lbra  L1C43
L1D9A    cmps  <$003B
         bhi   L1DA1
         clr   <$002A
L1DA1    rts   
L1DA2    ldb   #$47
L1DA4    bsr   L1DD8
         lbra  L1E31
L1DA9    ldb   #$4B
         bra   L1DA4
L1DAD    ldb   #$4F
         bra   L1DA4
L1DB1    ldb   #$20
L1DB3    bsr   L1DD8
         ldd   #$027F
         bsr   L1DBF
         bcs   L1DCF
         ldd   #$00BF
L1DBF    pshs  b,a
         ldd   ,x++
         bpl   L1DC9
         nega  
         negb  
         sbca  #$00
L1DC9    cmpd  ,s++
         bgt   L1E44
         clrb  
L1DCF    rts   
L1DD0    ldb   #$24
         bra   L1DB3
L1DD4    ldb   #$53
         bra   L1DB3
L1DD8    tfr   u,x
         abx   
         lda   $09,y
         bita  #$08
         beq   L1DE5
         ldd   -$07,y
         bne   L1DE6
L1DE5    rts   
L1DE6    pshs  y,x,b,a
         tfr   x,y
         ldx   ,y
         ldb   ,s
         beq   L1DF4
         bsr   L1E00
         std   ,y
L1DF4    ldx   $02,y
         ldb   $01,s
         beq   L1DFE
         bsr   L1E00
         std   $02,y
L1DFE    puls  pc,y,x,b,a
L1E00    pshs  x,b
         leas  -$02,s
         lda   $04,s
         mul   
         cmpb  #$CD
         pshs  cc
         exg   a,b
         clra  
         puls  cc
         bcs   L1E14
         addd  <$00B3
L1E14    std   ,s
         lda   $03,s
         ldb   $02,s
         mul   
         addd  ,s
         leas  $03,s
         puls  pc,x
L1E21    pshs  x
         lda   ,s
         stb   ,s
         mul   
         stb   ,-s
         ldd   $01,s
         mul   
         adda  ,s+
         puls  pc,x
L1E31    ldd   ,x
         cmpd  <$1B,y
         bhi   L1E44
         ldd   $02,x
         cmpd  <$1D,y
         bhi   L1E44
         andcc #$FE
         rts   
L1E44    comb  
         ldb   #$BD
         rts   
L1E48    ldd   -$0D,y
L1E4A    pshs  y,b,a
         lda   <$004A
         ldb   <$0063
         mul   
         addd  ,s++
         tfr   d,x
         ldb   <$0060
         bpl   L1E60
         ldd   <$0047
         lslb  
         leax  d,x
         puls  pc,y
L1E60    cmpb  #$04
         bne   L1E6B
         ldd   <$0047
         leay  <L1E99,pcr
         bra   L1E7F
L1E6B    cmpb  #$01
         beq   L1E76
         ldd   <$0047
         leay  <L1E94,pcr
         bra   L1E7D
L1E76    ldd   <$0047
         leay  <L1E8B,pcr
         lsra  
         rorb  
L1E7D    lsra  
         rorb  
L1E7F    lsra  
         rorb  
         leax  d,x
         ldb   <$0048
         andb  ,y+
         ldb   b,y
         puls  pc,y

* 2 color mode pixel mask table
L1E8B    fcb   $07          Mask for pixel #'s we care about
         fcb   $80,$40,$20,$10,$08,$04,$02,$01

* 4 color mode pixel mask table
L1E94    fcb   $03          Mask for pixel #'s we care about
         fcb   $c0,$30,$0c,$03

* 16 color mode pixel mask table
L1E99    fcb   $01          Mask for pixel #'s we care about
         fcb   $f0,$0f

L1E9C    lda   <$0060
         leax  <L1EAB-2,pcr
         lsla  
         ldd   a,x
         sta   <$0079
         leax  b,x
         stx   <$0077
         rts
* Bit shift table to shift to the right 3,2,1 or 0 times  
L1EAB    fcb   $80,L1EC2-(L1EAB-2) 
L1EAD    fcb   $c0,L1EC1-(L1EAB-2) 
L1EAF    fcb   $c0,L1EC1-(L1EAB-2)
L1EB1    fcb   $f0,L1EBF-(L1EAB-2) 
L1EB3    inc   <$48
         bne   L1EB9
         inc   <$0047
L1EB9    lsrb  
         bcs   L1EC3
         jmp   [<$77,u]
L1EBF    lsrb  
L1EC0    lsrb  
L1EC1    lsrb  
L1EC2    rts   
L1EC3    ldb   <$0079
         leax  $01,x
         rts   
L1EC8    lda   <$0060
         leax  <L1ED7-2,pcr
         lsla  
         ldd   a,x
         sta   <$007C
         leax  b,x
         stx   <$007A
         rts   

* Bit shift table to shift to the left 3,1 or 0 times
* Used by FFill when filling to the left
L1ED7    fcb   $01,L1EF0-(L1ED7-2)  $1b  640 2-color
         fcb   $03,L1EEF-(L1ED7-2)  $1a  320 4-color
         fcb   $03,L1EEF-(L1ED7-2)  $1a  640 4-color
         fcb   $0f,L1EED-(L1ED7-2)  $18  320 16-color

L1EDF    tst   <$0048
         bne   L1EE5
         dec   <$0047
L1EE5    dec   <$0048
         lslb  
         bcs   L1EF1
         jmp   [<$7A,u]

L1EED    lslb  
         lslb  
L1EEF    lslb  
L1EF0    rts   
L1EF1    ldb   <$007C
         leax  -$01,x
         rts   
L1EF6    pshs  b
         tfr   b,a
         anda  ,x
L1EFC    lsrb  
         bcs   L1F02
         lsra  
         bra   L1EFC
L1F02    cmpa  <$0028
         puls  pc,b
L1F06    pshs  b,a
         jmp   [<$64,u]
L1F0B    FCB   5,$0F,$0F,$17
L1F0F    pshs  b,x
         bsr   L1F55
         lsra  
         rorb  
         lsra  
         rorb  
         bra   L1F25
         pshs  x,b
         bsr   L1F55
         lsra  
         rorb  
         bra   L1F25
         pshs  x,b
         bsr   L1F55
L1F25    andb  <$00B0
         abx   
         lda   <$008A
         pshs  a
         lda   <$00B1
L1F2E    cmpx  #$4000
         bcs   L1F3A
         inca  
         leax  >-$2000,x
         bra   L1F2E
L1F3A    sta   <$008A
         sta   >$FFA9
         ldb   ,x
         puls  a
         sta   <$008A
         sta   >$FFA9
         andb  ,s+
         ldx   ,s++
         lda   ,s
         pshs  b
         anda  ,s+
         jmp   [<$68,u]
L1F55    ldx   <$0066
         lda   <$00AF
         ldb   <$00B2
         anda  <$004A
         mul   
         leax  d,x
         ldd   <$0047
         lsra  
         rorb  
         rts   
L1F65    ldb   $0E,y
         beq   L1F82
         stb   <$00B1
         jsr   <$00BC
         ldx   $0F,y
         stx   <$0066
         ldd   <-$16,x
         deca  
         bpl   L1F79
         lda   #$FF
L1F79    stb   <$00B2
         decb  
         bpl   L1F80
         ldb   #$FF
L1F80    std   <$00AF
L1F82    rts   
L1F83    anda  $01,s
         jmp   [<$68,u]
         ldb   $01,s
         bra   L1F9A
         anda  <$0061
         ldb   ,s
         andb  $01,s
         bra   L1F9A
         eora  ,x
         bra   L1FA1
         anda  ,x
L1F9A    comb  
         andb  ,x
         stb   ,x
         ora   ,x
L1FA1    sta   ,x
         puls  pc,b,a
         anda  $01,s
         eora  ,x
         sta   ,x
         puls  pc,b,a

         emod
eom      equ   *
         end

