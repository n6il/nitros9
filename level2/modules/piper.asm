********************************************************************
* Piper - Pipe device driver
*
* $Id$
*
* Ed.    Comments                                       Who YY/MM/DD
* ------------------------------------------------------------------
* 2      Original OS-9 L2 Tandy distribution

         nam   Piper
         ttl   Pipe null driver

* Disassembled 98/08/23 20:57:40 by Disasm v1.6 (C) 1988 by RML

         ifp1
         use   defsfile
         endc

tylg     set   Drivr+Objct   
atrv     set   ReEnt+rev
rev      set   $01
edition  set   2

         mod   eom,name,tylg,atrv,start,size

u0000    rmb   6
size     equ   .
         fcb   $03 

name     fcs   /Piper/
         fcb   edition

start    equ   *
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
         end
