********************************************************************
* krnp3 - Printerr functionality for Level 2
*
* $Id$
*
*    Peter E. Durham
*    The New Wentworth Timesharing System
*    summer: 6 Twin Brook Circle        school: Quincy House D-24
*            Andover, MA 01810                  58 Plympton St.
*            (617) 475-4243                     Cambridge, MA 02138
*                                               (617) 498-3209
*    cis:    73177,1215                 delphi: PEDXING
*    unix:   harvard!husc4!durham_2     intnet: durham_2@husc4.harvard.edu 
*
*  COPYRIGHT (C) 1987 by Peter Durham
*    Permission is given to all members of the OS-9 community to use,
*    modify, and share this program for their personal enjoyment.
*    Commercial use of this program, which was written for fun to share with
*    the community, is prohibited without the consent of the author.
*    Please share any extensions or modifications with the author, who
*    would be interested in hearing about them.
*
*  NOTE
*    Quick poll... how does the above sound as a copyright notice?  Clearly,
*    authors like to share their work while maintaining some control on it.
*    And it doesn't seem fair for someone else to make $ from something
*    someone else made for fun.  I think the above conditions are what most
*    people want.  Let me know what you think.
*
*  NOTE
*    The inspiration for this utility was the os9p3 example in
*    the Tandy Level 2 manual.  Tandy deserves praise for
*    including examples such as this one in their manuals.
*
*  NOTE
*    There is something funny about KrnP3 modules... some versions
*    are not liked, others are.  When developing this module, often
*    a version would fail... but if I added a "leas 0,s" right before
*    the "rts" in PrinBuf, it would work!  Probably the location and
*    operation are not significant.  This version here has never failed
*    to boot on my system; however, if it does on yours (or you change
*    it), try putting such things in.
*
*  NOTE
*    For those people who just can't have enough... KrnP3 will look for
*    a module called KrnP4, and link to it, and execute it.  Thanks to
*    Kev for this idea.  Now we can keep additions to the kernel in nice
*    separate chunks.  (How long 'til KrnP11 comes around...?)
*
* Edt/Rev  YYYY/MM/DD  Modified by
* Comment
* ------------------------------------------------------------------
*   1      1987/06/23  Peter E. Durham
* First release.

         nam   krnp3
         ttl   Printerr functionality for Level 2

         ifp1
         use   defsfile
         endc  

type     set   Systm      ;System module, 6809 object code
revs     set   0          ;
edition  set   1

         mod   eom,name,type,ReEnt+revs,entry,256

name     fcs   "KrnP3"
         fcb   edition

*+
*  Initialization routine and table
*-
Entry    equ   *
         leay  SvcTbl,pcr ;Get address of table
         os9   F$SSvc     ;Install services in table
         lda   #Type      ;Get system module type for KrnP4
         leax  P4Name,pcr ;Get name for KrnP4
         os9   F$Link     ;Try to link to it
         bcs   Exit       ;If not found, exit
         jsr   ,y         ;Go execute it!
Exit     rts              ;Return to KrnP2

SvcTbl   equ   *
         fcb   F$PErr     ;System call number
         fdb   PErr-*-2   ;Offset to code
         fcb   $80        ;End of table

*+
*  The new F$Perr service call
*-
*+
*  Data (in user space!)
*-
BufLen   equ   80
Buf      rmb   BufLen
HunDig   equ   Buf+7
TenDig   equ   Buf+8
OneDig   equ   Buf+9
DataMem  equ   .

*+
*  FUNCTION     PErr
*  PURPOSE      Top level routine
*  REGISTERS    B = Error code (after Setup)
*               U = User memory area (after Setup)
*               Y = User process descriptor (after Setup)
*               A = Error file path number (after OpenFil)
*               X = Pointer to strings
*-
PErr     equ   *
         bsr   Setup      ;Go set up registers
         leax  ErrMsg,pcr ;Get pointer to "Error #000"
         bsr   MoveBuf    ;Go copy it over
         bsr   WritNum    ;Go copy the number into it
         lbsr  PrinMsg    ;Go print the message
         bcs   PErrBye    ;If error, abort
         leax  FilNam,pcr ;Get pointer to "/dd/sys/errmsg"
         bsr   MoveBuf    ;Go copy it over
         lbsr  OpenFil    ;Go open the file
         bcs   PErrBye    ;If error, abort
Loop     lbsr  RdBuf      ;Go read a line from the file
         bcs   Error      ;If error, print CR, and abort
         pshs  b          ;Save error code
         pshs  b          ;Save error code again for compare
         bsr   CalcNum    ;What number is on this line?
         cmpb  ,s+        ;Is this line the right line?
         puls  b          ;Restore error code
         bne   Loop       ;If not right line, loop again
         lbsr  PrinBuf    ;If right line, write line out
         bra   Close      ;Done, so close the file
Error    lbsr  DoCR       ;Go print a carriage return
Close    lbsr  ClosFil    ;Go close the file
PErrBye  rts              ;Return from system call

*+
*  FUNCTION     SetUp
*  PURPOSE      Sets up registers
*  GIVES        B = Error code
*               U = Pointer to data memory on user stack in user space
*               Y = Pointer to user process descriptor in system space
*-
SetUp    equ   *
         ldb   R$B,u      ;Get error code
         ldy   D.Proc     ;Get user's process descriptor
         ldu   P$SP,y     ;Get user's stack pointer
         leau  -DataMem,u ;Reserve a little space
         rts   

*+
*  FUNCTION     MoveBuf
*  PURPOSE      Copies string to user space
*  TAKES        X = location of string in system space
*-
MoveBuf  equ   *
         pshs  u,y,d      ;Save registers
         lda   D.SysTsk   ;Get system process task number
         ldb   P$Task,y   ;Get user process task number
         leau  Buf,u      ;Get pointer to destination buffer
         ldy   #BufLen    ;Copy BufLen characters over (extras, oh well)
         os9   F$Move     ;Move string to user space
         puls  d,y,u,pc   ;Restore registers and return

*+
*  FUNCTION     WriteNum
*  PURPOSE      Puts the ASCII value of the error code in user space
*  TAKES        B = error code
*-
WritNum  equ   *
         pshs  x,d        ;Save registers
         clra             ;Start A as 0
Huns     cmpb  #100       ;Is B >= 100?
         blo   HunDone    ;If not, go do Tens
         inca             ;Increment hundreds digit
         subb  #100       ;Subtract 100 from B
         bra   Huns       ;Go do again
HunDone  leax  HunDig,u   ;Where to put digit
         bsr   WritDig    ;Go put it there
         clra             ;Start A again as 0
Tens     cmpb  #10        ;Is B >= 10?
         blo   TenDone    ;If not, go do Ones
         inca             ;Increment hundreds digit
         subb  #10        ;Subtract 10 from B
         bra   Tens       ;Go do again
TenDone  leax  TenDig,u   ;Where to put digit
         bsr   WritDig    ;Go put it there
         tfr   b,a        ;Get ones digit
         leax  OneDig,u   ;Where to put digit
         bsr   WritDig    ;Go put it there
         puls  d,x,pc     ;Restore registers and return

*+
*  FUNCTION     WritDig
*  PURPOSE      Copy digit into user space
*  TAKES        A = digit to copy (not in ASCII yet)
*               X = where to put digit
*-
WritDig  equ   *
         pshs  d          ;Save registers
         adda  #'0        ;Convert A to ASCII
         ldb   P$Task,y   ;Get task number
         os9   F$StABX    ;Write that digit to user space
         puls  d,pc       ;Restore registers and return

*+
*  FUNCTION     CalcNum
*  PURPOSE      Converts ASCII number in user space to binary
*  TAKES        Buf (in user space) = ASCII number
*  GIVES        B = number converted
*               X = points to first nonnumeric character
*-
CalcNum  equ   *
         pshs  a          ;Save register
         leax  Buf,u      ;Get pointer to buffer
         clrb             ;Set accumulator to zero
NextDig  bsr   LoadDig    ;Get digit from user space
         suba  #'0        ;Convert to binary; is it less than zero?
         bmi   CalcBye    ;If so, return
         cmpa  #9         ;Is the digit more than nine?
         bhi   CalcBye    ;If so, return
         pshs  a          ;Save the digit while we multiply
         lda   #10        ;Multiply current number by 10
         mul              ;Do it
         addb  ,s+        ;Add new digit to number
         leax  1,x        ;Advance X to next digit
         bra   NextDig    ;Go get the next digit
CalcBye  puls  a,pc       ;Restore register and return

*+
*  FUNCTION     LoadDig
*  PURPOSE      Get digit from user space
*  TAKES        X = pointer to digit in user space
*  GIVES        A = digit in user space
*-
LoadDig  equ   *
         pshs  b          ;Save register
         ldb   P$Task,y   ;Get user process task number
         os9   F$LdABX    ;Get digit
         puls  b,pc       ;Restore register and return

*+
*  FUNCTION     PrinMsg
*  PURPOSE      Prints out the Error #xxx message
*-
PrinMsg  equ   *
         pshs  y,x,a      ;Save registers
         lda   P$Path+2,y ;Get StdErr path number
         leax  Buf,u      ;Get pointer to message
         ldy   #ErrLen    ;Maximum ErrLen characters to print
         os9   I$Write    ;Write out error message
         puls  a,x,y,pc   ;Restore registers and return

*+
*  FUNCTION     DoCR
*  PURPOSE      Prints a carriage return
*-
DoCR     equ   *
         pshs  x,d        ;Save registers
         ldb   P$Task,y   ;Get user task number
         lda   #C$CR      ;Load A with a CR
         leax  Buf,u      ;Get pointer to buffer
         os9   F$StABX    ;Move the CR to the buffer
         bsr   PrinBuf    ;Go print it
         puls  d,x,pc     ;Restore registers and return

*+
*  FUNCTION     PrinBuf
*  PURPOSE      Prints out the string from user space
*  TAKES        X (in user space) = String to print
*-
PrinBuf  equ   *
         pshs  y,a        ;Save registers
         lda   P$Path+2,y ;Get StdErr path number
         ldy   #BufLen    ;Maximum BufLen characters to print
         os9   I$WritLn   ;Write out message
         puls  a,y,pc     ;Restore registers and return

*+
*  FUNCTION     RdBuf
*  PURPOSE      Reads in a string from file to user space
*  TAKES        A = path number
*  GIVES        Buf (in user space) = String read in
*-
RdBuf    equ   *
         pshs  y,x        ;Save registers
         leax  Buf,u      ;Get pointer to buffer
         ldy   #BufLen    ;Maximum BufLen characters to read
         os9   I$ReadLn   ;Read in line from file
         puls  x,y,pc     ;Restore registers and return

*+
*  FUNCTION     OpenFil
*  PURPOSE      Open path to error message file
*  TAKES        Buf (in user space) = name of file
*  GIVES        A = Path number
*-
OpenFil  equ   *
         pshs  x          ;Save register
         lda   #READ.     ;Open path for read access
         leax  Buf,u      ;Get pointer to string
         os9   I$Open     ;Open path
         puls  x,pc       ;Restore registers and return A

*+
*  FUNCTION     ClosFil
*  PURPOSE      Close path to error message file
*  TAKES        A = Path number
*-
ClosFil  equ   *
         os9   I$Close    ;Close file
         rts              ;Return
P4Name   fcc   "krnp4"
         fcb   C$CR
ErrMsg   fcc   "Error #000"
ErrLen   equ   *-ErrMsg
FilNam   fcc   "/dd/sys/errmsg"
         fcb   C$CR
FilLen   equ   *-FilNam

         emod  
eom      equ   *
         end   
