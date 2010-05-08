           nam    T1mon
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
U0003      rmb    1
U0004      rmb    1
U0005      rmb    1
U0006      rmb    2
U0008      rmb    32
U0028      rmb    1
U0029      rmb    599
size       equ    .

name       fcs    /T1mon/                                               * 000D 54 31 6D 6F EE T1mon
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
L007D      fcb    $4C                                                   * 007D 4C             L
           fcb    $6F                                                   * 007E 6F             o
           fcb    $67                                                   * 007F 67             g
           fcb    $69                                                   * 0080 69             i
           fcb    $6E                                                   * 0081 6E             n
           fcb    $0D                                                   * 0082 0D             .
           fcb    $4D                                                   * 0083 4D             M
           fcb    $6F                                                   * 0084 6F             o
           fcb    $6E                                                   * 0085 6E             n
           fcb    $69                                                   * 0086 69             i
           fcb    $74                                                   * 0087 74             t
           fcb    $6F                                                   * 0088 6F             o
           fcb    $72                                                   * 0089 72             r
           fcb    $0D                                                   * 008A 0D             .
L008B      fcb    $0D                                                   * 008B 0D             .
           fcb    $0A                                                   * 008C 0A             .
           fcb    $4D                                                   * 008D 4D             M
           fcb    $6F                                                   * 008E 6F             o
           fcb    $6E                                                   * 008F 6E             n
           fcb    $69                                                   * 0090 69             i
           fcb    $74                                                   * 0091 74             t
           fcb    $6F                                                   * 0092 6F             o
           fcb    $72                                                   * 0093 72             r
           fcb    $69                                                   * 0094 69             i
           fcb    $6E                                                   * 0095 6E             n
           fcb    $67                                                   * 0096 67             g
           fcb    $20                                                   * 0097 20
L0098      fcb    $31                                                   * 0098 31             1
           fcb    $31                                                   * 0099 31             1
           fcb    $30                                                   * 009A 30             0
           fcb    $20                                                   * 009B 20
           fcb    $20                                                   * 009C 20
           fcb    $42                                                   * 009D 42             B
           fcb    $61                                                   * 009E 61             a
           fcb    $75                                                   * 009F 75             u
           fcb    $64                                                   * 00A0 64             d
           fcb    $20                                                   * 00A1 20
           fcb    $33                                                   * 00A2 33             3
           fcb    $30                                                   * 00A3 30             0
           fcb    $30                                                   * 00A4 30             0
           fcb    $20                                                   * 00A5 20
           fcb    $20                                                   * 00A6 20
           fcb    $42                                                   * 00A7 42             B
           fcb    $61                                                   * 00A8 61             a
           fcb    $75                                                   * 00A9 75             u
           fcb    $64                                                   * 00AA 64             d
           fcb    $20                                                   * 00AB 20
           fcb    $36                                                   * 00AC 36             6
           fcb    $30                                                   * 00AD 30             0
           fcb    $30                                                   * 00AE 30             0
           fcb    $20                                                   * 00AF 20
           fcb    $20                                                   * 00B0 20
           fcb    $42                                                   * 00B1 42             B
           fcb    $61                                                   * 00B2 61             a
           fcb    $75                                                   * 00B3 75             u
           fcb    $64                                                   * 00B4 64             d
           fcb    $20                                                   * 00B5 20
           fcb    $31                                                   * 00B6 31             1
           fcb    $32                                                   * 00B7 32             2
           fcb    $30                                                   * 00B8 30             0
           fcb    $30                                                   * 00B9 30             0
           fcb    $20                                                   * 00BA 20
           fcb    $42                                                   * 00BB 42             B
           fcb    $61                                                   * 00BC 61             a
           fcb    $75                                                   * 00BD 75             u
           fcb    $64                                                   * 00BE 64             d
           fcb    $20                                                   * 00BF 20
           fcb    $32                                                   * 00C0 32             2
           fcb    $34                                                   * 00C1 34             4
           fcb    $30                                                   * 00C2 30             0
           fcb    $30                                                   * 00C3 30             0
           fcb    $20                                                   * 00C4 20
           fcb    $42                                                   * 00C5 42             B
           fcb    $61                                                   * 00C6 61             a
           fcb    $75                                                   * 00C7 75             u
           fcb    $64                                                   * 00C8 64             d
           fcb    $20                                                   * 00C9 20
L00CA      fcb    $38                                                   * 00CA 38             8
           fcb    $20                                                   * 00CB 20
           fcb    $62                                                   * 00CC 62             b
           fcb    $69                                                   * 00CD 69             i
           fcb    $74                                                   * 00CE 74             t
           fcb    $73                                                   * 00CF 73             s
           fcb    $2C                                                   * 00D0 2C             ,
           fcb    $20                                                   * 00D1 20
           fcb    $6E                                                   * 00D2 6E             n
           fcb    $6F                                                   * 00D3 6F             o
           fcb    $20                                                   * 00D4 20
           fcb    $70                                                   * 00D5 70             p
           fcb    $61                                                   * 00D6 61             a
           fcb    $72                                                   * 00D7 72             r
           fcb    $69                                                   * 00D8 69             i
           fcb    $74                                                   * 00D9 74             t
           fcb    $79                                                   * 00DA 79             y
           fcb    $0D                                                   * 00DB 0D             .
L00DC      fcb    $55                                                   * 00DC 55             U
           fcb    $73                                                   * 00DD 73             s
           fcb    $65                                                   * 00DE 65             e
           fcb    $72                                                   * 00DF 72             r
           fcb    $20                                                   * 00E0 20
           fcb    $6E                                                   * 00E1 6E             n
           fcb    $61                                                   * 00E2 61             a
           fcb    $6D                                                   * 00E3 6D             m
           fcb    $65                                                   * 00E4 65             e
           fcb    $20                                                   * 00E5 20
           fcb    $20                                                   * 00E6 20
           fcb    $20                                                   * 00E7 20
           fcb    $20                                                   * 00E8 20
           fcb    $20                                                   * 00E9 20
           fcb    $20                                                   * 00EA 20
           fcb    $20                                                   * 00EB 20
           fcb    $20                                                   * 00EC 20
           fcb    $20                                                   * 00ED 20
           fcb    $20                                                   * 00EE 20
           fcb    $20                                                   * 00EF 20
           fcb    $20                                                   * 00F0 20
           fcb    $44                                                   * 00F1 44             D
           fcb    $61                                                   * 00F2 61             a
           fcb    $74                                                   * 00F3 74             t
           fcb    $65                                                   * 00F4 65             e
           fcb    $20                                                   * 00F5 20
           fcb    $20                                                   * 00F6 20
           fcb    $20                                                   * 00F7 20
           fcb    $20                                                   * 00F8 20
           fcb    $20                                                   * 00F9 20
           fcb    $20                                                   * 00FA 20
           fcb    $20                                                   * 00FB 20
           fcb    $20                                                   * 00FC 20
           fcb    $20                                                   * 00FD 20
           fcb    $20                                                   * 00FE 20
           fcb    $20                                                   * 00FF 20
           fcb    $20                                                   * 0100 20
           fcb    $20                                                   * 0101 20
           fcb    $20                                                   * 0102 20
           fcb    $20                                                   * 0103 20
           fcb    $20                                                   * 0104 20
           fcb    $74                                                   * 0105 74             t
           fcb    $69                                                   * 0106 69             i
           fcb    $6D                                                   * 0107 6D             m
           fcb    $65                                                   * 0108 65             e
           fcb    $0D                                                   * 0109 0D             .
L010A      fcb    $2D                                                   * 010A 2D             -
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
           fcb    $2D                                                   * 012F 2D             -
           fcb    $2D                                                   * 0130 2D             -
           fcb    $2D                                                   * 0131 2D             -
           fcb    $2D                                                   * 0132 2D             -
           fcb    $2D                                                   * 0133 2D             -
           fcb    $2D                                                   * 0134 2D             -
           fcb    $2D                                                   * 0135 2D             -
           fcb    $2D                                                   * 0136 2D             -
           fcb    $2D                                                   * 0137 2D             -
           fcb    $2D                                                   * 0138 2D             -
           fcb    $2D                                                   * 0139 2D             -
           fcb    $2D                                                   * 013A 2D             -
           fcb    $2D                                                   * 013B 2D             -
           fcb    $2D                                                   * 013C 2D             -
           fcb    $2D                                                   * 013D 2D             -
           fcb    $2D                                                   * 013E 2D             -
           fcb    $2D                                                   * 013F 2D             -
           fcb    $2D                                                   * 0140 2D             -
           fcb    $2D                                                   * 0141 2D             -
           fcb    $2D                                                   * 0142 2D             -
           fcb    $2D                                                   * 0143 2D             -
           fcb    $2D                                                   * 0144 2D             -
           fcb    $2D                                                   * 0145 2D             -
           fcb    $2D                                                   * 0146 2D             -
           fcb    $2D                                                   * 0147 2D             -
           fcb    $2D                                                   * 0148 2D             -
           fcb    $2D                                                   * 0149 2D             -
           fcb    $2D                                                   * 014A 2D             -
           fcb    $2D                                                   * 014B 2D             -
           fcb    $2D                                                   * 014C 2D             -
           fcb    $2D                                                   * 014D 2D             -
           fcb    $2D                                                   * 014E 2D             -
           fcb    $2D                                                   * 014F 2D             -
           fcb    $2D                                                   * 0150 2D             -
           fcb    $2D                                                   * 0151 2D             -
           fcb    $0D                                                   * 0152 0D             .
L0153      fcb    $2F                                                   * 0153 2F             /
           fcb    $70                                                   * 0154 70             p
           fcb    $0D                                                   * 0155 0D             .
L0156      fcb    $4D                                                   * 0156 4D             M
           fcb    $6F                                                   * 0157 6F             o
           fcb    $64                                                   * 0158 64             d
           fcb    $65                                                   * 0159 65             e
           fcb    $6D                                                   * 015A 6D             m
           fcb    $2E                                                   * 015B 2E             .
           fcb    $73                                                   * 015C 73             s
           fcb    $65                                                   * 015D 65             e
           fcb    $74                                                   * 015E 74             t
           fcb    $0D                                                   * 015F 0D             .
start      clr    U0003,U                                               * 0160 6F 43          oC
           stx    U0006,U                                               * 0162 AF 46          /F
           lda    #255                                                  * 0164 86 FF          ..
           sta    U0003,U                                               * 0166 A7 43          'C
           leax   L0284,PC                                              * 0168 30 8D 01 18    0...
           os9    F$Icpt                                                * 016C 10 3F 09       .?.
           clra                                                         * 016F 4F             O
           os9    I$Close                                               * 0170 10 3F 8F       .?.
           inca                                                         * 0173 4C             L
           os9    I$Close                                               * 0174 10 3F 8F       .?.
           inca                                                         * 0177 4C             L
           os9    I$Close                                               * 0178 10 3F 8F       .?.
           leax   L0153,PC                                              * 017B 30 8D FF D4    0..T
           lda    #2                                                    * 017F 86 02          ..
           os9    I$Open                                                * 0181 10 3F 84       .?.
           leax   L00DC,PC                                              * 0184 30 8D FF 54    0..T
           ldy    #200                                                  * 0188 10 8E 00 C8    ...H
           os9    I$WritLn                                              * 018C 10 3F 8C       .?.
           leax   L010A,PC                                              * 018F 30 8D FF 77    0..w
           ldy    #80                                                   * 0193 10 8E 00 50    ...P
           os9    I$WritLn                                              * 0197 10 3F 8C       .?.
           os9    I$Close                                               * 019A 10 3F 8F       .?.
L019D      ldx    U0006,U                                               * 019D AE 46          .F
           lda    #3                                                    * 019F 86 03          ..
           os9    I$Open                                                * 01A1 10 3F 84       .?.
           lbcs   L027E                                                 * 01A4 10 25 00 D6    .%.V
           os9    I$Dup                                                 * 01A8 10 3F 82       .?.
           os9    I$Dup                                                 * 01AB 10 3F 82       .?.
           leax   L0156,PC                                              * 01AE 30 8D FF A4    0..$
           lda    #1                                                    * 01B2 86 01          ..
           os9    I$Open                                                * 01B4 10 3F 84       .?.
           bcs    L01D7                                                 * 01B7 25 1E          %.
L01B9      leax   <U0028,U                                              * 01B9 30 C8 28       0H(
           ldy    #200                                                  * 01BC 10 8E 00 C8    ...H
           os9    I$ReadLn                                              * 01C0 10 3F 8B       .?.
           bcs    L01D4                                                 * 01C3 25 0F          %.
           pshs   A                                                     * 01C5 34 02          4.
           lda    #1                                                    * 01C7 86 01          ..
           ldy    #200                                                  * 01C9 10 8E 00 C8    ...H
           os9    I$WritLn                                              * 01CD 10 3F 8C       .?.
           puls   A                                                     * 01D0 35 02          5.
           bra    L01B9                                                 * 01D2 20 E5           e
L01D4      os9    I$Close                                               * 01D4 10 3F 8F       .?.
L01D7      leax   U0008,U                                               * 01D7 30 48          0H
           clra                                                         * 01D9 4F             O
           clrb                                                         * 01DA 5F             _
           os9    I$GetStt                                              * 01DB 10 3F 8D       .?.
           leax   <$FFE0,X                                              * 01DE 30 88 E0       0.`
           lda    #1                                                    * 01E1 86 01          ..
           sta    U0005,U                                               * 01E3 A7 45          'E
           sta    <$0035,X                                              * 01E5 A7 88 35       '.5
           clr    <$0024,X                                              * 01E8 6F 88 24       o.$
           leax   U0008,U                                               * 01EB 30 48          0H
           clra                                                         * 01ED 4F             O
           clrb                                                         * 01EE 5F             _
           os9    I$SetStt                                              * 01EF 10 3F 8E       .?.
           clr    U0004,U                                               * 01F2 6F 44          oD
L01F4      leax   U0000,U                                               * 01F4 30 C4          0D
           clr    0,X                                                   * 01F6 6F 84          o.
           ldy    #1                                                    * 01F8 10 8E 00 01    ....
           clra                                                         * 01FC 4F             O
           os9    I$Read                                                * 01FD 10 3F 89       .?.
           bcc    L020A                                                 * 0200 24 08          $.
           ldx    #10                                                   * 0202 8E 00 0A       ...
           os9    F$Sleep                                               * 0205 10 3F 0A       .?.
           bra    L01F4                                                 * 0208 20 EA           j
L020A      lda    U0000,U                                               * 020A A6 C4          &D
           cmpa   #13                                                   * 020C 81 0D          ..
           beq    L0212                                                 * 020E 27 02          '.
           bra    L01F4                                                 * 0210 20 E2           b
L0212      leax   U0008,U                                               * 0212 30 48          0H
           leax   <$FFE0,X                                              * 0214 30 88 E0       0.`
           lda    #1                                                    * 0217 86 01          ..
           sta    <$0024,X                                              * 0219 A7 88 24       '.$
           leax   U0008,U                                               * 021C 30 48          0H
           clra                                                         * 021E 4F             O
           clrb                                                         * 021F 5F             _
           os9    I$SetStt                                              * 0220 10 3F 8E       .?.
           leax   <$FFE0,X                                              * 0223 30 88 E0       0.`
           ldb    <$0035,X                                              * 0226 E6 88 35       f.5
           lda    #10                                                   * 0229 86 0A          ..
           mul                                                          * 022B 3D             =
           leax   L0098,PC                                              * 022C 30 8D FE 68    0.~h
           leax   D,X                                                   * 0230 30 8B          0.
           ldy    #10                                                   * 0232 10 8E 00 0A    ....
           lda    #1                                                    * 0236 86 01          ..
           os9    I$Write                                               * 0238 10 3F 8A       .?.
           leax   L00CA,PC                                              * 023B 30 8D FE 8B    0.~.
           ldy    #200                                                  * 023F 10 8E 00 C8    ...H
           os9    I$WritLn                                              * 0243 10 3F 8C       .?.
           leax   L007D,PC                                              * 0246 30 8D FE 33    0.~3
           ldy    #1                                                    * 024A 10 8E 00 01    ....
           pshs   U                                                     * 024E 34 40          4@
           leau   L008B,PC                                              * 0250 33 8D FE 37    3.~7
           lda    #17                                                   * 0254 86 11          ..
           ldb    #3                                                    * 0256 C6 03          F.
           os9    F$Fork                                                * 0258 10 3F 03       .?.
           lbcs   L027E                                                 * 025B 10 25 00 1F    .%..
           ldu    0,S                                                   * 025F EE E4          nd
           sta    U0001,U                                               * 0261 A7 41          'A
           puls   U                                                     * 0263 35 40          5@
           os9    F$Wait                                                * 0265 10 3F 04       .?.
           lbcs   L027E                                                 * 0268 10 25 00 12    .%..
           clra                                                         * 026C 4F             O
           os9    I$Close                                               * 026D 10 3F 8F       .?.
           inca                                                         * 0270 4C             L
           os9    I$Close                                               * 0271 10 3F 8F       .?.
           inca                                                         * 0274 4C             L
           os9    I$Close                                               * 0275 10 3F 8F       .?.
           os9    F$Wait                                                * 0278 10 3F 04       .?.
           lbra   L019D                                                 * 027B 16 FF 1F       ...
L027E      os9    F$PErr                                                * 027E 10 3F 0F       .?.
           lbra   L019D                                                 * 0281 16 FF 19       ...
L0284      fcb    $3B                                                   * 0284 3B             ;

           emod
eom        equ    *
           end
