********************************************************************
* Dump - Show file contents in hex
*
* $Id$
*
* Ed.    Comments                                       Who YY/MM/DD
* ------------------------------------------------------------------
* 5      Original Tandy distribution version

         nam   Dump
         ttl   Show file contents in hex

* Disassembled 98/09/14 23:34:34 by Disasm v1.6 (C) 1988 by RML

         ifp1
         use   defsfile
         endc

tylg     set   Prgrm+Objct   
atrv     set   ReEnt+rev
rev      set   $01
edition  set   5

         mod   eom,name,tylg,atrv,start,size

u0000    rmb   1
u0001    rmb   1
u0002    rmb   1
u0003    rmb   1
u0004    rmb   1
u0005    rmb   1
u0006    rmb   2
u0008    rmb   2
u000A    rmb   2
u000C    rmb   16
u001C    rmb   5
u0021    rmb   1
u0022    rmb   16
u0032    rmb   8
u003A    rmb   17
u004B    rmb   16
u005B    rmb   201
size     equ   .

name     fcs   /Dump/
         fcb   edition
L0012    fcc   "Addr   0 1  2 3  4 5  6 7  8 9  A B  C D  E F  0 2 4 6 8 A C E"
         fcb   C$CR
L0051    fcc   "----  ---- ---- ---- ---- ---- ---- ---- ----  ----------------"
L0090    fcb   C$CR
L0091    fcb   C$LF
         fcb   C$LF
         fcb   C$LF
         fcb   C$LF
	 fcc   "     0 1 2 3 4 5 6 7  0 2 4 6"
         fcb   C$LF
         fcc   "ADDR 8 9 A B C D E F  8 A C E""
         fcb   C$CR
L00D1    fcc   "==== +-+-+-+-+-+-+-+- + + + + "
         fcb   C$CR

L00F0    lda   ,x+
         cmpa  #C$SPAC
         beq   L00F0
         leax  -1,x
         cmpa  #C$CR
         rts

start    lda   #63
         sta   <u000A
         clr   <u0000
         pshs  y,x,b,a
         lda   #1
         ldb   #SS.ScSiz
         os9   I$GetStt  get size of window
         bcc   L0115
         cmpb  #E$UnkSvc
         beq   L0120
         puls  y,x,b,a
         lbra  L01FE
L0115    cmpx  #80
         beq   L0120
         ldb   #31
         stb   <u000A
         inc   <u0000
L0120    puls  y,x,b,a
         ldd   #$0001
         std   <u0001
         bsr   L00F0
         beq   L0147
         lda   #READ.
         os9   I$Open   
         lbcs  L01FE
         sta   <u0001
         bsr   L00F0
         beq   L0147
         lda   #WRITE.
         ldb   #PREAD.+UPDAT.
         os9   I$Create 
         lbcs  L01FE
         sta   <u0002
L0147    ldd   #$0000
L014A    std   <u0003
         tst   <u0000
         beq   L0156
         bitb  #$3F
         bne   L017D
         bra   L0159
L0156    tstb  
         bne   L017D
L0159    leax  >L0090,pcr
         lbsr  L01EF
         leax  >L0012,pcr
         tst   <u0000
         beq   L016C
         leax  >L0091,pcr
L016C    lbsr  L01EF
         leax  >L0051,pcr
         tst   <u0000
         beq   L017B
         leax  >L00D1,pcr
L017B    bsr   L01EF
L017D    leax  <u001C,u
         lda   #$20
         ldb   <u000A
L0184    sta   ,x+
         decb  
         bne   L0184
         leax  <u001C,u
         stx   <u0006
         lda   <u0003
         bsr   L0201
         lda   <u0004
         bsr   L0201
         leax  <u0022,u
         stx   <u0006
         leax  <u004B,u
         stx   <u0008
         ldy   #$0010
         tst   <u0000
         beq   L01B6
         leax  <u0021,u
         stx   <u0006
         leax  <u0032,u
         stx   <u0008
         ldy   #$0008
L01B6    leax  u000C,u
         lda   <u0001
         os9   I$Read   
         bcs   L01F9
         tfr   y,d
         stb   <u0005
L01C3    bsr   L0223
         decb  
         beq   L01D5
         bsr   L0223
         tst   <u0000
         bne   L01D2
         lda   #$20
         bsr   L0219
L01D2    decb  
         bne   L01C3
L01D5    lda   #$0D
         sta   <u005B
         tst   <u0000
         beq   L01DF
         sta   <u003A
L01DF    leax  <u001C,u
         bsr   L01EF
         bcs   L01FE
         ldd   <u0003
         addb  <u0005
         adca  #$00
         lbra  L014A
L01EF    ldy   #$0050
         lda   <u0002
         os9   I$WritLn 
         rts   
L01F9    cmpb  #E$EOF
         bne   L01FE
         clrb  
L01FE    os9   F$Exit   
L0201    pshs  a
         lsra  
         lsra  
         lsra  
         lsra  
         bsr   L020F
         lda   ,s
         bsr   L020F
         puls  pc,a
L020F    anda  #$0F
         cmpa  #$09
         bls   L0217
         adda  #$07
L0217    adda  #$30
L0219    pshs  x
         ldx   <u0006
         sta   ,x+
         stx   <u0006
         puls  pc,x
L0223    lda   ,x+
         bsr   L0201
         pshs  x,a
         anda  #$7F
         cmpa  #$20
         bcs   L0233
         cmpa  #$7E
         bcs   L0235
L0233    lda   #$2E
L0235    ldx   <u0008
         sta   ,x+
         stx   <u0008
         puls  pc,x,a

         emod
eom      equ   *
         end
