********************************************************************
* Tsmon - Timesharing monitor
*
* $Id$
*
* Ed.    Comments                                       Who YY/MM/DD
* ------------------------------------------------------------------
*  6     Original Microware distribution version

         nam   Tsmon
         ttl   Timesharing monitor

* Disassembled 02/04/03 22:36:47 by Disasm v1.6 (C) 1988 by RML

         ifp1
         use   os9defs
         endc
tylg     set   Prgrm+Objct   
atrv     set   ReEnt+rev
rev      set   $01
         mod   eom,name,tylg,atrv,start,size
u0000    rmb   1
u0001    rmb   2
u0003    rmb   452
size     equ   .
name     equ   *
         fcs   /Tsmon/
         fcb   $06 
L0013    fcb   $4C L
         fcb   $4F O
         fcb   $47 G
         fcb   $49 I
         fcb   $4E N
L0018    fcb   $0D 
L0019    fcb   $3B ;
start    equ   *
         stx   <u0001
         std   <u0003
L001E    cmpd  #$0002
         bcs   L0047
         lda   ,x
         cmpa  #$0D
         beq   L0047
         clra  
         os9   I$Close  
         inca  
         os9   I$Close  
         inca  
         os9   I$Close  
         lda   #$03
         os9   I$Open   
         bcs   L007C
         os9   I$Dup    
         bcs   L007C
         os9   I$Dup    
         bcs   L007C
L0047    leax  <L0019,pcr
         os9   F$Icpt   
L004D    clra  
         leax  ,-s
         ldy   #$0001
         os9   I$ReadLn 
         leas  $01,s
         bcs   L004D
         lda   #$01
         clrb  
         leax  <L0013,pcr
         leau  <L0018,pcr
         ldy   #$0000
         os9   F$Fork   
         bcs   L004D
         sta   <u0000
L006F    os9   F$Wait   
         cmpa  <u0000
         bne   L006F
         ldx   <u0001
         ldd   <u0003
         bra   L001E
L007C    os9   F$Exit   
         emod
eom      equ   *
