*******************************************************************
* SMap - Show System Memory Map
*
* $Id$
*
* Edt/Rev  YYYY/MM/DD  Modified by
* Comment
* ------------------------------------------------------------------
*   1      ????/??/??  
* Original version.

         nam   SMap
         ttl   Show System Memory Map

* Disassembled 02/05/12 22:05:11 by Disasm v1.6 (C) 1988 by RML

         ifp1
         use   defsfile
         endc

tylg     set   Prgrm+Objct   
atrv     set   ReEnt+rev
rev      set   $00
edition  set   1

         mod   eom,name,tylg,atrv,start,size

u0000    rmb   1
decbuff  rmb   3		decimal buffer (100, 10, 1s place)
free     rmb   1		number of free 256 byte pages in system memory
u0005    rmb   1
u0006    rmb   1
wrbuf    rmb   1
u0008    rmb   6
u000E    rmb   1
memmap   rmb   256
         rmb   200
size     equ   .

name	 fcs   /SMap/
         fcb   edition

H1       fcc   "    0 1 2 3 4 5 6 7 8 9 A B C D E F"
CrRt     fcb   C$CR
H1L      equ   *-H1
H2       fcc   " #  = = = = = = = = = = = = = = = ="
*         fcb   C$CR
H2L      equ   *-H2
SysDat   fcb   $00,$00,$00,$00

start    lbsr  WriteCR			Write a carriage return to standard out
         leax  <H1,pcr			point to header 1
         lda   #$01
         ldy   #H1L
         os9   I$WritLn 		and write it to standard out
         leax  <H2,pcr			same with header 2
         ldy   #H2L
         os9   I$Write  
         leax  <SysDat,pcr
         tfr   x,d
         ldx   #D.SysMem		point to System Memory global
         ldy   #$0002			get 2 byte pointer into system RAM
         pshs  u			save statics
         leau  memmap,u			point to destination
         os9   F$CpyMem 		get it
         puls  u			restore statics
         lbcs  L013F			branch if error
         ldx   memmap,u			get pointer into system memory table in system space
         ldy   #256			all 256 bytes
         pshs  u			save statics
         leau  memmap,u			point to destination
         os9   F$CpyMem 		copy memory
         puls  u			restore statics
         lbcs  L013F			branch if error
         clr   <u000E
         clr   <free			clear free counter
         leax  memmap,u
         lda   #$30
         sta   <u0005
         clr   ,-s
L00B2    lda   ,s
         bita  #$0F
         bne   L00DF
         pshs  x
         lbsr  WriteCR
         leax  u0006,u
         ldy   #$0004
         lda   <u0005
         cmpa  #':
         bne   L00CD
         lda   #'A
         sta   <u0005
L00CD    sta   <wrbuf
         inc   <u0005
         ldd   #C$SPAC*256+C$SPAC
         sta   <u0006
         std   <u0008
         lda   #$01
         os9   I$Write  
         puls  x
L00DF    ldb   ,x+
         beq   L00ED
         bmi   L00E9
         ldb   #'U
         bra   L00F1
L00E9    ldb   #'.
         bra   L00F1
L00ED    ldb   #'_
         inc   <free			increment free page counter
L00F1    stb   <wrbuf
         ldb   #C$SPAC
         stb   <u0008
         pshs  x
         leax  wrbuf,u
         ldy   #$0002
         lda   #$01
         os9   I$Write  
         puls  x
         dec   ,s
         lbhi  L00B2
         puls  a
         bsr   WriteCR
         bsr   WriteCR
         leax  >FreePgs,pcr
         ldy   #FreePgsL
         lda   #$01
         os9   I$Write  
         ldb   <free
         clra  
         lbsr  L0194
         bsr   WriteCR
         leax  >FreeRAM,pcr
         ldy   #FreeRAML
         lda   #$01
         os9   I$Write  
         ldb   <free
         clra  
         lsrb  
         lsrb  
         lbsr  L0194
         bsr   WriteCR
         clrb  
L013F    os9   F$Exit   

FreePgs  fcc   " Number of Free Pages: "
FreePgsL equ   *-FreePgs
FreeRAM  fcc   "   RAM Free in KBytes: "
FreeRAML equ   *-FreeRAM

WriteCR  pshs  x,a
*         lda   #C$CR
*         sta   <wrbuf
         leax  CrRt,pcr
         ldy   #$0001
         lda   #$01
         os9   I$WritLn 
         puls  pc,x,a

L0183    sta   <wrbuf
         pshs  x
         leax  wrbuf,u
         ldy   #$0001
         lda   #$01
         os9   I$Write  
         puls  pc,x

L0194    leax  decbuff,u
         clr   <u0000
         clr   ,x
         clr   $01,x
         clr   $02,x
L019E    inc   ,x
         subd  #100
         bcc   L019E
         addd  #100
L01A8    inc   $01,x
         subd  #10
         bcc   L01A8
L01AF    addd  #10
         incb  
         stb   $02,x
         bsr   L01BF
         bsr   L01BF
L01B9    lda   ,x+
         adda  #$2F
         bra   L0183
L01BF    tst   <u0000
         bne   L01B9
         ldb   ,x
         inc   <u0000
         decb  
         bne   L01B9
         clr   <u0000
         lda   #C$SPAC
         leax  1,x
         bra   L0183

         emod
eom      equ   *
	 end

