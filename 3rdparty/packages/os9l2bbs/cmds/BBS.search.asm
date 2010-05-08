           nam    BBS.search
           ttl    program module

           ifp1
           use    defsfile
           endc

tylg       set    Prgrm+Objct
atrv       set    ReEnt+rev
rev        set    $01

           mod    eom,name,tylg,atrv,start,size

U0000      rmb    3
U0003      rmb    1
U0004      rmb    1
U0005      rmb    2
U0007      rmb    2
U0009      rmb    6
U000F      rmb    3
U0012      rmb    1
U0013      rmb    2
U0015      rmb    1
U0016      rmb    34
U0038      rmb    1
U0039      rmb    1
U003A      rmb    1
U003B      rmb    1
U003C      rmb    1
U003D      rmb    1
U003E      rmb    1
U003F      rmb    1
U0040      rmb    1
U0041      rmb    64
U0081      rmb    4
U0085      rmb    20
U0099      rmb    30
U00B7      rmb    1
U00B8      rmb    1
U00B9      rmb    1
U00BA      rmb    205
size       equ    .

name       fcs    /BBS.search/                                            * 000D 42 42 53 2E 73 65 61 72 63 E8 BBS.search
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
           fcb    $48                                                   * 0082 48             H
           fcb    $69                                                   * 0083 69             i
           fcb    $67                                                   * 0084 67             g
           fcb    $68                                                   * 0085 68             h
           fcb    $20                                                   * 0086 20
           fcb    $6D                                                   * 0087 6D             m
           fcb    $65                                                   * 0088 65             e
           fcb    $73                                                   * 0089 73             s
           fcb    $73                                                   * 008A 73             s
           fcb    $61                                                   * 008B 61             a
           fcb    $67                                                   * 008C 67             g
           fcb    $65                                                   * 008D 65             e
           fcb    $20                                                   * 008E 20
           fcb    $69                                                   * 008F 69             i
           fcb    $73                                                   * 0090 73             s
           fcb    $20                                                   * 0091 20
           fcb    $23                                                   * 0092 23             #
           fcb    $00                                                   * 0093 00             .
           fcb    $11                                                   * 0094 11             .
L0095      fcb    $45                                                   * 0095 45             E
           fcb    $6E                                                   * 0096 6E             n
           fcb    $74                                                   * 0097 74             t
           fcb    $65                                                   * 0098 65             e
           fcb    $72                                                   * 0099 72             r
           fcb    $20                                                   * 009A 20
           fcb    $73                                                   * 009B 73             s
           fcb    $75                                                   * 009C 75             u
           fcb    $62                                                   * 009D 62             b
           fcb    $6A                                                   * 009E 6A             j
           fcb    $65                                                   * 009F 65             e
           fcb    $63                                                   * 00A0 63             c
           fcb    $74                                                   * 00A1 74             t
           fcb    $20                                                   * 00A2 20
           fcb    $73                                                   * 00A3 73             s
           fcb    $65                                                   * 00A4 65             e
           fcb    $61                                                   * 00A5 61             a
           fcb    $72                                                   * 00A6 72             r
           fcb    $63                                                   * 00A7 63             c
           fcb    $68                                                   * 00A8 68             h
           fcb    $20                                                   * 00A9 20
           fcb    $74                                                   * 00AA 74             t
           fcb    $65                                                   * 00AB 65             e
           fcb    $78                                                   * 00AC 78             x
           fcb    $74                                                   * 00AD 74             t
           fcb    $0D                                                   * 00AE 0D             .
L00AF      fcb    $3E                                                   * 00AF 3E             >
L00B0      fcb    $4D                                                   * 00B0 4D             M
           fcb    $73                                                   * 00B1 73             s
           fcb    $67                                                   * 00B2 67             g
           fcb    $20                                                   * 00B3 20
           fcb    $23                                                   * 00B4 23             #
           fcb    $20                                                   * 00B5 20
           fcb    $20                                                   * 00B6 20
           fcb    $20                                                   * 00B7 20
           fcb    $20                                                   * 00B8 20
           fcb    $55                                                   * 00B9 55             U
           fcb    $73                                                   * 00BA 73             s
           fcb    $65                                                   * 00BB 65             e
           fcb    $72                                                   * 00BC 72             r
           fcb    $20                                                   * 00BD 20
           fcb    $6E                                                   * 00BE 6E             n
           fcb    $61                                                   * 00BF 61             a
           fcb    $6D                                                   * 00C0 6D             m
           fcb    $65                                                   * 00C1 65             e
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
           fcb    $20                                                   * 00CD 20
           fcb    $20                                                   * 00CE 20
           fcb    $20                                                   * 00CF 20
           fcb    $44                                                   * 00D0 44             D
           fcb    $61                                                   * 00D1 61             a
           fcb    $74                                                   * 00D2 74             t
           fcb    $65                                                   * 00D3 65             e
           fcb    $20                                                   * 00D4 20
           fcb    $20                                                   * 00D5 20
           fcb    $20                                                   * 00D6 20
           fcb    $20                                                   * 00D7 20
           fcb    $20                                                   * 00D8 20
           fcb    $20                                                   * 00D9 20
           fcb    $20                                                   * 00DA 20
           fcb    $20                                                   * 00DB 20
           fcb    $53                                                   * 00DC 53             S
           fcb    $75                                                   * 00DD 75             u
           fcb    $62                                                   * 00DE 62             b
           fcb    $6A                                                   * 00DF 6A             j
           fcb    $65                                                   * 00E0 65             e
           fcb    $63                                                   * 00E1 63             c
           fcb    $74                                                   * 00E2 74             t
           fcb    $0D                                                   * 00E3 0D             .
L00E4      fcb    $2D                                                   * 00E4 2D             -
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
           fcb    $2D                                                   * 0121 2D             -
           fcb    $2D                                                   * 0122 2D             -
           fcb    $2D                                                   * 0123 2D             -
           fcb    $0D                                                   * 0124 0D             .
L0125      fcb    $42                                                   * 0125 42             B
           fcb    $42                                                   * 0126 42             B
           fcb    $53                                                   * 0127 53             S
           fcb    $2E                                                   * 0128 2E             .
           fcb    $6D                                                   * 0129 6D             m
           fcb    $73                                                   * 012A 73             s
           fcb    $67                                                   * 012B 67             g
           fcb    $2E                                                   * 012C 2E             .
           fcb    $69                                                   * 012D 69             i
           fcb    $6E                                                   * 012E 6E             n
           fcb    $78                                                   * 012F 78             x
           fcb    $0D                                                   * 0130 0D             .
L0131      fcb    $20                                                   * 0131 20
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
           fcb    $20                                                   * 0155 20
           fcb    $20                                                   * 0156 20
           fcb    $20                                                   * 0157 20
L0158      fcb    $20                                                   * 0158 20
           fcb    $20                                                   * 0159 20
           fcb    $20                                                   * 015A 20
           fcb    $20                                                   * 015B 20
           fcb    $20                                                   * 015C 20
           fcb    $20                                                   * 015D 20
           fcb    $20                                                   * 015E 20
           fcb    $20                                                   * 015F 20
           fcb    $20                                                   * 0160 20
           fcb    $20                                                   * 0161 20
           fcb    $2A                                                   * 0162 2A             *
           fcb    $2A                                                   * 0163 2A             *
           fcb    $2A                                                   * 0164 2A             *
           fcb    $2A                                                   * 0165 2A             *
           fcb    $2A                                                   * 0166 2A             *
           fcb    $2A                                                   * 0167 2A             *
           fcb    $20                                                   * 0168 20
           fcb    $20                                                   * 0169 20
           fcb    $20                                                   * 016A 20
           fcb    $44                                                   * 016B 44             D
           fcb    $45                                                   * 016C 45             E
           fcb    $4C                                                   * 016D 4C             L
           fcb    $45                                                   * 016E 45             E
           fcb    $54                                                   * 016F 54             T
           fcb    $45                                                   * 0170 45             E
           fcb    $44                                                   * 0171 44             D
           fcb    $20                                                   * 0172 20
           fcb    $20                                                   * 0173 20
           fcb    $20                                                   * 0174 20
           fcb    $2A                                                   * 0175 2A             *
           fcb    $2A                                                   * 0176 2A             *
           fcb    $2A                                                   * 0177 2A             *
           fcb    $2A                                                   * 0178 2A             *
           fcb    $2A                                                   * 0179 2A             *
           fcb    $2A                                                   * 017A 2A             *
           fcb    $0D                                                   * 017B 0D             .
start      leax   L0125,PC                                              * 017C 30 8D FF A5    0..%
           lda    #1                                                    * 0180 86 01          ..
           os9    I$Open                                                * 0182 10 3F 84       .?.
           lbcs   L031D                                                 * 0185 10 25 01 94    .%..
           sta    U0000,U                                               * 0189 A7 C4          'D
           leax   <U0041,U                                              * 018B 30 C8 41       0HA
           ldy    #64                                                   * 018E 10 8E 00 40    ...@
           lda    U0000,U                                               * 0192 A6 C4          &D
           os9    I$Read                                                * 0194 10 3F 89       .?.
           lbcs   L031D                                                 * 0197 10 25 01 82    .%..
           ldd    #0                                                    * 019B CC 00 00       L..
           std    U0009,U                                               * 019E ED 49          mI
L01A0      leax   L0095,PC                                              * 01A0 30 8D FE F1    0.~q
           ldy    #200                                                  * 01A4 10 8E 00 C8    ...H
           lda    #1                                                    * 01A8 86 01          ..
           os9    I$WritLn                                              * 01AA 10 3F 8C       .?.
           lbcs   L031D                                                 * 01AD 10 25 01 6C    .%.l
           leax   L00AF,PC                                              * 01B1 30 8D FE FA    0.~z
           ldy    #1                                                    * 01B5 10 8E 00 01    ....
           os9    I$Write                                               * 01B9 10 3F 8A       .?.
           lbcs   L031D                                                 * 01BC 10 25 01 5D    .%.]
           leax   <U0016,U                                              * 01C0 30 C8 16       0H.
           ldy    #30                                                   * 01C3 10 8E 00 1E    ....
           clra                                                         * 01C7 4F             O
           os9    I$ReadLn                                              * 01C8 10 3F 8B       .?.
           bcs    L01A0                                                 * 01CB 25 D3          %S
           clr    <U0015,U                                              * 01CD 6F C8 15       oH.
           leax   <U0016,U                                              * 01D0 30 C8 16       0H.
           leax   L00B0,PC                                              * 01D3 30 8D FE D9    0.~Y
           ldy    #80                                                   * 01D7 10 8E 00 50    ...P
           lda    #1                                                    * 01DB 86 01          ..
           os9    I$WritLn                                              * 01DD 10 3F 8C       .?.
           lbcs   L031D                                                 * 01E0 10 25 01 39    .%.9
           leax   L00E4,PC                                              * 01E4 30 8D FE FC    0.~|
           ldy    #80                                                   * 01E8 10 8E 00 50    ...P
           os9    I$WritLn                                              * 01EC 10 3F 8C       .?.
           lbcs   L031D                                                 * 01EF 10 25 01 2A    .%.*
L01F3      lda    U0000,U                                               * 01F3 A6 C4          &D
           ldy    #64                                                   * 01F5 10 8E 00 40    ...@
           leax   >U0081,U                                              * 01F9 30 C9 00 81    0I..
           os9    I$Read                                                * 01FD 10 3F 89       .?.
           lbcs   L031C                                                 * 0200 10 25 01 18    .%..
           ldd    U0009,U                                               * 0204 EC 49          lI
           addd   #1                                                    * 0206 C3 00 01       C..
           std    U0009,U                                               * 0209 ED 49          mI
           leay   >U0099,U                                              * 020B 31 C9 00 99    1I..
           ldb    #30                                                   * 020F C6 1E          F.
L0211      leax   <U0016,U                                              * 0211 30 C8 16       0H.
L0214      lda    ,X+                                                   * 0214 A6 80          &.
           cmpa   #13                                                   * 0216 81 0D          ..
           beq    L0223                                                 * 0218 27 09          '.
           decb                                                         * 021A 5A             Z
           beq    L01F3                                                 * 021B 27 D6          'V
           cmpa   ,Y+                                                   * 021D A1 A0          !
           bne    L0211                                                 * 021F 26 F0          &p
           bra    L0214                                                 * 0221 20 F1           q
L0223      ldd    >U0081,U                                              * 0223 EC C9 00 81    lI..
           cmpd   #-1                                                   * 0227 10 83 FF FF    ....
           lbeq   L030C                                                 * 022B 10 27 00 DD    .'.]
           ldd    U0009,U                                               * 022F EC 49          lI
           leax   U000F,U                                               * 0231 30 4F          0O
           lbsr   L0387                                                 * 0233 17 01 51       ..Q
           leax   U000F,U                                               * 0236 30 4F          0O
           ldy    #5                                                    * 0238 10 8E 00 05    ....
           lda    #1                                                    * 023C 86 01          ..
           os9    I$Write                                               * 023E 10 3F 8A       .?.
           lbcs   L031D                                                 * 0241 10 25 00 D8    .%.X
           leax   L0131,PC                                              * 0245 30 8D FE E8    0.~h
           ldy    #4                                                    * 0249 10 8E 00 04    ....
           os9    I$Write                                               * 024D 10 3F 8A       .?.
           lbcs   L031D                                                 * 0250 10 25 00 C9    .%.I
           leax   >U0085,U                                              * 0254 30 C9 00 85    0I..
           clr    U0003,U                                               * 0258 6F 43          oC
           clr    U0004,U                                               * 025A 6F 44          oD
L025C      lda    ,X+                                                   * 025C A6 80          &.
           cmpa   #13                                                   * 025E 81 0D          ..
           beq    L0266                                                 * 0260 27 04          '.
           inc    U0004,U                                               * 0262 6C 44          lD
           bra    L025C                                                 * 0264 20 F6           v
L0266      leax   >U0085,U                                              * 0266 30 C9 00 85    0I..
           ldy    U0003,U                                               * 026A 10 AE 43       ..C
           lda    #1                                                    * 026D 86 01          ..
           os9    I$Write                                               * 026F 10 3F 8A       .?.
           lbcs   L031D                                                 * 0272 10 25 00 A7    .%.'
           ldd    #22                                                   * 0276 CC 00 16       L..
           subd   U0003,U                                               * 0279 A3 43          #C
           tfr    D,Y                                                   * 027B 1F 02          ..
           leax   L0131,PC                                              * 027D 30 8D FE B0    0.~0
           lda    #1                                                    * 0281 86 01          ..
           os9    I$Write                                               * 0283 10 3F 8A       .?.
           lbcs   L031D                                                 * 0286 10 25 00 93    .%..
           leax   U000F,U                                               * 028A 30 4F          0O
           ldb    >U00B8,U                                              * 028C E6 C9 00 B8    fI.8
           clra                                                         * 0290 4F             O
           lbsr   L0387                                                 * 0291 17 00 F3       ..s
           lda    <U0012,U                                              * 0294 A6 C8 12       &H.
           sta    <U0038,U                                              * 0297 A7 C8 38       'H8
           lda    <U0013,U                                              * 029A A6 C8 13       &H.
           sta    <U0039,U                                              * 029D A7 C8 39       'H9
           lda    #47                                                   * 02A0 86 2F          ./
           sta    <U003A,U                                              * 02A2 A7 C8 3A       'H:
           ldb    >U00B9,U                                              * 02A5 E6 C9 00 B9    fI.9
           clra                                                         * 02A9 4F             O
           leax   U000F,U                                               * 02AA 30 4F          0O
           lbsr   L0387                                                 * 02AC 17 00 D8       ..X
           lda    <U0012,U                                              * 02AF A6 C8 12       &H.
           sta    <U003B,U                                              * 02B2 A7 C8 3B       'H;
           lda    <U0013,U                                              * 02B5 A6 C8 13       &H.
           sta    <U003C,U                                              * 02B8 A7 C8 3C       'H<
           lda    #47                                                   * 02BB 86 2F          ./
           sta    <U003D,U                                              * 02BD A7 C8 3D       'H=
           ldb    >U00B7,U                                              * 02C0 E6 C9 00 B7    fI.7
           clra                                                         * 02C4 4F             O
           leax   U000F,U                                               * 02C5 30 4F          0O
           lbsr   L0387                                                 * 02C7 17 00 BD       ..=
           lda    <U0012,U                                              * 02CA A6 C8 12       &H.
           sta    <U003E,U                                              * 02CD A7 C8 3E       'H>
           lda    <U0013,U                                              * 02D0 A6 C8 13       &H.
           sta    <U003F,U                                              * 02D3 A7 C8 3F       'H?
           lda    #13                                                   * 02D6 86 0D          ..
           sta    <U0040,U                                              * 02D8 A7 C8 40       'H@
           leax   <U0038,U                                              * 02DB 30 C8 38       0H8
           ldy    #8                                                    * 02DE 10 8E 00 08    ....
           lda    #1                                                    * 02E2 86 01          ..
           os9    I$Write                                               * 02E4 10 3F 8A       .?.
           lbcs   L031D                                                 * 02E7 10 25 00 32    .%.2
           ldy    #5                                                    * 02EB 10 8E 00 05    ....
           leax   L0131,PC                                              * 02EF 30 8D FE 3E    0.~>
           os9    I$Write                                               * 02F3 10 3F 8A       .?.
           lbcs   L031D                                                 * 02F6 10 25 00 23    .%.#
           leax   >U0099,U                                              * 02FA 30 C9 00 99    0I..
           ldy    #30                                                   * 02FE 10 8E 00 1E    ....
           os9    I$WritLn                                              * 0302 10 3F 8C       .?.
           lbcs   L031D                                                 * 0305 10 25 00 14    .%..
           lbra   L01F3                                                 * 0309 16 FE E7       .~g
L030C      leax   L0158,PC                                              * 030C 30 8D FE 48    0.~H
           ldy    #200                                                  * 0310 10 8E 00 C8    ...H
           lda    #1                                                    * 0314 86 01          ..
           os9    I$WritLn                                              * 0316 10 3F 8C       .?.
           lbra   L01F3                                                 * 0319 16 FE D7       .~W
L031C      clrb                                                         * 031C 5F             _
L031D      os9    F$Exit                                                * 031D 10 3F 06       .?.
           fcb    $34                                                   * 0320 34             4
           fcb    $20                                                   * 0321 20
           fcb    $A6                                                   * 0322 A6             &
           fcb    $80                                                   * 0323 80             .
           fcb    $81                                                   * 0324 81             .
           fcb    $0D                                                   * 0325 0D             .
           fcb    $10                                                   * 0326 10             .
           fcb    $27                                                   * 0327 27             '
           fcb    $00                                                   * 0328 00             .
           fcb    $CB                                                   * 0329 CB             K
           fcb    $81                                                   * 032A 81             .
           fcb    $30                                                   * 032B 30             0
           fcb    $25                                                   * 032C 25             %
           fcb    $F4                                                   * 032D F4             t
           fcb    $81                                                   * 032E 81             .
           fcb    $39                                                   * 032F 39             9
           fcb    $22                                                   * 0330 22             "
           fcb    $F0                                                   * 0331 F0             p
           fcb    $30                                                   * 0332 30             0
           fcb    $1F                                                   * 0333 1F             .
           fcb    $A6                                                   * 0334 A6             &
           fcb    $80                                                   * 0335 80             .
           fcb    $81                                                   * 0336 81             .
           fcb    $30                                                   * 0337 30             0
           fcb    $25                                                   * 0338 25             %
           fcb    $06                                                   * 0339 06             .
           fcb    $81                                                   * 033A 81             .
           fcb    $39                                                   * 033B 39             9
           fcb    $22                                                   * 033C 22             "
           fcb    $02                                                   * 033D 02             .
           fcb    $20                                                   * 033E 20
           fcb    $F4                                                   * 033F F4             t
           fcb    $34                                                   * 0340 34             4
           fcb    $10                                                   * 0341 10             .
           fcb    $30                                                   * 0342 30             0
           fcb    $1F                                                   * 0343 1F             .
           fcb    $6F                                                   * 0344 6F             o
           fcb    $45                                                   * 0345 45             E
           fcb    $6F                                                   * 0346 6F             o
           fcb    $46                                                   * 0347 46             F
           fcb    $CC                                                   * 0348 CC             L
           fcb    $00                                                   * 0349 00             .
           fcb    $01                                                   * 034A 01             .
           fcb    $ED                                                   * 034B ED             m
           fcb    $47                                                   * 034C 47             G
           fcb    $A6                                                   * 034D A6             &
           fcb    $82                                                   * 034E 82             .
           fcb    $81                                                   * 034F 81             .
           fcb    $30                                                   * 0350 30             0
           fcb    $25                                                   * 0351 25             %
           fcb    $2E                                                   * 0352 2E             .
           fcb    $81                                                   * 0353 81             .
           fcb    $39                                                   * 0354 39             9
           fcb    $22                                                   * 0355 22             "
           fcb    $2A                                                   * 0356 2A             *
           fcb    $80                                                   * 0357 80             .
           fcb    $30                                                   * 0358 30             0
           fcb    $A7                                                   * 0359 A7             '
           fcb    $42                                                   * 035A 42             B
           fcb    $CC                                                   * 035B CC             L
           fcb    $00                                                   * 035C 00             .
           fcb    $00                                                   * 035D 00             .
           fcb    $6D                                                   * 035E 6D             m
           fcb    $42                                                   * 035F 42             B
           fcb    $27                                                   * 0360 27             '
           fcb    $06                                                   * 0361 06             .
           fcb    $E3                                                   * 0362 E3             c
           fcb    $47                                                   * 0363 47             G
           fcb    $6A                                                   * 0364 6A             j
           fcb    $42                                                   * 0365 42             B
           fcb    $20                                                   * 0366 20
           fcb    $F6                                                   * 0367 F6             v
           fcb    $E3                                                   * 0368 E3             c
           fcb    $45                                                   * 0369 45             E
           fcb    $ED                                                   * 036A ED             m
           fcb    $45                                                   * 036B 45             E
           fcb    $86                                                   * 036C 86             .
           fcb    $0A                                                   * 036D 0A             .
           fcb    $A7                                                   * 036E A7             '
           fcb    $42                                                   * 036F 42             B
           fcb    $CC                                                   * 0370 CC             L
           fcb    $00                                                   * 0371 00             .
           fcb    $00                                                   * 0372 00             .
           fcb    $6D                                                   * 0373 6D             m
           fcb    $42                                                   * 0374 42             B
           fcb    $27                                                   * 0375 27             '
           fcb    $06                                                   * 0376 06             .
           fcb    $E3                                                   * 0377 E3             c
           fcb    $47                                                   * 0378 47             G
           fcb    $6A                                                   * 0379 6A             j
           fcb    $42                                                   * 037A 42             B
           fcb    $20                                                   * 037B 20
           fcb    $F6                                                   * 037C F6             v
           fcb    $ED                                                   * 037D ED             m
           fcb    $47                                                   * 037E 47             G
           fcb    $20                                                   * 037F 20
           fcb    $CC                                                   * 0380 CC             L
           fcb    $EC                                                   * 0381 EC             l
           fcb    $45                                                   * 0382 45             E
           fcb    $35                                                   * 0383 35             5
           fcb    $10                                                   * 0384 10             .
           fcb    $35                                                   * 0385 35             5
           fcb    $A0                                                   * 0386 A0
L0387      pshs   X                                                     * 0387 34 10          4.
           std    U0005,U                                               * 0389 ED 45          mE
           lda    #48                                                   * 038B 86 30          .0
           sta    0,X                                                   * 038D A7 84          '.
           sta    $01,X                                                 * 038F A7 01          '.
           sta    $02,X                                                 * 0391 A7 02          '.
           sta    $03,X                                                 * 0393 A7 03          '.
           sta    $04,X                                                 * 0395 A7 04          '.
           ldd    #10000                                                * 0397 CC 27 10       L'.
           std    U0007,U                                               * 039A ED 47          mG
           ldd    U0005,U                                               * 039C EC 45          lE
           lbsr   L03E6                                                 * 039E 17 00 45       ..E
           ldd    #1000                                                 * 03A1 CC 03 E8       L.h
           std    U0007,U                                               * 03A4 ED 47          mG
           ldd    U0005,U                                               * 03A6 EC 45          lE
           bsr    L03E6                                                 * 03A8 8D 3C          .<
           ldd    #100                                                  * 03AA CC 00 64       L.d
           std    U0007,U                                               * 03AD ED 47          mG
           ldd    U0005,U                                               * 03AF EC 45          lE
           bsr    L03E6                                                 * 03B1 8D 33          .3
           ldd    #10                                                   * 03B3 CC 00 0A       L..
           std    U0007,U                                               * 03B6 ED 47          mG
           ldd    U0005,U                                               * 03B8 EC 45          lE
           bsr    L03E6                                                 * 03BA 8D 2A          .*
           ldd    #1                                                    * 03BC CC 00 01       L..
           std    U0007,U                                               * 03BF ED 47          mG
           ldd    U0005,U                                               * 03C1 EC 45          lE
           bsr    L03E6                                                 * 03C3 8D 21          .!
           lda    #13                                                   * 03C5 86 0D          ..
           sta    0,X                                                   * 03C7 A7 84          '.
           puls   X                                                     * 03C9 35 10          5.
           ldb    #32                                                   * 03CB C6 20          F
L03CD      lda    0,X                                                   * 03CD A6 84          &.
           cmpa   #48                                                   * 03CF 81 30          .0
           bne    L03D7                                                 * 03D1 26 04          &.
           stb    ,X+                                                   * 03D3 E7 80          g.
           bra    L03CD                                                 * 03D5 20 F6           v
L03D7      lda    ,X+                                                   * 03D7 A6 80          &.
           cmpa   #48                                                   * 03D9 81 30          .0
           bcs    L03E3                                                 * 03DB 25 06          %.
           cmpa   #57                                                   * 03DD 81 39          .9
           bhi    L03E3                                                 * 03DF 22 02          ".
           bra    L03D7                                                 * 03E1 20 F4           t
L03E3      leax   -$01,X                                                * 03E3 30 1F          0.
           rts                                                          * 03E5 39             9
L03E6      subd   U0007,U                                               * 03E6 A3 47          #G
           bcs    L03EE                                                 * 03E8 25 04          %.
           inc    0,X                                                   * 03EA 6C 84          l.
           bra    L03E6                                                 * 03EC 20 F8           x
L03EE      addd   U0007,U                                               * 03EE E3 47          cG
           std    U0005,U                                               * 03F0 ED 45          mE
           leax   $01,X                                                 * 03F2 30 01          0.
           rts                                                          * 03F4 39             9
           fcb    $CC                                                   * 03F5 CC             L
           fcb    $FF                                                   * 03F6 FF             .
           fcb    $FF                                                   * 03F7 FF             .
           fcb    $35                                                   * 03F8 35             5
           fcb    $A0                                                   * 03F9 A0

           emod
eom        equ    *
           end
