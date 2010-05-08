           nam    DLD.list
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
U0003      rmb    31
U0022      rmb    1
U0023      rmb    1
U0024      rmb    463
size       equ    .

name       fcs    /DLD.list/                                            * 000D 44 4C 44 2E 6C 69 73 F4 DLD.list
L0015      fcb    $44                                                   * 0015 44             D
           fcb    $4C                                                   * 0016 4C             L
           fcb    $44                                                   * 0017 44             D
           fcb    $2E                                                   * 0018 2E             .
           fcb    $6C                                                   * 0019 6C             l
           fcb    $73                                                   * 001A 73             s
           fcb    $74                                                   * 001B 74             t
           fcb    $0D                                                   * 001C 0D             .
L001D      fcb    $4E                                                   * 001D 4E             N
           fcb    $6F                                                   * 001E 6F             o
           fcb    $20                                                   * 001F 20
           fcb    $66                                                   * 0020 66             f
           fcb    $69                                                   * 0021 69             i
           fcb    $6C                                                   * 0022 6C             l
           fcb    $65                                                   * 0023 65             e
           fcb    $73                                                   * 0024 73             s
           fcb    $20                                                   * 0025 20
           fcb    $66                                                   * 0026 66             f
           fcb    $6F                                                   * 0027 6F             o
           fcb    $75                                                   * 0028 75             u
           fcb    $6E                                                   * 0029 6E             n
           fcb    $64                                                   * 002A 64             d
           fcb    $2E                                                   * 002B 2E             .
           fcb    $0D                                                   * 002C 0D             .
L002D      fcb    $20                                                   * 002D 20
           fcb    $20                                                   * 002E 20
           fcb    $20                                                   * 002F 20
           fcb    $20                                                   * 0030 20
           fcb    $20                                                   * 0031 20
           fcb    $20                                                   * 0032 20
           fcb    $20                                                   * 0033 20
           fcb    $20                                                   * 0034 20
           fcb    $20                                                   * 0035 20
           fcb    $20                                                   * 0036 20
           fcb    $20                                                   * 0037 20
           fcb    $20                                                   * 0038 20
           fcb    $20                                                   * 0039 20
           fcb    $20                                                   * 003A 20
           fcb    $20                                                   * 003B 20
           fcb    $20                                                   * 003C 20
           fcb    $20                                                   * 003D 20
           fcb    $20                                                   * 003E 20
           fcb    $20                                                   * 003F 20
           fcb    $20                                                   * 0040 20
           fcb    $20                                                   * 0041 20
           fcb    $20                                                   * 0042 20
           fcb    $20                                                   * 0043 20
           fcb    $20                                                   * 0044 20
           fcb    $20                                                   * 0045 20
           fcb    $20                                                   * 0046 20
           fcb    $20                                                   * 0047 20
           fcb    $20                                                   * 0048 20
           fcb    $20                                                   * 0049 20
           fcb    $20                                                   * 004A 20
           fcb    $20                                                   * 004B 20
           fcb    $20                                                   * 004C 20
           fcb    $20                                                   * 004D 20
           fcb    $20                                                   * 004E 20
           fcb    $20                                                   * 004F 20
           fcb    $20                                                   * 0050 20
           fcb    $20                                                   * 0051 20
           fcb    $20                                                   * 0052 20
           fcb    $20                                                   * 0053 20
           fcb    $20                                                   * 0054 20
           fcb    $20                                                   * 0055 20
           fcb    $20                                                   * 0056 20
           fcb    $20                                                   * 0057 20
           fcb    $20                                                   * 0058 20
           fcb    $20                                                   * 0059 20
           fcb    $20                                                   * 005A 20
           fcb    $20                                                   * 005B 20
           fcb    $20                                                   * 005C 20
           fcb    $20                                                   * 005D 20
           fcb    $20                                                   * 005E 20
           fcb    $20                                                   * 005F 20
           fcb    $20                                                   * 0060 20
           fcb    $20                                                   * 0061 20
           fcb    $20                                                   * 0062 20
           fcb    $20                                                   * 0063 20
           fcb    $20                                                   * 0064 20
           fcb    $20                                                   * 0065 20
           fcb    $20                                                   * 0066 20
           fcb    $20                                                   * 0067 20
           fcb    $20                                                   * 0068 20
           fcb    $20                                                   * 0069 20
           fcb    $20                                                   * 006A 20
           fcb    $20                                                   * 006B 20
           fcb    $20                                                   * 006C 20
           fcb    $20                                                   * 006D 20
           fcb    $20                                                   * 006E 20
           fcb    $20                                                   * 006F 20
           fcb    $20                                                   * 0070 20
           fcb    $20                                                   * 0071 20
           fcb    $20                                                   * 0072 20
           fcb    $20                                                   * 0073 20
           fcb    $20                                                   * 0074 20
           fcb    $20                                                   * 0075 20
           fcb    $20                                                   * 0076 20
           fcb    $20                                                   * 0077 20
           fcb    $20                                                   * 0078 20
           fcb    $20                                                   * 0079 20
           fcb    $20                                                   * 007A 20
           fcb    $20                                                   * 007B 20
           fcb    $0D                                                   * 007C 0D             .
L007D      fcb    $46                                                   * 007D 46             F
           fcb    $69                                                   * 007E 69             i
           fcb    $6C                                                   * 007F 6C             l
           fcb    $65                                                   * 0080 65             e
           fcb    $20                                                   * 0081 20
           fcb    $6E                                                   * 0082 6E             n
           fcb    $61                                                   * 0083 61             a
           fcb    $6D                                                   * 0084 6D             m
           fcb    $65                                                   * 0085 65             e
           fcb    $20                                                   * 0086 20
           fcb    $20                                                   * 0087 20
           fcb    $20                                                   * 0088 20
           fcb    $20                                                   * 0089 20
           fcb    $20                                                   * 008A 20
           fcb    $20                                                   * 008B 20
           fcb    $44                                                   * 008C 44             D
           fcb    $65                                                   * 008D 65             e
           fcb    $73                                                   * 008E 73             s
           fcb    $63                                                   * 008F 63             c
           fcb    $72                                                   * 0090 72             r
           fcb    $69                                                   * 0091 69             i
           fcb    $70                                                   * 0092 70             p
           fcb    $74                                                   * 0093 74             t
           fcb    $69                                                   * 0094 69             i
           fcb    $6F                                                   * 0095 6F             o
           fcb    $6E                                                   * 0096 6E             n
           fcb    $0D                                                   * 0097 0D             .
L0098      fcb    $2D                                                   * 0098 2D             -
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
           fcb    $2D                                                   * 00A6 2D             -
           fcb    $2D                                                   * 00A7 2D             -
           fcb    $2D                                                   * 00A8 2D             -
           fcb    $2D                                                   * 00A9 2D             -
           fcb    $2D                                                   * 00AA 2D             -
           fcb    $2D                                                   * 00AB 2D             -
           fcb    $2D                                                   * 00AC 2D             -
           fcb    $2D                                                   * 00AD 2D             -
           fcb    $2D                                                   * 00AE 2D             -
           fcb    $2D                                                   * 00AF 2D             -
           fcb    $2D                                                   * 00B0 2D             -
           fcb    $2D                                                   * 00B1 2D             -
           fcb    $2D                                                   * 00B2 2D             -
           fcb    $2D                                                   * 00B3 2D             -
           fcb    $2D                                                   * 00B4 2D             -
           fcb    $2D                                                   * 00B5 2D             -
           fcb    $2D                                                   * 00B6 2D             -
           fcb    $2D                                                   * 00B7 2D             -
           fcb    $2D                                                   * 00B8 2D             -
           fcb    $2D                                                   * 00B9 2D             -
           fcb    $2D                                                   * 00BA 2D             -
           fcb    $2D                                                   * 00BB 2D             -
           fcb    $2D                                                   * 00BC 2D             -
           fcb    $2D                                                   * 00BD 2D             -
           fcb    $2D                                                   * 00BE 2D             -
           fcb    $2D                                                   * 00BF 2D             -
           fcb    $2D                                                   * 00C0 2D             -
           fcb    $2D                                                   * 00C1 2D             -
           fcb    $2D                                                   * 00C2 2D             -
           fcb    $2D                                                   * 00C3 2D             -
           fcb    $2D                                                   * 00C4 2D             -
           fcb    $2D                                                   * 00C5 2D             -
           fcb    $2D                                                   * 00C6 2D             -
           fcb    $2D                                                   * 00C7 2D             -
           fcb    $2D                                                   * 00C8 2D             -
           fcb    $2D                                                   * 00C9 2D             -
           fcb    $2D                                                   * 00CA 2D             -
           fcb    $2D                                                   * 00CB 2D             -
           fcb    $2D                                                   * 00CC 2D             -
           fcb    $2D                                                   * 00CD 2D             -
           fcb    $2D                                                   * 00CE 2D             -
           fcb    $2D                                                   * 00CF 2D             -
           fcb    $2D                                                   * 00D0 2D             -
           fcb    $2D                                                   * 00D1 2D             -
           fcb    $2D                                                   * 00D2 2D             -
           fcb    $2D                                                   * 00D3 2D             -
           fcb    $2D                                                   * 00D4 2D             -
           fcb    $2D                                                   * 00D5 2D             -
           fcb    $2D                                                   * 00D6 2D             -
           fcb    $2D                                                   * 00D7 2D             -
           fcb    $2D                                                   * 00D8 2D             -
           fcb    $2D                                                   * 00D9 2D             -
           fcb    $2D                                                   * 00DA 2D             -
           fcb    $2D                                                   * 00DB 2D             -
           fcb    $2D                                                   * 00DC 2D             -
           fcb    $2D                                                   * 00DD 2D             -
           fcb    $2D                                                   * 00DE 2D             -
           fcb    $2D                                                   * 00DF 2D             -
           fcb    $2D                                                   * 00E0 2D             -
           fcb    $2D                                                   * 00E1 2D             -
           fcb    $0D                                                   * 00E2 0D             .
start      clr    U0002,U                                               * 00E3 6F 42          oB
           lda    0,X                                                   * 00E5 A6 84          &.
           cmpa   #13                                                   * 00E7 81 0D          ..
           beq    L00F4                                                 * 00E9 27 09          '.
           lda    #1                                                    * 00EB 86 01          ..
           os9    I$ChgDir                                              * 00ED 10 3F 86       .?.
           lbcs   L0192                                                 * 00F0 10 25 00 9E    .%..
L00F4      leax   L0015,PC                                              * 00F4 30 8D FF 1D    0...
           lda    #1                                                    * 00F8 86 01          ..
           os9    I$Open                                                * 00FA 10 3F 84       .?.
           lbcs   L0192                                                 * 00FD 10 25 00 91    .%..
           sta    U0000,U                                               * 0101 A7 C4          'D
L0103      clra                                                         * 0103 4F             O
           ldb    #1                                                    * 0104 C6 01          F.
           os9    I$GetStt                                              * 0106 10 3F 8D       .?.
           lbcc   L0191                                                 * 0109 10 24 00 84    .$..
           lda    U0000,U                                               * 010D A6 C4          &D
           leax   U0003,U                                               * 010F 30 43          0C
           ldy    #96                                                   * 0111 10 8E 00 60    ...`
           os9    I$Read                                                * 0115 10 3F 89       .?.
           lbcs   L017C                                                 * 0118 10 25 00 60    .%.`
           lda    <U0022,U                                              * 011C A6 C8 22       &H"
           cmpa   #255                                                  * 011F 81 FF          ..
           bne    L0103                                                 * 0121 26 E0          &`
           tst    U0002,U                                               * 0123 6D 42          mB
           bne    L0143                                                 * 0125 26 1C          &.
           leax   L007D,PC                                              * 0127 30 8D FF 52    0..R
           ldy    #200                                                  * 012B 10 8E 00 C8    ...H
           lda    #1                                                    * 012F 86 01          ..
           os9    I$WritLn                                              * 0131 10 3F 8C       .?.
           leax   L0098,PC                                              * 0134 30 8D FF 60    0..`
           ldy    #200                                                  * 0138 10 8E 00 C8    ...H
           os9    I$WritLn                                              * 013C 10 3F 8C       .?.
           lda    #255                                                  * 013F 86 FF          ..
           sta    U0002,U                                               * 0141 A7 42          'B
L0143      clrb                                                         * 0143 5F             _
           leax   U0003,U                                               * 0144 30 43          0C
L0146      lda    ,X+                                                   * 0146 A6 80          &.
           cmpa   #13                                                   * 0148 81 0D          ..
           beq    L014F                                                 * 014A 27 03          '.
           incb                                                         * 014C 5C             \
           bra    L0146                                                 * 014D 20 F7           w
L014F      stb    U0001,U                                               * 014F E7 41          gA
           clra                                                         * 0151 4F             O
           tfr    D,Y                                                   * 0152 1F 02          ..
           leax   U0003,U                                               * 0154 30 43          0C
           lda    #1                                                    * 0156 86 01          ..
           os9    I$Write                                               * 0158 10 3F 8A       .?.
           ldb    #15                                                   * 015B C6 0F          F.
           subb   U0001,U                                               * 015D E0 41          `A
           blt    L016D                                                 * 015F 2D 0C          -.
           clra                                                         * 0161 4F             O
           tfr    D,Y                                                   * 0162 1F 02          ..
           lda    #1                                                    * 0164 86 01          ..
           leax   L002D,PC                                              * 0166 30 8D FE C3    0.~C
           os9    I$Write                                               * 016A 10 3F 8A       .?.
L016D      leax   <U0023,U                                              * 016D 30 C8 23       0H#
           ldy    #65                                                   * 0170 10 8E 00 41    ...A
           lda    #1                                                    * 0174 86 01          ..
           os9    I$WritLn                                              * 0176 10 3F 8C       .?.
           lbra   L0103                                                 * 0179 16 FF 87       ...
L017C      cmpb   #211                                                  * 017C C1 D3          AS
           bne    L0192                                                 * 017E 26 12          &.
           tst    U0002,U                                               * 0180 6D 42          mB
           bne    L0191                                                 * 0182 26 0D          &.
           leax   L001D,PC                                              * 0184 30 8D FE 95    0.~.
           ldy    #200                                                  * 0188 10 8E 00 C8    ...H
           lda    #1                                                    * 018C 86 01          ..
           os9    I$WritLn                                              * 018E 10 3F 8C       .?.
L0191      clrb                                                         * 0191 5F             _
L0192      os9    F$Exit                                                * 0192 10 3F 06       .?.

           emod
eom        equ    *
           end
