******************************************************
* F$ReBoot entry point
*   Currently disabled (doesn't work)
*   Besides, there's no need for this code to be in system memory.
*   A user-mode program can do this just as well.
*
* Entry A = 0 Cold ReBoot
*         = 1 Quit to RSDOS
*
*ReBoot   equ    *
*         orcc   #Carry       Set error flag
*         rts                 Exit
*        tst    R$A,u        Cold start (a=0)
*        bne    WarmBt       no, attempt a warm boot
*WarmBt   orcc   #IntMasks
*         ldb    #CodeSize
*         leax   BootCode,pc
*         tfr    0,y
*BootLoop lda    ,x+
*         sta    ,y+
*         decb
*         bne    BootLoop
*         jmp    >$0000
*BootCode equ   *
*        lda   >$ffa8
*        sta   >$ffa0
*         clra
*         sta   >$ff90
*        sta   >$ff91
*         jmp   >$ed5f
*CodeSize equ   *-BootCode

