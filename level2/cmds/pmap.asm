********************************************************************
* PMap - Show process map information
*
* $Id$
*
* From "Inside Level II" by Kevin Darling
*
* Edt/Rev  YYYY/MM/DD  Modified by
* Comment
* ------------------------------------------------------------------
*   ?      1987/02/08  Kevin Darling
* Original version.
*
*   2      1989/09/12  Ken Drexler
* Revised to handle 4K or 8K blocks.

         nam   PMap
         ttl   Show process map information

         ifp1  
         use   defsfile
         endc  

Type     set   Prgrm+Objct
Revs     set   ReEnt+0
Bufsiz   set   512
edition  set   2

stdout   set   1
maxnam   set   30

         pag   
***************************************************
*
         mod   PrgSiz,Name,Type,Revs,Entry,DatSiz

Name     fcs   /PMap/
         fcb   edition

* Data Equates
umem     rmb   2
sysImg   rmb   2          pointer to sysprc datimg
datimg   rmb   2          datimg for copymem
lineptr  rmb   2
number   rmb   3
leadflag rmb   1
pid      rmb   1
hdr      rmb   12
blkcnt   rmb   1          no. blocks/64k
outbuf   rmb   80
buffer   rmb   bufsiz*2   working proc. desc.
stack    rmb   200
datsiz   equ   .

*************************************************
*
* Messages
*
Head1A   fcc   / ID   01 23 45 67 89 AB CD EF  Program    /
         fcb   C$CR

Head2A   fcc   /____  __ __ __ __ __ __ __ __  ___________/
Hdrcr    fcb   C$CR

Head1B   fcc   / ID   0  1  2  3  4  5  6  7  8  9  A  B  C  D  E  F   Program/
         fcb   C$CR

Head2B   fcc   /____  __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __  _______/
         fcb   C$CR

SysNam   fcs   "SYSTEM"
syslen   equ   *-Sysnam

         spc   3
***************************************************
*
Entry    stu   Umem
         lda   #1         start with process 1
         clr   Pid

* Print header
         leax  buffer,u   point at storage
         os9   F$GBlkMp   get block info
         bcs   Error
         cmpd  #8192      8k?
         beq   Set8k
         cmpd  #4096      4k?
         beq   Set4k
         bra   Error      we only do 4k/8k

Set8k    lda   #64/8
         bra   Entry1

Set4k    lda   #64/4
Entry1   sta   blkcnt     save size
         leax  Hdrcr,pcr  print line
         lbsr  PrintL1    print it
         lda   blkcnt
         cmpa  #64/4      4k?
         beq   Headr4
Headr8   leax  Head1A,pcr
         lbsr  PrintL1    print it
         leax  Head2A,pcr
         bra   Head41

Headr4   leax  Head1B,pcr
         lbsr  PrintL1
         leax  Head2B,pcr
Head41   lbsr  PrintL1

* Main Program Loop
Main     ldu   umem
         leax  OutBuf,U   set line pointer
         stx   Lineptr
         inc   Pid        next process
         beq   Bye        >= 255 --> exit
         lda   Pid        get proc id
         leax  Buffer,U   set destination
         os9   F$GPrDsc
         bcs   Main       loop if no descriptor
         bsr   Output     print data for descriptor
         bra   Main

Bye      clrb  
Error    os9   F$Exit

* Subroutines

Output   lda   P$ID,X     process id
         lbsr  Outdecl
         lbsr  Space
         lbsr  Space

* Print Process DAT Image
*  IN:  x = process descriptor
*
         pshs  X
         leax  P$DATImg,x point to DAT image
         ldb   blkcnt     set count
         pshs  b

PrntImg  ldd   ,x++       get DAT block
         cmpd  #$00FC     empty?
         bne   prntimg2
         ldy   lineptr
         ldd   #"..
         std   ,y++
         sty   lineptr
         lbsr  space
         bra   prntimg3

PrntImg2 tfr   b,a        print block no.
         lbsr  Out2HS

PrntImg3 dec   ,s         count -= 1
         bne   Prntimg
         puls  b,x

* Print primary module name
* IN: X - process descriptor
*
         lbsr  Space
         leay  P$DATImg,X
         tfr   Y,D        d=dat image
         std   datimg     save pointer
         ldx   P$PModul,X x=offset in map
         bne   doname
         leax  >sysnam,pcr point at name
         ldy   lineptr
         ldb   #syslen

Copy     lda   ,x+
         sta   ,y+
         decb  
         bne   copy
         bsr   Name2
         bra   Printlin

Doname   bsr   Printnam

* Print Line
Printlin ldx   lineptr    terminate line
         lda   #C$CR
         sta   ,X
         ldu   umem
         leax  outbuf,U

* Print line
PrintL1  ldy   #80
         lda   #stdout
         os9   I$Writln
         bcs   Error
         rts   

** Find and print a module name
* IN:  X - module offset
*      U - data area
*      datimg = pointer
*
Printnam equ   *

* Read module header
         pshs  U          save u
         leau  hdr,U      destination
         ldd   datimg     proc datimg pointer
         ldy   #10        set length
         os9   F$CpyMem
         lbcs  Error

* Read name from Module to buffer
         ldd   M$Name,U   get name offset from header
         ldu   lineptr    move name to outbuf
         leax  D,X        X - offset to name
         ldd   datimg
         ldy   #maxnam    set maximum length
         os9   F$CpyMem
         puls  U
         lbcs  Error

Name2    pshs  X
         ldx   lineptr
         clrb             set length = 0
Name3    incb  
         lda   ,X+
         bpl   Name3
         cmpb  #40
         bcc   Name5
         anda  #$7F       clear d7
         sta   -1,X
         cmpb  #9
         bcc   Name5
         lda   #C$SPAC
Name4    sta   ,X+
         incb  
         cmpb  #9
         bcs   Name4
Name5    stx   lineptr
         puls  X,PC

* Print hex digit in A
Out2HS   bsr   Hexl

Space    lda   #C$SPAC
         bra   Print


* Print Hexidecimal Digit in A
Hexl     tfr   A,B
         lsra  
         lsra  
         lsra  
         lsra  
         bsr   Outhex
         tfr   B,A
Outhex   anda  #$0F
         cmpa  #$0A       0 - 9
         bcs   Outdig
         adda  #$07       A - F
Outdig   adda  #'0        make ASCII

* Put character in A in buf
Print    pshs  X
         ldx   lineptr
         sta   ,X+
         stx   lineptr
         puls  X,PC

* Print 1 Decimal Digit in A
*
Outdecl  tfr   A,B        number to B
         clra  

* Print 2 Decimal Digits in D
Outdec   clr   leadflag
         pshs  X
         ldx   umem
         leax  number,X
         clr   ,X
         clr   1,X
         clr   2,X
Hundred  inc   ,X
         subd  #100
         bcc   Hundred
         addd  #100
Ten      inc   1,X
         subd  #10
         bcc   Ten
         addd  #10
         incb  
         stb   2,X
         bsr   Printled
         bsr   Printled
         bsr   Printnum
         bsr   Space
         puls  X,PC

Printnum lda   ,X+        get char
         adda  #'0-1      make ASCII
         bra   Print

Printled tst   leadflag   print leading zero?
         bne   Printnum   yes
         ldb   ,X         is it zero?
         inc   leadflag
         decb  
         bne   Printnum   no, print zeros
         clr   leadflag
         lda   #C$SPAC
         leax  1,X
         bra   Print

         emod  
Prgsiz   equ   *
         end
