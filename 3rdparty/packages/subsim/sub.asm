********************************************************************
* SUB - Sub Battle
*
* $Id$
*
* Ed.    Comments                                       Who YY/MM/DD
* ------------------------------------------------------------------
* 0      Disassembly of original distribution           PWZ 03/03/28
*        

* Disassembly by Os9disasm of sub

      nam sub
      ttl program module

      ifp1
      use defsfile
      endc

* I/O path definitions
StdIn    equ   0
StdOut   equ   1
StdErr   equ   2



*  defines for 5 bit zero offset instructions
Zldb_u   equ  $E640
Zadda_u  equ  $AB40
Zsta_u   equ  $A740
Zlda_x   equ  $A600
Zlda_u   equ  $A640
Zsta_x   equ  $A700
Zclr_u   equ  $6F40
Ztst_x   equ  $6D00

* class X external label equates

X0102 equ $0102
X0103 equ $0103
X0105 equ $0105
X0107 equ $0107
X0109 equ $0109
X010B equ $010B
X010C equ $010C
X010E equ $010E
X0110 equ $0110
X0111 equ $0111
X0112 equ $0112
X0114 equ $0114
X011A equ $011A
X011B equ $011B
X011E equ $011E
X0120 equ $0120
X0122 equ $0122
X0124 equ $0124
X0125 equ $0125
X028F equ $028F
X0290 equ $0290
X0291 equ $0291
X0292 equ $0292
X0294 equ $0294
X0295 equ $0295
X0296 equ $0296
X0297 equ $0297
X0298 equ $0298
X0299 equ $0299
X029C equ $029C
X029D equ $029D
X029E equ $029E
X02A0 equ $02A0
X02A2 equ $02A2
X02A4 equ $02A4
X0355 equ $0355
X0356 equ $0356
X0359 equ $0359
X035F equ $035F
X04F7 equ $04F7
X04F8 equ $04F8
X04F9 equ $04F9
X04FA equ $04FA
X04FB equ $04FB
X04FE equ $04FE
X04FF equ $04FF
X0500 equ $0500
X05CE equ $05CE
X1D3F equ $1D3F
X1D43 equ $1D43
X1D6D equ $1D6D
X1D7B equ $1D7B
X1D87 equ $1D87
X1D89 equ $1D89
X1D8B equ $1D8B
X1D8D equ $1D8D
X1DA5 equ $1DA5
X1DA7 equ $1DA7
X1DB9 equ $1DB9
X1DBF equ $1DBF
X1DC9 equ $1DC9
X1DDA equ $1DDA
X1DDB equ $1DDB
X1DDC equ $1DDC
X1DEF equ $1DEF
X1DF0 equ $1DF0
X1DF2 equ $1DF2
X1DF3 equ $1DF3
X1DF5 equ $1DF5
X1DF6 equ $1DF6
X1DF7 equ $1DF7
X1DF9 equ $1DF9
X1DFA equ $1DFA
X1DFC equ $1DFC
X1DFD equ $1DFD
X1DFF equ $1DFF
X1E00 equ $1E00
X1E02 equ $1E02
X1E0D equ $1E0D
X1E0E equ $1E0E
X1E10 equ $1E10
X1E11 equ $1E11
X1E13 equ $1E13
X1E16 equ $1E16
X1E17 equ $1E17
X1E19 equ $1E19
X1E1A equ $1E1A
X1E1B equ $1E1B
X1E1C equ $1E1C
X1E1D equ $1E1D
X1E1E equ $1E1E
X1E1F equ $1E1F
X1E20 equ $1E20
X1E22 equ $1E22
X1E23 equ $1E23
X4265 equ $4265
X4C75 equ $4C75
X4C76 equ $4C76
X4C77 equ $4C77
X4C80 equ $4C80
X4C81 equ $4C81
X4C82 equ $4C82
X4C84 equ $4C84
X4C85 equ $4C85
X4C87 equ $4C87
X4C88 equ $4C88
X4CA0 equ $4CA0
X4CA1 equ $4CA1
X4CA2 equ $4CA2
X4CA3 equ $4CA3
X4CB4 equ $4CB4
X4CBD equ $4CBD
X4CC2 equ $4CC2
X4CCA equ $4CCA
X4CCC equ $4CCC
X4CCD equ $4CCD
X4CD0 equ $4CD0
X4CD1 equ $4CD1
X4CD2 equ $4CD2
X4CD3 equ $4CD3
X4CD4 equ $4CD4
X4CD5 equ $4CD5
X4CD9 equ $4CD9
X4CDA equ $4CDA
X4CDF equ $4CDF
X4CE1 equ $4CE1
X4CE3 equ $4CE3
X4CEE equ $4CEE
X4CEF equ $4CEF
X4CF1 equ $4CF1
X4CF2 equ $4CF2
X4CF3 equ $4CF3
X4CF7 equ $4CF7
X4CFA equ $4CFA
X4CFB equ $4CFB
X4CFF equ $4CFF
X4D00 equ $4D00
X4D0F equ $4D0F
X4D10 equ $4D10
X4D11 equ $4D11
X4D14 equ $4D14
X4D15 equ $4D15
X4D16 equ $4D16
X4D17 equ $4D17
X4D19 equ $4D19
X4D1B equ $4D1B
X4D1D equ $4D1D
X4D1F equ $4D1F
X4D21 equ $4D21
X4D25 equ $4D25
X4D26 equ $4D26
X4D27 equ $4D27
X4D28 equ $4D28
X4D29 equ $4D29
X4D2A equ $4D2A
X4D2B equ $4D2B
X4D2C equ $4D2C
X4D30 equ $4D30
X4D3A equ $4D3A
X71C9 equ $71C9
X71CB equ $71CB
X7228 equ $7228
X723C equ $723C
X72C3 equ $72C3
X72F3 equ $72F3
X7304 equ $7304
X735B equ $735B
X7477 equ $7477
X74CC equ $74CC
X74D9 equ $74D9
X7556 equ $7556
X7604 equ $7604
X7648 equ $7648
X765F equ $765F
X7691 equ $7691
X76A4 equ $76A4
X76B9 equ $76B9
X76F7 equ $76F7
X7718 equ $7718
X7720 equ $7720
X7843 equ $7843
X7866 equ $7866
X7889 equ $7889
X7A23 equ $7A23
X7A3A equ $7A3A
X7A68 equ $7A68
X7A89 equ $7A89
X7AA7 equ $7AA7
X7D56 equ $7D56
X7D75 equ $7D75
X7DB4 equ $7DB4

     
tylg  set   Prgrm+Objct   
atrv  set   ReEnt+rev
rev   set   $01

  
      mod   eom,name,tylg,atrv,start,size



* OS9 data area definitions

      org 0

L0000 rmb 1
D0001 rmb 2
D0003 rmb 1
D0004 rmb 1
D0005 rmb 1
D0006 rmb 1
D0007 rmb 2
D0009 rmb 4
D000D rmb 1
D000E rmb 2
D0010 rmb 1
D0011 rmb 1
D0012 rmb 1
D0013 rmb 1
D0014 rmb 1
D0015 rmb 32239
D7e04 equ . 
size  equ .

name
L000D fcs "sub"


start                        
L0010 fcb 16                 they put the "start" at the wrong byte :-)
      ldu   #$0100           set u end of direct page
      ldx   #$0102           set x to the word past it start of data area
      ldd   #$7E04           set d to the end of the data area
      subd  #$0102           find the difference
      tfr   d,y              move that to index reg y

*                            make this inc by 2's next rev since
*                            we know its an even number
clr_mem
L001F clr   ,x+              clear x and bump one byte
      leay  -1,y             dec the counter 
      bne   clr_mem          loop till we're done  L001F
            
      ldu   #0
      leax  L06C1,pcr
      os9   F$Icpt
      
      lda   #1
      leax  L1F76,pcr
      os9   I$Open
      
      pshs  a
      ldx   #$7217
      ldy   #$0BED
      os9   I$Read
      puls  a
      
      os9   I$Close
      
      ldx   #1
      ldd   #$018B
      os9   I$SetStt
      
      lblo  L044C
      stx   X1D8B
      stx   X1D8D
      stx   X1D89
      
      lda   #1
      leax  L1F9C,pcr
      os9   I$Open
      
      pshs  a
      ldx   X1D89
      ldy   #$3C00
      lda   ,s
      os9   I$Read
      puls  a
      
      os9   I$Close
      ldd   #0
      jsr   X735B
      
      ldd   #$010F
      jsr   X735B
      
      ldd   #$0207
      jsr   X735B
      
      ldd   #$033F
      jsr   X735B
      
      ldy   #1
      ldd   #$018C
      os9   I$SetStt
      
      leax  L1FB0,pcr
      lda   #$21
      os9   F$NMLoad
      lblo  L044C
      
      lda   #$21
      leax  L1FB0,pcr
      os9   F$Link
      
      leax  L1FB0,pcr
      stx   X0105
      sty   X0107
      stu   X0103
      
      lda   #2
      sta   X0102
      
      ldd   #$0100
      lbsr  L049E
      
      lda   #$33
      lbsr  L0598

L00D1 lda   X0500
      ora   X4C82
      bne   L011F

      ldx   X0292
      bne   L0114

      ldx   #5
      stx   X0292

      lbsr  L1C34
      lbsr  L0A2A
      lbsr  L1EA2
      lbsr  L12F1
      lbsr  L16D0
      lbsr  L188E
      lbsr  L18FD
      lbsr  L19AB
      lbsr  L1A9E
      lbsr  L1B26
      lbsr  L1BBF
      lbsr  L11FC
      lbsr  L112B
      lbsr  L10A0
      lbsr  L0BAF
      lbsr  L17CE

L0114 ldx   X0292
      leax  -1,x
      stx   X0292
      lbsr  L0E76

L011F lbsr  L06A7
      jsr   X7D56

      lbsr  L0811
      tsta  
      beq   L00D1
      lbsr  L084A
      clr   X0110
      lbsr  L013B
      lda   X0110
      beq   L00D1
      bra   L011F

L013B cmpa  #$38
      bhi   L0145
      cmpa  #$31
      lbhs  L0598

L0145 cmpa  #$62
      lbeq  L0290
      cmpa  #$64
      lbeq  L0356
      cmpa  #$65
      lbeq  L0296
      cmpa  #$66
      lbeq  L03BD
      cmpa  #$67
      lbeq  L029C
      cmpa  #$68
      lbeq  L033E
      cmpa  #$69
      lbeq  L02A2
      cmpa  #$6A
      lbeq  L02A8
      cmpa  #$4A
      lbeq  L02AE
      cmpa  #$6B
      lbeq  L0344
      cmpa  #$6D
      lbeq  L02B4
      cmpa  #$6F
      lbeq  L02BA
      cmpa  #$70
      lbeq  L02C0
      cmpa  #$71
      lbeq  L02D8
      cmpa  #$72
      lbeq  L02C6
      cmpa  #$73
      lbeq  L02CC
      cmpa  #$74
      lbeq  L02D2
      cmpa  #$75
      lbeq  L02DE
      cmpa  #$76
      lbeq  L02E4
      cmpa  #$77
      lbeq  L040F
      cmpa  #$78
      lbeq  L02EA
      cmpa  #$79
      lbeq  L02F0
      cmpa  #$7A
      lbeq  L02F6
      cmpa  #$2C
      lbeq  L034A
      cmpa  #$2E
      lbeq  L0350
      cmpa  #8
      lbeq  L033E
      cmpa  #$09
      lbeq  L0344
      cmpa  #$0C
      lbeq  L0326
      cmpa  #$0A
      lbeq  L0320
      cmpa  #$B1
      lbeq  L032C
      cmpa  #$B2
      lbeq  L0376
      cmpa  #$30
      lbeq  L03B7
      cmpa  #$39
      lbeq  L03AB
      cmpa  #$2F
      lbeq  L028A
      cmpa  #$2A
      lbeq  L032C
      cmpa  #$3A
      lbeq  L032C
      cmpa  #$3D
      lbeq  L0376
      cmpa  #$2D
      lbeq  L0376
      cmpa  #1
      lbeq  L0308
      cmpa  #2
      lbeq  L03A2
      cmpa  #4
      lbeq  L0332
      cmpa  #6
      lbeq  L0338
      cmpa  #7
      lbeq  L06CD
      cmpa  #$0B
      lbeq  L0314
      cmpa  #$0D
      lbeq  L0368
      cmpa  #$12
      lbeq  L0302
      cmpa  #$13
      lbeq  L02FC
      cmpa  #$0E
      lbeq  L0399
      cmpa  #$0F
      lbeq  L030E
      cmpa  #$10
      lbeq  L0362
      cmpa  #$11
      lbeq  L0435
      cmpa  #$14
      lbeq  L0384
      cmpa  #$16
      lbeq  L035C
      cmpa  #$17
      lbeq  L031A
      rts   
      
      
L028A ldd   #$024A
      lbra  L049E
L0290 ldd   #$020E
      lbra  L049E
L0296 ldd   #$020C
      lbra  L049E
L029C ldd   #$020A
      lbra  L049E
L02A2 ldd   #$0242
      lbra  L049E
L02A8 ldd   #$023C
      lbra  L049E
L02AE ldd   #$023A
      lbra  L049E
L02B4 ldd   #$0216
      lbra  L049E
L02BA ldd   #$0226
      lbra  L049E
L02C0 ldd   #$0228
      lbra  L049E
L02C6 ldd   #$0212
      lbra  L049E
L02CC ldd   #$0210
      lbra  L049E
L02D2 ldd   #$0206
      lbra  L049E
L02D8 ldd   #$021A
      lbra  L049E
L02DE ldd   #$0240
      lbra  L049E
L02E4 ldd   #$0248
      lbra  L049E
L02EA ldd   #$0246
      lbra  L049E
L02F0 ldd   #$0208
      lbra  L049E
L02F6 ldd   #$0244
      lbra  L049E
L02FC ldd   #$0106
      lbra  L049E
L0302 ldd   #$0108
      lbra  L049E
L0308 ldd   #$050C
      lbra  L049E
L030E ldd   #$0104
      lbra  L049E
L0314 ldd   #$0110
      lbra  L049E
L031A ldd   #$022A
      lbra  L049E
L0320 ldd   #$0220
      lbra  L049E
L0326 ldd   #$021E
      lbra  L049E
L032C ldd   #$0224
      lbra  L049E
L0332 ldd   #$0506
      lbra  L049E
L0338 ldd   #$0508
      lbra  L049E
L033E ldd   #$0232
      lbra  L049E
L0344 ldd   #$0234
      lbra  L049E
L034A ldd   #$0236
      lbra  L049E
L0350 ldd   #$0238
      lbra  L049E
L0356 ldd   #$023E
      lbra  L049E
L035C ldd   #$0116
      lbra  L049E
L0362 ldd   #$024C
      lbra  L049E
L0368 ldd   #$021C
      lbsr  L049E
      lda   X0294
      lbne  L0582
      rts
      
         
L0376 ldd   #$0222
      lbsr  L049E
      lda   X0294
      lbne  L0582
      rts
      
         
L0384 ldd   #$0114
      lbsr  L049E
      ldb   X0291
      bmi   L0395
      ldd   #$0214
      lbsr  L049E
L0395 clr   X0291
      rts
      
         
L0399 inc   X0297
      ldd   #$0102
      lbra  L049E
L03A2 inc   X0297
      ldd   #$0500
      lbra  L049E
L03AB ldb   X4CD4
      subb  #$0A
      clra  
      std   X4CF7
      lbra  L0376
L03B7 ldd   X4CEF
      jmp   X7AA7
L03BD ldd   #$0230
      lbsr  L049E
      tstb  
      bmi   L040E
      pshs  b
      ldx   X1DC9
      beq   L03D3
      ldd   #$0402
      lbsr  L049E
L03D3 tst   ,s+
      beq   L03FC
      lda   #$14
      suba  X4C77
      adda  X1E16
      suba  #$27
      ldu   X1DBF
      bne   L03E9
      ldu   X1DB9
L03E9 lbsr  L0E26
      jsr   X72C3
      fcc   "We hit, Sir"
      fcb   C$NULL
      rts
      
         
L03FC jsr   X72C3
      fcc   "We missed, Sir"
      fcb   C$NULL
L040E rts

   
L040F ldd   #$0218
      lbsr  L049E
      lda   X1E1D
      cmpa  #4
      bne   L0434
      lda   X1D43
      cmpa  #7
      beq   L0434
      lda   X05CE
      cmpa  #1
      ble   L042C
      lda   #1
L042C sta   X05CE
      lda   #$36
      lbra  L0598
L0434 rts   


L0435 ldd   #$050A
      lbsr  L049E
      tst   X0299
      bne   L0441
      rts   


L0441 ldu   X0103
      os9   F$UnLink
      lbsr  L0476       call to unload
      clra  
      clrb  
L044C pshs  cc,b
      lda   #$21
      leax  L1FB0,pcr
      os9   F$UnLoad
      
      lda   #$21
      leax  L1FB0,pcr
      os9   F$UnLoad
      puls  cc,b
      
      ldd   #$1100
      leax  L1FC4,pcr
      ldy   #0
      ldu   #0
      os9   F$Chain
      os9   F$Exit
      
L0476 pshs  a,b,x,y,u
      lda   #$21
      leax  L1FAB,pcr
      os9   F$UnLoad
      lda   #$21
      leax  L1FB5,pcr
      os9   F$UnLoad
      lda   #$21
      leax  L1FBA,pcr
      os9   F$UnLoad
      lda   #$21
      leax  L1FBF,pcr
      os9   F$UnLoad
      puls  a,b,x,y,u,pc
      
      
L049E cmpa  X0102
      bne   L04A8
      jsr   [X0107]
      rts   
      
      
L04A8 std   X1DDA
      leax  L1FAB,pcr
      deca  
      ldb   #5
      mul   
      leax  d,x
      stx   X1DDC
      lda   X0102
      beq   L04C3
      ldu   X0103
      os9   F$UnLink
L04C3 ldx   X1DDC
      lda   #$21
      os9   F$Link
      bcc   L0501
      lda   X1DDA
      cmpa  #2
      beq   L04F7
L04D4 lda   X0102
      cmpa  #2
      bne   L04ED
      ldu   X0103
      os9   F$UnLink
      bra   L04ED
L04E3 ldx   X0105
      beq   L04ED
      lda   #$21
      lbsr  L0476
L04ED lda   #$21
      ldx   X1DDC
      os9   F$NMLoad
      bcs   L04E3
L04F7 lda   #$21
      ldx   X1DDC
      os9   F$Link
      bcs   L04D4
L0501 ldx   X1DDC
      stx   X0105
      sty   X0107
      stu   X0103
      ldd   X1DDA
      sta   X0102
      jsr   ,y
      rts
      
         
      clr   X1D87
      rts
      
         
      pshs  a
      lda   #$FF
      sta   X1D87
      puls  a,pc
      
      
      pshs  a,b,x,y,u
      lda   #1
      leax  L1F7F,pcr
      os9   I$Open
      pshs  a
      ldb   #$74
      ldx   #$1E25
L0536 lda   ,s
      pshs  b,x
      ldy   #$003D
      os9   I$Read
      puls  b,x
      leax  80,x
      decb  
      bne   L0536
      puls  a
      os9   I$Close
      puls  a,b,x,y,u,pc
      
      
      ldd   #$0212
      jmp   X735B
      pshs  a,b,x,y,u
      lda   #1
      leax  L1F8D,pcr
      os9   I$Open
      pshs  a
      ldb   #$74
      ldx   #$1E25
L0568 lda   ,s
      pshs  b,x
      ldy   #$003D
      os9   I$Read
      puls  b,x
      leax  80,x
      decb  
      bne   L0568
      puls  a
      os9   I$Close
      puls  a,b,x,y,u,pc
      
      
L0582 clr   X0294
      lda   X1D43
      beq   L0597
      cmpa  #3
      beq   L0597
      cmpa  #5
      bcc   L0597
      lda   #$31
      lbra  L0598
L0597 rts

   
L0598 suba  #$30
      lbeq  L0685
      cmpa  #8
      lbhi  L0685
      ldb   X1E1D
      cmpb  #4
      bne   L05B7
      cmpa  #4
      lblo  L0685
      cmpa  #7
      lbeq  L0685
L05B7 cmpa  #5
      bne   L0605
      ldb   X4CDA
      bne   L05E3
      jsr   X72C3
      fcc   "Our sub does not have radar!"
      fcb   C$NULL
      fcb   C$CLSALL
      fcb   C$NULL
      fcb   $A2
L05E3 tst   X4D2B
      bne   L0605
      jsr   X72C3
      fcc   "Radar turned off, Sir!"
      fcb   C$NULL
      fcb   C$CLSALL
      fcb   C$NULL
      fcb   $80
L0605 ldx   X4CEF
      beq   L0648
      cmpa  #2
      bne   L0629
L060E jsr   X72C3
      fcc   "You would drown, Sir"
      fcb   C$NULL
      fcb   C$CLSALL
      fcb   C$NULL
      fcb   $5C
L0629 cmpa  #3
      beq   L060E
      cmpa  #5
      bne   L0648
      jsr   X72C3
      fcc   "Underwater, Sir!"
      fcb   C$NULL
      fcb   C$CLSALL
      fcb   C$NULL
      fcb   $3D
L0648 deca  
      cmpa  X1D43
      lbeq  L0685
      sta   X1D43
      ldu   #0
      stu   X1DB9
      leax  >L0686,pcr
      asla  
      ldd   a,x
      std   X010C
      leax  >L0696,pcr
      lda   X1D43
      asla  
      ldd   a,x
      leax  L0000,pcr
      leax  d,x
      stx   X010E
      ldd   #$0236
      jsr   X735B
      ldd   #$0109
      jsr   X735B
      inc   X0297
L0685 rts   


L0686 fcb   $04,$00,$04,$00,$04,$00
      fcb   $02,$02,$02,$00,$03,$00
      fcb   $05,$02,$02,$04

L0696 fcb   $06,$A6,$05,$1B,$05,$17
      fcb   $05,$24,$05,$24,$05,$50
      fcb   $06,$A6,$05,$56,$39

L06A7 lda   X0297
      beq   L06BB
      clr   X0297
      leax  >L06BB,pcr
      pshs  x
      ldx   X010E
      pshs  x
      rts   

L06BB ldd   X010C
      lbra  L049E

intercept
L06C1 sta   X010B
      lda   #$1B
      sta   X029C
      lda   X010B
      rti
         

L06CD ldd   #$0302
      lbsr  L049E
      lda   X035F
      beq   L06D9
      rts   


L06D9 tst   X4D28
      bne   L06E4
      ldd   #$020C
      lbsr  L049E
L06E4 lda   #5
      sta   X1E1D
      ldd   #$021A
      lbsr  L049E
      ldd   #$0015
      jsr   X7A68
      lda   #$38
      lbsr  L0598
      lbsr  L188E
      lbsr  L18FD
      lbsr  L19AB
      lbsr  L1A9E
      lbsr  L1B26
      lbsr  L1BBF
      ldb   #$FF
      stb   X0290
L0711 ldy   #$0356
      ldu   #$4C84
      jsr   X74D9
      cmpa  #2
      bls   L0755
      jsr   X7556
      std   X4CF3
      std   X4CFB
      lbsr  L1C34
      lbsr  L1C34
      lbsr  L1C34
      lbsr  L1EA2
      lbsr  L12F1
      lbsr  L16D0
      lbsr  L112B
      lbsr  L0BAF
      lbsr  L0E76
      lbsr  L06A7
      tst   X4CF2
      beq   L0755
      tst   X0500
      bne   L0755
      tst   X4D25
      beq   L0711
L0755 ldb   X0356
      stb   X4C84
      ldd   #$4000
      std   X4C85
      ldb   X0359
      stb   X4C87
      ldd   #$4000
      std   X4C88
      ldu   #$4C84
      jsr   X7D75
      pshs  a,b
      jsr   X7DB4
      tstb  
      beq   L07AA
      ldd   ,s
      inca  
      jsr   X7DB4
      tstb  
      bne   L078C
      ldd   #$BF68
      std   X4C88
      bra   L07AA
L078C ldd   ,s
      incb  
      inca  
      jsr   X7DB4
      tstb  
      bne   L07A1
      ldd   #$BF68
      std   X4C88
      std   X4C85
      bra   L07AA
L07A1 ldd   #$BF68
      std   X4C85
      std   X4C88
L07AA puls  a,b
      clr   X4D2C
      clr   X0125
      jsr   X72C3
      fcc   "Navigator disengaging, Sir!"
      fcb   C$NULL
      lda   #1
      sta   X1E1D
      ldd   #$021A
      lbsr  L049E
      ldd   X4CF3
      jsr   X7A23
      ldd   X4CF3
      std   X4CFB
      lbsr  L1F5A
      ldd   #0
      sta   X0290
      jsr   X7A68
      rts   


      pshs  b,x,y
      clra  
      ldx   #$4265
      ldy   #1
      os9   I$Read
      lda   X4265
      cmpa  #3
      beq   L080D
      cmpa  #5
      bne   L080F
L080D lda   #$1B
L080F puls  b,x,y,pc


L0811 pshs  b,x,y
      inc   X1D3F
      clra  
      ldb   #1
      os9   I$GetStt
      bcc   L0821
      clra  
      puls  b,x,y,pc


L0821 clra  
      ldx   #$1DDA
      ldy   #1
      os9   I$Read
      lda   X1DDA
      adda  X1D3F
      sta   X1D3F
      lda   X1DDA
      cmpa  #3
      beq   L0843
      tst   X029C
      bne   L0843
      puls  b,x,y,pc
      
L0843 clr   X029C
      lda   #$1B
      puls  b,x,y,pc
      
L084A pshs  a,b,x,y,u
L084C lbsr  L0811
      tsta  
      bne   L084C
      puls  a,b,x,y,u,pc
      
      
L0854 pshs  a,b,x,y,u
      leax  >L0883,pcr
L085A tsta  
      beq   L0864
L085D ldb   ,x+
      bne   L085D
      deca  
      bra   L085A
L0864 jsr   X74CC
      puls  a,b,x,y,u,pc
      
      
L0869 pshs  a,b,x,y,u
      ldb   X4C75
      bne   L0872
      adda  #2
L0872 leax  >L08CD,pcr
      lda   a,x
      leax  >L08D1,pcr
      leax  a,x
      jsr   X74CC
      puls  a,b,x,y,u,pc

      
L0883 fcc "P.T. Boat"
      fcb C$NULL
      fcc "Troop Ship"
      fcb C$NULL
      fcc "Tanker"
      fcb C$NULL
      fcc "Cargoship"
      fcb C$NULL
      fcc "Carrier"
      fcb C$NULL
      fcc "Battleship"
      fcb C$NULL
      fcc "Destroyer"
      fcb C$NULL
      fcc "Escort"
      fcb C$NULL
L08CD fcb C$NULL
      fcb C$LF
      fcb $15,$1D
      
L08D1 fcc "Zero, Sir"
      fcb C$NULL
      fcc "Aichi, Sir"
      fcb C$NULL
      fcc "Avenger"
      fcb C$NULL
      fcc "Catalina"
      fcb C$NULL
L08F7 pshs  a,b,x,y,u
      leax  >L090C,pcr
L08FD tstb  
      beq   L0907
L0900 lda   ,x+
      bne   L0900
      decb  
      bra   L08FD
L0907 jsr   X74CC
      puls  a,b,x,y,u,pc


L090C fcc "sonar"
      fcb C$NULL
      fcc "radio"
      fcb C$NULL
      fcc "engines"
      fcb C$NULL
      fcc "rudder"
      fcb C$NULL
      fcc "ballast"
      fcb C$NULL
      fcc "hull"
      fcb C$NULL
      fcc "fwd tubes"
      fcb C$NULL
      fcc "aft tubes"
      fcb C$NULL
      fcc "planes"
      fcb C$NULL
      fcc "aa gun"
      fcb C$NULL
      fcc "periscope"
      fcb C$NULL
      fcc "batteries"
      fcb C$NULL
      fcc "deck gun"
      fcb C$NULL
      fcc "radar"
      fcb C$NULL
L0979 pshs  a,b,x,y,u
      leax  >L098E,pcr
L097F tstb  
      beq   L0989
L0982 lda   ,x+
      bne   L0982
      decb  
      bra   L097F
L0989 jsr   X74CC
      puls  a,b,x,y,u,pc


L098E fcc "sonar is"
      fcb C$NULL
      fcc "radio is"
      fcb C$NULL
      fcc "engines are"
      fcb C$NULL
      fcc "rudder is"
      fcb C$NULL
      fcc "ballast is"
      fcb C$NULL
      fcc "hull is"
      fcb C$NULL
      fcc "fwd tubes are"
      fcb C$NULL
      fcc "aft tubes are"
      fcb C$NULL
      fcc "planes are"
      fcb C$NULL
      fcc "aa gun is"
      fcb C$NULL
      fcc "periscope is"
      fcb C$NULL
      fcc "batteries are"
      fcb C$NULL
      fcc "deck gun is"
      fcb C$NULL
      fcc "radar is"
      fcb C$NULL
L0A2A pshs  a,b,x,y,u
      ldd   X4CEF
      lslb  
      rola  
      cmpd  #$000A
      bcs   L0A3A
      subd  #$000A
L0A3A std   X011E
      ldd   X0120
      std   X0122
      clr   X0125
      ldu   #$4C84
      jsr   X7D75
      pshs  a,b,x,y
      cmpa  #5
      lbls  L0B69
      cmpa  #$D8
      lbhs  L0B69
      cmpb  #5
      lbls  L0B69
      tst   X4C75
      bne   L0A6D
      cmpb  #$9A
      lbhs  L0B69
      bra   L0A73
L0A6D cmpb  #$C2
      lbhs  L0B69
L0A73 ldd   ,s
      jsr   X7DB4
      tstb  
      beq   L0A8D
      puls  a,b,x,y
      tst   X0500
      bne   L0A8B
      ldd   #$0518
      lbsr  L049E
      inc   X0500
L0A8B puls  a,b,x,y,u,pc


L0A8D ldd   ,s
      cmpx  #$4E20
      bcs   L0AB1
      inca  
      jsr   X7DB4
      tstb  
      beq   L0AB1
      ldd   #$4E20
      pshs  a,b
      tfr   x,d
      subd  ,s++
      std   X0120
      inc   X0125
      cmpx  #$5550
      lbhi  L0B69
L0AB1 cmpx  #$2E40
      bhi   L0AD5
      ldd   ,s
      deca  
      jsr   X7DB4
      tstb  
      beq   L0AD5
      stx   X0120
      ldd   #$2E40
      subd  X0120
      std   X0120
      inc   X0125
      cmpx  #$2710
      lblo  L0B69
L0AD5 cmpy  #$2E40
      bhi   L0AFC
      ldd   ,s
      decb  
      jsr   X7DB4
      tstb  
      beq   L0AFC
      sty   X0120
      ldd   #$2E40
      subd  X0120
      std   X0120
      inc   X0125
      cmpy  #$2710
      lblo  L0B69
L0AFC cmpy  #$4E20
      bcs   L0B22
      ldd   ,s
      incb  
      jsr   X7DB4
      tstb  
      beq   L0B22
      ldd   #$4E20
      pshs  a,b
      tfr   y,d
      subd  ,s++
      std   X0120
      inc   X0125
      cmpy  #$5550
      lbhi  L0B69
L0B22 lda   X0125
      beq   L0B33
      ldd   #$0730
      subd  X0120
      cmpd  X011E
      ble   L0B69
L0B33 clr   X4D2C
      tst   X0125
      beq   L0B65
      ldb   #$19
      jsr   X7691
      cmpb  #5
      bne   L0B65
      jsr   X72C3
      fcc   "We are in shallow water, Sir."
      fcb   C$NULL
L0B65 puls  a,b,x,y
      puls  a,b,x,y,u,pc
      
      
L0B69 clr   X0125
      tst   X4D2C
      bne   L0BA6
      jsr   X72C3
      fcc   "We have run aground, Sir"
      fcb   C$NULL
      ldb   #$0C
      jsr   X7691
      lda   X4C77
      inca  
      mul   
      lbsr  L0D3A
      ldd   #0
      jsr   X7A3A
      ldd   #0
      jsr   X7A68
L0BA6 lda   #$FF
      sta   X4D2C
      puls  a,b,x,y
      puls  a,b,x,y,u,pc
      
      
L0BAF pshs  a,b,x,y,u
      tst   X4C82
      lbne  L0D38
      tst   X4C76
      lbeq  L0CCF
      tst   X0295
      lbeq  L0CCF
      clr   X0295
      tst   X4C80
      lbmi  L0C71
      ldx   #$4C98
      lda   X4C80
      leax  a,x
      ldb   ,x
      stb   X1E10
      ldb   4,x
      stb   X1E0D
      ldd   #$7FFF
      std   X1E0E
      std   X1E11
      ldu   #$4C84
      ldy   #$1E0D
      jsr   X74D9
      ldb   X4C77
      cmpb  #2
      blt   L0C02
      cmpa  #1
      bcc   L0C71
      bra   L0C06
L0C02 cmpa  #2
      bcc   L0C71
L0C06 clr   X4C81
      lda   X4C80
      ldx   #$4CA4
      ldy   #$4C78
      inc   a,y
      ldb   a,y
      jsr   X723C
      jsr   X723C
      pshs  a,b
      clra  
      jsr   X7304
      jsr   X72F3
      fcc   " day"
      fcb   C$NULL
      cmpb  #1
      beq   L0C34
      jsr   X72F3
      
      fcb  $73
      fcb  $00
      
L0C34 jsr   X72F3
      fcc   " on station, Sir!"
      fcb   C$NULL
      jsr   X7228
      puls  a,b
      cmpb  a,x
      bne   L0C71
      jsr   X72C3
      fcc   "We can leave now, Sir"
      fcb   C$NULL
      ldd   #$010E
      lbsr  L049E
L0C71 tst   X4C81
      beq   L0C79
      dec   X4C81
L0C79 ldx   #$4C8A
      clrb  
L0C7D tst   ,x
      bmi   L0C8B
      tst   3,x
      bmi   L0C8B
      dec   3,x
      bne   L0C8B
      beq   L0C94
L0C8B leax  1,x
      incb  
      cmpb  #3
      bne   L0C7D
      bra   L0C9D
L0C94 inc   X0298
      ldd   #$010C
      lbsr  L049E
L0C9D ldx   #$4C90
      clrb  
L0CA1 tst   ,x
      bmi   L0CAF
      tst   4,x
      bmi   L0CAF
      dec   4,x
      bne   L0CAF
      bra   L0CB8
L0CAF leax  1,x
      incb  
      cmpb  #4
      blt   L0CA1
      bra   L0CCF
L0CB8 stb   X0296
      lda   #$16
      mul   
      addd  #$0579
      tfr   d,x
      lbsr  L11C8
      std   X1D6D
      ldd   #$010A
      lbsr  L049E
L0CCF ldb   X4CA0
      bmi   L0CE7
      ldb   X4CA2
      bmi   L0CE7
      dec   X4CA2
      bne   L0CE7
      clr   X028F
      ldd   #$024E
      lbsr  L049E
L0CE7 ldb   X4CA1
      bmi   L0D01
      ldb   X4CA3
      bmi   L0D01
      dec   X4CA3
      bne   L0D01
      ldb   #1
      stb   X028F
      ldd   #$024E
      lbsr  L049E
L0D01 ldx   #$4A80
      ldb   X4CB4
      lda   #$15
      mul   
      leax  d,x
      ldb   13,x
      bne   L0D38
      ldd   14,x
      cmpd  #$1388
      bhi   L0D38
      tst   X4C81
      bne   L0D38
      ldd   #$050E
      lbsr  L049E
      inc   X4C82
      lda   X4C76
      cmpa  #2
      bne   L0D38
      lda   X0500
      bne   L0D38
      ldd   #$0112
      lbsr  L049E
L0D38 puls  a,b,x,y,u,pc


L0D3A pshs  a,b,x,y,u
      incb  
      pshs  b
      lbsr  L0DEC
      lbsr  L0DEC
      puls  a
      tsta  
      bne   L0D4C
      lda   #2
L0D4C ldb   #$0D
      tst   X4CDA
      beq   L0D54
      incb  
L0D54 jsr   X7691
      ldu   #$4D2D
      tst   b,u
      bpl   L0D60
      bra   L0D8A
L0D60 adda  b,u
      cmpa  #$30
      bcs   L0D68
      lda   #$FF
L0D68 sta   b,u
      jsr   X723C
      jsr   X72F3
      fcc   "The "
      fcb   C$NULL
      lbsr  L0979
      cmpa  #0
      bge   L0D9E
      jsr   X72F3
      fcc   " destroyed"
      fcb   C$NULL
L0D8A ldb   #5
      jsr   X7691
      addb  #8
      lda   X4C77
      inca  
      mul   
      addb  X4CEE
      stb   X4CEE
      bra   L0DD9
L0D9E jsr   X72F3
      fcc   " damaged"
      fcb   C$NULL
      jsr   X7228
      jsr   X723C
      jsr   X72F3
      fcc  "Repairs estimated at "
      fcb   C$NULL
      tfr   a,b
      clra  
      jsr   X7304
      jsr   X72F3
      fcc   " hours"
      fcb   C$NULL
L0DD9 jsr   X7228
      lda   X4CEE
      bpl   L0DEA
      clr   X0355
      ldd   #$0504
      lbsr  L049E
L0DEA puls  a,b,x,y,u,pc


L0DEC pshs  a,b,x,y,u
      ldy   #$07D0
L0DF2 mul   
      leay  -1,y
      bne   L0DF2
      ldd   #$0027
      jsr   X735B
      ldd   #$0300
      jsr   X735B
      ldd   #$0F26
      jsr   X735B
      ldy   #$0FA0
L0E0D mul   
      leay  -1,y
      bne   L0E0D
      ldd   #$033F
      jsr   X735B
      ldd   #0
      jsr   X735B
      ldd   #$0F00
      jsr   X735B
      puls  a,b,x,y,u,pc
      
      
L0E26 pshs  a,b,x,y,u
      fdb   Zldb_u           ldb 0,u
      cmpb  #$64
      bcc   L0E51
      leax  L1F6B,pcr
      ldb   D0012,u
      ldb   b,x
      jsr   X76F7
      inca  
      fdb   Zadda_u          adda 0,u
      cmpa  #$64
      bcs   L0E43
      lda   #$64
L0E43 fdb   $A740            sta 0,u
      lda   D0010,u
      cmpa  #1
      bcc   L0E51
      lda   #1
      sta   D0010,u
L0E51 lda   X1D43
      cmpa  #2
      bhi   L0E74
      stu   X71C9
      clr   X71CB
L0E5E ldd   #$0400
      lbsr  L049E
      inc   X71CB
      lda   X71CB
      cmpa  #8
      bcs   L0E5E
      ldd   #0
      std   X71C9
L0E74 puls  a,b,x,y,u,pc


L0E76 ldx   #$0115
      os9 F$Time
      ldb   X011A
      tst   X0290
      bne   L0E8B
      cmpb  X011B
      lbeq  L0F2D
L0E8B stb   X011B
      ldd   X1E20
      cmpd  #$003C
      bcs   L0EAD
      ldu   #$0E10
      jsr   X76B9
      lbsr  L0ECF
      tfr   u,d
      ldu   #$003C
      jsr   X76B9
      lbsr  L0EBE
      tfr   u,d
L0EAD addb  X1E1B
      stb   X1E1B
      cmpb  #$3C
      bcs   L0F2D
      subb  #$3C
      stb   X1E1B
      ldb   #1
L0EBE addb  X1E1A
      stb   X1E1A
      cmpb  #$3C
      bcs   L0F2D
      subb  #$3C
      stb   X1E1A
      ldb   #1
L0ECF lbsr  L0F45
      lbsr  L0F97
      addb  X1E19
      stb   X1E19
      cmpb  #$18
      bcs   L0F2E
      subb  #$18
      stb   X1E19
      lbsr  L0F2E
      lda   #$FF
      sta   X0295
      ldd   X1E17
      addd  #1
      cmpd  #$016D
      bcs   L0EFE
      ldd   #0
      inc   X1E16
L0EFE std   X1E17
      lda   X4D21
      cmpa  #2
      bgt   L0F1D
      jsr   X72C3
      fcc   "Supplies low, Sir"
      fcb   C$NULL
L0F1D lda   X4D21
      cmpa  #254
      bne   L0F2A
      ldd   #$0510
      lbra  L049E
L0F2A dec   X4D21
L0F2D rts   


L0F2E clra  
      cmpb  #5
      bcs   L0F41
      cmpb  #5
      beq   L0F40
      cmpb  #$12
      beq   L0F40
      cmpb  #$12
      bhi   L0F41
      inca  
L0F40 inca  
L0F41 sta   X1E1C
      rts   


L0F45 pshs  a,b,x,y,u
      stb   X0114
      ldx   #$4D2D
      clrb  
L0F4E lda   b,x
      lbeq  L0F90
      lbmi  L0F90
      suba  X0114
      sta   b,x
      lbpl  L0F90
      clr   b,x
      jsr   X723C
      jsr   X72F3
      fcc   "Repair of the "
      fcb   C$NULL
      lbsr  L08F7
      jsr   X7228
      jsr   X72C3
      fcc   "completed, Sir"
      fcb   C$NULL
L0F90 incb  
      cmpb  #$0E
      bcs   L0F4E
      puls  a,b,x,y,u,pc
      
      
L0F97 pshs  a,b,x,y,u
      pshs  b
      lda   X4D28
      lbeq  L0FF4
      ldd   X4CEF
      lbne  L0FF4
      ldb   X4CF2
      bpl   L0FAF
      negb  
L0FAF lda   ,s
      mul   
      lda   X4CDF
      mul   
      lsra  
      rorb  
      lsra  
      rorb  
      cmpd  #0
      bne   L0FC1
      incb  
L0FC1 coma  
      comb  
      addd  #1
      addd  X4D1B
      cmpd  #0
      bge   L0FD2
      ldd   #0
L0FD2 std   X4D1B
      lda   X4D29
      beq   L0FF4
      ldd   X4D1B
      beq   L0FF4
      lda   ,s
      clrb  
      addd  X4D1D
      cmpd  #$6300
      bcs   L0FEE
      ldd   #$6300
L0FEE std   X4D1D
      lbra  L1060
L0FF4 lda   X4D28
      lbne  L1060
      ldd   X4D1D
      lbeq  L1060
      ldb   X4CF2
      bpl   L1008
      negb  
L1008 pshs  a,b
      clra  
      ldb   X4CD5
      cmpd  X4CEF
      bhi   L101A
      puls  a,b
      addb  #3
      pshs  a,b
L101A puls  a,b
      lslb  
      lslb  
      lda   ,s
      mul   
      incb  
      lda   X4CE3
      asla  
      mul   
      coma  
      comb  
      addd  #1
      addd  X4D1D
      cmpd  #0
      bge   L105D
      ldd   X4D1D
      beq   L105A
      jsr   X72C3
      fcc   "The batteries are dead, Sir!"
      fcb   C$NULL
L105A ldd   #0
L105D std   X4D1D
L1060 ldb   X4CD5
      clra  
      cmpd  X4CEF
      bls   L1072
      ldd   #$6300
      std   X4D1F
      bra   L109C
L1072 lda   ,s
      ldb   X4CE1
      lslb  
      lslb  
      addb  X4C77
      incb  
      lslb  
      lslb  
      mul   
      lslb  
      rola  
      coma  
      comb  
      addd  #1
      addd  X4D1F
      cmpd  #0
      bge   L1099
      ldd   #$0512
      lbsr  L049E
      ldd   #0
L1099 std   X4D1F
L109C puls  b
      puls  a,b,x,y,u,pc
      
L10A0 lda   X4D25
      sta   X1DDA
      clr   X4D25
      clr   X1DDB
      lda   #$45
      sta   X1E13
      ldx   #$42B5
L10B4 fdb   Zlda_x             lda  0,x
      lbmi  L1109
      lda   13,x
      lbne  L1109
      ldd   X4CEF
      beq   L10CF
      ldd   14,x
      cmpd  #$1770
      bhi   L10FC
      bra   L10EE
L10CF ldd   14,x
      tst   X4CDA
      beq   L10E8
      tst   X4D2B
      beq   L10E8
      tst   X4D3A
      bne   L10E8
      cmpd  #$6000
      bhi   L10FC
      bra   L10EE
L10E8 cmpd  #$2000
      bhi   L10FC
L10EE inc   X4D25
      lda   X1DDA
      bne   L112A
      ldd   #$022C
      lbra  L049E
L10FC cmpx  #$480A
      bcc   L1109
      inc   X1DDB
      ldd   11,x
      std   X1D6D
L1109 leax  21,x
      dec   X1E13
      bne   L10B4
      ldd   X4CEF
      bne   L112A
      lda   X1DDB
      beq   L112A
      lda   X4D26
      beq   L1124
      dec   X4D26
      rts   


L1124 ldd   #$022E
      lbra  L049E
L112A rts   


L112B lda   #4
      sta   X1E13
      ldx   #$4A02
      ldy   #$0579
L1137 fdb   Zlda_x         lda 0,x
      lbmi  L1196
      lda   20,x
      bne   L1148
      lda   #$FF
      fdb   Zsta_x         sta 0,x
      bra   L1196
L1148 clr   20,x
      lda   16,x
      beq   L1163
      lda   13,x
      cmpa  #3
      bcs   L115B
      clr   16,x
      bra   L1163
L115B ldb   #8
      stb   2,x
      clr   1,x
      bra   L1169
L1163 ldb   1,y
      stb   2,x
      clr   1,x
L1169 lbsr  L11A4
      tsta  
      bne   L1191
      lda   8,y
      inca  
      cmpa  #3
      bne   L118C
      pshs  a,b
      lda   2,y
      ldb   4,y
      sta   4,y
      stb   2,y
      lda   5,y
      ldb   7,y
      sta   7,y
      stb   5,y
      puls  a,b
      lda   #1
L118C sta   8,y
      lbsr  L11A4
L1191 jsr   X7556
      std   9,x
L1196 leax  21,x
      leay  22,y
      dec   X1E13
      lbne  L1137
      rts   


L11A4 pshs  y
      lda   8,y
      leay  a,y
      ldd   #0
      std   X1DF7
      std   X1DFA
      ldb   2,y
      stb   X1DF6
      ldb   5,y
      stb   X1DF9
      ldy   #$1DF6
      leau  3,x
      jsr   X74D9
      puls  y,pc


L11C8 pshs  x,y,u
      ldd   #0
      std   X1DF7
      std   X1DFA
      std   X1DFD
      std   X1E00
      ldb   2,x
      stb   X1DF6
      ldb   5,x
      stb   X1DF9
      ldb   3,x
      stb   X1DFC
      ldb   6,x
      stb   X1DFF
      ldy   #$1DFC
      ldu   #$1DF6
      jsr   X74D9
      jsr   X7556
      puls  x,y,u,pc


L11FC lda   #2
      sta   X1E13
      ldx   #$4A56
L1204 fdb   Zlda_x          lda 0,x     
      lbmi  L12E6
      ldu   19,x
      lda   D0007,u
      beq   L1282
      ldd   X4CEF
      bne   L1276
      lda   13,x
      bne   L1276
      ldd   14,x
      lsra                 left shift d (/2)
      rorb  
      lsra                 left shift d (/2)
      rorb  
      lsra                 left shift d (/2)
      rorb  
      cmpd  X1E1E
      bhi   L1276
      fdb   Zlda_u         lda 0,u
      bne   L124D
      jsr   X72C3
      fcc   "We picked up the flier, Sir"
      fcb   C$NULL
      bra   L1270
L124D jsr   X72C3
      fcc   "We picked up the shore party"
      fcb   C$NULL
      clr   X4D27
L1270 lda   #$FF
      fdb   Zsta_x         sta 0,x
      bra   L12E6
L1276 ldd   11,x
      addd  #$02D0
      jsr   X7648
      std   9,x
      bra   L12E6
L1282 leay  D0001,u
      leau  3,x
      jsr   X74D9
      pshs  a,u
      jsr   X7556
      std   9,x
      puls  a,u
      tsta  
      bne   L12E6
      tfr   u,d
      lsra                 left shift d (/2)
      rorb  
      lsra                 left shift d (/2)
      rorb  
      lsra                 left shift d (/2)
      rorb  
      cmpd  X1E1E
      bhi   L12E6
      jsr   X72C3
      fcc   "Shore party has reached land"
      fcb   C$NULL
      jsr   X72C3
      fcc   "Shore party returning, Sir"
      fcb   C$NULL
      ldu   19,x
      inc   D0007,u
L12E6 leax  21,x
      dec   X1E13
      lbne  L1204
      rts   
      
      
L12F1 lda   #$41
      sta   X1E13
      ldx   #$42B5
L12F9 fdb   Zlda_x        lda 0,x
      lbmi  L1394
      cmpa  #$64
      lbhs  L1394
      pshs  a,b,x,y,u
      lda   13,x
      bne   L1362
      ldd   14,x
      cmpd  #$0064
      bhi   L1362
      ldd   X4CEF
      tsta  
      bne   L1362
      lda   X4CD5
      adda  X4D11
      adda  #$14
      pshs  a
      cmpb  ,s+
      bcc   L1362
      ldb   #4
      jsr   X7691
      cmpb  #2
      bne   L1362
      ldb   #$14
      jsr   X7691
      lda   X4C77
      inca  
      mul   
      incb  
      lbsr  L0D3A
      andb  #7
      addb  X4CEE
      stb   X4CEE
      jsr   X72C3
      fcc   "We have been rammed, Sir"
      fcb   C$NULL
L1362 puls  a,b,x,y,u
      lda   18,x
      ldb   #$0C
      mul   
      addd  #$0501
      tfr   d,y
      std   X0109
      lda   16,x
      cmpa  #2
      bcc   L137E
      lbsr  L145B
      bra   L138E
L137E ldy   X0109
      lda   7,y
      beq   L138B
      lbsr  L14EC
      bra   L138E
L138B lbsr  L15F9
L138E clr   X1D7B
      lbsr  L139F
L1394 leax  21,x
      dec   X1E13
      lbne  L12F9
      rts
      
         
L139F ldu   19,x
      beq   L13DC
      cmpx  #$480A
      bcc   L13AC
      inc   D0014,u
L13AC lda   D0010,u
      cmpa  16,x
      bcs   L13BC
      sta   16,x
      clr   17,x
      bra   L13DC
L13BC ldb   17,x
      beq   L13DC
      tst   X1E1E
      bne   L13D1
      subb  X1E1F
      cmpb  #1
      blt   L13D1
      stb   17,x
      rts   
      
      
L13D1 clr   17,x
      sta   D0010,u
      lda   #5
      sta   D0011,u
L13DC lda   13,x
      bne   L1454
      tst   X1D7B
      beq   L13F4
      ldd   1,x
      cmpd  #$0032
      bhi   L13F4
      ldd   #$0035
      std   1,x
      bra   L13F9
L13F4 lda   X4D2C
      bne   L1444
L13F9 ldb   X4CD5
      clra  
      cmpd  X4CEF
      bls   L1444
      lda   16,x
      cmpa  #2
      lbeq  L1443
      ldu   #$0064
      cmpa  #1
      bcs   L1416
      ldu   #$01F4
L1416 ldd   #$2000
      tst   X1D7B
      beq   L1421
      ldd   #$6000
L1421 pshs  a,b
      ldd   14,x
      cmpd  ,s++
      bhi   L1444
      tst   X1D7B
      bne   L1439
      jsr   X76B9
      incb  
      jsr   X7691
      tstb  
      bne   L1443
L1439 lda   #2
      sta   16,x
      lda   #5
      sta   17,x
L1443 rts   


L1444 lda   16,x
      cmpa  #2
      bne   L1453
      lda   #1
      sta   16,x
      clr   17,x
L1453 rts

   
L1454 clr   16,x
      clr   17,x
      rts
      
         
L145B ldu   19,x
      lbeq  L14E1
      pshs  y
      leay  D0003,u
      leau  3,x
      jsr   X74D9
      puls  y
      tsta  
      bne   L1476
      cmpu  #$1F40
      bcs   L1485
L1476 ldu   19,x
      ldd   D0001,u
      addd  #4
      pshs  a,b
      jsr   X7556
      bra   L1497
L1485 ldu   19,x
      ldd   D0001,u
      cmpd  #$000C
      bls   L1493
      ldd   #$000C
L1493 pshs  a,b
      ldd   D0009,u
L1497 subd  9,x
      lbeq  L14B0
      jsr   X765F
      ldy   X0109
      ldu   1,y
      lbsr  L1DD0
      addd  9,x
      jsr   X7648
      std   9,x
L14B0 lda   16,x
      beq   L14C0
      ldy   X0109
      ldb   1,y
      clra  
      leas  2,s
      bra   L14C2
L14C0 puls  a,b
L14C2 subd  1,x
      lbeq  L14E0
      ldy   X0109
      ldu   4,y
      lbsr  L1DD0
      addd  1,x
      ldy   X0109
      cmpb  1,y
      bls   L14DE
      ldb   1,y
      clra  
L14DE std   1,x
L14E0 rts   


L14E1 lda   13,x
      cmpa  #3
      bcs   L14E0
      lda   #$FF
      fdb   Zsta_x           sta 0,x
      rts   
      
      
L14EC lda   13,x
      lbne  L154E
      ldd   X4CEF
      tsta  
      bne   L1539
      cmpb  X4CD5
      bhi   L1539
      ldb   #$14
      subb  X4C77
      jsr   X7691
      tstb  
      bne   L1539
      ldd   14,x
      cmpd  #$3A98
      bhi   L1539
      ldu   #$03E8
      jsr   X76B9
      incb  
      jsr   X7691
      tstb  
      beq   L1522
      lbsr  L15B8
      bra   L1539
L1522 lda   X4C77
      inca  
      ldy   X0109
      ldb   8,y
      lsrb  
      incb  
      addb  X1E1D
      mul   
      jsr   X7691
      incb  
      lbsr  L0D3A
L1539 ldd   14,x
      cmpd  #$07D0
      bhi   L154E
      ldd   #$0168
      jsr   X76A4
      addd  11,x
      addd  #$02D0
      bra   L1553
L154E ldd   11,x
      addd  #$02D0
L1553 subd  9,x
      lbeq  L156C
      jsr   X765F
      ldy   X0109
      ldu   1,y
      lbsr  L1DD0
      addd  9,x
      jsr   X7648
      std   9,x
L156C ldy   X0109
      ldb   1,y
      fdb  $A600
      beq   L159A
      cmpa  #$64
      bcs   L157D
      clrb  
      bra   L159A
L157D cmpa  #$0A
      bhi   L1584
      decb  
      bra   L159A
L1584 cmpa  #$50
      bhi   L1594
      cmpa  #$3C
      bhi   L1595
      cmpa  #$28
      bhi   L1596
      decb  
      decb  
      bra   L159A
L1594 lsrb  
L1595 lsrb  
L1596 lsrb  
      bne   L159A
      incb  
L159A ldy   X0109
      clra  
      subd  1,x
      beq   L15B7
      ldu   4,y
      lbsr  L1DD0
      ldy   X0109
      addd  1,x
      cmpb  1,y
      bls   L15B5
      ldb   1,y
      clra  
L15B5 std   1,x
L15B7 rts   


L15B8 pshs  a,b,x,y,u
      lda   X1D43
      cmpa  #2
      bhi   L15F4
      lda   #$FF
      sta   X02A2
      ldb   #$64
      jsr   X7691
      clra  
      addd  #$0032
      std   X029E
      ldb   #$1E
      jsr   X7691
      pshs  b
      ldb   #$73
      subb  ,s+
      clra  
      std   X02A0
      clr   X029D
L15E4 ldd   #$0400
      lbsr  L049E
      inc   X029D
      lda   X029D
      cmpa  #8
      bcs   L15E4
L15F4 clr   X02A2
      puls  a,b,x,y,u,pc
      
      
L15F9 ldd   11,x
      subd  9,x
      lbeq  L1614
      jsr   X765F
      ldy   X0109
      ldu   1,y
      lbsr  L1DD0
      addd  9,x
      jsr   X7648
      std   9,x
L1614 ldy   X0109
      ldb   1,y
      fdb  $A600
      beq   L1642
      cmpa  #$64
      bcs   L1625
      clrb  
      bra   L1642
L1625 cmpa  #$0A
      bhi   L162C
      decb  
      bra   L1642
L162C cmpa  #$50
      bhi   L163C
      cmpa  #$3C
      bhi   L163D
      cmpa  #$28
      bhi   L163E
      decb  
      decb  
      bra   L1642
L163C lsrb  
L163D lsrb  
L163E lsrb  
      bne   L1642
      incb  
L1642 clra  
      ldy   X0109
      subd  1,x
      beq   L165F
      ldu   4,y
      lbsr  L1DD0
      ldy   X0109
      addd  1,x
      cmpb  1,y
      bls   L165D
      ldb   1,y
      clra  
L165D std   1,x
L165F lda   18,x
      cmpa  #4
      lbeq  L1669
      rts
      
         
L1669 ldb   #$0A
      lda   #4
      suba  X4C77
      mul   
      jsr   X7691
      tstb  
      beq   L1678
      rts
      
         
L1678 pshs  a,b,x,y,u
      lda   #4
      sta   X0111
      ldu   #$480A
L1682 fdb   Zlda_u           lda 0,u
      lbpl  L16C4
      fdb   Zclr_u           clr 0,u
      ldd   3,x
      std   D0003,u
      ldd   5,x
      std   D0005,u
      ldd   7,x
      std   D0007,u
      ldd   9,x
      std   D0009,u
      stx   D0013,u
      lda   16,x
      sta   D0010,u
      clr   D0011,u
      ldb   #2
      jsr   X7691
      stb   D0012,u
      pshs  a,b,y
      addb  #7
      lda   #$0C
      mul   
      addd  #$0502
      tfr   d,y
      ldb   ,y
      clra  
      std   D0001,u
      puls  a,b,y
      inc   X04FB
L16C4 leau  D0015,u
      dec   X0111
      lbne  L1682
      puls  a,b,x,y,u,pc
      
      
L16D0 lda   #4
      sta   X1E13
      ldx   #$480A
L16D8 fdb   Zlda_x             lda 0,x
      bmi   L16F1
      lda   16,x
      cmpa  #2
      bcc   L16E8
      lbsr  L16FC
      bra   L16EB
L16E8 lbsr  L1758
L16EB inc   X1D7B
      lbsr  L139F
L16F1 leax  21,x
      dec   X1E13
      lbne  L16D8
      rts  
      
       
L16FC lda   13,x
      cmpa  #3
      bcs   L1707
      lda   #$FF
      fdb   Zsta_x           sta 0,x
      rts 
        
L1707 ldu   19,x
      lbeq  L1757
      fdb   Zlda_u           lda 0,u
      lbmi  L1757
      ldu   D0013,u
      fdb   Zlda_u           lda 0,u
      lbmi  L1757
      leay  D0003,u
      leau  3,x
      jsr   X74D9
      pshs  a
      jsr   X7556
      tst   ,s+
      bne   L1742
      cmpu  #$1000
      bhi   L1742
      pshs  a,b
      ldd   #$003C
      jsr   X76A4
      addd  ,s++
      addd  #$0410
      bra   L1745
L1742 addd  #$02D0
L1745 subd  9,x
      jsr   X765F
      ldu   #$0020
      lbsr  L1DD0
      addd  9,x
      jsr   X7648
      std   9,x
L1757 rts

   
L1758 lda   13,x
      lbne  L17B2
      ldd   X4CEF
      tsta  
      bne   L179D
      cmpb  X4CD5
      bhi   L179D
      ldb   #$0A
      jsr   X7691
      tstb  
      bne   L179D
      ldd   14,x
      cmpd  #$0FA0
      bhi   L179D
      ldu   #$03E8
      jsr   X76B9
      incb  
      jsr   X7691
      tstb  
      beq   L178B
      lbsr  L15B8
      bra   L179D
L178B lda   X4C77
      adda  #2
      ldb   X1E1D
      addb  #2
      mul   
      jsr   X7691
      incb  
      lbsr  L0D3A
L179D ldd   14,x
      cmpd  #$07D0
      bhi   L17B2
      ldd   #$0168
      jsr   X76A4
      addd  11,x
      addd  #$02D0
      bra   L17B7
L17B2 ldd   11,x
      addd  #$02D0
L17B7 subd  9,x
      lbeq  L17CD
      jsr   X765F
      ldu   #$0010
      lbsr  L1DD0
      addd  9,x
      jsr   X7648
      std   9,x
L17CD rts

   
L17CE lda   X1E1D
      cmpa  #4
      beq   L17D6
      rts 
      
        
L17D6 ldb   #6
      lda   X4C77
      adda  #4
      mul   
      jsr   X7691
      tstb  
      beq   L17E5
      rts   
      
      
L17E5 ldb   #3
      jsr   X7691
      tstb  
      beq   L1827
      lda   #4
      sta   X0111
      ldu   #$480A
L17F5 fdb   Zlda_u          lda 0,u
      lbpl  L181C
      inc   X04FB
      ldb   #2
      jsr   X7691
      stb   D0012,u
      pshs  a,b,y
      addb  #7
      lda   #$0C
      mul   
      addd  #$0502
      tfr   d,y
      ldb   ,y
      clra  
      std   D0001,u
      puls  a,b,y
      lbra  L1855
L181C leau  D0015,u
      dec   X0111
      lbne  L17F5
      rts   
      
      
L1827 lda   #$41
      sta   X0111
      ldu   #$42B5
L182F fdb   Zlda_u        lda 0,u
      lbpl  L184A
      inc   X04FA
      ldb   #4
      jsr   X7691
      addb  #4
      stb   D0012,u
      ldd   #8
      std   D0001,u
      lbra  L1855
L184A leau  D0015,u
      dec   X0111
      lbne  L182F
      rts   


L1855 fdb   Zclr_u       clr 0,u
      ldd   #$8000
      jsr   X76A4
      addd  #$8000
      addd  X4C85
      std   D0004,u
      ldd   #$8000
      jsr   X76A4
      addd  #$8000
      addd  X4C88
      std   D0007,u
      lda   X4C84
      sta   D0003,u
      lda   X4C87
      sta   D0006,u
      ldd   #0
      std   D0009,u
      std   D0013,u
      lda   #2
      sta   D0010,u
      clr   D0011,u
      rts   


L188E lda   X4D16
      beq   L18A6
      ldu   X1E1E
      cmpu  #$001E
      bcc   L18A7
      suba  X1E1F
      cmpa  #1
      blt   L18A7
      sta   X4D16
L18A6 rts

   
L18A7 clr   X4D16
      lda   X4D15
      beq   L18CE
      jsr   X72C3
      fcc   "Deck gun missed, Sir"
      fcb   C$NULL
      ldd   #0
      std   X4D17
      rts   
      
      
L18CE ldu   X4D17
      lda   #$17
      ldb   X1E16
      subb  #$26
      pshs  b
      adda  ,s+
      lbsr  L0E26
      jsr   X72C3
      fcc   "A shell hit, Sir"
      fcb   C$NULL
      ldd   #0
      std   X4D17
      inc   X04FF
      rts   
      
      
L18FD lda   #$14
      sta   X1E13
      ldx   #$485E
L1905 fdb   Ztst_x             tst 0,x
      lbmi  L19A0
      lbsr  L1A63
      tsta  
      beq   L1953
      inc   X04FE
      lda   #$FF
      fdb   Zsta_x             sta 0.x
      lda   X4CC2
      lbsr  L0E26
      jsr   X723C
      ldd   #$0048
      std   X1DA5
      ldd   #$0082
      std   X1DA7
      jsr   X72F3
      fcc   "Torpedo "
      fcb   C$NULL
      ldb   16,x
      clra  
      jsr   X7304
      jsr   X72F3
      fcc   " hit, Sir"
      fcb   C$NULL
      jsr   X7228
      lbra  L19A0
L1953 ldd   17,x
      addd  X1E1E
      std   17,x
      cmpd  X4CBD
      bcs   L19A0
      lda   #$FF
      fdb   Zsta_x           sta 0,x
      jsr   X723C
      ldd   #$0048
      std   X1DA5
      ldd   #$0082
      std   X1DA7
      jsr   X72F3
      fcc   "Torpedo "
      fcb   C$NULL
      ldb   16,x
      clra  
      jsr   X7304
      jsr   X72F3
      fcc   " has stopped, Sir"
      fcb   C$NULL
      jsr   X7228
L19A0 leax  21,x
      dec   X1E13
      lbne  L1905
      rts   
      
      
L19AB lda   #$10
      sta   X1E13
      ldx   #$4AFE
L19B3 tst   16,x
      beq   L19D2
      tst   X1E1E
      bne   L19CC
      ldb   16,x
      subb  X1E1F
      bpl   L19C6
      clrb  
L19C6 stb   16,x
      lbra  L1A53
L19CC clr   16,x
      lbra  L1A53
L19D2 fdb   Ztst_x               tst 0,x
      lbmi  L1A53
      ldd   #5
      std   1,x
      lda   13,x
      bne   L1A1D
      ldd   14,x
      cmpd  #$000A
      bhi   L1A1D
      ldb   #$32
      jsr   X7691
      lda   X4C77
      inca  
      mul   
      lbsr  L0D3A
      andb  #$1F
      addb  X4CEE
      stb   X4CEE
      jsr   X72C3
      fcc   "A mine hit the sub, Sir"
      fcb   C$NULL
      lda   #$FF
      fdb   Zsta_x           sta 0,x
L1A1D lbsr  L1A63
      tsta  
      beq   L1A53
      lda   #$FF
      fdb   Zsta_x           sta 0,x
      lda   #$28
      lbsr  L0E26
      jsr   X72C3
      fcc   "I think a mine exploded, "
      fcc   "Sir!"
      fcb   C$NULL
     
      jsr   X7228
     
      lbra  L1A53
L1A53 ldd   #0
      std   1,x
      leax  21,x
      dec   X1E13
      lbne  L19B3
      rts
      
         
L1A63 pshs  b,x,y
      leay  3,x
      ldb   2,x
      incb  
      lda   X1E1F
      adda  #5
      mul   
      std   X0112
      lda   #$41
      sta   X0111
      ldx   #$42B5
L1A7B fdb   Ztst_x       tst 0,x
      bmi   L1A93
      leau  3,x
      jsr   X74D9
      tsta  
      bne   L1A93
      cmpu  X0112
      bhi   L1A93
      tfr   x,u
      lda   #1
      puls  b,x,y,pc
      
      
L1A93 leax  21,x
      dec   X0111
      bne   L1A7B
      clra  
      puls  b,x,y,pc
      
      
L1A9E lda   X4D14
      beq   L1AFF
      ldu   X1E1E
      cmpu  #$001E
      bcc   L1AB7
      suba  X1E1F
      cmpa  #1
      blt   L1AB7
      sta   X4D14
      rts
      
         
L1AB7 clr   X4D14
      ldu   X4D19
      beq   L1AFF
      stu   X4D17
      lbsr  L1B0C
      stb   X4D16
      sta   X4D15
      lda   X1E23
      sta   X4D14
      ldd   #0
      std   X4D19
      jsr   X72C3
      fcc   "Firing deck gun, Sir"
      fcb   C$NULL
      ldd   #$3C02
      ldy   #$0E10
L1AF6 lbsr  L1B00
      leay  -2,y
      suba  #$0A
      bne   L1AF6
L1AFF rts

   
L1B00 pshs  a,b,x,y,u
      tfr   d,x
      ldd   #$0198
      os9   I$SetStt
      puls  a,b,x,y,u,pc
      
      
L1B0C lda   D000D,u
      bne   L1B21
      ldd   D000E,u
      cmpd  #$3A98
      bhi   L1B21
      ldu   #$03E8
      jsr   X76B9
      incb  
      clra  
      rts 
      
        
L1B21 lda   #1
      ldb   #$10
      rts  
      
       
L1B26 ldy   #0
      clrb  
L1B2B lbsr  L1B47
      incb  
      cmpb  X4CCC
      bcs   L1B2B
      ldy   #1
L1B38 lbsr  L1B47
      incb  
      tfr   b,a
      suba  X4CCC
      cmpa  X4CCD
      bcs   L1B38
      rts
      
         
L1B47 pshs  a,b,x,y,u
      clra  
      tfr   d,x
      lda   19717,x
      lble  L1BBD
      ldu   X1E1E
      cmpu  #$001E
      bcc   L1B6B
      suba  X1E1F
      cmpa  #1
      blt   L1B6B
      sta   19717,x
      lbra  L1BBD
L1B6B lda   19713,y
      cmpa  19711,y
      blt   L1B7D
      lda   #$FF
      sta   19717,x
      bra   L1BBD
L1B7D clr   19717,x
      jsr   X723C
      jsr   X72F3
      fcc   "Tube "
      fcb   C$NULL
      tfr   x,d
      addd  #1
      jsr   X7304
      jsr   X72F3
      fcc   " has been reloaded, Sir"
      fcb   C$NULL
      jsr   X7228
      inc   19713,y
      jsr   X7843
      jsr   X7866
L1BBD puls  a,b,x,y,u,pc


L1BBF lda   X4D0F
      lbeq  L1C33
      ldu   X1E1E
      cmpu  #$0258
      bcc   L1BDA
      suba  X1E1F
      cmpa  #1
      blt   L1BDA
      sta   X4D14
      rts
      
         
L1BDA clr   X4D0F
      jsr   X72C3
      fcc   "Torpedo transfered, Sir"
      fcb   C$NULL
      lda   X4D10
      bne   L1C12
      inc   X4CFF
      jsr   X7843
      ldx   #$4D05
      clra  
L1C07 ldb   a,x
      ble   L1C2E
      inca  
      cmpa  X4CCC
      bcs   L1C07
      rts
      
         
L1C12 inc   X4D00
      jsr   X7866
      ldx   #$4D05
      lda   X4CCC
L1C1E ldb   a,x
      ble   L1C2E
      inca  
      tfr   a,b
      subb  X4CCC
      cmpb  X4CCD
      bcs   L1C1E
      rts
      
         
L1C2E ldb   X1E23
      stb   a,x
L1C33 rts

   
L1C34 pshs  a,b,x,y,u
      lda   X0125
      beq   L1C4C
      ldd   #$0730
      subd  X0120
      lsra  
      rorb  
      lsra  
      rorb  
      lsra  
      rorb  
      lsra  
      rorb  
      stb   X0124
L1C4C lda   X4D2C
      beq   L1C84
      ldd   X0120
      cmpd  X0122
      bls   L1C84
      jsr   X72C3
      fcc   "We are still aground, Sir!"
      fcb   C$NULL
      ldd   #0
      jsr   X7A3A
      ldd   #0
      jsr   X7A68
L1C84 ldu   X4CF3
      ldd   X4CF1
      ldy   #$4C84
      lbsr  L1E1D
      ldd   X4CF1
      beq   L1CBB
      ldd   X4CFB
      subd  X4CF3
      beq   L1CBB
      jsr   X765F
      ldu   #2
      tst   X4D30
      beq   L1CAC
      ldu   #1
L1CAC lbsr  L1DD0
      cmpd  #0
      beq   L1CBB
      addd  X4CF3
      jsr   X7A23
L1CBB lda   X4D28
      bne   L1CD5
      lda   X4CD2
      tst   X4D2A
      beq   L1CC9
      lsra  
L1CC9 ldb   X4CD3
      ldy   #$4D38
      tst   X4D1D
      bra   L1CE2
L1CD5 lda   X4CD0
      ldb   X4CD1
      ldy   #$4D2F
      tst   X4D1B
L1CE2 bne   L1CE6
      clra  
      clrb  
L1CE6 tst   ,y
      beq   L1CFE
      tst   X4C77
      beq   L1CF3
      clra  
      clrb  
      bra   L1CFE
L1CF3 tst   ,y
      bmi   L1CFA
      lsra  
      bra   L1CFE
L1CFA lda   #1
      ldb   #1
L1CFE sta   X1DDA
      negb  
      stb   X1DDB
      ldb   X4CFA
      cmpb  X1DDA
      ble   L1D10
      ldb   X1DDA
L1D10 cmpb  X1DDB
      bge   L1D18
      ldb   X1DDB
L1D18 sex   
      subd  X4CF1
      lbeq  L1D2C
      ldu   #2
      lbsr  L1DD0
      addd  X4CF1
      jsr   X7A3A
L1D2C lda   X4CCA
      beq   L1D55
      ldu   X1E1E
      cmpu  #$001E
      bcc   L1D47
      suba  X1E1F
      cmpa  #1
      blt   L1D47
      sta   X4CCA
      lbra  L1DCE
L1D47 clr   X4CCA
      lda   X4D28
      beq   L1D55
      ldd   #$020C
      lbsr  L049E
L1D55 ldd   X4CF7
      subd  X4CEF
      lbeq  L1DCE
      ldu   #2
      lbsr  L1DD0
      addd  X4CEF
      pshs  a,b
      jsr   X7A89
      ldd   ,s
      cmpd  #$001E
      blt   L1D8C
      lda   X1D43
      cmpa  #1
      bne   L1D82
      ldd   #$0516
      lbsr  L049E
L1D82 cmpa  #2
      bne   L1D8C
      ldd   #$0516
      lbsr  L049E
L1D8C ldb   X4CD9
      lda   #6
      mul   
      cmpd  ,s
      bcs   L1DA1
      subd  #$0064
      cmpd  ,s
      bls   L1DAB
      bra   L1DCC
L1DA1 puls  a,b
      ldd   #$0514
      lbsr  L049E
      puls  a,b,x,y,u,pc
      
      
L1DAB ldb   #$0F
      jsr   X7691
      tstb  
      bne   L1DCC
      jsr   X72C3
      fcc   "We are too deep, Sir!"
      fcb   C$NULL
L1DCC puls  a,b
L1DCE puls  a,b,x,y,u,pc


L1DD0 pshs  u
      clr   X1DF5
      cmpd  #0
      bpl   L1DE3
      inc   X1DF5
      coma  
      comb  
      addd  #1
L1DE3 std   X1DDA
      tfr   u,d
      stb   X1DDC
      lda   X1E1F
      mul   
      std   X1DF0
      clr   X1DEF
      ldb   X1DDC
      lda   X1E1E
      mul   
      addd  X1DEF
      std   X1DEF
      tsta  
      bne   L1E0E
      ldd   X1DF0
      cmpd  X1DDA
      bcs   L1E11
L1E0E ldd   X1DDA
L1E11 tst   X1DF5
      beq   L1E1B
      coma  
      comb  
      addd  #1
L1E1B puls  u,pc


L1E1D pshs  a,b,x,y,u
      cmpd  #0
      ble   L1E2A
      lsra  
      rorb  
      lsra  
      rorb  
      incb  
L1E2A stu   X1E02
      clr   X1DF5
      cmpd  #0
      bpl   L1E3E
      inc   X1DF5
      coma  
      comb  
      addd  #1
L1E3E std   X1DDA
      lda   X1E1F
      mul   
      std   X1DF0
      clr   X1DEF
      lda   X1DDA
      ldb   X1E1F
      mul   
      addd  X1DEF
      std   X1DEF
      lda   X1DDB
      ldb   X1E1E
      mul   
      addd  X1DEF
      std   X1DEF
      lda   X1DDA
      ldb   X1E1E
      mul   
      addb  X1DEF
      stb   X1DEF
      ldd   X1E02
      jsr   X7718
      jsr   X7604
      ldd   1,y
      addd  X1DF3
      std   1,y
      lda   ,y
      adca  X1DF2
      sta   ,y
      ldd   X1E02
      jsr   X7720
      jsr   X7604
      ldd   4,y
      addd  X1DF3
      std   4,y
      lda   3,y
      adca  X1DF2
      sta   3,y
      puls  a,b,x,y,u,pc
      
      
L1EA2 lda   #$74
      sta   X1E13
      ldx   #$42B5
L1EAA fdb   Zlda_x       lda 0,x
      lbmi  L1F4F
      cmpa  #$64
      lblo  L1F35
      adda  X1E22
      fdb    Zsta_x      sta 0,x
      lbpl  L1F35
      jsr   X723C
      cmpx  #$480A
      bcc   L1F07
      jsr   X72F3
      fcc   "We sunk that "
      fcb   C$NULL
      lda   18,x
      lbsr  L0854
      jsr   X72F3
      fcc   ", Sir!"
      fcb   C$NULL
      ldu   #$0360
      lda   X04F7
      ldb   #4
      mul   
      leau  d,u
      lda   X1E16
      sta   ,u
      ldd   X1E17
      std   D0001,u
      lda   18,x
      sta   D0003,u
      inc   X04F7
      bra   L1F32
L1F07 jsr   X72F3
      fcc   "We shot down that "
      fcb   C$NULL
      lda   18,x
      bne   L1F27
      inc   X04F9
      bra   L1F2A
L1F27 inc   X04F8
L1F2A lbsr  L0869
      ldb   #$21
      jsr   X7477
L1F32 jsr   X7228
L1F35 ldu   9,x
      ldd   1,x
      leay  3,x
      lbsr  L1E1D
      leay  3,x
      ldu   #$4C84
      jsr   X74D9
      sta   13,x
      stu   14,x
      jsr   X7556
      std   11,x
L1F4F leax  21,x
      dec   X1E13
      lbpl  L1EAA
      rts
      
         
L1F5A std   X4CFB
      lsra  
      rorb  
      lsra  
      rorb  
      lsra  
      rorb  
      lda   #1
      sta   X02A4
      jmp   X7889
L1F6B fcb   $01,$02,$01,$01,$03,$04
      fcb   $02,$02,$01,$01,$01
L1F76 fcc   "sub/sub6"
      fcb   C$NULL
L1F7F fcc   "sub/radar.dat"
      fcb   C$NULL
L1F8D fcc   "sub/status.dat"
      fcb   C$NULL
L1F9C fcc   "sub/stitle.pic"
      fcb   C$NULL
L1FAB fcc   "sub1"
      fcb   C$NULL
L1FB0 fcc   "sub2"
      fcb   C$NULL
L1FB5 fcc   "sub3"
      fcb   C$NULL
L1FBA fcc   "sub4"
      fcb   C$NULL
L1FBF fcc   "sub5"
      fcb   C$NULL
L1FC4 fcc   "shell"
      fcb   C$NULL

      emod 
eom
L1FCD equ *

      end
