********************************************************************
* CO80 - WordPak 80-RS co-driver for CCIO
*
* $Id$
*
* Ed.    Comments                                       Who YY/MM/DD
* ------------------------------------------------------------------
*   2    From Tandy OS-9 Level One VR 02.00.00

         nam   CO80
         ttl   WordPak 80-RS co-driver for CCIO

* Disassembled 98/08/23 17:58:20 by Disasm v1.6 (C) 1988 by RML

         ifp1
         use   defsfile
         endc

tylg     set   Systm+Objct   
atrv     set   ReEnt+rev
rev      set   $01
edition  set   2

         mod   eom,name,tylg,atrv,start,size

u0000    rmb   0
size     equ   .
         fcb   $06 

name     fcs   /CO80/
         fcb   edition

start    lbra  L0022
         lbra  L0083
         lbra  L0054
         lbra  L007F
         lbra  L004A
L0022    ldx   #$FF78
         lda   #$06
         sta   $01,x
         sta   ,x
         lda   #$08
         sta   $01,x
         clr   ,x
         lda   #$0E
         sta   $01,x
         clr   ,x
         lbsr  L0152
         lbsr  L0229
         ldd   #$07D0
         lbsr  L0189
         ldb   <$70,u
         orb   #$04
         bra   L004F
L004A    ldb   <$70,u
         andb  #$FB
L004F    stb   <$70,u
         clrb  
         rts   
L0054    cmpa  #$25
         bne   L007F
         ldy   $06,y
         clra  
         ldb   <$58,u
         addb  #$20
         std   $06,y
         ldb   <$59,u
         addb  #$20
         std   $04,y
         ldx   #$FF78
         lda   #$0D
         sta   $01,x
         lbsr  L0174
         lda   ,x
         lbsr  L0174
         lda   ,x
         sta   $01,y
L007D    clrb  
         rts   
L007F    ldb   #E$UnkSvc
         coma  
         rts   
L0083    ldx   #$FF78
         cmpa  #$0E
         bcs   L00B6
         cmpa  #$1E
         bcs   L007D
         cmpa  #$20
         lbcs  L01F2
         cmpa  #$7F
         bcs   L0106
         cmpa  #$C0
         bls   L00A6
         anda  #$1F
         suba  #$01
         cmpa  #$19
         bhi   L00B2
         bra   L0106
L00A6    cmpa  #$AA
         bcs   L00B2
         ora   #$10
         anda  #$1F
         cmpa  #$1A
         bcc   L0106
L00B2    lda   #$7F
         bra   L0106
L00B6    leax  >L00C5,pcr
         lsla  
         ldd   a,x
         leax  d,x
         pshs  x
         ldx   #$FF78
         rts   
L00C5    fcb   $ff,$b8,$00,$8d,$00,$dd,$00,$b4,$00,$b6,$01
         fcb   $4c,$00,$50,$ff,$b8,$00,$1c,$00,$2e,$00,$5c
         fcb   $00,$c1,$00,$bf,$00
         fcb   $3c,$ec,$c8,$58,$26,$02,$5f,$39
L00E8    decb  
         bge   L00EE
         ldb   #$4F
         deca  
L00EE    std   <$58,u
         bra   L014F
         lda   <$58,u
         beq   L00FF
         deca  
         sta   <$58,u
         lbra  L01CC
L00FF    clrb  
         rts   
L0101    clr   <$59,u
         bra   L014C
L0106    ora   <$5A,u
         pshs  a
         bsr   L0174
         puls  a
         ldb   #$0D
         stb   $01,x
         sta   ,x
         inc   <$59,u
         lda   <$59,u
         cmpa  #$4F
         ble   L014C
         bsr   L0101
         lda   <$58,u
         cmpa  #$17
         bge   L012E
         inca  
         sta   <$58,u
         bra   L014F
L012E    ldd   <$54,u
         lbsr  L01DC
         ldd   <$54,u
         addd  #$0050
         bsr   L0161
         std   <$54,u
         bsr   L018E
         ldd   <$54,u
         bsr   L016B
         lda   #$08
         sta   $01,x
         stb   ,x
L014C    lda   <$58,u
L014F    lbra  L01CC
L0152    clr   <$58,u
         clr   <$59,u
         ldd   <$54,u
         std   <$56,u
         lbra  L01DC
L0161    cmpd  #$07D0
         blt   L016A
         subd  #$07D0
L016A    rts   
L016B    lsra  
         rorb  
         lsra  
         rorb  
         lsra  
         rorb  
         lsra  
         rorb  
         rts   
L0174    lda   $01,x
         bpl   L0174
         rts   
         bsr   L0101
         lda   <$58,u
         inca  
         ldb   #$50
         mul   
         bra   L0189
         bsr   L0152
         ldd   #$0780
L0189    addd  <$54,u
         bsr   L0161
L018E    bsr   L016B
         bsr   L0174
         lda   #$0B
         sta   $01,x
         stb   ,x
         lda   #$0D
         sta   $01,x
         lda   #$20
         sta   ,x
L01A0    clrb  
         rts   
         leax  >L01B0,pcr
         ldb   #$02
L01A8    stx   <$26,u
         stb   <$25,u
         clrb  
         rts   
L01B0    ldx   #$FF78
         lda   <$29,u
         ldb   <$28,u
         subb  #$20
         blt   L01A0
         cmpb  #$4F
         bgt   L01A0
         suba  #$20
         blt   L01A0
         cmpa  #$17
         bgt   L01A0
         std   <$58,u
L01CC    ldb   #$50
         mul   
         addb  <$59,u
         adca  #$00
         addd  <$54,u
         bsr   L0161
         std   <$56,u
L01DC    pshs  b,a
         bsr   L0174
         lda   #$0A
         sta   $01,x
         lda   ,s+
         sta   ,x
         lda   #$09
         sta   $01,x
         lda   ,s+
         sta   ,x
         clrb  
         rts   
L01F2    cmpa  #$1F
         bne   L0201
         lda   <$29,u
         cmpa  #$21
         beq   L0205
         cmpa  #$20
         beq   L020C
L0201    comb  
         ldb   #E$Write
         rts   
L0205    lda   #$80
         sta   <$5A,u
         clrb  
         rts   
L020C    clr   <$5A,u
L020F    clrb  
         rts   
         leax  >L0219,pcr
         ldb   #$01
         bra   L01A8
L0219    ldx   #$FF78
         lda   <$29,u
         cmpa  #$20
         blt   L0201
         beq   L022D
         cmpa  #$2A
         bgt   L020F
L0229    lda   #$05
         bra   L022F
L022D    lda   #$45
L022F    ldb   #$0C
         stb   $01,x
         sta   ,x
         clrb  
         rts   

         emod
eom      equ   *
         end

