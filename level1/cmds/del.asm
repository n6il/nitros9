********************************************************************
* Del - File deletion utility
*
* $Id$
*
* Ed.    Comments                                       Who YY/MM/DD
* ------------------------------------------------------------------
* 3      Original Tandy distribution version            BGP

         nam   Del
         ttl   File deletion utility

* Disassembled 98/09/10 22:43:13 by Disasm v1.6 (C) 1988 by RML

         ifp1
         use   defsfile
         endc

tylg     set   Prgrm+Objct   
atrv     set   ReEnt+rev
rev      set   $01
edition  set   5

         mod   eom,name,tylg,atrv,start,size

InPath   rmb   1
         rmb   450
size     equ   .

name     fcs   /Del/
         fcb   edition

HelpMsg  fcb   C$LF
         fcc   "Use: Del [-x] <path> {<path>} [-x]"
         fcb   C$CR

start    lda   ,x
         cmpa  #C$CR
         beq   L0093
         lda   #1
         sta   <InPath
         bsr   L0054
         leax  -1,x
L0043    lda   <InPath
         os9   I$DeletX 
         bcs   L0051
         lda   ,x
         cmpa  #C$CR
         bne   L0043
         clrb  
L0051    os9   F$Exit   
L0054    lda   ,x+
         cmpa  #C$SPAC
         beq   L0054
         cmpa  #C$COMA
         beq   L0054
         cmpa  #'-
         bne   L0067
         bsr   L0086
         leax  1,x
         rts   
L0067    pshs  x
L0069    lda   ,x+
         cmpa  #C$SPAC
         beq   L0069
         cmpa  #C$COMA
         beq   L0069
         cmpa  #'-
         beq   L007E
         cmpa  #C$CR
         bne   L0069
L007B    puls  x
         rts   
L007E    bsr   L0086
         lda   #C$CR
         sta   -2,x
         bra   L007B
L0086    lda   ,x+
         eora  #$58
         anda  #$DF
         bne   L0093
         lda   #$04
         sta   <InPath
         rts   
L0093    leax  >HelpMsg,pcr
         ldy   #80
         clra  
         os9   I$WritLn 
         clrb  
         bra   L0051

         emod
eom      equ   *
         end

