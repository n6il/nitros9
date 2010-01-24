         nam   Ansicode
         ttl   program module       

* Disassembled 2010/01/24 10:52:29 by Disasm v1.5 (C) 1988 by RML

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
         fcs   /Ansicode/
L0015    fcb   $1B 
         fcb   $5B [
start    equ   *
         pshs  x
         leax  >L0015,pcr
         ldy   #$0002
         lda   #$01
         os9   I$Write  
         puls  x
         ldy   #$00C8
         os9   I$WritLn 
         clrb  
         os9   F$Exit   
         emod
eom      equ   *
         end
