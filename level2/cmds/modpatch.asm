********************************************************************
* progname - program module
*
* $Id$
*
* Ed.    Comments                                       Who YY/MM/DD
* ------------------------------------------------------------------
*  -     Original Tandy distribution version
*
*

         nam   modpatch
         ttl   program module       

* Disassembled 02/07/06 13:11:04 by Disasm v1.6 (C) 1988 by RML

         ifp1
         use   os9defs
         endc
tylg     set   Prgrm+Objct   
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
u0007    rmb   2
u0009    rmb   2
u000B    rmb   2
u000D    rmb   2
u000F    rmb   1
u0010    rmb   1
u0011    rmb   1
u0012    rmb   2
u0014    rmb   2
u0016    rmb   1
u0017    rmb   1
u0018    rmb   1
u0019    rmb   7
u0020    rmb   10
u002A    rmb   5
u002F    rmb   5
u0034    rmb   55
u006B    rmb   2
u006D    rmb   26
u0087    rmb   2
u0089    rmb   2
u008B    rmb   2
u008D    rmb   2
u008F    rmb   2
u0091    rmb   2
u0093    rmb   2
u0095    rmb   2
u0097    rmb   1
u0098    rmb   1
u0099    rmb   2
u009B    rmb   2
u009D    rmb   2
u009F    rmb   35
u00C2    rmb   31
u00E1    rmb   92
u013D    rmb   2
u013F    rmb   58
u0179    rmb   1
u017A    rmb   3
u017D    rmb   912
size     equ   .
name     equ   *
         fcs   /modpatch/
         fcb   $04 
L0016    fcb   $A6 &
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
L0025    sta   ,u+
         decb  
         bne   L0025
         ldx   ,s
         leau  ,x
         leax  >$018D,x
         pshs  x
         leay  >L0A92,pcr
         ldx   ,y++
         beq   L0040
         bsr   L0016
         ldu   $02,s
L0040    leau  >u0087,u
         ldx   ,y++
         beq   L004B
         bsr   L0016
         clra  
L004B    cmpu  ,s
         beq   L0054
         sta   ,u+
         bra   L004B
L0054    ldu   $02,s
         ldd   ,y++
         beq   L0061
         leax  >L0000,pcr
         lbsr  L0164
L0061    ldd   ,y++
         beq   L006A
         leax  ,u
         lbsr  L0164
L006A    leas  $04,s
         puls  x
         stx   >u017D,u
         sty   >u013D,u
         ldd   #$0001
         std   >u0179,u
         leay  >u013F,u
         leax  ,s
         lda   ,x+
L0086    ldb   >u017A,u
         cmpb  #$1D
         beq   L00E2
L008E    cmpa  #$0D
         beq   L00E2
         cmpa  #$20
         beq   L009A
         cmpa  #$2C
         bne   L009E
L009A    lda   ,x+
         bra   L008E
L009E    cmpa  #$22
         beq   L00A6
         cmpa  #$27
         bne   L00C4
L00A6    stx   ,y++
         inc   >u017A,u
         pshs  a
L00AE    lda   ,x+
         cmpa  #$0D
         beq   L00B8
         cmpa  ,s
         bne   L00AE
L00B8    puls  b
         clr   -$01,x
         cmpa  #$0D
         beq   L00E2
         lda   ,x+
         bra   L0086
L00C4    leax  -$01,x
         stx   ,y++
         leax  $01,x
         inc   >u017A,u
L00CE    cmpa  #$0D
         beq   L00DE
         cmpa  #$20
         beq   L00DE
         cmpa  #$2C
         beq   L00DE
         lda   ,x+
         bra   L00CE
L00DE    clr   -$01,x
         bra   L0086
L00E2    leax  >u013D,u
         pshs  x
         ldd   >u0179,u
         pshs  b,a
         leay  ,u
         bsr   L00FC
         lbsr  L017E
         clr   ,-s
         clr   ,-s
         lbsr  L0A85
L00FC    leax  >$018D,y
         stx   >$0187,y
         sts   >$017B,y
         sts   >$0189,y
         ldd   #$FF82
L0111    leax  d,s
         cmpx  >$0189,y
         bcc   L0123
         cmpx  >$0187,y
         bcs   L013D
         stx   >$0189,y
L0123    rts   
L0124    bpl   L0150
         bpl   L0152
         bra   L017D
         lsrb  
         fcb   $41 A
         coma  
         fcb   $4B K
         bra   L017F
         rorb  
         fcb   $45 E
         fcb   $52 R
         rora  
         inca  
         clra  
         asrb  
         bra   L0163
         bpl   L0165
         bpl   L014A
L013D    leax  <L0124,pcr
         ldb   #$CF
         pshs  b
         lda   #$02
         ldy   #$0064
L014A    os9   I$WritLn 
         clr   ,-s
         lbsr  L0A8B
L0152    ldd   >$017B,y
         subd  >$0189,y
         rts   
         ldd   >$0189,y
         subd  >$0187,y
L0163    rts   
L0164    pshs  x
         leax  d,y
         leax  d,x
         pshs  x
L016C    ldd   ,y++
         leax  d,u
         ldd   ,x
         addd  $02,s
         std   ,x
         cmpy  ,s
         bne   L016C
         leas  $04,s
L017D    rts   
L017E    pshs  u
         ldd   #$FFB6
         lbsr  L0111
         clra  
         clrb  
         std   <u0009
         stb   <u0016
         ldd   #$0001
         stb   <u0018
         stb   <u0017
         clra  
         clrb  
         std   <u000D
         ldd   $04,s
         lbne  L0235
         lbsr  L045A
         lbra  L0235
L01A3    ldx   $06,s
         leax  $02,x
         stx   $06,s
         ldb   [,x]
         cmpb  #$2D
         lbne  L0213
         ldd   [<$06,s]
         bra   L0204
L01B6    ldb   [>$0012,y]
         sex   
         pshs  b,a
         lbsr  L07E5
         leas  $02,s
         tfr   d,x
         bra   L01EC
L01C6    ldd   #$0001
         stb   <u0016
         bra   L0202
L01CD    clra  
         clrb  
         stb   <u0017
         bra   L0202
L01D3    clra  
         clrb  
         stb   <u0018
         bra   L0202
L01D9    lbsr  L045A
L01DC    leax  >L074A,pcr
         pshs  x
         lbsr  L056A
         leas  $02,s
         lbsr  L045A
         bra   L0202
L01EC    cmpx  #$0053
         beq   L01C6
         cmpx  #$0057
         beq   L01CD
         cmpx  #$0043
         beq   L01D3
         cmpx  #$003F
         beq   L01D9
         bra   L01DC
L0202    ldd   <u0012
L0204    addd  #$0001
         std   <u0012
         ldb   [>$0012,y]
         lbne  L01B6
         bra   L0235
L0213    ldd   #$0001
         pshs  b,a
         ldd   [<$08,s]
         pshs  b,a
         lbsr  L08DD
         leas  $04,s
         std   <u0003
         cmpd  #$FFFF
         bne   L0235
         leax  >L0764,pcr
         pshs  x
         lbsr  L0533
         leas  $02,s
L0235    ldd   $04,s
         addd  #$FFFF
         std   $04,s
         lbne  L01A3
         lbra  L02C6
L0243    ldb   <u0016
         bne   L026D
         ldb   <u0010
         cmpb  #$0D
         bne   L025D
         ldd   #$0002
         pshs  b,a
         leax  >$000F,y
         pshs  x
         lbsr  L057D
         bra   L026B
L025D    ldd   #$0002
         pshs  b,a
         leax  >$000F,y
         pshs  x
         lbsr  L0550
L026B    leas  $04,s
L026D    ldb   <u000F
         sex   
         pshs  b,a
         lbsr  L07E5
         leas  $02,s
         tfr   d,x
         bra   L02A6
L027B    lbsr  L0320
         bra   L02C6
L0280    lbsr  L0387
         bra   L02C6
L0285    lbsr  L0414
         bra   L02C6
L028A    lbsr  L030B
         bra   L02C6
L028F    lbsr  L0317
         bra   L02C6
L0294    lbsr  L048A
         bra   L02C6
L0299    leax  >$00A1,y
         pshs  x
         lbsr  L056A
         leas  $02,s
         bra   L02C6
L02A6    cmpx  #$004C
         beq   L027B
         cmpx  #$0043
         beq   L0280
         cmpx  #$0056
         beq   L0285
         cmpx  #$004D
         beq   L028A
         cmpx  #$0055
         beq   L028F
         cmpx  #$002A
         beq   L0294
         bra   L0299
L02C6    ldd   #$0002
         pshs  b,a
         leax  >$000F,y
         pshs  x
         ldd   <u0003
         pshs  b,a
         lbsr  L0959
         leas  $06,s
         std   <u000B
         ldd   <u000B
         lbgt  L0243
         ldd   <u000B
         cmpd  #$FFFF
         bne   L02F5
         leax  >L0786,pcr
         pshs  x
         lbsr  L0533
         leas  $02,s
L02F5    ldd   <u0009
         beq   L02FB
         bsr   L0317
L02FB    ldd   <u000D
         lbeq  L054E
         ldd   <u000D
         pshs  b,a
         lbsr  L0A6B
         lbra  L054C
L030B    ldd   #$0001
         std   <u0009
         tfr   cc,b
         stb   <u0011
         orcc  #$50
         rts   
L0317    clra  
         clrb  
         std   <u0009
         ldb   <u0011
         tfr   b,cc
         rts   
L0320    pshs  u
         ldd   #$FFB6
         lbsr  L0111
         ldd   <u000D
         beq   L0335
         ldd   <u000D
         pshs  b,a
         lbsr  L0A6B
         leas  $02,s
L0335    ldd   #$001D
         pshs  b,a
         leax  >$001A,y
         pshs  x
         ldd   <u0003
         pshs  b,a
         lbsr  L0967
         leas  $06,s
         std   <u000B
         lble  L054E
         ldb   <u0016
         bne   L035E
         leax  >$001A,y
         pshs  x
         lbsr  L056A
         leas  $02,s
L035E    clra  
         clrb  
         pshs  b,a
         clra  
         clrb  
         pshs  b,a
         leax  >$001A,y
         pshs  x
         lbsr  L0A3F
         leas  $06,s
         std   <u000D
         cmpd  #$FFFF
         lbne  L054E
         leax  >L07A7,pcr
         pshs  x
         lbsr  L0533
         lbra  L054C
L0387    pshs  u
         ldd   #$FFB4
         lbsr  L0111
         leas  -$02,s
         ldd   #$0050
         pshs  b,a
         leax  >$0037,y
         pshs  x
         ldd   <u0003
         pshs  b,a
         lbsr  L0967
         leas  $06,s
         std   <u000B
         lble  L054C
         ldb   <u0016
         bne   L03BA
         leax  >$0037,y
         pshs  x
         lbsr  L056A
         leas  $02,s
L03BA    leax  >$0037,y
         stx   ,s
         leax  ,s
         pshs  x
         lbsr  L04B8
         leas  $02,s
         std   <u0001
         leax  ,s
         pshs  x
         lbsr  L04B8
         leas  $02,s
         std   <u0005
         leax  ,s
         pshs  x
         lbsr  L04B8
         leas  $02,s
         std   <u0007
         ldd   <u000D
         addd  <u0001
         std   <u0014
         ldb   [>$0014,y]
         stb   <u0019
         ldb   <u0019
         clra  
         tstb  
         cmpd  <u0005
         beq   L0405
         ldb   <u0017
         beq   L0405
         leax  >L07C8,pcr
         pshs  x
         lbsr  L056A
         leas  $02,s
L0405    ldb   <u0018
         lbeq  L054C
         ldd   <u0007
         stb   [>$0014,y]
         lbra  L054C
L0414    pshs  u
         ldd   #$FFB6
         lbsr  L0111
         ldx   <u000D
         ldd   $02,x
         addd  #$FFFD
         std   <u0001
         ldd   <u000D
         addd  <u0001
         tfr   d,u
         ldd   #$00FF
         stb   u0002,u
         stb   u0001,u
         stb   ,u
         pshs  u
         ldd   <u0001
         pshs  b,a
         ldd   <u000D
         pshs  b,a
         lbsr  L0A19
         leas  $06,s
         ldb   ,u
         sex   
         coma  
         comb  
         stb   ,u
         ldb   u0001,u
         sex   
         coma  
         comb  
         stb   u0001,u
         ldb   u0002,u
         sex   
         coma  
         comb  
         stb   u0002,u
         puls  pc,u
L045A    pshs  u
         ldd   #$FFB8
         lbsr  L0111
         leas  -$02,s
         leau  >$0087,y
         leax  >$00A1,y
         stx   ,s
         bra   L0479
L0470    ldd   ,u++
         pshs  b,a
         lbsr  L056A
         leas  $02,s
L0479    cmpu  ,s
         bcs   L0470
         clra  
         clrb  
         pshs  b,a
         lbsr  L0A85
         leas  $02,s
         lbra  L054C
L048A    pshs  u
         ldd   #$FFB6
         lbsr  L0111
         ldd   #$0050
         pshs  b,a
         leax  >$0037,y
         pshs  x
         ldd   <u0003
         pshs  b,a
         lbsr  L0967
         leas  $06,s
         ldb   <u0016
         lbne  L054E
         leax  >$0037,y
         pshs  x
         lbsr  L056A
         lbra  L054C
L04B8    pshs  u
         ldd   #$FFB6
         lbsr  L0111
         leas  -$02,s
         ldu   [<$06,s]
         clra  
         clrb  
         std   ,s
         bra   L04CD
L04CB    leau  u0001,u
L04CD    ldb   ,u
         sex   
         leax  >$00BD,y
         leax  d,x
         ldb   ,x
         clra  
         andb  #$40
         beq   L04CB
         bra   L0518
L04DF    ldd   ,s
         pshs  b,a
         ldd   #$0004
         lbsr  L08C2
         std   ,s
         pshs  b,a
         ldb   ,u
         sex   
         leax  >$00BD,y
         leax  d,x
         ldb   ,x
         clra  
         andb  #$08
         beq   L0505
         ldb   ,u
         sex   
         addd  #$FFD0
         bra   L0512
L0505    ldb   ,u
         sex   
         pshs  b,a
         lbsr  L07E5
         leas  $02,s
         addd  #$FFC9
L0512    addd  ,s++
         std   ,s
         leau  u0001,u
L0518    ldb   ,u
         sex   
         leax  >$00BD,y
         leax  d,x
         ldb   ,x
         clra  
         andb  #$40
         bne   L04DF
         leau  u0001,u
         tfr   u,d
         std   [<$06,s]
         ldd   ,s
         bra   L054C
L0533    pshs  u
         ldd   #$FFBA
         lbsr  L0111
         ldu   $04,s
         pshs  u
         bsr   L056A
         leas  $02,s
         ldd   >$018B,y
         pshs  b,a
         lbsr  L0A85
L054C    leas  $02,s
L054E    puls  pc,u
L0550    pshs  u
         ldd   #$FFB6
         lbsr  L0111
         ldu   $04,s
         ldd   $06,s
         pshs  b,a
         pshs  u
         ldd   #$0002
         pshs  b,a
         lbsr  L097D
         bra   L0595
L056A    pshs  u
         ldd   #$FFB6
         lbsr  L0111
         ldu   $04,s
         pshs  u
         lbsr  L0818
         std   ,s
         bra   L058B
L057D    pshs  u
         ldd   #$FFB6
         lbsr  L0111
         ldu   $04,s
         ldd   $06,s
         pshs  b,a
L058B    pshs  u
         ldd   #$0002
         pshs  b,a
         lbsr  L098D
L0595    leas  $06,s
         puls  pc,u
         tsta  
         clr   $04,s
         negb  
         oim   #$74,$03,s
         lsl   $00,y
         cwai  #$66
         rol   $0C,s
         eim   #$6E,$01,s
         tst   $05,s
         fcb   $3E >
         bra   L0609
         clr   -$10,s
         lsr   >$735D
         tst   <u0000
         fcb   $55 U
         com   >$6167
         eim   #$3A,$00,y
         bra   L060E
         oim   #$74,$03,s
         lsl   $00,y
         tst   $0F,s
         lsr   -$0B,s
         inc   $05,s
         com   >$2069
         jmp   $00,y
         fcb   $52 R
         fcb   $41 A
         tsta  
         tst   <u0000
         clra  
         neg   >$7473
         bra   L0613
         bra   L05FB
         blt   L0650
         bra   L061C
         bra   L0654
         rol   $0C,s
         eim   #$6E,-$0C,s
         bra   L0655
         clr   $04,s
         eim   #$0D,$00,x
         bra   L060F
         bra   L0611
         bra   L0613
         bra   L0615
         blt   L066E
         bra   L0636
         bra   L066E
L05FB    eim   #$70,>$7072
         eim   #$73,-$0D,s
         bra   L067B
         oim   #$72,$0E,s
         rol   $0E,s
L0609    asr   -$0D,s
         tst   <u0000
         bra   L062F
L060F    bra   L0631
L0611    bra   L0633
L0613    bra   L0635
L0615    blt   L067A
         bra   L0656
         bra   L067E
         clr   $0D,s
         neg   >$6172
         eim   #$20,$0F,s
         jmp   $0C,s
         rol   >$2C20
         jmp   $0F,s
         bra   L068F
         lsl   $01,s
         jmp   $07,s
         eim   #$0D,$00,x
L0633    bra   L0655
L0635    bra   L0657
         bra   L0659
         bra   L065B
         blt   L067C
         bra   L067C
         bra   L06A9
         eim   #$6C,-$10,s
         tst   <u0000
         coma  
         tst   $04,s
         com   >$203A
         bra   L066E
         inca  
         bra   L06BE
         clr   $04,s
         jmp   $01,s
L0655    tst   $05,s
L0657    bra   L0679
L0659    blt   L067B
L065B    inc   $09,s
         jmp   $0B,s
         bra   L06D5
         clr   $00,y
         tst   $0F,s
         lsr   -$0B,s
         inc   $05,s
         tst   <u0000
         bra   L068D
         bra   L068F
         bra   L0691
         bra   L0693
         coma  
         bra   L06E5
         ror   $06,s
         bra   L06E9
L067A    aim   #$79,-$0C,s
         eim   #$20,$0E,s
         aim   #$79,-$0C,s
         eim   #$20,$0D,y
         bra   L06EB
         lsl   $01,s
         jmp   $07,s
         eim   #$20,$0F,s
L068F    aim   #$79,-$0C,s
         eim   #$20,$01,s
         lsr   >$0D00
         bra   L06BA
         bra   L06BC
         bra   L06BE
         bra   L06C0
         bra   L06C2
         bra   L06C4
         bra   L06C6
         bra   L06C8
         bra   L06CA
         bra   L06CC
         bra   L06CE
         bra   L06D0
         bra   L06D2
         bra   L06D4
         clr   $06,s
         ror   $00,y
         lsr   >$6F20
         jmp   $02,s
         rol   >$7465
L06C0    tst   <u0000
L06C2    bra   L06E4
L06C4    bra   L06E6
L06C6    bra   L06E8
L06C8    bra   L06EA
L06CA    rorb  
         bra   L06FA
         bra   L0745
         eim   #$72,$09,s
L06D2    ror   -$07,s
L06D4    bra   L0743
         clr   $04,s
         eim   #$6C,>$6520
         coma  
         fcb   $52 R
         coma  
         tst   <u0000
         bra   L0703
         bra   L0705
L06E5    bra   L0707
         bra   L0709
L06E9    tsta  
L06EA    bra   L0719
         bra   L073B
         oim   #$73,$0B,s
         bra   L073C
         fcb   $52 R
         fcb   $51 Q
         com   >$2028
         lsr   >$6F20
         neg   >$6174
         com   $08,s
         bra   L074B
         fcb   $52 R
L0703    fcb   $51 Q
         bra   L0779
         eim   #$72,-$0A,s
L0709    rol   $03,s
         eim   #$20,-$0E,s
         clr   -$0B,s
         lsr   >$696E
         eim   #$0D,$00,x
         bra   L0738
         bra   L073A
         bra   L073C
         bra   L073E
         fcb   $55 U
         bra   L074E
         bra   L0778
         jmp   u000D,u
         oim   #$73,$0B,s
         bra   L0773
         fcb   $52 R
         fcb   $51 Q
         com   >$0D00
         bra   L0751
         bra   L0753
         bra   L0755
         bra   L0757
         bpl   L0759
         blt   L075B
L073B    coma  
L073C    clr   $0D,s
L073E    tst   $05,s
         jmp   -$0C,s
         bra   L0790
         rol   $0E,s
         eim   #$0D,$0D,x
         neg   <u006D
L074B    clr   $04,s
         neg   >$6174
         com   $08,s
         abx   
L0753    bra   L07CA
L0755    jmp   $0B,s
L0757    jmp   $0F,s
L0759    asr   >$6E20
         clr   -$10,s
         lsr   >$696F
         jmp   $0D,x
         neg   <u006D
         clr   $04,s
         neg   >$6174
         com   $08,s
         abx   
         bra   L07D2
         oim   #$6E,$07,y
         lsr   >$206F
         neg   >$656E
L0778    bra   L07E3
         jmp   -$10,s
         eim   #$74,>$2066
         rol   $0C,s
         eim   #$0D,$0D,x
         neg   <u006D
         clr   $04,s
         neg   >$6174
         com   $08,s
         abx   
         bra   L07FA
         jmp   -$10,s
         eim   #$74,>$2066
         rol   $0C,s
         eim   #$20,-$0E,s
         eim   #$61,$04,s
         bra   L0806
         aim   #$72,>$6F72
         tst   <u0000
L07A7    tst   $0F,s
         lsr   -$10,s
         oim   #$74,$03,s
         lsl   -$06,y
         bra   L0815
         oim   #$6E,$07,y
         lsr   >$206C
         rol   $0E,s
         tim   #$20,-$0C,s
         clr   $00,y
         tst   $0F,s
         lsr   -$0B,s
         inc   $05,s
         tst   <u000D
         neg   <u002A
         bpl   L07F5
         bra   L082F
         rol   >$7465
         bra   L0836
L07D2    clr   $05,s
         com   >$206E
         clr   -$0C,s
         bra   L0848
         oim   #$74,$03,s
         lsl   $00,y
         bpl   L080C
         bpl   L07F1
         neg   <u0034
         nega  
         ldd   $04,s
         leax  >$00BD,y
         leax  d,x
         ldb   ,x
L07F1    clra  
         andb  #$04
         beq   L0814
         ldd   $04,s
         clra  
         andb  #$DF
         bra   L0816
         pshs  u
         ldd   $04,s
         leax  >$00BD,y
         leax  d,x
         ldb   ,x
         clra  
         andb  #$02
L080C    beq   L0814
         ldd   $04,s
         orb   #$20
         bra   L0816
L0814    ldd   $04,s
L0816    puls  pc,u
L0818    pshs  u
         ldu   $04,s
L081C    ldb   ,u+
         bne   L081C
         tfr   u,d
         subd  $04,s
         addd  #$FFFF
         puls  pc,u
         pshs  u
         ldu   $06,s
         leas  -$02,s
L082F    ldd   $06,s
         std   ,s
L0833    ldb   ,u+
         ldx   ,s
         leax  $01,x
         stx   ,s
         stb   -$01,x
         bne   L0833
         bra   L0868
         pshs  u
         ldu   $06,s
         leas  -$02,s
         ldd   $06,s
         std   ,s
L084B    ldx   ,s
         leax  $01,x
         stx   ,s
         ldb   -$01,x
         bne   L084B
         ldd   ,s
         addd  #$FFFF
         std   ,s
L085C    ldb   ,u+
         ldx   ,s
         leax  $01,x
         stx   ,s
         stb   -$01,x
         bne   L085C
L0868    ldd   $06,s
         leas  $02,s
         puls  pc,u
         pshs  u
         ldu   $04,s
         bra   L0884
L0874    ldx   $06,s
         leax  $01,x
         stx   $06,s
         ldb   -$01,x
         bne   L0882
         clra  
         clrb  
         puls  pc,u
L0882    leau  u0001,u
L0884    ldb   ,u
         sex   
         pshs  b,a
         ldb   [<$08,s]
         sex   
         cmpd  ,s++
         beq   L0874
         ldb   [<$06,s]
         sex   
         pshs  b,a
         ldb   ,u
         sex   
         subd  ,s++
         puls  pc,u
         tstb  
         beq   L08B5
L08A2    asr   $02,s
         ror   $03,s
         decb  
         bne   L08A2
         bra   L08B5
         tstb  
         beq   L08B5
L08AE    lsr   $02,s
         ror   $03,s
         decb  
         bne   L08AE
L08B5    ldd   $02,s
         pshs  b,a
         ldd   $02,s
         std   $04,s
         ldd   ,s
         leas  $04,s
         rts   
L08C2    tstb  
         beq   L08B5
L08C5    lsl   $03,s
         rol   $02,s
         decb  
         bne   L08C5
         bra   L08B5
         ldx   $02,s
         lda   $05,s
         os9   I$Open   
         bcs   L08DA
         os9   I$Close  
L08DA    lbra  L0A80
L08DD    ldx   $02,s
         lda   $05,s
         os9   I$Open   
         lbcs  L0A77
         tfr   a,b
         clra  
         rts   
         lda   $03,s
         os9   I$Close  
         lbra  L0A80
         ldx   $02,s
         ldb   $05,s
         os9   I$MakDir 
         lbra  L0A80
         ldx   $02,s
         lda   $05,s
         tfr   a,b
         andb  #$24
         orb   #$0B
         os9   I$Create 
         bcs   L0911
L090D    tfr   a,b
         clra  
         rts   
L0911    cmpb  #$DA
         lbne  L0A77
         lda   $05,s
         bita  #$80
         lbne  L0A77
         anda  #$07
         ldx   $02,s
         os9   I$Open   
         lbcs  L0A77
         pshs  u,a
         ldx   #$0000
         leau  ,x
         ldb   #$02
         os9   I$SetStt 
         puls  u,a
         bcc   L090D
         pshs  b
         os9   I$Close  
         puls  b
         lbra  L0A77
         ldx   $02,s
         os9   I$Delete 
         lbra  L0A80
         lda   $03,s
         os9   I$Dup    
         lbcs  L0A77
         tfr   a,b
         clra  
         rts   
L0959    pshs  y
         lda   $05,s
         ldx   $06,s
         ldy   $08,s
         os9   I$Read   
         bra   L0973
L0967    pshs  y
         lda   $05,s
         ldx   $06,s
         ldy   $08,s
         os9   I$ReadLn 
L0973    bcc   L09A2
         cmpb  #$D3
         bne   L099D
         clra  
         clrb  
         puls  pc,y
L097D    pshs  y
         ldy   $08,s
         beq   L09A2
         lda   $05,s
         ldx   $06,s
         os9   I$Write  
         bra   L099B
L098D    pshs  y
         ldy   $08,s
         beq   L09A2
         lda   $05,s
         ldx   $06,s
         os9   I$WritLn 
L099B    bcc   L09A2
L099D    puls  y
         lbra  L0A77
L09A2    tfr   y,d
         puls  pc,y
         pshs  u
         ldd   $0A,s
         bne   L09B4
         ldu   #$0000
         ldx   #$0000
         bra   L09E8
L09B4    cmpd  #$0001
         beq   L09DF
         cmpd  #$0002
         beq   L09D4
         ldb   #$F7
L09C2    clra  
         std   >$018B,y
         ldd   #$FFFF
         leax  >$017F,y
         std   ,x
         std   $02,x
         puls  pc,u
L09D4    lda   $05,s
         ldb   #$02
         os9   I$GetStt 
         bcs   L09C2
         bra   L09E8
L09DF    lda   $05,s
         ldb   #$05
         os9   I$GetStt 
         bcs   L09C2
L09E8    tfr   u,d
         addd  $08,s
         std   >$0181,y
         tfr   d,u
         tfr   x,d
         adcb  $07,s
         adca  $06,s
         bmi   L09C2
         tfr   d,x
         std   >$017F,y
         lda   $05,s
         os9   I$Seek   
         bcs   L09C2
         leax  >$017F,y
         puls  pc,u
         rts   
         ldx   #$0000
         clrb  
         os9   F$Sleep  
         lbra  L0A77
         rts   
L0A19    pshs  u,y
         ldx   $06,s
         ldy   $08,s
         ldu   $0A,s
         os9   F$CRC    
         puls  pc,u,y
         lda   $03,s
         ldb   $05,s
         os9   F$PErr   
         lbcs  L0A77
         rts   
         ldx   $02,s
         os9   F$Sleep  
         lbcs  L0A77
         tfr   x,d
         rts   
L0A3F    pshs  u,y
         ldx   $06,s
         lda   $09,s
         lsla  
         lsla  
         lsla  
         lsla  
         ora   $0B,s
         os9   F$Link   
         bcs   L0A66
L0A50    tfr   u,d
         puls  u,y
         rts   
         pshs  u,y
         ldx   $06,s
         lda   $09,s
         lsla  
         lsla  
         lsla  
         lsla  
         ora   $0B,s
         os9   F$Load   
         bcc   L0A50
L0A66    puls  u,y
         lbra  L0A77
L0A6B    pshs  u
         ldu   $04,s
         os9   F$UnLink 
         puls  u
         lbra  L0A80
L0A77    clra  
         std   >$018B,y
         ldd   #$FFFF
         rts   
L0A80    bcs   L0A77
         clra  
         clrb  
         rts   
L0A85    lbsr  L0A90
         lbsr  L0A91
L0A8B    ldd   $02,s
         os9   F$Exit   
L0A90    rts   
L0A91    rts   
L0A92    neg   <u0001
         neg   <u0000
         lda   >$0599
         eim   #$B5,<u0005
         addd  <u0005
         std   $06,x
         tst   <u0006
         leau  $06,x
         rora  
         ror   <u006B
         ror   <u0098
         ror   <u00C2
         ror   <u00E1
         asr   <u0016
         asr   <u002F
         tst   $0F,s
         lsr   -$10,s
         oim   #$74,$03,s
         lsl   -$06,y
         bra   L0B25
         inc   $0C,s
         eim   #$67,$01,s
         inc   $00,y
         com   $0F,s
         tst   $0D,s
         oim   #$6E,$04,s
         tst   <u0000
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
         bra   L0B11
         bra   L0B13
         bra   L0B15
         bra   L0B17
         bra   L0B19
         bra   L0B1B
         bra   L0B1D
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
         bra   L0B29
         bra   L0B2B
         bra   L0B2D
         bra   L0B51
         fcb   $42 B
         fcb   $42 B
L0B11    fcb   $42 B
         fcb   $42 B
L0B13    fcb   $42 B
         aim   #$02,<u0002
L0B17    aim   #$02,<u0002
         aim   #$02,<u0002
L0B1D    aim   #$02,<u0002
         aim   #$02,<u0002
         aim   #$02,<u0002
         aim   #$02,<u0020
L0B29    bra   L0B4B
L0B2B    bra   L0B4D
L0B2D    bra   L0B73
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
         bra   L0B6A
         bra   L0B6C
         oim   #$00,<u000D
         neg   <u0091
L0B51    neg   <u008F
         neg   <u008D
         neg   <u008B
         neg   <u0089
         neg   <u0087
         neg   <u009F
         neg   <u009D
         neg   <u009B
         neg   <u0099
         neg   <u0097
         neg   <u0095
         neg   <u0093
         neg   <u0000
         tst   $0F,s
         lsr   -$10,s
         oim   #$74,$03,s
         lsl   $00,x
         emod
eom      equ   *
