**************************************************
* System Call: F$SRqMem
*
* Function: Request memory
*
* F$SRqMem allocates memory from the system in 256 byte 'pages.'
* There are 256 of these '256 byte pages' in RAM (256*256=64K).
* The allocation map, pointed to by D.FMBM holds 8 pages per byte, making the
* allocation map itself 32 bytes in size.
*
* Memory is allocated from the top of the system RAM map downwards.  Rel/Boot/Krn
* also reside in this area, and are loaded from $EE00-$FFFF.  Since this area is
* always allocated, we start searching for free pages from page $ED downward.
*
* Input:  D = Byte count
*
* Output: U = Address of allocated memory area
*
* Error:  CC = C bit set; B = error code
*
FSRqMem  ldd   R$D,u        get memory allocation size requested
         addd  #$00FF       round it up to nearest 256 byte page (e.g. $1FF = $2FE)
         clrb               just keep # of pages (e.g. $2FE = $200)
         std   R$D,u        save rounded version back to user
         ldx   <D.FMBM+2    get ptr to end of free memory bitmap
         ldd   #$01FF		A = $01 (RAM IN USE flag), B = $FF (counter)
         pshs  b,a			save onto stack
         bra   L0604		start the search
L05FA    dec   $01,s
         ldb   $01,s
L05FE    lsl   ,s
         bcc   L060A
         rol   ,s
L0604    leax  -1,x			backup into free memory bitmap
         cmpx  <D.FMBM		did we move past the begining?
         bcs   L0620		branch if so
L060A    lda   ,x			get byte in current location in free memory bitmap
         anda  ,s			AND with $01 on stack
         bne   L05FA		branch if not free
         dec   1,s			decrement counter on stack
         subb  1,s
         cmpb  R$A,u
         rora
         addb  1,s
         rola
         bcs   L05FE
         ldb   1,s
         clra
         incb
L0620    leas  2,s
         bcs   L0635
         ldx   <D.FMBM		get pointer to start of free memory bitmap
         tfr   d,y
         ldb   R$A,u		get MSB into B (this will be bit count)
         clra				clear A
         exg   d,y
* X = address of allocation bitmap
* D = Number of first bit to set
* Y = Bit count (number of bits to set)
         bsr   L065A		call into F$AllBit to allocate bits
         exg   a,b
         std   R$U,u		put allocated addres into caller's U
L0633    clra
         rts
L0635    comb
         ldb   #E$MemFul
         rts



**************************************************
* System Call: F$SRtMem
*
* Function: Return memory
*
* Input:  U = Address of memory to return
*         D = Number of bytes to return
*
* Output: None
*
* Error:  CC = C bit set; B = error code
*
FSRtMem  ldd   R$D,u        get memory allocation size requested
         addd  #$00FF       round it up to nearest 256 byte page (e.g. $1FF = $2FE)
         tfr   a,b			put MSB into B
         clra				now D reflects number of pages (not bytes)
         tfr   d,y			put 16 bit page count into Y
         ldd   R$U,u		get address of memory to free
         beq   L0633		if user passed 0, ignore
         tstb				check for B = 0 (it should!)
         beq   L064E
         comb				the user has passed B<>0 for the address, so return bad page error
         ldb   #E$BPAddr
         rts
L064E    exg   a,b			swap A/B
         ldx   <D.FMBM		get pointer to free memory bitmap
         bra   L06AD		call into FDelBit to delete bits
