********************************************************************
* Binex - Motorola S-Record utility
*
* $Id$
*
* Edt/Rev  YYYY/MM/DD  Modified by
* Comment
* ------------------------------------------------------------------
*  67      ????/??/??
* From Tandy OS-9 Level Two VR 02.00.01.
*
*  68      2003/01/14  Boisy G. Pitre
* Restarted edition; removed Motorola copyright.


         nam   Binex
         ttl   Motorola S-Record utility

* Disassembled 98/09/15 00:08:52 by Disasm v1.6 (C) 1988 by RML

         ifp1
         use   defsfile
         endc

tylg     set   Prgrm+Objct   
atrv     set   ReEnt+rev
rev      set   $00
edition  set   1

         mod   eom,name,tylg,atrv,start,size

u0000    rmb   1
u0001    rmb   1
u0002    rmb   2
u0004    rmb   1
u0005    rmb   1
u0006    rmb   1
u0007    rmb   2
u0009    rmb   1
u000A    rmb   2
u000C    rmb   1
u000D    rmb   31
u002C    rmb   1
u002D    rmb   1
u002E    rmb   1
u002F    rmb   2
u0031    rmb   2
u0033    rmb   2
u0035    rmb   656
size     equ   .

name     fcs   /Binex/
         fcb   edition

*         fcc   "Copyright 1982 Motorola, Inc."
*         fcb   $01 

start    stx   <u0002
         lda   #READ.
         os9   I$Open   
         bcc   L003C
L0039    os9   F$Exit   
L003C    sta   <u0000
         stx   <u0002
         lda   #WRITE.
         ldb   #SHARE.+PEXEC.+PWRIT.+PREAD.+EXEC.+UPDAT.
         os9   I$Create 
         bcs   L0039
         sta   <u0001
         stx   <u0002
         ldd   #$0000
         sta   <u0006
         std   <u000A
         std   <u002F
         ldx   #$5330
         stx   <u002D
         ldx   #$3030
         stx   <u0031
         stx   <u0033
L0062    leax  >AskStart,pcr
         lda   #$01
         ldy   #AskStrtL
         os9   I$Write  
         leax  <u0031,u
         lda   #$00
         ldy   #$0005
         os9   I$ReadLn 
         leay  -$01,y
         cmpy  #$0000
         beq   L0062
         cmpy  #$0004
         bhi   L0062
         beq   L00A7
         tfr   y,d
         pshs  b
         decb  
         leax  <u0031,u
         leay  $04,x
L0095    lda   b,x
         sta   ,-y
         decb  
         bpl   L0095
         ldb   #$04
         subb  ,s+
         lda   #$30
L00A2    sta   ,-y
         decb  
         bgt   L00A2
L00A7    lbsr  L0178
         leax  >AskName,pcr
         lda   #$01
         ldy   #AskNameL
         os9   I$Write  
         leax  u000C,u
         lda   #$00
         ldy   #$0015
         os9   I$ReadLn 
         leay  -$01,y
         cmpy  #$0000
         bne   L0120
L00CA    lda   <u0000
         leax  u000C,u
         ldy   #$0020
         os9   I$Read   
         lbcs  L0160
         cmpy  #$0000
         lbeq  L0160
         lda   <u0006
         bne   L0120
         inc   <u0006
         lda   #$31
         sta   <u002E
         ldx   <u0004
         stx   <u000A
         ldx   u000C,u
         cmpx  #$87CD
         beq   L0120
         leax  >Alert,pcr
         pshs  y
         ldy   #AlertL
         lda   #$01
         os9   I$Write  
         leax  <u0035,u
         ldy   #$0002
         lda   #$00
         os9   I$ReadLn 
         puls  y
         lda   <u0035,u
         anda  #$DF
         cmpa  #$59
         beq   L0120
L011C    clrb  
         os9   F$Exit   
L0120    sty   <u0007
         tfr   y,d
         addb  #$03
         stb   <u0009
         leax  u0009,u
         clra  
         ldb   ,x
L012E    adda  ,x+
         decb  
         bne   L012E
         coma  
         sta   ,x
         leax  u0009,u
         leay  <u002F,u
         ldb   ,x
         incb  
L013E    bsr   L01B6
         decb  
         bne   L013E
         ldb   #$0D
         stb   ,y
         leax  <u002D,u
         ldy   #$0073
         lda   <u0001
         os9   I$WritLn 
         lbcs  L0039
         ldd   <u000A
         addd  <u0007
         std   <u000A
         lbra  L00CA
L0160    cmpb  #$D3
         lbne  L0039
         lda   #$39
         cmpa  <u002E
         beq   L011C
         sta   <u002E
         ldx   <u0004
         stx   <u000A
         ldy   #$0000
         bra   L0120
L0178    bsr   L017C
         sta   <u0004
L017C    lda   ,x+
         bsr   L0197
         lsla  
         lsla  
         lsla  
         lsla  
         anda  #$F0
         pshs  a
         lda   ,x+
         bsr   L0197
         adda  ,s+
         sta   <u0005
         adda  <u002C
         sta   <u002C
         lda   <u0005
         rts   
L0197    suba  #$30
         bmi   L01A6
         cmpa  #$09
         ble   L01A5
         suba  #$07
         cmpa  #$0F
         bhi   L01A6
L01A5    rts   
L01A6    leax  >L01D7,pcr
         lda   #$02
         ldy   #$00FF
         os9   I$WritLn 
         lbra  L011C
L01B6    pshs  b,a
         lda   ,x+
         tfr   a,b
         lsra  
         lsra  
         lsra  
         lsra  
         bsr   L01CC
         sta   ,y+
         tfr   b,a
         bsr   L01CC
         sta   ,y+
         puls  pc,b,a
L01CC    anda  #$0F
         adda  #$30
         cmpa  #$39
         bls   L01D6
         adda  #$07
L01D6    rts   
L01D7    fcc   "** NON-HEX CHARACTER ENCOUNTERED"
         fcb   C$BELL,C$CR
AskName  fcc   "Enter name for header record: "
AskNameL equ   *-AskName
AskStart fcc   "Enter starting address for file: $"
AskStrtL equ   *-AskStart
Alert    fcb   C$BELL,C$CR,C$LF
         fcc   "** Not a binary load module file.  Proceed anyway (Y/N)? "
AlertL   equ   *-Alert

         emod
eom      equ   *
         end
