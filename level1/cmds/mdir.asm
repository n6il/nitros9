********************************************************************
* Mdir - Show module directory
*
* $Id$
*
* Ed.    Comments                                       Who YY/MM/DD
* ------------------------------------------------------------------
*  5     Original Tandy version

         nam   Mdir
         ttl   Show module directory

* Disassembled 02/04/05 12:49:18 by Disasm v1.6 (C) 1988 by RML

         ifp1
         use   defsfile
         endc

tylg     set   Prgrm+Objct   
atrv     set   ReEnt+rev
rev      set   $01

         mod   eom,name,tylg,atrv,start,size

u0000    rmb   2
u0002    rmb   2
u0004    rmb   2
u0006    rmb   1
u0007    rmb   1
u0008    rmb   1
u0009    rmb   3
u000C    rmb   3
u000F    rmb   1
u0010    rmb   1
u0011    rmb   1
u0012    rmb   530
size     equ   .

name     fcs   /Mdir/
         fcb   $05 

L0012    fcb   C$LF
         fcc   "  Module directory at "
L0029    fcb   C$LF
         fcc   "Addr Size Typ Rev Attr Use Module name"
         fcb   C$LF
         fcc   "---- ---- --- --- ---- --- ------------"
         fcb   C$CR
L0079    fcb   C$LF
         fcc   "Addr Size Ty Rv At Uc   Name"
         fcb   C$LF
         fcc   "---- ---- -- -- -- -- ---------"
         fcb   C$CR

start    stx   <u0004
         lda   #$0C
         ldb   #$30
         std   <u000F
         clr   <u0011
         lda   #$01
         ldb   #SS.ScSiz
         os9   I$GetStt 
         bcc   L00D2
         cmpb  #E$UnkSvc
         lbne  L01BE
         bra   L00DF
L00D2    cmpx  #80
         beq   L00DF
         inc   <u0011
         lda   #$0A
         ldb   #$15
         std   <u000F
L00DF    leax  >L0012,pcr
         ldy   #$0017
         lda   #$01
         os9   I$WritLn 
         leax  u0009,u
         os9   F$Time   
         leax  <u0012,u
         stx   <u0007
         leax  u000C,u
         lbsr  L0224
         lbsr  L0210
         ldx   >D.ModDir
         stx   <u0000
         ldd   >D.ModDir+2
         std   <u0002
         leax  -$04,x
         ldy   <u0004
         lda   ,y+
         eora  #'E
         anda  #$DF
         bne   L0157
         tst   <u0011
         bne   L0123
         leax  >L0029,pcr
         ldy   #80
         bra   L012B
L0123    leax  >L0079,pcr
         ldy   #$003E
L012B    lda   #$01
         os9   I$WritLn 
         ldx   <u0000
         lbra  L01B9
L0135    ldy   ,x
         beq   L015D
         ldd   $04,y
         leay  d,y
         lbsr  L0205
L0141    lbsr  L01F2
         ldb   <u0008
         subb  #$12
         cmpb  <u0010
         bhi   L0154
L014C    subb  <u000F
         bhi   L014C
         bne   L0141
         bra   L015D
L0154    lbsr  L0210
L0157    leay  <u0012,u
         sty   <u0007
L015D    leax  $04,x
         cmpx  <u0002
         bcs   L0135
         lbsr  L0210
         bra   L01BD
L0168    leay  <u0012,u
         sty   <u0007
         ldy   ,x
         beq   L01B7
         ldd   ,x
         bsr   L01C1
         ldd   $02,y
         bsr   L01C1
         tst   <u0011
         bne   L0181
         bsr   L01F2
L0181    lda   $06,y
         bsr   L01C9
         tst   <u0011
         bne   L018B
         bsr   L01F2
L018B    lda   $07,y
         anda  #$0F
         bsr   L01C9
         ldb   $07,y
         lda   #$72
         bsr   L01FE
         tst   <u0011
         bne   L01A7
         lda   #$3F
         bsr   L01FE
         lda   #$3F
         bsr   L01FE
         lda   #$3F
         bsr   L01FE
L01A7    bsr   L01F2
         bsr   L01F2
         lda   $02,x
         bsr   L01C9
         ldd   $04,y
         leay  d,y
         bsr   L0205
         bsr   L0210
L01B7    leax  $04,x
L01B9    cmpx  <u0002
         bcs   L0168
L01BD    clrb  
L01BE    os9   F$Exit   
L01C1    bsr   L01CD
         tfr   b,a
         bsr   L01CF
         bra   L01F2
L01C9    bsr   L01CD
         bra   L01F2
L01CD    clr   <u0006
L01CF    pshs  a
         lsra  
         lsra  
         lsra  
         lsra  
         bsr   L01DB
         lda   ,s+
         anda  #$0F
L01DB    tsta  
         beq   L01E0
         sta   <u0006
L01E0    tst   <u0006
         bne   L01E8
         lda   #$20
         bra   L01F4
L01E8    adda  #$30
         cmpa  #$39
         bls   L01F4
         adda  #$07
         bra   L01F4
L01F2    lda   #$20
L01F4    pshs  x
         ldx   <u0007
         sta   ,x+
         stx   <u0007
         puls  pc,x
L01FE    rolb  
         bcs   L01F4
         lda   #$2E
         bra   L01F4
L0205    lda   ,y
         anda  #$7F
         bsr   L01F4
         lda   ,y+
         bpl   L0205
         rts   
L0210    pshs  y,x,a
         lda   #$0D
         bsr   L01F4
         leax  <u0012,u
         ldy   #80
         lda   #$01
         os9   I$WritLn 
         puls  pc,y,x,a
L0224    bsr   L022C
         bsr   L0228
L0228    lda   #$3A
         bsr   L01F4
L022C    ldb   ,x+
         lda   #$2F
L0230    inca  
         subb  #$64
         bcc   L0230
         cmpa  #$30
         beq   L023B
         bsr   L01F4
L023B    lda   #$3A
L023D    deca  
         addb  #$0A
         bcc   L023D
         bsr   L01F4
         tfr   b,a
         adda  #$30
         bra   L01F4

         emod
eom      equ   *
         end
