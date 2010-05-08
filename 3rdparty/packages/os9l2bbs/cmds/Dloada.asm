           nam    Dloada
           ttl    program module

           ifp1
           use    defsfile
           endc

tylg       set    Prgrm+Objct
atrv       set    ReEnt+rev
rev        set    $01

           mod    eom,name,tylg,atrv,start,size

U0000      rmb    1
U0001      rmb    32
U0021      rmb    1
U0022      rmb    599
size       equ    .

name       fcs    /Dloada/                                              * 000D 44 6C 6F 61 64 E1 Dloada
L0013      fcb    $45                                                   * 0013 45             E
           fcb    $6E                                                   * 0014 6E             n
           fcb    $74                                                   * 0015 74             t
           fcb    $65                                                   * 0016 65             e
           fcb    $72                                                   * 0017 72             r
           fcb    $20                                                   * 0018 20
           fcb    $66                                                   * 0019 66             f
           fcb    $69                                                   * 001A 69             i
           fcb    $6C                                                   * 001B 6C             l
           fcb    $65                                                   * 001C 65             e
           fcb    $6E                                                   * 001D 6E             n
           fcb    $61                                                   * 001E 61             a
           fcb    $6D                                                   * 001F 6D             m
           fcb    $65                                                   * 0020 65             e
           fcb    $20                                                   * 0021 20
           fcb    $74                                                   * 0022 74             t
           fcb    $6F                                                   * 0023 6F             o
           fcb    $20                                                   * 0024 20
           fcb    $44                                                   * 0025 44             D
           fcb    $6F                                                   * 0026 6F             o
           fcb    $77                                                   * 0027 77             w
           fcb    $6E                                                   * 0028 6E             n
           fcb    $6C                                                   * 0029 6C             l
           fcb    $6F                                                   * 002A 6F             o
           fcb    $61                                                   * 002B 61             a
           fcb    $64                                                   * 002C 64             d
           fcb    $2D                                                   * 002D 2D             -
           fcb    $2D                                                   * 002E 2D             -
           fcb    $3E                                                   * 002F 3E             >
L0030      fcb    $50                                                   * 0030 50             P
           fcb    $72                                                   * 0031 72             r
           fcb    $65                                                   * 0032 65             e
           fcb    $73                                                   * 0033 73             s
           fcb    $73                                                   * 0034 73             s
           fcb    $20                                                   * 0035 20
           fcb    $3C                                                   * 0036 3C             <
           fcb    $53                                                   * 0037 53             S
           fcb    $50                                                   * 0038 50             P
           fcb    $41                                                   * 0039 41             A
           fcb    $43                                                   * 003A 43             C
           fcb    $45                                                   * 003B 45             E
           fcb    $3E                                                   * 003C 3E             >
           fcb    $20                                                   * 003D 20
           fcb    $74                                                   * 003E 74             t
           fcb    $6F                                                   * 003F 6F             o
           fcb    $20                                                   * 0040 20
           fcb    $61                                                   * 0041 61             a
           fcb    $62                                                   * 0042 62             b
           fcb    $6F                                                   * 0043 6F             o
           fcb    $72                                                   * 0044 72             r
           fcb    $74                                                   * 0045 74             t
           fcb    $0D                                                   * 0046 0D             .
L0047      fcb    $50                                                   * 0047 50             P
           fcb    $72                                                   * 0048 72             r
           fcb    $65                                                   * 0049 65             e
           fcb    $73                                                   * 004A 73             s
           fcb    $73                                                   * 004B 73             s
           fcb    $20                                                   * 004C 20
           fcb    $3C                                                   * 004D 3C             <
           fcb    $45                                                   * 004E 45             E
           fcb    $4E                                                   * 004F 4E             N
           fcb    $54                                                   * 0050 54             T
           fcb    $45                                                   * 0051 45             E
           fcb    $52                                                   * 0052 52             R
           fcb    $3E                                                   * 0053 3E             >
           fcb    $20                                                   * 0054 20
           fcb    $74                                                   * 0055 74             t
           fcb    $6F                                                   * 0056 6F             o
           fcb    $20                                                   * 0057 20
           fcb    $62                                                   * 0058 62             b
           fcb    $65                                                   * 0059 65             e
           fcb    $67                                                   * 005A 67             g
           fcb    $69                                                   * 005B 69             i
           fcb    $6E                                                   * 005C 6E             n
           fcb    $0D                                                   * 005D 0D             .
L005E      fcb    $18                                                   * 005E 18             .
L005F      fcb    $20                                                   * 005F 20
start      lda    #1                                                    * 0060 86 01          ..
           os9    I$Open                                                * 0062 10 3F 84       .?.
           bcs    L0069                                                 * 0065 25 02          %.
           bra    L008B                                                 * 0067 20 22           "
L0069      leax   L0013,PC                                              * 0069 30 8D FF A6    0..&
           ldy    #29                                                   * 006D 10 8E 00 1D    ....
           lda    #1                                                    * 0071 86 01          ..
           os9    I$Write                                               * 0073 10 3F 8A       .?.
           leax   U0001,U                                               * 0076 30 41          0A
           ldy    #32                                                   * 0078 10 8E 00 20    ...
           clra                                                         * 007C 4F             O
           os9    I$ReadLn                                              * 007D 10 3F 8B       .?.
           leax   U0001,U                                               * 0080 30 41          0A
           lda    #1                                                    * 0082 86 01          ..
           os9    I$Open                                                * 0084 10 3F 84       .?.
           lbcs   L00F4                                                 * 0087 10 25 00 69    .%.i
L008B      sta    U0000,U                                               * 008B A7 C4          'D
           leax   L0030,PC                                              * 008D 30 8D FF 9F    0...
           ldy    #200                                                  * 0091 10 8E 00 C8    ...H
           lda    #1                                                    * 0095 86 01          ..
           os9    I$WritLn                                              * 0097 10 3F 8C       .?.
           leax   L0047,PC                                              * 009A 30 8D FF A9    0..)
           ldy    #200                                                  * 009E 10 8E 00 C8    ...H
           os9    I$WritLn                                              * 00A2 10 3F 8C       .?.
L00A5      leax   <U0021,U                                              * 00A5 30 C8 21       0H!
           ldy    #1                                                    * 00A8 10 8E 00 01    ....
           clra                                                         * 00AC 4F             O
           os9    I$Read                                                * 00AD 10 3F 89       .?.
           lda    <U0021,U                                              * 00B0 A6 C8 21       &H!
           cmpa   #32                                                   * 00B3 81 20          .
           lbeq   L00F3                                                 * 00B5 10 27 00 3A    .'.:
           cmpa   #13                                                   * 00B9 81 0D          ..
           bne    L00A5                                                 * 00BB 26 E8          &h
           leax   L005E,PC                                              * 00BD 30 8D FF 9D    0...
           ldy    #1                                                    * 00C1 10 8E 00 01    ....
           os9    I$Write                                               * 00C5 10 3F 8A       .?.
L00C8      lda    U0000,U                                               * 00C8 A6 C4          &D
           leax   <U0021,U                                              * 00CA 30 C8 21       0H!
           ldy    #200                                                  * 00CD 10 8E 00 C8    ...H
           os9    I$ReadLn                                              * 00D1 10 3F 8B       .?.
           bcs    L00F3                                                 * 00D4 25 1D          %.
           lda    #1                                                    * 00D6 86 01          ..
           os9    I$WritLn                                              * 00D8 10 3F 8C       .?.
           clra                                                         * 00DB 4F             O
           ldb    #1                                                    * 00DC C6 01          F.
           os9    I$GetStt                                              * 00DE 10 3F 8D       .?.
           bcs    L00C8                                                 * 00E1 25 E5          %e
           ldy    #1                                                    * 00E3 10 8E 00 01    ....
           leax   <U0021,U                                              * 00E7 30 C8 21       0H!
           os9    I$Read                                                * 00EA 10 3F 89       .?.
           lda    0,X                                                   * 00ED A6 84          &.
           cmpa   #32                                                   * 00EF 81 20          .
           bne    L00C8                                                 * 00F1 26 D5          &U
L00F3      clrb                                                         * 00F3 5F             _
L00F4      pshs   B                                                     * 00F4 34 04          4.
           leax   L005F,PC                                              * 00F6 30 8D FF 65    0..e
           ldy    #1                                                    * 00FA 10 8E 00 01    ....
           lda    #1                                                    * 00FE 86 01          ..
           os9    I$Write                                               * 0100 10 3F 8A       .?.
           puls   B                                                     * 0103 35 04          5.
           os9    F$Exit                                                * 0105 10 3F 06       .?.

           emod
eom        equ    *
           end
