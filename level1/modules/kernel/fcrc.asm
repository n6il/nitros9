* F$CRC
FCRC     ldx   R$X,u
         ldy   R$Y,u
         beq   L0402
         ldu   R$U,u
L03FA    lda   ,x+
         bsr   CRCAlgo
         leay  -1,y
         bne   L03FA
L0402    clrb
         rts

CRCAlgo  eora  ,u
         pshs  a
         ldd   $01,u
         std   ,u
         clra
         ldb   ,s
         lslb
         rola
         eora  1,u
         std   1,u
         clrb
         lda   ,s
         lsra
         rorb
         lsra
         rorb
         eora  1,u
         eorb  2,u
         std   1,u
         lda   ,s
         lsla
         eora  ,s
         sta   ,s
         lsla
         lsla
         eora  ,s
         sta   ,s
         lsla
         lsla
         lsla
         lsla
         eora  ,s+
         bpl   L0442
         ldd   #$8021
         eora  ,u
         sta   ,u
         eorb  2,u
         stb   2,u
L0442    rts
