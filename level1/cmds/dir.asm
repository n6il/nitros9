********************************************************************
* Dir - Show directory
*
* $Id$
*
* Ed.    Comments                                       Who YY/MM/DD
* ------------------------------------------------------------------
*   5    From Tandy OS-9 Level One VR 02.00.00
*   7    Made compliant with 1900-2155                  BGP 99/05/11

         nam   Dir
         ttl   Show directory

* Disassembled 99/04/11 17:39:33 by Disasm v1.6 (C) 1988 by RML

         ifp1
         use   defsfile
         endc

tylg     set   Prgrm+Objct   
atrv     set   ReEnt+rev
rev      set   $01
edition  set   7

         mod   eom,name,tylg,atrv,start,size

u0000    rmb   2
u0002    rmb   1
u0003    rmb   1
u0004    rmb   1
u0005    rmb   1
u0006    rmb   1
u0007    rmb   1
u0008    rmb   1
u0009    rmb   1
u000A    rmb   1
u000B    rmb   1
u000C    rmb   3
u000F    rmb   3
u0012    rmb   29
u002F    rmb   1
u0030    rmb   1
u0031    rmb   1
u0032    rmb   1
u0033    rmb   2
u0035    rmb   6
u003B    rmb   2
u003D    rmb   2
u003F    rmb   530
size     equ   .

name     fcs   /Dir/
         fcb   edition

L0011    fcb   C$LF
         fcs   " Directory of "
L0020    fcc   "."
         fcb   C$CR
L0022    fcc   "@"
         fcb   C$CR
WideDir  fcb   C$LF
         fcc   "Owner Last modified   Attributes Sector Bytecount Name"
         fcb   C$LF
         fcc   "----- --------------- ---------- ------ --------- ----------"
         fcb   C$CR
WideDirL equ   *-WideDir

NrrwDir  fcb   C$LF
         fcc   "Modified on    Owner   Name"
         fcb   C$LF
         fcc   "  Attr     Sector     Size"
         fcb   C$LF
         fcc   "==============================="
         fcb   C$CR
NrrwDirL equ   *-NrrwDir

start    leay  <u003F,u
         sty   <u000A
         clr   <u0004
         clr   <u0003
         clr   <u0009
         lda   #$10
         ldb   #$30
         std   <u0007
         pshs  y,x,b,a
         lda   #1
         ldb   #$26
         os9   I$GetStt 
         bcc   L0111
         cmpb  #$D0
         beq   L011E
         puls  y,x,b,a
         lbra  L0258
L0111    cmpx  #80
         beq   L011E
         inc   <u0009
         lda   #$0A
         ldb   #$14
         std   <u0007
L011E    puls  y,x,b,a
         lbsr  L032F
         lda   ,-x
         cmpa  #$0D
         bne   L012D
         leax  >L0020,pcr
L012D    stx   <u0000
         lda   #$81
         ora   <u0004
         pshs  x,a
         os9   I$Open   
         sta   <u0002
         puls  x,a
         lbcs  L0258
         os9   I$ChgDir 
         lbcs  L0258
         pshs  x
         leay  >L0011,pcr
         lbsr  L02CC
         ldx   <u0000
L0152    lda   ,x+
         lbsr  L02A6
         cmpx  ,s
         bcs   L0152
         leas  $02,s
         lbsr  L032F
         lbsr  L02A4
         lbsr  L02A4
         leax  u000C,u
         os9   F$Time   
         leax  u000F,u
         lbsr  L0302
         lbsr  L02D7
         tst   <u0003
         beq   L01A3
         lda   #$01
         ora   <u0004
         leax  >L0022,pcr
         os9   I$Open   
         lbcs  L0258
         sta   <u0005
         tst   <u0009
         bne   L0196
         leax  >WideDir,pcr
         ldy   #WideDirL
         bra   L019E
L0196    leax  >NrrwDir,pcr
         ldy   #NrrwDirL
L019E    lda   #$01
         os9   I$WritLn 
L01A3    lda   <u0002
         ldx   #$0000
         pshs  u
         ldu   #$0040
         os9   I$Seek   
         puls  u
         lbra  L0243
L01B5    tst   <u0012
         lbeq  L0243
         tst   <u0003
         bne   L01D8
         leay  <u0012,u
         lbsr  L02CC
L01C5    lbsr  L02A4
         ldb   <u000B
         subb  #$3F
         cmpb  <u0008
         bhi   L021C
L01D0    subb  <u0007
         bhi   L01D0
         bne   L01C5
         bra   L0243
L01D8    pshs  u
         lda   <u0031
         clrb  
         tfr   d,u
         ldx   <u002F
         lda   <u0005
         os9   I$Seek   
         puls  u
         bcs   L0258
         leax  <u0032,u
         ldy   #$000D
         os9   I$Read   
         bcs   L0258
         tst   <u0009
         bne   L0221
         ldd   <u0033
         clr   <u0006
         bsr   L0263
         lbsr  L02A4
         lbsr  L02ED
         lbsr  L02A4
         lbsr  L02B9
         lbsr  L02A4
         lbsr  L02A4
         bsr   L025D
         bsr   L026F
         leay  <u0012,u
         lbsr  L02CC
L021C    lbsr  L02D7
         bra   L0243
L0221    lbsr  L02ED
         ldd   <u0033
         clr   <u0006
         bsr   L0263
         bsr   L02A4
         leay  <u0012,u
         lbsr  L02CC
         lbsr  L02D7
         lbsr  L02B9
         bsr   L02A4
         bsr   L02A4
         bsr   L025D
         bsr   L026F
         lbsr  L02D7
L0243    leax  <u0012,u
         ldy   #$0020
         lda   <u0002
         os9   I$Read   
         lbcc  L01B5
         cmpb  #$D3
         bne   L0258
         clrb  
L0258    bsr   L02D7
         os9   F$Exit   
L025D    lda   <u002F
         bsr   L0287
         ldd   <u0030
L0263    bsr   L0289
         tfr   b,a
         bsr   L027D
         inc   <u0006
         bsr   L028B
         bra   L02A4
L026F    ldd   <u003B
         bsr   L0287
         tfr   b,a
         bsr   L0289
         bsr   L02A4
         ldd   <u003D
         bra   L0263
L027D    pshs  a
         lsra  
         lsra  
         lsra  
         lsra  
         bsr   L028D
         puls  pc,a
L0287    clr   <u0006
L0289    bsr   L027D
L028B    anda  #$0F
L028D    tsta  
         beq   L0292
         sta   <u0006
L0292    tst   <u0006
         bne   L029A
         lda   #$20
         bra   L02A6
L029A    adda  #$30
         cmpa  #$39
         bls   L02A6
         adda  #$07
         bra   L02A6
L02A4    lda   #$20
L02A6    pshs  x
         ldx   <u000A
         sta   ,x+
         stx   <u000A
         puls  pc,x
L02B0    fcc   "dsewrewr"
         fcb   $FF
L02B9    fcb   $D6,$32
         leax  <L02B0,pcr
         lda   ,x+
L02C0    lslb  
         bcs   L02C5
         lda   #$2D
L02C5    bsr   L02A6
         lda   ,x+
         bpl   L02C0
         rts   
L02CC    lda   ,y
         anda  #$7F
         bsr   L02A6
         lda   ,y+
         bpl   L02CC
         rts   
L02D7    pshs  y,x,a
         lda   #$0D
         bsr   L02A6
         leax  <u003F,u
         stx   <u000A
         ldy   #$0050
         lda   #$01
         os9   I$WritLn 
         puls  pc,y,x,a
L02ED    leax  <u0035,u
         ldb   ,x
         cmpb  #100
         blo   L1900
         subb  #100
         cmpb  #100
         blo   L2000
L2100    subb  #100 
         stb   ,x
         ldb   #21
         bra   PrCnty
L1900    stb   ,x
         ldb   #19
         bra   PrCnty
L2000    stb   ,x
         ldb   #20
PrCnty   bsr   L030C
         bsr   L030A
         bsr   L02FE
         bsr   L02FE
         bsr   L02A4
         bsr   L030A
         bsr   L030A
         bra   L02A4
L02FE    lda   #$2F
         bra   L0308
L0302    bsr   L030A
         bsr   L0306
L0306    lda   #$3A
L0308    lbsr  L02A6
L030A    ldb   ,x+
L030C    lda   #$2F
         cmpb  #$64
         bcs   L0313
         clrb  
L0313    inca  
         subb  #$64
         bcc   L0313
         cmpa  #$30
         beq   L031E
         lbsr  L02A6
L031E    lda   #$3A
L0320    deca  
         addb  #$0A
         bcc   L0320
         lbsr  L02A6
         tfr   b,a
         adda  #$30
         lbra  L02A6
L032F    ldd   ,x+
         cmpa  #$20
         beq   L032F
         cmpa  #$2C
         beq   L032F
         eora  #$45
         anda  #$DF
         bne   L0347
         cmpb  #$30
         bcc   L0347
         inc   <u0003
         bra   L032F
L0347    lda   -$01,x
         eora  #$58
         anda  #$DF
         bne   L0359
         cmpb  #$30
         bcc   L0359
         lda   #$04
         sta   <u0004
         bra   L032F
L0359    rts   

         emod
eom      equ   *
         end
