********************************************************************
* Verify - Verify a module's CRC
*
* $Id$
*
* Ed.    Comments                                       Who YY/MM/DD
* ------------------------------------------------------------------
* 5      Original Tandy distribution version

         nam   Verify
         ttl   Verify a module's CRC

* Disassembled 98/09/15 00:03:43 by Disasm v1.6 (C) 1988 by RML

         ifp1
         use   defsfile
         endc

tylg     set   Prgrm+Objct   
atrv     set   ReEnt+rev
rev      set   $01
edition  set   5

         mod   eom,name,tylg,atrv,start,size

u0000    rmb   1
u0001    rmb   1
u0002    rmb   1
u0003    rmb   2
u0005    rmb   1
u0006    rmb   2
u0008    rmb   2
u000A    rmb   57
u0043    rmb   195
u0106    rmb   1000
size     equ   .

name     fcs   /Verify/
         fcb   edition

start    leas  >u0106,u
         sts   <u0006
         tfr   y,d
         subd  <u0006
         std   <u0008
         clr   <u0005
L0023    lda   ,x+
         cmpa  #C$SPAC
         beq   L0023
         anda  #$5F
         cmpa  #$55
         bne   L0031
         inc   <u0005
L0031    ldd   #$0009
         std   <u0003
         lbsr  L00F6
         bcs   L004D
         cmpy  #$0009
         bne   L0055
         ldd   ,x
         cmpd  #M$ID12
         bne   L0055
         bsr   L0059
         bra   L0031
L004D    cmpb  #E$EOF
         bne   L0052
         clrb  
L0052    os9   F$Exit   
L0055    ldb   #M$ID2
         bra   L0052
L0059    clrb  
         lda   #$08
L005C    eorb  ,x+
         deca  
         bne   L005C
         lda   <u0005
         bne   L0079
         eorb  ,x
         incb  
         beq   L0070
         leax  >L012F,pcr
         bra   L0074
L0070    leax  >L0115,pcr
L0074    lbsr  L010B
         bra   L007C
L0079    comb  
         stb   ,x
L007C    ldx   <u0006
         ldy   $02,x
         leay  -$03,y
         sty   <u0003
         ldd   #$FFFF
         std   <u0000
         stb   <u0002
         bsr   L00D6
         lda   <u0005
         bne   L00B6
         ldd   #$0003
         std   <u0003
         bsr   L00D6
         lda   <u0000
         cmpa  #$80
         bne   L00A8
         ldd   <u0001
         cmpd  #$0FE3
         beq   L00AE
L00A8    leax  >L015C,pcr
         bra   L00B2
L00AE    leax  >L014C,pcr
L00B2    bsr   L010B
         bra   L00CF
L00B6    com   <u0000
         com   <u0001
         com   <u0002
         lda   #$01
         leax  ,u
         ldy   #$0003
         os9   I$Write  
         bcs   L0052
         clra  
         os9   I$Read   
         bcs   L0052
L00CF    rts   
L00D0    bsr   L00F6
         lbcs  L0052
L00D6    ldy   <u000A
         beq   L00D0
         os9   F$CRC    
         lda   <u0005
         beq   L00EB
         lda   #$01
         os9   I$Write  
         lbcs  L0052
L00EB    ldd   <u0003
         subd  <u000A
         std   <u0003
         bne   L00D0
         std   <u000A
         rts   
L00F6    clra  
         ldx   <u0006
         ldy   <u0008
         cmpy  <u0003
         bls   L0104
         ldy   <u0003
L0104    os9   I$Read   
         sty   <u000A
         rts   
L010B    lda   #$02
         ldy   #$0050
         os9   I$WritLn 
         rts   
L0115    fcc   "Header parity is correct."
         fcb   C$CR
L012F    fcc   "Header parity is INCORRECT !"
         fcb   C$CR
L014C    fcc   "CRC is correct."
         fcb   C$CR
L015C    fcc   "CRC is INCORRECT !"
         fcb   C$CR

         emod
eom      equ   *
         end
