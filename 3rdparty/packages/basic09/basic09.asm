********************************************************************
* progname - program module
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

         nam   Basic09
         ttl   program module       

* Disassembled 02/04/06 16:19:46 by Disasm v1.6 (C) 1988 by RML

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
u001E    rmb   1
u001F    rmb   1
u0020    rmb   1
u0021    rmb   1
u0022    rmb   1
u0023    rmb   2
u0025    rmb   1
u0026    rmb   1
u0027    rmb   3
u002A    rmb   2
u002C    rmb   1
u002D    rmb   1
u002E    rmb   1
u002F    rmb   1
u0030    rmb   1
u0031    rmb   1
u0032    rmb   1
u0033    rmb   1
u0034    rmb   1
u0035    rmb   1
u0036    rmb   1
u0037    rmb   2
u0039    rmb   1
u003A    rmb   1
u003B    rmb   1
u003C    rmb   1
u003D    rmb   1
u003E    rmb   1
u003F    rmb   1
u0040    rmb   2
u0042    rmb   1
u0043    rmb   1
u0044    rmb   1
u0045    rmb   1
u0046    rmb   2
u0048    rmb   1
u0049    rmb   1
u004A    rmb   1
u004B    rmb   1
u004C    rmb   1
u004D    rmb   1
u004E    rmb   2
u0050    rmb   1
u0051    rmb   1
u0052    rmb   1
u0053    rmb   1
u0054    rmb   1
u0055    rmb   1
u0056    rmb   1
u0057    rmb   1
u0058    rmb   1
u0059    rmb   1
u005A    rmb   2
u005C    rmb   2
u005E    rmb   1
u005F    rmb   1
u0060    rmb   1
u0061    rmb   1
u0062    rmb   2
u0064    rmb   2
u0066    rmb   1
u0067    rmb   1
u0068    rmb   1
u0069    rmb   1
u006A    rmb   1
u006B    rmb   1
u006C    rmb   1
u006D    rmb   1
u006E    rmb   1
u006F    rmb   1
u0070    rmb   2
u0072    rmb   2
u0074    rmb   1
u0075    rmb   1
u0076    rmb   1
u0077    rmb   1
u0078    rmb   1
u0079    rmb   1
u007A    rmb   1
u007B    rmb   1
u007C    rmb   1
u007D    rmb   1
u007E    rmb   1
u007F    rmb   1
u0080    rmb   1
u0081    rmb   1
u0082    rmb   1
u0083    rmb   1
u0084    rmb   1
u0085    rmb   1
u0086    rmb   1
u0087    rmb   1
u0088    rmb   1
u0089    rmb   1
u008A    rmb   1
u008B    rmb   1
u008C    rmb   2
u008E    rmb   2
u0090    rmb   1
u0091    rmb   1
u0092    rmb   2
u0094    rmb   1
u0095    rmb   1
u0096    rmb   1
u0097    rmb   1
u0098    rmb   1
u0099    rmb   1
u009A    rmb   1
u009B    rmb   1
u009C    rmb   1
u009D    rmb   1
u009E    rmb   1
u009F    rmb   1
u00A0    rmb   1
u00A1    rmb   1
u00A2    rmb   1
u00A3    rmb   1
u00A4    rmb   1
u00A5    rmb   1
u00A6    rmb   1
u00A7    rmb   1
u00A8    rmb   1
u00A9    rmb   1
u00AA    rmb   1
u00AB    rmb   1
u00AC    rmb   1
u00AD    rmb   1
u00AE    rmb   1
u00AF    rmb   1
u00B0    rmb   1
u00B1    rmb   2
u00B3    rmb   1
u00B4    rmb   1
u00B5    rmb   2
u00B7    rmb   2
u00B9    rmb   1
u00BA    rmb   1
u00BB    rmb   1
u00BC    rmb   1
u00BD    rmb   1
u00BE    rmb   1
u00BF    rmb   2
u00C1    rmb   2
u00C3    rmb   2
u00C5    rmb   1
u00C6    rmb   1
u00C7    rmb   1
u00C8    rmb   2
u00CA    rmb   1
u00CB    rmb   1
u00CC    rmb   1
u00CD    rmb   1
u00CE    rmb   1
u00CF    rmb   1
u00D0    rmb   1
u00D1    rmb   1
u00D2    rmb   1
u00D3    rmb   1
u00D4    rmb   2
u00D6    rmb   2
u00D8    rmb   1
u00D9    rmb   1
u00DA    rmb   1
u00DB    rmb   1
u00DC    rmb   1
u00DD    rmb   1
u00DE    rmb   1
u00DF    rmb   1
u00E0    rmb   1
u00E1    rmb   1
u00E2    rmb   2
u00E4    rmb   1
u00E5    rmb   1
u00E6    rmb   2
u00E8    rmb   2
u00EA    rmb   1
u00EB    rmb   4
u00EF    rmb   3
u00F2    rmb   1
u00F3    rmb   2
u00F5    rmb   4
u00F9    rmb   1
u00FA    rmb   4
u00FE    rmb   1
u00FF    rmb   1
u0100    rmb   3840
size     equ   .
L000D    fcb   $00 
         fcb   $C5 E
         fcb   $1C 
         fcb   $8E 
         fcb   $25 %
         fcb   $43 C
         fcb   $31 1
         fcb   $D1 Q
         fcb   $3B ;
         fcb   $F2 r
         fcb   $50 P
         fcb   $6D m
         fcb   $00 
         fcb   $00 
name     equ   *
L001B    fcs   /Basic09/
         fcb   $16 
         fcb   $07 
L0024    fcb   $0C 
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
         fcb   $20 
         fcb   $42 B
         fcb   $41 A
         fcb   $53 S
         fcb   $49 I
         fcb   $43 C
         fcb   $30 0
         fcb   $39 9
         fcb   $0A 
         fcb   $43 C
         fcb   $4F O
         fcb   $50 P
         fcb   $59 Y
         fcb   $52 R
         fcb   $49 I
         fcb   $47 G
         fcb   $48 H
         fcb   $54 T
         fcb   $20 
         fcb   $31 1
         fcb   $39 9
         fcb   $38 8
         fcb   $30 0
         fcb   $20 
         fcb   $42 B
         fcb   $59 Y
         fcb   $20 
         fcb   $4D M
         fcb   $4F O
         fcb   $54 T
         fcb   $4F O
         fcb   $52 R
         fcb   $4F O
         fcb   $4C L
         fcb   $41 A
         fcb   $20 
         fcb   $49 I
         fcb   $4E N
         fcb   $43 C
         fcb   $2E .
         fcb   $0A 
         fcb   $20 
         fcb   $20 
         fcb   $41 A
         fcb   $4E N
         fcb   $44 D
         fcb   $20 
         fcb   $4D M
         fcb   $49 I
         fcb   $43 C
         fcb   $52 R
         fcb   $4F O
         fcb   $57 W
         fcb   $41 A
         fcb   $52 R
         fcb   $45 E
         fcb   $20 
         fcb   $53 S
         fcb   $59 Y
         fcb   $53 S
         fcb   $54 T
         fcb   $45 E
         fcb   $4D M
         fcb   $53 S
         fcb   $20 
         fcb   $43 C
         fcb   $4F O
         fcb   $52 R
         fcb   $50 P
         fcb   $2E .
         fcb   $0A 
         fcb   $20 
         fcb   $20 
         fcb   $20 
         fcb   $52 R
         fcb   $45 E
         fcb   $50 P
         fcb   $52 R
         fcb   $4F O
         fcb   $44 D
         fcb   $55 U
         fcb   $43 C
         fcb   $45 E
         fcb   $44 D
         fcb   $20 
         fcb   $55 U
         fcb   $4E N
         fcb   $44 D
         fcb   $45 E
         fcb   $52 R
         fcb   $20 
         fcb   $4C L
         fcb   $49 I
         fcb   $43 C
         fcb   $45 E
         fcb   $4E N
         fcb   $53 S
         fcb   $45 E
         fcb   $0A 
         fcb   $20 
         fcb   $20 
         fcb   $20 
         fcb   $20 
         fcb   $20 
         fcb   $54 T
         fcb   $4F O
         fcb   $20 
         fcb   $44 D
         fcb   $52 R
         fcb   $41 A
         fcb   $47 G
         fcb   $4F O
         fcb   $4E N
         fcb   $20 
         fcb   $44 D
         fcb   $41 A
         fcb   $54 T
         fcb   $41 A
         fcb   $20 
         fcb   $4C L
         fcb   $54 T
         fcb   $44 D
         fcb   $2E .
         fcb   $0A 
         fcb   $20 
         fcb   $20 
         fcb   $20 
         fcb   $20 
         fcb   $41 A
         fcb   $4C L
         fcb   $4C L
         fcb   $20 
         fcb   $52 R
         fcb   $49 I
         fcb   $47 G
         fcb   $48 H
         fcb   $54 T
         fcb   $53 S
         fcb   $20 
         fcb   $52 R
         fcb   $45 E
         fcb   $53 S
         fcb   $45 E
         fcb   $52 R
         fcb   $56 V
         fcb   $45 E
         fcb   $44 D
         fcb   $2E .
         fcb   $8A 
         fcb   $34 4
         fcb   $16 
         fcb   $E6 f
         fcb   $F8 x
         fcb   $04 
         fcb   $30 0
         fcb   $8C 
         fcb   $08 
         fcb   $EC l
         fcb   $85 
         fcb   $30 0
         fcb   $8B 
         fcb   $AF /
         fcb   $64 d
         fcb   $35 5
         fcb   $96 
         fcb   $0E 
         fcb   $A5 %
         fcb   $11 
         fcb   $9B 
         fcb   $07 
         fcb   $AD -
         fcb   $07 
         fcb   $A3 #
         fcb   $17 
         fcb   $D2 R
         fcb   $0D 
         fcb   $87 
         fcb   $0D 
         fcb   $81 
         fcb   $0D 
         fcb   $A3 #
         fcb   $1A 
         fcb   $B6 6
         fcb   $12 
         fcb   $0D 
         fcb   $18 
         fcb   $C5 E
         fcb   $10 
         fcb   $20 
         fcb   $0F 
         fcb   $3A :
         fcb   $0F 
         fcb   $C0 @
         fcb   $0F 
         fcb   $C5 E
L00F3    fcb   $9D 
         fcb   $1E 
         fcb   $04 
L00F6    fcb   $9D 
         fcb   $1E 
         fcb   $02 
L00F9    fcb   $9D 
         fcb   $1E 
         fcb   $00 
L00FC    fcb   $9D 
         fcb   $21 !
         fcb   $00 
L00FF    fcb   $9D 
         fcb   $24 $
         fcb   $00 
L0102    fcb   $9D 
         fcb   $24 $
         fcb   $04 
L0105    fcb   $9D 
         fcb   $24 $
         fcb   $02 
L0108    fcb   $9D 
         fcb   $2A *
         fcb   $02 
L010B    fcb   $9D 
         fcb   $1E 
         fcb   $0A 
L010E    fcb   $9D 
         fcb   $1E 
         fcb   $06 
L0111    fcb   $9D 
         fcb   $21 !
         fcb   $02 
L0114    fcb   $9D 
         fcb   $21 !
         fcb   $06 
L0117    fcb   $9D 
         fcb   $21 !
         fcb   $04 
         fcb   $9D 
         fcb   $24 $
         fcb   $0A 
L011D    fcb   $9D 
         fcb   $24 $
         fcb   $0C 
L0120    fcb   $9D 
         fcb   $24 $
         fcb   $08 
L0123    fcb   $9D 
         fcb   $2A *
         fcb   $00 
         fcb   $00 
         fcb   $72 r
         fcb   $02 
L0129    fcb   $01 
         fcb   $01 
         fcb   $50 P
         fcb   $41 A
         fcb   $52 R
         fcb   $41 A
         fcb   $CD M
         fcb   $02 
         fcb   $01 
         fcb   $54 T
         fcb   $59 Y
         fcb   $50 P
         fcb   $C5 E
         fcb   $03 
         fcb   $01 
         fcb   $44 D
         fcb   $49 I
         fcb   $CD M
         fcb   $04 
         fcb   $01 
         fcb   $44 D
         fcb   $41 A
         fcb   $54 T
         fcb   $C1 A
         fcb   $05 
         fcb   $01 
         fcb   $53 S
         fcb   $54 T
         fcb   $4F O
         fcb   $D0 P
         fcb   $06 
         fcb   $01 
         fcb   $42 B
         fcb   $59 Y
         fcb   $C5 E
         fcb   $07 
         fcb   $01 
         fcb   $54 T
         fcb   $52 R
         fcb   $4F O
         fcb   $CE N
         fcb   $08 
         fcb   $01 
         fcb   $54 T
         fcb   $52 R
         fcb   $4F O
         fcb   $46 F
         fcb   $C6 F
         fcb   $09 
         fcb   $01 
         fcb   $50 P
         fcb   $41 A
         fcb   $55 U
         fcb   $53 S
         fcb   $C5 E
         fcb   $0A 
         fcb   $01 
         fcb   $44 D
         fcb   $45 E
         fcb   $C7 G
         fcb   $0B 
         fcb   $01 
         fcb   $52 R
         fcb   $41 A
         fcb   $C4 D
         fcb   $0C 
         fcb   $01 
         fcb   $52 R
         fcb   $45 E
         fcb   $54 T
         fcb   $55 U
         fcb   $52 R
         fcb   $CE N
         fcb   $0D 
         fcb   $01 
         fcb   $4C L
         fcb   $45 E
         fcb   $D4 T
         fcb   $0F 
         fcb   $01 
         fcb   $50 P
         fcb   $4F O
         fcb   $4B K
         fcb   $C5 E
         fcb   $10 
         fcb   $01 
         fcb   $49 I
         fcb   $C6 F
         fcb   $11 
         fcb   $01 
         fcb   $45 E
         fcb   $4C L
         fcb   $53 S
         fcb   $C5 E
         fcb   $12 
         fcb   $01 
         fcb   $45 E
         fcb   $4E N
         fcb   $44 D
         fcb   $49 I
         fcb   $C6 F
         fcb   $13 
         fcb   $01 
         fcb   $46 F
         fcb   $4F O
         fcb   $D2 R
         fcb   $14 
         fcb   $01 
L0195    fcb   $4E N
         fcb   $45 E
         fcb   $58 X
         fcb   $D4 T
         fcb   $15 
         fcb   $01 
         fcb   $57 W
         fcb   $48 H
         fcb   $49 I
         fcb   $4C L
         fcb   $C5 E
         fcb   $16 
         fcb   $01 
         fcb   $45 E
         fcb   $4E N
         fcb   $44 D
         fcb   $57 W
         fcb   $48 H
         fcb   $49 I
         fcb   $4C L
         fcb   $C5 E
         fcb   $17 
         fcb   $01 
         fcb   $52 R
         fcb   $45 E
         fcb   $50 P
         fcb   $45 E
         fcb   $41 A
         fcb   $D4 T
         fcb   $18 
         fcb   $01 
         fcb   $55 U
         fcb   $4E N
         fcb   $54 T
         fcb   $49 I
         fcb   $CC L
         fcb   $19 
         fcb   $01 
         fcb   $4C L
         fcb   $4F O
         fcb   $4F O
         fcb   $D0 P
         fcb   $1A 
         fcb   $01 
         fcb   $45 E
         fcb   $4E N
         fcb   $44 D
         fcb   $4C L
         fcb   $4F O
         fcb   $4F O
         fcb   $D0 P
         fcb   $1B 
         fcb   $01 
         fcb   $45 E
         fcb   $58 X
         fcb   $49 I
         fcb   $54 T
         fcb   $49 I
         fcb   $C6 F
         fcb   $1C 
         fcb   $01 
         fcb   $45 E
         fcb   $4E N
         fcb   $44 D
         fcb   $45 E
         fcb   $58 X
         fcb   $49 I
         fcb   $D4 T
         fcb   $1D 
         fcb   $01 
         fcb   $4F O
         fcb   $CE N
         fcb   $1E 
         fcb   $01 
         fcb   $45 E
         fcb   $52 R
         fcb   $52 R
         fcb   $4F O
         fcb   $D2 R
         fcb   $1F 
         fcb   $01 
L01E6    fcb   $47 G
         fcb   $4F O
         fcb   $54 T
         fcb   $CF O
         fcb   $21 !
         fcb   $01 
L01EC    fcb   $47 G
         fcb   $4F O
         fcb   $53 S
         fcb   $55 U
         fcb   $C2 B
         fcb   $23 #
         fcb   $01 
L01F3    fcb   $52 R
         fcb   $55 U
         fcb   $CE N
         fcb   $24 $
         fcb   $01 
         fcb   $4B K
         fcb   $49 I
         fcb   $4C L
         fcb   $CC L
         fcb   $25 %
         fcb   $01 
         fcb   $49 I
         fcb   $4E N
         fcb   $50 P
         fcb   $55 U
         fcb   $D4 T
         fcb   $26 &
         fcb   $01 
         fcb   $50 P
         fcb   $52 R
         fcb   $49 I
         fcb   $4E N
         fcb   $D4 T
         fcb   $27 '
         fcb   $01 
         fcb   $43 C
         fcb   $48 H
         fcb   $C4 D
         fcb   $28 (
         fcb   $01 
         fcb   $43 C
         fcb   $48 H
         fcb   $D8 X
         fcb   $29 )
         fcb   $01 
         fcb   $43 C
         fcb   $52 R
         fcb   $45 E
         fcb   $41 A
         fcb   $54 T
         fcb   $C5 E
         fcb   $2A *
         fcb   $01 
         fcb   $4F O
         fcb   $50 P
         fcb   $45 E
         fcb   $CE N
         fcb   $2B +
         fcb   $01 
         fcb   $53 S
         fcb   $45 E
         fcb   $45 E
         fcb   $CB K
         fcb   $2C ,
         fcb   $01 
         fcb   $52 R
         fcb   $45 E
         fcb   $41 A
         fcb   $C4 D
         fcb   $2D -
         fcb   $01 
         fcb   $57 W
         fcb   $52 R
         fcb   $49 I
         fcb   $54 T
         fcb   $C5 E
         fcb   $2E .
         fcb   $01 
         fcb   $47 G
         fcb   $45 E
         fcb   $D4 T
         fcb   $2F /
         fcb   $01 
         fcb   $50 P
         fcb   $55 U
         fcb   $D4 T
         fcb   $30 0
         fcb   $01 
         fcb   $43 C
         fcb   $4C L
         fcb   $4F O
         fcb   $53 S
         fcb   $C5 E
         fcb   $31 1
         fcb   $01 
         fcb   $52 R
         fcb   $45 E
         fcb   $53 S
         fcb   $54 T
         fcb   $4F O
         fcb   $52 R
         fcb   $C5 E
         fcb   $32 2
         fcb   $01 
         fcb   $44 D
         fcb   $45 E
         fcb   $4C L
         fcb   $45 E
         fcb   $54 T
         fcb   $C5 E
         fcb   $33 3
         fcb   $01 
         fcb   $43 C
         fcb   $48 H
         fcb   $41 A
         fcb   $49 I
         fcb   $CE N
         fcb   $34 4
         fcb   $01 
L0260    fcb   $53 S
         fcb   $48 H
         fcb   $45 E
         fcb   $4C L
         fcb   $CC L
         fcb   $35 5
         fcb   $01 
L0267    fcb   $42 B
         fcb   $41 A
         fcb   $53 S
         fcb   $C5 E
         fcb   $37 7
         fcb   $01 
L026D    fcb   $52 R
         fcb   $45 E
         fcb   $CD M
         fcb   $39 9
         fcb   $01 
         fcb   $45 E
         fcb   $4E N
         fcb   $C4 D
         fcb   $40 @
         fcb   $03 
         fcb   $42 B
         fcb   $59 Y
         fcb   $54 T
         fcb   $C5 E
         fcb   $41 A
         fcb   $03 
         fcb   $49 I
         fcb   $4E N
         fcb   $54 T
         fcb   $45 E
         fcb   $47 G
         fcb   $45 E
         fcb   $D2 R
         fcb   $42 B
         fcb   $03 
         fcb   $52 R
         fcb   $45 E
         fcb   $41 A
         fcb   $CC L
         fcb   $43 C
         fcb   $03 
         fcb   $42 B
         fcb   $4F O
         fcb   $4F O
         fcb   $4C L
         fcb   $45 E
         fcb   $41 A
         fcb   $CE N
         fcb   $44 D
         fcb   $03 
         fcb   $53 S
         fcb   $54 T
         fcb   $52 R
         fcb   $49 I
         fcb   $4E N
         fcb   $C7 G
         fcb   $45 E
         fcb   $03 
L029D    fcb   $54 T
         fcb   $48 H
         fcb   $45 E
         fcb   $CE N
         fcb   $46 F
         fcb   $03 
         fcb   $54 T
         fcb   $CF O
         fcb   $47 G
         fcb   $03 
         fcb   $53 S
         fcb   $54 T
         fcb   $45 E
         fcb   $D0 P
         fcb   $48 H
         fcb   $03 
         fcb   $44 D
         fcb   $CF O
         fcb   $49 I
         fcb   $03 
         fcb   $55 U
         fcb   $53 S
         fcb   $49 I
         fcb   $4E N
         fcb   $C7 G
         fcb   $3D =
         fcb   $03 
         fcb   $50 P
         fcb   $52 R
         fcb   $4F O
         fcb   $43 C
         fcb   $45 E
         fcb   $44 D
         fcb   $55 U
         fcb   $52 R
         fcb   $C5 E
         fcb   $92 
         fcb   $04 
         fcb   $41 A
         fcb   $44 D
         fcb   $44 D
         fcb   $D2 R
         fcb   $94 
         fcb   $04 
         fcb   $53 S
         fcb   $49 I
         fcb   $5A Z
         fcb   $C5 E
         fcb   $96 
         fcb   $04 
         fcb   $50 P
         fcb   $4F O
         fcb   $D3 S
         fcb   $97 
         fcb   $04 
L02D4    fcb   $45 E
         fcb   $52 R
         fcb   $D2 R
         fcb   $98 
         fcb   $04 
         fcb   $4D M
         fcb   $4F O
         fcb   $C4 D
         fcb   $9A 
         fcb   $04 
         fcb   $52 R
         fcb   $4E N
         fcb   $C4 D
         fcb   $9C 
         fcb   $04 
         fcb   $53 S
         fcb   $55 U
         fcb   $42 B
         fcb   $53 S
         fcb   $54 T
         fcb   $D2 R
         fcb   $9B 
         fcb   $04 
         fcb   $50 P
         fcb   $C9 I
         fcb   $9F 
         fcb   $04 
         fcb   $53 S
         fcb   $49 I
         fcb   $CE N
         fcb   $A0 
         fcb   $04 
         fcb   $43 C
         fcb   $4F O
         fcb   $D3 S
         fcb   $A1 !
         fcb   $04 
         fcb   $54 T
         fcb   $41 A
         fcb   $CE N
         fcb   $A2 "
         fcb   $04 
         fcb   $41 A
         fcb   $53 S
         fcb   $CE N
         fcb   $A3 #
         fcb   $04 
         fcb   $41 A
         fcb   $43 C
         fcb   $D3 S
         fcb   $A4 $
         fcb   $04 
         fcb   $41 A
         fcb   $54 T
         fcb   $CE N
         fcb   $A5 %
         fcb   $04 
         fcb   $45 E
         fcb   $58 X
         fcb   $D0 P
         fcb   $A8 (
         fcb   $04 
         fcb   $4C L
         fcb   $4F O
         fcb   $C7 G
         fcb   $A9 )
         fcb   $04 
         fcb   $4C L
         fcb   $4F O
         fcb   $47 G
         fcb   $31 1
         fcb   $B0 0
         fcb   $9D 
         fcb   $04 
         fcb   $53 S
         fcb   $47 G
         fcb   $CE N
         fcb   $A6 &
         fcb   $04 
         fcb   $41 A
         fcb   $42 B
         fcb   $D3 S
         fcb   $AA *
         fcb   $04 
         fcb   $53 S
         fcb   $51 Q
         fcb   $52 R
         fcb   $D4 T
         fcb   $AA *
         fcb   $04 
         fcb   $53 S
         fcb   $51 Q
         fcb   $D2 R
         fcb   $AC ,
         fcb   $04 
         fcb   $49 I
         fcb   $4E N
         fcb   $D4 T
         fcb   $AE .
         fcb   $04 
         fcb   $46 F
         fcb   $49 I
         fcb   $D8 X
         fcb   $B0 0
         fcb   $04 
         fcb   $46 F
         fcb   $4C L
         fcb   $4F O
         fcb   $41 A
         fcb   $D4 T
         fcb   $B2 2
         fcb   $04 
         fcb   $53 S
         fcb   $D1 Q
         fcb   $B4 4
         fcb   $04 
         fcb   $50 P
         fcb   $45 E
         fcb   $45 E
         fcb   $CB K
         fcb   $B5 5
         fcb   $04 
         fcb   $4C L
         fcb   $4E N
         fcb   $4F O
         fcb   $D4 T
         fcb   $B6 6
         fcb   $04 
         fcb   $56 V
         fcb   $41 A
         fcb   $CC L
         fcb   $B7 7
         fcb   $04 
         fcb   $4C L
         fcb   $45 E
         fcb   $CE N
         fcb   $B8 8
         fcb   $04 
         fcb   $41 A
         fcb   $53 S
         fcb   $C3 C
         fcb   $B9 9
         fcb   $04 
         fcb   $4C L
         fcb   $41 A
         fcb   $4E N
         fcb   $C4 D
         fcb   $BA :
         fcb   $04 
         fcb   $4C L
         fcb   $4F O
         fcb   $D2 R
         fcb   $BB ;
         fcb   $04 
         fcb   $4C L
         fcb   $58 X
         fcb   $4F O
         fcb   $D2 R
         fcb   $BC <
         fcb   $04 
         fcb   $54 T
         fcb   $52 R
         fcb   $55 U
         fcb   $C5 E
         fcb   $BD =
         fcb   $04 
         fcb   $46 F
         fcb   $41 A
         fcb   $4C L
         fcb   $53 S
         fcb   $C5 E
         fcb   $BE >
         fcb   $04 
         fcb   $45 E
         fcb   $4F O
         fcb   $C6 F
         fcb   $BF ?
         fcb   $04 
         fcb   $54 T
         fcb   $52 R
         fcb   $49 I
         fcb   $4D M
         fcb   $A4 $
         fcb   $C0 @
         fcb   $04 
         fcb   $4D M
         fcb   $49 I
         fcb   $44 D
         fcb   $A4 $
         fcb   $C1 A
         fcb   $04 
         fcb   $4C L
         fcb   $45 E
         fcb   $46 F
         fcb   $54 T
         fcb   $A4 $
         fcb   $C2 B
         fcb   $04 
         fcb   $52 R
         fcb   $49 I
         fcb   $47 G
         fcb   $48 H
         fcb   $54 T
         fcb   $A4 $
         fcb   $C3 C
         fcb   $04 
         fcb   $43 C
         fcb   $48 H
         fcb   $52 R
         fcb   $A4 $
         fcb   $C4 D
         fcb   $04 
         fcb   $53 S
         fcb   $54 T
         fcb   $52 R
         fcb   $A4 $
         fcb   $C6 F
         fcb   $04 
         fcb   $44 D
         fcb   $41 A
         fcb   $54 T
         fcb   $45 E
         fcb   $A4 $
         fcb   $C7 G
         fcb   $04 
         fcb   $54 T
         fcb   $41 A
         fcb   $C2 B
         fcb   $CD M
         fcb   $05 
         fcb   $4E N
         fcb   $4F O
         fcb   $D4 T
         fcb   $D0 P
         fcb   $05 
         fcb   $41 A
         fcb   $4E N
         fcb   $C4 D
         fcb   $D1 Q
         fcb   $05 
         fcb   $4F O
         fcb   $D2 R
         fcb   $D2 R
         fcb   $05 
         fcb   $58 X
         fcb   $4F O
         fcb   $D2 R
         fcb   $F7 w
         fcb   $03 
         fcb   $55 U
         fcb   $50 P
         fcb   $44 D
         fcb   $41 A
         fcb   $54 T
         fcb   $C5 E
         fcb   $F8 x
         fcb   $03 
         fcb   $45 E
         fcb   $58 X
         fcb   $45 E
         fcb   $C3 C
         fcb   $F9 y
         fcb   $03 
         fcb   $44 D
         fcb   $49 I
         fcb   $D2 R
L03DE    fcb   $40 @
         fcb   $00 
         fcb   $00 
         fcb   $00 
         fcb   $FD 
         fcb   $49 I
         fcb   $00 
         fcb   $FD 
         fcb   $4D M
         fcb   $00 
         fcb   $FD 
         fcb   $50 P
         fcb   $00 
         fcb   $FD 
         fcb   $52 R
         fcb   $00 
         fcb   $FD 
         fcb   $55 U
         fcb   $00 
         fcb   $FD 
         fcb   $58 X
         fcb   $00 
         fcb   $FD 
         fcb   $5A Z
         fcb   $00 
         fcb   $FD 
         fcb   $5D ]
         fcb   $00 
         fcb   $FD 
         fcb   $61 a
         fcb   $00 
         fcb   $FD 
         fcb   $65 e
         fcb   $00 
         fcb   $FD 
         fcb   $67 g
         fcb   $00 
         fcb   $FD 
         fcb   $69 i
         fcb   $00 
         fcb   $FD 
         fcb   $6E n
         fcb   $40 @
         fcb   $00 
         fcb   $00 
         fcb   $00 
         fcb   $FD 
         fcb   $6D m
         fcb   $00 
         fcb   $FD 
         fcb   $70 p
         fcb   $63 c
         fcb   $FD 
         fcb   $71 q
         fcb   $02 
         fcb   $FD 
         fcb   $74 t
         fcb   $01 
         fcb   $FD 
         fcb   $78 x
         fcb   $22 "
         fcb   $0F 
         fcb   $E7 g
         fcb   $01 
         fcb   $FD 
         fcb   $7D ý
         fcb   $62 b
         fcb   $FD 
         fcb   $81 
         fcb   $01 
         fcb   $FD 
         fcb   $88 
         fcb   $02 
         fcb   $FD 
         fcb   $8D 
         fcb   $01 
         fcb   $FD 
         fcb   $91 
         fcb   $62 b
         fcb   $FD 
         fcb   $94 
         fcb   $02 
         fcb   $FD 
         fcb   $9A 
         fcb   $63 c
         fcb   $FD 
         fcb   $9F 
         fcb   $00 
         fcb   $FD 
         fcb   $A5 %
         fcb   $00 
         fcb   $FD 
         fcb   $A6 &
         fcb   $20 
         fcb   $0F 
         fcb   $76 v
         fcb   $20 
         fcb   $0F 
         fcb   $73 s
         fcb   $20 
         fcb   $0F 
         fcb   $6A j
         fcb   $20 
         fcb   $0F 
         fcb   $67 g
         fcb   $20 
         fcb   $0F 
         fcb   $B0 0
         fcb   $00 
         fcb   $FD 
         fcb   $AD -
         fcb   $00 
         fcb   $FD 
         fcb   $B0 0
         fcb   $00 
         fcb   $FD 
         fcb   $B4 4
         fcb   $00 
         fcb   $FD 
         fcb   $B8 8
         fcb   $00 
         fcb   $FD 
         fcb   $BA :
         fcb   $00 
         fcb   $FD 
         fcb   $BC <
         fcb   $00 
         fcb   $FD 
         fcb   $C1 A
         fcb   $00 
         fcb   $FD 
         fcb   $C4 D
         fcb   $00 
         fcb   $FD 
         fcb   $C7 G
         fcb   $00 
         fcb   $FD 
         fcb   $CA J
         fcb   $00 
         fcb   $FD 
         fcb   $CE N
         fcb   $00 
         fcb   $FD 
         fcb   $D0 P
         fcb   $00 
         fcb   $FD 
         fcb   $D2 R
         fcb   $00 
         fcb   $FD 
         fcb   $D6 V
         fcb   $00 
         fcb   $FD 
         fcb   $DC \
         fcb   $00 
         fcb   $FD 
         fcb   $E1 a
         fcb   $00 
         fcb   $FD 
         fcb   $E5 e
         fcb   $20 
         fcb   $0F 
         fcb   $6D m
         fcb   $20 
         fcb   $0F 
         fcb   $6A j
         fcb   $20 
         fcb   $0F 
         fcb   $A1 !
         fcb   $20 
         fcb   $0F 
         fcb   $98 
         fcb   $00 
         fcb   $FD 
         fcb   $E8 h
         fcb   $20 
         fcb   $0F 
         fcb   $2B +
         fcb   $20 
         fcb   $0F 
         fcb   $28 (
         fcb   $40 @
         fcb   $00 
         fcb   $00 
         fcb   $20 
         fcb   $0F 
         fcb   $96 
         fcb   $40 @
         fcb   $20 
         fcb   $5C \
         fcb   $20 
         fcb   $0E 
         fcb   $21 !
         fcb   $10 
         fcb   $FD 
         fcb   $D8 X
         fcb   $10 
         fcb   $FD 
         fcb   $DB [
         fcb   $10 
         fcb   $FD 
         fcb   $E1 a
         fcb   $10 
         fcb   $FD 
         fcb   $E4 d
         fcb   $10 
         fcb   $FD 
         fcb   $EA j
         fcb   $20 
         fcb   $0F 
         fcb   $5F _
         fcb   $60 `
         fcb   $FD 
         fcb   $F2 r
         fcb   $60 `
         fcb   $FD 
         fcb   $F3 s
         fcb   $00 
         fcb   $FD 
         fcb   $F6 v
         fcb   $00 
         fcb   $FD 
         fcb   $F7 w
         fcb   $20 
         fcb   $0F 
         fcb   $8A 
         fcb   $40 @
         fcb   $2C ,
         fcb   $00 
         fcb   $40 @
         fcb   $3A :
         fcb   $00 
         fcb   $40 @
         fcb   $28 (
         fcb   $00 
         fcb   $40 @
         fcb   $29 )
         fcb   $00 
         fcb   $40 @
         fcb   $5B [
         fcb   $00 
         fcb   $40 @
         fcb   $5D ]
         fcb   $00 
         fcb   $40 @
         fcb   $3B ;
         fcb   $20 
         fcb   $40 @
         fcb   $3A :
         fcb   $3D =
         fcb   $40 @
         fcb   $3D =
         fcb   $00 
         fcb   $40 @
         fcb   $23 #
         fcb   $00 
         fcb   $20 
         fcb   $15 
         fcb   $EC l
         fcb   $20 
         fcb   $0E 
         fcb   $92 
         fcb   $20 
         fcb   $0E 
         fcb   $8F 
         fcb   $20 
         fcb   $0E 
         fcb   $8C 
         fcb   $20 
         fcb   $0E 
         fcb   $89 
         fcb   $20 
         fcb   $0E 
         fcb   $86 
         fcb   $20 
         fcb   $0E 
         fcb   $83 
         fcb   $21 !
         fcb   $0E 
         fcb   $80 
         fcb   $22 "
         fcb   $0E 
         fcb   $7D ý
         fcb   $23 #
         fcb   $0E 
         fcb   $7A z
         fcb   $20 
         fcb   $0E 
         fcb   $73 s
         fcb   $21 !
         fcb   $0E 
         fcb   $70 p
         fcb   $22 "
         fcb   $0E 
         fcb   $6D m
         fcb   $23 #
         fcb   $0E 
         fcb   $6A j
         fcb   $26 &
         fcb   $0E 
         fcb   $9F 
         fcb   $27 '
         fcb   $0E 
         fcb   $AD -
         fcb   $24 $
         fcb   $0E 
         fcb   $7B û
         fcb   $24 $
         fcb   $0E 
         fcb   $B9 9
         fcb   $27 '
         fcb   $0E 
         fcb   $CB K
         fcb   $11 
         fcb   $FD 
         fcb   $AC ,
         fcb   $80 
         fcb   $00 
         fcb   $00 
         fcb   $11 
         fcb   $FD 
         fcb   $AC ,
         fcb   $80 
         fcb   $00 
         fcb   $00 
         fcb   $10 
         fcb   $FD 
         fcb   $AC ,
         fcb   $10 
         fcb   $FD 
         fcb   $AE .
         fcb   $12 
         fcb   $FD 
         fcb   $B0 0
         fcb   $12 
         fcb   $FD 
         fcb   $AD -
         fcb   $11 
         fcb   $FD 
         fcb   $AF /
         fcb   $10 
         fcb   $FD 
         fcb   $B9 9
         fcb   $12 
         fcb   $FD 
         fcb   $AE .
         fcb   $11 
         fcb   $FD 
         fcb   $E6 f
         fcb   $11 
         fcb   $FD 
         fcb   $E3 c
         fcb   $11 
         fcb   $FD 
         fcb   $B1 1
         fcb   $11 
         fcb   $FD 
         fcb   $B3 3
         fcb   $11 
         fcb   $FD 
         fcb   $B5 5
         fcb   $11 
         fcb   $FD 
         fcb   $B7 7
         fcb   $11 
         fcb   $FD 
         fcb   $B9 9
         fcb   $11 
         fcb   $FD 
         fcb   $BB ;
         fcb   $11 
         fcb   $FD 
         fcb   $BD =
         fcb   $11 
         fcb   $FD 
         fcb   $D0 P
         fcb   $11 
         fcb   $FD 
         fcb   $CD M
         fcb   $11 
         fcb   $FD 
         fcb   $B9 9
         fcb   $11 
         fcb   $FD 
         fcb   $BB ;
         fcb   $11 
         fcb   $FD 
         fcb   $C9 I
         fcb   $11 
         fcb   $FD 
         fcb   $C6 F
         fcb   $11 
         fcb   $FD 
         fcb   $CE N
         fcb   $11 
         fcb   $FD 
         fcb   $CB K
         fcb   $11 
         fcb   $FD 
         fcb   $CD M
         fcb   $11 
         fcb   $FD 
         fcb   $CA J
         fcb   $11 
         fcb   $FD 
         fcb   $CC L
         fcb   $11 
         fcb   $FD 
         fcb   $C9 I
         fcb   $11 
         fcb   $FD 
         fcb   $CD M
         fcb   $11 
         fcb   $FD 
         fcb   $CA J
         fcb   $11 
         fcb   $FD 
         fcb   $CB K
         fcb   $11 
         fcb   $FD 
         fcb   $CE N
         fcb   $11 
         fcb   $FD 
         fcb   $D1 Q
         fcb   $11 
         fcb   $FD 
         fcb   $D3 S
         fcb   $11 
         fcb   $FD 
         fcb   $D5 U
         fcb   $12 
         fcb   $FD 
         fcb   $D7 W
         fcb   $12 
         fcb   $FD 
         fcb   $DA Z
         fcb   $12 
         fcb   $FD 
         fcb   $DC \
         fcb   $10 
         fcb   $FD 
         fcb   $DF _
         fcb   $10 
         fcb   $FD 
         fcb   $E2 b
         fcb   $11 
         fcb   $FD 
         fcb   $E6 f
         fcb   $11 
         fcb   $FD 
         fcb   $E8 h
         fcb   $13 
         fcb   $FD 
         fcb   $EC l
         fcb   $12 
         fcb   $FD 
         fcb   $EF o
         fcb   $12 
         fcb   $FD 
         fcb   $F3 s
         fcb   $11 
         fcb   $FD 
         fcb   $F8 x
         fcb   $11 
         fcb   $FD 
         fcb   $FB 
         fcb   $11 
         fcb   $FD 
         fcb   $F8 x
         fcb   $10 
         fcb   $FD 
         fcb   $FB 
         fcb   $11 
         fcb   $FD 
         fcb   $FF 
         fcb   $80 
         fcb   $00 
         fcb   $00 
         fcb   $80 
         fcb   $00 
         fcb   $00 
         fcb   $80 
         fcb   $00 
         fcb   $00 
         fcb   $80 
         fcb   $00 
         fcb   $00 
         fcb   $80 
         fcb   $00 
         fcb   $00 
         fcb   $11 
         fcb   $FD 
         fcb   $F2 r
         fcb   $51 Q
         fcb   $2D -
         fcb   $00 
         fcb   $51 Q
         fcb   $2D -
         fcb   $00 
         fcb   $0A 
         fcb   $FD 
         fcb   $EE n
         fcb   $09 
         fcb   $FD 
         fcb   $F0 p
         fcb   $09 
         fcb   $FD 
         fcb   $F1 q
         fcb   $4B K
         fcb   $3E >
         fcb   $00 
         fcb   $4B K
         fcb   $3E >
         fcb   $00 
         fcb   $4B K
         fcb   $3E >
         fcb   $00 
         fcb   $4B K
         fcb   $3C <
         fcb   $00 
         fcb   $4B K
         fcb   $3C <
         fcb   $00 
         fcb   $4B K
         fcb   $3C <
         fcb   $00 
         fcb   $4B K
         fcb   $3C <
         fcb   $3E >
         fcb   $4B K
         fcb   $3C <
         fcb   $3E >
         fcb   $4B K
         fcb   $3C <
         fcb   $3E >
         fcb   $4B K
         fcb   $3C <
         fcb   $3E >
         fcb   $4B K
         fcb   $3D =
         fcb   $00 
         fcb   $4B K
         fcb   $3D =
         fcb   $00 
         fcb   $4B K
         fcb   $3D =
         fcb   $00 
         fcb   $4B K
         fcb   $3D =
         fcb   $00 
         fcb   $4B K
         fcb   $3E >
         fcb   $3D =
         fcb   $4B K
         fcb   $3E >
         fcb   $3D =
         fcb   $4B K
         fcb   $3E >
         fcb   $3D =
         fcb   $4B K
         fcb   $3C <
         fcb   $3D =
         fcb   $4B K
         fcb   $3C <
         fcb   $3D =
         fcb   $4B K
         fcb   $3C <
         fcb   $3D =
         fcb   $4C L
         fcb   $2B +
         fcb   $00 
         fcb   $4C L
         fcb   $2B +
         fcb   $00 
         fcb   $4C L
         fcb   $2B +
         fcb   $00 
         fcb   $4C L
         fcb   $2D -
         fcb   $00 
         fcb   $4C L
         fcb   $2D -
         fcb   $00 
         fcb   $4D M
         fcb   $2A *
         fcb   $00 
         fcb   $4D M
         fcb   $2A *
         fcb   $00 
         fcb   $4D M
         fcb   $2F /
         fcb   $00 
         fcb   $4D M
         fcb   $2F /
         fcb   $00 
         fcb   $4E N
         fcb   $5E ^
         fcb   $00 
         fcb   $4E N
         fcb   $2A *
         fcb   $2A *
         fcb   $20 
         fcb   $0D 
         fcb   $3C <
         fcb   $21 !
         fcb   $0D 
         fcb   $39 9
         fcb   $22 "
         fcb   $0D 
         fcb   $36 6
         fcb   $23 #
         fcb   $0D 
         fcb   $33 3
         fcb   $20 
         fcb   $0D 
         fcb   $2C ,
         fcb   $21 !
         fcb   $0D 
         fcb   $29 )
         fcb   $22 "
         fcb   $0D 
         fcb   $26 &
         fcb   $23 #
         fcb   $0D 
         fcb   $23 #
         fcb   $00 
         fcb   $02 
         fcb   $02 
L0651    fcb   $03 
         fcb   $91 
         fcb   $A4 $
         fcb   $02 
         fcb   $E4 d
         fcb   $8D 
         fcb   $00 
         fcb   $0E 
         fcb   $02 
         fcb   $07 
         fcb   $FC 
         fcb   $42 B
         fcb   $59 Y
         fcb   $C5 E
         fcb   $02 
         fcb   $D4 T
         fcb   $44 D
         fcb   $49 I
         fcb   $D2 R
         fcb   $0F 
         fcb   $15 
         fcb   $45 E
         fcb   $44 D
         fcb   $49 I
         fcb   $D4 T
         fcb   $0F 
         fcb   $0F 
         fcb   $C5 E
         fcb   $06 
         fcb   $7E þ
         fcb   $4C L
         fcb   $49 I
         fcb   $53 S
         fcb   $D4 T
         fcb   $07 
         fcb   $3D =
         fcb   $52 R
         fcb   $55 U
         fcb   $CE N
         fcb   $08 
         fcb   $09 
         fcb   $4B K
         fcb   $49 I
         fcb   $4C L
         fcb   $CC L
         fcb   $06 
         fcb   $5F _
         fcb   $53 S
         fcb   $41 A
         fcb   $56 V
         fcb   $C5 E
         fcb   $04 
         fcb   $28 (
         fcb   $4C L
         fcb   $4F O
         fcb   $41 A
         fcb   $C4 D
         fcb   $03 
         fcb   $91 
         fcb   $52 R
         fcb   $45 E
         fcb   $4E N
         fcb   $41 A
         fcb   $4D M
         fcb   $C5 E
         fcb   $04 
         fcb   $A8 (
         fcb   $50 P
         fcb   $41 A
         fcb   $43 C
         fcb   $CB K
         fcb   $02 
         fcb   $69 i
         fcb   $4D M
         fcb   $45 E
         fcb   $CD M
         fcb   $03 
         fcb   $70 p
         fcb   $43 C
         fcb   $48 H
         fcb   $C4 D
         fcb   $03 
         fcb   $6F o
         fcb   $43 C
         fcb   $48 H
         fcb   $D8 X
         fcb   $00 
         fcb   $02 
         fcb   $02 
L06AA    fcb   $03 
         fcb   $38 8
         fcb   $A4 $
         fcb   $09 
         fcb   $C7 G
         fcb   $8D 
         fcb   $00 
         fcb   $0E 
         fcb   $02 
         fcb   $09 
         fcb   $D0 P
         fcb   $43 C
         fcb   $4F O
         fcb   $4E N
         fcb   $D4 T
         fcb   $02 
         fcb   $7A z
         fcb   $44 D
         fcb   $49 I
         fcb   $D2 R
         fcb   $09 
         fcb   $93 
         fcb   $D1 Q
         fcb   $0A 
         fcb   $0C 
         fcb   $4C L
         fcb   $49 I
         fcb   $53 S
         fcb   $D4 T
         fcb   $0A 
         fcb   $B7 7
         fcb   $50 P
         fcb   $52 R
         fcb   $49 I
         fcb   $4E N
         fcb   $D4 T
         fcb   $0B 
         fcb   $25 %
         fcb   $53 S
         fcb   $54 T
         fcb   $41 A
         fcb   $54 T
         fcb   $C5 E
         fcb   $0A 
         fcb   $A9 )
         fcb   $54 T
         fcb   $52 R
         fcb   $4F O
         fcb   $CE N
         fcb   $0A 
         fcb   $A3 #
         fcb   $54 T
         fcb   $52 R
         fcb   $4F O
         fcb   $46 F
         fcb   $C6 F
         fcb   $0A 
         fcb   $9C 
         fcb   $44 D
         fcb   $45 E
         fcb   $C7 G
         fcb   $0A 
         fcb   $97 
         fcb   $52 R
         fcb   $41 A
         fcb   $C4 D
         fcb   $0A 
         fcb   $92 
         fcb   $4C L
         fcb   $45 E
         fcb   $D4 T
         fcb   $09 
         fcb   $74 t
         fcb   $53 S
         fcb   $54 T
         fcb   $45 E
         fcb   $D0 P
         fcb   $0B 
         fcb   $18 
         fcb   $42 B
         fcb   $52 R
         fcb   $45 E
         fcb   $41 A
         fcb   $CB K
         fcb   $00 
         fcb   $08 
         fcb   $02 
L0701    fcb   $0F 
         fcb   $86 
         fcb   $CC L
         fcb   $0F 
         fcb   $83 
         fcb   $EC l
         fcb   $12 
         fcb   $7C ü
         fcb   $C4 D
         fcb   $12 
         fcb   $79 y
         fcb   $E4 d
         fcb   $0E 
         fcb   $C3 C
         fcb   $AB +
         fcb   $0E 
         fcb   $C0 @
         fcb   $AD -
         fcb   $0E 
         fcb   $BD =
         fcb   $8D 
         fcb   $0E 
         fcb   $D4 T
         fcb   $A0 
         fcb   $00 
         fcb   $04 
         fcb   $02 
         fcb   $10 
         fcb   $28 (
         fcb   $D3 S
         fcb   $10 
         fcb   $28 (
         fcb   $C3 C
         fcb   $11 
         fcb   $A6 &
         fcb   $D2 R
         fcb   $12 
         fcb   $57 W
         fcb   $D1 Q
L0728    fcb   $0E 
         fcb   $52 R
         fcb   $65 e
         fcb   $61 a
         fcb   $64 d
         fcb   $F9 y
L072E    fcb   $57 W
         fcb   $68 h
         fcb   $61 a
         fcb   $74 t
         fcb   $BF ?
L0733    fcb   $20 
         fcb   $66 f
         fcb   $72 r
         fcb   $65 e
         fcb   $E5 e
L0738    fcb   $50 P
         fcb   $72 r
         fcb   $6F o
         fcb   $67 g
         fcb   $72 r
         fcb   $61 a
         fcb   $ED m
L073F    fcb   $50 P
         fcb   $52 R
         fcb   $4F O
         fcb   $43 C
         fcb   $45 E
         fcb   $44 D
         fcb   $55 U
         fcb   $52 R
         fcb   $C5 E
         fcb   $0D 
L0749    fcb   $0A 
         fcb   $20 
         fcb   $20 
         fcb   $4E N
         fcb   $61 a
         fcb   $6D m
         fcb   $65 e
         fcb   $20 
         fcb   $20 
         fcb   $20 
         fcb   $20 
         fcb   $20 
         fcb   $20 
         fcb   $50 P
         fcb   $72 r
         fcb   $6F o
         fcb   $63 c
         fcb   $2D -
         fcb   $53 S
         fcb   $69 i
         fcb   $7A z
         fcb   $65 e
         fcb   $20 
         fcb   $20 
         fcb   $44 D
         fcb   $61 a
         fcb   $74 t
         fcb   $61 a
         fcb   $2D -
         fcb   $53 S
         fcb   $69 i
         fcb   $7A z
         fcb   $E5 e
L076A    fcb   $52 R
         fcb   $65 e
         fcb   $77 w
         fcb   $72 r
         fcb   $69 i
         fcb   $74 t
         fcb   $65 e
         fcb   $3F ?
         fcb   $3A :
         fcb   $20 
L0774    fcb   $52 R
         fcb   $41 A
         fcb   $4E N
         fcb   $47 G
         fcb   $45 E
         fcb   $87 
L077A    fcb   $0E 
         fcb   $42 B
         fcb   $52 R
         fcb   $45 E
         fcb   $41 A
         fcb   $4B K
         fcb   $3A :
         fcb   $A0 
L0782    fcb   $63 c
         fcb   $61 a
         fcb   $6C l
         fcb   $6C l
         fcb   $65 e
         fcb   $64 d
         fcb   $20 
         fcb   $62 b
         fcb   $F9 y
L078B    fcb   $6F o
         fcb   $EB k
L078D    fcb   $44 D
         fcb   $BA :
L078F    fcb   $45 E
         fcb   $BA :
L0791    fcb   $42 B
         fcb   $BA :
L0793    fcb   $63 c
         fcb   $61 a
         fcb   $6E n
         fcb   $27 '
         fcb   $74 t
         fcb   $20 
         fcb   $66 f
         fcb   $69 i
         fcb   $6E n
         fcb   $64 d
         fcb   $BA :
L079E    fcb   $A6 &
         fcb   $63 c
         fcb   $1F 
         fcb   $8B 
         fcb   $D7 W
         fcb   $35 5
         fcb   $08 
         fcb   $34 4
         fcb   $43 C
         fcb   $06 
         fcb   $34 4
         fcb   $3B ;
start    equ   *
         pshs  u
         leau  >u0100,u
         clra  
         clrb  
L07B2    std   ,--u
         cmpu  ,s
         bhi   L07B2
         puls  b,a
         leau  ,x
         std   <u0000
         inca  
         sta   <u00D9
         std   <u0080
         std   <u0082
         adda  #$02
         std   <u0046
         std   <u0044
         inca  
         tfr   d,s
         std   <u0004
         inca  
         std   <u0008
         std   <u004A
         tfr   u,d
         subd  <u0000
         std   <u0002
         clra  
         ldb   #$01
         std   <u002D
         sta   <u00BD
         lda   #$03
L07E5    os9   I$Close  
         inca  
         cmpa  #$10
         bcs   L07E5
         lda   #$02
         os9   I$Dup    
         sta   <u00BE
         clr   <u0035
         pshs  x
         leax  <L079E,pcr
         os9   F$Icpt   
         ldx   <u0008
         clra  
         clrb  
L0802    std   ,--x
         cmpx  <u0004
         bhi   L0802
         leax  >L0000,pcr
         pshs  x
         ldx   <u0000
         leax  <$1B,x
         leay  >L000D,pcr
L0817    lda   #$7E
         sta   ,x+
         ldd   ,y++
         addd  ,s
         std   ,x++
         ldd   ,y
         bne   L0817
         leas  $02,s
         lbsr  L00FF
         puls  y
         leax  >L0129,pcr
         stx   <u009E
         ldb   ,y
         cmpb  #$0D
         beq   L088F
         leax  <L0849,pcr
         pshs  y
         bsr   L0859
         lbsr  L0F7A
         bcc   L0878
         lbsr  L0AAC
         bra   L0878
L0849    puls  y
         bsr   L0856
         ldx   <u0004
         ldd   ,x
         std   <u002F
         lbsr  L0DB0
L0856    leax  <L089B,pcr
L0859    puls  u
         bsr   L0882
         pshs  u
         clr   <u0034
         ldd   <u0000
         addd  <u0002
         subd  <u0008
         subd  <u000A
         std   <u000C
         leau  $02,s
         stu   <u0046
         stu   <u0044
         leas  >-$00FE,s
         jmp   [<-u0002,u]
L0878    lds   <u00B7
         puls  b,a
         std   <u00B7
L087F    lbra  L0DA4
L0882    ldd   <u00B7
         pshs  b,a
         sts   <u00B7
         ldd   $02,s
         stx   $02,s
         tfr   d,pc
L088F    leax  >L0024,pcr
         bsr   L08B9
         leax  >L001B,pcr
         bsr   L08B9
L089B    bsr   L0856
         leax  >L0728,pcr
         bsr   L08B9
         leax  >L0791,pcr
         leay  >L0651,pcr
         clr   <u0084
         bsr   L08BC
         bcc   L0878
         bsr   L08B5
         bra   L0878
L08B5    leax  >L072E,pcr
L08B9    lbra  L1248
L08BC    pshs  y,x
         clr   <u0035
         lbsr  L1254
         bsr   L087F
         lda   <u00BD
         beq   L08CC
         os9   I$Close  
L08CC    clr   <u00BD
         lbsr  L0B16
         bcc   L08E1
         cmpb  #$D3
         bne   L08FE
         ldd   #$6279
         std   ,y
         ldd   #$650D
         std   $02,y
L08E1    ldx   $02,s
         lda   #$80
         lbsr  L00F3
         bne   L08F8
         lbsr  L00F6
         beq   L08FE
         leax  $03,x
         lda   #$20
         lbsr  L00F3
         beq   L08FE
L08F8    ldd   ,x
         leas  $04,s
         jmp   d,x
L08FE    coma  
         puls  pc,y,x
         lbsr  L0A79
         bne   L0925
         leax  ,y
         ldd   <u0008
         addd  <u000A
         inca  
         subd  <u0000
         pshs  b,a
         lbsr  L1731
         bcs   L092F
         cmpd  ,s++
         bcs   L0931
         os9   F$Mem    
         bcs   L0925
         subd  #$0001
         std   <u0002
L0925    lbsr  L0DA4
         ldd   <u0002
         bsr   L09A3
L092C    lbra  L124D
L092F    leas  $02,s
L0931    coma  
         rts   
         leax  ,y
         lbsr  L0D48
         leax  >L0749,pcr
         lbsr  L1248
         ldy   <u0004
         bra   L0984
L0944    pshs  y,x
         lda   #$20
         tst   $06,x
         beq   L094E
         lda   #$2D
L094E    lbsr  L135C
         lda   #$20
         cmpx  <u002F
         bne   L0959
         lda   #$2A
L0959    lbsr  L135C
         ldd   $04,x
         leax  d,x
         lbsr  L1343
         ldd   #$1102
         bsr   L0996
         ldd   #$1C0B
         bsr   L0996
         ldd   $0B,x
         addd  #$0040
         cmpd  <u000C
         bcs   L097C
         lda   #$3F
         lbsr  L135C
L097C    bsr   L092C
         puls  y,x
         tst   <u0035
         bne   L0988
L0984    ldx   ,y++
         bne   L0944
L0988    ldd   <u000C
         bsr   L09A3
         leax  >L0733,pcr
         lbsr  L124A
         lbra  L0D3A
L0996    pshs  b
         ldb   #$10
         lbsr  L0108
         puls  b
         ldx   $02,s
         ldd   b,x
L09A3    pshs  y,x,b,a
         pshs  b,a
         leay  <L09D6,pcr
L09AA    ldx   #$2F00
L09AD    puls  b,a
L09AF    leax  >$0100,x
         subd  ,y
         bcc   L09AF
         addd  ,y++
         pshs  b,a
         ldd   ,y
         tfr   x,d
         beq   L09CF
         cmpd  #$3000
         beq   L09AA
         lbsr  L135C
         ldx   #$2F01
         bra   L09AD
L09CF    lbsr  L135C
         leas  $02,s
         puls  pc,y,x,b,a
L09D6    beq   L09E8
         com   <u00E8
         neg   <u0064
         neg   <u000A
         neg   <u0001
         neg   <u0000
         lbsr  L0A79
         leau  ,y
         clrb  
L09E8    incb  
         lda   ,y+
         cmpa  #$0D
         bne   L09E8
         clra  
         tfr   d,y
         leax  >L0260,pcr
         lda   #$01
         clrb  
         os9   F$Fork   
         bcs   L0A6F
         pshs  a
L0A00    os9   F$Wait   
         cmpa  ,s
         bne   L0A00
         leas  $01,s
         tstb  
         bne   L0A6F
         rts   
         lda   #$83
         bra   L0A13
         lda   #$84
L0A13    leax  ,y
         os9   I$ChgDir 
         bcs   L0A6F
         rts   
         bsr   L0A86
         lbsr  L0F57
         bcs   L0A75
         pshs  x
         ldx   ,x
         tst   $06,x
         bne   L0A75
         bsr   L0A79
         beq   L0A31
L0A2E    comb  
         puls  pc,x
L0A31    lbsr  L00F6
         beq   L0A2E
         pshs  y
         lbsr  L0F57
         bcs   L0A41
         cmpx  $02,s
         bne   L0A6D
L0A41    ldx   $02,s
         lbsr  L1A17
         puls  x
         ldy   <u004A
L0A4B    lda   ,x+
         sta   ,y+
         bpl   L0A4B
         sty   <u00AB
         ldx   [,s++]
         ldd   $04,x
         leay  d,x
         ldb   <$18,x
         lda   <u00A6
         sta   <$18,x
         clra  
         lbsr  L199A
         addd  <u005E
         std   <u005E
L0A6A    lbra  L197E
L0A6D    ldb   #$2C
L0A6F    lbsr  L1270
L0A72    lbra  L0878
L0A75    ldb   #$2B
         bra   L0A6F
L0A79    ldb   ,y+
         cmpb  #$2C
         beq   L0A85
         cmpb  #$20
         beq   L0A85
         leay  -$01,y
L0A85    rts   
L0A86    lbsr  L00F6
         bne   L0A99
L0A8B    ldy   <u002F
         beq   L0A95
         ldd   $04,y
         leay  d,y
         rts   
L0A95    leay  >L0738,pcr
L0A99    rts   
L0A9A    ldb   #$2B
         bra   L0AA6
L0A9E    ldb   #$20
L0AA0    pshs  b
         bsr   L0A6A
         puls  b
L0AA6    cmpb  #$D3
         beq   L0A72
         bra   L0A6F
L0AAC    leax  ,y
         lda   #$01
         os9   I$Open   
         bcs   L0AA6
         sta   <u00BD
         bsr   L0B16
         bsr   L0B25
         bne   L0A9A
L0ABD    lbsr  L00F6
         beq   L0A9A
         pshs  y
         lbsr  L0F57
         bcs   L0AD1
         ldy   ,s
         leay  -$01,y
         lbsr  L0E81
L0AD1    ldy   ,s
         lbsr  L0EE6
         lbsr  L1A17
         puls  x
         lbsr  L1248
L0ADF    ldb   <u0035
         bne   L0AA0
         bsr   L0B16
         bcs   L0AA0
         lda   <u000C
         cmpa  #$02
         bcs   L0A9E
         bsr   L0B25
         beq   L0AFD
         ldy   <u0080
         ldd   <u0060
         std   <u005C
         lbsr  L15EF
         bra   L0ADF
L0AFD    ldx   <u0080
         pshs  y,x
L0B01    lda   ,x+
         cmpa  #$0D
         bne   L0B01
         stx   <u0080
         stx   <u0082
         lbsr  L0111
         puls  y,x
         stx   <u0080
         stx   <u0082
         bra   L0ABD
L0B16    lda   <u00BD
         ldx   <u0080
         ldy   #$0100
         os9   I$ReadLn 
         ldy   <u0080
         rts   
L0B25    lbsr  L00F6
         leax  >L073F,pcr
L0B2C    lda   ,x+
         eora  ,y+
         anda  #$DF
         bne   L0B39
         tst   -$01,x
         bpl   L0B2C
         clra  
L0B39    rts   
         lbsr  L0C6C
         ldu   <u0046
         bra   L0B62
L0B41    ldy   ,y
         tst   $06,y
         lbne  L0E51
         lda   <$17,y
         rora  
         lbcs  L0E51
         ldd   $0D,y
         leay  d,y
         ldd   -$03,y
         lslb  
         rola  
         inca  
         cmpd  <u000C
         lbhi  L0F52
L0B62    ldy   ,--u
         bne   L0B41
         ldd   #$0607
         lbsr  L0D54
         ldy   <u0046
         stu   <u0046
         lbra  L0C63
L0B75    pshs  y
         lbsr  L1A17
         clr   <u00D9
         lbsr  L0111
         inc   <u00D9
         ldx   <u0062
         leay  ,x
         ldd   <u0000
         addd  <u0002
         tfr   d,u
         ldd   -$03,x
         beq   L0C01
         pshs  u
L0B91    pshs  b,a
         leax  $01,x
         ldd   ,x
         pshu  b,a
         clr   ,x+
         clr   ,x+
L0B9D    lda   ,x+
         bpl   L0B9D
         puls  b,a
         subd  #$0001
         bne   L0B91
         ldy   <u005E
         bra   L0BBA
L0BAD    ldd   ,y
         ldx   <u0062
         leax  d,x
         ldd   $01,x
         sty   $01,x
         std   ,y++
L0BBA    lbsr  L1BAB
         bcc   L0BAD
         puls  u
         ldx   <u0062
         ldd   -$03,x
         leay  ,x
L0BC7    leau  -u0002,u
         pshs  u,b,a
         clra  
         ldu   $01,x
         beq   L0BED
         pshs  x
         tfr   y,d
         subd  <u0062
         bra   L0BDC
L0BD8    std   ,u
         leau  ,x
L0BDC    ldx   ,u
         bne   L0BD8
         std   ,u
         puls  x
         lda   ,x
         sta   ,y+
         ldu   [<$02,s]
         stu   ,y++
L0BED    leax  $03,x
L0BEF    ldb   ,x+
         cmpa  #$A0
         bne   L0BF7
         stb   ,y+
L0BF7    tstb  
         bpl   L0BEF
         puls  u,b,a
         subd  #$0001
         bne   L0BC7
L0C01    ldx   <u002F
         ldd   $02,x
         pshs  b,a
         clr   ,y+
         clr   ,y+
         clr   ,y+
         tfr   y,d
         subd  <u002F
         std   $02,x
         ldd   ,s
         subd  $02,x
         std   ,s
         addd  <u000C
         std   <u000C
         ldd   <u000A
         subd  ,s++
         std   <u000A
         addd  <u0008
         std   <u004A
         ldb   #$22
         stb   $06,x
         ldb   #$80
         stb   <$17,x
         leau  ,y
         ldd   #$FFFF
         std   ,--u
         sta   ,-u
         ldb   #$07
L0C3B    eora  b,x
         decb  
         bpl   L0C3B
         sta   $08,x
         ldy   $02,x
         leay  -$03,y
         os9   F$CRC    
         com   ,u+
         com   ,u+
         com   ,u+
         ldy   $02,x
         lda   #$02
         os9   I$Write  
         lda   #$C0
         sta   <$17,x
         lbcs  L0D9F
         puls  y
L0C63    ldx   ,--y
         lbne  L0B75
         lbra  L0D3A
L0C6C    bsr   L0C86
         lda   ,y
         cmpa  #$0D
         bne   L0C83
         ldx   <u0046
         ldx   [<-$02,x]
         ldd   $04,x
         leax  d,x
         lbsr  L1343
         lbsr  L12B8
L0C83    leax  ,y
         rts   
L0C86    ldu   <u0046
         stu   <u0044
         lbsr  L0A79
         beq   L0CAF
         cmpb  #$2A
         bne   L0CB4
         ldx   <u0004
L0C95    ldd   ,x
         beq   L0C9D
         tfr   x,d
         leax  $02,x
L0C9D    std   ,--u
         bne   L0C95
         stu   <u0044
         lda   ,y
         cmpa  #$0D
         beq   L0CAB
         leay  $01,y
L0CAB    sty   <u0082
         rts   
L0CAF    lbsr  L00F6
         bne   L0CC2
L0CB4    sty   <u0082
         lbsr  L0A8B
         lbsr  L0F57
         bcc   L0CCA
L0CBF    lbra  L0A75
L0CC2    lbsr  L0F57
         bcs   L0CBF
         sty   <u0082
L0CCA    stx   ,--u
         ldy   <u0082
         lbsr  L0A79
         bne   L0CD9
         lbsr  L00F6
         bne   L0CC2
L0CD9    clra  
         clrb  
         bra   L0C9D
         tst   <u000C
         lbeq  L0F52
         lda   #$80
         sta   <u0084
         bsr   L0C6C
         bra   L0CEF
         bsr   L0C86
         leax  ,y
L0CEF    stx   <u005C
         bsr   L0D48
         ldy   <u0046
         stu   <u0046
         bra   L0D32
L0CFA    pshs  y
         ldy   [,y]
         sty   <u002F
         ldd   $09,y
         addd  <u002F
         std   <u005E
         ldd   $0F,y
         addd  <u002F
         std   <u0060
         ldd   $0D,y
         addd  <u002F
         std   <u0062
         tst   $06,y
         bne   L0D30
         leax  <L0D24,pcr
         lbsr  L0882
         lbsr  L10CD
L0D21    lbra  L0878
L0D24    tst   <u0084
         bmi   L0D30
         ldx   [,s]
         lbsr  L1A17
         lbsr  L0111
L0D30    puls  y
L0D32    ldx   ,--y
         bne   L0CFA
L0D36    bsr   L0D3A
         bra   L0D21
L0D3A    pshs  b
         lda   #$02
         os9   I$Close  
         lda   <u00BE
         os9   I$Dup    
         puls  pc,b
L0D48    lbsr  L0A79
         cmpb  #$0D
         beq   L0D9E
         stx   <u0082
         ldd   #$020B
L0D54    pshs  u,x,b,a
         lda   #$02
         os9   I$Close  
         ldd   ,s
         os9   I$Create 
         bcc   L0D9C
         cmpb  #$DA
         bne   L0D9F
         ldd   ,s
         ldx   $02,s
         os9   I$Open   
         bcs   L0D9F
         leax  >L076A,pcr
         ldy   #$000A
         lda   <u00BE
         os9   I$WritLn 
         clra  
         leax  ,--s
         ldy   #$0002
         os9   I$ReadLn 
         puls  b,a
         eora  #$59
         anda  #$DF
         bne   L0D36
         lda   #$02
         ldb   #$02
         ldx   #$0000
         leau  ,x
         os9   I$SetStt 
         bcs   L0D9F
L0D9C    puls  pc,u,y,b,a
L0D9E    rts   
L0D9F    bsr   L0D3A
         lbra  L0A6F
L0DA4    clr   <u007D
         inc   <u007D
         pshs  x
         ldx   <u0080
         stx   <u0082
         puls  pc,x
L0DB0    lbsr  L00F6
         bne   L0DC8
         pshs  y
         lbsr  L0A86
         ldx   ,s
L0DBC    lda   ,y+
         sta   ,x+
         bpl   L0DBC
         lda   #$0D
         sta   ,x
         puls  y
L0DC8    lbsr  L0F7A
         lbcs  L0A75
         ldx   ,x
         stx   <u002F
         lda   $06,x
         beq   L0DDF
         anda  #$0F
         cmpa  #$02
         bne   L0E51
         bra   L0DE5
L0DDF    lda   <$17,x
         rora  
         bcs   L0E51
L0DE5    lbsr  L00F9
         ldy   <u004A
         ldb   ,y
         cmpb  #$3D
         beq   L0E51
         sty   <u005E
         sty   <u005C
         ldx   <u00AB
         stx   <u0060
         stx   <u004A
         ldd   <u000C
         pshs  y,b,a
         lbsr  L00FC
         puls  y,b,a
         std   <u000C
         sty   <u004A
         ldx   <u002F
         lda   <$17,x
         rora  
         bcs   L0E51
         leas  >$0102,s
         ldd   <u0000
         addd  <u0002
         tfr   d,y
         std   <u0046
         std   <u0044
         ldu   #$0000
         stu   <u0031
         stu   <u00B3
         inc   <u00B4
         clr   <u0036
         ldd   <u004A
         ldx   <u000C
         pshs  x,b,a
         leax  >L0E48,pcr
         lbsr  L0882
         ldx   <u004A
         lbsr  L0102
         lbsr  L0DA4
         ldx   <u002F
         lbsr  L0105
         bra   L0E4E
L0E48    puls  x,b,a
         std   <u004A
         stx   <u000C
L0E4E    lbra  L0878
L0E51    ldb   #$33
         lbra  L0A6F
         bsr   L0E78
         clrb  
         os9   F$Exit   
         lbsr  L00F6
         beq   L0E74
         lbsr  L0F57
         bcs   L0E74
         ldu   <u0046
         clra  
         clrb  
         pshu  x,b,a
         inca  
         sta   <u0035
         bsr   L0E88
         clr   <u0035
         rts   
L0E74    comb  
         ldb   #$2B
         rts   
L0E78    ldy   <u0082
         lda   #$2A
         sta   ,y
         sta   <u0035
L0E81    lbsr  L0C86
         clr   <u002F
         clr   <u0030
L0E88    ldu   <u0046
         stu   <u0044
         bra   L0ECC
L0E8E    ldx   ,x
         ldb   $06,x
         beq   L0EA9
         cmpb  #$22
         bne   L0E9E
         ldb   <$17,x
         lslb  
         bmi   L0EA9
L0E9E    pshs  u
         leau  ,x
         os9   F$UnLink 
         puls  u
         bra   L0EC7
L0EA9    tst   <u0035
         bne   L0ECC
         ldx   ,u
         lbsr  L0F9F
         ldy   ,x
         ldd   <u000A
         subd  $02,y
         std   <u000A
         ldd   $02,y
         addd  <u000C
         std   <u000C
         ldd   <u004A
         subd  $02,y
         std   <u004A
L0EC7    ldd   #$FFFF
         std   [,u]
L0ECC    ldx   ,--u
         bne   L0E8E
         ldx   <u0004
         tfr   x,y
L0ED4    ldd   ,x++
         cmpd  #$FFFF
         beq   L0ED4
L0EDC    std   ,y++
         bne   L0ED4
         cmpd  ,y
         bne   L0EDC
         rts   
L0EE6    bsr   L0F57
         bcs   L0EEB
         rts   
L0EEB    pshs  u,x
         tfr   x,d
         cmpb  #$FE
         beq   L0F52
         ldx   <u000C
         cmpx  #$00FF
         bcs   L0F52
         leax  <-$1C,x
         ldu   <u004A
         ldb   #$FF
L0F01    incb  
         clr   b,u
         cmpb  #$18
         bne   L0F01
L0F08    incb  
         leax  -$01,x
         beq   L0F52
         inc   <u0018,u
         lda   ,y+
         sta   b,u
         bpl   L0F08
         incb  
         stx   <u000C
         clra  
         std   <u0015,u
         std   u0009,u
         std   u000F,u
         stu   [,s]
         pshs  b
         addd  #$0003
         std   u0002,u
         std   u000D,u
         addd  <u000A
         std   <u000A
         ldd   #$87CD
         std   ,u
         ldd   #$0019
         std   u0004,u
         ldd   #$0081
         std   u0006,u
         ldd   #$0016
         std   u000B,u
         puls  b
         leax  d,u
         ldb   #$03
         sta   ,x+
         std   ,x++
         stx   <u004A
         puls  pc,u,x
L0F52    ldb   #$20
         lbra  L0A6F
L0F57    pshs  u,y
         ldx   <u0004
L0F5B    ldy   ,s
         ldu   ,x++
         beq   L0F77
         ldd   u0004,u
         leau  d,u
L0F66    lda   ,y+
         eora  ,u+
         anda  #$DF
         bne   L0F5B
         clra  
         tst   -u0001,u
         bpl   L0F66
L0F73    leax  -$02,x
         puls  pc,u,b,a
L0F77    coma  
         bra   L0F73
L0F7A    bsr   L0F57
         bcs   L0F7F
         rts   
L0F7F    pshs  u,y,x
         ldb   $01,s
         cmpb  #$FE
         beq   L0F52
         leax  ,y
         clra  
         clrb  
         os9   F$Link   
         bcc   L0F99
         ldx   $02,s
         clra  
         clrb  
         os9   F$Load   
         bcs   L0F9D
L0F99    stx   $02,s
         stu   [,s]
L0F9D    puls  pc,u,y,x
L0F9F    pshs  y,x
         ldd   <u0008
         addd  <u000A
         tfr   d,y
         ldx   ,x
         sty   [,s]
         ldd   $02,x
         bsr   L0FCC
         pshs  y,x,b,a
         ldx   <u0004
         bra   L0FC4
L0FB6    cmpd  $02,s
         bcs   L0FC4
         cmpd  $04,s
         bhi   L0FC4
         subd  ,s
         std   -$02,x
L0FC4    ldd   ,x++
         bne   L0FB6
         leas  $06,s
         puls  pc,y,x
L0FCC    pshs  u,y,x,b,a
         ldu   #$0000
         tfr   x,d
         subd  $04,s
         pshs  x,b,a
         addd  $04,s
         beq   L100B
L0FDB    lda   ,x
         pshs  a
         bra   L0FE9
L0FE1    lda   ,y
         sta   ,x
         leau  u0001,u
         tfr   y,x
L0FE9    tfr   x,d
         addd  $05,s
         cmpd  $09,s
         bcs   L0FF4
         addd  $01,s
L0FF4    tfr   d,y
         cmpd  $03,s
         bne   L0FE1
         puls  a
         sta   ,x
         leax  $01,y
         stx   $02,s
         leau  u0001,u
         tfr   u,d
         addd  ,s
         bne   L0FDB
L100B    leas  $04,s
         puls  pc,u,y,x,b,a
         pshs  u,y,x,b,a
         lda   <u0036
         cmpa  #$39
         beq   L1051
         tst   <u00A0
         bne   L1093
         inc   <u00A0
         lda   <u0035
         bne   L104D
         ldd   <u00B3
         subd  #$0001
         bhi   L1072
         bmi   L1037
L102A    lbsr  L0DA4
         leax  >L077A,pcr
         lbsr  L1343
         lbsr  L1236
L1037    leax  >L078D,pcr
         leay  >L06AA,pcr
         lbsr  L08BC
         bcc   L1037
         lda   <u0035
         bne   L104D
         lbsr  L08B5
         bra   L1037
L104D    cmpa  #$02
         bne   L102A
L1051    lbsr  L011D
         lda   #$03
L1056    cmpa  <u00BE
         beq   L105D
         os9   I$Close  
L105D    inca  
         cmpa  #$10
         bcs   L1056
         lbra  L0878
         lbsr  L0A79
         bne   L1077
         leax  ,y
         lbsr  L1731
         bcc   L107A
         rts   
L1072    bsr   L107A
         clrb  
         bra   L1079
L1077    ldb   #$01
L1079    clra  
L107A    std   <u00B3
         lsl   <u0034
         coma  
         ror   <u0034
         bra   L108F
         lbsr  L0DA4
         lsl   <u0034
         lsr   <u0034
         ldd   #$0001
         std   <u00B3
L108F    leas  $02,s
         clr   <u00A0
L1093    puls  pc,u,y,x,b,a
         ldy   <u0019
         jsr   ,y
         pshs  u,y,x,b,a
         cmpy  <u0046
         beq   L10CB
         ldb   <u007D
         ldx   <u0080
         ldu   <u0082
         pshs  u,x,b
         stu   <u0080
         lbsr  L0DA4
         lda   #$3D
         lbsr  L135C
         ldb   ,y
         addb  #$01
         cmpb  #$06
         bcc   L10C0
         leax  ,y
         lbsr  L1393
L10C0    lbsr  L124D
         puls  u,x,b
         stb   <u007D
         stx   <u0080
         stu   <u0082
L10CB    puls  pc,u,y,x,b,a
L10CD    lbsr  L1234
         tst   <$17,x
         bmi   L10F3
         ldx   <u005E
L10D7    clr   <u0074
L10D9    tst   <u0035
         bne   L10F3
         leay  ,x
         lbsr  L1BB2
         bsr   L10F5
         exg   x,y
         cmpx  <u0060
         bcs   L10D9
         cmpx  <u005C
         bne   L10F3
         cmpy  <u0060
         bcs   L10D9
L10F3    clra  
         rts   
L10F5    pshs  u,y,x
         lbsr  L0DA4
         ldx   <u002F
         tst   <$17,x
         bmi   L117C
         ldx   ,s
         tfr   y,d
         subd  ,s
         bmi   L1179
         pshs  x,b,a
         addd  #$0040
         cmpd  <u000C
         lbcc  L0F52
         tst   <u0084
         bmi   L1141
         lda   #$20
         cmpx  <u005C
         bhi   L1128
         beq   L1126
         cmpy  <u005C
         bls   L1128
L1126    lda   #$2A
L1128    lbsr  L135C
         cmpx  <u0060
         bcc   L1141
         tfr   x,d
         subd  <u005E
         ldx   <u0082
         lbsr  L0114
         lda   #$20
         sta   ,x+
         stx   <u0082
         lbsr  L1259
L1141    puls  y,b,a
         cmpy  <u0060
         bcc   L1179
         ldu   <u004A
         lbsr  L19D8
         lbsr  L11DB
         stu   <u005C
         leax  d,u
         stx   <u0060
         stx   <u004A
         leay  ,u
         tst   <u0084
         bmi   L116C
         leax  ,y
         lbsr  L1660
         bne   L116C
         leax  >L02D4,pcr
         lbsr  L1254
L116C    lbsr  L0DA4
         lbsr  L1AAF
         lbsr  L1274
         bsr   L11BE
         dec   <u0083
L1179    lbsr  L124D
L117C    puls  pc,u,y,x
         ldx   <u002F
         tst   <$17,x
         bpl   L1187
         coma  
         rts   
L1187    ldy   <u0080
         lbsr  L010B
         bsr   L11DB
         ldx   <u004A
         lbsr  L1660
         beq   L11BE
         stx   <u005E
         stx   <u005C
         leay  ,x
         ldx   <u00AB
         stx   <u0060
         stx   <u004A
         lbsr  L0117
         ldx   <u002F
         lda   <$17,x
         clr   <$17,x
         tsta  
         bne   L11BE
         leax  <L11BE,pcr
         lbsr  L0882
         ldx   <u005E
         lbsr  L0120
         lbra  L0878
L11BE    pshs  u,y,x,b,a
         ldu   <u0046
         pulu  y,x,b,a
         sty   <u000A
         stx   <u000C
         std   <u004A
         pulu  y,x,b,a
         sty   <u0060
         stx   <u005E
         std   <u005C
L11D4    stu   <u0046
         stu   <u0044
         clra  
         puls  pc,u,y,x,b,a
L11DB    pshs  u,y,x,b,a
         ldu   <u0046
         ldd   <u005C
         ldx   <u005E
         ldy   <u0060
         pshu  y,x,b,a
         ldd   <u004A
         ldx   <u000C
         ldy   <u000A
         pshu  y,x,b,a
         bra   L11D4
         ldy   <u0031
         leax  >L073F,pcr
L11FA    bsr   L120C
         lbsr  L1343
         ldx   $03,y
         bsr   L123F
         leax  >L0782,pcr
         ldy   $07,y
         bne   L11FA
L120C    lbra  L0DA4
         lbsr  L00F6
         beq   L1232
         lbsr  L0F57
         bcs   L1232
         ldx   ,x
         ldy   <u0031
L121E    ldy   $07,y
         beq   L1232
         cmpx  $03,y
         bne   L121E
         lsl   ,y
         coma  
         ror   ,y
         leax  >L078B,pcr
         bra   L1248
L1232    coma  
         rts   
L1234    bsr   L120C
L1236    leax  >L073F,pcr
         lbsr  L1343
         ldx   <u002F
L123F    pshs  x
         leax  <$19,x
         bsr   L124A
         puls  pc,x
L1248    bsr   L120C
L124A    lbsr  L137B
L124D    lbsr  L135A
         bsr   L1259
         bra   L120C
L1254    bsr   L120C
         lbsr  L137B
L1259    pshs  y,x,b,a
         ldd   <u0082
         subd  <u0080
         bls   L126E
         tfr   d,y
         ldx   <u0080
         lda   #$02
         os9   I$WritLn 
         bcc   L126E
         bsr   L1270
L126E    puls  pc,y,x,b,a
L1270    os9   F$PErr   
         rts   
L1274    ldy   <u005C
         cmpy  <u0060
         bcc   L12B8
         ldb   ,y
         cmpb  #$3A
         bne   L128C
         leay  $01,y
         lbsr  L13B8
         lbsr  L1345
         ldb   ,y
L128C    tst   <u0084
         bmi   L12A1
         bsr   L12E2
         ldb   <u0074
         pshs  b
         bsr   L12C1
         puls  a
         sta   <u0074
         tfr   b,a
         lbsr  L1337
L12A1    ldb   ,y+
         bmi   L12AD
         bsr   L12E2
         bsr   L12C1
         bsr   L12F5
         bra   L12B0
L12AD    lbsr  L1472
L12B0    cmpy  <u0060
         bcs   L12A1
L12B5    sty   <u005C
L12B8    lda   #$0D
         lbra  L135C
         leas  $02,s
         bra   L12B5
L12C1    sta   ,-s
         bmi   L12DF
         anda  #$03
         beq   L12DF
         cmpa  #$01
         bne   L12D1
         inc   <u0074
         bra   L12DF
L12D1    decb  
         bpl   L12D5
         clrb  
L12D5    cmpa  #$03
         beq   L12DF
         dec   <u0074
         bpl   L12DF
         clr   <u0074
L12DF    lda   ,s+
         rts   
L12E2    leax  >L03DE,pcr
         tstb  
         bpl   L12EB
         subb  #$2A
L12EB    lda   #$03
         mul   
         leax  d,x
         lda   ,x
         rts   
L12F3    bsr   L12E2
L12F5    leax  $01,x
         anda  #$60
         beq   L1301
         cmpa  #$60
         bne   L1313
         leay  $02,y
L1301    lda   -$01,x
         pshs  a
         ldd   ,x
         leax  d,x
         puls  a
         anda  #$18
         cmpa  #$10
         beq   L137B
         bra   L1341
L1313    cmpa  #$20
         bne   L131B
         ldd   ,x
         jmp   d,x
L131B    bsr   L1323
         bsr   L131F
L131F    lda   ,x+
         bne   L135C
L1323    lda   <u007D
         cmpa  #$41
         bcs   L1340
         lda   #$0A
         bsr   L135C
         clr   <u007D
         tst   <u0084
         bmi   L1340
         lda   <u0074
         adda  #$03
L1337    lsla  
         adda  #$06
         ldb   #$10
         lbsr  L0108
         clra  
L1340    rts   
L1341    bsr   L1345
L1343    bsr   L137B
L1345    pshs  u,b,a
         bsr   L1323
         bcc   L1358
         ldu   <u0082
         lda   #$20
         cmpa  -u0001,u
         beq   L1358
         cmpu  <u0080
         bne   L1360
L1358    puls  pc,u,b,a
L135A    lda   #$0D
L135C    pshs  u,b,a
         ldu   <u0082
L1360    sta   ,u+
         ldd   <u0082
         subd  <u0080
         tsta  
         bne   L136D
         inc   <u007D
         stu   <u0082
L136D    puls  pc,u,b,a
         lda   #$2E
         bsr   L135C
L1373    ldx   ,y++
         ldd   <u0062
         leax  d,x
         leax  $03,x
L137B    pshs  x
L137D    lda   ,x
         anda  #$7F
         bsr   L135C
         tst   ,x+
         bpl   L137D
         puls  pc,x
         ldb   #$03
         ldx   <u0044
         pshs  y,b
         leay  -$01,y
         bra   L1395
L1393    pshs  y,b
L1395    ldd   $04,y
         std   ,--x
         ldd   $02,y
         std   ,--x
         ldd   ,y
         std   ,--x
         leay  ,x
         puls  b
         bra   L13C5
         ldb   ,y
         clra  
         bra   L13BA
         leax  >L01EC,pcr
         bra   L13B6
         leax  >L01E6,pcr
L13B6    bsr   L1341
L13B8    ldd   ,y++
L13BA    pshs  y
         ldy   <u0044
         leay  -$06,y
         std   $01,y
         ldb   #$02
L13C5    lbsr  L0108
         puls  pc,y
L13CA    bsr   L13DA
L13CC    lda   ,y+
         cmpa  #$FF
         beq   L13DA
         bsr   L135C
         cmpa  #$22
         bne   L13CC
         bra   L13CA
L13DA    lda   #$22
L13DC    lbra  L135C
         lda   #$24
         bsr   L13DC
         ldb   #$14
         lbsr  L0108
         leay  $02,y
         rts   
         leax  >L0267,pcr
         lbsr  L1343
         lda   -$01,y
         adda  #$FB
         bra   L13DC
         leax  >L01F3,pcr
L13FC    lbsr  L1343
         lbra  L1373
         leax  >L0195,pcr
         leay  $01,y
         bsr   L13FC
         leay  $06,y
         rts   
         leax  >L029D,pcr
         lbsr  L1341
         lda   ,y
         cmpa  #$3A
         beq   L141C
         inc   <u0074
L141C    rts   
L141D    bvc   L13C9
         leax  >L141D,pcr
         bra   L1429
         leax  >L026D,pcr
L1429    lbsr  L1343
         ldb   ,y+
L142E    decb  
         beq   L141C
         lda   ,y+
         bsr   L13DC
L1435    bra   L142E
         com   <u00EF
         bita  <u0001
         std   ,--w
         aim   #$ED,<u00F2
         lsr   <u00EF
         anda  <u0080
         stu   [e,x]
         neg   <u00A6
         suba  -$0C,y
         aim   #$86,<u003A
L144D    bsr   L13DC
         leax  <L1435,pcr
L1452    leax  $02,x
         lda   ,s
         anda  ,x
         cmpa  ,x+
         bne   L1452
         tsta  
         beq   L1470
         eora  ,s
         sta   ,s
         ldd   ,x
         leax  d,x
         lbsr  L137B
         lda   #$2B
         tst   ,s
         bne   L144D
L1470    puls  pc,a
L1472    pshs  u
         ldu   <u0044
         clr   ,-u
         clr   ,-u
         leay  -$01,y
L147C    ldb   ,y
         bpl   L14AD
         lbsr  L12E2
         tfr   a,b
         lda   ,y+
         bitb  #$80
         bne   L147C
         orb   #$80
         pshu  b,a
         bitb  #$18
         bne   L147C
         andb  #$7F
         pshu  b,a
         bitb  #$04
         bne   L14A1
         ldd   ,y++
         std   u0002,u
         bra   L147C
L14A1    leay  -$01,y
         sty   u0002,u
         ldb   ,y+
         lbsr  L1B51
         bra   L147C
L14AD    sty   <u005C
         leay  ,u
         clra  
         clrb  
         std   ,--y
         pshs  b,a
         sta   <u00BF
         sta   <u00B1
L14BC    ldd   ,u++
         bitb  #$08
         beq   L14E7
         andb  #$07
         cmpb  <u00BF
         bhi   L14DB
         bne   L14D8
         cmpb  #$06
         bne   L14D4
         tst   <u00B1
         beq   L14D8
         bra   L14DB
L14D4    tst   <u00B1
         beq   L14DB
L14D8    lbsr  L156A
L14DB    stb   <u00BF
         orb   #$80
         std   ,--y
         lda   #$01
         sta   <u00B1
         bra   L14BC
L14E7    clr   <u00B1
         bitb  #$03
         beq   L1516
         bitb  #$04
         bne   L1516
         bitb  #$10
         bne   L14F9
         pulu  x
         stx   ,--y
L14F9    std   ,--y
         andb  #$03
         bsr   L156A
         cmpa  #$BE
         bne   L1508
         ldx   #$54FF
         stx   ,--y
L1508    ldx   #$4B80
         bra   L150F
L150D    stx   ,--y
L150F    decb  
         bne   L150D
         stb   <u00BF
L1514    bra   L14BC
L1516    bitb  #$10
         bne   L151E
         pulu  x
L151C    pshs  x
L151E    pshs  b,a
         cmpa  #$89
         bcs   L1528
         cmpa  #$8C
         bls   L14BC
L1528    ldd   ,y++
         tstb  
         bmi   L1533
         beq   L1541
         ldx   ,y++
         bra   L151C
L1533    pshs  b,a
         clr   $01,s
         bitb  #$10
         bne   L1528
         andb  #$07
         stb   <u00BF
         bra   L1514
L1541    ldx   ,u++
         beq   L1552
         pshu  x
         std   ,--y
         bra   L1514
L154B    puls  y
         ldb   ,y+
         lbsr  L12F3
L1552    ldd   ,s++
         beq   L1565
         bitb  #$04
         bne   L154B
         leay  ,s
         exg   a,b
         lbsr  L12F3
         leas  ,y
         bra   L1552
L1565    ldy   <u005C
         puls  pc,u
L156A    ldx   ,s
         pshs  x
         ldx   #$4E00
         stx   $02,s
         ldx   #$4DFF
         stx   ,--y
         rts   
         lbsr  L0A86
         lbsr  L0EE6
         ldy   ,x
         tst   $06,y
         bne   L15CE
         pshs  x
         lbsr  L1A17
         lbsr  L1234
         ldy   <u005E
         bsr   L15DC
L1593    lda   <u0035
         cmpa  #$02
         bne   L159C
         lbsr  L197C
L159C    leax  >L078F,pcr
         leay  >L0701,pcr
         lbsr  L08BC
         bcc   L1593
         tst   <u0035
         bne   L1593
         leax  >L1593,pcr
         pshs  x
         ldx   <u0080
         lsl   ,x
         lsr   ,x
         lbsr  L1731
         lbcs  L08B5
         lbsr  L19F6
         lda   ,x
         cmpa  #$0D
         beq   L15DC
         ldy   <u0080
         bra   L15EA
L15CE    coma  
         rts   
         leax  -$01,y
         lsl   ,x
         asr   ,x
         lbsr  L16DB
         lbsr  L16A6
L15DC    sty   <u005C
         lbsr  L166B
         leax  ,y
         lbsr  L1BB2
         lbra  L1696
L15EA    bsr   L15EF
         bcc   L15DC
         rts   
L15EF    tst   <u000C
         beq   L1659
         clr   <u00A0
         lbsr  L010B
         ldx   <u004A
         lda   ,x
         cmpa  #$3A
         bne   L1647
         clra  
         clrb  
         sta   ,-s
         ldy   <u005C
         lbsr  L19F9
         cmpy  <u0060
         bcc   L1618
         ldd   $01,x
         cmpd  $01,y
         bls   L1618
         inc   ,s
L1618    ldy   <u005E
         ldd   $01,x
         lbsr  L19F6
         tst   ,s+
         bne   L162B
         bcc   L162B
         cmpy  <u005C
         bcc   L1647
L162B    sty   <u005C
         cmpy  <u0060
         bcc   L1647
         ldx   <u004A
         ldd   $01,x
         cmpd  $01,y
         bne   L1647
         pshs  y
         lbsr  L1BB2
         tfr   y,d
         subd  ,s++
         bra   L1649
L1647    clra  
         clrb  
L1649    ldy   <u005C
         lbsr  L199A
         ldx   <u005C
         bsr   L1660
         bne   L1657
         leay  ,x
L1657    clra  
         rts   
L1659    ldb   #$20
         lbsr  L1270
         coma  
         rts   
L1660    lda   ,x
         cmpa  #$3A
         bne   L1668
         lda   $03,x
L1668    cmpa  #$3D
         rts   
L166B    ldx   #$0000
         ldy   <u005E
L1671    cmpy  <u005C
         bcc   L1680
         leax  $01,x
         lbsr  L1BB2
         cmpy  <u0060
         bcs   L1671
L1680    sty   <u005C
         stx   <u00B5
         clra  
         rts   
         bsr   L16B7
         bsr   L16A6
         cmpx  <u005E
         bhi   L1696
         pshs  y,x
         lbsr  L1234
         puls  y,x
L1696    ldd   <u0060
         pshs  b,a
         sty   <u0060
         lbsr  L10D7
         puls  b,a
         std   <u0060
         clra  
         rts   
L16A6    pshs  x,b
         ldx   <u0082
         ldb   ,x
         cmpb  #$0D
         bne   L16B2
         puls  pc,x,b
L16B2    leas  $05,s
         lbra  L08B5
L16B7    lda   ,y+
         cmpa  #$20
         beq   L16B7
         cmpa  #$2A
         bne   L16CA
         sty   <u0082
         ldx   <u005E
         ldy   <u0060
         rts   
L16CA    leax  -$01,y
         bsr   L16DB
         bcs   L16DA
         ldx   <u005C
         cmpy  <u005C
         bcc   L16DA
         exg   x,y
         clra  
L16DA    rts   
L16DB    clr   ,-s
         ldd   ,x
         cmpa  #$2B
         bne   L16F0
         ldy   <u0060
L16E6    cmpb  #$2A
         bne   L16FB
         leax  $02,x
         stx   <u0082
         puls  pc,a
L16F0    cmpa  #$2D
         bne   L16FD
         inc   ,s
         ldy   <u005E
         bra   L16E6
L16FB    leax  $01,x
L16FD    lda   ,x
         cmpa  #$30
         bcs   L1707
         cmpa  #$39
         bls   L170C
L1707    ldd   #$0001
         bra   L1710
L170C    bsr   L1731
         bcs   L172B
L1710    stx   <u0082
         ldy   <u005C
         tst   ,s+
         beq   L1726
         ldy   <u005E
         pshs  b,a
         ldd   <u00B5
         subd  ,s++
         bcc   L1726
         clra  
         clrb  
L1726    lbsr  L1BB8
         clra  
         rts   
L172B    ldy   <u005C
         com   ,s+
         rts   
L1731    ldy   <u0046
         lbsr  L0123
         lda   ,y+
         cmpa  #$02
         beq   L1742
         clra  
         ldd   ,y
         bne   L1743
L1742    coma  
L1743    rts   
         clrb  
         bra   L1749
         ldb   #$01
L1749    leas  -$0F,s
         stb   ,s
         lda   ,y
         clr   $01,s
         cmpa  #$2A
         bne   L1759
         sta   $01,s
         leay  $01,y
L1759    ldb   ,y+
         cmpb  #$20
         beq   L1759
         tfr   b,a
         sty   <u0082
         lbsr  L1893
         stu   $02,s
         lbmi  L196E
         tst   ,s
         beq   L177A
         lbsr  L1893
         stu   $04,s
         lbmi  L196E
L177A    cmpa  #$0D
         beq   L1786
         lda   ,y+
         cmpa  #$0D
         lbne  L196E
L1786    ldu   <u0046
         stu   $0D,s
L178A    lda   ,-y
         sta   ,-u
         cmpy  <u0082
         bhi   L178A
         stu   <u0046
         stu   <u0044
         ldd   $02,s
         leau  d,u
         leau  u0001,u
         stu   $06,s
         ldy   <u005C
         sty   $0B,s
         clr   $0A,s
         lbra  L1861
L17AA    lbsr  L0DA4
         sty   <u005C
         lbsr  L1274
         ldy   <u0080
         leay  $05,y
         lsl   $0A,s
         asr   $0A,s
L17BC    tst   <u0035
         bne   L1823
         ldd   <u0082
         subd  $02,s
         ldx   <u0046
         lbsr  L18A7
         bcs   L1818
         lda   #$81
         sta   $0A,s
         tst   ,s
         beq   L1818
         ldd   <u0082
         addd  $04,s
         subd  $02,s
         subd  <u0080
         cmpd  #$00E6
         bhi   L1818
         ldx   <u0082
         exg   x,y
         ldd   $02,s
         lbsr  L0FCC
         tfr   y,d
         subd  $02,s
         tfr   d,y
         ldu   $06,s
         pshs  x,b,a
L17F4    lda   ,u+
         sta   ,y+
         cmpa  #$FF
         bne   L17F4
         leay  -$01,y
         ldd   ,s++
         subd  ,s
         puls  x
         lbsr  L0FCC
         sty   <u0082
         ldd   $04,s
         leay  d,x
         ldd   $02,s
         bne   L1814
         leay  $01,y
L1814    tst   $01,s
         bne   L17BC
L1818    tst   $0A,s
         bpl   L185B
         ldy   $08,s
         ldd   ,s
         bne   L182E
L1823    ldx   $0D,s
         stx   <u0046
         stx   <u0044
         leas  $0F,s
         lbra  L15DC
L182E    lbsr  L1259
         sty   $0B,s
         tst   ,s
         beq   L185B
         leax  ,y
         lbsr  L1BB2
         lbsr  L198E
         sty   <u005C
         ldy   <u0080
         lbsr  L15EF
         sty   <u005C
         ldy   $08,s
         lbsr  L1BB2
         cmpy  <u005C
         bne   L186B
         tst   $01,s
         beq   L186B
L185B    ldy   $08,s
         lbsr  L1BB2
L1861    sty   $08,s
         cmpy  <u0060
         lbcs  L17AA
L186B    lbsr  L0DA4
         tst   $0A,s
         bne   L1882
         leax  >L0793,pcr
         lbsr  L1343
         ldy   <u0046
         lbsr  L13CA
         lbsr  L124D
L1882    ldy   $0B,s
         sty   <u005C
         ldx   $0D,s
         stx   <u0046
         stx   <u0044
         leas  $0F,s
         lbra  L166B
L1893    ldu   #$FFFF
L1896    cmpa  #$0D
         beq   L18A2
         leau  u0001,u
         lda   ,y+
         cmpb  -$01,y
         bne   L1896
L18A2    clr   -$01,y
         com   -$01,y
         rts   
L18A7    pshs  b,a
         bra   L18BB
L18AB    pshs  y,x
L18AD    lda   ,x+
         cmpa  #$FF
         beq   L18C3
         cmpa  ,y+
         beq   L18AD
         puls  y,x
         leay  $01,y
L18BB    cmpy  ,s
         bls   L18AB
         coma  
         puls  pc,b,a
L18C3    puls  y,x
         clra  
         puls  pc,b,a
         ldd   #$0064
         ldx   #$000A
         pshs  x,b,a
         leax  ,y
         ldy   <u00B5
         lda   ,x
         cmpa  #$2A
         bne   L18E3
         ldy   #$0000
L18DF    leax  $01,x
         lda   ,x
L18E3    cmpa  #$20
         beq   L18DF
         pshs  y
         cmpa  #$0D
         beq   L1905
         lbsr  L1731
         bcs   L196A
         std   $02,s
         lda   ,x+
         cmpa  #$0D
         beq   L1905
         lbsr  L1731
         bcs   L196A
         std   $04,s
         bmi   L196A
         lda   ,x
L1905    cmpa  #$0D
         bne   L196A
         bsr   L197E
         ldd   ,s++
         ldy   <u005E
         lbsr  L1BB8
         sty   <u005C
         ldd   ,s
         lbsr  L19F6
         clr   ,-s
         cmpy  <u005C
         bcs   L1973
         bsr   L1949
         cmpx  #$0000
         ble   L1973
         tst   <u0035
         bne   L1935
         tst   <u0035
         bne   L1935
         inc   ,s
         bsr   L1949
L1935    leas  $05,s
         ldx   $02,s
         lbsr  L1A17
         ldy   <u005E
         ldd   <u00B5
         lbsr  L1BB8
         sty   <u005C
         clra  
         rts   
L1949    ldy   <u005C
         ldx   $03,s
L194E    clra  
         clrb  
         lbsr  L19F9
         cmpy  <u0060
         bcc   L1969
         tst   $02,s
         beq   L195E
         stx   $01,y
L195E    lbsr  L1BB2
         tfr   x,d
         addd  $05,s
         tfr   d,x
         bpl   L194E
L1969    rts   
L196A    leas  $06,s
         bra   L1970
L196E    leas  $0F,s
L1970    lbra  L08B5
L1973    leax  >L0774,pcr
         lbsr  L1248
         bra   L1935
L197C    leas  $04,s
L197E    lbsr  L0111
         clra  
         rts   
         lbsr  L16B7
         lbsr  L16A6
         bsr   L198E
         lbra  L15DC
L198E    ldd   <u004A
         std   <u00AB
         tfr   y,d
         pshs  x
         subd  ,s++
         leay  ,x
L199A    pshs  u,y,x,b,a
         leax  d,y
         pshs  x
         ldy   <u00AB
         ldd   <u004A
         subd  ,s
         beq   L19AC
         lbsr  L0FCC
L19AC    ldd   <u00AB
         ldu   ,s
         subd  ,s++
         bls   L19BA
         ldy   $04,s
         lbsr  L010E
L19BA    ldd   <u00AB
         subd  <u004A
         ldy   $04,s
         leay  d,y
         sty   $04,s
         subd  ,s++
         pshs  b,a
         addd  <u0060
         std   <u0060
         std   <u004A
         ldd   <u000C
         subd  ,s
         std   <u000C
         puls  pc,u,y,x,b,a
L19D8    pshs  y,x,b,a
         leay  d,y
         leau  d,u
         andb  #$03
L19E0    beq   L19EF
         lda   ,-y
         sta   ,-u
         decb  
         bra   L19E0
L19E9    ldx   ,--y
         ldd   ,--y
         pshu  x,b,a
L19EF    cmpy  $04,s
         bne   L19E9
         puls  pc,y,x,b,a
L19F6    ldy   <u005E
L19F9    pshs  b,a
         bra   L1A00
L19FD    lbsr  L1BB2
L1A00    cmpy  <u0060
         bcc   L1A14
         lda   ,y
         cmpa  #$3A
         bne   L19FD
         ldd   ,s
         cmpd  $01,y
         bhi   L19FD
         puls  pc,b,a
L1A14    coma  
         puls  pc,b,a
L1A17    pshs  u,y,x,b,a
         lbsr  L0F9F
         ldx   ,x
         stx   <u002F
         ldd   $09,x
         addd  <u002F
         std   <u005E
         ldd   $0F,x
         addd  <u002F
         std   <u0060
         std   <u004A
         ldd   $02,x
         subd  $0F,x
         pshs  b,a
         ldd   <u0000
         addd  <u0002
         subd  ,s
         tfr   d,u
         std   <u0066
         ldd   <u002F
         addd  $0F,x
         tfr   d,y
         puls  b,a
         bsr   L19D8
         ldd   $0D,x
         subd  $0F,x
         subd  #$0003
         std   <u0068
         addd  <u0066
         addd  #$0003
         std   <u0062
         ldd   $02,x
         subd  $0D,x
         addd  #$0003
         std   <u0064
         ldy   <u005E
         bsr   L1AAF
         ldx   <u0062
         ldd   -$03,x
         beq   L1A87
L1A6C    pshs  b,a
         leau  ,x
         leax  $03,x
L1A72    ldb   ,x+
         bpl   L1A72
         lda   #$02
         cmpb  #$A4
         bne   L1A7E
         lda   #$04
L1A7E    sta   ,u
         puls  b,a
         subd  #$0001
         bgt   L1A6C
L1A87    ldx   <u0066
         ldd   <u0068
         leax  d,x
         stx   <u00DA
         stx   <u0066
         addd  <u000C
         std   <u000C
         clr   <u0068
         clr   <u0069
         puls  pc,u,y,x,b,a
L1A9B    ldb   ,y+
         bpl   L1AA1
         subb  #$2A
L1AA1    clra  
         leax  >L1BBE,pcr
         ldb   d,x
         lsrb  
         lsrb  
         lsrb  
         lsrb  
         lbsr  L1B5E
L1AAF    cmpy  <u0060
         bcs   L1A9B
         rts   
L1AB5    daa   
         lbsr  L2FFC
         pshs  u,b,a
         bgt   L1B0A
         mul   
         brn   L1B13
         exg   x,0
         orcc  #$0F
         lda   -$01,y
         adda  #$93
         sta   -$01,y
         leay  $01,y
L1ACC    leay  $01,y
         rts   
         dec   -$01,y
         dec   -$01,y
         dec   -$01,y
         rts   
         ldd   ,y
         addd  <u005E
         tfr   d,x
         ldd   -$02,x
         std   ,y++
         dec   -$03,y
         rts   
         lda   ,y+
         cmpa  #$85
         bne   L1AEC
         leay  $09,y
         rts   
L1AEC    clrb  
         bsr   L1B0C
         leay  $07,y
         rts   
         lda   ,y
         cmpa  #$4F
         bne   L1ACC
         leay  $05,y
         rts   
L1AFB    lda   ,y+
         cmpa  #$FF
         bne   L1AFB
         rts   
         ldb   ,y
         clra  
         leay  d,y
         rts   
         ldb   -$01,y
L1B0A    andb  #$04
L1B0C    lda   #$60
         pshs  b,a
         lda   #$85
         sta   -$01,y
         ldx   <u0062
         ldd   -$03,x
         ldu   ,y
         bra   L1B29
L1B1C    puls  b,a
L1B1E    subd  #$0001
         beq   L1B4E
         leax  $03,x
L1B25    tst   ,x+
         bpl   L1B25
L1B29    cmpu  $01,x
         bne   L1B1E
         pshs  b,a
         lda   ,x
         anda  #$E0
         cmpa  $02,s
         bne   L1B1C
         lda   ,x
         anda  #$18
         bne   L1B1C
         lda   ,x
         anda  #$04
         eora  $03,s
         bne   L1B1C
         tfr   x,d
         subd  <u0062
         std   ,y++
         leas  $02,s
L1B4E    leas  $02,s
         rts   
L1B51    tstb  
         bpl   L1B56
         subb  #$2A
L1B56    leax  <L1BBE,pcr
         clra  
         ldb   d,x
         andb  #$0F
L1B5E    leax  >L1AB5,pcr
         ldb   b,x
         jmp   b,x
L1B66    pshs  u
         ldb   ,y+
L1B6A    cmpb  ,u+
         bhi   L1B6A
         puls  u
         beq   L1B7A
         bsr   L1B51
L1B74    cmpy  <u0060
         bcs   L1B66
         coma  
L1B7A    puls  pc,u,x,b,a
L1B7C    tfr   y,x
         abx   
         stu   >$3456
         leau  >L1B7C,pcr
         bra   L1B74
L1B88    fcb   $3E >
L1B89    swi   
         fcb   $FF 
         pshs  u,x,b,a
         leau  <L1B88,pcr
         bra   L1B74
L1B92    pshs  u,x,b,a
         leau  <L1B89,pcr
         bra   L1B74
L1B99    bls   L1B20
         lda   #$87
         eora  #$89
         ora   #$8B
         cmpx  #$F2F3
         andb  >$F5F6
         stb   >$F8F9
         stu   >$3456
         leau  <L1B99,pcr
         bra   L1B74
L1BB2    clra  
         clrb  
L1BB4    bsr   L1B92
         bcs   L1BBD
L1BB8    subd  #$0001
         bcc   L1BB4
L1BBD    rts   
L1BBE    neg   <u0000
         neg   <u0000
         neg   <u0000
         neg   <u0000
         neg   <u0000
         neg   <u0000
         neg   <u0000
         neg   <u0000
         neg   <u0022
         neg   <u0000
         lsr   $00,x
         bhi   L1BD6
L1BD6    neg   <u0000
         bhi   L1BDA
L1BDA    bhi   L1BDC
L1BDC    neg   <u0022
         sbca  <u0022
         sbca  <u0022
         neg   <u0000
         neg   <u0000
         neg   <u0000
         neg   <u0000
         neg   <u0000
         neg   <u0000
         neg   <u0000
         neg   <u0000
         neg   <u0000
         neg   <u0077
         asr   >$0022
         sbca  <u0077
         asr   >$0000
         neg   <u0000
         neg   <u0000
         suba  #$00
         bhi   L1C28
         neg   <u0000
         fcb   $11 
         neg   <u0000
         neg   <u0000
         neg   <u0000
         neg   <u0000
         neg   <u0000
         bhi   L1BB7
         sbca  ,-y
         sbca  ,-y
         bhi   L1C3D
         bhi   L1C3F
         bhi   L1C41
         bhi   L1C43
         fcb   $11 
         bhi   L1C57
         fcb   $55 U
         bhi   L1C27
L1C27    neg   <u0000
         neg   <u0000
         neg   <u0000
         suba  >$0000
         neg   <u0000
         suba  >$0000
         neg   <u0000
         neg   <u0000
         neg   <u0000
         suba  >$0000
         neg   <u00B0
         neg   <u00B0
         neg   <u00B0
         neg   <u00B0
         neg   <u00B0
         neg   <u0000
         neg   <u0000
         neg   <u0000
         neg   <u0000
         neg   <u0000
         neg   <u0000
         neg   <u0000
         neg   <u0000
         neg   <u00B0
         neg   <u0000
         neg   <u0000
         neg   <u0000
         neg   <u0000
         neg   <u00B0
         neg   <u0000
         neg   <u0000
         suba  >$C000
         suba  >$C000
         suba  >$C0D0
         neg   <u00B0
         subb  #$D0
         neg   <u00B0
         subb  #$00
         suba  >$C000
         suba  >$C000
         suba  >$00B0
         neg   <u00B0
         neg   <u0000
         sbcb  ,-s
         sbcb  ,-s
         sbcb  ,-s
         sbcb  ,-s
         pshs  x,b,a
         ldb   [<$04,s]
         leax  <L1C9E,pcr
         ldd   b,x
         leax  d,x
         stx   $04,s
         puls  pc,x,b,a
L1C9E    aim   #$E9,<u0007
         tim   #$08,>$7508
         comb  
         lsl   <u0008
         oim   #$74,<u009D
         fcb   $1B 
         aim   #$9D,<u001B
         lsr   <u009D
         fcb   $1B 
         ror   <u009D
         bpl   L1CB6
L1CB6    jsr   <u001B
         nop   
         neg   <u0021
         com   <u00CB
         adcb  <u000A
         cwai  #$BE
         addb  #$D9
         dec   <u003E
         cmpx  >$CBE4
         dec   <u003C
         jsr   >$CBE4
         dec   <u003D
L1CCF    cmpx  >$CBE1
         dec   <u003E
         jsr   >$CBE1
         dec   <u003D
         ldx   >$CB52
         lsl   <u003A
         jsr   >$CBF1
         eim   #$2A,<u00AA
         addb  #$38
         oim   #$28,<u00AA
         addb  #$3E
         aim   #$DC,<u00CB
         addd  <u000A
         ldx   >$CBD6
         dec   <u00BC
         addb  #$DD
         rol   <u00BD
         addb  #$E7
         eim   #$AB,<u00CB
         orb   $05,x
         jsr   d,u
         ldd   $05,x
         ora   d,u
         ldu   $05,x
         stx   d,u
         subb  >$05DE
         addb  #$4C
         inc   <u00BA
         addb  #$4F
         inc   <u00DB
         addb  #$50
         inc   <u00DD
         addb  #$51
         inc   <u00BB
         addb  #$54
         tim   #$A3,<u00CB
         bne   L1D25
         stx   >$CB37
         oim   #$A1,<u00A1
         neg   <u000C
         ora   #$CB
         fcb   $4B K
         inc   <u00AC
         addb  #$4D
         inc   <u00A8
         addb  #$4E
         inc   <u00A9
         andb  <u0089
         inc   <u00AE
         brn   L1CCF
         ror   <u00A2
         neg   <u0091
         ror   <u00A4
         addb  #$3F
         aim   #$8D,<u0003
         adda  >$0122
         oim   #$12,<u0001
         bhi   L1D53
         com   >$02C9
         com   <u00AB
         com   <u00AB
         com   <u00AB
         aim   #$C9,<u0003
         adda  $03,x
         adda  $03,x
         adda  $03,x
         addd  #$03BB
         oim   #$81,<u0001
         ora   #$01
         stx   <u0003
         adda  $01,x
         subd  $01,x
         andb  #$01
         ldu   #$01DD
         com   <u00AB
         oim   #$D9,<u0003
         adda  $01,x
         std   <u0001
         cmpb  $01,x
         std   <u0001
         ldd   $03,x
         ldd   <u0002
         beq   L1D8D
         adda  >$0227
L1D8D    com   <u00BB
         aim   #$54,<u0003
         ldd   <u0002
         lda   <u0002
         adcb  #$03
         ldd   <u0003
         ldd   <u0003
         leau  $03,x
         leau  $03,x
         bls   L1DA4
         orb   >$0307
         com   <u0011
         com   <u0011
         com   <u0072
         com   <u007C
         com   <u00DC
         com   <u00DC
         com   <u00DC
         com   <u0080
         com   <u0080
         com   <u0098
         com   <u0098
         aim   #$C9,<u0096
         tim   #$34,<u0002
         ldx   <u00A7
         lda   #$0D
L1DC5    lsl   ,x
         lsr   ,x
         cmpa  ,x+
         bne   L1DC5
         ldx   <u00A7
         bsr   L1E08
         ldd   <u00B9
         subd  <u00A7
         pshs  b
         ldx   <u00AF
         stx   <u00AB
         ldy   <u00A7
         lda   #$3D
         lbsr  L23FE
         lbsr  L20E1
         lbsr  L23FE
         lda   #$20
         ldx   <u0080
L1DED    sta   ,x+
         dec   ,s
         bpl   L1DED
         ldd   #$5E0D
         std   -$01,x
         ldx   <u0080
         bsr   L1E08
         puls  b,a
         lbsr  L1CAA
         ldx   <u0046
         stx   <u0044
L1E05    lbra  L1CB0
L1E08    ldy   #$0100
         lda   <u002E
         os9   I$WritLn 
         rts   
         puls  x
         lbsr  L1CAD
         lbsr  L1F79
         lbsr  L2135
         sty   <u00A7
         ldx   <u00AB
         stx   <u00AF
L1E24    bsr   L1E35
         lda   <u00A3
         lbsr  L23FE
         cmpa  #$3E
         beq   L1E24
         cmpa  #$3F
         bne   L1DBD
         bra   L1E05
L1E35    lbsr  L2327
         lda   <u00A4
         cmpa  #$01
         bne   L1E4B
         ldb   <u00A3
         clra  
         lslb  
         rola  
         leax  >L1D49,pcr
         ldd   d,x
         jmp   d,x
L1E4B    cmpa  #$02
         lbne  L210F
L1E51    pshs  x
         ldx   <u00AB
         leax  -$01,x
         stx   <u00AB
         puls  pc,x
         lbsr  L2150
         cmpa  #$DD
         lbne  L2108
         bsr   L1E51
         lda   #$53
         lbsr  L23FE
L1E6B    lbsr  L2150
         cmpa  #$4D
         bne   L1E84
         lbsr  L2157
         bne   L1E7F
         lbsr  L2157
         bne   L1E7F
         lbsr  L2157
L1E7F    lbsr  L22A8
         bsr   L1EB2
L1E84    lbsr  L218A
         beq   L1E6B
         cmpa  #$4C
         bne   L1EAC
         bsr   L1EB2
         ldb   <u00A4
         cmpb  #$00
         beq   L1EAA
         cmpb  #$03
         bne   L1EB5
         cmpa  #$44
         bne   L1EAA
         bsr   L1EB2
         cmpa  #$4F
         bne   L1EAC
         lbsr  L2157
         cmpa  #$50
         bne   L1EB5
L1EAA    bsr   L1EB2
L1EAC    cmpa  #$51
         beq   L1E6B
         bra   L1E51
L1EB2    lbra  L2327
L1EB5    lda   #$18
         bra   L1F1F
L1EB9    lbsr  L23FE
         bsr   L1F06
         lbsr  L218A
         beq   L1EB9
L1EC3    lda   #$55
L1EC5    lbsr  L23FE
         bra   L1F14
         lbsr  L2125
         lbsr  L218F
         lbra  L2122
         bsr   L1F22
         cmpa  #$45
         bne   L1EE4
         lbsr  L23FE
         lbsr  L2135
         bcc   L1F28
         lbra  L1E35
L1EE4    lda   #$26
         bra   L1F1F
         bsr   L1F14
         bra   L1F32
         lbsr  L217C
         lbsr  L2116
         lda   <u00A3
         cmpa  #$46
         bne   L1F09
         bsr   L1F04
         lda   <u00A3
         cmpa  #$47
         bne   L1EC3
         bsr   L1F04
         bra   L1EC3
L1F04    bsr   L1EC5
L1F06    lbra  L2125
L1F09    lda   #$27
         bra   L1F1F
         lbsr  L217C
         bsr   L1F14
         bsr   L1F14
L1F14    lbra  L215F
         bsr   L1F22
         cmpa  #$48
         beq   L1F30
         lda   #$1F
L1F1F    lbra  L1DBF
L1F22    bsr   L1F06
         bra   L1EC3
         bsr   L1F14
L1F28    bra   L1F76
         bsr   L1F22
         cmpa  #$45
         bne   L1EE4
L1F30    bsr   L1F9A
L1F32    lbra  L1E35
         ldd   <u00AB
         pshs  y,b,a
         lbsr  L2327
         cmpa  #$1E
         bne   L1F49
         leas  $04,s
         bsr   L1F76
         cmpa  #$1F
         beq   L1F73
         rts   
L1F49    puls  y,b,a
         std   <u00AB
         bsr   L1F22
         ldx   <u00AB
         leax  -$01,x
         pshs  x
         cmpa  #$1F
         beq   L1F65
         cmpa  #$21
         beq   L1F65
         lda   #$21
         bra   L1F1F
L1F61    bsr   L1F9A
         lda   #$3A
L1F65    inc   [,s]
         bsr   L1F73
         lbsr  L218A
         beq   L1F61
         puls  pc,x
         lbsr  L20F7
L1F73    lbsr  L213F
L1F76    lbra  L20F4
L1F79    sty   <u00A7
         ldx   <u004A
         stx   <u00AF
         stx   <u00AB
         clr   <u00BB
         clr   <u00BC
         rts   
         bsr   L1F79
         inc   <u00A0
         lbsr  L20F4
         bsr   L1FA9
         clr   <u00A0
         lda   <u00A3
         cmpa  #$3F
         lbne  L1DBD
L1F9A    lbra  L23FE
         lbsr  L20F7
         pshs  x
         lbsr  L217C
         ldb   #$23
         stb   [,s++]
L1FA9    cmpa  #$4D
         bne   L1FDE
L1FAD    bsr   L1F9A
         ldd   <u00AB
         pshs  y,b,a
         lbsr  L2327
         ldd   #$0005
         cmpa  <u00A4
         beq   L1FC1
         stb   <u00A4
         bra   L1FC4
L1FC1    lbsr  L216B
L1FC4    puls  y,b,a
         std   <u00AB
         ldb   <u00A4
         cmpb  #$05
         beq   L1FD1
         lbsr  L2246
L1FD1    lbsr  L22FD
         lbsr  L218A
         beq   L1FAD
         pshs  a
         lbra  L22E0
L1FDE    rts   
         sty   <u00A9
         lbsr  L216F
         bne   L1FF0
         sty   <u00A9
         bsr   L200B
         bsr   L1F9A
         bsr   L1F76
L1FF0    ldy   <u00A9
         cmpa  #$90
         bne   L2003
         lbsr  L2327
         lbsr  L1F76
L1FFD    bsr   L200B
L1FFF    lda   #$4B
         bsr   L2069
L2003    bsr   L205C
         lbsr  L2184
         beq   L1FFF
L200A    rts   
L200B    lbsr  L2184
         beq   L200A
         bra   L2066
         sty   <u00A9
         lbsr  L216F
         beq   L2023
         cmpa  #$49
         beq   L2027
L201E    ldy   <u00A9
         bra   L202E
L2023    cmpa  #$49
         bne   L203D
L2027    lbsr  L2122
         bra   L203D
L202C    bsr   L2069
L202E    lbsr  L2446
         cmpa  #$0D
L2033    lbeq  L20F4
         cmpa  #$5C
         beq   L2033
         bsr   L206E
L203D    lbsr  L2184
         beq   L202C
         rts   
         sty   <u00A9
         lbsr  L216F
         beq   L1FFD
         ldy   <u00A9
         bra   L2003
         sty   <u00A9
         lbsr  L216F
         beq   L203D
         bra   L201E
         bsr   L2061
L205C    inc   <u00BC
         lbra  L2169
L2061    lbsr  L216F
         bne   L20C0
L2066    lbsr  L218F
L2069    lbra  L23FE
         bsr   L2061
L206E    lbra  L2125
L2071    bge   L2074
         blt   L2077
         stb   >$03F8
         lsr   <u00F9
         suba  #$00
         lbsr  L2327
         cmpa  #$54
         bne   L20C0
         bsr   L205C
         bsr   L2066
         bsr   L206E
         lda   <u00A3
         cmpa  #$4C
         bne   L20FD
         lda   #$4A
         bsr   L2069
         clr   ,-s
L2095    bsr   L20F4
         leax  <L2071,pcr
L209A    cmpa  ,x++
         bhi   L209A
         bne   L20B0
         ldb   -$01,x
         orb   ,s
         stb   ,s
         bsr   L20F4
         cmpa  #$E7
         beq   L2095
         lda   ,s+
         bne   L2069
L20B0    lda   #$0F
         bra   L20C2
L20B4    lbsr  L218A
         bne   L20FD
         bsr   L2069
         lbsr  L216F
         beq   L20B4
L20C0    lda   #$1C
L20C2    lbra  L1DBF
         bsr   L2135
         bra   L20F4
         lbsr  L2446
         leay  $01,y
         suba  #$30
         beq   L20F4
         cmpa  #$01
         lbne  L21B2
         bsr   L20F7
         lda   #$36
         lbsr  L23FE
         bra   L20F4
L20E1    ldx   <u00AB
         lbsr  L2446
         clra  
L20E7    lbsr  L23FE
         inc   ,x
         lda   ,y+
         cmpa  #$0D
         bne   L20E7
         leay  -$01,y
L20F4    lbsr  L2327
L20F7    ldx   <u00AD
         stx   <u00AB
         lda   <u00A3
L20FD    rts   
L20FE    lda   <u00A4
         cmpa  #$00
         beq   L20FD
         lda   #$0C
         bra   L20C2
L2108    lda   #$1B
L210A    bra   L20C2
         lbsr  L2327
L210F    bsr   L20FE
         inc   <u00BC
         lbsr  L21E5
L2116    lda   <u00A3
         cmpa  #$52
         beq   L2122
         cmpa  #$DD
         bne   L2108
         lda   #$53
L2122    lbsr  L23FE
L2125    lda   #$39
L2127    ldx   <u0044
         clrb  
         lbsr  L22A3
L212D    bsr   L219D
         lbsr  L224B
         bcc   L212D
L2134    rts   
L2135    lbsr  L2446
         lbsr  L2457
         bcs   L2134
         lda   #$3A
L213F    bsr   L2166
         lbsr  L238F
         beq   L214C
         ldd   ,x
         lbgt  L23F5
L214C    lda   #$10
         bra   L210A
L2150    bsr   L2154
         bsr   L20FE
L2154    lbra  L1EB2
L2157    lda   #$8E
         bsr   L213F
         bsr   L2154
         bra   L218A
L215F    clra  
         bsr   L2166
         bsr   L2166
         bra   L2177
L2166    lbra  L23FE
L2169    bsr   L2154
L216B    bsr   L20FE
         bra   L21E5
L216F    bsr   L20F4
         cmpa  #$54
         bne   L217B
         bsr   L2122
L2177    lda   <u00A3
         cmpa  <u00A3
L217B    rts   
L217C    bsr   L2154
         lbsr  L20FE
L2181    lbra  L20F4
L2184    lda   <u00A3
         cmpa  #$51
         beq   L218E
L218A    lda   <u00A3
         cmpa  #$4B
L218E    rts   
L218F    bsr   L218A
         beq   L218E
         lda   #$1D
         bra   L21B4
L2197    clrb  
         bsr   L21DE
         lbsr  L20F7
L219D    bsr   L21D3
         bsr   L21B7
         cmpa  #$4D
         beq   L2197
         ldb   <u00A4
         cmpb  #$06
         beq   L2181
         cmpb  #$04
         bne   L216B
         lbra  L22B3
L21B2    lda   #$12
L21B4    lbra  L1DBF
L21B7    cmpa  #$CD
         beq   L21CC
         cmpa  #$EA
         bne   L218E
         lda   ,y
         lbsr  L2457
         bcc   L21D6
         cmpa  #$2E
         beq   L21D6
         lda   #$CE
L21CC    ldb   #$07
         bsr   L21DE
         lbsr  L20F7
L21D3    lbra  L2327
L21D6    leay  -$01,y
         lbsr  L1E51
         lbra  L2363
L21DE    ldx   <u0044
         std   ,--x
         stx   <u0044
         rts   
L21E5    ldd   #$8500
L21E8    pshs  b,a
         ldd   <u00A1
         bsr   L21DE
         puls  b,a
         bsr   L21DE
         lbsr  L20F7
         lbsr  L20F4
         clrb  
         cmpa  #$4D
         beq   L220F
L21FD    cmpa  #$89
         bne   L2230
         bsr   L2240
         bsr   L2230
         bsr   L21D3
         lbsr  L20FE
         ldd   #$8900
         bra   L21E8
L220F    bsr   L2240
         incb  
         pshs  b
         lbsr  L22FD
         lbsr  L218A
         bne   L2227
         ldb   ,s+
         cmpb  #$03
         bcs   L220F
         lda   #$2A
         lbra  L1DBF
L2227    bsr   L22A8
         lbsr  L20F4
         puls  b
         bra   L21FD
L2230    clr   <u00BC
         ldx   <u0044
         addb  ,x++
         lbsr  L23FC
         ldd   ,x++
         stx   <u0044
         lbra  L23F5
L2240    tst   <u00BC
         beq   L2273
         clr   <u00BC
L2246    lda   #$0E
L2248    lbra  L23FE
L224B    ldb   <u00A3
         clra  
         cmpb  #$4E
         beq   L2274
         tstb  
         bpl   L225C
         lbsr  L1CB6
         bita  #$08
         bne   L2274
L225C    ldx   <u0044
L225E    ldd   ,x++
         cmpa  #$4D
         beq   L22AE
         bsr   L2248
         tstb  
         bne   L225E
         cmpa  #$39
         bne   L2270
         lbsr  L1E51
L2270    stx   <u0044
         coma  
L2273    rts   
L2274    anda  #$07
         tfr   a,b
         ldx   <u0044
         bra   L2280
L227C    lda   ,x++
         bsr   L22F8
L2280    cmpb  $01,x
         bcs   L227C
         bhi   L22A1
         cmpb  #$06
         beq   L22A1
         tstb  
         bne   L227C
         lda   ,x++
         cmpa  #$4D
         bne   L2299
         stx   <u0044
         bsr   L22E7
         bra   L224B
L2299    cmpa  #$39
         beq   L22F0
         bsr   L22F8
         bra   L2270
L22A1    lda   <u00A3
L22A3    std   ,--x
         stx   <u0044
L22A7    rts   
L22A8    lda   <u00A3
         cmpa  #$4E
         beq   L22A7
L22AE    lda   #$25
L22B0    lbra  L1DBF
L22B3    lbsr  L1E51
         lda   <u00A3
         pshs  a
         bsr   L22E7
         ldb   ,s
         lbsr  L1CB6
         leax  <L22E0,pcr
         pshs  x
         anda  #$03
         beq   L22F4
         cmpa  #$02
         beq   L2304
         bhi   L230B
         ldb   $02,s
         cmpb  #$92
         beq   L231A
         cmpb  #$94
         beq   L231A
         cmpb  #$BE
         beq   L230F
         bra   L22FB
L22E0    bsr   L22A8
         puls  a
         lbsr  L23FE
L22E7    lbra  L20F4
L22EA    lda   <u00A3
         cmpa  #$4D
         beq   L22A7
L22F0    lda   #$22
         bra   L22B0
L22F4    leas  $02,s
         puls  a
L22F8    lbra  L23FE
L22FB    bsr   L22EA
L22FD    clra  
         lbsr  L2127
         lbra  L1E51
L2304    bsr   L22FB
L2306    lbsr  L218F
         bra   L22FD
L230B    bsr   L2304
         bra   L2306
L230F    bsr   L22EA
         bsr   L22E7
         cmpa  #$54
         beq   L22FD
         lbra  L20C0
L231A    bsr   L22EA
         incb  
         lbsr  L23FC
         lbra  L2169
L2323    lda   #$0A
         bra   L22B0
L2327    ldd   <u00AB
         std   <u00AD
         lbsr  L2446
         sty   <u00B9
         lbsr  L2419
         lbne  L23CA
         lda   ,y
         lbsr  L2457
         bcc   L2363
         leax  >L1CBC,pcr
         lda   #$80
         lbsr  L2513
         beq   L2323
         ldb   ,x
         leau  <L2386,pcr
         jmp   b,u
L2351    ldd   $01,x
L2353    stb   <u00A4
         sta   <u00A3
         lbra  L23FE
         lda   ,y
         lbsr  L2457
         bcs   L2351
         leay  -$01,y
L2363    bsr   L238F
         bne   L2378
         ldd   #$8F05
L236A    sta   <u00A3
L236C    bsr   L23BF
         lda   ,x+
         decb  
         bpl   L236C
         lda   #$06
         sta   <u00A4
         rts   
L2378    ldd   #$8E02
         tst   ,x
         bne   L236A
         ldd   #$8D01
         leax  $01,x
         bra   L236A
L2386    leay  -$01,y
         bsr   L238F
         ldd   #$9102
         bra   L236A
L238F    lbsr  L2446
         leax  ,y
         ldy   <u0044
         lbsr  L1CB3
         exg   x,y
         bcs   L23A3
         lda   ,x+
         cmpa  #$02
         rts   
L23A3    lda   #$16
         bra   L23C3
         bsr   L2351
         bra   L23AD
L23AB    bsr   L23FE
L23AD    lda   ,y+
         cmpa  #$0D
         beq   L23C1
         cmpa  #$22
         bne   L23AB
         cmpa  ,y+
         beq   L23AB
         leay  -$01,y
         lda   #$FF
L23BF    bra   L23FE
L23C1    lda   #$29
L23C3    lbra  L1DBF
L23C6    lda   #$31
         bra   L23C3
L23CA    ldx   <u009E
         lbsr  L2511
         beq   L23D8
         stx   <u00A1
         ldd   ,x
L23D5    lbra  L2353
L23D8    tst   <u00A0
         bmi   L23C6
         ldx   <u0062
         lbsr  L2511
         bne   L23EA
         tst   <u00A0
         bne   L23C6
         lbsr  L247D
L23EA    ldd   #$8500
         bsr   L23D5
         tfr   x,d
         subd  <u0062
         std   <u00A1
L23F5    bsr   L23FE
         bsr   L23FC
         lda   <u00A3
         rts   
L23FC    tfr   b,a
L23FE    pshs  x,b,a
         ldx   <u00AB
         sta   ,x+
         stx   <u00AB
         ldd   <u00AB
         subd  <u004A
         cmpb  #$FF
         bcc   L2411
         clra  
         puls  pc,x,b,a
L2411    lda   #$0D
         lbsr  L1CAA
         lbra  L1CB0
L2419    bsr   L2446
         pshs  y
         ldb   #$02
         stb   <u00A5
         clrb  
         bsr   L2461
         bcs   L2442
         leay  $01,y
L2428    incb  
         lda   ,y+
         bsr   L2453
         bcc   L2428
         cmpa  #$24
         bne   L243A
         incb  
         leay  $01,y
         lda   #$04
         sta   <u00A5
L243A    leay  -$01,y
         lda   #$80
         ora   -$01,y
         sta   -$01,y
L2442    stb   <u00A6
         puls  pc,y
L2446    lda   ,y+
         cmpa  #$20
         beq   L2446
         cmpa  #$0A
         beq   L2446
         leay  -$01,y
         rts   
L2453    bsr   L2461
         bcc   L247C
L2457    cmpa  #$30
         bcs   L247C
         cmpa  #$39
         bls   L247A
         bra   L2477
L2461    anda  #$7F
         cmpa  #$41
         bcs   L247C
         cmpa  #$5A
         bls   L247A
         cmpa  #$5F
         beq   L247C
         cmpa  #$61
         bcs   L247C
         cmpa  #$7A
         bls   L247A
L2477    orcc  #$01
         rts   
L247A    andcc #$FE
L247C    rts   
L247D    ldx   <u0062
         ldd   -$03,x
         addd  #$0001
         std   -$03,x
         ldb   <u00A6
         clra  
         addd  #$0003
         sty   <u00A9
         bsr   L24D7
         pshs  y
         lda   <u00A5
         clrb  
         std   ,y++
         clr   ,y+
         ldx   <u00A9
L249C    lda   ,x+
         sta   ,y+
         bpl   L249C
         leay  ,x
         puls  pc,x
L24A6    pshs  u,b,a
         ldd   <u000C
         subd  ,s
         bcc   L24B3
         lda   #$20
         lbra  L1DBF
L24B3    std   <u000C
         ldd   <u0066
         subd  ,s
         std   <u0066
         ldu   <u00DA
         ldd   <u00DA
         subd  ,s
         std   <u00DA
         tfr   d,y
         ldd   <u0066
         subd  <u00DA
         addd  <u0068
         bsr   L24F1
         ldd   <u0068
         addd  ,s++
         std   <u0068
         leax  ,u
         puls  pc,u
L24D7    pshs  u,b,a
         bsr   L24A6
         subd  ,s
         std   <u0068
         leau  ,x
         leax  $03,y
         stx   <u0062
         ldd   <u0064
         bsr   L24F1
         addd  ,s++
         std   <u0064
         leax  ,u
         puls  pc,u
L24F1    pshs  x,b,a
         leax  d,u
         pshs  x
L24F7    bitb  #$03
         beq   L2508
         lda   ,u+
         sta   ,y+
         decb  
         bra   L24F7
L2502    pulu  x,b,a
         std   ,y++
         stx   ,y++
L2508    cmpu  ,s
         bcs   L2502
         clr   ,s++
         puls  pc,x,b,a
L2511    lda   #$20
L2513    pshs  u,y,x,a
         ldu   -$03,x
         ldb   -$01,x
L2519    stx   $01,s
         cmpu  #$0000
         beq   L2541
         leau  -u0001,u
         ldy   $03,s
         leax  b,x
L2528    lda   ,x+
         eora  ,y+
         beq   L253A
         cmpa  ,s
         beq   L253A
         leax  -$01,x
L2534    lda   ,x+
         bpl   L2534
         bra   L2519
L253A    tst   -$01,x
         bpl   L2528
         sty   $03,s
L2541    puls  pc,u,y,x,a
         pshs  x,b,a
         ldb   [<$04,s]
         leax  <L2553,pcr
         ldd   b,x
         leax  d,x
         stx   $04,s
         puls  pc,x,b,a
L2553    ror   <u00E6
         tim   #$36,<u0001
         bvc   L255B
         subd  <u009D
         fcb   $1B 
         aim   #$9D,<u001B
         ror   <u009D
         fcb   $1B 
         sexw  
L2564    jsr   <u001E
         lsl   <u009D
         exg   d,w
L256A    asr   <u0086
         oim   #$FE,<u0001
         sta   $02,x
         aim   #$03,<u00A9
         asr   <u0007
         asr   <u009F
         asr   <u009F
         asr   <u009F
         asr   <u0007
         asr   <u009F
         asr   <u009F
         asr   <u009F
         com   <u00D3
         com   <u00D1
         lsr   <u0023
         lsr   <u00AF
         lsr   <u00CA
         lsr   <u00E1
         lsr   <u00F3
         eim   #$8B,<u0005
         orb   <u0005
         eorb  $06,x
         neg   <u0006
         asr   <u0006
         fcb   $1B 
         ror   <u001F
         ror   <u0023
         ror   <u0040
         lsr   <u002A
         lsr   <u0099
         lsr   <u004B
         tim   #$0C,<u0004
         fcb   $4B K
         tim   #$0C,<u0006
         ldx   <u0007
         lda   #$06
         andb  $07,x
         asr   <u0007
         lda   #$07
         lda   #$07
         fcb   $45 E
         asr   <u0045
         asr   <u0061
         ror   <u00E4
         asr   <u0007
         asr   <u006F
         asr   <u006F
         asr   <u0079
         asr   <u0097
         asr   <u0086
         asr   <u0086
         asr   <u0086
         asr   <u009F
         asr   <u009F
         oim   #$47,<u0001
         asra  
         asr   <u0007
         neg   <u00DC
         tim   #$0C,<u000B
         inc   <u0001
         nega  
         oim   #$97,<u0001
         sta   <u0020
         bra   L25F3
         neg   <u0043
         nega  
         bvc   L2617
         neg   <u0043
         coma  
         coma  
         coma  
         coma  
         coma  
         coma  
         eim   #$00,<u0043
         coma  
         coma  
         neg   <u0045
         neg   <u0025
         neg   <u0045
         neg   <u0005
         neg   <u0021
         brn   L2652
         beq   L2634
         bhi   L2631
         bhi   L2671
         neg   $01,s
         fcb   $87 
         ora   #$89
         adca  #$81
         bita  #$00
         suba  #$81
         subb  ,s+
         subb  ,s+
         subb  $0B,s
         eim   #$00,<u006C
         inc   $0C,s
         tst   $00,x
         neg   <u006D
         neg   <u0000
         jmp   $00,x
         neg   <u0000
L2631    jmp   $00,x
         neg   <u0000
         tst   $00,x
         neg   <u006D
         neg   <u0000
         tst   <u0000
         neg   <u0006
         neg   <u0006
         neg   <u0006
         neg   <u0044
         lsra  
         ldd   ,y
         tst   <u00D9
         bne   L265E
         pshs  b,a
         leay  -$01,y
         ldd   <u0060
L2652    std   <u00AB
         ldd   #$0003
         lbsr  L2561
         puls  b,a
         bra   L2660
L265E    leay  $02,y
L2660    lbsr  L29C7
         bcc   L2677
         std   ,x
         tfr   y,d
         subd  <u005E
         leax  $02,x
L266D    ldu   ,x
         std   ,x
L2671    leax  ,u
         bne   L266D
         bra   L267B
L2677    lda   #$4B
         bsr   L26B7
L267B    leax  >L256A,pcr
         ldb   ,y+
         bpl   L2688
         ldd   #$03D1
         bra   L2692
L2688    lslb  
         clra  
         ldd   d,x
         cmpd  #$03D1
         bcs   L26A8
L2692    tst   <u00C7
         bne   L26A8
         inc   <u00C7
         pshs  b,a
         tfr   y,d
         subd  <u005E
         subd  #$0001
         ldu   <u002F
         std   <u0015,u
         puls  b,a
L26A8    jmp   d,x
         ldx   <u002F
         lda   #$01
         sta   <$17,x
         ldb   ,y+
         clra  
         leay  d,y
         rts   
L26B7    pshs  y,x,b,a
         ldx   <u002F
         lda   #$01
         sta   <$17,x
         lda   <u0084
         bmi   L26E4
         ldd   $04,s
         subd  <u005E
         leas  -$05,s
         leax  ,s
         bsr   L26E6
         lda   #$20
         sta   ,x+
         lda   #$02
         leax  ,s
         ldy   #$0005
         os9   I$Write  
         leas  $05,s
         ldb   ,s
         lbsr  L255B
L26E4    puls  pc,y,x,b,a
L26E6    bsr   L26EA
         tfr   b,a
L26EA    pshs  a
         lsra  
         lsra  
         lsra  
         lsra  
         bsr   L26F6
         puls  a
         anda  #$0F
L26F6    adda  #$30
         cmpa  #$39
         bls   L26FE
         adda  #$07
L26FE    sta   ,x+
         rts   
L2701    ldb   ,y
         bsr   L270A
         bne   L2709
L2707    leay  $01,y
L2709    rts   
L270A    cmpb  #$3F
         beq   L2710
         cmpb  #$3E
L2710    rts   
         lbsr  L2F2C
         ldb   <u00CF
         beq   L271C
         lda   #$4C
         bsr   L26B7
L271C    leay  $04,y
         lda   #$40
         sta   <u00CE
         ldd   <u00C1
         pshs  b,a
         clra  
         clrb  
         std   <u00C1
         bsr   L2770
         ldd   <u00CC
         subd  <u0060
         beq   L2763
         addd  #$0003
         cmpd  <u000C
         lbcc  L29F6
         pshs  y,x
         lbsr  L2564
         ldd   <u00C1
         leau  ,y
         std   ,y++
         clr   ,y+
         ldx   <u0060
L274B    ldd   ,x++
         subd  <u0062
         std   ,y++
         inc   u0002,u
         cmpx  <u00CC
         bcs   L274B
         tfr   u,d
         puls  y,x
         subd  <u0066
         std   $01,x
         lda   #$25
         sta   ,x
L2763    puls  b,a
         std   <u00C1
         rts   
         lda   #$80
         bra   L276E
         lda   #$60
L276E    sta   <u00CE
L2770    ldd   <u0060
         pshs  x,b,a
         std   <u00CC
L2776    bsr   L27C9
         ldb   ,y+
         cmpb  #$4B
         beq   L2776
         cmpb  #$4C
         beq   L2788
         leay  -$01,y
         ldb   #$01
         bra   L278C
L2788    lbsr  L2823
         clrb  
L278C    pshs  y,b
         ldx   $03,s
         ldd   <u00CC
         std   $03,s
         stx   <u00CC
         subd  <u00CC
         lslb  
         rola  
         addd  $03,s
         cmpd  <u00DA
         lbcc  L29F6
         bra   L27B7
L27A5    ldu   ,x++
         tst   ,s
         beq   L27B4
         lda   ,u
         sta   <u00D1
         lbsr  L306C
         std   <u00D6
L27B4    lbsr  L2861
L27B7    cmpx  $03,s
         bcs   L27A5
         ldd   <u00CC
         std   $03,s
         puls  y,b
         ldb   ,y+
         cmpb  #$51
         beq   L2776
         puls  pc,x,b,a
L27C9    lbsr  L2F2C
         ldb   <u00CF
         beq   L27E8
         lda   #$4C
         lbsr  L26B7
         leay  $03,y
         ldb   ,y
         cmpb  #$4D
         bne   L27E7
         leay  $01,y
L27DF    bsr   L2817
         ldb   ,y+
         cmpb  #$4B
         beq   L27DF
L27E7    rts   
L27E8    ldd   <u00CC
         addd  #$000A
         cmpd  <u00DA
         lbcc  L29F6
         ldx   <u00CC
         ldd   <u00D2
         std   ,x++
         leau  ,x
         clr   ,x+
         leay  $03,y
         ldb   ,y
         cmpb  #$4D
         bne   L2814
         leay  $01,y
L2808    bsr   L2817
         std   ,x++
         inc   ,u
         ldb   ,y+
         cmpb  #$4B
         beq   L2808
L2814    stx   <u00CC
         rts   
L2817    ldb   ,y+
         clra  
         cmpb  #$8D
         beq   L2820
         lda   ,y+
L2820    ldb   ,y+
         rts   
L2823    lda   ,y+
         cmpa  #$85
         beq   L2844
         suba  #$40
         sta   <u00D1
         cmpa  #$04
         bne   L283F
         ldb   ,y
         cmpb  #$4F
         bne   L283F
         leay  $01,y
         bsr   L2817
         leay  $01,y
         bra   L285E
L283F    lbsr  L306C
         bra   L285E
L2844    leay  -$01,y
         lbsr  L2F2C
         leay  $03,y
         ldb   <u00CF
         cmpb  #$20
         beq   L2856
         lda   #$18
         lbra  L26B7
L2856    ldd   $01,x
         std   <u00D2
         ldx   <u0066
         ldd   d,x
L285E    std   <u00D6
         rts   
L2861    ldb   ,x+
         beq   L28B9
         pshs  b
         lslb  
         lslb  
         lslb  
         stb   <u00D0
         lsrb  
         lsrb  
         leax  b,x
         addb  #$04
         pshs  u,x
         lda   <u00D1
         cmpa  #$04
         bcs   L287C
         addb  #$02
L287C    clra  
         cmpd  <u000C
         lbhi  L29F6
         lbsr  L2564
         ldx   ,s
         leau  $02,y
         ldd   #$0001
         std   ,u++
L2890    ldd   ,--x
         std   ,u++
         bsr   L28E0
         dec   $04,s
         bne   L2890
         lda   <u00D1
         cmpa  #$04
         bls   L28A5
         ldd   <u00D2
         std   ,u
         coma  
L28A5    ldd   <u00D6
         bcs   L28AB
         std   ,u
L28AB    bsr   L28E0
         tfr   y,d
         puls  u,x
         subd  <u0066
         std   u0001,u
         leas  $01,s
         bra   L28C9
L28B9    stb   <u00D0
         lda   <u00D1
         cmpa  #$04
         bhi   L28C5
         ldd   <u00D6
         bra   L28C7
L28C5    ldd   <u00D2
L28C7    std   u0001,u
L28C9    lda   <u00D1
         ora   <u00D0
         ora   <u00CE
         sta   ,u
         pshs  x
         leax  ,u
         lbsr  L2FD7
         ldx   <u00CC
         stu   ,x++
         stx   <u00CC
         puls  pc,x
L28E0    pshs  b,a
         ldb   $02,y
         mul   
         bne   L290C
         lda   $01,s
         ldb   $02,y
         mul   
         tsta  
         bne   L290C
         stb   $02,y
         lda   ,s
         ldb   $03,y
         mul   
         tsta  
         bne   L290C
         addb  $02,y
         bcs   L290C
         stb   $02,y
         lda   $01,s
         ldb   $03,y
         mul   
         adda  $02,y
         bcs   L290C
         std   $02,y
         puls  pc,b,a
L290C    lda   #$49
         lbsr  L26B7
         puls  pc,b,a
         ldu   <u00CA
         bne   L291F
         tfr   y,d
         subd  <u005E
         std   <u00C8
         bra   L2925
L291F    tfr   y,d
         subd  <u005E
         std   ,u
L2925    lbsr  L2D4E
         lbsr  L2E3B
         ldb   ,y+
         cmpb  #$4B
         beq   L2925
         sty   <u00CA
         ldd   <u00C8
         std   ,y++
         lbra  L2707
         leay  -$01,y
         bsr   L296D
         leay  $01,y
         lbsr  L2D4E
         lbsr  L2E3B
         sta   <u00D1
         lbsr  L2E3B
         cmpa  <u00D1
         beq   L296A
         cmpa  #$02
         bhi   L2967
         beq   L295A
         lda   #$C8
         bra   L295C
L295A    lda   #$CB
L295C    ldb   <u00D1
         cmpb  #$02
         bhi   L2967
         lbsr  L2FA7
         bra   L296A
L2967    lbsr  L2A0F
L296A    lbra  L2701
L296D    lda   ,y
         cmpa  #$0E
         lbne  L2D4E
         leay  $01,y
         lbsr  L2D4E
L297A    lda   -$03,y
         cmpa  #$85
         bcc   L2988
         ldd   <u00D2
         subd  <u0062
         std   -$02,y
         lda   #$85
L2988    adda  #$6D
         sta   -$03,y
         rts   
         bsr   L298F
L298F    bsr   L2A03
         leay  $01,y
         rts   
         ldb   ,y+
         cmpb  #$1E
         beq   L29AE
         leay  -$01,y
         bsr   L298F
         ldd   ,y++
L29A0    pshs  b,a
         leay  $01,y
         bsr   L29B5
         puls  b,a
         subd  #$0001
         bne   L29A0
         rts   
L29AE    ldb   ,y+
         lbsr  L270A
         beq   L29C6
L29B5    ldd   ,y
         bsr   L29C7
         ldd   $02,x
         bcc   L29C0
         sty   $02,x
L29C0    std   ,y
         inc   -$01,y
         leay  $03,y
L29C6    rts   
L29C7    ldx   <u0066
         pshs  b,a
         bra   L29D6
L29CD    ldd   ,x
         anda  #$7F
         cmpd  ,s
         beq   L29F1
L29D6    leax  -$04,x
         cmpx  <u00DA
         bcc   L29CD
         ldd   <u000C
         subd  #$0004
         bcs   L29F6
         std   <u000C
         ldd   ,s
         ora   #$80
         std   ,x
         clra  
         clrb  
         std   $02,x
         stx   <u00DA
L29F1    lda   ,x
         rola  
         puls  pc,b,a
L29F6    lda   #$20
         sta   <u0036
         lbsr  L26B7
         lbsr  L30D4
         lbra  L255E
L2A03    lbsr  L2D4E
         lbsr  L2E3B
         cmpa  #$02
         beq   L2A14
         bcs   L29C6
L2A0F    lda   #$47
         lbra  L26B7
L2A14    lda   #$C8
         lbra  L2FA7
         lbsr  L2B98
         lda   $03,y
         cmpa  #$3A
         beq   L2A27
         lda   #$10
         lbra  L2B91
L2A27    pshs  y
         leay  $04,y
         bsr   L29B5
         tfr   y,d
         subd  <u005E
         std   [,s++]
         rts   
         ldd   #$1002
         lbsr  L2BC6
         ldu   $01,x
         sty   $01,x
         leay  $02,y
         lbsr  L2701
         tfr   y,d
         subd  <u005E
         std   ,u
         rts   
         ldd   #$1001
         lbsr  L2BC6
         leay  $01,y
L2A53    tfr   y,d
         subd  <u005E
         std   [<$01,x]
         lbra  L2BEA
         lbsr  L2F2C
         lbsr  L2ECC
         cmpa  #$60
         bne   L2A71
         lda   <u00D1
         cmpa  #$01
         beq   L2A7D
         cmpa  #$02
         beq   L2A7D
L2A71    lda   #$46
         lbsr  L26B7
         ldd   #$FFFF
         std   <u00D2
         bra   L2A89
L2A7D    ldb   <u00D0
         bne   L2A71
         adda  #$80
         sta   ,y
         ldd   $01,x
         std   $01,y
L2A89    ldx   <u0044
         leax  -$07,x
         stx   <u0044
         lda   <u00D1
         sta   ,x
         ldd   <u00D2
         subd  <u0062
         std   $01,x
         clra  
         clrb  
         std   $05,x
         leay  $04,y
         bsr   L2ADA
         bsr   L2ABD
         std   $03,x
         lda   ,y
         cmpa  #$47
         bne   L2AAF
         bsr   L2ABD
         std   $05,x
L2AAF    leay  $01,y
         sty   ,--x
         lda   #$13
         sta   ,-x
         stx   <u0044
         leay  $03,y
L2ABC    rts   
L2ABD    ldd   <u00C1
         pshs  b,a
         std   $01,y
         ldx   <u0044
         lda   ,x
         leax  >L3067,pcr
         ldb   a,x
         clra  
         addd  <u00C1
         std   <u00C1
         leay  $03,y
         bsr   L2ADA
         ldx   <u0044
         puls  pc,b,a
L2ADA    lbsr  L2D4E
         lbsr  L2E3B
         cmpa  ,u
         beq   L2ABC
         cmpa  #$02
         bcs   L2AF0
         lbne  L2A0F
         lda   #$C8
         bra   L2AF2
L2AF0    lda   #$CB
L2AF2    lbra  L2FA7
         leay  -$01,y
         ldd   #$130B
         lbsr  L2BC6
         ldd   $02,y
         cmpd  $04,x
         beq   L2B0B
         lda   #$46
         lbsr  L26B7
         bra   L2B3A
L2B0B    addd  <u0062
         exg   d,x
         ldx   $01,x
         exg   d,x
         std   $02,y
         lda   $03,x
         anda  #$02
         sta   $01,y
         ldd   $06,x
         std   $04,y
         ldd   $08,x
         std   $06,y
         beq   L2B27
         inc   $01,y
L2B27    ldu   $01,x
         tfr   y,d
         subd  <u005E
         addd  #$0001
         std   ,u
         leau  u0003,u
         tfr   u,d
         subd  <u005E
         std   $08,y
L2B3A    leay  $0B,y
         lbsr  L2BEA
         leax  $07,x
         stx   <u0044
         rts   
         leau  -$01,y
         pshs  u
         bsr   L2B98
         puls  b,a
         std   ,y
         lda   #$15
         bra   L2B91
         ldd   #$1503
         bsr   L2BC6
         ldx   $01,x
         ldd   ,x
         subd  <u005E
         std   ,y
         leay  $03,y
         tfr   y,d
         subd  <u005E
         std   ,x
         lbra  L2BEA
         lda   #$17
L2B6C    lbsr  L2707
         bra   L2BBC
         bsr   L2B98
         lda   #$17
L2B75    leay  -$01,y
         ldb   #$03
         bsr   L2BC6
         ldd   $01,x
         subd  <u005E
         std   $01,y
         leay  $04,y
         bra   L2BEA
         lda   #$19
         bra   L2B6C
         lda   #$19
         bra   L2B75
         bsr   L2B98
         lda   #$1B
L2B91    bsr   L2BBC
         leay  $03,y
         lbra  L2701
L2B98    lbsr  L2D4E
         lbsr  L2E3B
         cmpa  #$03
         beq   L2BA7
         lda   #$47
         lbsr  L26B7
L2BA7    leay  $01,y
         rts   
         ldd   #$1B03
         bsr   L2BC6
         leau  ,y
         leay  $03,y
         lbsr  L2A53
         stu   ,--x
         lda   #$1C
         bra   L2BC1
L2BBC    ldx   <u0044
         sty   ,--x
L2BC1    sta   ,-x
         stx   <u0044
         rts   
L2BC6    pshs  a
         ldx   <u0044
         bra   L2BCE
L2BCC    leax  $03,x
L2BCE    cmpx  <u0046
         bcc   L2BDC
         lda   ,x
         cmpa  #$1C
         beq   L2BCC
         cmpa  ,s
         beq   L2BE8
L2BDC    leas  $03,s
         lda   #$45
         lbsr  L26B7
         leay  b,y
         lbra  L2701
L2BE8    puls  pc,a
L2BEA    ldx   <u0044
         bra   L2BFD
L2BEE    lda   ,x
         cmpa  #$1C
         bne   L2C03
         tfr   y,d
         subd  <u005E
         std   [<$01,x]
         leax  $03,x
L2BFD    cmpx  <u0046
         bcs   L2BEE
         bra   L2C05
L2C03    leax  $03,x
L2C05    stx   <u0044
         rts   
         leay  -$01,y
         lbsr  L2F2C
         lda   <u00CF
         beq   L2C2A
         cmpa  #$A0
         beq   L2C37
         cmpa  #$60
         bcs   L2C23
         lda   <u00D0
         bne   L2C23
         lda   <u00D1
         cmpa  #$04
         beq   L2C37
L2C23    lda   #$4C
         lbsr  L26B7
         bra   L2C37
L2C2A    lda   #$A0
         sta   ,x
         ldd   <u00C5
         std   $01,x
         addd  #$0002
         std   <u00C5
L2C37    leay  $03,y
         ldb   ,y+
         cmpb  #$4D
         bne   L2C4D
L2C3F    lbsr  L296D
         lbsr  L2E3B
         ldb   ,y+
         cmpb  #$4B
         beq   L2C3F
         leay  $01,y
L2C4D    rts   
         bsr   L2C9B
         leay  -$01,y
         cmpb  #$90
         bne   L2C5B
         lbsr  L2CF4
         leay  $01,y
L2C5B    lbsr  L296D
         lbsr  L2E3B
         cmpa  #$05
         bcs   L2C6A
         lda   #$4D
         lbsr  L26B7
L2C6A    lda   ,y+
         cmpa  #$4B
         beq   L2C5B
         rts   
         bsr   L2C9B
         cmpb  #$49
         bne   L2C7B
         bsr   L2CF4
L2C79    ldb   ,y+
L2C7B    cmpb  #$4B
         beq   L2C79
         cmpb  #$51
         beq   L2C79
         lbsr  L270A
         beq   L2CAE
         leay  -$01,y
         lbsr  L2D4E
         lbsr  L2E3B
         cmpa  #$05
         bcs   L2C79
         lda   #$47
         lbsr  L26B7
         bra   L2C79
L2C9B    ldb   ,y+
         cmpb  #$54
         bne   L2CAE
         lbsr  L2A03
L2CA4    ldb   ,y+
         cmpb  #$4B
         beq   L2CA4
         cmpb  #$51
         beq   L2CA4
L2CAE    rts   
         leay  $01,y
         lbsr  L296D
         lbsr  L2E3B
         cmpa  #$01
         beq   L2CBE
         lbsr  L2A0F
L2CBE    leay  $01,y
         bsr   L2CF4
         lda   ,y+
         cmpa  #$4A
         bne   L2CCA
         leay  $02,y
L2CCA    rts   
         bsr   L2CEB
         bsr   L2D4E
         lbsr  L2E3B
         cmpa  #$42
         bls   L2D09
         lbra  L2A0F
         bsr   L2CEB
         lbsr  L296D
         lbsr  L2E3B
         bra   L2D09
L2CE3    bsr   L2CEB
         cmpb  #$4B
         beq   L2CE3
         bra   L2D09
L2CEB    leay  $01,y
         lbra  L298F
         bsr   L2CF4
         bra   L2D09
L2CF4    bsr   L2D4E
         lbsr  L2E3B
         cmpa  #$04
         beq   L2D00
         lbsr  L2A0F
L2D00    rts   
         ldb   ,y+
         cmpb  #$3A
         lbeq  L29B5
L2D09    lbra  L2701
L2D0C    cmpb  #$96
         bcc   L2D15
         lbsr  L2E48
         bra   L2D4E
L2D15    cmpb  #$F2
         lbcc  L3076
         subb  #$96
         leax  >L25EA,pcr
         leax  b,x
         ldb   ,x
         lbeq  L3076
         andb  #$1F
         beq   L2D33
         leau  <L2D8B,pcr
         lslb  
         jsr   b,u
L2D33    ldb   ,x
         andb  #$E0
         beq   L2D49
         clra  
         rolb  
         rola  
         rolb  
         rola  
         rolb  
         rola  
         cmpa  #$07
         bne   L2D49
         lbsr  L2FBD
         bra   L2D4E
L2D49    lbsr  L2E24
         leay  $01,y
L2D4E    ldb   ,y
         bmi   L2D0C
         rts   
L2D53    bsr   L2D58
         incb  
         bra   L2D5A
L2D58    ldb   #$C8
L2D5A    lbsr  L2E3B
         cmpa  #$02
         bcs   L2D6E
         beq   L2D67
         bsr   L2DAC
         bra   L2D6C
L2D67    tfr   b,a
         lbsr  L2FA7
L2D6C    lda   #$01
L2D6E    rts   
L2D6F    bsr   L2D74
         incb  
         bra   L2D76
L2D74    ldb   #$CB
L2D76    lbsr  L2E3B
         cmpa  #$02
         beq   L2D8A
         bcs   L2D83
         bsr   L2DAC
         bra   L2D88
L2D83    tfr   b,a
         lbsr  L2FA7
L2D88    lda   #$02
L2D8A    rts   
L2D8B    bra   L2DA9
         bra   L2D58
         bra   L2D53
         bra   L2D74
         bra   L2D6F
         bra   L2DC7
         bra   L2DB1
         bra   L2DDD
         bra   L2DDB
         bra   L2DE8
         bra   L2DED
         bra   L2E19
         bra   L2E17
         bra   L2DFC
         bra   L2DF2
L2DA9    lbra  L3076
L2DAC    lda   #$43
         lbra  L26B7
L2DB1    bsr   L2DD0
         pshs  a
         bsr   L2DD0
         cmpa  ,s+
         beq   L2DC9
         lda   #$CB
         bcc   L2DC0
         inca  
L2DC0    lbsr  L2FA7
         lda   #$02
         bra   L2DCD
L2DC7    bsr   L2DD0
L2DC9    cmpa  #$02
         bne   L2DCF
L2DCD    inc   ,y
L2DCF    rts   
L2DD0    bsr   L2E3B
         cmpa  #$02
         bls   L2DDA
         bsr   L2DAC
         lda   #$02
L2DDA    rts   
L2DDB    bsr   L2DDD
L2DDD    bsr   L2E3B
         cmpa  #$04
         beq   L2DE7
         bsr   L2DAC
         lda   #$04
L2DE7    rts   
L2DE8    lbsr  L2D58
         bra   L2DDD
L2DED    lbsr  L2D53
         bra   L2DDD
L2DF2    lda   #$03
         bsr   L2E09
         bne   L2DFC
         ldb   #$03
         bra   L2E04
L2DFC    lda   #$04
         bsr   L2E09
         bne   L2DB1
         ldb   #$02
L2E04    addb  ,y
         stb   ,y
         rts   
L2E09    ldu   <u0044
         cmpa  ,u+
         bne   L2E16
         cmpa  ,u+
         bne   L2E16
         stu   <u0044
         clrb  
L2E16    rts   
L2E17    bsr   L2E19
L2E19    bsr   L2E3B
         cmpa  #$03
         beq   L2E23
         bsr   L2DAC
         lda   #$03
L2E23    rts   
L2E24    cmpa  #$00
         bne   L2E2A
         lda   #$01
L2E2A    ldu   <u0044
         cmpa  #$05
         bne   L2E36
         ldd   <u00D4
         std   ,--u
         lda   #$05
L2E36    sta   ,-u
         stu   <u0044
         rts   
L2E3B    ldu   <u0044
         lda   ,u+
         cmpa  #$05
         bne   L2E45
         leau  u0002,u
L2E45    stu   <u0044
         rts   
L2E48    cmpb  #$85
         lbcs  L3076
         cmpb  #$89
         bcs   L2E94
         subb  #$8D
         lbcs  L2EF0
         leau  <L2E5E,pcr
         lslb  
         jmp   b,u
L2E5E    bra   L2E70
         bra   L2E72
         bra   L2E78
         bra   L2E7E
         bra   L2E72
         bra   L2E88
         bra   L2E91
         bra   L2E88
         bra   L2E91
L2E70    leay  -$01,y
L2E72    leay  $03,y
         lda   #$01
         bra   L2E24
L2E78    leay  $06,y
         lda   #$02
         bra   L2E24
L2E7E    ldb   ,y+
         cmpb  #$FF
         bne   L2E7E
         lda   #$04
         bra   L2E24
L2E88    lbsr  L297A
         bsr   L2E3B
         lda   #$01
         bsr   L2E24
L2E91    leay  $01,y
         rts   
L2E94    lbsr  L2F2C
         bsr   L2ECC
         cmpa  #$60
         beq   L2EA8
         cmpa  #$80
         beq   L2EA8
         lda   #$12
         lbsr  L26B7
         bra   L2EC5
L2EA8    ldb   #$85
         lbsr  L2F47
         ldb   ,y
         cmpb  #$85
         bne   L2EC5
         ldb   <u00CF
         cmpb  #$60
         bne   L2EC5
         cmpa  #$05
         bcc   L2EC5
         adda  #$80
         sta   ,y
         ldd   $01,x
         std   $01,y
L2EC5    lda   <u00D1
         leay  $03,y
         lbra  L2E24
L2ECC    lda   <u00CF
         cmpa  #$00
         bne   L2EEF
         ldd   #$0060
         sta   <u00D0
         stb   <u00CF
         lda   #$60
         ora   <u00D1
         sta   ,x
         anda  #$07
         cmpa  #$04
         bne   L2EEA
         ldd   #$0020
         std   $01,x
L2EEA    lbsr  L2FD7
         lda   <u00CF
L2EEF    rts   
L2EF0    bsr   L2F2C
         ldb   #$89
         bsr   L2F47
         lbsr  L2E3B
         cmpa  #$05
         beq   L2F02
         ldu   #$FFFF
         bra   L2F04
L2F02    ldu   -u0002,u
L2F04    pshs  u
         bsr   L2EC5
         puls  u
         cmpu  #$FFFF
         beq   L2F27
         ldb   u0002,u
         stb   <u00D6
         ldd   <u00D2
         subd  <u0062
         leau  u0003,u
L2F1A    cmpd  ,u++
         beq   L2F46
         dec   <u00D6
         bne   L2F1A
         lda   #$14
         bra   L2F29
L2F27    lda   #$42
L2F29    lbra  L26B7
L2F2C    ldd   $01,y
         addd  <u0062
         std   <u00D2
         ldx   <u00D2
L2F34    lda   ,x
         anda  #$E0
         sta   <u00CF
         lda   ,x
         anda  #$18
         sta   <u00D0
         lda   ,x
         anda  #$07
         sta   <u00D1
L2F46    rts   
L2F47    pshs  b
         ldb   ,y
         subb  ,s+
         bne   L2F5C
         tst   <u00D0
         beq   L2F86
         lda   #$05
         sta   <u00D1
         ldd   #$FFFF
         bra   L2FA2
L2F5C    lslb  
         lslb  
         lslb  
         cmpb  <u00D0
         beq   L2F68
         lda   #$41
         lbsr  L26B7
L2F68    lda   #$C8
         sta   <u00D8
L2F6C    lbsr  L2E3B
         cmpa  #$02
         bcs   L2F80
         beq   L2F7C
         lda   #$47
         lbsr  L26B7
         bra   L2F80
L2F7C    lda   <u00D8
         bsr   L2FA7
L2F80    inc   <u00D8
         subb  #$08
         bne   L2F6C
L2F86    lda   <u00D1
         cmpa  #$05
         bne   L2FA6
         ldd   $01,x
         addd  <u0066
         tfr   d,u
         ldb   <u00D0
         beq   L2F9E
         lsrb  
         lsrb  
         addb  #$04
         ldd   b,u
         bra   L2FA0
L2F9E    ldd   u0002,u
L2FA0    addd  <u0066
L2FA2    std   <u00D4
         lda   <u00D1
L2FA6    rts   
L2FA7    pshs  x,b
         ldx   <u000C
         cmpx  #$0010
         lbls  L29F6
         ldx   <u0060
         sta   ,x+
         stx   <u00AB
         clrb  
         bsr   L2FC3
         puls  pc,x,b
L2FBD    ldd   <u0060
         std   <u00AB
         ldb   #$01
L2FC3    clra  
         lbra  L2561
L2FC7    neg   <u0049
         neg   <u005C
         neg   <u0060
         neg   <u006A
         neg   <u0066
         neg   <u0072
         neg   <u0072
         neg   <u0076
L2FD7    pshs  u,y,x
         leay  <L2FC7,pcr
         ldb   ,x
         andb  #$E0
         cmpb  #$60
         beq   L2FEE
         cmpb  #$40
         beq   L2FEE
         cmpb  #$80
         bne   L300E
         leay  $08,y
L2FEE    ldb   ,x
         andb  #$18
         beq   L2FF8
         ldd   $06,y
         bra   L300C
L2FF8    ldb   ,x
         andb  #$07
L2FFC    cmpb  #$04
         bcs   L300A
         bhi   L3006
         ldd   $02,y
         bra   L300C
L3006    ldd   $04,y
         bra   L300C
L300A    ldd   ,y
L300C    jsr   d,y
L300E    puls  pc,u,y,x
         lda   ,x
         anda  #$07
         leay  $01,x
         bsr   L306C
L3018    pshs  b,a
         ldd   <u00C1
         std   ,y
         addd  ,s++
         std   <u00C1
         rts   
         bsr   L3052
         bra   L3018
         bsr   L3052
         addd  <u0066
         tfr   d,x
         ldd   ,x
         bra   L3018
         bsr   L3049
         bra   L3018
         leay  $01,x
L3037    ldd   <u00C3
         std   ,y
         addd  #$0004
         std   <u00C3
         rts   
         bsr   L3052
         bra   L3037
         bsr   L3049
         bra   L3037
L3049    ldd   $01,x
         addd  <u0066
         tfr   d,y
         ldd   $02,y
         rts   
L3052    ldd   #$0004
         lbsr  L2564
         ldx   $04,s
         ldd   $01,x
         std   $02,y
         tfr   y,d
         subd  <u0066
         std   $01,x
         ldd   $02,y
         rts   
L3067    oim   #$02,<u0005
         oim   #$20,<u0034
         addr  a,0
         ldb   >$E686
         clra  
         puls  pc,x
L3076    ldy   <u0060
         lda   #$30
         lbra  L26B7
L307E    oim   #$02,<u0003
         asr   <u0008
         rol   <u0037
         fcb   $38 8
         fcb   $3E >
         swi   
         fcb   $FF 
         ldd   #$0016
         std   <u00C1
         clrb  
         std   <u00C3
         std   <u00C5
         sta   <u00C7
         std   <u00C8
         std   <u00CA
         ldx   <u002F
         sta   <$17,x
         std   <$15,x
         ldy   <u005E
         bra   L30CB
L30A6    pshs  y
         lbsr  L267B
         puls  x
         ldb   <u00D9
         bne   L30CB
         lda   ,x
         leau  <L307E,pcr
L30B6    cmpa  ,u+
         bcs   L30CB
         bne   L30B6
         pshs  x
         tfr   y,d
         subd  ,s++
         leay  ,x
         ldu   <u004A
         stu   <u00AB
         lbsr  L2561
L30CB    ldx   <u0060
         clr   ,x
         cmpy  <u0060
         bcs   L30A6
L30D4    ldx   <u0066
         bra   L30F4
L30D8    lda   ,x
         bpl   L30F4
         anda  #$7F
         sta   ,x
         ldy   $02,x
L30E3    ldu   ,y
         ldd   ,x
         std   ,y
         dec   -$01,y
         lda   #$4A
         lbsr  L26B7
         leay  ,u
         bne   L30E3
L30F4    leax  -$04,x
         cmpx  <u00DA
         bcc   L30D8
         ldd   <u0066
         subd  <u00DA
         addd  <u000C
         std   <u000C
         ldx   <u0044
         bra   L311A
L3106    ldy   $01,x
         lda   #$45
         lbsr  L26B7
         lda   ,x
         cmpa  #$13
         bne   L3116
         leax  $07,x
L3116    leax  $03,x
         stx   <u0044
L311A    cmpx  <u0046
         bcs   L3106
         ldu   <u0066
         ldy   <u0060
         ldd   <u0064
         addd  <u0068
         lbsr  L2567
         ldx   <u002F
         ldd   <u00C8
         std   <$13,x
         ldd   <u00C1
         std   <$11,x
         addd  <u00C5
         std   <u00C5
         std   $0B,x
         ldb   <$18,x
         clra  
         addd  #$0019
         std   $09,x
         addd  <u0060
         subd  <u005E
         std   $0F,x
         addd  <u0068
         addd  #$0003
         std   $0D,x
         subd  #$0003
         addd  <u0064
         std   $02,x
         addd  <u002F
         std   <u004A
         subd  <u0008
         std   <u000A
         ldd   <u002F
         addd  $0D,x
         std   <u0062
         ldd   <u002F
         addd  $0F,x
         std   <u0066
         ldu   <u0062
         bra   L31CB
L3171    leax  ,u
         lbsr  L2F34
         lda   <u00CF
         cmpa  #$60
         bcs   L31A6
         cmpa  #$A0
         bne   L3188
         ldd   $01,x
         addd  <u00C1
         std   $01,x
         bra   L31C5
L3188    cmpa  #$80
         bne   L31A6
         ldb   <u00D0
         bne   L319A
         lda   <u00D1
         cmpa  #$04
         bcc   L319A
         leax  u0001,u
         bra   L31A0
L319A    ldd   u0001,u
         addd  <u0066
         tfr   d,x
L31A0    ldd   ,x
         addd  <u00C5
         std   ,x
L31A6    lda   <u00D1
         cmpa  #$05
         bne   L31C5
         ldb   <u00D0
         beq   L31B6
         lsrb  
         lsrb  
         addb  #$04
         bra   L31B8
L31B6    ldb   #$02
L31B8    clra  
         addd  u0001,u
         ldx   <u0066
         leay  d,x
         ldd   ,y
         ldd   d,x
         std   ,y
L31C5    leau  u0003,u
L31C7    lda   ,u+
         bpl   L31C7
L31CB    cmpu  <u004A
         bcs   L3171
         rts   
         pshs  x,b,a
         ldb   [<$04,s]
         leax  <L31E1,pcr
         ldd   b,x
         leax  d,x
         stx   $04,s
         puls  pc,x,b,a
L31E1    dec   <u0007
         neg   <u00E5
         rol   <u0067
         lsl   <u0003
         oim   #$B6,<u0008
         oim   #$08,>$7B9D
         fcb   $1B 
         ror   <u009D
         fcb   $1B 
         inc   <u009D
         fcb   $1B 
         jmp   <u009D
         fcb   $1B 
         aim   #$9D,<u001B
         neg   <u009D
         fcb   $1B 
         dec   <u009D
         fcb   $1B 
         fcb   $10 
L3204    jsr   <u001E
         ror   <u009D
         beq   L320E
L320A    jsr   <u0027
         dec   <u009D
L320E    beq   L3212
L3210    jsr   <u0027
L3212    inc   <u009D
         beq   L3224
L3216    jsr   <u0027
         neg   <u009D
         bpl   L321E
L321C    jsr   <u001B
L321E    fcb   $18 
L321F    jsr   <u001B
         lbra  LCF3F
L3224    orcc  #$9D
         fcb   $1B 
         andcc #$08
         nop   
         lsl   <u0012
         lsl   <u0012
         lsl   <u0012
         lsl   <u0012
         com   <u00A0
         com   <u00B1
         lsl   <u002A
         lsl   <u0034
         com   <u00B4
         lsl   <u001E
         lsl   <u0022
         com   <u00DA
         oim   #$6F,<u0002
         ldu   $03,x
         subd  <u0001
         tst   >$018D
         oim   #$94,<u0002
         ldx   $01,x
         eora  $01,x
         sta   <u0001
         bsr   L3258
         clr   $01,x
         sta   <u0001
         clr   $01,x
         bsr   L3260
         sta   <u0001
         bsr   L3266
         addd  >$07B8
L3266    lsl   <u001A
         oim   #$8D,<u0008
         orcc  #$03
         ora   >$084B
         rol   <u00B4
         lsr   <u00AF
         ror   <u0017
         asr   <u003E
         asr   <u004B
         lsr   <u0049
         lsr   <u0052
         lsr   <u0080
         eim   #$8C,<u0006
         subd  $06,x
         eorb  <u0006
         stu   <u0007
         tim   #$07,<u0018
         asr   <u0031
         asr   <u0061
         asr   <u007D
         asr   <u00FE
         lsl   <u0001
         lsl   <u0009
         lsl   <u0009
         oim   #$58,<u0001
         tst   $01,x
         tst   $08,x
         clr   <u0008
         orcc  #$01
         inc   $01,x
         inc   $03,x
         nop   
         com   <u0021
         com   <u0030
         com   <u0012
         com   <u0049
         com   <u007C
L32B4    comb  
         lsrb  
         clra  
         negb  
         bra   L32FF
         jmp   $03,s
         clr   -$0B,s
         jmp   -$0C,s
         eim   #$72,$05,s
         lsr   $0A,x
         stu   >$A688
         lbsr  LB7CC
         beq   L32D1
         ldb   #$33
         bra   L32ED
L32D1    tfr   s,d
         subd  #$0100
         cmpd  <u0080
         bcc   L32DF
         ldb   #$39
         bra   L32ED
L32DF    ldd   <u000C
         subd  $0B,x
         bcs   L32EB
         cmpd  #$0100
         bcc   L32F0
L32EB    ldb   #$20
L32ED    lbra  L39E4
L32F0    std   <u000C
         tfr   y,d
         subd  $0B,x
         exg   d,u
         sts   u0005,u
         std   u0007,u
         stx   u0003,u
L32FF    ldd   #$0001
         std   <u0042
         sta   u0001,u
         sta   <u0013,u
         stu   <u0014,u
         bsr   L333A
         ldd   <$13,x
         beq   L3315
         addd  <u005E
L3315    std   <u0039
         ldd   $0B,x
         leay  d,u
         pshs  y
         ldd   <$11,x
         leay  d,u
         clra  
         clrb  
         bra   L3328
L3326    std   ,y++
L3328    cmpy  ,s
         bcs   L3326
         leas  $02,s
         ldx   <u002F
         ldd   <u005E
         addd  <$15,x
         tfr   d,x
         bra   L337A
L333A    stx   <u002F
         stu   <u0031
         ldd   $0D,x
         addd  <u002F
         std   <u0062
         ldd   $0F,x
         addd  <u002F
         std   <u0066
         std   <u0060
         ldd   $09,x
         addd  <u002F
         std   <u005E
         ldd   <u0014,u
         std   <u0046
         std   <u0044
         rts   
L335A    stx   <u005C
         lda   <u0034
         beq   L3378
         bpl   L336B
         anda  #$7F
         sta   <u0034
         lbsr  L321C
         lda   <u0034
L336B    rora  
         bcc   L3378
         leay  ,x
         lbsr  L3201
         clr   <u0074
         lbsr  L321F
L3378    bsr   L3397
L337A    cmpx  <u0060
         bcs   L335A
         bra   L338A
         ldb   ,x
         lbsr  L3838
         beq   L338A
         lbsr  L383F
L338A    lbsr  L3A5C
         ldu   <u0031
         lds   u0005,u
         ldu   u0007,u
L3394    rts   
         leax  $02,x
L3397    ldb   ,x+
         bpl   L339D
         addb  #$40
L339D    lslb  
         clra  
         ldu   <u000E
         ldd   d,u
         jmp   d,u
         jsr   <u0016
         tst   $02,y
         beq   L33B5
         leax  $03,x
         ldb   ,x
         cmpb  #$3B
         bne   L3394
         leax  $01,x
L33B5    ldd   ,x
         addd  <u005E
         tfr   d,x
         rts   
         leax  $01,x
         rts   
         jsr   <u0016
         tst   $02,y
         beq   L33B5
         leax  $03,x
         rts   
L33C8    neg   <u0026
         neg   <u003F
         neg   <u007B
         neg   <u00C6
         leay  <L33C8,pcr
L33D3    ldb   ,x+
         lslb  
         ldd   b,y
         ldu   <u0031
         jmp   d,y
         ldd   ,x
         leay  d,u
         bra   L33F9
         ldd   ,x
         leay  d,u
         ldd   $04,x
         lda   d,u
         bpl   L33F9
         bra   L3419
         ldd   ,x
         leay  d,u
         ldd   ,y
         addd  #$0001
         std   ,y
L33F9    ldd   $02,x
         leax  $06,x
         ldd   d,u
         cmpd  ,y
         bge   L33B5
         leax  $03,x
         rts   
         ldd   ,x
         leay  d,u
         ldd   $04,x
         ldd   d,u
         pshs  a
         addd  ,y
         std   ,y
         tst   ,s+
         bpl   L33F9
L3419    ldd   $02,x
         leax  $06,x
         ldd   d,u
         cmpd  ,y
         ble   L33B5
         leax  $03,x
         rts   
         ldy   <u0046
         clrb  
         bsr   L3477
         bra   L3467
         ldy   <u0046
         clrb  
         bsr   L3477
         ldd   $04,x
         addd  #$0004
         ldu   <u0031
         lda   d,u
         lsra  
         bcc   L3467
         bra   L34B5
         ldy   <u0046
         clrb  
         bsr   L3477
         leay  -$06,y
         ldd   #$0180
         std   $01,y
         clra  
         clrb  
         std   $03,y
         sta   $05,y
         lbsr  L3207
         bsr   L34C5
         ldd   $01,y
         std   ,u
         ldd   $03,y
         std   u0002,u
         lda   $05,y
         sta   u0004,u
L3467    ldb   #$02
         bsr   L3477
         leax  $06,x
         lbsr  L320A
         lble  L33B5
         leax  $03,x
         rts   
L3477    ldd   b,x
         addd  <u0031
         tfr   d,u
         leay  -$06,y
         lda   #$02
         ldb   ,u
         std   ,y
         ldd   u0001,u
         std   $02,y
         ldd   u0003,u
         std   $04,y
         rts   
         ldy   <u0046
         clrb  
         bsr   L3477
         stu   <u00D2
         ldb   #$04
         bsr   L3477
         lda   u0004,u
         sta   <u00D1
         lbsr  L3207
         bsr   L34C5
         ldu   <u00D2
         ldd   $01,y
         std   ,u
         ldd   $03,y
         std   u0002,u
         lda   $05,y
         sta   u0004,u
         lsr   <u00D1
         bcc   L3467
L34B5    ldb   #$02
         bsr   L3477
         leax  $06,x
         lbsr  L320A
         lbge  L33B5
         leax  $03,x
L34C4    rts   
L34C5    ldb   <u0034
         bitb  #$01
         beq   L34C4
         lbra  L3225
L34CE    stu   >$0EFF
         sexw  
         stu   >$59FF
         oim   #$E6,,x+
         cmpb  #$82
         beq   L34FE
         bsr   L3549
         bsr   L34F1
         ldb   -$01,x
         cmpb  #$47
         bne   L34E8
         bsr   L34F1
L34E8    lbsr  L33B5
         leay  <L34CE,pcr
         lbra  L33D3
L34F1    ldd   ,x++
         addd  <u0031
         pshs  b,a
         jsr   <u0016
         ldd   $01,y
         std   [,s++]
         rts   
L34FE    bsr   L3558
         bsr   L350C
         ldb   -$01,x
         cmpb  #$47
         bne   L34E8
         bsr   L350C
         bra   L34E8
L350C    ldd   ,x++
         addd  <u0031
         pshs  b,a
         jsr   <u0016
         bra   L3562
         jsr   <u0016
L3518    cmpa  #$04
         bcs   L3520
         pshs  u
         ldu   <u003E
L3520    pshs  u,a
         leax  $01,x
         jsr   <u0016
L3526    puls  a
         lsla  
         leau  <L352E,pcr
         jmp   a,u
L352E    bra   L3544
         bra   L3553
         bra   L3562
         bra   L3544
         bra   L3585
         bra   L35AA
         ldd   ,x
         addd  <u0031
         pshs  b,a
         leax  $03,x
         jsr   <u0016
L3544    ldb   $02,y
         stb   [,s++]
         rts   
L3549    ldd   ,x
         addd  <u0031
         pshs  b,a
         leax  $03,x
         jsr   <u0016
L3553    ldd   $01,y
         std   [,s++]
         rts   
L3558    ldd   ,x
         addd  <u0031
         pshs  b,a
         leax  $03,x
         jsr   <u0016
L3562    puls  u
         ldd   $01,y
         std   ,u
         ldd   $03,y
         std   u0002,u
         lda   $05,y
         sta   u0004,u
         rts   
         ldd   ,x
         addd  <u0066
         tfr   d,u
         ldd   ,u
         addd  <u0031
         pshs  b,a
         ldd   u0002,u
         pshs  b,a
         leax  $03,x
         jsr   <u0016
L3585    puls  u,b,a
         tstb  
         bne   L358B
         deca  
L358B    sta   <u003E
         ldy   $01,y
         sty   <u0048
L3593    lda   ,y+
         sta   ,u+
         cmpa  #$FF
         beq   L35A2
         decb  
         bne   L3593
         dec   <u003E
         bpl   L3593
L35A2    clra  
         rts   
         lbsr  L320D
         lbra  L3518
L35AA    puls  u,b,a
         cmpd  $03,y
         bls   L35B3
         ldd   $03,y
L35B3    ldy   $01,y
         exg   y,u
         lbra  L3204
         jsr   <u0016
         ldd   $01,y
         pshs  b,a
         jsr   <u0016
         ldb   $02,y
         stb   [,s++]
         rts   
         lbsr  L383F
         lda   <u002E
         sta   <u007F
         leax  >L32B4,pcr
         lbsr  L3748
         lbra  L31EF
         lbra  L31F2
         lbsr  L383F
         lbra  L321C
         ldd   ,x
         leax  $03,x
L35E6    ldy   <u0031
         ldu   <$14,y
         cmpu  <u004A
         bhi   L35F6
         ldb   #$35
         lbra  L39E4
L35F6    stx   ,--u
         stu   <$14,y
         stu   <u0046
         addd  <u005E
         tfr   d,x
         rts   
         ldy   <u0031
         cmpy  <$14,y
         bhi   L3610
         ldb   #$36
         lbra  L39E4
L3610    ldu   <$14,y
         ldx   ,u++
         stu   <$14,y
         stu   <u0046
         rts   
         ldd   ,x
         cmpa  #$1E
         beq   L3656
         jsr   <u0016
         ldd   ,x
         lslb  
         rola  
         lslb  
         rola  
         addd  #$0002
         leau  d,x
         pshs  u
         ldd   $01,y
         ble   L3654
         cmpd  ,x++
         bhi   L3654
         subd  #$0001
         lslb  
         rola  
         lslb  
         rola  
         addd  #$0001
         ldd   d,x
         pshs  b,a
         ldb   ,x
         cmpb  #$22
         puls  x,b,a
         beq   L35E6
         addd  <u005E
         tfr   d,x
         rts   
L3654    puls  pc,x
L3656    ldu   <u0031
         cmpb  #$20
         bne   L366B
         ldd   $02,x
         addd  <u005E
         std   <u0011,u
         lda   #$01
         sta   <u0013,u
         leax  $05,x
         rts   
L366B    clr   <u0013,u
         leax  $02,x
         rts   
         bsr   L368F
         ldb   #$0B
         os9   I$Create 
         bra   L367F
         bsr   L368F
         os9   I$Open   
L367F    lbcs  L39E4
         puls  u,b
         cmpb  #$01
         bne   L368B
         clr   ,u+
L368B    sta   ,u
         puls  pc,x
L368F    leax  $01,x
         lbsr  L3762
         leax  $01,x
         jsr   <u0016
         lda   #$03
         cmpb  #$4A
         bne   L36A0
         lda   ,x++
L36A0    ldu   $03,s
         stx   $03,s
         ldx   $01,y
         jmp   ,u
         lbsr  L379F
         jsr   <u0016
         ldb   #$0E
         lbsr  L3219
         lbcs  L39E6
         rts   
L36B7    swi   
         fcb   $20 
         stu   >$2A2A
         bra   L3707
         jmp   -$10,s
         eim   #$74,>$2065
         aim   #$72,>$6F72
         bra   L36F7
         bra   L373E
         eim   #$65,$0E,s
         lsr   >$6572
         bra   L36FE
         bpl   L36E3
         stu   >$962E
         lbsr  L379F
         lda   #$2C
         sta   <u00DD
         pshs  x
L36E2    ldx   ,s
         ldb   ,x
         cmpb  #$90
         bne   L36F2
         jsr   <u0016
         pshs  x
         ldx   $01,y
         bra   L36F7
L36F2    pshs  x
         leax  <L36B7,pcr
L36F7    bsr   L3748
         puls  x
         lda   <u007F
         cmpa  <u002E
         bne   L3705
         lda   <u002D
         sta   <u007F
L3705    ldb   #$06
L3707    lbsr  L3219
         bcc   L3719
         cmpb  #$03
         lbne  L39E6
         lbsr  L3A0C
         clr   <u0036
         bra   L36E2
L3719    bsr   L372C
         bcc   L3724
         leax  <L36BA,pcr
         bsr   L3748
         bra   L36E2
L3724    ldb   ,x+
         cmpb  #$4B
         beq   L3719
         puls  pc,b,a
L372C    bsr   L3762
         ldb   ,s
         addb  #$07
         ldy   <u0046
         lbsr  L3219
         lbcc  L3526
         lda   ,s
L373E    cmpa  #$04
         bcs   L3744
         leas  $02,s
L3744    leas  $03,s
         coma  
         rts   
L3748    pshs  y
         leas  -$06,s
         leay  ,s
         stx   $01,y
         ldd   <u0080
         std   <u0082
         ldb   #$05
         lbsr  L3219
         ldb   #$00
         lbsr  L3219
         leas  $06,s
         puls  pc,y
L3762    lda   ,x+
         cmpa  #$0E
         bne   L376C
         jsr   <u0016
         bra   L3791
L376C    suba  #$80
         cmpa  #$04
         bcs   L3787
         beq   L3779
         lbsr  L320D
         bra   L3791
L3779    ldd   ,x++
         addd  <u0066
         tfr   d,u
         ldd   u0002,u
         std   <u003E
         ldd   ,u
         bra   L3789
L3787    ldd   ,x++
L3789    addd  <u0031
         tfr   d,u
         lda   -$03,x
         suba  #$80
L3791    puls  y
         cmpa  #$04
         bcs   L379B
         pshs  u
         ldu   <u003E
L379B    pshs  u,a
         jmp   ,y
L379F    ldb   ,x
         cmpb  #$54
         bne   L37B1
         leax  $01,x
         jsr   <u0016
         cmpb  #$4B
         beq   L37AF
         leax  -$01,x
L37AF    lda   $02,y
L37B1    sta   <u007F
         rts   
         ldb   ,x
         cmpb  #$54
         bne   L37DE
         bsr   L379F
         clr   <u00DD
         cmpb  #$4B
         bne   L37C4
         leax  -$01,x
L37C4    ldb   #$06
         lbsr  L3219
         bcc   L37D7
         cmpb  #$E4
         beq   L37C4
L37CF    lbra  L39E6
L37D2    lbsr  L372C
         bcs   L37CF
L37D7    ldb   ,x+
         cmpb  #$4B
         beq   L37D2
         rts   
L37DE    bsr   L3838
         beq   L381B
L37E2    bsr   L37EB
         ldb   ,x+
         cmpb  #$4B
         beq   L37E2
         rts   
L37EB    lbsr  L3762
         bsr   L381D
         lda   ,s
         bne   L37F5
         inca  
L37F5    cmpa  ,y
         lbeq  L3526
         cmpa  #$02
         bcs   L3805
         beq   L3811
L3801    ldb   #$47
         bra   L3825
L3805    lda   ,y
         cmpa  #$02
         bne   L3801
         lbsr  L3210
         lbra  L3526
L3811    cmpa  ,y
         bcs   L3801
         lbsr  L3213
         lbra  L3526
L381B    leax  $01,x
L381D    pshs  x
         ldx   <u0039
         bne   L3828
         ldb   #$4F
L3825    lbra  L39E4
L3828    jsr   <u0016
         cmpb  #$4B
         beq   L3834
         ldd   ,x
         addd  <u005E
         tfr   d,x
L3834    stx   <u0039
         puls  pc,x
L3838    cmpb  #$3F
         beq   L383E
         cmpb  #$3E
L383E    rts   
L383F    lda   <u002E
         lbsr  L379F
         ldd   <u0080
         std   <u0082
         ldb   ,x+
         cmpb  #$49
         beq   L388C
L384E    bsr   L3838
         beq   L3874
L3852    cmpb  #$4B
         beq   L3868
         cmpb  #$51
         beq   L386C
         leax  -$01,x
         jsr   <u0016
         ldb   ,y
         addb  #$01
         bsr   L3884
         ldb   -$01,x
         bra   L384E
L3868    ldb   #$0D
         bsr   L3884
L386C    ldb   ,x+
         bsr   L3838
         bne   L3852
         bra   L3878
L3874    ldb   #$0C
         bsr   L3884
L3878    ldb   #$00
         bsr   L3884
         lda   <u00DE
         clr   <u00DE
         tsta  
         bne   L3889
L3883    rts   
L3884    lbsr  L3219
         bcc   L3883
L3889    lbra  L39E6
L388C    jsr   <u0016
         ldd   <u004A
         std   <u008E
         std   <u008C
         ldu   <u0046
         pshs  u,b,a
         clr   <u0094
         ldd   <u0048
         std   <u004A
L389E    ldb   -$01,x
         bsr   L3838
         beq   L38C0
         ldb   ,x+
         bsr   L3838
         beq   L38BB
         leax  -$01,x
         ldb   #$11
         lbsr  L3219
         bcc   L389E
         puls  u,b,a
         std   <u004A
         stu   <u0046
         bra   L3889
L38BB    leay  <L3878,pcr
         bra   L38C3
L38C0    leay  <L3874,pcr
L38C3    puls  u,b,a
         std   <u004A
         stu   <u0046
         jmp   ,y
         lda   <u002E
         lbsr  L379F
         ldu   <u0080
         stu   <u0082
         ldb   ,x+
         lbsr  L3838
         beq   L38FD
         cmpb  #$4B
         beq   L38EB
         leax  -$01,x
         bra   L38EB
L38E3    clra  
         ldb   #$12
         lbsr  L3219
         bcs   L3889
L38EB    jsr   <u0016
         ldb   ,y
         addb  #$01
         lbsr  L3219
         bcs   L3889
         ldb   -$01,x
         lbsr  L3838
         bne   L38E3
L38FD    lbra  L3874
         bsr   L3913
         os9   I$Read   
         bra   L390C
         bsr   L3913
         os9   I$Write  
L390C    leax  ,u
         bcc   L3932
L3910    lbra  L39E4
L3913    lbsr  L379F
         lbsr  L3762
         leau  ,x
         puls  a
         cmpa  #$04
         bcc   L392C
         leax  >L3B44,pcr
         ldb   a,x
         clra  
         tfr   d,y
         bra   L392E
L392C    puls  y
L392E    puls  x
         lda   <u007F
L3932    rts   
L3933    lbsr  L379F
         os9   I$Close  
         bcs   L3910
         cmpb  #$4B
         beq   L3933
         rts   
         ldb   ,x+
         cmpb  #$3B
         beq   L3950
         ldu   <u002F
         ldd   <u0013,u
L394B    addd  <u005E
         std   <u0039
         rts   
L3950    ldd   ,x
         addd  #$0001
         leax  $03,x
         bra   L394B
         jsr   <u0016
         pshs  x
         ldx   $01,y
         os9   I$Delete 
L3962    bcs   L3910
         puls  pc,x
         jsr   <u0016
         lda   #$03
L396A    pshs  x
         ldx   $01,y
         os9   I$ChgDir 
         bra   L3962
         jsr   <u0016
         lda   #$04
         bra   L396A
         lbsr  L3762
         ldy   <u0046
         leay  -$06,y
         ldb   <u007F
         clra  
         std   $01,y
         lbra  L3526
         jsr   <u0016
         ldy   $01,y
         pshs  u,y,x
         lbsr  L31F5
         puls  u,y,x
         bsr   L39C9
         sts   <u00B1
         lds   <u0080
         os9   F$Chain  
         lds   <u00B1
         bra   L39E4
         jsr   <u0016
         pshs  u,x
         ldy   $01,y
         bsr   L39C9
         os9   F$Fork   
         bcs   L39E4
         pshs  a
L39B5    os9   F$Wait   
         cmpa  ,s
         bne   L39B5
         leas  $01,s
         tstb  
         bne   L39E4
         puls  pc,u,x
L39C3    comb  
         lsla  
         fcb   $45 E
         inca  
         inca  
         tst   <u009E
         lsla  
         lda   #$0D
         sta   -$01,x
         tfr   x,d
         leax  >L39C3,pcr
         leau  ,y
         pshs  y
         subd  ,s++
         tfr   d,y
         clra  
         clrb  
         rts   
         jsr   <u0016
         ldb   $02,y
L39E4    stb   <u0036
L39E6    ldu   <u0031
         beq   L3A04
         tst   <u0013,u
         beq   L39FD
         lds   u0005,u
         ldx   <u0011,u
         ldd   <u0014,u
         std   <u0046
         lbra  L335A
L39FD    bsr   L3A0C
         bsr   L3A5C
         lbra  L31EF
L3A04    lbsr  L31F8
         lbra  L31EF
L3A0A    jmp   <u00FF
L3A0C    leax  <L3A0A,pcr
         lbsr  L3748
         ldx   <u005C
         leay  ,x
         lbsr  L3201
         clr   <u0074
         lbsr  L321F
         ldb   <u0036
         lbsr  L31F8
         lbra  L321C
         clrb  
         bra   L3A2B
         ldb   #$01
L3A2B    clra  
         std   <u0042
         leax  $01,x
         rts   
         ldb   ,x+
         clra  
         leax  d,x
         rts   
         exg   x,pc
         rts   
         leay  ,x
         lbsr  L3201
         leax  ,y
         rts   
         ldb   #$33
         bra   L39E4
         lda   #$01
         bra   L3A4B
         clra  
L3A4B    ldu   <u0031
         sta   u0001,u
         leax  $01,x
         rts   
L3A52    lda   <u0034
         bita  #$01
         bne   L3A72
         ora   #$01
         bra   L3A64
L3A5C    lda   <u0034
         bita  #$01
         beq   L3A72
         anda  #$FE
L3A64    sta   <u0034
         ldd   <u0017
         pshs  b,a
         ldd   <u0019
         std   <u0017
         puls  b,a
         std   <u0019
L3A72    rts   
         lbsr  L320D
         pshs  x
         ldb   <u00CF
         cmpb  #$A0
         beq   L3A9F
         ldy   <u0048
         ldx   <u003E
L3A83    lda   ,u+
         leax  -$01,x
         beq   L3A91
         sta   ,y+
         cmpa  #$FF
         bne   L3A83
         lda   ,--y
L3A91    ora   #$80
         sta   ,y
         ldy   <u0048
         lbsr  L31FB
         bcs   L3ADD
         leau  ,x
L3A9F    ldd   ,u
         bne   L3AB1
         ldy   <u00D2
         leay  $03,y
         lbsr  L31FB
         bcs   L3ADD
         ldd   ,x
         std   ,u
L3AB1    ldx   ,s
         std   ,s
         ldu   <u0031
         lda   <u0034
         sta   ,u
         ldb   <u0043
         stb   u0002,u
         ldd   <u004A
         std   u000D,u
         ldd   <u0040
         std   u000F,u
         ldd   <u0039
         std   u0009,u
         bsr   L3B48
         stx   u000B,u
         puls  x
         lda   $06,x
         beq   L3B0C
         cmpa  #$22
         beq   L3B0C
         cmpa  #$21
         beq   L3AE2
L3ADD    ldb   #$2B
L3ADF    lbra  L39E4
L3AE2    ldd   u0005,u
         pshs  b,a
         sts   u0005,u
         leas  ,y
         ldd   <u0040
         pshs  y
         subd  ,s++
         lsra  
         rorb  
         lsra  
         rorb  
         pshs  b,a
         ldd   $09,x
         leay  >L32C6,pcr
         jsr   d,x
         ldu   <u0031
         lds   u0005,u
         puls  x
         stx   u0005,u
         bcc   L3B25
         bra   L3ADF
L3B0C    lbsr  L3A5C
         lda   <u0034
         anda  #$7F
         sta   <u0034
         lbsr  L32C6
         lda   ,u
         bita  #$01
         beq   L3B25
         lbsr  L3A52
         lda   ,u
         sta   <u0034
L3B25    ldd   u000D,u
         std   <u004A
         ldd   u000F,u
         std   <u0040
         ldd   u0009,u
         std   <u0039
         ldb   u0002,u
         sex   
         std   <u0042
         ldx   u0003,u
         lbsr  L333A
         ldx   u000B,u
         ldd   <u0044
         subd  <u004A
         std   <u000C
         rts   
L3B44    oim   #$02,<u0005
         oim   #$34,<u0040
         ldb   ,x+
         clra  
         pshs  x,a
         cmpb  #$4D
         bne   L3BCA
         leay  ,s
L3B55    pshs  y
         ldb   ,x
         cmpb  #$0E
         beq   L3B8C
         jsr   <u0016
         leax  -$01,x
         cmpa  #$02
         beq   L3B6F
         cmpa  #$04
         beq   L3B7C
         ldd   $01,y
         std   $04,y
         lda   ,y
L3B6F    ldb   #$06
         leau  <L3B44,pcr
         subb  a,u
         leau  b,y
         stu   <u0046
         bra   L3B90
L3B7C    ldu   $01,y
         ldd   <u0048
         subd  <u004A
         std   <u003E
         ldd   <u0048
         std   <u004A
         lda   #$04
         bra   L3B90
L3B8C    leax  $01,x
         jsr   <u0016
L3B90    puls  y
         inc   ,y
         cmpa  #$04
         bcs   L3B9C
         pshs  u
         ldu   <u003E
L3B9C    pshs  u,a
         ldb   ,x+
         cmpb  #$4B
         beq   L3B55
         leax  $01,x
         stx   $01,y
         leax  <L3B44,pcr
         ldu   <u0046
         stu   <u0040
L3BAF    puls  b
         cmpb  #$04
         bcs   L3BB9
         puls  b,a
         bra   L3BBC
L3BB9    ldb   b,x
         clra  
L3BBC    std   ,--u
         puls  b,a
         std   ,--u
         dec   ,y
         bne   L3BAF
         leay  ,u
         bra   L3BD0
L3BCA    ldy   <u0046
         sty   <u0040
L3BD0    tfr   y,d
         subd  <u004A
         lbcs  L32EB
         std   <u000C
         puls  pc,u,x,a
         jsr   <u0016
         ldy   $01,y
         pshs  x
         lbsr  L31FE
         puls  pc,x
         lbsr  L3216
         leax  >L3228,pcr
         stx   <u000E
         rts   
         pshs  x,b,a
         ldb   [<$04,s]
         leax  <L3C02,pcr
         ldd   b,x
         leax  d,x
         stx   $04,s
         puls  pc,x,b,a
L3C02    sexw  
         pulu  cc
         asr   $03,x
         eora  <u0004
         ora   >$061B
         lsl   <u0030
         rol   <u0022
         lsl   <u00EA
L3C12    jsr   <u001B
         lsl   <u009D
         bcc   L3C1E
L3C18    jsr   <u002A
         aim   #$9D,<u001B
         orcc  #$12
         rol   -$0E,x
         blt   L3C35
         fcb   $45 E
         nop   
         nop   
         nop   
         stu   -$0E,x
         addd  >$1343
         sync  
         lbsr  L44B6
         lsl   <u00EB
         lsl   <u00F2
         lsl   <u004E
         lsl   <u007F
         ror   <u00E0
         oim   #$F3,<u0002
         stu   $06,x
         addb  #$06
         cmpb  <u0006
         stb   <u0007
         deca  
         asr   <u008E
         asr   <u001C
         asr   <u0022
         asr   <u0070
         ror   <u00FE
         asr   <u0032
         asr   <u007C
         asr   <u0010
         asr   <u0068
         asr   <u003A
         asr   <u0082
         asr   <u000A
         asr   <u0060
         asr   <u0042
         asr   <u0088
         asr   <u0016
         asr   <u002A
         asr   <u0076
         asr   <u0004
         oim   #$FA,<u0002
         ldd   >$0830
         aim   #$03,<u0002
         ldb   >$020C
         lsr   <u0017
         aim   #$67,<u0005
         lsl   >$0681
         ror   <u0081
         neg   <u00B7
         neg   <u00B7
         neg   <u00B7
         neg   <u00B7
         neg   <u00BD
         neg   <u00BD
         neg   <u00BD
         neg   <u00BD
         neg   <u0000
         neg   <u0000
         neg   <u0000
         neg   <u0000
         neg   <u0000
         neg   <u0000
L3C9E    oim   #$CC,<u0001
         sbcb  $02,x
         eorb  <u0006
         adca  >$0812
         neg   <u00A4
         neg   <u00A4
         neg   <u00A4
         neg   <u00A4
         neg   <u00B3
         neg   <u00B3
         neg   <u00B3
         neg   <u00B3
         oim   #$C8,<u0001
         ldu   <u0002
         fcb   $C7 G
         asr   <u00E2
         oim   #$DE,<u000A
         ora   #$0A
         ora   #$0A
         cmpx  <u000A
         cmpx  <u0009
         cwai  #$09
         bgt   L3CD8
         std   $09,x
         bitb  >$1125
         jmp   <u004E
         nop   
         sbcb  #$09
         bra   L3CE4
         nop   
         tst   <u00CD
         tst   <u00FA
         jmp   <u0008
         inc   <u0072
L3CE4    inc   <u00B3
         tst   <u004E
         tim   #$AF,<u0009
         neg   <u0008
         adcb  >$0AF6
         dec   <u00EA
         rol   <u0040
         rol   <u0040
         lsl   <u004E
         dec   <u0011
         rol   <u003B
         lsl   <u0086
         lsl   <u004E
         rol   <u003B
         dec   <u0050
         dec   <u0059
         rol   <u000B
         dec   <u00C5
         dec   <u006A
         ldf   >$1208
         dec   <u00CA
         dec   <u00DA
         dec   <u00D2
         dec   <u00B4
         dec   <u00B9
         sync  
         suba  #$12
         ora   $01,x
         fcb   $52 R
         oim   #$68,<u0002
         fcb   $5E ^
         ror   <u003F
         asr   <u00A2
         asr   <u00C1
L3D2A    ldy   <u0046
         ldd   <u004A
         std   <u0048
         bra   L3D3A
L3D33    lslb  
         ldu   <u0010
         ldd   b,u
         jsr   d,u
L3D3A    ldb   ,x+
         bmi   L3D33
         clra  
         lda   ,y
         rts   
         bsr   L3D69
L3D44    pshs  pc,u
         ldu   <u0012
         lsla  
         ldd   a,u
         leau  d,u
         stu   $02,s
         puls  pc,u
         bsr   L3D61
         bra   L3D44
         leas  $02,s
         lda   #$F2
         bra   L3D6B
         leas  $02,s
         lda   #$F6
         bra   L3D63
L3D61    lda   #$89
L3D63    sta   <u00A3
         clr   <u003B
         bra   L3D6F
L3D69    lda   #$85
L3D6B    sta   <u00A3
         sta   <u003B
L3D6F    ldd   ,x++
         addd  <u0062
         std   <u00D2
         ldu   <u00D2
         lda   ,u
         anda  #$E0
         sta   <u00CF
         eora  #$80
         sta   <u00CE
         lda   ,u
         anda  #$07
         ldb   -$03,x
         subb  <u00A3
         pshs  b,a
         lda   ,u
         anda  #$18
         lbeq  L3E28
         ldd   u0001,u
         addd  <u0066
         tfr   d,u
         ldd   ,u
         std   <u003C
         lda   $01,s
         bne   L3DAD
         lda   #$05
         sta   ,s
         ldd   u0002,u
         std   <u003E
         clra  
         clrb  
         bra   L3E00
L3DAD    leay  -$06,y
         clra  
         clrb  
         std   $01,y
         leau  u0004,u
         bra   L3DBE
L3DB7    ldd   ,u
         std   $01,y
         lbsr  L3EAA
L3DBE    ldd   $07,y
         subd  <u0042
         cmpd  ,u++
         bcs   L3DCC
         ldb   #$37
         lbra  L3C15
L3DCC    addd  $01,y
         std   $07,y
         dec   $01,s
         bne   L3DB7
         lda   ,s
         beq   L3DE8
         cmpa  #$02
         bcs   L3DEC
         beq   L3DF4
         cmpa  #$04
         bcs   L3DE8
         ldd   ,u
         std   <u003E
         bra   L3DF7
L3DE8    ldd   $07,y
         bra   L3DF0
L3DEC    ldd   $07,y
         lslb  
         rola  
L3DF0    leay  $0C,y
         bra   L3E00
L3DF4    ldd   #$0005
L3DF7    std   $01,y
         lbsr  L3EAA
         ldd   $01,y
         leay  $06,y
L3E00    tst   <u00CE
         bne   L3E1C
         pshs  b,a
         ldd   <u003C
         addd  <u0031
         cmpd  <u0040
         bcc   L3E61
         tfr   d,u
         puls  b,a
         cmpd  u0002,u
         bhi   L3E61
         addd  ,u
         bra   L3E5C
L3E1C    addd  <u003C
         tst   <u003B
         bne   L3E5A
L3E22    addd  $01,y
         leay  $06,y
         bra   L3E5C
L3E28    lda   ,s
         cmpa  #$04
         ldd   u0001,u
         bcs   L3E3A
         addd  <u0066
         tfr   d,u
         ldd   u0002,u
         std   <u003E
         ldd   ,u
L3E3A    tst   <u003B
         beq   L3E22
         addd  <u0031
         tfr   d,u
         tst   <u00CE
         bne   L3E5E
         cmpd  <u0040
         bcc   L3E61
         ldd   <u003E
         cmpd  u0002,u
         bcs   L3E56
         ldd   u0002,u
         std   <u003E
L3E56    ldu   ,u
         bra   L3E5E
L3E5A    addd  <u0031
L3E5C    tfr   d,u
L3E5E    clra  
         puls  pc,b,a
L3E61    ldb   #$38
         lbra  L3C15
         leau  ,x+
         bra   L3E70
         ldd   ,x++
         addd  <u0031
         tfr   d,u
L3E70    ldb   ,u
         clra  
         leay  -$06,y
         std   $01,y
         lda   #$01
         sta   ,y
         rts   
         leau  ,x++
         bra   L3E86
         ldd   ,x++
         addd  <u0031
         tfr   d,u
L3E86    ldd   ,u
         leay  -$06,y
         std   $01,y
         lda   #$01
         sta   ,y
         rts   
         clra  
         clrb  
         subd  $01,y
         std   $01,y
         rts   
         ldd   $07,y
         addd  $01,y
         leay  $06,y
         std   $01,y
         rts   
         ldd   $07,y
         subd  $01,y
         leay  $06,y
         std   $01,y
         rts   
L3EAA    ldd   $07,y
         beq   L3EE3
         cmpd  #$0002
         bne   L3EB8
         ldd   $01,y
         bra   L3EC4
L3EB8    ldd   $01,y
         beq   L3EC6
         cmpd  #$0002
         bne   L3ECA
         ldd   $07,y
L3EC4    lslb  
         rola  
L3EC6    std   $07,y
         bra   L3EE3
L3ECA    lda   $08,y
         mul   
         sta   $03,y
         lda   $08,y
         stb   $08,y
         ldb   $01,y
         mul   
         addb  $03,y
         lda   $07,y
         stb   $07,y
         ldb   $02,y
         mul   
         addb  $07,y
         stb   $07,y
L3EE3    leay  $06,y
         rts   
L3EE6    clr   ,y
         ldd   $07,y
         bpl   L3EF4
         nega  
         negb  
         sbca  #$00
         std   $07,y
         com   ,y
L3EF4    ldd   $01,y
         bpl   L3F00
         nega  
         negb  
         sbca  #$00
         std   $01,y
         com   ,y
L3F00    cmpd  #$0002
         rts   
L3F05    bsr   L3EE6
         bne   L3F17
         ldd   $07,y
         beq   L3F24
         asra  
         rorb  
         std   $07,y
         ldd   #$0000
         rolb  
         bra   L3F4E
L3F17    ldd   $01,y
         bne   L3F20
         ldb   #$2D
         lbra  L3C15
L3F20    ldd   $07,y
         bne   L3F29
L3F24    leay  $06,y
         std   $03,y
         rts   
L3F29    tsta  
         bne   L3F34
         exg   a,b
         std   $07,y
         ldb   #$08
         bra   L3F36
L3F34    ldb   #$10
L3F36    stb   $03,y
         clra  
         clrb  
L3F3A    lsl   $08,y
         rol   $07,y
         rolb  
         rola  
         subd  $01,y
         bmi   L3F48
         inc   $08,y
         bra   L3F4A
L3F48    addd  $01,y
L3F4A    dec   $03,y
         bne   L3F3A
L3F4E    std   $09,y
         tst   ,y
         bpl   L3F62
         nega  
         negb  
         sbca  #$00
         std   $09,y
         ldd   $07,y
         nega  
         negb  
         sbca  #$00
         std   $07,y
L3F62    leay  $06,y
         rts   
         leay  -$06,y
         ldb   ,x+
         lda   #$02
         std   ,y
         ldd   ,x++
         std   $02,y
         ldd   ,x++
         std   $04,y
         rts   
         ldd   ,x++
         addd  <u0031
         tfr   d,u
L3F7C    leay  -$06,y
         lda   #$02
         ldb   ,u
         std   ,y
         ldd   u0001,u
         std   $02,y
         ldd   u0003,u
         std   $04,y
         rts   
         lda   $05,y
         eora  #$01
         sta   $05,y
         rts   
L3F94    ldb   $05,y
         eorb  #$01
         stb   $05,y
L3F9A    pshs  x
         tst   $02,y
         beq   L3FB0
         tst   $08,y
         bne   L3FB4
L3FA4    ldd   $01,y
         std   $07,y
         ldd   $03,y
         std   $09,y
         lda   $05,y
         sta   $0B,y
L3FB0    leay  $06,y
         puls  pc,x
L3FB4    lda   $07,y
         suba  $01,y
         bvc   L3FBE
         bpl   L3FA4
         bra   L3FB0
L3FBE    bmi   L3FC6
         cmpa  #$1F
         ble   L3FCE
         bra   L3FB0
L3FC6    cmpa  #$E1
         blt   L3FA4
         ldb   $01,y
         stb   $07,y
L3FCE    ldb   $0B,y
         andb  #$01
         stb   ,y
         eorb  $05,y
         andb  #$01
         stb   $01,y
         ldb   $0B,y
         andb  #$FE
         stb   $0B,y
         ldb   $05,y
         andb  #$FE
         stb   $05,y
         tsta  
         beq   L401A
         bpl   L4012
         nega  
         leax  $06,y
         bsr   L406B
         tst   $01,y
         beq   L4022
L3FF4    subd  $04,y
         exg   d,x
         sbcb  $03,y
         sbca  $02,y
         bcc   L4036
         coma  
         comb  
         exg   d,x
         coma  
         comb  
         addd  #$0001
         exg   d,x
         bcc   L400E
         addd  #$0001
L400E    dec   ,y
         bra   L4036
L4012    leax  ,y
         bsr   L406B
         stx   $02,y
         std   $04,y
L401A    ldx   $08,y
         ldd   $0A,y
         tst   $01,y
         bne   L3FF4
L4022    addd  $04,y
         exg   d,x
         adcb  $03,y
         adca  $02,y
         bcc   L4036
         rora  
         rorb  
         exg   d,x
         rora  
         rorb  
         inc   $07,y
         exg   d,x
L4036    tsta  
         bmi   L4049
L4039    dec   $07,y
         lbvs  L40C6
         exg   d,x
         lslb  
         rola  
         exg   d,x
         rolb  
         rola  
         bpl   L4039
L4049    exg   d,x
         addd  #$0001
         exg   d,x
         bcc   L405A
         addd  #$0001
         bcc   L405A
         rora  
         inc   $07,y
L405A    std   $08,y
         tfr   x,d
         andb  #$FE
         tst   ,y
         beq   L4065
         incb  
L4065    std   $0A,y
         leay  $06,y
         puls  pc,x
L406B    suba  #$10
         bcs   L4089
         suba  #$08
         bcs   L407A
         pshs  a
         clra  
         ldb   $02,x
         bra   L4080
L407A    adda  #$08
         pshs  a
         ldd   $02,x
L4080    ldx   #$0000
         tst   ,s
         beq   L40B2
         bra   L40A6
L4089    adda  #$08
         bcc   L409C
         pshs  a
         clra  
         ldb   $02,x
         ldx   $03,x
         tst   ,s
         bne   L40A8
         exg   d,x
         bra   L40B2
L409C    adda  #$08
         pshs  a
         ldd   $02,x
         ldx   $04,x
         bra   L40A8
L40A6    exg   d,x
L40A8    lsra  
         rorb  
         exg   d,x
         rora  
         rorb  
         dec   ,s
         bne   L40A6
L40B2    leas  $01,s
         rts   
L40B5    bsr   L40BC
         lbcs  L3C15
         rts   
L40BC    pshs  x
         lda   $02,y
         bpl   L40C6
         lda   $08,y
         bmi   L40D2
L40C6    clra  
         clrb  
         std   $07,y
         std   $09,y
         sta   $0B,y
         leay  $06,y
         puls  pc,x
L40D2    lda   $01,y
         adda  $07,y
         bvc   L40DF
L40D8    bpl   L40C6
         comb  
         ldb   #$32
         puls  pc,x
L40DF    sta   $07,y
         ldb   $0B,y
         eorb  $05,y
         andb  #$01
         stb   ,y
         lda   $0B,y
         anda  #$FE
         sta   $0B,y
         ldb   $05,y
         andb  #$FE
         stb   $05,y
         mul   
         sta   ,-s
         clr   ,-s
         clr   ,-s
         lda   $0B,y
         ldb   $04,y
         mul   
         addd  $01,s
         std   $01,s
         bcc   L4109
         inc   ,s
L4109    lda   $0A,y
         ldb   $05,y
         mul   
         addd  $01,s
         std   $01,s
         bcc   L4116
         inc   ,s
L4116    ldb   $02,s
         ldx   ,s
         stx   $01,s
         clr   ,s
         lda   $0B,y
         ldb   $03,y
         mul   
         addd  $01,s
         std   $01,s
         bcc   L412B
         inc   ,s
L412B    lda   $0A,y
         ldb   $04,y
         mul   
         addd  $01,s
         std   $01,s
         bcc   L4138
         inc   ,s
L4138    lda   $09,y
         ldb   $05,y
         mul   
         addd  $01,s
         std   $01,s
         bcc   L4145
         inc   ,s
L4145    ldb   $02,s
         ldx   ,s
         stx   $01,s
         clr   ,s
         lda   $0B,y
         ldb   $02,y
         mul   
         addd  $01,s
         std   $01,s
         bcc   L415A
         inc   ,s
L415A    lda   $0A,y
         ldb   $03,y
         mul   
         addd  $01,s
         std   $01,s
         bcc   L4167
         inc   ,s
L4167    lda   $09,y
         ldb   $04,y
         mul   
         addd  $01,s
         std   $01,s
         bcc   L4174
         inc   ,s
L4174    lda   $08,y
         ldb   $05,y
         mul   
         addd  $01,s
         std   $01,s
         bcc   L4181
         inc   ,s
L4181    ldb   $02,s
         ldx   ,s
         stx   $01,s
         clr   ,s
         stb   $0B,y
         lda   $0A,y
         ldb   $02,y
         mul   
         addd  $01,s
         std   $01,s
         bcc   L4198
         inc   ,s
L4198    lda   $09,y
         ldb   $03,y
         mul   
         addd  $01,s
         std   $01,s
         bcc   L41A5
         inc   ,s
L41A5    lda   $08,y
         ldb   $04,y
         mul   
         addd  $01,s
         std   $01,s
         bcc   L41B2
         inc   ,s
L41B2    ldb   $02,s
         ldx   ,s
         stx   $01,s
         clr   ,s
         stb   $0A,y
         lda   $09,y
         ldb   $02,y
         mul   
         addd  $01,s
         std   $01,s
         bcc   L41C9
         inc   ,s
L41C9    lda   $08,y
         ldb   $03,y
         mul   
         addd  $01,s
         std   $01,s
         bcc   L41D6
         inc   ,s
L41D6    lda   $08,y
         ldb   $02,y
         mul   
         addd  ,s
         bmi   L41EB
         lsl   $0B,y
         rol   $0A,y
         rol   $02,s
         rolb  
         rola  
         dec   $07,y
         bvs   L4204
L41EB    std   $08,y
         lda   $02,s
         ldb   $0A,y
         addd  #$0001
         bcc   L4209
         inc   $09,y
         bne   L420B
         inc   $08,y
         bne   L420B
         ror   $08,y
         inc   $07,y
         bvc   L420B
L4204    leas  $03,s
         lbra  L40D8
L4209    andb  #$FE
L420B    orb   ,y
         std   $0A,y
         leay  $06,y
         leas  $03,s
         clrb  
         puls  pc,x
L4216    bsr   L421D
         lbcs  L3C15
L421C    rts   
L421D    comb  
         ldb   #$2D
         tst   $02,y
         beq   L421C
         pshs  x
         tst   $08,y
         lbeq  L40C6
         lda   $07,y
         suba  $01,y
         lbvs  L40D8
         sta   $07,y
         lda   #$21
         ldb   $05,y
         eorb  $0B,y
         andb  #$01
         std   ,y
         lsr   $02,y
         ror   $03,y
         ror   $04,y
         ror   $05,y
         ldd   $08,y
         ldx   $0A,y
         lsra  
         rorb  
         exg   d,x
         rora  
         rorb  
         clr   $0B,y
         bra   L4258
L4256    exg   d,x
L4258    subd  $04,y
         exg   d,x
         bcc   L4261
         subd  #$0001
L4261    subd  $02,y
         beq   L4294
         bmi   L4290
L4267    orcc  #$01
L4269    dec   ,y
         beq   L42E1
         rol   $0B,y
         rol   $0A,y
         rol   $09,y
         rol   $08,y
         exg   d,x
         lslb  
         rola  
         exg   d,x
         rolb  
         rola  
         bcc   L4256
         exg   d,x
         addd  $04,y
         exg   d,x
         bcc   L428A
         addd  #$0001
L428A    addd  $02,y
         beq   L4294
         bpl   L4267
L4290    andcc #$FE
         bra   L4269
L4294    leax  ,x
         bne   L4267
         ldb   ,y
         decb  
         subb  #$10
         blt   L42B6
         subb  #$08
         blt   L42AB
         stb   ,y
         lda   $0B,y
         ldb   #$80
         bra   L42D4
L42AB    addb  #$08
         stb   ,y
         ldd   #$8000
         ldx   $0A,y
         bra   L42D6
L42B6    addb  #$08
         blt   L42C4
         stb   ,y
         ldx   $09,y
         lda   $0B,y
         ldb   #$80
         bra   L42D6
L42C4    addb  #$07
         stb   ,y
         ldx   $08,y
         ldd   $0A,y
         orcc  #$01
L42CE    rolb  
         rola  
         exg   d,x
         rolb  
         rola  
L42D4    exg   d,x
L42D6    andcc #$FE
         dec   ,y
         bpl   L42CE
         exg   d,x
         tsta  
         bra   L42E5
L42E1    ldx   $0A,y
         ldd   $08,y
L42E5    bmi   L42F5
         exg   d,x
         rolb  
         rola  
         exg   d,x
         rolb  
         rola  
         dec   $07,y
         lbvs  L40C6
L42F5    exg   d,x
         addd  #$0001
         exg   d,x
         bcc   L430A
         addd  #$0001
         bcc   L430A
         rora  
         inc   $07,y
         lbvs  L40D8
L430A    std   $08,y
         tfr   x,d
         andb  #$FE
         orb   $01,y
         std   $0A,y
         inc   $07,y
         lbvs  L40D8
L431A    leay  $06,y
         clrb  
         puls  pc,x
         pshs  x
         ldd   $07,y
         beq   L431A
         ldx   $01,y
         bne   L4338
         leay  $06,y
L432B    ldd   #$0180
         std   $01,y
         clr   $03,y
         clr   $04,y
         clr   $05,y
         puls  pc,x
L4338    std   $01,y
         stx   $07,y
         ldd   $09,y
         ldx   $03,y
         std   $03,y
         stx   $09,y
         lda   $0B,y
         ldb   $05,y
         sta   $05,y
         stb   $0B,y
         puls  x
         lbsr  L4794
         lbsr  L40B5
         lbra  L484D
         ldd   ,x++
         addd  <u0031
         tfr   d,u
         ldb   ,u
         clra  
         leay  -$06,y
         std   $01,y
         lda   #$03
         sta   ,y
         rts   
         ldb   $08,y
         andb  $02,y
         bra   L4379
         ldb   $08,y
         orb   $02,y
         bra   L4379
         ldb   $08,y
         eorb  $02,y
L4379    leay  $06,y
         std   $01,y
         rts   
         com   $02,y
         rts   
L4381    pshs  y,x
         ldx   $01,y
         ldy   $07,y
         sty   <u0048
L438B    lda   ,y+
         cmpa  ,x+
         bne   L4395
         cmpa  #$FF
         bne   L438B
L4395    inca  
         inc   -$01,x
         cmpa  -$01,x
         puls  pc,y,x
         bsr   L4381
         bcs   L43EE
         bra   L43F2
         bsr   L4381
         bls   L43EE
         bra   L43F2
         bsr   L4381
         beq   L43EE
         bra   L43F2
         bsr   L4381
         bne   L43EE
         bra   L43F2
         bsr   L4381
         bcc   L43EE
         bra   L43F2
         bsr   L4381
         bhi   L43EE
         bra   L43F2
         ldd   $07,y
         subd  $01,y
         blt   L43EE
         bra   L43F2
         ldd   $07,y
         subd  $01,y
         ble   L43EE
         bra   L43F2
         ldd   $07,y
         subd  $01,y
         bne   L43EE
         bra   L43F2
         ldd   $07,y
         subd  $01,y
         beq   L43EE
         bra   L43F2
         ldd   $07,y
         subd  $01,y
         bge   L43EE
         bra   L43F2
         ldd   $07,y
         subd  $01,y
         ble   L43F2
L43EE    ldb   #$FF
         bra   L43F4
L43F2    ldb   #$00
L43F4    clra  
         leay  $06,y
         std   $01,y
         lda   #$03
         sta   ,y
         rts   
         ldb   $08,y
         cmpb  $02,y
         beq   L43EE
         bra   L43F2
         ldb   $08,y
         cmpb  $02,y
         bne   L43EE
         bra   L43F2
         bsr   L4432
         blt   L43EE
         bra   L43F2
         bsr   L4432
         ble   L43EE
         bra   L43F2
         bsr   L4432
         bne   L43EE
         bra   L43F2
         bsr   L4432
         beq   L43EE
         bra   L43F2
         bsr   L4432
         bge   L43EE
         bra   L43F2
         bsr   L4432
         bgt   L43EE
         bra   L43F2
L4432    pshs  y
         andcc #$F0
         lda   $08,y
         bne   L444A
         lda   $02,y
         beq   L4448
L443E    lda   $05,y
L4440    anda  #$01
         bne   L4448
L4444    andcc #$F0
         orcc  #$08
L4448    puls  pc,y
L444A    lda   $02,y
         bne   L4454
         lda   $0B,y
         eora  #$01
         bra   L4440
L4454    lda   $0B,y
         eora  $05,y
         anda  #$01
         bne   L443E
         leau  $06,y
         lda   $05,y
         anda  #$01
         beq   L4466
         exg   u,y
L4466    ldd   u0001,u
         cmpd  $01,y
         bne   L4448
         ldd   u0003,u
         cmpd  $03,y
         bne   L447A
         lda   u0005,u
         cmpa  $05,y
         beq   L4448
L447A    bcs   L4444
         andcc #$F0
         puls  pc,y
L4480    clrb  
         stb   <u003E
L4483    ldu   <u0048
         leay  -$06,y
         stu   $01,y
         sty   <u0044
L448C    cmpu  <u0044
         bcc   L44AB
         lda   ,x+
         sta   ,u+
         cmpa  #$FF
         beq   L44A4
         decb  
         bne   L448C
         dec   <u003E
         bpl   L448C
         lda   #$FF
         sta   ,u+
L44A4    stu   <u0048
         lda   #$04
         sta   ,y
         rts   
L44AB    ldb   #$2F
         lbra  L3C15
         ldd   ,x++
         addd  <u0066
         tfr   d,u
L44B6    ldd   ,u
         addd  <u0031
         ldu   u0002,u
         stu   <u003E
         tfr   d,u
         pshs  x
         ldb   <u003F
         bne   L44C8
         dec   <u003E
L44C8    leax  ,u
         bsr   L4483
         puls  pc,x
         ldu   $01,y
         leay  $06,y
L44D2    lda   ,u+
         sta   -u0002,u
         cmpa  #$FF
         bne   L44D2
         leau  -u0001,u
         stu   <u0048
         rts   
         ldd   <u003E
         leay  -$06,y
         std   $03,y
         stu   $01,y
         lda   #$05
         sta   ,y
         rts   
L44EC    clra  
         clrb  
         std   $04,y
         ldd   $01,y
         bne   L44FB
         stb   $03,y
         lda   #$02
         sta   ,y
         rts   
L44FB    ldu   #$0210
         tsta  
         bpl   L4507
         nega  
         negb  
         sbca  #$00
         inc   $05,y
L4507    tsta  
         bne   L450F
         ldu   #$0208
         exg   a,b
L450F    tsta  
         bmi   L4518
L4512    leau  -u0001,u
         lslb  
         rola  
         bpl   L4512
L4518    std   $02,y
         stu   ,y
         rts   
         leay  $06,y
         bsr   L44EC
         leay  -$06,y
         rts   
L4524    ldb   $01,y
         bgt   L4537
         bmi   L4533
         lda   $02,y
         bpl   L4533
         ldd   #$0001
         bra   L457A
L4533    clra  
         clrb  
         bra   L4582
L4537    subb  #$10
         bhi   L4575
         bne   L454F
         ldd   $02,y
         ror   $05,y
         bcc   L4582
         cmpd  #$8000
         bne   L4575
         tst   $04,y
         bpl   L4582
         bra   L4575
L454F    cmpb  #$F8
         bhi   L4561
         pshs  b
         ldd   $02,y
         std   $03,y
         clr   $02,y
         puls  b
         addb  #$08
         beq   L456A
L4561    lsr   $02,y
         ror   $03,y
         ror   $04,y
         incb  
         bne   L4561
L456A    ldd   $02,y
         tst   $04,y
         bpl   L457A
         addd  #$0001
         bvc   L457A
L4575    ldb   #$34
         lbra  L3C15
L457A    ror   $05,y
         bcc   L4582
         nega  
         negb  
         sbca  #$00
L4582    std   $01,y
         lda   #$01
         sta   ,y
         rts   
         leay  $06,y
         bsr   L4524
         leay  -$06,y
         rts   
         leay  $0C,y
         bsr   L4524
         leay  -$0C,y
         rts   
         lda   $05,y
         anda  #$FE
         sta   $05,y
         rts   
         ldd   $01,y
         bpl   L45A8
         nega  
         negb  
         sbca  #$00
         std   $01,y
L45A8    rts   
         clra  
         ldb   [<$01,y]
         std   $01,y
         rts   
         lda   $02,y
         beq   L45C4
         lda   $05,y
         anda  #$01
         bne   L45C7
L45BA    ldb   #$01
         bra   L45C9
         ldd   $01,y
         bmi   L45C7
         bne   L45BA
L45C4    clrb  
         bra   L45C9
L45C7    ldb   #$FF
L45C9    sex   
         bra   L45D3
         ldb   <u0036
         clr   <u0036
L45D0    clra  
         leay  -$06,y
L45D3    std   $01,y
         lda   #$01
         sta   ,y
L45D9    rts   
         ldb   <u007D
         bra   L45D0
L45DE    ldb   $05,y
         asrb  
         lbcs  L4FB0
         ldb   #$1F
         stb   <u006E
         ldd   $01,y
         beq   L45D9
         inca  
         asra  
         sta   $01,y
         ldd   $02,y
         bcs   L45FF
         lsra  
         rorb  
         std   -$04,y
         ldd   $04,y
         rora  
         rorb  
         bra   L4603
L45FF    std   -$04,y
         ldd   $04,y
L4603    std   -$02,y
         clra  
         clrb  
         std   $02,y
         std   $04,y
         std   -$06,y
         std   -$08,y
         bra   L4621
L4611    orcc  #$01
         rol   $05,y
         rol   $04,y
         rol   $03,y
         rol   $02,y
         dec   <u006E
         beq   L4663
         bsr   L4678
L4621    ldb   -$04,y
         subb  #$40
         stb   -$04,y
         ldd   -$06,y
         sbcb  $05,y
         sbca  $04,y
         std   -$06,y
         ldd   -$08,y
         sbcb  $03,y
         sbca  $02,y
         std   -$08,y
         bpl   L4611
L4639    andcc #$FE
         rol   $05,y
         rol   $04,y
         rol   $03,y
         rol   $02,y
         dec   <u006E
         beq   L4663
         bsr   L4678
         ldb   -$04,y
         addb  #$C0
         stb   -$04,y
         ldd   -$06,y
         adcb  $05,y
         adca  $04,y
         std   -$06,y
         ldd   -$08,y
         adcb  $03,y
         adca  $02,y
         std   -$08,y
         bmi   L4639
         bra   L4611
L4663    ldd   $02,y
         bra   L466D
L4667    dec   $01,y
         lbvs  L40C6
L466D    lsl   $05,y
         rol   $04,y
         rolb  
         rola  
         bpl   L4667
         std   $02,y
         rts   
L4678    bsr   L467A
L467A    lsl   -$01,y
         rol   -$02,y
         rol   -$03,y
         rol   -$04,y
         rol   -$05,y
         rol   -$06,y
         rol   -$07,y
         rol   -$08,y
         rts   
         lbsr  L3F05
         ldd   $03,y
         std   $01,y
         rts   
L4693    leau  -$0C,y
         pshs  y
L4697    ldd   ,y++
         std   ,u++
         cmpu  ,s
         bne   L4697
         leas  $02,s
         leay  -u000C,u
         lbsr  L4216
         bsr   L46AF
         lbsr  L40B5
         lbra  L3F94
L46AF    lda   $01,y
         bgt   L46BC
         clra  
         clrb  
         std   $01,y
         std   $03,y
         stb   $05,y
L46BB    rts   
L46BC    cmpa  #$1F
         bcc   L46BB
         leau  $06,y
         ldb   -u0001,u
         andb  #$01
         pshs  u,b
         leau  $01,y
L46CA    leau  u0001,u
         suba  #$08
         bcc   L46CA
         beq   L46DE
         ldb   #$FF
L46D4    lslb  
         inca  
         bne   L46D4
         andb  ,u
         stb   ,u+
         bra   L46E2
L46DE    leau  u0001,u
L46E0    sta   ,u+
L46E2    cmpu  $01,s
         bne   L46E0
         puls  u,b
         orb   $05,y
         stb   $05,y
         rts   
         leay  -$06,y
         ldd   $07,y
         std   $01,y
         lbra  L3EAA
         leay  -$06,y
         ldd   $0A,y
         std   $04,y
         ldd   $08,y
         std   $02,y
         ldd   $06,y
         std   ,y
         lbra  L40B5
         ldd   <u0080
         ldu   <u0082
         pshs  u,b,a
         ldd   $01,y
         std   <u0080
         std   <u0082
         std   <u0048
         leay  $06,y
         ldb   #$09
         lbsr  L3C18
         puls  u,b,a
         std   <u0080
         stu   <u0082
         lbcs  L4FB0
         rts   
         lbsr  L3D3A
         leay  -$06,y
         stu   $01,y
L472F    lda   #$01
         sta   ,y
         leax  $01,x
         rts   
L4736    oim   #$02,<u0005
         oim   #$17,<u00F5
         std   >$313A
         cmpa  #$04
         bcc   L474C
         leau  >L4736,pcr
         ldb   a,u
         clra  
         bra   L474E
L474C    ldd   <u003E
L474E    std   $01,y
         bra   L472F
         ldd   #$00FF
         bra   L475A
         ldd   #$0000
L475A    leay  -$06,y
         std   $01,y
         lda   #$03
         sta   ,y
         rts   
         com   $01,y
         com   $02,y
         rts   
         ldd   $01,y
         anda  $07,y
         andb  $08,y
         bra   L477E
         ldd   $01,y
         eora  $07,y
         eorb  $08,y
         bra   L477E
         ldd   $01,y
         ora   $07,y
         orb   $08,y
L477E    std   $07,y
         leay  $06,y
         rts   
L4783    stu   >$DE5B
         eorb  <u00AA
         bsr   L4794
         leau  >L4783,pcr
         lbsr  L3F7C
         lbra  L40B5
L4794    pshs  x
         ldb   $05,y
         asrb  
         lbcs  L4FB0
         ldd   $01,y
         lbeq  L4FB0
         pshs  a
         ldb   #$01
         stb   $01,y
         leay  <-$1A,y
         leax  <$1B,y
         leau  ,y
         lbsr  L4BB5
         lbsr  L4CB0
         clra  
         clrb  
         std   <$14,y
         std   <$16,y
         sta   <$18,y
         leax  >L4C68,pcr
         stx   <$19,y
         lbsr  L48F2
         leax  <$14,y
         leau  <$1B,y
         lbsr  L4BB5
         lbsr  L4CCA
         leay  <$1A,y
         ldb   #$02
         stb   ,y
         ldb   $05,y
         orb   #$01
         stb   $05,y
         puls  b
         bsr   L47F3
         puls  x
         lbra  L3F9A
L47EE    neg   <u00B1
         aim   #$17,>$F81D
         bpl   L47F7
         negb  
L47F7    anda  #$01
         pshs  b,a
         leau  >L47EE,pcr
         lbsr  L3F7C
         ldb   $05,y
         lda   $01,s
         cmpa  #$01
         beq   L4845
         mul   
         stb   $05,y
         ldb   $04,y
         sta   $04,y
         lda   $01,s
         mul   
         addb  $04,y
         adca  #$00
         stb   $04,y
         ldb   $03,y
         sta   $03,y
         lda   $01,s
         mul   
         addb  $03,y
         adca  #$00
         stb   $03,y
         ldb   $02,y
         sta   $02,y
         lda   $01,s
         mul   
         addb  $02,y
         adca  #$00
         beq   L4841
L4834    inc   $01,y
         lsra  
         rorb  
         ror   $03,y
         ror   $04,y
         ror   $05,y
         tsta  
         bne   L4834
L4841    stb   $02,y
         ldb   $05,y
L4845    andb  #$FE
         orb   ,s
         stb   $05,y
         puls  pc,b,a
L484D    pshs  x
         ldb   $01,y
         beq   L4869
         cmpb  #$07
         ble   L4860
         ldb   $05,y
         rorb  
         rorb  
         eorb  #$80
         lbra  L4905
L4860    cmpb  #$E4
         lble  L432B
         tstb  
         bpl   L4873
L4869    clr   ,-s
         ldb   $05,y
         andb  #$01
         beq   L48B6
         bra   L48A4
L4873    lda   #$71
         mul   
         adda  $01,y
         ldb   $05,y
         andb  #$01
         pshs  b,a
         eorb  $05,y
         stb   $05,y
         ldb   ,s
L4884    lbsr  L47F3
         lbsr  L3F94
         ldb   $01,y
         ble   L4896
         addb  ,s
         stb   ,s
         ldb   $01,y
         bra   L4884
L4896    puls  b,a
         pshs  a
         tstb  
         beq   L48B6
         nega  
         sta   ,s
         orb   $05,y
         stb   $05,y
L48A4    leau  >L47EE,pcr
         lbsr  L3F7C
         lbsr  L3F9A
         dec   ,s
         ldb   $05,y
         andb  #$01
         bne   L48A4
L48B6    leay  <-$1A,y
         leax  <$1B,y
         leau  <$14,y
         lbsr  L4BB5
         lbsr  L4CB0
         ldd   #$1000
         std   ,y
         clra  
         std   $02,y
         sta   $04,y
         leax  >L4C4A,pcr
         stx   <$19,y
         bsr   L48F2
         leax  ,y
         leau  <$1B,y
         lbsr  L4BB5
         lbsr  L4CCA
         leay  <$1A,y
         puls  b
         addb  $01,y
         bvs   L4905
         lda   #$02
         std   ,y
         puls  pc,x
L48F2    lda   #$01
         sta   <u009A
         leax  >L4D58,pcr
         stx   <u0095
         leax  >$005F,x
         stx   <u0097
         lbra  L4B80
L4905    leay  -$06,y
         lbpl  L40C6
         ldb   #$32
         lbra  L3C15
         pshs  x
         bsr   L4946
         ldd   $01,y
         lbeq  L4A7A
         cmpd  #$0180
         bgt   L492C
         bne   L492F
         ldd   $03,y
         bne   L492C
         lda   $05,y
         lbeq  L49F7
L492C    lbra  L4FB0
L492F    lbsr  L49B4
         leay  <-$14,y
         leax  <$15,y
         leau  ,y
         lbsr  L4BB5
         lbsr  L4CB0
         leax  <$1B,y
         lbra  L4A27
L4946    ldb   $05,y
         andb  #$01
         stb   <u006D
         eorb  $05,y
         stb   $05,y
         rts   
         leau  <L4994,pcr
         pshs  u,x
         bsr   L4946
         ldd   $01,y
         lbeq  L49F7
         cmpd  #$0180
         bgt   L492C
         bne   L497E
         ldd   $03,y
         bne   L492C
         lda   $05,y
         bne   L492C
         lda   <u006D
         bne   L4977
         clrb  
         std   $01,y
         puls  pc,u,x
L4977    leay  $06,y
         puls  u,x
         lbra  L4AEC
L497E    bsr   L49B4
         leay  <-$14,y
         leax  <$1B,y
         leau  ,y
         lbsr  L4BB5
         lbsr  L4CB0
         leax  <$15,y
         lbra  L4A27
L4994    lda   $05,y
         bita  #$01
         beq   L49AE
         ldu   <u0031
         tst   u0001,u
         beq   L49A8
         leau  <L49AF,pcr
         lbsr  L3F7C
         bra   L49AB
L49A8    lbsr  L4AEC
L49AB    lbra  L3F9A
L49AE    rts   
L49AF    lsl   <u00B4
         neg   <u0000
         neg   <u0096
         tst   -$0C,y
         aim   #$31,<u00A8
         ldu   <L49BF,pcr
         oim   #$ED,<u002C
         lda   #$80
         clrb  
         std   $0E,y
         clra  
         std   <$10,y
         ldd   <$12,y
         std   ,y
         std   $06,y
         ldd   <$14,y
         std   $02,y
         std   $08,y
         ldd   <$16,y
         std   $04,y
         std   $0A,y
         lbsr  L40B5
         lbsr  L3F94
         lbsr  L45DE
         puls  a
         sta   <u006D
         rts   
         pshs  x
         lbsr  L4946
         ldb   $01,y
         cmpb  #$18
         blt   L4A00
L49F7    leay  $06,y
         lbsr  L4AEC
         dec   $01,y
         bra   L4A53
L4A00    leay  <-$1A,y
         ldd   #$1000
         std   ,y
         clra  
         std   $02,y
         sta   $04,y
         ldb   <$1B,y
         bra   L4A1D
L4A12    asr   ,y
         ror   $01,y
         ror   $02,y
         ror   $03,y
         ror   $04,y
         decb  
L4A1D    cmpb  #$02
         bgt   L4A12
         stb   <$1B,y
         leax  <$1B,y
L4A27    leau  $0A,y
         lbsr  L4BB5
         lbsr  L4CB0
         clra  
         clrb  
         std   <$14,y
         std   <$16,y
         sta   <$18,y
         leax  >L4C15,pcr
         stx   <$19,y
         lbsr  L4B72
         leax  <$14,y
         leau  <$1B,y
         lbsr  L4BB5
         lbsr  L4CCA
         leay  <$1A,y
L4A53    lda   $05,y
         ora   <u006D
         sta   $05,y
         ldu   <u0031
         tst   u0001,u
         beq   L4A7A
         leau  >L4AE7,pcr
         lbsr  L3F7C
         lbsr  L40B5
         bra   L4A7A
         pshs  x
         lbsr  L4AF3
         leax  $0A,y
         bsr   L4A80
         lda   $05,y
L4A76    eora  <u009C
L4A78    sta   $05,y
L4A7A    lda   #$02
         sta   ,y
         puls  pc,x
L4A80    leau  <$1B,y
         lbsr  L4BB5
         lbsr  L4CCA
         leay  <$14,y
         leax  >L4D53,pcr
         leau  $01,y
         lbsr  L4BB5
         lbra  L40B5
         pshs  x
         bsr   L4AF3
         leax  ,y
         bsr   L4A80
         lda   $05,y
         eora  <u009B
         bra   L4A78
         pshs  x
         bsr   L4AF3
         leax  $0A,y
         leau  <$1B,y
         lbsr  L4BB5
         lbsr  L4CCA
         leax  ,y
         leay  <$14,y
         leau  $01,y
         lbsr  L4BB5
         lbsr  L4CCA
         ldd   $01,y
         bne   L4AD4
         leay  $06,y
         ldd   #$7FFF
L4ACB    std   $01,y
         lda   #$FF
         std   $03,y
         deca  
         bra   L4AD9
L4AD4    lbsr  L4216
         lda   $05,y
L4AD9    eora  <u009B
         bra   L4A76
         aim   #$C9,<u000F
         orb   <u00A2
L4AE2    addb  >$8EFA
         puls  x,a
L4AE7    ror   <u00E5
         bgt   L4ACB
         andb  <u0033
         bsr   L4AEE
         std   -$0A,x
         andb  >$89DE
         leay  $0D,s
         fcb   $41 A
         beq   L4B03
         leau  >L4AE2,pcr
         lbsr  L3F7C
         lbsr  L40B5
L4B03    clr   <u009B
         ldb   $05,y
         andb  #$01
         stb   <u009C
         eorb  $05,y
         stb   $05,y
         bsr   L4AEC
         inc   $01,y
         lbsr  L4432
         blt   L4B1F
         lbsr  L4693
         bsr   L4AEC
         bra   L4B21
L4B1F    dec   $01,y
L4B21    lbsr  L4432
         blt   L4B33
         inc   <u009B
         lda   <u009C
         eora  #$01
         sta   <u009C
         lbsr  L3F94
         bsr   L4AEC
L4B33    dec   $01,y
         lbsr  L4432
         ble   L4B4D
         lda   <u009B
         eora  #$01
         sta   <u009B
         inc   $01,y
         lda   $0B,y
         ora   #$01
         sta   $0B,y
         lbsr  L3F9A
         leay  -$06,y
L4B4D    leay  <-$14,y
         leax  >L4C1C,pcr
         stx   <$19,y
         leax  <$1B,y
         leau  <$14,y
         bsr   L4BB5
         lbsr  L4CB0
         ldd   #$1000
         std   ,y
         clra  
         std   $02,y
         sta   $04,y
         std   $0A,y
         std   $0C,y
         sta   $0E,y
L4B72    leax  >L4D12,pcr
         stx   <u0095
         leax  >$0041,x
         stx   <u0097
         clr   <u009A
L4B80    ldb   #$25
         stb   <u0099
         clr   <u009D
L4B86    leau  <$1B,y
         ldx   <u0095
         cmpx  <u0097
         bcc   L4B97
         bsr   L4BB5
         leax  $05,x
         stx   <u0095
         bra   L4B9B
L4B97    ldb   #$01
         bsr   L4C07
L4B9B    leax  ,y
         leau  $05,y
         bsr   L4BC7
         tst   <u009A
         bne   L4BAB
         leax  $0A,y
         leau  $0F,y
         bsr   L4BC7
L4BAB    jsr   [<$19,y]
         inc   <u009D
         dec   <u0099
         bne   L4B86
         rts   
L4BB5    pshs  y,x
         lda   ,x
         ldy   $01,x
         ldx   $03,x
         sta   ,u
         sty   u0001,u
         stx   u0003,u
         puls  pc,y,x
L4BC7    ldb   ,x
         sex   
         ldb   <u009D
         lsrb  
         lsrb  
         lsrb  
         bcc   L4BD2
         incb  
L4BD2    pshs  b
         beq   L4BDB
L4BD6    sta   ,u+
         decb  
         bne   L4BD6
L4BDB    ldb   #$05
         subb  ,s+
         beq   L4BE8
L4BE1    lda   ,x+
         sta   ,u+
         decb  
         bne   L4BE1
L4BE8    leau  -u0005,u
         ldb   <u009D
         andb  #$07
         beq   L4C14
         cmpb  #$04
         bcs   L4C07
         subb  #$08
         lda   ,x
L4BF8    lsla  
         rol   u0004,u
         rol   u0003,u
         rol   u0002,u
         rol   u0001,u
         rol   ,u
         incb  
         bne   L4BF8
         rts   
L4C07    asr   ,u
         ror   u0001,u
         ror   u0002,u
         ror   u0003,u
         ror   u0004,u
         decb  
         bne   L4C07
L4C14    rts   
L4C15    lda   $0A,y
         eora  ,y
         coma  
         bra   L4C1F
L4C1C    lda   <$14,y
L4C1F    tsta  
         bpl   L4C36
         leax  ,y
         leau  $0F,y
         bsr   L4C78
         leax  $0A,y
         leau  $05,y
         bsr   L4C94
         leax  <$14,y
         leau  <$1B,y
         bra   L4C78
L4C36    leax  ,y
         leau  $0F,y
         bsr   L4C94
         leax  $0A,y
         leau  $05,y
         bsr   L4C78
         leax  <$14,y
         leau  <$1B,y
         bra   L4C94
L4C4A    leax  <$14,y
         leau  <$1B,y
         bsr   L4C94
         bmi   L4C78
         bne   L4C62
         ldd   $01,x
         bne   L4C62
         ldd   $03,x
         bne   L4C62
         ldb   #$01
         stb   <u0099
L4C62    leax  ,y
         leau  $05,y
         bra   L4C78
L4C68    leax  ,y
         leau  $05,y
         bsr   L4C78
         cmpa  #$20
         bcc   L4C94
         leax  <$14,y
         leau  <$1B,y
L4C78    ldd   $03,x
         addd  u0003,u
         std   $03,x
         ldd   $01,x
         bcc   L4C89
         addd  #$0001
         bcc   L4C89
         inc   ,x
L4C89    addd  u0001,u
         std   $01,x
         lda   ,x
         adca  ,u
         sta   ,x
         rts   
L4C94    ldd   $03,x
         subd  u0003,u
         std   $03,x
         ldd   $01,x
         bcc   L4CA5
         subd  #$0001
         bcc   L4CA5
         dec   ,x
L4CA5    subd  u0001,u
         std   $01,x
         lda   ,x
         sbca  ,u
         sta   ,x
         rts   
L4CB0    ldb   ,u
         clr   ,u
         addb  #$04
         bge   L4CC7
         negb  
         lbra  L4C07
L4CBC    lsl   u0004,u
         rol   u0003,u
         rol   u0002,u
         rol   u0001,u
         rol   ,u
         decb  
L4CC7    bne   L4CBC
         rts   
L4CCA    lda   ,u
         bpl   L4CD7
         clra  
         clrb  
         std   ,u
         std   u0002,u
         sta   u0004,u
         rts   
L4CD7    ldd   #$2004
L4CDA    decb  
         lsl   u0004,u
         rol   u0003,u
         rol   u0002,u
         rol   u0001,u
         rol   ,u
         bmi   L4CEE
         deca  
         bne   L4CDA
         clrb  
         std   ,u
         rts   
L4CEE    lda   ,u
         stb   ,u
         ldb   u0001,u
         sta   u0001,u
         lda   u0002,u
         stb   u0002,u
         ldb   u0003,u
         addd  #$0001
         andb  #$FE
         std   u0003,u
         bcc   L4D11
         inc   u0002,u
         bne   L4D11
         inc   u0001,u
         bne   L4D11
         ror   u0001,u
         inc   ,u
L4D11    rts   
L4D12    inc   <u0090
         std   >$AA22
         asr   <u006B
         daa   
         cmpb  #$58
         com   <u00EB
         jmp   [>$2601]
         std   >$5BA9
         adda  $00,x
         stu   >$AADD
         adca  >$007F
         bitb  >$56EF
         neg   <u003F
         ldu   >$AAB7
         neg   <u001F
         stu   >$D556
         neg   <u000F
         stu   >$FAAB
         neg   <u0007
         stu   >$FF55
         neg   <u0003
         stu   >$FFEB
         neg   <u0001
         stu   >$FFFD
         neg   <u0001
         neg   <u0000
         neg   <u0000
         adda  <u0074
         std   <$0B,y
         lbsr  L6EDB
         jmp   >$067C
         eorb  #$FB
         leax  $03,x
         cmpa  <u00FE
         eorb  >$F301
         sbcb  -$10,s
         ror   >$E300
         eorb  >$5186
         oim   #$00,<u007E
         dec   <u006C
         abx   
         neg   <u003F
         cmpa  #$51
         aim   #$00,-$01,x
         subb  $0A,y
         tim   #$00,$0F,x
         eorb  >$0551
         neg   <u0007
         ldu   >$00AA
         neg   <u0003
         stu   >$8015
         neg   <u0001
         stu   >$E003
         neg   <u0000
         stu   >$F800
         neg   <u0000
         clr   >$FE00
         neg   <u0000
         swi   
         fcb   $FF 
         suba  #$00
         neg   <u001F
         stu   >$E000
         neg   <u000F
         stu   >$F800
         neg   <u0007
         stu   >$FE00
         neg   <u0004
         neg   <u0000
L4DB7    jmp   <u0012
         sexw  
         sbca  [d,y]
         nega  
         ldb   $0D,y
         pshu  x,dp,cc
         aim   #u00E9,$0F,u
         clrb  
         std   <u004C
         std   <u004E
         pshs  a
         lda   $02,y
         beq   L4DE5
         ldb   $05,y
         bitb  #$01
         bne   L4DD9
         com   ,s
         bra   L4DE5
L4DD9    addb  #$FE
         addb  $01,y
         lda   $04,y
         std   <u0052
         ldd   $02,y
         std   <u0050
L4DE5    lda   <u0053
         ldb   <u0057
         mul   
         std   <u004E
         lda   <u0052
         ldb   <u0057
         mul   
         addd  <u004D
         bcc   L4DF7
         inc   <u004C
L4DF7    std   <u004D
         lda   <u0053
         ldb   <u0056
         mul   
         addd  <u004D
         bcc   L4E04
         inc   <u004C
L4E04    std   <u004D
         lda   <u0051
         ldb   <u0057
         mul   
         addd  <u004C
         std   <u004C
         lda   <u0052
         ldb   <u0056
         mul   
         addd  <u004C
         std   <u004C
         lda   <u0053
         ldb   <u0055
         mul   
         addd  <u004C
         std   <u004C
         lda   <u0050
         ldb   <u0057
         mul   
         addb  <u004C
         stb   <u004C
         lda   <u0051
         ldb   <u0056
         mul   
         addb  <u004C
         stb   <u004C
         lda   <u0052
         ldb   <u0055
         mul   
         addb  <u004C
         stb   <u004C
         lda   <u0053
         ldb   <u0054
         mul   
         addb  <u004C
         stb   <u004C
         ldd   <u004E
         addd  <u005A
         std   <u0052
         ldd   <u004C
         adcb  <u0059
         adca  <u0058
         std   <u0050
         tst   ,s+
         bne   L4E81
         ldd   <u0050
         std   $02,y
         ldd   <u0052
         std   $04,y
         clr   $01,y
L4E61    lda   #$1F
         pshs  a
         ldd   $02,y
         bmi   L4E77
L4E69    dec   ,s
         beq   L4E77
         dec   $01,y
         lsl   $05,y
         rol   $04,y
         rolb  
         rola  
         bpl   L4E69
L4E77    std   $02,y
         ldb   $05,y
         andb  #$FE
         stb   $05,y
         puls  pc,b
L4E81    ldd   <u0052
         andb  #$FE
         std   ,--y
         ldd   <u0050
         std   ,--y
         clra  
         clrb  
         std   ,--y
         bsr   L4E61
         lbra  L40B5
         ldd   <u0048
         ldu   $01,y
         subd  $01,y
         subd  #$0001
         stu   <u0048
L4E9F    std   $01,y
         lda   #$01
         sta   ,y
         rts   
         ldd   $01,y
         std   <u0048
         ldb   [<$01,y]
         clra  
         bra   L4E9F
         ldd   $01,y
         tsta  
         lbne  L4FB0
         ldu   <u0048
         stu   $01,y
         stb   ,u+
         lbsr  L4FD3
         sty   <u0044
         cmpu  <u0044
         lbcc  L44AB
         rts   
L4ECB    ldd   $01,y
         ble   L4EDD
         addd  $07,y
         tfr   d,u
         cmpd  <u0048
         bcc   L4EDA
         bsr   L4F59
L4EDA    leay  $06,y
         rts   
L4EDD    leay  $06,y
         ldu   $01,y
         bra   L4F59
         ldd   $01,y
         ble   L4EDD
         pshs  x
         ldd   <u0048
         subd  $01,y
         subd  #$0001
         cmpd  $07,y
         bls   L4F03
         tfr   d,x
         ldu   $07,y
L4EF9    lda   ,x+
         sta   ,u+
         cmpa  #$FF
         bne   L4EF9
         stu   <u0048
L4F03    leay  $06,y
         puls  pc,x
         ldd   $01,y
         ble   L4F0F
         ldd   $07,y
         bgt   L4F17
L4F0F    ldd   $01,y
         leay  $06,y
         std   $01,y
         bra   L4ECB
L4F17    subd  #$0001
         beq   L4F0F
         addd  $0D,y
         cmpd  <u0048
         bcs   L4F27
         leay  $06,y
         bra   L4EDD
L4F27    pshs  x
         tfr   d,x
         ldb   $02,y
         ldu   $0D,y
L4F2F    lda   ,x+
         sta   ,u+
         cmpa  #$FF
         beq   L4F42
         decb  
         bne   L4F2F
         dec   $01,y
         bpl   L4F2F
         lda   #$FF
         sta   ,u+
L4F42    stu   <u0048
         leay  $0C,y
         puls  pc,x
         ldu   <u0048
         leau  -u0001,u
L4F4C    cmpu  $01,y
         beq   L4F59
         lda   ,-u
         cmpa  #$20
         beq   L4F4C
         leau  u0001,u
L4F59    lda   #$FF
         sta   ,u+
         stu   <u0048
         rts   
         pshs  y,x
         ldd   <u0048
         subd  $01,y
         addd  $07,y
         addd  #$0001
         ldx   $07,y
         ldy   $01,y
         lbsr  L3C12
         bcc   L4F79
         clra  
         clrb  
         bra   L4F82
L4F79    tfr   y,d
         ldx   $02,s
         subd  $01,x
         addd  #$0001
L4F82    puls  y,x
         std   $07,y
         lda   #$01
         sta   $06,y
         leay  $06,y
         rts   
         ldb   #$02
         bra   L4F93
         ldb   #$03
L4F93    lda   <u007D
         ldu   <u0082
         pshs  u,x,a
         lbsr  L3C18
         bcs   L4FB0
         ldx   <u0082
         lda   #$FF
         sta   ,x
         ldx   $03,s
         lbsr  L4480
         puls  u,x,a
         sta   <u007D
         stu   <u0082
         rts   
L4FB0    ldb   #$43
         lbra  L3C15
         pshs  x
         ldd   $01,y
         blt   L4FB0
         sty   <u0044
         ldu   <u0048
         stu   $01,y
         lda   #$20
L4FC4    cmpb  <u007D
         bls   L4FD5
         sta   ,u+
         decb  
         cmpu  <u0044
         bcs   L4FC4
         lbra  L44AB
L4FD3    pshs  x
L4FD5    lda   #$FF
         sta   ,u+
         stu   <u0048
         lda   #$04
         sta   ,y
         puls  pc,x
         pshs  x
         leay  -$06,y
         leax  -$06,y
         ldu   <u0048
         stu   $01,y
         os9   F$Time   
         bcs   L4FD5
         bsr   L500A
         lda   #$2F
         bsr   L5008
         lda   #$2F
         bsr   L5008
         lda   #$20
         bsr   L5008
         lda   #$3A
         bsr   L5008
         lda   #$3A
         bsr   L5008
         bra   L4FD5
L5008    sta   ,u+
L500A    lda   ,x+
         ldb   #$2F
L500E    incb  
         suba  #$0A
         bcc   L500E
         stb   ,u+
         ldb   #$3A
L5017    decb  
         inca  
         bne   L5017
         stb   ,u+
         rts   
         lda   $02,y
         ldb   #$06
         os9   I$GetStt 
         bcc   L502F
         cmpb  #$D3
         bne   L502F
         ldb   #$FF
         bra   L5031
L502F    ldb   #$00
L5031    clra  
         std   $01,y
         lda   #$03
         sta   ,y
         rts   
         ldb   #$06
         pshs  y,x,b
         tfr   dp,a
         ldb   #$50
         tfr   d,y
         leax  >L4DB7,pcr
L5047    ldd   ,x++
         std   ,y++
         dec   ,s
         bne   L5047
         leax  >L3C9E,pcr
         stx   <u0010
         leax  >L3D1E,pcr
         stx   <u0012
         lda   #$7E
         sta   <u0016
         leax  >L3D2A,pcr
         stx   <u0017
         leax  >L3C1B,pcr
         stx   <u0019
         puls  pc,y,x,b
         pshs  x,b,a
         ldb   [<$04,s]
         leax  <L507D,pcr
         ldd   b,x
         leax  d,x
         stx   $04,s
         puls  pc,x,b,a
L507D    neg   <u00BA
         neg   <u0010
L5081    jsr   <u0027
         inc   <u009D
         beq   L5095
L5087    jsr   <u0027
         lsl   <u009D
         beq   L5093
         pshs  pc,x,b,a
         lslb  
         leax  <L509B,pcr
L5093    ldd   b,x
L5095    leax  d,x
         stx   $04,s
         puls  pc,x,b,a
L509B    lsr   <u005F
         eim   #$C3,<u0005
         addd  #$04B7
         eim   #$B3,<u0005
         ora   $04,x
         deca  
         aim   #$58,<u0002
         tim   #$02,-$0B,y
         aim   #$A2,<u0002
         clr   >$05F9
         eim   #$E9,<u0004
         lsl   >$0A11
L50BB    eim   #$DA,<u0006
         ora   >$0562
         asr   <u0059
L50C3    ror   <u0002
         beq   L50D7
         com   <u00E8
         neg   <u0064
         neg   <u000A
L50CD    lsr   <u00A0
         neg   <u0000
         neg   <u0007
         eorb  #$00
         neg   <u0000
L50D7    dec   <u00FA
         neg   <u0000
         neg   <u000E
         cmpx  <u0040
         neg   <u0000
         fcb   $11 
         addd  #$5000
         neg   <u0014
         andb  >$2400
         neg   <u0018
         eora  <u0096
         suba  #$00
         fcb   $1B 
         ldx   >$BC20
         neg   <u001E
         ldu   $0B,s
         bvc   L50FA
L50FA    bhi   L5091
         aim   #$F9,<u0000
         bcs   L50BB
         coma  
         sta   >$4028
         eorb  [,u]
         bita  -$10,x
         bge   L509C
         anda  #$E7
         bpl   L513E
         bita  >$E620
         andb  >$32E3
         clrb  
         adca  -$0E,y
         pshu  pc,dp,b,a
         fcb   $1B 
         adcb  #$C0
         rts   
         cmpa  >$A2BC
         bgt   L515F
         ldu   <u000B
         tim   #u003A,$00,u
         ora   #$C7
         bls   L5130
L512C    lsrb  
         aim   #$75,>$65FF
L5131    rora  
         oim   #$6C,-$0D,s
         eim   #$FF,-$0C,y
         nega  
         leay  -$06,y
         clra  
         clrb  
         sta   <u0075
         sta   <u0076
         sta   <u0077
         sta   <u0078
         sta   <u0079
         std   $04,y
         std   $02,y
         sta   $01,y
         lbsr  L5379
         bcc   L515B
         leax  -$01,x
         cmpa  #$2C
         bne   L51C7
         lbra  L51E4
L515B    cmpa  #$24
         lbeq  L529B
         cmpa  #$2B
         beq   L516B
         cmpa  #$2D
         bne   L516D
         inc   <u0078
L516B    lda   ,x+
L516D    cmpa  #$2E
         bne   L5179
         tst   <u0077
         bne   L51C7
         inc   <u0077
         bra   L516B
L5179    lbsr  L57C7
         bcs   L51CE
         pshs  a
         inc   <u0076
         ldd   $04,y
         ldu   $02,y
         bsr   L51B4
         std   $04,y
         stu   $02,y
         bsr   L51B4
         bsr   L51B4
         addd  $04,y
         exg   d,u
         adcb  $03,y
         adca  $02,y
         bcs   L51C1
         exg   d,u
         addb  ,s+
         adca  #$00
         bcc   L51A8
         leau  u0001,u
         stu   $02,y
         beq   L51C3
L51A8    std   $04,y
         stu   $02,y
         tst   <u0077
         beq   L516B
         inc   <u0079
         bra   L516B
L51B4    lslb  
         rola  
         exg   d,u
         rolb  
         rola  
         exg   d,u
         bcs   L51BF
         rts   
L51BF    leas  $02,s
L51C1    leas  $01,s
L51C3    ldb   #$3C
         bra   L51C9
L51C7    ldb   #$3B
L51C9    stb   <u0036
         coma  
         puls  pc,u
L51CE    eora  #$45
         anda  #$DF
         beq   L51F7
         leax  -$01,x
         tst   <u0076
         bne   L51DC
         bra   L51C7
L51DC    tst   <u0077
         bne   L5225
         ldd   $02,y
         bne   L5225
L51E4    ldd   $04,y
         bmi   L5225
         tst   <u0078
         beq   L51F0
         nega  
         negb  
         sbca  #$00
L51F0    std   $01,y
L51F2    lda   #$01
         lbra  L527E
L51F7    lda   ,x
         cmpa  #$2B
         beq   L5203
         cmpa  #$2D
         bne   L5205
         inc   <u0075
L5203    leax  $01,x
L5205    lbsr  L57C5
         bcs   L51C7
         tfr   a,b
         lbsr  L57C5
         bcc   L5215
         leax  -$01,x
         bra   L521C
L5215    pshs  a
         lda   #$0A
         mul   
         addb  ,s+
L521C    tst   <u0075
         bne   L5221
         negb  
L5221    addb  <u0079
         stb   <u0079
L5225    ldb   #$20
         stb   $01,y
         ldd   $02,y
         bne   L5236
         cmpd  $04,y
         bne   L5236
         clr   $01,y
         bra   L527C
L5236    tsta  
         bmi   L5243
L5239    dec   $01,y
         lsl   $05,y
         rol   $04,y
         rolb  
         rola  
         bpl   L5239
L5243    std   $02,y
         clr   <u0075
         ldb   <u0079
         beq   L5274
         bpl   L5250
         negb  
         inc   <u0075
L5250    cmpb  #$13
         bls   L5264
         subb  #$13
         pshs  b
         leau  >L5127,pcr
         bsr   L5284
         puls  b
         lbcs  L51C3
L5264    decb  
         lda   #$05
         mul   
         leau  >L50CD,pcr
         leau  b,u
         bsr   L5284
         lbcs  L51C3
L5274    lda   $05,y
         anda  #$FE
         ora   <u0078
         sta   $05,y
L527C    lda   #$02
L527E    sta   ,y
         andcc #$FE
         puls  pc,u
L5284    leay  -$06,y
         ldd   ,u
         std   $01,y
         ldd   u0002,u
         std   $03,y
         ldb   u0004,u
         stb   $05,y
         lda   <u0075
         lbeq  L5087
         lbra  L508A
L529B    lbsr  L57C5
         bcc   L52B0
         cmpa  #$61
         bcs   L52A6
         suba  #$20
L52A6    cmpa  #$41
         bcs   L52C5
         cmpa  #$46
         bhi   L52C5
         suba  #$37
L52B0    inc   <u0076
         ldb   #$04
L52B4    lsl   $02,y
         rol   $01,y
         lbcs  L51C3
         decb  
         bne   L52B4
         adda  $02,y
         sta   $02,y
         bra   L529B
L52C5    leax  -$01,x
         tst   <u0076
         lbeq  L51C7
         lbra  L51F2
         pshs  x
         ldx   <u0082
         lbsr  L5137
         bcc   L52DB
L52D9    puls  pc,x
L52DB    cmpa  #$02
         beq   L52E2
         lbsr  L5084
L52E2    lbsr  L536D
         bcs   L52EE
         ldb   #$3D
         stb   <u0036
         coma  
         puls  pc,x
L52EE    stx   <u0082
         clra  
         puls  pc,x
         pshs  x
         ldx   <u0082
         lbsr  L5137
         bcs   L52D9
         cmpa  #$01
         bne   L5313
         tst   $01,y
         beq   L52E2
         bra   L5313
         pshs  x
         ldx   <u0082
         lbsr  L5137
         bcs   L52D9
         cmpa  #$01
         beq   L52E2
L5313    ldb   #$3A
         stb   <u0036
         coma  
         puls  pc,x
         pshs  u,x
         leay  -$06,y
         ldu   <u004A
         stu   $01,y
         lda   #$04
         sta   ,y
         ldx   <u0082
L5328    lda   ,x+
         bsr   L537F
         bcs   L5332
         sta   ,u+
         bra   L5328
L5332    stx   <u0082
         lda   #$FF
         sta   ,u+
         stu   <u0048
         clra  
         puls  pc,u,x
         pshs  x
         leay  -$06,y
         lda   #$03
         sta   ,y
         clr   $02,y
         ldx   <u0082
         bsr   L5379
         bcs   L5368
         cmpa  #$54
         beq   L5362
         cmpa  #$74
         beq   L5362
         eora  #$46
         anda  #$DF
         beq   L5364
         ldb   #$3A
         stb   <u0036
         coma  
         puls  pc,x
L5362    com   $02,y
L5364    bsr   L536D
         bcc   L5364
L5368    stx   <u0082
         clra  
         puls  pc,x
L536D    lda   ,x+
         cmpa  #$20
         bne   L537F
         bsr   L5379
         bcc   L538E
         bra   L5390
L5379    lda   ,x+
         cmpa  #$20
         beq   L5379
L537F    cmpa  <u00DD
         beq   L5390
         cmpa  #$0D
         beq   L538E
         cmpa  #$FF
         beq   L538E
         andcc #$FE
         rts   
L538E    leax  -$01,x
L5390    orcc  #$01
         rts   
L5393    pshs  u,x
         clra  
         sta   $03,y
         sta   <u0076
         sta   <u0078
         lda   #$04
         sta   <u007E
         ldd   $01,y
         bpl   L53AA
         nega  
         negb  
         sbca  #$00
         inc   <u0078
L53AA    leau  >L50C3,pcr
L53AE    clr   <u007A
         leau  u0002,u
L53B2    subd  ,u
         bcs   L53BA
         inc   <u007A
         bra   L53B2
L53BA    addd  ,u
         tst   <u007A
         bne   L53C4
         tst   $03,y
         beq   L53CF
L53C4    inc   $03,y
         pshs  a
         lda   <u007A
         lbsr  L54D3
         puls  a
L53CF    dec   <u007E
         bne   L53AE
         tfr   b,a
         lbsr  L54D3
         leay  $06,y
         puls  pc,u,x
L53DC    pshs  u,x
         clr   <u0075
         clr   <u0078
         clr   <u007C
         clr   <u007B
         clr   <u0079
         clr   <u0076
         leau  ,x
         ldd   #$0A30
L53EF    stb   ,u+
         deca  
         bne   L53EF
         ldd   $01,y
         bne   L53FC
         inca  
         lbra  L54CD
L53FC    ldb   $05,y
         bitb  #$01
         beq   L5408
         stb   <u0078
         andb  #$FE
         stb   $05,y
L5408    ldd   $01,y
         bpl   L540F
         inc   <u0075
         nega  
L540F    cmpa  #$03
         bls   L5440
         ldb   #$9A
         mul   
         lsra  
         nop   
         nop   
         tfr   a,b
         tst   <u0075
         beq   L5420
         negb  
L5420    stb   <u0079
         cmpa  #$13
         bls   L5433
         pshs  a
         leau  >L5127,pcr
         lbsr  L5284
         puls  a
         suba  #$13
L5433    leau  >L50CD,pcr
         deca  
         ldb   #$05
         mul   
         leau  d,u
         lbsr  L5284
L5440    ldd   $02,y
         tst   $01,y
         beq   L546C
         bpl   L5458
L5448    lsra  
         rorb  
         ror   $04,y
         ror   $05,y
         ror   <u007C
         inc   $01,y
         bne   L5448
         std   $02,y
         bra   L546C
L5458    lsl   $05,y
         rol   $04,y
         rolb  
         rola  
         rol   <u007B
         dec   $01,y
         bne   L5458
         std   $02,y
         inc   <u0079
         lda   <u007B
         bsr   L54D3
L546C    ldd   $02,y
         ldu   $04,y
L5470    clr   <u007B
         bsr   L54DA
         std   $02,y
         stu   $04,y
         pshs  a
         lda   <u007B
         sta   <u007C
         puls  a
         bsr   L54DA
         bsr   L54DA
         exg   d,u
         addd  $04,y
         exg   d,u
         adcb  $03,y
         adca  $02,y
         pshs  a
         lda   <u007B
         adca  <u007C
         bsr   L54D3
         lda   <u0076
         cmpa  #$09
         puls  a
         beq   L54AA
         cmpd  #$0000
         bne   L5470
         cmpu  #$0000
         bne   L5470
L54AA    sta   ,y
         lda   <u0076
         cmpa  #$09
         bcs   L54CB
         ldb   ,y
         bpl   L54CB
L54B6    lda   ,-x
         inca  
         sta   ,x
         cmpa  #$39
         bls   L54CB
         lda   #$30
         sta   ,x
         cmpx  ,s
         bne   L54B6
         inc   ,x
         inc   <u0079
L54CB    lda   #$09
L54CD    sta   <u0076
         leay  $06,y
         puls  pc,u,x
L54D3    ora   #$30
         sta   ,x+
         inc   <u0076
         rts   
L54DA    exg   d,u
         lslb  
         rola  
         exg   d,u
         rolb  
         rola  
         rol   <u007B
         rts   
         pshs  y,x
         ldx   <u0080
         stx   <u0082
         lda   #$01
         sta   <u007D
         ldy   #$0100
         lda   <u007F
         os9   I$ReadLn 
         bra   L550D
         pshs  y,x
         ldd   <u0082
         subd  <u0080
         beq   L5511
         tfr   d,y
         ldx   <u0080
         stx   <u0082
         lda   <u007F
         os9   I$WritLn 
L550D    bcc   L5511
         stb   <u0036
L5511    puls  pc,y,x
         pshs  u,x
         lda   ,y
         cmpa  #$02
         beq   L551F
         ldu   $01,y
         bra   L5526
L551F    lda   $01,y
         bgt   L552B
         ldu   #$0000
L5526    ldx   #$0000
         bra   L5547
L552B    ldx   $02,y
         ldu   $04,y
         suba  #$20
         bcs   L5538
         ldb   #$4E
         coma  
         bra   L554E
L5538    exg   x,d
         lsra  
         rorb  
         exg   d,u
         rora  
         rorb  
         exg   d,x
         exg   x,u
         inca  
         bne   L5538
L5547    lda   <u007F
         os9   I$Seek   
         bcc   L5550
L554E    stb   <u0036
L5550    puls  pc,u,x
         pshs  u,x
         leas  -$0A,s
         leax  ,s
         lbsr  L53DC
         pshs  x
         lda   #$09
         leax  $09,x
L5561    ldb   ,-x
         cmpb  #$30
         bne   L556C
         deca  
         cmpa  #$01
         bne   L5561
L556C    sta   <u0076
         puls  x
         ldb   <u0079
         bgt   L5595
         negb  
         tfr   b,a
         cmpb  #$09
         bhi   L55AF
         addb  <u0076
         cmpb  #$09
         bhi   L55AF
         pshs  a
         lbsr  L562C
         clra  
         bsr   L55FB
         puls  b
         tstb  
         beq   L5591
         lbsr  L561D
L5591    lda   <u0076
         bra   L55A8
L5595    cmpb  #$09
         bhi   L55AF
         lbsr  L562C
         tfr   b,a
         bsr   L55EA
         bsr   L55FB
         lda   <u0076
         suba  <u0079
         bls   L55AA
L55A8    bsr   L55EA
L55AA    leas  $0A,s
         clra  
         puls  pc,u,x
L55AF    bsr   L562C
         lda   #$01
         bsr   L55EA
         bsr   L55FB
         lda   <u0076
         deca  
         bne   L55BD
         inca  
L55BD    bsr   L55EA
         bsr   L55C3
         bra   L55AA
L55C3    lda   #$45
         bsr   L55FD
         lda   <u0079
         deca  
         pshs  a
         bpl   L55D4
         neg   ,s
         bsr   L5630
         bra   L55D6
L55D4    bsr   L5634
L55D6    puls  b
         clra  
L55D9    subb  #$0A
         bcs   L55E0
         inca  
         bra   L55D9
L55E0    addb  #$0A
         bsr   L55E6
         tfr   b,a
L55E6    adda  #$30
         bra   L55FD
L55EA    tfr   a,b
         tstb  
         beq   L55F6
L55EF    lda   ,x+
         bsr   L55FD
         decb  
         bne   L55EF
L55F6    rts   
L55F7    lda   #$20
         bra   L55FD
L55FB    lda   #$2E
L55FD    pshs  u,a
         leau  <-$40,s
         cmpu  <u0082
         bhi   L5613
         cmpa  #$0D
         beq   L5613
         lda   #$50
         sta   <u0036
         sta   <u00DE
         bra   L561B
L5613    ldu   <u0082
         sta   ,u+
         stu   <u0082
         inc   <u007D
L561B    puls  pc,u,a
L561D    lda   #$30
L561F    tstb  
         beq   L5627
L5622    bsr   L55FD
         decb  
         bne   L5622
L5627    rts   
L5628    tst   <u0078
         beq   L55F7
L562C    tst   <u0078
         beq   L5627
L5630    lda   #$2D
         bra   L55FD
L5634    lda   #$2B
         bra   L55FD
L5638    lda   #$20
         bra   L561F
L563C    bsr   L55FD
L563E    lda   ,x+
         cmpa  #$FF
         bne   L563C
         rts   
         pshs  x
         ldx   $01,y
L5649    bsr   L563E
         clra  
         puls  pc,x
         pshs  x
         leax  >L512C,pcr
         lda   $02,y
         bne   L5649
         leax  >L5131,pcr
         bra   L5649
         pshs  u,x
         leas  -$05,s
         leax  ,s
         lbsr  L5393
         bsr   L562C
         lda   <u0076
         leax  ,s
         lbsr  L55EA
         leas  $05,s
         clra  
         puls  pc,u,x
         tfr   a,b
L5677    pshs  u
         ldu   <u0082
         subb  <u007D
         bls   L5681
         bsr   L5638
L5681    clra  
         puls  pc,u
         lbsr  L55F7
L5687    lda   <u007D
         anda  #$0F
         cmpa  #$01
         beq   L569B
         lbsr  L55F7
         bra   L5687
         lda   #$0D
         clr   <u007D
         lbsr  L55FD
L569B    clra  
         rts   
         pshs  u
         lda   #$04
         leau  ,y
         tst   ,u
         bne   L56AA
         asra  
         leau  u0001,u
L56AA    sta   <u0086
         tfr   a,b
         asrb  
         lbsr  L5846
         puls  pc,u
L56B4    clrb  
         stb   <u0087
         cmpa  #$3C
         beq   L56C7
         cmpa  #$3E
         bne   L56C2
         incb  
         bra   L56C7
L56C2    cmpa  #$5E
         bne   L56CB
         decb  
L56C7    stb   <u0087
         lda   ,x+
L56CB    cmpa  #$2C
         beq   L5707
         cmpa  #$FF
         bne   L56E5
         lda   <u0094
         beq   L56DB
         leax  -$01,x
         bra   L56F0
L56DB    ldx   <u008E
         tst   <u00DC
         beq   L56E9
         clr   <u00DC
         bra   L5707
L56E5    cmpa  #$29
         beq   L56EC
L56E9    orcc  #$01
         rts   
L56EC    lda   <u0094
         beq   L56E9
L56F0    dec   <u0092
         bne   L5705
         ldu   <u0046
         pulu  y,a
         sta   <u0092
         sty   <u0090
         stu   <u0046
         lda   ,x+
         dec   <u0094
         bra   L56CB
L5705    ldx   <u0090
L5707    stx   <u008C
         andcc #$FE
         rts   
L570C    rola  
         neg   <u00DF
         lsla  
         neg   <u00DC
         fcb   $52 R
         neg   <u00CF
         fcb   $45 E
         neg   <u00CC
         comb  
         neg   <u00D3
         fcb   $42 B
         neg   <u00D0
         lsrb  
         neg   <u000A
         lslb  
         neg   <u0012
         beq   L5726
L5726    orcc  #$00
         bsr   L56CB
         bcs   L5790
         ldb   <u0086
         lbsr  L5677
         bra   L575B
         bsr   L56CB
         bcs   L5790
         ldb   <u0086
         lbsr  L5638
         bra   L575B
L573E    cmpa  #$FF
         beq   L5790
         cmpa  #$27
         bne   L574E
         lda   ,x+
         bsr   L56CB
         bcs   L5790
         bra   L575B
L574E    lbsr  L55FD
         lda   ,x+
         bra   L573E
         pshs  y,x
         clr   <u00DC
         inc   <u00DC
L575B    ldx   <u008C
         bsr   L57AB
         bcs   L577A
         cmpa  #$28
         bne   L5794
         lda   <u0092
         stb   <u0092
         beq   L5794
         inc   <u0094
         ldu   <u0046
         ldy   <u0090
         pshu  y,a
         stu   <u0046
         stx   <u0090
         lda   ,x+
L577A    leay  >L570C,pcr
         clrb  
L577F    pshs  a
         eora  ,y
         anda  #$DF
         puls  a
         beq   L579B
         leay  $03,y
         incb  
         tst   ,y
         bne   L577F
L5790    ldb   #$3F
         bra   L5796
L5794    ldb   #$3E
L5796    stb   <u0036
         coma  
         puls  pc,y,x
L579B    stb   <u0085
         ldd   $01,y
         leay  d,y
         bsr   L57AB
         bcc   L57A7
         ldb   #$01
L57A7    stb   <u0086
         jmp   ,y
L57AB    bsr   L57C5
         bcs   L57D4
         tfr   a,b
         bsr   L57C5
         bcs   L57D1
         bsr   L57D7
         bsr   L57C5
         bcs   L57D1
         bsr   L57D7
         tsta  
         beq   L57C1
         clrb  
L57C1    lda   ,x+
         bra   L57D1
L57C5    lda   ,x+
L57C7    cmpa  #$30
         bcs   L57D4
         cmpa  #$39
         bhi   L57D4
         suba  #$30
L57D1    andcc #$FE
         rts   
L57D4    orcc  #$01
         rts   
L57D7    pshs  a
         lda   #$0A
         mul   
         addb  ,s+
         adca  #$00
         rts   
         cmpa  #$2E
         bne   L5790
         bsr   L57AB
         bcs   L5790
         stb   <u0089
         lbsr  L56B4
         bcs   L5790
         puls  y,x
         inc   <u00DC
         ldb   <u0085
         lbeq  L589C
         decb  
         beq   L580F
         decb  
         lbeq  L5952
         decb  
         lbeq  L59F9
         decb  
         lbeq  L5907
         lbra  L58ED
L580F    jsr   <u0016
         cmpa  #$04
         bcs   L5825
         ldu   $01,y
         clrb  
L5818    lda   ,u+
         cmpa  #$FF
         beq   L5821
         incb  
         bne   L5818
L5821    ldu   $01,y
         bra   L5846
L5825    leau  $01,y
         lda   ,y
         cmpa  #$02
         bne   L5831
         ldb   #$05
         bra   L5846
L5831    cmpa  #$01
         bne   L583B
         ldb   #$02
         cmpb  <u0086
         bcs   L583F
L583B    ldb   #$01
         leau  u0001,u
L583F    tfr   b,a
         lsla  
         cmpa  <u0086
         bhi   L587C
L5846    tst   <u0087
         beq   L5872
         bmi   L5859
         pshs  b
         lslb  
         pshs  b
         ldb   <u0086
         subb  ,s+
         bcs   L5870
         bra   L5865
L5859    pshs  b
         lslb  
         pshs  b
         ldb   <u0086
         subb  ,s+
         bcs   L5870
         asrb  
L5865    pshs  b
         lda   <u0086
         suba  ,s+
         sta   <u0086
         lbsr  L5638
L5870    puls  b
L5872    lda   ,u
         lsra  
         lsra  
         lsra  
         lsra  
         bsr   L588C
         beq   L588A
L587C    lda   ,u+
         bsr   L588C
         beq   L588A
         decb  
         bne   L5872
         ldb   <u0086
         lbsr  L5638
L588A    clra  
         rts   
L588C    anda  #$0F
         cmpa  #$09
         bls   L5894
         adda  #$07
L5894    lbsr  L55E6
         dec   <u0086
         rts   
L589A    coma  
         rts   
L589C    jsr   <u0016
         cmpa  #$02
         bcs   L58A7
         bne   L589A
         lbsr  L5081
L58A7    pshs  u,x
         leas  -$05,s
         leax  ,s
         lbsr  L5393
         ldb   <u0086
         decb  
         subb  <u0076
         bpl   L58BE
         leas  $05,s
         puls  u,x
         lbra  L59F0
L58BE    tst   <u0087
         beq   L58CC
         bmi   L58DD
         lbsr  L5638
         lbsr  L5628
         bra   L58E3
L58CC    lbsr  L5628
         pshs  b
         lda   <u0076
         lbsr  L55EA
         puls  b
         lbsr  L5638
         bra   L58E8
L58DD    lbsr  L5628
         lbsr  L561D
L58E3    lda   <u0076
         lbsr  L55EA
L58E8    leas  $05,s
         clra  
         puls  pc,u,x
L58ED    jsr   <u0016
         cmpa  #$03
         bne   L589A
         pshs  u,x
         leax  >L512C,pcr
         ldb   #$04
         lda   $02,y
         bne   L591B
         leax  >L5131,pcr
         ldb   #$05
         bra   L591B
L5907    jsr   <u0016
         cmpa  #$04
         bne   L589A
         pshs  u,x
         ldx   $01,y
         ldd   <u0048
         subd  $01,y
         subd  #$0001
         tsta  
         bne   L591F
L591B    cmpb  <u0086
         bls   L5921
L591F    ldb   <u0086
L5921    tfr   b,a
         negb  
         addb  <u0086
         tst   <u0087
         beq   L5938
         bmi   L593C
         pshs  a
         lbsr  L5638
         puls  a
         lbsr  L55EA
         bra   L594F
L5938    pshs  b
         bra   L5947
L593C    lsrb  
         bcc   L5940
         incb  
L5940    pshs  b,a
         lbsr  L5638
         puls  a
L5947    lbsr  L55EA
         puls  b
         lbsr  L5638
L594F    clra  
         puls  pc,u,x
L5952    jsr   <u0016
         cmpa  #$02
         beq   L595F
         lbcc  L589A
         lbsr  L5084
L595F    pshs  u,x
         leas  -$0A,s
         leax  ,s
         lbsr  L53DC
         lda   <u0079
         cmpa  #$09
         bgt   L597F
         lbsr  L5A53
         lda   <u0086
         suba  #$02
         bmi   L597F
         suba  <u0089
         bmi   L597F
         suba  <u008A
         bpl   L5985
L597F    leas  $0A,s
         puls  u,x
         bra   L59F0
L5985    sta   <u0088
         leax  ,s
         ldb   <u0087
         beq   L5995
         bmi   L599B
         bsr   L59D2
         bsr   L59A7
         bra   L59A2
L5995    bsr   L59A7
         bsr   L59D2
         bra   L59A2
L599B    bsr   L59D2
         bsr   L59AA
         lbsr  L5628
L59A2    leas  $0A,s
         clra  
         puls  pc,u,x
L59A7    lbsr  L5628
L59AA    lda   <u008A
         lbsr  L55EA
         lbsr  L55FB
         ldb   <u0079
         bpl   L59E2
         negb  
         cmpb  <u0089
         bls   L59BD
         ldb   <u0089
L59BD    pshs  b
         lbsr  L561D
         ldb   <u0089
         subb  ,s+
         stb   <u0089
         lda   <u008B
         cmpa  <u0089
         bls   L59D0
         lda   <u0089
L59D0    bra   L59E4
L59D2    ldb   <u0088
         lbra  L5638
L59D7    lbsr  L5628
         lda   <u008A
         lbsr  L55EA
         lbsr  L55FB
L59E2    lda   <u008B
L59E4    lbsr  L55EA
         ldb   <u0089
         subb  <u008B
         ble   L59F8
         lbra  L561D
L59F0    ldb   <u0086
         lda   #$2A
         lbsr  L561F
         clra  
L59F8    rts   
L59F9    jsr   <u0016
         cmpa  #$02
         beq   L5A06
         lbcc  L589A
         lbsr  L5084
L5A06    pshs  u,x
         leas  -$0A,s
         leax  ,s
         lbsr  L53DC
         lda   <u0079
         pshs  a
         lda   #$01
         sta   <u0079
         bsr   L5A53
         puls  a
         ldb   <u0079
         cmpb  #$01
         beq   L5A22
         inca  
L5A22    ldb   #$01
         stb   <u008A
         sta   <u0079
         lda   <u0086
         suba  #$06
         bmi   L5A36
         suba  <u0089
         bmi   L5A36
         suba  <u008A
         bpl   L5A3C
L5A36    leas  $0A,s
         puls  u,x
         bra   L59F0
L5A3C    sta   <u0088
         ldb   <u0087
         beq   L5A4B
         bsr   L59D2
         bsr   L59D7
         lbsr  L55C3
         bra   L5A50
L5A4B    bsr   L59D7
         lbsr  L55C3
L5A50    lbra  L59A2
L5A53    pshs  x
         lda   <u0079
         adda  <u0089
         bne   L5A61
         lda   ,x
         cmpa  #$35
         bcc   L5A78
L5A61    deca  
         bmi   L5A94
         cmpa  #$07
         bhi   L5A94
         leax  a,x
         ldb   $01,x
         cmpb  #$35
         bcs   L5A94
L5A70    inc   ,x
         ldb   ,x
         cmpb  #$39
         bls   L5A94
L5A78    ldb   #$30
         stb   ,x
         leax  -$01,x
         cmpx  ,s
         bcc   L5A70
         ldx   ,s
         leax  $08,x
L5A86    lda   ,-x
         sta   $01,x
         cmpx  ,s
         bhi   L5A86
         lda   #$31
         sta   ,x
         inc   <u0079
L5A94    puls  x
         lda   <u0079
         bpl   L5A9B
         clra  
L5A9B    sta   <u008A
         nega  
         adda  #$09
         bpl   L5AA3
         clra  
L5AA3    cmpa  <u0089
         bls   L5AA9
         lda   <u0089
L5AA9    sta   <u008B
         rts   
         ldb   #$30
         stb   <u0036
         coma  
         rts   
         emod
eom      equ   *
