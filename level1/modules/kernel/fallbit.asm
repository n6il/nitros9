**************************************************
* System Call: F$AllBit
*
* Function: Sets bits in an allocation bitmap
*
* Input:  X = Address of allocation bitmap
*         D = Number of first bit to set
*         Y = Bit count (number of bits to set)
*
* Output: None
*
* Error:  CC = C bit set; B = error code
*
FAllBit  ldd   R$D,u        get bit # to start with
         leau  R$X,u        get address of allocation bit map
         pulu  y,x
L065A    pshs  y,x,b,a
         bsr   CalcBit      calculate byte & position & get first bit mask
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

* Calculate address of first byte we want, and which bit in that byte, from
*   a bit allocation map given the address of the map & the bit # we want to
*   point to
* Entry: D=Bit #
*        X=Ptr to bit mask table
* Exit:  A=Mask to point to bit # within byte we are starting on
*        X=Ptr in allocation map to first byte we are starting on
CalcBit  pshs  b
         IFNE  H6309
         lsrd               divide bit # by 8 to calculate byte # to start
         lsrd               allocating at
         lsrd
         addr  d,x          offset that far into the map
         ELSE
         lsra
         rorb
         lsra
         rorb
         lsra
         rorb
         leax  d,x
         ENDC
         puls  b
         lda   #$80
         andb  #$07           round it down to nearest bit
         beq   L06A6
L06A2    lsra
         decb
         bne   L06A2
L06A6    rts


**************************************************
* System Call: F$DelBit
*
* Function: Clears bits in an allocation bitmap
*
* Input:  X = Address of allocation bitmap
*         D = Number of first bit to clear
*         Y = Bit count (number of bits to clear)
*
* Output: None
*
* Error:  CC = C bit set; B = error code
*
FDelBit  ldd   R$D,u        get bit # to start with
         leau  R$X,u        get addr. of bit allocation map
         pulu  y,x
L06AD    pshs  y,x,b,a
         bsr   CalcBit
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


**************************************************
* System Call: F$SchBit
*
* Function: Search bitmap for a free area
*
* Input:  X = Address of allocation bitmap
*         D = Starting bit number
*         Y = Bit count (free bit block size)
*         U = Address of end of allocation bitmap
*
* Output: D = Beginning bit number
*         Y = Bit count
*
* Error:  CC = C bit set; B = error code
*
FSchBit  pshs  u
         ldd   R$D,u        get start bit #
         ldx   R$X,u        get addr. of allocation bitmap
         ldy   R$Y,u        get bit count
         ldu   R$U,u        get address of end of allocation bitmap
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
         bsr   CalcBit
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
