********************************************************************
* Tsmon - Timesharing monitor
*
* $Id$
*
* Ed.    Comments                                       Who YY/MM/DD
* ------------------------------------------------------------------
*  7     Original Tandy/Microware version

         nam   Tsmon
         ttl   Timesharing monitor

* Disassembled 02/07/06 23:17:42 by Disasm v1.6 (C) 1988 by RML

         ifp1
         use   defsfile
         endc

tylg     set   Prgrm+Objct   
atrv     set   ReEnt+rev
rev      set   $01

         mod   eom,name,tylg,atrv,start,size

u0000    rmb   1
u0001    rmb   2
u0003    rmb   452
size     equ   .

name     fcs   /Tsmon/
         fcb   $07 

L0013    fcc   "LOGIN"
L0018    fcb   C$CR

L0019    rti

start    stx   <u0001
         std   <u0003
L001E    cmpd  #$0002
         bcs   L0047
         lda   ,x
         cmpa  #C$CR
         beq   L0047
         clra  
         os9   I$Close  
         inca  
         os9   I$Close  
         inca  
         os9   I$Close  
         lda   #UPDAT.
         os9   I$Open   
         bcs   L0082
         os9   I$Dup    
         bcs   L0082
         os9   I$Dup    
         bcs   L0082
L0047    leax  <L0019,pcr
         os9   F$Icpt   
L004D    clra  
         leax  ,-s
         ldy   #$0001
         os9   I$ReadLn 
         leas  $01,s
         bcc   L0061
         cmpb  #E$HangUp
         bne   L004D
         bra   L007C
L0061    lda   #$01
         clrb  
         leax  <L0013,pcr
         leau  <L0018,pcr
         ldy   #$0000
         os9   F$Fork   
         bcs   L004D
         sta   <u0000
L0075    os9   F$Wait   
         cmpa  <u0000
         bne   L0075
L007C    ldx   <u0001
         ldd   <u0003
         bra   L001E
L0082    os9   F$Exit   

         emod
eom      equ   *
         end
