********************************************************************
* progname - program module
*
* $Id$
*
* Ed.    Comments                                       Who YY/MM/DD
* ------------------------------------------------------------------
*  -     Original Tandy distribution version
*
*

         nam   gfx2
         ttl   subroutine module    

* Disassembled 02/07/06 13:10:09 by Disasm v1.6 (C) 1988 by RML

         ifp1
         use   os9defs
         endc
tylg     set   Sbrtn+Objct   
atrv     set   ReEnt+rev
rev      set   $01
         mod   eom,name,tylg,atrv,start,size
u0000    rmb   0
size     equ   .
name     equ   *
         fcs   /gfx2/
         fcb   $02 
L0012    fcb   $02 
         fcb   $7E þ
         fcb   $44 D
         fcb   $57 W
         fcb   $53 S
         fcb   $65 e
         fcb   $74 t
         fcb   $FF 
         fcb   $02 
         fcb   $AA *
         fcb   $53 S
         fcb   $65 e
         fcb   $6C l
         fcb   $65 e
         fcb   $63 c
         fcb   $74 t
         fcb   $FF 
         fcb   $02 
         fcb   $BD =
         fcb   $4F O
         fcb   $57 W
         fcb   $53 S
         fcb   $65 e
         fcb   $74 t
         fcb   $FF 
         fcb   $02 
         fcb   $E5 e
         fcb   $4F O
         fcb   $57 W
         fcb   $45 E
         fcb   $6E n
         fcb   $64 d
         fcb   $FF 
         fcb   $02 
         fcb   $E9 i
         fcb   $44 D
         fcb   $57 W
         fcb   $45 E
         fcb   $6E n
         fcb   $64 d
         fcb   $FF 
         fcb   $02 
         fcb   $ED m
         fcb   $43 C
         fcb   $57 W
         fcb   $41 A
         fcb   $72 r
         fcb   $65 e
         fcb   $61 a
         fcb   $FF 
         fcb   $03 
         fcb   $01 
         fcb   $44 D
         fcb   $65 e
         fcb   $66 f
         fcb   $42 B
         fcb   $75 u
         fcb   $66 f
         fcb   $66 f
         fcb   $FF 
         fcb   $03 
         fcb   $1C 
         fcb   $4B K
         fcb   $69 i
         fcb   $6C l
         fcb   $6C l
         fcb   $42 B
         fcb   $75 u
         fcb   $66 f
         fcb   $66 f
         fcb   $FF 
         fcb   $03 
         fcb   $37 7
         fcb   $47 G
         fcb   $50 P
         fcb   $4C L
         fcb   $6F o
         fcb   $61 a
         fcb   $64 d
         fcb   $FF 
         fcb   $03 
         fcb   $54 T
         fcb   $47 G
         fcb   $65 e
         fcb   $74 t
         fcb   $FF 
         fcb   $03 
         fcb   $7B û
         fcb   $50 P
         fcb   $75 u
         fcb   $74 t
         fcb   $FF 
         fcb   $03 
         fcb   $95 
         fcb   $50 P
         fcb   $61 a
         fcb   $74 t
         fcb   $74 t
         fcb   $65 e
         fcb   $72 r
         fcb   $6E n
         fcb   $FF 
         fcb   $03 
         fcb   $99 
         fcb   $4C L
         fcb   $6F o
         fcb   $67 g
         fcb   $69 i
         fcb   $63 c
         fcb   $FF 
         fcb   $03 
         fcb   $C8 H
         fcb   $44 D
         fcb   $65 e
         fcb   $66 f
         fcb   $43 C
         fcb   $6F o
         fcb   $6C l
         fcb   $FF 
         fcb   $03 
         fcb   $CD M
         fcb   $50 P
         fcb   $61 a
         fcb   $6C l
         fcb   $65 e
         fcb   $74 t
         fcb   $74 t
         fcb   $65 e
         fcb   $FF 
         fcb   $03 
         fcb   $D2 R
         fcb   $43 C
         fcb   $6F o
         fcb   $6C l
         fcb   $6F o
         fcb   $72 r
         fcb   $FF 
         fcb   $04 
         fcb   $14 
         fcb   $42 B
         fcb   $6F o
         fcb   $72 r
         fcb   $64 d
         fcb   $65 e
         fcb   $72 r
         fcb   $FF 
         fcb   $04 
         fcb   $2F /
         fcb   $53 S
         fcb   $63 c
         fcb   $61 a
         fcb   $6C l
         fcb   $65 e
         fcb   $53 S
         fcb   $77 w
         fcb   $FF 
         fcb   $04 
         fcb   $4A J
         fcb   $44 D
         fcb   $57 W
         fcb   $50 P
         fcb   $72 r
         fcb   $6F o
         fcb   $74 t
         fcb   $53 S
         fcb   $77 w
         fcb   $FF 
         fcb   $04 
         fcb   $4E N
         fcb   $47 G
         fcb   $43 C
         fcb   $53 S
         fcb   $65 e
         fcb   $74 t
         fcb   $FF 
         fcb   $04 
         fcb   $53 S
         fcb   $46 F
         fcb   $6F o
         fcb   $6E n
         fcb   $74 t
         fcb   $FF 
         fcb   $04 
         fcb   $58 X
         fcb   $54 T
         fcb   $43 C
         fcb   $68 h
         fcb   $61 a
         fcb   $72 r
         fcb   $53 S
         fcb   $77 w
         fcb   $FF 
         fcb   $04 
         fcb   $5C \
         fcb   $42 B
         fcb   $6F o
         fcb   $6C l
         fcb   $64 d
         fcb   $53 S
         fcb   $77 w
         fcb   $FF 
         fcb   $04 
         fcb   $60 `
         fcb   $50 P
         fcb   $72 r
         fcb   $6F o
         fcb   $70 p
         fcb   $53 S
         fcb   $77 w
         fcb   $FF 
         fcb   $04 
         fcb   $64 d
         fcb   $53 S
         fcb   $65 e
         fcb   $74 t
         fcb   $44 D
         fcb   $50 P
         fcb   $74 t
         fcb   $72 r
         fcb   $FF 
         fcb   $04 
         fcb   $85 
         fcb   $50 P
         fcb   $6F o
         fcb   $69 i
         fcb   $6E n
         fcb   $74 t
         fcb   $FF 
         fcb   $04 
         fcb   $A0 
         fcb   $4C L
         fcb   $69 i
         fcb   $6E n
         fcb   $65 e
         fcb   $FF 
         fcb   $04 
         fcb   $C4 D
         fcb   $42 B
         fcb   $6F o
         fcb   $78 x
         fcb   $FF 
         fcb   $04 
         fcb   $C8 H
         fcb   $42 B
         fcb   $61 a
         fcb   $72 r
         fcb   $FF 
         fcb   $04 
         fcb   $CC L
         fcb   $50 P
         fcb   $75 u
         fcb   $74 t
         fcb   $47 G
         fcb   $43 C
         fcb   $FF 
         fcb   $04 
         fcb   $DE ^
         fcb   $46 F
         fcb   $69 i
         fcb   $6C l
         fcb   $6C l
         fcb   $FF 
         fcb   $04 
         fcb   $FC 
         fcb   $43 C
         fcb   $69 i
         fcb   $72 r
         fcb   $63 c
         fcb   $6C l
         fcb   $65 e
         fcb   $FF 
         fcb   $05 
         fcb   $1D 
         fcb   $44 D
         fcb   $72 r
         fcb   $61 a
         fcb   $77 w
         fcb   $FF 
         fcb   $07 
         fcb   $0D 
         fcb   $45 E
         fcb   $6C l
         fcb   $6C l
         fcb   $69 i
         fcb   $70 p
         fcb   $73 s
         fcb   $65 e
         fcb   $FF 
         fcb   $07 
         fcb   $12 
         fcb   $41 A
         fcb   $72 r
         fcb   $63 c
         fcb   $FF 
         fcb   $07 
         fcb   $4C L
         fcb   $43 C
         fcb   $75 u
         fcb   $72 r
         fcb   $48 H
         fcb   $6F o
         fcb   $6D m
         fcb   $65 e
         fcb   $FF 
         fcb   $07 
         fcb   $50 P
         fcb   $43 C
         fcb   $75 u
         fcb   $72 r
         fcb   $58 X
         fcb   $59 Y
         fcb   $FF 
         fcb   $07 
         fcb   $83 
         fcb   $45 E
         fcb   $72 r
         fcb   $4C L
         fcb   $69 i
         fcb   $6E n
         fcb   $65 e
         fcb   $FF 
         fcb   $07 
         fcb   $87 
         fcb   $45 E
         fcb   $72 r
         fcb   $45 E
         fcb   $4F O
         fcb   $4C L
         fcb   $69 i
         fcb   $6E n
         fcb   $65 e
         fcb   $FF 
         fcb   $07 
         fcb   $8B 
         fcb   $43 C
         fcb   $75 u
         fcb   $72 r
         fcb   $4F O
         fcb   $66 f
         fcb   $66 f
         fcb   $FF 
         fcb   $07 
         fcb   $93 
         fcb   $43 C
         fcb   $75 u
         fcb   $72 r
         fcb   $4F O
         fcb   $6E n
         fcb   $FF 
         fcb   $07 
         fcb   $9B 
         fcb   $43 C
         fcb   $75 u
         fcb   $72 r
         fcb   $52 R
         fcb   $67 g
         fcb   $74 t
         fcb   $FF 
         fcb   $07 
         fcb   $9F 
         fcb   $42 B
         fcb   $65 e
         fcb   $6C l
         fcb   $6C l
         fcb   $FF 
         fcb   $07 
         fcb   $A3 #
         fcb   $43 C
         fcb   $75 u
         fcb   $72 r
         fcb   $4C L
         fcb   $66 f
         fcb   $74 t
         fcb   $FF 
         fcb   $07 
         fcb   $A7 '
         fcb   $43 C
         fcb   $75 u
         fcb   $72 r
         fcb   $55 U
         fcb   $70 p
         fcb   $FF 
         fcb   $07 
         fcb   $AB +
         fcb   $43 C
         fcb   $75 u
         fcb   $72 r
         fcb   $44 D
         fcb   $77 w
         fcb   $6E n
         fcb   $FF 
         fcb   $07 
         fcb   $AF /
         fcb   $45 E
         fcb   $72 r
         fcb   $45 E
         fcb   $4F O
         fcb   $57 W
         fcb   $6E n
         fcb   $64 d
         fcb   $77 w
         fcb   $FF 
         fcb   $07 
         fcb   $B6 6
         fcb   $43 C
         fcb   $6C l
         fcb   $65 e
         fcb   $61 a
         fcb   $72 r
         fcb   $FF 
         fcb   $07 
         fcb   $BA :
         fcb   $43 C
         fcb   $72 r
         fcb   $52 R
         fcb   $74 t
         fcb   $6E n
         fcb   $FF 
         fcb   $07 
         fcb   $BE >
         fcb   $52 R
         fcb   $65 e
         fcb   $56 V
         fcb   $4F O
         fcb   $6E n
         fcb   $FF 
         fcb   $07 
         fcb   $C6 F
         fcb   $52 R
         fcb   $65 e
         fcb   $56 V
         fcb   $4F O
         fcb   $66 f
         fcb   $66 f
         fcb   $FF 
         fcb   $07 
         fcb   $CE N
         fcb   $55 U
         fcb   $6E n
         fcb   $64 d
         fcb   $6C l
         fcb   $6E n
         fcb   $4F O
         fcb   $6E n
         fcb   $FF 
         fcb   $07 
         fcb   $D6 V
         fcb   $55 U
         fcb   $6E n
         fcb   $64 d
         fcb   $6C l
         fcb   $6E n
         fcb   $4F O
         fcb   $66 f
         fcb   $66 f
         fcb   $FF 
         fcb   $07 
         fcb   $DF _
         fcb   $42 B
         fcb   $6C l
         fcb   $6E n
         fcb   $6B k
         fcb   $4F O
         fcb   $6E n
         fcb   $FF 
         fcb   $07 
         fcb   $E7 g
         fcb   $42 B
         fcb   $6C l
         fcb   $6E n
         fcb   $6B k
         fcb   $4F O
         fcb   $66 f
         fcb   $66 f
         fcb   $FF 
         fcb   $07 
         fcb   $EF o
         fcb   $49 I
         fcb   $6E n
         fcb   $73 s
         fcb   $4C L
         fcb   $69 i
         fcb   $6E n
         fcb   $FF 
         fcb   $07 
         fcb   $F7 w
         fcb   $44 D
         fcb   $65 e
         fcb   $6C l
         fcb   $4C L
         fcb   $69 i
         fcb   $6E n
         fcb   $FF 
         fcb   $00 
L0200    fcb   $4F O
         fcb   $46 F
         fcb   $46 F
         fcb   $FF 
         fcb   $00 
         fcb   $41 A
         fcb   $4E N
         fcb   $44 D
         fcb   $FF 
         fcb   $01 
         fcb   $4F O
         fcb   $52 R
         fcb   $FF 
         fcb   $02 
         fcb   $58 X
         fcb   $4F O
         fcb   $52 R
         fcb   $FF 
         fcb   $03 
         fcb   $00 
L0214    fcb   $4F O
         fcb   $46 F
         fcb   $46 F
         fcb   $FF 
         fcb   $00 
         fcb   $4F O
         fcb   $4E N
         fcb   $FF 
         fcb   $01 
         fcb   $00 
start    equ   *
         leas  <-$21,s
         clr   ,s
         ldd   <$23,s
         beq   L0289
         tsta  
         bne   L0289
         ldd   [<$25,s]
         ldx   <$27,s
         leax  -$01,x
         beq   L023B
         leax  -$01,x
         bne   L023D
         tfr   b,a
L023B    sta   ,s
L023D    leau  >L0012,pcr
L0241    ldy   ,u++
         beq   L0285
         tst   ,s
         bne   L024F
         ldx   <$25,s
         bra   L0252
L024F    ldx   <$29,s
L0252    lda   ,x+
         eora  ,u+
         anda  #$DF
         beq   L0262
         leau  -$01,u
L025C    tst   ,u+
         bpl   L025C
         bra   L0241
L0262    tst   -$01,u
         bpl   L0252
         tfr   y,d
         leay  >L0012,pcr
         leay  d,y
         leax  $01,s
         lda   #$1B
         sta   ,x+
         tst   ,s
         bne   L027D
         leau  <$29,s
         bra   L0280
L027D    leau  <$2D,s
L0280    ldd   <$23,s
         jmp   ,y
L0285    ldb   #$30
         bra   L028B
L0289    ldb   #$38
L028B    coma  
         leas  <$21,s
         rts   
         lda   #$20
         pshs  x,b,a
         ldx   $02,u
         cmpx  #$0002
         bne   L029F
         ldd   [,u]
         bra   L02A1
L029F    lda   [,u]
L02A1    puls  x,b,a
         beq   L02D1
         bmi   L02D1
         tst   ,s
         beq   L02AF
         cmpb  #$0A
         bra   L02B1
L02AF    cmpb  #$09
L02B1    lbne  L0289
         sta   ,x+
         lbsr  L088D
         bra   L02DF
         lda   #$21
L02BE    tst   ,s
         beq   L02C6
         cmpb  #$02
         bra   L02C8
L02C6    cmpb  #$01
L02C8    bne   L0289
         sta   ,x+
         lbra  L08A1
         lda   #$22
L02D1    tst   ,s
         beq   L02D9
         cmpb  #$09
         bra   L02DB
L02D9    cmpb  #$08
L02DB    bne   L0289
         sta   ,x+
L02DF    lbsr  L088D
         lbsr  L088D
         lbsr  L088D
L02E8    lbsr  L088D
         lbsr  L088D
         lbsr  L088D
         lbsr  L088D
         lbra  L08A1
         lda   #$23
         bra   L02BE
         lda   #$24
         bra   L02BE
         lda   #$25
         tst   ,s
         beq   L0309
         cmpb  #$06
         bra   L030B
L0309    cmpb  #$05
L030B    lbne  L0289
         sta   ,x+
         bra   L02E8
         lda   #$29
         tst   ,s
         beq   L031D
         cmpb  #$05
         bra   L031F
L031D    cmpb  #$04
L031F    lbne  L0289
         sta   ,x+
         lbsr  L088D
         lbsr  L088D
         lbra  L0387
         lda   #$2A
L0330    tst   ,s
         beq   L0338
         cmpb  #$04
         bra   L033A
L0338    cmpb  #$03
L033A    lbne  L0289
         sta   ,x+
         lbsr  L088D
         lbsr  L088D
         lbra  L08A1
         lda   #$2B
         tst   ,s
         beq   L0353
         cmpb  #$08
         bra   L0355
L0353    cmpb  #$07
L0355    lbne  L0289
         sta   ,x+
         lbsr  L088D
         lbsr  L088D
         lbsr  L088D
         bra   L0381
         lda   #$2C
         tst   ,s
         beq   L0370
         cmpb  #$08
         bra   L0372
L0370    cmpb  #$07
L0372    lbne  L0289
         sta   ,x+
         lbsr  L088D
         lbsr  L088D
         lbsr  L0845
L0381    lbsr  L0845
L0384    lbsr  L0845
L0387    lbsr  L0845
         lbra  L08A1
         lda   #$2D
         tst   ,s
         beq   L0397
         cmpb  #$06
         bra   L0399
L0397    cmpb  #$05
L0399    lbne  L0289
         sta   ,x+
         lbsr  L088D
         lbsr  L088D
         bra   L0384
         lda   #$2E
         bra   L0330
         lda   #$2F
         tst   ,s
         beq   L03B5
         cmpb  #$03
         bra   L03B7
L03B5    cmpb  #$02
L03B7    lbne  L0289
         sta   ,x+
         pshs  y,x,b,a
         leay  >L0200,pcr
L03C3    ldx   ,u
         lbsr  L0811
         bcs   L03D5
         ldx   $02,s
         sta   ,x+
         stx   $02,s
         puls  y,x,b,a
         lbra  L08A1
L03D5    puls  y,x,b,a
         lbra  L0289
         lda   #$30
         lbra  L02BE
         lda   #$31
         lbra  L0330
         tst   ,s
         bne   L03E9
         incb  
L03E9    cmpb  #$03
         beq   L03F8
         cmpb  #$04
         beq   L03FC
         cmpb  #$05
         beq   L0406
         lbra  L0289
L03F8    bsr   L0418
         bra   L0415
L03FC    bsr   L0418
         ldb   #$1B
         stb   ,x+
         bsr   L041F
         bra   L0415
L0406    bsr   L0418
         ldb   #$1B
         stb   ,x+
         bsr   L041F
         ldb   #$1B
         stb   ,x+
         lbsr  L0439
L0415    lbra  L08A1
L0418    lda   #$32
         sta   ,x+
         lbra  L088D
L041F    lda   #$33
         sta   ,x+
         lbra  L088D
         tst   ,s
         beq   L042E
         cmpb  #$03
         bra   L0430
L042E    cmpb  #$02
L0430    lbne  L0289
         bsr   L0439
         lbra  L08A1
L0439    lda   #$34
         sta   ,x+
         lbra  L088D
         rts   
         lda   #$35
L0443    tst   ,s
         beq   L044B
         cmpb  #$03
         bra   L044D
L044B    cmpb  #$02
L044D    lbne  L0289
         sta   ,x+
         pshs  y,x,b,a
         leay  >L0214,pcr
         lbra  L03C3
         lda   #$36
         bra   L0443
         lda   #$39
         lbra  L0330
         lda   #$3A
         lbra  L0330
         lda   #$3C
         bra   L0443
         lda   #$3D
         bra   L0443
         lda   #$3F
         bra   L0443
         tst   ,s
         beq   L047E
         cmpb  #$04
         bra   L0480
L047E    cmpb  #$03
L0480    lbne  L0289
         bsr   L0489
         lbra  L08A1
L0489    pshs  a
         lda   #$40
         sta   ,x+
         lbsr  L085D
         lbsr  L085D
         puls  pc,a
         lda   #$42
         tst   ,s
         beq   L04A1
         cmpb  #$04
         bra   L04A3
L04A1    cmpb  #$03
L04A3    lbne  L0289
         sta   ,x+
         lbsr  L0845
         lbsr  L0845
         lbra  L08A1
         lda   #$46
L04B4    tst   ,s
         bne   L04B9
         incb  
L04B9    cmpb  #$04
         beq   L04CB
         cmpb  #$06
         beq   L04C4
         lbra  L0289
L04C4    lbsr  L0489
         ldb   #$1B
         stb   ,x+
L04CB    sta   ,x+
         lbsr  L0845
         lbsr  L0845
         lbra  L08A1
         lda   #$48
         bra   L04B4
         lda   #$4A
         bra   L04B4
         lda   #$4E
         tst   ,s
         beq   L04E8
         cmpb  #$04
         bra   L04EA
L04E8    cmpb  #$03
L04EA    lbne  L0289
         bra   L04CB
         lda   #$4F
         tst   ,s
         bne   L04F7
         incb  
L04F7    cmpb  #$02
         beq   L0509
         cmpb  #$04
         beq   L0502
         lbra  L0289
L0502    lbsr  L0489
         ldb   #$1B
         stb   ,x+
L0509    sta   ,x+
         lbra  L08A1
         lda   #$50
         tst   ,s
         bne   L0515
         incb  
L0515    cmpb  #$03
         beq   L0527
         cmpb  #$05
         beq   L0520
         lbra  L0289
L0520    lbsr  L0489
         ldb   #$1B
         stb   ,x+
L0527    sta   ,x+
         lbsr  L0845
         lbra  L08A1
         tst   ,s
         beq   L053E
         cmpb  #$05
         beq   L0549
         cmpb  #$03
         beq   L055F
         lbra  L0289
L053E    cmpb  #$04
         beq   L0549
         cmpb  #$02
         beq   L055F
         lbra  L0289
L0549    pshs  u,x
         leas  -$02,s
         ldd   #$1B40
         std   ,x++
         lbsr  L0875
         lbsr  L0875
         lbsr  L0708
         leas  $02,s
         bra   L0561
L055F    pshs  u,x
L0561    ldu   ,u
         leas  -$02,s
         clr   $01,s
         clr   ,s
L0569    lda   ,u+
         anda  #$DF
         cmpa  #$41
         beq   L05A6
         cmpa  #$42
         beq   L05AD
         cmpa  #$55
         beq   L05CA
         cmpa  #$4E
         beq   L05D1
         cmpa  #$53
         lbeq  L0614
         cmpa  #$45
         lbeq  L0649
         cmpa  #$57
         lbeq  L0659
         lda   -$01,u
         cmpa  #$2C
         beq   L0569
         cmpa  #$FF
         bne   L05A1
         leas  $02,s
         puls  u,x
         leas  <$21,s
         rts   
L05A1    leas  $06,s
         lbra  L0289
L05A6    lbsr  L066C
         std   ,s
         bra   L0569
L05AD    ldd   #$1B41
         std   ,x++
L05B2    lbsr  L066C
         std   ,x++
         lda   ,u+
         cmpa  #$2C
         bne   L05A1
         lbsr  L066C
         std   ,x++
         lbsr  L06BD
         lbsr  L0708
         bra   L0569
L05CA    ldd   #$1B45
         std   ,x++
         bra   L05B2
L05D1    ldd   #$1B47
         std   ,x++
         lda   ,u
         anda  #$DF
         cmpa  #$45
         beq   L05F1
         cmpa  #$57
         beq   L05FF
         ldd   #$0000
         std   ,x++
         lbsr  L066C
         lbsr  L0703
         std   ,x++
         bra   L060B
L05F1    leau  $01,u
         lbsr  L066C
         std   ,x++
         lbsr  L0703
         std   ,x++
         bra   L060B
L05FF    leau  $01,u
         lbsr  L066C
         lbsr  L0703
         std   ,x++
         std   ,x++
L060B    lbsr  L06BD
         lbsr  L0708
         lbra  L0569
L0614    ldd   #$1B47
         std   ,x++
         lda   ,u
         anda  #$DF
         cmpa  #$45
         beq   L0630
         cmpa  #$57
         beq   L063A
         ldd   #$0000
         std   ,x++
         bsr   L066C
         std   ,x++
         bra   L060B
L0630    leau  $01,u
         bsr   L066C
         std   ,x++
         std   ,x++
         bra   L060B
L063A    leau  $01,u
         bsr   L066C
         std   $02,x
         lbsr  L0703
         std   ,x++
         leax  $02,x
         bra   L060B
L0649    ldd   #$1B47
         std   ,x++
         bsr   L066C
         std   ,x++
         ldd   #$0000
         std   ,x++
         bra   L060B
L0659    ldd   #$1B47
         std   ,x++
         bsr   L066C
         lbsr  L0703
         std   ,x++
         ldd   #$0000
         std   ,x++
         bra   L060B
L066C    ldd   #$0000
         pshs  u,b,a
         ldb   ,u
         cmpb  #$2D
         bne   L0679
         leau  $01,u
L0679    clra  
         ldb   ,u
         subb  #$30
         bcs   L069E
         cmpb  #$09
         bhi   L069E
         pshs  b,a
         ldd   $02,s
         lslb  
         rola  
         lslb  
         rola  
         lslb  
         rola  
         pshs  b,a
         ldd   $04,s
         lslb  
         rola  
         addd  ,s++
         addd  ,s++
         std   ,s
         leau  $01,u
         bra   L0679
L069E    cmpu  $02,s
         lbeq  L06B8
         lda   [<$02,s]
         cmpa  #$2D
         bne   L06B3
         puls  b,a
         lbsr  L0703
         bra   L06B5
L06B3    puls  b,a
L06B5    leas  $02,s
         rts   
L06B8    leas  $0C,s
         lbra  L0289
L06BD    ldd   $02,s
         beq   L0702
         subd  #$0001
         beq   L06D2
         subd  #$0001
         beq   L06E3
         subd  #$0001
         beq   L06F3
         bra   L0702
L06D2    ldd   -$02,x
         lbsr  L0703
         pshs  b,a
         ldd   -$04,x
         std   -$02,x
         puls  b,a
         std   -$04,x
         bra   L0702
L06E3    ldd   -$04,x
         lbsr  L0703
         std   -$04,x
         ldd   -$02,x
         lbsr  L0703
         std   -$02,x
         bra   L0702
L06F3    ldd   -$04,x
         lbsr  L0703
         pshs  b,a
         ldd   -$02,x
         std   -$04,x
         puls  b,a
         std   -$02,x
L0702    rts   
L0703    nega  
         negb  
         sbca  #$00
         rts   
L0708    pshs  y,x
         tfr   x,d
         subd  $08,s
         tfr   d,y
         ldx   $08,s
         lda   $0C,s
         bne   L0717
         inca  
L0717    os9   I$Write  
         puls  y,x
         ldx   $04,s
         rts   
         lda   #$51
         lbra  L04B4
         lda   #$52
         tst   ,s
         beq   L0735
         cmpb  #$0A
         beq   L0740
         cmpb  #$08
         beq   L0747
         lbra  L0289
L0735    cmpb  #$09
         beq   L0740
         cmpb  #$07
         beq   L0747
         lbra  L0289
L0740    lbsr  L0489
         ldb   #$1B
         stb   ,x+
L0747    sta   ,x+
         lbsr  L0845
         lbsr  L0845
         lbsr  L0845
         lbsr  L0845
         lbsr  L0845
         lbsr  L0845
         lbra  L08A1
         lda   #$01
         bra   L07C3
         lda   #$02
         tst   ,s
         beq   L076C
         cmpb  #$04
         bra   L076E
L076C    cmpb  #$03
L076E    lbne  L0289
         sta   -$01,x
         bsr   L077B
         bsr   L077B
         lbra  L08A1
L077B    pshs  y,b,a
         ldd   [,u++]
         adda  #$20
         sta   ,x+
         pulu  y
         leay  -$01,y
         beq   L0793
         leay  -$01,y
         lbne  L08BA
         addb  #$20
         stb   -$01,x
L0793    puls  pc,y,b,a
         lda   #$03
         bra   L07C3
         lda   #$04
         bra   L07C3
         lda   #$05
         sta   -$01,x
         lda   #$20
         bra   L07EE
         lda   #$05
         sta   -$01,x
         lda   #$21
         bra   L07EE
         lda   #$06
         bra   L07C3
         lda   #$07
         bra   L07C3
         lda   #$08
         bra   L07C3
         lda   #$09
         bra   L07C3
         lda   #$0A
         bra   L07C3
         lda   #$0B
L07C3    leax  -$01,x
         lbra  L02BE
         lda   #$0C
         bra   L07C3
         lda   #$0D
         bra   L07C3
         lda   #$1F
         sta   -$01,x
         lda   #$20
         bra   L07EE
         lda   #$1F
         sta   -$01,x
         lda   #$21
         bra   L07EE
         lda   #$1F
         sta   -$01,x
         lda   #$22
         bra   L07EE
         lda   #$1F
         sta   -$01,x
         lda   #$23
L07EE    lbra  L02BE
         lda   #$1F
         sta   -$01,x
         lda   #$24
         bra   L07EE
         lda   #$1F
         sta   -$01,x
         lda   #$25
         bra   L07EE
         lda   #$1F
         sta   -$01,x
         lda   #$30
         bra   L07EE
         lda   #$1F
         sta   -$01,x
         lda   #$31
         bra   L07EE
L0811    pshs  x
L0813    lda   ,y+
         beq   L0841
L0817    eora  ,x+
         anda  #$DF
         bne   L082F
         tst   ,y
         bpl   L0827
         tst   ,x
         bmi   L083B
         bra   L082F
L0827    tst   ,x
         bmi   L082F
         lda   ,y+
         bra   L0817
L082F    leay  -$01,y
L0831    tst   ,y+
         bpl   L0831
         ldx   ,s
         leay  $01,y
         bra   L0813
L083B    lda   $01,y
         andcc #$FE
         bra   L0843
L0841    orcc  #$01
L0843    puls  pc,x
L0845    pshs  y,b,a
         ldd   [,u++]
         pulu  y
         leay  -$01,y
         bne   L0855
         clr   ,x+
         sta   ,x+
         bra   L085B
L0855    leay  -$01,y
         bne   L08BA
         std   ,x++
L085B    puls  pc,y,b,a
L085D    pshs  y,b,a
         ldd   [,u++]
         pulu  y
         leay  -$01,y
         bne   L086D
         clr   ,x+
         sta   ,x+
         bra   L0873
L086D    leay  -$01,y
         bne   L08BE
         std   ,x++
L0873    puls  pc,y,b,a
L0875    pshs  y,b,a
         ldd   [,u++]
         pulu  y
         leay  -$01,y
         bne   L0885
         clr   ,x+
         sta   ,x+
         bra   L088B
L0885    leay  -$01,y
         bne   L08C2
         std   ,x++
L088B    puls  pc,y,b,a
L088D    pshs  y,b,a
         ldd   [,u++]
         sta   ,x+
         pulu  y
         leay  -$01,y
         beq   L089F
         leay  -$01,y
         bne   L08BA
         stb   -$01,x
L089F    puls  pc,y,b,a
L08A1    bsr   L08A7
         leas  <$21,s
         rts   
L08A7    tfr   x,d
         leax  $03,s
         pshs  x
         subd  ,s++
         tfr   d,y
         lda   $02,s
         bne   L08B6
         inca  
L08B6    os9   I$Write  
         rts   
L08BA    leas  $06,s
         bra   L08C4
L08BE    leas  $09,s
         bra   L08C4
L08C2    leas  $0F,s
L08C4    lbra  L0289
         emod
eom      equ   *
