FAllBit  ldd   R$D,u
         leau  R$X,u
         pulu  y,x
L065A    pshs  y,x,b,a
         bsr   L0690
         tsta
         pshs  a
         bmi   L0671
         lda   ,x
L0665    ora   ,s
         leay  -1,y
         beq   L0689
         lsr   ,s
         bcc   L0665
         sta   ,x+
L0671    tfr   y,d
         sta   ,s
         lda   #$FF
         bra   L067B
L0679    sta   ,x+
L067B    subb  #$08
         bcc   L0679
         dec   ,s
         bpl   L0679
L0683    lsla
         incb
         bne   L0683
         ora   ,x
L0689    sta   ,x
         clra
         leas  1,s
         puls  pc,y,x,b,a
L0690    pshs  b
         lsra
         rorb
         lsra
         rorb
         lsra
         rorb
         leax  d,x
         puls  b
         lda   #$80
         andb  #$07
         beq   L06A6
L06A2    lsra
         decb
         bne   L06A2
L06A6    rts

FDelBit  ldd   R$D,u
         leau  R$X,u
         pulu  y,x
L06AD    pshs  y,x,b,a
         bsr   L0690
         coma
         pshs  a
         bpl   L06C4
         lda   ,x
L06B8    anda  ,s
         leay  -1,y
         beq   L06D8
         asr   ,s
         bcs   L06B8
         sta   ,x+
L06C4    tfr   y,d
         bra   L06CA
L06C8    clr   ,x+
L06CA    subd  #$0008
         bhi   L06C8
         beq   L06D8
L06D1    lsla
         incb
         bne   L06D1
         coma
         anda  ,x
L06D8    sta   ,x
         clr   ,s+
         puls  pc,y,x,b,a

FSchBit  pshs  u
         ldd   R$D,u
         ldx   R$X,u
         ldy   R$Y,u
         ldu   R$U,u
         bsr   L06F3
         puls  u
         std   R$D,u
         sty   R$Y,u
         rts
L06F3    pshs  u,y,x,b,a
         pshs  y,b,a
         clr   8,s
         clr   9,s
         tfr   d,y
         bsr   L0690
         pshs  a
         bra   L0710
L0703    leay  $01,y
         sty   $05,s
L0708    lsr   ,s
         bcc   L0714
         ror   ,s
         leax  $01,x
L0710    cmpx  $0B,s
         bcc   L0732
L0714    lda   ,x
         anda  ,s
         bne   L0703
         leay  $01,y
         tfr   y,d
         subd  $05,s
         cmpd  $03,s
         bcc   L0739
         cmpd  $09,s
         bls   L0708
         std   $09,s
         ldd   $05,s
         std   $01,s
         bra   L0708
L0732    ldd   $01,s
         std   $05,s
         coma
         bra   L073B
L0739    std   $09,s
L073B    leas  $05,s
         puls  pc,u,y,x,b,a
