********************************************************************
* Printerr - OS-9 Level One printerr routine
*
* $Id$
*
* Ed.    Comments                                       Who YY/MM/DD
* ------------------------------------------------------------------
*   6    From Tandy OS-9 Level One VR 02.00.00
*   7    Changed /D0 to /DD                             BGP 02/07/13

         nam   Printerr
         ttl   OS-9 Level One printerr routine

         ifp1
         use   defsfile
         endc

tylg     set   Prgrm+Objct
atrv     set   ReEnt+rev
rev      set   $01
edition  set   7

         mod   eom,name,tylg,atrv,start,size

         org   0
datarea  rmb   86
size     equ   .

name     fcs   /Printerr/
         fcb   edition

ErrFile  fcc   "/DD/SYS/ERRMSG"
         fcb   C$CR
         fcc   ",,,,,,,,,,,,"

ErrMsg   fcc   "Error #"
         fcb   $FF

SysSVC   fcb   F$PErr
         fdb   FPErr-*-2
         fcb   $80

start    clra			any module
         leax  <name,pcr	point to name
         os9   F$Link		link one extra time
         bcs   error		branch if error
         leay  <SysSVC,pcr	point to system service table
         os9   F$SSvc		add it to system calls
         clrb			clear carry
error    os9   F$Exit		and exit

FPErr    ldx   <D.Proc		get current process pointer
         lda   P$PATH+2,x	get stderr path
         beq   Exit2		branch if not open
         leas  <-$56,s		else make room on stack
         ldb   R$B,u		get error code
         leau  ,s		point U to save area
         sta   ,u		store path
         stb   2,u		store error code
         bsr   PErrOrg		print error as originally done
         lda   #READ.		read access mode
         leax  >ErrFile,pcr	point to error file
         os9   I$Open		open path to it
         sta   1,u		save path to file
         bcs   Exit1		branch if error
         bsr   FindErr		attempt to find line that matches error code
         bcs   Close		if error, close file and return to OS-9
         bne   Close
L0077    bsr   WriteLn		else write line
         bsr   ReadLine		read next line
         bcs   Close		branch if error
         ldb   ,x		get first byte of line just read
         cmpb  #'0		number?
         bcs   L0077		branch if not
Close    lda   1,u		get path
         os9   I$Close		close path to error file
Exit1    leas  <$56,s		clean stack
Exit2    clrb			clear carry
         rts			and return to OS-9

FindErr  bsr   ReadLine		read line
         bcs   L009B		branch if error
         bsr   L00DE		get error number
         cmpa  #'0
         bcc   FindErr
         cmpb  2,u		same as error?
         bne   FindErr		branch if not
L009B    rts

* read a line from the error file
ReadLine lda   1,u		get path number of file
         leax  5,u		point X to buffer
         ldy   #80		max 80 chars
         os9   I$ReadLn		read line
         rts

PErrOrg  leax  >ErrMsg,pcr	point X to error header
         leay  5,u		point Y to buffer area
         lda   ,x+		get byte at X
CopyLoop sta   ,y+		and store it at Y
         lda   ,x+		get byte...
         bpl   CopyLoop		while hi bit not set in A
         ldb   2,u		get error number
         lda   #$2F		start out just below '0
L00BA    inca			increment A
         subb  #$64		subtract
         bcc   L00BA		continue if carry clear
         sta   ,y+		else store as character
         lda   #$3A		start out just beyond '9
L00C3    deca			decrement A
         addb  #10		add 10 to B
         bcc   L00C3		continue if carry clear
         sta   ,y+		save A
         tfr   b,a		transfer
         adda  #$30		add '0
         ldb   #C$CR
         std   ,y+
         leax  5,u		point X at buffer
WriteLn  ldy   #80		max string len
         lda   ,u		get stderr path
         os9   I$WritLn		write it out
         rts

L00DE    clrb			clear B
L00DF    lda   ,x+		get byte from X
         suba  #'0		make 8 bit integer
         cmpa  #$09		compare against 9
         bhi   L00F0		branch if greater
         pshs  a		else save A
         lda   #10		multiply by 10
         mul			do it
         addb  ,s+		add on stack
         bcc   L00DF		if carry clear, do it again
L00F0    lda   -1,x		load byte
         rts			return

         emod
eom      equ   *
         end

