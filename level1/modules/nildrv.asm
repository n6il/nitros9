********************************************************************
* NilDrv - Null device driver
*
* $Id$
*
* Ed.    Comments                                       Who YY/MM/DD
* ------------------------------------------------------------------
*   3    From Tandy OS-9 Level One VR 02.00.00

         nam   NilDrv
         ttl   Null device driver

* Disassembled 98/08/23 17:30:33 by Disasm v1.6 (C) 1988 by RML

         ifp1
         use   defsfile
         endc

tylg     set   Drivr+Objct   
atrv     set   ReEnt+rev
rev      set   $01
edition  set   3

         mod   eom,name,tylg,atrv,start,size

u0000    rmb   6
size     equ   .

         fcb   UPDAT.

name     fcs   /NilDrv/
         fcb   edition

start
Init     clrb  
         rts   
         nop   

Read     bra   Read2
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

Read2    comb  
         ldb   #E$EOF
         rts   

         emod
eom      equ   *
