********************************************************************
* Makdir - Create directory file
*
* $Id$
*
* Ed.    Comments                                       Who YY/MM/DD
* ------------------------------------------------------------------
*  2     Original Microware distribution version

         nam   Makdir
         ttl   Create directory file

* Disassembled 02/04/03 23:05:28 by Disasm v1.6 (C) 1988 by RML

         ifp1
         use   defsfile
         endc

tylg     set   Prgrm+Objct   
atrv     set   ReEnt+rev
rev      set   $01

         mod   eom,name,tylg,atrv,start,size

u0000    rmb   450
size     equ   .

name     fcs   /Makdir/
         fcb   $04 

start    ldb   #DIR.+PREAD.+PWRIT.+PEXEC.+READ.+WRITE.+EXEC.
         os9   I$MakDir 
         bcs   L001C
         clrb  
L001C    os9   F$Exit   

         emod
eom      equ   *
         end

