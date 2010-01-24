         nam   Makdir
         ttl   program module       

* Disassembled 2010/01/24 10:24:09 by Disasm v1.5 (C) 1988 by RML

         ifp1
         use   /dd/defs/defsfile
         endc
tylg     set   Prgrm+Objct   
atrv     set   ReEnt+rev
rev      set   $01
         mod   eom,name,tylg,atrv,start,size
u0000    rmb   400
size     equ   .
name     equ   *
         fcs   /Makdir/
start    equ   *
         ldb   #$3F
         os9   I$MakDir 
         bcs   L001B
         clrb  
L001B    os9   F$Exit   
         emod
eom      equ   *
         end
