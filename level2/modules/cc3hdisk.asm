********************************************************************
* CC3HDisk - CoCo 3 Tandy hard disk adapter driver
*
* $Id$
*
* Ed.    Comments                                       Who YY/MM/DD
* ------------------------------------------------------------------
* 5      Taken from OS-9 L2 Tandy distribution and      BGP 98/10/12
*        modified banner for V3

         nam   CC3HDisk
         ttl   CoCo 3 Tandy hard disk adapter driver

* Disassembled 98/08/23 20:51:43 by Disasm v1.6 (C) 1988 by RML

         ifp1
         use   defsfile
         endc

tylg     set   Drivr+Objct   
atrv     set   ReEnt+rev
rev      set   $01
edition  set   5

         mod   eom,name,tylg,atrv,start,size

u0000    rmb   8
u0008    rmb   7
u000F    rmb   123
u008A    rmb   29
u00A7    rmb   2
u00A9    rmb   1
u00AA    rmb   1
u00AB    rmb   2
u00AD    rmb   2
u00AF    rmb   1
u00B0    rmb   1
u00B1    rmb   1
u00B2    rmb   1
u00B3    rmb   1
u00B4    rmb   1
u00B5    rmb   1
u00B6    rmb   1
u00B7    rmb   1
u00B8    rmb   1
u00B9    rmb   1
u00BA    rmb   1
u00BB    rmb   1
u00BC    rmb   2
u00BE    rmb   1
u00BF    rmb   2
u00C1    rmb   2
size     equ   .
         fcb   $FF 

name     fcs   /CC3HDisk/
         fcb   edition

start    equ   *
         lbra  L0029
         lbra  L00A4
         lbra  L00E5
         lbra  L00A2
         lbra  L017C
         lbra  L0094
L0029    lbsr  L04D5
         lda   >$FF51
         cmpa  #$08
         beq   L0038
         comb  
         ldb   #$F6
         bra   L0084
L0038    lbsr  L04C1
         bcs   L0084
         ldd   #$FFFF
         std   >u00A9,u
         std   >u00A7,u
         leax  <$25,y
         ldd   ,x++
         sta   >u00B3,u
         stb   >u00BE,u
         ldd   ,x++
         std   >u00BF,u
         ldd   ,x++
         std   >u00C1,u
         lda   ,x
         sta   >u00B2,u
         lda   #$04
         leay  u000F,u
         ldb   #$FF
L006D    stb   ,y
         stb   <$15,y
         leay  <$26,y
         deca  
         bne   L006D
         ldd   #$0100
         pshs  u
         os9   F$SRqMem 
         tfr   u,x
         puls  u
L0084    bcs   L00C8
         stx   >u00AB,u
         leax  >$0100,x
         stx   >u00AD,u
         bra   L00C7
L0094    pshs  u
         ldu   >u00AB,u
         ldd   #$0100
         os9   F$SRtMem 
         puls  u
L00A2    clrb  
         rts   
L00A4    lbsr  L04D5
         cmpx  #$0000
         bne   L00CC
         tstb  
         bne   L00CC
         bsr   L00D2
         bcs   L00C8
         ldx   $08,y
         pshs  y,x
         ldy   >u00A7,u
         ldb   #$14
L00BE    lda   b,x
         sta   b,y
         decb  
         bpl   L00BE
         puls  y,x
L00C7    clrb  
L00C8    lbsr  L04E2
         rts   
L00CC    bsr   L00D2
         bcs   L00C8
         bra   L00C7
L00D2    lbsr  L0340
         bcs   L00E4
         ldx   $08,y
         lda   #$02
         sta   >u00B9,u
         lda   #$20
         lbsr  L028D
L00E4    rts   
L00E5    lbsr  L04D5
         bsr   L014B
         bcs   L00C8
         pshs  x,b
         bsr   L0101
         puls  x,b
         bcs   L00C8
         tst   <$28,y
         bne   L00C7
         bsr   L0114
         bcc   L00C7
         ldb   <$00F5
         bra   L00C8
L0101    lbsr  L0340
         bcs   L0113
         lda   #$03
         sta   >u00B9,u
         lda   #$30
         ldx   $08,y
         lbsr  L028D
L0113    rts   
L0114    pshs  x,b,a
         ldx   $08,y
         pshs  x
         ldx   >u00AB,u
         stx   $08,y
         ldx   $04,s
         bsr   L00D2
         puls  x
         stx   $08,y
         bcs   L0149
         lda   #$20
         pshs  u,y,a
         ldy   >u00AB,u
         tfr   x,u
L0135    ldx   ,u
         cmpx  ,y
         bne   L0145
         leau  u0008,u
         leay  $08,y
         dec   ,s
         bne   L0135
         bra   L0147
L0145    orcc  #Carry
L0147    puls  u,y,a
L0149    puls  pc,x,b,a
L014B    pshs  b
         ldb   >$FF50
         beq   L017A
         lda   <$21,y
         bne   L015D
         andb  #$80
         bne   L0175
         bra   L017A
L015D    cmpa  #$01
         bne   L0167
         andb  #$40
         bne   L0175
         bra   L017A
L0167    cmpa  #$02
         bne   L0171
         andb  #$20
         bne   L0175
         bra   L017A
L0171    andb  #$10
         beq   L017A
L0175    comb  
         ldb   #$F2
         stb   ,s
L017A    puls  pc,b
L017C    lbsr  L04D5
         lbsr  L0461
         ldx   $06,y
         ldb   $02,x
         cmpb  #$03
         bne   L018F
         lbsr  L04A6
         bra   L01A2
L018F    cmpb  #$04
         bne   L0197
         bsr   L01B6
         bra   L01A2
L0197    cmpb  #$0C
         bne   L019F
         bsr   L01A9
         bra   L01A2
L019F    comb  
         ldb   #$D0
L01A2    lbcs  L00C8
         lbra  L00C7
L01A9    ldd   <$25,y
         exg   a,b
         std   >u00B6,u
         lbsr  L0497
         rts   
L01B6    ldd   $08,x
         cmpd  #$0000
         bne   L01C4
         ldd   $06,x
         cmpa  #$00
         beq   L01C6
L01C4    clrb  
         rts   
L01C6    pshs  u,y,x
         clr   >u00AF,u
         clr   >u00B0,u
         clr   >u00B1,u
         lda   <$2A,y
         bsr   L023E
L01D9    lda   <$2A,y
         sta   >u00B4,u
         lda   >u00B2,u
         sta   >u00B5,u
         lda   >u00B8,u
         anda  #$F8
         sta   >u00B8,u
         lda   >u00B1,u
         ora   >u00B8,u
         sta   >u00B8,u
         ldd   >u00AF,u
         exg   a,b
         std   >u00B6,u
         lda   #$03
         sta   >u00B9,u
         lda   #$50
         ldx   >u00AB,u
         bsr   L028D
         bcs   L023C
         lda   >u00B1,u
         inca  
         sta   >u00B1,u
         cmpa  <$27,y
         bcs   L01D9
         clr   >u00B1,u
         ldd   >u00AF,u
         addd  #$0001
         std   >u00AF,u
         cmpd  <$25,y
         bcs   L01D9
         clrb  
L023C    puls  pc,u,y,x
L023E    pshs  y,x,b,a
         ldb   <$2D,y
         stb   >u00BB,u
         sta   >u00BA,u
         lsla  
         ldx   >u00AB,u
         leay  a,x
         nega  
         pshs  y,x,b,a
         clra  
L0256    clr   ,x
         sta   $01,x
         inca  
         cmpa  >u00BA,u
         beq   L0279
         ldb   >u00BB,u
         lslb  
         abx   
         cmpx  $04,s
         bcs   L026F
         ldb   ,s
         leax  b,x
L026F    cmpx  $02,s
         bne   L0256
         leax  $02,x
         stx   $02,s
         bra   L0256
L0279    ldy   $04,s
         lda   #$00
L027E    cmpy  >u00AD,u
         beq   L0289
         sta   ,y+
         bra   L027E
L0289    leas  $06,s
         puls  pc,y,x,b,a
L028D    pshs  y,x,a
         leax  >u00B3,u
         ldy   #$FF59
         ldb   #$06
L0299    lda   ,x+
         sta   ,y+
         decb  
         bne   L0299
         lda   ,s
         sta   ,y
         ldy   $03,s
         ldx   $01,s
         lda   >u00B9,u
         cmpa  #$03
         beq   L02C7
         bsr   L02E2
         cmpa  #$02
         beq   L02BB
L02B7    bsr   L02F3
         puls  pc,y,x,a
L02BB    bsr   L02EC
L02BD    lda   >$FF58
         sta   ,x+
         decb  
         bne   L02BD
         bra   L02B7
L02C7    lda   ,x+
         sta   >$FF58
         decb  
         bne   L02C7
         bsr   L02E2
         bra   L02B7
L02D3    lda   >$FF5F
         pshs  a
         lda   >$FF5F
         cmpa  ,s
         leas  $01,s
         bne   L02D3
         rts   
L02E2    pshs  a
L02E4    bsr   L02D3
         anda  #$80
         bne   L02E4
         puls  pc,a
L02EC    bsr   L02D3
         bita  #$08
         beq   L02EC
         rts   
L02F3    bsr   L02D3
         bita  #$01
         bne   L02FB
         clrb  
         rts   
L02FB    comb  
         bita  #$02
         beq   L0303
         lbsr  L04F2
L0303    lda   >$FF59
         bita  #$80
         bne   L0333
         bita  #$40
         bne   L0320
         bita  #$10
         bne   L0323
         bita  #$04
         bne   L0337
         bita  #$02
         bne   L0323
         bita  #$01
         bne   L0327
         clrb  
         rts   
L0320    ldb   #$F3
         rts   
L0323    comb  
         ldb   #$F7
         rts   
L0327    comb  
         ldb   #$F4
         rts   
         comb  
         ldb   #$F5
         rts   
L032F    comb  
         ldb   #$F6
         rts   
L0333    comb  
         ldb   #$F0
         rts   
L0337    lda   >$FF5F
         bita  #$10
         beq   L0323
         bra   L032F
L0340    lbsr  L0461
         bcs   L0347
         bsr   L0348
L0347    rts   
L0348    pshs  y,x,b
         lbsr  L04C1
         lbcs  L0429
         stx   >u00BC,u
         tstb  
         bne   L0381
         cmpx  #$0000
         bne   L0381
         leax  >u00B4,u
         ldd   #$0001
         sta   $01,x
         sta   $02,x
         sta   $03,x
         stb   ,x
         lda   >u00B8,u
         anda  #$F8
         sta   >u00B8,u
         tst   >u00AA,u
         lbne  L040C
         lbra  L0428
L0381    ldy   >u00A7,u
         cmpb  ,y
         lbhi  L042F
         bcs   L0394
         cmpx  $01,y
         lbcc  L042F
L0394    clr   >u00B6,u
         clr   >u00B7,u
         ldb   ,s
         ldx   $01,s
         ldy   $03,s
         tstb  
         bne   L03B5
         pshs  x,b,a
         lda   <$2A,y
         ldb   <$27,y
         mul   
         subd  $02,s
         puls  x,b,a
         bhi   L03D6
L03B5    pshs  u,y,x,b,a
         lda   >u00BE,u
         ldy   >u00BF,u
         ldu   >u00C1,u
         bsr   L0436
         ldu   $06,s
         std   >u00BC,u
         tfr   x,d
         exg   a,b
         std   >u00B6,u
         puls  u,y,x,b,a
L03D6    clra  
         ldb   <$2A,y
         beq   L042F
         pshs  b,a
         pshs  a
         ldd   >u00BC,u
L03E4    subd  $01,s
         bcs   L03EC
         inc   ,s
         bra   L03E4
L03EC    addd  $01,s
         stb   >u00B5,u
         lda   >u00B8,u
         anda  #$F8
         ora   ,s
         sta   >u00B8,u
         leas  $03,s
         lda   #$01
         sta   >u00B4,u
         tst   >u00AA,u
         beq   L0428
L040C    clr   >u00AA,u
         ldy   >u00A7,u
         lda   <$15,y
         ldy   $03,s
         cmpa  #$FF
         bne   L0424
         lbsr  L04A6
         bra   L0429
L0424    bsr   L0497
         bra   L0429
L0428    clrb  
L0429    bcc   L042D
         stb   ,s
L042D    puls  pc,y,x,b
L042F    puls  b
         comb  
         ldb   #$F1
         puls  pc,y,x
L0436    pshs  u,y,x,b,a
         ldd   $01,s
L043A    subd  $04,s
         bcc   L0444
         addd  $04,s
         andcc #^Carry
         bra   L0446
L0444    orcc  #Carry
L0446    rol   $03,s
         rolb  
         rola  
         dec   ,s
         bne   L043A
         std   ,s
         andb  $06,s
         stb   $02,s
         ldb   $07,s
         beq   L045F
L0458    lsr   ,s
         ror   $01,s
         decb  
         bne   L0458
L045F    puls  pc,u,y,x,b,a
L0461    lda   <$21,y
         cmpa  #$04
         lbcc  L0333
         cmpa  >u00A9,u
         beq   L0496
         sta   >u00A9,u
         dec   >u00AA,u
         lsla  
         lsla  
         lsla  
         pshs  a
         lda   >u00B8,u
         anda  #$E7
         ora   ,s
         leas  $01,s
         sta   >u00B8,u
         pshs  x
         ldx   <$1E,y
         stx   >u00A7,u
         puls  x
L0496    rts   
L0497    clr   >u00B9,u
         lda   <$22,y
         anda  #$0F
         ora   #$70
         lbsr  L028D
         rts   
L04A6    clr   >u00B9,u
         lda   <$22,y
         anda  #$0F
         ora   #$10
         lbsr  L028D
         bcs   L04C0
         ldx   >u00A7,u
         clr   <$15,x
         clr   <$16,x
L04C0    rts   
L04C1    pshs  b,a
         clrb  
L04C4    lda   >$FF5F
         bita  #$40
         bne   L04D3
         decb  
         bne   L04C4
         ldb   #$F6
         stb   $01,s
         comb  
L04D3    puls  pc,b,a
L04D5    dec   <u008A
         lda   #$02
         sta   >MPI.Slct
         lda   #$08
L04DE    sta   >$FF51
         rts   
L04E2    pshs  cc
         lda   #$00
         sta   >$FF51
         lda   #$03
         sta   >MPI.Slct
         clr   <u008A
         puls  pc,cc
L04F2    lda   #$10
         bra   L04DE

         emod
eom      equ   *
         end

