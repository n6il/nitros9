********************************************************************
* Cobble - Make a bootstrap file
*
* $Id$
*
* Ed.    Comments                                       Who YY/MM/DD
* ------------------------------------------------------------------
* 5      Original Tandy distribution version

         nam   Cobbler
         ttl   Make a bootstrap file

* Disassembled 02/07/06 23:26:00 by Disasm v1.6 (C) 1988 by RML

         ifp1
         use   defsfile
         endc
tylg     set   Prgrm+Objct   
atrv     set   ReEnt+rev
rev      set   $01
         mod   eom,name,tylg,atrv,start,size
u0000    rmb   1
DevFd    rmb   3
BTLSN    rmb   1
u0005    rmb   2
BtSiz    rmb   2
u0009    rmb   7
sttbuf   rmb   3
u0013    rmb   17
u0024    rmb   2
u0026    rmb   10
u0030    rmb   2
devnam   rmb   32
u0052    rmb   16
u0062    rmb   1
u0063    rmb   7
u006A    rmb   432
size     equ   .
name     equ   *
         fcs   /Cobbler/
         fcb   $05 
L0015    fcb   C$LF
         fcc   "Use: COBBLER </devname>"
         fcb   C$LF
         fcc   "     to create a new system disk"
         fcb   C$CR
L004F    fcb   C$LF
         fcc   "Error writing kernel track"
         fcb   C$CR
L006B    fcb   C$LF
         fcc   "Error - cannot gen to hard disk"
         fcb   C$CR
L008C    fcb   C$LF
         fcc   "Warning - file(s) present"
         fcb   C$LF
         fcc   "on track 34 - this track"
         fcb   C$LF
         fcc   "not rewritten."
         fcb   C$CR
L00CF    fcb   C$LF
         fcc   "Error - OS9boot file fragmented"
         fcb   C$CR
BfNam    fcc   "OS9Boot "
         fcb   $FF 

start    equ   *
         clrb  
         lda   #'/
         cmpa  ,x
         lbne  Usage
         os9   F$PrsNam 
         lbcs  Usage
         lda   #'/
         cmpa  ,y
         lbeq  Usage
         leay  <devnam,u
L0114    sta   ,y+
         lda   ,x+
         decb  
         bpl   L0114
         sty   <u0030
         lda   #'@
         ldb   #$20
         std   ,y++
         leax  <devnam,u
         lda   #UPDAT.
         os9   I$Open   
         sta   <DevFd
         lbcs  Usage
         ldx   <u0030
         leay  >BfNam,pcr
         lda   #'/
L013A    sta   ,x+
         lda   ,y+
         bpl   L013A
         lda   <DevFd
         leax  <sttbuf,u
         ldb   #$00
         os9   I$GetStt 
         lbcs  Exit
         leax  <sttbuf,u
         lda   <u0013,u
         bpl   L015E
         leax  >L006B,pcr
         clrb  
         lbra  wrerr
L015E    lda   <DevFd
         pshs  u
         ldx   #$0000
         ldu   #$0015   probably DD.BT
         os9   I$Seek   
         puls  u
         lbcs  Exit
         leax  BTLSN,u
         ldy   #$0005
         os9   I$Read    Read bootstrap sector + size = 5 bytes
         lbcs  Exit
         ldd   <BtSiz
         beq   L0193
         leax  <devnam,u
         os9   I$Delete 
         clra  
         clrb  
         sta   <BTLSN
         std   <u0005
         std   <BtSiz
         lbsr  UpLSN0
L0193    lda   #WRITE.
         ldb   #UPDAT.
         leax  <devnam,u
         os9   I$Create 
         sta   <u0000
         lbcs  Exit
         ldd   >$0068
         subd  >$0066
         tfr   d,y
         std   <BtSiz
         ldx   >$0066
         lda   <u0000
         os9   I$Write  
         lbcs  Exit
         leax  <sttbuf,u
         ldb   #SS.OPT
         os9   I$GetStt 
         lbcs  Exit
         lda   <u0000
         os9   I$Close  
         lbcs  Usage
         pshs  u
         ldx   <u0024,u
         lda   <u0026,u
         clrb  
         tfr   d,u
         lda   <DevFd
         os9   I$Seek   
         puls  u
         lbcs  Exit
         leax  <u0052,u
         ldy   #$0100
         os9   I$Read   
         lbcs  Exit
         ldd   <u006A,u
         lbne  Fragd
         ldb   <u0062,u
         stb   <BTLSN
         ldd   <u0063,u
         std   <u0005
         lbsr  UpLSN0
         lbsr  SkLSN1
         leax  <u0052,u
         ldy   #$0100
         os9   I$Read   
         lbcs  wrerr
         leax  <u0052,u
         lda   <$4C,x
         bita  #$0F
         beq   L0273
         lda   <DevFd
         pshs  u
         ldx   #$0002
         ldu   #$6400
         os9   I$Seek      Jump to LSN 612
         puls  u
         leax  u0009,u
         ldy   #$0007
         os9   I$Read   
         lbcs  L02ED
         leax  u0009,u
         ldd   ,x
         cmpa  #$4F
         lbne  L02ED
         cmpb  #$53
         lbne  L02ED
         lda   $04,x
         cmpa  #$12
         beq   L025C
         lda   <$4E,x
         bita  #$1C
         lbne  L02ED
L025C    lda   <$4C,x
         ora   #$0F
         sta   <$4C,x
         lda   #$FF
         sta   <$4D,x
         lda   <$4E,x
         ora   #$FC
         sta   <$4E,x
         bra   L028C
L0273    ora   #$0F
         sta   <$4C,x
         tst   <$4D,x
         bne   L02ED
         com   <$4D,x
         lda   <$4E,x
         bita  #$FC
         bne   L02ED
         ora   #$FC
         sta   <$4E,x
L028C    bsr   SkLSN1
         leax  <u0052,u
         ldy   #$0064
         os9   I$Write  
         bcs   wrerr
         pshs  u
         ldx   #$0002
         ldu   #$6400
         os9   I$Seek   Jump to LSN 612
         puls  u
         ldx   #$EF00    Address of kernel in RAM
         ldy   #$0F80    Amount to write
         os9   I$Write  
         bcs   ETrack
         os9   I$Close  
         bcs   Usage
         clrb  
         bra   Exit

SkLSN1   pshs  u
         lda   <DevFd
         ldx   #$0000
         ldu   #$0100
         os9   I$Seek   Seek to allocation map at LSN 1
         puls  pc,u

Usage    leax  >L0015,pcr
wrerr    pshs  b
         lda   #$02
         ldy   #$0100
         os9   I$WritLn 
         comb  
         puls  b
Exit     os9   F$Exit   

Fragd    leax  >L00CF,pcr
         clrb  
         bra   wrerr

ETrack   leax  >L004F,pcr
         clrb  
         bra   wrerr

L02ED    leax  >L008C,pcr
         clrb  
         bra   wrerr

UpLSN0   pshs  u
         ldx   #$0000
         ldu   #$0015   probably DD.BT
         lda   <DevFd
         os9   I$Seek   
         puls  u
         bcs   Exit
         leax  BTLSN,u
         ldy   #$0005
         os9   I$Write  
         bcs   Exit
         rts   
         emod
eom      equ   *
