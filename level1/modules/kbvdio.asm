********************************************************************
* progname - program module
*
* $Id$
*
* Ed.    Comments                                       Who YY/MM/DD
* ------------------------------------------------------------------
*  -     Original Dragon Data distribution version
*

         nam   KBVDIO
         ttl   os9 device driver    

* Disassembled 02/04/21 22:37:57 by Disasm v1.6 (C) 1988 by RML

         ifp1
         use   defsfile
         endc
tylg     set   Drivr+Objct   
atrv     set   ReEnt+rev
rev      set   $01
         mod   eom,name,tylg,atrv,start,size
u0000    rmb   2
u0002    rmb   1
u0003    rmb   1
u0004    rmb   1
u0005    rmb   4
u0009    rmb   2
u000B    rmb   1
u000C    rmb   1
u000D    rmb   11
u0018    rmb   1
u0019    rmb   1
u001A    rmb   1
u001B    rmb   1
u001C    rmb   1
u001D    rmb   2
u001F    rmb   2
u0021    rmb   1
u0022    rmb   1
u0023    rmb   1
u0024    rmb   1
u0025    rmb   1
u0026    rmb   2
u0028    rmb   1
u0029    rmb   2
u002B    rmb   1
u002C    rmb   1
u002D    rmb   2
u002F    rmb   1
u0030    rmb   1
u0031    rmb   2
u0033    rmb   1
u0034    rmb   1
u0035    rmb   1
u0036    rmb   1
u0037    rmb   1
u0038    rmb   1
u0039    rmb   1
u003A    rmb   1
u003B    rmb   2
u003D    rmb   1
u003E    rmb   1
u003F    rmb   1
u0040    rmb   1
u0041    rmb   1
u0042    rmb   1
u0043    rmb   1
u0044    rmb   1
u0045    rmb   1
u0046    rmb   1
u0047    rmb   1
u0048    rmb   1
u0049    rmb   1
u004A    rmb   1
u004B    rmb   10
u0055    rmb   26
u006F    rmb   91
size     equ   .
         fcb   $07 
name     equ   *
         fcs   /KBVDIO/
         fcb   $04 
start    equ   *
         lbra  L0027
         lbra  L0286
         lbra  L0345
         lbra  L0072
         lbra  L0098
         lbra  L009D
L0027    lbsr  L02BA
         lbra  L002D
L002D    pshs  cc
         orcc  #$10
         stu   >$006D
         ldd   >$0032
         std   >$006B
         leax  >L00B0,pcr
         stx   >$0032
         ldx   #$FF00
         stx   <u003B,u
         clra  
         clrb  
         std   <u0048,u
         sta   $01,x
         sta   ,x
         sta   $03,x
         comb  
         stb   <u003D,u
         stb   $02,x
         stb   <u003F,u
         stb   <u0040,u
         stb   <u0041,u
         lda   #$34
         sta   $01,x
         lda   #$3F
         sta   $03,x
         lda   $02,x
         puls  pc,cc
         ldb   #$F5
         orcc  #$01
         rts   
L0072    cmpa  #$01
         bne   L0082
         lda   <u0049,u
         suba  <u0048,u
         bne   L00AE
         ldb   #$F6
         bra   L009A
L0082    cmpa  #$06
         beq   L00AE
         cmpa  #$12
         lbeq  L04E4
         cmpa  #$13
         lbeq  L085F
         cmpa  #$1C
         lbeq  L04CD
L0098    ldb   #$D0
L009A    orcc  #$01
         rts   
L009D    pshs  cc
         orcc  #$10
         ldx   >$006B
         stx   >$0032
         puls  pc,cc
L00A9    incb  
         cmpb  #$7F
         bls   L00AF
L00AE    clrb  
L00AF    rts   
L00B0    ldu   >$006D
         ldx   <u003B,u
         lda   $03,x
         bmi   L00BE
         jmp   [>$0038]
L00BE    lda   $02,x
         lda   #$FF
         sta   $02,x
         lda   ,x
         coma  
         anda  #$03
         bne   L00D4
         clr   $02,x
         lda   ,x
         coma  
         anda  #$7F
         bne   L00F1
L00D4    clra  
         coma  
         sta   <u003F,u
         sta   <u0040,u
         sta   <u0041,u
L00DF    lda   >$006F
         beq   L00ED
         deca  
         sta   >$006F
         bne   L00ED
         sta   >$FF48
L00ED    jmp   [>$006B]
L00F1    bsr   L013F
         bmi   L00DF
         sta   <u0047,u
         cmpa  #$1F
         bne   L0101
         com   <u003D,u
         bra   L00DF
L0101    ldb   <u0048,u
         leax  <u004A,u
         abx   
         bsr   L00A9
         cmpb  <u0049,u
         beq   L0112
         stb   <u0048,u
L0112    sta   ,x
         beq   L0132
         cmpa  u000D,u
         bne   L0122
         ldx   u0009,u
         beq   L0132
         sta   $08,x
         bra   L0132
L0122    ldb   #$03
         cmpa  u000B,u
         beq   L012E
         ldb   #$02
         cmpa  u000C,u
         bne   L0132
L012E    lda   u0003,u
         bra   L0136
L0132    ldb   #$01
         lda   u0005,u
L0136    beq   L013B
         os9   F$Send   
L013B    clr   u0005,u
         bra   L00DF
L013F    clra  
         sta   <u003E,u
         sta   <u0045,u
         sta   <u0046,u
         coma  
         sta   <u0042,u
         sta   <u0043,u
         sta   <u0044,u
         deca  
         sta   $02,x
L0156    lda   ,x
         coma  
         anda  #$7F
         beq   L0169
         ldb   #$FF
L015F    incb  
         lsra  
         bcc   L0165
         bsr   L01AF
L0165    cmpb  #$06
         bcs   L015F
L0169    inc   <u003E,u
         orcc  #$01
         rol   $02,x
         bcs   L0156
         lbsr  L01F8
         bmi   L01AE
         suba  #$1B
         bcc   L0191
         adda  #$1B
         ldb   <u0046,u
         bne   L0190
         adda  #$40
         ldb   <u0045,u
         eorb  <u003D,u
         andb  #$01
         bne   L0190
         adda  #$20
L0190    rts   
L0191    ldb   #$03
         mul   
         lda   <u0045,u
         beq   L019C
         incb  
         bra   L01A3
L019C    lda   <u0046,u
         beq   L01A3
         addb  #$02
L01A3    pshs  x
         leax  >L023E,pcr
         clra  
         lda   d,x
         puls  x
L01AE    rts   
L01AF    pshs  b
         cmpb  #$06
         beq   L01BF
         cmpb  #$01
         bhi   L01BD
         addb  #$04
         bra   L01BF
L01BD    subb  #$02
L01BF    lslb  
         lslb  
         lslb  
         addb  <u003E,u
         cmpb  #$31
         bne   L01CE
         inc   <u0046,u
         puls  pc,b
L01CE    cmpb  #$37
         bne   L01D7
         com   <u0045,u
         puls  pc,b
L01D7    pshs  x
         leax  <u0042,u
         bsr   L01E2
         puls  x
         puls  pc,b
L01E2    pshs  a
         lda   ,x
         bpl   L01EC
         stb   ,x
         puls  pc,a
L01EC    lda   $01,x
         bpl   L01F4
         stb   $01,x
         puls  pc,a
L01F4    stb   $02,x
         puls  pc,a
L01F8    pshs  y,x,b
         leax  <u003F,u
         ldb   #$03
         pshs  b
L0201    leay  <u0042,u
         ldb   #$03
         lda   ,x
         bmi   L021D
L020A    cmpa  ,y
         bne   L0214
         clr   ,y
         com   ,y
         bra   L021D
L0214    leay  $01,y
         decb  
         bne   L020A
         lda   #$FF
         sta   ,x
L021D    leax  $01,x
         dec   ,s
         bne   L0201
         leas  $01,s
         leax  <u0042,u
         lda   #$03
L022A    ldb   ,x+
         bpl   L0235
         deca  
         bne   L022A
         orcc  #$08
         puls  pc,y,x,b
L0235    leax  <u003F,u
         bsr   L01E2
         tfr   b,a
         puls  pc,y,x,b
L023E    inc   <u001C
         sync  
         dec   <u001A
         nop   
         lsl   <u0018
         fcb   $10 
         rol   <u0019
         fcb   $11 
         bra   L026C
         bra   L027E
         leax  -$01,x
         leay  $01,y
         inc   >$3222
         neg   <u0033
         bls   L02D7
         pshs  y,b
         neg   <u0035
         bcs   L025F
L025F    pshu  y,b,a
         neg   <u0037
         beq   L02C3
         fcb   $38 8
         bvc   L02C3
         rts   
         bvs   L02C8
         abx   
L026C    bpl   L026E
L026E    rti   
         bmi   L0271
L0271    bge   L02AF
         tim   #$2D,>$3D5F
         bgt   L02B7
         tst   >$2F3F
         incb  
         tst   <u000D
         tst   <u0000
         neg   <u0000
         eim   #$03,<u001B
L0286    leax  <u004A,u
         ldb   <u0049,u
         orcc  #$10
         cmpb  <u0048,u
         beq   L029F
         abx   
         lda   ,x
         lbsr  L00A9
         stb   <u0049,u
         andcc #$EE
         rts   
L029F    lda   u0004,u
         sta   u0005,u
         andcc #$EF
         ldx   #$0000
         os9   F$Sleep  
         clr   u0005,u
         ldx   <u004B
L02AF    ldb   <$36,x
         beq   L0286
         cmpb  #$04
         bcc   L0286
         coma  
         rts   
L02BA    pshs  y,x
         clr   <u0025,u
         clr   <u002C,u
         pshs  u
         ldd   #$0300
         os9   F$SRqMem 
         tfr   u,d
         tfr   u,x
         bita  #$01
         beq   L02D8
         leax  >$0100,x
         bra   L02DC
L02D8    leau  >$0200,u
L02DC    ldd   #$0100
         os9   F$SRtMem 
         puls  u
         stx   <u001D,u
         clra  
         clrb  
         bsr   L0303
         stx   <u0021,u
         leax  >$0200,x
         stx   <u001F,u
         lbsr  L0459
         lda   #$60
         sta   <u0023,u
         sta   <u002B,u
         clrb  
         puls  pc,y,x
L0303    pshs  x,a
         lda   >$FF22
         anda  #$07
         ora   ,s+
         sta   >$FF22
         tstb  
         bne   L0320
         stb   >$FFC0
         stb   >$FFC2
         stb   >$FFC4
         lda   <u001D,u
         bra   L032C
L0320    stb   >$FFC0
         stb   >$FFC3
         stb   >$FFC5
         lda   <u002D,u
L032C    ldb   #$07
         ldx   #$FFC6
         lsra  
L0332    lsra  
         bcs   L033B
         sta   ,x+
         leax  $01,x
         bra   L033F
L033B    leax  $01,x
         sta   ,x+
L033F    decb  
         bne   L0332
         clrb  
         puls  pc,x
L0345    ldb   <u0025,u
         bne   L0387
         tsta  
         bmi   L0371
         cmpa  #$1F
         bls   L03BC
         cmpa  #$7C
         bne   L0359
         lda   #$61
         bra   L0371
L0359    cmpa  #$7E
         bne   L0361
         lda   #$6D
         bra   L0371
L0361    cmpa  #$60
         bcs   L036B
         suba  #$20
         ora   #$40
         bra   L0371
L036B    cmpa  #$40
         bcs   L0371
         suba  #$40
L0371    ldx   <u0021,u
         eora  #$40
         sta   ,x+
         stx   <u0021,u
         cmpx  <u001F,u
         bcs   L0382
         bsr   L039C
L0382    lbsr  L0415
         clrb  
         rts   
L0387    cmpb  #$01
         beq   L0394
         clr   <u0025,u
         sta   <u0029,u
         jmp   [<u0026,u]
L0394    sta   <u0028,u
         inc   <u0025,u
         clrb  
         rts   
L039C    ldx   <u001D,u
         leax  <$20,x
L03A2    ldd   ,x++
         std   <-$22,x
         cmpx  <u001F,u
         bcs   L03A2
         leax  <-$20,x
         stx   <u0021,u
         lda   #$20
         ldb   #$60
L03B6    stb   ,x+
         deca  
         bne   L03B6
L03BB    rts   
L03BC    cmpa  #$1B
         bcc   L03BB
         cmpa  #$10
         bcs   L03CE
         ldb   <u002C,u
         bne   L03CE
         ldb   #$F6
         orcc  #$01
         rts   
L03CE    leax  <L03D6,pcr
         lsla  
         ldd   a,x
         jmp   d,x
L03D6    stu   >$C400
         cmpa  <u0000
         bita  $00,x
         subb  <u00FF
         andb  #$FF
         andb  #$00
         eim   #$FF,>$C400
         asr   $00,x
         sbcb  $00,x
         fcb   $4E N
         stu   >$C400
         subd  #$0036
         neg   <u00F2
         oim   #$4A,<u0002
         bgt   L03FB
         rol   <u0002
L03FB    sex   
         aim   #$4E,<u0002
         rolb  
         aim   #$72,<u0002
         stu   <u0002
         orb   <u0002
         adca  #$02
         anda  #$03
         eora  >L682E,pcr
         fcb   $10 
         andb  #$E0
         stb   <u0022,u
L0415    ldx   <u0021,u
         lda   ,x
         sta   <u0023,u
         lda   #$20
         sta   ,x
         andcc #$FE
         rts   
         bsr   L0472
         leax  <$20,x
         cmpx  <u001F,u
         bcs   L0438
         leax  <-$20,x
         pshs  x
         lbsr  L039C
         puls  x
L0438    stx   <u0021,u
         bra   L0415
         bsr   L0472
         cmpx  <u001D,u
         bls   L0449
         leax  -$01,x
         stx   <u0021,u
L0449    bra   L0415
         bsr   L0472
         leax  $01,x
         cmpx  <u001F,u
         bcc   L0457
         stx   <u0021,u
L0457    bra   L0415
L0459    bsr   L0467
         lda   #$60
L045D    sta   ,x+
         cmpx  <u001F,u
         bcs   L045D
         lbra  L0415
L0467    bsr   L0472
         ldx   <u001D,u
         stx   <u0021,u
         lbra  L0415
L0472    ldx   <u0021,u
         lda   <u0023,u
         sta   ,x
         rts   
         leax  <L0481,pcr
         lbra  L064B
L0481    bsr   L0472
         ldb   <u0029,u
         subb  #$20
         lda   #$20
         mul   
         addb  <u0028,u
         adca  #$00
         subd  #$0020
         addd  <u001D,u
         cmpd  <u001F,u
         bcc   L04A3
         std   <u0021,u
         lbsr  L0415
         clrb  
L04A3    lbra  L0415
         lbsr  L040C
         ldb   #$20
         lda   #$60
         ldx   <u0021,u
L04B0    sta   ,x+
         decb  
         bne   L04B0
         lbra  L0415
         bsr   L0472
         leax  <-$20,x
         cmpx  <u001D,u
         bcs   L04C5
         stx   <u0021,u
L04C5    lbra  L0415
         clra  
         clrb  
         lbra  L0303
L04CD    ldx   $06,y
         ldd   <u001D,u
         std   $04,x
         ldd   <u0021,u
         std   $06,x
         ldb   <u003D,u
         stb   $01,x
         clrb  
         rts   
L04E0    neg   <u0055
         ora   [>$A6C8]
         bge   L050E
         eim   #$C6,<u00F6
         orcc  #$01
         rts   
         ldd   <u0034,u
         lbsr  L0684
         tfr   a,b
         andb  ,x
L04F8    bita  #$01
         bne   L0507
         lsra  
         lsrb  
         tst   <u0024,u
         bmi   L04F8
         lsra  
         lsrb  
         bra   L04F8
L0507    pshs  b
         ldb   <u003A,u
         andb  #$FC
L050E    orb   ,s+
         ldx   $06,y
         stb   $01,x
         ldd   <u0034,u
         std   $06,x
         ldd   <u002D,u
         std   $04,x
         clrb  
         rts   
         leax  <L0526,pcr
         lbra  L064B
L0526    ldb   <u002C,u
         bne   L0566
         pshs  u
         ldd   #$1900
         os9   F$SRqMem 
         tfr   u,d
         puls  u
         bcs   L0585
         tfr   a,b
         bita  #$01
         beq   L0543
         adda  #$01
         bra   L0545
L0543    addb  #$18
L0545    pshs  u,a
         tfr   b,a
         clrb  
         tfr   d,u
         ldd   #$0100
         os9   F$SRtMem 
         puls  u,a
         bcs   L0585
         clrb  
         std   <u002D,u
         addd  #$1800
         std   <u002F,u
         inc   <u002C,u
         lbsr  L0624
L0566    lda   <u0029,u
         sta   <u003A,u
         anda  #$03
         leax  >L04E0,pcr
         lda   a,x
         sta   <u0036,u
         sta   <u0037,u
         lda   <u0028,u
         cmpa  #$01
         bls   L0586
         ldb   #$CB
         orcc  #$01
L0585    rts   
L0586    tsta  
         beq   L05A6
         ldd   #$C003
         std   <u0038,u
         lda   #$01
         sta   <u0024,u
         lda   #$E0
         ldb   <u0029,u
         andb  #$08
         beq   L059F
         lda   #$F0
L059F    ldb   #$03
         leax  <L05D3,pcr
         bra   L05BE
L05A6    ldd   #$8001
         std   <u0038,u
         lda   #$FF
         sta   <u0036,u
         sta   <u0037,u
         sta   <u0024,u
         lda   #$F0
         ldb   #$07
         leax  <L05D7,pcr
L05BE    stb   <u0033,u
         stx   <u0031,u
         ldb   <u0029,u
         andb  #$04
         lslb  
         pshs  b
         ora   ,s+
         ldb   #$01
         lbra  L0303
L05D3    subb  #$30
         inc   <u0003
L05D7    suba  #$40
         bra   L05EB
         lsl   <u0004
         aim   #$01,<u0030
         cmpx  #$0316
         oim   #$9C,<u006F
         eorb  #$28
         lda   <u0024,u
L05EB    bmi   L05F0
         inc   <u0028,u
L05F0    lbra  L0566
         pshs  u
         ldu   <u002D,u
         ldd   #$1800
         os9   F$SRtMem 
         puls  u
         clr   <u002C,u
         rts   
         leax  <L060A,pcr
         lbra  L0781
L060A    lda   <u0029,u
         tst   <u0024,u
         bpl   L061A
         ldb   #$FF
         anda  #$01
         beq   L0624
         bra   L0625
L061A    anda  #$03
         leax  >L04E0,pcr
         ldb   a,x
         bra   L0625
L0624    clrb  
L0625    ldx   <u002D,u
L0628    stb   ,x+
         cmpx  <u002F,u
         bcs   L0628
         clra  
         clrb  
         std   <u0034,u
         rts   
L0635    ldd   <u0028,u
         cmpb  #$C0
         bcs   L063E
         ldb   #$BF
L063E    tst   <u0024,u
         bmi   L0644
         lsra  
L0644    std   <u0028,u
         rts   
         leax  <L0653,pcr
L064B    stx   <u0026,u
         inc   <u0025,u
         clrb  
         rts   
L0653    bsr   L0635
         std   <u0034,u
         clrb  
         rts   
         clr   <u0036,u
         bra   L065F
L065F    leax  <L0664,pcr
         bra   L064B
L0664    bsr   L0635
         std   <u0034,u
         bsr   L0673
         lda   <u0037,u
         sta   <u0036,u
         clrb  
         rts   
L0673    bsr   L0684
         tfr   a,b
         comb  
         andb  ,x
         stb   ,x
         anda  <u0036,u
         ora   ,x
         sta   ,x
         rts   
L0684    pshs  y,b,a
         ldb   <u0024,u
         bpl   L068C
         lsra  
L068C    lsra  
         lsra  
         pshs  a
         ldb   #$BF
         subb  $02,s
         lda   #$20
         mul   
         addb  ,s+
         adca  #$00
         ldy   <u002D,u
         leay  d,y
         lda   ,s
         sty   ,s
         anda  <u0033,u
         ldx   <u0031,u
         lda   a,x
         puls  pc,y,x
         clr   <u0036,u
         bra   L06B5
L06B5    leax  <L06BA,pcr
         bra   L064B
L06BA    lbsr  L0635
         leas  -$0E,s
         std   $0C,s
         bsr   L0684
         stx   $02,s
         sta   $01,s
         ldd   <u0034,u
         bsr   L0684
         sta   ,s
         clra  
         clrb  
         std   $04,s
         lda   #$BF
         suba  <u0035,u
         sta   <u0035,u
         lda   #$BF
         suba  <u0029,u
         sta   <u0029,u
         lda   #$FF
         sta   $06,s
         clra  
         ldb   <u0034,u
         subb  <u0028,u
         sbca  #$00
         bpl   L06F7
         nega  
         negb  
         sbca  #$00
         neg   $06,s
L06F7    std   $08,s
         bne   L0700
         ldd   #$FFFF
         std   $04,s
L0700    lda   #$E0
         sta   $07,s
         clra  
         ldb   <u0035,u
         subb  <u0029,u
         sbca  #$00
         bpl   L0715
         nega  
         negb  
         sbca  #$00
         neg   $07,s
L0715    std   $0A,s
         bra   L0721
L0719    sta   ,s
         ldd   $04,s
         subd  $0A,s
         std   $04,s
L0721    lda   ,s
         tfr   a,b
         anda  <u0036,u
         comb  
         andb  ,x
         pshs  b
         ora   ,s+
         sta   ,x
         cmpx  $02,s
         bne   L073B
         lda   ,s
         cmpa  $01,s
         beq   L076F
L073B    ldd   $04,s
         bpl   L0749
         addd  $08,s
         std   $04,s
         lda   $07,s
         leax  a,x
         bra   L0721
L0749    lda   ,s
         ldb   $06,s
         bpl   L075F
         lsla  
         ldb   <u0024,u
         bmi   L0756
         lsla  
L0756    bcc   L0719
         lda   <u0039,u
         leax  -$01,x
         bra   L0719
L075F    lsra  
         ldb   <u0024,u
         bmi   L0766
         lsra  
L0766    bcc   L0719
         lda   <u0038,u
         leax  $01,x
         bra   L0719
L076F    ldd   $0C,s
         std   <u0034,u
         leas  $0E,s
         lda   <u0037,u
         sta   <u0036,u
         clrb  
         rts   
         leax  <L0789,pcr
L0781    stx   <u0026,u
         com   <u0025,u
         clrb  
         rts   
L0789    leas  -$04,s
         ldb   <u0029,u
         stb   $01,s
         clra  
         sta   ,s
         addb  $01,s
         adca  #$00
         nega  
         negb  
         sbca  #$00
         addd  #$0003
         std   $02,s
L07A0    lda   ,s
         cmpa  $01,s
         bcc   L07D2
         ldb   $01,s
         bsr   L07E0
         clra  
         ldb   $02,s
         bpl   L07BA
         ldb   ,s
         lslb  
         rola  
         lslb  
         rola  
         addd  #$0006
         bra   L07CA
L07BA    dec   $01,s
         clra  
         ldb   ,s
         subb  $01,s
         sbca  #$00
         lslb  
         rola  
         lslb  
         rola  
         addd  #$000A
L07CA    addd  $02,s
         std   $02,s
         inc   ,s
         bra   L07A0
L07D2    lda   ,s
         cmpa  $01,s
         bne   L07DC
         ldb   $01,s
         bsr   L07E0
L07DC    leas  $04,s
         clrb  
         rts   
L07E0    leas  -$08,s
         sta   ,s
         clra  
         std   $02,s
         nega  
         negb  
         sbca  #$00
         std   $06,s
         ldb   ,s
         clra  
         std   ,s
         nega  
         negb  
         sbca  #$00
         std   $04,s
         ldx   $06,s
         bsr   L0829
         ldd   $04,s
         ldx   $02,s
         bsr   L0829
         ldd   ,s
         ldx   $02,s
         bsr   L0829
         ldd   ,s
         ldx   $06,s
         bsr   L0829
         ldd   $02,s
         ldx   ,s
         bsr   L0829
         ldd   $02,s
         ldx   $04,s
         bsr   L0829
         ldd   $06,s
         ldx   $04,s
         bsr   L0829
         ldd   $06,s
         ldx   ,s
         bsr   L0829
         leas  $08,s
         rts   
L0829    pshs  b,a
         ldb   <u0035,u
         clra  
         leax  d,x
         cmpx  #$0000
         bmi   L083B
         cmpx  #$00BF
         ble   L083D
L083B    puls  pc,b,a
L083D    ldb   <u0034,u
         clra  
         tst   <u0024,u
         bmi   L0848
         lslb  
         rola  
L0848    addd  ,s++
         tsta  
         beq   L084E
         rts   
L084E    pshs  b
         tfr   x,d
         puls  a
         tst   <u0024,u
         lbmi  L0673
         lsra  
         lbra  L0673
L085F    ldx   $06,y
         pshs  y,cc
         orcc  #$10
         lda   #$FF
         clr   >$FF02
         ldb   >$FF00
         ldy   $04,x
         bne   L0878
         andb  #$01
         bne   L087C
         bra   L087D
L0878    andb  #$02
         beq   L087D
L087C    clra  
L087D    sta   $01,x
         lda   >$FF03
         ora   #$08
         ldy   $04,x
         bne   L088B
         anda  #$F7
L088B    sta   >$FF03
         lda   >$FF01
         anda  #$F7
         bsr   L08AA
         std   $04,x
         lda   >$FF01
         ora   #$08
         bsr   L08AA
         pshs  b,a
         ldd   #$003F
         subd  ,s++
         std   $06,x
         clrb  
         puls  pc,y,cc
L08AA    sta   >$FF01
         clrb  
         bsr   L08BA
         bsr   L08BA
         bsr   L08BA
         bsr   L08BA
         lsrb  
         lsrb  
         clra  
         rts   
L08BA    pshs  b
         lda   #$7F
         tfr   a,b
L08C0    lsrb  
         cmpb  #$03
         bhi   L08CC
         lsra  
         lsra  
         tfr   a,b
         addb  ,s+
         rts   
L08CC    addb  #$02
         andb  #$FC
         pshs  b
         anda  #$FC
         sta   >$FF20
         tst   >$FF00
         bpl   L08E0
         adda  ,s+
         bra   L08C0
L08E0    suba  ,s+
         bra   L08C0
         emod
eom      equ   *
