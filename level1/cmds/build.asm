********************************************************************
* Build - Simple text file creation utility
*
* $Id$
*
* Ed.    Comments                                       Who YY/MM/DD
* ------------------------------------------------------------------
* 5      Original Tandy distribution version
* 6      Brought up to OS-9 Level Two version, only     BGP 02/07/13
*        difference was use of PREAD. at start line
*        which is not present in OS-9 Level Two version.

         nam   Build
         ttl   Simple text file creation utility

* Disassembled 98/09/10 23:19:12 by Disasm v1.6 (C) 1988 by RML

         ifp1
         use   defsfile
         endc

tylg     set   Prgrm+Objct   
atrv     set   ReEnt+rev
rev      set   $01
edition  set   6

         mod   eom,name,tylg,atrv,start,size

FPath    rmb   1
LineBuff rmb   578
size     equ   .

name     fcs   /Build/
         fcb   edition

*start    ldd   #(WRITE.*256)+PREAD.+UPDAT.  Level One edition 5 line
start    ldd   #(WRITE.*256)+UPDAT.
         os9   I$Create 
         bcs   Exit
         sta   <FPath
InpLoop  lda   #1
         leax  <Prompt,pcr
         ldy   #PromptL
         os9   I$WritLn 
         clra  
         leax  LineBuff,u
         ldy   #128
         os9   I$ReadLn 
         bcs   Close
         cmpy  #$0001
         beq   Close
         lda   <FPath
         os9   I$WritLn 
         bcc   InpLoop
         bra   Exit
Close    lda   <FPath
         os9   I$Close  
         bcs   Exit
         clrb  
Exit     os9   F$Exit   

Prompt   fcc   "? "
PromptL  equ   *-Prompt

         emod
eom      equ   *
         end

