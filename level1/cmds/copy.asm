********************************************************************
* progname - program module
*
* $Id$
*
* Ed.    Comments                                       Who YY/MM/DD
* ------------------------------------------------------------------
*  -     Original Tandy distribution version
*
*

         nam   Copy
         ttl   program module       

* Disassembled 02/07/06 13:08:43 by Disasm v1.6 (C) 1988 by RML

         ifp1
         use   defsfile
         endc

tylg     set   Prgrm+Objct   
atrv     set   ReEnt+rev
rev      set   $01

         mod   eom,name,tylg,atrv,start,size

u0000    rmb   1
u0001    rmb   1
u0002    rmb   1
u0003    rmb   1
u0004    rmb   2
u0006    rmb   2
u0008    rmb   2
u000A    rmb   2
u000C    rmb   2
u000E    rmb   1
u000F    rmb   1
u0010    rmb   16
u0020    rmb   480
u0200    rmb   256
u0300    rmb   4096
size     equ   .
name     equ   *
         fcs   /Copy/
         fcb   $09 

L0012    fcc   "Ready SOURCE, hit C to continue: "
L0033    fcc   "Ready DESTINATION, hit C to continue: "
L0059    fcb   C$CR
L005A    fcc   "Use: Copy <Path1> <Path2> [-s]"
         fcb   C$LF
         fcc   "  -s = single drive copy (Path2 must be complete pathlist)"
         fcb   C$CR
L00B4    fcb   C$BELL
         fcc   "Error - write verification failed."
         fcb   C$CR

start    leas  >u0200,u
         pshs  u
         leau  <u0020,u
L00E1    clr   ,-u
         cmpu  ,s
         bhi   L00E1
         tfr   y,d
         subd  ,s++
         subd  #$0300
         clrb  
         std   <u0004
         pshs  x
L00F4    lda   ,x+
         cmpa  #'-
         beq   L0100
         cmpa  #$0D
         bne   L00F4
         bra   L0113
L0100    ldd   ,x+
         eora  #'S
         anda  #$DF
         bne   L0110
         cmpb  #$30
         bcc   L0110
         inc   <u000E
         bra   L00F4
L0110    lbra  L0281
L0113    puls  x
         lda   #READ.
         os9   I$Open   
         bcc   L0125
         cmpb  #$D7
         lbeq  L0281
         lbra  L0288
L0125    sta   <u0000
         pshs  x
         leax  <u0010,u
         ldy   #$0010
         ldb   #SS.FD
         os9   I$GetStt 
         puls  x
         bcs   L0147
         tst   <u000E
         beq   L0147
         lda   ,x
         ldb   #$D7
         cmpa  #'/
         lbne  L0288
L0147    pshs  x
         lda   <u0000
         leax  <u0020,u
         ldb   #SS.Opt
         os9   I$GetStt 
         lbcs  L0288
         lda   ,x
         sta   <u0002
         ldb   #$0F
         cmpa  #$01
         bne   L0177
         pshs  u,x
         lda   <u0000
         ldb   #SS.Size
         os9   I$GetStt 
         lbcs  L0288
         stx   <u0006
         stu   <u0008
         puls  u,x
         ldb   <$13,x
L0177    stb   <u000F
         ldx   ,s
         lda   #$01
         lbsr  L0295
         lda   #UPDAT.
         ldb   <u000F
         os9   I$Create 
         puls  x
         bcc   L0198
         inc   <u0003
         lda   #WRITE.
         ldb   <u000F
         os9   I$Create 
         lbcs  L0288
L0198    sta   <u0001
         leax  <u0020,u
         ldb   #SS.Opt
         os9   I$GetStt 
         lbcs  L0288
         ldb   ,x
         cmpb  #$01
         beq   L01B0
         inc   <u0003
         bra   L01E8
L01B0    tst   <u0003
         bne   L01C1
         ldb   #$01
         stb   $08,x
         ldb   #SS.Opt
         os9   I$SetStt 
         lbcs  L0288
L01C1    lda   <u0002
         cmpa  #$01
         bne   L01E8
         pshs  u
         lda   <u0001
         ldb   #$02
         ldx   <u0006
         ldu   <u0008
         os9   I$SetStt 
         lbcs  L0288
         puls  u
         lda   <u0001
         leax  <u0010,u
         ldy   #$0010
         ldb   #SS.FD
         os9   I$SetStt 
L01E8    leax  >u0300,u
         clra  
         lbsr  L0295
         lda   <u0000
         ldy   <u0004
         os9   I$Read   
         bcs   L0265
         lda   #$01
         lbsr  L0295
         lda   <u0001
         os9   I$Write  
         lbcs  L0288
         tst   <u0003
         bne   L0258
         pshs  u,y
         ldx   <u000A
         ldu   <u000C
         lda   <u0001
         os9   I$Seek   
         bcs   L0288
         ldu   $02,s
         leau  >u0300,u
         ldd   ,s
         addd  <u000C
         std   <u000C
         ldd   ,s
         bcc   L022D
         leax  $01,x
         stx   <u000A
L022D    ldy   #$0100
         std   ,s
         tsta  
         bne   L0238
         tfr   d,y
L0238    ldx   $02,s
         leax  >$0200,x
         lda   <u0001
         os9   I$Read   
         bcs   L0288
L0245    lda   ,u+
         cmpa  ,x+
         bne   L0276
         leay  -$01,y
         bne   L0245
         ldd   ,s
         subd  #$0100
         bhi   L022D
         puls  u,y
L0258    lda   <u0000
         ldb   #SS.EOF
         os9   I$GetStt 
         bcc   L01E8
         cmpb  #E$EOF
         beq   L026D
L0265    cmpb  #E$EOF
         bne   L0288
         lda   #$01
         bsr   L0295
L026D    lda   <u0001
         os9   I$Close  
         bcc   L0287
         bra   L0288
L0276    leax  >L00B4,pcr
         bsr   L028B
         comb  
         ldb   #$01
         bra   L0288
L0281    leax  >L005A,pcr
         bsr   L028B
L0287    clrb  
L0288    os9   F$Exit   
L028B    ldy   #256
L028F    lda   #$01
         os9   I$WritLn 
         rts   
L0295    tst   <u000E
         beq   L02D2
         pshs  y,x
L029B    pshs  a
         tsta  
         bne   L02AA
         leax  >L0012,pcr
         ldy   #$0021
         bra   L02B2
L02AA    leax  >L0033,pcr
         ldy   #$0026
L02B2    bsr   L028F
         leax  ,-s
         ldy   #$0001
         clra  
         os9   I$Read   
         lda   ,s+
         eora  #'C
         anda  #$DF
         beq   L02CC
         bsr   L02D3
         puls  a
         bne   L029B
L02CC    bsr   L02D3
         puls  a
         puls  y,x
L02D2    rts   
L02D3    pshs  y,x,a
         lda   #$01
         leax  >L0059,pcr
         ldy   #$0050
         os9   I$WritLn 
         puls  pc,y,x,a

         emod
eom      equ   *
         end
