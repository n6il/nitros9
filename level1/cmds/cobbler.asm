********************************************************************
* Cobbler - Make a bootstrap file
*
* $Id$
*
* Ed.    Comments                                       Who YY/MM/DD
* ------------------------------------------------------------------
*  5     Original Microware distribution version

         nam   Cobbler
         ttl   Make a bootstrap file

* Disassembled 02/04/03 23:11:02 by Disasm v1.6 (C) 1988 by RML

         ifp1
         use   os9defs
         endc
tylg     set   Prgrm+Objct   
atrv     set   ReEnt+rev
rev      set   $01
         mod   eom,name,tylg,atrv,start,size
u0000    rmb   1
u0001    rmb   3
u0004    rmb   1
u0005    rmb   2
u0007    rmb   2
u0009    rmb   20
u001D    rmb   2
u001F    rmb   10
u0029    rmb   2
u002B    rmb   32
u004B    rmb   16
u005B    rmb   1
u005C    rmb   7
u0063    rmb   682
size     equ   .
name     equ   *
         fcs   /Cobbler/
         fcb   $05 
L0015    fcb   $0A 
         fcb   $55 U
         fcb   $73 s
         fcb   $65 e
         fcb   $3A :
         fcb   $20 
         fcb   $43 C
         fcb   $6F o
         fcb   $62 b
         fcb   $62 b
         fcb   $6C l
         fcb   $65 e
         fcb   $72 r
         fcb   $20 
         fcb   $3C <
         fcb   $2F /
         fcb   $64 d
         fcb   $65 e
         fcb   $76 v
         fcb   $6E n
         fcb   $61 a
         fcb   $6D m
         fcb   $65 e
         fcb   $3E >
         fcb   $0A 
         fcb   $20 
         fcb   $20 
         fcb   $20 
         fcb   $20 
         fcb   $74 t
         fcb   $6F o
         fcb   $20 
         fcb   $63 c
         fcb   $72 r
         fcb   $65 e
         fcb   $61 a
         fcb   $74 t
         fcb   $65 e
         fcb   $20 
         fcb   $61 a
         fcb   $20 
         fcb   $6E n
         fcb   $65 e
         fcb   $77 w
         fcb   $20 
         fcb   $73 s
         fcb   $79 y
         fcb   $73 s
         fcb   $74 t
         fcb   $65 e
         fcb   $6D m
         fcb   $20 
         fcb   $64 d
         fcb   $69 i
         fcb   $73 s
         fcb   $6B k
         fcb   $0D 
L004E    fcb   $0A 
         fcb   $45 E
         fcb   $72 r
         fcb   $72 r
         fcb   $6F o
         fcb   $72 r
         fcb   $20 
         fcb   $77 w
         fcb   $72 r
         fcb   $69 i
         fcb   $74 t
         fcb   $69 i
         fcb   $6E n
         fcb   $67 g
         fcb   $20 
         fcb   $6B k
         fcb   $65 e
         fcb   $72 r
         fcb   $6E n
         fcb   $65 e
         fcb   $6C l
         fcb   $20 
         fcb   $74 t
         fcb   $72 r
         fcb   $61 a
         fcb   $63 c
         fcb   $6B k
         fcb   $0D 
L006A    fcb   $0A 
         fcb   $57 W
         fcb   $61 a
         fcb   $72 r
         fcb   $6E n
         fcb   $69 i
         fcb   $6E n
         fcb   $67 g
         fcb   $20 
         fcb   $2D -
         fcb   $20 
         fcb   $4B K
         fcb   $65 e
         fcb   $72 r
         fcb   $6E n
         fcb   $65 e
         fcb   $6C l
         fcb   $20 
         fcb   $74 t
         fcb   $72 r
         fcb   $61 a
         fcb   $63 c
         fcb   $6B k
         fcb   $20 
         fcb   $68 h
         fcb   $61 a
         fcb   $73 s
         fcb   $0A 
         fcb   $6E n
         fcb   $6F o
         fcb   $74 t
         fcb   $20 
         fcb   $62 b
         fcb   $65 e
         fcb   $65 e
         fcb   $6E n
         fcb   $20 
         fcb   $61 a
         fcb   $6C l
         fcb   $6C l
         fcb   $6F o
         fcb   $63 c
         fcb   $61 a
         fcb   $74 t
         fcb   $65 e
         fcb   $64 d
         fcb   $20 
         fcb   $70 p
         fcb   $72 r
         fcb   $6F o
         fcb   $70 p
         fcb   $65 e
         fcb   $72 r
         fcb   $6C l
         fcb   $79 y
         fcb   $2E .
         fcb   $0A 
         fcb   $54 T
         fcb   $72 r
         fcb   $61 a
         fcb   $63 c
         fcb   $6B k
         fcb   $20 
         fcb   $6E n
         fcb   $6F o
         fcb   $74 t
         fcb   $20 
         fcb   $77 w
         fcb   $72 r
         fcb   $69 i
         fcb   $74 t
         fcb   $74 t
         fcb   $65 e
         fcb   $6E n
         fcb   $2E .
         fcb   $0D 
L00B6    fcb   $0A 
         fcb   $45 E
         fcb   $72 r
         fcb   $72 r
         fcb   $6F o
         fcb   $72 r
         fcb   $20 
         fcb   $2D -
         fcb   $20 
         fcb   $4F O
         fcb   $53 S
         fcb   $39 9
         fcb   $62 b
         fcb   $6F o
         fcb   $6F o
         fcb   $74 t
         fcb   $20 
         fcb   $66 f
         fcb   $69 i
         fcb   $6C l
         fcb   $65 e
         fcb   $20 
         fcb   $66 f
         fcb   $72 r
         fcb   $61 a
         fcb   $67 g
         fcb   $6D m
         fcb   $65 e
         fcb   $6E n
         fcb   $74 t
         fcb   $65 e
         fcb   $64 d
         fcb   $0A 
         fcb   $20 
         fcb   $54 T
         fcb   $68 h
         fcb   $69 i
         fcb   $73 s
         fcb   $20 
         fcb   $64 d
         fcb   $69 i
         fcb   $73 s
         fcb   $6B k
         fcb   $20 
         fcb   $77 w
         fcb   $69 i
         fcb   $6C l
         fcb   $6C l
         fcb   $20 
         fcb   $6E n
         fcb   $6F o
         fcb   $74 t
         fcb   $20 
         fcb   $62 b
         fcb   $6F o
         fcb   $6F o
         fcb   $74 t
         fcb   $73 s
         fcb   $74 t
         fcb   $72 r
         fcb   $61 a
         fcb   $70 p
         fcb   $2E .
         fcb   $0D 
L00F6    fcb   $4F O
         fcb   $53 S
         fcb   $39 9
         fcb   $42 B
         fcb   $6F o
         fcb   $6F o
         fcb   $74 t
         fcb   $20 
         fcb   $FF 
start    equ   *
         clrb  
         lda   #$2F
         cmpa  ,x
         lbne  L0237
         os9   F$PrsNam 
         lbcs  L0237
         lda   #$2F
         cmpa  ,y
         lbeq  L0237
         leay  <u002B,u
L011A    sta   ,y+
         lda   ,x+
         decb  
         bpl   L011A
         sty   <u0029
         lda   #$40
         ldb   #$20
         std   ,y++
         leax  <u002B,u
         lda   #$03
         os9   I$Open   
         sta   <u0001
         lbcs  L0237
         ldx   <u0029
         leay  >L00F6,pcr
         lda   #$2F
L0140    sta   ,x+
         lda   ,y+
         bpl   L0140
         lda   <u0001
         pshs  u
         ldx   #$0000
         ldu   #$0015
         os9   I$Seek   
         puls  u
         lbcs  L0249
         leax  u0004,u
         ldy   #$0005
         os9   I$Read   
         lbcs  L0249
         ldd   <u0007
         beq   L017B
         leax  <u002B,u
         os9   I$Delete 
         clra  
         clrb  
         sta   <u0004
         std   <u0005
         std   <u0007
         lbsr  L0261
L017B    lda   #$02
         ldb   #$03
         leax  <u002B,u
         os9   I$Create 
         sta   <u0000
         lbcs  L0249
         ldd   >$0068
         subd  >$0066
         tfr   d,y
         std   <u0007
         ldx   >$0066
         lda   <u0000
         os9   I$Write  
         lbcs  L0249
         leax  u0009,u
         ldb   #$00
         os9   I$GetStt 
         lbcs  L0249
         lda   <u0000
         os9   I$Close  
         lbcs  L0237
         pshs  u
         ldx   <u001D,u
         lda   <u001F,u
         clrb  
         tfr   d,u
         lda   <u0001
         os9   I$Seek   
         puls  u
         lbcs  L0249
         leax  <u004B,u
         ldy   #$0100
         os9   I$Read   
         lbcs  L0249
         ldd   <u0063,u
         lbne  L024C
         ldb   <u005B,u
         stb   <u0004
         ldd   <u005C,u
         std   <u0005
         lbsr  L0261
         lbsr  L0228
         leax  <u004B,u
         ldy   #$0100
         os9   I$Read   
         bcs   L023B
         lda   ,x
         anda  #$3F
         eora  #$3F
         bne   L025A
         lda   $01,x
         eora  #$FF
         bne   L025A
         lda   $02,x
         anda  #$90
         eora  #$90
         bne   L025A
         ldx   #$F000
         ldy   #$0F00
         lda   <u0001
         os9   I$Write  
         bcs   L0253
         os9   I$Close  
         bcs   L0249
         clrb  
         bra   L0249
L0228    pshs  u
         lda   <u0001
         ldx   #$0000
         ldu   #$0100
         os9   I$Seek   
         puls  pc,u
L0237    leax  >L0015,pcr
L023B    pshs  b
         lda   #$02
         ldy   #$0100
         os9   I$WritLn 
         comb  
         puls  b
L0249    os9   F$Exit   
L024C    leax  >L00B6,pcr
         clrb  
         bra   L023B
L0253    leax  >L004E,pcr
         clrb  
         bra   L023B
L025A    leax  >L006A,pcr
         clrb  
         bra   L023B
L0261    pshs  u
         ldx   #$0000
         ldu   #$0015
         lda   <u0001
         os9   I$Seek   
         puls  u
         bcs   L0249
         leax  u0004,u
         ldy   #$0005
         os9   I$Write  
         bcs   L0249
         rts   
         emod
eom      equ   *
