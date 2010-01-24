         nam   ViewBBS
         ttl   program module       

* Disassembled 2010/01/24 10:53:54 by Disasm v1.5 (C) 1988 by RML

         ifp1
         use   /dd/defs/defsfile
         endc
tylg     set   Prgrm+Objct   
atrv     set   ReEnt+rev
rev      set   $01
         mod   eom,name,tylg,atrv,start,size
u0000    rmb   401
size     equ   .
name     equ   *
         fcs   /ViewBBS/
L0014    fcb   $2F /
         fcb   $77 w
         fcb   $62 b
         fcb   $0D 
L0018    fcb   $1B 
         fcb   $21 !
start    equ   *
         leax  >L0014,pcr
         lda   #$03
         os9   I$Open   
         lbcs  L004E
         sta   ,u
         leax  >L0018,pcr
         ldy   #$0002
         lda   ,u
         os9   I$Write  
         clra  
         os9   I$Close  
         inca  
         os9   I$Close  
         inca  
         os9   I$Close  
         lda   ,u
         os9   I$Dup    
         os9   I$Dup    
         os9   I$Dup    
         clrb  
L004E    os9   F$Exit   
         emod
eom      equ   *
         end
