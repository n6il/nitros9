********************************************************************
* Rename - Rename a file
*
* $Id$
*
* Ed.    Comments                                       Who YY/MM/DD
* ------------------------------------------------------------------
*   6    From Tandy OS-9 Level One VR 02.00.00

         nam   Rename
         ttl   Rename a file

* Disassembled 98/09/11 01:35:46 by Disasm v1.6 (C) 1988 by RML

         ifp1
         use   defsfile
         endc

tylg     set   Prgrm+Objct   
atrv     set   ReEnt+rev
rev      set   $01
edition  set   6

         mod   eom,name,tylg,atrv,start,size

u0000    rmb   1
u0001    rmb   1
u0002    rmb   2
u0004    rmb   1
u0005    rmb   2
u0007    rmb   1
u0008    rmb   24
u0020    rmb   26
u003A    rmb   2
u003C    rmb   405
size     equ   .

name     fcs   /Rename/
         fcb   edition

start    cmpd  #$0004
         lbcs  L00A8
         stx   <u0000
         lda   #WRITE.
         os9   I$Open   
         bcc   L0032
         cmpb  #E$FNA
         bne   L00A5
         ldx   <u0000
         lda   #DIR.+WRITE.
         os9   I$Open   
         bcs   L00A5
L0032    stx   <u0005
         ldb   #SS.Opt
         leax  <u0020,u
         os9   I$GetStt 
         bcs   L00A5
         os9   I$Close  
         bcs   L00A5
         ldb   <u0020
         cmpb  #$01
         bne   L00A8
         bsr   L00AE
         bcs   L00A5
         ldx   <u0002
         lda   #C$CR
         sta   -1,x
         ldx   <u0000
         lda   #READ.+WRITE.
         os9   I$ChgDir 
         bcs   L00A5
         ldx   <u0005
         ldb   <u0008
         decb  
         lda   b,x
         ora   #$80
         sta   b,x
         incb  
         cmpb  <u0004
         bne   L0075
         leay  ,x
         ldx   <u0002
         os9   F$CmpNam 
         bcc   L0082
L0075    ldx   <u0005
         lda   #READ.
         os9   I$Open   
         bcc   L00A8
         cmpb  #E$PNNF
         bne   L00A8
L0082    leax  <L00AC,pcr
         lda   #DIR.!UPDAT.
         os9   I$Open   
         bcs   L00A5
         ldx   <u003A
         ldu   <u003C
         os9   I$Seek   
         bcs   L00A5
         ldx   <u0005
         ldy   <u0007
         os9   I$Write  
         bcs   L00A5
         os9   I$Close  
         bcs   L00A5
         clrb  
L00A5    os9   F$Exit   
L00A8    ldb   #E$BPNam
         bra   L00A5
L00AC    fcc   "."
         fcb   C$CR
L00AE    ldx   <u0000
         bsr   L00F6
         ldu   <u0000
         lda   ,u
         cmpa  #PDELIM
         beq   L00C7
         lda   ,y
         cmpa  #PDELIM
         beq   L00C7
         leau  <L00AC,pcr
         stu   <u0000
         bra   L00CD
L00C7    leax  ,y
         bsr   L00F6
         bcs   L00F2
L00CD    stx   <u0002
         stb   <u0004
         leax  ,y
         bsr   L00F6
         bcc   L00CD
         ldb   <u0004
         beq   L00F2
         ldx   <u0005
         os9   F$PrsNam 
         bcs   L00F2
         lda   ,y
         cmpa  #PDELIM
         beq   L00F2
         cmpb  #$1E
         bcc   L00F2
         stx   <u0005
         clra  
         std   <u0007
         rts   
L00F2    comb  
         ldb   #E$BPNam
         rts   
L00F6    os9   F$PrsNam 
         bcc   L0119
         clrb  
         leau  ,x
L00FE    lda   ,u+
         bpl   L0107
         incb  
         cmpa  #$AE
         bne   L010C
L0107    incb  
         cmpa  #C$PERD
         beq   L00FE
L010C    decb  
         beq   L0118
         leay  -u0001,u
         cmpb  #$03
         bcc   L0118
         clrb  
         bra   L0119
L0118    coma  
L0119    rts   

         emod
eom      equ   *
         end

