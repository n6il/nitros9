*******************************************************************
* Tsmon - Timesharing monitor
*
* $Id$
*
* Ed.    Comments                                       Who YY/MM/DD
* ------------------------------------------------------------------
*  8     Original Tandy/Microware version

         nam   Tsmon
         ttl   Timesharing monitor

* Disassembled 02/07/13 23:44:55 by Disasm v1.6 (C) 1988 by RML

         ifp1
         use   defsfile
         endc

tylg     set   Prgrm+Objct   
atrv     set   ReEnt+rev
rev      set   $01

         mod   eom,name,tylg,atrv,start,size

u0000    rmb   1
u0001    rmb   2
u0003    rmb   2
u0005    rmb   451
size     equ   .

name     fcs   /Tsmon/
         fcb   $08 

L0013    fcc   "LOGIN"
L0018    fcb   C$CR

L0019    rti

start    stx   <u0001
         std   <u0003
         leax  <L0019,pcr
         os9   F$Icpt   
L0024    ldx   <u0001
         ldd   <u0003
         cmpd  #$0002
         bcs   L0052
         lda   ,x
         cmpa  #C$CR
         beq   L0052
         clra  
         os9   I$Close  
         lda   #UPDAT.
         os9   I$Open   
         bcs   L007B
         inca  
         os9   I$Close  
         inca  
         os9   I$Close  
         clra  
         os9   I$Dup    
         bcs   L007B
         os9   I$Dup    
         bcs   L007B
L0052    clra  
         leax  u0005,u
         ldy   #$0001
         os9   I$ReadLn 
         bcs   L0024
         lda   #$01
         clrb  
         leax  <L0013,pcr
         leau  <L0018,pcr
         ldy   #$0000
         os9   F$Fork   
         bcs   L0024
         sta   <u0000
L0072    os9   F$Wait   
         cmpa  <u0000
         bne   L0072
         bra   L0024
L007B    os9   F$Exit   

         emod
eom      equ   *
         end
