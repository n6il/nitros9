********************************************************************
* Unlink - Unlink a module
*
* $Id$
*
* Ed.    Comments                                       Who YY/MM/DD
* ------------------------------------------------------------------
* 2      Original Tandy/Microware version

         nam   Unlink
         ttl   Unlink a module

* Disassembled 98/09/10 23:12:44 by Disasm v1.6 (C) 1988 by RML

         ifp1
         use   defsfile
         endc

tylg     set   Prgrm+Objct   
atrv     set   ReEnt+rev
rev      set   $01
edition  set   2

         mod   eom,name,tylg,atrv,start,size

u0000    rmb   512
size     equ   .

name     fcs   /Unlink/
         fcb   edition

start    clra  
         os9   F$UnLoad 
         bcs   exit
         lda   ,x+
         cmpa  #C$COMA
         beq   start
         lda   ,-x
         cmpa  #C$CR
         bne   start
         clrb  
exit     os9   F$Exit   

         emod
eom      equ   *
         end
