**************************************************
* System Call: F$PrsNam
*
* Function: Parse a path name
*
* Modification to allow '-' in filenames by WG
*
* Input:  X = Address of pathlist
*
* Output: X = Updated past optional "/" character
*         Y = Address of last character of pathlist + 1
*         B = Length of pathlist
*
* Error:  CC = C bit set; B = error code
*
         IFGT  Level-1

FPrsNam  ldx   <D.Proc		proc desc
         leay  <P$DATImg,x	Y=DAT image ptr
         ldx   R$X,u		X=name string
         bsr   ParseNam		get it and length
         std   R$D,u		return length in D
         bcs   L073E		..err
         stx   R$X,u		and X at name begin
         abx			plus len
L073E    stx   R$Y,u		return Y=end of name ptr
         rts			end.

* Parse name
ParseNam equ   *
         pshs  y		save DAT image pointer
         lbsr  AdjBlk0		go find map block...
         pshs  x,y		save X offset within block and Y block pointer
         bsr   GoGetAXY		go get byte at X in block Y...
         cmpa  #'.		is the first character a period?
         bne   IsSlash		no, do proper first character checking
         lbsr  L0AC8		do a LDAXY, without changing X or Y
         bsr   ChkFirst		is the next character non-period?
         lda   #'.		restore the period character the LDAXY destroyed
         bcc   Do.Loop		if NON-period character, skip 1st char checks

IsSlash  cmpa  #PDELIM		is it a slash?
         bne   NotSlash		no, go keep X offset and block Y...
         bsr   GetChar		go get character...
NotSlash bsr   ChkFirst		go check if valid first character...
         bcs   NotValid		not valid, go get next name start offset in X...
Do.Loop  clrb			initialize character counter
LastLoop incb			add one character
         tsta			last character in name string?
         bmi   LastChar		yes, go return valid...
         bsr   GoGetAXY		go get next character...
         bsr   ChkValid		go check if valid character...
         bcc   LastLoop		valid, go check if last character...
LastChar andcc #^Carry
         bra   RtnValid

GetChar
         stx   2,s          save current offset over old offset
         sty   4,s          save current block pointer over old block pointer
GoGetAXY lbra  LDAXY        go get byte at X in block Y in A,  & return

NextLoop bsr   GetChar      go get character...
NotValid cmpa  #',          comma?
         beq   NextLoop     yes, go get next character...
         cmpa  #C$SPAC      space?
         beq   NextLoop     yes, go get next character...
         comb               error, set Carry
         ldb   #E$BNam      'Bad Name' error
RtnValid equ   *
         puls  x,y          recover offset & pointer
         bra   L0720        go do a similar exit routine

ChkFirst pshs  a            save character
         anda  #$7F         drop msbit
         bra   ChkRst       skip dash for first character check

* Determine if character in A is a valid filename character
ChkValid pshs  a            save character
         anda  #$7F         drop msbit
         cmpa  #'.          period?
         beq   ValidChr     yes, go return valid character...
ChkRest  cmpa  #'-          is it a dash?
         beq   ValidChr     yes, it's valid      
ChkRst   cmpa  #'z          greater than "z"?
         bhi   InvalidC     yes, go return invalid character...
         cmpa  #'a          greater than or equal to "a"?
         bhs   ValidChr     yes, go return valid character...
         cmpa  #'_          underscore?
         beq   ValidChr     yes, go return valid character...
         cmpa  #'Z          greater than "Z"?
         bhi   InvalidC     yes, go return invalid character...
         cmpa  #'A          greater than or equal to "A"?
         bhs   ValidChr     yes, go return valid character...
         cmpa  #'9          greater than "9"?
         bhi   InvalidC     yes, go return invalid character...
         cmpa  #'0          greater than or equal to "0"?
         bhs   ValidChr     yes, go return valid character...
         cmpa  #'$          dollar symbol?
         beq   ValidChr     yes, go return valid character...
InvalidC coma               invalid character, set carry
ValidChr puls  a,pc

         ELSE

FPrsNam  ldx   R$X,u
         bsr   ParseNam
         std   R$D,u
         bcs   L0749
         stx   R$X,u
L0749    sty   R$Y,u
         rts
ParseNam lda   ,x
         cmpa  #PDELIM                 pathlist char?
         bne   L0755                   branch if not
         leax  1,x                     go past pathlist char
L0755    leay  ,x
         clrb
         lda   ,y+
         anda  #$7F
         bsr   ChkRest
         bcs   L0772
L0760    incb
         lda   -1,y
         bmi   L076F                   hi bit set on this char, done
         lda   ,y+
         anda  #$7F
         bsr   ChkFirst
         bcc   L0760
         lda   ,-y
L076F    andcc #^Carry
         rts
L0772    cmpa  #C$COMA                 comma?
         bne   L0778
L0776    lda   ,y+
L0778    cmpa  #C$SPAC                 space?
         beq   L0776
         lda   ,-y
         comb
         ldb   #E$BNam
         rts

* check for illegal characters in a pathlist
ChkFirst cmpa  #C$PERD                 period?
         beq   L07C9                   branch if so
ChkRest  cmpa  #'0                     zero?
         bcs   L07A2                   branch if less than
         cmpa  #'9                     number?
         bls   L07C9                   branch if lower/same
         cmpa  #'_                     underscore?
         beq   L07C9                   branch if so
         cmpa  #'A                     A?
         bcs   L07A2                   branch if less than
         cmpa  #'Z                     Z?
         bls   L07C9                   branch if less or equal
         cmpa  #'a                     a?
         bcs   L07A2                   branch if lower
         cmpa  #'z                     z?
         bls   L07C9                   branch if less or equal
L07A2    orcc  #Carry
         rts

         ENDC
