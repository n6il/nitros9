********************************************************************
* Dir - Show directory
*
* $Id$
*
* This dir initially started from the dir command that came with
* the OS-9 Level Two package, then incorporated Glenside's Y2K
* fix.
*
* Ed.    Comments                                       Who YY/MM/DD
* ------------------------------------------------------------------
* 10     Incorporated Glenside Y2K fixes                BGP 99/05/11

         nam   Dir
         ttl   Show directory

         ttl   program module       

* Disassembled 99/04/11 16:36:40 by Disasm v1.6 (C) 1988 by RML

         ifp1
         use   defsfile
         endc

tylg     set   Prgrm+Objct   
atrv     set   ReEnt+rev
rev      set   $00
edition  set   10

         mod   eom,name,tylg,atrv,start,size

u0000    rmb   2
u0002    rmb   1
u0003    rmb   1
u0004    rmb   1
u0005    rmb   1
u0006    rmb   2
u0008    rmb   1
u0009    rmb   1
u000A    rmb   1
u000B    rmb   1
u000C    rmb   1
u000D    rmb   3
u0010    rmb   3
u0013    rmb   29
u0030    rmb   1
u0031    rmb   1
u0032    rmb   1
u0033    rmb   1
u0034    rmb   2
u0036    rmb   6
u003C    rmb   2
u003E    rmb   2
u0040    rmb   530
size     equ   .

name     fcs   /Dir/
         fcb   edition

L0011    fcb   C$LF
         fcs   " Directory of "
L0020    fcc   "."
         fcb   C$CR
L0022    fcc   "@"
         fcb   C$CR
L0024    fcb   C$CR,C$LF
         fcc   "Owner  Last modified   Attributes Sector Bytecount   Name"
         fcb   C$CR,C$LF
         fcc   "----- ---------------- ---------- ------ --------- ----------"
         fcb   C$CR,C$LF
L00A0    fcb   C$CR,C$LF
         fcc   "Modified on  Owner   Name"
         fcb   C$CR,C$LF
         fcc   "  Attr     Sector     Size"
         fcb   C$CR,C$LF
         fcc   "==============================="
         fcb   C$CR
         fcb   C$LF

start    leay  <u0040,u
         sty   <u000B
         clr   <u0004
         clr   <u0003
         clr   <u000A
         lda   #$10
         ldb   #$30
         std   <u0008
         pshs  y,x,b,a
         lda   #$01
         ldb   #$26
         os9   I$GetStt 
         bcc   L0120
         cmpb  #$D0
         beq   L012D
         puls  y,x,b,a
         lbra  L0268
L0120    cmpx  #$0040
         bge   L012D
         inc   <u000A
         lda   #$0A
         ldb   #$14
         std   <u0008
L012D    puls  y,x,b,a
         lbsr  L0370
         lda   ,-x
         cmpa  #$0D
         bne   L013C
         leax  >L0020,pcr
L013C    stx   <u0000
         lda   #$81
         ora   <u0004
         pshs  x,a
         os9   I$Open   
         sta   <u0002
         puls  x,a
         lbcs  L0268
         os9   I$ChgDir 
         lbcs  L0268
         pshs  x
         leay  >L0011,pcr
         lbsr  L02E6
         ldx   <u0000
L0161    lda   ,x+
         lbsr  L02B7
         cmpx  ,s
         bcs   L0161
         leas  $02,s
         lbsr  L0370
         lbsr  L02B5
         lbsr  L02B5
         leax  u000D,u
         os9   F$Time   
         leax  <u0010,u
         lbsr  L0328
         lbsr  L02F5
         tst   <u0003
         beq   L01B3
         lda   #$01
         ora   <u0004
         leax  >L0022,pcr
         os9   I$Open   
         lbcs  L0268
         sta   <u0005
         tst   <u000A
         bne   L01A6
         leax  >L0024,pcr
         ldy   #$007C
         bra   L01AE
L01A6    leax  >L00A0,pcr
         ldy   #$005A
L01AE    lda   #$01
         os9   I$Write  
L01B3    lda   <u0002
         ldx   #$0000
         pshs  u
         ldu   #$0040
         os9   I$Seek   
         puls  u
         lbra  L0253
L01C5    tst   <u0013
         lbeq  L0253
         tst   <u0003
         bne   L01E8
         leay  <u0013,u
         lbsr  L02E6
L01D5    lbsr  L02B5
         ldb   <u000C
         subb  #$40
         cmpb  <u0009
         bhi   L022C
L01E0    subb  <u0008
         bhi   L01E0
         bne   L01D5
         bra   L0253
L01E8    pshs  u
         lda   <u0032
         clrb  
         tfr   d,u
         ldx   <u0030
         lda   <u0005
         os9   I$Seek   
         puls  u
         bcs   L0268
         leax  <u0033,u
         ldy   #$000D
         os9   I$Read   
         bcs   L0268
         tst   <u000A
         bne   L0231
         ldd   <u0034
         clr   <u0006
         bsr   L0274
         lbsr  L02B5
         lbsr  L030B
         lbsr  L02B5
         lbsr  L02D3
         lbsr  L02B5
         lbsr  L02B5
         bsr   L026E
         bsr   L0280
         leay  <u0013,u
         lbsr  L02E6
L022C    lbsr  L02F5
         bra   L0253
L0231    lbsr  L030B
         ldd   <u0034
         clr   <u0006
         bsr   L0274
         bsr   L02B5
         leay  <u0013,u
         lbsr  L02E6
         lbsr  L02F5
         lbsr  L02D3
         bsr   L02B5
         bsr   L02B5
         bsr   L026E
         bsr   L0280
         lbsr  L02F5
L0253    leax  <u0013,u
         ldy   #$0020
         lda   <u0002
         os9   I$Read   
         lbcc  L01C5
         cmpb  #$D3
         bne   L0268
         clrb  
L0268    lbsr  L02F5
         os9   F$Exit   
L026E    lda   <u0030
         bsr   L0298
         ldd   <u0031
L0274    bsr   L029A
         tfr   b,a
         bsr   L028E
         inc   <u0006
         bsr   L029C
         bra   L02B5
L0280    ldd   <u003C
         bsr   L0298
         tfr   b,a
         bsr   L029A
         bsr   L02B5
         ldd   <u003E
         bra   L0274
L028E    pshs  a
         lsra  
         lsra  
         lsra  
         lsra  
         bsr   L029E
         puls  pc,a
L0298    clr   <u0006
L029A    bsr   L028E
L029C    anda  #$0F
L029E    tsta  
         beq   L02A3
         sta   <u0006
L02A3    tst   <u0006
         bne   L02AB
         lda   #$20
         bra   L02B7
L02AB    adda  #$30
         cmpa  #$39
         bls   L02B7
         adda  #$07
         bra   L02B7
L02B5    lda   #$20
L02B7    pshs  x
         ldx   <u000B
         cmpx  #$0090
         bne   L02C4
         bsr   L02F1
         ldx   <u000B
L02C4    sta   ,x+
         stx   <u000B
         puls  pc,x
L02CA    fcc   "dsewrewr"
         fcb    $FF
L02D3    fcb    $D6,$33,$30,$8C,$F2
         lda   ,x+
L02DA    lslb  
         bcs   L02DF
         lda   #$2D
L02DF    bsr   L02B7
         lda   ,x+
         bpl   L02DA
         rts   
L02E6    lda   ,y
         anda  #$7F
         bsr   L02B7
         lda   ,y+
         bpl   L02E6
         rts   
L02F1    pshs  y,x,b,a
         bra   L02FB
L02F5    pshs  y,x,b,a
         lda   #$0D
         bsr   L02B7
L02FB    leax  <u0040,u
         stx   <u000B
         ldy   #$0050
         lda   #$01
         os9   I$WritLn 
         puls  pc,y,x,b,a
L030B    leax  <u0036,u
L030E    bsr   L0338
         bsr   L0324
         bsr   L0324
         bsr   L02B5
         bsr   L034F
         tst   <u000A
         beq   L0320
         bsr   L034F
         bra   L02B5
L0320    bsr   L0332
         bra   L02B5
L0324    lda   #$2F
         bra   L0334
L0328    tst   <u000A
         bne   L0330
         leax  u000D,u
         bra   L030E
L0330    bsr   L034F
L0332    lda   #$3A
L0334    bsr   L02B7
         bra   L034F
L0338    lda   #$AE
         ldb   ,x
L033C    inca  
         subb  #$64
         bcc   L033C
         stb   ,x
         tfr   a,b
         tst   <u000A
         bne   L034B
         bsr   L035F
L034B    ldb   ,x+
         bra   L035F
L034F    ldb   ,x+
         lda   #$2F
L0353    inca  
         subb  #$64
         bcc   L0353
         cmpa  #$30
         beq   L035F
         lbsr  L02B7
L035F    lda   #$3A
L0361    deca  
         addb  #$0A
         bcc   L0361
         lbsr  L02B7
         tfr   b,a
         adda  #$30
         lbra  L02B7
L0370    ldd   ,x+
         cmpa  #$20
         beq   L0370
         cmpa  #$2C
         beq   L0370
         eora  #$45
         anda  #$DF
         bne   L0388
         cmpb  #$30
         bcc   L039A
         inc   <u0003
         bra   L0370
L0388    lda   -$01,x
         eora  #$58
         anda  #$DF
         bne   L039A
         cmpb  #$30
         bcc   L039A
         lda   #$04
         sta   <u0004
         bra   L0370
L039A    rts   

         emod
eom      equ   *
         end
