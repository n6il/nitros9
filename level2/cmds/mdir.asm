********************************************************************
* MDir - Show module information
*
* $Id$
*
* Edt/Rev  YYYY/MM/DD  Modified by
* Comment
* ------------------------------------------------------------------
*   7      ????/??/??
* Original Tandy/Microware version
*
*  8       2003/01/14  Boisy Pitre
* Changed option to -e, optimized slightly. Could use greater optimization.

         nam   MDir
         ttl   Show module information

* Disassembled 98/09/11 11:57:27 by Disasm v1.6 (C) 1988 by RML

         ifp1
         use   defsfile
         endc

tylg     set   Prgrm+Objct   
atrv     set   ReEnt+rev
rev      set   $00
edition  set   8

         mod   eom,name,tylg,atrv,start,size

u0000    rmb   2
u0002    rmb   1
u0003    rmb   1
u0004    rmb   1
u0005    rmb   3
u0008    rmb   3
narrow   rmb   1
u000C    rmb   1
u000D    rmb   1
u000E    rmb   80
u005E    rmb   2
u0060    rmb   2
u0062    rmb   4096
u1062    rmb   64
u10A2    rmb   269
size     equ   .

name     fcs   /MDir/
         fcb   edition

header   fcs   "   Module Directory at "
header2  fcs   "Block Offset Size Typ Rev Attr  Use Module Name"
header3  fcs   "----- ------ ---- --- --- ---- ---- ------------"
sheader1 fcs   "Blk Ofst Size Ty Rv At Uc  Name"
sheader2 fcs   "___ ____ ____ __ __ __ __ ______"
lock     fcs   "Lock "
slock    fcs   "Lk"

start    pshs  u
         leau  >u1062,u
L00D4    clr   ,-u
         cmpu  ,s
         bhi   L00D4
         puls  u
         clr   <narrow
         ldd   #$0C30
         std   <u000C
         stx   <u0000
         leax  u000E,u
         stx   <u0003
         lbsr  L02A3
         lda   #$01		standard output
         ldb   #SS.ScSiz	get size of screen
         os9   I$GetStt 	get it!
         bcc   L00FF		branch if ok
         cmpb  #E$UnkSvc	unknown service?
         lbne  L0241		branch if not
         bra   L010C		else ignore screen width test
L00FF    cmpx  #50		compare against 50
         bge   L010C		if greater or equal, go on
         inc   <narrow		else set narrow flag
         ldd   #$0A15
         std   <u000C
L010C    leay  >header,pcr	point to header
         lbsr  L0298
         leax  u0005,u
         os9   F$Time   
         leax  u0008,u
         lbsr  L02B8
         lbsr  L02A3
         leax  <u0062,u
         pshs  u
         os9   F$GModDr 
         sty   <u005E
         stu   <u0060
         puls  u
         leax  -$08,x
         ldy   <u0000
         ldd   ,y+
         andb  #$DF
         cmpd  #$2D45		-e option?
         bne   L018E
         lbsr  L02A3
         tst   <narrow
         beq   L0149
         leay  >sheader1,pcr
         bra   L014D
L0149    leay  >header2,pcr
L014D    lbsr  L0298
         lbsr  L02A3
         tst   <narrow
         beq   L015D
         leay  >sheader2,pcr
         bra   L0161
L015D    leay  >header3,pcr
L0161    lbsr  L0298
         lbsr  L02A3
         leax  <u0062,u
         lbra  L023A
L016D    lbsr  L0308
         beq   L018E
         lbsr  L02DE
         lbsr  L0298
L0178    lbsr  L0285
         ldb   <u0004
         subb  #$0E
         cmpb  <u000D
         bhi   L018B
L0183    subb  <u000C
         bhi   L0183
         bne   L0178
         bra   L018E
L018B    lbsr  L02A3
L018E    leax  $08,x
         cmpx  <u005E
         bcs   L016D
         lbsr  L02A3
         lbra  L0240
L019A    lbsr  L0308
         lbeq  L0238
         tfr   d,y
         ldd   ,y
         tst   <narrow
         beq   L01B1
         lbsr  L0285
         lbsr  L024C
         bra   L01B4
L01B1    lbsr  L0244
L01B4    tst   <narrow
         bne   L01BE
         lbsr  L0285
         lbsr  L0285
L01BE    ldd   $04,x
         lbsr  L0244
         tst   <narrow
         bne   L01CA
         lbsr  L0285
L01CA    lbsr  L02DE
         leay  >u10A2,u
         ldd   $02,y
         bsr   L0244
         tst   <narrow
         bne   L01DC
         lbsr  L0285
L01DC    lda   $06,y
         bsr   L0252
         tst   <narrow
         bne   L01E7
         lbsr  L0285
L01E7    lda   $07,y
         anda  #$0F
         bsr   L0252
         ldb   $07,y
         lda   #$72
         lbsr  L0291
         tst   <narrow
         bne   L0207
         lda   #$3F
         lbsr  L0291
         lda   #$3F
         lbsr  L0291
         lda   #$3F
         lbsr  L0291
L0207    bsr   L0285
         ldd   $06,x
         cmpd  #$FFFF
         bne   L0223
         tst   <narrow
         beq   L021B
         leay  >slock,pcr
         bra   L021F
L021B    leay  >lock,pcr
L021F    bsr   L0298
         bra   L0230
L0223    tst   <narrow
         beq   L022E
         lbsr  L0285
         bsr   L024C
         bra   L0230
L022E    bsr   L0244
L0230    leay  >u1062,u
         bsr   L0298
         bsr   L02A3
L0238    leax  $08,x
L023A    cmpx  <u005E
         lbcs  L019A
L0240    clrb  
L0241    os9   F$Exit   
L0244    bsr   L0256
         tst   <u0002
         bne   L024C
         dec   <u0002
L024C    tfr   b,a
         bsr   L0258
         bra   L0285
L0252    bsr   L0256
         bra   L0285
L0256    clr   <u0002
L0258    pshs  a
         lsra  
         lsra  
         lsra  
         lsra  
         bsr   L026C
         tst   <u0002
         bpl   L0268
         lda   #$01
         sta   <u0002
L0268    lda   ,s+
         anda  #$0F
L026C    tsta  
         beq   L0271
         sta   <u0002
L0271    tst   <u0002
         bmi   L0277
         bne   L027B
L0277    lda   #C$SPAC
         bra   L0287
L027B    adda  #'0
         cmpa  #'9
         bls   L0287
         adda  #$07
         bra   L0287
L0285    lda   #C$SPAC
L0287    pshs  x
         ldx   <u0003
         sta   ,x+
         stx   <u0003
         puls  pc,x

L0291    rolb  
         bcs   L0287
         lda   #'.
         bra   L0287

L0298    lda   ,y
         anda  #$7F
         bsr   L0287
         lda   ,y+
         bpl   L0298
         rts   

L02A3    pshs  y,x,a
         lda   #C$CR
         bsr   L0287
         leax  u000E,u
         stx   <u0003
         ldy   #80
         lda   #$01
         os9   I$WritLn 
         puls  pc,y,x,a
L02B8    bsr   L02C0
         bsr   L02BC
L02BC    lda   #':
         bsr   L0287
L02C0    ldb   ,x+
         lda   #$2F
L02C4    inca  
         subb  #100
         bcc   L02C4
         cmpa  #'0
         beq   L02CF
         bsr   L0287
L02CF    lda   #$3A
L02D1    deca  
         addb  #10
         bcc   L02D1
         bsr   L0287
         tfr   b,a
         adda  #'0
         bra   L0287
L02DE    pshs  u,x
         bsr   L0308
         ldx   $04,x
         ldy   #$000D
         leau  >u10A2,u
         os9   F$CpyMem 
         pshs  b,a
         ldd   u0004,u
         leax  d,x
         puls  b,a
         ldu   $02,s
         leau  >u1062,u
         ldy   #64
         os9   F$CpyMem 
         tfr   u,y
         puls  pc,u,x
L0308    ldd   ,x
         beq   L0319
         pshs  y
         leay  <u0062,u
         pshs  y
         subd  <u0060
         addd  ,s++
         puls  y
L0319    rts   

         emod
eom      equ   *
         end
