********************************************************************
* cmp - File comparison utility
*
* $Id$
*
* Ed.    Comments                                       Who YY/MM/DD
* ------------------------------------------------------------------
*  50    From Tandy OS-9 Level One VR 02.00.00

         nam   cmp
         ttl   File comparison utility

* Disassembled 02/04/03 23:09:47 by Disasm v1.6 (C) 1988 by RML

         ifp1
         use   defsfile
         endc

tylg     set   Prgrm+Objct   
atrv     set   ReEnt+rev
rev      set   $01
edition  set   50

         mod   eom,name,tylg,atrv,start,size

u0000    rmb   2
u0002    rmb   2
u0004    rmb   2
u0006    rmb   4
u000A    rmb   10
u0014    rmb   12
u0020    rmb   2
u0022    rmb   2
u0024    rmb   1
u0025    rmb   1
u0026    rmb   28
u0042    rmb   33
u0063    rmb   16
u0073    rmb   17
u0084    rmb   104
u00EC    rmb   314
u0226    rmb   514
u0428    rmb   2
u042A    rmb   1135
size     equ   .

name     fcs   /cmp/
L0010    fcb   $32 2
         fcb   $E9 i
         fcb   $FF 
         fcb   $7A z
         fcb   $1F 
         fcb   $40 @
         fcb   $C3 C
         fcb   $00 
         fcb   $8A 
         fcb   $ED m
         fcb   $E3 c
         fcb   $1F 
         fcb   $40 @
         fcb   $C3 C
         fcb   $00 
         fcb   $02 
         fcb   $ED m
         fcb   $E3 c
         fcb   $EC l
         fcb   $E9 i
         fcb   $00 
         fcb   $8C 
         fcb   $ED m
         fcb   $E3 c
         fcb   $17 
         fcb   $00 
         fcb   $59 Y
         fcb   $32 2
         fcb   $66 f
         fcb   $1F 
         fcb   $40 @
         fcb   $ED m
         fcb   $E3 c
         fcb   $17 
         fcb   $09 
         fcb   $DA Z
         fcb   $32 2
         fcb   $62 b
         fcb   $32 2
         fcb   $E9 i
         fcb   $00 
         fcb   $86 
         fcb   $39 9
L003B    fcb   $32 2
         fcb   $E9 i
         fcb   $FF 
         fcb   $7A z
         fcb   $1F 
         fcb   $40 @
         fcb   $C3 C
         fcb   $00 
         fcb   $8C 
         fcb   $ED m
         fcb   $E3 c
         fcb   $1F 
         fcb   $40 @
         fcb   $C3 C
         fcb   $00 
         fcb   $02 
         fcb   $ED m
         fcb   $E3 c
         fcb   $EC l
         fcb   $E9 i
         fcb   $00 
         fcb   $8E 
         fcb   $ED m
         fcb   $E3 c
         fcb   $17 
         fcb   $00 
         fcb   $2E .
         fcb   $32 2
         fcb   $66 f
         fcb   $EC l
         fcb   $E9 i
         fcb   $00 
         fcb   $88 
         fcb   $ED m
         fcb   $E3 c
         fcb   $1F 
         fcb   $40 @
         fcb   $C3 C
         fcb   $00 
         fcb   $02 
         fcb   $ED m
         fcb   $E3 c
         fcb   $17 
         fcb   $09 
         fcb   $AA *
         fcb   $32 2
         fcb   $64 d
         fcb   $32 2
         fcb   $E9 i
         fcb   $00 
         fcb   $86 
         fcb   $39 9
         fcb   $1F 
         fcb   $40 @
         fcb   $C3 C
         fcb   $00 
         fcb   $06 
         fcb   $ED m
         fcb   $E3 c
         fcb   $EC l
         fcb   $64 d
         fcb   $ED m
         fcb   $E3 c
         fcb   $EC l
         fcb   $68 h
         fcb   $ED m
         fcb   $E3 c
         fcb   $17 
         fcb   $00 
         fcb   $03 
         fcb   $32 2
         fcb   $66 f
         fcb   $39 9
         fcb   $32 2
         fcb   $7C ü
         fcb   $32 2
         fcb   $7E þ
         fcb   $EC l
         fcb   $68 h
         fcb   $ED m
         fcb   $E3 c
         fcb   $C3 C
         fcb   $00 
         fcb   $01 
         fcb   $ED m
         fcb   $6A j
         fcb   $EC l
         fcb   $E1 a
         fcb   $1F 
         fcb   $01 
         fcb   $E6 f
         fcb   $84 
         fcb   $1D 
         fcb   $E7 g
         fcb   $65 e
         fcb   $10 
         fcb   $27 '
         fcb   $03 
         fcb   $0F 
         fcb   $E6 f
         fcb   $65 e
         fcb   $1D 
         fcb   $ED m
         fcb   $E3 c
         fcb   $CC L
         fcb   $00 
         fcb   $25 %
         fcb   $10 
         fcb   $A3 #
         fcb   $E1 a
         fcb   $10 
         fcb   $26 &
         fcb   $02 
         fcb   $EB k
         fcb   $EC l
         fcb   $68 h
         fcb   $ED m
         fcb   $E3 c
         fcb   $C3 C
         fcb   $00 
         fcb   $01 
         fcb   $ED m
         fcb   $6A j
         fcb   $EC l
         fcb   $E1 a
         fcb   $1F 
         fcb   $01 
         fcb   $E6 f
         fcb   $84 
         fcb   $1D 
         fcb   $E7 g
         fcb   $65 e
         fcb   $E6 f
         fcb   $65 e
         fcb   $1D 
         fcb   $ED m
         fcb   $E3 c
         fcb   $CC L
         fcb   $00 
         fcb   $20 
         fcb   $AA *
         fcb   $E0 `
         fcb   $EA j
         fcb   $E0 `
         fcb   $ED m
         fcb   $E3 c
         fcb   $CC L
         fcb   $00 
         fcb   $2D -
         fcb   $10 
         fcb   $A3 #
         fcb   $E1 a
         fcb   $10 
         fcb   $26 &
         fcb   $00 
         fcb   $06 
         fcb   $CC L
         fcb   $00 
         fcb   $01 
         fcb   $16 
         fcb   $00 
         fcb   $05 
         fcb   $4F O
         fcb   $5F _
         fcb   $16 
         fcb   $00 
         fcb   $00 
         fcb   $ED m
         fcb   $C9 I
         fcb   $04 
         fcb   $94 
         fcb   $10 
         fcb   $27 '
         fcb   $00 
         fcb   $12 
         fcb   $EC l
         fcb   $68 h
         fcb   $ED m
         fcb   $E3 c
         fcb   $C3 C
         fcb   $00 
         fcb   $01 
         fcb   $ED m
         fcb   $6A j
         fcb   $EC l
         fcb   $E1 a
         fcb   $1F 
         fcb   $01 
         fcb   $E6 f
         fcb   $84 
         fcb   $1D 
         fcb   $E7 g
         fcb   $65 e
         fcb   $4F O
         fcb   $5F _
         fcb   $ED m
         fcb   $C9 I
         fcb   $04 
         fcb   $26 &
         fcb   $ED m
         fcb   $C9 I
         fcb   $04 
         fcb   $2C ,
         fcb   $CC L
         fcb   $00 
         fcb   $20 
         fcb   $E7 g
         fcb   $C9 I
         fcb   $04 
         fcb   $98 
         fcb   $E6 f
         fcb   $65 e
         fcb   $1D 
         fcb   $ED m
         fcb   $E3 c
         fcb   $CC L
         fcb   $00 
         fcb   $30 0
         fcb   $10 
         fcb   $A3 #
         fcb   $E1 a
         fcb   $10 
         fcb   $26 &
         fcb   $00 
         fcb   $19 
         fcb   $CC L
         fcb   $00 
         fcb   $30 0
         fcb   $E7 g
         fcb   $C9 I
         fcb   $04 
         fcb   $98 
         fcb   $EC l
         fcb   $68 h
         fcb   $ED m
         fcb   $E3 c
         fcb   $C3 C
         fcb   $00 
         fcb   $01 
         fcb   $ED m
         fcb   $6A j
         fcb   $EC l
         fcb   $E1 a
         fcb   $1F 
         fcb   $01 
         fcb   $E6 f
         fcb   $84 
         fcb   $1D 
         fcb   $E7 g
         fcb   $65 e
         fcb   $E6 f
         fcb   $65 e
         fcb   $1D 
         fcb   $ED m
         fcb   $E3 c
         fcb   $CC L
         fcb   $00 
         fcb   $30 0
         fcb   $10 
         fcb   $A3 #
         fcb   $E1 a
         fcb   $10 
         fcb   $2E .
         fcb   $00 
         fcb   $48 H
         fcb   $E6 f
         fcb   $65 e
         fcb   $1D 
         fcb   $ED m
         fcb   $E3 c
         fcb   $CC L
         fcb   $00 
         fcb   $39 9
         fcb   $10 
         fcb   $A3 #
         fcb   $E1 a
         fcb   $10 
         fcb   $2D -
         fcb   $00 
         fcb   $39 9
         fcb   $EC l
         fcb   $C9 I
         fcb   $04 
         fcb   $2C ,
         fcb   $ED m
         fcb   $E3 c
         fcb   $CC L
         fcb   $00 
         fcb   $0A 
         fcb   $17 
         fcb   $05 
         fcb   $49 I
         fcb   $ED m
         fcb   $E3 c
         fcb   $E6 f
         fcb   $67 g
         fcb   $1D 
         fcb   $ED m
         fcb   $E3 c
         fcb   $CC L
         fcb   $00 
         fcb   $30 0
         fcb   $35 5
         fcb   $10 
         fcb   $34 4
         fcb   $06 
         fcb   $1F 
         fcb   $10 
         fcb   $A3 #
         fcb   $E1 a
         fcb   $E3 c
         fcb   $E1 a
         fcb   $ED m
         fcb   $C9 I
         fcb   $04 
         fcb   $2C ,
         fcb   $EC l
         fcb   $68 h
         fcb   $ED m
         fcb   $E3 c
         fcb   $C3 C
         fcb   $00 
         fcb   $01 
         fcb   $ED m
         fcb   $6A j
         fcb   $EC l
         fcb   $E1 a
         fcb   $1F 
         fcb   $01 
         fcb   $E6 f
         fcb   $84 
         fcb   $1D 
         fcb   $E7 g
         fcb   $65 e
         fcb   $16 
         fcb   $FF 
         fcb   $A9 )
         fcb   $E6 f
         fcb   $65 e
         fcb   $1D 
         fcb   $ED m
         fcb   $E3 c
         fcb   $CC L
         fcb   $00 
         fcb   $2E .
         fcb   $10 
         fcb   $A3 #
         fcb   $E1 a
         fcb   $10 
         fcb   $26 &
         fcb   $00 
         fcb   $69 i
         fcb   $EC l
         fcb   $68 h
         fcb   $ED m
         fcb   $E3 c
         fcb   $C3 C
         fcb   $00 
         fcb   $01 
         fcb   $ED m
         fcb   $6A j
         fcb   $EC l
         fcb   $E1 a
         fcb   $1F 
         fcb   $01 
         fcb   $E6 f
         fcb   $84 
         fcb   $1D 
         fcb   $E7 g
         fcb   $65 e
         fcb   $E6 f
         fcb   $65 e
         fcb   $1D 
         fcb   $ED m
         fcb   $E3 c
         fcb   $CC L
         fcb   $00 
         fcb   $30 0
         fcb   $10 
         fcb   $A3 #
         fcb   $E1 a
         fcb   $10 
         fcb   $2E .
         fcb   $00 
         fcb   $48 H
         fcb   $E6 f
         fcb   $65 e
         fcb   $1D 
         fcb   $ED m
         fcb   $E3 c
         fcb   $CC L
         fcb   $00 
         fcb   $39 9
         fcb   $10 
         fcb   $A3 #
         fcb   $E1 a
         fcb   $10 
         fcb   $2D -
         fcb   $00 
         fcb   $39 9
         fcb   $EC l
         fcb   $C9 I
         fcb   $04 
         fcb   $26 &
         fcb   $ED m
         fcb   $E3 c
         fcb   $CC L
         fcb   $00 
         fcb   $0A 
         fcb   $17 
         fcb   $04 
         fcb   $D1 Q
         fcb   $ED m
         fcb   $E3 c
         fcb   $E6 f
         fcb   $67 g
         fcb   $1D 
         fcb   $ED m
         fcb   $E3 c
         fcb   $CC L
         fcb   $00 
         fcb   $30 0
         fcb   $35 5
         fcb   $10 
         fcb   $34 4
         fcb   $06 
         fcb   $1F 
         fcb   $10 
         fcb   $A3 #
         fcb   $E1 a
         fcb   $E3 c
         fcb   $E1 a
         fcb   $ED m
         fcb   $C9 I
         fcb   $04 
         fcb   $26 &
         fcb   $EC l
         fcb   $68 h
         fcb   $ED m
         fcb   $E3 c
         fcb   $C3 C
         fcb   $00 
         fcb   $01 
         fcb   $ED m
         fcb   $6A j
         fcb   $EC l
         fcb   $E1 a
         fcb   $1F 
         fcb   $01 
         fcb   $E6 f
         fcb   $84 
         fcb   $1D 
         fcb   $E7 g
         fcb   $65 e
         fcb   $16 
         fcb   $FF 
         fcb   $A9 )
         fcb   $4F O
         fcb   $5F _
         fcb   $ED m
         fcb   $E4 d
         fcb   $E6 f
         fcb   $65 e
         fcb   $1D 
         fcb   $ED m
         fcb   $E3 c
         fcb   $CC L
         fcb   $00 
         fcb   $20 
         fcb   $AA *
         fcb   $E0 `
         fcb   $EA j
         fcb   $E0 `
         fcb   $ED m
         fcb   $E3 c
         fcb   $CC L
         fcb   $00 
         fcb   $6C l
         fcb   $10 
         fcb   $A3 #
         fcb   $E1 a
         fcb   $10 
         fcb   $26 &
         fcb   $00 
         fcb   $06 
         fcb   $CC L
         fcb   $00 
         fcb   $01 
         fcb   $16 
         fcb   $00 
         fcb   $05 
         fcb   $4F O
         fcb   $5F _
         fcb   $16 
         fcb   $00 
         fcb   $00 
         fcb   $ED m
         fcb   $C9 I
         fcb   $04 
         fcb   $92 
         fcb   $10 
         fcb   $27 '
         fcb   $00 
         fcb   $27 '
         fcb   $EC l
         fcb   $68 h
         fcb   $ED m
         fcb   $E3 c
         fcb   $C3 C
         fcb   $00 
         fcb   $01 
         fcb   $ED m
         fcb   $6A j
         fcb   $EC l
         fcb   $E1 a
         fcb   $1F 
         fcb   $01 
         fcb   $E6 f
         fcb   $84 
         fcb   $1D 
         fcb   $E7 g
         fcb   $65 e
         fcb   $EC l
         fcb   $6C l
         fcb   $ED m
         fcb   $E3 c
         fcb   $ED m
         fcb   $E3 c
         fcb   $CC L
         fcb   $00 
         fcb   $02 
         fcb   $E3 c
         fcb   $E1 a
         fcb   $ED m
         fcb   $6E n
         fcb   $EC l
         fcb   $E1 a
         fcb   $1F 
         fcb   $01 
         fcb   $EC l
         fcb   $84 
         fcb   $ED m
         fcb   $E4 d
         fcb   $30 0
         fcb   $8D 
         fcb   $01 
         fcb   $1F 
         fcb   $AF /
         fcb   $E3 c
         fcb   $E6 f
         fcb   $67 g
         fcb   $1D 
         fcb   $ED m
         fcb   $E3 c
         fcb   $CC L
         fcb   $00 
         fcb   $20 
         fcb   $AA *
         fcb   $E0 `
         fcb   $EA j
         fcb   $E0 `
         fcb   $17 
         fcb   $04 
         fcb   $18 
         fcb   $16 
         fcb   $01 
         fcb   $23 #
         fcb   $1F 
         fcb   $40 @
         fcb   $C3 C
         fcb   $00 
         fcb   $0A 
         fcb   $ED m
         fcb   $E3 c
         fcb   $CC L
         fcb   $00 
         fcb   $0A 
         fcb   $ED m
         fcb   $E3 c
         fcb   $EC l
         fcb   $E8 h
         fcb   $10 
         fcb   $ED m
         fcb   $E3 c
         fcb   $ED m
         fcb   $E3 c
         fcb   $CC L
         fcb   $00 
         fcb   $02 
         fcb   $E3 c
         fcb   $E1 a
         fcb   $ED m
         fcb   $E8 h
         fcb   $12 
         fcb   $EC l
         fcb   $E1 a
         fcb   $1F 
         fcb   $01 
         fcb   $EC l
         fcb   $84 
         fcb   $ED m
         fcb   $E3 c
         fcb   $EC l
         fcb   $66 f
         fcb   $ED m
         fcb   $E3 c
         fcb   $17 
         fcb   $01 
         fcb   $1F 
         fcb   $32 2
         fcb   $68 h
         fcb   $16 
         fcb   $00 
         fcb   $F4 t
         fcb   $1F 
         fcb   $40 @
         fcb   $C3 C
         fcb   $00 
         fcb   $0A 
         fcb   $ED m
         fcb   $E3 c
         fcb   $CC L
         fcb   $00 
         fcb   $08 
         fcb   $ED m
         fcb   $E3 c
         fcb   $EC l
         fcb   $E8 h
         fcb   $10 
         fcb   $ED m
         fcb   $E3 c
         fcb   $ED m
         fcb   $E3 c
         fcb   $CC L
         fcb   $00 
         fcb   $02 
         fcb   $E3 c
         fcb   $E1 a
         fcb   $ED m
         fcb   $E8 h
         fcb   $12 
         fcb   $EC l
         fcb   $E1 a
         fcb   $1F 
         fcb   $01 
         fcb   $EC l
         fcb   $84 
         fcb   $ED m
         fcb   $E3 c
         fcb   $EC l
         fcb   $66 f
         fcb   $ED m
         fcb   $E3 c
         fcb   $17 
         fcb   $00 
         fcb   $F0 p
         fcb   $32 2
         fcb   $68 h
         fcb   $16 
         fcb   $00 
         fcb   $C5 E
         fcb   $1F 
         fcb   $40 @
         fcb   $C3 C
         fcb   $00 
         fcb   $0A 
         fcb   $ED m
         fcb   $E3 c
         fcb   $CC L
         fcb   $00 
         fcb   $10 
         fcb   $ED m
         fcb   $E3 c
         fcb   $EC l
         fcb   $E8 h
         fcb   $10 
         fcb   $ED m
         fcb   $E3 c
         fcb   $ED m
         fcb   $E3 c
         fcb   $CC L
         fcb   $00 
         fcb   $02 
         fcb   $E3 c
         fcb   $E1 a
         fcb   $ED m
         fcb   $E8 h
         fcb   $12 
         fcb   $EC l
         fcb   $E1 a
         fcb   $1F 
         fcb   $01 
         fcb   $EC l
         fcb   $84 
         fcb   $ED m
         fcb   $E3 c
         fcb   $EC l
         fcb   $66 f
         fcb   $ED m
         fcb   $E3 c
         fcb   $17 
         fcb   $00 
         fcb   $C1 A
         fcb   $32 2
         fcb   $68 h
         fcb   $16 
         fcb   $00 
         fcb   $96 
         fcb   $EC l
         fcb   $6A j
         fcb   $ED m
         fcb   $E3 c
         fcb   $C3 C
         fcb   $00 
         fcb   $01 
         fcb   $ED m
         fcb   $6C l
         fcb   $EC l
         fcb   $E1 a
         fcb   $ED m
         fcb   $E3 c
         fcb   $EC l
         fcb   $6E n
         fcb   $ED m
         fcb   $E3 c
         fcb   $ED m
         fcb   $E3 c
         fcb   $CC L
         fcb   $00 
         fcb   $02 
         fcb   $E3 c
         fcb   $E1 a
         fcb   $ED m
         fcb   $E8 h
         fcb   $10 
         fcb   $EC l
         fcb   $E1 a
         fcb   $1F 
         fcb   $01 
         fcb   $EC l
         fcb   $84 
         fcb   $E7 g
         fcb   $F1 q
         fcb   $16 
         fcb   $00 
         fcb   $70 p
         fcb   $EC l
         fcb   $6C l
         fcb   $ED m
         fcb   $E3 c
         fcb   $ED m
         fcb   $E3 c
         fcb   $CC L
         fcb   $00 
         fcb   $02 
         fcb   $E3 c
         fcb   $E1 a
         fcb   $ED m
         fcb   $6E n
         fcb   $EC l
         fcb   $E1 a
         fcb   $1F 
         fcb   $01 
         fcb   $EC l
         fcb   $84 
         fcb   $ED m
         fcb   $62 b
         fcb   $EC l
         fcb   $62 b
         fcb   $ED m
         fcb   $E3 c
         fcb   $C3 C
         fcb   $00 
         fcb   $01 
         fcb   $ED m
         fcb   $64 d
         fcb   $EC l
         fcb   $E1 a
         fcb   $1F 
         fcb   $01 
         fcb   $E6 f
         fcb   $84 
         fcb   $1D 
         fcb   $E7 g
         fcb   $65 e
         fcb   $10 
         fcb   $27 '
         fcb   $00 
         fcb   $15 
         fcb   $EC l
         fcb   $6A j
         fcb   $ED m
         fcb   $E3 c
         fcb   $C3 C
         fcb   $00 
         fcb   $01 
         fcb   $ED m
         fcb   $6C l
         fcb   $EC l
         fcb   $E1 a
         fcb   $ED m
         fcb   $E3 c
         fcb   $E6 f
         fcb   $67 g
         fcb   $1D 
         fcb   $E7 g
         fcb   $F1 q
         fcb   $16 
         fcb   $FF 
         fcb   $D5 U
         fcb   $16 
         fcb   $00 
         fcb   $2D -
         fcb   $EC l
         fcb   $6A j
         fcb   $ED m
         fcb   $E3 c
         fcb   $C3 C
         fcb   $00 
         fcb   $01 
         fcb   $ED m
         fcb   $6C l
         fcb   $EC l
         fcb   $E1 a
         fcb   $ED m
         fcb   $E3 c
         fcb   $E6 f
         fcb   $67 g
         fcb   $1D 
         fcb   $E7 g
         fcb   $F1 q
         fcb   $16 
         fcb   $00 
         fcb   $18 
         fcb   $00 
         fcb   $05 
         fcb   $FF 
         fcb   $EB k
         fcb   $00 
         fcb   $64 d
         fcb   $FE 
         fcb   $F5 u
         fcb   $00 
         fcb   $6F o
         fcb   $FF 
         fcb   $24 $
         fcb   $00 
         fcb   $78 x
         fcb   $FF 
         fcb   $53 S
         fcb   $00 
         fcb   $63 c
         fcb   $FF 
         fcb   $82 
         fcb   $00 
         fcb   $73 s
         fcb   $FF 
         fcb   $A8 (
         fcb   $16 
         fcb   $00 
         fcb   $12 
         fcb   $EC l
         fcb   $6A j
         fcb   $ED m
         fcb   $E3 c
         fcb   $C3 C
         fcb   $00 
         fcb   $01 
         fcb   $ED m
         fcb   $6C l
         fcb   $EC l
         fcb   $E1 a
         fcb   $ED m
         fcb   $E3 c
         fcb   $E6 f
         fcb   $67 g
         fcb   $1D 
         fcb   $E7 g
         fcb   $F1 q
         fcb   $16 
         fcb   $FC 
         fcb   $DB [
         fcb   $EC l
         fcb   $6A j
         fcb   $ED m
         fcb   $E3 c
         fcb   $4F O
         fcb   $5F _
         fcb   $E7 g
         fcb   $F1 q
         fcb   $CC L
         fcb   $00 
         fcb   $01 
         fcb   $32 2
         fcb   $66 f
         fcb   $39 9
         fcb   $32 2
         fcb   $74 t
         fcb   $32 2
         fcb   $7A z
         fcb   $EC l
         fcb   $E8 h
         fcb   $1A 
         fcb   $1F 
         fcb   $01 
         fcb   $EC l
         fcb   $84 
         fcb   $ED m
         fcb   $E8 h
         fcb   $10 
         fcb   $1F 
         fcb   $40 @
         fcb   $C3 C
         fcb   $00 
         fcb   $06 
         fcb   $ED m
         fcb   $6E n
         fcb   $AE .
         fcb   $E8 h
         fcb   $14 
         fcb   $EC l
         fcb   $E8 h
         fcb   $16 
         fcb   $ED m
         fcb   $E3 c
         fcb   $AF /
         fcb   $E3 c
         fcb   $4F O
         fcb   $5F _
         fcb   $8E 
         fcb   $00 
         fcb   $00 
         fcb   $AC ,
         fcb   $E1 a
         fcb   $26 &
         fcb   $03 
         fcb   $10 
         fcb   $A3 #
         fcb   $E4 d
         fcb   $32 2
         fcb   $62 b
         fcb   $10 
         fcb   $2F /
         fcb   $00 
         fcb   $15 
         fcb   $EC l
         fcb   $E8 h
         fcb   $18 
         fcb   $ED m
         fcb   $E3 c
         fcb   $CC L
         fcb   $00 
         fcb   $0A 
         fcb   $10 
         fcb   $A3 #
         fcb   $E1 a
         fcb   $10 
         fcb   $26 &
         fcb   $00 
         fcb   $06 
         fcb   $CC L
         fcb   $00 
         fcb   $01 
         fcb   $16 
         fcb   $00 
         fcb   $05 
         fcb   $4F O
         fcb   $5F _
         fcb   $16 
         fcb   $00 
         fcb   $00 
         fcb   $ED m
         fcb   $62 b
         fcb   $10 
         fcb   $27 '
         fcb   $00 
         fcb   $1B 
         fcb   $AE .
         fcb   $E8 h
         fcb   $14 
         fcb   $EC l
         fcb   $E8 h
         fcb   $16 
         fcb   $43 C
         fcb   $53 S
         fcb   $1E 
         fcb   $01 
         fcb   $43 C
         fcb   $53 S
         fcb   $30 0
         fcb   $01 
         fcb   $27 '
         fcb   $03 
         fcb   $C3 C
         fcb   $00 
         fcb   $01 
         fcb   $1E 
         fcb   $01 
         fcb   $AF /
         fcb   $E8 h
         fcb   $14 
         fcb   $ED m
         fcb   $E8 h
         fcb   $16 
         fcb   $AE .
         fcb   $E8 h
         fcb   $14 
         fcb   $EC l
         fcb   $E8 h
         fcb   $16 
         fcb   $ED m
         fcb   $E3 c
         fcb   $AF /
         fcb   $E3 c
         fcb   $4F O
         fcb   $5F _
         fcb   $8E 
         fcb   $00 
         fcb   $00 
         fcb   $AC ,
         fcb   $E1 a
         fcb   $26 &
         fcb   $03 
         fcb   $10 
         fcb   $A3 #
         fcb   $E4 d
         fcb   $32 2
         fcb   $62 b
         fcb   $10 
         fcb   $26 &
         fcb   $00 
         fcb   $16 
         fcb   $EC l
         fcb   $6E n
         fcb   $ED m
         fcb   $E3 c
         fcb   $C3 C
         fcb   $00 
         fcb   $01 
         fcb   $ED m
         fcb   $E8 h
         fcb   $10 
         fcb   $EC l
         fcb   $E1 a
         fcb   $ED m
         fcb   $E3 c
         fcb   $CC L
         fcb   $00 
         fcb   $30 0
         fcb   $E7 g
         fcb   $F1 q
         fcb   $16 
         fcb   $00 
         fcb   $87 
         fcb   $AE .
         fcb   $E8 h
         fcb   $14 
         fcb   $EC l
         fcb   $E8 h
         fcb   $16 
         fcb   $10 
         fcb   $27 '
         fcb   $00 
         fcb   $7D ý
         fcb   $AE .
         fcb   $E8 h
         fcb   $14 
         fcb   $EC l
         fcb   $E8 h
         fcb   $16 
         fcb   $ED m
         fcb   $E3 c
         fcb   $AF /
         fcb   $E3 c
         fcb   $EC l
         fcb   $E8 h
         fcb   $1C 
         fcb   $8E 
         fcb   $00 
         fcb   $00 
         fcb   $17 
         fcb   $03 
         fcb   $5C \
         fcb   $AE .
         fcb   $E1 a
         fcb   $EC l
         fcb   $E1 a
         fcb   $ED m
         fcb   $E4 d
         fcb   $EC l
         fcb   $E4 d
         fcb   $ED m
         fcb   $E3 c
         fcb   $CC L
         fcb   $00 
         fcb   $0A 
         fcb   $10 
         fcb   $A3 #
         fcb   $E1 a
         fcb   $10 
         fcb   $2F /
         fcb   $00 
         fcb   $0E 
         fcb   $EC l
         fcb   $E4 d
         fcb   $ED m
         fcb   $E3 c
         fcb   $CC L
         fcb   $00 
         fcb   $30 0
         fcb   $E3 c
         fcb   $E1 a
         fcb   $ED m
         fcb   $E4 d
         fcb   $16 
         fcb   $00 
         fcb   $18 
         fcb   $EC l
         fcb   $E4 d
         fcb   $ED m
         fcb   $E3 c
         fcb   $CC L
         fcb   $00 
         fcb   $41 A
         fcb   $ED m
         fcb   $E3 c
         fcb   $CC L
         fcb   $00 
         fcb   $0A 
         fcb   $35 5
         fcb   $10 
         fcb   $34 4
         fcb   $06 
         fcb   $1F 
         fcb   $10 
         fcb   $A3 #
         fcb   $E1 a
         fcb   $E3 c
         fcb   $E1 a
         fcb   $ED m
         fcb   $E4 d
         fcb   $EC l
         fcb   $6E n
         fcb   $ED m
         fcb   $E3 c
         fcb   $C3 C
         fcb   $00 
         fcb   $01 
         fcb   $ED m
         fcb   $E8 h
         fcb   $10 
         fcb   $EC l
         fcb   $E1 a
         fcb   $ED m
         fcb   $E3 c
         fcb   $EC l
         fcb   $62 b
         fcb   $E7 g
         fcb   $F1 q
         fcb   $AE .
         fcb   $E8 h
         fcb   $14 
         fcb   $EC l
         fcb   $E8 h
         fcb   $16 
         fcb   $ED m
         fcb   $E3 c
         fcb   $AF /
         fcb   $E3 c
         fcb   $EC l
         fcb   $E8 h
         fcb   $1C 
         fcb   $8E 
         fcb   $00 
         fcb   $00 
         fcb   $17 
         fcb   $02 
         fcb   $FD 
         fcb   $32 2
         fcb   $64 d
         fcb   $AF /
         fcb   $E8 h
         fcb   $14 
         fcb   $ED m
         fcb   $E8 h
         fcb   $16 
         fcb   $16 
         fcb   $FF 
         fcb   $79 y
         fcb   $EC l
         fcb   $6E n
         fcb   $ED m
         fcb   $E3 c
         fcb   $1F 
         fcb   $40 @
         fcb   $C3 C
         fcb   $00 
         fcb   $08 
         fcb   $35 5
         fcb   $10 
         fcb   $34 4
         fcb   $06 
         fcb   $1F 
         fcb   $10 
         fcb   $A3 #
         fcb   $E1 a
         fcb   $ED m
         fcb   $64 d
         fcb   $EC l
         fcb   $C9 I
         fcb   $04 
         fcb   $2C ,
         fcb   $ED m
         fcb   $E3 c
         fcb   $EC l
         fcb   $66 f
         fcb   $35 5
         fcb   $10 
         fcb   $34 4
         fcb   $06 
         fcb   $1F 
         fcb   $10 
         fcb   $A3 #
         fcb   $E1 a
         fcb   $ED m
         fcb   $C9 I
         fcb   $04 
         fcb   $2C ,
         fcb   $ED m
         fcb   $E3 c
         fcb   $4F O
         fcb   $5F _
         fcb   $10 
         fcb   $A3 #
         fcb   $E1 a
         fcb   $10 
         fcb   $2C ,
         fcb   $00 
         fcb   $80 
         fcb   $EC l
         fcb   $62 b
         fcb   $10 
         fcb   $27 '
         fcb   $00 
         fcb   $38 8
         fcb   $EC l
         fcb   $C9 I
         fcb   $04 
         fcb   $2C ,
         fcb   $ED m
         fcb   $E3 c
         fcb   $83 
         fcb   $00 
         fcb   $01 
         fcb   $ED m
         fcb   $C9 I
         fcb   $04 
         fcb   $2C ,
         fcb   $EC l
         fcb   $E1 a
         fcb   $E6 f
         fcb   $C9 I
         fcb   $04 
         fcb   $98 
         fcb   $1D 
         fcb   $ED m
         fcb   $E3 c
         fcb   $CC L
         fcb   $00 
         fcb   $30 0
         fcb   $10 
         fcb   $A3 #
         fcb   $E1 a
         fcb   $10 
         fcb   $26 &
         fcb   $00 
         fcb   $18 
         fcb   $EC l
         fcb   $E8 h
         fcb   $10 
         fcb   $ED m
         fcb   $E3 c
         fcb   $C3 C
         fcb   $00 
         fcb   $01 
         fcb   $ED m
         fcb   $E8 h
         fcb   $12 
         fcb   $EC l
         fcb   $E1 a
         fcb   $ED m
         fcb   $E3 c
         fcb   $CC L
         fcb   $00 
         fcb   $2D -
         fcb   $E7 g
         fcb   $F1 q
         fcb   $4F O
         fcb   $5F _
         fcb   $ED m
         fcb   $62 b
         fcb   $EC l
         fcb   $C9 I
         fcb   $04 
         fcb   $94 
         fcb   $ED m
         fcb   $E3 c
         fcb   $4F O
         fcb   $5F _
         fcb   $10 
         fcb   $A3 #
         fcb   $E1 a
         fcb   $10 
         fcb   $26 &
         fcb   $00 
         fcb   $33 3
         fcb   $EC l
         fcb   $C9 I
         fcb   $04 
         fcb   $2C ,
         fcb   $ED m
         fcb   $E3 c
         fcb   $83 
         fcb   $00 
         fcb   $01 
         fcb   $ED m
         fcb   $C9 I
         fcb   $04 
         fcb   $2C ,
         fcb   $EC l
         fcb   $E1 a
         fcb   $ED m
         fcb   $E3 c
         fcb   $4F O
         fcb   $5F _
         fcb   $10 
         fcb   $A3 #
         fcb   $E1 a
         fcb   $10 
         fcb   $2C ,
         fcb   $00 
         fcb   $19 
         fcb   $EC l
         fcb   $E8 h
         fcb   $10 
         fcb   $ED m
         fcb   $E3 c
         fcb   $C3 C
         fcb   $00 
         fcb   $01 
         fcb   $ED m
         fcb   $E8 h
         fcb   $12 
         fcb   $EC l
         fcb   $E1 a
         fcb   $ED m
         fcb   $E3 c
         fcb   $E6 f
         fcb   $C9 I
         fcb   $04 
         fcb   $98 
         fcb   $1D 
         fcb   $E7 g
         fcb   $F1 q
         fcb   $16 
         fcb   $FF 
         fcb   $CD M
         fcb   $EC l
         fcb   $62 b
         fcb   $10 
         fcb   $27 '
         fcb   $00 
         fcb   $14 
         fcb   $EC l
         fcb   $E8 h
         fcb   $10 
         fcb   $ED m
         fcb   $E3 c
         fcb   $C3 C
         fcb   $00 
         fcb   $01 
         fcb   $ED m
         fcb   $E8 h
         fcb   $12 
         fcb   $EC l
         fcb   $E1 a
         fcb   $ED m
         fcb   $E3 c
         fcb   $CC L
         fcb   $00 
         fcb   $2D -
         fcb   $E7 g
         fcb   $F1 q
         fcb   $EC l
         fcb   $64 d
         fcb   $ED m
         fcb   $E3 c
         fcb   $83 
         fcb   $00 
         fcb   $01 
         fcb   $ED m
         fcb   $66 f
         fcb   $EC l
         fcb   $E1 a
         fcb   $ED m
         fcb   $E3 c
         fcb   $4F O
         fcb   $5F _
         fcb   $10 
         fcb   $A3 #
         fcb   $E1 a
         fcb   $10 
         fcb   $2C ,
         fcb   $00 
         fcb   $22 "
         fcb   $EC l
         fcb   $E8 h
         fcb   $10 
         fcb   $ED m
         fcb   $E3 c
         fcb   $C3 C
         fcb   $00 
         fcb   $01 
         fcb   $ED m
         fcb   $E8 h
         fcb   $12 
         fcb   $EC l
         fcb   $E1 a
         fcb   $ED m
         fcb   $E3 c
         fcb   $EC l
         fcb   $E8 h
         fcb   $10 
         fcb   $83 
         fcb   $00 
         fcb   $01 
         fcb   $ED m
         fcb   $E8 h
         fcb   $10 
         fcb   $1F 
         fcb   $01 
         fcb   $E6 f
         fcb   $84 
         fcb   $1D 
         fcb   $E7 g
         fcb   $F1 q
         fcb   $16 
         fcb   $FF 
         fcb   $C8 H
         fcb   $EC l
         fcb   $C9 I
         fcb   $04 
         fcb   $2C ,
         fcb   $ED m
         fcb   $E3 c
         fcb   $83 
         fcb   $00 
         fcb   $01 
         fcb   $ED m
         fcb   $C9 I
         fcb   $04 
         fcb   $2C ,
         fcb   $EC l
         fcb   $E1 a
         fcb   $ED m
         fcb   $E3 c
         fcb   $4F O
         fcb   $5F _
         fcb   $10 
         fcb   $A3 #
         fcb   $E1 a
         fcb   $10 
         fcb   $2C ,
         fcb   $00 
         fcb   $19 
         fcb   $EC l
         fcb   $E8 h
         fcb   $10 
         fcb   $ED m
         fcb   $E3 c
         fcb   $C3 C
         fcb   $00 
         fcb   $01 
         fcb   $ED m
         fcb   $E8 h
         fcb   $12 
         fcb   $EC l
         fcb   $E1 a
         fcb   $ED m
         fcb   $E3 c
         fcb   $E6 f
         fcb   $C9 I
         fcb   $04 
         fcb   $98 
         fcb   $1D 
         fcb   $E7 g
         fcb   $F1 q
         fcb   $16 
         fcb   $FF 
         fcb   $CD M
         fcb   $EC l
         fcb   $E8 h
         fcb   $1A 
         fcb   $ED m
         fcb   $E3 c
         fcb   $EC l
         fcb   $E8 h
         fcb   $12 
         fcb   $ED m
         fcb   $F1 q
         fcb   $32 2
         fcb   $E8 h
         fcb   $12 
         fcb   $39 9
         fcb   $4F O
         fcb   $5F _
         fcb   $ED m
         fcb   $E3 c
         fcb   $17 
         fcb   $03 
         fcb   $58 X
         fcb   $32 2
         fcb   $62 b
         fcb   $39 9
         fcb   $CC L
         fcb   $00 
         fcb   $01 
         fcb   $ED m
         fcb   $E3 c
         fcb   $E6 f
         fcb   $65 e
         fcb   $1D 
         fcb   $ED m
         fcb   $E3 c
         fcb   $17 
         fcb   $03 
         fcb   $6D m
         fcb   $32 2
         fcb   $64 d
         fcb   $39 9
         fcb   $EC l
         fcb   $C9 I
         fcb   $04 
         fcb   $96 
         fcb   $1F 
         fcb   $01 
         fcb   $E6 f
         fcb   $84 
         fcb   $1D 
         fcb   $39 9
         fcb   $17 
         fcb   $FF 
         fcb   $F3 s
         fcb   $ED m
         fcb   $7E þ
         fcb   $10 
         fcb   $27 '
         fcb   $00 
         fcb   $11 
         fcb   $EC l
         fcb   $C9 I
         fcb   $04 
         fcb   $96 
         fcb   $ED m
         fcb   $E3 c
         fcb   $CC L
         fcb   $00 
         fcb   $01 
         fcb   $E3 c
         fcb   $E1 a
         fcb   $1F 
         fcb   $01 
         fcb   $E6 f
         fcb   $84 
         fcb   $1D 
         fcb   $39 9
         fcb   $4F O
         fcb   $5F _
         fcb   $39 9
         fcb   $17 
         fcb   $FF 
         fcb   $D6 V
         fcb   $ED m
         fcb   $7E þ
         fcb   $10 
         fcb   $27 '
         fcb   $00 
         fcb   $15 
         fcb   $EC l
         fcb   $C9 I
         fcb   $04 
         fcb   $96 
         fcb   $ED m
         fcb   $E3 c
         fcb   $C3 C
         fcb   $00 
         fcb   $01 
         fcb   $ED m
         fcb   $C9 I
         fcb   $04 
         fcb   $96 
         fcb   $EC l
         fcb   $E1 a
         fcb   $1F 
         fcb   $01 
         fcb   $E6 f
         fcb   $84 
         fcb   $1D 
         fcb   $39 9
         fcb   $4F O
         fcb   $5F _
         fcb   $39 9
L0687    fcb   $AE .
         fcb   $62 b
         fcb   $10 
         fcb   $AE .
         fcb   $84 
         fcb   $27 '
         fcb   $0B 
         fcb   $30 0
         fcb   $04 
         fcb   $10 
         fcb   $A3 #
         fcb   $84 
         fcb   $27 '
         fcb   $06 
         fcb   $31 1
         fcb   $3F ?
         fcb   $26 &
         fcb   $F5 u
         fcb   $AE .
         fcb   $62 b
         fcb   $EC l
         fcb   $02 
         fcb   $10 
         fcb   $27 '
         fcb   $02 
         fcb   $77 w
         fcb   $E3 c
         fcb   $62 b
         fcb   $ED m
         fcb   $E4 d
         fcb   $16 
         fcb   $02 
         fcb   $70 p
         fcb   $6F o
         fcb   $E2 b
         fcb   $4D M
         fcb   $2A *
         fcb   $07 
         fcb   $63 c
         fcb   $E4 d
         fcb   $53 S
         fcb   $43 C
         fcb   $C3 C
         fcb   $00 
         fcb   $01 
         fcb   $1F 
         fcb   $02 
         fcb   $EC l
         fcb   $63 c
         fcb   $2A *
         fcb   $07 
         fcb   $63 c
         fcb   $E4 d
         fcb   $53 S
         fcb   $43 C
         fcb   $C3 C
         fcb   $00 
         fcb   $01 
         fcb   $8E 
         fcb   $00 
         fcb   $00 
         fcb   $34 4
         fcb   $06 
         fcb   $34 4
         fcb   $10 
         fcb   $1F 
         fcb   $20 
         fcb   $8D 
         fcb   $7B û
         fcb   $6D m
         fcb   $E0 `
         fcb   $10 
         fcb   $27 '
         fcb   $02 
         fcb   $46 F
         fcb   $53 S
         fcb   $43 C
         fcb   $C3 C
         fcb   $00 
         fcb   $01 
         fcb   $16 
         fcb   $02 
         fcb   $3E >
         fcb   $AE .
         fcb   $62 b
         fcb   $34 4
         fcb   $10 
         fcb   $8E 
         fcb   $00 
         fcb   $00 
         fcb   $34 4
         fcb   $10 
         fcb   $8D 
         fcb   $62 b
         fcb   $16 
         fcb   $02 
         fcb   $30 0
         fcb   $6F o
         fcb   $E2 b
         fcb   $1E 
         fcb   $10 
         fcb   $4D M
         fcb   $2D -
         fcb   $04 
         fcb   $1E 
         fcb   $01 
         fcb   $20 
         fcb   $0F 
         fcb   $63 c
         fcb   $E4 d
         fcb   $43 C
         fcb   $53 S
         fcb   $1E 
         fcb   $01 
         fcb   $43 C
         fcb   $53 S
         fcb   $C3 C
         fcb   $00 
         fcb   $01 
         fcb   $24 $
         fcb   $02 
         fcb   $30 0
         fcb   $01 
         fcb   $1F 
         fcb   $02 
         fcb   $6D m
         fcb   $63 c
         fcb   $2A *
         fcb   $19 
         fcb   $63 c
         fcb   $E4 d
         fcb   $63 c
         fcb   $66 f
         fcb   $63 c
         fcb   $65 e
         fcb   $63 c
         fcb   $64 d
         fcb   $63 c
         fcb   $63 c
         fcb   $EC l
         fcb   $65 e
         fcb   $C3 C
         fcb   $00 
         fcb   $01 
         fcb   $ED m
         fcb   $65 e
         fcb   $EC l
         fcb   $63 c
         fcb   $C9 I
         fcb   $00 
         fcb   $89 
         fcb   $00 
         fcb   $ED m
         fcb   $63 c
         fcb   $EC l
         fcb   $65 e
         fcb   $34 4
         fcb   $06 
         fcb   $EC l
         fcb   $65 e
         fcb   $34 4
         fcb   $06 
         fcb   $1F 
         fcb   $20 
         fcb   $8D 
         fcb   $1A 
         fcb   $6D m
         fcb   $E0 `
         fcb   $10 
         fcb   $27 '
         fcb   $01 
         fcb   $EC l
         fcb   $43 C
         fcb   $53 S
         fcb   $1E 
         fcb   $10 
         fcb   $43 C
         fcb   $53 S
         fcb   $1E 
         fcb   $01 
         fcb   $C3 C
         fcb   $00 
         fcb   $01 
         fcb   $10 
         fcb   $24 $
         fcb   $01 
         fcb   $DD ]
         fcb   $30 0
         fcb   $01 
         fcb   $16 
         fcb   $01 
         fcb   $D8 X
         fcb   $10 
         fcb   $8E 
         fcb   $00 
         fcb   $00 
         fcb   $34 4
         fcb   $20 
         fcb   $34 4
         fcb   $20 
         fcb   $AF /
         fcb   $7E þ
         fcb   $26 &
         fcb   $04 
         fcb   $ED m
         fcb   $7E þ
         fcb   $27 '
         fcb   $26 &
         fcb   $1E 
         fcb   $10 
         fcb   $44 D
         fcb   $56 V
         fcb   $1E 
         fcb   $01 
         fcb   $46 F
         fcb   $56 V
         fcb   $24 $
         fcb   $12 
         fcb   $34 4
         fcb   $06 
         fcb   $EC l
         fcb   $64 d
         fcb   $E3 c
         fcb   $6A j
         fcb   $ED m
         fcb   $64 d
         fcb   $EC l
         fcb   $62 b
         fcb   $E9 i
         fcb   $69 i
         fcb   $A9 )
         fcb   $68 h
         fcb   $ED m
         fcb   $62 b
         fcb   $35 5
         fcb   $06 
         fcb   $68 h
         fcb   $69 i
         fcb   $69 i
         fcb   $68 h
         fcb   $69 i
         fcb   $67 g
         fcb   $69 i
         fcb   $66 f
         fcb   $20 
         fcb   $D2 R
         fcb   $35 5
         fcb   $10 
         fcb   $35 5
         fcb   $06 
         fcb   $16 
         fcb   $01 
         fcb   $9B 
         fcb   $6F o
         fcb   $E2 b
         fcb   $4D M
         fcb   $2A *
         fcb   $07 
         fcb   $63 c
         fcb   $E4 d
         fcb   $53 S
         fcb   $43 C
         fcb   $C3 C
         fcb   $00 
         fcb   $01 
         fcb   $1F 
         fcb   $02 
         fcb   $EC l
         fcb   $63 c
         fcb   $2A *
         fcb   $07 
         fcb   $63 c
         fcb   $E4 d
         fcb   $53 S
         fcb   $43 C
         fcb   $C3 C
         fcb   $00 
         fcb   $01 
         fcb   $8E 
         fcb   $00 
         fcb   $00 
         fcb   $34 4
         fcb   $06 
         fcb   $34 4
         fcb   $10 
         fcb   $1F 
         fcb   $20 
         fcb   $17 
         fcb   $00 
         fcb   $A8 (
         fcb   $AE .
         fcb   $62 b
         fcb   $32 2
         fcb   $64 d
         fcb   $6D m
         fcb   $63 c
         fcb   $10 
         fcb   $2A *
         fcb   $FF 
         fcb   $19 
         fcb   $1E 
         fcb   $10 
         fcb   $53 S
         fcb   $43 C
         fcb   $C3 C
         fcb   $00 
         fcb   $01 
         fcb   $1E 
         fcb   $10 
         fcb   $16 
         fcb   $FF 
         fcb   $0D 
         fcb   $AE .
         fcb   $62 b
         fcb   $34 4
         fcb   $10 
         fcb   $8E 
         fcb   $00 
         fcb   $00 
         fcb   $34 4
         fcb   $10 
         fcb   $17 
         fcb   $00 
         fcb   $86 
         fcb   $AE .
         fcb   $62 b
         fcb   $32 2
         fcb   $64 d
         fcb   $16 
         fcb   $01 
         fcb   $46 F
         fcb   $6F o
         fcb   $E2 b
         fcb   $4D M
         fcb   $2A *
         fcb   $11 
         fcb   $63 c
         fcb   $E4 d
         fcb   $53 S
         fcb   $43 C
         fcb   $1E 
         fcb   $10 
         fcb   $53 S
         fcb   $43 C
         fcb   $1E 
         fcb   $01 
         fcb   $C3 C
         fcb   $00 
         fcb   $01 
         fcb   $24 $
         fcb   $02 
         fcb   $30 0
         fcb   $01 
         fcb   $1F 
         fcb   $02 
         fcb   $6D m
         fcb   $63 c
         fcb   $2A *
         fcb   $19 
         fcb   $63 c
         fcb   $E4 d
         fcb   $63 c
         fcb   $66 f
         fcb   $63 c
         fcb   $65 e
         fcb   $63 c
         fcb   $64 d
         fcb   $63 c
         fcb   $63 c
         fcb   $EC l
         fcb   $65 e
         fcb   $C3 C
         fcb   $00 
         fcb   $01 
         fcb   $ED m
         fcb   $65 e
         fcb   $EC l
         fcb   $63 c
         fcb   $C9 I
         fcb   $00 
         fcb   $89 
         fcb   $00 
         fcb   $ED m
         fcb   $63 c
         fcb   $EC l
         fcb   $65 e
         fcb   $34 4
         fcb   $06 
         fcb   $EC l
         fcb   $65 e
         fcb   $34 4
         fcb   $06 
         fcb   $1F 
         fcb   $20 
         fcb   $8D 
         fcb   $3E >
         fcb   $6D m
         fcb   $64 d
         fcb   $2A *
         fcb   $0F 
         fcb   $53 S
         fcb   $43 C
         fcb   $1E 
         fcb   $10 
         fcb   $53 S
         fcb   $43 C
         fcb   $1E 
         fcb   $01 
         fcb   $C3 C
         fcb   $00 
         fcb   $01 
         fcb   $24 $
         fcb   $02 
         fcb   $30 0
         fcb   $01 
         fcb   $1F 
         fcb   $02 
         fcb   $6D m
         fcb   $67 g
         fcb   $2A *
         fcb   $18 
         fcb   $63 c
         fcb   $63 c
         fcb   $63 c
         fcb   $62 b
         fcb   $63 c
         fcb   $61 a
         fcb   $63 c
         fcb   $E4 d
         fcb   $EC l
         fcb   $62 b
         fcb   $C3 C
         fcb   $00 
         fcb   $01 
         fcb   $ED m
         fcb   $62 b
         fcb   $24 $
         fcb   $07 
         fcb   $EC l
         fcb   $E4 d
         fcb   $C3 C
         fcb   $00 
         fcb   $01 
         fcb   $ED m
         fcb   $E4 d
         fcb   $EC l
         fcb   $E1 a
         fcb   $ED m
         fcb   $65 e
         fcb   $EC l
         fcb   $E1 a
         fcb   $ED m
         fcb   $65 e
         fcb   $32 2
         fcb   $61 a
         fcb   $1F 
         fcb   $20 
         fcb   $39 9
         fcb   $10 
         fcb   $8E 
         fcb   $00 
         fcb   $00 
         fcb   $34 4
         fcb   $20 
         fcb   $34 4
         fcb   $20 
         fcb   $AC ,
         fcb   $66 f
         fcb   $22 "
         fcb   $07 
         fcb   $25 %
         fcb   $0A 
         fcb   $10 
         fcb   $A3 #
         fcb   $68 h
         fcb   $23 #
         fcb   $05 
         fcb   $AE .
         fcb   $E1 a
         fcb   $EC l
         fcb   $E1 a
         fcb   $39 9
         fcb   $31 1
         fcb   $21 !
         fcb   $AC ,
         fcb   $66 f
         fcb   $22 "
         fcb   $13 
         fcb   $25 %
         fcb   $07 
         fcb   $10 
         fcb   $A3 #
         fcb   $68 h
         fcb   $22 "
         fcb   $0C 
         fcb   $27 '
         fcb   $14 
         fcb   $58 X
         fcb   $49 I
         fcb   $1E 
         fcb   $10 
         fcb   $59 Y
         fcb   $49 I
         fcb   $1E 
         fcb   $01 
         fcb   $20 
         fcb   $E7 g
         fcb   $1E 
         fcb   $10 
         fcb   $44 D
         fcb   $56 V
         fcb   $1E 
         fcb   $01 
         fcb   $46 F
         fcb   $56 V
         fcb   $31 1
         fcb   $3F ?
         fcb   $34 4
         fcb   $10 
         fcb   $AE .
         fcb   $6A j
         fcb   $ED m
         fcb   $6A j
         fcb   $EC l
         fcb   $E4 d
         fcb   $AF /
         fcb   $E4 d
         fcb   $AE .
         fcb   $68 h
         fcb   $ED m
         fcb   $68 h
         fcb   $35 5
         fcb   $06 
         fcb   $68 h
         fcb   $63 c
         fcb   $69 i
         fcb   $62 b
         fcb   $69 i
         fcb   $61 a
         fcb   $69 i
         fcb   $E4 d
         fcb   $AC ,
         fcb   $66 f
         fcb   $22 "
         fcb   $07 
         fcb   $25 %
         fcb   $11 
         fcb   $10 
         fcb   $A3 #
         fcb   $68 h
         fcb   $25 %
         fcb   $0C 
         fcb   $A3 #
         fcb   $68 h
         fcb   $1E 
         fcb   $01 
         fcb   $E2 b
         fcb   $67 g
         fcb   $A2 "
         fcb   $66 f
         fcb   $1E 
         fcb   $01 
         fcb   $6C l
         fcb   $63 c
         fcb   $64 d
         fcb   $66 f
         fcb   $66 f
         fcb   $67 g
         fcb   $66 f
         fcb   $68 h
         fcb   $66 f
         fcb   $69 i
         fcb   $31 1
         fcb   $3F ?
         fcb   $26 &
         fcb   $D5 U
         fcb   $AF /
         fcb   $66 f
         fcb   $ED m
         fcb   $68 h
         fcb   $AE .
         fcb   $E1 a
         fcb   $EC l
         fcb   $E1 a
         fcb   $39 9
         fcb   $1F 
         fcb   $01 
         fcb   $EC l
         fcb   $62 b
         fcb   $30 0
         fcb   $84 
         fcb   $27 '
         fcb   $40 @
         fcb   $44 D
         fcb   $56 V
         fcb   $30 0
         fcb   $1F 
         fcb   $20 
         fcb   $F8 x
         fcb   $1F 
         fcb   $02 
         fcb   $AE .
         fcb   $62 b
         fcb   $EC l
         fcb   $64 d
         fcb   $31 1
         fcb   $A4 $
         fcb   $27 '
         fcb   $37 7
         fcb   $1E 
         fcb   $10 
         fcb   $44 D
         fcb   $56 V
         fcb   $1E 
         fcb   $10 
         fcb   $46 F
         fcb   $56 V
         fcb   $31 1
         fcb   $3F ?
         fcb   $20 
         fcb   $F2 r
L08F4    fcb   $1F 
         fcb   $01 
         fcb   $EC l
         fcb   $62 b
         fcb   $30 0
         fcb   $84 
         fcb   $27 '
         fcb   $1C 
         fcb   $58 X
         fcb   $49 I
         fcb   $30 0
         fcb   $1F 
         fcb   $20 
         fcb   $F8 x
         fcb   $1F 
         fcb   $02 
         fcb   $AE .
         fcb   $62 b
         fcb   $EC l
         fcb   $64 d
         fcb   $31 1
         fcb   $A4 $
         fcb   $27 '
         fcb   $13 
         fcb   $58 X
         fcb   $49 I
         fcb   $1E 
         fcb   $10 
         fcb   $59 Y
         fcb   $49 I
         fcb   $1E 
         fcb   $01 
         fcb   $31 1
         fcb   $3F ?
         fcb   $20 
         fcb   $F2 r
         fcb   $10 
         fcb   $AE .
         fcb   $E1 a
         fcb   $10 
         fcb   $AF /
         fcb   $E4 d
         fcb   $39 9
         fcb   $10 
         fcb   $AE .
         fcb   $E1 a
         fcb   $10 
         fcb   $AF /
         fcb   $62 b
         fcb   $32 2
         fcb   $62 b
         fcb   $39 9
         fcb   $30 0
         fcb   $8D 
         fcb   $00 
         fcb   $03 
         fcb   $1F 
         fcb   $10 
         fcb   $39 9
         fcb   $2F /
         fcb   $64 d
         fcb   $30 0
         fcb   $2F /
         fcb   $69 i
         fcb   $6E n
         fcb   $63 c
         fcb   $6C l
         fcb   $75 u
         fcb   $64 d
         fcb   $65 e
         fcb   $2F /
         fcb   $00 
         fcb   $1F 
         fcb   $30 0
         fcb   $39 9
         fcb   $CC L
         fcb   $04 
         fcb   $99 
         fcb   $39 9
         fcb   $1F 
         fcb   $40 @
         fcb   $34 4
         fcb   $40 @
         fcb   $A3 #
         fcb   $E1 a
         fcb   $83 
         fcb   $04 
         fcb   $99 
         fcb   $39 9
L094D    fcb   $E6 f
         fcb   $F8 x
         fcb   $04 
         fcb   $86 
         fcb   $01 
         fcb   $C1 A
         fcb   $72 r
         fcb   $27 '
         fcb   $0A 
         fcb   $86 
         fcb   $02 
         fcb   $C1 A
         fcb   $77 w
         fcb   $27 '
         fcb   $04 
         fcb   $CC L
         fcb   $00 
         fcb   $00 
         fcb   $39 9
         fcb   $AE .
         fcb   $62 b
         fcb   $34 4
         fcb   $02 
         fcb   $10 
         fcb   $3F ?
         fcb   $84 
         fcb   $24 $
         fcb   $0D 
         fcb   $A6 &
         fcb   $E4 d
         fcb   $85 
         fcb   $02 
         fcb   $27 '
         fcb   $07 
         fcb   $C6 F
         fcb   $0B 
         fcb   $AE .
         fcb   $63 c
         fcb   $10 
         fcb   $3F ?
         fcb   $83 
         fcb   $35 5
         fcb   $04 
         fcb   $25 %
         fcb   $E2 b
         fcb   $1F 
         fcb   $89 
         fcb   $4F O
         fcb   $39 9
         fcb   $A6 &
         fcb   $63 c
         fcb   $10 
         fcb   $3F ?
         fcb   $8F 
         fcb   $39 9
         fcb   $A6 &
         fcb   $63 c
         fcb   $32 2
         fcb   $7E þ
         fcb   $1F 
         fcb   $41 A
         fcb   $10 
         fcb   $8E 
         fcb   $00 
         fcb   $01 
         fcb   $10 
         fcb   $3F ?
         fcb   $89 
         fcb   $24 $
         fcb   $04 
         fcb   $C6 F
         fcb   $FF 
         fcb   $20 
         fcb   $04 
         fcb   $E6 f
         fcb   $E4 d
         fcb   $C4 D
         fcb   $7F ÿ
         fcb   $1D 
         fcb   $32 2
         fcb   $62 b
         fcb   $C1 A
         fcb   $0A 
         fcb   $27 '
         fcb   $E2 b
         fcb   $C1 A
         fcb   $0D 
         fcb   $26 &
         fcb   $02 
         fcb   $C6 F
         fcb   $0A 
         fcb   $39 9
         fcb   $A6 &
         fcb   $65 e
         fcb   $E6 f
         fcb   $63 c
         fcb   $C1 A
         fcb   $09 
         fcb   $26 &
         fcb   $0F 
         fcb   $C6 F
         fcb   $20 
         fcb   $8D 
         fcb   $2F /
         fcb   $25 %
         fcb   $29 )
         fcb   $E6 f
         fcb   $C9 I
         fcb   $00 
         fcb   $00 
         fcb   $C1 A
         fcb   $01 
         fcb   $26 &
         fcb   $F2 r
         fcb   $39 9
         fcb   $C1 A
         fcb   $0A 
         fcb   $27 '
         fcb   $04 
         fcb   $C1 A
         fcb   $0D 
         fcb   $26 &
         fcb   $0A 
         fcb   $C6 F
         fcb   $01 
         fcb   $E7 g
         fcb   $C9 I
         fcb   $00 
         fcb   $00 
         fcb   $C6 F
         fcb   $0D 
         fcb   $20 
         fcb   $0A 
         fcb   $68 h
         fcb   $C9 I
         fcb   $00 
         fcb   $00 
         fcb   $26 &
         fcb   $04 
         fcb   $6C l
         fcb   $C9 I
         fcb   $00 
         fcb   $00 
         fcb   $8D 
         fcb   $06 
         fcb   $24 $
         fcb   $02 
         fcb   $C6 F
         fcb   $FF 
         fcb   $1D 
         fcb   $39 9
         fcb   $34 4
         fcb   $06 
         fcb   $30 0
         fcb   $61 a
         fcb   $10 
         fcb   $8E 
         fcb   $00 
         fcb   $01 
         fcb   $10 
         fcb   $3F ?
         fcb   $8C 
         fcb   $35 5
         fcb   $86 
         fcb   $4F O
         fcb   $20 
         fcb   $02 
         fcb   $A6 &
         fcb   $67 g
         fcb   $AE .
         fcb   $62 b
         fcb   $10 
         fcb   $AE .
         fcb   $64 d
         fcb   $10 
         fcb   $3F ?
         fcb   $8B 
         fcb   $25 %
         fcb   $09 
         fcb   $31 1
         fcb   $3F ?
         fcb   $1F 
         fcb   $20 
         fcb   $6F o
         fcb   $8B 
         fcb   $EC l
         fcb   $62 b
         fcb   $39 9
         fcb   $CC L
         fcb   $FF 
         fcb   $FF 
         fcb   $39 9
         fcb   $0D 
         fcb   $86 
         fcb   $01 
         fcb   $20 
         fcb   $02 
         fcb   $A6 &
         fcb   $65 e
         fcb   $AE .
         fcb   $62 b
         fcb   $31 1
         fcb   $84 
         fcb   $E6 f
         fcb   $80 
         fcb   $27 '
         fcb   $1B 
         fcb   $C1 A
         fcb   $0A 
         fcb   $27 '
         fcb   $04 
         fcb   $C1 A
         fcb   $0D 
         fcb   $26 &
         fcb   $F4 t
         fcb   $34 4
         fcb   $10 
         fcb   $8D 
         fcb   $0F 
         fcb   $30 0
         fcb   $8D 
         fcb   $FF 
         fcb   $E1 a
         fcb   $10 
         fcb   $8E 
         fcb   $00 
         fcb   $01 
         fcb   $10 
         fcb   $3F ?
         fcb   $8C 
         fcb   $35 5
         fcb   $10 
         fcb   $20 
         fcb   $DF _
         fcb   $34 4
         fcb   $22 "
         fcb   $30 0
         fcb   $1F 
         fcb   $1F 
         fcb   $10 
         fcb   $A3 #
         fcb   $61 a
         fcb   $1F 
         fcb   $02 
         fcb   $35 5
         fcb   $12 
         fcb   $31 1
         fcb   $A4 $
         fcb   $27 '
         fcb   $03 
         fcb   $10 
         fcb   $3F ?
         fcb   $8C 
         fcb   $39 9
start    equ   *
         clrb  
         ldb   #$01
         stb   >u0000,u
L0A52    lda   ,x+
         cmpa  #$20
         beq   L0A52
         cmpa  #$0D
         beq   L0A71
         incb  
         leay  -$01,x
         pshs  y
L0A61    lda   ,x+
         cmpa  #$20
         bne   L0A6B
         clr   -$01,x
         bra   L0A52
L0A6B    cmpa  #$0D
         bne   L0A61
         clr   -$01,x
L0A71    leax  >name,pcr
         pshs  x
         clra  
         leax  ,s
         pshs  x,b,a
         subb  #$02
         bls   L0A9D
         leax  $02,x
         lslb  
         leay  b,x
L0A85    lda   ,x
         ldb   ,y
         sta   ,y
         stb   ,x+
         lda   ,x
         ldb   $01,y
         sta   $01,y
         stb   ,x+
         leay  -$02,y
         pshs  y
         cmpx  ,s++
         bcs   L0A85
L0A9D    lbsr  L0AA4
L0AA0    clrb  
         os9   F$Exit   
L0AA4    leas  -$04,s
         leas  -$04,s
         leax  >u0006,u
         tfr   x,d
         std   ,--s
         ldd   #$0002
         addd  ,s++
         std   ,--s
         leax  >u0006,u
         tfr   x,d
         std   ,--s
         clra  
         clrb  
         addd  ,s++
         std   ,--s
         leax  >u0006,u
         tfr   x,d
         std   ,--s
         ldd   #$0004
         addd  ,s++
         std   ,--s
         leax  >u0026,u
         tfr   x,d
         std   [,s++]
         std   [,s++]
         std   [,s++]
         leax  >u0014,u
         tfr   x,d
         std   ,--s
         ldd   #$0002
         addd  ,s++
         std   ,--s
         leax  >u0014,u
         tfr   x,d
         std   ,--s
         clra  
         clrb  
         addd  ,s++
         std   ,--s
         leax  >u0014,u
         tfr   x,d
         std   ,--s
         ldd   #$0004
         addd  ,s++
         std   ,--s
         leax  >u0226,u
         tfr   x,d
         std   [,s++]
         std   [,s++]
         std   [,s++]
         leax  >u0006,u
         tfr   x,d
         std   ,--s
         ldd   #$000A
         addd  ,s++
         std   ,--s
         leax  >u0014,u
         tfr   x,d
         std   ,--s
         ldd   #$000A
         addd  ,s++
         std   ,--s
         ldd   #$0200
         std   [,s++]
         std   [,s++]
         leax  >u0006,u
         tfr   x,d
         std   ,--s
         ldd   #$0006
         addd  ,s++
         std   ,--s
         leax  >u0014,u
         tfr   x,d
         std   ,--s
         ldd   #$0006
         addd  ,s++
         std   ,--s
         clra  
         clrb  
         std   [,s++]
         std   [,s++]
         ldd   #$0001
         std   $06,s
L0B66    ldd   $06,s
         std   ,--s
         ldd   $0C,s
         cmpd  ,s++
         lble  L0D22
         ldd   $0C,s
         std   ,--s
         ldd   $08,s
         std   ,--s
         addd  #$0001
         std   $0A,s
         ldd   ,s++
         std   ,--s
         ldd   #$0001
         lbsr  L08F4
         addd  ,s++
         tfr   d,x
         ldd   ,x
         std   ,s
         ldd   ,s
         std   ,--s
         ldd   ,s++
         tfr   d,x
         ldb   ,x
         sex   
         std   ,--s
         ldd   #$002D
         cmpd  ,s++
         lbne  L0C1C
         ldd   ,s
         std   ,--s
         ldd   #$0001
         addd  ,s++
         tfr   d,x
         ldb   ,x
         sex   
         lbeq  L0C1C
         ldd   #$0001
         std   $04,s
         ldd   ,s
         std   ,--s
         ldd   $06,s
         std   ,--s
         addd  #$0001
         std   $08,s
         ldd   ,s++
         addd  ,s++
         tfr   d,x
         ldb   ,x
         sex   
         stb   $03,s
         lbeq  L0C19
         leax  >L0C12,pcr
         stx   ,--s
         ldb   $05,s
         sex   
         std   ,--s
         ldd   #$0020
         ora   ,s+
         orb   ,s+
         lbsr  L0687
         lbra  L0C16
         ldb   $03,s
         sex   
         std   ,--s
         leax  >L0EF0,pcr
         tfr   x,d
         std   ,--s
         lbsr  L0010
         leas  $04,s
         clra  
         clrb  
         std   ,--s
         lbsr  L0AA0
         leas  $02,s
         lbra  L0C16
L0C12    fcb   $00,$00,$FF,$E2
L0C16    fcb   $16,$FF,$A7
L0C19    fcb   $16,$01,$03
L0C1C    fcb   $ec,$e4,$ed,$e3,$ec,$e1,$1f,$01,$e6,$84
         sex   
         std   ,--s
         ldd   #$002D
         cmpd  ,s++
         lbne  L0C42
         leax  >L0F09,pcr
         tfr   x,d
         std   ,s
         clra  
         clrb  
         std   $04,s
         lbra  L0C7A
L0C42    leax  >L0F18,pcr
         tfr   x,d
         std   ,--s
         ldd   $02,s
         std   ,--s
         lbsr  L094D
         leas  $04,s
         std   $04,s
         std   ,--s
         clra  
         clrb  
         cmpd  ,s++
         lbne  L0C7A
         ldd   ,s
         std   ,--s
         leax  >L0F1A,pcr
         tfr   x,d
         std   ,--s
         lbsr  L0010
         leas  $04,s
         clra  
         clrb  
         std   ,--s
         lbsr  L0AA0
         leas  $02,s
L0C7A    leax  >u0006,u
         tfr   x,d
         std   ,--s
         ldd   #$0006
         addd  ,s++
         tfr   d,x
         ldd   ,x
         std   ,--s
         clra  
         clrb  
         cmpd  ,s++
         lbne  L0CBF
         leax  >u0006,u
         tfr   x,d
         std   ,--s
         ldd   #$0006
         addd  ,s++
         std   ,--s
         ldd   $02,s
         std   [,s++]
         leax  >u0006,u
         tfr   x,d
         std   ,--s
         ldd   #$0008
         addd  ,s++
         std   ,--s
         ldd   $06,s
         std   [,s++]
         lbra  L0D1F
L0CBF    leax  >u0014,u
         tfr   x,d
         std   ,--s
         ldd   #$0006
         addd  ,s++
         tfr   d,x
         ldd   ,x
         std   ,--s
         clra  
         clrb  
         cmpd  ,s++
         lbne  L0D04
         leax  >u0014,u
         tfr   x,d
         std   ,--s
         ldd   #$0006
         addd  ,s++
         std   ,--s
         ldd   $02,s
         std   [,s++]
         leax  >u0014,u
         tfr   x,d
         std   ,--s
         ldd   #$0008
         addd  ,s++
         std   ,--s
         ldd   $06,s
         std   [,s++]
         lbra  L0D1F
L0D04    leax  >L0F2B,pcr
         tfr   x,d
         std   ,--s
         ldd   #$0002
         std   ,--s
         lbsr  L003B
         leas  $04,s
         clra  
         clrb  
         std   ,--s
         lbsr  L0AA0
         leas  $02,s
L0D1F    lbra  L0B66
L0D22    clra  
         clrb  
         ldx   #$0000
         stx   >u0428,u
         std   >u042A,u
         stx   >u0022,u
         std   >u0024,u
         leax  >L0F48,pcr
         tfr   x,d
         std   ,--s
         lbsr  L0010
         leas  $02,s
L0D44    leax  >u0006,u
         tfr   x,d
         std   ,--s
         lbsr  L0FEA
         leas  $02,s
         std   >u0002,u
         std   ,--s
         ldd   #$FFFF
         cmpd  ,s++
         lbeq  L0E18
         leax  >u0014,u
         tfr   x,d
         std   ,--s
         lbsr  L0FEA
         leas  $02,s
         std   >u0004,u
         std   ,--s
         ldd   #$FFFF
         cmpd  ,s++
         lbeq  L0E18
         ldd   >u0002,u
         std   ,--s
         ldd   >u0004,u
         cmpd  ,s++
         lbeq  L0DFA
         ldx   >u0428,u
         ldd   >u042A,u
         std   ,--s
         stx   ,--s
         addd  #$0001
         exg   d,x
         adcb  #$00
         adca  #$00
         exg   d,x
         stx   >u0428,u
         std   >u042A,u
         ldx   ,s++
         ldd   ,s++
         std   ,--s
         stx   ,--s
         clra  
         clrb  
         ldx   #$0000
         cmpx  ,s++
         bne   L0DC2
         cmpd  ,s
L0DC2    leas  $02,s
         lbne  L0DD5
         leax  >L0F57,pcr
         tfr   x,d
         std   ,--s
         lbsr  L0010
         leas  $02,s
L0DD5    ldd   >u0004,u
         std   ,--s
         ldd   >u0002,u
         std   ,--s
         ldx   >u0022,u
         ldd   >u0024,u
         std   ,--s
         stx   ,--s
         leax  >L0F79,pcr
         tfr   x,d
         std   ,--s
         lbsr  L0010
         leas  $0A,s
L0DFA    ldx   >u0022,u
         ldd   >u0024,u
         addd  #$0001
         exg   d,x
         adcb  #$00
         adca  #$00
         exg   d,x
         stx   >u0022,u
         std   >u0024,u
         lbra  L0D44
L0E18    ldx   >u0428,u
         ldd   >u042A,u
         std   ,--s
         stx   ,--s
         clra  
         clrb  
         ldx   #$0000
         cmpx  ,s++
         bne   L0E30
         cmpd  ,s
L0E30    leas  $02,s
         lbne  L0E43
         leax  >L0F8B,pcr
         tfr   x,d
         std   ,--s
         lbsr  L0010
         leas  $02,s
L0E43    ldx   >u0022,u
         ldd   >u0024,u
         std   ,--s
         stx   ,--s
         leax  >L0F99,pcr
         tfr   x,d
         std   ,--s
         lbsr  L0010
         leas  $06,s
         ldx   >u0428,u
         ldd   >u042A,u
         std   ,--s
         stx   ,--s
         leax  >L0FB3,pcr
         tfr   x,d
         std   ,--s
         lbsr  L0010
         leas  $06,s
         ldd   >u0002,u
         std   ,--s
         ldd   #$FFFF
         cmpd  ,s++
         lbne  L0ECD
         leax  >u0014,u
         tfr   x,d
         std   ,--s
         lbsr  L0FEA
         leas  $02,s
         std   ,--s
         ldd   #$FFFF
         cmpd  ,s++
         lbne  L0EAA
         clra  
         clrb  
         std   ,--s
         lbsr  L0AA0
         leas  $02,s
         lbra  L0ECA
L0EAA    leax  >u0014,u
         tfr   x,d
         std   ,--s
         ldd   #$0006
         addd  ,s++
         tfr   d,x
         ldd   ,x
         std   ,--s
         leax  >L0FCC,pcr
         tfr   x,d
         std   ,--s
         lbsr  L0010
         leas  $04,s
L0ECA    lbra  L0EED
L0ECD    leax  >u0006,u
         tfr   x,d
         std   ,--s
         ldd   #$0006
         addd  ,s++
         tfr   d,x
         ldd   ,x
         std   ,--s
         leax  >L0FDB,pcr
         tfr   x,d
         std   ,--s
         lbsr  L0010
         leas  $04,s
L0EED    leas  $08,s
         rts   
L0EF0    fcc   "Cmp: unknown option -%c"
         fcb   C$LF,$00
L0F09    fcc   "standard input"
         fcb   $00
L0F18    fcc   "r"
         fcb   $00
L0F1A    fcc   "cannot open: %s"
         fcb   C$LF,$00
L0F2B    fcc   "use: cmp {-opt} path1 path2"
         fcb   C$LF
         fcb   $00
L0F48    fcb   C$LF
         fcc   " Differences"
         fcb   C$LF
         fcb   $00
L0F57    fcb   C$LF
         fcc   "byte      #1 #2"
         fcb   C$LF
         fcc   "========  == =="
         fcb   C$LF
         fcb   $00
L0F79    fcc   "%08lx  %02x %02x"
         fcb   C$LF
         fcb   $00
L0F8B    fcb   C$LF
         fcc   "   None ..."
         fcb   C$LF
         fcb   $00
L0F99    fcb   C$LF
         fcc   "Bytes compared:   %08lx"
         fcb   C$LF
         fcb   $00
L0FB3    fcc   "Bytes different:  %08lx"
         fcb   C$LF
         fcb   $00
L0FCC    fcb   C$LF
         fcc   "%s is longer"
         fcb   C$LF
         fcb   $00
L0FDB    fcb   C$LF
         fcc   "%s is longer"
         fcb   C$LF
         fcb   $00
L0FEA    fcb   $10
         ldx   $02,s
         ldx   ,y
         cmpx  $04,y
         bcs   L100C
         lda   $09,y
         ldx   $02,y
L0FF7    ldy   $0A,y
         os9   I$Read   
         bcs   L1012
         tfr   y,d
         ldy   $02,s
         std   $0C,y
         addd  $02,y
         std   $04,y
         ldx   $02,y
L100C    ldb   ,x+
         clra  
         stx   ,y
         rts   
L1012    ldd   #$FFFF
         rts   

         emod
eom      equ   *
         end
