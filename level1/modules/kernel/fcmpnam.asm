**************************************************
* System Call: F$CmpNam
*
* Function: Compare two names
*
* Input:  X = Address of first name
*         Y = Address of second name
*         B = length of first name
*
* Output: None
*
* Error:  CC = C bit set; B = error code
*

         IFGT  Level-1

FCmpNam  ldx   <D.Proc      get current process ptr
         leay  P$DATImg,x   Point to the DAT image
         ldx   R$X,u        Get pointer to string #1
         pshs  y,x          preserve 'em
         bra   L07CF

* F$CmpNam entry point for system state
FSCmpNam ldx   <D.Proc      Get current proc. dsc. ptr
         leay  P$DATImg,x   Point to it's DAT image
         ldx   R$X,u        get pointer to string #1
         pshs  x,y
         ldy   <D.SysDAT    get pointer to system DAT
L07CF    ldx   R$Y,u        get pointer to string #2
         pshs  y,x          Preserve them
         ldd   R$D,u        get length
         leax  4,s          point to string #1 info packet
         leay  ,s           point to string #2 info packet
         bsr   L07DE        go compare 'em
         leas  8,s          purge stack
         rts                return

* Compare 2 strings
*
* Input:  D = Length of string #1 (only requires B)
*         X = Ptr to string #1 info packet
*             0,X = DAT image pointer
*             2,X = Pointer to string
*         Y = Ptr to string #2 info packet
*             0,Y = DAT image pointer
*             2,Y = Pointer to string
*         U = Register stack ptr
L07DE    pshs  d,x,y,u      preserve registers
         tfr   x,u          U=ptr to string #1 packet
         pulu  x,y          get DAT ptr to Y and string ptr to X
         lbsr  AdjBlk0      adjust X to use block 0
         pshu  x,y          put them back
         ldu   4,s          get pointer to string #2 packet
         pulu  x,y          get DAT ptr to Y and string ptr to X
         lbsr  AdjBlk0      Adjust X to block 0
         bra   L07F6        go compare the strings

L07F2    ldu   4,s          get pointer to string #2 packet
         pulu  x,y          get DAT ptr to Y and string ptr to X
L07F6    lbsr  LDAXY        Map in the block & grab a byte from string
         pshu  x,y          Put updated DAT & string ptr back
         pshs  a            Save the character
         ldu   3,s          pointer to string #1 packet
         pulu  x,y          get DAT ptr to Y and string ptr to X
         lbsr  LDAXY        get byte from string #1
         pshu  y,x          put pointers back
         eora  ,s
         tst   ,s+          was it high bit?
         bmi   L0816        yes, check if last character in string #2
         decb  
         beq   L0813
         anda  #$DF         match?
         beq   L07F2        yes, check next character
L0813    comb               set carry
         puls  d,x,y,u,pc

L0816    decb               done whole string?
         bne   L0813        no, exit with no match
         anda  #$5F         match?
         bne   L0813        yes, keep checking
         clrb               strings match, clear carry
         puls  d,x,y,u,pc   restore & return

         ELSE

FCmpNam  ldb   R$B,u
         leau  R$X,u
         pulu  y,x
L07AB    pshs  y,x,b,a
L07AD    lda   ,y+
         bmi   L07BE
         decb
         beq   L07BA
         eora  ,x+
         anda  #$DF
         beq   L07AD
L07BA    orcc  #Carry
         puls  pc,y,x,b,a
L07BE    decb
         bne   L07BA
         eora  ,x
         anda  #$5F
         bne   L07BA
         puls  y,x,b,a
L07C9    andcc #^Carry
         rts

         ENDC
