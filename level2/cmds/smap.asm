********************************************************************
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
u0001    rmb   3
u0004    rmb   1
u0005    rmb   1
u0006    rmb   1
u0007    rmb   1
u0008    rmb   6
u000E    rmb   1
u000F    rmb   456
size     equ   .

name	 fcs   /SMap/
         fcb   edition

H1       fcc   "    0 1 2 3 4 5 6 7 8 9 A B C D E F"
         fcb   C$CR
H1L      equ   *-H1
H2       fcc   " #  = = = = = = = = = = = = = = = ="
         fcb   C$CR
H2L      equ   *-H2
L005A    fcb   $00,$00,$00,$00

start    lbsr  L0170
         leax  >H1,pcr
         lda   #$01
         ldy   #H1L
         os9   I$WritLn 
         leax  >H2,pcr
         ldy   #H2L
         os9   I$Write  
         leax  >L005A,pcr
         tfr   x,d
         ldx   #$004E
         ldy   #$0002
         pshs  u
         leau  u000F,u
         os9   F$CpyMem 
         puls  u
         lbcs  L013F
         ldx   u000F,u
         ldy   #$0100
         pshs  u
         leau  u000F,u
         os9   F$CpyMem 
         puls  u
         lbcs  L013F
         clr   <u000E
         clr   <u0004
         leax  u000F,u
         lda   #$30
         sta   <u0005
         clr   ,-s
L00B2    lda   ,s
         bita  #$0F
         bne   L00DF
         pshs  x
         lbsr  L0170
         leax  u0006,u
         ldy   #$0004
         lda   <u0005
         cmpa  #$3A
         bne   L00CD
         lda   #$41
         sta   <u0005
L00CD    sta   <u0007
         inc   <u0005
         ldd   #$2020
         sta   <u0006
         std   <u0008
         lda   #$01
         os9   I$Write  
         puls  x
L00DF    ldb   ,x+
         beq   L00ED
         bmi   L00E9
         ldb   #$55
         bra   L00F1
L00E9    ldb   #$2E
         bra   L00F1
L00ED    ldb   #$5F
         inc   <u0004
L00F1    stb   <u0007
         ldb   #$20
         stb   <u0008
         pshs  x
         leax  u0007,u
         ldy   #$0002
         lda   #$01
         os9   I$Write  
         puls  x
         dec   ,s
         lbhi  L00B2
         puls  a
         bsr   L0170
         bsr   L0170
         leax  >FreePgs,pcr
         ldy   #FreePgsL
         lda   #$01
         os9   I$Write  
         ldb   <u0004
         clra  
         lbsr  L0194
         bsr   L0170
         leax  >FreeRAM,pcr
         ldy   #FreeRAML
         lda   #$01
         os9   I$Write  
         ldb   <u0004
         clra  
         lsrb  
         lsrb  
         lbsr  L0194
         bsr   L0170
         clrb  
L013F    os9   F$Exit   

FreePgs  fcc   " Number of Free Pages: "
FreePgsL equ   *-FreePgs
FreeRAM  fcc   "   RAM Free in KBytes: "
FreeRAML equ   *-FreeRAM

L0170    pshs  x,a
         lda   #C$CR
         sta   <u0007
         leax  u0007,u
         ldy   #$0001
         lda   #$01
         os9   I$WritLn 
         puls  pc,x,a
L0183    sta   <u0007
         pshs  x
         leax  u0007,u
         ldy   #$0001
         lda   #$01
         os9   I$Write  
L0192    puls  pc,x
L0194    leax  u0001,u
         clr   <u0000
         clr   ,x
         clr   $01,x
         clr   $02,x
L019E    inc   ,x
         subd  #$0064
         bcc   L019E
         addd  #$0064
L01A8    inc   $01,x
         subd  #$000A
         bcc   L01A8
L01AF    addd  #$000A
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

