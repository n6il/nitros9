********************************************************************
* OS9gen - Build and Link a Bootstrap File
*
* $Id$
*
* Ed.    Comments                                       Who YY/MM/DD
* ------------------------------------------------------------------
*  7     Original Tandy distribution version
*
* OS9gen is hardware dependent. On COCO the track to write is 34

         nam   OS9gen
         ttl   Build and Link a Bootstrap File

* Disassembled 02/07/06 22:40:22 by Disasm v1.6 (C) 1988 by RML

         ifp1
         use   defsfile
         endc
tylg     set   Prgrm+Objct   
atrv     set   ReEnt+rev
rev      set   $01
         mod   eom,name,tylg,atrv,start,size
u0000    rmb   2
u0002    rmb   1
DevFd    rmb   1
u0004    rmb   1
u0005    rmb   1
u0006    rmb   2
u0008    rmb   1
u0009    rmb   2
u000B    rmb   2
u000D    rmb   2
u000F    rmb   2
u0011    rmb   2
u0013    rmb   7
u001A    rmb   3
u001D    rmb   17
u002E    rmb   2
u0030    rmb   10
u003A    rmb   2
u003C    rmb   1
u003D    rmb   451
u0200    rmb   16
u0210    rmb   1
u0211    rmb   7
u0218    rmb   1000
size     equ   .
name     equ   *
         fcs   /OS9gen/
         fcb   $07 
L0014    fcb   C$LF
         fcc   "Use (CAUTION): OS9GEN </devname> [-s]"
         fcb   C$LF
         fcc   " ..reads (std input) pathnames until EOF,"
         fcb   C$LF
         fcc   "   merging paths into New OS9Boot file."
         fcb   C$LF
         fcc   " -s = single drive operation"
         fcb   C$LF
         fcb   C$CR
         fcc   "Can't find: "
L00B7    fcb   C$LF
         fcc   "Error writing kernel track"
         fcb   C$CR
L00D3    fcb   C$LF
         fcc   "Error - cannot gen to hard disk"
         fcb   C$CR
L00F4    fcb   C$CR
L00F5    fcb   $07 
L00F6    fcb   C$LF
         fcc   "Warning - file(s) present"
         fcb   C$LF
         fcc   "on track 34 - this track"
         fcb   C$LF
         fcc   "not rewritten."
         fcb   C$CR
L0139    fcb   C$LF
         fcc   "Error - OS9boot file fragmented"
         fcb   C$CR
L015A    fcc   "Ready SOURCE, hit C to continue: "
L017B    fcc   "Ready DESTINATION, hit C to continue: "
L01A1    fcc   "RENAME "
L01A8    fcc   "TempBoot "
         fcb   $FF 
L01B2    fcc   "OS9Boot"
         fcb   C$CR
         fcb   $FF 

start    equ   *
         clrb  
         stb   <u0005
         stb   <u003C
         stu   <u0000
         leas  >u0200,u
         pshs  u
         tfr   y,d
         subd  ,s++
         subd  #$0200
         clrb  
         std   <u0011
         lda   #$2F
         cmpa  ,x
         lbne  L0503
         os9   F$PrsNam 
         lbcs  L0503
         lda   #$2F
         cmpa  ,y
         lbeq  L0503
         pshs  b,a
L01EB    lda   ,y+
         cmpa  #$2D
         beq   L01F7
         cmpa  #$0D
         beq   L0209
         bra   L01EB
L01F7    ldd   ,y+
         eora  #$53
         anda  #$DF
         lbne  L0503
         cmpb  #$30
         lbcc  L0503
         inc   <u003C
L0209    puls  b,a
         leay  <u003D,u
L020E    sta   ,y+
         lda   ,x+
         decb  
         bpl   L020E
         sty   <u003A
         lda   #'@
         ldb   #$20
         std   ,y++
         lda   #$01
         lbsr  L0517
         leax  <u003D,u
         lda   #$03
         os9   I$Open   
         sta   <DevFd
         lbcs  L0503
         leax  <u001A,u
         ldb   #$00
         os9   I$GetStt 
         lbcs  L0514
         leax  <u001A,u
         lda   <u001D,u
         bpl   L024D
         clrb  
         leax  >L00D3,pcr
         lbra  L0507
L024D    ldx   <u003A
         leay  >L01A8,pcr
         lda   #$2F
L0255    sta   ,x+
         lda   ,y+
         bpl   L0255
         leay  >L01B2,pcr
L025F    lda   ,y+
         sta   ,x+
         bpl   L025F
         tfr   x,d
         leax  <u003D,u
         pshs  x
         subd  ,s++
         std   <u000D
         lda   #$02
         ldb   #$03
         os9   I$Create 
         sta   <u0002
         lbcs  L0514
         ldx   #$0000
         stx   <u0006
         ldu   #$3000
         ldb   #SS.Size
         os9   I$SetStt 
         lbcs  L0514
         ldu   <u0000
         lda   #$00
         lbsr  L0517
L0295    clra  
         leax  >u0200,u
         ldy   #$0400
         os9   I$ReadLn 
         bcs   L0322
         lda   ,x
         ldb   #$D3
         cmpa  #$0D
         beq   L0322
         lda   #$01
         os9   I$Open   
         bcs   L0310
         sta   <u0004
         tst   <u003C
         beq   L02E2
         lda   #$01
         lbsr  L0517
         lda   <DevFd
         ldx   #$0000
         ldu   #$0000
         os9   I$Seek   
         lbcs  L0514
         ldu   <u0000
         leax  >u0200,u
         ldy   #$0100
         os9   I$Read   
         lbcs  L0514
L02DD    lda   #$00
         lbsr  L0517
L02E2    lda   <u0004
         leax  >u0200,u
         ldy   <u0011
         os9   I$Read   
         bcs   L0305
         tfr   y,d
         addd  <u0006
         std   <u0006
         lda   #$01
         lbsr  L0517
         lda   <u0002
         os9   I$Write  
         bcc   L02DD
         lbra  L0514
L0305    cmpb  #$D3
         lbne  L0514
         os9   I$Close  
         bra   L0295
L0310    pshs  b
         leax  >u0200,u
         ldy   #$0100
         lda   #$02
         os9   I$WritLn 
L031F    lbra  L0514
L0322    cmpb  #$D3
         bne   L031F
         lda   #$01
         lbsr  L0517
         leax  <u001A,u
         ldb   #$00
         lda   <u0002
         os9   I$GetStt 
         lbcs  L0514
         lda   <u0002
         ldx   #$0000
         ldu   <u0006
         ldb   #SS.Size
         os9   I$SetStt 
         lbcs  L0514
         ldu   <u0000
         os9   I$Close  
         lbcs  L0503
         ldx   <u002E,u
         lda   <u0030,u
         clrb  
         tfr   d,u
         lda   <DevFd
         os9   I$Seek   
         ldu   <u0000
         lbcs  L0514
         leax  >u0200,u
         ldy   #$0100
         os9   I$Read   
         lbcs  L0514
         ldd   >u0218,u
         lbne  L0577
         lda   <DevFd
         ldx   #$0000
         ldu   #$0015
         os9   I$Seek   
         ldu   <u0000
         lbcs  L0514
         leax  u0008,u
         ldy   #$0005
         os9   I$Read   
         lbcs  L0514
         ldd   <u000B
         beq   L03C1
         ldx   <u003A
         leay  >L01B2,pcr
         lda   #$2F
L03A7    sta   ,x+
         lda   ,y+
         bpl   L03A7
         leax  <u003D,u
         os9   I$Delete 
         ldx   <u003A
         leay  >L01A8,pcr
         lda   #$2F
L03BB    sta   ,x+
         lda   ,y+
         bpl   L03BB
L03C1    tst   <u003C
         beq   L03E1
         lda   #$00
         lbsr  L0517
         clra  
         leax  >L01A1,pcr
         os9   F$Load   
         lbcs  L0514
         tfr   u,d
         ldu   <u0000
         std   u000F,u
         lda   #$01
         lbsr  L0517
L03E1    lda   #$01
         clrb  
         leax  >L01A1,pcr
         ldy   <u000D
         leau  <u003D,u
         os9   F$Fork   
         lbcs  L0514
         os9   F$Wait   
         lbcs  L0514
         tstb  
         lbne  L0514
         tst   <u003C
         beq   L0412
         ldu   <u0000
         ldd   u000F,u
         tfr   d,u
         os9   F$UnLink 
         lbcs  L0514
L0412    ldu   <u0000
         ldb   >u0210,u
         stb   <u0008
         ldd   >u0211,u
         std   <u0009
         ldd   <u0006
         std   <u000B
         ldx   #$0000
         ldu   #$0015
         lda   <DevFd
         os9   I$Seek   
         ldu   <u0000
         lbcs  L0514
         leax  u0008,u
         ldy   #$0005
         os9   I$Write  
         lbcs  L0514
         lbsr  L057E
         leax  >u0200,u
         ldy   #$0100
         os9   I$Read   
         lbcs  L0507
         leax  >u0200,u
         lda   <$4C,x
         bita  #$0F
         beq   L04AE
         lda   <DevFd
         pshs  u
         ldx   #$0002
         ldu   #$6400
         os9   I$Seek   
         puls  u
         leax  <u0013,u
         ldy   #$0007
         os9   I$Read   
         lbcs  L058D
         leax  <u0013,u
         ldd   ,x
         cmpa  #$4F
         lbne  L058D
         cmpb  #$53
         lbne  L058D
         lda   $04,x
         cmpa  #$12
         beq   L049C
         lda   <$4E,x
         bita  #$1C
         lbne  L058D
L049C    lda   <$4C,x
         ora   #$0F
         sta   <$4C,x
         lda   #$FF
         sta   <$4D,x
         sta   <$4E,x
         bra   L04CB
L04AE    ora   #$0F
         sta   <$4C,x
         tst   <$4D,x
         lbne  L058D
         com   <$4D,x
         lda   <$4E,x
         bita  #$FC
         lbne  L058D
         ora   #$FC
         sta   <$4E,x
L04CB    lbsr  L057E
         leax  >u0200,u
         ldy   #$0064
         os9   I$Write  
         bcs   L0507
         pshs  u
         ldx   #$0002
         ldu   #$6400
         os9   I$Seek   
         puls  u
         ldx   #$EF00    Address of kernel in RAM
         ldy   #$0F80    Amount to write
         os9   I$Write  
         bcs   L04FC
         os9   I$Close  
         bcs   L0503
         clrb  
         bra   L0514
L04FC    leax  >L00B7,pcr
         clrb  
         bra   L0507
L0503    leax  >L0014,pcr
L0507    pshs  b
         lda   #$02
         ldy   #$0100
         os9   I$WritLn 
         puls  b
L0514    os9   F$Exit   
L0517    tst   <u003C
         beq   L055F
         pshs  y,x
L051D    pshs  a
         tsta  
         bne   L052C
         leax  >L015A,pcr
         ldy   #$0021
         bra   L0534
L052C    leax  >L017B,pcr
         ldy   #$0026
L0534    bsr   L0560
         leax  ,-s
         ldy   #$0001
         lda   #$02
         os9   I$Read   
         lda   ,s+
         eora  #$43
         anda  #$DF
         beq   L0559
         leax  >L00F5,pcr
         ldy   #$0001
         bsr   L0560
         bsr   L0566
         puls  a
         bne   L051D
L0559    bsr   L0566
         puls  a
         puls  y,x
L055F    rts   
L0560    lda   #$01
         os9   I$WritLn 
         rts   
L0566    pshs  y,x,a
         lda   #$01
         leax  >L00F4,pcr
         ldy   #$0050
         os9   I$WritLn 
         puls  pc,y,x,a
L0577    leax  >L0139,pcr
         clrb  
         bra   L0507
L057E    pshs  u
         lda   <DevFd
         ldx   #$0000
         ldu   #$0100
         os9   I$Seek   
         puls  pc,u

L058D    leax  >L00F6,pcr
         clrb  
         lbra  L0507
         emod
eom      equ   *
