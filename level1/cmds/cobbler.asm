********************************************************************
* Cobbler - Make a bootstrap file
*
* $Id$
*
* Ed.    Comments                                       Who YY/MM/DD
* ------------------------------------------------------------------
*  5     Original Microware distribution version

         nam   Cobbler
         ttl   Make a bootstrap file

* Disassembled 02/04/03 23:11:02 by Disasm v1.6 (C) 1988 by RML

         ifp1
         use   defsfile
         endc
tylg     set   Prgrm+Objct   
atrv     set   ReEnt+rev
rev      set   $01
         mod   eom,name,tylg,atrv,start,size
u0000    rmb   1
u0001    rmb   3
u0004    rmb   1
u0005    rmb   2
u0007    rmb   2
u0009    rmb   20
u001D    rmb   2
u001F    rmb   10
u0029    rmb   2
u002B    rmb   32
u004B    rmb   16
u005B    rmb   1
u005C    rmb   7
u0063    rmb   682
size     equ   .
name     equ   *
         fcs   /Cobbler/
         fcb   $05 
L0015    fcb   C$LF 
         fcc   "Use: Cobbler </devname>"
         fcb   C$LF 
         fcc   "    to create a new system disk"
         fcb   C$CR 
L004E    fcb   C$LF 
         fcc   "Error writing kernel track"
         fcb   C$CR 
L006A    fcb   C$LF 
         fcc   "Warning - Kernel track has"
         fcb   C$LF 
         fcc   "not been allocated properly."
         fcb   C$LF 
         fcc   "Track not written."
         fcb   C$CR 
L00B6    fcb   C$LF 
         fcc   "Error - OS9boot file fragmented"
         fcb   C$LF 
         fcc   " This disk will not bootstrap."
         fcb   C$CR 
L00F6    fcc   "OS9Boot "
         fcb   $FF 
start    equ   *
         clrb  
         lda   #$2F
         cmpa  ,x
         lbne  L0237
         os9   F$PrsNam 
         lbcs  L0237
         lda   #$2F
         cmpa  ,y
         lbeq  L0237
         leay  <u002B,u
L011A    sta   ,y+
         lda   ,x+
         decb  
         bpl   L011A
         sty   <u0029
         lda   #$40
         ldb   #$20
         std   ,y++
         leax  <u002B,u
         lda   #$03
         os9   I$Open   
         sta   <u0001
         lbcs  L0237
         ldx   <u0029
         leay  >L00F6,pcr
         lda   #$2F
L0140    sta   ,x+
         lda   ,y+
         bpl   L0140
         lda   <u0001
         pshs  u
         ldx   #$0000
         ldu   #$0015   probably DD.BT
         os9   I$Seek   
         puls  u
         lbcs  Exit
         leax  u0004,u
         ldy   #$0005
         os9   I$Read    Read bootstrap sector + size = 5 bytes
         lbcs  Exit
         ldd   <u0007
         beq   L017B
         leax  <u002B,u
         os9   I$Delete 
         clra  
         clrb  
         sta   <u0004
         std   <u0005
         std   <u0007
         lbsr  L0261
L017B    lda   #$02
         ldb   #$03
         leax  <u002B,u
         os9   I$Create 
         sta   <u0000
         lbcs  Exit
         ldd   >$0068
         subd  >$0066
         tfr   d,y
         std   <u0007
         ldx   >$0066
         lda   <u0000
         os9   I$Write  
         lbcs  Exit
         leax  u0009,u
         ldb   #$00
         os9   I$GetStt 
         lbcs  Exit
         lda   <u0000
         os9   I$Close  
         lbcs  L0237
         pshs  u
         ldx   <u001D,u
         lda   <u001F,u
         clrb  
         tfr   d,u
         lda   <u0001
         os9   I$Seek   
         puls  u
         lbcs  Exit
         leax  <u004B,u
         ldy   #$0100
         os9   I$Read   
         lbcs  Exit
         ldd   <u0063,u
         lbne  L024C
         ldb   <u005B,u
         stb   <u0004
         ldd   <u005C,u
         std   <u0005
         lbsr  L0261
         lbsr  L0228
         leax  <u004B,u
         ldy   #$0100
         os9   I$Read   
         bcs   wrerr
         lda   ,x
         anda  #$3F
         eora  #$3F
         bne   L025A
         lda   $01,x
         eora  #$FF
         bne   L025A
         lda   $02,x
         anda  #$90
         eora  #$90
         bne   L025A
         ldx   #$F000
         ldy   #$0F00
         lda   <u0001
         os9   I$Write  
         bcs   L0253
         os9   I$Close  
         bcs   Exit
         clrb  
         bra   Exit
L0228    pshs  u
         lda   <u0001
         ldx   #$0000
         ldu   #$0100
         os9   I$Seek   
         puls  pc,u
L0237    leax  >L0015,pcr
wrerr    pshs  b
         lda   #$02
         ldy   #$0100
         os9   I$WritLn 
         comb  
         puls  b
Exit     os9   F$Exit   
L024C    leax  >L00B6,pcr
         clrb  
         bra   wrerr
L0253    leax  >L004E,pcr
         clrb  
         bra   wrerr
L025A    leax  >L006A,pcr
         clrb  
         bra   wrerr
L0261    pshs  u
         ldx   #$0000
         ldu   #$0015
         lda   <u0001
         os9   I$Seek   
         puls  u
         bcs   Exit
         leax  u0004,u
         ldy   #$0005
         os9   I$Write  
         bcs   Exit
         rts   
         emod
eom      equ   *
