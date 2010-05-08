           nam    BBS.upload
           ttl    program module

           ifp1
           use    defsfile
           endc

tylg       set    Prgrm+Objct
atrv       set    ReEnt+rev
rev        set    $01

           mod    eom,name,tylg,atrv,start,size

U0000      rmb    1
U0001      rmb    2
U0003      rmb    13
U0010      rmb    2
U0012      rmb    2
U0014      rmb    2
U0016      rmb    6
U001C      rmb    2
U001E      rmb    2
U0020      rmb    2
U0022      rmb    16
U0032      rmb    27
U004D      rmb    2
U004F      rmb    2
U0051      rmb    1
U0052      rmb    64
U0092      rmb    31
U00B1      rmb    1
U00B2      rmb    8499
size       equ    .

name       fcs    /BBS.upload/                                            * 000D 42 42 53 2E 75 70 6C 6F 61 E4 BBS.upload
           fcb    $43                                                   * 0017 43             C
           fcb    $6F                                                   * 0018 6F             o
           fcb    $70                                                   * 0019 70             p
           fcb    $79                                                   * 001A 79             y
           fcb    $72                                                   * 001B 72             r
           fcb    $69                                                   * 001C 69             i
           fcb    $67                                                   * 001D 67             g
           fcb    $68                                                   * 001E 68             h
           fcb    $74                                                   * 001F 74             t
           fcb    $20                                                   * 0020 20
           fcb    $28                                                   * 0021 28             (
           fcb    $43                                                   * 0022 43             C
           fcb    $29                                                   * 0023 29             )
           fcb    $20                                                   * 0024 20
           fcb    $31                                                   * 0025 31             1
           fcb    $39                                                   * 0026 39             9
           fcb    $38                                                   * 0027 38             8
           fcb    $38                                                   * 0028 38             8
           fcb    $42                                                   * 0029 42             B
           fcb    $79                                                   * 002A 79             y
           fcb    $20                                                   * 002B 20
           fcb    $4B                                                   * 002C 4B             K
           fcb    $65                                                   * 002D 65             e
           fcb    $69                                                   * 002E 69             i
           fcb    $74                                                   * 002F 74             t
           fcb    $68                                                   * 0030 68             h
           fcb    $20                                                   * 0031 20
           fcb    $41                                                   * 0032 41             A
           fcb    $6C                                                   * 0033 6C             l
           fcb    $70                                                   * 0034 70             p
           fcb    $68                                                   * 0035 68             h
           fcb    $6F                                                   * 0036 6F             o
           fcb    $6E                                                   * 0037 6E             n
           fcb    $73                                                   * 0038 73             s
           fcb    $6F                                                   * 0039 6F             o
           fcb    $4C                                                   * 003A 4C             L
           fcb    $69                                                   * 003B 69             i
           fcb    $63                                                   * 003C 63             c
           fcb    $65                                                   * 003D 65             e
           fcb    $6E                                                   * 003E 6E             n
           fcb    $63                                                   * 003F 63             c
           fcb    $65                                                   * 0040 65             e
           fcb    $64                                                   * 0041 64             d
           fcb    $20                                                   * 0042 20
           fcb    $74                                                   * 0043 74             t
           fcb    $6F                                                   * 0044 6F             o
           fcb    $20                                                   * 0045 20
           fcb    $41                                                   * 0046 41             A
           fcb    $6C                                                   * 0047 6C             l
           fcb    $70                                                   * 0048 70             p
           fcb    $68                                                   * 0049 68             h
           fcb    $61                                                   * 004A 61             a
           fcb    $20                                                   * 004B 20
           fcb    $53                                                   * 004C 53             S
           fcb    $6F                                                   * 004D 6F             o
           fcb    $66                                                   * 004E 66             f
           fcb    $74                                                   * 004F 74             t
           fcb    $77                                                   * 0050 77             w
           fcb    $61                                                   * 0051 61             a
           fcb    $72                                                   * 0052 72             r
           fcb    $65                                                   * 0053 65             e
           fcb    $20                                                   * 0054 20
           fcb    $54                                                   * 0055 54             T
           fcb    $65                                                   * 0056 65             e
           fcb    $63                                                   * 0057 63             c
           fcb    $68                                                   * 0058 68             h
           fcb    $6E                                                   * 0059 6E             n
           fcb    $6F                                                   * 005A 6F             o
           fcb    $6C                                                   * 005B 6C             l
           fcb    $6F                                                   * 005C 6F             o
           fcb    $67                                                   * 005D 67             g
           fcb    $69                                                   * 005E 69             i
           fcb    $65                                                   * 005F 65             e
           fcb    $73                                                   * 0060 73             s
           fcb    $41                                                   * 0061 41             A
           fcb    $6C                                                   * 0062 6C             l
           fcb    $6C                                                   * 0063 6C             l
           fcb    $20                                                   * 0064 20
           fcb    $72                                                   * 0065 72             r
           fcb    $69                                                   * 0066 69             i
           fcb    $67                                                   * 0067 67             g
           fcb    $68                                                   * 0068 68             h
           fcb    $74                                                   * 0069 74             t
           fcb    $73                                                   * 006A 73             s
           fcb    $20                                                   * 006B 20
           fcb    $72                                                   * 006C 72             r
           fcb    $65                                                   * 006D 65             e
           fcb    $73                                                   * 006E 73             s
           fcb    $65                                                   * 006F 65             e
           fcb    $72                                                   * 0070 72             r
           fcb    $76                                                   * 0071 76             v
           fcb    $65                                                   * 0072 65             e
           fcb    $64                                                   * 0073 64             d
           fcb    $EC                                                   * 0074 EC             l
           fcb    $E6                                                   * 0075 E6             f
           fcb    $EA                                                   * 0076 EA             j
           fcb    $F5                                                   * 0077 F5             u
           fcb    $E9                                                   * 0078 E9             i
           fcb    $A0                                                   * 0079 A0
           fcb    $E2                                                   * 007A E2             b
           fcb    $ED                                                   * 007B ED             m
           fcb    $F1                                                   * 007C F1             q
           fcb    $E9                                                   * 007D E9             i
           fcb    $F0                                                   * 007E F0             p
           fcb    $EF                                                   * 007F EF             o
           fcb    $F4                                                   * 0080 F4             t
           fcb    $F0                                                   * 0081 F0             p
L0082      fcb    $55                                                   * 0082 55             U
           fcb    $6C                                                   * 0083 6C             l
           fcb    $6F                                                   * 0084 6F             o
           fcb    $61                                                   * 0085 61             a
           fcb    $64                                                   * 0086 64             d
           fcb    $78                                                   * 0087 78             x
           fcb    $0D                                                   * 0088 0D             .
L0089      fcb    $55                                                   * 0089 55             U
           fcb    $6C                                                   * 008A 6C             l
           fcb    $6F                                                   * 008B 6F             o
           fcb    $61                                                   * 008C 61             a
           fcb    $64                                                   * 008D 64             d
           fcb    $78                                                   * 008E 78             x
           fcb    $63                                                   * 008F 63             c
           fcb    $0D                                                   * 0090 0D             .
L0091      fcb    $55                                                   * 0091 55             U
           fcb    $6C                                                   * 0092 6C             l
           fcb    $6F                                                   * 0093 6F             o
           fcb    $61                                                   * 0094 61             a
           fcb    $64                                                   * 0095 64             d
           fcb    $79                                                   * 0096 79             y
           fcb    $0D                                                   * 0097 0D             .
           fcb    $55                                                   * 0098 55             U
           fcb    $6C                                                   * 0099 6C             l
           fcb    $6F                                                   * 009A 6F             o
           fcb    $61                                                   * 009B 61             a
           fcb    $64                                                   * 009C 64             d
           fcb    $79                                                   * 009D 79             y
           fcb    $62                                                   * 009E 62             b
           fcb    $0D                                                   * 009F 0D             .
L00A0      fcb    $55                                                   * 00A0 55             U
           fcb    $6C                                                   * 00A1 6C             l
           fcb    $6F                                                   * 00A2 6F             o
           fcb    $61                                                   * 00A3 61             a
           fcb    $64                                                   * 00A4 64             d
           fcb    $61                                                   * 00A5 61             a
           fcb    $0D                                                   * 00A6 0D             .
L00A7      fcb    $45                                                   * 00A7 45             E
           fcb    $6E                                                   * 00A8 6E             n
           fcb    $74                                                   * 00A9 74             t
           fcb    $65                                                   * 00AA 65             e
           fcb    $72                                                   * 00AB 72             r
           fcb    $20                                                   * 00AC 20
           fcb    $79                                                   * 00AD 79             y
           fcb    $6F                                                   * 00AE 6F             o
           fcb    $75                                                   * 00AF 75             u
           fcb    $72                                                   * 00B0 72             r
           fcb    $20                                                   * 00B1 20
           fcb    $75                                                   * 00B2 75             u
           fcb    $70                                                   * 00B3 70             p
           fcb    $6C                                                   * 00B4 6C             l
           fcb    $6F                                                   * 00B5 6F             o
           fcb    $61                                                   * 00B6 61             a
           fcb    $64                                                   * 00B7 64             d
           fcb    $20                                                   * 00B8 20
           fcb    $70                                                   * 00B9 70             p
           fcb    $72                                                   * 00BA 72             r
           fcb    $6F                                                   * 00BB 6F             o
           fcb    $74                                                   * 00BC 74             t
           fcb    $6F                                                   * 00BD 6F             o
           fcb    $63                                                   * 00BE 63             c
           fcb    $6F                                                   * 00BF 6F             o
           fcb    $6C                                                   * 00C0 6C             l
           fcb    $0D                                                   * 00C1 0D             .
L00C2      fcb    $0A                                                   * 00C2 0A             .
           fcb    $0D                                                   * 00C3 0D             .
           fcb    $5B                                                   * 00C4 5B             [
           fcb    $41                                                   * 00C5 41             A
           fcb    $5D                                                   * 00C6 5D             ]
           fcb    $20                                                   * 00C7 20
           fcb    $41                                                   * 00C8 41             A
           fcb    $73                                                   * 00C9 73             s
           fcb    $63                                                   * 00CA 63             c
           fcb    $69                                                   * 00CB 69             i
           fcb    $69                                                   * 00CC 69             i
           fcb    $0A                                                   * 00CD 0A             .
           fcb    $0D                                                   * 00CE 0D             .
           fcb    $5B                                                   * 00CF 5B             [
           fcb    $58                                                   * 00D0 58             X
           fcb    $5D                                                   * 00D1 5D             ]
           fcb    $20                                                   * 00D2 20
           fcb    $78                                                   * 00D3 78             x
           fcb    $6D                                                   * 00D4 6D             m
           fcb    $6F                                                   * 00D5 6F             o
           fcb    $64                                                   * 00D6 64             d
           fcb    $65                                                   * 00D7 65             e
           fcb    $6D                                                   * 00D8 6D             m
           fcb    $0A                                                   * 00D9 0A             .
           fcb    $0D                                                   * 00DA 0D             .
           fcb    $5B                                                   * 00DB 5B             [
           fcb    $43                                                   * 00DC 43             C
           fcb    $5D                                                   * 00DD 5D             ]
           fcb    $20                                                   * 00DE 20
           fcb    $78                                                   * 00DF 78             x
           fcb    $6D                                                   * 00E0 6D             m
           fcb    $6F                                                   * 00E1 6F             o
           fcb    $64                                                   * 00E2 64             d
           fcb    $65                                                   * 00E3 65             e
           fcb    $6D                                                   * 00E4 6D             m
           fcb    $20                                                   * 00E5 20
           fcb    $28                                                   * 00E6 28             (
           fcb    $43                                                   * 00E7 43             C
           fcb    $52                                                   * 00E8 52             R
           fcb    $43                                                   * 00E9 43             C
           fcb    $29                                                   * 00EA 29             )
           fcb    $0A                                                   * 00EB 0A             .
           fcb    $0D                                                   * 00EC 0D             .
           fcb    $5B                                                   * 00ED 5B             [
           fcb    $59                                                   * 00EE 59             Y
           fcb    $5D                                                   * 00EF 5D             ]
           fcb    $20                                                   * 00F0 20
           fcb    $79                                                   * 00F1 79             y
           fcb    $6D                                                   * 00F2 6D             m
           fcb    $6F                                                   * 00F3 6F             o
           fcb    $64                                                   * 00F4 64             d
           fcb    $65                                                   * 00F5 65             e
           fcb    $6D                                                   * 00F6 6D             m
           fcb    $0A                                                   * 00F7 0A             .
           fcb    $0D                                                   * 00F8 0D             .
           fcb    $5B                                                   * 00F9 5B             [
           fcb    $51                                                   * 00FA 51             Q
           fcb    $5D                                                   * 00FB 5D             ]
           fcb    $20                                                   * 00FC 20
           fcb    $71                                                   * 00FD 71             q
           fcb    $75                                                   * 00FE 75             u
           fcb    $69                                                   * 00FF 69             i
           fcb    $74                                                   * 0100 74             t
           fcb    $0A                                                   * 0101 0A             .
           fcb    $0D                                                   * 0102 0D             .
           fcb    $50                                                   * 0103 50             P
           fcb    $72                                                   * 0104 72             r
           fcb    $6F                                                   * 0105 6F             o
           fcb    $74                                                   * 0106 74             t
           fcb    $6F                                                   * 0107 6F             o
           fcb    $63                                                   * 0108 63             c
           fcb    $6F                                                   * 0109 6F             o
           fcb    $6C                                                   * 010A 6C             l
           fcb    $3F                                                   * 010B 3F             ?
L010C      fcb    $45                                                   * 010C 45             E
           fcb    $6E                                                   * 010D 6E             n
           fcb    $74                                                   * 010E 74             t
           fcb    $65                                                   * 010F 65             e
           fcb    $72                                                   * 0110 72             r
           fcb    $20                                                   * 0111 20
           fcb    $66                                                   * 0112 66             f
           fcb    $69                                                   * 0113 69             i
           fcb    $6C                                                   * 0114 6C             l
           fcb    $65                                                   * 0115 65             e
           fcb    $6E                                                   * 0116 6E             n
           fcb    $61                                                   * 0117 61             a
           fcb    $6D                                                   * 0118 6D             m
           fcb    $65                                                   * 0119 65             e
           fcb    $20                                                   * 011A 20
           fcb    $74                                                   * 011B 74             t
           fcb    $6F                                                   * 011C 6F             o
           fcb    $20                                                   * 011D 20
           fcb    $75                                                   * 011E 75             u
           fcb    $70                                                   * 011F 70             p
           fcb    $6C                                                   * 0120 6C             l
           fcb    $6F                                                   * 0121 6F             o
           fcb    $61                                                   * 0122 61             a
           fcb    $64                                                   * 0123 64             d
           fcb    $3A                                                   * 0124 3A             :
L0125      fcb    $44                                                   * 0125 44             D
           fcb    $4C                                                   * 0126 4C             L
           fcb    $44                                                   * 0127 44             D
           fcb    $2E                                                   * 0128 2E             .
           fcb    $6C                                                   * 0129 6C             l
           fcb    $73                                                   * 012A 73             s
           fcb    $74                                                   * 012B 74             t
           fcb    $0D                                                   * 012C 0D             .
L012D      fcb    $0D                                                   * 012D 0D             .
           fcb    $0A                                                   * 012E 0A             .
L012F      fcb    $45                                                   * 012F 45             E
           fcb    $6E                                                   * 0130 6E             n
           fcb    $74                                                   * 0131 74             t
           fcb    $65                                                   * 0132 65             e
           fcb    $72                                                   * 0133 72             r
           fcb    $20                                                   * 0134 20
           fcb    $61                                                   * 0135 61             a
           fcb    $20                                                   * 0136 20
           fcb    $6F                                                   * 0137 6F             o
           fcb    $6E                                                   * 0138 6E             n
           fcb    $65                                                   * 0139 65             e
           fcb    $2D                                                   * 013A 2D             -
           fcb    $6C                                                   * 013B 6C             l
           fcb    $69                                                   * 013C 69             i
           fcb    $6E                                                   * 013D 6E             n
           fcb    $65                                                   * 013E 65             e
           fcb    $20                                                   * 013F 20
           fcb    $64                                                   * 0140 64             d
           fcb    $65                                                   * 0141 65             e
           fcb    $73                                                   * 0142 73             s
           fcb    $63                                                   * 0143 63             c
           fcb    $72                                                   * 0144 72             r
           fcb    $69                                                   * 0145 69             i
           fcb    $70                                                   * 0146 70             p
           fcb    $74                                                   * 0147 74             t
           fcb    $69                                                   * 0148 69             i
           fcb    $6F                                                   * 0149 6F             o
           fcb    $6E                                                   * 014A 6E             n
           fcb    $20                                                   * 014B 20
           fcb    $6F                                                   * 014C 6F             o
           fcb    $66                                                   * 014D 66             f
           fcb    $20                                                   * 014E 20
           fcb    $74                                                   * 014F 74             t
           fcb    $68                                                   * 0150 68             h
           fcb    $69                                                   * 0151 69             i
           fcb    $73                                                   * 0152 73             s
           fcb    $20                                                   * 0153 20
           fcb    $66                                                   * 0154 66             f
           fcb    $69                                                   * 0155 69             i
           fcb    $6C                                                   * 0156 6C             l
           fcb    $65                                                   * 0157 65             e
           fcb    $0D                                                   * 0158 0D             .
L0159      fcb    $3E                                                   * 0159 3E             >
           fcb    $0D                                                   * 015A 0D             .
L015B      fcb    $2F                                                   * 015B 2F             /
           fcb    $64                                                   * 015C 64             d
           fcb    $64                                                   * 015D 64             d
           fcb    $2F                                                   * 015E 2F             /
           fcb    $62                                                   * 015F 62             b
           fcb    $62                                                   * 0160 62             b
           fcb    $73                                                   * 0161 73             s
           fcb    $2F                                                   * 0162 2F             /
           fcb    $42                                                   * 0163 42             B
           fcb    $42                                                   * 0164 42             B
           fcb    $53                                                   * 0165 53             S
           fcb    $2E                                                   * 0166 2E             .
           fcb    $75                                                   * 0167 75             u
           fcb    $73                                                   * 0168 73             s
           fcb    $65                                                   * 0169 65             e
           fcb    $72                                                   * 016A 72             r
           fcb    $73                                                   * 016B 73             s
           fcb    $74                                                   * 016C 74             t
           fcb    $61                                                   * 016D 61             a
           fcb    $74                                                   * 016E 74             t
           fcb    $73                                                   * 016F 73             s
           fcb    $0D                                                   * 0170 0D             .
start      lda    0,X                                                   * 0171 A6 84          &.
           cmpa   #13                                                   * 0173 81 0D          ..
           beq    L0180                                                 * 0175 27 09          '.
           lda    #1                                                    * 0177 86 01          ..
           os9    I$ChgDir                                              * 0179 10 3F 86       .?.
           lbcs   L04B2                                                 * 017C 10 25 03 32    .%.2
L0180      leax   L0125,PC                                              * 0180 30 8D FF A1    0..!
           lda    #3                                                    * 0184 86 03          ..
           os9    I$Open                                                * 0186 10 3F 84       .?.
           bcs    L018F                                                 * 0189 25 04          %.
           sta    U0001,U                                               * 018B A7 41          'A
           bra    L01A0                                                 * 018D 20 11           .
L018F      cmpb   #216                                                  * 018F C1 D8          AX
           lbne   L04B2                                                 * 0191 10 26 03 1D    .&..
           ldb    #27                                                   * 0195 C6 1B          F.
           os9    I$Create                                              * 0197 10 3F 83       .?.
           lbcs   L04B2                                                 * 019A 10 25 03 14    .%..
           sta    U0001,U                                               * 019E A7 41          'A
L01A0      leax   L00A7,PC                                              * 01A0 30 8D FF 03    0...
           ldy    #200                                                  * 01A4 10 8E 00 C8    ...H
           lda    #1                                                    * 01A8 86 01          ..
           os9    I$WritLn                                              * 01AA 10 3F 8C       .?.
           leax   L00C2,PC                                              * 01AD 30 8D FF 11    0...
           ldy    #74                                                   * 01B1 10 8E 00 4A    ...J
           lda    #1                                                    * 01B5 86 01          ..
           os9    I$Write                                               * 01B7 10 3F 8A       .?.
           leax   U0000,U                                               * 01BA 30 C4          0D
           ldy    #1                                                    * 01BC 10 8E 00 01    ....
           lda    #1                                                    * 01C0 86 01          ..
           os9    I$Read                                                * 01C2 10 3F 89       .?.
           leax   L012D,PC                                              * 01C5 30 8D FF 64    0..d
           ldy    #1                                                    * 01C9 10 8E 00 01    ....
           lda    #1                                                    * 01CD 86 01          ..
           os9    I$WritLn                                              * 01CF 10 3F 8C       .?.
           lda    U0000,U                                               * 01D2 A6 C4          &D
           anda   #223                                                  * 01D4 84 DF          ._
           cmpa   #65                                                   * 01D6 81 41          .A
           lbeq   L01F6                                                 * 01D8 10 27 00 1A    .'..
           cmpa   #88                                                   * 01DC 81 58          .X
           lbeq   L023A                                                 * 01DE 10 27 00 58    .'.X
           cmpa   #67                                                   * 01E2 81 43          .C
           lbeq   L027E                                                 * 01E4 10 27 00 96    .'..
           cmpa   #89                                                   * 01E8 81 59          .Y
           lbeq   L02C6                                                 * 01EA 10 27 00 D8    .'.X
           cmpa   #81                                                   * 01EE 81 51          .Q
           lbeq   L04B1                                                 * 01F0 10 27 02 BD    .'.=
           bra    L0180                                                 * 01F4 20 8A           .
L01F6      leax   L010C,PC                                              * 01F6 30 8D FF 12    0...
           ldy    #25                                                   * 01FA 10 8E 00 19    ....
           lda    #1                                                    * 01FE 86 01          ..
           os9    I$Write                                               * 0200 10 3F 8A       .?.
           leax   <U0032,U                                              * 0203 30 C8 32       0H2
           ldy    #27                                                   * 0206 10 8E 00 1B    ....
           clra                                                         * 020A 4F             O
           os9    I$ReadLn                                              * 020B 10 3F 8B       .?.
           bcs    L01F6                                                 * 020E 25 E6          %f
           cmpy   #1                                                    * 0210 10 8C 00 01    ....
           lbls   L04B1                                                 * 0214 10 23 02 99    .#..
           lda    #17                                                   * 0218 86 11          ..
           ldb    #3                                                    * 021A C6 03          F.
           leax   L00A0,PC                                              * 021C 30 8D FE 80    0.~.
           pshs   U                                                     * 0220 34 40          4@
           leau   <U0032,U                                              * 0222 33 C8 32       3H2
           os9    F$Fork                                                * 0225 10 3F 03       .?.
           lbcs   L04B2                                                 * 0228 10 25 02 86    .%..
           clrb                                                         * 022C 5F             _
           os9    F$Wait                                                * 022D 10 3F 04       .?.
           tstb                                                         * 0230 5D             ]
           lbne   L04B2                                                 * 0231 10 26 02 7D    .&.}
           puls   U                                                     * 0235 35 40          5@
           lbra   L0336                                                 * 0237 16 00 FC       ..|
L023A      leax   L010C,PC                                              * 023A 30 8D FE CE    0.~N
           ldy    #25                                                   * 023E 10 8E 00 19    ....
           lda    #1                                                    * 0242 86 01          ..
           os9    I$Write                                               * 0244 10 3F 8A       .?.
           leax   <U0032,U                                              * 0247 30 C8 32       0H2
           ldy    #27                                                   * 024A 10 8E 00 1B    ....
           clra                                                         * 024E 4F             O
           os9    I$ReadLn                                              * 024F 10 3F 8B       .?.
           bcs    L023A                                                 * 0252 25 E6          %f
           cmpy   #1                                                    * 0254 10 8C 00 01    ....
           lbls   L04B1                                                 * 0258 10 23 02 55    .#.U
           lda    #17                                                   * 025C 86 11          ..
           ldb    #3                                                    * 025E C6 03          F.
           leax   L0082,PC                                              * 0260 30 8D FE 1E    0.~.
           pshs   U                                                     * 0264 34 40          4@
           leau   <U0032,U                                              * 0266 33 C8 32       3H2
           os9    F$Fork                                                * 0269 10 3F 03       .?.
           lbcs   L04B2                                                 * 026C 10 25 02 42    .%.B
           clrb                                                         * 0270 5F             _
           os9    F$Wait                                                * 0271 10 3F 04       .?.
           tstb                                                         * 0274 5D             ]
           lbne   L04B2                                                 * 0275 10 26 02 39    .&.9
           puls   U                                                     * 0279 35 40          5@
           lbra   L0336                                                 * 027B 16 00 B8       ..8
L027E      leax   L010C,PC                                              * 027E 30 8D FE 8A    0.~.
           ldy    #25                                                   * 0282 10 8E 00 19    ....
           lda    #1                                                    * 0286 86 01          ..
           os9    I$Write                                               * 0288 10 3F 8A       .?.
           leax   <U0032,U                                              * 028B 30 C8 32       0H2
           ldy    #27                                                   * 028E 10 8E 00 1B    ....
           clra                                                         * 0292 4F             O
           os9    I$ReadLn                                              * 0293 10 3F 8B       .?.
           bcs    L027E                                                 * 0296 25 E6          %f
           cmpy   #1                                                    * 0298 10 8C 00 01    ....
           lbls   L04B1                                                 * 029C 10 23 02 11    .#..
           lda    #17                                                   * 02A0 86 11          ..
           ldb    #3                                                    * 02A2 C6 03          F.
           leax   L0089,PC                                              * 02A4 30 8D FD E1    0.}a
           pshs   U                                                     * 02A8 34 40          4@
           leau   <U0032,U                                              * 02AA 33 C8 32       3H2
           os9    F$Fork                                                * 02AD 10 3F 03       .?.
           lbcs   L04B2                                                 * 02B0 10 25 01 FE    .%.~
           clrb                                                         * 02B4 5F             _
           os9    F$Wait                                                * 02B5 10 3F 04       .?.
           lbcs   L04B2                                                 * 02B8 10 25 01 F6    .%.v
           tstb                                                         * 02BC 5D             ]
           lbne   L04B2                                                 * 02BD 10 26 01 F1    .&.q
           puls   U                                                     * 02C1 35 40          5@
           lbra   L0336                                                 * 02C3 16 00 70       ..p
L02C6      leax   L010C,PC                                              * 02C6 30 8D FE 42    0.~B
           ldy    #25                                                   * 02CA 10 8E 00 19    ....
           lda    #1                                                    * 02CE 86 01          ..
           os9    I$Write                                               * 02D0 10 3F 8A       .?.
           leax   <U0032,U                                              * 02D3 30 C8 32       0H2
           ldy    #27                                                   * 02D6 10 8E 00 1B    ....
           clra                                                         * 02DA 4F             O
           os9    I$ReadLn                                              * 02DB 10 3F 8B       .?.
           bcs    L02C6                                                 * 02DE 25 E6          %f
           cmpy   #1                                                    * 02E0 10 8C 00 01    ....
           lbls   L04B1                                                 * 02E4 10 23 01 C9    .#.I
           lda    #17                                                   * 02E8 86 11          ..
           ldb    #3                                                    * 02EA C6 03          F.
           leax   L0091,PC                                              * 02EC 30 8D FD A1    0.}!
           pshs   U                                                     * 02F0 34 40          4@
           leau   <U0032,U                                              * 02F2 33 C8 32       3H2
           os9    F$Fork                                                * 02F5 10 3F 03       .?.
           lbcs   L04B2                                                 * 02F8 10 25 01 B6    .%.6
           clrb                                                         * 02FC 5F             _
           os9    F$Wait                                                * 02FD 10 3F 04       .?.
           lbcs   L04B2                                                 * 0300 10 25 01 AE    .%..
           tstb                                                         * 0304 5D             ]
           lbne   L04B2                                                 * 0305 10 26 01 A9    .&.)
           puls   U                                                     * 0309 35 40          5@
           lbra   L0336                                                 * 030B 16 00 28       ..(
           fcb    $86                                                   * 030E 86             .
           fcb    $11                                                   * 030F 11             .
           fcb    $10                                                   * 0310 10             .
           fcb    $8E                                                   * 0311 8E             .
           fcb    $00                                                   * 0312 00             .
           fcb    $01                                                   * 0313 01             .
           fcb    $C6                                                   * 0314 C6             F
           fcb    $03                                                   * 0315 03             .
           fcb    $30                                                   * 0316 30             0
           fcb    $8D                                                   * 0317 8D             .
           fcb    $FD                                                   * 0318 FD             }
           fcb    $7E                                                   * 0319 7E             ~
           fcb    $34                                                   * 031A 34             4
           fcb    $40                                                   * 031B 40             @
           fcb    $33                                                   * 031C 33             3
           fcb    $C9                                                   * 031D C9             I
           fcb    $01                                                   * 031E 01             .
           fcb    $2D                                                   * 031F 2D             -
           fcb    $10                                                   * 0320 10             .
           fcb    $3F                                                   * 0321 3F             ?
           fcb    $03                                                   * 0322 03             .
           fcb    $10                                                   * 0323 10             .
           fcb    $25                                                   * 0324 25             %
           fcb    $01                                                   * 0325 01             .
           fcb    $8B                                                   * 0326 8B             .
           fcb    $5F                                                   * 0327 5F             _
           fcb    $10                                                   * 0328 10             .
           fcb    $3F                                                   * 0329 3F             ?
           fcb    $04                                                   * 032A 04             .
           fcb    $10                                                   * 032B 10             .
           fcb    $25                                                   * 032C 25             %
           fcb    $01                                                   * 032D 01             .
           fcb    $83                                                   * 032E 83             .
           fcb    $5D                                                   * 032F 5D             ]
           fcb    $10                                                   * 0330 10             .
           fcb    $26                                                   * 0331 26             &
           fcb    $01                                                   * 0332 01             .
           fcb    $7E                                                   * 0333 7E             ~
           fcb    $35                                                   * 0334 35             5
           fcb    $40                                                   * 0335 40             @
L0336      lda    U0001,U                                               * 0336 A6 41          &A
           leax   >U0092,U                                              * 0338 30 C9 00 92    0I..
           ldy    #96                                                   * 033C 10 8E 00 60    ...`
           os9    I$Read                                                * 0340 10 3F 89       .?.
           bcs    L0359                                                 * 0343 25 14          %.
           leay   <U0032,U                                              * 0345 31 C8 32       1H2
L0348      lda    ,X+                                                   * 0348 A6 80          &.
           cmpa   ,Y+                                                   * 034A A1 A0          !
           bne    L0336                                                 * 034C 26 E8          &h
           cmpa   #13                                                   * 034E 81 0D          ..
           beq    L0354                                                 * 0350 27 02          '.
           bra    L0348                                                 * 0352 20 F4           t
L0354      ldb    #218                                                  * 0354 C6 DA          FZ
           lbra   L04B2                                                 * 0356 16 01 59       ..Y
L0359      cmpb   #211                                                  * 0359 C1 D3          AS
           lbne   L04B2                                                 * 035B 10 26 01 53    .&.S
           lda    U0001,U                                               * 035F A6 41          &A
           ldb    #5                                                    * 0361 C6 05          F.
           ldx    #0                                                    * 0363 8E 00 00       ...
           pshs   U                                                     * 0366 34 40          4@
           ldu    #0                                                    * 0368 CE 00 00       N..
           os9    I$Seek                                                * 036B 10 3F 88       .?.
           puls   U                                                     * 036E 35 40          5@
L0370      lda    U0001,U                                               * 0370 A6 41          &A
           leax   >U0092,U                                              * 0372 30 C9 00 92    0I..
           ldy    #96                                                   * 0376 10 8E 00 60    ...`
           os9    I$Read                                                * 037A 10 3F 89       .?.
           bcs    L03A7                                                 * 037D 25 28          %(
           lda    >U00B1,U                                              * 037F A6 C9 00 B1    &I.1
           cmpa   #1                                                    * 0383 81 01          ..
           bne    L0370                                                 * 0385 26 E9          &i
           lda    U0001,U                                               * 0387 A6 41          &A
           ldb    #5                                                    * 0389 C6 05          F.
           pshs   U                                                     * 038B 34 40          4@
           os9    I$GetStt                                              * 038D 10 3F 8D       .?.
           tfr    U,D                                                   * 0390 1F 30          .0
           subd   #96                                                   * 0392 83 00 60       ..`
           bge    L0399                                                 * 0395 2C 02          ,.
           leax   -$01,X                                                * 0397 30 1F          0.
L0399      ldy    0,S                                                   * 0399 10 AE E4       ..d
           tfr    D,U                                                   * 039C 1F 03          ..
           lda    $01,Y                                                 * 039E A6 21          &!
           os9    I$Seek                                                * 03A0 10 3F 88       .?.
           puls   U                                                     * 03A3 35 40          5@
           bra    L03AD                                                 * 03A5 20 06           .
L03A7      cmpb   #211                                                  * 03A7 C1 D3          AS
           lbne   L04B2                                                 * 03A9 10 26 01 05    .&..
L03AD      ldx    #0                                                    * 03AD 8E 00 00       ...
           ldy    #0                                                    * 03B0 10 8E 00 00    ....
           stx    <U004D,U                                              * 03B4 AF C8 4D       /HM
           sty    <U004F,U                                              * 03B7 10 AF C8 4F    ./HO
           leax   L012F,PC                                              * 03BB 30 8D FD 70    0.}p
           ldy    #200                                                  * 03BF 10 8E 00 C8    ...H
           lda    #1                                                    * 03C3 86 01          ..
           os9    I$WritLn                                              * 03C5 10 3F 8C       .?.
           leax   L0159,PC                                              * 03C8 30 8D FD 8D    0.}.
           ldy    #1                                                    * 03CC 10 8E 00 01    ....
           os9    I$Write                                               * 03D0 10 3F 8A       .?.
           leax   <U0052,U                                              * 03D3 30 C8 52       0HR
           ldy    #64                                                   * 03D6 10 8E 00 40    ...@
           clra                                                         * 03DA 4F             O
           os9    I$ReadLn                                              * 03DB 10 3F 8B       .?.
           clr    <U0051,U                                              * 03DE 6F C8 51       oHQ
           leax   <U0032,U                                              * 03E1 30 C8 32       0H2
           ldy    #-1                                                   * 03E4 10 8E FF FF    ....
           sty    <U004D,U                                              * 03E8 10 AF C8 4D    ./HM
           sty    <U004F,U                                              * 03EC 10 AF C8 4F    ./HO
           ldy    #96                                                   * 03F0 10 8E 00 60    ...`
           lda    U0001,U                                               * 03F4 A6 41          &A
           os9    I$Write                                               * 03F6 10 3F 8A       .?.
           leax   L015B,PC                                              * 03F9 30 8D FD 5E    0.}^
           lda    #3                                                    * 03FD 86 03          ..
           os9    I$Open                                                * 03FF 10 3F 84       .?.
           bcc    L040D                                                 * 0402 24 09          $.
           ldb    #27                                                   * 0404 C6 1B          F.
           os9    I$Create                                              * 0406 10 3F 83       .?.
           lbcs   L04B2                                                 * 0409 10 25 00 A5    .%.%
L040D      sta    U0003,U                                               * 040D A7 43          'C
           os9    F$ID                                                  * 040F 10 3F 0C       .?.
           sty    <U0010,U                                              * 0412 10 AF C8 10    ./H.
L0416      leax   <U0012,U                                              * 0416 30 C8 12       0H.
           ldy    #32                                                   * 0419 10 8E 00 20    ...
           lda    U0003,U                                               * 041D A6 43          &C
           os9    I$Read                                                * 041F 10 3F 89       .?.
           bcs    L042F                                                 * 0422 25 0B          %.
           ldd    <U0012,U                                              * 0424 EC C8 12       lH.
           cmpd   <U0010,U                                              * 0427 10 A3 C8 10    .#H.
           bne    L0416                                                 * 042B 26 E9          &i
           bra    L0438                                                 * 042D 20 09           .
L042F      cmpb   #211                                                  * 042F C1 D3          AS
           lbne   L04B2                                                 * 0431 10 26 00 7D    .&.}
           lbra   L0476                                                 * 0435 16 00 3E       ..>
L0438      ldd    <U0022,U                                              * 0438 EC C8 22       lH"
           addd   #1                                                    * 043B C3 00 01       C..
           std    <U0022,U                                              * 043E ED C8 22       mH"
           lda    U0003,U                                               * 0441 A6 43          &C
           ldb    #5                                                    * 0443 C6 05          F.
           pshs   U                                                     * 0445 34 40          4@
           os9    I$GetStt                                              * 0447 10 3F 8D       .?.
           tfr    U,D                                                   * 044A 1F 30          .0
           subd   #32                                                   * 044C 83 00 20       ..
           bge    L0453                                                 * 044F 2C 02          ,.
           leax   -$01,X                                                * 0451 30 1F          0.
L0453      ldu    0,S                                                   * 0453 EE E4          nd
           tfr    D,Y                                                   * 0455 1F 02          ..
           lda    U0003,U                                               * 0457 A6 43          &C
           tfr    Y,U                                                   * 0459 1F 23          .#
           os9    I$Seek                                                * 045B 10 3F 88       .?.
           lbcs   L04B2                                                 * 045E 10 25 00 50    .%.P
           puls   U                                                     * 0462 35 40          5@
           leax   <U0012,U                                              * 0464 30 C8 12       0H.
           ldy    #32                                                   * 0467 10 8E 00 20    ...
           lda    U0003,U                                               * 046B A6 43          &C
           os9    I$Write                                               * 046D 10 3F 8A       .?.
           os9    I$Close                                               * 0470 10 3F 8F       .?.
           lbra   L04B1                                                 * 0473 16 00 3B       ..;
L0476      leax   <U0012,U                                              * 0476 30 C8 12       0H.
           ldd    #1                                                    * 0479 CC 00 01       L..
           std    <U0014,U                                              * 047C ED C8 14       mH.
           std    <U001E,U                                              * 047F ED C8 1E       mH.
           ldd    #0                                                    * 0482 CC 00 00       L..
           std    <U001C,U                                              * 0485 ED C8 1C       mH.
           std    <U0022,U                                              * 0488 ED C8 22       mH"
           std    <U0020,U                                              * 048B ED C8 20       mH
           ldd    <U0010,U                                              * 048E EC C8 10       lH.
           std    <U0012,U                                              * 0491 ED C8 12       mH.
           leax   <U0016,U                                              * 0494 30 C8 16       0H.
           os9    F$Time                                                * 0497 10 3F 15       .?.
           lbcs   L04B2                                                 * 049A 10 25 00 14    .%..
           leax   <U0012,U                                              * 049E 30 C8 12       0H.
           ldy    #32                                                   * 04A1 10 8E 00 20    ...
           lda    U0003,U                                               * 04A5 A6 43          &C
           os9    I$Write                                               * 04A7 10 3F 8A       .?.
           os9    I$Close                                               * 04AA 10 3F 8F       .?.
           lbcs   L04B2                                                 * 04AD 10 25 00 01    .%..
L04B1      clrb                                                         * 04B1 5F             _
L04B2      os9    F$Exit                                                * 04B2 10 3F 06       .?.

           emod
eom        equ    *
           end
