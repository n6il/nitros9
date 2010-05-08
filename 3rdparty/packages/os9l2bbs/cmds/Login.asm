           nam    Login
           ttl    program module

           ifp1
           use    defsfile
           endc

tylg       set    Prgrm+Objct
atrv       set    ReEnt+rev
rev        set    $01

           mod    eom,name,tylg,atrv,start,size

U0000      rmb    2
U0002      rmb    1
U0003      rmb    1
U0004      rmb    1
U0005      rmb    1
U0006      rmb    5
U000B      rmb    1
U000C      rmb    1
U000D      rmb    1
U000E      rmb    1
U000F      rmb    1
U0010      rmb    3
U0013      rmb    2
U0015      rmb    1
U0016      rmb    1
U0017      rmb    2
U0019      rmb    2
U001B      rmb    2
U001D      rmb    2
U001F      rmb    2
U0021      rmb    2
U0023      rmb    2
U0025      rmb    2
U0027      rmb    1
U0028      rmb    2
U002A      rmb    1
U002B      rmb    2
U002D      rmb    2
U002F      rmb    2
U0031      rmb    2
U0033      rmb    2
U0035      rmb    1
U0036      rmb    1
U0037      rmb    1
U0038      rmb    1
U0039      rmb    2
U003B      rmb    8
U0043      rmb    3
U0046      rmb    1
U0047      rmb    1
U0048      rmb    1
U0049      rmb    32
U0069      rmb    200
U0131      rmb    200
U01F9      rmb    400
U0389      rmb    1
U038A      rmb    599
size       equ    .

name       fcs    /Login/                                               * 000D 4C 6F 67 69 EE Login
           fcb    $43                                                   * 0012 43             C
           fcb    $6F                                                   * 0013 6F             o
           fcb    $70                                                   * 0014 70             p
           fcb    $79                                                   * 0015 79             y
           fcb    $72                                                   * 0016 72             r
           fcb    $69                                                   * 0017 69             i
           fcb    $67                                                   * 0018 67             g
           fcb    $68                                                   * 0019 68             h
           fcb    $74                                                   * 001A 74             t
           fcb    $20                                                   * 001B 20
           fcb    $28                                                   * 001C 28             (
           fcb    $43                                                   * 001D 43             C
           fcb    $29                                                   * 001E 29             )
           fcb    $20                                                   * 001F 20
           fcb    $31                                                   * 0020 31             1
           fcb    $39                                                   * 0021 39             9
           fcb    $38                                                   * 0022 38             8
           fcb    $38                                                   * 0023 38             8
           fcb    $42                                                   * 0024 42             B
           fcb    $79                                                   * 0025 79             y
           fcb    $20                                                   * 0026 20
           fcb    $4B                                                   * 0027 4B             K
           fcb    $65                                                   * 0028 65             e
           fcb    $69                                                   * 0029 69             i
           fcb    $74                                                   * 002A 74             t
           fcb    $68                                                   * 002B 68             h
           fcb    $20                                                   * 002C 20
           fcb    $41                                                   * 002D 41             A
           fcb    $6C                                                   * 002E 6C             l
           fcb    $70                                                   * 002F 70             p
           fcb    $68                                                   * 0030 68             h
           fcb    $6F                                                   * 0031 6F             o
           fcb    $6E                                                   * 0032 6E             n
           fcb    $73                                                   * 0033 73             s
           fcb    $6F                                                   * 0034 6F             o
           fcb    $4C                                                   * 0035 4C             L
           fcb    $69                                                   * 0036 69             i
           fcb    $63                                                   * 0037 63             c
           fcb    $65                                                   * 0038 65             e
           fcb    $6E                                                   * 0039 6E             n
           fcb    $63                                                   * 003A 63             c
           fcb    $65                                                   * 003B 65             e
           fcb    $64                                                   * 003C 64             d
           fcb    $20                                                   * 003D 20
           fcb    $74                                                   * 003E 74             t
           fcb    $6F                                                   * 003F 6F             o
           fcb    $20                                                   * 0040 20
           fcb    $41                                                   * 0041 41             A
           fcb    $6C                                                   * 0042 6C             l
           fcb    $70                                                   * 0043 70             p
           fcb    $68                                                   * 0044 68             h
           fcb    $61                                                   * 0045 61             a
           fcb    $20                                                   * 0046 20
           fcb    $53                                                   * 0047 53             S
           fcb    $6F                                                   * 0048 6F             o
           fcb    $66                                                   * 0049 66             f
           fcb    $74                                                   * 004A 74             t
           fcb    $77                                                   * 004B 77             w
           fcb    $61                                                   * 004C 61             a
           fcb    $72                                                   * 004D 72             r
           fcb    $65                                                   * 004E 65             e
           fcb    $20                                                   * 004F 20
           fcb    $54                                                   * 0050 54             T
           fcb    $65                                                   * 0051 65             e
           fcb    $63                                                   * 0052 63             c
           fcb    $68                                                   * 0053 68             h
           fcb    $6E                                                   * 0054 6E             n
           fcb    $6F                                                   * 0055 6F             o
           fcb    $6C                                                   * 0056 6C             l
           fcb    $6F                                                   * 0057 6F             o
           fcb    $67                                                   * 0058 67             g
           fcb    $69                                                   * 0059 69             i
           fcb    $65                                                   * 005A 65             e
           fcb    $73                                                   * 005B 73             s
           fcb    $41                                                   * 005C 41             A
           fcb    $6C                                                   * 005D 6C             l
           fcb    $6C                                                   * 005E 6C             l
           fcb    $20                                                   * 005F 20
           fcb    $72                                                   * 0060 72             r
           fcb    $69                                                   * 0061 69             i
           fcb    $67                                                   * 0062 67             g
           fcb    $68                                                   * 0063 68             h
           fcb    $74                                                   * 0064 74             t
           fcb    $73                                                   * 0065 73             s
           fcb    $20                                                   * 0066 20
           fcb    $72                                                   * 0067 72             r
           fcb    $65                                                   * 0068 65             e
           fcb    $73                                                   * 0069 73             s
           fcb    $65                                                   * 006A 65             e
           fcb    $72                                                   * 006B 72             r
           fcb    $76                                                   * 006C 76             v
           fcb    $65                                                   * 006D 65             e
           fcb    $64                                                   * 006E 64             d
           fcb    $EC                                                   * 006F EC             l
           fcb    $E6                                                   * 0070 E6             f
           fcb    $EA                                                   * 0071 EA             j
           fcb    $F5                                                   * 0072 F5             u
           fcb    $E9                                                   * 0073 E9             i
           fcb    $A0                                                   * 0074 A0
           fcb    $E2                                                   * 0075 E2             b
           fcb    $ED                                                   * 0076 ED             m
           fcb    $F1                                                   * 0077 F1             q
           fcb    $E9                                                   * 0078 E9             i
           fcb    $F0                                                   * 0079 F0             p
           fcb    $EF                                                   * 007A EF             o
           fcb    $F4                                                   * 007B F4             t
           fcb    $F0                                                   * 007C F0             p
L007D      fcb    $2F                                                   * 007D 2F             /
           fcb    $50                                                   * 007E 50             P
           fcb    $0D                                                   * 007F 0D             .
L0080      fcb    $0A                                                   * 0080 0A             .
           fcb    $45                                                   * 0081 45             E
           fcb    $6E                                                   * 0082 6E             n
           fcb    $74                                                   * 0083 74             t
           fcb    $65                                                   * 0084 65             e
           fcb    $72                                                   * 0085 72             r
           fcb    $20                                                   * 0086 20
           fcb    $79                                                   * 0087 79             y
           fcb    $6F                                                   * 0088 6F             o
           fcb    $75                                                   * 0089 75             u
           fcb    $72                                                   * 008A 72             r
           fcb    $20                                                   * 008B 20
           fcb    $75                                                   * 008C 75             u
           fcb    $73                                                   * 008D 73             s
           fcb    $65                                                   * 008E 65             e
           fcb    $72                                                   * 008F 72             r
           fcb    $20                                                   * 0090 20
           fcb    $6E                                                   * 0091 6E             n
           fcb    $61                                                   * 0092 61             a
           fcb    $6D                                                   * 0093 6D             m
           fcb    $65                                                   * 0094 65             e
           fcb    $2D                                                   * 0095 2D             -
           fcb    $2D                                                   * 0096 2D             -
           fcb    $3E                                                   * 0097 3E             >
L0098      fcb    $00                                                   * 0098 00             .
           fcb    $18                                                   * 0099 18             .
L009A      fcb    $45                                                   * 009A 45             E
           fcb    $6E                                                   * 009B 6E             n
           fcb    $74                                                   * 009C 74             t
           fcb    $65                                                   * 009D 65             e
           fcb    $72                                                   * 009E 72             r
           fcb    $20                                                   * 009F 20
           fcb    $79                                                   * 00A0 79             y
           fcb    $6F                                                   * 00A1 6F             o
           fcb    $75                                                   * 00A2 75             u
           fcb    $72                                                   * 00A3 72             r
           fcb    $20                                                   * 00A4 20
           fcb    $50                                                   * 00A5 50             P
           fcb    $61                                                   * 00A6 61             a
           fcb    $73                                                   * 00A7 73             s
           fcb    $73                                                   * 00A8 73             s
           fcb    $77                                                   * 00A9 77             w
           fcb    $6F                                                   * 00AA 6F             o
           fcb    $72                                                   * 00AB 72             r
           fcb    $64                                                   * 00AC 64             d
           fcb    $2D                                                   * 00AD 2D             -
           fcb    $2D                                                   * 00AE 2D             -
           fcb    $2D                                                   * 00AF 2D             -
           fcb    $3E                                                   * 00B0 3E             >
L00B1      fcb    $00                                                   * 00B1 00             .
           fcb    $17                                                   * 00B2 17             .
L00B3      fcb    $4D                                                   * 00B3 4D             M
           fcb    $6F                                                   * 00B4 6F             o
           fcb    $74                                                   * 00B5 74             t
           fcb    $64                                                   * 00B6 64             d
           fcb    $0D                                                   * 00B7 0D             .
L00B8      fcb    $53                                                   * 00B8 53             S
           fcb    $68                                                   * 00B9 68             h
           fcb    $65                                                   * 00BA 65             e
           fcb    $6C                                                   * 00BB 6C             l
           fcb    $6C                                                   * 00BC 6C             l
           fcb    $0D                                                   * 00BD 0D             .
           fcb    $0D                                                   * 00BE 0D             .
L00BF      fcb    $42                                                   * 00BF 42             B
           fcb    $42                                                   * 00C0 42             B
           fcb    $53                                                   * 00C1 53             S
           fcb    $2E                                                   * 00C2 2E             .
           fcb    $75                                                   * 00C3 75             u
           fcb    $73                                                   * 00C4 73             s
           fcb    $65                                                   * 00C5 65             e
           fcb    $72                                                   * 00C6 72             r
           fcb    $73                                                   * 00C7 73             s
           fcb    $0D                                                   * 00C8 0D             .
L00C9      fcb    $49                                                   * 00C9 49             I
           fcb    $6E                                                   * 00CA 6E             n
           fcb    $76                                                   * 00CB 76             v
           fcb    $61                                                   * 00CC 61             a
           fcb    $6C                                                   * 00CD 6C             l
           fcb    $64                                                   * 00CE 64             d
           fcb    $20                                                   * 00CF 20
           fcb    $6E                                                   * 00D0 6E             n
           fcb    $61                                                   * 00D1 61             a
           fcb    $6D                                                   * 00D2 6D             m
           fcb    $65                                                   * 00D3 65             e
           fcb    $2F                                                   * 00D4 2F             /
           fcb    $70                                                   * 00D5 70             p
           fcb    $61                                                   * 00D6 61             a
           fcb    $73                                                   * 00D7 73             s
           fcb    $73                                                   * 00D8 73             s
           fcb    $77                                                   * 00D9 77             w
           fcb    $6F                                                   * 00DA 6F             o
           fcb    $72                                                   * 00DB 72             r
           fcb    $64                                                   * 00DC 64             d
           fcb    $21                                                   * 00DD 21             !
           fcb    $21                                                   * 00DE 21             !
           fcb    $21                                                   * 00DF 21             !
           fcb    $0D                                                   * 00E0 0D             .
L00E1      fcb    $0A                                                   * 00E1 0A             .
           fcb    $4F                                                   * 00E2 4F             O
           fcb    $53                                                   * 00E3 53             S
           fcb    $39                                                   * 00E4 39             9
           fcb    $20                                                   * 00E5 20
           fcb    $4C                                                   * 00E6 4C             L
           fcb    $65                                                   * 00E7 65             e
           fcb    $76                                                   * 00E8 76             v
           fcb    $65                                                   * 00E9 65             e
           fcb    $6C                                                   * 00EA 6C             l
           fcb    $20                                                   * 00EB 20
           fcb    $49                                                   * 00EC 49             I
           fcb    $49                                                   * 00ED 49             I
           fcb    $20                                                   * 00EE 20
           fcb    $42                                                   * 00EF 42             B
           fcb    $42                                                   * 00F0 42             B
           fcb    $53                                                   * 00F1 53             S
           fcb    $0D                                                   * 00F2 0D             .
L00F3      fcb    $42                                                   * 00F3 42             B
           fcb    $79                                                   * 00F4 79             y
           fcb    $20                                                   * 00F5 20
           fcb    $41                                                   * 00F6 41             A
           fcb    $6C                                                   * 00F7 6C             l
           fcb    $70                                                   * 00F8 70             p
           fcb    $68                                                   * 00F9 68             h
           fcb    $61                                                   * 00FA 61             a
           fcb    $20                                                   * 00FB 20
           fcb    $53                                                   * 00FC 53             S
           fcb    $6F                                                   * 00FD 6F             o
           fcb    $66                                                   * 00FE 66             f
           fcb    $74                                                   * 00FF 74             t
           fcb    $77                                                   * 0100 77             w
           fcb    $61                                                   * 0101 61             a
           fcb    $72                                                   * 0102 72             r
           fcb    $65                                                   * 0103 65             e
           fcb    $20                                                   * 0104 20
           fcb    $54                                                   * 0105 54             T
           fcb    $65                                                   * 0106 65             e
           fcb    $63                                                   * 0107 63             c
           fcb    $68                                                   * 0108 68             h
           fcb    $6E                                                   * 0109 6E             n
           fcb    $6F                                                   * 010A 6F             o
           fcb    $6C                                                   * 010B 6C             l
           fcb    $6F                                                   * 010C 6F             o
           fcb    $67                                                   * 010D 67             g
           fcb    $69                                                   * 010E 69             i
           fcb    $65                                                   * 010F 65             e
           fcb    $73                                                   * 0110 73             s
           fcb    $0D                                                   * 0111 0D             .
L0112      fcb    $43                                                   * 0112 43             C
           fcb    $6F                                                   * 0113 6F             o
           fcb    $70                                                   * 0114 70             p
           fcb    $79                                                   * 0115 79             y
           fcb    $72                                                   * 0116 72             r
           fcb    $69                                                   * 0117 69             i
           fcb    $67                                                   * 0118 67             g
           fcb    $68                                                   * 0119 68             h
           fcb    $74                                                   * 011A 74             t
           fcb    $20                                                   * 011B 20
           fcb    $28                                                   * 011C 28             (
           fcb    $63                                                   * 011D 63             c
           fcb    $29                                                   * 011E 29             )
           fcb    $20                                                   * 011F 20
           fcb    $31                                                   * 0120 31             1
           fcb    $39                                                   * 0121 39             9
           fcb    $38                                                   * 0122 38             8
           fcb    $38                                                   * 0123 38             8
           fcb    $0A                                                   * 0124 0A             .
           fcb    $0D                                                   * 0125 0D             .
L0126      fcb    $0A                                                   * 0126 0A             .
           fcb    $0D                                                   * 0127 0D             .
L0128      fcb    $64                                                   * 0128 64             d
           fcb    $61                                                   * 0129 61             a
           fcb    $74                                                   * 012A 74             t
           fcb    $65                                                   * 012B 65             e
           fcb    $0D                                                   * 012C 0D             .
L012D      fcb    $74                                                   * 012D 74             t
           fcb    $0D                                                   * 012E 0D             .
L012F      fcb    $20                                                   * 012F 20
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
           fcb    $20                                                   * 0155 20
L0156      fcb    $3A                                                   * 0156 3A             :
L0157      fcb    $53                                                   * 0157 53             S
           fcb    $6F                                                   * 0158 6F             o
           fcb    $72                                                   * 0159 72             r
           fcb    $72                                                   * 015A 72             r
           fcb    $79                                                   * 015B 79             y
           fcb    $2C                                                   * 015C 2C             ,
           fcb    $20                                                   * 015D 20
           fcb    $62                                                   * 015E 62             b
           fcb    $75                                                   * 015F 75             u
           fcb    $74                                                   * 0160 74             t
           fcb    $20                                                   * 0161 20
           fcb    $49                                                   * 0162 49             I
           fcb    $20                                                   * 0163 20
           fcb    $63                                                   * 0164 63             c
           fcb    $61                                                   * 0165 61             a
           fcb    $6E                                                   * 0166 6E             n
           fcb    $6E                                                   * 0167 6E             n
           fcb    $6F                                                   * 0168 6F             o
           fcb    $74                                                   * 0169 74             t
           fcb    $20                                                   * 016A 20
           fcb    $6C                                                   * 016B 6C             l
           fcb    $6F                                                   * 016C 6F             o
           fcb    $67                                                   * 016D 67             g
           fcb    $20                                                   * 016E 20
           fcb    $79                                                   * 016F 79             y
           fcb    $6F                                                   * 0170 6F             o
           fcb    $75                                                   * 0171 75             u
           fcb    $20                                                   * 0172 20
           fcb    $6F                                                   * 0173 6F             o
           fcb    $6E                                                   * 0174 6E             n
           fcb    $0D                                                   * 0175 0D             .
L0176      fcb    $57                                                   * 0176 57             W
           fcb    $65                                                   * 0177 65             e
           fcb    $6C                                                   * 0178 6C             l
           fcb    $63                                                   * 0179 63             c
           fcb    $6F                                                   * 017A 6F             o
           fcb    $6D                                                   * 017B 6D             m
           fcb    $65                                                   * 017C 65             e
           fcb    $2C                                                   * 017D 2C             ,
           fcb    $20                                                   * 017E 20
           fcb    $0D                                                   * 017F 0D             .
L0180      fcb    $0A                                                   * 0180 0A             .
           fcb    $56                                                   * 0181 56             V
           fcb    $65                                                   * 0182 65             e
           fcb    $72                                                   * 0183 72             r
           fcb    $69                                                   * 0184 69             i
           fcb    $66                                                   * 0185 66             f
           fcb    $79                                                   * 0186 79             y
           fcb    $69                                                   * 0187 69             i
           fcb    $6E                                                   * 0188 6E             n
           fcb    $67                                                   * 0189 67             g
           fcb    $20                                                   * 018A 20
           fcb    $50                                                   * 018B 50             P
           fcb    $61                                                   * 018C 61             a
           fcb    $73                                                   * 018D 73             s
           fcb    $73                                                   * 018E 73             s
           fcb    $77                                                   * 018F 77             w
           fcb    $6F                                                   * 0190 6F             o
           fcb    $72                                                   * 0191 72             r
           fcb    $64                                                   * 0192 64             d
           fcb    $2E                                                   * 0193 2E             .
           fcb    $2E                                                   * 0194 2E             .
           fcb    $2E                                                   * 0195 2E             .
           fcb    $50                                                   * 0196 50             P
           fcb    $6C                                                   * 0197 6C             l
           fcb    $65                                                   * 0198 65             e
           fcb    $61                                                   * 0199 61             a
           fcb    $73                                                   * 019A 73             s
           fcb    $65                                                   * 019B 65             e
           fcb    $20                                                   * 019C 20
           fcb    $77                                                   * 019D 77             w
           fcb    $61                                                   * 019E 61             a
           fcb    $69                                                   * 019F 69             i
           fcb    $74                                                   * 01A0 74             t
           fcb    $0A                                                   * 01A1 0A             .
           fcb    $0D                                                   * 01A2 0D             .
L01A3      fcb    $0A                                                   * 01A3 0A             .
           fcb    $45                                                   * 01A4 45             E
           fcb    $6E                                                   * 01A5 6E             n
           fcb    $74                                                   * 01A6 74             t
           fcb    $65                                                   * 01A7 65             e
           fcb    $72                                                   * 01A8 72             r
           fcb    $69                                                   * 01A9 69             i
           fcb    $6E                                                   * 01AA 6E             n
           fcb    $67                                                   * 01AB 67             g
           fcb    $20                                                   * 01AC 20
           fcb    $73                                                   * 01AD 73             s
           fcb    $79                                                   * 01AE 79             y
           fcb    $73                                                   * 01AF 73             s
           fcb    $74                                                   * 01B0 74             t
           fcb    $65                                                   * 01B1 65             e
           fcb    $6D                                                   * 01B2 6D             m
           fcb    $2E                                                   * 01B3 2E             .
           fcb    $2E                                                   * 01B4 2E             .
           fcb    $2E                                                   * 01B5 2E             .
           fcb    $0A                                                   * 01B6 0A             .
           fcb    $0D                                                   * 01B7 0D             .
L01B8      fcb    $55                                                   * 01B8 55             U
           fcb    $73                                                   * 01B9 73             s
           fcb    $65                                                   * 01BA 65             e
           fcb    $72                                                   * 01BB 72             r
           fcb    $6C                                                   * 01BC 6C             l
           fcb    $6F                                                   * 01BD 6F             o
           fcb    $67                                                   * 01BE 67             g
           fcb    $0D                                                   * 01BF 0D             .
L01C0      fcb    $20                                                   * 01C0 20
           fcb    $20                                                   * 01C1 20
           fcb    $20                                                   * 01C2 20
           fcb    $20                                                   * 01C3 20
           fcb    $20                                                   * 01C4 20
           fcb    $4C                                                   * 01C5 4C             L
           fcb    $69                                                   * 01C6 69             i
           fcb    $73                                                   * 01C7 73             s
           fcb    $74                                                   * 01C8 74             t
           fcb    $20                                                   * 01C9 20
           fcb    $6F                                                   * 01CA 6F             o
           fcb    $66                                                   * 01CB 66             f
           fcb    $20                                                   * 01CC 20
           fcb    $74                                                   * 01CD 74             t
           fcb    $6F                                                   * 01CE 6F             o
           fcb    $64                                                   * 01CF 64             d
           fcb    $61                                                   * 01D0 61             a
           fcb    $79                                                   * 01D1 79             y
           fcb    $27                                                   * 01D2 27             '
           fcb    $73                                                   * 01D3 73             s
           fcb    $20                                                   * 01D4 20
           fcb    $63                                                   * 01D5 63             c
           fcb    $61                                                   * 01D6 61             a
           fcb    $6C                                                   * 01D7 6C             l
           fcb    $6C                                                   * 01D8 6C             l
           fcb    $65                                                   * 01D9 65             e
           fcb    $72                                                   * 01DA 72             r
           fcb    $73                                                   * 01DB 73             s
           fcb    $0D                                                   * 01DC 0D             .
L01DD      fcb    $3D                                                   * 01DD 3D             =
           fcb    $3D                                                   * 01DE 3D             =
           fcb    $3D                                                   * 01DF 3D             =
           fcb    $3D                                                   * 01E0 3D             =
           fcb    $3D                                                   * 01E1 3D             =
           fcb    $3D                                                   * 01E2 3D             =
           fcb    $3D                                                   * 01E3 3D             =
           fcb    $3D                                                   * 01E4 3D             =
           fcb    $3D                                                   * 01E5 3D             =
           fcb    $3D                                                   * 01E6 3D             =
           fcb    $3D                                                   * 01E7 3D             =
           fcb    $3D                                                   * 01E8 3D             =
           fcb    $3D                                                   * 01E9 3D             =
           fcb    $3D                                                   * 01EA 3D             =
           fcb    $3D                                                   * 01EB 3D             =
           fcb    $3D                                                   * 01EC 3D             =
           fcb    $3D                                                   * 01ED 3D             =
           fcb    $3D                                                   * 01EE 3D             =
           fcb    $3D                                                   * 01EF 3D             =
           fcb    $3D                                                   * 01F0 3D             =
           fcb    $3D                                                   * 01F1 3D             =
           fcb    $3D                                                   * 01F2 3D             =
           fcb    $3D                                                   * 01F3 3D             =
           fcb    $3D                                                   * 01F4 3D             =
           fcb    $3D                                                   * 01F5 3D             =
           fcb    $3D                                                   * 01F6 3D             =
           fcb    $3D                                                   * 01F7 3D             =
           fcb    $3D                                                   * 01F8 3D             =
           fcb    $3D                                                   * 01F9 3D             =
           fcb    $3D                                                   * 01FA 3D             =
           fcb    $3D                                                   * 01FB 3D             =
           fcb    $3D                                                   * 01FC 3D             =
           fcb    $3D                                                   * 01FD 3D             =
           fcb    $0D                                                   * 01FE 0D             .
L01FF      fcb    $65                                                   * 01FF 65             e
           fcb    $6F                                                   * 0200 6F             o
           fcb    $74                                                   * 0201 74             t
           fcb    $64                                                   * 0202 64             d
           fcb    $0D                                                   * 0203 0D             .
L0204      fcb    $58                                                   * 0204 58             X
L0205      fcb    $08                                                   * 0205 08             .
           fcb    $20                                                   * 0206 20
           fcb    $08                                                   * 0207 08             .
L0208      fcb    $2F                                                   * 0208 2F             /
           fcb    $64                                                   * 0209 64             d
           fcb    $64                                                   * 020A 64             d
           fcb    $2F                                                   * 020B 2F             /
           fcb    $62                                                   * 020C 62             b
           fcb    $62                                                   * 020D 62             b
           fcb    $73                                                   * 020E 73             s
           fcb    $2F                                                   * 020F 2F             /
           fcb    $42                                                   * 0210 42             B
           fcb    $42                                                   * 0211 42             B
           fcb    $53                                                   * 0212 53             S
           fcb    $2E                                                   * 0213 2E             .
           fcb    $75                                                   * 0214 75             u
           fcb    $73                                                   * 0215 73             s
           fcb    $65                                                   * 0216 65             e
           fcb    $72                                                   * 0217 72             r
           fcb    $73                                                   * 0218 73             s
           fcb    $74                                                   * 0219 74             t
           fcb    $61                                                   * 021A 61             a
           fcb    $74                                                   * 021B 74             t
           fcb    $73                                                   * 021C 73             s
           fcb    $0D                                                   * 021D 0D             .
L021E      fcb    $49                                                   * 021E 49             I
           fcb    $27                                                   * 021F 27             '
           fcb    $6D                                                   * 0220 6D             m
           fcb    $20                                                   * 0221 20
           fcb    $73                                                   * 0222 73             s
           fcb    $6F                                                   * 0223 6F             o
           fcb    $72                                                   * 0224 72             r
           fcb    $72                                                   * 0225 72             r
           fcb    $79                                                   * 0226 79             y
           fcb    $20                                                   * 0227 20
           fcb    $62                                                   * 0228 62             b
           fcb    $75                                                   * 0229 75             u
           fcb    $74                                                   * 022A 74             t
           fcb    $20                                                   * 022B 20
           fcb    $79                                                   * 022C 79             y
           fcb    $6F                                                   * 022D 6F             o
           fcb    $75                                                   * 022E 75             u
           fcb    $20                                                   * 022F 20
           fcb    $64                                                   * 0230 64             d
           fcb    $6F                                                   * 0231 6F             o
           fcb    $6E                                                   * 0232 6E             n
           fcb    $27                                                   * 0233 27             '
           fcb    $74                                                   * 0234 74             t
           fcb    $20                                                   * 0235 20
           fcb    $68                                                   * 0236 68             h
           fcb    $61                                                   * 0237 61             a
           fcb    $76                                                   * 0238 76             v
           fcb    $65                                                   * 0239 65             e
           fcb    $20                                                   * 023A 20
           fcb    $61                                                   * 023B 61             a
           fcb    $6E                                                   * 023C 6E             n
           fcb    $79                                                   * 023D 79             y
           fcb    $20                                                   * 023E 20
           fcb    $6D                                                   * 023F 6D             m
           fcb    $6F                                                   * 0240 6F             o
           fcb    $72                                                   * 0241 72             r
           fcb    $65                                                   * 0242 65             e
           fcb    $20                                                   * 0243 20
           fcb    $74                                                   * 0244 74             t
           fcb    $69                                                   * 0245 69             i
           fcb    $6D                                                   * 0246 6D             m
           fcb    $65                                                   * 0247 65             e
           fcb    $20                                                   * 0248 20
           fcb    $6F                                                   * 0249 6F             o
           fcb    $6E                                                   * 024A 6E             n
           fcb    $2D                                                   * 024B 2D             -
           fcb    $6C                                                   * 024C 6C             l
           fcb    $69                                                   * 024D 69             i
           fcb    $6E                                                   * 024E 6E             n
           fcb    $65                                                   * 024F 65             e
           fcb    $0D                                                   * 0250 0D             .
start      leax   L007D,PC                                              * 0251 30 8D FE 28    0.~(
           lda    #2                                                    * 0255 86 02          ..
           os9    I$Open                                                * 0257 10 3F 84       .?.
           bcc    L025E                                                 * 025A 24 02          $.
           lda    #255                                                  * 025C 86 FF          ..
L025E      sta    U0005,U                                               * 025E A7 45          'E
           ldy    #0                                                    * 0260 10 8E 00 00    ....
           os9    F$SUser                                               * 0264 10 3F 1C       .?.
           lbcs   L07A1                                                 * 0267 10 25 05 36    .%.6
           clr    U000D,U                                               * 026B 6F 4D          oM
           leax   L00B3,PC                                              * 026D 30 8D FE 42    0.~B
           lda    #1                                                    * 0271 86 01          ..
           os9    I$Open                                                * 0273 10 3F 84       .?.
           bcs    L0294                                                 * 0276 25 1C          %.
           leax   <U0069,U                                              * 0278 30 C8 69       0Hi
           sta    U0004,U                                               * 027B A7 44          'D
L027D      ldy    #200                                                  * 027D 10 8E 00 C8    ...H
           lda    U0004,U                                               * 0281 A6 44          &D
           os9    I$ReadLn                                              * 0283 10 3F 8B       .?.
           bcs    L028F                                                 * 0286 25 07          %.
           lda    #1                                                    * 0288 86 01          ..
           os9    I$WritLn                                              * 028A 10 3F 8C       .?.
           bra    L027D                                                 * 028D 20 EE           n
L028F      lda    U0004,U                                               * 028F A6 44          &D
           os9    I$Close                                               * 0291 10 3F 8F       .?.
L0294      leax   L00E1,PC                                              * 0294 30 8D FE 49    0.~I
           ldy    #200                                                  * 0298 10 8E 00 C8    ...H
           lda    #1                                                    * 029C 86 01          ..
           os9    I$WritLn                                              * 029E 10 3F 8C       .?.
           leax   L00F3,PC                                              * 02A1 30 8D FE 4E    0.~N
           ldy    #200                                                  * 02A5 10 8E 00 C8    ...H
           os9    I$WritLn                                              * 02A9 10 3F 8C       .?.
           leax   L0112,PC                                              * 02AC 30 8D FE 62    0.~b
           ldy    #200                                                  * 02B0 10 8E 00 C8    ...H
           os9    I$WritLn                                              * 02B4 10 3F 8C       .?.
L02B7      leax   L0080,PC                                              * 02B7 30 8D FD C5    0.}E
           ldy    L0098,PC                                              * 02BB 10 AE 8D FD D8 ...}X
           lda    #1                                                    * 02C0 86 01          ..
           os9    I$Write                                               * 02C2 10 3F 8A       .?.
           leax   >U0131,U                                              * 02C5 30 C9 01 31    0I.1
           clra                                                         * 02C9 4F             O
           ldy    #200                                                  * 02CA 10 8E 00 C8    ...H
           os9    I$ReadLn                                              * 02CE 10 3F 8B       .?.
           bcs    L02B7                                                 * 02D1 25 E4          %d
           sty    <U0019,U                                              * 02D3 10 AF C8 19    ./H.
           lbsr   L0869                                                 * 02D7 17 05 8F       ...
           lbsr   L066E                                                 * 02DA 17 03 91       ...
           leax   L009A,PC                                              * 02DD 30 8D FD B9    0.}9
           ldy    L00B1,PC                                              * 02E1 10 AE 8D FD CB ...}K
           lda    #1                                                    * 02E6 86 01          ..
           os9    I$Write                                               * 02E8 10 3F 8A       .?.
           leax   >U01F9,U                                              * 02EB 30 C9 01 F9    0I.y
L02EF      ldy    #1                                                    * 02EF 10 8E 00 01    ....
           clra                                                         * 02F3 4F             O
           os9    I$Read                                                * 02F4 10 3F 89       .?.
           bcs    L02EF                                                 * 02F7 25 F6          %v
           lda    0,X                                                   * 02F9 A6 84          &.
           cmpa   #8                                                    * 02FB 81 08          ..
           beq    L032F                                                 * 02FD 27 30          '0
           pshs   X                                                     * 02FF 34 10          4.
           leax   L0204,PC                                              * 0301 30 8D FE FF    0.~.
           ldy    #1                                                    * 0305 10 8E 00 01    ....
           lda    #1                                                    * 0309 86 01          ..
           os9    I$Write                                               * 030B 10 3F 8A       .?.
           puls   X                                                     * 030E 35 10          5.
           lda    ,X+                                                   * 0310 A6 80          &.
           cmpa   #13                                                   * 0312 81 0D          ..
           bne    L02EF                                                 * 0314 26 D9          &Y
           leax   >U01F9,U                                              * 0316 30 C9 01 F9    0I.y
           lbsr   L0869                                                 * 031A 17 05 4C       ..L
           leax   L0126,PC                                              * 031D 30 8D FE 05    0.~.
           ldy    #2                                                    * 0321 10 8E 00 02    ....
           lda    #1                                                    * 0325 86 01          ..
           os9    I$WritLn                                              * 0327 10 3F 8C       .?.
           lbsr   L0685                                                 * 032A 17 03 58       ..X
           bra    L0351                                                 * 032D 20 22           "
L032F      leay   >U01F9,U                                              * 032F 31 C9 01 F9    1I.y
           sty    <U0015,U                                              * 0333 10 AF C8 15    ./H.
           cmpx   <U0015,U                                              * 0337 AC C8 15       ,H.
           beq    L02EF                                                 * 033A 27 B3          '3
           pshs   X                                                     * 033C 34 10          4.
           leax   L0205,PC                                              * 033E 30 8D FE C3    0.~C
           ldy    #3                                                    * 0342 10 8E 00 03    ....
           lda    #1                                                    * 0346 86 01          ..
           os9    I$Write                                               * 0348 10 3F 8A       .?.
           puls   X                                                     * 034B 35 10          5.
           leax   -$01,X                                                * 034D 30 1F          0.
           bra    L02EF                                                 * 034F 20 9E           .
L0351      leax   L0180,PC                                              * 0351 30 8D FE 2B    0.~+
           ldy    #200                                                  * 0355 10 8E 00 C8    ...H
           lda    #1                                                    * 0359 86 01          ..
           os9    I$WritLn                                              * 035B 10 3F 8C       .?.
           leax   L00BF,PC                                              * 035E 30 8D FD 5D    0.}]
           lda    #1                                                    * 0362 86 01          ..
           os9    I$Open                                                * 0364 10 3F 84       .?.
           lbcs   L07A1                                                 * 0367 10 25 04 36    .%.6
           sta    U0003,U                                               * 036B A7 43          'C
L036D      leax   <U0069,U                                              * 036D 30 C8 69       0Hi
           ldb    #200                                                  * 0370 C6 C8          FH
           lda    #13                                                   * 0372 86 0D          ..
L0374      sta    ,X+                                                   * 0374 A7 80          '.
           decb                                                         * 0376 5A             Z
           bne    L0374                                                 * 0377 26 FB          &{
           leax   <U0069,U                                              * 0379 30 C8 69       0Hi
           clr    U000C,U                                               * 037C 6F 4C          oL
           lda    U0003,U                                               * 037E A6 43          &C
           ldy    #200                                                  * 0380 10 8E 00 C8    ...H
           os9    I$ReadLn                                              * 0384 10 3F 8B       .?.
           bcs    L0403                                                 * 0387 25 7A          %z
           lbsr   L0869                                                 * 0389 17 04 DD       ..]
           leay   >U0131,U                                              * 038C 31 C9 01 31    1I.1
L0390      lda    ,Y+                                                   * 0390 A6 A0          &
           cmpa   #13                                                   * 0392 81 0D          ..
           beq    L03A4                                                 * 0394 27 0E          '.
           cmpa   #90                                                   * 0396 81 5A          .Z
           bls    L039C                                                 * 0398 23 02          #.
           anda   #223                                                  * 039A 84 DF          ._
L039C      cmpa   ,X+                                                   * 039C A1 80          !.
           bne    L036D                                                 * 039E 26 CD          &M
           inc    U000C,U                                               * 03A0 6C 4C          lL
           bra    L0390                                                 * 03A2 20 EC           l
L03A4      lda    ,X+                                                   * 03A4 A6 80          &.
           cmpa   #44                                                   * 03A6 81 2C          .,
           bne    L036D                                                 * 03A8 26 C3          &C
           leay   >U01F9,U                                              * 03AA 31 C9 01 F9    1I.y
L03AE      lda    ,Y+                                                   * 03AE A6 A0          &
           cmpa   #13                                                   * 03B0 81 0D          ..
           beq    L03C0                                                 * 03B2 27 0C          '.
           cmpa   #90                                                   * 03B4 81 5A          .Z
           bls    L03BA                                                 * 03B6 23 02          #.
           anda   #223                                                  * 03B8 84 DF          ._
L03BA      cmpa   ,X+                                                   * 03BA A1 80          !.
           bne    L036D                                                 * 03BC 26 AF          &/
           bra    L03AE                                                 * 03BE 20 EE           n
L03C0      lda    ,X+                                                   * 03C0 A6 80          &.
           cmpa   #44                                                   * 03C2 81 2C          .,
           bne    L036D                                                 * 03C4 26 A7          &'
           leay   >U0389,U                                              * 03C6 31 C9 03 89    1I..
           clr    <U0017,U                                              * 03CA 6F C8 17       oH.
L03CD      inc    <U0017,U                                              * 03CD 6C C8 17       lH.
           lda    ,X+                                                   * 03D0 A6 80          &.
           cmpa   #44                                                   * 03D2 81 2C          .,
           beq    L03DE                                                 * 03D4 27 08          '.
           cmpa   #13                                                   * 03D6 81 0D          ..
           beq    L03DE                                                 * 03D8 27 04          '.
           sta    ,Y+                                                   * 03DA A7 A0          '
           bra    L03CD                                                 * 03DC 20 EF           o
L03DE      pshs   Y,X                                                   * 03DE 34 30          40
           lbsr   L07A4                                                 * 03E0 17 03 C1       ..A
           puls   Y,X                                                   * 03E3 35 30          50
           lda    #13                                                   * 03E5 86 0D          ..
           sta    0,Y                                                   * 03E7 A7 A4          '$
           inc    <U0017,U                                              * 03E9 6C C8 17       lH.
           bsr    L0437                                                 * 03EC 8D 49          .I
           std    <U001D,U                                              * 03EE ED C8 1D       mH.
           tfr    D,Y                                                   * 03F1 1F 02          ..
           os9    F$SUser                                               * 03F3 10 3F 1C       .?.
           bsr    L0437                                                 * 03F6 8D 3F          .?
           std    <U001B,U                                              * 03F8 ED C8 1B       mH.
           lda    U0003,U                                               * 03FB A6 43          &C
           os9    I$Close                                               * 03FD 10 3F 8F       .?.
           lbra   L04A5                                                 * 0400 16 00 A2       .."
L0403      leax   L00C9,PC                                              * 0403 30 8D FC C2    0.|B
           ldy    #200                                                  * 0407 10 8E 00 C8    ...H
           lda    #1                                                    * 040B 86 01          ..
           os9    I$WritLn                                              * 040D 10 3F 8C       .?.
           lda    U0003,U                                               * 0410 A6 43          &C
           os9    I$Close                                               * 0412 10 3F 8F       .?.
           inc    U000D,U                                               * 0415 6C 4D          lM
           lda    U000D,U                                               * 0417 A6 4D          &M
           cmpa   #3                                                    * 0419 81 03          ..
           bgt    L0425                                                 * 041B 2E 08          ..
           lbra   L02B7                                                 * 041D 16 FE 97       .~.
L0420      ldd    #0                                                    * 0420 CC 00 00       L..
           puls   PC,Y                                                  * 0423 35 A0          5
L0425      leax   L0157,PC                                              * 0425 30 8D FD 2E    0.}.
           ldy    #200                                                  * 0429 10 8E 00 C8    ...H
           lda    #1                                                    * 042D 86 01          ..
           os9    I$WritLn                                              * 042F 10 3F 8C       .?.
           pshs   U                                                     * 0432 34 40          4@
           lbra   L069E                                                 * 0434 16 02 67       ..g
L0437      pshs   Y                                                     * 0437 34 20          4
L0439      lda    ,X+                                                   * 0439 A6 80          &.
           cmpa   #13                                                   * 043B 81 0D          ..
           beq    L0420                                                 * 043D 27 E1          'a
           cmpa   #48                                                   * 043F 81 30          .0
           bcs    L0439                                                 * 0441 25 F6          %v
           cmpa   #57                                                   * 0443 81 39          .9
           bhi    L0439                                                 * 0445 22 F2          "r
           leax   -$01,X                                                * 0447 30 1F          0.
L0449      lda    ,X+                                                   * 0449 A6 80          &.
           cmpa   #48                                                   * 044B 81 30          .0
           bcs    L0455                                                 * 044D 25 06          %.
           cmpa   #57                                                   * 044F 81 39          .9
           bhi    L0455                                                 * 0451 22 02          ".
           bra    L0449                                                 * 0453 20 F4           t
L0455      pshs   X                                                     * 0455 34 10          4.
           leax   -$01,X                                                * 0457 30 1F          0.
           clr    <U0015,U                                              * 0459 6F C8 15       oH.
           clr    <U0016,U                                              * 045C 6F C8 16       oH.
           ldd    #1                                                    * 045F CC 00 01       L..
           std    <U0013,U                                              * 0462 ED C8 13       mH.
L0465      lda    ,-X                                                   * 0465 A6 82          &.
           cmpa   #48                                                   * 0467 81 30          .0
           bcs    L049E                                                 * 0469 25 33          %3
           cmpa   #57                                                   * 046B 81 39          .9
           bhi    L049E                                                 * 046D 22 2F          "/
           suba   #48                                                   * 046F 80 30          .0
           sta    U000B,U                                               * 0471 A7 4B          'K
           ldd    #0                                                    * 0473 CC 00 00       L..
L0476      tst    U000B,U                                               * 0476 6D 4B          mK
           beq    L0481                                                 * 0478 27 07          '.
           addd   <U0013,U                                              * 047A E3 C8 13       cH.
           dec    U000B,U                                               * 047D 6A 4B          jK
           bra    L0476                                                 * 047F 20 F5           u
L0481      addd   <U0015,U                                              * 0481 E3 C8 15       cH.
           std    <U0015,U                                              * 0484 ED C8 15       mH.
           lda    #10                                                   * 0487 86 0A          ..
           sta    U000B,U                                               * 0489 A7 4B          'K
           ldd    #0                                                    * 048B CC 00 00       L..
L048E      tst    U000B,U                                               * 048E 6D 4B          mK
           beq    L0499                                                 * 0490 27 07          '.
           addd   <U0013,U                                              * 0492 E3 C8 13       cH.
           dec    U000B,U                                               * 0495 6A 4B          jK
           bra    L048E                                                 * 0497 20 F5           u
L0499      std    <U0013,U                                              * 0499 ED C8 13       mH.
           bra    L0465                                                 * 049C 20 C7           G
L049E      ldd    <U0015,U                                              * 049E EC C8 15       lH.
           puls   X                                                     * 04A1 35 10          5.
           puls   PC,Y                                                  * 04A3 35 A0          5
L04A5      leax   L0176,PC                                              * 04A5 30 8D FC CD    0.|M
           lda    #1                                                    * 04A9 86 01          ..
           ldy    #9                                                    * 04AB 10 8E 00 09    ....
           os9    I$Write                                               * 04AF 10 3F 8A       .?.
           lbcs   L07A1                                                 * 04B2 10 25 02 EB    .%.k
           leax   >U0131,U                                              * 04B6 30 C9 01 31    0I.1
           ldb    U000C,U                                               * 04BA E6 4C          fL
           clra                                                         * 04BC 4F             O
           tfr    D,Y                                                   * 04BD 1F 02          ..
           lda    U0005,U                                               * 04BF A6 45          &E
           bmi    L04C6                                                 * 04C1 2B 03          +.
           os9    I$Write                                               * 04C3 10 3F 8A       .?.
L04C6      lbcs   L07A1                                                 * 04C6 10 25 02 D7    .%.W
           lda    #1                                                    * 04CA 86 01          ..
           leay   $01,Y                                                 * 04CC 31 21          1!
           os9    I$WritLn                                              * 04CE 10 3F 8C       .?.
           lbcs   L07A1                                                 * 04D1 10 25 02 CC    .%.L
           leax   L01A3,PC                                              * 04D5 30 8D FC CA    0.|J
           ldy    #200                                                  * 04D9 10 8E 00 C8    ...H
           lda    #1                                                    * 04DD 86 01          ..
           os9    I$WritLn                                              * 04DF 10 3F 8C       .?.
           ldb    #21                                                   * 04E2 C6 15          F.
           subb   U000C,U                                               * 04E4 E0 4C          `L
           clra                                                         * 04E6 4F             O
           tfr    D,Y                                                   * 04E7 1F 02          ..
           leax   L012F,PC                                              * 04E9 30 8D FC 42    0.|B
           lda    U0005,U                                               * 04ED A6 45          &E
           bmi    L04F4                                                 * 04EF 2B 03          +.
           os9    I$Write                                               * 04F1 10 3F 8A       .?.
L04F4      lbcs   L07A1                                                 * 04F4 10 25 02 A9    .%.)
           pshs   U                                                     * 04F8 34 40          4@
           lda    #1                                                    * 04FA 86 01          ..
           os9    I$Close                                               * 04FC 10 3F 8F       .?.
           lda    U0005,U                                               * 04FF A6 45          &E
           bmi    L0529                                                 * 0501 2B 26          +&
           os9    I$Dup                                                 * 0503 10 3F 82       .?.
           leax   L0128,PC                                              * 0506 30 8D FC 1E    0.|.
           leau   L012D,PC                                              * 050A 33 8D FC 1F    3.|.
           ldy    #2                                                    * 050E 10 8E 00 02    ....
           lda    #17                                                   * 0512 86 11          ..
           ldb    #3                                                    * 0514 C6 03          F.
           os9    F$Fork                                                * 0516 10 3F 03       .?.
           lbcs   L07A1                                                 * 0519 10 25 02 84    .%..
           os9    F$Wait                                                * 051D 10 3F 04       .?.
           lbcs   L07A1                                                 * 0520 10 25 02 7D    .%.}
           lda    #1                                                    * 0524 86 01          ..
           os9    I$Close                                               * 0526 10 3F 8F       .?.
L0529      clra                                                         * 0529 4F             O
           os9    I$Dup                                                 * 052A 10 3F 82       .?.
           puls   U                                                     * 052D 35 40          5@
           leax   L0208,PC                                              * 052F 30 8D FC D5    0.|U
           lda    #3                                                    * 0533 86 03          ..
           os9    I$Open                                                * 0535 10 3F 84       .?.
           bcc    L0543                                                 * 0538 24 09          $.
           ldb    #27                                                   * 053A C6 1B          F.
           os9    I$Create                                              * 053C 10 3F 83       .?.
           lbcs   L07A1                                                 * 053F 10 25 02 5E    .%.^
L0543      sta    <U0010,U                                              * 0543 A7 C8 10       'H.
L0546      leax   <U0023,U                                              * 0546 30 C8 23       0H#
           ldy    #32                                                   * 0549 10 8E 00 20    ...
           lda    <U0010,U                                              * 054D A6 C8 10       &H.
           os9    I$Read                                                * 0550 10 3F 89       .?.
           bcs    L0560                                                 * 0553 25 0B          %.
           ldd    <U0023,U                                              * 0555 EC C8 23       lH#
           cmpd   <U001D,U                                              * 0558 10 A3 C8 1D    .#H.
           bne    L0546                                                 * 055C 26 E8          &h
           bra    L0579                                                 * 055E 20 19           .
L0560      cmpb   #211                                                  * 0560 C1 D3          AS
           lbne   L07A1                                                 * 0562 10 26 02 3B    .&.;
           lbra   L05EA                                                 * 0566 16 00 81       ...
L0569      leax   L021E,PC                                              * 0569 30 8D FC B1    0.|1
           ldy    #200                                                  * 056D 10 8E 00 C8    ...H
           lda    #1                                                    * 0571 86 01          ..
           os9    I$WritLn                                              * 0573 10 3F 8C       .?.
           lbra   L069E                                                 * 0576 16 01 25       ..%
L0579      ldd    <U0025,U                                              * 0579 EC C8 25       lH%
           addd   #1                                                    * 057C C3 00 01       C..
           std    <U0025,U                                              * 057F ED C8 25       mH%
           leax   <U0027,U                                              * 0582 30 C8 27       0H'
           os9    F$Time                                                * 0585 10 3F 15       .?.
           lda    <U0035,U                                              * 0588 A6 C8 35       &H5
           cmpa   <U0027,U                                              * 058B A1 C8 27       !H'
           bne    L059B                                                 * 058E 26 0B          &.
           ldd    <U0036,U                                              * 0590 EC C8 36       lH6
           cmpd   <U0028,U                                              * 0593 10 A3 C8 28    .#H(
           bne    L059B                                                 * 0597 26 02          &.
           bra    L05A1                                                 * 0599 20 06           .
L059B      ldd    <U001B,U                                              * 059B EC C8 1B       lH.
           std    <U003B,U                                              * 059E ED C8 3B       mH;
L05A1      ldd    <U003B,U                                              * 05A1 EC C8 3B       lH;
           cmpd   #1                                                    * 05A4 10 83 00 01    ....
           lbeq   L0569                                                 * 05A8 10 27 FF BD    .'.=
           lda    <U0010,U                                              * 05AC A6 C8 10       &H.
           ldb    #5                                                    * 05AF C6 05          F.
           pshs   U                                                     * 05B1 34 40          4@
           os9    I$GetStt                                              * 05B3 10 3F 8D       .?.
           tfr    U,D                                                   * 05B6 1F 30          .0
           subd   #32                                                   * 05B8 83 00 20       ..
           bge    L05BF                                                 * 05BB 2C 02          ,.
           leax   -$01,X                                                * 05BD 30 1F          0.
L05BF      ldu    0,S                                                   * 05BF EE E4          nd
           stx    <U001F,U                                              * 05C1 AF C8 1F       /H.
           std    <U0021,U                                              * 05C4 ED C8 21       mH!
           tfr    D,Y                                                   * 05C7 1F 02          ..
           lda    <U0010,U                                              * 05C9 A6 C8 10       &H.
           tfr    Y,U                                                   * 05CC 1F 23          .#
           os9    I$Seek                                                * 05CE 10 3F 88       .?.
           lbcs   L07A1                                                 * 05D1 10 25 01 CC    .%.L
           puls   U                                                     * 05D5 35 40          5@
           leax   <U0023,U                                              * 05D7 30 C8 23       0H#
           ldy    #32                                                   * 05DA 10 8E 00 20    ...
           lda    <U0010,U                                              * 05DE A6 C8 10       &H.
           os9    I$Write                                               * 05E1 10 3F 8A       .?.
           os9    I$Close                                               * 05E4 10 3F 8F       .?.
           lbra   L064D                                                 * 05E7 16 00 63       ..c
L05EA      leax   <U0023,U                                              * 05EA 30 C8 23       0H#
           ldd    #1                                                    * 05ED CC 00 01       L..
           std    <U0025,U                                              * 05F0 ED C8 25       mH%
           ldd    #0                                                    * 05F3 CC 00 00       L..
           std    <U002D,U                                              * 05F6 ED C8 2D       mH-
           std    <U002F,U                                              * 05F9 ED C8 2F       mH/
           std    <U0033,U                                              * 05FC ED C8 33       mH3
           std    <U0031,U                                              * 05FF ED C8 31       mH1
           std    <U0035,U                                              * 0602 ED C8 35       mH5
           std    <U0037,U                                              * 0605 ED C8 37       mH7
           std    <U0039,U                                              * 0608 ED C8 39       mH9
           ldd    <U001B,U                                              * 060B EC C8 1B       lH.
           std    <U003B,U                                              * 060E ED C8 3B       mH;
           ldd    <U001D,U                                              * 0611 EC C8 1D       lH.
           std    <U0023,U                                              * 0614 ED C8 23       mH#
           leax   <U0027,U                                              * 0617 30 C8 27       0H'
           os9    F$Time                                                * 061A 10 3F 15       .?.
           lbcs   L07A1                                                 * 061D 10 25 01 80    .%..
           lda    <U0010,U                                              * 0621 A6 C8 10       &H.
           ldb    #5                                                    * 0624 C6 05          F.
           pshs   U                                                     * 0626 34 40          4@
           os9    I$GetStt                                              * 0628 10 3F 8D       .?.
           lbcs   L07A1                                                 * 062B 10 25 01 72    .%.r
           tfr    U,D                                                   * 062F 1F 30          .0
           puls   U                                                     * 0631 35 40          5@
           stx    <U001F,U                                              * 0633 AF C8 1F       /H.
           std    <U0021,U                                              * 0636 ED C8 21       mH!
           leax   <U0023,U                                              * 0639 30 C8 23       0H#
           ldy    #32                                                   * 063C 10 8E 00 20    ...
           lda    <U0010,U                                              * 0640 A6 C8 10       &H.
           os9    I$Write                                               * 0643 10 3F 8A       .?.
           lbcs   L07A1                                                 * 0646 10 25 01 57    .%.W
           os9    I$Close                                               * 064A 10 3F 8F       .?.
L064D      pshs   U                                                     * 064D 34 40          4@
           ldb    <U0017,U                                              * 064F E6 C8 17       fH.
           clra                                                         * 0652 4F             O
           tfr    D,Y                                                   * 0653 1F 02          ..
           leax   L00B8,PC                                              * 0655 30 8D FA 5F    0.z_
           leau   >U0389,U                                              * 0659 33 C9 03 89    3I..
           lda    #17                                                   * 065D 86 11          ..
           ldb    #3                                                    * 065F C6 03          F.
           os9    F$Fork                                                * 0661 10 3F 03       .?.
           lbcs   L07A1                                                 * 0664 10 25 01 39    .%.9
           os9    F$Wait                                                * 0668 10 3F 04       .?.
           lbra   L06D1                                                 * 066B 16 00 63       ..c
L066E      leax   <U0049,U                                              * 066E 30 C8 49       0HI
           clra                                                         * 0671 4F             O
           clrb                                                         * 0672 5F             _
           os9    I$GetStt                                              * 0673 10 3F 8D       .?.
           leax   <$FFE0,X                                              * 0676 30 88 E0       0.`
           clr    <$0024,X                                              * 0679 6F 88 24       o.$
           leax   <U0049,U                                              * 067C 30 C8 49       0HI
           clra                                                         * 067F 4F             O
           clrb                                                         * 0680 5F             _
           os9    I$SetStt                                              * 0681 10 3F 8E       .?.
           rts                                                          * 0684 39             9
L0685      leax   <U0049,U                                              * 0685 30 C8 49       0HI
           clra                                                         * 0688 4F             O
           clrb                                                         * 0689 5F             _
           os9    I$GetStt                                              * 068A 10 3F 8D       .?.
           leax   <$FFE0,X                                              * 068D 30 88 E0       0.`
           lda    #1                                                    * 0690 86 01          ..
           sta    <$0024,X                                              * 0692 A7 88 24       '.$
           leax   <U0049,U                                              * 0695 30 C8 49       0HI
           clra                                                         * 0698 4F             O
           clrb                                                         * 0699 5F             _
           os9    I$SetStt                                              * 069A 10 3F 8E       .?.
           rts                                                          * 069D 39             9
L069E      puls   U                                                     * 069E 35 40          5@
           ldy    #0                                                    * 06A0 10 8E 00 00    ....
           os9    F$SUser                                               * 06A4 10 3F 1C       .?.
           leax   L01FF,PC                                              * 06A7 30 8D FB 54    0.{T
           lda    #1                                                    * 06AB 86 01          ..
           os9    I$Open                                                * 06AD 10 3F 84       .?.
           bcs    L06CD                                                 * 06B0 25 1B          %.
           sta    U0002,U                                               * 06B2 A7 42          'B
L06B4      leax   <U0069,U                                              * 06B4 30 C8 69       0Hi
           lda    U0002,U                                               * 06B7 A6 42          &B
           ldy    #200                                                  * 06B9 10 8E 00 C8    ...H
           os9    I$ReadLn                                              * 06BD 10 3F 8B       .?.
           bcs    L06CD                                                 * 06C0 25 0B          %.
           lda    #1                                                    * 06C2 86 01          ..
           ldy    #200                                                  * 06C4 10 8E 00 C8    ...H
           os9    I$WritLn                                              * 06C8 10 3F 8C       .?.
           bra    L06B4                                                 * 06CB 20 E7           g
L06CD      clrb                                                         * 06CD 5F             _
           os9    F$Exit                                                * 06CE 10 3F 06       .?.
L06D1      puls   U                                                     * 06D1 35 40          5@
           ldy    #0                                                    * 06D3 10 8E 00 00    ....
           os9    F$SUser                                               * 06D7 10 3F 1C       .?.
           leax   L01FF,PC                                              * 06DA 30 8D FB 21    0.{!
           lda    #1                                                    * 06DE 86 01          ..
           os9    I$Open                                                * 06E0 10 3F 84       .?.
           bcs    L0700                                                 * 06E3 25 1B          %.
           sta    U0002,U                                               * 06E5 A7 42          'B
L06E7      leax   <U0069,U                                              * 06E7 30 C8 69       0Hi
           lda    U0002,U                                               * 06EA A6 42          &B
           ldy    #200                                                  * 06EC 10 8E 00 C8    ...H
           os9    I$ReadLn                                              * 06F0 10 3F 8B       .?.
           bcs    L0700                                                 * 06F3 25 0B          %.
           lda    #1                                                    * 06F5 86 01          ..
           ldy    #200                                                  * 06F7 10 8E 00 C8    ...H
           os9    I$WritLn                                              * 06FB 10 3F 8C       .?.
           bra    L06E7                                                 * 06FE 20 E7           g
L0700      cmpb   #211                                                  * 0700 C1 D3          AS
           lbne   L07A1                                                 * 0702 10 26 00 9B    .&..
           leax   L0208,PC                                              * 0706 30 8D FA FE    0.z~
           lda    #3                                                    * 070A 86 03          ..
           os9    I$Open                                                * 070C 10 3F 84       .?.
           sta    <U0010,U                                              * 070F A7 C8 10       'H.
           lbcs   L07A1                                                 * 0712 10 25 00 8B    .%..
           pshs   U                                                     * 0716 34 40          4@
           ldx    <U001F,U                                              * 0718 AE C8 1F       .H.
           ldu    <U0021,U                                              * 071B EE C8 21       nH!
           os9    I$Seek                                                * 071E 10 3F 88       .?.
           puls   U                                                     * 0721 35 40          5@
           leax   <U0023,U                                              * 0723 30 C8 23       0H#
           ldy    #32                                                   * 0726 10 8E 00 20    ...
           lda    <U0010,U                                              * 072A A6 C8 10       &H.
           os9    I$Read                                                * 072D 10 3F 89       .?.
           leax   <U0035,U                                              * 0730 30 C8 35       0H5
           os9    F$Time                                                * 0733 10 3F 15       .?.
           ldd    <U001B,U                                              * 0736 EC C8 1B       lH.
           cmpd   #0                                                    * 0739 10 83 00 00    ....
           beq    L0781                                                 * 073D 27 42          'B
           lda    <U0027,U                                              * 073F A6 C8 27       &H'
           cmpa   <U0035,U                                              * 0742 A1 C8 35       !H5
           bne    L077B                                                 * 0745 26 34          &4
           ldd    <U0028,U                                              * 0747 EC C8 28       lH(
           cmpd   <U0036,U                                              * 074A 10 A3 C8 36    .#H6
           bne    L077B                                                 * 074E 26 2B          &+
           lda    <U0038,U                                              * 0750 A6 C8 38       &H8
           suba   <U002A,U                                              * 0753 A0 C8 2A        H*
           ldb    #60                                                   * 0756 C6 3C          F<
           mul                                                          * 0758 3D             =
           std    <U001B,U                                              * 0759 ED C8 1B       mH.
           lda    <U0039,U                                              * 075C A6 C8 39       &H9
           suba   <U002B,U                                              * 075F A0 C8 2B        H+
           tfr    A,B                                                   * 0762 1F 89          ..
           sex                                                          * 0764 1D             .
           addd   <U001B,U                                              * 0765 E3 C8 1B       cH.
           std    <U001B,U                                              * 0768 ED C8 1B       mH.
           ldd    <U003B,U                                              * 076B EC C8 3B       lH;
           subd   <U001B,U                                              * 076E A3 C8 1B       #H.
           bgt    L0776                                                 * 0771 2E 03          ..
           ldd    #1                                                    * 0773 CC 00 01       L..
L0776      std    <U003B,U                                              * 0776 ED C8 3B       mH;
           bra    L0781                                                 * 0779 20 06           .
L077B      ldd    <U001B,U                                              * 077B EC C8 1B       lH.
           std    <U003B,U                                              * 077E ED C8 3B       mH;
L0781      lda    <U0010,U                                              * 0781 A6 C8 10       &H.
           pshs   U                                                     * 0784 34 40          4@
           ldx    <U001F,U                                              * 0786 AE C8 1F       .H.
           ldu    <U0021,U                                              * 0789 EE C8 21       nH!
           os9    I$Seek                                                * 078C 10 3F 88       .?.
           puls   U                                                     * 078F 35 40          5@
           leax   <U0023,U                                              * 0791 30 C8 23       0H#
           ldy    #32                                                   * 0794 10 8E 00 20    ...
           lda    <U0010,U                                              * 0798 A6 C8 10       &H.
           os9    I$Write                                               * 079B 10 3F 8A       .?.
           bcs    L07A1                                                 * 079E 25 01          %.
           clrb                                                         * 07A0 5F             _
L07A1      os9    F$Exit                                                * 07A1 10 3F 06       .?.
L07A4      leax   L01B8,PC                                              * 07A4 30 8D FA 10    0.z.
           lda    #3                                                    * 07A8 86 03          ..
           os9    I$Open                                                * 07AA 10 3F 84       .?.
           bcc    L07D6                                                 * 07AD 24 27          $'
           cmpb   #216                                                  * 07AF C1 D8          AX
           lbne   L07A1                                                 * 07B1 10 26 FF EC    .&.l
           leax   L01B8,PC                                              * 07B5 30 8D F9 FF    0.y.
           lda    #3                                                    * 07B9 86 03          ..
           ldb    #11                                                   * 07BB C6 0B          F.
           os9    I$Create                                              * 07BD 10 3F 83       .?.
           leax   L01C0,PC                                              * 07C0 30 8D F9 FC    0.y|
           ldy    #200                                                  * 07C4 10 8E 00 C8    ...H
           os9    I$WritLn                                              * 07C8 10 3F 8C       .?.
           leax   L01DD,PC                                              * 07CB 30 8D FA 0E    0.z.
           ldy    #200                                                  * 07CF 10 8E 00 C8    ...H
           os9    I$WritLn                                              * 07D3 10 3F 8C       .?.
L07D6      sta    U0006,U                                               * 07D6 A7 46          'F
           pshs   U                                                     * 07D8 34 40          4@
           ldb    #2                                                    * 07DA C6 02          F.
           os9    I$GetStt                                              * 07DC 10 3F 8D       .?.
           os9    I$Seek                                                * 07DF 10 3F 88       .?.
           puls   U                                                     * 07E2 35 40          5@
           leax   >U0131,U                                              * 07E4 30 C9 01 31    0I.1
           ldy    <U0019,U                                              * 07E8 10 AE C8 19    ..H.
           leay   -$01,Y                                                * 07EC 31 3F          1?
           os9    I$Write                                               * 07EE 10 3F 8A       .?.
           sty    <U0015,U                                              * 07F1 10 AF C8 15    ./H.
           ldd    #24                                                   * 07F5 CC 00 18       L..
           subd   <U0015,U                                              * 07F8 A3 C8 15       #H.
           blt    L0808                                                 * 07FB 2D 0B          -.
           tfr    D,Y                                                   * 07FD 1F 02          ..
           leax   L012F,PC                                              * 07FF 30 8D F9 2C    0.y,
           lda    U0006,U                                               * 0803 A6 46          &F
           os9    I$Write                                               * 0805 10 3F 8A       .?.
L0808      leax   <U0043,U                                              * 0808 30 C8 43       0HC
           os9    F$Time                                                * 080B 10 3F 15       .?.
           bsr    L0814                                                 * 080E 8D 04          ..
           os9    I$Close                                               * 0810 10 3F 8F       .?.
           rts                                                          * 0813 39             9
L0814      lda    <U0046,U                                              * 0814 A6 C8 46       &HF
           bsr    L084B                                                 * 0817 8D 32          .2
           leax   L0156,PC                                              * 0819 30 8D F9 39    0.y9
           ldy    #1                                                    * 081D 10 8E 00 01    ....
           lda    U0006,U                                               * 0821 A6 46          &F
           os9    I$Write                                               * 0823 10 3F 8A       .?.
           lda    <U0047,U                                              * 0826 A6 C8 47       &HG
           bsr    L084B                                                 * 0829 8D 20          .
           leax   L0156,PC                                              * 082B 30 8D F9 27    0.y'
           ldy    #1                                                    * 082F 10 8E 00 01    ....
           lda    U0006,U                                               * 0833 A6 46          &F
           os9    I$Write                                               * 0835 10 3F 8A       .?.
           lda    <U0048,U                                              * 0838 A6 C8 48       &HH
           bsr    L084B                                                 * 083B 8D 0E          ..
           leax   L0126,PC                                              * 083D 30 8D F8 E5    0.xe
           ldy    #1                                                    * 0841 10 8E 00 01    ....
           lda    U0006,U                                               * 0845 A6 46          &F
           os9    I$WritLn                                              * 0847 10 3F 8C       .?.
           rts                                                          * 084A 39             9
L084B      clrb                                                         * 084B 5F             _
L084C      cmpa   #10                                                   * 084C 81 0A          ..
           blt    L0855                                                 * 084E 2D 05          -.
           incb                                                         * 0850 5C             \
           suba   #10                                                   * 0851 80 0A          ..
           bra    L084C                                                 * 0853 20 F7           w
L0855      addb   #48                                                   * 0855 CB 30          K0
           stb    U000E,U                                               * 0857 E7 4E          gN
           adda   #48                                                   * 0859 8B 30          .0
           sta    U000F,U                                               * 085B A7 4F          'O
           leax   U000E,U                                               * 085D 30 4E          0N
           ldy    #2                                                    * 085F 10 8E 00 02    ....
           lda    U0006,U                                               * 0863 A6 46          &F
           os9    I$Write                                               * 0865 10 3F 8A       .?.
           rts                                                          * 0868 39             9
L0869      pshs   X                                                     * 0869 34 10          4.
L086B      lda    ,X+                                                   * 086B A6 80          &.
           cmpa   #13                                                   * 086D 81 0D          ..
           beq    L087B                                                 * 086F 27 0A          '.
           cmpa   #90                                                   * 0871 81 5A          .Z
           bls    L086B                                                 * 0873 23 F6          #v
           anda   #223                                                  * 0875 84 DF          ._
           sta    -$01,X                                                * 0877 A7 1F          '.
           bra    L086B                                                 * 0879 20 F0           p
L087B      puls   PC,X                                                  * 087B 35 90          5.

           emod
eom        equ    *
           end
