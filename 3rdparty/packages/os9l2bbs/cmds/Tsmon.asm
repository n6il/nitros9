           nam    Tsmon
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
U0006      rmb    2
U0008      rmb    32
U0028      rmb    1
U0029      rmb    599
size       equ    .

name       fcs    /Tsmon/                                               * 000D 54 73 6D 6F EE Tsmon
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
L0083      fcb    $4D                                                   * 0083 4D             M
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
L0160      fcb    $2F                                                   * 0160 2F             /
           fcb    $57                                                   * 0161 57             W
           fcb    $62                                                   * 0162 62             b
           fcb    $0D                                                   * 0163 0D             .
start      clr    U0003,U                                               * 0164 6F 43          oC
           stx    U0006,U                                               * 0166 AF 46          /F
L0168      lda    ,X+                                                   * 0168 A6 80          &.
           cmpa   #45                                                   * 016A 81 2D          .-
           beq    L0174                                                 * 016C 27 06          '.
           cmpa   #13                                                   * 016E 81 0D          ..
           bne    L0168                                                 * 0170 26 F6          &v
           bra    L0182                                                 * 0172 20 0E           .
L0174      lda    ,X+                                                   * 0174 A6 80          &.
           anda   #223                                                  * 0176 84 DF          ._
           cmpa   #77                                                   * 0178 81 4D          .M
           bne    L0182                                                 * 017A 26 06          &.
           lda    #255                                                  * 017C 86 FF          ..
           sta    U0003,U                                               * 017E A7 43          'C
           stx    U0006,U                                               * 0180 AF 46          /F
L0182      leax   L0160,PC                                              * 0182 30 8D FF DA    0..Z
           lda    #3                                                    * 0186 86 03          ..
           os9    I$Open                                                * 0188 10 3F 84       .?.
           leax   L0320,PC                                              * 018B 30 8D 01 91    0...
           os9    F$Icpt                                                * 018F 10 3F 09       .?.
           clra                                                         * 0192 4F             O
           os9    I$Close                                               * 0193 10 3F 8F       .?.
           inca                                                         * 0196 4C             L
           os9    I$Close                                               * 0197 10 3F 8F       .?.
           inca                                                         * 019A 4C             L
           os9    I$Close                                               * 019B 10 3F 8F       .?.
           leax   L0153,PC                                              * 019E 30 8D FF B1    0..1
           lda    #2                                                    * 01A2 86 02          ..
           os9    I$Open                                                * 01A4 10 3F 84       .?.
           leax   L00DC,PC                                              * 01A7 30 8D FF 31    0..1
           ldy    #200                                                  * 01AB 10 8E 00 C8    ...H
           os9    I$WritLn                                              * 01AF 10 3F 8C       .?.
           leax   L010A,PC                                              * 01B2 30 8D FF 54    0..T
           ldy    #80                                                   * 01B6 10 8E 00 50    ...P
           os9    I$WritLn                                              * 01BA 10 3F 8C       .?.
           os9    I$Close                                               * 01BD 10 3F 8F       .?.
L01C0      ldx    U0006,U                                               * 01C0 AE 46          .F
           lda    #3                                                    * 01C2 86 03          ..
           os9    I$Open                                                * 01C4 10 3F 84       .?.
           os9    I$Dup                                                 * 01C7 10 3F 82       .?.
           os9    I$Dup                                                 * 01CA 10 3F 82       .?.
           leax   L0156,PC                                              * 01CD 30 8D FF 85    0...
           lda    #1                                                    * 01D1 86 01          ..
           os9    I$Open                                                * 01D3 10 3F 84       .?.
           bcs    L020A                                                 * 01D6 25 32          %2
L01D8      leax   <U0028,U                                              * 01D8 30 C8 28       0H(
           ldy    #200                                                  * 01DB 10 8E 00 C8    ...H
           os9    I$ReadLn                                              * 01DF 10 3F 8B       .?.
           bcs    L0207                                                 * 01E2 25 23          %#
           pshs   A                                                     * 01E4 34 02          4.
L01E6      lda    #1                                                    * 01E6 86 01          ..
           ldy    #1                                                    * 01E8 10 8E 00 01    ....
           os9    I$Write                                               * 01EC 10 3F 8A       .?.
           lda    0,X                                                   * 01EF A6 84          &.
           cmpa   #13                                                   * 01F1 81 0D          ..
           beq    L0203                                                 * 01F3 27 0E          '.
           leax   $01,X                                                 * 01F5 30 01          0.
           pshs   X                                                     * 01F7 34 10          4.
           ldx    #5                                                    * 01F9 8E 00 05       ...
           os9    F$Sleep                                               * 01FC 10 3F 0A       .?.
           puls   X                                                     * 01FF 35 10          5.
           bra    L01E6                                                 * 0201 20 E3           c
L0203      puls   A                                                     * 0203 35 02          5.
           bra    L01D8                                                 * 0205 20 D1           Q
L0207      os9    I$Close                                               * 0207 10 3F 8F       .?.
L020A      leax   U0008,U                                               * 020A 30 48          0H
           clra                                                         * 020C 4F             O
           clrb                                                         * 020D 5F             _
           os9    I$GetStt                                              * 020E 10 3F 8D       .?.
           leax   <$FFE0,X                                              * 0211 30 88 E0       0.`
           lda    #3                                                    * 0214 86 03          ..
           sta    U0005,U                                               * 0216 A7 45          'E
           sta    <$0035,X                                              * 0218 A7 88 35       '.5
           clr    <$0024,X                                              * 021B 6F 88 24       o.$
           leax   U0008,U                                               * 021E 30 48          0H
           clra                                                         * 0220 4F             O
           clrb                                                         * 0221 5F             _
           os9    I$SetStt                                              * 0222 10 3F 8E       .?.
           clr    U0004,U                                               * 0225 6F 44          oD
L0227      dec    U0004,U                                               * 0227 6A 44          jD
           beq    L020A                                                 * 0229 27 DF          '_
           ldx    #2                                                    * 022B 8E 00 02       ...
           os9    F$Sleep                                               * 022E 10 3F 0A       .?.
           clra                                                         * 0231 4F             O
           ldb    #1                                                    * 0232 C6 01          F.
           os9    I$GetStt                                              * 0234 10 3F 8D       .?.
           bcs    L0227                                                 * 0237 25 EE          %n
           leax   U0000,U                                               * 0239 30 C4          0D
           clr    0,X                                                   * 023B 6F 84          o.
           ldy    #1                                                    * 023D 10 8E 00 01    ....
           clra                                                         * 0241 4F             O
           os9    I$Read                                                * 0242 10 3F 89       .?.
           bcc    L0255                                                 * 0245 24 0E          $.
           ldx    #10                                                   * 0247 8E 00 0A       ...
           os9    F$Sleep                                               * 024A 10 3F 0A       .?.
           lda    #1                                                    * 024D 86 01          ..
           bsr    L0273                                                 * 024F 8D 22          ."
           clr    U0004,U                                               * 0251 6F 44          oD
           bra    L0227                                                 * 0253 20 D2           R
L0255      lda    U0000,U                                               * 0255 A6 C4          &D
           cmpa   #13                                                   * 0257 81 0D          ..
           beq    L0283                                                 * 0259 27 28          '(
           clr    U0004,U                                               * 025B 6F 44          oD
           lda    U0005,U                                               * 025D A6 45          &E
           cmpa   #4                                                    * 025F 81 04          ..
           beq    L026B                                                 * 0261 27 08          '.
           lda    #4                                                    * 0263 86 04          ..
           sta    U0005,U                                               * 0265 A7 45          'E
           bsr    L0273                                                 * 0267 8D 0A          ..
           bra    L0227                                                 * 0269 20 BC           <
L026B      lda    #1                                                    * 026B 86 01          ..
           sta    U0005,U                                               * 026D A7 45          'E
           bsr    L0273                                                 * 026F 8D 02          ..
           bra    L0227                                                 * 0271 20 B4           4
L0273      leax   U0008,U                                               * 0273 30 48          0H
           leax   <$FFE0,X                                              * 0275 30 88 E0       0.`
           sta    <$0035,X                                              * 0278 A7 88 35       '.5
           leax   U0008,U                                               * 027B 30 48          0H
           clra                                                         * 027D 4F             O
           clrb                                                         * 027E 5F             _
           os9    I$SetStt                                              * 027F 10 3F 8E       .?.
           rts                                                          * 0282 39             9
L0283      leax   U0008,U                                               * 0283 30 48          0H
           leax   <$FFE0,X                                              * 0285 30 88 E0       0.`
           lda    #1                                                    * 0288 86 01          ..
           sta    <$0024,X                                              * 028A A7 88 24       '.$
           leax   U0008,U                                               * 028D 30 48          0H
           clra                                                         * 028F 4F             O
           clrb                                                         * 0290 5F             _
           os9    I$SetStt                                              * 0291 10 3F 8E       .?.
           leax   <$FFE0,X                                              * 0294 30 88 E0       0.`
           ldb    <$0035,X                                              * 0297 E6 88 35       f.5
           lda    #10                                                   * 029A 86 0A          ..
           mul                                                          * 029C 3D             =
           leax   L0098,PC                                              * 029D 30 8D FD F7    0.}w
           leax   D,X                                                   * 02A1 30 8B          0.
           ldy    #10                                                   * 02A3 10 8E 00 0A    ....
           lda    #1                                                    * 02A7 86 01          ..
           os9    I$Write                                               * 02A9 10 3F 8A       .?.
           leax   L00CA,PC                                              * 02AC 30 8D FE 1A    0.~.
           ldy    #200                                                  * 02B0 10 8E 00 C8    ...H
           os9    I$WritLn                                              * 02B4 10 3F 8C       .?.
           leax   L007D,PC                                              * 02B7 30 8D FD C2    0.}B
           ldy    #1                                                    * 02BB 10 8E 00 01    ....
           pshs   U                                                     * 02BF 34 40          4@
           leau   L008B,PC                                              * 02C1 33 8D FD C6    3.}F
           lda    #17                                                   * 02C5 86 11          ..
           ldb    #3                                                    * 02C7 C6 03          F.
           os9    F$Fork                                                * 02C9 10 3F 03       .?.
           lbcs   L031A                                                 * 02CC 10 25 00 4A    .%.J
           ldu    0,S                                                   * 02D0 EE E4          nd
           sta    U0001,U                                               * 02D2 A7 41          'A
           lda    U0003,U                                               * 02D4 A6 43          &C
           bne    L02E9                                                 * 02D6 26 11          &.
           leau   L008B,PC                                              * 02D8 33 8D FD AF    3.}/
           leax   L0083,PC                                              * 02DC 30 8D FD A3    0.}#
           lda    #17                                                   * 02E0 86 11          ..
           os9    F$Fork                                                * 02E2 10 3F 03       .?.
           lbcs   L031A                                                 * 02E5 10 25 00 31    .%.1
L02E9      puls   U                                                     * 02E9 35 40          5@
           lbcs   L031A                                                 * 02EB 10 25 00 2B    .%.+
           sta    U0002,U                                               * 02EF A7 42          'B
           os9    F$Wait                                                * 02F1 10 3F 04       .?.
           pshs   A                                                     * 02F4 34 02          4.
           clra                                                         * 02F6 4F             O
           os9    I$Close                                               * 02F7 10 3F 8F       .?.
           inca                                                         * 02FA 4C             L
           os9    I$Close                                               * 02FB 10 3F 8F       .?.
           inca                                                         * 02FE 4C             L
           os9    I$Close                                               * 02FF 10 3F 8F       .?.
           puls   A                                                     * 0302 35 02          5.
           cmpa   U0001,U                                               * 0304 A1 41          !A
           bne    L0314                                                 * 0306 26 0C          &.
           ldx    #60                                                   * 0308 8E 00 3C       ..<
           os9    F$Sleep                                               * 030B 10 3F 0A       .?.
           lda    U0002,U                                               * 030E A6 42          &B
           clrb                                                         * 0310 5F             _
           os9    F$Send                                                * 0311 10 3F 08       .?.
L0314      os9    F$Wait                                                * 0314 10 3F 04       .?.
           lbra   L01C0                                                 * 0317 16 FE A6       .~&
L031A      os9    F$PErr                                                * 031A 10 3F 0F       .?.
           lbra   L01C0                                                 * 031D 16 FE A0       .~
L0320      fcb    $3B                                                   * 0320 3B             ;

           emod
eom        equ    *
           end
