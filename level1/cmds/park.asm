********************************************************************
* Park - Park a hard drive
*
* $Id$
*
* Ed.    Comments                                       Who YY/MM/DD
* ------------------------------------------------------------------
* 1      Original Tandy/Microware version

         nam   Park
         ttl   Park a hard drive

* Disassembled 02/07/06 21:41:10 by Disasm v1.6 (C) 1988 by RML

         ifp1
         use   defsfile
         endc

tylg     set   Prgrm+Objct   
atrv     set   ReEnt+rev
rev      set   $01

         mod   eom,name,tylg,atrv,start,size

u0000    rmb   1
u0001    rmb   2
u0003    rmb   20
u0017    rmb   502
size     equ   .

name     fcs   /Park/
         fcb   $01 

HelpMsg  fcb   C$LF
         fcc   "Use:  Park </devname> .... "
         fcb   C$LF
         fcc   "      To park hard disk heads"
         fcb   C$LF
         fcc   "      on inner track of drive"
         fcb   C$LF,C$CR
HelpMsgL equ   *-HelpMsg

Parked   fcc   " has been parked. "
         fcb   C$CR
ParkedLen equ  *-Parked

NoOpen   fcc   " cannot be opened."
         fcb   C$CR
NoOpenL  equ   *-NoOpen

NoPark   fcc   " has not been parked."
         fcb   C$CR
NoParkL  equ   *-NoPark

start    bsr   L0117
         cmpa  #C$CR
         beq   L00E0
L00AE    cmpa  #PDELIM
         bne   L00E0
         bsr   L0122
         lda   #READ.
         os9   I$Open   
         bcs   L00FA
         ldb   #SS.SQD
         os9   I$SetStt 
         bcs   L0106
         lda   <u0000
         os9   I$Close  
         bsr   L00EF
         leax  >Parked,pcr
         ldy   #ParkedLen
L00D1    os9   I$WritLn 
         ldx   <u0001
         lda   ,x
         cmpa  #C$CR
         bne   L00AE
L00DC    clrb  
         os9   F$Exit   
L00E0    lda   #2
         leax  >HelpMsg,pcr
         ldy   #HelpMsgL
         os9   I$WritLn 
         bra   L00DC
L00EF    leax  u0003,u
         lda   #2
         ldy   <u0017
         os9   I$Write  
         rts   
L00FA    bsr   L00EF
         leax  >NoOpen,pcr
         ldy   #NoOpenL
         bra   L00D1
L0106    lda   <u0000
         os9   I$Close  
         bsr   L00EF
         leax  >NoPark,pcr
         ldy   #NoParkL
         bra   L00D1

* Skip spaces
L0117    lda   ,x
         cmpa  #C$SPAC
         bne   L0121
         leax  1,x
         bra   L0117
L0121    rts   

L0122    clrb  
         leay  u0003,u
         pshs  y
L0127    lda   ,x+
         cmpa  #C$SPAC
         bls   L0132
         sta   ,y+
         incb  
         bra   L0127
L0132    lda   #PENTIR
         sta   ,y+
         leax  -1,x
         bsr   L0117
         stx   <u0001
         clra  
         std   <u0017,u
         puls  pc,x

         emod
eom      equ   *
         end

