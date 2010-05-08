           nam    Uloadx
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
U0004      rmb    2
U0006      rmb    1
U0007      rmb    2
U0009      rmb    32
U0029      rmb    1
U002A      rmb    1
U002B      rmb    128
U00AB      rmb    1
U00AC      rmb    32
U00CC      rmb    1
U00CD      rmb    431
size       equ    .

name       fcs    /Uloadx/                                              * 000D 55 6C 6F 61 64 F8 Uloadx
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
L007E      fcb    $46                                                   * 007E 46             F
           fcb    $69                                                   * 007F 69             i
           fcb    $6C                                                   * 0080 6C             l
           fcb    $65                                                   * 0081 65             e
           fcb    $20                                                   * 0082 20
           fcb    $6F                                                   * 0083 6F             o
           fcb    $70                                                   * 0084 70             p
           fcb    $65                                                   * 0085 65             e
           fcb    $6E                                                   * 0086 6E             n
           fcb    $2C                                                   * 0087 2C             ,
           fcb    $20                                                   * 0088 20
           fcb    $72                                                   * 0089 72             r
           fcb    $65                                                   * 008A 65             e
           fcb    $61                                                   * 008B 61             a
           fcb    $64                                                   * 008C 64             d
           fcb    $79                                                   * 008D 79             y
           fcb    $20                                                   * 008E 20
           fcb    $74                                                   * 008F 74             t
           fcb    $6F                                                   * 0090 6F             o
           fcb    $20                                                   * 0091 20
           fcb    $72                                                   * 0092 72             r
           fcb    $65                                                   * 0093 65             e
           fcb    $63                                                   * 0094 63             c
           fcb    $69                                                   * 0095 69             i
           fcb    $65                                                   * 0096 65             e
           fcb    $76                                                   * 0097 76             v
           fcb    $65                                                   * 0098 65             e
           fcb    $2E                                                   * 0099 2E             .
           fcb    $2E                                                   * 009A 2E             .
           fcb    $2E                                                   * 009B 2E             .
           fcb    $0D                                                   * 009C 0D             .
L009D      fcb    $45                                                   * 009D 45             E
           fcb    $6E                                                   * 009E 6E             n
           fcb    $74                                                   * 009F 74             t
           fcb    $65                                                   * 00A0 65             e
           fcb    $72                                                   * 00A1 72             r
           fcb    $20                                                   * 00A2 20
           fcb    $66                                                   * 00A3 66             f
           fcb    $69                                                   * 00A4 69             i
           fcb    $6C                                                   * 00A5 6C             l
           fcb    $65                                                   * 00A6 65             e
           fcb    $6E                                                   * 00A7 6E             n
           fcb    $61                                                   * 00A8 61             a
           fcb    $6D                                                   * 00A9 6D             m
           fcb    $65                                                   * 00AA 65             e
           fcb    $20                                                   * 00AB 20
           fcb    $74                                                   * 00AC 74             t
           fcb    $6F                                                   * 00AD 6F             o
           fcb    $20                                                   * 00AE 20
           fcb    $75                                                   * 00AF 75             u
           fcb    $70                                                   * 00B0 70             p
           fcb    $6C                                                   * 00B1 6C             l
           fcb    $6F                                                   * 00B2 6F             o
           fcb    $61                                                   * 00B3 61             a
           fcb    $64                                                   * 00B4 64             d
           fcb    $3A                                                   * 00B5 3A             :
           fcb    $20                                                   * 00B6 20
L00B7      fcb    $55                                                   * 00B7 55             U
           fcb    $70                                                   * 00B8 70             p
           fcb    $6C                                                   * 00B9 6C             l
           fcb    $6F                                                   * 00BA 6F             o
           fcb    $61                                                   * 00BB 61             a
           fcb    $64                                                   * 00BC 64             d
           fcb    $20                                                   * 00BD 20
           fcb    $61                                                   * 00BE 61             a
           fcb    $62                                                   * 00BF 62             b
           fcb    $6F                                                   * 00C0 6F             o
           fcb    $72                                                   * 00C1 72             r
           fcb    $74                                                   * 00C2 74             t
           fcb    $65                                                   * 00C3 65             e
           fcb    $64                                                   * 00C4 64             d
           fcb    $21                                                   * 00C5 21             !
           fcb    $0D                                                   * 00C6 0D             .
L00C7      fcb    $55                                                   * 00C7 55             U
           fcb    $70                                                   * 00C8 70             p
           fcb    $6C                                                   * 00C9 6C             l
           fcb    $6F                                                   * 00CA 6F             o
           fcb    $61                                                   * 00CB 61             a
           fcb    $64                                                   * 00CC 64             d
           fcb    $20                                                   * 00CD 20
           fcb    $73                                                   * 00CE 73             s
           fcb    $75                                                   * 00CF 75             u
           fcb    $63                                                   * 00D0 63             c
           fcb    $63                                                   * 00D1 63             c
           fcb    $65                                                   * 00D2 65             e
           fcb    $73                                                   * 00D3 73             s
           fcb    $73                                                   * 00D4 73             s
           fcb    $66                                                   * 00D5 66             f
           fcb    $75                                                   * 00D6 75             u
           fcb    $6C                                                   * 00D7 6C             l
           fcb    $21                                                   * 00D8 21             !
           fcb    $0D                                                   * 00D9 0D             .
start      pshs   X                                                     * 00DA 34 10          4.
           os9    F$ID                                                  * 00DC 10 3F 0C       .?.
           ldb    #255                                                  * 00DF C6 FF          F.
           os9    F$SPrior                                              * 00E1 10 3F 0D       .?.
           lda    0,X                                                   * 00E4 A6 84          &.
           cmpa   #13                                                   * 00E6 81 0D          ..
           bne    L0101                                                 * 00E8 26 17          &.
           leax   L009D,PC                                              * 00EA 30 8D FF AF    0../
           ldy    #25                                                   * 00EE 10 8E 00 19    ....
           lda    #1                                                    * 00F2 86 01          ..
           os9    I$Write                                               * 00F4 10 3F 8A       .?.
           leax   U0009,U                                               * 00F7 30 49          0I
           ldy    #32                                                   * 00F9 10 8E 00 20    ...
           clra                                                         * 00FD 4F             O
           os9    I$ReadLn                                              * 00FE 10 3F 8B       .?.
L0101      stx    U0007,U                                               * 0101 AF 47          /G
           lda    #2                                                    * 0103 86 02          ..
           ldb    #27                                                   * 0105 C6 1B          F.
           os9    I$Create                                              * 0107 10 3F 83       .?.
           lbcs   L02BD                                                 * 010A 10 25 01 AF    .%./
           sta    U0001,U                                               * 010E A7 41          'A
           clr    U0003,U                                               * 0110 6F 43          oC
           clr    U0002,U                                               * 0112 6F 42          oB
           clr    >U00AB,U                                              * 0114 6F C9 00 AB    oI.+
           dec    >U00AB,U                                              * 0118 6A C9 00 AB    jI.+
           leax   L007E,PC                                              * 011C 30 8D FF 5E    0..^
           ldy    #200                                                  * 0120 10 8E 00 C8    ...H
           lda    #1                                                    * 0124 86 01          ..
           os9    I$WritLn                                              * 0126 10 3F 8C       .?.
           leax   >U00AC,U                                              * 0129 30 C9 00 AC    0I.,
           clra                                                         * 012D 4F             O
           clrb                                                         * 012E 5F             _
           os9    I$GetStt                                              * 012F 10 3F 8D       .?.
           lbcs   L02BD                                                 * 0132 10 25 01 87    .%..
           leax   >U00CC,U                                              * 0136 30 C9 00 CC    0I.L
           clra                                                         * 013A 4F             O
           clrb                                                         * 013B 5F             _
           os9    I$GetStt                                              * 013C 10 3F 8D       .?.
           lbcs   L02BD                                                 * 013F 10 25 01 7A    .%.z
           leax   >U00CC,U                                              * 0143 30 C9 00 CC    0I.L
           leax   <$FFE0,X                                              * 0147 30 88 E0       0.`
           clr    <$002B,X                                              * 014A 6F 88 2B       o.+
           clr    <$002C,X                                              * 014D 6F 88 2C       o.,
           clr    <$002E,X                                              * 0150 6F 88 2E       o..
           clr    <$002F,X                                              * 0153 6F 88 2F       o./
           clr    <$0030,X                                              * 0156 6F 88 30       o.0
           clr    <$0031,X                                              * 0159 6F 88 31       o.1
           clr    <$0038,X                                              * 015C 6F 88 38       o.8
           clr    <$0039,X                                              * 015F 6F 88 39       o.9
           clr    <$0024,X                                              * 0162 6F 88 24       o.$
           clr    <$002D,X                                              * 0165 6F 88 2D       o.-
           clr    <$0027,X                                              * 0168 6F 88 27       o.'
           clr    <$0028,X                                              * 016B 6F 88 28       o.(
           clr    <$0029,X                                              * 016E 6F 88 29       o.)
           clra                                                         * 0171 4F             O
           clrb                                                         * 0172 5F             _
           leax   >U00CC,U                                              * 0173 30 C9 00 CC    0I.L
           os9    I$SetStt                                              * 0177 10 3F 8E       .?.
L017A      lda    #21                                                   * 017A 86 15          ..
           sta    U0000,U                                               * 017C A7 C4          'D
           leax   U0000,U                                               * 017E 30 C4          0D
           lda    #1                                                    * 0180 86 01          ..
           ldy    #1                                                    * 0182 10 8E 00 01    ....
           os9    I$Write                                               * 0186 10 3F 8A       .?.
           clr    U0004,U                                               * 0189 6F 44          oD
           lda    U0003,U                                               * 018B A6 43          &C
           inca                                                         * 018D 4C             L
           sta    U0003,U                                               * 018E A7 43          'C
           cmpa   #10                                                   * 0190 81 0A          ..
           bcs    L0199                                                 * 0192 25 05          %.
           ldb    #1                                                    * 0194 C6 01          F.
           lbra   L02B6                                                 * 0196 16 01 1D       ...
L0199      clra                                                         * 0199 4F             O
           ldb    #1                                                    * 019A C6 01          F.
           os9    I$GetStt                                              * 019C 10 3F 8D       .?.
           bcc    L01B1                                                 * 019F 24 10          $.
           ldy    U0004,U                                               * 01A1 10 AE 44       ..D
           leay   $01,Y                                                 * 01A4 31 21          1!
           sty    U0004,U                                               * 01A6 10 AF 44       ./D
           cmpy   #4096                                                 * 01A9 10 8C 10 00    ....
           bcc    L017A                                                 * 01AD 24 CB          $K
           bra    L0199                                                 * 01AF 20 E8           h
L01B1      leax   U0000,U                                               * 01B1 30 C4          0D
           ldy    #1                                                    * 01B3 10 8E 00 01    ....
           clra                                                         * 01B7 4F             O
           os9    I$Read                                                * 01B8 10 3F 89       .?.
           lda    U0000,U                                               * 01BB A6 C4          &D
           cmpa   #1                                                    * 01BD 81 01          ..
           beq    L01CF                                                 * 01BF 27 0E          '.
           cmpa   #4                                                    * 01C1 81 04          ..
           lbeq   L0291                                                 * 01C3 10 27 00 CA    .'.J
           cmpa   #24                                                   * 01C7 81 18          ..
           lbeq   L02C0                                                 * 01C9 10 27 00 F3    .'.s
           bra    L0199                                                 * 01CD 20 CA           J
L01CF      leax   <U0029,U                                              * 01CF 30 C8 29       0H)
           lda    #131                                                  * 01D2 86 83          ..
           sta    U0006,U                                               * 01D4 A7 46          'F
           clr    U0004,U                                               * 01D6 6F 44          oD
           bsr    L01E3                                                 * 01D8 8D 09          ..
           lbcs   L017A                                                 * 01DA 10 25 FF 9C    .%..
           inc    U0002,U                                               * 01DE 6C 42          lB
           lbra   L0232                                                 * 01E0 16 00 4F       ..O
L01E3      clra                                                         * 01E3 4F             O
           ldb    #1                                                    * 01E4 C6 01          F.
           os9    I$GetStt                                              * 01E6 10 3F 8D       .?.
           bcc    L01FB                                                 * 01E9 24 10          $.
           ldy    U0004,U                                               * 01EB 10 AE 44       ..D
           leay   $01,Y                                                 * 01EE 31 21          1!
           sty    U0004,U                                               * 01F0 10 AF 44       ./D
           cmpy   #4096                                                 * 01F3 10 8C 10 00    ....
           bhi    L0214                                                 * 01F7 22 1B          ".
           bra    L01E3                                                 * 01F9 20 E8           h
L01FB      clr    U0004,U                                               * 01FB 6F 44          oD
           clra                                                         * 01FD 4F             O
           tfr    D,Y                                                   * 01FE 1F 02          ..
           os9    I$Read                                                * 0200 10 3F 89       .?.
           bcs    L0218                                                 * 0203 25 13          %.
           tfr    Y,D                                                   * 0205 1F 20          .
           leax   B,X                                                   * 0207 30 85          0.
           lda    U0006,U                                               * 0209 A6 46          &F
           stb    U0006,U                                               * 020B E7 46          gF
           suba   U0006,U                                               * 020D A0 46           F
           sta    U0006,U                                               * 020F A7 46          'F
           bne    L01E3                                                 * 0211 26 D0          &P
           rts                                                          * 0213 39             9
L0214      lda    #255                                                  * 0214 86 FF          ..
           rola                                                         * 0216 49             I
           rts                                                          * 0217 39             9
L0218      pshs   X                                                     * 0218 34 10          4.
           ldx    #60                                                   * 021A 8E 00 3C       ..<
           os9    F$Sleep                                               * 021D 10 3F 0A       .?.
           puls   X                                                     * 0220 35 10          5.
           clra                                                         * 0222 4F             O
           ldb    #1                                                    * 0223 C6 01          F.
           os9    I$GetStt                                              * 0225 10 3F 8D       .?.
           clra                                                         * 0228 4F             O
           tfr    D,Y                                                   * 0229 1F 02          ..
           os9    I$Read                                                * 022B 10 3F 89       .?.
           lda    #255                                                  * 022E 86 FF          ..
           rola                                                         * 0230 49             I
           rts                                                          * 0231 39             9
L0232      lda    <U0029,U                                              * 0232 A6 C8 29       &H)
           inca                                                         * 0235 4C             L
           cmpa   U0002,U                                               * 0236 A1 42          !B
           lbeq   L0275                                                 * 0238 10 27 00 39    .'.9
           deca                                                         * 023C 4A             J
           cmpa   U0002,U                                               * 023D A1 42          !B
           beq    L0246                                                 * 023F 27 05          '.
           dec    U0002,U                                               * 0241 6A 42          jB
           lbra   L017A                                                 * 0243 16 FF 34       ..4
L0246      coma                                                         * 0246 43             C
           cmpa   <U002A,U                                              * 0247 A1 C8 2A       !H*
           beq    L0251                                                 * 024A 27 05          '.
           dec    U0002,U                                               * 024C 6A 42          jB
           lbra   L017A                                                 * 024E 16 FF 29       ..)
L0251      leax   <U002B,U                                              * 0251 30 C8 2B       0H+
           ldb    #128                                                  * 0254 C6 80          F.
           clra                                                         * 0256 4F             O
L0257      adda   ,X+                                                   * 0257 AB 80          +.
           decb                                                         * 0259 5A             Z
           bne    L0257                                                 * 025A 26 FB          &{
           cmpa   >U00AB,U                                              * 025C A1 C9 00 AB    !I.+
           beq    L0267                                                 * 0260 27 05          '.
           dec    U0002,U                                               * 0262 6A 42          jB
           lbra   L017A                                                 * 0264 16 FF 13       ...
L0267      lda    U0001,U                                               * 0267 A6 41          &A
           leax   <U002B,U                                              * 0269 30 C8 2B       0H+
           ldy    #128                                                  * 026C 10 8E 00 80    ....
           os9    I$Write                                               * 0270 10 3F 8A       .?.
           bra    L0277                                                 * 0273 20 02           .
L0275      dec    U0002,U                                               * 0275 6A 42          jB
L0277      ldx    #10                                                   * 0277 8E 00 0A       ...
           os9    F$Sleep                                               * 027A 10 3F 0A       .?.
           lda    #6                                                    * 027D 86 06          ..
           sta    U0000,U                                               * 027F A7 C4          'D
           lda    #1                                                    * 0281 86 01          ..
           leax   U0000,U                                               * 0283 30 C4          0D
           ldy    #1                                                    * 0285 10 8E 00 01    ....
           os9    I$Write                                               * 0289 10 3F 8A       .?.
           clr    U0003,U                                               * 028C 6F 43          oC
           lbra   L0199                                                 * 028E 16 FF 08       ...
L0291      lda    #6                                                    * 0291 86 06          ..
           sta    U0000,U                                               * 0293 A7 C4          'D
           lda    #1                                                    * 0295 86 01          ..
           leax   U0000,U                                               * 0297 30 C4          0D
           ldy    #1                                                    * 0299 10 8E 00 01    ....
           os9    I$Write                                               * 029D 10 3F 8A       .?.
           lda    U0001,U                                               * 02A0 A6 41          &A
           os9    I$Close                                               * 02A2 10 3F 8F       .?.
           lbsr   L02E1                                                 * 02A5 17 00 39       ..9
           leax   L00C7,PC                                              * 02A8 30 8D FE 1B    0.~.
           ldy    #200                                                  * 02AC 10 8E 00 C8    ...H
           lda    #1                                                    * 02B0 86 01          ..
           os9    I$WritLn                                              * 02B2 10 3F 8C       .?.
           clrb                                                         * 02B5 5F             _
L02B6      pshs   B                                                     * 02B6 34 04          4.
           lbsr   L02E1                                                 * 02B8 17 00 26       ..&
           puls   B                                                     * 02BB 35 04          5.
L02BD      os9    F$Exit                                                * 02BD 10 3F 06       .?.
L02C0      bsr    L02E1                                                 * 02C0 8D 1F          ..
           leax   L00B7,PC                                              * 02C2 30 8D FD F1    0.}q
           ldy    #200                                                  * 02C6 10 8E 00 C8    ...H
           lda    #1                                                    * 02CA 86 01          ..
           os9    I$WritLn                                              * 02CC 10 3F 8C       .?.
           lda    U0001,U                                               * 02CF A6 41          &A
           os9    I$Close                                               * 02D1 10 3F 8F       .?.
           ldx    U0007,U                                               * 02D4 AE 47          .G
           os9    I$Delete                                              * 02D6 10 3F 87       .?.
           lbcs   L02B6                                                 * 02D9 10 25 FF D9    .%.Y
           ldb    #1                                                    * 02DD C6 01          F.
           bra    L02B6                                                 * 02DF 20 D5           U
L02E1      leax   >U00AC,U                                              * 02E1 30 C9 00 AC    0I.,
           clra                                                         * 02E5 4F             O
           clrb                                                         * 02E6 5F             _
           os9    I$SetStt                                              * 02E7 10 3F 8E       .?.
           rts                                                          * 02EA 39             9

           emod
eom        equ    *
           end
