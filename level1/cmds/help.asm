********************************************************************
* help - Show help for commands
*
* $Id$
*
* Ed.    Comments                                       Who YY/MM/DD
* ------------------------------------------------------------------
*   5    From Tandy OS-9 Level Two Vr. 2.00.01

         nam   help
         ttl   Show help for commands

* Disassembled 02/07/23 22:09:55 by Disasm v1.6 (C) 1988 by RML

         ifp1
         use   defsfile
         endc

tylg     set   Prgrm+Objct   
atrv     set   ReEnt+rev
rev      set   $01
edition  set   5

L0000    mod   eom,name,tylg,atrv,start,size

         org   0
u0000    rmb   1
u0001    rmb   1
u0002    rmb   1
u0003    rmb   1
u0004    rmb   1
u0005    rmb   1
u0006    rmb   2
u0008    rmb   2
u000A    rmb   1
u000B    rmb   2
u000D    rmb   4
u0011    rmb   15
u0020    rmb   14
u002E    rmb   1
u002F    rmb   38
u0055    rmb   14
u0063    rmb   5
u0068    rmb   10
u0072    rmb   123
u00ED    rmb   2
u00EF    rmb   2
u00F1    rmb   2
u00F3    rmb   2
u00F5    rmb   2
u00F7    rmb   2
u00F9    rmb   2
u00FB    rmb   2
u00FD    rmb   2
u00FF    rmb   337
u0250    rmb   2
u0252    rmb   58
u028C    rmb   1
u028D    rmb   3
u0290    rmb   6036
size     equ   .

name     fcs   /help/
         fcb   edition

L0012    fcb   $A6 &
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
L0021    sta   ,u+
         decb  
         bne   L0021
         ldx   ,s
         leau  ,x
         leax  >$02A4,x
         pshs  x
         leay  >L15AA,pcr
         ldx   ,y++
         beq   L003C
         bsr   L0012
         ldu   $02,s
L003C    leau  >u00FF,u
         ldx   ,y++
         beq   L0047
         bsr   L0012
         clra  
L0047    cmpu  ,s
         beq   L0050
         sta   ,u+
         bra   L0047
L0050    ldu   $02,s
         ldd   ,y++
         beq   L005D
         leax  >L0000,pcr
         lbsr  L0160
L005D    ldd   ,y++
         beq   L0066
         leax  ,u
         lbsr  L0160
L0066    leas  $04,s
         puls  x
         stx   >u0290,u
         sty   >u0250,u
         ldd   #$0001
         std   >u028C,u
         leay  >u0252,u
         leax  ,s
         lda   ,x+
L0082    ldb   >u028D,u
         cmpb  #$1D
         beq   L00DE
L008A    cmpa  #$0D
         beq   L00DE
         cmpa  #$20
         beq   L0096
         cmpa  #$2C
         bne   L009A
L0096    lda   ,x+
         bra   L008A
L009A    cmpa  #$22
         beq   L00A2
         cmpa  #$27
         bne   L00C0
L00A2    stx   ,y++
         inc   >u028D,u
         pshs  a
L00AA    lda   ,x+
         cmpa  #$0D
         beq   L00B4
         cmpa  ,s
         bne   L00AA
L00B4    puls  b
         clr   -$01,x
         cmpa  #$0D
         beq   L00DE
         lda   ,x+
         bra   L0082
L00C0    leax  -$01,x
         stx   ,y++
         leax  $01,x
         inc   >u028D,u
L00CA    cmpa  #$0D
         beq   L00DA
         cmpa  #$20
         beq   L00DA
         cmpa  #$2C
         beq   L00DA
         lda   ,x+
         bra   L00CA
L00DA    clr   -$01,x
         bra   L0082
L00DE    leax  >u0250,u
         pshs  x
         ldd   >u028C,u
         pshs  b,a
         leay  ,u
         bsr   L00F8
         lbsr  L018C
         clr   ,-s
         clr   ,-s
         lbsr  L159E
L00F8    leax  >$02A4,y
         stx   >$029A,y
         sts   >$028E,y
         sts   >$029C,y
         ldd   #$FF82
L010D    leax  d,s
         cmpx  >$029C,y
         bcc   L011F
         cmpx  >$029A,y
         bcs   L0139
         stx   >$029C,y
L011F    rts   
L0120    fcc   "**** STACK OVERFLOW ****"
         fcb   C$CR

L0139    leax  <L0120,pcr
         ldb   #$CF
         pshs  b
         lda   #$02
         ldy   #$0064
L0146    os9   I$WritLn 
         clr   ,-s
         lbsr  L15A4
L014E    ldd   >$028E,y
         subd  >$029C,y
         rts   
         ldd   >$029C,y
         subd  >$029A,y
L015F    rts   
L0160    pshs  x
         leax  d,y
         leax  d,x
         pshs  x
L0168    ldd   ,y++
         leax  d,u
         ldd   ,x
         addd  $02,s
         std   ,x
         cmpy  ,s
         bne   L0168
         leas  $04,s
L0179    rts   
L017A    pshs  u
         ldd   #$FFBA
         lbsr  L010D
         clra  
         clrb  
         pshs  b,a
         lbsr  L159E
         lbra  L0719
L018C    pshs  u
         ldd   #$FFB6
         lbsr  L010D
         leas  -$02,s
         leax  >L017A,pcr
         pshs  x
         lbsr  L156E
         leas  $02,s
         ldd   #$0080
         pshs  b,a
         ldd   #$0001
         pshs  b,a
         lbsr  L0884
         leas  $04,s
         leax  >L077F,pcr
         pshs  x
         leax  >L076F,pcr
         pshs  x
         lbsr  L09E6
         leas  $04,s
         std   <u0001
         bne   L01D0
         leax  >L0781,pcr
         pshs  x
         lbsr  L04B7
         leas  $02,s
L01D0    ldd   #$1000
         ldx   <u0001
         std   $0B,x
         clra  
         clrb  
         std   <u00FD
         ldd   $06,s
         cmpd  #$0001
         lbne  L02D5
         clra  
         clrb  
         std   <u00F3
         leax  >$010C,y
         pshs  x
         leax  >L079C,pcr
         pshs  x
         lbsr  L0A38
         leas  $04,s
L01FA    clra  
         clrb  
         std   <u00FB
         std   <u00FD
         leax  >$010C,y
         pshs  x
         leax  >L07AE,pcr
         pshs  x
         lbsr  L0A5A
         leas  $04,s
         leax  >$0005,y
         pshs  x
         lbsr  L0A7A
         std   ,s++
         lbeq  L028C
         leax  >$0005,y
         stx   ,s
         leau  ,x
         ldb   ,u
         cmpb  #$3F
         beq   L0232
         ldb   ,u
         bne   L0238
L0232    lbsr  L0502
         lbra  L0293
L0238    ldb   ,u
         cmpb  #$20
         lbeq  L0293
         bra   L0286
L0242    leau  u0001,u
L0244    ldb   ,u
         cmpb  #$20
         beq   L024E
         ldb   ,u
         bne   L0242
L024E    ldb   ,u
         cmpb  #$20
         bne   L0273
         ldd   <u00FD
         addd  #$0001
         std   <u00FD
         clra  
         clrb  
         stb   ,u
         ldd   ,s
         pshs  b,a
         lbsr  L02E8
         leas  $02,s
         lbsr  L04E9
         leau  u0001,u
         tfr   u,d
         std   ,s
         bra   L0286
L0273    ldd   ,s
         pshs  b,a
         lbsr  L02E8
         leas  $02,s
         lbsr  L04E9
         ldd   <u00FB
         addd  #$0001
         std   <u00FB
L0286    ldd   <u00FB
         beq   L0244
         bra   L0293
L028C    ldd   <u00F3
         addd  #$0001
         std   <u00F3
L0293    ldd   <u00F3
         lbeq  L01FA
         bra   L02DE
L029B    ldd   $06,s
         cmpd  #$0001
         ble   L02AA
         ldd   <u00FD
         addd  #$0001
         std   <u00FD
L02AA    ldx   $08,s
         leax  $02,x
         stx   $08,s
         ldb   [,x]
         cmpb  #$2D
         bne   L02CC
         ldx   [<$08,s]
         ldb   $01,x
         cmpb  #$3F
         bne   L02C4
         lbsr  L0502
         bra   L02D5
L02C4    leax  >L07C0,pcr
         pshs  x
         bra   L02D1
L02CC    ldd   [<$08,s]
         pshs  b,a
L02D1    bsr   L02E8
         leas  $02,s
L02D5    ldd   $06,s
         addd  #$FFFF
         std   $06,s
         bne   L029B
L02DE    ldd   <u0001
         pshs  b,a
         lbsr  L0DF5
         lbra  L04B0
L02E8    pshs  u
         ldd   #$FFB2
         lbsr  L010D
         leas  -$02,s
         leax  >L07C5,pcr
         pshs  x
         leax  >$00A5,y
         pshs  x
         lbsr  L1143
         leas  $04,s
         ldd   $06,s
         pshs  b,a
         leax  >$00A5,y
         pshs  x
         lbsr  L115B
         leas  $04,s
         leax  >L07CE,pcr
         pshs  x
         leax  >$00A5,y
         pshs  x
         lbsr  L115B
         leas  $04,s
         leax  >L07D2,pcr
         pshs  x
         leax  >$00A5,y
         pshs  x
         lbsr  L09E6
         leas  $04,s
         std   <u0003
         beq   L0347
         lbsr  L0731
         ldd   <u0003
         pshs  b,a
         lbsr  L13BA
         leas  $02,s
         lbra  L0719
L0347    clra  
         clrb  
         std   <u00F9
         clra  
         clrb  
         pshs  b,a
         clra  
         clrb  
         pshs  b,a
         pshs  b,a
         ldd   <u0001
         pshs  b,a
         lbsr  L0B44
         leas  $08,s
         cmpd  #$FFFF
         lbne  L0463
         leax  >L07D4,pcr
         lbra  L045C
L036D    ldu   $06,s
         leax  >$0055,y
         stx   ,s
         clra  
         clrb  
         std   <u00F5
         ldd   #$0040
         ldx   ,s
         leax  $01,x
         stx   ,s
         stb   -$01,x
         lbeq  L0463
         bra   L03B0
L038A    ldb   ,u+
         sex   
         pshs  b,a
         lbsr  L0F1B
         std   ,s
         ldx   $02,s
         leax  $01,x
         stx   $02,s
         ldb   -$01,x
         sex   
         pshs  b,a
         lbsr  L0F1B
         leas  $02,s
         cmpd  ,s++
         beq   L03B0
         ldd   <u00F5
         addd  #$0001
         std   <u00F5
L03B0    ldb   ,u
         beq   L03B8
         ldd   <u00F5
         beq   L038A
L03B8    ldb   [,s]
         cmpb  #$0D
         beq   L03C5
         ldd   <u00F5
         addd  #$0001
         std   <u00F5
L03C5    ldd   <u00F5
         lbne  L0463
         ldd   <u00F9
         addd  #$0001
         std   <u00F9
         clra  
         clrb  
         std   <u00F7
         ldd   <u00FD
         beq   L042F
         ldu   $06,s
         bra   L03F5
L03DE    leax  >$010C,y
         pshs  x
         ldb   ,u
         sex   
         pshs  b,a
         lbsr  L0F1B
         std   ,s
         lbsr  L0D04
         leas  $04,s
         leau  u0001,u
L03F5    ldb   ,u
         bne   L03DE
         leax  >$010C,y
         pshs  x
         leax  >L07EA,pcr
         pshs  x
         lbsr  L0A5A
         leas  $04,s
         lbsr  L04E9
         bra   L042F
L040F    ldb   <u0055
         cmpb  #$40
         beq   L0428
         leax  >$010C,y
         pshs  x
         leax  >$0055,y
         pshs  x
         lbsr  L0A5A
         leas  $04,s
         bra   L042F
L0428    ldd   <u00F7
         addd  #$0001
         std   <u00F7
L042F    ldd   <u0001
         pshs  b,a
         ldd   #$0050
         pshs  b,a
         leax  >$0055,y
         pshs  x
         lbsr  L0AB5
         leas  $06,s
         std   -$02,s
         beq   L044B
         ldd   <u00F7
         beq   L040F
L044B    ldd   <u00F7
         bne   L0463
         ldx   <u0001
         ldd   $06,x
         clra  
         andb  #$20
         beq   L0463
         leax  >L07ED,pcr
L045C    pshs  x
         lbsr  L04B7
         leas  $02,s
L0463    ldd   <u0001
         pshs  b,a
         ldd   #$0050
         pshs  b,a
         leax  >$0055,y
         pshs  x
         lbsr  L0AB5
         leas  $06,s
         std   -$02,s
         beq   L0481
         ldd   <u00F9
         lbeq  L036D
L0481    ldd   <u00F9
         bne   L04B2
         ldx   <u0001
         ldd   $06,x
         clra  
         andb  #$20
         beq   L0498
         leax  >L0805,pcr
         pshs  x
         bsr   L04B7
         leas  $02,s
L0498    leax  >$010C,y
         pshs  x
         ldd   $08,s
         pshs  b,a
         lbsr  L0A5A
         leas  $04,s
         leax  >L081D,pcr
         pshs  x
         lbsr  L0A38
L04B0    leas  $02,s
L04B2    bsr   L04E9
         lbra  L0719
L04B7    pshs  u
         ldd   #$FFB8
         lbsr  L010D
         leax  >$0119,y
         pshs  x
         leax  >L0831,pcr
         pshs  x
         lbsr  L0A5A
         leas  $04,s
         leax  >$0119,y
         pshs  x
         ldd   $06,s
         pshs  b,a
         lbsr  L0A5A
         leas  $04,s
         clra  
         clrb  
         pshs  b,a
         lbsr  L159E
         lbra  L0719
L04E9    pshs  u
         ldd   #$FFB8
         lbsr  L010D
         leax  >$010C,y
         pshs  x
         ldd   #$000D
         pshs  b,a
         lbsr  L0D04
         lbra  L06BA
L0502    pshs  u
         ldd   #$FFB0
         lbsr  L010D
         leas  -$04,s
         leax  >L0838,pcr
         pshs  x
         lbsr  L0A38
         leas  $02,s
         lbsr  L071D
         std   <u00EF
         ldd   <u00EF
         pshs  b,a
         ldd   #$000A
         lbsr  L1294
         std   <u00EF
         clra  
         clrb  
         pshs  b,a
         clra  
         clrb  
         pshs  b,a
         pshs  b,a
         ldd   <u0001
         pshs  b,a
         lbsr  L0B44
         leas  $08,s
         cmpd  #$FFFF
         lbne  L05CF
         leax  >L084C,pcr
         pshs  x
         lbsr  L04B7
         leas  $02,s
         lbra  L05CF
L0551    ldb   <u0005
         cmpb  #$40
         lbne  L05D3
         leau  >$0005,y
         leax  >$00C3,y
         stx   $02,s
         clra  
         clrb  
         std   <u00ED
         bra   L057D
L0569    ldb   ,u
         ldx   $02,s
         leax  $01,x
         stx   $02,s
         stb   -$01,x
         ldd   <u00ED
         addd  #$0001
         std   <u00ED
         subd  #$0001
L057D    leau  u0001,u
         ldb   ,u
         cmpb  #$20
         bgt   L0569
         clra  
         clrb  
         stb   [<$02,s]
         leax  >$010C,y
         pshs  x
         leax  >$00C3,y
         pshs  x
         lbsr  L0A5A
         leas  $04,s
         ldd   <u00F1
         addd  #$0001
         std   <u00F1
         cmpd  <u00EF
         bge   L05CC
         ldd   <u00ED
         bra   L05C0
L05AB    leax  >$010C,y
         pshs  x
         ldd   #$0020
         pshs  b,a
         lbsr  L0D04
         leas  $04,s
         ldd   ,s
         addd  #$0001
L05C0    std   ,s
         ldd   ,s
         cmpd  #$000A
         blt   L05AB
         bra   L05D3
L05CC    lbsr  L04E9
L05CF    clra  
         clrb  
         std   <u00F1
L05D3    ldd   <u0001
         pshs  b,a
         ldd   #$0050
         pshs  b,a
         leax  >$0005,y
         pshs  x
         lbsr  L0AB5
         leas  $06,s
         std   -$02,s
         lbne  L0551
         ldx   <u0001
         ldd   $06,x
         clra  
         andb  #$20
         beq   L0601
         leax  >L0862,pcr
         pshs  x
         lbsr  L04B7
         leas  $02,s
L0601    leax  >L0882,pcr
         pshs  x
         leax  >L087A,pcr
         pshs  x
         lbsr  L09E6
         leas  $04,s
         std   <u0003
         lbeq  L06B4
         lbra  L068C
L061B    leax  >$00CD,y
         pshs  x
         lbsr  L06BE
         std   ,s++
         lbeq  L068C
         leau  >$00CD,y
         clra  
         clrb  
         std   <u00ED
         bra   L0653
L0634    leax  >$010C,y
         pshs  x
         ldb   ,u+
         sex   
         pshs  b,a
         lbsr  L0F1B
         std   ,s
         lbsr  L0D04
         leas  $04,s
         ldd   <u00ED
         addd  #$0001
         std   <u00ED
         subd  #$0001
L0653    ldb   ,u
         cmpb  #$2E
         bne   L0634
         ldd   <u00F1
         cmpd  <u00EF
         bge   L0685
         ldd   <u00ED
         bra   L0679
L0664    leax  >$010C,y
         pshs  x
         ldd   #$0020
         pshs  b,a
         lbsr  L0D04
         leas  $04,s
         ldd   ,s
         addd  #$0001
L0679    std   ,s
         ldd   ,s
         cmpd  #$000A
         blt   L0664
         bra   L068C
L0685    lbsr  L04E9
         clra  
         clrb  
         std   <u00F1
L068C    ldd   <u0003
         pshs  b,a
         ldd   #$0001
         pshs  b,a
         ldd   #$0020
         pshs  b,a
         leax  >$00CD,y
         pshs  x
         lbsr  L0AFE
         leas  $08,s
         std   -$02,s
         lbne  L061B
         ldd   <u0003
         pshs  b,a
         lbsr  L13BA
         leas  $02,s
L06B4    lbsr  L04E9
         lbsr  L04E9
L06BA    leas  $04,s
         puls  pc,u
L06BE    pshs  u
         ldd   #$FFBE
         lbsr  L010D
         leas  -$02,s
         clra  
         clrb  
         std   ,s
         ldb   [<$06,s]
         beq   L0717
         ldu   $06,s
         bra   L06D7
L06D5    leau  u0001,u
L06D7    ldb   ,u
         cmpb  #$2E
         bne   L06D5
         ldb   ,u
         lbeq  L06D5
         ldb   ,u
         cmpb  #$7E
         lbgt  L06D5
         ldb   ,u+
         cmpb  #$2E
         bne   L0717
         ldb   ,u
         cmpb  #$68
         beq   L06FD
         ldb   ,u
         cmpb  #$48
         bne   L0717
L06FD    leau  u0001,u
         ldb   ,u
         clra  
         andb  #$7F
         stb   ,u
         cmpb  #$70
         beq   L0710
         ldb   ,u
         cmpb  #$50
         bne   L0717
L0710    ldd   ,s
         addd  #$0001
         std   ,s
L0717    ldd   ,s
L0719    leas  $02,s
         puls  pc,u
L071D    pshs  y,x
         lda   #$01
         ldb   #$26
         os9   I$GetStt 
         bcc   L072D
         ldd   #$0050
         bra   L072F
L072D    tfr   x,d
L072F    puls  pc,y,x
L0731    pshs  u
         ldd   #$FFB6
         lbsr  L010D
         bra   L0752
L073B    ldb   <u0005
         cmpb  #$40
         beq   L0752
         leax  >$010C,y
         pshs  x
         leax  >$0005,y
         pshs  x
         lbsr  L0A5A
         leas  $04,s
L0752    ldd   <u0003
         pshs  b,a
         ldd   #$0050
         pshs  b,a
         leax  >$0005,y
         pshs  x
         lbsr  L0AB5
         leas  $06,s
         std   -$02,s
         bne   L073B
         lbsr  L04E9
         puls  pc,u

L076F    fcc   "/dd/sys/helpmsg"
         fcb   $00
L077F    fcc   "r"
         fcb   $00
L0781    fcc   "can't open /dd/sys/helpmsg"
         fcb   $00
L079C    fcc   "Hit [ESC] to exit"
         fcb   $00
L07AE    fcc   "What Subject(s)? "
         fcb   $00
L07C0    fcc   "help"
         fcb   $00
L07C5    fcc   "/dd/sys/"
         fcb   $00
L07CE    fcc   ".hp"
         fcb   $00
L07D2    fcc   "r"
         fcb   $00
L07D4    fcc   "can't reset help file"
         fcb   $00
L07EA    fcc   " -"
         fcb   $00
L07ED    fcc   "error reading help file"
         fcb   $00
L0805    fcc   "error reading help file"
         fcb   $00
L081D    fcc   ": no help available"
         fcb   $00
L0831    fcc   "help: "
         fcb   $00
L0838    fcc   "Help available on: "
         fcb   $00
L084C    fcc   "can't reset help file"
         fcb   $00
L0862    fcc   "error reading help file"
         fcb   $00
L087A    fcc   "/dd/sys"
         fcb   $00
L0882    fcc   "d"
         fcb   $00
L0884    lda   $03,s
         ldb   #$8A
         ldx   $04,s
         os9   I$SetStt 
         lbra  L1599
L0890    pshs  u
         leau  >$00FF,y
L0896    ldd   u0006,u
         clra  
         andb  #$03
         lbeq  L0907
L089F    leau  u000D,u
         pshs  u
         leax  >$01CF,y
         cmpx  ,s++
         bhi   L0896
         ldd   #$00C8
         std   >$029E,y
         lbra  L090B
         puls  pc,u
L08B7    pshs  u
         ldu   $08,s
         bne   L08C1
         bsr   L0890
         tfr   d,u
L08C1    stu   -$02,s
         beq   L090B
         ldd   $04,s
         std   u0008,u
         ldx   $06,s
         ldb   $01,x
         cmpb  #$2B
         beq   L08D9
         ldx   $06,s
         ldb   $02,x
         cmpb  #$2B
         bne   L08DF
L08D9    ldd   u0006,u
L08DB    orb   #$03
         bra   L08FD
L08DF    ldd   u0006,u
         pshs  b,a
         ldb   [<$08,s]
         cmpb  #$72
         beq   L08F1
         ldb   [<$08,s]
         cmpb  #$64
         bne   L08F6
L08F1    ldd   #$0001
         bra   L08F9
L08F6    ldd   #$0002
L08F9    ora   ,s+
         orb   ,s+
L08FD    std   u0006,u
         ldd   u0002,u
         addd  u000B,u
         std   u0004,u
         std   ,u
L0907    tfr   u,d
         puls  pc,u
L090B    clra  
         clrb  
         puls  pc,u
L090F    pshs  u
         ldu   $04,s
         leas  -$04,s
         clra  
         clrb  
         std   ,s
         ldx   $0A,s
         ldb   $01,x
         sex   
         tfr   d,x
         bra   L0940
L0922    ldx   $0A,s
         ldb   $02,x
         cmpb  #$2B
         bne   L092F
         ldd   #$0007
         bra   L0937
L092F    ldd   #$0004
         bra   L0937
L0934    ldd   #$0003
L0937    std   ,s
         bra   L0950
L093B    leax  $04,s
         lbra  L09A8
L0940    stx   -$02,s
         beq   L0950
         cmpx  #$0078
         beq   L0922
         cmpx  #$002B
         beq   L0934
         bra   L093B
L0950    ldb   [<$0A,s]
         sex   
         tfr   d,x
         lbra  L09B5
L0959    ldd   ,s
         orb   #$01
         bra   L099B
L095F    ldd   ,s
         orb   #$02
         pshs  b,a
         pshs  u
         lbsr  L13AB
         leas  $04,s
         std   $02,s
         cmpd  #$FFFF
         beq   L098A
         ldd   #$0002
         pshs  b,a
         clra  
         clrb  
         pshs  b,a
         pshs  b,a
         ldd   $08,s
         pshs  b,a
         lbsr  L1481
         leas  $08,s
         bra   L09CF
L098A    ldd   ,s
         orb   #$02
         pshs  b,a
         pshs  u
         lbsr  L13CC
         bra   L09A2
L0997    ldd   ,s
         orb   #$81
L099B    pshs  b,a
         pshs  u
         lbsr  L13AB
L09A2    leas  $04,s
         std   $02,s
         bra   L09CF
L09A8    leas  -$04,x
L09AA    ldd   #$00CB
         std   >$029E,y
         clra  
         clrb  
         bra   L09D1
L09B5    cmpx  #$0072
         lbeq  L0959
         cmpx  #$0061
         lbeq  L095F
         cmpx  #$0077
         beq   L098A
         cmpx  #$0064
         beq   L0997
         bra   L09AA
L09CF    ldd   $02,s
L09D1    leas  $04,s
         puls  pc,u
         pshs  u
         clra  
         clrb  
         pshs  b,a
         ldd   $08,s
         pshs  b,a
         ldd   $08,s
         pshs  b,a
         lbra  L0A31
L09E6    pshs  u
         ldd   $06,s
         pshs  b,a
         ldd   $06,s
         pshs  b,a
         lbsr  L090F
         leas  $04,s
         tfr   d,u
         cmpu  #$FFFF
         bne   L0A01
         clra  
         clrb  
         bra   L0A36
L0A01    clra  
         clrb  
         bra   L0A29
         pshs  u
         ldd   $08,s
         pshs  b,a
         lbsr  L0DF5
         leas  $02,s
         ldd   $06,s
         pshs  b,a
         ldd   $06,s
         pshs  b,a
         lbsr  L090F
         leas  $04,s
         tfr   d,u
         stu   -$02,s
         bge   L0A27
         clra  
         clrb  
         bra   L0A36
L0A27    ldd   $08,s
L0A29    pshs  b,a
         ldd   $08,s
         pshs  b,a
         pshs  u
L0A31    lbsr  L08B7
         leas  $06,s
L0A36    puls  pc,u
L0A38    pshs  u
         leax  >$010C,y
         pshs  x
         ldd   $06,s
         pshs  b,a
         bsr   L0A5A
         leas  $04,s
         leax  >$010C,y
         pshs  x
         ldd   #$000D
         pshs  b,a
         lbsr  L0D04
         leas  $04,s
         puls  pc,u
L0A5A    pshs  u
         ldu   $04,s
         leas  -$01,s
         bra   L0A70
L0A62    ldd   $07,s
         pshs  b,a
         ldb   $02,s
         sex   
         pshs  b,a
         lbsr  L0D04
         leas  $04,s
L0A70    ldb   ,u+
         stb   ,s
         bne   L0A62
         leas  $01,s
         puls  pc,u
L0A7A    pshs  u,b,a
         ldu   $06,s
         bra   L0A84
L0A80    ldd   ,s
         stb   ,u+
L0A84    leax  >$00FF,y
         pshs  x
         lbsr  L0F4E
         leas  $02,s
         std   ,s
         cmpd  #$000D
         beq   L0A9F
         ldd   ,s
         cmpd  #$FFFF
         bne   L0A80
L0A9F    ldd   ,s
         cmpd  #$FFFF
         bne   L0AAB
         clra  
         clrb  
         bra   L0AB1
L0AAB    clra  
         clrb  
         stb   ,u
         ldd   $06,s
L0AB1    leas  $02,s
         puls  pc,u
L0AB5    pshs  u
         ldu   $06,s
         leas  -$04,s
         ldd   $08,s
         std   ,s
         bra   L0ACF
L0AC1    ldd   $02,s
         ldx   ,s
         leax  $01,x
         stx   ,s
         stb   -$01,x
         cmpb  #$0D
         beq   L0AE8
L0ACF    tfr   u,d
         leau  -u0001,u
         std   -$02,s
         ble   L0AE8
         ldd   $0C,s
         pshs  b,a
         lbsr  L0F4E
         leas  $02,s
         std   $02,s
         cmpd  #$FFFF
         bne   L0AC1
L0AE8    clra  
         clrb  
         stb   [,s]
         ldd   $02,s
         cmpd  #$FFFF
         bne   L0AF8
         clra  
         clrb  
         bra   L0AFA
L0AF8    ldd   $08,s
L0AFA    leas  $04,s
         puls  pc,u
L0AFE    pshs  u
         ldu   $04,s
         leas  -$06,s
         clra  
         clrb  
         bra   L0B35
L0B08    ldd   $0C,s
         std   $04,s
         bra   L0B24
L0B0E    ldd   <$10,s
         pshs  b,a
         lbsr  L0F4E
         leas  $02,s
         std   ,s
         cmpd  #$FFFF
         beq   L0B3E
         ldd   ,s
         stb   ,u+
L0B24    ldd   $04,s
         addd  #$FFFF
         std   $04,s
         subd  #$FFFF
         bgt   L0B0E
         ldd   $02,s
         addd  #$0001
L0B35    std   $02,s
         ldd   $02,s
         cmpd  $0E,s
         blt   L0B08
L0B3E    ldd   $02,s
         leas  $06,s
         puls  pc,u
L0B44    pshs  u
         ldu   $04,s
         leas  -$06,s
         cmpu  #$0000
         beq   L0B57
         ldd   u0006,u
         clra  
         andb  #$03
         bne   L0B5D
L0B57    ldd   #$FFFF
         lbra  L0C80
L0B5D    ldd   u0006,u
         anda  #$80
         clrb  
         std   -$02,s
         bne   L0B70
         pshs  u
         lbsr  L10A2
         leas  $02,s
         lbra  L0C46
L0B70    ldd   u0006,u
         anda  #$01
         clrb  
         std   -$02,s
         beq   L0B8F
         pshs  u
         lbsr  L0E2F
         leas  $02,s
         ldd   u0006,u
         anda  #$FE
         std   u0006,u
         ldd   u0002,u
         addd  u000B,u
         std   u0004,u
         lbra  L0C44
L0B8F    ldd   ,u
         cmpd  u0004,u
         lbcc  L0C46
         leax  $02,s
         pshs  x
         leax  $0E,s
         lbsr  L1247
         ldx   <$10,s
         lbra  L0C13
L0BA7    leax  $02,s
         pshs  x
         ldd   $02,x
         pshs  b,a
         ldd   ,x
         pshs  b,a
         pshs  u
         lbsr  L0C9B
         leas  $02,s
         lbsr  L11CE
         lbsr  L1247
L0BC0    ldd   u000B,u
         lbsr  L122E
         ldd   $02,x
         pshs  b,a
         ldd   ,x
         pshs  b,a
         leax  $06,s
         ldd   $02,x
         pshs  b,a
         ldd   ,x
         pshs  b,a
         bsr   L0BDD
         neg   <u0000
         neg   <u0000
L0BDD    puls  x
         lbsr  L11E3
         bge   L0BEB
         leax  $06,s
         lbsr  L1207
         bra   L0BED
L0BEB    leax  $06,s
L0BED    lbsr  L11E3
         blt   L0C20
         ldd   $04,s
         addd  ,u
         std   ,s
         cmpd  u0002,u
         bcs   L0C20
         ldd   ,s
         cmpd  u0004,u
         bcc   L0C20
         ldd   ,s
         std   ,u
         ldd   u0006,u
         andb  #$EF
         std   u0006,u
         lbra  L0C7E
         bra   L0C20
L0C13    stx   -$02,s
         lbeq  L0BA7
         cmpx  #$0001
         lbeq  L0BC0
L0C20    ldd   <$10,s
         cmpd  #$0001
         bne   L0C42
         leax  $0C,s
         pshs  x
         ldd   $02,x
         pshs  b,a
         ldd   ,x
         pshs  b,a
         ldd   u0004,u
         subd  ,u
         lbsr  L122E
         lbsr  L11CE
         lbsr  L1247
L0C42    ldd   u0004,u
L0C44    std   ,u
L0C46    ldd   u0006,u
         andb  #$EF
         std   u0006,u
         ldd   <$10,s
         pshs  b,a
         leax  $0E,s
         ldd   $02,x
         pshs  b,a
         ldd   ,x
         pshs  b,a
         ldd   u0008,u
         pshs  b,a
         lbsr  L1481
         leas  $08,s
         ldd   $02,x
         pshs  b,a
         ldd   ,x
         pshs  b,a
         fcb   $8D,$04
         fcb   $FF,$FF,$FF
         fcb   $FF,$35,$10
L0C72    lbsr  L11E3
         bne   L0C7E
         ldd   #$FFFF
         bra   L0C80
L0C7E    clra  
         clrb  
L0C80    leas  $06,s
         puls  pc,u
         pshs  u
         clra  
         clrb  
         pshs  b,a
         clra  
         clrb  
         pshs  b,a
         pshs  b,a
         ldd   $0A,s
         pshs  b,a
         lbsr  L0B44
         leas  $08,s
         puls  pc,u
L0C9B    pshs  u
         ldu   $04,s
         beq   L0CA8
         ldd   u0006,u
         clra  
         andb  #$03
         bne   L0CBB
L0CA8    fdb   $8d04
         fcb   $FF,$FF
         fdb   $FFFF,$3510
L0CAE    leau  >$0292,y
         pshs  u
         lbsr  L1247
         puls  pc,u
L0CBB    ldd   u0006,u
         anda  #$80
         clrb  
         std   -$02,s
         bne   L0CCB
         pshs  u
         lbsr  L10A2
         leas  $02,s
L0CCB    ldd   #$0001
         pshs  b,a
         clra  
         clrb  
         pshs  b,a
         pshs  b,a
         ldd   u0008,u
         pshs  b,a
         lbsr  L1481
         leas  $08,s
         ldd   $02,x
         pshs  b,a
         ldd   ,x
         pshs  b,a
         ldd   u0006,u
         anda  #$01
         clrb  
         std   -$02,s
         beq   L0CF4
         ldd   u0002,u
         bra   L0CF6
L0CF4    ldd   u0004,u
L0CF6    pshs  b,a
         ldd   ,u
         subd  ,s++
         lbsr  L122E
         lbsr  L11B9
         puls  pc,u
L0D04    pshs  u
         ldu   $06,s
         ldd   u0006,u
         anda  #$80
         andb  #$22
         cmpd  #$8002
         beq   L0D28
         ldd   u0006,u
         clra  
         andb  #$22
         cmpd  #$0002
         lbne  L0E40
         pshs  u
         lbsr  L10A2
         leas  $02,s
L0D28    ldd   u0006,u
         clra  
         andb  #$04
         beq   L0D64
         ldd   #$0001
         pshs  b,a
         leax  $07,s
         pshs  x
         ldd   u0008,u
         pshs  b,a
         ldd   u0006,u
         clra  
         andb  #$40
         beq   L0D49
         leax  >L1471,pcr
         bra   L0D4D
L0D49    leax  >L1458,pcr
L0D4D    tfr   x,d
         tfr   d,x
         jsr   ,x
         leas  $06,s
         cmpd  #$FFFF
         bne   L0DA5
         ldd   u0006,u
         orb   #$20
         std   u0006,u
         lbra  L0E40
L0D64    ldd   u0006,u
         anda  #$01
         clrb  
         std   -$02,s
         bne   L0D74
         pshs  u
         lbsr  L0E5D
         leas  $02,s
L0D74    ldd   ,u
         addd  #$0001
         std   ,u
         subd  #$0001
         tfr   d,x
         ldd   $04,s
         stb   ,x
         ldd   ,u
         cmpd  u0004,u
         bcc   L0D9A
         ldd   u0006,u
         clra  
         andb  #$40
         beq   L0DA5
         ldd   $04,s
         cmpd  #$000D
         bne   L0DA5
L0D9A    pshs  u
         lbsr  L0E5D
         std   ,s++
         lbne  L0E40
L0DA5    ldd   $04,s
         puls  pc,u
         pshs  u
         ldu   $04,s
         ldd   $06,s
         pshs  b,a
         pshs  u
         ldd   #$0008
         lbsr  L130A
         pshs  b,a
         lbsr  L0D04
         leas  $04,s
         ldd   $06,s
         pshs  b,a
         pshs  u
         lbsr  L0D04
         lbra  L0F17
L0DCC    pshs  u,b,a
         leau  >$00FF,y
         clra  
         clrb  
         std   ,s
         bra   L0DE2
L0DD8    tfr   u,d
         leau  u000D,u
         pshs  b,a
         bsr   L0DF5
         leas  $02,s
L0DE2    ldd   ,s
         addd  #$0001
         std   ,s
         subd  #$0001
         cmpd  #$0010
         blt   L0DD8
         lbra  L0E59
L0DF5    pshs  u
         ldu   $04,s
         leas  -$02,s
         cmpu  #$0000
         beq   L0E05
         ldd   u0006,u
         bne   L0E0B
L0E05    ldd   #$FFFF
         lbra  L0E59
L0E0B    ldd   u0006,u
         clra  
         andb  #$02
         beq   L0E1A
         pshs  u
         bsr   L0E2F
         leas  $02,s
         bra   L0E1C
L0E1A    clra  
         clrb  
L0E1C    std   ,s
         ldd   u0008,u
         pshs  b,a
         lbsr  L13BA
         leas  $02,s
         clra  
         clrb  
         std   u0006,u
         ldd   ,s
         bra   L0E59
L0E2F    pshs  u
         ldu   $04,s
         beq   L0E40
         ldd   u0006,u
         clra  
         andb  #$22
         cmpd  #$0002
         beq   L0E45
L0E40    ldd   #$FFFF
         puls  pc,u
L0E45    ldd   u0006,u
         anda  #$80
         clrb  
         std   -$02,s
         bne   L0E55
         pshs  u
         lbsr  L10A2
         leas  $02,s
L0E55    pshs  u
         bsr   L0E5D
L0E59    leas  $02,s
         puls  pc,u
L0E5D    pshs  u
         ldu   $04,s
         leas  -$04,s
         ldd   u0006,u
         anda  #$01
         clrb  
         std   -$02,s
         bne   L0E8F
         ldd   ,u
         cmpd  u0004,u
         beq   L0E8F
         clra  
         clrb  
         pshs  b,a
         pshs  u
         lbsr  L0C9B
         leas  $02,s
         ldd   $02,x
         pshs  b,a
         ldd   ,x
         pshs  b,a
         ldd   u0008,u
         pshs  b,a
         lbsr  L1481
         leas  $08,s
L0E8F    ldd   ,u
         subd  u0002,u
         std   $02,s
         lbeq  L0F07
         ldd   u0006,u
         anda  #$01
         clrb  
         std   -$02,s
         lbeq  L0F07
         ldd   u0006,u
         clra  
         andb  #$40
         beq   L0EDE
         ldd   u0002,u
         bra   L0ED6
L0EAF    ldd   $02,s
         pshs  b,a
         ldd   ,u
         pshs  b,a
         ldd   u0008,u
         pshs  b,a
         lbsr  L1471
         leas  $06,s
         std   ,s
         cmpd  #$FFFF
         bne   L0ECC
         leax  $04,s
         bra   L0EF6
L0ECC    ldd   $02,s
         subd  ,s
         std   $02,s
         ldd   ,u
         addd  ,s
L0ED6    std   ,u
         ldd   $02,s
         bne   L0EAF
         bra   L0F07
L0EDE    ldd   $02,s
         pshs  b,a
         ldd   u0002,u
         pshs  b,a
         ldd   u0008,u
         pshs  b,a
         lbsr  L1458
         leas  $06,s
         cmpd  $02,s
         beq   L0F07
         bra   L0EF8
L0EF6    leas  -$04,x
L0EF8    ldd   u0006,u
         orb   #$20
         std   u0006,u
         ldd   u0004,u
         std   ,u
         ldd   #$FFFF
         bra   L0F17
L0F07    ldd   u0006,u
         ora   #$01
         std   u0006,u
         ldd   u0002,u
         std   ,u
         addd  u000B,u
         std   u0004,u
         clra  
         clrb  
L0F17    leas  $04,s
         puls  pc,u
L0F1B    pshs  u
         ldd   $04,s
         leax  >$01D0,y
         leax  d,x
         ldb   ,x
         clra  
         andb  #$04
         beq   L0F4A
         ldd   $04,s
         clra  
         andb  #$DF
         bra   L0F4C
         pshs  u
         ldd   $04,s
         leax  >$01D0,y
         leax  d,x
         ldb   ,x
         clra  
         andb  #$02
         beq   L0F4A
         ldd   $04,s
         orb   #$20
         bra   L0F4C
L0F4A    ldd   $04,s
L0F4C    puls  pc,u
L0F4E    pshs  u
         ldu   $04,s
         beq   L0F9A
         ldd   u0006,u
         anda  #$01
         clrb  
         std   -$02,s
         bne   L0F9A
         ldd   ,u
         cmpd  u0004,u
         bcc   L0F76
         ldd   ,u
         addd  #$0001
         std   ,u
         subd  #$0001
         tfr   d,x
         ldb   ,x
         clra  
         lbra  L10A0
L0F76    pshs  u
         lbsr  L0FE9
         lbra  L109E
         pshs  u
         ldu   $06,s
         beq   L0F9A
         ldd   u0006,u
         clra  
         andb  #$01
         beq   L0F9A
         ldd   $04,s
         cmpd  #$FFFF
         beq   L0F9A
         ldd   ,u
         cmpd  u0002,u
         bhi   L0F9F
L0F9A    ldd   #$FFFF
         puls  pc,u
L0F9F    ldd   ,u
         addd  #$FFFF
         std   ,u
         tfr   d,x
         ldd   $04,s
         stb   ,x
         ldd   $04,s
         puls  pc,u
         pshs  u
         ldu   $04,s
         leas  -$04,s
         pshs  u
         lbsr  L0F4E
         leas  $02,s
         std   $02,s
         cmpd  #$FFFF
         beq   L0FD4
         pshs  u
         lbsr  L0F4E
         leas  $02,s
         std   ,s
         cmpd  #$FFFF
         bne   L0FD9
L0FD4    ldd   #$FFFF
         bra   L0FE5
L0FD9    ldd   $02,s
         pshs  b,a
         ldd   #$0008
         lbsr  L1321
         addd  ,s
L0FE5    leas  $04,s
         puls  pc,u
L0FE9    pshs  u
         ldu   $04,s
         leas  -$02,s
         ldd   u0006,u
         anda  #$80
         andb  #$31
         cmpd  #$8001
         beq   L100F
         ldd   u0006,u
         clra  
         andb  #$31
         cmpd  #$0001
         lbne  L1088
         pshs  u
         lbsr  L10A2
         leas  $02,s
L100F    leax  >$00FF,y
         pshs  x
         cmpu  ,s++
         bne   L102C
         ldd   u0006,u
         clra  
         andb  #$40
         beq   L102C
         leax  >$010C,y
         pshs  x
         lbsr  L0E2F
         leas  $02,s
L102C    ldd   u0006,u
         clra  
         andb  #$08
         beq   L1058
         ldd   u000B,u
         pshs  b,a
         ldd   u0002,u
         pshs  b,a
         ldd   u0008,u
         pshs  b,a
         ldd   u0006,u
         clra  
         andb  #$40
         beq   L104C
         leax  >L1448,pcr
         bra   L1050
L104C    leax  >L1427,pcr
L1050    tfr   x,d
         tfr   d,x
         jsr   ,x
         bra   L106A
L1058    ldd   #$0001
         pshs  b,a
         leax  u000A,u
         stx   u0002,u
         pshs  x
         ldd   u0008,u
         pshs  b,a
         lbsr  L1427
L106A    leas  $06,s
         std   ,s
         ldd   ,s
         bgt   L108D
         ldd   u0006,u
         pshs  b,a
         ldd   $02,s
         beq   L107F
         ldd   #$0020
         bra   L1082
L107F    ldd   #$0010
L1082    ora   ,s+
         orb   ,s+
         std   u0006,u
L1088    ldd   #$FFFF
         bra   L109E
L108D    ldd   u0002,u
         addd  #$0001
         std   ,u
         ldd   u0002,u
         addd  ,s
         std   u0004,u
         ldb   [<u0002,u]
         clra  
L109E    leas  $02,s
L10A0    puls  pc,u
L10A2    pshs  u
         ldu   $04,s
         ldd   u0006,u
         clra  
         andb  #$C0
         bne   L10DA
         leas  <-$20,s
         leax  ,s
         pshs  x
         ldd   u0008,u
         pshs  b,a
         clra  
         clrb  
         pshs  b,a
         lbsr  L133C
         leas  $06,s
         ldd   u0006,u
         pshs  b,a
         ldb   $02,s
         bne   L10CE
         ldd   #$0040
         bra   L10D1
L10CE    ldd   #$0080
L10D1    ora   ,s+
         orb   ,s+
         std   u0006,u
         leas  <$20,s
L10DA    ldd   u0006,u
         ora   #$80
         std   u0006,u
         clra  
         andb  #$0C
         beq   L10E7
         puls  pc,u
L10E7    ldd   u000B,u
         bne   L10FC
         ldd   u0006,u
         clra  
         andb  #$40
         beq   L10F7
         ldd   #$0080
         bra   L10FA
L10F7    ldd   #$0100
L10FA    std   u000B,u
L10FC    ldd   u0002,u
         bne   L1111
         ldd   u000B,u
         pshs  b,a
         lbsr  L1541
         leas  $02,s
         std   u0002,u
         cmpd  #$FFFF
         beq   L1119
L1111    ldd   u0006,u
         orb   #$08
         std   u0006,u
         bra   L1128
L1119    ldd   u0006,u
         orb   #$04
         std   u0006,u
         leax  u000A,u
         stx   u0002,u
         ldd   #$0001
         std   u000B,u
L1128    ldd   u0002,u
         addd  u000B,u
         std   u0004,u
         std   ,u
         puls  pc,u
         pshs  u
         ldu   $04,s
L1136    ldb   ,u+
         bne   L1136
         tfr   u,d
         subd  $04,s
         addd  #$FFFF
         puls  pc,u
L1143    pshs  u
         ldu   $06,s
         leas  -$02,s
         ldd   $06,s
         std   ,s
L114D    ldb   ,u+
         ldx   ,s
         leax  $01,x
         stx   ,s
         stb   -$01,x
         bne   L114D
         bra   L1182
L115B    pshs  u
         ldu   $06,s
         leas  -$02,s
         ldd   $06,s
         std   ,s
L1165    ldx   ,s
         leax  $01,x
         stx   ,s
         ldb   -$01,x
         bne   L1165
         ldd   ,s
         addd  #$FFFF
         std   ,s
L1176    ldb   ,u+
         ldx   ,s
         leax  $01,x
         stx   ,s
         stb   -$01,x
         bne   L1176
L1182    ldd   $06,s
         leas  $02,s
         puls  pc,u
         pshs  u
         ldu   $04,s
         bra   L119E
L118E    ldx   $06,s
         leax  $01,x
         stx   $06,s
         ldb   -$01,x
         bne   L119C
         clra  
         clrb  
         puls  pc,u
L119C    leau  u0001,u
L119E    ldb   ,u
         sex   
         pshs  b,a
         ldb   [<$08,s]
         sex   
         cmpd  ,s++
         beq   L118E
         ldb   [<$06,s]
         sex   
         pshs  b,a
         ldb   ,u
         sex   
         subd  ,s++
         puls  pc,u
L11B9    ldd   $04,s
         addd  $02,x
         std   >$0294,y
         ldd   $02,s
         adcb  $01,x
         adca  ,x
         std   >$0292,y
         lbra  L125D
L11CE    ldd   $04,s
         subd  $02,x
         std   >$0294,y
         ldd   $02,s
         sbcb  $01,x
         sbca  ,x
         std   >$0292,y
         lbra  L125D
L11E3    ldd   $02,s
         cmpd  ,x
         bne   L11FC
         ldd   $04,s
         cmpd  $02,x
         beq   L11FC
         bcs   L11F9
         lda   #$01
         andcc #$FE
         bra   L11FC
L11F9    clra  
         cmpa  #$01
L11FC    pshs  cc
         ldd   $01,s
         std   $05,s
         puls  cc
         leas  $04,s
         rts   
L1207    lbsr  L126C
         ldd   #$0000
         subd  $02,x
         std   $02,x
         ldd   #$0000
         sbcb  $01,x
         sbca  ,x
         std   ,x
         rts   
         ldd   ,x
         coma  
         comb  
         std   >$0292,y
         ldd   $02,x
         coma  
         comb  
         leax  >$0292,y
         std   $02,x
         rts   
L122E    leax  >$0292,y
         std   $02,x
         tfr   a,b
         sex   
         tfr   a,b
         std   ,x
         rts   
         leax  >$0292,y
         std   $02,x
         clr   ,x
         clr   $01,x
         rts   
L1247    pshs  y
         ldy   $04,s
         ldd   ,x
         std   ,y
         ldd   $02,x
         std   $02,y
         puls  x
         exg   y,x
         puls  b,a
         std   ,s
         rts   
L125D    tfr   cc,a
         puls  x
         stx   $02,s
         leas  $02,s
         leax  >$0292,y
         tfr   a,cc
         rts   
L126C    ldd   ,x
         std   >$0292,y
         ldd   $02,x
         leax  >$0292,y
         std   $02,x
         rts   
         subd  #$0000
         beq   L128A
         pshs  b,a
         leas  -$02,s
         clr   ,s
         clr   $01,s
         bra   L12B8
L128A    puls  b,a
         std   ,s
         ldd   #$002D
         lbra  L132D
L1294    subd  #$0000
         beq   L128A
         pshs  b,a
         leas  -$02,s
         clr   ,s
         clr   $01,s
         tsta  
         bpl   L12AC
         nega  
         negb  
         sbca  #$00
         inc   $01,s
         std   $02,s
L12AC    ldd   $06,s
         bpl   L12B8
         nega  
         negb  
         sbca  #$00
         com   $01,s
         std   $06,s
L12B8    lda   #$01
L12BA    inca  
         lsl   $03,s
         rol   $02,s
         bpl   L12BA
         sta   ,s
         ldd   $06,s
         clr   $06,s
         clr   $07,s
L12C9    subd  $02,s
         bcc   L12D3
         addd  $02,s
         andcc #$FE
         bra   L12D5
L12D3    orcc  #$01
L12D5    rol   $07,s
         rol   $06,s
         lsr   $02,s
         ror   $03,s
         dec   ,s
         bne   L12C9
         std   $02,s
         tst   $01,s
         beq   L12EF
         ldd   $06,s
         nega  
         negb  
         sbca  #$00
         std   $06,s
L12EF    ldx   $04,s
         ldd   $06,s
         std   $04,s
         stx   $06,s
         ldx   $02,s
         ldd   $04,s
         leas  $06,s
         rts   
         tstb  
         beq   L1314
L1301    asr   $02,s
         ror   $03,s
         decb  
         bne   L1301
         bra   L1314
L130A    tstb  
         beq   L1314
L130D    lsr   $02,s
         ror   $03,s
         decb  
         bne   L130D
L1314    ldd   $02,s
         pshs  b,a
         ldd   $02,s
         std   $04,s
         ldd   ,s
         leas  $04,s
         rts   
L1321    tstb  
         beq   L1314
L1324    lsl   $03,s
         rol   $02,s
         decb  
         bne   L1324
         bra   L1314
L132D    std   >$029E,y
         pshs  y,b
         os9   F$ID     
         puls  y,b
         os9   F$Send   
         rts   
L133C    lda   $05,s
         ldb   $03,s
         beq   L136F
         cmpb  #$01
         beq   L1371
         cmpb  #$06
         beq   L1371
         cmpb  #$02
         beq   L1357
         cmpb  #$05
         beq   L1357
         ldb   #$D0
         lbra  L1590
L1357    pshs  u
         os9   I$GetStt 
         bcc   L1363
         puls  u
         lbra  L1590
L1363    stx   [<$08,s]
         ldx   $08,s
         stu   $02,x
         puls  u
         clra  
         clrb  
         rts   
L136F    ldx   $06,s
L1371    os9   I$GetStt 
         lbra  L1599
         lda   $05,s
         ldb   $03,s
         beq   L1386
         cmpb  #$02
         beq   L138E
         ldb   #$D0
         lbra  L1590
L1386    ldx   $06,s
         os9   I$SetStt 
         lbra  L1599
L138E    pshs  u
         ldx   $08,s
         ldu   $0A,s
         os9   I$SetStt 
         puls  u
         lbra  L1599
         ldx   $02,s
         lda   $05,s
         os9   I$Open   
         bcs   L13A8
         os9   I$Close  
L13A8    lbra  L1599
L13AB    ldx   $02,s
         lda   $05,s
         os9   I$Open   
         lbcs  L1590
         tfr   a,b
         clra  
         rts   
L13BA    lda   $03,s
         os9   I$Close  
         lbra  L1599
         ldx   $02,s
         ldb   $05,s
         os9   I$MakDir 
         lbra  L1599
L13CC    ldx   $02,s
         lda   $05,s
         tfr   a,b
         andb  #$24
         orb   #$0B
         os9   I$Create 
         bcs   L13DF
L13DB    tfr   a,b
         clra  
         rts   
L13DF    cmpb  #$DA
         lbne  L1590
         lda   $05,s
         bita  #$80
         lbne  L1590
         anda  #$07
         ldx   $02,s
         os9   I$Open   
         lbcs  L1590
         pshs  u,a
         ldx   #$0000
         leau  ,x
         ldb   #$02
         os9   I$SetStt 
         puls  u,a
         bcc   L13DB
         pshs  b
         os9   I$Close  
         puls  b
         lbra  L1590
         ldx   $02,s
         os9   I$Delete 
         lbra  L1599
         lda   $03,s
         os9   I$Dup    
         lbcs  L1590
         tfr   a,b
         clra  
         rts   
L1427    pshs  y
         ldx   $06,s
         lda   $05,s
         ldy   $08,s
         pshs  y
         os9   I$Read   
L1435    bcc   L1444
         cmpb  #$D3
         bne   L143F
         clra  
         clrb  
         puls  pc,y,x
L143F    puls  y,x
         lbra  L1590
L1444    tfr   y,d
         puls  pc,y,x
L1448    pshs  y
         lda   $05,s
         ldx   $06,s
         ldy   $08,s
         pshs  y
         os9   I$ReadLn 
         bra   L1435
L1458    pshs  y
         ldy   $08,s
         beq   L146D
         lda   $05,s
         ldx   $06,s
         os9   I$Write  
L1466    bcc   L146D
         puls  y
         lbra  L1590
L146D    tfr   y,d
         puls  pc,y
L1471    pshs  y
         ldy   $08,s
         beq   L146D
         lda   $05,s
         ldx   $06,s
         os9   I$WritLn 
         bra   L1466
L1481    pshs  u
         ldd   $0A,s
         bne   L148F
         ldu   #$0000
         ldx   #$0000
         bra   L14C3
L148F    cmpd  #$0001
         beq   L14BA
         cmpd  #$0002
         beq   L14AF
         ldb   #$F7
L149D    clra  
         std   >$029E,y
         ldd   #$FFFF
         leax  >$0292,y
         std   ,x
         std   $02,x
         puls  pc,u
L14AF    lda   $05,s
         ldb   #$02
         os9   I$GetStt 
         bcs   L149D
         bra   L14C3
L14BA    lda   $05,s
         ldb   #$05
         os9   I$GetStt 
         bcs   L149D
L14C3    tfr   u,d
         addd  $08,s
         std   >$0294,y
         tfr   d,u
         tfr   x,d
         adcb  $07,s
         adca  $06,s
         bmi   L149D
         tfr   d,x
         std   >$0292,y
         lda   $05,s
         os9   I$Seek   
         bcs   L149D
         leax  >$0292,y
         puls  pc,u
         ldd   >$0290,y
         pshs  b,a
         ldd   $04,s
         cmpd  >$02A0,y
         bcs   L151E
         addd  >$0290,y
         bcs   L150A
         pshs  y
         subd  ,s
         os9   F$Mem    
         tfr   y,d
         puls  y
         bcc   L1510
L150A    ldd   #$FFFF
         leas  $02,s
         rts   
L1510    std   >$0290,y
         addd  >$02A0,y
         subd  ,s
         std   >$02A0,y
L151E    leas  $02,s
         ldd   >$02A0,y
         pshs  b,a
         subd  $04,s
         std   >$02A0,y
         ldd   >$0290,y
         subd  ,s++
         pshs  b,a
         clra  
         ldx   ,s
L1537    sta   ,x+
         cmpx  >$0290,y
         bcs   L1537
         puls  pc,b,a
L1541    ldd   $02,s
         addd  >$029A,y
         bcs   L156A
         cmpd  >$029C,y
         bcc   L156A
         pshs  b,a
         ldx   >$029A,y
         clra  
L1557    cmpx  ,s
         bcc   L155F
         sta   ,x+
         bra   L1557
L155F    ldd   >$029A,y
         puls  x
         stx   >$029A,y
         rts   
L156A    ldd   #$FFFF
         rts   
L156E    pshs  u
         tfr   y,u
         ldx   $04,s
         stx   >$02A2,y
         leax  >L1584,pcr
         os9   F$Icpt   
         puls  u
         lbra  L1599
L1584    tfr   u,y
         clra  
         pshs  b,a
         jsr   [>$02A2,y]
         leas  $02,s
         rti   
L1590    clra  
         std   >$029E,y
         ldd   #$FFFF
         rts   
L1599    bcs   L1590
         clra  
         clrb  
         rts   
L159E    lbsr  L15A9
         lbsr  L0DCC
L15A4    ldd   $02,s
         os9   F$Exit   
L15A9    rts   
L15AA    fdb   $0001,$0001,$5100
         fdb   $0000,$0000,$0000,$0100,$0000,$0000,$0000,$0000
         fdb   $0000,$0002,$0001,$0000,$0000,$0000,$0000,$0000
         fdb   $4200,$0200,$0000,$0000,$0000,$0000,$0000,$0000
         fdb   $0000,$0000,$0000,$0000,$0000,$0000,$0000,$0000
         fdb   $0000,$0000,$0000,$0000,$0000,$0000,$0000,$0000
         fdb   $0000,$0000,$0000,$0000,$0000,$0000,$0000,$0000
         fdb   $0000,$0000,$0000,$0000,$0000,$0000,$0000,$0000
         fdb   $0000,$0000,$0000,$0000,$0000,$0000,$0000,$0000
         fdb   $0000,$0000,$0000,$0000,$0000,$0000,$0000,$0000
         fdb   $0000,$0000,$0000,$0000,$0000,$0000,$0000,$0000
         fdb   $0000,$0000,$0000,$0000,$0000,$0000,$0000,$0000
         fdb   $0000,$0000,$0000,$0000,$0000,$0000,$0000,$0000
         fdb   $0000,$0000,$0000,$0000,$0000,$0000,$0000,$0000
         fdb   $0101,$0101,$0101,$0101,$0111,$1101,$1111,$0101
         fdb   $0101,$0101,$0101,$0101,$0101,$0101,$0101,$0101
         fdb   $3020,$2020,$2020,$2020,$2020,$2020,$2020,$2020
         fdb   $4848,$4848,$4848,$4848,$4848,$2020,$2020,$2020
         fdb   $2042,$4242,$4242,$4202,$0202,$0202,$0202,$0202
         fdb   $0202,$0202,$0202,$0202,$0202,$0220,$2020,$2020
         fdb   $2044,$4444,$4444,$4404,$0404,$0404,$0404,$0404
         fdb   $0404,$0404,$0404,$0404,$0404,$0420,$2020,$2001
         fdb   $0000,$0000
         fcc   "help"
         fcb   $00

         emod
eom      equ   *
         end
