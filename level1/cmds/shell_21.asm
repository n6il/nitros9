********************************************************************
* Shell - OS-9 Command Interpreter
*
* $Id$
*
* Ed.    Comments                                       Who YY/MM/DD
* ------------------------------------------------------------------
* 20     Original Microware distribution version

         nam   Shell
         ttl   OS-9 Command Interpreter

* Disassembled 02/04/03 22:01:32 by Disasm v1.6 (C) 1988 by RML

         ifp1
         use   defsfile
         endc

tylg     set   Prgrm+Objct   
atrv     set   ReEnt+rev
rev      set   $01

         mod   eom,name,tylg,atrv,start,size

u0000    rmb   1
u0001    rmb   2
u0003    rmb   1
u0004    rmb   1
u0005    rmb   1
u0006    rmb   2
u0008    rmb   2
u000A    rmb   1
u000B    rmb   1
u000C    rmb   1
u000D    rmb   1
u000E    rmb   1
u000F    rmb   1
u0010    rmb   1
u0011    rmb   1
u0012    rmb   1
u0013    rmb   4
u0017    rmb   14
u0025    rmb   1
u0026    rmb   7
u002D    rmb   17
u003E    rmb   5
u0043    rmb   8
u004B    rmb   19
u005E    rmb   46
u008C    rmb   1
u008D    rmb   25
u00A6    rmb   4
u00AA    rmb   17
u00BB    rmb   25
u00D4    rmb   3
u00D7    rmb   40
u00FF    rmb   438
size     equ   .

name     fcs   /Shell/
         fcb   $14 
L0013    fcb   $13 
         fcb   $50 P
         fcb   $61 a
         fcb   $73 s
         fcb   $63 c
         fcb   $61 a
         fcb   $6C l
         fcb   $D3 S
         fcb   $25 %
         fcb   $52 R
         fcb   $75 u
         fcb   $6E n
         fcb   $C3 C
         fcb   $22 "
         fcb   $52 R
         fcb   $75 u
         fcb   $6E n
         fcb   $C2 B
         fcb   $00 
         fcb   $00 
         fcb   $00 
         fcb   $00 
         fcb   $00 
         fcb   $00 
         fcb   $00 
         fcb   $00 
         fcb   $00 
L002E    fcb   C$LF
         fcc   "Shell"
         fcb   C$CR
L0035    fcb   C$LF
L0036    fcc   "OS9:"

L003A    stb   <u000E
         rti

start    leas  -$05,s
         pshs  y,x,b,a
         ldb   #$24
         lbsr  L00C9
         leax  <L003A,pcr
         os9   F$Icpt   
         puls  x,b,a
         std   <u0006
         beq   L005B
         lbsr  L0131
         bcs   L00BC
         tst   <u000C
         bne   L00BB
L005B    lds   ,s++
         leax  <L002E,pcr
         tst   <u000F
         bne   L0074
         bsr   L00BF
L0067    leax  <L0035,pcr
         ldy   #$0005
L006E    tst   <u000F
         bne   L0074
         bsr   L00C3
L0074    clra  
         leax  <u0025,u
         ldy   #$00C8
         os9   I$ReadLn 
         bcc   L008E
         cmpb  #$D3
         beq   L00B2
L0085    tst   <u0011
         bne   L00BC
         os9   F$PErr   
         bra   L0067
L008E    cmpy  #$0001
         bhi   L009E
         leax  >L0036,pcr
         ldy   #$0004
         bra   L006E
L009E    tst   <u0010
         beq   L00A4
         bsr   L00BF
L00A4    lbsr  L0131
         bcc   L0067
         tstb  
         bne   L0085
         bra   L0067
L00AE    fcc   "eof"
         fcb   C$CR
L00B2    tst   <u000F
         bne   L00BB
         leax  <L00AE,pcr
         bsr   L00BF
L00BB    clrb  
L00BC    os9   F$Exit   
L00BF    ldy   #$0050
L00C3    lda   #$02
         os9   I$WritLn 
         rts   
L00C9    clr   b,u
L00CB    decb  
         bpl   L00C9
         rts   
L00CF    fdb   L0286-*
         fcs   "*"
         fdb   L035B-*
         fcs   "W"
         fdb   L0268-*
         fcs   "CHD"
         fdb   L0264-*
         fcs   "CHX"
         fdb   L023E-*
         fcs   "EX"
         fdb   L04BC-* 
         fcs   "KILL"
         fdb   L027E-*
         fcs   "X"
         fdb   L0282-*
         fcs   "-X"
         fdb   L026E-*
         fcs   "P"
         fdb   L0271-*
         fcs   "-P"
         fdb   L0276-*
         fcs   "T"
         fdb   L027A-*
         fcs   "-T"
         fdb   L04E8-*
         fcs   "SETPR"
         fdb   L0209-*
         fcs   ";"
         fdb   $0000
L010A    fcb   $03
         fcb   $5E       ^ symbol
         fcb   $A1       ! symbol
         fdb   L0334-*
         fcs   ";"
         fdb   L034D-*
         fcs   "&"
         fdb   L032D-*
         fcb   $8D
L0116    fdb   L02CE-*
         fcs   ">>"
         fdb   L02C9-*
         fcs   "<"
         fdb   L02D5-*
         fcs   ">"
         fdb   L030F-*
         fcs   "#"
         fdb   $0000
L0125    fcb   $0d
         fcc   "()"
         fcb   $FF
L0129    fcb   $0D
         fcb   $21,$23,$26,$3b,$3c,$3e,$ff
L0131    fcb   $c6,$0E,$8d,$94
L0135    clr   <u0003
         clr   <u000E
         leay  <L00CF,pcr
         lbsr  L01C3
         bcs   L0192
         cmpa  #$0D
         beq   L0192
         sta   <u000C
         cmpa  #$28
         bne   L016F
         leay  >name,pcr
         sty   <u0004
         leax  $01,x
         stx   <u0008
L0156    inc   <u000D
L0158    leay  <L0125,pcr
         bsr   L01DB
         cmpa  #$28
         beq   L0156
         cmpa  #$29
         bne   L018A
         dec   <u000D
         bne   L0158
         lda   #$0D
         sta   -$01,x
         bra   L0173
L016F    bsr   L0195
         bcs   L0192
L0173    leay  <L0129,pcr
         bsr   L01DB
         tfr   x,d
         subd  <u0008
         std   <u0006
         leax  -$01,x
         leay  <L010A,pcr
         bsr   L01C3
         bcs   L0192
         ldy   <u0004
L018A    lbne  L02BE
         cmpa  #$0D
         bne   L0135
L0192    lbra  L028F
L0195    stx   <u0004
         bsr   L01A8
         bcs   L01A7
L019B    bsr   L01A8
         bcc   L019B
         leay  >L0116,pcr
         bsr   L01C3
         stx   <u0008
L01A7    rts   
L01A8    os9   F$PrsNam 
         bcc   L01B9
         lda   ,x+
         cmpa  #$2E
         bne   L01BD
         cmpa  ,x+
         beq   L01BB
         leay  -$01,x
L01B9    leax  ,y
L01BB    clra  
         rts   
L01BD    comb  
         leax  -$01,x
         ldb   #$D7
         rts   
L01C3    bsr   L01E9
         pshs  y
         bsr   L020C
         bcs   L01D4
         ldd   ,y
         jsr   d,y
         puls  y
         bcc   L01C3
         rts   
L01D4    clra  
         lda   ,x
         puls  pc,y
L01D9    puls  y
L01DB    pshs  y
         lda   ,x+
L01DF    tst   ,y
         bmi   L01D9
         cmpa  ,y+
         bne   L01DF
         puls  pc,y
L01E9    pshs  x
         lda   ,x+
         cmpa  #$20
         beq   L01FF
         cmpa  #$2C
         beq   L01FF
         leax  >L0129,pcr
L01F9    cmpa  ,x+
         bhi   L01F9
         puls  pc,x
L01FF    leas  $02,s
         lda   #$20
L0203    cmpa  ,x+
         beq   L0203
         leax  -$01,x
L0209    andcc #$FE
         rts   
L020C    pshs  y,x
         leay  $02,y
L0210    ldx   ,s
L0212    lda   ,x+
         cmpa  #$61
         bcs   L021A
         suba  #$20
L021A    eora  ,y+
         lsla  
         bne   L022E
         bcc   L0212
         lda   -$01,y
         cmpa  #$C1
         bcs   L022B
         bsr   L01E9
         bcs   L022E
L022B    clra  
         puls  pc,y,b,a
L022E    leay  -$01,y
L0230    lda   ,y+
         bpl   L0230
         sty   $02,s
         ldd   ,y++
         bne   L0210
         comb  
         puls  pc,y,x
L023E    lbsr  L0195
         clra  
         bsr   L0260
         bsr   L025F
         bsr   L025F
         bsr   L0286
         leax  $01,x
         tfr   x,d
         subd  <u0008
         std   <u0006
         leas  >u00FF,u
         lbsr  L0394
         os9   F$Chain  
         os9   F$Exit   
L025F    inca  
L0260    pshs  a
         bra   L02AB
L0264    lda   #$84
         bra   L026A
L0268    lda   #$83
L026A    os9   I$ChgDir 
         rts   
L026E    clra  
         bra   L0273
L0271    lda   #$01
L0273    sta   <u000F
         rts   
L0276    lda   #$01
         bra   L027B
L027A    clra  
L027B    sta   <u0010
         rts   
L027E    lda   #$01
         bra   L0283
L0282    clra  
L0283    sta   <u0011
         rts   
L0286    lda   #$0D
L0288    cmpa  ,x+
         bne   L0288
         cmpa  ,-x
         rts   
L028F    pshs  b,a,cc
         clra  
L0292    bsr   L029D
         inca  
         cmpa  #$02
         bls   L0292
         ror   ,s+
         puls  pc,b,a
L029D    pshs  a
         tst   a,u
         beq   L02B6
         os9   I$Close  
         lda   a,u
         os9   I$Dup    
L02AB    ldb   ,s
         lda   b,u
         beq   L02B6
         clr   b,u
         os9   I$Close  
L02B6    puls  pc,a
L02B8    asrb  
         lsla  
         fcb   $41 A
         lsrb  
         swi   
         fcb   $0D 
L02BE    bsr   L028F
         leax  <L02B8,pcr
         lbsr  L00BF
         clrb  
         coma  
         rts   
L02C9    ldd   #$0001
         bra   L02E3
L02CE    ldd   #$020D
         stb   -$02,x
         bra   L02D7
L02D5    lda   #$01
L02D7    ldb   #$02
         bra   L02E3
         tst   a,u
         bne   L02BE
         pshs  b,a
         bra   L02ED
L02E3    tst   a,u
         bne   L02BE
         pshs  b,a
         ldb   #$0D
         stb   -$01,x
L02ED    os9   I$Dup    
         bcs   L030D
         ldb   ,s
         sta   b,u
         lda   ,s
         os9   I$Close  
         lda   $01,s
         bita  #$02
         bne   L0306
         os9   I$Open   
         bra   L030B
L0306    ldb   #$0B
         os9   I$Create 
L030B    stb   $01,s
L030D    puls  pc,b,a
L030F    ldb   #$0D
         stb   -$01,x
         ldb   <u0003
         bne   L02BE
         lbsr  L04CA
         eora  #$4B
         anda  #$DF
         bne   L0328
         leax  $01,x
         lda   #$04
         mul   
         tsta  
         bne   L02BE
L0328    stb   <u0003
         lbra  L01E9
L032D    leax  -$01,x
         lbsr  L03C7
         bra   L0337
L0334    lbsr  L03C3
L0337    bcs   L034A
         lbsr  L028F
         bsr   L035C
L033E    bcs   L034A
         lbsr  L01E9
         cmpa  #$0D
         bne   L0349
         leas  $04,s
L0349    clrb  
L034A    lbra  L028F
L034D    lbsr  L03C3
         bcs   L034A
         bsr   L034A
         ldb   #$26
         lbsr  L0495
         bra   L033E
L035B    clra  
L035C    pshs  a
L035E    os9   F$Wait   
         tst   <u000E
         beq   L0376
         ldb   <u000E
         cmpb  #$02
         bne   L038E
         lda   ,s
         beq   L038E
         os9   F$Send   
         clr   ,s
         bra   L035E
L0376    bcs   L0392
         cmpa  ,s
         beq   L038E
         tst   ,s
         beq   L0383
         tstb  
         beq   L035E
L0383    pshs  b
         bsr   L034A
         ldb   #$2D
         lbsr  L0495
         puls  b
L038E    tstb  
         beq   L0392
         coma  
L0392    puls  pc,a
L0394    lda   #$11
         ldb   <u0003
         ldx   <u0004
         ldy   <u0006
         ldu   <u0008
         rts   
L03A0    lda   #$04
         os9   I$Open   
         bcs   L03FE
         leax  <u0013,u
         ldy   #$000D
         os9   I$Read   
         pshs  b,cc
         os9   I$Close  
         puls  b,cc
         lbcs  L045F
         lda   $06,x
         ldy   $0B,x
         bra   L03D7
L03C3    lda   #$0D
         sta   -$01,x
L03C7    pshs  u,y,x
         clra  
         ldx   <u0004
         os9   F$Link   
         bcs   L03A0
         ldy   u000B,u
         os9   F$UnLink 
L03D7    cmpa  #$11
         beq   L0425
         sty   <u000A
         leax  >L0013,pcr
L03E2    tst   ,x
         beq   L045D
         cmpa  ,x+
         beq   L03F0
L03EA    tst   ,x+
         bpl   L03EA
         bra   L03E2
L03F0    ldd   <u0008
         subd  <u0004
         addd  <u0006
         std   <u0006
         ldd   <u0004
         std   <u0008
         bra   L0423
L03FE    ldx   <u0006
         leax  $05,x
         stx   <u0006
         ldx   <u0004
         ldu   $04,s
         lbsr  L02C9
         bcs   L045F
         ldu   <u0008
         ldd   #$5820
         std   ,--u
         ldd   #$5020
         std   ,--u
         ldb   #$2D
         stb   ,-u
         stu   <u0008
         leax  >name,pcr
L0423    stx   <u0004
L0425    ldx   <u0004
         lda   #$11
         os9   F$Link   
         bcc   L0433
         os9   F$Load   
         bcs   L045F
L0433    pshs  u
         tst   <u0003
         bne   L0442
         ldd   u000B,u
         addd  <u000A
         addd  #$00FF
         sta   <u0003
L0442    lbsr  L0394
         os9   F$Fork   
         puls  u
         pshs  b,cc
         bcs   L0454
         ldx   #$0001
         os9   F$Sleep  
L0454    clr   <u0004
         clr   <u0005
         os9   F$UnLink 
         puls  pc,u,y,x,b,cc
L045D    ldb   #$EA

L045F    coma  
         puls  pc,u,y,x

L0462    fcc   "/pipe"
         fcb   C$CR
L0468    fcb   $34,$10,$30,$8c,$f5,$cc,$01,$03
         fdb   $17FE,$6835,$1025,$5217,$FF49,$254D,$A6C4,$2607
         os9   I$Dup    
         bcs   L04C9
         sta   ,u
L0487    clra  
         os9   I$Close  
         lda   #$01
         os9   I$Dup    
         lda   #$01
         lbra  L029D
L0495    pshs  y,x,b,a
         pshs  y,x,b
         leax  $01,s
         ldb   #$2F
L049D    incb  
         suba  #$64
         bcc   L049D
         stb   ,x+
         ldb   #$3A
L04A6    decb  
         adda  #$0A
         bcc   L04A6
         stb   ,x+
         adda  #$30
         ldb   #$0D
         std   ,x
         leax  ,s
         lbsr  L00BF
         leas  $05,s
         puls  pc,y,x,b,a
L04BC    bsr   L04CA
         cmpb  #$02
         bcs   L04E5
         tfr   b,a
         ldb   #$00
         os9   F$Send   
L04C9    rts   
L04CA    clrb  
L04CB    lda   ,x+
         suba  #$30
         cmpa  #$09
         bhi   L04DC
         pshs  a
         lda   #$0A
         mul   
         addb  ,s+
         bcc   L04CB
L04DC    lda   ,-x
         bcs   L04E3
         tstb  
         bne   L04C9
L04E3    leas  $02,s
L04E5    lbra  L02BE
L04E8    bsr   L04CA
         stb   <u0012
         lbsr  L01E9
         bsr   L04CA
         lda   <u0012
         os9   F$SPrior 
         rts   
         emod
eom      equ   *
