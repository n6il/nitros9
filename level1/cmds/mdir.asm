********************************************************************
* Mdir - Show module directory
*
* $Id$
*
* Ed.    Comments                                       Who YY/MM/DD
* ------------------------------------------------------------------
*  5     Original Tandy version                         BGP 02/04/05

         nam   Mdir
         ttl   Show module directory

* Disassembled 02/04/05 12:49:18 by Disasm v1.6 (C) 1988 by RML

         ifp1
         use   defsfile
         endc

tylg     set   Prgrm+Objct   
atrv     set   ReEnt+rev
rev      set   $01
stdout   set   1

         mod   eom,name,tylg,atrv,start,size

MdirSt   rmb   2
MdirEn   rmb   2
u0004    rmb   2
u0006    rmb   1
bufptr   rmb   1
u0008    rmb   1
u0009    rmb   3
u000C    rmb   3
u000F    rmb   1
u0010    rmb   1
u0011    rmb   1
buffer   rmb   530
size     equ   .

name     fcs   /Mdir/
         fcb   $05 

tophead  fcb   C$LF
         fcc   "  Module directory at "
ltitle   fcb   C$LF
         fcc   "Addr Size Typ Rev Attr Use Module name"
         fcb   C$LF
         fcc   "---- ---- --- --- ---- --- ------------"
         fcb   C$CR
stitle    fcb   C$LF
         fcc   "Addr Size Ty Rv At Uc   Name"
         fcb   C$LF
         fcc   "---- ---- -- -- -- -- ---------"
         fcb   C$CR

start    stx   <u0004
         lda   #$0C
         ldb   #$30
         std   <u000F
         clr   <u0011
         lda   #stdout
         ldb   #SS.ScSiz
         os9   I$GetStt 
         bcc   L00D2
         cmpb  #E$UnkSvc
         lbne  exit
         bra   L00DF
L00D2    cmpx  #80
         beq   L00DF
         inc   <u0011
         lda   #$0A
         ldb   #$15
         std   <u000F
L00DF    leax  >tophead,pcr
         ldy   #$0017
         lda   #stdout
         os9   I$WritLn 
         leax  u0009,u
         os9   F$Time   
         leax  <buffer,u
         stx   <bufptr
         leax  u000C,u
         lbsr  L0224
         lbsr  write
         ldx   >D.ModDir
         stx   <MdirSt
         ldd   >D.ModDir+2
         std   <MdirEn
         leax  -$04,x
* Check for 'E' given as argument
         ldy   <u0004
         lda   ,y+
         eora  #'E
         anda  #$DF
         bne   L0157
         tst   <u0011
         bne   L0123
         leax  >ltitle,pcr
         ldy   #80            Maxlength to write
         bra   L012B
L0123    leax  >stitle,pcr
         ldy   #$003E         Maxlength to write
L012B    lda   #stdout
         os9   I$WritLn 
         ldx   <MdirSt
         lbra  L01B9
loop     ldy   ,x
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
L0154    lbsr  write
L0157    leay  <buffer,u
         sty   <bufptr
L015D    leax  $04,x
         cmpx  <MdirEn
         bcs   loop
         lbsr  write
         bra   L01BD
*
* A module entry is 2 twobyte pointers.
* If the first pointer is $0000, then the slot is unused
L0168    leay  <buffer,u
         sty   <bufptr
         ldy   ,x
         beq   gotonxt         Is slot unused? If yes, branch
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
         bsr   write
gotonxt  leax  $04,x
L01B9    cmpx  <MdirEn
         bcs   L0168

L01BD    clrb  
exit     os9   F$Exit   

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
         bra   ApndA
L01E8    adda  #'0
         cmpa  #'9
         bls   ApndA
         adda  #$07    Make it A-F
         bra   ApndA
L01F2    lda   #$20
*
* append a char (in reg a) to buffer
*
ApndA    pshs  x
         ldx   <bufptr
         sta   ,x+
         stx   <bufptr
         puls  pc,x

L01FE    rolb  
         bcs   ApndA
         lda   #'.
         bra   ApndA
L0205    lda   ,y
         anda  #$7F
         bsr   ApndA
         lda   ,y+
         bpl   L0205
         rts   
*
* Append a CR to buffer and write it
*
write    pshs  y,x,a
         lda   #C$CR
         bsr   ApndA
         leax  <buffer,u
         ldy   #80
         lda   #stdout
         os9   I$WritLn 
         puls  pc,y,x,a

L0224    bsr   L022C
         bsr   L0228
L0228    lda   #':
         bsr   ApndA
L022C    ldb   ,x+
         lda   #$2F
L0230    inca  
         subb  #$64
         bcc   L0230
         cmpa  #$30
         beq   L023B
         bsr   ApndA
L023B    lda   #$3A
L023D    deca  
         addb  #$0A
         bcc   L023D
         bsr   ApndA
         tfr   b,a
         adda  #'0
         bra   ApndA

         emod
eom      equ   *
         end
