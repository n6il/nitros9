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
         ldx   R$X,u        get address of allocation bit map
         bsr   CalcBit      calculate byte & position & get first bit mask
         ldy   <D.Proc      get current task #
         ldb   P$Task,y     get task number
         bra   SetBit       go do it

* F$AllBit (System State)
FSAllBit ldd   R$D,u        get bit # to start with
         ldx   R$X,u        get address of allocation bit map
         bsr   CalcBit      calculate byte & pos & get first bit mask
         ldb   <D.SysTsk    Get system task #

* Main bit setting loop
SetBit   equ   *
         IFNE  H6309
         ldw   R$Y,u        get # bits to set
         ELSE
         ldy   R$Y,u        get # bits to set
         ENDC
         beq   BitEx        nothing to set, return
         sta   ,-s          preserve current mask
         bmi   SkpBit       If high bit set, skip ahead
         os9   F$LDABX      Go get original value from bit map 
NxtBitLp ora   ,s           OR it with the current mask
         IFNE  H6309
         decw               Dec the bit counter
         ELSE
         leay  -1,y
         ENDC
         beq   BitStEx      Done, go put the byte back into the task's map
         lsr   ,s           Shift out the lowest bit of original
         bcc   NxtBitLp     If it is a 0, do next bit
         os9   F$STABX      If it was a 1 (which means whole byte done),
         leax  1,x          Store finished byte and bump ptr
SkpBit   lda   #$FF         Preload a finished byte
         bra   SkpBit2      Skip ahead

StFulByt os9   F$STABX      Store full byte
         leax  1,x          Bump ptr up 1
         IFNE  H6309
         subw  #8           Bump counter down by 8
SkpBit2  cmpw  #8           Is there at least 8 more (a full byte) to do?
         ELSE
         leay  -8,y
SkpBit2  cmpy  #$0008
         ENDC
         bhi   StFulByt     More than 1, go do current
         beq   BitStEx      Exactly 1 byte left, do final store & exit

* Last byte: Not a full byte left loop
L085A    lsra               Bump out least sig. bit
         IFNE  H6309
         decw               Dec the bit counter
         ELSE
         leay  -1,y
         ENDC
         bne   L085A        Keep going until last one is shifted out
         coma               Invert byte to get proper result
         sta   ,s           Preserve a sec
         os9   F$LDABX      Get byte for original map
         ora   ,s           Merge with new mask
BitStEx  os9   F$STABX      Store finished byte into task
         leas  1,s          Eat the working copy of the mask
BitEx    clrb               No error & return
         rts   

* Calculate address of first byte we want, and which bit in that byte, from
*   a bit allocation map given the address of the map & the bit # we want to
*   point to
* Entry: D=Bit #
*        X=Ptr to bit mask table
* Exit:  A=Mask to point to bit # within byte we are starting on
*        X=Ptr in allocation map to first byte we are starting on
CalcBit  pshs  b,y          preserve registers
         IFNE  H6309
         lsrd               divide bit # by 8 to calculate byte # to start
         lsrd               allocating at
         lsrd
         addr  d,x          Offset that far into the map
         ELSE
         lsra
         rorb
         lsra
         rorb
         lsra
         rorb
         leax  d,x
         ENDC
         puls  b            restore bit position LSB
         leay  <L0883,pc    point to mask table
         andb  #7           round it down to nearest bit
         lda   b,y          get bit mask
         puls  y,pc         restore & return

* Bit position table (NOTE that bit #'s are done by left to right)
L0883    fcb   $80,$40,$20,$10,$08,$04,$02,$01


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
FDelBit  ldd   R$D,u        Get bit # to start with
         ldx   R$X,u        Get addr. of bit allocation map
         bsr   CalcBit      Point to starting bit
         ldy   <D.Proc      Get current Task #
         ldb   P$Task,y     get task #
         bra   L08A0        Do rest of 0 bits

* F$DelBit entry point for system state
FSDelBit ldd   R$D,u        Get bit # to start with
         ldx   R$X,u        Get addr. of bit allocation map
         bsr   CalcBit      Point to starting bit
         ldb   <D.SysTsk    Get system task #

L08A0    equ   *
         IFNE  H6309
         ldw   R$Y,u        Get # bits to clear
         ELSE
         ldy   R$Y,u        Get # bits to clear
         ENDC
         beq   L08E0        None, return
         coma               Invert current bit mask
         sta   ,-s          Preserve on stack
         bpl   L08BC        If high bit clear, skip ahead
         os9   F$LDABX      Go get byte from user's map
L08AD    anda  ,s           AND it with current mask
         IFNE  H6309
         decw               Dec the bits left counter
         ELSE
         leay  -1,y
         ENDC
         beq   BitDone      Done, store finished byte back in task's map
         asr   ,s           Shift out lowest bit, leaving highest alone
         bcs   L08AD        If it is a 1, do next bit
         os9   F$STABX      If it was a 0 (which means whole byte done),
         leax  1,x          store finished byte & inc. ptr
L08BC    clra               Preload a cleared byte
         bra   ChkFull      skip ahead
L08BF    os9   F$STABX      Store full byte
         leax  1,x          Bump ptr up by 1
         IFNE  H6309
         subw  #8           Dec bits left counter by 8
ChkFull  cmpw  #8           At least 1 full byte left?
         ELSE
         leay  -8,y
ChkFull  cmpy  #8
         ENDC
         bhi   L08BF        Yes, do a whole byte in 1 shot
         beq   BitDone      Exactly 1, store byte & exit
         coma               < full byte left, invert bits
L08CF    lsra               Shift out rightmost bit
         IFNE  H6309
         decw               Dec bits left counter
         ELSE
         leay  -1,y
         ENDC
         bne   L08CF        Keep doing till done
         sta   ,s           Save finished mask
         os9   F$LDABX      Get original byte from task
         anda  ,s           Merge cleared bits with it
BitDone  os9   F$STABX      Store finished byte into task
         leas  1,s          Eat working copy of mask
L08E0    clrb               Eat error & return
         rts   


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
FSchBit  ldd   R$D,u        Get start bit #
         ldx   R$X,u        Get addr. of allocation bit map
         bsr   CalcBit      Point to starting bit
         ldy   <D.Proc      Get task #
         ldb   P$Task,y
         bra   L08F8        skip ahead

* F$SchBit entry point for system
FSSchBit ldd   R$D,u        Get start bit #
         ldx   R$X,u        Get addr. of allocation bit map
         lbsr  CalcBit      Point to starting bit
         ldb   <D.SysTsk    Get task #
* Stack: 0,s : byte we are working on (from original map)
*        1,s : Mask of which bit in current byte to start on
*        2,s : Task number the allocation bit map is in
*        3,s : Largest block found so far
*        5,s : Starting bit # of requested (or closest) size found
*        7,s : Starting bit # of current block being checked (2 bytes) (NOW IN Y)
         IFNE  H6309
L08F8    pshs  cc,d,x,y    Preserve task # & bit mask & reserve stack space
         clrd              Faster than 2 memory clears
         ELSE
L08F8    pshs  cc,d,x,y,u  Preserve task # & bit mask & reserve stack space
         clra
         clrb
         ENDC
         std   3,s         Preserve it
         IFNE  H6309
         ldw   R$D,u       get start bit #
         tfr   w,y         save as current block starting bit #
         ELSE
         ldy   R$D,u
         sty   7,s
         ENDC
         bra   Skipper     skip ahead

* New start point for search at current location
RstSrch  equ   *
         IFNE  H6309
         tfr   w,y         Preserve current block bit # start
         ELSE
         sty   7,s
         ENDC
* Move to next bit position, and to next byte if current byte is done
MoveBit  lsr   1,s         Move to next bit position
         bcc   CheckBit    If not the last one, check it
         ror   1,s         Move bit position marker to 1st bit again
         leax  1,x         Move byte ptr (in map) to next byte

* Check if we are finished allocation map
Skipper  cmpx  R$U,u       done entire map?
         bhs   BadNews     yes, couldn't fit in 1 block, notify caller
         ldb   2,s         Get task number
         os9   F$LDABX     Get byte from bit allocation map
         sta   ,s          Preserve in scratch area

* Main checking
CheckBit equ   *
         IFNE  H6309
         incw              Increment current bit #
         ELSE
         leay  1,y
         ENDC
         lda   ,s          Get current byte
         anda  1,s         Mask out all but current bit position
         bne   RstSrch     If bit not free, restart search from next bit
         IFNE  H6309
         tfr   w,d         Dupe current bit # into D
         subr  y,d         Calculate size we have free so far
         cmpd  R$Y,u       As big as user requested?
         ELSE
         tfr   y,d
         subd  7,s
         cmpd  R$Y,u
         ENDC
         bhs   WereDone    Yes, we are done
         cmpd  $03,s       As big as the largest one we have found so far?
         bls   MoveBit     No, move to next bit and keep going
         std   $03,s       It is the largest, save current size
         IFNE  H6309
         sty   $05,s       Save as start bit # of largest block found so far
         ELSE
         ldd   7,s
         std   5,s
         ENDC
         bra   MoveBit     Move to next bit and keep going

* Couldn't find requested size block; tell user where the closest was found
*   and how big it was
BadNews  ldd   $03,s       Get size of largest block we found
         std   R$Y,u       Put into callers Y register
         comb              Set carry to indicate we couldn't get full size
         ldd   5,s         Get starting bit # of largest block we found
         bra   BadSkip     skip ahead
* Found one, tell user where it is
WereDone equ   *
         IFNE  H6309
         tfr   y,d         Get start bit # of the block we found
         ELSE
         ldd   7,s
         ENDC
BadSkip  std   R$D,u       Put starting bit # of block into callers D register
         IFNE  H6309
         leas  $07,s       Eat our temporary stack area & return
         ELSE
         leas  $09,s
         ENDC
         rts   
