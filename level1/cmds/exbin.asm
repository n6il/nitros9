********************************************************************
* Exbin - Motorola S-Record utility
*
* $Id$
*
* Ed.    Comments                                       Who YY/MM/DD
* ------------------------------------------------------------------
*  67    From Tandy OS-9 Level One VR 02.00.00
*  68    Made proper edition number                     BGP 02/07/14

         nam   Exbin
         ttl   Motorola S-Record utility

* Disassembled 98/09/15 00:16:49 by Disasm v1.6 (C) 1988 by RML

         ifp1
         use   defsfile
         endc

tylg     set   Prgrm+Objct   
atrv     set   ReEnt+rev
rev      set   $01
edition  set   68

         mod   eom,name,tylg,atrv,start,size

u0000    rmb   1
u0001    rmb   1
u0002    rmb   2
u0004    rmb   1
u0005    rmb   1
u0006    rmb   2
u0008    rmb   1
u0009    rmb   2
u000B    rmb   1
u000C    rmb   1
u000D    rmb   1
u000E    rmb   1
u000F    rmb   1
u0010    rmb   2
u0012    rmb   2
u0014    rmb   2
u0016    rmb   656
size     equ   .

name     fcs   /Exbin/
         fcb   edition

         fcc   "Copyright 1982 Motorola, Inc."
         fcb   $01 

start    stx   <u0002
         lda   #$01
         os9   I$Open   
         bcc   L003C
L0039    os9   F$Exit   
L003C    sta   <u0000
         stx   <u0002
         lda   #$02
         ldb   #$7F
         os9   I$Create 
         bcs   L0039
         sta   <u0001
         stx   <u0002
         ldd   #$0000
         std   <u0009
         std   <u000B
         sta   <u000F
         ldx   #$4E61
         stx   <u0010
         ldx   #$6D65
         stx   <u0012
         ldx   #$3D20
         stx   <u0014
L0065    lda   <u0000
         leax  <u0016,u
         ldy   #$0100
         os9   I$ReadLn 
         lbcs  L0114
         leax  <u0016,u
         tfr   x,y
         tfr   x,d
         addd  #$0100
         std   <u0006
L0081    lda   ,x+
         cmpa  #$53
         beq   L008D
         cmpx  <u0006
         bne   L0081
         bra   L0065
L008D    lda   ,x+
         suba  #$30
         sta   <u000E
         beq   L009E
         cmpa  #$09
         bne   L009B
         bra   L0065
L009B    deca  
         bne   L0065
L009E    bsr   L011F
         sta   <u0008
         suba  #$03
         sta   <u000C
         sta   <u000D
         bsr   L011B
         tst   <u000E
         beq   L00CD
         pshs  x
         ldx   <u0009
         lda   <u000F
         beq   L00C0
         cmpx  <u0004
         beq   L00C6
         leax  >L018D,pcr
         bra   L00DE
L00C0    ldx   <u0004
         lda   #$01
         sta   <u000F
L00C6    ldb   <u000C
         abx   
         stx   <u0009
         puls  x
L00CD    bsr   L011F
         sta   ,y+
         dec   <u000D
         bpl   L00CD
         lda   <u0008
         inca  
         beq   L00EB
         leax  >L0171,pcr
L00DE    lda   #$02
         ldy   #$00FF
         os9   I$WritLn 
L00E7    clrb  
         lbra  L0039
L00EB    lda   <u000E
         bne   L0102
         lda   #$0D
         sta   ,-y
         lda   #$01
         ldy   #$00FF
         leax  <u0010,u
         os9   I$WritLn 
         lbra  L0065
L0102    lda   <u0001
         ldy   <u000B
         leax  <u0016,u
         os9   I$Write  
         lbcc  L0065
         lbra  L0039
L0114    cmpb  #$D3
         beq   L00E7
         lbra  L0039
L011B    bsr   L011F
         sta   <u0004
L011F    lda   ,x+
         bsr   L013A
         lsla  
         lsla  
         lsla  
         lsla  
         anda  #$F0
         pshs  a
         lda   ,x+
         bsr   L013A
         adda  ,s+
         sta   <u0005
         adda  <u0008
         sta   <u0008
         lda   <u0005
         rts   
L013A    suba  #$30
         bmi   L0149
         cmpa  #$09
         ble   L0148
         suba  #$07
         cmpa  #$0F
         bhi   L0149
L0148    rts   
L0149    leax  >L014F,pcr
         bra   L00DE
L014F    fcc   "** NON-HEX CHARACTER ENCOUNTERED"
         fcb   $07,C$CR
L0171    fcc   "** CHECKSUM ERROR DETECTED"
         fcb   $07,C$CR
L018D    fcc   "** NON-CONTIGUOUS ADDRESS SPACE DETECTED"
         fcb   $07,C$CR

         emod
eom      equ   *
         end
