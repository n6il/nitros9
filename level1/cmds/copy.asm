********************************************************************
* Copy - Copy data from one path to another
*
* $Id$
*
* Ed.    Comments                                       Who YY/MM/DD
* ------------------------------------------------------------------
*  7     Original Microware distribution version

         nam   Copy
         ttl   Copy data from one path to another

* Disassembled 02/04/03 23:12:01 by Disasm v1.6 (C) 1988 by RML

         ifp1
         use   os9defs
         endc
tylg     set   Prgrm+Objct   
atrv     set   ReEnt+rev
rev      set   $01
         mod   eom,name,tylg,atrv,start,size
u0000    rmb   1
u0001    rmb   1
u0002    rmb   1
u0003    rmb   1
u0004    rmb   2
u0006    rmb   2
u0008    rmb   2
u000A    rmb   2
u000C    rmb   2
u000E    rmb   1
u000F    rmb   1
u0010    rmb   496
u0200    rmb   256
u0300    rmb   4096
size     equ   .
name     equ   *
         fcs   /Copy/
         fcb   $07 
L0012    fcb   $52 R
         fcb   $65 e
         fcb   $61 a
         fcb   $64 d
         fcb   $79 y
         fcb   $20 
         fcb   $53 S
         fcb   $4F O
         fcb   $55 U
         fcb   $52 R
         fcb   $43 C
         fcb   $45 E
         fcb   $2C ,
         fcb   $20 
         fcb   $68 h
         fcb   $69 i
         fcb   $74 t
         fcb   $20 
         fcb   $43 C
         fcb   $20 
         fcb   $74 t
         fcb   $6F o
         fcb   $20 
         fcb   $63 c
         fcb   $6F o
         fcb   $6E n
         fcb   $74 t
         fcb   $69 i
         fcb   $6E n
         fcb   $75 u
         fcb   $65 e
         fcb   $3A :
         fcb   $20 
L0033    fcb   $52 R
         fcb   $65 e
         fcb   $61 a
         fcb   $64 d
         fcb   $79 y
         fcb   $20 
         fcb   $44 D
         fcb   $45 E
         fcb   $53 S
         fcb   $54 T
         fcb   $49 I
         fcb   $4E N
         fcb   $41 A
         fcb   $54 T
         fcb   $49 I
         fcb   $4F O
         fcb   $4E N
         fcb   $2C ,
         fcb   $20 
         fcb   $68 h
         fcb   $69 i
         fcb   $74 t
         fcb   $20 
         fcb   $43 C
         fcb   $20 
         fcb   $74 t
         fcb   $6F o
         fcb   $20 
         fcb   $63 c
         fcb   $6F o
         fcb   $6E n
         fcb   $74 t
         fcb   $69 i
         fcb   $6E n
         fcb   $75 u
         fcb   $65 e
         fcb   $3A :
         fcb   $20 
L0059    fcb   $0D 
L005A    fcb   $55 U
         fcb   $73 s
         fcb   $65 e
         fcb   $3A :
         fcb   $20 
         fcb   $43 C
         fcb   $6F o
         fcb   $70 p
         fcb   $79 y
         fcb   $20 
         fcb   $3C <
         fcb   $50 P
         fcb   $61 a
         fcb   $74 t
         fcb   $68 h
         fcb   $31 1
         fcb   $3E >
         fcb   $20 
         fcb   $3C <
         fcb   $50 P
         fcb   $61 a
         fcb   $74 t
         fcb   $68 h
         fcb   $32 2
         fcb   $3E >
         fcb   $20 
         fcb   $5B [
         fcb   $2D -
         fcb   $73 s
         fcb   $5D ]
         fcb   $0A 
         fcb   $20 
         fcb   $20 
         fcb   $2D -
         fcb   $73 s
         fcb   $20 
         fcb   $3D =
         fcb   $20 
         fcb   $73 s
         fcb   $69 i
         fcb   $6E n
         fcb   $67 g
         fcb   $6C l
         fcb   $65 e
         fcb   $20 
         fcb   $64 d
         fcb   $72 r
         fcb   $69 i
         fcb   $76 v
         fcb   $65 e
         fcb   $20 
         fcb   $63 c
         fcb   $6F o
         fcb   $70 p
         fcb   $79 y
         fcb   $20 
         fcb   $28 (
         fcb   $50 P
         fcb   $61 a
         fcb   $74 t
         fcb   $68 h
         fcb   $32 2
         fcb   $20 
         fcb   $6D m
         fcb   $75 u
         fcb   $73 s
         fcb   $74 t
         fcb   $20 
         fcb   $62 b
         fcb   $65 e
         fcb   $20 
         fcb   $63 c
         fcb   $6F o
         fcb   $6D m
         fcb   $70 p
         fcb   $6C l
         fcb   $65 e
         fcb   $74 t
         fcb   $65 e
         fcb   $20 
         fcb   $70 p
         fcb   $61 a
         fcb   $74 t
         fcb   $68 h
         fcb   $6C l
         fcb   $69 i
         fcb   $73 s
         fcb   $74 t
         fcb   $29 )
         fcb   $0D 
L00B4    fcb   $07 
         fcb   $45 E
         fcb   $72 r
         fcb   $72 r
         fcb   $6F o
         fcb   $72 r
         fcb   $20 
         fcb   $2D -
         fcb   $20 
         fcb   $77 w
         fcb   $72 r
         fcb   $69 i
         fcb   $74 t
         fcb   $65 e
         fcb   $20 
         fcb   $76 v
         fcb   $65 e
         fcb   $72 r
         fcb   $69 i
         fcb   $66 f
         fcb   $69 i
         fcb   $63 c
         fcb   $61 a
         fcb   $74 t
         fcb   $69 i
         fcb   $6F o
         fcb   $6E n
         fcb   $20 
         fcb   $66 f
         fcb   $61 a
         fcb   $69 i
         fcb   $6C l
         fcb   $65 e
         fcb   $64 d
         fcb   $2E .
         fcb   $0D 
start    equ   *
         leas  >u0200,u
         pshs  u
         leau  <u0010,u
L00E1    clr   ,-u
         cmpu  ,s
         bhi   L00E1
         tfr   y,d
         subd  ,s++
         subd  #$0300
         clrb  
         std   <u0004
         pshs  x
L00F4    lda   ,x+
         cmpa  #$2D
         beq   L0100
         cmpa  #$0D
         bne   L00F4
         bra   L0113
L0100    ldd   ,x+
         eora  #$53
         anda  #$DF
         bne   L0110
         cmpb  #$30
         bcc   L0110
         inc   <u000E
         bra   L00F4
L0110    lbra  L0276
L0113    puls  x
         lda   #$01
         os9   I$Open   
         bcc   L0125
         cmpb  #$D7
         lbeq  L0276
         lbra  L027D
L0125    sta   <u0000
         tst   <u000E
         beq   L0135
         lda   ,x
         ldb   #$D7
         cmpa  #$2F
         lbne  L027D
L0135    pshs  x
         lda   <u0000
         leax  <u0010,u
         ldb   #$00
         os9   I$GetStt 
         lbcs  L027D
         lda   ,x
         sta   <u0002
         ldb   #$0F
         cmpa  #$01
         bne   L0165
         pshs  u,x
         lda   <u0000
         ldb   #$02
         os9   I$GetStt 
         lbcs  L027D
         stx   <u0006
         stu   <u0008
         puls  u,x
         ldb   <$13,x
L0165    stb   <u000F
         puls  x
         lda   #$01
         lbsr  L028A
         lda   #$03
         ldb   <u000F
         os9   I$Create 
         bcc   L0184
         inc   <u0003
         lda   #$02
         ldb   <u000F
         os9   I$Create 
         lbcs  L027D
L0184    sta   <u0001
         leax  <u0010,u
         ldb   #$00
         os9   I$GetStt 
         lbcs  L027D
         ldb   ,x
         cmpb  #$01
         beq   L019C
         inc   <u0003
         bra   L01DD
L019C    tst   <u0003
         bne   L01AD
         ldb   #$01
         stb   $08,x
         ldb   #$00
         os9   I$SetStt 
         lbcs  L027D
L01AD    lda   <u0002
         cmpa  #$01
         bne   L01DD
         pshs  u
         lda   <u0001
         ldb   #$02
         ldx   <u0006
         ldu   <u0008
         os9   I$SetStt 
         lbcs  L027D
         puls  u
         leax  <u0010,u
         ldy   #$0010
         lda   <u0000
         ldb   #$0F
         os9   I$GetStt 
         bcs   L01DD
         lda   <u0001
         ldb   #$0F
         os9   I$SetStt 
L01DD    leax  >u0300,u
         clra  
         lbsr  L028A
         lda   <u0000
         ldy   <u0004
         os9   I$Read   
         bcs   L025A
         lda   #$01
         lbsr  L028A
         lda   <u0001
         os9   I$Write  
         lbcs  L027D
         tst   <u0003
         bne   L024D
         pshs  u,y
         ldx   <u000A
         ldu   <u000C
         lda   <u0001
         os9   I$Seek   
         bcs   L027D
         ldu   $02,s
         leau  >u0300,u
         ldd   ,s
         addd  <u000C
         std   <u000C
         ldd   ,s
         bcc   L0222
         leax  $01,x
         stx   <u000A
L0222    ldy   #$0100
         std   ,s
         tsta  
         bne   L022D
         tfr   d,y
L022D    ldx   $02,s
         leax  >$0200,x
         lda   <u0001
         os9   I$Read   
         bcs   L027D
L023A    lda   ,u+
         cmpa  ,x+
         bne   L026B
         leay  -$01,y
         bne   L023A
         ldd   ,s
         subd  #$0100
         bhi   L0222
         puls  u,y
L024D    lda   <u0000
         ldb   #$06
         os9   I$GetStt 
         bcc   L01DD
         cmpb  #$D3
         beq   L0262
L025A    cmpb  #$D3
         bne   L027D
         lda   #$01
         bsr   L028A
L0262    lda   <u0001
         os9   I$Close  
         bcc   L027C
         bra   L027D
L026B    leax  >L00B4,pcr
         bsr   L0280
         comb  
         ldb   #$01
         bra   L027D
L0276    leax  >L005A,pcr
         bsr   L0280
L027C    clrb  
L027D    os9   F$Exit   
L0280    ldy   #$0100
L0284    lda   #$01
         os9   I$WritLn 
         rts   
L028A    tst   <u000E
         beq   L02C7
         pshs  y,x
L0290    pshs  a
         tsta  
         bne   L029F
         leax  >L0012,pcr
         ldy   #$0021
         bra   L02A7
L029F    leax  >L0033,pcr
         ldy   #$0026
L02A7    bsr   L0284
         leax  ,-s
         ldy   #$0001
         clra  
         os9   I$Read   
         lda   ,s+
         eora  #$43
         anda  #$DF
         beq   L02C1
         bsr   L02C8
         puls  a
         bne   L0290
L02C1    bsr   L02C8
         puls  a
         puls  y,x
L02C7    rts   
L02C8    pshs  y,x,a
         lda   #$01
         leax  >L0059,pcr
         ldy   #$0050
         os9   I$WritLn 
         puls  pc,y,x,a
         emod
eom      equ   *
