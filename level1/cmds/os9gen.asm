********************************************************************
* OS9gen - Build and Link a Bootstrap File
*
* $Id$
*
* Ed.    Comments                                       Who YY/MM/DD
* ------------------------------------------------------------------
*  2     Original Microware distribution version

         nam   OS9gen
         ttl   Build and Link a Bootstrap File

* Disassembled 02/04/03 23:17:45 by Disasm v1.6 (C) 1988 by RML

         ifp1
         use   defsfile
         endc
tylg     set   Prgrm+Objct   
atrv     set   ReEnt+rev
rev      set   $01
         mod   eom,name,tylg,atrv,start,size
u0000    rmb   2
u0002    rmb   1
u0003    rmb   1
u0004    rmb   1
u0005    rmb   1
u0006    rmb   2
u0008    rmb   1
u0009    rmb   2
u000B    rmb   2
u000D    rmb   2
u000F    rmb   20
u0023    rmb   2
u0025    rmb   10
u002F    rmb   2
u0031    rmb   32
u0051    rmb   16
u0061    rmb   1
u0062    rmb   7
u0069    rmb   4522
size     equ   .
name     equ   *
         fcs   /OS9gen/
         fcb   $07 
L0014    fcb   C$LF 
         fcc   "Use (caution): os9gen </devname>"
         fcb   C$LF 
         fcc   " ..reads (std input) pathnames until eof,"
         fcb   C$LF 
         fcc   "   merging paths into new OS9Boot file."
         fcb   C$CR 
         fcc   "Can't find: "
L0094    fcb   C$LF
         fcc   "Error writing kernel track"
         fcb   C$CR 
L00B0    fcb   C$LF 
         fcc   "Warning - Kernel track has"
         fcb   C$LF 
         fcc   "not been allocated properly."
         fcb   C$LF 
         fcc   "Track not written."
         fcb   C$CR 
L00FC    fcb   C$LF
         fcc   "Error - OS9boot file fragmented"
         fcb   C$LF 
         fcc   " This disk will not bootstrap."
         fcb   C$CR 
L013C    fcc   "RENAME "
L0143    fcc   "TempBoot "
         fcb   $FF
L014D    fcc   "OS9Boot"
         fcb   C$CR
         fcb   $FF
start    equ   *
         clrb  
         stb   <u0005
         stu   <u0000
         lda   #$2F
         cmpa  ,x
         lbne  L035B
         os9   F$PrsNam 
         lbcs  L035B
         lda   #$2F
         cmpa  ,y
         lbeq  L035B
         leay  <u0031,u
L0175    sta   ,y+
         lda   ,x+
         decb  
         bpl   L0175
         sty   <u002F
         lda   #$40
         ldb   #$20
         std   ,y++
         leax  <u0031,u
         lda   #$03
         os9   I$Open   
         sta   <u0003
         lbcs  L035B
         ldx   <u002F
         leay  >L0143,pcr
         lda   #$2F
L019B    sta   ,x+
         lda   ,y+
         bpl   L019B
         leay  >L014D,pcr
L01A5    lda   ,y+
         sta   ,x+
         bpl   L01A5
         tfr   x,d
         leax  <u0031,u
         pshs  x
         subd  ,s++
         std   <u000D
         lda   #$02
         ldb   #$03
         os9   I$Create 
         sta   <u0002
         lbcs  L036C
         ldx   #$0000
         stx   <u0006
         ldu   #$4000
         ldb   #$02
         os9   I$SetStt 
         lbcs  L036C
         ldu   <u0000
L01D6    clra  
         leax  <u0051,u
         ldy   #$1000
         os9   I$ReadLn 
         bcs   L022E
         lda   ,x
         ldb   #$D3
         cmpa  #C$CR
         beq   L022E
         lda   #$01
         os9   I$Open   
         bcs   L021D
         sta   <u0004
L01F4    lda   <u0004
         leax  <u0051,u
         ldy   #$1000
         os9   I$Read   
         bcs   L0212
         tfr   y,d
         addd  <u0006
         std   <u0006
         lda   <u0002
         os9   I$Write  
         bcc   L01F4
         lbra  L036C
L0212    cmpb  #$D3
         lbne  L036C
         os9   I$Close  
         bra   L01D6
L021D    pshs  b
         leax  <u0051,u
         ldy   #$0100
         lda   #$02
         os9   I$WritLn 
L022B    lbra  L036C
L022E    cmpb  #$D3
         bne   L022B
         leax  u000F,u
         ldb   #$00
         lda   <u0002
         os9   I$GetStt 
         lbcs  L036C
         lda   <u0002
         ldx   #$0000
         ldu   <u0006
         ldb   #$02
         os9   I$SetStt 
         lbcs  L036C
         ldu   <u0000
         os9   I$Close  
         lbcs  L035B
         ldx   <u0023,u
         lda   <u0025,u
         clrb  
         tfr   d,u
         lda   <u0003
         os9   I$Seek   
         ldu   <u0000
         lbcs  L036C
         leax  <u0051,u
         ldy   #$0100
         os9   I$Read   
         lbcs  L036C
         ldd   <u0069,u
         lbne  L036F
         lda   <u0003
         ldx   #$0000
         ldu   #$0015
         os9   I$Seek   
         ldu   <u0000
         lbcs  L036C
         leax  u0008,u
         ldy   #$0005
         os9   I$Read   
         lbcs  L036C
         ldd   <u000B
         beq   L02C5
         ldx   <u002F
         leay  >L014D,pcr
         lda   #$2F
L02AB    sta   ,x+
         lda   ,y+
         bpl   L02AB
         leax  <u0031,u
         os9   I$Delete 
         ldx   <u002F
         leay  >L0143,pcr
         lda   #$2F
L02BF    sta   ,x+
         lda   ,y+
         bpl   L02BF
L02C5    lda   #$01
         clrb  
         leax  >L013C,pcr
         ldy   <u000D
         leau  <u0031,u
         os9   F$Fork   
         lbcs  L036C
         os9   F$Wait   
         lbcs  L036C
         tstb  
         lbne  L036C
         ldu   <u0000
         ldb   <u0061,u
         stb   <u0008
         ldd   <u0062,u
         std   <u0009
         ldd   <u0006
         std   <u000B
         ldx   #$0000
         ldu   #$0015
         lda   <u0003
         os9   I$Seek   
         ldu   <u0000
         lbcs  L036C
         leax  u0008,u
         ldy   #$0005
         os9   I$Write  
         lbcs  L036C
         lbsr  L0376
         leax  <u0051,u
         ldy   #$0100
         os9   I$Read   
         bcs   L035F
         lda   ,x
         anda  #$3F
         eora  #$3F
         lbne  L0385
         lda   $01,x
         eora  #$FF
         lbne  L0385
         lda   $02,x
         anda  #$90
         eora  #$90
         lbne  L0385
         ldx   #$F000
         ldy   #$0F00
         lda   <u0003
         os9   I$Write  
         bcs   L0354
         os9   I$Close  
         bcs   L036C
         clrb  
         bra   L036C
L0354    leax  >L0094,pcr
         clrb  
         bra   L035F
L035B    leax  >L0014,pcr
L035F    pshs  b
         lda   #$02
         ldy   #$0100
         os9   I$WritLn 
         puls  b
L036C    os9   F$Exit   
L036F    leax  >L00FC,pcr
         clrb  
         bra   L035F
L0376    pshs  u
         lda   <u0003
         ldx   #$0000
         ldu   #$0100
         os9   I$Seek   
         puls  pc,u
L0385    leax  >L00B0,pcr
         clrb  
         bra   L035F
         emod
eom      equ   *
