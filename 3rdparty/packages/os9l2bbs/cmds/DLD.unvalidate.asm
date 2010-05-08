           nam    DLD.unvalidate
           ttl    program module

           ifp1
           use    defsfile
           endc

tylg       set    Prgrm+Objct
atrv       set    ReEnt+rev
rev        set    $01

           mod    eom,name,tylg,atrv,start,size

U0000      rmb    2
U0002      rmb    2
U0004      rmb    82
U0056      rmb    27
U0071      rmb    31
U0090      rmb    1
U0091      rmb    464
size       equ    .

name       fcs    /DLD.unvalidate/                                            * 000D 44 4C 44 2E 75 6E 76 61 6C 69 64 61 74 E5 DLD.unvalidate
L001B      fcb    $44                                                   * 001B 44             D
           fcb    $4C                                                   * 001C 4C             L
           fcb    $44                                                   * 001D 44             D
           fcb    $2E                                                   * 001E 2E             .
           fcb    $6C                                                   * 001F 6C             l
           fcb    $73                                                   * 0020 73             s
           fcb    $74                                                   * 0021 74             t
           fcb    $0D                                                   * 0022 0D             .
           fcb    $44                                                   * 0023 44             D
           fcb    $4C                                                   * 0024 4C             L
           fcb    $44                                                   * 0025 44             D
           fcb    $2E                                                   * 0026 2E             .
           fcb    $64                                                   * 0027 64             d
           fcb    $73                                                   * 0028 73             s
           fcb    $63                                                   * 0029 63             c
           fcb    $0D                                                   * 002A 0D             .
L002B      fcb    $45                                                   * 002B 45             E
           fcb    $6E                                                   * 002C 6E             n
           fcb    $74                                                   * 002D 74             t
           fcb    $65                                                   * 002E 65             e
           fcb    $72                                                   * 002F 72             r
           fcb    $20                                                   * 0030 20
           fcb    $66                                                   * 0031 66             f
           fcb    $69                                                   * 0032 69             i
           fcb    $6C                                                   * 0033 6C             l
           fcb    $65                                                   * 0034 65             e
           fcb    $6E                                                   * 0035 6E             n
           fcb    $61                                                   * 0036 61             a
           fcb    $6D                                                   * 0037 6D             m
           fcb    $65                                                   * 0038 65             e
           fcb    $20                                                   * 0039 20
           fcb    $74                                                   * 003A 74             t
           fcb    $6F                                                   * 003B 6F             o
           fcb    $20                                                   * 003C 20
           fcb    $75                                                   * 003D 75             u
           fcb    $6E                                                   * 003E 6E             n
           fcb    $76                                                   * 003F 76             v
           fcb    $61                                                   * 0040 61             a
           fcb    $6C                                                   * 0041 6C             l
           fcb    $69                                                   * 0042 69             i
           fcb    $64                                                   * 0043 64             d
           fcb    $61                                                   * 0044 61             a
           fcb    $74                                                   * 0045 74             t
           fcb    $65                                                   * 0046 65             e
           fcb    $3A                                                   * 0047 3A             :
L0048      fcb    $46                                                   * 0048 46             F
           fcb    $69                                                   * 0049 69             i
           fcb    $6C                                                   * 004A 6C             l
           fcb    $65                                                   * 004B 65             e
           fcb    $6E                                                   * 004C 6E             n
           fcb    $61                                                   * 004D 61             a
           fcb    $6D                                                   * 004E 6D             m
           fcb    $65                                                   * 004F 65             e
           fcb    $20                                                   * 0050 20
           fcb    $6E                                                   * 0051 6E             n
           fcb    $6F                                                   * 0052 6F             o
           fcb    $74                                                   * 0053 74             t
           fcb    $20                                                   * 0054 20
           fcb    $66                                                   * 0055 66             f
           fcb    $6F                                                   * 0056 6F             o
           fcb    $75                                                   * 0057 75             u
           fcb    $6E                                                   * 0058 6E             n
           fcb    $64                                                   * 0059 64             d
           fcb    $2E                                                   * 005A 2E             .
           fcb    $0D                                                   * 005B 0D             .
           fcb    $0A                                                   * 005C 0A             .
           fcb    $0D                                                   * 005D 0D             .
           fcb    $4E                                                   * 005E 4E             N
           fcb    $61                                                   * 005F 61             a
           fcb    $6D                                                   * 0060 6D             m
           fcb    $65                                                   * 0061 65             e
           fcb    $3A                                                   * 0062 3A             :
           fcb    $44                                                   * 0063 44             D
           fcb    $65                                                   * 0064 65             e
           fcb    $73                                                   * 0065 73             s
           fcb    $63                                                   * 0066 63             c
           fcb    $3A                                                   * 0067 3A             :
           fcb    $2D                                                   * 0068 2D             -
           fcb    $2D                                                   * 0069 2D             -
           fcb    $2D                                                   * 006A 2D             -
           fcb    $2D                                                   * 006B 2D             -
           fcb    $2D                                                   * 006C 2D             -
           fcb    $2D                                                   * 006D 2D             -
           fcb    $2D                                                   * 006E 2D             -
           fcb    $2D                                                   * 006F 2D             -
           fcb    $2D                                                   * 0070 2D             -
           fcb    $2D                                                   * 0071 2D             -
           fcb    $2D                                                   * 0072 2D             -
           fcb    $2D                                                   * 0073 2D             -
           fcb    $2D                                                   * 0074 2D             -
           fcb    $2D                                                   * 0075 2D             -
           fcb    $2D                                                   * 0076 2D             -
           fcb    $2D                                                   * 0077 2D             -
           fcb    $2D                                                   * 0078 2D             -
           fcb    $2D                                                   * 0079 2D             -
           fcb    $2D                                                   * 007A 2D             -
           fcb    $2D                                                   * 007B 2D             -
           fcb    $2D                                                   * 007C 2D             -
           fcb    $2D                                                   * 007D 2D             -
           fcb    $2D                                                   * 007E 2D             -
           fcb    $2D                                                   * 007F 2D             -
           fcb    $2D                                                   * 0080 2D             -
           fcb    $2D                                                   * 0081 2D             -
           fcb    $2D                                                   * 0082 2D             -
           fcb    $2D                                                   * 0083 2D             -
           fcb    $2D                                                   * 0084 2D             -
           fcb    $2D                                                   * 0085 2D             -
           fcb    $2D                                                   * 0086 2D             -
           fcb    $2D                                                   * 0087 2D             -
           fcb    $2D                                                   * 0088 2D             -
           fcb    $2D                                                   * 0089 2D             -
           fcb    $2D                                                   * 008A 2D             -
           fcb    $2D                                                   * 008B 2D             -
           fcb    $2D                                                   * 008C 2D             -
           fcb    $2D                                                   * 008D 2D             -
           fcb    $2D                                                   * 008E 2D             -
           fcb    $2D                                                   * 008F 2D             -
           fcb    $2D                                                   * 0090 2D             -
           fcb    $2D                                                   * 0091 2D             -
           fcb    $2D                                                   * 0092 2D             -
           fcb    $2D                                                   * 0093 2D             -
           fcb    $2D                                                   * 0094 2D             -
           fcb    $2D                                                   * 0095 2D             -
           fcb    $2D                                                   * 0096 2D             -
           fcb    $2D                                                   * 0097 2D             -
           fcb    $2D                                                   * 0098 2D             -
           fcb    $2D                                                   * 0099 2D             -
           fcb    $2D                                                   * 009A 2D             -
           fcb    $2D                                                   * 009B 2D             -
           fcb    $2D                                                   * 009C 2D             -
           fcb    $2D                                                   * 009D 2D             -
           fcb    $2D                                                   * 009E 2D             -
           fcb    $2D                                                   * 009F 2D             -
           fcb    $2D                                                   * 00A0 2D             -
           fcb    $2D                                                   * 00A1 2D             -
           fcb    $2D                                                   * 00A2 2D             -
           fcb    $2D                                                   * 00A3 2D             -
           fcb    $2D                                                   * 00A4 2D             -
           fcb    $2D                                                   * 00A5 2D             -
           fcb    $0D                                                   * 00A6 0D             .
L00A7      fcb    $46                                                   * 00A7 46             F
           fcb    $69                                                   * 00A8 69             i
           fcb    $6C                                                   * 00A9 6C             l
           fcb    $65                                                   * 00AA 65             e
           fcb    $20                                                   * 00AB 20
           fcb    $75                                                   * 00AC 75             u
           fcb    $6E                                                   * 00AD 6E             n
           fcb    $76                                                   * 00AE 76             v
           fcb    $61                                                   * 00AF 61             a
           fcb    $6C                                                   * 00B0 6C             l
           fcb    $69                                                   * 00B1 69             i
           fcb    $64                                                   * 00B2 64             d
           fcb    $61                                                   * 00B3 61             a
           fcb    $74                                                   * 00B4 74             t
           fcb    $65                                                   * 00B5 65             e
           fcb    $64                                                   * 00B6 64             d
           fcb    $2E                                                   * 00B7 2E             .
           fcb    $0D                                                   * 00B8 0D             .
start      lda    0,X                                                   * 00B9 A6 84          &.
           cmpa   #13                                                   * 00BB 81 0D          ..
           beq    L00C8                                                 * 00BD 27 09          '.
           lda    #1                                                    * 00BF 86 01          ..
           os9    I$ChgDir                                              * 00C1 10 3F 86       .?.
           lbcs   L018A                                                 * 00C4 10 25 00 C2    .%.B
L00C8      leax   L001B,PC                                              * 00C8 30 8D FF 4F    0..O
           lda    #3                                                    * 00CC 86 03          ..
           os9    I$Open                                                * 00CE 10 3F 84       .?.
           lbcs   L018A                                                 * 00D1 10 25 00 B5    .%.5
           sta    U0000,U                                               * 00D5 A7 C4          'D
L00D7      leax   L002B,PC                                              * 00D7 30 8D FF 50    0..P
           ldy    #29                                                   * 00DB 10 8E 00 1D    ....
           lda    #1                                                    * 00DF 86 01          ..
           os9    I$Write                                               * 00E1 10 3F 8A       .?.
           leax   <U0056,U                                              * 00E4 30 C8 56       0HV
           ldy    #27                                                   * 00E7 10 8E 00 1B    ....
           clra                                                         * 00EB 4F             O
           os9    I$ReadLn                                              * 00EC 10 3F 8B       .?.
           lbcs   L00D7                                                 * 00EF 10 25 FF E4    .%.d
           cmpy   #1                                                    * 00F3 10 8C 00 01    ....
           lble   L0189                                                 * 00F7 10 2F 00 8E    ./..
L00FB      lda    0,X                                                   * 00FB A6 84          &.
           anda   #223                                                  * 00FD 84 DF          ._
           sta    ,X+                                                   * 00FF A7 80          '.
           cmpa   #13                                                   * 0101 81 0D          ..
           bne    L00FB                                                 * 0103 26 F6          &v
L0105      lda    U0000,U                                               * 0105 A6 C4          &D
           ldb    #5                                                    * 0107 C6 05          F.
           pshs   U                                                     * 0109 34 40          4@
           os9    I$GetStt                                              * 010B 10 3F 8D       .?.
           lbcs   L018A                                                 * 010E 10 25 00 78    .%.x
           tfr    U,Y                                                   * 0112 1F 32          .2
           puls   U                                                     * 0114 35 40          5@
           stx    U0002,U                                               * 0116 AF 42          /B
           sty    U0004,U                                               * 0118 10 AF 44       ./D
           leax   <U0071,U                                              * 011B 30 C8 71       0Hq
           lda    U0000,U                                               * 011E A6 C4          &D
           ldy    #96                                                   * 0120 10 8E 00 60    ...`
           clrb                                                         * 0124 5F             _
           os9    I$Read                                                * 0125 10 3F 89       .?.
           lbcs   L0145                                                 * 0128 10 25 00 19    .%..
           tst    >U0090,U                                              * 012C 6D C9 00 90    mI..
           beq    L0105                                                 * 0130 27 D3          'S
           leay   <U0056,U                                              * 0132 31 C8 56       1HV
L0135      lda    0,Y                                                   * 0135 A6 A4          &$
           cmpa   #13                                                   * 0137 81 0D          ..
           beq    L015B                                                 * 0139 27 20          '
           lda    ,X+                                                   * 013B A6 80          &.
           anda   #223                                                  * 013D 84 DF          ._
           cmpa   ,Y+                                                   * 013F A1 A0          !
           bne    L0105                                                 * 0141 26 C2          &B
           bra    L0135                                                 * 0143 20 F0           p
L0145      cmpb   #211                                                  * 0145 C1 D3          AS
           lbne   L018A                                                 * 0147 10 26 00 3F    .&.?
           leax   L0048,PC                                              * 014B 30 8D FE F9    0.~y
           ldy    #200                                                  * 014F 10 8E 00 C8    ...H
           lda    #1                                                    * 0153 86 01          ..
           os9    I$WritLn                                              * 0155 10 3F 8C       .?.
           lbra   L0189                                                 * 0158 16 00 2E       ...
L015B      clr    >U0090,U                                              * 015B 6F C9 00 90    oI..
           ldx    U0002,U                                               * 015F AE 42          .B
           lda    U0000,U                                               * 0161 A6 C4          &D
           pshs   U                                                     * 0163 34 40          4@
           ldu    U0004,U                                               * 0165 EE 44          nD
           os9    I$Seek                                                * 0167 10 3F 88       .?.
           lbcs   L018A                                                 * 016A 10 25 00 1C    .%..
           puls   U                                                     * 016E 35 40          5@
           leax   <U0071,U                                              * 0170 30 C8 71       0Hq
           ldy    #96                                                   * 0173 10 8E 00 60    ...`
           lda    U0000,U                                               * 0177 A6 C4          &D
           os9    I$Write                                               * 0179 10 3F 8A       .?.
           leax   L00A7,PC                                              * 017C 30 8D FF 27    0..'
           ldy    #200                                                  * 0180 10 8E 00 C8    ...H
           lda    #1                                                    * 0184 86 01          ..
           os9    I$WritLn                                              * 0186 10 3F 8C       .?.
L0189      clrb                                                         * 0189 5F             _
L018A      os9    F$Exit                                                * 018A 10 3F 06       .?.

           emod
eom        equ    *
           end
