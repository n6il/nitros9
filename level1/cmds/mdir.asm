********************************************************************
* Mdir - Show module directory
*
* $Id$
*
* Ed.    Comments                                       Who YY/MM/DD
* ------------------------------------------------------------------
*   5    From Tandy OS-9 Level One VR 02.00.00
*   6    Changed option to -e, optimized slightly       BGP 03/01/14

         nam   Mdir
         ttl   Show module directory

* Disassembled 02/04/05 12:49:18 by Disasm v1.6 (C) 1988 by RML

         ifp1
         use   defsfile
         endc

tylg     set   Prgrm+Objct   
atrv     set   ReEnt+rev
rev      set   $01
edition  set   6
stdout   set   1

         mod   eom,name,tylg,atrv,start,size

         org   0
mdstart  rmb   2
mdend    rmb   2
parmptr  rmb   2
u0006    rmb   1
bufptr   rmb   1
u0008    rmb   1
datebuf  rmb   3
timebuf  rmb   3
u000F    rmb   1
u0010    rmb   1
narrow   rmb   1
buffer   rmb   530
size     equ   .

name     fcs   /Mdir/
         fcb   edition

tophead  fcb   C$LF
         fcc   "  Module directory at "
topheadl equ   *-tophead
ltitle   fcb   C$LF
         fcc   "Addr Size Typ Rev Attr Use Module name"
         fcb   C$LF
         fcc   "---- ---- --- --- ---- --- ------------"
         fcb   C$CR
stitle   fcb   C$LF
         fcc   "Addr Size Ty Rv At Uc   Name"
         fcb   C$LF
         fcc   "---- ---- -- -- -- -- ---------"
         fcb   C$CR

start    stx   <parmptr
         ldd   #$0C30
         std   <u000F
         clr   <narrow		assume wide output
         lda   #stdout		standard output
         ldb   #SS.ScSiz	we need screen size
         os9   I$GetStt 	get it
         bcc   L00D2		branch if we got it
         cmpb  #E$UnkSvc	not a known service request error?
         lbne  Exit		if not, exit
         bra   L00DF
L00D2    cmpx  #80		80 columns?
         bge   L00DF		branch if greater or equal to
         inc   <narrow
         ldd   #$0A15
         std   <u000F
L00DF    leax  >tophead,pcr
         ldy   #topheadl
         lda   #stdout
         os9   I$WritLn 
         leax  datebuf,u
         os9   F$Time   
         leax  <buffer,u
         stx   <bufptr
         leax  timebuf,u
         lbsr  L0224
         lbsr  write
         ldx   >D.ModDir
         stx   <mdstart
         ldd   >D.ModDir+2
         std   <mdend
         leax  -$04,x
* Check for 'E' given as argument
         ldy   <parmptr
         ldd   ,y+
         andb  #$DF
         cmpd  #$2D45		-E ?	
         bne   L0157
         tst   <narrow
         bne   L0123
         leax  >ltitle,pcr
         bra   L012B
L0123    leax  >stitle,pcr
L012B    ldy   #80		max. length to write
         lda   #stdout
         os9   I$WritLn 
         ldx   <mdstart
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
         cmpx  <mdend
         bcs   loop
         lbsr  write
         bra   ExitOk
*
* A module entry is 2 two byte pointers.
* If the first pointer is $0000, then the slot is unused
L0168    leay  <buffer,u
         sty   <bufptr
         ldy   ,x
         beq   gotonxt         Is slot unused? If yes, branch
         ldd   ,x
         bsr   L01C1
         ldd   $02,y
         bsr   L01C1
         tst   <narrow
         bne   L0181
         bsr   L01F2
L0181    lda   $06,y
         bsr   L01C9
         tst   <narrow
         bne   L018B
         bsr   L01F2
L018B    lda   $07,y
         anda  #$0F
         bsr   L01C9
         ldb   $07,y
         lda   #$72
         bsr   L01FE
         tst   <narrow
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
L01B9    cmpx  <mdend
         bcs   L0168

ExitOk   clrb  
Exit     os9   F$Exit   

L01C1    bsr   Byt2Hex
         tfr   b,a
         bsr   L01CF
         bra   L01F2
L01C9    bsr   Byt2Hex
         bra   L01F2

Byt2Hex  clr   <u0006
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
         lda   #C$SPAC
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

L0224    bsr   Byt2ASC
         bsr   Colon
Colon    lda   #':
         bsr   ApndA
Byt2ASC  ldb   ,x+
         lda   #$2F		load A with '0 - 1
Hundreds inca  
         subb  #100
         bcc   Hundreds
         cmpa  #'0
         beq   Tens		no leading zeros
         bsr   ApndA
Tens     lda   #$3A		load A with '9 + 1
TensLoop deca  
         addb  #10
         bcc   TensLoop
         bsr   ApndA
         tfr   b,a
         adda  #'0
         bra   ApndA

         emod
eom      equ   *
         end
