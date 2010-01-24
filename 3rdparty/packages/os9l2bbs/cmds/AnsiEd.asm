         nam   AnsiEd
         ttl   program module       

* Disassembled 2010/01/24 10:25:33 by Disasm v1.5 (C) 1988 by RML

         ifp1
         use   /dd/defs/defsfile
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
u0007    rmb   1
u0008    rmb   2
u000A    rmb   1
u000B    rmb   1
u000C    rmb   1
u000D    rmb   4
u0011    rmb   14
u001F    rmb   1
u0020    rmb   1
u0021    rmb   2
u0023    rmb   2
u0025    rmb   2
u0027    rmb   2
u0029    rmb   2
u002B    rmb   2
u002D    rmb   7
u0034    rmb   3
u0037    rmb   10
u0041    rmb   1
u0042    rmb   1
u0043    rmb   6
u0049    rmb   3
u004C    rmb   3
u004F    rmb   1
u0050    rmb   2
u0052    rmb   1
u0053    rmb   3
u0056    rmb   1
u0057    rmb   1
u0058    rmb   1
u0059    rmb   1
u005A    rmb   1
u005B    rmb   9
u0064    rmb   132
u00E8    rmb   165
u018D    rmb   2
u018F    rmb   58
u01C9    rmb   1
u01CA    rmb   3
u01CD    rmb   14743
size     equ   .
name     equ   *
         fcs   /AnsiEd/
         fcb   $01 
L0014    fcb   $A6 &
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
L0023    sta   ,u+
         decb  
         bne   L0023
         ldx   ,s
         leau  ,x
         leax  >$37E4,x
         pshs  x
         leay  >L3B61,pcr
         ldx   ,y++
         beq   L003E
         bsr   L0014
         ldu   $02,s
L003E    leau  >u0001,u
         ldx   ,y++
         beq   L0049
         bsr   L0014
         clra  
L0049    cmpu  ,s
         beq   L0052
         sta   ,u+
         bra   L0049
L0052    ldu   $02,s
         ldd   ,y++
         beq   L005F
         leax  >L0000,pcr
         lbsr  L0162
L005F    ldd   ,y++
         beq   L0068
         leax  ,u
         lbsr  L0162
L0068    leas  $04,s
         puls  x
         stx   >u01CD,u
         sty   >u018D,u
         ldd   #$0001
         std   >u01C9,u
         leay  >u018F,u
         leax  ,s
         lda   ,x+
L0084    ldb   >u01CA,u
         cmpb  #$1D
         beq   L00E0
L008C    cmpa  #$0D
         beq   L00E0
         cmpa  #$20
         beq   L0098
         cmpa  #$2C
         bne   L009C
L0098    lda   ,x+
         bra   L008C
L009C    cmpa  #$22
         beq   L00A4
         cmpa  #$27
         bne   L00C2
L00A4    stx   ,y++
         inc   >u01CA,u
         pshs  a
L00AC    lda   ,x+
         cmpa  #$0D
         beq   L00B6
         cmpa  ,s
         bne   L00AC
L00B6    puls  b
         clr   -$01,x
         cmpa  #$0D
         beq   L00E0
         lda   ,x+
         bra   L0084
L00C2    leax  -$01,x
         stx   ,y++
         leax  $01,x
         inc   >u01CA,u
L00CC    cmpa  #$0D
         beq   L00DC
         cmpa  #$20
         beq   L00DC
         cmpa  #$2C
         beq   L00DC
         lda   ,x+
         bra   L00CC
L00DC    clr   -$01,x
         bra   L0084
L00E0    leax  >u018D,u
         pshs  x
         ldd   >u01C9,u
         pshs  b,a
         leay  ,u
         bsr   L00FA
         lbsr  L017C
         clr   ,-s
         clr   ,-s
         lbsr  L3A29
L00FA    leax  >$37E4,y
         stx   >$01D7,y
         sts   >$01CB,y
         sts   >$01D9,y
         ldd   #$FF82
L010F    leax  d,s
         cmpx  >$01D9,y
         bcc   L0121
         cmpx  >$01D7,y
         bcs   L013B
         stx   >$01D9,y
L0121    rts   
L0122    bpl   L014E
         bpl   L0150
         bra   L017B
         lsrb  
         fcb   $41 A
         coma  
         fcb   $4B K
         bra   L017D
         rorb  
         fcb   $45 E
         fcb   $52 R
         rora  
         inca  
         clra  
         asrb  
         bra   L0161
         bpl   L0163
         bpl   L0148
L013B    leax  <L0122,pcr
         ldb   #$CF
         pshs  b
         lda   #$02
         ldy   #$0064
L0148    os9   I$WritLn 
         clr   ,-s
         lbsr  L3A2F
L0150    ldd   >$01CB,y
         subd  >$01D9,y
         rts   
         ldd   >$01D9,y
         subd  >$01D7,y
L0161    rts   
L0162    pshs  x
         leax  d,y
         leax  d,x
         pshs  x
L016A    ldd   ,y++
         leax  d,u
         ldd   ,x
         addd  $02,s
         std   ,x
         cmpy  ,s
         bne   L016A
         leas  $04,s
L017B    rts   
L017C    pshs  u
         ldd   #$FF8A
         lbsr  L010F
         leas  <-$22,s
         lbsr  L02DF
         lbsr  L035D
         ldd   <$26,s
         cmpd  #$0001
         ble   L01A2
         ldx   <$28,s
         ldd   $02,x
         pshs  b,a
         lbsr  L0555
         leas  $02,s
L01A2    lbsr  L07B7
         ldd   <$26,s
         cmpd  #$0002
         ble   L01BB
         ldx   <$28,s
         ldd   $04,x
         pshs  b,a
         lbsr  L03E2
         lbra  L0284
L01BB    ldd   #$0004
         pshs  b,a
         ldd   #$0004
         pshs  b,a
         ldd   #$0006
         pshs  b,a
         ldd   #$0028
         pshs  b,a
         ldd   #$0006
         pshs  b,a
         ldd   #$0014
         pshs  b,a
         ldd   #$0001
         pshs  b,a
         ldd   #$0001
         pshs  b,a
         lbsr  L3A52
         leas  <$10,s
         ldd   #$0002
         pshs  b,a
         clra  
         clrb  
         pshs  b,a
         ldd   #$0004
         pshs  b,a
         ldd   #$0026
         pshs  b,a
         ldd   #$0007
         pshs  b,a
         ldd   #$0015
         pshs  b,a
         clra  
         clrb  
         pshs  b,a
         ldd   #$0001
         pshs  b,a
         lbsr  L3A52
         leas  <$10,s
         ldd   #$0001
         pshs  b,a
         lbsr  L252A
         leas  $02,s
         ldd   #$0001
         pshs  b,a
         lbsr  L3AEC
         leas  $02,s
         leax  >L266E,pcr
         pshs  x
         lbsr  L2D4D
         leas  $02,s
         leax  >$0049,y
         pshs  x
         lbsr  L337C
         leas  $02,s
         ldd   #$0020
         pshs  b,a
         leax  $04,s
         pshs  x
         clra  
         clrb  
         pshs  b,a
         lbsr  L38C5
         leas  $06,s
         std   ,s
         cmpd  #$0001
         bgt   L0269
         ldx   <$28,s
         ldd   $02,x
         pshs  b,a
         leax  $04,s
         pshs  x
         lbsr  L3556
         leas  $04,s
L0269    leax  $02,s
         pshs  x
         lbsr  L03E2
         leas  $02,s
         ldd   #$0001
         pshs  b,a
         lbsr  L3A82
         leas  $02,s
         ldd   #$0001
         pshs  b,a
         lbsr  L3A82
L0284    leas  $02,s
         ldd   #$0001
         pshs  b,a
         lbsr  L3A82
         leas  $02,s
         ldd   #$0001
         pshs  b,a
         lbsr  L3AEC
         leas  $02,s
         ldd   #$0001
         pshs  b,a
         lbsr  L3AFB
         leas  $02,s
         leax  >L2682,pcr
         pshs  x
         lbsr  L2D4D
         leas  $02,s
         leax  >L26AB,pcr
         pshs  x
         lbsr  L2D4D
         leas  $02,s
         leax  >L26D4,pcr
         pshs  x
         lbsr  L2D4D
         leas  $02,s
         leax  >L26FD,pcr
         pshs  x
         lbsr  L2D4D
         leas  $02,s
         ldd   #$0001
         pshs  b,a
         lbsr  L3B00
         leas  $02,s
         leas  <$22,s
         puls  pc,u
L02DF    pshs  u
         ldd   #$FFAC
         lbsr  L010F
         ldd   #$0001
         pshs  b,a
         lbsr  L3AEC
         leas  $02,s
         ldd   #$0002
         pshs  b,a
         clra  
         clrb  
         pshs  b,a
         ldd   #$0017
         pshs  b,a
         ldd   #$0050
         pshs  b,a
         clra  
         clrb  
         pshs  b,a
         clra  
         clrb  
         pshs  b,a
         ldd   #$0001
         pshs  b,a
         ldd   #$0001
         pshs  b,a
         lbsr  L3A52
         leas  <$10,s
         clra  
         clrb  
         pshs  b,a
         ldd   #$0002
         pshs  b,a
         ldd   #$0001
         pshs  b,a
         ldd   #$0050
         pshs  b,a
         ldd   #$0017
         pshs  b,a
         clra  
         clrb  
         pshs  b,a
         clra  
         clrb  
         pshs  b,a
         ldd   #$0001
         pshs  b,a
         lbsr  L3A52
         leas  <$10,s
         ldd   #$0001
         pshs  b,a
         lbsr  L3AEC
         leas  $02,s
         ldd   #$0001
         pshs  b,a
         lbsr  L3A82
         leas  $02,s
         puls  pc,u
L035D    pshs  u
         ldd   #$FFB5
         lbsr  L010F
         leas  -$05,s
         clra  
         clrb  
         lbra  L03BE
L036C    clra  
         clrb  
         bra   L03AF
L0370    ldd   $01,s
         pshs  b,a
         ldd   #$0050
         lbsr  L365D
         leax  >$2225,y
         leax  d,x
         ldd   $03,s
         leax  d,x
         clra  
         clrb  
         stb   ,x
         ldd   $01,s
         pshs  b,a
         ldd   #$00A0
         lbsr  L365D
         leax  >$2955,y
         leax  d,x
         tfr   x,d
         pshs  b,a
         ldd   $05,s
         lslb  
         rola  
         addd  ,s++
         tfr   d,x
         ldd   >$0009,y
         std   ,x
         ldd   $01,s
         addd  #$0001
L03AF    std   $01,s
         ldd   $01,s
         cmpd  #$0017
         blt   L0370
         ldd   $03,s
         addd  #$0001
L03BE    std   $03,s
         ldd   $03,s
         cmpd  #$0050
         lblt  L036C
         ldd   #$0001
         pshs  b,a
         lbsr  L3AEC
         leas  $02,s
         ldd   #$0001
         std   >$0007,y
         lbsr  L20F0
         leas  $05,s
         puls  pc,u
L03E2    pshs  u
         ldd   #$FF9D
         lbsr  L010F
         leas  -$0F,s
         clra  
         clrb  
         std   >$0009,y
         ldd   #$0002
         pshs  b,a
         ldd   <$15,s
         pshs  b,a
         lbsr  L3849
         leas  $04,s
         std   $0D,s
         cmpd  #$FFFF
         bne   L0420
         ldd   >$01DB,y
         pshs  b,a
         leax  >L2726,pcr
         pshs  x
         lbsr  L2561
         leas  $04,s
         ldd   #$FFFF
         lbra  L0551
L0420    ldd   #$0004
         pshs  b,a
         ldd   #$0004
         pshs  b,a
         ldd   #$0006
         pshs  b,a
         ldd   #$001E
         pshs  b,a
         ldd   #$0003
         pshs  b,a
         ldd   #$000A
         pshs  b,a
         ldd   #$0001
         pshs  b,a
         ldd   #$0001
         pshs  b,a
         lbsr  L3A52
         leas  <$10,s
         ldd   #$0002
         pshs  b,a
         clra  
         clrb  
         pshs  b,a
         ldd   #$0004
         pshs  b,a
         ldd   #$001C
         pshs  b,a
         ldd   #$0004
         pshs  b,a
         ldd   #$000B
         pshs  b,a
         clra  
         clrb  
         pshs  b,a
         ldd   #$0001
         pshs  b,a
         lbsr  L3A52
         leas  <$10,s
         ldd   #$0001
         pshs  b,a
         lbsr  L3AEC
         leas  $02,s
         leax  >L273E,pcr
         pshs  x
         lbsr  L2D4D
         leas  $02,s
         leax  >$0049,y
         pshs  x
         lbsr  L337C
         leas  $02,s
         ldd   #$0001
         pshs  b,a
         leax  $02,s
         pshs  x
         clra  
         clrb  
         pshs  b,a
         lbsr  L38A4
         leas  $06,s
         ldb   ,s
         clra  
         andb  #$DF
         cmpd  #$004E
         beq   L04BA
         lbsr  L212A
L04BA    ldd   #$0001
         pshs  b,a
         lbsr  L3AEC
         leas  $02,s
         leax  >L2757,pcr
         pshs  x
         lbsr  L2D4D
         leas  $02,s
         leax  >$0049,y
         pshs  x
         lbsr  L337C
         leas  $02,s
         ldd   #$0001
         pshs  b,a
         leax  $02,s
         pshs  x
         clra  
         clrb  
         pshs  b,a
         lbsr  L38A4
         leas  $06,s
         ldb   ,s
         clra  
         andb  #$DF
         cmpd  #$0059
         bne   L051E
         ldd   #$001B
         stb   $01,s
         ldd   #$005B
         stb   $02,s
         ldd   #$0032
         stb   $03,s
         ldd   #$004A
         stb   $04,s
         ldd   #$0004
         pshs  b,a
         leax  $03,s
         pshs  x
         ldd   <$11,s
         pshs  b,a
         lbsr  L38D5
         leas  $06,s
L051E    ldd   #$0001
         pshs  b,a
         lbsr  L3A82
         leas  $02,s
         ldd   #$0001
         pshs  b,a
         lbsr  L3A82
         leas  $02,s
         ldd   >$000D,y
         pshs  b,a
         leax  >$0225,y
         pshs  x
         ldd   <$11,s
         pshs  b,a
         lbsr  L38D5
         leas  $06,s
         ldd   $0D,s
         pshs  b,a
         lbsr  L3837
         leas  $02,s
L0551    leas  $0F,s
         puls  pc,u
L0555    pshs  u
         ldd   #$FFA8
         lbsr  L010F
         leas  -$04,s
         ldd   #$0001
         pshs  b,a
         ldd   $0A,s
         pshs  b,a
         lbsr  L3828
         leas  $04,s
         std   $02,s
         cmpd  #$FFFF
         bne   L058C
         ldd   >$01DB,y
         pshs  b,a
         leax  >L2771,pcr
         pshs  x
         lbsr  L2561
         leas  $04,s
         ldd   #$FFFF
         lbra  L07B3
L058C    clra  
         clrb  
         std   >$0219,y
         clra  
         clrb  
         std   >$021B,y
         clra  
         clrb  
         std   >$0221,y
         clra  
         clrb  
         std   >$0223,y
         clra  
         clrb  
         std   >$021D,y
         clra  
         clrb  
         std   >$021F,y
         clra  
         clrb  
         pshs  b,a
         ldd   #$0002
         pshs  b,a
         ldd   #$0001
         pshs  b,a
         ldd   #$0050
         pshs  b,a
         ldd   #$0017
         pshs  b,a
         clra  
         clrb  
         pshs  b,a
         clra  
         clrb  
         pshs  b,a
         ldd   #$0001
         pshs  b,a
         lbsr  L3A52
         leas  <$10,s
         leax  >L2782,pcr
         pshs  x
         lbsr  L2D4D
         leas  $02,s
         leax  >$0049,y
         pshs  x
         lbsr  L337C
         leas  $02,s
         clra  
         clrb  
         bra   L060C
L05F5    ldd   #$0001
         pshs  b,a
         leax  $03,s
         pshs  x
         clra  
         clrb  
         pshs  b,a
         lbsr  L38A4
         leas  $06,s
         ldb   $01,s
         clra  
         andb  #$DF
L060C    stb   $01,s
         ldb   $01,s
         cmpb  #$4F
         beq   L061A
         ldb   $01,s
         cmpb  #$53
         bne   L05F5
L061A    ldb   $01,s
         cmpb  #$53
         bne   L0625
         ldd   #$0001
         bra   L0627
L0625    clra  
         clrb  
L0627    std   >$0007,y
         leax  >L27B3,pcr
         pshs  x
         lbsr  L2D4D
         leas  $02,s
         leax  >$0049,y
         pshs  x
         lbsr  L337C
         leas  $02,s
         clra  
         clrb  
         bra   L065C
L0645    ldd   #$0001
         pshs  b,a
         leax  $02,s
         pshs  x
         clra  
         clrb  
         pshs  b,a
         lbsr  L38A4
         leas  $06,s
         ldb   ,s
         clra  
         andb  #$DF
L065C    stb   ,s
         ldb   ,s
         cmpb  #$59
         beq   L066A
         ldb   ,s
         cmpb  #$4E
         bne   L0645
L066A    ldd   #$0001
         pshs  b,a
         lbsr  L3A82
         lbra  L0790
L0675    ldd   >$0007,y
         bne   L06B2
         ldd   >$000D,y
         addd  #$0001
         std   >$000D,y
         subd  #$0001
         leax  >$0225,y
         leax  d,x
         ldb   $01,s
         stb   ,x
         ldd   >$000D,y
         cmpd  #$2000
         blt   L06B2
         ldd   #$0001
         pshs  b,a
         lbsr  L3AD8
         leas  $02,s
         ldd   >$000D,y
         addd  #$FFFF
         std   >$000D,y
L06B2    ldb   $01,s
         cmpb  #$1B
         lbne  L076D
         ldd   >$0005,y
         lbne  L076D
         ldd   #$0001
         pshs  b,a
         leax  $03,s
         pshs  x
         ldd   $06,s
         pshs  b,a
         lbsr  L38A4
         leas  $06,s
         ldd   >$0007,y
         bne   L0711
         ldd   >$000D,y
         addd  #$0001
         std   >$000D,y
         subd  #$0001
         leax  >$0225,y
         leax  d,x
         ldb   $01,s
         stb   ,x
         ldd   >$000D,y
         cmpd  #$2000
         blt   L0711
         ldd   #$0001
         pshs  b,a
         lbsr  L3AD8
         leas  $02,s
         ldd   >$000D,y
         addd  #$FFFF
         std   >$000D,y
L0711    ldb   $01,s
         cmpb  #$5B
         bne   L076D
         ldd   #$0001
         std   >$0005,y
         ldd   #$0001
         pshs  b,a
         leax  $03,s
         pshs  x
         ldd   $06,s
         pshs  b,a
         lbsr  L38A4
         leas  $06,s
         ldd   >$0007,y
         bne   L076D
         ldd   >$000D,y
         addd  #$0001
         std   >$000D,y
         subd  #$0001
         leax  >$0225,y
         leax  d,x
         ldb   $01,s
         stb   ,x
         ldd   >$000D,y
         cmpd  #$2000
         blt   L076D
         ldd   #$0001
         pshs  b,a
         lbsr  L3AD8
         leas  $02,s
         ldd   >$000D,y
         addd  #$FFFF
         std   >$000D,y
L076D    ldb   ,s
         cmpb  #$59
         bne   L0788
         ldb   $01,s
         cmpb  #$0D
         bne   L0788
         ldb   $01,s
         sex   
         pshs  b,a
         lbsr  L19C1
         leas  $02,s
         ldd   #$000A
         bra   L078B
L0788    ldb   $01,s
         sex   
L078B    pshs  b,a
         lbsr  L19C1
L0790    leas  $02,s
         ldd   #$0001
         pshs  b,a
         leax  $03,s
         pshs  x
         ldd   $06,s
         pshs  b,a
         lbsr  L38A4
         leas  $06,s
         std   -$02,s
         lbne  L0675
         ldd   $02,s
         pshs  b,a
         lbsr  L3837
         leas  $02,s
L07B3    leas  $04,s
         puls  pc,u
L07B7    pshs  u
         ldd   #$FF88
         lbsr  L010F
         leas  <-$24,s
         clra  
         clrb  
         pshs  b,a
         lbsr  L252A
         leas  $02,s
         clra  
         clrb  
         pshs  b,a
         ldd   #$0002
         pshs  b,a
         ldd   #$0001
         pshs  b,a
         ldd   #$0050
         pshs  b,a
         ldd   #$0017
         pshs  b,a
         clra  
         clrb  
         pshs  b,a
         clra  
         clrb  
         pshs  b,a
         ldd   #$0001
         pshs  b,a
         lbsr  L3A52
         leas  <$10,s
         ldd   #$0001
         pshs  b,a
         lbsr  L3AEC
         leas  $02,s
         ldd   #$0001
         pshs  b,a
         lbsr  L3A82
         leas  $02,s
         lbra  L14E4
L080D    clra  
         clrb  
         pshs  b,a
         ldd   #$0002
         pshs  b,a
         ldd   #$0001
         pshs  b,a
         ldd   #$0050
         pshs  b,a
         ldd   #$0017
         pshs  b,a
         clra  
         clrb  
         pshs  b,a
         clra  
         clrb  
         pshs  b,a
         ldd   #$0001
         pshs  b,a
         lbsr  L3A52
         leas  <$10,s
         ldd   >$021B,y
         addd  #$0001
         pshs  b,a
         ldd   >$0219,y
         addd  #$0001
         pshs  b,a
         leax  >L27D8,pcr
         pshs  x
         lbsr  L2D4D
         leas  $06,s
         ldd   >$0007,y
         beq   L0861
         leax  >L27EE,pcr
         bra   L0865
L0861    leax  >L27F8,pcr
L0865    pshs  x
         lbsr  L2D4D
         leas  $02,s
         ldd   >$021B,y
         pshs  b,a
         ldd   #$0050
         lbsr  L365D
         leax  >$2225,y
         leax  d,x
         ldd   >$0219,y
         leax  d,x
         ldb   ,x
         beq   L08B2
         ldd   >$021B,y
         pshs  b,a
         ldd   #$0050
         lbsr  L365D
         leax  >$2225,y
         leax  d,x
         ldd   >$0219,y
         leax  d,x
         ldb   ,x
         sex   
         pshs  b,a
         leax  >L2802,pcr
         pshs  x
         lbsr  L2D4D
         leas  $04,s
         bra   L08BD
L08B2    leax  >L280D,pcr
         pshs  x
         lbsr  L2D4D
         leas  $02,s
L08BD    leax  >L2816,pcr
         pshs  x
         lbsr  L2D4D
         leas  $02,s
         ldd   >$0009,y
         anda  #$01
         clrb  
         std   -$02,s
         beq   L08D9
         leax  >L281F,pcr
         bra   L08DD
L08D9    leax  >L2821,pcr
L08DD    pshs  x
         lbsr  L2D4D
         leas  $02,s
         ldd   >$0009,y
         anda  #$02
         clrb  
         std   -$02,s
         beq   L08F5
         leax  >L2823,pcr
         bra   L08F9
L08F5    leax  >L2825,pcr
L08F9    pshs  x
         lbsr  L2D4D
         leas  $02,s
         ldd   >$0009,y
         anda  #$04
         clrb  
         std   -$02,s
         beq   L0911
         leax  >L2827,pcr
         bra   L0915
L0911    leax  >L2829,pcr
L0915    pshs  x
         lbsr  L2D4D
         leas  $02,s
         ldd   >$0009,y
         anda  #$08
         clrb  
         std   -$02,s
         beq   L092D
         leax  >L282B,pcr
         bra   L0931
L092D    leax  >L282D,pcr
L0931    pshs  x
         lbsr  L2D4D
         leas  $02,s
         ldd   >$0009,y
         anda  #$10
         clrb  
         std   -$02,s
         beq   L0949
         leax  >L282F,pcr
         bra   L094D
L0949    leax  >L2831,pcr
L094D    pshs  x
         lbsr  L2D4D
         leas  $02,s
         ldd   >$0009,y
         pshs  b,a
         ldd   #$0100
         lbsr  L36BE
         beq   L09A2
         ldd   >$0009,y
         pshs  b,a
         ldd   #$0010
         lbsr  L36BE
         lslb  
         rola  
         leax  >$001F,y
         leax  d,x
         ldd   ,x
         pshs  b,a
         ldd   >$0009,y
         clra  
         andb  #$F0
         pshs  b,a
         ldd   #$0010
         lbsr  L3711
         lslb  
         rola  
         leax  >$001F,y
         leax  d,x
         ldd   ,x
         pshs  b,a
         leax  >L2833,pcr
         pshs  x
         lbsr  L2D4D
         leas  $06,s
         bra   L09AD
L09A2    leax  >L2846,pcr
         pshs  x
         lbsr  L2D4D
         leas  $02,s
L09AD    leax  >$0049,y
         pshs  x
         lbsr  L337C
         leas  $02,s
         ldd   #$0001
         pshs  b,a
         lbsr  L3A82
         leas  $02,s
         ldd   #$0001
         pshs  b,a
         leax  <$25,s
         pshs  x
         clra  
         clrb  
         pshs  b,a
         lbsr  L38A4
         leas  $06,s
         ldd   #$0001
         std   >$0005,y
         ldb   <$23,s
         sex   
         tfr   d,x
         lbra  L1463
L09E5    ldd   #$0004
         pshs  b,a
         ldd   #$0004
         pshs  b,a
         ldd   #$0013
         pshs  b,a
         ldd   #$0028
         pshs  b,a
         ldd   #$0002
         pshs  b,a
         ldd   #$0014
         pshs  b,a
         ldd   #$0001
         pshs  b,a
         ldd   #$0001
         pshs  b,a
         lbsr  L3A52
         leas  <$10,s
         ldd   #$0002
         pshs  b,a
         clra  
         clrb  
         pshs  b,a
         ldd   #$0011
         pshs  b,a
         ldd   #$0026
         pshs  b,a
         ldd   #$0003
         pshs  b,a
         ldd   #$0015
         pshs  b,a
         clra  
         clrb  
         pshs  b,a
         ldd   #$0001
         pshs  b,a
         lbsr  L3A52
         leas  <$10,s
         ldd   #$0001
         pshs  b,a
         lbsr  L3AEC
         leas  $02,s
         leax  >L2861,pcr
         pshs  x
         lbsr  L2D4D
         leas  $02,s
         leax  >L287F,pcr
         pshs  x
         lbsr  L2D4D
         leas  $02,s
         leax  >L28A7,pcr
         pshs  x
         lbsr  L2D4D
         leas  $02,s
         leax  >L28C1,pcr
         pshs  x
         lbsr  L2D4D
         leas  $02,s
         leax  >L28DA,pcr
         pshs  x
         lbsr  L2D4D
         leas  $02,s
         leax  >L28F1,pcr
         pshs  x
         lbsr  L2D4D
         leas  $02,s
         leax  >L290B,pcr
         pshs  x
         lbsr  L2D4D
         leas  $02,s
         leax  >L292D,pcr
         pshs  x
         lbsr  L2D4D
         leas  $02,s
         leax  >L294F,pcr
         pshs  x
         lbsr  L2D4D
         leas  $02,s
         leax  >L2974,pcr
         pshs  x
         lbsr  L2D4D
         leas  $02,s
         leax  >L2998,pcr
         pshs  x
         lbsr  L2D4D
         leas  $02,s
         leax  >L29B4,pcr
         pshs  x
         lbsr  L2D4D
         leas  $02,s
         leax  >L29CE,pcr
         pshs  x
         lbsr  L2D4D
         leas  $02,s
         leax  >L29E7,pcr
         pshs  x
         lbsr  L2D4D
         leas  $02,s
         leax  >L2A00,pcr
         pshs  x
         lbsr  L2D4D
         leas  $02,s
         ldd   #$0001
         pshs  b,a
         lbsr  L3ACA
         leas  $02,s
L0AF8    clra  
         clrb  
         pshs  b,a
         lbsr  L3A35
         leas  $02,s
         cmpd  #$FFFF
         beq   L0AF8
         ldd   #$0001
         pshs  b,a
         lbsr  L3ACF
         leas  $02,s
         ldd   #$0001
         pshs  b,a
         lbsr  L3A82
         leas  $02,s
         ldd   #$0001
         pshs  b,a
         lbsr  L3A82
         lbra  L145E
L0B26    ldd   #$0004
         pshs  b,a
         ldd   #$0004
         pshs  b,a
         ldd   #$0006
         pshs  b,a
         ldd   #$0014
         pshs  b,a
         ldd   #$0003
         pshs  b,a
         ldd   #$0005
         pshs  b,a
         ldd   #$0001
         pshs  b,a
         ldd   #$0001
         pshs  b,a
         lbsr  L3A52
         leas  <$10,s
         ldd   #$0002
         pshs  b,a
         clra  
         clrb  
         pshs  b,a
         ldd   #$0004
         pshs  b,a
         ldd   #$0012
         pshs  b,a
         ldd   #$0004
         pshs  b,a
         ldd   #$0006
         pshs  b,a
         clra  
         clrb  
         pshs  b,a
         ldd   #$0001
         pshs  b,a
         lbsr  L3A52
         leas  <$10,s
         ldd   #$0001
         pshs  b,a
         lbsr  L3AEC
         leas  $02,s
         leax  >L2A1F,pcr
         pshs  x
         lbsr  L2D4D
         leas  $02,s
         leax  >$0049,y
         pshs  x
         lbsr  L337C
         leas  $02,s
         ldd   #$0001
         pshs  b,a
         leax  <$25,s
         pshs  x
         clra  
         clrb  
         pshs  b,a
         lbsr  L38A4
         leas  $06,s
         ldd   #$0001
         pshs  b,a
         lbsr  L3A82
         leas  $02,s
         ldd   #$0001
         pshs  b,a
         lbsr  L3A82
         leas  $02,s
         ldb   <$23,s
         clra  
         andb  #$DF
         cmpd  #$0059
         lbne  L14E4
         ldd   #$0001
         pshs  b,a
         lbsr  L3A82
         leas  $02,s
         ldd   #$0001
         pshs  b,a
         lbsr  L3AEC
         leas  $02,s
         ldd   #$0001
         pshs  b,a
         lbsr  L3AFB
         leas  $02,s
         leax  >L2A30,pcr
         pshs  x
         lbsr  L2D4D
         leas  $02,s
         leax  >L2A59,pcr
         pshs  x
         lbsr  L2D4D
         leas  $02,s
         leax  >L2A82,pcr
         pshs  x
         lbsr  L2D4D
         leas  $02,s
         leax  >L2AAB,pcr
         pshs  x
         lbsr  L2D4D
         leas  $02,s
         ldd   #$0001
         pshs  b,a
         lbsr  L3B00
         leas  $02,s
         ldd   #$0001
         pshs  b,a
         lbsr  L252A
         leas  $02,s
         clra  
         clrb  
         pshs  b,a
         lbsr  L3A29
         lbra  L145E
L0C3D    ldd   #$0004
         pshs  b,a
         ldd   #$0004
         pshs  b,a
         ldd   #$0006
         pshs  b,a
         ldd   #$0028
         pshs  b,a
         ldd   #$0006
         pshs  b,a
         ldd   #$0014
         pshs  b,a
         ldd   #$0001
         pshs  b,a
         ldd   #$0001
         pshs  b,a
         lbsr  L3A52
         leas  <$10,s
         ldd   #$0002
         pshs  b,a
         clra  
         clrb  
         pshs  b,a
         ldd   #$0004
         pshs  b,a
         ldd   #$0026
         pshs  b,a
         ldd   #$0007
         pshs  b,a
         ldd   #$0015
         pshs  b,a
         clra  
         clrb  
         pshs  b,a
         ldd   #$0001
         pshs  b,a
         lbsr  L3A52
         leas  <$10,s
         ldd   #$0001
         pshs  b,a
         lbsr  L252A
         leas  $02,s
         ldd   #$0001
         pshs  b,a
         lbsr  L3AEC
         leas  $02,s
         leax  >L2AD4,pcr
         pshs  x
         lbsr  L2D4D
         leas  $02,s
         leax  >$0049,y
         pshs  x
         lbsr  L337C
         leas  $02,s
         ldd   #$0020
         pshs  b,a
         leax  $04,s
         pshs  x
         clra  
         clrb  
         pshs  b,a
         lbsr  L38C5
         leas  $06,s
         std   ,s
         ldd   #$0001
         pshs  b,a
         lbsr  L3A82
         leas  $02,s
         ldd   #$0001
         pshs  b,a
         lbsr  L3A82
         leas  $02,s
         clra  
         clrb  
         pshs  b,a
         lbsr  L252A
         leas  $02,s
         ldd   ,s
         cmpd  #$0001
         bgt   L0CFD
         lbra  L14E4
L0CFD    leax  $02,s
         pshs  x
         lbsr  L0555
         lbra  L145E
L0D07    ldd   #$0004
         pshs  b,a
         ldd   #$0004
         pshs  b,a
         ldd   #$0006
         pshs  b,a
         ldd   #$0028
         pshs  b,a
         ldd   #$0006
         pshs  b,a
         ldd   #$0014
         pshs  b,a
         ldd   #$0001
         pshs  b,a
         ldd   #$0001
         pshs  b,a
         lbsr  L3A52
         leas  <$10,s
         ldd   #$0002
         pshs  b,a
         clra  
         clrb  
         pshs  b,a
         ldd   #$0004
         pshs  b,a
         ldd   #$0026
         pshs  b,a
         ldd   #$0007
         pshs  b,a
         ldd   #$0015
         pshs  b,a
         clra  
         clrb  
         pshs  b,a
         ldd   #$0001
         pshs  b,a
         lbsr  L3A52
         leas  <$10,s
         ldd   #$0001
         pshs  b,a
         lbsr  L252A
         leas  $02,s
         ldd   #$0001
         pshs  b,a
         lbsr  L3AEC
         leas  $02,s
         leax  >L2AE8,pcr
         pshs  x
         lbsr  L2D4D
         leas  $02,s
         leax  >$0049,y
         pshs  x
         lbsr  L337C
         leas  $02,s
         ldd   #$0020
         pshs  b,a
         leax  $04,s
         pshs  x
         clra  
         clrb  
         pshs  b,a
         lbsr  L38C5
         leas  $06,s
         std   ,s
         ldd   #$0001
         pshs  b,a
         lbsr  L3A82
         leas  $02,s
         ldd   #$0001
         pshs  b,a
         lbsr  L3A82
         leas  $02,s
         clra  
         clrb  
         pshs  b,a
         lbsr  L252A
         leas  $02,s
         ldd   ,s
         cmpd  #$0001
         bgt   L0DC7
         lbra  L14E4
L0DC7    leax  $02,s
         pshs  x
         lbsr  L03E2
         lbra  L145E
L0DD1    ldd   #$0041
         pshs  b,a
         lbsr  L19C1
         leas  $02,s
         ldd   >$0007,y
         lbne  L14E4
         ldd   #$0041
         lbra  L0FA6
L0DE9    ldd   #$0042
         pshs  b,a
         lbsr  L19C1
         leas  $02,s
         ldd   >$0007,y
         lbne  L14E4
         ldd   #$0042
         lbra  L0FA6
L0E01    ldd   #$0044
         pshs  b,a
         lbsr  L19C1
         leas  $02,s
         ldd   >$0007,y
         lbne  L14E4
         ldd   #$0044
         lbra  L0FA6
L0E19    ldd   #$0043
         pshs  b,a
         lbsr  L19C1
         leas  $02,s
         ldd   >$0007,y
         lbne  L14E4
         ldd   #$0043
         lbra  L0FA6
L0E31    ldd   #$0004
         pshs  b,a
         ldd   #$0004
         pshs  b,a
         ldd   #$0006
         pshs  b,a
         ldd   #$0014
         pshs  b,a
         ldd   #$0003
         pshs  b,a
         ldd   #$000A
         pshs  b,a
         ldd   #$0001
         pshs  b,a
         ldd   #$0001
         pshs  b,a
         lbsr  L3A52
         leas  <$10,s
         ldd   #$0002
         pshs  b,a
         clra  
         clrb  
         pshs  b,a
         ldd   #$0004
         pshs  b,a
         ldd   #$0012
         pshs  b,a
         ldd   #$0004
         pshs  b,a
         ldd   #$000B
         pshs  b,a
         clra  
         clrb  
         pshs  b,a
         ldd   #$0001
         pshs  b,a
         lbsr  L3A52
         leas  <$10,s
         ldd   #$0001
         pshs  b,a
         lbsr  L3AEC
         leas  $02,s
         leax  >L2AFC,pcr
         pshs  x
         lbsr  L2D4D
         leas  $02,s
         ldd   #$0005
         pshs  b,a
         lbsr  L363F
         leas  $02,s
         ldd   #$0001
         pshs  b,a
         lbsr  L3A82
         leas  $02,s
         ldd   #$0001
         pshs  b,a
         lbsr  L3A82
         leas  $02,s
         ldd   #$0073
         pshs  b,a
         lbsr  L19C1
         leas  $02,s
         ldd   >$0007,y
         lbne  L14E4
         ldd   #$0073
         lbra  L0FA6
L0ED6    ldd   #$0004
         pshs  b,a
         ldd   #$0004
         pshs  b,a
         ldd   #$0006
         pshs  b,a
         ldd   #$0014
         pshs  b,a
         ldd   #$0003
         pshs  b,a
         ldd   #$000A
         pshs  b,a
         ldd   #$0001
         pshs  b,a
         ldd   #$0001
         pshs  b,a
         lbsr  L3A52
         leas  <$10,s
         ldd   #$0002
         pshs  b,a
         clra  
         clrb  
         pshs  b,a
         ldd   #$0004
         pshs  b,a
         ldd   #$0012
         pshs  b,a
         ldd   #$0004
         pshs  b,a
         ldd   #$000B
         pshs  b,a
         clra  
         clrb  
         pshs  b,a
         ldd   #$0001
         pshs  b,a
         lbsr  L3A52
         leas  <$10,s
         ldd   #$0001
         pshs  b,a
         lbsr  L3AEC
         leas  $02,s
         leax  >L2B0F,pcr
         pshs  x
         lbsr  L2D4D
         leas  $02,s
         ldd   #$0005
         pshs  b,a
         lbsr  L363F
         leas  $02,s
         ldd   #$0001
         pshs  b,a
         lbsr  L3A82
         leas  $02,s
         ldd   #$0001
         pshs  b,a
         lbsr  L3A82
         leas  $02,s
         ldd   #$0075
         pshs  b,a
         lbsr  L19C1
         leas  $02,s
         ldd   >$0007,y
         lbne  L14E4
         ldd   #$0075
         bra   L0FA6
L0F7A    ldd   #$004A
         pshs  b,a
         lbsr  L19C1
         leas  $02,s
         ldd   >$0007,y
         lbne  L14E4
         ldd   #$004A
         bra   L0FA6
L0F91    ldd   #$006B
         pshs  b,a
         lbsr  L19C1
         leas  $02,s
         ldd   >$0007,y
         lbne  L14E4
         ldd   #$006B
L0FA6    pshs  b,a
         lbsr  L1933
         lbra  L145E
L0FAE    lbsr  L14EC
         lbra  L14E4
L0FB4    ldd   >$0219,y
         cmpd  >$021D,y
         bne   L0FCC
         ldd   >$021B,y
         cmpd  >$021F,y
         lbeq  L10F3
L0FCC    ldd   >$000D,y
         addd  #$0008
         cmpd  #$2000
         lbge  L10E9
         ldd   >$000D,y
         addd  #$0001
         std   >$000D,y
         subd  #$0001
         leax  >$0225,y
         leax  d,x
         ldd   #$001B
         stb   ,x
         ldd   >$000D,y
         addd  #$0001
         std   >$000D,y
         subd  #$0001
         leax  >$0225,y
         leax  d,x
         ldd   #$005B
         stb   ,x
         ldd   >$000D,y
         addd  #$0001
         std   >$000D,y
         subd  #$0001
         leax  >$0225,y
         leax  d,x
         pshs  x
         ldd   >$021B,y
         addd  #$0001
         pshs  b,a
         ldd   #$000A
         lbsr  L3711
         addd  #$0030
         stb   [,s++]
         ldd   >$000D,y
         addd  #$0001
         std   >$000D,y
         subd  #$0001
         leax  >$0225,y
         leax  d,x
         pshs  x
         ldd   >$021B,y
         addd  #$0001
         pshs  b,a
         ldd   #$000A
         lbsr  L36BE
         addd  #$0030
         stb   [,s++]
         ldd   >$000D,y
         addd  #$0001
         std   >$000D,y
         subd  #$0001
         leax  >$0225,y
         leax  d,x
         ldd   #$003B
         stb   ,x
         ldd   >$000D,y
         addd  #$0001
         std   >$000D,y
         subd  #$0001
         leax  >$0225,y
         leax  d,x
         pshs  x
         ldd   >$0219,y
         addd  #$0001
         pshs  b,a
         ldd   #$000A
         lbsr  L3711
         addd  #$0030
         stb   [,s++]
         ldd   >$000D,y
         addd  #$0001
         std   >$000D,y
         subd  #$0001
         leax  >$0225,y
         leax  d,x
         pshs  x
         ldd   >$0219,y
         addd  #$0001
         pshs  b,a
         ldd   #$000A
         lbsr  L36BE
         addd  #$0030
         stb   [,s++]
         ldd   >$000D,y
         addd  #$0001
         std   >$000D,y
         subd  #$0001
         leax  >$0225,y
         leax  d,x
         ldd   #$0048
         stb   ,x
         bra   L10F3
L10E9    ldd   #$0001
         pshs  b,a
         lbsr  L3AD8
         leas  $02,s
L10F3    clra  
         clrb  
         std   >$0007,y
         ldd   >$0219,y
         std   >$021D,y
         ldd   >$021B,y
         std   >$021F,y
         lbra  L14E4
L110C    ldd   #$0001
         std   >$0007,y
         lbra  L14E4
L1116    ldd   #$0004
         pshs  b,a
         ldd   #$0004
         pshs  b,a
         ldd   #$0006
         pshs  b,a
         ldd   #$001E
         pshs  b,a
         ldd   #$0003
         pshs  b,a
         ldd   #$000A
         pshs  b,a
         ldd   #$0001
         pshs  b,a
         ldd   #$0001
         pshs  b,a
         lbsr  L3A52
         leas  <$10,s
         ldd   #$0002
         pshs  b,a
         clra  
         clrb  
         pshs  b,a
         ldd   #$0004
         pshs  b,a
         ldd   #$001C
         pshs  b,a
         ldd   #$0004
         pshs  b,a
         ldd   #$000B
         pshs  b,a
         clra  
         clrb  
         pshs  b,a
         ldd   #$0001
         pshs  b,a
         lbsr  L3A52
         leas  <$10,s
         ldd   #$0001
         pshs  b,a
         lbsr  L3AEC
         leas  $02,s
         leax  >L2B23,pcr
         pshs  x
         lbsr  L2D4D
         leas  $02,s
         lbsr  L212A
         ldd   #$0001
         pshs  b,a
         lbsr  L3A82
         leas  $02,s
         ldd   #$0001
         pshs  b,a
         lbsr  L3A82
         lbra  L145E
L119D    ldd   #$0001
         pshs  b,a
         lbsr  L252A
         leas  $02,s
         leas  <$24,s
         puls  pc,u
L11AC    ldd   #$0004
         pshs  b,a
         ldd   #$0004
         pshs  b,a
         ldd   #$000A
         pshs  b,a
         ldd   #$001E
         pshs  b,a
         ldd   #$0003
         pshs  b,a
         ldd   #$0005
         pshs  b,a
         ldd   #$0001
         pshs  b,a
         ldd   #$0001
         pshs  b,a
         lbsr  L3A52
         leas  <$10,s
         ldd   #$0002
         pshs  b,a
         clra  
         clrb  
         pshs  b,a
         ldd   #$0008
         pshs  b,a
         ldd   #$001C
         pshs  b,a
         ldd   #$0004
         pshs  b,a
         ldd   #$0006
         pshs  b,a
         clra  
         clrb  
         pshs  b,a
         ldd   #$0001
         pshs  b,a
         lbsr  L3A52
         leas  <$10,s
         ldd   #$0001
         pshs  b,a
         lbsr  L3AEC
         leas  $02,s
         leax  >L2B3E,pcr
         pshs  x
         lbsr  L2D4D
         leas  $02,s
         leax  >L2B58,pcr
         pshs  x
         lbsr  L2D4D
         leas  $02,s
         leax  >L2B71,pcr
         pshs  x
         lbsr  L2D4D
         leas  $02,s
         leax  >L2B8B,pcr
         pshs  x
         lbsr  L2D4D
         leas  $02,s
         leax  >L2BA7,pcr
         pshs  x
         lbsr  L2D4D
         leas  $02,s
         leax  >L2BC3,pcr
         pshs  x
         lbsr  L2D4D
         leas  $02,s
         leax  >$0049,y
         pshs  x
         lbsr  L337C
         leas  $02,s
         ldd   #$0001
         pshs  b,a
         leax  <$24,s
         pshs  x
         clra  
         clrb  
         pshs  b,a
         lbsr  L38A4
         leas  $06,s
         ldb   <$22,s
         clra  
         andb  #$DF
         stb   <$22,s
         clra  
         clrb  
         stb   <$23,s
         ldb   <$22,s
         cmpb  #$53
         beq   L12A1
         ldb   <$22,s
         cmpb  #$52
         beq   L12A1
         ldb   <$22,s
         cmpb  #$42
         beq   L12A1
         ldb   <$22,s
         cmpb  #$44
         beq   L12A1
         ldb   <$22,s
         cmpb  #$54
         bne   L12CA
L12A1    leax  >L2BD0,pcr
         pshs  x
         lbsr  L2D4D
         leas  $02,s
         leax  >$0049,y
         pshs  x
         lbsr  L337C
         leas  $02,s
         ldd   #$0001
         pshs  b,a
         leax  <$25,s
         pshs  x
         clra  
         clrb  
         pshs  b,a
         lbsr  L38A4
         leas  $06,s
L12CA    ldd   #$0001
         pshs  b,a
         lbsr  L3A82
         leas  $02,s
         ldd   #$0001
         pshs  b,a
         lbsr  L3A82
         leas  $02,s
         ldb   <$23,s
         clra  
         andb  #$DF
         cmpd  #$0059
         lbne  L14E4
         ldb   <$22,s
         clra  
         andb  #$DF
         tfr   d,x
         lbra  L13F0
L12F7    clra  
         clrb  
         std   >$0009,y
         clra  
         clrb  
         pshs  b,a
         ldd   #$0001
         pshs  b,a
         lbsr  L3A9F
         leas  $04,s
         ldd   #$0002
         pshs  b,a
         ldd   #$0001
         pshs  b,a
         lbsr  L3AA3
         leas  $04,s
         lbsr  L035D
         ldd   #$004A
         pshs  b,a
         lbsr  L19C1
         lbra  L13EB
L1328    clra  
         clrb  
         pshs  b,a
         ldd   #$0001
         pshs  b,a
         lbsr  L3A9F
         leas  $04,s
         ldd   #$0002
         pshs  b,a
         ldd   #$0001
         pshs  b,a
         lbsr  L3AA3
         leas  $04,s
         lbsr  L035D
         ldd   #$004A
         pshs  b,a
         lbsr  L19C1
         leas  $02,s
L1352    clra  
         clrb  
         std   >$0009,y
         clra  
         clrb  
         std   >$000D,y
         lbra  L14E4
L1361    ldd   >$0219,y
         pshs  b,a
         ldd   #$0050
         lbsr  L365D
         leax  >$2225,y
         leax  d,x
         ldd   >$021B,y
         leax  d,x
         clra  
         clrb  
         stb   ,x
         ldd   >$0219,y
         pshs  b,a
         ldd   #$00A0
         lbsr  L365D
         leax  >$2955,y
         leax  d,x
         tfr   x,d
         pshs  b,a
         ldd   >$021B,y
         lslb  
         rola  
         addd  ,s++
         tfr   d,x
         clra  
         clrb  
         std   ,x
         ldd   #$0001
         pshs  b,a
         leax  >L2BE6,pcr
         pshs  x
         ldd   #$0001
         pshs  b,a
         lbsr  L38D5
         leas  $06,s
         lbra  L14E4
L13B9    ldd   >$000D,y
         addd  #$FFFF
         std   >$000D,y
         ldd   #$0001
         pshs  b,a
         lbsr  L3ADC
         leas  $02,s
         ldd   #$0001
         pshs  b,a
         leax  >L2BE8,pcr
         pshs  x
         ldd   #$0001
         pshs  b,a
         lbsr  L38D5
         leas  $06,s
         ldd   #$0001
         pshs  b,a
         lbsr  L3ADC
L13EB    leas  $02,s
         lbra  L14E4
L13F0    cmpx  #$0053
         lbeq  L12F7
         cmpx  #$0052
         lbeq  L1352
         cmpx  #$0042
         lbeq  L1328
         cmpx  #$0044
         lbeq  L1361
         cmpx  #$0054
         beq   L13B9
         lbra  L14E4
L1414    clra  
         clrb  
         std   >$0005,y
         ldb   <$23,s
         sex   
         pshs  b,a
         lbsr  L19C1
         leas  $02,s
         ldd   >$0007,y
         lbne  L14E4
         ldd   >$000D,y
         addd  #$0001
         cmpd  #$2000
         bge   L1456
         ldd   >$000D,y
         addd  #$0001
         std   >$000D,y
         subd  #$0001
         leax  >$0225,y
         leax  d,x
         ldb   <$23,s
         stb   ,x
         lbra  L14E4
L1456    ldd   #$0001
         pshs  b,a
         lbsr  L3AD8
L145E    leas  $02,s
         lbra  L14E4
L1463    cmpx  #$FFAF
         lbeq  L09E5
         cmpx  #$FFF1
         lbeq  L0B26
         cmpx  #$FFEC
         lbeq  L0C3D
         cmpx  #$FFEB
         lbeq  L0D07
         cmpx  #$000C
         lbeq  L0DD1
         cmpx  #$000A
         lbeq  L0DE9
         cmpx  #$0008
         lbeq  L0E01
         cmpx  #$0009
         lbeq  L0E19
         cmpx  #$FFF3
         lbeq  L0E31
         cmpx  #$FFE1
         lbeq  L0ED6
         cmpx  #$FFE3
         lbeq  L0F7A
         cmpx  #$FFEE
         lbeq  L0F91
         cmpx  #$FFE7
         lbeq  L0FAE
         cmpx  #$FFF2
         lbeq  L0FB4
         cmpx  #$FFE5
         lbeq  L110C
         cmpx  #$FFF0
         lbeq  L1116
         cmpx  #$FFF8
         lbeq  L119D
         cmpx  #$FFFA
         lbeq  L11AC
         lbra  L1414
L14E4    lbra  L080D
         leas  <$24,s
         puls  pc,u
L14EC    pshs  u
         ldd   #$FFAA
         lbsr  L010F
         leas  -$02,s
         ldd   >$0007,y
         bne   L1547
         ldd   >$000D,y
         addd  #$0002
         cmpd  #$2000
         bge   L153D
         ldd   >$000D,y
         addd  #$0001
         std   >$000D,y
         subd  #$0001
         leax  >$0225,y
         leax  d,x
         ldd   #$001B
         stb   ,x
         ldd   >$000D,y
         addd  #$0001
         std   >$000D,y
         subd  #$0001
         leax  >$0225,y
         leax  d,x
         ldd   #$005B
         stb   ,x
         bra   L1547
L153D    ldd   #$0001
         pshs  b,a
         lbsr  L3AD8
         leas  $02,s
L1547    clra  
         clrb  
         stb   $01,s
         lbra  L17EA
L154E    ldd   #$0003
         pshs  b,a
         ldd   #$0003
         pshs  b,a
         ldd   #$0011
         pshs  b,a
         ldd   #$0028
         pshs  b,a
         ldd   #$0006
         pshs  b,a
         ldd   #$0014
         pshs  b,a
         ldd   #$0001
         pshs  b,a
         ldd   #$0001
         pshs  b,a
         lbsr  L3A52
         leas  <$10,s
         ldd   #$0002
         pshs  b,a
         clra  
         clrb  
         pshs  b,a
         ldd   #$000F
         pshs  b,a
         ldd   #$0026
         pshs  b,a
         ldd   #$0007
         pshs  b,a
         ldd   #$0015
         pshs  b,a
         clra  
         clrb  
         pshs  b,a
         ldd   #$0001
         pshs  b,a
         lbsr  L3A52
         leas  <$10,s
         ldd   #$0001
         pshs  b,a
         lbsr  L3AEC
         leas  $02,s
         leax  >L2BEA,pcr
         pshs  x
         lbsr  L2D4D
         leas  $02,s
         leax  >L2C06,pcr
         pshs  x
         lbsr  L2D4D
         leas  $02,s
         leax  >L2C25,pcr
         pshs  x
         lbsr  L2D4D
         leas  $02,s
         leax  >L2C4C,pcr
         pshs  x
         lbsr  L2D4D
         leas  $02,s
         leax  >L2C5B,pcr
         pshs  x
         lbsr  L2D4D
         leas  $02,s
         leax  >L2C70,pcr
         pshs  x
         lbsr  L2D4D
         leas  $02,s
         leax  >L2C80,pcr
         pshs  x
         lbsr  L2D4D
         leas  $02,s
         leax  >L2C98,pcr
         pshs  x
         lbsr  L2D4D
         leas  $02,s
         leax  >L2CAC,pcr
         pshs  x
         lbsr  L2D4D
         leas  $02,s
         leax  >L2CC8,pcr
         pshs  x
         lbsr  L2D4D
         leas  $02,s
         leax  >L2CE4,pcr
         pshs  x
         lbsr  L2D4D
         leas  $02,s
         leax  >L2CF0,pcr
         pshs  x
         lbsr  L2D4D
         leas  $02,s
         leax  >$0049,y
         pshs  x
         lbsr  L337C
         leas  $02,s
         ldd   #$0001
         pshs  b,a
         leax  $03,s
         pshs  x
         clra  
         clrb  
         pshs  b,a
         lbsr  L38A4
         leas  $06,s
         ldb   $01,s
         clra  
         andb  #$DF
         stb   $01,s
         ldd   #$0001
         pshs  b,a
         lbsr  L3A82
         leas  $02,s
         ldd   #$0001
         pshs  b,a
         lbsr  L3A82
         leas  $02,s
         ldb   $01,s
         sex   
         tfr   d,x
         lbra  L17B2
L1676    ldd   #$0030
         pshs  b,a
         lbsr  L19C1
         leas  $02,s
         ldd   #$003B
         pshs  b,a
         lbsr  L19C1
         leas  $02,s
         ldd   >$0007,y
         lbne  L17EA
         clra  
         clrb  
         lbra  L17A9
L1697    ldd   #$0031
         pshs  b,a
         lbsr  L19C1
         leas  $02,s
         ldd   #$003B
         pshs  b,a
         lbsr  L19C1
         leas  $02,s
         ldd   >$0007,y
         lbne  L17EA
         ldd   #$0001
         lbra  L17A9
L16B9    ldd   #$0034
         pshs  b,a
         lbsr  L19C1
         leas  $02,s
         ldd   #$003B
         pshs  b,a
         lbsr  L19C1
         leas  $02,s
         ldd   >$0007,y
         lbne  L17EA
         ldd   #$0004
         lbra  L17A9
L16DB    ldd   #$0035
         pshs  b,a
         lbsr  L19C1
         leas  $02,s
         ldd   #$003B
         pshs  b,a
         lbsr  L19C1
         leas  $02,s
         ldd   >$0007,y
         lbne  L17EA
         ldd   #$0005
         lbra  L17A9
L16FD    ldd   #$0037
         pshs  b,a
         lbsr  L19C1
         leas  $02,s
         ldd   #$003B
         pshs  b,a
         lbsr  L19C1
         leas  $02,s
         ldd   >$0007,y
         lbne  L17EA
         ldd   #$0007
         lbra  L17A9
L171F    ldd   #$0038
         pshs  b,a
         lbsr  L19C1
         leas  $02,s
         ldd   #$003B
         pshs  b,a
         lbsr  L19C1
         leas  $02,s
         ldd   >$0007,y
         lbne  L17EA
         ldd   #$0008
         lbra  L17A9
L1741    lbsr  L1819
         stb   ,s
         ldd   #$0033
         pshs  b,a
         lbsr  L19C1
         leas  $02,s
         ldb   ,s
         sex   
         addd  #$0030
         pshs  b,a
         lbsr  L19C1
         leas  $02,s
         ldd   #$003B
         pshs  b,a
         lbsr  L19C1
         leas  $02,s
         ldd   >$0007,y
         lbne  L17EA
         ldb   ,s
         sex   
         addd  #$001E
         bra   L17A9
L1777    lbsr  L1819
         stb   ,s
         ldd   #$0034
         pshs  b,a
         lbsr  L19C1
         leas  $02,s
         ldb   ,s
         sex   
         addd  #$0030
         pshs  b,a
         lbsr  L19C1
         leas  $02,s
         ldd   #$003B
         pshs  b,a
         lbsr  L19C1
         leas  $02,s
         ldd   >$0007,y
         bne   L17EA
         ldb   ,s
         sex   
         addd  #$0028
L17A9    pshs  b,a
         lbsr  L249A
         leas  $02,s
         bra   L17EA
L17B2    cmpx  #$0052
         lbeq  L1676
         cmpx  #$004F
         lbeq  L1697
         cmpx  #$0055
         lbeq  L16B9
         cmpx  #$004C
         lbeq  L16DB
         cmpx  #$0056
         lbeq  L16FD
         cmpx  #$0049
         lbeq  L171F
         cmpx  #$0046
         lbeq  L1741
         cmpx  #$0042
         lbeq  L1777
L17EA    ldb   $01,s
         cmpb  #$44
         lbne  L154E
         ldd   #$006D
         pshs  b,a
         lbsr  L19C1
         leas  $02,s
         ldd   >$0007,y
         lbne  L1C74
         ldd   >$000D,y
         addd  #$FFFF
         leax  >$0225,y
         leax  d,x
         ldd   #$006D
         stb   ,x
         lbra  L1C74
L1819    pshs  u
         ldd   #$FFA9
         lbsr  L010F
         leas  -$03,s
         ldd   #$0004
         pshs  b,a
         ldd   #$0004
         pshs  b,a
         ldd   #$000C
         pshs  b,a
         ldd   #$0014
         pshs  b,a
         ldd   #$0002
         pshs  b,a
         ldd   #$0028
         pshs  b,a
         ldd   #$0001
         pshs  b,a
         ldd   #$0001
         pshs  b,a
         lbsr  L3A52
         leas  <$10,s
         ldd   #$0002
         pshs  b,a
         clra  
         clrb  
         pshs  b,a
         ldd   #$000A
         pshs  b,a
         ldd   #$0012
         pshs  b,a
         ldd   #$0003
         pshs  b,a
         ldd   #$0029
         pshs  b,a
         clra  
         clrb  
         pshs  b,a
         ldd   #$0001
         pshs  b,a
         lbsr  L3A52
         leas  <$10,s
         ldd   #$0001
         pshs  b,a
         lbsr  L3AEC
         leas  $02,s
         clra  
         clrb  
         lbra  L18DC
L188C    ldd   $01,s
         pshs  b,a
         clra  
         clrb  
         pshs  b,a
         ldd   #$0001
         pshs  b,a
         lbsr  L3B2A
         leas  $06,s
         ldd   $01,s
         beq   L18BA
         ldd   $01,s
         lslb  
         rola  
         leax  >$000F,y
         leax  d,x
         ldd   ,x
         pshs  b,a
         ldd   #$0001
         pshs  b,a
         lbsr  L3A9F
         leas  $04,s
L18BA    ldd   $01,s
         lslb  
         rola  
         leax  >$001F,y
         leax  d,x
         ldd   ,x
         pshs  b,a
         ldd   $03,s
         pshs  b,a
         leax  >L2D05,pcr
         pshs  x
         lbsr  L2D4D
         leas  $06,s
         ldd   $01,s
         addd  #$0001
L18DC    std   $01,s
         ldd   $01,s
         cmpd  #$0008
         lblt  L188C
         leax  >L2D0E,pcr
         pshs  x
         lbsr  L2D4D
         leas  $02,s
         leax  >$0049,y
         pshs  x
         lbsr  L337C
         leas  $02,s
         ldd   #$0001
         pshs  b,a
         leax  $02,s
         pshs  x
         clra  
         clrb  
         pshs  b,a
         lbsr  L38A4
         leas  $06,s
         ldb   ,s
         sex   
         subd  #$0030
         stb   ,s
         ldd   #$0001
         pshs  b,a
         lbsr  L3A82
         leas  $02,s
         ldd   #$0001
         pshs  b,a
         lbsr  L3A82
         leas  $02,s
         ldb   ,s
         sex   
         leas  $03,s
         puls  pc,u
L1933    pshs  u
         ldd   #$FFBA
         lbsr  L010F
         ldd   >$000D,y
         addd  #$0003
         cmpd  #$2000
         lbge  L19B6
         ldd   >$000D,y
         addd  #$0001
         std   >$000D,y
         subd  #$0001
         leax  >$0225,y
         leax  d,x
         ldd   #$001B
         stb   ,x
         ldd   >$000D,y
         addd  #$0001
         std   >$000D,y
         subd  #$0001
         leax  >$0225,y
         leax  d,x
         ldd   #$005B
         stb   ,x
         ldb   $05,s
         cmpb  #$4A
         bne   L199B
         ldd   >$000D,y
         addd  #$0001
         std   >$000D,y
         subd  #$0001
         leax  >$0225,y
         leax  d,x
         ldd   #$0032
         stb   ,x
L199B    ldd   >$000D,y
         addd  #$0001
         std   >$000D,y
         subd  #$0001
         leax  >$0225,y
         leax  d,x
         ldb   $05,s
         stb   ,x
         lbra  L1C76
L19B6    ldd   #$0001
         pshs  b,a
         lbsr  L3AD8
         lbra  L1C74
L19C1    pshs  u
         ldd   #$FFB4
         lbsr  L010F
         leas  -$02,s
         ldd   >$0005,y
         lbeq  L1B18
         ldb   $07,s
         sex   
         leax  >$010D,y
         leax  d,x
         ldb   ,x
         clra  
         andb  #$08
         beq   L1A0F
         ldd   >$0001,y
         pshs  b,a
         ldd   #$0005
         lbsr  L365D
         leax  >$01E7,y
         leax  d,x
         tfr   x,d
         pshs  b,a
         ldd   >$0003,y
         addd  #$0001
         std   >$0003,y
         subd  #$0001
         addd  ,s++
         tfr   d,x
         ldb   $07,s
         stb   ,x
L1A0F    ldb   $07,s
         sex   
         leax  >$010D,y
         leax  d,x
         ldb   ,x
         clra  
         andb  #$06
         lbeq  L1AA2
         ldd   >$0003,y
         ble   L1A6C
         ldd   >$0001,y
         pshs  b,a
         ldd   #$0005
         lbsr  L365D
         leax  >$01E7,y
         leax  d,x
         ldd   >$0003,y
         leax  d,x
         clra  
         clrb  
         stb   ,x
         ldd   >$0001,y
         leax  >$01DD,y
         leax  d,x
         pshs  x
         ldd   >$0001,y
         pshs  b,a
         ldd   #$0005
         lbsr  L365D
         leax  >$01E7,y
         leax  d,x
         pshs  x
         lbsr  L35CC
         leas  $02,s
         stb   [,s++]
         bra   L1A7B
L1A6C    ldd   >$0001,y
         leax  >$01DD,y
         leax  d,x
         ldd   #$0001
         stb   ,x
L1A7B    ldd   >$0003,y
         bgt   L1A87
         ldb   $07,s
         cmpb  #$6D
         beq   L1A92
L1A87    ldd   >$0001,y
         addd  #$0001
         std   >$0001,y
L1A92    clra  
         clrb  
         std   >$0003,y
         ldb   $07,s
         sex   
         pshs  b,a
         lbsr  L1C78
         leas  $02,s
L1AA2    ldb   $07,s
         cmpb  #$3B
         lbne  L1C74
         ldd   >$0003,y
         ble   L1AF5
         ldd   >$0001,y
         pshs  b,a
         ldd   #$0005
         lbsr  L365D
         leax  >$01E7,y
         leax  d,x
         ldd   >$0003,y
         leax  d,x
         clra  
         clrb  
         stb   ,x
         ldd   >$0001,y
         leax  >$01DD,y
         leax  d,x
         pshs  x
         ldd   >$0001,y
         pshs  b,a
         ldd   #$0005
         lbsr  L365D
         leax  >$01E7,y
         leax  d,x
         pshs  x
         lbsr  L35CC
         leas  $02,s
         stb   [,s++]
         bra   L1B04
L1AF5    ldd   >$0001,y
         leax  >$01DD,y
         leax  d,x
         ldd   #$0001
         stb   ,x
L1B04    ldd   >$0001,y
         addd  #$0001
         std   >$0001,y
         clra  
         clrb  
         std   >$0003,y
         lbra  L1C74
L1B18    ldd   #$0001
         pshs  b,a
         leax  $09,s
         pshs  x
         ldd   #$0001
         pshs  b,a
         lbsr  L38D5
         leas  $06,s
         ldb   $07,s
         sex   
         tfr   d,x
         lbra  L1C5C
L1B33    ldd   >$021B,y
         addd  #$0001
         std   >$021B,y
         cmpd  #$0017
         lble  L1C74
         ldd   #$0017
         lbra  L1C56
L1B4C    clra  
         clrb  
         lbra  L1BB3
L1B51    clra  
         clrb  
         bra   L1B9E
L1B55    ldd   >$021B,y
         pshs  b,a
         ldd   #$0050
         lbsr  L365D
         leax  >$2225,y
         leax  d,x
         ldd   >$0219,y
         leax  d,x
         clra  
         clrb  
         stb   ,x
         ldd   >$021B,y
         pshs  b,a
         ldd   #$00A0
         lbsr  L365D
         leax  >$2955,y
         leax  d,x
         tfr   x,d
         pshs  b,a
         ldd   >$0219,y
         lslb  
         rola  
         addd  ,s++
         tfr   d,x
         ldd   >$0009,y
         std   ,x
         ldd   >$021B,y
         addd  #$0001
L1B9E    std   >$021B,y
         ldd   >$021B,y
         cmpd  #$0017
         blt   L1B55
         ldd   >$0219,y
         addd  #$0001
L1BB3    std   >$0219,y
         ldd   >$0219,y
         cmpd  #$0050
         lblt  L1B51
         clra  
         clrb  
         std   >$0219,y
         clra  
         clrb  
         lbra  L1C56
L1BCE    clra  
         clrb  
         std   >$0219,y
         lbra  L1C74
L1BD7    ldb   $07,s
         cmpb  #$20
         bge   L1BE3
         ldb   $07,s
         lbge  L1C74
L1BE3    ldd   >$0007,y
         beq   L1C2B
         ldd   >$021B,y
         pshs  b,a
         ldd   #$0050
         lbsr  L365D
         leax  >$2225,y
         leax  d,x
         ldd   >$0219,y
         leax  d,x
         ldb   $07,s
         stb   ,x
         ldd   >$021B,y
         pshs  b,a
         ldd   #$00A0
         lbsr  L365D
         leax  >$2955,y
         leax  d,x
         tfr   x,d
         pshs  b,a
         ldd   >$0219,y
         lslb  
         rola  
         addd  ,s++
         tfr   d,x
         ldd   >$0009,y
         std   ,x
L1C2B    ldd   >$0219,y
         addd  #$0001
         std   >$0219,y
         cmpd  #$0050
         blt   L1C74
         clra  
         clrb  
         std   >$0219,y
         ldd   >$021B,y
         addd  #$0001
         std   >$021B,y
         cmpd  #$0017
         blt   L1C74
         ldd   #$0016
L1C56    std   >$021B,y
         bra   L1C74
L1C5C    cmpx  #$000A
         lbeq  L1B33
         cmpx  #$000C
         lbeq  L1B4C
         cmpx  #$000D
         lbeq  L1BCE
         lbra  L1BD7
L1C74    leas  $02,s
L1C76    puls  pc,u
L1C78    pshs  u
         ldd   #$FFB1
         lbsr  L010F
         leas  -$05,s
         clra  
         clrb  
         std   >$0005,y
         ldb   $0A,s
         sex   
         tfr   d,x
         lbra  L209D
L1C90    ldb   >$01DD,y
         sex   
         addd  #$FFFF
         pshs  b,a
         ldb   >$01DE,y
         sex   
         addd  #$FFFF
         pshs  b,a
         ldd   #$0001
         pshs  b,a
         lbsr  L3B2A
         leas  $06,s
         ldb   >$01DE,y
         sex   
         addd  #$FFFF
         std   >$0219,y
         ldb   >$01DD,y
         sex   
         addd  #$FFFF
         std   >$021B,y
         lbra  L20EA
L1CC9    clra  
         clrb  
         bra   L1CEF
L1CCD    ldd   #$0001
         pshs  b,a
         lbsr  L3AE0
         leas  $02,s
         ldd   >$021B,y
         addd  #$FFFF
         std   >$021B,y
         bge   L1CEA
         clra  
         clrb  
         std   >$021B,y
L1CEA    ldd   $03,s
         addd  #$0001
L1CEF    std   $03,s
         ldb   >$01DD,y
         sex   
         cmpd  $03,s
         bgt   L1CCD
         lbra  L20EA
L1CFE    clra  
         clrb  
         bra   L1D2B
L1D02    ldd   >$021B,y
         addd  #$0001
         std   >$021B,y
         cmpd  #$0017
         blt   L1D1C
         ldd   #$0016
         std   >$021B,y
         bra   L1D26
L1D1C    ldd   #$0001
         pshs  b,a
         lbsr  L3AE4
         leas  $02,s
L1D26    ldd   $03,s
         addd  #$0001
L1D2B    std   $03,s
         ldb   >$01DD,y
         sex   
         cmpd  $03,s
         bgt   L1D02
         lbra  L20EA
L1D3A    clra  
         clrb  
         bra   L1D67
L1D3E    ldd   >$0219,y
         addd  #$0001
         std   >$0219,y
         cmpd  #$004F
         ble   L1D58
         ldd   #$004F
         std   >$0219,y
         bra   L1D62
L1D58    ldd   #$0001
         pshs  b,a
         lbsr  L3AD4
         leas  $02,s
L1D62    ldd   $03,s
         addd  #$0001
L1D67    std   $03,s
         ldb   >$01DD,y
         sex   
         cmpd  $03,s
         bgt   L1D3E
         lbra  L20EA
L1D76    clra  
         clrb  
         bra   L1D9E
L1D7A    ldd   >$0219,y
         addd  #$FFFF
         std   >$0219,y
         bge   L1D8F
         clra  
         clrb  
         std   >$0219,y
         bra   L1D99
L1D8F    ldd   #$0001
         pshs  b,a
         lbsr  L3ADC
         leas  $02,s
L1D99    ldd   $03,s
         addd  #$0001
L1D9E    std   $03,s
         ldb   >$01DD,y
         sex   
         cmpd  $03,s
         bgt   L1D7A
         lbra  L20EA
L1DAD    ldd   >$0219,y
         std   >$0221,y
         ldd   >$021B,y
         std   >$0223,y
         lbra  L20EA
L1DC0    ldd   >$0221,y
         std   >$0219,y
         ldd   >$0223,y
         std   >$021B,y
         pshs  b,a
         ldd   >$0219,y
         pshs  b,a
         ldd   #$0001
         pshs  b,a
         lbsr  L3B2A
         leas  $06,s
         lbra  L20EA
L1DE5    ldd   #$0001
         pshs  b,a
         lbsr  L3AEC
         leas  $02,s
         clra  
         clrb  
         lbra  L1E56
L1DF4    clra  
         clrb  
         bra   L1E41
L1DF8    ldd   >$021B,y
         pshs  b,a
         ldd   #$0050
         lbsr  L365D
         leax  >$2225,y
         leax  d,x
         ldd   >$0219,y
         leax  d,x
         clra  
         clrb  
         stb   ,x
         ldd   >$021B,y
         pshs  b,a
         ldd   #$00A0
         lbsr  L365D
         leax  >$2955,y
         leax  d,x
         tfr   x,d
         pshs  b,a
         ldd   >$0219,y
         lslb  
         rola  
         addd  ,s++
         tfr   d,x
         ldd   >$0009,y
         std   ,x
         ldd   >$021B,y
         addd  #$0001
L1E41    std   >$021B,y
         ldd   >$021B,y
         cmpd  #$0017
         blt   L1DF8
         ldd   >$0219,y
         addd  #$0001
L1E56    std   >$0219,y
         ldd   >$0219,y
         cmpd  #$0050
         lblt  L1DF4
         clra  
         clrb  
         std   >$021B,y
         std   >$0219,y
         lbra  L20EA
L1E73    ldd   #$0001
         pshs  b,a
         lbsr  L3AC6
         leas  $02,s
         ldd   >$0219,y
         bra   L1EC4
L1E83    ldd   >$021B,y
         pshs  b,a
         ldd   #$0050
         lbsr  L365D
         leax  >$2225,y
         leax  d,x
         ldd   $03,s
         leax  d,x
         clra  
         clrb  
         stb   ,x
         ldd   >$021B,y
         pshs  b,a
         ldd   #$00A0
         lbsr  L365D
         leax  >$2955,y
         leax  d,x
         tfr   x,d
         pshs  b,a
         ldd   $05,s
         lslb  
         rola  
         addd  ,s++
         tfr   d,x
         clra  
         clrb  
         std   ,x
         ldd   $03,s
         addd  #$0001
L1EC4    std   $03,s
         ldd   $03,s
         cmpd  #$0050
         blt   L1E83
         lbra  L20EA
L1ED1    clra  
         clrb  
         lbra  L208E
L1ED6    ldd   $03,s
         leax  >$01DD,y
         leax  d,x
         ldb   ,x
         sex   
         tfr   d,x
         lbra  L205D
L1EE6    ldd   #$0002
         pshs  b,a
         ldd   #$0001
         pshs  b,a
         lbsr  L3AA3
         leas  $04,s
         clra  
         clrb  
         pshs  b,a
         ldd   #$0001
         pshs  b,a
         lbsr  L3A9F
         leas  $04,s
         ldd   #$0001
         pshs  b,a
         lbsr  L3B0A
         leas  $02,s
         ldd   #$0001
         pshs  b,a
         lbsr  L3B14
         leas  $02,s
         ldd   #$0001
         pshs  b,a
         lbsr  L3B00
         leas  $02,s
         clra  
         clrb  
         lbra  L2057
L1F26    ldd   >$0009,y
         ora   #$10
         lbra  L2057
L1F2F    ldd   #$0001
         pshs  b,a
         lbsr  L3B05
         leas  $02,s
         ldd   >$0009,y
         ora   #$01
         lbra  L2057
L1F42    ldd   #$0001
         pshs  b,a
         lbsr  L3B0F
         leas  $02,s
         ldd   >$0009,y
         ora   #$02
         lbra  L2057
L1F55    ldd   #$0001
         pshs  b,a
         lbsr  L3AFB
         leas  $02,s
         ldd   >$0009,y
         ora   #$04
         lbra  L2057
L1F68    ldd   >$0009,y
         clra  
         andb  #$0F
         lslb  
         rola  
         leax  >$000F,y
         leax  d,x
         ldd   ,x
         pshs  b,a
         ldd   #$0001
         pshs  b,a
         lbsr  L3A9F
         leas  $04,s
         ldd   >$0009,y
         ora   #$08
         lbra  L2057
L1F8E    ldd   $03,s
         leax  >$01DD,y
         leax  d,x
         ldb   ,x
         cmpb  #$1E
         lblt  L1FF5
         ldd   $03,s
         leax  >$01DD,y
         leax  d,x
         ldb   ,x
         cmpb  #$26
         bge   L1FF5
         ldd   $03,s
         leax  >$01DD,y
         leax  d,x
         ldb   ,x
         sex   
         addd  #$FFE2
         lslb  
         rola  
         leax  >$000F,y
         leax  d,x
         ldd   ,x
         pshs  b,a
         ldd   #$0001
         pshs  b,a
         lbsr  L3A9F
         leas  $04,s
         ldd   >$0009,y
         andb  #$0F
         std   >$0009,y
         pshs  b,a
         ldd   $05,s
         leax  >$01DD,y
         leax  d,x
         ldb   ,x
         sex   
         addd  #$FFE2
         lslb  
         rola  
         lslb  
         rola  
         lslb  
         rola  
         lslb  
         rola  
         lbra  L2053
L1FF5    ldd   $03,s
         leax  >$01DD,y
         leax  d,x
         ldb   ,x
         cmpb  #$28
         lblt  L2089
         ldd   $03,s
         leax  >$01DD,y
         leax  d,x
         ldb   ,x
         cmpb  #$30
         lbge  L2089
         ldd   $03,s
         leax  >$01DD,y
         leax  d,x
         ldb   ,x
         sex   
         addd  #$FFD8
         lslb  
         rola  
         leax  >$000F,y
         leax  d,x
         ldd   ,x
         pshs  b,a
         ldd   #$0001
         pshs  b,a
         lbsr  L3AA3
         leas  $04,s
         ldd   >$0009,y
         andb  #$F0
         std   >$0009,y
         pshs  b,a
         ldd   $05,s
         leax  >$01DD,y
         leax  d,x
         ldb   ,x
         sex   
         addd  #$FFD8
L2053    ora   ,s+
         orb   ,s+
L2057    std   >$0009,y
         bra   L2089
L205D    stx   -$02,s
         lbeq  L1EE6
         cmpx  #$0001
         lbeq  L1F26
         cmpx  #$0004
         lbeq  L1F2F
         cmpx  #$0005
         lbeq  L1F42
         cmpx  #$0007
         lbeq  L1F55
         cmpx  #$0008
         lbeq  L1F68
         lbra  L1F8E
L2089    ldd   $03,s
         addd  #$0001
L208E    std   $03,s
         ldd   $03,s
         cmpd  >$0001,y
         lblt  L1ED6
         bra   L20EA
L209D    cmpx  #$0048
         lbeq  L1C90
         cmpx  #$0066
         lbeq  L1C90
         cmpx  #$0041
         lbeq  L1CC9
         cmpx  #$0042
         lbeq  L1CFE
         cmpx  #$0043
         lbeq  L1D3A
         cmpx  #$0044
         lbeq  L1D76
         cmpx  #$0073
         lbeq  L1DAD
         cmpx  #$0075
         lbeq  L1DC0
         cmpx  #$004A
         lbeq  L1DE5
         cmpx  #$006B
         lbeq  L1E73
         cmpx  #$006D
         lbeq  L1ED1
L20EA    bsr   L20F0
         leas  $05,s
         puls  pc,u
L20F0    pshs  u
         ldd   #$FFBE
         lbsr  L010F
         leas  -$02,s
         clra  
         clrb  
         bra   L2110
L20FE    ldd   ,s
         leax  >$01DD,y
         leax  d,x
         ldd   #$0001
         stb   ,x
         ldd   ,s
         addd  #$0001
L2110    std   ,s
         ldd   ,s
         cmpd  #$000A
         blt   L20FE
         clra  
         clrb  
         std   >$0001,y
         clra  
         clrb  
         std   >$0003,y
         leas  $02,s
         puls  pc,u
L212A    pshs  u
         ldd   #$FFB0
         lbsr  L010F
         leas  -$08,s
         clra  
         clrb  
         std   $02,s
         clra  
         clrb  
         std   ,s
         clra  
         clrb  
         lbra  L2396
L2141    clra  
         clrb  
         lbra  L2385
L2146    ldd   $04,s
         pshs  b,a
         ldd   #$0050
         lbsr  L365D
         leax  >$2225,y
         leax  d,x
         ldd   $06,s
         leax  d,x
         ldb   ,x
         lbeq  L2348
         ldd   $02,s
         cmpd  $06,s
         bne   L2170
         ldd   ,s
         cmpd  $04,s
         lbeq  L22AD
L2170    ldd   >$000D,y
         addd  #$0008
         cmpd  #$2000
         lbge  L22A3
         ldd   >$000D,y
         addd  #$0001
         std   >$000D,y
         subd  #$0001
         leax  >$0225,y
         leax  d,x
         ldd   #$001B
         stb   ,x
         ldd   >$000D,y
         addd  #$0001
         std   >$000D,y
         subd  #$0001
         leax  >$0225,y
         leax  d,x
         ldd   #$005B
         stb   ,x
         ldd   $04,s
         addd  #$0001
         cmpd  #$000A
         blt   L21E4
         ldd   >$000D,y
         addd  #$0001
         std   >$000D,y
         subd  #$0001
         leax  >$0225,y
         leax  d,x
         pshs  x
         ldd   $06,s
         addd  #$0001
         pshs  b,a
         ldd   #$000A
         lbsr  L3711
         addd  #$0030
         stb   [,s++]
L21E4    ldd   >$000D,y
         addd  #$0001
         std   >$000D,y
         subd  #$0001
         leax  >$0225,y
         leax  d,x
         pshs  x
         ldd   $06,s
         addd  #$0001
         pshs  b,a
         ldd   #$000A
         lbsr  L36BE
         addd  #$0030
         stb   [,s++]
         ldd   >$000D,y
         addd  #$0001
         std   >$000D,y
         subd  #$0001
         leax  >$0225,y
         leax  d,x
         ldd   #$003B
         stb   ,x
         ldd   $06,s
         addd  #$0001
         cmpd  #$000A
         blt   L2258
         ldd   >$000D,y
         addd  #$0001
         std   >$000D,y
         subd  #$0001
         leax  >$0225,y
         leax  d,x
         pshs  x
         ldd   $08,s
         addd  #$0001
         pshs  b,a
         ldd   #$000A
         lbsr  L3711
         addd  #$0030
         stb   [,s++]
L2258    ldd   >$000D,y
         addd  #$0001
         std   >$000D,y
         subd  #$0001
         leax  >$0225,y
         leax  d,x
         pshs  x
         ldd   $08,s
         addd  #$0001
         pshs  b,a
         ldd   #$000A
         lbsr  L36BE
         addd  #$0030
         stb   [,s++]
         ldd   >$000D,y
         addd  #$0001
         std   >$000D,y
         subd  #$0001
         leax  >$0225,y
         leax  d,x
         ldd   #$0048
         stb   ,x
         ldd   $06,s
         std   $02,s
         ldd   $04,s
         std   ,s
         bra   L22AD
L22A3    ldd   #$0001
         pshs  b,a
         lbsr  L3AD8
         leas  $02,s
L22AD    ldd   $04,s
         pshs  b,a
         ldd   #$00A0
         lbsr  L365D
         leax  >$2955,y
         leax  d,x
         tfr   x,d
         pshs  b,a
         ldd   $08,s
         lslb  
         rola  
         addd  ,s++
         tfr   d,x
         ldd   ,x
         cmpd  >$0009,y
         beq   L22F7
         ldd   $04,s
         pshs  b,a
         ldd   #$00A0
         lbsr  L365D
         leax  >$2955,y
         leax  d,x
         tfr   x,d
         pshs  b,a
         ldd   $08,s
         lslb  
         rola  
         addd  ,s++
         tfr   d,x
         ldd   ,x
         pshs  b,a
         lbsr  L23A6
         leas  $02,s
L22F7    ldd   >$000D,y
         addd  #$0001
         std   >$000D,y
         subd  #$0001
         leax  >$0225,y
         leax  d,x
         pshs  x
         ldd   $06,s
         pshs  b,a
         ldd   #$0050
         lbsr  L365D
         leax  >$2225,y
         leax  d,x
         ldd   $08,s
         leax  d,x
         ldb   ,x
         stb   [,s++]
         ldd   $02,s
         addd  #$0001
         std   $02,s
         cmpd  #$004F
         ble   L2348
         ldd   ,s
         addd  #$0001
         std   ,s
         cmpd  #$0016
         ble   L2344
         ldd   #$0016
         std   ,s
L2344    clra  
         clrb  
         std   $02,s
L2348    ldd   $04,s
         pshs  b,a
         ldd   #$0050
         lbsr  L365D
         leax  >$2225,y
         leax  d,x
         ldd   $06,s
         leax  d,x
         clra  
         clrb  
         stb   ,x
         ldd   $04,s
         pshs  b,a
         ldd   #$00A0
         lbsr  L365D
         leax  >$2955,y
         leax  d,x
         tfr   x,d
         pshs  b,a
         ldd   $08,s
         lslb  
         rola  
         addd  ,s++
         tfr   d,x
         clra  
         clrb  
         std   ,x
         ldd   $06,s
         addd  #$0001
L2385    std   $06,s
         ldd   $06,s
         cmpd  #$0050
         lblt  L2146
         ldd   $04,s
         addd  #$0001
L2396    std   $04,s
         ldd   $04,s
         cmpd  #$0017
         lblt  L2141
         leas  $08,s
         puls  pc,u
L23A6    pshs  u
         ldd   #$FFBA
         lbsr  L010F
         ldd   >$000D,y
         addd  #$0002
         cmpd  #$2000
         bge   L23EF
         ldd   >$000D,y
         addd  #$0001
         std   >$000D,y
         subd  #$0001
         leax  >$0225,y
         leax  d,x
         ldd   #$001B
         stb   ,x
         ldd   >$000D,y
         addd  #$0001
         std   >$000D,y
         subd  #$0001
         leax  >$0225,y
         leax  d,x
         ldd   #$005B
         stb   ,x
         bra   L23F9
L23EF    ldd   #$0001
         pshs  b,a
         lbsr  L3AD8
         leas  $02,s
L23F9    clra  
         clrb  
         pshs  b,a
         lbsr  L249A
         leas  $02,s
         ldd   $04,s
         anda  #$10
         clrb  
         std   -$02,s
         beq   L2415
         ldd   #$0001
         pshs  b,a
         lbsr  L249A
         leas  $02,s
L2415    ldd   $04,s
         anda  #$01
         clrb  
         std   -$02,s
         beq   L2428
         ldd   #$0004
         pshs  b,a
         lbsr  L249A
         leas  $02,s
L2428    ldd   $04,s
         anda  #$02
         clrb  
         std   -$02,s
         beq   L243B
         ldd   #$0005
         pshs  b,a
         lbsr  L249A
         leas  $02,s
L243B    ldd   $04,s
         anda  #$04
         clrb  
         std   -$02,s
         beq   L244E
         ldd   #$0007
         pshs  b,a
         lbsr  L249A
         leas  $02,s
L244E    ldd   $04,s
         clra  
         andb  #$F0
         beq   L246B
         ldd   $04,s
         clra  
         andb  #$F0
         lsra  
         rorb  
         lsra  
         rorb  
         lsra  
         rorb  
         lsra  
         rorb  
         addd  #$001E
         pshs  b,a
         bsr   L249A
         leas  $02,s
L246B    ldd   $04,s
         clra  
         andb  #$0F
         beq   L2480
         ldd   $04,s
         clra  
         andb  #$0F
         addd  #$0028
         pshs  b,a
         bsr   L249A
         leas  $02,s
L2480    ldd   $04,s
         std   >$0009,y
         ldd   >$000D,y
         addd  #$FFFF
         leax  >$0225,y
         leax  d,x
         ldd   #$006D
         stb   ,x
         puls  pc,u
L249A    pshs  u
         ldd   #$FFB8
         lbsr  L010F
         ldd   >$000D,y
         addd  #$0003
         cmpd  #$2000
         lbge  L251E
         ldd   $04,s
         cmpd  #$000A
         blt   L24DE
         ldd   >$000D,y
         addd  #$0001
         std   >$000D,y
         subd  #$0001
         leax  >$0225,y
         leax  d,x
         pshs  x
         ldd   $06,s
         pshs  b,a
         ldd   #$000A
         lbsr  L3711
         addd  #$0030
         stb   [,s++]
L24DE    ldd   >$000D,y
         addd  #$0001
         std   >$000D,y
         subd  #$0001
         leax  >$0225,y
         leax  d,x
         pshs  x
         ldd   $06,s
         pshs  b,a
         ldd   #$000A
         lbsr  L36BE
         addd  #$0030
         stb   [,s++]
         ldd   >$000D,y
         addd  #$0001
         std   >$000D,y
         subd  #$0001
         leax  >$0225,y
         leax  d,x
         ldd   #$003B
         stb   ,x
         bra   L2528
L251E    ldd   #$0001
         pshs  b,a
         lbsr  L3AD8
         leas  $02,s
L2528    puls  pc,u
L252A    pshs  u
         ldd   #$FF96
         lbsr  L010F
         leas  <-$20,s
         leax  ,s
         pshs  x
         clra  
         clrb  
         pshs  b,a
         clra  
         clrb  
         pshs  b,a
         lbsr  L37B9
         leas  $06,s
         ldb   <$25,s
         stb   $04,s
         leax  ,s
         pshs  x
         clra  
         clrb  
         pshs  b,a
         clra  
         clrb  
         pshs  b,a
         lbsr  L37F4
         leas  $06,s
         leas  <$20,s
         puls  pc,u
L2561    pshs  u
         ldd   #$FFAB
         lbsr  L010F
         leas  -$01,s
         ldd   #$0004
         pshs  b,a
         ldd   #$0004
         pshs  b,a
         ldd   #$0006
         pshs  b,a
         ldd   #$0028
         pshs  b,a
         ldd   #$0003
         pshs  b,a
         ldd   #$000A
         pshs  b,a
         ldd   #$0001
         pshs  b,a
         ldd   #$0001
         pshs  b,a
         lbsr  L3A52
         leas  <$10,s
         ldd   #$0002
         pshs  b,a
         clra  
         clrb  
         pshs  b,a
         ldd   #$0004
         pshs  b,a
         ldd   #$0026
         pshs  b,a
         ldd   #$0004
         pshs  b,a
         ldd   #$000B
         pshs  b,a
         clra  
         clrb  
         pshs  b,a
         ldd   #$0001
         pshs  b,a
         lbsr  L3A52
         leas  <$10,s
         ldd   #$0001
         pshs  b,a
         lbsr  L3AEC
         leas  $02,s
         ldd   $05,s
         pshs  b,a
         lbsr  L3545
         std   ,s
         ldd   #$0002
         lbsr  L3711
         pshs  b,a
         ldd   #$0013
         subd  ,s++
         pshs  b,a
         leax  >L2D18,pcr
         pshs  x
         ldd   #$0001
         pshs  b,a
         lbsr  L38D5
         leas  $06,s
         ldd   $05,s
         pshs  b,a
         leax  >L2D2D,pcr
         pshs  x
         lbsr  L2D4D
         leas  $04,s
         ldd   $07,s
         pshs  b,a
         leax  >L2D31,pcr
         pshs  x
         lbsr  L2D4D
         leas  $04,s
         ldd   #$0001
         pshs  b,a
         leax  $02,s
         pshs  x
         clra  
         clrb  
         pshs  b,a
         lbsr  L38A4
         leas  $06,s
         ldd   #$0001
         pshs  b,a
         lbsr  L3A82
         leas  $02,s
         ldd   #$0001
         pshs  b,a
         lbsr  L3A82
         leas  $02,s
         leas  $01,s
         puls  pc,u
         fcb   $42 B
         inc   $01,s
         com   $0B,s
         neg   <u0052
         eim   #$64,$00,x
         asra  
         aim   #$65,>$656E
         neg   <u0059
         eim   #$6C,$0C,s
         clr   -$09,s
         neg   <u0042
         inc   -$0B,s
         eim   #u0000,$0D,u
         oim   #$67,$05,s
         jmp   -$0C,s
         oim   #u0000,$03,u
         rol   >$616E
         neg   <u0057
         lsl   $09,s
         lsr   >$6500
L266E    tst   <u0020
         rora  
         rol   $0C,s
         eim   #$6E,$01,s
         tst   $05,s
         bra   L26EE
         clr   $00,y
         com   >$6176
         eim   #$3A,$00,x
L2682    fcb   $41 A
         jmp   -$0D,s
         rol   $00,y
         asra  
         aim   #$61,>$7068
         rol   $03,s
         clr   >$2045
         lsr   $09,s
         lsr   >$6F72
         bge   L26B8
         rorb  
         eim   #$72,-$0D,s
         rol   $0F,s
         jmp   $00,y
         leay  $0E,y
         leax  $00,y
         bra   L26C6
         bra   L26C8
         bra   L26B7
         neg   <u0043
         clr   -$10,s
         rol   >$7269
         asr   $08,s
         lsr   >$2028
         com   $09,y
L26B8    bra   L26EB
         rts   
         fcb   $38 8
         rts   
         bge   L26DF
         fcb   $42 B
         rol   >$204B
         eim   #$69,-$0C,s
L26C6    lsl   $00,y
L26C8    fcb   $41 A
         inc   -$10,s
         lsl   $0F,s
         jmp   -$0D,s
         clr   $00,y
         bra   L26E0
         neg   <u004C
         rol   $03,s
         eim   #$6E,-$0D,s
         eim   #$64,$00,y
         lsr   >$6F20
L26E0    fcb   $41 A
         inc   -$10,s
         lsl   $01,s
         bra   L273A
         clr   $06,s
         lsr   >$7761
         aim   #$65,>$2054
         eim   #$63,$08,s
         jmp   $0F,s
         inc   $0F,s
         asr   $09,s
         eim   #$73,$0D,x
         neg   <u0041
         inc   $0C,s
         bra   L2774
         rol   $07,s
         lsl   -$0C,s
         com   >$2072
         eim   #$73,$05,s
         aim   #$76,>$6564
         bra   L2732
         bra   L2734
         bra   L2736
         bra   L2738
         bra   L273A
         bra   L273C
         bra   L273E
         bra   L2740
         bra   L2742
         bra   L2744
         tst   <u0000
L2726    coma  
         oim   #$6E,$0E,s
         clr   -$0C,s
         bra   L279D
         neg   >$656E
         bra   L27A2
         eim   #$74,>$7075
         lsr   >$2066
L273A    rol   $0C,s
L273C    eim   #$00,$0D,x
         negb  
L2740    eim   #$74,>$2053
L2744    com   -$0E,s
         eim   #$65,$0E,s
         bra   L27B4
         jmp   -$0C,s
         clr   $00,y
         fcb   $42 B
         eim   #$66,>$6665
         aim   #$3F,>$000D
         comb  
         lsr   >$6172
         lsr   >$2077
         rol   -$0C,s
         lsl   $00,y
         com   $0C,s
         eim   #$61,-$0E,s
         bra   L27DD
         com   -$0E,s
         eim   #$65,$0E,s
         swi   
         fcb   $00 
L2771    coma  
         oim   #$6E,$0E,s
         clr   -$0C,s
         bra   L27E8
         neg   >$656E
         bra   L27E4
         rol   $0C,s
         eim   #$00,$0D,x
         fcb   $52 R
         eim   #$61,$04,s
         bra   L27EF
         rol   $0C,s
         eim   #$20,-$0C,s
         clr   $00,y
         fcb   $5B [
         clra  
         tstb  
         eim   #$74,>$7075
         lsr   >$2062
         eim   #$66,>$6665
         aim   #$20,>$6F72
L27A2    bra   L27FF
         comb  
         tstb  
         com   -$0E,s
         eim   #$65,$0E,s
         bra   L280F
         eim   #$66,>$6665
         aim   #$00,>$0D41
         lsr   $04,s
         bra   L2825
         rol   $0E,s
         eim   #$20,$06,s
         eim   #$65,$04,s
         com   >$2074
         clr   $00,y
         com   $01,s
         aim   #$72,>$6961
         asr   $05,s
         bra   L2842
         eim   #$74,-$0B,s
         aim   #$6E,>$733F
         neg   <u0058
         mul   
         bcs   L280E
         lsr   $00,y
         rolb  
         mul   
         bcs   L2814
         lsr   $00,y
L27E4    bra   L2806
         comb  
         lsr   >$6174
         eim   #$73,>$3A00
L27EE    fcb   $45 E
L27EF    lsra  
         rola  
         lsrb  
         rola  
         fcb   $4E N
         asra  
         bra   L2817
         neg   <u0052
         fcb   $45 E
         coma  
         clra  
         fcb   $52 R
         lsra  
         rola  
L27FF    fcb   $4E N
         asra  
         neg   <u0020
         bra   L2848
         lsl   $01,s
         aim   #$3A,>$2531
         com   $00,x
L280D    bra   L282F
L280F    coma  
         lsl   $01,s
         aim   #$3A,>$2000
L2816    bra   L2838
         fcb   $41 A
         lsr   >$7472
         com   >$3A00
L281F    fcb   $55 U
         neg   <u0020
         neg   <u004C
         neg   <u0020
         neg   <u0056
         neg   <u0020
         neg   <u0049
         neg   <u0020
         neg   <u004F
         neg   <u0020
         neg   <u0020
         coma  
         clr   $0C,s
         clr   -$0E,s
         com   >$3A25
         pulu  u,y,x,a,cc
         bra   L28AF
         jmp   $00,y
L2842    bcs   L287B
         com   >$0020
         coma  
L2848    clr   $0C,s
         clr   -$0E,s
         com   >$3A57
         lsl   $09,s
         lsr   >$6520
         bra   L2876
         clr   $0E,s
         bra   L289C
         inc   $01,s
         com   $0B,s
         bra   L2880
         neg   <u0020
         bra   L2884
         bra   L2886
         bra   L2888
         bra   L288A
         bra   L288C
         fcb   $41 A
         jmp   -$0D,s
         rol   $0D,y
         fcb   $45 E
         lsr   $09,s
         lsr   >$6F72
         bra   L2899
         lsla  
         eim   #$6C,-$10,s
         tst   <u0000
L287F    blt   L28AE
         blt   L28B0
         blt   L28B2
         blt   L28B4
         blt   L28B6
         blt   L28B8
         blt   L28BA
         blt   L28BC
         blt   L28BE
         blt   L28C0
         blt   L28C2
         blt   L28C4
         blt   L28C6
L2899    blt   L28C8
         blt   L28CA
         blt   L28CC
         blt   L28CE
         blt   L28D0
         blt   L28D2
         tst   <u0000
L28A7    bra   L2904
         fcb   $41 A
         inca  
         lsrb  
         tstb  
         fcb   $5B [
L28AE    asra  
L28AF    tstb  
L28B0    bra   L28DF
L28B2    bra   L2907
L28B4    eim   #$74,$00,y
         asr   -$0E,s
         oim   #$70,$08,s
L28BC    rol   $03,s
L28BE    com   >$0D00
L28C1    bra   L291E
         fcb   $41 A
L28C4    inca  
         lsrb  
L28C6    tstb  
         fcb   $5B [
L28C8    fcb   $52 R
         tstb  
L28CA    bra   L28F9
L28CC    bra   L2920
L28CE    eim   #$63,$0F,s
         aim   #$64,>$206D
         clr   $04,s
         eim   #$0D,$00,x
L28DA    bra   L2937
         fcb   $41 A
         inca  
         lsrb  
L28DF    tstb  
         fcb   $5B [
         fcb   $45 E
         tstb  
         bra   L2912
         bra   L292C
         lsr   $09,s
         lsr   >$206D
         clr   $04,s
         eim   #$0D,$00,x
L28F1    bra   L294E
         fcb   $41 A
         inca  
         lsrb  
         tstb  
         fcb   $5B [
         coma  
L28F9    tstb  
         bra   L2929
         bra   L2941
         inc   $05,s
         oim   #$72,$00,y
         com   >$6372
         eim   #$65,$0E,s
         tst   <u0000
L290B    bra   L2968
         fcb   $41 A
         inca  
         lsrb  
         tstb  
         fcb   $5B [
L2912    fcb   $4E N
         tstb  
         bra   L2943
         bra   L295B
         inc   $05,s
         oim   #$72,$00,y
         lsr   >$6F20
L2920    eim   #$6E,$04,s
         bra   L2994
         ror   $00,y
         inc   $09,s
L2929    jmp   $05,s
         tst   <u0000
L292D    bra   L298A
         fcb   $41 A
         inca  
         lsrb  
         tstb  
         fcb   $5B [
         comb  
         tstb  
         bra   L2965
         bra   L298D
         oim   #$76,$05,s
         bra   L29A2
         eim   #$72,>$736F
L2943    aim   #$20,>$706F
         com   >$6974
         rol   $0F,s
         jmp   $0D,x
L294E    neg   <u0020
         fcb   $5B [
         fcb   $41 A
         inca  
         lsrb  
         tstb  
         fcb   $5B [
         fcb   $41 A
         tstb  
         bra   L2987
         bra   L29AE
         eim   #$73,-$0C,s
         clr   -$0E,s
         eim   #$20,$03,s
         eim   #$72,>$736F
L2968    aim   #$20,>$706F
         com   >$6974
         rol   $0F,s
         jmp   $0D,x
         neg   <u0020
         fcb   $5B [
         fcb   $41 A
         inca  
         lsrb  
         tstb  
         fcb   $5B [
         negb  
         tstb  
         bra   L29AC
         bra   L29D1
         eim   #$74,>$2073
         com   -$0E,s
L2987    eim   #$65,$0E,s
L298A    bra   L29F5
         jmp   -$0C,s
         clr   $00,y
         aim   #$75,$06,s
         ror   $05,s
         aim   #$0D,>$0020
         fcb   $5B [
         fcb   $41 A
         inca  
         lsrb  
         tstb  
         fcb   $5B [
         inca  
         tstb  
         bra   L29D0
         bra   L29F1
         clr   $01,s
         lsr   $00,y
         ror   -$0E,s
         clr   $0D,s
         bra   L2A15
         rol   $0C,s
         eim   #$0D,$00,x
L29B4    bra   L2A11
         fcb   $41 A
         inca  
         lsrb  
         tstb  
         fcb   $5B [
         fcb   $4B K
         tstb  
         bra   L29EC
         bra   L2A14
         oim   #$76,$05,s
         bra   L2A3A
         clr   $00,y
         ror   $09,s
         inc   $05,s
         tst   <u0000
L29CE    bra   L2A2B
L29D0    fcb   $41 A
L29D1    inca  
         lsrb  
         tstb  
         fcb   $5B [
         decb  
         tstb  
         bra   L2A06
         bra   L2A35
         oim   #$70,$00,y
         aim   #$75,$06,s
         ror   $05,s
         aim   #$73,>$0D00
L29E7    bra   L2A44
         fcb   $41 A
         inca  
         lsrb  
L29EC    tstb  
         fcb   $5B [
         lslb  
         tstb  
         bra   L2A1F
         bra   L2A47
         oim   #$76,$05,s
         bra   L2A1F
         bra   L2A40
         lsl   >$6974
         tst   <u0000
L2A00    bra   L2A5D
         fcb   $41 A
         inca  
         lsrb  
         tstb  
L2A06    fcb   $5B [
         fcb   $51 Q
         tstb  
         bra   L2A38
         bra   L2A5E
         eim   #$69,>$7420
L2A11    asr   >$6974
L2A14    lsl   $0F,s
         eim   #$74,>$2073
         oim   #$76,$05,s
         tst   <u0000
L2A1F    tst   <u0020
         bra   L2A64
         aim   #$65,>$2079
         clr   -$0B,s
         bra   L2A9E
L2A2B    eim   #$72,>$653F
         neg   <u0041
         fcb   $4E N
         comb  
         rola  
         bra   L2A7D
         aim   #$61,>$7068
L2A3A    rol   $03,s
         com   >$2045
         lsr   $09,s
         lsr   >$6F72
L2A44    bge   L2A66
         rorb  
L2A47    eim   #$72,-$0D,s
         rol   $0F,s
         jmp   $00,y
         leay  $0E,y
         leax  $00,y
         bra   L2A74
         bra   L2A76
         bra   L2A65
         neg   <u0043
         clr   -$10,s
         rol   >$7269
         asr   $08,s
         lsr   >$2028
L2A64    com   $09,y
L2A66    bra   L2A99
         rts   
         fcb   $38 8
         rts   
         bge   L2A8D
         fcb   $42 B
         rol   >$204B
         eim   #$69,-$0C,s
L2A74    lsl   $00,y
L2A76    fcb   $41 A
         inc   -$10,s
         lsl   $0F,s
         jmp   -$0D,s
L2A7D    clr   $00,y
         bra   L2A8E
         neg   <u004C
         rol   $03,s
         eim   #$6E,-$0D,s
         eim   #$64,$00,y
         lsr   >$6F20
L2A8E    fcb   $41 A
         inc   -$10,s
         lsl   $01,s
         bra   L2AE8
         clr   $06,s
         lsr   >$7761
         aim   #$65,>$2054
L2A9E    eim   #$63,$08,s
         jmp   $0F,s
         inc   $0F,s
         asr   $09,s
         eim   #$73,$0D,x
         neg   <u0041
         inc   $0C,s
         bra   L2B22
         rol   $07,s
         lsl   -$0C,s
         com   >$2072
         eim   #$73,$05,s
         aim   #$76,>$6564
         bra   L2AE0
         bra   L2AE2
         bra   L2AE4
         bra   L2AE6
         bra   L2AE8
         bra   L2AEA
         bra   L2AEC
         bra   L2AEE
         bra   L2AF0
         bra   L2AF2
         tst   <u0000
L2AD4    tst   <u0020
         rora  
         rol   $0C,s
         eim   #$6E,$01,s
         tst   $05,s
         bra   L2B54
L2AE0    clr   $00,y
L2AE2    inc   $0F,s
L2AE4    oim   #$64,-$06,y
         neg   <u000D
         bra   L2B31
         rol   $0C,s
         eim   #$6E,$01,s
L2AF0    tst   $05,s
L2AF2    bra   L2B68
         clr   $00,y
         com   >$6176
         eim   #$3A,$00,x
L2AFC    tst   <u0050
         clr   -$0D,s
         rol   -$0C,s
         rol   $0F,s
         jmp   $00,y
         comb  
         oim   #$76,$05,s
         lsr   $01,y
         brn   L2B1B
         neg   <u000D
         negb  
         clr   -$0D,s
         rol   -$0C,s
         rol   $0F,s
         jmp   $00,y
         fcb   $52 R
         eim   #$73,-$0C,s
         clr   -$0E,s
         eim   #$64,$0D,x
L2B22    neg   <u000D
         bra   L2B73
         clr   -$0A,s
         rol   $0E,s
         asr   $00,y
         com   >$6372
         eim   #$65,$0E,s
         bra   L2B96
         eim   #$66,>$6665
         aim   #$2E,>$2E2E
         tst   <u0000
L2B3E    tst   <u005A
         oim   #$70,-$06,y
         bra   L2B65
         bra   L2B9A
         fcb   $3E >
         bra   L2B9D
         com   -$0E,s
         eim   #$65,$0E,s
         bra   L2B93
         eim   #$66,>$6665
         aim   #$0D,>$0020
         bra   L2B7B
         bra   L2B7D
         bra   L2B7F
         fcb   $52 R
         fcb   $3E >
         bra   L2BB5
         eim   #$63,$0F,s
         aim   #$64,>$2042
         eim   #$66,>$6665
         aim   #$0D,>$0020
         bra   L2B94
         bra   L2B96
         bra   L2B98
         fcb   $42 B
         fcb   $3E >
         bra   L2BBE
         clr   -$0C,s
         lsl   $00,y
         bra   L2BA2
         aim   #$75,$06,s
         ror   $05,s
         aim   #$73,>$0D00
L2B8B    bra   L2BAD
         bra   L2BAF
         bra   L2BB1
         bra   L2BD7
L2B93    fcb   $3E >
L2B94    bra   L2BE9
L2B96    com   -$0E,s
L2B98    eim   #$65,$0E,s
         bra   L2BE0
L2B9D    lsl   $01,s
         aim   #$61,>$6374
         eim   #$72,$0D,x
         neg   <u0020
         bra   L2BCA
         bra   L2BCC
         bra   L2BCE
         lsrb  
L2BAF    fcb   $3E >
         bra   L2C04
         eim   #$63,$0F,s
L2BB5    aim   #$64,>$2043
         lsl   $01,s
         aim   #$61,>$6374
         eim   #$72,$0D,x
         neg   <u0059
         clr   -$0B,s
         aim   #$20,>$4368
L2BCA    clr   $09,s
L2BCC    com   $05,s
L2BCE    abx   
         neg   <u000C
         tst   <u000D
         bra   L2BF5
         bra   L2BF7
L2BD7    bra   L2C1A
         aim   #$65,>$2079
         clr   -$0B,s
         bra   L2C54
         eim   #$72,>$653F
         neg   <u0020
         neg   <u0020
L2BE9    neg   <u0020
         bra   L2C0D
         bra   L2C0F
         bra   L2C11
         bra   L2C13
         bra   L2C15
L2BF5    bra   L2C17
L2BF7    comb  
         eim   #$74,$00,y
         bra   L2C44
         aim   #$61,>$7068
         rol   $03,s
         com   >$0D00
L2C06    bra   L2C28
         bra   L2C2A
         bra   L2C2C
         bra   L2C2E
         bra   L2C30
         bra   L2C3F
         blt   L2C41
         blt   L2C43
         blt   L2C45
         blt   L2C47
L2C1A    blt   L2C49
         blt   L2C4B
         blt   L2C4D
         blt   L2C4F
         tst   <u000D
         neg   <u005B
         fcb   $52 R
         tstb  
L2C28    bra   L2C57
L2C2A    bra   L2C7E
L2C2C    eim   #$73,$05,s
         lsr   >$2047
         aim   #$61,>$7068
         rol   $03,s
         com   >$2028
         asr   >$6869
         lsr   >$6520
L2C41    clr   $0E,s
L2C43    bra   L2CA7
L2C45    inc   $01,s
L2C47    com   $0B,s
L2C49    bvs   L2C58
L2C4B    neg   <u005B
L2C4D    clra  
         tstb  
L2C4F    bra   L2C7E
         bra   L2C95
         clr   $0C,s
         lsr   $00,y
L2C57    clr   $0E,s
         tst   <u0000
L2C5B    fcb   $5B [
         fcb   $55 U
         tstb  
         bra   L2C8D
         bra   L2CB7
         jmp   $04,s
         eim   #$72,-$0D,s
         com   $0F,s
         aim   #$65,>$206F
         jmp   $0D,x
         neg   <u005B
         inca  
         tstb  
         bra   L2CA2
         bra   L2CB9
         inc   $09,s
         jmp   $0B,s
         bra   L2CEC
         jmp   $0D,x
         neg   <u005B
         rorb  
         tstb  
         bra   L2CB2
         bra   L2CD9
         eim   #$76,$05,s
         aim   #$73,>$6520
         rorb  
         rol   $04,s
         eim   #$6F,$00,y
         clr   $0E,s
         tst   <u0000
L2C98    fcb   $5B [
         rola  
         tstb  
         bra   L2CCA
         bra   L2CE8
         jmp   -$0A,s
         rol   -$0D,s
         rol   $02,s
         inc   $05,s
L2CA7    bra   L2D18
         jmp   $0D,x
         neg   <u005B
         rora  
         tstb  
         bra   L2CDE
         bra   L2D06
         eim   #$74,$00,y
         ror   $0F,s
         aim   #$65,>$6772
         clr   -$0B,s
         jmp   $04,s
         bra   L2D25
         clr   $0C,s
         clr   -$0E,s
         tst   <u0000
L2CC8    fcb   $5B [
         fcb   $42 B
L2CCA    tstb  
         bra   L2CFA
         bra   L2D22
         eim   #$74,$00,y
         aim   #$61,$03,s
         tim   #$67,-$0E,s
         clr   -$0B,s
         jmp   $04,s
         bra   L2D41
L2CDE    clr   $0C,s
         clr   -$0E,s
         tst   <u0000
L2CE4    fcb   $5B [
         lsra  
         tstb  
         bra   L2D16
         bra   L2D2F
         clr   $0E,s
         eim   #$0D,$00,x
L2CF0    tst   <u0053
         eim   #$6C,$05,s
         com   -$0C,s
         bra   L2D72
         clr   -$0B,s
         aim   #$20,>$6368
         clr   $09,s
         com   $05,s
         abx   
         neg   <u0025
L2D06    leay  $04,s
         abx   
         bra   L2D30
         com   >$0D00
L2D0E    tst   <u0043
         clr   $0C,s
         clr   -$0E,s
         bra   L2D39
L2D16    abx   
         neg   <u0020
         bra   L2D3B
         bra   L2D3D
         bra   L2D3F
         bra   L2D41
         bra   L2D43
         bra   L2D45
L2D25    bra   L2D47
         bra   L2D49
         bra   L2D4B
         bra   L2D2D
L2D2D    bcs   L2DA2
L2D2F    tst   <u0000
L2D31    tst   <u0020
         bra   L2D55
         bra   L2D57
         bra   L2D59
L2D39    bra   L2D5B
L2D3B    bra   L2D5D
L2D3D    bra   L2D5F
L2D3F    bra   L2D61
L2D41    fcb   $45 E
         fcb   $52 R
L2D43    fcb   $52 R
         clra  
L2D45    fcb   $52 R
         bra   L2D6D
         leax  -$0D,y
         lsr   $0D,x
         neg   <u0034
         nega  
         leax  >$0049,y
         stx   >$37B5,y
L2D57    leax  $06,s
L2D59    pshs  x
L2D5B    ldd   $06,s
L2D5D    bra   L2D6D
L2D5F    pshs  u
L2D61    ldd   $04,s
         std   >$37B5,y
         leax  $08,s
         pshs  x
         ldd   $08,s
L2D6D    pshs  b,a
         leax  >L3225,pcr
         pshs  x
         bsr   L2D9F
         leas  $06,s
         puls  pc,u
         pshs  u
         ldd   $04,s
         std   >$37B5,y
         leax  $08,s
         pshs  x
         ldd   $08,s
         pshs  b,a
         leax  >L3238,pcr
         pshs  x
         bsr   L2D9F
         leas  $06,s
         clra  
         clrb  
         stb   [>$37B5,y]
         ldd   $04,s
         puls  pc,u
L2D9F    pshs  u
         ldu   $06,s
         leas  -$0B,s
         bra   L2DB7
L2DA7    ldb   $08,s
         lbeq  L2FE8
         ldb   $08,s
         sex   
         pshs  b,a
         jsr   [<$11,s]
         leas  $02,s
L2DB7    ldb   ,u+
         stb   $08,s
         cmpb  #$25
         bne   L2DA7
         ldb   ,u+
         stb   $08,s
         clra  
         clrb  
         std   $02,s
         std   $06,s
         ldb   $08,s
         cmpb  #$2D
         bne   L2DDC
         ldd   #$0001
         std   >$37CB,y
         ldb   ,u+
         stb   $08,s
         bra   L2DE2
L2DDC    clra  
         clrb  
         std   >$37CB,y
L2DE2    ldb   $08,s
         cmpb  #$30
         bne   L2DED
         ldd   #$0030
         bra   L2DF0
L2DED    ldd   #$0020
L2DF0    std   >$37CD,y
         bra   L2E10
L2DF6    ldd   $06,s
         pshs  b,a
         ldd   #$000A
         lbsr  L365D
         pshs  b,a
         ldb   $0A,s
         sex   
         addd  #$FFD0
         addd  ,s++
         std   $06,s
         ldb   ,u+
         stb   $08,s
L2E10    ldb   $08,s
         sex   
         leax  >$010D,y
         leax  d,x
         ldb   ,x
         clra  
         andb  #$08
         bne   L2DF6
         ldb   $08,s
         cmpb  #$2E
         bne   L2E59
         ldd   #$0001
         std   $04,s
         bra   L2E43
L2E2D    ldd   $02,s
         pshs  b,a
         ldd   #$000A
         lbsr  L365D
         pshs  b,a
         ldb   $0A,s
         sex   
         addd  #$FFD0
         addd  ,s++
         std   $02,s
L2E43    ldb   ,u+
         stb   $08,s
         ldb   $08,s
         sex   
         leax  >$010D,y
         leax  d,x
         ldb   ,x
         clra  
         andb  #$08
         bne   L2E2D
         bra   L2E5D
L2E59    clra  
         clrb  
         std   $04,s
L2E5D    ldb   $08,s
         sex   
         tfr   d,x
         lbra  L2F8B
L2E65    ldd   $06,s
         pshs  b,a
         ldx   <$15,s
         leax  $02,x
         stx   <$15,s
         ldd   -$02,x
         pshs  b,a
         lbsr  L2FEC
         bra   L2E8D
L2E7A    ldd   $06,s
         pshs  b,a
         ldx   <$15,s
         leax  $02,x
         stx   <$15,s
         ldd   -$02,x
         pshs  b,a
         lbsr  L30A9
L2E8D    std   ,s
         lbra  L2F71
L2E92    ldd   $06,s
         pshs  b,a
         ldb   $0A,s
         sex   
         leax  >$010D,y
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
         lbsr  L30F1
         lbra  L2F6D
L2EB8    ldd   $06,s
         pshs  b,a
         ldx   <$15,s
         leax  $02,x
         stx   <$15,s
         ldd   -$02,x
         pshs  b,a
         leax  >$37B7,y
         pshs  x
         lbsr  L3030
         lbra  L2F6D
L2ED4    ldd   $04,s
         bne   L2EDD
         ldd   #$0006
         std   $02,s
L2EDD    ldd   $06,s
         pshs  b,a
         leax  <$15,s
         pshs  x
         ldd   $06,s
         pshs  b,a
         ldb   $0E,s
         sex   
         pshs  b,a
         lbsr  L353A
         leas  $06,s
         lbra  L2F6F
L2EF7    ldx   <$13,s
         leax  $02,x
         stx   <$13,s
         ldd   -$02,x
         lbra  L2F81
L2F04    ldx   <$13,s
         leax  $02,x
         stx   <$13,s
         ldd   -$02,x
         std   $09,s
         ldd   $04,s
         beq   L2F4C
         ldd   $09,s
         std   $04,s
         bra   L2F26
L2F1A    ldb   [<$09,s]
         beq   L2F32
         ldd   $09,s
         addd  #$0001
         std   $09,s
L2F26    ldd   $02,s
         addd  #$FFFF
         std   $02,s
         subd  #$FFFF
         bne   L2F1A
L2F32    ldd   $06,s
         pshs  b,a
         ldd   $0B,s
         subd  $06,s
         pshs  b,a
         ldd   $08,s
         pshs  b,a
         ldd   <$15,s
         pshs  b,a
         lbsr  L315C
         leas  $08,s
         bra   L2F7B
L2F4C    ldd   $06,s
         pshs  b,a
         ldd   $0B,s
         bra   L2F6F
L2F54    ldb   ,u+
         stb   $08,s
         bra   L2F5C
         leas  -$0B,x
L2F5C    ldd   $06,s
         pshs  b,a
         leax  <$15,s
         pshs  x
         ldb   $0C,s
         sex   
         pshs  b,a
         lbsr  L34FC
L2F6D    leas  $04,s
L2F6F    pshs  b,a
L2F71    ldd   <$13,s
         pshs  b,a
         lbsr  L31BE
         leas  $06,s
L2F7B    lbra  L2DB7
L2F7E    ldb   $08,s
         sex   
L2F81    pshs  b,a
         jsr   [<$11,s]
         leas  $02,s
         lbra  L2DB7
L2F8B    cmpx  #$0064
         lbeq  L2E65
         cmpx  #$006F
         lbeq  L2E7A
         cmpx  #$0078
         lbeq  L2E92
         cmpx  #$0058
         lbeq  L2E92
         cmpx  #$0075
         lbeq  L2EB8
         cmpx  #$0066
         lbeq  L2ED4
         cmpx  #$0065
         lbeq  L2ED4
         cmpx  #$0067
         lbeq  L2ED4
         cmpx  #$0045
         lbeq  L2ED4
         cmpx  #$0047
         lbeq  L2ED4
         cmpx  #$0063
         lbeq  L2EF7
         cmpx  #$0073
         lbeq  L2F04
         cmpx  #$006C
         lbeq  L2F54
         bra   L2F7E
L2FE8    leas  $0B,s
         puls  pc,u
L2FEC    pshs  u,b,a
         leax  >$37B7,y
         stx   ,s
         ldd   $06,s
         bge   L3021
         ldd   $06,s
         nega  
         negb  
         sbca  #$00
         std   $06,s
         bge   L3016
         leax  >L324A,pcr
         pshs  x
         leax  >$37B7,y
         pshs  x
         lbsr  L3556
         leas  $04,s
         lbra  L30ED
L3016    ldd   #$002D
         ldx   ,s
         leax  $01,x
         stx   ,s
         stb   -$01,x
L3021    ldd   $06,s
         pshs  b,a
         ldd   $02,s
         pshs  b,a
         bsr   L3030
         leas  $04,s
         lbra  L30E7
L3030    pshs  u,y,x,b,a
         ldu   $0A,s
         clra  
         clrb  
         std   $02,s
         clra  
         clrb  
         std   ,s
         bra   L304D
L303E    ldd   ,s
         addd  #$0001
         std   ,s
         ldd   $0C,s
         subd  >$002F,y
         std   $0C,s
L304D    ldd   $0C,s
         blt   L303E
         leax  >$002F,y
         stx   $04,s
         bra   L308F
L3059    ldd   ,s
         addd  #$0001
         std   ,s
L3060    ldd   $0C,s
         subd  [<$04,s]
         std   $0C,s
         bge   L3059
         ldd   $0C,s
         addd  [<$04,s]
         std   $0C,s
         ldd   ,s
         beq   L3079
         ldd   #$0001
         std   $02,s
L3079    ldd   $02,s
         beq   L3084
         ldd   ,s
         addd  #$0030
         stb   ,u+
L3084    clra  
         clrb  
         std   ,s
         ldd   $04,s
         addd  #$0002
         std   $04,s
L308F    ldd   $04,s
         cmpd  >$0037,y
         bne   L3060
         ldd   $0C,s
         addd  #$0030
         stb   ,u+
         clra  
         clrb  
         stb   ,u
         ldd   $0A,s
         leas  $06,s
         puls  pc,u
L30A9    pshs  u,b,a
         leax  >$37B7,y
         stx   ,s
         leau  >$37C1,y
L30B5    ldd   $06,s
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
         bne   L30B5
         bra   L30D7
L30CD    ldb   ,u
         ldx   ,s
         leax  $01,x
         stx   ,s
         stb   -$01,x
L30D7    leau  -u0001,u
         pshs  u
         leax  >$37C1,y
         cmpx  ,s++
         bls   L30CD
         clra  
         clrb  
         stb   [,s]
L30E7    leax  >$37B7,y
         tfr   x,d
L30ED    leas  $02,s
         puls  pc,u
L30F1    pshs  u,x,b,a
         leax  >$37B7,y
         stx   $02,s
         leau  >$37C1,y
L30FD    ldd   $08,s
         clra  
         andb  #$0F
         std   ,s
         pshs  b,a
         ldd   $02,s
         cmpd  #$0009
         ble   L311F
         ldd   $0C,s
         beq   L3117
         ldd   #$0041
         bra   L311A
L3117    ldd   #$0061
L311A    addd  #$FFF6
         bra   L3122
L311F    ldd   #$0030
L3122    addd  ,s++
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
         bne   L30FD
         bra   L3142
L3138    ldb   ,u
         ldx   $02,s
         leax  $01,x
         stx   $02,s
         stb   -$01,x
L3142    leau  -u0001,u
         pshs  u
         leax  >$37C1,y
         cmpx  ,s++
         bls   L3138
         clra  
         clrb  
         stb   [<$02,s]
         leax  >$37B7,y
         tfr   x,d
         lbra  L3234
L315C    pshs  u
         ldu   $06,s
         ldd   $0A,s
         subd  $08,s
         std   $0A,s
         ldd   >$37CB,y
         bne   L3191
         bra   L3179
L316E    ldd   >$37CD,y
         pshs  b,a
         jsr   [<$06,s]
         leas  $02,s
L3179    ldd   $0A,s
         addd  #$FFFF
         std   $0A,s
         subd  #$FFFF
         bgt   L316E
         bra   L3191
L3187    ldb   ,u+
         sex   
         pshs  b,a
         jsr   [<$06,s]
         leas  $02,s
L3191    ldd   $08,s
         addd  #$FFFF
         std   $08,s
         subd  #$FFFF
         bne   L3187
         ldd   >$37CB,y
         beq   L31BC
         bra   L31B0
L31A5    ldd   >$37CD,y
         pshs  b,a
         jsr   [<$06,s]
         leas  $02,s
L31B0    ldd   $0A,s
         addd  #$FFFF
         std   $0A,s
         subd  #$FFFF
         bgt   L31A5
L31BC    puls  pc,u
L31BE    pshs  u
         ldu   $06,s
         ldd   $08,s
         pshs  b,a
         pshs  u
         lbsr  L3545
         leas  $02,s
         nega  
         negb  
         sbca  #$00
         addd  ,s++
         std   $08,s
         ldd   >$37CB,y
         bne   L3200
         bra   L31E8
L31DD    ldd   >$37CD,y
         pshs  b,a
         jsr   [<$06,s]
         leas  $02,s
L31E8    ldd   $08,s
         addd  #$FFFF
         std   $08,s
         subd  #$FFFF
         bgt   L31DD
         bra   L3200
L31F6    ldb   ,u+
         sex   
         pshs  b,a
         jsr   [<$06,s]
         leas  $02,s
L3200    ldb   ,u
         bne   L31F6
         ldd   >$37CB,y
         beq   L3223
         bra   L3217
L320C    ldd   >$37CD,y
         pshs  b,a
         jsr   [<$06,s]
         leas  $02,s
L3217    ldd   $08,s
         addd  #$FFFF
         std   $08,s
         subd  #$FFFF
         bgt   L320C
L3223    puls  pc,u
L3225    pshs  u
         ldd   >$37B5,y
         pshs  b,a
         ldd   $06,s
         pshs  b,a
         lbsr  L3251
L3234    leas  $04,s
         puls  pc,u
L3238    pshs  u
         ldd   $04,s
         ldx   >$37B5,y
         leax  $01,x
         stx   >$37B5,y
         stb   -$01,x
         puls  pc,u
L324A    blt   L327F
         leas  -$09,y
         pshu  y,x,dp
         neg   <u0034
         nega  
         ldu   $06,s
         ldd   u0006,u
         anda  #$80
         andb  #$22
         cmpd  #$8002
         beq   L3275
         ldd   u0006,u
         clra  
         andb  #$22
         cmpd  #$0002
         lbne  L338D
         pshs  u
         lbsr  L346C
         leas  $02,s
L3275    ldd   u0006,u
         clra  
         andb  #$04
         beq   L32B1
         ldd   #$0001
L327F    pshs  b,a
         leax  $07,s
         pshs  x
         ldd   u0008,u
         pshs  b,a
         ldd   u0006,u
         clra  
         andb  #$40
         beq   L3296
         leax  >L38EE,pcr
         bra   L329A
L3296    leax  >L38D5,pcr
L329A    tfr   x,d
         tfr   d,x
         jsr   ,x
         leas  $06,s
         cmpd  #$FFFF
         bne   L32F2
         ldd   u0006,u
         orb   #$20
         std   u0006,u
         lbra  L338D
L32B1    ldd   u0006,u
         anda  #$01
         clrb  
         std   -$02,s
         bne   L32C1
         pshs  u
         lbsr  L33AA
         leas  $02,s
L32C1    ldd   ,u
         addd  #$0001
         std   ,u
         subd  #$0001
         tfr   d,x
         ldd   $04,s
         stb   ,x
         ldd   ,u
         cmpd  u0004,u
         bcc   L32E7
         ldd   u0006,u
         clra  
         andb  #$40
         beq   L32F2
         ldd   $04,s
         cmpd  #$000D
         bne   L32F2
L32E7    pshs  u
         lbsr  L33AA
         std   ,s++
         lbne  L338D
L32F2    ldd   $04,s
         puls  pc,u
         pshs  u
         ldu   $04,s
         ldd   $06,s
         pshs  b,a
         pshs  u
         ldd   #$0008
         lbsr  L3787
         pshs  b,a
         lbsr  L3251
         leas  $04,s
         ldd   $06,s
         pshs  b,a
         pshs  u
         lbsr  L3251
         lbra  L3464
L3319    pshs  u,b,a
         leau  >$003C,y
         clra  
         clrb  
         std   ,s
         bra   L332F
L3325    tfr   u,d
         leau  u000D,u
         pshs  b,a
         bsr   L3342
         leas  $02,s
L332F    ldd   ,s
         addd  #$0001
         std   ,s
         subd  #$0001
         cmpd  #$0010
         blt   L3325
         lbra  L33A6
L3342    pshs  u
         ldu   $04,s
         leas  -$02,s
         cmpu  #$0000
         beq   L3352
         ldd   u0006,u
         bne   L3358
L3352    ldd   #$FFFF
         lbra  L33A6
L3358    ldd   u0006,u
         clra  
         andb  #$02
         beq   L3367
         pshs  u
         bsr   L337C
         leas  $02,s
         bra   L3369
L3367    clra  
         clrb  
L3369    std   ,s
         ldd   u0008,u
         pshs  b,a
         lbsr  L3837
         leas  $02,s
         clra  
         clrb  
         std   u0006,u
         ldd   ,s
         bra   L33A6
L337C    pshs  u
         ldu   $04,s
         beq   L338D
         ldd   u0006,u
         clra  
         andb  #$22
         cmpd  #$0002
         beq   L3392
L338D    ldd   #$FFFF
         puls  pc,u
L3392    ldd   u0006,u
         anda  #$80
         clrb  
         std   -$02,s
         bne   L33A2
         pshs  u
         lbsr  L346C
         leas  $02,s
L33A2    pshs  u
         bsr   L33AA
L33A6    leas  $02,s
         puls  pc,u
L33AA    pshs  u
         ldu   $04,s
         leas  -$04,s
         ldd   u0006,u
         anda  #$01
         clrb  
         std   -$02,s
         bne   L33DC
         ldd   ,u
         cmpd  u0004,u
         beq   L33DC
         clra  
         clrb  
         pshs  b,a
         pshs  u
         lbsr  L3468
         leas  $02,s
         ldd   $02,x
         pshs  b,a
         ldd   ,x
         pshs  b,a
         ldd   u0008,u
         pshs  b,a
         lbsr  L38FE
         leas  $08,s
L33DC    ldd   ,u
         subd  u0002,u
         std   $02,s
         lbeq  L3454
         ldd   u0006,u
         anda  #$01
         clrb  
         std   -$02,s
         lbeq  L3454
         ldd   u0006,u
         clra  
         andb  #$40
         beq   L342B
         ldd   u0002,u
         bra   L3423
L33FC    ldd   $02,s
         pshs  b,a
         ldd   ,u
         pshs  b,a
         ldd   u0008,u
         pshs  b,a
         lbsr  L38EE
         leas  $06,s
         std   ,s
         cmpd  #$FFFF
         bne   L3419
         leax  $04,s
         bra   L3443
L3419    ldd   $02,s
         subd  ,s
         std   $02,s
         ldd   ,u
         addd  ,s
L3423    std   ,u
         ldd   $02,s
         bne   L33FC
         bra   L3454
L342B    ldd   $02,s
         pshs  b,a
         ldd   u0002,u
         pshs  b,a
         ldd   u0008,u
         pshs  b,a
         lbsr  L38D5
         leas  $06,s
         cmpd  $02,s
         beq   L3454
         bra   L3445
L3443    leas  -$04,x
L3445    ldd   u0006,u
         orb   #$20
         std   u0006,u
         ldd   u0004,u
         std   ,u
         ldd   #$FFFF
         bra   L3464
L3454    ldd   u0006,u
         ora   #$01
         std   u0006,u
         ldd   u0002,u
         std   ,u
         addd  u000B,u
         std   u0004,u
         clra  
         clrb  
L3464    leas  $04,s
         puls  pc,u
L3468    pshs  u
         puls  pc,u
L346C    pshs  u
         ldu   $04,s
         ldd   u0006,u
         clra  
         andb  #$C0
         bne   L34A4
         leas  <-$20,s
         leax  ,s
         pshs  x
         ldd   u0008,u
         pshs  b,a
         clra  
         clrb  
         pshs  b,a
         lbsr  L37B9
         leas  $06,s
         ldd   u0006,u
         pshs  b,a
         ldb   $02,s
         bne   L3498
         ldd   #$0040
         bra   L349B
L3498    ldd   #$0080
L349B    ora   ,s+
         orb   ,s+
         std   u0006,u
         leas  <$20,s
L34A4    ldd   u0006,u
         ora   #$80
         std   u0006,u
         clra  
         andb  #$0C
         beq   L34B1
         puls  pc,u
L34B1    ldd   u000B,u
         bne   L34C6
         ldd   u0006,u
         clra  
         andb  #$40
         beq   L34C1
         ldd   #$0080
         bra   L34C4
L34C1    ldd   #$0100
L34C4    std   u000B,u
L34C6    ldd   u0002,u
         bne   L34DB
         ldd   u000B,u
         pshs  b,a
         lbsr  L39EE
         leas  $02,s
         std   u0002,u
         cmpd  #$FFFF
         beq   L34E3
L34DB    ldd   u0006,u
         orb   #$08
         std   u0006,u
         bra   L34F2
L34E3    ldd   u0006,u
         orb   #$04
         std   u0006,u
         leax  u000A,u
         stx   u0002,u
         ldd   #$0001
         std   u000B,u
L34F2    ldd   u0002,u
         addd  u000B,u
         std   u0004,u
         std   ,u
         puls  pc,u
L34FC    pshs  u
         ldb   $05,s
         sex   
         tfr   d,x
         bra   L3522
L3505    ldd   [<$06,s]
         addd  #$0004
         std   [<$06,s]
         leax  >L3539,pcr
         bra   L351E
L3514    ldb   $05,s
         stb   >$003A,y
         leax  >$0039,y
L351E    tfr   x,d
         puls  pc,u
L3522    cmpx  #$0064
         beq   L3505
         cmpx  #$006F
         lbeq  L3505
         cmpx  #$0078
         lbeq  L3505
         bra   L3514
         puls  pc,u
L3539    neg   <u0034
         nega  
         leax  >L3544,pcr
         tfr   x,d
         puls  pc,u
L3544    neg   <u0034
         nega  
         ldu   $04,s
L3549    ldb   ,u+
         bne   L3549
         tfr   u,d
         subd  $04,s
         addd  #$FFFF
         puls  pc,u
L3556    pshs  u
         ldu   $06,s
         leas  -$02,s
         ldd   $06,s
         std   ,s
L3560    ldb   ,u+
         ldx   ,s
         leax  $01,x
         stx   ,s
         stb   -$01,x
         bne   L3560
         bra   L3595
         pshs  u
         ldu   $06,s
         leas  -$02,s
         ldd   $06,s
         std   ,s
L3578    ldx   ,s
         leax  $01,x
         stx   ,s
         ldb   -$01,x
         bne   L3578
         ldd   ,s
         addd  #$FFFF
         std   ,s
L3589    ldb   ,u+
         ldx   ,s
         leax  $01,x
         stx   ,s
         stb   -$01,x
         bne   L3589
L3595    ldd   $06,s
         leas  $02,s
         puls  pc,u
         pshs  u
         ldu   $04,s
         bra   L35B1
L35A1    ldx   $06,s
         leax  $01,x
         stx   $06,s
         ldb   -$01,x
         bne   L35AF
         clra  
         clrb  
         puls  pc,u
L35AF    leau  u0001,u
L35B1    ldb   ,u
         sex   
         pshs  b,a
         ldb   [<$08,s]
         sex   
         cmpd  ,s++
         beq   L35A1
         ldb   [<$06,s]
         sex   
         pshs  b,a
         ldb   ,u
         sex   
         subd  ,s++
         puls  pc,u
L35CC    pshs  u
         ldu   $04,s
         leas  -$05,s
         clra  
         clrb  
         std   $01,s
L35D6    ldb   ,u+
         stb   ,s
         cmpb  #$20
         beq   L35D6
         ldb   ,s
         cmpb  #$09
         lbeq  L35D6
         ldb   ,s
         cmpb  #$2D
         bne   L35F1
         ldd   #$0001
         bra   L35F3
L35F1    clra  
         clrb  
L35F3    std   $03,s
         ldb   ,s
         cmpb  #$2D
         beq   L3619
         ldb   ,s
         cmpb  #$2B
         bne   L361D
         bra   L3619
L3603    ldd   $01,s
         pshs  b,a
         ldd   #$000A
         lbsr  L365D
         pshs  b,a
         ldb   $02,s
         sex   
         addd  ,s++
         addd  #$FFD0
         std   $01,s
L3619    ldb   ,u+
         stb   ,s
L361D    ldb   ,s
         sex   
         leax  >$010D,y
         leax  d,x
         ldb   ,x
         clra  
         andb  #$08
         bne   L3603
         ldd   $03,s
         beq   L3639
         ldd   $01,s
         nega  
         negb  
         sbca  #$00
         bra   L363B
L3639    ldd   $01,s
L363B    leas  $05,s
         puls  pc,u
L363F    pshs  u
         ldd   $04,s
         beq   L3651
         ldd   $04,s
         pshs  b,a
         ldd   #$000A
         lbsr  L365D
         bra   L3654
L3651    ldd   #$0001
L3654    pshs  b,a
         lbsr  L398B
         leas  $02,s
         puls  pc,u
L365D    tsta  
         bne   L3672
         tst   $02,s
         bne   L3672
         lda   $03,s
         mul   
         ldx   ,s
         stx   $02,s
         ldx   #$0000
         std   ,s
         puls  pc,b,a
L3672    pshs  b,a
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
         bcc   L368F
         inc   ,s
L368F    lda   $04,s
         ldb   $09,s
         mul   
         addd  $01,s
         std   $01,s
         bcc   L369C
         inc   ,s
L369C    lda   $04,s
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
         clr   >$37CF,y
         leax  >L36F8,pcr
         stx   >$37D0,y
         bra   L36D2
L36BE    leax  >L3711,pcr
         stx   >$37D0,y
         clr   >$37CF,y
         tst   $02,s
         bpl   L36D2
         inc   >$37CF,y
L36D2    subd  #$0000
         bne   L36DD
         puls  x
         ldd   ,s++
         jmp   ,x
L36DD    ldx   $02,s
         pshs  x
         jsr   [>$37D0,y]
         ldd   ,s
         std   $02,s
         tfr   x,d
         tst   >$37CF,y
         beq   L36F5
         nega  
         negb  
         sbca  #$00
L36F5    std   ,s++
         rts   
L36F8    subd  #$0000
         beq   L3707
         pshs  b,a
         leas  -$02,s
         clr   ,s
         clr   $01,s
         bra   L3735
L3707    puls  b,a
         std   ,s
         ldd   #$002D
         lbra  L37AA
L3711    subd  #$0000
         beq   L3707
         pshs  b,a
         leas  -$02,s
         clr   ,s
         clr   $01,s
         tsta  
         bpl   L3729
         nega  
         negb  
         sbca  #$00
         inc   $01,s
         std   $02,s
L3729    ldd   $06,s
         bpl   L3735
         nega  
         negb  
         sbca  #$00
         com   $01,s
         std   $06,s
L3735    lda   #$01
L3737    inca  
         lsl   $03,s
         rol   $02,s
         bpl   L3737
         sta   ,s
         ldd   $06,s
         clr   $06,s
         clr   $07,s
L3746    subd  $02,s
         bcc   L3750
         addd  $02,s
         andcc #$FE
         bra   L3752
L3750    orcc  #$01
L3752    rol   $07,s
         rol   $06,s
         lsr   $02,s
         ror   $03,s
         dec   ,s
         bne   L3746
         std   $02,s
         tst   $01,s
         beq   L376C
         ldd   $06,s
         nega  
         negb  
         sbca  #$00
         std   $06,s
L376C    ldx   $04,s
         ldd   $06,s
         std   $04,s
         stx   $06,s
         ldx   $02,s
         ldd   $04,s
         leas  $06,s
         rts   
         tstb  
         beq   L3791
L377E    asr   $02,s
         ror   $03,s
         decb  
         bne   L377E
         bra   L3791
L3787    tstb  
         beq   L3791
L378A    lsr   $02,s
         ror   $03,s
         decb  
         bne   L378A
L3791    ldd   $02,s
         pshs  b,a
         ldd   $02,s
         std   $04,s
         ldd   ,s
         leas  $04,s
         rts   
         tstb  
         beq   L3791
L37A1    lsl   $03,s
         rol   $02,s
         decb  
         bne   L37A1
         bra   L3791
L37AA    std   >$01DB,y
         pshs  y,b
         os9   F$ID     
         puls  y,b
         os9   F$Send   
         rts   
L37B9    lda   $05,s
         ldb   $03,s
         beq   L37EC
         cmpb  #$01
         beq   L37EE
         cmpb  #$06
         beq   L37EE
         cmpb  #$02
         beq   L37D4
         cmpb  #$05
         beq   L37D4
         ldb   #$D0
         lbra  L3A1B
L37D4    pshs  u
         os9   I$GetStt 
         bcc   L37E0
         puls  u
         lbra  L3A1B
L37E0    stx   [<$08,s]
         ldx   $08,s
         stu   $02,x
         puls  u
         clra  
         clrb  
         rts   
L37EC    ldx   $06,s
L37EE    os9   I$GetStt 
         lbra  L3A24
L37F4    lda   $05,s
         ldb   $03,s
         beq   L3803
         cmpb  #$02
         beq   L380B
         ldb   #$D0
         lbra  L3A1B
L3803    ldx   $06,s
         os9   I$SetStt 
         lbra  L3A24
L380B    pshs  u
         ldx   $08,s
         ldu   $0A,s
         os9   I$SetStt 
         puls  u
         lbra  L3A24
         ldx   $02,s
         lda   $05,s
         os9   I$Open   
         bcs   L3825
         os9   I$Close  
L3825    lbra  L3A24
L3828    ldx   $02,s
         lda   $05,s
         os9   I$Open   
         lbcs  L3A1B
         tfr   a,b
         clra  
         rts   
L3837    lda   $03,s
         os9   I$Close  
         lbra  L3A24
         ldx   $02,s
         ldb   $05,s
         os9   I$MakDir 
         lbra  L3A24
L3849    ldx   $02,s
         lda   $05,s
         tfr   a,b
         andb  #$24
         orb   #$0B
         os9   I$Create 
         bcs   L385C
L3858    tfr   a,b
         clra  
         rts   
L385C    cmpb  #$DA
         lbne  L3A1B
         lda   $05,s
         bita  #$80
         lbne  L3A1B
         anda  #$07
         ldx   $02,s
         os9   I$Open   
         lbcs  L3A1B
         pshs  u,a
         ldx   #$0000
         leau  ,x
         ldb   #$02
         os9   I$SetStt 
         puls  u,a
         bcc   L3858
         pshs  b
         os9   I$Close  
         puls  b
         lbra  L3A1B
         ldx   $02,s
         os9   I$Delete 
         lbra  L3A24
         lda   $03,s
         os9   I$Dup    
         lbcs  L3A1B
         tfr   a,b
         clra  
         rts   
L38A4    pshs  y
         ldx   $06,s
         lda   $05,s
         ldy   $08,s
         pshs  y
         os9   I$Read   
L38B2    bcc   L38C1
         cmpb  #$D3
         bne   L38BC
         clra  
         clrb  
         puls  pc,y,x
L38BC    puls  y,x
         lbra  L3A1B
L38C1    tfr   y,d
         puls  pc,y,x
L38C5    pshs  y
         lda   $05,s
         ldx   $06,s
         ldy   $08,s
         pshs  y
         os9   I$ReadLn 
         bra   L38B2
L38D5    pshs  y
         ldy   $08,s
         beq   L38EA
         lda   $05,s
         ldx   $06,s
         os9   I$Write  
L38E3    bcc   L38EA
         puls  y
         lbra  L3A1B
L38EA    tfr   y,d
         puls  pc,y
L38EE    pshs  y
         ldy   $08,s
         beq   L38EA
         lda   $05,s
         ldx   $06,s
         os9   I$WritLn 
         bra   L38E3
L38FE    pshs  u
         ldd   $0A,s
         bne   L390C
         ldu   #$0000
         ldx   #$0000
         bra   L3940
L390C    cmpd  #$0001
         beq   L3937
         cmpd  #$0002
         beq   L392C
         ldb   #$F7
L391A    clra  
         std   >$01DB,y
         ldd   #$FFFF
         leax  >$01CF,y
         std   ,x
         std   $02,x
         puls  pc,u
L392C    lda   $05,s
         ldb   #$02
         os9   I$GetStt 
         bcs   L391A
         bra   L3940
L3937    lda   $05,s
         ldb   #$05
         os9   I$GetStt 
         bcs   L391A
L3940    tfr   u,d
         addd  $08,s
         std   >$01D1,y
         tfr   d,u
         tfr   x,d
         adcb  $07,s
         adca  $06,s
         bmi   L391A
         tfr   d,x
         std   >$01CF,y
         lda   $05,s
         os9   I$Seek   
         bcs   L391A
         leax  >$01CF,y
         puls  pc,u
         rts   
         ldx   #$0000
         clrb  
         os9   F$Sleep  
         lbra  L3A1B
         rts   
         pshs  u,y
         ldx   $06,s
         ldy   $08,s
         ldu   $0A,s
         os9   F$CRC    
         puls  pc,u,y
         lda   $03,s
         ldb   $05,s
         os9   F$PErr   
         lbcs  L3A1B
         rts   
L398B    ldx   $02,s
         os9   F$Sleep  
         lbcs  L3A1B
         tfr   x,d
         rts   
         ldd   >$01CD,y
         pshs  b,a
         ldd   $04,s
         cmpd  >$37D2,y
         bcs   L39CB
         addd  >$01CD,y
         pshs  y
         subd  ,s
         os9   F$Mem    
         tfr   y,d
         puls  y
         bcc   L39BD
         ldd   #$FFFF
         leas  $02,s
         rts   
L39BD    std   >$01CD,y
         addd  >$37D2,y
         subd  ,s
         std   >$37D2,y
L39CB    leas  $02,s
         ldd   >$37D2,y
         pshs  b,a
         subd  $04,s
         std   >$37D2,y
         ldd   >$01CD,y
         subd  ,s++
         pshs  b,a
         clra  
         ldx   ,s
L39E4    sta   ,x+
         cmpx  >$01CD,y
         bcs   L39E4
         puls  pc,b,a
L39EE    ldd   $02,s
         addd  >$01D7,y
         bcs   L3A17
         cmpd  >$01D9,y
         bcc   L3A17
         pshs  b,a
         ldx   >$01D7,y
         clra  
L3A04    cmpx  ,s
         bcc   L3A0C
         sta   ,x+
         bra   L3A04
L3A0C    ldd   >$01D7,y
         puls  x
         stx   >$01D7,y
         rts   
L3A17    ldd   #$FFFF
         rts   
L3A1B    clra  
         std   >$01DB,y
         ldd   #$FFFF
         rts   
L3A24    bcs   L3A1B
         clra  
         clrb  
         rts   
L3A29    lbsr  L3A34
         lbsr  L3319
L3A2F    ldd   $02,s
         os9   F$Exit   
L3A34    rts   
L3A35    lda   $03,s
         ldb   #$01
         os9   I$GetStt 
         lbcs  L3A1B
         clra  
         rts   
         ldd   #$1B20
         bsr   L3A5B
         ldb   #$09
         tst   $05,s
         ble   L3A4F
         ldb   #$0A
L3A4F    lbra  L3B43
L3A52    ldd   #$1B22
         bsr   L3A5B
         ldb   #$09
         bra   L3A4F
L3A5B    leax  >$37D4,y
         std   ,x++
         lda   $07,s
         ldb   $09,s
         std   ,x++
         lda   $0B,s
         ldb   $0D,s
         std   ,x++
         lda   $0F,s
         ldb   <$11,s
         std   ,x++
         lda   <$13,s
         ldb   <$15,s
         std   ,x
         rts   
         ldd   #$1B24
         bra   L3A8A
L3A82    ldd   #$1B23
         bra   L3A8A
         ldd   #$1B21
L3A8A    std   >$37D4,y
         ldb   #$02
         lbra  L3B43
         ldd   #$1B30
         std   >$37D4,y
         ldb   #$02
         lbra  L3B43
L3A9F    ldb   #$32
         bra   L3AAD
L3AA3    ldb   #$33
         bra   L3AAD
         ldb   #$34
         bra   L3AAD
         ldb   #$2F
L3AAD    lda   #$1B
         std   >$37D4,y
         ldb   $05,s
         stb   >$37D6,y
         ldb   #$03
         lbra  L3B43
         ldb   #$01
         bra   L3AF2
         ldb   #$03
         bra   L3AF2
L3AC6    ldb   #$04
         bra   L3AF2
L3ACA    ldd   #$0520
         bra   L3B21
L3ACF    ldd   #$0521
         bra   L3B21
L3AD4    ldb   #$06
         bra   L3AF2
L3AD8    ldb   #$07
         bra   L3AF2
L3ADC    ldb   #$08
         bra   L3AF2
L3AE0    ldb   #$09
         bra   L3AF2
L3AE4    ldb   #$0A
         bra   L3AF2
         ldb   #$0B
         bra   L3AF2
L3AEC    ldb   #$0C
         bra   L3AF2
         ldb   #$0D
L3AF2    stb   >$37D4,y
         ldb   #$01
         lbra  L3B43
L3AFB    ldd   #$1F20
         bra   L3B21
L3B00    ldd   #$1F21
         bra   L3B21
L3B05    ldd   #$1F22
         bra   L3B21
L3B0A    ldd   #$1F23
         bra   L3B21
L3B0F    ldd   #$1F24
         bra   L3B21
L3B14    ldd   #$1F25
         bra   L3B21
         ldd   #$1F30
         bra   L3B21
         ldd   #$1F31
L3B21    std   >$37D4,y
         ldb   #$02
         lbra  L3B43
L3B2A    leax  >$37D4,y
         ldb   #$02
         stb   ,x+
         ldd   $04,s
         addb  #$20
         stb   ,x+
         ldd   $06,s
         addb  #$20
         stb   ,x+
         ldb   #$03
         lbra  L3B43
L3B43    clra  
         leax  >$37D4,y
         pshs  y
         tfr   d,y
         lda   $05,s
         os9   I$Write  
         puls  y
         bcs   L3B58
         clra  
         clrb  
         rts   
L3B58    clra  
         std   >$01DB,y
         ldd   #$FFFF
         rts   
L3B61    neg   <u0001
         neg   <u0001
         cmpx  #$0000
         neg   <u0000
         neg   <u0000
         neg   <u0000
         neg   <u0000
         neg   <u0000
         neg   <u0000
         neg   <u0002
         neg   <u0004
         neg   <u0003
         neg   <u0005
         neg   <u0001
         neg   <u0006
         neg   <u0007
         neg   <u0000
         bne   L3BC5
         bne   L3BCD
         bne   L3BD3
         bne   L3BDB
         bne   L3BE4
         bne   L3BEB
         bne   L3BF5
         bne   L3BFC
         beq   L3BA6
         com   <u00E8
         neg   <u0064
         neg   <u000A
         neg   <u0037
         inc   -$08,s
         neg   <u0000
         neg   <u0000
         neg   <u0000
L3BA6    neg   <u0000
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
L3BC5    neg   <u0000
         neg   <u0000
         neg   <u0000
         neg   <u0000
L3BCD    neg   <u0000
         neg   <u0000
         neg   <u0000
L3BD3    neg   <u0000
         neg   <u0000
         neg   <u0000
         neg   <u0000
L3BDB    neg   <u0000
         neg   <u0000
         neg   <u0000
         neg   <u0000
         neg   <u0000
         neg   <u0000
         neg   <u0000
         neg   <u0000
L3BEB    neg   <u0000
         neg   <u0000
         neg   <u0000
         neg   <u0000
         neg   <u0000
L3BF5    neg   <u0000
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
         bra   L3CB6
         bra   L3CB8
         bra   L3CBA
         bra   L3CBC
         bra   L3CBE
         bra   L3CC0
         bra   L3CC2
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
         bra   L3CCE
         bra   L3CD0
         bra   L3CD2
         bra   L3CF6
         fcb   $42 B
         fcb   $42 B
L3CB6    fcb   $42 B
         fcb   $42 B
L3CB8    fcb   $42 B
         aim   #$02,<u0002
L3CBC    aim   #$02,<u0002
         aim   #$02,<u0002
L3CC2    aim   #$02,<u0002
         aim   #$02,<u0002
         aim   #$02,<u0002
         aim   #$02,<u0020
L3CCE    bra   L3CF0
L3CD0    bra   L3CF2
L3CD2    bra   L3D18
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
         bra   L3D0F
         bra   L3D11
         oim   #$00,<u0008
         neg   <u001F
L3CF6    neg   <u002D
         neg   <u002B
         neg   <u0029
         neg   <u0027
         neg   <u0025
         neg   <u0023
         neg   <u0021
         neg   <u0001
         neg   <u0037
         fcb   $41 A
         jmp   -$0D,s
         rol   u0005,u
         lsr   $00,x
         emod
eom      equ   *
         end
