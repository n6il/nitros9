********************************************************************
* Cobbler - Make a bootstrap file
*
* $Id$
*
* Ed.    Comments                                       Who YY/MM/DD
* ------------------------------------------------------------------
*   5    From Tandy OS-9 Level One VR 02.00.00
*   6    Allocation bitmap bug fixed, as per Rainbow    BGP 02/07/20
*        Magazine, January 1987, Page 203

         nam   Cobbler
         ttl   Make a bootstrap file

* Disassembled 02/07/06 23:26:00 by Disasm v1.6 (C) 1988 by RML

         ifp1
         use   defsfile
         use   rbfdefs
         endc

tylg     set   Prgrm+Objct   
atrv     set   ReEnt+rev
rev      set   $01
edition  set   6

os9start equ  $EF00
os9size  equ  $0F80

         mod   eom,name,tylg,atrv,start,size

BFPath   rmb   1
DevFd    rmb   3
BTLSN    rmb   1
u0005    rmb   2
BtSiz    rmb   2
u0009    rmb   7
sttbuf   rmb   32
u0030    rmb   2
devnam   rmb   32
bootfd   rmb   16
u0062    rmb   1
u0063    rmb   7
u006A    rmb   432
size     equ   .

name     fcs   /Cobbler/
         fcb   edition

L0015    fcb   C$LF
         fcc   "Use: COBBLER </devname>"
         fcb   C$LF
         fcc   "     to create a new system disk"
         fcb   C$CR
L004F    fcb   C$LF
         fcc   "Error writing kernel track"
         fcb   C$CR
NoHard   fcb   C$LF
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

start    clrb  
         lda   #PDELIM
         cmpa  ,x
         lbne  Usage
         os9   F$PrsNam 
         lbcs  Usage
         lda   #PDELIM
         cmpa  ,y
         lbeq  Usage
         leay  <devnam,u
L0114    sta   ,y+
         lda   ,x+
         decb  
         bpl   L0114
         sty   <u0030
         lda   #PENTIR
         ldb   #C$SPAC
         std   ,y++
         leax  <devnam,u
         lda   #UPDAT.
         os9   I$Open   
         sta   <DevFd
         lbcs  Usage
         ldx   <u0030
         leay  >BfNam,pcr
         lda   #PDELIM
L013A    sta   ,x+
         lda   ,y+
         bpl   L013A
         lda   <DevFd
         leax  <sttbuf,u
         ldb   #SS.Opt
         os9   I$GetStt 
         lbcs  Exit
         leax  <sttbuf,u
         lda   <sttbuf+(PD.TYP-PD.OPT),u	get PD.TYP
         bpl   L015E		if not hard drive, branch
         leax  >NoHard,pcr
         clrb  
         lbra  wrerr
L015E    lda   <DevFd
         pshs  u
         ldx   #$0000
         ldu   #DD.BT		probably DD.BT
         os9   I$Seek   
         puls  u
         lbcs  Exit
         leax  BTLSN,u
         ldy   #DD.DAT-DD.BT
         os9   I$Read		Read bootstrap sector + size = 5 bytes
         lbcs  Exit
         ldd   <BtSiz
         beq   L0193
         leax  <devnam,u
         os9   I$Delete 	delete existing OS9Boot file
         clra  
         clrb  
         sta   <BTLSN
         std   <u0005
         std   <BtSiz
         lbsr  UpLSN0
L0193    lda   #WRITE.
         ldb   #UPDAT.
         leax  <devnam,u
         os9   I$Create 	create OS9Boot file
         sta   <BFPath
         lbcs  Exit
         ldd   >D.BTHI		get bootfile size
         subd  >D.BTLO
         tfr   d,y		in D, tfr to Y
         std   <BtSiz		save it
         ldx   >D.BTLO		get pointer to boot in mem
         lda   <BFPath
         os9   I$Write  	write out boot to file
         lbcs  Exit
         leax  <sttbuf,u
         ldb   #SS.OPT
         os9   I$GetStt 
         lbcs  Exit
         lda   <BFPath
         os9   I$Close 
         lbcs  Usage
         pshs  u
         ldx   <sttbuf+(PD.FD-PD.OPT),u
         lda   <sttbuf+(PD.FD+2-PD.OPT),u
         clrb  
         tfr   d,u
         lda   <DevFd
         os9   I$Seek   	seek to file descriptor of bootfile
         puls  u
         lbcs  Exit
         leax  <bootfd,u
         ldy   #256		read FD sector
         os9   I$Read   
         lbcs  Exit
         ldd   <bootfd+FD.SEG+FDSL.S+3,u
         lbne  Fragd		branch if fragmented
         ldb   <bootfd+FD.SEG,u	get LSN of first (only) segment
         stb   <BTLSN		save off
         ldd   <bootfd+FD.SEG+1,u
         std   <u0005
         lbsr  UpLSN0
         lbsr  SkLSN1
         leax  <bootfd,u
         ldy   #256
         os9   I$Read   	read bitmap sector
         lbcs  wrerr
         leax  <bootfd,u
         lda   <(34*18)/8,x	get byte in bitmap corresponding to kernel track
         bita  #$0F		bits 3-0 set? 
         beq   L0273		branch if not
         lda   <DevFd
         pshs  u
         ldx   #$0002
         ldu   #$6400
         os9   I$Seek      Jump to LSN 612
         puls  u
         leax  u0009,u
         ldy   #$0007
         os9   I$Read		read first 7 bytes of boot track
         lbcs  L02ED
         leax  u0009,u
         ldd   #$4F53		D = "OS"
         cmpd  ,x		same as first two bytes of boot track?
         lbne  L02ED		branch if not
         lda   4,x
         leax  <bootfd,u
         nop
         cmpa  #$12		is it a nop?
         beq   L025C		branch if so
         lda   <$4E,x
         bita  #$1C
         lbne  L02ED
L025C    lda   <(34*18)/8,x
         ora   #$0F
         sta   <(34*18)/8,x
         lda   #$FF
         sta   <(34*18)/8+1,x
         lda   <(34*18)/8+2,x
         ora   #$FC
         sta   <(34*18)/8+2,x
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
         leax  <bootfd,u
         ldy   #$0064
         os9   I$Write  
         bcs   wrerr
         pshs  u
         ldx   #$0002
         ldu   #$6400
         os9   I$Seek   Jump to LSN 612
         puls  u
         ldx   #os9start    Address of kernel in RAM
         ldy   #os9size    Amount to write
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
         ldu   #DD.BT
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
         end
