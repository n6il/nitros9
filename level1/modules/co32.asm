********************************************************************
* CO32 - Hardware VDG co-driver for CCIO
*
* $Id$
*
* Ed.    Comments                                       Who YY/MM/DD
* ------------------------------------------------------------------
* 1      Tandy/Microware original version

         nam   CO32
         ttl   Hardware VDG co-driver for CCIO

* Disassembled 98/08/23 17:47:40 by Disasm v1.6 (C) 1988 by RML

         ifp1
         use   defsfile
         endc

tylg     set   Systm+Objct   
atrv     set   ReEnt+rev
rev      set   $01
edition  set   $01

         mod   eom,name,tylg,atrv,start,size

u0000    rmb   0
size     equ   .
         fcb   $07 

name     fcs   /CO32/
         fcb   edition

start    lbra  L0035
         lbra  L008C
         lbra  L0246
         lbra  L0250
         pshs  y,x
         pshs  u
         ldd   #$0200
         ldu   <$1D,u
         os9   F$SRtMem 
         puls  u
         ldb   <$70,u
         andb  #$FD
         bra   L0086
L0035    pshs  y,x
         lda   #$AF
         sta   <$2C,u
         pshs  u
         ldd   #$0300
         os9   F$SRqMem 
         tfr   u,d
         tfr   u,x
         bita  #$01
         beq   L0052
         leax  >$0100,x
         bra   L0056
L0052    leau  >$0200,u
L0056    ldd   #$0100
         os9   F$SRtMem 
         puls  u
         stx   <$1D,u
         pshs  y
         leay  -$0E,y
         clra  
         clrb  
         jsr   [<$5B,u]
         puls  y
         stx   <$21,u
         leax  >$0200,x
         stx   <$1F,u
         lda   #$60
         sta   <$23,u
         sta   <$2B,u
         lbsr  L0187
         ldb   <$70,u
         orb   #$02
L0086    stb   <$70,u
         clrb  
         puls  pc,y,x
L008C    tsta  
         bmi   L00D0
         cmpa  #$1F
         bls   L0103
         ldb   <$71,u
         beq   L00B0
         cmpa  #$5E
         bne   L00A0
         lda   #$00
         bra   L00D0
L00A0    cmpa  #$5F
         bne   L00A8
         lda   #$1F
         bra   L00D0
L00A8    cmpa  #$60
         bne   L00C0
         lda   #$67
         bra   L00D0
L00B0    cmpa  #$7C
         bne   L00B8
         lda   #$21
         bra   L00D0
L00B8    cmpa  #$7E
         bne   L00C0
         lda   #$2D
         bra   L00D0
L00C0    cmpa  #$60
         bcs   L00C8
         suba  #$60
         bra   L00D0
L00C8    cmpa  #$40
         bcs   L00CE
         suba  #$40
L00CE    eora  #$40
L00D0    ldx   <$21,u
         sta   ,x+
         stx   <$21,u
         cmpx  <$1F,u
         bcs   L00DF
         bsr   L00E3
L00DF    bsr   L013E
         clrb  
         rts   
L00E3    ldx   <$1D,u
         leax  <$20,x
L00E9    ldd   ,x++
         std   <-$22,x
         cmpx  <$1F,u
         bcs   L00E9
         leax  <-$20,x
         stx   <$21,u
         lda   #$20
         ldb   #$60
L00FD    stb   ,x+
         deca  
         bne   L00FD
L0102    rts   
L0103    cmpa  #$1B
         bcc   L0113
         cmpa  #$0E
         bhi   L0102
         leax  <L0117,pcr
         lsla  
         ldd   a,x
         jmp   d,x
L0113    comb  
         ldb   #E$Write
         rts   
L0117    fcb   $ff,$ca,$00,$7d,$00,$c9,$01,$07,$00,$f9,$00,$91,$00
         fcb   $5e,$ff,$ca,$00,$50,$01,$19,$00,$38,$00,$6c,$00,$70
         fcb   $00,$1e,$01,$2a
L0135    bsr   L019E
         tfr   x,d
         andb  #$E0
         stb   <$22,u
L013E    ldx   <$21,u
         lda   ,x
         sta   <$23,u
         lda   <$2C,u
         beq   L014D
L014B    sta   ,x
L014D    clrb  
         rts   
         bsr   L019E
         leax  <$20,x
         cmpx  <$1F,u
         bcs   L0162
         leax  <-$20,x
         pshs  x
         bsr   L00E3
         puls  x
L0162    stx   <$21,u
         bra   L013E
         bsr   L019E
         cmpx  <$1D,u
         bls   L0173
         leax  -$01,x
         stx   <$21,u
L0173    bra   L013E
         bsr   L019E
         leax  $01,x
         cmpx  <$1F,u
         bcc   L0181
         stx   <$21,u
L0181    bra   L013E
         bsr   L019E
         bra   L0189
L0187    bsr   L0194
L0189    lda   #$60
L018B    sta   ,x+
         cmpx  <$1F,u
         bcs   L018B
         bra   L013E
L0194    bsr   L019E
         ldx   <$1D,u
         stx   <$21,u
         bra   L013E
L019E    ldx   <$21,u
         lda   <$23,u
         sta   ,x
         clrb  
         rts   
         ldb   #$01
         leax  <L01AF,pcr
         bra   L01E5
L01AF    lda   <$29,u
         suba  #$20
         bne   L01BB
         sta   <$2C,u
         bra   L019E
L01BB    cmpa  #$0B
         bge   L014D
         cmpa  #$01
         bgt   L01C7
         lda   #$AF
         bra   L01D7
L01C7    cmpa  #$02
         bgt   L01CF
         lda   #$A0
         bra   L01D7
L01CF    subb  #$03
         lsla  
         lsla  
         lsla  
         lsla  
         ora   #$8F
L01D7    sta   <$2C,u
         ldx   <$21,u
         lbra  L014B
         ldb   #$02
         leax  <L01ED,pcr
L01E5    stx   <$26,u
         stb   <$25,u
         clrb  
         rts   
L01ED    bsr   L019E
         ldb   <$29,u
         subb  #$20
         lda   #$20
         mul   
         addb  <$28,u
         adca  #$00
         subd  #$0020
         addd  <$1D,u
         cmpd  <$1F,u
         lbcc  L014D
         std   <$21,u
         lbra  L013E
         bsr   L019E
         tfr   x,d
         andb  #$1F
         pshs  b
         ldb   #$20
         subb  ,s+
         bra   L0223
         lbsr  L0135
         ldb   #$20
L0223    lda   #$60
         ldx   <$21,u
L0228    sta   ,x+
         decb  
         bne   L0228
         lbra  L013E
         lbsr  L019E
         leax  <-$20,x
         cmpx  <$1D,u
         bcs   L023E
         stx   <$21,u
L023E    lbra  L013E
         clra  
         clrb  
         jmp   [<$5B,u]
L0246    ldx   $06,y
         cmpa  #$1C
         beq   L0254
         cmpa  #$25
         beq   L0263
L0250    comb  
         ldb   #E$UnkSvc
         rts   
L0254    ldd   <$1D,u
         std   $04,x
         ldd   <$21,u
         std   $06,x
         lda   <$50,u
         bra   L02BA
L0263    ldd   <$21,u
         subd  <$1D,u
         pshs  b,a
         clra  
         andb  #$1F
         addb  #$20
         std   $04,x
         puls  b,a
         lsra  
         rolb  
         rolb  
         rolb  
         rolb  
         clra  
         andb  #$0F
         addb  #$20
         std   $06,x
         ldb   <$71,u
         lda   <$23,u
         bmi   L02BA
         cmpa  #$60
         bcc   L02A5
         cmpa  #$20
         bcc   L02A9
         tstb  
         beq   L02A3
         cmpa  #$00
         bne   L029B
         lda   #$5E
         bra   L02BA
L029B    cmpa  #$1F
         bne   L02A3
         lda   #$5F
         bra   L02BA
L02A3    ora   #$20
L02A5    eora  #$40
         bra   L02BA
L02A9    tstb  
         bne   L02BA
         cmpa  #$21
         bne   L02B4
         lda   #$7C
         bra   L02BA
L02B4    cmpa  #$2D
         bne   L02BA
         lda   #$7E
L02BA    sta   $01,x
         clrb  
         rts   

         emod
eom      equ   *
         end

