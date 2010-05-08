           nam    BBS.reply
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
U0007      rmb    1
U0008      rmb    2
U000A      rmb    2
U000C      rmb    1
U000D      rmb    1
U000E      rmb    1
U000F      rmb    1
U0010      rmb    2
U0012      rmb    2
U0014      rmb    2
U0016      rmb    1
U0017      rmb    1
U0018      rmb    2
U001A      rmb    2
U001C      rmb    200
U00E4      rmb    1
U00E5      rmb    5
U00EA      rmb    1
U00EB      rmb    2
U00ED      rmb    2
U00EF      rmb    60
U012B      rmb    2
U012D      rmb    2
U012F      rmb    20
U0143      rmb    30
U0161      rmb    6
U0167      rmb    2
U0169      rmb    2
U016B      rmb    2
U016D      rmb    2
U016F      rmb    6
U0175      rmb    2
U0177      rmb    2
U0179      rmb    2
U017B      rmb    16
U018B      rmb    8000
U20CB      rmb    80
U211B      rmb    32
U213B      rmb    1
U213C      rmb    399
size       equ    .

name       fcs    /BBS.reply/                                            * 000D 42 42 53 2E 72 65 70 6C F9 BBS.reply
           fcb    $43                                                   * 0016 43             C
           fcb    $6F                                                   * 0017 6F             o
           fcb    $70                                                   * 0018 70             p
           fcb    $79                                                   * 0019 79             y
           fcb    $72                                                   * 001A 72             r
           fcb    $69                                                   * 001B 69             i
           fcb    $67                                                   * 001C 67             g
           fcb    $68                                                   * 001D 68             h
           fcb    $74                                                   * 001E 74             t
           fcb    $20                                                   * 001F 20
           fcb    $28                                                   * 0020 28             (
           fcb    $43                                                   * 0021 43             C
           fcb    $29                                                   * 0022 29             )
           fcb    $20                                                   * 0023 20
           fcb    $31                                                   * 0024 31             1
           fcb    $39                                                   * 0025 39             9
           fcb    $38                                                   * 0026 38             8
           fcb    $38                                                   * 0027 38             8
           fcb    $42                                                   * 0028 42             B
           fcb    $79                                                   * 0029 79             y
           fcb    $20                                                   * 002A 20
           fcb    $4B                                                   * 002B 4B             K
           fcb    $65                                                   * 002C 65             e
           fcb    $69                                                   * 002D 69             i
           fcb    $74                                                   * 002E 74             t
           fcb    $68                                                   * 002F 68             h
           fcb    $20                                                   * 0030 20
           fcb    $41                                                   * 0031 41             A
           fcb    $6C                                                   * 0032 6C             l
           fcb    $70                                                   * 0033 70             p
           fcb    $68                                                   * 0034 68             h
           fcb    $6F                                                   * 0035 6F             o
           fcb    $6E                                                   * 0036 6E             n
           fcb    $73                                                   * 0037 73             s
           fcb    $6F                                                   * 0038 6F             o
           fcb    $4C                                                   * 0039 4C             L
           fcb    $69                                                   * 003A 69             i
           fcb    $63                                                   * 003B 63             c
           fcb    $65                                                   * 003C 65             e
           fcb    $6E                                                   * 003D 6E             n
           fcb    $63                                                   * 003E 63             c
           fcb    $65                                                   * 003F 65             e
           fcb    $64                                                   * 0040 64             d
           fcb    $20                                                   * 0041 20
           fcb    $74                                                   * 0042 74             t
           fcb    $6F                                                   * 0043 6F             o
           fcb    $20                                                   * 0044 20
           fcb    $41                                                   * 0045 41             A
           fcb    $6C                                                   * 0046 6C             l
           fcb    $70                                                   * 0047 70             p
           fcb    $68                                                   * 0048 68             h
           fcb    $61                                                   * 0049 61             a
           fcb    $20                                                   * 004A 20
           fcb    $53                                                   * 004B 53             S
           fcb    $6F                                                   * 004C 6F             o
           fcb    $66                                                   * 004D 66             f
           fcb    $74                                                   * 004E 74             t
           fcb    $77                                                   * 004F 77             w
           fcb    $61                                                   * 0050 61             a
           fcb    $72                                                   * 0051 72             r
           fcb    $65                                                   * 0052 65             e
           fcb    $20                                                   * 0053 20
           fcb    $54                                                   * 0054 54             T
           fcb    $65                                                   * 0055 65             e
           fcb    $63                                                   * 0056 63             c
           fcb    $68                                                   * 0057 68             h
           fcb    $6E                                                   * 0058 6E             n
           fcb    $6F                                                   * 0059 6F             o
           fcb    $6C                                                   * 005A 6C             l
           fcb    $6F                                                   * 005B 6F             o
           fcb    $67                                                   * 005C 67             g
           fcb    $69                                                   * 005D 69             i
           fcb    $65                                                   * 005E 65             e
           fcb    $73                                                   * 005F 73             s
           fcb    $41                                                   * 0060 41             A
           fcb    $6C                                                   * 0061 6C             l
           fcb    $6C                                                   * 0062 6C             l
           fcb    $20                                                   * 0063 20
           fcb    $72                                                   * 0064 72             r
           fcb    $69                                                   * 0065 69             i
           fcb    $67                                                   * 0066 67             g
           fcb    $68                                                   * 0067 68             h
           fcb    $74                                                   * 0068 74             t
           fcb    $73                                                   * 0069 73             s
           fcb    $20                                                   * 006A 20
           fcb    $72                                                   * 006B 72             r
           fcb    $65                                                   * 006C 65             e
           fcb    $73                                                   * 006D 73             s
           fcb    $65                                                   * 006E 65             e
           fcb    $72                                                   * 006F 72             r
           fcb    $76                                                   * 0070 76             v
           fcb    $65                                                   * 0071 65             e
           fcb    $64                                                   * 0072 64             d
           fcb    $EC                                                   * 0073 EC             l
           fcb    $E6                                                   * 0074 E6             f
           fcb    $EA                                                   * 0075 EA             j
           fcb    $F5                                                   * 0076 F5             u
           fcb    $E9                                                   * 0077 E9             i
           fcb    $A0                                                   * 0078 A0
           fcb    $E2                                                   * 0079 E2             b
           fcb    $ED                                                   * 007A ED             m
           fcb    $F1                                                   * 007B F1             q
           fcb    $E9                                                   * 007C E9             i
           fcb    $F0                                                   * 007D F0             p
           fcb    $EF                                                   * 007E EF             o
           fcb    $F4                                                   * 007F F4             t
           fcb    $F0                                                   * 0080 F0             p
L0081      fcb    $42                                                   * 0081 42             B
           fcb    $42                                                   * 0082 42             B
           fcb    $53                                                   * 0083 53             S
           fcb    $2E                                                   * 0084 2E             .
           fcb    $6D                                                   * 0085 6D             m
           fcb    $73                                                   * 0086 73             s
           fcb    $67                                                   * 0087 67             g
           fcb    $2E                                                   * 0088 2E             .
           fcb    $69                                                   * 0089 69             i
           fcb    $6E                                                   * 008A 6E             n
           fcb    $78                                                   * 008B 78             x
           fcb    $0D                                                   * 008C 0D             .
L008D      fcb    $42                                                   * 008D 42             B
           fcb    $42                                                   * 008E 42             B
           fcb    $53                                                   * 008F 53             S
           fcb    $2E                                                   * 0090 2E             .
           fcb    $6D                                                   * 0091 6D             m
           fcb    $73                                                   * 0092 73             s
           fcb    $67                                                   * 0093 67             g
           fcb    $0D                                                   * 0094 0D             .
           fcb    $0A                                                   * 0095 0A             .
           fcb    $45                                                   * 0096 45             E
           fcb    $6E                                                   * 0097 6E             n
           fcb    $74                                                   * 0098 74             t
           fcb    $65                                                   * 0099 65             e
           fcb    $72                                                   * 009A 72             r
           fcb    $20                                                   * 009B 20
           fcb    $73                                                   * 009C 73             s
           fcb    $75                                                   * 009D 75             u
           fcb    $62                                                   * 009E 62             b
           fcb    $6A                                                   * 009F 6A             j
           fcb    $65                                                   * 00A0 65             e
           fcb    $63                                                   * 00A1 63             c
           fcb    $74                                                   * 00A2 74             t
           fcb    $20                                                   * 00A3 20
           fcb    $6F                                                   * 00A4 6F             o
           fcb    $66                                                   * 00A5 66             f
           fcb    $20                                                   * 00A6 20
           fcb    $6D                                                   * 00A7 6D             m
           fcb    $65                                                   * 00A8 65             e
           fcb    $73                                                   * 00A9 73             s
           fcb    $73                                                   * 00AA 73             s
           fcb    $61                                                   * 00AB 61             a
           fcb    $67                                                   * 00AC 67             g
           fcb    $65                                                   * 00AD 65             e
           fcb    $0D                                                   * 00AE 0D             .
           fcb    $0A                                                   * 00AF 0A             .
           fcb    $3E                                                   * 00B0 3E             >
           fcb    $00                                                   * 00B1 00             .
           fcb    $1C                                                   * 00B2 1C             .
L00B3      fcb    $0A                                                   * 00B3 0A             .
           fcb    $0A                                                   * 00B4 0A             .
           fcb    $20                                                   * 00B5 20
           fcb    $20                                                   * 00B6 20
           fcb    $20                                                   * 00B7 20
           fcb    $20                                                   * 00B8 20
           fcb    $50                                                   * 00B9 50             P
           fcb    $6C                                                   * 00BA 6C             l
           fcb    $65                                                   * 00BB 65             e
           fcb    $61                                                   * 00BC 61             a
           fcb    $73                                                   * 00BD 73             s
           fcb    $65                                                   * 00BE 65             e
           fcb    $20                                                   * 00BF 20
           fcb    $65                                                   * 00C0 65             e
           fcb    $6E                                                   * 00C1 6E             n
           fcb    $74                                                   * 00C2 74             t
           fcb    $65                                                   * 00C3 65             e
           fcb    $72                                                   * 00C4 72             r
           fcb    $20                                                   * 00C5 20
           fcb    $6D                                                   * 00C6 6D             m
           fcb    $65                                                   * 00C7 65             e
           fcb    $73                                                   * 00C8 73             s
           fcb    $73                                                   * 00C9 73             s
           fcb    $61                                                   * 00CA 61             a
           fcb    $67                                                   * 00CB 67             g
           fcb    $65                                                   * 00CC 65             e
           fcb    $20                                                   * 00CD 20
           fcb    $6E                                                   * 00CE 6E             n
           fcb    $6F                                                   * 00CF 6F             o
           fcb    $77                                                   * 00D0 77             w
           fcb    $20                                                   * 00D1 20
           fcb    $20                                                   * 00D2 20
           fcb    $20                                                   * 00D3 20
           fcb    $20                                                   * 00D4 20
           fcb    $20                                                   * 00D5 20
           fcb    $20                                                   * 00D6 20
           fcb    $20                                                   * 00D7 20
           fcb    $20                                                   * 00D8 20
           fcb    $20                                                   * 00D9 20
           fcb    $20                                                   * 00DA 20
           fcb    $20                                                   * 00DB 20
           fcb    $20                                                   * 00DC 20
           fcb    $28                                                   * 00DD 28             (
           fcb    $42                                                   * 00DE 42             B
           fcb    $6C                                                   * 00DF 6C             l
           fcb    $61                                                   * 00E0 61             a
           fcb    $6E                                                   * 00E1 6E             n
           fcb    $6B                                                   * 00E2 6B             k
           fcb    $20                                                   * 00E3 20
           fcb    $6C                                                   * 00E4 6C             l
           fcb    $69                                                   * 00E5 69             i
           fcb    $6E                                                   * 00E6 6E             n
           fcb    $65                                                   * 00E7 65             e
           fcb    $20                                                   * 00E8 20
           fcb    $65                                                   * 00E9 65             e
           fcb    $6E                                                   * 00EA 6E             n
           fcb    $64                                                   * 00EB 64             d
           fcb    $73                                                   * 00EC 73             s
           fcb    $29                                                   * 00ED 29             )
           fcb    $0D                                                   * 00EE 0D             .
L00EF      fcb    $2D                                                   * 00EF 2D             -
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
           fcb    $2D                                                   * 0124 2D             -
           fcb    $2D                                                   * 0125 2D             -
           fcb    $2D                                                   * 0126 2D             -
           fcb    $2D                                                   * 0127 2D             -
           fcb    $2D                                                   * 0128 2D             -
           fcb    $2D                                                   * 0129 2D             -
           fcb    $2D                                                   * 012A 2D             -
           fcb    $2D                                                   * 012B 2D             -
           fcb    $2D                                                   * 012C 2D             -
           fcb    $2D                                                   * 012D 2D             -
           fcb    $2D                                                   * 012E 2D             -
           fcb    $0D                                                   * 012F 0D             .
L0130      fcb    $2F                                                   * 0130 2F             /
           fcb    $64                                                   * 0131 64             d
           fcb    $64                                                   * 0132 64             d
           fcb    $2F                                                   * 0133 2F             /
           fcb    $62                                                   * 0134 62             b
           fcb    $62                                                   * 0135 62             b
           fcb    $73                                                   * 0136 73             s
           fcb    $2F                                                   * 0137 2F             /
           fcb    $42                                                   * 0138 42             B
           fcb    $42                                                   * 0139 42             B
           fcb    $53                                                   * 013A 53             S
           fcb    $2E                                                   * 013B 2E             .
           fcb    $61                                                   * 013C 61             a
           fcb    $6C                                                   * 013D 6C             l
           fcb    $69                                                   * 013E 69             i
           fcb    $61                                                   * 013F 61             a
           fcb    $73                                                   * 0140 73             s
           fcb    $0D                                                   * 0141 0D             .
L0142      fcb    $0A                                                   * 0142 0A             .
           fcb    $5B                                                   * 0143 5B             [
           fcb    $41                                                   * 0144 41             A
           fcb    $5D                                                   * 0145 5D             ]
           fcb    $62                                                   * 0146 62             b
           fcb    $6F                                                   * 0147 6F             o
           fcb    $72                                                   * 0148 72             r
           fcb    $74                                                   * 0149 74             t
           fcb    $20                                                   * 014A 20
           fcb    $5B                                                   * 014B 5B             [
           fcb    $44                                                   * 014C 44             D
           fcb    $5D                                                   * 014D 5D             ]
           fcb    $6F                                                   * 014E 6F             o
           fcb    $6E                                                   * 014F 6E             n
           fcb    $65                                                   * 0150 65             e
           fcb    $20                                                   * 0151 20
           fcb    $5B                                                   * 0152 5B             [
           fcb    $45                                                   * 0153 45             E
           fcb    $5D                                                   * 0154 5D             ]
           fcb    $64                                                   * 0155 64             d
           fcb    $69                                                   * 0156 69             i
           fcb    $74                                                   * 0157 74             t
           fcb    $20                                                   * 0158 20
           fcb    $5B                                                   * 0159 5B             [
           fcb    $43                                                   * 015A 43             C
           fcb    $5D                                                   * 015B 5D             ]
           fcb    $6F                                                   * 015C 6F             o
           fcb    $6E                                                   * 015D 6E             n
           fcb    $74                                                   * 015E 74             t
           fcb    $69                                                   * 015F 69             i
           fcb    $6E                                                   * 0160 6E             n
           fcb    $75                                                   * 0161 75             u
           fcb    $65                                                   * 0162 65             e
           fcb    $20                                                   * 0163 20
           fcb    $6F                                                   * 0164 6F             o
           fcb    $72                                                   * 0165 72             r
           fcb    $20                                                   * 0166 20
           fcb    $5B                                                   * 0167 5B             [
           fcb    $4C                                                   * 0168 4C             L
           fcb    $5D                                                   * 0169 5D             ]
           fcb    $69                                                   * 016A 69             i
           fcb    $73                                                   * 016B 73             s
           fcb    $74                                                   * 016C 74             t
           fcb    $0D                                                   * 016D 0D             .
L016E      fcb    $45                                                   * 016E 45             E
           fcb    $6E                                                   * 016F 6E             n
           fcb    $74                                                   * 0170 74             t
           fcb    $65                                                   * 0171 65             e
           fcb    $72                                                   * 0172 72             r
           fcb    $20                                                   * 0173 20
           fcb    $6C                                                   * 0174 6C             l
           fcb    $69                                                   * 0175 69             i
           fcb    $6E                                                   * 0176 6E             n
           fcb    $65                                                   * 0177 65             e
           fcb    $20                                                   * 0178 20
           fcb    $23                                                   * 0179 23             #
           fcb    $0D                                                   * 017A 0D             .
L017B      fcb    $3E                                                   * 017B 3E             >
L017C      fcb    $0A                                                   * 017C 0A             .
           fcb    $0D                                                   * 017D 0D             .
L017E      fcb    $08                                                   * 017E 08             .
           fcb    $20                                                   * 017F 20
           fcb    $08                                                   * 0180 08             .
L0181      fcb    $2F                                                   * 0181 2F             /
           fcb    $64                                                   * 0182 64             d
           fcb    $64                                                   * 0183 64             d
           fcb    $2F                                                   * 0184 2F             /
           fcb    $62                                                   * 0185 62             b
           fcb    $62                                                   * 0186 62             b
           fcb    $73                                                   * 0187 73             s
           fcb    $2F                                                   * 0188 2F             /
           fcb    $42                                                   * 0189 42             B
           fcb    $42                                                   * 018A 42             B
           fcb    $53                                                   * 018B 53             S
           fcb    $2E                                                   * 018C 2E             .
           fcb    $75                                                   * 018D 75             u
           fcb    $73                                                   * 018E 73             s
           fcb    $65                                                   * 018F 65             e
           fcb    $72                                                   * 0190 72             r
           fcb    $73                                                   * 0191 73             s
           fcb    $74                                                   * 0192 74             t
           fcb    $61                                                   * 0193 61             a
           fcb    $74                                                   * 0194 74             t
           fcb    $73                                                   * 0195 73             s
           fcb    $0D                                                   * 0196 0D             .
L0197      fcb    $55                                                   * 0197 55             U
           fcb    $73                                                   * 0198 73             s
           fcb    $65                                                   * 0199 65             e
           fcb    $72                                                   * 019A 72             r
           fcb    $20                                                   * 019B 20
           fcb    $6E                                                   * 019C 6E             n
           fcb    $61                                                   * 019D 61             a
           fcb    $6D                                                   * 019E 6D             m
           fcb    $65                                                   * 019F 65             e
           fcb    $20                                                   * 01A0 20
           fcb    $6E                                                   * 01A1 6E             n
           fcb    $6F                                                   * 01A2 6F             o
           fcb    $74                                                   * 01A3 74             t
           fcb    $20                                                   * 01A4 20
           fcb    $66                                                   * 01A5 66             f
           fcb    $6F                                                   * 01A6 6F             o
           fcb    $75                                                   * 01A7 75             u
           fcb    $6E                                                   * 01A8 6E             n
           fcb    $64                                                   * 01A9 64             d
           fcb    $21                                                   * 01AA 21             !
           fcb    $0D                                                   * 01AB 0D             .
L01AC      fcb    $41                                                   * 01AC 41             A
           fcb    $64                                                   * 01AD 64             d
           fcb    $64                                                   * 01AE 64             d
           fcb    $72                                                   * 01AF 72             r
           fcb    $65                                                   * 01B0 65             e
           fcb    $73                                                   * 01B1 73             s
           fcb    $73                                                   * 01B2 73             s
           fcb    $20                                                   * 01B3 20
           fcb    $6D                                                   * 01B4 6D             m
           fcb    $65                                                   * 01B5 65             e
           fcb    $73                                                   * 01B6 73             s
           fcb    $73                                                   * 01B7 73             s
           fcb    $61                                                   * 01B8 61             a
           fcb    $67                                                   * 01B9 67             g
           fcb    $65                                                   * 01BA 65             e
           fcb    $20                                                   * 01BB 20
           fcb    $74                                                   * 01BC 74             t
           fcb    $6F                                                   * 01BD 6F             o
           fcb    $20                                                   * 01BE 20
           fcb    $28                                                   * 01BF 28             (
           fcb    $42                                                   * 01C0 42             B
           fcb    $4C                                                   * 01C1 4C             L
           fcb    $41                                                   * 01C2 41             A
           fcb    $4E                                                   * 01C3 4E             N
           fcb    $4B                                                   * 01C4 4B             K
           fcb    $20                                                   * 01C5 20
           fcb    $66                                                   * 01C6 66             f
           fcb    $6F                                                   * 01C7 6F             o
           fcb    $72                                                   * 01C8 72             r
           fcb    $20                                                   * 01C9 20
           fcb    $41                                                   * 01CA 41             A
           fcb    $4C                                                   * 01CB 4C             L
           fcb    $4C                                                   * 01CC 4C             L
           fcb    $29                                                   * 01CD 29             )
           fcb    $0D                                                   * 01CE 0D             .
           fcb    $0A                                                   * 01CF 0A             .
start      stx    U0008,U                                               * 01D0 AF 48          /H
           clr    >U00EA,U                                              * 01D2 6F C9 00 EA    oI.j
           clr    >U00E4,U                                              * 01D6 6F C9 00 E4    oI.d
           clr    U0006,U                                               * 01DA 6F 46          oF
           os9    F$ID                                                  * 01DC 10 3F 0C       .?.
           lbcs   L063B                                                 * 01DF 10 25 04 58    .%.X
           sty    U000A,U                                               * 01E3 10 AF 4A       ./J
           ldy    #0                                                    * 01E6 10 8E 00 00    ....
           os9    F$SUser                                               * 01EA 10 3F 1C       .?.
           lbcs   L063B                                                 * 01ED 10 25 04 4A    .%.J
           leax   L0081,PC                                              * 01F1 30 8D FE 8C    0.~.
           lda    #3                                                    * 01F5 86 03          ..
           os9    I$Open                                                * 01F7 10 3F 84       .?.
           lbcs   L063B                                                 * 01FA 10 25 04 3D    .%.=
           sta    U0000,U                                               * 01FE A7 C4          'D
           leax   >U00EB,U                                              * 0200 30 C9 00 EB    0I.k
           ldy    #64                                                   * 0204 10 8E 00 40    ...@
           lda    U0000,U                                               * 0208 A6 C4          &D
           os9    I$Read                                                * 020A 10 3F 89       .?.
           lbcs   L063B                                                 * 020D 10 25 04 2A    .%.*
           lda    #6                                                    * 0211 86 06          ..
           sta    U0003,U                                               * 0213 A7 43          'C
           ldd    >U00EB,U                                              * 0215 EC C9 00 EB    lI.k
           addd   #1                                                    * 0219 C3 00 01       C..
           std    >U00EB,U                                              * 021C ED C9 00 EB    mI.k
           clr    U000E,U                                               * 0220 6F 4E          oN
           clr    U000F,U                                               * 0222 6F 4F          oO
L0224      aslb                                                         * 0224 58             X
           rola                                                         * 0225 49             I
           rol    U000F,U                                               * 0226 69 4F          iO
           dec    U0003,U                                               * 0228 6A 43          jC
           bne    L0224                                                 * 022A 26 F8          &x
           std    <U0010,U                                              * 022C ED C8 10       mH.
           lda    U0000,U                                               * 022F A6 C4          &D
           ldx    U000E,U                                               * 0231 AE 4E          .N
           pshs   U                                                     * 0233 34 40          4@
           ldu    <U0010,U                                              * 0235 EE C8 10       nH.
           os9    I$Seek                                                * 0238 10 3F 88       .?.
           lbcs   L063B                                                 * 023B 10 25 03 FC    .%.|
           puls   U                                                     * 023F 35 40          5@
           leax   >U0161,U                                              * 0241 30 C9 01 61    0I.a
           os9    F$Time                                                * 0245 10 3F 15       .?.
           ldx    U0008,U                                               * 0248 AE 48          .H
           leay   >U0143,U                                              * 024A 31 C9 01 43    1I.C
           ldb    #30                                                   * 024E C6 1E          F.
L0250      lda    ,X+                                                   * 0250 A6 80          &.
           sta    ,Y+                                                   * 0252 A7 A0          '
           cmpa   #13                                                   * 0254 81 0D          ..
           beq    L025B                                                 * 0256 27 03          '.
           decb                                                         * 0258 5A             Z
           bne    L0250                                                 * 0259 26 F5          &u
L025B      leax   L0130,PC                                              * 025B 30 8D FE D1    0.~Q
           lda    #1                                                    * 025F 86 01          ..
           os9    I$Open                                                * 0261 10 3F 84       .?.
           lbcs   L063B                                                 * 0264 10 25 03 D3    .%.S
           sta    U0002,U                                               * 0268 A7 42          'B
L026A      leax   L01AC,PC                                              * 026A 30 8D FF 3E    0..>
           ldy    #36                                                   * 026E 10 8E 00 24    ...$
           lda    #1                                                    * 0272 86 01          ..
           os9    I$Write                                               * 0274 10 3F 8A       .?.
           leax   >U213B,U                                              * 0277 30 C9 21 3B    0I!;
           ldy    #200                                                  * 027B 10 8E 00 C8    ...H
           clra                                                         * 027F 4F             O
           os9    I$ReadLn                                              * 0280 10 3F 8B       .?.
           cmpy   #1                                                    * 0283 10 8C 00 01    ....
           ble    L02F1                                                 * 0287 2F 68          /h
L0289      lda    ,X+                                                   * 0289 A6 80          &.
           anda   #223                                                  * 028B 84 DF          ._
           sta    -$01,X                                                * 028D A7 1F          '.
           cmpa   #13                                                   * 028F 81 0D          ..
           bne    L0289                                                 * 0291 26 F6          &v
L0293      leax   <U001C,U                                              * 0293 30 C8 1C       0H.
           ldy    #200                                                  * 0296 10 8E 00 C8    ...H
           lda    U0002,U                                               * 029A A6 42          &B
           os9    I$ReadLn                                              * 029C 10 3F 8B       .?.
           bcs    L02D4                                                 * 029F 25 33          %3
           leay   >U213B,U                                              * 02A1 31 C9 21 3B    1I!;
           leax   <U001C,U                                              * 02A5 30 C8 1C       0H.
L02A8      lda    ,X+                                                   * 02A8 A6 80          &.
           cmpa   #44                                                   * 02AA 81 2C          .,
           beq    L02B6                                                 * 02AC 27 08          '.
           anda   #223                                                  * 02AE 84 DF          ._
           cmpa   ,Y+                                                   * 02B0 A1 A0          !
           bne    L0293                                                 * 02B2 26 DF          &_
           bra    L02A8                                                 * 02B4 20 F2           r
L02B6      lda    ,Y+                                                   * 02B6 A6 A0          &
           cmpa   #13                                                   * 02B8 81 0D          ..
           bne    L0293                                                 * 02BA 26 D7          &W
           lbsr   L07D2                                                 * 02BC 17 05 13       ...
           std    >U0169,U                                              * 02BF ED C9 01 69    mI.i
           lda    U0002,U                                               * 02C3 A6 42          &B
           pshs   U                                                     * 02C5 34 40          4@
           ldu    #0                                                    * 02C7 CE 00 00       N..
           ldx    #0                                                    * 02CA 8E 00 00       ...
           os9    I$Seek                                                * 02CD 10 3F 88       .?.
           puls   U                                                     * 02D0 35 40          5@
           bra    L02F8                                                 * 02D2 20 24           $
L02D4      leax   L0197,PC                                              * 02D4 30 8D FE BF    0.~?
           ldy    #200                                                  * 02D8 10 8E 00 C8    ...H
           lda    #1                                                    * 02DC 86 01          ..
           os9    I$WritLn                                              * 02DE 10 3F 8C       .?.
           lda    U0002,U                                               * 02E1 A6 42          &B
           pshs   U                                                     * 02E3 34 40          4@
           ldu    #0                                                    * 02E5 CE 00 00       N..
           ldx    #0                                                    * 02E8 8E 00 00       ...
           os9    I$Seek                                                * 02EB 10 3F 88       .?.
           lbra   L026A                                                 * 02EE 16 FF 79       ..y
L02F1      ldd    #-1                                                   * 02F1 CC FF FF       L..
           std    >U0169,U                                              * 02F4 ED C9 01 69    mI.i
L02F8      leax   L00B3,PC                                              * 02F8 30 8D FD B7    0.}7
           ldy    #200                                                  * 02FC 10 8E 00 C8    ...H
           lda    #1                                                    * 0300 86 01          ..
           os9    I$WritLn                                              * 0302 10 3F 8C       .?.
           lbcs   L063B                                                 * 0305 10 25 03 32    .%.2
           leax   L00EF,PC                                              * 0309 30 8D FD E2    0.}b
           ldy    #80                                                   * 030D 10 8E 00 50    ...P
           os9    I$WritLn                                              * 0311 10 3F 8C       .?.
           lbcs   L063B                                                 * 0314 10 25 03 23    .%.#
           ldd    #0                                                    * 0318 CC 00 00       L..
           std    U000C,U                                               * 031B ED 4C          mL
L031D      ldd    U000C,U                                               * 031D EC 4C          lL
           addd   #1                                                    * 031F C3 00 01       C..
           std    U000C,U                                               * 0322 ED 4C          mL
           cmpd   #99                                                   * 0324 10 83 00 63    ...c
           bge    L0335                                                 * 0328 2C 0B          ,.
           lbsr   L0432                                                 * 032A 17 01 05       ...
           cmpy   #1                                                    * 032D 10 8C 00 01    ....
           bls    L0335                                                 * 0331 23 02          #.
           bra    L031D                                                 * 0333 20 E8           h
L0335      leax   L0142,PC                                              * 0335 30 8D FE 09    0.~.
           ldy    #200                                                  * 0339 10 8E 00 C8    ...H
           lda    #1                                                    * 033D 86 01          ..
           os9    I$WritLn                                              * 033F 10 3F 8C       .?.
           leax   L017B,PC                                              * 0342 30 8D FE 35    0.~5
           ldy    #1                                                    * 0346 10 8E 00 01    ....
           os9    I$Write                                               * 034A 10 3F 8A       .?.
           leax   U0005,U                                               * 034D 30 45          0E
           clra                                                         * 034F 4F             O
           ldy    #1                                                    * 0350 10 8E 00 01    ....
           os9    I$Read                                                * 0354 10 3F 89       .?.
           leax   L017C,PC                                              * 0357 30 8D FE 21    0.~!
           ldy    #1                                                    * 035B 10 8E 00 01    ....
           lda    #1                                                    * 035F 86 01          ..
           os9    I$WritLn                                              * 0361 10 3F 8C       .?.
           lda    U0005,U                                               * 0364 A6 45          &E
           anda   #223                                                  * 0366 84 DF          ._
           cmpa   #65                                                   * 0368 81 41          .A
           lbeq   L063E                                                 * 036A 10 27 02 D0    .'.P
           cmpa   #68                                                   * 036E 81 44          .D
           lbeq   L0487                                                 * 0370 10 27 01 13    .'..
           cmpa   #69                                                   * 0374 81 45          .E
           beq    L038B                                                 * 0376 27 13          '.
           cmpa   #67                                                   * 0378 81 43          .C
           beq    L0382                                                 * 037A 27 06          '.
           cmpa   #76                                                   * 037C 81 4C          .L
           beq    L03F1                                                 * 037E 27 71          'q
           bra    L0335                                                 * 0380 20 B3           3
L0382      ldd    U000C,U                                               * 0382 EC 4C          lL
           subd   #1                                                    * 0384 83 00 01       ...
           std    U000C,U                                               * 0387 ED 4C          mL
           bra    L031D                                                 * 0389 20 92           .
L038B      leax   L016E,PC                                              * 038B 30 8D FD DF    0.}_
           ldy    #200                                                  * 038F 10 8E 00 C8    ...H
           lda    #1                                                    * 0393 86 01          ..
           os9    I$WritLn                                              * 0395 10 3F 8C       .?.
           leax   L017B,PC                                              * 0398 30 8D FD DF    0.}_
           ldy    #1                                                    * 039C 10 8E 00 01    ....
           os9    I$Write                                               * 03A0 10 3F 8A       .?.
           clra                                                         * 03A3 4F             O
           leax   >U00E5,U                                              * 03A4 30 C9 00 E5    0I.e
           ldy    #3                                                    * 03A8 10 8E 00 03    ....
           os9    I$ReadLn                                              * 03AC 10 3F 8B       .?.
           lbsr   L07D2                                                 * 03AF 17 04 20       ..
           cmpd   U000C,U                                               * 03B2 10 A3 4C       .#L
           lbcc   L0335                                                 * 03B5 10 24 FF 7C    .$.|
           std    <U001A,U                                              * 03B9 ED C8 1A       mH.
           leax   >U00E5,U                                              * 03BC 30 C9 00 E5    0I.e
           lbsr   L0842                                                 * 03C0 17 04 7F       ...
           leax   >U00E5,U                                              * 03C3 30 C9 00 E5    0I.e
           lda    #58                                                   * 03C7 86 3A          .:
           sta    $02,X                                                 * 03C9 A7 02          '.
           ldy    #3                                                    * 03CB 10 8E 00 03    ....
           lda    #1                                                    * 03CF 86 01          ..
           os9    I$Write                                               * 03D1 10 3F 8A       .?.
           ldd    <U001A,U                                              * 03D4 EC C8 1A       lH.
           leax   >U018B,U                                              * 03D7 30 C9 01 8B    0I..
           lda    #80                                                   * 03DB 86 50          .P
           mul                                                          * 03DD 3D             =
           leax   D,X                                                   * 03DE 30 8B          0.
           ldy    #80                                                   * 03E0 10 8E 00 50    ...P
           lda    #1                                                    * 03E4 86 01          ..
           os9    I$WritLn                                              * 03E6 10 3F 8C       .?.
           ldd    <U001A,U                                              * 03E9 EC C8 1A       lH.
           bsr    L0432                                                 * 03EC 8D 44          .D
           lbra   L0335                                                 * 03EE 16 FF 44       ..D
L03F1      ldd    #0                                                    * 03F1 CC 00 00       L..
           std    U000C,U                                               * 03F4 ED 4C          mL
L03F6      ldd    U000C,U                                               * 03F6 EC 4C          lL
           addd   #1                                                    * 03F8 C3 00 01       C..
           std    U000C,U                                               * 03FB ED 4C          mL
           leax   >U00E5,U                                              * 03FD 30 C9 00 E5    0I.e
           lbsr   L0842                                                 * 0401 17 04 3E       ..>
           leax   >U00E5,U                                              * 0404 30 C9 00 E5    0I.e
           lda    #58                                                   * 0408 86 3A          .:
           sta    $02,X                                                 * 040A A7 02          '.
           lda    #1                                                    * 040C 86 01          ..
           ldy    #3                                                    * 040E 10 8E 00 03    ....
           os9    I$Write                                               * 0412 10 3F 8A       .?.
           leax   >U018B,U                                              * 0415 30 C9 01 8B    0I..
           ldd    U000C,U                                               * 0419 EC 4C          lL
           lda    #80                                                   * 041B 86 50          .P
           mul                                                          * 041D 3D             =
           leax   D,X                                                   * 041E 30 8B          0.
           ldy    #80                                                   * 0420 10 8E 00 50    ...P
           lda    #1                                                    * 0424 86 01          ..
           os9    I$WritLn                                              * 0426 10 3F 8C       .?.
           cmpy   #1                                                    * 0429 10 8C 00 01    ....
           bhi    L03F6                                                 * 042D 22 C7          "G
           lbra   L0335                                                 * 042F 16 FF 03       ...
L0432      leax   >U00E5,U                                              * 0432 30 C9 00 E5    0I.e
           pshs   D                                                     * 0436 34 06          4.
           lbsr   L0842                                                 * 0438 17 04 07       ...
           leax   >U00E5,U                                              * 043B 30 C9 00 E5    0I.e
           lda    #58                                                   * 043F 86 3A          .:
           sta    $02,X                                                 * 0441 A7 02          '.
           lda    #1                                                    * 0443 86 01          ..
           ldy    #3                                                    * 0445 10 8E 00 03    ....
           os9    I$Write                                               * 0449 10 3F 8A       .?.
           lbcs   L063B                                                 * 044C 10 25 01 EB    .%.k
           leax   >U20CB,U                                              * 0450 30 C9 20 CB    0I K
           ldb    U0006,U                                               * 0454 E6 46          fF
           clra                                                         * 0456 4F             O
           tfr    D,Y                                                   * 0457 1F 02          ..
           lda    #1                                                    * 0459 86 01          ..
           os9    I$Write                                               * 045B 10 3F 8A       .?.
           puls   D                                                     * 045E 35 06          5.
           lda    #80                                                   * 0460 86 50          .P
           mul                                                          * 0462 3D             =
           leax   >U018B,U                                              * 0463 30 C9 01 8B    0I..
           leax   D,X                                                   * 0467 30 8B          0.
           leay   >U20CB,U                                              * 0469 31 C9 20 CB    1I K
           ldb    #80                                                   * 046D C6 50          FP
           lda    U0006,U                                               * 046F A6 46          &F
           beq    L0480                                                 * 0471 27 0D          '.
           sta    <U0016,U                                              * 0473 A7 C8 16       'H.
L0476      lda    ,Y+                                                   * 0476 A6 A0          &
           sta    ,X+                                                   * 0478 A7 80          '.
           decb                                                         * 047A 5A             Z
           dec    <U0016,U                                              * 047B 6A C8 16       jH.
           bne    L0476                                                 * 047E 26 F6          &v
L0480      clra                                                         * 0480 4F             O
           tfr    D,Y                                                   * 0481 1F 02          ..
           lbsr   L0642                                                 * 0483 17 01 BC       ..<
           rts                                                          * 0486 39             9
L0487      leax   <U001C,U                                              * 0487 30 C8 1C       0H.
           ldy    #200                                                  * 048A 10 8E 00 C8    ...H
           lda    U0002,U                                               * 048E A6 42          &B
           os9    I$ReadLn                                              * 0490 10 3F 8B       .?.
           lbcs   L063B                                                 * 0493 10 25 01 A4    .%.$
L0497      lda    ,X+                                                   * 0497 A6 80          &.
           cmpa   #44                                                   * 0499 81 2C          .,
           bne    L0497                                                 * 049B 26 FA          &z
           lbsr   L07D2                                                 * 049D 17 03 32       ..2
           cmpd   U000A,U                                               * 04A0 10 A3 4A       .#J
           bne    L0487                                                 * 04A3 26 E2          &b
           leax   <U001C,U                                              * 04A5 30 C8 1C       0H.
           leay   >U012F,U                                              * 04A8 31 C9 01 2F    1I./
L04AC      lda    ,X+                                                   * 04AC A6 80          &.
           cmpa   #44                                                   * 04AE 81 2C          .,
           beq    L04B6                                                 * 04B0 27 04          '.
           sta    ,Y+                                                   * 04B2 A7 A0          '
           bra    L04AC                                                 * 04B4 20 F6           v
L04B6      lda    #13                                                   * 04B6 86 0D          ..
           sta    0,Y                                                   * 04B8 A7 A4          '$
           ldd    >U00ED,U                                              * 04BA EC C9 00 ED    lI.m
           std    >U012B,U                                              * 04BE ED C9 01 2B    mI.+
           ldd    >U00EF,U                                              * 04C2 EC C9 00 EF    lI.o
           std    >U012D,U                                              * 04C6 ED C9 01 2D    mI.-
           ldd    U000A,U                                               * 04CA EC 4A          lJ
           std    >U0167,U                                              * 04CC ED C9 01 67    mI.g
           leax   >U012B,U                                              * 04D0 30 C9 01 2B    0I.+
           lda    U0000,U                                               * 04D4 A6 C4          &D
           ldy    #64                                                   * 04D6 10 8E 00 40    ...@
           os9    I$Write                                               * 04DA 10 3F 8A       .?.
           lbcs   L063B                                                 * 04DD 10 25 01 5A    .%.Z
           leax   L008D,PC                                              * 04E1 30 8D FB A8    0.{(
           lda    #3                                                    * 04E5 86 03          ..
           os9    I$Open                                                * 04E7 10 3F 84       .?.
           lbcs   L063B                                                 * 04EA 10 25 01 4D    .%.M
           sta    U0001,U                                               * 04EE A7 41          'A
           pshs   U                                                     * 04F0 34 40          4@
           ldx    >U00ED,U                                              * 04F2 AE C9 00 ED    .I.m
           lda    U0001,U                                               * 04F6 A6 41          &A
           ldu    >U00EF,U                                              * 04F8 EE C9 00 EF    nI.o
           os9    I$Seek                                                * 04FC 10 3F 88       .?.
           lbcs   L063B                                                 * 04FF 10 25 01 38    .%.8
           puls   U                                                     * 0503 35 40          5@
           lda    #0                                                    * 0505 86 00          ..
           sta    <U0012,U                                              * 0507 A7 C8 12       'H.
           ldd    #1                                                    * 050A CC 00 01       L..
           std    <U0014,U                                              * 050D ED C8 14       mH.
L0510      lda    <U0012,U                                              * 0510 A6 C8 12       &H.
           inca                                                         * 0513 4C             L
           sta    <U0012,U                                              * 0514 A7 C8 12       'H.
           cmpa   U000D,U                                               * 0517 A1 4D          !M
           bhi    L0541                                                 * 0519 22 26          "&
           ldb    #80                                                   * 051B C6 50          FP
           mul                                                          * 051D 3D             =
           leax   >U018B,U                                              * 051E 30 C9 01 8B    0I..
           leax   D,X                                                   * 0522 30 8B          0.
           ldy    #80                                                   * 0524 10 8E 00 50    ...P
           lda    U0001,U                                               * 0528 A6 41          &A
           os9    I$WritLn                                              * 052A 10 3F 8C       .?.
           lbcs   L063B                                                 * 052D 10 25 01 0A    .%..
           cmpy   #1                                                    * 0531 10 8C 00 01    ....
           bls    L0541                                                 * 0535 23 0A          #.
           tfr    Y,D                                                   * 0537 1F 20          .
           addd   <U0014,U                                              * 0539 E3 C8 14       cH.
           std    <U0014,U                                              * 053C ED C8 14       mH.
           bra    L0510                                                 * 053F 20 CF           O
L0541      ldd    >U00EF,U                                              * 0541 EC C9 00 EF    lI.o
           addd   <U0014,U                                              * 0545 E3 C8 14       cH.
           std    >U00EF,U                                              * 0548 ED C9 00 EF    mI.o
           bcc    L0559                                                 * 054C 24 0B          $.
           ldd    >U00ED,U                                              * 054E EC C9 00 ED    lI.m
           addd   #1                                                    * 0552 C3 00 01       C..
           std    >U00ED,U                                              * 0555 ED C9 00 ED    mI.m
L0559      pshs   U                                                     * 0559 34 40          4@
           lda    U0000,U                                               * 055B A6 C4          &D
           ldx    #0                                                    * 055D 8E 00 00       ...
           ldu    #0                                                    * 0560 CE 00 00       N..
           os9    I$Seek                                                * 0563 10 3F 88       .?.
           lbcs   L063B                                                 * 0566 10 25 00 D1    .%.Q
           puls   U                                                     * 056A 35 40          5@
           leax   >U00EB,U                                              * 056C 30 C9 00 EB    0I.k
           ldy    #64                                                   * 0570 10 8E 00 40    ...@
           lda    U0000,U                                               * 0574 A6 C4          &D
           os9    I$Write                                               * 0576 10 3F 8A       .?.
           lbcs   L063B                                                 * 0579 10 25 00 BE    .%.>
           leax   L0181,PC                                              * 057D 30 8D FC 00    0.|.
           lda    #3                                                    * 0581 86 03          ..
           os9    I$Open                                                * 0583 10 3F 84       .?.
           bcc    L0591                                                 * 0586 24 09          $.
           ldb    #27                                                   * 0588 C6 1B          F.
           os9    I$Create                                              * 058A 10 3F 83       .?.
           lbcs   L063B                                                 * 058D 10 25 00 AA    .%.*
L0591      sta    U0007,U                                               * 0591 A7 47          'G
L0593      leax   >U016B,U                                              * 0593 30 C9 01 6B    0I.k
           ldy    #32                                                   * 0597 10 8E 00 20    ...
           lda    U0007,U                                               * 059B A6 47          &G
           os9    I$Read                                                * 059D 10 3F 89       .?.
           bcs    L05AD                                                 * 05A0 25 0B          %.
           ldd    >U016B,U                                              * 05A2 EC C9 01 6B    lI.k
           cmpd   U000A,U                                               * 05A6 10 A3 4A       .#J
           bne    L0593                                                 * 05A9 26 E8          &h
           bra    L05B6                                                 * 05AB 20 09           .
L05AD      cmpb   #211                                                  * 05AD C1 D3          AS
           lbne   L063B                                                 * 05AF 10 26 00 88    .&..
           lbra   L05F4                                                 * 05B3 16 00 3E       ..>
L05B6      ldd    >U0175,U                                              * 05B6 EC C9 01 75    lI.u
           addd   #1                                                    * 05BA C3 00 01       C..
           std    >U0175,U                                              * 05BD ED C9 01 75    mI.u
           lda    U0007,U                                               * 05C1 A6 47          &G
           ldb    #5                                                    * 05C3 C6 05          F.
           pshs   U                                                     * 05C5 34 40          4@
           os9    I$GetStt                                              * 05C7 10 3F 8D       .?.
           tfr    U,D                                                   * 05CA 1F 30          .0
           subd   #32                                                   * 05CC 83 00 20       ..
           bge    L05D3                                                 * 05CF 2C 02          ,.
           leax   -$01,X                                                * 05D1 30 1F          0.
L05D3      ldu    0,S                                                   * 05D3 EE E4          nd
           tfr    D,Y                                                   * 05D5 1F 02          ..
           lda    U0007,U                                               * 05D7 A6 47          &G
           tfr    Y,U                                                   * 05D9 1F 23          .#
           os9    I$Seek                                                * 05DB 10 3F 88       .?.
           lbcs   L063B                                                 * 05DE 10 25 00 59    .%.Y
           puls   U                                                     * 05E2 35 40          5@
           leax   >U016B,U                                              * 05E4 30 C9 01 6B    0I.k
           ldy    #32                                                   * 05E8 10 8E 00 20    ...
           lda    U0007,U                                               * 05EC A6 47          &G
           os9    I$Write                                               * 05EE 10 3F 8A       .?.
           lbra   L0634                                                 * 05F1 16 00 40       ..@
L05F4      leax   >U016B,U                                              * 05F4 30 C9 01 6B    0I.k
           ldd    #1                                                    * 05F8 CC 00 01       L..
           std    >U016D,U                                              * 05FB ED C9 01 6D    mI.m
           ldd    #0                                                    * 05FF CC 00 00       L..
           std    >U0175,U                                              * 0602 ED C9 01 75    mI.u
           std    >U0177,U                                              * 0606 ED C9 01 77    mI.w
           std    >U017B,U                                              * 060A ED C9 01 7B    mI.{
           std    >U0179,U                                              * 060E ED C9 01 79    mI.y
           ldd    U000A,U                                               * 0612 EC 4A          lJ
           std    >U016B,U                                              * 0614 ED C9 01 6B    mI.k
           leax   >U016F,U                                              * 0618 30 C9 01 6F    0I.o
           os9    F$Time                                                * 061C 10 3F 15       .?.
           lbcs   L063B                                                 * 061F 10 25 00 18    .%..
           leax   >U016B,U                                              * 0623 30 C9 01 6B    0I.k
           ldy    #32                                                   * 0627 10 8E 00 20    ...
           lda    U0007,U                                               * 062B A6 47          &G
           os9    I$Write                                               * 062D 10 3F 8A       .?.
           lbcs   L063B                                                 * 0630 10 25 00 07    .%..
L0634      clrb                                                         * 0634 5F             _
           ldy    U000A,U                                               * 0635 10 AE 4A       ..J
           os9    F$SUser                                               * 0638 10 3F 1C       .?.
L063B      os9    F$Exit                                                * 063B 10 3F 06       .?.
L063E      ldb    #1                                                    * 063E C6 01          F.
           bra    L063B                                                 * 0640 20 F9           y
L0642      lbsr   L079B                                                 * 0642 17 01 56       ..V
           ldb    U0006,U                                               * 0645 E6 46          fF
           leay   B,Y                                                   * 0647 31 A5          1%
           pshs   Y                                                     * 0649 34 20          4
           negb                                                         * 064B 50             P
           sex                                                          * 064C 1D             .
           leay   D,Y                                                   * 064D 31 AB          1+
           clr    U0006,U                                               * 064F 6F 46          oF
           cmpy   #0                                                    * 0651 10 8C 00 00    ....
           lbeq   L0711                                                 * 0655 10 27 00 B8    .'.8
           pshs   Y,X                                                   * 0659 34 30          40
           lda    #13                                                   * 065B 86 0D          ..
L065D      sta    ,X+                                                   * 065D A7 80          '.
           leay   -$01,Y                                                * 065F 31 3F          1?
           bne    L065D                                                 * 0661 26 FA          &z
           puls   Y,X                                                   * 0663 35 30          50
L0665      pshs   Y,X                                                   * 0665 34 30          40
           leax   U0005,U                                               * 0667 30 45          0E
           ldy    #1                                                    * 0669 10 8E 00 01    ....
           clra                                                         * 066D 4F             O
           os9    I$Read                                                * 066E 10 3F 89       .?.
           bcs    L069E                                                 * 0671 25 2B          %+
           lda    U0005,U                                               * 0673 A6 45          &E
           cmpa   #1                                                    * 0675 81 01          ..
           beq    L06A2                                                 * 0677 27 29          ')
           cmpa   #8                                                    * 0679 81 08          ..
           beq    L06C4                                                 * 067B 27 47          'G
           cmpa   #24                                                   * 067D 81 18          ..
           beq    L06E8                                                 * 067F 27 67          'g
           cmpa   #13                                                   * 0681 81 0D          ..
           lbeq   L070F                                                 * 0683 10 27 00 88    .'..
           cmpa   #32                                                   * 0687 81 20          .
           bcs    L069E                                                 * 0689 25 13          %.
           lda    #1                                                    * 068B 86 01          ..
           os9    I$Write                                               * 068D 10 3F 8A       .?.
           puls   Y,X                                                   * 0690 35 30          50
           lda    U0005,U                                               * 0692 A6 45          &E
           sta    ,X+                                                   * 0694 A7 80          '.
           leay   -$01,Y                                                * 0696 31 3F          1?
           lbeq   L0738                                                 * 0698 10 27 00 9C    .'..
           bra    L0665                                                 * 069C 20 C7           G
L069E      puls   Y,X                                                   * 069E 35 30          50
           bra    L0665                                                 * 06A0 20 C3           C
L06A2      puls   Y,X                                                   * 06A2 35 30          50
           leay   -$01,Y                                                * 06A4 31 3F          1?
           beq    L06BF                                                 * 06A6 27 17          '.
           lda    ,X+                                                   * 06A8 A6 80          &.
           cmpa   #13                                                   * 06AA 81 0D          ..
           beq    L06BD                                                 * 06AC 27 0F          '.
           pshs   Y,X                                                   * 06AE 34 30          40
           leax   -$01,X                                                * 06B0 30 1F          0.
           ldy    #1                                                    * 06B2 10 8E 00 01    ....
           lda    #1                                                    * 06B6 86 01          ..
           os9    I$Write                                               * 06B8 10 3F 8A       .?.
           bra    L06A2                                                 * 06BB 20 E5           e
L06BD      leax   -$01,X                                                * 06BD 30 1F          0.
L06BF      leay   $01,Y                                                 * 06BF 31 21          1!
           lbra   L0665                                                 * 06C1 16 FF A1       ..!
L06C4      puls   Y,X                                                   * 06C4 35 30          50
           leay   $01,Y                                                 * 06C6 31 21          1!
           cmpy   0,S                                                   * 06C8 10 AC E4       .,d
           bhi    L06E3                                                 * 06CB 22 16          ".
           pshs   Y,X                                                   * 06CD 34 30          40
           leax   L017E,PC                                              * 06CF 30 8D FA AB    0.z+
           ldy    #3                                                    * 06D3 10 8E 00 03    ....
           lda    #1                                                    * 06D7 86 01          ..
           os9    I$Write                                               * 06D9 10 3F 8A       .?.
           puls   Y,X                                                   * 06DC 35 30          50
           leax   -$01,X                                                * 06DE 30 1F          0.
           lbra   L0665                                                 * 06E0 16 FF 82       ...
L06E3      leay   -$01,Y                                                * 06E3 31 3F          1?
           lbra   L0665                                                 * 06E5 16 FF 7D       ..}
L06E8      puls   Y,X                                                   * 06E8 35 30          50
           leay   $01,Y                                                 * 06EA 31 21          1!
           cmpy   0,S                                                   * 06EC 10 AC E4       .,d
           bhi    L06E3                                                 * 06EF 22 F2          "r
           pshs   Y,X                                                   * 06F1 34 30          40
           leax   L017E,PC                                              * 06F3 30 8D FA 87    0.z.
           ldy    #3                                                    * 06F7 10 8E 00 03    ....
           lda    #1                                                    * 06FB 86 01          ..
           os9    I$Write                                               * 06FD 10 3F 8A       .?.
           puls   Y,X                                                   * 0700 35 30          50
           leax   -$01,X                                                * 0702 30 1F          0.
           cmpy   0,S                                                   * 0704 10 AC E4       .,d
           lbhi   L0665                                                 * 0707 10 22 FF 5A    .".Z
           pshs   Y,X                                                   * 070B 34 30          40
           bra    L06E8                                                 * 070D 20 D9           Y
L070F      puls   Y,X                                                   * 070F 35 30          50
L0711      lda    #13                                                   * 0711 86 0D          ..
           sta    ,X+                                                   * 0713 A7 80          '.
           pshs   Y,X                                                   * 0715 34 30          40
           leax   L017C,PC                                              * 0717 30 8D FA 61    0.za
           ldy    #1                                                    * 071B 10 8E 00 01    ....
           lda    #1                                                    * 071F 86 01          ..
           os9    I$WritLn                                              * 0721 10 3F 8C       .?.
           puls   Y,X                                                   * 0724 35 30          50
           puls   D                                                     * 0726 35 06          5.
           pshs   Y                                                     * 0728 34 20          4
           subd   0,S                                                   * 072A A3 E4          #d
           leas   $02,S                                                 * 072C 32 62          2b
           tfr    D,Y                                                   * 072E 1F 02          ..
           leay   $01,Y                                                 * 0730 31 21          1!
           lbsr   L07B5                                                 * 0732 17 00 80       ...
           rts                                                          * 0735 39             9
           fcb    $35                                                   * 0736 35             5
           fcb    $30                                                   * 0737 30             0
L0738      puls   D                                                     * 0738 35 06          5.
           pshs   Y                                                     * 073A 34 20          4
           subd   0,S                                                   * 073C A3 E4          #d
           leas   $02,S                                                 * 073E 32 62          2b
           addd   #1                                                    * 0740 C3 00 01       C..
           tfr    D,Y                                                   * 0743 1F 02          ..
           clrb                                                         * 0745 5F             _
L0746      leay   -$01,Y                                                * 0746 31 3F          1?
           beq    L0764                                                 * 0748 27 1A          '.
           lda    ,-X                                                   * 074A A6 82          &.
           cmpa   #32                                                   * 074C 81 20          .
           beq    L0775                                                 * 074E 27 25          '%
           pshs   Y,X                                                   * 0750 34 30          40
           leax   L017E,PC                                              * 0752 30 8D FA 28    0.z(
           ldy    #3                                                    * 0756 10 8E 00 03    ....
           lda    #1                                                    * 075A 86 01          ..
           os9    I$Write                                               * 075C 10 3F 8A       .?.
           incb                                                         * 075F 5C             \
           puls   Y,X                                                   * 0760 35 30          50
           bra    L0746                                                 * 0762 20 E2           b
L0764      lda    #13                                                   * 0764 86 0D          ..
           sta    <$004F,X                                              * 0766 A7 88 4F       '.O
           ldy    #200                                                  * 0769 10 8E 00 C8    ...H
           lda    #1                                                    * 076D 86 01          ..
           os9    I$WritLn                                              * 076F 10 3F 8C       .?.
           puls   Y                                                     * 0772 35 20          5
           rts                                                          * 0774 39             9
L0775      lda    #13                                                   * 0775 86 0D          ..
           sta    ,X+                                                   * 0777 A7 80          '.
           pshs   Y,X                                                   * 0779 34 30          40
           stb    U0006,U                                               * 077B E7 46          gF
           leay   >U20CB,U                                              * 077D 31 C9 20 CB    1I K
L0781      lda    ,X+                                                   * 0781 A6 80          &.
           sta    ,Y+                                                   * 0783 A7 A0          '
           decb                                                         * 0785 5A             Z
           bne    L0781                                                 * 0786 26 F9          &y
           leax   L017C,PC                                              * 0788 30 8D F9 F0    0.yp
           ldy    #1                                                    * 078C 10 8E 00 01    ....
           lda    #1                                                    * 0790 86 01          ..
           os9    I$WritLn                                              * 0792 10 3F 8C       .?.
           puls   Y,X                                                   * 0795 35 30          50
           lbsr   L07B5                                                 * 0797 17 00 1B       ...
           rts                                                          * 079A 39             9
L079B      pshs   Y,X,D                                                 * 079B 34 36          46
           leax   >U211B,U                                              * 079D 30 C9 21 1B    0I!.
           clra                                                         * 07A1 4F             O
           ldb    #0                                                    * 07A2 C6 00          F.
           os9    I$GetStt                                              * 07A4 10 3F 8D       .?.
           leax   <$FFE0,X                                              * 07A7 30 88 E0       0.`
           clr    <$0024,X                                              * 07AA 6F 88 24       o.$
           leax   <$0020,X                                              * 07AD 30 88 20       0.
           os9    I$SetStt                                              * 07B0 10 3F 8E       .?.
           puls   PC,Y,X,D                                              * 07B3 35 B6          56
L07B5      pshs   Y,X,D                                                 * 07B5 34 36          46
           leax   >U211B,U                                              * 07B7 30 C9 21 1B    0I!.
           clra                                                         * 07BB 4F             O
           ldb    #0                                                    * 07BC C6 00          F.
           os9    I$GetStt                                              * 07BE 10 3F 8D       .?.
           leax   <$FFE0,X                                              * 07C1 30 88 E0       0.`
           lda    #1                                                    * 07C4 86 01          ..
           sta    <$0024,X                                              * 07C6 A7 88 24       '.$
           leax   <$0020,X                                              * 07C9 30 88 20       0.
           clra                                                         * 07CC 4F             O
           os9    I$SetStt                                              * 07CD 10 3F 8E       .?.
           puls   PC,Y,X,D                                              * 07D0 35 B6          56
L07D2      pshs   Y                                                     * 07D2 34 20          4
L07D4      lda    ,X+                                                   * 07D4 A6 80          &.
           cmpa   #13                                                   * 07D6 81 0D          ..
           lbeq   L087B                                                 * 07D8 10 27 00 9F    .'..
           cmpa   #48                                                   * 07DC 81 30          .0
           bcs    L07D4                                                 * 07DE 25 F4          %t
           cmpa   #57                                                   * 07E0 81 39          .9
           bhi    L07D4                                                 * 07E2 22 F0          "p
           leax   -$01,X                                                * 07E4 30 1F          0.
L07E6      lda    ,X+                                                   * 07E6 A6 80          &.
           cmpa   #48                                                   * 07E8 81 30          .0
           bcs    L07F2                                                 * 07EA 25 06          %.
           cmpa   #57                                                   * 07EC 81 39          .9
           bhi    L07F2                                                 * 07EE 22 02          ".
           bra    L07E6                                                 * 07F0 20 F4           t
L07F2      pshs   X                                                     * 07F2 34 10          4.
           leax   -$01,X                                                * 07F4 30 1F          0.
           clr    <U0016,U                                              * 07F6 6F C8 16       oH.
           clr    <U0017,U                                              * 07F9 6F C8 17       oH.
           ldd    #1                                                    * 07FC CC 00 01       L..
           std    <U0018,U                                              * 07FF ED C8 18       mH.
L0802      lda    ,-X                                                   * 0802 A6 82          &.
           cmpa   #48                                                   * 0804 81 30          .0
           bcs    L083B                                                 * 0806 25 33          %3
           cmpa   #57                                                   * 0808 81 39          .9
           bhi    L083B                                                 * 080A 22 2F          "/
           suba   #48                                                   * 080C 80 30          .0
           sta    U0004,U                                               * 080E A7 44          'D
           ldd    #0                                                    * 0810 CC 00 00       L..
L0813      tst    U0004,U                                               * 0813 6D 44          mD
           beq    L081E                                                 * 0815 27 07          '.
           addd   <U0018,U                                              * 0817 E3 C8 18       cH.
           dec    U0004,U                                               * 081A 6A 44          jD
           bra    L0813                                                 * 081C 20 F5           u
L081E      addd   <U0016,U                                              * 081E E3 C8 16       cH.
           std    <U0016,U                                              * 0821 ED C8 16       mH.
           lda    #10                                                   * 0824 86 0A          ..
           sta    U0004,U                                               * 0826 A7 44          'D
           ldd    #0                                                    * 0828 CC 00 00       L..
L082B      tst    U0004,U                                               * 082B 6D 44          mD
           beq    L0836                                                 * 082D 27 07          '.
           addd   <U0018,U                                              * 082F E3 C8 18       cH.
           dec    U0004,U                                               * 0832 6A 44          jD
           bra    L082B                                                 * 0834 20 F5           u
L0836      std    <U0018,U                                              * 0836 ED C8 18       mH.
           bra    L0802                                                 * 0839 20 C7           G
L083B      ldd    <U0016,U                                              * 083B EC C8 16       lH.
           puls   X                                                     * 083E 35 10          5.
           puls   PC,Y                                                  * 0840 35 A0          5
L0842      pshs   Y                                                     * 0842 34 20          4
           std    <U0016,U                                              * 0844 ED C8 16       mH.
           lda    #48                                                   * 0847 86 30          .0
           sta    0,X                                                   * 0849 A7 84          '.
           sta    $01,X                                                 * 084B A7 01          '.
           ldd    #10                                                   * 084D CC 00 0A       L..
           std    <U0018,U                                              * 0850 ED C8 18       mH.
           ldd    <U0016,U                                              * 0853 EC C8 16       lH.
           bsr    L0869                                                 * 0856 8D 11          ..
           ldd    #1                                                    * 0858 CC 00 01       L..
           std    <U0018,U                                              * 085B ED C8 18       mH.
           ldd    <U0016,U                                              * 085E EC C8 16       lH.
           bsr    L0869                                                 * 0861 8D 06          ..
           lda    #13                                                   * 0863 86 0D          ..
           sta    0,X                                                   * 0865 A7 84          '.
           puls   PC,Y                                                  * 0867 35 A0          5
L0869      subd   <U0018,U                                              * 0869 A3 C8 18       #H.
           bcs    L0872                                                 * 086C 25 04          %.
           inc    0,X                                                   * 086E 6C 84          l.
           bra    L0869                                                 * 0870 20 F7           w
L0872      addd   <U0018,U                                              * 0872 E3 C8 18       cH.
           std    <U0016,U                                              * 0875 ED C8 16       mH.
           leax   $01,X                                                 * 0878 30 01          0.
           rts                                                          * 087A 39             9
L087B      ldd    #-1                                                   * 087B CC FF FF       L..
           puls   PC,Y                                                  * 087E 35 A0          5

           emod
eom        equ    *
           end
