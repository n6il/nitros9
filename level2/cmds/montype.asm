********************************************************************
* MonType - Change monitor type
*
* $Id$
*
* Ed.    Comments                                       Who YY/MM/DD
* ------------------------------------------------------------------
* 1      Original Tandy/Microware version

         nam   MonType
         ttl   Change monitor type

* Disassembled 98/09/10 23:52:51 by Disasm v1.6 (C) 1988 by RML

         ifp1
         use   defsfile
         endc

tylg     set   Prgrm+Objct   
atrv     set   ReEnt+rev
rev      set   $01
edition  set   1

         mod   eom,name,tylg,atrv,start,size

u0000    rmb   300
size     equ   .

name     fcs   /MonType/
         fcb   edition

CurOn    fdb   $1B21
HelpMsg  fcb   C$CR
         fcb   C$LF
         fcc   "MonType - Set up the monitor type"
         fcb   C$CR
         fcb   C$LF
         fcc   "Syntax:  MonType [opt]"
         fcb   C$CR
         fcb   C$LF
         fcc   "Options: r = rgb monitor"
         fcb   C$CR
         fcb   C$LF
         fcc   "         c = composite monitor (t.v.)"
         fcb   C$CR
         fcb   C$LF
         fcc   "         m = monochrome monitor"
         fcb   C$CR
         fcb   C$LF
HelpMsgL equ   *-HelpMsg

start    bsr   L00F3
         cmpa  #C$CR
         beq   L00FA
         anda  #$5F
         cmpa  #'R
         bne   L00C7
         ldx   #$0001
         bra   L00D7
L00C7    cmpa  #'C
         bne   L00D0
         ldx   #$0000
         bra   L00D7
L00D0    cmpa  #'M
         bne   L00FA
         ldx   #$0002
L00D7    lda   #1
         ldb   #SS.Montr
         os9   I$SetStt 
         bcs   L00F0
         leax  >CurOn,pcr
         lda   #1
         ldy   #2
         os9   I$Write  
         bcs   L00F0
L00EF    clrb  
L00F0    os9   F$Exit   
L00F3    lda   ,x+
         cmpa  #C$SPAC
         beq   L00F3
         rts   
L00FA    lda   #1
         leax  >HelpMsg,pcr
         ldy   #HelpMsgL
         os9   I$Write  
         bra   L00EF

         emod
eom      equ   *
         end
