********************************************************************
* debug - 6809 debugger
*
* $Id$
*
* Ed.    Comments                                       Who YY/MM/DD
* ------------------------------------------------------------------
*   6    From Tandy OS-9 Level One VR 02.00.00

         nam   debug
         ttl   6809 debugger

* Disassembled 02/07/06 13:05:58 by Disasm v1.6 (C) 1988 by RML

         ifp1
         use   defsfile
         endc

tylg     set   Prgrm+Objct   
atrv     set   ReEnt+rev
rev      set   $01
edition  set   6

L0000    mod   eom,name,tylg,atrv,start,size

u0000    rmb   1
u0001    rmb   1
u0002    rmb   1
u0003    rmb   1
u0004    rmb   2
u0006    rmb   2
u0008    rmb   1
u0009    rmb   1
u000A    rmb   1
u000B    rmb   1
u000C    rmb   4
u0010    rmb   14
u001E    rmb   2
u0020    rmb   1
u0021    rmb   19
u0034    rmb   4
u0038    rmb   9
u0041    rmb   1
u0042    rmb   1
u0043    rmb   1
u0044    rmb   3
u0047    rmb   4
u004B    rmb   1
u004C    rmb   1
u004D    rmb   4
u0051    rmb   2
u0053    rmb   2
u0055    rmb   3
u0058    rmb   1
u0059    rmb   6
u005F    rmb   39
u0086    rmb   20
u009A    rmb   4
u009E    rmb   9
u00A7    rmb   18
u00B9    rmb   67
u00FC    rmb   260
size     equ   .

name     fcs   /debug/
         fcb   edition

L0013    bsr   L0021
         bra   L0019
L0017    bsr   L0027
L0019    pshs  a
         lda   #$20
         sta   ,x+
         puls  pc,a
L0021    exg   a,b
         bsr   L0027
         tfr   a,b
L0027    pshs  b
         andb  #$F0
         lsrb  
         lsrb  
         lsrb  
         lsrb  
         bsr   L0035
         puls  b
         andb  #$0F
L0035    cmpb  #$09
         bls   L003B
         addb  #$07
L003B    addb  #$30
         stb   ,x+
         rts   
L0040    pshs  u,y,b
         leau  <L0065,pcr
         ldy   #$0005
L0049    clr   ,s
L004B    subd  ,u
         bcs   L0053
         inc   ,s
         bra   L004B
L0053    addd  ,u++
         pshs  b
         ldb   $01,s
         addb  #$30
         stb   ,x+
         puls  b
         leay  -$01,y
         bne   L0049
         puls  pc,u,y,b

L0065    fcb   $27,$10,$03,$e8,$00,$64,$00,$0a,$00,$01

L006F    lbsr  L0127
         leax  $01,x
         cmpa  #'#
         beq   L00BA
         cmpa  #'%
         beq   L00E0
         cmpa  #'$
         beq   L0082
         leax  -$01,x
L0082    leas  -$04,s
         bsr   L00F7
L0086    bsr   L00FE
         bcc   L00A0
         cmpb  #'A
         lbcs  L0110
         cmpb  #'F
         bls   L009E
         cmpb  #'a
         bcs   L0110
         cmpb  #'f
         bhi   L0110
         subb  #$20
L009E    subb  #$37
L00A0    stb   ,s
         ldd   $02,s
         bita  #$F0
         bne   L0123
         lslb  
         rola  
         lslb  
         rola  
         lslb  
         rola  
         lslb  
         rola  
         addb  ,s
         adca  #$00
         std   $02,s
         inc   $01,s
         bra   L0086
L00BA    leas  -$04,s
         bsr   L00F7
L00BE    bsr   L00FE
         bcs   L0110
         stb   ,s
         ldd   $02,s
         lslb  
         rola  
         std   $02,s
         lslb  
         rola  
         lslb  
         rola  
         bcs   L0123
         addd  $02,s
         bcs   L0123
         addb  ,s
         adca  #$00
         bcs   L0123
         std   $02,s
         inc   $01,s
         bra   L00BE
L00E0    leas  -$04,s
         bsr   L00F7
L00E4    ldb   ,x+
         subb  #$30
         bcs   L0110
         lsrb  
         bne   L0110
         rol   $03,s
         rol   $02,s
         bcs   L0123
         inc   $01,s
         bra   L00E4
L00F7    clra  
         clrb  
         std   $02,s
         std   $04,s
         rts   
L00FE    ldb   ,x+
         cmpb  #'0
         bcs   L0108
         cmpb  #'9
         bls   L010B
L0108    orcc  #Carry
         rts   
L010B    subb  #'0
         andcc #^Carry
         rts   
L0110    leax  -$01,x
         tst   $01,s
         beq   L011C
         ldd   $02,s
         andcc #^Carry
         bra   L0120
L011C    orcc  #Zero
L011E    orcc  #Carry
L0120    leas  $04,s
         rts   
L0123    andcc #^Zero
         bra   L011E
L0127    lda   ,x+
         cmpa  #C$SPAC
         beq   L0127
         leax  -$01,x
         rts   
L0130    pshs  x,b,a
         lda   $03,s
         mul   
         pshs  b,a
         lda   $02,s
         ldb   $04,s
         mul   
         pshs  b,a
         lda   $04,s
         ldb   $07,s
         bsr   L0157
         lda   $05,s
         ldb   $06,s
         bsr   L0157
         andcc #^Carry
         ldd   $02,s
         ldx   ,s
         beq   L0154
         orcc  #Carry
L0154    leas  $08,s
         rts   
L0157    mul   
         addd  $03,s
         std   $03,s
         bcc   L0160
         inc   $02,s
L0160    rts   
L0161    pshs  y,x,b,a
         ldd   ,s
         bne   L016B
         orcc  #Carry
         bra   L018B
L016B    ldd   #$0010
         stb   $04,s
         clrb  
L0171    lsl   $03,s
         rol   $02,s
         rolb  
         rola  
         subd  ,s
         bmi   L017F
         inc   $03,s
         bra   L0181
L017F    addd  ,s
L0181    dec   $04,s
         bne   L0171
         tfr   d,x
         ldd   $02,s
         andcc #^Carry
L018B    leas  $06,s
         rts   
L018E    sta   ,x+
L0190    lda   ,y+
         bne   L018E
         rts   
L0195    pshs  u,y
         tfr   s,u
         bsr   L01A7
         andcc #^Carry
         puls  pc,u,y
L019F    tfr   u,s
         orcc  #Carry
         puls  pc,u,y
L01A5    leax  $01,x
L01A7    bsr   L01C9
         pshs  b,a
L01AB    bsr   L021D
         cmpa  #'-
         bne   L01B9
         bsr   L01C7
         nega  
         negb  
         sbca  #$00
         bra   L01BF
L01B9    cmpa  #$2B
         bne   L01C5
         bsr   L01C7
L01BF    addd  ,s
         std   ,s
         bra   L01AB
L01C5    puls  pc,b,a
L01C7    leax  $01,x
L01C9    bsr   L01FD
         pshs  b,a
L01CD    bsr   L021D
         cmpa  #'*
         bne   L01E2
         bsr   L01FB
         pshs  x
         ldx   $02,s
         lbsr  L0130
         bcc   L01F5
         ldb   #$02
         bra   L019F
L01E2    cmpa  #'/
         bne   L01C5
         bsr   L01FB
         pshs  x
         ldx   $02,s
         lbsr  L0161
         bcc   L01F5
         ldb   #$01
         bra   L019F
L01F5    puls  x
         std   ,s
         bra   L01CD
L01FB    leax  $01,x
L01FD    bsr   L0222
         pshs  b,a
L0201    bsr   L021D
         cmpa  #'&
         bne   L020F
         bsr   L0220
         andb  $01,s
         anda  ,s
         bra   L0219
L020F    cmpa  #'!
         bne   L01C5
         bsr   L0220
         orb   $01,s
         ora   ,s
L0219    std   ,s
         bra   L0201
L021D    lbra  L0127
L0220    leax  $01,x
L0222    bsr   L021D
         cmpa  #'^
         bne   L022E
         bsr   L0239
         comb  
         coma  
         bra   L0238
L022E    cmpa  #'-
         bne   L023B
         bsr   L0239
         nega  
         negb  
         sbca  #$00
L0238    rts   
L0239    leax  $01,x
L023B    bsr   L021D
         cmpa  #'(
         bne   L0250
         lbsr  L01A5
         pshs  b,a
         bsr   L021D
         cmpa  #')
         beq   L0282
         ldb   <u0004
         bra   L0265
L0250    cmpa  #'[
         bne   L026A
         lbsr  L01A5
         tfr   d,y
         ldd   ,y
         pshs  b,a
         bsr   L021D
         cmpa  #']
         beq   L0282
         ldb   #$05
L0265    leas  $02,s
L0267    lbra  L019F
L026A    cmpa  #'<
         bne   L0286
         lbsr  L01A5
         tfr   d,y
         clra  
         ldb   ,y
         pshs  b,a
         bsr   L021D
         cmpa  #'>
         beq   L0282
         ldb   #$06
         bra   L0265
L0282    leax  $01,x
         puls  pc,b,a
L0286    cmpa  #'.
         bne   L028F
         ldd   <u0000
         leax  $01,x
         rts   
L028F    cmpa  #''
         bne   L0297
         ldd   ,x++
         clra  
         rts   
L0297    cmpa  #'"
         bne   L02A0
         leax  $01,x
         ldd   ,x++
         rts   
L02A0    cmpa  #':
         bne   L02B4
         leax  $01,x
         bsr   L02C3
         bcs   L0267
         tsta  
         bmi   L02B1
         clra  
         ldb   ,y
         rts   
L02B1    ldd   ,y
L02B3    rts   
L02B4    lbsr  L006F
         bcc   L02B3
         beq   L02BF
         ldb   #$03
         bra   L0267
L02BF    ldb   #$00
         bra   L0267
L02C3    ldb   #$09
         pshs  b
         ldd   ,x
         cmpd  #$7370
         beq   L02D5
         cmpd  #$5350
         bne   L02E2
L02D5    leax  $02,x
         ldd   #$0002
         tfr   dp,a
         tfr   d,y
         lda   #$80
         bra   L0314
L02E2    leay  >L0322,pcr
L02E6    lda   ,y
         ldb   $01,y
         bne   L02F8
         cmpa  ,x
         beq   L0307
         adda  #$20
         cmpa  ,x
         beq   L0307
         bra   L0318
L02F8    cmpd  ,x
         beq   L0305
         addd  #$2020
         cmpd  ,x
         bne   L0318
L0305    leax  $01,x
L0307    leax  $01,x
         lda   $02,y
         tfr   a,b
         andb  #$0F
         ldy   <u0002
         leay  b,y
L0314    andcc #^Carry
         puls  pc,b
L0318    leay  $03,y
         dec   ,s
         bne   L02E6
         orcc  #Carry
         puls  pc,b

L0322    fcc   "CC"
         fcb   $00
         fcc   "DP"
         fcb   $03
         fcc   "PC"
         fcb   $8a
         fcc   "A"
         fcb   $00,$01
         fcc   "B"
         fcb   $00,$02
         fcc   "D"
         fcb   $00,$81
         fcc   "X"
         fcb   $00,$84
         fcc   "Y"
         fcb   $00,$86
         fcc   "U"
         fcb   $00,$88

start    leas  >size,u
         leas  -R$Size,s
         sts   <u0002
         sts   <u0004
         leay  >L0765,pcr
         sty   R$PC,s
         lda   #Entire
         sta   R$CC,s
         tfr   s,x		X = size-R$Size
         leax  >-$0145,x
         stx   <u0006
         leax  <-$50,x
         stx   <u0008
         leax  <-$24,x
         stx   <u000C
         clr   <u0000
         clr   <u0001
L036A    clr   ,x+
         cmpx  <u0006
         bcs   L036A
         leax  >L0652,pcr
         lda   #$01
         os9   F$SSWi   
         os9   F$Icpt   
         lbsr  L07E1
         ldx   <u0006
         leay  >L0766,pcr
         bsr   L03C2
         lbsr  L07E3
L038A    leay  >L077B,pcr
         lbsr  L07EF
         lbsr  L0807
         leay  >L07AD,pcr
         lda   ,x
         cmpa  #'a
         bcs   L03A2
         suba  #$20
         sta   ,x
L03A2    leay  $03,y
         lda   ,y
         beq   L03B8
         cmpa  ,x
         bne   L03A2
         leax  $01,x
         ldd   $01,y
         leau  >L0000,pcr
         jsr   d,u
         bra   L038A
L03B8    ldb   #$09
         bsr   L03BE
         bra   L038A
L03BE    os9   F$PErr   
         rts   
L03C2    lbra  L0190
L03C5    lda   ,x
         cmpa  #C$PERD
         bne   L03CF
         ldd   <u000A
         bra   L03DC
L03CF    cmpa  #C$CR
         bne   L03D7
L03D3    ldd   <u0000
         bra   L03DC
L03D7    lbsr  L0195
         bcs   L03BE
L03DC    ldx   <u0000
         stx   <u000A
         std   <u0000
         pshs  b,a
         bsr   L0415
         ldd   ,s
         lbsr  L0013
         puls  y
         ldb   ,y
         lbsr  L0027
         lbra  L07E3
L03F5    ldd   <u0000
         subd  #$0001
         bra   L03DC
L03FC    bsr   L043F
         bcs   L03BE
         ldx   <u0000
         stb   ,x
         cmpb  ,x
         beq   L040E
         ldb   #$0A
         bsr   L03BE
         bra   L03D3
L040E    ldd   <u0000
         addd  #$0001
         bra   L03DC
L0415    ldx   <u0006
         pshs  b,a
         leay  >L0780,pcr
         bsr   L03C2
         puls  pc,b,a
L0421    lbsr  L0195
         bcs   L03BE
         bsr   L0415
         pshs  b,a
         lda   #'$
         sta   ,x+
         lda   ,s
         lbsr  L0013
         lda   #'#
         sta   ,x+
         puls  b,a
         lbsr  L0040
         lbra  L07E3
L043F    lbsr  L0195
         bcs   L044B
         tsta  
         beq   L044B
         ldb   #$08
         orcc  #Carry
L044B    rts   
L044C    lbsr  L0512
         beq   L04AF
         lbsr  L02C3
         lbcs  L03BE
         pshs  y,a
         lbsr  L0512
         bne   L0475
         bsr   L0415
         puls  y,a
         tsta  
         bpl   L046D
         ldd   ,y
         lbsr  L0021
         bra   L0472
L046D    ldb   ,y
         lbsr  L0027
L0472    lbra  L07E3
L0475    lda   ,s+
         bpl   L0485
         lbsr  L0195
         puls  y
         lbcs  L054E
         std   ,y
         rts   
L0485    bsr   L043F
         puls  y
         lbcs  L054E
         stb   ,y
         rts   

L0490    fcc   "PC="
         fcb   $00
         fcc   "A="
         fcb   $00
         fcc   "B="
         fcb   $00
         fcc   "CC="
         fcb   $00
         fcc   "DP="
         fcb   $00
         fcc   "SP="
         fcb   $00
         fcc   "X="
         fcb   $00
         fcc   "Y="
         fcb   $00
         fcc   "U="
         fcb   $00

L04AF    pshs  u
         ldx   <u0006
         leay  <L0490,pcr
         ldu   <u0002
         lbsr  L03C2
         ldd   u000A,u
         bsr   L0505
         lbsr  L03C2
         ldb   u0001,u
         bsr   L050F
         lbsr  L03C2
         ldb   u0002,u
         bsr   L050F
         lbsr  L03C2
         ldb   ,u
         bsr   L050F
         lbsr  L03C2
         ldb   u0003,u
         bsr   L050F
         pshs  y
         lbsr  L07E3
         puls  y
         lbsr  L03C2
         tfr   u,d
         bsr   L0505
         lbsr  L03C2
         ldd   u0004,u
         bsr   L0505
         lbsr  L03C2
         ldd   u0006,u
         bsr   L0505
         lbsr  L03C2
         ldd   u0008,u
         bsr   L0505
         lbsr  L07E3
         puls  pc,u
         ldd   ,y++
L0505    lbra  L0013
L0508    ldd   ,y++
         lbra  L0021
         ldb   ,y+
L050F    lbra  L0017
L0512    lbsr  L0127
         cmpa  #$0D
         rts   
L0518    bsr   L0512
         bne   L0538
         lbsr  L0415
         ldy   <u000C
         ldb   #$0C
         pshs  b
L0526    ldd   ,y
         beq   L052D
         lbsr  L0013
L052D    leay  $03,y
         dec   ,s
         bne   L0526
         leas  $01,s
         lbra  L07E3
L0538    lbsr  L0195
         bcs   L054E
         pshs  b,a
         bsr   L0556
         beq   L0551
         ldd   #$0000
         bsr   L0556
         beq   L0551
         ldb   #$0B
         leas  $02,s
L054E    lbra  L03BE
L0551    puls  b,a
         std   ,y
         rts   
L0556    pshs  u
         tfr   d,u
         ldb   #$0C
         ldy   <u000C
L055F    cmpu  ,y
         beq   L056D
         leay  $03,y
         decb  
         bne   L055F
         ldb   <u000C
         andcc #^Zero
L056D    puls  pc,u
L056F    bsr   L0512
         beq   L0581
         lbsr  L0195
         bcs   L054E
         bsr   L0556
         bne   L054E
         clra  
         clrb  
         std   ,y
         rts   
L0581    ldy   <u000C
         ldb   #$24
L0586    clr   ,y+
         decb  
         bne   L0586
         rts   
L058C    bsr   L0512
         beq   L059A
         lbsr  L0195
         bcs   L054E
         ldy   <u0002
         std   $0A,y
L059A    ldy   <u000C
         ldb   #$0C
         ldx   <u0002
         ldx   $0A,x
L05A3    ldu   ,y
         beq   L05B3
         lda   ,u
         sta   $02,y
         cmpx  ,y
         beq   L05B3
         lda   #$3F
         sta   ,u
L05B3    leay  $03,y
         decb  
         bne   L05A3
         lds   <u0002
         rti   
L05BC    bsr   L0613
         bcs   L054E
         orb   #$07
         exg   d,u
         andb  #$F8
         pshs  u,b,a
         cmpd  $02,s
         bcc   L05D9
L05CD    ldy   ,s
         leay  -$01,y
         cmpy  $02,s
         leay  $01,y
         bcs   L05DB
L05D9    puls  pc,u,b,a
L05DB    ldx   <u0006
         tfr   y,d
         lbsr  L0013
         ldb   #$04
         pshs  b
L05E6    lbsr  L0508
         dec   ,s
         bne   L05E6
         lbsr  L0019
         ldb   #$08
         stb   ,s
         ldy   $01,s
L05F7    lda   ,y+
         cmpa  #$7E
         bhi   L0601
         cmpa  #$20
         bcc   L0603
L0601    lda   #$2E
L0603    sta   ,x+
         dec   ,s
         bne   L05F7
         leas  $01,s
         sty   ,s
         lbsr  L07E3
         bra   L05CD
L0613    lbsr  L0195
         bcs   L061D
         tfr   d,u
         lbsr  L0195
L061D    rts   
L061E    bsr   L0613
         lbcs  L03BE
         pshs  b,a
L0626    cmpu  ,s
         bls   L062D
         puls  pc,b,a
L062D    ldd   #$8008
         sta   ,u
L0632    cmpa  ,u
         bne   L063E
         lsra  
         lsr   ,u
         decb  
         bne   L0632
         bra   L064E
L063E    lbsr  L0415
         ldd   #$2D20
         std   ,x++
         tfr   u,d
         lbsr  L0021
         lbsr  L07E3
L064E    leau  u0001,u
         bra   L0626
L0652    clra  
         tfr   a,dp
         ldx   <u004B
         lda   $07,x
         tfr   a,dp
         sts   <u0002
         ldd   $0A,s
         subd  #$0001
         std   $0A,s
         lds   <u0004
         lbsr  L0556
         beq   L0672
         ldb   #$0D
         lbsr  L03BE
L0672    ldy   <u000C
         ldb   #$0C
L0677    ldx   ,y
         beq   L067F
         lda   $02,y
         sta   ,x
L067F    leay  $03,y
         decb  
         bne   L0677
         lbsr  L07E1
         lbsr  L0415
         leay  >L07A9,pcr
         lbsr  L03C2
         lbsr  L07E3
         lbsr  L04AF
         lbra  L038A
L069A    bsr   L06B0
         lbcs  L03BE
         ldx   <u0006
         tfr   u,d
         pshs  u
         lbsr  L03DC
         lbsr  L07E3
         puls  u
         bra   L06CC
L06B0    lbsr  L0127
         lda   #$00
         os9   F$Link   
         rts   
L06B9    bsr   L06B0
         lbcs  L03BE
         ldd   u000B,u
         addd  #$0200
         os9   F$Mem    
         bcc   L06D0
         lbsr  L03BE
L06CC    os9   F$UnLink 
         rts   
L06D0    os9   F$UnLink 
         pshs  u,y,x
L06D5    lda   ,x+
         cmpa  #$0D
         bne   L06D5
         clrb  
L06DC    lda   ,-x
         sta   ,-y
         incb  
         cmpx  ,s
         bhi   L06DC
         sty   -$08,y
         leay  -$0C,y
         sty   <u0002
         clra  
         std   $01,y
         puls  u,x,b,a
         stx   $06,y
         ldd   u0009,u
         leax  d,u
         stx   $0A,y
         tfr   cc,a
         ora   #$80
         sta   ,y
         tfr   dp,a
         adda  #$02
         clrb  
         std   $08,y
         sta   $03,y
         lbra  L04AF
L070C    lbsr  L0127
         clra  
         clrb  
         tfr   x,u
         tfr   d,y
L0715    leay  $01,y
         lda   ,x+
         cmpa  #C$CR
         bne   L0715
         clra  
         leax  <L072E,pcr
         os9   F$Fork   
         bcs   L0729
         os9   F$Wait   
L0729    lbcs  L03BE
         rts   

L072E    fcc   "shell"
         fcb   $00

L0734    clrb
         os9   F$Exit   
L0738    lbsr  L0613
         lbcs  L03BE
         pshs  u
         ldx   <u0000
         tsta  
         bne   L0750
L0746    cmpb  ,x+
         beq   L075C
         cmpx  ,s
         bne   L0746
         puls  pc,u
L0750    cmpd  ,x+
         beq   L075C
         cmps  ,s
         bne   L0750
         puls  pc,u
L075C    leax  -$01,x
         tfr   x,d
         leas  $02,s
         lbra  L03DC
L0765    fcc   "?"
L0766    fcc   "Interactive Debugger"
         fcb   $00
L077B    fcc   "DB: "
         fcb   $00
L0780    fcc   "    "
         fcb   $00
         fcc   " SP  CC  A  B DP  X    Y    U    PC"
         fcb   $00
L07A9    fcc   "BKPT"
L07AD    fcc   ": "
         fcb   $00
         fcc   /./
         fdb   L03C5
         fcc   /=/
         fdb   L03FC
         fcb   C$CR
         fdb   L040E
         fcb   C$SPAC
         fdb   L0421
         fcc   /-/
         fdb   L03F5
         fcc   /:/
         fdb   L044C
         fcc   /K/
         fdb   L056F
         fcc   /M/
         fdb   L05BC
         fcc   /C/
         fdb   L061E
         fcc   /B/
         fdb   L0518
         fcc   /G/
         fdb   L058C
         fcc   /L/
         fdb   L069A
         fcc   /E/
         fdb   L06B9
         fcc   /$/
         fdb   L070C
         fcc   /Q/
         fdb   L0734
         fcc   /S/
         fdb   L0738
         fcb   $00

L07E1    ldx   <u0006
L07E3    lda   #C$CR
         sta   ,x+
         ldx   <u0006
         ldy   #$0051
         bra   L07FF
L07EF    tfr   y,x
         tfr   y,u
         ldy   #$0000
L07F7    ldb   ,u+
         beq   L07FF
         leay  $01,y
         bra   L07F7
L07FF    lda   #$01
         os9   I$WritLn 
         ldx   <u0006
         rts   
L0807    ldx   <u0006
         ldy   #80
         clra  
         os9   I$ReadLn 
         ldx   <u0006
         rts   

         emod
eom      equ   *
         end
