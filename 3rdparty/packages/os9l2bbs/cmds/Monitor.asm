           nam    Monitor
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
U0008      rmb    32
U0028      rmb    255
U0127      rmb    1
U0128      rmb    1
U0129      rmb    711
size       equ    .

name       fcs    /Monitor/                                             * 000D 4D 6F 6E 69 74 6F F2 Monitor
           fcb    $43                                                   * 0014 43             C
           fcb    $6F                                                   * 0015 6F             o
           fcb    $70                                                   * 0016 70             p
           fcb    $79                                                   * 0017 79             y
           fcb    $72                                                   * 0018 72             r
           fcb    $69                                                   * 0019 69             i
           fcb    $67                                                   * 001A 67             g
           fcb    $68                                                   * 001B 68             h
           fcb    $74                                                   * 001C 74             t
           fcb    $20                                                   * 001D 20
           fcb    $28                                                   * 001E 28             (
           fcb    $43                                                   * 001F 43             C
           fcb    $29                                                   * 0020 29             )
           fcb    $20                                                   * 0021 20
           fcb    $31                                                   * 0022 31             1
           fcb    $39                                                   * 0023 39             9
           fcb    $38                                                   * 0024 38             8
           fcb    $38                                                   * 0025 38             8
           fcb    $42                                                   * 0026 42             B
           fcb    $79                                                   * 0027 79             y
           fcb    $20                                                   * 0028 20
           fcb    $4B                                                   * 0029 4B             K
           fcb    $65                                                   * 002A 65             e
           fcb    $69                                                   * 002B 69             i
           fcb    $74                                                   * 002C 74             t
           fcb    $68                                                   * 002D 68             h
           fcb    $20                                                   * 002E 20
           fcb    $41                                                   * 002F 41             A
           fcb    $6C                                                   * 0030 6C             l
           fcb    $70                                                   * 0031 70             p
           fcb    $68                                                   * 0032 68             h
           fcb    $6F                                                   * 0033 6F             o
           fcb    $6E                                                   * 0034 6E             n
           fcb    $73                                                   * 0035 73             s
           fcb    $6F                                                   * 0036 6F             o
           fcb    $4C                                                   * 0037 4C             L
           fcb    $69                                                   * 0038 69             i
           fcb    $63                                                   * 0039 63             c
           fcb    $65                                                   * 003A 65             e
           fcb    $6E                                                   * 003B 6E             n
           fcb    $63                                                   * 003C 63             c
           fcb    $65                                                   * 003D 65             e
           fcb    $64                                                   * 003E 64             d
           fcb    $20                                                   * 003F 20
           fcb    $74                                                   * 0040 74             t
           fcb    $6F                                                   * 0041 6F             o
           fcb    $20                                                   * 0042 20
           fcb    $41                                                   * 0043 41             A
           fcb    $6C                                                   * 0044 6C             l
           fcb    $70                                                   * 0045 70             p
           fcb    $68                                                   * 0046 68             h
           fcb    $61                                                   * 0047 61             a
           fcb    $20                                                   * 0048 20
           fcb    $53                                                   * 0049 53             S
           fcb    $6F                                                   * 004A 6F             o
           fcb    $66                                                   * 004B 66             f
           fcb    $74                                                   * 004C 74             t
           fcb    $77                                                   * 004D 77             w
           fcb    $61                                                   * 004E 61             a
           fcb    $72                                                   * 004F 72             r
           fcb    $65                                                   * 0050 65             e
           fcb    $20                                                   * 0051 20
           fcb    $54                                                   * 0052 54             T
           fcb    $65                                                   * 0053 65             e
           fcb    $63                                                   * 0054 63             c
           fcb    $68                                                   * 0055 68             h
           fcb    $6E                                                   * 0056 6E             n
           fcb    $6F                                                   * 0057 6F             o
           fcb    $6C                                                   * 0058 6C             l
           fcb    $6F                                                   * 0059 6F             o
           fcb    $67                                                   * 005A 67             g
           fcb    $69                                                   * 005B 69             i
           fcb    $65                                                   * 005C 65             e
           fcb    $73                                                   * 005D 73             s
           fcb    $41                                                   * 005E 41             A
           fcb    $6C                                                   * 005F 6C             l
           fcb    $6C                                                   * 0060 6C             l
           fcb    $20                                                   * 0061 20
           fcb    $72                                                   * 0062 72             r
           fcb    $69                                                   * 0063 69             i
           fcb    $67                                                   * 0064 67             g
           fcb    $68                                                   * 0065 68             h
           fcb    $74                                                   * 0066 74             t
           fcb    $73                                                   * 0067 73             s
           fcb    $20                                                   * 0068 20
           fcb    $72                                                   * 0069 72             r
           fcb    $65                                                   * 006A 65             e
           fcb    $73                                                   * 006B 73             s
           fcb    $65                                                   * 006C 65             e
           fcb    $72                                                   * 006D 72             r
           fcb    $76                                                   * 006E 76             v
           fcb    $65                                                   * 006F 65             e
           fcb    $64                                                   * 0070 64             d
           fcb    $EC                                                   * 0071 EC             l
           fcb    $E6                                                   * 0072 E6             f
           fcb    $EA                                                   * 0073 EA             j
           fcb    $F5                                                   * 0074 F5             u
           fcb    $E9                                                   * 0075 E9             i
           fcb    $A0                                                   * 0076 A0
           fcb    $E2                                                   * 0077 E2             b
           fcb    $ED                                                   * 0078 ED             m
           fcb    $F1                                                   * 0079 F1             q
           fcb    $E9                                                   * 007A E9             i
           fcb    $F0                                                   * 007B F0             p
           fcb    $EF                                                   * 007C EF             o
           fcb    $F4                                                   * 007D F4             t
           fcb    $F0                                                   * 007E F0             p
start      lda    0,X                                                   * 007F A6 84          &.
           cmpa   #13                                                   * 0081 81 0D          ..
           beq    L00A0                                                 * 0083 27 1B          '.
           clra                                                         * 0085 4F             O
           os9    I$Close                                               * 0086 10 3F 8F       .?.
           inca                                                         * 0089 4C             L
           os9    I$Close                                               * 008A 10 3F 8F       .?.
           inca                                                         * 008D 4C             L
           os9    I$Close                                               * 008E 10 3F 8F       .?.
           lda    #3                                                    * 0091 86 03          ..
           os9    I$Open                                                * 0093 10 3F 84       .?.
           lbcs   L0106                                                 * 0096 10 25 00 6C    .%.l
           os9    I$Dup                                                 * 009A 10 3F 82       .?.
           os9    I$Dup                                                 * 009D 10 3F 82       .?.
L00A0      clra                                                         * 00A0 4F             O
           ldb    #14                                                   * 00A1 C6 0E          F.
           leax   U0008,U                                               * 00A3 30 48          0H
           os9    I$GetStt                                              * 00A5 10 3F 8D       .?.
           lbcs   L0106                                                 * 00A8 10 25 00 5A    .%.Z
           lda    #241                                                  * 00AC 86 F1          .q
           pshs   U                                                     * 00AE 34 40          4@
           os9    F$Link                                                * 00B0 10 3F 00       .?.
           lbcs   L0106                                                 * 00B3 10 25 00 4F    .%.O
           tfr    U,Y                                                   * 00B7 1F 32          .2
           puls   U                                                     * 00B9 35 40          5@
           ldx    $0F,Y                                                 * 00BB AE 2F          ./
           leax   $01,X                                                 * 00BD 30 01          0.
           stx    U0004,U                                               * 00BF AF 44          /D
L00C1      ldx    #1                                                    * 00C1 8E 00 01       ...
           os9    F$Sleep                                               * 00C4 10 3F 0A       .?.
           ldx    U0004,U                                               * 00C7 AE 44          .D
           lda    0,X                                                   * 00C9 A6 84          &.
           bita   #32                                                   * 00CB 85 20          .
           beq    L00C1                                                 * 00CD 27 F2          'r
           os9    F$ID                                                  * 00CF 10 3F 0C       .?.
           sta    U0002,U                                               * 00D2 A7 42          'B
           leax   >U0127,U                                              * 00D4 30 C9 01 27    0I.'
           os9    F$GPrDsc                                              * 00D8 10 3F 18       .?.
           lda    >U0128,U                                              * 00DB A6 C9 01 28    &I.(
           sta    U0000,U                                               * 00DF A7 C4          'D
           lda    #255                                                  * 00E1 86 FF          ..
           sta    U0001,U                                               * 00E3 A7 41          'A
           clr    U0003,U                                               * 00E5 6F 43          oC
           leax   <U0028,U                                              * 00E7 30 C8 28       0H(
           stx    U0006,U                                               * 00EA AF 46          /F
L00EC      lda    U0001,U                                               * 00EC A6 41          &A
L00EE      leax   >U0127,U                                              * 00EE 30 C9 01 27    0I.'
           os9    F$GPrDsc                                              * 00F2 10 3F 18       .?.
           bcs    L0117                                                 * 00F5 25 20          %
           lda    >U0128,U                                              * 00F7 A6 C9 01 28    &I.(
           cmpa   U0000,U                                               * 00FB A1 C4          !D
           beq    L0109                                                 * 00FD 27 0A          '.
           cmpa   #0                                                    * 00FF 81 00          ..
           beq    L0117                                                 * 0101 27 14          '.
           bra    L00EE                                                 * 0103 20 E9           i
L0105      clrb                                                         * 0105 5F             _
L0106      os9    F$Exit                                                * 0106 10 3F 06       .?.
L0109      lda    U0001,U                                               * 0109 A6 41          &A
           cmpa   U0002,U                                               * 010B A1 42          !B
           beq    L0117                                                 * 010D 27 08          '.
           ldx    U0006,U                                               * 010F AE 46          .F
           sta    ,X+                                                   * 0111 A7 80          '.
           stx    U0006,U                                               * 0113 AF 46          /F
           inc    U0003,U                                               * 0115 6C 43          lC
L0117      dec    U0001,U                                               * 0117 6A 41          jA
           cmpa   #3                                                    * 0119 81 03          ..
           beq    L011F                                                 * 011B 27 02          '.
           bra    L00EC                                                 * 011D 20 CD           M
L011F      leax   <U0028,U                                              * 011F 30 C8 28       0H(
L0122      tst    U0003,U                                               * 0122 6D 43          mC
           lbeq   L0105                                                 * 0124 10 27 FF DD    .'.]
           dec    U0003,U                                               * 0128 6A 43          jC
           lda    ,X+                                                   * 012A A6 80          &.
           clrb                                                         * 012C 5F             _
L012D      os9    F$Send                                                * 012D 10 3F 08       .?.
           bcc    L0122                                                 * 0130 24 F0          $p
           pshs   X,A                                                   * 0132 34 12          4.
           ldx    #1                                                    * 0134 8E 00 01       ...
           os9    F$Sleep                                               * 0137 10 3F 0A       .?.
           puls   X,A                                                   * 013A 35 12          5.
           bra    L012D                                                 * 013C 20 EF           o

           emod
eom        equ    *
           end
