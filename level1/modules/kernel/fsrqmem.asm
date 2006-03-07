FSRqMem  ldd   R$D,u
         addd  #$00FF
         clrb
         std   R$D,u
         ldx   <D.FMBM+2
         ldd   #$01FF
         pshs  b,a
         bra   L0604
L05FA    dec   $01,s
         ldb   $01,s
L05FE    lsl   ,s
         bcc   L060A
         rol   ,s
L0604    leax  -1,x
         cmpx  <D.FMBM
         bcs   L0620
L060A    lda   ,x
         anda  ,s
         bne   L05FA
         dec   1,s
         subb  1,s
         cmpb  1,u
         rora
         addb  1,s
         rola
         bcs   L05FE
         ldb   1,s
         clra
         incb
L0620    leas  2,s
         bcs   L0635
         ldx   <D.FMBM
         tfr   d,y
         ldb   1,u
         clra
         exg   d,y
         bsr   L065A
         exg   a,b
         std   8,u
L0633    clra
         rts
L0635    comb
         ldb   #E$MemFul
         rts

FSRtMem  ldd   R$D,u
         addd  #$00FF
         tfr   a,b
         clra
         tfr   d,y
         ldd   R$U,u
         beq   L0633
         tstb
         beq   L064E
         comb
         ldb   #E$BPAddr
         rts
L064E    exg   a,b
         ldx   <D.FMBM
         bra   L06AD
