********************************************************************
* Boot - OS-9 Level One V2 Boot module
*
* $Id$
*
* Ed.    Comments                                       Who YY/MM/DD
* ------------------------------------------------------------------
* 1      Tandy/Microware original version

         nam   Boot
         ttl   OS-9 Level One V2.00 Boot module

         ifp1
         use   defsfile
         endc

tylg     set   Systm+Objct
atrv     set   ReEnt+rev
rev      set   $01
edition  set   1

         mod   eom,name,tylg,atrv,start,size

u0000    rmb   2
u0002    rmb   2
u0004    rmb   1
size     equ   .

name     fcs   /Boot/
         fcb   edition


* obtain bootfile size at known offset
start    pshs  u,y,x,a,b
         leax  eom,pcr                 point to end of module
         ldd   ,x                      get size of bootfile
         std   ,s                      place bootfile size in A/B on stack
* allocate memory from system
         os9   F$SRqMem
         bcs   Uhoh
* copy bootfile from low RAM to allocated area
         stu   2,s                     place address in X loc. on stack
         ldx   #$2600+$1200            X points to bootfile in ROM
         ldd   ,s                      get bootfile size from A/B on stack
Loop     ldy   ,x++
         sty   ,u++
         subd  #2
         bgt   Loop

* Upon exit, we return to the kernel with:
*    X = address of bootfile
*    D = size of bootfile
Uhoh     puls  u,y,x,a,b,pc

         emod
eom      equ   *

* Size of bootfile (maximum is put here)
         fdb   $2E00
         end
