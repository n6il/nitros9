********************************************************************
* DirM - Show module directory
*
* $Id$
*
* Changes:
*
* Added internal print buffer, so an I$Write call is not performed for every
* byte printed out.  Halves printout time.
*
* Added SS.ScSiz check, and goes to 32-column output if display is 40 columns
* or less.
*
* Ed.    Comments                                       Who YY/MM/DD
* ------------------------------------------------------------------
* ?      Disassembled at 8:18:38                        AD  94/11/10
* 5      Added internal print buffer, so an I$Write     AD  ??/??/??
*        call is not performed for every byte printed
*        out.  Halves printout time.  Added SS.ScSiz
*        check, and goes to 32-column output if display
*        is 40 columns or less.

         nam   DirM
         ttl   Show module directory

         ifp1
         use   defsfile
         endc

tylg     set   Prgrm+Objct   
atrv     set   ReEnt+rev
rev      set   $01
edition  set   5

Bound    equ   40         width at which change is made to 32-col printing


         mod   eom,name,tylg,atrv,start,size

MD.DAT   rmb   2
MD.Crnt  rmb   2
MD.Strt  rmb   2
MD.End   rmb   2
MD.MPDAT rmb   5
PntCnt   rmb   1

*Single   rmb   1          single entry/line?
Width    rmb   1          width of the output device

PBuffer  rmb   31         internal print buffer
Buffer   rmb   40         room for a name buffer
MD.Data  rmb   2048       size of the module directory
         rmb   200        for the stack
size     equ   .
name     equ   *
         fcs   /DirM/
         fcb   edition

H2       fcc   / Bk Ofst Size Ty At Link Name/
         fcb   C$CR
H3       fcc   / -- ---- ---- -- -- ---- -----/
H1       fcb   C$CR

* Believe it or not, all this internal crap is still smaller than having
* a different version of the header for 32/80 columns.
Dump     ldu   #PBuffer   output print buffer
         lda   ,x+        get first character
         sta   ,u+        move it over
         ldb   <Width     get the width

D.01     cmpa  #C$CR      CR?
         beq   D.Print    yup, dump it out

         lda   ,x+        grab a character
         sta   ,u+        save it
         cmpa  #C$SPAC    was it a space?
         bne   D.01       no, just save it

         cmpb  #Bound     40-column screen?
         bls   D.01       yes, don't add the space
         sta   ,u+        if a space, save another copy of it
         bra   D.01

D.Print  lda   #$01       to STDOUT
         ldx   #PBuffer
         ldy   #50        max. size of data to print
         OS9   I$WritLn   dump it out
         bcs   Exit
         rts

start    equ   *
         stu   <MD.DAT    u=$0000 always on startup in OS-9 LII
         ldd   #$0100+SS.ScSiz stdout, get screen size
         OS9   I$GetStt
         bcs   s.01
         tfr   x,d
         bra   s.02       save actual screen size

s.01     cmpb  #E$UnkSvc
         bne   Exit
         ldb   #80        default to 80 columns if error
s.02     stb   <Width

         leax  <H1,pcr   print out initial CR
         bsr   Dump
         leax  >H2,pcr   header of names
         bsr   Dump
         leax  <H3,pcr   and hyphens
         bsr   Dump

         ldx   #MD.Data
         os9   F$GModDr 
         bcs   Exit
         stu   <MD.Strt     save start address of system module dir

         sty   <MD.End     save end of the module directory
         bra   L00B5

ClnExit  clrb  
Exit     os9   F$Exit   

L00AD    ldx   <MD.Crnt
         leax  MD$ESIZE,x go to the next entry
         cmpx  <MD.End
         bcc   ClnExit

L00B5    stx   <MD.Crnt
         ldu   #PBuffer      temporary print buffer
         ldd   MD$MPDAT,x get module DAT image
         beq   L00AD      if zero, skip this entry
         pshs  d
         cmpd  <MD.DAT
         beq   L00CD
         std   <MD.DAT    save the current DAT image
         lda   #'-        start of this block
         fcb   $8C        skip 2 bytes

L00CD    lda   #C$SPAC    space
         sta   ,u+        store it in the data buffer
L00D0    puls  d          restore current DAT image
         subd  <MD.Strt   take out start of the block
         ldy   #MD.Data   point to module directory data
         leay  d,y        to the DAT image within it
         tfr   y,d
         std   <MD.MPDAT     save pointer to DAT
         lda   MD$MPtr,x  module pointer
         lsra  
         lsra  
         lsra  
         lsra             turn address into block offset
         anda  #$0E       keep low bits only
         inca             DAT image is (junk),(block)
         lda   a,y        get the starting block number
         bsr   L0165      dump it out
         ldd   MD$MPtr,x  get real pointer
         anda  #$1F       get offset inside block
         bsr   L0159      print it out
         ldx   MD$MPtr,x  and get pointer again

         pshs  u          save print buffer pointer
         ldu   #Buffer     to a name buffer
         ldy   #$000A     move first 10 bytes of the module?
         ldd   <MD.MPDAT
         os9   F$CpyMem   copy it over
         puls  u          restore print buffer ptr
         bcs   Exit

         ldd   <Buffer+M$Size
         bsr   L0159      print out the size of the module
         lda   <Buffer+M$Type
         bsr   L0165      print out the Ty/Lg
         lda   <Buffer+M$Revs
         bsr   L0165      print out At/Rv
         ldx   <MD.Crnt   get current module pointer
         ldd   MD$Link,x  link count
         bsr   L0159
         ldd   <Buffer+M$Name
         ldx   <MD.Crnt
         ldx   MD$MPtr,x  start address of the module
         leax  d,x        point to the name

         pshs  u          save print buffer ptr
         ldu   #Buffer    to the buffer again
         lda   <Width
         cmpa  #Bound
         bhi   n.01
         leau  -6,u       discount 6 spaces

n.01     ldd   <MD.MPDAT
         ldy   #40        copy over 40 bytes of the name
         os9   F$CpyMem 
         tfr   u,x        save copy of the start of the buffer
         puls  u          restore print buffer ptr
         lbcs  Exit

         ldb   #39        maximum number of characters to check
L013F    lda   ,x+        get a character
         bpl   L013F      if it's OK
         anda  #$7F       force it to be printable
         sta   -1,x       save it again
         lda   #C$CR      drop a CR after the last character of the name

         sta   ,x         save it
         ldx   #PBuffer   point to the start of the buffer
         ldy   #64        64 characters
         lda   #$01
         os9   I$WritLn   print out the name
         lbra  L00AD      start all over again

* Print out a 2-byte hex number in D
L0159    pshs  b          save low order character
         ldb   #3         3 digits to print out
         bsr   L0171      print out A
         puls  a          restore low byte
         bsr   L0173      print it, too
         bra   L0167      and dump out 2 spaces

* print out a 1-digit hex number in A
L0165    bsr   L016F
L0167    lda   <Width     check the width
         cmpa  #Bound
         bls   L016B      if 40 columns or smaller, don't print extra space
         lda   #C$SPAC    space
         sta   ,u+
L016B    lda   #C$SPAC    and another space
         sta   ,u+
         rts

L016F    ldb   #$01
L0171    stb   <PntCnt
L0173    tfr   a,b        save a copy of the number in B
         lsra  
         lsra  
         lsra  
         lsra             move high nibble into the lower nibble
         bsr   L017D      print out lower nibble of A as hex number
         tfr   b,a        restore lower nibble

L017D    anda  #$0F       make 0-15
         beq   L019C      if zero, skip printing it out
         clr   <PntCnt
         cmpa  #$0A       higher than A?
         bcs   L0189      no, add in ascii zero
         adda  #$07       yes, add difference between 9 and A
L0189    adda  #'0        turn it into an ascii number

Print    sta   ,u+        save the character in the buffer
         rts

L019C    dec   <PntCnt    count down of number of characters to print
         bmi   L0189      if last one, print out a zero
         bra   L016B      otherwise print out a space

         emod
eom      equ   *
         end
