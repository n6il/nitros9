           nam    DLD.search
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
U0006      rmb    2
U0008      rmb    27
U0023      rmb    12
U002F      rmb    2
U0031      rmb    2
U0033      rmb    31
U0052      rmb    1
U0053      rmb    1
U0054      rmb    463
size       equ    .

name       fcs    /DLD.search/                                            * 000D 44 4C 44 2E 73 65 61 72 63 E8 DLD.search
L0017      fcb    $44                                                   * 0017 44             D
           fcb    $4C                                                   * 0018 4C             L
           fcb    $44                                                   * 0019 44             D
           fcb    $2E                                                   * 001A 2E             .
           fcb    $6C                                                   * 001B 6C             l
           fcb    $73                                                   * 001C 73             s
           fcb    $74                                                   * 001D 74             t
           fcb    $0D                                                   * 001E 0D             .
L001F      fcb    $44                                                   * 001F 44             D
           fcb    $4C                                                   * 0020 4C             L
           fcb    $44                                                   * 0021 44             D
           fcb    $2E                                                   * 0022 2E             .
           fcb    $6B                                                   * 0023 6B             k
           fcb    $65                                                   * 0024 65             e
           fcb    $79                                                   * 0025 79             y
           fcb    $0D                                                   * 0026 0D             .
L0027      fcb    $45                                                   * 0027 45             E
           fcb    $6E                                                   * 0028 6E             n
           fcb    $74                                                   * 0029 74             t
           fcb    $65                                                   * 002A 65             e
           fcb    $72                                                   * 002B 72             r
           fcb    $20                                                   * 002C 20
           fcb    $6B                                                   * 002D 6B             k
           fcb    $65                                                   * 002E 65             e
           fcb    $79                                                   * 002F 79             y
           fcb    $77                                                   * 0030 77             w
           fcb    $6F                                                   * 0031 6F             o
           fcb    $72                                                   * 0032 72             r
           fcb    $64                                                   * 0033 64             d
           fcb    $20                                                   * 0034 20
           fcb    $66                                                   * 0035 66             f
           fcb    $6F                                                   * 0036 6F             o
           fcb    $72                                                   * 0037 72             r
           fcb    $20                                                   * 0038 20
           fcb    $73                                                   * 0039 73             s
           fcb    $65                                                   * 003A 65             e
           fcb    $61                                                   * 003B 61             a
           fcb    $72                                                   * 003C 72             r
           fcb    $63                                                   * 003D 63             c
           fcb    $68                                                   * 003E 68             h
           fcb    $3A                                                   * 003F 3A             :
L0040      fcb    $4E                                                   * 0040 4E             N
           fcb    $6F                                                   * 0041 6F             o
           fcb    $20                                                   * 0042 20
           fcb    $66                                                   * 0043 66             f
           fcb    $69                                                   * 0044 69             i
           fcb    $6C                                                   * 0045 6C             l
           fcb    $65                                                   * 0046 65             e
           fcb    $73                                                   * 0047 73             s
           fcb    $20                                                   * 0048 20
           fcb    $66                                                   * 0049 66             f
           fcb    $6F                                                   * 004A 6F             o
           fcb    $75                                                   * 004B 75             u
           fcb    $6E                                                   * 004C 6E             n
           fcb    $64                                                   * 004D 64             d
           fcb    $2E                                                   * 004E 2E             .
           fcb    $0D                                                   * 004F 0D             .
L0050      fcb    $20                                                   * 0050 20
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
           fcb    $20                                                   * 007C 20
           fcb    $20                                                   * 007D 20
           fcb    $20                                                   * 007E 20
           fcb    $20                                                   * 007F 20
           fcb    $20                                                   * 0080 20
           fcb    $20                                                   * 0081 20
           fcb    $20                                                   * 0082 20
           fcb    $20                                                   * 0083 20
           fcb    $20                                                   * 0084 20
           fcb    $20                                                   * 0085 20
           fcb    $20                                                   * 0086 20
           fcb    $20                                                   * 0087 20
           fcb    $20                                                   * 0088 20
           fcb    $20                                                   * 0089 20
           fcb    $20                                                   * 008A 20
           fcb    $20                                                   * 008B 20
           fcb    $20                                                   * 008C 20
           fcb    $20                                                   * 008D 20
           fcb    $20                                                   * 008E 20
           fcb    $20                                                   * 008F 20
           fcb    $20                                                   * 0090 20
           fcb    $20                                                   * 0091 20
           fcb    $20                                                   * 0092 20
           fcb    $20                                                   * 0093 20
           fcb    $20                                                   * 0094 20
           fcb    $20                                                   * 0095 20
           fcb    $20                                                   * 0096 20
           fcb    $20                                                   * 0097 20
           fcb    $20                                                   * 0098 20
           fcb    $20                                                   * 0099 20
           fcb    $20                                                   * 009A 20
           fcb    $20                                                   * 009B 20
           fcb    $20                                                   * 009C 20
           fcb    $20                                                   * 009D 20
           fcb    $20                                                   * 009E 20
           fcb    $0D                                                   * 009F 0D             .
L00A0      fcb    $0A                                                   * 00A0 0A             .
           fcb    $46                                                   * 00A1 46             F
           fcb    $69                                                   * 00A2 69             i
           fcb    $6C                                                   * 00A3 6C             l
           fcb    $65                                                   * 00A4 65             e
           fcb    $20                                                   * 00A5 20
           fcb    $6E                                                   * 00A6 6E             n
           fcb    $61                                                   * 00A7 61             a
           fcb    $6D                                                   * 00A8 6D             m
           fcb    $65                                                   * 00A9 65             e
           fcb    $20                                                   * 00AA 20
           fcb    $20                                                   * 00AB 20
           fcb    $20                                                   * 00AC 20
           fcb    $20                                                   * 00AD 20
           fcb    $20                                                   * 00AE 20
           fcb    $20                                                   * 00AF 20
           fcb    $44                                                   * 00B0 44             D
           fcb    $65                                                   * 00B1 65             e
           fcb    $73                                                   * 00B2 73             s
           fcb    $63                                                   * 00B3 63             c
           fcb    $72                                                   * 00B4 72             r
           fcb    $69                                                   * 00B5 69             i
           fcb    $70                                                   * 00B6 70             p
           fcb    $74                                                   * 00B7 74             t
           fcb    $69                                                   * 00B8 69             i
           fcb    $6F                                                   * 00B9 6F             o
           fcb    $6E                                                   * 00BA 6E             n
           fcb    $0D                                                   * 00BB 0D             .
L00BC      fcb    $2D                                                   * 00BC 2D             -
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
           fcb    $2D                                                   * 00E2 2D             -
           fcb    $2D                                                   * 00E3 2D             -
           fcb    $2D                                                   * 00E4 2D             -
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
           fcb    $0D                                                   * 0106 0D             .
start      clr    U0003,U                                               * 0107 6F 43          oC
           lda    0,X                                                   * 0109 A6 84          &.
           cmpa   #13                                                   * 010B 81 0D          ..
           beq    L0118                                                 * 010D 27 09          '.
           lda    #1                                                    * 010F 86 01          ..
           os9    I$ChgDir                                              * 0111 10 3F 86       .?.
           lbcs   L0244                                                 * 0114 10 25 01 2C    .%.,
L0118      ldd    #-1                                                   * 0118 CC FF FF       L..
           std    U0006,U                                               * 011B ED 46          mF
           std    U0004,U                                               * 011D ED 44          mD
           leax   L0017,PC                                              * 011F 30 8D FE F4    0.~t
           lda    #1                                                    * 0123 86 01          ..
           os9    I$Open                                                * 0125 10 3F 84       .?.
           lbcs   L0244                                                 * 0128 10 25 01 18    .%..
           sta    U0001,U                                               * 012C A7 41          'A
           leax   L001F,PC                                              * 012E 30 8D FE ED    0.~m
           lda    #1                                                    * 0132 86 01          ..
           os9    I$Open                                                * 0134 10 3F 84       .?.
           lbcs   L0244                                                 * 0137 10 25 01 09    .%..
           sta    U0000,U                                               * 013B A7 C4          'D
L013D      leax   L0027,PC                                              * 013D 30 8D FE E6    0.~f
           ldy    #25                                                   * 0141 10 8E 00 19    ....
           lda    #1                                                    * 0145 86 01          ..
           os9    I$Write                                               * 0147 10 3F 8A       .?.
           leax   U0008,U                                               * 014A 30 48          0H
           ldy    #27                                                   * 014C 10 8E 00 1B    ....
           clra                                                         * 0150 4F             O
           os9    I$ReadLn                                              * 0151 10 3F 8B       .?.
           lbcs   L013D                                                 * 0154 10 25 FF E5    .%.e
L0158      leax   <U0023,U                                              * 0158 30 C8 23       0H#
           ldy    #16                                                   * 015B 10 8E 00 10    ....
           lda    U0000,U                                               * 015F A6 C4          &D
           os9    I$Read                                                * 0161 10 3F 89       .?.
           lbcs   L0198                                                 * 0164 10 25 00 30    .%.0
           ldd    <U002F,U                                              * 0168 EC C8 2F       lH/
           cmpd   U0004,U                                               * 016B 10 A3 44       .#D
           bne    L017A                                                 * 016E 26 0A          &.
           ldd    <U0031,U                                              * 0170 EC C8 31       lH1
           cmpd   U0006,U                                               * 0173 10 A3 46       .#F
           bne    L017A                                                 * 0176 26 02          &.
           bra    L0158                                                 * 0178 20 DE           ^
L017A      pshs   X                                                     * 017A 34 10          4.
L017C      lda    0,X                                                   * 017C A6 84          &.
           anda   #223                                                  * 017E 84 DF          ._
           sta    ,X+                                                   * 0180 A7 80          '.
           cmpa   #13                                                   * 0182 81 0D          ..
           bne    L017C                                                 * 0184 26 F6          &v
           puls   X                                                     * 0186 35 10          5.
           leay   U0008,U                                               * 0188 31 48          1H
L018A      lda    ,Y+                                                   * 018A A6 A0          &
           cmpa   #13                                                   * 018C 81 0D          ..
           beq    L01B4                                                 * 018E 27 24          '$
           anda   #223                                                  * 0190 84 DF          ._
           cmpa   ,X+                                                   * 0192 A1 80          !.
           bne    L0158                                                 * 0194 26 C2          &B
           bra    L018A                                                 * 0196 20 F2           r
L0198      cmpb   #211                                                  * 0198 C1 D3          AS
           lbne   L0244                                                 * 019A 10 26 00 A6    .&.&
           tst    U0003,U                                               * 019E 6D 43          mC
           lbne   L0243                                                 * 01A0 10 26 00 9F    .&..
           leax   L0040,PC                                              * 01A4 30 8D FE 98    0.~.
           ldy    #200                                                  * 01A8 10 8E 00 C8    ...H
           lda    #1                                                    * 01AC 86 01          ..
           os9    I$WritLn                                              * 01AE 10 3F 8C       .?.
           lbra   L0243                                                 * 01B1 16 00 8F       ...
L01B4      pshs   U                                                     * 01B4 34 40          4@
           lda    U0001,U                                               * 01B6 A6 41          &A
           ldx    <U002F,U                                              * 01B8 AE C8 2F       .H/
           ldu    <U0031,U                                              * 01BB EE C8 31       nH1
           os9    I$Seek                                                * 01BE 10 3F 88       .?.
           lbcs   L0244                                                 * 01C1 10 25 00 7F    .%..
           puls   U                                                     * 01C5 35 40          5@
           leax   <U0033,U                                              * 01C7 30 C8 33       0H3
           ldy    #96                                                   * 01CA 10 8E 00 60    ...`
           lda    U0001,U                                               * 01CE A6 41          &A
           os9    I$Read                                                * 01D0 10 3F 89       .?.
           lbcs   L0244                                                 * 01D3 10 25 00 6D    .%.m
           tst    <U0052,U                                              * 01D7 6D C8 52       mHR
           lbeq   L0158                                                 * 01DA 10 27 FF 7A    .'.z
           tst    U0003,U                                               * 01DE 6D 43          mC
           bne    L01FE                                                 * 01E0 26 1C          &.
           leax   L00A0,PC                                              * 01E2 30 8D FE BA    0.~:
           ldy    #200                                                  * 01E6 10 8E 00 C8    ...H
           lda    #1                                                    * 01EA 86 01          ..
           os9    I$WritLn                                              * 01EC 10 3F 8C       .?.
           leax   L00BC,PC                                              * 01EF 30 8D FE C9    0.~I
           ldy    #200                                                  * 01F3 10 8E 00 C8    ...H
           os9    I$WritLn                                              * 01F7 10 3F 8C       .?.
           lda    #255                                                  * 01FA 86 FF          ..
           sta    U0003,U                                               * 01FC A7 43          'C
L01FE      clrb                                                         * 01FE 5F             _
           leax   <U0033,U                                              * 01FF 30 C8 33       0H3
L0202      lda    ,X+                                                   * 0202 A6 80          &.
           cmpa   #13                                                   * 0204 81 0D          ..
           beq    L020B                                                 * 0206 27 03          '.
           incb                                                         * 0208 5C             \
           bra    L0202                                                 * 0209 20 F7           w
L020B      stb    U0002,U                                               * 020B E7 42          gB
           clra                                                         * 020D 4F             O
           tfr    D,Y                                                   * 020E 1F 02          ..
           leax   <U0033,U                                              * 0210 30 C8 33       0H3
           lda    #1                                                    * 0213 86 01          ..
           os9    I$Write                                               * 0215 10 3F 8A       .?.
           ldb    #15                                                   * 0218 C6 0F          F.
           subb   U0002,U                                               * 021A E0 42          `B
           blt    L022A                                                 * 021C 2D 0C          -.
           clra                                                         * 021E 4F             O
           tfr    D,Y                                                   * 021F 1F 02          ..
           lda    #1                                                    * 0221 86 01          ..
           leax   L0050,PC                                              * 0223 30 8D FE 29    0.~)
           os9    I$Write                                               * 0227 10 3F 8A       .?.
L022A      leax   <U0053,U                                              * 022A 30 C8 53       0HS
           ldy    #65                                                   * 022D 10 8E 00 41    ...A
           lda    #1                                                    * 0231 86 01          ..
           os9    I$WritLn                                              * 0233 10 3F 8C       .?.
           ldd    <U002F,U                                              * 0236 EC C8 2F       lH/
           std    U0004,U                                               * 0239 ED 44          mD
           ldd    <U0031,U                                              * 023B EC C8 31       lH1
           std    U0006,U                                               * 023E ED 46          mF
           lbra   L0158                                                 * 0240 16 FF 15       ...
L0243      clrb                                                         * 0243 5F             _
L0244      os9    F$Exit                                                * 0244 10 3F 06       .?.

           emod
eom        equ    *
           end
