********************************************************************
* Mdir - Display Module Directory
*
* $Id$
*
* Ed.    Comments                                       Who YY/MM/DD
* ------------------------------------------------------------------
*  2     Original Microware distribution version

         nam   Mdir
         ttl   Display Module Directory

* Disassembled 02/04/03 23:16:41 by Disasm v1.6 (C) 1988 by RML

         ifp1
         use   os9defs
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
u000F    rmb   280
size     equ   .
name     equ   *
         fcs   /Mdir/
         fcb   $03 
L0012    fcb   $0A 
         fcb   $20 
         fcb   $4D M
         fcb   $6F o
         fcb   $64 d
         fcb   $75 u
         fcb   $6C l
         fcb   $65 e
         fcb   $20 
         fcb   $44 D
         fcb   $69 i
         fcb   $72 r
         fcb   $65 e
         fcb   $63 c
         fcb   $74 t
         fcb   $6F o
         fcb   $72 r
         fcb   $79 y
         fcb   $20 
         fcb   $61 a
         fcb   $74 t
         fcb   $20 
L0028    fcb   $0A 
         fcb   $41 A
         fcb   $44 D
         fcb   $44 D
         fcb   $52 R
         fcb   $20 
         fcb   $53 S
         fcb   $49 I
         fcb   $5A Z
         fcb   $45 E
         fcb   $20 
         fcb   $54 T
         fcb   $59 Y
         fcb   $20 
         fcb   $52 R
         fcb   $56 V
         fcb   $20 
         fcb   $41 A
         fcb   $54 T
         fcb   $20 
         fcb   $55 U
         fcb   $43 C
         fcb   $20 
         fcb   $20 
         fcb   $20 
         fcb   $4E N
         fcb   $41 A
         fcb   $4D M
         fcb   $45 E
         fcb   $0A 
         fcb   $2D -
         fcb   $2D -
         fcb   $2D -
         fcb   $2D -
         fcb   $20 
         fcb   $2D -
         fcb   $2D -
         fcb   $2D -
         fcb   $2D -
         fcb   $20 
         fcb   $2D -
         fcb   $2D -
         fcb   $20 
         fcb   $2D -
         fcb   $2D -
         fcb   $20 
         fcb   $2D -
         fcb   $2D -
         fcb   $20 
         fcb   $2D -
         fcb   $2D -
         fcb   $20 
         fcb   $2D -
         fcb   $2D -
         fcb   $2D -
         fcb   $2D -
         fcb   $2D -
         fcb   $2D -
         fcb   $2D -
         fcb   $2D -
         fcb   $2D -
         fcb   $0D 
start    equ   *
         stx   <u0004
         leax  <L0012,pcr
         ldy   #$0016
         lda   #$01
         os9   I$WritLn 
         leax  u0009,u
         os9   F$Time   
         leax  u000F,u
         stx   <u0007
         leax  u000C,u
         lbsr  L017D
         lbsr  L016A
         ldx   >$0026
         stx   <u0000
         ldd   >$0028
         std   <u0002
         leax  -$04,x
         ldy   <u0004
         lda   ,y+
         eora  #$45
         anda  #$DF
         bne   L00CF
         leax  >L0028,pcr
         ldy   #$003E
         lda   #$01
         os9   I$WritLn 
         ldx   <u0000
         bra   L0113
L00AD    ldy   ,x
         beq   L00D4
         ldd   $04,y
         leay  d,y
         lbsr  L015F
L00B9    lbsr  L014C
         ldb   <u0008
         subb  #$0F
         cmpb  #$15
         bhi   L00CC
L00C4    subb  #$0A
         bhi   L00C4
         bne   L00B9
         bra   L00D4
L00CC    lbsr  L016A
L00CF    leay  u000F,u
         sty   <u0007
L00D4    leax  $04,x
         cmpx  <u0002
         bcs   L00AD
         lbsr  L016A
         bra   L0117
L00DF    leay  u000F,u
         sty   <u0007
         ldy   ,x
         beq   L0111
         ldd   ,x
         bsr   L011B
         ldd   $02,y
         bsr   L011B
         lda   $06,y
         bsr   L0123
         lda   $07,y
         anda  #$0F
         bsr   L0123
         ldb   $07,y
         lda   #$72
         bsr   L0158
         bsr   L014C
         bsr   L014C
         lda   $02,x
         bsr   L0123
         ldd   $04,y
         leay  d,y
         bsr   L015F
         bsr   L016A
L0111    leax  $04,x
L0113    cmpx  <u0002
         bcs   L00DF
L0117    clrb  
         os9   F$Exit   
L011B    bsr   L0127
         tfr   b,a
         bsr   L0129
         bra   L014C
L0123    bsr   L0127
         bra   L014C
L0127    clr   <u0006
L0129    pshs  a
         lsra  
         lsra  
         lsra  
         lsra  
         bsr   L0135
         lda   ,s+
         anda  #$0F
L0135    tsta  
         beq   L013A
         sta   <u0006
L013A    tst   <u0006
         bne   L0142
         lda   #$20
         bra   L014E
L0142    adda  #$30
         cmpa  #$39
         bls   L014E
         adda  #$07
         bra   L014E
L014C    lda   #$20
L014E    pshs  x
         ldx   <u0007
         sta   ,x+
         stx   <u0007
         puls  pc,x
L0158    rolb  
         bcs   L014E
         lda   #$2E
         bra   L014E
L015F    lda   ,y
         anda  #$7F
         bsr   L014E
         lda   ,y+
         bpl   L015F
         rts   
L016A    pshs  y,x,a
         lda   #$0D
         bsr   L014E
         leax  u000F,u
         ldy   #$0050
         lda   #$01
         os9   I$WritLn 
         puls  pc,y,x,a
L017D    bsr   L0185
         bsr   L0181
L0181    lda   #$3A
         bsr   L014E
L0185    ldb   ,x+
         lda   #$2F
L0189    inca  
         subb  #$64
         bcc   L0189
         cmpa  #$30
         beq   L0194
         bsr   L014E
L0194    lda   #$3A
L0196    deca  
         addb  #$0A
         bcc   L0196
         bsr   L014E
         tfr   b,a
         adda  #$30
         bra   L014E
         emod
eom      equ   *
