********************************************************************
* Ident - Show module information
*
* $Id$
*
* Ed.    Comments                                       Who YY/MM/DD
* ------------------------------------------------------------------
* 7      Original Tandy/Microware version

         nam   Ident
         ttl   Show module information

* Disassembled 98/09/20 15:54:44 by Disasm v1.6 (C) 1988 by RML

         ifp1
         use   defsfile
         endc

tylg     set   Prgrm+Objct   
atrv     set   ReEnt+rev
rev      set   $01
edition  set   7

         mod   eom,name,tylg,atrv,start,size
u0000    rmb   1
u0001    rmb   1
u0002    rmb   1
u0003    rmb   1
u0004    rmb   2
u0006    rmb   2
u0008    rmb   2
u000A    rmb   1
u000B    rmb   1
u000C    rmb   1
u000D    rmb   1
u000E    rmb   2
u0010    rmb   2
u0012    rmb   1
u0013    rmb   1
u0014    rmb   1
u0015    rmb   1
u0016    rmb   1
u0017    rmb   1
u0018    rmb   1
u0019    rmb   1
u001A    rmb   1
u001B    rmb   1
u001C    rmb   2
u001E    rmb   2
u0020    rmb   2
u0022    rmb   66
u0064    rmb   14
u0072    rmb   14
u0080    rmb   33
u00A1    rmb   71
u00E8    rmb   180
u019C    rmb   2048
size     equ   .

name     fcs   /Ident/
         fcb   edition

L0013    fcb   $0A 
         fcb   $55 U
         fcb   $73 s
         fcb   $65 e
         fcb   $3A :
         fcb   $20 
         fcb   $49 I
         fcb   $64 d
         fcb   $65 e
         fcb   $6E n
         fcb   $74 t
         fcb   $20 
         fcb   $5B [
         fcb   $2D -
         fcb   $6F o
         fcb   $70 p
         fcb   $74 t
         fcb   $73 s
         fcb   $5D ]
         fcb   $20 
         fcb   $3C <
         fcb   $6D m
         fcb   $6F o
         fcb   $64 d
         fcb   $75 u
         fcb   $6C l
         fcb   $65 e
         fcb   $3E >
         fcb   $20 
         fcb   $5B [
         fcb   $2D -
         fcb   $6F o
         fcb   $70 p
         fcb   $74 t
         fcb   $73 s
         fcb   $5D ]
         fcb   $0A 
         fcb   $20 
         fcb   $20 
         fcb   $74 t
         fcb   $6F o
         fcb   $20 
         fcb   $64 d
         fcb   $69 i
         fcb   $73 s
         fcb   $70 p
         fcb   $6C l
         fcb   $61 a
         fcb   $79 y
         fcb   $20 
         fcb   $6D m
         fcb   $6F o
         fcb   $64 d
         fcb   $75 u
         fcb   $6C l
         fcb   $65 e
         fcb   $20 
         fcb   $68 h
         fcb   $65 e
         fcb   $61 a
         fcb   $64 d
         fcb   $65 e
         fcb   $72 r
         fcb   $2E .
         fcb   $0A 
         fcb   $20 
         fcb   $20 
         fcb   $2D -
         fcb   $6D m
         fcb   $20 
         fcb   $74 t
         fcb   $6F o
         fcb   $20 
         fcb   $64 d
         fcb   $69 i
         fcb   $73 s
         fcb   $70 p
         fcb   $6C l
         fcb   $61 a
         fcb   $79 y
         fcb   $20 
         fcb   $6D m
         fcb   $6F o
         fcb   $64 d
         fcb   $75 u
         fcb   $6C l
         fcb   $65 e
         fcb   $20 
         fcb   $69 i
         fcb   $6E n
         fcb   $20 
         fcb   $6D m
         fcb   $65 e
         fcb   $6D m
         fcb   $6F o
         fcb   $72 r
         fcb   $79 y
         fcb   $2E .
         fcb   $0A 
         fcb   $20 
         fcb   $20 
         fcb   $2D -
         fcb   $73 s
         fcb   $20 
         fcb   $66 f
         fcb   $6F o
         fcb   $72 r
         fcb   $20 
         fcb   $73 s
         fcb   $68 h
         fcb   $6F o
         fcb   $72 r
         fcb   $74 t
         fcb   $20 
         fcb   $66 f
         fcb   $6F o
         fcb   $72 r
         fcb   $6D m
         fcb   $2E .
         fcb   $0A 
         fcb   $20 
         fcb   $20 
         fcb   $2D -
         fcb   $76 v
         fcb   $20 
         fcb   $66 f
         fcb   $6F o
         fcb   $72 r
         fcb   $20 
         fcb   $6E n
         fcb   $6F o
         fcb   $20 
         fcb   $43 C
         fcb   $52 R
         fcb   $43 C
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
         fcb   $0A 
         fcb   $20 
         fcb   $20 
         fcb   $2D -
         fcb   $78 x
         fcb   $20 
         fcb   $66 f
         fcb   $6F o
         fcb   $72 r
         fcb   $20 
         fcb   $66 f
         fcb   $69 i
         fcb   $6C l
         fcb   $65 e
         fcb   $20 
         fcb   $69 i
         fcb   $6E n
         fcb   $20 
         fcb   $65 e
         fcb   $78 x
         fcb   $65 e
         fcb   $63 c
         fcb   $75 u
         fcb   $74 t
         fcb   $69 i
         fcb   $6F o
         fcb   $6E n
         fcb   $20 
         fcb   $64 d
         fcb   $69 i
         fcb   $72 r
         fcb   $65 e
         fcb   $63 c
         fcb   $74 t
         fcb   $6F o
         fcb   $72 r
         fcb   $79 y
         fcb   $0D 
L00CD    fcb   $4D M
         fcb   $6F o
         fcb   $64 d
         fcb   $75 u
         fcb   $6C l
         fcb   $65 e
         fcb   $20 
         fcb   $68 h
         fcb   $65 e
         fcb   $61 a
         fcb   $64 d
         fcb   $65 e
         fcb   $72 r
         fcb   $20 
         fcb   $69 i
         fcb   $73 s
         fcb   $20 
         fcb   $69 i
         fcb   $6E n
         fcb   $63 c
         fcb   $6F o
         fcb   $72 r
         fcb   $72 r
         fcb   $65 e
         fcb   $63 c
         fcb   $74 t
         fcb   $A1 !
L00E8    fcb   $48 H
         fcb   $65 e
         fcb   $61 a
         fcb   $64 d
         fcb   $65 e
         fcb   $72 r
         fcb   $20 
         fcb   $66 f
         fcb   $6F o
         fcb   $72 r
         fcb   $3A :
         fcb   $A0 
L00F4    fcb   $4D M
         fcb   $6F o
         fcb   $64 d
         fcb   $75 u
         fcb   $6C l
         fcb   $65 e
         fcb   $20 
         fcb   $73 s
         fcb   $69 i
         fcb   $7A z
         fcb   $65 e
         fcb   $BA :
L0100    fcb   $4D M
         fcb   $6F o
         fcb   $64 d
         fcb   $75 u
         fcb   $6C l
         fcb   $65 e
         fcb   $20 
         fcb   $43 C
         fcb   $52 R
         fcb   $43 C
         fcb   $3A :
         fcb   $A0 
L010C    fcb   $48 H
         fcb   $64 d
         fcb   $72 r
         fcb   $20 
         fcb   $70 p
         fcb   $61 a
         fcb   $72 r
         fcb   $69 i
         fcb   $74 t
         fcb   $79 y
         fcb   $3A :
         fcb   $A0 
L0118    fcb   $45 E
         fcb   $78 x
         fcb   $65 e
         fcb   $63 c
         fcb   $2E .
         fcb   $20 
         fcb   $6F o
         fcb   $66 f
         fcb   $66 f
         fcb   $3A :
         fcb   $20 
         fcb   $A0 
L0124    fcb   $44 D
         fcb   $61 a
         fcb   $74 t
         fcb   $61 a
         fcb   $20 
         fcb   $53 S
         fcb   $69 i
         fcb   $7A z
         fcb   $65 e
         fcb   $3A :
         fcb   $20 
         fcb   $A0 
L0130    fcb   $54 T
         fcb   $79 y
         fcb   $2F /
         fcb   $4C L
         fcb   $61 a
         fcb   $20 
         fcb   $41 A
         fcb   $74 t
         fcb   $2F /
         fcb   $52 R
         fcb   $76 v
         fcb   $BA :
L013C    fcb   $45 E
         fcb   $64 d
         fcb   $69 i
         fcb   $74 t
         fcb   $69 i
         fcb   $6F o
         fcb   $6E n
         fcb   $3A :
         fcb   $20 
         fcb   $20 
         fcb   $20 
         fcb   $A0 
L0148    fcb   $6D m
         fcb   $6F o
         fcb   $64 d
         fcb   $AC ,
L014C    fcb   $72 r
         fcb   $65 e
         fcb   $2D -
         fcb   $65 e
         fcb   $6E n
         fcb   $AC ,
L0152    fcb   $6E n
         fcb   $6F o
         fcb   $6E n
         fcb   $2D -
         fcb   $73 s
         fcb   $68 h
         fcb   $72 r
         fcb   $AC ,
L015A    fcb   $52 R
         fcb   $2F /
         fcb   $CF O
L015D    fcb   $52 R
         fcb   $2F /
         fcb   $D7 W
L0160    fcb   $28 (
         fcb   $47 G
         fcb   $6F o
         fcb   $6F o
         fcb   $64 d
         fcb   $A9 )
L0166    fcb   $28 (
         fcb   $42 B
         fcb   $61 a
         fcb   $64 d
         fcb   $29 )
         fcb   $87 
L016C    fcb   $10 
         fcb   $1C 
         fcb   $20 
         fcb   $24 $
         fcb   $29 )
         fcb   $2D -
         fcb   $32 2
         fcb   $37 7
         fcb   $3C <
         fcb   $41 A
         fcb   $46 F
         fcb   $4B K
         fcb   $50 P
         fcb   $56 V
         fcb   $5E ^
         fcb   $65 e
         fcb   $62 b
         fcb   $61 a
         fcb   $64 d
         fcb   $20 
         fcb   $74 t
         fcb   $79 y
         fcb   $70 p
         fcb   $65 e
         fcb   $20 
         fcb   $66 f
         fcb   $6F o
         fcb   $F2 r
         fcb   $50 P
         fcb   $72 r
         fcb   $6F o
         fcb   $E7 g
         fcb   $53 S
         fcb   $75 u
         fcb   $62 b
         fcb   $F2 r
         fcb   $4D M
         fcb   $75 u
         fcb   $6C l
         fcb   $74 t
         fcb   $E9 i
         fcb   $44 D
         fcb   $61 a
         fcb   $74 t
         fcb   $E1 a
         fcb   $55 U
         fcb   $73 s
         fcb   $72 r
         fcb   $20 
         fcb   $B5 5
         fcb   $55 U
         fcb   $73 s
         fcb   $72 r
         fcb   $20 
         fcb   $B6 6
         fcb   $55 U
         fcb   $73 s
         fcb   $72 r
         fcb   $20 
         fcb   $B7 7
         fcb   $55 U
         fcb   $73 s
         fcb   $72 r
         fcb   $20 
         fcb   $B8 8
         fcb   $55 U
         fcb   $73 s
         fcb   $72 r
         fcb   $20 
         fcb   $B9 9
         fcb   $55 U
         fcb   $73 s
         fcb   $72 r
         fcb   $20 
         fcb   $C1 A
         fcb   $55 U
         fcb   $73 s
         fcb   $72 r
         fcb   $20 
         fcb   $C2 B
         fcb   $53 S
         fcb   $79 y
         fcb   $73 s
         fcb   $74 t
         fcb   $65 e
         fcb   $ED m
         fcb   $46 F
         fcb   $69 i
         fcb   $6C l
         fcb   $65 e
         fcb   $20 
         fcb   $4D M
         fcb   $61 a
         fcb   $EE n
         fcb   $44 D
         fcb   $65 e
         fcb   $76 v
         fcb   $20 
         fcb   $44 D
         fcb   $76 v
         fcb   $F2 r
         fcb   $44 D
         fcb   $65 e
         fcb   $76 v
         fcb   $20 
         fcb   $44 D
         fcb   $73 s
         fcb   $E3 c
L01D8    fcb   $10 
         fcb   $15 
         fcb   $1E 
         fcb   $2D -
         fcb   $3B ;
         fcb   $44 D
         fcb   $51 Q
         fcb   $60 `
         fcb   $60 `
         fcb   $60 `
         fcb   $60 `
         fcb   $60 `
         fcb   $60 `
         fcb   $60 `
         fcb   $60 `
         fcb   $60 `
         fcb   $44 D
         fcb   $61 a
         fcb   $74 t
         fcb   $61 a
         fcb   $AC ,
         fcb   $36 6
         fcb   $38 8
         fcb   $30 0
         fcb   $39 9
         fcb   $20 
         fcb   $6F o
         fcb   $62 b
         fcb   $6A j
         fcb   $AC ,
         fcb   $42 B
         fcb   $41 A
         fcb   $53 S
         fcb   $49 I
         fcb   $43 C
         fcb   $30 0
         fcb   $39 9
         fcb   $20 
         fcb   $49 I
         fcb   $2D -
         fcb   $63 c
         fcb   $6F o
         fcb   $64 d
         fcb   $65 e
         fcb   $AC ,
         fcb   $50 P
         fcb   $41 A
         fcb   $53 S
         fcb   $43 C
         fcb   $41 A
         fcb   $4C L
         fcb   $20 
         fcb   $50 P
         fcb   $2D -
         fcb   $63 c
         fcb   $6F o
         fcb   $64 d
         fcb   $65 e
         fcb   $AC ,
         fcb   $43 C
         fcb   $20 
         fcb   $49 I
         fcb   $2D -
         fcb   $63 c
         fcb   $6F o
         fcb   $64 d
         fcb   $65 e
         fcb   $AC ,
         fcb   $43 C
         fcb   $4F O
         fcb   $42 B
         fcb   $4F O
         fcb   $4C L
         fcb   $20 
         fcb   $49 I
         fcb   $2D -
         fcb   $63 c
         fcb   $6F o
         fcb   $64 d
         fcb   $65 e
         fcb   $AC ,
         fcb   $46 F
         fcb   $4F O
         fcb   $52 R
         fcb   $54 T
         fcb   $52 R
         fcb   $41 A
         fcb   $4E N
         fcb   $20 
         fcb   $49 I
         fcb   $2D -
         fcb   $63 c
         fcb   $6F o
         fcb   $64 d
         fcb   $65 e
         fcb   $AC ,
         fcb   $3F ?
         fcb   $3F ?
         fcb   $3F ?
         fcb   $3F ?
         fcb   $AC ,
start    equ   *
         leas  >u019C,u
         sts   <u0006
         tfr   y,d
         subd  <u0006
         std   <u0008
         leay  <u0022,u
         sty   <u0000
         clr   <u000A
         clr   <u000B
         clr   <u000C
         clr   <u0018
         lda   #$01
         sta   <u000D
         ldd   #$0000
         std   <u0002
         std   <u0004
L0263    lda   ,x+
L0265    cmpa  #$20
         beq   L0263
         cmpa  #$2C
         beq   L0263
         cmpa  #$0D
         beq   L02BB
         cmpa  #$2D
         beq   L027E
         ldy   <u0002
         bne   L0263
         stx   <u0002
         bra   L0263
L027E    lda   ,x+
         cmpa  #$2D
         beq   L027E
         cmpa  #$30
         bcs   L0265
         eora  #$4D
         anda  #$DF
         bne   L0292
         inc   <u000A
         bra   L027E
L0292    lda   -$01,x
         eora  #$53
         anda  #$DF
         bne   L029E
         inc   <u000B
         bra   L027E
L029E    lda   -$01,x
         eora  #$56
         anda  #$DF
         bne   L02AA
         inc   <u000C
         bra   L027E
L02AA    lda   -$01,x
         eora  #$58
         anda  #$DF
         bne   L02B8
         lda   #$05
         sta   <u000D
         bra   L027E
L02B8    lbra  L03C4
L02BB    ldx   <u0002
         lbeq  L03C4
         leax  -$01,x
         tst   <u000A
         beq   L0314
         pshs  u
         clra  
         os9   F$Link   
         lbcs  L03D2
         stu   <u000E
         ldd   ,u
         cmpd  #$87CD
         beq   L02EB
         puls  u
L02DD    leay  >L00CD,pcr
         lbsr  L05FC
         lbsr  L0612
         clrb  
         lbra  L03D2
L02EB    ldd   u0002,u
         subd  #$0003
         leax  d,u
         puls  u
         leay  <u0010,u
         pshs  u
         lda   #$03
L02FB    ldb   ,x+
         stb   ,y+
         deca  
         bne   L02FB
         puls  u
         lbsr  L03D5
         ldu   <u000E
         os9   F$UnLink 
         lbcs  L03D2
         clrb  
         lbra  L03D2
L0314    lda   #$80
         sta   <u00A1
         lda   <u000D
         os9   I$Open   
         lbcs  L03D2
         sta   <u0019
         ldd   #$0000
         std   <u001E
         std   <u0020
         std   <u001C
L032C    ldd   <u0020
         addd  <u001C
         std   <u0020
         bcc   L033B
         ldd   <u001E
         addd  #$0001
         std   <u001E
L033B    pshs  u
         ldx   <u001E
         ldu   <u0020
         lda   <u0019
         os9   I$Seek   
         lbcs  L03D2
         puls  u
         leax  <u0072,u
         stx   <u000E
         ldy   #$000E
         os9   I$Read   
         bcc   L0360
         cmpb  #$D3
         bne   L03D2
         bra   L03C1
L0360    ldd   ,x
         cmpd  #$87CD
         lbne  L02DD
         pshs  u,x
         ldd   $02,x
         std   <u001C
         addd  <u0020
         tfr   d,u
         leau  -u0003,u
         ldx   <u001E
         bcc   L037C
         leax  $01,x
L037C    lda   <u0019
         os9   I$Seek   
         bcs   L03D2
         puls  u,x
         leax  <u0010,u
         ldy   #$0003
         lda   <u0019
         os9   I$Read   
         bcs   L03D2
         pshs  u,x
         ldy   <u000E
         ldd   $04,y
         addd  <u0020
         tfr   d,u
         ldx   <u001E
         bcc   L03A4
         leax  $01,x
L03A4    lda   <u0019
         os9   I$Seek   
         bcs   L03D2
         puls  u,x
         leax  >u0080,u
         ldy   #$0021
         lda   <u0019
         os9   I$Read   
         bcs   L03D2
         bsr   L03D5
         lbra  L032C
L03C1    clrb  
         bra   L03D2
L03C4    lda   #$01
         leax  >L0013,pcr
         ldy   #$00BA
         os9   I$WritLn 
         clrb  
L03D2    os9   F$Exit   
L03D5    tst   <u000B
         lbne  L0502
         lbsr  L0612
         leay  >L00E8,pcr
         lbsr  L05FC
         lbsr  L04E9
         lbsr  L0612
         leay  >L00F4,pcr
         lbsr  L05FC
         ldy   <u000E
         ldd   $02,y
         lbsr  L05D2
         leay  >L0100,pcr
         lbsr  L05FC
         lbsr  L0543
         tst   <u000C
         bne   L041E
         lbsr  L0553
         tsta  
         beq   L0417
         leay  >L0166,pcr
         lbsr  L05FC
         bra   L041E
L0417    leay  >L0160,pcr
         lbsr  L05FC
L041E    lbsr  L0612
         leay  >L010C,pcr
         lbsr  L05FC
         ldy   <u000E
         ldb   $08,y
         lbsr  L0633
         lbsr  L0612
         ldy   <u000E
         ldb   $06,y
         stb   <u001A
         andb  #$F0
         cmpb  #$E0
         beq   L0444
         cmpb  #$10
         bne   L0462
L0444    leay  >L0118,pcr
         lbsr  L05FC
         ldy   <u000E
         ldd   $09,y
         lbsr  L05D2
         leay  >L0124,pcr
         lbsr  L05FC
         ldy   <u000E
         ldd   $0B,y
         lbsr  L05D2
L0462    leay  >L013C,pcr
         lbsr  L05FC
         ldb   <u0016
         pshs  b
         lbsr  L0633
         ldb   #$05
         lbsr  L0654
         puls  b
         clra  
         lbsr  L0649
         lbsr  L0612
         leay  >L0130,pcr
         lbsr  L05FC
         ldb   <u001A
         lbsr  L0633
         ldy   <u000E
         ldb   $07,y
         stb   <u001B
         lbsr  L0633
         lbsr  L0612
         ldb   <u001A
         lsrb  
         lsrb  
         lsrb  
         lsrb  
         leax  >L016C,pcr
         lda   b,x
         leay  a,x
         lbsr  L05FC
         leay  >L0148,pcr
         lbsr  L05FC
         ldb   <u001A
         andb  #$0F
         leax  >L01D8,pcr
         lda   b,x
         leay  a,x
         lbsr  L05FC
         ldb   <u001B
         bitb  #$80
         beq   L04CD
         leay  >L014C,pcr
         lbsr  L05FC
         bra   L04D4
L04CD    leay  >L0152,pcr
         lbsr  L05FC
L04D4    bitb  #$40
         beq   L04DE
         leay  >L015D,pcr
         bra   L04E2
L04DE    leay  >L015A,pcr
L04E2    lbsr  L05FC
         lbsr  L0612
         rts   
L04E9    tst   <u000A
         beq   L04F6
         ldy   <u000E
         ldd   $04,y
         leay  d,y
         bra   L04FA
L04F6    leay  >u0080,u
L04FA    lbsr  L05FC
         lda   ,y
         sta   <u0016
         rts   
L0502    ldb   #$06
         lbsr  L0654
         ldy   <u000E
         ldb   $06,y
         lbsr  L0633
         bsr   L0543
         tst   <u000C
         beq   L0519
         lda   #$20
         bra   L0520
L0519    bsr   L0553
         tsta  
         bne   L0520
         lda   #$2E
L0520    lbsr  L0608
         lbsr  L0666
         bsr   L04E9
         ldx   <u0000
         pshs  x
         leax  <u0022,u
         stx   <u0000
         ldb   <u0016
         inc   <u0018
         clra  
         lbsr  L0692
         clr   <u0018
         puls  x
         stx   <u0000
         lbsr  L0612
         rts   
L0543    lda   #$24
         lbsr  L0608
         ldd   <u0010
         lbsr  L066E
         ldb   <u0012
         lbsr  L0664
         rts   
L0553    ldd   #$FFFF
         std   <u0013
         stb   <u0015
         pshs  u,y,x
         leau  <u0013,u
         tst   <u000A
         beq   L0571
         ldx   <u000E
         ldy   $02,x
         os9   F$CRC    
         lbcs  L03D2
         bra   L058C
L0571    pshs  u,x
         ldx   <u001E
         ldu   <u0020
         lda   <u0019
         os9   I$Seek   
         puls  u,x
         lbcs  L03D2
         ldd   <u001C
         pshs  b,a
         bsr   L05BF
         puls  b,a
         std   <u001C
L058C    puls  u,y,x
         lda   <u0013
         cmpa  #$80
         bne   L059E
         ldd   <u0014
         cmpd  #$0FE3
         bne   L059E
         bra   L05A1
L059E    lda   #$3F
         rts   
L05A1    clra  
         rts   
L05A3    lda   <u0019
         ldx   <u0006
         ldy   <u0008
         cmpy  <u001C
         bls   L05B2
         ldy   <u001C
L05B2    os9   I$Read   
         sty   <u0004
         rts   
L05B9    bsr   L05A3
         lbcs  L03D2
L05BF    ldy   <u0004
         beq   L05B9
         os9   F$CRC    
         ldd   <u001C
         subd  <u0004
         std   <u001C
         bne   L05B9
         std   <u0004
         rts   
L05D2    pshs  b,a
         bsr   L0628
         ldb   #$03
         bsr   L0654
         puls  b,a
         bsr   L0649
         bsr   L0612
         rts   
         pshs  b,a
         andb  #$F0
         lsrb  
         lsrb  
         lsrb  
         lsrb  
L05E9    lda   #$24
         bsr   L0608
         lbsr  L0682
         ldb   #$02
         bsr   L0654
         puls  pc,b,a
         pshs  b,a
         andb  #$0F
         bra   L05E9
L05FC    lda   ,y
         anda  #$7F
         bsr   L0608
         lda   ,y+
         bpl   L05FC
L0606    lda   #$20
L0608    pshs  x
         ldx   <u0000
         sta   ,x+
         stx   <u0000
         puls  pc,x
L0612    pshs  y,x,a
         lda   #$0D
         bsr   L0608
         leax  <u0022,u
         stx   <u0000
         ldy   #$0050
         lda   #$01
         os9   I$WritLn 
         puls  pc,y,x,a
L0628    pshs  a
         lda   #$24
         bsr   L0608
         puls  a
         bsr   L0660
         rts   
L0633    pshs  a
         lda   #$24
         bsr   L0608
         puls  a
         bsr   L0664
         rts   
         pshs  a
         lda   #$24
         bsr   L0608
         puls  a
         bsr   L0682
         rts   
L0649    pshs  a
         lda   #$23
         bsr   L0608
         puls  a
         bsr   L0692
         rts   
L0654    pshs  b,a
L0656    tstb  
         ble   L065E
         bsr   L0606
         decb  
         bra   L0656
L065E    puls  pc,b,a
L0660    bsr   L066E
         bra   L0666
L0664    bsr   L0674
L0666    pshs  a
         lda   #$20
         bsr   L0608
         puls  pc,a
L066E    exg   a,b
         bsr   L0674
         tfr   a,b
L0674    pshs  b
         andb  #$F0
         lsrb  
         lsrb  
         lsrb  
         lsrb  
         bsr   L0682
         puls  b
         andb  #$0F
L0682    cmpb  #$09
         bls   L0688
         addb  #$07
L0688    addb  #$30
         exg   a,b
         lbsr  L0608
         exg   a,b
         rts   
L0692    pshs  u,y,b
         leau  <L06C3,pcr
         clr   <u0017
         ldy   #$0005
L069D    clr   ,s
L069F    subd  ,u
         bcs   L06A7
         inc   ,s
         bra   L069F
L06A7    addd  ,u++
         pshs  b
         ldb   $01,s
         exg   a,b
         bsr   L06CD
         exg   a,b
         puls  b
         cmpy  #$0002
         bgt   L06BD
         inc   <u0017
L06BD    leay  -$01,y
         bne   L069D
         puls  pc,u,y,b
L06C3    fdb   $2710,$03e8,$0064,$000a,$0001
L06CD    tsta  
         beq   L06D2
         sta   <u0017
L06D2    tst   <u0017
         bne   L06DF
         tst   <u0018
         beq   L06DE
         lda   #$20
         bra   L06E1
L06DE    rts   
L06DF    adda  #$30
L06E1    lbra  L0608

         emod
eom      equ   *
         end
