* F$LDABX entry point
FLDABX   ldb   R$B,u        Get task # to get byte from
         ldx   R$X,u        Get offset into task's DAT image to get byte from
***         bsr   L0C40        Go get the byte into B
* Load a byte from another task
* Entry: B=Task #
*        X=Pointer to data
* Exit : B=Byte from other task
L0C40    pshs  cc,a,x,u
         bsr   L0BF5
         ldd   a,u
         orcc  #IntMasks
         stb   >$FFA0
         ldb   ,x
         clr   >$FFA0
         puls  cc,a,x,u

         stb   R$A,u        Save into caller's A & return
         clrb             set to no errors
         rts   

* Get pointer to task DAT image
* Entry: B=Task #
* Exit : U=Pointer to task image
*L0C09    ldu   <D.TskIPt    get pointer to task image table
*         lslb               multiply task # by 2
*         ldu   b,u          get pointer to task image (doesn't affect carry)
*         rts                restore & return

* F$STABX entry point
FSTABX   ldd   R$D,u
         ldx   R$X,u
* Store a byte in another task
* Entry: A=Byte to store
*        B=Task #

*        X=Pointer to data
L0C28    andcc #^Carry
         pshs  cc,d,x,u
         bsr   L0BF5        calculate offset into DAT image
         ldd   a,u          get memory block
         lda   1,s
         orcc  #IntMasks
         stb   >$FFA0
         sta   ,x
         clr   >$FFA0
         puls  cc,d,x,u,pc
