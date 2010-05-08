           nam    Dloady
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
U0003      rmb    2
U0005      rmb    2
U0007      rmb    1
U0008      rmb    2
U000A      rmb    2
U000C      rmb    10
U0016      rmb    1
U0017      rmb    1
U0018      rmb    1
U0019      rmb    1024
U0419      rmb    1
U041A      rmb    1
U041B      rmb    32
U043B      rmb    2
U043D      rmb    1
U043E      rmb    231
size       equ    .

name       fcs    /Dloady/                                              * 000D 44 6C 6F 61 64 F9 Dloady
           fcb    $43                                                   * 0013 43             C
           fcb    $6F                                                   * 0014 6F             o
           fcb    $70                                                   * 0015 70             p
           fcb    $79                                                   * 0016 79             y
           fcb    $72                                                   * 0017 72             r
           fcb    $69                                                   * 0018 69             i
           fcb    $67                                                   * 0019 67             g
           fcb    $68                                                   * 001A 68             h
           fcb    $74                                                   * 001B 74             t
           fcb    $20                                                   * 001C 20
           fcb    $28                                                   * 001D 28             (
           fcb    $43                                                   * 001E 43             C
           fcb    $29                                                   * 001F 29             )
           fcb    $20                                                   * 0020 20
           fcb    $31                                                   * 0021 31             1
           fcb    $39                                                   * 0022 39             9
           fcb    $38                                                   * 0023 38             8
           fcb    $38                                                   * 0024 38             8
           fcb    $42                                                   * 0025 42             B
           fcb    $79                                                   * 0026 79             y
           fcb    $20                                                   * 0027 20
           fcb    $4B                                                   * 0028 4B             K
           fcb    $65                                                   * 0029 65             e
           fcb    $69                                                   * 002A 69             i
           fcb    $74                                                   * 002B 74             t
           fcb    $68                                                   * 002C 68             h
           fcb    $20                                                   * 002D 20
           fcb    $41                                                   * 002E 41             A
           fcb    $6C                                                   * 002F 6C             l
           fcb    $70                                                   * 0030 70             p
           fcb    $68                                                   * 0031 68             h
           fcb    $6F                                                   * 0032 6F             o
           fcb    $6E                                                   * 0033 6E             n
           fcb    $73                                                   * 0034 73             s
           fcb    $6F                                                   * 0035 6F             o
           fcb    $4C                                                   * 0036 4C             L
           fcb    $69                                                   * 0037 69             i
           fcb    $63                                                   * 0038 63             c
           fcb    $65                                                   * 0039 65             e
           fcb    $6E                                                   * 003A 6E             n
           fcb    $63                                                   * 003B 63             c
           fcb    $65                                                   * 003C 65             e
           fcb    $64                                                   * 003D 64             d
           fcb    $20                                                   * 003E 20
           fcb    $74                                                   * 003F 74             t
           fcb    $6F                                                   * 0040 6F             o
           fcb    $20                                                   * 0041 20
           fcb    $41                                                   * 0042 41             A
           fcb    $6C                                                   * 0043 6C             l
           fcb    $70                                                   * 0044 70             p
           fcb    $68                                                   * 0045 68             h
           fcb    $61                                                   * 0046 61             a
           fcb    $20                                                   * 0047 20
           fcb    $53                                                   * 0048 53             S
           fcb    $6F                                                   * 0049 6F             o
           fcb    $66                                                   * 004A 66             f
           fcb    $74                                                   * 004B 74             t
           fcb    $77                                                   * 004C 77             w
           fcb    $61                                                   * 004D 61             a
           fcb    $72                                                   * 004E 72             r
           fcb    $65                                                   * 004F 65             e
           fcb    $20                                                   * 0050 20
           fcb    $54                                                   * 0051 54             T
           fcb    $65                                                   * 0052 65             e
           fcb    $63                                                   * 0053 63             c
           fcb    $68                                                   * 0054 68             h
           fcb    $6E                                                   * 0055 6E             n
           fcb    $6F                                                   * 0056 6F             o
           fcb    $6C                                                   * 0057 6C             l
           fcb    $6F                                                   * 0058 6F             o
           fcb    $67                                                   * 0059 67             g
           fcb    $69                                                   * 005A 69             i
           fcb    $65                                                   * 005B 65             e
           fcb    $73                                                   * 005C 73             s
           fcb    $41                                                   * 005D 41             A
           fcb    $6C                                                   * 005E 6C             l
           fcb    $6C                                                   * 005F 6C             l
           fcb    $20                                                   * 0060 20
           fcb    $72                                                   * 0061 72             r
           fcb    $69                                                   * 0062 69             i
           fcb    $67                                                   * 0063 67             g
           fcb    $68                                                   * 0064 68             h
           fcb    $74                                                   * 0065 74             t
           fcb    $73                                                   * 0066 73             s
           fcb    $20                                                   * 0067 20
           fcb    $72                                                   * 0068 72             r
           fcb    $65                                                   * 0069 65             e
           fcb    $73                                                   * 006A 73             s
           fcb    $65                                                   * 006B 65             e
           fcb    $72                                                   * 006C 72             r
           fcb    $76                                                   * 006D 76             v
           fcb    $65                                                   * 006E 65             e
           fcb    $64                                                   * 006F 64             d
           fcb    $EC                                                   * 0070 EC             l
           fcb    $E6                                                   * 0071 E6             f
           fcb    $EA                                                   * 0072 EA             j
           fcb    $F5                                                   * 0073 F5             u
           fcb    $E9                                                   * 0074 E9             i
           fcb    $A0                                                   * 0075 A0
           fcb    $E2                                                   * 0076 E2             b
           fcb    $ED                                                   * 0077 ED             m
           fcb    $F1                                                   * 0078 F1             q
           fcb    $E9                                                   * 0079 E9             i
           fcb    $F0                                                   * 007A F0             p
           fcb    $EF                                                   * 007B EF             o
           fcb    $F4                                                   * 007C F4             t
           fcb    $F0                                                   * 007D F0             p
L007E      fcb    $45                                                   * 007E 45             E
           fcb    $6E                                                   * 007F 6E             n
           fcb    $74                                                   * 0080 74             t
           fcb    $65                                                   * 0081 65             e
           fcb    $72                                                   * 0082 72             r
           fcb    $20                                                   * 0083 20
           fcb    $66                                                   * 0084 66             f
           fcb    $69                                                   * 0085 69             i
           fcb    $6C                                                   * 0086 6C             l
           fcb    $65                                                   * 0087 65             e
           fcb    $6E                                                   * 0088 6E             n
           fcb    $61                                                   * 0089 61             a
           fcb    $6D                                                   * 008A 6D             m
           fcb    $65                                                   * 008B 65             e
           fcb    $20                                                   * 008C 20
           fcb    $74                                                   * 008D 74             t
           fcb    $6F                                                   * 008E 6F             o
           fcb    $20                                                   * 008F 20
           fcb    $64                                                   * 0090 64             d
           fcb    $6F                                                   * 0091 6F             o
           fcb    $77                                                   * 0092 77             w
           fcb    $6E                                                   * 0093 6E             n
           fcb    $6C                                                   * 0094 6C             l
           fcb    $6F                                                   * 0095 6F             o
           fcb    $61                                                   * 0096 61             a
           fcb    $64                                                   * 0097 64             d
           fcb    $2D                                                   * 0098 2D             -
           fcb    $2D                                                   * 0099 2D             -
           fcb    $3E                                                   * 009A 3E             >
L009B      fcb    $00                                                   * 009B 00             .
           fcb    $1D                                                   * 009C 1D             .
L009D      fcb    $46                                                   * 009D 46             F
           fcb    $69                                                   * 009E 69             i
           fcb    $6C                                                   * 009F 6C             l
           fcb    $65                                                   * 00A0 65             e
           fcb    $20                                                   * 00A1 20
           fcb    $6F                                                   * 00A2 6F             o
           fcb    $70                                                   * 00A3 70             p
           fcb    $65                                                   * 00A4 65             e
           fcb    $6E                                                   * 00A5 6E             n
           fcb    $2C                                                   * 00A6 2C             ,
           fcb    $20                                                   * 00A7 20
           fcb    $72                                                   * 00A8 72             r
           fcb    $65                                                   * 00A9 65             e
           fcb    $61                                                   * 00AA 61             a
           fcb    $64                                                   * 00AB 64             d
           fcb    $79                                                   * 00AC 79             y
           fcb    $20                                                   * 00AD 20
           fcb    $74                                                   * 00AE 74             t
           fcb    $6F                                                   * 00AF 6F             o
           fcb    $20                                                   * 00B0 20
           fcb    $73                                                   * 00B1 73             s
           fcb    $65                                                   * 00B2 65             e
           fcb    $6E                                                   * 00B3 6E             n
           fcb    $64                                                   * 00B4 64             d
           fcb    $2E                                                   * 00B5 2E             .
           fcb    $2E                                                   * 00B6 2E             .
           fcb    $2E                                                   * 00B7 2E             .
           fcb    $0D                                                   * 00B8 0D             .
L00B9      fcb    $46                                                   * 00B9 46             F
           fcb    $69                                                   * 00BA 69             i
           fcb    $6C                                                   * 00BB 6C             l
           fcb    $65                                                   * 00BC 65             e
           fcb    $20                                                   * 00BD 20
           fcb    $74                                                   * 00BE 74             t
           fcb    $72                                                   * 00BF 72             r
           fcb    $61                                                   * 00C0 61             a
           fcb    $6E                                                   * 00C1 6E             n
           fcb    $73                                                   * 00C2 73             s
           fcb    $66                                                   * 00C3 66             f
           fcb    $65                                                   * 00C4 65             e
           fcb    $72                                                   * 00C5 72             r
           fcb    $20                                                   * 00C6 20
           fcb    $73                                                   * 00C7 73             s
           fcb    $75                                                   * 00C8 75             u
           fcb    $63                                                   * 00C9 63             c
           fcb    $63                                                   * 00CA 63             c
           fcb    $65                                                   * 00CB 65             e
           fcb    $73                                                   * 00CC 73             s
           fcb    $73                                                   * 00CD 73             s
           fcb    $66                                                   * 00CE 66             f
           fcb    $75                                                   * 00CF 75             u
           fcb    $6C                                                   * 00D0 6C             l
           fcb    $0D                                                   * 00D1 0D             .
L00D2      fcb    $46                                                   * 00D2 46             F
           fcb    $69                                                   * 00D3 69             i
           fcb    $6C                                                   * 00D4 6C             l
           fcb    $65                                                   * 00D5 65             e
           fcb    $20                                                   * 00D6 20
           fcb    $74                                                   * 00D7 74             t
           fcb    $72                                                   * 00D8 72             r
           fcb    $61                                                   * 00D9 61             a
           fcb    $6E                                                   * 00DA 6E             n
           fcb    $73                                                   * 00DB 73             s
           fcb    $66                                                   * 00DC 66             f
           fcb    $65                                                   * 00DD 65             e
           fcb    $72                                                   * 00DE 72             r
           fcb    $20                                                   * 00DF 20
           fcb    $75                                                   * 00E0 75             u
           fcb    $6E                                                   * 00E1 6E             n
           fcb    $73                                                   * 00E2 73             s
           fcb    $75                                                   * 00E3 75             u
           fcb    $63                                                   * 00E4 63             c
           fcb    $63                                                   * 00E5 63             c
           fcb    $65                                                   * 00E6 65             e
           fcb    $73                                                   * 00E7 73             s
           fcb    $73                                                   * 00E8 73             s
           fcb    $66                                                   * 00E9 66             f
           fcb    $75                                                   * 00EA 75             u
           fcb    $6C                                                   * 00EB 6C             l
           fcb    $0D                                                   * 00EC 0D             .
L00ED      fcb    $50                                                   * 00ED 50             P
           fcb    $72                                                   * 00EE 72             r
           fcb    $65                                                   * 00EF 65             e
           fcb    $73                                                   * 00F0 73             s
           fcb    $73                                                   * 00F1 73             s
           fcb    $20                                                   * 00F2 20
           fcb    $3C                                                   * 00F3 3C             <
           fcb    $43                                                   * 00F4 43             C
           fcb    $54                                                   * 00F5 54             T
           fcb    $52                                                   * 00F6 52             R
           fcb    $4C                                                   * 00F7 4C             L
           fcb    $3E                                                   * 00F8 3E             >
           fcb    $3C                                                   * 00F9 3C             <
           fcb    $58                                                   * 00FA 58             X
           fcb    $3E                                                   * 00FB 3E             >
           fcb    $20                                                   * 00FC 20
           fcb    $74                                                   * 00FD 74             t
           fcb    $6F                                                   * 00FE 6F             o
           fcb    $20                                                   * 00FF 20
           fcb    $61                                                   * 0100 61             a
           fcb    $62                                                   * 0101 62             b
           fcb    $6F                                                   * 0102 6F             o
           fcb    $72                                                   * 0103 72             r
           fcb    $74                                                   * 0104 74             t
           fcb    $0D                                                   * 0105 0D             .
L0106      fcb    $04                                                   * 0106 04             .
L0107      fcb    $0A                                                   * 0107 0A             .
           fcb    $0D                                                   * 0108 0D             .
L0109      fcb    $54                                                   * 0109 54             T
           fcb    $6F                                                   * 010A 6F             o
           fcb    $74                                                   * 010B 74             t
           fcb    $61                                                   * 010C 61             a
           fcb    $6C                                                   * 010D 6C             l
           fcb    $20                                                   * 010E 20
           fcb    $6E                                                   * 010F 6E             n
           fcb    $75                                                   * 0110 75             u
           fcb    $6D                                                   * 0111 6D             m
           fcb    $62                                                   * 0112 62             b
           fcb    $65                                                   * 0113 65             e
           fcb    $72                                                   * 0114 72             r
           fcb    $20                                                   * 0115 20
           fcb    $6F                                                   * 0116 6F             o
           fcb    $66                                                   * 0117 66             f
           fcb    $20                                                   * 0118 20
           fcb    $62                                                   * 0119 62             b
           fcb    $6C                                                   * 011A 6C             l
           fcb    $6F                                                   * 011B 6F             o
           fcb    $63                                                   * 011C 63             c
           fcb    $6B                                                   * 011D 6B             k
           fcb    $73                                                   * 011E 73             s
           fcb    $20                                                   * 011F 20
           fcb    $74                                                   * 0120 74             t
           fcb    $6F                                                   * 0121 6F             o
           fcb    $20                                                   * 0122 20
           fcb    $64                                                   * 0123 64             d
           fcb    $6F                                                   * 0124 6F             o
           fcb    $77                                                   * 0125 77             w
           fcb    $6E                                                   * 0126 6E             n
           fcb    $6C                                                   * 0127 6C             l
           fcb    $6F                                                   * 0128 6F             o
           fcb    $61                                                   * 0129 61             a
           fcb    $64                                                   * 012A 64             d
           fcb    $3A                                                   * 012B 3A             :
L012C      clr    U0002,U                                               * 012C 6F 42          oB
           leax   >U043D,U                                              * 012E 30 C9 04 3D    0I.=
           clra                                                         * 0132 4F             O
           clrb                                                         * 0133 5F             _
           os9    I$GetStt                                              * 0134 10 3F 8D       .?.
           leax   <$FFE0,X                                              * 0137 30 88 E0       0.`
           clr    <$0024,X                                              * 013A 6F 88 24       o.$
           leax   >U043D,U                                              * 013D 30 C9 04 3D    0I.=
           clra                                                         * 0141 4F             O
           clrb                                                         * 0142 5F             _
           os9    I$SetStt                                              * 0143 10 3F 8E       .?.
           rts                                                          * 0146 39             9
start      lda    0,X                                                   * 0147 A6 84          &.
           cmpa   #13                                                   * 0149 81 0D          ..
           bne    L0167                                                 * 014B 26 1A          &.
           leax   L007E,PC                                              * 014D 30 8D FF 2D    0..-
           ldy    L009B,PC                                              * 0151 10 AE 8D FF 45 ....E
           lda    #1                                                    * 0156 86 01          ..
           os9    I$Write                                               * 0158 10 3F 8A       .?.
           leax   >U041B,U                                              * 015B 30 C9 04 1B    0I..
           ldy    #32                                                   * 015F 10 8E 00 20    ...
           clra                                                         * 0163 4F             O
           os9    I$ReadLn                                              * 0164 10 3F 8B       .?.
L0167      stx    >U043B,U                                              * 0167 AF C9 04 3B    /I.;
           lbsr   L012C                                                 * 016B 17 FF BE       ..>
           lda    #1                                                    * 016E 86 01          ..
           ldx    >U043B,U                                              * 0170 AE C9 04 3B    .I.;
           os9    I$Open                                                * 0174 10 3F 84       .?.
           lbcs   L032E                                                 * 0177 10 25 01 B3    .%.3
           sta    U0000,U                                               * 017B A7 C4          'D
           leax   L0109,PC                                              * 017D 30 8D FF 88    0...
           ldy    #35                                                   * 0181 10 8E 00 23    ...#
           lda    #1                                                    * 0185 86 01          ..
           os9    I$Write                                               * 0187 10 3F 8A       .?.
           lda    U0000,U                                               * 018A A6 C4          &D
           ldb    #2                                                    * 018C C6 02          F.
           pshs   U                                                     * 018E 34 40          4@
           os9    I$GetStt                                              * 0190 10 3F 8D       .?.
           tfr    U,Y                                                   * 0193 1F 32          .2
           puls   U                                                     * 0195 35 40          5@
           lda    #10                                                   * 0197 86 0A          ..
           sta    U0007,U                                               * 0199 A7 47          'G
L019B      tfr    X,D                                                   * 019B 1F 10          ..
           lsra                                                         * 019D 44             D
           rorb                                                         * 019E 56             V
           tfr    D,X                                                   * 019F 1F 01          ..
           tfr    Y,D                                                   * 01A1 1F 20          .
           rora                                                         * 01A3 46             F
           rorb                                                         * 01A4 56             V
           tfr    D,Y                                                   * 01A5 1F 02          ..
           dec    U0007,U                                               * 01A7 6A 47          jG
           bne    L019B                                                 * 01A9 26 F0          &p
           tfr    Y,D                                                   * 01AB 1F 20          .
           leax   U000C,U                                               * 01AD 30 4C          0L
           addd   #1                                                    * 01AF C3 00 01       C..
           lbsr   L03AE                                                 * 01B2 17 01 F9       ..y
           leax   U000C,U                                               * 01B5 30 4C          0L
           ldy    #5                                                    * 01B7 10 8E 00 05    ....
           lda    #1                                                    * 01BB 86 01          ..
           os9    I$Write                                               * 01BD 10 3F 8A       .?.
           leax   L0107,PC                                              * 01C0 30 8D FF 43    0..C
           ldy    #1                                                    * 01C4 10 8E 00 01    ....
           lda    #1                                                    * 01C8 86 01          ..
           os9    I$WritLn                                              * 01CA 10 3F 8C       .?.
           leax   L00ED,PC                                              * 01CD 30 8D FF 1C    0...
           ldy    #200                                                  * 01D1 10 8E 00 C8    ...H
           lda    #1                                                    * 01D5 86 01          ..
           os9    I$WritLn                                              * 01D7 10 3F 8C       .?.
           leax   L009D,PC                                              * 01DA 30 8D FE BF    0.~?
           ldy    #200                                                  * 01DE 10 8E 00 C8    ...H
           lda    #1                                                    * 01E2 86 01          ..
           os9    I$WritLn                                              * 01E4 10 3F 8C       .?.
L01E7      leax   U0001,U                                               * 01E7 30 41          0A
           ldy    #1                                                    * 01E9 10 8E 00 01    ....
           clra                                                         * 01ED 4F             O
           os9    I$Read                                                * 01EE 10 3F 89       .?.
           lda    U0001,U                                               * 01F1 A6 41          &A
           cmpa   #67                                                   * 01F3 81 43          .C
           beq    L0203                                                 * 01F5 27 0C          '.
           cmpa   #24                                                   * 01F7 81 18          ..
           lbeq   L0320                                                 * 01F9 10 27 01 23    .'.#
           cmpa   #21                                                   * 01FD 81 15          ..
           bne    L01E7                                                 * 01FF 26 E6          &f
           bra    L0207                                                 * 0201 20 04           .
L0203      lda    #1                                                    * 0203 86 01          ..
           sta    U0002,U                                               * 0205 A7 42          'B
L0207      lda    #2                                                    * 0207 86 02          ..
           sta    <U0016,U                                              * 0209 A7 C8 16       'H.
           lda    #1                                                    * 020C 86 01          ..
           sta    <U0017,U                                              * 020E A7 C8 17       'H.
           coma                                                         * 0211 43             C
           sta    <U0018,U                                              * 0212 A7 C8 18       'H.
L0215      leax   <U0019,U                                              * 0215 30 C8 19       0H.
           ldy    #1024                                                 * 0218 10 8E 04 00    ....
           lda    U0000,U                                               * 021C A6 C4          &D
           os9    I$Read                                                * 021E 10 3F 89       .?.
           lbcs   L02EE                                                 * 0221 10 25 00 C9    .%.I
           cmpy   #1024                                                 * 0225 10 8C 04 00    ....
           beq    L023D                                                 * 0229 27 12          '.
           tfr    Y,D                                                   * 022B 1F 20          .
           leax   D,X                                                   * 022D 30 8B          0.
           clra                                                         * 022F 4F             O
L0230      sta    ,X+                                                   * 0230 A7 80          '.
           leay   $01,Y                                                 * 0232 31 21          1!
           cmpy   #1024                                                 * 0234 10 8C 04 00    ....
           bcs    L0230                                                 * 0238 25 F6          %v
           leax   <U0019,U                                              * 023A 30 C8 19       0H.
L023D      tst    U0002,U                                               * 023D 6D 42          mB
           bne    L0259                                                 * 023F 26 18          &.
           clr    >U0419,U                                              * 0241 6F C9 04 19    oI..
           ldy    #1024                                                 * 0245 10 8E 04 00    ....
L0249      lda    ,X+                                                   * 0249 A6 80          &.
           adda   >U0419,U                                              * 024B AB C9 04 19    +I..
           sta    >U0419,U                                              * 024F A7 C9 04 19    'I..
           leay   -$01,Y                                                * 0253 31 3F          1?
           bne    L0249                                                 * 0255 26 F2          &r
           bra    L02AA                                                 * 0257 20 51           Q
L0259      ldd    #0                                                    * 0259 CC 00 00       L..
           std    >U0419,U                                              * 025C ED C9 04 19    mI..
           ldy    #1024                                                 * 0260 10 8E 04 00    ....
           sty    U0003,U                                               * 0264 10 AF 43       ./C
L0267      lda    ,X+                                                   * 0267 A6 80          &.
           clrb                                                         * 0269 5F             _
           eora   >U0419,U                                              * 026A A8 C9 04 19    (I..
           eorb   >U041A,U                                              * 026E E8 C9 04 1A    hI..
           std    >U0419,U                                              * 0272 ED C9 04 19    mI..
           lda    #8                                                    * 0276 86 08          ..
           sta    U0005,U                                               * 0278 A7 45          'E
L027A      lda    >U0419,U                                              * 027A A6 C9 04 19    &I..
           bita   #128                                                  * 027E 85 80          ..
           beq    L0292                                                 * 0280 27 10          '.
           ldd    >U0419,U                                              * 0282 EC C9 04 19    lI..
           aslb                                                         * 0286 58             X
           rola                                                         * 0287 49             I
           eora   #16                                                   * 0288 88 10          ..
           eorb   #33                                                   * 028A C8 21          H!
           std    >U0419,U                                              * 028C ED C9 04 19    mI..
           bra    L0298                                                 * 0290 20 06           .
L0292      aslb                                                         * 0292 58             X
           rola                                                         * 0293 49             I
           std    >U0419,U                                              * 0294 ED C9 04 19    mI..
L0298      dec    U0005,U                                               * 0298 6A 45          jE
           bne    L027A                                                 * 029A 26 DE          &^
           ldy    U0003,U                                               * 029C 10 AE 43       ..C
           leay   -$01,Y                                                * 029F 31 3F          1?
           sty    U0003,U                                               * 02A1 10 AF 43       ./C
           bne    L0267                                                 * 02A4 26 C1          &A
           ldd    >U0419,U                                              * 02A6 EC C9 04 19    lI..
L02AA      leax   <U0016,U                                              * 02AA 30 C8 16       0H.
           tst    U0002,U                                               * 02AD 6D 42          mB
           beq    L02B7                                                 * 02AF 27 06          '.
           ldy    #1029                                                 * 02B1 10 8E 04 05    ....
           bra    L02BB                                                 * 02B5 20 04           .
L02B7      ldy    #1028                                                 * 02B7 10 8E 04 04    ....
L02BB      lda    #1                                                    * 02BB 86 01          ..
           os9    I$Write                                               * 02BD 10 3F 8A       .?.
           leax   U0001,U                                               * 02C0 30 41          0A
           ldy    #1                                                    * 02C2 10 8E 00 01    ....
           clra                                                         * 02C6 4F             O
           os9    I$Read                                                * 02C7 10 3F 89       .?.
           lda    U0001,U                                               * 02CA A6 41          &A
           cmpa   #21                                                   * 02CC 81 15          ..
           beq    L02AA                                                 * 02CE 27 DA          'Z
           cmpa   #6                                                    * 02D0 81 06          ..
           beq    L02E0                                                 * 02D2 27 0C          '.
           cmpa   #24                                                   * 02D4 81 18          ..
           beq    L0320                                                 * 02D6 27 48          'H
           cmpa   #67                                                   * 02D8 81 43          .C
           beq    L02AA                                                 * 02DA 27 CE          'N
           ldb    #1                                                    * 02DC C6 01          F.
           bra    L032E                                                 * 02DE 20 4E           N
L02E0      lda    <U0017,U                                              * 02E0 A6 C8 17       &H.
           inca                                                         * 02E3 4C             L
           sta    <U0017,U                                              * 02E4 A7 C8 17       'H.
           coma                                                         * 02E7 43             C
           sta    <U0018,U                                              * 02E8 A7 C8 18       'H.
           lbra   L0215                                                 * 02EB 16 FF 27       ..'
L02EE      cmpb   #211                                                  * 02EE C1 D3          AS
           lbne   L032E                                                 * 02F0 10 26 00 3A    .&.:
           leax   L0106,PC                                              * 02F4 30 8D FE 0E    0.~.
           ldy    #1                                                    * 02F8 10 8E 00 01    ....
           lda    #1                                                    * 02FC 86 01          ..
           os9    I$Write                                               * 02FE 10 3F 8A       .?.
           leax   U0001,U                                               * 0301 30 41          0A
           ldy    #1                                                    * 0303 10 8E 00 01    ....
           clra                                                         * 0307 4F             O
           os9    I$Read                                                * 0308 10 3F 89       .?.
           lda    U0001,U                                               * 030B A6 41          &A
           cmpa   #6                                                    * 030D 81 06          ..
           bne    L0320                                                 * 030F 26 0F          &.
           leax   L00B9,PC                                              * 0311 30 8D FD A4    0.}$
           ldy    #200                                                  * 0315 10 8E 00 C8    ...H
           lda    #1                                                    * 0319 86 01          ..
           os9    I$WritLn                                              * 031B 10 3F 8C       .?.
           bra    L032D                                                 * 031E 20 0D           .
L0320      leax   L00D2,PC                                              * 0320 30 8D FD AE    0.}.
           ldy    #200                                                  * 0324 10 8E 00 C8    ...H
           lda    #1                                                    * 0328 86 01          ..
           os9    I$WritLn                                              * 032A 10 3F 8C       .?.
L032D      clrb                                                         * 032D 5F             _
L032E      pshs   B                                                     * 032E 34 04          4.
           bsr    L0337                                                 * 0330 8D 05          ..
           puls   B                                                     * 0332 35 04          5.
           os9    F$Exit                                                * 0334 10 3F 06       .?.
L0337      leax   >U043D,U                                              * 0337 30 C9 04 3D    0I.=
           leax   <$FFE0,X                                              * 033B 30 88 E0       0.`
           lda    #1                                                    * 033E 86 01          ..
           sta    <$0024,X                                              * 0340 A7 88 24       '.$
           leax   >U043D,U                                              * 0343 30 C9 04 3D    0I.=
           clra                                                         * 0347 4F             O
           clrb                                                         * 0348 5F             _
           os9    I$SetStt                                              * 0349 10 3F 8E       .?.
           rts                                                          * 034C 39             9
           fcb    $34                                                   * 034D 34             4
           fcb    $20                                                   * 034E 20
           fcb    $A6                                                   * 034F A6             &
           fcb    $80                                                   * 0350 80             .
           fcb    $81                                                   * 0351 81             .
           fcb    $30                                                   * 0352 30             0
           fcb    $25                                                   * 0353 25             %
           fcb    $FA                                                   * 0354 FA             z
           fcb    $81                                                   * 0355 81             .
           fcb    $39                                                   * 0356 39             9
           fcb    $22                                                   * 0357 22             "
           fcb    $F6                                                   * 0358 F6             v
           fcb    $30                                                   * 0359 30             0
           fcb    $1F                                                   * 035A 1F             .
           fcb    $A6                                                   * 035B A6             &
           fcb    $80                                                   * 035C 80             .
           fcb    $81                                                   * 035D 81             .
           fcb    $30                                                   * 035E 30             0
           fcb    $25                                                   * 035F 25             %
           fcb    $06                                                   * 0360 06             .
           fcb    $81                                                   * 0361 81             .
           fcb    $39                                                   * 0362 39             9
           fcb    $22                                                   * 0363 22             "
           fcb    $02                                                   * 0364 02             .
           fcb    $20                                                   * 0365 20
           fcb    $F4                                                   * 0366 F4             t
           fcb    $34                                                   * 0367 34             4
           fcb    $10                                                   * 0368 10             .
           fcb    $30                                                   * 0369 30             0
           fcb    $1F                                                   * 036A 1F             .
           fcb    $6F                                                   * 036B 6F             o
           fcb    $48                                                   * 036C 48             H
           fcb    $6F                                                   * 036D 6F             o
           fcb    $49                                                   * 036E 49             I
           fcb    $CC                                                   * 036F CC             L
           fcb    $00                                                   * 0370 00             .
           fcb    $01                                                   * 0371 01             .
           fcb    $ED                                                   * 0372 ED             m
           fcb    $4A                                                   * 0373 4A             J
           fcb    $A6                                                   * 0374 A6             &
           fcb    $82                                                   * 0375 82             .
           fcb    $81                                                   * 0376 81             .
           fcb    $30                                                   * 0377 30             0
           fcb    $25                                                   * 0378 25             %
           fcb    $2E                                                   * 0379 2E             .
           fcb    $81                                                   * 037A 81             .
           fcb    $39                                                   * 037B 39             9
           fcb    $22                                                   * 037C 22             "
           fcb    $2A                                                   * 037D 2A             *
           fcb    $80                                                   * 037E 80             .
           fcb    $30                                                   * 037F 30             0
           fcb    $A7                                                   * 0380 A7             '
           fcb    $46                                                   * 0381 46             F
           fcb    $CC                                                   * 0382 CC             L
           fcb    $00                                                   * 0383 00             .
           fcb    $00                                                   * 0384 00             .
           fcb    $6D                                                   * 0385 6D             m
           fcb    $46                                                   * 0386 46             F
           fcb    $27                                                   * 0387 27             '
           fcb    $06                                                   * 0388 06             .
           fcb    $E3                                                   * 0389 E3             c
           fcb    $4A                                                   * 038A 4A             J
           fcb    $6A                                                   * 038B 6A             j
           fcb    $46                                                   * 038C 46             F
           fcb    $20                                                   * 038D 20
           fcb    $F6                                                   * 038E F6             v
           fcb    $E3                                                   * 038F E3             c
           fcb    $48                                                   * 0390 48             H
           fcb    $ED                                                   * 0391 ED             m
           fcb    $48                                                   * 0392 48             H
           fcb    $86                                                   * 0393 86             .
           fcb    $0A                                                   * 0394 0A             .
           fcb    $A7                                                   * 0395 A7             '
           fcb    $46                                                   * 0396 46             F
           fcb    $CC                                                   * 0397 CC             L
           fcb    $00                                                   * 0398 00             .
           fcb    $00                                                   * 0399 00             .
           fcb    $6D                                                   * 039A 6D             m
           fcb    $46                                                   * 039B 46             F
           fcb    $27                                                   * 039C 27             '
           fcb    $06                                                   * 039D 06             .
           fcb    $E3                                                   * 039E E3             c
           fcb    $4A                                                   * 039F 4A             J
           fcb    $6A                                                   * 03A0 6A             j
           fcb    $46                                                   * 03A1 46             F
           fcb    $20                                                   * 03A2 20
           fcb    $F6                                                   * 03A3 F6             v
           fcb    $ED                                                   * 03A4 ED             m
           fcb    $4A                                                   * 03A5 4A             J
           fcb    $20                                                   * 03A6 20
           fcb    $CC                                                   * 03A7 CC             L
           fcb    $EC                                                   * 03A8 EC             l
           fcb    $48                                                   * 03A9 48             H
           fcb    $35                                                   * 03AA 35             5
           fcb    $10                                                   * 03AB 10             .
           fcb    $35                                                   * 03AC 35             5
           fcb    $A0                                                   * 03AD A0
L03AE      std    U0008,U                                               * 03AE ED 48          mH
           lda    #48                                                   * 03B0 86 30          .0
           sta    0,X                                                   * 03B2 A7 84          '.
           sta    $01,X                                                 * 03B4 A7 01          '.
           sta    $02,X                                                 * 03B6 A7 02          '.
           sta    $03,X                                                 * 03B8 A7 03          '.
           sta    $04,X                                                 * 03BA A7 04          '.
           ldd    #10000                                                * 03BC CC 27 10       L'.
           std    U000A,U                                               * 03BF ED 4A          mJ
           ldd    U0008,U                                               * 03C1 EC 48          lH
           lbsr   L03EF                                                 * 03C3 17 00 29       ..)
           ldd    #1000                                                 * 03C6 CC 03 E8       L.h
           std    U000A,U                                               * 03C9 ED 4A          mJ
           ldd    U0008,U                                               * 03CB EC 48          lH
           bsr    L03EF                                                 * 03CD 8D 20          .
           ldd    #100                                                  * 03CF CC 00 64       L.d
           std    U000A,U                                               * 03D2 ED 4A          mJ
           ldd    U0008,U                                               * 03D4 EC 48          lH
           bsr    L03EF                                                 * 03D6 8D 17          ..
           ldd    #10                                                   * 03D8 CC 00 0A       L..
           std    U000A,U                                               * 03DB ED 4A          mJ
           ldd    U0008,U                                               * 03DD EC 48          lH
           bsr    L03EF                                                 * 03DF 8D 0E          ..
           ldd    #1                                                    * 03E1 CC 00 01       L..
           std    U000A,U                                               * 03E4 ED 4A          mJ
           ldd    U0008,U                                               * 03E6 EC 48          lH
           bsr    L03EF                                                 * 03E8 8D 05          ..
           lda    #13                                                   * 03EA 86 0D          ..
           sta    0,X                                                   * 03EC A7 84          '.
           rts                                                          * 03EE 39             9
L03EF      subd   U000A,U                                               * 03EF A3 4A          #J
           bcs    L03F7                                                 * 03F1 25 04          %.
           inc    0,X                                                   * 03F3 6C 84          l.
           bra    L03EF                                                 * 03F5 20 F8           x
L03F7      addd   U000A,U                                               * 03F7 E3 4A          cJ
           std    U0008,U                                               * 03F9 ED 48          mH
           leax   $01,X                                                 * 03FB 30 01          0.
           rts                                                          * 03FD 39             9

           emod
eom        equ    *
           end
