         nam   Raaka-Tu
         ttl   program module       

* Disassembled 2004/07/13 07:31:17 by Disasm v1.5 (C) 1988 by RML

         ifp1
         use   os9defs
         endc

tylg     set   Prgrm+Objct   
atrv     set   ReEnt+rev
rev      set   $00

BaseOff  equ     $00 $C000+$16-$600

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
u000F    rmb   1
u0010    rmb   1
u0011    rmb   1
u0012    rmb   1
u0013    rmb   1
u0014    rmb   1
u0015    rmb   1
u0016    rmb   1
u0017    rmb   1
u0018    rmb   1
u0019    rmb   1
u001A    rmb   1
u001B    rmb   1
u001C    rmb   1
u001D    rmb   1
u001E    rmb   1
u001F    rmb   1
u0020    rmb   1
u0021    rmb   1
u0022    rmb   1
u0023    rmb   1
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
u0030    rmb   2
u0032    rmb   1
u0033    rmb   1
u0034    rmb   1
u0035    rmb   1
u0036    rmb   1
u0037    rmb   1
u0038    rmb   1
u0039    rmb   1
u003A    rmb   1
u003B    rmb   1
u003C    rmb   2
u003E    rmb   1
u003F    rmb   1
u0040    rmb   1
u0041    rmb   1
u0042    rmb   1
u0043    rmb   1
u0044    rmb   1
u0045    rmb   1
u0046    rmb   1
u0047    rmb   2
u0049    rmb   2
u004B    rmb   1
u004C    rmb   1
u004D    rmb   1
u004E    rmb   1
u004F    rmb   1
u0050    rmb   1
u0051    rmb   1
u0052    rmb   1
u0053    rmb   1
u0054    rmb   1
u0055    rmb   1
u0056    rmb   1
u0057    rmb   1
u0058    rmb   1
u0059    rmb   1
u005A    rmb   1
u005B    rmb   1
u005C    rmb   3
u005F    rmb   1
u0060    rmb   1
u0061    rmb   1
u0062    rmb   1
u0063    rmb   1
u0064    rmb   2
u0066    rmb   1
u0067    rmb   1
u0068    rmb   1
u0069    rmb   1
u006A    rmb   1
u006B    rmb   1
u006C    rmb   2
u006E    rmb   1
u006F    rmb   1
u0070    rmb   1
u0071    rmb   1
u0072    rmb   1
u0073    rmb   3
u0076    rmb   1
u0077    rmb   1
u0078    rmb   1
u0079    rmb   1
u007A    rmb   1
u007B    rmb   3
u007E    rmb   2
u0080    rmb   1
u0081    rmb   1
u0082    rmb   1
u0083    rmb   1
u0084    rmb   1
u0085    rmb   1
u0086    rmb   1
u0087    rmb   1
u0088    rmb   1
u0089    rmb   1
u008A    rmb   1
u008B    rmb   1
u008C    rmb   1
u008D    rmb   2
u008F    rmb   1
u0090    rmb   1
         rmb   $8000-.
size     equ   .

name     equ   *
         fcs   /Raaka-Tu/
         fcb   $04 

start    equ   *
         ldx   #$600
         leay  realstart,pcr
         ldd   #realsize
copyloop ldu   ,y++
         stu   ,x++
         subd  #$0002
         bgt   copyloop
         jmp   >$0600 

realstart
* Clear screen at $400
         clra  
         ldx   #$0400
         ldu   #$6060
L0019    stu   ,x++
         deca  
         bne   L0019
* Set up stack at #$03FF
         lds   #$03FF
         lda   #$1D
         sta   >$01D2
         ldx   #$05E0
         stx   <u0088
         ldb   #$96
         stb   >$01D5
         ldx   #$1523+BaseOff
         lbsr  X1
         stx   >$01D6
         lbsr  X2
         lda   #$0D
         lbsr  X3
         lds   #$03FF
         lbsr  L04DE >$0ACC+BaseOff
         clr   >$01B7
         clr   >$01BA
         clr   >$01BB
         clr   >$01B2
         clr   >$01B3
         clr   >$01B9
         clr   >$01B8
         clr   >$01B4
         clr   >$01B5
         clr   >$01BF
         clr   >$01C3
         clr   >$01C9
         ldb   #$1D
         stb   >$01D2
         lbsr  X4
         stx   >$01D3
         lbsr  L0454
         ldb   ,x
         stb   >$01D5
         ldx   #$1523+BaseOff
         lbsr  X1
         stx   >$01D6
         ldx   #$01E3
         stx   >$01D8
         clr   ,x
         ldx   #$05E0
L0094    lbsr  L0554 >$0B42+BaseOff
         beq   L00A4
L0099    lda   ,x+
         cmpa  #$60
         beq   L0094
         cmpx  #$0600
         bne   L0099
L00A4    cmpx  #$0600
         bne   L0094
         clr   [>$01D8]
         ldx   #$01E3
         lda   ,x
         lbeq  L0148
         cmpa  #$02
         bne   L00C9
         leax  $01,x
         lda   ,x
         leax  -$01,x
         cmpa  #$06
         bcc   L00C9
         sta   >$01B8
         leax  $03,x
L00C9    lda   ,x+
         beq   L0148
         ldb   ,x
         ldu   ,x++
         pshs  x
         deca  
         bne   L00F7
         ldx   #$1332+BaseOff
         lbsr  X1
         bcc   L00F1
         lbsr  L0454
L00E1    lbsr  X5
         tfr   b,a
         bcc   L00F1
         ldb   ,x+
         lda   ,x+
         cmpb  >$01B3
         bne   L00E1
L00F1    stb   >$01B3
         jmp   >$0731+BaseOff
L00F7    deca  
         bne   L0130
         tst   >$01B5
         beq   L011F
         ldx   #$01C9
L0102    stb   ,x+
         lda   >$01B7
         sta   ,x+
         lda   >$01BA
         sta   ,x
         bne   L0114
         tfr   u,d
         stb   ,x
L0114    clr   >$01B7
         clr   >$01B5
         clr   >$01BA
         bra   L0143
L011F    ldx   >$01C3
         stx   >$01C9
         ldx   >$01C5
         stx   >$01CB
         ldx   #$01C3
         bra   L0102
L0130    deca  
         bne   L013D
         stb   >$01B7
         tfr   u,d
         stb   >$01BA
         bra   L0143
L013D    stb   >$01B4
         stb   >$01B5
L0143    puls  x
         jmp   >$06B7+BaseOff
L0148    tst   >$01B3
         lbeq  L03A7
         ldx   #$01C9
         lbsr  X6
         sta   >$01C9
         stx   >$01CC
         ldx   #$01C3
         lbsr  X6
         sta   >$01C3
         stx   >$01C6
         clr   >$01B5
         ldx   >$01C6
         lda   >$01C3
         beq   L0179
         lbsr  L0454
         leax  $02,x
         lda   ,x
L0179    sta   >$01C8
         ldx   >$01CC
         lda   >$01C9
         beq   L018B
         lbsr  L0454
         leax  $02,x
         lda   ,x
L018B    sta   >$01CE
         ldx   #$135B+BaseOff
         lda   ,x
         lbeq  L0363
         lda   >$01B3
         cmpa  ,x+
         bne   L01F9
         lda   ,x
         sta   >$01B6
         lda   >$01B4
         beq   L01AC
         cmpa  ,x
         bne   L01F9
L01AC    leax  $01,x
         lda   ,x
         beq   L01C6
         lda   >$01C3
         bne   L01CD
         lda   >$01BB
         sta   >$01BD
         ldy   #$01C3
         lbsr  X7
         bra   L01CD
L01C6    lda   >$01C3
         lbne  L0363
L01CD    leax  $01,x
         lda   ,x
         beq   L01EC
         lda   >$01C9
         bne   L01F3
         lda   >$01BC
         sta   >$01BD
         lda   #$01
         sta   >$01B5
         ldy   #$01C9
         lbsr  X7
         bra   L01F3
L01EC    lda   >$01C9
         lbne  L0363
L01F3    leax  $01,x
         lda   ,x
         bra   L0202
L01F9    leax  $01,x
         leax  $01,x
         leax  $02,x
         jmp   >$077F+BaseOff
L0202    sta   >$01D1
         ldx   #$05FF
         stx   <u0088
         lda   #$0D
         lbsr  X3
         lda   >$01C3
         bne   L0220
         ldx   >$01CC
         stx   >$01C6
         lda   >$01C9
         sta   >$01C3
L0220    ldx   #$323C
         lbsr  L0454
         lbsr  X8
         lbsr  X9
         lda   #$0D
         lbsr  X3
         jmp   >$0630+BaseOff
X6       clr   >$01BF
         ldb   ,x+
         stb   >$01B2
         bne   L0240
         clra  
         rts   
L0240    lda   ,x+
         sta   >$01B7
         lda   ,x
         sta   >$01CF
         ldx   #$20FF+BaseOff
         lbsr  X1
         bcc   L02AC
L0252    pshs  y
         pshs  x
         lda   >$01E1
         sta   >$01E2
         lbsr  L02BC
         bne   L02B8
         lda   >$01B7
         beq   L0285
         puls  x
         pshs  x
         lbsr  L0454
         leax  $03,x
         ldb   #$01
         lbsr  L0439
         bcc   L0285
         lbsr  L0454
L0279    
         lbsr  X5
         bcc   L02B8
         lda   >$01B7
         cmpa  ,x+
         bne   L0279
L0285    puls  x
         lda   >$01BF
         lbne  L039E
         lda   >$01E2
         sta   >$01BF
         stx   >$01C0
L0297    
         lbsr  L0454
         tfr   y,x
         puls  y
         ldb   >$01B2
         lda   >$01E2
         sta   >$01E1
         lbsr  L0439
         bcs   L0252
L02AC    ldx   >$01C0
         lda   >$01BF
         bne   L02B7
         jmp   >$0948+BaseOff
L02B7    rts   
L02B8    puls  x
         bra   L0297
L02BC    
         lbsr  L0454
         lda   >$01D5
         cmpa  ,x
         beq   L02B7
         lda   ,x
         beq   L02E1
         cmpa  #$FF
         beq   L02B7
         bita  #$80
         bne   L02E1
         ldb   ,x
         cmpb  >$01D2
         beq   L02B7
         ldx   #$20FF+BaseOff
         lbsr  X4
         bra   L02BC
L02E1    ora   #$01
         rts   
X7       pshs  x
         clr   >$01B2
         clr   >$01E1
         pshs  y
         lda   ,x
         sta   >$01AB
         ldx   #$20FF+BaseOff
         lbsr  L0454
L02F9    lbsr  X5
         bcc   L033E
         inc   >$01E1
         pshs  y
         pshs  x
         lbsr  L02BC
         puls  x
         bne   L0339
         ldb   ,x
         stx   >$01D8
         lbsr  L0454
         leax  $02,x
         lda   ,x
         anda  >$01AB
         cmpa  >$01AB
         bne   L0333
         lda   >$01B2
         bne   L036C
         stb   >$01B2
         lda   ,x
         sta   >$01B7
         ldx   >$01D8
         stx   >$01AD
L0333    exg   x,y
         puls  y
         bra   L02F9
L0339    
         lbsr  L0454
         bra   L0333
L033E    lda   >$01B2
         beq   L036C
         puls  y
         ldx   >$01AD
         lda   >$01E1
         sta   ,y
         leay  $03,y
         stx   ,y++
         lda   >$01B7
         sta   ,y
         puls  x
         clra  
         rts   
         ldy   #$1343+BaseOff
         lda   >$01CF
         bra   L03AD
L0363    ldy   #$1352+BaseOff
         lda   >$01BC
         bra   L03AD
L036C    lda   >$01B5
         beq   L0395
         lda   >$01B4
         bne   L0395
         ldx   #$3ECF
L0379    ldb   ,x
         beq   L0395
         pshs  x
         ldb   ,x+
         abx   
         lda   >$01B6
         cmpa  ,x+
         beq   L038D
         puls  b,a
         bra   L0379
L038D    puls  y
         lda   >$01BD
         jsr   >$09E1+BaseOff
L0395    ldy   #$1343+BaseOff
         lda   >$01BD
         bra   L03AD
L039E    ldy   #$134A+BaseOff
         lda   >$01CF
         bra   L03AD
L03A7    ldy   #$133C+BaseOff
         lda   #$E0
L03AD    lds   #$03FF
         ldx   #$05E0
         jsr   >$09E1+BaseOff
L03B7    lda   ,y
         sta   >$01AB
         pshs  x
L03BE    lda   #$60
         sta   ,x+
         dec   >$01AB
         bne   L03BE
         jsr   >$09D6+BaseOff
         puls  x
         decb  
         bne   L03E3
         lda   ,y
         inca  
         sta   >$01AB
L03D5    jsr   >$0ADB+BaseOff
         dec   >$01AB
         bne   L03D5
         jsr   >$0A63+BaseOff
         jmp   >$0637+BaseOff
L03E3    jsr   >$0A00+BaseOff
         bra   L03B7
         lda   #$32
L03EA    dec   >$01AB
         bne   L03EA
         deca  
         bne   L03EA
         rts   
         sta   >$01AB
         ldd   #$05E0
         ldb   >$01AB
         tfr   d,x
         lda   ,y
         inca  
         sta   >$01AB
         pshs  y
L0406    jsr   >$0B06+BaseOff
         dec   >$01AB
         bne   L0406
         puls  y
         ldb   #$08
         lda   ,y
         sta   >$01AB
         pshs  y,x,b
         leay  $01,y
L041B    lda   ,y+
         sta   ,x+
         dec   >$01AB
         bne   L041B
         leax  $01,x
         tfr   x,d
         stb   >$01BD
         jsr   >$09D6+BaseOff
         puls  y,x,b
         rts   
X1       leax  $01,x
         jsr   >$0A44+BaseOff
         clr   >$01E1
L0439    lbsr  X5
         bcs   L043F
         rts   
L043F    inc   >$01E1
         cmpb  ,x
         beq   L0451
         pshs  y
         lbsr  L0454
         tfr   y,x
         puls  y
         bra   L0439
L0451    orcc  #$01
         rts   
L0454    leax  $01,x
         clra  
         pshs  b
         ldb   ,x+
         bitb  #$80
         beq   L0465
         andb  #$7F
         tfr   b,a
         ldb   ,x+
L0465    leay  d,x
         puls  b
         rts   
X5       sty   >$01A9
         cmpx  >$01A9
         rts   
         ldx   #$05E0
         jsr   >$0B23+BaseOff
L0478    jsr   >$0B2B+BaseOff
         cmpa  #$15
         beq   L049F
         cmpa  #$5D
         beq   L04B2
         cmpa  #$09
         beq   L04C5
         cmpa  #$0D
         beq   L04DA
         cmpa  #$0C
         beq   L04DE
         cmpa  #$08
         beq   L04CE
         cmpx  #$05FF
         beq   L0478
         jsr   >$0B06+BaseOff
         sta   ,x+
         bra   L0478
L049F    cmpx  #$05E0
         beq   L0478
         leax  -$01,x
         lda   ,x+
         sta   ,x
         leax  -$01,x
         lda   #$CF
         sta   ,x
         bra   L0478
L04B2    cmpx  #$05FF
         beq   L0478
         leax  $01,x
         lda   ,x
         leax  -$01,x
         sta   ,x+
         lda   #$CF
         sta   ,x
         bra   L0478
L04C5    jsr   >$0ADB+BaseOff
         lda   #$CF
         sta   ,x
         bra   L0478
L04CE    cmpx  #$05E0
         beq   L0478
         leax  -$01,x
         jsr   >$0ADB+BaseOff
         bra   L0478
L04DA    jsr   >$0ADB+BaseOff
L04DD    rts   
L04DE    ldx   #$05E0
         ldb   #$20
         lda   #$60
L04E5    sta   ,x+
         decb  
         bne   L04E5
         jmp   >$0A60+BaseOff
         tfr   x,u
         leay  $01,x
         lda   #$60
         sta   ,x
         cmpy  #$0600
         beq   L04DD
         cmpy  #$0601
         beq   L04DD
         cmpy  #$0602
         beq   L04DD
L0507    lda   ,y+
         sta   ,x+
         cmpy  #$0600
         bne   L0507
         lda   #$60
         sta   ,x
         tfr   u,x
         rts   
         cmpx  #$0600
         beq   L0534
         stx   >$01A7
         ldx   #$0600
         ldy   #$05FF
L0527    ldb   ,-y
         stb   ,-x
         cmpx  >$01A7
         bne   L0527
         ldb   #$60
         stb   ,x
L0534    rts   
         jsr   >$0B06+BaseOff
         lda   #$CF
         sta   ,x
         rts   
L053D    jsr   >$12A8+BaseOff
*         jsr   [>$A000]
         lbsr   os9read
         nop
         tsta  
         beq   L053D
         cmpa  #$41
         bcc   L0551
         cmpa  #$20
         bcs   L0551
         adda  #$40
L0551    rts   
L0552    leax  $01,x
L0554    tfr   x,d
         stb   >$01CF
         cmpx  #$0600
         beq   L0551
         lda   ,x
         cmpa  #$60
         bcc   L0552
         ldy   #$3C29
         jsr   >$0B8B+BaseOff
         beq   L0554
         ldb   #$01
L056F    leay  $01,y
         jsr   >$0B8B+BaseOff
         beq   L057E
         incb  
         cmpb  #$05
         bne   L056F
         ora   #$01
         rts   
L057E    exg   x,y
         ldx   >$01D8
         stb   ,x+
         sta   ,x+
         lda   >$01CF
         sta   ,x+
         stx   >$01D8
         exg   x,y
         cmpb  #$01
         bne   L059B
         lda   >$01BC
         sta   >$01BB
L059B    clra  
         rts   
         lda   ,y
         bne   L05A4
         ora   #$01
         rts   
L05A4    sta   >$01AB
         sta   >$01D0
         pshs  x
         leay  $01,y
L05AE    lda   ,x
         cmpa  #$60
         beq   L0607
         cmpx  #$0600
         beq   L0607
         cmpa  #$60
         bcs   L05C1
         leax  $01,x
         bra   L05AE
L05C1    cmpa  ,y
         bne   L0607
         leax  $01,x
         leay  $01,y
         dec   >$01AB
         bne   L05AE
         lda   >$01D0
         cmpa  #$06
         beq   L05DB
         lda   ,x
         cmpa  #$60
         bcs   L060E
L05DB    lda   ,y
         puls  y
         sta   >$01AB
L05E2    lda   ,x
         cmpa  #$60
         beq   L05F4
         stx   >$01A7
         cmpx  #$0600
         beq   L05FA
         leax  $01,x
         bra   L05E2
L05F4    stx   >$01A7
         inc   >$01A8
L05FA    lda   >$01A8
         sta   >$01BC
         lda   >$01AB
         clr   >$01A7
         rts   
L0607    leay  $01,y
         dec   >$01AB
         bne   L0607
L060E    puls  x
         leay  $01,y
         jmp   >$0B8B+BaseOff
X8       lda   ,x+
         tfr   a,b
         bita  #$80
         beq   L0630
         pshs  y,x
         ldx   #$37FA
         lbsr  X1
         bcc   L062D
         lbsr  L0454
         lbsr  X8
L062D    puls  y,x
         rts   
L0630    tfr   b,a
         ldy   #$12E5+BaseOff
         lsla  
         jmp   [a,y]
         jsr   >$0A44+BaseOff
L063C    lbsr  X5
         bcc   L064D
         pshs  y
         lbsr  X8
         puls  y
         beq   L063C
         exg   x,y
         rts   
L064D    exg   x,y
         clra  
         rts   
         jsr   >$0A44+BaseOff
L0654    lbsr  X5
         bcc   L0665
         pshs  y
         lbsr  X8
         puls  y
         bne   L0654
         exg   x,y
         rts   
L0665    exg   x,y
         ora   #$01
         rts   
         jsr   >$0A44+BaseOff
         ldb   ,x+
L066F    lbsr  X5
         bcc   L0665
         pshs  y
         pshs  b
         tfr   b,a
         jsr   >$0C20+BaseOff
         puls  b
         beq   L068A
         jsr   >$0A44+BaseOff
         exg   x,y
         puls  y
         bra   L066F
L068A    jsr   >$0A44+BaseOff
         lbsr  X8
         puls  x
         rts   
         jsr   >$0C8D+BaseOff
         pshs  x
         lbsr  X2
         puls  x
         clra  
         rts   
         lda   ,x+
         pshs  x
         sta   >$01D5
         tfr   a,b
         ldx   #$1523+BaseOff
         lbsr  X1
         stx   >$01D6
         ldx   >$01D3
         lbsr  L0454
         lda   >$01D5
         sta   ,x
         puls  x
         clra  
         rts   
         ldu   >$01C6
         stu   >$01C0
         lda   >$01C3
         sta   >$01BF
         clra  
         rts   
         ldu   >$01CC
         stu   >$01C0
         lda   >$01C9
         sta   >$01BF
         clra  
         rts   
         ldb   ,x+
         pshs  x
         stb   >$01BF
         beq   L06EB
         lbsr  X4
         stx   >$01C0
L06EB    puls  x
         clra  
         rts   
         ldu   >$01C6
         pshs  u
         ldu   >$01CC
         pshs  u
         lda   >$01C9
         ldb   >$01C3
         pshs  b,a
         lda   >$01D1
         pshs  a
         lda   ,x+
         sta   >$01D1
         ldd   ,x++
         stb   >$01AB
         pshs  x
         sta   >$01C3
         tfr   a,b
         beq   L071F
         lbsr  X4
         stx   >$01C6
L071F    ldb   >$01AB
         stb   >$01C9
         beq   L072D
         lbsr  X4
         stx   >$01CC
L072D    ldx   #$323C
         lbsr  L0454
         lbsr  X8
         tfr   cc,a
         sta   >$01AB
         puls  y
         puls  a
         sta   >$01D1
         puls  b,a
         stb   >$01C3
         sta   >$01C9
         puls  u
         stu   >$01CC
         puls  u
         stu   >$01C6
         exg   x,y
         lda   >$01AB
         tfr   a,cc
L075B    rts   
X2       lda   >$01D2
         cmpa  #$1D
         bne   L075B
         ldx   >$01D6
         lbsr  L0454
         leax  $01,x
         ldb   #$03
         lbsr  L0439
         bcc   L0777
         leax  $01,x
         jsr   >$114C+BaseOff
L0777    ldx   #$20FF+BaseOff
         lbsr  L0454
L077D    pshs  y
         lbsr  L0454
         lda   >$01D5
         cmpa  ,x
         bne   L079B
         leax  $03,x
         ldb   #$03
         lbsr  L0439
         bcc   L079B
         leax  $01,x
         pshs  y
         jsr   >$114C+BaseOff
         puls  y
L079B    exg   x,y
         puls  y
         lbsr  X5
         bcs   L077D
         rts   
         ldb   ,x+
         pshs  x
         lbsr  X4
         lbsr  L02BC
         puls  x
         rts   
         lda   >$01D2
         cmpa  ,x+
         rts   
         ldb   ,x+
         jmp   >$0F5F+BaseOff
         ldd   ,x++
         pshs  x
         sta   >$01AB
         lbsr  X4
         lbsr  L0454
         ldd   ,x++
         cmpa  >$01AB
         puls  x
         rts   
         ora   #$01
         rts   
         lda   >$01D2
         cmpa  #$1D
         bne   L07EA
         ldb   #$1D
         pshs  x
         lbsr  X4
         lbsr  L02BC
         puls  x
         beq   L07F1
L07EA    jsr   >$0A44+BaseOff
         exg   x,y
         bra   L07F4
L07F1    jsr   >$114C+BaseOff
L07F4    clra  
         rts   
         lbsr  X2
         clra  
         rts   
         pshs  x
L07FD    lda   #$0D
         lbsr  X3
         ldx   #$20FF+BaseOff
         lbsr  L0454
L0808    lbsr  X5
         bcc   L0831
         pshs  y
         lbsr  L0454
         ldb   ,x
         cmpb  >$01D2
         bne   L082B
         leax  $03,x
         ldb   #$02
         lbsr  L0439
         bcc   L082B
         leax  $01,x
         pshs  y
         jsr   >$1143+BaseOff
         puls  y
L082B    exg   x,y
         puls  y
         bra   L0808
L0831    clra  
         puls  x
         rts   
         ldu   >$01C6
         lda   >$01C3
L083B    stu   >$01D8
         tsta  
         beq   L0851
         ldb   ,x+
         pshs  x
         lbsr  X4
         exg   x,y
         puls  x
         cmpy  >$01D8
         rts   
L0851    tstb  
         rts   
         ldu   >$01CC
         lda   >$01C9
         bra   L083B
         ldb   ,x+
         cmpb  >$01D1
         rts   
         pshs  x
         ldx   >$01C0
         lbsr  L0454
         lda   >$01D2
         sta   ,x
         clra  
         puls  x
         rts   
         pshs  x
         ldx   >$01C0
         lbsr  L0454
         lda   >$01D5
         sta   ,x
         puls  x
         clra  
         rts   
         pshs  x
         ldx   >$01D6
         lbsr  L0454
         leax  $01,x
         ldb   #$04
         lbsr  L0439
         bcc   L089C
         lbsr  L0454
         lbsr  X8
         beq   L08D7
L089C    lda   >$01C9
         beq   L08B8
         ldx   >$01CC
         lbsr  L0454
         leax  $03,x
         ldb   #$06
         lbsr  L0439
         bcc   L08B8
         lbsr  L0454
         lbsr  X8
         beq   L08D7
L08B8    lda   >$01C3
         bne   L08C2
L08BD    puls  x
         ora   #$01
         rts   
L08C2    ldx   >$01C6
         lbsr  L0454
         leax  $03,x
         ldb   #$07
         lbsr  L0439
         bcc   L08BD
         lbsr  L0454
         lbsr  X8
L08D7    puls  x
         rts   
         pshs  x
         ldx   >$01C0
         lda   >$01BF
         bra   L08EC
         pshs  x
         ldx   >$01C6
         lda   >$01C3
L08EC    beq   L08D7
         ldb   #$1D
         pshs  x
         lbsr  X4
         lbsr  L02BC
         puls  x
         bne   L090D
         lbsr  L0454
         leax  $03,x
         ldb   #$02
         lbsr  L0439
         bcc   L090D
         leax  $01,x
         jsr   >$114C+BaseOff
L090D    puls  x
         clra  
         rts   
         pshs  x
         ldx   >$01CC
         lda   >$01C9
         bra   L08EC
         pshs  x
         ldx   >$01C0
         lda   >$01BF
         beq   L0933
         lbsr  L0454
         leax  $02,x
         lda   ,x
         puls  x
         anda  ,x
         eora  ,x+
         rts   
L0933    puls  x
         leax  $01,x
         ora   #$01
         rts   
         lbsr  X8
         bne   L0942
         ora   #$01
         rts   
L0942    clra  
         rts   
         ldb   ,x+
         pshs  x
         lbsr  X4
         lbsr  L0454
         puls  y
         lda   ,y+
         sta   ,x
         exg   x,y
         clra  
L0957    rts   
         pshs  x
         ldx   >$01C0
L095D     
         lbsr  L0454
         ldb   ,x
         puls  x
         lbeq  L02E1
         cmpb  >$01D2
         beq   L0957
         bitb  #$80
         bne   L0957
         pshs  x
         lbsr  X4
         bra   L095D
X9       ldx   #$20FF+BaseOff
         clr   >$01D0
         lbsr  L0454
L0981    lbsr  X5
         bcc   L0957
         inc   >$01D0
         pshs  y
         lbsr  L0454
         lda   ,x
         sta   >$01AB
         pshs  y
         lda   ,x
         beq   L09DB
         leax  $03,x
         ldb   #$08
         lbsr  L0439
         bcc   L09DB
         lbsr  L0454
         pshs  x
         jsr   >$12A8+BaseOff
         ldb   >$01D0
         stb   >$01D2
         lbsr  X4
         stx   >$01D3
         ldb   >$01AB
L09B9    tstb  
         bmi   L09CA
         lbsr  X4
         lbsr  L0454
         ldb   ,x
         bne   L09B9
         puls  x
         bra   L09DB
L09CA    stb   >$01D5
         ldx   #$1523+BaseOff
         lbsr  X1
         stx   >$01D6
         puls  x
         lbsr  X8
L09DB    puls  x
         puls  y
         bra   L0981
         lda   >$1338
         cmpa  ,x+
         bcs   L09ED
         beq   L09ED
         ora   #$01
         rts   
L09ED    clra  
         rts   
         lda   ,x+
         sta   >$01AB
         pshs  x
         ldx   >$01C0
         lbsr  L0454
         leax  $03,x
         pshs  x
         pshs  y
         ldb   #$09
         lbsr  L0439
         bcc   L0A32
         lbsr  L0454
         leax  $01,x
         lda   ,x
         suba  >$01AB
         bcc   L0A16
         clra  
L0A16    sta   ,x
         puls  y
         puls  x
         tsta  
         beq   L0A23
L0A1F    puls  x
         clra  
         rts   
L0A23    ldb   #$0A
         lbsr  L0439
         bcc   L0A1F
         lbsr  L0454
         lbsr  X8
         bra   L0A1F
L0A32    puls  y
         puls  x
         bra   L0A1F
         ldb   ,x+
         lda   ,x+
         sta   >$01AB
         pshs  x
         lbsr  X4
         lbsr  L0454
         tfr   x,u
         ldb   >$01AB
         lbsr  X4
         lbsr  L0454
         lda   ,x
         ldb   ,u
         sta   ,u
         stb   ,x
         puls  x
         clra  
         rts   
         lda   ,x+
         pshs  x
         sta   >$01AB
         ldx   >$01C0
         lbsr  L0454
         leax  $03,x
         ldb   #$09
         lbsr  L0439
         bcc   L0A82
         lbsr  L0454
         leax  $01,x
         lda   ,x
         cmpa  >$01AB
         bcs   L0A87
         beq   L0A87
L0A82    puls  x
         ora   #$01
         rts   
L0A87    puls  x
         clra  
         rts   
         lda   ,x+
         sta   >$01AB
         pshs  x
         ldx   >$01C0
         lbsr  L0454
         leax  $03,x
         ldb   #$09
         lbsr  L0439
         bcc   L0A87
         lbsr  L0454
         ldd   ,x
         addb  >$01AB
         sta   >$01AB
         cmpb  >$01AB
         bcs   L0AB4
         ldb   >$01AB
L0AB4    leax  $01,x
         stb   ,x
         bra   L0A87
         lda   #$0D
         lbsr  X3
         lda   #$0D
         lbsr  X3
         jmp   >$060C+BaseOff
L0AC7    bra   L0AC7
L0AC9    lda   ,y+
         beq   L0AD6
         pshs  y
         lbsr  X3
         puls  y
         bra   L0AC9
L0AD6    rts   
         pshs  x
         clr   >$01AF
         clr   >$01B0
         lda   >$01D5
         cmpa  #$96
         bne   L0AE9
         inc   >$01B0
L0AE9    ldx   #$20FF+BaseOff
         lbsr  L0454
L0AEF    lbsr  X5
         bcc   L0B21
         pshs  y
         lbsr  L0454
         ldb   ,x+
         cmpb  #$96
         beq   L0B03
         cmpb  #$1D
         bne   L0B1B
L0B03    lda   >$01AF
         adda  ,x
         daa   
         sta   >$01AF
         cmpb  #$96
         beq   L0B15
         tst   >$01B0
         beq   L0B1B
L0B15    adda  ,x
         daa   
         sta   >$01AF
L0B1B    tfr   y,x
         puls  y
         bra   L0AEF
L0B21    lda   >$01AF
         asra  
         asra  
         asra  
         asra  
         adda  #$30
         lbsr  X3
         lda   >$01AF
         anda  #$0F
         adda  #$30
         lbsr  X3
         lda   #$2E
         lbsr  X3
         lda   #$20
         lbsr  X3
         puls  x
         clra  
         rts   
X4       ldx   #$20FF+BaseOff
         lbsr  L0454
L0B4B    decb  
         beq   L0AD6
         lbsr  L0454
         exg   x,y
         bra   L0B4B
         jsr   >$114C+BaseOff
         lda   #$0D
         lbsr  X3
         rts   
         clra  
         ldb   ,x
         bitb  #$80
         beq   L0B69
         lda   ,x+
         anda  #$7F
L0B69    ldb   ,x+
         std   >$01AB
L0B6E    ldd   >$01AB
         cmpd  #$0002
         bcs   L0B85
         jsr   >$11EC+BaseOff
         ldd   >$01AB
         subd  #$0002
         std   >$01AB
         bra   L0B6E
L0B85    tstb  
         beq   L0B90
         lda   ,x+
         lbsr  X3
         decb  
         bra   L0B85
L0B90    lda   #$20
         lbsr  X3
         rts   
X3       pshs  b,a
         lda   >$01BE
         cmpa  #$20
         bne   L0BB9
         puls  b,a
         cmpa  #$20
         beq   L0BFC
         cmpa  #$2E
         beq   L0BB1
         cmpa  #$3F
         beq   L0BB1
         cmpa  #$21
         bne   L0BBB
L0BB1    ldu   <u0088
         leau  -u0001,u
         stu   <u0088
         bra   L0BBB
L0BB9    puls  b,a
L0BBB    sta   >$01BE
*         jsr   [>$A002]
         lbsr   os9write
         nop
         lda   <u0089
         cmpa  #$FE
         bcs   L0BFC
         ldu   <u0088
         leau  <-u0021,u
         lda   #$0D
*         jsr   [>$A002]
         lbsr   os9write
         nop
L0BD3    lda   ,u
         cmpa  #$60
         beq   L0BDD
         leau  -u0001,u
         bra   L0BD3
L0BDD    leau  u0001,u
         lda   ,u
         cmpa  #$60
         beq   L0BFC
         pshs  b
         ldb   #$60
         stb   ,u
         puls  b
         cmpa  #$60
         bcs   L0BF3
         suba  #$40
L0BF3    sta   >$01BE
*         jsr   [>$A002]
         lbsr   os9write
         nop
         bra   L0BDD
L0BFC    rts   
         rts   
         ldy   #$12A4+BaseOff
         ldb   #$03
         stb   >$12A1+BaseOff
         lda   ,x+
         sta   >$01DE
         lda   ,x+
         sta   >$01DD
         leay  $03,y
L0C13    ldu   #$0028
         stu   >$12A2+BaseOff
         lda   #$11
         sta   >$01DA
         clr   >$01DB
         clr   >$01DC
L0C24    rol   >$01DE
         rol   >$01DD
         dec   >$01DA
         beq   L0C68
         lda   #$00
         adca  #$00
         lsl   >$01DC
         rol   >$01DB
         adda  >$01DC
         suba  >$12A3+BaseOff
         sta   >$01E0
         lda   >$01DB
         sbca  >$12A2+BaseOff
         sta   >$01DF
         bcc   L0C58
         ldd   >$01DF
         addd  >$12A2+BaseOff
         std   >$01DB
         bra   L0C5E
L0C58    ldd   >$01DF
         std   >$01DB
L0C5E    bcs   L0C64
         orcc  #$01
         bra   L0C24
L0C64    andcc #$FE
         bra   L0C24
L0C68    ldd   >$01DB
         addd  #$1279+BaseOff
         tfr   d,u
         lda   ,u
         sta   ,-y
         dec   >$12A1+BaseOff
         bne   L0C13
         ldy   #$12A4+BaseOff
         ldb   #$03
L0C7F    lda   ,y+
         lbsr  X3
         decb  
         bne   L0C7F
         ldd   >$01AB
         rts   


L0C78    fcb   $3F,$21,$32,$20,$22,$27,$3C   9?!2 "'<
L0C80    fcb   $3E,$2F,$30,$33,$41,$42,$43,$44   >/03ABCD
L0C88    fcb   $45,$46,$47,$48,$49,$4A,$4B,$4C   EFGHIJKL
L0C90    fcb   $4D,$4E,$4F,$50,$51,$52,$53,$54   MNOPQRST
L0C98    fcb   $55,$56,$57,$58,$59,$5A,$2D,$2C   UVWXYZ-,
L0CA0    fcb   $2E,$00,$00,$00,$00,$00,$00,$00   ........

         pshs  x,b
         ldx   #$1338+BaseOff
         ldb   #$17
         lda   ,x
L0CC3    leax  $01,x
L0CC5    orcc  #$01
         anda  #$06
         beq   L0CD2
         cmpa  #$06
         orcc  #$01
         beq   L0CD2
         clra  
L0CD2    lda   ,x
         bcs   L0CD9
         lsra
         bra   L0CDC
L0CD9    lsra  
         ora   #$80
L0CDC    sta   ,x
L0CDE    leax  -$01,x
         lda   ,x
         bcs   L0CE7
         lsra
         bra   L0CEA
L0CE7    lsra
         ora   #$80
L0CEA    anda  #$FE
         sta   ,x
         decb
         bne   L0CC3
         lda   >$1339+BaseOff
         puls  x,b
         rts

L0CE5    fcb   $0C,$81,$0D   .95.9...
L0CE8    fcb   $93,$0D,$A6,$0D,$AB,$0D,$C3,$0F   ..&.+.C.
L0CF0    fcb   $CF,$0D,$E9,$0D,$E4,$0E,$23,$0E   O.i.d.#.
L0CF8    fcb   $41,$0E,$49,$0C,$58,$0D,$C0,$0C   A.I.X.@.
L0D00    fcb   $27,$0C,$3F,$0E,$4F,$0E,$60,$0E   '.?.O.`.
L0D08    fcb   $D2,$0E,$FF,$0E,$71,$0F,$28,$0F   R...q.(.
L0D10    fcb   $09,$0E,$C8,$0F,$32,$0F,$46,$0C   ..H.2.F.
L0D18    fcb   $8D,$0C,$AE,$0C,$BC,$0C,$CA,$0F   ....<.J.
L0D20    fcb   $DD,$10,$26,$0D,$CA,$0D,$A0,$0C   ].&.J. .
L0D28    fcb   $DD,$10,$4C,$10,$79,$10,$B5,$10   ].L.y.5.
L0D30    fcb   $A8,$10,$C5,$00,$12,$23,$44,$1D   (.E..#D.
L0D38    fcb   $27,$4D,$2D,$13,$06,$3F,$56,$45   'M-..?VE
L0D40    fcb   $52,$42,$3F,$06,$3F,$57,$48,$41   RB?.?WHA
L0D48    fcb   $54,$3F,$07,$3F,$57,$48,$49,$43   T?.?WHIC
L0D50    fcb   $48,$3F,$08,$3F,$50,$48,$52,$41   H?.?PHRA
L0D58    fcb   $53,$45,$3F,$05,$00,$00,$00,$01   SE?.....
L0D60    fcb   $06,$00,$00,$00,$02,$07,$00,$00   ........
L0D68    fcb   $00,$03,$08,$00,$00,$00,$04,$09   ........
L0D70    fcb   $00,$20,$00,$05,$34,$07,$00,$80   . ..4...
L0D78    fcb   $05,$34,$07,$80,$00,$05,$0A,$00   .4......
L0D80    fcb   $20,$00,$06,$0A,$05,$80,$80,$0F    .......
L0D88    fcb   $0A,$06,$00,$88,$16,$0B,$00,$00   ........
L0D90    fcb   $00,$07,$01,$00,$04,$00,$08,$04   ........
L0D98    fcb   $02,$10,$40,$09,$0C,$00,$00,$00   ..@.....
L0DA0    fcb   $0A,$0C,$03,$00,$80,$0B,$0C,$04   ........
L0DA8    fcb   $00,$80,$0C,$0C,$05,$00,$80,$10   ........
L0DB0    fcb   $03,$03,$40,$10,$0D,$03,$05,$80   ..@.....
L0DB8    fcb   $80,$39,$03,$08,$00,$20,$06,$03   .9... ..
L0DC0    fcb   $01,$80,$10,$0E,$0D,$01,$80,$10   ........
L0DC8    fcb   $0E,$0E,$00,$80,$00,$0B,$0E,$05   ........
L0DD0    fcb   $00,$80,$0B,$0F,$00,$80,$00,$11   ........
L0DD8    fcb   $0F,$02,$80,$80,$3A,$10,$00,$80   ....:...
L0DE0    fcb   $00,$12,$10,$08,$00,$80,$12,$10   ........
L0DE8    fcb   $06,$00,$80,$05,$10,$06,$80,$00   ........
L0DF0    fcb   $05,$10,$07,$00,$80,$2D,$10,$07   .....-..
L0DF8    fcb   $80,$00,$2D,$11,$02,$88,$88,$14   ..-.....
L0E00    fcb   $12,$00,$80,$00,$15,$13,$06,$00   ........
L0E08    fcb   $88,$16,$14,$00,$88,$00,$16,$15   ........
L0E10    fcb   $00,$80,$00,$17,$15,$07,$00,$80   ........
L0E18    fcb   $17,$15,$08,$00,$80,$17,$15,$09   ........
L0E20    fcb   $00,$80,$17,$15,$0C,$00,$80,$17   ........
L0E28    fcb   $15,$05,$00,$00,$36,$15,$05,$00   ....6...
L0E30    fcb   $80,$36,$15,$06,$00,$00,$37,$15   .6....7.
L0E38    fcb   $06,$00,$80,$37,$15,$04,$00,$80   ...7....
L0E40    fcb   $38,$16,$00,$80,$00,$18,$18,$00   8.......
L0E48    fcb   $00,$00,$1A,$05,$01,$00,$00,$01   ........
L0E50    fcb   $06,$01,$00,$00,$02,$07,$01,$00   ........
L0E58    fcb   $00,$03,$08,$01,$00,$00,$04,$0A   ........
L0E60    fcb   $08,$00,$20,$06,$0A,$08,$20,$00   .. ... .
L0E68    fcb   $06,$0A,$0A,$20,$80,$06,$0A,$04   ... ....
L0E70    fcb   $20,$80,$06,$0A,$0C,$20,$80,$06    .... ..
L0E78    fcb   $0C,$07,$00,$00,$0A,$0C,$08,$00   ........
L0E80    fcb   $00,$0A,$0C,$09,$80,$00,$0B,$0C   ........
L0E88    fcb   $09,$00,$80,$0B,$0C,$0B,$00,$00   ........
L0E90    fcb   $0A,$0C,$0A,$00,$00,$0A,$0C,$0B   ........
L0E98    fcb   $00,$80,$1B,$0C,$0A,$00,$80,$1C   ........
L0EA0    fcb   $32,$00,$00,$00,$21,$2B,$00,$00   2...!+..
L0EA8    fcb   $00,$22,$2D,$00,$00,$00,$23,$2C   ."-...#,
L0EB0    fcb   $00,$00,$00,$25,$2C,$00,$20,$00   ...%,. .
L0EB8    fcb   $06,$21,$00,$00,$00,$25,$21,$01   .!...%!.
L0EC0    fcb   $00,$80,$3D,$21,$05,$00,$80,$36   ..=!...6
L0EC8    fcb   $21,$06,$00,$80,$37,$21,$04,$00   !...7!..
L0ED0    fcb   $80,$38,$21,$07,$00,$80,$17,$21   .8!....!
L0ED8    fcb   $08,$00,$80,$17,$21,$0B,$00,$80   ....!...
L0EE0    fcb   $26,$23,$00,$80,$00,$27,$23,$08   &#...'#.
L0EE8    fcb   $00,$80,$27,$23,$05,$00,$80,$27   ..'#...'
L0EF0    fcb   $24,$02,$10,$80,$28,$24,$01,$80   $...($..
L0EF8    fcb   $10,$29,$28,$00,$00,$00,$2C,$1C   .)(...,.
L0F00    fcb   $00,$80,$00,$2D,$1F,$00,$00,$00   ...-....
L0F08    fcb   $2F,$1F,$0B,$00,$00,$2F,$09,$07   /..../..
L0F10    fcb   $00,$00,$2F,$20,$09,$00,$80,$34   ../ ...4
L0F18    fcb   $20,$05,$00,$80,$36,$20,$06,$00    ...6 ..
L0F20    fcb   $80,$37,$00,$00,$8B,$D9,$81,$5E   .7...Y.^
L0F28    fcb   $00,$03,$52,$C7,$DE,$94,$14,$4B   ..RG^..K
L0F30    fcb   $5E,$83,$96,$5F,$17,$46,$48,$39   ^.._.FH9
L0F38    fcb   $17,$DB,$9F,$56,$D1,$09,$71,$D0   .[.VQ.qP
L0F40    fcb   $B0,$7F,$7B,$F3,$17,$0D,$8D,$90   0{s....
L0F48    fcb   $14,$08,$58,$81,$8D,$1B,$B5,$5F   ..X...5_
L0F50    fcb   $BE,$5B,$B1,$4B,$7B,$55,$45,$8E   >[1K{UE.
L0F58    fcb   $91,$11,$8A,$F0,$A4,$91,$7A,$89   ...p$.z.
L0F60    fcb   $17,$82,$17,$47,$5E,$66,$49,$90   ...G^fI.
L0F68    fcb   $14,$03,$58,$3B,$16,$B7,$B1,$A9   ..X;.71)
L0F70    fcb   $15,$DB,$8B,$83,$7A,$5F,$BE,$D7   .[..z_>W
L0F78    fcb   $14,$43,$7A,$CF,$98,$04,$07,$0B   .CzO....
L0F80    fcb   $05,$0A,$03,$02,$00,$82,$82,$80   ........
L0F88    fcb   $C4,$00,$03,$80,$AB,$C7,$DE,$94   D...+G^.
L0F90    fcb   $14,$4B,$5E,$83,$96,$3B,$16,$B7   .K^..;.7
L0F98    fcb   $B1,$2F,$17,$FB,$55,$C7,$98,$54   1/..UG.T
L0FA0    fcb   $8B,$39,$17,$FF,$9F,$C0,$16,$82   .9...@..
L0FA8    fcb   $17,$48,$5E,$81,$8D,$91,$AF,$96   .H^.../.
L0FB0    fcb   $64,$DB,$72,$95,$5F,$15,$BC,$FF   d[r._.<.
L0FB8    fcb   $78,$B8,$16,$82,$17,$54,$5E,$3F   x8...T^?
L0FC0    fcb   $A0,$D5,$15,$90,$14,$D0,$15,$F3    U...P.s
L0FC8    fcb   $BF,$16,$53,$51,$5E,$07,$B2,$BB   ?.SQ^.2;
L0FD0    fcb   $9A,$14,$8A,$6B,$C4,$0C,$BA,$7D   ...kD.:}
L0FD8    fcb   $62,$90,$73,$C4,$6A,$91,$62,$30   b.sDj.b0
L0FE0    fcb   $60,$82,$17,$50,$5E,$BE,$A0,$03   `..P^> .
L0FE8    fcb   $71,$33,$98,$47,$B9,$53,$BE,$0E   q3.G9S>.
L0FF0    fcb   $D0,$2F,$8E,$D0,$15,$82,$17,$47   P/.P...G
L0FF8    fcb   $5E,$66,$49,$F3,$17,$F3,$8C,$4B   ^fIs.s.K
L1000    fcb   $7B,$4A,$45,$77,$C4,$D3,$14,$0F   {JEwDS..
L1008    fcb   $B4,$19,$58,$36,$A0,$83,$61,$81   4.X6 .a.
L1010    fcb   $5B,$1B,$B5,$6B,$BF,$5F,$BE,$61   [.5k?_>a
L1018    fcb   $17,$82,$C6,$03,$EE,$5F,$17,$46   ..F.n_.F
L1020    fcb   $48,$A9,$15,$DB,$8B,$E3,$8B,$0B   H).[.c..
L1028    fcb   $5C,$6B,$BF,$46,$45,$35,$49,$DB   \k?FE5I[
L1030    fcb   $16,$D3,$B9,$9B,$6C,$1B,$D0,$2E   .S9.l.P.
L1038    fcb   $04,$13,$0B,$11,$0A,$04,$02,$00   ........
L1040    fcb   $81,$02,$02,$00,$83,$03,$06,$0D   ........
L1048    fcb   $04,$20,$1D,$8B,$81,$83,$3A,$00   . ....:.
L1050    fcb   $03,$2A,$C7,$DE,$94,$14,$4B,$5E   .*G^..K^
L1058    fcb   $83,$96,$FB,$14,$4B,$B2,$55,$A4   ....K2U$
L1060    fcb   $09,$B7,$59,$5E,$3B,$4A,$23,$D1   .7Y^;J#Q
L1068    fcb   $13,$54,$C9,$B8,$F5,$A4,$B2,$17   .TI8u$2.
L1070    fcb   $90,$14,$16,$58,$D6,$9C,$DB,$72   ...XV.[r
L1078    fcb   $47,$B9,$77,$BE,$04,$0B,$0B,$09   G9w>....
L1080    fcb   $0A,$01,$02,$00,$82,$02,$02,$00   ........
L1088    fcb   $84,$84,$67,$00,$03,$53,$C7,$DE   ..g..SG^
L1090    fcb   $94,$14,$43,$5E,$16,$BC,$DB,$72   ..C^.<[r
L1098    fcb   $82,$BF,$B8,$16,$7B,$14,$55,$A4   .?8.{.U$
L10A0    fcb   $09,$B7,$59,$5E,$85,$73,$15,$71   .7Y^.s.q
L10A8    fcb   $82,$8D,$4B,$62,$89,$5B,$83,$96   ..Kb.[..
L10B0    fcb   $33,$98,$6B,$BF,$5F,$BE,$99,$16   3.k?_>..
L10B8    fcb   $C2,$B3,$56,$F4,$F4,$72,$4B,$5E   B3VttrK^
L10C0    fcb   $C3,$B5,$E1,$14,$73,$B3,$84,$5B   C5a.s3.[
L10C8    fcb   $89,$17,$82,$17,$47,$5E,$66,$49   ....G^fI
L10D0    fcb   $90,$14,$03,$58,$06,$9A,$F4,$72   ...X..tr
L10D8    fcb   $89,$17,$82,$17,$59,$5E,$66,$62   ....Y^fb
L10E0    fcb   $2E,$04,$0F,$0B,$0D,$0A,$01,$02   ........
L10E8    fcb   $00,$83,$04,$02,$00,$A1,$03,$02   .....!..
L10F0    fcb   $00,$85,$85,$44,$00,$03,$26,$63   ...D..&c
L10F8    fcb   $BE,$CB,$B5,$C3,$B5,$73,$17,$1B   >K5C5s..
L1100    fcb   $B8,$E6,$A4,$39,$17,$DB,$9F,$56   8f$9.[.V
L1108    fcb   $D1,$07,$71,$96,$D7,$C7,$B5,$66   Q.q.WG5f
L1110    fcb   $49,$15,$EE,$36,$A1,$73,$76,$8E   I.n6!sv.
L1118    fcb   $48,$F7,$17,$17,$BA,$04,$19,$0B   Hw..:...
L1120    fcb   $17,$0A,$04,$02,$00,$84,$02,$02   ........
L1128    fcb   $00,$86,$03,$0C,$0D,$0A,$00,$88   ........
L1130    fcb   $14,$0D,$05,$20,$1D,$01,$07,$82   ... ....
L1138    fcb   $86,$3F,$00,$03,$2F,$C7,$DE,$94   .?../G^.
L1140    fcb   $14,$4B,$5E,$83,$96,$39,$17,$DB   .K^..9.[
L1148    fcb   $9F,$56,$D1,$09,$71,$DB,$B0,$66   .VQ.q[0f
L1150    fcb   $17,$0F,$A0,$F3,$17,$0D,$8D,$52   .. s...R
L1158    fcb   $F4,$65,$49,$77,$47,$CE,$B5,$86   teIwGN5.
L1160    fcb   $5F,$99,$16,$C2,$B3,$90,$14,$07   _..B3...
L1168    fcb   $58,$66,$49,$2E,$04,$0B,$0B,$09   XfI.....
L1170    fcb   $0A,$01,$02,$00,$85,$03,$02,$00   ........
L1178    fcb   $87,$87,$44,$00,$03,$2F,$63,$BE   ..D../c>
L1180    fcb   $CB,$B5,$C3,$B5,$39,$17,$8E,$C5   K5C59..E
L1188    fcb   $39,$17,$DB,$9F,$56,$D1,$0A,$71   9.[.VQ.q
L1190    fcb   $7A,$79,$F3,$17,$0D,$8D,$56,$F4   zys...Vt
L1198    fcb   $DB,$72,$16,$A0,$51,$DB,$F0,$A4   [r. Q[p$
L11A0    fcb   $91,$7A,$D5,$15,$89,$17,$82,$17   .zU.....
L11A8    fcb   $59,$5E,$66,$62,$2E,$04,$10,$0B   Y^fb....
L11B0    fcb   $0E,$0A,$05,$07,$0D,$05,$08,$08   ........
L11B8    fcb   $19,$8C,$0C,$04,$02,$00,$86,$88   ........
L11C0    fcb   $79,$00,$03,$57,$C7,$DE,$94,$14   y..WG^..
L11C8    fcb   $4B,$5E,$83,$96,$8C,$17,$90,$78   K^.....x
L11D0    fcb   $2E,$6F,$23,$49,$01,$B3,$59,$90   .o#I.3Y.
L11D8    fcb   $82,$7B,$C2,$16,$93,$61,$C5,$98   .{B..aE.
L11E0    fcb   $D0,$15,$82,$17,$47,$5E,$66,$49   P...G^fI
L11E8    fcb   $90,$14,$19,$58,$66,$62,$E1,$14   ...Xfba.
L11F0    fcb   $CF,$B2,$AF,$B3,$82,$17,$2F,$62   O2/3../b
L11F8    fcb   $D5,$15,$7B,$14,$FB,$B9,$67,$C0   U.{..9g@
L1200    fcb   $D0,$15,$82,$17,$55,$5E,$36,$A1   P...U^6!
L1208    fcb   $05,$71,$B8,$A0,$23,$62,$56,$D1   .q8 #bVQ
L1210    fcb   $04,$71,$6B,$A1,$8E,$48,$94,$14   .qk!.H..
L1218    fcb   $09,$B3,$2E,$04,$1D,$0B,$1B,$0A   .3......
L1220    fcb   $04,$0B,$0E,$09,$0D,$05,$20,$1D   ...... .
L1228    fcb   $01,$07,$82,$00,$85,$03,$0B,$0E   ........
L1230    fcb   $09,$0D,$05,$20,$1D,$01,$06,$82   ... ....
L1238    fcb   $00,$89,$89,$5D,$00,$03,$3F,$C7   ...]..?G
L1240    fcb   $DE,$94,$14,$43,$5E,$16,$BC,$DB   ^..C^.<[
L1248    fcb   $72,$47,$B9,$53,$BE,$8E,$61,$B8   rG9S>.a8
L1250    fcb   $16,$82,$17,$49,$5E,$63,$B1,$05   ...I^c1.
L1258    fcb   $BC,$9E,$61,$CE,$B0,$9B,$15,$11   <.aN0...
L1260    fcb   $8D,$5F,$4A,$3A,$15,$8D,$7B,$3A   ._J:..{:
L1268    fcb   $15,$66,$7B,$D0,$15,$82,$17,$47   .f{P...G
L1270    fcb   $5E,$66,$49,$90,$14,$19,$58,$66   ^fI...Xf
L1278    fcb   $62,$F3,$17,$0D,$8D,$2E,$04,$19   bs......
L1280    fcb   $0B,$17,$0A,$04,$0C,$0D,$0A,$00   ........
L1288    fcb   $88,$14,$0D,$05,$20,$1D,$01,$06   .... ...
L1290    fcb   $82,$01,$02,$00,$90,$03,$02,$00   ........
L1298    fcb   $8A,$8A,$3A,$00,$03,$26,$63,$BE   ..:..&c>
L12A0    fcb   $CB,$B5,$C3,$B5,$73,$17,$1B,$B8   K5C5s..8
L12A8    fcb   $E6,$A4,$39,$17,$DB,$9F,$56,$D1   f$9.[.VQ
L12B0    fcb   $07,$71,$96,$D7,$C7,$B5,$66,$49   .q.WG5fI
L12B8    fcb   $15,$EE,$36,$A1,$73,$76,$8E,$48   .n6!sv.H
L12C0    fcb   $F7,$17,$17,$BA,$04,$0F,$0B,$0D   w..:....
L12C8    fcb   $0A,$04,$02,$00,$89,$02,$02,$00   ........
L12D0    fcb   $8B,$03,$02,$00,$8D,$8B,$3F,$00   ......?.
L12D8    fcb   $03,$2F,$C7,$DE,$94,$14,$4B,$5E   ./G^..K^
L12E0    fcb   $83,$96,$39,$17,$DB,$9F,$56,$D1   ..9.[.VQ
L12E8    fcb   $09,$71,$7B,$B1,$66,$17,$0F,$A0   .q{1f.. 
L12F0    fcb   $F3,$17,$0D,$8D,$52,$F4,$65,$49   s...RteI
L12F8    fcb   $77,$47,$CE,$B5,$86,$5F,$99,$16   wGN5._..
L1300    fcb   $C2,$B3,$90,$14,$07,$58,$66,$49   B3...XfI
L1308    fcb   $2E,$04,$0B,$0B,$09,$0A,$01,$02   ........
L1310    fcb   $00,$8A,$03,$02,$00,$8C,$8C,$44   .......D
L1318    fcb   $00,$03,$2F,$63,$BE,$CB,$B5,$C3   ../c>K5C
L1320    fcb   $B5,$39,$17,$8E,$C5,$39,$17,$DB   59..E9.[
L1328    fcb   $9F,$56,$D1,$0A,$71,$7A,$79,$F3   .VQ.qzys
L1330    fcb   $17,$0D,$8D,$56,$F4,$DB,$72,$16   ...Vt[r.
L1338    fcb   $A0,$51,$DB,$F0,$A4,$91,$7A,$D5    Q[p$.zU
L1340    fcb   $15,$89,$17,$82,$17,$59,$5E,$66   .....Y^f
L1348    fcb   $62,$2E,$04,$10,$0B,$0E,$0A,$05   b.......
L1350    fcb   $07,$0D,$05,$08,$08,$19,$87,$0C   ........
L1358    fcb   $04,$02,$00,$8B,$8D,$4D,$00,$03   .....M..
L1360    fcb   $3D,$C7,$DE,$94,$14,$4B,$5E,$83   =G^..K^.
L1368    fcb   $96,$DF,$16,$96,$BE,$45,$5E,$4F   ._..>E^O
L1370    fcb   $72,$74,$4D,$56,$F4,$F4,$72,$4B   rtMVttrK
L1378    fcb   $5E,$C3,$B5,$3B,$16,$B7,$B1,$94   ^C5;.71.
L1380    fcb   $AF,$3F,$A0,$89,$17,$82,$17,$50   /? ....P
L1388    fcb   $5E,$BE,$A0,$03,$71,$33,$98,$52   ^> .q3.R
L1390    fcb   $45,$65,$49,$77,$47,$89,$17,$82   EeIwG...
L1398    fcb   $17,$59,$5E,$66,$62,$2E,$04,$0B   .Y^fb...
L13A0    fcb   $0B,$09,$0A,$04,$02,$00,$8A,$01   ........
L13A8    fcb   $02,$00,$8E,$8E,$80,$A2,$00,$03   ....."..
L13B0    fcb   $3B,$C7,$DE,$94,$14,$4B,$5E,$83   ;G^..K^.
L13B8    fcb   $96,$3B,$16,$B7,$B1,$39,$17,$DB   .;.719.[
L13C0    fcb   $9F,$23,$D1,$13,$54,$E7,$B8,$0D   .#Q.Tg8.
L13C8    fcb   $8D,$B8,$16,$FF,$14,$1B,$53,$91   .8....S.
L13D0    fcb   $7A,$56,$15,$5A,$62,$56,$F4,$F4   zV.ZbVtt
L13D8    fcb   $72,$43,$5E,$5B,$B1,$23,$63,$0B   rC^[1#c.
L13E0    fcb   $C0,$04,$9A,$53,$BE,$8E,$48,$61   @..S>.Ha
L13E8    fcb   $17,$82,$C6,$2E,$04,$62,$0B,$60   ..F..b.`
L13F0    fcb   $0A,$02,$02,$00,$8D,$01,$59,$0E   ......Y.
L13F8    fcb   $57,$0D,$1D,$01,$1E,$20,$1D,$04   W.... ..
L1400    fcb   $17,$5F,$BE,$73,$15,$C1,$B1,$3F   ._>s.A1?
L1408    fcb   $DE,$B6,$14,$5D,$9E,$D6,$B5,$DB   ^6.].V5[
L1410    fcb   $72,$1B,$D0,$99,$16,$C2,$B3,$2E   r.P..B3.
L1418    fcb   $0D,$34,$20,$1D,$01,$0A,$17,$0A   .4 .....
L1420    fcb   $00,$17,$1E,$8E,$04,$28,$5F,$BE   .....(_>
L1428    fcb   $73,$15,$C1,$B1,$3F,$DE,$E1,$14   s.A1?^a.
L1430    fcb   $35,$92,$89,$17,$43,$16,$5B,$66   5...C.[f
L1438    fcb   $8E,$48,$FF,$15,$ED,$93,$09,$15   .H..m...
L1440    fcb   $03,$D2,$6B,$BF,$89,$4E,$8B,$54   .Rk?.N.T
L1448    fcb   $C7,$DE,$99,$AF,$39,$4A,$00,$8F   G^./9J..
L1450    fcb   $8F,$3A,$00,$03,$2E,$63,$BE,$CB   .:...c>K
L1458    fcb   $B5,$C3,$B5,$7B,$17,$F3,$8C,$01   5C5{.s..
L1460    fcb   $B3,$45,$90,$40,$49,$F3,$5F,$C3   3E.@Is_C
L1468    fcb   $9E,$09,$BA,$5B,$98,$56,$D1,$03   ..:[.VQ.
L1470    fcb   $71,$5B,$17,$BE,$98,$47,$5E,$96   q[.>.G^.
L1478    fcb   $D7,$89,$17,$82,$17,$55,$5E,$36   W....U^6
L1480    fcb   $A1,$9B,$76,$04,$07,$0B,$05,$0A   !.v.....
L1488    fcb   $02,$02,$00,$8E,$90,$80,$A2,$00   ......".
L1490    fcb   $03,$56,$C7,$DE,$94,$14,$43,$5E   .VG^..C^
L1498    fcb   $16,$BC,$DB,$72,$04,$9A,$53,$BE   .<[r..S>
L14A0    fcb   $8E,$61,$B8,$16,$82,$17,$49,$5E   .a8...I^
L14A8    fcb   $63,$B1,$05,$BC,$9E,$61,$CE,$B0   c1.<.aN0
L14B0    fcb   $9B,$15,$11,$8D,$5F,$4A,$3A,$15   ...._J:.
L14B8    fcb   $8D,$7B,$3A,$15,$66,$7B,$D0,$15   .{:.f{P.
L14C0    fcb   $82,$17,$47,$5E,$66,$49,$90,$14   ..G^fI..
L14C8    fcb   $19,$58,$66,$62,$F3,$17,$0D,$8D   .Xfbs...
L14D0    fcb   $56,$F4,$F4,$72,$4B,$5E,$C3,$B5   VttrK^C5
L14D8    fcb   $09,$15,$A3,$A0,$03,$A0,$5F,$BE   ..# . _>
L14E0    fcb   $99,$16,$C2,$B3,$F3,$17,$17,$8D   ..B3s...
L14E8    fcb   $04,$47,$0B,$45,$0A,$02,$02,$00   .G.E....
L14F0    fcb   $89,$03,$02,$00,$A0,$01,$36,$0E   .... .6.
L14F8    fcb   $34,$0D,$14,$01,$1B,$04,$10,$5F   4......_
L1500    fcb   $BE,$09,$15,$A3,$A0,$89,$4E,$A5   >..# .N%
L1508    fcb   $54,$DB,$16,$D3,$B9,$BF,$6C,$0D   T[.S9?l.
L1510    fcb   $1C,$00,$91,$17,$1B,$91,$04,$12   ........
L1518    fcb   $5F,$BE,$09,$15,$A3,$A0,$C9,$54   _>..# IT
L1520    fcb   $B5,$B7,$AF,$14,$90,$73,$1B,$58   57/..s.X
L1528    fcb   $3F,$A1,$17,$1C,$00,$04,$02,$00   ?!......
L1530    fcb   $92,$91,$80,$8F,$00,$03,$22,$C7   ......"G
L1538    fcb   $DE,$94,$14,$4B,$5E,$83,$96,$CB   ^..K^..K
L1540    fcb   $17,$4E,$C5,$FB,$17,$53,$BE,$4E   .NE..S>N
L1548    fcb   $45,$31,$49,$46,$5E,$44,$A0,$89   E1IF^D .
L1550    fcb   $17,$82,$17,$55,$5E,$36,$A1,$9B   ...U^6!.
L1558    fcb   $76,$04,$68,$0B,$66,$0A,$02,$2F   v.h.f../
L1560    fcb   $0E,$2D,$0D,$10,$01,$1B,$04,$0C   .-......
L1568    fcb   $5F,$BE,$09,$15,$A3,$A0,$4B,$7B   _>..# K{
L1570    fcb   $2F,$B8,$9B,$C1,$0D,$19,$00,$90   /8.A....
L1578    fcb   $17,$1B,$90,$04,$0F,$5F,$BE,$09   ....._>.
L1580    fcb   $15,$A3,$A0,$C9,$54,$B5,$B7,$89   .# IT57.
L1588    fcb   $14,$D0,$47,$2E,$17,$1C,$00,$11   .PG.....
L1590    fcb   $32,$0E,$30,$0D,$10,$08,$1C,$04   2.0.....
L1598    fcb   $0C,$8D,$7B,$8E,$14,$63,$B1,$FB   ..{..c1.
L15A0    fcb   $5C,$5F,$A0,$1B,$9C,$0D,$1C,$08   \_ .....
L15A8    fcb   $1B,$17,$1C,$91,$17,$1B,$00,$04   ........
L15B0    fcb   $12,$64,$B7,$B7,$C6,$B0,$C6,$D6   .d77F0FV
L15B8    fcb   $6A,$DB,$72,$81,$5B,$91,$AF,$F0   j[r.[./p
L15C0    fcb   $A4,$5B,$BB,$92,$4B,$00,$03,$3B   $[;.K..;
L15C8    fcb   $C7,$DE,$94,$14,$43,$5E,$16,$BC   G^..C^.<
L15D0    fcb   $DB,$72,$9E,$61,$D0,$B0,$9B,$53   [r.aP0.S
L15D8    fcb   $6B,$BF,$4E,$45,$11,$A0,$FB,$14   k?NE. ..
L15E0    fcb   $4B,$B2,$70,$C0,$6E,$98,$FA,$17   K2p@n.z.
L15E8    fcb   $DA,$78,$3F,$16,$0D,$47,$F7,$17   Zx?..Gw.
L15F0    fcb   $17,$BA,$82,$17,$2F,$62,$D5,$15   .:../bU.
L15F8    fcb   $7B,$14,$55,$A4,$09,$B7,$47,$5E   {.U$.7G^
L1600    fcb   $66,$49,$2E,$04,$0B,$0B,$09,$0A   fI......
L1608    fcb   $03,$02,$00,$90,$04,$02,$00,$93   ........
L1610    fcb   $93,$22,$00,$03,$12,$C7,$DE,$94   ."...G^.
L1618    fcb   $14,$4B,$5E,$96,$96,$DB,$72,$54   .K^..[rT
L1620    fcb   $59,$D6,$83,$98,$C5,$57,$61,$04   YV..EWa.
L1628    fcb   $0B,$0B,$09,$0A,$03,$02,$00,$92   ........
L1630    fcb   $04,$02,$00,$94,$94,$58,$00,$03   .....X..
L1638    fcb   $3B,$C7,$DE,$94,$14,$43,$5E,$16   ;G^..C^.
L1640    fcb   $BC,$DB,$72,$9E,$61,$D0,$B0,$9B   <[r.aP0.
L1648    fcb   $53,$6B,$BF,$4E,$45,$11,$A0,$FB   Sk?NE. .
L1650    fcb   $14,$4B,$B2,$70,$C0,$6E,$98,$FA   .K2p@n.z
L1658    fcb   $17,$DA,$78,$3F,$16,$0D,$47,$23   .Zx?..G#
L1660    fcb   $15,$17,$BA,$82,$17,$2F,$62,$D5   ..:../bU
L1668    fcb   $15,$7B,$14,$55,$A4,$09,$B7,$59   .{.U$.7Y
L1670    fcb   $5E,$66,$62,$2E,$04,$18,$0B,$16   ^fb.....
L1678    fcb   $0A,$03,$02,$00,$93,$04,$0F,$0E   ........
L1680    fcb   $0D,$0D,$09,$20,$1D,$03,$00,$16   ... ....
L1688    fcb   $17,$15,$95,$0C,$00,$95,$95,$32   .......2
L1690    fcb   $00,$03,$20,$C7,$DE,$94,$14,$4B   .. G^..K
L1698    fcb   $5E,$83,$96,$3B,$16,$B7,$B1,$39   ^..;.719
L16A0    fcb   $17,$DB,$9F,$56,$D1,$03,$71,$5B   .[.VQ.q[
L16A8    fcb   $17,$BE,$98,$47,$5E,$96,$D7,$23   .>.G^.W#
L16B0    fcb   $15,$17,$BA,$04,$0D,$0B,$0B,$0A   ..:.....
L16B8    fcb   $36,$01,$8F,$17,$01,$8F,$03,$02   6.......
L16C0    fcb   $00,$94,$96,$30,$00,$03,$18,$C7   ...0...G
L16C8    fcb   $DE,$94,$14,$4B,$5E,$83,$96,$FF   ^..K^...
L16D0    fcb   $14,$97,$9A,$FB,$14,$4B,$B2,$4F   .....K2O
L16D8    fcb   $59,$0C,$A3,$91,$C5,$FF,$8B,$04   Y.#.E...
L16E0    fcb   $13,$0B,$11,$0A,$01,$02,$00,$A3   .......#
L16E8    fcb   $02,$02,$00,$A4,$04,$02,$00,$97   ...$....
L16F0    fcb   $03,$02,$00,$A4,$97,$30,$00,$03   ...$.0..
L16F8    fcb   $18,$C7,$DE,$94,$14,$4B,$5E,$83   .G^..K^.
L1700    fcb   $96,$FB,$14,$4B,$B2,$F0,$59,$9B   ...K2pY.
L1708    fcb   $B7,$4F,$59,$0C,$A3,$91,$C5,$FF   7OY.#.E.
L1710    fcb   $8B,$04,$13,$0B,$11,$0A,$01,$02   ........
L1718    fcb   $00,$A2,$02,$02,$00,$96,$03,$02   ."......
L1720    fcb   $00,$A3,$04,$02,$00,$98,$98,$40   .#.....@
L1728    fcb   $00,$03,$28,$6C,$BE,$29,$A1,$16   ..(l>)!.
L1730    fcb   $71,$DB,$72,$F0,$81,$BF,$6D,$51   q[rp.?mQ
L1738    fcb   $18,$55,$C2,$1B,$60,$5F,$BE,$23   .UB.`_>#
L1740    fcb   $15,$F3,$B9,$0E,$D0,$11,$8A,$83   .s9.P...
L1748    fcb   $64,$84,$15,$96,$5F,$7F,$17,$E6   d..._.f
L1750    fcb   $93,$DB,$63,$04,$13,$0B,$11,$0A   .[c.....
L1758    fcb   $01,$02,$00,$9B,$02,$02,$00,$99   ........
L1760    fcb   $03,$02,$00,$97,$04,$02,$00,$9E   ........
L1768    fcb   $99,$44,$00,$03,$2C,$83,$7A,$45   .D..,.zE
L1770    fcb   $45,$E3,$8B,$10,$B2,$C4,$6A,$59   Ec..2DjY
L1778    fcb   $60,$5B,$B1,$C7,$DE,$66,$17,$8E   `[1G^f..
L1780    fcb   $48,$D6,$B5,$DB,$72,$47,$B9,$53   HV5[rG9S
L1788    fcb   $BE,$0E,$D0,$11,$8A,$83,$64,$84   >.P...d.
L1790    fcb   $15,$96,$5F,$7F,$17,$E6,$93,$DB   .._.f.[
L1798    fcb   $63,$04,$13,$0B,$11,$0A,$01,$02   c.......
L17A0    fcb   $00,$9F,$02,$02,$00,$96,$03,$02   ........
L17A8    fcb   $00,$98,$04,$02,$00,$9A,$9A,$59   .......Y
L17B0    fcb   $00,$03,$41,$6C,$BE,$29,$A1,$16   ..Al>)!.
L17B8    fcb   $71,$DB,$72,$F0,$59,$9B,$B7,$8E   q[rpY.7.
L17C0    fcb   $C5,$31,$62,$09,$B3,$76,$BE,$51   E1b.3v>Q
L17C8    fcb   $18,$45,$C2,$83,$48,$A7,$B7,$82   .EB.H'7.
L17D0    fcb   $17,$49,$5E,$63,$B1,$04,$BC,$00   .I^c1.<.
L17D8    fcb   $B3,$5B,$E3,$16,$6C,$4B,$62,$03   3[c.lKb.
L17E0    fcb   $A0,$5F,$BE,$F7,$17,$F3,$B9,$0E    _>w.s9.
L17E8    fcb   $D0,$11,$8A,$96,$64,$DB,$72,$EF   P...d[ro
L17F0    fcb   $BD,$FF,$A5,$2E,$04,$13,$0B,$11   =.%.....
L17F8    fcb   $0A,$01,$02,$00,$9B,$02,$02,$00   ........
L1800    fcb   $99,$03,$02,$00,$9C,$04,$02,$00   ........
L1808    fcb   $A4,$9B,$4D,$00,$03,$35,$6C,$BE   $.M..5l>
L1810    fcb   $29,$A1,$03,$71,$73,$15,$0B,$A3   )!.qs..#
L1818    fcb   $96,$96,$DB,$72,$F0,$81,$BF,$6D   ..[rp.?m
L1820    fcb   $51,$18,$45,$C2,$83,$48,$A7,$B7   Q.EB.H'7
L1828    fcb   $82,$17,$50,$5E,$BE,$A0,$19,$71   ..P^> .q
L1830    fcb   $46,$48,$B8,$16,$7B,$14,$89,$91   FH8.{...
L1838    fcb   $08,$99,$D7,$78,$B3,$9A,$EF,$BD   ..Wx3.o=
L1840    fcb   $FF,$A5,$2E,$04,$13,$0B,$11,$0A   .%......
L1848    fcb   $01,$02,$00,$A2,$02,$02,$00,$9D   ..."....
L1850    fcb   $04,$02,$00,$9A,$03,$02,$00,$98   ........
L1858    fcb   $9C,$3A,$00,$03,$26,$C7,$DE,$94   .:..&G^.
L1860    fcb   $14,$55,$5E,$50,$BD,$90,$5A,$C4   .U^P=.ZD
L1868    fcb   $6A,$59,$60,$5B,$B1,$5F,$BE,$F7   jY`[1_>w
L1870    fcb   $17,$F3,$B9,$9E,$61,$D0,$B0,$9B   .s9.aP0.
L1878    fcb   $53,$C3,$9E,$5F,$BE,$7F,$17,$E6   SC._>.f
L1880    fcb   $93,$DB,$63,$04,$0F,$0B,$0D,$0A   .[c.....
L1888    fcb   $01,$02,$00,$9D,$02,$02,$00,$9F   ........
L1890    fcb   $04,$02,$00,$9A,$9D,$80,$B3,$00   ......3.
L1898    fcb   $03,$12,$C7,$DE,$94,$14,$43,$5E   ..G^..C^
L18A0    fcb   $16,$BC,$DB,$72,$04,$9A,$53,$BE   .<[r..S>
L18A8    fcb   $0E,$D0,$9B,$8F,$04,$80,$9B,$0B   .P......
L18B0    fcb   $80,$98,$0A,$01,$02,$00,$9B,$03   ........
L18B8    fcb   $02,$00,$9E,$17,$80,$88,$0D,$80   ........
L18C0    fcb   $85,$08,$21,$0E,$80,$80,$0D,$54   ..!....T
L18C8    fcb   $05,$7F,$04,$2A,$C7,$DE,$DE,$14   ..*G^^.
L18D0    fcb   $64,$7A,$89,$17,$82,$17,$54,$5E   dz....T^
L18D8    fcb   $38,$A0,$3B,$F4,$4B,$49,$C7,$DE   8 ;tKIG^
L18E0    fcb   $66,$17,$D3,$61,$03,$A0,$5F,$BE   f.Sa. _>
L18E8    fcb   $39,$17,$E6,$9E,$D6,$15,$E1,$14   9.f.V.a.
L18F0    fcb   $FB,$8C,$17,$A7,$5B,$BB,$17,$36   ...'[;.6
L18F8    fcb   $00,$17,$29,$FF,$17,$2A,$FF,$17   ..)..*..
L1900    fcb   $2B,$FF,$17,$2C,$FF,$17,$2D,$FF   +..,..-.
L1908    fcb   $17,$2E,$FF,$17,$31,$FF,$17,$34   ....1..4
L1910    fcb   $FF,$17,$35,$FF,$17,$3A,$FF,$17   ..5..:..
L1918    fcb   $3C,$00,$00,$81,$04,$28,$4B,$49   <....(KI
L1920    fcb   $C7,$DE,$DE,$14,$64,$7A,$16,$EE   G^^.dz.n
L1928    fcb   $DB,$72,$10,$CB,$49,$5E,$CF,$7B   [r.KI^O{
L1930    fcb   $D9,$B5,$3B,$4A,$8E,$48,$51,$18   Y5;J.HQ.
L1938    fcb   $48,$C2,$46,$48,$89,$17,$82,$17   HBFH....
L1940    fcb   $49,$5E,$07,$B3,$57,$98,$04,$02   I^.3W...
L1948    fcb   $00,$9C,$9E,$25,$00,$03,$11,$C7   ...%...G
L1950    fcb   $DE,$94,$14,$43,$5E,$16,$BC,$DB   ^..C^.<[
L1958    fcb   $72,$95,$5F,$19,$BC,$46,$48,$2E   r._.<FH.
L1960    fcb   $04,$0F,$0B,$0D,$0A,$01,$02,$00   ........
L1968    fcb   $9D,$02,$02,$00,$9F,$03,$02,$00   ........
L1970    fcb   $98,$9F,$26,$00,$03,$12,$C7,$DE   ..&...G^
L1978    fcb   $94,$14,$43,$5E,$16,$BC,$DB,$72   ..C^.<[r
L1980    fcb   $47,$B9,$53,$BE,$0E,$D0,$9B,$8F   G9S>.P..
L1988    fcb   $04,$0F,$0B,$0D,$0A,$04,$02,$00   ........
L1990    fcb   $9C,$03,$02,$00,$9E,$02,$02,$00   ........
L1998    fcb   $99,$A0,$20,$00,$03,$14,$C7,$DE   .  ...G^
L19A0    fcb   $94,$14,$4B,$5E,$83,$96,$CF,$17   ..K^..O.
L19A8    fcb   $7B,$B4,$E3,$B8,$F3,$8C,$01,$B3   {4c8s..3
L19B0    fcb   $DB,$95,$04,$07,$0B,$05,$0A,$04   [.......
L19B8    fcb   $02,$00,$90,$A1,$2C,$00,$03,$20   ...!,.. 
L19C0    fcb   $C7,$DE,$94,$14,$4B,$5E,$83,$96   G^..K^..
L19C8    fcb   $5F,$17,$46,$48,$39,$17,$DB,$9F   _.FH9.[.
L19D0    fcb   $56,$D1,$03,$71,$5B,$17,$BE,$98   VQ.q[.>.
L19D8    fcb   $47,$5E,$96,$D7,$23,$15,$17,$BA   G^.W#..:
L19E0    fcb   $04,$07,$0B,$05,$0A,$03,$02,$00   ........
L19E8    fcb   $84,$A2,$30,$00,$03,$18,$C7,$DE   ."0...G^
L19F0    fcb   $94,$14,$4B,$5E,$83,$96,$FB,$14   ..K^....
L19F8    fcb   $4B,$B2,$4F,$59,$06,$A3,$9D,$61   K2OY.#.a
L1A00    fcb   $4C,$5E,$91,$C5,$FF,$8B,$04,$13   L^.E....
L1A08    fcb   $0B,$11,$0A,$03,$02,$00,$A4,$01   ......$.
L1A10    fcb   $02,$00,$96,$02,$02,$00,$A3,$04   ......#.
L1A18    fcb   $02,$00,$97,$A3,$30,$00,$03,$18   ...#0...
L1A20    fcb   $C7,$DE,$94,$14,$4B,$5E,$83,$96   G^..K^..
L1A28    fcb   $FF,$14,$97,$9A,$FB,$14,$D3,$93   ......S.
L1A30    fcb   $54,$59,$CC,$83,$91,$C5,$FF,$8B   TYL..E..
L1A38    fcb   $04,$13,$0B,$11,$0A,$03,$02,$00   ........
L1A40    fcb   $A4,$01,$02,$00,$A2,$02,$02,$00   $..."...
L1A48    fcb   $96,$04,$02,$00,$97,$A4,$30,$00   .....$0.
L1A50    fcb   $03,$18,$C7,$DE,$94,$14,$4B,$5E   ..G^..K^
L1A58    fcb   $83,$96,$FB,$14,$D3,$93,$54,$59   ....S.TY
L1A60    fcb   $C6,$83,$9D,$61,$4C,$5E,$91,$C5   F..aL^.E
L1A68    fcb   $FF,$8B,$04,$13,$0B,$11,$0A,$03   ........
L1A70    fcb   $02,$00,$A3,$01,$02,$00,$A2,$02   ..#...".
L1A78    fcb   $02,$00,$96,$04,$02,$00,$A3,$A5   ......#%
L1A80    fcb   $2C,$00,$03,$20,$C7,$DE,$94,$14   ,.. G^..
L1A88    fcb   $4B,$5E,$96,$96,$DB,$72,$A5,$B7   K^..[r%7
L1A90    fcb   $76,$B1,$DB,$16,$D3,$B9,$9B,$6C   v1[.S9.l
L1A98    fcb   $23,$D1,$13,$54,$E3,$8B,$0B,$5C   #Q.Tc..\
L1AA0    fcb   $95,$5F,$9B,$C1,$04,$07,$0B,$05   ._.A....
L1AA8    fcb   $0A,$03,$02,$00,$A6,$A6,$50,$00   ....&&P.
L1AB0    fcb   $03,$2C,$C7,$DE,$94,$14,$43,$5E   .,G^..C^
L1AB8    fcb   $16,$BC,$DB,$72,$8E,$61,$B8,$16   .<[r.a8.
L1AC0    fcb   $82,$17,$52,$5E,$65,$49,$77,$47   ..R^eIwG
L1AC8    fcb   $56,$F4,$F4,$72,$4B,$5E,$C3,$B5   VttrK^C5
L1AD0    fcb   $A9,$15,$DB,$8B,$83,$7A,$5F,$BE   ).[..z_>
L1AD8    fcb   $D7,$14,$43,$7A,$CF,$98,$04,$1F   W.CzO...
L1AE0    fcb   $0B,$1D,$0A,$04,$02,$00,$A5,$17   ......%.
L1AE8    fcb   $05,$0D,$03,$08,$2C,$91,$36,$05   ....,.6.
L1AF0    fcb   $0D,$03,$08,$2C,$91,$37,$05,$0D   ...,.7..
L1AF8    fcb   $03,$08,$2C,$91,$33,$01,$91,$00   ..,.3...
L1B00    fcb   $91,$3A,$01,$03,$00,$00,$00,$03   .:......
L1B08    fcb   $03,$00,$00,$00,$06,$48,$82,$00   .....H..
L1B10    fcb   $80,$02,$02,$E9,$B3,$07,$3F,$0B   ...i3.?.
L1B18    fcb   $3D,$0A,$0C,$01,$8C,$36,$01,$8A   =....6..
L1B20    fcb   $33,$01,$8A,$34,$01,$8A,$35,$01   3..4..5.
L1B28    fcb   $8B,$2D,$01,$8C,$26,$28,$04,$26   .-..&(.&
L1B30    fcb   $C7,$DE,$D3,$14,$E6,$96,$16,$EE   G^S.f..n
L1B38    fcb   $DB,$72,$E9,$B3,$66,$17,$76,$B1   [ri3f.v1
L1B40    fcb   $1F,$54,$C3,$B5,$F3,$8C,$5F,$BE   .TC5s._>
L1B48    fcb   $F3,$17,$43,$DB,$B9,$55,$CB,$B9   s.C[9UK9
L1B50    fcb   $5F,$BE,$39,$17,$FF,$9F,$09,$5E   _>9....^
L1B58    fcb   $82,$00,$84,$02,$03,$81,$5B,$52   ......[R
L1B60    fcb   $07,$54,$0E,$52,$0D,$22,$0A,$08   .T.R."..
L1B68    fcb   $04,$1E,$5F,$BE,$D3,$14,$13,$B4   .._>S..4
L1B70    fcb   $C5,$98,$C0,$16,$82,$17,$46,$5E   E.@...F^
L1B78    fcb   $44,$A0,$53,$17,$B3,$E0,$49,$1B   D S.3`I.
L1B80    fcb   $99,$16,$07,$BC,$BF,$9A,$1C,$B5   ...<?..5
L1B88    fcb   $0D,$2C,$14,$0A,$0B,$04,$27,$C7   .,....'G
L1B90    fcb   $DE,$C6,$22,$9B,$15,$5B,$CA,$6B   ^F"..[Jk
L1B98    fcb   $BF,$2B,$6E,$6B,$BF,$5F,$BE,$23   ?+nk?_>#
L1BA0    fcb   $15,$F3,$B9,$46,$B8,$51,$5E,$96   .s9F8Q^.
L1BA8    fcb   $64,$DB,$72,$01,$B3,$56,$90,$C6   d[r.3V.F
L1BB0    fcb   $9C,$D6,$9C,$56,$72,$2E,$0C,$2A   .V.Vr..*
L1BB8    fcb   $84,$00,$A0,$03,$0D,$5F,$BE,$5B   .. .._>[
L1BC0    fcb   $B1,$4B,$7B,$01,$68,$0A,$58,$2F   1K{.h.X/
L1BC8    fcb   $62,$2E,$07,$11,$0D,$0F,$0A,$15   b.......
L1BD0    fcb   $04,$04,$F4,$4F,$AB,$A2,$17,$05   ..tO+"..
L1BD8    fcb   $00,$1C,$1D,$23,$0F,$02,$03,$01   ...#....
L1BE0    fcb   $68,$44,$0D,$2A,$88,$00,$80,$02   hD.*....
L1BE8    fcb   $04,$FB,$B9,$67,$C0,$07,$05,$0D   ..9g@...
L1BF0    fcb   $03,$0A,$12,$8D,$03,$18,$5F,$BE   ......_>
L1BF8    fcb   $66,$17,$8F,$49,$4B,$5E,$C8,$B5   f..IK^H5
L1C00    fcb   $DB,$46,$AB,$98,$5F,$BE,$23,$15   [F+._>#.
L1C08    fcb   $F3,$B9,$81,$5B,$1B,$B5,$0D,$2A   s9.[.5.*
L1C10    fcb   $00,$00,$80,$02,$04,$FB,$B9,$67   ......9g
L1C18    fcb   $C0,$07,$05,$0D,$03,$0A,$12,$8D   @.......
L1C20    fcb   $03,$18,$5F,$BE,$66,$17,$8F,$49   .._>f..I
L1C28    fcb   $4B,$5E,$C8,$B5,$DB,$46,$AB,$98   K^H5[F+.
L1C30    fcb   $5F,$BE,$F7,$17,$F3,$B9,$81,$5B   _>w.s9.[
L1C38    fcb   $1B,$B5,$12,$44,$8C,$05,$A4,$03   .5.D..$.
L1C40    fcb   $14,$54,$45,$91,$7A,$B8,$16,$53   .TE.z8.S
L1C48    fcb   $15,$75,$98,$09,$BC,$BE,$9F,$D5   .u..<>.U
L1C50    fcb   $15,$9F,$15,$7F,$B1,$02,$06,$3E   ...1..>
L1C58    fcb   $6E,$14,$58,$91,$7A,$07,$21,$0D   n.X.z.!.
L1C60    fcb   $1F,$0A,$08,$04,$1B,$5F,$BE,$D0   ....._>P
L1C68    fcb   $15,$64,$B7,$EE,$7A,$C0,$7A,$2F   .d7nz@z/
L1C70    fcb   $17,$0D,$47,$FC,$ED,$10,$B2,$D1   ..G.m.2Q
L1C78    fcb   $6A,$8F,$64,$03,$A1,$27,$A0,$22   j.d.!' "
L1C80    fcb   $0E,$42,$A1,$00,$E4,$03,$19,$5F   .B!.d.._
L1C88    fcb   $BE,$5B,$B1,$4B,$7B,$4E,$45,$31   >[1K{NE1
L1C90    fcb   $49,$55,$5E,$44,$D2,$0E,$58,$4B   IU^DR.XK
L1C98    fcb   $4A,$AB,$98,$63,$98,$03,$B1,$2E   J+.c..1.
L1CA0    fcb   $07,$18,$0D,$16,$0A,$08,$04,$12   ........
L1CA8    fcb   $2C,$1D,$5F,$A0,$D3,$B3,$B8,$16   ,._ S38.
L1CB0    fcb   $43,$16,$57,$63,$28,$54,$BD,$5F   C.Wc(T=_
L1CB8    fcb   $23,$BC,$02,$08,$54,$8B,$9B,$6C   #<..T..l
L1CC0    fcb   $81,$BA,$33,$B1,$0F,$6B,$8E,$00   .:31.k..
L1CC8    fcb   $80,$03,$34,$5F,$BE,$5B,$B1,$4B   ..4_>[1K
L1CD0    fcb   $7B,$4A,$45,$FF,$78,$35,$A1,$66   {JE.x5!f
L1CD8    fcb   $17,$0F,$A0,$73,$15,$C1,$B1,$3F   .. s.A1?
L1CE0    fcb   $DE,$DF,$16,$1A,$B1,$F3,$5F,$03   ^_..1s_.
L1CE8    fcb   $A0,$4E,$45,$01,$60,$43,$5E,$08    NE.`C^.
L1CF0    fcb   $4F,$56,$5E,$DB,$72,$04,$9A,$53   OV^[r..S
L1CF8    fcb   $BE,$55,$A4,$09,$B7,$DB,$63,$07   >U$.7[c.
L1D00    fcb   $24,$0D,$22,$0A,$0B,$04,$1E,$5F   $."...._
L1D08    fcb   $BE,$5B,$B1,$EA,$48,$94,$5F,$D6   >[1jH._V
L1D10    fcb   $B5,$C4,$9C,$46,$5E,$07,$B2,$04   5D.F^.2.
L1D18    fcb   $58,$81,$8D,$11,$58,$8A,$96,$4B   X...X..K
L1D20    fcb   $7B,$BB,$54,$C9,$D2,$02,$0A,$09   {;TIR...
L1D28    fcb   $BA,$5B,$98,$14,$6C,$4B,$6E,$DB   :[..lKn[
L1D30    fcb   $8B,$22,$58,$95,$00,$80,$03,$32   ."X....2
L1D38    fcb   $68,$4D,$AF,$A0,$51,$18,$55,$C2   hM/ Q.UB
L1D40    fcb   $50,$BD,$0B,$5C,$83,$48,$4E,$48   P=.\.HNH
L1D48    fcb   $46,$49,$66,$17,$D0,$47,$F3,$5F   FIf.PGs_
L1D50    fcb   $56,$D1,$16,$71,$DB,$72,$89,$4E   VQ.q[r.N
L1D58    fcb   $73,$9E,$C3,$9E,$47,$55,$C6,$9A   s.C.GUF.
L1D60    fcb   $65,$62,$53,$17,$B3,$55,$05,$67   ebS.3U.g
L1D68    fcb   $6F,$62,$07,$10,$0B,$0E,$0A,$12   ob......
L1D70    fcb   $01,$8E,$0C,$01,$8E,$38,$05,$0D   .....8..
L1D78    fcb   $03,$00,$A5,$90,$02,$0D,$89,$4E   ..%....N
L1D80    fcb   $73,$9E,$FB,$B9,$8F,$7A,$03,$58   s..9.z.X
L1D88    fcb   $3B,$8E,$52,$23,$2F,$95,$05,$A0   ;.R#/.. 
L1D90    fcb   $03,$20,$49,$45,$BE,$9F,$83,$61   . IE>..a
L1D98    fcb   $09,$79,$15,$8A,$50,$BD,$0B,$5C   .y..P=.\
L1DA0    fcb   $83,$7A,$5F,$BE,$D7,$14,$BF,$9A   .z_>W.?.
L1DA8    fcb   $91,$AF,$96,$64,$DB,$72,$01,$B3   ./.d[r.3
L1DB0    fcb   $DB,$95,$02,$08,$3E,$6E,$F0,$59   [...>npY
L1DB8    fcb   $C6,$15,$B3,$9F,$27,$80,$9A,$9C   F.3.'...
L1DC0    fcb   $00,$80,$03,$34,$AF,$6E,$73,$49   ...4/nsI
L1DC8    fcb   $79,$4F,$AF,$9B,$73,$15,$F5,$BD   yO/.s.u=
L1DD0    fcb   $30,$15,$AB,$6E,$66,$CA,$FB,$17   0.+nfJ..
L1DD8    fcb   $53,$BE,$63,$7A,$B5,$6C,$B8,$16   S>cz5l8.
L1DE0    fcb   $57,$17,$1F,$B3,$CD,$9A,$66,$17   W..3M.f.
L1DE8    fcb   $8E,$48,$5B,$17,$F0,$8B,$13,$BF   .H[.p..?
L1DF0    fcb   $AF,$14,$04,$68,$5B,$5E,$3F,$A1   /..h[^?!
L1DF8    fcb   $07,$55,$0B,$53,$0A,$11,$20,$04   .U.S.. .
L1E00    fcb   $1E,$5F,$BE,$73,$15,$F5,$BD,$94   ._>s.u=.
L1E08    fcb   $14,$4E,$5E,$5D,$9E,$16,$60,$51   .N^]..`Q
L1E10    fcb   $18,$45,$C2,$83,$48,$06,$9A,$C2   .EB.H..B
L1E18    fcb   $16,$83,$61,$5F,$BE,$DB,$95,$36   ..a_>[.6
L1E20    fcb   $10,$04,$0E,$5F,$BE,$73,$15,$F5   ..._>s.u
L1E28    fcb   $BD,$94,$14,$45,$5E,$85,$8D,$17   =..E^...
L1E30    fcb   $60,$17,$19,$04,$17,$5F,$BE,$73   `...._>s
L1E38    fcb   $15,$F5,$BD,$94,$14,$56,$5E,$2B   .u=..V^+
L1E40    fcb   $A0,$F1,$B8,$02,$A1,$89,$17,$DE    q8.!..^
L1E48    fcb   $14,$64,$7A,$2E,$34,$01,$89,$02   .dz.4...
L1E50    fcb   $08,$79,$4F,$AF,$9B,$73,$15,$F5   .yO/.s.u
L1E58    fcb   $BD,$16,$59,$91,$00,$A0,$02,$04   =.Y.. ..
L1E60    fcb   $F8,$8B,$23,$62,$03,$16,$44,$45   x.#b..DE
L1E68    fcb   $EF,$60,$AE,$D0,$F3,$5F,$F8,$8B   o`.Ps_x.
L1E70    fcb   $23,$62,$4B,$7B,$03,$A0,$0F,$A0   #bK{. . 
L1E78    fcb   $F3,$17,$17,$8D,$07,$36,$0D,$34   s....6.4
L1E80    fcb   $0A,$12,$04,$2F,$56,$45,$D2,$B0   .../VER0
L1E88    fcb   $09,$15,$A3,$A0,$5F,$A0,$8B,$9A   ..# _ ..
L1E90    fcb   $B9,$46,$5B,$CA,$C7,$DE,$3B,$F4   9F[JG^;t
L1E98    fcb   $3E,$6E,$06,$58,$66,$C6,$53,$15   >n.XfFS.
L1EA0    fcb   $0D,$8D,$82,$17,$54,$5E,$3F,$A0   ....T^? 
L1EA8    fcb   $90,$14,$06,$58,$09,$B3,$8B,$9A   ...X.3..
L1EB0    fcb   $C7,$DE,$2E,$81,$16,$42,$00,$05   G^...B..
L1EB8    fcb   $A0,$03,$12,$44,$45,$EF,$60,$AE    ..DEo`.
L1EC0    fcb   $D0,$F3,$5F,$F8,$8B,$23,$62,$4B   Ps_x.#bK
L1EC8    fcb   $7B,$F4,$72,$DB,$63,$02,$0A,$6C   {tr[c..l
L1ED0    fcb   $4D,$F7,$62,$E6,$8B,$3F,$16,$74   Mwbf.?.t
L1ED8    fcb   $CA,$07,$1D,$0D,$1B,$0A,$12,$04   J.......
L1EE0    fcb   $17,$5F,$BE,$3F,$16,$74,$CA,$D3   ._>?.tJS
L1EE8    fcb   $14,$90,$96,$CE,$9C,$11,$A0,$23   ...N.. #
L1EF0    fcb   $62,$5B,$4D,$6E,$A7,$E6,$8B,$2E   b[Mn'f..
L1EF8    fcb   $18,$80,$C5,$91,$00,$84,$07,$80   ..E.....
L1F00    fcb   $98,$0D,$80,$95,$0A,$08,$04,$80   ........
L1F08    fcb   $90,$9E,$C5,$BE,$9F,$33,$17,$1F   ..E>.3..
L1F10    fcb   $54,$CE,$B5,$1B,$79,$56,$D1,$90   TN5.yVQ.
L1F18    fcb   $73,$2F,$17,$DA,$46,$0A,$EE,$2F   s/.ZF.n/
L1F20    fcb   $62,$D6,$E7,$C3,$9C,$7B,$9B,$19   bVgC.{..
L1F28    fcb   $87,$50,$D1,$33,$70,$98,$8C,$91   .PQ3p...
L1F30    fcb   $7A,$E4,$14,$96,$5F,$2F,$C6,$44   zd.._/FD
L1F38    fcb   $F4,$59,$5E,$43,$49,$82,$17,$29   tY^CI..)
L1F40    fcb   $A1,$73,$76,$EB,$99,$96,$91,$F4   !svk...t
L1F48    fcb   $BD,$FA,$17,$73,$49,$73,$BE,$E4   =z.sIs>d
L1F50    fcb   $14,$26,$60,$16,$EE,$56,$72,$82   .&`.nVr.
L1F58    fcb   $17,$1B,$A1,$54,$72,$75,$98,$C3   ..!Tru.C
L1F60    fcb   $B5,$33,$98,$8F,$8C,$73,$7B,$73   53...s{s
L1F68    fcb   $BE,$E9,$16,$B4,$D0,$EE,$68,$84   >i.4Pnh.
L1F70    fcb   $15,$26,$60,$3B,$F4,$6E,$A7,$16   .&`;tn'.
L1F78    fcb   $8A,$DB,$72,$F8,$8B,$23,$62,$6B   .[rx.#bk
L1F80    fcb   $BF,$0B,$6C,$96,$96,$FB,$75,$A3   ?.l...u#
L1F88    fcb   $D0,$42,$8E,$04,$EE,$52,$5E,$72   PB..nR^r
L1F90    fcb   $B1,$2F,$49,$16,$58,$DF,$9C,$DB   1/I.X_.[
L1F98    fcb   $F9,$03,$1F,$5F,$BE,$5B,$B1,$4B   y.._>[1K
L1FA0    fcb   $7B,$52,$45,$53,$8B,$1B,$C4,$03   {RES..D.
L1FA8    fcb   $A0,$5F,$BE,$F3,$17,$F3,$8C,$B9    _>s.s.9
L1FB0    fcb   $46,$5B,$CA,$5F,$BE,$3F,$16,$74   F[J_>?.t
L1FB8    fcb   $CA,$2E,$02,$04,$FB,$A5,$A7,$AD   J....%'-
L1FC0    fcb   $19,$6F,$92,$00,$A8,$03,$10,$45   .o..(..E
L1FC8    fcb   $45,$8E,$48,$DB,$8B,$4B,$7B,$83   E.H[.K{.
L1FD0    fcb   $7A,$5F,$BE,$39,$17,$FF,$9F,$02   z_>9....
L1FD8    fcb   $04,$10,$53,$FF,$5A,$07,$52,$0B   ..S.Z.R.
L1FE0    fcb   $50,$0A,$14,$34,$0E,$32,$0D,$2F   P..4.2./
L1FE8    fcb   $09,$14,$1E,$11,$12,$04,$28,$5F   ......(_
L1FF0    fcb   $BE,$D3,$14,$46,$98,$4B,$5E,$D0   >S.F.K^P
L1FF8    fcb   $B5,$6B,$A1,$F4,$4F,$10,$99,$33   5k!tO..3
L2000    fcb   $70,$55,$45,$A7,$D0,$15,$BC,$B0   pUE'P.<0
L2008    fcb   $53,$12,$BC,$37,$62,$96,$5F,$4B   S.<7b._K
L2010    fcb   $62,$5F,$BE,$39,$17,$FF,$9F,$88   b_>9....
L2018    fcb   $15,$17,$0D,$15,$04,$12,$55,$BD   ......U=
L2020    fcb   $F5,$BD,$F3,$17,$1E,$DA,$D6,$15   u=s..ZV.
L2028    fcb   $D2,$B5,$55,$9F,$19,$A0,$49,$C6   R5U.. IF
L2030    fcb   $81,$19,$80,$C6,$00,$00,$A8,$03   ...F..(.
L2038    fcb   $12,$45,$45,$8E,$48,$DB,$8B,$4B   .EE.H[.K
L2040    fcb   $7B,$F4,$4F,$10,$99,$C6,$6A,$6E   {tO..Fjn
L2048    fcb   $7A,$DB,$E0,$02,$0A,$F4,$4F,$10   z[`..tO.
L2050    fcb   $99,$C5,$6A,$8E,$48,$DB,$8B,$07   .Ej.H[..
L2058    fcb   $59,$0E,$57,$0D,$1C,$0E,$04,$0A   Y.W.....
L2060    fcb   $13,$0A,$14,$04,$14,$5F,$BE,$D3   ....._>S
L2068    fcb   $14,$46,$98,$4B,$5E,$C3,$B5,$EF   .F.K^C5o
L2070    fcb   $8D,$13,$47,$BF,$14,$D3,$B2,$CF   ..G?.S2O
L2078    fcb   $98,$0D,$19,$0A,$16,$1E,$11,$12   ........
L2080    fcb   $04,$12,$5F,$BE,$D3,$14,$46,$98   .._>S.F.
L2088    fcb   $4B,$5E,$C7,$B5,$43,$D9,$C7,$98   K^G5CYG.
L2090    fcb   $5A,$7B,$17,$60,$0D,$1C,$0A,$15   Z{.`....
L2098    fcb   $04,$18,$C7,$DE,$2F,$17,$46,$48   ..G^/.FH
L20A0    fcb   $55,$DB,$87,$74,$B3,$8B,$76,$A7   U[.t3.v'
L20A8    fcb   $D6,$15,$C7,$16,$08,$BC,$3D,$7B   V.G..<={
L20B0    fcb   $9B,$C1,$08,$46,$0D,$44,$1F,$24   .A.F.D.$
L20B8    fcb   $5F,$BE,$43,$16,$2E,$6D,$5C,$15   _>C..m\.
L20C0    fcb   $DB,$9F,$5F,$BE,$D3,$14,$46,$98   [._>S.F.
L20C8    fcb   $55,$5E,$2F,$60,$D6,$B5,$C4,$9C   U^/`V5D.
L20D0    fcb   $49,$5E,$09,$B3,$91,$7A,$03,$15   I^.3.z..
L20D8    fcb   $67,$93,$1B,$B5,$0B,$1C,$01,$1D   g..5....
L20E0    fcb   $07,$0D,$05,$1C,$1D,$1D,$14,$0C   ........
L20E8    fcb   $1E,$07,$0D,$05,$1C,$1E,$1D,$32   .......2
L20F0    fcb   $0C,$15,$07,$0D,$05,$1C,$15,$1D   ........
L20F8    fcb   $0F,$0C,$18,$80,$84,$92,$00,$84   ........
L2100    fcb   $07,$5B,$0D,$59,$0A,$08,$04,$55   .[.Y...U
L2108    fcb   $9E,$7A,$D6,$9C,$DB,$72,$70,$C0   .zV.[rp@
L2110    fcb   $6E,$98,$30,$15,$F4,$BD,$D6,$B5   n.0.t=V5
L2118    fcb   $DB,$72,$A7,$B7,$B4,$85,$04,$EE   [r'74..n
L2120    fcb   $D8,$B0,$53,$61,$90,$14,$19,$58   X0Sa...X
L2128    fcb   $57,$7B,$FB,$8E,$DB,$72,$37,$6E   W{..[r7n
L2130    fcb   $5B,$BB,$04,$68,$9F,$15,$FB,$17   [;.h....
L2138    fcb   $F3,$8C,$65,$B1,$00,$9F,$6F,$7C   s.e1..o|
L2140    fcb   $82,$17,$54,$5E,$92,$5F,$46,$62   ..T^._Fb
L2148    fcb   $95,$14,$82,$17,$4E,$5E,$7A,$79   ....N^zy
L2150    fcb   $04,$BC,$59,$60,$5B,$B1,$8F,$73   .<Y`[1.s
L2158    fcb   $7E,$15,$85,$A1,$2E,$03,$1C,$5F   ~..!..._
L2160    fcb   $BE,$5B,$B1,$2F,$49,$E4,$14,$EE   >[1/Id.n
L2168    fcb   $DE,$CB,$78,$F0,$B3,$4B,$62,$B9   ^Kxp3Kb9
L2170    fcb   $46,$5B,$CA,$5F,$BE,$8F,$17,$CF   F[J_>..O
L2178    fcb   $99,$9B,$8F,$02,$04,$F0,$B3,$4B   .....p3K
L2180    fcb   $62,$1B,$80,$B5,$A0,$00,$AC,$03   b..5 .,.
L2188    fcb   $14,$5F,$BE,$5B,$B1,$4B,$7B,$44   ._>[1K{D
L2190    fcb   $45,$38,$C6,$91,$7A,$3B,$16,$D3   E8F.z;.S
L2198    fcb   $93,$F4,$72,$DB,$63,$07,$80,$8F   .tr[c...
L21A0    fcb   $0E,$80,$8C,$0D,$1B,$0E,$04,$0A   ........
L21A8    fcb   $13,$0A,$14,$04,$13,$5F,$BE,$3B   ....._>;
L21B0    fcb   $16,$D3,$93,$4B,$7B,$4C,$48,$86   .S.K{LH.
L21B8    fcb   $5F,$44,$DB,$38,$C6,$91,$7A,$2E   _D[8F.z.
L21C0    fcb   $0B,$6D,$0A,$16,$12,$0D,$10,$1E   .m......
L21C8    fcb   $28,$14,$04,$0B,$5F,$BE,$3B,$16   (..._>;.
L21D0    fcb   $D3,$93,$4B,$7B,$36,$A1,$2E,$18   S.K{6!..
L21D8    fcb   $2D,$0D,$2B,$04,$26,$5F,$BE,$3B   -.+.&_>;
L21E0    fcb   $16,$D3,$93,$37,$6E,$D1,$B5,$97   .S.7nQ5.
L21E8    fcb   $C6,$51,$18,$4F,$C2,$66,$C6,$9B   FQ.OBfF.
L21F0    fcb   $15,$5B,$CA,$E4,$B3,$66,$4D,$D6   .[Jd3fMV
L21F8    fcb   $15,$82,$17,$59,$5E,$00,$B3,$D9   ...Y^.3Y
L2200    fcb   $6A,$39,$4A,$1E,$28,$14,$08,$27   j9J.(..'
L2208    fcb   $04,$25,$5F,$BE,$3B,$16,$D3,$93   .%_>;.S.
L2210    fcb   $4B,$7B,$48,$55,$2F,$62,$19,$58   K{HU/b.X
L2218    fcb   $82,$7B,$7B,$17,$D3,$B2,$13,$B8   .{{.S2.8
L2220    fcb   $8E,$48,$51,$18,$45,$C2,$85,$48   .HQ.EB.H
L2228    fcb   $14,$BC,$86,$5F,$D6,$15,$2E,$02   .<._V...
L2230    fcb   $08,$F4,$4F,$10,$99,$CE,$6A,$72   .tO..Njr
L2238    fcb   $48,$24,$81,$C0,$00,$00,$90,$03   H$.@....
L2240    fcb   $1C,$4E,$45,$31,$49,$55,$5E,$3A   .NE1IU^:
L2248    fcb   $62,$9E,$61,$43,$16,$4B,$62,$3B   b.aC.Kb;
L2250    fcb   $55,$E6,$8B,$C0,$16,$82,$17,$48   Uf.@...H
L2258    fcb   $5E,$81,$8D,$1B,$B5,$09,$02,$3C   ^...5..<
L2260    fcb   $3C,$07,$80,$B3,$0B,$80,$B0,$0A   <..3..0.
L2268    fcb   $09,$80,$9A,$0D,$80,$97,$1A,$09   ........
L2270    fcb   $09,$0B,$80,$91,$05,$99,$2B,$0D   ......+.
L2278    fcb   $29,$04,$03,$C7,$DE,$52,$12,$04   )..G^R..
L2280    fcb   $1F,$50,$B8,$CB,$87,$6B,$BF,$5F   .P8K.k?_
L2288    fcb   $BE,$A3,$15,$33,$8E,$83,$7A,$5F   >#.3..z_
L2290    fcb   $BE,$57,$17,$1F,$B3,$B5,$9A,$D5   >W..35.U
L2298    fcb   $B5,$0E,$53,$44,$DB,$93,$9E,$21   5.SD[..!
L22A0    fcb   $1D,$11,$CC,$2E,$0D,$2C,$04,$03   ..L..,..
L22A8    fcb   $C7,$DE,$52,$12,$04,$24,$6C,$BE   G^R..$l>
L22B0    fcb   $85,$A1,$7B,$14,$29,$B8,$B4,$D0   .!{.)84P
L22B8    fcb   $B8,$16,$62,$17,$35,$49,$C3,$B5   8.b.5IC5
L22C0    fcb   $CB,$B5,$09,$BC,$50,$8B,$B5,$53   K5.<P.5S
L22C8    fcb   $B8,$16,$96,$64,$DB,$72,$0E,$D0   8..d[r.P
L22D0    fcb   $AB,$89,$FF,$31,$0D,$2F,$04,$2B   +..1./.+
L22D8    fcb   $5F,$BE,$57,$17,$1F,$B3,$B5,$9A   _>W..35.
L22E0    fcb   $CA,$B5,$86,$5F,$D5,$15,$57,$17   J5._U.W.
L22E8    fcb   $74,$CA,$F3,$5F,$79,$68,$4A,$90   tJs_yhJ.
L22F0    fcb   $4B,$7B,$F6,$4E,$EB,$DA,$4F,$45   K{vNkZOE
L22F8    fcb   $80,$47,$53,$79,$B0,$53,$04,$BC   .GSy0S.<
L2300    fcb   $89,$8D,$21,$1D,$FF,$15,$10,$04   ..!.....
L2308    fcb   $0E,$76,$4D,$F4,$BD,$1B,$16,$F3   .vMt=..s
L2310    fcb   $8C,$73,$7B,$14,$67,$F1,$B9,$08   .s{.gq9.
L2318    fcb   $80,$C4,$0D,$80,$C1,$0E,$3E,$0D   .D..A.>.
L2320    fcb   $32,$14,$01,$1D,$0B,$19,$0A,$04   2.......
L2328    fcb   $04,$21,$04,$00,$00,$03,$04,$21   .!.....!
L2330    fcb   $03,$00,$00,$01,$04,$21,$01,$00   .....!..
L2338    fcb   $00,$02,$04,$21,$02,$00,$00,$1F   ...!....
L2340    fcb   $12,$5F,$BE,$57,$17,$1F,$B3,$B3   ._>W..33
L2348    fcb   $9A,$74,$A7,$27,$BA,$DB,$B5,$1B   .t'':[5.
L2350    fcb   $A1,$8E,$48,$1F,$08,$5F,$BE,$57   !.H.._>W
L2358    fcb   $17,$1F,$B3,$B3,$9A,$0D,$7F,$01   ..33...
L2360    fcb   $1D,$1C,$1D,$0B,$79,$05,$33,$23   ....y.3#
L2368    fcb   $0D,$21,$1F,$1D,$0C,$BA,$17,$7A   .!...:.z
L2370    fcb   $33,$BB,$7B,$A6,$40,$B9,$E1,$14   3;{&@9a.
L2378    fcb   $3D,$C6,$4B,$62,$6C,$BE,$29,$A1   =FKbl>)!
L2380    fcb   $1B,$71,$34,$A1,$CF,$17,$9D,$7A   .q4!O..z
L2388    fcb   $21,$1D,$14,$99,$16,$1F,$14,$0C   !.......
L2390    fcb   $BA,$17,$7A,$33,$BB,$C7,$DE,$09   :.z3;G^.
L2398    fcb   $15,$37,$5A,$A3,$15,$CE,$B5,$91   .7Z#.N5.
L23A0    fcb   $C5,$EB,$5D,$CC,$21,$0D,$1F,$1F   Ek]L!...
L23A8    fcb   $1B,$3B,$55,$0B,$8E,$D2,$B0,$06   .;U..R0.
L23B0    fcb   $79,$43,$DB,$07,$B3,$33,$98,$C7   yC[.33.G
L23B8    fcb   $DE,$90,$14,$05,$58,$1D,$A0,$F3   ^...X. s
L23C0    fcb   $BF,$0D,$56,$21,$1D,$14,$FF,$16   ?.V!....
L23C8    fcb   $1F,$14,$16,$6C,$F4,$72,$CB,$B5   ...ltrK5
L23D0    fcb   $17,$C0,$03,$8C,$04,$68,$90,$14   .@...h..
L23D8    fcb   $96,$14,$45,$BD,$5B,$89,$0A,$15   ..E=[...
L23E0    fcb   $0D,$13,$1F,$0E,$5F,$BE,$57,$17   ...._>W.
L23E8    fcb   $1F,$B3,$B3,$9A,$4B,$7B,$E3,$59   .33.K{cY
L23F0    fcb   $9B,$5D,$1E,$15,$16,$02,$05,$B4   .].....4
L23F8    fcb   $B7,$F0,$A4,$54,$24,$40,$00,$00   7p$T$@..
L2400    fcb   $80,$03,$1A,$4E,$45,$31,$49,$46   ...NE1IF
L2408    fcb   $5E,$86,$5F,$57,$17,$1F,$B3,$B3   ^._W..33
L2410    fcb   $9A,$87,$8C,$D1,$B5,$96,$96,$DB   ...Q5..[
L2418    fcb   $72,$89,$67,$C7,$A0,$07,$15,$0D   r.gG ...
L2420    fcb   $13,$0A,$15,$04,$0F,$A8,$77,$4E   .....(wN
L2428    fcb   $5E,$E6,$A0,$7B,$16,$92,$14,$F6   ^f {...v
L2430    fcb   $A4,$7F,$7B,$21,$02,$08,$E3,$59   ${!..cY
L2438    fcb   $15,$58,$3A,$62,$9E,$61,$1F,$09   .X:b.a..
L2440    fcb   $FF,$00,$80,$02,$04,$50,$72,$0B   .....Pr.
L2448    fcb   $5C,$20,$34,$9C,$05,$A4,$03,$14   \ 4..$..
L2450    fcb   $5F,$BE,$5B,$B1,$4B,$7B,$45,$45   _>[1K{EE
L2458    fcb   $50,$9F,$C0,$16,$82,$17,$49,$5E   P.@...I^
L2460    fcb   $07,$B3,$57,$98,$07,$14,$0D,$12   .3W.....
L2468    fcb   $0A,$08,$04,$0E,$2C,$1D,$D5,$47   ....,.UG
L2470    fcb   $F3,$5F,$5B,$4D,$C3,$B0,$1D,$85   s_[MC0..
L2478    fcb   $5C,$C0,$02,$03,$3B,$55,$4E,$21   \@..;UN!
L2480    fcb   $7F,$88,$00,$80,$03,$1D,$5F,$BE   ....._>
L2488    fcb   $5B,$B1,$4B,$7B,$56,$45,$A3,$7A   [1K{VE#z
L2490    fcb   $5E,$17,$F3,$A0,$36,$56,$D0,$15   ^.s 6VP.
L2498    fcb   $82,$17,$50,$5E,$BE,$A0,$19,$71   ..P^> .q
L24A0    fcb   $46,$48,$2E,$02,$06,$90,$BE,$55   FH....>U
L24A8    fcb   $DB,$86,$8D,$06,$53,$0D,$51,$0A   [...S.Q.
L24B0    fcb   $0F,$0E,$4D,$0D,$24,$14,$08,$18   ..M.$...
L24B8    fcb   $04,$02,$5F,$BE,$11,$04,$1A,$4B   .._>...K
L24C0    fcb   $7B,$81,$BF,$B3,$14,$D6,$6A,$C8   {.?3.VjH
L24C8    fcb   $9C,$73,$7B,$83,$7A,$25,$BA,$03   .s{.z%:.
L24D0    fcb   $71,$83,$17,$7B,$9B,$C9,$B8,$9B   q..{.I8.
L24D8    fcb   $C1,$0D,$25,$17,$06,$00,$17,$07   A.%.....
L24E0    fcb   $88,$17,$18,$00,$04,$1A,$5F,$BE   ......_>
L24E8    fcb   $66,$17,$8F,$49,$56,$5E,$38,$C6   f..IV^8F
L24F0    fcb   $D6,$B5,$C8,$9C,$D7,$46,$82,$17   V5H.WF..
L24F8    fcb   $59,$5E,$66,$62,$09,$15,$C7,$A0   Y^fb..G 
L2500    fcb   $18,$53,$88,$00,$84,$03,$1C,$5F   .S....._
L2508    fcb   $BE,$5B,$B1,$4B,$7B,$4F,$45,$65   >[1K{OEe
L2510    fcb   $62,$77,$47,$D3,$14,$0F,$B4,$17   bwGS..4.
L2518    fcb   $58,$3F,$98,$96,$AF,$DB,$72,$C9   X?../[rI
L2520    fcb   $B8,$9B,$C1,$02,$0A,$14,$53,$66   8.A...Sf
L2528    fcb   $CA,$67,$16,$D3,$B9,$9B,$6C,$07   Jg.S9.l.
L2530    fcb   $24,$0D,$22,$0A,$08,$04,$1E,$5F   $."...._
L2538    fcb   $BE,$67,$16,$D3,$B9,$9B,$6C,$1B   >g.S9.l.
L2540    fcb   $B7,$33,$BB,$93,$1D,$5B,$66,$55   73;..[fU
L2548    fcb   $A4,$09,$B7,$48,$5E,$A3,$A0,$52   $.7H^# R
L2550    fcb   $45,$05,$B2,$DC,$63,$09,$3B,$90   E.2\c.;.
L2558    fcb   $00,$80,$03,$0D,$5F,$BE,$09,$15   ...._>..
L2560    fcb   $A3,$A0,$4B,$7B,$C9,$54,$A6,$B7   # K{IT&7
L2568    fcb   $2E,$02,$03,$81,$5B,$52,$07,$22   ....[R."
L2570    fcb   $0D,$20,$0A,$11,$17,$1B,$00,$17   . ......
L2578    fcb   $1C,$90,$04,$16,$7C,$B3,$6F,$B3   ....|3o3
L2580    fcb   $27,$60,$2D,$60,$8B,$18,$5F,$BE   '`-`.._>
L2588    fcb   $09,$15,$A3,$A0,$4B,$7B,$5F,$A0   ..# K{_ 
L2590    fcb   $1B,$9C,$09,$30,$00,$00,$80,$03   ...0....
L2598    fcb   $12,$5F,$BE,$09,$15,$A3,$A0,$4B   ._>..# K
L25A0    fcb   $7B,$FB,$B9,$43,$98,$AB,$98,$5F   {.9C.+._
L25A8    fcb   $A0,$1B,$9C,$02,$03,$81,$5B,$52    .....[R
L25B0    fcb   $07,$12,$0D,$10,$0A,$11,$04,$0C   ........
L25B8    fcb   $8D,$7B,$8E,$14,$63,$B1,$FB,$5C   .{..c1.\
L25C0    fcb   $5F,$A0,$1B,$9C,$FF,$80,$87,$96   _ ......
L25C8    fcb   $00,$80,$0A,$76,$0E,$74,$0B,$07   ...v.t..
L25D0    fcb   $20,$1D,$01,$81,$23,$01,$81,$0D    ...#...
L25D8    fcb   $69,$1F,$66,$C7,$DE,$DB,$16,$CB   i.fG^[.K
L25E0    fcb   $B9,$36,$A1,$59,$F4,$F0,$72,$51   96!YtprQ
L25E8    fcb   $18,$43,$C2,$0D,$D0,$A6,$61,$51   .CB.P&aQ
L25F0    fcb   $18,$48,$C2,$8E,$7A,$51,$18,$3D   .HB.zQ.=
L25F8    fcb   $C6,$40,$61,$DA,$14,$D0,$47,$F3   F@aZ.PGs
L2600    fcb   $5F,$6B,$BF,$44,$45,$81,$8D,$15   _k?DE...
L2608    fcb   $58,$4B,$BD,$66,$98,$8E,$14,$54   XK=f...T
L2610    fcb   $BD,$43,$F4,$EC,$16,$35,$79,$0B   =Ctl.5y.
L2618    fcb   $BC,$CD,$B5,$67,$98,$90,$8C,$D1   <M5g...Q
L2620    fcb   $6A,$74,$CA,$51,$18,$59,$C2,$82   jtJQ.YB.
L2628    fcb   $7B,$7B,$14,$13,$87,$7F,$66,$D6   {{...fV
L2630    fcb   $15,$49,$16,$A5,$9F,$43,$16,$9B   .I.%.C..
L2638    fcb   $85,$63,$BE,$CB,$B5,$CB,$B5,$9B   .c>K5K5.
L2640    fcb   $C1,$81,$08,$06,$0D,$04,$1C,$1D   A.......
L2648    fcb   $23,$05,$09,$02,$46,$46,$0F,$81   #...FF..
L2650    fcb   $B4,$00,$00,$90,$03,$25,$5F,$BE   4....%_>
L2658    fcb   $5B,$B1,$4B,$7B,$4A,$45,$FF,$78   [1K{JE.x
L2660    fcb   $35,$A1,$73,$15,$C1,$B1,$3F,$DE   5!s.A1?^
L2668    fcb   $B6,$14,$5D,$9E,$91,$7A,$82,$17   6.]..z..
L2670    fcb   $50,$5E,$BE,$A0,$12,$71,$65,$49   P^> .qeI
L2678    fcb   $77,$47,$2E,$02,$06,$14,$6C,$4B   wG....lK
L2680    fcb   $6E,$DB,$8B,$09,$02,$FF,$FF,$07   n[......
L2688    fcb   $22,$0D,$20,$0A,$15,$04,$1C,$DD   ". ....]
L2690    fcb   $72,$F3,$8C,$96,$5F,$51,$18,$4E   rs.._Q.N
L2698    fcb   $C2,$11,$A0,$AF,$14,$04,$68,$5B   B. /..h[
L26A0    fcb   $5E,$1D,$A1,$F3,$8C,$96,$5F,$A3   ^.!s.._#
L26A8    fcb   $15,$EB,$8F,$08,$81,$29,$0D,$81   .k...)..
L26B0    fcb   $26,$01,$1D,$1C,$1D,$14,$01,$12   &.......
L26B8    fcb   $0B,$81,$1C,$05,$19,$2E,$0D,$2C   .......,
L26C0    fcb   $1F,$28,$5F,$BE,$73,$15,$C1,$B1   .(_>s.A1
L26C8    fcb   $3F,$DE,$81,$15,$75,$B1,$51,$18   ?^..u1Q.
L26D0    fcb   $59,$C2,$82,$7B,$A3,$15,$CA,$B5   YB.{#.J5
L26D8    fcb   $B8,$A0,$90,$14,$14,$58,$ED,$7A   8 ...Xmz
L26E0    fcb   $51,$18,$23,$C6,$36,$6F,$D1,$B5   Q.#F6oQ5
L26E8    fcb   $71,$C6,$1D,$FF,$3F,$21,$0D,$1F   qF..?!..
L26F0    fcb   $1F,$1B,$5F,$BE,$73,$15,$C1,$B1   .._>s.A1
L26F8    fcb   $3F,$DE,$DE,$14,$05,$4A,$51,$18   ?^^..JQ.
L2700    fcb   $43,$C2,$B9,$55,$CB,$B9,$5F,$BE   CB9UK9_>
L2708    fcb   $DA,$14,$66,$62,$21,$1D,$32,$64   Z.fb!.2d
L2710    fcb   $2E,$0D,$2C,$1F,$28,$C7,$DE,$4F   ..,.(G^O
L2718    fcb   $15,$33,$61,$5F,$BE,$80,$15,$5A   .3a_>..Z
L2720    fcb   $49,$91,$7A,$B8,$16,$82,$17,$49   I.z8...I
L2728    fcb   $5E,$31,$49,$CE,$A1,$A5,$5E,$7F   ^1IN!%^
L2730    fcb   $17,$82,$62,$D0,$15,$51,$18,$23   ..bP.Q.#
L2738    fcb   $C6,$46,$B8,$EB,$5D,$1D,$32,$A3   FF8k].2#
L2740    fcb   $3C,$0D,$3A,$1F,$36,$5F,$BE,$DE   <.:.6_>^
L2748    fcb   $14,$05,$4A,$B8,$16,$82,$17,$49   ..J8...I
L2750    fcb   $5E,$31,$49,$CE,$A1,$54,$5E,$D3   ^1IN!T^S
L2758    fcb   $7A,$6C,$BE,$29,$A1,$1B,$71,$34   zl>)!.q4
L2760    fcb   $A1,$94,$14,$4B,$90,$83,$96,$83   !..K....
L2768    fcb   $96,$3F,$C0,$EE,$93,$89,$17,$2F   .?@n.../
L2770    fcb   $17,$DA,$46,$51,$18,$23,$C6,$F6   .ZFQ.#Fv
L2778    fcb   $4E,$EB,$DA,$1D,$19,$E1,$3E,$0D   NkZ..a>.
L2780    fcb   $3C,$1F,$38,$5F,$BE,$73,$15,$C1   <.8_>s.A
L2788    fcb   $B1,$3F,$DE,$4F,$16,$B7,$98,$C3   1?^O.7.C
L2790    fcb   $B5,$1B,$BC,$34,$A1,$4B,$15,$9B   5.<4!K..
L2798    fcb   $53,$F6,$4F,$51,$18,$52,$C2,$46   SvOQ.RBF
L27A0    fcb   $C5,$AB,$14,$AF,$54,$4A,$13,$44   E+./TJ.D
L27A8    fcb   $5E,$7F,$7B,$DB,$B5,$34,$A1,$5A   ^{[54!Z
L27B0    fcb   $17,$2E,$A1,$F4,$59,$D0,$15,$FF   ..!tYP..
L27B8    fcb   $B9,$F1,$46,$1D,$19,$FF,$18,$0D   9qF.....
L27C0    fcb   $16,$1F,$14,$C7,$DE,$09,$15,$37   ...G^..7
L27C8    fcb   $5A,$82,$17,$49,$5E,$31,$49,$CE   Z..I^1IN
L27D0    fcb   $A1,$A5,$5E,$A9,$15,$E7,$B2,$0A   !%^).g2.
L27D8    fcb   $2C,$0D,$2A,$1F,$22,$5F,$BE,$73   ,.*."_>s
L27E0    fcb   $15,$C1,$B1,$3F,$DE,$7B,$17,$B5   .A1?^{.5
L27E8    fcb   $85,$7B,$14,$10,$67,$33,$48,$6F   .{..g3Ho
L27F0    fcb   $4F,$82,$49,$90,$14,$16,$58,$F0   O.I...Xp
L27F8    fcb   $72,$3A,$15,$94,$A5,$6F,$62,$17   r:..%ob.
L2800    fcb   $1E,$00,$17,$1F,$8E,$0F,$53,$00   ......S.
L2808    fcb   $00,$80,$03,$24,$5F,$BE,$5B,$B1   ...$_>[1
L2810    fcb   $4B,$7B,$5F,$BE,$FF,$14,$F3,$46   K{_>..sF
L2818    fcb   $14,$53,$15,$53,$D1,$B5,$83,$64   .S.SQ5.d
L2820    fcb   $97,$96,$D3,$6D,$73,$15,$C1,$B1   ..Sms.A1
L2828    fcb   $3F,$DE,$8F,$16,$2C,$49,$DB,$E0   ?^..,I[`
L2830    fcb   $07,$1D,$0D,$1B,$0A,$15,$04,$17   ........
L2838    fcb   $7A,$C4,$CB,$06,$82,$17,$95,$7A   zDK....z
L2840    fcb   $BD,$15,$49,$90,$50,$9F,$D6,$6A   =.I.P.Vj
L2848    fcb   $C4,$9C,$55,$5E,$DD,$78,$21,$02   D.U^]x!.
L2850    fcb   $09,$E3,$59,$09,$58,$31,$49,$CE   .cY.X1IN
L2858    fcb   $A1,$45,$25,$32,$FF,$00,$80,$07   !E%2....
L2860    fcb   $28,$0B,$26,$0A,$17,$20,$04,$1E   (.&.. ..
L2868    fcb   $C7,$DE,$D3,$14,$90,$96,$F3,$A0   G^S...s 
L2870    fcb   $C3,$54,$A3,$91,$5F,$BE,$F3,$17   CT#._>s.
L2878    fcb   $16,$8D,$D6,$15,$D5,$15,$89,$17   ..V.U...
L2880    fcb   $D5,$9C,$C1,$93,$77,$BE,$34,$01   U.A.w>4.
L2888    fcb   $89,$02,$03,$0E,$D0,$4C,$26,$29   ....PL&)
L2890    fcb   $9D,$00,$80,$03,$1E,$4E,$45,$31   .....NE1
L2898    fcb   $49,$50,$5E,$91,$62,$B5,$A0,$B8   IP^.b5 8
L28A0    fcb   $16,$D3,$17,$75,$98,$DE,$14,$91   .S.u.^..
L28A8    fcb   $7A,$D6,$B5,$D6,$9C,$DB,$72,$0E   zV5V.[r.
L28B0    fcb   $D0,$9B,$8F,$02,$04,$10,$CB,$4B   P.....KK
L28B8    fcb   $62,$1E,$28,$8F,$05,$A0,$03,$16   b.(.. ..
L28C0    fcb   $5F,$BE,$5B,$B1,$4B,$7B,$49,$45   _>[1K{IE
L28C8    fcb   $BE,$9F,$83,$61,$29,$54,$26,$A7   >..a)T&'
L28D0    fcb   $DD,$78,$9F,$15,$7F,$B1,$02,$0B   ]x..1..
L28D8    fcb   $3E,$6E,$F0,$59,$DA,$14,$6D,$A0   >npYZ.m 
L28E0    fcb   $85,$BE,$4B,$28,$80,$CA,$9C,$00   .>K(.J..
L28E8    fcb   $90,$03,$27,$B8,$B7,$2B,$62,$09   ..'87+b.
L28F0    fcb   $8A,$94,$C3,$0B,$5C,$14,$53,$8B   ..C.\.S.
L28F8    fcb   $B4,$AB,$98,$F6,$8B,$4E,$72,$E4   4+.v.Nrd
L2900    fcb   $14,$E5,$A0,$09,$4F,$D6,$B5,$38   .e .OV58
L2908    fcb   $C6,$89,$17,$4B,$15,$9B,$53,$C7   F..K..SG
L2910    fcb   $DE,$2E,$08,$80,$95,$0E,$80,$92   ^.......
L2918    fcb   $0D,$2F,$14,$01,$1D,$0B,$29,$03   ./....).
L2920    fcb   $9C,$23,$07,$0D,$05,$00,$9D,$01   .#......
L2928    fcb   $1D,$86,$9F,$23,$07,$0D,$05,$00   ...#....
L2930    fcb   $9C,$01,$1D,$86,$9E,$23,$07,$0D   .....#..
L2938    fcb   $05,$00,$9F,$01,$1D,$86,$9D,$23   .......#
L2940    fcb   $07,$0D,$05,$00,$9E,$01,$1D,$86   ........
L2948    fcb   $0C,$0D,$5F,$01,$1D,$1C,$1D,$1F   .._.....
L2950    fcb   $58,$A6,$1D,$51,$A0,$D0,$15,$06   X&.Q P..
L2958    fcb   $67,$33,$61,$79,$5B,$06,$07,$82   g3ay[...
L2960    fcb   $17,$49,$5E,$94,$C3,$0B,$5C,$F8   .I^.C.\x
L2968    fcb   $8B,$33,$61,$5F,$BE,$23,$7B,$B9   .3a_>#{9
L2970    fcb   $55,$D4,$B9,$85,$A1,$90,$14,$0E   UT9.!...
L2978    fcb   $58,$45,$A0,$56,$5E,$EB,$72,$84   XE V^kr.
L2980    fcb   $AF,$CE,$9F,$6B,$B5,$C7,$DE,$84   /N.k5G^.
L2988    fcb   $AF,$93,$9E,$4B,$15,$0D,$8D,$89   /..K....
L2990    fcb   $17,$82,$17,$49,$5E,$07,$B3,$33   ...I^.33
L2998    fcb   $98,$06,$B2,$FF,$5A,$19,$58,$82   ..2.Z.X.
L29A0    fcb   $7B,$82,$17,$55,$5E,$48,$72,$09   {..U^Hr.
L29A8    fcb   $C0,$81,$02,$04,$23,$6F,$4D,$B1   @...#oM1
L29B0    fcb   $29,$4C,$1D,$00,$00,$08,$47,$0B   )L....G.
L29B8    fcb   $45,$03,$9C,$23,$0E,$0E,$0C,$0D   E..#....
L29C0    fcb   $04,$03,$9A,$1D,$85,$0D,$04,$03   ........
L29C8    fcb   $99,$1D,$87,$9F,$23,$0E,$0E,$0C   ....#...
L29D0    fcb   $0D,$04,$03,$99,$1D,$85,$0D,$04   ........
L29D8    fcb   $03,$98,$1D,$87,$9E,$23,$0E,$0E   .....#..
L29E0    fcb   $0C,$0D,$04,$03,$98,$1D,$85,$0D   ........
L29E8    fcb   $04,$03,$9B,$1D,$87,$9D,$23,$0E   ......#.
L29F0    fcb   $0E,$0C,$0D,$04,$03,$9B,$1D,$85   ........
L29F8    fcb   $0D,$04,$03,$9A,$1D,$87,$13,$30   .......0
L2A00    fcb   $9C,$00,$A0,$02,$08,$EF,$A6,$51   .. ..o&Q
L2A08    fcb   $54,$4B,$C6,$AF,$6C,$08,$21,$0D   TKF/l.!.
L2A10    fcb   $1F,$03,$9C,$25,$0B,$1A,$05,$33   ...%...3
L2A18    fcb   $03,$17,$25,$89,$66,$03,$17,$25   ..%.f..%
L2A20    fcb   $94,$99,$03,$17,$25,$86,$CC,$03   ....%.L.
L2A28    fcb   $17,$25,$8E,$FF,$03,$17,$25,$83   .%....%.
L2A30    fcb   $13,$23,$00,$05,$A0,$02,$08,$EF   .#.. ..o
L2A38    fcb   $A6,$51,$54,$4B,$C6,$AF,$6C,$03   &QTKF/l.
L2A40    fcb   $14,$5F,$BE,$5B,$B1,$4B,$7B,$52   ._>[1K{R
L2A48    fcb   $45,$65,$B1,$C7,$7A,$C9,$B5,$5B   Ee1GzI5[
L2A50    fcb   $61,$F4,$72,$DB,$63,$2A,$32,$FF   atr[c*2.
L2A58    fcb   $00,$00,$02,$03,$01,$B3,$4D,$07   .....3M.
L2A60    fcb   $28,$0D,$26,$0A,$0B,$01,$25,$04   (.&...%.
L2A68    fcb   $20,$C7,$DE,$03,$15,$61,$B7,$74    G^..a7t
L2A70    fcb   $CA,$7B,$14,$EF,$A6,$51,$54,$4B   J{.o&QTK
L2A78    fcb   $C6,$AF,$6C,$A3,$15,$BF,$59,$8B   F/l#.?Y.
L2A80    fcb   $96,$83,$96,$E4,$14,$D3,$62,$BF   ...d.Sb?
L2A88    fcb   $53,$1B,$62,$00,$00,$AC,$02,$03   S.b..,..
L2A90    fcb   $4F,$8B,$50,$03,$0E,$5F,$BE,$5B   O.P.._>[
L2A98    fcb   $B1,$4B,$7B,$4E,$45,$72,$48,$9F   1K{NErH.
L2AA0    fcb   $15,$7F,$B1,$07,$48,$0B,$46,$0A   .1.H.F.
L2AA8    fcb   $14,$1C,$0E,$1A,$0D,$17,$09,$12   ........
L2AB0    fcb   $1E,$28,$14,$04,$10,$5F,$BE,$3B   .(..._>;
L2AB8    fcb   $16,$D3,$93,$4B,$7B,$09,$9A,$BF   .S.K{..?
L2AC0    fcb   $14,$D3,$B2,$CF,$98,$88,$18,$19   .S2O....
L2AC8    fcb   $04,$17,$29,$D1,$09,$15,$51,$18   ..)Q..Q.
L2AD0    fcb   $56,$C2,$90,$73,$DB,$83,$1B,$A1   VB.s[..!
L2AD8    fcb   $2F,$49,$03,$EE,$46,$8B,$90,$5A   /I.nF..Z
L2AE0    fcb   $3F,$08,$0A,$04,$08,$49,$1B,$99   ?....I..
L2AE8    fcb   $16,$14,$BC,$A4,$C3,$2B,$09,$00   ..<$C+..
L2AF0    fcb   $00,$80,$02,$04,$89,$67,$A3,$A0   .....g# 
L2AF8    fcb   $2C,$0B,$00,$00,$80,$07,$01,$93   ,.......
L2B00    fcb   $02,$03,$23,$63,$54,$2D,$0D,$00   ..#cT-..
L2B08    fcb   $00,$80,$07,$01,$93,$02,$05,$55   .......U
L2B10    fcb   $A4,$09,$B7,$45,$2E,$0B,$00,$00   $.7E....
L2B18    fcb   $80,$07,$01,$93,$02,$03,$7E,$74   ......~t
L2B20    fcb   $45,$2F,$0E,$00,$00,$80,$07,$01   E/......
L2B28    fcb   $93,$02,$06,$44,$55,$06,$B2,$A3   ...DU.2#
L2B30    fcb   $A0,$30,$09,$00,$00,$80,$02,$04    0......
L2B38    fcb   $44,$55,$74,$98,$31,$07,$88,$00   DUt.1...
L2B40    fcb   $80,$02,$02,$09,$4F,$32,$09,$88   ....O2..
L2B48    fcb   $00,$80,$02,$04,$3C,$49,$6B,$A1   ....<Ik!
L2B50    fcb   $33,$0D,$00,$00,$80,$07,$01,$93   3.......
L2B58    fcb   $02,$05,$4E,$72,$B3,$8E,$59,$34   ..Nr3.Y4
L2B60    fcb   $0A,$8D,$00,$80,$02,$05,$1B,$54   .......T
L2B68    fcb   $AF,$91,$52,$35,$09,$91,$00,$80   /.R5....
L2B70    fcb   $02,$04,$D7,$C9,$33,$8E,$36,$0E   ..WI3.6.
L2B78    fcb   $00,$00,$80,$07,$01,$93,$02,$06   ........
L2B80    fcb   $9E,$61,$D0,$B0,$9B,$53,$37,$0C   .aP0.S7.
L2B88    fcb   $00,$00,$80,$07,$01,$93,$02,$04   ........
L2B90    fcb   $70,$C0,$6E,$98,$38,$0C,$FF,$00   p@n.8...
L2B98    fcb   $80,$07,$01,$93,$02,$04,$F0,$81   ......p.
L2BA0    fcb   $BF,$6D,$39,$0C,$FF,$00,$80,$07   ?m9.....
L2BA8    fcb   $01,$93,$02,$04,$EF,$BD,$FF,$A5   ....o=.%
L2BB0    fcb   $24,$0B,$9C,$00,$80,$02,$06,$B4   $......4
L2BB8    fcb   $B7,$F0,$A4,$0B,$C0,$3A,$31,$82   7p$.@:1.
L2BC0    fcb   $00,$80,$07,$28,$0B,$26,$0A,$36   ...(.&.6
L2BC8    fcb   $01,$8A,$33,$01,$8A,$34,$01,$8A   ..3..4..
L2BD0    fcb   $26,$17,$04,$15,$5F,$BE,$5B,$B1   &..._>[1
L2BD8    fcb   $4B,$7B,$EB,$99,$1B,$D0,$94,$14   K{k..P..
L2BE0    fcb   $30,$A1,$16,$58,$DB,$72,$96,$A5   0!.X[r.%
L2BE8    fcb   $2E,$17,$01,$8A,$02,$02,$96,$A5   .......%
L2BF0    fcb   $3B,$0A,$00,$00,$80,$02,$05,$AB   ;......+
L2BF8    fcb   $53,$90,$8C,$47,$22,$39,$A5,$00   S..G"9%.
L2C00    fcb   $80,$02,$04,$4E,$48,$23,$62,$07   ...NH#b.
L2C08    fcb   $2E,$0D,$2C,$0A,$12,$04,$28,$C7   ..,...(G
L2C10    fcb   $DE,$D3,$14,$90,$96,$F3,$A0,$C8   ^S...s H
L2C18    fcb   $93,$56,$5E,$DB,$72,$4E,$48,$23   .V^[rNH#
L2C20    fcb   $62,$79,$68,$44,$90,$8F,$61,$82   byhD..a.
L2C28    fcb   $49,$D6,$15,$0B,$EE,$0B,$BC,$D6   IV..n.<V
L2C30    fcb   $B5,$2B,$A0,$E3,$72,$9F,$CD,$3C   5+ cr.M<
L2C38    fcb   $03,$1D,$00,$80,$00,$85,$BB,$0E   ......;.
L2C40    fcb   $85,$B8,$0D,$2C,$0E,$08,$0A,$01   .8.,....
L2C48    fcb   $0A,$02,$0A,$03,$0A,$04,$0E,$20   ....... 
L2C50    fcb   $13,$0D,$1D,$04,$19,$5F,$BE,$5B   ....._>[
L2C58    fcb   $B1,$4B,$7B,$EB,$99,$1B,$D0,$89   1K{k..P.
L2C60    fcb   $17,$81,$15,$82,$17,$73,$49,$94   .....sI.
L2C68    fcb   $5A,$E6,$5F,$C0,$7A,$2E,$20,$1D   Zf_@z. .
L2C70    fcb   $0B,$85,$83,$0A,$05,$21,$0E,$1F   .....!..
L2C78    fcb   $0D,$19,$1A,$18,$04,$13,$C7,$DE   ......G^
L2C80    fcb   $94,$14,$43,$5E,$EF,$8D,$13,$47   ..C^o..G
L2C88    fcb   $D3,$14,$83,$B3,$91,$7A,$82,$17   S..3.z..
L2C90    fcb   $45,$16,$84,$13,$83,$14,$0C,$06   E.......
L2C98    fcb   $0C,$0D,$0A,$1A,$10,$04,$06,$F9   .......y
L2CA0    fcb   $5B,$9F,$A6,$9B,$5D,$08,$17,$0E   [.&.]...
L2CA8    fcb   $15,$13,$0D,$12,$04,$0E,$89,$74   .......t
L2CB0    fcb   $D3,$14,$9B,$96,$1B,$A1,$63,$B1   S....!c1
L2CB8    fcb   $16,$58,$DB,$72,$11,$84,$11,$16   .X[r....
L2CC0    fcb   $0E,$14,$13,$0D,$11,$04,$0D,$EB   .......k
L2CC8    fcb   $99,$0F,$A0,$D3,$14,$91,$96,$F0   .. S...p
L2CD0    fcb   $A4,$82,$17,$45,$11,$84,$12,$21   $..E...!
L2CD8    fcb   $0E,$1F,$13,$0D,$1C,$04,$13,$33   .......3
L2CE0    fcb   $D1,$09,$15,$E6,$96,$51,$18,$4E   Q..f.Q.N
L2CE8    fcb   $C2,$98,$5F,$56,$5E,$DB,$72,$81   B._V^[r.
L2CF0    fcb   $A6,$52,$11,$04,$04,$49,$48,$7F   &R...IH
L2CF8    fcb   $98,$09,$81,$37,$0E,$81,$34,$14   ...7..4.
L2D00    fcb   $1B,$14,$0E,$03,$09,$17,$83,$0E   ........
L2D08    fcb   $81,$29,$0D,$1F,$14,$15,$40,$14   .)....@.
L2D10    fcb   $09,$17,$04,$0C,$C7,$DE,$D3,$14   ....G^S.
L2D18    fcb   $E6,$96,$AF,$15,$B3,$B3,$5F,$BE   f./.33_>
L2D20    fcb   $11,$04,$06,$56,$D1,$16,$71,$DB   ...VQ.q[
L2D28    fcb   $72,$12,$84,$13,$0D,$1A,$1A,$14   r.......
L2D30    fcb   $15,$10,$04,$12,$73,$7B,$77,$5B   ....s{w[
L2D38    fcb   $D0,$B5,$C9,$9C,$36,$A0,$89,$17   P5I.6 ..
L2D40    fcb   $96,$14,$45,$BD,$C3,$83,$11,$84   ..E=C...
L2D48    fcb   $0D,$80,$D7,$1A,$0B,$80,$D3,$09   ..W...S.
L2D50    fcb   $09,$80,$99,$0B,$80,$96,$05,$52   .......R
L2D58    fcb   $28,$0D,$26,$04,$17,$4F,$45,$7A   (.&..OEz
L2D60    fcb   $79,$FB,$C0,$6C,$BE,$66,$C6,$04   y.@l>fF.
L2D68    fcb   $EE,$73,$C6,$73,$7B,$D5,$92,$B5   nsFs{U.5
L2D70    fcb   $B7,$82,$17,$45,$16,$04,$0A,$7B   7..E...{
L2D78    fcb   $50,$4D,$45,$49,$7A,$36,$92,$21   PMEIz6.!
L2D80    fcb   $62,$A4,$2D,$0D,$2B,$04,$1C,$89   b$-.+...
L2D88    fcb   $4E,$73,$9E,$F5,$B3,$F5,$72,$59   Ns.u3urY
L2D90    fcb   $15,$C2,$B3,$95,$14,$51,$18,$4A   .B3..Q.J
L2D98    fcb   $C2,$CF,$49,$5E,$17,$5A,$49,$F3   BOI^.ZIs
L2DA0    fcb   $5F,$5F,$BE,$16,$04,$08,$83,$7A   __>....z
L2DA8    fcb   $5F,$BE,$94,$14,$EB,$8F,$1D,$0A   _>..k...
L2DB0    fcb   $FD,$20,$0D,$1E,$04,$1A,$C7,$DE   . ....G^
L2DB8    fcb   $63,$16,$C9,$97,$43,$5E,$84,$15   c.I.C^..
L2DC0    fcb   $73,$4A,$AB,$98,$89,$4E,$D6,$CE   sJ+..NVN
L2DC8    fcb   $D6,$9C,$DB,$72,$1F,$54,$F1,$B9   V.[r.Tq9
L2DD0    fcb   $1D,$14,$FF,$18,$0D,$16,$04,$12   ........
L2DD8    fcb   $4E,$45,$DD,$C3,$44,$DB,$89,$8D   NE]CD[..
L2DE0    fcb   $89,$17,$82,$17,$4A,$5E,$94,$5F   ....J^._
L2DE8    fcb   $AB,$BB,$1D,$FF,$17,$34,$0B,$32   +;...4.2
L2DF0    fcb   $05,$AF,$14,$04,$12,$59,$45,$3E   ./...YE>
L2DF8    fcb   $7A,$EF,$16,$1A,$98,$90,$14,$1B   zo......
L2E00    fcb   $58,$1B,$A1,$D5,$92,$5B,$BB,$FF   X.!U.[;.
L2E08    fcb   $19,$0D,$17,$04,$13,$C7,$DE,$EF   .....G^o
L2E10    fcb   $16,$1A,$98,$F3,$5F,$8F,$73,$D0   ...s_.sP
L2E18    fcb   $15,$82,$17,$4A,$5E,$86,$5F,$21   ...J^._!
L2E20    fcb   $1D,$03,$0D,$0F,$04,$02,$5F,$BE   ......_>
L2E28    fcb   $11,$04,$08,$4B,$7B,$92,$C5,$37   ...K{.E7
L2E30    fcb   $49,$17,$60,$0A,$01,$07,$15,$29   I.`....)
L2E38    fcb   $0E,$27,$13,$0D,$24,$04,$0D,$80   .'..$...
L2E40    fcb   $5B,$F3,$23,$5B,$4D,$4E,$B8,$F9   [s#[MN8y
L2E48    fcb   $8E,$82,$17,$45,$11,$04,$12,$47   ...E...G
L2E50    fcb   $D2,$C8,$8B,$F3,$23,$55,$BD,$DB   RH.s#U=[
L2E58    fcb   $BD,$41,$6E,$03,$58,$99,$9B,$5F   =An.X.._
L2E60    fcb   $4A,$17,$51,$0E,$4F,$13,$0D,$25   J.Q.O..%
L2E68    fcb   $1A,$15,$10,$04,$0C,$46,$77,$05   .....Fw.
L2E70    fcb   $A0,$16,$BC,$90,$73,$D6,$83,$DB    .<.sV.[
L2E78    fcb   $72,$11,$04,$11,$4E,$D1,$15,$8A   r...NQ..
L2E80    fcb   $50,$BD,$15,$58,$8E,$BE,$08,$8A   P=.X.>..
L2E88    fcb   $BE,$A0,$56,$72,$2E,$0D,$25,$04   > Vr..%.
L2E90    fcb   $12,$CF,$62,$8B,$96,$9B,$64,$1B   .Ob...d.
L2E98    fcb   $A1,$47,$55,$B3,$8B,$C3,$54,$A3   !GU3.CT#
L2EA0    fcb   $91,$5F,$BE,$11,$04,$0E,$73,$7B   ._>...s{
L2EA8    fcb   $47,$D2,$C8,$8B,$F3,$23,$EE,$72   GRH.s#nr
L2EB0    fcb   $1B,$A3,$3F,$A1,$16,$16,$0E,$14   .#?!....
L2EB8    fcb   $13,$0D,$11,$04,$02,$5F,$BE,$11   ....._>.
L2EC0    fcb   $04,$0A,$4B,$7B,$06,$9A,$BF,$14   ..K{..?.
L2EC8    fcb   $D3,$B2,$CF,$98,$18,$35,$0E,$33   S2O..5.3
L2ED0    fcb   $13,$0D,$18,$1A,$15,$10,$04,$11   ........
L2ED8    fcb   $5B,$BE,$65,$BC,$99,$16,$F3,$17   [>e<..s.
L2EE0    fcb   $56,$DB,$CA,$9C,$3E,$C6,$82,$17   V[J.>F..
L2EE8    fcb   $45,$16,$84,$0D,$16,$04,$02,$5F   E......_
L2EF0    fcb   $BE,$11,$04,$0F,$81,$8D,$CB,$87   >.....K.
L2EF8    fcb   $A5,$94,$04,$71,$8E,$62,$23,$62   %..q.b#b
L2F00    fcb   $09,$9A,$2E,$0B,$3A,$0E,$38,$13   ....:.8.
L2F08    fcb   $0D,$19,$1A,$15,$04,$04,$12,$3F   .......?
L2F10    fcb   $B9,$82,$62,$91,$7A,$D5,$15,$04   9.b.zU..
L2F18    fcb   $18,$8E,$7B,$83,$61,$03,$A0,$5F   ..{.a. _
L2F20    fcb   $BE,$16,$84,$0D,$1A,$04,$16,$5F   >......_
L2F28    fcb   $BE,$5D,$B1,$D0,$B5,$02,$A1,$91   >]1P5.!.
L2F30    fcb   $7A,$62,$17,$DB,$5F,$33,$48,$B9   zb.[_3H9
L2F38    fcb   $46,$73,$C6,$5F,$BE,$11,$84,$0C   FsF_>...
L2F40    fcb   $1A,$0E,$18,$13,$0D,$15,$04,$11   ........
L2F48    fcb   $5F,$BE,$5D,$B1,$D0,$B5,$02,$A1   _>]1P5.!
L2F50    fcb   $91,$7A,$B0,$17,$F4,$59,$82,$17   .z0.tY..
L2F58    fcb   $45,$11,$84,$10,$18,$0E,$16,$13   E.......
L2F60    fcb   $0D,$13,$04,$0F,$5F,$BE,$5D,$B1   ...._>]1
L2F68    fcb   $D0,$B5,$02,$A1,$91,$7A,$D0,$15   P5.!.zP.
L2F70    fcb   $82,$17,$45,$11,$84,$1B,$20,$0E   ..E... .
L2F78    fcb   $1E,$13,$0D,$03,$08,$00,$07,$0D   ........
L2F80    fcb   $16,$04,$12,$5F,$BE,$5B,$B1,$4B   ..._>[1K
L2F88    fcb   $7B,$06,$9A,$90,$73,$C3,$6A,$07   {...sCj.
L2F90    fcb   $B3,$33,$98,$5F,$BE,$11,$84,$1C   33._>...
L2F98    fcb   $34,$0E,$32,$13,$0D,$17,$08,$00   4.2.....
L2FA0    fcb   $04,$13,$5F,$BE,$5B,$B1,$4B,$7B   .._>[1K{
L2FA8    fcb   $06,$9A,$90,$73,$C4,$6A,$A3,$60   ...sDj#`
L2FB0    fcb   $33,$98,$C7,$DE,$2E,$0D,$16,$04   3.G^....
L2FB8    fcb   $12,$5F,$BE,$5B,$B1,$4B,$7B,$06   ._>[1K{.
L2FC0    fcb   $9A,$90,$73,$C4,$6A,$A3,$60,$33   ..sDj#`3
L2FC8    fcb   $98,$5F,$BE,$11,$84,$21,$0A,$04   ._>..!..
L2FD0    fcb   $08,$B5,$6C,$8E,$C5,$EB,$72,$AB   .5l.Ekr+
L2FD8    fcb   $BB,$22,$12,$04,$10,$5B,$E0,$27   ;"...[`'
L2FE0    fcb   $60,$31,$60,$41,$A0,$49,$A0,$89   `1`A I .
L2FE8    fcb   $D3,$89,$D3,$69,$CE,$23,$05,$0D   S.SiN#..
L2FF0    fcb   $03,$92,$26,$24,$2C,$04,$0D,$02   ..&$,...
L2FF8    fcb   $92,$26,$3E,$01,$27,$3F,$01,$28   .&>.'?.(
L3000    fcb   $25,$0D,$04,$0B,$03,$C0,$7B,$14   %....@{.
L3008    fcb   $94,$5A,$E6,$5F,$C0,$7A,$2E,$26   .Zf_@z.&
L3010    fcb   $24,$0E,$22,$13,$0D,$17,$1A,$15   $.".....
L3018    fcb   $10,$04,$02,$5F,$BE,$11,$04,$0D   ..._>...
L3020    fcb   $40,$D2,$F3,$23,$F6,$8B,$51,$18   @Rs#v.Q.
L3028    fcb   $52,$C2,$65,$49,$21,$04,$06,$09   RBeI!...
L3030    fcb   $9A,$FA,$17,$70,$49,$3D,$01,$94   .z.pI=..
L3038    fcb   $27,$0E,$0E,$0C,$13,$04,$09,$25   '......%
L3040    fcb   $A1,$AB,$70,$3B,$95,$77,$BF,$21   !+p;.w?!
L3048    fcb   $28,$0A,$0E,$08,$13,$0D,$04,$1A   (.......
L3050    fcb   $15,$10,$96,$97,$29,$0A,$0E,$08   ....)...
L3058    fcb   $13,$0D,$04,$1B,$15,$10,$96,$97   ........
L3060    fcb   $2F,$07,$04,$05,$9B,$29,$57,$C6   /....)WF
L3068    fcb   $3E,$2D,$09,$0E,$07,$13,$0D,$02   >-......
L3070    fcb   $1A,$83,$14,$0C,$33,$04,$0E,$02   ....3...
L3078    fcb   $13,$98,$34,$04,$0E,$02,$13,$98   ..4.....
L3080    fcb   $36,$17,$0E,$15,$13,$0D,$12,$04   6.......
L3088    fcb   $0E,$C7,$DE,$D3,$14,$E6,$96,$77   .G^S.f.w
L3090    fcb   $15,$0B,$BC,$96,$96,$DB,$72,$11   ..<..[r.
L3098    fcb   $84,$37,$15,$0E,$13,$13,$0D,$10   .7......
L30A0    fcb   $04,$0C,$C7,$DE,$94,$14,$85,$61   ..G^...a
L30A8    fcb   $0B,$BC,$96,$96,$DB,$72,$11,$84   .<..[r..
L30B0    fcb   $38,$20,$0E,$1E,$13,$0D,$1B,$04   8 ......
L30B8    fcb   $17,$5F,$BE,$5B,$B1,$4B,$7B,$06   ._>[1K{.
L30C0    fcb   $9A,$30,$15,$29,$A1,$14,$71,$3F   .0.)!.q?
L30C8    fcb   $A0,$B0,$17,$F4,$59,$82,$17,$45    0.tY..E
L30D0    fcb   $11,$84,$39,$1D,$0E,$1B,$13,$0D   ..9.....
L30D8    fcb   $18,$04,$16,$C7,$DE,$FB,$17,$F3   ...G^..s
L30E0    fcb   $8C,$58,$72,$56,$5E,$D2,$9C,$73   .XrV^R.s
L30E8    fcb   $C6,$73,$7B,$83,$7A,$5F,$BE,$7F   Fs{.z_>
L30F0    fcb   $B1,$3A,$1E,$0E,$1C,$13,$0D,$19   1:......
L30F8    fcb   $04,$0C,$C7,$DE,$D3,$14,$E6,$96   ..G^S.f.
L3100    fcb   $C2,$16,$83,$61,$5F,$BE,$11,$04   B..a_>..
L3108    fcb   $06,$56,$D1,$16,$71,$DB,$72,$12   .VQ.q[r.
L3110    fcb   $84,$0D,$34,$0E,$32,$0D,$2E,$1A   ..4.2...
L3118    fcb   $83,$0E,$2A,$0D,$27,$0E,$07,$14   ..*.'...
L3120    fcb   $15,$10,$1B,$14,$15,$40,$04,$02   .....@..
L3128    fcb   $5F,$BE,$11,$04,$14,$07,$4F,$17   _>....O.
L3130    fcb   $98,$CA,$B5,$37,$49,$F5,$8B,$D3   .J57Iu.S
L3138    fcb   $B8,$B8,$16,$91,$64,$96,$64,$DB   88..d.d[
L3140    fcb   $72,$12,$84,$10,$13,$14,$0C,$0E   r.......
L3148    fcb   $39,$0E,$37,$0D,$1B,$1B,$14,$15   9.7.....
L3150    fcb   $10,$04,$02,$5F,$BE,$12,$04,$10   ..._>...
L3158    fcb   $4B,$7B,$06,$9A,$85,$14,$B2,$53   K{....2S
L3160    fcb   $90,$BE,$C9,$6A,$5E,$79,$5B,$BB   .>Ij^y[;
L3168    fcb   $13,$0D,$17,$04,$02,$5F,$BE,$12   ....._>.
L3170    fcb   $04,$10,$60,$7B,$F3,$23,$D5,$46   ..`{s#UF
L3178    fcb   $EE,$61,$91,$7A,$BC,$14,$AF,$78   na.z<./x
L3180    fcb   $5B,$BB,$0F,$19,$0E,$17,$13,$0D   [;......
L3188    fcb   $14,$04,$02,$5F,$BE,$11,$04,$0B   ..._>...
L3190    fcb   $40,$D2,$F3,$23,$16,$67,$D0,$15   @Rs#.gP.
L3198    fcb   $82,$17,$45,$12,$84,$14,$3B,$0D   ..E...;.
L31A0    fcb   $39,$1B,$83,$0E,$35,$0D,$18,$1A   9...5...
L31A8    fcb   $15,$08,$0E,$04,$09,$12,$09,$14   ........
L31B0    fcb   $0E,$0D,$13,$04,$0A,$73,$7B,$40   .....s{@
L31B8    fcb   $D2,$F3,$23,$F4,$4F,$1B,$9C,$0D   Rs#tO...
L31C0    fcb   $19,$04,$0C,$C7,$DE,$D3,$14,$E6   ...G^S.f
L31C8    fcb   $96,$BF,$14,$C3,$B2,$5F,$BE,$11   .?.C2_>.
L31D0    fcb   $04,$06,$56,$D1,$16,$71,$DB,$72   ..VQ.q[r
L31D8    fcb   $12,$84,$07,$1A,$0D,$18,$04,$15   ........
L31E0    fcb   $C7,$DE,$94,$14,$45,$5E,$3C,$49   G^..E^<I
L31E8    fcb   $D0,$DD,$D6,$6A,$DB,$72,$FE,$67   P]Vj[r.g
L31F0    fcb   $89,$8D,$91,$7A,$3A,$06,$04,$02   ...z:...
L31F8    fcb   $00,$00,$00,$84,$2C,$81,$63,$0D   ....,.c.
L3200    fcb   $61,$1F,$10,$C7,$DE,$AF,$23,$FF   a..G^/#.
L3208    fcb   $14,$17,$47,$8C,$17,$43,$DB,$0B   ..G..C[.
L3210    fcb   $6C,$1B,$9C,$95,$17,$01,$81,$17   l.......
L3218    fcb   $05,$84,$17,$06,$88,$17,$07,$00   ........
L3220    fcb   $17,$08,$8C,$17,$09,$A1,$17,$0A   .....!..
L3228    fcb   $8E,$17,$0C,$95,$17,$0E,$91,$17   ........
L3230    fcb   $0F,$00,$17,$11,$92,$17,$12,$00   ........
L3238    fcb   $17,$14,$A0,$17,$15,$00,$17,$16   .. .....
L3240    fcb   $00,$17,$18,$9C,$17,$1E,$00,$17   ........
L3248    fcb   $1F,$00,$17,$22,$8F,$17,$25,$9C   ..."..%.
L3250    fcb   $17,$26,$00,$17,$28,$00,$1C,$15   .&..(...
L3258    fcb   $23,$3C,$1C,$1D,$23,$46,$17,$1D   #<..#F..
L3260    fcb   $96,$25,$82,$2C,$0D,$2A,$1F,$27   .%.,.*.'
L3268    fcb   $5F,$BE,$66,$17,$8F,$49,$54,$5E   _>f..IT^
L3270    fcb   $3F,$61,$57,$49,$D6,$B5,$DB,$72   ?aWIV5[r
L3278    fcb   $3C,$49,$6B,$A1,$23,$D1,$13,$54   <Ik!#Q.T
L3280    fcb   $F0,$A4,$8C,$62,$7F,$49,$DB,$B5   p$.bI[5
L3288    fcb   $34,$A1,$9F,$15,$3E,$49,$2E,$81   4!..>I..
L3290    fcb   $83,$66,$0D,$64,$0E,$61,$0D,$08   .f.d.a..
L3298    fcb   $08,$0E,$17,$0E,$00,$1C,$0F,$0C   ........
L32A0    fcb   $0D,$08,$08,$25,$17,$25,$00,$1C   ...%.%..
L32A8    fcb   $26,$0C,$0D,$1D,$15,$10,$04,$0C   &.......
L32B0    fcb   $46,$77,$05,$A0,$16,$BC,$90,$73   Fw. .<.s
L32B8    fcb   $D6,$83,$DB,$72,$16,$04,$0A,$4E   V.[r...N
L32C0    fcb   $D1,$05,$8A,$42,$A0,$2B,$62,$FF   Q..B +b.
L32C8    fcb   $BD,$0D,$21,$14,$15,$20,$04,$1A   =.!.. ..
L32D0    fcb   $C7,$DE,$94,$14,$53,$5E,$D6,$C4   G^..S^VD
L32D8    fcb   $4B,$5E,$13,$98,$44,$A4,$DB,$8B   K^..D$[.
L32E0    fcb   $C3,$9E,$6F,$B1,$53,$A1,$AB,$98   C.o1S!+.
L32E8    fcb   $5F,$BE,$16,$84,$18,$0D,$08,$0F   _>......
L32F0    fcb   $16,$04,$04,$4D,$BD,$A7,$61,$18   ...M='a.
L32F8    fcb   $84,$04,$04,$02,$3B,$F4,$85,$29   ....;t.)
L3300    fcb   $1F,$27,$49,$45,$07,$B3,$11,$A3   .'IE.3.#
L3308    fcb   $89,$64,$94,$C3,$0B,$5C,$94,$91   .d.C.\..
L3310    fcb   $1F,$54,$C3,$B5,$07,$B3,$33,$98   .TC5.33.
L3318    fcb   $5F,$BE,$E1,$14,$CF,$B2,$96,$AF   _>a.O2./
L3320    fcb   $DB,$9C,$34,$A1,$33,$17,$2E,$6D   [.4!3..m
L3328    fcb   $2E,$87,$2A,$1F,$28,$49,$45,$07   ..*.(IE.
L3330    fcb   $B3,$11,$A3,$89,$64,$94,$C3,$0B   3.#.d.C.
L3338    fcb   $5C,$95,$5A,$EA,$48,$94,$5F,$C3   \.ZjH._C
L3340    fcb   $B5,$07,$B3,$33,$98,$5F,$BE,$E1   5.33._>a
L3348    fcb   $14,$CF,$B2,$96,$AF,$DB,$9C,$34   .O2./[.4
L3350    fcb   $A1,$3F,$16,$D7,$68,$86,$1E,$1F   !?.Wh...
L3358    fcb   $1C,$49,$45,$07,$B3,$11,$A3,$89   .IE.3.#.
L3360    fcb   $64,$94,$C3,$0B,$5C,$3F,$55,$4B   d.C.\?UK
L3368    fcb   $62,$39,$49,$8E,$C5,$82,$17,$45   b9I.E..E
L3370    fcb   $5E,$B8,$A0,$47,$62,$88,$13,$0D   ^8 Gb...
L3378    fcb   $11,$04,$02,$5F,$BE,$12,$04,$0A   ..._>...
L3380    fcb   $4B,$7B,$06,$9A,$BF,$14,$10,$B2   K{..?..2
L3388    fcb   $5B,$70,$92,$1C,$1F,$1A,$36,$A1   [p....6!
L3390    fcb   $B8,$16,$7B,$14,$85,$A6,$44,$B8   8.{..&D8
L3398    fcb   $DB,$8B,$08,$67,$1E,$C1,$51,$18   [..g.AQ.
L33A0    fcb   $23,$C6,$61,$B7,$5B,$B1,$4B,$7B   #Fa7[1K{
L33A8    fcb   $89,$12,$1F,$10,$C7,$DE,$D3,$14   ....G^S.
L33B0    fcb   $E6,$96,$FF,$15,$D3,$93,$5B,$BE   f...S.[>
L33B8    fcb   $08,$BC,$21,$49,$8A,$32,$0D,$30   .<!I.2.0
L33C0    fcb   $1F,$2D,$C7,$DE,$3B,$16,$33,$98   .-G^;.3.
L33C8    fcb   $03,$A0,$55,$45,$8D,$A5,$43,$5E   . UE.%C^
L33D0    fcb   $16,$BC,$DB,$72,$06,$4F,$7F,$BF   .<[r.O?
L33D8    fcb   $B8,$16,$82,$17,$52,$5E,$73,$7B   8...R^s{
L33E0    fcb   $23,$D1,$13,$54,$5F,$BE,$3F,$17   #Q.T_>?.
L33E8    fcb   $C5,$6A,$4F,$A1,$66,$B1,$2E,$81   EjO!f1..
L33F0    fcb   $8B,$79,$0D,$77,$1F,$74,$C7,$DE   .y.w.tG^
L33F8    fcb   $2F,$17,$43,$48,$5B,$E3,$23,$D1   /.CH[c#Q
L3400    fcb   $DB,$8B,$C7,$DE,$AF,$23,$4B,$15   [.G^/#K.
L3408    fcb   $03,$8D,$AB,$98,$5B,$BE,$16,$BC   ..+.[>.<
L3410    fcb   $DB,$72,$E9,$B3,$E1,$14,$74,$CA   [ri3a.tJ
L3418    fcb   $F3,$5F,$52,$45,$97,$7B,$82,$17   s_RE.{..
L3420    fcb   $44,$5E,$0E,$A1,$DB,$9F,$C3,$9E   D^.![.C.
L3428    fcb   $5F,$BE,$E3,$16,$0B,$BC,$C5,$B5   _>c..<E5
L3430    fcb   $4F,$A1,$66,$B1,$FB,$17,$53,$BE   O!f1..S>
L3438    fcb   $63,$B9,$B5,$85,$84,$14,$36,$A1   c95...6!
L3440    fcb   $59,$15,$23,$C6,$67,$66,$16,$BC   Y.#Fgf.<
L3448    fcb   $46,$48,$8B,$18,$C7,$DE,$09,$15   FH..G^..
L3450    fcb   $E6,$96,$9B,$15,$5B,$CA,$8F,$BE   f...[J.>
L3458    fcb   $56,$5E,$CF,$9C,$95,$5F,$2F,$C6   V^O.._/F
L3460    fcb   $82,$17,$5B,$61,$1B,$63,$06,$56   ..[a.c.V
L3468    fcb   $DB,$E0,$81,$8C,$49,$1F,$47,$C7   [`..I.GG
L3470    fcb   $DE,$03,$15,$61,$B7,$74,$CA,$7B   ^..a7tJ{
L3478    fcb   $14,$E7,$59,$06,$A3,$35,$49,$E3   .gY.#5Ic
L3480    fcb   $16,$19,$BC,$85,$73,$07,$71,$3F   ..<.s.q?
L3488    fcb   $D9,$4D,$98,$5C,$15,$DB,$9F,$5F   YM.\.[._
L3490    fcb   $BE,$99,$16,$C2,$B3,$89,$17,$82   >..B3...
L3498    fcb   $17,$55,$5E,$36,$A1,$19,$71,$46   .U^6!.qF
L34A0    fcb   $48,$56,$F4,$DB,$72,$96,$A5,$D5   HVt[r.%U
L34A8    fcb   $15,$89,$17,$C4,$9C,$F3,$B2,$16   ...D.s2.
L34B0    fcb   $58,$CC,$9C,$72,$C5,$2E,$8D,$20   XL.rE.. 
L34B8    fcb   $04,$1E,$5F,$BE,$66,$17,$8F,$49   .._>f..I
L34C0    fcb   $4B,$5E,$CF,$B5,$DA,$C3,$89,$17   K^O5ZC..
L34C8    fcb   $CA,$9C,$98,$5F,$48,$DB,$A3,$A0   J.._H[# 
L34D0    fcb   $C7,$DE,$89,$17,$71,$16,$7F,$CA   G^..q.J
L34D8    fcb   $8E,$3E,$04,$3C,$7A,$C4,$D9,$06   .>.<zDY.
L34E0    fcb   $82,$7B,$84,$15,$96,$5F,$03,$15   .{..._..
L34E8    fcb   $93,$66,$2E,$56,$FB,$C0,$C7,$DE   .f.V.@G^
L34F0    fcb   $63,$16,$C9,$97,$56,$5E,$CF,$9C   c.I.V^O.
L34F8    fcb   $4F,$A1,$82,$17,$43,$5E,$3B,$8E   O!..C^;.
L3500    fcb   $83,$AF,$33,$98,$C7,$DE,$03,$15   ./3.G^..
L3508    fcb   $61,$B7,$74,$CA,$7B,$14,$A5,$B7   a7tJ{.%7
L3510    fcb   $76,$B1,$DB,$16,$D3,$B9,$BF,$6C   v1[.S9?l
L3518    fcb   $8F,$07,$0D,$05,$08,$2B,$00,$A5   .....+.%
L3520    fcb   $90,$90,$22,$1F,$20,$5F,$BE,$8E   ..". _>.
L3528    fcb   $14,$54,$BD,$71,$16,$75,$CA,$AB   .T=q.uJ+
L3530    fcb   $14,$8B,$54,$6B,$BF,$A3,$B7,$16   ..Tk?#7.
L3538    fcb   $8A,$DB,$72,$7E,$74,$43,$5E,$08   .[r~tC^.
L3540    fcb   $4F,$5B,$5E,$3F,$A1,$91,$37,$0D   O[^?!.7.
L3548    fcb   $35,$1F,$30,$4B,$49,$C7,$DE,$DE   5.0KIG^^
L3550    fcb   $14,$64,$7A,$C7,$16,$11,$BC,$96   .dzG..<.
L3558    fcb   $64,$DB,$72,$7E,$74,$B3,$63,$73   d[r~t3cs
L3560    fcb   $7B,$A7,$B7,$4B,$94,$6B,$BF,$89   {'7K.k?.
L3568    fcb   $91,$D3,$78,$13,$8D,$57,$17,$33   .Sx..W.3
L3570    fcb   $48,$D3,$C5,$6A,$4D,$8E,$7A,$51   HSEjM.zQ
L3578    fcb   $18,$DB,$C7,$00,$9F,$95,$93,$09   .[G.....
L3580    fcb   $0B,$07,$0A,$36,$01,$94,$37,$01   ...6..7.
L3588    fcb   $94,$94,$19,$1F,$17,$FF,$A5,$57   ......%W
L3590    fcb   $49,$B5,$17,$46,$5E,$2F,$7B,$03   I5.F^/{.
L3598    fcb   $56,$1D,$A0,$A6,$16,$3F,$BB,$11   V. &.?;.
L35A0    fcb   $EE,$99,$AF,$2E,$95,$26,$0D,$24   n./..&.$
L35A8    fcb   $17,$36,$FF,$17,$29,$00,$17,$2A   .6..)..*
L35B0    fcb   $00,$17,$2B,$00,$17,$2C,$00,$17   ..+..,..
L35B8    fcb   $2D,$00,$17,$2E,$00,$17,$31,$00   -.....1.
L35C0    fcb   $17,$34,$00,$17,$35,$00,$17,$3A   .4..5..:
L35C8    fcb   $00,$17,$3C,$1D,$96,$1A,$04,$18   ..<.....
L35D0    fcb   $5B,$BE,$65,$BC,$7B,$14,$41,$6E   [>e<{.An
L35D8    fcb   $19,$58,$3B,$4A,$6B,$BF,$85,$8D   .X;Jk?..
L35E0    fcb   $5B,$5E,$34,$A1,$9B,$15,$31,$98   [^4!..1.
L35E8    fcb   $97,$19,$04,$17,$43,$79,$C7,$DE   ....CyG^
L35F0    fcb   $D3,$14,$88,$96,$8E,$7A,$7B,$14   S....z{.
L35F8    fcb   $C7,$93,$76,$BE,$BD,$15,$49,$90   G.v>=.I.
L3600    fcb   $67,$48,$21,$98,$24,$04,$22,$0F   gH!.$.".
L3608    fcb   $A0,$5F,$17,$46,$48,$66,$17,$D3    _.FHf.S
L3610    fcb   $61,$04,$68,$63,$16,$5B,$99,$56   a.hc.[.V
L3618    fcb   $98,$C0,$16,$49,$5E,$90,$78,$0E   .@.I^.x.
L3620    fcb   $BC,$92,$5F,$59,$15,$9B,$AF,$19   <._Y../.
L3628    fcb   $A1,$00,$04,$52,$45,$41,$44,$01   !..READ.
L3630    fcb   $03,$47,$45,$54,$09,$05,$54,$48   .GET..TH
L3638    fcb   $52,$4F,$57,$03,$06,$41,$54,$54   ROW..ATT
L3640    fcb   $41,$43,$4B,$04,$04,$4B,$49,$4C   ACK..KIL
L3648    fcb   $4C,$04,$03,$48,$49,$54,$04,$05   L..HIT..
L3650    fcb   $4E,$4F,$52,$54,$48,$05,$01,$4E   NORTH..N
L3658    fcb   $05,$05,$53,$4F,$55,$54,$48,$06   ..SOUTH.
L3660    fcb   $01,$53,$06,$04,$45,$41,$53,$54   .S..EAST
L3668    fcb   $07,$01,$45,$07,$04,$57,$45,$53   ..E..WES
L3670    fcb   $54,$08,$01,$57,$08,$04,$54,$41   T..W..TA
L3678    fcb   $4B,$45,$09,$04,$44,$52,$4F,$50   KE..DROP
L3680    fcb   $0A,$03,$50,$55,$54,$0A,$06,$49   ..PUT..I
L3688    fcb   $4E,$56,$45,$4E,$54,$0B,$04,$4C   NVENT..L
L3690    fcb   $4F,$4F,$4B,$0C,$04,$47,$49,$56   OOK..GIV
L3698    fcb   $45,$0D,$05,$4F,$46,$46,$45,$52   E..OFFER
L36A0    fcb   $0D,$06,$45,$58,$41,$4D,$49,$4E   ..EXAMIN
L36A8    fcb   $0E,$06,$53,$45,$41,$52,$43,$48   ..SEARCH
L36B0    fcb   $0E,$04,$4F,$50,$45,$4E,$0F,$04   ..OPEN..
L36B8    fcb   $50,$55,$4C,$4C,$10,$05,$4C,$49   PULL..LI
L36C0    fcb   $47,$48,$54,$11,$04,$42,$55,$52   GHT..BUR
L36C8    fcb   $4E,$11,$03,$45,$41,$54,$12,$05   N..EAT..
L36D0    fcb   $54,$41,$53,$54,$45,$12,$04,$42   TASTE..B
L36D8    fcb   $4C,$4F,$57,$13,$06,$45,$58,$54   LOW..EXT
L36E0    fcb   $49,$4E,$47,$14,$05,$43,$4C,$49   ING..CLI
L36E8    fcb   $4D,$42,$15,$03,$52,$55,$42,$16   MB..RUB.
L36F0    fcb   $04,$57,$49,$50,$45,$16,$06,$50   .WIPE..P
L36F8    fcb   $4F,$4C,$49,$53,$48,$16,$04,$4C   OLISH..L
L3700    fcb   $49,$46,$54,$1C,$04,$57,$41,$49   IFT..WAI
L3708    fcb   $54,$1F,$04,$53,$54,$41,$59,$1F   T..STAY.
L3710    fcb   $04,$4A,$55,$4D,$50,$20,$02,$47   .JUMP .G
L3718    fcb   $4F,$21,$03,$52,$55,$4E,$21,$05   O!.RUN!.
L3720    fcb   $45,$4E,$54,$45,$52,$21,$04,$50   ENTER!.P
L3728    fcb   $55,$53,$48,$10,$04,$4D,$4F,$56   USH..MOV
L3730    fcb   $45,$10,$04,$4B,$49,$43,$4B,$23   E..KICK#
L3738    fcb   $04,$46,$45,$45,$44,$24,$05,$53   .FEED$.S
L3740    fcb   $43,$4F,$52,$45,$28,$06,$53,$43   CORE(.SC
L3748    fcb   $52,$45,$41,$4D,$2B,$04,$59,$45   REAM+.YE
L3750    fcb   $4C,$4C,$2B,$04,$51,$55,$49,$54   LL+.QUIT
L3758    fcb   $2D,$04,$53,$54,$4F,$50,$2D,$05   -.STOP-.
L3760    fcb   $50,$4C,$55,$47,$48,$32,$05,$4C   PLUGH2.L
L3768    fcb   $45,$41,$56,$45,$2C,$04,$50,$49   EAVE,.PI
L3770    fcb   $43,$4B,$34,$00,$06,$50,$4F,$54   CK4..POT
L3778    fcb   $49,$4F,$4E,$03,$03,$52,$55,$47   ION..RUG
L3780    fcb   $06,$04,$44,$4F,$4F,$52,$09,$04   ..DOOR..
L3788    fcb   $46,$4F,$4F,$44,$0C,$06,$53,$54   FOOD..ST
L3790    fcb   $41,$54,$55,$45,$0D,$05,$53,$57   ATUE..SW
L3798    fcb   $4F,$52,$44,$0E,$06,$47,$41,$52   ORD..GAR
L37A0    fcb   $47,$4F,$59,$0F,$04,$52,$49,$4E   GOY..RIN
L37A8    fcb   $47,$12,$03,$47,$45,$4D,$13,$05   G..GEM..
L37B0    fcb   $4C,$45,$56,$45,$52,$16,$06,$50   LEVER..P
L37B8    fcb   $4C,$41,$51,$55,$45,$18,$05,$52   LAQUE..R
L37C0    fcb   $55,$4E,$45,$53,$18,$04,$53,$49   UNES..SI
L37C8    fcb   $47,$4E,$18,$06,$4D,$45,$53,$53   GN..MESS
L37D0    fcb   $41,$47,$18,$06,$43,$41,$4E,$44   AG..CAND
L37D8    fcb   $4C,$45,$19,$04,$4C,$41,$4D,$50   LE..LAMP
L37E0    fcb   $1B,$06,$43,$48,$4F,$50,$53,$54   ..CHOPST
L37E8    fcb   $1E,$04,$48,$41,$4E,$44,$1F,$05   ..HAND..
L37F0    fcb   $48,$41,$4E,$44,$53,$1F,$04,$43   HANDS..C
L37F8    fcb   $4F,$49,$4E,$20,$04,$53,$4C,$4F   OIN .SLO
L3800    fcb   $54,$21,$05,$41,$4C,$54,$41,$52   T!.ALTAR
L3808    fcb   $22,$04,$49,$44,$4F,$4C,$23,$06   ".IDOL#.
L3810    fcb   $53,$45,$52,$50,$45,$4E,$24,$05   SERPEN$.
L3818    fcb   $53,$4E,$41,$4B,$45,$24,$04,$57   SNAKE$.W
L3820    fcb   $41,$4C,$4C,$25,$05,$57,$41,$4C   ALL%.WAL
L3828    fcb   $4C,$53,$25,$04,$56,$49,$4E,$45   LS%.VINE
L3830    fcb   $26,$05,$56,$49,$4E,$45,$53,$26   &.VINES&
L3838    fcb   $04,$47,$41,$54,$45,$27,$05,$47   .GATE'.G
L3840    fcb   $41,$54,$45,$53,$27,$05,$47,$55   ATES'.GU
L3848    fcb   $41,$52,$44,$28,$06,$47,$55,$41   ARD(.GUA
L3850    fcb   $52,$44,$53,$28,$04,$52,$4F,$4F   RDS(.ROO
L3858    fcb   $4D,$2A,$05,$46,$4C,$4F,$4F,$52   M*.FLOOR
L3860    fcb   $2B,$04,$45,$58,$49,$54,$2C,$06   +.EXIT,.
L3868    fcb   $50,$41,$53,$53,$41,$47,$2D,$04   PASSAG-.
L3870    fcb   $48,$4F,$4C,$45,$2E,$06,$43,$4F   HOLE..CO
L3878    fcb   $52,$52,$49,$44,$2F,$03,$42,$4F   RRID/.BO
L3880    fcb   $57,$31,$05,$41,$52,$52,$4F,$57   W1.ARROW
L3888    fcb   $32,$06,$48,$41,$4C,$4C,$57,$41   2.HALLWA
L3890    fcb   $33,$06,$43,$48,$41,$4D,$42,$45   3.CHAMBE
L3898    fcb   $34,$05,$56,$41,$55,$4C,$54,$35   4.VAULT5
L38A0    fcb   $06,$45,$4E,$54,$52,$41,$4E,$36   .ENTRAN6
L38A8    fcb   $06,$54,$55,$4E,$4E,$45,$4C,$37   .TUNNEL7
L38B0    fcb   $06,$4A,$55,$4E,$47,$4C,$45,$38   .JUNGLE8
L38B8    fcb   $06,$54,$45,$4D,$50,$4C,$45,$39   .TEMPLE9
L38C0    fcb   $03,$50,$49,$54,$3A,$06,$43,$45   .PIT:.CE
L38C8    fcb   $49,$4C,$49,$4E,$3B,$00,$00,$02   ILIN;...
L38D0    fcb   $54,$4F,$01,$04,$57,$49,$54,$48   TO..WITH
L38D8    fcb   $02,$02,$41,$54,$03,$05,$55,$4E   ..AT..UN
L38E0    fcb   $44,$45,$52,$04,$02,$49,$4E,$05   DER..IN.
L38E8    fcb   $04,$49,$4E,$54,$4F,$05,$03,$4F   .INTO..O
L38F0    fcb   $55,$54,$06,$02,$55,$50,$07,$04   UT..UP..
L38F8    fcb   $44,$4F,$57,$4E,$08,$04,$4F,$56   DOWN..OV
L3900    fcb   $45,$52,$09,$06,$42,$45,$48,$49   ER..BEHI
L3908    fcb   $4E,$44,$0A,$06,$41,$52,$4F,$55   ND..AROU
L3910    fcb   $4E,$44,$0B,$02,$4F,$4E,$0C,$00   ND..ON..
L3918    fcb   $03,$CE,$80,$01,$03,$00,$00,$40   .N.....@
L3920    fcb   $FF                                .

os9read  pshs  y,x,d
         clra
         leax  ,s
         ldy   #$0001
         os9   I$Read
ok       puls  d,x,y,pc
         
os9write pshs  y,x,d
         cmpa  #$0D
         beq   WriteCR
         lda   #$01
         leax  ,s
         ldy   #$0001
         os9   I$Write
         bra   DoCHROUT
WriteCR
         lda   #$01
         leax  ,s
         ldy   #$0001
         os9   I$WritLn
DoCHROUT
         puls  d,x,y
         pshs  x,b,a
         ldx   $88
         cmpa  #$08
         bne   LA31D
         cmpx  #$400
         beq   LA35D
         lda   #$60
         sta   ,-x
         bra   LA344
LA31D    cmpa  #$0D
         bne   LA32F
         ldx   $88
LA323    lda   #$60
         sta   ,x+
         tfr   x,d
         bitb  #$1F
         bne   LA323
         bra   LA344
LA32F    cmpa  #$20
         bcs   LA35D
         tsta
         bmi   LA342
         cmpa  #$40
         bcs   LA340
         CMPA  #$60
         bcs   LA342
         anda  #$DF
LA340    eora  #$40
LA342    sta   ,x+
LA344    stx   $88
         cmpx  #$400+511
         bls   LA35D
         ldx   #$400

* SCROLL SCREEN
LA34E    ldd   32,x
         std   ,x++
         cmpx  #$400+$1E0
         bcs   LA34E
         ldb   #$60
LA92D    stx   $88
LA92F    stb   ,x+
         cmpx  #$400+511
         bls   LA92F
LA35D    puls  d,x,pc

os9exit  os9   F$Exit
realsize equ   *-realstart

         emod
eom      equ   *
         end

