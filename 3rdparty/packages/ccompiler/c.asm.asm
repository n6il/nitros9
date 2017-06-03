           NAM    c.asm
           TTL    program module

           USE    defsfile

tylg       SET    Prgrm+Objct
atrv       SET    ReEnt+rev
rev        SET    $01

           MOD    eom,name,tylg,atrv,_cstart,size

U0000      RMB    1
U0001      RMB    1
U0002      RMB    1
U0003      RMB    2
U0005      RMB    2
Y0007      RMB    2
Y0009      RMB    2
Y000B      RMB    2
Y000D      RMB    2
Y000F      RMB    2
Y0011      RMB    2
Y0013      RMB    2
U0015      RMB    2
U0017      RMB    2
U0019      RMB    2
U001B      RMB    2
U001D      RMB    2
U001F      RMB    2
U0021      RMB    2
U0023      RMB    2
U0025      RMB    2
U0027      RMB    2
U0029      RMB    2
U002B      RMB    2
U002D      RMB    2
U002F      RMB    2
U0031      RMB    1
U0032      RMB    1
U0033      RMB    2
U0035      RMB    2
U0037      RMB    2
U0039      RMB    4
U003D      RMB    2
U003F      RMB    2
U0041      RMB    2
U0043      RMB    2
U0045      RMB    2
U0047      RMB    2
Y0049      RMB    2
U004B      RMB    2
U004D      RMB    2
U004F      RMB    2
reldt      RMB    2
U0053      RMB    2
U0055      RMB    2
Y0057      RMB    2
Y0059      RMB    2
U005B      RMB    1
U005C      RMB    1
U005D      RMB    1
U005E      RMB    1
U005F      RMB    1
U0060      RMB    1
U0061      RMB    1
U0062      RMB    2
U0064      RMB    2
U0066      RMB    2
U0068      RMB    2
U006A      RMB    2
U006C      RMB    2
U006E      RMB    2
U0070      RMB    2
U0072      RMB    2
U0074      RMB    2
U0076      RMB    2
U0078      RMB    2
U007A      RMB    2
U007C      RMB    1
U007D      RMB    7
U0084      RMB    12
U0090      RMB    1
U0091      RMB    7
U0098      RMB    12
U00A4      RMB    1
U00A5      RMB    7
U00AC      RMB    12
U00B8      RMB    1
Y00B9      RMB    1
U00BA      RMB    1
U00BB      RMB    2
U00BD      RMB    2
U00BF      RMB    1
U00C0      RMB    1
U00C1      RMB    1
U00C2      RMB    1
U00C3      RMB    1
U00C4      RMB    1
U00C5      RMB    1
U00C6      RMB    1
U00C7      RMB    1
U00C8      RMB    2
U00CA      RMB    2
U00CC      RMB    2
U00CE      RMB    2
U00D0      RMB    2
U00D2      RMB    2
U00D4      RMB    2
U00D6      RMB    2
U00D8      RMB    2
U00DA      RMB    2
U00DC      RMB    2
U00DE      RMB    2
U00E0      RMB    2
U00E2      RMB    2
U00E4      RMB    2
U00E6      RMB    2
dpsiz      RMB    30
Y0106      RMB    16
Y0116      RMB    320
Y0256      RMB    8
Y025E      RMB    28
Y027A      RMB    8
Y0282      RMB    88
Y02DA      RMB    76
Y0326      RMB    12
Y0332      RMB    8
Y033A      RMB    28
Y0356      RMB    4
Y035A      RMB    4
Y035E      RMB    4
Y0362      RMB    30
Y0380      RMB    24
Y0398      RMB    22
Y03AE      RMB    24
Y03C6      RMB    14
Y03D4      RMB    4
Y03D8      RMB    4
Y03DC      RMB    2
Y03DE      RMB    1
Y03DF      RMB    5
Y03E4      RMB    2
Y03E6      RMB    2
Y03E8      RMB    2
Y03EA      RMB    2
Y03EC      RMB    2
Y03EE      RMB    2
Y03F0      RMB    2
Y03F2      RMB    2
Y03F4      RMB    2
Y03F6      RMB    2
Y03F8      RMB    2
Y03FA      RMB    2
Y03FC      RMB    128
Y047C      RMB    8
Y0484      RMB    2
Y0486      RMB    1
Y0487      RMB    2
_iob       RMB    13
Y0496      RMB    13
Y04A3      RMB    182
argv       RMB    62
_sttop     RMB    2
memend     RMB    2
Y059B      RMB    2
Y059D      RMB    6
_mtop      RMB    2
_stbot     RMB    2
errno      RMB    2
Y05A9      RMB    10
Y05B3      RMB    1
Y05B4      RMB    9
Y05BD      RMB    10
Y05C7      RMB    120
Y063F      RMB    120
Y06B7      RMB    10
Y06C1      RMB    4
Y06C5      RMB    256
Y07C5      RMB    2
Y07C7      RMB    30
Y07E5      RMB    2
Y07E7      RMB    2
Y07E9      RMB    4
Y07ED      RMB    4
Y07F1      RMB    4
Y07F5      RMB    4
Y07F9      RMB    1
Y07FA      RMB    1
Y07FB      RMB    1
Y07FC      RMB    1
Y07FD      RMB    2
Y07FF      RMB    24
Y0817      RMB    62
Y0855      RMB    2
Y0857      RMB    256
Y0957      RMB    80
Y09A7      RMB    2
Y09A9      RMB    10
Y09B3      RMB    10
Y09BD      RMB    2
Y09BF      RMB    2
Y09C1      RMB    1
Y09C2      RMB    2
Y09C4      RMB    2
end        RMB    1
U09C7      RMB    3967
size       EQU    .

name       FCS    /c.asm/                                               * 000D 63 2E 61 73 ED c.asm
           FCB    $04                                                   * 0012 04             .

*
* move bytes (Y=From addr, U=To addr, X=Count)
*
movbytes   LDA    ,Y+          get a byte                               * 0013 A6 A0          &
           STA    ,U+          put a byte                               * 0015 A7 C0          '@
           LEAX   -1,X         dec the count                            * 0017 30 1F          0.
           BNE    movbytes     and round again                          * 0019 26 F8          &x
           RTS                                                          * 001B 39             9

_cstart    PSHS   Y            save the to of mem                       * 001C 34 20          4
           PSHS   U            save the data beginning address          * 001E 34 40          4@

           CLRA                setup to clear                           * 0020 4F             O
           CLRB                256 bytes                                * 0021 5F             _
csta05     STA    ,U+          clear dp bytes                           * 0022 A7 C0          '@
           DECB                                                         * 0024 5A             Z
           BNE    csta05                                                * 0025 26 FB          &{

csta10     LDX    ,S           get the beginning of data address        * 0027 AE E4          .d
           LEAU   ,X           (tfr x,u)                                * 0029 33 84          3.
           LEAX   >2502,X      get the end of bss address               * 002B 30 89 09 C6    0..F
           PSHS   X            save it                                  * 002F 34 10          4.
           LEAY   >etext,PC    point to dp-data count word              * 0031 31 8D 49 E7    1.Ig

           LDX    ,Y++         get count of dp-data to be moved         * 0035 AE A1          .!
           BEQ    csta15       bra if none                              * 0037 27 04          '.
           BSR    movbytes     move dp data into position               * 0039 8D D8          .X

           LDU    2,S          get beginning address again              * 003B EE 62          nb
csta15     LEAU   >232,U       point to where non-dp should start       * 003D 33 C9 00 E8    3I.h
           LDX    ,Y++         get count of non-dp data to be moved     * 0041 AE A1          .!
           BEQ    clrbss                                                * 0043 27 03          '.
           BSR    movbytes     move non-dp data into position           * 0045 8D CC          .L

* clear the bss area - starts where
* the transferred data finished
           CLRA                                                         * 0047 4F             O
clrbss     CMPU   ,S           reached the end?                         * 0048 11 A3 E4       .#d
           BEQ    L0051        bra if so                                * 004B 27 04          '.
           STA    ,U+          clear it                                 * 004D A7 C0          '@
           BRA    clrbss                                                * 004F 20 F7           w

* now replace the data-text references
L0051      LDU    2,S          store to data bottom                     * 0051 EE 62          nb
           LDD    ,Y++         get data-text ref. count                 * 0053 EC A1          l!
           BEQ    reldd                                                 * 0055 27 07          '.
           LEAX   >U0000,PC    point to text                            * 0057 30 8D FF A5    0..%
           LBSR   patch        patch them                               * 005B 17 01 03       ...

* and the data-data refs.
reldd      LDD    ,Y++         get the count of data refs.              * 005E EC A1          l!
           BEQ    restack      bra if none                              * 0060 27 05          '.
           LEAX   ,U           u was already pointing there             * 0062 30 C4          0D
           LBSR   patch                                                 * 0064 17 00 FA       ..z

restack    LEAS   4,S          reset stack                              * 0067 32 64          2d
           PULS   X            restore 'memend'                         * 0069 35 10          5.
           STX    >1433,U                                               * 006B AF C9 05 99    /I..

* process the params
* the stack pointer is back where it started so is
* pointing at the params
*
* the objective is to insert null chars at the end of each argument
* and fill in the argv vector with pointers to them

* first store the program name address
* (an extra name is inserted here for just this purpose
* - undocumented as yet)
           STY    >1369,U                                               * 006F 10 AF C9 05 59 ./I.Y

           LDD    #1           at least one arg                         * 0074 CC 00 01       L..
           STD    >1429,U                                               * 0077 ED C9 05 95    mI..
           LEAY   >1371,U      point y at second slot                   * 007B 31 C9 05 5B    1I.[
           LEAX   ,S           point x at params                        * 007F 30 E4          0d
           LDA    ,X+          initialize                               * 0081 A6 80          &.

aloop      LDB    >1430,U                                               * 0083 E6 C9 05 96    fI..
           CMPB   #29          about to overflow?                       * 0087 C1 1D          A.
           BEQ    final                                                 * 0089 27 54          'T
aloop10    CMPA   #13          is it EOL?                               * 008B 81 0D          ..
           BEQ    final        yes - reached the end of the list        * 008D 27 50          'P

           CMPA   #32          is it a space?                           * 008F 81 20          .
           BEQ    aloop20      yes - try another                        * 0091 27 04          '.
           CMPA   #44          is it a comma?                           * 0093 81 2C          .,
           BNE    aloop30      no - a word has started                  * 0095 26 04          &.
aloop20    LDA    ,X+          yes - bump                               * 0097 A6 80          &.
           BRA    aloop10      and round again                          * 0099 20 F0           p

aloop30    CMPA   #34          quoted string?                           * 009B 81 22          ."
           BEQ    aloop40      yes                                      * 009D 27 04          '.
           CMPA   #39          the other one?                           * 009F 81 27          .'
           BNE    aloop60      no - ordinary                            * 00A1 26 1E          &.

aloop40    STX    ,Y++         save address in vector                   * 00A3 AF A1          /!
           INC    >1430,U      bump the arg count                       * 00A5 6C C9 05 96    lI..
           PSHS   A            save delimiter                           * 00A9 34 02          4.

qloop      LDA    ,X+          get another                              * 00AB A6 80          &.
           CMPA   #13          eol?                                     * 00AD 81 0D          ..
           BEQ    aloop50                                               * 00AF 27 04          '.
           CMPA   ,S           delimiter?                               * 00B1 A1 E4          !d
           BNE    qloop                                                 * 00B3 26 F6          &v

aloop50    PULS   B            clean stack                              * 00B5 35 04          5.
           CLR    -1,X                                                  * 00B7 6F 1F          o.
           CMPA   #13                                                   * 00B9 81 0D          ..
           BEQ    final                                                 * 00BB 27 22          '"
           LDA    ,X+                                                   * 00BD A6 80          &.
           BRA    aloop                                                 * 00BF 20 C2           B

aloop60    LEAX   -1,X         point at first char                      * 00C1 30 1F          0.
           STX    ,Y++         put address in vector                    * 00C3 AF A1          /!
           LEAX   1,X          bump it back                             * 00C5 30 01          0.
           INC    >1430,U      bump the arg count                       * 00C7 6C C9 05 96    lI..

* at least one non-space char has been seen
aloop70    CMPA   #13          have                                     * 00CB 81 0D          ..
           BEQ    loopend      we                                       * 00CD 27 0C          '.
           CMPA   #32          reached                                  * 00CF 81 20          .
           BEQ    loopend      the end?                                 * 00D1 27 08          '.
           CMPA   #44          comma?                                   * 00D3 81 2C          .,
           BEQ    loopend                                               * 00D5 27 04          '.
           LDA    ,X+          no - look further                        * 00D7 A6 80          &.
           BRA    aloop70                                               * 00D9 20 F0           p

loopend    CLR    -1,X         yes - put in the null byte               * 00DB 6F 1F          o.
           BRA    aloop        and look for the next word               * 00DD 20 A4           $

* now put the pointers on the stack
final      LEAX   >1369,U      get the address of the arg vector        * 00DF 30 C9 05 59    0I.Y
           PSHS   X            goes on the stack first                  * 00E3 34 10          4.
           LDD    >1429,U      get the arg count                        * 00E5 EC C9 05 95    lI..
           PSHS   D            stack it                                 * 00E9 34 06          4.
           LEAY   ,U           C progs. assume data & bss offset from y * 00EB 31 C4          1D

           BSR    _fixtop      set various variables                    * 00ED 8D 0A          ..

           LBSR   main         call the program                         * 00EF 17 00 89       ...

           CLR    ,-S          put a zero                               * 00F2 6F E2          ob
           CLR    ,-S          on the stack                             * 00F4 6F E2          ob
           LBSR   exit         and a dummy 'return address'             * 00F6 17 49 17       .I.

* no return here
_fixtop    LEAX   >end,Y       get the initial memory end address       * 00F9 30 A9 09 C6    0).F
           STX    >_mtop,Y     it's the current memory top              * 00FD AF A9 05 A3    /).#
           STS    >_sttop,Y    this is really two bytes short!          * 0101 10 EF A9 05 97 .o)..
           STS    >_stbot,Y                                             * 0106 10 EF A9 05 A5 .o).%
           LDD    #-126        give ourselves some breathing space      * 010B CC FF 82       L..

* on entry here, d holds the negative of a stack reservation request
_stkcheck  LEAX   D,S          calculate the requested size             * 010E 30 EB          0k
           CMPX   >_stbot,Y    is it lower than already reserved?       * 0110 AC A9 05 A5    ,).%
           BCC    stk10        no - return                              * 0114 24 0A          $.
           CMPX   >_mtop,Y     yes - is it lower than possible?         * 0116 AC A9 05 A3    ,).#
           BCS    fsterr       yes - can't cope                         * 011A 25 1E          %.
           STX    >_stbot,Y    no - reserve it                          * 011C AF A9 05 A5    /).%
stk10      RTS                 and return                               * 0120 39             9

fixserr    FCC    "**** STACK OVERFLOW ****"                            * 0121 2A 2A 2A 2A 20 53 54 41 43 4B 20 4F 56 45 52 46 4C 4F 57 20 2A 2A 2A 2A **** STACK OVERFLOW ****
           FCB    $0D                                                   * 0139 0D             .

fsterr     LEAX   <fixserr,PC  address of error string                  * 013A 30 8C E4       0.d
           LDB    #E$MemFul    MEMORY FULL error number                 * 013D C6 CF          FO

erexit     PSHS   B            stack the error number                   * 013F 34 04          4.
           LDA    #2           standard error output                    * 0141 86 02          ..
           LDY    #100         more than necessary                      * 0143 10 8E 00 64    ...d
           OS9    I$WritLn     write it                                 * 0147 10 3F 8C       .?.
           CLR    ,-S          clear MSB of status                      * 014A 6F E2          ob
           LBSR   _exit        and out                                  * 014C 17 48 C7       .HG
* no return here

* stacksize()
* the extent of stack requested
* can be used by programmer for guidance
* in sizing memory at compile time
stacksiz   LDD    >_sttop,Y    top of stack on entry                    * 014F EC A9 05 97    l)..
           SUBD   >_stbot,Y    subtract current reserved limit          * 0153 A3 A9 05 A5    #).%
           RTS                                                          * 0157 39             9

* freemem()
* returns the current size of the free memory area
freemem    LDD    >_stbot,Y                                             * 0158 EC A9 05 A5    l).%
           SUBD   >_mtop,Y                                              * 015C A3 A9 05 A3    #).#
           RTS                                                          * 0160 39             9

* patch - adjust initialized data which refer to memory locations.
* entry:
*       y -> list of offsets in the data area to be patched
*       u -> base of data
*       x -> base of either text or data area as appropriate
*       d =  count of offsets in the list
*
* exit:
*       u - unchanged
*       y - past the last entry in the list
*       x and d mangled

patch      PSHS   X            save the base                            * 0161 34 10          4.
           LEAX   D,Y          half way up the list                     * 0163 30 AB          0+
           LEAX   D,X          top of list                              * 0165 30 8B          0.
           PSHS   X            save it as place to stop                 * 0167 34 10          4.

* we do not come to this routine with
* a zero count (check!) so a test at the loop top
* is unnecessary
patch10    LDD    ,Y++         get the offset                           * 0169 EC A1          l!
           LEAX   D,U          point to location                        * 016B 30 CB          0K
           LDD    ,X           get the relative reference               * 016D EC 84          l.
           ADDD   2,S          add in the base                          * 016F E3 62          cb
           STD    ,X           store the absolute reference             * 0171 ED 84          m.
           CMPY   ,S           reached the top?                         * 0173 10 AC E4       .,d
           BNE    patch10      no - round again                         * 0176 26 F1          &q

           LEAS   4,S          reset the stack                          * 0178 32 64          2d
           RTS                 and return                               * 017A 39             9

main       PSHS   U,D                                                   * 017B 34 46          4F
           LDD    8,S                                                   * 017D EC 68          lh
           PSHS   D                                                     * 017F 34 06          4.
           LDD    8,S                                                   * 0181 EC 68          lh
           PSHS   D                                                     * 0183 34 06          4.
           LBSR   L2893                                                 * 0185 17 27 0B       .'.
           LEAS   4,S                                                   * 0188 32 64          2d
           LDB    <U00C3                                                * 018A D6 C3          VC
           BEQ    L0193                                                 * 018C 27 05          '.
           LDD    #1                                                    * 018E CC 00 01       L..
           STB    <U00C4                                                * 0191 D7 C4          WD
L0193      LDD    #4                                                    * 0193 CC 00 04       L..
           STB    <U007C                                                * 0196 D7 7C          W|
           LDD    #3                                                    * 0198 CC 00 03       L..
           STB    <U0090                                                * 019B D7 90          W.
           LDD    #1                                                    * 019D CC 00 01       L..
           STB    <U00A4                                                * 01A0 D7 A4          W$
           LDD    #2                                                    * 01A2 CC 00 02       L..
           STB    <U00A5                                                * 01A5 D7 A5          W%
           STB    <U0091                                                * 01A7 D7 91          W.
           STB    <U007D                                                * 01A9 D7 7D          W}
           LDB    <U00C6                                                * 01AB D6 C6          VF
           BEQ    L01C2                                                 * 01AD 27 13          '.
           LEAX   >L07AD,PC                                             * 01AF 30 8D 05 FA    0..z
           PSHS   X                                                     * 01B3 34 10          4.
           LDD    >Y03F8,Y                                              * 01B5 EC A9 03 F8    l).x
           PSHS   D                                                     * 01B9 34 06          4.
           LBSR   L2955                                                 * 01BB 17 27 97       .'.
           LEAS   4,S                                                   * 01BE 32 64          2d
           STD    <U0017                                                * 01C0 DD 17          ].
L01C2      LEAX   >Y0817,Y                                              * 01C2 30 A9 08 17    0)..
           STX    ,S                                                    * 01C6 AF E4          /d
           LBRA   L0230                                                 * 01C8 16 00 65       ..e
L01CB      LEAX   >L07AF,PC                                             * 01CB 30 8D 05 E0    0..`
           PSHS   X                                                     * 01CF 34 10          4.
           LDD    [<$02,S]                                              * 01D1 EC F8 02       lx.
           PSHS   D                                                     * 01D4 34 06          4.
           LBSR   L2955                                                 * 01D6 17 27 7C       .'|
           LEAS   4,S                                                   * 01D9 32 64          2d
           STD    <U0015                                                * 01DB DD 15          ].
           CLRA                                                         * 01DD 4F             O
           CLRB                                                         * 01DE 5F             _
           STB    >Y063F,Y                                              * 01DF E7 A9 06 3F    g).?
           STB    >Y05C7,Y                                              * 01E3 E7 A9 05 C7    g).G
           CLRA                                                         * 01E7 4F             O
           CLRB                                                         * 01E8 5F             _
           STD    <U00AC                                                * 01E9 DD AC          ],
           STD    <U0098                                                * 01EB DD 98          ].
           STD    <U0084                                                * 01ED DD 84          ].
           CLRA                                                         * 01EF 4F             O
           CLRB                                                         * 01F0 5F             _
           STB    <U005B                                                * 01F1 D7 5B          W[
           LBSR   L0252                                                 * 01F3 17 00 5C       ..\
           LDD    <U0015                                                * 01F6 DC 15          \.
           PSHS   D                                                     * 01F8 34 06          4.
           LBSR   L4042                                                 * 01FA 17 3E 45       .>E
           LEAS   2,S                                                   * 01FD 32 62          2b
           LDD    #1                                                    * 01FF CC 00 01       L..
           STB    <U005B                                                * 0202 D7 5B          W[
           BSR    L0252                                                 * 0204 8D 4C          .L
           LBSR   L2DB3                                                 * 0206 17 2B AA       .+*
           LBSR   L2F35                                                 * 0209 17 2D 29       .-)
           LDD    <U0015                                                * 020C DC 15          \.
           PSHS   D                                                     * 020E 34 06          4.
           LBSR   fclose                                                * 0210 17 3F 9F       .?.
           STD    ,S++                                                  * 0213 ED E1          ma
           BEQ    L0222                                                 * 0215 27 0B          '.
           LEAX   >L07B1,PC                                             * 0217 30 8D 05 96    0...
           PSHS   X                                                     * 021B 34 10          4.
           LBSR   L074E                                                 * 021D 17 05 2E       ...
           LEAS   2,S                                                   * 0220 32 62          2b
L0222      LDB    <U00C7                                                * 0222 D6 C7          VG
           BLE    L0229                                                 * 0224 2F 03          /.
           LBSR   L2B29                                                 * 0226 17 29 00       .).
L0229      LDD    ,S                                                    * 0229 EC E4          ld
           ADDD   #2                                                    * 022B C3 00 02       C..
           STD    ,S                                                    * 022E ED E4          md
L0230      LDD    ,S                                                    * 0230 EC E4          ld
           CMPD   >Y03F6,Y                                              * 0232 10 A3 A9 03 F6 .#).v
           LBCS   L01CB                                                 * 0237 10 25 FF 90    .%..
           LBSR   L36FE                                                 * 023B 17 34 C0       .4@
           LDD    <U0023                                                * 023E DC 23          \#
           BEQ    L0247                                                 * 0240 27 05          '.
           LDD    #1                                                    * 0242 CC 00 01       L..
           BRA    L0249                                                 * 0245 20 02           .
L0247      CLRA                                                         * 0247 4F             O
           CLRB                                                         * 0248 5F             _
L0249      PSHS   D                                                     * 0249 34 06          4.
           LBSR   exit                                                  * 024B 17 47 C2       .GB
           LEAS   2,S                                                   * 024E 32 62          2b
           PULS   PC,U,X                                                * 0250 35 D0          5P
L0252      PSHS   U                                                     * 0252 34 40          4@
           LEAS   -1,S                                                  * 0254 32 7F          2.
           LBSR   L1C72                                                 * 0256 17 1A 19       ...
           CLRA                                                         * 0259 4F             O
           CLRB                                                         * 025A 5F             _
           STD    <U0025                                                * 025B DD 25          ]%
           STD    <U0023                                                * 025D DD 23          ]#
           LEAX   >Y06C5,Y                                              * 025F 30 A9 06 C5    0).E
           STX    <U0076                                                * 0263 9F 76          .v
           CLRA                                                         * 0265 4F             O
           CLRB                                                         * 0266 5F             _
           STD    <U00D8                                                * 0267 DD D8          ]X
           CLRA                                                         * 0269 4F             O
           CLRB                                                         * 026A 5F             _
           STD    <U00C8                                                * 026B DD C8          ]H
           STD    <U002D                                                * 026D DD 2D          ]-
           STD    <U002F                                                * 026F DD 2F          ]/
           STD    <U0027                                                * 0271 DD 27          ]'
           STD    <U002B                                                * 0273 DD 2B          ]+
           STD    <U0029                                                * 0275 DD 29          ])
           LDB    <U005B                                                * 0277 D6 5B          V[
           BEQ    L0288                                                 * 0279 27 0D          '.
           LDB    <U00C4                                                * 027B D6 C4          VD
           BEQ    L0288                                                 * 027D 27 09          '.
           LDB    <U00C3                                                * 027F D6 C3          VC
           BLE    L0288                                                 * 0281 2F 05          /.
           LDD    #1                                                    * 0283 CC 00 01       L..
           BRA    L028A                                                 * 0286 20 02           .
L0288      CLRA                                                         * 0288 4F             O
           CLRB                                                         * 0289 5F             _
L028A      STD    <U003D                                                * 028A DD 3D          ]=
           LBSR   L298C                                                 * 028C 17 26 FD       .&}
           BRA    L029E                                                 * 028F 20 0D           .
L0291      BSR    L02A9                                                 * 0291 8D 16          ..
           STD    -2,S                                                  * 0293 ED 7E          m~
           BEQ    L029B                                                 * 0295 27 04          '.
           LDD    <U0062                                                * 0297 DC 62          \b
           STD    <U006C                                                * 0299 DD 6C          ]l
L029B      LBSR   L05C5                                                 * 029B 17 03 27       ..'
L029E      LBSR   L2A7F                                                 * 029E 17 27 DE       .'^
           STD    -2,S                                                  * 02A1 ED 7E          m~
           BNE    L0291                                                 * 02A3 26 EC          &l
           LEAS   1,S                                                   * 02A5 32 61          2a
           PULS   PC,U                                                  * 02A7 35 C0          5@
L02A9      PSHS   U                                                     * 02A9 34 40          4@
           LEAS   -3,S                                                  * 02AB 32 7D          2}
           CLRA                                                         * 02AD 4F             O
           CLRB                                                         * 02AE 5F             _
           STD    <U00BD                                                * 02AF DD BD          ]=
           STD    <U0039                                                * 02B1 DD 39          ]9
           STD    <U0037                                                * 02B3 DD 37          ]7
           STD    <U0021                                                * 02B5 DD 21          ]!
           STD    <U001D                                                * 02B7 DD 1D          ].
           STD    <U0033                                                * 02B9 DD 33          ]3
           STD    <U001B                                                * 02BB DD 1B          ].
           LDD    <U004B                                                * 02BD DC 4B          \K
           STD    <U004F                                                * 02BF DD 4F          ]O
           BEQ    L02CF                                                 * 02C1 27 0C          '.
           LEAX   >reldt,Y                                              * 02C3 30 A9 00 51    0).Q
           STX    <U004F                                                * 02C7 9F 4F          .O
           LDD    [>U004B,Y]                                            * 02C9 EC B9 00 4B    l9.K
           STD    ,X                                                    * 02CD ED 84          m.
L02CF      CLRA                                                         * 02CF 4F             O
           CLRB                                                         * 02D0 5F             _
           STD    <U00CA                                                * 02D1 DD CA          ]J
           STD    <U006C                                                * 02D3 DD 6C          ]l
           STD    <U006A                                                * 02D5 DD 6A          ]j
           STD    <U0066                                                * 02D7 DD 66          ]f
           STD    <U0064                                                * 02D9 DD 64          ]d
           LDB    <U005C                                                * 02DB D6 5C          V\
           STB    <U005D                                                * 02DD D7 5D          W]
           LDB    <U005E                                                * 02DF D6 5E          V^
           STB    <U005F                                                * 02E1 D7 5F          W_
           LDB    <U0060                                                * 02E3 D6 60          V`
           STB    <U0061                                                * 02E5 D7 61          Wa
           LEAX   >Y07C7,Y                                              * 02E7 30 A9 07 C7    0).G
           STX    >Y07E5,Y                                              * 02EB AF A9 07 E5    /).e
           LDB    <U005B                                                * 02EF D6 5B          V[
           BEQ    L0300                                                 * 02F1 27 0D          '.
           LDB    <U00C4                                                * 02F3 D6 C4          VD
           BEQ    L0300                                                 * 02F5 27 09          '.
           LDB    <U00C3                                                * 02F7 D6 C3          VC
           BLE    L0300                                                 * 02F9 2F 05          /.
           LDD    #1                                                    * 02FB CC 00 01       L..
           BRA    L0302                                                 * 02FE 20 02           .
L0300      CLRA                                                         * 0300 4F             O
           CLRB                                                         * 0301 5F             _
L0302      STD    <U003D                                                * 0302 DD 3D          ]=
           CLRA                                                         * 0304 4F             O
           CLRB                                                         * 0305 5F             _
           STD    <U00D6                                                * 0306 DD D6          ]V
           LDD    <U00CE                                                * 0308 DC CE          \N
           BEQ    L0310                                                 * 030A 27 04          '.
           LDB    <U0002                                                * 030C D6 02          V.
           BLE    L0318                                                 * 030E 2F 08          /.
L0310      LDD    <U002B                                                * 0310 DC 2B          \+
           BEQ    L031C                                                 * 0312 27 08          '.
           LDB    <U00BF                                                * 0314 D6 BF          V?
           BGT    L031C                                                 * 0316 2E 04          ..
L0318      CLRA                                                         * 0318 4F             O
           CLRB                                                         * 0319 5F             _
           STD    <U003D                                                * 031A DD 3D          ]=
L031C      LDB    [>U0062,Y]                                            * 031C E6 B9 00 62    f9.b
           STB    2,S                                                   * 0320 E7 62          gb
           LBEQ   L05AD                                                 * 0322 10 27 02 87    .'..
           LDB    2,S                                                   * 0326 E6 62          fb
           CMPB   #42                                                   * 0328 C1 2A          A*
           LBEQ   L05AD                                                 * 032A 10 27 02 7F    .'..
           LDB    2,S                                                   * 032E E6 62          fb
           CMPB   #32                                                   * 0330 C1 20          A
           BEQ    L037B                                                 * 0332 27 47          'G
           LDD    <U0062                                                * 0334 DC 62          \b
           STD    <U0064                                                * 0336 DD 64          ]d
           LDD    <U00CC                                                * 0338 DC CC          \L
           BNE    L0361                                                 * 033A 26 25          &%
           LDD    <U002B                                                * 033C DC 2B          \+
           BNE    L0361                                                 * 033E 26 21          &!
           LDD    <U00D2                                                * 0340 DC D2          \R
           BNE    L0361                                                 * 0342 26 1D          &.
           LBSR   L1E7F                                                 * 0344 17 1B 38       ..8
           STD    -2,S                                                  * 0347 ED 7E          m~
           BNE    L0369                                                 * 0349 26 1E          &.
           LEAX   >L07C2,PC                                             * 034B 30 8D 04 73    0..s
           LBRA   L05BA                                                 * 034F 16 02 68       ..h

           BRA    L0369                                                 * 0352 20 15           .

L0354      LDB    2,S                                                   * 0354 E6 62          fb
           CMPB   #32                                                   * 0356 C1 20          A
           BEQ    L0369                                                 * 0358 27 0F          '.
           LDD    <U0062                                                * 035A DC 62          \b
           ADDD   #1                                                    * 035C C3 00 01       C..
           STD    <U0062                                                * 035F DD 62          ]b
L0361      LDB    [>U0062,Y]                                            * 0361 E6 B9 00 62    f9.b
           STB    2,S                                                   * 0365 E7 62          gb
           BNE    L0354                                                 * 0367 26 EB          &k
L0369      LDB    [>U0062,Y]                                            * 0369 E6 B9 00 62    f9.b
           CMPB   #32                                                   * 036D C1 20          A
           BNE    L037B                                                 * 036F 26 0A          &.
           CLRA                                                         * 0371 4F             O
           CLRB                                                         * 0372 5F             _
           LDX    <U0062                                                * 0373 9E 62          .b
           LEAX   1,X                                                   * 0375 30 01          0.
           STX    <U0062                                                * 0377 9F 62          .b
           STB    -1,X                                                  * 0379 E7 1F          g.
L037B      LBSR   L2229                                                 * 037B 17 1E AB       ..+
           STB    2,S                                                   * 037E E7 62          gb
           LBEQ   L05AD                                                 * 0380 10 27 02 29    .'.)
           LEAX   >Y05B3,Y                                              * 0384 30 A9 05 B3    0).3
           PSHS   X                                                     * 0388 34 10          4.
           LBSR   L1E0B                                                 * 038A 17 1A 7E       ..~
           STD    ,S++                                                  * 038D ED E1          ma
           LBEQ   L05B2                                                 * 038F 10 27 02 1F    .'..
           LEAX   >Y05B3,Y                                              * 0393 30 A9 05 B3    0).3
           STX    <U0066                                                * 0397 9F 66          .f
           LBSR   L2229                                                 * 0399 17 1E 8D       ...
           LDD    <U00D2                                                * 039C DC D2          \R
           BNE    L03C1                                                 * 039E 26 21          &!
           LEAX   >Y05B3,Y                                              * 03A0 30 A9 05 B3    0).3
           PSHS   X                                                     * 03A4 34 10          4.
           LBSR   L3318                                                 * 03A6 17 2F 6F       ./o
           LEAS   2,S                                                   * 03A9 32 62          2b
           STD    ,S                                                    * 03AB ED E4          md
           BEQ    L03C1                                                 * 03AD 27 12          '.
           LDD    <U00CC                                                * 03AF DC CC          \L
           LBNE   L048A                                                 * 03B1 10 26 00 D5    .&.U
           LDD    ,S                                                    * 03B5 EC E4          ld
           PSHS   D                                                     * 03B7 34 06          4.
           LBSR   L3350                                                 * 03B9 17 2F 94       ./.
           LEAS   2,S                                                   * 03BC 32 62          2b
           LBRA   L0424                                                 * 03BE 16 00 63       ..c
L03C1      LDD    >Y0011,Y                                              * 03C1 EC A9 00 11    l)..
           PSHS   D                                                     * 03C5 34 06          4.
           LEAX   >Y0282,Y                                              * 03C7 30 A9 02 82    0)..
           PSHS   X                                                     * 03CB 34 10          4.
           LEAX   >Y05B3,Y                                              * 03CD 30 A9 05 B3    0).3
           PSHS   X                                                     * 03D1 34 10          4.
           LBSR   L0874                                                 * 03D3 17 04 9E       ...
           LEAS   6,S                                                   * 03D6 32 66          2f
           STD    <U0070                                                * 03D8 DD 70          ]p
           LBEQ   L047B                                                 * 03DA 10 27 00 9D    .'..
           LDX    <U0070                                                * 03DE 9E 70          .p
           LDB    3,X                                                   * 03E0 E6 03          f.
           CLRA                                                         * 03E2 4F             O
           ANDB   #15                                                   * 03E3 C4 0F          D.
           STD    <U001F                                                * 03E5 DD 1F          ].
           LDD    <U00D2                                                * 03E7 DC D2          \R
           BEQ    L0401                                                 * 03E9 27 16          '.
           LDD    <U001F                                                * 03EB DC 1F          \.
           LBNE   L047F                                                 * 03ED 10 26 00 8E    .&..
           LDX    <U0070                                                * 03F1 9E 70          .p
           LDB    2,X                                                   * 03F3 E6 02          f.
           CMPB   #11                                                   * 03F5 C1 0B          A.
           LBNE   L047F                                                 * 03F7 10 26 00 84    .&..
           LBSR   L1D19                                                 * 03FB 17 19 1B       ...
           LBRA   L05C1                                                 * 03FE 16 01 C0       ..@
L0401      LDD    <U00CC                                                * 0401 DC CC          \L
           BEQ    L0427                                                 * 0403 27 22          '"
           LDD    <U001F                                                * 0405 DC 1F          \.
           CMPD   #4                                                    * 0407 10 83 00 04    ....
           BNE    L0413                                                 * 040B 26 06          &.
           LBSR   L0742                                                 * 040D 17 03 32       ..2
           LBRA   L05C1                                                 * 0410 16 01 AE       ...
L0413      LDD    <U001F                                                * 0413 DC 1F          \.
           CMPD   #5                                                    * 0415 10 83 00 05    ....
           LBNE   L048A                                                 * 0419 10 26 00 6D    .&.m
           LBSR   L3300                                                 * 041D 17 2E E0       ..`
           CLRA                                                         * 0420 4F             O
           CLRB                                                         * 0421 5F             _
           STD    <U00CC                                                * 0422 DD CC          ]L
L0424      LBRA   L05AD                                                 * 0424 16 01 86       ...
L0427      LDD    <U002B                                                * 0427 DC 2B          \+
           BEQ    L045C                                                 * 0429 27 31          '1
           LDD    <U001F                                                * 042B DC 1F          \.
           CMPD   #1                                                    * 042D 10 83 00 01    ....
           BEQ    L0452                                                 * 0431 27 1F          '.
           LDD    <U001F                                                * 0433 DC 1F          \.
           CMPD   #2                                                    * 0435 10 83 00 02    ....
           LBNE   L05AD                                                 * 0439 10 26 01 70    .&.p
           LDD    <U002B                                                * 043D DC 2B          \+
           ADDD   #-1                                                   * 043F C3 FF FF       C..
           STD    <U002B                                                * 0442 DD 2B          ]+
           LDD    <U002B                                                * 0444 DC 2B          \+
           LBEQ   L05AD                                                 * 0446 10 27 01 63    .'.c
           LDX    <U0070                                                * 044A 9E 70          .p
           LDB    2,X                                                   * 044C E6 02          f.
           LBEQ   L05AD                                                 * 044E 10 27 01 5B    .'.[
L0452      LDD    <U002B                                                * 0452 DC 2B          \+
           ADDD   #1                                                    * 0454 C3 00 01       C..
           STD    <U002B                                                * 0457 DD 2B          ]+
           LBRA   L05AD                                                 * 0459 16 01 51       ..Q

L045C      LDX    <U0070                                                * 045C 9E 70          .p
           LDB    2,X                                                   * 045E E6 02          f.
           STB    <Y00B9                                                * 0460 D7 B9          W9
           LDD    <U0062                                                * 0462 DC 62          \b
           STD    <U006A                                                * 0464 DD 6A          ]j
           LDD    <U001F                                                * 0466 DC 1F          \.
           ASLB                                                         * 0468 58             X
           ROLA                                                         * 0469 49             I
           LEAX   >Y0326,Y                                              * 046A 30 A9 03 26    0).&
           LEAX   D,X                                                   * 046E 30 8B          0.
           JSR    [,X]                                                  * 0470 AD 94          -.
           STD    -2,S                                                  * 0472 ED 7E          m~
           LBEQ   L0578                                                 * 0474 10 27 01 00    .'..
           LBRA   L0589                                                 * 0478 16 01 0E       ...
L047B      LDD    <U00D2                                                * 047B DC D2          \R
           BEQ    L0486                                                 * 047D 27 07          '.
L047F      CLRA                                                         * 047F 4F             O
           CLRB                                                         * 0480 5F             _
           STD    <U003D                                                * 0481 DD 3D          ]=
           LBRA   L05AD                                                 * 0483 16 01 27       ..'
L0486      LDD    <U00CC                                                * 0486 DC CC          \L
           BEQ    L0490                                                 * 0488 27 06          '.
L048A      LBSR   L329E                                                 * 048A 17 2E 11       ...
           LBRA   L05AD                                                 * 048D 16 01 1D       ...
L0490      LDD    <U002B                                                * 0490 DC 2B          \+
           BEQ    L04CF                                                 * 0492 27 3B          ';
           LDD    <U003D                                                * 0494 DC 3D          \=
           LBEQ   L05AD                                                 * 0496 10 27 01 13    .'..
           LDB    [>U0062,Y]                                            * 049A E6 B9 00 62    f9.b
           LBEQ   L05AD                                                 * 049E 10 27 01 0B    .'..
           LDD    <U0062                                                * 04A2 DC 62          \b
           STD    <U006A                                                * 04A4 DD 6A          ]j
           BRA    L04B0                                                 * 04A6 20 08           .
L04A8      LDB    [>U0062,Y]                                            * 04A8 E6 B9 00 62    f9.b
           CMPB   #32                                                   * 04AC C1 20          A
           BEQ    L04BA                                                 * 04AE 27 0A          '.
L04B0      LDX    <U0062                                                * 04B0 9E 62          .b
           LEAX   1,X                                                   * 04B2 30 01          0.
           STX    <U0062                                                * 04B4 9F 62          .b
           LDB    ,X                                                    * 04B6 E6 84          f.
           BNE    L04A8                                                 * 04B8 26 EE          &n
L04BA      LDB    [>U0062,Y]                                            * 04BA E6 B9 00 62    f9.b
           LBEQ   L05AD                                                 * 04BE 10 27 00 EB    .'.k
           CLRA                                                         * 04C2 4F             O
           CLRB                                                         * 04C3 5F             _
           LDX    <U0062                                                * 04C4 9E 62          .b
           LEAX   1,X                                                   * 04C6 30 01          0.
           STX    <U0062                                                * 04C8 9F 62          .b
           STB    -1,X                                                  * 04CA E7 1F          g.
           LBRA   L05AD                                                 * 04CC 16 00 DE       ..^
L04CF      LEAX   >Y0116,Y                                              * 04CF 30 A9 01 16    0)..
           CMPX   <U0072                                                * 04D3 9C 72          .r
           BNE    L0500                                                 * 04D5 26 29          &)
           LDB    >Y05B3,Y                                              * 04D7 E6 A9 05 B3    f).3
           CMPB   #98                                                   * 04DB C1 62          Ab
           BEQ    L04E7                                                 * 04DD 27 08          '.
           LDB    >Y05B3,Y                                              * 04DF E6 A9 05 B3    f).3
           CMPB   #66                                                   * 04E3 C1 42          AB
           BNE    L0500                                                 * 04E5 26 19          &.
L04E7      LDD    >Y0013,Y                                              * 04E7 EC A9 00 13    l)..
           PSHS   D                                                     * 04EB 34 06          4.
           LEAX   >Y02DA,Y                                              * 04ED 30 A9 02 DA    0).Z
           PSHS   X                                                     * 04F1 34 10          4.
           LEAX   >Y05B3,Y                                              * 04F3 30 A9 05 B3    0).3
           PSHS   X                                                     * 04F7 34 10          4.
           LBSR   L0874                                                 * 04F9 17 03 78       ..x
           LEAS   6,S                                                   * 04FC 32 66          2f
           STD    <U0070                                                * 04FE DD 70          ]p
L0500      LDD    <U0070                                                * 0500 DC 70          \p
           BNE    L0519                                                 * 0502 26 15          &.
           LDD    <U0074                                                * 0504 DC 74          \t
           PSHS   D                                                     * 0506 34 06          4.
           LDD    <U0072                                                * 0508 DC 72          \r
           PSHS   D                                                     * 050A 34 06          4.
           LEAX   >Y05B3,Y                                              * 050C 30 A9 05 B3    0).3
           PSHS   X                                                     * 0510 34 10          4.
           LBSR   L0874                                                 * 0512 17 03 5F       .._
           LEAS   6,S                                                   * 0515 32 66          2f
           STD    <U0070                                                * 0517 DD 70          ]p
L0519      LDD    <U0070                                                * 0519 DC 70          \p
           LBEQ   L05B2                                                 * 051B 10 27 00 93    .'..
           LDX    <U0070                                                * 051F 9E 70          .p
           LDB    3,X                                                   * 0521 E6 03          f.
           CLRA                                                         * 0523 4F             O
           ANDB   #15                                                   * 0524 C4 0F          D.
           STD    <U001F                                                * 0526 DD 1F          ].
           LDD    #1                                                    * 0528 CC 00 01       L..
           STD    <U001B                                                * 052B DD 1B          ].
           LEAX   >Y00B9,Y                                              * 052D 30 A9 00 B9    0).9
           STX    <U00CA                                                * 0531 9F CA          .J
           LDX    <U0070                                                * 0533 9E 70          .p
           LDB    3,X                                                   * 0535 E6 03          f.
           CLRA                                                         * 0537 4F             O
           ANDB   #48                                                   * 0538 C4 30          D0
           STB    <U00B8                                                * 053A D7 B8          W8
           BEQ    L055A                                                 * 053C 27 1C          '.
           LDB    <U00B8                                                * 053E D6 B8          V8
           CLRA                                                         * 0540 4F             O
           ANDB   #16                                                   * 0541 C4 10          D.
           BEQ    L054A                                                 * 0543 27 05          '.
           LDD    #16                                                   * 0545 CC 00 10       L..
           BRA    L054D                                                 * 0548 20 03           .
L054A      LDD    #17                                                   * 054A CC 00 11       L..
L054D      STB    <U00B8                                                * 054D D7 B8          W8
           LDD    #2                                                    * 054F CC 00 02       L..
           STD    <U001B                                                * 0552 DD 1B          ].
           LEAX   >U00B8,Y                                              * 0554 30 A9 00 B8    0).8
           STX    <U00CA                                                * 0558 9F CA          .J
L055A      LDX    <U0070                                                * 055A 9E 70          .p
           LDB    2,X                                                   * 055C E6 02          f.
           STB    <Y00B9                                                * 055E D7 B9          W9
           CLRA                                                         * 0560 4F             O
           CLRB                                                         * 0561 5F             _
           STD    <U00BB                                                * 0562 DD BB          ];
           STB    <U00BA                                                * 0564 D7 BA          W:
           LDD    <U0062                                                * 0566 DC 62          \b
           STD    <U006A                                                * 0568 DD 6A          ]j
           LDD    <U001F                                                * 056A DC 1F          \.
           ASLB                                                         * 056C 58             X
           ROLA                                                         * 056D 49             I
           LDX    <U006E                                                * 056E 9E 6E          .n
           LEAX   D,X                                                   * 0570 30 8B          0.
           JSR    [,X]                                                  * 0572 AD 94          -.
           STD    -2,S                                                  * 0574 ED 7E          m~
           BNE    L057C                                                 * 0576 26 04          &.
L0578      CLRA                                                         * 0578 4F             O
           CLRB                                                         * 0579 5F             _
           BRA    L05C1                                                 * 057A 20 45           E
L057C      LDD    <U001B                                                * 057C DC 1B          \.
           PSHS   D                                                     * 057E 34 06          4.
           LDD    <U00CA                                                * 0580 DC CA          \J
           PSHS   D                                                     * 0582 34 06          4.
           LBSR   L2E3B                                                 * 0584 17 28 B4       .(4
           LEAS   4,S                                                   * 0587 32 64          2d
L0589      LDD    <U006A                                                * 0589 DC 6A          \j
           CMPD   <U0062                                                * 058B 10 93 62       ..b
           BNE    L0596                                                 * 058E 26 06          &.
           CLRA                                                         * 0590 4F             O
           CLRB                                                         * 0591 5F             _
           STD    <U006A                                                * 0592 DD 6A          ]j
           BRA    L05AD                                                 * 0594 20 17           .
L0596      LDD    <U006A                                                * 0596 DC 6A          \j
           BEQ    L05AD                                                 * 0598 27 13          '.
           LDB    [>U0062,Y]                                            * 059A E6 B9 00 62    f9.b
           BEQ    L05AD                                                 * 059E 27 0D          '.
           CLRA                                                         * 05A0 4F             O
           CLRB                                                         * 05A1 5F             _
           LDX    <U0062                                                * 05A2 9E 62          .b
           LEAX   1,X                                                   * 05A4 30 01          0.
           STX    <U0062                                                * 05A6 9F 62          .b
           STB    -1,X                                                  * 05A8 E7 1F          g.
           LBSR   L2229                                                 * 05AA 17 1C 7C       ..|
L05AD      LDD    #1                                                    * 05AD CC 00 01       L..
           BRA    L05C1                                                 * 05B0 20 0F           .
L05B2      LDD    <U0062                                                * 05B2 DC 62          \b
           STD    <U006C                                                * 05B4 DD 6C          ]l
           LEAX   >L07CC,PC                                             * 05B6 30 8D 02 12    0...
L05BA      PSHS   X                                                     * 05BA 34 10          4.
           LBSR   L074E                                                 * 05BC 17 01 8F       ...
           LEAS   2,S                                                   * 05BF 32 62          2b
L05C1      LEAS   3,S                                                   * 05C1 32 63          2c
           PULS   PC,U                                                  * 05C3 35 C0          5@
L05C5      PSHS   U                                                     * 05C5 34 40          4@
           LDD    <U003D                                                * 05C7 DC 3D          \=
           LBEQ   L0787                                                 * 05C9 10 27 01 BA    .'.:
           LDD    <U0003                                                * 05CD DC 03          \.
           ADDD   #-3                                                   * 05CF C3 FF FD       C.}
           CMPD   <U00C8                                                * 05D2 10 93 C8       ..H
           BGE    L05DA                                                 * 05D5 2C 03          ,.
           LBSR   L298C                                                 * 05D7 17 23 B2       .#2
L05DA      CLRA                                                         * 05DA 4F             O
           CLRB                                                         * 05DB 5F             _
           STD    <U003D                                                * 05DC DD 3D          ]=
           LDB    <U00C5                                                * 05DE D6 C5          VE
           BNE    L05F1                                                 * 05E0 26 0F          &.
           LDD    <U002F                                                * 05E2 DC 2F          \/
           PSHS   D                                                     * 05E4 34 06          4.
           LEAX   >L07D9,PC                                             * 05E6 30 8D 01 EF    0..o
           PSHS   X                                                     * 05EA 34 10          4.
           LBSR   L39FC                                                 * 05EC 17 34 0D       .4.
           LEAS   4,S                                                   * 05EF 32 64          2d
L05F1      LDD    <U0064                                                * 05F1 DC 64          \d
           BNE    L05FF                                                 * 05F3 26 0A          &.
           LDD    <U0066                                                * 05F5 DC 66          \f
           BNE    L05FF                                                 * 05F7 26 06          &.
           LDD    <U001B                                                * 05F9 DC 1B          \.
           LBLE   L0696                                                 * 05FB 10 2F 00 97    ./..
L05FF      LEAS   -2,S                                                  * 05FF 32 7E          2~
           LDU    <U00CA                                                * 0601 DE CA          ^J
           LDD    <U004F                                                * 0603 DC 4F          \O
           BEQ    L0618                                                 * 0605 27 11          '.
           LDD    [>U004F,Y]                                            * 0607 EC B9 00 4F    l9.O
           PSHS   D                                                     * 060B 34 06          4.
           LEAX   >L07DE,PC                                             * 060D 30 8D 01 CD    0..M
           PSHS   X                                                     * 0611 34 10          4.
           LBSR   L39FC                                                 * 0613 17 33 E6       .3f
           BRA    L0627                                                 * 0616 20 0F           .
L0618      LEAX   >Y0496,Y                                              * 0618 30 A9 04 96    0)..
           PSHS   X                                                     * 061C 34 10          4.
           LEAX   >L07E4,PC                                             * 061E 30 8D 01 C2    0..B
           PSHS   X                                                     * 0622 34 10          4.
           LBSR   L3992                                                 * 0624 17 33 6B       .3k
L0627      LEAS   4,S                                                   * 0627 32 64          2d
           LEAX   >Y0496,Y                                              * 0629 30 A9 04 96    0)..
           PSHS   X                                                     * 062D 34 10          4.
           LDD    <U00BD                                                * 062F DC BD          \=
           BEQ    L0638                                                 * 0631 27 05          '.
           LDD    #61                                                   * 0633 CC 00 3D       L.=
           BRA    L063B                                                 * 0636 20 03           .
L0638      LDD    #32                                                   * 0638 CC 00 20       L.
L063B      PSHS   D                                                     * 063B 34 06          4.
           LBSR   L40C2                                                 * 063D 17 3A 82       .:.
           LEAS   4,S                                                   * 0640 32 64          2d
           STU    -2,S                                                  * 0642 EF 7E          o~
           BEQ    L0683                                                 * 0644 27 3D          '=
           CLRA                                                         * 0646 4F             O
           CLRB                                                         * 0647 5F             _
           BRA    L0677                                                 * 0648 20 2D           -
L064A      LDD    ,S                                                    * 064A EC E4          ld
           CMPD   <U001B                                                * 064C 10 93 1B       ...
           BGE    L0661                                                 * 064F 2C 10          ,.
           LDB    ,U+                                                   * 0651 E6 C0          f@
           CLRA                                                         * 0653 4F             O
           PSHS   D                                                     * 0654 34 06          4.
           LEAX   >L07EA,PC                                             * 0656 30 8D 01 90    0...
           PSHS   X                                                     * 065A 34 10          4.
           LBSR   L39FC                                                 * 065C 17 33 9D       .3.
           BRA    L0670                                                 * 065F 20 0F           .
L0661      LEAX   >Y0496,Y                                              * 0661 30 A9 04 96    0)..
           PSHS   X                                                     * 0665 34 10          4.
           LEAX   >L07EF,PC                                             * 0667 30 8D 01 84    0...
           PSHS   X                                                     * 066B 34 10          4.
           LBSR   L3992                                                 * 066D 17 33 22       .3"
L0670      LEAS   4,S                                                   * 0670 32 64          2d
           LDD    ,S                                                    * 0672 EC E4          ld
           ADDD   #1                                                    * 0674 C3 00 01       C..
L0677      STD    ,S                                                    * 0677 ED E4          md
           LDD    ,S                                                    * 0679 EC E4          ld
           CMPD   #5                                                    * 067B 10 83 00 05    ....
           BLT    L064A                                                 * 067F 2D C9          -I
           BRA    L0694                                                 * 0681 20 11           .
L0683      LEAX   >Y0496,Y                                              * 0683 30 A9 04 96    0)..
           PSHS   X                                                     * 0687 34 10          4.
           LEAX   >L07F2,PC                                             * 0689 30 8D 01 65    0..e
           PSHS   X                                                     * 068D 34 10          4.
           LBSR   L3992                                                 * 068F 17 33 00       .3.
           LEAS   4,S                                                   * 0692 32 64          2d
L0694      LEAS   2,S                                                   * 0694 32 62          2b
L0696      LDD    <U0064                                                * 0696 DC 64          \d
           BNE    L06A0                                                 * 0698 26 06          &.
           LDD    <U0066                                                * 069A DC 66          \f
           LBEQ   L06FE                                                 * 069C 10 27 00 5E    .'.^
L06A0      LDD    <U0064                                                * 06A0 DC 64          \d
           BNE    L06AA                                                 * 06A2 26 06          &.
           LEAX   >L07FD,PC                                             * 06A4 30 8D 01 55    0..U
           STX    <U0064                                                * 06A8 9F 64          .d
L06AA      LDD    <U0066                                                * 06AA DC 66          \f
           BNE    L06B4                                                 * 06AC 26 06          &.
           LEAX   >L07FE,PC                                             * 06AE 30 8D 01 4C    0..L
           STX    <U0066                                                * 06B2 9F 66          .f
L06B4      LDD    <U006A                                                * 06B4 DC 6A          \j
           BNE    L06BE                                                 * 06B6 26 06          &.
           LEAX   >L07FF,PC                                             * 06B8 30 8D 01 43    0..C
           STX    <U006A                                                * 06BC 9F 6A          .j
L06BE      LDD    <U0066                                                * 06BE DC 66          \f
           PSHS   D                                                     * 06C0 34 06          4.
           LDD    <U0064                                                * 06C2 DC 64          \d
           PSHS   D                                                     * 06C4 34 06          4.
           LDD    <U00CE                                                * 06C6 DC CE          \N
           BEQ    L06D3                                                 * 06C8 27 09          '.
           LDD    <U00D6                                                * 06CA DC D6          \V
           BNE    L06D3                                                 * 06CC 26 05          &.
           LDD    #43                                                   * 06CE CC 00 2B       L.+
           BRA    L06D6                                                 * 06D1 20 03           .
L06D3      LDD    #32                                                   * 06D3 CC 00 20       L.
L06D6      PSHS   D                                                     * 06D6 34 06          4.
           LEAX   >L0800,PC                                             * 06D8 30 8D 01 24    0..$
           PSHS   X                                                     * 06DC 34 10          4.
           LBSR   L39FC                                                 * 06DE 17 33 1B       .3.
           LEAS   8,S                                                   * 06E1 32 68          2h
           LDD    <U006A                                                * 06E3 DC 6A          \j
           PSHS   D                                                     * 06E5 34 06          4.
           LDD    <U00D6                                                * 06E7 DC D6          \V
           BEQ    L06F1                                                 * 06E9 27 06          '.
           LEAX   >L080D,PC                                             * 06EB 30 8D 01 1E    0...
           BRA    L06F5                                                 * 06EF 20 04           .
L06F1      LEAX   >L0810,PC                                             * 06F1 30 8D 01 1B    0...
L06F5      TFR    X,D                                                   * 06F5 1F 10          ..
           PSHS   D                                                     * 06F7 34 06          4.
           LBSR   L39FC                                                 * 06F9 17 33 00       .3.
           LEAS   4,S                                                   * 06FC 32 64          2d
L06FE      LDD    <U006C                                                * 06FE DC 6C          \l
           BEQ    L0711                                                 * 0700 27 0F          '.
           LDD    <U006C                                                * 0702 DC 6C          \l
           PSHS   D                                                     * 0704 34 06          4.
           LEAX   >L0816,PC                                             * 0706 30 8D 01 0C    0...
           PSHS   X                                                     * 070A 34 10          4.
           LBSR   L39FC                                                 * 070C 17 32 ED       .2m
           LEAS   4,S                                                   * 070F 32 64          2d
L0711      LEAX   >Y0496,Y                                              * 0711 30 A9 04 96    0)..
           PSHS   X                                                     * 0715 34 10          4.
           LDD    #13                                                   * 0717 CC 00 0D       L..
           PSHS   D                                                     * 071A 34 06          4.
           LBSR   L40C2                                                 * 071C 17 39 A3       .9#
           LEAS   4,S                                                   * 071F 32 64          2d
           LDD    <U00C8                                                * 0721 DC C8          \H
           ADDD   #1                                                    * 0723 C3 00 01       C..
           STD    <U00C8                                                * 0726 DD C8          ]H
           PULS   PC,U                                                  * 0728 35 C0          5@

L072A      PSHS   U                                                     * 072A 34 40          4@
           LEAX   >L081A,PC                                             * 072C 30 8D 00 EA    0..j
           PSHS   X                                                     * 0730 34 10          4.
           BSR    L074E                                                 * 0732 8D 1A          ..
           PULS   PC,U,X                                                * 0734 35 D0          5P
L0736      PSHS   U                                                     * 0736 34 40          4@
           LEAX   >L082C,PC                                             * 0738 30 8D 00 F0    0..p
           PSHS   X                                                     * 073C 34 10          4.
           BSR    L074E                                                 * 073E 8D 0E          ..
           PULS   PC,U,X                                                * 0740 35 D0          5P

L0742      PSHS   U                                                     * 0742 34 40          4@
           LEAX   >L083E,PC                                             * 0744 30 8D 00 F6    0..v
           PSHS   X                                                     * 0748 34 10          4.
           BSR    L074E                                                 * 074A 8D 02          ..
           PULS   PC,U,X                                                * 074C 35 D0          5P
L074E      PSHS   U                                                     * 074E 34 40          4@
           LDB    <U005B                                                * 0750 D6 5B          V[
           BEQ    L0780                                                 * 0752 27 2C          ',
           LDD    #1                                                    * 0754 CC 00 01       L..
           STD    <U003D                                                * 0757 DD 3D          ]=
           LDD    <U00C8                                                * 0759 DC C8          \H
           BEQ    L0767                                                 * 075B 27 0A          '.
           LDD    <U0003                                                * 075D DC 03          \.
           ADDD   #-4                                                   * 075F C3 FF FC       C.|
           CMPD   <U00C8                                                * 0762 10 93 C8       ..H
           BGE    L076A                                                 * 0765 2C 03          ,.
L0767      LBSR   L298C                                                 * 0767 17 22 22       .""
L076A      LDD    4,S                                                   * 076A EC 64          ld
           PSHS   D                                                     * 076C 34 06          4.
           LEAX   >L0857,PC                                             * 076E 30 8D 00 E5    0..e
           PSHS   X                                                     * 0772 34 10          4.
           LBSR   L39FC                                                 * 0774 17 32 85       .2.
           LEAS   4,S                                                   * 0777 32 64          2d
           LDD    <U00C8                                                * 0779 DC C8          \H
           ADDD   #1                                                    * 077B C3 00 01       C..
           STD    <U00C8                                                * 077E DD C8          ]H
L0780      LDD    <U0023                                                * 0780 DC 23          \#
           ADDD   #1                                                    * 0782 C3 00 01       C..
           STD    <U0023                                                * 0785 DD 23          ]#
L0787      CLRA                                                         * 0787 4F             O
           CLRB                                                         * 0788 5F             _
           PULS   PC,U                                                  * 0789 35 C0          5@
L078B      PSHS   U                                                     * 078B 34 40          4@
           LDD    4,S                                                   * 078D EC 64          ld
           PSHS   D                                                     * 078F 34 06          4.
           LEAX   >L086B,PC                                             * 0791 30 8D 00 D6    0..V
           PSHS   X                                                     * 0795 34 10          4.
           LEAX   >Y04A3,Y                                              * 0797 30 A9 04 A3    0).#
           PSHS   X                                                     * 079B 34 10          4.
           LBSR   L3A0E                                                 * 079D 17 32 6E       .2n
           LEAS   6,S                                                   * 07A0 32 66          2f
           LDD    >errno,Y                                              * 07A2 EC A9 05 A7    l).'
           PSHS   D                                                     * 07A6 34 06          4.
           LBSR   exit                                                  * 07A8 17 42 65       .Be
           PULS   PC,U,X                                                * 07AB 35 D0          5P
L07AD      FCB    $77                                                   * 07AD 77             w
           FCB    $00                                                   * 07AE 00             .
L07AF      FCB    $72                                                   * 07AF 72             r
           FCB    $00                                                   * 07B0 00             .
L07B1      FCC    "file close error"                                    * 07B1 66 69 6C 65 20 63 6C 6F 73 65 20 65 72 72 6F 72 file close error
           FCB    $00                                                   * 07C1 00             .
L07C2      FCC    "bad label"                                           * 07C2 62 61 64 20 6C 61 62 65 6C bad label
           FCB    $00                                                   * 07CB 00             .
L07CC      FCC    "bad mnemonic"                                        * 07CC 62 61 64 20 6D 6E 65 6D 6F 6E 69 63 bad mnemonic
           FCB    $00                                                   * 07D8 00             .
L07D9      FCC    "%05d"                                                * 07D9 25 30 35 64    %05d
           FCB    $00                                                   * 07DD 00             .
L07DE      FCC    " %04x"                                               * 07DE 20 25 30 34 78  %04x
           FCB    $00                                                   * 07E3 00             .
L07E4      FCC    "     "                                               * 07E4 20 20 20 20 20
           FCB    $00                                                   * 07E9 00             .
L07EA      FCC    "%02x"                                                * 07EA 25 30 32 78    %02x
           FCB    $00                                                   * 07EE 00             .
L07EF      FCC    "  "                                                  * 07EF 20 20
           FCB    $00                                                   * 07F1 00             .
L07F2      FCC    "          "                                          * 07F2 20 20 20 20 20 20 20 20 20 20
           FCB    $00                                                   * 07FC 00             .
L07FD      FCB    $00                                                   * 07FD 00             .
L07FE      FCB    $00                                                   * 07FE 00             .
L07FF      FCB    $00                                                   * 07FF 00             .
L0800      FCC    "%c%-8s %-5s "                                        * 0800 25 63 25 2D 38 73 20 25 2D 35 73 20 %c%-8s %-5s
           FCB    $00                                                   * 080C 00             .
L080D      FCC    "%s"                                                  * 080D 25 73          %s
           FCB    $00                                                   * 080F 00             .
L0810      FCC    "%-10s"                                               * 0810 25 2D 31 30 73 %-10s
           FCB    $00                                                   * 0815 00             .
L0816      FCC    " %s"                                                 * 0816 20 25 73        %s
           FCB    $00                                                   * 0819 00             .
L081A      FCC    "bad register list"                                   * 081A 62 61 64 20 72 65 67 69 73 74 65 72 20 6C 69 73 74 bad register list
           FCB    $00                                                   * 082B 00             .
L082C      FCC    "bad register name"                                   * 082C 62 61 64 20 72 65 67 69 73 74 65 72 20 6E 61 6D 65 bad register name
           FCB    $00                                                   * 083D 00             .
L083E      FCC    "nested MACRO definitions"                            * 083E 6E 65 73 74 65 64 20 4D 41 43 52 4F 20 64 65 66 69 6E 69 74 69 6F 6E 73 nested MACRO definitions
           FCB    $00                                                   * 0856 00             .
L0857      FCC    "*** error - %s ***"                                  * 0857 2A 2A 2A 20 65 72 72 6F 72 20 2D 20 25 73 20 2A 2A 2A *** error - %s ***
           FCB    $0D                                                   * 0869 0D             .
           FCB    $00                                                   * 086A 00             .
L086B      FCC    "asm: %s"                                             * 086B 61 73 6D 3A 20 25 73 asm: %s
           FCB    $0D                                                   * 0872 0D             .
           FCB    $00                                                   * 0873 00             .
L0874      PSHS   U,D                                                   * 0874 34 46          4F
           LEAU   >Y06B7,Y                                              * 0876 33 A9 06 B7    3).7
           BRA    L08A4                                                 * 087A 20 28           (
L087C      LDB    [<$06,S]                                              * 087C E6 F8 06       fx.
           SEX                                                          * 087F 1D             .
           LEAX   >Y03FC,Y                                              * 0880 30 A9 03 FC    0).|
           LEAX   D,X                                                   * 0884 30 8B          0.
           LDB    ,X                                                    * 0886 E6 84          f.
           CLRA                                                         * 0888 4F             O
           ANDB   #4                                                    * 0889 C4 04          D.
           BEQ    L0893                                                 * 088B 27 06          '.
           LDB    [<$06,S]                                              * 088D E6 F8 06       fx.
           SEX                                                          * 0890 1D             .
           BRA    L0899                                                 * 0891 20 06           .
L0893      LDB    [<$06,S]                                              * 0893 E6 F8 06       fx.
           SEX                                                          * 0896 1D             .
           ORB    #32                                                   * 0897 CA 20          J
L0899      STB    ,U                                                    * 0899 E7 C4          gD
           LEAU   1,U                                                   * 089B 33 41          3A
           LDD    6,S                                                   * 089D EC 66          lf
           ADDD   #1                                                    * 089F C3 00 01       C..
           STD    6,S                                                   * 08A2 ED 66          mf
L08A4      LDB    [<$06,S]                                              * 08A4 E6 F8 06       fx.
           BNE    L087C                                                 * 08A7 26 D3          &S
           CLRA                                                         * 08A9 4F             O
           CLRB                                                         * 08AA 5F             _
           STB    ,U                                                    * 08AB E7 C4          gD
           LDD    8,S                                                   * 08AD EC 68          lh
           BRA    L08E1                                                 * 08AF 20 30           0
L08B1      LDU    [,S]                                                  * 08B1 EE F4          nt
           LEAX   >Y06B7,Y                                              * 08B3 30 A9 06 B7    0).7
           STX    <U0068                                                * 08B7 9F 68          .h
           BRA    L08D0                                                 * 08B9 20 15           .
L08BB      LDB    ,U                                                    * 08BB E6 C4          fD
           SEX                                                          * 08BD 1D             .
           PSHS   D                                                     * 08BE 34 06          4.
           LDX    <U0068                                                * 08C0 9E 68          .h
           LEAX   1,X                                                   * 08C2 30 01          0.
           STX    <U0068                                                * 08C4 9F 68          .h
           LDB    -1,X                                                  * 08C6 E6 1F          f.
           SEX                                                          * 08C8 1D             .
           CMPD   ,S++                                                  * 08C9 10 A3 E1       .#a
           BNE    L08D4                                                 * 08CC 26 06          &.
           LEAU   1,U                                                   * 08CE 33 41          3A
L08D0      LDB    ,U                                                    * 08D0 E6 C4          fD
           BNE    L08BB                                                 * 08D2 26 E7          &g
L08D4      LDB    ,U                                                    * 08D4 E6 C4          fD
           BNE    L08DC                                                 * 08D6 26 04          &.
           LDD    ,S                                                    * 08D8 EC E4          ld
           PULS   PC,U,X                                                * 08DA 35 D0          5P
L08DC      LDD    ,S                                                    * 08DC EC E4          ld
           ADDD   #4                                                    * 08DE C3 00 04       C..
L08E1      STD    ,S                                                    * 08E1 ED E4          md
           LDD    ,S                                                    * 08E3 EC E4          ld
           CMPD   10,S                                                  * 08E5 10 A3 6A       .#j
           BCS    L08B1                                                 * 08E8 25 C7          %G
           CLRA                                                         * 08EA 4F             O
           CLRB                                                         * 08EB 5F             _
           PULS   PC,U,X                                                * 08EC 35 D0          5P
           FCC    "psect"                                               * 08EE 70 73 65 63 74 psect
           FCB    $00                                                   * 08F3 00             .
           FCC    "csect"                                               * 08F4 63 73 65 63 74 csect
           FCB    $00                                                   * 08F9 00             .
           FCC    "vsect"                                               * 08FA 76 73 65 63 74 vsect
           FCB    $00                                                   * 08FF 00             .
           FCC    "end"                                                 * 0900 65 6E 64       end
           FCB    $00                                                   * 0903 00             .
           FCC    "lbra"                                                * 0904 6C 62 72 61    lbra
           FCB    $00                                                   * 0908 00             .
           FCC    "lbsr"                                                * 0909 6C 62 73 72    lbsr
           FCB    $00                                                   * 090D 00             .
           FCC    "orcc"                                                * 090E 6F 72 63 63    orcc
           FCB    $00                                                   * 0912 00             .
           FCC    "andcc"                                               * 0913 61 6E 64 63 63 andcc
           FCB    $00                                                   * 0918 00             .
           FCC    "cwai"                                                * 0919 63 77 61 69    cwai
           FCB    $00                                                   * 091D 00             .
           FCC    "addd"                                                * 091E 61 64 64 64    addd
           FCB    $00                                                   * 0922 00             .
           FCC    "subd"                                                * 0923 73 75 62 64    subd
           FCB    $00                                                   * 0927 00             .
           FCC    "ldd"                                                 * 0928 6C 64 64       ldd
           FCB    $00                                                   * 092B 00             .
           FCC    "ldx"                                                 * 092C 6C 64 78       ldx
           FCB    $00                                                   * 092F 00             .
           FCC    "ldu"                                                 * 0930 6C 64 75       ldu
           FCB    $00                                                   * 0933 00             .
           FCC    "cmpx"                                                * 0934 63 6D 70 78    cmpx
           FCB    $00                                                   * 0938 00             .
           FCC    "jsr"                                                 * 0939 6A 73 72       jsr
           FCB    $00                                                   * 093C 00             .
           FCC    "std"                                                 * 093D 73 74 64       std
           FCB    $00                                                   * 0940 00             .
           FCC    "stx"                                                 * 0941 73 74 78       stx
           FCB    $00                                                   * 0944 00             .
           FCC    "stu"                                                 * 0945 73 74 75       stu
           FCB    $00                                                   * 0948 00             .
           FCC    "cmpu"                                                * 0949 63 6D 70 75    cmpu
           FCB    $00                                                   * 094D 00             .
           FCC    "cmps"                                                * 094E 63 6D 70 73    cmps
           FCB    $00                                                   * 0952 00             .
           FCC    "cmpd"                                                * 0953 63 6D 70 64    cmpd
           FCB    $00                                                   * 0957 00             .
           FCC    "cmpy"                                                * 0958 63 6D 70 79    cmpy
           FCB    $00                                                   * 095C 00             .
           FCC    "ldy"                                                 * 095D 6C 64 79       ldy
           FCB    $00                                                   * 0960 00             .
           FCC    "lds"                                                 * 0961 6C 64 73       lds
           FCB    $00                                                   * 0964 00             .
           FCC    "sty"                                                 * 0965 73 74 79       sty
           FCB    $00                                                   * 0968 00             .
           FCC    "sts"                                                 * 0969 73 74 73       sts
           FCB    $00                                                   * 096C 00             .
           FCC    "add"                                                 * 096D 61 64 64       add
           FCB    $00                                                   * 0970 00             .
           FCC    "cmp"                                                 * 0971 63 6D 70       cmp
           FCB    $00                                                   * 0974 00             .
           FCC    "sub"                                                 * 0975 73 75 62       sub
           FCB    $00                                                   * 0978 00             .
           FCC    "sbc"                                                 * 0979 73 62 63       sbc
           FCB    $00                                                   * 097C 00             .
           FCC    "and"                                                 * 097D 61 6E 64       and
           FCB    $00                                                   * 0980 00             .
           FCC    "bit"                                                 * 0981 62 69 74       bit
           FCB    $00                                                   * 0984 00             .
           FCC    "ld"                                                  * 0985 6C 64          ld
           FCB    $00                                                   * 0987 00             .
           FCC    "st"                                                  * 0988 73 74          st
           FCB    $00                                                   * 098A 00             .
           FCC    "eor"                                                 * 098B 65 6F 72       eor
           FCB    $00                                                   * 098E 00             .
           FCC    "adc"                                                 * 098F 61 64 63       adc
           FCB    $00                                                   * 0992 00             .
           FCC    "org"                                                 * 0993 6F 72 67       org
           FCB    $00                                                   * 0996 00             .
           FCC    "or"                                                  * 0997 6F 72          or
           FCB    $00                                                   * 0999 00             .
           FCC    "neg"                                                 * 099A 6E 65 67       neg
           FCB    $00                                                   * 099D 00             .
           FCC    "com"                                                 * 099E 63 6F 6D       com
           FCB    $00                                                   * 09A1 00             .
           FCC    "lsr"                                                 * 09A2 6C 73 72       lsr
           FCB    $00                                                   * 09A5 00             .
           FCC    "ror"                                                 * 09A6 72 6F 72       ror
           FCB    $00                                                   * 09A9 00             .
           FCC    "asr"                                                 * 09AA 61 73 72       asr
           FCB    $00                                                   * 09AD 00             .
           FCC    "lsl"                                                 * 09AE 6C 73 6C       lsl
           FCB    $00                                                   * 09B1 00             .
           FCC    "asl"                                                 * 09B2 61 73 6C       asl
           FCB    $00                                                   * 09B5 00             .
           FCC    "rol"                                                 * 09B6 72 6F 6C       rol
           FCB    $00                                                   * 09B9 00             .
           FCC    "dec"                                                 * 09BA 64 65 63       dec
           FCB    $00                                                   * 09BD 00             .
           FCC    "inc"                                                 * 09BE 69 6E 63       inc
           FCB    $00                                                   * 09C1 00             .
           FCC    "tst"                                                 * 09C2 74 73 74       tst
           FCB    $00                                                   * 09C5 00             .
           FCC    "jmp"                                                 * 09C6 6A 6D 70       jmp
           FCB    $00                                                   * 09C9 00             .
           FCC    "clr"                                                 * 09CA 63 6C 72       clr
           FCB    $00                                                   * 09CD 00             .
           FCC    "rts"                                                 * 09CE 72 74 73       rts
           FCB    $00                                                   * 09D1 00             .
           FCC    "mul"                                                 * 09D2 6D 75 6C       mul
           FCB    $00                                                   * 09D5 00             .
           FCC    "nop"                                                 * 09D6 6E 6F 70       nop
           FCB    $00                                                   * 09D9 00             .
           FCC    "sync"                                                * 09DA 73 79 6E 63    sync
           FCB    $00                                                   * 09DE 00             .
           FCC    "daa"                                                 * 09DF 64 61 61       daa
           FCB    $00                                                   * 09E2 00             .
           FCC    "sex"                                                 * 09E3 73 65 78       sex
           FCB    $00                                                   * 09E6 00             .
           FCC    "abx"                                                 * 09E7 61 62 78       abx
           FCB    $00                                                   * 09EA 00             .
           FCC    "rti"                                                 * 09EB 72 74 69       rti
           FCB    $00                                                   * 09EE 00             .
           FCC    "swi2"                                                * 09EF 73 77 69 32    swi2
           FCB    $00                                                   * 09F3 00             .
           FCC    "swi3"                                                * 09F4 73 77 69 33    swi3
           FCB    $00                                                   * 09F8 00             .
           FCC    "swi"                                                 * 09F9 73 77 69       swi
           FCB    $00                                                   * 09FC 00             .
           FCC    "leax"                                                * 09FD 6C 65 61 78    leax
           FCB    $00                                                   * 0A01 00             .
           FCC    "leay"                                                * 0A02 6C 65 61 79    leay
           FCB    $00                                                   * 0A06 00             .
           FCC    "leas"                                                * 0A07 6C 65 61 73    leas
           FCB    $00                                                   * 0A0B 00             .
           FCC    "leau"                                                * 0A0C 6C 65 61 75    leau
           FCB    $00                                                   * 0A10 00             .
           FCC    "tfr"                                                 * 0A11 74 66 72       tfr
           FCB    $00                                                   * 0A14 00             .
           FCC    "exg"                                                 * 0A15 65 78 67       exg
           FCB    $00                                                   * 0A18 00             .
           FCC    "pshs"                                                * 0A19 70 73 68 73    pshs
           FCB    $00                                                   * 0A1D 00             .
           FCC    "puls"                                                * 0A1E 70 75 6C 73    puls
           FCB    $00                                                   * 0A22 00             .
           FCC    "pshu"                                                * 0A23 70 73 68 75    pshu
           FCB    $00                                                   * 0A27 00             .
           FCC    "pulu"                                                * 0A28 70 75 6C 75    pulu
           FCB    $00                                                   * 0A2C 00             .
           FCC    "lb"                                                  * 0A2D 6C 62          lb
           FCB    $00                                                   * 0A2F 00             .
           FCC    "fcc"                                                 * 0A30 66 63 63       fcc
           FCB    $00                                                   * 0A33 00             .
           FCC    "fdb"                                                 * 0A34 66 64 62       fdb
           FCB    $00                                                   * 0A37 00             .
           FCC    "fcs"                                                 * 0A38 66 63 73       fcs
           FCB    $00                                                   * 0A3B 00             .
           FCC    "fcb"                                                 * 0A3C 66 63 62       fcb
           FCB    $00                                                   * 0A3F 00             .
           FCC    "rzb"                                                 * 0A40 72 7A 62       rzb
           FCB    $00                                                   * 0A43 00             .
           FCC    "vsect"                                               * 0A44 76 73 65 63 74 vsect
           FCB    $00                                                   * 0A49 00             .
           FCC    "csect"                                               * 0A4A 63 73 65 63 74 csect
           FCB    $00                                                   * 0A4F 00             .
           FCC    "ends"                                                * 0A50 65 6E 64 73    ends
           FCB    $00                                                   * 0A54 00             .
           FCC    "setdp"                                               * 0A55 73 65 74 64 70 setdp
           FCB    $00                                                   * 0A5A 00             .
           FCC    "os9"                                                 * 0A5B 6F 73 39       os9
           FCB    $00                                                   * 0A5E 00             .
           FCC    "rmb"                                                 * 0A5F 72 6D 62       rmb
           FCB    $00                                                   * 0A62 00             .
           FCC    "ends"                                                * 0A63 65 6E 64 73    ends
           FCB    $00                                                   * 0A67 00             .
           FCC    "rmb"                                                 * 0A68 72 6D 62       rmb
           FCB    $00                                                   * 0A6B 00             .
           FCC    "fcc"                                                 * 0A6C 66 63 63       fcc
           FCB    $00                                                   * 0A6F 00             .
           FCC    "fdb"                                                 * 0A70 66 64 62       fdb
           FCB    $00                                                   * 0A73 00             .
           FCC    "fcs"                                                 * 0A74 66 63 73       fcs
           FCB    $00                                                   * 0A77 00             .
           FCC    "fcb"                                                 * 0A78 66 63 62       fcb
           FCB    $00                                                   * 0A7B 00             .
           FCC    "rzb"                                                 * 0A7C 72 7A 62       rzb
           FCB    $00                                                   * 0A7F 00             .
           FCC    "ends"                                                * 0A80 65 6E 64 73    ends
           FCB    $00                                                   * 0A84 00             .
           FCC    "rmb"                                                 * 0A85 72 6D 62       rmb
           FCB    $00                                                   * 0A88 00             .
           FCC    "ends"                                                * 0A89 65 6E 64 73    ends
           FCB    $00                                                   * 0A8D 00             .
           FCC    "nam"                                                 * 0A8E 6E 61 6D       nam
           FCB    $00                                                   * 0A91 00             .
           FCC    "opt"                                                 * 0A92 6F 70 74       opt
           FCB    $00                                                   * 0A95 00             .
           FCC    "ttl"                                                 * 0A96 74 74 6C       ttl
           FCB    $00                                                   * 0A99 00             .
           FCC    "pag"                                                 * 0A9A 70 61 67       pag
           FCB    $00                                                   * 0A9D 00             .
           FCC    "spc"                                                 * 0A9E 73 70 63       spc
           FCB    $00                                                   * 0AA1 00             .
           FCC    "use"                                                 * 0AA2 75 73 65       use
           FCB    $00                                                   * 0AA5 00             .
           FCC    "fail"                                                * 0AA6 66 61 69 6C    fail
           FCB    $00                                                   * 0AAA 00             .
           FCC    "rept"                                                * 0AAB 72 65 70 74    rept
           FCB    $00                                                   * 0AAF 00             .
           FCC    "endr"                                                * 0AB0 65 6E 64 72    endr
           FCB    $00                                                   * 0AB4 00             .
           FCC    "ifeq"                                                * 0AB5 69 66 65 71    ifeq
           FCB    $00                                                   * 0AB9 00             .
           FCC    "ifne"                                                * 0ABA 69 66 6E 65    ifne
           FCB    $00                                                   * 0ABE 00             .
           FCC    "iflt"                                                * 0ABF 69 66 6C 74    iflt
           FCB    $00                                                   * 0AC3 00             .
           FCC    "ifle"                                                * 0AC4 69 66 6C 65    ifle
           FCB    $00                                                   * 0AC8 00             .
           FCC    "ifge"                                                * 0AC9 69 66 67 65    ifge
           FCB    $00                                                   * 0ACD 00             .
           FCC    "ifgt"                                                * 0ACE 69 66 67 74    ifgt
           FCB    $00                                                   * 0AD2 00             .
           FCC    "ifp1"                                                * 0AD3 69 66 70 31    ifp1
           FCB    $00                                                   * 0AD7 00             .
           FCC    "endc"                                                * 0AD8 65 6E 64 63    endc
           FCB    $00                                                   * 0ADC 00             .
           FCC    "else"                                                * 0ADD 65 6C 73 65    else
           FCB    $00                                                   * 0AE1 00             .
           FCC    "equ"                                                 * 0AE2 65 71 75       equ
           FCB    $00                                                   * 0AE5 00             .
           FCC    "set"                                                 * 0AE6 73 65 74       set
           FCB    $00                                                   * 0AE9 00             .
           FCC    "macro"                                               * 0AEA 6D 61 63 72 6F macro
           FCB    $00                                                   * 0AEF 00             .
           FCC    "endm"                                                * 0AF0 65 6E 64 6D    endm
           FCB    $00                                                   * 0AF4 00             .
           FCC    "bsr"                                                 * 0AF5 62 73 72       bsr
           FCB    $00                                                   * 0AF8 00             .
           FCC    "bra"                                                 * 0AF9 62 72 61       bra
           FCB    $00                                                   * 0AFC 00             .
           FCC    "brn"                                                 * 0AFD 62 72 6E       brn
           FCB    $00                                                   * 0B00 00             .
           FCC    "bhi"                                                 * 0B01 62 68 69       bhi
           FCB    $00                                                   * 0B04 00             .
           FCC    "bls"                                                 * 0B05 62 6C 73       bls
           FCB    $00                                                   * 0B08 00             .
           FCC    "bhs"                                                 * 0B09 62 68 73       bhs
           FCB    $00                                                   * 0B0C 00             .
           FCC    "bcc"                                                 * 0B0D 62 63 63       bcc
           FCB    $00                                                   * 0B10 00             .
           FCC    "blo"                                                 * 0B11 62 6C 6F       blo
           FCB    $00                                                   * 0B14 00             .
           FCC    "bcs"                                                 * 0B15 62 63 73       bcs
           FCB    $00                                                   * 0B18 00             .
           FCC    "bne"                                                 * 0B19 62 6E 65       bne
           FCB    $00                                                   * 0B1C 00             .
           FCC    "beq"                                                 * 0B1D 62 65 71       beq
           FCB    $00                                                   * 0B20 00             .
           FCC    "bvc"                                                 * 0B21 62 76 63       bvc
           FCB    $00                                                   * 0B24 00             .
           FCC    "bvs"                                                 * 0B25 62 76 73       bvs
           FCB    $00                                                   * 0B28 00             .
           FCC    "bpl"                                                 * 0B29 62 70 6C       bpl
           FCB    $00                                                   * 0B2C 00             .
           FCC    "bmi"                                                 * 0B2D 62 6D 69       bmi
           FCB    $00                                                   * 0B30 00             .
           FCC    "bge"                                                 * 0B31 62 67 65       bge
           FCB    $00                                                   * 0B34 00             .
           FCC    "blt"                                                 * 0B35 62 6C 74       blt
           FCB    $00                                                   * 0B38 00             .
           FCC    "bgt"                                                 * 0B39 62 67 74       bgt
           FCB    $00                                                   * 0B3C 00             .
           FCC    "ble"                                                 * 0B3D 62 6C 65       ble
           FCB    $00                                                   * 0B40 00             .

           PSHS   U                                                     * 0B41 34 40          4@
           LDD    #3                                                    * 0B43 CC 00 03       L..
           STD    <U001B                                                * 0B46 DD 1B          ].
           LBRA   L0CF6                                                 * 0B48 16 01 AB       ..+
           PSHS   U                                                     * 0B4B 34 40          4@
           LDD    #2                                                    * 0B4D CC 00 02       L..
           STD    <U001B                                                * 0B50 DD 1B          ].
           LBSR   L100E                                                 * 0B52 17 04 B9       ..9
           STD    -2,S                                                  * 0B55 ED 7E          m~
           LBEQ   L0C27                                                 * 0B57 10 27 00 CC    .'.L
           LDB    <U0061                                                * 0B5B D6 61          Va
           SEX                                                          * 0B5D 1D             .
           ORB    #8                                                    * 0B5E CA 08          J.
           STB    <U0061                                                * 0B60 D7 61          Wa
           LBSR   L23D4                                                 * 0B62 17 18 6F       ..o
           LDD    <U0031                                                * 0B65 DC 31          \1
           STB    <U00BA                                                * 0B67 D7 BA          W:
           LBRA   L0F25                                                 * 0B69 16 03 B9       ..9
           PSHS   U                                                     * 0B6C 34 40          4@
           LBSR   L100E                                                 * 0B6E 17 04 9D       ...
           STD    -2,S                                                  * 0B71 ED 7E          m~
           BEQ    L0BB8                                                 * 0B73 27 43          'C
           LDD    <U001B                                                * 0B75 DC 1B          \.
           ADDD   #2                                                    * 0B77 C3 00 02       C..
           STD    <U001B                                                * 0B7A DD 1B          ].
           LBSR   L23B8                                                 * 0B7C 17 18 39       ..9
           LDD    <U0031                                                * 0B7F DC 31          \1
           STD    <U00BA                                                * 0B81 DD BA          ]:
           BRA    L0BB3                                                 * 0B83 20 2E           .
           PSHS   U                                                     * 0B85 34 40          4@
           LDB    [>U0068,Y]                                            * 0B87 E6 B9 00 68    f9.h
           SEX                                                          * 0B8B 1D             .
           TFR    D,X                                                   * 0B8C 1F 01          ..
           BRA    L0BBD                                                 * 0B8E 20 2D           -
L0B90      LDB    <Y00B9                                                * 0B90 D6 B9          V9
           SEX                                                          * 0B92 1D             .
           ORB    #64                                                   * 0B93 CA 40          J@
           STB    <Y00B9                                                * 0B95 D7 B9          W9
L0B97      LBSR   L100E                                                 * 0B97 17 04 74       ..t
           STD    -2,S                                                  * 0B9A ED 7E          m~
           BEQ    L0BB8                                                 * 0B9C 27 1A          '.
           LDD    <U001B                                                * 0B9E DC 1B          \.
           ADDD   #1                                                    * 0BA0 C3 00 01       C..
           STD    <U001B                                                * 0BA3 DD 1B          ].
           LDB    <U0061                                                * 0BA5 D6 61          Va
           SEX                                                          * 0BA7 1D             .
           ORB    #8                                                    * 0BA8 CA 08          J.
           STB    <U0061                                                * 0BAA D7 61          Wa
           LBSR   L23D4                                                 * 0BAC 17 18 25       ..%
           LDD    <U0031                                                * 0BAF DC 31          \1
           STB    <U00BA                                                * 0BB1 D7 BA          W:
L0BB3      LBSR   L1023                                                 * 0BB3 17 04 6D       ..m
           PULS   PC,U                                                  * 0BB6 35 C0          5@
L0BB8      LBSR   L1118                                                 * 0BB8 17 05 5D       ..]
           PULS   PC,U                                                  * 0BBB 35 C0          5@
L0BBD      CMPX   #98                                                   * 0BBD 8C 00 62       ..b
           BEQ    L0B90                                                 * 0BC0 27 CE          'N
           CMPX   #97                                                   * 0BC2 8C 00 61       ..a
           BEQ    L0B97                                                 * 0BC5 27 D0          'P
           BRA    L0BE7                                                 * 0BC7 20 1E           .
           PSHS   U                                                     * 0BC9 34 40          4@
           LDB    <Y00B9                                                * 0BCB D6 B9          V9
           CMPB   #14                                                   * 0BCD C1 0E          A.
           BEQ    L0BF8                                                 * 0BCF 27 27          ''
           LDB    [>U0068,Y]                                            * 0BD1 E6 B9 00 68    f9.h
           BEQ    L0BF8                                                 * 0BD5 27 21          '!
           LDB    [>U0068,Y]                                            * 0BD7 E6 B9 00 68    f9.h
           SEX                                                          * 0BDB 1D             .
           TFR    D,X                                                   * 0BDC 1F 01          ..
           BRA    L0BEC                                                 * 0BDE 20 0C           .
L0BE0      LDB    <Y00B9                                                * 0BE0 D6 B9          V9
           SEX                                                          * 0BE2 1D             .
           ORB    #80                                                   * 0BE3 CA 50          JP
           BRA    L0C0F                                                 * 0BE5 20 28           (
L0BE7      LBSR   L0736                                                 * 0BE7 17 FB 4C       .{L
           PULS   PC,U                                                  * 0BEA 35 C0          5@
L0BEC      CMPX   #97                                                   * 0BEC 8C 00 61       ..a
           BEQ    L0C0A                                                 * 0BEF 27 19          '.
           CMPX   #98                                                   * 0BF1 8C 00 62       ..b
           BEQ    L0BE0                                                 * 0BF4 27 EA          'j
           BRA    L0BE7                                                 * 0BF6 20 EF           o
L0BF8      LBSR   L1118                                                 * 0BF8 17 05 1D       ...
           STD    -2,S                                                  * 0BFB ED 7E          m~
           LBEQ   L0EE4                                                 * 0BFD 10 27 02 E3    .'.c
           LDB    <Y00B9                                                * 0C01 D6 B9          V9
           CLRA                                                         * 0C03 4F             O
           ANDB   #240                                                  * 0C04 C4 F0          Dp
           LBEQ   L0F25                                                 * 0C06 10 27 03 1B    .'..
L0C0A      LDB    <Y00B9                                                * 0C0A D6 B9          V9
           SEX                                                          * 0C0C 1D             .
           ORB    #64                                                   * 0C0D CA 40          J@
L0C0F      STB    <Y00B9                                                * 0C0F D7 B9          W9
           LBRA   L0F25                                                 * 0C11 16 03 11       ...
           PSHS   U                                                     * 0C14 34 40          4@
           LBRA   L0F25                                                 * 0C16 16 03 0C       ...
           PSHS   U                                                     * 0C19 34 40          4@
           LBSR   L1118                                                 * 0C1B 17 04 FA       ..z
           STD    -2,S                                                  * 0C1E ED 7E          m~
           BEQ    L0C27                                                 * 0C20 27 05          '.
           LDD    #1                                                    * 0C22 CC 00 01       L..
           BRA    L0C2A                                                 * 0C25 20 03           .
L0C27      LBSR   L12F8                                                 * 0C27 17 06 CE       ..N
L0C2A      PULS   PC,U                                                  * 0C2A 35 C0          5@
           PSHS   U,X,D                                                 * 0C2C 34 56          4V
           LDD    #2                                                    * 0C2E CC 00 02       L..
           STD    <U001B                                                * 0C31 DD 1B          ].
           CLRA                                                         * 0C33 4F             O
           CLRB                                                         * 0C34 5F             _
           PSHS   D                                                     * 0C35 34 06          4.
           LBSR   L1070                                                 * 0C37 17 04 36       ..6
           LEAS   2,S                                                   * 0C3A 32 62          2b
           STD    2,S                                                   * 0C3C ED 62          mb
           LBEQ   L0C8B                                                 * 0C3E 10 27 00 49    .'.I
           LDB    [>U0062,Y]                                            * 0C42 E6 B9 00 62    f9.b
           CMPB   #44                                                   * 0C46 C1 2C          A,
           BNE    L0C8B                                                 * 0C48 26 41          &A
           LDD    <U0062                                                * 0C4A DC 62          \b
           ADDD   #1                                                    * 0C4C C3 00 01       C..
           STD    <U0062                                                * 0C4F DD 62          ]b
           CLRA                                                         * 0C51 4F             O
           CLRB                                                         * 0C52 5F             _
           PSHS   D                                                     * 0C53 34 06          4.
           LBSR   L1070                                                 * 0C55 17 04 18       ...
           LEAS   2,S                                                   * 0C58 32 62          2b
           STD    ,S                                                    * 0C5A ED E4          md
           BEQ    L0C8B                                                 * 0C5C 27 2D          '-
           LDD    2,S                                                   * 0C5E EC 62          lb
           EORA   ,S                                                    * 0C60 A8 E4          (d
           EORB   1,S                                                   * 0C62 E8 61          ha
           CLRA                                                         * 0C64 4F             O
           ANDB   #8                                                    * 0C65 C4 08          D.
           BNE    L0C7E                                                 * 0C67 26 15          &.
           LDD    2,S                                                   * 0C69 EC 62          lb
           ASLB                                                         * 0C6B 58             X
           ROLA                                                         * 0C6C 49             I
           ASLB                                                         * 0C6D 58             X
           ROLA                                                         * 0C6E 49             I
           ASLB                                                         * 0C6F 58             X
           ROLA                                                         * 0C70 49             I
           ASLB                                                         * 0C71 58             X
           ROLA                                                         * 0C72 49             I
           ORA    ,S                                                    * 0C73 AA E4          *d
           ORB    1,S                                                   * 0C75 EA 61          ja
           STB    <U00BA                                                * 0C77 D7 BA          W:
           LDD    #1                                                    * 0C79 CC 00 01       L..
           BRA    L0C8E                                                 * 0C7C 20 10           .
L0C7E      LEAX   >L0F80,PC                                             * 0C7E 30 8D 02 FE    0..~
           PSHS   X                                                     * 0C82 34 10          4.
           LBSR   L074E                                                 * 0C84 17 FA C7       .zG
           LEAS   2,S                                                   * 0C87 32 62          2b
           BRA    L0C8E                                                 * 0C89 20 03           .
L0C8B      LBSR   L072A                                                 * 0C8B 17 FA 9C       .z.
L0C8E      LEAS   4,S                                                   * 0C8E 32 64          2d
           PULS   PC,U                                                  * 0C90 35 C0          5@
           PSHS   U,D                                                   * 0C92 34 46          4F
           LDD    #2                                                    * 0C94 CC 00 02       L..
           STD    <U001B                                                * 0C97 DD 1B          ].
           LBSR   L2229                                                 * 0C99 17 15 8D       ...
           BRA    L0CBB                                                 * 0C9C 20 1D           .
L0C9E      LDB    <U00BA                                                * 0C9E D6 BA          V:
           SEX                                                          * 0CA0 1D             .
           ORA    ,S                                                    * 0CA1 AA E4          *d
           ORB    1,S                                                   * 0CA3 EA 61          ja
           STB    <U00BA                                                * 0CA5 D7 BA          W:
           LDB    [>U0062,Y]                                            * 0CA7 E6 B9 00 62    f9.b
           CMPB   #44                                                   * 0CAB C1 2C          A,
           BEQ    L0CB4                                                 * 0CAD 27 05          '.
           LDD    #1                                                    * 0CAF CC 00 01       L..
           PULS   PC,U,X                                                * 0CB2 35 D0          5P
L0CB4      LDD    <U0062                                                * 0CB4 DC 62          \b
           ADDD   #1                                                    * 0CB6 C3 00 01       C..
           STD    <U0062                                                * 0CB9 DD 62          ]b
L0CBB      LDD    #1                                                    * 0CBB CC 00 01       L..
           PSHS   D                                                     * 0CBE 34 06          4.
           LBSR   L1070                                                 * 0CC0 17 03 AD       ..-
           LEAS   2,S                                                   * 0CC3 32 62          2b
           STD    ,S                                                    * 0CC5 ED E4          md
           BNE    L0C9E                                                 * 0CC7 26 D5          &U
           LBSR   L072A                                                 * 0CC9 17 FA 5E       .z^
           PULS   PC,U,X                                                * 0CCC 35 D0          5P
           PSHS   U                                                     * 0CCE 34 40          4@
           LDD    #4                                                    * 0CD0 CC 00 04       L..
           STD    <U001B                                                * 0CD3 DD 1B          ].
           LDD    >Y0013,Y                                              * 0CD5 EC A9 00 13    l)..
           PSHS   D                                                     * 0CD9 34 06          4.
           LEAX   >Y02DA,Y                                              * 0CDB 30 A9 02 DA    0).Z
           PSHS   X                                                     * 0CDF 34 10          4.
           LEAX   >Y05B4,Y                                              * 0CE1 30 A9 05 B4    0).4
           PSHS   X                                                     * 0CE5 34 10          4.
           LBSR   L0874                                                 * 0CE7 17 FB 8A       .{.
           LEAS   6,S                                                   * 0CEA 32 66          2f
           STD    <U0070                                                * 0CEC DD 70          ]p
           BEQ    L0CFB                                                 * 0CEE 27 0B          '.
           LDX    <U0070                                                * 0CF0 9E 70          .p
           LDB    2,X                                                   * 0CF2 E6 02          f.
           STB    <Y00B9                                                * 0CF4 D7 B9          W9
L0CF6      LBSR   L1038                                                 * 0CF6 17 03 3F       ..?
           PULS   PC,U                                                  * 0CF9 35 C0          5@
L0CFB      LEAX   >L0F97,PC                                             * 0CFB 30 8D 02 98    0...
           PSHS   X                                                     * 0CFF 34 10          4.
           LBSR   L074E                                                 * 0D01 17 FA 4A       .zJ
           PULS   PC,U,X                                                * 0D04 35 D0          5P
           PSHS   U,D                                                   * 0D06 34 46          4F
           LDD    #2                                                    * 0D08 CC 00 02       L..
           STD    <U001B                                                * 0D0B DD 1B          ].
           LBSR   L2426                                                 * 0D0D 17 17 16       ...
           STD    -2,S                                                  * 0D10 ED 7E          m~
           BEQ    L0D63                                                 * 0D12 27 4F          'O
           LDB    <U005B                                                * 0D14 D6 5B          V[
           BEQ    L0D5E                                                 * 0D16 27 46          'F
           LDD    <U0031                                                * 0D18 DC 31          \1
           SUBD   <U004D                                                * 0D1A 93 4D          .M
           ADDD   #-2                                                   * 0D1C C3 FF FE       C.~
           STD    ,S                                                    * 0D1F ED E4          md
           LDB    <U0061                                                * 0D21 D6 61          Va
           SEX                                                          * 0D23 1D             .
           ORB    #136                                                  * 0D24 CA 88          J.
           STB    <U0061                                                * 0D26 D7 61          Wa
           LBSR   L1485                                                 * 0D28 17 07 5A       ..Z
           LEAX   >Y07C7,Y                                              * 0D2B 30 A9 07 C7    0).G
           CMPX   >Y07E5,Y                                              * 0D2F AC A9 07 E5    ,).e
           BNE    L0D57                                                 * 0D33 26 22          &"
           LDD    ,S                                                    * 0D35 EC E4          ld
           CMPD   #127                                                  * 0D37 10 83 00 7F    ....
           BGT    L0D45                                                 * 0D3B 2E 08          ..
           LDD    ,S                                                    * 0D3D EC E4          ld
           CMPD   #-128                                                 * 0D3F 10 83 FF 80    ....
           BGE    L0D5A                                                 * 0D43 2C 15          ,.
L0D45      LDD    #-2                                                   * 0D45 CC FF FE       L.~
           STD    ,S                                                    * 0D48 ED E4          md
           LEAX   >L0FA4,PC                                             * 0D4A 30 8D 02 56    0..V
           PSHS   X                                                     * 0D4E 34 10          4.
           LBSR   L074E                                                 * 0D50 17 F9 FB       .y{
           LEAS   2,S                                                   * 0D53 32 62          2b
           BRA    L0D5A                                                 * 0D55 20 03           .
L0D57      LBSR   L13DA                                                 * 0D57 17 06 80       ...
L0D5A      LDD    ,S                                                    * 0D5A EC E4          ld
           STB    <U00BA                                                * 0D5C D7 BA          W:
L0D5E      LDD    #1                                                    * 0D5E CC 00 01       L..
           PULS   PC,U,X                                                * 0D61 35 D0          5P
L0D63      CLRA                                                         * 0D63 4F             O
           CLRB                                                         * 0D64 5F             _
           PULS   PC,U,X                                                * 0D65 35 D0          5P
           PSHS   U                                                     * 0D67 34 40          4@
           CLRA                                                         * 0D69 4F             O
           CLRB                                                         * 0D6A 5F             _
           STD    <U001B                                                * 0D6B DD 1B          ].
           LDB    <Y00B9                                                * 0D6D D6 B9          V9
           SEX                                                          * 0D6F 1D             .
           ASLB                                                         * 0D70 58             X
           ROLA                                                         * 0D71 49             I
           LEAX   >Y0398,Y                                              * 0D72 30 A9 03 98    0)..
           BRA    L0D87                                                 * 0D76 20 0F           .
           PSHS   U                                                     * 0D78 34 40          4@
           CLRA                                                         * 0D7A 4F             O
           CLRB                                                         * 0D7B 5F             _
           STD    <U001B                                                * 0D7C DD 1B          ].
           LDB    <Y00B9                                                * 0D7E D6 B9          V9
           SEX                                                          * 0D80 1D             .
           ASLB                                                         * 0D81 58             X
           ROLA                                                         * 0D82 49             I
           LEAX   >Y03AE,Y                                              * 0D83 30 A9 03 AE    0)..
L0D87      LEAX   D,X                                                   * 0D87 30 8B          0.
           JSR    [,X]                                                  * 0D89 AD 94          -.
           PULS   PC,U                                                  * 0D8B 35 C0          5@
           PSHS   U                                                     * 0D8D 34 40          4@
           CLRA                                                         * 0D8F 4F             O
           CLRB                                                         * 0D90 5F             _
           STD    <U001B                                                * 0D91 DD 1B          ].
           LDD    <U0029                                                * 0D93 DC 29          \)
           ADDD   #1                                                    * 0D95 C3 00 01       C..
           STD    <U0029                                                * 0D98 DD 29          ])
           LDB    <Y00B9                                                * 0D9A D6 B9          V9
           SEX                                                          * 0D9C 1D             .
           ASLB                                                         * 0D9D 58             X
           ROLA                                                         * 0D9E 49             I
           LEAX   >Y03C6,Y                                              * 0D9F 30 A9 03 C6    0).F
           LEAX   D,X                                                   * 0DA3 30 8B          0.
           LDD    ,X                                                    * 0DA5 EC 84          l.
           PSHS   D                                                     * 0DA7 34 06          4.
           LEAX   >L1BBF,PC                                             * 0DA9 30 8D 0E 12    0...
           CMPX   ,S++                                                  * 0DAD AC E1          ,a
           BEQ    L0DC6                                                 * 0DAF 27 15          '.
           LBSR   L2426                                                 * 0DB1 17 16 72       ..r
           STD    -2,S                                                  * 0DB4 ED 7E          m~
           LBEQ   L0EE4                                                 * 0DB6 10 27 01 2A    .'.*
           LEAX   >Y07C7,Y                                              * 0DBA 30 A9 07 C7    0).G
           CMPX   >Y07E5,Y                                              * 0DBE AC A9 07 E5    ,).e
           LBNE   L0EF2                                                 * 0DC2 10 26 01 2C    .&.,
L0DC6      LDB    <Y00B9                                                * 0DC6 D6 B9          V9
           SEX                                                          * 0DC8 1D             .
           ASLB                                                         * 0DC9 58             X
           ROLA                                                         * 0DCA 49             I
           LEAX   >Y03C6,Y                                              * 0DCB 30 A9 03 C6    0).F
           LEAX   D,X                                                   * 0DCF 30 8B          0.
           JSR    [,X]                                                  * 0DD1 AD 94          -.
           STD    -2,S                                                  * 0DD3 ED 7E          m~
           BNE    L0DDE                                                 * 0DD5 26 07          &.
           LDD    <U002B                                                * 0DD7 DC 2B          \+
           ADDD   #1                                                    * 0DD9 C3 00 01       C..
           STD    <U002B                                                * 0DDC DD 2B          ]+
L0DDE      LDD    <U003D                                                * 0DDE DC 3D          \=
           PSHS   D                                                     * 0DE0 34 06          4.
           LDB    <U00BF                                                * 0DE2 D6 BF          V?
           BLE    L0E30                                                 * 0DE4 2F 4A          /J
           LDD    #1                                                    * 0DE6 CC 00 01       L..
           BRA    L0E32                                                 * 0DE9 20 47           G
L0DEB      PSHS   U                                                     * 0DEB 34 40          4@
           LEAX   >L0FB8,PC                                             * 0DED 30 8D 01 C7    0..G
           PSHS   X                                                     * 0DF1 34 10          4.
           LBSR   L074E                                                 * 0DF3 17 F9 58       .yX
           PULS   PC,U,X                                                * 0DF6 35 D0          5P
           PSHS   U                                                     * 0DF8 34 40          4@
           CLRA                                                         * 0DFA 4F             O
           CLRB                                                         * 0DFB 5F             _
           STD    <U001B                                                * 0DFC DD 1B          ].
           LDD    <U0029                                                * 0DFE DC 29          \)
           BEQ    L0E3B                                                 * 0E00 27 39          '9
           LDB    <Y00B9                                                * 0E02 D6 B9          V9
           BNE    L0E18                                                 * 0E04 26 12          &.
           LDD    <U0029                                                * 0E06 DC 29          \)
           ADDD   #-1                                                   * 0E08 C3 FF FF       C..
           STD    <U0029                                                * 0E0B DD 29          ])
           LDD    <U002B                                                * 0E0D DC 2B          \+
           BEQ    L0E23                                                 * 0E0F 27 12          '.
L0E11      LDD    <U002B                                                * 0E11 DC 2B          \+
           ADDD   #-1                                                   * 0E13 C3 FF FF       C..
           BRA    L0E21                                                 * 0E16 20 09           .
L0E18      LDD    <U002B                                                * 0E18 DC 2B          \+
           BNE    L0E11                                                 * 0E1A 26 F5          &u
           LDD    <U002B                                                * 0E1C DC 2B          \+
           ADDD   #1                                                    * 0E1E C3 00 01       C..
L0E21      STD    <U002B                                                * 0E21 DD 2B          ]+
L0E23      LDD    <U003D                                                * 0E23 DC 3D          \=
           PSHS   D                                                     * 0E25 34 06          4.
           LDB    <U00BF                                                * 0E27 D6 BF          V?
           BLE    L0E30                                                 * 0E29 2F 05          /.
           LDD    #1                                                    * 0E2B CC 00 01       L..
           BRA    L0E32                                                 * 0E2E 20 02           .
L0E30      CLRA                                                         * 0E30 4F             O
           CLRB                                                         * 0E31 5F             _
L0E32      ANDA   ,S+                                                   * 0E32 A4 E0          $`
           ANDB   ,S+                                                   * 0E34 E4 E0          d`
           STD    <U003D                                                * 0E36 DD 3D          ]=
           LBRA   L0F25                                                 * 0E38 16 00 EA       ..j
L0E3B      LEAX   >L0FD3,PC                                             * 0E3B 30 8D 01 94    0...
           PSHS   X                                                     * 0E3F 34 10          4.
           LBSR   L074E                                                 * 0E41 17 F9 0A       .y.
           PULS   PC,U,X                                                * 0E44 35 D0          5P
           PSHS   U                                                     * 0E46 34 40          4@
           BSR    L0E5C                                                 * 0E48 8D 12          ..
           LBSR   L2BC2                                                 * 0E4A 17 1D 75       ..u
           CLRA                                                         * 0E4D 4F             O
           CLRB                                                         * 0E4E 5F             _
           STD    <U0041                                                * 0E4F DD 41          ]A
           STD    <U0045                                                * 0E51 DD 45          ]E
           STD    <U0043                                                * 0E53 DD 43          ]C
           STD    <U0047                                                * 0E55 DD 47          ]G
           STD    <U004D                                                * 0E57 DD 4D          ]M
           LBRA   L0F25                                                 * 0E59 16 00 C9       ..I
L0E5C      PSHS   U                                                     * 0E5C 34 40          4@
           CLRA                                                         * 0E5E 4F             O
           CLRB                                                         * 0E5F 5F             _
           STD    <U001B                                                * 0E60 DD 1B          ].
           LEAX   >Y0116,Y                                              * 0E62 30 A9 01 16    0)..
           STX    <U0072                                                * 0E66 9F 72          .r
           LDD    >Y0009,Y                                              * 0E68 EC A9 00 09    l)..
           STD    <U0074                                                * 0E6C DD 74          ]t
           LEAX   >Y033A,Y                                              * 0E6E 30 A9 03 3A    0).:
           STX    <U006E                                                * 0E72 9F 6E          .n
           LEAX   >U007C,Y                                              * 0E74 30 A9 00 7C    0).|
           STX    <U007A                                                * 0E78 9F 7A          .z
           LDD    #4                                                    * 0E7A CC 00 04       L..
           STB    <U005C                                                * 0E7D D7 5C          W\
           LDD    #162                                                  * 0E7F CC 00 A2       L."
           STB    <U005E                                                * 0E82 D7 5E          W^
           LDD    #32                                                   * 0E84 CC 00 20       L.
           STB    <U0060                                                * 0E87 D7 60          W`
           LEAX   >U004D,Y                                              * 0E89 30 A9 00 4D    0).M
           STX    <U004B                                                * 0E8D 9F 4B          .K
           CLRA                                                         * 0E8F 4F             O
           CLRB                                                         * 0E90 5F             _
           STD    <U0053                                                * 0E91 DD 53          ]S
           LBRA   L0F25                                                 * 0E93 16 00 8F       ...
           PSHS   U                                                     * 0E96 34 40          4@
           CLRA                                                         * 0E98 4F             O
           CLRB                                                         * 0E99 5F             _
           STD    <U001B                                                * 0E9A DD 1B          ].
           LEAX   >Y0256,Y                                              * 0E9C 30 A9 02 56    0).V
           STX    <U0072                                                * 0EA0 9F 72          .r
           LDD    >Y000B,Y                                              * 0EA2 EC A9 00 0B    l)..
           STD    <U0074                                                * 0EA6 DD 74          ]t
           LEAX   >Y0356,Y                                              * 0EA8 30 A9 03 56    0).V
           STX    <U006E                                                * 0EAC 9F 6E          .n
           CLRA                                                         * 0EAE 4F             O
           CLRB                                                         * 0EAF 5F             _
           STD    <U007A                                                * 0EB0 DD 7A          ]z
           LDD    #6                                                    * 0EB2 CC 00 06       L..
           STB    <U005C                                                * 0EB5 D7 5C          W\
           LDB    <U005E                                                * 0EB7 D6 5E          V^
           CLRA                                                         * 0EB9 4F             O
           ANDB   #2                                                    * 0EBA C4 02          D.
           ORB    #128                                                  * 0EBC CA 80          J.
           STB    <U005E                                                * 0EBE D7 5E          W^
           CLRA                                                         * 0EC0 4F             O
           CLRB                                                         * 0EC1 5F             _
           STB    <U0060                                                * 0EC2 D7 60          W`
           CLRA                                                         * 0EC4 4F             O
           CLRB                                                         * 0EC5 5F             _
           STD    <U004B                                                * 0EC6 DD 4B          ]K
           LEAX   >Y0049,Y                                              * 0EC8 30 A9 00 49    0).I
           STX    <U0053                                                * 0ECC 9F 53          .S
           TFR    X,D                                                   * 0ECE 1F 10          ..
           STD    <U004F                                                * 0ED0 DD 4F          ]O
           CLRA                                                         * 0ED2 4F             O
           CLRB                                                         * 0ED3 5F             _
           STD    <Y0049                                                * 0ED4 DD 49          ]I
           LBSR   L2229                                                 * 0ED6 17 13 50       ..P
           STD    -2,S                                                  * 0ED9 ED 7E          m~
           BEQ    L0F25                                                 * 0EDB 27 48          'H
           LBSR   L2426                                                 * 0EDD 17 15 46       ..F
           STD    -2,S                                                  * 0EE0 ED 7E          m~
           BNE    L0EE8                                                 * 0EE2 26 04          &.
L0EE4      CLRA                                                         * 0EE4 4F             O
           CLRB                                                         * 0EE5 5F             _
           PULS   PC,U                                                  * 0EE6 35 C0          5@
L0EE8      LEAX   >Y07C7,Y                                              * 0EE8 30 A9 07 C7    0).G
           CMPX   >Y07E5,Y                                              * 0EEC AC A9 07 E5    ,).e
           BEQ    L0EF7                                                 * 0EF0 27 05          '.
L0EF2      LBSR   L0DEB                                                 * 0EF2 17 FE F6       .~v
           PULS   PC,U                                                  * 0EF5 35 C0          5@
L0EF7      LDD    <U0031                                                * 0EF7 DC 31          \1
           STD    <Y0049                                                * 0EF9 DD 49          ]I
           BRA    L0F25                                                 * 0EFB 20 28           (
           PSHS   U                                                     * 0EFD 34 40          4@
           CLRA                                                         * 0EFF 4F             O
           CLRB                                                         * 0F00 5F             _
           STD    <U001B                                                * 0F01 DD 1B          ].
           LEAX   >Y027A,Y                                              * 0F03 30 A9 02 7A    0).z
           STX    <U0072                                                * 0F07 9F 72          .r
           LDD    >Y000F,Y                                              * 0F09 EC A9 00 0F    l)..
           STD    <U0074                                                * 0F0D DD 74          ]t
           LEAX   >Y035E,Y                                              * 0F0F 30 A9 03 5E    0).^
           STX    <U006E                                                * 0F13 9F 6E          .n
           CLRA                                                         * 0F15 4F             O
           CLRB                                                         * 0F16 5F             _
           STB    <U005C                                                * 0F17 D7 5C          W\
           LBSR   L1C27                                                 * 0F19 17 0D 0B       ...
           STD    -2,S                                                  * 0F1C ED 7E          m~
           BEQ    L0F25                                                 * 0F1E 27 05          '.
           LDD    #2                                                    * 0F20 CC 00 02       L..
           STB    <U005C                                                * 0F23 D7 5C          W\
L0F25      LDD    #1                                                    * 0F25 CC 00 01       L..
           PULS   PC,U                                                  * 0F28 35 C0          5@
           PSHS   U                                                     * 0F2A 34 40          4@
           LDD    <U0053                                                * 0F2C DC 53          \S
           STD    <U004F                                                * 0F2E DD 4F          ]O
           LDB    <U005E                                                * 0F30 D6 5E          V^
           CLRA                                                         * 0F32 4F             O
           ANDB   #2                                                    * 0F33 C4 02          D.
           BEQ    L0F3C                                                 * 0F35 27 05          '.
           LBSR   L0E5C                                                 * 0F37 17 FF 22       .."
           BRA    L0F3F                                                 * 0F3A 20 03           .
L0F3C      LBSR   L1C72                                                 * 0F3C 17 0D 33       ..3
L0F3F      PULS   PC,U                                                  * 0F3F 35 C0          5@
           PSHS   U                                                     * 0F41 34 40          4@
           LDD    <U00CC                                                * 0F43 DC CC          \L
           BEQ    L0F4C                                                 * 0F45 27 05          '.
           LBSR   L0742                                                 * 0F47 17 F7 F8       .wx
           PULS   PC,U                                                  * 0F4A 35 C0          5@
L0F4C      LDD    <U0064                                                * 0F4C DC 64          \d
           BNE    L0F5B                                                 * 0F4E 26 0B          &.
           LEAX   >L0FED,PC                                             * 0F50 30 8D 00 99    0...
           PSHS   X                                                     * 0F54 34 10          4.
           LBSR   L074E                                                 * 0F56 17 F7 F5       .wu
           PULS   PC,U,X                                                * 0F59 35 D0          5P
L0F5B      LDD    #7                                                    * 0F5B CC 00 07       L..
           PSHS   D                                                     * 0F5E 34 06          4.
           LBSR   L20A1                                                 * 0F60 17 11 3E       ..>
           LEAS   2,S                                                   * 0F63 32 62          2b
           LDB    <U005B                                                * 0F65 D6 5B          V[
           BNE    L0F6C                                                 * 0F67 26 03          &.
           LBSR   L31E9                                                 * 0F69 17 22 7D       ."}
L0F6C      LDD    #1                                                    * 0F6C CC 00 01       L..
           STD    <U00CC                                                * 0F6F DD CC          ]L
           PULS   PC,U                                                  * 0F71 35 C0          5@
           PSHS   U                                                     * 0F73 34 40          4@
           LEAX   >L0FFB,PC                                             * 0F75 30 8D 00 82    0...
           PSHS   X                                                     * 0F79 34 10          4.
           LBSR   L074E                                                 * 0F7B 17 F7 D0       .wP
           PULS   PC,U,X                                                * 0F7E 35 D0          5P
L0F80      FCC    "register size mismatch"                              * 0F80 72 65 67 69 73 74 65 72 20 73 69 7A 65 20 6D 69 73 6D 61 74 63 68 register size mismatch
           FCB    $00                                                   * 0F96 00             .
L0F97      FCC    "bad mnemonic"                                        * 0F97 62 61 64 20 6D 6E 65 6D 6F 6E 69 63 bad mnemonic
           FCB    $00                                                   * 0FA3 00             .
L0FA4      FCC    "branch out of range"                                 * 0FA4 62 72 61 6E 63 68 20 6F 75 74 20 6F 66 20 72 61 6E 67 65 branch out of range
           FCB    $00                                                   * 0FB7 00             .
L0FB8      FCC    "illegal external reference"                          * 0FB8 69 6C 6C 65 67 61 6C 20 65 78 74 65 72 6E 61 6C 20 72 65 66 65 72 65 6E 63 65 illegal external reference
           FCB    $00                                                   * 0FD2 00             .
L0FD3      FCC    "conditional nesting error"                           * 0FD3 63 6F 6E 64 69 74 69 6F 6E 61 6C 20 6E 65 73 74 69 6E 67 20 65 72 72 6F 72 conditional nesting error
           FCB    $00                                                   * 0FEC 00             .
L0FED      FCC    "label missing"                                       * 0FED 6C 61 62 65 6C 20 6D 69 73 73 69 6E 67 label missing
           FCB    $00                                                   * 0FFA 00             .
L0FFB      FCC    "ENDM without MACRO"                                  * 0FFB 45 4E 44 4D 20 77 69 74 68 6F 75 74 20 4D 41 43 52 4F ENDM without MACRO
           FCB    $00                                                   * 100D 00             .
L100E      PSHS   U                                                     * 100E 34 40          4@
           LBSR   L2229                                                 * 1010 17 12 16       ...
           CMPD   #35                                                   * 1013 10 83 00 23    ...#
           BNE    L1048                                                 * 1017 26 2F          &/
           LDD    <U0062                                                * 1019 DC 62          \b
           ADDD   #1                                                    * 101B C3 00 01       C..
           STD    <U0062                                                * 101E DD 62          ]b
           LBRA   L13C1                                                 * 1020 16 03 9E       ...
L1023      PSHS   U                                                     * 1023 34 40          4@
           LDD    <U001F                                                * 1025 DC 1F          \.
           CLRA                                                         * 1027 4F             O
           ANDB   #64                                                   * 1028 C4 40          D@
           LBEQ   L13C1                                                 * 102A 10 27 03 93    .'..
           LDD    #3                                                    * 102E CC 00 03       L..
           STD    <U001B                                                * 1031 DD 1B          ].
           LBSR   L12F8                                                 * 1033 17 02 C2       ..B
           PULS   PC,U                                                  * 1036 35 C0          5@
L1038      PSHS   U                                                     * 1038 34 40          4@
           LDB    <U0061                                                * 103A D6 61          Va
           SEX                                                          * 103C 1D             .
           ORB    #128                                                  * 103D CA 80          J.
           STB    <U0061                                                * 103F D7 61          Wa
           LBSR   L23B8                                                 * 1041 17 13 74       ..t
           STD    -2,S                                                  * 1044 ED 7E          m~
           BNE    L104C                                                 * 1046 26 04          &.
L1048      CLRA                                                         * 1048 4F             O
           CLRB                                                         * 1049 5F             _
           PULS   PC,U                                                  * 104A 35 C0          5@
L104C      LDD    <U0031                                                * 104C DC 31          \1
           SUBD   <U004D                                                * 104E 93 4D          .M
           SUBD   <U001B                                                * 1050 93 1B          ..
           STD    <U00BA                                                * 1052 DD BA          ]:
           LDD    <U00BA                                                * 1054 DC BA          \:
           CMPD   #127                                                  * 1056 10 83 00 7F    ....
           BGT    L1064                                                 * 105A 2E 08          ..
           LDD    <U00BA                                                * 105C DC BA          \:
           CMPD   #-128                                                 * 105E 10 83 FF 80    ....
           BGE    L1069                                                 * 1062 2C 05          ,.
L1064      LDD    #1                                                    * 1064 CC 00 01       L..
           BRA    L106B                                                 * 1067 20 02           .
L1069      CLRA                                                         * 1069 4F             O
           CLRB                                                         * 106A 5F             _
L106B      STD    <U0039                                                * 106B DD 39          ]9
           LBRA   L13C1                                                 * 106D 16 03 51       ..Q
L1070      PSHS   U                                                     * 1070 34 40          4@
           LEAS   -3,S                                                  * 1072 32 7D          2}
           CLRA                                                         * 1074 4F             O
           CLRB                                                         * 1075 5F             _
           LBRA   L1106                                                 * 1076 16 00 8D       ...
L1079      LDD    1,S                                                   * 1079 EC 61          la
           PSHS   D                                                     * 107B 34 06          4.
           LDD    #3                                                    * 107D CC 00 03       L..
           LBSR   L466A                                                 * 1080 17 35 E7       .5g
           LEAX   >Y0362,Y                                              * 1083 30 A9 03 62    0).b
           LEAX   D,X                                                   * 1087 30 8B          0.
           LDB    ,X                                                    * 1089 E6 84          f.
           SEX                                                          * 108B 1D             .
           PSHS   D                                                     * 108C 34 06          4.
           LDB    [>U0062,Y]                                            * 108E E6 B9 00 62    f9.b
           CLRA                                                         * 1092 4F             O
           ANDB   #223                                                  * 1093 C4 DF          D_
           CMPD   ,S++                                                  * 1095 10 A3 E1       .#a
           LBNE   L1101                                                 * 1098 10 26 00 65    .&.e
           LDD    1,S                                                   * 109C EC 61          la
           PSHS   D                                                     * 109E 34 06          4.
           LDD    #3                                                    * 10A0 CC 00 03       L..
           LBSR   L466A                                                 * 10A3 17 35 C4       .5D
           LEAX   >Y0362,Y                                              * 10A6 30 A9 03 62    0).b
           LEAX   D,X                                                   * 10AA 30 8B          0.
           LDB    1,X                                                   * 10AC E6 01          f.
           STB    ,S                                                    * 10AE E7 E4          gd
           BEQ    L10CA                                                 * 10B0 27 18          '.
           LDX    <U0062                                                * 10B2 9E 62          .b
           LDB    1,X                                                   * 10B4 E6 01          f.
           CLRA                                                         * 10B6 4F             O
           ANDB   #223                                                  * 10B7 C4 DF          D_
           PSHS   D                                                     * 10B9 34 06          4.
           LDB    2,S                                                   * 10BB E6 62          fb
           SEX                                                          * 10BD 1D             .
           CMPD   ,S++                                                  * 10BE 10 A3 E1       .#a
           BNE    L1101                                                 * 10C1 26 3E          &>
           LDD    <U0062                                                * 10C3 DC 62          \b
           ADDD   #1                                                    * 10C5 C3 00 01       C..
           STD    <U0062                                                * 10C8 DD 62          ]b
L10CA      LDD    <U0062                                                * 10CA DC 62          \b
           ADDD   #1                                                    * 10CC C3 00 01       C..
           STD    <U0062                                                * 10CF DD 62          ]b
           LDD    7,S                                                   * 10D1 EC 67          lg
           BNE    L10EC                                                 * 10D3 26 17          &.
           LDD    1,S                                                   * 10D5 EC 61          la
           CMPD   #4                                                    * 10D7 10 83 00 04    ....
           BGE    L10E3                                                 * 10DB 2C 06          ,.
           LDD    1,S                                                   * 10DD EC 61          la
           ORB    #8                                                    * 10DF CA 08          J.
           BRA    L1114                                                 * 10E1 20 31           1
L10E3      LDD    1,S                                                   * 10E3 EC 61          la
           ADDD   #-4                                                   * 10E5 C3 FF FC       C.|
           ORA    #1                                                    * 10E8 8A 01          ..
           BRA    L1114                                                 * 10EA 20 28           (
L10EC      LDD    1,S                                                   * 10EC EC 61          la
           PSHS   D                                                     * 10EE 34 06          4.
           LDD    #3                                                    * 10F0 CC 00 03       L..
           LBSR   L466A                                                 * 10F3 17 35 74       .5t
           LEAX   >Y0362,Y                                              * 10F6 30 A9 03 62    0).b
           LEAX   D,X                                                   * 10FA 30 8B          0.
           LDB    2,X                                                   * 10FC E6 02          f.
           SEX                                                          * 10FE 1D             .
           BRA    L1114                                                 * 10FF 20 13           .
L1101      LDD    1,S                                                   * 1101 EC 61          la
           ADDD   #1                                                    * 1103 C3 00 01       C..
L1106      STD    1,S                                                   * 1106 ED 61          ma
           LDD    1,S                                                   * 1108 EC 61          la
           CMPD   #10                                                   * 110A 10 83 00 0A    ....
           LBLT   L1079                                                 * 110E 10 2D FF 67    .-.g
           CLRA                                                         * 1112 4F             O
           CLRB                                                         * 1113 5F             _
L1114      LEAS   3,S                                                   * 1114 32 63          2c
           PULS   PC,U                                                  * 1116 35 C0          5@
L1118      PSHS   U                                                     * 1118 34 40          4@
           LEAS   -1,S                                                  * 111A 32 7F          2.
           LBSR   L2229                                                 * 111C 17 11 0A       ...
           STB    ,S                                                    * 111F E7 E4          gd
           CMPB   #91                                                   * 1121 C1 5B          A[
           BNE    L112A                                                 * 1123 26 05          &.
           LDD    #1                                                    * 1125 CC 00 01       L..
           BRA    L112C                                                 * 1128 20 02           .
L112A      CLRA                                                         * 112A 4F             O
           CLRB                                                         * 112B 5F             _
L112C      STD    <U0035                                                * 112C DD 35          ]5
           BEQ    L113A                                                 * 112E 27 0A          '.
           LDX    <U0062                                                * 1130 9E 62          .b
           LEAX   1,X                                                   * 1132 30 01          0.
           STX    <U0062                                                * 1134 9F 62          .b
           LDB    ,X                                                    * 1136 E6 84          f.
           STB    ,S                                                    * 1138 E7 E4          gd
L113A      LDB    ,S                                                    * 113A E6 E4          fd
           SEX                                                          * 113C 1D             .
           PSHS   D                                                     * 113D 34 06          4.
           LBSR   L11C0                                                 * 113F 17 00 7E       ..~
           LEAS   2,S                                                   * 1142 32 62          2b
           STB    ,S                                                    * 1144 E7 E4          gd
           CMPB   #44                                                   * 1146 C1 2C          A,
           BNE    L1150                                                 * 1148 26 06          &.
           LBSR   L1260                                                 * 114A 17 01 13       ...
           LBRA   L1364                                                 * 114D 16 02 14       ...
L1150      LDX    <U0062                                                * 1150 9E 62          .b
           LDB    1,X                                                   * 1152 E6 01          f.
           CMPB   #44                                                   * 1154 C1 2C          A,
           BNE    L1185                                                 * 1156 26 2D          &-
           LDB    ,S                                                    * 1158 E6 E4          fd
           CLRA                                                         * 115A 4F             O
           ANDB   #223                                                  * 115B C4 DF          D_
           TFR    D,X                                                   * 115D 1F 01          ..
           BRA    L1176                                                 * 115F 20 15           .
L1161      LDD    #134                                                  * 1161 CC 00 86       L..
           BRA    L116E                                                 * 1164 20 08           .
L1166      LDD    #133                                                  * 1166 CC 00 85       L..
           BRA    L116E                                                 * 1169 20 03           .
L116B      LDD    #139                                                  * 116B CC 00 8B       L..
L116E      STB    <U00BA                                                * 116E D7 BA          W:
           LBSR   L11F1                                                 * 1170 17 00 7E       ..~
           LBRA   L1364                                                 * 1173 16 01 EE       ..n
L1176      CMPX   #65                                                   * 1176 8C 00 41       ..A
           BEQ    L1161                                                 * 1179 27 E6          'f
           CMPX   #66                                                   * 117B 8C 00 42       ..B
           BEQ    L1166                                                 * 117E 27 E6          'f
           CMPX   #68                                                   * 1180 8C 00 44       ..D
           BEQ    L116B                                                 * 1183 27 E6          'f
L1185      LBSR   L2426                                                 * 1185 17 12 9E       ...
           LDD    <U0031                                                * 1188 DC 31          \1
           STD    <U0033                                                * 118A DD 33          ]3
           LDB    [>U0062,Y]                                            * 118C E6 B9 00 62    f9.b
           CMPB   #44                                                   * 1190 C1 2C          A,
           BNE    L119A                                                 * 1192 26 06          &.
           LBSR   L15A3                                                 * 1194 17 04 0C       ...
           LBRA   L1364                                                 * 1197 16 01 CA       ..J
L119A      LDD    <U0035                                                * 119A DC 35          \5
           BNE    L11BB                                                 * 119C 26 1D          &.
           LDD    <U0037                                                * 119E DC 37          \7
           BLT    L11BB                                                 * 11A0 2D 19          -.
           LDD    <U0037                                                * 11A2 DC 37          \7
           BGT    L11B5                                                 * 11A4 2E 0F          ..
           LDD    <U0033                                                * 11A6 DC 33          \3
           PSHS   D                                                     * 11A8 34 06          4.
           LDD    #256                                                  * 11AA CC 01 00       L..
           LBSR   L471E                                                 * 11AD 17 35 6E       .5n
           CMPD   <U0027                                                * 11B0 10 93 27       ..'
           BNE    L11BB                                                 * 11B3 26 06          &.
L11B5      LBSR   L1233                                                 * 11B5 17 00 7B       ..{
           LBRA   L1364                                                 * 11B8 16 01 A9       ..)
L11BB      BSR    L1209                                                 * 11BB 8D 4C          .L
           LBRA   L1364                                                 * 11BD 16 01 A4       ..$
L11C0      PSHS   U                                                     * 11C0 34 40          4@
           LDB    5,S                                                   * 11C2 E6 65          fe
           CMPB   #62                                                   * 11C4 C1 3E          A>
           BNE    L11CD                                                 * 11C6 26 05          &.
           LDD    #-1                                                   * 11C8 CC FF FF       L..
           BRA    L11DA                                                 * 11CB 20 0D           .
L11CD      LDB    5,S                                                   * 11CD E6 65          fe
           CMPB   #60                                                   * 11CF C1 3C          A<
           BNE    L11D8                                                 * 11D1 26 05          &.
           LDD    #1                                                    * 11D3 CC 00 01       L..
           BRA    L11DA                                                 * 11D6 20 02           .
L11D8      CLRA                                                         * 11D8 4F             O
           CLRB                                                         * 11D9 5F             _
L11DA      STD    <U0037                                                * 11DA DD 37          ]7
           LDD    <U0037                                                * 11DC DC 37          \7
           BEQ    L11EA                                                 * 11DE 27 0A          '.
           LDX    <U0062                                                * 11E0 9E 62          .b
           LEAX   1,X                                                   * 11E2 30 01          0.
           STX    <U0062                                                * 11E4 9F 62          .b
           LDB    ,X                                                    * 11E6 E6 84          f.
           BRA    L11EC                                                 * 11E8 20 02           .
L11EA      LDB    5,S                                                   * 11EA E6 65          fe
L11EC      SEX                                                          * 11EC 1D             .
           PULS   PC,U                                                  * 11ED 35 C0          5@
           FCB    $35                                                   * 11EF 35             5
           FCB    $C0                                                   * 11F0 C0             @
L11F1      PSHS   U                                                     * 11F1 34 40          4@
           LDD    <U0062                                                * 11F3 DC 62          \b
           ADDD   #2                                                    * 11F5 C3 00 02       C..
           STD    <U0062                                                * 11F8 DD 62          ]b
           LBSR   L1305                                                 * 11FA 17 01 08       ...
           STD    -2,S                                                  * 11FD ED 7E          m~
           LBEQ   L12A4                                                 * 11FF 10 27 00 A1    .'.!
           LBSR   L1375                                                 * 1203 17 01 6F       ..o
           LBRA   L12A7                                                 * 1206 16 00 9E       ...
L1209      PSHS   U                                                     * 1209 34 40          4@
           LDD    <U001B                                                * 120B DC 1B          \.
           ADDD   #2                                                    * 120D C3 00 02       C..
           STD    <U001B                                                * 1210 DD 1B          ].
           LDD    <U0035                                                * 1212 DC 35          \5
           BEQ    L1222                                                 * 1214 27 0C          '.
           LDD    #159                                                  * 1216 CC 00 9F       L..
           STB    <U00BA                                                * 1219 D7 BA          W:
           LDD    <U0033                                                * 121B DC 33          \3
           STD    <U00BB                                                * 121D DD BB          ];
           LBRA   L12E3                                                 * 121F 16 00 C1       ..A
L1222      LBSR   L1485                                                 * 1222 17 02 60       ..`
           LBSR   L13DA                                                 * 1225 17 01 B2       ..2
           LDD    <U0033                                                * 1228 DC 33          \3
           STD    <U00BA                                                * 122A DD BA          ]:
           LDB    <Y00B9                                                * 122C D6 B9          V9
           SEX                                                          * 122E 1D             .
           ORB    #48                                                   * 122F CA 30          J0
           BRA    L125B                                                 * 1231 20 28           (
L1233      PSHS   U                                                     * 1233 34 40          4@
           LDD    <U001B                                                * 1235 DC 1B          \.
           ADDD   #1                                                    * 1237 C3 00 01       C..
           STD    <U001B                                                * 123A DD 1B          ].
           LDB    <U0061                                                * 123C D6 61          Va
           SEX                                                          * 123E 1D             .
           ORB    #8                                                    * 123F CA 08          J.
           STB    <U0061                                                * 1241 D7 61          Wa
           LBSR   L1485                                                 * 1243 17 02 3F       ..?
           LBSR   L13DA                                                 * 1246 17 01 91       ...
           LDD    <U0033                                                * 1249 DC 33          \3
           STB    <U00BA                                                * 124B D7 BA          W:
           LDB    <Y00B9                                                * 124D D6 B9          V9
           CLRA                                                         * 124F 4F             O
           ANDB   #240                                                  * 1250 C4 F0          Dp
           LBEQ   L13C1                                                 * 1252 10 27 01 6B    .'.k
           LDB    <Y00B9                                                * 1256 D6 B9          V9
           SEX                                                          * 1258 1D             .
           ORB    #16                                                   * 1259 CA 10          J.
L125B      STB    <Y00B9                                                * 125B D7 B9          W9
           LBRA   L13C1                                                 * 125D 16 01 61       ..a
L1260      PSHS   U                                                     * 1260 34 40          4@
           LDD    <U0062                                                * 1262 DC 62          \b
           ADDD   #1                                                    * 1264 C3 00 01       C..
           STD    <U0062                                                * 1267 DD 62          ]b
           CLRA                                                         * 1269 4F             O
           CLRB                                                         * 126A 5F             _
           STD    <U0033                                                * 126B DD 33          ]3
           LDB    [>U0062,Y]                                            * 126D E6 B9 00 62    f9.b
           CMPB   #45                                                   * 1271 C1 2D          A-
           BNE    L12A9                                                 * 1273 26 34          &4
           LDD    <U0062                                                * 1275 DC 62          \b
           ADDD   #1                                                    * 1277 C3 00 01       C..
           STD    <U0062                                                * 127A DD 62          ]b
           LDB    [>U0062,Y]                                            * 127C E6 B9 00 62    f9.b
           CMPB   #45                                                   * 1280 C1 2D          A-
           BNE    L1290                                                 * 1282 26 0C          &.
           LDD    <U0062                                                * 1284 DC 62          \b
           ADDD   #1                                                    * 1286 C3 00 01       C..
           STD    <U0062                                                * 1289 DD 62          ]b
           LDD    #131                                                  * 128B CC 00 83       L..
           BRA    L1296                                                 * 128E 20 06           .
L1290      LBSR   L12ED                                                 * 1290 17 00 5A       ..Z
           LDD    #130                                                  * 1293 CC 00 82       L..
L1296      STB    <U00BA                                                * 1296 D7 BA          W:
           LBSR   L1305                                                 * 1298 17 00 6A       ..j
           STD    -2,S                                                  * 129B ED 7E          m~
           BEQ    L12A4                                                 * 129D 27 05          '.
           LBSR   L1375                                                 * 129F 17 00 D3       ..S
           BRA    L12A7                                                 * 12A2 20 03           .
L12A4      LBSR   L1368                                                 * 12A4 17 00 C1       ..A
L12A7      PULS   PC,U                                                  * 12A7 35 C0          5@
L12A9      LBSR   L1305                                                 * 12A9 17 00 59       ..Y
           STD    -2,S                                                  * 12AC ED 7E          m~
           BNE    L12B5                                                 * 12AE 26 05          &.
           LBSR   L163E                                                 * 12B0 17 03 8B       ...
           PULS   PC,U                                                  * 12B3 35 C0          5@
L12B5      LDB    [>U0062,Y]                                            * 12B5 E6 B9 00 62    f9.b
           CMPB   #43                                                   * 12B9 C1 2B          A+
           BNE    L12E8                                                 * 12BB 26 2B          &+
           LDD    <U0062                                                * 12BD DC 62          \b
           ADDD   #1                                                    * 12BF C3 00 01       C..
           STD    <U0062                                                * 12C2 DD 62          ]b
           LDB    [>U0062,Y]                                            * 12C4 E6 B9 00 62    f9.b
           CMPB   #43                                                   * 12C8 C1 2B          A+
           BNE    L12DA                                                 * 12CA 26 0E          &.
           LDD    <U0062                                                * 12CC DC 62          \b
           ADDD   #1                                                    * 12CE C3 00 01       C..
           STD    <U0062                                                * 12D1 DD 62          ]b
           LDB    <U00BA                                                * 12D3 D6 BA          V:
           SEX                                                          * 12D5 1D             .
           ORB    #129                                                  * 12D6 CA 81          J.
           BRA    L12E1                                                 * 12D8 20 07           .
L12DA      BSR    L12ED                                                 * 12DA 8D 11          ..
           LDB    <U00BA                                                * 12DC D6 BA          V:
           SEX                                                          * 12DE 1D             .
           ORB    #128                                                  * 12DF CA 80          J.
L12E1      STB    <U00BA                                                * 12E1 D7 BA          W:
L12E3      LBSR   L1375                                                 * 12E3 17 00 8F       ...
           PULS   PC,U                                                  * 12E6 35 C0          5@
L12E8      LBSR   L15BC                                                 * 12E8 17 02 D1       ..Q
           PULS   PC,U                                                  * 12EB 35 C0          5@
L12ED      PSHS   U                                                     * 12ED 34 40          4@
           LDD    <U0035                                                * 12EF DC 35          \5
           LBEQ   L13C1                                                 * 12F1 10 27 00 CC    .'.L
           LBRA   L13C6                                                 * 12F5 16 00 CE       ..N
L12F8      PSHS   U                                                     * 12F8 34 40          4@
           LEAX   >L16CF,PC                                             * 12FA 30 8D 03 D1    0..Q
           PSHS   X                                                     * 12FE 34 10          4.
           LBSR   L074E                                                 * 1300 17 F4 4B       .tK
           PULS   PC,U,X                                                * 1303 35 D0          5P
L1305      PSHS   U                                                     * 1305 34 40          4@
           LEAS   -1,S                                                  * 1307 32 7F          2.
           LDD    #255                                                  * 1309 CC 00 FF       L..
           STB    ,S                                                    * 130C E7 E4          gd
           LDB    [>U0062,Y]                                            * 130E E6 B9 00 62    f9.b
           CLRA                                                         * 1312 4F             O
           ANDB   #223                                                  * 1313 C4 DF          D_
           TFR    D,X                                                   * 1315 1F 01          ..
           BRA    L132E                                                 * 1317 20 15           .
L1319      CLRA                                                         * 1319 4F             O
           CLRB                                                         * 131A 5F             _
           BRA    L132A                                                 * 131B 20 0D           .
L131D      LDD    #32                                                   * 131D CC 00 20       L.
           BRA    L132A                                                 * 1320 20 08           .
L1322      LDD    #64                                                   * 1322 CC 00 40       L.@
           BRA    L132A                                                 * 1325 20 03           .
L1327      LDD    #96                                                   * 1327 CC 00 60       L.`
L132A      STB    ,S                                                    * 132A E7 E4          gd
           BRA    L1342                                                 * 132C 20 14           .
L132E      CMPX   #88                                                   * 132E 8C 00 58       ..X
           BEQ    L1319                                                 * 1331 27 E6          'f
           CMPX   #89                                                   * 1333 8C 00 59       ..Y
           BEQ    L131D                                                 * 1336 27 E5          'e
           CMPX   #85                                                   * 1338 8C 00 55       ..U
           BEQ    L1322                                                 * 133B 27 E5          'e
           CMPX   #83                                                   * 133D 8C 00 53       ..S
           BEQ    L1327                                                 * 1340 27 E5          'e
L1342      LDB    ,S                                                    * 1342 E6 E4          fd
           CMPB   #255                                                  * 1344 C1 FF          A.
           BEQ    L1362                                                 * 1346 27 1A          '.
           LDD    <U0062                                                * 1348 DC 62          \b
           ADDD   #1                                                    * 134A C3 00 01       C..
           STD    <U0062                                                * 134D DD 62          ]b
           LDB    <U00BA                                                * 134F D6 BA          V:
           SEX                                                          * 1351 1D             .
           PSHS   D                                                     * 1352 34 06          4.
           LDB    2,S                                                   * 1354 E6 62          fb
           SEX                                                          * 1356 1D             .
           ORA    ,S+                                                   * 1357 AA E0          *`
           ORB    ,S+                                                   * 1359 EA E0          j`
           STB    <U00BA                                                * 135B D7 BA          W:
           LDD    #1                                                    * 135D CC 00 01       L..
           BRA    L1364                                                 * 1360 20 02           .
L1362      CLRA                                                         * 1362 4F             O
           CLRB                                                         * 1363 5F             _
L1364      LEAS   1,S                                                   * 1364 32 61          2a
           PULS   PC,U                                                  * 1366 35 C0          5@
L1368      PSHS   U                                                     * 1368 34 40          4@
           LEAX   >L16E7,PC                                             * 136A 30 8D 03 79    0..y
           PSHS   X                                                     * 136E 34 10          4.
           LBSR   L074E                                                 * 1370 17 F3 DB       .s[
           PULS   PC,U,X                                                * 1373 35 D0          5P
L1375      PSHS   U                                                     * 1375 34 40          4@
           LDB    <Y00B9                                                * 1377 D6 B9          V9
           SEX                                                          * 1379 1D             .
           ORB    #32                                                   * 137A CA 20          J
           STB    <Y00B9                                                * 137C D7 B9          W9
           LDD    <U001B                                                * 137E DC 1B          \.
           ADDD   #1                                                    * 1380 C3 00 01       C..
           STD    <U001B                                                * 1383 DD 1B          ].
           LDD    <U0021                                                * 1385 DC 21          \!
           ADDD   #1                                                    * 1387 C3 00 01       C..
           STD    <U0021                                                * 138A DD 21          ]!
           LDD    <U0035                                                * 138C DC 35          \5
           BEQ    L13B3                                                 * 138E 27 23          '#
           LDB    <U00BA                                                * 1390 D6 BA          V:
           SEX                                                          * 1392 1D             .
           ORB    #16                                                   * 1393 CA 10          J.
           STB    <U00BA                                                * 1395 D7 BA          W:
           LDB    [>U0062,Y]                                            * 1397 E6 B9 00 62    f9.b
           CMPB   #93                                                   * 139B C1 5D          A]
           BEQ    L13AC                                                 * 139D 27 0D          '.
           LEAX   >L16FE,PC                                             * 139F 30 8D 03 5B    0..[
           PSHS   X                                                     * 13A3 34 10          4.
           LBSR   L074E                                                 * 13A5 17 F3 A6       .s&
           LEAS   2,S                                                   * 13A8 32 62          2b
           BRA    L13B3                                                 * 13AA 20 07           .
L13AC      LDD    <U0062                                                * 13AC DC 62          \b
           ADDD   #1                                                    * 13AE C3 00 01       C..
           STD    <U0062                                                * 13B1 DD 62          ]b
L13B3      LDB    [>U0062,Y]                                            * 13B3 E6 B9 00 62    f9.b
           SEX                                                          * 13B7 1D             .
           TFR    D,X                                                   * 13B8 1F 01          ..
           BRA    L13CB                                                 * 13BA 20 0F           .
L13BC      LBSR   L1485                                                 * 13BC 17 00 C6       ..F
           BSR    L13DA                                                 * 13BF 8D 19          ..
L13C1      LDD    #1                                                    * 13C1 CC 00 01       L..
           PULS   PC,U                                                  * 13C4 35 C0          5@
L13C6      LBSR   L12F8                                                 * 13C6 17 FF 2F       ../
           PULS   PC,U                                                  * 13C9 35 C0          5@
L13CB      CMPX   #32                                                   * 13CB 8C 00 20       ..
           BEQ    L13BC                                                 * 13CE 27 EC          'l
           STX    -2,S                                                  * 13D0 AF 7E          /~
           LBEQ   L13BC                                                 * 13D2 10 27 FF E6    .'.f
           BRA    L13C6                                                 * 13D6 20 EE           n
           PULS   PC,U                                                  * 13D8 35 C0          5@
L13DA      PSHS   U,X,D                                                 * 13DA 34 56          4V
           LDB    <U005B                                                * 13DC D6 5B          V[
           LBEQ   L157C                                                 * 13DE 10 27 01 9A    .'..
           LEAX   >Y07C7,Y                                              * 13E2 30 A9 07 C7    0).G
           CMPX   >Y07E5,Y                                              * 13E6 AC A9 07 E5    ,).e
           LBCC   L157C                                                 * 13EA 10 24 01 8E    .$..
           LDD    <U004B                                                * 13EE DC 4B          \K
           BNE    L13F8                                                 * 13F0 26 06          &.
           LBSR   L0DEB                                                 * 13F2 17 F9 F6       .yv
           LBRA   L157C                                                 * 13F5 16 01 84       ...
L13F8      LDB    <U0061                                                * 13F8 D6 61          Va
           CLRA                                                         * 13FA 4F             O
           ANDB   #8                                                    * 13FB C4 08          D.
           BEQ    L1404                                                 * 13FD 27 05          '.
           LDD    #1                                                    * 13FF CC 00 01       L..
           BRA    L1407                                                 * 1402 20 03           .
L1404      LDD    #2                                                    * 1404 CC 00 02       L..
L1407      PSHS   D                                                     * 1407 34 06          4.
           LDD    [>U004B,Y]                                            * 1409 EC B9 00 4B    l9.K
           ADDD   <U001B                                                * 140D D3 1B          S.
           SUBD   ,S++                                                  * 140F A3 E1          #a
           STD    2,S                                                   * 1411 ED 62          mb
           LBRA   L1476                                                 * 1413 16 00 60       ..`
L1416      LDX    >Y07E5,Y                                              * 1416 AE A9 07 E5    .).e
           LEAX   -3,X                                                  * 141A 30 1D          0.
           STX    >Y07E5,Y                                              * 141C AF A9 07 E5    /).e
           LDU    1,X                                                   * 1420 EE 01          n.
           LDB    ,U                                                    * 1422 E6 C4          fD
           SEX                                                          * 1424 1D             .
           PSHS   D                                                     * 1425 34 06          4.
           LDB    <U0061                                                * 1427 D6 61          Va
           SEX                                                          * 1429 1D             .
           ORA    ,S+                                                   * 142A AA E0          *`
           ORB    ,S+                                                   * 142C EA E0          j`
           PSHS   D                                                     * 142E 34 06          4.
           LDB    [>Y07E5,Y]                                            * 1430 E6 B9 07 E5    f9.e
           SEX                                                          * 1434 1D             .
           ORA    ,S+                                                   * 1435 AA E0          *`
           ORB    ,S+                                                   * 1437 EA E0          j`
           STD    ,S                                                    * 1439 ED E4          md
           LDB    1,U                                                   * 143B E6 41          fA
           CLRA                                                         * 143D 4F             O
           ANDB   #66                                                   * 143E C4 42          DB
           BNE    L145E                                                 * 1440 26 1C          &.
           LDD    #1                                                    * 1442 CC 00 01       L..
           STD    <U00BD                                                * 1445 DD BD          ]=
           LDD    8,U                                                   * 1447 EC 48          lH
           BNE    L1452                                                 * 1449 26 07          &.
           LDD    <Y0057                                                * 144B DC 57          \W
           ADDD   #1                                                    * 144D C3 00 01       C..
           STD    <Y0057                                                * 1450 DD 57          ]W
L1452      LDD    2,S                                                   * 1452 EC 62          lb
           PSHS   D                                                     * 1454 34 06          4.
           LDD    2,S                                                   * 1456 EC 62          lb
           PSHS   D                                                     * 1458 34 06          4.
           PSHS   U                                                     * 145A 34 40          4@
           BRA    L1471                                                 * 145C 20 13           .
L145E      LDD    <Y0059                                                * 145E DC 59          \Y
           ADDD   #1                                                    * 1460 C3 00 01       C..
           STD    <Y0059                                                * 1463 DD 59          ]Y
           LDD    2,S                                                   * 1465 EC 62          lb
           PSHS   D                                                     * 1467 34 06          4.
           LDD    2,S                                                   * 1469 EC 62          lb
           PSHS   D                                                     * 146B 34 06          4.
           LDD    <U007A                                                * 146D DC 7A          \z
           PSHS   D                                                     * 146F 34 06          4.
L1471      LBSR   L2207                                                 * 1471 17 0D 93       ...
           LEAS   6,S                                                   * 1474 32 66          2f
L1476      LEAX   >Y07C7,Y                                              * 1476 30 A9 07 C7    0).G
           CMPX   >Y07E5,Y                                              * 147A AC A9 07 E5    ,).e
           LBCS   L1416                                                 * 147E 10 25 FF 94    .%..
           LBRA   L157C                                                 * 1482 16 00 F7       ..w
L1485      PSHS   U,D                                                   * 1485 34 46          4F
           LDB    <U005B                                                * 1487 D6 5B          V[
           BEQ    L14E2                                                 * 1489 27 57          'W
           LEAX   >Y07C7,Y                                              * 148B 30 A9 07 C7    0).G
           CMPX   >Y07E5,Y                                              * 148F AC A9 07 E5    ,).e
           BCC    L14E2                                                 * 1493 24 4D          $M
           LEAU   >Y07C7,Y                                              * 1495 33 A9 07 C7    3).G
           BRA    L14DB                                                 * 1499 20 40           @
L149B      PSHS   U                                                     * 149B 34 40          4@
           BSR    L14E6                                                 * 149D 8D 47          .G
           STD    ,S++                                                  * 149F ED E1          ma
           BNE    L14DB                                                 * 14A1 26 38          &8
           LDD    1,U                                                   * 14A3 EC 41          lA
           PSHS   D                                                     * 14A5 34 06          4.
           LBSR   L1580                                                 * 14A7 17 00 D6       ..V
           STD    ,S++                                                  * 14AA ED E1          ma
           BEQ    L14D9                                                 * 14AC 27 2B          '+
           STU    ,S                                                    * 14AE EF E4          od
           BRA    L14BE                                                 * 14B0 20 0C           .
L14B2      LDB    ,U                                                    * 14B2 E6 C4          fD
           LDX    ,S                                                    * 14B4 AE E4          .d
           STB    -3,X                                                  * 14B6 E7 1D          g.
           LDD    1,U                                                   * 14B8 EC 41          lA
           LDX    ,S                                                    * 14BA AE E4          .d
           STD    -2,X                                                  * 14BC ED 1E          m.
L14BE      LDD    ,S                                                    * 14BE EC E4          ld
           ADDD   #3                                                    * 14C0 C3 00 03       C..
           STD    ,S                                                    * 14C3 ED E4          md
           CMPD   >Y07E5,Y                                              * 14C5 10 A3 A9 07 E5 .#).e
           BCS    L14B2                                                 * 14CA 25 E6          %f
           LDD    >Y07E5,Y                                              * 14CC EC A9 07 E5    l).e
           ADDD   #-3                                                   * 14D0 C3 FF FD       C.}
           STD    >Y07E5,Y                                              * 14D3 ED A9 07 E5    m).e
           BRA    L14DB                                                 * 14D7 20 02           .
L14D9      LEAU   3,U                                                   * 14D9 33 43          3C
L14DB      CMPU   >Y07E5,Y                                              * 14DB 11 A3 A9 07 E5 .#).e
           BCS    L149B                                                 * 14E0 25 B9          %9
L14E2      CLRA                                                         * 14E2 4F             O
           CLRB                                                         * 14E3 5F             _
           PULS   PC,U,X                                                * 14E4 35 D0          5P
L14E6      PSHS   U                                                     * 14E6 34 40          4@
           LDU    4,S                                                   * 14E8 EE 64          nd
           LEAS   -4,S                                                  * 14EA 32 7C          2|
           LDB    [<$01,U]                                              * 14EC E6 D8 01       fX.
           SEX                                                          * 14EF 1D             .
           PSHS   D                                                     * 14F0 34 06          4.
           LDB    <U0061                                                * 14F2 D6 61          Va
           SEX                                                          * 14F4 1D             .
           ORA    ,S+                                                   * 14F5 AA E0          *`
           ORB    ,S+                                                   * 14F7 EA E0          j`
           PSHS   D                                                     * 14F9 34 06          4.
           LDB    ,U                                                    * 14FB E6 C4          fD
           SEX                                                          * 14FD 1D             .
           ORA    ,S+                                                   * 14FE AA E0          *`
           ORB    ,S+                                                   * 1500 EA E0          j`
           STD    ,S                                                    * 1502 ED E4          md
           STU    2,S                                                   * 1504 EF 62          ob
           LBRA   L156A                                                 * 1506 16 00 61       ..a
L1509      LDX    2,S                                                   * 1509 AE 62          .b
           LDB    [<$01,X]                                              * 150B E6 98 01       f..
           SEX                                                          * 150E 1D             .
           PSHS   D                                                     * 150F 34 06          4.
           LDB    <U0061                                                * 1511 D6 61          Va
           SEX                                                          * 1513 1D             .
           ORA    ,S+                                                   * 1514 AA E0          *`
           ORB    ,S+                                                   * 1516 EA E0          j`
           PSHS   D                                                     * 1518 34 06          4.
           LDB    [<$04,S]                                              * 151A E6 F8 04       fx.
           SEX                                                          * 151D 1D             .
           ORA    ,S+                                                   * 151E AA E0          *`
           ORB    ,S+                                                   * 1520 EA E0          j`
           EORA   ,S                                                    * 1522 A8 E4          (d
           EORB   1,S                                                   * 1524 E8 61          ha
           CMPD   #64                                                   * 1526 10 83 00 40    ...@
           BNE    L156A                                                 * 152A 26 3E          &>
           BRA    L1538                                                 * 152C 20 0A           .
L152E      LDB    3,U                                                   * 152E E6 43          fC
           STB    ,U                                                    * 1530 E7 C4          gD
           LDD    4,U                                                   * 1532 EC 44          lD
           STD    1,U                                                   * 1534 ED 41          mA
           LEAU   3,U                                                   * 1536 33 43          3C
L1538      PSHS   U                                                     * 1538 34 40          4@
           LDD    #3                                                    * 153A CC 00 03       L..
           ADDD   ,S++                                                  * 153D E3 E1          ca
           CMPD   2,S                                                   * 153F 10 A3 62       .#b
           BCS    L152E                                                 * 1542 25 EA          %j
           BRA    L1553                                                 * 1544 20 0D           .
L1546      LDB    [<$02,S]                                              * 1546 E6 F8 02       fx.
           STB    ,U                                                    * 1549 E7 C4          gD
           LDX    2,S                                                   * 154B AE 62          .b
           LDD    1,X                                                   * 154D EC 01          l.
           STD    1,U                                                   * 154F ED 41          mA
           LEAU   3,U                                                   * 1551 33 43          3C
L1553      LDD    2,S                                                   * 1553 EC 62          lb
           ADDD   #3                                                    * 1555 C3 00 03       C..
           STD    2,S                                                   * 1558 ED 62          mb
           CMPD   >Y07E5,Y                                              * 155A 10 A3 A9 07 E5 .#).e
           BCS    L1546                                                 * 155F 25 E5          %e
           STU    >Y07E5,Y                                              * 1561 EF A9 07 E5    o).e
           LDD    #1                                                    * 1565 CC 00 01       L..
           BRA    L157C                                                 * 1568 20 12           .
L156A      LDD    2,S                                                   * 156A EC 62          lb
           ADDD   #3                                                    * 156C C3 00 03       C..
           STD    2,S                                                   * 156F ED 62          mb
           CMPD   >Y07E5,Y                                              * 1571 10 A3 A9 07 E5 .#).e
           LBCS   L1509                                                 * 1576 10 25 FF 8F    .%..
           CLRA                                                         * 157A 4F             O
           CLRB                                                         * 157B 5F             _
L157C      LEAS   4,S                                                   * 157C 32 64          2d
           PULS   PC,U                                                  * 157E 35 C0          5@
L1580      PSHS   U                                                     * 1580 34 40          4@
           LDU    4,S                                                   * 1582 EE 64          nd
           LDB    ,U                                                    * 1584 E6 C4          fD
           CLRA                                                         * 1586 4F             O
           ANDB   #7                                                    * 1587 C4 07          D.
           CMPD   #4                                                    * 1589 10 83 00 04    ....
           BNE    L159F                                                 * 158D 26 10          &.
           LDB    <U0061                                                * 158F D6 61          Va
           CLRA                                                         * 1591 4F             O
           ANDB   #176                                                  * 1592 C4 B0          D0
           CMPD   #160                                                  * 1594 10 83 00 A0    ...
           BNE    L159F                                                 * 1598 26 05          &.
           LDD    #1                                                    * 159A CC 00 01       L..
           BRA    L15A1                                                 * 159D 20 02           .
L159F      CLRA                                                         * 159F 4F             O
           CLRB                                                         * 15A0 5F             _
L15A1      PULS   PC,U                                                  * 15A1 35 C0          5@
L15A3      PSHS   U                                                     * 15A3 34 40          4@
           LDD    <U0062                                                * 15A5 DC 62          \b
           ADDD   #1                                                    * 15A7 C3 00 01       C..
           STD    <U0062                                                * 15AA DD 62          ]b
           LBSR   L1305                                                 * 15AC 17 FD 56       .}V
           STD    -2,S                                                  * 15AF ED 7E          m~
           BNE    L15B8                                                 * 15B1 26 05          &.
           LBSR   L163E                                                 * 15B3 17 00 88       ...
           PULS   PC,U                                                  * 15B6 35 C0          5@
L15B8      BSR    L15BC                                                 * 15B8 8D 02          ..
           PULS   PC,U                                                  * 15BA 35 C0          5@
L15BC      PSHS   U                                                     * 15BC 34 40          4@
           LDD    <U0037                                                * 15BE DC 37          \7
           BLT    L15D6                                                 * 15C0 2D 14          -.
           LDD    <U0037                                                * 15C2 DC 37          \7
           BNE    L15E9                                                 * 15C4 26 23          &#
           LDD    <U0033                                                * 15C6 DC 33          \3
           CMPD   #127                                                  * 15C8 10 83 00 7F    ....
           BGT    L15D6                                                 * 15CC 2E 08          ..
           LDD    <U0033                                                * 15CE DC 33          \3
           CMPD   #-128                                                 * 15D0 10 83 FF 80    ....
           BGE    L15E9                                                 * 15D4 2C 13          ,.
L15D6      LDD    <U0033                                                * 15D6 DC 33          \3
           STD    <U00BB                                                * 15D8 DD BB          ];
           LDD    <U001B                                                * 15DA DC 1B          \.
           ADDD   #2                                                    * 15DC C3 00 02       C..
           STD    <U001B                                                * 15DF DD 1B          ].
           LDB    <U00BA                                                * 15E1 D6 BA          V:
           SEX                                                          * 15E3 1D             .
           ORB    #137                                                  * 15E4 CA 89          J.
           LBRA   L16C6                                                 * 15E6 16 00 DD       ..]
L15E9      LDD    <U0037                                                * 15E9 DC 37          \7
           BNE    L15F9                                                 * 15EB 26 0C          &.
           LDD    <U0033                                                * 15ED DC 33          \3
           BNE    L15F9                                                 * 15EF 26 08          &.
           LDB    <U00BA                                                * 15F1 D6 BA          V:
           SEX                                                          * 15F3 1D             .
           ORB    #132                                                  * 15F4 CA 84          J.
           LBRA   L16C6                                                 * 15F6 16 00 CD       ..M
L15F9      LDD    <U0037                                                * 15F9 DC 37          \7
           BGT    L1611                                                 * 15FB 2E 14          ..
           LDD    <U0035                                                * 15FD DC 35          \5
           BNE    L1611                                                 * 15FF 26 10          &.
           LDD    <U0033                                                * 1601 DC 33          \3
           CMPD   #15                                                   * 1603 10 83 00 0F    ....
           BGT    L1611                                                 * 1607 2E 08          ..
           LDD    <U0033                                                * 1609 DC 33          \3
           CMPD   #-16                                                  * 160B 10 83 FF F0    ...p
           BGE    L162B                                                 * 160F 2C 1A          ,.
L1611      LDD    <U0033                                                * 1611 DC 33          \3
           STB    <U00BB                                                * 1613 D7 BB          W;
           LDD    <U001B                                                * 1615 DC 1B          \.
           ADDD   #1                                                    * 1617 C3 00 01       C..
           STD    <U001B                                                * 161A DD 1B          ].
           LDB    <U0061                                                * 161C D6 61          Va
           SEX                                                          * 161E 1D             .
           ORB    #8                                                    * 161F CA 08          J.
           STB    <U0061                                                * 1621 D7 61          Wa
           LDB    <U00BA                                                * 1623 D6 BA          V:
           SEX                                                          * 1625 1D             .
           ORB    #136                                                  * 1626 CA 88          J.
           LBRA   L16C6                                                 * 1628 16 00 9B       ...
L162B      LDB    <U00BA                                                * 162B D6 BA          V:
           SEX                                                          * 162D 1D             .
           PSHS   D                                                     * 162E 34 06          4.
           LDD    <U0033                                                * 1630 DC 33          \3
           CLRA                                                         * 1632 4F             O
           ANDB   #31                                                   * 1633 C4 1F          D.
           ORA    ,S+                                                   * 1635 AA E0          *`
           ORB    ,S+                                                   * 1637 EA E0          j`
           LBRA   L16C6                                                 * 1639 16 00 8A       ...
           FCB    $35                                                   * 163C 35             5
           FCB    $C0                                                   * 163D C0             @
L163E      PSHS   U                                                     * 163E 34 40          4@
           LDB    [>U0062,Y]                                            * 1640 E6 B9 00 62    f9.b
           CLRA                                                         * 1644 4F             O
           ANDB   #223                                                  * 1645 C4 DF          D_
           CMPD   #80                                                   * 1647 10 83 00 50    ...P
           BNE    L165A                                                 * 164B 26 0D          &.
           LDX    <U0062                                                * 164D 9E 62          .b
           LDB    1,X                                                   * 164F E6 01          f.
           CLRA                                                         * 1651 4F             O
           ANDB   #223                                                  * 1652 C4 DF          D_
           CMPD   #67                                                   * 1654 10 83 00 43    ...C
           BEQ    L165F                                                 * 1658 27 05          '.
L165A      LBSR   L1368                                                 * 165A 17 FD 0B       .}.
           PULS   PC,U                                                  * 165D 35 C0          5@
L165F      LDD    <U0062                                                * 165F DC 62          \b
           ADDD   #2                                                    * 1661 C3 00 02       C..
           STD    <U0062                                                * 1664 DD 62          ]b
           LDB    [>U0062,Y]                                            * 1666 E6 B9 00 62    f9.b
           CLRA                                                         * 166A 4F             O
           ANDB   #223                                                  * 166B C4 DF          D_
           CMPD   #82                                                   * 166D 10 83 00 52    ...R
           BNE    L167A                                                 * 1671 26 07          &.
           LDD    <U0062                                                * 1673 DC 62          \b
           ADDD   #1                                                    * 1675 C3 00 01       C..
           STD    <U0062                                                * 1678 DD 62          ]b
L167A      LDD    <U001B                                                * 167A DC 1B          \.
           ADDD   #1                                                    * 167C C3 00 01       C..
           STD    <U001B                                                * 167F DD 1B          ].
           LDB    <U0061                                                * 1681 D6 61          Va
           SEX                                                          * 1683 1D             .
           ORB    #128                                                  * 1684 CA 80          J.
           STB    <U0061                                                * 1686 D7 61          Wa
           LDD    <U0033                                                * 1688 DC 33          \3
           PSHS   D                                                     * 168A 34 06          4.
           LDD    <U004D                                                * 168C DC 4D          \M
           ADDD   <U001B                                                * 168E D3 1B          S.
           ADDD   #1                                                    * 1690 C3 00 01       C..
           NEGA                                                         * 1693 40             @
           NEGB                                                         * 1694 50             P
           SBCA   #0                                                    * 1695 82 00          ..
           ADDD   ,S++                                                  * 1697 E3 E1          ca
           STD    <U0033                                                * 1699 DD 33          ]3
           LDD    <U0037                                                * 169B DC 37          \7
           BLE    L16B1                                                 * 169D 2F 12          /.
           LDD    <U0033                                                * 169F DC 33          \3
           STB    <U00BB                                                * 16A1 D7 BB          W;
           LDB    <U0061                                                * 16A3 D6 61          Va
           SEX                                                          * 16A5 1D             .
           ORB    #8                                                    * 16A6 CA 08          J.
           STB    <U0061                                                * 16A8 D7 61          Wa
           LDB    <U00BA                                                * 16AA D6 BA          V:
           SEX                                                          * 16AC 1D             .
           ORB    #140                                                  * 16AD CA 8C          J.
           BRA    L16C6                                                 * 16AF 20 15           .
L16B1      LDD    <U001B                                                * 16B1 DC 1B          \.
           ADDD   #1                                                    * 16B3 C3 00 01       C..
           STD    <U001B                                                * 16B6 DD 1B          ].
           LDD    <U0033                                                * 16B8 DC 33          \3
           ADDD   #-1                                                   * 16BA C3 FF FF       C..
           STD    <U0033                                                * 16BD DD 33          ]3
           STD    <U00BB                                                * 16BF DD BB          ];
           LDB    <U00BA                                                * 16C1 D6 BA          V:
           SEX                                                          * 16C3 1D             .
           ORB    #141                                                  * 16C4 CA 8D          J.
L16C6      STB    <U00BA                                                * 16C6 D7 BA          W:
           LBSR   L1375                                                 * 16C8 17 FC AA       .|*
           PULS   PC,U                                                  * 16CB 35 C0          5@
           PULS   PC,U                                                  * 16CD 35 C0          5@
L16CF      FCC    "illegal addressing mode"                             * 16CF 69 6C 6C 65 67 61 6C 20 61 64 64 72 65 73 73 69 6E 67 20 6D 6F 64 65 illegal addressing mode
           FCB    $00                                                   * 16E6 00             .
L16E7      FCC    "illegal index register"                              * 16E7 69 6C 6C 65 67 61 6C 20 69 6E 64 65 78 20 72 65 67 69 73 74 65 72 illegal index register
           FCB    $00                                                   * 16FD 00             .
L16FE      FCC    "bracket missing"                                     * 16FE 62 72 61 63 6B 65 74 20 6D 69 73 73 69 6E 67 bracket missing
           FCB    $00                                                   * 170D 00             .
           PSHS   U                                                     * 170E 34 40          4@
           LBSR   L1771                                                 * 1710 17 00 5E       ..^
           STD    -2,S                                                  * 1713 ED 7E          m~
           BNE    L1725                                                 * 1715 26 0E          &.
           LBRA   L17F8                                                 * 1717 16 00 DE       ..^
           BRA    L1725                                                 * 171A 20 09           .
L171C      CLRA                                                         * 171C 4F             O
           CLRB                                                         * 171D 5F             _
           PSHS   D                                                     * 171E 34 06          4.
           LBSR   L1912                                                 * 1720 17 01 EF       ..o
           LEAS   2,S                                                   * 1723 32 62          2b
L1725      LDD    <U0031                                                * 1725 DC 31          \1
           ADDD   #-1                                                   * 1727 C3 FF FF       C..
           STD    <U0031                                                * 172A DD 31          ]1
           SUBD   #-1                                                   * 172C 83 FF FF       ...
           BNE    L171C                                                 * 172F 26 EB          &k
           LBRA   L1D8B                                                 * 1731 16 06 57       ..W
           PSHS   U                                                     * 1734 34 40          4@
           BSR    L1771                                                 * 1736 8D 39          .9
           STD    -2,S                                                  * 1738 ED 7E          m~
           LBEQ   L17F8                                                 * 173A 10 27 00 BA    .'.:
           LEAX   >reldt,Y                                              * 173E 30 A9 00 51    0).Q
           STX    <U004F                                                * 1742 9F 4F          .O
           PSHS   X                                                     * 1744 34 10          4.
           LBSR   L179F                                                 * 1746 17 00 56       ..V
           STD    [,S++]                                                * 1749 ED F1          mq
           LDD    <U0064                                                * 174B DC 64          \d
           BEQ    L1764                                                 * 174D 27 15          '.
           LDB    <U005D                                                * 174F D6 5D          V]
           SEX                                                          * 1751 1D             .
           ANDB   #254                                                  * 1752 C4 FE          D~
           PSHS   D                                                     * 1754 34 06          4.
           LBSR   L20A1                                                 * 1756 17 09 48       ..H
           LEAS   2,S                                                   * 1759 32 62          2b
           LDD    <reldt                                                * 175B DC 51          \Q
           PSHS   D                                                     * 175D 34 06          4.
           LBSR   L20E0                                                 * 175F 17 09 7E       ..~
           LEAS   2,S                                                   * 1762 32 62          2b
L1764      LDD    <reldt                                                * 1764 DC 51          \Q
           ADDD   <U0031                                                * 1766 D3 31          S1
           PSHS   D                                                     * 1768 34 06          4.
           BSR    L17AF                                                 * 176A 8D 43          .C
           LEAS   2,S                                                   * 176C 32 62          2b
           LBRA   L1D8B                                                 * 176E 16 06 1A       ...
L1771      PSHS   U,D                                                   * 1771 34 46          4F
           CLRA                                                         * 1773 4F             O
           CLRB                                                         * 1774 5F             _
           STD    ,S                                                    * 1775 ED E4          md
           LDU    <U0078                                                * 1777 DE 78          ^x
           LBSR   L2426                                                 * 1779 17 0C AA       ..*
           STD    -2,S                                                  * 177C ED 7E          m~
           BEQ    L1799                                                 * 177E 27 19          '.
           LBSR   L1485                                                 * 1780 17 FD 02       .}.
           LEAX   >Y07C7,Y                                              * 1783 30 A9 07 C7    0).G
           CMPX   >Y07E5,Y                                              * 1787 AC A9 07 E5    ,).e
           BNE    L1794                                                 * 178B 26 07          &.
           LDD    #1                                                    * 178D CC 00 01       L..
           STD    ,S                                                    * 1790 ED E4          md
           BRA    L1799                                                 * 1792 20 05           .
L1794      LBSR   L0DEB                                                 * 1794 17 F6 54       .vT
           STD    <U0031                                                * 1797 DD 31          ]1
L1799      STU    <U0078                                                * 1799 DF 78          _x
           LDD    ,S                                                    * 179B EC E4          ld
           PULS   PC,U,X                                                * 179D 35 D0          5P
L179F      PSHS   U                                                     * 179F 34 40          4@
           LDD    <U0053                                                * 17A1 DC 53          \S
           BNE    L17A9                                                 * 17A3 26 04          &.
           CLRA                                                         * 17A5 4F             O
           CLRB                                                         * 17A6 5F             _
           BRA    L17AD                                                 * 17A7 20 04           .
L17A9      LDD    [>U0053,Y]                                            * 17A9 EC B9 00 53    l9.S
L17AD      PULS   PC,U                                                  * 17AD 35 C0          5@
L17AF      PSHS   U                                                     * 17AF 34 40          4@
           LDD    <U0053                                                * 17B1 DC 53          \S
           BEQ    L17BB                                                 * 17B3 27 06          '.
           LDD    4,S                                                   * 17B5 EC 64          ld
           STD    [>U0053,Y]                                            * 17B7 ED B9 00 53    m9.S
L17BB      LDD    4,S                                                   * 17BB EC 64          ld
           PULS   PC,U                                                  * 17BD 35 C0          5@
           PSHS   U                                                     * 17BF 34 40          4@
           LDD    #6                                                    * 17C1 CC 00 06       L..
           PSHS   D                                                     * 17C4 34 06          4.
           BSR    L17D5                                                 * 17C6 8D 0D          ..
           PULS   PC,U,X                                                * 17C8 35 D0          5P
           PSHS   U                                                     * 17CA 34 40          4@
           LDD    #5                                                    * 17CC CC 00 05       L..
           PSHS   D                                                     * 17CF 34 06          4.
           BSR    L17D5                                                 * 17D1 8D 02          ..
           PULS   PC,U,X                                                * 17D3 35 D0          5P
L17D5      PSHS   U                                                     * 17D5 34 40          4@
           LDD    <U0064                                                * 17D7 DC 64          \d
           BNE    L17E6                                                 * 17D9 26 0B          &.
           LEAX   >L1D90,PC                                             * 17DB 30 8D 05 B1    0..1
           PSHS   X                                                     * 17DF 34 10          4.
           LBSR   L074E                                                 * 17E1 17 EF 6A       .oj
           PULS   PC,U,X                                                * 17E4 35 D0          5P
L17E6      LDD    4,S                                                   * 17E6 EC 64          ld
           PSHS   D                                                     * 17E8 34 06          4.
           LBSR   L20A1                                                 * 17EA 17 08 B4       ..4
           LEAS   2,S                                                   * 17ED 32 62          2b
           LDU    <U0078                                                * 17EF DE 78          ^x
           LBSR   L2426                                                 * 17F1 17 0C 32       ..2
           STD    -2,S                                                  * 17F4 ED 7E          m~
           BNE    L17FC                                                 * 17F6 26 04          &.
L17F8      CLRA                                                         * 17F8 4F             O
           CLRB                                                         * 17F9 5F             _
           PULS   PC,U                                                  * 17FA 35 C0          5@
L17FC      STU    <U0078                                                * 17FC DF 78          _x
           LBSR   L1485                                                 * 17FE 17 FC 84       .|.
           LDD    <U0031                                                * 1801 DC 31          \1
           PSHS   D                                                     * 1803 34 06          4.
           LBSR   L20E0                                                 * 1805 17 08 D8       ..X
           LEAS   2,S                                                   * 1808 32 62          2b
           LEAX   >U0031,Y                                              * 180A 30 A9 00 31    0).1
           STX    <U004F                                                * 180E 9F 4F          .O
           LBRA   L1D8B                                                 * 1810 16 05 78       ..x
           PSHS   U                                                     * 1813 34 40          4@
           LDD    #1                                                    * 1815 CC 00 01       L..
           PSHS   D                                                     * 1818 34 06          4.
           BSR    L1829                                                 * 181A 8D 0D          ..
           PULS   PC,U,X                                                * 181C 35 D0          5P
           PSHS   U                                                     * 181E 34 40          4@
           LDD    #2                                                    * 1820 CC 00 02       L..
           PSHS   D                                                     * 1823 34 06          4.
           BSR    L1829                                                 * 1825 8D 02          ..
           PULS   PC,U,X                                                * 1827 35 D0          5P
L1829      PSHS   U,X,D                                                 * 1829 34 56          4V
           LDB    [>U0062,Y]                                            * 182B E6 B9 00 62    f9.b
           STB    1,S                                                   * 182F E7 61          ga
           LBEQ   L18B2                                                 * 1831 10 27 00 7D    .'.}
           LDD    <U0062                                                * 1835 DC 62          \b
           STD    2,S                                                   * 1837 ED 62          mb
           BRA    L1848                                                 * 1839 20 0D           .
L183B      LDB    ,S                                                    * 183B E6 E4          fd
           SEX                                                          * 183D 1D             .
           PSHS   D                                                     * 183E 34 06          4.
           LDB    3,S                                                   * 1840 E6 63          fc
           SEX                                                          * 1842 1D             .
           CMPD   ,S++                                                  * 1843 10 A3 E1       .#a
           BEQ    L1854                                                 * 1846 27 0C          '.
L1848      LDX    2,S                                                   * 1848 AE 62          .b
           LEAX   1,X                                                   * 184A 30 01          0.
           STX    2,S                                                   * 184C AF 62          /b
           LDB    ,X                                                    * 184E E6 84          f.
           STB    ,S                                                    * 1850 E7 E4          gd
           BNE    L183B                                                 * 1852 26 E7          &g
L1854      LDB    ,S                                                    * 1854 E6 E4          fd
           LBEQ   L18AE                                                 * 1856 10 27 00 54    .'.T
           LDD    2,S                                                   * 185A EC 62          lb
           SUBD   #2                                                    * 185C 83 00 02       ...
           STD    2,S                                                   * 185F ED 62          mb
           CMPD   <U0062                                                * 1861 10 93 62       ..b
           BCS    L18A2                                                 * 1864 25 3C          %<
           BRA    L1878                                                 * 1866 20 10           .
L1868      LDX    <U0062                                                * 1868 9E 62          .b
           LEAX   1,X                                                   * 186A 30 01          0.
           STX    <U0062                                                * 186C 9F 62          .b
           LDB    ,X                                                    * 186E E6 84          f.
           SEX                                                          * 1870 1D             .
           PSHS   D                                                     * 1871 34 06          4.
           LBSR   L1912                                                 * 1873 17 00 9C       ...
           LEAS   2,S                                                   * 1876 32 62          2b
L1878      LDD    <U0062                                                * 1878 DC 62          \b
           CMPD   2,S                                                   * 187A 10 A3 62       .#b
           BCS    L1868                                                 * 187D 25 E9          %i
           LDX    <U0062                                                * 187F 9E 62          .b
           LEAX   1,X                                                   * 1881 30 01          0.
           STX    <U0062                                                * 1883 9F 62          .b
           LDB    ,X                                                    * 1885 E6 84          f.
           STB    ,S                                                    * 1887 E7 E4          gd
           LDD    8,S                                                   * 1889 EC 68          lh
           CMPD   #2                                                    * 188B 10 83 00 02    ....
           BNE    L1898                                                 * 188F 26 07          &.
           LDB    ,S                                                    * 1891 E6 E4          fd
           SEX                                                          * 1893 1D             .
           ORB    #128                                                  * 1894 CA 80          J.
           STB    ,S                                                    * 1896 E7 E4          gd
L1898      LDB    ,S                                                    * 1898 E6 E4          fd
           SEX                                                          * 189A 1D             .
           PSHS   D                                                     * 189B 34 06          4.
           LBSR   L1912                                                 * 189D 17 00 72       ..r
           LEAS   2,S                                                   * 18A0 32 62          2b
L18A2      LDD    <U0062                                                * 18A2 DC 62          \b
           ADDD   #2                                                    * 18A4 C3 00 02       C..
           STD    <U0062                                                * 18A7 DD 62          ]b
           LDD    #1                                                    * 18A9 CC 00 01       L..
           BRA    L18EF                                                 * 18AC 20 41           A
L18AE      LDD    2,S                                                   * 18AE EC 62          lb
           STD    <U0062                                                * 18B0 DD 62          ]b
L18B2      BSR    L18B6                                                 * 18B2 8D 02          ..
           BRA    L18EF                                                 * 18B4 20 39           9
L18B6      PSHS   U                                                     * 18B6 34 40          4@
           LEAX   >L1D9E,PC                                             * 18B8 30 8D 04 E2    0..b
           PSHS   X                                                     * 18BC 34 10          4.
           LBSR   L074E                                                 * 18BE 17 EE 8D       .n.
           PULS   PC,U,X                                                * 18C1 35 D0          5P
           PSHS   U                                                     * 18C3 34 40          4@
           LEAX   >U0032,Y                                              * 18C5 30 A9 00 32    0).2
           STX    >U00CA,Y                                              * 18C9 AF A9 00 CA    /).J
           LDD    #1                                                    * 18CD CC 00 01       L..
           PSHS   D                                                     * 18D0 34 06          4.
           LEAX   >L23D4,PC                                             * 18D2 30 8D 0A FE    0..~
           BRA    L18EB                                                 * 18D6 20 13           .
           PSHS   U                                                     * 18D8 34 40          4@
           LEAX   >U0031,Y                                              * 18DA 30 A9 00 31    0).1
           STX    >U00CA,Y                                              * 18DE AF A9 00 CA    /).J
           LDD    #2                                                    * 18E2 CC 00 02       L..
           PSHS   D                                                     * 18E5 34 06          4.
           LEAX   >L23B8,PC                                             * 18E7 30 8D 0A CD    0..M
L18EB      PSHS   X                                                     * 18EB 34 10          4.
           BSR    L18F3                                                 * 18ED 8D 04          ..
L18EF      LEAS   4,S                                                   * 18EF 32 64          2d
           PULS   PC,U                                                  * 18F1 35 C0          5@
L18F3      PSHS   U                                                     * 18F3 34 40          4@
           BRA    L1900                                                 * 18F5 20 09           .
L18F7      BSR    L1934                                                 * 18F7 8D 3B          .;
           LDD    <U0062                                                * 18F9 DC 62          \b
           ADDD   #1                                                    * 18FB C3 00 01       C..
           STD    <U0062                                                * 18FE DD 62          ]b
L1900      LDD    6,S                                                   * 1900 EC 66          lf
           STD    <U001B                                                * 1902 DD 1B          ].
           JSR    [<$04,S]                                              * 1904 AD F8 04       -x.
           LDB    [>U0062,Y]                                            * 1907 E6 B9 00 62    f9.b
           CMPB   #44                                                   * 190B C1 2C          A,
           BEQ    L18F7                                                 * 190D 27 E8          'h
           LBRA   L1D8B                                                 * 190F 16 04 79       ..y
L1912      PSHS   U                                                     * 1912 34 40          4@
           LDD    <U001B                                                * 1914 DC 1B          \.
           CMPD   #4                                                    * 1916 10 83 00 04    ....
           BLT    L191E                                                 * 191A 2D 02          -.
           BSR    L1934                                                 * 191C 8D 16          ..
L191E      LDD    <U001B                                                * 191E DC 1B          \.
           ADDD   #1                                                    * 1920 C3 00 01       C..
           STD    <U001B                                                * 1923 DD 1B          ].
           SUBD   #1                                                    * 1925 83 00 01       ...
           ADDD   >U00CA,Y                                              * 1928 E3 A9 00 CA    c).J
           TFR    D,X                                                   * 192C 1F 01          ..
           LDB    5,S                                                   * 192E E6 65          fe
           STB    ,X                                                    * 1930 E7 84          g.
           PULS   PC,U                                                  * 1932 35 C0          5@
L1934      PSHS   U                                                     * 1934 34 40          4@
           LDD    <U001B                                                * 1936 DC 1B          \.
           PSHS   D                                                     * 1938 34 06          4.
           LDD    >U00CA,Y                                              * 193A EC A9 00 CA    l).J
           PSHS   D                                                     * 193E 34 06          4.
           LBSR   L2E3B                                                 * 1940 17 14 F8       ..x
           LEAS   4,S                                                   * 1943 32 64          2d
           LDD    <U003D                                                * 1945 DC 3D          \=
           BEQ    L1979                                                 * 1947 27 30          '0
           LBSR   L05C5                                                 * 1949 17 EC 79       .ly
           LDB    <U005B                                                * 194C D6 5B          V[
           BEQ    L1961                                                 * 194E 27 11          '.
           LDB    <U00C4                                                * 1950 D6 C4          VD
           BEQ    L1961                                                 * 1952 27 0D          '.
           LDB    <U00C3                                                * 1954 D6 C3          VC
           BLE    L1961                                                 * 1956 2F 09          /.
           LDB    <U00C1                                                * 1958 D6 C1          VA
           BLE    L1961                                                 * 195A 2F 05          /.
           LDD    #1                                                    * 195C CC 00 01       L..
           BRA    L1963                                                 * 195F 20 02           .
L1961      CLRA                                                         * 1961 4F             O
           CLRB                                                         * 1962 5F             _
L1963      STD    <U003D                                                * 1963 DD 3D          ]=
           CLRA                                                         * 1965 4F             O
           CLRB                                                         * 1966 5F             _
           STD    <U006C                                                * 1967 DD 6C          ]l
           STD    <U006A                                                * 1969 DD 6A          ]j
           STD    <U0066                                                * 196B DD 66          ]f
           STD    <U0064                                                * 196D DD 64          ]d
           LDD    <U004B                                                * 196F DC 4B          \K
           BEQ    L1979                                                 * 1971 27 06          '.
           LDD    [>U004B,Y]                                            * 1973 EC B9 00 4B    l9.K
           STD    <reldt                                                * 1977 DD 51          ]Q
L1979      CLRA                                                         * 1979 4F             O
           CLRB                                                         * 197A 5F             _
           STD    <U001B                                                * 197B DD 1B          ].
           PULS   PC,U                                                  * 197D 35 C0          5@
           PSHS   U                                                     * 197F 34 40          4@
           LDD    #3                                                    * 1981 CC 00 03       L..
           STD    <U001B                                                * 1984 DD 1B          ].
           LBSR   L23D4                                                 * 1986 17 0A 4B       ..K
           LDD    #16                                                   * 1989 CC 00 10       L..
           STB    <Y00B9                                                * 198C D7 B9          W9
           LDD    #63                                                   * 198E CC 00 3F       L.?
           STB    <U00BA                                                * 1991 D7 BA          W:
           LDD    <U0031                                                * 1993 DC 31          \1
           STB    <U00BB                                                * 1995 D7 BB          W;
           LBRA   L1D8B                                                 * 1997 16 03 F1       ..q
L199A      PSHS   U                                                     * 199A 34 40          4@
           LDB    [>U0062,Y]                                            * 199C E6 B9 00 62    f9.b
           CMPB   #44                                                   * 19A0 C1 2C          A,
           BNE    L19AB                                                 * 19A2 26 07          &.
           LDD    <U0062                                                * 19A4 DC 62          \b
           ADDD   #1                                                    * 19A6 C3 00 01       C..
           BRA    L19F6                                                 * 19A9 20 4B           K
L19AB      LEAX   >L1DB2,PC                                             * 19AB 30 8D 04 03    0...
           PSHS   X                                                     * 19AF 34 10          4.
           LBSR   L074E                                                 * 19B1 17 ED 9A       .m.
           PULS   PC,U,X                                                * 19B4 35 D0          5P
           PSHS   U                                                     * 19B6 34 40          4@
           LBSR   L1771                                                 * 19B8 17 FD B6       .}6
           LDD    <U004B                                                * 19BB DC 4B          \K
           BEQ    L19C5                                                 * 19BD 27 06          '.
           LDD    <U0031                                                * 19BF DC 31          \1
           STD    [>U004B,Y]                                            * 19C1 ED B9 00 4B    m9.K
L19C5      PULS   PC,U                                                  * 19C5 35 C0          5@
           PSHS   U                                                     * 19C7 34 40          4@
           PULS   PC,U                                                  * 19C9 35 C0          5@
           PSHS   U                                                     * 19CB 34 40          4@
           LEAX   >Y05C7,Y                                              * 19CD 30 A9 05 C7    0).G
           PSHS   X                                                     * 19D1 34 10          4.
           BSR    L19D7                                                 * 19D3 8D 02          ..
           PULS   PC,U,X                                                * 19D5 35 D0          5P
L19D7      PSHS   U                                                     * 19D7 34 40          4@
           LDU    4,S                                                   * 19D9 EE 64          nd
           LDB    <U005B                                                * 19DB D6 5B          V[
           BNE    L19E5                                                 * 19DD 26 06          &.
           LDB    ,U                                                    * 19DF E6 C4          fD
           LBNE   L1D8B                                                 * 19E1 10 26 03 A6    .&.&
L19E5      LDX    <U0062                                                * 19E5 9E 62          .b
           LEAX   1,X                                                   * 19E7 30 01          0.
           STX    <U0062                                                * 19E9 9F 62          .b
           LDB    -1,X                                                  * 19EB E6 1F          f.
           STB    ,U+                                                   * 19ED E7 C0          g@
           BNE    L19E5                                                 * 19EF 26 F4          &t
           LDD    <U0062                                                * 19F1 DC 62          \b
           ADDD   #-1                                                   * 19F3 C3 FF FF       C..
L19F6      STD    <U0062                                                * 19F6 DD 62          ]b
           LBRA   L1D8B                                                 * 19F8 16 03 90       ...
           PSHS   U                                                     * 19FB 34 40          4@
           LEAX   >Y063F,Y                                              * 19FD 30 A9 06 3F    0).?
           PSHS   X                                                     * 1A01 34 10          4.
           BSR    L19D7                                                 * 1A03 8D D2          .R
           PULS   PC,U,X                                                * 1A05 35 D0          5P
           PSHS   U                                                     * 1A07 34 40          4@
           LBSR   L298C                                                 * 1A09 17 0F 80       ...
           BRA    L1A27                                                 * 1A0C 20 19           .
           PSHS   U                                                     * 1A0E 34 40          4@
           BSR    L1A2D                                                 * 1A10 8D 1B          ..
           STD    -2,S                                                  * 1A12 ED 7E          m~
           BEQ    L1A2B                                                 * 1A14 27 15          '.
           BRA    L1A1B                                                 * 1A16 20 03           .
L1A18      LBSR   L2A4B                                                 * 1A18 17 10 30       ..0
L1A1B      LDD    <U0031                                                * 1A1B DC 31          \1
           ADDD   #-1                                                   * 1A1D C3 FF FF       C..
           STD    <U0031                                                * 1A20 DD 31          ]1
           SUBD   #-1                                                   * 1A22 83 FF FF       ...
           BNE    L1A18                                                 * 1A25 26 F1          &q
L1A27      CLRA                                                         * 1A27 4F             O
           CLRB                                                         * 1A28 5F             _
           STD    <U003D                                                * 1A29 DD 3D          ]=
L1A2B      PULS   PC,U                                                  * 1A2B 35 C0          5@

L1A2D      PSHS   U                                                     * 1A2D 34 40          4@
           LBSR   L274A                                                 * 1A2F 17 0D 18       ...
           STD    -2,S                                                  * 1A32 ED 7E          m~
           BEQ    L1A3B                                                 * 1A34 27 05          '.
           LDD    #1                                                    * 1A36 CC 00 01       L..
           BRA    L1A46                                                 * 1A39 20 0B           .
L1A3B      LEAX   >L1DC1,PC                                             * 1A3B 30 8D 03 82    0...
           PSHS   X                                                     * 1A3F 34 10          4.
           LBSR   L074E                                                 * 1A41 17 ED 0A       .m.
           LEAS   2,S                                                   * 1A44 32 62          2b
L1A46      PULS   PC,U                                                  * 1A46 35 C0          5@
L1A48      PSHS   U                                                     * 1A48 34 40          4@
           LEAS   -3,S                                                  * 1A4A 32 7D          2}
           LBSR   L2229                                                 * 1A4C 17 07 DA       ..Z
L1A4F      STB    ,S                                                    * 1A4F E7 E4          gd
           LDB    ,S                                                    * 1A51 E6 E4          fd
           CMPB   #45                                                   * 1A53 C1 2D          A-
           BEQ    L1A5C                                                 * 1A55 27 05          '.
           LDD    #1                                                    * 1A57 CC 00 01       L..
           BRA    L1A5E                                                 * 1A5A 20 02           .
L1A5C      CLRA                                                         * 1A5C 4F             O
           CLRB                                                         * 1A5D 5F             _
L1A5E      STD    1,S                                                   * 1A5E ED 61          ma
           BNE    L1A71                                                 * 1A60 26 0F          &.
           LDD    #-1                                                   * 1A62 CC FF FF       L..
           STD    1,S                                                   * 1A65 ED 61          ma
           LDX    <U0062                                                * 1A67 9E 62          .b
           LEAX   1,X                                                   * 1A69 30 01          0.
           STX    <U0062                                                * 1A6B 9F 62          .b
           LDB    ,X                                                    * 1A6D E6 84          f.
           STB    ,S                                                    * 1A6F E7 E4          gd
L1A71      LDB    ,S                                                    * 1A71 E6 E4          fd
           SEX                                                          * 1A73 1D             .
           ORB    #32                                                   * 1A74 CA 20          J
           STB    ,S                                                    * 1A76 E7 E4          gd
           LEAU   >Y0380,Y                                              * 1A78 33 A9 03 80    3)..
           BRA    L1A98                                                 * 1A7C 20 1A           .
L1A7E      LDB    ,S                                                    * 1A7E E6 E4          fd
           SEX                                                          * 1A80 1D             .
           PSHS   D                                                     * 1A81 34 06          4.
           LDB    ,U                                                    * 1A83 E6 C4          fD
           SEX                                                          * 1A85 1D             .
           CMPD   ,S++                                                  * 1A86 10 A3 E1       .#a
           BNE    L1A96                                                 * 1A89 26 0B          &.
           LDB    [<$01,U]                                              * 1A8B E6 D8 01       fX.
           SEX                                                          * 1A8E 1D             .
           ADDD   1,S                                                   * 1A8F E3 61          ca
           STB    [<$01,U]                                              * 1A91 E7 D8 01       gX.
           BRA    L1AA3                                                 * 1A94 20 0D           .
L1A96      LEAU   3,U                                                   * 1A96 33 43          3C
L1A98      LEAX   >Y0398,Y                                              * 1A98 30 A9 03 98    0)..
           PSHS   X                                                     * 1A9C 34 10          4.
           CMPU   ,S++                                                  * 1A9E 11 A3 E1       .#a
           BCS    L1A7E                                                 * 1AA1 25 DB          %[
L1AA3      LEAX   >Y0398,Y                                              * 1AA3 30 A9 03 98    0)..
           PSHS   X                                                     * 1AA7 34 10          4.
           CMPU   ,S++                                                  * 1AA9 11 A3 E1       .#a
           BCS    L1ADF                                                 * 1AAC 25 31          %1
           LDB    ,S                                                    * 1AAE E6 E4          fd
           SEX                                                          * 1AB0 1D             .
           TFR    D,X                                                   * 1AB1 1F 01          ..
           BRA    L1AD3                                                 * 1AB3 20 1E           .
L1AB5      LBSR   L1A2D                                                 * 1AB5 17 FF 75       ..u
           STD    -2,S                                                  * 1AB8 ED 7E          m~
           BEQ    L1ACF                                                 * 1ABA 27 13          '.
           LDD    <U0031                                                * 1ABC DC 31          \1
           STD    <U0003                                                * 1ABE DD 03          ].
           BRA    L1ADF                                                 * 1AC0 20 1D           .
L1AC2      LBSR   L1A2D                                                 * 1AC2 17 FF 68       ..h
           STD    -2,S                                                  * 1AC5 ED 7E          m~
           BEQ    L1ACF                                                 * 1AC7 27 06          '.
           LDD    <U0031                                                * 1AC9 DC 31          \1
           STD    <U0005                                                * 1ACB DD 05          ].
           BRA    L1ADF                                                 * 1ACD 20 10           .
L1ACF      BSR    L1AFD                                                 * 1ACF 8D 2C          .,
           BRA    L1AF9                                                 * 1AD1 20 26           &
L1AD3      CMPX   #100                                                  * 1AD3 8C 00 64       ..d
           BEQ    L1AB5                                                 * 1AD6 27 DD          ']
           CMPX   #119                                                  * 1AD8 8C 00 77       ..w
           BEQ    L1AC2                                                 * 1ADB 27 E5          'e
           BRA    L1ACF                                                 * 1ADD 20 F0           p
L1ADF      LDX    <U0062                                                * 1ADF 9E 62          .b
           LEAX   1,X                                                   * 1AE1 30 01          0.
           STX    <U0062                                                * 1AE3 9F 62          .b
           LDB    ,X                                                    * 1AE5 E6 84          f.
           CMPB   #44                                                   * 1AE7 C1 2C          A,
           BNE    L1AF6                                                 * 1AE9 26 0B          &.
           LDX    <U0062                                                * 1AEB 9E 62          .b
           LEAX   1,X                                                   * 1AED 30 01          0.
           STX    <U0062                                                * 1AEF 9F 62          .b
           LDB    ,X                                                    * 1AF1 E6 84          f.
           LBRA   L1A4F                                                 * 1AF3 16 FF 59       ..Y
L1AF6      LDD    #1                                                    * 1AF6 CC 00 01       L..
L1AF9      LEAS   3,S                                                   * 1AF9 32 63          2c
           PULS   PC,U                                                  * 1AFB 35 C0          5@
L1AFD      PSHS   U                                                     * 1AFD 34 40          4@
           LEAX   >L1DCC,PC                                             * 1AFF 30 8D 02 C9    0..I
           PSHS   X                                                     * 1B03 34 10          4.
           LBSR   L074E                                                 * 1B05 17 EC 46       .lF
           PULS   PC,U,X                                                * 1B08 35 D0          5P
           PSHS   U                                                     * 1B0A 34 40          4@
           LBSR   L2426                                                 * 1B0C 17 09 17       ...
           STD    -2,S                                                  * 1B0F ED 7E          m~
           BEQ    L1B16                                                 * 1B11 27 03          '.
           LBSR   L1485                                                 * 1B13 17 F9 6F       .yo
L1B16      LEAX   >Y07C7,Y                                              * 1B16 30 A9 07 C7    0).G
           STX    >Y07E5,Y                                              * 1B1A AF A9 07 E5    /).e
           LBEQ   L1CEF                                                 * 1B1E 10 27 01 CD    .'.M
           LDD    <U0031                                                * 1B22 DC 31          \1
           STD    <U0027                                                * 1B24 DD 27          ]'
           LEAX   >U0031,Y                                              * 1B26 30 A9 00 31    0).1
           STX    <U004F                                                * 1B2A 9F 4F          .O
           LBRA   L1D8B                                                 * 1B2C 16 02 5C       ..\
           PSHS   U                                                     * 1B2F 34 40          4@
           LEAS   -1,S                                                  * 1B31 32 7F          2.
           LDD    <U0015                                                * 1B33 DC 15          \.
           LDX    >Y03F4,Y                                              * 1B35 AE A9 03 F4    .).t
           LEAX   2,X                                                   * 1B39 30 02          0.
           STX    >Y03F4,Y                                              * 1B3B AF A9 03 F4    /).t
           STD    -2,X                                                  * 1B3F ED 1E          m.
           LEAX   >L1DD7,PC                                             * 1B41 30 8D 02 92    0...
           PSHS   X                                                     * 1B45 34 10          4.
           LDD    <U0062                                                * 1B47 DC 62          \b
           PSHS   D                                                     * 1B49 34 06          4.
           LBSR   L2955                                                 * 1B4B 17 0E 07       ...
           LEAS   4,S                                                   * 1B4E 32 64          2d
           STD    <U0015                                                * 1B50 DD 15          ].
           BRA    L1B5C                                                 * 1B52 20 08           .
L1B54      LDB    ,S                                                    * 1B54 E6 E4          fd
           CMPB   #32                                                   * 1B56 C1 20          A
           LBEQ   L1C5E                                                 * 1B58 10 27 01 02    .'..
L1B5C      LDX    <U0062                                                * 1B5C 9E 62          .b
           LEAX   1,X                                                   * 1B5E 30 01          0.
           STX    <U0062                                                * 1B60 9F 62          .b
           LDB    ,X                                                    * 1B62 E6 84          f.
           STB    ,S                                                    * 1B64 E7 E4          gd
           BNE    L1B54                                                 * 1B66 26 EC          &l
           LBRA   L1C5E                                                 * 1B68 16 00 F3       ..s
           PSHS   U                                                     * 1B6B 34 40          4@
           LDD    <U0031                                                * 1B6D DC 31          \1
           LBNE   L1CDE                                                 * 1B6F 10 26 01 6B    .&.k
           LDD    #1                                                    * 1B73 CC 00 01       L..
           LBRA   L1CE0                                                 * 1B76 16 01 67       ..g
           PSHS   U                                                     * 1B79 34 40          4@
           LDD    <U0031                                                * 1B7B DC 31          \1
           LBEQ   L1CDE                                                 * 1B7D 10 27 01 5D    .'.]
           LDD    #1                                                    * 1B81 CC 00 01       L..
           LBRA   L1CE0                                                 * 1B84 16 01 59       ..Y
           PSHS   U                                                     * 1B87 34 40          4@
           LDD    <U0031                                                * 1B89 DC 31          \1
           LBGE   L1CDE                                                 * 1B8B 10 2C 01 4F    .,.O
           LDD    #1                                                    * 1B8F CC 00 01       L..
           LBRA   L1CE0                                                 * 1B92 16 01 4B       ..K
           PSHS   U                                                     * 1B95 34 40          4@
           LDD    <U0031                                                * 1B97 DC 31          \1
           LBGT   L1CDE                                                 * 1B99 10 2E 01 41    ...A
           LDD    #1                                                    * 1B9D CC 00 01       L..
           LBRA   L1CE0                                                 * 1BA0 16 01 3D       ..=
           PSHS   U                                                     * 1BA3 34 40          4@
           LDD    <U0031                                                * 1BA5 DC 31          \1
           LBLT   L1CDE                                                 * 1BA7 10 2D 01 33    .-.3
           LDD    #1                                                    * 1BAB CC 00 01       L..
           LBRA   L1CE0                                                 * 1BAE 16 01 2F       ../
           PSHS   U                                                     * 1BB1 34 40          4@
           LDD    <U0031                                                * 1BB3 DC 31          \1
           LBLE   L1CDE                                                 * 1BB5 10 2F 01 25    ./.%
           LDD    #1                                                    * 1BB9 CC 00 01       L..
           LBRA   L1CE0                                                 * 1BBC 16 01 21       ..!
L1BBF      PSHS   U                                                     * 1BBF 34 40          4@
           LDB    <U005B                                                * 1BC1 D6 5B          V[
           LBNE   L1CDE                                                 * 1BC3 10 26 01 17    .&..
           LDD    #1                                                    * 1BC7 CC 00 01       L..
           LBRA   L1CE0                                                 * 1BCA 16 01 13       ...
           PSHS   U                                                     * 1BCD 34 40          4@
           LEAX   >Y025E,Y                                              * 1BCF 30 A9 02 5E    0).^
           STX    <U0072                                                * 1BD3 9F 72          .r
           LDD    >Y000D,Y                                              * 1BD5 EC A9 00 0D    l)..
           STD    <U0074                                                * 1BD9 DD 74          ]t
           LEAX   >Y035A,Y                                              * 1BDB 30 A9 03 5A    0).Z
           STX    <U006E                                                * 1BDF 9F 6E          .n
           LEAX   >U00A4,Y                                              * 1BE1 30 A9 00 A4    0).$
           STX    <U007A                                                * 1BE5 9F 7A          .z
           LDD    #1                                                    * 1BE7 CC 00 01       L..
           STB    <U005C                                                * 1BEA D7 5C          W\
           CLRA                                                         * 1BEC 4F             O
           CLRB                                                         * 1BED 5F             _
           STB    <U0060                                                * 1BEE D7 60          W`
           LEAX   >U0045,Y                                              * 1BF0 30 A9 00 45    0).E
           STX    <U004B                                                * 1BF4 9F 4B          .K
           LEAX   >U0041,Y                                              * 1BF6 30 A9 00 41    0).A
           STX    <U0053                                                * 1BFA 9F 53          .S
           BSR    L1C27                                                 * 1BFC 8D 29          .)
           STD    -2,S                                                  * 1BFE ED 7E          m~
           BEQ    L1C1E                                                 * 1C00 27 1C          '.
           LEAX   >U0090,Y                                              * 1C02 30 A9 00 90    0)..
           STX    <U007A                                                * 1C06 9F 7A          .z
           LDD    #3                                                    * 1C08 CC 00 03       L..
           STB    <U005C                                                * 1C0B D7 5C          W\
           LDD    #16                                                   * 1C0D CC 00 10       L..
           STB    <U0060                                                * 1C10 D7 60          W`
           LEAX   >U0047,Y                                              * 1C12 30 A9 00 47    0).G
           STX    <U004B                                                * 1C16 9F 4B          .K
           LEAX   >U0043,Y                                              * 1C18 30 A9 00 43    0).C
           STX    <U0053                                                * 1C1C 9F 53          .S
L1C1E      LDD    [>U004B,Y]                                            * 1C1E EC B9 00 4B    l9.K
           STD    <reldt                                                * 1C22 DD 51          ]Q
           LBRA   L1D8B                                                 * 1C24 16 01 64       ..d
L1C27      PSHS   U                                                     * 1C27 34 40          4@
           LEAS   -1,S                                                  * 1C29 32 7F          2.
           LDB    [>U0062,Y]                                            * 1C2B E6 B9 00 62    f9.b
           CLRA                                                         * 1C2F 4F             O
           ANDB   #223                                                  * 1C30 C4 DF          D_
           STB    ,S                                                    * 1C32 E7 E4          gd
           BEQ    L1C6E                                                 * 1C34 27 38          '8
           LDB    ,S                                                    * 1C36 E6 E4          fd
           CMPB   #68                                                   * 1C38 C1 44          AD
           BNE    L1C6E                                                 * 1C3A 26 32          &2
           LDX    <U0062                                                * 1C3C 9E 62          .b
           LDB    1,X                                                   * 1C3E E6 01          f.
           CLRA                                                         * 1C40 4F             O
           ANDB   #223                                                  * 1C41 C4 DF          D_
           CMPD   #80                                                   * 1C43 10 83 00 50    ...P
           BNE    L1C6E                                                 * 1C47 26 25          &%
           LDX    <U0062                                                * 1C49 9E 62          .b
           LDB    2,X                                                   * 1C4B E6 02          f.
           BEQ    L1C57                                                 * 1C4D 27 08          '.
           LDX    <U0062                                                * 1C4F 9E 62          .b
           LDB    2,X                                                   * 1C51 E6 02          f.
           CMPB   #32                                                   * 1C53 C1 20          A
           BNE    L1C63                                                 * 1C55 26 0C          &.
L1C57      LDD    <U0062                                                * 1C57 DC 62          \b
           ADDD   #2                                                    * 1C59 C3 00 02       C..
           STD    <U0062                                                * 1C5C DD 62          ]b
L1C5E      LDD    #1                                                    * 1C5E CC 00 01       L..
           BRA    L1C6E                                                 * 1C61 20 0B           .
L1C63      LEAX   >L1DD9,PC                                             * 1C63 30 8D 01 72    0..r
           PSHS   X                                                     * 1C67 34 10          4.
           LBSR   L074E                                                 * 1C69 17 EA E2       .jb
           LEAS   2,S                                                   * 1C6C 32 62          2b
L1C6E      LEAS   1,S                                                   * 1C6E 32 61          2a
           PULS   PC,U                                                  * 1C70 35 C0          5@
L1C72      PSHS   U                                                     * 1C72 34 40          4@
           CLRA                                                         * 1C74 4F             O
           CLRB                                                         * 1C75 5F             _
           STD    <U001B                                                * 1C76 DD 1B          ].
           LEAX   >Y0106,Y                                              * 1C78 30 A9 01 06    0)..
           STX    <U0072                                                * 1C7C 9F 72          .r
           LDD    >Y0007,Y                                              * 1C7E EC A9 00 07    l)..
           STD    <U0074                                                * 1C82 DD 74          ]t
           LEAX   >Y0332,Y                                              * 1C84 30 A9 03 32    0).2
           STX    <U006E                                                * 1C88 9F 6E          .n
           CLRA                                                         * 1C8A 4F             O
           CLRB                                                         * 1C8B 5F             _
           STD    <U007A                                                * 1C8C DD 7A          ]z
           LDD    #4                                                    * 1C8E CC 00 04       L..
           STB    <U005C                                                * 1C91 D7 5C          W\
           LDD    #160                                                  * 1C93 CC 00 A0       L.
           STB    <U005E                                                * 1C96 D7 5E          W^
           CLRA                                                         * 1C98 4F             O
           CLRB                                                         * 1C99 5F             _
           STB    <U0060                                                * 1C9A D7 60          W`
           CLRA                                                         * 1C9C 4F             O
           CLRB                                                         * 1C9D 5F             _
           STD    <U0053                                                * 1C9E DD 53          ]S
           STD    <U004B                                                * 1CA0 DD 4B          ]K
           LBRA   L1D8B                                                 * 1CA2 16 00 E6       ..f
           PSHS   U                                                     * 1CA5 34 40          4@
           LDD    <U006A                                                * 1CA7 DC 6A          \j
           BEQ    L1CAF                                                 * 1CA9 27 04          '.
           LDD    <U006A                                                * 1CAB DC 6A          \j
           BRA    L1CB5                                                 * 1CAD 20 06           .
L1CAF      LEAX   >L1DE8,PC                                             * 1CAF 30 8D 01 35    0..5
           TFR    X,D                                                   * 1CB3 1F 10          ..
L1CB5      PSHS   D                                                     * 1CB5 34 06          4.
           LBSR   L074E                                                 * 1CB7 17 EA 94       .j.
           PULS   PC,U,X                                                * 1CBA 35 D0          5P
           PSHS   U                                                     * 1CBC 34 40          4@
           LEAX   >Y06C1,Y                                              * 1CBE 30 A9 06 C1    0).A
           LDA    ,X                                                    * 1CC2 A6 84          &.
           ORA    1,X                                                   * 1CC4 AA 01          *.
           ORA    2,X                                                   * 1CC6 AA 02          *.
           ORA    3,X                                                   * 1CC8 AA 03          *.
           BEQ    L1CD7                                                 * 1CCA 27 0B          '.
           LEAX   >L1DED,PC                                             * 1CCC 30 8D 01 1D    0...
           PSHS   X                                                     * 1CD0 34 10          4.
           LBSR   L074E                                                 * 1CD2 17 EA 79       .jy
           PULS   PC,U,X                                                * 1CD5 35 D0          5P
L1CD7      LBSR   L2426                                                 * 1CD7 17 07 4C       ..L
           STD    -2,S                                                  * 1CDA ED 7E          m~
           BNE    L1CE2                                                 * 1CDC 26 04          &.
L1CDE      CLRA                                                         * 1CDE 4F             O
           CLRB                                                         * 1CDF 5F             _
L1CE0      PULS   PC,U                                                  * 1CE0 35 C0          5@
L1CE2      LBSR   L1485                                                 * 1CE2 17 F7 A0       .w
           LEAX   >Y07C7,Y                                              * 1CE5 30 A9 07 C7    0).G
           CMPX   >Y07E5,Y                                              * 1CE9 AC A9 07 E5    ,).e
           BEQ    L1CF4                                                 * 1CED 27 05          '.
L1CEF      LBSR   L0DEB                                                 * 1CEF 17 F0 F9       .py
           PULS   PC,U                                                  * 1CF2 35 C0          5@
L1CF4      LDD    <U0031                                                * 1CF4 DC 31          \1
           STD    <U00D0                                                * 1CF6 DD D0          ]P
           BEQ    L1D14                                                 * 1CF8 27 1A          '.
           LEAX   >Y06C1,Y                                              * 1CFA 30 A9 06 C1    0).A
           PSHS   X                                                     * 1CFE 34 10          4.
           LDD    <U00CE                                                * 1D00 DC CE          \N
           BEQ    L1D08                                                 * 1D02 27 04          '.
           LDD    <U00DC                                                * 1D04 DC DC          \\
           BRA    L1D0A                                                 * 1D06 20 02           .
L1D08      LDD    <U0015                                                * 1D08 DC 15          \.
L1D0A      PSHS   D                                                     * 1D0A 34 06          4.
           LBSR   L4059                                                 * 1D0C 17 23 4A       .#J
           LEAS   2,S                                                   * 1D0F 32 62          2b
           LBRA   L1D88                                                 * 1D11 16 00 74       ..t
L1D14      LDD    #1                                                    * 1D14 CC 00 01       L..
           BRA    L1D21                                                 * 1D17 20 08           .
L1D19      PSHS   U                                                     * 1D19 34 40          4@
           LDD    <U00D2                                                * 1D1B DC D2          \R
           BEQ    L1D26                                                 * 1D1D 27 07          '.
           CLRA                                                         * 1D1F 4F             O
           CLRB                                                         * 1D20 5F             _
L1D21      STD    <U00D2                                                * 1D21 DD D2          ]R
           LBRA   L1D8B                                                 * 1D23 16 00 65       ..e
L1D26      LEAX   >Y06C1,Y                                              * 1D26 30 A9 06 C1    0).A
           LDD    2,X                                                   * 1D2A EC 02          l.
           PSHS   D                                                     * 1D2C 34 06          4.
           LDD    ,X                                                    * 1D2E EC 84          l.
           PSHS   D                                                     * 1D30 34 06          4.
           BSR    L1D38                                                 * 1D32 8D 04          ..
           NEG    <U0000                                                * 1D34 00 00          ..
           NEG    <U0000                                                * 1D36 00 00          ..
L1D38      PULS   X                                                     * 1D38 35 10          5.
           LBSR   L45D2                                                 * 1D3A 17 28 95       .(.
           BNE    L1D4A                                                 * 1D3D 26 0B          &.
           LEAX   >L1DF9,PC                                             * 1D3F 30 8D 00 B6    0..6
           PSHS   X                                                     * 1D43 34 10          4.
           LBSR   L074E                                                 * 1D45 17 EA 06       .j.
           PULS   PC,U,X                                                * 1D48 35 D0          5P
L1D4A      LDD    <U00D0                                                * 1D4A DC D0          \P
           ADDD   #-1                                                   * 1D4C C3 FF FF       C..
           STD    <U00D0                                                * 1D4F DD D0          ]P
           BLE    L1D7A                                                 * 1D51 2F 27          /'
           CLRA                                                         * 1D53 4F             O
           CLRB                                                         * 1D54 5F             _
           PSHS   D                                                     * 1D55 34 06          4.
           LEAX   >Y06C1,Y                                              * 1D57 30 A9 06 C1    0).A
           LDD    2,X                                                   * 1D5B EC 02          l.
           PSHS   D                                                     * 1D5D 34 06          4.
           LDD    ,X                                                    * 1D5F EC 84          l.
           PSHS   D                                                     * 1D61 34 06          4.
           LDD    <U00CE                                                * 1D63 DC CE          \N
           BEQ    L1D6B                                                 * 1D65 27 04          '.
           LDD    <U00DC                                                * 1D67 DC DC          \\
           BRA    L1D6D                                                 * 1D69 20 02           .
L1D6B      LDD    <U0015                                                * 1D6B DC 15          \.
L1D6D      PSHS   D                                                     * 1D6D 34 06          4.
           LBSR   L3F02                                                 * 1D6F 17 21 90       .!.
           LEAS   8,S                                                   * 1D72 32 68          2h
           CLRA                                                         * 1D74 4F             O
           CLRB                                                         * 1D75 5F             _
           STD    <U003D                                                * 1D76 DD 3D          ]=
           BRA    L1D8B                                                 * 1D78 20 11           .
L1D7A      LEAX   >Y06C1,Y                                              * 1D7A 30 A9 06 C1    0).A
           PSHS   X                                                     * 1D7E 34 10          4.
           BSR    L1D86                                                 * 1D80 8D 04          ..
           NEG    <U0000                                                * 1D82 00 00          ..
           NEG    <U0000                                                * 1D84 00 00          ..
L1D86      PULS   X                                                     * 1D86 35 10          5.
L1D88      LBSR   L4636                                                 * 1D88 17 28 AB       .(+
L1D8B      LDD    #1                                                    * 1D8B CC 00 01       L..
           PULS   PC,U                                                  * 1D8E 35 C0          5@
L1D90      FCC    "label missing"                                       * 1D90 6C 61 62 65 6C 20 6D 69 73 73 69 6E 67 label missing
           FCB    $00                                                   * 1D9D 00             .
L1D9E      FCC    "constant definition"                                 * 1D9E 63 6F 6E 73 74 61 6E 74 20 64 65 66 69 6E 69 74 69 6F 6E constant definition
           FCB    $00                                                   * 1DB1 00             .
L1DB2      FCC    "comma expected"                                      * 1DB2 63 6F 6D 6D 61 20 65 78 70 65 63 74 65 64 comma expected
           FCB    $00                                                   * 1DC0 00             .
L1DC1      FCC    "bad number"                                          * 1DC1 62 61 64 20 6E 75 6D 62 65 72 bad number
           FCB    $00                                                   * 1DCB 00             .
L1DCC      FCC    "bad option"                                          * 1DCC 62 61 64 20 6F 70 74 69 6F 6E bad option
           FCB    $00                                                   * 1DD6 00             .
L1DD7      FCB    $72                                                   * 1DD7 72             r
           FCB    $00                                                   * 1DD8 00             .
L1DD9      FCC    "DP section ???"                                      * 1DD9 44 50 20 73 65 63 74 69 6F 6E 20 3F 3F 3F DP section ???
           FCB    $00                                                   * 1DE7 00             .
L1DE8      FCC    "fail"                                                * 1DE8 66 61 69 6C    fail
           FCB    $00                                                   * 1DEC 00             .
L1DED      FCC    "nested REPT"                                         * 1DED 6E 65 73 74 65 64 20 52 45 50 54 nested REPT
           FCB    $00                                                   * 1DF8 00             .
L1DF9      FCC    "ENDR without REPT"                                   * 1DF9 45 4E 44 52 20 77 69 74 68 6F 75 74 20 52 45 50 54 ENDR without REPT
           FCB    $00                                                   * 1E0A 00             .
L1E0B      PSHS   U,D                                                   * 1E0B 34 46          4F
           LDB    [>U0062,Y]                                            * 1E0D E6 B9 00 62    f9.b
           SEX                                                          * 1E11 1D             .
           LEAX   >Y03FC,Y                                              * 1E12 30 A9 03 FC    0).|
           LEAX   D,X                                                   * 1E16 30 8B          0.
           LDB    ,X                                                    * 1E18 E6 84          f.
           CLRA                                                         * 1E1A 4F             O
           ANDB   #6                                                    * 1E1B C4 06          D.
           LBEQ   L1E7B                                                 * 1E1D 10 27 00 5A    .'.Z
           LDD    #9                                                    * 1E21 CC 00 09       L..
           STD    ,S                                                    * 1E24 ED E4          md
           BRA    L1E38                                                 * 1E26 20 10           .
L1E28      LDX    <U0062                                                * 1E28 9E 62          .b
           LEAX   1,X                                                   * 1E2A 30 01          0.
           STX    <U0062                                                * 1E2C 9F 62          .b
           LDB    -1,X                                                  * 1E2E E6 1F          f.
           LDX    6,S                                                   * 1E30 AE 66          .f
           LEAX   1,X                                                   * 1E32 30 01          0.
           STX    6,S                                                   * 1E34 AF 66          /f
           STB    -1,X                                                  * 1E36 E7 1F          g.
L1E38      LDD    ,S                                                    * 1E38 EC E4          ld
           ADDD   #-1                                                   * 1E3A C3 FF FF       C..
           STD    ,S                                                    * 1E3D ED E4          md
           SUBD   #-1                                                   * 1E3F 83 FF FF       ...
           BLE    L1E56                                                 * 1E42 2F 12          /.
           LDB    [>U0062,Y]                                            * 1E44 E6 B9 00 62    f9.b
           SEX                                                          * 1E48 1D             .
           LEAX   >Y03FC,Y                                              * 1E49 30 A9 03 FC    0).|
           LEAX   D,X                                                   * 1E4D 30 8B          0.
           LDB    ,X                                                    * 1E4F E6 84          f.
           CLRA                                                         * 1E51 4F             O
           ANDB   #15                                                   * 1E52 C4 0F          D.
           BNE    L1E28                                                 * 1E54 26 D2          &R
L1E56      CLRA                                                         * 1E56 4F             O
           CLRB                                                         * 1E57 5F             _
           STB    [<$06,S]                                              * 1E58 E7 F8 06       gx.
           BRA    L1E64                                                 * 1E5B 20 07           .
L1E5D      LDD    <U0062                                                * 1E5D DC 62          \b
           ADDD   #1                                                    * 1E5F C3 00 01       C..
           STD    <U0062                                                * 1E62 DD 62          ]b
L1E64      LDB    [>U0062,Y]                                            * 1E64 E6 B9 00 62    f9.b
           SEX                                                          * 1E68 1D             .
           LEAX   >Y03FC,Y                                              * 1E69 30 A9 03 FC    0).|
           LEAX   D,X                                                   * 1E6D 30 8B          0.
           LDB    ,X                                                    * 1E6F E6 84          f.
           CLRA                                                         * 1E71 4F             O
           ANDB   #15                                                   * 1E72 C4 0F          D.
           BNE    L1E5D                                                 * 1E74 26 E7          &g
           LDD    #1                                                    * 1E76 CC 00 01       L..
           PULS   PC,U,X                                                * 1E79 35 D0          5P
L1E7B      CLRA                                                         * 1E7B 4F             O
           CLRB                                                         * 1E7C 5F             _
           PULS   PC,U,X                                                * 1E7D 35 D0          5P
L1E7F      PSHS   U,D                                                   * 1E7F 34 46          4F
           CLRA                                                         * 1E81 4F             O
           CLRB                                                         * 1E82 5F             _
           STD    <U0078                                                * 1E83 DD 78          ]x
           LEAX   >Y05A9,Y                                              * 1E85 30 A9 05 A9    0).)
           PSHS   X                                                     * 1E89 34 10          4.
           LBSR   L1E0B                                                 * 1E8B 17 FF 7D       ..}
           STD    ,S++                                                  * 1E8E ED E1          ma
           BNE    L1E96                                                 * 1E90 26 04          &.
           CLRA                                                         * 1E92 4F             O
           CLRB                                                         * 1E93 5F             _
           PULS   PC,U,X                                                * 1E94 35 D0          5P
L1E96      LDB    [>U0062,Y]                                            * 1E96 E6 B9 00 62    f9.b
           CMPB   #58                                                   * 1E9A C1 3A          A:
           BNE    L1EAC                                                 * 1E9C 26 0E          &.
           LDD    <U0062                                                * 1E9E DC 62          \b
           ADDD   #1                                                    * 1EA0 C3 00 01       C..
           STD    <U0062                                                * 1EA3 DD 62          ]b
           LDB    <U005F                                                * 1EA5 D6 5F          V_
           SEX                                                          * 1EA7 1D             .
           ORB    #4                                                    * 1EA8 CA 04          J.
           STB    <U005F                                                * 1EAA D7 5F          W_
L1EAC      LEAX   >U0078,Y                                              * 1EAC 30 A9 00 78    0).x
           PSHS   X                                                     * 1EB0 34 10          4.
           LEAX   >Y05A9,Y                                              * 1EB2 30 A9 05 A9    0).)
           PSHS   X                                                     * 1EB6 34 10          4.
           LBSR   L22CC                                                 * 1EB8 17 04 11       ...
           LEAS   4,S                                                   * 1EBB 32 64          2d
           STD    ,S                                                    * 1EBD ED E4          md
           LDU    <U0078                                                * 1EBF DE 78          ^x
           LDB    <U005B                                                * 1EC1 D6 5B          V[
           LBNE   L1F40                                                 * 1EC3 10 26 00 79    .&.y
           LDD    ,S                                                    * 1EC7 EC E4          ld
           BEQ    L1EE6                                                 * 1EC9 27 1B          '.
           LDD    ,S                                                    * 1ECB EC E4          ld
           PSHS   D                                                     * 1ECD 34 06          4.
           LEAX   >U0078,Y                                              * 1ECF 30 A9 00 78    0).x
           PSHS   X                                                     * 1ED3 34 10          4.
           LEAX   >Y05A9,Y                                              * 1ED5 30 A9 05 A9    0).)
           PSHS   X                                                     * 1ED9 34 10          4.
           LBSR   L2252                                                 * 1EDB 17 03 74       ..t
           LEAS   6,S                                                   * 1EDE 32 66          2f
           TFR    D,U                                                   * 1EE0 1F 03          ..
           TFR    U,D                                                   * 1EE2 1F 30          .0
           STD    <U0078                                                * 1EE4 DD 78          ]x
L1EE6      LDB    1,U                                                   * 1EE6 E6 41          fA
           CLRA                                                         * 1EE8 4F             O
           ANDB   #128                                                  * 1EE9 C4 80          D.
           BNE    L1F17                                                 * 1EEB 26 2A          &*
           LDB    ,U                                                    * 1EED E6 C4          fD
           SEX                                                          * 1EEF 1D             .
           ANDB   #248                                                  * 1EF0 C4 F8          Dx
           PSHS   D                                                     * 1EF2 34 06          4.
           LDB    <U005D                                                * 1EF4 D6 5D          V]
           SEX                                                          * 1EF6 1D             .
           ORA    ,S+                                                   * 1EF7 AA E0          *`
           ORB    ,S+                                                   * 1EF9 EA E0          j`
           STB    ,U                                                    * 1EFB E7 C4          gD
           LDB    1,U                                                   * 1EFD E6 41          fA
           SEX                                                          * 1EFF 1D             .
           PSHS   D                                                     * 1F00 34 06          4.
           LDB    <U005F                                                * 1F02 D6 5F          V_
           SEX                                                          * 1F04 1D             .
           ORA    ,S+                                                   * 1F05 AA E0          *`
           ORB    ,S+                                                   * 1F07 EA E0          j`
           STB    1,U                                                   * 1F09 E7 41          gA
           LDD    <U004B                                                * 1F0B DC 4B          \K
           BEQ    L1F29                                                 * 1F0D 27 1A          '.
           LDD    [>U004B,Y]                                            * 1F0F EC B9 00 4B    l9.K
           STD    2,U                                                   * 1F13 ED 42          mB
           BRA    L1F29                                                 * 1F15 20 12           .
L1F17      LDB    ,U                                                    * 1F17 E6 C4          fD
           CLRA                                                         * 1F19 4F             O
           ANDB   #7                                                    * 1F1A C4 07          D.
           CMPD   #5                                                    * 1F1C 10 83 00 05    ....
           BEQ    L1F29                                                 * 1F20 27 07          '.
           LDB    1,U                                                   * 1F22 E6 41          fA
           SEX                                                          * 1F24 1D             .
           ORB    #64                                                   * 1F25 CA 40          J@
           STB    1,U                                                   * 1F27 E7 41          gA
L1F29      LDB    1,U                                                   * 1F29 E6 41          fA
           CLRA                                                         * 1F2B 4F             O
           ANDB   #198                                                  * 1F2C C4 C6          DF
           CMPD   #134                                                  * 1F2E 10 83 00 86    ....
           LBNE   L1F94                                                 * 1F32 10 26 00 5E    .&.^
           LDD    <U0055                                                * 1F36 DC 55          \U
           ADDD   #1                                                    * 1F38 C3 00 01       C..
           STD    <U0055                                                * 1F3B DD 55          ]U
           LBRA   L1F94                                                 * 1F3D 16 00 54       ..T
L1F40      LDD    ,S                                                    * 1F40 EC E4          ld
           BNE    L1F4B                                                 * 1F42 26 07          &.
           LDB    1,U                                                   * 1F44 E6 41          fA
           CLRA                                                         * 1F46 4F             O
           ANDB   #128                                                  * 1F47 C4 80          D.
           BNE    L1F56                                                 * 1F49 26 0B          &.
L1F4B      LEAX   >L2360,PC                                             * 1F4B 30 8D 04 11    0...
           PSHS   X                                                     * 1F4F 34 10          4.
           LBSR   L078B                                                 * 1F51 17 E8 37       .h7
           LEAS   2,S                                                   * 1F54 32 62          2b
L1F56      LDB    1,U                                                   * 1F56 E6 41          fA
           SEX                                                          * 1F58 1D             .
           ANDB   #239                                                  * 1F59 C4 EF          Do
           STB    1,U                                                   * 1F5B E7 41          gA
           CLRA                                                         * 1F5D 4F             O
           ANDB   #64                                                   * 1F5E C4 40          D@
           BEQ    L1F6F                                                 * 1F60 27 0D          '.
           LEAX   >L236E,PC                                             * 1F62 30 8D 04 08    0...
           PSHS   X                                                     * 1F66 34 10          4.
           LBSR   L074E                                                 * 1F68 17 E7 E3       .gc
           LEAS   2,S                                                   * 1F6B 32 62          2b
           BRA    L1F94                                                 * 1F6D 20 25           %
L1F6F      LDD    <U004B                                                * 1F6F DC 4B          \K
           BEQ    L1F94                                                 * 1F71 27 21          '!
           LDB    ,U                                                    * 1F73 E6 C4          fD
           CLRA                                                         * 1F75 4F             O
           ANDB   #7                                                    * 1F76 C4 07          D.
           PSHS   D                                                     * 1F78 34 06          4.
           LDB    <U005C                                                * 1F7A D6 5C          V\
           SEX                                                          * 1F7C 1D             .
           CMPD   ,S++                                                  * 1F7D 10 A3 E1       .#a
           BNE    L1F94                                                 * 1F80 26 12          &.
           LDD    2,U                                                   * 1F82 EC 42          lB
           CMPD   [>U004B,Y]                                            * 1F84 10 A3 B9 00 4B .#9.K
           BEQ    L1F94                                                 * 1F89 27 09          '.
           LBSR   L21FA                                                 * 1F8B 17 02 6C       ..l
           LDD    [>U004B,Y]                                            * 1F8E EC B9 00 4B    l9.K
           STD    2,U                                                   * 1F92 ED 42          mB
L1F94      LDD    #1                                                    * 1F94 CC 00 01       L..
           PULS   PC,U,X                                                * 1F97 35 D0          5P
L1F99      PSHS   U,X,D                                                 * 1F99 34 56          4V
           LEAX   >U0078,Y                                              * 1F9B 30 A9 00 78    0).x
           PSHS   X                                                     * 1F9F 34 10          4.
           LEAX   >Y05BD,Y                                              * 1FA1 30 A9 05 BD    0).=
           PSHS   X                                                     * 1FA5 34 10          4.
           LBSR   L22CC                                                 * 1FA7 17 03 22       .."
           LEAS   4,S                                                   * 1FAA 32 64          2d
           STD    ,S                                                    * 1FAC ED E4          md
           LDU    <U0078                                                * 1FAE DE 78          ^x
           LDD    ,S                                                    * 1FB0 EC E4          ld
           BEQ    L1FDE                                                 * 1FB2 27 2A          '*
           LDB    <U005B                                                * 1FB4 D6 5B          V[
           BNE    L1FD3                                                 * 1FB6 26 1B          &.
           LDD    ,S                                                    * 1FB8 EC E4          ld
           PSHS   D                                                     * 1FBA 34 06          4.
           LEAX   >U0078,Y                                              * 1FBC 30 A9 00 78    0).x
           PSHS   X                                                     * 1FC0 34 10          4.
           LEAX   >Y05BD,Y                                              * 1FC2 30 A9 05 BD    0).=
           PSHS   X                                                     * 1FC6 34 10          4.
           LBSR   L2252                                                 * 1FC8 17 02 87       ...
           LEAS   6,S                                                   * 1FCB 32 66          2f
           STD    <U0078                                                * 1FCD DD 78          ]x
           TFR    D,U                                                   * 1FCF 1F 03          ..
           BRA    L1FDE                                                 * 1FD1 20 0B           .
L1FD3      LEAX   >L237D,PC                                             * 1FD3 30 8D 03 A6    0..&
           PSHS   X                                                     * 1FD7 34 10          4.
           LBSR   L078B                                                 * 1FD9 17 E7 AF       .g/
           LEAS   2,S                                                   * 1FDC 32 62          2b
L1FDE      LDB    1,U                                                   * 1FDE E6 41          fA
           SEX                                                          * 1FE0 1D             .
           EORB   #128                                                  * 1FE1 C8 80          H.
           CLRA                                                         * 1FE3 4F             O
           ANDB   #160                                                  * 1FE4 C4 A0          D
           LBEQ   L2067                                                 * 1FE6 10 27 00 7D    .'.}
           LDD    #1                                                    * 1FEA CC 00 01       L..
           STD    <U003F                                                * 1FED DD 3F          ]?
           LDB    <U005B                                                * 1FEF D6 5B          V[
           BEQ    L2043                                                 * 1FF1 27 50          'P
           LDB    1,U                                                   * 1FF3 E6 41          fA
           CLRA                                                         * 1FF5 4F             O
           ANDB   #128                                                  * 1FF6 C4 80          D.
           BEQ    L2043                                                 * 1FF8 27 49          'I
           LDB    ,U                                                    * 1FFA E6 C4          fD
           CLRA                                                         * 1FFC 4F             O
           ANDB   #7                                                    * 1FFD C4 07          D.
           CMPD   #6                                                    * 1FFF 10 83 00 06    ....
           BEQ    L2010                                                 * 2003 27 0B          '.
           LDB    ,U                                                    * 2005 E6 C4          fD
           CLRA                                                         * 2007 4F             O
           ANDB   #7                                                    * 2008 C4 07          D.
           CMPD   #5                                                    * 200A 10 83 00 05    ....
           BNE    L2043                                                 * 200E 26 33          &3
L2010      LDD    8,U                                                   * 2010 EC 48          lH
           BRA    L203B                                                 * 2012 20 27           '
L2014      LDB    [<$02,S]                                              * 2014 E6 F8 02       fx.
           STB    [>Y07E5,Y]                                            * 2017 E7 B9 07 E5    g9.e
           LDX    2,S                                                   * 201B AE 62          .b
           LDD    1,X                                                   * 201D EC 01          l.
           LDX    >Y07E5,Y                                              * 201F AE A9 07 E5    .).e
           STD    1,X                                                   * 2023 ED 01          m.
           PSHS   D                                                     * 2025 34 06          4.
           LBSR   L2082                                                 * 2027 17 00 58       ..X
           LEAS   2,S                                                   * 202A 32 62          2b
           LDD    >Y07E5,Y                                              * 202C EC A9 07 E5    l).e
           ADDD   #3                                                    * 2030 C3 00 03       C..
           STD    >Y07E5,Y                                              * 2033 ED A9 07 E5    m).e
           LDX    2,S                                                   * 2037 AE 62          .b
           LDD    3,X                                                   * 2039 EC 03          l.
L203B      STD    2,S                                                   * 203B ED 62          mb
           LDD    2,S                                                   * 203D EC 62          lb
           BNE    L2014                                                 * 203F 26 D3          &S
           BRA    L2078                                                 * 2041 20 35           5
L2043      LDB    <U005B                                                * 2043 D6 5B          V[
           BNE    L204E                                                 * 2045 26 07          &.
           LDB    1,U                                                   * 2047 E6 41          fA
           SEX                                                          * 2049 1D             .
           ORB    #16                                                   * 204A CA 10          J.
           STB    1,U                                                   * 204C E7 41          gA
L204E      CLRA                                                         * 204E 4F             O
           CLRB                                                         * 204F 5F             _
           STB    [>Y07E5,Y]                                            * 2050 E7 B9 07 E5    g9.e
           LDX    >Y07E5,Y                                              * 2054 AE A9 07 E5    .).e
           STU    1,X                                                   * 2058 EF 01          o.
           LDD    >Y07E5,Y                                              * 205A EC A9 07 E5    l).e
           ADDD   #3                                                    * 205E C3 00 03       C..
           STD    >Y07E5,Y                                              * 2061 ED A9 07 E5    m).e
           BRA    L2072                                                 * 2065 20 0B           .
L2067      LDB    <U005B                                                * 2067 D6 5B          V[
           BEQ    L2078                                                 * 2069 27 0D          '.
           LDB    1,U                                                   * 206B E6 41          fA
           CLRA                                                         * 206D 4F             O
           ANDB   #16                                                   * 206E C4 10          D.
           BEQ    L2078                                                 * 2070 27 06          '.
L2072      PSHS   U                                                     * 2072 34 40          4@
           BSR    L2082                                                 * 2074 8D 0C          ..
           LEAS   2,S                                                   * 2076 32 62          2b
L2078      LDD    2,U                                                   * 2078 EC 42          lB
           STD    <U0031                                                * 207A DD 31          ]1
           LDD    #1                                                    * 207C CC 00 01       L..
           LBRA   L21F6                                                 * 207F 16 01 74       ..t
L2082      PSHS   U                                                     * 2082 34 40          4@
           LDU    4,S                                                   * 2084 EE 64          nd
           LDD    <U0037                                                * 2086 DC 37          \7
           BNE    L209F                                                 * 2088 26 15          &.
           LDB    ,U                                                    * 208A E6 C4          fD
           CLRA                                                         * 208C 4F             O
           ANDB   #6                                                    * 208D C4 06          D.
           CMPD   #2                                                    * 208F 10 83 00 02    ....
           BNE    L209A                                                 * 2093 26 05          &.
           LDD    #1                                                    * 2095 CC 00 01       L..
           BRA    L209D                                                 * 2098 20 03           .
L209A      LDD    #-1                                                   * 209A CC FF FF       L..
L209D      STD    <U0037                                                * 209D DD 37          ]7
L209F      PULS   PC,U                                                  * 209F 35 C0          5@
L20A1      PSHS   U                                                     * 20A1 34 40          4@
           LDX    <U0078                                                * 20A3 9E 78          .x
           LDB    1,X                                                   * 20A5 E6 01          f.
           CLRA                                                         * 20A7 4F             O
           ANDB   #64                                                   * 20A8 C4 40          D@
           BNE    L20DE                                                 * 20AA 26 32          &2
           LDB    5,S                                                   * 20AC E6 65          fe
           CMPB   #5                                                    * 20AE C1 05          A.
           BEQ    L20CA                                                 * 20B0 27 18          '.
           LDB    [>U0078,Y]                                            * 20B2 E6 B9 00 78    f9.x
           CLRA                                                         * 20B6 4F             O
           ANDB   #7                                                    * 20B7 C4 07          D.
           CMPD   #5                                                    * 20B9 10 83 00 05    ....
           BNE    L20CA                                                 * 20BD 26 0B          &.
           LDX    <U0078                                                * 20BF 9E 78          .x
           LDB    1,X                                                   * 20C1 E6 01          f.
           SEX                                                          * 20C3 1D             .
           ORB    #64                                                   * 20C4 CA 40          J@
           STB    1,X                                                   * 20C6 E7 01          g.
           BRA    L20DE                                                 * 20C8 20 14           .
L20CA      LDB    [>U0078,Y]                                            * 20CA E6 B9 00 78    f9.x
           SEX                                                          * 20CE 1D             .
           ANDB   #248                                                  * 20CF C4 F8          Dx
           PSHS   D                                                     * 20D1 34 06          4.
           LDB    7,S                                                   * 20D3 E6 67          fg
           SEX                                                          * 20D5 1D             .
           ORA    ,S+                                                   * 20D6 AA E0          *`
           ORB    ,S+                                                   * 20D8 EA E0          j`
           STB    [>U0078,Y]                                            * 20DA E7 B9 00 78    g9.x
L20DE      PULS   PC,U                                                  * 20DE 35 C0          5@
L20E0      PSHS   U,X,D                                                 * 20E0 34 56          4V
           LDU    <U0078                                                * 20E2 DE 78          ^x
           LEAX   >Y07C7,Y                                              * 20E4 30 A9 07 C7    0).G
           CMPX   >Y07E5,Y                                              * 20E8 AC A9 07 E5    ,).e
           BNE    L212E                                                 * 20EC 26 40          &@
           LDB    ,U                                                    * 20EE E6 C4          fD
           CLRA                                                         * 20F0 4F             O
           ANDB   #4                                                    * 20F1 C4 04          D.
           BEQ    L2106                                                 * 20F3 27 11          '.
           LDB    1,U                                                   * 20F5 E6 41          fA
           CLRA                                                         * 20F7 4F             O
           ANDB   #32                                                   * 20F8 C4 20          D
           BEQ    L2106                                                 * 20FA 27 0A          '.
           LDB    1,U                                                   * 20FC E6 41          fA
           SEX                                                          * 20FE 1D             .
           ANDB   #223                                                  * 20FF C4 DF          D_
           STB    1,U                                                   * 2101 E7 41          gA
           LBRA   L21F2                                                 * 2103 16 00 EC       ..l
L2106      LDB    <U005B                                                * 2106 D6 5B          V[
           LBLE   L21F2                                                 * 2108 10 2F 00 E6    ./.f
           LDD    8,S                                                   * 210C EC 68          lh
           CMPD   2,U                                                   * 210E 10 A3 42       .#B
           LBEQ   L21F2                                                 * 2111 10 27 00 DD    .'.]
           LDB    1,U                                                   * 2115 E6 41          fA
           CLRA                                                         * 2117 4F             O
           ANDB   #64                                                   * 2118 C4 40          D@
           LBNE   L21F2                                                 * 211A 10 26 00 D4    .&.T
           LDB    ,U                                                    * 211E E6 C4          fD
           CLRA                                                         * 2120 4F             O
           ANDB   #7                                                    * 2121 C4 07          D.
           CMPD   #5                                                    * 2123 10 83 00 05    ....
           LBEQ   L21F2                                                 * 2127 10 27 00 C7    .'.G
           LBRA   L21C6                                                 * 212B 16 00 98       ...
L212E      LDB    <U005B                                                * 212E D6 5B          V[
           BNE    L2176                                                 * 2130 26 44          &D
           LDB    ,U                                                    * 2132 E6 C4          fD
           CLRA                                                         * 2134 4F             O
           ANDB   #7                                                    * 2135 C4 07          D.
           CMPD   #6                                                    * 2137 10 83 00 06    ....
           LBNE   L21F2                                                 * 213B 10 26 00 B3    .&.3
           LDB    1,U                                                   * 213F E6 41          fA
           SEX                                                          * 2141 1D             .
           ORB    #32                                                   * 2142 CA 20          J
           STB    1,U                                                   * 2144 E7 41          gA
           BRA    L2169                                                 * 2146 20 21           !
L2148      LDD    >Y07E5,Y                                              * 2148 EC A9 07 E5    l).e
           ADDD   #-3                                                   * 214C C3 FF FD       C.}
           STD    >Y07E5,Y                                              * 214F ED A9 07 E5    m).e
           LDX    >Y07E5,Y                                              * 2153 AE A9 07 E5    .).e
           LDD    1,X                                                   * 2157 EC 01          l.
           PSHS   D                                                     * 2159 34 06          4.
           LDB    [>Y07E5,Y]                                            * 215B E6 B9 07 E5    f9.e
           SEX                                                          * 215F 1D             .
           PSHS   D                                                     * 2160 34 06          4.
           PSHS   U                                                     * 2162 34 40          4@
           LBSR   L2207                                                 * 2164 17 00 A0       ..
           LEAS   6,S                                                   * 2167 32 66          2f
L2169      LEAX   >Y07C7,Y                                              * 2169 30 A9 07 C7    0).G
           CMPX   >Y07E5,Y                                              * 216D AC A9 07 E5    ,).e
           BCS    L2148                                                 * 2171 25 D5          %U
           LBRA   L21F2                                                 * 2173 16 00 7C       ..|
L2176      LDB    ,U                                                    * 2176 E6 C4          fD
           CLRA                                                         * 2178 4F             O
           ANDB   #7                                                    * 2179 C4 07          D.
           CMPD   #6                                                    * 217B 10 83 00 06    ....
           LBNE   L21EF                                                 * 217F 10 26 00 6C    .&.l
           LDD    8,U                                                   * 2183 EC 48          lH
           STD    ,S                                                    * 2185 ED E4          md
           LDD    >Y07E5,Y                                              * 2187 EC A9 07 E5    l).e
           STD    2,S                                                   * 218B ED 62          mb
           BRA    L21A7                                                 * 218D 20 18           .
L218F      LDD    2,S                                                   * 218F EC 62          lb
           ADDD   #-3                                                   * 2191 C3 FF FD       C.}
           STD    2,S                                                   * 2194 ED 62          mb
           LDX    ,S                                                    * 2196 AE E4          .d
           LDD    1,X                                                   * 2198 EC 01          l.
           LDX    2,S                                                   * 219A AE 62          .b
           CMPD   1,X                                                   * 219C 10 A3 01       .#.
           BNE    L21B3                                                 * 219F 26 12          &.
           LDX    ,S                                                    * 21A1 AE E4          .d
           LDD    3,X                                                   * 21A3 EC 03          l.
           STD    ,S                                                    * 21A5 ED E4          md
L21A7      LDD    ,S                                                    * 21A7 EC E4          ld
           BEQ    L21B3                                                 * 21A9 27 08          '.
           LEAX   >Y07C7,Y                                              * 21AB 30 A9 07 C7    0).G
           CMPX   2,S                                                   * 21AF AC 62          ,b
           BCS    L218F                                                 * 21B1 25 DC          %\
L21B3      LDD    ,S                                                    * 21B3 EC E4          ld
           BNE    L21C6                                                 * 21B5 26 0F          &.
           LEAX   >Y07C7,Y                                              * 21B7 30 A9 07 C7    0).G
           CMPX   2,S                                                   * 21BB AC 62          ,b
           BNE    L21C6                                                 * 21BD 26 07          &.
           LDD    2,U                                                   * 21BF EC 42          lB
           CMPD   8,S                                                   * 21C1 10 A3 68       .#h
           BEQ    L21CA                                                 * 21C4 27 04          '.
L21C6      BSR    L21FA                                                 * 21C6 8D 32          .2
           BRA    L21F2                                                 * 21C8 20 28           (
L21CA      LDB    1,U                                                   * 21CA E6 41          fA
           CLRA                                                         * 21CC 4F             O
           ANDB   #4                                                    * 21CD C4 04          D.
           BEQ    L21F2                                                 * 21CF 27 21          '!
           LDD    8,U                                                   * 21D1 EC 48          lH
           BRA    L21E7                                                 * 21D3 20 12           .
L21D5      LDX    ,S                                                    * 21D5 AE E4          .d
           LDX    1,X                                                   * 21D7 AE 01          ..
           LDB    1,X                                                   * 21D9 E6 01          f.
           CLRA                                                         * 21DB 4F             O
           ANDB   #66                                                   * 21DC C4 42          DB
           BNE    L21E3                                                 * 21DE 26 03          &.
           LBSR   L0DEB                                                 * 21E0 17 EC 08       .l.
L21E3      LDX    ,S                                                    * 21E3 AE E4          .d
           LDD    3,X                                                   * 21E5 EC 03          l.
L21E7      STD    ,S                                                    * 21E7 ED E4          md
           LDD    ,S                                                    * 21E9 EC E4          ld
           BNE    L21D5                                                 * 21EB 26 E8          &h
           BRA    L21F2                                                 * 21ED 20 03           .
L21EF      LBSR   L0DEB                                                 * 21EF 17 EB F9       .ky
L21F2      LDD    8,S                                                   * 21F2 EC 68          lh
           STD    2,U                                                   * 21F4 ED 42          mB
L21F6      LEAS   4,S                                                   * 21F6 32 64          2d
           PULS   PC,U                                                  * 21F8 35 C0          5@
L21FA      PSHS   U                                                     * 21FA 34 40          4@
           LEAX   >L2394,PC                                             * 21FC 30 8D 01 94    0...
           PSHS   X                                                     * 2200 34 10          4.
           LBSR   L074E                                                 * 2202 17 E5 49       .eI
           PULS   PC,U,X                                                * 2205 35 D0          5P
L2207      PSHS   U                                                     * 2207 34 40          4@
           LDD    #5                                                    * 2209 CC 00 05       L..
           PSHS   D                                                     * 220C 34 06          4.
           LBSR   L233C                                                 * 220E 17 01 2B       ..+
           LEAS   2,S                                                   * 2211 32 62          2b
           TFR    D,U                                                   * 2213 1F 03          ..
           LDD    6,S                                                   * 2215 EC 66          lf
           STB    ,U                                                    * 2217 E7 C4          gD
           LDD    8,S                                                   * 2219 EC 68          lh
           STD    1,U                                                   * 221B ED 41          mA
           LDX    4,S                                                   * 221D AE 64          .d
           LDD    8,X                                                   * 221F EC 08          l.
           STD    3,U                                                   * 2221 ED 43          mC
           LDX    4,S                                                   * 2223 AE 64          .d
           STU    8,X                                                   * 2225 EF 08          o.
           PULS   PC,U                                                  * 2227 35 C0          5@
L2229      LDX    <U0062                                                * 2229 9E 62          .b
L222B      LDB    ,X+                                                   * 222B E6 80          f.
           CMPB   #32                                                   * 222D C1 20          A
           BEQ    L222B                                                 * 222F 27 FA          'z
           SEX                                                          * 2231 1D             .
           LEAX   -1,X                                                  * 2232 30 1F          0.
           STX    <U0062                                                * 2234 9F 62          .b
           RTS                                                          * 2236 39             9
L2237      PSHS   U                                                     * 2237 34 40          4@
           LDX    4,S                                                   * 2239 AE 64          .d
           LDU    6,X                                                   * 223B EE 06          n.
           LDX    4,S                                                   * 223D AE 64          .d
           LDB    1,X                                                   * 223F E6 01          f.
           CLRA                                                         * 2241 4F             O
           ANDB   #8                                                    * 2242 C4 08          D.
           BEQ    L224E                                                 * 2244 27 08          '.
           BRA    L224A                                                 * 2246 20 02           .
L2248      LDU    4,U                                                   * 2248 EE 44          nD
L224A      LDD    4,U                                                   * 224A EC 44          lD
           BNE    L2248                                                 * 224C 26 FA          &z
L224E      TFR    U,D                                                   * 224E 1F 30          .0
           PULS   PC,U                                                  * 2250 35 C0          5@
L2252      PSHS   U,D                                                   * 2252 34 46          4F
           LDD    >Y07C5,Y                                              * 2254 EC A9 07 C5    l).E
           BEQ    L2278                                                 * 2258 27 1E          '.
           LDU    >Y07C5,Y                                              * 225A EE A9 07 C5    n).E
           LDX    >Y07C5,Y                                              * 225E AE A9 07 C5    .).E
           LDD    4,X                                                   * 2262 EC 04          l.
           STD    >Y07C5,Y                                              * 2264 ED A9 07 C5    m).E
           CLRA                                                         * 2268 4F             O
           CLRB                                                         * 2269 5F             _
           STD    2,U                                                   * 226A ED 42          mB
           STB    1,U                                                   * 226C E7 41          gA
           STB    ,U                                                    * 226E E7 C4          gD
           CLRA                                                         * 2270 4F             O
           CLRB                                                         * 2271 5F             _
           STD    8,U                                                   * 2272 ED 48          mH
           STD    4,U                                                   * 2274 ED 44          mD
           BRA    L2284                                                 * 2276 20 0C           .
L2278      LDD    #20                                                   * 2278 CC 00 14       L..
           PSHS   D                                                     * 227B 34 06          4.
           LBSR   L233C                                                 * 227D 17 00 BC       ..<
           LEAS   2,S                                                   * 2280 32 62          2b
           TFR    D,U                                                   * 2282 1F 03          ..
L2284      LDD    [<$08,S]                                              * 2284 EC F8 08       lx.
           STD    ,S                                                    * 2287 ED E4          md
           BEQ    L22AE                                                 * 2289 27 23          '#
           LDD    10,S                                                  * 228B EC 6A          lj
           BGE    L2299                                                 * 228D 2C 0A          ,.
           LDD    ,S                                                    * 228F EC E4          ld
           STD    6,U                                                   * 2291 ED 46          mF
           LDX    ,S                                                    * 2293 AE E4          .d
           STU    4,X                                                   * 2295 EF 04          o.
           BRA    L22B6                                                 * 2297 20 1D           .
L2299      LDX    ,S                                                    * 2299 AE E4          .d
           LDD    6,X                                                   * 229B EC 06          l.
           STD    6,U                                                   * 229D ED 46          mF
           LDX    ,S                                                    * 229F AE E4          .d
           STU    6,X                                                   * 22A1 EF 06          o.
           LDX    ,S                                                    * 22A3 AE E4          .d
           LDB    1,X                                                   * 22A5 E6 01          f.
           SEX                                                          * 22A7 1D             .
           ORB    #8                                                    * 22A8 CA 08          J.
           STB    1,X                                                   * 22AA E7 01          g.
           BRA    L22B6                                                 * 22AC 20 08           .
L22AE      STU    [>Y07E7,Y]                                            * 22AE EF B9 07 E7    o9.g
           CLRA                                                         * 22B2 4F             O
           CLRB                                                         * 22B3 5F             _
           STD    6,U                                                   * 22B4 ED 46          mF
L22B6      LDD    6,S                                                   * 22B6 EC 66          lf
           PSHS   D                                                     * 22B8 34 06          4.
           PSHS   U                                                     * 22BA 34 40          4@
           LDD    #10                                                   * 22BC CC 00 0A       L..
           ADDD   ,S++                                                  * 22BF E3 E1          ca
           PSHS   D                                                     * 22C1 34 06          4.
           LBSR   L4514                                                 * 22C3 17 22 4E       ."N
           LEAS   4,S                                                   * 22C6 32 64          2d
           TFR    U,D                                                   * 22C8 1F 30          .0
           PULS   PC,U,X                                                * 22CA 35 D0          5P
L22CC      PSHS   U,D                                                   * 22CC 34 46          4F
           LDD    #1                                                    * 22CE CC 00 01       L..
           STD    ,S                                                    * 22D1 ED E4          md
           LEAS   -2,S                                                  * 22D3 32 7E          2~
           LDU    8,S                                                   * 22D5 EE 68          nh
           CLRA                                                         * 22D7 4F             O
           CLRB                                                         * 22D8 5F             _
           STD    ,S                                                    * 22D9 ED E4          md
L22DB      LDD    ,S                                                    * 22DB EC E4          ld
           PSHS   D                                                     * 22DD 34 06          4.
           LDB    ,U                                                    * 22DF E6 C4          fD
           SEX                                                          * 22E1 1D             .
           ADDD   ,S++                                                  * 22E2 E3 E1          ca
           STD    ,S                                                    * 22E4 ED E4          md
           LEAU   1,U                                                   * 22E6 33 41          3A
           LDB    ,U                                                    * 22E8 E6 C4          fD
           BNE    L22DB                                                 * 22EA 26 EF          &o
           LDD    ,S                                                    * 22EC EC E4          ld
           CLRA                                                         * 22EE 4F             O
           ANDB   #63                                                   * 22EF C4 3F          D?
           ASLB                                                         * 22F1 58             X
           ROLA                                                         * 22F2 49             I
           ADDD   <U0076                                                * 22F3 D3 76          Sv
           STD    >Y07E7,Y                                              * 22F5 ED A9 07 E7    m).g
           LEAS   2,S                                                   * 22F9 32 62          2b
           LDD    [>Y07E7,Y]                                            * 22FB EC B9 07 E7    l9.g
           STD    [<$08,S]                                              * 22FF ED F8 08       mx.
           TFR    D,U                                                   * 2302 1F 03          ..
           STU    -2,S                                                  * 2304 EF 7E          o~
           BEQ    L2338                                                 * 2306 27 30          '0
L2308      STU    [<$08,S]                                              * 2308 EF F8 08       ox.
           PSHS   U                                                     * 230B 34 40          4@
           LDD    #10                                                   * 230D CC 00 0A       L..
           ADDD   ,S++                                                  * 2310 E3 E1          ca
           PSHS   D                                                     * 2312 34 06          4.
           LDD    8,S                                                   * 2314 EC 68          lh
           PSHS   D                                                     * 2316 34 06          4.
           LBSR   L4559                                                 * 2318 17 22 3E       .">
           LEAS   4,S                                                   * 231B 32 64          2d
           STD    ,S                                                    * 231D ED E4          md
           BGE    L2325                                                 * 231F 2C 04          ,.
           LDU    4,U                                                   * 2321 EE 44          nD
           BRA    L2334                                                 * 2323 20 0F           .
L2325      LDD    ,S                                                    * 2325 EC E4          ld
           BLE    L2338                                                 * 2327 2F 0F          /.
           LDB    1,U                                                   * 2329 E6 41          fA
           CLRA                                                         * 232B 4F             O
           ANDB   #8                                                    * 232C C4 08          D.
           BEQ    L2338                                                 * 232E 27 08          '.
           LDU    6,U                                                   * 2330 EE 46          nF
           BRA    L2334                                                 * 2332 20 00           .
L2334      STU    -2,S                                                  * 2334 EF 7E          o~
           BNE    L2308                                                 * 2336 26 D0          &P
L2338      LDD    ,S                                                    * 2338 EC E4          ld
           PULS   PC,U,X                                                * 233A 35 D0          5P
L233C      PSHS   U,D                                                   * 233C 34 46          4F
           LDD    6,S                                                   * 233E EC 66          lf
           PSHS   D                                                     * 2340 34 06          4.
           LBSR   L496E                                                 * 2342 17 26 29       .&)
           LEAS   2,S                                                   * 2345 32 62          2b
           STD    ,S                                                    * 2347 ED E4          md
           CMPD   #-1                                                   * 2349 10 83 FF FF    ....
           BEQ    L2353                                                 * 234D 27 04          '.
           LDD    ,S                                                    * 234F EC E4          ld
           BRA    L235E                                                 * 2351 20 0B           .
L2353      LEAX   >L23A2,PC                                             * 2353 30 8D 00 4B    0..K
           PSHS   X                                                     * 2357 34 10          4.
           LBSR   L078B                                                 * 2359 17 E4 2F       .d/
           LEAS   2,S                                                   * 235C 32 62          2b
L235E      PULS   PC,U,X                                                * 235E 35 D0          5P
L2360      FCC    "symbol lost!?"                                       * 2360 73 79 6D 62 6F 6C 20 6C 6F 73 74 21 3F symbol lost!?
           FCB    $00                                                   * 236D 00             .
L236E      FCC    "redefined name"                                      * 236E 72 65 64 65 66 69 6E 65 64 20 6E 61 6D 65 redefined name
           FCB    $00                                                   * 237C 00             .
L237D      FCC    "new symbol in pass two"                              * 237D 6E 65 77 20 73 79 6D 62 6F 6C 20 69 6E 20 70 61 73 73 20 74 77 6F new symbol in pass two
           FCB    $00                                                   * 2393 00             .
L2394      FCC    "phasing error"                                       * 2394 70 68 61 73 69 6E 67 20 65 72 72 6F 72 phasing error
           FCB    $00                                                   * 23A1 00             .
L23A2      FCC    "symbol table overflow"                               * 23A2 73 79 6D 62 6F 6C 20 74 61 62 6C 65 20 6F 76 65 72 66 6C 6F 77 symbol table overflow
           FCB    $00                                                   * 23B7 00             .
L23B8      PSHS   U                                                     * 23B8 34 40          4@
           LDD    #-68                                                  * 23BA CC FF BC       L.<
           LBSR   _stkcheck                                             * 23BD 17 DD 4E       .]N
           LBSR   L2426                                                 * 23C0 17 00 63       ..c
           STD    -2,S                                                  * 23C3 ED 7E          m~
           BEQ    L23E2                                                 * 23C5 27 1B          '.
           LBSR   L1485                                                 * 23C7 17 F0 BB       .p;
           LBSR   L13DA                                                 * 23CA 17 F0 0D       .p.
           LDB    <U0061                                                * 23CD D6 61          Va
           SEX                                                          * 23CF 1D             .
           ANDB   #127                                                  * 23D0 C4 7F          D.
           BRA    L241F                                                 * 23D2 20 4B           K
L23D4      PSHS   U                                                     * 23D4 34 40          4@
           LDD    #-70                                                  * 23D6 CC FF BA       L.:
           LBSR   _stkcheck                                             * 23D9 17 DD 32       .]2
           BSR    L2426                                                 * 23DC 8D 48          .H
           STD    -2,S                                                  * 23DE ED 7E          m~
           BNE    L23E6                                                 * 23E0 26 04          &.
L23E2      CLRA                                                         * 23E2 4F             O
           CLRB                                                         * 23E3 5F             _
           PULS   PC,U                                                  * 23E4 35 C0          5@
L23E6      LDB    <U0061                                                * 23E6 D6 61          Va
           SEX                                                          * 23E8 1D             .
           ORB    #8                                                    * 23E9 CA 08          J.
           STB    <U0061                                                * 23EB D7 61          Wa
           LBSR   L1485                                                 * 23ED 17 F0 95       .p.
           LEAX   >Y07C7,Y                                              * 23F0 30 A9 07 C7    0).G
           CMPX   >Y07E5,Y                                              * 23F4 AC A9 07 E5    ,).e
           BCC    L23FF                                                 * 23F8 24 05          $.
           LBSR   L13DA                                                 * 23FA 17 EF DD       .o]
           BRA    L241A                                                 * 23FD 20 1B           .
L23FF      LDD    <U0031                                                * 23FF DC 31          \1
           CMPD   #256                                                  * 2401 10 83 01 00    ....
           BGE    L240F                                                 * 2405 2C 08          ,.
           LDD    <U0031                                                * 2407 DC 31          \1
           CMPD   #-256                                                 * 2409 10 83 FF 00    ....
           BGE    L241A                                                 * 240D 2C 0B          ,.
L240F      LEAX   >L2837,PC                                             * 240F 30 8D 04 24    0..$
           PSHS   X                                                     * 2413 34 10          4.
           LBSR   L074E                                                 * 2415 17 E3 36       .c6
           PULS   PC,U,X                                                * 2418 35 D0          5P
L241A      LDB    <U0061                                                * 241A D6 61          Va
           SEX                                                          * 241C 1D             .
           ANDB   #119                                                  * 241D C4 77          Dw
L241F      STB    <U0061                                                * 241F D7 61          Wa
           LDD    #1                                                    * 2421 CC 00 01       L..
           PULS   PC,U                                                  * 2424 35 C0          5@
L2426      PSHS   U                                                     * 2426 34 40          4@
           LDD    #-68                                                  * 2428 CC FF BC       L.<
           LBSR   _stkcheck                                             * 242B 17 DC E0       .\`
           LBSR   L2229                                                 * 242E 17 FD F8       .}x
           LEAX   >Y07C7,Y                                              * 2431 30 A9 07 C7    0).G
           STX    >Y07E5,Y                                              * 2435 AF A9 07 E5    /).e
           BSR    L244E                                                 * 2439 8D 13          ..
           PULS   PC,U                                                  * 243B 35 C0          5@
L243D      PSHS   U                                                     * 243D 34 40          4@
           LDD    #-68                                                  * 243F CC FF BC       L.<
           LBSR   _stkcheck                                             * 2442 17 DC C9       .\I
           LBSR   L0DEB                                                 * 2445 17 E9 A3       .i#
           STD    <U0031                                                * 2448 DD 31          ]1
           STD    <U003F                                                * 244A DD 3F          ]?
           PULS   PC,U                                                  * 244C 35 C0          5@
L244E      PSHS   U                                                     * 244E 34 40          4@
           LDD    #-77                                                  * 2450 CC FF B3       L.3
           LBSR   _stkcheck                                             * 2453 17 DC B8       .\8
           LEAS   -7,S                                                  * 2456 32 79          2y
           CLRA                                                         * 2458 4F             O
           CLRB                                                         * 2459 5F             _
           STD    <U003F                                                * 245A DD 3F          ]?
           LBSR   L250D                                                 * 245C 17 00 AE       ...
           STD    -2,S                                                  * 245F ED 7E          m~
           BEQ    L2489                                                 * 2461 27 26          '&
           LBRA   L24C2                                                 * 2463 16 00 5C       ..\
L2466      LDX    <U0062                                                * 2466 9E 62          .b
           LEAX   1,X                                                   * 2468 30 01          0.
           STX    <U0062                                                * 246A 9F 62          .b
           LDB    -1,X                                                  * 246C E6 1F          f.
           STB    ,S                                                    * 246E E7 E4          gd
           LDD    <U0031                                                * 2470 DC 31          \1
           STD    3,S                                                   * 2472 ED 63          mc
           LDD    >Y07E5,Y                                              * 2474 EC A9 07 E5    l).e
           STD    5,S                                                   * 2478 ED 65          me
           LDD    <U003F                                                * 247A DC 3F          \?
           STD    1,S                                                   * 247C ED 61          ma
           CLRA                                                         * 247E 4F             O
           CLRB                                                         * 247F 5F             _
           STD    <U003F                                                * 2480 DD 3F          ]?
           LBSR   L250D                                                 * 2482 17 00 88       ...
           STD    -2,S                                                  * 2485 ED 7E          m~
           BNE    L248E                                                 * 2487 26 05          &.
L2489      CLRA                                                         * 2489 4F             O
           CLRB                                                         * 248A 5F             _
           LBRA   L2509                                                 * 248B 16 00 7B       ..{
L248E      LDD    <U003F                                                * 248E DC 3F          \?
           ORA    1,S                                                   * 2490 AA 61          *a
           ORB    2,S                                                   * 2492 EA 62          jb
           STD    <U003F                                                * 2494 DD 3F          ]?
           LDB    ,S                                                    * 2496 E6 E4          fd
           CMPB   #43                                                   * 2498 C1 2B          A+
           BNE    L24A4                                                 * 249A 26 08          &.
           LDD    3,S                                                   * 249C EC 63          lc
           ADDD   <U0031                                                * 249E D3 31          S1
           STD    <U0031                                                * 24A0 DD 31          ]1
           BRA    L24C2                                                 * 24A2 20 1E           .
L24A4      LDD    3,S                                                   * 24A4 EC 63          lc
           SUBD   <U0031                                                * 24A6 93 31          .1
           STD    <U0031                                                * 24A8 DD 31          ]1
           BRA    L24B9                                                 * 24AA 20 0D           .
L24AC      LDX    5,S                                                   * 24AC AE 65          .e
           LEAX   3,X                                                   * 24AE 30 03          0.
           STX    5,S                                                   * 24B0 AF 65          /e
           LDB    -3,X                                                  * 24B2 E6 1D          f.
           SEX                                                          * 24B4 1D             .
           EORB   #64                                                   * 24B5 C8 40          H@
           STB    -3,X                                                  * 24B7 E7 1D          g.
L24B9      LDD    5,S                                                   * 24B9 EC 65          le
           CMPD   >Y07E5,Y                                              * 24BB 10 A3 A9 07 E5 .#).e
           BCS    L24AC                                                 * 24C0 25 EA          %j
L24C2      LDB    [>U0062,Y]                                            * 24C2 E6 B9 00 62    f9.b
           CMPB   #43                                                   * 24C6 C1 2B          A+
           LBEQ   L2466                                                 * 24C8 10 27 FF 9A    .'..
           LDB    [>U0062,Y]                                            * 24CC E6 B9 00 62    f9.b
           CMPB   #45                                                   * 24D0 C1 2D          A-
           LBEQ   L2466                                                 * 24D2 10 27 FF 90    .'..
           LDB    [>U0062,Y]                                            * 24D6 E6 B9 00 62    f9.b
           SEX                                                          * 24DA 1D             .
           TFR    D,X                                                   * 24DB 1F 01          ..
           BRA    L24EC                                                 * 24DD 20 0D           .
L24DF      LEAX   >L284A,PC                                             * 24DF 30 8D 03 67    0..g
           PSHS   X                                                     * 24E3 34 10          4.
           LBSR   L074E                                                 * 24E5 17 E2 66       .bf
           LEAS   2,S                                                   * 24E8 32 62          2b
           BRA    L2509                                                 * 24EA 20 1D           .
L24EC      CMPX   #32                                                   * 24EC 8C 00 20       ..
           BEQ    L2506                                                 * 24EF 27 15          '.
           STX    -2,S                                                  * 24F1 AF 7E          /~
           BEQ    L2506                                                 * 24F3 27 11          '.
           CMPX   #44                                                   * 24F5 8C 00 2C       ..,
           BEQ    L2506                                                 * 24F8 27 0C          '.
           CMPX   #41                                                   * 24FA 8C 00 29       ..)
           BEQ    L2506                                                 * 24FD 27 07          '.
           CMPX   #93                                                   * 24FF 8C 00 5D       ..]
           BEQ    L2506                                                 * 2502 27 02          '.
           BRA    L24DF                                                 * 2504 20 D9           Y
L2506      LDD    #1                                                    * 2506 CC 00 01       L..
L2509      LEAS   7,S                                                   * 2509 32 67          2g
           PULS   PC,U                                                  * 250B 35 C0          5@
L250D      PSHS   U                                                     * 250D 34 40          4@
           LDD    #-73                                                  * 250F CC FF B7       L.7
           LBSR   _stkcheck                                             * 2512 17 DB F9       .[y
           LEAS   -3,S                                                  * 2515 32 7D          2}
           LBSR   L2583                                                 * 2517 17 00 69       ..i
           STD    -2,S                                                  * 251A ED 7E          m~
           LBEQ   L2617                                                 * 251C 10 27 00 F7    .'.w
           BRA    L256E                                                 * 2520 20 4C           L
L2522      LDX    <U0062                                                * 2522 9E 62          .b
           LEAX   1,X                                                   * 2524 30 01          0.
           STX    <U0062                                                * 2526 9F 62          .b
           LDB    -1,X                                                  * 2528 E6 1F          f.
           STB    ,S                                                    * 252A E7 E4          gd
           LDD    <U0031                                                * 252C DC 31          \1
           STD    1,S                                                   * 252E ED 61          ma
           BSR    L2583                                                 * 2530 8D 51          .Q
           STD    -2,S                                                  * 2532 ED 7E          m~
           LBEQ   L2617                                                 * 2534 10 27 00 DF    .'._
           LDD    <U003F                                                * 2538 DC 3F          \?
           BEQ    L2541                                                 * 253A 27 05          '.
           LBSR   L243D                                                 * 253C 17 FE FE       .~~
           BRA    L256E                                                 * 253F 20 2D           -
L2541      LDB    ,S                                                    * 2541 E6 E4          fd
           CMPB   #42                                                   * 2543 C1 2A          A*
           BNE    L2552                                                 * 2545 26 0B          &.
           LDD    1,S                                                   * 2547 EC 61          la
           PSHS   D                                                     * 2549 34 06          4.
           LDD    <U0031                                                * 254B DC 31          \1
           LBSR   L466A                                                 * 254D 17 21 1A       .!.
           BRA    L256C                                                 * 2550 20 1A           .
L2552      LDD    <U0031                                                * 2552 DC 31          \1
           BNE    L2563                                                 * 2554 26 0D          &.
           LEAX   >L2857,PC                                             * 2556 30 8D 02 FD    0..}
           PSHS   X                                                     * 255A 34 10          4.
           LBSR   L074E                                                 * 255C 17 E1 EF       .ao
           LEAS   2,S                                                   * 255F 32 62          2b
           BRA    L256E                                                 * 2561 20 0B           .
L2563      LDD    1,S                                                   * 2563 EC 61          la
           PSHS   D                                                     * 2565 34 06          4.
           LDD    <U0031                                                * 2567 DC 31          \1
           LBSR   L4705                                                 * 2569 17 21 99       .!.
L256C      STD    <U0031                                                * 256C DD 31          ]1
L256E      LDB    [>U0062,Y]                                            * 256E E6 B9 00 62    f9.b
           CMPB   #42                                                   * 2572 C1 2A          A*
           BEQ    L2522                                                 * 2574 27 AC          ',
           LDB    [>U0062,Y]                                            * 2576 E6 B9 00 62    f9.b
           CMPB   #47                                                   * 257A C1 2F          A/
           LBEQ   L2522                                                 * 257C 10 27 FF A2    .'."
           LBRA   L2658                                                 * 2580 16 00 D5       ..U
L2583      PSHS   U                                                     * 2583 34 40          4@
           LDD    #-71                                                  * 2585 CC FF B9       L.9
           LBSR   _stkcheck                                             * 2588 17 DB 83       .[.
           LEAS   -3,S                                                  * 258B 32 7D          2}
           LBSR   L25E2                                                 * 258D 17 00 52       ..R
           STD    -2,S                                                  * 2590 ED 7E          m~
           LBEQ   L2617                                                 * 2592 10 27 00 81    .'..
           BRA    L25CD                                                 * 2596 20 35           5
L2598      LDX    <U0062                                                * 2598 9E 62          .b
           LEAX   1,X                                                   * 259A 30 01          0.
           STX    <U0062                                                * 259C 9F 62          .b
           LDB    -1,X                                                  * 259E E6 1F          f.
           STB    ,S                                                    * 25A0 E7 E4          gd
           LDD    <U0031                                                * 25A2 DC 31          \1
           STD    1,S                                                   * 25A4 ED 61          ma
           BSR    L25E2                                                 * 25A6 8D 3A          .:
           STD    -2,S                                                  * 25A8 ED 7E          m~
           LBEQ   L2617                                                 * 25AA 10 27 00 69    .'.i
           LDD    <U003F                                                * 25AE DC 3F          \?
           BEQ    L25B7                                                 * 25B0 27 05          '.
           LBSR   L243D                                                 * 25B2 17 FE 88       .~.
           BRA    L25CD                                                 * 25B5 20 16           .
L25B7      LDB    ,S                                                    * 25B7 E6 E4          fd
           CMPB   #38                                                   * 25B9 C1 26          A&
           BNE    L25C5                                                 * 25BB 26 08          &.
           LDD    1,S                                                   * 25BD EC 61          la
           ANDA   <U0031                                                * 25BF 94 31          .1
           ANDB   <U0032                                                * 25C1 D4 32          T2
           BRA    L25CB                                                 * 25C3 20 06           .
L25C5      LDD    1,S                                                   * 25C5 EC 61          la
           ORA    <U0031                                                * 25C7 9A 31          .1
           ORB    <U0032                                                * 25C9 DA 32          Z2
L25CB      STD    <U0031                                                * 25CB DD 31          ]1
L25CD      LDB    [>U0062,Y]                                            * 25CD E6 B9 00 62    f9.b
           CMPB   #38                                                   * 25D1 C1 26          A&
           BEQ    L2598                                                 * 25D3 27 C3          'C
           LDB    [>U0062,Y]                                            * 25D5 E6 B9 00 62    f9.b
           CMPB   #33                                                   * 25D9 C1 21          A!
           LBEQ   L2598                                                 * 25DB 10 27 FF B9    .'.9
           LBRA   L2658                                                 * 25DF 16 00 76       ..v
L25E2      PSHS   U                                                     * 25E2 34 40          4@
           LDD    #-71                                                  * 25E4 CC FF B9       L.9
           LBSR   _stkcheck                                             * 25E7 17 DB 24       .[$
           LEAS   -3,S                                                  * 25EA 32 7D          2}
           LDB    [>U0062,Y]                                            * 25EC E6 B9 00 62    f9.b
           STB    ,S                                                    * 25F0 E7 E4          gd
           CMPB   #43                                                   * 25F2 C1 2B          A+
           BEQ    L2604                                                 * 25F4 27 0E          '.
           LDB    ,S                                                    * 25F6 E6 E4          fd
           CMPB   #45                                                   * 25F8 C1 2D          A-
           BEQ    L2604                                                 * 25FA 27 08          '.
           LDB    ,S                                                    * 25FC E6 E4          fd
           CMPB   #94                                                   * 25FE C1 5E          A^
           LBNE   L265D                                                 * 2600 10 26 00 59    .&.Y
L2604      LDD    <U0062                                                * 2604 DC 62          \b
           ADDD   #1                                                    * 2606 C3 00 01       C..
           STD    <U0062                                                * 2609 DD 62          ]b
           LDD    >Y07E5,Y                                              * 260B EC A9 07 E5    l).e
           STD    1,S                                                   * 260F ED 61          ma
           BSR    L25E2                                                 * 2611 8D CF          .O
           STD    -2,S                                                  * 2613 ED 7E          m~
           BNE    L261B                                                 * 2615 26 04          &.
L2617      CLRA                                                         * 2617 4F             O
           CLRB                                                         * 2618 5F             _
           BRA    L265F                                                 * 2619 20 44           D
L261B      LDB    ,S                                                    * 261B E6 E4          fd
           CMPB   #45                                                   * 261D C1 2D          A-
           BNE    L2643                                                 * 261F 26 22          &"
           LDD    <U0031                                                * 2621 DC 31          \1
           NEGA                                                         * 2623 40             @
           NEGB                                                         * 2624 50             P
           SBCA   #0                                                    * 2625 82 00          ..
           STD    <U0031                                                * 2627 DD 31          ]1
           BRA    L2638                                                 * 2629 20 0D           .
L262B      LDX    1,S                                                   * 262B AE 61          .a
           LEAX   3,X                                                   * 262D 30 03          0.
           STX    1,S                                                   * 262F AF 61          /a
           LDB    -3,X                                                  * 2631 E6 1D          f.
           SEX                                                          * 2633 1D             .
           EORB   #64                                                   * 2634 C8 40          H@
           STB    -3,X                                                  * 2636 E7 1D          g.
L2638      LDD    1,S                                                   * 2638 EC 61          la
           CMPD   >Y07E5,Y                                              * 263A 10 A3 A9 07 E5 .#).e
           BCS    L262B                                                 * 263F 25 EA          %j
           BRA    L2658                                                 * 2641 20 15           .
L2643      LDB    ,S                                                    * 2643 E6 E4          fd
           CMPB   #94                                                   * 2645 C1 5E          A^
           BNE    L2658                                                 * 2647 26 0F          &.
           LDD    <U003F                                                * 2649 DC 3F          \?
           BEQ    L2652                                                 * 264B 27 05          '.
           LBSR   L243D                                                 * 264D 17 FD ED       .}m
           BRA    L2658                                                 * 2650 20 06           .
L2652      LDD    <U0031                                                * 2652 DC 31          \1
           COMA                                                         * 2654 43             C
           COMB                                                         * 2655 53             S
           STD    <U0031                                                * 2656 DD 31          ]1
L2658      LDD    #1                                                    * 2658 CC 00 01       L..
           BRA    L265F                                                 * 265B 20 02           .
L265D      BSR    L2663                                                 * 265D 8D 04          ..
L265F      LEAS   3,S                                                   * 265F 32 63          2c
           PULS   PC,U                                                  * 2661 35 C0          5@
L2663      PSHS   U                                                     * 2663 34 40          4@
           LDD    #-72                                                  * 2665 CC FF B8       L.8
           LBSR   _stkcheck                                             * 2668 17 DA A3       .Z#
           LEAS   -2,S                                                  * 266B 32 7E          2~
           LDB    [>U0062,Y]                                            * 266D E6 B9 00 62    f9.b
           SEX                                                          * 2671 1D             .
           TFR    D,X                                                   * 2672 1F 01          ..
           LBRA   L2730                                                 * 2674 16 00 B9       ..9
L2677      LDD    <U003F                                                * 2677 DC 3F          \?
           STD    ,S                                                    * 2679 ED E4          md
           LDD    <U0062                                                * 267B DC 62          \b
           ADDD   #1                                                    * 267D C3 00 01       C..
           STD    <U0062                                                * 2680 DD 62          ]b
           LBSR   L244E                                                 * 2682 17 FD C9       .}I
           STD    -2,S                                                  * 2685 ED 7E          m~
           BEQ    L26A4                                                 * 2687 27 1B          '.
           LDB    [>U0062,Y]                                            * 2689 E6 B9 00 62    f9.b
           CMPB   #41                                                   * 268D C1 29          A)
           BNE    L2699                                                 * 268F 26 08          &.
           LDD    <U003F                                                * 2691 DC 3F          \?
           ORA    ,S                                                    * 2693 AA E4          *d
           ORB    1,S                                                   * 2695 EA 61          ja
           BRA    L26E9                                                 * 2697 20 50           P
L2699      LEAX   >L2865,PC                                             * 2699 30 8D 01 C8    0..H
           PSHS   X                                                     * 269D 34 10          4.
           LBSR   L074E                                                 * 269F 17 E0 AC       .`,
           LEAS   2,S                                                   * 26A2 32 62          2b
L26A4      CLRA                                                         * 26A4 4F             O
           CLRB                                                         * 26A5 5F             _
           PULS   PC,U,X                                                * 26A6 35 D0          5P
L26A8      LDD    <U004B                                                * 26A8 DC 4B          \K
           BNE    L26C7                                                 * 26AA 26 1B          &.
           LDD    <U0053                                                * 26AC DC 53          \S
           BNE    L26BF                                                 * 26AE 26 0F          &.
           LEAX   >L2879,PC                                             * 26B0 30 8D 01 C5    0..E
           PSHS   X                                                     * 26B4 34 10          4.
           LBSR   L074E                                                 * 26B6 17 E0 95       .`.
           LEAS   2,S                                                   * 26B9 32 62          2b
           STD    <U0031                                                * 26BB DD 31          ]1
           PULS   PC,U,X                                                * 26BD 35 D0          5P
L26BF      LDD    [>U0053,Y]                                            * 26BF EC B9 00 53    l9.S
           STD    <U0031                                                * 26C3 DD 31          ]1
           BRA    L26FE                                                 * 26C5 20 37           7
L26C7      LDD    [>U004B,Y]                                            * 26C7 EC B9 00 4B    l9.K
           STD    <U0031                                                * 26CB DD 31          ]1
           LDB    <U005D                                                * 26CD D6 5D          V]
           STB    [>Y07E5,Y]                                            * 26CF E7 B9 07 E5    g9.e
           LDD    <U007A                                                * 26D3 DC 7A          \z
           LDX    >Y07E5,Y                                              * 26D5 AE A9 07 E5    .).e
           STD    1,X                                                   * 26D9 ED 01          m.
           LDD    >Y07E5,Y                                              * 26DB EC A9 07 E5    l).e
           ADDD   #3                                                    * 26DF C3 00 03       C..
           STD    >Y07E5,Y                                              * 26E2 ED A9 07 E5    m).e
           LDD    #1                                                    * 26E6 CC 00 01       L..
L26E9      STD    <U003F                                                * 26E9 DD 3F          ]?
           BRA    L26FE                                                 * 26EB 20 11           .
L26ED      LDX    <U0062                                                * 26ED 9E 62          .b
           LEAX   1,X                                                   * 26EF 30 01          0.
           STX    <U0062                                                * 26F1 9F 62          .b
           LDB    ,X                                                    * 26F3 E6 84          f.
           SEX                                                          * 26F5 1D             .
           STD    <U0031                                                * 26F6 DD 31          ]1
           BNE    L26FE                                                 * 26F8 26 04          &.
           CLRA                                                         * 26FA 4F             O
           CLRB                                                         * 26FB 5F             _
           PULS   PC,U,X                                                * 26FC 35 D0          5P
L26FE      LDD    <U0062                                                * 26FE DC 62          \b
           ADDD   #1                                                    * 2700 C3 00 01       C..
           STD    <U0062                                                * 2703 DD 62          ]b
           BRA    L2745                                                 * 2705 20 3E           >
L2707      BSR    L274A                                                 * 2707 8D 41          .A
           STD    -2,S                                                  * 2709 ED 7E          m~
           BNE    L2745                                                 * 270B 26 38          &8
           LEAX   >Y05BD,Y                                              * 270D 30 A9 05 BD    0).=
           PSHS   X                                                     * 2711 34 10          4.
           LBSR   L1E0B                                                 * 2713 17 F6 F5       .vu
           STD    ,S++                                                  * 2716 ED E1          ma
           BEQ    L271F                                                 * 2718 27 05          '.
           LBSR   L1F99                                                 * 271A 17 F8 7C       .x|
           BRA    L2745                                                 * 271D 20 26           &
L271F      LEAX   >L2887,PC                                             * 271F 30 8D 01 64    0..d
           PSHS   X                                                     * 2723 34 10          4.
           LBSR   L074E                                                 * 2725 17 E0 26       .`&
           LEAS   2,S                                                   * 2728 32 62          2b
           STD    <U0031                                                * 272A DD 31          ]1
           PULS   PC,U,X                                                * 272C 35 D0          5P
           BRA    L2745                                                 * 272E 20 15           .
L2730      CMPX   #40                                                   * 2730 8C 00 28       ..(
           LBEQ   L2677                                                 * 2733 10 27 FF 40    .'.@
           CMPX   #42                                                   * 2737 8C 00 2A       ..*
           LBEQ   L26A8                                                 * 273A 10 27 FF 6A    .'.j
           CMPX   #39                                                   * 273E 8C 00 27       ..'
           BEQ    L26ED                                                 * 2741 27 AA          '*
           BRA    L2707                                                 * 2743 20 C2           B
L2745      LDD    #1                                                    * 2745 CC 00 01       L..
           PULS   PC,U,X                                                * 2748 35 D0          5P
L274A      PSHS   U                                                     * 274A 34 40          4@
           LDD    #-72                                                  * 274C CC FF B8       L.8
           LBSR   _stkcheck                                             * 274F 17 D9 BC       .Y<
           LEAS   -6,S                                                  * 2752 32 7A          2z
           CLRA                                                         * 2754 4F             O
           CLRB                                                         * 2755 5F             _
           STD    4,S                                                   * 2756 ED 64          md
           CLRA                                                         * 2758 4F             O
           CLRB                                                         * 2759 5F             _
           STD    2,S                                                   * 275A ED 62          mb
           LDD    #8                                                    * 275C CC 00 08       L..
           STB    1,S                                                   * 275F E7 61          ga
           LDB    [>U0062,Y]                                            * 2761 E6 B9 00 62    f9.b
           STB    ,S                                                    * 2765 E7 E4          gd
           SEX                                                          * 2767 1D             .
           TFR    D,X                                                   * 2768 1F 01          ..
           BRA    L27AD                                                 * 276A 20 41           A
L276C      LDX    <U0062                                                * 276C 9E 62          .b
           LEAX   1,X                                                   * 276E 30 01          0.
           STX    <U0062                                                * 2770 9F 62          .b
           LDB    ,X                                                    * 2772 E6 84          f.
           STB    ,S                                                    * 2774 E7 E4          gd
           LDD    #2                                                    * 2776 CC 00 02       L..
           STD    4,S                                                   * 2779 ED 64          md
           LDD    #16                                                   * 277B CC 00 10       L..
           BRA    L2792                                                 * 277E 20 12           .
L2780      LDX    <U0062                                                * 2780 9E 62          .b
           LEAX   1,X                                                   * 2782 30 01          0.
           STX    <U0062                                                * 2784 9F 62          .b
           LDB    ,X                                                    * 2786 E6 84          f.
           STB    ,S                                                    * 2788 E7 E4          gd
           LDD    #16                                                   * 278A CC 00 10       L..
           STD    4,S                                                   * 278D ED 64          md
           LDD    #32                                                   * 278F CC 00 20       L.
L2792      STB    1,S                                                   * 2792 E7 61          ga
           BRA    L27B9                                                 * 2794 20 23           #
L2796      LDB    ,S                                                    * 2796 E6 E4          fd
           SEX                                                          * 2798 1D             .
           LEAX   >Y03FC,Y                                              * 2799 30 A9 03 FC    0).|
           LEAX   D,X                                                   * 279D 30 8B          0.
           LDB    ,X                                                    * 279F E6 84          f.
           CLRA                                                         * 27A1 4F             O
           ANDB   #8                                                    * 27A2 C4 08          D.
           BEQ    L27B9                                                 * 27A4 27 13          '.
           LDD    #10                                                   * 27A6 CC 00 0A       L..
           STD    4,S                                                   * 27A9 ED 64          md
           BRA    L27B9                                                 * 27AB 20 0C           .
L27AD      CMPX   #37                                                   * 27AD 8C 00 25       ..%
           BEQ    L276C                                                 * 27B0 27 BA          ':
           CMPX   #36                                                   * 27B2 8C 00 24       ..$
           BEQ    L2780                                                 * 27B5 27 C9          'I
           BRA    L2796                                                 * 27B7 20 DD           ]
L27B9      LDD    4,S                                                   * 27B9 EC 64          ld
           BNE    L27C2                                                 * 27BB 26 05          &.
           CLRA                                                         * 27BD 4F             O
           CLRB                                                         * 27BE 5F             _
           LBRA   L2833                                                 * 27BF 16 00 71       ..q
L27C2      CLRA                                                         * 27C2 4F             O
           CLRB                                                         * 27C3 5F             _
           STD    <U0031                                                * 27C4 DD 31          ]1
           BRA    L27FC                                                 * 27C6 20 34           4
L27C8      LDD    <U0031                                                * 27C8 DC 31          \1
           PSHS   D                                                     * 27CA 34 06          4.
           LDD    6,S                                                   * 27CC EC 66          lf
           LBSR   L466A                                                 * 27CE 17 1E 99       ...
           PSHS   D                                                     * 27D1 34 06          4.
           LDB    2,S                                                   * 27D3 E6 62          fb
           CMPB   #65                                                   * 27D5 C1 41          AA
           BGE    L27E1                                                 * 27D7 2C 08          ,.
           LDB    2,S                                                   * 27D9 E6 62          fb
           SEX                                                          * 27DB 1D             .
           ADDD   #-48                                                  * 27DC C3 FF D0       C.P
           BRA    L27E7                                                 * 27DF 20 06           .
L27E1      LDB    2,S                                                   * 27E1 E6 62          fb
           SEX                                                          * 27E3 1D             .
           ADDD   #-55                                                  * 27E4 C3 FF C9       C.I
L27E7      ADDD   ,S++                                                  * 27E7 E3 E1          ca
           STD    <U0031                                                * 27E9 DD 31          ]1
           LDD    2,S                                                   * 27EB EC 62          lb
           ADDD   #1                                                    * 27ED C3 00 01       C..
           STD    2,S                                                   * 27F0 ED 62          mb
           LDX    <U0062                                                * 27F2 9E 62          .b
           LEAX   1,X                                                   * 27F4 30 01          0.
           STX    <U0062                                                * 27F6 9F 62          .b
           LDB    ,X                                                    * 27F8 E6 84          f.
           STB    ,S                                                    * 27FA E7 E4          gd
L27FC      LDB    ,S                                                    * 27FC E6 E4          fd
           SEX                                                          * 27FE 1D             .
           LEAX   >Y03FC,Y                                              * 27FF 30 A9 03 FC    0).|
           LEAX   D,X                                                   * 2803 30 8B          0.
           LDB    ,X                                                    * 2805 E6 84          f.
           CLRA                                                         * 2807 4F             O
           ANDB   #4                                                    * 2808 C4 04          D.
           BEQ    L2813                                                 * 280A 27 07          '.
           LDB    ,S                                                    * 280C E6 E4          fd
           CLRA                                                         * 280E 4F             O
           ANDB   #223                                                  * 280F C4 DF          D_
           BRA    L2816                                                 * 2811 20 03           .
L2813      LDB    ,S                                                    * 2813 E6 E4          fd
           SEX                                                          * 2815 1D             .
L2816      STB    ,S                                                    * 2816 E7 E4          gd
           SEX                                                          * 2818 1D             .
           LEAX   >Y03FC,Y                                              * 2819 30 A9 03 FC    0).|
           LEAX   D,X                                                   * 281D 30 8B          0.
           LDB    ,X                                                    * 281F E6 84          f.
           SEX                                                          * 2821 1D             .
           PSHS   D                                                     * 2822 34 06          4.
           LDB    3,S                                                   * 2824 E6 63          fc
           SEX                                                          * 2826 1D             .
           ANDA   ,S+                                                   * 2827 A4 E0          $`
           ANDB   ,S+                                                   * 2829 E4 E0          d`
           STD    -2,S                                                  * 282B ED 7E          m~
           LBNE   L27C8                                                 * 282D 10 26 FF 97    .&..
           LDD    2,S                                                   * 2831 EC 62          lb
L2833      LEAS   6,S                                                   * 2833 32 66          2f
           PULS   PC,U                                                  * 2835 35 C0          5@
L2837      FCC    "value out of range"                                  * 2837 76 61 6C 75 65 20 6F 75 74 20 6F 66 20 72 61 6E 67 65 value out of range
           FCB    $00                                                   * 2849 00             .
L284A      FCC    "bad operator"                                        * 284A 62 61 64 20 6F 70 65 72 61 74 6F 72 bad operator
           FCB    $00                                                   * 2856 00             .
L2857      FCC    "zero division"                                       * 2857 7A 65 72 6F 20 64 69 76 69 73 69 6F 6E zero division
           FCB    $00                                                   * 2864 00             .
L2865      FCC    "parenthesis missing"                                 * 2865 70 61 72 65 6E 74 68 65 73 69 73 20 6D 69 73 73 69 6E 67 parenthesis missing
           FCB    $00                                                   * 2878 00             .
L2879      FCC    "undefined org"                                       * 2879 75 6E 64 65 66 69 6E 65 64 20 6F 72 67 undefined org
           FCB    $00                                                   * 2886 00             .
L2887      FCC    "bad operand"                                         * 2887 62 61 64 20 6F 70 65 72 61 6E 64 bad operand
           FCB    $00                                                   * 2892 00             .
L2893      PSHS   U                                                     * 2893 34 40          4@
           LEAS   -1,S                                                  * 2895 32 7F          2.
           CLRA                                                         * 2897 4F             O
           CLRB                                                         * 2898 5F             _
           STD    <U0017                                                * 2899 DD 17          ].
           STD    <U0015                                                * 289B DD 15          ].
           LEAX   >Y0496,Y                                              * 289D 30 A9 04 96    0)..
           STX    <U0019                                                * 28A1 9F 19          ..
           LBRA   L291C                                                 * 28A3 16 00 76       ..v
L28A6      LDX    7,S                                                   * 28A6 AE 67          .g
           LDB    [,X]                                                  * 28A8 E6 94          f.
           CMPB   #45                                                   * 28AA C1 2D          A-
           BNE    L28F8                                                 * 28AC 26 4A          &J
           LDD    [<$07,S]                                              * 28AE EC F8 07       lx.
           ADDD   #1                                                    * 28B1 C3 00 01       C..
           STD    <U0062                                                * 28B4 DD 62          ]b
           LBSR   L1A48                                                 * 28B6 17 F1 8F       .q.
           LDB    <U00C6                                                * 28B9 D6 C6          VF
           LBEQ   L291C                                                 * 28BB 10 27 00 5D    .'.]
           LDX    <U0062                                                * 28BF 9E 62          .b
           LDB    -1,X                                                  * 28C1 E6 1F          f.
           CLRA                                                         * 28C3 4F             O
           ANDB   #223                                                  * 28C4 C4 DF          D_
           STB    ,S                                                    * 28C6 E7 E4          gd
           BEQ    L291C                                                 * 28C8 27 52          'R
           LDB    ,S                                                    * 28CA E6 E4          fd
           CMPB   #79                                                   * 28CC C1 4F          AO
           BNE    L291C                                                 * 28CE 26 4C          &L
           LDB    [>U0062,Y]                                            * 28D0 E6 B9 00 62    f9.b
           CMPB   #61                                                   * 28D4 C1 3D          A=
           BNE    L291C                                                 * 28D6 26 44          &D
           LDD    >Y03F8,Y                                              * 28D8 EC A9 03 F8    l).x
           BEQ    L28EB                                                 * 28DC 27 0D          '.
           LEAX   >L30DB,PC                                             * 28DE 30 8D 07 F9    0..y
           PSHS   X                                                     * 28E2 34 10          4.
           LBSR   L078B                                                 * 28E4 17 DE A4       .^$
           LEAS   2,S                                                   * 28E7 32 62          2b
           BRA    L291C                                                 * 28E9 20 31           1
L28EB      LDD    <U0062                                                * 28EB DC 62          \b
           ADDD   #1                                                    * 28ED C3 00 01       C..
           STD    <U0062                                                * 28F0 DD 62          ]b
           STD    >Y03F8,Y                                              * 28F2 ED A9 03 F8    m).x
           BRA    L291C                                                 * 28F6 20 24           $
L28F8      LEAX   >Y0855,Y                                              * 28F8 30 A9 08 55    0).U
           CMPX   >Y03F6,Y                                              * 28FC AC A9 03 F6    ,).v
           BCC    L290D                                                 * 2900 24 0B          $.
           LEAX   >L30F1,PC                                             * 2902 30 8D 07 EB    0..k
           PSHS   X                                                     * 2906 34 10          4.
           LBSR   L078B                                                 * 2908 17 DE 80       .^.
           LEAS   2,S                                                   * 290B 32 62          2b
L290D      LDD    [<$07,S]                                              * 290D EC F8 07       lx.
           LDX    >Y03F6,Y                                              * 2910 AE A9 03 F6    .).v
           LEAX   2,X                                                   * 2914 30 02          0.
           STX    >Y03F6,Y                                              * 2916 AF A9 03 F6    /).v
           STD    -2,X                                                  * 291A ED 1E          m.
L291C      LDD    7,S                                                   * 291C EC 67          lg
           ADDD   #2                                                    * 291E C3 00 02       C..
           STD    7,S                                                   * 2921 ED 67          mg
           LDD    5,S                                                   * 2923 EC 65          le
           ADDD   #-1                                                   * 2925 C3 FF FF       C..
           STD    5,S                                                   * 2928 ED 65          me
           LBNE   L28A6                                                 * 292A 10 26 FF 78    .&.x
           LEAX   >Y0817,Y                                              * 292E 30 A9 08 17    0)..
           CMPX   >Y03F6,Y                                              * 2932 AC A9 03 F6    ,).v
           BNE    L2943                                                 * 2936 26 0B          &.
           LEAX   >L3106,PC                                             * 2938 30 8D 07 CA    0..J
           PSHS   X                                                     * 293C 34 10          4.
           LBSR   L078B                                                 * 293E 17 DE 4A       .^J
           LEAS   2,S                                                   * 2941 32 62          2b
L2943      LDD    >Y03F8,Y                                              * 2943 EC A9 03 F8    l).x
           BNE    L2951                                                 * 2947 26 08          &.
           LEAX   >L3114,PC                                             * 2949 30 8D 07 C7    0..G
           STX    >Y03F8,Y                                              * 294D AF A9 03 F8    /).x
L2951      LEAS   1,S                                                   * 2951 32 61          2a
           PULS   PC,U                                                  * 2953 35 C0          5@
L2955      PSHS   U,D                                                   * 2955 34 46          4F
           LDD    8,S                                                   * 2957 EC 68          lh
           PSHS   D                                                     * 2959 34 06          4.
           LDD    8,S                                                   * 295B EC 68          lh
           PSHS   D                                                     * 295D 34 06          4.
           LBSR   fopen                                                 * 295F 17 0F BC       ..<
           LEAS   4,S                                                   * 2962 32 64          2d
           STD    ,S                                                    * 2964 ED E4          md
           BNE    L2988                                                 * 2966 26 20          &
           LDD    6,S                                                   * 2968 EC 66          lf
           PSHS   D                                                     * 296A 34 06          4.
           LEAX   >L311D,PC                                             * 296C 30 8D 07 AD    0..-
           PSHS   X                                                     * 2970 34 10          4.
           LEAX   >Y04A3,Y                                              * 2972 30 A9 04 A3    0).#
           PSHS   X                                                     * 2976 34 10          4.
           LBSR   L3A0E                                                 * 2978 17 10 93       ...
           LEAS   6,S                                                   * 297B 32 66          2f
           LEAX   >L3125,PC                                             * 297D 30 8D 07 A4    0..$
           PSHS   X                                                     * 2981 34 10          4.
           LBSR   L078B                                                 * 2983 17 DE 05       .^.
           LEAS   2,S                                                   * 2986 32 62          2b
L2988      LDD    ,S                                                    * 2988 EC E4          ld
           PULS   PC,U,X                                                * 298A 35 D0          5P
L298C      PSHS   U                                                     * 298C 34 40          4@
           LDB    <U005B                                                * 298E D6 5B          V[
           LBEQ   L2A7D                                                 * 2990 10 27 00 E9    .'.i
           LDD    <U003D                                                * 2994 DC 3D          \=
           LBEQ   L2A7D                                                 * 2996 10 27 00 E3    .'.c
           LDD    >U00C8,Y                                              * 299A EC A9 00 C8    l).H
           BEQ    L29D6                                                 * 299E 27 36          '6
           LDB    <U00C0                                                * 29A0 D6 C0          V@
           BEQ    L29CD                                                 * 29A2 27 29          ')
           LDD    <U0019                                                * 29A4 DC 19          \.
           PSHS   D                                                     * 29A6 34 06          4.
           LDD    #12                                                   * 29A8 CC 00 0C       L..
           PSHS   D                                                     * 29AB 34 06          4.
           LBSR   L40C2                                                 * 29AD 17 17 12       ...
           LEAS   4,S                                                   * 29B0 32 64          2d
           BRA    L29D6                                                 * 29B2 20 22           "
L29B4      LDD    <U0019                                                * 29B4 DC 19          \.
           PSHS   D                                                     * 29B6 34 06          4.
           LDD    #13                                                   * 29B8 CC 00 0D       L..
           PSHS   D                                                     * 29BB 34 06          4.
           LBSR   L40C2                                                 * 29BD 17 17 02       ...
           LEAS   4,S                                                   * 29C0 32 64          2d
           LDD    >U00C8,Y                                              * 29C2 EC A9 00 C8    l).H
           ADDD   #1                                                    * 29C6 C3 00 01       C..
           STD    >U00C8,Y                                              * 29C9 ED A9 00 C8    m).H
L29CD      LDD    >U00C8,Y                                              * 29CD EC A9 00 C8    l).H
           CMPD   <U0003                                                * 29D1 10 93 03       ...
           BLT    L29B4                                                 * 29D4 2D DE          -^
L29D6      LEAX   >Y07F9,Y                                              * 29D6 30 A9 07 F9    0).y
           PSHS   X                                                     * 29DA 34 10          4.
           LBSR   L49FA                                                 * 29DC 17 20 1B       . .
           LEAS   2,S                                                   * 29DF 32 62          2b
           LDB    >Y07FD,Y                                              * 29E1 E6 A9 07 FD    f).}
           SEX                                                          * 29E5 1D             .
           PSHS   D                                                     * 29E6 34 06          4.
           LDB    >Y07FC,Y                                              * 29E8 E6 A9 07 FC    f).|
           SEX                                                          * 29EC 1D             .
           PSHS   D                                                     * 29ED 34 06          4.
           LDB    >Y07FB,Y                                              * 29EF E6 A9 07 FB    f).{
           SEX                                                          * 29F3 1D             .
           PSHS   D                                                     * 29F4 34 06          4.
           LDB    >Y07FA,Y                                              * 29F6 E6 A9 07 FA    f).z
           SEX                                                          * 29FA 1D             .
           PSHS   D                                                     * 29FB 34 06          4.
           LDB    >Y07F9,Y                                              * 29FD E6 A9 07 F9    f).y
           SEX                                                          * 2A01 1D             .
           PSHS   D                                                     * 2A02 34 06          4.
           LEAX   >L3160,PC                                             * 2A04 30 8D 07 58    0..X
           PSHS   X                                                     * 2A08 34 10          4.
           LEAX   >L3135,PC                                             * 2A0A 30 8D 07 27    0..'
           PSHS   X                                                     * 2A0E 34 10          4.
           LBSR   L39FC                                                 * 2A10 17 0F E9       ..i
           LEAS   14,S                                                  * 2A13 32 6E          2n
           LDD    <U002D                                                * 2A15 DC 2D          \-
           ADDD   #1                                                    * 2A17 C3 00 01       C..
           STD    <U002D                                                * 2A1A DD 2D          ]-
           PSHS   D                                                     * 2A1C 34 06          4.
           LDD    >Y0817,Y                                              * 2A1E EC A9 08 17    l)..
           PSHS   D                                                     * 2A22 34 06          4.
           LEAX   >L316B,PC                                             * 2A24 30 8D 07 43    0..C
           PSHS   X                                                     * 2A28 34 10          4.
           LBSR   L39FC                                                 * 2A2A 17 0F CF       ..O
           LEAS   6,S                                                   * 2A2D 32 66          2f
           LEAX   >Y063F,Y                                              * 2A2F 30 A9 06 3F    0).?
           PSHS   X                                                     * 2A33 34 10          4.
           LEAX   >Y05C7,Y                                              * 2A35 30 A9 05 C7    0).G
           PSHS   X                                                     * 2A39 34 10          4.
           LEAX   >L317E,PC                                             * 2A3B 30 8D 07 3F    0..?
           PSHS   X                                                     * 2A3F 34 10          4.
           LBSR   L39FC                                                 * 2A41 17 0F B8       ..8
           LEAS   6,S                                                   * 2A44 32 66          2f
           LDD    #3                                                    * 2A46 CC 00 03       L..
           BRA    L2A79                                                 * 2A49 20 2E           .
L2A4B      PSHS   U                                                     * 2A4B 34 40          4@
           LDB    <U005B                                                * 2A4D D6 5B          V[
           BEQ    L2A7D                                                 * 2A4F 27 2C          ',
           LDD    <U003D                                                * 2A51 DC 3D          \=
           BEQ    L2A7D                                                 * 2A53 27 28          '(
           LDD    <U0003                                                * 2A55 DC 03          \.
           ADDD   #-3                                                   * 2A57 C3 FF FD       C.}
           CMPD   >U00C8,Y                                              * 2A5A 10 A3 A9 00 C8 .#).H
           BGE    L2A64                                                 * 2A5F 2C 03          ,.
           LBSR   L298C                                                 * 2A61 17 FF 28       ..(
L2A64      LDD    <U0019                                                * 2A64 DC 19          \.
           PSHS   D                                                     * 2A66 34 06          4.
           LDD    #13                                                   * 2A68 CC 00 0D       L..
           PSHS   D                                                     * 2A6B 34 06          4.
           LBSR   L40C2                                                 * 2A6D 17 16 52       ..R
           LEAS   4,S                                                   * 2A70 32 64          2d
           LDD    >U00C8,Y                                              * 2A72 EC A9 00 C8    l).H
           ADDD   #1                                                    * 2A76 C3 00 01       C..
L2A79      STD    >U00C8,Y                                              * 2A79 ED A9 00 C8    m).H
L2A7D      PULS   PC,U                                                  * 2A7D 35 C0          5@
L2A7F      PSHS   U                                                     * 2A7F 34 40          4@
           LEAS   -3,S                                                  * 2A81 32 7D          2}
           LBSR   L342B                                                 * 2A83 17 09 A5       ..%
           STD    -2,S                                                  * 2A86 ED 7E          m~
           BNE    L2AC1                                                 * 2A88 26 37          &7
L2A8A      LDB    <U00C2                                                * 2A8A D6 C2          VB
           BEQ    L2AA3                                                 * 2A8C 27 15          '.
           LEAX   >Y07FF,Y                                              * 2A8E 30 A9 07 FF    0)..
           CMPX   >Y03F4,Y                                              * 2A92 AC A9 03 F4    ,).t
           BNE    L2AA3                                                 * 2A96 26 0B          &.
           LEAX   >L3188,PC                                             * 2A98 30 8D 06 EC    0..l
           PSHS   X                                                     * 2A9C 34 10          4.
           LBSR   L39FC                                                 * 2A9E 17 0F 5B       ..[
           LEAS   2,S                                                   * 2AA1 32 62          2b
L2AA3      LEAX   >Y0857,Y                                              * 2AA3 30 A9 08 57    0).W
           STX    <U0062                                                * 2AA7 9F 62          .b
           TFR    X,D                                                   * 2AA9 1F 10          ..
           STD    1,S                                                   * 2AAB ED 61          ma
           BRA    L2AD0                                                 * 2AAD 20 21           !
L2AAF      LDB    ,S                                                    * 2AAF E6 E4          fd
           CMPB   #13                                                   * 2AB1 C1 0D          A.
           BNE    L2AC6                                                 * 2AB3 26 11          &.
           CLRA                                                         * 2AB5 4F             O
           CLRB                                                         * 2AB6 5F             _
           STB    [<$01,S]                                              * 2AB7 E7 F8 01       gx.
           LDD    <U002F                                                * 2ABA DC 2F          \/
           ADDD   #1                                                    * 2ABC C3 00 01       C..
           STD    <U002F                                                * 2ABF DD 2F          ]/
L2AC1      LDD    #1                                                    * 2AC1 CC 00 01       L..
           BRA    L2AEC                                                 * 2AC4 20 26           &
L2AC6      LDB    ,S                                                    * 2AC6 E6 E4          fd
           LDX    1,S                                                   * 2AC8 AE 61          .a
           LEAX   1,X                                                   * 2ACA 30 01          0.
           STX    1,S                                                   * 2ACC AF 61          /a
           STB    -1,X                                                  * 2ACE E7 1F          g.
L2AD0      LDD    <U0015                                                * 2AD0 DC 15          \.
           PSHS   D                                                     * 2AD2 34 06          4.
           LBSR   L42D5                                                 * 2AD4 17 17 FE       ..~
           LEAS   2,S                                                   * 2AD7 32 62          2b
           STB    ,S                                                    * 2AD9 E7 E4          gd
           SEX                                                          * 2ADB 1D             .
           CMPD   #-1                                                   * 2ADC 10 83 FF FF    ....
           BNE    L2AAF                                                 * 2AE0 26 CD          &M
           BSR    L2AF0                                                 * 2AE2 8D 0C          ..
           STD    -2,S                                                  * 2AE4 ED 7E          m~
           LBNE   L2A8A                                                 * 2AE6 10 26 FF A0    .&.
           CLRA                                                         * 2AEA 4F             O
           CLRB                                                         * 2AEB 5F             _
L2AEC      LEAS   3,S                                                   * 2AEC 32 63          2c
           PULS   PC,U                                                  * 2AEE 35 C0          5@
L2AF0      PSHS   U                                                     * 2AF0 34 40          4@
           LEAX   >Y07FF,Y                                              * 2AF2 30 A9 07 FF    0)..
           CMPX   >Y03F4,Y                                              * 2AF6 AC A9 03 F4    ,).t
           BNE    L2B00                                                 * 2AFA 26 04          &.
           CLRA                                                         * 2AFC 4F             O
           CLRB                                                         * 2AFD 5F             _
           PULS   PC,U                                                  * 2AFE 35 C0          5@
L2B00      LDD    <U0015                                                * 2B00 DC 15          \.
           PSHS   D                                                     * 2B02 34 06          4.
           LBSR   fclose                                                * 2B04 17 16 AB       ..+
           STD    ,S++                                                  * 2B07 ED E1          ma
           BEQ    L2B16                                                 * 2B09 27 0B          '.
           LEAX   >L318D,PC                                             * 2B0B 30 8D 06 7E    0..~
           PSHS   X                                                     * 2B0F 34 10          4.
           LBSR   L074E                                                 * 2B11 17 DC 3A       .\:
           LEAS   2,S                                                   * 2B14 32 62          2b
L2B16      LDX    >Y03F4,Y                                              * 2B16 AE A9 03 F4    .).t
           LEAX   -2,X                                                  * 2B1A 30 1E          0.
           STX    >Y03F4,Y                                              * 2B1C AF A9 03 F4    /).t
           LDD    ,X                                                    * 2B20 EC 84          l.
           STD    <U0015                                                * 2B22 DD 15          ].
           LDD    #1                                                    * 2B24 CC 00 01       L..
           PULS   PC,U                                                  * 2B27 35 C0          5@
L2B29      PSHS   U                                                     * 2B29 34 40          4@
           LEAX   >L319E,PC                                             * 2B2B 30 8D 06 6F    0..o
           PSHS   X                                                     * 2B2F 34 10          4.
           LBSR   L39FC                                                 * 2B31 17 0E C8       ..H
           LEAS   2,S                                                   * 2B34 32 62          2b
           LDD    <U0005                                                * 2B36 DC 05          \.
           SUBD   #24                                                   * 2B38 83 00 18       ...
           STD    <U0005                                                * 2B3B DD 05          ].
           LEAX   >L2B64,PC                                             * 2B3D 30 8D 00 23    0..#
           PSHS   X                                                     * 2B41 34 10          4.
           LBSR   L2EF2                                                 * 2B43 17 03 AC       ..,
           LEAS   2,S                                                   * 2B46 32 62          2b
           LDD    >Y03FA,Y                                              * 2B48 EC A9 03 FA    l).z
           BLE    L2B59                                                 * 2B4C 2F 0B          /.
           LEAX   >L31AD,PC                                             * 2B4E 30 8D 06 5B    0..[
           PSHS   X                                                     * 2B52 34 10          4.
           LBSR   L39FC                                                 * 2B54 17 0E A5       ..%
           LEAS   2,S                                                   * 2B57 32 62          2b
L2B59      LEAX   >L31AF,PC                                             * 2B59 30 8D 06 52    0..R
           PSHS   X                                                     * 2B5D 34 10          4.
           LBSR   L39FC                                                 * 2B5F 17 0E 9A       ...
           PULS   PC,U,X                                                * 2B62 35 D0          5P
L2B64      PSHS   U                                                     * 2B64 34 40          4@
           LDU    4,S                                                   * 2B66 EE 64          nd
           LDD    >Y03FA,Y                                              * 2B68 EC A9 03 FA    l).z
           BLE    L2B79                                                 * 2B6C 2F 0B          /.
           LEAX   >L31B1,PC                                             * 2B6E 30 8D 06 3F    0..?
           PSHS   X                                                     * 2B72 34 10          4.
           LBSR   L39FC                                                 * 2B74 17 0E 85       ...
           LEAS   2,S                                                   * 2B77 32 62          2b
L2B79      LDD    2,U                                                   * 2B79 EC 42          lB
           PSHS   D                                                     * 2B7B 34 06          4.
           LDB    1,U                                                   * 2B7D E6 41          fA
           CLRA                                                         * 2B7F 4F             O
           PSHS   D                                                     * 2B80 34 06          4.
           LDB    ,U                                                    * 2B82 E6 C4          fD
           CLRA                                                         * 2B84 4F             O
           PSHS   D                                                     * 2B85 34 06          4.
           PSHS   U                                                     * 2B87 34 40          4@
           LDD    #10                                                   * 2B89 CC 00 0A       L..
           ADDD   ,S++                                                  * 2B8C E3 E1          ca
           PSHS   D                                                     * 2B8E 34 06          4.
           LEAX   >L31B5,PC                                             * 2B90 30 8D 06 21    0..!
           PSHS   X                                                     * 2B94 34 10          4.
           LBSR   L39FC                                                 * 2B96 17 0E 63       ..c
           LEAS   10,S                                                  * 2B99 32 6A          2j
           LDD    >Y03FA,Y                                              * 2B9B EC A9 03 FA    l).z
           ADDD   #25                                                   * 2B9F C3 00 19       C..
           STD    >Y03FA,Y                                              * 2BA2 ED A9 03 FA    m).z
           CMPD   <U0005                                                * 2BA6 10 93 05       ...
           BGT    L2BAF                                                 * 2BA9 2E 04          ..
           LDB    <U00C5                                                * 2BAB D6 C5          VE
           BEQ    L2BC0                                                 * 2BAD 27 11          '.
L2BAF      LEAX   >L31CB,PC                                             * 2BAF 30 8D 06 18    0...
           PSHS   X                                                     * 2BB3 34 10          4.
           LBSR   L39FC                                                 * 2BB5 17 0E 44       ..D
           LEAS   2,S                                                   * 2BB8 32 62          2b
           CLRA                                                         * 2BBA 4F             O
           CLRB                                                         * 2BBB 5F             _
           STD    >Y03FA,Y                                              * 2BBC ED A9 03 FA    m).z
L2BC0      PULS   PC,U                                                  * 2BC0 35 C0          5@
L2BC2      PSHS   U                                                     * 2BC2 34 40          4@
           LEAS   -16,S                                                 * 2BC4 32 70          2p
           LDB    [>U0062,Y]                                            * 2BC6 E6 B9 00 62    f9.b
           LBEQ   L2C7A                                                 * 2BCA 10 27 00 AC    .'.,
           LEAS   -2,S                                                  * 2BCE 32 7E          2~
           LEAU   2,S                                                   * 2BD0 33 62          3b
           LDD    #16                                                   * 2BD2 CC 00 10       L..
           STD    ,S                                                    * 2BD5 ED E4          md
           BRA    L2BE3                                                 * 2BD7 20 0A           .
L2BD9      LDX    <U0062                                                * 2BD9 9E 62          .b
           LEAX   1,X                                                   * 2BDB 30 01          0.
           STX    <U0062                                                * 2BDD 9F 62          .b
           LDB    -1,X                                                  * 2BDF E6 1F          f.
           STB    ,U+                                                   * 2BE1 E7 C0          g@
L2BE3      LDD    ,S                                                    * 2BE3 EC E4          ld
           ADDD   #-1                                                   * 2BE5 C3 FF FF       C..
           STD    ,S                                                    * 2BE8 ED E4          md
           SUBD   #-1                                                   * 2BEA 83 FF FF       ...
           BEQ    L2BFD                                                 * 2BED 27 0E          '.
           LDB    [>U0062,Y]                                            * 2BEF E6 B9 00 62    f9.b
           BEQ    L2BFD                                                 * 2BF3 27 08          '.
           LDB    [>U0062,Y]                                            * 2BF5 E6 B9 00 62    f9.b
           CMPB   #44                                                   * 2BF9 C1 2C          A,
           BNE    L2BD9                                                 * 2BFB 26 DC          &\
L2BFD      CLRA                                                         * 2BFD 4F             O
           CLRB                                                         * 2BFE 5F             _
           STB    ,U                                                    * 2BFF E7 C4          gD
           LBSR   L199A                                                 * 2C01 17 ED 96       .m.
           STD    -2,S                                                  * 2C04 ED 7E          m~
           LBEQ   L2C76                                                 * 2C06 10 27 00 6C    .'.l
           LBSR   L2426                                                 * 2C0A 17 F8 19       .x.
           LBSR   L2D99                                                 * 2C0D 17 01 89       ...
           LDD    <U0031                                                * 2C10 DC 31          \1
           PSHS   D                                                     * 2C12 34 06          4.
           LDD    #8                                                    * 2C14 CC 00 08       L..
           LBSR   L47AB                                                 * 2C17 17 1B 91       ...
           STD    >Y03DC,Y                                              * 2C1A ED A9 03 DC    m).\
           LBSR   L199A                                                 * 2C1E 17 ED 79       .my
           STD    -2,S                                                  * 2C21 ED 7E          m~
           BEQ    L2C76                                                 * 2C23 27 51          'Q
           LBSR   L2426                                                 * 2C25 17 F7 FE       .w~
           LBSR   L2D99                                                 * 2C28 17 01 6E       ..n
           LDD    >Y03DC,Y                                              * 2C2B EC A9 03 DC    l).\
           PSHS   D                                                     * 2C2F 34 06          4.
           LDD    <U0031                                                * 2C31 DC 31          \1
           CLRA                                                         * 2C33 4F             O
           ORA    ,S+                                                   * 2C34 AA E0          *`
           ORB    ,S+                                                   * 2C36 EA E0          j`
           STD    >Y03DC,Y                                              * 2C38 ED A9 03 DC    m).\
           LBSR   L199A                                                 * 2C3C 17 ED 5B       .m[
           STD    -2,S                                                  * 2C3F ED 7E          m~
           BEQ    L2C76                                                 * 2C41 27 33          '3
           LBSR   L2426                                                 * 2C43 17 F7 E0       .w`
           LBSR   L2D99                                                 * 2C46 17 01 50       ..P
           LDD    <U0031                                                * 2C49 DC 31          \1
           CLRA                                                         * 2C4B 4F             O
           STB    >Y03E4,Y                                              * 2C4C E7 A9 03 E4    g).d
           LBSR   L199A                                                 * 2C50 17 ED 47       .mG
           STD    -2,S                                                  * 2C53 ED 7E          m~
           BEQ    L2C76                                                 * 2C55 27 1F          '.
           LBSR   L2426                                                 * 2C57 17 F7 CC       .wL
           LBSR   L2D99                                                 * 2C5A 17 01 3C       ..<
           LDD    <U0031                                                * 2C5D DC 31          \1
           STD    >Y03F0,Y                                              * 2C5F ED A9 03 F0    m).p
           LBSR   L199A                                                 * 2C63 17 ED 34       .m4
           STD    -2,S                                                  * 2C66 ED 7E          m~
           BEQ    L2C76                                                 * 2C68 27 0C          '.
           LBSR   L2426                                                 * 2C6A 17 F7 B9       .w9
           LBSR   L2D99                                                 * 2C6D 17 01 29       ..)
           LDD    <U0031                                                * 2C70 DC 31          \1
           STD    >Y03F2,Y                                              * 2C72 ED A9 03 F2    m).r
L2C76      LEAS   2,S                                                   * 2C76 32 62          2b
           BRA    L2C89                                                 * 2C78 20 0F           .
L2C7A      LEAX   >L31CD,PC                                             * 2C7A 30 8D 05 4F    0..O
           PSHS   X                                                     * 2C7E 34 10          4.
           LEAX   2,S                                                   * 2C80 30 62          0b
           PSHS   X                                                     * 2C82 34 10          4.
           LBSR   L4514                                                 * 2C84 17 18 8D       ...
           LEAS   4,S                                                   * 2C87 32 64          2d
L2C89      LEAX   >Y07F9,Y                                              * 2C89 30 A9 07 F9    0).y
           PSHS   X                                                     * 2C8D 34 10          4.
           LBSR   L49FA                                                 * 2C8F 17 1D 68       ..h
           LEAS   2,S                                                   * 2C92 32 62          2b
           LDD    #5                                                    * 2C94 CC 00 05       L..
           PSHS   D                                                     * 2C97 34 06          4.
           LEAX   >Y07F9,Y                                              * 2C99 30 A9 07 F9    0).y
           PSHS   X                                                     * 2C9D 34 10          4.
           LEAX   >Y03DF,Y                                              * 2C9F 30 A9 03 DF    0)._
           PSHS   X                                                     * 2CA3 34 10          4.
           LBSR   L458A                                                 * 2CA5 17 18 E2       ..b
           LEAS   6,S                                                   * 2CA8 32 66          2f
           LDD    <U0023                                                * 2CAA DC 23          \#
           STB    >Y03DE,Y                                              * 2CAC E7 A9 03 DE    g).^
           LDD    <U0041                                                * 2CB0 DC 41          \A
           STD    >Y03E6,Y                                              * 2CB2 ED A9 03 E6    m).f
           LDD    <U0043                                                * 2CB6 DC 43          \C
           STD    >Y03E8,Y                                              * 2CB8 ED A9 03 E8    m).h
           LDD    <U0045                                                * 2CBC DC 45          \E
           STD    >Y03EA,Y                                              * 2CBE ED A9 03 EA    m).j
           LDD    <U0047                                                * 2CC2 DC 47          \G
           STD    >Y03EC,Y                                              * 2CC4 ED A9 03 EC    m).l
           LDD    <U004D                                                * 2CC8 DC 4D          \M
           STD    >Y03EE,Y                                              * 2CCA ED A9 03 EE    m).n
           LDB    <U005B                                                * 2CCE D6 5B          V[
           LBEQ   L2D94                                                 * 2CD0 10 27 00 C0    .'.@
           LDD    <U0017                                                * 2CD4 DC 17          \.
           LBEQ   L2D94                                                 * 2CD6 10 27 00 BA    .'.:
           LEAX   >Y07E9,Y                                              * 2CDA 30 A9 07 E9    0).i
           PSHS   X                                                     * 2CDE 34 10          4.
           LDD    <U0017                                                * 2CE0 DC 17          \.
           PSHS   D                                                     * 2CE2 34 06          4.
           LBSR   L4059                                                 * 2CE4 17 13 72       ..r
           LEAS   2,S                                                   * 2CE7 32 62          2b
           LBSR   L4636                                                 * 2CE9 17 19 4A       ..J
           LDD    <U0017                                                * 2CEC DC 17          \.
           PSHS   D                                                     * 2CEE 34 06          4.
           LDD    #1                                                    * 2CF0 CC 00 01       L..
           PSHS   D                                                     * 2CF3 34 06          4.
           LDD    #28                                                   * 2CF5 CC 00 1C       L..
           PSHS   D                                                     * 2CF8 34 06          4.
           LEAX   >Y03D8,Y                                              * 2CFA 30 A9 03 D8    0).X
           PSHS   X                                                     * 2CFE 34 10          4.
           LBSR   L39B2                                                 * 2D00 17 0C AF       ../
           LEAS   8,S                                                   * 2D03 32 68          2h
           LDD    <U0017                                                * 2D05 DC 17          \.
           PSHS   D                                                     * 2D07 34 06          4.
           LEAX   2,S                                                   * 2D09 30 62          0b
           PSHS   X                                                     * 2D0B 34 10          4.
           LBSR   L3992                                                 * 2D0D 17 0C 82       ...
           LEAS   4,S                                                   * 2D10 32 64          2d
           LDD    <U0017                                                * 2D12 DC 17          \.
           PSHS   D                                                     * 2D14 34 06          4.
           CLRA                                                         * 2D16 4F             O
           CLRB                                                         * 2D17 5F             _
           PSHS   D                                                     * 2D18 34 06          4.
           LBSR   L40C2                                                 * 2D1A 17 13 A5       ..%
           LEAS   4,S                                                   * 2D1D 32 64          2d
           LDD    <U0017                                                * 2D1F DC 17          \.
           PSHS   D                                                     * 2D21 34 06          4.
           LDD    #1                                                    * 2D23 CC 00 01       L..
           PSHS   D                                                     * 2D26 34 06          4.
           LDD    #2                                                    * 2D28 CC 00 02       L..
           PSHS   D                                                     * 2D2B 34 06          4.
           LEAX   >U0055,Y                                              * 2D2D 30 A9 00 55    0).U
           PSHS   X                                                     * 2D31 34 10          4.
           LBSR   L39B2                                                 * 2D33 17 0C 7C       ..|
           LEAS   8,S                                                   * 2D36 32 68          2h
           LDD    <U0055                                                * 2D38 DC 55          \U
           BEQ    L2D47                                                 * 2D3A 27 0B          '.
           LEAX   >L2FC4,PC                                             * 2D3C 30 8D 02 84    0...
           PSHS   X                                                     * 2D40 34 10          4.
           LBSR   L2EF2                                                 * 2D42 17 01 AD       ..-
           LEAS   2,S                                                   * 2D45 32 62          2b
L2D47      LEAX   >Y07F5,Y                                              * 2D47 30 A9 07 F5    0).u
           PSHS   X                                                     * 2D4B 34 10          4.
           LEAX   >Y07F1,Y                                              * 2D4D 30 A9 07 F1    0).q
           PSHS   X                                                     * 2D51 34 10          4.
           LEAX   >Y07ED,Y                                              * 2D53 30 A9 07 ED    0).m
           PSHS   X                                                     * 2D57 34 10          4.
           LEAX   >Y03D4,Y                                              * 2D59 30 A9 03 D4    0).T
           PSHS   X                                                     * 2D5D 34 10          4.
           LDD    <U0017                                                * 2D5F DC 17          \.
           PSHS   D                                                     * 2D61 34 06          4.
           LBSR   L4059                                                 * 2D63 17 12 F3       ..s
           LEAS   2,S                                                   * 2D66 32 62          2b
           LBSR   L4636                                                 * 2D68 17 18 CB       ..K
           LBSR   L4636                                                 * 2D6B 17 18 C8       ..H
           LDD    2,X                                                   * 2D6E EC 02          l.
           PSHS   D                                                     * 2D70 34 06          4.
           LDD    ,X                                                    * 2D72 EC 84          l.
           PSHS   D                                                     * 2D74 34 06          4.
           LDD    <U004D                                                * 2D76 DC 4D          \M
           LBSR   L462B                                                 * 2D78 17 18 B0       ..0
           LBSR   L45A8                                                 * 2D7B 17 18 2A       ..*
           LBSR   L4636                                                 * 2D7E 17 18 B5       ..5
           LDD    2,X                                                   * 2D81 EC 02          l.
           PSHS   D                                                     * 2D83 34 06          4.
           LDD    ,X                                                    * 2D85 EC 84          l.
           PSHS   D                                                     * 2D87 34 06          4.
           LDD    <U0047                                                * 2D89 DC 47          \G
           LBSR   L462B                                                 * 2D8B 17 18 9D       ...
           LBSR   L45A8                                                 * 2D8E 17 18 17       ...
           LBSR   L4636                                                 * 2D91 17 18 A2       .."
L2D94      LEAS   <$10,S                                                * 2D94 32 E8 10       2h.
           PULS   PC,U                                                  * 2D97 35 C0          5@
L2D99      PSHS   U                                                     * 2D99 34 40          4@
           LDB    <U005B                                                * 2D9B D6 5B          V[
           LBEQ   L2FC2                                                 * 2D9D 10 27 02 21    .'.!
           LDD    <U00BD                                                * 2DA1 DC BD          \=
           LBEQ   L2FC2                                                 * 2DA3 10 27 02 1B    .'..
           LEAX   >L31D5,PC                                             * 2DA7 30 8D 04 2A    0..*
           PSHS   X                                                     * 2DAB 34 10          4.
           LBSR   L074E                                                 * 2DAD 17 D9 9E       .Y.
           LBRA   L2FC0                                                 * 2DB0 16 02 0D       ...
L2DB3      PSHS   U,D                                                   * 2DB3 34 46          4F
           LEAX   >Y03D8,Y                                              * 2DB5 30 A9 03 D8    0).X
           TFR    X,D                                                   * 2DB9 1F 10          ..
           LEAX   >Y03DE,Y                                              * 2DBB 30 A9 03 DE    0).^
           NEGA                                                         * 2DBF 40             @
           NEGB                                                         * 2DC0 50             P
           SBCA   #0                                                    * 2DC1 82 00          ..
           LEAX   D,X                                                   * 2DC3 30 8B          0.
           STX    ,S                                                    * 2DC5 AF E4          /d
           LDD    <U0017                                                * 2DC7 DC 17          \.
           LBEQ   L2E39                                                 * 2DC9 10 27 00 6C    .'.l
           LDB    <U00C6                                                * 2DCD D6 C6          VF
           LBLE   L2E39                                                 * 2DCF 10 2F 00 66    ./.f
           CLRA                                                         * 2DD3 4F             O
           CLRB                                                         * 2DD4 5F             _
           PSHS   D                                                     * 2DD5 34 06          4.
           LEAX   >Y07E9,Y                                              * 2DD7 30 A9 07 E9    0).i
           LDD    2,X                                                   * 2DDB EC 02          l.
           PSHS   D                                                     * 2DDD 34 06          4.
           LDD    ,X                                                    * 2DDF EC 84          l.
           PSHS   D                                                     * 2DE1 34 06          4.
           LDD    6,S                                                   * 2DE3 EC 66          lf
           LBSR   L462B                                                 * 2DE5 17 18 43       ..C
           LBSR   L45A8                                                 * 2DE8 17 17 BD       ..=
           LDD    2,X                                                   * 2DEB EC 02          l.
           PSHS   D                                                     * 2DED 34 06          4.
           LDD    ,X                                                    * 2DEF EC 84          l.
           PSHS   D                                                     * 2DF1 34 06          4.
           LDD    <U0017                                                * 2DF3 DC 17          \.
           PSHS   D                                                     * 2DF5 34 06          4.
           LBSR   L3F02                                                 * 2DF7 17 11 08       ...
           LEAS   8,S                                                   * 2DFA 32 68          2h
           LDD    <U0017                                                * 2DFC DC 17          \.
           PSHS   D                                                     * 2DFE 34 06          4.
           LDD    <U0023                                                * 2E00 DC 23          \#
           PSHS   D                                                     * 2E02 34 06          4.
           LBSR   L40C2                                                 * 2E04 17 12 BB       ..;
           LEAS   4,S                                                   * 2E07 32 64          2d
           LEAX   >Y03D4,Y                                              * 2E09 30 A9 03 D4    0).T
           PSHS   X                                                     * 2E0D 34 10          4.
           LEAX   >Y07E9,Y                                              * 2E0F 30 A9 07 E9    0).i
           LDD    2,X                                                   * 2E13 EC 02          l.
           PSHS   D                                                     * 2E15 34 06          4.
           LDD    ,X                                                    * 2E17 EC 84          l.
           PSHS   D                                                     * 2E19 34 06          4.
           LDD    6,S                                                   * 2E1B EC 66          lf
           LBSR   L462B                                                 * 2E1D 17 18 0B       ...
           LBSR   L45A8                                                 * 2E20 17 17 85       ...
           LDD    2,X                                                   * 2E23 EC 02          l.
           PSHS   D                                                     * 2E25 34 06          4.
           LDD    ,X                                                    * 2E27 EC 84          l.
           PSHS   D                                                     * 2E29 34 06          4.
           BSR    L2E31                                                 * 2E2B 8D 04          ..
           NEG    <U0000                                                * 2E2D 00 00          ..
           NEG    <U0001                                                * 2E2F 00 01          ..
L2E31      PULS   X                                                     * 2E31 35 10          5.
           LBSR   L45A8                                                 * 2E33 17 17 72       ..r
           LBSR   L4636                                                 * 2E36 17 17 FD       ..}
L2E39      PULS   PC,U,X                                                * 2E39 35 D0          5P
L2E3B      PSHS   U                                                     * 2E3B 34 40          4@
           LDD    <U004B                                                * 2E3D DC 4B          \K
           LBEQ   L2EF0                                                 * 2E3F 10 27 00 AD    .'.-
           LDD    6,S                                                   * 2E43 EC 66          lf
           LBEQ   L2EF0                                                 * 2E45 10 27 00 A7    .'.'
           LDD    [>U004B,Y]                                            * 2E49 EC B9 00 4B    l9.K
           ADDD   6,S                                                   * 2E4D E3 66          cf
           STD    [>U004B,Y]                                            * 2E4F ED B9 00 4B    m9.K
           LDB    <U005B                                                * 2E53 D6 5B          V[
           LBEQ   L2EF0                                                 * 2E55 10 27 00 97    .'..
           LDB    <U005E                                                * 2E59 D6 5E          V^
           CLRA                                                         * 2E5B 4F             O
           ANDB   #2                                                    * 2E5C C4 02          D.
           LBEQ   L2EF0                                                 * 2E5E 10 27 00 8E    .'..
           LDD    <U0017                                                * 2E62 DC 17          \.
           LBEQ   L2EF0                                                 * 2E64 10 27 00 88    .'..
           LDB    <U00C6                                                * 2E68 D6 C6          VF
           LBLE   L2EF0                                                 * 2E6A 10 2F 00 82    ./..
           LDB    <U005D                                                * 2E6E D6 5D          V]
           CLRA                                                         * 2E70 4F             O
           ANDB   #4                                                    * 2E71 C4 04          D.
           BEQ    L2E7B                                                 * 2E73 27 06          '.
           LEAX   >Y07ED,Y                                              * 2E75 30 A9 07 ED    0).m
           BRA    L2E8C                                                 * 2E79 20 11           .
L2E7B      LDB    <U005D                                                * 2E7B D6 5D          V]
           CLRA                                                         * 2E7D 4F             O
           ANDB   #2                                                    * 2E7E C4 02          D.
           BEQ    L2E88                                                 * 2E80 27 06          '.
           LEAX   >Y07F1,Y                                              * 2E82 30 A9 07 F1    0).q
           BRA    L2E8C                                                 * 2E86 20 04           .
L2E88      LEAX   >Y07F5,Y                                              * 2E88 30 A9 07 F5    0).u
L2E8C      TFR    X,D                                                   * 2E8C 1F 10          ..
           TFR    D,U                                                   * 2E8E 1F 03          ..
           LEAX   >Y03D4,Y                                              * 2E90 30 A9 03 D4    0).T
           LDD    2,X                                                   * 2E94 EC 02          l.
           PSHS   D                                                     * 2E96 34 06          4.
           LDD    ,X                                                    * 2E98 EC 84          l.
           PSHS   D                                                     * 2E9A 34 06          4.
           LEAX   ,U                                                    * 2E9C 30 C4          0D
           LBSR   L45D2                                                 * 2E9E 17 17 31       ..1
           BEQ    L2EBA                                                 * 2EA1 27 17          '.
           CLRA                                                         * 2EA3 4F             O
           CLRB                                                         * 2EA4 5F             _
           PSHS   D                                                     * 2EA5 34 06          4.
           LEAX   ,U                                                    * 2EA7 30 C4          0D
           LDD    2,X                                                   * 2EA9 EC 02          l.
           PSHS   D                                                     * 2EAB 34 06          4.
           LDD    ,X                                                    * 2EAD EC 84          l.
           PSHS   D                                                     * 2EAF 34 06          4.
           LDD    <U0017                                                * 2EB1 DC 17          \.
           PSHS   D                                                     * 2EB3 34 06          4.
           LBSR   L3F02                                                 * 2EB5 17 10 4A       ..J
           LEAS   8,S                                                   * 2EB8 32 68          2h
L2EBA      LDD    <U0017                                                * 2EBA DC 17          \.
           PSHS   D                                                     * 2EBC 34 06          4.
           LDD    #1                                                    * 2EBE CC 00 01       L..
           PSHS   D                                                     * 2EC1 34 06          4.
           LDD    10,S                                                  * 2EC3 EC 6A          lj
           PSHS   D                                                     * 2EC5 34 06          4.
           LDD    10,S                                                  * 2EC7 EC 6A          lj
           PSHS   D                                                     * 2EC9 34 06          4.
           LBSR   L39B2                                                 * 2ECB 17 0A E4       ..d
           LEAS   8,S                                                   * 2ECE 32 68          2h
           LEAX   >Y03D4,Y                                              * 2ED0 30 A9 03 D4    0).T
           PSHS   X                                                     * 2ED4 34 10          4.
           LEAX   ,U                                                    * 2ED6 30 C4          0D
           PSHS   X                                                     * 2ED8 34 10          4.
           LDD    2,X                                                   * 2EDA EC 02          l.
           PSHS   D                                                     * 2EDC 34 06          4.
           LDD    ,X                                                    * 2EDE EC 84          l.
           PSHS   D                                                     * 2EE0 34 06          4.
           LDD    14,S                                                  * 2EE2 EC 6E          ln
           LBSR   L461D                                                 * 2EE4 17 17 36       ..6
           LBSR   L45A8                                                 * 2EE7 17 16 BE       ..>
           LBSR   L4636                                                 * 2EEA 17 17 49       ..I
           LBSR   L4636                                                 * 2EED 17 17 46       ..F
L2EF0      PULS   PC,U                                                  * 2EF0 35 C0          5@
L2EF2      PSHS   U,D                                                   * 2EF2 34 46          4F
           CLRA                                                         * 2EF4 4F             O
           CLRB                                                         * 2EF5 5F             _
           BRA    L2F29                                                 * 2EF6 20 31           1
L2EF8      LDD    ,S                                                    * 2EF8 EC E4          ld
           ASLB                                                         * 2EFA 58             X
           ROLA                                                         * 2EFB 49             I
           LEAX   >Y06C5,Y                                              * 2EFC 30 A9 06 C5    0).E
           LEAX   D,X                                                   * 2F00 30 8B          0.
           LDU    ,X                                                    * 2F02 EE 84          n.
           STU    -2,S                                                  * 2F04 EF 7E          o~
           BEQ    L2F24                                                 * 2F06 27 1C          '.
           BRA    L2F0C                                                 * 2F08 20 02           .
L2F0A      LDU    4,U                                                   * 2F0A EE 44          nD
L2F0C      LDD    4,U                                                   * 2F0C EC 44          lD
           BNE    L2F0A                                                 * 2F0E 26 FA          &z
L2F10      PSHS   U                                                     * 2F10 34 40          4@
           JSR    [<$08,S]                                              * 2F12 AD F8 08       -x.
           LEAS   2,S                                                   * 2F15 32 62          2b
           PSHS   U                                                     * 2F17 34 40          4@
           LBSR   L2237                                                 * 2F19 17 F3 1B       .s.
           LEAS   2,S                                                   * 2F1C 32 62          2b
           TFR    D,U                                                   * 2F1E 1F 03          ..
           STU    -2,S                                                  * 2F20 EF 7E          o~
           BNE    L2F10                                                 * 2F22 26 EC          &l
L2F24      LDD    ,S                                                    * 2F24 EC E4          ld
           ADDD   #1                                                    * 2F26 C3 00 01       C..
L2F29      STD    ,S                                                    * 2F29 ED E4          md
           LDD    ,S                                                    * 2F2B EC E4          ld
           CMPD   #64                                                   * 2F2D 10 83 00 40    ...@
           BLT    L2EF8                                                 * 2F31 2D C5          -E
           PULS   PC,U,X                                                * 2F33 35 D0          5P
L2F35      PSHS   U                                                     * 2F35 34 40          4@
           LDD    <U0017                                                * 2F37 DC 17          \.
           LBEQ   L2FC2                                                 * 2F39 10 27 00 85    .'..
           CLRA                                                         * 2F3D 4F             O
           CLRB                                                         * 2F3E 5F             _
           PSHS   D                                                     * 2F3F 34 06          4.
           LEAX   >Y07F5,Y                                              * 2F41 30 A9 07 F5    0).u
           LDD    2,X                                                   * 2F45 EC 02          l.
           PSHS   D                                                     * 2F47 34 06          4.
           LDD    ,X                                                    * 2F49 EC 84          l.
           PSHS   D                                                     * 2F4B 34 06          4.
           LDD    <U0017                                                * 2F4D DC 17          \.
           PSHS   D                                                     * 2F4F 34 06          4.
           LBSR   L3F02                                                 * 2F51 17 0F AE       ...
           LEAS   8,S                                                   * 2F54 32 68          2h
           LDD    <U0017                                                * 2F56 DC 17          \.
           PSHS   D                                                     * 2F58 34 06          4.
           LDD    #1                                                    * 2F5A CC 00 01       L..
           PSHS   D                                                     * 2F5D 34 06          4.
           LDD    #2                                                    * 2F5F CC 00 02       L..
           PSHS   D                                                     * 2F62 34 06          4.
           LEAX   >Y0057,Y                                              * 2F64 30 A9 00 57    0).W
           PSHS   X                                                     * 2F68 34 10          4.
           LBSR   L39B2                                                 * 2F6A 17 0A 45       ..E
           LEAS   8,S                                                   * 2F6D 32 68          2h
           LDD    <Y0057                                                * 2F6F DC 57          \W
           BEQ    L2F7E                                                 * 2F71 27 0B          '.
           LEAX   >L3017,PC                                             * 2F73 30 8D 00 A0    0..
           PSHS   X                                                     * 2F77 34 10          4.
           LBSR   L2EF2                                                 * 2F79 17 FF 76       ..v
           LEAS   2,S                                                   * 2F7C 32 62          2b
L2F7E      LDD    <U0017                                                * 2F7E DC 17          \.
           PSHS   D                                                     * 2F80 34 06          4.
           LDD    #1                                                    * 2F82 CC 00 01       L..
           PSHS   D                                                     * 2F85 34 06          4.
           LDD    #2                                                    * 2F87 CC 00 02       L..
           PSHS   D                                                     * 2F8A 34 06          4.
           LEAX   >Y0059,Y                                              * 2F8C 30 A9 00 59    0).Y
           PSHS   X                                                     * 2F90 34 10          4.
           LBSR   L39B2                                                 * 2F92 17 0A 1D       ...
           LEAS   8,S                                                   * 2F95 32 68          2h
           LDD    <Y0059                                                * 2F97 DC 59          \Y
           BEQ    L2FC2                                                 * 2F99 27 27          ''
           LDD    <U0084                                                * 2F9B DC 84          \.
           BEQ    L2FA8                                                 * 2F9D 27 09          '.
           LDD    <U0084                                                * 2F9F DC 84          \.
           PSHS   D                                                     * 2FA1 34 06          4.
           LBSR   L30BA                                                 * 2FA3 17 01 14       ...
           LEAS   2,S                                                   * 2FA6 32 62          2b
L2FA8      LDD    <U0098                                                * 2FA8 DC 98          \.
           BEQ    L2FB5                                                 * 2FAA 27 09          '.
           LDD    <U0098                                                * 2FAC DC 98          \.
           PSHS   D                                                     * 2FAE 34 06          4.
           LBSR   L30BA                                                 * 2FB0 17 01 07       ...
           LEAS   2,S                                                   * 2FB3 32 62          2b
L2FB5      LDD    <U00AC                                                * 2FB5 DC AC          \,
           BEQ    L2FC2                                                 * 2FB7 27 09          '.
           LDD    <U00AC                                                * 2FB9 DC AC          \,
           PSHS   D                                                     * 2FBB 34 06          4.
           LBSR   L30BA                                                 * 2FBD 17 00 FA       ..z
L2FC0      LEAS   2,S                                                   * 2FC0 32 62          2b
L2FC2      PULS   PC,U                                                  * 2FC2 35 C0          5@
L2FC4      PSHS   U                                                     * 2FC4 34 40          4@
           LDU    4,S                                                   * 2FC6 EE 64          nd
           LEAS   -3,S                                                  * 2FC8 32 7D          2}
           LDB    1,U                                                   * 2FCA E6 41          fA
           CLRA                                                         * 2FCC 4F             O
           ANDB   #198                                                  * 2FCD C4 C6          DF
           CMPD   #134                                                  * 2FCF 10 83 00 86    ....
           BNE    L3013                                                 * 2FD3 26 3E          &>
           LDD    <U0017                                                * 2FD5 DC 17          \.
           PSHS   D                                                     * 2FD7 34 06          4.
           PSHS   U                                                     * 2FD9 34 40          4@
           LDD    #10                                                   * 2FDB CC 00 0A       L..
           ADDD   ,S++                                                  * 2FDE E3 E1          ca
           PSHS   D                                                     * 2FE0 34 06          4.
           LBSR   L3992                                                 * 2FE2 17 09 AD       ..-
           LEAS   4,S                                                   * 2FE5 32 64          2d
           LDD    <U0017                                                * 2FE7 DC 17          \.
           PSHS   D                                                     * 2FE9 34 06          4.
           CLRA                                                         * 2FEB 4F             O
           CLRB                                                         * 2FEC 5F             _
           PSHS   D                                                     * 2FED 34 06          4.
           LBSR   L40C2                                                 * 2FEF 17 10 D0       ..P
           LEAS   4,S                                                   * 2FF2 32 64          2d
           LDB    ,U                                                    * 2FF4 E6 C4          fD
           STB    ,S                                                    * 2FF6 E7 E4          gd
           LDD    2,U                                                   * 2FF8 EC 42          lB
           STD    1,S                                                   * 2FFA ED 61          ma
           LDD    <U0017                                                * 2FFC DC 17          \.
           PSHS   D                                                     * 2FFE 34 06          4.
           LDD    #1                                                    * 3000 CC 00 01       L..
           PSHS   D                                                     * 3003 34 06          4.
           LDD    #3                                                    * 3005 CC 00 03       L..
           PSHS   D                                                     * 3008 34 06          4.
           LEAX   6,S                                                   * 300A 30 66          0f
           PSHS   X                                                     * 300C 34 10          4.
           LBSR   L39B2                                                 * 300E 17 09 A1       ..!
           LEAS   8,S                                                   * 3011 32 68          2h
L3013      LEAS   3,S                                                   * 3013 32 63          2c
           PULS   PC,U                                                  * 3015 35 C0          5@
L3017      PSHS   U                                                     * 3017 34 40          4@
           LDU    4,S                                                   * 3019 EE 64          nd
           LEAS   -2,S                                                  * 301B 32 7E          2~
           LDB    1,U                                                   * 301D E6 41          fA
           CLRA                                                         * 301F 4F             O
           ANDB   #66                                                   * 3020 C4 42          DB
           LBNE   L3089                                                 * 3022 10 26 00 63    .&.c
           LDD    8,U                                                   * 3026 EC 48          lH
           LBEQ   L3089                                                 * 3028 10 27 00 5D    .'.]
           LDB    ,U                                                    * 302C E6 C4          fD
           CLRA                                                         * 302E 4F             O
           ANDB   #7                                                    * 302F C4 07          D.
           STD    ,S                                                    * 3031 ED E4          md
           CMPD   #6                                                    * 3033 10 83 00 06    ....
           LBEQ   L3089                                                 * 3037 10 27 00 4E    .'.N
           LDD    ,S                                                    * 303B EC E4          ld
           CMPD   #5                                                    * 303D 10 83 00 05    ....
           BEQ    L3089                                                 * 3041 27 46          'F
           LDD    <U0017                                                * 3043 DC 17          \.
           PSHS   D                                                     * 3045 34 06          4.
           PSHS   U                                                     * 3047 34 40          4@
           LDD    #10                                                   * 3049 CC 00 0A       L..
           ADDD   ,S++                                                  * 304C E3 E1          ca
           PSHS   D                                                     * 304E 34 06          4.
           LBSR   L3992                                                 * 3050 17 09 3F       ..?
           LEAS   4,S                                                   * 3053 32 64          2d
           LDD    <U0017                                                * 3055 DC 17          \.
           PSHS   D                                                     * 3057 34 06          4.
           CLRA                                                         * 3059 4F             O
           CLRB                                                         * 305A 5F             _
           PSHS   D                                                     * 305B 34 06          4.
           LBSR   L40C2                                                 * 305D 17 10 62       ..b
           LEAS   4,S                                                   * 3060 32 64          2d
           PSHS   U                                                     * 3062 34 40          4@
           BSR    L308B                                                 * 3064 8D 25          .%
           LEAS   2,S                                                   * 3066 32 62          2b
           STD    ,S                                                    * 3068 ED E4          md
           LDD    <U0017                                                * 306A DC 17          \.
           PSHS   D                                                     * 306C 34 06          4.
           LDD    #1                                                    * 306E CC 00 01       L..
           PSHS   D                                                     * 3071 34 06          4.
           LDD    #2                                                    * 3073 CC 00 02       L..
           PSHS   D                                                     * 3076 34 06          4.
           LEAX   6,S                                                   * 3078 30 66          0f
           PSHS   X                                                     * 307A 34 10          4.
           LBSR   L39B2                                                 * 307C 17 09 33       ..3
           LEAS   8,S                                                   * 307F 32 68          2h
           LDD    8,U                                                   * 3081 EC 48          lH
           PSHS   D                                                     * 3083 34 06          4.
           BSR    L30BA                                                 * 3085 8D 33          .3
           LEAS   2,S                                                   * 3087 32 62          2b
L3089      PULS   PC,U,X                                                * 3089 35 D0          5P
L308B      PSHS   U,X,D                                                 * 308B 34 56          4V
           CLRA                                                         * 308D 4F             O
           CLRB                                                         * 308E 5F             _
           STD    ,S                                                    * 308F ED E4          md
           LDX    8,S                                                   * 3091 AE 68          .h
           LDU    8,X                                                   * 3093 EE 08          n.
           CLRA                                                         * 3095 4F             O
           CLRB                                                         * 3096 5F             _
           LDX    8,S                                                   * 3097 AE 68          .h
           STD    8,X                                                   * 3099 ED 08          m.
L309B      LDD    3,U                                                   * 309B EC 43          lC
           STD    2,S                                                   * 309D ED 62          mb
           LDX    8,S                                                   * 309F AE 68          .h
           LDD    8,X                                                   * 30A1 EC 08          l.
           STD    3,U                                                   * 30A3 ED 43          mC
           LDX    8,S                                                   * 30A5 AE 68          .h
           STU    8,X                                                   * 30A7 EF 08          o.
           LDD    ,S                                                    * 30A9 EC E4          ld
           ADDD   #1                                                    * 30AB C3 00 01       C..
           STD    ,S                                                    * 30AE ED E4          md
           LDU    2,S                                                   * 30B0 EE 62          nb
           BNE    L309B                                                 * 30B2 26 E7          &g
           LDD    ,S                                                    * 30B4 EC E4          ld
           LEAS   4,S                                                   * 30B6 32 64          2d
           PULS   PC,U                                                  * 30B8 35 C0          5@
L30BA      PSHS   U                                                     * 30BA 34 40          4@
           LDU    4,S                                                   * 30BC EE 64          nd
L30BE      LDD    <U0017                                                * 30BE DC 17          \.
           PSHS   D                                                     * 30C0 34 06          4.
           LDD    #1                                                    * 30C2 CC 00 01       L..
           PSHS   D                                                     * 30C5 34 06          4.
           LDD    #3                                                    * 30C7 CC 00 03       L..
           PSHS   D                                                     * 30CA 34 06          4.
           PSHS   U                                                     * 30CC 34 40          4@
           LBSR   L39B2                                                 * 30CE 17 08 E1       ..a
           LEAS   8,S                                                   * 30D1 32 68          2h
           LDU    3,U                                                   * 30D3 EE 43          nC
           STU    -2,S                                                  * 30D5 EF 7E          o~
           BNE    L30BE                                                 * 30D7 26 E5          &e
           PULS   PC,U                                                  * 30D9 35 C0          5@
L30DB      FCC    "too many object files"                               * 30DB 74 6F 6F 20 6D 61 6E 79 20 6F 62 6A 65 63 74 20 66 69 6C 65 73 too many object files
           FCB    $00                                                   * 30F0 00             .
L30F1      FCC    "too many input files"                                * 30F1 74 6F 6F 20 6D 61 6E 79 20 69 6E 70 75 74 20 66 69 6C 65 73 too many input files
           FCB    $00                                                   * 3105 00             .
L3106      FCC    "no input file"                                       * 3106 6E 6F 20 69 6E 70 75 74 20 66 69 6C 65 no input file
           FCB    $00                                                   * 3113 00             .
L3114      FCC    "output.r"                                            * 3114 6F 75 74 70 75 74 2E 72 output.r
           FCB    $00                                                   * 311C 00             .
L311D      FCC    /"%s" - /                                             * 311D 22 25 73 22 20 2D 20 "%s" -
           FCB    $00                                                   * 3124 00             .
L3125      FCC    "can't open file"                                     * 3125 63 61 6E 27 74 20 6F 70 65 6E 20 66 69 6C 65 can't open file
           FCB    $00                                                   * 3134 00             .
L3135      FCC    "Microware OS-9 %s  %d/%02d/%02d  %02d:%02d"          * 3135 4D 69 63 72 6F 77 61 72 65 20 4F 53 2D 39 20 25 73 20 20 25 64 2F 25 30 32 64 2F 25 30 32 64 20 20 25 30 32 64 3A 25 30 32 64 Microware OS-9 %s  %d/%02d/%02d  %02d:%02d
           FCB    $00                                                   * 315F 00             .
L3160      FCC    "RMA - V1.0"                                          * 3160 52 4D 41 20 2D 20 56 31 2E 30 RMA - V1.0
           FCB    $00                                                   * 316A 00             .
L316B      FCC    "   %-20s Page %5d"                                   * 316B 20 20 20 25 2D 32 30 73 20 50 61 67 65 20 25 35 64    %-20s Page %5d
           FCB    $0D                                                   * 317C 0D             .
           FCB    $00                                                   * 317D 00             .
L317E      FCC    "%s - %s"                                             * 317E 25 73 20 2D 20 25 73 %s - %s
           FCB    $0D                                                   * 3185 0D             .
           FCB    $0D                                                   * 3186 0D             .
           FCB    $00                                                   * 3187 00             .
L3188      FCC    "Asm:"                                                * 3188 41 73 6D 3A    Asm:
           FCB    $00                                                   * 318C 00             .
L318D      FCC    "file close error"                                    * 318D 66 69 6C 65 20 63 6C 6F 73 65 20 65 72 72 6F 72 file close error
           FCB    $00                                                   * 319D 00             .
L319E      FCB    $0D                                                   * 319E 0D             .
           FCC    "Symbol Table"                                        * 319F 53 79 6D 62 6F 6C 20 54 61 62 6C 65 Symbol Table
           FCB    $0D                                                   * 31AB 0D             .
           FCB    $00                                                   * 31AC 00             .
L31AD      FCB    $0D                                                   * 31AD 0D             .
           FCB    $00                                                   * 31AE 00             .
L31AF      FCB    $0D                                                   * 31AF 0D             .
           FCB    $00                                                   * 31B0 00             .
L31B1      FCC    "  |"                                                 * 31B1 20 20 7C         |
           FCB    $00                                                   * 31B4 00             .
L31B5      FCC    "  %-9s %02x %02x %04x"                               * 31B5 20 20 25 2D 39 73 20 25 30 32 78 20 25 30 32 78 20 25 30 34 78   %-9s %02x %02x %04x
           FCB    $00                                                   * 31CA 00             .
L31CB      FCB    $0D                                                   * 31CB 0D             .
           FCB    $00                                                   * 31CC 00             .
L31CD      FCC    "program"                                             * 31CD 70 72 6F 67 72 61 6D program
           FCB    $00                                                   * 31D4 00             .
L31D5      FCC    "no external allowed"                                 * 31D5 6E 6F 20 65 78 74 65 72 6E 61 6C 20 61 6C 6C 6F 77 65 64 no external allowed
           FCB    $00                                                   * 31E8 00             .
L31E9      PSHS   U,D                                                   * 31E9 34 46          4F
           LDB    <U005B                                                * 31EB D6 5B          V[
           BEQ    L31F4                                                 * 31ED 27 05          '.
           LDD    #1                                                    * 31EF CC 00 01       L..
           PULS   PC,U,X                                                * 31F2 35 D0          5P
L31F4      LDD    <U00DA                                                * 31F4 DC DA          \Z
           BNE    L3221                                                 * 31F6 26 29          &)
           LEAX   >L3721,PC                                             * 31F8 30 8D 05 25    0..%
           PSHS   X                                                     * 31FC 34 10          4.
           LEAX   >dpsiz,Y                                              * 31FE 30 A9 00 E8    0).h
           PSHS   X                                                     * 3202 34 10          4.
           LBSR   fopen                                                 * 3204 17 07 17       ...
           LEAS   4,S                                                   * 3207 32 64          2d
           STD    <U00DA                                                * 3209 DD DA          ]Z
           STD    <U00DC                                                * 320B DD DC          ]\
           BNE    L321A                                                 * 320D 26 0B          &.
           LEAX   >L3724,PC                                             * 320F 30 8D 05 11    0...
           PSHS   X                                                     * 3213 34 10          4.
           LBSR   L078B                                                 * 3215 17 D5 73       .Us
           LEAS   2,S                                                   * 3218 32 62          2b
L321A      LDD    #512                                                  * 321A CC 02 00       L..
           LDX    <U00DA                                                * 321D 9E DA          .Z
           STD    11,X                                                  * 321F ED 0B          m.
L3221      LDD    #10                                                   * 3221 CC 00 0A       L..
           PSHS   D                                                     * 3224 34 06          4.
           LBSR   L233C                                                 * 3226 17 F1 13       .q.
           LEAS   2,S                                                   * 3229 32 62          2b
           TFR    D,U                                                   * 322B 1F 03          ..
           LDD    <U00D4                                                * 322D DC D4          \T
           STD    ,U                                                    * 322F ED C4          mD
           STU    <U00D4                                                * 3231 DF D4          _T
           LDD    <U0078                                                * 3233 DC 78          \x
           STD    2,U                                                   * 3235 ED 42          mB
           LDD    <U00DA                                                * 3237 DC DA          \Z
           STD    4,U                                                   * 3239 ED 44          mD
           LDD    #2                                                    * 323B CC 00 02       L..
           PSHS   D                                                     * 323E 34 06          4.
           CLRA                                                         * 3240 4F             O
           CLRB                                                         * 3241 5F             _
           PSHS   D                                                     * 3242 34 06          4.
           PSHS   D                                                     * 3244 34 06          4.
           LDD    <U00DA                                                * 3246 DC DA          \Z
           PSHS   D                                                     * 3248 34 06          4.
           LBSR   L3F02                                                 * 324A 17 0C B5       ..5
           LEAS   8,S                                                   * 324D 32 68          2h
           LDD    <U0078                                                * 324F DC 78          \x
           ADDD   #10                                                   * 3251 C3 00 0A       C..
           STD    ,S                                                    * 3254 ED E4          md
           BRA    L326C                                                 * 3256 20 14           .
L3258      LDD    <U00DA                                                * 3258 DC DA          \Z
           PSHS   D                                                     * 325A 34 06          4.
           LDX    2,S                                                   * 325C AE 62          .b
           LEAX   1,X                                                   * 325E 30 01          0.
           STX    2,S                                                   * 3260 AF 62          /b
           LDB    -1,X                                                  * 3262 E6 1F          f.
           SEX                                                          * 3264 1D             .
           PSHS   D                                                     * 3265 34 06          4.
           LBSR   L40C2                                                 * 3267 17 0E 58       ..X
           LEAS   4,S                                                   * 326A 32 64          2d
L326C      LDB    [,S]                                                  * 326C E6 F4          ft
           BNE    L3258                                                 * 326E 26 E8          &h
           LDD    <U00DA                                                * 3270 DC DA          \Z
           PSHS   D                                                     * 3272 34 06          4.
           CLRA                                                         * 3274 4F             O
           CLRB                                                         * 3275 5F             _
           PSHS   D                                                     * 3276 34 06          4.
           LBSR   L40C2                                                 * 3278 17 0E 47       ..G
           LEAS   4,S                                                   * 327B 32 64          2d
           LDX    <U00DA                                                * 327D 9E DA          .Z
           LDD    6,X                                                   * 327F EC 06          l.
           CLRA                                                         * 3281 4F             O
           ANDB   #32                                                   * 3282 C4 20          D
           BEQ    L3289                                                 * 3284 27 03          '.
           LBSR   L3714                                                 * 3286 17 04 8B       ...
L3289      LEAX   6,U                                                   * 3289 30 46          0F
           PSHS   X                                                     * 328B 34 10          4.
           LDD    <U00DA                                                * 328D DC DA          \Z
           PSHS   D                                                     * 328F 34 06          4.
           LBSR   L4059                                                 * 3291 17 0D C5       ..E
           LEAS   2,S                                                   * 3294 32 62          2b
           LBSR   L4636                                                 * 3296 17 13 9D       ...
           LDD    #1                                                    * 3299 CC 00 01       L..
           PULS   PC,U,X                                                * 329C 35 D0          5P
L329E      PSHS   U                                                     * 329E 34 40          4@
           LDB    <U005B                                                * 32A0 D6 5B          V[
           LBNE   L3313                                                 * 32A2 10 26 00 6D    .&.m
           LDD    #32                                                   * 32A6 CC 00 20       L.
           PSHS   D                                                     * 32A9 34 06          4.
           LDD    <U0064                                                * 32AB DC 64          \d
           PSHS   D                                                     * 32AD 34 06          4.
           BSR    L32CD                                                 * 32AF 8D 1C          ..
           LEAS   4,S                                                   * 32B1 32 64          2d
           LDD    #32                                                   * 32B3 CC 00 20       L.
           PSHS   D                                                     * 32B6 34 06          4.
           LDD    <U0066                                                * 32B8 DC 66          \f
           PSHS   D                                                     * 32BA 34 06          4.
           BSR    L32CD                                                 * 32BC 8D 0F          ..
           LEAS   4,S                                                   * 32BE 32 64          2d
           LDD    #13                                                   * 32C0 CC 00 0D       L..
           PSHS   D                                                     * 32C3 34 06          4.
           LDD    <U0062                                                * 32C5 DC 62          \b
           PSHS   D                                                     * 32C7 34 06          4.
           BSR    L32CD                                                 * 32C9 8D 02          ..
           BRA    L3311                                                 * 32CB 20 44           D
L32CD      PSHS   U                                                     * 32CD 34 40          4@
           LDU    4,S                                                   * 32CF EE 64          nd
           BRA    L32E1                                                 * 32D1 20 0E           .
L32D3      LDD    <U00DA                                                * 32D3 DC DA          \Z
           PSHS   D                                                     * 32D5 34 06          4.
           LDB    ,U+                                                   * 32D7 E6 C0          f@
           SEX                                                          * 32D9 1D             .
           PSHS   D                                                     * 32DA 34 06          4.
           LBSR   L40C2                                                 * 32DC 17 0D E3       ..c
           LEAS   4,S                                                   * 32DF 32 64          2d
L32E1      LDB    ,U                                                    * 32E1 E6 C4          fD
           BNE    L32D3                                                 * 32E3 26 EE          &n
           LDD    <U00DA                                                * 32E5 DC DA          \Z
           PSHS   D                                                     * 32E7 34 06          4.
           LDD    8,S                                                   * 32E9 EC 68          lh
           PSHS   D                                                     * 32EB 34 06          4.
           LBSR   L40C2                                                 * 32ED 17 0D D2       ..R
           LEAS   4,S                                                   * 32F0 32 64          2d
           LDX    <U00DA                                                * 32F2 9E DA          .Z
           LDD    6,X                                                   * 32F4 EC 06          l.
           CLRA                                                         * 32F6 4F             O
           ANDB   #32                                                   * 32F7 C4 20          D
           BEQ    L32FE                                                 * 32F9 27 03          '.
           LBSR   L3714                                                 * 32FB 17 04 16       ...
L32FE      PULS   PC,U                                                  * 32FE 35 C0          5@
L3300      PSHS   U                                                     * 3300 34 40          4@
           LDB    <U005B                                                * 3302 D6 5B          V[
           BNE    L3313                                                 * 3304 26 0D          &.
           LDD    <U00DA                                                * 3306 DC DA          \Z
           PSHS   D                                                     * 3308 34 06          4.
           CLRA                                                         * 330A 4F             O
           CLRB                                                         * 330B 5F             _
           PSHS   D                                                     * 330C 34 06          4.
           LBSR   L40C2                                                 * 330E 17 0D B1       ..1
L3311      LEAS   4,S                                                   * 3311 32 64          2d
L3313      LDD    #1                                                    * 3313 CC 00 01       L..
           PULS   PC,U                                                  * 3316 35 C0          5@
L3318      PSHS   U                                                     * 3318 34 40          4@
           LDU    <U00D4                                                * 331A DE D4          ^T
           BRA    L3348                                                 * 331C 20 2A           *
L331E      LDB    [<$04,S]                                              * 331E E6 F8 04       fx.
           SEX                                                          * 3321 1D             .
           PSHS   D                                                     * 3322 34 06          4.
           LDX    2,U                                                   * 3324 AE 42          .B
           LDB    10,X                                                  * 3326 E6 0A          f.
           SEX                                                          * 3328 1D             .
           CMPD   ,S++                                                  * 3329 10 A3 E1       .#a
           BNE    L3346                                                 * 332C 26 18          &.
           LDD    2,U                                                   * 332E EC 42          lB
           ADDD   #10                                                   * 3330 C3 00 0A       C..
           PSHS   D                                                     * 3333 34 06          4.
           LDD    6,S                                                   * 3335 EC 66          lf
           PSHS   D                                                     * 3337 34 06          4.
           LBSR   L4559                                                 * 3339 17 12 1D       ...
           LEAS   4,S                                                   * 333C 32 64          2d
           STD    -2,S                                                  * 333E ED 7E          m~
           BNE    L3346                                                 * 3340 26 04          &.
           TFR    U,D                                                   * 3342 1F 30          .0
           PULS   PC,U                                                  * 3344 35 C0          5@
L3346      LDU    ,U                                                    * 3346 EE C4          nD
L3348      STU    -2,S                                                  * 3348 EF 7E          o~
           BNE    L331E                                                 * 334A 26 D2          &R
           CLRA                                                         * 334C 4F             O
           CLRB                                                         * 334D 5F             _
           PULS   PC,U                                                  * 334E 35 C0          5@
L3350      PSHS   U                                                     * 3350 34 40          4@
           LDD    <U00E2                                                * 3352 DC E2          \b
           ADDD   #1                                                    * 3354 C3 00 01       C..
           STD    <U00E2                                                * 3357 DD E2          ]b
           SUBD   #1                                                    * 3359 83 00 01       ...
           PSHS   D                                                     * 335C 34 06          4.
           LDD    #10                                                   * 335E CC 00 0A       L..
           LBSR   L466A                                                 * 3361 17 13 06       ...
           LEAX   >Y0957,Y                                              * 3364 30 A9 09 57    0).W
           LEAX   D,X                                                   * 3368 30 8B          0.
           LEAU   ,X                                                    * 336A 33 84          3.
           LDD    <U00E2                                                * 336C DC E2          \b
           CMPD   #8                                                    * 336E 10 83 00 08    ....
           BLE    L337F                                                 * 3372 2F 0B          /.
           LEAX   >L373F,PC                                             * 3374 30 8D 03 C7    0..G
           PSHS   X                                                     * 3378 34 10          4.
           LBSR   L078B                                                 * 337A 17 D4 0E       .T.
           LEAS   2,S                                                   * 337D 32 62          2b
L337F      LDD    <U00DC                                                * 337F DC DC          \\
           STD    ,U                                                    * 3381 ED C4          mD
           LEAX   2,U                                                   * 3383 30 42          0B
           PSHS   X                                                     * 3385 34 10          4.
           LDD    <U00DC                                                * 3387 DC DC          \\
           PSHS   D                                                     * 3389 34 06          4.
           LBSR   L4059                                                 * 338B 17 0C CB       ..K
           LEAS   2,S                                                   * 338E 32 62          2b
           LBSR   L4636                                                 * 3390 17 12 A3       ..#
           LDD    <U00DE                                                * 3393 DC DE          \^
           STD    6,U                                                   * 3395 ED 46          mF
           LDD    <U00E0                                                * 3397 DC E0          \`
           STD    8,U                                                   * 3399 ED 48          mH
           LDX    4,S                                                   * 339B AE 64          .d
           LDD    4,X                                                   * 339D EC 04          l.
           STD    <U00DC                                                * 339F DD DC          ]\
           CLRA                                                         * 33A1 4F             O
           CLRB                                                         * 33A2 5F             _
           PSHS   D                                                     * 33A3 34 06          4.
           LDX    6,S                                                   * 33A5 AE 66          .f
           LEAX   6,X                                                   * 33A7 30 06          0.
           LDD    2,X                                                   * 33A9 EC 02          l.
           PSHS   D                                                     * 33AB 34 06          4.
           LDD    ,X                                                    * 33AD EC 84          l.
           PSHS   D                                                     * 33AF 34 06          4.
           LDD    <U00DC                                                * 33B1 DC DC          \\
           PSHS   D                                                     * 33B3 34 06          4.
           LBSR   L3F02                                                 * 33B5 17 0B 4A       ..J
           LEAS   8,S                                                   * 33B8 32 68          2h
           LDD    <U00CC                                                * 33BA DC CC          \L
           BNE    L33C5                                                 * 33BC 26 07          &.
           LDD    <U00D8                                                * 33BE DC D8          \X
           ADDD   #1                                                    * 33C0 C3 00 01       C..
           STD    <U00D8                                                * 33C3 DD D8          ]X
L33C5      LDD    <U00D8                                                * 33C5 DC D8          \X
           STD    <U00DE                                                * 33C7 DD DE          ]^
           LBSR   L3556                                                 * 33C9 17 01 8A       ...
           STD    <U00E0                                                * 33CC DD E0          ]`
           LDD    #1                                                    * 33CE CC 00 01       L..
           STD    <U00CE                                                * 33D1 DD CE          ]N
           PULS   PC,U                                                  * 33D3 35 C0          5@
L33D5      PSHS   U                                                     * 33D5 34 40          4@
           LDD    <U00E2                                                * 33D7 DC E2          \b
           ADDD   #-1                                                   * 33D9 C3 FF FF       C..
           STD    <U00E2                                                * 33DC DD E2          ]b
           PSHS   D                                                     * 33DE 34 06          4.
           LDD    #10                                                   * 33E0 CC 00 0A       L..
           LBSR   L466A                                                 * 33E3 17 12 84       ...
           LEAX   >Y0957,Y                                              * 33E6 30 A9 09 57    0).W
           LEAX   D,X                                                   * 33EA 30 8B          0.
           LEAU   ,X                                                    * 33EC 33 84          3.
           LDD    <U00E2                                                * 33EE DC E2          \b
           BGE    L33FD                                                 * 33F0 2C 0B          ,.
           LEAX   >L3756,PC                                             * 33F2 30 8D 03 60    0..`
           PSHS   X                                                     * 33F6 34 10          4.
           LBSR   L078B                                                 * 33F8 17 D3 90       .S.
           LEAS   2,S                                                   * 33FB 32 62          2b
L33FD      LDD    ,U                                                    * 33FD EC C4          lD
           STD    <U00DC                                                * 33FF DD DC          ]\
           CLRA                                                         * 3401 4F             O
           CLRB                                                         * 3402 5F             _
           PSHS   D                                                     * 3403 34 06          4.
           LEAX   2,U                                                   * 3405 30 42          0B
           LDD    2,X                                                   * 3407 EC 02          l.
           PSHS   D                                                     * 3409 34 06          4.
           LDD    ,X                                                    * 340B EC 84          l.
           PSHS   D                                                     * 340D 34 06          4.
           LDD    <U00DC                                                * 340F DC DC          \\
           PSHS   D                                                     * 3411 34 06          4.
           LBSR   L3F02                                                 * 3413 17 0A EC       ..l
           LEAS   8,S                                                   * 3416 32 68          2h
           LDD    6,U                                                   * 3418 EC 46          lF
           STD    <U00DE                                                * 341A DD DE          ]^
           LDD    <U00E0                                                * 341C DC E0          \`
           PSHS   D                                                     * 341E 34 06          4.
           LBSR   L3697                                                 * 3420 17 02 74       ..t
           LEAS   2,S                                                   * 3423 32 62          2b
           LDD    8,U                                                   * 3425 EC 48          lH
           STD    <U00E0                                                * 3427 DD E0          ]`
           PULS   PC,U                                                  * 3429 35 C0          5@
L342B      PSHS   U,D                                                   * 342B 34 46          4F
           LBRA   L3495                                                 * 342D 16 00 65       ..e
L3430      LEAX   >Y0857,Y                                              * 3430 30 A9 08 57    0).W
           STX    <U0062                                                * 3434 9F 62          .b
           TFR    X,D                                                   * 3436 1F 10          ..
           STD    <U00E4                                                * 3438 DD E4          ]d
           BRA    L347B                                                 * 343A 20 3F           ?
L343C      LDD    ,S                                                    * 343C EC E4          ld
           CMPD   #13                                                   * 343E 10 83 00 0D    ....
           BNE    L345A                                                 * 3442 26 16          &.
           CLRA                                                         * 3444 4F             O
           CLRB                                                         * 3445 5F             _
           STB    [>U00E4,Y]                                            * 3446 E7 B9 00 E4    g9.d
           LDB    <U0002                                                * 344A D6 02          V.
           BEQ    L3455                                                 * 344C 27 07          '.
           LDD    <U002F                                                * 344E DC 2F          \/
           ADDD   #1                                                    * 3450 C3 00 01       C..
           STD    <U002F                                                * 3453 DD 2F          ]/
L3455      LDD    #1                                                    * 3455 CC 00 01       L..
           PULS   PC,U,X                                                * 3458 35 D0          5P
L345A      LDD    ,S                                                    * 345A EC E4          ld
           CMPD   #92                                                   * 345C 10 83 00 5C    ...\
           BNE    L3471                                                 * 3460 26 0F          &.
           LDD    <U00DC                                                * 3462 DC DC          \\
           PSHS   D                                                     * 3464 34 06          4.
           LBSR   L42D5                                                 * 3466 17 0E 6C       ..l
           STD    ,S                                                    * 3469 ED E4          md
           BSR    L349F                                                 * 346B 8D 32          .2
           LEAS   2,S                                                   * 346D 32 62          2b
           BRA    L347B                                                 * 346F 20 0A           .
L3471      LDD    ,S                                                    * 3471 EC E4          ld
           LDX    <U00E4                                                * 3473 9E E4          .d
           LEAX   1,X                                                   * 3475 30 01          0.
           STX    <U00E4                                                * 3477 9F E4          .d
           STB    -1,X                                                  * 3479 E7 1F          g.
L347B      LDD    <U00DC                                                * 347B DC DC          \\
           PSHS   D                                                     * 347D 34 06          4.
           LBSR   L42D5                                                 * 347F 17 0E 53       ..S
           LEAS   2,S                                                   * 3482 32 62          2b
           STD    ,S                                                    * 3484 ED E4          md
           BGT    L343C                                                 * 3486 2E B4          .4
           LDD    <U00E2                                                * 3488 DC E2          \b
           BNE    L3492                                                 * 348A 26 06          &.
           CLRA                                                         * 348C 4F             O
           CLRB                                                         * 348D 5F             _
           STD    <U00CE                                                * 348E DD CE          ]N
           BRA    L349B                                                 * 3490 20 09           .
L3492      LBSR   L33D5                                                 * 3492 17 FF 40       ..@
L3495      LDD    <U00CE                                                * 3495 DC CE          \N
           LBNE   L3430                                                 * 3497 10 26 FF 95    .&..
L349B      CLRA                                                         * 349B 4F             O
           CLRB                                                         * 349C 5F             _
           PULS   PC,U,X                                                * 349D 35 D0          5P
L349F      PSHS   U                                                     * 349F 34 40          4@
           LDD    4,S                                                   * 34A1 EC 64          ld
           LEAX   >Y03FC,Y                                              * 34A3 30 A9 03 FC    0).|
           LEAX   D,X                                                   * 34A7 30 8B          0.
           LDB    ,X                                                    * 34A9 E6 84          f.
           CLRA                                                         * 34AB 4F             O
           ANDB   #8                                                    * 34AC C4 08          D.
           BEQ    L34C0                                                 * 34AE 27 10          '.
           LDD    #1                                                    * 34B0 CC 00 01       L..
           PSHS   D                                                     * 34B3 34 06          4.
           LDD    6,S                                                   * 34B5 EC 66          lf
           PSHS   D                                                     * 34B7 34 06          4.
           LBSR   L36A4                                                 * 34B9 17 01 E8       ..h
           LEAS   4,S                                                   * 34BC 32 64          2d
           PULS   PC,U                                                  * 34BE 35 C0          5@
L34C0      LDX    4,S                                                   * 34C0 AE 64          .d
           LBRA   L3538                                                 * 34C2 16 00 73       ..s
L34C5      LDD    4,S                                                   * 34C5 EC 64          ld
           LDX    <U00E4                                                * 34C7 9E E4          .d
           LEAX   1,X                                                   * 34C9 30 01          0.
           STX    <U00E4                                                * 34CB 9F E4          .d
           STB    -1,X                                                  * 34CD E7 1F          g.
           LDD    <U00DE                                                * 34CF DC DE          \^
           PSHS   D                                                     * 34D1 34 06          4.
           LDD    #100                                                  * 34D3 CC 00 64       L.d
           LBSR   L46BD                                                 * 34D6 17 11 E4       ..d
           PSHS   D                                                     * 34D9 34 06          4.
           LEAX   >L376A,PC                                             * 34DB 30 8D 02 8B    0...
           PSHS   X                                                     * 34DF 34 10          4.
           LDD    <U00E4                                                * 34E1 DC E4          \d
           PSHS   D                                                     * 34E3 34 06          4.
           LBSR   L3A2A                                                 * 34E5 17 05 42       ..B
           LEAS   6,S                                                   * 34E8 32 66          2f
           LDD    <U00E4                                                * 34EA DC E4          \d
           ADDD   #3                                                    * 34EC C3 00 03       C..
           BRA    L3528                                                 * 34EF 20 37           7
L34F1      LDD    4,S                                                   * 34F1 EC 64          ld
           CMPD   #35                                                   * 34F3 10 83 00 23    ...#
           BNE    L3500                                                 * 34F7 26 07          &.
           LDB    [>U00E0,Y]                                            * 34F9 E6 B9 00 E0    f9.`
           SEX                                                          * 34FD 1D             .
           BRA    L3512                                                 * 34FE 20 12           .
L3500      CLRA                                                         * 3500 4F             O
           CLRB                                                         * 3501 5F             _
           PSHS   D                                                     * 3502 34 06          4.
           LDD    <U00DC                                                * 3504 DC DC          \\
           PSHS   D                                                     * 3506 34 06          4.
           LBSR   L42D5                                                 * 3508 17 0D CA       ..J
           STD    ,S                                                    * 350B ED E4          md
           LBSR   L36A4                                                 * 350D 17 01 94       ...
           LEAS   4,S                                                   * 3510 32 64          2d
L3512      PSHS   D                                                     * 3512 34 06          4.
           LEAX   >L376F,PC                                             * 3514 30 8D 02 57    0..W
           PSHS   X                                                     * 3518 34 10          4.
           LDD    <U00E4                                                * 351A DC E4          \d
           PSHS   D                                                     * 351C 34 06          4.
           LBSR   L3A2A                                                 * 351E 17 05 09       ...
           LEAS   6,S                                                   * 3521 32 66          2f
           LDD    <U00E4                                                * 3523 DC E4          \d
           ADDD   #2                                                    * 3525 C3 00 02       C..
L3528      STD    <U00E4                                                * 3528 DD E4          ]d
           BRA    L3554                                                 * 352A 20 28           (
L352C      LDD    4,S                                                   * 352C EC 64          ld
           LDX    <U00E4                                                * 352E 9E E4          .d
           LEAX   1,X                                                   * 3530 30 01          0.
           STX    <U00E4                                                * 3532 9F E4          .d
           STB    -1,X                                                  * 3534 E7 1F          g.
           BRA    L3554                                                 * 3536 20 1C           .
L3538      CMPX   #64                                                   * 3538 8C 00 40       ..@
           LBEQ   L34C5                                                 * 353B 10 27 FF 86    .'..
           CMPX   #76                                                   * 353F 8C 00 4C       ..L
           BEQ    L34F1                                                 * 3542 27 AD          '-
           CMPX   #108                                                  * 3544 8C 00 6C       ..l
           LBEQ   L34F1                                                 * 3547 10 27 FF A6    .'.&
           CMPX   #35                                                   * 354B 8C 00 23       ..#
           LBEQ   L34F1                                                 * 354E 10 27 FF 9F    .'..
           BRA    L352C                                                 * 3552 20 D8           X
L3554      PULS   PC,U                                                  * 3554 35 C0          5@
L3556      PSHS   U,Y,X,D                                               * 3556 34 76          4v
           CLRA                                                         * 3558 4F             O
           CLRB                                                         * 3559 5F             _
           STD    2,S                                                   * 355A ED 62          mb
           LDD    #59                                                   * 355C CC 00 3B       L.;
           STD    ,S                                                    * 355F ED E4          md
           LDD    <U00E6                                                * 3561 DC E6          \f
           BEQ    L356F                                                 * 3563 27 0A          '.
           LDU    <U00E6                                                * 3565 DE E6          ^f
           LDD    [>U00E6,Y]                                            * 3567 EC B9 00 E6    l9.f
           STD    <U00E6                                                * 356B DD E6          ]f
           BRA    L357B                                                 * 356D 20 0C           .
L356F      LDD    #61                                                   * 356F CC 00 3D       L.=
           PSHS   D                                                     * 3572 34 06          4.
           LBSR   L233C                                                 * 3574 17 ED C5       .mE
           LEAS   2,S                                                   * 3577 32 62          2b
           TFR    D,U                                                   * 3579 1F 03          ..
L357B      LBSR   L2229                                                 * 357B 17 EC AB       .l+
           LDD    <U0062                                                * 357E DC 62          \b
           STD    <U006A                                                * 3580 DD 6A          ]j
           LDD    #1                                                    * 3582 CC 00 01       L..
           STD    <U00D6                                                * 3585 DD D6          ]V
           TFR    U,D                                                   * 3587 1F 30          .0
           LEAU   1,U                                                   * 3589 33 41          3A
           STD    4,S                                                   * 358B ED 64          md
           LDB    [>U0062,Y]                                            * 358D E6 B9 00 62    f9.b
           LBEQ   L3666                                                 * 3591 10 27 00 D1    .'.Q
           LEAS   -2,S                                                  * 3595 32 7E          2~
           LBRA   L3645                                                 * 3597 16 00 AB       ..+
L359A      LDB    [>U0062,Y]                                            * 359A E6 B9 00 62    f9.b
           SEX                                                          * 359E 1D             .
           TFR    D,X                                                   * 359F 1F 01          ..
           LBRA   L361B                                                 * 35A1 16 00 77       ..w
L35A4      CLRA                                                         * 35A4 4F             O
           CLRB                                                         * 35A5 5F             _
           STB    ,U+                                                   * 35A6 E7 C0          g@
           LDD    4,S                                                   * 35A8 EC 64          ld
           ADDD   #1                                                    * 35AA C3 00 01       C..
           STD    4,S                                                   * 35AD ED 64          md
           LDD    <U0062                                                * 35AF DC 62          \b
           ADDD   #1                                                    * 35B1 C3 00 01       C..
           STD    <U0062                                                * 35B4 DD 62          ]b
           LBRA   L363E                                                 * 35B6 16 00 85       ...
L35B9      LEAX   8,S                                                   * 35B9 30 68          0h
           LBRA   L3664                                                 * 35BB 16 00 A6       ..&
L35BE      LDX    <U0062                                                * 35BE 9E 62          .b
           LEAX   1,X                                                   * 35C0 30 01          0.
           STX    <U0062                                                * 35C2 9F 62          .b
           LDB    -1,X                                                  * 35C4 E6 1F          f.
           STB    1,S                                                   * 35C6 E7 61          ga
           BRA    L35DE                                                 * 35C8 20 14           .
L35CA      LDB    ,S                                                    * 35CA E6 E4          fd
           CMPB   #92                                                   * 35CC C1 5C          A\
           BNE    L35DA                                                 * 35CE 26 0A          &.
           LDX    <U0062                                                * 35D0 9E 62          .b
           LEAX   1,X                                                   * 35D2 30 01          0.
           STX    <U0062                                                * 35D4 9F 62          .b
           LDB    -1,X                                                  * 35D6 E6 1F          f.
           STB    ,S                                                    * 35D8 E7 E4          gd
L35DA      LDB    ,S                                                    * 35DA E6 E4          fd
           STB    ,U+                                                   * 35DC E7 C0          g@
L35DE      LDX    <U0062                                                * 35DE 9E 62          .b
           LEAX   1,X                                                   * 35E0 30 01          0.
           STX    <U0062                                                * 35E2 9F 62          .b
           LDB    -1,X                                                  * 35E4 E6 1F          f.
           STB    ,S                                                    * 35E6 E7 E4          gd
           BEQ    L35F7                                                 * 35E8 27 0D          '.
           LDB    ,S                                                    * 35EA E6 E4          fd
           SEX                                                          * 35EC 1D             .
           PSHS   D                                                     * 35ED 34 06          4.
           LDB    3,S                                                   * 35EF E6 63          fc
           SEX                                                          * 35F1 1D             .
           CMPD   ,S++                                                  * 35F2 10 A3 E1       .#a
           BNE    L35CA                                                 * 35F5 26 D3          &S
L35F7      LDB    ,S                                                    * 35F7 E6 E4          fd
           BNE    L363E                                                 * 35F9 26 43          &C
           LEAX   >L3774,PC                                             * 35FB 30 8D 01 75    0..u
           PSHS   X                                                     * 35FF 34 10          4.
           LBSR   L074E                                                 * 3601 17 D1 4A       .QJ
           LEAS   2,S                                                   * 3604 32 62          2b
           BRA    L363E                                                 * 3606 20 36           6
L3608      LDD    <U0062                                                * 3608 DC 62          \b
           ADDD   #1                                                    * 360A C3 00 01       C..
           STD    <U0062                                                * 360D DD 62          ]b
L360F      LDX    <U0062                                                * 360F 9E 62          .b
           LEAX   1,X                                                   * 3611 30 01          0.
           STX    <U0062                                                * 3613 9F 62          .b
           LDB    -1,X                                                  * 3615 E6 1F          f.
           STB    ,U+                                                   * 3617 E7 C0          g@
           BRA    L363E                                                 * 3619 20 23           #
L361B      CMPX   #44                                                   * 361B 8C 00 2C       ..,
           LBEQ   L35A4                                                 * 361E 10 27 FF 82    .'..
           CMPX   #32                                                   * 3622 8C 00 20       ..
           LBEQ   L35B9                                                 * 3625 10 27 FF 90    .'..
           CMPX   #39                                                   * 3629 8C 00 27       ..'
           LBEQ   L35BE                                                 * 362C 10 27 FF 8E    .'..
           CMPX   #34                                                   * 3630 8C 00 22       .."
           LBEQ   L35BE                                                 * 3633 10 27 FF 87    .'..
           CMPX   #92                                                   * 3637 8C 00 5C       ..\
           BEQ    L3608                                                 * 363A 27 CC          'L
           BRA    L360F                                                 * 363C 20 D1           Q
L363E      LDD    2,S                                                   * 363E EC 62          lb
           ADDD   #-1                                                   * 3640 C3 FF FF       C..
           STD    2,S                                                   * 3643 ED 62          mb
L3645      LDD    2,S                                                   * 3645 EC 62          lb
           BEQ    L3659                                                 * 3647 27 10          '.
           LDB    [>U0062,Y]                                            * 3649 E6 B9 00 62    f9.b
           STB    ,S                                                    * 364D E7 E4          gd
           BEQ    L3659                                                 * 364F 27 08          '.
           LDB    ,S                                                    * 3651 E6 E4          fd
           CMPB   #32                                                   * 3653 C1 20          A
           LBNE   L359A                                                 * 3655 10 26 FF 41    .&.A
L3659      LDD    4,S                                                   * 3659 EC 64          ld
           ADDD   #1                                                    * 365B C3 00 01       C..
           STD    4,S                                                   * 365E ED 64          md
           LEAS   2,S                                                   * 3660 32 62          2b
           BRA    L3666                                                 * 3662 20 02           .
L3664      LEAS   -6,X                                                  * 3664 32 1A          2.
L3666      CLRA                                                         * 3666 4F             O
           CLRB                                                         * 3667 5F             _
           STB    ,U                                                    * 3668 E7 C4          gD
           LDD    ,S                                                    * 366A EC E4          ld
           BNE    L3679                                                 * 366C 26 0B          &.
           LEAX   >L3785,PC                                             * 366E 30 8D 01 13    0...
           PSHS   X                                                     * 3672 34 10          4.
           LBSR   L074E                                                 * 3674 17 D0 D7       .PW
           LEAS   2,S                                                   * 3677 32 62          2b
L3679      LDD    2,S                                                   * 3679 EC 62          lb
           CMPD   #9                                                    * 367B 10 83 00 09    ....
           BLE    L368C                                                 * 367F 2F 0B          /.
           LEAX   >L3798,PC                                             * 3681 30 8D 01 13    0...
           PSHS   X                                                     * 3685 34 10          4.
           LBSR   L074E                                                 * 3687 17 D0 C4       .PD
           LEAS   2,S                                                   * 368A 32 62          2b
L368C      LDD    2,S                                                   * 368C EC 62          lb
           STB    [<$04,S]                                              * 368E E7 F8 04       gx.
           LDD    4,S                                                   * 3691 EC 64          ld
           LEAS   6,S                                                   * 3693 32 66          2f
           PULS   PC,U                                                  * 3695 35 C0          5@
L3697      PSHS   U                                                     * 3697 34 40          4@
           LDD    <U00E6                                                * 3699 DC E6          \f
           STD    [<$04,S]                                              * 369B ED F8 04       mx.
           LDD    4,S                                                   * 369E EC 64          ld
           STD    <U00E6                                                * 36A0 DD E6          ]f
           PULS   PC,U                                                  * 36A2 35 C0          5@
L36A4      PSHS   U,D                                                   * 36A4 34 46          4F
           CLRA                                                         * 36A6 4F             O
           CLRB                                                         * 36A7 5F             _
           STD    ,S                                                    * 36A8 ED E4          md
           LDD    6,S                                                   * 36AA EC 66          lf
           SUBD   #48                                                   * 36AC 83 00 30       ..0
           STD    6,S                                                   * 36AF ED 66          mf
           BLE    L36FA                                                 * 36B1 2F 47          /G
           LDU    <U00E0                                                * 36B3 DE E0          ^`
           LDB    ,U                                                    * 36B5 E6 C4          fD
           SEX                                                          * 36B7 1D             .
           CMPD   6,S                                                   * 36B8 10 A3 66       .#f
           BLT    L36EF                                                 * 36BB 2D 32          -2
           LEAU   1,U                                                   * 36BD 33 41          3A
           BRA    L36C5                                                 * 36BF 20 04           .
L36C1      LDB    ,U+                                                   * 36C1 E6 C0          f@
           BNE    L36C1                                                 * 36C3 26 FC          &|
L36C5      LDD    6,S                                                   * 36C5 EC 66          lf
           ADDD   #-1                                                   * 36C7 C3 FF FF       C..
           STD    6,S                                                   * 36CA ED 66          mf
           LBGT   L36C1                                                 * 36CC 10 2E FF F1    ...q
           BRA    L36E9                                                 * 36D0 20 17           .
L36D2      LDD    8,S                                                   * 36D2 EC 68          lh
           BEQ    L36E0                                                 * 36D4 27 0A          '.
           LDB    ,U                                                    * 36D6 E6 C4          fD
           LDX    <U00E4                                                * 36D8 9E E4          .d
           LEAX   1,X                                                   * 36DA 30 01          0.
           STX    <U00E4                                                * 36DC 9F E4          .d
           STB    -1,X                                                  * 36DE E7 1F          g.
L36E0      LEAU   1,U                                                   * 36E0 33 41          3A
           LDD    ,S                                                    * 36E2 EC E4          ld
           ADDD   #1                                                    * 36E4 C3 00 01       C..
           STD    ,S                                                    * 36E7 ED E4          md
L36E9      LDB    ,U                                                    * 36E9 E6 C4          fD
           BNE    L36D2                                                 * 36EB 26 E5          &e
           BRA    L36FA                                                 * 36ED 20 0B           .
L36EF      LEAX   >L37A6,PC                                             * 36EF 30 8D 00 B3    0..3
           PSHS   X                                                     * 36F3 34 10          4.
           LBSR   L074E                                                 * 36F5 17 D0 56       .PV
           LEAS   2,S                                                   * 36F8 32 62          2b
L36FA      LDD    ,S                                                    * 36FA EC E4          ld
           PULS   PC,U,X                                                * 36FC 35 D0          5P
L36FE      PSHS   U                                                     * 36FE 34 40          4@
           LDD    <U00DA                                                * 3700 DC DA          \Z
           PSHS   D                                                     * 3702 34 06          4.
           LBSR   fclose                                                * 3704 17 0A AB       ..+
           LEAS   2,S                                                   * 3707 32 62          2b
           LEAX   >dpsiz,Y                                              * 3709 30 A9 00 E8    0).h
           PSHS   X                                                     * 370D 34 10          4.
           LBSR   unlink                                                * 370F 17 11 86       ...
           PULS   PC,U,X                                                * 3712 35 D0          5P
L3714      PSHS   U                                                     * 3714 34 40          4@
           LEAX   >L37B7,PC                                             * 3716 30 8D 00 9D    0...
           PSHS   X                                                     * 371A 34 10          4.
           LBSR   L078B                                                 * 371C 17 D0 6C       .Pl
           PULS   PC,U,X                                                * 371F 35 D0          5P
L3721      FCC    "w+"                                                  * 3721 77 2B          w+
           FCB    $00                                                   * 3723 00             .
L3724      FCC    "can't open macro work file"                          * 3724 63 61 6E 27 74 20 6F 70 65 6E 20 6D 61 63 72 6F 20 77 6F 72 6B 20 66 69 6C 65 can't open macro work file
           FCB    $00                                                   * 373E 00             .
L373F      FCC    "macro nesting too deep"                              * 373F 6D 61 63 72 6F 20 6E 65 73 74 69 6E 67 20 74 6F 6F 20 64 65 65 70 macro nesting too deep
           FCB    $00                                                   * 3755 00             .
L3756      FCC    "asm err: macro nest"                                 * 3756 61 73 6D 20 65 72 72 3A 20 6D 61 63 72 6F 20 6E 65 73 74 asm err: macro nest
           FCB    $00                                                   * 3769 00             .
L376A      FCC    "%03d"                                                * 376A 25 30 33 64    %03d
           FCB    $00                                                   * 376E 00             .
L376F      FCC    "%02d"                                                * 376F 25 30 32 64    %02d
           FCB    $00                                                   * 3773 00             .
L3774      FCC    "unmatched quotes"                                    * 3774 75 6E 6D 61 74 63 68 65 64 20 71 75 6F 74 65 73 unmatched quotes
           FCB    $00                                                   * 3784 00             .
L3785      FCC    "macro arg too long"                                  * 3785 6D 61 63 72 6F 20 61 72 67 20 74 6F 6F 20 6C 6F 6E 67 macro arg too long
           FCB    $00                                                   * 3797 00             .
L3798      FCC    "too many args"                                       * 3798 74 6F 6F 20 6D 61 6E 79 20 61 72 67 73 too many args
           FCB    $00                                                   * 37A5 00             .
L37A6      FCC    "no param for arg"                                    * 37A6 6E 6F 20 70 61 72 61 6D 20 66 6F 72 20 61 72 67 no param for arg
           FCB    $00                                                   * 37B6 00             .
L37B7      FCC    "macro file error"                                    * 37B7 6D 61 63 72 6F 20 66 69 6C 65 20 65 72 72 6F 72 macro file error
           FCB    $00                                                   * 37C7 00             .

* fopen

L37C8      PSHS   U                                                     * 37C8 34 40          4@
           LEAU   >_iob,Y                                               * 37CA 33 A9 04 89    3)..
L37CE      LDD    6,U                                                   * 37CE EC 46          lF
           CLRA                                                         * 37D0 4F             O
           ANDB   #3                                                    * 37D1 C4 03          D.
           LBEQ   L383F                                                 * 37D3 10 27 00 68    .'.h
           LEAU   13,U                                                  * 37D7 33 4D          3M
           PSHS   U                                                     * 37D9 34 40          4@
           LEAX   >argv,Y      Should be _iob+208,y                     * 37DB 30 A9 05 59    0).Y
           CMPX   ,S++                                                  * 37DF AC E1          ,a
           BHI    L37CE                                                 * 37E1 22 EB          "k
           LDD    #200                                                  * 37E3 CC 00 C8       L.H
           STD    >errno,Y                                              * 37E6 ED A9 05 A7    m).'
           LBRA   L3843                                                 * 37EA 16 00 56       ..V
           PULS   PC,U                                                  * 37ED 35 C0          5@
L37EF      PSHS   U                                                     * 37EF 34 40          4@
           LDU    8,S                                                   * 37F1 EE 68          nh
           BNE    L37F9                                                 * 37F3 26 04          &.
           BSR    L37C8                                                 * 37F5 8D D1          .Q
           TFR    D,U                                                   * 37F7 1F 03          ..
L37F9      STU    -2,S                                                  * 37F9 EF 7E          o~
           BEQ    L3843                                                 * 37FB 27 46          'F
           LDD    4,S                                                   * 37FD EC 64          ld
           STD    8,U                                                   * 37FF ED 48          mH
           LDX    6,S                                                   * 3801 AE 66          .f
           LDB    1,X                                                   * 3803 E6 01          f.
           CMPB   #43                                                   * 3805 C1 2B          A+
           BEQ    L3811                                                 * 3807 27 08          '.
           LDX    6,S                                                   * 3809 AE 66          .f
           LDB    2,X                                                   * 380B E6 02          f.
           CMPB   #43                                                   * 380D C1 2B          A+
           BNE    L3817                                                 * 380F 26 06          &.
L3811      LDD    6,U                                                   * 3811 EC 46          lF
           ORB    #3                                                    * 3813 CA 03          J.
           BRA    L3835                                                 * 3815 20 1E           .
L3817      LDD    6,U                                                   * 3817 EC 46          lF
           PSHS   D                                                     * 3819 34 06          4.
           LDB    [<$08,S]                                              * 381B E6 F8 08       fx.
           CMPB   #114                                                  * 381E C1 72          Ar
           BEQ    L3829                                                 * 3820 27 07          '.
           LDB    [<$08,S]                                              * 3822 E6 F8 08       fx.
           CMPB   #100                                                  * 3825 C1 64          Ad
           BNE    L382E                                                 * 3827 26 05          &.
L3829      LDD    #1                                                    * 3829 CC 00 01       L..
           BRA    L3831                                                 * 382C 20 03           .
L382E      LDD    #2                                                    * 382E CC 00 02       L..
L3831      ORA    ,S+                                                   * 3831 AA E0          *`
           ORB    ,S+                                                   * 3833 EA E0          j`
L3835      STD    6,U                                                   * 3835 ED 46          mF
           LDD    2,U                                                   * 3837 EC 42          lB
           ADDD   11,U                                                  * 3839 E3 4B          cK
           STD    4,U                                                   * 383B ED 44          mD
           STD    ,U                                                    * 383D ED C4          mD
L383F      TFR    U,D                                                   * 383F 1F 30          .0
           PULS   PC,U                                                  * 3841 35 C0          5@
L3843      CLRA                                                         * 3843 4F             O
           CLRB                                                         * 3844 5F             _
           PULS   PC,U                                                  * 3845 35 C0          5@
L3847      PSHS   U                                                     * 3847 34 40          4@
           LDU    4,S                                                   * 3849 EE 64          nd
           LEAS   -4,S                                                  * 384B 32 7C          2|
           CLRA                                                         * 384D 4F             O
           CLRB                                                         * 384E 5F             _
           STD    ,S                                                    * 384F ED E4          md
           LDX    10,S                                                  * 3851 AE 6A          .j
           LDB    1,X                                                   * 3853 E6 01          f.
           SEX                                                          * 3855 1D             .
           TFR    D,X                                                   * 3856 1F 01          ..
           BRA    L3878                                                 * 3858 20 1E           .
L385A      LDX    10,S                                                  * 385A AE 6A          .j
           LDB    2,X                                                   * 385C E6 02          f.
           CMPB   #43                                                   * 385E C1 2B          A+
           BNE    L3867                                                 * 3860 26 05          &.
           LDD    #7                                                    * 3862 CC 00 07       L..
           BRA    L386F                                                 * 3865 20 08           .
L3867      LDD    #4                                                    * 3867 CC 00 04       L..
           BRA    L386F                                                 * 386A 20 03           .
L386C      LDD    #3                                                    * 386C CC 00 03       L..
L386F      STD    ,S                                                    * 386F ED E4          md
           BRA    L3888                                                 * 3871 20 15           .
L3873      LEAX   4,S                                                   * 3873 30 64          0d
           LBRA   L38E0                                                 * 3875 16 00 68       ..h
L3878      STX    -2,S                                                  * 3878 AF 7E          /~
           BEQ    L3888                                                 * 387A 27 0C          '.
           CMPX   #120                                                  * 387C 8C 00 78       ..x
           BEQ    L385A                                                 * 387F 27 D9          'Y
           CMPX   #43                                                   * 3881 8C 00 2B       ..+
           BEQ    L386C                                                 * 3884 27 E6          'f
           BRA    L3873                                                 * 3886 20 EB           k
L3888      LDB    [<$0A,S]                                              * 3888 E6 F8 0A       fx.
           SEX                                                          * 388B 1D             .
           TFR    D,X                                                   * 388C 1F 01          ..
           LBRA   L38ED                                                 * 388E 16 00 5C       ..\
L3891      LDD    ,S                                                    * 3891 EC E4          ld
           ORB    #1                                                    * 3893 CA 01          J.
           BRA    L38D3                                                 * 3895 20 3C           <
L3897      LDD    ,S                                                    * 3897 EC E4          ld
           ORB    #2                                                    * 3899 CA 02          J.
           PSHS   D                                                     * 389B 34 06          4.
           PSHS   U                                                     * 389D 34 40          4@
           LBSR   open                                                  * 389F 17 0F 93       ...
           LEAS   4,S                                                   * 38A2 32 64          2d
           STD    2,S                                                   * 38A4 ED 62          mb
           CMPD   #-1                                                   * 38A6 10 83 FF FF    ....
           BEQ    L38C2                                                 * 38AA 27 16          '.
           LDD    #2                                                    * 38AC CC 00 02       L..
           PSHS   D                                                     * 38AF 34 06          4.
           CLRA                                                         * 38B1 4F             O
           CLRB                                                         * 38B2 5F             _
           PSHS   D                                                     * 38B3 34 06          4.
           PSHS   D                                                     * 38B5 34 06          4.
           LDD    8,S                                                   * 38B7 EC 68          lh
           PSHS   D                                                     * 38B9 34 06          4.
           LBSR   lseek                                                 * 38BB 17 10 49       ..I
           LEAS   8,S                                                   * 38BE 32 68          2h
           BRA    L3907                                                 * 38C0 20 45           E
L38C2      LDD    ,S                                                    * 38C2 EC E4          ld
           ORB    #2                                                    * 38C4 CA 02          J.
           PSHS   D                                                     * 38C6 34 06          4.
           PSHS   U                                                     * 38C8 34 40          4@
           LBSR   creat                                                 * 38CA 17 0F 89       ...
           BRA    L38DA                                                 * 38CD 20 0B           .
L38CF      LDD    ,S                                                    * 38CF EC E4          ld
           ORB    #129                                                  * 38D1 CA 81          J.
L38D3      PSHS   D                                                     * 38D3 34 06          4.
           PSHS   U                                                     * 38D5 34 40          4@
           LBSR   open                                                  * 38D7 17 0F 5B       ..[
L38DA      LEAS   4,S                                                   * 38DA 32 64          2d
           STD    2,S                                                   * 38DC ED 62          mb
           BRA    L3907                                                 * 38DE 20 27           '
L38E0      LEAS   -4,X                                                  * 38E0 32 1C          2.
L38E2      LDD    #203                                                  * 38E2 CC 00 CB       L.K
           STD    >errno,Y                                              * 38E5 ED A9 05 A7    m).'
           CLRA                                                         * 38E9 4F             O
           CLRB                                                         * 38EA 5F             _
           BRA    L3909                                                 * 38EB 20 1C           .
L38ED      CMPX   #114                                                  * 38ED 8C 00 72       ..r
           LBEQ   L3891                                                 * 38F0 10 27 FF 9D    .'..
           CMPX   #97                                                   * 38F4 8C 00 61       ..a
           LBEQ   L3897                                                 * 38F7 10 27 FF 9C    .'..
           CMPX   #119                                                  * 38FB 8C 00 77       ..w
           BEQ    L38C2                                                 * 38FE 27 C2          'B
           CMPX   #100                                                  * 3900 8C 00 64       ..d
           BEQ    L38CF                                                 * 3903 27 CA          'J
           BRA    L38E2                                                 * 3905 20 DB           [
L3907      LDD    2,S                                                   * 3907 EC 62          lb
L3909      LEAS   4,S                                                   * 3909 32 64          2d
           PULS   PC,U                                                  * 390B 35 C0          5@
fdopen     PSHS   U                                                     * 390D 34 40          4@
           CLRA                                                         * 390F 4F             O
           CLRB                                                         * 3910 5F             _
           PSHS   D                                                     * 3911 34 06          4.
           LDD    8,S                                                   * 3913 EC 68          lh
           PSHS   D                                                     * 3915 34 06          4.
           LDD    8,S                                                   * 3917 EC 68          lh
           PSHS   D                                                     * 3919 34 06          4.
           LBRA   L3969                                                 * 391B 16 00 4B       ..K
fopen      PSHS   U                                                     * 391E 34 40          4@
           LDD    6,S                                                   * 3920 EC 66          lf
           PSHS   D                                                     * 3922 34 06          4.
           LDD    6,S                                                   * 3924 EC 66          lf
           PSHS   D                                                     * 3926 34 06          4.
           LBSR   L3847                                                 * 3928 17 FF 1C       ...
           LEAS   4,S                                                   * 392B 32 64          2d
           TFR    D,U                                                   * 392D 1F 03          ..
           CMPU   #-1                                                   * 392F 11 83 FF FF    ....
           BNE    L3939                                                 * 3933 26 04          &.
           CLRA                                                         * 3935 4F             O
           CLRB                                                         * 3936 5F             _
           BRA    L396E                                                 * 3937 20 35           5
L3939      CLRA                                                         * 3939 4F             O
           CLRB                                                         * 393A 5F             _
           BRA    L3961                                                 * 393B 20 24           $
freopen    PSHS   U                                                     * 393D 34 40          4@
           LDD    8,S                                                   * 393F EC 68          lh
           PSHS   D                                                     * 3941 34 06          4.
           LBSR   fclose                                                * 3943 17 08 6C       ..l
           LEAS   2,S                                                   * 3946 32 62          2b
           LDD    6,S                                                   * 3948 EC 66          lf
           PSHS   D                                                     * 394A 34 06          4.
           LDD    6,S                                                   * 394C EC 66          lf
           PSHS   D                                                     * 394E 34 06          4.
           LBSR   L3847                                                 * 3950 17 FE F4       .~t
           LEAS   4,S                                                   * 3953 32 64          2d
           TFR    D,U                                                   * 3955 1F 03          ..
           STU    -2,S                                                  * 3957 EF 7E          o~
           BGE    L395F                                                 * 3959 2C 04          ,.
           CLRA                                                         * 395B 4F             O
           CLRB                                                         * 395C 5F             _
           BRA    L396E                                                 * 395D 20 0F           .
L395F      LDD    8,S                                                   * 395F EC 68          lh
L3961      PSHS   D                                                     * 3961 34 06          4.
           LDD    8,S                                                   * 3963 EC 68          lh
           PSHS   D                                                     * 3965 34 06          4.
           PSHS   U                                                     * 3967 34 40          4@
L3969      LBSR   L37EF                                                 * 3969 17 FE 83       .~.
           LEAS   6,S                                                   * 396C 32 66          2f
L396E      PULS   PC,U                                                  * 396E 35 C0          5@
           PSHS   U                                                     * 3970 34 40          4@
           LEAX   >Y0496,Y                                              * 3972 30 A9 04 96    0)..
           PSHS   X                                                     * 3976 34 10          4.
           LDD    6,S                                                   * 3978 EC 66          lf
           PSHS   D                                                     * 397A 34 06          4.
           BSR    L3992                                                 * 397C 8D 14          ..
           LEAS   4,S                                                   * 397E 32 64          2d
           LEAX   >Y0496,Y                                              * 3980 30 A9 04 96    0)..
           PSHS   X                                                     * 3984 34 10          4.
           LDD    #13                                                   * 3986 CC 00 0D       L..
           PSHS   D                                                     * 3989 34 06          4.
           LBSR   L40C2                                                 * 398B 17 07 34       ..4
           LEAS   4,S                                                   * 398E 32 64          2d
           PULS   PC,U                                                  * 3990 35 C0          5@
L3992      PSHS   U                                                     * 3992 34 40          4@
           LDU    4,S                                                   * 3994 EE 64          nd
           LEAS   -1,S                                                  * 3996 32 7F          2.
           BRA    L39A8                                                 * 3998 20 0E           .
L399A      LDD    7,S                                                   * 399A EC 67          lg
           PSHS   D                                                     * 399C 34 06          4.
           LDB    2,S                                                   * 399E E6 62          fb
           SEX                                                          * 39A0 1D             .
           PSHS   D                                                     * 39A1 34 06          4.
           LBSR   L40C2                                                 * 39A3 17 07 1C       ...
           LEAS   4,S                                                   * 39A6 32 64          2d
L39A8      LDB    ,U+                                                   * 39A8 E6 C0          f@
           STB    ,S                                                    * 39AA E7 E4          gd
           BNE    L399A                                                 * 39AC 26 EC          &l
           LEAS   1,S                                                   * 39AE 32 61          2a
           PULS   PC,U                                                  * 39B0 35 C0          5@
L39B2      PSHS   U                                                     * 39B2 34 40          4@
           LDU    4,S                                                   * 39B4 EE 64          nd
           LEAS   -4,S                                                  * 39B6 32 7C          2|
           CLRA                                                         * 39B8 4F             O
           CLRB                                                         * 39B9 5F             _
           BRA    L39ED                                                 * 39BA 20 31           1
L39BC      CLRA                                                         * 39BC 4F             O
           CLRB                                                         * 39BD 5F             _
           STD    ,S                                                    * 39BE ED E4          md
           BRA    L39D9                                                 * 39C0 20 17           .
L39C2      LDD    14,S                                                  * 39C2 EC 6E          ln
           PSHS   D                                                     * 39C4 34 06          4.
           LDB    ,U+                                                   * 39C6 E6 C0          f@
           SEX                                                          * 39C8 1D             .
           PSHS   D                                                     * 39C9 34 06          4.
           LBSR   L40C2                                                 * 39CB 17 06 F4       ..t
           LEAS   4,S                                                   * 39CE 32 64          2d
           LDX    14,S                                                  * 39D0 AE 6E          .n
           LDD    6,X                                                   * 39D2 EC 06          l.
           CLRA                                                         * 39D4 4F             O
           ANDB   #32                                                   * 39D5 C4 20          D
           BNE    L39F6                                                 * 39D7 26 1D          &.
L39D9      LDD    ,S                                                    * 39D9 EC E4          ld
           ADDD   #1                                                    * 39DB C3 00 01       C..
           STD    ,S                                                    * 39DE ED E4          md
           SUBD   #1                                                    * 39E0 83 00 01       ...
           CMPD   10,S                                                  * 39E3 10 A3 6A       .#j
           BLT    L39C2                                                 * 39E6 2D DA          -Z
           LDD    2,S                                                   * 39E8 EC 62          lb
           ADDD   #1                                                    * 39EA C3 00 01       C..
L39ED      STD    2,S                                                   * 39ED ED 62          mb
           LDD    2,S                                                   * 39EF EC 62          lb
           CMPD   12,S                                                  * 39F1 10 A3 6C       .#l
           BLT    L39BC                                                 * 39F4 2D C6          -F
L39F6      LDD    2,S                                                   * 39F6 EC 62          lb
           LEAS   4,S                                                   * 39F8 32 64          2d
           PULS   PC,U                                                  * 39FA 35 C0          5@
L39FC      PSHS   U                                                     * 39FC 34 40          4@
           LEAX   >Y0496,Y                                              * 39FE 30 A9 04 96    0)..
           STX    >Y09A7,Y                                              * 3A02 AF A9 09 A7    /).'
           LEAX   6,S                                                   * 3A06 30 66          0f
           PSHS   X                                                     * 3A08 34 10          4.
           LDD    6,S                                                   * 3A0A EC 66          lf
           BRA    L3A1C                                                 * 3A0C 20 0E           .
L3A0E      PSHS   U                                                     * 3A0E 34 40          4@
           LDD    4,S                                                   * 3A10 EC 64          ld
           STD    >Y09A7,Y                                              * 3A12 ED A9 09 A7    m).'
           LEAX   8,S                                                   * 3A16 30 68          0h
           PSHS   X                                                     * 3A18 34 10          4.
           LDD    8,S                                                   * 3A1A EC 68          lh
L3A1C      PSHS   D                                                     * 3A1C 34 06          4.
           LEAX   >L3ED6,PC                                             * 3A1E 30 8D 04 B4    0..4
           PSHS   X                                                     * 3A22 34 10          4.
           BSR    L3A4E                                                 * 3A24 8D 28          .(
           LEAS   6,S                                                   * 3A26 32 66          2f
           PULS   PC,U                                                  * 3A28 35 C0          5@
L3A2A      PSHS   U                                                     * 3A2A 34 40          4@
           LDD    4,S                                                   * 3A2C EC 64          ld
           STD    >Y09A7,Y                                              * 3A2E ED A9 09 A7    m).'
           LEAX   8,S                                                   * 3A32 30 68          0h
           PSHS   X                                                     * 3A34 34 10          4.
           LDD    8,S                                                   * 3A36 EC 68          lh
           PSHS   D                                                     * 3A38 34 06          4.
           LEAX   >L3EE9,PC                                             * 3A3A 30 8D 04 AB    0..+
           PSHS   X                                                     * 3A3E 34 10          4.
           BSR    L3A4E                                                 * 3A40 8D 0C          ..
           LEAS   6,S                                                   * 3A42 32 66          2f
           CLRA                                                         * 3A44 4F             O
           CLRB                                                         * 3A45 5F             _
           STB    [>Y09A7,Y]                                            * 3A46 E7 B9 09 A7    g9.'
           LDD    4,S                                                   * 3A4A EC 64          ld
           PULS   PC,U                                                  * 3A4C 35 C0          5@
L3A4E      PSHS   U                                                     * 3A4E 34 40          4@
           LDU    6,S                                                   * 3A50 EE 66          nf
           LEAS   -11,S                                                 * 3A52 32 75          2u
           BRA    L3A66                                                 * 3A54 20 10           .
L3A56      LDB    8,S                                                   * 3A56 E6 68          fh
           LBEQ   L3C97                                                 * 3A58 10 27 02 3B    .'.;
           LDB    8,S                                                   * 3A5C E6 68          fh
           SEX                                                          * 3A5E 1D             .
           PSHS   D                                                     * 3A5F 34 06          4.
           JSR    [<$11,S]                                              * 3A61 AD F8 11       -x.
           LEAS   2,S                                                   * 3A64 32 62          2b
L3A66      LDB    ,U+                                                   * 3A66 E6 C0          f@
           STB    8,S                                                   * 3A68 E7 68          gh
           CMPB   #37                                                   * 3A6A C1 25          A%
           BNE    L3A56                                                 * 3A6C 26 E8          &h
           LDB    ,U+                                                   * 3A6E E6 C0          f@
           STB    8,S                                                   * 3A70 E7 68          gh
           CLRA                                                         * 3A72 4F             O
           CLRB                                                         * 3A73 5F             _
           STD    2,S                                                   * 3A74 ED 62          mb
           STD    6,S                                                   * 3A76 ED 66          mf
           LDB    8,S                                                   * 3A78 E6 68          fh
           CMPB   #45                                                   * 3A7A C1 2D          A-
           BNE    L3A8B                                                 * 3A7C 26 0D          &.
           LDD    #1                                                    * 3A7E CC 00 01       L..
           STD    >Y09BD,Y                                              * 3A81 ED A9 09 BD    m).=
           LDB    ,U+                                                   * 3A85 E6 C0          f@
           STB    8,S                                                   * 3A87 E7 68          gh
           BRA    L3A91                                                 * 3A89 20 06           .
L3A8B      CLRA                                                         * 3A8B 4F             O
           CLRB                                                         * 3A8C 5F             _
           STD    >Y09BD,Y                                              * 3A8D ED A9 09 BD    m).=
L3A91      LDB    8,S                                                   * 3A91 E6 68          fh
           CMPB   #48                                                   * 3A93 C1 30          A0
           BNE    L3A9C                                                 * 3A95 26 05          &.
           LDD    #48                                                   * 3A97 CC 00 30       L.0
           BRA    L3A9F                                                 * 3A9A 20 03           .
L3A9C      LDD    #32                                                   * 3A9C CC 00 20       L.
L3A9F      STD    >Y09BF,Y                                              * 3A9F ED A9 09 BF    m).?
           BRA    L3ABF                                                 * 3AA3 20 1A           .
L3AA5      LDD    6,S                                                   * 3AA5 EC 66          lf
           PSHS   D                                                     * 3AA7 34 06          4.
           LDD    #10                                                   * 3AA9 CC 00 0A       L..
           LBSR   L466A                                                 * 3AAC 17 0B BB       ..;
           PSHS   D                                                     * 3AAF 34 06          4.
           LDB    10,S                                                  * 3AB1 E6 6A          fj
           SEX                                                          * 3AB3 1D             .
           ADDD   #-48                                                  * 3AB4 C3 FF D0       C.P
           ADDD   ,S++                                                  * 3AB7 E3 E1          ca
           STD    6,S                                                   * 3AB9 ED 66          mf
           LDB    ,U+                                                   * 3ABB E6 C0          f@
           STB    8,S                                                   * 3ABD E7 68          gh
L3ABF      LDB    8,S                                                   * 3ABF E6 68          fh
           SEX                                                          * 3AC1 1D             .
           LEAX   >Y03FC,Y                                              * 3AC2 30 A9 03 FC    0).|
           LEAX   D,X                                                   * 3AC6 30 8B          0.
           LDB    ,X                                                    * 3AC8 E6 84          f.
           CLRA                                                         * 3ACA 4F             O
           ANDB   #8                                                    * 3ACB C4 08          D.
           BNE    L3AA5                                                 * 3ACD 26 D6          &V
           LDB    8,S                                                   * 3ACF E6 68          fh
           CMPB   #46                                                   * 3AD1 C1 2E          A.
           BNE    L3B08                                                 * 3AD3 26 33          &3
           LDD    #1                                                    * 3AD5 CC 00 01       L..
           STD    4,S                                                   * 3AD8 ED 64          md
           BRA    L3AF2                                                 * 3ADA 20 16           .
L3ADC      LDD    2,S                                                   * 3ADC EC 62          lb
           PSHS   D                                                     * 3ADE 34 06          4.
           LDD    #10                                                   * 3AE0 CC 00 0A       L..
           LBSR   L466A                                                 * 3AE3 17 0B 84       ...
           PSHS   D                                                     * 3AE6 34 06          4.
           LDB    10,S                                                  * 3AE8 E6 6A          fj
           SEX                                                          * 3AEA 1D             .
           ADDD   #-48                                                  * 3AEB C3 FF D0       C.P
           ADDD   ,S++                                                  * 3AEE E3 E1          ca
           STD    2,S                                                   * 3AF0 ED 62          mb
L3AF2      LDB    ,U+                                                   * 3AF2 E6 C0          f@
           STB    8,S                                                   * 3AF4 E7 68          gh
           LDB    8,S                                                   * 3AF6 E6 68          fh
           SEX                                                          * 3AF8 1D             .
           LEAX   >Y03FC,Y                                              * 3AF9 30 A9 03 FC    0).|
           LEAX   D,X                                                   * 3AFD 30 8B          0.
           LDB    ,X                                                    * 3AFF E6 84          f.
           CLRA                                                         * 3B01 4F             O
           ANDB   #8                                                    * 3B02 C4 08          D.
           BNE    L3ADC                                                 * 3B04 26 D6          &V
           BRA    L3B0C                                                 * 3B06 20 04           .
L3B08      CLRA                                                         * 3B08 4F             O
           CLRB                                                         * 3B09 5F             _
           STD    4,S                                                   * 3B0A ED 64          md
L3B0C      LDB    8,S                                                   * 3B0C E6 68          fh
           SEX                                                          * 3B0E 1D             .
           TFR    D,X                                                   * 3B0F 1F 01          ..
           LBRA   L3C3A                                                 * 3B11 16 01 26       ..&
L3B14      LDD    6,S                                                   * 3B14 EC 66          lf
           PSHS   D                                                     * 3B16 34 06          4.
           LDX    <$15,S                                                * 3B18 AE E8 15       .h.
           LEAX   2,X                                                   * 3B1B 30 02          0.
           STX    <$15,S                                                * 3B1D AF E8 15       /h.
           LDD    -2,X                                                  * 3B20 EC 1E          l.
           PSHS   D                                                     * 3B22 34 06          4.
           LBSR   L3C9B                                                 * 3B24 17 01 74       ..t
           BRA    L3B3C                                                 * 3B27 20 13           .
L3B29      LDD    6,S                                                   * 3B29 EC 66          lf
           PSHS   D                                                     * 3B2B 34 06          4.
           LDX    <$15,S                                                * 3B2D AE E8 15       .h.
           LEAX   2,X                                                   * 3B30 30 02          0.
           STX    <$15,S                                                * 3B32 AF E8 15       /h.
           LDD    -2,X                                                  * 3B35 EC 1E          l.
           PSHS   D                                                     * 3B37 34 06          4.
           LBSR   L3D5C                                                 * 3B39 17 02 20       ..
L3B3C      STD    ,S                                                    * 3B3C ED E4          md
           LBRA   L3C20                                                 * 3B3E 16 00 DF       .._
L3B41      LDD    6,S                                                   * 3B41 EC 66          lf
           PSHS   D                                                     * 3B43 34 06          4.
           LDB    10,S                                                  * 3B45 E6 6A          fj
           SEX                                                          * 3B47 1D             .
           LEAX   >Y03FC,Y                                              * 3B48 30 A9 03 FC    0).|
           LEAX   D,X                                                   * 3B4C 30 8B          0.
           LDB    ,X                                                    * 3B4E E6 84          f.
           CLRA                                                         * 3B50 4F             O
           ANDB   #2                                                    * 3B51 C4 02          D.
           PSHS   D                                                     * 3B53 34 06          4.
           LDX    <$17,S                                                * 3B55 AE E8 17       .h.
           LEAX   2,X                                                   * 3B58 30 02          0.
           STX    <$17,S                                                * 3B5A AF E8 17       /h.
           LDD    -2,X                                                  * 3B5D EC 1E          l.
           PSHS   D                                                     * 3B5F 34 06          4.
           LBSR   L3DA2                                                 * 3B61 17 02 3E       ..>
           LBRA   L3C1C                                                 * 3B64 16 00 B5       ..5
L3B67      LDD    6,S                                                   * 3B67 EC 66          lf
           PSHS   D                                                     * 3B69 34 06          4.
           LDX    <$15,S                                                * 3B6B AE E8 15       .h.
           LEAX   2,X                                                   * 3B6E 30 02          0.
           STX    <$15,S                                                * 3B70 AF E8 15       /h.
           LDD    -2,X                                                  * 3B73 EC 1E          l.
           PSHS   D                                                     * 3B75 34 06          4.
           LEAX   >Y09A9,Y                                              * 3B77 30 A9 09 A9    0).)
           PSHS   X                                                     * 3B7B 34 10          4.
           LBSR   L3CE3                                                 * 3B7D 17 01 63       ..c
           LBRA   L3C1C                                                 * 3B80 16 00 99       ...
L3B83      LDD    4,S                                                   * 3B83 EC 64          ld
           BNE    L3B8C                                                 * 3B85 26 05          &.
           LDD    #6                                                    * 3B87 CC 00 06       L..
           STD    2,S                                                   * 3B8A ED 62          mb
L3B8C      LDD    6,S                                                   * 3B8C EC 66          lf
           PSHS   D                                                     * 3B8E 34 06          4.
           LEAX   <$15,S                                                * 3B90 30 E8 15       0h.
           PSHS   X                                                     * 3B93 34 10          4.
           LDD    6,S                                                   * 3B95 EC 66          lf
           PSHS   D                                                     * 3B97 34 06          4.
           LDB    14,S                                                  * 3B99 E6 6E          fn
           SEX                                                          * 3B9B 1D             .
           PSHS   D                                                     * 3B9C 34 06          4.
           LBSR   L44F8                                                 * 3B9E 17 09 57       ..W
           LEAS   6,S                                                   * 3BA1 32 66          2f
           LBRA   L3C1E                                                 * 3BA3 16 00 78       ..x
L3BA6      LDX    <$13,S                                                * 3BA6 AE E8 13       .h.
           LEAX   2,X                                                   * 3BA9 30 02          0.
           STX    <$13,S                                                * 3BAB AF E8 13       /h.
           LDD    -2,X                                                  * 3BAE EC 1E          l.
           LBRA   L3C30                                                 * 3BB0 16 00 7D       ..}
L3BB3      LDX    <$13,S                                                * 3BB3 AE E8 13       .h.
           LEAX   2,X                                                   * 3BB6 30 02          0.
           STX    <$13,S                                                * 3BB8 AF E8 13       /h.
           LDD    -2,X                                                  * 3BBB EC 1E          l.
           STD    9,S                                                   * 3BBD ED 69          mi
           LDD    4,S                                                   * 3BBF EC 64          ld
           BEQ    L3BFB                                                 * 3BC1 27 38          '8
           LDD    9,S                                                   * 3BC3 EC 69          li
           STD    4,S                                                   * 3BC5 ED 64          md
           BRA    L3BD5                                                 * 3BC7 20 0C           .
L3BC9      LDB    [<$09,S]                                              * 3BC9 E6 F8 09       fx.
           BEQ    L3BE1                                                 * 3BCC 27 13          '.
           LDD    9,S                                                   * 3BCE EC 69          li
           ADDD   #1                                                    * 3BD0 C3 00 01       C..
           STD    9,S                                                   * 3BD3 ED 69          mi
L3BD5      LDD    2,S                                                   * 3BD5 EC 62          lb
           ADDD   #-1                                                   * 3BD7 C3 FF FF       C..
           STD    2,S                                                   * 3BDA ED 62          mb
           SUBD   #-1                                                   * 3BDC 83 FF FF       ...
           BNE    L3BC9                                                 * 3BDF 26 E8          &h
L3BE1      LDD    6,S                                                   * 3BE1 EC 66          lf
           PSHS   D                                                     * 3BE3 34 06          4.
           LDD    11,S                                                  * 3BE5 EC 6B          lk
           SUBD   6,S                                                   * 3BE7 A3 66          #f
           PSHS   D                                                     * 3BE9 34 06          4.
           LDD    8,S                                                   * 3BEB EC 68          lh
           PSHS   D                                                     * 3BED 34 06          4.
           LDD    <$15,S                                                * 3BEF EC E8 15       lh.
           PSHS   D                                                     * 3BF2 34 06          4.
           LBSR   L3E0D                                                 * 3BF4 17 02 16       ...
           LEAS   8,S                                                   * 3BF7 32 68          2h
           BRA    L3C2A                                                 * 3BF9 20 2F           /
L3BFB      LDD    6,S                                                   * 3BFB EC 66          lf
           PSHS   D                                                     * 3BFD 34 06          4.
           LDD    11,S                                                  * 3BFF EC 6B          lk
           BRA    L3C1E                                                 * 3C01 20 1B           .
L3C03      LDB    ,U+                                                   * 3C03 E6 C0          f@
           STB    8,S                                                   * 3C05 E7 68          gh
           BRA    L3C0B                                                 * 3C07 20 02           .
           LEAS   -11,X                                                 * 3C09 32 15          2.
L3C0B      LDD    6,S                                                   * 3C0B EC 66          lf
           PSHS   D                                                     * 3C0D 34 06          4.
           LEAX   <$15,S                                                * 3C0F 30 E8 15       0h.
           PSHS   X                                                     * 3C12 34 10          4.
           LDB    12,S                                                  * 3C14 E6 6C          fl
           SEX                                                          * 3C16 1D             .
           PSHS   D                                                     * 3C17 34 06          4.
           LBSR   L44BA                                                 * 3C19 17 08 9E       ...
L3C1C      LEAS   4,S                                                   * 3C1C 32 64          2d
L3C1E      PSHS   D                                                     * 3C1E 34 06          4.
L3C20      LDD    <$13,S                                                * 3C20 EC E8 13       lh.
           PSHS   D                                                     * 3C23 34 06          4.
           LBSR   L3E6F                                                 * 3C25 17 02 47       ..G
           LEAS   6,S                                                   * 3C28 32 66          2f
L3C2A      LBRA   L3A66                                                 * 3C2A 16 FE 39       .~9
L3C2D      LDB    8,S                                                   * 3C2D E6 68          fh
           SEX                                                          * 3C2F 1D             .
L3C30      PSHS   D                                                     * 3C30 34 06          4.
           JSR    [<$11,S]                                              * 3C32 AD F8 11       -x.
           LEAS   2,S                                                   * 3C35 32 62          2b
           LBRA   L3A66                                                 * 3C37 16 FE 2C       .~,
L3C3A      CMPX   #100                                                  * 3C3A 8C 00 64       ..d
           LBEQ   L3B14                                                 * 3C3D 10 27 FE D3    .'~S
           CMPX   #111                                                  * 3C41 8C 00 6F       ..o
           LBEQ   L3B29                                                 * 3C44 10 27 FE E1    .'~a
           CMPX   #120                                                  * 3C48 8C 00 78       ..x
           LBEQ   L3B41                                                 * 3C4B 10 27 FE F2    .'~r
           CMPX   #88                                                   * 3C4F 8C 00 58       ..X
           LBEQ   L3B41                                                 * 3C52 10 27 FE EB    .'~k
           CMPX   #117                                                  * 3C56 8C 00 75       ..u
           LBEQ   L3B67                                                 * 3C59 10 27 FF 0A    .'..
           CMPX   #102                                                  * 3C5D 8C 00 66       ..f
           LBEQ   L3B83                                                 * 3C60 10 27 FF 1F    .'..
           CMPX   #101                                                  * 3C64 8C 00 65       ..e
           LBEQ   L3B83                                                 * 3C67 10 27 FF 18    .'..
           CMPX   #103                                                  * 3C6B 8C 00 67       ..g
           LBEQ   L3B83                                                 * 3C6E 10 27 FF 11    .'..
           CMPX   #69                                                   * 3C72 8C 00 45       ..E
           LBEQ   L3B83                                                 * 3C75 10 27 FF 0A    .'..
           CMPX   #71                                                   * 3C79 8C 00 47       ..G
           LBEQ   L3B83                                                 * 3C7C 10 27 FF 03    .'..
           CMPX   #99                                                   * 3C80 8C 00 63       ..c
           LBEQ   L3BA6                                                 * 3C83 10 27 FF 1F    .'..
           CMPX   #115                                                  * 3C87 8C 00 73       ..s
           LBEQ   L3BB3                                                 * 3C8A 10 27 FF 25    .'.%
           CMPX   #108                                                  * 3C8E 8C 00 6C       ..l
           LBEQ   L3C03                                                 * 3C91 10 27 FF 6E    .'.n
           BRA    L3C2D                                                 * 3C95 20 96           .
L3C97      LEAS   11,S                                                  * 3C97 32 6B          2k
           PULS   PC,U                                                  * 3C99 35 C0          5@
L3C9B      PSHS   U,D                                                   * 3C9B 34 46          4F
           LEAX   >Y09A9,Y                                              * 3C9D 30 A9 09 A9    0).)
           STX    ,S                                                    * 3CA1 AF E4          /d
           LDD    6,S                                                   * 3CA3 EC 66          lf
           BGE    L3CCF                                                 * 3CA5 2C 28          ,(
           LDD    6,S                                                   * 3CA7 EC 66          lf
           NEGA                                                         * 3CA9 40             @
           NEGB                                                         * 3CAA 50             P
           SBCA   #0                                                    * 3CAB 82 00          ..
           STD    6,S                                                   * 3CAD ED 66          mf
           BGE    L3CC4                                                 * 3CAF 2C 13          ,.
           LEAX   >L3EFB,PC                                             * 3CB1 30 8D 02 46    0..F
           PSHS   X                                                     * 3CB5 34 10          4.
           LEAX   >Y09A9,Y                                              * 3CB7 30 A9 09 A9    0).)
           PSHS   X                                                     * 3CBB 34 10          4.
           LBSR   L4514                                                 * 3CBD 17 08 54       ..T
           LEAS   4,S                                                   * 3CC0 32 64          2d
           PULS   PC,U,X                                                * 3CC2 35 D0          5P
L3CC4      LDD    #45                                                   * 3CC4 CC 00 2D       L.-
           LDX    ,S                                                    * 3CC7 AE E4          .d
           LEAX   1,X                                                   * 3CC9 30 01          0.
           STX    ,S                                                    * 3CCB AF E4          /d
           STB    -1,X                                                  * 3CCD E7 1F          g.
L3CCF      LDD    6,S                                                   * 3CCF EC 66          lf
           PSHS   D                                                     * 3CD1 34 06          4.
           LDD    2,S                                                   * 3CD3 EC 62          lb
           PSHS   D                                                     * 3CD5 34 06          4.
           BSR    L3CE3                                                 * 3CD7 8D 0A          ..
           LEAS   4,S                                                   * 3CD9 32 64          2d
           LEAX   >Y09A9,Y                                              * 3CDB 30 A9 09 A9    0).)
           TFR    X,D                                                   * 3CDF 1F 10          ..
           PULS   PC,U,X                                                * 3CE1 35 D0          5P
L3CE3      PSHS   U,Y,X,D                                               * 3CE3 34 76          4v
           LDU    10,S                                                  * 3CE5 EE 6A          nj
           CLRA                                                         * 3CE7 4F             O
           CLRB                                                         * 3CE8 5F             _
           STD    2,S                                                   * 3CE9 ED 62          mb
           CLRA                                                         * 3CEB 4F             O
           CLRB                                                         * 3CEC 5F             _
           STD    ,S                                                    * 3CED ED E4          md
           BRA    L3D00                                                 * 3CEF 20 0F           .
L3CF1      LDD    ,S                                                    * 3CF1 EC E4          ld
           ADDD   #1                                                    * 3CF3 C3 00 01       C..
           STD    ,S                                                    * 3CF6 ED E4          md
           LDD    12,S                                                  * 3CF8 EC 6C          ll
           SUBD   >Y047C,Y                                              * 3CFA A3 A9 04 7C    #).|
           STD    12,S                                                  * 3CFE ED 6C          ml
L3D00      LDD    12,S                                                  * 3D00 EC 6C          ll
           BLT    L3CF1                                                 * 3D02 2D ED          -m
           LEAX   >Y047C,Y                                              * 3D04 30 A9 04 7C    0).|
           STX    4,S                                                   * 3D08 AF 64          /d
           BRA    L3D42                                                 * 3D0A 20 36           6
L3D0C      LDD    ,S                                                    * 3D0C EC E4          ld
           ADDD   #1                                                    * 3D0E C3 00 01       C..
           STD    ,S                                                    * 3D11 ED E4          md
L3D13      LDD    12,S                                                  * 3D13 EC 6C          ll
           SUBD   [<$04,S]                                              * 3D15 A3 F8 04       #x.
           STD    12,S                                                  * 3D18 ED 6C          ml
           BGE    L3D0C                                                 * 3D1A 2C F0          ,p
           LDD    12,S                                                  * 3D1C EC 6C          ll
           ADDD   [<$04,S]                                              * 3D1E E3 F8 04       cx.
           STD    12,S                                                  * 3D21 ED 6C          ml
           LDD    ,S                                                    * 3D23 EC E4          ld
           BEQ    L3D2C                                                 * 3D25 27 05          '.
           LDD    #1                                                    * 3D27 CC 00 01       L..
           STD    2,S                                                   * 3D2A ED 62          mb
L3D2C      LDD    2,S                                                   * 3D2C EC 62          lb
           BEQ    L3D37                                                 * 3D2E 27 07          '.
           LDD    ,S                                                    * 3D30 EC E4          ld
           ADDD   #48                                                   * 3D32 C3 00 30       C.0
           STB    ,U+                                                   * 3D35 E7 C0          g@
L3D37      CLRA                                                         * 3D37 4F             O
           CLRB                                                         * 3D38 5F             _
           STD    ,S                                                    * 3D39 ED E4          md
           LDD    4,S                                                   * 3D3B EC 64          ld
           ADDD   #2                                                    * 3D3D C3 00 02       C..
           STD    4,S                                                   * 3D40 ED 64          md
L3D42      LDD    4,S                                                   * 3D42 EC 64          ld
           CMPD   >Y0484,Y                                              * 3D44 10 A3 A9 04 84 .#)..
           BNE    L3D13                                                 * 3D49 26 C8          &H
           LDD    12,S                                                  * 3D4B EC 6C          ll
           ADDD   #48                                                   * 3D4D C3 00 30       C.0
           STB    ,U+                                                   * 3D50 E7 C0          g@
           CLRA                                                         * 3D52 4F             O
           CLRB                                                         * 3D53 5F             _
           STB    ,U                                                    * 3D54 E7 C4          gD
           LDD    10,S                                                  * 3D56 EC 6A          lj
           LEAS   6,S                                                   * 3D58 32 66          2f
           PULS   PC,U                                                  * 3D5A 35 C0          5@
L3D5C      PSHS   U,D                                                   * 3D5C 34 46          4F
           LEAX   >Y09A9,Y                                              * 3D5E 30 A9 09 A9    0).)
           STX    ,S                                                    * 3D62 AF E4          /d
           LEAU   >Y09B3,Y                                              * 3D64 33 A9 09 B3    3).3
L3D68      LDD    6,S                                                   * 3D68 EC 66          lf
           CLRA                                                         * 3D6A 4F             O
           ANDB   #7                                                    * 3D6B C4 07          D.
           ADDD   #48                                                   * 3D6D C3 00 30       C.0
           STB    ,U+                                                   * 3D70 E7 C0          g@
           LDD    6,S                                                   * 3D72 EC 66          lf
           LSRA                                                         * 3D74 44             D
           RORB                                                         * 3D75 56             V
           LSRA                                                         * 3D76 44             D
           RORB                                                         * 3D77 56             V
           LSRA                                                         * 3D78 44             D
           RORB                                                         * 3D79 56             V
           STD    6,S                                                   * 3D7A ED 66          mf
           BNE    L3D68                                                 * 3D7C 26 EA          &j
           BRA    L3D8A                                                 * 3D7E 20 0A           .
L3D80      LDB    ,U                                                    * 3D80 E6 C4          fD
           LDX    ,S                                                    * 3D82 AE E4          .d
           LEAX   1,X                                                   * 3D84 30 01          0.
           STX    ,S                                                    * 3D86 AF E4          /d
           STB    -1,X                                                  * 3D88 E7 1F          g.
L3D8A      LEAU   -1,U                                                  * 3D8A 33 5F          3_
           PSHS   U                                                     * 3D8C 34 40          4@
           LEAX   >Y09B3,Y                                              * 3D8E 30 A9 09 B3    0).3
           CMPX   ,S++                                                  * 3D92 AC E1          ,a
           BLS    L3D80                                                 * 3D94 23 EA          #j
           CLRA                                                         * 3D96 4F             O
           CLRB                                                         * 3D97 5F             _
           STB    [,S]                                                  * 3D98 E7 F4          gt
           LEAX   >Y09A9,Y                                              * 3D9A 30 A9 09 A9    0).)
           TFR    X,D                                                   * 3D9E 1F 10          ..
           PULS   PC,U,X                                                * 3DA0 35 D0          5P
L3DA2      PSHS   U,X,D                                                 * 3DA2 34 56          4V
           LEAX   >Y09A9,Y                                              * 3DA4 30 A9 09 A9    0).)
           STX    2,S                                                   * 3DA8 AF 62          /b
           LEAU   >Y09B3,Y                                              * 3DAA 33 A9 09 B3    3).3
L3DAE      LDD    8,S                                                   * 3DAE EC 68          lh
           CLRA                                                         * 3DB0 4F             O
           ANDB   #15                                                   * 3DB1 C4 0F          D.
           STD    ,S                                                    * 3DB3 ED E4          md
           PSHS   D                                                     * 3DB5 34 06          4.
           LDD    2,S                                                   * 3DB7 EC 62          lb
           CMPD   #9                                                    * 3DB9 10 83 00 09    ....
           BLE    L3DD0                                                 * 3DBD 2F 11          /.
           LDD    12,S                                                  * 3DBF EC 6C          ll
           BEQ    L3DC8                                                 * 3DC1 27 05          '.
           LDD    #65                                                   * 3DC3 CC 00 41       L.A
           BRA    L3DCB                                                 * 3DC6 20 03           .
L3DC8      LDD    #97                                                   * 3DC8 CC 00 61       L.a
L3DCB      ADDD   #-10                                                  * 3DCB C3 FF F6       C.v
           BRA    L3DD3                                                 * 3DCE 20 03           .
L3DD0      LDD    #48                                                   * 3DD0 CC 00 30       L.0
L3DD3      ADDD   ,S++                                                  * 3DD3 E3 E1          ca
           STB    ,U+                                                   * 3DD5 E7 C0          g@
           LDD    8,S                                                   * 3DD7 EC 68          lh
           LSRA                                                         * 3DD9 44             D
           RORB                                                         * 3DDA 56             V
           LSRA                                                         * 3DDB 44             D
           RORB                                                         * 3DDC 56             V
           LSRA                                                         * 3DDD 44             D
           RORB                                                         * 3DDE 56             V
           LSRA                                                         * 3DDF 44             D
           RORB                                                         * 3DE0 56             V
           ANDA   #15                                                   * 3DE1 84 0F          ..
           STD    8,S                                                   * 3DE3 ED 68          mh
           BNE    L3DAE                                                 * 3DE5 26 C7          &G
           BRA    L3DF3                                                 * 3DE7 20 0A           .
L3DE9      LDB    ,U                                                    * 3DE9 E6 C4          fD
           LDX    2,S                                                   * 3DEB AE 62          .b
           LEAX   1,X                                                   * 3DED 30 01          0.
           STX    2,S                                                   * 3DEF AF 62          /b
           STB    -1,X                                                  * 3DF1 E7 1F          g.
L3DF3      LEAU   -1,U                                                  * 3DF3 33 5F          3_
           PSHS   U                                                     * 3DF5 34 40          4@
           LEAX   >Y09B3,Y                                              * 3DF7 30 A9 09 B3    0).3
           CMPX   ,S++                                                  * 3DFB AC E1          ,a
           BLS    L3DE9                                                 * 3DFD 23 EA          #j
           CLRA                                                         * 3DFF 4F             O
           CLRB                                                         * 3E00 5F             _
           STB    [<$02,S]                                              * 3E01 E7 F8 02       gx.
           LEAX   >Y09A9,Y                                              * 3E04 30 A9 09 A9    0).)
           TFR    X,D                                                   * 3E08 1F 10          ..
           LBRA   L3EE5                                                 * 3E0A 16 00 D8       ..X
L3E0D      PSHS   U                                                     * 3E0D 34 40          4@
           LDU    6,S                                                   * 3E0F EE 66          nf
           LDD    10,S                                                  * 3E11 EC 6A          lj
           SUBD   8,S                                                   * 3E13 A3 68          #h
           STD    10,S                                                  * 3E15 ED 6A          mj
           LDD    >Y09BD,Y                                              * 3E17 EC A9 09 BD    l).=
           BNE    L3E42                                                 * 3E1B 26 25          &%
           BRA    L3E2A                                                 * 3E1D 20 0B           .
L3E1F      LDD    >Y09BF,Y                                              * 3E1F EC A9 09 BF    l).?
           PSHS   D                                                     * 3E23 34 06          4.
           JSR    [<$06,S]                                              * 3E25 AD F8 06       -x.
           LEAS   2,S                                                   * 3E28 32 62          2b
L3E2A      LDD    10,S                                                  * 3E2A EC 6A          lj
           ADDD   #-1                                                   * 3E2C C3 FF FF       C..
           STD    10,S                                                  * 3E2F ED 6A          mj
           SUBD   #-1                                                   * 3E31 83 FF FF       ...
           BGT    L3E1F                                                 * 3E34 2E E9          .i
           BRA    L3E42                                                 * 3E36 20 0A           .
L3E38      LDB    ,U+                                                   * 3E38 E6 C0          f@
           SEX                                                          * 3E3A 1D             .
           PSHS   D                                                     * 3E3B 34 06          4.
           JSR    [<$06,S]                                              * 3E3D AD F8 06       -x.
           LEAS   2,S                                                   * 3E40 32 62          2b
L3E42      LDD    8,S                                                   * 3E42 EC 68          lh
           ADDD   #-1                                                   * 3E44 C3 FF FF       C..
           STD    8,S                                                   * 3E47 ED 68          mh
           SUBD   #-1                                                   * 3E49 83 FF FF       ...
           BNE    L3E38                                                 * 3E4C 26 EA          &j
           LDD    >Y09BD,Y                                              * 3E4E EC A9 09 BD    l).=
           BEQ    L3E6D                                                 * 3E52 27 19          '.
           BRA    L3E61                                                 * 3E54 20 0B           .
L3E56      LDD    >Y09BF,Y                                              * 3E56 EC A9 09 BF    l).?
           PSHS   D                                                     * 3E5A 34 06          4.
           JSR    [<$06,S]                                              * 3E5C AD F8 06       -x.
           LEAS   2,S                                                   * 3E5F 32 62          2b
L3E61      LDD    10,S                                                  * 3E61 EC 6A          lj
           ADDD   #-1                                                   * 3E63 C3 FF FF       C..
           STD    10,S                                                  * 3E66 ED 6A          mj
           SUBD   #-1                                                   * 3E68 83 FF FF       ...
           BGT    L3E56                                                 * 3E6B 2E E9          .i
L3E6D      PULS   PC,U                                                  * 3E6D 35 C0          5@
L3E6F      PSHS   U                                                     * 3E6F 34 40          4@
           LDU    6,S                                                   * 3E71 EE 66          nf
           LDD    8,S                                                   * 3E73 EC 68          lh
           PSHS   D                                                     * 3E75 34 06          4.
           PSHS   U                                                     * 3E77 34 40          4@
           LBSR   L4503                                                 * 3E79 17 06 87       ...
           LEAS   2,S                                                   * 3E7C 32 62          2b
           NEGA                                                         * 3E7E 40             @
           NEGB                                                         * 3E7F 50             P
           SBCA   #0                                                    * 3E80 82 00          ..
           ADDD   ,S++                                                  * 3E82 E3 E1          ca
           STD    8,S                                                   * 3E84 ED 68          mh
           LDD    >Y09BD,Y                                              * 3E86 EC A9 09 BD    l).=
           BNE    L3EB1                                                 * 3E8A 26 25          &%
           BRA    L3E99                                                 * 3E8C 20 0B           .
L3E8E      LDD    >Y09BF,Y                                              * 3E8E EC A9 09 BF    l).?
           PSHS   D                                                     * 3E92 34 06          4.
           JSR    [<$06,S]                                              * 3E94 AD F8 06       -x.
           LEAS   2,S                                                   * 3E97 32 62          2b
L3E99      LDD    8,S                                                   * 3E99 EC 68          lh
           ADDD   #-1                                                   * 3E9B C3 FF FF       C..
           STD    8,S                                                   * 3E9E ED 68          mh
           SUBD   #-1                                                   * 3EA0 83 FF FF       ...
           BGT    L3E8E                                                 * 3EA3 2E E9          .i
           BRA    L3EB1                                                 * 3EA5 20 0A           .
L3EA7      LDB    ,U+                                                   * 3EA7 E6 C0          f@
           SEX                                                          * 3EA9 1D             .
           PSHS   D                                                     * 3EAA 34 06          4.
           JSR    [<$06,S]                                              * 3EAC AD F8 06       -x.
           LEAS   2,S                                                   * 3EAF 32 62          2b
L3EB1      LDB    ,U                                                    * 3EB1 E6 C4          fD
           BNE    L3EA7                                                 * 3EB3 26 F2          &r
           LDD    >Y09BD,Y                                              * 3EB5 EC A9 09 BD    l).=
           BEQ    L3ED4                                                 * 3EB9 27 19          '.
           BRA    L3EC8                                                 * 3EBB 20 0B           .
L3EBD      LDD    >Y09BF,Y                                              * 3EBD EC A9 09 BF    l).?
           PSHS   D                                                     * 3EC1 34 06          4.
           JSR    [<$06,S]                                              * 3EC3 AD F8 06       -x.
           LEAS   2,S                                                   * 3EC6 32 62          2b
L3EC8      LDD    8,S                                                   * 3EC8 EC 68          lh
           ADDD   #-1                                                   * 3ECA C3 FF FF       C..
           STD    8,S                                                   * 3ECD ED 68          mh
           SUBD   #-1                                                   * 3ECF 83 FF FF       ...
           BGT    L3EBD                                                 * 3ED2 2E E9          .i
L3ED4      PULS   PC,U                                                  * 3ED4 35 C0          5@
L3ED6      PSHS   U                                                     * 3ED6 34 40          4@
           LDD    >Y09A7,Y                                              * 3ED8 EC A9 09 A7    l).'
           PSHS   D                                                     * 3EDC 34 06          4.
           LDD    6,S                                                   * 3EDE EC 66          lf
           PSHS   D                                                     * 3EE0 34 06          4.
           LBSR   L40C2                                                 * 3EE2 17 01 DD       ..]
L3EE5      LEAS   4,S                                                   * 3EE5 32 64          2d
           PULS   PC,U                                                  * 3EE7 35 C0          5@
L3EE9      PSHS   U                                                     * 3EE9 34 40          4@
           LDD    4,S                                                   * 3EEB EC 64          ld
           LDX    >Y09A7,Y                                              * 3EED AE A9 09 A7    .).'
           LEAX   1,X                                                   * 3EF1 30 01          0.
           STX    >Y09A7,Y                                              * 3EF3 AF A9 09 A7    /).'
           STB    -1,X                                                  * 3EF7 E7 1F          g.
           PULS   PC,U                                                  * 3EF9 35 C0          5@
L3EFB      FCC    "-32768"                                              * 3EFB 2D 33 32 37 36 38 -32768
           FCB    $00                                                   * 3F01 00             .
L3F02      PSHS   U                                                     * 3F02 34 40          4@
           LDU    4,S                                                   * 3F04 EE 64          nd
           LEAS   -6,S                                                  * 3F06 32 7A          2z
           CMPU   #0                                                    * 3F08 11 83 00 00    ....
           BEQ    L3F15                                                 * 3F0C 27 07          '.
           LDD    6,U                                                   * 3F0E EC 46          lF
           CLRA                                                         * 3F10 4F             O
           ANDB   #3                                                    * 3F11 C4 03          D.
           BNE    L3F1B                                                 * 3F13 26 06          &.
L3F15      LDD    #-1                                                   * 3F15 CC FF FF       L..
           LBRA   L403E                                                 * 3F18 16 01 23       ..#
L3F1B      LDD    6,U                                                   * 3F1B EC 46          lF
           ANDA   #128                                                  * 3F1D 84 80          ..
           CLRB                                                         * 3F1F 5F             _
           STD    -2,S                                                  * 3F20 ED 7E          m~
           BNE    L3F2E                                                 * 3F22 26 0A          &.
           PSHS   U                                                     * 3F24 34 40          4@
           LBSR   L442A                                                 * 3F26 17 05 01       ...
           LEAS   2,S                                                   * 3F29 32 62          2b
           LBRA   L4004                                                 * 3F2B 16 00 D6       ..V
L3F2E      LDD    6,U                                                   * 3F2E EC 46          lF
           ANDA   #1                                                    * 3F30 84 01          ..
           CLRB                                                         * 3F32 5F             _
           STD    -2,S                                                  * 3F33 ED 7E          m~
           BEQ    L3F4D                                                 * 3F35 27 16          '.
           PSHS   U                                                     * 3F37 34 40          4@
           LBSR   L41EB                                                 * 3F39 17 02 AF       ../
           LEAS   2,S                                                   * 3F3C 32 62          2b
           LDD    6,U                                                   * 3F3E EC 46          lF
           ANDA   #254                                                  * 3F40 84 FE          .~
           STD    6,U                                                   * 3F42 ED 46          mF
           LDD    2,U                                                   * 3F44 EC 42          lB
           ADDD   11,U                                                  * 3F46 E3 4B          cK
           STD    4,U                                                   * 3F48 ED 44          mD
           LBRA   L4002                                                 * 3F4A 16 00 B5       ..5
L3F4D      LDD    ,U                                                    * 3F4D EC C4          lD
           CMPD   4,U                                                   * 3F4F 10 A3 44       .#D
           LBCC   L4004                                                 * 3F52 10 24 00 AE    .$..
           LEAX   2,S                                                   * 3F56 30 62          0b
           PSHS   X                                                     * 3F58 34 10          4.
           LEAX   14,S                                                  * 3F5A 30 6E          0n
           LBSR   L4636                                                 * 3F5C 17 06 D7       ..W
           LDX    <$10,S                                                * 3F5F AE E8 10       .h.
           LBRA   L3FD1                                                 * 3F62 16 00 6C       ..l
L3F65      LEAX   2,S                                                   * 3F65 30 62          0b
           PSHS   X                                                     * 3F67 34 10          4.
           LDD    2,X                                                   * 3F69 EC 02          l.
           PSHS   D                                                     * 3F6B 34 06          4.
           LDD    ,X                                                    * 3F6D EC 84          l.
           PSHS   D                                                     * 3F6F 34 06          4.
           PSHS   U                                                     * 3F71 34 40          4@
           LBSR   L4059                                                 * 3F73 17 00 E3       ..c
           LEAS   2,S                                                   * 3F76 32 62          2b
           LBSR   L45BD                                                 * 3F78 17 06 42       ..B
           LBSR   L4636                                                 * 3F7B 17 06 B8       ..8
L3F7E      LDD    11,U                                                  * 3F7E EC 4B          lK
           LBSR   L461D                                                 * 3F80 17 06 9A       ...
           LDD    2,X                                                   * 3F83 EC 02          l.
           PSHS   D                                                     * 3F85 34 06          4.
           LDD    ,X                                                    * 3F87 EC 84          l.
           PSHS   D                                                     * 3F89 34 06          4.
           LEAX   6,S                                                   * 3F8B 30 66          0f
           LDD    2,X                                                   * 3F8D EC 02          l.
           PSHS   D                                                     * 3F8F 34 06          4.
           LDD    ,X                                                    * 3F91 EC 84          l.
           PSHS   D                                                     * 3F93 34 06          4.
           BSR    L3F9B                                                 * 3F95 8D 04          ..
           NEG    <U0000                                                * 3F97 00 00          ..
           NEG    <U0000                                                * 3F99 00 00          ..
L3F9B      PULS   X                                                     * 3F9B 35 10          5.
           LBSR   L45D2                                                 * 3F9D 17 06 32       ..2
           BGE    L3FA9                                                 * 3FA0 2C 07          ,.
           LEAX   6,S                                                   * 3FA2 30 66          0f
           LBSR   L45F6                                                 * 3FA4 17 06 4F       ..O
           BRA    L3FAB                                                 * 3FA7 20 02           .
L3FA9      LEAX   6,S                                                   * 3FA9 30 66          0f
L3FAB      LBSR   L45D2                                                 * 3FAB 17 06 24       ..$
           BLT    L3FDE                                                 * 3FAE 2D 2E          -.
           LDD    4,S                                                   * 3FB0 EC 64          ld
           ADDD   ,U                                                    * 3FB2 E3 C4          cD
           STD    ,S                                                    * 3FB4 ED E4          md
           CMPD   2,U                                                   * 3FB6 10 A3 42       .#B
           BCS    L3FDE                                                 * 3FB9 25 23          %#
           LDD    ,S                                                    * 3FBB EC E4          ld
           CMPD   4,U                                                   * 3FBD 10 A3 44       .#D
           BCC    L3FDE                                                 * 3FC0 24 1C          $.
           LDD    ,S                                                    * 3FC2 EC E4          ld
           STD    ,U                                                    * 3FC4 ED C4          mD
           LDD    6,U                                                   * 3FC6 EC 46          lF
           ANDB   #239                                                  * 3FC8 C4 EF          Do
           STD    6,U                                                   * 3FCA ED 46          mF
           LBRA   L403C                                                 * 3FCC 16 00 6D       ..m
           BRA    L3FDE                                                 * 3FCF 20 0D           .
L3FD1      STX    -2,S                                                  * 3FD1 AF 7E          /~
           LBEQ   L3F65                                                 * 3FD3 10 27 FF 8E    .'..
           CMPX   #1                                                    * 3FD7 8C 00 01       ...
           LBEQ   L3F7E                                                 * 3FDA 10 27 FF A0    .'.
L3FDE      LDD    <$10,S                                                * 3FDE EC E8 10       lh.
           CMPD   #1                                                    * 3FE1 10 83 00 01    ....
           BNE    L4000                                                 * 3FE5 26 19          &.
           LEAX   12,S                                                  * 3FE7 30 6C          0l
           PSHS   X                                                     * 3FE9 34 10          4.
           LDD    2,X                                                   * 3FEB EC 02          l.
           PSHS   D                                                     * 3FED 34 06          4.
           LDD    ,X                                                    * 3FEF EC 84          l.
           PSHS   D                                                     * 3FF1 34 06          4.
           LDD    4,U                                                   * 3FF3 EC 44          lD
           SUBD   ,U                                                    * 3FF5 A3 C4          #D
           LBSR   L461D                                                 * 3FF7 17 06 23       ..#
           LBSR   L45BD                                                 * 3FFA 17 05 C0       ..@
           LBSR   L4636                                                 * 3FFD 17 06 36       ..6
L4000      LDD    4,U                                                   * 4000 EC 44          lD
L4002      STD    ,U                                                    * 4002 ED C4          mD
L4004      LDD    6,U                                                   * 4004 EC 46          lF
           ANDB   #239                                                  * 4006 C4 EF          Do
           STD    6,U                                                   * 4008 ED 46          mF
           LDD    <$10,S                                                * 400A EC E8 10       lh.
           PSHS   D                                                     * 400D 34 06          4.
           LEAX   14,S                                                  * 400F 30 6E          0n
           LDD    2,X                                                   * 4011 EC 02          l.
           PSHS   D                                                     * 4013 34 06          4.
           LDD    ,X                                                    * 4015 EC 84          l.
           PSHS   D                                                     * 4017 34 06          4.
           LDD    8,U                                                   * 4019 EC 48          lH
           PSHS   D                                                     * 401B 34 06          4.
           LBSR   lseek                                                 * 401D 17 08 E7       ..g
           LEAS   8,S                                                   * 4020 32 68          2h
           LDD    2,X                                                   * 4022 EC 02          l.
           PSHS   D                                                     * 4024 34 06          4.
           LDD    ,X                                                    * 4026 EC 84          l.
           PSHS   D                                                     * 4028 34 06          4.
           BSR    L4030                                                 * 402A 8D 04          ..
           STU    >-1                                                   * 402C FF FF FF       ...
           FCB    $FF                                                   * 402F FF             .
L4030      PULS   X                                                     * 4030 35 10          5.
           LBSR   L45D2                                                 * 4032 17 05 9D       ...
           BNE    L403C                                                 * 4035 26 05          &.
           LDD    #-1                                                   * 4037 CC FF FF       L..
           BRA    L403E                                                 * 403A 20 02           .
L403C      CLRA                                                         * 403C 4F             O
           CLRB                                                         * 403D 5F             _
L403E      LEAS   6,S                                                   * 403E 32 66          2f
           PULS   PC,U                                                  * 4040 35 C0          5@
L4042      PSHS   U                                                     * 4042 34 40          4@
           CLRA                                                         * 4044 4F             O
           CLRB                                                         * 4045 5F             _
           PSHS   D                                                     * 4046 34 06          4.
           CLRA                                                         * 4048 4F             O
           CLRB                                                         * 4049 5F             _
           PSHS   D                                                     * 404A 34 06          4.
           PSHS   D                                                     * 404C 34 06          4.
           LDD    10,S                                                  * 404E EC 6A          lj
           PSHS   D                                                     * 4050 34 06          4.
           LBSR   L3F02                                                 * 4052 17 FE AD       .~-
           LEAS   8,S                                                   * 4055 32 68          2h
           PULS   PC,U                                                  * 4057 35 C0          5@
L4059      PSHS   U                                                     * 4059 34 40          4@
           LDU    4,S                                                   * 405B EE 64          nd
           BEQ    L4066                                                 * 405D 27 07          '.
           LDD    6,U                                                   * 405F EC 46          lF
           CLRA                                                         * 4061 4F             O
           ANDB   #3                                                    * 4062 C4 03          D.
           BNE    L4079                                                 * 4064 26 13          &.
L4066      BSR    L406C                                                 * 4066 8D 04          ..
           STU    >-1                                                   * 4068 FF FF FF       ...
           FCB    $FF                                                   * 406B FF             .
L406C      PULS   X                                                     * 406C 35 10          5.
           LEAU   >Y059B,Y                                              * 406E 33 A9 05 9B    3)..
           PSHS   U                                                     * 4072 34 40          4@
           LBSR   L4636                                                 * 4074 17 05 BF       ..?
           PULS   PC,U                                                  * 4077 35 C0          5@
L4079      LDD    6,U                                                   * 4079 EC 46          lF
           ANDA   #128                                                  * 407B 84 80          ..
           CLRB                                                         * 407D 5F             _
           STD    -2,S                                                  * 407E ED 7E          m~
           BNE    L4089                                                 * 4080 26 07          &.
           PSHS   U                                                     * 4082 34 40          4@
           LBSR   L442A                                                 * 4084 17 03 A3       ..#
           LEAS   2,S                                                   * 4087 32 62          2b
L4089      LDD    #1                                                    * 4089 CC 00 01       L..
           PSHS   D                                                     * 408C 34 06          4.
           CLRA                                                         * 408E 4F             O
           CLRB                                                         * 408F 5F             _
           PSHS   D                                                     * 4090 34 06          4.
           PSHS   D                                                     * 4092 34 06          4.
           LDD    8,U                                                   * 4094 EC 48          lH
           PSHS   D                                                     * 4096 34 06          4.
           LBSR   lseek                                                 * 4098 17 08 6C       ..l
           LEAS   8,S                                                   * 409B 32 68          2h
           LDD    2,X                                                   * 409D EC 02          l.
           PSHS   D                                                     * 409F 34 06          4.
           LDD    ,X                                                    * 40A1 EC 84          l.
           PSHS   D                                                     * 40A3 34 06          4.
           LDD    6,U                                                   * 40A5 EC 46          lF
           ANDA   #1                                                    * 40A7 84 01          ..
           CLRB                                                         * 40A9 5F             _
           STD    -2,S                                                  * 40AA ED 7E          m~
           BEQ    L40B2                                                 * 40AC 27 04          '.
           LDD    2,U                                                   * 40AE EC 42          lB
           BRA    L40B4                                                 * 40B0 20 02           .
L40B2      LDD    4,U                                                   * 40B2 EC 44          lD
L40B4      PSHS   D                                                     * 40B4 34 06          4.
           LDD    ,U                                                    * 40B6 EC C4          lD
           SUBD   ,S++                                                  * 40B8 A3 E1          #a
           LBSR   L461D                                                 * 40BA 17 05 60       ..`
           LBSR   L45A8                                                 * 40BD 17 04 E8       ..h
           PULS   PC,U                                                  * 40C0 35 C0          5@
L40C2      PSHS   U                                                     * 40C2 34 40          4@
           LDU    6,S                                                   * 40C4 EE 66          nf
           LDD    6,U                                                   * 40C6 EC 46          lF
           ANDA   #128                                                  * 40C8 84 80          ..
           ANDB   #34                                                   * 40CA C4 22          D"
           CMPD   #-32766                                               * 40CC 10 83 80 02    ....
           BEQ    L40E6                                                 * 40D0 27 14          '.
           LDD    6,U                                                   * 40D2 EC 46          lF
           CLRA                                                         * 40D4 4F             O
           ANDB   #34                                                   * 40D5 C4 22          D"
           CMPD   #2                                                    * 40D7 10 83 00 02    ....
           LBNE   L41FC                                                 * 40DB 10 26 01 1D    .&..
           PSHS   U                                                     * 40DF 34 40          4@
           LBSR   L442A                                                 * 40E1 17 03 46       ..F
           LEAS   2,S                                                   * 40E4 32 62          2b
L40E6      LDD    6,U                                                   * 40E6 EC 46          lF
           CLRA                                                         * 40E8 4F             O
           ANDB   #4                                                    * 40E9 C4 04          D.
           BEQ    L4122                                                 * 40EB 27 35          '5
           LDD    #1                                                    * 40ED CC 00 01       L..
           PSHS   D                                                     * 40F0 34 06          4.
           LEAX   7,S                                                   * 40F2 30 67          0g
           PSHS   X                                                     * 40F4 34 10          4.
           LDD    8,U                                                   * 40F6 EC 48          lH
           PSHS   D                                                     * 40F8 34 06          4.
           LDD    6,U                                                   * 40FA EC 46          lF
           CLRA                                                         * 40FC 4F             O
           ANDB   #64                                                   * 40FD C4 40          D@
           BEQ    L4107                                                 * 40FF 27 06          '.
           LEAX   >L48F7,PC                                             * 4101 30 8D 07 F2    0..r
           BRA    L410B                                                 * 4105 20 04           .
L4107      LEAX   >L48DE,PC                                             * 4107 30 8D 07 D3    0..S
L410B      TFR    X,D                                                   * 410B 1F 10          ..
           TFR    D,X                                                   * 410D 1F 01          ..
           JSR    ,X                                                    * 410F AD 84          -.
           LEAS   6,S                                                   * 4111 32 66          2f
           CMPD   #-1                                                   * 4113 10 83 FF FF    ....
           BNE    L4163                                                 * 4117 26 4A          &J
           LDD    6,U                                                   * 4119 EC 46          lF
           ORB    #32                                                   * 411B CA 20          J
           STD    6,U                                                   * 411D ED 46          mF
           LBRA   L41FC                                                 * 411F 16 00 DA       ..Z
L4122      LDD    6,U                                                   * 4122 EC 46          lF
           ANDA   #1                                                    * 4124 84 01          ..
           CLRB                                                         * 4126 5F             _
           STD    -2,S                                                  * 4127 ED 7E          m~
           BNE    L4132                                                 * 4129 26 07          &.
           PSHS   U                                                     * 412B 34 40          4@
           LBSR   L4217                                                 * 412D 17 00 E7       ..g
           LEAS   2,S                                                   * 4130 32 62          2b
L4132      LDD    ,U                                                    * 4132 EC C4          lD
           ADDD   #1                                                    * 4134 C3 00 01       C..
           STD    ,U                                                    * 4137 ED C4          mD
           SUBD   #1                                                    * 4139 83 00 01       ...
           TFR    D,X                                                   * 413C 1F 01          ..
           LDD    4,S                                                   * 413E EC 64          ld
           STB    ,X                                                    * 4140 E7 84          g.
           LDD    ,U                                                    * 4142 EC C4          lD
           CMPD   4,U                                                   * 4144 10 A3 44       .#D
           BCC    L4158                                                 * 4147 24 0F          $.
           LDD    6,U                                                   * 4149 EC 46          lF
           CLRA                                                         * 414B 4F             O
           ANDB   #64                                                   * 414C C4 40          D@
           BEQ    L4163                                                 * 414E 27 13          '.
           LDD    4,S                                                   * 4150 EC 64          ld
           CMPD   #13                                                   * 4152 10 83 00 0D    ....
           BNE    L4163                                                 * 4156 26 0B          &.
L4158      PSHS   U                                                     * 4158 34 40          4@
           LBSR   L4217                                                 * 415A 17 00 BA       ..:
           STD    ,S++                                                  * 415D ED E1          ma
           LBNE   L41FC                                                 * 415F 10 26 00 99    .&..
L4163      LDD    4,S                                                   * 4163 EC 64          ld
           PULS   PC,U                                                  * 4165 35 C0          5@
           PSHS   U                                                     * 4167 34 40          4@
           LDU    4,S                                                   * 4169 EE 64          nd
           LDD    6,S                                                   * 416B EC 66          lf
           PSHS   D                                                     * 416D 34 06          4.
           PSHS   U                                                     * 416F 34 40          4@
           LDD    #8                                                    * 4171 CC 00 08       L..
           LBSR   L4794                                                 * 4174 17 06 1D       ...
           PSHS   D                                                     * 4177 34 06          4.
           LBSR   L40C2                                                 * 4179 17 FF 46       ..F
           LEAS   4,S                                                   * 417C 32 64          2d
           LDD    6,S                                                   * 417E EC 66          lf
           PSHS   D                                                     * 4180 34 06          4.
           PSHS   U                                                     * 4182 34 40          4@
           LBSR   L40C2                                                 * 4184 17 FF 3B       ..;
           LBRA   L42D1                                                 * 4187 16 01 47       ..G
_tidyup    PSHS   U,D                                                   * 418A 34 46          4F
           LEAU   >_iob,Y                                               * 418C 33 A9 04 89    3)..
           CLRA                                                         * 4190 4F             O
           CLRB                                                         * 4191 5F             _
           STD    ,S                                                    * 4192 ED E4          md
           BRA    L41A0                                                 * 4194 20 0A           .
L4196      TFR    U,D                                                   * 4196 1F 30          .0
           LEAU   13,U                                                  * 4198 33 4D          3M
           PSHS   D                                                     * 419A 34 06          4.
           BSR    fclose                                                * 419C 8D 14          ..
           LEAS   2,S                                                   * 419E 32 62          2b
L41A0      LDD    ,S                                                    * 41A0 EC E4          ld
           ADDD   #1                                                    * 41A2 C3 00 01       C..
           STD    ,S                                                    * 41A5 ED E4          md
           SUBD   #1                                                    * 41A7 83 00 01       ...
           CMPD   #16                                                   * 41AA 10 83 00 10    ....
           BLT    L4196                                                 * 41AE 2D E6          -f
           PULS   PC,U,X                                                * 41B0 35 D0          5P
fclose     PSHS   U                                                     * 41B2 34 40          4@
           LDU    4,S                                                   * 41B4 EE 64          nd
           LEAS   -2,S                                                  * 41B6 32 7E          2~
           CMPU   #0                                                    * 41B8 11 83 00 00    ....
           BEQ    L41C2                                                 * 41BC 27 04          '.
           LDD    6,U                                                   * 41BE EC 46          lF
           BNE    L41C7                                                 * 41C0 26 05          &.
L41C2      LDD    #-1                                                   * 41C2 CC FF FF       L..
           PULS   PC,U,X                                                * 41C5 35 D0          5P
L41C7      LDD    6,U                                                   * 41C7 EC 46          lF
           CLRA                                                         * 41C9 4F             O
           ANDB   #2                                                    * 41CA C4 02          D.
           BEQ    L41D6                                                 * 41CC 27 08          '.
           PSHS   U                                                     * 41CE 34 40          4@
           BSR    L41EB                                                 * 41D0 8D 19          ..
           LEAS   2,S                                                   * 41D2 32 62          2b
           BRA    L41D8                                                 * 41D4 20 02           .
L41D6      CLRA                                                         * 41D6 4F             O
           CLRB                                                         * 41D7 5F             _
L41D8      STD    ,S                                                    * 41D8 ED E4          md
           LDD    8,U                                                   * 41DA EC 48          lH
           PSHS   D                                                     * 41DC 34 06          4.
           LBSR   close                                                 * 41DE 17 06 63       ..c
           LEAS   2,S                                                   * 41E1 32 62          2b
           CLRA                                                         * 41E3 4F             O
           CLRB                                                         * 41E4 5F             _
           STD    6,U                                                   * 41E5 ED 46          mF
           LDD    ,S                                                    * 41E7 EC E4          ld
           PULS   PC,U,X                                                * 41E9 35 D0          5P
L41EB      PSHS   U                                                     * 41EB 34 40          4@
           LDU    4,S                                                   * 41ED EE 64          nd
           BEQ    L41FC                                                 * 41EF 27 0B          '.
           LDD    6,U                                                   * 41F1 EC 46          lF
           CLRA                                                         * 41F3 4F             O
           ANDB   #34                                                   * 41F4 C4 22          D"
           CMPD   #2                                                    * 41F6 10 83 00 02    ....
           BEQ    L4201                                                 * 41FA 27 05          '.
L41FC      LDD    #-1                                                   * 41FC CC FF FF       L..
           PULS   PC,U                                                  * 41FF 35 C0          5@
L4201      LDD    6,U                                                   * 4201 EC 46          lF
           ANDA   #128                                                  * 4203 84 80          ..
           CLRB                                                         * 4205 5F             _
           STD    -2,S                                                  * 4206 ED 7E          m~
           BNE    L4211                                                 * 4208 26 07          &.
           PSHS   U                                                     * 420A 34 40          4@
           LBSR   L442A                                                 * 420C 17 02 1B       ...
           LEAS   2,S                                                   * 420F 32 62          2b
L4211      PSHS   U                                                     * 4211 34 40          4@
           BSR    L4217                                                 * 4213 8D 02          ..
           PULS   PC,U,X                                                * 4215 35 D0          5P
L4217      PSHS   U                                                     * 4217 34 40          4@
           LDU    4,S                                                   * 4219 EE 64          nd
           LEAS   -4,S                                                  * 421B 32 7C          2|
           LDD    6,U                                                   * 421D EC 46          lF
           ANDA   #1                                                    * 421F 84 01          ..
           CLRB                                                         * 4221 5F             _
           STD    -2,S                                                  * 4222 ED 7E          m~
           BNE    L4249                                                 * 4224 26 23          &#
           LDD    ,U                                                    * 4226 EC C4          lD
           CMPD   4,U                                                   * 4228 10 A3 44       .#D
           BEQ    L4249                                                 * 422B 27 1C          '.
           CLRA                                                         * 422D 4F             O
           CLRB                                                         * 422E 5F             _
           PSHS   D                                                     * 422F 34 06          4.
           PSHS   U                                                     * 4231 34 40          4@
           LBSR   L4059                                                 * 4233 17 FE 23       .~#
           LEAS   2,S                                                   * 4236 32 62          2b
           LDD    2,X                                                   * 4238 EC 02          l.
           PSHS   D                                                     * 423A 34 06          4.
           LDD    ,X                                                    * 423C EC 84          l.
           PSHS   D                                                     * 423E 34 06          4.
           LDD    8,U                                                   * 4240 EC 48          lH
           PSHS   D                                                     * 4242 34 06          4.
           LBSR   lseek                                                 * 4244 17 06 C0       ..@
           LEAS   8,S                                                   * 4247 32 68          2h
L4249      LDD    ,U                                                    * 4249 EC C4          lD
           SUBD   2,U                                                   * 424B A3 42          #B
           STD    2,S                                                   * 424D ED 62          mb
           LBEQ   L42C1                                                 * 424F 10 27 00 6E    .'.n
           LDD    6,U                                                   * 4253 EC 46          lF
           ANDA   #1                                                    * 4255 84 01          ..
           CLRB                                                         * 4257 5F             _
           STD    -2,S                                                  * 4258 ED 7E          m~
           LBEQ   L42C1                                                 * 425A 10 27 00 63    .'.c
           LDD    6,U                                                   * 425E EC 46          lF
           CLRA                                                         * 4260 4F             O
           ANDB   #64                                                   * 4261 C4 40          D@
           BEQ    L4298                                                 * 4263 27 33          '3
           LDD    2,U                                                   * 4265 EC 42          lB
           BRA    L4290                                                 * 4267 20 27           '
L4269      LDD    2,S                                                   * 4269 EC 62          lb
           PSHS   D                                                     * 426B 34 06          4.
           LDD    ,U                                                    * 426D EC C4          lD
           PSHS   D                                                     * 426F 34 06          4.
           LDD    8,U                                                   * 4271 EC 48          lH
           PSHS   D                                                     * 4273 34 06          4.
           LBSR   L48F7                                                 * 4275 17 06 7F       ...
           LEAS   6,S                                                   * 4278 32 66          2f
           STD    ,S                                                    * 427A ED E4          md
           CMPD   #-1                                                   * 427C 10 83 FF FF    ....
           BNE    L4286                                                 * 4280 26 04          &.
           LEAX   4,S                                                   * 4282 30 64          0d
           BRA    L42B0                                                 * 4284 20 2A           *
L4286      LDD    2,S                                                   * 4286 EC 62          lb
           SUBD   ,S                                                    * 4288 A3 E4          #d
           STD    2,S                                                   * 428A ED 62          mb
           LDD    ,U                                                    * 428C EC C4          lD
           ADDD   ,S                                                    * 428E E3 E4          cd
L4290      STD    ,U                                                    * 4290 ED C4          mD
           LDD    2,S                                                   * 4292 EC 62          lb
           BNE    L4269                                                 * 4294 26 D3          &S
           BRA    L42C1                                                 * 4296 20 29           )
L4298      LDD    2,S                                                   * 4298 EC 62          lb
           PSHS   D                                                     * 429A 34 06          4.
           LDD    2,U                                                   * 429C EC 42          lB
           PSHS   D                                                     * 429E 34 06          4.
           LDD    8,U                                                   * 42A0 EC 48          lH
           PSHS   D                                                     * 42A2 34 06          4.
           LBSR   L48DE                                                 * 42A4 17 06 37       ..7
           LEAS   6,S                                                   * 42A7 32 66          2f
           CMPD   2,S                                                   * 42A9 10 A3 62       .#b
           BEQ    L42C1                                                 * 42AC 27 13          '.
           BRA    L42B2                                                 * 42AE 20 02           .
L42B0      LEAS   -4,X                                                  * 42B0 32 1C          2.
L42B2      LDD    6,U                                                   * 42B2 EC 46          lF
           ORB    #32                                                   * 42B4 CA 20          J
           STD    6,U                                                   * 42B6 ED 46          mF
           LDD    4,U                                                   * 42B8 EC 44          lD
           STD    ,U                                                    * 42BA ED C4          mD
           LDD    #-1                                                   * 42BC CC FF FF       L..
           BRA    L42D1                                                 * 42BF 20 10           .
L42C1      LDD    6,U                                                   * 42C1 EC 46          lF
           ORA    #1                                                    * 42C3 8A 01          ..
           STD    6,U                                                   * 42C5 ED 46          mF
           LDD    2,U                                                   * 42C7 EC 42          lB
           STD    ,U                                                    * 42C9 ED C4          mD
           ADDD   11,U                                                  * 42CB E3 4B          cK
           STD    4,U                                                   * 42CD ED 44          mD
           CLRA                                                         * 42CF 4F             O
           CLRB                                                         * 42D0 5F             _
L42D1      LEAS   4,S                                                   * 42D1 32 64          2d
           PULS   PC,U                                                  * 42D3 35 C0          5@
L42D5      PSHS   U                                                     * 42D5 34 40          4@
           LDU    4,S                                                   * 42D7 EE 64          nd
           BEQ    L4321                                                 * 42D9 27 46          'F
           LDD    6,U                                                   * 42DB EC 46          lF
           ANDA   #1                                                    * 42DD 84 01          ..
           CLRB                                                         * 42DF 5F             _
           STD    -2,S                                                  * 42E0 ED 7E          m~
           BNE    L4321                                                 * 42E2 26 3D          &=
           LDD    ,U                                                    * 42E4 EC C4          lD
           CMPD   4,U                                                   * 42E6 10 A3 44       .#D
           BCC    L42FC                                                 * 42E9 24 11          $.
           LDD    ,U                                                    * 42EB EC C4          lD
           ADDD   #1                                                    * 42ED C3 00 01       C..
           STD    ,U                                                    * 42F0 ED C4          mD
           SUBD   #1                                                    * 42F2 83 00 01       ...
           TFR    D,X                                                   * 42F5 1F 01          ..
           LDB    ,X                                                    * 42F7 E6 84          f.
           CLRA                                                         * 42F9 4F             O
           BRA    L4303                                                 * 42FA 20 07           .
L42FC      PSHS   U                                                     * 42FC 34 40          4@
           LBSR   L4370                                                 * 42FE 17 00 6F       ..o
           LEAS   2,S                                                   * 4301 32 62          2b
L4303      PULS   PC,U                                                  * 4303 35 C0          5@
           PSHS   U                                                     * 4305 34 40          4@
           LDU    6,S                                                   * 4307 EE 66          nf
           BEQ    L4321                                                 * 4309 27 16          '.
           LDD    6,U                                                   * 430B EC 46          lF
           CLRA                                                         * 430D 4F             O
           ANDB   #1                                                    * 430E C4 01          D.
           BEQ    L4321                                                 * 4310 27 0F          '.
           LDD    4,S                                                   * 4312 EC 64          ld
           CMPD   #-1                                                   * 4314 10 83 FF FF    ....
           BEQ    L4321                                                 * 4318 27 07          '.
           LDD    ,U                                                    * 431A EC C4          lD
           CMPD   2,U                                                   * 431C 10 A3 42       .#B
           BHI    L4326                                                 * 431F 22 05          ".
L4321      LDD    #-1                                                   * 4321 CC FF FF       L..
           PULS   PC,U                                                  * 4324 35 C0          5@
L4326      LDD    ,U                                                    * 4326 EC C4          lD
           ADDD   #-1                                                   * 4328 C3 FF FF       C..
           STD    ,U                                                    * 432B ED C4          mD
           TFR    D,X                                                   * 432D 1F 01          ..
           LDD    4,S                                                   * 432F EC 64          ld
           STB    ,X                                                    * 4331 E7 84          g.
           LDD    4,S                                                   * 4333 EC 64          ld
           PULS   PC,U                                                  * 4335 35 C0          5@
           PSHS   U                                                     * 4337 34 40          4@
           LDU    4,S                                                   * 4339 EE 64          nd
           LEAS   -4,S                                                  * 433B 32 7C          2|
           PSHS   U                                                     * 433D 34 40          4@
           LBSR   L42D5                                                 * 433F 17 FF 93       ...
           LEAS   2,S                                                   * 4342 32 62          2b
           STD    2,S                                                   * 4344 ED 62          mb
           CMPD   #-1                                                   * 4346 10 83 FF FF    ....
           BEQ    L435B                                                 * 434A 27 0F          '.
           PSHS   U                                                     * 434C 34 40          4@
           LBSR   L42D5                                                 * 434E 17 FF 84       ...
           LEAS   2,S                                                   * 4351 32 62          2b
           STD    ,S                                                    * 4353 ED E4          md
           CMPD   #-1                                                   * 4355 10 83 FF FF    ....
           BNE    L4360                                                 * 4359 26 05          &.
L435B      LDD    #-1                                                   * 435B CC FF FF       L..
           BRA    L436C                                                 * 435E 20 0C           .
L4360      LDD    2,S                                                   * 4360 EC 62          lb
           PSHS   D                                                     * 4362 34 06          4.
           LDD    #8                                                    * 4364 CC 00 08       L..
           LBSR   L47AB                                                 * 4367 17 04 41       ..A
           ADDD   ,S                                                    * 436A E3 E4          cd
L436C      LEAS   4,S                                                   * 436C 32 64          2d
           PULS   PC,U                                                  * 436E 35 C0          5@
L4370      PSHS   U                                                     * 4370 34 40          4@
           LDU    4,S                                                   * 4372 EE 64          nd
           LEAS   -2,S                                                  * 4374 32 7E          2~
           LDD    6,U                                                   * 4376 EC 46          lF
           ANDA   #128                                                  * 4378 84 80          ..
           ANDB   #49                                                   * 437A C4 31          D1
           CMPD   #-32767                                               * 437C 10 83 80 01    ....
           BEQ    L4399                                                 * 4380 27 17          '.
           LDD    6,U                                                   * 4382 EC 46          lF
           CLRA                                                         * 4384 4F             O
           ANDB   #49                                                   * 4385 C4 31          D1
           CMPD   #1                                                    * 4387 10 83 00 01    ....
           BEQ    L4392                                                 * 438B 27 05          '.
           LDD    #-1                                                   * 438D CC FF FF       L..
           PULS   PC,U,X                                                * 4390 35 D0          5P
L4392      PSHS   U                                                     * 4392 34 40          4@
           LBSR   L442A                                                 * 4394 17 00 93       ...
           LEAS   2,S                                                   * 4397 32 62          2b
L4399      LEAX   >_iob,Y                                               * 4399 30 A9 04 89    0)..
           PSHS   X                                                     * 439D 34 10          4.
           CMPU   ,S++                                                  * 439F 11 A3 E1       .#a
           BNE    L43B6                                                 * 43A2 26 12          &.
           LDD    6,U                                                   * 43A4 EC 46          lF
           CLRA                                                         * 43A6 4F             O
           ANDB   #64                                                   * 43A7 C4 40          D@
           BEQ    L43B6                                                 * 43A9 27 0B          '.
           LEAX   >Y0496,Y                                              * 43AB 30 A9 04 96    0)..
           PSHS   X                                                     * 43AF 34 10          4.
           LBSR   L41EB                                                 * 43B1 17 FE 37       .~7
           LEAS   2,S                                                   * 43B4 32 62          2b
L43B6      LDD    6,U                                                   * 43B6 EC 46          lF
           CLRA                                                         * 43B8 4F             O
           ANDB   #8                                                    * 43B9 C4 08          D.
           BEQ    L43E2                                                 * 43BB 27 25          '%
           LDD    11,U                                                  * 43BD EC 4B          lK
           PSHS   D                                                     * 43BF 34 06          4.
           LDD    2,U                                                   * 43C1 EC 42          lB
           PSHS   D                                                     * 43C3 34 06          4.
           LDD    8,U                                                   * 43C5 EC 48          lH
           PSHS   D                                                     * 43C7 34 06          4.
           LDD    6,U                                                   * 43C9 EC 46          lF
           CLRA                                                         * 43CB 4F             O
           ANDB   #64                                                   * 43CC C4 40          D@
           BEQ    L43D6                                                 * 43CE 27 06          '.
           LEAX   >L48CE,PC                                             * 43D0 30 8D 04 FA    0..z
           BRA    L43DA                                                 * 43D4 20 04           .
L43D6      LEAX   >L48AD,PC                                             * 43D6 30 8D 04 D3    0..S
L43DA      TFR    X,D                                                   * 43DA 1F 10          ..
           TFR    D,X                                                   * 43DC 1F 01          ..
           JSR    ,X                                                    * 43DE AD 84          -.
           BRA    L43F4                                                 * 43E0 20 12           .
L43E2      LDD    #1                                                    * 43E2 CC 00 01       L..
           PSHS   D                                                     * 43E5 34 06          4.
           LEAX   10,U                                                  * 43E7 30 4A          0J
           STX    2,U                                                   * 43E9 AF 42          /B
           PSHS   X                                                     * 43EB 34 10          4.
           LDD    8,U                                                   * 43ED EC 48          lH
           PSHS   D                                                     * 43EF 34 06          4.
           LBSR   L48AD                                                 * 43F1 17 04 B9       ..9
L43F4      LEAS   6,S                                                   * 43F4 32 66          2f
           STD    ,S                                                    * 43F6 ED E4          md
           LDD    ,S                                                    * 43F8 EC E4          ld
           BGT    L4417                                                 * 43FA 2E 1B          ..
           LDD    6,U                                                   * 43FC EC 46          lF
           PSHS   D                                                     * 43FE 34 06          4.
           LDD    2,S                                                   * 4400 EC 62          lb
           BEQ    L4409                                                 * 4402 27 05          '.
           LDD    #32                                                   * 4404 CC 00 20       L.
           BRA    L440C                                                 * 4407 20 03           .
L4409      LDD    #16                                                   * 4409 CC 00 10       L..
L440C      ORA    ,S+                                                   * 440C AA E0          *`
           ORB    ,S+                                                   * 440E EA E0          j`
           STD    6,U                                                   * 4410 ED 46          mF
           LDD    #-1                                                   * 4412 CC FF FF       L..
           PULS   PC,U,X                                                * 4415 35 D0          5P
L4417      LDD    2,U                                                   * 4417 EC 42          lB
           ADDD   #1                                                    * 4419 C3 00 01       C..
           STD    ,U                                                    * 441C ED C4          mD
           LDD    2,U                                                   * 441E EC 42          lB
           ADDD   ,S                                                    * 4420 E3 E4          cd
           STD    4,U                                                   * 4422 ED 44          mD
           LDB    [<$02,U]                                              * 4424 E6 D8 02       fX.
           CLRA                                                         * 4427 4F             O
           PULS   PC,U,X                                                * 4428 35 D0          5P
L442A      PSHS   U                                                     * 442A 34 40          4@
           LDU    4,S                                                   * 442C EE 64          nd
           LDD    6,U                                                   * 442E EC 46          lF
           CLRA                                                         * 4430 4F             O
           ANDB   #192                                                  * 4431 C4 C0          D@
           BNE    L4462                                                 * 4433 26 2D          &-
           LEAS   <-$20,S                                               * 4435 32 E8 E0       2h`
           LEAX   ,S                                                    * 4438 30 E4          0d
           PSHS   X                                                     * 443A 34 10          4.
           LDD    8,U                                                   * 443C EC 48          lH
           PSHS   D                                                     * 443E 34 06          4.
           CLRA                                                         * 4440 4F             O
           CLRB                                                         * 4441 5F             _
           PSHS   D                                                     * 4442 34 06          4.
           LBSR   L47C6                                                 * 4444 17 03 7F       ...
           LEAS   6,S                                                   * 4447 32 66          2f
           LDD    6,U                                                   * 4449 EC 46          lF
           PSHS   D                                                     * 444B 34 06          4.
           LDB    2,S                                                   * 444D E6 62          fb
           BNE    L4456                                                 * 444F 26 05          &.
           LDD    #64                                                   * 4451 CC 00 40       L.@
           BRA    L4459                                                 * 4454 20 03           .
L4456      LDD    #128                                                  * 4456 CC 00 80       L..
L4459      ORA    ,S+                                                   * 4459 AA E0          *`
           ORB    ,S+                                                   * 445B EA E0          j`
           STD    6,U                                                   * 445D ED 46          mF
           LEAS   <$20,S                                                * 445F 32 E8 20       2h
L4462      LDD    6,U                                                   * 4462 EC 46          lF
           ORA    #128                                                  * 4464 8A 80          ..
           STD    6,U                                                   * 4466 ED 46          mF
           CLRA                                                         * 4468 4F             O
           ANDB   #12                                                   * 4469 C4 0C          D.
           BEQ    L446F                                                 * 446B 27 02          '.
           PULS   PC,U                                                  * 446D 35 C0          5@
L446F      LDD    11,U                                                  * 446F EC 4B          lK
           BNE    L4484                                                 * 4471 26 11          &.
           LDD    6,U                                                   * 4473 EC 46          lF
           CLRA                                                         * 4475 4F             O
           ANDB   #64                                                   * 4476 C4 40          D@
           BEQ    L447F                                                 * 4478 27 05          '.
           LDD    #128                                                  * 447A CC 00 80       L..
           BRA    L4482                                                 * 447D 20 03           .
L447F      LDD    #256                                                  * 447F CC 01 00       L..
L4482      STD    11,U                                                  * 4482 ED 4B          mK
L4484      LDD    2,U                                                   * 4484 EC 42          lB
           BNE    L4499                                                 * 4486 26 11          &.
           LDD    11,U                                                  * 4488 EC 4B          lK
           PSHS   D                                                     * 448A 34 06          4.
           LBSR   L49C5                                                 * 448C 17 05 36       ..6
           LEAS   2,S                                                   * 448F 32 62          2b
           STD    2,U                                                   * 4491 ED 42          mB
           CMPD   #-1                                                   * 4493 10 83 FF FF    ....
           BEQ    L44A1                                                 * 4497 27 08          '.
L4499      LDD    6,U                                                   * 4499 EC 46          lF
           ORB    #8                                                    * 449B CA 08          J.
           STD    6,U                                                   * 449D ED 46          mF
           BRA    L44B0                                                 * 449F 20 0F           .
L44A1      LDD    6,U                                                   * 44A1 EC 46          lF
           ORB    #4                                                    * 44A3 CA 04          J.
           STD    6,U                                                   * 44A5 ED 46          mF
           LEAX   10,U                                                  * 44A7 30 4A          0J
           STX    2,U                                                   * 44A9 AF 42          /B
           LDD    #1                                                    * 44AB CC 00 01       L..
           STD    11,U                                                  * 44AE ED 4B          mK
L44B0      LDD    2,U                                                   * 44B0 EC 42          lB
           ADDD   11,U                                                  * 44B2 E3 4B          cK
           STD    4,U                                                   * 44B4 ED 44          mD
           STD    ,U                                                    * 44B6 ED C4          mD
           PULS   PC,U                                                  * 44B8 35 C0          5@
L44BA      PSHS   U                                                     * 44BA 34 40          4@
           LDB    5,S                                                   * 44BC E6 65          fe
           SEX                                                          * 44BE 1D             .
           TFR    D,X                                                   * 44BF 1F 01          ..
           BRA    L44E0                                                 * 44C1 20 1D           .
L44C3      LDD    [<$06,S]                                              * 44C3 EC F8 06       lx.
           ADDD   #4                                                    * 44C6 C3 00 04       C..
           STD    [<$06,S]                                              * 44C9 ED F8 06       mx.
           LEAX   >L44F7,PC                                             * 44CC 30 8D 00 27    0..'
           BRA    L44DC                                                 * 44D0 20 0A           .
L44D2      LDB    5,S                                                   * 44D2 E6 65          fe
           STB    >Y0487,Y                                              * 44D4 E7 A9 04 87    g)..
           LEAX   >Y0486,Y                                              * 44D8 30 A9 04 86    0)..
L44DC      TFR    X,D                                                   * 44DC 1F 10          ..
           PULS   PC,U                                                  * 44DE 35 C0          5@
L44E0      CMPX   #100                                                  * 44E0 8C 00 64       ..d
           BEQ    L44C3                                                 * 44E3 27 DE          '^
           CMPX   #111                                                  * 44E5 8C 00 6F       ..o
           LBEQ   L44C3                                                 * 44E8 10 27 FF D7    .'.W
           CMPX   #120                                                  * 44EC 8C 00 78       ..x
           LBEQ   L44C3                                                 * 44EF 10 27 FF D0    .'.P
           BRA    L44D2                                                 * 44F3 20 DD           ]
           PULS   PC,U                                                  * 44F5 35 C0          5@
L44F7      FCB    $00                                                   * 44F7 00             .
L44F8      PSHS   U                                                     * 44F8 34 40          4@
           LEAX   >L4502,PC                                             * 44FA 30 8D 00 04    0...
           TFR    X,D                                                   * 44FE 1F 10          ..
           PULS   PC,U                                                  * 4500 35 C0          5@
L4502      FCB    $00                                                   * 4502 00             .
L4503      PSHS   U                                                     * 4503 34 40          4@
           LDU    4,S                                                   * 4505 EE 64          nd
L4507      LDB    ,U+                                                   * 4507 E6 C0          f@
           BNE    L4507                                                 * 4509 26 FC          &|
           TFR    U,D                                                   * 450B 1F 30          .0
           SUBD   4,S                                                   * 450D A3 64          #d
           ADDD   #-1                                                   * 450F C3 FF FF       C..
           PULS   PC,U                                                  * 4512 35 C0          5@
L4514      PSHS   U                                                     * 4514 34 40          4@
           LDU    6,S                                                   * 4516 EE 66          nf
           LEAS   -2,S                                                  * 4518 32 7E          2~
           LDD    6,S                                                   * 451A EC 66          lf
           STD    ,S                                                    * 451C ED E4          md
L451E      LDB    ,U+                                                   * 451E E6 C0          f@
           LDX    ,S                                                    * 4520 AE E4          .d
           LEAX   1,X                                                   * 4522 30 01          0.
           STX    ,S                                                    * 4524 AF E4          /d
           STB    -1,X                                                  * 4526 E7 1F          g.
           BNE    L451E                                                 * 4528 26 F4          &t
           LDD    6,S                                                   * 452A EC 66          lf
           PULS   PC,U,X                                                * 452C 35 D0          5P
           PSHS   U                                                     * 452E 34 40          4@
           LDU    6,S                                                   * 4530 EE 66          nf
           LEAS   -2,S                                                  * 4532 32 7E          2~
           LDD    6,S                                                   * 4534 EC 66          lf
           STD    ,S                                                    * 4536 ED E4          md
L4538      LDX    ,S                                                    * 4538 AE E4          .d
           LEAX   1,X                                                   * 453A 30 01          0.
           STX    ,S                                                    * 453C AF E4          /d
           LDB    -1,X                                                  * 453E E6 1F          f.
           BNE    L4538                                                 * 4540 26 F6          &v
           LDD    ,S                                                    * 4542 EC E4          ld
           ADDD   #-1                                                   * 4544 C3 FF FF       C..
           STD    ,S                                                    * 4547 ED E4          md
L4549      LDB    ,U+                                                   * 4549 E6 C0          f@
           LDX    ,S                                                    * 454B AE E4          .d
           LEAX   1,X                                                   * 454D 30 01          0.
           STX    ,S                                                    * 454F AF E4          /d
           STB    -1,X                                                  * 4551 E7 1F          g.
           BNE    L4549                                                 * 4553 26 F4          &t
           LDD    6,S                                                   * 4555 EC 66          lf
           PULS   PC,U,X                                                * 4557 35 D0          5P
L4559      PSHS   U                                                     * 4559 34 40          4@
           LDU    4,S                                                   * 455B EE 64          nd
           BRA    L456F                                                 * 455D 20 10           .
L455F      LDX    6,S                                                   * 455F AE 66          .f
           LEAX   1,X                                                   * 4561 30 01          0.
           STX    6,S                                                   * 4563 AF 66          /f
           LDB    -1,X                                                  * 4565 E6 1F          f.
           BNE    L456D                                                 * 4567 26 04          &.
           CLRA                                                         * 4569 4F             O
           CLRB                                                         * 456A 5F             _
           PULS   PC,U                                                  * 456B 35 C0          5@
L456D      LEAU   1,U                                                   * 456D 33 41          3A
L456F      LDB    ,U                                                    * 456F E6 C4          fD
           SEX                                                          * 4571 1D             .
           PSHS   D                                                     * 4572 34 06          4.
           LDB    [<$08,S]                                              * 4574 E6 F8 08       fx.
           SEX                                                          * 4577 1D             .
           CMPD   ,S++                                                  * 4578 10 A3 E1       .#a
           BEQ    L455F                                                 * 457B 27 E2          'b
           LDB    [<$06,S]                                              * 457D E6 F8 06       fx.
           SEX                                                          * 4580 1D             .
           PSHS   D                                                     * 4581 34 06          4.
           LDB    ,U                                                    * 4583 E6 C4          fD
           SEX                                                          * 4585 1D             .
           SUBD   ,S++                                                  * 4586 A3 E1          #a
           PULS   PC,U                                                  * 4588 35 C0          5@
L458A      PSHS   U                                                     * 458A 34 40          4@
           LDU    4,S                                                   * 458C EE 64          nd
           BRA    L459A                                                 * 458E 20 0A           .
L4590      LDX    6,S                                                   * 4590 AE 66          .f
           LEAX   1,X                                                   * 4592 30 01          0.
           STX    6,S                                                   * 4594 AF 66          /f
           LDB    -1,X                                                  * 4596 E6 1F          f.
           STB    ,U+                                                   * 4598 E7 C0          g@
L459A      LDD    8,S                                                   * 459A EC 68          lh
           ADDD   #-1                                                   * 459C C3 FF FF       C..
           STD    8,S                                                   * 459F ED 68          mh
           SUBD   #-1                                                   * 45A1 83 FF FF       ...
           BGT    L4590                                                 * 45A4 2E EA          .j
           PULS   PC,U                                                  * 45A6 35 C0          5@
L45A8      LDD    4,S                                                   * 45A8 EC 64          ld
           ADDD   2,X                                                   * 45AA E3 02          c.
           STD    >Y059D,Y                                              * 45AC ED A9 05 9D    m)..
           LDD    2,S                                                   * 45B0 EC 62          lb
           ADCB   1,X                                                   * 45B2 E9 01          i.
           ADCA   ,X                                                    * 45B4 A9 84          ).
           STD    >Y059B,Y                                              * 45B6 ED A9 05 9B    m)..
           LBRA   L464C                                                 * 45BA 16 00 8F       ...
L45BD      LDD    4,S                                                   * 45BD EC 64          ld
           SUBD   2,X                                                   * 45BF A3 02          #.
           STD    >Y059D,Y                                              * 45C1 ED A9 05 9D    m)..
           LDD    2,S                                                   * 45C5 EC 62          lb
           SBCB   1,X                                                   * 45C7 E2 01          b.
           SBCA   ,X                                                    * 45C9 A2 84          ".
           STD    >Y059B,Y                                              * 45CB ED A9 05 9B    m)..
           LBRA   L464C                                                 * 45CF 16 00 7A       ..z
L45D2      LDD    2,S                                                   * 45D2 EC 62          lb
           CMPD   ,X                                                    * 45D4 10 A3 84       .#.
           BNE    L45EB                                                 * 45D7 26 12          &.
           LDD    4,S                                                   * 45D9 EC 64          ld
           CMPD   2,X                                                   * 45DB 10 A3 02       .#.
           BEQ    L45EB                                                 * 45DE 27 0B          '.
           BCS    L45E8                                                 * 45E0 25 06          %.
           LDA    #1                                                    * 45E2 86 01          ..
           ANDCC  #254                                                  * 45E4 1C FE          .~
           BRA    L45EB                                                 * 45E6 20 03           .
L45E8      CLRA                                                         * 45E8 4F             O
           CMPA   #1                                                    * 45E9 81 01          ..
L45EB      PSHS   CC                                                    * 45EB 34 01          4.
           LDD    1,S                                                   * 45ED EC 61          la
           STD    5,S                                                   * 45EF ED 65          me
           PULS   CC                                                    * 45F1 35 01          5.
           LEAS   4,S                                                   * 45F3 32 64          2d
           RTS                                                          * 45F5 39             9
L45F6      LBSR   L465B                                                 * 45F6 17 00 62       ..b
           LDD    #0                                                    * 45F9 CC 00 00       L..
           SUBD   2,X                                                   * 45FC A3 02          #.
           STD    2,X                                                   * 45FE ED 02          m.
           LDD    #0                                                    * 4600 CC 00 00       L..
           SBCB   1,X                                                   * 4603 E2 01          b.
           SBCA   ,X                                                    * 4605 A2 84          ".
           STD    ,X                                                    * 4607 ED 84          m.
           RTS                                                          * 4609 39             9
           LDD    ,X                                                    * 460A EC 84          l.
           COMA                                                         * 460C 43             C
           COMB                                                         * 460D 53             S
           STD    >Y059B,Y                                              * 460E ED A9 05 9B    m)..
           LDD    2,X                                                   * 4612 EC 02          l.
           COMA                                                         * 4614 43             C
           COMB                                                         * 4615 53             S
           LEAX   >Y059B,Y                                              * 4616 30 A9 05 9B    0)..
           STD    2,X                                                   * 461A ED 02          m.
           RTS                                                          * 461C 39             9
L461D      LEAX   >Y059B,Y                                              * 461D 30 A9 05 9B    0)..
           STD    2,X                                                   * 4621 ED 02          m.
           TFR    A,B                                                   * 4623 1F 89          ..
           SEX                                                          * 4625 1D             .
           TFR    A,B                                                   * 4626 1F 89          ..
           STD    ,X                                                    * 4628 ED 84          m.
           RTS                                                          * 462A 39             9
L462B      LEAX   >Y059B,Y                                              * 462B 30 A9 05 9B    0)..
           STD    2,X                                                   * 462F ED 02          m.
           CLR    ,X                                                    * 4631 6F 84          o.
           CLR    1,X                                                   * 4633 6F 01          o.
           RTS                                                          * 4635 39             9
L4636      PSHS   Y                                                     * 4636 34 20          4
           LDY    4,S                                                   * 4638 10 AE 64       ..d
           LDD    ,X                                                    * 463B EC 84          l.
           STD    ,Y                                                    * 463D ED A4          m$
           LDD    2,X                                                   * 463F EC 02          l.
           STD    U0002,Y                                               * 4641 ED 22          m"
           PULS   X                                                     * 4643 35 10          5.
           EXG    Y,X                                                   * 4645 1E 21          .!
           PULS   D                                                     * 4647 35 06          5.
           STD    ,S                                                    * 4649 ED E4          md
           RTS                                                          * 464B 39             9
L464C      TFR    CC,A                                                  * 464C 1F A8          .(
           PULS   X                                                     * 464E 35 10          5.
           STX    2,S                                                   * 4650 AF 62          /b
           LEAS   2,S                                                   * 4652 32 62          2b
           LEAX   >Y059B,Y                                              * 4654 30 A9 05 9B    0)..
           TFR    A,CC                                                  * 4658 1F 8A          ..
           RTS                                                          * 465A 39             9
L465B      LDD    ,X                                                    * 465B EC 84          l.
           STD    >Y059B,Y                                              * 465D ED A9 05 9B    m)..
           LDD    2,X                                                   * 4661 EC 02          l.
           LEAX   >Y059B,Y                                              * 4663 30 A9 05 9B    0)..
           STD    2,X                                                   * 4667 ED 02          m.
           RTS                                                          * 4669 39             9
L466A      TSTA                                                         * 466A 4D             M
           BNE    L467F                                                 * 466B 26 12          &.
           TST    2,S                                                   * 466D 6D 62          mb
           BNE    L467F                                                 * 466F 26 0E          &.
           LDA    3,S                                                   * 4671 A6 63          &c
           MUL                                                          * 4673 3D             =
           LDX    ,S                                                    * 4674 AE E4          .d
           STX    2,S                                                   * 4676 AF 62          /b
           LDX    #0                                                    * 4678 8E 00 00       ...
           STD    ,S                                                    * 467B ED E4          md
           PULS   PC,D                                                  * 467D 35 86          5.
L467F      PSHS   D                                                     * 467F 34 06          4.
           LDD    #0                                                    * 4681 CC 00 00       L..
           PSHS   D                                                     * 4684 34 06          4.
           PSHS   D                                                     * 4686 34 06          4.
           LDA    5,S                                                   * 4688 A6 65          &e
           LDB    9,S                                                   * 468A E6 69          fi
           MUL                                                          * 468C 3D             =
           STD    2,S                                                   * 468D ED 62          mb
           LDA    5,S                                                   * 468F A6 65          &e
           LDB    8,S                                                   * 4691 E6 68          fh
           MUL                                                          * 4693 3D             =
           ADDD   1,S                                                   * 4694 E3 61          ca
           STD    1,S                                                   * 4696 ED 61          ma
           BCC    L469C                                                 * 4698 24 02          $.
           INC    ,S                                                    * 469A 6C E4          ld
L469C      LDA    4,S                                                   * 469C A6 64          &d
           LDB    9,S                                                   * 469E E6 69          fi
           MUL                                                          * 46A0 3D             =
           ADDD   1,S                                                   * 46A1 E3 61          ca
           STD    1,S                                                   * 46A3 ED 61          ma
           BCC    L46A9                                                 * 46A5 24 02          $.
           INC    ,S                                                    * 46A7 6C E4          ld
L46A9      LDA    4,S                                                   * 46A9 A6 64          &d
           LDB    8,S                                                   * 46AB E6 68          fh
           MUL                                                          * 46AD 3D             =
           ADDD   ,S                                                    * 46AE E3 E4          cd
           STD    ,S                                                    * 46B0 ED E4          md
           LDX    6,S                                                   * 46B2 AE 66          .f
           STX    8,S                                                   * 46B4 AF 68          /h
           LDX    ,S                                                    * 46B6 AE E4          .d
           LDD    2,S                                                   * 46B8 EC 62          lb
           LEAS   8,S                                                   * 46BA 32 68          2h
           RTS                                                          * 46BC 39             9
L46BD      CLR    >Y09C1,Y                                              * 46BD 6F A9 09 C1    o).A
           LEAX   >L4705,PC                                             * 46C1 30 8D 00 40    0..@
           STX    >Y09C2,Y                                              * 46C5 AF A9 09 C2    /).B
           BRA    L46DF                                                 * 46C9 20 14           .
           LEAX   >L471E,PC                                             * 46CB 30 8D 00 4F    0..O
           STX    >Y09C2,Y                                              * 46CF AF A9 09 C2    /).B
           CLR    >Y09C1,Y                                              * 46D3 6F A9 09 C1    o).A
           TST    2,S                                                   * 46D7 6D 62          mb
           BPL    L46DF                                                 * 46D9 2A 04          *.
           INC    >Y09C1,Y                                              * 46DB 6C A9 09 C1    l).A
L46DF      SUBD   #0                                                    * 46DF 83 00 00       ...
           BNE    L46EA                                                 * 46E2 26 06          &.
           PULS   X                                                     * 46E4 35 10          5.
           LDD    ,S++                                                  * 46E6 EC E1          la
           JMP    ,X                                                    * 46E8 6E 84          n.
L46EA      LDX    2,S                                                   * 46EA AE 62          .b
           PSHS   X                                                     * 46EC 34 10          4.
           JSR    [>Y09C2,Y]                                            * 46EE AD B9 09 C2    -9.B
           LDD    ,S                                                    * 46F2 EC E4          ld
           STD    2,S                                                   * 46F4 ED 62          mb
           TFR    X,D                                                   * 46F6 1F 10          ..
           TST    >Y09C1,Y                                              * 46F8 6D A9 09 C1    m).A
           BEQ    L4702                                                 * 46FC 27 04          '.
           NEGA                                                         * 46FE 40             @
           NEGB                                                         * 46FF 50             P
           SBCA   #0                                                    * 4700 82 00          ..
L4702      STD    ,S++                                                  * 4702 ED E1          ma
           RTS                                                          * 4704 39             9
L4705      SUBD   #0                                                    * 4705 83 00 00       ...
           BEQ    L4714                                                 * 4708 27 0A          '.
           PSHS   D                                                     * 470A 34 06          4.
           LEAS   -2,S                                                  * 470C 32 7E          2~
           CLR    ,S                                                    * 470E 6F E4          od
           CLR    1,S                                                   * 4710 6F 61          oa
           BRA    L4742                                                 * 4712 20 2E           .
L4714      PULS   D                                                     * 4714 35 06          5.
           STD    ,S                                                    * 4716 ED E4          md
           LDD    #45                                                   * 4718 CC 00 2D       L.-
           LBRA   L47B7                                                 * 471B 16 00 99       ...
L471E      SUBD   #0                                                    * 471E 83 00 00       ...
           BEQ    L4714                                                 * 4721 27 F1          'q
           PSHS   D                                                     * 4723 34 06          4.
           LEAS   -2,S                                                  * 4725 32 7E          2~
           CLR    ,S                                                    * 4727 6F E4          od
           CLR    1,S                                                   * 4729 6F 61          oa
           TSTA                                                         * 472B 4D             M
           BPL    L4736                                                 * 472C 2A 08          *.
           NEGA                                                         * 472E 40             @
           NEGB                                                         * 472F 50             P
           SBCA   #0                                                    * 4730 82 00          ..
           INC    1,S                                                   * 4732 6C 61          la
           STD    2,S                                                   * 4734 ED 62          mb
L4736      LDD    6,S                                                   * 4736 EC 66          lf
           BPL    L4742                                                 * 4738 2A 08          *.
           NEGA                                                         * 473A 40             @
           NEGB                                                         * 473B 50             P
           SBCA   #0                                                    * 473C 82 00          ..
           COM    1,S                                                   * 473E 63 61          ca
           STD    6,S                                                   * 4740 ED 66          mf
L4742      LDA    #1                                                    * 4742 86 01          ..
L4744      INCA                                                         * 4744 4C             L
           ASL    3,S                                                   * 4745 68 63          hc
           ROL    2,S                                                   * 4747 69 62          ib
           BPL    L4744                                                 * 4749 2A F9          *y
           STA    ,S                                                    * 474B A7 E4          'd
           LDD    6,S                                                   * 474D EC 66          lf
           CLR    6,S                                                   * 474F 6F 66          of
           CLR    7,S                                                   * 4751 6F 67          og
L4753      SUBD   2,S                                                   * 4753 A3 62          #b
           BCC    L475D                                                 * 4755 24 06          $.
           ADDD   2,S                                                   * 4757 E3 62          cb
           ANDCC  #254                                                  * 4759 1C FE          .~
           BRA    L475F                                                 * 475B 20 02           .
L475D      ORCC   #1                                                    * 475D 1A 01          ..
L475F      ROL    7,S                                                   * 475F 69 67          ig
           ROL    6,S                                                   * 4761 69 66          if
           LSR    2,S                                                   * 4763 64 62          db
           ROR    3,S                                                   * 4765 66 63          fc
           DEC    ,S                                                    * 4767 6A E4          jd
           BNE    L4753                                                 * 4769 26 E8          &h
           STD    2,S                                                   * 476B ED 62          mb
           TST    1,S                                                   * 476D 6D 61          ma
           BEQ    L4779                                                 * 476F 27 08          '.
           LDD    6,S                                                   * 4771 EC 66          lf
           NEGA                                                         * 4773 40             @
           NEGB                                                         * 4774 50             P
           SBCA   #0                                                    * 4775 82 00          ..
           STD    6,S                                                   * 4777 ED 66          mf
L4779      LDX    4,S                                                   * 4779 AE 64          .d
           LDD    6,S                                                   * 477B EC 66          lf
           STD    4,S                                                   * 477D ED 64          md
           STX    6,S                                                   * 477F AF 66          /f
           LDX    2,S                                                   * 4781 AE 62          .b
           LDD    4,S                                                   * 4783 EC 64          ld
           LEAS   6,S                                                   * 4785 32 66          2f
           RTS                                                          * 4787 39             9
           TSTB                                                         * 4788 5D             ]
           BEQ    L479E                                                 * 4789 27 13          '.
L478B      ASR    2,S                                                   * 478B 67 62          gb
           ROR    3,S                                                   * 478D 66 63          fc
           DECB                                                         * 478F 5A             Z
           BNE    L478B                                                 * 4790 26 F9          &y
           BRA    L479E                                                 * 4792 20 0A           .
L4794      TSTB                                                         * 4794 5D             ]
           BEQ    L479E                                                 * 4795 27 07          '.
L4797      LSR    2,S                                                   * 4797 64 62          db
           ROR    3,S                                                   * 4799 66 63          fc
           DECB                                                         * 479B 5A             Z
           BNE    L4797                                                 * 479C 26 F9          &y
L479E      LDD    2,S                                                   * 479E EC 62          lb
           PSHS   D                                                     * 47A0 34 06          4.
           LDD    2,S                                                   * 47A2 EC 62          lb
           STD    4,S                                                   * 47A4 ED 64          md
           LDD    ,S                                                    * 47A6 EC E4          ld
           LEAS   4,S                                                   * 47A8 32 64          2d
           RTS                                                          * 47AA 39             9
L47AB      TSTB                                                         * 47AB 5D             ]
           BEQ    L479E                                                 * 47AC 27 F0          'p
L47AE      ASL    3,S                                                   * 47AE 68 63          hc
           ROL    2,S                                                   * 47B0 69 62          ib
           DECB                                                         * 47B2 5A             Z
           BNE    L47AE                                                 * 47B3 26 F9          &y
           BRA    L479E                                                 * 47B5 20 E7           g
L47B7      STD    >errno,Y                                              * 47B7 ED A9 05 A7    m).'
           PSHS   Y,B                                                   * 47BB 34 24          4$
           OS9    F$ID                                                  * 47BD 10 3F 0C       .?.
           PULS   Y,B                                                   * 47C0 35 24          5$
           OS9    F$Send                                                * 47C2 10 3F 08       .?.
           RTS                                                          * 47C5 39             9
L47C6      LDA    5,S                                                   * 47C6 A6 65          &e
           LDB    3,S                                                   * 47C8 E6 63          fc
           BEQ    L47F9                                                 * 47CA 27 2D          '-
           CMPB   #1                                                    * 47CC C1 01          A.
           BEQ    L47FB                                                 * 47CE 27 2B          '+
           CMPB   #6                                                    * 47D0 C1 06          A.
           BEQ    L47FB                                                 * 47D2 27 27          ''
           CMPB   #2                                                    * 47D4 C1 02          A.
           BEQ    L47E1                                                 * 47D6 27 09          '.
           CMPB   #5                                                    * 47D8 C1 05          A.
           BEQ    L47E1                                                 * 47DA 27 05          '.
           LDB    #208                                                  * 47DC C6 D0          FP
           LBRA   _os9err                                               * 47DE 16 02 21       ..!
L47E1      PSHS   U                                                     * 47E1 34 40          4@
           OS9    I$GetStt                                              * 47E3 10 3F 8D       .?.
           BCC    L47ED                                                 * 47E6 24 05          $.
           PULS   U                                                     * 47E8 35 40          5@
           LBRA   _os9err                                               * 47EA 16 02 15       ...
L47ED      STX    [<$08,S]                                              * 47ED AF F8 08       /x.
           LDX    8,S                                                   * 47F0 AE 68          .h
           STU    2,X                                                   * 47F2 EF 02          o.
           PULS   U                                                     * 47F4 35 40          5@
           CLRA                                                         * 47F6 4F             O
           CLRB                                                         * 47F7 5F             _
           RTS                                                          * 47F8 39             9
L47F9      LDX    6,S                                                   * 47F9 AE 66          .f
L47FB      OS9    I$GetStt                                              * 47FB 10 3F 8D       .?.
           LBRA   _sysret                                               * 47FE 16 02 0A       ...
           LDA    5,S                                                   * 4801 A6 65          &e
           LDB    3,S                                                   * 4803 E6 63          fc
           BEQ    L4810                                                 * 4805 27 09          '.
           CMPB   #2                                                    * 4807 C1 02          A.
           BEQ    L4818                                                 * 4809 27 0D          '.
           LDB    #208                                                  * 480B C6 D0          FP
           LBRA   _os9err                                               * 480D 16 01 F2       ..r
L4810      LDX    6,S                                                   * 4810 AE 66          .f
           OS9    I$SetStt                                              * 4812 10 3F 8E       .?.
           LBRA   _sysret                                               * 4815 16 01 F3       ..s
L4818      PSHS   U                                                     * 4818 34 40          4@
           LDX    8,S                                                   * 481A AE 68          .h
           LDU    10,S                                                  * 481C EE 6A          nj
           OS9    I$SetStt                                              * 481E 10 3F 8E       .?.
           PULS   U                                                     * 4821 35 40          5@
           LBRA   _sysret                                               * 4823 16 01 E5       ..e
access     LDX    2,S                                                   * 4826 AE 62          .b
           LDA    5,S                                                   * 4828 A6 65          &e
           OS9    I$Open                                                * 482A 10 3F 84       .?.
           BCS    L4832                                                 * 482D 25 03          %.
           OS9    I$Close                                               * 482F 10 3F 8F       .?.
L4832      LBRA   _sysret                                               * 4832 16 01 D6       ..V
open       LDX    2,S                                                   * 4835 AE 62          .b
           LDA    5,S                                                   * 4837 A6 65          &e
           OS9    I$Open                                                * 4839 10 3F 84       .?.
           LBCS   _os9err                                               * 483C 10 25 01 C2    .%.B
           TFR    A,B                                                   * 4840 1F 89          ..
           CLRA                                                         * 4842 4F             O
           RTS                                                          * 4843 39             9
close      LDA    3,S                                                   * 4844 A6 63          &c
           OS9    I$Close                                               * 4846 10 3F 8F       .?.
           LBRA   _sysret                                               * 4849 16 01 BF       ..?
mknod      LDX    2,S                                                   * 484C AE 62          .b
           LDB    5,S                                                   * 484E E6 65          fe
           OS9    I$MakDir                                              * 4850 10 3F 85       .?.
           LBRA   _sysret                                               * 4853 16 01 B5       ..5
creat      LDX    2,S                                                   * 4856 AE 62          .b
           LDA    5,S                                                   * 4858 A6 65          &e
           LDB    #11                                                   * 485A C6 0B          F.
           OS9    I$Create                                              * 485C 10 3F 83       .?.
           BCS    L4865                                                 * 485F 25 04          %.
L4861      TFR    A,B                                                   * 4861 1F 89          ..
           CLRA                                                         * 4863 4F             O
           RTS                                                          * 4864 39             9
L4865      CMPB   #218                                                  * 4865 C1 DA          AZ
           LBNE   _os9err                                               * 4867 10 26 01 97    .&..
           LDA    5,S                                                   * 486B A6 65          &e
           BITA   #128                                                  * 486D 85 80          ..
           LBNE   _os9err                                               * 486F 10 26 01 8F    .&..
           ANDA   #7                                                    * 4873 84 07          ..
           LDX    2,S                                                   * 4875 AE 62          .b
           OS9    I$Open                                                * 4877 10 3F 84       .?.
           LBCS   _os9err                                               * 487A 10 25 01 84    .%..
           PSHS   U,A                                                   * 487E 34 42          4B
           LDX    #0                                                    * 4880 8E 00 00       ...
           LEAU   ,X                                                    * 4883 33 84          3.
           LDB    #2                                                    * 4885 C6 02          F.
           OS9    I$SetStt                                              * 4887 10 3F 8E       .?.
           PULS   U,A                                                   * 488A 35 42          5B
           BCC    L4861                                                 * 488C 24 D3          $S
           PSHS   B                                                     * 488E 34 04          4.
           OS9    I$Close                                               * 4890 10 3F 8F       .?.
           PULS   B                                                     * 4893 35 04          5.
           LBRA   _os9err                                               * 4895 16 01 6A       ..j
unlink     LDX    2,S                                                   * 4898 AE 62          .b
           OS9    I$Delete                                              * 489A 10 3F 87       .?.
           LBRA   _sysret                                               * 489D 16 01 6B       ..k
dup        LDA    3,S                                                   * 48A0 A6 63          &c
           OS9    I$Dup                                                 * 48A2 10 3F 82       .?.
           LBCS   _os9err                                               * 48A5 10 25 01 59    .%.Y
           TFR    A,B                                                   * 48A9 1F 89          ..
           CLRA                                                         * 48AB 4F             O
           RTS                                                          * 48AC 39             9
L48AD      PSHS   Y                                                     * 48AD 34 20          4
           LDX    6,S                                                   * 48AF AE 66          .f
           LDA    5,S                                                   * 48B1 A6 65          &e
           LDY    8,S                                                   * 48B3 10 AE 68       ..h
           PSHS   Y                                                     * 48B6 34 20          4
           OS9    I$Read                                                * 48B8 10 3F 89       .?.
L48BB      BCC    L48CA                                                 * 48BB 24 0D          $.
           CMPB   #211                                                  * 48BD C1 D3          AS
           BNE    L48C5                                                 * 48BF 26 04          &.
           CLRA                                                         * 48C1 4F             O
           CLRB                                                         * 48C2 5F             _
           PULS   PC,Y,X                                                * 48C3 35 B0          50
L48C5      PULS   Y,X                                                   * 48C5 35 30          50
           LBRA   _os9err                                               * 48C7 16 01 38       ..8
L48CA      TFR    Y,D                                                   * 48CA 1F 20          .
           PULS   PC,Y,X                                                * 48CC 35 B0          50
L48CE      PSHS   Y                                                     * 48CE 34 20          4
           LDA    5,S                                                   * 48D0 A6 65          &e
           LDX    6,S                                                   * 48D2 AE 66          .f
           LDY    8,S                                                   * 48D4 10 AE 68       ..h
           PSHS   Y                                                     * 48D7 34 20          4
           OS9    I$ReadLn                                              * 48D9 10 3F 8B       .?.
           BRA    L48BB                                                 * 48DC 20 DD           ]
L48DE      PSHS   Y                                                     * 48DE 34 20          4
           LDY    8,S                                                   * 48E0 10 AE 68       ..h
           BEQ    L48F3                                                 * 48E3 27 0E          '.
           LDA    5,S                                                   * 48E5 A6 65          &e
           LDX    6,S                                                   * 48E7 AE 66          .f
           OS9    I$Write                                               * 48E9 10 3F 8A       .?.
L48EC      BCC    L48F3                                                 * 48EC 24 05          $.
           PULS   Y                                                     * 48EE 35 20          5
           LBRA   _os9err                                               * 48F0 16 01 0F       ...
L48F3      TFR    Y,D                                                   * 48F3 1F 20          .
           PULS   PC,Y                                                  * 48F5 35 A0          5
L48F7      PSHS   Y                                                     * 48F7 34 20          4
           LDY    8,S                                                   * 48F9 10 AE 68       ..h
           BEQ    L48F3                                                 * 48FC 27 F5          'u
           LDA    5,S                                                   * 48FE A6 65          &e
           LDX    6,S                                                   * 4900 AE 66          .f
           OS9    I$WritLn                                              * 4902 10 3F 8C       .?.
           BRA    L48EC                                                 * 4905 20 E5           e
lseek      PSHS   U                                                     * 4907 34 40          4@
           LDD    10,S                                                  * 4909 EC 6A          lj
           BNE    L4915                                                 * 490B 26 08          &.
           LDU    #0                                                    * 490D CE 00 00       N..
           LDX    #0                                                    * 4910 8E 00 00       ...
           BRA    L4949                                                 * 4913 20 34           4
L4915      CMPD   #1                                                    * 4915 10 83 00 01    ....
           BEQ    L4940                                                 * 4919 27 25          '%
           CMPD   #2                                                    * 491B 10 83 00 02    ....
           BEQ    L4935                                                 * 491F 27 14          '.
           LDB    #247                                                  * 4921 C6 F7          Fw
L4923      CLRA                                                         * 4923 4F             O
           STD    >errno,Y                                              * 4924 ED A9 05 A7    m).'
           LDD    #-1                                                   * 4928 CC FF FF       L..
           LEAX   >Y059B,Y                                              * 492B 30 A9 05 9B    0)..
           STD    ,X                                                    * 492F ED 84          m.
           STD    2,X                                                   * 4931 ED 02          m.
           PULS   PC,U                                                  * 4933 35 C0          5@
L4935      LDA    5,S                                                   * 4935 A6 65          &e
           LDB    #2                                                    * 4937 C6 02          F.
           OS9    I$GetStt                                              * 4939 10 3F 8D       .?.
           BCS    L4923                                                 * 493C 25 E5          %e
           BRA    L4949                                                 * 493E 20 09           .
L4940      LDA    5,S                                                   * 4940 A6 65          &e
           LDB    #5                                                    * 4942 C6 05          F.
           OS9    I$GetStt                                              * 4944 10 3F 8D       .?.
           BCS    L4923                                                 * 4947 25 DA          %Z
L4949      TFR    U,D                                                   * 4949 1F 30          .0
           ADDD   8,S                                                   * 494B E3 68          ch
           STD    >Y059D,Y                                              * 494D ED A9 05 9D    m)..
           TFR    D,U                                                   * 4951 1F 03          ..
           TFR    X,D                                                   * 4953 1F 10          ..
           ADCB   7,S                                                   * 4955 E9 67          ig
           ADCA   6,S                                                   * 4957 A9 66          )f
           BMI    L4923                                                 * 4959 2B C8          +H
           TFR    D,X                                                   * 495B 1F 01          ..
           STD    >Y059B,Y                                              * 495D ED A9 05 9B    m)..
           LDA    5,S                                                   * 4961 A6 65          &e
           OS9    I$Seek                                                * 4963 10 3F 88       .?.
           BCS    L4923                                                 * 4966 25 BB          %;
           LEAX   >Y059B,Y                                              * 4968 30 A9 05 9B    0)..
           PULS   PC,U                                                  * 496C 35 C0          5@
L496E      LDD    >memend,Y                                             * 496E EC A9 05 99    l)..
           PSHS   D                                                     * 4972 34 06          4.
           LDD    4,S                                                   * 4974 EC 64          ld
           CMPD   >Y09C4,Y                                              * 4976 10 A3 A9 09 C4 .#).D
           BCS    L49A2                                                 * 497B 25 25          %%
           ADDD   >memend,Y                                             * 497D E3 A9 05 99    c)..
           PSHS   Y                                                     * 4981 34 20          4
           SUBD   ,S                                                    * 4983 A3 E4          #d
           OS9    F$Mem                                                 * 4985 10 3F 07       .?.
           TFR    Y,D                                                   * 4988 1F 20          .
           PULS   Y                                                     * 498A 35 20          5
           BCC    L4994                                                 * 498C 24 06          $.
           LDD    #-1                                                   * 498E CC FF FF       L..
           LEAS   2,S                                                   * 4991 32 62          2b
           RTS                                                          * 4993 39             9
L4994      STD    >memend,Y                                             * 4994 ED A9 05 99    m)..
           ADDD   >Y09C4,Y                                              * 4998 E3 A9 09 C4    c).D
           SUBD   ,S                                                    * 499C A3 E4          #d
           STD    >Y09C4,Y                                              * 499E ED A9 09 C4    m).D
L49A2      LEAS   2,S                                                   * 49A2 32 62          2b
           LDD    >Y09C4,Y                                              * 49A4 EC A9 09 C4    l).D
           PSHS   D                                                     * 49A8 34 06          4.
           SUBD   4,S                                                   * 49AA A3 64          #d
           STD    >Y09C4,Y                                              * 49AC ED A9 09 C4    m).D
           LDD    >memend,Y                                             * 49B0 EC A9 05 99    l)..
           SUBD   ,S++                                                  * 49B4 A3 E1          #a
           PSHS   D                                                     * 49B6 34 06          4.
           CLRA                                                         * 49B8 4F             O
           LDX    ,S                                                    * 49B9 AE E4          .d
L49BB      STA    ,X+                                                   * 49BB A7 80          '.
           CMPX   >memend,Y                                             * 49BD AC A9 05 99    ,)..
           BCS    L49BB                                                 * 49C1 25 F8          %x
           PULS   PC,D                                                  * 49C3 35 86          5.
L49C5      LDD    2,S                                                   * 49C5 EC 62          lb
           ADDD   >_mtop,Y                                              * 49C7 E3 A9 05 A3    c).#
           BCS    L49EE                                                 * 49CB 25 21          %!
           CMPD   >_stbot,Y                                             * 49CD 10 A3 A9 05 A5 .#).%
           BCC    L49EE                                                 * 49D2 24 1A          $.
           PSHS   D                                                     * 49D4 34 06          4.
           LDX    >_mtop,Y                                              * 49D6 AE A9 05 A3    .).#
           CLRA                                                         * 49DA 4F             O
L49DB      CMPX   ,S                                                    * 49DB AC E4          ,d
           BCC    L49E3                                                 * 49DD 24 04          $.
           STA    ,X+                                                   * 49DF A7 80          '.
           BRA    L49DB                                                 * 49E1 20 F8           x
L49E3      LDD    >_mtop,Y                                              * 49E3 EC A9 05 A3    l).#
           PULS   X                                                     * 49E7 35 10          5.
           STX    >_mtop,Y                                              * 49E9 AF A9 05 A3    /).#
           RTS                                                          * 49ED 39             9
L49EE      LDD    #-1                                                   * 49EE CC FF FF       L..
           RTS                                                          * 49F1 39             9
           LDX    2,S                                                   * 49F2 AE 62          .b
           OS9    F$STime                                               * 49F4 10 3F 16       .?.
           LBRA   _sysret                                               * 49F7 16 00 11       ...
L49FA      LDX    2,S                                                   * 49FA AE 62          .b
           OS9    F$Time                                                * 49FC 10 3F 15       .?.
           LBRA   _sysret                                               * 49FF 16 00 09       ...
_os9err    CLRA                                                         * 4A02 4F             O
           STD    >errno,Y                                              * 4A03 ED A9 05 A7    m).'
           LDD    #-1                                                   * 4A07 CC FF FF       L..
           RTS                                                          * 4A0A 39             9
_sysret    BCS    _os9err                                               * 4A0B 25 F5          %u
           CLRA                                                         * 4A0D 4F             O
           CLRB                                                         * 4A0E 5F             _
           RTS                                                          * 4A0F 39             9

exit       LBSR   _dumprof                                              * 4A10 17 00 08       ...
           LBSR   _tidyup                                               * 4A13 17 F7 74       .wt
_exit      LDD    2,S                                                   * 4A16 EC 62          lb
           OS9    F$Exit                                                * 4A18 10 3F 06       .?.

_dumprof   RTS                                                          * 4A1B 39             9

etext      FCB    $00                                                   * 4A1C 00             .
           FCB    $15                                                   * 4A1D 15             .
           FCB    $00                                                   * 4A1E 00             .
           FCB    $01                                                   * 4A1F 01             .
           FCB    $01                                                   * 4A20 01             .
           FCB    $00                                                   * 4A21 00             .
           FCB    $42                                                   * 4A22 42             B
           FCB    $00                                                   * 4A23 00             .
           FCB    $50                                                   * 4A24 50             P
           FCB    $01                                                   * 4A25 01             .
           FCB    $16                                                   * 4A26 16             .
           FCB    $02                                                   * 4A27 02             .
           FCB    $56                                                   * 4A28 56             V
           FCB    $02                                                   * 4A29 02             .
           FCB    $5E                                                   * 4A2A 5E             ^
           FCB    $02                                                   * 4A2B 02             .
           FCB    $7A                                                   * 4A2C 7A             z
           FCB    $02                                                   * 4A2D 02             .
           FCB    $82                                                   * 4A2E 82             .
           FCB    $02                                                   * 4A2F 02             .
           FCB    $DA                                                   * 4A30 DA             Z
           FCB    $03                                                   * 4A31 03             .
           FCB    $26                                                   * 4A32 26             &
           FCB    $04                                                   * 4A33 04             .
           FCB    $71                                                   * 4A34 71             q
           FCC    "rma.tmp"                                             * 4A35 72 6D 61 2E 74 6D 70 rma.tmp
           FCB    $00                                                   * 4A3C 00             .
           FCB    $00                                                   * 4A3D 00             .
           FCB    $00                                                   * 4A3E 00             .
           FCB    $00                                                   * 4A3F 00             .
           FCB    $00                                                   * 4A40 00             .
           FCB    $00                                                   * 4A41 00             .
           FCB    $00                                                   * 4A42 00             .
           FCB    $00                                                   * 4A43 00             .
           FCB    $00                                                   * 4A44 00             .
           FCB    $00                                                   * 4A45 00             .
           FCB    $00                                                   * 4A46 00             .
           FCB    $00                                                   * 4A47 00             .
           FCB    $00                                                   * 4A48 00             .
           FCB    $00                                                   * 4A49 00             .
           FCB    $00                                                   * 4A4A 00             .
           FCB    $00                                                   * 4A4B 00             .
           FCB    $00                                                   * 4A4C 00             .
           FCB    $00                                                   * 4A4D 00             .
           FCB    $00                                                   * 4A4E 00             .
           FCB    $00                                                   * 4A4F 00             .
           FCB    $00                                                   * 4A50 00             .
           FCB    $00                                                   * 4A51 00             .
           FCB    $00                                                   * 4A52 00             .
           FCB    $08                                                   * 4A53 08             .
           FCB    $EE                                                   * 4A54 EE             n
           FCB    $00                                                   * 4A55 00             .
           FCB    $00                                                   * 4A56 00             .
           FCB    $08                                                   * 4A57 08             .
           FCB    $F4                                                   * 4A58 F4             t
           FCB    $00                                                   * 4A59 00             .
           FCB    $01                                                   * 4A5A 01             .
           FCB    $08                                                   * 4A5B 08             .
           FCB    $FA                                                   * 4A5C FA             z
           FCB    $00                                                   * 4A5D 00             .
           FCB    $02                                                   * 4A5E 02             .
           FCB    $09                                                   * 4A5F 09             .
           FCB    $00                                                   * 4A60 00             .
           FCB    $06                                                   * 4A61 06             .
           FCB    $03                                                   * 4A62 03             .
           FCB    $09                                                   * 4A63 09             .
           FCB    $04                                                   * 4A64 04             .
           FCB    $16                                                   * 4A65 16             .
           FCB    $00                                                   * 4A66 00             .
           FCB    $09                                                   * 4A67 09             .
           FCB    $09                                                   * 4A68 09             .
           FCB    $17                                                   * 4A69 17             .
           FCB    $00                                                   * 4A6A 00             .
           FCB    $09                                                   * 4A6B 09             .
           FCB    $0E                                                   * 4A6C 0E             .
           FCB    $1A                                                   * 4A6D 1A             .
           FCB    $01                                                   * 4A6E 01             .
           FCB    $09                                                   * 4A6F 09             .
           FCB    $13                                                   * 4A70 13             .
           FCB    $1C                                                   * 4A71 1C             .
           FCB    $01                                                   * 4A72 01             .
           FCB    $09                                                   * 4A73 09             .
           FCB    $19                                                   * 4A74 19             .
           FCB    $3C                                                   * 4A75 3C             <
           FCB    $01                                                   * 4A76 01             .
           FCB    $09                                                   * 4A77 09             .
           FCB    $1E                                                   * 4A78 1E             .
           FCB    $C3                                                   * 4A79 C3             C
           FCB    $02                                                   * 4A7A 02             .
           FCB    $09                                                   * 4A7B 09             .
           FCB    $23                                                   * 4A7C 23             #
           FCB    $83                                                   * 4A7D 83             .
           FCB    $02                                                   * 4A7E 02             .
           FCB    $09                                                   * 4A7F 09             .
           FCB    $28                                                   * 4A80 28             (
           FCB    $CC                                                   * 4A81 CC             L
           FCB    $02                                                   * 4A82 02             .
           FCB    $09                                                   * 4A83 09             .
           FCB    $2C                                                   * 4A84 2C             ,
           FCB    $8E                                                   * 4A85 8E             .
           FCB    $02                                                   * 4A86 02             .
           FCB    $09                                                   * 4A87 09             .
           FCB    $30                                                   * 4A88 30             0
           FCB    $CE                                                   * 4A89 CE             N
           FCB    $02                                                   * 4A8A 02             .
           FCB    $09                                                   * 4A8B 09             .
           FCB    $34                                                   * 4A8C 34             4
           FCB    $8C                                                   * 4A8D 8C             .
           FCB    $02                                                   * 4A8E 02             .
           FCB    $09                                                   * 4A8F 09             .
           FCB    $39                                                   * 4A90 39             9
           FCB    $8D                                                   * 4A91 8D             .
           FCB    $42                                                   * 4A92 42             B
           FCB    $09                                                   * 4A93 09             .
           FCB    $3D                                                   * 4A94 3D             =
           FCB    $CD                                                   * 4A95 CD             M
           FCB    $42                                                   * 4A96 42             B
           FCB    $09                                                   * 4A97 09             .
           FCB    $41                                                   * 4A98 41             A
           FCB    $8F                                                   * 4A99 8F             .
           FCB    $42                                                   * 4A9A 42             B
           FCB    $09                                                   * 4A9B 09             .
           FCB    $45                                                   * 4A9C 45             E
           FCB    $CF                                                   * 4A9D CF             O
           FCB    $42                                                   * 4A9E 42             B
           FCB    $09                                                   * 4A9F 09             .
           FCB    $49                                                   * 4AA0 49             I
           FCB    $83                                                   * 4AA1 83             .
           FCB    $22                                                   * 4AA2 22             "
           FCB    $09                                                   * 4AA3 09             .
           FCB    $4E                                                   * 4AA4 4E             N
           FCB    $8C                                                   * 4AA5 8C             .
           FCB    $22                                                   * 4AA6 22             "
           FCB    $09                                                   * 4AA7 09             .
           FCB    $53                                                   * 4AA8 53             S
           FCB    $83                                                   * 4AA9 83             .
           FCB    $12                                                   * 4AAA 12             .
           FCB    $09                                                   * 4AAB 09             .
           FCB    $58                                                   * 4AAC 58             X
           FCB    $8C                                                   * 4AAD 8C             .
           FCB    $12                                                   * 4AAE 12             .
           FCB    $09                                                   * 4AAF 09             .
           FCB    $5D                                                   * 4AB0 5D             ]
           FCB    $8E                                                   * 4AB1 8E             .
           FCB    $12                                                   * 4AB2 12             .
           FCB    $09                                                   * 4AB3 09             .
           FCB    $61                                                   * 4AB4 61             a
           FCB    $CE                                                   * 4AB5 CE             N
           FCB    $12                                                   * 4AB6 12             .
           FCB    $09                                                   * 4AB7 09             .
           FCB    $65                                                   * 4AB8 65             e
           FCB    $8F                                                   * 4AB9 8F             .
           FCB    $52                                                   * 4ABA 52             R
           FCB    $09                                                   * 4ABB 09             .
           FCB    $69                                                   * 4ABC 69             i
           FCB    $CF                                                   * 4ABD CF             O
           FCB    $52                                                   * 4ABE 52             R
           FCB    $09                                                   * 4ABF 09             .
           FCB    $6D                                                   * 4AC0 6D             m
           FCB    $8B                                                   * 4AC1 8B             .
           FCB    $03                                                   * 4AC2 03             .
           FCB    $09                                                   * 4AC3 09             .
           FCB    $71                                                   * 4AC4 71             q
           FCB    $81                                                   * 4AC5 81             .
           FCB    $03                                                   * 4AC6 03             .
           FCB    $09                                                   * 4AC7 09             .
           FCB    $75                                                   * 4AC8 75             u
           FCB    $80                                                   * 4AC9 80             .
           FCB    $03                                                   * 4ACA 03             .
           FCB    $09                                                   * 4ACB 09             .
           FCB    $79                                                   * 4ACC 79             y
           FCB    $82                                                   * 4ACD 82             .
           FCB    $03                                                   * 4ACE 03             .
           FCB    $09                                                   * 4ACF 09             .
           FCB    $7D                                                   * 4AD0 7D             }
           FCB    $84                                                   * 4AD1 84             .
           FCB    $03                                                   * 4AD2 03             .
           FCB    $09                                                   * 4AD3 09             .
           FCB    $81                                                   * 4AD4 81             .
           FCB    $85                                                   * 4AD5 85             .
           FCB    $03                                                   * 4AD6 03             .
           FCB    $09                                                   * 4AD7 09             .
           FCB    $85                                                   * 4AD8 85             .
           FCB    $86                                                   * 4AD9 86             .
           FCB    $03                                                   * 4ADA 03             .
           FCB    $09                                                   * 4ADB 09             .
           FCB    $88                                                   * 4ADC 88             .
           FCB    $87                                                   * 4ADD 87             .
           FCB    $43                                                   * 4ADE 43             C
           FCB    $09                                                   * 4ADF 09             .
           FCB    $8B                                                   * 4AE0 8B             .
           FCB    $88                                                   * 4AE1 88             .
           FCB    $03                                                   * 4AE2 03             .
           FCB    $09                                                   * 4AE3 09             .
           FCB    $8F                                                   * 4AE4 8F             .
           FCB    $89                                                   * 4AE5 89             .
           FCB    $03                                                   * 4AE6 03             .
           FCB    $09                                                   * 4AE7 09             .
           FCB    $93                                                   * 4AE8 93             .
           FCB    $08                                                   * 4AE9 08             .
           FCB    $0C                                                   * 4AEA 0C             .
           FCB    $09                                                   * 4AEB 09             .
           FCB    $97                                                   * 4AEC 97             .
           FCB    $8A                                                   * 4AED 8A             .
           FCB    $03                                                   * 4AEE 03             .
           FCB    $09                                                   * 4AEF 09             .
           FCB    $9A                                                   * 4AF0 9A             .
           FCB    $00                                                   * 4AF1 00             .
           FCB    $04                                                   * 4AF2 04             .
           FCB    $09                                                   * 4AF3 09             .
           FCB    $9E                                                   * 4AF4 9E             .
           FCB    $03                                                   * 4AF5 03             .
           FCB    $04                                                   * 4AF6 04             .
           FCB    $09                                                   * 4AF7 09             .
           FCB    $A2                                                   * 4AF8 A2             "
           FCB    $04                                                   * 4AF9 04             .
           FCB    $04                                                   * 4AFA 04             .
           FCB    $09                                                   * 4AFB 09             .
           FCB    $A6                                                   * 4AFC A6             &
           FCB    $06                                                   * 4AFD 06             .
           FCB    $04                                                   * 4AFE 04             .
           FCB    $09                                                   * 4AFF 09             .
           FCB    $AA                                                   * 4B00 AA             *
           FCB    $07                                                   * 4B01 07             .
           FCB    $04                                                   * 4B02 04             .
           FCB    $09                                                   * 4B03 09             .
           FCB    $AE                                                   * 4B04 AE             .
           FCB    $08                                                   * 4B05 08             .
           FCB    $04                                                   * 4B06 04             .
           FCB    $09                                                   * 4B07 09             .
           FCB    $B2                                                   * 4B08 B2             2
           FCB    $08                                                   * 4B09 08             .
           FCB    $04                                                   * 4B0A 04             .
           FCB    $09                                                   * 4B0B 09             .
           FCB    $B6                                                   * 4B0C B6             6
           FCB    $09                                                   * 4B0D 09             .
           FCB    $04                                                   * 4B0E 04             .
           FCB    $09                                                   * 4B0F 09             .
           FCB    $BA                                                   * 4B10 BA             :
           FCB    $0A                                                   * 4B11 0A             .
           FCB    $04                                                   * 4B12 04             .
           FCB    $09                                                   * 4B13 09             .
           FCB    $BE                                                   * 4B14 BE             >
           FCB    $0C                                                   * 4B15 0C             .
           FCB    $04                                                   * 4B16 04             .
           FCB    $09                                                   * 4B17 09             .
           FCB    $C2                                                   * 4B18 C2             B
           FCB    $0D                                                   * 4B19 0D             .
           FCB    $04                                                   * 4B1A 04             .
           FCB    $09                                                   * 4B1B 09             .
           FCB    $C6                                                   * 4B1C C6             F
           FCB    $0E                                                   * 4B1D 0E             .
           FCB    $44                                                   * 4B1E 44             D
           FCB    $09                                                   * 4B1F 09             .
           FCB    $CA                                                   * 4B20 CA             J
           FCB    $0F                                                   * 4B21 0F             .
           FCB    $04                                                   * 4B22 04             .
           FCB    $09                                                   * 4B23 09             .
           FCB    $CE                                                   * 4B24 CE             N
           FCB    $39                                                   * 4B25 39             9
           FCB    $05                                                   * 4B26 05             .
           FCB    $09                                                   * 4B27 09             .
           FCB    $D2                                                   * 4B28 D2             R
           FCB    $3D                                                   * 4B29 3D             =
           FCB    $05                                                   * 4B2A 05             .
           FCB    $09                                                   * 4B2B 09             .
           FCB    $D6                                                   * 4B2C D6             V
           FCB    $12                                                   * 4B2D 12             .
           FCB    $05                                                   * 4B2E 05             .
           FCB    $09                                                   * 4B2F 09             .
           FCB    $DA                                                   * 4B30 DA             Z
           FCB    $13                                                   * 4B31 13             .
           FCB    $05                                                   * 4B32 05             .
           FCB    $09                                                   * 4B33 09             .
           FCB    $DF                                                   * 4B34 DF             _
           FCB    $19                                                   * 4B35 19             .
           FCB    $05                                                   * 4B36 05             .
           FCB    $09                                                   * 4B37 09             .
           FCB    $E3                                                   * 4B38 E3             c
           FCB    $1D                                                   * 4B39 1D             .
           FCB    $05                                                   * 4B3A 05             .
           FCB    $09                                                   * 4B3B 09             .
           FCB    $E7                                                   * 4B3C E7             g
           FCB    $3A                                                   * 4B3D 3A             :
           FCB    $05                                                   * 4B3E 05             .
           FCB    $09                                                   * 4B3F 09             .
           FCB    $EB                                                   * 4B40 EB             k
           FCB    $3B                                                   * 4B41 3B             ;
           FCB    $05                                                   * 4B42 05             .
           FCB    $09                                                   * 4B43 09             .
           FCB    $EF                                                   * 4B44 EF             o
           FCB    $3F                                                   * 4B45 3F             ?
           FCB    $15                                                   * 4B46 15             .
           FCB    $09                                                   * 4B47 09             .
           FCB    $F4                                                   * 4B48 F4             t
           FCB    $3F                                                   * 4B49 3F             ?
           FCB    $25                                                   * 4B4A 25             %
           FCB    $09                                                   * 4B4B 09             .
           FCB    $F9                                                   * 4B4C F9             y
           FCB    $3F                                                   * 4B4D 3F             ?
           FCB    $05                                                   * 4B4E 05             .
           FCB    $09                                                   * 4B4F 09             .
           FCB    $FD                                                   * 4B50 FD             }
           FCB    $30                                                   * 4B51 30             0
           FCB    $06                                                   * 4B52 06             .
           FCB    $0A                                                   * 4B53 0A             .
           FCB    $02                                                   * 4B54 02             .
           FCB    $31                                                   * 4B55 31             1
           FCB    $06                                                   * 4B56 06             .
           FCB    $0A                                                   * 4B57 0A             .
           FCB    $07                                                   * 4B58 07             .
           FCB    $32                                                   * 4B59 32             2
           FCB    $06                                                   * 4B5A 06             .
           FCB    $0A                                                   * 4B5B 0A             .
           FCB    $0C                                                   * 4B5C 0C             .
           FCB    $33                                                   * 4B5D 33             3
           FCB    $06                                                   * 4B5E 06             .
           FCB    $0A                                                   * 4B5F 0A             .
           FCB    $11                                                   * 4B60 11             .
           FCB    $1F                                                   * 4B61 1F             .
           FCB    $07                                                   * 4B62 07             .
           FCB    $0A                                                   * 4B63 0A             .
           FCB    $15                                                   * 4B64 15             .
           FCB    $1E                                                   * 4B65 1E             .
           FCB    $07                                                   * 4B66 07             .
           FCB    $0A                                                   * 4B67 0A             .
           FCB    $19                                                   * 4B68 19             .
           FCB    $34                                                   * 4B69 34             4
           FCB    $08                                                   * 4B6A 08             .
           FCB    $0A                                                   * 4B6B 0A             .
           FCB    $1E                                                   * 4B6C 1E             .
           FCB    $35                                                   * 4B6D 35             5
           FCB    $08                                                   * 4B6E 08             .
           FCB    $0A                                                   * 4B6F 0A             .
           FCB    $23                                                   * 4B70 23             #
           FCB    $36                                                   * 4B71 36             6
           FCB    $08                                                   * 4B72 08             .
           FCB    $0A                                                   * 4B73 0A             .
           FCB    $28                                                   * 4B74 28             (
           FCB    $37                                                   * 4B75 37             7
           FCB    $08                                                   * 4B76 08             .
           FCB    $0A                                                   * 4B77 0A             .
           FCB    $2D                                                   * 4B78 2D             -
           FCB    $00                                                   * 4B79 00             .
           FCB    $19                                                   * 4B7A 19             .
           FCB    $0A                                                   * 4B7B 0A             .
           FCB    $30                                                   * 4B7C 30             0
           FCB    $01                                                   * 4B7D 01             .
           FCB    $0B                                                   * 4B7E 0B             .
           FCB    $0A                                                   * 4B7F 0A             .
           FCB    $34                                                   * 4B80 34             4
           FCB    $02                                                   * 4B81 02             .
           FCB    $0B                                                   * 4B82 0B             .
           FCB    $0A                                                   * 4B83 0A             .
           FCB    $38                                                   * 4B84 38             8
           FCB    $03                                                   * 4B85 03             .
           FCB    $0B                                                   * 4B86 0B             .
           FCB    $0A                                                   * 4B87 0A             .
           FCB    $3C                                                   * 4B88 3C             <
           FCB    $04                                                   * 4B89 04             .
           FCB    $0B                                                   * 4B8A 0B             .
           FCB    $0A                                                   * 4B8B 0A             .
           FCB    $40                                                   * 4B8C 40             @
           FCB    $0A                                                   * 4B8D 0A             .
           FCB    $0B                                                   * 4B8E 0B             .
           FCB    $0A                                                   * 4B8F 0A             .
           FCB    $44                                                   * 4B90 44             D
           FCB    $06                                                   * 4B91 06             .
           FCB    $0B                                                   * 4B92 0B             .
           FCB    $0A                                                   * 4B93 0A             .
           FCB    $4A                                                   * 4B94 4A             J
           FCB    $00                                                   * 4B95 00             .
           FCB    $0D                                                   * 4B96 0D             .
           FCB    $0A                                                   * 4B97 0A             .
           FCB    $50                                                   * 4B98 50             P
           FCB    $07                                                   * 4B99 07             .
           FCB    $0B                                                   * 4B9A 0B             .
           FCB    $0A                                                   * 4B9B 0A             .
           FCB    $55                                                   * 4B9C 55             U
           FCB    $07                                                   * 4B9D 07             .
           FCB    $0C                                                   * 4B9E 0C             .
           FCB    $0A                                                   * 4B9F 0A             .
           FCB    $5B                                                   * 4BA0 5B             [
           FCB    $09                                                   * 4BA1 09             .
           FCB    $0B                                                   * 4BA2 0B             .
           FCB    $0A                                                   * 4BA3 0A             .
           FCB    $5F                                                   * 4BA4 5F             _
           FCB    $00                                                   * 4BA5 00             .
           FCB    $00                                                   * 4BA6 00             .
           FCB    $0A                                                   * 4BA7 0A             .
           FCB    $63                                                   * 4BA8 63             c
           FCB    $00                                                   * 4BA9 00             .
           FCB    $01                                                   * 4BAA 01             .
           FCB    $0A                                                   * 4BAB 0A             .
           FCB    $68                                                   * 4BAC 68             h
           FCB    $00                                                   * 4BAD 00             .
           FCB    $00                                                   * 4BAE 00             .
           FCB    $0A                                                   * 4BAF 0A             .
           FCB    $6C                                                   * 4BB0 6C             l
           FCB    $01                                                   * 4BB1 01             .
           FCB    $00                                                   * 4BB2 00             .
           FCB    $0A                                                   * 4BB3 0A             .
           FCB    $70                                                   * 4BB4 70             p
           FCB    $02                                                   * 4BB5 02             .
           FCB    $00                                                   * 4BB6 00             .
           FCB    $0A                                                   * 4BB7 0A             .
           FCB    $74                                                   * 4BB8 74             t
           FCB    $03                                                   * 4BB9 03             .
           FCB    $00                                                   * 4BBA 00             .
           FCB    $0A                                                   * 4BBB 0A             .
           FCB    $78                                                   * 4BBC 78             x
           FCB    $04                                                   * 4BBD 04             .
           FCB    $00                                                   * 4BBE 00             .
           FCB    $0A                                                   * 4BBF 0A             .
           FCB    $7C                                                   * 4BC0 7C             |
           FCB    $0A                                                   * 4BC1 0A             .
           FCB    $00                                                   * 4BC2 00             .
           FCB    $0A                                                   * 4BC3 0A             .
           FCB    $80                                                   * 4BC4 80             .
           FCB    $00                                                   * 4BC5 00             .
           FCB    $01                                                   * 4BC6 01             .
           FCB    $0A                                                   * 4BC7 0A             .
           FCB    $85                                                   * 4BC8 85             .
           FCB    $00                                                   * 4BC9 00             .
           FCB    $00                                                   * 4BCA 00             .
           FCB    $0A                                                   * 4BCB 0A             .
           FCB    $89                                                   * 4BCC 89             .
           FCB    $00                                                   * 4BCD 00             .
           FCB    $01                                                   * 4BCE 01             .
           FCB    $0A                                                   * 4BCF 0A             .
           FCB    $8E                                                   * 4BD0 8E             .
           FCB    $00                                                   * 4BD1 00             .
           FCB    $00                                                   * 4BD2 00             .
           FCB    $0A                                                   * 4BD3 0A             .
           FCB    $92                                                   * 4BD4 92             .
           FCB    $01                                                   * 4BD5 01             .
           FCB    $00                                                   * 4BD6 00             .
           FCB    $0A                                                   * 4BD7 0A             .
           FCB    $96                                                   * 4BD8 96             .
           FCB    $02                                                   * 4BD9 02             .
           FCB    $00                                                   * 4BDA 00             .
           FCB    $0A                                                   * 4BDB 0A             .
           FCB    $9A                                                   * 4BDC 9A             .
           FCB    $03                                                   * 4BDD 03             .
           FCB    $00                                                   * 4BDE 00             .
           FCB    $0A                                                   * 4BDF 0A             .
           FCB    $9E                                                   * 4BE0 9E             .
           FCB    $04                                                   * 4BE1 04             .
           FCB    $00                                                   * 4BE2 00             .
           FCB    $0A                                                   * 4BE3 0A             .
           FCB    $A2                                                   * 4BE4 A2             "
           FCB    $05                                                   * 4BE5 05             .
           FCB    $00                                                   * 4BE6 00             .
           FCB    $0A                                                   * 4BE7 0A             .
           FCB    $A6                                                   * 4BE8 A6             &
           FCB    $09                                                   * 4BE9 09             .
           FCB    $00                                                   * 4BEA 00             .
           FCB    $0A                                                   * 4BEB 0A             .
           FCB    $AB                                                   * 4BEC AB             +
           FCB    $0A                                                   * 4BED 0A             .
           FCB    $00                                                   * 4BEE 00             .
           FCB    $0A                                                   * 4BEF 0A             .
           FCB    $B0                                                   * 4BF0 B0             0
           FCB    $0B                                                   * 4BF1 0B             .
           FCB    $00                                                   * 4BF2 00             .
           FCB    $0A                                                   * 4BF3 0A             .
           FCB    $B5                                                   * 4BF4 B5             5
           FCB    $00                                                   * 4BF5 00             .
           FCB    $01                                                   * 4BF6 01             .
           FCB    $0A                                                   * 4BF7 0A             .
           FCB    $BA                                                   * 4BF8 BA             :
           FCB    $01                                                   * 4BF9 01             .
           FCB    $01                                                   * 4BFA 01             .
           FCB    $0A                                                   * 4BFB 0A             .
           FCB    $BF                                                   * 4BFC BF             ?
           FCB    $02                                                   * 4BFD 02             .
           FCB    $01                                                   * 4BFE 01             .
           FCB    $0A                                                   * 4BFF 0A             .
           FCB    $C4                                                   * 4C00 C4             D
           FCB    $03                                                   * 4C01 03             .
           FCB    $01                                                   * 4C02 01             .
           FCB    $0A                                                   * 4C03 0A             .
           FCB    $C9                                                   * 4C04 C9             I
           FCB    $04                                                   * 4C05 04             .
           FCB    $01                                                   * 4C06 01             .
           FCB    $0A                                                   * 4C07 0A             .
           FCB    $CE                                                   * 4C08 CE             N
           FCB    $05                                                   * 4C09 05             .
           FCB    $01                                                   * 4C0A 01             .
           FCB    $0A                                                   * 4C0B 0A             .
           FCB    $D3                                                   * 4C0C D3             S
           FCB    $06                                                   * 4C0D 06             .
           FCB    $01                                                   * 4C0E 01             .
           FCB    $0A                                                   * 4C0F 0A             .
           FCB    $D8                                                   * 4C10 D8             X
           FCB    $00                                                   * 4C11 00             .
           FCB    $02                                                   * 4C12 02             .
           FCB    $0A                                                   * 4C13 0A             .
           FCB    $DD                                                   * 4C14 DD             ]
           FCB    $01                                                   * 4C15 01             .
           FCB    $02                                                   * 4C16 02             .
           FCB    $0A                                                   * 4C17 0A             .
           FCB    $E2                                                   * 4C18 E2             b
           FCB    $05                                                   * 4C19 05             .
           FCB    $03                                                   * 4C1A 03             .
           FCB    $0A                                                   * 4C1B 0A             .
           FCB    $E6                                                   * 4C1C E6             f
           FCB    $08                                                   * 4C1D 08             .
           FCB    $03                                                   * 4C1E 03             .
           FCB    $0A                                                   * 4C1F 0A             .
           FCB    $EA                                                   * 4C20 EA             j
           FCB    $00                                                   * 4C21 00             .
           FCB    $04                                                   * 4C22 04             .
           FCB    $0A                                                   * 4C23 0A             .
           FCB    $F0                                                   * 4C24 F0             p
           FCB    $00                                                   * 4C25 00             .
           FCB    $05                                                   * 4C26 05             .
           FCB    $0A                                                   * 4C27 0A             .
           FCB    $F5                                                   * 4C28 F5             u
           FCB    $8D                                                   * 4C29 8D             .
           FCB    $0A                                                   * 4C2A 0A             .
           FCB    $0A                                                   * 4C2B 0A             .
           FCB    $F9                                                   * 4C2C F9             y
           FCB    $20                                                   * 4C2D 20
           FCB    $0A                                                   * 4C2E 0A             .
           FCB    $0A                                                   * 4C2F 0A             .
           FCB    $FD                                                   * 4C30 FD             }
           FCB    $21                                                   * 4C31 21             !
           FCB    $0A                                                   * 4C32 0A             .
           FCB    $0B                                                   * 4C33 0B             .
           FCB    $01                                                   * 4C34 01             .
           FCB    $22                                                   * 4C35 22             "
           FCB    $0A                                                   * 4C36 0A             .
           FCB    $0B                                                   * 4C37 0B             .
           FCB    $05                                                   * 4C38 05             .
           FCB    $23                                                   * 4C39 23             #
           FCB    $0A                                                   * 4C3A 0A             .
           FCB    $0B                                                   * 4C3B 0B             .
           FCB    $09                                                   * 4C3C 09             .
           FCB    $24                                                   * 4C3D 24             $
           FCB    $0A                                                   * 4C3E 0A             .
           FCB    $0B                                                   * 4C3F 0B             .
           FCB    $0D                                                   * 4C40 0D             .
           FCB    $24                                                   * 4C41 24             $
           FCB    $0A                                                   * 4C42 0A             .
           FCB    $0B                                                   * 4C43 0B             .
           FCB    $11                                                   * 4C44 11             .
           FCB    $25                                                   * 4C45 25             %
           FCB    $0A                                                   * 4C46 0A             .
           FCB    $0B                                                   * 4C47 0B             .
           FCB    $15                                                   * 4C48 15             .
           FCB    $25                                                   * 4C49 25             %
           FCB    $0A                                                   * 4C4A 0A             .
           FCB    $0B                                                   * 4C4B 0B             .
           FCB    $19                                                   * 4C4C 19             .
           FCB    $26                                                   * 4C4D 26             &
           FCB    $0A                                                   * 4C4E 0A             .
           FCB    $0B                                                   * 4C4F 0B             .
           FCB    $1D                                                   * 4C50 1D             .
           FCB    $27                                                   * 4C51 27             '
           FCB    $0A                                                   * 4C52 0A             .
           FCB    $0B                                                   * 4C53 0B             .
           FCB    $21                                                   * 4C54 21             !
           FCB    $28                                                   * 4C55 28             (
           FCB    $0A                                                   * 4C56 0A             .
           FCB    $0B                                                   * 4C57 0B             .
           FCB    $25                                                   * 4C58 25             %
           FCB    $29                                                   * 4C59 29             )
           FCB    $0A                                                   * 4C5A 0A             .
           FCB    $0B                                                   * 4C5B 0B             .
           FCB    $29                                                   * 4C5C 29             )
           FCB    $2A                                                   * 4C5D 2A             *
           FCB    $0A                                                   * 4C5E 0A             .
           FCB    $0B                                                   * 4C5F 0B             .
           FCB    $2D                                                   * 4C60 2D             -
           FCB    $2B                                                   * 4C61 2B             +
           FCB    $0A                                                   * 4C62 0A             .
           FCB    $0B                                                   * 4C63 0B             .
           FCB    $31                                                   * 4C64 31             1
           FCB    $2C                                                   * 4C65 2C             ,
           FCB    $0A                                                   * 4C66 0A             .
           FCB    $0B                                                   * 4C67 0B             .
           FCB    $35                                                   * 4C68 35             5
           FCB    $2D                                                   * 4C69 2D             -
           FCB    $0A                                                   * 4C6A 0A             .
           FCB    $0B                                                   * 4C6B 0B             .
           FCB    $39                                                   * 4C6C 39             9
           FCB    $2E                                                   * 4C6D 2E             .
           FCB    $0A                                                   * 4C6E 0A             .
           FCB    $0B                                                   * 4C6F 0B             .
           FCB    $3D                                                   * 4C70 3D             =
           FCB    $2F                                                   * 4C71 2F             /
           FCB    $0A                                                   * 4C72 0A             .
           FCB    $0D                                                   * 4C73 0D             .
           FCB    $78                                                   * 4C74 78             x
           FCB    $0D                                                   * 4C75 0D             .
           FCB    $8D                                                   * 4C76 8D             .
           FCB    $0D                                                   * 4C77 0D             .
           FCB    $F8                                                   * 4C78 F8             x
           FCB    $0D                                                   * 4C79 0D             .
           FCB    $67                                                   * 4C7A 67             g
           FCB    $0F                                                   * 4C7B 0F             .
           FCB    $41                                                   * 4C7C 41             A
           FCB    $0F                                                   * 4C7D 0F             .
           FCB    $73                                                   * 4C7E 73             s
           FCB    $0E                                                   * 4C7F 0E             .
           FCB    $46                                                   * 4C80 46             F
           FCB    $0E                                                   * 4C81 0E             .
           FCB    $96                                                   * 4C82 96             .
           FCB    $0E                                                   * 4C83 0E             .
           FCB    $FD                                                   * 4C84 FD             }
           FCB    $0D                                                   * 4C85 0D             .
           FCB    $78                                                   * 4C86 78             x
           FCB    $0B                                                   * 4C87 0B             .
           FCB    $41                                                   * 4C88 41             A
           FCB    $0B                                                   * 4C89 0B             .
           FCB    $4B                                                   * 4C8A 4B             K
           FCB    $0B                                                   * 4C8B 0B             .
           FCB    $6C                                                   * 4C8C 6C             l
           FCB    $0B                                                   * 4C8D 0B             .
           FCB    $85                                                   * 4C8E 85             .
           FCB    $0B                                                   * 4C8F 0B             .
           FCB    $C9                                                   * 4C90 C9             I
           FCB    $0C                                                   * 4C91 0C             .
           FCB    $14                                                   * 4C92 14             .
           FCB    $0C                                                   * 4C93 0C             .
           FCB    $19                                                   * 4C94 19             .
           FCB    $0C                                                   * 4C95 0C             .
           FCB    $2C                                                   * 4C96 2C             ,
           FCB    $0C                                                   * 4C97 0C             .
           FCB    $92                                                   * 4C98 92             .
           FCB    $0C                                                   * 4C99 0C             .
           FCB    $CE                                                   * 4C9A CE             N
           FCB    $0D                                                   * 4C9B 0D             .
           FCB    $06                                                   * 4C9C 06             .
           FCB    $0D                                                   * 4C9D 0D             .
           FCB    $67                                                   * 4C9E 67             g
           FCB    $0D                                                   * 4C9F 0D             .
           FCB    $78                                                   * 4CA0 78             x
           FCB    $0E                                                   * 4CA1 0E             .
           FCB    $96                                                   * 4CA2 96             .
           FCB    $0D                                                   * 4CA3 0D             .
           FCB    $67                                                   * 4CA4 67             g
           FCB    $0F                                                   * 4CA5 0F             .
           FCB    $2A                                                   * 4CA6 2A             *
           FCB    $0D                                                   * 4CA7 0D             .
           FCB    $67                                                   * 4CA8 67             g
           FCB    $0E                                                   * 4CA9 0E             .
           FCB    $5C                                                   * 4CAA 5C             \
           FCB    $0D                                                   * 4CAB 0D             .
           FCB    $67                                                   * 4CAC 67             g
           FCB    $1C                                                   * 4CAD 1C             .
           FCB    $72                                                   * 4CAE 72             r
           FCC    "A"                                                   * 4CAF 41             A
           FCB    $00                                                   * 4CB0 00             .
           FCB    $02                                                   * 4CB1 02             .
           FCC    "B"                                                   * 4CB2 42             B
           FCB    $00                                                   * 4CB3 00             .
           FCB    $04                                                   * 4CB4 04             .
           FCC    "CC"                                                  * 4CB5 43 43          CC
           FCB    $01                                                   * 4CB7 01             .
           FCC    "DP"                                                  * 4CB8 44 50          DP
           FCB    $08                                                   * 4CBA 08             .
           FCC    "D"                                                   * 4CBB 44             D
           FCB    $00                                                   * 4CBC 00             .
           FCB    $06                                                   * 4CBD 06             .
           FCC    "X"                                                   * 4CBE 58             X
           FCB    $00                                                   * 4CBF 00             .
           FCB    $10                                                   * 4CC0 10             .
           FCC    "Y"                                                   * 4CC1 59             Y
           FCB    $00                                                   * 4CC2 00             .
           FCB    $20                                                   * 4CC3 20
           FCC    "U"                                                   * 4CC4 55             U
           FCB    $00                                                   * 4CC5 00             .
           FCB    $40                                                   * 4CC6 40             @
           FCC    "S"                                                   * 4CC7 53             S
           FCB    $00                                                   * 4CC8 00             .
           FCB    $40                                                   * 4CC9 40             @
           FCC    "PC"                                                  * 4CCA 50 43          PC
           FCB    $80                                                   * 4CCC 80             .
           FCB    $6C                                                   * 4CCD 6C             l
           FCB    $00                                                   * 4CCE 00             .
           FCB    $C3                                                   * 4CCF C3             C
           FCB    $6F                                                   * 4CD0 6F             o
           FCB    $00                                                   * 4CD1 00             .
           FCB    $C6                                                   * 4CD2 C6             F
           FCB    $63                                                   * 4CD3 63             c
           FCB    $00                                                   * 4CD4 00             .
           FCB    $BF                                                   * 4CD5 BF             ?
           FCB    $66                                                   * 4CD6 66             f
           FCB    $00                                                   * 4CD7 00             .
           FCB    $C0                                                   * 4CD8 C0             @
           FCB    $67                                                   * 4CD9 67             g
           FCB    $00                                                   * 4CDA 00             .
           FCB    $C1                                                   * 4CDB C1             A
           FCB    $65                                                   * 4CDC 65             e
           FCB    $00                                                   * 4CDD 00             .
           FCB    $01                                                   * 4CDE 01             .
           FCB    $73                                                   * 4CDF 73             s
           FCB    $00                                                   * 4CE0 00             .
           FCB    $C7                                                   * 4CE1 C7             G
           FCB    $78                                                   * 4CE2 78             x
           FCB    $00                                                   * 4CE3 00             .
           FCB    $02                                                   * 4CE4 02             .
           FCB    $17                                                   * 4CE5 17             .
           FCB    $34                                                   * 4CE6 34             4
           FCB    $18                                                   * 4CE7 18             .
           FCB    $13                                                   * 4CE8 13             .
           FCB    $18                                                   * 4CE9 18             .
           FCB    $D8                                                   * 4CEA D8             X
           FCB    $18                                                   * 4CEB 18             .
           FCB    $1E                                                   * 4CEC 1E             .
           FCB    $18                                                   * 4CED 18             .
           FCB    $C3                                                   * 4CEE C3             C
           FCB    $17                                                   * 4CEF 17             .
           FCB    $BF                                                   * 4CF0 BF             ?
           FCB    $1B                                                   * 4CF1 1B             .
           FCB    $CD                                                   * 4CF2 CD             M
           FCB    $1C                                                   * 4CF3 1C             .
           FCB    $72                                                   * 4CF4 72             r
           FCB    $17                                                   * 4CF5 17             .
           FCB    $CA                                                   * 4CF6 CA             J
           FCB    $19                                                   * 4CF7 19             .
           FCB    $7F                                                   * 4CF8 7F             .
           FCB    $17                                                   * 4CF9 17             .
           FCB    $0E                                                   * 4CFA 0E             .
           FCB    $19                                                   * 4CFB 19             .
           FCB    $CB                                                   * 4CFC CB             K
           FCB    $1A                                                   * 4CFD 1A             .
           FCB    $48                                                   * 4CFE 48             H
           FCB    $19                                                   * 4CFF 19             .
           FCB    $FB                                                   * 4D00 FB             {
           FCB    $1A                                                   * 4D01 1A             .
           FCB    $07                                                   * 4D02 07             .
           FCB    $1A                                                   * 4D03 1A             .
           FCB    $0E                                                   * 4D04 0E             .
           FCB    $1B                                                   * 4D05 1B             .
           FCB    $2F                                                   * 4D06 2F             /
           FCB    $19                                                   * 4D07 19             .
           FCB    $C7                                                   * 4D08 C7             G
           FCB    $1B                                                   * 4D09 1B             .
           FCB    $0A                                                   * 4D0A 0A             .
           FCB    $19                                                   * 4D0B 19             .
           FCB    $B6                                                   * 4D0C B6             6
           FCB    $1C                                                   * 4D0D 1C             .
           FCB    $A5                                                   * 4D0E A5             %
           FCB    $1C                                                   * 4D0F 1C             .
           FCB    $BC                                                   * 4D10 BC             <
           FCB    $1D                                                   * 4D11 1D             .
           FCB    $19                                                   * 4D12 19             .
           FCB    $1B                                                   * 4D13 1B             .
           FCB    $6B                                                   * 4D14 6B             k
           FCB    $1B                                                   * 4D15 1B             .
           FCB    $79                                                   * 4D16 79             y
           FCB    $1B                                                   * 4D17 1B             .
           FCB    $87                                                   * 4D18 87             .
           FCB    $1B                                                   * 4D19 1B             .
           FCB    $95                                                   * 4D1A 95             .
           FCB    $1B                                                   * 4D1B 1B             .
           FCB    $A3                                                   * 4D1C A3             #
           FCB    $1B                                                   * 4D1D 1B             .
           FCB    $B1                                                   * 4D1E B1             1
           FCB    $1B                                                   * 4D1F 1B             .
           FCB    $BF                                                   * 4D20 BF             ?
           FCB    $00                                                   * 4D21 00             .
           FCB    $00                                                   * 4D22 00             .
           FCB    $00                                                   * 4D23 00             .
           FCB    $00                                                   * 4D24 00             .
           FCB    $62                                                   * 4D25 62             b
           FCB    $CD                                                   * 4D26 CD             M
           FCB    $23                                                   * 4D27 23             #
           FCB    $87                                                   * 4D28 87             .
           FCB    $00                                                   * 4D29 00             .
           FCB    $00                                                   * 4D2A 00             .
           FCB    $00                                                   * 4D2B 00             .
           FCB    $00                                                   * 4D2C 00             .
           FCB    $00                                                   * 4D2D 00             .
           FCB    $00                                                   * 4D2E 00             .
           FCB    $00                                                   * 4D2F 00             .
           FCB    $00                                                   * 4D30 00             .
           FCB    $00                                                   * 4D31 00             .
           FCB    $00                                                   * 4D32 00             .
           FCB    $00                                                   * 4D33 00             .
           FCB    $00                                                   * 4D34 00             .
           FCB    $00                                                   * 4D35 00             .
           FCB    $00                                                   * 4D36 00             .
           FCB    $00                                                   * 4D37 00             .
           FCB    $00                                                   * 4D38 00             .
           FCB    $00                                                   * 4D39 00             .
           FCB    $00                                                   * 4D3A 00             .
           FCB    $00                                                   * 4D3B 00             .
           FCB    $00                                                   * 4D3C 00             .
           FCB    $00                                                   * 4D3D 00             .
           FCB    $00                                                   * 4D3E 00             .
           FCB    $00                                                   * 4D3F 00             .
           FCB    $00                                                   * 4D40 00             .
           FCB    $07                                                   * 4D41 07             .
           FCB    $FF                                                   * 4D42 FF             .
           FCB    $08                                                   * 4D43 08             .
           FCB    $17                                                   * 4D44 17             .
           FCB    $00                                                   * 4D45 00             .
           FCB    $00                                                   * 4D46 00             .
           FCB    $00                                                   * 4D47 00             .
           FCB    $00                                                   * 4D48 00             .
           FCB    $00                                                   * 4D49 00             .
           FCB    $00                                                   * 4D4A 00             .
           FCB    $00                                                   * 4D4B 00             .
           FCB    $00                                                   * 4D4C 00             .
           FCB    $00                                                   * 4D4D 00             .
           FCB    $00                                                   * 4D4E 00             .
           FCB    $00                                                   * 4D4F 00             .
           FCB    $00                                                   * 4D50 00             .
           FCB    $00                                                   * 4D51 00             .
           FCB    $00                                                   * 4D52 00             .
           FCB    $00                                                   * 4D53 00             .
           FCB    $00                                                   * 4D54 00             .
           FCB    $00                                                   * 4D55 00             .
           FCB    $00                                                   * 4D56 00             .
           FCB    $00                                                   * 4D57 00             .
           FCB    $00                                                   * 4D58 00             .
           FCB    $00                                                   * 4D59 00             .
           FCB    $00                                                   * 4D5A 00             .
           FCB    $00                                                   * 4D5B 00             .
           FCB    $00                                                   * 4D5C 00             .
           FCB    $00                                                   * 4D5D 00             .
           FCB    $00                                                   * 4D5E 00             .
           FCB    $00                                                   * 4D5F 00             .
           FCB    $00                                                   * 4D60 00             .
           FCB    $00                                                   * 4D61 00             .
           FCB    $00                                                   * 4D62 00             .
           FCB    $00                                                   * 4D63 00             .
           FCB    $00                                                   * 4D64 00             .
           FCB    $00                                                   * 4D65 00             .
           FCB    $00                                                   * 4D66 00             .
           FCB    $00                                                   * 4D67 00             .
           FCB    $00                                                   * 4D68 00             .
           FCB    $00                                                   * 4D69 00             .
           FCB    $00                                                   * 4D6A 00             .
           FCB    $00                                                   * 4D6B 00             .
           FCB    $00                                                   * 4D6C 00             .
           FCB    $01                                                   * 4D6D 01             .
           FCB    $00                                                   * 4D6E 00             .
           FCB    $00                                                   * 4D6F 00             .
           FCB    $00                                                   * 4D70 00             .
           FCB    $00                                                   * 4D71 00             .
           FCB    $00                                                   * 4D72 00             .
           FCB    $00                                                   * 4D73 00             .
           FCB    $00                                                   * 4D74 00             .
           FCB    $00                                                   * 4D75 00             .
           FCB    $00                                                   * 4D76 00             .
           FCB    $02                                                   * 4D77 02             .
           FCB    $00                                                   * 4D78 00             .
           FCB    $38                                                   * 4D79 38             8
           FCB    $38                                                   * 4D7A 38             8
           FCB    $28                                                   * 4D7B 28             (
           FCB    $28                                                   * 4D7C 28             (
           FCB    $28                                                   * 4D7D 28             (
           FCB    $28                                                   * 4D7E 28             (
           FCB    $28                                                   * 4D7F 28             (
           FCB    $28                                                   * 4D80 28             (
           FCB    $28                                                   * 4D81 28             (
           FCB    $28                                                   * 4D82 28             (
           FCB    $00                                                   * 4D83 00             .
           FCB    $00                                                   * 4D84 00             .
           FCB    $00                                                   * 4D85 00             .
           FCB    $00                                                   * 4D86 00             .
           FCB    $00                                                   * 4D87 00             .
           FCB    $00                                                   * 4D88 00             .
           FCB    $02                                                   * 4D89 02             .
           FCB    $22                                                   * 4D8A 22             "
           FCB    $22                                                   * 4D8B 22             "
           FCB    $22                                                   * 4D8C 22             "
           FCB    $22                                                   * 4D8D 22             "
           FCB    $22                                                   * 4D8E 22             "
           FCB    $22                                                   * 4D8F 22             "
           FCB    $02                                                   * 4D90 02             .
           FCB    $02                                                   * 4D91 02             .
           FCB    $02                                                   * 4D92 02             .
           FCB    $02                                                   * 4D93 02             .
           FCB    $02                                                   * 4D94 02             .
           FCB    $02                                                   * 4D95 02             .
           FCB    $02                                                   * 4D96 02             .
           FCB    $02                                                   * 4D97 02             .
           FCB    $02                                                   * 4D98 02             .
           FCB    $02                                                   * 4D99 02             .
           FCB    $02                                                   * 4D9A 02             .
           FCB    $02                                                   * 4D9B 02             .
           FCB    $02                                                   * 4D9C 02             .
           FCB    $02                                                   * 4D9D 02             .
           FCB    $02                                                   * 4D9E 02             .
           FCB    $02                                                   * 4D9F 02             .
           FCB    $02                                                   * 4DA0 02             .
           FCB    $02                                                   * 4DA1 02             .
           FCB    $02                                                   * 4DA2 02             .
           FCB    $02                                                   * 4DA3 02             .
           FCB    $00                                                   * 4DA4 00             .
           FCB    $00                                                   * 4DA5 00             .
           FCB    $00                                                   * 4DA6 00             .
           FCB    $00                                                   * 4DA7 00             .
           FCB    $02                                                   * 4DA8 02             .
           FCB    $00                                                   * 4DA9 00             .
           FCB    $04                                                   * 4DAA 04             .
           FCB    $04                                                   * 4DAB 04             .
           FCB    $04                                                   * 4DAC 04             .
           FCB    $04                                                   * 4DAD 04             .
           FCB    $04                                                   * 4DAE 04             .
           FCB    $04                                                   * 4DAF 04             .
           FCB    $04                                                   * 4DB0 04             .
           FCB    $04                                                   * 4DB1 04             .
           FCB    $04                                                   * 4DB2 04             .
           FCB    $04                                                   * 4DB3 04             .
           FCB    $04                                                   * 4DB4 04             .
           FCB    $04                                                   * 4DB5 04             .
           FCB    $04                                                   * 4DB6 04             .
           FCB    $04                                                   * 4DB7 04             .
           FCB    $04                                                   * 4DB8 04             .
           FCB    $04                                                   * 4DB9 04             .
           FCB    $04                                                   * 4DBA 04             .
           FCB    $04                                                   * 4DBB 04             .
           FCB    $04                                                   * 4DBC 04             .
           FCB    $04                                                   * 4DBD 04             .
           FCB    $04                                                   * 4DBE 04             .
           FCB    $04                                                   * 4DBF 04             .
           FCB    $04                                                   * 4DC0 04             .
           FCB    $04                                                   * 4DC1 04             .
           FCB    $04                                                   * 4DC2 04             .
           FCB    $04                                                   * 4DC3 04             .
           FCB    $00                                                   * 4DC4 00             .
           FCB    $00                                                   * 4DC5 00             .
           FCB    $00                                                   * 4DC6 00             .
           FCB    $00                                                   * 4DC7 00             .
           FCB    $00                                                   * 4DC8 00             .
           FCB    $27                                                   * 4DC9 27             '
           FCB    $10                                                   * 4DCA 10             .
           FCB    $03                                                   * 4DCB 03             .
           FCB    $E8                                                   * 4DCC E8             h
           FCB    $00                                                   * 4DCD 00             .
           FCB    $64                                                   * 4DCE 64             d
           FCB    $00                                                   * 4DCF 00             .
           FCB    $0A                                                   * 4DD0 0A             .
           FCB    $04                                                   * 4DD1 04             .
           FCB    $84                                                   * 4DD2 84             .
           FCB    $6C                                                   * 4DD3 6C             l
           FCB    $78                                                   * 4DD4 78             x
           FCB    $00                                                   * 4DD5 00             .
           FCB    $00                                                   * 4DD6 00             .
           FCB    $00                                                   * 4DD7 00             .
           FCB    $00                                                   * 4DD8 00             .
           FCB    $00                                                   * 4DD9 00             .
           FCB    $00                                                   * 4DDA 00             .
           FCB    $00                                                   * 4DDB 00             .
           FCB    $00                                                   * 4DDC 00             .
           FCB    $01                                                   * 4DDD 01             .
           FCB    $00                                                   * 4DDE 00             .
           FCB    $00                                                   * 4DDF 00             .
           FCB    $00                                                   * 4DE0 00             .
           FCB    $00                                                   * 4DE1 00             .
           FCB    $00                                                   * 4DE2 00             .
           FCB    $00                                                   * 4DE3 00             .
           FCB    $00                                                   * 4DE4 00             .
           FCB    $00                                                   * 4DE5 00             .
           FCB    $00                                                   * 4DE6 00             .
           FCB    $00                                                   * 4DE7 00             .
           FCB    $00                                                   * 4DE8 00             .
           FCB    $00                                                   * 4DE9 00             .
           FCB    $02                                                   * 4DEA 02             .
           FCB    $00                                                   * 4DEB 00             .
           FCB    $01                                                   * 4DEC 01             .
           FCB    $00                                                   * 4DED 00             .
           FCB    $00                                                   * 4DEE 00             .
           FCB    $00                                                   * 4DEF 00             .
           FCB    $00                                                   * 4DF0 00             .
           FCB    $00                                                   * 4DF1 00             .
           FCB    $00                                                   * 4DF2 00             .
           FCB    $00                                                   * 4DF3 00             .
           FCB    $00                                                   * 4DF4 00             .
           FCB    $00                                                   * 4DF5 00             .
           FCB    $00                                                   * 4DF6 00             .
           FCB    $42                                                   * 4DF7 42             B
           FCB    $00                                                   * 4DF8 00             .
           FCB    $02                                                   * 4DF9 02             .
           FCB    $00                                                   * 4DFA 00             .
           FCB    $00                                                   * 4DFB 00             .
           FCB    $00                                                   * 4DFC 00             .
           FCB    $00                                                   * 4DFD 00             .
           FCB    $00                                                   * 4DFE 00             .
           FCB    $00                                                   * 4DFF 00             .
           FCB    $00                                                   * 4E00 00             .
           FCB    $00                                                   * 4E01 00             .
           FCB    $00                                                   * 4E02 00             .
           FCB    $00                                                   * 4E03 00             .
           FCB    $00                                                   * 4E04 00             .
           FCB    $00                                                   * 4E05 00             .
           FCB    $00                                                   * 4E06 00             .
           FCB    $00                                                   * 4E07 00             .
           FCB    $00                                                   * 4E08 00             .
           FCB    $00                                                   * 4E09 00             .
           FCB    $00                                                   * 4E0A 00             .
           FCB    $00                                                   * 4E0B 00             .
           FCB    $00                                                   * 4E0C 00             .
           FCB    $00                                                   * 4E0D 00             .
           FCB    $00                                                   * 4E0E 00             .
           FCB    $00                                                   * 4E0F 00             .
           FCB    $00                                                   * 4E10 00             .
           FCB    $00                                                   * 4E11 00             .
           FCB    $00                                                   * 4E12 00             .
           FCB    $00                                                   * 4E13 00             .
           FCB    $00                                                   * 4E14 00             .
           FCB    $00                                                   * 4E15 00             .
           FCB    $00                                                   * 4E16 00             .
           FCB    $00                                                   * 4E17 00             .
           FCB    $00                                                   * 4E18 00             .
           FCB    $00                                                   * 4E19 00             .
           FCB    $00                                                   * 4E1A 00             .
           FCB    $00                                                   * 4E1B 00             .
           FCB    $00                                                   * 4E1C 00             .
           FCB    $00                                                   * 4E1D 00             .
           FCB    $00                                                   * 4E1E 00             .
           FCB    $00                                                   * 4E1F 00             .
           FCB    $00                                                   * 4E20 00             .
           FCB    $00                                                   * 4E21 00             .
           FCB    $00                                                   * 4E22 00             .
           FCB    $00                                                   * 4E23 00             .
           FCB    $00                                                   * 4E24 00             .
           FCB    $00                                                   * 4E25 00             .
           FCB    $00                                                   * 4E26 00             .
           FCB    $00                                                   * 4E27 00             .
           FCB    $00                                                   * 4E28 00             .
           FCB    $00                                                   * 4E29 00             .
           FCB    $00                                                   * 4E2A 00             .
           FCB    $00                                                   * 4E2B 00             .
           FCB    $00                                                   * 4E2C 00             .
           FCB    $00                                                   * 4E2D 00             .
           FCB    $00                                                   * 4E2E 00             .
           FCB    $00                                                   * 4E2F 00             .
           FCB    $00                                                   * 4E30 00             .
           FCB    $00                                                   * 4E31 00             .
           FCB    $00                                                   * 4E32 00             .
           FCB    $00                                                   * 4E33 00             .
           FCB    $00                                                   * 4E34 00             .
           FCB    $00                                                   * 4E35 00             .
           FCB    $00                                                   * 4E36 00             .
           FCB    $00                                                   * 4E37 00             .
           FCB    $00                                                   * 4E38 00             .
           FCB    $00                                                   * 4E39 00             .
           FCB    $00                                                   * 4E3A 00             .
           FCB    $00                                                   * 4E3B 00             .
           FCB    $00                                                   * 4E3C 00             .
           FCB    $00                                                   * 4E3D 00             .
           FCB    $00                                                   * 4E3E 00             .
           FCB    $00                                                   * 4E3F 00             .
           FCB    $00                                                   * 4E40 00             .
           FCB    $00                                                   * 4E41 00             .
           FCB    $00                                                   * 4E42 00             .
           FCB    $00                                                   * 4E43 00             .
           FCB    $00                                                   * 4E44 00             .
           FCB    $00                                                   * 4E45 00             .
           FCB    $00                                                   * 4E46 00             .
           FCB    $00                                                   * 4E47 00             .
           FCB    $00                                                   * 4E48 00             .
           FCB    $00                                                   * 4E49 00             .
           FCB    $00                                                   * 4E4A 00             .
           FCB    $00                                                   * 4E4B 00             .
           FCB    $00                                                   * 4E4C 00             .
           FCB    $00                                                   * 4E4D 00             .
           FCB    $00                                                   * 4E4E 00             .
           FCB    $00                                                   * 4E4F 00             .
           FCB    $00                                                   * 4E50 00             .
           FCB    $00                                                   * 4E51 00             .
           FCB    $00                                                   * 4E52 00             .
           FCB    $00                                                   * 4E53 00             .
           FCB    $00                                                   * 4E54 00             .
           FCB    $00                                                   * 4E55 00             .
           FCB    $00                                                   * 4E56 00             .
           FCB    $00                                                   * 4E57 00             .
           FCB    $00                                                   * 4E58 00             .
           FCB    $00                                                   * 4E59 00             .
           FCB    $00                                                   * 4E5A 00             .
           FCB    $00                                                   * 4E5B 00             .
           FCB    $00                                                   * 4E5C 00             .
           FCB    $00                                                   * 4E5D 00             .
           FCB    $00                                                   * 4E5E 00             .
           FCB    $00                                                   * 4E5F 00             .
           FCB    $00                                                   * 4E60 00             .
           FCB    $00                                                   * 4E61 00             .
           FCB    $00                                                   * 4E62 00             .
           FCB    $00                                                   * 4E63 00             .
           FCB    $00                                                   * 4E64 00             .
           FCB    $00                                                   * 4E65 00             .
           FCB    $00                                                   * 4E66 00             .
           FCB    $00                                                   * 4E67 00             .
           FCB    $00                                                   * 4E68 00             .
           FCB    $00                                                   * 4E69 00             .
           FCB    $00                                                   * 4E6A 00             .
           FCB    $00                                                   * 4E6B 00             .
           FCB    $00                                                   * 4E6C 00             .
           FCB    $00                                                   * 4E6D 00             .
           FCB    $00                                                   * 4E6E 00             .
           FCB    $00                                                   * 4E6F 00             .
           FCB    $00                                                   * 4E70 00             .
           FCB    $00                                                   * 4E71 00             .
           FCB    $00                                                   * 4E72 00             .
           FCB    $00                                                   * 4E73 00             .
           FCB    $00                                                   * 4E74 00             .
           FCB    $00                                                   * 4E75 00             .
           FCB    $00                                                   * 4E76 00             .
           FCB    $00                                                   * 4E77 00             .
           FCB    $00                                                   * 4E78 00             .
           FCB    $00                                                   * 4E79 00             .
           FCB    $00                                                   * 4E7A 00             .
           FCB    $00                                                   * 4E7B 00             .
           FCB    $00                                                   * 4E7C 00             .
           FCB    $00                                                   * 4E7D 00             .
           FCB    $00                                                   * 4E7E 00             .
           FCB    $00                                                   * 4E7F 00             .
           FCB    $00                                                   * 4E80 00             .
           FCB    $00                                                   * 4E81 00             .
           FCB    $00                                                   * 4E82 00             .
           FCB    $00                                                   * 4E83 00             .
           FCB    $00                                                   * 4E84 00             .
           FCB    $00                                                   * 4E85 00             .
           FCB    $00                                                   * 4E86 00             .
           FCB    $00                                                   * 4E87 00             .
           FCB    $00                                                   * 4E88 00             .
           FCB    $00                                                   * 4E89 00             .
           FCB    $00                                                   * 4E8A 00             .
           FCB    $00                                                   * 4E8B 00             .
           FCB    $00                                                   * 4E8C 00             .
           FCB    $00                                                   * 4E8D 00             .
           FCB    $00                                                   * 4E8E 00             .
           FCB    $00                                                   * 4E8F 00             .
           FCB    $00                                                   * 4E90 00             .
           FCB    $00                                                   * 4E91 00             .
           FCB    $00                                                   * 4E92 00             .
           FCB    $00                                                   * 4E93 00             .
           FCB    $00                                                   * 4E94 00             .
           FCB    $00                                                   * 4E95 00             .
           FCB    $00                                                   * 4E96 00             .
           FCB    $00                                                   * 4E97 00             .
           FCB    $00                                                   * 4E98 00             .
           FCB    $00                                                   * 4E99 00             .
           FCB    $00                                                   * 4E9A 00             .
           FCB    $00                                                   * 4E9B 00             .
           FCB    $00                                                   * 4E9C 00             .
           FCB    $00                                                   * 4E9D 00             .
           FCB    $00                                                   * 4E9E 00             .
           FCB    $00                                                   * 4E9F 00             .
           FCB    $00                                                   * 4EA0 00             .
           FCB    $00                                                   * 4EA1 00             .
           FCB    $00                                                   * 4EA2 00             .
           FCB    $00                                                   * 4EA3 00             .
           FCB    $00                                                   * 4EA4 00             .
           FCB    $00                                                   * 4EA5 00             .
           FCB    $00                                                   * 4EA6 00             .
           FCB    $C4                                                   * 4EA7 C4             D
           FCB    $03                                                   * 4EA8 03             .
           FCB    $A4                                                   * 4EA9 A4             $
           FCB    $03                                                   * 4EAA 03             .
           FCB    $A2                                                   * 4EAB A2             "
           FCB    $03                                                   * 4EAC 03             .
           FCB    $A0                                                   * 4EAD A0
           FCB    $03                                                   * 4EAE 03             .
           FCB    $9E                                                   * 4EAF 9E             .
           FCB    $03                                                   * 4EB0 03             .
           FCB    $9C                                                   * 4EB1 9C             .
           FCB    $03                                                   * 4EB2 03             .
           FCB    $9A                                                   * 4EB3 9A             .
           FCB    $03                                                   * 4EB4 03             .
           FCB    $98                                                   * 4EB5 98             .
           FCB    $03                                                   * 4EB6 03             .
           FCB    $B2                                                   * 4EB7 B2             2
           FCB    $03                                                   * 4EB8 03             .
           FCB    $B0                                                   * 4EB9 B0             0
           FCB    $03                                                   * 4EBA 03             .
           FCB    $AE                                                   * 4EBB AE             .
           FCB    $03                                                   * 4EBC 03             .
           FCB    $AC                                                   * 4EBD AC             ,
           FCB    $03                                                   * 4EBE 03             .
           FCB    $AA                                                   * 4EBF AA             *
           FCB    $03                                                   * 4EC0 03             .
           FCB    $A8                                                   * 4EC1 A8             (
           FCB    $03                                                   * 4EC2 03             .
           FCB    $A6                                                   * 4EC3 A6             &
           FCB    $03                                                   * 4EC4 03             .
           FCB    $C0                                                   * 4EC5 C0             @
           FCB    $03                                                   * 4EC6 03             .
           FCB    $BE                                                   * 4EC7 BE             >
           FCB    $03                                                   * 4EC8 03             .
           FCB    $BC                                                   * 4EC9 BC             <
           FCB    $03                                                   * 4ECA 03             .
           FCB    $BA                                                   * 4ECB BA             :
           FCB    $03                                                   * 4ECC 03             .
           FCB    $B8                                                   * 4ECD B8             8
           FCB    $03                                                   * 4ECE 03             .
           FCB    $B6                                                   * 4ECF B6             6
           FCB    $03                                                   * 4ED0 03             .
           FCB    $B4                                                   * 4ED1 B4             4
           FCB    $03                                                   * 4ED2 03             .
           FCB    $CE                                                   * 4ED3 CE             N
           FCB    $03                                                   * 4ED4 03             .
           FCB    $CC                                                   * 4ED5 CC             L
           FCB    $03                                                   * 4ED6 03             .
           FCB    $CA                                                   * 4ED7 CA             J
           FCB    $03                                                   * 4ED8 03             .
           FCB    $C8                                                   * 4ED9 C8             H
           FCB    $03                                                   * 4EDA 03             .
           FCB    $C6                                                   * 4EDB C6             F
           FCB    $03                                                   * 4EDC 03             .
           FCB    $C4                                                   * 4EDD C4             D
           FCB    $03                                                   * 4EDE 03             .
           FCB    $C2                                                   * 4EDF C2             B
           FCB    $03                                                   * 4EE0 03             .
           FCB    $2E                                                   * 4EE1 2E             .
           FCB    $03                                                   * 4EE2 03             .
           FCB    $2C                                                   * 4EE3 2C             ,
           FCB    $03                                                   * 4EE4 03             .
           FCB    $2A                                                   * 4EE5 2A             *
           FCB    $03                                                   * 4EE6 03             .
           FCB    $28                                                   * 4EE7 28             (
           FCB    $03                                                   * 4EE8 03             .
           FCB    $26                                                   * 4EE9 26             &
           FCB    $03                                                   * 4EEA 03             .
           FCB    $D2                                                   * 4EEB D2             R
           FCB    $03                                                   * 4EEC 03             .
           FCB    $D0                                                   * 4EED D0             P
           FCB    $03                                                   * 4EEE 03             .
           FCB    $3C                                                   * 4EEF 3C             <
           FCB    $03                                                   * 4EF0 03             .
           FCB    $3A                                                   * 4EF1 3A             :
           FCB    $03                                                   * 4EF2 03             .
           FCB    $38                                                   * 4EF3 38             8
           FCB    $03                                                   * 4EF4 03             .
           FCB    $36                                                   * 4EF5 36             6
           FCB    $03                                                   * 4EF6 03             .
           FCB    $34                                                   * 4EF7 34             4
           FCB    $03                                                   * 4EF8 03             .
           FCB    $32                                                   * 4EF9 32             2
           FCB    $03                                                   * 4EFA 03             .
           FCB    $30                                                   * 4EFB 30             0
           FCB    $03                                                   * 4EFC 03             .
           FCB    $4A                                                   * 4EFD 4A             J
           FCB    $03                                                   * 4EFE 03             .
           FCB    $48                                                   * 4EFF 48             H
           FCB    $03                                                   * 4F00 03             .
           FCB    $46                                                   * 4F01 46             F
           FCB    $03                                                   * 4F02 03             .
           FCB    $44                                                   * 4F03 44             D
           FCB    $03                                                   * 4F04 03             .
           FCB    $42                                                   * 4F05 42             B
           FCB    $03                                                   * 4F06 03             .
           FCB    $40                                                   * 4F07 40             @
           FCB    $03                                                   * 4F08 03             .
           FCB    $3E                                                   * 4F09 3E             >
           FCB    $03                                                   * 4F0A 03             .
           FCB    $58                                                   * 4F0B 58             X
           FCB    $03                                                   * 4F0C 03             .
           FCB    $56                                                   * 4F0D 56             V
           FCB    $03                                                   * 4F0E 03             .
           FCB    $54                                                   * 4F0F 54             T
           FCB    $03                                                   * 4F10 03             .
           FCB    $52                                                   * 4F11 52             R
           FCB    $03                                                   * 4F12 03             .
           FCB    $50                                                   * 4F13 50             P
           FCB    $03                                                   * 4F14 03             .
           FCB    $4E                                                   * 4F15 4E             N
           FCB    $03                                                   * 4F16 03             .
           FCB    $4C                                                   * 4F17 4C             L
           FCB    $01                                                   * 4F18 01             .
           FCB    $0E                                                   * 4F19 0E             .
           FCB    $01                                                   * 4F1A 01             .
           FCB    $0A                                                   * 4F1B 0A             .
           FCB    $01                                                   * 4F1C 01             .
           FCB    $06                                                   * 4F1D 06             .
           FCB    $03                                                   * 4F1E 03             .
           FCB    $60                                                   * 4F1F 60             `
           FCB    $03                                                   * 4F20 03             .
           FCB    $5E                                                   * 4F21 5E             ^
           FCB    $03                                                   * 4F22 03             .
           FCB    $5C                                                   * 4F23 5C             \
           FCB    $03                                                   * 4F24 03             .
           FCB    $5A                                                   * 4F25 5A             Z
           FCB    $01                                                   * 4F26 01             .
           FCB    $2A                                                   * 4F27 2A             *
           FCB    $01                                                   * 4F28 01             .
           FCB    $26                                                   * 4F29 26             &
           FCB    $01                                                   * 4F2A 01             .
           FCB    $22                                                   * 4F2B 22             "
           FCB    $01                                                   * 4F2C 01             .
           FCB    $1E                                                   * 4F2D 1E             .
           FCB    $01                                                   * 4F2E 01             .
           FCB    $1A                                                   * 4F2F 1A             .
           FCB    $01                                                   * 4F30 01             .
           FCB    $16                                                   * 4F31 16             .
           FCB    $01                                                   * 4F32 01             .
           FCB    $12                                                   * 4F33 12             .
           FCB    $01                                                   * 4F34 01             .
           FCB    $46                                                   * 4F35 46             F
           FCB    $01                                                   * 4F36 01             .
           FCB    $42                                                   * 4F37 42             B
           FCB    $01                                                   * 4F38 01             .
           FCB    $3E                                                   * 4F39 3E             >
           FCB    $01                                                   * 4F3A 01             .
           FCB    $3A                                                   * 4F3B 3A             :
           FCB    $01                                                   * 4F3C 01             .
           FCB    $36                                                   * 4F3D 36             6
           FCB    $01                                                   * 4F3E 01             .
           FCB    $32                                                   * 4F3F 32             2
           FCB    $01                                                   * 4F40 01             .
           FCB    $2E                                                   * 4F41 2E             .
           FCB    $01                                                   * 4F42 01             .
           FCB    $62                                                   * 4F43 62             b
           FCB    $01                                                   * 4F44 01             .
           FCB    $5E                                                   * 4F45 5E             ^
           FCB    $01                                                   * 4F46 01             .
           FCB    $5A                                                   * 4F47 5A             Z
           FCB    $01                                                   * 4F48 01             .
           FCB    $56                                                   * 4F49 56             V
           FCB    $01                                                   * 4F4A 01             .
           FCB    $52                                                   * 4F4B 52             R
           FCB    $01                                                   * 4F4C 01             .
           FCB    $4E                                                   * 4F4D 4E             N
           FCB    $01                                                   * 4F4E 01             .
           FCB    $4A                                                   * 4F4F 4A             J
           FCB    $01                                                   * 4F50 01             .
           FCB    $7E                                                   * 4F51 7E             ~
           FCB    $01                                                   * 4F52 01             .
           FCB    $7A                                                   * 4F53 7A             z
           FCB    $01                                                   * 4F54 01             .
           FCB    $76                                                   * 4F55 76             v
           FCB    $01                                                   * 4F56 01             .
           FCB    $72                                                   * 4F57 72             r
           FCB    $01                                                   * 4F58 01             .
           FCB    $6E                                                   * 4F59 6E             n
           FCB    $01                                                   * 4F5A 01             .
           FCB    $6A                                                   * 4F5B 6A             j
           FCB    $01                                                   * 4F5C 01             .
           FCB    $66                                                   * 4F5D 66             f
           FCB    $01                                                   * 4F5E 01             .
           FCB    $9A                                                   * 4F5F 9A             .
           FCB    $01                                                   * 4F60 01             .
           FCB    $96                                                   * 4F61 96             .
           FCB    $01                                                   * 4F62 01             .
           FCB    $92                                                   * 4F63 92             .
           FCB    $01                                                   * 4F64 01             .
           FCB    $8E                                                   * 4F65 8E             .
           FCB    $01                                                   * 4F66 01             .
           FCB    $8A                                                   * 4F67 8A             .
           FCB    $01                                                   * 4F68 01             .
           FCB    $86                                                   * 4F69 86             .
           FCB    $01                                                   * 4F6A 01             .
           FCB    $82                                                   * 4F6B 82             .
           FCB    $01                                                   * 4F6C 01             .
           FCB    $B6                                                   * 4F6D B6             6
           FCB    $01                                                   * 4F6E 01             .
           FCB    $B2                                                   * 4F6F B2             2
           FCB    $01                                                   * 4F70 01             .
           FCB    $AE                                                   * 4F71 AE             .
           FCB    $01                                                   * 4F72 01             .
           FCB    $AA                                                   * 4F73 AA             *
           FCB    $01                                                   * 4F74 01             .
           FCB    $A6                                                   * 4F75 A6             &
           FCB    $01                                                   * 4F76 01             .
           FCB    $A2                                                   * 4F77 A2             "
           FCB    $01                                                   * 4F78 01             .
           FCB    $9E                                                   * 4F79 9E             .
           FCB    $01                                                   * 4F7A 01             .
           FCB    $D2                                                   * 4F7B D2             R
           FCB    $01                                                   * 4F7C 01             .
           FCB    $CE                                                   * 4F7D CE             N
           FCB    $01                                                   * 4F7E 01             .
           FCB    $CA                                                   * 4F7F CA             J
           FCB    $01                                                   * 4F80 01             .
           FCB    $C6                                                   * 4F81 C6             F
           FCB    $01                                                   * 4F82 01             .
           FCB    $C2                                                   * 4F83 C2             B
           FCB    $01                                                   * 4F84 01             .
           FCB    $BE                                                   * 4F85 BE             >
           FCB    $01                                                   * 4F86 01             .
           FCB    $BA                                                   * 4F87 BA             :
           FCB    $01                                                   * 4F88 01             .
           FCB    $EE                                                   * 4F89 EE             n
           FCB    $01                                                   * 4F8A 01             .
           FCB    $EA                                                   * 4F8B EA             j
           FCB    $01                                                   * 4F8C 01             .
           FCB    $E6                                                   * 4F8D E6             f
           FCB    $01                                                   * 4F8E 01             .
           FCB    $E2                                                   * 4F8F E2             b
           FCB    $01                                                   * 4F90 01             .
           FCB    $DE                                                   * 4F91 DE             ^
           FCB    $01                                                   * 4F92 01             .
           FCB    $DA                                                   * 4F93 DA             Z
           FCB    $01                                                   * 4F94 01             .
           FCB    $D6                                                   * 4F95 D6             V
           FCB    $02                                                   * 4F96 02             .
           FCB    $0A                                                   * 4F97 0A             .
           FCB    $02                                                   * 4F98 02             .
           FCB    $06                                                   * 4F99 06             .
           FCB    $02                                                   * 4F9A 02             .
           FCB    $02                                                   * 4F9B 02             .
           FCB    $01                                                   * 4F9C 01             .
           FCB    $FE                                                   * 4F9D FE             ~
           FCB    $01                                                   * 4F9E 01             .
           FCB    $FA                                                   * 4F9F FA             z
           FCB    $01                                                   * 4FA0 01             .
           FCB    $F6                                                   * 4FA1 F6             v
           FCB    $01                                                   * 4FA2 01             .
           FCB    $F2                                                   * 4FA3 F2             r
           FCB    $02                                                   * 4FA4 02             .
           FCB    $26                                                   * 4FA5 26             &
           FCB    $02                                                   * 4FA6 02             .
           FCB    $22                                                   * 4FA7 22             "
           FCB    $02                                                   * 4FA8 02             .
           FCB    $1E                                                   * 4FA9 1E             .
           FCB    $02                                                   * 4FAA 02             .
           FCB    $1A                                                   * 4FAB 1A             .
           FCB    $02                                                   * 4FAC 02             .
           FCB    $16                                                   * 4FAD 16             .
           FCB    $02                                                   * 4FAE 02             .
           FCB    $12                                                   * 4FAF 12             .
           FCB    $02                                                   * 4FB0 02             .
           FCB    $0E                                                   * 4FB1 0E             .
           FCB    $02                                                   * 4FB2 02             .
           FCB    $42                                                   * 4FB3 42             B
           FCB    $02                                                   * 4FB4 02             .
           FCB    $3E                                                   * 4FB5 3E             >
           FCB    $02                                                   * 4FB6 02             .
           FCB    $3A                                                   * 4FB7 3A             :
           FCB    $02                                                   * 4FB8 02             .
           FCB    $36                                                   * 4FB9 36             6
           FCB    $02                                                   * 4FBA 02             .
           FCB    $32                                                   * 4FBB 32             2
           FCB    $02                                                   * 4FBC 02             .
           FCB    $2E                                                   * 4FBD 2E             .
           FCB    $02                                                   * 4FBE 02             .
           FCB    $2A                                                   * 4FBF 2A             *
           FCB    $02                                                   * 4FC0 02             .
           FCB    $5E                                                   * 4FC1 5E             ^
           FCB    $02                                                   * 4FC2 02             .
           FCB    $5A                                                   * 4FC3 5A             Z
           FCB    $02                                                   * 4FC4 02             .
           FCB    $56                                                   * 4FC5 56             V
           FCB    $02                                                   * 4FC6 02             .
           FCB    $52                                                   * 4FC7 52             R
           FCB    $02                                                   * 4FC8 02             .
           FCB    $4E                                                   * 4FC9 4E             N
           FCB    $02                                                   * 4FCA 02             .
           FCB    $4A                                                   * 4FCB 4A             J
           FCB    $02                                                   * 4FCC 02             .
           FCB    $46                                                   * 4FCD 46             F
           FCB    $02                                                   * 4FCE 02             .
           FCB    $7A                                                   * 4FCF 7A             z
           FCB    $02                                                   * 4FD0 02             .
           FCB    $76                                                   * 4FD1 76             v
           FCB    $02                                                   * 4FD2 02             .
           FCB    $72                                                   * 4FD3 72             r
           FCB    $02                                                   * 4FD4 02             .
           FCB    $6E                                                   * 4FD5 6E             n
           FCB    $02                                                   * 4FD6 02             .
           FCB    $6A                                                   * 4FD7 6A             j
           FCB    $02                                                   * 4FD8 02             .
           FCB    $66                                                   * 4FD9 66             f
           FCB    $02                                                   * 4FDA 02             .
           FCB    $62                                                   * 4FDB 62             b
           FCB    $02                                                   * 4FDC 02             .
           FCB    $96                                                   * 4FDD 96             .
           FCB    $02                                                   * 4FDE 02             .
           FCB    $92                                                   * 4FDF 92             .
           FCB    $02                                                   * 4FE0 02             .
           FCB    $8E                                                   * 4FE1 8E             .
           FCB    $02                                                   * 4FE2 02             .
           FCB    $8A                                                   * 4FE3 8A             .
           FCB    $02                                                   * 4FE4 02             .
           FCB    $86                                                   * 4FE5 86             .
           FCB    $02                                                   * 4FE6 02             .
           FCB    $82                                                   * 4FE7 82             .
           FCB    $02                                                   * 4FE8 02             .
           FCB    $7E                                                   * 4FE9 7E             ~
           FCB    $02                                                   * 4FEA 02             .
           FCB    $B2                                                   * 4FEB B2             2
           FCB    $02                                                   * 4FEC 02             .
           FCB    $AE                                                   * 4FED AE             .
           FCB    $02                                                   * 4FEE 02             .
           FCB    $AA                                                   * 4FEF AA             *
           FCB    $02                                                   * 4FF0 02             .
           FCB    $A6                                                   * 4FF1 A6             &
           FCB    $02                                                   * 4FF2 02             .
           FCB    $A2                                                   * 4FF3 A2             "
           FCB    $02                                                   * 4FF4 02             .
           FCB    $9E                                                   * 4FF5 9E             .
           FCB    $02                                                   * 4FF6 02             .
           FCB    $9A                                                   * 4FF7 9A             .
           FCB    $02                                                   * 4FF8 02             .
           FCB    $CE                                                   * 4FF9 CE             N
           FCB    $02                                                   * 4FFA 02             .
           FCB    $CA                                                   * 4FFB CA             J
           FCB    $02                                                   * 4FFC 02             .
           FCB    $C6                                                   * 4FFD C6             F
           FCB    $02                                                   * 4FFE 02             .
           FCB    $C2                                                   * 4FFF C2             B
           FCB    $02                                                   * 5000 02             .
           FCB    $BE                                                   * 5001 BE             >
           FCB    $02                                                   * 5002 02             .
           FCB    $BA                                                   * 5003 BA             :
           FCB    $02                                                   * 5004 02             .
           FCB    $B6                                                   * 5005 B6             6
           FCB    $02                                                   * 5006 02             .
           FCB    $EA                                                   * 5007 EA             j
           FCB    $02                                                   * 5008 02             .
           FCB    $E6                                                   * 5009 E6             f
           FCB    $02                                                   * 500A 02             .
           FCB    $E2                                                   * 500B E2             b
           FCB    $02                                                   * 500C 02             .
           FCB    $DE                                                   * 500D DE             ^
           FCB    $02                                                   * 500E 02             .
           FCB    $DA                                                   * 500F DA             Z
           FCB    $02                                                   * 5010 02             .
           FCB    $D6                                                   * 5011 D6             V
           FCB    $02                                                   * 5012 02             .
           FCB    $D2                                                   * 5013 D2             R
           FCB    $03                                                   * 5014 03             .
           FCB    $06                                                   * 5015 06             .
           FCB    $03                                                   * 5016 03             .
           FCB    $02                                                   * 5017 02             .
           FCB    $02                                                   * 5018 02             .
           FCB    $FE                                                   * 5019 FE             ~
           FCB    $02                                                   * 501A 02             .
           FCB    $FA                                                   * 501B FA             z
           FCB    $02                                                   * 501C 02             .
           FCB    $F6                                                   * 501D F6             v
           FCB    $02                                                   * 501E 02             .
           FCB    $F2                                                   * 501F F2             r
           FCB    $02                                                   * 5020 02             .
           FCB    $EE                                                   * 5021 EE             n
           FCB    $03                                                   * 5022 03             .
           FCB    $22                                                   * 5023 22             "
           FCB    $03                                                   * 5024 03             .
           FCB    $1E                                                   * 5025 1E             .
           FCB    $03                                                   * 5026 03             .
           FCB    $1A                                                   * 5027 1A             .
           FCB    $03                                                   * 5028 03             .
           FCB    $16                                                   * 5029 16             .
           FCB    $03                                                   * 502A 03             .
           FCB    $12                                                   * 502B 12             .
           FCB    $03                                                   * 502C 03             .
           FCB    $0E                                                   * 502D 0E             .
           FCB    $03                                                   * 502E 03             .
           FCB    $0A                                                   * 502F 0A             .
           FCB    $00                                                   * 5030 00             .
           FCB    $12                                                   * 5031 12             .
           FCB    $03                                                   * 5032 03             .
           FCB    $81                                                   * 5033 81             .
           FCB    $03                                                   * 5034 03             .
           FCB    $F6                                                   * 5035 F6             v
           FCB    $03                                                   * 5036 03             .
           FCB    $F4                                                   * 5037 F4             t
           FCB    $04                                                   * 5038 04             .
           FCB    $84                                                   * 5039 84             .
           FCB    $03                                                   * 503A 03             .
           FCB    $84                                                   * 503B 84             .
           FCB    $03                                                   * 503C 03             .
           FCB    $93                                                   * 503D 93             .
           FCB    $03                                                   * 503E 03             .
           FCB    $96                                                   * 503F 96             .
           FCB    $03                                                   * 5040 03             .
           FCB    $87                                                   * 5041 87             .
           FCB    $03                                                   * 5042 03             .
           FCB    $90                                                   * 5043 90             .
           FCB    $03                                                   * 5044 03             .
           FCB    $8A                                                   * 5045 8A             .
           FCB    $03                                                   * 5046 03             .
           FCB    $8D                                                   * 5047 8D             .
           FCB    $00                                                   * 5048 00             .
           FCB    $13                                                   * 5049 13             .
           FCB    $00                                                   * 504A 00             .
           FCB    $11                                                   * 504B 11             .
           FCB    $00                                                   * 504C 00             .
           FCB    $0F                                                   * 504D 0F             .
           FCB    $00                                                   * 504E 00             .
           FCB    $0D                                                   * 504F 0D             .
           FCB    $00                                                   * 5050 00             .
           FCB    $0B                                                   * 5051 0B             .
           FCB    $00                                                   * 5052 00             .
           FCB    $09                                                   * 5053 09             .
           FCB    $00                                                   * 5054 00             .
           FCB    $07                                                   * 5055 07             .
           FCC    "c.asm"                                               * 5056 63 2E 61 73 6D c.asm
           FCB    $00                                                   * 505B 00             .

           EMOD
eom        EQU    *
           END
