********************************************************************
* Build - Simple text file creation utility
*
* $Id$
*
* Edt/Rev  YYYY/MM/DD  Modified by
* Comment
* ------------------------------------------------------------------
*   6      ????/??/??
* From Tandy OS-9 Level Two VR 02.00.01.

         nam   Build
         ttl   Simple text file creation utility

* Disassembled 98/09/10 23:19:12 by Disasm v1.6 (C) 1988 by RML

         ifp1
         use   defsfile
         endc

tylg     set   Prgrm+Objct   
atrv     set   ReEnt+rev
rev      set   $00
edition  set   6

         mod   eom,name,tylg,atrv,start,size

fpath    rmb   1
linebuff rmb   128
stack    rmb   450
size     equ   .

name     fcs   /Build/
         fcb   edition

*start    ldd   #(WRITE.*256)+PREAD.+UPDAT.  Level One edition 5 line
start    ldd   #(WRITE.*256)+UPDAT.
         os9   I$Create 		create file
         bcs   Exit			branch if error
         sta   <fpath			else save path to file
InpLoop  lda   #1			stdout
         leax  <Prompt,pcr		point to prompt
         ldy   #PromptL			and size of prompt
         os9   I$WritLn 		write line
         clra  				stdin
         leax  linebuff,u		point to line buffer
         ldy   #128			and max read size
         os9   I$ReadLn 		read line
         bcs   Close			branch if error
         cmpy  #$0001			1 byte read?
         beq   Close			if so, must be CR, exit
         lda   <fpath			else get file path
         os9   I$WritLn 		write line to file
         bcc   InpLoop			branch if ok
         bra   Exit			else exit
Close    lda   <fpath			get file path
         os9   I$Close  		close it
         bcs   Exit			branch if erro
         clrb  				else clear carry
Exit     os9   F$Exit   		and exit normally

Prompt   fcc   "? "
PromptL  equ   *-Prompt

         emod
eom      equ   *
         end

