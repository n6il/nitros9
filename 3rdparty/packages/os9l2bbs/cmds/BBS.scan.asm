           nam    BBS.scan
           ttl    program module

           ifp1
           use    defsfile
           endc

tylg       set    Prgrm+Objct
atrv       set    ReEnt+rev
rev        set    $01

           mod    eom,name,tylg,atrv,start,size

U0000      rmb    1
U0001      rmb    1
U0002      rmb    1
U0003      rmb    1
U0004      rmb    1
U0005      rmb    1
U0006      rmb    1
U0007      rmb    2
U0009      rmb    6
U000F      rmb    3
U0012      rmb    1
U0013      rmb    2
U0015      rmb    1
U0016      rmb    6
U001C      rmb    1
U001D      rmb    1
U001E      rmb    2
U0020      rmb    1
U0021      rmb    1
U0022      rmb    1
U0023      rmb    1
U0024      rmb    1
U0025      rmb    1
U0026      rmb    1
U0027      rmb    1
U0028      rmb    1
U0029      rmb    64
U0069      rmb    4
U006D      rmb    20
U0081      rmb    30
U009F      rmb    1
U00A0      rmb    1
U00A1      rmb    1
U00A2      rmb    205
size       equ    .

name       fcs    /BBS.scan/                                            * 000D 42 42 53 2E 73 63 61 EE BBS.scan
           fcb    $43                                                   * 0015 43             C
           fcb    $6F                                                   * 0016 6F             o
           fcb    $70                                                   * 0017 70             p
           fcb    $79                                                   * 0018 79             y
           fcb    $72                                                   * 0019 72             r
           fcb    $69                                                   * 001A 69             i
           fcb    $67                                                   * 001B 67             g
           fcb    $68                                                   * 001C 68             h
           fcb    $74                                                   * 001D 74             t
           fcb    $20                                                   * 001E 20
           fcb    $28                                                   * 001F 28             (
           fcb    $43                                                   * 0020 43             C
           fcb    $29                                                   * 0021 29             )
           fcb    $20                                                   * 0022 20
           fcb    $31                                                   * 0023 31             1
           fcb    $39                                                   * 0024 39             9
           fcb    $38                                                   * 0025 38             8
           fcb    $38                                                   * 0026 38             8
           fcb    $42                                                   * 0027 42             B
           fcb    $79                                                   * 0028 79             y
           fcb    $20                                                   * 0029 20
           fcb    $4B                                                   * 002A 4B             K
           fcb    $65                                                   * 002B 65             e
           fcb    $69                                                   * 002C 69             i
           fcb    $74                                                   * 002D 74             t
           fcb    $68                                                   * 002E 68             h
           fcb    $20                                                   * 002F 20
           fcb    $41                                                   * 0030 41             A
           fcb    $6C                                                   * 0031 6C             l
           fcb    $70                                                   * 0032 70             p
           fcb    $68                                                   * 0033 68             h
           fcb    $6F                                                   * 0034 6F             o
           fcb    $6E                                                   * 0035 6E             n
           fcb    $73                                                   * 0036 73             s
           fcb    $6F                                                   * 0037 6F             o
           fcb    $4C                                                   * 0038 4C             L
           fcb    $69                                                   * 0039 69             i
           fcb    $63                                                   * 003A 63             c
           fcb    $65                                                   * 003B 65             e
           fcb    $6E                                                   * 003C 6E             n
           fcb    $63                                                   * 003D 63             c
           fcb    $65                                                   * 003E 65             e
           fcb    $64                                                   * 003F 64             d
           fcb    $20                                                   * 0040 20
           fcb    $74                                                   * 0041 74             t
           fcb    $6F                                                   * 0042 6F             o
           fcb    $20                                                   * 0043 20
           fcb    $41                                                   * 0044 41             A
           fcb    $6C                                                   * 0045 6C             l
           fcb    $70                                                   * 0046 70             p
           fcb    $68                                                   * 0047 68             h
           fcb    $61                                                   * 0048 61             a
           fcb    $20                                                   * 0049 20
           fcb    $53                                                   * 004A 53             S
           fcb    $6F                                                   * 004B 6F             o
           fcb    $66                                                   * 004C 66             f
           fcb    $74                                                   * 004D 74             t
           fcb    $77                                                   * 004E 77             w
           fcb    $61                                                   * 004F 61             a
           fcb    $72                                                   * 0050 72             r
           fcb    $65                                                   * 0051 65             e
           fcb    $20                                                   * 0052 20
           fcb    $54                                                   * 0053 54             T
           fcb    $65                                                   * 0054 65             e
           fcb    $63                                                   * 0055 63             c
           fcb    $68                                                   * 0056 68             h
           fcb    $6E                                                   * 0057 6E             n
           fcb    $6F                                                   * 0058 6F             o
           fcb    $6C                                                   * 0059 6C             l
           fcb    $6F                                                   * 005A 6F             o
           fcb    $67                                                   * 005B 67             g
           fcb    $69                                                   * 005C 69             i
           fcb    $65                                                   * 005D 65             e
           fcb    $73                                                   * 005E 73             s
           fcb    $41                                                   * 005F 41             A
           fcb    $6C                                                   * 0060 6C             l
           fcb    $6C                                                   * 0061 6C             l
           fcb    $20                                                   * 0062 20
           fcb    $72                                                   * 0063 72             r
           fcb    $69                                                   * 0064 69             i
           fcb    $67                                                   * 0065 67             g
           fcb    $68                                                   * 0066 68             h
           fcb    $74                                                   * 0067 74             t
           fcb    $73                                                   * 0068 73             s
           fcb    $20                                                   * 0069 20
           fcb    $72                                                   * 006A 72             r
           fcb    $65                                                   * 006B 65             e
           fcb    $73                                                   * 006C 73             s
           fcb    $65                                                   * 006D 65             e
           fcb    $72                                                   * 006E 72             r
           fcb    $76                                                   * 006F 76             v
           fcb    $65                                                   * 0070 65             e
           fcb    $64                                                   * 0071 64             d
           fcb    $EC                                                   * 0072 EC             l
           fcb    $E6                                                   * 0073 E6             f
           fcb    $EA                                                   * 0074 EA             j
           fcb    $F5                                                   * 0075 F5             u
           fcb    $E9                                                   * 0076 E9             i
           fcb    $A0                                                   * 0077 A0
           fcb    $E2                                                   * 0078 E2             b
           fcb    $ED                                                   * 0079 ED             m
           fcb    $F1                                                   * 007A F1             q
           fcb    $E9                                                   * 007B E9             i
           fcb    $F0                                                   * 007C F0             p
           fcb    $EF                                                   * 007D EF             o
           fcb    $F4                                                   * 007E F4             t
           fcb    $F0                                                   * 007F F0             p
L0080      fcb    $48                                                   * 0080 48             H
           fcb    $69                                                   * 0081 69             i
           fcb    $67                                                   * 0082 67             g
           fcb    $68                                                   * 0083 68             h
           fcb    $20                                                   * 0084 20
           fcb    $6D                                                   * 0085 6D             m
           fcb    $65                                                   * 0086 65             e
           fcb    $73                                                   * 0087 73             s
           fcb    $73                                                   * 0088 73             s
           fcb    $61                                                   * 0089 61             a
           fcb    $67                                                   * 008A 67             g
           fcb    $65                                                   * 008B 65             e
           fcb    $20                                                   * 008C 20
           fcb    $69                                                   * 008D 69             i
           fcb    $73                                                   * 008E 73             s
           fcb    $20                                                   * 008F 20
           fcb    $23                                                   * 0090 23             #
L0091      fcb    $00                                                   * 0091 00             .
           fcb    $11                                                   * 0092 11             .
L0093      fcb    $45                                                   * 0093 45             E
           fcb    $6E                                                   * 0094 6E             n
           fcb    $74                                                   * 0095 74             t
           fcb    $65                                                   * 0096 65             e
           fcb    $72                                                   * 0097 72             r
           fcb    $20                                                   * 0098 20
           fcb    $73                                                   * 0099 73             s
           fcb    $74                                                   * 009A 74             t
           fcb    $61                                                   * 009B 61             a
           fcb    $72                                                   * 009C 72             r
           fcb    $74                                                   * 009D 74             t
           fcb    $69                                                   * 009E 69             i
           fcb    $6E                                                   * 009F 6E             n
           fcb    $67                                                   * 00A0 67             g
           fcb    $20                                                   * 00A1 20
           fcb    $6D                                                   * 00A2 6D             m
           fcb    $65                                                   * 00A3 65             e
           fcb    $73                                                   * 00A4 73             s
           fcb    $73                                                   * 00A5 73             s
           fcb    $61                                                   * 00A6 61             a
           fcb    $67                                                   * 00A7 67             g
           fcb    $65                                                   * 00A8 65             e
           fcb    $20                                                   * 00A9 20
           fcb    $23                                                   * 00AA 23             #
           fcb    $0D                                                   * 00AB 0D             .
L00AC      fcb    $3E                                                   * 00AC 3E             >
L00AD      fcb    $4D                                                   * 00AD 4D             M
           fcb    $73                                                   * 00AE 73             s
           fcb    $67                                                   * 00AF 67             g
           fcb    $20                                                   * 00B0 20
           fcb    $23                                                   * 00B1 23             #
           fcb    $20                                                   * 00B2 20
           fcb    $20                                                   * 00B3 20
           fcb    $20                                                   * 00B4 20
           fcb    $20                                                   * 00B5 20
           fcb    $55                                                   * 00B6 55             U
           fcb    $73                                                   * 00B7 73             s
           fcb    $65                                                   * 00B8 65             e
           fcb    $72                                                   * 00B9 72             r
           fcb    $20                                                   * 00BA 20
           fcb    $6E                                                   * 00BB 6E             n
           fcb    $61                                                   * 00BC 61             a
           fcb    $6D                                                   * 00BD 6D             m
           fcb    $65                                                   * 00BE 65             e
           fcb    $20                                                   * 00BF 20
           fcb    $20                                                   * 00C0 20
           fcb    $20                                                   * 00C1 20
           fcb    $20                                                   * 00C2 20
           fcb    $20                                                   * 00C3 20
           fcb    $20                                                   * 00C4 20
           fcb    $20                                                   * 00C5 20
           fcb    $20                                                   * 00C6 20
           fcb    $20                                                   * 00C7 20
           fcb    $20                                                   * 00C8 20
           fcb    $20                                                   * 00C9 20
           fcb    $20                                                   * 00CA 20
           fcb    $20                                                   * 00CB 20
           fcb    $20                                                   * 00CC 20
           fcb    $44                                                   * 00CD 44             D
           fcb    $61                                                   * 00CE 61             a
           fcb    $74                                                   * 00CF 74             t
           fcb    $65                                                   * 00D0 65             e
           fcb    $20                                                   * 00D1 20
           fcb    $20                                                   * 00D2 20
           fcb    $20                                                   * 00D3 20
           fcb    $20                                                   * 00D4 20
           fcb    $20                                                   * 00D5 20
           fcb    $20                                                   * 00D6 20
           fcb    $20                                                   * 00D7 20
           fcb    $20                                                   * 00D8 20
           fcb    $53                                                   * 00D9 53             S
           fcb    $75                                                   * 00DA 75             u
           fcb    $62                                                   * 00DB 62             b
           fcb    $6A                                                   * 00DC 6A             j
           fcb    $65                                                   * 00DD 65             e
           fcb    $63                                                   * 00DE 63             c
           fcb    $74                                                   * 00DF 74             t
           fcb    $0D                                                   * 00E0 0D             .
L00E1      fcb    $2D                                                   * 00E1 2D             -
           fcb    $2D                                                   * 00E2 2D             -
           fcb    $2D                                                   * 00E3 2D             -
           fcb    $2D                                                   * 00E4 2D             -
           fcb    $2D                                                   * 00E5 2D             -
           fcb    $2D                                                   * 00E6 2D             -
           fcb    $2D                                                   * 00E7 2D             -
           fcb    $2D                                                   * 00E8 2D             -
           fcb    $2D                                                   * 00E9 2D             -
           fcb    $2D                                                   * 00EA 2D             -
           fcb    $2D                                                   * 00EB 2D             -
           fcb    $2D                                                   * 00EC 2D             -
           fcb    $2D                                                   * 00ED 2D             -
           fcb    $2D                                                   * 00EE 2D             -
           fcb    $2D                                                   * 00EF 2D             -
           fcb    $2D                                                   * 00F0 2D             -
           fcb    $2D                                                   * 00F1 2D             -
           fcb    $2D                                                   * 00F2 2D             -
           fcb    $2D                                                   * 00F3 2D             -
           fcb    $2D                                                   * 00F4 2D             -
           fcb    $2D                                                   * 00F5 2D             -
           fcb    $2D                                                   * 00F6 2D             -
           fcb    $2D                                                   * 00F7 2D             -
           fcb    $2D                                                   * 00F8 2D             -
           fcb    $2D                                                   * 00F9 2D             -
           fcb    $2D                                                   * 00FA 2D             -
           fcb    $2D                                                   * 00FB 2D             -
           fcb    $2D                                                   * 00FC 2D             -
           fcb    $2D                                                   * 00FD 2D             -
           fcb    $2D                                                   * 00FE 2D             -
           fcb    $2D                                                   * 00FF 2D             -
           fcb    $2D                                                   * 0100 2D             -
           fcb    $2D                                                   * 0101 2D             -
           fcb    $2D                                                   * 0102 2D             -
           fcb    $2D                                                   * 0103 2D             -
           fcb    $2D                                                   * 0104 2D             -
           fcb    $2D                                                   * 0105 2D             -
           fcb    $2D                                                   * 0106 2D             -
           fcb    $2D                                                   * 0107 2D             -
           fcb    $2D                                                   * 0108 2D             -
           fcb    $2D                                                   * 0109 2D             -
           fcb    $2D                                                   * 010A 2D             -
           fcb    $2D                                                   * 010B 2D             -
           fcb    $2D                                                   * 010C 2D             -
           fcb    $2D                                                   * 010D 2D             -
           fcb    $2D                                                   * 010E 2D             -
           fcb    $2D                                                   * 010F 2D             -
           fcb    $2D                                                   * 0110 2D             -
           fcb    $2D                                                   * 0111 2D             -
           fcb    $2D                                                   * 0112 2D             -
           fcb    $2D                                                   * 0113 2D             -
           fcb    $2D                                                   * 0114 2D             -
           fcb    $2D                                                   * 0115 2D             -
           fcb    $2D                                                   * 0116 2D             -
           fcb    $2D                                                   * 0117 2D             -
           fcb    $2D                                                   * 0118 2D             -
           fcb    $2D                                                   * 0119 2D             -
           fcb    $2D                                                   * 011A 2D             -
           fcb    $2D                                                   * 011B 2D             -
           fcb    $2D                                                   * 011C 2D             -
           fcb    $2D                                                   * 011D 2D             -
           fcb    $2D                                                   * 011E 2D             -
           fcb    $2D                                                   * 011F 2D             -
           fcb    $2D                                                   * 0120 2D             -
           fcb    $0D                                                   * 0121 0D             .
L0122      fcb    $42                                                   * 0122 42             B
           fcb    $42                                                   * 0123 42             B
           fcb    $53                                                   * 0124 53             S
           fcb    $2E                                                   * 0125 2E             .
           fcb    $6D                                                   * 0126 6D             m
           fcb    $73                                                   * 0127 73             s
           fcb    $67                                                   * 0128 67             g
           fcb    $2E                                                   * 0129 2E             .
           fcb    $69                                                   * 012A 69             i
           fcb    $6E                                                   * 012B 6E             n
           fcb    $78                                                   * 012C 78             x
           fcb    $0D                                                   * 012D 0D             .
L012E      fcb    $20                                                   * 012E 20
           fcb    $20                                                   * 012F 20
           fcb    $20                                                   * 0130 20
           fcb    $20                                                   * 0131 20
           fcb    $20                                                   * 0132 20
           fcb    $20                                                   * 0133 20
           fcb    $20                                                   * 0134 20
           fcb    $20                                                   * 0135 20
           fcb    $20                                                   * 0136 20
           fcb    $20                                                   * 0137 20
           fcb    $20                                                   * 0138 20
           fcb    $20                                                   * 0139 20
           fcb    $20                                                   * 013A 20
           fcb    $20                                                   * 013B 20
           fcb    $20                                                   * 013C 20
           fcb    $20                                                   * 013D 20
           fcb    $20                                                   * 013E 20
           fcb    $20                                                   * 013F 20
           fcb    $20                                                   * 0140 20
           fcb    $20                                                   * 0141 20
           fcb    $20                                                   * 0142 20
           fcb    $20                                                   * 0143 20
           fcb    $20                                                   * 0144 20
           fcb    $20                                                   * 0145 20
           fcb    $20                                                   * 0146 20
           fcb    $20                                                   * 0147 20
           fcb    $20                                                   * 0148 20
           fcb    $20                                                   * 0149 20
           fcb    $20                                                   * 014A 20
           fcb    $20                                                   * 014B 20
           fcb    $20                                                   * 014C 20
           fcb    $20                                                   * 014D 20
           fcb    $20                                                   * 014E 20
           fcb    $20                                                   * 014F 20
           fcb    $20                                                   * 0150 20
           fcb    $20                                                   * 0151 20
           fcb    $20                                                   * 0152 20
           fcb    $20                                                   * 0153 20
           fcb    $20                                                   * 0154 20
L0155      fcb    $20                                                   * 0155 20
           fcb    $20                                                   * 0156 20
           fcb    $20                                                   * 0157 20
           fcb    $20                                                   * 0158 20
           fcb    $20                                                   * 0159 20
           fcb    $20                                                   * 015A 20
           fcb    $20                                                   * 015B 20
           fcb    $20                                                   * 015C 20
           fcb    $20                                                   * 015D 20
           fcb    $20                                                   * 015E 20
           fcb    $2A                                                   * 015F 2A             *
           fcb    $2A                                                   * 0160 2A             *
           fcb    $2A                                                   * 0161 2A             *
           fcb    $2A                                                   * 0162 2A             *
           fcb    $2A                                                   * 0163 2A             *
           fcb    $2A                                                   * 0164 2A             *
           fcb    $20                                                   * 0165 20
           fcb    $20                                                   * 0166 20
           fcb    $20                                                   * 0167 20
           fcb    $44                                                   * 0168 44             D
           fcb    $45                                                   * 0169 45             E
           fcb    $4C                                                   * 016A 4C             L
           fcb    $45                                                   * 016B 45             E
           fcb    $54                                                   * 016C 54             T
           fcb    $45                                                   * 016D 45             E
           fcb    $44                                                   * 016E 44             D
           fcb    $20                                                   * 016F 20
           fcb    $20                                                   * 0170 20
           fcb    $20                                                   * 0171 20
           fcb    $2A                                                   * 0172 2A             *
           fcb    $2A                                                   * 0173 2A             *
           fcb    $2A                                                   * 0174 2A             *
           fcb    $2A                                                   * 0175 2A             *
           fcb    $2A                                                   * 0176 2A             *
           fcb    $2A                                                   * 0177 2A             *
           fcb    $0D                                                   * 0178 0D             .
start      leax   L0122,PC                                              * 0179 30 8D FF A5    0..%
           lda    #1                                                    * 017D 86 01          ..
           os9    I$Open                                                * 017F 10 3F 84       .?.
           lbcs   L0369                                                 * 0182 10 25 01 E3    .%.c
           sta    U0000,U                                               * 0186 A7 C4          'D
           leax   <U0029,U                                              * 0188 30 C8 29       0H)
           ldy    #64                                                   * 018B 10 8E 00 40    ...@
           lda    U0000,U                                               * 018F A6 C4          &D
           os9    I$Read                                                * 0191 10 3F 89       .?.
           lbcs   L0369                                                 * 0194 10 25 01 D1    .%.Q
           ldd    <U0029,U                                              * 0198 EC C8 29       lH)
           leax   U0009,U                                               * 019B 30 49          0I
           lbsr   L03D3                                                 * 019D 17 02 33       ..3
           leax   L0080,PC                                              * 01A0 30 8D FE DC    0.~\
           ldy    L0091,PC                                              * 01A4 10 AE 8D FE E8 ...~h
           lda    #1                                                    * 01A9 86 01          ..
           os9    I$Write                                               * 01AB 10 3F 8A       .?.
           lbcs   L0369                                                 * 01AE 10 25 01 B7    .%.7
           leax   U0009,U                                               * 01B2 30 49          0I
           ldy    #6                                                    * 01B4 10 8E 00 06    ....
           os9    I$WritLn                                              * 01B8 10 3F 8C       .?.
           lbcs   L0369                                                 * 01BB 10 25 01 AA    .%.*
           leax   L0093,PC                                              * 01BF 30 8D FE D0    0.~P
           ldy    #200                                                  * 01C3 10 8E 00 C8    ...H
           lda    #1                                                    * 01C7 86 01          ..
           os9    I$WritLn                                              * 01C9 10 3F 8C       .?.
           lbcs   L0369                                                 * 01CC 10 25 01 99    .%..
           leax   L00AC,PC                                              * 01D0 30 8D FE D8    0.~X
           ldy    #1                                                    * 01D4 10 8E 00 01    ....
           os9    I$Write                                               * 01D8 10 3F 8A       .?.
           lbcs   L0369                                                 * 01DB 10 25 01 8A    .%..
           leax   <U0016,U                                              * 01DF 30 C8 16       0H.
           ldy    #6                                                    * 01E2 10 8E 00 06    ....
           clra                                                         * 01E6 4F             O
           os9    I$ReadLn                                              * 01E7 10 3F 8B       .?.
           lbcs   L0369                                                 * 01EA 10 25 01 7B    .%.{
           clr    <U0015,U                                              * 01EE 6F C8 15       oH.
           leax   <U0016,U                                              * 01F1 30 C8 16       0H.
           lbsr   L036C                                                 * 01F4 17 01 75       ..u
           cmpd   #1                                                    * 01F7 10 83 00 01    ....
           lbcs   L0368                                                 * 01FB 10 25 01 69    .%.i
           cmpd   <U0029,U                                              * 01FF 10 A3 C8 29    .#H)
           lbhi   L0368                                                 * 0203 10 22 01 61    .".a
           std    U0009,U                                               * 0207 ED 49          mI
           clr    <U001C,U                                              * 0209 6F C8 1C       oH.
           clr    <U001D,U                                              * 020C 6F C8 1D       oH.
           lda    #6                                                    * 020F 86 06          ..
           sta    U0001,U                                               * 0211 A7 41          'A
           ldd    U0009,U                                               * 0213 EC 49          lI
L0215      aslb                                                         * 0215 58             X
           rola                                                         * 0216 49             I
           rol    <U001D,U                                              * 0217 69 C8 1D       iH.
           dec    U0001,U                                               * 021A 6A 41          jA
           bne    L0215                                                 * 021C 26 F7          &w
           std    <U001E,U                                              * 021E ED C8 1E       mH.
           ldx    <U001C,U                                              * 0221 AE C8 1C       .H.
           lda    U0000,U                                               * 0224 A6 C4          &D
           pshs   U                                                     * 0226 34 40          4@
           ldu    <U001E,U                                              * 0228 EE C8 1E       nH.
           os9    I$Seek                                                * 022B 10 3F 88       .?.
           lbcs   L0369                                                 * 022E 10 25 01 37    .%.7
           puls   U                                                     * 0232 35 40          5@
           leax   L00AD,PC                                              * 0234 30 8D FE 75    0.~u
           ldy    #80                                                   * 0238 10 8E 00 50    ...P
           lda    #1                                                    * 023C 86 01          ..
           os9    I$WritLn                                              * 023E 10 3F 8C       .?.
           lbcs   L0369                                                 * 0241 10 25 01 24    .%.$
           leax   L00E1,PC                                              * 0245 30 8D FE 98    0.~.
           ldy    #80                                                   * 0249 10 8E 00 50    ...P
           os9    I$WritLn                                              * 024D 10 3F 8C       .?.
           lbcs   L0369                                                 * 0250 10 25 01 15    .%..
L0254      lda    U0000,U                                               * 0254 A6 C4          &D
           ldy    #64                                                   * 0256 10 8E 00 40    ...@
           leax   <U0069,U                                              * 025A 30 C8 69       0Hi
           os9    I$Read                                                * 025D 10 3F 89       .?.
           lbcs   L0368                                                 * 0260 10 25 01 04    .%..
           ldd    <U0069,U                                              * 0264 EC C8 69       lHi
           cmpd   #-1                                                   * 0267 10 83 FF FF    ....
           lbeq   L0351                                                 * 026B 10 27 00 E2    .'.b
           ldd    U0009,U                                               * 026F EC 49          lI
           leax   U000F,U                                               * 0271 30 4F          0O
           lbsr   L03D3                                                 * 0273 17 01 5D       ..]
           ldd    U0009,U                                               * 0276 EC 49          lI
           addd   #1                                                    * 0278 C3 00 01       C..
           std    U0009,U                                               * 027B ED 49          mI
           leax   U000F,U                                               * 027D 30 4F          0O
           ldy    #5                                                    * 027F 10 8E 00 05    ....
           lda    #1                                                    * 0283 86 01          ..
           os9    I$Write                                               * 0285 10 3F 8A       .?.
           lbcs   L0369                                                 * 0288 10 25 00 DD    .%.]
           leax   L012E,PC                                              * 028C 30 8D FE 9E    0.~.
           ldy    #4                                                    * 0290 10 8E 00 04    ....
           os9    I$Write                                               * 0294 10 3F 8A       .?.
           lbcs   L0369                                                 * 0297 10 25 00 CE    .%.N
           leax   <U006D,U                                              * 029B 30 C8 6D       0Hm
           clr    U0003,U                                               * 029E 6F 43          oC
           clr    U0004,U                                               * 02A0 6F 44          oD
L02A2      lda    ,X+                                                   * 02A2 A6 80          &.
           cmpa   #13                                                   * 02A4 81 0D          ..
           beq    L02AC                                                 * 02A6 27 04          '.
           inc    U0004,U                                               * 02A8 6C 44          lD
           bra    L02A2                                                 * 02AA 20 F6           v
L02AC      leax   <U006D,U                                              * 02AC 30 C8 6D       0Hm
           ldy    U0003,U                                               * 02AF 10 AE 43       ..C
           lda    #1                                                    * 02B2 86 01          ..
           os9    I$Write                                               * 02B4 10 3F 8A       .?.
           lbcs   L0369                                                 * 02B7 10 25 00 AE    .%..
           ldd    #22                                                   * 02BB CC 00 16       L..
           subd   U0003,U                                               * 02BE A3 43          #C
           tfr    D,Y                                                   * 02C0 1F 02          ..
           leax   L012E,PC                                              * 02C2 30 8D FE 68    0.~h
           lda    #1                                                    * 02C6 86 01          ..
           os9    I$Write                                               * 02C8 10 3F 8A       .?.
           lbcs   L0369                                                 * 02CB 10 25 00 9A    .%..
           leax   U000F,U                                               * 02CF 30 4F          0O
           ldb    >U00A0,U                                              * 02D1 E6 C9 00 A0    fI.
           clra                                                         * 02D5 4F             O
           lbsr   L03D3                                                 * 02D6 17 00 FA       ..z
           lda    <U0012,U                                              * 02D9 A6 C8 12       &H.
           sta    <U0020,U                                              * 02DC A7 C8 20       'H
           lda    <U0013,U                                              * 02DF A6 C8 13       &H.
           sta    <U0021,U                                              * 02E2 A7 C8 21       'H!
           lda    #47                                                   * 02E5 86 2F          ./
           sta    <U0022,U                                              * 02E7 A7 C8 22       'H"
           ldb    >U00A1,U                                              * 02EA E6 C9 00 A1    fI.!
           clra                                                         * 02EE 4F             O
           leax   U000F,U                                               * 02EF 30 4F          0O
           lbsr   L03D3                                                 * 02F1 17 00 DF       .._
           lda    <U0012,U                                              * 02F4 A6 C8 12       &H.
           sta    <U0023,U                                              * 02F7 A7 C8 23       'H#
           lda    <U0013,U                                              * 02FA A6 C8 13       &H.
           sta    <U0024,U                                              * 02FD A7 C8 24       'H$
           lda    #47                                                   * 0300 86 2F          ./
           sta    <U0025,U                                              * 0302 A7 C8 25       'H%
           ldb    >U009F,U                                              * 0305 E6 C9 00 9F    fI..
           clra                                                         * 0309 4F             O
           leax   U000F,U                                               * 030A 30 4F          0O
           lbsr   L03D3                                                 * 030C 17 00 C4       ..D
           lda    <U0012,U                                              * 030F A6 C8 12       &H.
           sta    <U0026,U                                              * 0312 A7 C8 26       'H&
           lda    <U0013,U                                              * 0315 A6 C8 13       &H.
           sta    <U0027,U                                              * 0318 A7 C8 27       'H'
           lda    #13                                                   * 031B 86 0D          ..
           sta    <U0028,U                                              * 031D A7 C8 28       'H(
           leax   <U0020,U                                              * 0320 30 C8 20       0H
           ldy    #8                                                    * 0323 10 8E 00 08    ....
           lda    #1                                                    * 0327 86 01          ..
           os9    I$Write                                               * 0329 10 3F 8A       .?.
           lbcs   L0369                                                 * 032C 10 25 00 39    .%.9
           ldy    #5                                                    * 0330 10 8E 00 05    ....
           leax   L012E,PC                                              * 0334 30 8D FD F6    0.}v
           os9    I$Write                                               * 0338 10 3F 8A       .?.
           lbcs   L0369                                                 * 033B 10 25 00 2A    .%.*
           leax   >U0081,U                                              * 033F 30 C9 00 81    0I..
           ldy    #30                                                   * 0343 10 8E 00 1E    ....
           os9    I$WritLn                                              * 0347 10 3F 8C       .?.
           lbcs   L0369                                                 * 034A 10 25 00 1B    .%..
           lbra   L0254                                                 * 034E 16 FF 03       ...
L0351      ldd    U0009,U                                               * 0351 EC 49          lI
           addd   #1                                                    * 0353 C3 00 01       C..
           std    U0009,U                                               * 0356 ED 49          mI
           leax   L0155,PC                                              * 0358 30 8D FD F9    0.}y
           ldy    #200                                                  * 035C 10 8E 00 C8    ...H
           lda    #1                                                    * 0360 86 01          ..
           os9    I$WritLn                                              * 0362 10 3F 8C       .?.
           lbra   L0254                                                 * 0365 16 FE EC       .~l
L0368      clrb                                                         * 0368 5F             _
L0369      os9    F$Exit                                                * 0369 10 3F 06       .?.
L036C      pshs   Y                                                     * 036C 34 20          4
L036E      lda    ,X+                                                   * 036E A6 80          &.
           cmpa   #13                                                   * 0370 81 0D          ..
           lbeq   L0441                                                 * 0372 10 27 00 CB    .'.K
           cmpa   #48                                                   * 0376 81 30          .0
           bcs    L036E                                                 * 0378 25 F4          %t
           cmpa   #57                                                   * 037A 81 39          .9
           bhi    L036E                                                 * 037C 22 F0          "p
           leax   -$01,X                                                * 037E 30 1F          0.
L0380      lda    ,X+                                                   * 0380 A6 80          &.
           cmpa   #48                                                   * 0382 81 30          .0
           bcs    L038C                                                 * 0384 25 06          %.
           cmpa   #57                                                   * 0386 81 39          .9
           bhi    L038C                                                 * 0388 22 02          ".
           bra    L0380                                                 * 038A 20 F4           t
L038C      pshs   X                                                     * 038C 34 10          4.
           leax   -$01,X                                                * 038E 30 1F          0.
           clr    U0005,U                                               * 0390 6F 45          oE
           clr    U0006,U                                               * 0392 6F 46          oF
           ldd    #1                                                    * 0394 CC 00 01       L..
           std    U0007,U                                               * 0397 ED 47          mG
L0399      lda    ,-X                                                   * 0399 A6 82          &.
           cmpa   #48                                                   * 039B 81 30          .0
           bcs    L03CD                                                 * 039D 25 2E          %.
           cmpa   #57                                                   * 039F 81 39          .9
           bhi    L03CD                                                 * 03A1 22 2A          "*
           suba   #48                                                   * 03A3 80 30          .0
           sta    U0002,U                                               * 03A5 A7 42          'B
           ldd    #0                                                    * 03A7 CC 00 00       L..
L03AA      tst    U0002,U                                               * 03AA 6D 42          mB
           beq    L03B4                                                 * 03AC 27 06          '.
           addd   U0007,U                                               * 03AE E3 47          cG
           dec    U0002,U                                               * 03B0 6A 42          jB
           bra    L03AA                                                 * 03B2 20 F6           v
L03B4      addd   U0005,U                                               * 03B4 E3 45          cE
           std    U0005,U                                               * 03B6 ED 45          mE
           lda    #10                                                   * 03B8 86 0A          ..
           sta    U0002,U                                               * 03BA A7 42          'B
           ldd    #0                                                    * 03BC CC 00 00       L..
L03BF      tst    U0002,U                                               * 03BF 6D 42          mB
           beq    L03C9                                                 * 03C1 27 06          '.
           addd   U0007,U                                               * 03C3 E3 47          cG
           dec    U0002,U                                               * 03C5 6A 42          jB
           bra    L03BF                                                 * 03C7 20 F6           v
L03C9      std    U0007,U                                               * 03C9 ED 47          mG
           bra    L0399                                                 * 03CB 20 CC           L
L03CD      ldd    U0005,U                                               * 03CD EC 45          lE
           puls   X                                                     * 03CF 35 10          5.
           puls   PC,Y                                                  * 03D1 35 A0          5
L03D3      pshs   X                                                     * 03D3 34 10          4.
           std    U0005,U                                               * 03D5 ED 45          mE
           lda    #48                                                   * 03D7 86 30          .0
           sta    0,X                                                   * 03D9 A7 84          '.
           sta    $01,X                                                 * 03DB A7 01          '.
           sta    $02,X                                                 * 03DD A7 02          '.
           sta    $03,X                                                 * 03DF A7 03          '.
           sta    $04,X                                                 * 03E1 A7 04          '.
           ldd    #10000                                                * 03E3 CC 27 10       L'.
           std    U0007,U                                               * 03E6 ED 47          mG
           ldd    U0005,U                                               * 03E8 EC 45          lE
           lbsr   L0432                                                 * 03EA 17 00 45       ..E
           ldd    #1000                                                 * 03ED CC 03 E8       L.h
           std    U0007,U                                               * 03F0 ED 47          mG
           ldd    U0005,U                                               * 03F2 EC 45          lE
           bsr    L0432                                                 * 03F4 8D 3C          .<
           ldd    #100                                                  * 03F6 CC 00 64       L.d
           std    U0007,U                                               * 03F9 ED 47          mG
           ldd    U0005,U                                               * 03FB EC 45          lE
           bsr    L0432                                                 * 03FD 8D 33          .3
           ldd    #10                                                   * 03FF CC 00 0A       L..
           std    U0007,U                                               * 0402 ED 47          mG
           ldd    U0005,U                                               * 0404 EC 45          lE
           bsr    L0432                                                 * 0406 8D 2A          .*
           ldd    #1                                                    * 0408 CC 00 01       L..
           std    U0007,U                                               * 040B ED 47          mG
           ldd    U0005,U                                               * 040D EC 45          lE
           bsr    L0432                                                 * 040F 8D 21          .!
           lda    #13                                                   * 0411 86 0D          ..
           sta    0,X                                                   * 0413 A7 84          '.
           puls   X                                                     * 0415 35 10          5.
           ldb    #32                                                   * 0417 C6 20          F
L0419      lda    0,X                                                   * 0419 A6 84          &.
           cmpa   #48                                                   * 041B 81 30          .0
           bne    L0423                                                 * 041D 26 04          &.
           stb    ,X+                                                   * 041F E7 80          g.
           bra    L0419                                                 * 0421 20 F6           v
L0423      lda    ,X+                                                   * 0423 A6 80          &.
           cmpa   #48                                                   * 0425 81 30          .0
           bcs    L042F                                                 * 0427 25 06          %.
           cmpa   #57                                                   * 0429 81 39          .9
           bhi    L042F                                                 * 042B 22 02          ".
           bra    L0423                                                 * 042D 20 F4           t
L042F      leax   -$01,X                                                * 042F 30 1F          0.
           rts                                                          * 0431 39             9
L0432      subd   U0007,U                                               * 0432 A3 47          #G
           bcs    L043A                                                 * 0434 25 04          %.
           inc    0,X                                                   * 0436 6C 84          l.
           bra    L0432                                                 * 0438 20 F8           x
L043A      addd   U0007,U                                               * 043A E3 47          cG
           std    U0005,U                                               * 043C ED 45          mE
           leax   $01,X                                                 * 043E 30 01          0.
           rts                                                          * 0440 39             9
L0441      ldd    #-1                                                   * 0441 CC FF FF       L..
           puls   PC,Y                                                  * 0444 35 A0          5

           emod
eom        equ    *
           end
