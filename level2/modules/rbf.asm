********************************************************************
* RBF - Random Block file manager
*
* $Id$
*
* Ed.    Comments                                       Who YY/MM/DD
* ------------------------------------------------------------------
* 30     Given to me by Gene Heskett                    BGP 98/10/10

         nam   RBF
         ttl   Random Block file manager

* Disassembled 98/08/24 22:41:27 by Disasm v1.6 (C) 1988 by RML

         ifp1
         use   defsfile
         endc

tylg     set   FlMgr+Objct   
atrv     set   ReEnt+rev
rev      set   $02
edition  set   30

         mod   eom,name,tylg,atrv,start,size
u0000    rmb   0
size     equ   .

name     fcs   /RBF/
         fcb   30
L0011    fcb   $26 

start    equ   *
         lbra  L0039
         lbra  L018D
         lbra  L0220
         lbra  L02EC
         lbra  L031F
         lbra  L0407
         lbra  L04B2
         lbra  L0569
         lbra  L0429
         lbra  L0542
         lbra  L05E2
         lbra  L064E
         lbra  L0288
L0039    pshs  y
         leas  -$05,s
         lda   $02,u
         anda  #$7F
         sta   $02,u
         lbsr  L07B5
         bcs   L004A
         ldb   #$DA
L004A    cmpb  #$D8
         bne   L0082
         cmpa  #$2F
         beq   L0082
         pshs  x
         ldx   $06,y
         stu   $04,x
         ldb   <$16,y
         ldx   <$17,y
         lda   <$19,y
         ldu   <$1A,y
         pshs  u,x,b,a
         ldx   $06,y
         lda   $01,x
         clrb  
         anda  #$20
         beq   L0071
         ldd   $06,x
L0071    addd  #$0001
         bcc   L0079
         ldd   #$FFFF
L0079    lbsr  L0DBE
         bcc   L0087
         leas  $06,s
L0080    leas  $02,s
L0082    leas  $05,s
         lbra  L02B1
L0087    std   $0B,s
         ldb   <$16,y
         ldx   <$17,y
         stb   $08,s
         stx   $09,s
         puls  u,x,b,a
         stb   <$16,y
         stx   <$17,y
         sta   <$19,y
         stu   <$1A,y
         ldd   <$3A,y
         std   $0B,y
         ldd   <$3C,y
         std   $0D,y
         lbsr  L0960
         bcs   L00B9
L00B0    tst   ,x
         beq   L00CB
         lbsr  L094B
         bcc   L00B0
L00B9    cmpb  #$D3
         bne   L0080
         ldd   #$0020
         lbsr  L05A2
         bcs   L0080
         lbsr  L0275
         lbsr  L0960
L00CB    leau  ,x
         lbsr  L0173
         puls  x
         os9   F$PrsNam 
         bcs   L0082
         cmpb  #$1D
         bls   L00DD
         ldb   #$1D
L00DD    clra  
         tfr   d,y
         lbsr  L05D4
         tfr   y,d
         ldy   $05,s
         decb  
         lda   b,u
         ora   #$80
         sta   b,u
         ldb   ,s
         ldx   $01,s
         stb   <$1D,u
         stx   <$1E,u
         lbsr  L120E
         bcs   L015B
         ldu   $08,y
         bsr   L017A
         lda   #$04
         sta   $0A,y
         ldx   $06,y
         lda   $02,x
         sta   ,u
         ldx   <$0050
         ldd   $08,x
         std   $01,u
         lbsr  L02D1
         ldd   $03,u
         std   $0D,u
         ldb   $05,u
         stb   $0F,u
         ldb   #$01
         stb   $08,u
         ldd   $03,s
         subd  #$0001
         beq   L013A
         leax  <$10,u
         std   $03,x
         ldd   $01,s
         addd  #$0001
         std   $01,x
         ldb   ,s
         adcb  #$00
         stb   ,x
L013A    ldb   ,s
         ldx   $01,s
         lbsr  L1210
         bcs   L015B
         lbsr  L0A99
         stb   <$34,y
         stx   <$35,y
         lbsr  L0A33
         leas  $05,s
         ldx   <$30,y
         lda   #$04
         sta   $07,x
         lbra  L01DB
L015B    puls  u,x,a
         sta   <$16,y
         stx   <$17,y
         clr   <$19,y
         stu   <$1A,y
         pshs  b
         lbsr  L0FD5
         puls  b
L0170    lbra  L02B1
L0173    pshs  u,x,b,a
         leau  <$20,u
         bra   L0180
L017A    pshs  u,x,b,a
         leau  >$0100,u
L0180    clra  
         clrb  
         tfr   d,x
L0184    pshu  x,b,a
         cmpu  $04,s
         bhi   L0184
         puls  pc,u,x,b,a
L018D    pshs  y
         lbsr  L07B5
         bcs   L0170
         ldu   $06,y
         stx   $04,u
         ldd   <$35,y
         bne   L01CA
         lda   <$34,y
         bne   L01CA
         ldb   $01,y
         andb  #$80
         lbne  L02AF
         std   <$16,y
         sta   <$18,y
         std   <$13,y
         sta   <$15,y
         ldx   <$1E,y
         lda   $02,x
         std   <$11,y
         sta   <$1B,y
         ldd   ,x
         std   $0F,y
         std   <$19,y
         puls  pc,y
L01CA    lda   $01,y
         lbsr  L09E6
         bcs   L0170
         bita  #$02
         beq   L01DB
         lbsr  L02D1
         lbsr  L1206
L01DB    puls  y
L01DD    clra  
         clrb  
         std   $0B,y
         std   $0D,y
         std   <$13,y
         sta   <$15,y
         sta   <$19,y
         lda   ,u
         sta   <$33,y
         ldd   <$10,u
         std   <$16,y
         lda   <$12,u
         sta   <$18,y
         ldd   <$13,u
         std   <$1A,y
         ldd   $09,u
         ldx   $0B,u
         ldu   <$30,y
         cmpu  $05,u
         beq   L0218
         ldu   $05,u
         ldu   $01,u
         ldd   $0F,u
         ldx   <$11,u
L0218    std   $0F,y
         stx   <$11,y
         clr   $0A,y
         rts   
L0220    lbsr  L0039
         bcs   L0273
         lda   <$33,y
         ora   #$40
         lbsr  L09E6
         bcs   L0273
         ldd   #$0040
         std   <$11,y
         bsr   L0285
         bcs   L0273
         lbsr  L0C78
         bcs   L0273
         lbsr  L112C
         ldu   $08,y
         lda   ,u
         ora   #$80
         sta   ,u
         bsr   L0278
         bcs   L0273
         lbsr  L017A
         ldd   #$2EAE
         std   ,u
         stb   <$20,u
         lda   <$37,y
         sta   <$1D,u
         ldd   <$38,y
         std   <$1E,u
         lda   <$34,y
         sta   <$3D,u
         ldd   <$35,y
         std   <$3E,u
         lbsr  L120E
L0273    bra   L02B4
L0275    lbsr  L112C
L0278    ldx   $08,y
         ldd   $0F,y
         std   $09,x
         ldd   <$11,y
         std   $0B,x
         clr   $0A,y
L0285    lbra  L1206
L0288    clra  
         tst   $02,y
         bne   L02AE
         lbsr  L1240
         bcs   L02B4
         ldb   $01,y
         bitb  #$02
         beq   L02B4
         ldd   <$34,y
         bne   L02A2
         lda   <$36,y
         beq   L02B4
L02A2    bsr   L0275
         lbsr  L05EE
         bcc   L02B4
         lbsr  L0F07
         bra   L02B4
L02AE    rts   
L02AF    ldb   #$D6
L02B1    coma  
L02B2    puls  y
L02B4    pshs  b,cc
         ldu   $08,y
         beq   L02CF
         ldd   #$0100
         os9   F$SRtMem 
         ldx   <$30,y
         beq   L02CF
         lbsr  L0A99
         lda   ,x
         ldx   <$0088
         os9   F$Ret64  
L02CF    puls  pc,b,cc
L02D1    lbsr  L112C
         ldu   $08,y
         lda   $08,u
         ldx   <$0050
         pshs  x,a
         ldx   <$004A
         stx   <$0050
         leax  $03,u
         os9   F$Time   
         puls  x,a
         stx   <$0050
         sta   $08,u
         rts   
L02EC    pshs  y
         lda   $01,y
         ora   #$80
         sta   $01,y
         lbsr  L018D
         bcs   L02B2
         ldx   <$0050
         ldu   <$35,y
         ldb   $01,y
         bitb  #$03
         beq   L030D
         ldb   <$34,y
         stb   <$23,x
         stu   <$24,x
L030D    ldb   $01,y
         bitb  #$04
         beq   L031C
         ldb   <$34,y
         stb   <$29,x
         stu   <$2A,x
L031C    clrb  
         bra   L02B2
L031F    pshs  y
         lbsr  L07B5
         bcs   L02B2
         ldd   <$35,y
         bne   L0332
         tst   <$34,y
         lbeq  L02AF
L0332    lda   #$42
         lbsr  L09E6
         lbcs  L02B2
         ldu   $06,y
         stx   $04,u
         lbsr  L112C
         lbcs  L03D7
         ldx   $08,y
         dec   $08,x
         beq   L0358
         lbsr  L1206
         nop   
         pshs  u,x,b
         clra  
         clrb  
         std   $03,s
         bra   L03A2
L0358    ldb   <$34,y
         ldx   <$35,y
         pshs  u,x,b
         ldd   #$0100
         os9   F$SRqMem 
         bcc   L036C
         clra  
         clrb  
         bra   L037A
L036C    stu   $03,s
         ldx   $08,y
         clrb  
L0371    lda   ,x+
         sta   ,u+
         decb  
         bne   L0371
         ldd   $03,s
L037A    std   $03,s
         clra  
         clrb  
         std   $0F,y
         std   <$11,y
         lbsr  L0F07
         bcs   L03F7
         ldb   <$34,y
         ldx   <$35,y
         stb   <$16,y
         stx   <$17,y
         ldx   $08,y
         ldd   <$13,x
         addd  #$0001
         std   <$1A,y
         lbsr  L0FD5
L03A2    bcs   L03F7
         lbsr  L1240
         lbsr  L0A99
         lda   <$37,y
         sta   <$34,y
         ldd   <$38,y
         std   <$35,y
         lbsr  L112C
         bcs   L03F7
         lbsr  L0A33
         ldu   $08,y
         lbsr  L01DD
         ldd   <$3A,y
         std   $0B,y
         ldd   <$3C,y
         std   $0D,y
         lbsr  L0960
         bcs   L03F7
         clr   ,x
         lbsr  L120E
L03D7    ldu   $03,s
         beq   L0402
         ldb   ,s
         ldx   $01,s
         stb   <$34,y
         stx   <$35,y
         ldx   <$08,y
         stx   <$01,s
         stu   <$08,y
         lbsr  L1206
         ldu   <$01,s
         stu   <$08,y
L03F7    ldu   <$03,s
         beq   L0402
         ldd   #$0100
         os9   F$SRtMem 
L0402    leas  $05,s
         lbra  L02B2
L0407    ldb   $0A,y
         bitb  #$02
         beq   L0420
         lda   $05,u
         ldb   $08,u
         subd  $0C,y
         bne   L041B
         lda   $04,u
         sbca  $0B,y
         beq   L0424
L041B    lbsr  L1240
         bcs   L0428
L0420    ldd   $04,u
         std   $0B,y
L0424    ldd   $08,u
         std   $0D,y
L0428    rts   
L0429    bsr   L046C
         beq   L044F
         bsr   L0450
         pshs  u,y,x,b,a
         exg   x,u
         ldy   #$0000
         lda   #$0D
L0439    leay  $01,y
         cmpa  ,x+
         beq   L0442
         decb  
         bne   L0439
L0442    ldx   $06,s
         bsr   L04A4
         sty   $0A,s
         puls  u,y,x,b,a
         ldd   $02,s
         leax  d,x
L044F    rts   
L0450    lbsr  L04DC
         leax  -$01,x
         lbsr  L0988
         cmpa  #$0D
         beq   L0462
         ldd   $02,s
         lbne  L04E2
L0462    ldu   $06,y
         ldd   $06,u
         subd  $02,s
         std   $06,u
         bra   L04C9
L046C    ldd   $06,u
         lbsr  L0B15
         bcs   L04A0
         ldd   $06,u
         bsr   L047C
         bcs   L04A0
         std   $06,u
         rts   
L047C    pshs  b,a
         ldd   <$11,y
         subd  $0D,y
         tfr   d,x
         ldd   $0F,y
         sbcb  $0C,y
         sbca  $0B,y
         bcs   L049D
         bne   L049A
         tstb  
         bne   L049A
         cmpx  ,s
         bcc   L049A
         stx   ,s
         beq   L049D
L049A    clrb  
         puls  pc,b,a
L049D    comb  
         ldb   #$D3
L04A0    leas  $02,s
         bra   L04CE
L04A4    pshs  x
         ldx   <$0050
         lda   <$00D0
         ldb   $06,x
         puls  x
         os9   F$Move   
         rts   
L04B2    bsr   L046C
         beq   L04C4
         bsr   L04C5
L04B8    pshs  u,y,x,b,a
         exg   x,u
         tfr   d,y
         bsr   L04A4
         puls  u,y,x,b,a
         leax  d,x
L04C4    rts   
L04C5    bsr   L04DC
         bne   L04E2
L04C9    clrb  
L04CA    leas  -$02,s
L04CC    leas  $0A,s
L04CE    pshs  b,cc
         lda   $01,y
         bita  #$02
         bne   L04D9
         lbsr  L0B0B
L04D9    puls  b,cc
         rts   
L04DC    ldd   $04,u
         ldx   $06,u
         pshs  x,b,a
L04E2    lda   $0A,y
         bita  #$02
         bne   L0502
         tst   $0E,y
         bne   L04FD
         tst   $02,s
         beq   L04FD
         leax  >L057A,pcr
         cmpx  $06,s
         bne   L04FD
         lbsr  L10A1
         bra   L0500
L04FD    lbsr  L125F
L0500    bcs   L04CA
L0502    ldu   $08,y
         clra  
         ldb   $0E,y
         leau  d,u
         negb  
         sbca  #$FF
         ldx   ,s
         cmpd  $02,s
         bls   L0515
         ldd   $02,s
L0515    pshs  b,a
         jsr   [<$08,s]
         stx   $02,s
         lda   $0A,y
         anda  #$BF
         sta   $0A,y
         ldb   $01,s
         addb  $0E,y
         stb   $0E,y
         bne   L0539
         lbsr  L1240
         inc   $0D,y
         bne   L0537
         inc   $0C,y
         bne   L0537
         inc   $0B,y
L0537    bcs   L04CC
L0539    ldd   $04,s
         subd  ,s++
         std   $02,s
         jmp   [<$04,s]
L0542    pshs  y
         clrb  
         ldy   $06,u
         beq   L0567
         ldx   <$0050
         ldb   $06,x
         ldx   $04,u
L0550    leay  -$01,y
         beq   L0567
         os9   F$LDABX  
         leax  $01,x
         cmpa  #$0D
         bne   L0550
         tfr   y,d
         nega  
         negb  
         sbca  #$00
         addd  $06,u
         std   $06,u
L0567    puls  y
L0569    ldd   $06,u
         lbsr  L0B15
         bcs   L05A1
         ldd   $06,u
         beq   L05A0
         bsr   L05A2
         bcs   L05A1
         bsr   L058B
L057A    pshs  y,b,a
         tfr   d,y
         bsr   L05D4
         puls  y,b,a
         leax  d,x
         lda   $0A,y
         ora   #$03
         sta   $0A,y
         rts   
L058B    lbsr  L04DC
         lbne  L04E2
         leas  $08,s
         ldy   <$30,y
         lda   #$01
         lbsr  L0ADA
         ldy   $01,y
L05A0    clrb  
L05A1    rts   
L05A2    addd  $0D,y
         tfr   d,x
         ldd   $0B,y
         adcb  #$00
         adca  #$00
L05AC    cmpd  $0F,y
         bcs   L05A0
         bhi   L05B8
         cmpx  <$11,y
         bls   L05A0
L05B8    pshs  u
         ldu   <$11,y
         stx   <$11,y
         ldx   $0F,y
         std   $0F,y
         pshs  u,x
         lbsr  L0C78
         puls  u,x
         bcc   L05D2
         stx   $0F,y
         stu   <$11,y
L05D2    puls  pc,u
L05D4    pshs  x
         ldx   <$0050
         lda   $06,x
         ldb   <$00D0
         puls  x
         os9   F$Move   
         rts   
L05E2    ldb   $02,u
         cmpb  #$00
         beq   L0608
         cmpb  #$06
         bne   L05F4
         clr   $02,u
L05EE    clra  
         ldb   #$01
         lbra  L047C
L05F4    cmpb  #$01
         bne   L05FB
         clr   $02,u
         rts   
L05FB    cmpb  #$02
         bne   L0609
         ldd   $0F,y
         std   $04,u
         ldd   <$11,y
         std   $08,u
L0608    rts   
L0609    cmpb  #$05
         bne   L0616
         ldd   $0B,y
         std   $04,u
         ldd   $0D,y
         std   $08,u
         rts   
L0616    cmpb  #$0F
         bne   L0630
         lbsr  L112C
         bcs   L0608
         ldu   $06,y
         ldd   $06,u
         tsta  
         beq   L0629
         ldd   #$0100
L0629    ldx   $04,u
         ldu   $08,y
         lbra  L04B8
L0630    cmpb  #$20
         bne   L0649
         lbsr  L1240
         bcs   L0608
         ldb   $06,u
         ldx   $08,u
         lbsr  L1143
         bcs   L0608
         ldu   $06,y
         ldd   $06,u
         clra  
         bra   L0629
L0649    lda   #$09
         lbra  L1145
L064E    ldb   $02,u
         cmpb  #$00
         bne   L0662
         ldx   $04,u
         leax  $02,x
         leau  <$22,y
         ldy   #$000D
         lbra  L05D4
L0662    cmpb  #$02
         bne   L06A4
         ldd   <$35,y
         bne   L0672
         tst   <$34,y
         lbeq  L07B1
L0672    lda   $01,y
         bita  #$02
         beq   L06A0
         ldd   $04,u
         ldx   $08,u
         cmpd  $0F,y
         bcs   L068B
         bne   L0688
         cmpx  <$11,y
         bcs   L068B
L0688    lbra  L05AC
L068B    std   $0F,y
         stx   <$11,y
         ldd   $0B,y
         ldx   $0D,y
         pshs  x,b,a
         lbsr  L0F07
         puls  u,x
         stx   $0B,y
         stu   $0D,y
         rts   
L06A0    comb  
         ldb   #$CB
L06A3    rts   
L06A4    cmpb  #$0F
         bne   L06E2
         lda   $01,y
         bita  #$02
         beq   L06A0
         lbsr  L112C
         bcs   L06A3
         pshs  y
         ldx   $04,u
         ldu   $08,y
         ldy   <$0050
         ldd   $08,y
         bne   L06C5
         ldd   #$0102
         bsr   L06D4
L06C5    ldd   #$0305
         bsr   L06D4
         ldd   #$0D03
         bsr   L06D4
         puls  y
         lbra  L1206
L06D4    pshs  u,x
         leax  a,x
         leau  a,u
         clra  
         tfr   d,y
         lbsr  L05D4
         puls  pc,u,x
L06E2    cmpb  #$11
         bne   L0701
         ldd   $08,u
         ldx   $04,u
         cmpx  #$FFFF
         bne   L06FE
         cmpx  $08,u
         bne   L06FE
         ldu   <$30,y
         lda   $07,u
         ora   #$02
         sta   $07,u
         lda   #$FF
L06FE    lbra  L0B24
L0701    cmpb  #$10
         bne   L070E
         ldd   $04,u
         ldx   <$30,y
         std   <$12,x
         rts   
L070E    cmpb  #$1E
         bne   L071E
         ldx   <$1E,y
         lda   $05,u
         sta   <$1E,x
         clr   <$1D,x
L071D    rts   
L071E    cmpb  #$1C
         bne   L078D
         lbsr  L112C
         bcs   L071D
         ldx   <$0050
         lda   $08,x
         beq   L0733
         ldx   $08,y
         cmpa  $01,x
         bne   L0789
L0733    lda   $05,u
         tfr   a,b
         ldu   $08,y
         eorb  ,u
         bpl   L0784
         tsta  
         bmi   L076D
         ldx   <$1E,y
         ldd   $08,x
         cmpd  <$34,y
         bne   L0752
         ldb   $0A,x
         cmpb  <$36,y
         beq   L0789
L0752    ldb   $0B,y
         ldx   $0C,y
         pshs  x,b
         std   $0B,y
         ldb   #$20
         std   $0D,y
L075E    lbsr  L094B
         bcs   L0771
         tst   ,x
         beq   L075E
         puls  x,b
         stb   $0B,y
         stx   $0C,y
L076D    ldb   #$EE
         bra   L078B
L0771    puls  x,a
         sta   $0B,y
         stx   $0C,y
         cmpb  #$D3
         bne   L078B
         lbsr  L112C
         ldu   $08,y
         ldx   $06,y
         lda   $05,x
L0784    sta   ,u
         lbra  L1206
L0789    ldb   #$D6
L078B    coma  
         rts   
L078D    cmpb  #$2C
         bne   L07AC
         lda   <$33,y
         bita  #$40
         lbne  L0A94
         ldx   <$30,y
         lda   $05,u
         sta   <$18,x
         ldu   <$0050
         lda   <$0000,u
         sta   <$17,x
         clrb  
         rts   
L07AC    lda   #$0C
         lbra  L1145
L07B1    comb  
         ldb   #$D0
L07B4    rts   
L07B5    ldd   #$0100
         stb   $0A,y
         os9   F$SRqMem 
         bcs   L07B4
         stu   $08,y
         leau  ,y
         ldx   <$0088
         os9   F$All64  
         exg   y,u
         bcs   L07B4
         stu   <$30,y
         clr   <$17,u
         sty   $01,u
         stu   <$10,u
         ldx   $06,y
         ldx   $04,x
         pshs  u,y,x
         leas  -$04,s
         clra  
         clrb  
         sta   <$34,y
         std   <$35,y
         std   <$1C,y
         lbsr  L0988
         sta   ,s
         cmpa  #$2F
         bne   L0804
         lbsr  L0993
         sta   ,s
         lbcs  L0916
         leax  ,y
         ldy   $06,s
         bra   L0827
L0804    anda  #$7F
         cmpa  #$40
         beq   L0827
         lda   #$2F
         sta   ,s
         leax  -$01,x
         lda   $01,y
         ldu   <$0050
         leau  <$20,u
         bita  #$04
         beq   L081D
         leau  $06,u
L081D    ldb   $03,u
         stb   <$34,y
         ldd   $04,u
         std   <$35,y
L0827    ldu   $03,y
         stu   <$3E,y
         lda   <$21,y
         ldb   >L0011,pcr
         mul   
         addd  $02,u
         addd  #$000F
         std   <$1E,y
         lda   ,s
         anda  #$7F
         cmpa  #$40
         bne   L0848
         leax  $01,x
         bra   L086A
L0848    lbsr  L1119
         lbcs  L091E
         ldu   $08,y
         ldd   $0E,u
         std   <$1C,y
         ldd   <$35,y
         bne   L086A
         lda   <$34,y
         bne   L086A
         lda   $08,u
         sta   <$34,y
         ldd   $09,u
         std   <$35,y
L086A    stx   $04,s
         stx   $08,s
L086E    lbsr  L1240
         lbcs  L091E
         lda   ,s
         anda  #$7F
         cmpa  #$40
         beq   L0884
         lbsr  L112C
         lbcs  L091E
L0884    lbsr  L0A33
         lda   ,s
         cmpa  #$2F
         bne   L08F8
         clr   $02,s
         clr   $03,s
         lda   $01,y
         ora   #$80
         lbsr  L09E6
         bcs   L0916
         lbsr  L01DD
         ldx   $08,s
         leax  $01,x
         lbsr  L0993
         std   ,s
         stx   $04,s
         sty   $08,s
         ldy   $06,s
         bcs   L0916
         pshs  u,y
         ldu   <$30,y
         leau  <$20,u
         clra  
         tfr   d,y
         lbsr  L05D4
         puls  u,y
         lbsr  L0960
         bra   L08CA
L08C5    bsr   L0921
L08C7    lbsr  L094B
L08CA    bcs   L0916
         tst   ,x
         beq   L08C5
         clra  
         ldb   $01,s
         exg   x,y
         ldx   <$30,x
         leax  <$20,x
         lbsr  L09C8
         ldx   $06,s
         exg   x,y
         bcs   L08C7
         bsr   L092F
         lda   <$1D,x
         sta   <$34,y
         ldd   <$1E,x
         std   <$35,y
         lbsr  L0A99
         lbra  L086E
L08F8    ldx   $08,s
         tsta  
         bmi   L0905
         os9   F$PrsNam 
         leax  ,y
         ldy   $06,s
L0905    stx   $04,s
         clra  
L0908    lda   ,s
         leas  $04,s
         pshs  b,a,cc
         lda   $0A,y
         anda  #$BF
         sta   $0A,y
         puls  pc,u,y,x,b,a,cc
L0916    cmpb  #$D3
         bne   L091E
         bsr   L0921
         ldb   #$D8
L091E    coma  
         bra   L0908
L0921    pshs  b,a
         lda   $04,s
         cmpa  #$2F
         beq   L0949
         ldd   $06,s
         bne   L0949
         puls  b,a
L092F    pshs  b,a
         stx   $06,s
         lda   <$34,y
         sta   <$37,y
         ldd   <$35,y
         std   <$38,y
         ldd   $0B,y
         std   <$3A,y
         ldd   $0D,y
         std   <$3C,y
L0949    puls  pc,b,a
L094B    ldb   $0E,y
         addb  #$20
         stb   $0E,y
         bcc   L0960
         lbsr  L1240
         inc   $0D,y
         bne   L0960
         inc   $0C,y
         bne   L0960
         inc   $0B,y
L0960    ldd   #$0020
         lbsr  L047C
         bcs   L0987
         ldd   #$0020
         lbsr  L0B15
         bcs   L0987
         lda   $0A,y
         bita  #$02
         bne   L0980
         lbsr  L10A1
         bcs   L0987
         lbsr  L125F
         bcs   L0987
L0980    ldb   $0E,y
         lda   $08,y
         tfr   d,x
         clrb  
L0987    rts   
L0988    pshs  u,x,b
         ldu   <$0050
         ldb   $06,u
         os9   F$LDABX  
         puls  pc,u,x,b
L0993    os9   F$PrsNam 
         pshs  x
         bcc   L09C0
         clrb  
L099B    pshs  a
         anda  #$7F
         cmpa  #$2E
         puls  a
         bne   L09B6
         incb  
         leax  $01,x
         tsta  
         bmi   L09B6
         bsr   L0988
         cmpb  #$03
         bcs   L099B
         lda   #$2F
         decb  
         leax  -$03,x
L09B6    tstb  
         bne   L09BE
L09B9    comb  
         ldb   #$D7
         puls  pc,x
L09BE    leay  ,x
L09C0    cmpb  #$20
         bhi   L09B9
         andcc #^Carry
         puls  pc,x
L09C8    pshs  y,x,b,a
L09CA    lda   ,y+
         bmi   L09DA
         decb  
         beq   L09D7
         eora  ,x+
         anda  #$DF
         beq   L09CA
L09D7    comb  
         puls  pc,y,x,b,a
L09DA    decb  
         bne   L09D7
         eora  ,x
         anda  #$5F
         bne   L09D7
         clrb  
         puls  pc,y,x,b,a
L09E6    tfr   a,b
         anda  #$07
         andb  #$C0
         pshs  x,b,a
         lbsr  L112C
         bcs   L0A15
         ldu   $08,y
         ldx   <$0050
         ldd   $08,x
         beq   L09FE
         cmpd  $01,u
L09FE    puls  a
         beq   L0A05
         lsla  
         lsla  
         lsla  
L0A05    ora   ,s
         anda  #$BF
         pshs  a
         ora   #$80
         anda  ,u
         cmpa  ,s
         beq   L0A1E
         ldb   #$D6
L0A15    leas  $02,s
         coma  
         puls  pc,x
L0A1A    ldb   #$FD
         bra   L0A15
L0A1E    ldb   $01,s
         orb   ,u
         bitb  #$40
         beq   L0A31
         ldx   <$30,y
         cmpx  $05,x
         bne   L0A1A
         lda   #$02
         sta   $07,x
L0A31    puls  pc,x,b,a
L0A33    pshs  u,y,x
         clra  
         clrb  
         std   $0B,y
         std   $0D,y
         sta   <$19,y
         std   <$1A,y
         ldb   <$34,y
         ldx   <$35,y
         pshs  x,b
         ldu   <$1E,y
         ldy   <$30,y
         sty   $05,y
         leau  <$15,u
         bra   L0A5A
L0A58    ldu   $03,u
L0A5A    ldx   $03,u
         beq   L0A88
         ldx   $01,x
         ldd   <$34,x
         cmpd  ,s
         bcs   L0A58
         bhi   L0A88
         ldb   <$36,x
         cmpb  $02,s
         bcs   L0A58
         bhi   L0A88
         ldx   <$30,x
         lda   $07,y
         bita  #$02
         bne   L0A94
         sty   $03,y
         ldd   $05,x
         std   $05,y
         sty   $05,x
         bra   L0A8F
L0A88    ldx   $03,u
         stx   $03,y
         sty   $03,u
L0A8F    clrb  
L0A90    leas  $03,s
         puls  pc,u,y,x
L0A94    comb  
         ldb   #$FD
         bra   L0A90
L0A99    pshs  u,y,x,b,a
         ldu   <$1E,y
         leau  <$15,u
         ldx   <$30,y
         leay  ,x
         bsr   L0AD8
         bra   L0AAE
L0AAA    ldx   $05,x
         beq   L0AD3
L0AAE    cmpy  $05,x
         bne   L0AAA
         ldd   $05,y
         std   $05,x
         bra   L0ABB
L0AB9    ldu   $03,u
L0ABB    ldd   $03,u
         beq   L0AD3
         cmpy  $03,u
         bne   L0AB9
         ldx   $03,y
         cmpy  $05,y
         beq   L0AD1
         ldx   $05,y
         ldd   $03,y
         std   $03,x
L0AD1    stx   $03,u
L0AD3    sty   $05,y
         puls  pc,u,y,x,b,a
L0AD8    lda   #$07
L0ADA    pshs  u,y,x,b,a
         bita  $07,y
         beq   L0AE9
         coma  
         anda  $07,y
         sta   $07,y
         bita  #$02
         bne   L0B06
L0AE9    leau  ,y
L0AEB    ldx   <$10,u
         cmpy  <$10,u
         beq   L0B03
         stu   <$10,u
         leau  ,x
         lda   <$14,u
         ldb   #$01
         os9   F$Send   
         bra   L0AEB
L0B03    stu   <$10,u
L0B06    puls  pc,u,y,x,b,a
L0B08    comb  
         ldb   #$FD
L0B0B    pshs  y,b,cc
         ldy   <$30,y
         bsr   L0AD8
         puls  pc,y,b,cc
L0B15    ldx   #$0000
         bra   L0B24
L0B1A    ldu   <$30,y
         lda   <$15,u
         sta   $07,u
         puls  u,y,x,b,a
L0B24    pshs  u,y,x,b,a
         ldu   <$30,y
         lda   $07,u
         sta   <$15,u
         lda   ,s
         bsr   L0BA8
         bcc   L0BA6
         ldu   <$0050
         lda   <$14,x
L0B39    os9   F$GProcP 
         bcs   L0B4B
         lda   <$1E,y
         beq   L0B4B
         cmpa  ,u
         bne   L0B39
         ldb   #$FE
         bra   L0BA3
L0B4B    lda   <$14,x
         sta   <$1E,u
         ldy   $04,s
         lda   $0A,y
         anda  #$BF
         sta   $0A,y
         ldu   <$30,y
         ldd   <$10,x
         stu   <$10,x
         std   <$10,u
         lbsr  L0C5F
         ldx   <$12,u
         os9   F$Sleep  
         pshs  x
         leax  ,u
         bra   L0B78
L0B75    ldx   <$10,x
L0B78    cmpu  <$10,x
         bne   L0B75
         ldd   <$10,u
         std   <$10,x
         stu   <$10,u
         puls  x
         ldu   <$0050
         clr   <$1E,u
         lbsr  L105C
         bcs   L0BA3
         leax  ,x
         bne   L0B1A
         ldu   <$30,y
         ldx   <$12,u
         lbeq  L0B1A
         ldb   #$FC
L0BA3    coma  
         stb   $01,s
L0BA6    puls  pc,u,y,x,b,a
L0BA8    std   -$02,s
         bne   L0BB3
         cmpx  #$0000
         lbeq  L0B0B
L0BB3    bsr   L0BCB
         lbcs  L0B08
         pshs  u,y,x
         ldy   <$30,y
         lda   #$01
         lbsr  L0ADA
         ora   $07,y
         sta   $07,y
         clrb  
         puls  pc,u,y,x
L0BCB    pshs  u,y,b,a
         leau  ,y
         ldy   <$30,y
         subd  #$0001
         bcc   L0BDA
         leax  -$01,x
L0BDA    addd  $0D,u
         exg   d,x
         adcb  $0C,u
         adca  $0B,u
         bcc   L0BE9
         ldx   #$FFFF
         tfr   x,d
L0BE9    std   $0C,y
         stx   $0E,y
         cmpd  $0F,u
         bcs   L0C01
         bhi   L0BF9
         cmpx  <$11,u
         bcs   L0C01
L0BF9    lda   $07,y
         ora   #$04
         sta   $07,y
         bra   L0C0A
L0C01    lda   #$04
         bita  $07,y
         beq   L0C0A
         lbsr  L0ADA
L0C0A    ldd   $0B,u
         ldx   $0D,u
         std   $08,y
         stx   $0A,y
         lda   $05,u
         sta   <$14,y
         leax  ,y
L0C19    cmpy  $05,x
         beq   L0C5D
         ldx   $05,x
         ldb   <$14,y
         cmpb  <$14,x
         beq   L0C19
         lda   $07,x
         beq   L0C19
         ora   $07,y
         bita  #$02
         bne   L0C5C
         lda   $07,x
         anda  $07,y
         bita  #$04
         bne   L0C5C
         ldd   $08,x
         cmpd  $0C,y
         bhi   L0C19
         bcs   L0C4C
         ldd   $0A,x
         cmpd  $0E,y
         bhi   L0C19
         beq   L0C5C
L0C4C    ldd   $0C,x
         cmpd  $08,y
         bcs   L0C19
         bhi   L0C5C
         ldd   $0E,x
         cmpd  $0A,y
         bcs   L0C19
L0C5C    comb  
L0C5D    puls  pc,u,y,b,a
L0C5F    pshs  y,x,b,a
         ldx   <$0050
         lda   <$10,x
         beq   L0C75
         clr   <$10,x
         ldb   #$01
         os9   F$Send   
         os9   F$GProcP 
         clr   $0F,y
L0C75    clrb  
         puls  pc,y,x,b,a
L0C78    pshs  u,x
L0C7A    bsr   L0CDA
         bne   L0C8A
         cmpx  <$1A,y
         bcs   L0CD1
         bne   L0C8A
         lda   <$12,y
         beq   L0CD1
L0C8A    lbsr  L112C
         bcs   L0CCE
         ldx   $0B,y
         ldu   $0D,y
         pshs  u,x
         ldd   $0F,y
         std   $0B,y
         ldd   <$11,y
         std   $0D,y
         lbsr  L10BB
         puls  u,x
         stx   $0B,y
         stu   $0D,y
         bcc   L0CD1
         cmpb  #$D5
         bne   L0CCE
         bsr   L0CDA
         bne   L0CBA
         tst   <$12,y
         beq   L0CBD
         leax  $01,x
         bne   L0CBD
L0CBA    ldx   #$FFFF
L0CBD    tfr   x,d
         tsta  
         bne   L0CCA
         cmpb  <$2E,y
         bcc   L0CCA
         ldb   <$2E,y
L0CCA    bsr   L0D10
         bcc   L0C7A
L0CCE    coma  
         puls  pc,u,x
L0CD1    lbsr  L10A1
         bcs   L0CCE
         bsr   L0CE8
         puls  pc,u,x
L0CDA    ldd   <$10,y
         subd  <$14,y
         tfr   d,x
         ldb   $0F,y
         sbcb  <$13,y
         rts   
L0CE8    clra  
         ldb   #$02
         pshs  u,x
         ldu   <$30,y
         bra   L0D06
L0CF2    ldu   $01,u
         ldx   $0F,y
         stx   $0F,u
         ldx   <$11,y
         stx   <$11,u
         bitb  $01,y
         beq   L0D03
         inca  
L0D03    ldu   <$30,u
L0D06    ldu   $05,u
         cmpy  $01,u
         bne   L0CF2
         tsta  
         puls  pc,u,x
L0D10    pshs  u,x
         lbsr  L0DBE
         bcs   L0D57
         lbsr  L112C
         bcs   L0D57
         ldu   $08,y
         clra  
         clrb  
         std   $09,u
         std   $0B,u
         leax  <$10,u
         ldd   $03,x
         beq   L0D9F
         ldd   $08,y
         inca  
         pshs  b,a
         bra   L0D3F
L0D32    clrb  
         ldd   -$02,x
         beq   L0D53
         addd  $0A,u
         std   $0A,u
         bcc   L0D3F
         inc   $09,u
L0D3F    leax  $05,x
         cmpx  ,s
         bcs   L0D32
         lbsr  L0FD5
         clra  
         clrb  
         sta   <$19,y
         std   <$1A,y
         comb  
         ldb   #$D9
L0D53    leas  $02,s
         leax  -$05,x
L0D57    bcs   L0DBC
         ldd   -$04,x
         addd  -$02,x
         pshs  b,a
         ldb   -$05,x
         adcb  #$00
         cmpb  <$16,y
         puls  b,a
         bne   L0D9F
         cmpd  <$17,y
         bne   L0D9F
         ldu   <$1E,y
         ldd   $06,u
         ldu   $08,y
         subd  #$0001
         coma  
         comb  
         pshs  b,a
         ldd   -$05,x
         eora  <$16,y
         eorb  <$17,y
         lsra  
         rorb  
         lsra  
         rorb  
         lsra  
         rorb  
         anda  ,s+
         andb  ,s+
         std   -$02,s
         bne   L0D9F
         ldd   -$02,x
         addd  <$1A,y
         bcs   L0D9F
         std   -$02,x
         bra   L0DAE
L0D9F    ldd   <$16,y
         std   ,x
         lda   <$18,y
         sta   $02,x
         ldd   <$1A,y
         std   $03,x
L0DAE    ldd   $0A,u
         addd  <$1A,y
         std   $0A,u
         bcc   L0DB9
         inc   $09,u
L0DB9    lbsr  L1206
L0DBC    puls  pc,u,x
L0DBE    pshs  u,y,x,b,a
         ldb   #$0C
L0DC2    clr   ,-s
         decb  
         bne   L0DC2
         ldx   <$1E,y
         ldd   $04,x
         std   $04,s
         ldd   $06,x
         std   $02,s
         std   $0A,s
         ldx   $03,y
         ldx   $04,x
         leax  <$12,x
         subd  #$0001
         addb  $0E,x
         adca  #$00
         bra   L0DE6
L0DE4    lsra  
         rorb  
L0DE6    lsr   $0A,s
         ror   $0B,s
         bcc   L0DE4
         std   ,s
         ldd   $02,s
         std   $0A,s
         subd  #$0001
         addd  $0C,s
         bcc   L0E00
         ldd   #$FFFF
         bra   L0E00
L0DFE    lsra  
         rorb  
L0E00    lsr   $0A,s
         ror   $0B,s
         bcc   L0DFE
         cmpa  #$08
         bcs   L0E0D
         ldd   #$0800
L0E0D    std   $0C,s
         lbsr  L103F
         lbcs  L0EFB
         ldx   <$1E,y
         ldd   <$1A,x
         cmpd  $0E,x
         bne   L0E2F
         lda   <$1C,x
         cmpa  $04,x
         bne   L0E2F
         ldb   <$1D,x
         cmpb  $04,x
         bcs   L0E3D
L0E2F    ldd   $0E,x
         std   <$1A,x
         lda   $04,x
         sta   <$1C,x
         clrb  
         stb   <$1D,x
L0E3D    incb  
         stb   $06,s
         ldx   <$1E,y
         cmpb  <$1E,x
         beq   L0E79
         lbsr  L109A
         lbcs  L0EFB
         ldb   $06,s
         cmpb  $04,s
         bls   L0E5A
         clra  
         ldb   $05,s
         bra   L0E5D
L0E5A    ldd   #$0100
L0E5D    ldx   $08,y
         leau  d,x
         ldy   $0C,s
         clra  
         clrb  
         os9   F$SchBit 
         bcc   L0EA6
         cmpy  $08,s
         bls   L0E79
         sty   $08,s
         std   $0A,s
         lda   $06,s
         sta   $07,s
L0E79    ldy   <$10,s
         ldb   $06,s
         cmpb  $04,s
         bcs   L0E8A
         bhi   L0E89
         tst   $05,s
         bne   L0E8A
L0E89    clrb  
L0E8A    ldx   <$1E,y
         cmpb  <$1D,x
         bne   L0E3D
         ldb   $07,s
         beq   L0EF9
         cmpb  $06,s
         beq   L0E9F
         stb   $06,s
         lbsr  L109A
L0E9F    ldx   $08,y
         ldd   $0A,s
         ldy   $08,s
L0EA6    std   $0A,s
         sty   $08,s
         os9   F$AllBit 
         ldy   <$10,s
         ldb   $06,s
         lbsr  L1072
         bcs   L0EFB
         ldx   <$1E,y
         lda   $06,s
         deca  
         sta   <$1D,x
         clrb  
         lsla  
         rolb  
         lsla  
         rolb  
         lsla  
         rolb  
         stb   <$16,y
         ora   $0A,s
         ldb   $0B,s
         ldx   $08,s
         ldy   <$10,s
         std   <$17,y
         stx   <$1A,y
         ldd   $02,s
         bra   L0EEF
L0EE0    lsl   <$18,y
         rol   <$17,y
         rol   <$16,y
         lsl   <$1B,y
         rol   <$1A,y
L0EEF    lsra  
         rorb  
         bcc   L0EE0
         clrb  
         ldd   <$1A,y
         bra   L0F03
L0EF9    ldb   #$F8
L0EFB    ldy   <$10,s
         lbsr  L1079
         coma  
L0F03    leas  $0E,s
         puls  pc,u,y,x
L0F07    clra  
         lda   $01,y
         bita  #$80
         bne   L0F78
         ldd   $0F,y
         std   $0B,y
         ldd   <$11,y
         std   $0D,y
         ldd   #$FFFF
         tfr   d,x
         lbsr  L0B24
         bcs   L0F77
         lbsr  L0CE8
         bne   L0F78
         lbsr  L10BB
         bcc   L0F2F
         cmpb  #$D5
         bra   L0F70
L0F2F    ldd   <$14,y
         subd  $0C,y
         addd  <$1A,y
         tst   $0E,y
         beq   L0F3E
         subd  #$0001
L0F3E    pshs  b,a
         ldu   <$1E,y
         ldd   $06,u
         subd  #$0001
         coma  
         comb  
         anda  ,s+
         andb  ,s+
         ldu   <$1A,y
         std   <$1A,y
         beq   L0F72
         tfr   u,d
         subd  <$1A,y
         pshs  x,b,a
         addd  <$17,y
         std   <$17,y
         bcc   L0F68
         inc   <$16,y
L0F68    bsr   L0FD5
         bcc   L0F79
         leas  $04,s
         cmpb  #$DB
L0F70    bne   L0F77
L0F72    lbsr  L112C
         bcc   L0F82
L0F77    coma  
L0F78    rts   
L0F79    lbsr  L112C
         bcs   L0FD2
         puls  x,b,a
         std   $03,x
L0F82    ldu   $08,y
         ldd   <$11,y
         std   $0B,u
         ldd   $0F,y
         std   $09,u
         tfr   x,d
         clrb  
         inca  
         leax  $05,x
         pshs  x,b,a
         bra   L0FBD
L0F97    ldd   -$02,x
         beq   L0FCA
         std   <$1A,y
         ldd   -$05,x
         std   <$16,y
         lda   -$03,x
         sta   <$18,y
         bsr   L0FD5
         bcs   L0FD2
         stx   $02,s
         lbsr  L112C
         bcs   L0FD2
         ldx   $02,s
         clra  
         clrb  
         std   -$05,x
         sta   -$03,x
         std   -$02,x
L0FBD    lbsr  L1206
         bcs   L0FD2
         ldx   $02,s
         leax  $05,x
         cmpx  ,s
         bcs   L0F97
L0FCA    clra  
         clrb  
         sta   <$19,y
         std   <$1A,y
L0FD2    leas  $04,s
         rts   
L0FD5    pshs  u,y,x,a
         ldx   <$1E,y
         ldd   $06,x
         subd  #$0001
         addd  <$17,y
         std   <$17,y
         ldd   $06,x
         bcc   L0FFD
         inc   <$16,y
         bra   L0FFD
L0FEE    lsr   <$16,y
         ror   <$17,y
         ror   <$18,y
         lsr   <$1A,y
         ror   <$1B,y
L0FFD    lsra  
         rorb  
         bcc   L0FEE
         clrb  
         ldd   <$1A,y
         beq   L103D
         ldd   <$16,y
         lsra  
         rorb  
         lsra  
         rorb  
         lsra  
         rorb  
         tfr   b,a
         ldb   #$DB
         cmpa  $04,x
         bhi   L103C
         inca  
         sta   ,s
L101B    bsr   L103F
         bcs   L101B
         ldb   ,s
         bsr   L109A
         bcs   L103C
         ldx   $08,y
         ldd   <$17,y
         anda  #$07
         ldy   <$1A,y
         os9   F$DelBit 
         ldy   $03,s
         ldb   ,s
         bsr   L1072
         bcc   L103D
L103C    coma  
L103D    puls  pc,u,y,x,a
L103F    lbsr  L1240
         bra   L104C
L1044    lbsr  L0C5F
         os9   F$IOQu   
         bsr   L105C
L104C    bcs   L105B
         ldx   <$1E,y
         lda   <$17,x
         bne   L1044
         lda   $05,y
         sta   <$17,x
L105B    rts   
L105C    ldu   <$0050
         ldb   <$19,u
         cmpb  #$01
         bls   L1069
         cmpb  #$03
         bls   L1070
L1069    clra  
         lda   $0C,u
         bita  #$02
         beq   L1071
L1070    coma  
L1071    rts   
L1072    clra  
         tfr   d,x
         clrb  
         lbsr  L1210
L1079    pshs  cc
         ldx   <$1E,y
         lda   $05,y
         cmpa  <$17,x
         bne   L1098
         clr   <$17,x
         ldx   <$0050
         lda   <$10,x
         beq   L1098
         lbsr  L0C5F
         ldx   #$0001
         os9   F$Sleep  
L1098    puls  pc,cc
L109A    clra  
         tfr   d,x
         clrb  
         lbra  L1143
L10A1    ldd   $0C,y
         subd  <$14,y
         tfr   d,x
         ldb   $0B,y
         sbcb  <$13,y
         cmpb  <$19,y
         bcs   L10B9
         bhi   L10BB
         cmpx  <$1A,y
         bcc   L10BB
L10B9    clrb  
L10BA    rts   
L10BB    pshs  u
         bsr   L112C
         bcs   L1117
         clra  
         clrb  
         std   <$13,y
         stb   <$15,y
         ldu   $08,y
         leax  <$10,u
         lda   $08,y
         ldb   #$FC
         pshs  b,a
L10D4    ldd   $03,x
         beq   L10F9
         addd  <$14,y
         tfr   d,u
         ldb   <$13,y
         adcb  #$00
         cmpb  $0B,y
         bhi   L1106
         bne   L10ED
         cmpu  $0C,y
         bhi   L1106
L10ED    stb   <$13,y
         stu   <$14,y
         leax  $05,x
         cmpx  ,s
         bcs   L10D4
L10F9    clra  
         clrb  
         sta   <$19,y
         std   <$1A,y
         comb  
         ldb   #$D5
         bra   L1115
L1106    ldd   ,x
         std   <$16,y
         lda   $02,x
         sta   <$18,y
         ldd   $03,x
         std   <$1A,y
L1115    leas  $02,s
L1117    puls  pc,u
L1119    pshs  x,b
         lbsr  L1240
         bcs   L1128
         clrb  
         ldx   #$0000
         bsr   L1143
         bcc   L112A
L1128    stb   ,s
L112A    puls  pc,x,b
L112C    ldb   $0A,y
         bitb  #$04
         bne   L10B9
         lbsr  L1240
         bcs   L10BA
         ldb   $0A,y
         orb   #$04
         stb   $0A,y
         ldb   <$34,y
         ldx   <$35,y
L1143    lda   #$03
L1145    pshs  u,y,x,b,a
         lda   $0A,y
         ora   #$20
         sta   $0A,y
         ldx   <$0050
         lda   $0A,x
         tfr   a,b
         addb  #$03
         bcc   L1159
         ldb   #$FF
L1159    stb   $0A,x
         stb   $0B,x
         ldx   <$30,y
         sta   <$16,x
         ldu   $03,y
         ldu   $02,u
         bra   L116F
L1169    lbsr  L0C5F
         os9   F$IOQu   
L116F    lda   $04,u
         bne   L1169
         lda   $05,y
         sta   $04,u
         ldd   ,s
         ldx   $02,s
         pshs  u
         bsr   L11F4
         puls  u
         ldy   $04,s
         pshs  cc
         bcc   L118A
         stb   $02,s
L118A    lda   $0A,y
         anda  #$DF
         sta   $0A,y
         clr   $04,u
         ldx   <$30,y
         lda   <$16,x
         ldx   <$0050
         sta   $0A,x
         lda   ,s
         bita  #$01
         bne   L11D4
         lda   $01,s
         cmpa  #$06
         bne   L11D4
         pshs  u,y,x
         ldy   <$30,y
         leau  ,y
L11B0    ldx   <$05,u
         cmpy  <$05,u
         beq   L11D2
         leau  ,x
         lda   <$17,u
         beq   L11B0
         ldx   <$0050
         cmpa  <$00,x
         beq   L11B0
         clr   <$17,u
         ldb   <$18,u
         os9   F$Send   
         bra   L11B0
L11D2    puls  u,y,x
L11D4    lda   <$10,x
         beq   L11F2
         lda   $01,y
         bita  #$04
         bne   L11F2
         ldx   <$1E,y
         lda   $05,y
         cmpa  <$17,x
         beq   L11F2
         lbsr  L0C5F
         ldx   #$0001
         os9   F$Sleep  
L11F2    puls  pc,u,y,x,b,a,cc
L11F4    pshs  pc,x,b,a
         ldx   $03,y
         ldd   ,x
         ldx   ,x
         addd  $09,x
         addb  ,s
         adca  #$00
         std   $04,s
         puls  pc,x,b,a
L1206    ldb   <$34,y
         ldx   <$35,y
         bra   L1210
L120E    bsr   L1229
L1210    lda   #$06
         pshs  x,b,a
         ldd   <$1C,y
         beq   L121F
         ldx   <$1E,y
         cmpd  $0E,x
L121F    puls  x,b,a
         lbeq  L1145
         comb  
         ldb   #$FB
         rts   
L1229    ldd   $0C,y
         subd  <$14,y
         tfr   d,x
         ldb   $0B,y
         sbcb  <$13,y
         exg   d,x
         addd  <$17,y
         exg   d,x
         adcb  <$16,y
         rts   
L1240    clrb  
         pshs  u,x
         ldb   $0A,y
         andb  #$46
         beq   L125D
         tfr   b,a
         eorb  $0A,y
         stb   $0A,y
         andb  #$01
         beq   L125D
         eorb  $0A,y
         stb   $0A,y
         bita  #$02
         beq   L125D
         bsr   L120E
L125D    puls  pc,u,x
L125F    pshs  u,x
         lbsr  L10A1
         bcs   L12CF
         bsr   L1240
         bcs   L12CF
L126A    ldb   $0B,y
         ldu   $0C,y
         leax  ,y
         ldy   <$30,y
L1274    ldx   <$30,x
         cmpy  $05,x
         beq   L12BE
         ldx   $05,x
         ldx   $01,x
         cmpu  $0C,x
         bne   L1274
         cmpb  $0B,x
         bne   L1274
         lda   $0A,x
         bita  #$02
         beq   L1274
         bita  #$20
         bne   L1297
         bita  #$40
         beq   L12A9
L1297    lda   $05,x
         ldy   $01,y
         lbsr  L0C5F
         os9   F$IOQu   
         lbsr  L105C
         bcc   L126A
         bra   L12CF
L12A9    ldy   $01,y
         ldd   $08,x
         ldu   $08,y
         std   $08,y
         stu   $08,x
         lda   $0A,x
         ora   #$40
         sta   $0A,y
         clr   $0A,x
         puls  pc,u,x
L12BE    ldy   $01,y
         lbsr  L1229
         lbsr  L1143
         bcs   L12CF
         lda   $0A,y
         ora   #$42
         sta   $0A,y
L12CF    puls  pc,u,x

         emod
eom      equ   *
         end
