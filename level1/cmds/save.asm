********************************************************************
* Save - Save module from memory to disk
*
* $Id$
*
* Ed.    Comments                                       Who YY/MM/DD
* ------------------------------------------------------------------
* 3      Original Tandy distribution version

         nam   Save
         ttl   Save module from memory to disk

* Disassembled 98/09/14 23:45:22 by Disasm v1.6 (C) 1988 by RML

         ifp1
         use   defsfile
         endc

tylg     set   Prgrm+Objct   
atrv     set   ReEnt+rev
rev      set   $01
edition  set   3

         mod   eom,name,tylg,atrv,start,size

u0000    rmb   451
size     equ   .

name     fcs   /Save/
         fcb   edition

start    leay  -1,y
         pshs  y,x
         cmpx  $02,s
         bcc   L0060
         ldd   #$022F
         os9   I$Create 
         bcs   L0061
         sta   <u0000
         lda   ,x
         cmpa  #C$CR
         bne   L002C
         ldx   ,s
L002C    lda   ,x+
         cmpa  #C$SPAC
         beq   L002C
         cmpa  #C$COMA
         beq   L002C
         leax  -$01,x
         clra  
         os9   F$Link   
         bcs   L0061
         stx   ,s
         leax  ,u
         ldy   $02,x
         lda   <u0000
         os9   I$Write  
         pshs  b,cc
         os9   F$UnLink 
         ror   ,s+
         puls  b
         bcs   L0061
         ldx   ,s
         cmpx  $02,s
         bcs   L002C
         os9   I$Close  
         bcs   L0061
L0060    clrb  
L0061    os9   F$Exit   

         emod
eom      equ   *
         end
