         nam   Suser
         ttl   program module       

* Disassembled 2010/01/24 10:51:32 by Disasm v1.5 (C) 1988 by RML

         ifp1
         use   /dd/defs/defsfile
         endc
tylg     set   Prgrm+Objct   
atrv     set   ReEnt+rev
rev      set   $01
         mod   eom,name,tylg,atrv,start,size
u0000    rmb   1
u0001    rmb   1
u0002    rmb   2
u0004    rmb   2
u0006    rmb   2
u0008    rmb   1
u0009    rmb   1
u000A    rmb   1
u000B    rmb   2
u000D    rmb   4
u0011    rmb   15
u0020    rmb   20
u0034    rmb   31
u0053    rmb   17
u0064    rmb   132
u00E8    rmb   119
u015F    rmb   2
u0161    rmb   58
u019B    rmb   1
u019C    rmb   3
u019F    rmb   940
size     equ   .
name     equ   *
         fcs   /Suser/
         fcb   $01 
L0013    fcb   $A6 &
         fcb   $A0 
         fcb   $A7 '
         fcb   $C0 @
         fcb   $30 0
         fcb   $1F 
         fcb   $26 &
         fcb   $F8 x
         fcb   $39 9
start    equ   *
         pshs  y
         pshs  u
         clra  
         clrb  
L0022    sta   ,u+
         decb  
         bne   L0022
         ldx   ,s
         leau  ,x
         leax  >$01CB,x
         pshs  x
         leay  >L0F36,pcr
         ldx   ,y++
         beq   L003D
         bsr   L0013
         ldu   $02,s
L003D    leau  >u0001,u
         ldx   ,y++
         beq   L0048
         bsr   L0013
         clra  
L0048    cmpu  ,s
         beq   L0051
         sta   ,u+
         bra   L0048
L0051    ldu   $02,s
         ldd   ,y++
         beq   L005E
         leax  >L0000,pcr
         lbsr  L0161
L005E    ldd   ,y++
         beq   L0067
         leax  ,u
         lbsr  L0161
L0067    leas  $04,s
         puls  x
         stx   >u019F,u
         sty   >u015F,u
         ldd   #$0001
         std   >u019B,u
         leay  >u0161,u
         leax  ,s
         lda   ,x+
L0083    ldb   >u019C,u
         cmpb  #$1D
         beq   L00DF
L008B    cmpa  #$0D
         beq   L00DF
         cmpa  #$20
         beq   L0097
         cmpa  #$2C
         bne   L009B
L0097    lda   ,x+
         bra   L008B
L009B    cmpa  #$22
         beq   L00A3
         cmpa  #$27
         bne   L00C1
L00A3    stx   ,y++
         inc   >u019C,u
         pshs  a
L00AB    lda   ,x+
         cmpa  #$0D
         beq   L00B5
         cmpa  ,s
         bne   L00AB
L00B5    puls  b
         clr   -$01,x
         cmpa  #$0D
         beq   L00DF
         lda   ,x+
         bra   L0083
L00C1    leax  -$01,x
         stx   ,y++
         leax  $01,x
         inc   >u019C,u
L00CB    cmpa  #$0D
         beq   L00DB
         cmpa  #$20
         beq   L00DB
         cmpa  #$2C
         beq   L00DB
         lda   ,x+
         bra   L00CB
L00DB    clr   -$01,x
         bra   L0083
L00DF    leax  >u015F,u
         pshs  x
         ldd   >u019B,u
         pshs  b,a
         leay  ,u
         bsr   L00F9
         lbsr  L017B
         clr   ,-s
         clr   ,-s
         lbsr  L0F2A
L00F9    leax  >$01CB,y
         stx   >$01A9,y
         sts   >$019D,y
         sts   >$01AB,y
         ldd   #$FF82
L010E    leax  d,s
         cmpx  >$01AB,y
         bcc   L0120
         cmpx  >$01A9,y
         bcs   L013A
         stx   >$01AB,y
L0120    rts   
L0121    bpl   L014D
         bpl   L014F
         bra   L017A
         lsrb  
         fcb   $41 A
         coma  
         fcb   $4B K
         bra   L017C
         rorb  
         fcb   $45 E
         fcb   $52 R
         rora  
         inca  
         clra  
         asrb  
         bra   L0160
         bpl   L0162
         bpl   L0147
L013A    leax  <L0121,pcr
         ldb   #$CF
         pshs  b
         lda   #$02
         ldy   #$0064
L0147    os9   I$WritLn 
         clr   ,-s
         lbsr  L0F30
L014F    ldd   >$019D,y
         subd  >$01AB,y
         rts   
         ldd   >$01AB,y
         subd  >$01A9,y
L0160    rts   
L0161    pshs  x
         leax  d,y
         leax  d,x
         pshs  x
L0169    ldd   ,y++
         leax  d,u
         ldd   ,x
         addd  $02,s
         std   ,x
         cmpy  ,s
         bne   L0169
         leas  $04,s
L017A    rts   
L017B    pshs  u
         ldd   #$FEE4
         lbsr  L010E
         leas  >-$00CC,s
         clra  
         clrb  
         stb   ,s
         ldd   >$00D0,s
         cmpd  #$0001
         bne   L01A4
         clra  
         clrb  
         pshs  b,a
         leax  >L0274,pcr
         pshs  x
         lbsr  L0252
         leas  $04,s
L01A4    ldx   >$00D2,s
         ldd   $02,x
         pshs  b,a
         lbsr  L0B4F
         leas  $02,s
         std   >$00CA,s
         pshs  b,a
         lbsr  L0EF8
         leas  $02,s
         cmpd  #$FFFF
         bne   L01D3
         ldd   >$01AD,y
         pshs  b,a
         leax  >L0298,pcr
         pshs  x
         lbsr  L0252
         leas  $04,s
L01D3    ldd   #$0002
         bra   L0207
L01D8    ldd   >$00C8,s
         lslb  
         rola  
         ldx   >$00D2,s
         leax  d,x
         ldd   ,x
         pshs  b,a
         leax  $02,s
         pshs  x
         lbsr  L0AF1
         leas  $04,s
         leax  >L02C1,pcr
         pshs  x
         leax  $02,s
         pshs  x
         lbsr  L0AF1
         leas  $04,s
         ldd   >$00C8,s
         addd  #$0001
L0207    std   >$00C8,s
         ldd   >$00C8,s
         cmpd  >$00D0,s
         blt   L01D8
         leax  >L02C3,pcr
         pshs  x
         leax  $02,s
         pshs  x
         lbsr  L0AF1
         leas  $04,s
         ldd   #$0003
         pshs  b,a
         ldd   #$0001
         pshs  b,a
         ldd   #$0010
         pshs  b,a
         leax  $06,s
         pshs  x
         leax  $08,s
         pshs  x
         lbsr  L0AC8
         std   ,s
         leax  >L02C5,pcr
         pshs  x
         lbsr  L0E9D
         leas  $0C,s
         leas  >$00CC,s
         puls  pc,u
L0252    pshs  u
         ldd   #$FFB8
         lbsr  L010E
         ldd   $04,s
         pshs  b,a
         leax  >L02CC,pcr
         pshs  x
         lbsr  L02D0
         leas  $04,s
         ldd   $06,s
         pshs  b,a
         lbsr  L0F2A
         leas  $02,s
         puls  pc,u
L0274    fcb   $55 U
         com   >$6167
         eim   #$20,$09,s
         com   >$3A20
         comb  
         eim   #$73,>$6572
         bra   L02C1
         jmp   -$0B,s
         tst   $02,s
         eim   #$72,-$02,y
         bra   L02E9
         neg   >$726F
         asr   $0E,s
         oim   #$6D,$05,s
         tstb  
         neg   <u0053
         clr   -$0E,s
         aim   #$79,>$2C20
         rol   >$6F75
         bra   L0307
         oim   #$6E,$0E,s
         clr   -$0C,s
         bra   L030E
         lsl   $01,s
         jmp   $07,s
         eim   #$20,-$0C,s
         lsl   $05,s
         bra   L032B
         com   >$6572
         bra   L0329
         eim   #$6D,>$6265
         aim   #$00,>$2000
L02C3    tst   <u0000
L02C5    comb  
         lsl   $05,s
         inc   $0C,s
         tst   <u0000
L02CC    bcs   L0341
         tst   <u0000
L02D0    pshs  u
         leax  >$001B,y
         stx   >$01AF,y
         leax  $06,s
         pshs  x
         ldd   $06,s
         bra   L02F0
         pshs  u
         ldd   $04,s
         std   >$01AF,y
         leax  $08,s
         pshs  x
         ldd   $08,s
L02F0    pshs  b,a
         leax  >L07A8,pcr
         pshs  x
         bsr   L0322
         leas  $06,s
         puls  pc,u
         pshs  u
         ldd   $04,s
         std   >$01AF,y
         leax  $08,s
         pshs  x
         ldd   $08,s
         pshs  b,a
L030E    leax  >L07BB,pcr
         pshs  x
         bsr   L0322
         leas  $06,s
         clra  
         clrb  
         stb   [>$01AF,y]
         ldd   $04,s
         puls  pc,u
L0322    pshs  u
         ldu   $06,s
         leas  -$0B,s
         bra   L033A
L032A    ldb   $08,s
         lbeq  L056B
         ldb   $08,s
         sex   
         pshs  b,a
         jsr   [<$11,s]
         leas  $02,s
L033A    ldb   ,u+
         stb   $08,s
         cmpb  #$25
         bne   L032A
         ldb   ,u+
         stb   $08,s
         clra  
         clrb  
         std   $02,s
         std   $06,s
         ldb   $08,s
         cmpb  #$2D
         bne   L035F
         ldd   #$0001
         std   >$01C5,y
         ldb   ,u+
         stb   $08,s
         bra   L0365
L035F    clra  
         clrb  
         std   >$01C5,y
L0365    ldb   $08,s
         cmpb  #$30
         bne   L0370
         ldd   #$0030
         bra   L0373
L0370    ldd   #$0020
L0373    std   >$01C7,y
         bra   L0393
L0379    ldd   $06,s
         pshs  b,a
         ldd   #$000A
         lbsr  L0BC2
         pshs  b,a
         ldb   $0A,s
         sex   
         addd  #$FFD0
         addd  ,s++
         std   $06,s
         ldb   ,u+
         stb   $08,s
L0393    ldb   $08,s
         sex   
         leax  >$00DF,y
         leax  d,x
         ldb   ,x
         clra  
         andb  #$08
         bne   L0379
         ldb   $08,s
         cmpb  #$2E
         bne   L03DC
         ldd   #$0001
         std   $04,s
         bra   L03C6
L03B0    ldd   $02,s
         pshs  b,a
         ldd   #$000A
         lbsr  L0BC2
         pshs  b,a
         ldb   $0A,s
         sex   
         addd  #$FFD0
         addd  ,s++
         std   $02,s
L03C6    ldb   ,u+
         stb   $08,s
         ldb   $08,s
         sex   
         leax  >$00DF,y
         leax  d,x
         ldb   ,x
         clra  
         andb  #$08
         bne   L03B0
         bra   L03E0
L03DC    clra  
         clrb  
         std   $04,s
L03E0    ldb   $08,s
         sex   
         tfr   d,x
         lbra  L050E
L03E8    ldd   $06,s
         pshs  b,a
         ldx   <$15,s
         leax  $02,x
         stx   <$15,s
         ldd   -$02,x
         pshs  b,a
         lbsr  L056F
         bra   L0410
L03FD    ldd   $06,s
         pshs  b,a
         ldx   <$15,s
         leax  $02,x
         stx   <$15,s
         ldd   -$02,x
         pshs  b,a
         lbsr  L062C
L0410    std   ,s
         lbra  L04F4
L0415    ldd   $06,s
         pshs  b,a
         ldb   $0A,s
         sex   
         leax  >$00DF,y
         leax  d,x
         ldb   ,x
         clra  
         andb  #$02
         pshs  b,a
         ldx   <$17,s
         leax  $02,x
         stx   <$17,s
         ldd   -$02,x
         pshs  b,a
         lbsr  L0674
         lbra  L04F0
L043B    ldd   $06,s
         pshs  b,a
         ldx   <$15,s
         leax  $02,x
         stx   <$15,s
         ldd   -$02,x
         pshs  b,a
         leax  >$01B1,y
         pshs  x
         lbsr  L05B3
         lbra  L04F0
L0457    ldd   $04,s
         bne   L0460
         ldd   #$0006
         std   $02,s
L0460    ldd   $06,s
         pshs  b,a
         leax  <$15,s
         pshs  x
         ldd   $06,s
         pshs  b,a
         ldb   $0E,s
         sex   
         pshs  b,a
         lbsr  L0ABD
         leas  $06,s
         lbra  L04F2
L047A    ldx   <$13,s
         leax  $02,x
         stx   <$13,s
         ldd   -$02,x
         lbra  L0504
L0487    ldx   <$13,s
         leax  $02,x
         stx   <$13,s
         ldd   -$02,x
         std   $09,s
         ldd   $04,s
         beq   L04CF
         ldd   $09,s
         std   $04,s
         bra   L04A9
L049D    ldb   [<$09,s]
         beq   L04B5
         ldd   $09,s
         addd  #$0001
         std   $09,s
L04A9    ldd   $02,s
         addd  #$FFFF
         std   $02,s
         subd  #$FFFF
         bne   L049D
L04B5    ldd   $06,s
         pshs  b,a
         ldd   $0B,s
         subd  $06,s
         pshs  b,a
         ldd   $08,s
         pshs  b,a
         ldd   <$15,s
         pshs  b,a
         lbsr  L06DF
         leas  $08,s
         bra   L04FE
L04CF    ldd   $06,s
         pshs  b,a
         ldd   $0B,s
         bra   L04F2
L04D7    ldb   ,u+
         stb   $08,s
         bra   L04DF
         leas  -$0B,x
L04DF    ldd   $06,s
         pshs  b,a
         leax  <$15,s
         pshs  x
         ldb   $0C,s
         sex   
         pshs  b,a
         lbsr  L0A7F
L04F0    leas  $04,s
L04F2    pshs  b,a
L04F4    ldd   <$13,s
         pshs  b,a
         lbsr  L0741
         leas  $06,s
L04FE    lbra  L033A
L0501    ldb   $08,s
         sex   
L0504    pshs  b,a
         jsr   [<$11,s]
         leas  $02,s
         lbra  L033A
L050E    cmpx  #$0064
         lbeq  L03E8
         cmpx  #$006F
         lbeq  L03FD
         cmpx  #$0078
         lbeq  L0415
         cmpx  #$0058
         lbeq  L0415
         cmpx  #$0075
         lbeq  L043B
         cmpx  #$0066
         lbeq  L0457
         cmpx  #$0065
         lbeq  L0457
         cmpx  #$0067
         lbeq  L0457
         cmpx  #$0045
         lbeq  L0457
         cmpx  #$0047
         lbeq  L0457
         cmpx  #$0063
         lbeq  L047A
         cmpx  #$0073
         lbeq  L0487
         cmpx  #$006C
         lbeq  L04D7
         bra   L0501
L056B    leas  $0B,s
         puls  pc,u
L056F    pshs  u,b,a
         leax  >$01B1,y
         stx   ,s
         ldd   $06,s
         bge   L05A4
         ldd   $06,s
         nega  
         negb  
         sbca  #$00
         std   $06,s
         bge   L0599
         leax  >L07CD,pcr
         pshs  x
         leax  >$01B1,y
         pshs  x
         lbsr  L0AD9
         leas  $04,s
         lbra  L0670
L0599    ldd   #$002D
         ldx   ,s
         leax  $01,x
         stx   ,s
         stb   -$01,x
L05A4    ldd   $06,s
         pshs  b,a
         ldd   $02,s
         pshs  b,a
         bsr   L05B3
         leas  $04,s
         lbra  L066A
L05B3    pshs  u,y,x,b,a
         ldu   $0A,s
         clra  
         clrb  
         std   $02,s
         clra  
         clrb  
         std   ,s
         bra   L05D0
L05C1    ldd   ,s
         addd  #$0001
         std   ,s
         ldd   $0C,s
         subd  >$0001,y
         std   $0C,s
L05D0    ldd   $0C,s
         blt   L05C1
         leax  >$0001,y
         stx   $04,s
         bra   L0612
L05DC    ldd   ,s
         addd  #$0001
         std   ,s
L05E3    ldd   $0C,s
         subd  [<$04,s]
         std   $0C,s
         bge   L05DC
         ldd   $0C,s
         addd  [<$04,s]
         std   $0C,s
         ldd   ,s
         beq   L05FC
         ldd   #$0001
         std   $02,s
L05FC    ldd   $02,s
         beq   L0607
         ldd   ,s
         addd  #$0030
         stb   ,u+
L0607    clra  
         clrb  
         std   ,s
         ldd   $04,s
         addd  #$0002
         std   $04,s
L0612    ldd   $04,s
         cmpd  >$0009,y
         bne   L05E3
         ldd   $0C,s
         addd  #$0030
         stb   ,u+
         clra  
         clrb  
         stb   ,u
         ldd   $0A,s
         leas  $06,s
         puls  pc,u
L062C    pshs  u,b,a
         leax  >$01B1,y
         stx   ,s
         leau  >$01BB,y
L0638    ldd   $06,s
         clra  
         andb  #$07
         addd  #$0030
         stb   ,u+
         ldd   $06,s
         lsra  
         rorb  
         lsra  
         rorb  
         lsra  
         rorb  
         std   $06,s
         bne   L0638
         bra   L065A
L0650    ldb   ,u
         ldx   ,s
         leax  $01,x
         stx   ,s
         stb   -$01,x
L065A    leau  -u0001,u
         pshs  u
         leax  >$01BB,y
         cmpx  ,s++
         bls   L0650
         clra  
         clrb  
         stb   [,s]
L066A    leax  >$01B1,y
         tfr   x,d
L0670    leas  $02,s
         puls  pc,u
L0674    pshs  u,x,b,a
         leax  >$01B1,y
         stx   $02,s
         leau  >$01BB,y
L0680    ldd   $08,s
         clra  
         andb  #$0F
         std   ,s
         pshs  b,a
         ldd   $02,s
         cmpd  #$0009
         ble   L06A2
         ldd   $0C,s
         beq   L069A
         ldd   #$0041
         bra   L069D
L069A    ldd   #$0061
L069D    addd  #$FFF6
         bra   L06A5
L06A2    ldd   #$0030
L06A5    addd  ,s++
         stb   ,u+
         ldd   $08,s
         lsra  
         rorb  
         lsra  
         rorb  
         lsra  
         rorb  
         lsra  
         rorb  
         anda  #$0F
         std   $08,s
         bne   L0680
         bra   L06C5
L06BB    ldb   ,u
         ldx   $02,s
         leax  $01,x
         stx   $02,s
         stb   -$01,x
L06C5    leau  -u0001,u
         pshs  u
         leax  >$01BB,y
         cmpx  ,s++
         bls   L06BB
         clra  
         clrb  
         stb   [<$02,s]
         leax  >$01B1,y
         tfr   x,d
         lbra  L07B7
L06DF    pshs  u
         ldu   $06,s
         ldd   $0A,s
         subd  $08,s
         std   $0A,s
         ldd   >$01C5,y
         bne   L0714
         bra   L06FC
L06F1    ldd   >$01C7,y
         pshs  b,a
         jsr   [<$06,s]
         leas  $02,s
L06FC    ldd   $0A,s
         addd  #$FFFF
         std   $0A,s
         subd  #$FFFF
         bgt   L06F1
         bra   L0714
L070A    ldb   ,u+
         sex   
         pshs  b,a
         jsr   [<$06,s]
         leas  $02,s
L0714    ldd   $08,s
         addd  #$FFFF
         std   $08,s
         subd  #$FFFF
         bne   L070A
         ldd   >$01C5,y
         beq   L073F
         bra   L0733
L0728    ldd   >$01C7,y
         pshs  b,a
         jsr   [<$06,s]
         leas  $02,s
L0733    ldd   $0A,s
         addd  #$FFFF
         std   $0A,s
         subd  #$FFFF
         bgt   L0728
L073F    puls  pc,u
L0741    pshs  u
         ldu   $06,s
         ldd   $08,s
         pshs  b,a
         pshs  u
         lbsr  L0AC8
         leas  $02,s
         nega  
         negb  
         sbca  #$00
         addd  ,s++
         std   $08,s
         ldd   >$01C5,y
         bne   L0783
         bra   L076B
L0760    ldd   >$01C7,y
         pshs  b,a
         jsr   [<$06,s]
         leas  $02,s
L076B    ldd   $08,s
         addd  #$FFFF
         std   $08,s
         subd  #$FFFF
         bgt   L0760
         bra   L0783
L0779    ldb   ,u+
         sex   
         pshs  b,a
         jsr   [<$06,s]
         leas  $02,s
L0783    ldb   ,u
         bne   L0779
         ldd   >$01C5,y
         beq   L07A6
         bra   L079A
L078F    ldd   >$01C7,y
         pshs  b,a
         jsr   [<$06,s]
         leas  $02,s
L079A    ldd   $08,s
         addd  #$FFFF
         std   $08,s
         subd  #$FFFF
         bgt   L078F
L07A6    puls  pc,u
L07A8    pshs  u
         ldd   >$01AF,y
         pshs  b,a
         ldd   $06,s
         pshs  b,a
         lbsr  L07D4
L07B7    leas  $04,s
         puls  pc,u
L07BB    pshs  u
         ldd   $04,s
         ldx   >$01AF,y
         leax  $01,x
         stx   >$01AF,y
         stb   -$01,x
         puls  pc,u
L07CD    blt   L0802
         leas  -$09,y
         pshu  y,x,dp
         neg   <u0034
         nega  
         ldu   $06,s
         ldd   u0006,u
         anda  #$80
         andb  #$22
         cmpd  #$8002
         beq   L07F8
         ldd   u0006,u
         clra  
         andb  #$22
         cmpd  #$0002
         lbne  L0910
         pshs  u
         lbsr  L09EF
         leas  $02,s
L07F8    ldd   u0006,u
         clra  
         andb  #$04
         beq   L0834
         ldd   #$0001
L0802    pshs  b,a
         leax  $07,s
         pshs  x
         ldd   u0008,u
         pshs  b,a
         ldd   u0006,u
         clra  
         andb  #$40
         beq   L0819
         leax  >L0D79,pcr
         bra   L081D
L0819    leax  >L0D60,pcr
L081D    tfr   x,d
         tfr   d,x
         jsr   ,x
         leas  $06,s
         cmpd  #$FFFF
         bne   L0875
         ldd   u0006,u
         orb   #$20
         std   u0006,u
         lbra  L0910
L0834    ldd   u0006,u
         anda  #$01
         clrb  
         std   -$02,s
         bne   L0844
         pshs  u
         lbsr  L092D
         leas  $02,s
L0844    ldd   ,u
         addd  #$0001
         std   ,u
         subd  #$0001
         tfr   d,x
         ldd   $04,s
         stb   ,x
         ldd   ,u
         cmpd  u0004,u
         bcc   L086A
         ldd   u0006,u
         clra  
         andb  #$40
         beq   L0875
         ldd   $04,s
         cmpd  #$000D
         bne   L0875
L086A    pshs  u
         lbsr  L092D
         std   ,s++
         lbne  L0910
L0875    ldd   $04,s
         puls  pc,u
         pshs  u
         ldu   $04,s
         ldd   $06,s
         pshs  b,a
         pshs  u
         ldd   #$0008
         lbsr  L0C21
         pshs  b,a
         lbsr  L07D4
         leas  $04,s
         ldd   $06,s
         pshs  b,a
         pshs  u
         lbsr  L07D4
         lbra  L09E7
L089C    pshs  u,b,a
         leau  >$000E,y
         clra  
         clrb  
         std   ,s
         bra   L08B2
L08A8    tfr   u,d
         leau  u000D,u
         pshs  b,a
         bsr   L08C5
         leas  $02,s
L08B2    ldd   ,s
         addd  #$0001
         std   ,s
         subd  #$0001
         cmpd  #$0010
         blt   L08A8
         lbra  L0929
L08C5    pshs  u
         ldu   $04,s
         leas  -$02,s
         cmpu  #$0000
         beq   L08D5
         ldd   u0006,u
         bne   L08DB
L08D5    ldd   #$FFFF
         lbra  L0929
L08DB    ldd   u0006,u
         clra  
         andb  #$02
         beq   L08EA
         pshs  u
         bsr   L08FF
         leas  $02,s
         bra   L08EC
L08EA    clra  
         clrb  
L08EC    std   ,s
         ldd   u0008,u
         pshs  b,a
         lbsr  L0CC2
         leas  $02,s
         clra  
         clrb  
         std   u0006,u
         ldd   ,s
         bra   L0929
L08FF    pshs  u
         ldu   $04,s
         beq   L0910
         ldd   u0006,u
         clra  
         andb  #$22
         cmpd  #$0002
         beq   L0915
L0910    ldd   #$FFFF
         puls  pc,u
L0915    ldd   u0006,u
         anda  #$80
         clrb  
         std   -$02,s
         bne   L0925
         pshs  u
         lbsr  L09EF
         leas  $02,s
L0925    pshs  u
         bsr   L092D
L0929    leas  $02,s
         puls  pc,u
L092D    pshs  u
         ldu   $04,s
         leas  -$04,s
         ldd   u0006,u
         anda  #$01
         clrb  
         std   -$02,s
         bne   L095F
         ldd   ,u
         cmpd  u0004,u
         beq   L095F
         clra  
         clrb  
         pshs  b,a
         pshs  u
         lbsr  L09EB
         leas  $02,s
         ldd   $02,x
         pshs  b,a
         ldd   ,x
         pshs  b,a
         ldd   u0008,u
         pshs  b,a
         lbsr  L0D89
         leas  $08,s
L095F    ldd   ,u
         subd  u0002,u
         std   $02,s
         lbeq  L09D7
         ldd   u0006,u
         anda  #$01
         clrb  
         std   -$02,s
         lbeq  L09D7
         ldd   u0006,u
         clra  
         andb  #$40
         beq   L09AE
         ldd   u0002,u
         bra   L09A6
L097F    ldd   $02,s
         pshs  b,a
         ldd   ,u
         pshs  b,a
         ldd   u0008,u
         pshs  b,a
         lbsr  L0D79
         leas  $06,s
         std   ,s
         cmpd  #$FFFF
         bne   L099C
         leax  $04,s
         bra   L09C6
L099C    ldd   $02,s
         subd  ,s
         std   $02,s
         ldd   ,u
         addd  ,s
L09A6    std   ,u
         ldd   $02,s
         bne   L097F
         bra   L09D7
L09AE    ldd   $02,s
         pshs  b,a
         ldd   u0002,u
         pshs  b,a
         ldd   u0008,u
         pshs  b,a
         lbsr  L0D60
         leas  $06,s
         cmpd  $02,s
         beq   L09D7
         bra   L09C8
L09C6    leas  -$04,x
L09C8    ldd   u0006,u
         orb   #$20
         std   u0006,u
         ldd   u0004,u
         std   ,u
         ldd   #$FFFF
         bra   L09E7
L09D7    ldd   u0006,u
         ora   #$01
         std   u0006,u
         ldd   u0002,u
         std   ,u
         addd  u000B,u
         std   u0004,u
         clra  
         clrb  
L09E7    leas  $04,s
         puls  pc,u
L09EB    pshs  u
         puls  pc,u
L09EF    pshs  u
         ldu   $04,s
         ldd   u0006,u
         clra  
         andb  #$C0
         bne   L0A27
         leas  <-$20,s
         leax  ,s
         pshs  x
         ldd   u0008,u
         pshs  b,a
         clra  
         clrb  
         pshs  b,a
         lbsr  L0C44
         leas  $06,s
         ldd   u0006,u
         pshs  b,a
         ldb   $02,s
         bne   L0A1B
         ldd   #$0040
         bra   L0A1E
L0A1B    ldd   #$0080
L0A1E    ora   ,s+
         orb   ,s+
         std   u0006,u
         leas  <$20,s
L0A27    ldd   u0006,u
         ora   #$80
         std   u0006,u
         clra  
         andb  #$0C
         beq   L0A34
         puls  pc,u
L0A34    ldd   u000B,u
         bne   L0A49
         ldd   u0006,u
         clra  
         andb  #$40
         beq   L0A44
         ldd   #$0080
         bra   L0A47
L0A44    ldd   #$0100
L0A47    std   u000B,u
L0A49    ldd   u0002,u
         bne   L0A5E
         ldd   u000B,u
         pshs  b,a
         lbsr  L0E47
         leas  $02,s
         std   u0002,u
         cmpd  #$FFFF
         beq   L0A66
L0A5E    ldd   u0006,u
         orb   #$08
         std   u0006,u
         bra   L0A75
L0A66    ldd   u0006,u
         orb   #$04
         std   u0006,u
         leax  u000A,u
         stx   u0002,u
         ldd   #$0001
         std   u000B,u
L0A75    ldd   u0002,u
         addd  u000B,u
         std   u0004,u
         std   ,u
         puls  pc,u
L0A7F    pshs  u
         ldb   $05,s
         sex   
         tfr   d,x
         bra   L0AA5
L0A88    ldd   [<$06,s]
         addd  #$0004
         std   [<$06,s]
         leax  >L0ABC,pcr
         bra   L0AA1
L0A97    ldb   $05,s
         stb   >$000C,y
         leax  >$000B,y
L0AA1    tfr   x,d
         puls  pc,u
L0AA5    cmpx  #$0064
         beq   L0A88
         cmpx  #$006F
         lbeq  L0A88
         cmpx  #$0078
         lbeq  L0A88
         bra   L0A97
         puls  pc,u
L0ABC    neg   <u0034
         nega  
         leax  >L0AC7,pcr
         tfr   x,d
         puls  pc,u
L0AC7    neg   <u0034
         nega  
         ldu   $04,s
L0ACC    ldb   ,u+
         bne   L0ACC
         tfr   u,d
         subd  $04,s
         addd  #$FFFF
         puls  pc,u
L0AD9    pshs  u
         ldu   $06,s
         leas  -$02,s
         ldd   $06,s
         std   ,s
L0AE3    ldb   ,u+
         ldx   ,s
         leax  $01,x
         stx   ,s
         stb   -$01,x
         bne   L0AE3
         bra   L0B18
L0AF1    pshs  u
         ldu   $06,s
         leas  -$02,s
         ldd   $06,s
         std   ,s
L0AFB    ldx   ,s
         leax  $01,x
         stx   ,s
         ldb   -$01,x
         bne   L0AFB
         ldd   ,s
         addd  #$FFFF
         std   ,s
L0B0C    ldb   ,u+
         ldx   ,s
         leax  $01,x
         stx   ,s
         stb   -$01,x
         bne   L0B0C
L0B18    ldd   $06,s
         leas  $02,s
         puls  pc,u
         pshs  u
         ldu   $04,s
         bra   L0B34
L0B24    ldx   $06,s
         leax  $01,x
         stx   $06,s
         ldb   -$01,x
         bne   L0B32
         clra  
         clrb  
         puls  pc,u
L0B32    leau  u0001,u
L0B34    ldb   ,u
         sex   
         pshs  b,a
         ldb   [<$08,s]
         sex   
         cmpd  ,s++
         beq   L0B24
         ldb   [<$06,s]
         sex   
         pshs  b,a
         ldb   ,u
         sex   
         subd  ,s++
         puls  pc,u
L0B4F    pshs  u
         ldu   $04,s
         leas  -$05,s
         clra  
         clrb  
         std   $01,s
L0B59    ldb   ,u+
         stb   ,s
         cmpb  #$20
         beq   L0B59
         ldb   ,s
         cmpb  #$09
         lbeq  L0B59
         ldb   ,s
         cmpb  #$2D
         bne   L0B74
         ldd   #$0001
         bra   L0B76
L0B74    clra  
         clrb  
L0B76    std   $03,s
         ldb   ,s
         cmpb  #$2D
         beq   L0B9C
         ldb   ,s
         cmpb  #$2B
         bne   L0BA0
         bra   L0B9C
L0B86    ldd   $01,s
         pshs  b,a
         ldd   #$000A
         lbsr  L0BC2
         pshs  b,a
         ldb   $02,s
         sex   
         addd  ,s++
         addd  #$FFD0
         std   $01,s
L0B9C    ldb   ,u+
         stb   ,s
L0BA0    ldb   ,s
         sex   
         leax  >$00DF,y
         leax  d,x
         ldb   ,x
         clra  
         andb  #$08
         bne   L0B86
         ldd   $03,s
         beq   L0BBC
         ldd   $01,s
         nega  
         negb  
         sbca  #$00
         bra   L0BBE
L0BBC    ldd   $01,s
L0BBE    leas  $05,s
         puls  pc,u
L0BC2    tsta  
         bne   L0BD7
         tst   $02,s
         bne   L0BD7
         lda   $03,s
         mul   
         ldx   ,s
         stx   $02,s
         ldx   #$0000
         std   ,s
         puls  pc,b,a
L0BD7    pshs  b,a
         ldd   #$0000
         pshs  b,a
         pshs  b,a
         lda   $05,s
         ldb   $09,s
         mul   
         std   $02,s
         lda   $05,s
         ldb   $08,s
         mul   
         addd  $01,s
         std   $01,s
         bcc   L0BF4
         inc   ,s
L0BF4    lda   $04,s
         ldb   $09,s
         mul   
         addd  $01,s
         std   $01,s
         bcc   L0C01
         inc   ,s
L0C01    lda   $04,s
         ldb   $08,s
         mul   
         addd  ,s
         std   ,s
         ldx   $06,s
         stx   $08,s
         ldx   ,s
         ldd   $02,s
         leas  $08,s
         rts   
         tstb  
         beq   L0C2B
L0C18    asr   $02,s
         ror   $03,s
         decb  
         bne   L0C18
         bra   L0C2B
L0C21    tstb  
         beq   L0C2B
L0C24    lsr   $02,s
         ror   $03,s
         decb  
         bne   L0C24
L0C2B    ldd   $02,s
         pshs  b,a
         ldd   $02,s
         std   $04,s
         ldd   ,s
         leas  $04,s
         rts   
         tstb  
         beq   L0C2B
L0C3B    lsl   $03,s
         rol   $02,s
         decb  
         bne   L0C3B
         bra   L0C2B
L0C44    lda   $05,s
         ldb   $03,s
         beq   L0C77
         cmpb  #$01
         beq   L0C79
         cmpb  #$06
         beq   L0C79
         cmpb  #$02
         beq   L0C5F
         cmpb  #$05
         beq   L0C5F
         ldb   #$D0
         lbra  L0F1C
L0C5F    pshs  u
         os9   I$GetStt 
         bcc   L0C6B
         puls  u
         lbra  L0F1C
L0C6B    stx   [<$08,s]
         ldx   $08,s
         stu   $02,x
         puls  u
         clra  
         clrb  
         rts   
L0C77    ldx   $06,s
L0C79    os9   I$GetStt 
         lbra  L0F25
         lda   $05,s
         ldb   $03,s
         beq   L0C8E
         cmpb  #$02
         beq   L0C96
         ldb   #$D0
         lbra  L0F1C
L0C8E    ldx   $06,s
         os9   I$SetStt 
         lbra  L0F25
L0C96    pshs  u
         ldx   $08,s
         ldu   $0A,s
         os9   I$SetStt 
         puls  u
         lbra  L0F25
         ldx   $02,s
         lda   $05,s
         os9   I$Open   
         bcs   L0CB0
         os9   I$Close  
L0CB0    lbra  L0F25
         ldx   $02,s
         lda   $05,s
         os9   I$Open   
         lbcs  L0F1C
         tfr   a,b
         clra  
         rts   
L0CC2    lda   $03,s
         os9   I$Close  
         lbra  L0F25
         ldx   $02,s
         ldb   $05,s
         os9   I$MakDir 
         lbra  L0F25
         ldx   $02,s
         lda   $05,s
         tfr   a,b
         andb  #$24
         orb   #$0B
         os9   I$Create 
         bcs   L0CE7
L0CE3    tfr   a,b
         clra  
         rts   
L0CE7    cmpb  #$DA
         lbne  L0F1C
         lda   $05,s
         bita  #$80
         lbne  L0F1C
         anda  #$07
         ldx   $02,s
         os9   I$Open   
         lbcs  L0F1C
         pshs  u,a
         ldx   #$0000
         leau  ,x
         ldb   #$02
         os9   I$SetStt 
         puls  u,a
         bcc   L0CE3
         pshs  b
         os9   I$Close  
         puls  b
         lbra  L0F1C
         ldx   $02,s
         os9   I$Delete 
         lbra  L0F25
         lda   $03,s
         os9   I$Dup    
         lbcs  L0F1C
         tfr   a,b
         clra  
         rts   
         pshs  y
         ldx   $06,s
         lda   $05,s
         ldy   $08,s
         pshs  y
         os9   I$Read   
L0D3D    bcc   L0D4C
         cmpb  #$D3
         bne   L0D47
         clra  
         clrb  
         puls  pc,y,x
L0D47    puls  y,x
         lbra  L0F1C
L0D4C    tfr   y,d
         puls  pc,y,x
         pshs  y
         lda   $05,s
         ldx   $06,s
         ldy   $08,s
         pshs  y
         os9   I$ReadLn 
         bra   L0D3D
L0D60    pshs  y
         ldy   $08,s
         beq   L0D75
         lda   $05,s
         ldx   $06,s
         os9   I$Write  
L0D6E    bcc   L0D75
         puls  y
         lbra  L0F1C
L0D75    tfr   y,d
         puls  pc,y
L0D79    pshs  y
         ldy   $08,s
         beq   L0D75
         lda   $05,s
         ldx   $06,s
         os9   I$WritLn 
         bra   L0D6E
L0D89    pshs  u
         ldd   $0A,s
         bne   L0D97
         ldu   #$0000
         ldx   #$0000
         bra   L0DCB
L0D97    cmpd  #$0001
         beq   L0DC2
         cmpd  #$0002
         beq   L0DB7
         ldb   #$F7
L0DA5    clra  
         std   >$01AD,y
         ldd   #$FFFF
         leax  >$01A1,y
         std   ,x
         std   $02,x
         puls  pc,u
L0DB7    lda   $05,s
         ldb   #$02
         os9   I$GetStt 
         bcs   L0DA5
         bra   L0DCB
L0DC2    lda   $05,s
         ldb   #$05
         os9   I$GetStt 
         bcs   L0DA5
L0DCB    tfr   u,d
         addd  $08,s
         std   >$01A3,y
         tfr   d,u
         tfr   x,d
         adcb  $07,s
         adca  $06,s
         bmi   L0DA5
         tfr   d,x
         std   >$01A1,y
         lda   $05,s
         os9   I$Seek   
         bcs   L0DA5
         leax  >$01A1,y
         puls  pc,u
         ldd   >$019F,y
         pshs  b,a
         ldd   $04,s
         cmpd  >$01C9,y
         bcs   L0E24
         addd  >$019F,y
         pshs  y
         subd  ,s
         os9   F$Mem    
         tfr   y,d
         puls  y
         bcc   L0E16
         ldd   #$FFFF
         leas  $02,s
         rts   
L0E16    std   >$019F,y
         addd  >$01C9,y
         subd  ,s
         std   >$01C9,y
L0E24    leas  $02,s
         ldd   >$01C9,y
         pshs  b,a
         subd  $04,s
         std   >$01C9,y
         ldd   >$019F,y
         subd  ,s++
         pshs  b,a
         clra  
         ldx   ,s
L0E3D    sta   ,x+
         cmpx  >$019F,y
         bcs   L0E3D
         puls  pc,b,a
L0E47    ldd   $02,s
         addd  >$01A9,y
         bcs   L0E70
         cmpd  >$01AB,y
         bcc   L0E70
         pshs  b,a
         ldx   >$01A9,y
         clra  
L0E5D    cmpx  ,s
         bcc   L0E65
         sta   ,x+
         bra   L0E5D
L0E65    ldd   >$01A9,y
         puls  x
         stx   >$01A9,y
         rts   
L0E70    ldd   #$FFFF
         rts   
         lda   $03,s
         ldb   $05,s
         os9   F$Send   
         lbra  L0F25
         clra  
         clrb  
         os9   F$Wait   
         lbcs  L0F1C
         ldx   $02,s
         beq   L0E8F
         stb   $01,x
         clr   ,x
L0E8F    tfr   a,b
         clra  
         rts   
         lda   $03,s
         ldb   $05,s
         os9   F$SPrior 
         lbra  L0F25
L0E9D    leau  ,s
         leas  >$00FF,y
         ldx   u0002,u
         ldy   u0004,u
         lda   u0009,u
         lsla  
         lsla  
         lsla  
         lsla  
         ora   u000B,u
         ldb   u000D,u
         ldu   u0006,u
         os9   F$Chain  
         os9   F$Exit   
         pshs  u,y
         ldx   $06,s
         ldy   $08,s
         ldu   $0A,s
         lda   $0D,s
         ora   $0F,s
         ldb   <$11,s
         os9   F$Fork   
         puls  u,y
         lbcs  L0F1C
         tfr   a,b
         clra  
         rts   
         pshs  y
         os9   F$ID     
         puls  y
         bcc   L0EE4
         lbcs  L0F1C
L0EE4    tfr   a,b
         clra  
         rts   
L0EE8    pshs  y
         os9   F$ID     
         bcc   L0EF4
L0EEF    puls  y
         lbra  L0F1C
L0EF4    tfr   y,d
         puls  pc,y
L0EF8    pshs  y
         bsr   L0EE8
         std   -$02,s
         beq   L0F04
         ldb   #$D6
         bra   L0EEF
L0F04    ldy   $04,s
         os9   F$SUser  
         bcc   L0F18
         cmpb  #$D0
         bne   L0EEF
         tfr   y,d
         ldy   >$004B
         std   $09,y
L0F18    clra  
         clrb  
         puls  pc,y
L0F1C    clra  
         std   >$01AD,y
         ldd   #$FFFF
         rts   
L0F25    bcs   L0F1C
         clra  
         clrb  
         rts   
L0F2A    lbsr  L0F35
         lbsr  L089C
L0F30    ldd   $02,s
         os9   F$Exit   
L0F35    rts   
L0F36    neg   <u0001
         neg   <u0001
         fcb   $5E ^
         beq   L0F4D
         com   <u00E8
         neg   <u0064
         neg   <u000A
         neg   <u0009
         inc   -$08,s
         neg   <u0000
         neg   <u0000
         neg   <u0000
L0F4D    neg   <u0000
         oim   #$00,<u0000
         neg   <u0000
         neg   <u0000
         neg   <u0000
         neg   <u0000
         neg   <u0000
         aim   #$00,<u0001
         neg   <u0000
         neg   <u0000
         neg   <u0000
         neg   <u0000
         neg   <u0000
         fcb   $42 B
         neg   <u0002
         neg   <u0000
         neg   <u0000
         neg   <u0000
         neg   <u0000
         neg   <u0000
         neg   <u0000
         neg   <u0000
         neg   <u0000
         neg   <u0000
         neg   <u0000
         neg   <u0000
         neg   <u0000
         neg   <u0000
         neg   <u0000
         neg   <u0000
         neg   <u0000
         neg   <u0000
         neg   <u0000
         neg   <u0000
         neg   <u0000
         neg   <u0000
         neg   <u0000
         neg   <u0000
         neg   <u0000
         neg   <u0000
         neg   <u0000
         neg   <u0000
         neg   <u0000
         neg   <u0000
         neg   <u0000
         neg   <u0000
         neg   <u0000
         neg   <u0000
         neg   <u0000
         neg   <u0000
         neg   <u0000
         neg   <u0000
         neg   <u0000
         neg   <u0000
         neg   <u0000
         neg   <u0000
         neg   <u0000
         neg   <u0000
         neg   <u0000
         neg   <u0000
         neg   <u0000
         neg   <u0000
         neg   <u0000
         neg   <u0000
         neg   <u0000
         neg   <u0000
         neg   <u0000
         neg   <u0000
         neg   <u0000
         neg   <u0000
         neg   <u0000
         neg   <u0000
         neg   <u0000
         neg   <u0000
         neg   <u0000
         neg   <u0000
         neg   <u0000
         neg   <u0000
         neg   <u0000
         neg   <u0000
         neg   <u0000
         neg   <u0000
         neg   <u0000
         neg   <u0000
         neg   <u0000
         neg   <u0000
         neg   <u0000
         neg   <u0000
         neg   <u0000
         neg   <u0000
         neg   <u0000
         neg   <u0000
         neg   <u0000
         neg   <u0000
         neg   <u0000
         neg   <u0000
         neg   <u0000
         neg   <u0000
         neg   <u0000
         neg   <u0000
         neg   <u0000
         neg   <u0001
         oim   #$01,<u0001
         oim   #$01,<u0001
         oim   #$01,<u0011
         fcb   $11 
         oim   #$11,<u0011
         oim   #$01,<u0001
         oim   #$01,<u0001
         oim   #$01,<u0001
         oim   #$01,<u0001
         oim   #$01,<u0001
         oim   #$01,<u0001
         leax  $00,y
         bra   L105D
         bra   L105F
         bra   L1061
         bra   L1063
         bra   L1065
         bra   L1067
         bra   L1069
         lsla  
         lsla  
         lsla  
         lsla  
         lsla  
         lsla  
         lsla  
         lsla  
         lsla  
         lsla  
         bra   L1075
         bra   L1077
         bra   L1079
         bra   L109D
         fcb   $42 B
         fcb   $42 B
L105D    fcb   $42 B
         fcb   $42 B
L105F    fcb   $42 B
         aim   #$02,<u0002
L1063    aim   #$02,<u0002
         aim   #$02,<u0002
L1069    aim   #$02,<u0002
         aim   #$02,<u0002
         aim   #$02,<u0002
         aim   #$02,<u0020
L1075    bra   L1097
L1077    bra   L1099
L1079    bra   L10BF
         lsra  
         lsra  
         lsra  
         lsra  
         lsra  
         lsr   <u0004
         lsr   <u0004
         lsr   <u0004
         lsr   <u0004
         lsr   <u0004
         lsr   <u0004
         lsr   <u0004
         lsr   <u0004
         lsr   <u0004
         lsr   <u0004
         bra   L10B6
         bra   L10B8
         oim   #$00,<u0000
         neg   <u0001
L109D    neg   <u0009
         comb  
         eim   #$73,>$6572
         fcb   $00 
         emod
eom      equ   *
         end
