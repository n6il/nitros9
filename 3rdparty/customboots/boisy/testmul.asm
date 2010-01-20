         ifp1
         use   defsfile
         endc

tylg     set   Prgrm+Objct   
atrv     set   ReEnt+rev
rev      set   $00
edition  set   1

         mod   eom,name,tylg,atrv,start,size

stack    rmb   200
size     equ   .

name     fcs   /testmul/
         fcb   edition

start
         orcc  #IntMasks
         clra
         clrb
top
         mul
         mul
         mul
         mul
         mul
         mul
         mul
         mul
         mul
         mul
         mul
         mul
         mul
         mul
         mul
         mul
         mul
         mul
         mul
         mul
         bra   top

         emod
eom      equ   *
         end
