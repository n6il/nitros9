********************************************************************
* Piper - Pipe device driver
*
* $Id$
*
* Ed.    Comments                                       Who YY/MM/DD
* ------------------------------------------------------------------
*   2    From Tandy OS-9 Level One VR 02.00.00

         nam   Piper
         ttl   Pipe device driver

* Disassembled 98/08/23 17:31:20 by Disasm v1.6 (C) 1988 by RML

         ifp1
         use   defsfile
         endc

tylg     set   Drivr+Objct   
atrv     set   ReEnt+rev
rev      set   $01
edition  set   2

         mod   eom,name,tylg,atrv,Init,size

u0000    rmb   6
size     equ   .

         fcb   UPDAT.

name     fcs   /Piper/
         fcb   edition

Init     clrb  
         rts   
         nop   

Read     clrb  
         rts   
         nop   

Write    clrb  
         rts   
         nop   

GetStat  clrb  
         rts   
         nop   

SetStat  clrb  
         rts   
         nop   

Term     clrb  
         rts   

         emod
eom      equ   *
