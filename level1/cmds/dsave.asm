********************************************************************
* dsave - Generate procedure file to copy files
*
* $Id$
*
* Ed.    Comments                                       Who YY/MM/DD
* ------------------------------------------------------------------
*  2     Original Microware distribution version

         nam   dsave
         ttl   Generate procedure file to copy files

* Disassembled 02/04/03 23:14:53 by Disasm v1.6 (C) 1988 by RML

         ifp1
         use   os9defs
         endc
start    set   $0E0B
tylg     set   Prgrm+Objct   
atrv     set   ReEnt+rev
rev      set   $01
         mod   eom,name,tylg,atrv,start,size
u0000    rmb   2897
size     equ   .
         fcb   $34 4
         fcb   $06 
         fcb   $32 2
         fcb   $7A z
         fcb   $5F _
         fcb   $4F O
         fcb   $ED m
         fcb   $2C ,
         fcb   $ED m
         fcb   $2A *
         fcb   $ED m
         fcb   $28 (
         fcb   $ED m
         fcb   $26 &
         fcb   $ED m
         fcb   $24 $
         fcb   $ED m
         fcb   $22 "
         fcb   $ED m
         fcb   $A4 $
         fcb   $6F o
         fcb   $A8 (
         fcb   $29 )
         fcb   $6F o
         fcb   $A8 (
         fcb   $51 Q
         fcb   $6F o
         fcb   $A9 )
         fcb   $01 
         fcb   $09 
         fcb   $C6 F
         fcb   $20 
         fcb   $E7 g
         fcb   $A8 (
         fcb   $24 $
         fcb   $30 0
         fcb   $A8 (
         fcb   $24 $
         fcb   $1F 
         fcb   $10 
         fcb   $C3 C
         fcb   $00 
         fcb   $01 
         fcb   $1F 
         fcb   $01 
         fcb   $6F o
         fcb   $84 
         fcb   $30 0
         fcb   $A8 (
         fcb   $24 $
         fcb   $1F 
         fcb   $10 
         fcb   $C3 C
         fcb   $00 
         fcb   $02 
         fcb   $1F 
         fcb   $01 
         fcb   $6F o
         fcb   $84 
         fcb   $30 0
         fcb   $8D 
         fcb   $0A 
         fcb   $64 d
         fcb   $AF /
         fcb   $A9 )
         fcb   $02 
         fcb   $49 I
         fcb   $EC l
         fcb   $66 f
         fcb   $83 
         fcb   $00 
         fcb   $01 
         fcb   $ED m
         fcb   $66 f
         fcb   $10 
         fcb   $83 
         fcb   $00 
         fcb   $00 
         fcb   $10 
         fcb   $2F /
         fcb   $01 
         fcb   $6A j
         fcb   $EC l
         fcb   $6A j
         fcb   $C3 C
         fcb   $00 
         fcb   $02 
         fcb   $ED m
         fcb   $6A j
         fcb   $1F 
         fcb   $01 
         fcb   $EC l
         fcb   $84 
         fcb   $ED m
         fcb   $E4 d
         fcb   $1F 
         fcb   $01 
         fcb   $E6 f
         fcb   $84 
         fcb   $C1 A
         fcb   $2D -
         fcb   $10 
         fcb   $26 &
         fcb   $01 
         fcb   $53 S
         fcb   $EC l
         fcb   $E4 d
         fcb   $C3 C
         fcb   $00 
         fcb   $01 
         fcb   $ED m
         fcb   $62 b
         fcb   $E6 f
         fcb   $F8 x
         fcb   $02 
         fcb   $27 '
         fcb   $CE N
         fcb   $E6 f
         fcb   $F8 x
         fcb   $02 
         fcb   $CA J
         fcb   $20 
         fcb   $E7 g
         fcb   $F8 x
         fcb   $02 
         fcb   $E6 f
         fcb   $F8 x
         fcb   $02 
         fcb   $C1 A
         fcb   $69 i
         fcb   $27 '
         fcb   $1B 
         fcb   $C1 A
         fcb   $76 v
         fcb   $27 '
         fcb   $24 $
         fcb   $C1 A
         fcb   $6D m
         fcb   $27 '
         fcb   $28 (
         fcb   $C1 A
         fcb   $73 s
         fcb   $27 '
         fcb   $2C ,
         fcb   $C1 A
         fcb   $6C l
         fcb   $10 
         fcb   $27 '
         fcb   $00 
         fcb   $A8 (
         fcb   $C1 A
         fcb   $62 b
         fcb   $10 
         fcb   $27 '
         fcb   $00 
         fcb   $AA *
         fcb   $16 
         fcb   $00 
         fcb   $FA z
         fcb   $CC L
         fcb   $00 
         fcb   $01 
         fcb   $ED m
         fcb   $22 "
         fcb   $5F _
         fcb   $4F O
         fcb   $ED m
         fcb   $A8 (
         fcb   $10 
         fcb   $16 
         fcb   $01 
         fcb   $03 
         fcb   $CC L
         fcb   $00 
         fcb   $01 
         fcb   $ED m
         fcb   $2C ,
         fcb   $16 
         fcb   $00 
         fcb   $FB 
         fcb   $CC L
         fcb   $00 
         fcb   $01 
         fcb   $ED m
         fcb   $26 &
         fcb   $16 
         fcb   $00 
         fcb   $F3 s
         fcb   $CC L
         fcb   $00 
         fcb   $01 
         fcb   $ED m
         fcb   $28 (
         fcb   $5F _
         fcb   $4F O
         fcb   $ED m
         fcb   $64 d
         fcb   $EC l
         fcb   $64 d
         fcb   $C3 C
         fcb   $00 
         fcb   $01 
         fcb   $ED m
         fcb   $64 d
         fcb   $83 
         fcb   $00 
         fcb   $01 
         fcb   $30 0
         fcb   $A8 (
         fcb   $24 $
         fcb   $34 4
         fcb   $10 
         fcb   $E3 c
         fcb   $E1 a
         fcb   $34 4
         fcb   $06 
         fcb   $C6 F
         fcb   $23 #
         fcb   $E7 g
         fcb   $F1 q
         fcb   $AE .
         fcb   $62 b
         fcb   $E6 f
         fcb   $01 
         fcb   $C1 A
         fcb   $30 0
         fcb   $25 %
         fcb   $35 5
         fcb   $AE .
         fcb   $62 b
         fcb   $E6 f
         fcb   $01 
         fcb   $C1 A
         fcb   $39 9
         fcb   $22 "
         fcb   $2D -
         fcb   $EC l
         fcb   $64 d
         fcb   $10 
         fcb   $83 
         fcb   $00 
         fcb   $03 
         fcb   $2C ,
         fcb   $25 %
         fcb   $EC l
         fcb   $64 d
         fcb   $C3 C
         fcb   $00 
         fcb   $01 
         fcb   $ED m
         fcb   $64 d
         fcb   $83 
         fcb   $00 
         fcb   $01 
         fcb   $30 0
         fcb   $A8 (
         fcb   $24 $
         fcb   $34 4
         fcb   $10 
         fcb   $E3 c
         fcb   $E1 a
         fcb   $34 4
         fcb   $06 
         fcb   $EC l
         fcb   $64 d
         fcb   $C3 C
         fcb   $00 
         fcb   $01 
         fcb   $ED m
         fcb   $64 d
         fcb   $83 
         fcb   $00 
         fcb   $01 
         fcb   $1F 
         fcb   $01 
         fcb   $E6 f
         fcb   $01 
         fcb   $E7 g
         fcb   $F1 q
         fcb   $20 
         fcb   $C3 C
         fcb   $EC l
         fcb   $64 d
         fcb   $C3 C
         fcb   $00 
         fcb   $01 
         fcb   $ED m
         fcb   $64 d
         fcb   $83 
         fcb   $00 
         fcb   $01 
         fcb   $30 0
         fcb   $A8 (
         fcb   $24 $
         fcb   $34 4
         fcb   $10 
         fcb   $E3 c
         fcb   $E1 a
         fcb   $34 4
         fcb   $06 
         fcb   $C6 F
         fcb   $4B K
         fcb   $E7 g
         fcb   $F1 q
         fcb   $30 0
         fcb   $A8 (
         fcb   $24 $
         fcb   $1F 
         fcb   $10 
         fcb   $E3 c
         fcb   $64 d
         fcb   $1F 
         fcb   $01 
         fcb   $6F o
         fcb   $84 
         fcb   $16 
         fcb   $00 
         fcb   $71 q
         fcb   $CC L
         fcb   $00 
         fcb   $01 
         fcb   $ED m
         fcb   $24 $
         fcb   $16 
         fcb   $00 
         fcb   $69 i
         fcb   $AE .
         fcb   $62 b
         fcb   $E6 f
         fcb   $01 
         fcb   $C1 A
         fcb   $3D =
         fcb   $10 
         fcb   $26 &
         fcb   $00 
         fcb   $42 B
         fcb   $5F _
         fcb   $4F O
         fcb   $ED m
         fcb   $64 d
         fcb   $EC l
         fcb   $62 b
         fcb   $C3 C
         fcb   $00 
         fcb   $01 
         fcb   $ED m
         fcb   $62 b
         fcb   $1F 
         fcb   $01 
         fcb   $E6 f
         fcb   $01 
         fcb   $C1 A
         fcb   $00 
         fcb   $27 '
         fcb   $1C 
         fcb   $EC l
         fcb   $64 d
         fcb   $C3 C
         fcb   $00 
         fcb   $01 
         fcb   $ED m
         fcb   $64 d
         fcb   $83 
         fcb   $00 
         fcb   $01 
         fcb   $30 0
         fcb   $A9 )
         fcb   $00 
         fcb   $B9 9
         fcb   $34 4
         fcb   $10 
         fcb   $E3 c
         fcb   $E1 a
         fcb   $34 4
         fcb   $06 
         fcb   $AE .
         fcb   $64 d
         fcb   $E6 f
         fcb   $01 
         fcb   $E7 g
         fcb   $F1 q
         fcb   $20 
         fcb   $D5 U
         fcb   $30 0
         fcb   $A9 )
         fcb   $00 
         fcb   $B9 9
         fcb   $1F 
         fcb   $10 
         fcb   $E3 c
         fcb   $64 d
         fcb   $1F 
         fcb   $01 
         fcb   $6F o
         fcb   $84 
         fcb   $CC L
         fcb   $00 
         fcb   $02 
         fcb   $ED m
         fcb   $A4 $
         fcb   $20 
         fcb   $1D 
         fcb   $CC L
         fcb   $00 
         fcb   $01 
         fcb   $ED m
         fcb   $A4 $
         fcb   $20 
         fcb   $16 
         fcb   $E6 f
         fcb   $F8 x
         fcb   $02 
         fcb   $4F O
         fcb   $34 4
         fcb   $06 
         fcb   $30 0
         fcb   $8D 
         fcb   $09 
         fcb   $28 (
         fcb   $34 4
         fcb   $10 
         fcb   $DC \
         fcb   $0E 
         fcb   $17 
         fcb   $0C 
         fcb   $39 9
         fcb   $32 2
         fcb   $64 d
         fcb   $17 
         fcb   $08 
         fcb   $93 
         fcb   $EC l
         fcb   $62 b
         fcb   $C3 C
         fcb   $00 
         fcb   $01 
         fcb   $ED m
         fcb   $62 b
         fcb   $83 
         fcb   $00 
         fcb   $01 
         fcb   $16 
         fcb   $FE 
         fcb   $B4 4
         fcb   $EC l
         fcb   $66 f
         fcb   $83 
         fcb   $00 
         fcb   $01 
         fcb   $ED m
         fcb   $66 f
         fcb   $C3 C
         fcb   $00 
         fcb   $01 
         fcb   $10 
         fcb   $83 
         fcb   $00 
         fcb   $00 
         fcb   $10 
         fcb   $2F /
         fcb   $00 
         fcb   $2E .
         fcb   $EC l
         fcb   $F8 x
         fcb   $0A 
         fcb   $ED m
         fcb   $E4 d
         fcb   $1F 
         fcb   $01 
         fcb   $E6 f
         fcb   $84 
         fcb   $C1 A
         fcb   $2F /
         fcb   $27 '
         fcb   $10 
         fcb   $30 0
         fcb   $8D 
         fcb   $09 
         fcb   $08 
         fcb   $34 4
         fcb   $10 
         fcb   $30 0
         fcb   $A8 (
         fcb   $29 )
         fcb   $1F 
         fcb   $10 
         fcb   $17 
         fcb   $07 
         fcb   $56 V
         fcb   $32 2
         fcb   $62 b
         fcb   $EC l
         fcb   $F8 x
         fcb   $0A 
         fcb   $34 4
         fcb   $06 
         fcb   $30 0
         fcb   $A8 (
         fcb   $29 )
         fcb   $1F 
         fcb   $10 
         fcb   $17 
         fcb   $07 
         fcb   $47 G
         fcb   $32 2
         fcb   $62 b
         fcb   $20 
         fcb   $10 
         fcb   $30 0
         fcb   $8D 
         fcb   $08 
         fcb   $E9 i
         fcb   $34 4
         fcb   $10 
         fcb   $30 0
         fcb   $A8 (
         fcb   $29 )
         fcb   $1F 
         fcb   $10 
         fcb   $17 
         fcb   $07 
         fcb   $35 5
         fcb   $32 2
         fcb   $62 b
         fcb   $EC l
         fcb   $66 f
         fcb   $83 
         fcb   $00 
         fcb   $01 
         fcb   $ED m
         fcb   $66 f
         fcb   $C3 C
         fcb   $00 
         fcb   $01 
         fcb   $10 
         fcb   $83 
         fcb   $00 
         fcb   $00 
         fcb   $10 
         fcb   $2F /
         fcb   $00 
         fcb   $35 5
         fcb   $CC L
         fcb   $00 
         fcb   $01 
         fcb   $ED m
         fcb   $2A *
         fcb   $AE .
         fcb   $6A j
         fcb   $EC l
         fcb   $02 
         fcb   $ED m
         fcb   $E4 d
         fcb   $1F 
         fcb   $01 
         fcb   $E6 f
         fcb   $84 
         fcb   $C1 A
         fcb   $2F /
         fcb   $27 '
         fcb   $10 
         fcb   $30 0
         fcb   $8D 
         fcb   $08 
         fcb   $B8 8
         fcb   $34 4
         fcb   $10 
         fcb   $30 0
         fcb   $A8 (
         fcb   $51 Q
         fcb   $1F 
         fcb   $10 
         fcb   $17 
         fcb   $07 
         fcb   $00 
         fcb   $32 2
         fcb   $62 b
         fcb   $AE .
         fcb   $6A j
         fcb   $EC l
         fcb   $02 
         fcb   $34 4
         fcb   $06 
         fcb   $30 0
         fcb   $A8 (
         fcb   $51 Q
         fcb   $1F 
         fcb   $10 
         fcb   $17 
         fcb   $06 
         fcb   $F0 p
         fcb   $32 2
         fcb   $62 b
         fcb   $20 
         fcb   $10 
         fcb   $30 0
         fcb   $8D 
         fcb   $08 
         fcb   $98 
         fcb   $34 4
         fcb   $10 
         fcb   $30 0
         fcb   $A8 (
         fcb   $51 Q
         fcb   $1F 
         fcb   $10 
         fcb   $17 
         fcb   $06 
         fcb   $DE ^
         fcb   $32 2
         fcb   $62 b
         fcb   $EC l
         fcb   $66 f
         fcb   $10 
         fcb   $83 
         fcb   $00 
         fcb   $00 
         fcb   $2F /
         fcb   $10 
         fcb   $30 0
         fcb   $8D 
         fcb   $08 
         fcb   $84 
         fcb   $34 4
         fcb   $10 
         fcb   $DC \
         fcb   $0E 
         fcb   $17 
         fcb   $0B 
         fcb   $6D m
         fcb   $32 2
         fcb   $62 b
         fcb   $17 
         fcb   $07 
         fcb   $C7 G
         fcb   $6F o
         fcb   $A9 )
         fcb   $01 
         fcb   $4F O
         fcb   $CC L
         fcb   $00 
         fcb   $F9 y
         fcb   $ED m
         fcb   $A8 (
         fcb   $12 
         fcb   $EC l
         fcb   $A8 (
         fcb   $12 
         fcb   $83 
         fcb   $00 
         fcb   $01 
         fcb   $ED m
         fcb   $A8 (
         fcb   $12 
         fcb   $C3 C
         fcb   $00 
         fcb   $01 
         fcb   $30 0
         fcb   $A9 )
         fcb   $01 
         fcb   $4F O
         fcb   $34 4
         fcb   $10 
         fcb   $E3 c
         fcb   $E1 a
         fcb   $1F 
         fcb   $01 
         fcb   $6F o
         fcb   $84 
         fcb   $30 0
         fcb   $8D 
         fcb   $08 
         fcb   $71 q
         fcb   $1F 
         fcb   $10 
         fcb   $17 
         fcb   $0B 
         fcb   $40 @
         fcb   $EC l
         fcb   $2A *
         fcb   $27 '
         fcb   $10 
         fcb   $30 0
         fcb   $A8 (
         fcb   $51 Q
         fcb   $34 4
         fcb   $10 
         fcb   $30 0
         fcb   $8D 
         fcb   $08 
         fcb   $62 b
         fcb   $1F 
         fcb   $10 
         fcb   $17 
         fcb   $0B 
         fcb   $2E .
         fcb   $32 2
         fcb   $62 b
         fcb   $30 0
         fcb   $8D 
         fcb   $08 
         fcb   $5F _
         fcb   $1F 
         fcb   $10 
         fcb   $17 
         fcb   $0B 
         fcb   $23 #
         fcb   $30 0
         fcb   $8D 
         fcb   $08 
         fcb   $67 g
         fcb   $1F 
         fcb   $10 
         fcb   $17 
         fcb   $0B 
         fcb   $1A 
         fcb   $EC l
         fcb   $2C ,
         fcb   $27 '
         fcb   $09 
         fcb   $30 0
         fcb   $8D 
         fcb   $08 
         fcb   $65 e
         fcb   $1F 
         fcb   $10 
         fcb   $17 
         fcb   $0B 
         fcb   $0D 
         fcb   $17 
         fcb   $05 
         fcb   $A2 "
         fcb   $10 
         fcb   $83 
         fcb   $00 
         fcb   $00 
         fcb   $10 
         fcb   $26 &
         fcb   $01 
         fcb   $48 H
         fcb   $EC l
         fcb   $A8 (
         fcb   $16 
         fcb   $17 
         fcb   $0A 
         fcb   $FF 
         fcb   $30 0
         fcb   $A8 (
         fcb   $79 y
         fcb   $E6 f
         fcb   $88 
         fcb   $1D 
         fcb   $4F O
         fcb   $ED m
         fcb   $A8 (
         fcb   $1A 
         fcb   $30 0
         fcb   $A8 (
         fcb   $79 y
         fcb   $E6 f
         fcb   $88 
         fcb   $1E 
         fcb   $4F O
         fcb   $ED m
         fcb   $A8 (
         fcb   $1C 
         fcb   $30 0
         fcb   $A8 (
         fcb   $79 y
         fcb   $E6 f
         fcb   $88 
         fcb   $1F 
         fcb   $4F O
         fcb   $ED m
         fcb   $A8 (
         fcb   $1E 
         fcb   $30 0
         fcb   $8D 
         fcb   $08 
         fcb   $3A :
         fcb   $34 4
         fcb   $10 
         fcb   $30 0
         fcb   $8D 
         fcb   $08 
         fcb   $31 1
         fcb   $1F 
         fcb   $10 
         fcb   $17 
         fcb   $07 
         fcb   $05 
         fcb   $32 2
         fcb   $62 b
         fcb   $CC L
         fcb   $00 
         fcb   $01 
         fcb   $ED m
         fcb   $A8 (
         fcb   $18 
         fcb   $EC l
         fcb   $A8 (
         fcb   $18 
         fcb   $10 
         fcb   $27 '
         fcb   $00 
         fcb   $AE .
         fcb   $17 
         fcb   $05 
         fcb   $55 U
         fcb   $C3 C
         fcb   $00 
         fcb   $00 
         fcb   $27 '
         fcb   $05 
         fcb   $5F _
         fcb   $4F O
         fcb   $ED m
         fcb   $A8 (
         fcb   $18 
         fcb   $EC l
         fcb   $A8 (
         fcb   $16 
         fcb   $17 
         fcb   $03 
         fcb   $BE >
         fcb   $10 
         fcb   $83 
         fcb   $00 
         fcb   $00 
         fcb   $2C ,
         fcb   $12 
         fcb   $30 0
         fcb   $8D 
         fcb   $08 
         fcb   $05 
         fcb   $34 4
         fcb   $10 
         fcb   $DC \
         fcb   $0E 
         fcb   $17 
         fcb   $0A 
         fcb   $99 
         fcb   $32 2
         fcb   $62 b
         fcb   $DC \
         fcb   $02 
         fcb   $17 
         fcb   $0A 
         fcb   $9B 
         fcb   $30 0
         fcb   $A9 )
         fcb   $00 
         fcb   $99 
         fcb   $E6 f
         fcb   $88 
         fcb   $1F 
         fcb   $4F O
         fcb   $10 
         fcb   $A3 #
         fcb   $A8 (
         fcb   $1E 
         fcb   $10 
         fcb   $26 &
         fcb   $FF 
         fcb   $D2 R
         fcb   $30 0
         fcb   $A9 )
         fcb   $00 
         fcb   $99 
         fcb   $E6 f
         fcb   $88 
         fcb   $1E 
         fcb   $4F O
         fcb   $10 
         fcb   $A3 #
         fcb   $A8 (
         fcb   $1C 
         fcb   $10 
         fcb   $26 &
         fcb   $FF 
         fcb   $C2 B
         fcb   $30 0
         fcb   $A9 )
         fcb   $00 
         fcb   $99 
         fcb   $E6 f
         fcb   $88 
         fcb   $1D 
         fcb   $4F O
         fcb   $10 
         fcb   $A3 #
         fcb   $A8 (
         fcb   $1A 
         fcb   $10 
         fcb   $26 &
         fcb   $FF 
         fcb   $B2 2
         fcb   $30 0
         fcb   $A9 )
         fcb   $00 
         fcb   $99 
         fcb   $1F 
         fcb   $10 
         fcb   $17 
         fcb   $04 
         fcb   $A1 !
         fcb   $30 0
         fcb   $A9 )
         fcb   $00 
         fcb   $99 
         fcb   $1F 
         fcb   $10 
         fcb   $17 
         fcb   $06 
         fcb   $19 
         fcb   $30 0
         fcb   $8D 
         fcb   $07 
         fcb   $CF O
         fcb   $1F 
         fcb   $10 
         fcb   $17 
         fcb   $06 
         fcb   $10 
         fcb   $30 0
         fcb   $A8 (
         fcb   $79 y
         fcb   $E6 f
         fcb   $88 
         fcb   $1D 
         fcb   $4F O
         fcb   $ED m
         fcb   $A8 (
         fcb   $1A 
         fcb   $30 0
         fcb   $A8 (
         fcb   $79 y
         fcb   $E6 f
         fcb   $88 
         fcb   $1E 
         fcb   $4F O
         fcb   $ED m
         fcb   $A8 (
         fcb   $1C 
         fcb   $30 0
         fcb   $A8 (
         fcb   $79 y
         fcb   $E6 f
         fcb   $88 
         fcb   $1F 
         fcb   $4F O
         fcb   $ED m
         fcb   $A8 (
         fcb   $1E 
         fcb   $EC l
         fcb   $A8 (
         fcb   $16 
         fcb   $17 
         fcb   $0A 
         fcb   $29 )
         fcb   $30 0
         fcb   $8D 
         fcb   $07 
         fcb   $A7 '
         fcb   $34 4
         fcb   $10 
         fcb   $30 0
         fcb   $8D 
         fcb   $07 
         fcb   $9E 
         fcb   $1F 
         fcb   $10 
         fcb   $17 
         fcb   $06 
         fcb   $4D M
         fcb   $32 2
         fcb   $62 b
         fcb   $16 
         fcb   $FF 
         fcb   $4B K
         fcb   $30 0
         fcb   $A8 (
         fcb   $29 )
         fcb   $1F 
         fcb   $10 
         fcb   $17 
         fcb   $05 
         fcb   $D0 P
         fcb   $EC l
         fcb   $A8 (
         fcb   $12 
         fcb   $C3 C
         fcb   $00 
         fcb   $01 
         fcb   $ED m
         fcb   $A8 (
         fcb   $12 
         fcb   $30 0
         fcb   $A9 )
         fcb   $01 
         fcb   $4F O
         fcb   $34 4
         fcb   $10 
         fcb   $E3 c
         fcb   $E1 a
         fcb   $34 4
         fcb   $06 
         fcb   $30 0
         fcb   $A9 )
         fcb   $01 
         fcb   $4F O
         fcb   $1F 
         fcb   $10 
         fcb   $17 
         fcb   $05 
         fcb   $47 G
         fcb   $32 2
         fcb   $62 b
         fcb   $CC L
         fcb   $00 
         fcb   $01 
         fcb   $ED m
         fcb   $A8 (
         fcb   $12 
         fcb   $EC l
         fcb   $A8 (
         fcb   $12 
         fcb   $C3 C
         fcb   $00 
         fcb   $01 
         fcb   $ED m
         fcb   $A8 (
         fcb   $12 
         fcb   $83 
         fcb   $00 
         fcb   $01 
         fcb   $30 0
         fcb   $A9 )
         fcb   $01 
         fcb   $4F O
         fcb   $E6 f
         fcb   $8B 
         fcb   $C1 A
         fcb   $2F /
         fcb   $26 &
         fcb   $EA j
         fcb   $30 0
         fcb   $8D 
         fcb   $07 
         fcb   $53 S
         fcb   $34 4
         fcb   $10 
         fcb   $30 0
         fcb   $A9 )
         fcb   $01 
         fcb   $4F O
         fcb   $1F 
         fcb   $10 
         fcb   $E3 c
         fcb   $A8 (
         fcb   $12 
         fcb   $17 
         fcb   $05 
         fcb   $F4 t
         fcb   $32 2
         fcb   $62 b
         fcb   $20 
         fcb   $10 
         fcb   $30 0
         fcb   $A8 (
         fcb   $29 )
         fcb   $34 4
         fcb   $10 
         fcb   $30 0
         fcb   $A9 )
         fcb   $01 
         fcb   $4F O
         fcb   $1F 
         fcb   $10 
         fcb   $17 
         fcb   $05 
         fcb   $05 
         fcb   $32 2
         fcb   $62 b
         fcb   $EC l
         fcb   $A8 (
         fcb   $16 
         fcb   $17 
         fcb   $09 
         fcb   $A7 '
         fcb   $5F _
         fcb   $4F O
         fcb   $ED m
         fcb   $2E .
         fcb   $17 
         fcb   $00 
         fcb   $27 '
         fcb   $EC l
         fcb   $2C ,
         fcb   $27 '
         fcb   $09 
         fcb   $30 0
         fcb   $8D 
         fcb   $07 
         fcb   $1E 
         fcb   $1F 
         fcb   $10 
         fcb   $17 
         fcb   $09 
         fcb   $90 
         fcb   $30 0
         fcb   $8D 
         fcb   $07 
         fcb   $21 !
         fcb   $1F 
         fcb   $10 
         fcb   $17 
         fcb   $09 
         fcb   $87 
         fcb   $30 0
         fcb   $8D 
         fcb   $07 
         fcb   $25 %
         fcb   $1F 
         fcb   $10 
         fcb   $17 
         fcb   $09 
         fcb   $7E þ
         fcb   $5F _
         fcb   $4F O
         fcb   $17 
         fcb   $09 
         fcb   $7F ÿ
         fcb   $32 2
         fcb   $68 h
         fcb   $39 9
         fcb   $32 2
         fcb   $E9 i
         fcb   $FF 
         fcb   $02 
         fcb   $EC l
         fcb   $2E .
         fcb   $C3 C
         fcb   $00 
         fcb   $01 
         fcb   $ED m
         fcb   $2E .
         fcb   $83 
         fcb   $00 
         fcb   $01 
         fcb   $EC l
         fcb   $22 "
         fcb   $10 
         fcb   $27 '
         fcb   $00 
         fcb   $5A Z
         fcb   $EC l
         fcb   $A8 (
         fcb   $10 
         fcb   $C3 C
         fcb   $00 
         fcb   $01 
         fcb   $ED m
         fcb   $A8 (
         fcb   $10 
         fcb   $83 
         fcb   $00 
         fcb   $01 
         fcb   $30 0
         fcb   $A9 )
         fcb   $01 
         fcb   $09 
         fcb   $34 4
         fcb   $10 
         fcb   $E3 c
         fcb   $E1 a
         fcb   $34 4
         fcb   $06 
         fcb   $C6 F
         fcb   $20 
         fcb   $E7 g
         fcb   $F1 q
         fcb   $EC l
         fcb   $A8 (
         fcb   $10 
         fcb   $C3 C
         fcb   $00 
         fcb   $01 
         fcb   $ED m
         fcb   $A8 (
         fcb   $10 
         fcb   $83 
         fcb   $00 
         fcb   $01 
         fcb   $30 0
         fcb   $A9 )
         fcb   $01 
         fcb   $09 
         fcb   $34 4
         fcb   $10 
         fcb   $E3 c
         fcb   $E1 a
         fcb   $34 4
         fcb   $06 
         fcb   $C6 F
         fcb   $20 
         fcb   $E7 g
         fcb   $F1 q
         fcb   $30 0
         fcb   $A9 )
         fcb   $01 
         fcb   $09 
         fcb   $1F 
         fcb   $10 
         fcb   $E3 c
         fcb   $A8 (
         fcb   $10 
         fcb   $1F 
         fcb   $01 
         fcb   $6F o
         fcb   $84 
         fcb   $EC l
         fcb   $A8 (
         fcb   $10 
         fcb   $10 
         fcb   $83 
         fcb   $00 
         fcb   $1E 
         fcb   $2F /
         fcb   $10 
         fcb   $30 0
         fcb   $8D 
         fcb   $06 
         fcb   $C6 F
         fcb   $34 4
         fcb   $10 
         fcb   $DC \
         fcb   $0E 
         fcb   $17 
         fcb   $09 
         fcb   $0A 
         fcb   $32 2
         fcb   $62 b
         fcb   $17 
         fcb   $09 
         fcb   $0E 
         fcb   $CC L
         fcb   $00 
         fcb   $81 
         fcb   $34 4
         fcb   $06 
         fcb   $30 0
         fcb   $8D 
         fcb   $06 
         fcb   $D7 W
         fcb   $1F 
         fcb   $10 
         fcb   $17 
         fcb   $09 
         fcb   $03 
         fcb   $32 2
         fcb   $62 b
         fcb   $ED m
         fcb   $A8 (
         fcb   $14 
         fcb   $10 
         fcb   $83 
         fcb   $00 
         fcb   $00 
         fcb   $2E .
         fcb   $12 
         fcb   $30 0
         fcb   $8D 
         fcb   $06 
         fcb   $C5 E
         fcb   $34 4
         fcb   $10 
         fcb   $DC \
         fcb   $0E 
         fcb   $17 
         fcb   $08 
         fcb   $E1 a
         fcb   $32 2
         fcb   $62 b
         fcb   $DC \
         fcb   $02 
         fcb   $17 
         fcb   $08 
         fcb   $E3 c
         fcb   $5F _
         fcb   $4F O
         fcb   $ED m
         fcb   $A8 (
         fcb   $20 
         fcb   $CC L
         fcb   $00 
         fcb   $40 @
         fcb   $ED m
         fcb   $A8 (
         fcb   $22 "
         fcb   $EC l
         fcb   $A8 (
         fcb   $14 
         fcb   $17 
         fcb   $02 
         fcb   $16 
         fcb   $EC l
         fcb   $A8 (
         fcb   $14 
         fcb   $17 
         fcb   $01 
         fcb   $D7 W
         fcb   $10 
         fcb   $83 
         fcb   $00 
         fcb   $00 
         fcb   $10 
         fcb   $2D -
         fcb   $01 
         fcb   $95 
         fcb   $CC L
         fcb   $00 
         fcb   $01 
         fcb   $34 4
         fcb   $06 
         fcb   $30 0
         fcb   $A9 )
         fcb   $00 
         fcb   $99 
         fcb   $1F 
         fcb   $10 
         fcb   $17 
         fcb   $08 
         fcb   $B9 9
         fcb   $32 2
         fcb   $62 b
         fcb   $ED m
         fcb   $A8 (
         fcb   $16 
         fcb   $10 
         fcb   $83 
         fcb   $00 
         fcb   $00 
         fcb   $10 
         fcb   $2E .
         fcb   $01 
         fcb   $68 h
         fcb   $EC l
         fcb   $24 $
         fcb   $26 &
         fcb   $D3 S
         fcb   $CC L
         fcb   $00 
         fcb   $81 
         fcb   $34 4
         fcb   $06 
         fcb   $30 0
         fcb   $A9 )
         fcb   $00 
         fcb   $99 
         fcb   $1F 
         fcb   $10 
         fcb   $17 
         fcb   $08 
         fcb   $9A 
         fcb   $32 2
         fcb   $62 b
         fcb   $ED m
         fcb   $A8 (
         fcb   $16 
         fcb   $10 
         fcb   $83 
         fcb   $00 
         fcb   $00 
         fcb   $10 
         fcb   $2E .
         fcb   $00 
         fcb   $2D -
         fcb   $DC \
         fcb   $02 
         fcb   $34 4
         fcb   $06 
         fcb   $30 0
         fcb   $A9 )
         fcb   $00 
         fcb   $99 
         fcb   $34 4
         fcb   $10 
         fcb   $EC l
         fcb   $A9 )
         fcb   $02 
         fcb   $49 I
         fcb   $17 
         fcb   $08 
         fcb   $73 s
         fcb   $32 2
         fcb   $64 d
         fcb   $DC \
         fcb   $02 
         fcb   $34 4
         fcb   $06 
         fcb   $30 0
         fcb   $A9 )
         fcb   $00 
         fcb   $99 
         fcb   $34 4
         fcb   $10 
         fcb   $EC l
         fcb   $A9 )
         fcb   $02 
         fcb   $49 I
         fcb   $34 4
         fcb   $06 
         fcb   $DC \
         fcb   $0E 
         fcb   $17 
         fcb   $08 
         fcb   $59 Y
         fcb   $32 2
         fcb   $66 f
         fcb   $16 
         fcb   $FF 
         fcb   $8B 
         fcb   $30 0
         fcb   $A9 )
         fcb   $00 
         fcb   $99 
         fcb   $1F 
         fcb   $10 
         fcb   $17 
         fcb   $02 
         fcb   $93 
         fcb   $EC l
         fcb   $26 &
         fcb   $26 &
         fcb   $17 
         fcb   $30 0
         fcb   $A9 )
         fcb   $00 
         fcb   $99 
         fcb   $34 4
         fcb   $10 
         fcb   $30 0
         fcb   $A9 )
         fcb   $01 
         fcb   $09 
         fcb   $34 4
         fcb   $10 
         fcb   $30 0
         fcb   $8D 
         fcb   $06 
         fcb   $32 2
         fcb   $1F 
         fcb   $10 
         fcb   $17 
         fcb   $08 
         fcb   $35 5
         fcb   $32 2
         fcb   $64 d
         fcb   $EC l
         fcb   $A8 (
         fcb   $16 
         fcb   $17 
         fcb   $08 
         fcb   $39 9
         fcb   $30 0
         fcb   $A9 )
         fcb   $00 
         fcb   $99 
         fcb   $1F 
         fcb   $10 
         fcb   $17 
         fcb   $02 
         fcb   $69 i
         fcb   $30 0
         fcb   $A9 )
         fcb   $00 
         fcb   $99 
         fcb   $34 4
         fcb   $10 
         fcb   $30 0
         fcb   $A9 )
         fcb   $01 
         fcb   $09 
         fcb   $34 4
         fcb   $10 
         fcb   $30 0
         fcb   $8D 
         fcb   $06 
         fcb   $19 
         fcb   $1F 
         fcb   $10 
         fcb   $17 
         fcb   $08 
         fcb   $0F 
         fcb   $32 2
         fcb   $64 d
         fcb   $30 0
         fcb   $8D 
         fcb   $06 
         fcb   $18 
         fcb   $34 4
         fcb   $10 
         fcb   $30 0
         fcb   $A9 )
         fcb   $00 
         fcb   $99 
         fcb   $1F 
         fcb   $10 
         fcb   $17 
         fcb   $04 
         fcb   $34 4
         fcb   $32 2
         fcb   $62 b
         fcb   $6F o
         fcb   $E4 d
         fcb   $30 0
         fcb   $A9 )
         fcb   $01 
         fcb   $4F O
         fcb   $34 4
         fcb   $10 
         fcb   $30 0
         fcb   $62 b
         fcb   $1F 
         fcb   $10 
         fcb   $17 
         fcb   $03 
         fcb   $46 F
         fcb   $32 2
         fcb   $62 b
         fcb   $30 0
         fcb   $8D 
         fcb   $05 
         fcb   $F8 x
         fcb   $34 4
         fcb   $10 
         fcb   $30 0
         fcb   $A9 )
         fcb   $01 
         fcb   $4F O
         fcb   $1F 
         fcb   $10 
         fcb   $17 
         fcb   $03 
         fcb   $35 5
         fcb   $32 2
         fcb   $62 b
         fcb   $30 0
         fcb   $A9 )
         fcb   $00 
         fcb   $99 
         fcb   $34 4
         fcb   $10 
         fcb   $30 0
         fcb   $A9 )
         fcb   $01 
         fcb   $4F O
         fcb   $1F 
         fcb   $10 
         fcb   $17 
         fcb   $03 
         fcb   $24 $
         fcb   $32 2
         fcb   $62 b
         fcb   $EC l
         fcb   $A8 (
         fcb   $20 
         fcb   $ED m
         fcb   $E9 i
         fcb   $00 
         fcb   $FA z
         fcb   $EC l
         fcb   $A8 (
         fcb   $22 "
         fcb   $ED m
         fcb   $E9 i
         fcb   $00 
         fcb   $FC 
         fcb   $EC l
         fcb   $A8 (
         fcb   $14 
         fcb   $17 
         fcb   $07 
         fcb   $C1 A
         fcb   $17 
         fcb   $FE 
         fcb   $3C <
         fcb   $30 0
         fcb   $A9 )
         fcb   $01 
         fcb   $09 
         fcb   $34 4
         fcb   $10 
         fcb   $30 0
         fcb   $8D 
         fcb   $05 
         fcb   $BB ;
         fcb   $1F 
         fcb   $10 
         fcb   $17 
         fcb   $07 
         fcb   $A3 #
         fcb   $32 2
         fcb   $62 b
         fcb   $30 0
         fcb   $8D 
         fcb   $05 
         fcb   $BD =
         fcb   $34 4
         fcb   $10 
         fcb   $30 0
         fcb   $8D 
         fcb   $05 
         fcb   $B4 4
         fcb   $1F 
         fcb   $10 
         fcb   $17 
         fcb   $03 
         fcb   $C8 H
         fcb   $32 2
         fcb   $62 b
         fcb   $CC L
         fcb   $00 
         fcb   $81 
         fcb   $34 4
         fcb   $06 
         fcb   $30 0
         fcb   $8D 
         fcb   $05 
         fcb   $A9 )
         fcb   $1F 
         fcb   $10 
         fcb   $17 
         fcb   $07 
         fcb   $8B 
         fcb   $32 2
         fcb   $62 b
         fcb   $ED m
         fcb   $A8 (
         fcb   $14 
         fcb   $10 
         fcb   $83 
         fcb   $00 
         fcb   $00 
         fcb   $2E .
         fcb   $12 
         fcb   $30 0
         fcb   $8D 
         fcb   $05 
         fcb   $97 
         fcb   $34 4
         fcb   $10 
         fcb   $DC \
         fcb   $0E 
         fcb   $17 
         fcb   $07 
         fcb   $69 i
         fcb   $32 2
         fcb   $62 b
         fcb   $DC \
         fcb   $02 
         fcb   $17 
         fcb   $07 
         fcb   $6B k
         fcb   $EC l
         fcb   $E9 i
         fcb   $00 
         fcb   $FA z
         fcb   $ED m
         fcb   $A8 (
         fcb   $20 
         fcb   $EC l
         fcb   $E9 i
         fcb   $00 
         fcb   $FC 
         fcb   $ED m
         fcb   $A8 (
         fcb   $22 "
         fcb   $EC l
         fcb   $A8 (
         fcb   $14 
         fcb   $17 
         fcb   $00 
         fcb   $9B 
         fcb   $6F o
         fcb   $A9 )
         fcb   $01 
         fcb   $4F O
         fcb   $30 0
         fcb   $E4 d
         fcb   $34 4
         fcb   $10 
         fcb   $30 0
         fcb   $A9 )
         fcb   $01 
         fcb   $4F O
         fcb   $1F 
         fcb   $10 
         fcb   $17 
         fcb   $02 
         fcb   $99 
         fcb   $32 2
         fcb   $62 b
         fcb   $16 
         fcb   $FE 
         fcb   $6F o
         fcb   $EC l
         fcb   $A8 (
         fcb   $16 
         fcb   $17 
         fcb   $07 
         fcb   $41 A
         fcb   $30 0
         fcb   $A9 )
         fcb   $00 
         fcb   $99 
         fcb   $1F 
         fcb   $10 
         fcb   $17 
         fcb   $00 
         fcb   $A8 (
         fcb   $16 
         fcb   $FE 
         fcb   $5D ]
         fcb   $EC l
         fcb   $A8 (
         fcb   $14 
         fcb   $17 
         fcb   $07 
         fcb   $2F /
         fcb   $EC l
         fcb   $22 "
         fcb   $27 '
         fcb   $21 !
         fcb   $EC l
         fcb   $A8 (
         fcb   $10 
         fcb   $83 
         fcb   $00 
         fcb   $01 
         fcb   $ED m
         fcb   $A8 (
         fcb   $10 
         fcb   $C3 C
         fcb   $00 
         fcb   $01 
         fcb   $EC l
         fcb   $A8 (
         fcb   $10 
         fcb   $83 
         fcb   $00 
         fcb   $01 
         fcb   $ED m
         fcb   $A8 (
         fcb   $10 
         fcb   $30 0
         fcb   $A9 )
         fcb   $01 
         fcb   $09 
         fcb   $34 4
         fcb   $10 
         fcb   $E3 c
         fcb   $E1 a
         fcb   $1F 
         fcb   $01 
         fcb   $6F o
         fcb   $84 
         fcb   $EC l
         fcb   $2E .
         fcb   $83 
         fcb   $00 
         fcb   $01 
         fcb   $ED m
         fcb   $2E .
         fcb   $C3 C
         fcb   $00 
         fcb   $01 
         fcb   $32 2
         fcb   $E9 i
         fcb   $00 
         fcb   $FE 
         fcb   $39 9
         fcb   $34 4
         fcb   $06 
         fcb   $6F o
         fcb   $A9 )
         fcb   $00 
         fcb   $99 
         fcb   $E6 f
         fcb   $A9 )
         fcb   $00 
         fcb   $99 
         fcb   $26 &
         fcb   $27 '
         fcb   $EC l
         fcb   $A8 (
         fcb   $22 "
         fcb   $C3 C
         fcb   $00 
         fcb   $20 
         fcb   $ED m
         fcb   $A8 (
         fcb   $22 "
         fcb   $CC L
         fcb   $00 
         fcb   $20 
         fcb   $34 4
         fcb   $06 
         fcb   $30 0
         fcb   $A9 )
         fcb   $00 
         fcb   $99 
         fcb   $34 4
         fcb   $10 
         fcb   $EC l
         fcb   $64 d
         fcb   $17 
         fcb   $06 
         fcb   $D9 Y
         fcb   $32 2
         fcb   $64 d
         fcb   $10 
         fcb   $83 
         fcb   $00 
         fcb   $20 
         fcb   $27 '
         fcb   $D9 Y
         fcb   $CC L
         fcb   $FF 
         fcb   $FF 
         fcb   $32 2
         fcb   $62 b
         fcb   $39 9
         fcb   $CC L
         fcb   $00 
         fcb   $01 
         fcb   $32 2
         fcb   $62 b
         fcb   $39 9
         fcb   $34 4
         fcb   $06 
         fcb   $5F _
         fcb   $4F O
         fcb   $34 4
         fcb   $06 
         fcb   $EC l
         fcb   $A8 (
         fcb   $22 "
         fcb   $34 4
         fcb   $06 
         fcb   $EC l
         fcb   $A8 (
         fcb   $20 
         fcb   $34 4
         fcb   $06 
         fcb   $EC l
         fcb   $66 f
         fcb   $17 
         fcb   $06 
         fcb   $B3 3
         fcb   $32 2
         fcb   $66 f
         fcb   $10 
         fcb   $83 
         fcb   $00 
         fcb   $00 
         fcb   $2C ,
         fcb   $12 
         fcb   $30 0
         fcb   $8D 
         fcb   $04 
         fcb   $D7 W
         fcb   $34 4
         fcb   $10 
         fcb   $DC \
         fcb   $0E 
         fcb   $17 
         fcb   $06 
         fcb   $8B 
         fcb   $32 2
         fcb   $62 b
         fcb   $DC \
         fcb   $02 
         fcb   $17 
         fcb   $06 
         fcb   $8D 
         fcb   $32 2
         fcb   $62 b
         fcb   $39 9
         fcb   $34 4
         fcb   $06 
         fcb   $EC l
         fcb   $E4 d
         fcb   $17 
         fcb   $00 
         fcb   $C2 B
         fcb   $EC l
         fcb   $2E .
         fcb   $10 
         fcb   $83 
         fcb   $00 
         fcb   $01 
         fcb   $10 
         fcb   $26 &
         fcb   $00 
         fcb   $6E n
         fcb   $30 0
         fcb   $8D 
         fcb   $04 
         fcb   $C4 D
         fcb   $34 4
         fcb   $10 
         fcb   $EC l
         fcb   $62 b
         fcb   $17 
         fcb   $01 
         fcb   $7E þ
         fcb   $32 2
         fcb   $62 b
         fcb   $10 
         fcb   $83 
         fcb   $00 
         fcb   $00 
         fcb   $10 
         fcb   $26 &
         fcb   $00 
         fcb   $59 Y
         fcb   $EC l
         fcb   $A4 $
         fcb   $10 
         fcb   $83 
         fcb   $00 
         fcb   $01 
         fcb   $26 &
         fcb   $22 "
         fcb   $30 0
         fcb   $A9 )
         fcb   $01 
         fcb   $4F O
         fcb   $34 4
         fcb   $10 
         fcb   $30 0
         fcb   $A9 )
         fcb   $01 
         fcb   $09 
         fcb   $34 4
         fcb   $10 
         fcb   $30 0
         fcb   $A8 (
         fcb   $51 Q
         fcb   $34 4
         fcb   $10 
         fcb   $30 0
         fcb   $A9 )
         fcb   $01 
         fcb   $09 
         fcb   $34 4
         fcb   $10 
         fcb   $30 0
         fcb   $8D 
         fcb   $04 
         fcb   $98 
         fcb   $1F 
         fcb   $10 
         fcb   $17 
         fcb   $06 
         fcb   $36 6
         fcb   $32 2
         fcb   $68 h
         fcb   $EC l
         fcb   $A4 $
         fcb   $10 
         fcb   $83 
         fcb   $00 
         fcb   $02 
         fcb   $26 &
         fcb   $22 "
         fcb   $30 0
         fcb   $A9 )
         fcb   $00 
         fcb   $B9 9
         fcb   $34 4
         fcb   $10 
         fcb   $30 0
         fcb   $A9 )
         fcb   $01 
         fcb   $09 
         fcb   $34 4
         fcb   $10 
         fcb   $30 0
         fcb   $A8 (
         fcb   $51 Q
         fcb   $34 4
         fcb   $10 
         fcb   $30 0
         fcb   $A9 )
         fcb   $01 
         fcb   $09 
         fcb   $34 4
         fcb   $10 
         fcb   $30 0
         fcb   $8D 
         fcb   $04 
         fcb   $89 
         fcb   $1F 
         fcb   $10 
         fcb   $17 
         fcb   $06 
         fcb   $0C 
         fcb   $32 2
         fcb   $68 h
         fcb   $5F _
         fcb   $4F O
         fcb   $32 2
         fcb   $62 b
         fcb   $39 9
         fcb   $EC l
         fcb   $E4 d
         fcb   $34 4
         fcb   $06 
         fcb   $EC l
         fcb   $62 b
         fcb   $34 4
         fcb   $06 
         fcb   $30 0
         fcb   $A9 )
         fcb   $01 
         fcb   $4F O
         fcb   $34 4
         fcb   $10 
         fcb   $30 0
         fcb   $A8 (
         fcb   $24 $
         fcb   $34 4
         fcb   $10 
         fcb   $30 0
         fcb   $A9 )
         fcb   $01 
         fcb   $09 
         fcb   $34 4
         fcb   $10 
         fcb   $30 0
         fcb   $8D 
         fcb   $04 
         fcb   $73 s
         fcb   $1F 
         fcb   $10 
         fcb   $17 
         fcb   $05 
         fcb   $E3 c
         fcb   $32 2
         fcb   $6A j
         fcb   $EC l
         fcb   $2C ,
         fcb   $27 '
         fcb   $1F 
         fcb   $EC l
         fcb   $E4 d
         fcb   $34 4
         fcb   $06 
         fcb   $EC l
         fcb   $62 b
         fcb   $34 4
         fcb   $06 
         fcb   $30 0
         fcb   $A9 )
         fcb   $01 
         fcb   $4F O
         fcb   $34 4
         fcb   $10 
         fcb   $30 0
         fcb   $A9 )
         fcb   $01 
         fcb   $09 
         fcb   $34 4
         fcb   $10 
         fcb   $30 0
         fcb   $8D 
         fcb   $04 
         fcb   $64 d
         fcb   $1F 
         fcb   $10 
         fcb   $17 
         fcb   $05 
         fcb   $C0 @
         fcb   $32 2
         fcb   $68 h
         fcb   $32 2
         fcb   $62 b
         fcb   $39 9
         fcb   $34 4
         fcb   $06 
         fcb   $32 2
         fcb   $7C ü
         fcb   $5F _
         fcb   $4F O
         fcb   $ED m
         fcb   $62 b
         fcb   $ED m
         fcb   $E4 d
         fcb   $EC l
         fcb   $64 d
         fcb   $E3 c
         fcb   $E4 d
         fcb   $1F 
         fcb   $01 
         fcb   $E6 f
         fcb   $84 
         fcb   $C4 D
         fcb   $80 
         fcb   $C1 A
         fcb   $00 
         fcb   $26 &
         fcb   $14 
         fcb   $EC l
         fcb   $E4 d
         fcb   $10 
         fcb   $83 
         fcb   $00 
         fcb   $1D 
         fcb   $2E .
         fcb   $0C 
         fcb   $EC l
         fcb   $E4 d
         fcb   $C3 C
         fcb   $00 
         fcb   $01 
         fcb   $ED m
         fcb   $E4 d
         fcb   $83 
         fcb   $00 
         fcb   $01 
         fcb   $20 
         fcb   $DE ^
         fcb   $EC l
         fcb   $64 d
         fcb   $E3 c
         fcb   $E4 d
         fcb   $34 4
         fcb   $06 
         fcb   $EC l
         fcb   $66 f
         fcb   $E3 c
         fcb   $62 b
         fcb   $1F 
         fcb   $01 
         fcb   $E6 f
         fcb   $84 
         fcb   $C4 D
         fcb   $7F ÿ
         fcb   $E7 g
         fcb   $F1 q
         fcb   $EC l
         fcb   $E4 d
         fcb   $C3 C
         fcb   $00 
         fcb   $01 
         fcb   $ED m
         fcb   $E4 d
         fcb   $83 
         fcb   $00 
         fcb   $01 
         fcb   $EC l
         fcb   $64 d
         fcb   $E3 c
         fcb   $E4 d
         fcb   $1F 
         fcb   $01 
         fcb   $6F o
         fcb   $84 
         fcb   $32 2
         fcb   $66 f
         fcb   $39 9
         fcb   $CC L
         fcb   $00 
         fcb   $81 
         fcb   $34 4
         fcb   $06 
         fcb   $30 0
         fcb   $8D 
         fcb   $04 
         fcb   $0E 
         fcb   $1F 
         fcb   $10 
         fcb   $17 
         fcb   $05 
         fcb   $63 c
         fcb   $32 2
         fcb   $62 b
         fcb   $ED m
         fcb   $A8 (
         fcb   $16 
         fcb   $CC L
         fcb   $00 
         fcb   $20 
         fcb   $34 4
         fcb   $06 
         fcb   $30 0
         fcb   $A9 )
         fcb   $00 
         fcb   $99 
         fcb   $34 4
         fcb   $10 
         fcb   $EC l
         fcb   $A8 (
         fcb   $16 
         fcb   $17 
         fcb   $05 
         fcb   $53 S
         fcb   $32 2
         fcb   $64 d
         fcb   $CC L
         fcb   $00 
         fcb   $20 
         fcb   $34 4
         fcb   $06 
         fcb   $30 0
         fcb   $A8 (
         fcb   $79 y
         fcb   $34 4
         fcb   $10 
         fcb   $EC l
         fcb   $A8 (
         fcb   $16 
         fcb   $17 
         fcb   $05 
         fcb   $41 A
         fcb   $32 2
         fcb   $64 d
         fcb   $30 0
         fcb   $A8 (
         fcb   $79 y
         fcb   $1F 
         fcb   $10 
         fcb   $C3 C
         fcb   $00 
         fcb   $1F 
         fcb   $34 4
         fcb   $06 
         fcb   $30 0
         fcb   $A9 )
         fcb   $00 
         fcb   $99 
         fcb   $E6 f
         fcb   $88 
         fcb   $1F 
         fcb   $E1 a
         fcb   $F1 q
         fcb   $26 &
         fcb   $2E .
         fcb   $30 0
         fcb   $A8 (
         fcb   $79 y
         fcb   $1F 
         fcb   $10 
         fcb   $C3 C
         fcb   $00 
         fcb   $1E 
         fcb   $34 4
         fcb   $06 
         fcb   $30 0
         fcb   $A9 )
         fcb   $00 
         fcb   $99 
         fcb   $E6 f
         fcb   $88 
         fcb   $1E 
         fcb   $E1 a
         fcb   $F1 q
         fcb   $26 &
         fcb   $19 
         fcb   $30 0
         fcb   $A8 (
         fcb   $79 y
         fcb   $1F 
         fcb   $10 
         fcb   $C3 C
         fcb   $00 
         fcb   $1D 
         fcb   $34 4
         fcb   $06 
         fcb   $30 0
         fcb   $A9 )
         fcb   $00 
         fcb   $99 
         fcb   $E6 f
         fcb   $88 
         fcb   $1D 
         fcb   $E1 a
         fcb   $F1 q
         fcb   $26 &
         fcb   $04 
         fcb   $CC L
         fcb   $00 
         fcb   $01 
         fcb   $39 9
         fcb   $5F _
         fcb   $4F O
         fcb   $39 9
         fcb   $34 4
         fcb   $06 
         fcb   $32 2
         fcb   $7D ý
         fcb   $5F _
         fcb   $4F O
         fcb   $ED m
         fcb   $61 a
         fcb   $EC l
         fcb   $61 a
         fcb   $AE .
         fcb   $63 c
         fcb   $E6 f
         fcb   $8B 
         fcb   $27 '
         fcb   $29 )
         fcb   $EC l
         fcb   $63 c
         fcb   $E3 c
         fcb   $61 a
         fcb   $1F 
         fcb   $01 
         fcb   $E6 f
         fcb   $84 
         fcb   $CA J
         fcb   $20 
         fcb   $E7 g
         fcb   $E4 d
         fcb   $5D ]
         fcb   $27 '
         fcb   $1A 
         fcb   $EC l
         fcb   $61 a
         fcb   $C3 C
         fcb   $00 
         fcb   $01 
         fcb   $ED m
         fcb   $61 a
         fcb   $83 
         fcb   $00 
         fcb   $01 
         fcb   $E3 c
         fcb   $67 g
         fcb   $34 4
         fcb   $06 
         fcb   $E6 f
         fcb   $62 b
         fcb   $E1 a
         fcb   $F1 q
         fcb   $27 '
         fcb   $D5 U
         fcb   $CC L
         fcb   $00 
         fcb   $01 
         fcb   $32 2
         fcb   $65 e
         fcb   $39 9
         fcb   $EC l
         fcb   $61 a
         fcb   $AE .
         fcb   $67 g
         fcb   $E6 f
         fcb   $8B 
         fcb   $4F O
         fcb   $32 2
         fcb   $65 e
         fcb   $39 9
         fcb   $34 4
         fcb   $06 
         fcb   $32 2
         fcb   $7C ü
         fcb   $5F _
         fcb   $4F O
         fcb   $ED m
         fcb   $E4 d
         fcb   $EC l
         fcb   $E4 d
         fcb   $AE .
         fcb   $64 d
         fcb   $E6 f
         fcb   $8B 
         fcb   $27 '
         fcb   $0C 
         fcb   $EC l
         fcb   $E4 d
         fcb   $C3 C
         fcb   $00 
         fcb   $01 
         fcb   $ED m
         fcb   $E4 d
         fcb   $83 
         fcb   $00 
         fcb   $01 
         fcb   $20 
         fcb   $EC l
         fcb   $5F _
         fcb   $4F O
         fcb   $ED m
         fcb   $62 b
         fcb   $EC l
         fcb   $E4 d
         fcb   $C3 C
         fcb   $00 
         fcb   $01 
         fcb   $ED m
         fcb   $E4 d
         fcb   $83 
         fcb   $00 
         fcb   $01 
         fcb   $E3 c
         fcb   $64 d
         fcb   $34 4
         fcb   $06 
         fcb   $EC l
         fcb   $64 d
         fcb   $AE .
         fcb   $6A j
         fcb   $E6 f
         fcb   $8B 
         fcb   $E7 g
         fcb   $F1 q
         fcb   $EC l
         fcb   $62 b
         fcb   $C3 C
         fcb   $00 
         fcb   $01 
         fcb   $ED m
         fcb   $62 b
         fcb   $83 
         fcb   $00 
         fcb   $01 
         fcb   $AE .
         fcb   $68 h
         fcb   $E6 f
         fcb   $8B 
         fcb   $C1 A
         fcb   $00 
         fcb   $27 '
         fcb   $08 
         fcb   $EC l
         fcb   $E4 d
         fcb   $10 
         fcb   $83 
         fcb   $00 
         fcb   $F9 y
         fcb   $2D -
         fcb   $D0 P
         fcb   $EC l
         fcb   $E4 d
         fcb   $10 
         fcb   $83 
         fcb   $00 
         fcb   $F9 y
         fcb   $2D -
         fcb   $12 
         fcb   $30 0
         fcb   $8D 
         fcb   $02 
         fcb   $FC 
         fcb   $34 4
         fcb   $10 
         fcb   $DC \
         fcb   $0E 
         fcb   $17 
         fcb   $04 
         fcb   $41 A
         fcb   $32 2
         fcb   $62 b
         fcb   $5F _
         fcb   $4F O
         fcb   $17 
         fcb   $04 
         fcb   $43 C
         fcb   $32 2
         fcb   $66 f
         fcb   $39 9
         fcb   $34 4
         fcb   $06 
         fcb   $32 2
         fcb   $7E þ
         fcb   $5F _
         fcb   $4F O
         fcb   $ED m
         fcb   $E4 d
         fcb   $EC l
         fcb   $E4 d
         fcb   $AE .
         fcb   $62 b
         fcb   $E6 f
         fcb   $8B 
         fcb   $27 '
         fcb   $0C 
         fcb   $EC l
         fcb   $E4 d
         fcb   $C3 C
         fcb   $00 
         fcb   $01 
         fcb   $ED m
         fcb   $E4 d
         fcb   $83 
         fcb   $00 
         fcb   $01 
         fcb   $20 
         fcb   $EC l
         fcb   $EC l
         fcb   $E4 d
         fcb   $10 
         fcb   $83 
         fcb   $00 
         fcb   $00 
         fcb   $2F /
         fcb   $2E .
         fcb   $EC l
         fcb   $A8 (
         fcb   $12 
         fcb   $10 
         fcb   $83 
         fcb   $00 
         fcb   $00 
         fcb   $2D -
         fcb   $25 %
         fcb   $EC l
         fcb   $A8 (
         fcb   $12 
         fcb   $83 
         fcb   $00 
         fcb   $01 
         fcb   $ED m
         fcb   $A8 (
         fcb   $12 
         fcb   $C3 C
         fcb   $00 
         fcb   $01 
         fcb   $30 0
         fcb   $A9 )
         fcb   $01 
         fcb   $4F O
         fcb   $34 4
         fcb   $10 
         fcb   $E3 c
         fcb   $E1 a
         fcb   $34 4
         fcb   $06 
         fcb   $EC l
         fcb   $62 b
         fcb   $83 
         fcb   $00 
         fcb   $01 
         fcb   $ED m
         fcb   $62 b
         fcb   $AE .
         fcb   $64 d
         fcb   $E6 f
         fcb   $8B 
         fcb   $E7 g
         fcb   $F1 q
         fcb   $20 
         fcb   $CA J
         fcb   $EC l
         fcb   $A8 (
         fcb   $12 
         fcb   $10 
         fcb   $83 
         fcb   $00 
         fcb   $00 
         fcb   $2E .
         fcb   $12 
         fcb   $30 0
         fcb   $8D 
         fcb   $02 
         fcb   $A8 (
         fcb   $34 4
         fcb   $10 
         fcb   $DC \
         fcb   $0E 
         fcb   $17 
         fcb   $03 
         fcb   $D1 Q
         fcb   $32 2
         fcb   $62 b
         fcb   $5F _
         fcb   $4F O
         fcb   $17 
         fcb   $03 
         fcb   $D3 S
         fcb   $32 2
         fcb   $64 d
         fcb   $39 9
         fcb   $34 4
         fcb   $06 
         fcb   $EC l
         fcb   $E4 d
         fcb   $17 
         fcb   $03 
         fcb   $D8 X
         fcb   $10 
         fcb   $83 
         fcb   $00 
         fcb   $00 
         fcb   $2C ,
         fcb   $16 
         fcb   $EC l
         fcb   $E4 d
         fcb   $34 4
         fcb   $06 
         fcb   $30 0
         fcb   $8D 
         fcb   $02 
         fcb   $9E 
         fcb   $34 4
         fcb   $10 
         fcb   $DC \
         fcb   $0E 
         fcb   $17 
         fcb   $03 
         fcb   $AB +
         fcb   $32 2
         fcb   $64 d
         fcb   $DC \
         fcb   $02 
         fcb   $17 
         fcb   $03 
         fcb   $AD -
         fcb   $32 2
         fcb   $62 b
         fcb   $39 9
         fcb   $30 0
         fcb   $8D 
         fcb   $02 
         fcb   $AF /
         fcb   $34 4
         fcb   $10 
         fcb   $DC \
         fcb   $0E 
         fcb   $17 
         fcb   $03 
         fcb   $96 
         fcb   $32 2
         fcb   $62 b
         fcb   $30 0
         fcb   $8D 
         fcb   $02 
         fcb   $CA J
         fcb   $34 4
         fcb   $10 
         fcb   $DC \
         fcb   $0E 
         fcb   $17 
         fcb   $03 
         fcb   $89 
         fcb   $32 2
         fcb   $62 b
         fcb   $30 0
         fcb   $8D 
         fcb   $02 
         fcb   $DE ^
         fcb   $34 4
         fcb   $10 
         fcb   $DC \
         fcb   $0E 
         fcb   $17 
         fcb   $03 
         fcb   $7C ü
         fcb   $32 2
         fcb   $62 b
         fcb   $30 0
         fcb   $8D 
         fcb   $02 
         fcb   $F3 s
         fcb   $34 4
         fcb   $10 
         fcb   $DC \
         fcb   $0E 
         fcb   $17 
         fcb   $03 
         fcb   $6F o
         fcb   $32 2
         fcb   $62 b
         fcb   $30 0
         fcb   $8D 
         fcb   $03 
         fcb   $09 
         fcb   $34 4
         fcb   $10 
         fcb   $DC \
         fcb   $0E 
         fcb   $17 
         fcb   $03 
         fcb   $62 b
         fcb   $32 2
         fcb   $62 b
         fcb   $30 0
         fcb   $8D 
         fcb   $03 
         fcb   $19 
         fcb   $34 4
         fcb   $10 
         fcb   $DC \
         fcb   $0E 
         fcb   $17 
         fcb   $03 
         fcb   $55 U
         fcb   $32 2
         fcb   $62 b
         fcb   $30 0
         fcb   $8D 
         fcb   $03 
         fcb   $2B +
         fcb   $34 4
         fcb   $10 
         fcb   $DC \
         fcb   $0E 
         fcb   $17 
         fcb   $03 
         fcb   $48 H
         fcb   $32 2
         fcb   $62 b
         fcb   $5F _
         fcb   $4F O
         fcb   $17 
         fcb   $03 
         fcb   $4A J
         fcb   $39 9
         fcb   $2A *
         fcb   $20 
         fcb   $53 S
         fcb   $6B k
         fcb   $69 i
         fcb   $70 p
         fcb   $70 p
         fcb   $69 i
         fcb   $6E n
         fcb   $67 g
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
         fcb   $3A :
         fcb   $20 
         fcb   $27 '
         fcb   $25 %
         fcb   $73 s
         fcb   $27 '
         fcb   $2E .
         fcb   $20 
         fcb   $20 
         fcb   $45 E
         fcb   $72 r
         fcb   $72 r
         fcb   $6F o
         fcb   $72 r
         fcb   $20 
         fcb   $23 #
         fcb   $25 %
         fcb   $64 d
         fcb   $0A 
         fcb   $00 
         fcb   $64 d
         fcb   $73 s
         fcb   $61 a
         fcb   $76 v
         fcb   $65 e
         fcb   $3A :
         fcb   $20 
         fcb   $75 u
         fcb   $6E n
         fcb   $6B k
         fcb   $6E n
         fcb   $6F o
         fcb   $77 w
         fcb   $6E n
         fcb   $20 
         fcb   $6F o
         fcb   $70 p
         fcb   $74 t
         fcb   $69 i
         fcb   $6F o
         fcb   $6E n
         fcb   $2D -
         fcb   $20 
         fcb   $25 %
         fcb   $63 c
         fcb   $0A 
         fcb   $0A 
         fcb   $00 
         fcb   $2F /
         fcb   $00 
         fcb   $2F /
         fcb   $44 D
         fcb   $30 0
         fcb   $00 
         fcb   $2F /
         fcb   $00 
         fcb   $2F /
         fcb   $44 D
         fcb   $31 1
         fcb   $00 
         fcb   $64 d
         fcb   $73 s
         fcb   $61 a
         fcb   $76 v
         fcb   $65 e
         fcb   $3A :
         fcb   $20 
         fcb   $75 u
         fcb   $6E n
         fcb   $70 p
         fcb   $72 r
         fcb   $6F o
         fcb   $63 c
         fcb   $65 e
         fcb   $73 s
         fcb   $73 s
         fcb   $65 e
         fcb   $64 d
         fcb   $20 
         fcb   $61 a
         fcb   $72 r
         fcb   $67 g
         fcb   $75 u
         fcb   $6D m
         fcb   $65 e
         fcb   $6E n
         fcb   $74 t
         fcb   $73 s
         fcb   $0A 
         fcb   $0A 
         fcb   $00 
         fcb   $74 t
         fcb   $0A 
         fcb   $00 
         fcb   $63 c
         fcb   $68 h
         fcb   $64 d
         fcb   $20 
         fcb   $25 %
         fcb   $73 s
         fcb   $0A 
         fcb   $00 
         fcb   $74 t
         fcb   $6D m
         fcb   $6F o
         fcb   $64 d
         fcb   $65 e
         fcb   $20 
         fcb   $2E .
         fcb   $31 1
         fcb   $20 
         fcb   $2D -
         fcb   $70 p
         fcb   $61 a
         fcb   $75 u
         fcb   $73 s
         fcb   $65 e
         fcb   $0A 
         fcb   $00 
         fcb   $6C l
         fcb   $6F o
         fcb   $61 a
         fcb   $64 d
         fcb   $20 
         fcb   $63 c
         fcb   $6F o
         fcb   $70 p
         fcb   $79 y
         fcb   $0A 
         fcb   $00 
         fcb   $6C l
         fcb   $6F o
         fcb   $61 a
         fcb   $64 d
         fcb   $20 
         fcb   $63 c
         fcb   $6D m
         fcb   $70 p
         fcb   $0A 
         fcb   $00 
         fcb   $2E .
         fcb   $2E .
         fcb   $00 
         fcb   $72 r
         fcb   $00 
         fcb   $64 d
         fcb   $73 s
         fcb   $61 a
         fcb   $76 v
         fcb   $65 e
         fcb   $3A :
         fcb   $20 
         fcb   $65 e
         fcb   $72 r
         fcb   $72 r
         fcb   $6F o
         fcb   $72 r
         fcb   $20 
         fcb   $69 i
         fcb   $6E n
         fcb   $20 
         fcb   $72 r
         fcb   $65 e
         fcb   $61 a
         fcb   $64 d
         fcb   $69 i
         fcb   $6E n
         fcb   $67 g
         fcb   $20 
         fcb   $70 p
         fcb   $61 a
         fcb   $74 t
         fcb   $68 h
         fcb   $0A 
         fcb   $00 
         fcb   $2F /
         fcb   $00 
         fcb   $2E .
         fcb   $2E .
         fcb   $00 
         fcb   $72 r
         fcb   $00 
         fcb   $72 r
         fcb   $00 
         fcb   $75 u
         fcb   $6E n
         fcb   $6C l
         fcb   $69 i
         fcb   $6E n
         fcb   $6B k
         fcb   $20 
         fcb   $63 c
         fcb   $6D m
         fcb   $70 p
         fcb   $0A 
         fcb   $00 
         fcb   $75 u
         fcb   $6E n
         fcb   $6C l
         fcb   $69 i
         fcb   $6E n
         fcb   $6B k
         fcb   $20 
         fcb   $63 c
         fcb   $6F o
         fcb   $70 p
         fcb   $79 y
         fcb   $0A 
         fcb   $00 
         fcb   $74 t
         fcb   $6D m
         fcb   $6F o
         fcb   $64 d
         fcb   $65 e
         fcb   $20 
         fcb   $2E .
         fcb   $31 1
         fcb   $20 
         fcb   $70 p
         fcb   $61 a
         fcb   $75 u
         fcb   $73 s
         fcb   $65 e
         fcb   $0A 
         fcb   $00 
         fcb   $64 d
         fcb   $73 s
         fcb   $61 a
         fcb   $76 v
         fcb   $65 e
         fcb   $3A :
         fcb   $20 
         fcb   $64 d
         fcb   $69 i
         fcb   $72 r
         fcb   $20 
         fcb   $6C l
         fcb   $65 e
         fcb   $76 v
         fcb   $65 e
         fcb   $6C l
         fcb   $20 
         fcb   $74 t
         fcb   $6F o
         fcb   $6F o
         fcb   $20 
         fcb   $64 d
         fcb   $65 e
         fcb   $65 e
         fcb   $70 p
         fcb   $20 
         fcb   $66 f
         fcb   $6F o
         fcb   $72 r
         fcb   $20 
         fcb   $69 i
         fcb   $6E n
         fcb   $64 d
         fcb   $65 e
         fcb   $6E n
         fcb   $74 t
         fcb   $0A 
         fcb   $00 
         fcb   $2E .
         fcb   $00 
         fcb   $64 d
         fcb   $73 s
         fcb   $61 a
         fcb   $76 v
         fcb   $65 e
         fcb   $3A :
         fcb   $20 
         fcb   $63 c
         fcb   $61 a
         fcb   $6E n
         fcb   $6E n
         fcb   $6F o
         fcb   $74 t
         fcb   $20 
         fcb   $6F o
         fcb   $70 p
         fcb   $65 e
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
         fcb   $0A 
         fcb   $00 
         fcb   $25 %
         fcb   $73 s
         fcb   $4D M
         fcb   $61 a
         fcb   $6B k
         fcb   $64 d
         fcb   $69 i
         fcb   $72 r
         fcb   $20 
         fcb   $25 %
         fcb   $73 s
         fcb   $0A 
         fcb   $00 
         fcb   $25 %
         fcb   $73 s
         fcb   $43 C
         fcb   $68 h
         fcb   $64 d
         fcb   $20 
         fcb   $25 %
         fcb   $73 s
         fcb   $0A 
         fcb   $00 
         fcb   $72 r
         fcb   $00 
         fcb   $2F /
         fcb   $00 
         fcb   $25 %
         fcb   $73 s
         fcb   $43 C
         fcb   $68 h
         fcb   $64 d
         fcb   $20 
         fcb   $2E .
         fcb   $2E .
         fcb   $0A 
         fcb   $00 
         fcb   $2E .
         fcb   $2E .
         fcb   $00 
         fcb   $72 r
         fcb   $00 
         fcb   $2E .
         fcb   $00 
         fcb   $64 d
         fcb   $73 s
         fcb   $61 a
         fcb   $76 v
         fcb   $65 e
         fcb   $3A :
         fcb   $20 
         fcb   $63 c
         fcb   $61 a
         fcb   $6E n
         fcb   $6E n
         fcb   $6F o
         fcb   $74 t
         fcb   $20 
         fcb   $6F o
         fcb   $70 p
         fcb   $65 e
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
         fcb   $0A 
         fcb   $00 
         fcb   $64 d
         fcb   $73 s
         fcb   $61 a
         fcb   $76 v
         fcb   $65 e
         fcb   $3A :
         fcb   $20 
         fcb   $73 s
         fcb   $65 e
         fcb   $65 e
         fcb   $6B k
         fcb   $20 
         fcb   $65 e
         fcb   $72 r
         fcb   $72 r
         fcb   $6F o
         fcb   $72 r
         fcb   $0A 
         fcb   $00 
         fcb   $6F o
         fcb   $73 s
         fcb   $39 9
         fcb   $62 b
         fcb   $6F o
         fcb   $6F o
         fcb   $74 t
         fcb   $00 
         fcb   $25 %
         fcb   $73 s
         fcb   $4F O
         fcb   $53 S
         fcb   $39 9
         fcb   $47 G
         fcb   $65 e
         fcb   $6E n
         fcb   $20 
         fcb   $25 %
         fcb   $73 s
         fcb   $0A 
         fcb   $25 %
         fcb   $73 s
         fcb   $25 %
         fcb   $73 s
         fcb   $2F /
         fcb   $4F O
         fcb   $53 S
         fcb   $39 9
         fcb   $42 B
         fcb   $6F o
         fcb   $6F o
         fcb   $74 t
         fcb   $0A 
         fcb   $0A 
         fcb   $00 
         fcb   $25 %
         fcb   $73 s
         fcb   $4F O
         fcb   $53 S
         fcb   $39 9
         fcb   $47 G
         fcb   $65 e
         fcb   $6E n
         fcb   $20 
         fcb   $25 %
         fcb   $73 s
         fcb   $0A 
         fcb   $25 %
         fcb   $73 s
         fcb   $25 %
         fcb   $73 s
         fcb   $0A 
         fcb   $0A 
         fcb   $00 
         fcb   $25 %
         fcb   $73 s
         fcb   $43 C
         fcb   $6F o
         fcb   $70 p
         fcb   $79 y
         fcb   $20 
         fcb   $25 %
         fcb   $73 s
         fcb   $20 
         fcb   $25 %
         fcb   $73 s
         fcb   $2F /
         fcb   $25 %
         fcb   $73 s
         fcb   $20 
         fcb   $25 %
         fcb   $73 s
         fcb   $0A 
         fcb   $00 
         fcb   $25 %
         fcb   $73 s
         fcb   $43 C
         fcb   $6D m
         fcb   $70 p
         fcb   $20 
         fcb   $25 %
         fcb   $73 s
         fcb   $2F /
         fcb   $25 %
         fcb   $73 s
         fcb   $20 
         fcb   $25 %
         fcb   $73 s
         fcb   $0A 
         fcb   $00 
         fcb   $2E .
         fcb   $00 
         fcb   $64 d
         fcb   $73 s
         fcb   $61 a
         fcb   $76 v
         fcb   $65 e
         fcb   $3A :
         fcb   $20 
         fcb   $65 e
         fcb   $72 r
         fcb   $72 r
         fcb   $6F o
         fcb   $72 r
         fcb   $20 
         fcb   $70 p
         fcb   $61 a
         fcb   $74 t
         fcb   $68 h
         fcb   $20 
         fcb   $74 t
         fcb   $6F o
         fcb   $6F o
         fcb   $20 
         fcb   $6C l
         fcb   $6F o
         fcb   $6E n
         fcb   $67 g
         fcb   $0A 
         fcb   $00 
         fcb   $64 d
         fcb   $73 s
         fcb   $61 a
         fcb   $76 v
         fcb   $65 e
         fcb   $3A :
         fcb   $20 
         fcb   $65 e
         fcb   $72 r
         fcb   $72 r
         fcb   $6F o
         fcb   $72 r
         fcb   $20 
         fcb   $70 p
         fcb   $61 a
         fcb   $74 t
         fcb   $68 h
         fcb   $20 
         fcb   $74 t
         fcb   $6F o
         fcb   $6F o
         fcb   $20 
         fcb   $6C l
         fcb   $6F o
         fcb   $6E n
         fcb   $67 g
         fcb   $0A 
         fcb   $00 
         fcb   $64 d
         fcb   $73 s
         fcb   $61 a
         fcb   $76 v
         fcb   $65 e
         fcb   $3A :
         fcb   $20 
         fcb   $63 c
         fcb   $61 a
         fcb   $6E n
         fcb   $6E n
         fcb   $6F o
         fcb   $74 t
         fcb   $20 
         fcb   $63 c
         fcb   $68 h
         fcb   $61 a
         fcb   $6E n
         fcb   $67 g
         fcb   $65 e
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
         fcb   $20 
         fcb   $74 t
         fcb   $6F o
         fcb   $20 
         fcb   $25 %
         fcb   $73 s
         fcb   $0A 
         fcb   $00 
         fcb   $55 U
         fcb   $73 s
         fcb   $65 e
         fcb   $3A :
         fcb   $20 
         fcb   $44 D
         fcb   $53 S
         fcb   $41 A
         fcb   $56 V
         fcb   $45 E
         fcb   $20 
         fcb   $3C <
         fcb   $2D -
         fcb   $6F o
         fcb   $70 p
         fcb   $74 t
         fcb   $73 s
         fcb   $3E >
         fcb   $20 
         fcb   $3C <
         fcb   $66 f
         fcb   $72 r
         fcb   $6F o
         fcb   $6D m
         fcb   $20 
         fcb   $64 d
         fcb   $65 e
         fcb   $76 v
         fcb   $3E >
         fcb   $20 
         fcb   $3C <
         fcb   $74 t
         fcb   $6F o
         fcb   $20 
         fcb   $64 d
         fcb   $65 e
         fcb   $76 v
         fcb   $3E >
         fcb   $0A 
         fcb   $00 
         fcb   $20 
         fcb   $20 
         fcb   $20 
         fcb   $20 
         fcb   $20 
         fcb   $6F o
         fcb   $70 p
         fcb   $74 t
         fcb   $73 s
         fcb   $20 
         fcb   $20 
         fcb   $62 b
         fcb   $20 
         fcb   $3D =
         fcb   $20 
         fcb   $69 i
         fcb   $6E n
         fcb   $63 c
         fcb   $6C l
         fcb   $75 u
         fcb   $64 d
         fcb   $65 e
         fcb   $20 
         fcb   $62 b
         fcb   $6F o
         fcb   $6F o
         fcb   $74 t
         fcb   $66 f
         fcb   $69 i
         fcb   $6C l
         fcb   $65 e
         fcb   $0A 
         fcb   $00 
         fcb   $20 
         fcb   $20 
         fcb   $20 
         fcb   $20 
         fcb   $20 
         fcb   $20 
         fcb   $20 
         fcb   $20 
         fcb   $20 
         fcb   $20 
         fcb   $20 
         fcb   $69 i
         fcb   $20 
         fcb   $3D =
         fcb   $20 
         fcb   $69 i
         fcb   $6E n
         fcb   $64 d
         fcb   $65 e
         fcb   $6E n
         fcb   $74 t
         fcb   $20 
         fcb   $64 d
         fcb   $69 i
         fcb   $72 r
         fcb   $20 
         fcb   $6C l
         fcb   $65 e
         fcb   $76 v
         fcb   $65 e
         fcb   $6C l
         fcb   $73 s
         fcb   $0A 
         fcb   $00 
         fcb   $20 
         fcb   $20 
         fcb   $20 
         fcb   $20 
         fcb   $20 
         fcb   $20 
         fcb   $20 
         fcb   $20 
         fcb   $20 
         fcb   $20 
         fcb   $20 
         fcb   $6C l
         fcb   $20 
         fcb   $3D =
         fcb   $20 
         fcb   $6F o
         fcb   $6E n
         fcb   $6C l
         fcb   $79 y
         fcb   $20 
         fcb   $6F o
         fcb   $6E n
         fcb   $65 e
         fcb   $20 
         fcb   $64 d
         fcb   $69 i
         fcb   $72 r
         fcb   $20 
         fcb   $6C l
         fcb   $65 e
         fcb   $76 v
         fcb   $65 e
         fcb   $6C l
         fcb   $0A 
         fcb   $00 
         fcb   $20 
         fcb   $20 
         fcb   $20 
         fcb   $20 
         fcb   $20 
         fcb   $20 
         fcb   $20 
         fcb   $20 
         fcb   $20 
         fcb   $20 
         fcb   $20 
         fcb   $6D m
         fcb   $20 
         fcb   $3D =
         fcb   $20 
         fcb   $6F o
         fcb   $6D m
         fcb   $69 i
         fcb   $74 t
         fcb   $20 
         fcb   $6D m
         fcb   $61 a
         fcb   $6B k
         fcb   $64 d
         fcb   $69 i
         fcb   $72 r
         fcb   $73 s
         fcb   $0A 
         fcb   $00 
         fcb   $20 
         fcb   $20 
         fcb   $20 
         fcb   $20 
         fcb   $20 
         fcb   $20 
         fcb   $20 
         fcb   $20 
         fcb   $20 
         fcb   $20 
         fcb   $20 
         fcb   $73 s
         fcb   $20 
         fcb   $3D =
         fcb   $20 
         fcb   $61 a
         fcb   $6C l
         fcb   $74 t
         fcb   $65 e
         fcb   $72 r
         fcb   $20 
         fcb   $6D m
         fcb   $65 e
         fcb   $6D m
         fcb   $20 
         fcb   $73 s
         fcb   $69 i
         fcb   $7A z
         fcb   $65 e
         fcb   $0A 
         fcb   $00 
         fcb   $20 
         fcb   $20 
         fcb   $20 
         fcb   $20 
         fcb   $20 
         fcb   $20 
         fcb   $20 
         fcb   $20 
         fcb   $20 
         fcb   $20 
         fcb   $20 
         fcb   $76 v
         fcb   $20 
         fcb   $3D =
         fcb   $20 
         fcb   $76 v
         fcb   $65 e
         fcb   $72 r
         fcb   $69 i
         fcb   $66 f
         fcb   $79 y
         fcb   $20 
         fcb   $63 c
         fcb   $6F o
         fcb   $70 p
         fcb   $69 i
         fcb   $65 e
         fcb   $64 d
         fcb   $20 
         fcb   $66 f
         fcb   $69 i
         fcb   $6C l
         fcb   $65 e
         fcb   $73 s
         fcb   $0A 
         fcb   $00 
         fcb   $16 
         fcb   $00 
         fcb   $C3 C
         fcb   $16 
         fcb   $00 
         fcb   $F5 u
         fcb   $16 
         fcb   $03 
         fcb   $F1 q
         fcb   $16 
         fcb   $00 
         fcb   $9F 
         fcb   $16 
         fcb   $0B 
         fcb   $1F 
         fcb   $16 
         fcb   $0B 
         fcb   $29 )
         fcb   $16 
         fcb   $0B 
         fcb   $30 0
         fcb   $16 
         fcb   $0B 
         fcb   $C6 F
         fcb   $16 
         fcb   $0B 
         fcb   $01 
         fcb   $5F _
         fcb   $E7 g
         fcb   $C1 A
         fcb   $A6 &
         fcb   $80 
         fcb   $81 
         fcb   $0D 
         fcb   $27 '
         fcb   $18 
         fcb   $8D 
         fcb   $7E þ
         fcb   $27 '
         fcb   $F6 v
         fcb   $30 0
         fcb   $1F 
         fcb   $AF /
         fcb   $C1 A
         fcb   $0C 
         fcb   $00 
         fcb   $A6 &
         fcb   $80 
         fcb   $81 
         fcb   $0D 
         fcb   $27 '
         fcb   $08 
         fcb   $8D 
         fcb   $6E n
         fcb   $26 &
         fcb   $F6 v
         fcb   $6F o
         fcb   $1F 
         fcb   $20 
         fcb   $E2 b
         fcb   $6F o
         fcb   $82 
         fcb   $96 
         fcb   $00 
         fcb   $97 
         fcb   $01 
         fcb   $4F O
         fcb   $5F _
         fcb   $34 4
         fcb   $06 
         fcb   $0D 
         fcb   $00 
         fcb   $27 '
         fcb   $08 
         fcb   $0A 
         fcb   $00 
         fcb   $EC l
         fcb   $C3 C
         fcb   $34 4
         fcb   $06 
         fcb   $20 
         fcb   $F4 t
         fcb   $34 4
         fcb   $10 
         fcb   $30 0
         fcb   $E4 d
         fcb   $34 4
         fcb   $10 
         fcb   $30 0
         fcb   $7E þ
         fcb   $34 4
         fcb   $10 
         fcb   $30 0
         fcb   $C4 D
         fcb   $6F o
         fcb   $80 
         fcb   $AC ,
         fcb   $E4 d
         fcb   $25 %
         fcb   $FA z
         fcb   $35 5
         fcb   $10 
         fcb   $33 3
         fcb   $5E ^
         fcb   $30 0
         fcb   $C8 H
         fcb   $10 
         fcb   $9F 
         fcb   $0A 
         fcb   $9F 
         fcb   $08 
         fcb   $30 0
         fcb   $C8 H
         fcb   $1B 
         fcb   $9F 
         fcb   $0C 
         fcb   $9F 
         fcb   $18 
         fcb   $30 0
         fcb   $C8 H
         fcb   $26 &
         fcb   $9F 
         fcb   $0E 
         fcb   $9F 
         fcb   $23 #
         fcb   $86 
         fcb   $05 
         fcb   $97 
         fcb   $16 
         fcb   $86 
         fcb   $06 
         fcb   $97 
         fcb   $21 !
         fcb   $86 
         fcb   $06 
         fcb   $97 
         fcb   $2C ,
         fcb   $4F O
         fcb   $97 
         fcb   $17 
         fcb   $4C L
         fcb   $97 
         fcb   $22 "
         fcb   $4C L
         fcb   $97 
         fcb   $2D -
         fcb   $EC l
         fcb   $C4 D
         fcb   $C3 C
         fcb   $00 
         fcb   $01 
         fcb   $10 
         fcb   $9F 
         fcb   $00 
         fcb   $31 1
         fcb   $C9 I
         fcb   $00 
         fcb   $FD 
         fcb   $17 
         fcb   $F1 q
         fcb   $7C ü
         fcb   $16 
         fcb   $00 
         fcb   $07 
         fcb   $81 
         fcb   $20 
         fcb   $27 '
         fcb   $02 
         fcb   $81 
         fcb   $09 
         fcb   $39 9
         fcb   $34 4
         fcb   $06 
         fcb   $DC \
         fcb   $08 
         fcb   $27 '
         fcb   $07 
         fcb   $DC \
         fcb   $08 
         fcb   $17 
         fcb   $00 
         fcb   $0A 
         fcb   $20 
         fcb   $F5 u
         fcb   $EC l
         fcb   $E4 d
         fcb   $17 
         fcb   $00 
         fcb   $06 
         fcb   $32 2
         fcb   $62 b
         fcb   $39 9
         fcb   $16 
         fcb   $03 
         fcb   $37 7
         fcb   $16 
         fcb   $0B 
         fcb   $56 V
         fcb   $34 4
         fcb   $06 
         fcb   $32 2
         fcb   $E9 i
         fcb   $FF 
         fcb   $00 
         fcb   $30 0
         fcb   $E9 i
         fcb   $01 
         fcb   $06 
         fcb   $34 4
         fcb   $10 
         fcb   $EC l
         fcb   $E9 i
         fcb   $01 
         fcb   $06 
         fcb   $34 4
         fcb   $06 
         fcb   $30 0
         fcb   $64 d
         fcb   $1F 
         fcb   $10 
         fcb   $17 
         fcb   $00 
         fcb   $16 
         fcb   $32 2
         fcb   $64 d
         fcb   $EC l
         fcb   $E9 i
         fcb   $01 
         fcb   $00 
         fcb   $34 4
         fcb   $06 
         fcb   $30 0
         fcb   $62 b
         fcb   $1F 
         fcb   $10 
         fcb   $17 
         fcb   $00 
         fcb   $0A 
         fcb   $32 2
         fcb   $62 b
         fcb   $32 2
         fcb   $E9 i
         fcb   $01 
         fcb   $02 
         fcb   $39 9
         fcb   $16 
         fcb   $00 
         fcb   $30 0
         fcb   $16 
         fcb   $04 
         fcb   $58 X
         fcb   $34 4
         fcb   $06 
         fcb   $32 2
         fcb   $E9 i
         fcb   $FF 
         fcb   $00 
         fcb   $30 0
         fcb   $E9 i
         fcb   $01 
         fcb   $04 
         fcb   $34 4
         fcb   $10 
         fcb   $EC l
         fcb   $E9 i
         fcb   $01 
         fcb   $02 
         fcb   $34 4
         fcb   $06 
         fcb   $30 0
         fcb   $64 d
         fcb   $1F 
         fcb   $10 
         fcb   $17 
         fcb   $00 
         fcb   $0E 
         fcb   $32 2
         fcb   $64 d
         fcb   $30 0
         fcb   $E4 d
         fcb   $1F 
         fcb   $10 
         fcb   $17 
         fcb   $00 
         fcb   $08 
         fcb   $32 2
         fcb   $E9 i
         fcb   $01 
         fcb   $02 
         fcb   $39 9
         fcb   $16 
         fcb   $00 
         fcb   $03 
         fcb   $16 
         fcb   $03 
         fcb   $C6 F
         fcb   $34 4
         fcb   $06 
         fcb   $32 2
         fcb   $E9 i
         fcb   $FE 
         fcb   $F3 s
         fcb   $AE .
         fcb   $E9 i
         fcb   $01 
         fcb   $11 
         fcb   $E6 f
         fcb   $80 
         fcb   $AF /
         fcb   $E9 i
         fcb   $01 
         fcb   $11 
         fcb   $E7 g
         fcb   $E4 d
         fcb   $5D ]
         fcb   $10 
         fcb   $27 '
         fcb   $02 
         fcb   $1C 
         fcb   $E6 f
         fcb   $E4 d
         fcb   $C1 A
         fcb   $25 %
         fcb   $27 '
         fcb   $16 
         fcb   $EC l
         fcb   $E9 i
         fcb   $01 
         fcb   $0D 
         fcb   $C3 C
         fcb   $00 
         fcb   $01 
         fcb   $ED m
         fcb   $E9 i
         fcb   $01 
         fcb   $0D 
         fcb   $83 
         fcb   $00 
         fcb   $01 
         fcb   $34 4
         fcb   $06 
         fcb   $E6 f
         fcb   $62 b
         fcb   $E7 g
         fcb   $F1 q
         fcb   $20 
         fcb   $D3 S
         fcb   $30 0
         fcb   $6D m
         fcb   $AF /
         fcb   $69 i
         fcb   $CC L
         fcb   $00 
         fcb   $06 
         fcb   $ED m
         fcb   $64 d
         fcb   $6F o
         fcb   $67 g
         fcb   $C6 F
         fcb   $20 
         fcb   $E7 g
         fcb   $68 h
         fcb   $6F o
         fcb   $66 f
         fcb   $E6 f
         fcb   $F9 y
         fcb   $01 
         fcb   $11 
         fcb   $C1 A
         fcb   $2D -
         fcb   $26 &
         fcb   $0F 
         fcb   $EC l
         fcb   $E9 i
         fcb   $01 
         fcb   $11 
         fcb   $C3 C
         fcb   $00 
         fcb   $01 
         fcb   $ED m
         fcb   $E9 i
         fcb   $01 
         fcb   $11 
         fcb   $C6 F
         fcb   $01 
         fcb   $E7 g
         fcb   $67 g
         fcb   $E6 f
         fcb   $F9 y
         fcb   $01 
         fcb   $11 
         fcb   $4F O
         fcb   $17 
         fcb   $02 
         fcb   $5D ]
         fcb   $C3 C
         fcb   $00 
         fcb   $00 
         fcb   $27 '
         fcb   $19 
         fcb   $E6 f
         fcb   $F9 y
         fcb   $01 
         fcb   $11 
         fcb   $C1 A
         fcb   $30 0
         fcb   $26 &
         fcb   $04 
         fcb   $C6 F
         fcb   $30 0
         fcb   $E7 g
         fcb   $68 h
         fcb   $30 0
         fcb   $E9 i
         fcb   $01 
         fcb   $11 
         fcb   $1F 
         fcb   $10 
         fcb   $17 
         fcb   $02 
         fcb   $46 F
         fcb   $ED m
         fcb   $62 b
         fcb   $20 
         fcb   $04 
         fcb   $5F _
         fcb   $4F O
         fcb   $ED m
         fcb   $62 b
         fcb   $E6 f
         fcb   $F9 y
         fcb   $01 
         fcb   $11 
         fcb   $C1 A
         fcb   $2E .
         fcb   $26 &
         fcb   $1A 
         fcb   $EC l
         fcb   $E9 i
         fcb   $01 
         fcb   $11 
         fcb   $C3 C
         fcb   $00 
         fcb   $01 
         fcb   $ED m
         fcb   $E9 i
         fcb   $01 
         fcb   $11 
         fcb   $30 0
         fcb   $E9 i
         fcb   $01 
         fcb   $11 
         fcb   $1F 
         fcb   $10 
         fcb   $17 
         fcb   $02 
         fcb   $22 "
         fcb   $ED m
         fcb   $64 d
         fcb   $C6 F
         fcb   $01 
         fcb   $E7 g
         fcb   $66 f
         fcb   $AE .
         fcb   $E9 i
         fcb   $01 
         fcb   $11 
         fcb   $E6 f
         fcb   $80 
         fcb   $AF /
         fcb   $E9 i
         fcb   $01 
         fcb   $11 
         fcb   $E7 g
         fcb   $E4 d
         fcb   $E6 f
         fcb   $E4 d
         fcb   $4F O
         fcb   $17 
         fcb   $02 
         fcb   $0D 
         fcb   $C1 A
         fcb   $64 d
         fcb   $27 '
         fcb   $1F 
         fcb   $C1 A
         fcb   $75 u
         fcb   $27 '
         fcb   $48 H
         fcb   $C1 A
         fcb   $78 x
         fcb   $10 
         fcb   $27 '
         fcb   $00 
         fcb   $48 H
         fcb   $C1 A
         fcb   $6F o
         fcb   $10 
         fcb   $27 '
         fcb   $00 
         fcb   $48 H
         fcb   $C1 A
         fcb   $63 c
         fcb   $10 
         fcb   $27 '
         fcb   $00 
         fcb   $6C l
         fcb   $C1 A
         fcb   $73 s
         fcb   $10 
         fcb   $27 '
         fcb   $00 
         fcb   $88 
         fcb   $16 
         fcb   $01 
         fcb   $40 @
         fcb   $EC l
         fcb   $F9 y
         fcb   $01 
         fcb   $13 
         fcb   $10 
         fcb   $83 
         fcb   $00 
         fcb   $00 
         fcb   $2C ,
         fcb   $23 #
         fcb   $EC l
         fcb   $69 i
         fcb   $C3 C
         fcb   $00 
         fcb   $01 
         fcb   $ED m
         fcb   $69 i
         fcb   $83 
         fcb   $00 
         fcb   $01 
         fcb   $34 4
         fcb   $06 
         fcb   $C6 F
         fcb   $2D -
         fcb   $E7 g
         fcb   $F1 q
         fcb   $EC l
         fcb   $F9 y
         fcb   $01 
         fcb   $13 
         fcb   $40 @
         fcb   $50 P
         fcb   $82 
         fcb   $00 
         fcb   $ED m
         fcb   $F9 y
         fcb   $01 
         fcb   $13 
         fcb   $EC l
         fcb   $62 b
         fcb   $83 
         fcb   $00 
         fcb   $01 
         fcb   $ED m
         fcb   $62 b
         fcb   $C6 F
         fcb   $0A 
         fcb   $E7 g
         fcb   $61 a
         fcb   $20 
         fcb   $0A 
         fcb   $C6 F
         fcb   $10 
         fcb   $E7 g
         fcb   $61 a
         fcb   $20 
         fcb   $04 
         fcb   $C6 F
         fcb   $08 
         fcb   $E7 g
         fcb   $61 a
         fcb   $E6 f
         fcb   $61 a
         fcb   $4F O
         fcb   $34 4
         fcb   $06 
         fcb   $AE .
         fcb   $E9 i
         fcb   $01 
         fcb   $15 
         fcb   $EC l
         fcb   $81 
         fcb   $AF /
         fcb   $E9 i
         fcb   $01 
         fcb   $15 
         fcb   $34 4
         fcb   $06 
         fcb   $30 0
         fcb   $6D m
         fcb   $1F 
         fcb   $10 
         fcb   $17 
         fcb   $01 
         fcb   $0B 
         fcb   $32 2
         fcb   $64 d
         fcb   $4F O
         fcb   $34 4
         fcb   $06 
         fcb   $EC l
         fcb   $64 d
         fcb   $A3 #
         fcb   $E1 a
         fcb   $ED m
         fcb   $62 b
         fcb   $16 
         fcb   $00 
         fcb   $64 d
         fcb   $EC l
         fcb   $69 i
         fcb   $C3 C
         fcb   $00 
         fcb   $01 
         fcb   $ED m
         fcb   $69 i
         fcb   $83 
         fcb   $00 
         fcb   $01 
         fcb   $34 4
         fcb   $06 
         fcb   $AE .
         fcb   $E9 i
         fcb   $01 
         fcb   $15 
         fcb   $EC l
         fcb   $81 
         fcb   $AF /
         fcb   $E9 i
         fcb   $01 
         fcb   $15 
         fcb   $E7 g
         fcb   $F1 q
         fcb   $EC l
         fcb   $62 b
         fcb   $83 
         fcb   $00 
         fcb   $01 
         fcb   $ED m
         fcb   $62 b
         fcb   $16 
         fcb   $00 
         fcb   $42 B
         fcb   $E6 f
         fcb   $66 f
         fcb   $26 &
         fcb   $05 
         fcb   $CC L
         fcb   $01 
         fcb   $00 
         fcb   $ED m
         fcb   $64 d
         fcb   $AE .
         fcb   $E9 i
         fcb   $01 
         fcb   $13 
         fcb   $EC l
         fcb   $81 
         fcb   $AF /
         fcb   $E9 i
         fcb   $01 
         fcb   $13 
         fcb   $ED m
         fcb   $6B k
         fcb   $E6 f
         fcb   $F8 x
         fcb   $0B 
         fcb   $27 '
         fcb   $28 (
         fcb   $EC l
         fcb   $64 d
         fcb   $27 '
         fcb   $24 $
         fcb   $EC l
         fcb   $69 i
         fcb   $C3 C
         fcb   $00 
         fcb   $01 
         fcb   $ED m
         fcb   $69 i
         fcb   $83 
         fcb   $00 
         fcb   $01 
         fcb   $34 4
         fcb   $06 
         fcb   $AE .
         fcb   $6D m
         fcb   $E6 f
         fcb   $80 
         fcb   $AF /
         fcb   $6D m
         fcb   $E7 g
         fcb   $F1 q
         fcb   $EC l
         fcb   $64 d
         fcb   $83 
         fcb   $00 
         fcb   $01 
         fcb   $ED m
         fcb   $64 d
         fcb   $EC l
         fcb   $62 b
         fcb   $83 
         fcb   $00 
         fcb   $01 
         fcb   $ED m
         fcb   $62 b
         fcb   $20 
         fcb   $D3 S
         fcb   $6F o
         fcb   $F8 x
         fcb   $09 
         fcb   $30 0
         fcb   $6D m
         fcb   $AF /
         fcb   $69 i
         fcb   $E6 f
         fcb   $67 g
         fcb   $26 &
         fcb   $26 &
         fcb   $EC l
         fcb   $62 b
         fcb   $83 
         fcb   $00 
         fcb   $01 
         fcb   $ED m
         fcb   $62 b
         fcb   $C3 C
         fcb   $00 
         fcb   $01 
         fcb   $10 
         fcb   $83 
         fcb   $00 
         fcb   $00 
         fcb   $2F /
         fcb   $16 
         fcb   $EC l
         fcb   $E9 i
         fcb   $01 
         fcb   $0D 
         fcb   $C3 C
         fcb   $00 
         fcb   $01 
         fcb   $ED m
         fcb   $E9 i
         fcb   $01 
         fcb   $0D 
         fcb   $83 
         fcb   $00 
         fcb   $01 
         fcb   $34 4
         fcb   $06 
         fcb   $E6 f
         fcb   $6A j
         fcb   $E7 g
         fcb   $F1 q
         fcb   $20 
         fcb   $DA Z
         fcb   $AE .
         fcb   $69 i
         fcb   $E6 f
         fcb   $80 
         fcb   $AF /
         fcb   $69 i
         fcb   $E7 g
         fcb   $F9 y
         fcb   $01 
         fcb   $0D 
         fcb   $5D ]
         fcb   $27 '
         fcb   $0D 
         fcb   $EC l
         fcb   $E9 i
         fcb   $01 
         fcb   $0D 
         fcb   $C3 C
         fcb   $00 
         fcb   $01 
         fcb   $ED m
         fcb   $E9 i
         fcb   $01 
         fcb   $0D 
         fcb   $20 
         fcb   $E6 f
         fcb   $E6 f
         fcb   $67 g
         fcb   $10 
         fcb   $27 '
         fcb   $FE 
         fcb   $12 
         fcb   $EC l
         fcb   $62 b
         fcb   $83 
         fcb   $00 
         fcb   $01 
         fcb   $ED m
         fcb   $62 b
         fcb   $C3 C
         fcb   $00 
         fcb   $01 
         fcb   $10 
         fcb   $83 
         fcb   $00 
         fcb   $00 
         fcb   $10 
         fcb   $2F /
         fcb   $FE 
         fcb   $00 
         fcb   $EC l
         fcb   $E9 i
         fcb   $01 
         fcb   $0D 
         fcb   $C3 C
         fcb   $00 
         fcb   $01 
         fcb   $ED m
         fcb   $E9 i
         fcb   $01 
         fcb   $0D 
         fcb   $83 
         fcb   $00 
         fcb   $01 
         fcb   $34 4
         fcb   $06 
         fcb   $E6 f
         fcb   $6A j
         fcb   $E7 g
         fcb   $F1 q
         fcb   $20 
         fcb   $D8 X
         fcb   $EC l
         fcb   $E9 i
         fcb   $01 
         fcb   $0D 
         fcb   $C3 C
         fcb   $00 
         fcb   $01 
         fcb   $ED m
         fcb   $E9 i
         fcb   $01 
         fcb   $0D 
         fcb   $83 
         fcb   $00 
         fcb   $01 
         fcb   $34 4
         fcb   $06 
         fcb   $E6 f
         fcb   $62 b
         fcb   $E7 g
         fcb   $F1 q
         fcb   $16 
         fcb   $FD 
         fcb   $D3 S
         fcb   $6F o
         fcb   $F9 y
         fcb   $01 
         fcb   $0D 
         fcb   $32 2
         fcb   $E9 i
         fcb   $01 
         fcb   $0F 
         fcb   $39 9
         fcb   $34 4
         fcb   $06 
         fcb   $32 2
         fcb   $7D ý
         fcb   $EC l
         fcb   $F8 x
         fcb   $03 
         fcb   $ED m
         fcb   $E4 d
         fcb   $EC l
         fcb   $67 g
         fcb   $34 4
         fcb   $06 
         fcb   $EC l
         fcb   $6B k
         fcb   $17 
         fcb   $00 
         fcb   $7E þ
         fcb   $E7 g
         fcb   $62 b
         fcb   $EC l
         fcb   $F8 x
         fcb   $03 
         fcb   $C3 C
         fcb   $00 
         fcb   $01 
         fcb   $ED m
         fcb   $F8 x
         fcb   $03 
         fcb   $83 
         fcb   $00 
         fcb   $01 
         fcb   $34 4
         fcb   $06 
         fcb   $E6 f
         fcb   $64 d
         fcb   $C1 A
         fcb   $0A 
         fcb   $24 $
         fcb   $06 
         fcb   $E6 f
         fcb   $64 d
         fcb   $CB K
         fcb   $30 0
         fcb   $20 
         fcb   $04 
         fcb   $E6 f
         fcb   $64 d
         fcb   $CB K
         fcb   $37 7
         fcb   $E7 g
         fcb   $F1 q
         fcb   $EC l
         fcb   $67 g
         fcb   $34 4
         fcb   $06 
         fcb   $EC l
         fcb   $6B k
         fcb   $17 
         fcb   $00 
         fcb   $56 V
         fcb   $ED m
         fcb   $67 g
         fcb   $C3 C
         fcb   $00 
         fcb   $00 
         fcb   $27 '
         fcb   $2D -
         fcb   $EC l
         fcb   $67 g
         fcb   $34 4
         fcb   $06 
         fcb   $EC l
         fcb   $6B k
         fcb   $17 
         fcb   $00 
         fcb   $43 C
         fcb   $E7 g
         fcb   $62 b
         fcb   $EC l
         fcb   $F8 x
         fcb   $03 
         fcb   $C3 C
         fcb   $00 
         fcb   $01 
         fcb   $ED m
         fcb   $F8 x
         fcb   $03 
         fcb   $83 
         fcb   $00 
         fcb   $01 
         fcb   $34 4
         fcb   $06 
         fcb   $E6 f
         fcb   $64 d
         fcb   $C1 A
         fcb   $0A 
         fcb   $24 $
         fcb   $06 
         fcb   $E6 f
         fcb   $64 d
         fcb   $CB K
         fcb   $30 0
         fcb   $20 
         fcb   $04 
         fcb   $E6 f
         fcb   $64 d
         fcb   $CB K
         fcb   $37 7
         fcb   $E7 g
         fcb   $F1 q
         fcb   $20 
         fcb   $C3 C
         fcb   $AE .
         fcb   $F8 x
         fcb   $03 
         fcb   $6F o
         fcb   $84 
         fcb   $EC l
         fcb   $E4 d
         fcb   $17 
         fcb   $00 
         fcb   $12 
         fcb   $EC l
         fcb   $F8 x
         fcb   $03 
         fcb   $A3 #
         fcb   $E4 d
         fcb   $4F O
         fcb   $32 2
         fcb   $65 e
         fcb   $39 9
         fcb   $16 
         fcb   $05 
         fcb   $C0 @
         fcb   $16 
         fcb   $00 
         fcb   $C1 A
         fcb   $16 
         fcb   $05 
         fcb   $D1 Q
         fcb   $16 
         fcb   $01 
         fcb   $0D 
         fcb   $16 
         fcb   $06 
         fcb   $69 i
         fcb   $16 
         fcb   $06 
         fcb   $82 
         fcb   $34 4
         fcb   $06 
         fcb   $32 2
         fcb   $7B û
         fcb   $5F _
         fcb   $4F O
         fcb   $ED m
         fcb   $62 b
         fcb   $DC \
         fcb   $08 
         fcb   $ED m
         fcb   $E4 d
         fcb   $EC l
         fcb   $E4 d
         fcb   $10 
         fcb   $27 '
         fcb   $00 
         fcb   $5D ]
         fcb   $EC l
         fcb   $E4 d
         fcb   $10 
         fcb   $A3 #
         fcb   $65 e
         fcb   $10 
         fcb   $26 &
         fcb   $00 
         fcb   $47 G
         fcb   $EC l
         fcb   $62 b
         fcb   $27 '
         fcb   $0F 
         fcb   $EC l
         fcb   $62 b
         fcb   $C3 C
         fcb   $00 
         fcb   $08 
         fcb   $34 4
         fcb   $06 
         fcb   $AE .
         fcb   $62 b
         fcb   $EC l
         fcb   $08 
         fcb   $ED m
         fcb   $F1 q
         fcb   $20 
         fcb   $06 
         fcb   $AE .
         fcb   $E4 d
         fcb   $EC l
         fcb   $08 
         fcb   $DD ]
         fcb   $08 
         fcb   $6F o
         fcb   $64 d
         fcb   $EC l
         fcb   $65 e
         fcb   $17 
         fcb   $00 
         fcb   $71 q
         fcb   $AE .
         fcb   $65 e
         fcb   $E6 f
         fcb   $07 
         fcb   $4F O
         fcb   $17 
         fcb   $00 
         fcb   $6C l
         fcb   $10 
         fcb   $83 
         fcb   $FF 
         fcb   $FF 
         fcb   $26 &
         fcb   $04 
         fcb   $C6 F
         fcb   $01 
         fcb   $E7 g
         fcb   $64 d
         fcb   $EC l
         fcb   $65 e
         fcb   $17 
         fcb   $00 
         fcb   $23 #
         fcb   $E6 f
         fcb   $64 d
         fcb   $27 '
         fcb   $06 
         fcb   $CC L
         fcb   $FF 
         fcb   $FF 
         fcb   $32 2
         fcb   $67 g
         fcb   $39 9
         fcb   $CC L
         fcb   $00 
         fcb   $01 
         fcb   $32 2
         fcb   $67 g
         fcb   $39 9
         fcb   $EC l
         fcb   $E4 d
         fcb   $ED m
         fcb   $62 b
         fcb   $AE .
         fcb   $E4 d
         fcb   $EC l
         fcb   $08 
         fcb   $ED m
         fcb   $E4 d
         fcb   $16 
         fcb   $FF 
         fcb   $9D 
         fcb   $CC L
         fcb   $FF 
         fcb   $FF 
         fcb   $32 2
         fcb   $67 g
         fcb   $39 9
         fcb   $34 4
         fcb   $06 
         fcb   $EC l
         fcb   $E4 d
         fcb   $C3 C
         fcb   $00 
         fcb   $06 
         fcb   $1F 
         fcb   $01 
         fcb   $E6 f
         fcb   $84 
         fcb   $C4 D
         fcb   $08 
         fcb   $5D ]
         fcb   $27 '
         fcb   $07 
         fcb   $AE .
         fcb   $E4 d
         fcb   $EC l
         fcb   $04 
         fcb   $17 
         fcb   $00 
         fcb   $26 &
         fcb   $EC l
         fcb   $E4 d
         fcb   $10 
         fcb   $93 
         fcb   $0A 
         fcb   $27 '
         fcb   $0E 
         fcb   $EC l
         fcb   $E4 d
         fcb   $10 
         fcb   $93 
         fcb   $0C 
         fcb   $27 '
         fcb   $07 
         fcb   $EC l
         fcb   $E4 d
         fcb   $10 
         fcb   $93 
         fcb   $0E 
         fcb   $26 &
         fcb   $03 
         fcb   $32 2
         fcb   $62 b
         fcb   $39 9
         fcb   $EC l
         fcb   $E4 d
         fcb   $17 
         fcb   $00 
         fcb   $09 
         fcb   $32 2
         fcb   $62 b
         fcb   $39 9
         fcb   $16 
         fcb   $03 
         fcb   $5F _
         fcb   $16 
         fcb   $06 
         fcb   $8F 
         fcb   $16 
         fcb   $04 
         fcb   $45 E
         fcb   $34 4
         fcb   $06 
         fcb   $32 2
         fcb   $7E þ
         fcb   $5F _
         fcb   $4F O
         fcb   $ED m
         fcb   $E4 d
         fcb   $AE .
         fcb   $F8 x
         fcb   $02 
         fcb   $E6 f
         fcb   $84 
         fcb   $4F O
         fcb   $17 
         fcb   $00 
         fcb   $28 (
         fcb   $C3 C
         fcb   $00 
         fcb   $00 
         fcb   $27 '
         fcb   $1E 
         fcb   $AE .
         fcb   $F8 x
         fcb   $02 
         fcb   $E6 f
         fcb   $80 
         fcb   $AF /
         fcb   $F8 x
         fcb   $02 
         fcb   $4F O
         fcb   $34 4
         fcb   $06 
         fcb   $EC l
         fcb   $62 b
         fcb   $34 4
         fcb   $06 
         fcb   $CC L
         fcb   $00 
         fcb   $0A 
         fcb   $17 
         fcb   $00 
         fcb   $11 
         fcb   $E3 c
         fcb   $E1 a
         fcb   $83 
         fcb   $00 
         fcb   $30 0
         fcb   $ED m
         fcb   $E4 d
         fcb   $20 
         fcb   $D4 T
         fcb   $EC l
         fcb   $E4 d
         fcb   $32 2
         fcb   $64 d
         fcb   $39 9
         fcb   $16 
         fcb   $04 
         fcb   $C0 @
         fcb   $16 
         fcb   $05 
         fcb   $23 #
         fcb   $34 4
         fcb   $06 
         fcb   $DC \
         fcb   $0C 
         fcb   $34 4
         fcb   $06 
         fcb   $EC l
         fcb   $62 b
         fcb   $17 
         fcb   $00 
         fcb   $05 
         fcb   $32 2
         fcb   $62 b
         fcb   $32 2
         fcb   $62 b
         fcb   $39 9
         fcb   $16 
         fcb   $00 
         fcb   $52 R
         fcb   $34 4
         fcb   $06 
         fcb   $32 2
         fcb   $7B û
         fcb   $5F _
         fcb   $4F O
         fcb   $ED m
         fcb   $E4 d
         fcb   $EC l
         fcb   $65 e
         fcb   $17 
         fcb   $00 
         fcb   $42 B
         fcb   $83 
         fcb   $00 
         fcb   $01 
         fcb   $ED m
         fcb   $62 b
         fcb   $EC l
         fcb   $E4 d
         fcb   $10 
         fcb   $A3 #
         fcb   $62 b
         fcb   $10 
         fcb   $2C ,
         fcb   $00 
         fcb   $31 1
         fcb   $EC l
         fcb   $E4 d
         fcb   $AE .
         fcb   $65 e
         fcb   $E6 f
         fcb   $8B 
         fcb   $E7 g
         fcb   $64 d
         fcb   $EC l
         fcb   $65 e
         fcb   $E3 c
         fcb   $E4 d
         fcb   $34 4
         fcb   $06 
         fcb   $EC l
         fcb   $64 d
         fcb   $AE .
         fcb   $67 g
         fcb   $E6 f
         fcb   $8B 
         fcb   $E7 g
         fcb   $F1 q
         fcb   $EC l
         fcb   $65 e
         fcb   $E3 c
         fcb   $62 b
         fcb   $34 4
         fcb   $06 
         fcb   $E6 f
         fcb   $66 f
         fcb   $E7 g
         fcb   $F1 q
         fcb   $EC l
         fcb   $E4 d
         fcb   $C3 C
         fcb   $00 
         fcb   $01 
         fcb   $ED m
         fcb   $E4 d
         fcb   $EC l
         fcb   $62 b
         fcb   $83 
         fcb   $00 
         fcb   $01 
         fcb   $ED m
         fcb   $62 b
         fcb   $16 
         fcb   $FF 
         fcb   $C6 F
         fcb   $32 2
         fcb   $67 g
         fcb   $39 9
         fcb   $16 
         fcb   $04 
         fcb   $A2 "
         fcb   $34 4
         fcb   $06 
         fcb   $32 2
         fcb   $E9 i
         fcb   $FE 
         fcb   $F9 y
         fcb   $EC l
         fcb   $E9 i
         fcb   $01 
         fcb   $0B 
         fcb   $17 
         fcb   $00 
         fcb   $E1 a
         fcb   $EC l
         fcb   $E9 i
         fcb   $01 
         fcb   $07 
         fcb   $ED m
         fcb   $61 a
         fcb   $30 0
         fcb   $67 g
         fcb   $AF /
         fcb   $63 c
         fcb   $E6 f
         fcb   $F8 x
         fcb   $01 
         fcb   $10 
         fcb   $27 '
         fcb   $00 
         fcb   $90 
         fcb   $E6 f
         fcb   $F8 x
         fcb   $01 
         fcb   $C1 A
         fcb   $0A 
         fcb   $10 
         fcb   $26 &
         fcb   $00 
         fcb   $2F /
         fcb   $C6 F
         fcb   $0D 
         fcb   $E7 g
         fcb   $F8 x
         fcb   $03 
         fcb   $CC L
         fcb   $01 
         fcb   $00 
         fcb   $34 4
         fcb   $06 
         fcb   $30 0
         fcb   $69 i
         fcb   $34 4
         fcb   $10 
         fcb   $AE .
         fcb   $E9 i
         fcb   $01 
         fcb   $0F 
         fcb   $E6 f
         fcb   $07 
         fcb   $4F O
         fcb   $17 
         fcb   $00 
         fcb   $B2 2
         fcb   $32 2
         fcb   $64 d
         fcb   $10 
         fcb   $83 
         fcb   $FF 
         fcb   $FF 
         fcb   $26 &
         fcb   $08 
         fcb   $CC L
         fcb   $FF 
         fcb   $FF 
         fcb   $32 2
         fcb   $E9 i
         fcb   $01 
         fcb   $09 
         fcb   $39 9
         fcb   $30 0
         fcb   $67 g
         fcb   $AF /
         fcb   $63 c
         fcb   $16 
         fcb   $00 
         fcb   $4E N
         fcb   $E6 f
         fcb   $F8 x
         fcb   $01 
         fcb   $C1 A
         fcb   $09 
         fcb   $26 &
         fcb   $36 6
         fcb   $EC l
         fcb   $63 c
         fcb   $30 0
         fcb   $67 g
         fcb   $34 4
         fcb   $10 
         fcb   $A3 #
         fcb   $E1 a
         fcb   $34 4
         fcb   $06 
         fcb   $CC L
         fcb   $00 
         fcb   $08 
         fcb   $17 
         fcb   $00 
         fcb   $8D 
         fcb   $34 4
         fcb   $06 
         fcb   $CC L
         fcb   $00 
         fcb   $08 
         fcb   $A3 #
         fcb   $E1 a
         fcb   $ED m
         fcb   $65 e
         fcb   $EC l
         fcb   $65 e
         fcb   $27 '
         fcb   $2A *
         fcb   $EC l
         fcb   $63 c
         fcb   $C3 C
         fcb   $00 
         fcb   $01 
         fcb   $ED m
         fcb   $63 c
         fcb   $83 
         fcb   $00 
         fcb   $01 
         fcb   $34 4
         fcb   $06 
         fcb   $C6 F
         fcb   $20 
         fcb   $E7 g
         fcb   $F1 q
         fcb   $EC l
         fcb   $65 e
         fcb   $83 
         fcb   $00 
         fcb   $01 
         fcb   $ED m
         fcb   $65 e
         fcb   $20 
         fcb   $E3 c
         fcb   $EC l
         fcb   $63 c
         fcb   $C3 C
         fcb   $00 
         fcb   $01 
         fcb   $ED m
         fcb   $63 c
         fcb   $83 
         fcb   $00 
         fcb   $01 
         fcb   $34 4
         fcb   $06 
         fcb   $E6 f
         fcb   $F8 x
         fcb   $03 
         fcb   $E7 g
         fcb   $F1 q
         fcb   $EC l
         fcb   $61 a
         fcb   $C3 C
         fcb   $00 
         fcb   $01 
         fcb   $ED m
         fcb   $61 a
         fcb   $16 
         fcb   $FF 
         fcb   $69 i
         fcb   $6F o
         fcb   $F8 x
         fcb   $03 
         fcb   $EC l
         fcb   $63 c
         fcb   $30 0
         fcb   $67 g
         fcb   $34 4
         fcb   $10 
         fcb   $10 
         fcb   $A3 #
         fcb   $E1 a
         fcb   $10 
         fcb   $27 '
         fcb   $00 
         fcb   $27 '
         fcb   $30 0
         fcb   $67 g
         fcb   $1F 
         fcb   $10 
         fcb   $17 
         fcb   $00 
         fcb   $32 2
         fcb   $34 4
         fcb   $06 
         fcb   $30 0
         fcb   $69 i
         fcb   $34 4
         fcb   $10 
         fcb   $AE .
         fcb   $E9 i
         fcb   $01 
         fcb   $0F 
         fcb   $E6 f
         fcb   $07 
         fcb   $4F O
         fcb   $17 
         fcb   $00 
         fcb   $1F 
         fcb   $32 2
         fcb   $64 d
         fcb   $10 
         fcb   $83 
         fcb   $FF 
         fcb   $FF 
         fcb   $26 &
         fcb   $08 
         fcb   $CC L
         fcb   $FF 
         fcb   $FF 
         fcb   $32 2
         fcb   $E9 i
         fcb   $01 
         fcb   $09 
         fcb   $39 9
         fcb   $EC l
         fcb   $E9 i
         fcb   $01 
         fcb   $07 
         fcb   $32 2
         fcb   $E9 i
         fcb   $01 
         fcb   $09 
         fcb   $39 9
         fcb   $16 
         fcb   $01 
         fcb   $C4 D
         fcb   $16 
         fcb   $05 
         fcb   $3D =
         fcb   $16 
         fcb   $05 
         fcb   $10 
         fcb   $16 
         fcb   $03 
         fcb   $A8 (
         fcb   $16 
         fcb   $04 
         fcb   $04 
         fcb   $34 4
         fcb   $06 
         fcb   $DC \
         fcb   $0C 
         fcb   $34 4
         fcb   $06 
         fcb   $EC l
         fcb   $62 b
         fcb   $17 
         fcb   $00 
         fcb   $05 
         fcb   $32 2
         fcb   $62 b
         fcb   $32 2
         fcb   $62 b
         fcb   $39 9
         fcb   $34 4
         fcb   $06 
         fcb   $EC l
         fcb   $64 d
         fcb   $C3 C
         fcb   $00 
         fcb   $02 
         fcb   $1F 
         fcb   $01 
         fcb   $EC l
         fcb   $84 
         fcb   $83 
         fcb   $00 
         fcb   $01 
         fcb   $ED m
         fcb   $84 
         fcb   $10 
         fcb   $83 
         fcb   $00 
         fcb   $00 
         fcb   $2D -
         fcb   $15 
         fcb   $EC l
         fcb   $F8 x
         fcb   $04 
         fcb   $C3 C
         fcb   $00 
         fcb   $01 
         fcb   $ED m
         fcb   $F8 x
         fcb   $04 
         fcb   $83 
         fcb   $00 
         fcb   $01 
         fcb   $34 4
         fcb   $06 
         fcb   $E6 f
         fcb   $63 c
         fcb   $E7 g
         fcb   $F1 q
         fcb   $4F O
         fcb   $20 
         fcb   $11 
         fcb   $CC L
         fcb   $00 
         fcb   $01 
         fcb   $34 4
         fcb   $06 
         fcb   $EC l
         fcb   $66 f
         fcb   $34 4
         fcb   $06 
         fcb   $E6 f
         fcb   $65 e
         fcb   $4F O
         fcb   $17 
         fcb   $00 
         fcb   $15 
         fcb   $32 2
         fcb   $64 d
         fcb   $32 2
         fcb   $62 b
         fcb   $39 9
         fcb   $34 4
         fcb   $06 
         fcb   $DC \
         fcb   $0E 
         fcb   $34 4
         fcb   $06 
         fcb   $EC l
         fcb   $62 b
         fcb   $17 
         fcb   $FF 
         fcb   $B6 6
         fcb   $32 2
         fcb   $62 b
         fcb   $32 2
         fcb   $62 b
         fcb   $39 9
         fcb   $34 4
         fcb   $06 
         fcb   $32 2
         fcb   $7D ý
         fcb   $E6 f
         fcb   $64 d
         fcb   $E7 g
         fcb   $62 b
         fcb   $EC l
         fcb   $67 g
         fcb   $C3 C
         fcb   $00 
         fcb   $06 
         fcb   $1F 
         fcb   $01 
         fcb   $E6 f
         fcb   $84 
         fcb   $C4 D
         fcb   $02 
         fcb   $C1 A
         fcb   $00 
         fcb   $27 '
         fcb   $0F 
         fcb   $EC l
         fcb   $67 g
         fcb   $C3 C
         fcb   $00 
         fcb   $06 
         fcb   $1F 
         fcb   $01 
         fcb   $E6 f
         fcb   $84 
         fcb   $C4 D
         fcb   $30 0
         fcb   $C1 A
         fcb   $00 
         fcb   $27 '
         fcb   $06 
         fcb   $CC L
         fcb   $FF 
         fcb   $FF 
         fcb   $32 2
         fcb   $65 e
         fcb   $39 9
         fcb   $E6 f
         fcb   $6A j
         fcb   $27 '
         fcb   $05 
         fcb   $CC L
         fcb   $00 
         fcb   $01 
         fcb   $20 
         fcb   $02 
         fcb   $5F _
         fcb   $4F O
         fcb   $34 4
         fcb   $06 
         fcb   $EC l
         fcb   $69 i
         fcb   $C3 C
         fcb   $00 
         fcb   $02 
         fcb   $34 4
         fcb   $06 
         fcb   $CC L
         fcb   $01 
         fcb   $00 
         fcb   $A3 #
         fcb   $F1 q
         fcb   $A3 #
         fcb   $E1 a
         fcb   $ED m
         fcb   $E4 d
         fcb   $EC l
         fcb   $67 g
         fcb   $C3 C
         fcb   $00 
         fcb   $06 
         fcb   $1F 
         fcb   $01 
         fcb   $E6 f
         fcb   $84 
         fcb   $C4 D
         fcb   $04 
         fcb   $C1 A
         fcb   $00 
         fcb   $10 
         fcb   $26 &
         fcb   $00 
         fcb   $2E .
         fcb   $AE .
         fcb   $67 g
         fcb   $EC l
         fcb   $04 
         fcb   $26 &
         fcb   $28 (
         fcb   $EC l
         fcb   $67 g
         fcb   $C3 C
         fcb   $00 
         fcb   $04 
         fcb   $34 4
         fcb   $06 
         fcb   $CC L
         fcb   $01 
         fcb   $00 
         fcb   $17 
         fcb   $01 
         fcb   $00 
         fcb   $ED m
         fcb   $F1 q
         fcb   $10 
         fcb   $83 
         fcb   $00 
         fcb   $00 
         fcb   $26 &
         fcb   $0F 
         fcb   $EC l
         fcb   $67 g
         fcb   $C3 C
         fcb   $00 
         fcb   $06 
         fcb   $1F 
         fcb   $03 
         fcb   $E6 f
         fcb   $C4 D
         fcb   $CA J
         fcb   $04 
         fcb   $E7 g
         fcb   $C4 D
         fcb   $20 
         fcb   $04 
         fcb   $5F _
         fcb   $4F O
         fcb   $ED m
         fcb   $E4 d
         fcb   $EC l
         fcb   $67 g
         fcb   $C3 C
         fcb   $00 
         fcb   $06 
         fcb   $1F 
         fcb   $01 
         fcb   $E6 f
         fcb   $84 
         fcb   $C4 D
         fcb   $04 
         fcb   $5D ]
         fcb   $10 
         fcb   $27 '
         fcb   $00 
         fcb   $34 4
         fcb   $E6 f
         fcb   $6A j
         fcb   $10 
         fcb   $27 '
         fcb   $00 
         fcb   $5F _
         fcb   $CC L
         fcb   $00 
         fcb   $01 
         fcb   $34 4
         fcb   $06 
         fcb   $30 0
         fcb   $64 d
         fcb   $34 4
         fcb   $10 
         fcb   $AE .
         fcb   $6B k
         fcb   $E6 f
         fcb   $07 
         fcb   $4F O
         fcb   $17 
         fcb   $00 
         fcb   $C1 A
         fcb   $32 2
         fcb   $64 d
         fcb   $10 
         fcb   $83 
         fcb   $FF 
         fcb   $FF 
         fcb   $10 
         fcb   $26 &
         fcb   $00 
         fcb   $44 D
         fcb   $EC l
         fcb   $67 g
         fcb   $C3 C
         fcb   $00 
         fcb   $06 
         fcb   $1F 
         fcb   $03 
         fcb   $E6 f
         fcb   $C4 D
         fcb   $CA J
         fcb   $20 
         fcb   $E7 g
         fcb   $C4 D
         fcb   $CC L
         fcb   $FF 
         fcb   $FF 
         fcb   $32 2
         fcb   $65 e
         fcb   $39 9
         fcb   $EC l
         fcb   $E4 d
         fcb   $27 '
         fcb   $2D -
         fcb   $EC l
         fcb   $E4 d
         fcb   $34 4
         fcb   $06 
         fcb   $AE .
         fcb   $69 i
         fcb   $EC l
         fcb   $04 
         fcb   $34 4
         fcb   $06 
         fcb   $AE .
         fcb   $6B k
         fcb   $E6 f
         fcb   $07 
         fcb   $4F O
         fcb   $17 
         fcb   $00 
         fcb   $8E 
         fcb   $32 2
         fcb   $64 d
         fcb   $10 
         fcb   $83 
         fcb   $FF 
         fcb   $FF 
         fcb   $26 &
         fcb   $13 
         fcb   $EC l
         fcb   $67 g
         fcb   $C3 C
         fcb   $00 
         fcb   $06 
         fcb   $1F 
         fcb   $03 
         fcb   $E6 f
         fcb   $C4 D
         fcb   $CA J
         fcb   $20 
         fcb   $E7 g
         fcb   $C4 D
         fcb   $CC L
         fcb   $FF 
         fcb   $FF 
         fcb   $32 2
         fcb   $65 e
         fcb   $39 9
         fcb   $EC l
         fcb   $67 g
         fcb   $C3 C
         fcb   $00 
         fcb   $02 
         fcb   $34 4
         fcb   $06 
         fcb   $EC l
         fcb   $69 i
         fcb   $C3 C
         fcb   $00 
         fcb   $06 
         fcb   $1F 
         fcb   $01 
         fcb   $E6 f
         fcb   $84 
         fcb   $C4 D
         fcb   $04 
         fcb   $5D ]
         fcb   $27 '
         fcb   $04 
         fcb   $5F _
         fcb   $4F O
         fcb   $20 
         fcb   $03 
         fcb   $CC L
         fcb   $01 
         fcb   $00 
         fcb   $ED m
         fcb   $F1 q
         fcb   $AE .
         fcb   $67 g
         fcb   $EC l
         fcb   $04 
         fcb   $ED m
         fcb   $F8 x
         fcb   $07 
         fcb   $E6 f
         fcb   $6A j
         fcb   $27 '
         fcb   $2D -
         fcb   $EC l
         fcb   $67 g
         fcb   $C3 C
         fcb   $00 
         fcb   $06 
         fcb   $1F 
         fcb   $01 
         fcb   $E6 f
         fcb   $84 
         fcb   $C4 D
         fcb   $04 
         fcb   $C1 A
         fcb   $00 
         fcb   $26 &
         fcb   $1E 
         fcb   $EC l
         fcb   $F8 x
         fcb   $07 
         fcb   $C3 C
         fcb   $00 
         fcb   $01 
         fcb   $ED m
         fcb   $F8 x
         fcb   $07 
         fcb   $83 
         fcb   $00 
         fcb   $01 
         fcb   $34 4
         fcb   $06 
         fcb   $E6 f
         fcb   $66 f
         fcb   $E7 g
         fcb   $F1 q
         fcb   $EC l
         fcb   $67 g
         fcb   $C3 C
         fcb   $00 
         fcb   $02 
         fcb   $34 4
         fcb   $06 
         fcb   $CC L
         fcb   $00 
         fcb   $FF 
         fcb   $ED m
         fcb   $F1 q
         fcb   $E6 f
         fcb   $64 d
         fcb   $4F O
         fcb   $32 2
         fcb   $65 e
         fcb   $39 9
         fcb   $34 4
         fcb   $06 
         fcb   $5F _
         fcb   $4F O
         fcb   $34 4
         fcb   $06 
         fcb   $EC l
         fcb   $62 b
         fcb   $34 4
         fcb   $06 
         fcb   $5F _
         fcb   $4F O
         fcb   $17 
         fcb   $FE 
         fcb   $98 
         fcb   $32 2
         fcb   $64 d
         fcb   $32 2
         fcb   $62 b
         fcb   $39 9
         fcb   $16 
         fcb   $00 
         fcb   $03 
         fcb   $16 
         fcb   $03 
         fcb   $38 8
         fcb   $34 4
         fcb   $06 
         fcb   $32 2
         fcb   $78 x
         fcb   $EC l
         fcb   $68 h
         fcb   $C3 C
         fcb   $00 
         fcb   $03 
         fcb   $44 D
         fcb   $56 V
         fcb   $44 D
         fcb   $56 V
         fcb   $C3 C
         fcb   $00 
         fcb   $01 
         fcb   $ED m
         fcb   $66 f
         fcb   $EC l
         fcb   $A9 )
         fcb   $02 
         fcb   $4F O
         fcb   $ED m
         fcb   $62 b
         fcb   $10 
         fcb   $83 
         fcb   $00 
         fcb   $00 
         fcb   $26 &
         fcb   $14 
         fcb   $30 0
         fcb   $A9 )
         fcb   $02 
         fcb   $4B K
         fcb   $AF /
         fcb   $62 b
         fcb   $AF /
         fcb   $A9 )
         fcb   $02 
         fcb   $4F O
         fcb   $AF /
         fcb   $A9 )
         fcb   $02 
         fcb   $4B K
         fcb   $5F _
         fcb   $4F O
         fcb   $ED m
         fcb   $A9 )
         fcb   $02 
         fcb   $4D M
         fcb   $EC l
         fcb   $F8 x
         fcb   $02 
         fcb   $ED m
         fcb   $E4 d
         fcb   $AE .
         fcb   $E4 d
         fcb   $EC l
         fcb   $02 
         fcb   $10 
         fcb   $A3 #
         fcb   $66 f
         fcb   $10 
         fcb   $25 %
         fcb   $00 
         fcb   $4B K
         fcb   $AE .
         fcb   $E4 d
         fcb   $EC l
         fcb   $02 
         fcb   $10 
         fcb   $A3 #
         fcb   $66 f
         fcb   $26 &
         fcb   $07 
         fcb   $EC l
         fcb   $F4 t
         fcb   $ED m
         fcb   $F8 x
         fcb   $02 
         fcb   $20 
         fcb   $2D -
         fcb   $EC l
         fcb   $E4 d
         fcb   $C3 C
         fcb   $00 
         fcb   $02 
         fcb   $1F 
         fcb   $03 
         fcb   $EC l
         fcb   $C4 D
         fcb   $A3 #
         fcb   $66 f
         fcb   $ED m
         fcb   $C4 D
         fcb   $EC l
         fcb   $E4 d
         fcb   $C3 C
         fcb   $00 
         fcb   $02 
         fcb   $1F 
         fcb   $01 
         fcb   $EC l
         fcb   $84 
         fcb   $58 X
         fcb   $49 I
         fcb   $58 X
         fcb   $49 I
         fcb   $34 4
         fcb   $06 
         fcb   $EC l
         fcb   $62 b
         fcb   $E3 c
         fcb   $E1 a
         fcb   $ED m
         fcb   $E4 d
         fcb   $EC l
         fcb   $E4 d
         fcb   $C3 C
         fcb   $00 
         fcb   $02 
         fcb   $34 4
         fcb   $06 
         fcb   $EC l
         fcb   $68 h
         fcb   $ED m
         fcb   $F1 q
         fcb   $EC l
         fcb   $62 b
         fcb   $ED m
         fcb   $A9 )
         fcb   $02 
         fcb   $4F O
         fcb   $EC l
         fcb   $E4 d
         fcb   $C3 C
         fcb   $00 
         fcb   $04 
         fcb   $32 2
         fcb   $6A j
         fcb   $39 9
         fcb   $EC l
         fcb   $E4 d
         fcb   $10 
         fcb   $A3 #
         fcb   $A9 )
         fcb   $02 
         fcb   $4F O
         fcb   $10 
         fcb   $26 &
         fcb   $00 
         fcb   $2F /
         fcb   $EC l
         fcb   $66 f
         fcb   $58 X
         fcb   $49 I
         fcb   $58 X
         fcb   $49 I
         fcb   $17 
         fcb   $00 
         fcb   $E5 e
         fcb   $ED m
         fcb   $64 d
         fcb   $10 
         fcb   $83 
         fcb   $FF 
         fcb   $FF 
         fcb   $26 &
         fcb   $05 
         fcb   $5F _
         fcb   $4F O
         fcb   $32 2
         fcb   $6A j
         fcb   $39 9
         fcb   $EC l
         fcb   $64 d
         fcb   $C3 C
         fcb   $00 
         fcb   $02 
         fcb   $34 4
         fcb   $06 
         fcb   $EC l
         fcb   $68 h
         fcb   $ED m
         fcb   $F1 q
         fcb   $EC l
         fcb   $64 d
         fcb   $C3 C
         fcb   $00 
         fcb   $04 
         fcb   $17 
         fcb   $00 
         fcb   $11 
         fcb   $EC l
         fcb   $A9 )
         fcb   $02 
         fcb   $4F O
         fcb   $ED m
         fcb   $E4 d
         fcb   $EC l
         fcb   $E4 d
         fcb   $ED m
         fcb   $62 b
         fcb   $EC l
         fcb   $F4 t
         fcb   $ED m
         fcb   $E4 d
         fcb   $16 
         fcb   $FF 
         fcb   $65 e
         fcb   $34 4
         fcb   $06 
         fcb   $32 2
         fcb   $7C ü
         fcb   $EC l
         fcb   $64 d
         fcb   $83 
         fcb   $00 
         fcb   $04 
         fcb   $ED m
         fcb   $E4 d
         fcb   $EC l
         fcb   $A9 )
         fcb   $02 
         fcb   $4F O
         fcb   $ED m
         fcb   $62 b
         fcb   $EC l
         fcb   $E4 d
         fcb   $10 
         fcb   $A3 #
         fcb   $62 b
         fcb   $23 #
         fcb   $08 
         fcb   $EC l
         fcb   $E4 d
         fcb   $10 
         fcb   $A3 #
         fcb   $F8 x
         fcb   $02 
         fcb   $25 %
         fcb   $1F 
         fcb   $EC l
         fcb   $62 b
         fcb   $10 
         fcb   $A3 #
         fcb   $F8 x
         fcb   $02 
         fcb   $25 %
         fcb   $0F 
         fcb   $EC l
         fcb   $E4 d
         fcb   $10 
         fcb   $A3 #
         fcb   $62 b
         fcb   $22 "
         fcb   $10 
         fcb   $EC l
         fcb   $E4 d
         fcb   $10 
         fcb   $A3 #
         fcb   $F8 x
         fcb   $02 
         fcb   $25 %
         fcb   $08 
         fcb   $EC l
         fcb   $F8 x
         fcb   $02 
         fcb   $ED m
         fcb   $62 b
         fcb   $16 
         fcb   $FF 
         fcb   $D2 R
         fcb   $EC l
         fcb   $E4 d
         fcb   $C3 C
         fcb   $00 
         fcb   $02 
         fcb   $1F 
         fcb   $01 
         fcb   $EC l
         fcb   $84 
         fcb   $58 X
         fcb   $49 I
         fcb   $58 X
         fcb   $49 I
         fcb   $E3 c
         fcb   $E4 d
         fcb   $10 
         fcb   $A3 #
         fcb   $F8 x
         fcb   $02 
         fcb   $26 &
         fcb   $1E 
         fcb   $EC l
         fcb   $F8 x
         fcb   $02 
         fcb   $C3 C
         fcb   $00 
         fcb   $02 
         fcb   $34 4
         fcb   $06 
         fcb   $EC l
         fcb   $62 b
         fcb   $C3 C
         fcb   $00 
         fcb   $02 
         fcb   $1F 
         fcb   $03 
         fcb   $EC l
         fcb   $C4 D
         fcb   $E3 c
         fcb   $F1 q
         fcb   $ED m
         fcb   $C4 D
         fcb   $AE .
         fcb   $F8 x
         fcb   $02 
         fcb   $EC l
         fcb   $84 
         fcb   $ED m
         fcb   $F4 t
         fcb   $20 
         fcb   $05 
         fcb   $EC l
         fcb   $F8 x
         fcb   $02 
         fcb   $ED m
         fcb   $F4 t
         fcb   $EC l
         fcb   $62 b
         fcb   $C3 C
         fcb   $00 
         fcb   $02 
         fcb   $1F 
         fcb   $01 
         fcb   $EC l
         fcb   $84 
         fcb   $58 X
         fcb   $49 I
         fcb   $58 X
         fcb   $49 I
         fcb   $E3 c
         fcb   $62 b
         fcb   $10 
         fcb   $A3 #
         fcb   $E4 d
         fcb   $26 &
         fcb   $1B 
         fcb   $EC l
         fcb   $E4 d
         fcb   $C3 C
         fcb   $00 
         fcb   $02 
         fcb   $34 4
         fcb   $06 
         fcb   $EC l
         fcb   $64 d
         fcb   $C3 C
         fcb   $00 
         fcb   $02 
         fcb   $1F 
         fcb   $03 
         fcb   $EC l
         fcb   $C4 D
         fcb   $E3 c
         fcb   $F1 q
         fcb   $ED m
         fcb   $C4 D
         fcb   $EC l
         fcb   $F4 t
         fcb   $ED m
         fcb   $F8 x
         fcb   $02 
         fcb   $20 
         fcb   $05 
         fcb   $EC l
         fcb   $E4 d
         fcb   $ED m
         fcb   $F8 x
         fcb   $02 
         fcb   $EC l
         fcb   $62 b
         fcb   $ED m
         fcb   $A9 )
         fcb   $02 
         fcb   $4F O
         fcb   $32 2
         fcb   $66 f
         fcb   $39 9
         fcb   $16 
         fcb   $01 
         fcb   $48 H
         fcb   $34 4
         fcb   $06 
         fcb   $E6 f
         fcb   $61 a
         fcb   $C1 A
         fcb   $30 0
         fcb   $25 %
         fcb   $0A 
         fcb   $E6 f
         fcb   $61 a
         fcb   $C1 A
         fcb   $39 9
         fcb   $22 "
         fcb   $04 
         fcb   $C6 F
         fcb   $01 
         fcb   $20 
         fcb   $01 
         fcb   $5F _
         fcb   $4F O
         fcb   $32 2
         fcb   $62 b
         fcb   $39 9
         fcb   $34 4
         fcb   $06 
         fcb   $E6 f
         fcb   $61 a
         fcb   $4F O
         fcb   $17 
         fcb   $00 
         fcb   $11 
         fcb   $C3 C
         fcb   $00 
         fcb   $00 
         fcb   $27 '
         fcb   $06 
         fcb   $E6 f
         fcb   $61 a
         fcb   $CB K
         fcb   $20 
         fcb   $20 
         fcb   $02 
         fcb   $E6 f
         fcb   $61 a
         fcb   $4F O
         fcb   $32 2
         fcb   $62 b
         fcb   $39 9
         fcb   $16 
         fcb   $00 
         fcb   $00 
         fcb   $34 4
         fcb   $06 
         fcb   $E6 f
         fcb   $61 a
         fcb   $C1 A
         fcb   $41 A
         fcb   $25 %
         fcb   $0A 
         fcb   $E6 f
         fcb   $61 a
         fcb   $C1 A
         fcb   $5A Z
         fcb   $22 "
         fcb   $04 
         fcb   $C6 F
         fcb   $01 
         fcb   $20 
         fcb   $01 
         fcb   $5F _
         fcb   $4F O
         fcb   $32 2
         fcb   $62 b
         fcb   $39 9
         fcb   $34 4
         fcb   $06 
         fcb   $32 2
         fcb   $7E þ
         fcb   $EC l
         fcb   $62 b
         fcb   $ED m
         fcb   $E4 d
         fcb   $E6 f
         fcb   $F4 t
         fcb   $27 '
         fcb   $09 
         fcb   $EC l
         fcb   $E4 d
         fcb   $C3 C
         fcb   $00 
         fcb   $01 
         fcb   $ED m
         fcb   $E4 d
         fcb   $20 
         fcb   $F3 s
         fcb   $EC l
         fcb   $E4 d
         fcb   $A3 #
         fcb   $62 b
         fcb   $32 2
         fcb   $64 d
         fcb   $39 9
         fcb   $32 2
         fcb   $7B û
         fcb   $6F o
         fcb   $E4 d
         fcb   $8D 
         fcb   $33 3
         fcb   $ED m
         fcb   $61 a
         fcb   $EC l
         fcb   $67 g
         fcb   $8D 
         fcb   $2D -
         fcb   $ED m
         fcb   $67 g
         fcb   $A6 &
         fcb   $62 b
         fcb   $E6 f
         fcb   $68 h
         fcb   $3D =
         fcb   $ED m
         fcb   $63 c
         fcb   $A6 &
         fcb   $61 a
         fcb   $E6 f
         fcb   $68 h
         fcb   $3D =
         fcb   $1F 
         fcb   $98 
         fcb   $5F _
         fcb   $E3 c
         fcb   $63 c
         fcb   $ED m
         fcb   $63 c
         fcb   $A6 &
         fcb   $62 b
         fcb   $E6 f
         fcb   $67 g
         fcb   $3D =
         fcb   $1F 
         fcb   $98 
         fcb   $5F _
         fcb   $E3 c
         fcb   $63 c
         fcb   $6D m
         fcb   $E4 d
         fcb   $2A *
         fcb   $04 
         fcb   $40 @
         fcb   $50 P
         fcb   $82 
         fcb   $00 
         fcb   $AE .
         fcb   $65 e
         fcb   $32 2
         fcb   $69 i
         fcb   $6E n
         fcb   $84 
         fcb   $4D M
         fcb   $2A *
         fcb   $06 
         fcb   $63 c
         fcb   $62 b
         fcb   $40 @
         fcb   $50 P
         fcb   $82 
         fcb   $00 
         fcb   $39 9
         fcb   $AE .
         fcb   $62 b
         fcb   $8D 
         fcb   $7B û
         fcb   $34 4
         fcb   $01 
         fcb   $AF /
         fcb   $63 c
         fcb   $35 5
         fcb   $01 
         fcb   $20 
         fcb   $02 
         fcb   $1C 
         fcb   $F7 w
         fcb   $1A 
         fcb   $01 
         fcb   $34 4
         fcb   $01 
         fcb   $8E 
         fcb   $00 
         fcb   $00 
         fcb   $35 5
         fcb   $01 
         fcb   $20 
         fcb   $14 
         fcb   $AE .
         fcb   $62 b
         fcb   $8D 
         fcb   $62 b
         fcb   $34 4
         fcb   $01 
         fcb   $AF /
         fcb   $63 c
         fcb   $8E 
         fcb   $7F ÿ
         fcb   $FF 
         fcb   $35 5
         fcb   $01 
         fcb   $20 
         fcb   $05 
         fcb   $8E 
         fcb   $FF 
         fcb   $FF 
         fcb   $1C 
         fcb   $F6 v
         fcb   $32 2
         fcb   $7D ý
         fcb   $34 4
         fcb   $01 
         fcb   $ED m
         fcb   $62 b
         fcb   $26 &
         fcb   $06 
         fcb   $35 5
         fcb   $01 
         fcb   $1F 
         fcb   $10 
         fcb   $20 
         fcb   $3E >
         fcb   $86 
         fcb   $01 
         fcb   $A7 '
         fcb   $61 a
         fcb   $6D m
         fcb   $62 b
         fcb   $2B +
         fcb   $08 
         fcb   $68 h
         fcb   $63 c
         fcb   $69 i
         fcb   $62 b
         fcb   $6C l
         fcb   $61 a
         fcb   $20 
         fcb   $F4 t
         fcb   $EC l
         fcb   $66 f
         fcb   $6F o
         fcb   $66 f
         fcb   $6F o
         fcb   $67 g
         fcb   $A3 #
         fcb   $62 b
         fcb   $24 $
         fcb   $06 
         fcb   $E3 c
         fcb   $62 b
         fcb   $1C 
         fcb   $FE 
         fcb   $20 
         fcb   $02 
         fcb   $1A 
         fcb   $01 
         fcb   $69 i
         fcb   $67 g
         fcb   $69 i
         fcb   $66 f
         fcb   $64 d
         fcb   $62 b
         fcb   $66 f
         fcb   $63 c
         fcb   $6A j
         fcb   $61 a
         fcb   $26 &
         fcb   $E8 h
         fcb   $35 5
         fcb   $01 
         fcb   $25 %
         fcb   $06 
         fcb   $34 4
         fcb   $01 
         fcb   $EC l
         fcb   $66 f
         fcb   $35 5
         fcb   $01 
         fcb   $2A *
         fcb   $04 
         fcb   $40 @
         fcb   $50 P
         fcb   $82 
         fcb   $00 
         fcb   $AE .
         fcb   $63 c
         fcb   $32 2
         fcb   $67 g
         fcb   $6E n
         fcb   $84 
         fcb   $34 4
         fcb   $40 @
         fcb   $1F 
         fcb   $03 
         fcb   $34 4
         fcb   $10 
         fcb   $A8 (
         fcb   $E1 a
         fcb   $1C 
         fcb   $FE 
         fcb   $34 4
         fcb   $01 
         fcb   $1F 
         fcb   $10 
         fcb   $8D 
         fcb   $08 
         fcb   $1F 
         fcb   $01 
         fcb   $1F 
         fcb   $30 0
         fcb   $8D 
         fcb   $02 
         fcb   $35 5
         fcb   $C1 A
         fcb   $4D M
         fcb   $2A *
         fcb   $04 
         fcb   $40 @
         fcb   $50 P
         fcb   $82 
         fcb   $00 
         fcb   $39 9
         fcb   $34 4
         fcb   $06 
         fcb   $30 0
         fcb   $A9 )
         fcb   $FF 
         fcb   $03 
         fcb   $1F 
         fcb   $10 
         fcb   $40 @
         fcb   $50 P
         fcb   $82 
         fcb   $00 
         fcb   $D3 S
         fcb   $00 
         fcb   $E3 c
         fcb   $E4 d
         fcb   $34 4
         fcb   $20 
         fcb   $10 
         fcb   $3F ?
         fcb   $07 
         fcb   $35 5
         fcb   $20 
         fcb   $35 5
         fcb   $10 
         fcb   $25 %
         fcb   $07 
         fcb   $DC \
         fcb   $00 
         fcb   $30 0
         fcb   $8B 
         fcb   $9F 
         fcb   $00 
         fcb   $39 9
         fcb   $4F O
         fcb   $DD ]
         fcb   $02 
         fcb   $CC L
         fcb   $FF 
         fcb   $FF 
         fcb   $39 9
         fcb   $1F 
         fcb   $01 
         fcb   $86 
         fcb   $01 
         fcb   $10 
         fcb   $3F ?
         fcb   $86 
         fcb   $24 $
         fcb   $06 
         fcb   $DD ]
         fcb   $02 
         fcb   $CC L
         fcb   $FF 
         fcb   $FF 
         fcb   $39 9
         fcb   $4F O
         fcb   $5F _
         fcb   $39 9
         fcb   $1F 
         fcb   $01 
         fcb   $A6 &
         fcb   $63 c
         fcb   $10 
         fcb   $3F ?
         fcb   $84 
         fcb   $25 %
         fcb   $62 b
         fcb   $1F 
         fcb   $89 
         fcb   $4F O
         fcb   $39 9
         fcb   $1F 
         fcb   $98 
         fcb   $10 
         fcb   $3F ?
         fcb   $8F 
         fcb   $25 %
         fcb   $57 W
         fcb   $4F O
         fcb   $5F _
         fcb   $39 9
         fcb   $34 4
         fcb   $20 
         fcb   $1F 
         fcb   $98 
         fcb   $AE .
         fcb   $64 d
         fcb   $10 
         fcb   $AE .
         fcb   $66 f
         fcb   $10 
         fcb   $3F ?
         fcb   $89 
         fcb   $35 5
         fcb   $10 
         fcb   $1E 
         fcb   $12 
         fcb   $25 %
         fcb   $42 B
         fcb   $1F 
         fcb   $10 
         fcb   $39 9
         fcb   $34 4
         fcb   $20 
         fcb   $1F 
         fcb   $98 
         fcb   $AE .
         fcb   $64 d
         fcb   $10 
         fcb   $AE .
         fcb   $66 f
         fcb   $10 
         fcb   $3F ?
         fcb   $8A 
         fcb   $35 5
         fcb   $10 
         fcb   $1E 
         fcb   $12 
         fcb   $25 %
         fcb   $2D -
         fcb   $1F 
         fcb   $10 
         fcb   $39 9
         fcb   $34 4
         fcb   $20 
         fcb   $1F 
         fcb   $98 
         fcb   $AE .
         fcb   $64 d
         fcb   $10 
         fcb   $AE .
         fcb   $66 f
         fcb   $10 
         fcb   $3F ?
         fcb   $8B 
         fcb   $35 5
         fcb   $10 
         fcb   $1E 
         fcb   $12 
         fcb   $25 %
         fcb   $18 
         fcb   $1F 
         fcb   $10 
         fcb   $39 9
         fcb   $34 4
         fcb   $20 
         fcb   $1F 
         fcb   $98 
         fcb   $AE .
         fcb   $64 d
         fcb   $10 
         fcb   $AE .
         fcb   $66 f
         fcb   $10 
         fcb   $3F ?
         fcb   $8C 
         fcb   $35 5
         fcb   $10 
         fcb   $1E 
         fcb   $12 
         fcb   $25 %
         fcb   $03 
         fcb   $1F 
         fcb   $10 
         fcb   $39 9
         fcb   $4F O
         fcb   $DD ]
         fcb   $02 
         fcb   $CC L
         fcb   $FF 
         fcb   $FF 
         fcb   $39 9
         fcb   $1F 
         fcb   $01 
         fcb   $86 
         fcb   $02 
         fcb   $E6 f
         fcb   $63 c
         fcb   $2B +
         fcb   $04 
         fcb   $1F 
         fcb   $98 
         fcb   $84 
         fcb   $03 
         fcb   $CA J
         fcb   $01 
         fcb   $34 4
         fcb   $16 
         fcb   $10 
         fcb   $3F ?
         fcb   $83 
         fcb   $35 5
         fcb   $50 P
         fcb   $1E 
         fcb   $13 
         fcb   $24 $
         fcb   $10 
         fcb   $34 4
         fcb   $10 
         fcb   $10 
         fcb   $3F ?
         fcb   $87 
         fcb   $35 5
         fcb   $10 
         fcb   $25 %
         fcb   $D7 W
         fcb   $1F 
         fcb   $30 0
         fcb   $10 
         fcb   $3F ?
         fcb   $83 
         fcb   $25 %
         fcb   $D0 P
         fcb   $1F 
         fcb   $89 
         fcb   $4F O
         fcb   $39 9
         fcb   $34 4
         fcb   $06 
         fcb   $AE .
         fcb   $64 d
         fcb   $EC l
         fcb   $84 
         fcb   $ED m
         fcb   $64 d
         fcb   $5F _
         fcb   $A6 &
         fcb   $02 
         fcb   $E3 c
         fcb   $66 f
         fcb   $ED m
         fcb   $66 f
         fcb   $35 5
         fcb   $06 
         fcb   $1F 
         fcb   $98 
         fcb   $E6 f
         fcb   $67 g
         fcb   $AE .
         fcb   $62 b
         fcb   $EE n
         fcb   $64 d
         fcb   $5A Z
         fcb   $26 &
         fcb   $09 
         fcb   $C6 F
         fcb   $05 
         fcb   $10 
         fcb   $3F ?
         fcb   $8D 
         fcb   $25 %
         fcb   $A9 )
         fcb   $20 
         fcb   $0A 
         fcb   $5A Z
         fcb   $26 &
         fcb   $15 
         fcb   $C6 F
         fcb   $02 
         fcb   $10 
         fcb   $3F ?
         fcb   $8D 
         fcb   $25 %
         fcb   $9D 
         fcb   $1E 
         fcb   $03 
         fcb   $E3 c
         fcb   $64 d
         fcb   $1E 
         fcb   $03 
         fcb   $1E 
         fcb   $01 
         fcb   $E9 i
         fcb   $63 c
         fcb   $A9 )
         fcb   $62 b
         fcb   $1E 
         fcb   $01 
         fcb   $10 
         fcb   $3F ?
         fcb   $88 
         fcb   $25 %
         fcb   $8A 
         fcb   $4F O
         fcb   $5F _
         fcb   $39 9
         fcb   $1F 
         fcb   $01 
         fcb   $10 
         fcb   $3F ?
         fcb   $87 
         fcb   $25 %
         fcb   $80 
         fcb   $4F O
         fcb   $5F _
         fcb   $39 9
         fcb   $10 
         fcb   $3F ?
         fcb   $06 
name     equ   *
         fcs   /dsave/
         fcb   $02 
         emod
eom      equ   *
