********************************************************************
* Shell - OS-9 command line interpreter
*
* $Id$
*
* Ed.    Comments                                       Who YY/MM/DD
* ------------------------------------------------------------------
* 21     Original Tandy/Microware version

         nam   Shell
         ttl   OS-9 command line interpreter

* Disassembled 99/04/18 22:59:49 by Disasm v1.6 (C) 1988 by RML

         ifp1
         use   defsfile
         endc

tylg     set   Prgrm+Objct   
atrv     set   ReEnt+rev
rev      set   $01
edition  set   21

         mod   eom,name,tylg,atrv,start,size

u0000    rmb   1
u0001    rmb   2
u0003    rmb   1
u0004    rmb   1
u0005    rmb   1
u0006    rmb   2
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
u0017    rmb   22
u002D    rmb   3
u0030    rmb   14
u003E    rmb   32
u005E    rmb   2
u0060    rmb   16
u0070    rmb   58
u00AA    rmb   85
u00FF    rmb   513
size     equ   .
name     equ   *

L000D    fcs   /Shell/
         fcb   edition

L0013    fcb   $13 
         fcs   "PascalS"
         fcb   $25 %
         fcs   "RunC"
         fcb   $22 "
         fcs   "RunB"
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
L003A    fcs   "W"
         fcb   $0E 
         fcc   ";"

start    leas  -$05,s
         pshs  y,x,b,a
         ldb   #$6F
         lbsr  L0175
         leax  <L003A,pcr
         os9   F$Icpt   
         puls  x,b,a
         std   <u0006
         beq   L005B
         lbsr  L017B
         bcs   L00C2
         tst   <u000C
         bne   L00C1
L005B    lds   ,s++
L005E    leax  <L002E,pcr
         tst   <u0012
         bne   L0076
         bsr   L00CB
         bcs   L00C8
L0069    leax  <L0035,pcr
         ldy   #$0005
L0070    tst   <u0012
         bne   L0076
         bsr   L00CF
L0076    clra  
         leax  <u0070,u
         ldy   #$00C8
         os9   I$ReadLn 
         bcc   L0094
         cmpb  #$D3
         beq   L00B8
L0087    tst   <u000F
         bne   L008F
         tst   <u0014
         bne   L00C2
L008F    os9   F$PErr   
         bra   L0069
L0094    cmpy  #$0001
         bhi   L00A4
         leax  >L0036,pcr
         ldy   #$0004
         bra   L0070
L00A4    tst   <u0013
         beq   L00AA
         bsr   L00CB
L00AA    lbsr  L017B
         bcc   L0069
         tstb  
         bne   L0087
         bra   L0069
L00B4    fcc   "eof"
         fcb   C$CR
L00B8    tst   <u0012
         bne   L00C1
         leax  <L00B4,pcr
         bsr   L00CB
L00C1    clrb  
L00C2    lda   <u000F
         lbne  L0331
L00C8    os9   F$Exit   
L00CB    ldy   #$0050
L00CF    lda   #$02
         os9   I$WritLn 
         rts   
         lbsr  L03B3
         lbcs  L02ED
         pshs  x
         ldb   #$0E
         leax  <u0016,u
         lda   #$2F
         sta   ,x+
         clra  
         os9   I$GetStt 
         puls  x
         lbcs  L02ED
         inc   <u000F
         inc   <u0010
         lbsr  L02ED
         clr   <u0010
         rts   
L00FB    fcb   $01,$e3,$aa,$03,$60
L0100    fcs   "W"
         fcb   $01,$BF
         fcs   "CHD"
         fcb   $01,$B6
         fcs   "CHX"
         fcb   $01,$8B
         fcs   "EX"
         fcb   $04,$AF
         fcs   "KILL"
         fcb   $01,$C1
         fcb   $d8,$01,$c2,$2d,$d8,$01,$aa,$d0,$01
         fcb   $aa
         fcs   "-P"
         fcb   $01,$ab
         fcs   "T"
         fcb   $01,$ac
         fcs   "-T"
         fcb   $04,$c0
         fcs   "SETPR"
         fcb   $FF,$a4
         fcs   "I="
         fcb   $01,$2c
         fcs   ";"
         fcb   $00,$00
L013A    fcb   $04,$30,$a1,$02,$fb,$bb,$03,$11
         fcs   "&"
         fcb   $02,$ee,$8d
L0146    fcb   $02,$69
         fcs   "<>>>"
         fcb   $02,$79
         fcs   "<>>"
         fcb   $02,$67
         fcs   "<>"
         fcb   $02,$7d
         fcs   ">>>"
         fcb   $01,$fb
         fcs   ">>"
         fcb   $01,$f2
         fcs   "<"
         fcb   $01,$fb
         fcs   ">"
         fcb   $02,$ab
         fcs   "#"
         fcb   $00,$00
L0169    fcb   $0d
         fcc   "()"
         fcb   $ff
L016D    fcb   $0d
         fcc   "!#&;<>"
         fcb   $ff

L0175    clr   b,u
         decb  
         bpl   L0175
         rts   
L017B    ldb   #$0E
         bsr   L0175
L017F    clr   <u0003
         clr   <u000E
         leay  >L00FB,pcr
         lbsr  L020F
         bcs   L01DE
         cmpa  #$0D
         beq   L01DE
         sta   <u000C
         cmpa  #$28
         bne   L01BA
         leay  >L000D,pcr
         sty   <u0004
         leax  $01,x
         stx   <u0008
L01A1    inc   <u000D
L01A3    leay  <L0169,pcr
         bsr   L0227
         cmpa  #$28
         beq   L01A1
         cmpa  #$29
         bne   L01D6
         dec   <u000D
         bne   L01A3
         lda   #$0D
         sta   -$01,x
         bra   L01BE
L01BA    bsr   L01E1
         bcs   L01DE
L01BE    leay  <L016D,pcr
         bsr   L0227
         tfr   x,d
         subd  <u0008
         std   <u0006
         leax  -$01,x
         leay  >L013A,pcr
         bsr   L020F
         bcs   L01DE
         ldy   <u0004
L01D6    lbne  L0326
         cmpa  #$0D
         bne   L017F
L01DE    lbra  L02ED
L01E1    stx   <u0004
         bsr   L01F4
         bcs   L01F3
L01E7    bsr   L01F4
         bcc   L01E7
         leay  >L0146,pcr
         bsr   L020F
         stx   <u0008
L01F3    rts   
L01F4    os9   F$PrsNam 
         bcc   L0205
         lda   ,x+
         cmpa  #$2E
         bne   L0209
         cmpa  ,x+
         beq   L0207
         leay  -$01,x
L0205    leax  ,y
L0207    clra  
         rts   
L0209    comb  
         leax  -$01,x
         ldb   #$D7
         rts   
L020F    bsr   L0241
         pshs  y
         bsr   L0264
         bcs   L0220
         ldd   ,y
         jsr   d,y
         puls  y
         bcc   L020F
         rts   
L0220    clra  
         lda   ,x
         puls  pc,y
L0225    puls  y
L0227    pshs  y
         lda   ,x+
L022B    tst   ,y
         bmi   L0225
         cmpa  #$22
         bne   L023B
L0233    lda   ,x+
         cmpa  #$22
         bne   L0233
         lda   ,x+
L023B    cmpa  ,y+
         bne   L022B
         puls  pc,y
L0241    pshs  x
         lda   ,x+
         cmpa  #$20
         beq   L0257
         cmpa  #$2C
         beq   L0257
         leax  >L016D,pcr
L0251    cmpa  ,x+
         bhi   L0251
         puls  pc,x
L0257    leas  $02,s
         lda   #$20
L025B    cmpa  ,x+
         beq   L025B
         leax  -$01,x
         andcc #^Carry
         rts   
L0264    pshs  y,x
         leay  $02,y
L0268    ldx   ,s
L026A    lda   ,x+
         cmpa  #$61
         bcs   L0272
         suba  #$20
L0272    eora  ,y+
         lsla  
         bne   L0286
         bcc   L026A
         lda   -$01,y
         cmpa  #$C1
         bcs   L0283
         bsr   L0241
         bcs   L0286
L0283    clra  
         puls  pc,y,b,a
L0286    leay  -$01,y
L0288    lda   ,y+
         bpl   L0288
         sty   $02,s
         ldd   ,y++
         bne   L0268
         comb  
         puls  pc,y,x
         lbsr  L01E1
         clra  
         bsr   L02B8
         bsr   L02B7
         bsr   L02B7
         bsr   L02DE
         leax  $01,x
         tfr   x,d
         subd  <u0008
         std   <u0006
         leas  >u00FF,u
         lbsr  L0497
         os9   F$Chain  
         lbra  L00C2
L02B7    inca  
L02B8    pshs  a
         bra   L0313
         lda   #$84
         bra   L02C2
         lda   #$83
L02C2    os9   I$ChgDir 
         rts   
         clra  
         bra   L02CB
         lda   #$01
L02CB    sta   <u0012
         rts   
         lda   #$01
         bra   L02D3
         clra  
L02D3    sta   <u0013
         rts   
         lda   #$01
         bra   L02DB
         clra  
L02DB    sta   <u0014
         rts   
L02DE    lda   #$0D
L02E0    cmpa  ,x+
         bne   L02E0
         cmpa  ,-x
         rts   
L02E7    pshs  b,a,cc
         lda   #$01
         bra   L02F1
L02ED    pshs  b,a,cc
         lda   #$02
L02F1    sta   <u0011
         clra  
L02F4    bsr   L02FF
         inca  
         cmpa  <u0011
         bls   L02F4
         ror   ,s+
         puls  pc,b,a
L02FF    pshs  a
         tst   <u0010
         bmi   L031B
         bne   L0313
         tst   a,u
         beq   L031E
         os9   I$Close  
         lda   a,u
         os9   I$Dup    
L0313    ldb   ,s
         lda   b,u
         beq   L031E
         clr   b,u
L031B    os9   I$Close  
L031E    puls  pc,a
L0320    fcc   "WHAT?"
         fcb   C$CR
L0326    bsr   L02ED
         leax  <L0320,pcr
         lbsr  L00CB
         clrb  
         coma  
         rts   
L0331    inc   <u0010
         bsr   L02ED
         lda   #$FF
         sta   <u0010
         bsr   L02E7
         leax  <u0016,u
         bsr   L03BC
         lbcs  L00C8
         lda   #$02
         bsr   L02FF
         lbsr  L03DC
         clr   <u0010
         lbra  L005E
L0350    ldd   #$0001
         bra   L036E
         ldd   #$020D
         stb   -$02,x
         bra   L035E
         lda   #$01
L035E    ldb   #$02
         bra   L036E
L0362    tst   a,u
         bne   L0326
         pshs  b,a
         tst   <u0010
         bmi   L0386
         bra   L0378
L036E    tst   a,u
         bne   L0326
         pshs  b,a
         ldb   #$0D
         stb   -$01,x
L0378    os9   I$Dup    
         bcs   L03A8
         ldb   ,s
         sta   b,u
         lda   ,s
         os9   I$Close  
L0386    lda   $01,s
         bmi   L0391
         ldb   ,s
         bsr   L03E1
         tsta  
         bpl   L0398
L0391    anda  #$0F
         os9   I$Dup    
         bra   L03A6
L0398    bita  #$02
         bne   L03A1
         os9   I$Open   
         bra   L03A6
L03A1    ldb   #$0B
         os9   I$Create 
L03A6    stb   $01,s
L03A8    puls  pc,b,a
L03AA    clra  
L03AB    ldb   #$03
         bra   L0362
         lda   #$0D
L03B1    sta   -$04,x
L03B3    bsr   L03BC
         bcc   L03DC
L03B7    rts   
         lda   #$0D
         sta   -$02,x
L03BC    bsr   L03AA
         bcs   L03B7
         ldd   #$0180
         bra   L0362
         lda   #$0D
         sta   -$03,x
         bsr   L03AA
         bcs   L03B7
         ldd   #$0280
         bra   L0362
         lda   #$0D
         sta   -$03,x
         lda   #$01
         bsr   L03AB
         bcs   L03B7
L03DC    ldd   #$0281
         bra   L0362
L03E1    pshs  x,b,a
         ldd   ,x++
         cmpd  #$2F30
         bcs   L040D
         cmpd  #$2F32
         bhi   L040D
         pshs  x,b,a
         lbsr  L0241
         puls  x,b,a
         bcs   L040D
         andb  #$03
         cmpb  $01,s
         bne   L0404
         ldb   $01,s
         ldb   b,u
L0404    orb   #$80
         stb   ,s
         puls  b,a
         leas  $02,s
         rts   
L040D    puls  pc,x,b,a
         ldb   #$0D
         stb   -$01,x
         ldb   <u0003
         lbne  L0326
         lbsr  L05CC
         eora  #$4B
         anda  #$DF
         bne   L042C
         leax  $01,x
         lda   #$04
         mul   
         tsta  
         lbne  L0326
L042C    stb   <u0003
         lbra  L0241
         leax  -$01,x
         lbsr  L04CA
         bra   L043B
         lbsr  L04C6
L043B    bcs   L044E
         lbsr  L02ED
         bsr   L045F
L0442    bcs   L044E
         lbsr  L0241
         cmpa  #$0D
         bne   L044D
         leas  $04,s
L044D    clrb  
L044E    lbra  L02ED
         bsr   L04C6
         bcs   L044E
         bsr   L044E
         ldb   #$26
         lbsr  L0597
         bra   L0442
         clra  
L045F    pshs  a
L0461    os9   F$Wait   
         tst   <u000E
         beq   L0479
         ldb   <u000E
         cmpb  #$02
         bne   L0491
         lda   ,s
         beq   L0491
         os9   F$Send   
         clr   ,s
         bra   L0461
L0479    bcs   L0495
         cmpa  ,s
         beq   L0491
         tst   ,s
         beq   L0486
         tstb  
         beq   L0461
L0486    pshs  b
         bsr   L044E
         ldb   #$2D
         lbsr  L0597
         puls  b
L0491    tstb  
         beq   L0495
         coma  
L0495    puls  pc,a
L0497    lda   #$11
         ldb   <u0003
         ldx   <u0004
         ldy   <u0006
         ldu   <u0008
         rts   
L04A3    lda   #$04
         os9   I$Open   
         bcs   L0500
         leax  <u005E,u
         ldy   #$000D
         os9   I$Read   
         pshs  b,cc
         os9   I$Close  
         puls  b,cc
         lbcs  L0561
         lda   $06,x
         ldy   $0B,x
         bra   L04D9
L04C6    lda   #$0D
         sta   -$01,x
L04CA    pshs  u,y,x
         clra  
         ldx   <u0004
         os9   F$NMLink 
         bcs   L04A3
         ldx   <u0004
         os9   F$UnLoad 
L04D9    cmpa  #$11
         beq   L0527
         sty   <u000A
         leax  >L0013,pcr
L04E4    tst   ,x
         beq   L055F
         cmpa  ,x+
         beq   L04F2
L04EC    tst   ,x+
         bpl   L04EC
         bra   L04E4
L04F2    ldd   <u0008
         subd  <u0004
         addd  <u0006
         std   <u0006
         ldd   <u0004
         std   <u0008
         bra   L0525
L0500    ldx   <u0006
         leax  $05,x
         stx   <u0006
         ldx   <u0004
         ldu   $04,s
         lbsr  L0350
         bcs   L0561
         ldu   <u0008
         ldd   #$5820
         std   ,--u
         ldd   #$5020
         std   ,--u
         ldb   #$2D
         stb   ,-u
         stu   <u0008
         leax  >L000D,pcr
L0525    stx   <u0004
L0527    ldx   <u0004
         lda   #$11
         os9   F$NMLink 
         bcc   L0535
         os9   F$NMLoad 
         bcs   L0561
L0535    tst   <u0003
         bne   L0542
         tfr   y,d
         addd  <u000A
         addd  #$00FF
         sta   <u0003
L0542    lbsr  L0497
         os9   F$Fork   
         pshs  b,a,cc
         bcs   L0552
         ldx   #$0001
         os9   F$Sleep  
L0552    lda   #$11
         ldx   <u0004
         clr   <u0004
         clr   <u0005
         os9   F$UnLoad 
         puls  pc,u,y,x,b,a,cc
L055F    ldb   #$EA
L0561    coma  
         puls  pc,u,y,x

L0564    fcc   "/pipe"
         fcb   C$CR
L0569    pshs  x
         leax  <L0564,pcr
         ldd   #$0103
         lbsr  L0362
         puls  x
         bcs   L05CB
         lbsr  L04C6
         bcs   L05CB
         lda   ,u
         bne   L0589
         os9   I$Dup
         bcs   L05CB
         sta   ,u
L0589    clra  
         os9   I$Close  
         lda   #$01
         os9   I$Dup    
         lda   #$01
         lbra  L02FF
L0597    pshs  y,x,b,a
         pshs  y,x,b
         leax  $01,s
         ldb   #$2F
L059F    incb  
         suba  #$64
         bcc   L059F
         stb   ,x+
         ldb   #$3A
L05A8    decb  
         adda  #$0A
         bcc   L05A8
         stb   ,x+
         adda  #$30
         ldb   #$0D
         std   ,x
         leax  ,s
         lbsr  L00CB
         leas  $05,s
         puls  pc,y,x,b,a
         bsr   L05CC
         cmpb  #$02
         bls   L05E7
         tfr   b,a
         ldb   #$00
         os9   F$Send   
L05CB    rts   
L05CC    clrb  
L05CD    lda   ,x+
         suba  #$30
         cmpa  #$09
         bhi   L05DE
         pshs  a
         lda   #$0A
         mul   
         addb  ,s+
         bcc   L05CD
L05DE    lda   ,-x
         bcs   L05E5
         tstb  
         bne   L05CB
L05E5    leas  $02,s
L05E7    lbra  L0326
         bsr   L05CC
         stb   <u0015
         lbsr  L0241
         bsr   L05CC
         lda   <u0015
         os9   F$SPrior 
         rts   

         emod
eom      equ   *
         end
