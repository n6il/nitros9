********************************************************************
* Mfree - Show free memory
*
* $Id$
*
* Edt/Rev  YYYY/MM/DD  Modified by
* Comment
* ------------------------------------------------------------------
*   2      ????/??/??
* Original Tandy/Microware version.

         nam   Mfree
         ttl   Show free memory

* Disassembled 98/09/11 12:07:32 by Disasm v1.6 (C) 1988 by RML

         ifp1
         use   defsfile
         endc

tylg     set   Prgrm+Objct   
atrv     set   ReEnt+rev
rev      set   $00
edition  set   2

         mod   eom,name,tylg,atrv,start,size

u0000    rmb   1
u0001    rmb   1
u0002    rmb   2
u0004    rmb   1
u0005    rmb   1
u0006    rmb   1
u0007    rmb   1
u0008    rmb   1
u0009    rmb   1
u000A    rmb   1
u000B    rmb   2
linebuf  rmb   80
u005D    rmb   7
u0064    rmb   132
u00E8    rmb   1135
size     equ   .

name     fcs   /Mfree/
         fcb   edition

Hdr      fcs   " Blk Begin   End   Blks  Size"
         fcs   " --- ------ ------ ---- ------"
Ftr      fcs   "                   ==== ======"
         fcs   "            Total: "

start    leax  linebuf,u		get line buffer address
         stx   <u0009
         stx   <u000B
         lbsr  L016E
         leay  <Hdr,pcr
         lbsr  L0183
         lbsr  L016E
         lbsr  L0183
         lbsr  L016E
         clr   <u0000
         clr   <u0001
         leax  <u005D,u
         os9   F$GBlkMp 
         sty   <u0002
         sta   <u0004
         ldy   #$0000
L00AA    ldu   #$0000
L00AD    tst   ,x+
         beq   L00BA
         leay  $01,y
         cmpy  <u0002
         bcs   L00AD
         bra   L0109
L00BA    tfr   y,d
         bsr   L0123
         lda   <u0004
         pshs  y,a
         clra  
         clrb  
L00C4    addd  $01,s
         dec   ,s
         bne   L00C4
         leas  $03,s
         std   <u0006
         clr   <u0008
         bsr   L0133
L00D2    leau  u0001,u
         leay  $01,y
         cmpy  <u0002
         beq   L0109
         tst   ,x+
         beq   L00D2
         lda   <u0004
         pshs  y,a
         clra  
         clrb  
L00E5    addd  $01,s
         dec   ,s
         bne   L00E5
         leas  $03,s
         subd  #$0001
         std   <u0006
         lda   #$FF
         sta   <u0008
         bsr   L0133
         leax  -$01,x
         tfr   u,d
         bsr   L0123
         lbsr  L0199
         addd  <u0000
         std   <u0000
         bsr   L016E
         bra   L00AA
L0109    leay  >Ftr,pcr
         bsr   L0183
         bsr   L016E
         bsr   L0183
         tfr   u,d
         addd  <u0000
         std   <u0000
         bsr   L0123
         bsr   L0199
         bsr   L016E
         clrb  
         os9   F$Exit   
L0123    pshs  b,a
         clr   <u0005
         bsr   L0145
         tfr   b,a
         bsr   L0145
         lda   #$20
         bsr   L0164
         puls  pc,b,a
L0133    clr   <u0005
         lda   <u0006
         bsr   L0145
         lda   <u0007
         bsr   L0145
         lda   <u0008
         bsr   L0145
         lda   #$20
         bra   L0164
L0145    pshs  a
         lsra  
         lsra  
         lsra  
         lsra  
         bsr   L014F
         puls  a
L014F    anda  #$0F
         tsta  
         beq   L0156
         sta   <u0005
L0156    tst   <u0005
         bne   L015C
         lda   #$F0
L015C    adda  #$30
         cmpa  #$3A
         bcs   L0164
         adda  #$07
L0164    pshs  x
         ldx   <u000B
         sta   ,x+
         stx   <u000B
         puls  pc,x

L016E    pshs  y,x,a
         lda   #C$CR
         bsr   L0164
         ldx   <u0009
         stx   <u000B
         ldy   #80
         lda   #$01
         os9   I$WritLn 
         puls  pc,y,x,a
L0183    lda   ,y
         anda  #$7F
         bsr   L0164
         tst   ,y+
         bpl   L0183
         rts   

DecTbl   fdb   10000,1000,100,10,1
         fcb   $FF

L0199    pshs  y,x,b,a
         lda   <u0004
         pshs  a
         lda   $01,s
         lsr   ,s
         lsr   ,s
         bra   L01A9
L01A7    lslb
         rola
L01A9    lsr   ,s
         bne   L01A7
         leas  1,s
         leax  <DecTbl,pcr
         ldy   #$2F20
L01B6    leay  >256,y
         subd  ,x
         bcc   L01B6
         addd  ,x++
         pshs  b,a
         tfr   y,d
         tst   ,x
         bmi   L01DE
         ldy   #$2F30
         cmpd  #'0*256+C$SPAC
         bne   L01D8
         ldy   #$2F20
         lda   #C$SPAC
L01D8    bsr   L0164
         puls  b,a
         bra   L01B6
L01DE    bsr   L0164
         lda   #'k
         bsr   L0164
         leas  $02,s
         puls  pc,y,x,b,a

         emod
eom      equ   *
         end
