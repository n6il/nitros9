         nam   Quikterm
         ttl   program module       

* Disassembled 2010/01/24 10:47:16 by Disasm v1.5 (C) 1988 by RML

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
u0008    rmb   2
u000A    rmb   1
u000B    rmb   2
u000D    rmb   1
u000E    rmb   3
u0011    rmb   15
u0020    rmb   5
u0025    rmb   13
u0032    rmb   2
u0034    rmb   13
u0041    rmb   1
u0042    rmb   1
u0043    rmb   3
u0046    rmb   12
u0052    rmb   1
u0053    rmb   1
u0054    rmb   16
u0064    rmb   132
u00E8    rmb   124
u0164    rmb   2
u0166    rmb   58
u01A0    rmb   1
u01A1    rmb   3
u01A4    rmb   1252
size     equ   .
name     equ   *
         fcs   /Quikterm/
         fcb   $01 
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
         leax  >$0308,x
         pshs  x
         leay  >L21E0,pcr
         ldx   ,y++
         beq   L0040
         bsr   L0016
         ldu   $02,s
L0040    leau  >u0001,u
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
         stx   >u01A4,u
         sty   >u0164,u
         ldd   #$0001
         std   >u01A0,u
         leay  >u0166,u
         leax  ,s
         lda   ,x+
L0086    ldb   >u01A1,u
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
         inc   >u01A1,u
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
         inc   >u01A1,u
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
L00E2    leax  >u0164,u
         pshs  x
         ldd   >u01A0,u
         pshs  b,a
         leay  ,u
         bsr   L00FC
         lbsr  L022F
         clr   ,-s
         clr   ,-s
         lbsr  L2127
L00FC    leax  >$0308,y
         stx   >$01AE,y
         sts   >$01A2,y
         sts   >$01B0,y
         ldd   #$FF82
L0111    leax  d,s
         cmpx  >$01B0,y
         bcc   L0123
         cmpx  >$01AE,y
         bcs   L013D
         stx   >$01B0,y
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
         lbsr  L212D
L0152    ldd   >$01A2,y
         subd  >$01B0,y
         rts   
         ldd   >$01B0,y
         subd  >$01AE,y
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
         ldd   #$FFB0
         lbsr  L0111
         leas  -$06,s
         ldx   $0A,s
         lbra  L0221
L018D    ldd   >$01B6,y
         pshs  b,a
         lbsr  L2133
         leas  $02,s
         std   $04,s
         pshs  b,a
         leax  >$01DA,y
         pshs  x
         ldd   >$01B6,y
         pshs  b,a
         lbsr  L1F80
         leas  $06,s
         ldd   $04,s
         pshs  b,a
         leax  >$01DA,y
         pshs  x
         ldd   >$01B4,y
         pshs  b,a
         lbsr  L1FB1
         leas  $06,s
         lbra  L022B
L01C5    ldd   >$01B6,y
         pshs  b,a
         lbsr  L1F13
         leas  $02,s
         leax  >$01B8,y
         pshs  x
         ldd   >$01B4,y
         pshs  b,a
         clra  
         clrb  
         pshs  b,a
         lbsr  L1E95
         leas  $06,s
         ldd   #$0001
         stb   >$01BC,y
         ldd   #$0003
         stb   >$01C8,y
         ldd   #$0005
         stb   >$01C9,y
         ldd   #$000D
         stb   >$01C3,y
         leax  >$01B8,y
         pshs  x
         ldd   >$01B4,y
         pshs  b,a
         clra  
         clrb  
         pshs  b,a
         lbsr  L1ED0
         leas  $06,s
         ldd   $0A,s
         pshs  b,a
         lbsr  L2127
         leas  $02,s
         bra   L022B
L0221    cmpx  #$000A
         lbeq  L018D
         lbra  L01C5
L022B    leas  $06,s
         puls  pc,u
L022F    pshs  u
         ldd   #$FFB5
         lbsr  L0111
         leas  -$01,s
         clra  
         clrb  
         std   >$01B4,y
         ldd   $05,s
         cmpd  #$0001
         bne   L0274
         ldd   #$0003
         pshs  b,a
         leax  >L0F04,pcr
         pshs  x
         lbsr  L1F04
         leas  $04,s
         std   >$01B6,y
         cmpd  #$FFFF
         bne   L02AA
         ldd   >$01B2,y
         pshs  b,a
         leax  >L0F08,pcr
         pshs  x
         lbsr  L0E44
         leas  $04,s
         bra   L02AA
L0274    ldd   #$0003
         pshs  b,a
         ldx   $09,s
         ldd   $02,x
         pshs  b,a
         lbsr  L1F04
         leas  $04,s
         std   >$01B6,y
         cmpd  #$FFFF
         bne   L02AA
         ldx   $07,s
         ldd   $02,x
         pshs  b,a
         leax  >L0F18,pcr
         pshs  x
         lbsr  L1440
         leas  $04,s
         ldd   >$01B2,y
         pshs  b,a
         lbsr  L2127
         leas  $02,s
L02AA    leax  >$01B8,y
         pshs  x
         ldd   >$01B4,y
         pshs  b,a
         clra  
         clrb  
         pshs  b,a
         lbsr  L1E95
         leas  $06,s
         clra  
         clrb  
         stb   >$01BC,y
         clra  
         clrb  
         stb   >$01C9,y
         clra  
         clrb  
         stb   >$01C8,y
         clra  
         clrb  
         stb   >$01C3,y
         leax  >$01B8,y
         pshs  x
         ldd   >$01B4,y
         pshs  b,a
         clra  
         clrb  
         pshs  b,a
         lbsr  L1ED0
         leas  $06,s
         leax  >$01B8,y
         pshs  x
         ldd   >$01B6,y
         pshs  b,a
         clra  
         clrb  
         pshs  b,a
         lbsr  L1E95
         leas  $06,s
         clra  
         clrb  
         stb   >$01B9,y
         clra  
         clrb  
         stb   >$01BA,y
         clra  
         clrb  
         stb   >$01BB,y
         clra  
         clrb  
         stb   >$01BC,y
         clra  
         clrb  
         stb   >$01BD,y
         clra  
         clrb  
         stb   >$01BE,y
         clra  
         clrb  
         stb   >$01BF,y
         clra  
         clrb  
         stb   >$01C0,y
         clra  
         clrb  
         stb   >$01C1,y
         clra  
         clrb  
         stb   >$01C2,y
         clra  
         clrb  
         stb   >$01C3,y
         clra  
         clrb  
         stb   >$01C4,y
         clra  
         clrb  
         stb   >$01C5,y
         clra  
         clrb  
         stb   >$01C6,y
         clra  
         clrb  
         stb   >$01C7,y
         clra  
         clrb  
         stb   >$01C8,y
         clra  
         clrb  
         stb   >$01C9,y
         clra  
         clrb  
         stb   >$01CA,y
         clra  
         clrb  
         stb   >$01CB,y
         clra  
         clrb  
         stb   >$01CC,y
         leax  >$01B8,y
         pshs  x
         ldd   >$01B6,y
         pshs  b,a
         clra  
         clrb  
         pshs  b,a
         lbsr  L1ED0
         leas  $06,s
         leax  >L017E,pcr
         pshs  x
         lbsr  L20F7
         leas  $02,s
         clra  
         clrb  
         pshs  b,a
         lbsr  L2184
         leas  $02,s
         clra  
         clrb  
         pshs  b,a
         lbsr  L2193
         leas  $02,s
         leax  >L0F28,pcr
         pshs  x
         lbsr  L1440
         leas  $02,s
         leax  >L0F48,pcr
         pshs  x
         lbsr  L1440
         leas  $02,s
         leax  >L0F68,pcr
         pshs  x
         lbsr  L1440
         leas  $02,s
         clra  
         clrb  
         pshs  b,a
         lbsr  L2198
         leas  $02,s
         leax  >L0F88,pcr
         pshs  x
         lbsr  L1440
         leas  $02,s
         leax  >L0F8A,pcr
         pshs  x
         lbsr  L1440
         leas  $02,s
         leax  >L0FC6,pcr
         pshs  x
         lbsr  L1440
         lbra  L0455
L03F7    ldd   #$000A
         pshs  b,a
         ldd   >$01B6,y
         pshs  b,a
         lbsr  L2140
         leas  $04,s
         ldd   >$01B4,y
         pshs  b,a
         lbsr  L2133
         leas  $02,s
         cmpd  #$FFFF
         beq   L044D
         ldd   #$0001
         pshs  b,a
         leax  $02,s
         pshs  x
         ldd   >$01B4,y
         pshs  b,a
         lbsr  L1F80
         leas  $06,s
         ldb   ,s
         sex   
         pshs  b,a
         bsr   L045A
         std   ,s++
         beq   L044B
         ldd   #$0001
         pshs  b,a
         leax  $02,s
         pshs  x
         ldd   >$01B6,y
         pshs  b,a
         lbsr  L1FB1
         leas  $06,s
L044B    bra   L03F7
L044D    ldd   #$0001
         pshs  b,a
         lbsr  L2067
L0455    leas  $02,s
         lbra  L03F7
L045A    pshs  u
         ldd   #$FFB6
         lbsr  L0111
         ldb   $05,s
         sex   
         tfr   d,x
         lbra  L051C
L046A    ldd   >$01B6,y
         pshs  b,a
         lbsr  L1F13
         leas  $02,s
         leax  >$01B8,y
         pshs  x
         ldd   >$01B4,y
         pshs  b,a
         clra  
         clrb  
         pshs  b,a
         lbsr  L1E95
         leas  $06,s
         ldd   #$0001
         stb   >$01BC,y
         ldd   #$0003
         stb   >$01C8,y
         ldd   #$0005
         stb   >$01C9,y
         ldd   #$000D
         stb   >$01C3,y
         leax  >$01B8,y
         pshs  x
         ldd   >$01B4,y
         pshs  b,a
         clra  
         clrb  
         pshs  b,a
         lbsr  L1ED0
         leas  $06,s
         clra  
         clrb  
         pshs  b,a
         lbsr  L2184
         leas  $02,s
         leax  >L1008,pcr
         pshs  x
         lbsr  L1440
         leas  $02,s
         leax  >L1020,pcr
         pshs  x
         lbsr  L1440
         leas  $02,s
         leax  >L1046,pcr
         pshs  x
         lbsr  L1440
         leas  $02,s
         leax  >L1064,pcr
         pshs  x
         lbsr  L1440
         leas  $02,s
         leax  >L1075,pcr
         pshs  x
         lbsr  L1440
         leas  $02,s
         leax  >L108B,pcr
         pshs  x
         lbsr  L1440
         leas  $02,s
         clra  
         clrb  
         pshs  b,a
         lbsr  L2127
         leas  $02,s
         bra   L052A
L0511    bsr   L052C
         clra  
         clrb  
         puls  pc,u
L0517    ldd   #$0001
         puls  pc,u
L051C    cmpx  #$FFF8
         lbeq  L046A
         cmpx  #$FFF4
         beq   L0511
         bra   L0517
L052A    puls  pc,u
L052C    pshs  u
         ldd   #$FFB5
         lbsr  L0111
         leas  -$01,s
         clra  
         clrb  
         pshs  b,a
         lbsr  L2184
         leas  $02,s
         leax  >L10B5,pcr
         pshs  x
         lbsr  L1440
         leas  $02,s
         leax  >$0020,y
         pshs  x
         lbsr  L1A6F
         leas  $02,s
         ldd   #$0001
         pshs  b,a
         leax  $02,s
         pshs  x
         clra  
         clrb  
         pshs  b,a
         lbsr  L1F80
         leas  $06,s
         leax  >L10D1,pcr
         pshs  x
         lbsr  L1440
         leas  $02,s
         ldb   ,s
         clra  
         andb  #$DF
         stb   ,s
         cmpb  #$52
         bne   L0580
         lbsr  L08FD
L0580    leax  >$01B8,y
         pshs  x
         ldd   >$01B6,y
         pshs  b,a
         clra  
         clrb  
         pshs  b,a
         lbsr  L1E95
         leas  $06,s
         ldd   #$1113
         std   >$01D0,y
         leax  >$01B8,y
         pshs  x
         ldd   >$01B6,y
         pshs  b,a
         clra  
         clrb  
         pshs  b,a
         lbsr  L1ED0
         leas  $06,s
         ldb   ,s
         cmpb  #$53
         bne   L05B9
         bsr   L05BD
L05B9    leas  $01,s
         puls  pc,u
L05BD    pshs  u
         ldd   #$FEE5
         lbsr  L0111
         leas  >-$00CF,s
         ldd   #$0001
         std   ,s
         ldd   >$01B6,y
         pshs  b,a
         lbsr  L214C
         leas  $02,s
         leax  >$01B8,y
         pshs  x
         ldd   >$01B4,y
         pshs  b,a
         clra  
         clrb  
         pshs  b,a
         lbsr  L1E95
         leas  $06,s
         ldd   #$0001
         stb   >$01BC,y
         ldd   #$000D
         stb   >$01C3,y
         leax  >$01B8,y
         pshs  x
         ldd   >$01B4,y
         pshs  b,a
         clra  
         clrb  
         pshs  b,a
         lbsr  L1ED0
         leas  $06,s
         leax  >L10D3,pcr
         pshs  x
         lbsr  L1440
         leas  $02,s
         leax  >$0013,y
         pshs  x
         ldd   #$00C8
         pshs  b,a
         leax  $0B,s
         pshs  x
         lbsr  L13F7
         leas  $06,s
         clra  
         clrb  
         stb   >$01BC,y
         clra  
         clrb  
         stb   >$01C3,y
         leax  >$01B8,y
         pshs  x
         ldd   >$01B4,y
         pshs  b,a
         clra  
         clrb  
         pshs  b,a
         lbsr  L1ED0
         leas  $06,s
         ldd   #$0001
         pshs  b,a
         leax  $09,s
         pshs  x
         lbsr  L1F04
         leas  $04,s
         std   $04,s
         cmpd  #$FFFF
         bne   L067B
         ldd   >$01B2,y
         pshs  b,a
         leax  >L10EB,pcr
         pshs  x
         lbsr  L1440
         leas  $04,s
         lbra  L0C6C
L067B    leax  >L1107,pcr
         pshs  x
         lbsr  L1440
         leas  $02,s
         leax  >L1140,pcr
         pshs  x
         lbsr  L1440
         leas  $02,s
         leax  >$01B8,y
         pshs  x
         ldd   >$01B4,y
         pshs  b,a
         clra  
         clrb  
         pshs  b,a
         lbsr  L1E95
         leas  $06,s
         clra  
         clrb  
         stb   >$01BD,y
         leax  >$01B8,y
         pshs  x
         ldd   >$01B4,y
         pshs  b,a
         clra  
         clrb  
         pshs  b,a
         lbsr  L1ED0
         leas  $06,s
         ldd   #$0001
         stb   >$01D8,y
         ldd   #$0001
         stb   >$01D9,y
         sex   
         coma  
         comb  
         stb   >$01DA,y
         ldd   #$0080
         pshs  b,a
         leax  >$01DB,y
         pshs  x
         ldd   $08,s
         pshs  b,a
         lbsr  L1F80
         leas  $06,s
         leax  >$01DB,y
         pshs  x
         lbsr  L0E0B
         leas  $02,s
         stb   >$025B,y
         ldd   ,s
         pshs  b,a
         leax  >L1182,pcr
         pshs  x
         lbsr  L1440
         leas  $04,s
         leax  >$0020,y
         pshs  x
         lbsr  L1A6F
         leas  $02,s
         lbra  L077A
L0716    clra  
         clrb  
         pshs  b,a
         lbsr  L0EC9
         leas  $02,s
         cmpd  #$FFF1
         bne   L077A
         leax  >$01B8,y
         pshs  x
         ldd   >$01B4,y
         pshs  b,a
         clra  
         clrb  
         pshs  b,a
         lbsr  L1E95
         leas  $06,s
         ldd   #$0001
         stb   >$01BD,y
         leax  >$01B8,y
         pshs  x
         ldd   >$01B4,y
         pshs  b,a
         clra  
         clrb  
         pshs  b,a
         lbsr  L1ED0
         leas  $06,s
         leax  >L1198,pcr
         pshs  x
         lbsr  L1440
         leas  $02,s
         ldd   #$0001
         pshs  b,a
         leax  >$0005,y
         pshs  x
         ldd   >$01B6,y
         pshs  b,a
         lbsr  L1FB1
         leas  $06,s
         lbra  L0C6C
L077A    leax  $06,s
         pshs  x
         ldd   #$0001
         pshs  b,a
         ldd   #$0001
         pshs  b,a
         ldd   >$01B6,y
         pshs  b,a
         lbsr  L0D73
         leas  $08,s
         cmpd  #$FFFF
         lbeq  L0716
         ldb   $06,s
         cmpb  #$15
         bne   L07B7
         ldd   #$0084
         pshs  b,a
         leax  >$01D8,y
         pshs  x
         ldd   >$01B6,y
         pshs  b,a
         lbsr  L1FB1
         leas  $06,s
L07B7    ldb   $06,s
         cmpb  #$18
         bne   L0803
         leax  >$01B8,y
         pshs  x
         ldd   >$01B4,y
         pshs  b,a
         clra  
         clrb  
         pshs  b,a
         lbsr  L1E95
         leas  $06,s
         ldd   #$0001
         stb   >$01BD,y
         leax  >$01B8,y
         pshs  x
         ldd   >$01B4,y
         pshs  b,a
         clra  
         clrb  
         pshs  b,a
         lbsr  L1ED0
         leas  $06,s
         leax  >L11B0,pcr
         pshs  x
         lbsr  L1440
         leas  $02,s
         ldd   $04,s
         pshs  b,a
         lbsr  L1F13
         lbra  L0C12
L0803    ldb   $06,s
         cmpb  #$06
         lbne  L077A
         ldb   >$01D9,y
         addd  #$0001
         stb   >$01D9,y
         sex   
         coma  
         comb  
         stb   >$01DA,y
         ldd   ,s
         addd  #$0001
         std   ,s
         clra  
         clrb  
         bra   L0839
L0828    ldd   $02,s
         leax  >$01DB,y
         leax  d,x
         clra  
         clrb  
         stb   ,x
         ldd   $02,s
         addd  #$0001
L0839    std   $02,s
         ldd   $02,s
         cmpd  #$007F
         ble   L0828
         ldd   #$0080
         pshs  b,a
         leax  >$01DB,y
         pshs  x
         ldd   $08,s
         pshs  b,a
         lbsr  L1F80
         leas  $06,s
         std   -$02,s
         lbne  L08BB
         ldd   #$0001
         pshs  b,a
         leax  >$0003,y
         pshs  x
         ldd   >$01B6,y
         pshs  b,a
         lbsr  L1FB1
         leas  $06,s
         leax  >$01B8,y
         pshs  x
         ldd   >$01B4,y
         pshs  b,a
         clra  
         clrb  
         pshs  b,a
         lbsr  L1E95
         leas  $06,s
         ldd   #$0001
         stb   >$01BD,y
         leax  >$01B8,y
         pshs  x
         ldd   >$01B4,y
         pshs  b,a
         clra  
         clrb  
         pshs  b,a
         lbsr  L1ED0
         leas  $06,s
         leax  >L11C8,pcr
         pshs  x
         lbsr  L1440
         leas  $02,s
         ldd   $04,s
         pshs  b,a
         lbsr  L1F13
         leas  $02,s
         lbra  L0B9A
L08BB    leax  >$01DB,y
         pshs  x
         lbsr  L0E0B
         leas  $02,s
         stb   >$025B,y
         ldd   ,s
         pshs  b,a
         leax  >L11E1,pcr
         pshs  x
         lbsr  L1440
         leas  $04,s
         leax  >$0020,y
         pshs  x
         lbsr  L1A6F
         leas  $02,s
         ldd   #$0084
         pshs  b,a
         leax  >$01D8,y
         pshs  x
         ldd   >$01B6,y
         pshs  b,a
         lbsr  L1FB1
         leas  $06,s
         lbra  L077A
L08FD    pshs  u
         ldd   #$FEE5
         lbsr  L0111
         leas  >-$00CF,s
         ldd   #$0001
         stb   $06,s
         ldd   #$0001
         std   $04,s
         ldd   >$01B6,y
         pshs  b,a
         lbsr  L214C
         leas  $02,s
         leax  >$01B8,y
         pshs  x
         ldd   >$01B6,y
         pshs  b,a
         clra  
         clrb  
         pshs  b,a
         lbsr  L1E95
         leas  $06,s
         clra  
         clrb  
         std   >$01D0,y
         leax  >$01B8,y
         pshs  x
         ldd   >$01B6,y
         pshs  b,a
         clra  
         clrb  
         pshs  b,a
         lbsr  L1ED0
         leas  $06,s
         leax  >$01B8,y
         pshs  x
         ldd   >$01B4,y
         pshs  b,a
         clra  
         clrb  
         pshs  b,a
         lbsr  L1E95
         leas  $06,s
         ldd   #$0001
         stb   >$01BC,y
         ldd   #$000D
         stb   >$01C3,y
         leax  >$01B8,y
         pshs  x
         ldd   >$01B4,y
         pshs  b,a
         clra  
         clrb  
         pshs  b,a
         lbsr  L1ED0
         leas  $06,s
         leax  >L11F7,pcr
         pshs  x
         lbsr  L1440
         leas  $02,s
         leax  >$0013,y
         pshs  x
         ldd   #$00C8
         pshs  b,a
         leax  $0B,s
         pshs  x
         lbsr  L13F7
         leas  $06,s
         clra  
         clrb  
         stb   >$01BC,y
         clra  
         clrb  
         stb   >$01C3,y
         leax  >$01B8,y
         pshs  x
         ldd   >$01B4,y
         pshs  b,a
         clra  
         clrb  
         pshs  b,a
         lbsr  L1ED0
         leas  $06,s
         ldd   #$0001
         pshs  b,a
         leax  $09,s
         pshs  x
         lbsr  L1EF5
         leas  $04,s
         cmpd  #$FFFF
         beq   L09E1
         leax  >L1212,pcr
         lbra  L0AC4
L09E1    ldd   #$0002
         pshs  b,a
         leax  $09,s
         pshs  x
         lbsr  L1F25
         leas  $04,s
         std   $02,s
         cmpd  #$FFFF
         bne   L0A0B
         ldd   >$01B2,y
         pshs  b,a
         leax  >L1220,pcr
         pshs  x
         lbsr  L1440
         leas  $04,s
         lbra  L0C6C
L0A0B    leax  >L123C,pcr
         pshs  x
         lbsr  L1440
         leas  $02,s
         leax  >L1275,pcr
         pshs  x
         lbsr  L1440
         leas  $02,s
         leax  >$01B8,y
         pshs  x
         ldd   >$01B4,y
         pshs  b,a
         clra  
         clrb  
         pshs  b,a
         lbsr  L1E95
         leas  $06,s
         clra  
         clrb  
         stb   >$01BD,y
         leax  >$01B8,y
         pshs  x
         ldd   >$01B4,y
         pshs  b,a
         clra  
         clrb  
         pshs  b,a
         lbsr  L1ED0
         leas  $06,s
         ldd   #$0001
         pshs  b,a
         leax  >$0004,y
         pshs  x
         ldd   >$01B6,y
         pshs  b,a
         lbsr  L1FB1
         leas  $06,s
         lbra  L0D6A
L0A6A    clra  
         clrb  
         pshs  b,a
         lbsr  L0EC9
         leas  $02,s
         cmpd  #$FFF1
         bne   L0ACC
         ldd   #$0001
         pshs  b,a
         leax  >$0005,y
         pshs  x
         ldd   >$01B6,y
         pshs  b,a
         lbsr  L1FB1
         leas  $06,s
         leax  >$01B8,y
         pshs  x
         ldd   >$01B4,y
         pshs  b,a
         clra  
         clrb  
         pshs  b,a
         lbsr  L1E95
         leas  $06,s
         ldd   #$0001
         stb   >$01BD,y
         leax  >$01B8,y
         pshs  x
         ldd   >$01B4,y
         pshs  b,a
         clra  
         clrb  
         pshs  b,a
         lbsr  L1ED0
         leas  $06,s
         leax  >L12B7,pcr
L0AC4    pshs  x
         lbsr  L1440
         lbra  L0C12
L0ACC    clra  
         clrb  
         stb   >$01D8,y
         clra  
         clrb  
         std   ,s
         ldd   $04,s
         pshs  b,a
         leax  >L12D0,pcr
         pshs  x
         lbsr  L1440
         leas  $04,s
         leax  >$0020,y
         pshs  x
         lbsr  L1A6F
         leas  $02,s
         lbra  L0C72
L0AF3    leax  >$01D8,y
         pshs  x
         ldd   #$000A
         pshs  b,a
         ldd   #$0001
         pshs  b,a
         ldd   >$01B6,y
         pshs  b,a
         lbsr  L0D73
         leas  $08,s
         cmpd  #$FFFF
         bne   L0B35
         leax  >L12E8,pcr
         pshs  x
         lbsr  L1440
         leas  $02,s
         ldd   #$0001
         pshs  b,a
         leax  >$0004,y
         pshs  x
         ldd   >$01B6,y
         pshs  b,a
         lbsr  L1FB1
         leas  $06,s
L0B35    ldb   >$01D8,y
         cmpb  #$04
         lbne  L0B9F
         ldd   #$0001
         pshs  b,a
         leax  >$0002,y
         pshs  x
         ldd   >$01B6,y
         pshs  b,a
         lbsr  L1FB1
         leas  $06,s
         leax  >$01B8,y
         pshs  x
         ldd   >$01B4,y
         pshs  b,a
         clra  
         clrb  
         pshs  b,a
         lbsr  L1E95
         leas  $06,s
         ldd   #$0001
         stb   >$01BD,y
         leax  >$01B8,y
         pshs  x
         ldd   >$01B4,y
         pshs  b,a
         clra  
         clrb  
         pshs  b,a
         lbsr  L1ED0
         leas  $06,s
         leax  >L12FC,pcr
         pshs  x
         lbsr  L1440
         leas  $02,s
         ldd   $02,s
         pshs  b,a
         lbsr  L1F13
         leas  $02,s
L0B9A    clra  
         clrb  
         lbra  L0D6D
L0B9F    ldd   ,s
         addd  #$0001
         std   ,s
         subd  #$0001
         cmpd  #$000A
         lble  L0C17
         leax  >$01B8,y
         pshs  x
         ldd   >$01B4,y
         pshs  b,a
         clra  
         clrb  
         pshs  b,a
         lbsr  L1E95
         leas  $06,s
         clra  
         clrb  
         stb   >$01BD,y
         leax  >$01B8,y
         pshs  x
         ldd   >$01B4,y
         pshs  b,a
         clra  
         clrb  
         pshs  b,a
         lbsr  L1ED0
         leas  $06,s
         leax  >L1316,pcr
         pshs  x
         lbsr  L1440
         leas  $02,s
         ldd   #$0001
         pshs  b,a
         leax  >$0005,y
         pshs  x
         ldd   >$01B6,y
         pshs  b,a
         lbsr  L1FB1
         leas  $06,s
         ldd   $02,s
         pshs  b,a
         lbsr  L1F13
         leas  $02,s
         leax  $07,s
         pshs  x
         lbsr  L1F6B
L0C12    leas  $02,s
         lbra  L0C6C
L0C17    ldb   >$01D8,y
         cmpb  #$18
         bne   L0C72
         leax  >L1334,pcr
         pshs  x
         lbsr  L1440
         leas  $02,s
         ldd   $02,s
         pshs  b,a
         lbsr  L1F13
         leas  $02,s
         leax  $07,s
         pshs  x
         lbsr  L1F6B
         leas  $02,s
         leax  >$01B8,y
         pshs  x
         ldd   >$01B4,y
         pshs  b,a
         clra  
         clrb  
         pshs  b,a
         lbsr  L1E95
         leas  $06,s
         clra  
         clrb  
         stb   >$01BD,y
         leax  >$01B8,y
         pshs  x
         ldd   >$01B4,y
         pshs  b,a
         clra  
         clrb  
         pshs  b,a
         lbsr  L1ED0
         leas  $06,s
L0C6C    ldd   #$FFFF
         lbra  L0D6D
L0C72    ldb   >$01D8,y
         cmpb  #$01
         lbne  L0AF3
         leax  >$01D9,y
         pshs  x
         ldd   #$0001
         pshs  b,a
         ldd   #$0083
         pshs  b,a
         ldd   >$01B6,y
         pshs  b,a
         lbsr  L0D73
         leas  $08,s
         cmpd  #$FFFF
         bne   L0CBA
         ldd   >$01B2,y
         pshs  b,a
         leax  >L134C,pcr
         pshs  x
         lbsr  L1440
         leas  $04,s
L0CAE    ldd   #$0001
         pshs  b,a
         leax  >$0004,y
         lbra  L0D5D
L0CBA    ldb   >$01D9,y
         sex   
         pshs  b,a
         ldb   >$01DA,y
         sex   
         coma  
         comb  
         cmpd  ,s++
         beq   L0CDA
         leax  >L1365,pcr
         pshs  x
         lbsr  L1440
         leas  $02,s
         bra   L0CAE
L0CDA    ldb   >$01D9,y
         sex   
         pshs  b,a
         ldb   $08,s
         sex   
         cmpd  ,s++
         beq   L0CF7
         leax  >L1379,pcr
         pshs  x
         lbsr  L1440
         leas  $02,s
         lbra  L0CAE
L0CF7    leax  >$01DB,y
         pshs  x
         lbsr  L0E0B
         leas  $02,s
         sex   
         pshs  b,a
         ldb   >$025B,y
         sex   
         cmpd  ,s++
         beq   L0D32
         ldb   >$025B,y
         sex   
         pshs  b,a
         leax  >$01DB,y
         pshs  x
         lbsr  L0E0B
         leas  $02,s
         sex   
         pshs  b,a
         leax  >L1387,pcr
         pshs  x
         lbsr  L1440
         leas  $06,s
         lbra  L0CAE
L0D32    ldd   #$0080
         pshs  b,a
         leax  >$01DB,y
         pshs  x
         ldd   $06,s
         pshs  b,a
         lbsr  L1FB1
         leas  $06,s
         ldb   $06,s
         addd  #$0001
         stb   $06,s
         ldd   $04,s
         addd  #$0001
         std   $04,s
         ldd   #$0001
         pshs  b,a
         leax  >$0002,y
L0D5D    pshs  x
         ldd   >$01B6,y
         pshs  b,a
         lbsr  L1FB1
         leas  $06,s
L0D6A    lbra  L0A6A
L0D6D    leas  >$00CF,s
         puls  pc,u
L0D73    pshs  u
         ldd   #$FFB2
         lbsr  L0111
         leas  -$04,s
         clra  
         clrb  
         std   ,s
         bra   L0D83
L0D83    ldd   $08,s
         pshs  b,a
         lbsr  L2133
         leas  $02,s
         std   $02,s
         cmpd  #$FFFF
         bne   L0DC7
         ldd   ,s
         addd  #$0001
         std   ,s
         subd  #$0001
         cmpd  #$003C
         ble   L0DBB
         clra  
         clrb  
         std   ,s
         ldd   $0C,s
         addd  #$FFFF
         std   $0C,s
         subd  #$FFFF
         bgt   L0DC5
         ldd   #$FFFF
         bra   L0E07
         bra   L0DC5
L0DBB    ldd   #$0001
         pshs  b,a
         lbsr  L2067
         leas  $02,s
L0DC5    bra   L0D83
L0DC7    ldd   $02,s
         cmpd  $0A,s
         bge   L0DF3
         ldd   $02,s
         pshs  b,a
         ldd   <$10,s
         pshs  b,a
         ldd   $0C,s
         pshs  b,a
         lbsr  L1F80
         leas  $06,s
         ldd   $0E,s
         addd  $02,s
         std   $0E,s
         ldd   $0A,s
         subd  $02,s
         std   $0A,s
         clra  
         clrb  
         std   ,s
         lbra  L0D83
L0DF3    ldd   $0A,s
         pshs  b,a
         ldd   <$10,s
         pshs  b,a
         ldd   >$01B6,y
         pshs  b,a
         lbsr  L1F80
         leas  $06,s
L0E07    leas  $04,s
         puls  pc,u
L0E0B    pshs  u
         ldd   #$FFBB
         lbsr  L0111
         leas  -$03,s
         clra  
         clrb  
         stb   $02,s
         clra  
         clrb  
         bra   L0E34
L0E1D    ldb   $02,s
         sex   
         pshs  b,a
         ldx   $09,s
         ldd   $02,s
         leax  d,x
         ldb   ,x
         sex   
         addd  ,s++
         stb   $02,s
         ldd   ,s
         addd  #$0001
L0E34    std   ,s
         ldd   ,s
         cmpd  #$007F
         ble   L0E1D
         ldb   $02,s
         leas  $03,s
         puls  pc,u
L0E44    pshs  u
         ldd   #$FFB6
         lbsr  L0111
         ldd   >$01B6,y
         pshs  b,a
         lbsr  L1F13
         leas  $02,s
         leax  >$01B8,y
         pshs  x
         ldd   >$01B4,y
         pshs  b,a
         clra  
         clrb  
         pshs  b,a
         lbsr  L1E95
         leas  $06,s
         ldd   #$0001
         stb   >$01BC,y
         ldd   #$0003
         stb   >$01C8,y
         ldd   #$0005
         stb   >$01C9,y
         ldd   #$000D
         stb   >$01C3,y
         leax  >$01B8,y
         pshs  x
         ldd   >$01B4,y
         pshs  b,a
         clra  
         clrb  
         pshs  b,a
         lbsr  L1ED0
         leas  $06,s
         clra  
         clrb  
         pshs  b,a
         lbsr  L2184
         leas  $02,s
         ldd   $04,s
         pshs  b,a
         leax  >L139E,pcr
         pshs  x
         lbsr  L1440
         leas  $04,s
         leax  >L13A2,pcr
         pshs  x
         lbsr  L1440
         leas  $02,s
         ldd   $06,s
         pshs  b,a
         lbsr  L2127
         bra   L0F00
L0EC9    pshs  u
         ldd   #$FFB4
         lbsr  L0111
         leas  -$02,s
         ldd   $06,s
         pshs  b,a
         ldd   #$0001
         pshs  b,a
         lbsr  L1E95
         leas  $04,s
         stb   $01,s
         bne   L0EF9
         ldd   #$0001
         pshs  b,a
         leax  $02,s
         pshs  x
         ldd   $0A,s
         pshs  b,a
         lbsr  L1F80
         leas  $06,s
         bra   L0EFD
L0EF9    clra  
         clrb  
         stb   ,s
L0EFD    ldb   ,s
         sex   
L0F00    leas  $02,s
         puls  pc,u
L0F04    ble   L0F7A
         leas  $00,x
L0F08    coma  
         oim   #$6E,$0E,s
         clr   -$0C,s
         bra   L0F7F
         neg   >$656E
         bra   L0F44
         lsr   >$3200
L0F18    coma  
         oim   #$6E,$0E,s
         clr   -$0C,s
         bra   L0F8F
         neg   >$656E
         bra   L0F4A
         com   >$0D00
L0F28    fcb   $51 Q
         eim   #$69,>$6B20
         lsr   >$6572
         tst   $09,s
         jmp   $01,s
         inc   $00,y
         rorb  
         eim   #$72,-$0D,s
         rol   $0F,s
         jmp   $00,y
         leay  $0E,y
         leax  -$10,y
         bra   L0F64
L0F44    bra   L0F66
         tst   <u0000
L0F48    fcb   $42 B
         rol   >$2041
         inc   -$10,s
         lsl   $01,s
         bra   L0FA5
         clr   $06,s
         lsr   >$7761
         aim   #$65,>$2054
         eim   #$63,$08,s
         jmp   $0F,s
         inc   $0F,s
         asr   $09,s
L0F64    eim   #$73,$0D,x
         neg   <u0052
         eim   #$6C,$05,s
         oim   #$73,$05,s
         lsr   $00,y
         ror   $0F,s
         aim   #$20,>$7368
         oim   #$72,$05,s
L0F7A    asr   >$6172
         eim   #$2C,$00,y
         leay  -$07,y
         fcb   $38 8
         fcb   $38 8
         bra   L0FA6
         tst   <u0000
L0F88    tst   <u0000
L0F8A    negb  
         aim   #$65,>$7373
L0F8F    bra   L0FCD
         fcb   $41 A
         inca  
         lsrb  
         fcb   $3E >
         cwai  #$58
         fcb   $3E >
         bra   L100E
         clr   $00,y
         eim   #$78,$09,s
         lsr   >$2020
         bra   L0FC4
         bra   L0FC6
L0FA6    bra   L0FC8
         bra   L0FCA
         cwai  #$41
         inca  
         lsrb  
         fcb   $3E >
         cwai  #$54
         fcb   $3E >
         bra   L1028
         clr   $00,y
         lsr   >$7261
         jmp   -$0D,s
         ror   $05,s
         aim   #$20,>$6669
         inc   $05,s
         com   >$0D00
L0FC6    blt   L0FF5
L0FC8    blt   L0FF7
L0FCA    blt   L0FF9
         blt   L0FFB
         blt   L0FFD
         blt   L0FFF
         blt   L1001
         blt   L1003
         blt   L1005
         blt   L1007
         blt   L1009
         blt   L100B
         blt   L100D
         blt   L100F
         blt   L1011
         blt   L1013
         blt   L1015
         blt   L1017
         blt   L1019
         blt   L101B
         blt   L101D
         blt   L101F
         blt   L1021
         blt   L1023
         blt   L1025
         blt   L1027
         blt   L1029
         blt   L102B
         blt   L102D
         blt   L102F
         blt   L1031
         blt   L1033
         tst   <u0000
L1008    fcb   $51 Q
L1009    eim   #$69,>$6B20
L100D    lsr   >$6572
         tst   $09,s
         jmp   $01,s
         inc   $0E,y
         bgt   L1046
         eim   #$78,$09,s
L101B    lsr   >$6564
         tst   <u0000
L1020    tst   <u0046
         clr   -$0E,s
         bra   L1087
         bra   L108E
L1028    aim   #$65,>$6520
         com   $01,s
         lsr   >$616C
L1031    clr   $07,s
L1033    bra   L10A5
         inc   $05,s
         oim   #$73,$05,s
         bra   L10B3
         aim   #$69,>$7465
         bra   L10B6
         clr   -$06,y
         tst   <u0000
L1046    tst   <u0041
         inc   -$10,s
         lsl   $01,s
         bra   L10A1
         clr   $06,s
         lsr   >$7761
         aim   #$65,>$2054
         eim   #$63,$08,s
         jmp   $0F,s
         inc   $0F,s
         asr   $09,s
         eim   #$73,$0D,x
         neg   <u0032
         fcb   $38 8
         leay  -$10,y
         bra   L10AC
         eim   #$66,>$666F
         jmp   $00,y
         comb  
         lsr   >$2E0D
         neg   <u0043
         lsl   $01,s
         inc   $0D,s
         eim   #$74,-$0C,s
         eim   #$2C,$00,y
         inca  
         oim   #$2E,$00,y
         pulu  y,x
         leax  -$0C,y
         leau  $0D,x
         neg   <u000D
         clr   -$0E,s
L108E    bra   L10FC
         eim   #$61,-$0A,s
         eim   #$20,$0D,s
         oim   #$69,$0C,s
         bra   L1101
         clr   -$0E,s
         bra   L10C6
         fcb   $41 A
         inca  
L10A1    negb  
         lsla  
         fcb   $41 A
         comb  
L10A5    clra  
         rora  
         lsrb  
         beq   L10CA
         clr   $0E,s
L10AC    bra   L10F2
         fcb   $45 E
         inca  
         negb  
         lsla  
         rola  
L10B3    tst   <u0000
L10B5    fcb   $5B [
L10B6    fcb   $52 R
         tstb  
         eim   #$63,$09,s
         eim   #$76,$05,s
         bra   L112F
         aim   #$20,>$5B53
         tstb  
         eim   #$6E,$04,s
         bra   L112B
L10CA    bra   L1132
         rol   $0C,s
         eim   #$3A,$00,x
L10D1    tst   <u0000
L10D3    fcb   $45 E
         jmp   -$0C,s
         eim   #$72,$00,y
         ror   $09,s
         inc   $05,s
         jmp   $01,s
         tst   $05,s
         bra   L1157
         clr   $00,y
         com   >$656E
         lsr   -$06,y
         neg   <u0043
         oim   #$6E,$0E,s
         clr   -$0C,s
         bra   L1162
         neg   >$656E
         bra   L115E
         rol   $0C,s
         eim   #$2C,$00,y
         eim   #$72,-$0E,s
         clr   -$0E,s
         bra   L1129
         lsr   $0D,x
         neg   <u0053
         eim   #$6E,$04,s
         rol   $0E,s
         asr   $00,y
         ror   $09,s
         inc   $05,s
         bra   L1135
         bra   L1137
         bra   L1139
         bra   L113B
         bra   L113D
         bra   L113F
         bra   L1141
         bra   L1143
         bra   L1145
         bra   L1147
         neg   >$7265
         com   >$7320
         cwai  #$41
L112F    inca  
         lsrb  
         fcb   $3E >
L1132    cwai  #$51
         fcb   $3E >
L1135    bra   L11AB
L1137    clr   $00,y
L1139    oim   #$62,$0F,s
         aim   #$74,>$0D00
L1140    blt   L116F
         blt   L1171
         blt   L1173
         blt   L1175
         blt   L1177
         blt   L1179
         blt   L117B
         blt   L117D
         blt   L117F
         blt   L1181
         blt   L1183
         blt   L1185
         blt   L1187
         blt   L1189
         blt   L118B
L115E    blt   L118D
         blt   L118F
L1162    blt   L1191
         blt   L1193
         blt   L1195
         blt   L1197
         blt   L1199
         blt   L119B
         blt   L119D
         blt   L119F
         blt   L11A1
         blt   L11A3
         blt   L11A5
         blt   L11A7
         blt   L11A9
         blt   L11AB
         blt   L11AD
         tst   <u0000
L1182    tst   <u0053
         eim   #$6E,$04,s
L1187    rol   $0E,s
L1189    asr   $00,y
L118B    aim   #$6C,$0F,s
         com   $0B,s
         bra   L11B5
         bcs   L11C4
         puls  u,y,x,b,cc
         bra   L1198
L1198    rora  
L1199    rol   $0C,s
L119B    eim   #$20,-$0C,s
         aim   #$61,>$6E73
         ror   $05,s
         aim   #$20,>$6162
         clr   -$0E,s
         lsr   >$6564
L11AD    brn   L11BC
         neg   <u0046
         rol   $0C,s
         eim   #$20,-$0C,s
         aim   #$61,>$6E73
         ror   $05,s
L11BC    aim   #$20,>$6162
         clr   -$0E,s
         lsr   >$6564
         brn   L11D4
         neg   <u0046
         rol   $0C,s
         eim   #$20,-$0C,s
         aim   #$61,>$6E73
         ror   $05,s
L11D4    aim   #$20,>$636F
         tst   -$10,s
         inc   $05,s
         lsr   >$652E
         tst   <u0000
L11E1    tst   <u0053
         eim   #$6E,$04,s
         rol   $0E,s
         asr   $00,y
         aim   #$6C,$0F,s
         com   $0B,s
         bra   L1214
         bcs   L1223
         puls  u,y,x,b,cc
         bra   L11F7
L11F7    fcb   $45 E
         jmp   -$0C,s
         eim   #$72,$00,y
         ror   $09,s
         inc   $05,s
         jmp   $01,s
         tst   $05,s
         bra   L127B
         clr   $00,y
         aim   #$65,>$6369
         eim   #$76,$05,s
         abx   
         neg   <u0046
         rol   $0C,s
         eim   #$20,$05,s
         lsl   >$6973
         lsr   >$7321
         tst   <u0000
L1220    coma  
         oim   #$6E,$0E,s
         clr   -$0C,s
         bra   L1297
         neg   >$656E
         bra   L1293
         rol   $0C,s
         eim   #$2C,$00,y
         eim   #$72,-$0E,s
         clr   -$0E,s
         bra   L125E
         lsr   $0D,x
         neg   <u0052
         eim   #$63,$09,s
         eim   #$76,$09,s
         jmp   $07,s
         bra   L12AD
         rol   $0C,s
         eim   #$20,$00,y
         bra   L126E
         bra   L1270
         bra   L1272
         bra   L1274
         bra   L1276
         bra   L1278
         bra   L127A
         bra   L127C
         neg   >$7265
         com   >$7320
         cwai  #$41
         inca  
         lsrb  
         fcb   $3E >
         cwai  #$51
         fcb   $3E >
         bra   L12E0
         clr   $00,y
L126E    oim   #$62,$0F,s
         aim   #$74,>$0D00
L1275    blt   L12A4
         blt   L12A6
         blt   L12A8
L127B    blt   L12AA
         blt   L12AC
         blt   L12AE
         blt   L12B0
         blt   L12B2
         blt   L12B4
         blt   L12B6
         blt   L12B8
         blt   L12BA
         blt   L12BC
         blt   L12BE
         blt   L12C0
L1293    blt   L12C2
         blt   L12C4
L1297    blt   L12C6
         blt   L12C8
         blt   L12CA
         blt   L12CC
         blt   L12CE
         blt   L12D0
         blt   L12D2
         blt   L12D4
         blt   L12D6
         blt   L12D8
         blt   L12DA
L12AD    blt   L12DC
         blt   L12DE
         blt   L12E0
         blt   L12E2
         tst   <u0000
L12B7    tst   <u0046
         rol   $0C,s
         eim   #$20,-$0C,s
L12BE    aim   #$61,>$6E73
L12C2    ror   $05,s
L12C4    aim   #$20,>$6162
L12C8    clr   -$0E,s
L12CA    lsr   >$6564
         brn   L12DC
         neg   <u000D
         fcb   $52 R
L12D2    eim   #$63,$09,s
         eim   #$76,$09,s
L12D8    jmp   $07,s
L12DA    bra   L133E
L12DC    inc   $0F,s
L12DE    com   $0B,s
L12E0    bra   L1305
L12E2    bcs   L1314
         puls  u,y,x,b,cc
         bra   L12E8
L12E8    lsrb  
         rol   $0D,s
         eim   #$6F,-$0B,s
         lsr   >$2F72
         eim   #$61,$04,s
         bra   L135B
         aim   #$72,>$6F72
         tst   <u0000
L12FC    rora  
         rol   $0C,s
         eim   #$20,-$0E,s
         eim   #$63,$05,s
L1305    rol   -$0A,s
         eim   #$20,-$0D,s
         eim   #$63,>$6365
         com   >$7366
         eim   #$6C,>$2E0D
         neg   <u0054
         clr   $0F,s
         bra   L1388
         oim   #$6E,-$07,s
         bra   L1385
         aim   #$72,>$6F72
         com   >$2E2E
         bgt   L1372
         bra   L1392
         rol   -$0A,s
         eim   #$20,-$0B,s
         neg   >$210D
         neg   <u0046
         rol   $0C,s
         eim   #$20,-$0C,s
         aim   #$61,>$6E73
L133E    ror   $05,s
         aim   #$20,>$6162
         clr   -$0E,s
         lsr   >$6564
         brn   L1358
         neg   <u0054
         rol   $0D,s
         eim   #$6F,-$0B,s
         lsr   >$2F72
         eim   #$61,$04,s
L1358    bra   L13BF
         aim   #$72,>$6F72
         bra   L1385
         lsr   $01,y
         brn   L1371
         neg   <u0042
         inc   $0F,s
         com   $0B,s
         bra   L138F
         bra   L13E1
         com   -$0E,s
         oim   #$6D,$02,s
         inc   $05,s
         lsr   $01,y
         tst   <u0000
L1379    fcb   $42 B
         oim   #$64,$00,y
         aim   #$6C,$0F,s
         com   $0B,s
         bra   L13A7
         brn   L1393
         neg   <u0042
L1388    oim   #$64,$00,y
         com   $08,s
         eim   #$63,$0B,s
         com   >$756D
L1393    brn   L13B5
         bcs   L13FB
         bra   L13C8
         bra   L13C0
         lsr   $0D,x
         neg   <u0025
         com   >$0D00
L13A2    comb  
         lsr   >$7570
         rol   $04,s
         bra   L141E
         eim   #$72,$0D,s
         rol   $0E,s
         oim   #$6C,$0E,y
         bgt   L13E2
         eim   #$78,$09,s
         lsr   >$6564
         tst   <u0000
         pshs  u,b,a
         ldu   $06,s
L13C0    bra   L13C6
L13C2    ldd   ,s
         stb   ,u+
L13C6    leax  >$0013,y
         pshs  x
         lbsr  L1B5F
         leas  $02,s
         std   ,s
         cmpd  #$000D
         beq   L13E1
         ldd   ,s
         cmpd  #$FFFF
         bne   L13C2
L13E1    ldd   ,s
         cmpd  #$FFFF
         bne   L13ED
         clra  
         clrb  
         bra   L13F3
L13ED    clra  
         clrb  
         stb   ,u
         ldd   $06,s
L13F3    leas  $02,s
         puls  pc,u
L13F7    pshs  u
         ldu   $06,s
L13FB    leas  -$04,s
         ldd   $08,s
         std   ,s
         bra   L1411
L1403    ldd   $02,s
         ldx   ,s
         leax  $01,x
         stx   ,s
         stb   -$01,x
         cmpb  #$0D
         beq   L142A
L1411    tfr   u,d
         leau  -u0001,u
         std   -$02,s
         ble   L142A
         ldd   $0C,s
         pshs  b,a
         lbsr  L1B5F
         leas  $02,s
         std   $02,s
         cmpd  #$FFFF
         bne   L1403
L142A    clra  
         clrb  
         stb   [,s]
         ldd   $02,s
         cmpd  #$FFFF
         bne   L143A
         clra  
         clrb  
         bra   L143C
L143A    ldd   $08,s
L143C    leas  $04,s
         puls  pc,u
L1440    pshs  u
         leax  >$0020,y
         stx   >$02DA,y
         leax  $06,s
         pshs  x
         ldd   $06,s
         bra   L1460
         pshs  u
         ldd   $04,s
         std   >$02DA,y
         leax  $08,s
         pshs  x
         ldd   $08,s
L1460    pshs  b,a
         leax  >L1918,pcr
         pshs  x
         bsr   L1492
         leas  $06,s
         puls  pc,u
         pshs  u
         ldd   $04,s
         std   >$02DA,y
         leax  $08,s
         pshs  x
         ldd   $08,s
         pshs  b,a
         leax  >L192B,pcr
         pshs  x
         bsr   L1492
         leas  $06,s
         clra  
         clrb  
         stb   [>$02DA,y]
         ldd   $04,s
         puls  pc,u
L1492    pshs  u
         ldu   $06,s
         leas  -$0B,s
         bra   L14AA
L149A    ldb   $08,s
         lbeq  L16DB
         ldb   $08,s
         sex   
         pshs  b,a
         jsr   [<$11,s]
         leas  $02,s
L14AA    ldb   ,u+
         stb   $08,s
         cmpb  #$25
         bne   L149A
         ldb   ,u+
         stb   $08,s
         clra  
         clrb  
         std   $02,s
         std   $06,s
         ldb   $08,s
         cmpb  #$2D
         bne   L14CF
         ldd   #$0001
         std   >$02F0,y
         ldb   ,u+
         stb   $08,s
         bra   L14D5
L14CF    clra  
         clrb  
         std   >$02F0,y
L14D5    ldb   $08,s
         cmpb  #$30
         bne   L14E0
         ldd   #$0030
         bra   L14E3
L14E0    ldd   #$0020
L14E3    std   >$02F2,y
         bra   L1503
L14E9    ldd   $06,s
         pshs  b,a
         ldd   #$000A
         lbsr  L1E13
         pshs  b,a
         ldb   $0A,s
         sex   
         addd  #$FFD0
         addd  ,s++
         std   $06,s
         ldb   ,u+
         stb   $08,s
L1503    ldb   $08,s
         sex   
         leax  >$00E4,y
         leax  d,x
         ldb   ,x
         clra  
         andb  #$08
         bne   L14E9
         ldb   $08,s
         cmpb  #$2E
         bne   L154C
         ldd   #$0001
         std   $04,s
         bra   L1536
L1520    ldd   $02,s
         pshs  b,a
         ldd   #$000A
         lbsr  L1E13
         pshs  b,a
         ldb   $0A,s
         sex   
         addd  #$FFD0
         addd  ,s++
         std   $02,s
L1536    ldb   ,u+
         stb   $08,s
         ldb   $08,s
         sex   
         leax  >$00E4,y
         leax  d,x
         ldb   ,x
         clra  
         andb  #$08
         bne   L1520
         bra   L1550
L154C    clra  
         clrb  
         std   $04,s
L1550    ldb   $08,s
         sex   
         tfr   d,x
         lbra  L167E
L1558    ldd   $06,s
         pshs  b,a
         ldx   <$15,s
         leax  $02,x
         stx   <$15,s
         ldd   -$02,x
         pshs  b,a
         lbsr  L16DF
         bra   L1580
L156D    ldd   $06,s
         pshs  b,a
         ldx   <$15,s
         leax  $02,x
         stx   <$15,s
         ldd   -$02,x
         pshs  b,a
         lbsr  L179C
L1580    std   ,s
         lbra  L1664
L1585    ldd   $06,s
         pshs  b,a
         ldb   $0A,s
         sex   
         leax  >$00E4,y
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
         lbsr  L17E4
         lbra  L1660
L15AB    ldd   $06,s
         pshs  b,a
         ldx   <$15,s
         leax  $02,x
         stx   <$15,s
         ldd   -$02,x
         pshs  b,a
         leax  >$02DC,y
         pshs  x
         lbsr  L1723
         lbra  L1660
L15C7    ldd   $04,s
         bne   L15D0
         ldd   #$0006
         std   $02,s
L15D0    ldd   $06,s
         pshs  b,a
         leax  <$15,s
         pshs  x
         ldd   $06,s
         pshs  b,a
         ldb   $0E,s
         sex   
         pshs  b,a
         lbsr  L1D81
         leas  $06,s
         lbra  L1662
L15EA    ldx   <$13,s
         leax  $02,x
         stx   <$13,s
         ldd   -$02,x
         lbra  L1674
L15F7    ldx   <$13,s
         leax  $02,x
         stx   <$13,s
         ldd   -$02,x
         std   $09,s
         ldd   $04,s
         beq   L163F
         ldd   $09,s
         std   $04,s
         bra   L1619
L160D    ldb   [<$09,s]
         beq   L1625
         ldd   $09,s
         addd  #$0001
         std   $09,s
L1619    ldd   $02,s
         addd  #$FFFF
         std   $02,s
         subd  #$FFFF
         bne   L160D
L1625    ldd   $06,s
         pshs  b,a
         ldd   $0B,s
         subd  $06,s
         pshs  b,a
         ldd   $08,s
         pshs  b,a
         ldd   <$15,s
         pshs  b,a
         lbsr  L184F
         leas  $08,s
         bra   L166E
L163F    ldd   $06,s
         pshs  b,a
         ldd   $0B,s
         bra   L1662
L1647    ldb   ,u+
         stb   $08,s
         bra   L164F
         leas  -$0B,x
L164F    ldd   $06,s
         pshs  b,a
         leax  <$15,s
         pshs  x
         ldb   $0C,s
         sex   
         pshs  b,a
         lbsr  L1D43
L1660    leas  $04,s
L1662    pshs  b,a
L1664    ldd   <$13,s
         pshs  b,a
         lbsr  L18B1
         leas  $06,s
L166E    lbra  L14AA
L1671    ldb   $08,s
         sex   
L1674    pshs  b,a
         jsr   [<$11,s]
         leas  $02,s
         lbra  L14AA
L167E    cmpx  #$0064
         lbeq  L1558
         cmpx  #$006F
         lbeq  L156D
         cmpx  #$0078
         lbeq  L1585
         cmpx  #$0058
         lbeq  L1585
         cmpx  #$0075
         lbeq  L15AB
         cmpx  #$0066
         lbeq  L15C7
         cmpx  #$0065
         lbeq  L15C7
         cmpx  #$0067
         lbeq  L15C7
         cmpx  #$0045
         lbeq  L15C7
         cmpx  #$0047
         lbeq  L15C7
         cmpx  #$0063
         lbeq  L15EA
         cmpx  #$0073
         lbeq  L15F7
         cmpx  #$006C
         lbeq  L1647
         bra   L1671
L16DB    leas  $0B,s
         puls  pc,u
L16DF    pshs  u,b,a
         leax  >$02DC,y
         stx   ,s
         ldd   $06,s
         bge   L1714
         ldd   $06,s
         nega  
         negb  
         sbca  #$00
         std   $06,s
         bge   L1709
         leax  >L193D,pcr
         pshs  x
         leax  >$02DC,y
         pshs  x
         lbsr  L1D9D
         leas  $04,s
         lbra  L17E0
L1709    ldd   #$002D
         ldx   ,s
         leax  $01,x
         stx   ,s
         stb   -$01,x
L1714    ldd   $06,s
         pshs  b,a
         ldd   $02,s
         pshs  b,a
         bsr   L1723
         leas  $04,s
         lbra  L17DA
L1723    pshs  u,y,x,b,a
         ldu   $0A,s
         clra  
         clrb  
         std   $02,s
         clra  
         clrb  
         std   ,s
         bra   L1740
L1731    ldd   ,s
         addd  #$0001
         std   ,s
         ldd   $0C,s
         subd  >$0006,y
         std   $0C,s
L1740    ldd   $0C,s
         blt   L1731
         leax  >$0006,y
         stx   $04,s
         bra   L1782
L174C    ldd   ,s
         addd  #$0001
         std   ,s
L1753    ldd   $0C,s
         subd  [<$04,s]
         std   $0C,s
         bge   L174C
         ldd   $0C,s
         addd  [<$04,s]
         std   $0C,s
         ldd   ,s
         beq   L176C
         ldd   #$0001
         std   $02,s
L176C    ldd   $02,s
         beq   L1777
         ldd   ,s
         addd  #$0030
         stb   ,u+
L1777    clra  
         clrb  
         std   ,s
         ldd   $04,s
         addd  #$0002
         std   $04,s
L1782    ldd   $04,s
         cmpd  >$000E,y
         bne   L1753
         ldd   $0C,s
         addd  #$0030
         stb   ,u+
         clra  
         clrb  
         stb   ,u
         ldd   $0A,s
         leas  $06,s
         puls  pc,u
L179C    pshs  u,b,a
         leax  >$02DC,y
         stx   ,s
         leau  >$02E6,y
L17A8    ldd   $06,s
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
         bne   L17A8
         bra   L17CA
L17C0    ldb   ,u
         ldx   ,s
         leax  $01,x
         stx   ,s
         stb   -$01,x
L17CA    leau  -u0001,u
         pshs  u
         leax  >$02E6,y
         cmpx  ,s++
         bls   L17C0
         clra  
         clrb  
         stb   [,s]
L17DA    leax  >$02DC,y
         tfr   x,d
L17E0    leas  $02,s
         puls  pc,u
L17E4    pshs  u,x,b,a
         leax  >$02DC,y
         stx   $02,s
         leau  >$02E6,y
L17F0    ldd   $08,s
         clra  
         andb  #$0F
         std   ,s
         pshs  b,a
         ldd   $02,s
         cmpd  #$0009
         ble   L1812
         ldd   $0C,s
         beq   L180A
         ldd   #$0041
         bra   L180D
L180A    ldd   #$0061
L180D    addd  #$FFF6
         bra   L1815
L1812    ldd   #$0030
L1815    addd  ,s++
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
         bne   L17F0
         bra   L1835
L182B    ldb   ,u
         ldx   $02,s
         leax  $01,x
         stx   $02,s
         stb   -$01,x
L1835    leau  -u0001,u
         pshs  u
         leax  >$02E6,y
         cmpx  ,s++
         bls   L182B
         clra  
         clrb  
         stb   [<$02,s]
         leax  >$02DC,y
         tfr   x,d
         lbra  L1927
L184F    pshs  u
         ldu   $06,s
         ldd   $0A,s
         subd  $08,s
         std   $0A,s
         ldd   >$02F0,y
         bne   L1884
         bra   L186C
L1861    ldd   >$02F2,y
         pshs  b,a
         jsr   [<$06,s]
         leas  $02,s
L186C    ldd   $0A,s
         addd  #$FFFF
         std   $0A,s
         subd  #$FFFF
         bgt   L1861
         bra   L1884
L187A    ldb   ,u+
         sex   
         pshs  b,a
         jsr   [<$06,s]
         leas  $02,s
L1884    ldd   $08,s
         addd  #$FFFF
         std   $08,s
         subd  #$FFFF
         bne   L187A
         ldd   >$02F0,y
         beq   L18AF
         bra   L18A3
L1898    ldd   >$02F2,y
         pshs  b,a
         jsr   [<$06,s]
         leas  $02,s
L18A3    ldd   $0A,s
         addd  #$FFFF
         std   $0A,s
         subd  #$FFFF
         bgt   L1898
L18AF    puls  pc,u
L18B1    pshs  u
         ldu   $06,s
         ldd   $08,s
         pshs  b,a
         pshs  u
         lbsr  L1D8C
         leas  $02,s
         nega  
         negb  
         sbca  #$00
         addd  ,s++
         std   $08,s
         ldd   >$02F0,y
         bne   L18F3
         bra   L18DB
L18D0    ldd   >$02F2,y
         pshs  b,a
         jsr   [<$06,s]
         leas  $02,s
L18DB    ldd   $08,s
         addd  #$FFFF
         std   $08,s
         subd  #$FFFF
         bgt   L18D0
         bra   L18F3
L18E9    ldb   ,u+
         sex   
         pshs  b,a
         jsr   [<$06,s]
         leas  $02,s
L18F3    ldb   ,u
         bne   L18E9
         ldd   >$02F0,y
         beq   L1916
         bra   L190A
L18FF    ldd   >$02F2,y
         pshs  b,a
         jsr   [<$06,s]
         leas  $02,s
L190A    ldd   $08,s
         addd  #$FFFF
         std   $08,s
         subd  #$FFFF
         bgt   L18FF
L1916    puls  pc,u
L1918    pshs  u
         ldd   >$02DA,y
         pshs  b,a
         ldd   $06,s
         pshs  b,a
         lbsr  L1944
L1927    leas  $04,s
         puls  pc,u
L192B    pshs  u
         ldd   $04,s
         ldx   >$02DA,y
         leax  $01,x
         stx   >$02DA,y
         stb   -$01,x
         puls  pc,u
L193D    blt   L1972
         leas  -$09,y
         pshu  y,x,dp
         neg   <u0034
         nega  
         ldu   $06,s
         ldd   u0006,u
         anda  #$80
         andb  #$22
         cmpd  #$8002
         beq   L1968
         ldd   u0006,u
         clra  
         andb  #$22
         cmpd  #$0002
         lbne  L1A80
         pshs  u
         lbsr  L1CB3
         leas  $02,s
L1968    ldd   u0006,u
         clra  
         andb  #$04
         beq   L19A4
         ldd   #$0001
L1972    pshs  b,a
         leax  $07,s
         pshs  x
         ldd   u0008,u
         pshs  b,a
         ldd   u0006,u
         clra  
         andb  #$40
         beq   L1989
         leax  >L1FCA,pcr
         bra   L198D
L1989    leax  >L1FB1,pcr
L198D    tfr   x,d
         tfr   d,x
         jsr   ,x
         leas  $06,s
         cmpd  #$FFFF
         bne   L19E5
         ldd   u0006,u
         orb   #$20
         std   u0006,u
         lbra  L1A80
L19A4    ldd   u0006,u
         anda  #$01
         clrb  
         std   -$02,s
         bne   L19B4
         pshs  u
         lbsr  L1A9D
         leas  $02,s
L19B4    ldd   ,u
         addd  #$0001
         std   ,u
         subd  #$0001
         tfr   d,x
         ldd   $04,s
         stb   ,x
         ldd   ,u
         cmpd  u0004,u
         bcc   L19DA
         ldd   u0006,u
         clra  
         andb  #$40
         beq   L19E5
         ldd   $04,s
         cmpd  #$000D
         bne   L19E5
L19DA    pshs  u
         lbsr  L1A9D
         std   ,s++
         lbne  L1A80
L19E5    ldd   $04,s
         puls  pc,u
         pshs  u
         ldu   $04,s
         ldd   $06,s
         pshs  b,a
         pshs  u
         ldd   #$0008
         lbsr  L1E72
         pshs  b,a
         lbsr  L1944
         leas  $04,s
         ldd   $06,s
         pshs  b,a
         pshs  u
         lbsr  L1944
         lbra  L1B57
L1A0C    pshs  u,b,a
         leau  >$0013,y
         clra  
         clrb  
         std   ,s
         bra   L1A22
L1A18    tfr   u,d
         leau  u000D,u
         pshs  b,a
         bsr   L1A35
         leas  $02,s
L1A22    ldd   ,s
         addd  #$0001
         std   ,s
         subd  #$0001
         cmpd  #$0010
         blt   L1A18
         lbra  L1A99
L1A35    pshs  u
         ldu   $04,s
         leas  -$02,s
         cmpu  #$0000
         beq   L1A45
         ldd   u0006,u
         bne   L1A4B
L1A45    ldd   #$FFFF
         lbra  L1A99
L1A4B    ldd   u0006,u
         clra  
         andb  #$02
         beq   L1A5A
         pshs  u
         bsr   L1A6F
         leas  $02,s
         bra   L1A5C
L1A5A    clra  
         clrb  
L1A5C    std   ,s
         ldd   u0008,u
         pshs  b,a
         lbsr  L1F13
         leas  $02,s
         clra  
         clrb  
         std   u0006,u
         ldd   ,s
         bra   L1A99
L1A6F    pshs  u
         ldu   $04,s
         beq   L1A80
         ldd   u0006,u
         clra  
         andb  #$22
         cmpd  #$0002
         beq   L1A85
L1A80    ldd   #$FFFF
         puls  pc,u
L1A85    ldd   u0006,u
         anda  #$80
         clrb  
         std   -$02,s
         bne   L1A95
         pshs  u
         lbsr  L1CB3
         leas  $02,s
L1A95    pshs  u
         bsr   L1A9D
L1A99    leas  $02,s
         puls  pc,u
L1A9D    pshs  u
         ldu   $04,s
         leas  -$04,s
         ldd   u0006,u
         anda  #$01
         clrb  
         std   -$02,s
         bne   L1ACF
         ldd   ,u
         cmpd  u0004,u
         beq   L1ACF
         clra  
         clrb  
         pshs  b,a
         pshs  u
         lbsr  L1B5B
         leas  $02,s
         ldd   $02,x
         pshs  b,a
         ldd   ,x
         pshs  b,a
         ldd   u0008,u
         pshs  b,a
         lbsr  L1FDA
         leas  $08,s
L1ACF    ldd   ,u
         subd  u0002,u
         std   $02,s
         lbeq  L1B47
         ldd   u0006,u
         anda  #$01
         clrb  
         std   -$02,s
         lbeq  L1B47
         ldd   u0006,u
         clra  
         andb  #$40
         beq   L1B1E
         ldd   u0002,u
         bra   L1B16
L1AEF    ldd   $02,s
         pshs  b,a
         ldd   ,u
         pshs  b,a
         ldd   u0008,u
         pshs  b,a
         lbsr  L1FCA
         leas  $06,s
         std   ,s
         cmpd  #$FFFF
         bne   L1B0C
         leax  $04,s
         bra   L1B36
L1B0C    ldd   $02,s
         subd  ,s
         std   $02,s
         ldd   ,u
         addd  ,s
L1B16    std   ,u
         ldd   $02,s
         bne   L1AEF
         bra   L1B47
L1B1E    ldd   $02,s
         pshs  b,a
         ldd   u0002,u
         pshs  b,a
         ldd   u0008,u
         pshs  b,a
         lbsr  L1FB1
         leas  $06,s
         cmpd  $02,s
         beq   L1B47
         bra   L1B38
L1B36    leas  -$04,x
L1B38    ldd   u0006,u
         orb   #$20
         std   u0006,u
         ldd   u0004,u
         std   ,u
         ldd   #$FFFF
         bra   L1B57
L1B47    ldd   u0006,u
         ora   #$01
         std   u0006,u
         ldd   u0002,u
         std   ,u
         addd  u000B,u
         std   u0004,u
         clra  
         clrb  
L1B57    leas  $04,s
         puls  pc,u
L1B5B    pshs  u
         puls  pc,u
L1B5F    pshs  u
         ldu   $04,s
         beq   L1BAB
         ldd   u0006,u
         anda  #$01
         clrb  
         std   -$02,s
         bne   L1BAB
         ldd   ,u
         cmpd  u0004,u
         bcc   L1B87
         ldd   ,u
         addd  #$0001
         std   ,u
         subd  #$0001
         tfr   d,x
         ldb   ,x
         clra  
         lbra  L1CB1
L1B87    pshs  u
         lbsr  L1BFA
         lbra  L1CAF
         pshs  u
         ldu   $06,s
         beq   L1BAB
         ldd   u0006,u
         clra  
         andb  #$01
         beq   L1BAB
         ldd   $04,s
         cmpd  #$FFFF
         beq   L1BAB
         ldd   ,u
         cmpd  u0002,u
         bhi   L1BB0
L1BAB    ldd   #$FFFF
         puls  pc,u
L1BB0    ldd   ,u
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
         lbsr  L1B5F
         leas  $02,s
         std   $02,s
         cmpd  #$FFFF
         beq   L1BE5
         pshs  u
         lbsr  L1B5F
         leas  $02,s
         std   ,s
         cmpd  #$FFFF
         bne   L1BEA
L1BE5    ldd   #$FFFF
         bra   L1BF6
L1BEA    ldd   $02,s
         pshs  b,a
         ldd   #$0008
         lbsr  L1E89
         addd  ,s
L1BF6    leas  $04,s
         puls  pc,u
L1BFA    pshs  u
         ldu   $04,s
         leas  -$02,s
         ldd   u0006,u
         anda  #$80
         andb  #$31
         cmpd  #$8001
         beq   L1C20
         ldd   u0006,u
         clra  
         andb  #$31
         cmpd  #$0001
         lbne  L1C99
         pshs  u
         lbsr  L1CB3
         leas  $02,s
L1C20    leax  >$0013,y
         pshs  x
         cmpu  ,s++
         bne   L1C3D
         ldd   u0006,u
         clra  
         andb  #$40
         beq   L1C3D
         leax  >$0020,y
         pshs  x
         lbsr  L1A6F
         leas  $02,s
L1C3D    ldd   u0006,u
         clra  
         andb  #$08
         beq   L1C69
         ldd   u000B,u
         pshs  b,a
         ldd   u0002,u
         pshs  b,a
         ldd   u0008,u
         pshs  b,a
         ldd   u0006,u
         clra  
         andb  #$40
         beq   L1C5D
         leax  >L1FA1,pcr
         bra   L1C61
L1C5D    leax  >L1F80,pcr
L1C61    tfr   x,d
         tfr   d,x
         jsr   ,x
         bra   L1C7B
L1C69    ldd   #$0001
         pshs  b,a
         leax  u000A,u
         stx   u0002,u
         pshs  x
         ldd   u0008,u
         pshs  b,a
         lbsr  L1F80
L1C7B    leas  $06,s
         std   ,s
         ldd   ,s
         bgt   L1C9E
         ldd   u0006,u
         pshs  b,a
         ldd   $02,s
         beq   L1C90
         ldd   #$0020
         bra   L1C93
L1C90    ldd   #$0010
L1C93    ora   ,s+
         orb   ,s+
         std   u0006,u
L1C99    ldd   #$FFFF
         bra   L1CAF
L1C9E    ldd   u0002,u
         addd  #$0001
         std   ,u
         ldd   u0002,u
         addd  ,s
         std   u0004,u
         ldb   [<u0002,u]
         clra  
L1CAF    leas  $02,s
L1CB1    puls  pc,u
L1CB3    pshs  u
         ldu   $04,s
         ldd   u0006,u
         clra  
         andb  #$C0
         bne   L1CEB
         leas  <-$20,s
         leax  ,s
         pshs  x
         ldd   u0008,u
         pshs  b,a
         clra  
         clrb  
         pshs  b,a
         lbsr  L1E95
         leas  $06,s
         ldd   u0006,u
         pshs  b,a
         ldb   $02,s
         bne   L1CDF
         ldd   #$0040
         bra   L1CE2
L1CDF    ldd   #$0080
L1CE2    ora   ,s+
         orb   ,s+
         std   u0006,u
         leas  <$20,s
L1CEB    ldd   u0006,u
         ora   #$80
         std   u0006,u
         clra  
         andb  #$0C
         beq   L1CF8
         puls  pc,u
L1CF8    ldd   u000B,u
         bne   L1D0D
         ldd   u0006,u
         clra  
         andb  #$40
         beq   L1D08
         ldd   #$0080
         bra   L1D0B
L1D08    ldd   #$0100
L1D0B    std   u000B,u
L1D0D    ldd   u0002,u
         bne   L1D22
         ldd   u000B,u
         pshs  b,a
         lbsr  L20CA
         leas  $02,s
         std   u0002,u
         cmpd  #$FFFF
         beq   L1D2A
L1D22    ldd   u0006,u
         orb   #$08
         std   u0006,u
         bra   L1D39
L1D2A    ldd   u0006,u
         orb   #$04
         std   u0006,u
         leax  u000A,u
         stx   u0002,u
         ldd   #$0001
         std   u000B,u
L1D39    ldd   u0002,u
         addd  u000B,u
         std   u0004,u
         std   ,u
         puls  pc,u
L1D43    pshs  u
         ldb   $05,s
         sex   
         tfr   d,x
         bra   L1D69
L1D4C    ldd   [<$06,s]
         addd  #$0004
         std   [<$06,s]
         leax  >L1D80,pcr
         bra   L1D65
L1D5B    ldb   $05,s
         stb   >$0011,y
         leax  >$0010,y
L1D65    tfr   x,d
         puls  pc,u
L1D69    cmpx  #$0064
         beq   L1D4C
         cmpx  #$006F
         lbeq  L1D4C
         cmpx  #$0078
         lbeq  L1D4C
         bra   L1D5B
         puls  pc,u
L1D80    neg   <u0034
         nega  
         leax  >L1D8B,pcr
         tfr   x,d
         puls  pc,u
L1D8B    neg   <u0034
         nega  
         ldu   $04,s
L1D90    ldb   ,u+
         bne   L1D90
         tfr   u,d
         subd  $04,s
         addd  #$FFFF
         puls  pc,u
L1D9D    pshs  u
         ldu   $06,s
         leas  -$02,s
         ldd   $06,s
         std   ,s
L1DA7    ldb   ,u+
         ldx   ,s
         leax  $01,x
         stx   ,s
         stb   -$01,x
         bne   L1DA7
         bra   L1DDC
         pshs  u
         ldu   $06,s
         leas  -$02,s
         ldd   $06,s
         std   ,s
L1DBF    ldx   ,s
         leax  $01,x
         stx   ,s
         ldb   -$01,x
         bne   L1DBF
         ldd   ,s
         addd  #$FFFF
         std   ,s
L1DD0    ldb   ,u+
         ldx   ,s
         leax  $01,x
         stx   ,s
         stb   -$01,x
         bne   L1DD0
L1DDC    ldd   $06,s
         leas  $02,s
         puls  pc,u
         pshs  u
         ldu   $04,s
         bra   L1DF8
L1DE8    ldx   $06,s
         leax  $01,x
         stx   $06,s
         ldb   -$01,x
         bne   L1DF6
         clra  
         clrb  
         puls  pc,u
L1DF6    leau  u0001,u
L1DF8    ldb   ,u
         sex   
         pshs  b,a
         ldb   [<$08,s]
         sex   
         cmpd  ,s++
         beq   L1DE8
         ldb   [<$06,s]
         sex   
         pshs  b,a
         ldb   ,u
         sex   
         subd  ,s++
         puls  pc,u
L1E13    tsta  
         bne   L1E28
         tst   $02,s
         bne   L1E28
         lda   $03,s
         mul   
         ldx   ,s
         stx   $02,s
         ldx   #$0000
         std   ,s
         puls  pc,b,a
L1E28    pshs  b,a
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
         bcc   L1E45
         inc   ,s
L1E45    lda   $04,s
         ldb   $09,s
         mul   
         addd  $01,s
         std   $01,s
         bcc   L1E52
         inc   ,s
L1E52    lda   $04,s
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
         beq   L1E7C
L1E69    asr   $02,s
         ror   $03,s
         decb  
         bne   L1E69
         bra   L1E7C
L1E72    tstb  
         beq   L1E7C
L1E75    lsr   $02,s
         ror   $03,s
         decb  
         bne   L1E75
L1E7C    ldd   $02,s
         pshs  b,a
         ldd   $02,s
         std   $04,s
         ldd   ,s
         leas  $04,s
         rts   
L1E89    tstb  
         beq   L1E7C
L1E8C    lsl   $03,s
         rol   $02,s
         decb  
         bne   L1E8C
         bra   L1E7C
L1E95    lda   $05,s
         ldb   $03,s
         beq   L1EC8
         cmpb  #$01
         beq   L1ECA
         cmpb  #$06
         beq   L1ECA
         cmpb  #$02
         beq   L1EB0
         cmpb  #$05
         beq   L1EB0
         ldb   #$D0
         lbra  L2119
L1EB0    pshs  u
         os9   I$GetStt 
         bcc   L1EBC
         puls  u
         lbra  L2119
L1EBC    stx   [<$08,s]
         ldx   $08,s
         stu   $02,x
         puls  u
         clra  
         clrb  
         rts   
L1EC8    ldx   $06,s
L1ECA    os9   I$GetStt 
         lbra  L2122
L1ED0    lda   $05,s
         ldb   $03,s
         beq   L1EDF
         cmpb  #$02
         beq   L1EE7
         ldb   #$D0
         lbra  L2119
L1EDF    ldx   $06,s
         os9   I$SetStt 
         lbra  L2122
L1EE7    pshs  u
         ldx   $08,s
         ldu   $0A,s
         os9   I$SetStt 
         puls  u
         lbra  L2122
L1EF5    ldx   $02,s
         lda   $05,s
         os9   I$Open   
         bcs   L1F01
         os9   I$Close  
L1F01    lbra  L2122
L1F04    ldx   $02,s
         lda   $05,s
         os9   I$Open   
         lbcs  L2119
         tfr   a,b
         clra  
         rts   
L1F13    lda   $03,s
         os9   I$Close  
         lbra  L2122
         ldx   $02,s
         ldb   $05,s
         os9   I$MakDir 
         lbra  L2122
L1F25    ldx   $02,s
         lda   $05,s
         tfr   a,b
         andb  #$24
         orb   #$0B
         os9   I$Create 
         bcs   L1F38
L1F34    tfr   a,b
         clra  
         rts   
L1F38    cmpb  #$DA
         lbne  L2119
         lda   $05,s
         bita  #$80
         lbne  L2119
         anda  #$07
         ldx   $02,s
         os9   I$Open   
         lbcs  L2119
         pshs  u,a
         ldx   #$0000
         leau  ,x
         ldb   #$02
         os9   I$SetStt 
         puls  u,a
         bcc   L1F34
         pshs  b
         os9   I$Close  
         puls  b
         lbra  L2119
L1F6B    ldx   $02,s
         os9   I$Delete 
         lbra  L2122
         lda   $03,s
         os9   I$Dup    
         lbcs  L2119
         tfr   a,b
         clra  
         rts   
L1F80    pshs  y
         ldx   $06,s
         lda   $05,s
         ldy   $08,s
         pshs  y
         os9   I$Read   
L1F8E    bcc   L1F9D
         cmpb  #$D3
         bne   L1F98
         clra  
         clrb  
         puls  pc,y,x
L1F98    puls  y,x
         lbra  L2119
L1F9D    tfr   y,d
         puls  pc,y,x
L1FA1    pshs  y
         lda   $05,s
         ldx   $06,s
         ldy   $08,s
         pshs  y
         os9   I$ReadLn 
         bra   L1F8E
L1FB1    pshs  y
         ldy   $08,s
         beq   L1FC6
         lda   $05,s
         ldx   $06,s
         os9   I$Write  
L1FBF    bcc   L1FC6
         puls  y
         lbra  L2119
L1FC6    tfr   y,d
         puls  pc,y
L1FCA    pshs  y
         ldy   $08,s
         beq   L1FC6
         lda   $05,s
         ldx   $06,s
         os9   I$WritLn 
         bra   L1FBF
L1FDA    pshs  u
         ldd   $0A,s
         bne   L1FE8
         ldu   #$0000
         ldx   #$0000
         bra   L201C
L1FE8    cmpd  #$0001
         beq   L2013
         cmpd  #$0002
         beq   L2008
         ldb   #$F7
L1FF6    clra  
         std   >$01B2,y
         ldd   #$FFFF
         leax  >$01A6,y
         std   ,x
         std   $02,x
         puls  pc,u
L2008    lda   $05,s
         ldb   #$02
         os9   I$GetStt 
         bcs   L1FF6
         bra   L201C
L2013    lda   $05,s
         ldb   #$05
         os9   I$GetStt 
         bcs   L1FF6
L201C    tfr   u,d
         addd  $08,s
         std   >$01A8,y
         tfr   d,u
         tfr   x,d
         adcb  $07,s
         adca  $06,s
         bmi   L1FF6
         tfr   d,x
         std   >$01A6,y
         lda   $05,s
         os9   I$Seek   
         bcs   L1FF6
         leax  >$01A6,y
         puls  pc,u
         rts   
         ldx   #$0000
         clrb  
         os9   F$Sleep  
         lbra  L2119
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
         lbcs  L2119
         rts   
L2067    ldx   $02,s
         os9   F$Sleep  
         lbcs  L2119
         tfr   x,d
         rts   
         ldd   >$01A4,y
         pshs  b,a
         ldd   $04,s
         cmpd  >$02F4,y
         bcs   L20A7
         addd  >$01A4,y
         pshs  y
         subd  ,s
         os9   F$Mem    
         tfr   y,d
         puls  y
         bcc   L2099
         ldd   #$FFFF
         leas  $02,s
         rts   
L2099    std   >$01A4,y
         addd  >$02F4,y
         subd  ,s
         std   >$02F4,y
L20A7    leas  $02,s
         ldd   >$02F4,y
         pshs  b,a
         subd  $04,s
         std   >$02F4,y
         ldd   >$01A4,y
         subd  ,s++
         pshs  b,a
         clra  
         ldx   ,s
L20C0    sta   ,x+
         cmpx  >$01A4,y
         bcs   L20C0
         puls  pc,b,a
L20CA    ldd   $02,s
         addd  >$01AE,y
         bcs   L20F3
         cmpd  >$01B0,y
         bcc   L20F3
         pshs  b,a
         ldx   >$01AE,y
         clra  
L20E0    cmpx  ,s
         bcc   L20E8
         sta   ,x+
         bra   L20E0
L20E8    ldd   >$01AE,y
         puls  x
         stx   >$01AE,y
         rts   
L20F3    ldd   #$FFFF
         rts   
L20F7    pshs  u
         tfr   y,u
         ldx   $04,s
         stx   >$02F6,y
         leax  >L210D,pcr
         os9   F$Icpt   
         puls  u
         lbra  L2122
L210D    tfr   u,y
         clra  
         pshs  b,a
         jsr   [>$02F6,y]
         leas  $02,s
         rti   
L2119    clra  
         std   >$01B2,y
         ldd   #$FFFF
         rts   
L2122    bcs   L2119
         clra  
         clrb  
         rts   
L2127    lbsr  L2132
         lbsr  L1A0C
L212D    ldd   $02,s
         os9   F$Exit   
L2132    rts   
L2133    lda   $03,s
         ldb   #$01
         os9   I$GetStt 
         lbcs  L2119
         clra  
         rts   
L2140    lda   $03,s
         ldb   #$1A
         ldx   $04,s
         os9   I$SetStt 
         lbra  L2122
L214C    lda   $03,s
         ldb   #$1B
         os9   I$SetStt 
         lbra  L2122
         ldb   #$01
         bra   L218A
         ldb   #$03
         bra   L218A
         ldb   #$04
         bra   L218A
         ldd   #$0520
         bra   L21B9
         ldd   #$0521
         bra   L21B9
         ldb   #$06
         bra   L218A
         ldb   #$07
         bra   L218A
         ldb   #$08
         bra   L218A
         ldb   #$09
         bra   L218A
         ldb   #$0A
         bra   L218A
         ldb   #$0B
         bra   L218A
L2184    ldb   #$0C
         bra   L218A
         ldb   #$0D
L218A    stb   >$02F8,y
         ldb   #$01
         lbra  L21C2
L2193    ldd   #$1F20
         bra   L21B9
L2198    ldd   #$1F21
         bra   L21B9
         ldd   #$1F22
         bra   L21B9
         ldd   #$1F23
         bra   L21B9
         ldd   #$1F24
         bra   L21B9
         ldd   #$1F25
         bra   L21B9
         ldd   #$1F30
         bra   L21B9
         ldd   #$1F31
L21B9    std   >$02F8,y
         ldb   #$02
         lbra  L21C2
L21C2    clra  
         leax  >$02F8,y
         pshs  y
         tfr   d,y
         lda   $05,s
         os9   I$Write  
         puls  y
         bcs   L21D7
         clra  
         clrb  
         rts   
L21D7    clra  
         std   >$01B2,y
         ldd   #$FFFF
         rts   
L21E0    neg   <u0001
         neg   <u0001
         com   $01,x
         ror   <u0004
         fcb   $15 
         fcb   $18 
         beq   L21FC
         com   <u00E8
         neg   <u0064
         neg   <u000A
         neg   <u000E
         inc   -$08,s
         neg   <u0000
         neg   <u0000
         neg   <u0000
L21FC    neg   <u0000
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
         bra   L230C
         bra   L230E
         bra   L2310
         bra   L2312
         bra   L2314
         bra   L2316
         bra   L2318
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
         bra   L2324
         bra   L2326
         bra   L2328
         bra   L234C
         fcb   $42 B
         fcb   $42 B
L230C    fcb   $42 B
         fcb   $42 B
L230E    fcb   $42 B
         aim   #$02,<u0002
L2312    aim   #$02,<u0002
         aim   #$02,<u0002
L2318    aim   #$02,<u0002
         aim   #$02,<u0002
         aim   #$02,<u0002
         aim   #$02,<u0020
L2324    bra   L2346
L2326    bra   L2348
L2328    bra   L236E
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
         bra   L2365
         bra   L2367
         oim   #$00,<u0000
         neg   <u0001
L234C    neg   <u000E
         lsrb  
         eim   #$72,$0D,s
         rol   $0E,s
         oim   #$6C,$00,x
         emod
eom      equ   *
         end
