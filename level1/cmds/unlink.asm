********************************************************************
* Unlink - Unlink memory module
*
* $Id$
*
* Ed.    Comments                                       Who YY/MM/DD
* ------------------------------------------------------------------
*   2    From Tandy OS-9 Level One VR 02.00.00

         nam   Unlink
         ttl   Unlink memory module

* Disassembled 02/04/03 22:32:26 by Disasm v1.6 (C) 1988 by RML

         ifp1
         use   defsfile
         endc

tylg     set   Prgrm+Objct   
atrv     set   ReEnt+rev
rev      set   $01
edition  set   2

         mod   eom,name,tylg,atrv,start,size

         org   0
u0000    rmb   512
size     equ   .

name     fcs   /Unlink/
         fcb   edition

start    clra  
         clrb  
         os9   F$Link   
         bcs   L0032
         os9   F$UnLink 
         bcs   L0032
         os9   F$UnLink 
         bcs   L0032
         lda   ,x+
         cmpa  #C$COMA
         beq   start
         lda   ,-x
         cmpa  #C$CR
         bne   start
         clrb  
L0032    os9   F$Exit   

         emod
eom      equ   *
         end

