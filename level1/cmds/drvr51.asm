********************************************************************
* drvr51 - Driver for The 51 column by 24 line video display
*
* $Id$
*
* Ed.    Comments                                       Who YY/MM/DD
* ------------------------------------------------------------------
* 1      Original Dragon distribution version


         nam   drvr51
         ttl   Driver for The 51 column by 24 line video display

* Disassembled 02/07/06 21:17:23 by Disasm v1.6 (C) 1988 by RML

         ifp1
         use   defsfile
         endc
tylg     set   Drivr+Objct   
atrv     set   ReEnt+rev
rev      set   $01
         mod   eom,name,tylg,atrv,start,size
u0000    rmb   1
u0001    rmb   1
u0002    rmb   1
u0003    rmb   1
u0004    rmb   1
u0005    rmb   1
u0006    rmb   1
u0007    rmb   1
u0008    rmb   1
u0009    rmb   1
u000A    rmb   1
u000B    rmb   1
u000C    rmb   1
u000D    rmb   1
u000E    rmb   1
u000F    rmb   8
u0017    rmb   4
u001B    rmb   2
u001D    rmb   1
u001E    rmb   1
u001F    rmb   1
u0020    rmb   1
u0021    rmb   1
u0022    rmb   2
u0024    rmb   1
u0025    rmb   1
u0026    rmb   1
u0027    rmb   1
u0028    rmb   1
u0029    rmb   1
u002A    rmb   1
u002B    rmb   1
u002C    rmb   1
u002D    rmb   1
u002E    rmb   1
u002F    rmb   1
u0030    rmb   1
u0031    rmb   1
u0032    rmb   1
u0033    rmb   1
u0034    rmb   1
u0035    rmb   1
u0036    rmb   1
u0037    rmb   1
u0038    rmb   1
u0039    rmb   1
u003A    rmb   6
u0040    rmb   2
u0042    rmb   2
u0044    rmb   6
u004A    rmb   1
u004B    rmb   5
u0050    rmb   5
u0055    rmb   9
u005E    rmb   2
u0060    rmb   9
u0069    rmb   6
u006F    rmb   1
u0070    rmb   1
u0071    rmb   7
u0078    rmb   6
u007E    rmb   2
u0080    rmb   8
u0088    rmb   6
u008E    rmb   2
u0090    rmb   6
u0096    rmb   3
u0099    rmb   1
u009A    rmb   3
u009D    rmb   1
size     equ   .
         fcb   $03 
name     equ   *
         fcs   /drvr51/
         fcb   $01 
start    equ   *
         lbra  L0027
         lbra  L00EE
         lbra  L011D
         lbra  L04BE
         lbra  L04E1
         lbra  L009E+1
L0027    pshs  u,a
         ldu   <u001D,u
         ldd   #$0200
         os9   F$SRtMem 
         ldu   $01,s
         tst   <u002C,u
         beq   L0044
         ldu   <u002D,u
         ldd   #$1800
         os9   F$SRtMem 
         ldu   $01,s
L0044    ldb   #$81
         leax  <u001D,u
L0049    clr   ,x+
         decb  
         bne   L0049
         ldd   #$1900
         os9   F$SRqMem 
         bcs   L009C
         tfr   u,d
         ldu   $01,s
         tfr   d,x
         bita  #$01
         beq   L0066
         leax  >$0100,x
         bra   L0068
L0066    adda  #$18
L0068    stx   <u0022,u
         tfr   d,u
         ldd   #$0100
         os9   F$SRtMem 
         ldu   $01,s
         lda   #$10
         sta   <u0037,u
         pshs  cc
         orcc  #$50
         leay  >L00AD,pcr
         sty   >$0032
         ldx   #$FF00
         lda   $03,x
         ora   #$01
         sta   $03,x
         inc   >L009E,pcr
         puls  cc
         lbsr  L0475
         lbsr  L02C3
         clrb  
L009C    puls  pc,u,a
L009E    neg   <u0034
         oim   #$1A,<u0050
         ldx   >$006B
         stx   >$0032
         puls  cc
         clrb  
         rts   
L00AD    ldu   >$006D
         ldx   #$FF00
         lda   $03,x
         bmi   L00BB
         jmp   [>$0038]
L00BB    lda   $02,x
         lda   >$006F
         beq   L00CB
         deca  
         sta   >$006F
         bne   L00CB
         sta   >$FF48
L00CB    lbsr  L04E5
         jmp   [>$006B]
L00D2    pshs  x,b
         lda   u0004,u
         sta   u0005,u
         ldx   #$0000
         os9   F$Sleep  
         ldx   <u004B
         ldb   <$36,x
         beq   L00EC
         cmpb  #$03
         bhi   L00EC
         coma  
         puls  pc,x,a
L00EC    puls  x,b
L00EE    tst   >L009E,pcr
         bne   L00F9
         lbsr  L0027
         bcs   L011C
L00F9    leax  <u003A,u
         orcc  #$10
         ldb   <u001D,u
         cmpb  <u001E,u
         beq   L00D2
         lda   b,x
         incb  
         cmpb  #$64
         bcs   L010E
         clrb  
L010E    stb   <u001D,u
         andcc #$EE
         tst   u000E,u
         beq   L011C
         clr   u000E,u
         comb  
         ldb   #$F4
L011C    rts   
L011D    tst   >L009E,pcr
         bne   L012C
         pshs  a
         lbsr  L0027
         puls  a
         bcs   L0139
L012C    ldb   <u001F,u
         bne   L0165
         cmpa  #$1B
         bne   L013A
         inc   <u001F,u
         clrb  
L0139    rts   
L013A    cmpa  #$20
         bcs   L0144
         cmpa  #$7F
         bcc   L0144
         bra   L0173
L0144    leax  >L066E,pcr
L0148    tst   ,x
         bne   L0150
L014C    clr   <u001F,u
         rts   
L0150    cmpa  ,x+
         bne   L0161
         ldd   ,x
         leax  >L066E,pcr
         leax  d,x
         stx   <u0020,u
         jmp   ,x
L0161    leax  $02,x
         bra   L0148
L0165    inc   <u001F,u
         leax  >L0681,pcr
         cmpb  #$01
         beq   L0148
         jmp   [<u0020,u]
L0173    inc   <u0032,u
         bsr   L01B3
         tst   <u0039,u
         beq   L0185
         lda   #$F8
         leay  <-$40,y
         lbsr  L0236
L0185    lda   <u0024,u
         inca  
         cmpa  #$33
         bcs   L01A2
         clr   <u0024,u
         lda   <u0025,u
         inca  
         cmpa  #$18
         bcs   L019D
         lbsr  L033E
         bra   L01A5
L019D    sta   <u0025,u
         bra   L01A5
L01A2    sta   <u0024,u
L01A5    clr   <u0033,u
         ldd   <u0024,u
         std   <u0030,u
         dec   <u0032,u
         clrb  
         rts   
L01B3    tfr   a,b
         subb  #$20
         clra  
         leax  >L06A0,pcr
         lslb  
         rola  
         lslb  
         rola  
         leax  d,x
         ldb   #$05
         lda   <u0024,u
         mul   
         pshs  b
         lsra  
         rorb  
         lsra  
         rorb  
         lsra  
         rorb  
         puls  a
         anda  #$07
         pshs  b
         sta   <u0026,u
         tst   <u0034,u
         bne   L01FF
         tfr   a,b
         lda   #$F8
         tstb  
         beq   L01FA
L01E5    lsra  
         decb  
         bhi   L01E5
         bne   L01EE
         rorb  
         bra   L01FA
L01EE    pshs  b
         ldb   #$80
L01F2    lsra  
         rorb  
         dec   ,s
         bne   L01F2
         leas  $01,s
L01FA    coma  
         comb  
         std   <u0035,u
L01FF    ldy   <u0022,u
         lda   <u0025,u
         ldb   ,s+
         leay  d,y
         lda   #$04
         pshs  a
         inc   <u0032,u
L0211    lda   ,x
         anda  #$F0
         bsr   L0236
         lda   ,x+
         anda  #$0F
         bsr   L0227
         dec   ,s
         bne   L0211
         dec   <u0032,u
         clrb  
         puls  pc,b
L0227    ldb   <u0026,u
         subb  #$04
         bhi   L023B
         beq   L0250
L0230    lsla  
         incb  
         bne   L0230
         bra   L0250
L0236    ldb   <u0026,u
         beq   L0250
L023B    lsra  
         decb  
         bhi   L023B
         bne   L0244
         rorb  
         bra   L0250
L0244    pshs  b
         ldb   #$80
L0248    lsra  
         rorb  
         dec   ,s
         bne   L0248
         leas  $01,s
L0250    tst   <u0034,u
         bne   L0273
         tst   <u0038,u
         beq   L0262
         coma  
         comb  
         eora  <u0035,u
         eorb  <u0036,u
L0262    pshs  b,a
         ldd   <u0035,u
         anda  ,y
         andb  $01,y
         addd  ,s++
L026D    std   ,y
         leay  <$20,y
         rts   
L0273    eora  ,y
         eorb  $01,y
         bra   L026D
         ldx   #$FF20
         ldb   #$64
L027E    lda   ,x
         eora  #$C0
         sta   ,x
         lda   #$19
L0286    deca  
         nop   
         nop   
         bne   L0286
         decb  
         bne   L027E
         lbra  L014C
         dec   <u0024,u
         bpl   L02A6
         lda   #$32
         sta   <u0024,u
         dec   <u0025,u
         bpl   L02A6
         clr   <u0025,u
         lbsr  L035E
L02A6    lbsr  L0484
         lbra  L014C
L02AC    lda   <u0025,u
         inca  
         cmpa  #$18
         bcs   L02B9
         lbsr  L033E
         bra   L02BC
L02B9    sta   <u0025,u
L02BC    bra   L02A6
         clr   <u0024,u
         bra   L02A6
L02C3    ldy   <u0022,u
         leay  >$0080,y
         lda   #$18
         pshs  a
         inc   <u0032,u
L02D2    bsr   L0314
         dec   ,s
         bne   L02D2
         leas  $01,s
         clra  
         clrb  
         sta   <u0033,u
         std   <u0030,u
         std   <u0024,u
         dec   <u0032,u
         ldx   #$FF20
         lda   $02,x
         ora   #$F0
         sta   $02,x
         ldx   #$FFC0
         lda   #$06
         ldb   #$03
         bsr   L0305
         lda   <u0022,u
         lsra  
         ldb   #$07
         bsr   L0305
         lbra  L014C
L0305    lsra  
         bcc   L030E
         leax  $01,x
         sta   ,x+
         bra   L0310
L030E    sta   ,x++
L0310    decb  
         bne   L0305
         rts   
L0314    lda   #$10
L0316    pshs  a
         lda   <u0038,u
         tfr   a,b
L031D    std   <-$80,y
         std   <-$60,y
         std   <-$40,y
         std   <-$20,y
         std   <$20,y
         std   <$40,y
         std   <$60,y
         std   ,y++
         dec   ,s
         bne   L031D
         leay  >$00E0,y
         puls  pc,b
L033E    ldy   <u0022,u
         inc   <u0032,u
         pshs  u
         leau  >$0100,y
         lda   #$10
         bsr   L037C
         puls  u
         dec   <u0031,u
L0354    leay  >$0080,y
         bsr   L0314
         dec   <u0032,u
         rts   
L035E    ldy   <u0022,u
         leay  >$17F0,y
         inc   <u0032,u
         pshs  u
         leau  >-$0100,y
         lda   #$F0
         bsr   L037C
         leay  ,u
         puls  u
         inc   <u0031,u
         bra   L0354
L037C    ldb   #$17
         pshs  b
L0380    ldb   #$10
L0382    ldx   ,u
         stx   ,y
         ldx   u0002,u
         stx   $02,y
         ldx   u0004,u
         stx   $04,y
         ldx   u0006,u
         stx   $06,y
         ldx   u0008,u
         stx   $08,y
         ldx   u000A,u
         stx   $0A,y
         ldx   u000C,u
         stx   $0C,y
         ldx   u000E,u
         stx   $0E,y
         leay  a,y
         leau  a,u
         decb  
         bne   L0382
         dec   ,s
         bne   L0380
         puls  pc,b
         inc   <u0032,u
         bsr   L03BA
         dec   <u0032,u
         lbra  L014C
L03BA    clr   <u0033,u
         ldb   <u0024,u
         pshs  b
         bitb  #$07
         bne   L03CB
         lda   #$05
         mul   
         bra   L03F3
L03CB    lda   #$01
         pshs  a
L03CF    lda   #$20
         lbsr  L01B3
         lda   <u0024,u
         inca  
         sta   <u0024,u
         cmpa  #$33
         bcs   L03E3
         leas  $01,s
         bra   L040D
L03E3    dec   ,s
         bpl   L03CF
         lda   <u0024,u
         ldb   #$05
         mul   
         bitb  #$08
         bne   L03CF
         leas  $01,s
L03F3    lsrb  
         lsrb  
         lsrb  
         ldy   <u0022,u
         lda   <u0025,u
         leay  d,y
         leay  >$0080,y
         lda   #$20
         pshs  b
         suba  ,s+
         lsra  
         lbsr  L0316
L040D    puls  a
         sta   <u0024,u
         rts   
         inc   <u0032,u
         bsr   L03BA
         lda   #$17
         suba  <u0025,u
         bls   L042A
         pshs  a
L0421    lbsr  L0314
         dec   ,s
         bne   L0421
         leas  $01,s
L042A    dec   <u0032,u
         lbra  L014C
         clr   <u0024,u
         clr   <u0025,u
         lbra  L02A6
         ldb   <u001F,u
         subb  #$02
         bne   L0442
         clrb  
         rts   
L0442    decb  
         bne   L0450
         cmpa  #$33
         bcs   L044B
         lda   #$32
L044B    sta   <u0024,u
         clrb  
         rts   
L0450    cmpa  #$18
         bcs   L0456
         lda   #$17
L0456    sta   <u0025,u
L0459    lbra  L02A6
         inc   <u0024,u
         lda   <u0024,u
         cmpa  #$33
         bcs   L0459
         clr   <u0024,u
         lbra  L02AC
         lda   #$FF
         coma  
L046F    sta   <u0038,u
         lbra  L014C
L0475    lda   #$FF
         bra   L046F
         lda   #$FF
L047B    sta   <u0039,u
         lbra  L014C
         clra  
         bra   L047B
L0484    ldd   <u0024,u
         inc   <u0032,u
         tst   <u0033,u
         bne   L0494
         std   <u0030,u
         bra   L04B9
L0494    pshs  b,a
         ldd   <u0030,u
         inc   <u0034,u
         tstb  
         bmi   L04AB
         cmpb  #$18
         bcc   L04AB
         std   <u0024,u
         lda   #$7F
         lbsr  L01B3
L04AB    puls  b,a
         std   <u0024,u
         std   <u0030,u
         clr   <u0033,u
         dec   <u0034,u
L04B9    dec   <u0032,u
         clrb  
         rts   
L04BE    cmpa  #$01
         bne   L04D0
         lda   <u001D,u
         cmpa  <u001E,u
         beq   L04CC
L04CA    clrb  
         rts   
L04CC    comb  
         ldb   #$F6
         rts   
L04D0    cmpa  #$06
         beq   L04CA
         cmpa  #$02
         bne   L04E1
         ldx   $06,y
         ldd   <u0022,u
         std   $04,x
         clrb  
         rts   
L04E1    comb  
         ldb   #$D0
         rts   
L04E5    tst   <u0032,u
         bne   L0512
         dec   <u0037,u
         bne   L0512
         lda   #$10
         sta   <u0037,u
         inc   <u0034,u
         ldd   <u0024,u
         pshs  b,a
         ldd   <u0030,u
         std   <u0024,u
         lda   #$7F
         lbsr  L01B3
         puls  b,a
         std   <u0024,u
         com   <u0033,u
         dec   <u0034,u
L0512    ldx   #$FF00
         lda   #$FF
         sta   $02,x
         bsr   L053B
         anda  #$03
         bne   L0526
         clra  
         sta   $02,x
         bsr   L053B
         bne   L052D
L0526    clr   <u0027,u
         clr   <u0028,u
         rts   
L052D    tst   <u0028,u
         bne   L0541
         sta   <u0028,u
L0535    clrb  
         rts   
L0537    clrb  
         stb   $02,x
         rts   
L053B    lda   ,x
         coma  
         anda  #$7F
         rts   
L0541    cmpa  <u0028,u
         bne   L0526
         clr   <u002A,u
         clr   <u002B,u
         clr   <u002C,u
         clr   <u002D,u
         clr   <u002E,u
         ldb   #$01
L0557    comb  
         stb   $02,x
         bsr   L053B
         beq   L05A1
         bita  #$40
         beq   L0583
         cmpb  #$7F
         bne   L056B
         inc   <u002D,u
         bra   L057F
L056B    cmpb  #$FD
         bne   L0574
         inc   <u002E,u
         bra   L057F
L0574    tst   <u002C,u
         bne   L0537
         stb   <u002C,u
         com   <u002C,u
L057F    anda  #$3F
         beq   L05A1
L0583    pshs  b,a
         clrb  
L0586    lsra  
         bcc   L058A
         incb  
L058A    tsta  
         bne   L0586
         cmpb  #$01
         puls  b,a
         bne   L0537
         tst   <u002A,u
         bne   L0537
         sta   <u002A,u
         stb   <u002B,u
         com   <u002B,u
L05A1    comb  
         lslb  
         bne   L0557
         stb   $02,x
         ldb   <u002C,u
         beq   L05B5
         tst   <u002A,u
         bne   L0535
         lda   #$40
         bra   L05BF
L05B5    ldb   <u002B,u
         lda   <u002A,u
         lbeq  L0526
L05BF    pshs  b
         tst   <u0027,u
         beq   L05D0
         dec   <u0027,u
         beq   L05D4
         puls  b
         lbra  L0665
L05D0    ldb   #$32
         bra   L05D6
L05D4    ldb   #$05
L05D6    stb   <u0027,u
         lbsr  L0667
         lslb  
         lslb  
         lslb  
         puls  a
         pshs  b
         lbsr  L0667
         orb   ,s+
         stb   <u0029,u
         leax  >L0820,pcr
         lda   b,x
         tst   <u002E,u
         beq   L05FE
         leax  >L0886,pcr
         lda   b,x
         bra   L0609
L05FE    tst   <u002D,u
         beq   L0612
         leax  >L0853,pcr
         lda   b,x
L0609    cmpa  #$1F
         bne   L0621
         com   <u002F,u
         bra   L0665
L0612    tst   <u002F,u
         beq   L0621
         cmpa  #$61
         bcs   L0621
         cmpa  #$7A
         bhi   L0621
         suba  #$20
L0621    leax  <u003A,u
         ldb   <u001E,u
         sta   b,x
         incb  
         cmpb  #$64
         bcs   L062F
         clrb  
L062F    cmpb  <u001D,u
         bne   L0638
         inc   u000E,u
         bra   L063B
L0638    stb   <u001E,u
L063B    tsta  
         beq   L065A
         cmpa  u000D,u
L0640    bne   L064A
         ldx   u0009,u
         beq   L065A
L0646    sta   $08,x
         bra   L065A
L064A    ldb   #$03
         cmpa  u000B,u
         beq   L0656
         ldb   #$02
         cmpa  u000C,u
         bne   L065A
L0656    lda   u0003,u
         bra   L065E
L065A    ldb   #$01
         lda   u0005,u
L065E    beq   L0663
         os9   F$Send   
L0663    clr   u0005,u
L0665    clrb  
         rts   
L0667    clrb  
L0668    incb  
         lsra  
         bne   L0668
         decb  
         rts   

L066E  fcb $07
       fcb $FC
       fcb $0B
       fcb $08
       fcb $FC
       fcb $23
       fcb $0A
       fcb $FC
       fcb $3E
       fcb $0D
       fcb $FC
       fcb $50
       fcb $0C
       fcb $FC
       fcb $55
       fcb $0B
       fcb $FD
       fcb $C2
       fcb $00
L0681  fcb $41
       fcb $FD
       fcb $CB
       fcb $42
       fcb $FD
       fcb $41
       fcb $43
       fcb $FD
       fcb $EE
       fcb $44
       fcb $FC
       fcb $2D
       fcb $45
       fcb $FC
       fcb $3E
       fcb $46
       fcb $FD
       fcb $FE
       fcb $47
       fcb $FE
       fcb $07
       fcb $48
       fcb $FE
       fcb $0B
       fcb $49
       fcb $FE
       fcb $13
       fcb $4A
       fcb $FD
       fcb $A5
       fcb $00
L06A0  fcb $00
       fcb $00
       fcb $00
       fcb $00
       fcb $44
       fcb $40
       fcb $40
       fcb $00
       fcb $55
       fcb $00
       fcb $00
       fcb $00
       fcb $6F
       fcb $6F
       fcb $60
       fcb $00
       fcb $27
       fcb $86
       fcb $1E
       fcb $20
       fcb $91
       fcb $24
       fcb $89
       fcb $00
       fcb $4A
       fcb $4A
       fcb $D0
       fcb $00
       fcb $44
       fcb $00
       fcb $00
       fcb $00
       fcb $24
       fcb $44
       fcb $20
       fcb $00
       fcb $42
       fcb $22
       fcb $40
       fcb $00
       fcb $96
       fcb $F6
       fcb $90
       fcb $00
       fcb $44
       fcb $E4
       fcb $40
       fcb $00
       fcb $00
       fcb $02
       fcb $24
       fcb $00
       fcb $00
       fcb $F0
       fcb $00
       fcb $00
       fcb $00
       fcb $06
       fcb $60
       fcb $00
       fcb $01
       fcb $24
       fcb $80
       fcb $00
       fcb $69
       fcb $BD
       fcb $60
       fcb $00
       fcb $26
       fcb $22
       fcb $70
       fcb $00
       fcb $69
       fcb $2C
       fcb $F0
       fcb $00
       fcb $E1
       fcb $61
       fcb $E0
       fcb $00
       fcb $26
       fcb $AF
       fcb $20
       fcb $00
       fcb $F8
       fcb $E1
       fcb $E0
       fcb $00
       fcb $78
       fcb $E9
       fcb $60
       fcb $00
       fcb $F1
       fcb $24
       fcb $40
       fcb $00
       fcb $69
       fcb $69
       fcb $60
       fcb $00
       fcb $69
       fcb $71
       fcb $60
       fcb $00
       fcb $00
       fcb $40
       fcb $40
       fcb $00
       fcb $00
       fcb $20
       fcb $24
       fcb $00
       fcb $24
       fcb $84
       fcb $20
       fcb $00
       fcb $0F
       fcb $0F
       fcb $00
       fcb $00
       fcb $42
       fcb $12
       fcb $40
       fcb $00
       fcb $69
       fcb $22
       fcb $02
       fcb $00
       fcb $69
       fcb $BB
       fcb $87
       fcb $00
       fcb $69
       fcb $F9
       fcb $90
       fcb $00
       fcb $E9
       fcb $E9
       fcb $E0
       fcb $00
       fcb $78
       fcb $88
       fcb $70
       fcb $00
       fcb $E9
       fcb $99
       fcb $E0
       fcb $00
       fcb $F8
       fcb $E8
       fcb $F0
       fcb $00
       fcb $F8
       fcb $E8
       fcb $80
       fcb $00
       fcb $78
       fcb $B9
       fcb $70
       fcb $00
       fcb $99
       fcb $F9
       fcb $90
       fcb $00
       fcb $E4
       fcb $44
       fcb $E0
       fcb $00
       fcb $F2
       fcb $2A
       fcb $40
       fcb $00
       fcb $9A
       fcb $CA
       fcb $90
       fcb $00
       fcb $88
       fcb $88
       fcb $F0
       fcb $00
       fcb $FD
       fcb $D9
       fcb $90
       fcb $00
       fcb $9D
       fcb $B9
       fcb $90
       fcb $00
       fcb $69
       fcb $99
       fcb $60
       fcb $00
       fcb $E9
       fcb $E8
       fcb $80
       fcb $00
       fcb $69
       fcb $9B
       fcb $70
       fcb $00
       fcb $E9
       fcb $EA
       fcb $90
       fcb $00
       fcb $78
       fcb $61
       fcb $E0
       fcb $00
       fcb $E4
       fcb $44
       fcb $40
       fcb $00
       fcb $99
       fcb $99
       fcb $60
       fcb $00
       fcb $99
       fcb $96
       fcb $60
       fcb $00
       fcb $99
       fcb $DD
       fcb $F0
       fcb $00
       fcb $99
       fcb $69
       fcb $90
       fcb $00
       fcb $99
       fcb $71
       fcb $E0
       fcb $00
       fcb $F1
       fcb $68
       fcb $F0
       fcb $00
       fcb $E8
       fcb $88
       fcb $E0
       fcb $00
       fcb $08
       fcb $42
       fcb $10
       fcb $00
       fcb $71
       fcb $11
       fcb $70
       fcb $00
       fcb $69
       fcb $00
       fcb $00
       fcb $00
       fcb $00
       fcb $00
       fcb $0F
       fcb $00
       fcb $22
       fcb $00
       fcb $00
       fcb $00
       fcb $07
       fcb $99
       fcb $70
       fcb $00
       fcb $8E
       fcb $99
       fcb $E0
       fcb $00
       fcb $07
       fcb $88
       fcb $70
       fcb $00
       fcb $17
       fcb $99
       fcb $70
       fcb $00
       fcb $07
       fcb $AC
       fcb $70
       fcb $00
       fcb $34
       fcb $F4
       fcb $40
       fcb $00
       fcb $06
       fcb $99
       fcb $71
       fcb $E0
       fcb $8E
       fcb $99
       fcb $90
       fcb $00
       fcb $40
       fcb $44
       fcb $40
       fcb $00
       fcb $20
       fcb $22
       fcb $22
       fcb $C0
       fcb $8A
       fcb $CA
       fcb $90
       fcb $00
       fcb $44
       fcb $44
       fcb $40
       fcb $00
       fcb $0E
       fcb $DD
       fcb $90
       fcb $00
       fcb $0E
       fcb $99
       fcb $90
       fcb $00
       fcb $06
       fcb $99
       fcb $60
       fcb $00
       fcb $0E
       fcb $99
       fcb $E8
       fcb $80
       fcb $07
       fcb $99
       fcb $71
       fcb $10
       fcb $07
       fcb $88
       fcb $80
       fcb $00
       fcb $07
       fcb $C3
       fcb $E0
       fcb $00
       fcb $4F
       fcb $44
       fcb $30
       fcb $00
       fcb $09
       fcb $99
       fcb $70
       fcb $00
       fcb $09
       fcb $96
       fcb $60
       fcb $00
       fcb $09
       fcb $DD
       fcb $60
       fcb $00
       fcb $09
       fcb $66
       fcb $90
       fcb $00
       fcb $09
       fcb $99
       fcb $71
       fcb $E0
       fcb $0F
       fcb $24
       fcb $F0
       fcb $00
       fcb $34
       fcb $C4
       fcb $30
       fcb $00
       fcb $44
       fcb $04
       fcb $40
       fcb $00
       fcb $C2
       fcb $32
       fcb $C0
       fcb $00
       fcb $05
       fcb $A0
       fcb $00
       fcb $00
       fcb $FF
       fcb $FF
       fcb $FF
       fcb $F0
L0820  fcb $30
       fcb $31
       fcb $32
       fcb $33
       fcb $34
       fcb $35
       fcb $36
       fcb $37
       fcb $38
       fcb $39
       fcb $3A
       fcb $3B
       fcb $2C
       fcb $2D
       fcb $2E
       fcb $2F
       fcb $40
       fcb $61
       fcb $62
       fcb $63
       fcb $64
       fcb $65
       fcb $66
       fcb $67
       fcb $68
       fcb $69
       fcb $6A
       fcb $6B
       fcb $6C
       fcb $6D
       fcb $6E
       fcb $6F
       fcb $70
       fcb $71
       fcb $72
       fcb $73
       fcb $74
       fcb $75
       fcb $76
       fcb $77
       fcb $78
       fcb $79
       fcb $7A
       fcb $0C
       fcb $0A
       fcb $08
       fcb $09
       fcb $20
       fcb $0D
       fcb $00
       fcb $05
L0853  fcb $30
       fcb $21
       fcb $22
       fcb $23
       fcb $24
       fcb $25
       fcb $26
       fcb $27
       fcb $28
       fcb $29
       fcb $2A
       fcb $2B
       fcb $3C
       fcb $3D
       fcb $3E
       fcb $3F
       fcb $7C
       fcb $41
       fcb $42
       fcb $43
       fcb $44
       fcb $45
       fcb $46
       fcb $47
       fcb $48
       fcb $49
       fcb $4A
       fcb $4B
       fcb $4C
       fcb $4D
       fcb $4E
       fcb $4F
       fcb $50
       fcb $51
       fcb $52
       fcb $53
       fcb $54
       fcb $55
       fcb $56
       fcb $57
       fcb $58
       fcb $59
       fcb $5A
       fcb $1C
       fcb $1A
       fcb $18
       fcb $19
       fcb $20
       fcb $0D
       fcb $00
       fcb $03
L0886  fcb $1F
       fcb $7C
       fcb $00
       fcb $7E
       fcb $00
       fcb $00
       fcb $00
       fcb $5E
       fcb $5B
       fcb $5D
       fcb $00
       fcb $00
       fcb $7B
       fcb $5F
       fcb $7D
       fcb $5C
       fcb $00
       fcb $01
       fcb $02
       fcb $03
       fcb $04
       fcb $05
       fcb $06
       fcb $07
       fcb $08
       fcb $09
       fcb $0A
       fcb $0B
       fcb $0C
       fcb $0D
       fcb $0E
       fcb $0F
       fcb $10
       fcb $11
       fcb $12
       fcb $13
       fcb $14
       fcb $15
       fcb $16
       fcb $17
       fcb $18
       fcb $19
       fcb $1A
       fcb $13
       fcb $12
       fcb $10
       fcb $11
       fcb $20
       fcb $0D
       fcb $00
       fcb $1B

         emod
eom      equ   *
