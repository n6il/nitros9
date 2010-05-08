           nam    BBS.validate
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
U0005      rmb    80
U0055      rmb    1
U0056      rmb    479
size       equ    .

name       fcs    /BBS.validate/                                            * 000D 42 42 53 2E 76 61 6C 69 64 61 74 E5 BBS.validate
L0019      fcb    $45                                                   * 0019 45             E
           fcb    $6E                                                   * 001A 6E             n
           fcb    $74                                                   * 001B 74             t
           fcb    $65                                                   * 001C 65             e
           fcb    $72                                                   * 001D 72             r
           fcb    $20                                                   * 001E 20
           fcb    $6E                                                   * 001F 6E             n
           fcb    $65                                                   * 0020 65             e
           fcb    $77                                                   * 0021 77             w
           fcb    $20                                                   * 0022 20
           fcb    $75                                                   * 0023 75             u
           fcb    $73                                                   * 0024 73             s
           fcb    $65                                                   * 0025 65             e
           fcb    $72                                                   * 0026 72             r
           fcb    $27                                                   * 0027 27             '
           fcb    $73                                                   * 0028 73             s
           fcb    $20                                                   * 0029 20
           fcb    $6E                                                   * 002A 6E             n
           fcb    $61                                                   * 002B 61             a
           fcb    $6D                                                   * 002C 6D             m
           fcb    $65                                                   * 002D 65             e
           fcb    $3A                                                   * 002E 3A             :
           fcb    $3D                                                   * 002F 3D             =
           fcb    $3D                                                   * 0030 3D             =
           fcb    $3D                                                   * 0031 3D             =
           fcb    $3D                                                   * 0032 3D             =
           fcb    $3D                                                   * 0033 3D             =
           fcb    $3E                                                   * 0034 3E             >
L0035      fcb    $45                                                   * 0035 45             E
           fcb    $6E                                                   * 0036 6E             n
           fcb    $74                                                   * 0037 74             t
           fcb    $65                                                   * 0038 65             e
           fcb    $72                                                   * 0039 72             r
           fcb    $20                                                   * 003A 20
           fcb    $6E                                                   * 003B 6E             n
           fcb    $65                                                   * 003C 65             e
           fcb    $77                                                   * 003D 77             w
           fcb    $20                                                   * 003E 20
           fcb    $75                                                   * 003F 75             u
           fcb    $73                                                   * 0040 73             s
           fcb    $65                                                   * 0041 65             e
           fcb    $72                                                   * 0042 72             r
           fcb    $27                                                   * 0043 27             '
           fcb    $73                                                   * 0044 73             s
           fcb    $20                                                   * 0045 20
           fcb    $70                                                   * 0046 70             p
           fcb    $61                                                   * 0047 61             a
           fcb    $73                                                   * 0048 73             s
           fcb    $73                                                   * 0049 73             s
           fcb    $77                                                   * 004A 77             w
           fcb    $6F                                                   * 004B 6F             o
           fcb    $72                                                   * 004C 72             r
           fcb    $64                                                   * 004D 64             d
           fcb    $3A                                                   * 004E 3A             :
           fcb    $3D                                                   * 004F 3D             =
           fcb    $3E                                                   * 0050 3E             >
L0051      fcb    $45                                                   * 0051 45             E
           fcb    $6E                                                   * 0052 6E             n
           fcb    $74                                                   * 0053 74             t
           fcb    $65                                                   * 0054 65             e
           fcb    $72                                                   * 0055 72             r
           fcb    $20                                                   * 0056 20
           fcb    $6E                                                   * 0057 6E             n
           fcb    $65                                                   * 0058 65             e
           fcb    $77                                                   * 0059 77             w
           fcb    $20                                                   * 005A 20
           fcb    $75                                                   * 005B 75             u
           fcb    $73                                                   * 005C 73             s
           fcb    $65                                                   * 005D 65             e
           fcb    $72                                                   * 005E 72             r
           fcb    $27                                                   * 005F 27             '
           fcb    $73                                                   * 0060 73             s
           fcb    $20                                                   * 0061 20
           fcb    $70                                                   * 0062 70             p
           fcb    $72                                                   * 0063 72             r
           fcb    $6F                                                   * 0064 6F             o
           fcb    $67                                                   * 0065 67             g
           fcb    $72                                                   * 0066 72             r
           fcb    $61                                                   * 0067 61             a
           fcb    $6D                                                   * 0068 6D             m
           fcb    $3A                                                   * 0069 3A             :
           fcb    $3D                                                   * 006A 3D             =
           fcb    $3D                                                   * 006B 3D             =
           fcb    $3E                                                   * 006C 3E             >
L006D      fcb    $45                                                   * 006D 45             E
           fcb    $6E                                                   * 006E 6E             n
           fcb    $74                                                   * 006F 74             t
           fcb    $65                                                   * 0070 65             e
           fcb    $72                                                   * 0071 72             r
           fcb    $20                                                   * 0072 20
           fcb    $6E                                                   * 0073 6E             n
           fcb    $65                                                   * 0074 65             e
           fcb    $77                                                   * 0075 77             w
           fcb    $20                                                   * 0076 20
           fcb    $75                                                   * 0077 75             u
           fcb    $73                                                   * 0078 73             s
           fcb    $65                                                   * 0079 65             e
           fcb    $72                                                   * 007A 72             r
           fcb    $27                                                   * 007B 27             '
           fcb    $73                                                   * 007C 73             s
           fcb    $20                                                   * 007D 20
           fcb    $6E                                                   * 007E 6E             n
           fcb    $75                                                   * 007F 75             u
           fcb    $6D                                                   * 0080 6D             m
           fcb    $62                                                   * 0081 62             b
           fcb    $65                                                   * 0082 65             e
           fcb    $72                                                   * 0083 72             r
           fcb    $3A                                                   * 0084 3A             :
           fcb    $3D                                                   * 0085 3D             =
           fcb    $3D                                                   * 0086 3D             =
           fcb    $3D                                                   * 0087 3D             =
           fcb    $3E                                                   * 0088 3E             >
L0089      fcb    $45                                                   * 0089 45             E
           fcb    $6E                                                   * 008A 6E             n
           fcb    $74                                                   * 008B 74             t
           fcb    $65                                                   * 008C 65             e
           fcb    $72                                                   * 008D 72             r
           fcb    $20                                                   * 008E 20
           fcb    $6E                                                   * 008F 6E             n
           fcb    $65                                                   * 0090 65             e
           fcb    $77                                                   * 0091 77             w
           fcb    $20                                                   * 0092 20
           fcb    $75                                                   * 0093 75             u
           fcb    $73                                                   * 0094 73             s
           fcb    $65                                                   * 0095 65             e
           fcb    $72                                                   * 0096 72             r
           fcb    $27                                                   * 0097 27             '
           fcb    $73                                                   * 0098 73             s
           fcb    $20                                                   * 0099 20
           fcb    $74                                                   * 009A 74             t
           fcb    $69                                                   * 009B 69             i
           fcb    $6D                                                   * 009C 6D             m
           fcb    $65                                                   * 009D 65             e
           fcb    $20                                                   * 009E 20
           fcb    $6C                                                   * 009F 6C             l
           fcb    $69                                                   * 00A0 69             i
           fcb    $6D                                                   * 00A1 6D             m
           fcb    $69                                                   * 00A2 69             i
           fcb    $74                                                   * 00A3 74             t
           fcb    $3E                                                   * 00A4 3E             >
L00A5      fcb    $45                                                   * 00A5 45             E
           fcb    $6E                                                   * 00A6 6E             n
           fcb    $74                                                   * 00A7 74             t
           fcb    $65                                                   * 00A8 65             e
           fcb    $72                                                   * 00A9 72             r
           fcb    $20                                                   * 00AA 20
           fcb    $6E                                                   * 00AB 6E             n
           fcb    $65                                                   * 00AC 65             e
           fcb    $77                                                   * 00AD 77             w
           fcb    $20                                                   * 00AE 20
           fcb    $75                                                   * 00AF 75             u
           fcb    $73                                                   * 00B0 73             s
           fcb    $65                                                   * 00B1 65             e
           fcb    $72                                                   * 00B2 72             r
           fcb    $27                                                   * 00B3 27             '
           fcb    $73                                                   * 00B4 73             s
           fcb    $20                                                   * 00B5 20
           fcb    $61                                                   * 00B6 61             a
           fcb    $6C                                                   * 00B7 6C             l
           fcb    $69                                                   * 00B8 69             i
           fcb    $61                                                   * 00B9 61             a
           fcb    $73                                                   * 00BA 73             s
           fcb    $3A                                                   * 00BB 3A             :
           fcb    $3D                                                   * 00BC 3D             =
           fcb    $3D                                                   * 00BD 3D             =
           fcb    $3D                                                   * 00BE 3D             =
           fcb    $3D                                                   * 00BF 3D             =
           fcb    $3E                                                   * 00C0 3E             >
L00C1      fcb    $0A                                                   * 00C1 0A             .
           fcb    $4E                                                   * 00C2 4E             N
           fcb    $65                                                   * 00C3 65             e
           fcb    $77                                                   * 00C4 77             w
           fcb    $20                                                   * 00C5 20
           fcb    $42                                                   * 00C6 42             B
           fcb    $42                                                   * 00C7 42             B
           fcb    $53                                                   * 00C8 53             S
           fcb    $2E                                                   * 00C9 2E             .
           fcb    $75                                                   * 00CA 75             u
           fcb    $73                                                   * 00CB 73             s
           fcb    $65                                                   * 00CC 65             e
           fcb    $72                                                   * 00CD 72             r
           fcb    $73                                                   * 00CE 73             s
           fcb    $20                                                   * 00CF 20
           fcb    $6C                                                   * 00D0 6C             l
           fcb    $69                                                   * 00D1 69             i
           fcb    $6E                                                   * 00D2 6E             n
           fcb    $65                                                   * 00D3 65             e
           fcb    $20                                                   * 00D4 20
           fcb    $77                                                   * 00D5 77             w
           fcb    $69                                                   * 00D6 69             i
           fcb    $6C                                                   * 00D7 6C             l
           fcb    $6C                                                   * 00D8 6C             l
           fcb    $20                                                   * 00D9 20
           fcb    $72                                                   * 00DA 72             r
           fcb    $65                                                   * 00DB 65             e
           fcb    $61                                                   * 00DC 61             a
           fcb    $64                                                   * 00DD 64             d
           fcb    $20                                                   * 00DE 20
           fcb    $61                                                   * 00DF 61             a
           fcb    $73                                                   * 00E0 73             s
           fcb    $20                                                   * 00E1 20
           fcb    $66                                                   * 00E2 66             f
           fcb    $6F                                                   * 00E3 6F             o
           fcb    $6C                                                   * 00E4 6C             l
           fcb    $6C                                                   * 00E5 6C             l
           fcb    $6F                                                   * 00E6 6F             o
           fcb    $77                                                   * 00E7 77             w
           fcb    $73                                                   * 00E8 73             s
           fcb    $3A                                                   * 00E9 3A             :
           fcb    $0D                                                   * 00EA 0D             .
L00EB      fcb    $0D                                                   * 00EB 0D             .
           fcb    $0A                                                   * 00EC 0A             .
           fcb    $49                                                   * 00ED 49             I
           fcb    $73                                                   * 00EE 73             s
           fcb    $20                                                   * 00EF 20
           fcb    $74                                                   * 00F0 74             t
           fcb    $68                                                   * 00F1 68             h
           fcb    $69                                                   * 00F2 69             i
           fcb    $73                                                   * 00F3 73             s
           fcb    $20                                                   * 00F4 20
           fcb    $6C                                                   * 00F5 6C             l
           fcb    $69                                                   * 00F6 69             i
           fcb    $6E                                                   * 00F7 6E             n
           fcb    $65                                                   * 00F8 65             e
           fcb    $20                                                   * 00F9 20
           fcb    $63                                                   * 00FA 63             c
           fcb    $6F                                                   * 00FB 6F             o
           fcb    $72                                                   * 00FC 72             r
           fcb    $72                                                   * 00FD 72             r
           fcb    $65                                                   * 00FE 65             e
           fcb    $63                                                   * 00FF 63             c
           fcb    $74                                                   * 0100 74             t
           fcb    $3F                                                   * 0101 3F             ?
           fcb    $20                                                   * 0102 20
           fcb    $28                                                   * 0103 28             (
           fcb    $59                                                   * 0104 59             Y
           fcb    $2F                                                   * 0105 2F             /
           fcb    $4E                                                   * 0106 4E             N
           fcb    $29                                                   * 0107 29             )
           fcb    $3A                                                   * 0108 3A             :
L0109      fcb    $42                                                   * 0109 42             B
           fcb    $42                                                   * 010A 42             B
           fcb    $53                                                   * 010B 53             S
           fcb    $2E                                                   * 010C 2E             .
           fcb    $75                                                   * 010D 75             u
           fcb    $73                                                   * 010E 73             s
           fcb    $65                                                   * 010F 65             e
           fcb    $72                                                   * 0110 72             r
           fcb    $73                                                   * 0111 73             s
           fcb    $0D                                                   * 0112 0D             .
L0113      fcb    $2F                                                   * 0113 2F             /
           fcb    $64                                                   * 0114 64             d
           fcb    $64                                                   * 0115 64             d
           fcb    $2F                                                   * 0116 2F             /
           fcb    $62                                                   * 0117 62             b
           fcb    $62                                                   * 0118 62             b
           fcb    $73                                                   * 0119 73             s
           fcb    $2F                                                   * 011A 2F             /
           fcb    $62                                                   * 011B 62             b
           fcb    $62                                                   * 011C 62             b
           fcb    $73                                                   * 011D 73             s
           fcb    $2E                                                   * 011E 2E             .
           fcb    $61                                                   * 011F 61             a
           fcb    $6C                                                   * 0120 6C             l
           fcb    $69                                                   * 0121 69             i
           fcb    $61                                                   * 0122 61             a
           fcb    $73                                                   * 0123 73             s
           fcb    $0D                                                   * 0124 0D             .
L0125      fcb    $0D                                                   * 0125 0D             .
           fcb    $0A                                                   * 0126 0A             .
start      leax   L0109,PC                                              * 0127 30 8D FF DE    0..^
           lda    #3                                                    * 012B 86 03          ..
           os9    I$Open                                                * 012D 10 3F 84       .?.
           bcc    L014E                                                 * 0130 24 1C          $.
           cmpb   #216                                                  * 0132 C1 D8          AX
           lbne   L02F1                                                 * 0134 10 26 01 B9    .&.9
           os9    F$ID                                                  * 0138 10 3F 0C       .?.
           ldb    #214                                                  * 013B C6 D6          FV
           cmpy   #0                                                    * 013D 10 8C 00 00    ....
           lbne   L02F1                                                 * 0141 10 26 01 AC    .&.,
           ldb    #3                                                    * 0145 C6 03          F.
           os9    I$Create                                              * 0147 10 3F 83       .?.
           lbcs   L02F1                                                 * 014A 10 25 01 A3    .%.#
L014E      sta    U0000,U                                               * 014E A7 C4          'D
           leax   L0113,PC                                              * 0150 30 8D FF BF    0..?
           lda    #3                                                    * 0154 86 03          ..
           os9    I$Open                                                * 0156 10 3F 84       .?.
           bcc    L0177                                                 * 0159 24 1C          $.
           cmpb   #216                                                  * 015B C1 D8          AX
           lbne   L02F1                                                 * 015D 10 26 01 90    .&..
           os9    F$ID                                                  * 0161 10 3F 0C       .?.
           ldb    #214                                                  * 0164 C6 D6          FV
           cmpy   #0                                                    * 0166 10 8C 00 00    ....
           lbne   L02F1                                                 * 016A 10 26 01 83    .&..
           ldb    #11                                                   * 016E C6 0B          F.
           os9    I$Create                                              * 0170 10 3F 83       .?.
           lbcs   L02F1                                                 * 0173 10 25 01 7A    .%.z
L0177      sta    U0001,U                                               * 0177 A7 41          'A
           lda    U0000,U                                               * 0179 A6 C4          &D
           ldb    #2                                                    * 017B C6 02          F.
           pshs   U                                                     * 017D 34 40          4@
           os9    I$GetStt                                              * 017F 10 3F 8D       .?.
           lbcs   L02F1                                                 * 0182 10 25 01 6B    .%.k
           os9    I$Seek                                                * 0186 10 3F 88       .?.
           lbcs   L02F1                                                 * 0189 10 25 01 64    .%.d
           puls   U                                                     * 018D 35 40          5@
           lda    U0001,U                                               * 018F A6 41          &A
           ldb    #2                                                    * 0191 C6 02          F.
           pshs   U                                                     * 0193 34 40          4@
           os9    I$GetStt                                              * 0195 10 3F 8D       .?.
           lbcs   L02F1                                                 * 0198 10 25 01 55    .%.U
           os9    I$Seek                                                * 019C 10 3F 88       .?.
           lbcs   L02F1                                                 * 019F 10 25 01 4E    .%.N
           puls   U                                                     * 01A3 35 40          5@
L01A5      leax   L0019,PC                                              * 01A5 30 8D FE 70    0.~p
           ldy    #28                                                   * 01A9 10 8E 00 1C    ....
           lda    #1                                                    * 01AD 86 01          ..
           os9    I$Write                                               * 01AF 10 3F 8A       .?.
           leax   U0005,U                                               * 01B2 30 45          0E
           clra                                                         * 01B4 4F             O
           ldy    #80                                                   * 01B5 10 8E 00 50    ...P
           os9    I$ReadLn                                              * 01B9 10 3F 8B       .?.
           pshs   X                                                     * 01BC 34 10          4.
L01BE      lda    0,X                                                   * 01BE A6 84          &.
           cmpa   #97                                                   * 01C0 81 61          .a
           bcs    L01C6                                                 * 01C2 25 02          %.
           anda   #223                                                  * 01C4 84 DF          ._
L01C6      sta    ,X+                                                   * 01C6 A7 80          '.
           cmpa   #13                                                   * 01C8 81 0D          ..
           bne    L01BE                                                 * 01CA 26 F2          &r
           puls   X                                                     * 01CC 35 10          5.
           tfr    Y,D                                                   * 01CE 1F 20          .
           leax   D,X                                                   * 01D0 30 8B          0.
           lda    #44                                                   * 01D2 86 2C          .,
           sta    -$01,X                                                * 01D4 A7 1F          '.
           pshs   X                                                     * 01D6 34 10          4.
           leax   L0035,PC                                              * 01D8 30 8D FE 59    0.~Y
           ldy    #28                                                   * 01DC 10 8E 00 1C    ....
           lda    #1                                                    * 01E0 86 01          ..
           os9    I$Write                                               * 01E2 10 3F 8A       .?.
           puls   X                                                     * 01E5 35 10          5.
           ldy    #80                                                   * 01E7 10 8E 00 50    ...P
           clra                                                         * 01EB 4F             O
           os9    I$ReadLn                                              * 01EC 10 3F 8B       .?.
           pshs   X                                                     * 01EF 34 10          4.
L01F1      lda    0,X                                                   * 01F1 A6 84          &.
           cmpa   #97                                                   * 01F3 81 61          .a
           bcs    L01F9                                                 * 01F5 25 02          %.
           anda   #223                                                  * 01F7 84 DF          ._
L01F9      sta    ,X+                                                   * 01F9 A7 80          '.
           cmpa   #13                                                   * 01FB 81 0D          ..
           bne    L01F1                                                 * 01FD 26 F2          &r
           puls   X                                                     * 01FF 35 10          5.
           tfr    Y,D                                                   * 0201 1F 20          .
           leax   D,X                                                   * 0203 30 8B          0.
           lda    #44                                                   * 0205 86 2C          .,
           sta    -$01,X                                                * 0207 A7 1F          '.
           pshs   X                                                     * 0209 34 10          4.
           leax   L0051,PC                                              * 020B 30 8D FE 42    0.~B
           ldy    #28                                                   * 020F 10 8E 00 1C    ....
           lda    #1                                                    * 0213 86 01          ..
           os9    I$Write                                               * 0215 10 3F 8A       .?.
           puls   X                                                     * 0218 35 10          5.
           clra                                                         * 021A 4F             O
           ldy    #80                                                   * 021B 10 8E 00 50    ...P
           os9    I$ReadLn                                              * 021F 10 3F 8B       .?.
           tfr    Y,D                                                   * 0222 1F 20          .
           leax   D,X                                                   * 0224 30 8B          0.
           lda    #44                                                   * 0226 86 2C          .,
           sta    -$01,X                                                * 0228 A7 1F          '.
           pshs   X                                                     * 022A 34 10          4.
           leax   L00A5,PC                                              * 022C 30 8D FE 75    0.~u
           ldy    #28                                                   * 0230 10 8E 00 1C    ....
           lda    #1                                                    * 0234 86 01          ..
           os9    I$Write                                               * 0236 10 3F 8A       .?.
           leax   <U0055,U                                              * 0239 30 C8 55       0HU
           ldy    #80                                                   * 023C 10 8E 00 50    ...P
           clra                                                         * 0240 4F             O
           os9    I$ReadLn                                              * 0241 10 3F 8B       .?.
           tfr    Y,D                                                   * 0244 1F 20          .
           leax   D,X                                                   * 0246 30 8B          0.
           lda    #44                                                   * 0248 86 2C          .,
           sta    -$01,X                                                * 024A A7 1F          '.
           stx    U0003,U                                               * 024C AF 43          /C
           leax   L006D,PC                                              * 024E 30 8D FE 1B    0.~.
           ldy    #28                                                   * 0252 10 8E 00 1C    ....
           lda    #1                                                    * 0256 86 01          ..
           os9    I$Write                                               * 0258 10 3F 8A       .?.
           puls   X                                                     * 025B 35 10          5.
           ldy    #80                                                   * 025D 10 8E 00 50    ...P
           clra                                                         * 0261 4F             O
           os9    I$ReadLn                                              * 0262 10 3F 8B       .?.
           ldy    U0003,U                                               * 0265 10 AE 43       ..C
L0268      lda    ,X+                                                   * 0268 A6 80          &.
           sta    ,Y+                                                   * 026A A7 A0          '
           cmpa   #13                                                   * 026C 81 0D          ..
           bne    L0268                                                 * 026E 26 F8          &x
           lda    #44                                                   * 0270 86 2C          .,
           sta    -$01,X                                                * 0272 A7 1F          '.
           pshs   X                                                     * 0274 34 10          4.
           leax   L0089,PC                                              * 0276 30 8D FE 0F    0.~.
           ldy    #28                                                   * 027A 10 8E 00 1C    ....
           lda    #1                                                    * 027E 86 01          ..
           os9    I$Write                                               * 0280 10 3F 8A       .?.
           puls   X                                                     * 0283 35 10          5.
           ldy    #80                                                   * 0285 10 8E 00 50    ...P
           clra                                                         * 0289 4F             O
           os9    I$ReadLn                                              * 028A 10 3F 8B       .?.
           leax   L00C1,PC                                              * 028D 30 8D FE 30    0.~0
           ldy    #200                                                  * 0291 10 8E 00 C8    ...H
           lda    #1                                                    * 0295 86 01          ..
           os9    I$WritLn                                              * 0297 10 3F 8C       .?.
           leax   U0005,U                                               * 029A 30 45          0E
           ldy    #200                                                  * 029C 10 8E 00 C8    ...H
           os9    I$WritLn                                              * 02A0 10 3F 8C       .?.
           leax   L00EB,PC                                              * 02A3 30 8D FE 44    0.~D
           ldy    #30                                                   * 02A7 10 8E 00 1E    ....
           lda    #1                                                    * 02AB 86 01          ..
           os9    I$Write                                               * 02AD 10 3F 8A       .?.
           leax   U0002,U                                               * 02B0 30 42          0B
           ldy    #1                                                    * 02B2 10 8E 00 01    ....
           clra                                                         * 02B6 4F             O
           os9    I$Read                                                * 02B7 10 3F 89       .?.
           leax   L0125,PC                                              * 02BA 30 8D FE 67    0.~g
           ldy    #1                                                    * 02BE 10 8E 00 01    ....
           lda    #1                                                    * 02C2 86 01          ..
           os9    I$WritLn                                              * 02C4 10 3F 8C       .?.
           lda    U0002,U                                               * 02C7 A6 42          &B
           anda   #223                                                  * 02C9 84 DF          ._
           cmpa   #89                                                   * 02CB 81 59          .Y
           lbne   L01A5                                                 * 02CD 10 26 FE D4    .&~T
           lda    U0000,U                                               * 02D1 A6 C4          &D
           leax   U0005,U                                               * 02D3 30 45          0E
           ldy    #81                                                   * 02D5 10 8E 00 51    ...Q
           os9    I$WritLn                                              * 02D9 10 3F 8C       .?.
           lbcs   L02F1                                                 * 02DC 10 25 00 11    .%..
           lda    U0001,U                                               * 02E0 A6 41          &A
           leax   <U0055,U                                              * 02E2 30 C8 55       0HU
           ldy    #81                                                   * 02E5 10 8E 00 51    ...Q
           os9    I$WritLn                                              * 02E9 10 3F 8C       .?.
           lbcs   L02F1                                                 * 02EC 10 25 00 01    .%..
           clrb                                                         * 02F0 5F             _
L02F1      os9    F$Exit                                                * 02F1 10 3F 06       .?.

           emod
eom        equ    *
           end
