********************************************************************
* Edit - External editor with same syntax as the builtin of Basic09
*
* $Id$
*
* Ed.    Comments                                       Who YY/MM/DD
* ------------------------------------------------------------------
*  -     Original Basic09 from Dragon Data distribution version
*
* $Log$
* Revision 1.1  2002/04/06 14:47:31  roug
* Prego; The basic09 interpreter.
*
*

         nam   Edit
         ttl   External editor with same syntax as the builtin of Basic09

* Disassembled 02/04/06 16:38:45 by Disasm v1.6 (C) 1988 by RML

         ifp1
         use   /dd/defs/os9defs
         endc
tylg     set   Prgrm+Objct   
atrv     set   ReEnt+rev
rev      set   $01
         mod   eom,name,tylg,atrv,start,size
u0000    rmb   1
u0001    rmb   1
u0002    rmb   1
u0003    rmb   1
u0004    rmb   1
u0005    rmb   1
u0006    rmb   1
u0007    rmb   1
u0008    rmb   1
u0009    rmb   1
u000A    rmb   1
u000B    rmb   1
u000C    rmb   1
u000D    rmb   1
u000E    rmb   1
u000F    rmb   1
u0010    rmb   1
u0011    rmb   1
u0012    rmb   2
u0014    rmb   2
u0016    rmb   2
u0018    rmb   2
u001A    rmb   2
u001C    rmb   2
u001E    rmb   5
u0023    rmb   1
u0024    rmb   1
u0025    rmb   1
u0026    rmb   1
u0027    rmb   2
u0029    rmb   1
u002A    rmb   1
u002B    rmb   2
u002D    rmb   2
u002F    rmb   1
u0030    rmb   2
u0032    rmb   4
u0036    rmb   1
u0037    rmb   1
u0038    rmb   1
u0039    rmb   1
u003A    rmb   1
u003B    rmb   1
u003C    rmb   1
u003D    rmb   1
u003E    rmb   1
u003F    rmb   1
u0040    rmb   1
u0041    rmb   1
u0042    rmb   1
u0043    rmb   1
u0044    rmb   1
u0045    rmb   2
u0047    rmb   1
u0048    rmb   1
u0049    rmb   2
u004B    rmb   2
u004D    rmb   1
u004E    rmb   1
u004F    rmb   2
u0051    rmb   4
u0055    rmb   2
u0057    rmb   13
u0064    rmb   7
u006B    rmb   2
u006D    rmb   2
u006F    rmb   5
u0074    rmb   7
u007B    rmb   14
u0089    rmb   1
u008A    rmb   4
u008E    rmb   16
u009E    rmb   7
u00A5    rmb   1
u00A6    rmb   11
u00B1    rmb   3
u00B4    rmb   2
u00B6    rmb   15
u00C5    rmb   8
u00CD    rmb   2
u00CF    rmb   2
u00D1    rmb   2
u00D3    rmb   2
u00D5    rmb   1
u00D6    rmb   18
u00E8    rmb   4
u00EC    rmb   1
u00ED    rmb   10
u00F7    rmb   4
u00FB    rmb   3
u00FE    rmb   121
u0177    rmb   255
u0276    rmb   40
u029E    rmb   384
u041E    rmb   2049
size     equ   .
name     equ   *
         fcs   /Edit/
         fcb   $03 
         fcb   $28 (
         fcb   $43 C
         fcb   $29 )
         fcb   $31 1
         fcb   $39 9
         fcb   $38 8
         fcb   $31 1
         fcb   $4D M
         fcb   $69 i
         fcb   $63 c
         fcb   $72 r
         fcb   $6F o
         fcb   $77 w
         fcb   $61 a
         fcb   $72 r
         fcb   $65 e
L0022    fcb   $01 
         fcb   $16 
         fcb   $02 
         fcb   $6C l
         fcb   $16 
         fcb   $0C 
         fcb   $0F 
         fcb   $16 
         fcb   $0B 
         fcb   $C0 @
         fcb   $16 
         fcb   $0B 
         fcb   $B4 4
         fcb   $16 
         fcb   $0F 
         fcb   $DD ]
         fcb   $16 
         fcb   $07 
         fcb   $3B ;
         fcb   $16 
         fcb   $06 
         fcb   $B2 2
         fcb   $16 
         fcb   $06 
         fcb   $DB [
         fcb   $16 
         fcb   $07 
         fcb   $01 
         fcb   $16 
         fcb   $04 
         fcb   $60 `
         fcb   $16 
         fcb   $04 
         fcb   $27 '
         fcb   $16 
         fcb   $05 
         fcb   $8F 
         fcb   $16 
         fcb   $05 
         fcb   $DC \
         fcb   $16 
         fcb   $00 
         fcb   $47 G
         fcb   $16 
         fcb   $0B 
         fcb   $46 F
         fcb   $16 
         fcb   $0A 
         fcb   $AE .
L0053    fcb   $86 
         fcb   $00 
         fcb   $A7 '
         fcb   $C8 H
         fcb   $23 #
         fcb   $3B ;
L0059    fcb   $9E 
         fcb   $0E 
         fcb   $6E n
         fcb   $84 
L005D    fcb   $96 
         fcb   $26 &
         fcb   $17 
         fcb   $00 
         fcb   $A5 %
         fcb   $86 
         fcb   $3A :
         fcb   $17 
         fcb   $00 
         fcb   $A0 
         fcb   $9E 
         fcb   $12 
         fcb   $30 0
         fcb   $89 
         fcb   $01 
         fcb   $77 w
         fcb   $96 
         fcb   $0A 
         fcb   $10 
         fcb   $8E 
         fcb   $00 
         fcb   $80 
         fcb   $10 
         fcb   $3F ?
         fcb   $8B 
         fcb   $24 $
         fcb   $09 
         fcb   $C1 A
         fcb   $D3 S
         fcb   $10 
         fcb   $27 '
         fcb   $10 
         fcb   $CF O
         fcb   $16 
         fcb   $12 
         fcb   $29 )
         fcb   $39 9
L0082    fcb   $34 4
         fcb   $16 
         fcb   $17 
         fcb   $06 
         fcb   $50 P
         fcb   $8D 
         fcb   $02 
         fcb   $35 5
         fcb   $96 
L008B    fcb   $34 4
         fcb   $06 
         fcb   $17 
         fcb   $00 
         fcb   $A0 
         fcb   $8D 
         fcb   $02 
         fcb   $35 5
         fcb   $86 
L0094    fcb   $34 4
         fcb   $36 6
         fcb   $10 
         fcb   $83 
         fcb   $00 
         fcb   $00 
         fcb   $27 '
         fcb   $2A *
         fcb   $31 1
         fcb   $8B 
         fcb   $34 4
         fcb   $20 
         fcb   $0D 
         fcb   $37 7
         fcb   $27 '
         fcb   $08 
         fcb   $86 
         fcb   $20 
         fcb   $8D 
         fcb   $5F _
         fcb   $8D 
         fcb   $5D ]
         fcb   $8D 
         fcb   $5B [
         fcb   $0D 
         fcb   $23 #
         fcb   $27 '
         fcb   $14 
         fcb   $A6 &
         fcb   $80 
         fcb   $8D 
         fcb   $53 S
         fcb   $AC ,
         fcb   $E4 d
         fcb   $27 '
         fcb   $06 
         fcb   $81 
         fcb   $0D 
         fcb   $26 &
         fcb   $F0 p
         fcb   $20 
         fcb   $E2 b
         fcb   $81 
         fcb   $0D 
         fcb   $27 '
         fcb   $02 
         fcb   $8D 
         fcb   $3B ;
         fcb   $35 5
         fcb   $20 
         fcb   $35 5
         fcb   $B6 6
L00C8    fcb   $34 4
         fcb   $26 &
         fcb   $DC \
         fcb   $02 
         fcb   $5D ]
         fcb   $27 '
         fcb   $11 
         fcb   $A1 !
         fcb   $E4 d
         fcb   $26 &
         fcb   $0D 
         fcb   $DC \
         fcb   $21 !
         fcb   $C3 C
         fcb   $00 
         fcb   $01 
         fcb   $DD ]
         fcb   $21 !
         fcb   $D6 V
         fcb   $20 
         fcb   $C9 I
         fcb   $00 
         fcb   $D7 W
         fcb   $20 
         fcb   $8D 
         fcb   $4E N
         fcb   $1F 
         fcb   $02 
         fcb   $A6 &
         fcb   $E4 d
         fcb   $10 
         fcb   $3F ?
         fcb   $8A 
         fcb   $10 
         fcb   $25 %
         fcb   $11 
         fcb   $BD =
         fcb   $35 5
         fcb   $A6 &
L00EF    fcb   $34 4
         fcb   $02 
         fcb   $8D 
         fcb   $0C 
         fcb   $96 
         fcb   $37 7
         fcb   $0F 
         fcb   $37 7
         fcb   $8D 
         fcb   $92 
         fcb   $97 
         fcb   $37 7
         fcb   $35 5
         fcb   $82 
L00FD    fcb   $8D 
         fcb   $00 
L00FF    fcb   $34 4
         fcb   $02 
         fcb   $86 
         fcb   $0D 
         fcb   $8D 
         fcb   $02 
         fcb   $35 5
         fcb   $82 
L0107    fcb   $34 4
         fcb   $32 2
         fcb   $96 
         fcb   $0B 
         fcb   $10 
         fcb   $8E 
         fcb   $00 
         fcb   $01 
         fcb   $1F 
         fcb   $41 A
         fcb   $0D 
         fcb   $41 A
         fcb   $2B +
         fcb   $04 
         fcb   $0D 
         fcb   $3E >
         fcb   $27 '
         fcb   $07 
         fcb   $10 
         fcb   $3F ?
         fcb   $8C 
         fcb   $10 
         fcb   $25 %
         fcb   $11 
         fcb   $8A 
         fcb   $35 5
         fcb   $B2 2
L0122    fcb   $34 4
         fcb   $10 
         fcb   $A6 &
         fcb   $80 
         fcb   $81 
         fcb   $0D 
         fcb   $10 
         fcb   $27 '
         fcb   $11 
         fcb   $46 F
         fcb   $8D 
         fcb   $04 
         fcb   $35 5
         fcb   $90 
L0130    fcb   $86 
         fcb   $0D 
L0132    fcb   $34 4
         fcb   $30 0
         fcb   $C6 F
         fcb   $0D 
         fcb   $10 
         fcb   $8E 
         fcb   $00 
         fcb   $00 
         fcb   $9C 
         fcb   $1C 
         fcb   $27 '
         fcb   $0E 
         fcb   $31 1
         fcb   $21 !
         fcb   $E1 a
         fcb   $84 
         fcb   $27 '
         fcb   $08 
         fcb   $A1 !
         fcb   $80 
         fcb   $26 &
         fcb   $F2 r
         fcb   $31 1
         fcb   $3F ?
         fcb   $20 
         fcb   $06 
         fcb   $81 
         fcb   $0D 
         fcb   $10 
         fcb   $26 &
         fcb   $11 
         fcb   $20 
         fcb   $1F 
         fcb   $20 
         fcb   $10 
         fcb   $83 
         fcb   $00 
         fcb   $00 
         fcb   $35 5
         fcb   $B0 0
L015A    fcb   $34 4
         fcb   $56 V
         fcb   $10 
         fcb   $3F ?
         fcb   $10 
         fcb   $35 5
         fcb   $D6 V
start    equ   *
         tfr   u,d
         std   <u0012
         sts   <u001E
         leas  >u041E,u
         addd  #$041F
         std   <u0014
         std   <u0016
         std   <u001C
         std   <u001A
         pshs  u,y,x,b,a
         leax  >L0022,pcr
         stx   <u000C
         leax  >L005D,pcr
         stx   <u000E
         leax  >L09DD,pcr
         stx   <u0010
         ldd   #$0000
         std   <u0051
         std   <u006F
         std   <u0089
         leax  >L1482,pcr
         stx   <u004D
         leax  >L13CF,pcr
         stx   <u006B
         leax  >L0000,pcr
         stx   <u004F
         stx   <u006D
         leax  >L13B0,pcr
         lda   #$01
         os9   F$Link   
         bcs   L01B5
         jsr   ,y
L01B5    leax  >L13B6,pcr
         lda   #$01
         os9   F$Link   
         bcs   L01C2
         jsr   ,y
L01C2    puls  u,y,x,b,a
         lda   #$FF
         sta   <u0041
         inca  
         sta   <u0001
         sta   <u0003
         sta   <u0005
         sta   <u0007
         sta   <u000A
         sta   <u003D
         inca  
         sta   <u000B
         sta   <u003E
         sta   <u0040
         lda   #$45
         sta   <u0026
         clr   <u0036
         lbsr  L0691
         cmpa  #$0D
         beq   L0260
         lbsr  L015A
         bcs   L0259
         lda   #$01
         stx   <u0032
         os9   I$Open   
         bcs   L024B
         ldb   #$01
         std   <u0000
         pshs  x
         leay  >u00F7,u
         leax  >L139F,pcr
         ldd   #$0007
         lbsr  L0B96
         pshs  y
         ldx   <u0032
L020F    cmpx  $02,s
         beq   L0220
         lda   ,x+
         sta   ,y+
         cmpa  #$2F
         bne   L020F
         sty   ,s
         bra   L020F
L0220    puls  y
         leax  >L13A7,pcr
         ldd   #$0008
         lbsr  L0B96
         ldx   <u0032
         ldd   ,s
         subd  <u0032
         sty   <u0032
         lbsr  L0B96
         lda   #$0D
         sta   ,y
         puls  x
         lbsr  L0691
         cmpa  #$0D
         bne   L024B
         leax  >u00FE,u
         inc   <u0036
L024B    ldd   #$020B
         os9   I$Create 
         bcs   L025B
         ldb   #$02
         std   <u0002
         bra   L0260
L0259    ldb   #$D8
L025B    orcc  #$01
         os9   F$Exit   
L0260    ldy   #$0000
         sty   <u0024
         lda   #$42
         lbsr  L06EA
         lbsr  L073F
         lda   #$42
         ldy   #$0001
         lbsr  L06EA
         leax  >L0053,pcr
         ldu   <u0012
         os9   F$Icpt   
         tst   <u0001
         beq   L028F
         ldd   <u001E
         subd  <u001C
         subd  #$0400
         lbsr  L0F43
L028F    lbsr  L00FD
L0292    ldu   <u0012
         leas  >u041E,u
         leax  >u029E,u
         stx   <u0045
         stx   <u0047
         leax  <-$28,x
         stx   <u0049
         lda   #$FF
         sta   <u0041
         sta   <u0023
         lda   <u0040
         sta   <u003E
         clr   <u003B
         clr   <u003A
         clr   <u003C
         lda   #$01
         sta   <u0037
         tst   <u003D
         beq   L02CB
         tst   <u0039
         bne   L02CB
         leax  >L1398,pcr
         lbsr  L00EF
         lbsr  L00FF
L02CB    clr   <u003D
         clr   <u0039
         lbsr  L0059
         leax  >u0177,u
         lbsr  L0130
         leay  d,x
         sty   <u002B
         ldy   #$0000
         sty   <u0029
         leau  >u0276,u
         stu   <u0027
         lda   ,x
         cmpa  #$20
         bne   L02F8
         leax  $01,x
         lbsr  L0BDE
         bra   L0292
L02F8    cmpa  #$0D
         bne   L0308
         ldx   <u001A
         lbsr  L06B2
         stx   <u001A
         lbsr  L008B
         bra   L0292
L0308    bsr   L0310
         lbsr  L00FF
         lbra  L0292
L0310    ldd   <u0043
         pshs  b,a
         ldd   <u0045
         std   <u0043
         pshs  b,a
         lda   <u003E
         pshs  a
         clr   <u002F
         inc   <u0041
L0322    cmpx  <u002B
         lbcc  L03B8
         lbsr  L0691
         cmpa  #$0D
         bne   L0335
         leax  $01,x
         clr   <u002F
         bra   L0322
L0335    ldd   <u0027
         pshs  b,a
         stu   <u0027
         ldd   <u0029
         pshs  b,a
         ldd   <u002B
         pshs  b,a
         pshs  u
         lbsr  L0691
         sta   <u0038
         lbsr  L03D3
         pshs  x
         pshs  u
         leax  <L039D,pcr
         pshu  x
         pshu  u
         tfr   d,x
         lda   <u0038
         tst   <u003B
         bne   L0372
         tst   <u003C
         bne   L0372
         tst   <u003D
         beq   L0397
         tst   <u003A
         bne   L0372
         cmpa  #$3A
         bne   L0372
         stb   <u003D
L0372    cmpa  #$5B
         bne   L0378
         inc   <u003A
L0378    cmpa  #$5D
         bne   L039D
         dec   <u003A
         bpl   L039D
         tst   <u003C
         bne   L0395
         lbsr  L0964
         tst   <u003B
         bne   L038F
         clr   <u003D
         bra   L039D
L038F    clr   <u003B
         bra   L039D
         bra   L039D
L0395    clr   <u003C
L0397    lda   <u0041
         clr   <u0039
         jsr   ,y
L039D    puls  u
         puls  x
         puls  u
         puls  b,a
         std   <u002B
         puls  b,a
         std   <u0029
         puls  b,a
         std   <u0027
         tst   <u0023
         lbeq  L127B
         lbra  L0322
L03B8    dec   <u0041
         puls  a
         sta   <u003E
         puls  b,a
         std   <u0045
         puls  b,a
         std   <u0043
         tst   <u003D
         beq   L03D2
         lda   #$01
         sta   <u003D
         clr   <u003C
         clr   <u003B
L03D2    rts   
L03D3    lbsr  L0691
         bsr   L040E
         beq   L0400
         leax  $01,x
         lbsr  L04A1
         lbeq  L1269
         pshs  y
         tfr   d,y
         ldd   ,y
         leay  d,y
         sty   <u002B
         ldy   ,s
         lbsr  L04F4
         tfr   y,d
         puls  y
         sty   <u0029
         leay  >L0310,pcr
         rts   
L0400    pshs  b,a
         lbsr  L04F4
         ldd   #$0000
         std   <u0029
         std   <u002B
         puls  pc,y
L040E    ldb   ,x+
         lbsr  L04D0
         tfr   a,b
L0415    ldy   <u0012
         leay  <$4D,y
         cmpb  #$2E
         bne   L0425
         ldy   <u0012
         leay  <$6B,y
L0425    sty   <u004B
         ldy   ,y
L042B    lda   ,y
         bne   L043C
         ldy   <u004B
         leay  $04,y
         sty   <u004B
         ldy   ,y
         beq   L045D
L043C    cmpb  #$2E
         beq   L0446
         cmpb  ,y+
         bne   L044A
         bra   L044E
L0446    bsr   L046B
         beq   L044E
L044A    bsr   L0462
         bra   L042B
L044E    pshs  y
         bsr   L0462
         ldd   -$02,y
         ldy   <u004B
         addd  $02,y
         orcc  #$04
         puls  pc,y
L045D    leax  -$01,x
         andcc #$FB
         rts   
L0462    lda   ,y+
         cmpa  #$0D
         bne   L0462
         leay  $02,y
         rts   
L046B    pshs  y,x,b,a
         lda   ,y
         bsr   L04DA
         bne   L049D
L0473    sty   $04,s
         lda   ,y+
         bsr   L04D0
         bne   L0491
         pshs  a
         lda   ,x+
         bsr   L04D0
         cmpa  ,s+
         beq   L0473
L0486    sty   $04,s
         lda   ,y+
         bsr   L04DA
         beq   L0486
         bra   L049D
L0491    lda   ,x
         bsr   L04DA
         beq   L049D
         stx   $02,s
         orcc  #$04
         bra   L049F
L049D    andcc #$FB
L049F    puls  pc,y,x,b,a
L04A1    pshs  u
         ldu   <u0014
         lbsr  L0691
L04A8    lda   u0004,u
         cmpa  #$4D
         bne   L04C0
         leay  u000B,u
         lbsr  L069A
         bsr   L046B
         beq   L04C4
         ldd   ,u
         leau  d,u
         cmpu  <u001C
         bcs   L04A8
L04C0    orcc  #$04
         puls  pc,u
L04C4    lbsr  L069A
         lbsr  L0691
         tfr   u,d
         andcc #$FB
         puls  pc,u
L04D0    cmpa  #$61
         bcs   L04DA
         cmpa  #$7A
         bhi   L04DA
         suba  #$20
L04DA    cmpa  #$5F
         beq   L04EE
         cmpa  #$41
         bcs   L04F1
         cmpa  #$5A
         bls   L04EE
         cmpa  #$61
         bcs   L04F1
         cmpa  #$7A
         bhi   L04F1
L04EE    orcc  #$04
         rts   
L04F1    andcc #$FB
         rts   
L04F4    clr   <u0042
         pshs  b,a
L04F8    lbsr  L069A
         lbsr  L0691
         bsr   L052B
L0500    cmpa  #$0D
         beq   L0525
         cmpa  #$4C
         bne   L050F
         pshu  x
         lbsr  L06C2
         bra   L0525
L050F    cmpa  #$23
         bne   L0517
         bsr   L0540
         bra   L04F8
L0517    cmpa  #$24
         lbne  L1287
L051D    bsr   L0553
         cmpa  #$24
         beq   L051D
         bra   L0500
L0525    ldb   <u0042
         pshu  b
         puls  pc,b,a
L052B    lbsr  L069A
         pshs  a
         cmpa  #$0D
         beq   L053E
         inc   <u0042
L0536    leay  $01,y
         lda   ,y
         bsr   L04DA
         beq   L0536
L053E    puls  pc,a
L0540    pshs  b,a
         lda   ,x
         cmpa  #$23
         bne   L054C
         bsr   L05B3
         bra   L0551
L054C    lbsr  L05D6
         pshu  b,a
L0551    puls  pc,b,a
L0553    pshs  b
         lbsr  L0691
         cmpa  #$24
         bne   L0562
         bsr   L05B3
         bsr   L052B
         bra   L057E
L0562    pshu  x
         lbsr  L0122
         leax  d,x
         leax  $02,x
         bsr   L052B
         cmpa  #$24
         bne   L057E
         pshs  x,a
         lbsr  L0691
         cmpa  #$24
         puls  x,a
         beq   L057E
         leax  -$01,x
L057E    puls  pc,b
L0580    pshs  y,x,a
         ldy   <u0029
         ldb   #$00
L0587    lbsr  L069A
         cmpa  #$0D
         beq   L05AB
         lbsr  L0691
         addb  #$01
         lda   ,x+
         cmpa  ,y+
         bne   L059E
         lbsr  L046B
         beq   L05AD
L059E    ldx   $01,s
L05A0    lda   ,y+
         lbsr  L04DA
         beq   L05A0
         leay  -$01,y
         bra   L0587
L05AB    ldb   #$00
L05AD    stx   $01,s
         cmpb  #$00
         puls  pc,y,x,a
L05B3    pshs  y
         lda   ,x
         cmpa  #$24
         beq   L05C1
         cmpa  #$23
         lbne  L1287
L05C1    bsr   L0580
         lbeq  L1290
         ldy   <u0027
         negb  
         addb  $04,y
         lslb  
         leay  $05,y
         ldd   b,y
         pshu  b,a
         puls  pc,y
L05D6    lda   ,x
         cmpa  #$2A
         bne   L05E3
         leax  $01,x
         ldd   #$FFFF
         bra   L05F3
L05E3    ldd   #$0000
         bsr   L0600
         bne   L05EF
         ldd   #$0001
         bra   L05F3
L05EF    bsr   L0600
         bne   L05EF
L05F3    rts   
L05F4    beq   L0606
         com   <u00E8
         neg   <u0064
         neg   <u000A
         neg   <u0001
         neg   <u0000
L0600    pshs  y,b,a
         ldb   ,x
         subb  #$30
L0606    cmpb  #$0A
         bcc   L0622
         leax  $01,x
         lda   #$00
         ldy   #$000A
L0612    addd  ,s
         lbcs  L1266
         leay  -$01,y
         bne   L0612
         std   ,s
         andcc #$FB
         puls  pc,y,b,a
L0622    orcc  #$04
         puls  pc,y,b,a
L0626    pshs  y,x,b,a
         leax  >L05F4,pcr
         ldy   #$2F20
L0630    leay  >$0100,y
         subd  ,x
         bcc   L0630
         addd  ,x++
         pshs  b,a
         ldd   ,x
         tfr   y,d
         beq   L0659
         ldy   #$2F30
         cmpd  #$3020
         bne   L0652
         ldy   #$2F20
         tfr   b,a
L0652    lbsr  L0107
         puls  b,a
         bra   L0630
L0659    lbsr  L0107
         leas  $02,s
         puls  pc,y,x,b,a
L0660    pshs  x,b,a
         ldx   <u0027
         ldd   -$02,x
         puls  pc,x,b,a
L0668    pshs  x,b,a
         tst   <u0023
         beq   L0683
         ldx   <u0027
         ldd   -$02,x
         beq   L0683
         cmpd  #$FFFF
         bne   L067E
         andcc #$FB
         bra   L0683
L067E    subd  #$0001
         std   -$02,x
L0683    puls  pc,x,b,a
L0685    pshs  x,b,a
         ldx   <u0027
         ldd   -$02,x
         cmpd  #$FFFF
         puls  pc,x,b,a
L0691    lda   ,x+
         cmpa  #$20
         beq   L0691
         leax  -$01,x
         rts   
L069A    lda   ,y+
         cmpa  #$20
         beq   L069A
         leay  -$01,y
         rts   
L06A3    pshs  b,a
         ldd   <u001C
         sty   <u001C
         bsr   L06B2
         pshs  cc
         std   <u001C
         puls  pc,b,a,cc
L06B2    pshs  a
L06B4    cmpx  <u001C
         beq   L06C0
         lda   ,x+
         cmpa  #$0D
         bne   L06B4
         andcc #$FB
L06C0    puls  pc,a
L06C2    cmpx  <u001C
         beq   L06CE
         bsr   L06B2
         cmpx  <u0018
         beq   L06CE
         leax  -$01,x
L06CE    andcc #$FB
         rts   
L06D1    bsr   L06D7
         beq   L06E9
         leax  -$01,x
L06D7    pshs  a
L06D9    cmpx  <u0018
         beq   L06E7
         lda   ,-x
         cmpa  #$0D
         bne   L06D9
         leax  $01,x
         andcc #$FB
L06E7    puls  a
L06E9    rts   
L06EA    pshs  y,x,b,a
         ldd   #$000B
         ldy   <u001C
         lbsr  L0BC0
         leax  d,y
         sty   <u0016
         stx   <u001C
         stx   <u0018
         stx   <u001A
         std   ,y
         std   $02,y
         lda   ,s
         sta   $04,y
         ldd   $04,s
         std   $05,y
         ldd   <u0000
         std   <u0004
         ldd   <u0002
         std   <u0006
         puls  pc,y,x,b,a
L0716    pshs  y,x,b,a
         stx   <u001A
         ldd   ,x
         lbsr  L0BEC
         nega  
         negb  
         sbca  #$00
         ldx   <u001C
         leax  d,x
         stx   <u0016
         leay  $0B,x
         sty   <u0018
         ldd   $02,x
         leay  d,x
         sty   <u001A
         ldd   $07,x
         std   <u0004
         ldd   $09,x
         std   <u0006
         puls  pc,y,x,b,a
L073F    pshs  y,x,b,a
         ldx   <u0016
         ldd   <u001C
         subd  <u0016
         std   ,x
         ldd   <u001A
         subd  <u0016
         std   $02,x
         ldd   <u0004
         std   $07,x
         ldd   <u0006
         std   $09,x
         lda   $04,x
         cmpa  #$42
         bne   L0763
         ldd   $05,x
         std   <u0024
         bra   L076E
L0763    ldy   <u0014
         sty   <u001A
         ldd   ,x
         lbsr  L0C38
L076E    puls  pc,y,x,b,a
L0770    pshs  b,a
         ldx   <u0014
L0774    lda   $04,x
         cmpa  #$42
         bne   L0781
         ldd   ,s
         cmpd  $05,x
         beq   L0788
L0781    lbsr  L089B
         bcs   L0774
         andcc #$FB
L0788    puls  pc,b,a
         ldx   <u0012
         ldd   u0005,u
         addd  #$041F
         leax  d,x
         cmpx  <u001C
         bls   L07A1
         os9   F$Mem    
         lbcs  L12AA
         sty   <u001E
L07A1    pulu  pc,u
         lbsr  L0922
         lbsr  L00FF
         ldd   <u001C
         subd  <u0014
         lbsr  L0626
         lda   #$20
         lbsr  L0107
         lbsr  L0107
         ldd   <u001E
         subd  <u0014
         lbsr  L0626
         lbsr  L00FF
         lbra  L0929
         ldx   <u0016
         lda   $04,x
         cmpa  #$42
         lbne  L127E
         ldd   <u001C
         subd  <u0016
         std   ,x
         ldd   u0005,u
         cmpd  $05,x
         beq   L07F9
         bsr   L0770
         beq   L07F3
         ldd   #$000B
         lbsr  L0BC0
         lbsr  L073F
         lda   #$42
         ldy   u0005,u
         lbsr  L06EA
         pulu  pc,u
L07F3    lbsr  L073F
         lbsr  L0716
L07F9    pulu  pc,u
         tst   <u0041
         lbne  L127E
         ldx   <u0016
         lda   $04,x
         cmpa  #$42
         lbne  L127E
         ldx   $05,x
         ldy   <u0024
         pshs  y,x
         ldx   u0005,u
         lbsr  L0691
         cmpa  $01,x
         bne   L0825
         lbsr  L073F
         lda   #$4D
         lbsr  L06EA
         bra   L0836
L0825    leax  $01,x
         lbsr  L04A1
         lbeq  L1278
         lbsr  L073F
         tfr   d,x
         lbsr  L0716
L0836    puls  y,x
         stx   <u0024
         sty   <u002D
         lda   #$4D
         sta   <u0026
         pulu  pc,u
         lbsr  L0922
         leax  >L13C6,pcr
         lbsr  L00EF
         ldx   <u0014
L084F    ldb   $04,x
         cmpb  #$42
         bne   L0873
         ldd   $05,x
         cmpx  <u0016
         beq   L0863
         cmpd  <u0024
         beq   L0866
         lda   #$20
         cmpx  #$862A
         cmpx  #$8624
         lbsr  L0107
         ldd   $05,x
         lbsr  L0626
         lbsr  L00FF
L0873    bsr   L089B
         bcs   L084F
         leax  >L13BE,pcr
         lbsr  L00EF
         ldx   <u0014
L0880    pshs  x
         lda   $04,x
         cmpa  #$4D
         bne   L0893
         leax  $0B,x
         lbsr  L008B
         puls  x
         bsr   L089B
         bcs   L0880
L0893    lbsr  L00FF
         lbsr  L0929
         pulu  pc,u
L089B    pshs  b,a
         ldd   ,x
         leax  d,x
         cmpx  <u001C
         puls  pc,b,a
         tst   <u0041
         lbne  L127E
         ldx   u0005,u
         lda   ,x+
         pshs  a
         lbsr  L0691
         lbsr  L04A1
         lbeq  L1278
         tfr   d,y
         ldd   ,y
         ldx   <u001A
         pshs  x,b,a
         sty   <u001A
         lbsr  L0BEC
         ldd   <u0016
         subd  ,s
         std   <u0016
         ldd   <u0018
         subd  ,s
         std   <u0018
         ldd   <u001C
         subd  ,s
         std   <u001C
         puls  x
         puls  b,a
         pshs  x
         subd  ,s++
         std   <u001A
         pulu  pc,u
         pshs  u
         ldx   u0005,u
         lbsr  L0130
         tfr   d,y
         tfr   x,u
         leax  <L090C,pcr
         lda   #$01
         ldb   #$00
         os9   F$Fork   
         lbcs  L12AA
         os9   F$Wait   
         tstb  
         lbne  L12AA
         puls  u
         pulu  pc,u
L090C    comb  
         lsla  
         fcb   $45 E
         inca  
         inca  
         tst   <u00EC
         fcb   $45 E
         beq   L0918
         lda   #$01
L0918    sta   <u003E
         tst   <u0041
         bne   L0920
         sta   <u0040
L0920    pulu  pc,u
L0922    lda   <u003E
         sta   <u003F
         inc   <u003E
         rts   
L0929    lda   <u003F
         sta   <u003E
         rts   
         ldx   ,u
         ldx   $02,x
         ldy   <u0045
         cmpy  <u0049
         lbls  L128D
         stx   ,--y
         ldx   #$0000
         stx   ,--y
         sty   <u0045
         pulu  pc,u
         ldx   <u0045
         ldd   ,x
         addd  #$0001
         std   ,x
         cmpd  u0005,u
         bcs   L095A
         bsr   L0964
         pulu  pc,u
L095A    ldy   $02,x
         ldx   ,u
         sty   $02,x
         pulu  pc,u
L0964    pshs  x
         ldx   <u0045
         leax  $04,x
         cmpx  <u0043
         lbhi  L128A
         stx   <u0045
         puls  pc,x
         bsr   L0922
         ldx   <u001A
         lbsr  L0660
         beq   L098A
L097D    lbsr  L008B
         lbsr  L06B2
         beq   L098A
         lbsr  L0668
         bne   L097D
L098A    bsr   L0929
         pulu  pc,u
         bsr   L0922
         lbsr  L0660
         beq   L09AF
         ldx   <u001A
         lbsr  L06D7
         bra   L09A1
L099C    lbsr  L06D1
         beq   L09A6
L09A1    lbsr  L0668
         bne   L099C
L09A6    pshs  x
         ldd   <u001A
         subd  ,s++
         lbsr  L0094
L09AF    lbsr  L0929
         pulu  pc,u
         inc   <u002F
         ldd   u0005,u
         std   <u0030
         bne   L09BE
         clr   <u002F
L09BE    pulu  pc,u
L09C0    lbsr  L06B2
         beq   L09D4
L09C5    pshs  b,a
         ldd   <u0030
         lbsr  L0B01
         puls  b,a
         bne   L09C0
         cmpx  <u001A
         bcs   L09C0
L09D4    rts   
L09D5    pshs  y,x
         ldx   <u0010
         stx   $02,s
         puls  pc,x
L09DD    pshs  y,b,a
         ldx   <u001A
         lda   ,y+
         tst   <u002F
         beq   L09E9
         bsr   L09C5
L09E9    pshs  y,x
L09EB    cmpa  ,y
         beq   L0A0B
         ldb   ,y+
         cmpx  <u001C
         bcc   L0A05
         cmpb  ,x+
         beq   L09EB
         puls  y,x
         leax  $01,x
         tst   <u002F
         beq   L09E9
         bsr   L09C0
         bra   L09E9
L0A05    orcc  #$01
         bra   L0A0B
         andcc #$FE
L0A0B    puls  y,x
         puls  pc,y,b,a
L0A0F    lbsr  L1126
         tst   <u0041
         bne   L0A29
         tst   <u003D
         beq   L0A29
         inc   <u0039
         lbsr  L0922
         leax  >L1318,pcr
         lbsr  L00EF
         lbsr  L0929
L0A29    pulu  pc,u
L0A2B    pshs  y,x,b,a
         lbsr  L0660
         andcc #$FE
         beq   L0A4E
         ldx   u0005,u
         lbsr  L0122
L0A39    ldy   u0005,u
         bsr   L09D5
         bcs   L0A4E
         lbsr  L0082
         leax  d,x
         stx   <u001A
         lbsr  L0668
         bne   L0A39
         andcc #$FE
L0A4E    puls  pc,y,x,b,a
L0A50    pshs  y,x,b,a
         lbsr  L0660
         andcc #$FE
         beq   L0A94
         ldx   u0005,u
         lbsr  L0122
         pshs  b,a
         ldx   u0007,u
         lbsr  L0122
         pshs  b,a
L0A67    ldd   $02,s
         subd  ,s
         lbsr  L0BC0
         ldy   u0007,u
         lbsr  L09D5
         bcs   L0A92
         stx   <u001A
         ldd   ,s
         lbsr  L100F
         ldx   u0005,u
         leax  $01,x
         ldd   $02,s
         lbsr  L0BE3
         ldx   <u001A
         lbsr  L0082
         lbsr  L0668
         bne   L0A67
         andcc #$FE
L0A92    leas  $04,s
L0A94    puls  pc,y,x,b,a
         lbsr  L0A2B
         lbcs  L0A0F
         rts   
         lbsr  L0A50
         lbcs  L0A0F
         rts   
         ldx   <u001A
         lbsr  L0A50
         bra   L0AB2
         ldx   <u001A
         lbsr  L0A2B
L0AB2    pshs  cc
         cmpx  <u001A
         beq   L0ABF
         ldx   <u001A
         lbsr  L06D7
         stx   <u001A
L0ABF    puls  cc
         lbcs  L0A0F
         rts   
         lbsr  L0660
         beq   L0AFF
         ldx   u0005,u
         lbsr  L0122
         leax  $01,x
L0AD2    pshs  x,b,a
         ldx   <u001A
         cmpx  <u001C
         bcs   L0ADF
         lbsr  L1126
         bra   L0AFF
L0ADF    lbsr  L06C2
         ldd   ,s
         lbsr  L0BC0
         stx   <u001A
         ldx   $02,s
         lbsr  L0BE3
         ldx   <u001A
         lbsr  L0082
         lbsr  L06B2
         stx   <u001A
         puls  x,b,a
         lbsr  L0668
         bne   L0AD2
L0AFF    pulu  pc,u
L0B01    pshs  y
         cmpd  #$0000
         beq   L0B26
         tfr   d,y
         lbsr  L06D7
L0B0E    lda   ,x
         cmpa  #$0D
         beq   L0B20
         cmpx  <u001C
         bcc   L0B20
         leax  $01,x
         leay  -$01,y
         bne   L0B0E
         leax  -$01,x
L0B20    tfr   y,d
         cmpd  #$0000
L0B26    puls  pc,y
         lbsr  L0660
         beq   L0B5C
         ldx   <u001A
         ldd   u0005,u
         bsr   L0B01
         stx   <u001A
         std   u0005,u
         beq   L0B5C
         tfr   d,y
         lbsr  L0668
         beq   L0B5C
         leay  -$01,y
         lda   #$20
         ldx   <u001C
         pshs  x
L0B48    cmpx  <u001E
         lbcc  L126F
         sta   ,x+
         lbsr  L0668
         bne   L0B48
         tfr   y,d
         puls  x
         lbsr  L0BE3
L0B5C    pulu  pc,u
         lbsr  L0660
         beq   L0B94
         ldx   <u001A
         lbsr  L06D7
         pshs  x
         ldx   u0005,u
         lbsr  L0122
         leax  $01,x
         ldy   <u001C
L0B74    bsr   L0B96
         lbeq  L126F
         lbsr  L0668
         bne   L0B74
         ldx   <u001C
         tfr   y,d
         subd  <u001C
         bsr   L0BE3
         lda   #$0D
         bsr   L0BB5
         ldx   ,s
         ldd   <u001A
         subd  ,s++
         lbsr  L0094
L0B94    pulu  pc,u
L0B96    pshs  u,x,b,a
         tfr   d,u
L0B9A    cmpy  <u001E
         bcc   L0BB1
         cmpu  #$0000
         beq   L0BAD
         lda   ,x+
         sta   ,y+
         leau  -u0001,u
         bra   L0B9A
L0BAD    andcc #$FB
         puls  pc,u,x,b,a
L0BB1    orcc  #$04
         puls  pc,u,x,b,a
L0BB5    pshs  x,b,a
         tfr   s,x
         ldd   #$0001
         bsr   L0BE3
         puls  pc,x,b,a
L0BC0    pshs  x
         ldx   <u001C
         leax  d,x
         cmpx  <u001E
         lbcc  L126F
         puls  pc,x
L0BCE    pshs  y
         ldy   <u001C
         bsr   L0B96
         lbeq  L126F
         sty   <u001C
         puls  pc,y
L0BDE    lda   #$0D
         lbsr  L0132
L0BE3    bsr   L0BCE
         bsr   L0C38
         addd  <u001A
         std   <u001A
         rts   
L0BEC    pshs  u,y,x,b,a
         cmpd  #$0000
         beq   L0C36
         std   <u00CF
         ldd   <u001A
         subd  <u001C
         tfr   d,y
         addd  ,s
         std   <u00D1
         ldd   <u001C
         subd  <u00CF
         std   <u00D3
         ldx   <u001C
         lda   ,-x
         stx   <u00D5
         sta   <u00CD
         bra   L0C22
L0C10    cmpx  <u00D5
         bne   L0C1E
         lda   <u00CD
         sta   ,u
         lda   ,-x
         stx   <u00D5
         sta   <u00CD
L0C1E    leay  $01,y
         beq   L0C36
L0C22    ldd   <u00D1
L0C24    tfr   x,u
         leax  d,x
         lda   ,x
         sta   ,u
         cmpx  <u00D3
         bcc   L0C10
         ldd   <u00CF
         leay  $01,y
         bne   L0C24
L0C36    puls  pc,u,y,x,b,a
L0C38    pshs  b,a
         ldd   <u001C
         subd  <u001A
         subd  ,s
         bsr   L0BEC
         puls  pc,b,a
         lbsr  L0660
         beq   L0CAF
         ldd   <u0024
         lbsr  L0770
         pshs  x
         ldd   ,x
         leay  d,x
         leax  $0B,x
         pshs  x
L0C58    pshs  y
         cmpx  ,s++
         bne   L0C63
         lbsr  L1126
         bra   L0C6D
L0C63    lbsr  L06A3
         beq   L0C6D
         lbsr  L0668
         bne   L0C58
L0C6D    tfr   x,d
         subd  ,s
         puls  y,x
         pshs  b,a
         lbsr  L0094
         ldd   $02,y
         subd  #$000B
         subd  ,s
         bcc   L0C84
         ldd   #$0000
L0C84    addd  #$000B
         std   $02,y
         ldd   ,y
         subd  ,s
         std   ,y
         ldd   <u0016
         subd  ,s
         std   <u0016
         ldd   <u0018
         subd  ,s
         std   <u0018
         puls  b,a
         ldy   <u001A
         stx   <u001A
         ldx   <u001C
         sty   <u001C
         lbsr  L0BEC
         stx   <u001C
         sty   <u001A
L0CAF    pulu  pc,u
         lbsr  L0660
         beq   L0D0D
         ldx   <u001C
         pshs  x
         ldd   <u0024
         lbsr  L0770
         pshs  x
         ldx   <u001A
         pshs  x
L0CC5    cmpx  <u001C
         bcs   L0CCE
         lbsr  L1126
         bra   L0CD8
L0CCE    lbsr  L06B2
         beq   L0CD8
         lbsr  L0668
         bne   L0CC5
L0CD8    tfr   x,d
         subd  ,s
         puls  y,x
         lbsr  L0094
         leax  d,x
         pshs  x,b,a
         stx   <u001C
         ldd   ,y
         addd  ,s
         std   ,y
         ldd   $02,y
         leax  d,y
         stx   <u001A
         addd  ,s
         std   $02,y
         ldd   <u0016
         addd  ,s
         std   <u0016
         ldd   <u0018
         addd  ,s
         std   <u0018
         puls  y,x,b,a
         lbsr  L0C38
         stx   <u001A
         sty   <u001C
L0D0D    pulu  pc,u
         tst   <u0005
         beq   L0D4D
         lbsr  L0660
         beq   L0D7A
         ldx   <u001C
L0D1A    leay  >$0080,x
         cmpy  <u001E
         bls   L0D28
         bsr   L0D68
         lbra  L126F
L0D28    lda   <u0004
         ldy   #$0080
         os9   I$ReadLn 
         bcc   L0D5F
         pshs  b
         bsr   L0D68
         puls  b
         cmpb  #$D3
         lbne  L12AA
         ldd   <u0004
         cmpd  <u0000
         beq   L0D4D
         os9   I$Close  
         lbcs  L12AA
L0D4D    clr   <u0005
         lbsr  L1126
         tst   <u0041
         bne   L0D5D
         leax  >L138A,pcr
         lbsr  L00EF
L0D5D    bra   L0D7A
L0D5F    tfr   y,d
         leax  d,x
         lbsr  L0668
         bne   L0D1A
L0D68    tfr   x,d
         subd  <u001C
         ldx   <u001A
         pshs  x,b,a
         ldx   <u001C
         lbsr  L0BE3
         puls  x,b,a
         lbsr  L0094
L0D7A    rts   
         tst   <u0007
         lbeq  L1275
         lbsr  L0660
         beq   L0DB5
         ldy   <u001A
L0D89    tfr   y,x
         lbsr  L0130
         bne   L0D9D
         bsr   L0DA9
         lbsr  L1126
         leax  >L137C,pcr
         lbsr  L00EF
         rts   
L0D9D    leay  d,x
         lda   <u0006
         lbsr  L00C8
         lbsr  L0668
         bne   L0D89
L0DA9    ldx   <u001A
         tfr   y,d
         subd  <u001A
         lbsr  L0094
         lbsr  L100F
L0DB5    rts   
         ldd   <u0004
         cmpd  <u0000
         beq   L0DC9
         tstb  
         beq   L0DC9
         os9   I$Close  
         lbcs  L12AA
         clr   <u0005
L0DC9    ldx   u0005,u
         ldb   ,x+
         cmpb  ,x
         bne   L0DD7
         ldd   <u0000
         std   <u0004
         pulu  pc,u
L0DD7    lbsr  L0EC6
         lbne  L12A8
         lda   #$01
         os9   I$Open   
         lbcs  L12AA
         ldb   #$01
         std   <u0004
         pulu  pc,u
         ldd   <u0006
         cmpd  <u0002
         beq   L0E00
         tstb  
         beq   L0E00
         os9   I$Close  
         lbcs  L12AA
         clr   <u0007
L0E00    ldx   u0005,u
         ldb   ,x+
         cmpb  ,x
         bne   L0E0E
         ldd   <u0002
         std   <u0006
         pulu  pc,u
L0E0E    lbsr  L0EC6
         lbne  L12A8
         ldd   #$021B
         os9   I$Create 
         lbcs  L12AA
         ldb   #$01
         std   <u0006
         pulu  pc,u
         ldx   u0005,u
         ldb   ,x+
         lbsr  L0EC6
         lbne  L12A8
         lda   #$01
         os9   I$Open   
         lbcs  L12AA
         sta   <u0008
L0E3B    ldx   <u001C
         ldy   #$000B
         bsr   L0EB7
         lda   <u0008
         os9   I$Read   
         bcs   L0E6E
         lda   $04,x
         cmpa  #$4D
         beq   L0E58
         ldd   $05,x
         beq   L0E58
         ldb   #$D3
         bra   L0E6E
L0E58    clr   $08,x
         clr   $0A,x
         ldd   ,x
         subd  #$000B
         tfr   d,y
         leax  $0B,x
         bsr   L0EB7
         lda   <u0008
         os9   I$Read   
         bcc   L0E7F
L0E6E    pshs  b
         lda   <u0008
         os9   I$Close  
         puls  b
         cmpb  #$D3
         lbne  L12AA
         pulu  pc,u
L0E7F    lbsr  L0691
         pshs  x
         lbsr  L04A1
         puls  x
         bne   L0E3B
         lbsr  L008B
         ldx   <u001C
         ldd   ,x
         ldy   <u001A
         leax  d,x
         stx   <u001C
         pshs  y,b,a
         ldx   <u0014
         stx   <u001A
         lbsr  L0C38
         ldd   <u0016
         addd  ,s
         std   <u0016
         ldd   <u0018
         addd  ,s
         std   <u0018
         puls  y,b,a
         leay  d,y
         sty   <u001A
         bra   L0E3B
L0EB7    pshs  y,b,a
         tfr   y,d
         leay  d,x
         cmpy  <u001E
         lbcc  L126F
         puls  pc,y,b,a
L0EC6    lbsr  L0691
         pshs  y,x
         leay  ,x
L0ECD    cmpb  ,y+
         bne   L0ECD
         pshs  y
         lbsr  L015A
         bcs   L0EE1
         cmpy  ,s++
         bcc   L0EE1
         orcc  #$04
         puls  pc,y,x
L0EE1    andcc #$FB
         puls  pc,y,x
         ldx   #$FFFF
         pshs  x
         ldx   u0007,u
         leax  $01,x
         lbsr  L0691
L0EF1    lbsr  L04A1
         lbeq  L1278
         pshs  b,a
         lbsr  L0691
         ldy   u0007,u
         cmpa  ,y
         bne   L0EF1
         ldx   u0005,u
         ldb   ,x+
         bsr   L0EC6
         lbne  L12A8
         ldd   #$021B
         os9   I$Create 
         lbcs  L12AA
         sta   <u0008
L0F1A    puls  x
         cmpx  #$FFFF
         beq   L0F3C
         ldd   #$0000
         std   $05,x
         ldy   ,x
         lda   <u0008
         os9   I$Write  
         bcc   L0F1A
         pshs  b
         lda   <u0008
         os9   I$Close  
         puls  b
         lbra  L12AA
L0F3C    lda   <u0008
         os9   I$Close  
         pulu  pc,u
L0F43    tst   <u0001
         beq   L0F8E
         ldx   <u001C
         leay  d,x
         leay  >$0080,y
         cmpy  <u001E
         bcs   L0F5D
         cmpd  #$0080
         bcs   L0F8E
         subd  #$0080
L0F5D    tfr   d,y
         lda   <u0000
         os9   I$Read   
         bcs   L0F77
         tfr   y,d
         leax  d,x
         stx   <u001C
         ldy   #$0080
         lda   <u0000
         os9   I$ReadLn 
         bcc   L0F88
L0F77    cmpb  #$D3
         lbne  L12AA
         leax  >L138A,pcr
         lbsr  L00EF
         clr   <u0005
         bra   L0F8E
L0F88    tfr   y,d
         leax  d,x
         stx   <u001C
L0F8E    rts   
         tst   <u0003
         beq   L0FA8
         ldx   <u0018
         ldd   <u001A
         subd  <u0018
         tfr   d,y
         lda   <u0002
         os9   I$Write  
         stx   <u001A
         tfr   y,d
         bsr   L100F
         bsr   L0F43
L0FA8    pulu  pc,u
         lbsr  L0660
         beq   L0FD4
         ldx   <u001A
         lbsr  L06D7
         stx   <u001A
         pshs  x
L0FB8    cmpx  <u001C
         bne   L0FC1
         lbsr  L1126
         bra   L0FCE
L0FC1    lbsr  L008B
         lbsr  L06B2
         beq   L0FCE
         lbsr  L0668
         bne   L0FB8
L0FCE    tfr   x,d
         subd  ,s++
         bsr   L100F
L0FD4    pulu  pc,u
         lbsr  L0660
         beq   L0FFA
         ldx   <u001A
         pshs  x
L0FDF    cmpx  <u001C
         bne   L0FE8
         lbsr  L1126
         bra   L0FEF
L0FE8    leax  $01,x
         lbsr  L0668
         bne   L0FDF
L0FEF    tfr   x,d
         subd  ,s
         puls  x
         lbsr  L0094
         bsr   L100F
L0FFA    pulu  pc,u
         ldx   <u001A
         lbsr  L0130
         beq   L100D
         subd  #$0001
         beq   L100D
         bsr   L100F
         lbsr  L0082
L100D    pulu  pc,u
L100F    pshs  b,a
         lbsr  L0BEC
         ldd   <u001C
         subd  ,s
         std   <u001C
         puls  pc,b,a
         lbsr  L0660
         beq   L1035
         ldx   <u001A
L1023    cmpx  <u0018
         bne   L102C
         lbsr  L1126
         bra   L1033
L102C    leax  -$01,x
         lbsr  L0668
         bne   L1023
L1033    stx   <u001A
L1035    pulu  pc,u
         lbsr  L0660
         beq   L1035
         ldx   <u001A
L103E    cmpx  <u001C
         bne   L1047
         lbsr  L1126
         bra   L1033
L1047    leax  $01,x
         lbsr  L0668
         bne   L103E
         bra   L1033
         ldx   <u001A
         lbsr  L0660
         bne   L105C
         lbsr  L06C2
         bra   L106F
L105C    cmpx  <u001C
         bne   L1065
         lbsr  L1126
         bra   L106F
L1065    lbsr  L06B2
         beq   L106F
         lbsr  L0668
         bne   L105C
L106F    stx   <u001A
         lbsr  L008B
         pulu  pc,u
         ldx   <u001A
         lbsr  L0660
         bne   L1082
         lbsr  L06D7
         bra   L106F
L1082    cmpx  <u0018
         bne   L108B
         lbsr  L1126
         bra   L106F
L108B    lbsr  L06D1
         beq   L106F
         lbsr  L0668
         bne   L1082
         bra   L106F
         ldx   <u0018
         stx   <u001A
         pulu  pc,u
         ldx   <u001C
         stx   <u001A
         pulu  pc,u
         lda   #$01
         sta   <u003C
         clr   <u003A
         pulu  pc,u
L10AB    lda   #$01
         sta   <u003D
         clr   <u003A
         pulu  pc,u
L10B3    clra  
         sta   <u003D
         sta   <u003A
         pulu  pc,u
         ldx   <u001A
         cmpx  <u001C
         beq   L10AB
         lda   ,x
         cmpa  #$0D
         beq   L10AB
         bra   L10B3
         ldx   <u001A
         cmpx  <u001C
         beq   L10B3
         lda   ,x
         cmpa  #$0D
         beq   L10B3
         bra   L10AB
         ldx   <u001A
         cmpx  <u001C
         bne   L10B3
         bra   L10AB
         ldx   <u001A
         cmpx  <u001C
         beq   L10B3
         bra   L10AB
         bsr   L10F2
         bne   L10AB
         bra   L10B3
         bsr   L10F2
         beq   L10AB
         bra   L10B3
L10F2    ldx   u0005,u
         ldy   <u001A
         ldb   ,x+
L10F9    cmpb  ,x
         beq   L110A
         cmpy  <u001C
         beq   L1108
         lda   ,x+
         cmpa  ,y+
         beq   L10F9
L1108    andcc #$FB
L110A    rts   
         tst   <u0005
         bne   L10B3
         bra   L10AB
         lda   <u0005
         beq   L10B3
         bra   L10AB
         ldd   u0005,u
         beq   L10B3
         bra   L10AB
         lda   #$00
         lbsr  L0685
         beq   L10B3
         bra   L10AB
L1126    pshs  a
         lbsr  L0685
         beq   L1133
         lda   #$01
         sta   <u003D
         clr   <u003A
L1133    puls  pc,a
         lda   #$00
         sta   <u003D
         sta   <u003A
         inca  
         sta   <u003B
         pulu  pc,u
         lda   #$00
         sta   <u003A
         inca  
         sta   <u003D
         sta   <u003B
         pulu  pc,u
         pulu  pc,u
         tst   <u0041
         lbne  L127E
         ldx   <u0016
         lda   $04,x
         cmpa  #$42
         beq   L11C5
         ldx   <u001C
         cmpx  <u0018
         lbeq  L1281
         lda   #$0D
         cmpa  -$01,x
         beq   L1175
         leax  $01,x
         cmpx  <u001E
         lbcc  L126F
         sta   -$01,x
         stx   <u001C
L1175    ldx   <u0018
         lbsr  L0691
         lbsr  L04DA
         lbne  L1281
         pshs  x
L1183    lda   ,x+
         lbsr  L04DA
         beq   L1183
         cmpa  #$20
         beq   L119C
         cmpa  #$0D
         beq   L119C
         cmpa  #$24
         beq   L119C
         cmpa  #$23
         lbne  L1281
L119C    ldx   ,s
         lbsr  L04A1
         lbne  L1284
         ldb   #$2E
         puls  x
         lbsr  L0415
         lbeq  L1284
         lbsr  L073F
         ldd   <u0024
         lbsr  L0770
         lbsr  L0716
         ldd   <u002D
         std   <u0024
         lda   #$45
         sta   <u0026
         pulu  pc,u
L11C5    ldd   #$0001
         lbsr  L0770
         cmpx  <u0016
         beq   L11D2
         lbra  L126C
L11D2    ldy   <u0012
         leay  >$0089,y
L11D9    ldx   ,y++
         beq   L11E4
         jsr   ,x
         os9   F$UnLink 
         bra   L11D9
L11E4    ldx   <u0018
         ldd   <u001C
         subd  <u0018
         tfr   d,y
L11EC    ldd   <u0002
         cmpb  #$00
         beq   L1261
         os9   I$Write  
         bcs   L1263
         ldx   <u0014
         ldd   <u001E
         subd  <u0014
         tfr   d,y
         ldd   <u0000
         cmpb  #$00
         beq   L1261
         os9   I$Read   
         bcc   L11EC
         cmpb  #$D3
         bne   L1263
         tst   <u0036
         beq   L1261
         ldd   <u001E
         subd  <u0014
         os9   F$Mem    
         bcs   L1263
         lda   <u0000
         os9   I$Close  
         bcs   L1263
         lda   <u0002
         os9   I$Close  
         bcs   L1263
         ldx   <u0032
         os9   I$Delete 
         bcs   L1261
         ldy   <u0032
L1233    ldx   <u0032
L1235    lda   ,y+
         sta   ,x+
         cmpa  #$2F
         beq   L1233
         cmpa  #$0D
         bne   L1235
         ldy   <u0012
         leax  >$00FE,y
         tfr   x,u
         lbsr  L0130
         leax  >$00F7,y
         tfr   d,y
         ldd   #$0100
         os9   F$Fork   
         bcs   L1263
         os9   F$Wait   
         tstb  
         bne   L1263
L1261    ldb   #$00
L1263    os9   F$Exit   
L1266    ldb   #$00
         cmpx  #$C60B
         cmpx  #$C613
         cmpx  #$C622
         cmpx  #$C633
         cmpx  #$C641
         cmpx  #$C64F
         cmpx  #$C659
         cmpx  #$C65F
         cmpx  #$C66D
         cmpx  #$C67C
         cmpx  #$C687
         cmpx  #$C694
         cmpx  #$C694
         cmpx  #$C6A5
         lda   #$FF
         sta   <u0023
         inc   <u003E
         leax  >L12C9,pcr
         clra  
         leax  d,x
         lbsr  L00EF
         lbsr  L00FF
         lbra  L0292
L12A8    ldb   #$D7
L12AA    inc   <u003E
         pshs  b
         leax  <L12C5,pcr
         ldy   #$0004
         lda   <u000B
         os9   I$Write  
         puls  b
         os9   F$PErr   
         lbsr  L00FF
         lbra  L0292
L12C5    clra  
         comb  
         rts   
         bra   L130C
         fcb   $41 A
         lsra  
         bra   L131C
         fcb   $55 U
         tsta  
         fcb   $42 B
         fcb   $45 E
         fcb   $52 R
         tst   <u0057
         lsla  
         fcb   $41 A
         lsrb  
         bra   L1319
         swi   
         fcb   $0D 
         bpl   L12FE
         fcb   $4E N
         clra  
         lsrb  
         bra   L1325
         fcb   $55 U
         rora  
         bra   L130A
         leay  $00,y
         bpl   L12F8
         bpl   L1344
         clra  
         fcb   $52 R
         fcb   $4B K
         comb  
         negb  
         fcb   $41 A
         coma  
         fcb   $45 E
         bra   L133D
         fcb   $55 U
L12F8    inca  
         inca  
         bpl   L1309
         tsta  
         rola  
L12FE    comb  
         comb  
         rola  
         fcb   $4E N
         asra  
         bra   L1349
         fcb   $45 E
         inca  
         rola  
         tsta  
L1309    tst   <u002A
         rora  
L130C    rola  
         inca  
         fcb   $45 E
         bra   L1354
         inca  
         clra  
         comb  
         fcb   $45 E
         lsra  
         bpl   L1325
L1318    fcb   $4E N
L1319    clra  
         lsrb  
         bra   L1363
         clra  
         fcb   $55 U
         fcb   $4E N
         lsra  
         tst   <u0042
         fcb   $52 R
         fcb   $45 E
L1325    fcb   $41 A
         fcb   $4B K
         tst   <u004D
         fcb   $41 A
         coma  
         fcb   $52 R
         clra  
         bra   L1378
         comb  
         bra   L1381
         negb  
         fcb   $45 E
         fcb   $4E N
         tst   <u0042
         fcb   $41 A
         lsra  
         bra   L1388
         fcb   $41 A
         coma  
L133D    fcb   $52 R
         clra  
         bra   L138F
         fcb   $41 A
         tsta  
         fcb   $45 E
L1344    tst   <u0044
         fcb   $55 U
         negb  
         inca  
L1349    bra   L1398
         fcb   $41 A
         coma  
         fcb   $52 R
         clra  
         tst   <u0042
         fcb   $41 A
         lsra  
         bra   L13AB
         fcb   $41 A
         fcb   $52 R
         bra   L13A5
         rola  
         comb  
         lsrb  
         tst   <u0042
         fcb   $52 R
         fcb   $41 A
         coma  
         fcb   $4B K
         fcb   $45 E
L1363    lsrb  
         bra   L13B3
         rola  
         comb  
         tsta  
         fcb   $41 A
         lsrb  
         coma  
         lsla  
         tst   <u0055
         fcb   $4E N
         lsra  
         fcb   $45 E
         rora  
         rola  
         fcb   $4E N
         fcb   $45 E
         lsra  
         bra   L13CF
         fcb   $41 A
         fcb   $52 R
         tst   <u002A
         fcb   $45 E
         fcb   $4E N
         lsra  
         bra   L13D1
         rora  
         bra   L13D9
         fcb   $45 E
         lslb  
         lsrb  
L1388    bpl   L1397
L138A    bpl   L13D1
         fcb   $4E N
         lsra  
         bra   L13DF
         rora  
         bra   L13D9
         rola  
         inca  
         fcb   $45 E
         bpl   L13A5
L1398    bpl   L13E0
         fcb   $41 A
         rola  
         inca  
         bpl   L13AC
L139F    fcb   $52 R
         fcb   $45 E
         fcb   $4E N
         fcb   $41 A
         tsta  
         fcb   $45 E
L13A5    bra   L13B4
L13A7    comb  
         coma  
         fcb   $52 R
         fcb   $41 A
L13AB    lsrb  
L13AC    coma  
         lsla  
         bra   L13BD
L13B0    fcb   $45 E
         lsra  
         lsrb  
L13B3    negb  
L13B4    leas  $0D,x
L13B6    fcb   $45 E
         lsra  
         lsrb  
         inca  
         rola  
         fcb   $42 B
         leay  $0D,x
L13BE    tsta  
         fcb   $41 A
         coma  
         fcb   $52 R
         clra  
         comb  
         abx   
         tst   <u0042
         fcb   $55 U
         rora  
         rora  
         fcb   $45 E
         fcb   $52 R
         comb  
         abx   
         tst   <u004D
         fcb   $41 A
L13D1    coma  
         bcc   L13E1
         asr   <u00FB
         fcb   $45 E
         clra  
         rora  
L13D9    tst   <u0011
         fcb   $11 
         fcb   $4E N
         fcb   $45 E
         clra  
L13DF    rora  
L13E0    tst   <u0011
         tim   #$45,<u004F
         fcb   $42 B
         tst   <u0010
         ldu   <u004E
         fcb   $45 E
         clra  
         fcb   $42 B
         tst   <u0010
         ldb   <u0045
         clra  
         inca  
         tst   <u0010
         eorb  #$4E
         fcb   $45 E
         clra  
         inca  
         tst   <u0010
         ora   >$5A45
         fcb   $52 R
         clra  
         bls   L1410
         fcb   $11 
         lbsr  L675B
         fcb   $41 A
         fcb   $52 R
         bls   L1418
         fcb   $11 
         sex   
         comb  
         lsrb  
         fcb   $52 R
L1410    bcc   L141F
         fcb   $10 
         ldb   u000E,u
         comb  
         lsrb  
         fcb   $52 R
L1418    bcc   L1427
         ldq   u0004,u
         rola  
         fcb   $52 R
L141F    tst   <u0008
         coma  
         comb  
         tst   <u0011
         puls  u,b,a
L1427    tst   <u0011
         nega  
         comb  
         fcb   $45 E
         fcb   $41 A
         fcb   $52 R
         coma  
         lsla  
         bls   L1456
         tst   <u000A
         lda   <u0043
         lsla  
         fcb   $41 A
         fcb   $4E N
         asra  
         fcb   $45 E
         bls   L1461
         bcc   L144C
         dec   <u009E
         inca  
         clra  
         fcb   $41 A
         lsra  
         bcc   L1454
         jmp   <u0025
         comb  
         fcb   $41 A
         rorb  
L144C    fcb   $45 E
         bcc   L1473
         tst   <u000E
         bitb  -u000D,u
         rola  
L1454    decb  
         fcb   $45 E
L1456    tst   <u0007
         subd  u0004,u
         fcb   $45 E
         inca  
         bcc   L146B
         lsl   <u00A5
         fcb   $52 R
L1461    fcb   $45 E
         fcb   $41 A
         lsra  
         bcc   L1473
         tst   <u00B6
         asrb  
         fcb   $52 R
         rola  
L146B    lsrb  
         fcb   $45 E
         bcc   L147C
         tst   <u00ED
         comb  
         lsla  
L1473    fcb   $45 E
         inca  
         inca  
         bra   L14C4
         tst   <u0008
         stb   u000E,u
L147C    fcb   $45 E
         asrb  
         tst   <u000F
         fcb   $8F 
         neg   <u0041
         bls   L1492
         rol   <u00B4
         inca  
         bls   L1497
         rol   <u0074
         lslb  
         bls   L149C
         rol   <u008E
         bmi   L14B6
         tst   <u0010
         negb  
         blt   L14BB
         tst   <u0010
         ror   >$4423
         tst   <u000F
         ora   u0005,u
         bls   L14C7
         tst   <u000A
         ldb   #$3C
         bls   L14B6
         fcb   $10 
         andcc #$3E
         bls   L14BB
         cmpr  s,b
         bls   L14D7
         tst   <u000B
         fcb   $5E ^
L14B6    fcb   $4B K
         bls   L14C6
         clr   <u00D6
L14BB    comb  
         bls   L14E2
         tst   <u000A
         jsr   u0003,u
         bls   L14E8
L14C4    bcc   L14D3
L14C6    dec   <u00A6
         fcb   $55 U
         tst   <u000F
         ldd   >$5423
         tst   <u000B
         bvc   L1514
         bls   L14E1
         asr   <u00C5
         fcb   $5E ^
L14D7    tst   <u0010
         sta   <u002F
         tst   <u0010
         jsr   <u004D
         bls   L14EE
L14E1    asr   <u008A
         rorb  
         bls   L14F3
         rol   <u0012
L14E8    asra  
         bls   L14F8
         inc   <u0044
         negb  
L14EE    bls   L14FD
         inc   <u00B1
         fcb   $5B [
L14F3    tst   <u0009
         bgt   L1554
         bls   L1506
         rol   <u0048
         abx   
         tst   <u0010
         subd  -u000E,u
         bls   L150F
         tst   <u000F
         asrb  
         bls   L1514
         tst   <u007B
         brn   L1557
         tst   <u0011
         fcb   $4B K
         fcb   $51 Q
L150F    tst   <u0011
         tsta  
         fcb   $00 
         emod
eom      equ   *
