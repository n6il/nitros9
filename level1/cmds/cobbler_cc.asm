********************************************************************
* Cobble - Make a bootstrap file
*
* $Id$
*
* Ed.    Comments                                       Who YY/MM/DD
* ------------------------------------------------------------------
* 5      Original Tandy distribution version

         nam   Cobbler
         ttl   Make a bootstrap file

* Disassembled 02/07/06 23:26:00 by Disasm v1.6 (C) 1988 by RML

         ifp1
         use   defsfile
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
u0009    rmb   7
u0010    rmb   3
u0013    rmb   17
u0024    rmb   2
u0026    rmb   10
u0030    rmb   2
u0032    rmb   32
u0052    rmb   16
u0062    rmb   1
u0063    rmb   7
u006A    rmb   432
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
         fcb   $4F O
         fcb   $42 B
         fcb   $42 B
         fcb   $4C L
         fcb   $45 E
         fcb   $52 R
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
L004F    fcb   $0A 
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
L006B    fcb   $0A 
         fcb   $45 E
         fcb   $72 r
         fcb   $72 r
         fcb   $6F o
         fcb   $72 r
         fcb   $20 
         fcb   $2D -
         fcb   $20 
         fcb   $63 c
         fcb   $61 a
         fcb   $6E n
         fcb   $6E n
         fcb   $6F o
         fcb   $74 t
         fcb   $20 
         fcb   $67 g
         fcb   $65 e
         fcb   $6E n
         fcb   $20 
         fcb   $74 t
         fcb   $6F o
         fcb   $20 
         fcb   $68 h
         fcb   $61 a
         fcb   $72 r
         fcb   $64 d
         fcb   $20 
         fcb   $64 d
         fcb   $69 i
         fcb   $73 s
         fcb   $6B k
         fcb   $0D 
L008C    fcb   $0A 
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
         fcb   $66 f
         fcb   $69 i
         fcb   $6C l
         fcb   $65 e
         fcb   $28 (
         fcb   $73 s
         fcb   $29 )
         fcb   $20 
         fcb   $70 p
         fcb   $72 r
         fcb   $65 e
         fcb   $73 s
         fcb   $65 e
         fcb   $6E n
         fcb   $74 t
         fcb   $0A 
         fcb   $6F o
         fcb   $6E n
         fcb   $20 
         fcb   $74 t
         fcb   $72 r
         fcb   $61 a
         fcb   $63 c
         fcb   $6B k
         fcb   $20 
         fcb   $33 3
         fcb   $34 4
         fcb   $20 
         fcb   $2D -
         fcb   $20 
         fcb   $74 t
         fcb   $68 h
         fcb   $69 i
         fcb   $73 s
         fcb   $20 
         fcb   $74 t
         fcb   $72 r
         fcb   $61 a
         fcb   $63 c
         fcb   $6B k
         fcb   $0A 
         fcb   $6E n
         fcb   $6F o
         fcb   $74 t
         fcb   $20 
         fcb   $72 r
         fcb   $65 e
         fcb   $77 w
         fcb   $72 r
         fcb   $69 i
         fcb   $74 t
         fcb   $74 t
         fcb   $65 e
         fcb   $6E n
         fcb   $2E .
         fcb   $0D 
L00CF    fcb   $0A 
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
         fcb   $0D 
L00F0    fcb   $4F O
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
         lbne  L02CA
         os9   F$PrsNam 
         lbcs  L02CA
         lda   #$2F
         cmpa  ,y
         lbeq  L02CA
         leay  <u0032,u
L0114    sta   ,y+
         lda   ,x+
         decb  
         bpl   L0114
         sty   <u0030
         lda   #$40
         ldb   #$20
         std   ,y++
         leax  <u0032,u
         lda   #$03
         os9   I$Open   
         sta   <u0001
         lbcs  L02CA
         ldx   <u0030
         leay  >L00F0,pcr
         lda   #$2F
L013A    sta   ,x+
         lda   ,y+
         bpl   L013A
         lda   <u0001
         leax  <u0010,u
         ldb   #$00
         os9   I$GetStt 
         lbcs  L02DC
         leax  <u0010,u
         lda   <u0013,u
         bpl   L015E
         leax  >L006B,pcr
         clrb  
         lbra  L02CE
L015E    lda   <u0001
         pshs  u
         ldx   #$0000
         ldu   #$0015
         os9   I$Seek   
         puls  u
         lbcs  L02DC
         leax  u0004,u
         ldy   #$0005
         os9   I$Read   
         lbcs  L02DC
         ldd   <u0007
         beq   L0193
         leax  <u0032,u
         os9   I$Delete 
         clra  
         clrb  
         sta   <u0004
         std   <u0005
         std   <u0007
         lbsr  L02F4
L0193    lda   #$02
         ldb   #$03
         leax  <u0032,u
         os9   I$Create 
         sta   <u0000
         lbcs  L02DC
         ldd   >$0068
         subd  >$0066
         tfr   d,y
         std   <u0007
         ldx   >$0066
         lda   <u0000
         os9   I$Write  
         lbcs  L02DC
         leax  <u0010,u
         ldb   #$00
         os9   I$GetStt 
         lbcs  L02DC
         lda   <u0000
         os9   I$Close  
         lbcs  L02CA
         pshs  u
         ldx   <u0024,u
         lda   <u0026,u
         clrb  
         tfr   d,u
         lda   <u0001
         os9   I$Seek   
         puls  u
         lbcs  L02DC
         leax  <u0052,u
         ldy   #$0100
         os9   I$Read   
         lbcs  L02DC
         ldd   <u006A,u
         lbne  L02DF
         ldb   <u0062,u
         stb   <u0004
         ldd   <u0063,u
         std   <u0005
         lbsr  L02F4
         lbsr  L02BB
         leax  <u0052,u
         ldy   #$0100
         os9   I$Read   
         lbcs  L02CE
         leax  <u0052,u
         lda   <$4C,x
         bita  #$0F
         beq   L0273
         lda   <u0001
         pshs  u
         ldx   #$0002
         ldu   #$6400
         os9   I$Seek   
         puls  u
         leax  u0009,u
         ldy   #$0007
         os9   I$Read   
         lbcs  L02ED
         leax  u0009,u
         ldd   ,x
         cmpa  #$4F
         lbne  L02ED
         cmpb  #$53
         lbne  L02ED
         lda   $04,x
         cmpa  #$12
         beq   L025C
         lda   <$4E,x
         bita  #$1C
         lbne  L02ED
L025C    lda   <$4C,x
         ora   #$0F
         sta   <$4C,x
         lda   #$FF
         sta   <$4D,x
         lda   <$4E,x
         ora   #$FC
         sta   <$4E,x
         bra   L028C
L0273    ora   #$0F
         sta   <$4C,x
         tst   <$4D,x
         bne   L02ED
         com   <$4D,x
         lda   <$4E,x
         bita  #$FC
         bne   L02ED
         ora   #$FC
         sta   <$4E,x
L028C    bsr   L02BB
         leax  <u0052,u
         ldy   #$0064
         os9   I$Write  
         bcs   L02CE
         pshs  u
         ldx   #$0002
         ldu   #$6400
         os9   I$Seek   
         puls  u
         ldx   #$EF00
         ldy   #$0F80
         os9   I$Write  
         bcs   L02E6
         os9   I$Close  
         bcs   L02CA
         clrb  
         bra   L02DC
L02BB    pshs  u
         lda   <u0001
         ldx   #$0000
         ldu   #$0100
         os9   I$Seek   
         puls  pc,u
L02CA    leax  >L0015,pcr
L02CE    pshs  b
         lda   #$02
         ldy   #$0100
         os9   I$WritLn 
         comb  
         puls  b
L02DC    os9   F$Exit   
L02DF    leax  >L00CF,pcr
         clrb  
         bra   L02CE
L02E6    leax  >L004F,pcr
         clrb  
         bra   L02CE
L02ED    leax  >L008C,pcr
         clrb  
         bra   L02CE
L02F4    pshs  u
         ldx   #$0000
         ldu   #$0015
         lda   <u0001
         os9   I$Seek   
         puls  u
         bcs   L02DC
         leax  u0004,u
         ldy   #$0005
         os9   I$Write  
         bcs   L02DC
         rts   
         emod
eom      equ   *
