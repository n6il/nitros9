********************************************************************
* DMem - Dump memory from system
*
* $Id$
*
* Edt/Rev  YYYY/MM/DD  Modified by
* Comment
* ------------------------------------------------------------------
*   2      ????/??/??  Kevin Darling
* Started.

         nam   DMem
         ttl   Dump memory from system

* Disassembled 98/09/14 19:24:59 by Disasm v1.6 (C) 1988 by RML

         ifp1
         use   defsfile
         endc

tylg     set   Prgrm+Objct   
atrv     set   ReEnt+rev
rev      set   $00
edition  set   2

         mod   eom,name,tylg,atrv,start,size

u0000    rmb   1
u0001    rmb   1
u0002    rmb   1
u0003    rmb   2
u0005    rmb   3
u0008    rmb   64
u0048    rmb   1
u0049    rmb   447
u0208    rmb   4296
size     equ   .

name     fcs   /DMem/
         fcb   edition

L0012    clr   <u0000
         clr   <u0001
L0016    lda   ,x+
         cmpa  #C$SPAC
         beq   L0046
         cmpa  #C$CR
         beq   L0046
         suba  #$30
         cmpa  #$0A
         bcs   L002A
         anda  #$07
         adda  #$09
L002A    lsla
         lsla
         lsla
         lsla
         sta   <u0002
         ldd   <u0000
         rol   <u0002
         rolb
         rola
         rol   <u0002
         rolb
         rola
         rol   <u0002
         rolb
         rola
         rol   <u0002
         rolb
         rola
         std   <u0000
         bra   L0016
L0046    leax  -1,x
         ldd   <u0000
         rts

start    lbsr  L0128
         lbeq  L0119
         cmpa  #'-
         bne   L006D
         leax  1,x
         bsr   L0012
         tfr   b,a
         pshs  x
         leax  >u0008,u
         os9   F$GPrDsc 
         lbcs  L00BC
         puls  x
         bra   L0073
L006D    bsr   L0012
         clr   <u0048
         stb   <u0049
L0073    lbsr  L0128
         lbeq  L0119
         lbsr  L0012
         std   <u0003
         lbsr  L0128
         beq   L0092
         lbsr  L0012
         cmpd  #$1000
         bls   L0095
         ldd   #$1000
         bra   L0095
L0092    ldd   #$0100
L0095    std   <u0005
         leax  >u0048,u
         tfr   x,d
         ldy   <u0005
         ldx   <u0003
         pshs  u
         leau  >u0208,u
         os9   F$CpyMem 
         puls  u
         bcs   L00BC
         ldy   <u0005
         leax  >u0208,u
         lda   #$01
         os9   I$Write  
L00BB    clrb  
L00BC    os9   F$Exit   

HelpTxt  fcc   "Use: DMem <block> <offset> [<length>] ! dump"
         fcb   C$LF
         fcc   " or: DMem -<id>   <offset> [<length>] ! dump"
         fcb   C$CR
HelpTxtL equ   *-HelpTxt

L0119    leax  >HelpTxt,pcr
L011D    ldy   #HelpTxtL
         lda   #$02
         os9   I$WritLn 
         bra   L00BB
L0128    lda   ,x+
         cmpa  #C$SPAC
         beq   L0128
         leax  -1,x
         cmpa  #C$CR
         rts   

         emod
eom      equ   *
         end
