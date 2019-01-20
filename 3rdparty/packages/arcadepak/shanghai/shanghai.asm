           NAM    Shanghai
           TTL    program module

           USE    defsfile

tylg       SET    Prgrm+Objct
atrv       SET    ReEnt+rev
rev        SET    $01

           MOD    eom,name,tylg,atrv,start,size

U0000      RMB    1
U0001      RMB    1
U0002      RMB    1
U0003      RMB    1
U0004      RMB    1
U0005      RMB    1
U0006      RMB    1
U0007      RMB    1
U0008      RMB    1
U0009      RMB    1
U000A      RMB    1
U000B      RMB    1
U000C      RMB    2
U000E      RMB    2
U0010      RMB    1
U0011      RMB    1
U0012      RMB    1
U0013      RMB    1
U0014      RMB    2
U0016      RMB    1
U0017      RMB    1
U0018      RMB    2
U001A      RMB    1
U001B      RMB    5
U0020      RMB    1
U0021      RMB    1
U0022      RMB    1
U0023      RMB    1
U0024      RMB    1
U0025      RMB    1
U0026      RMB    1
U0027      RMB    1
U0028      RMB    1
U0029      RMB    1
U002A      RMB    1
U002B      RMB    1
U002C      RMB    1
U002D      RMB    1
U002E      RMB    2
U0030      RMB    3
U0033      RMB    1
U0034      RMB    3
U0037      RMB    2
U0039      RMB    1
U003A      RMB    2
U003C      RMB    5
U0041      RMB    1
U0042      RMB    2
U0044      RMB    2
U0046      RMB    2
U0048      RMB    2
U004A      RMB    1
ScTyp      RMB    1
ScnWidth   RMB    2
ScnHeight  RMB    2
Foreground RMB    1
Background RMB    1
Border     RMB    1
U0053      RMB    2
U0055      RMB    2
U0057      RMB    4
U005B      RMB    1
U005C      RMB    1
U005D      RMB    4
U0061      RMB    9
U006A      RMB    48
X009A      RMB    5
X009F      RMB    1
X00A0      RMB    6
U00A6      RMB    28
U00C2      RMB    2
U00C4      RMB    2
U00C6      RMB    1
U00C7      RMB    2
U00C9      RMB    1
U00CA      RMB    1
U00CB      RMB    2
U00CD      RMB    1
U00CE      RMB    4
U00D2      RMB    1
U00D3      RMB    109
X0140      RMB    320
X0280      RMB    1
X0281      RMB    152
X0319      RMB    7
X0320      RMB    201
U03E9      RMB    275
X04FC      RMB    4
X0500      RMB    2
X0502      RMB    158
X05A0      RMB    2
X05A2      RMB    1104
U09F2      RMB    98
U0A54      RMB    46
FileName   RMB    1626
X10DC      RMB    538
X12F6      RMB    2826
U1E00      RMB    2088
Palette    RMB    16
U2638      RMB    3618
size       EQU    .

name       FCS    /Shanghai/
           FCB    $01
L0016      FDB    $0037
           FDB    $2822
           FDB    $1524
           FDB    $0D0C
           FDB    $260C
           FDB    $0707
           FDB    $3F3F
           FDB    $383F
           FDB    $0037
           FDB    $2822
           FDB    $1524
           FDB    $0D0C
           FDB    $260C
           FDB    $3738
           FDB    $3E3F
           FDB    $383F

* Initialize the screen
L0036      FCB    $1B
           FCB    $24
           FCB    $1B
           FCB    $20
           FCB    $08
           FCB    $00
           FCB    $00
           FCB    $28
           FCB    $18
           FCB    $00
           FCB    $09
           FCB    $09
           FCB    $1B
           FCB    $21
           FCB    $05
           FCB    $20
Title      FCC    "Shanghai - (C) Copyright 1986-1987 Activision, Inc."
           FCB    $0D
           FCB    $0A
           FCB    $0A
           FCC    "Programmed by : Rick Adams"
           FCB    $0D
           FCB    $0A
           FCC    "Designed by   : Brodie Lockard"
           FCB    $0D
           FCB    $0A
           FCC    "OS-9 Port by  : Bill Nobel"
           FCB    $0D
           FCB    $0A
           FCC    "              : and Alan DeKok"
           FCB    $0D
           FCB    $0A
           FCC    " Modifications (C) 1994 Bill Nobel and Alan DeKok"
           FCB    $0D
           FCB    $0A

start      CLRA
           CLRB
           STD    >FileName    Set filename to null
L012C      LDA    ,X+          Get the next character from the command-line arguments
           CMPA   #' '         Is it a space?
           BEQ    L012C        Yes, skip it
           CMPA   #13          Is it a CR?
           BEQ    L015A        Yes, skip it
           CMPA   #45          Is it a dash?
           BNE    Exit         No, exit
           LDD    ,X++         Get the next two bytes from the command line
           ANDA   #$DF
           CMPD   #$463D       Is it F=?
           BNE    Exit         No, exit
           STX    >FileName    Store the filename
           BRA    L015A

Exit       LEAX   >Title,PC    Point to the title
           LDY    #225         Write 225 bytes
           LDA    #1           to stdout
           OS9    I$Write      Write the title
           CLRB                Clear the error code
           OS9    F$Exit       Exit back to OS-9

L015A      TFR    U,X          Swap U and X
           CLRB
L015D      CLR    ,X+
           DECB
           BNE    L015D
           CLRA
           STD    <U0057
           LEAX   >Intercept,PC
           OS9    F$Icpt       Set an intercept handler
           LDD    #SS.Opt
           LDX    #$0082
           OS9    I$GetStt     Get stdin options
           LDX    #$00A2
           OS9    I$GetStt     Get stdin options again
           CLR    <U00A6       Turn off echo
           LDX    #$00A2
           OS9    I$SetStt     Set the stdin options
           LDA    #1
           LDX    >FileName    Get the name of the custom tiles
           BNE    OpenTile     Open the custom tiles if not null
           LEAX   >TileFile,PC Get the name of the default tiles
           OS9    I$Open       Open the default tiles
           BCC    L019E        Branch if no error
           LEAX   >SysDir,PC
OpenTile   OS9    I$Open
           LBCS   TilDatErr
L019E      LDB    #SS.Size
           OS9    I$GetStt     Get the file size
           LEAX   ,X           Check the MSB of the file size
           LBNE   NoTileErr    Error if not zero
           CMPU   #9710        Check the LSB of the file size
           LBNE   NoTileErr    Error if not 9710 bytes
           LDX    #2692        Store the tile data at U2692
           LDY    #9710
           OS9    I$Read       Read 9710 bytes
           LBCS   TilDatErr    Branch if error
           OS9    I$Close      Close the tiles
           LEAX   >L0016,PC
           LDU    #2646
           LDB    #32
           BSR    cpymem       Copy 32 bytes from L0016 to 0A56
           LDU    #2647
           LDX    #12394
           LDB    #8
           BSR    cpymem       Copy 8 bytes from 306A to 0A57
           LDU    #2663
           LDX    #12394
           LDB    #8
           BSR    cpymem       Copy 8 bytes from 306A to 0A67
           BRA    L01EB

* Copy the number of bytes in B from X to U
* B = the number of bytes to copy
* X = the source memory block
* Y = the destination memory block
cpymem     LDA    ,X+
           STA    ,U+
           DECB
           BNE    cpymem
           RTS

L01EB      LDB    #4           Need 4 blocks
           OS9    F$AllRAM     Allocate 4 blocks
           LBCS   ScnMemErr    Branch if error
           STD    <U0057       Store the pointer to screen memory
           LBSR   SetScrn
           LBSR   L2BA9
           LBSR   L0A7A
           LDD    #1543
           LBSR   L28D5
           LEAX   >X0140,X
           LEAU   >Copyright,PC
           LBSR   L0FA2
           LDD    #276
           LBSR   L28D5
           LEAX   >$FF60,X
           LEAU   >Title3,PC
           LBSR   L0FA2
           LDD    #277
           LBSR   L28D5
           LEAU   >Title4,PC
           LBSR   L0FA2
           LDD    #6676
           LBSR   L28D5
           LEAX   >$FF60,X
           LEAU   >Title1,PC
           LBSR   L0FA2
           LDD    #7445
           LBSR   L28D5
           LEAU   >Title2,PC
           LBSR   L0FA2
           LDD    #279
           LBSR   L28D5
           LEAU   >Title5,PC
           LBSR   L0FA2
           LBSR   L2DA1
           LDA    #9
           STA    <U0021
           LBSR   L0F8F
           LBSR   L0DFE
           CLR    <U0021
           LBSR   L1513
           LBSR   Sleep120
           LBSR   Sleep120
           LDD    #1
           LBSR   L28D5
           LEAU   >ChsColor,PC
           LBSR   L0FA2
           LBSR   L1513
           LEAU   >L263A,PC
           STU    <U0018
           LBRA   L2AB9
ScnMemErr  LEAX   >L02C0,PC
           LDY    #41
           BRA    ErrExit
NoTileErr  LEAX   >L0312,PC
           LDY    #51
           LDB    #228
           BRA    ErrExit
TilDatErr  LEAX   >L02E9,PC
           LDY    #41
ErrExit    PSHS   B,CC
           LDA    #2
           OS9    I$Write
           LDD    #0
           LDX    #130
           OS9    I$SetStt
           LBSR   L044A
           PULS   B,CC
           OS9    F$Exit
L02C0      FCC    "Shanghai: Can't allocate screen memory."
           FCB    $0D
           FCB    $0A
L02E9      FCC    "Shanghai: Error opening tile data file."
           FCB    $0D
           FCB    $0A
L0312      FCC    "Shanghai: Specified file is NOT a tile data file."
           FCB    $0D
           FCB    $0A
SysDir     FCC    "/DD/SYS/"
TileFile   FCC    "Shanghai.til"
           FCB    $0D
ChsColor   FCC    "Choose color set:"
           FCB    $00
Copyright  FCC    "* 1986-87 Activision, Inc."
           FCB    $00
Title1     FCC    "Programmed by"
           FCB    $00
Title2     FCC    "Rick Adams"
           FCB    $00
Title3     FCC    "Designed by"
           FCB    $00
Title4     FCC    "Brodie Lockard"
           FCB    $00
Title5     FCC    "OS-9 Port by Bill Nobel and Alan DeKok"
           FCB    $00
           FCB    $1B
           LEAX   -1,U
           PSHS   B
           LDD    #6948
           STD    >U00C2
           LDD    #6944
           STD    >U00C4
           LDA    <ScTyp
           STA    >U00C6
           LDD    #0
           STD    >U00C7
           LDD    <ScnWidth
           STB    >U00C9
           LDD    <ScnHeight
           STB    >U00CA
           LDA    <Foreground
           LDB    <Background
           STD    >U00CB
           LDA    <Border
           STA    >U00CD
           LDD    #6945
           STD    >U00CE
           LDX    #194
           LDY    #14
           LDA    #1
           OS9    I$Write
           LDU    #2628
           LBSR   L09E8
           BSR    L044A
           LDD    #0
           LDX    #130
           OS9    I$SetStt
           LDA    #1
           LDB    #137
           LDX    #255
           LDY    #0
           OS9    I$SetStt
           PULS   B
           OS9    F$Exit
L044A      LDX    <U0057
           BEQ    L0453
           LDB    #4
           OS9    F$DelRAM
L0453      RTS
           LDU    #2662
           BRA    L045C
           LDU    #2646
L045C      STU    >U0A54
           LBSR   L09E8
L0462      LBSR   L0F8F
L0465      LBSR   L0A7A
           LDD    #2308
           LBSR   L28D5
           LEAU   >L0793,PC
           LBSR   L0FA2
           LEAU   >L265E,PC
           LBRA   L2AB4
           TST    <U004A
           BEQ    L0495
           LBSR   L1AEE
           BRA    L0465
           TST    <U004A
           BEQ    L0498
           LBSR   L1AEE
           BRA    L0465
           CLR    <U004A
L0490      LBSR   L0F8F
           CLR    <U0021
L0495      LBSR   J0F7A
L0498      TST    <U002D
           BEQ    L0490
           LBSR   L0A7A
           LBSR   L0DFE
           LBSR   J136D
           LDX    #2678
           OS9    F$Time
           TST    <U004A
           LBGT   L07B8
           LBLT   L06F1
           LEAU   >L26F2,PC
           LBSR   L28B6
           LBSR   L19BC
L04BF      LDB    #1
           LBSR   L0E2B
           LEAU   >L26F2,PC
           LBSR   L2909
           LDB    #1
           LBSR   L107E
           BEQ    L04BF
           LBSR   L29E2
           LBSR   J10C9
           TSTB
           BEQ    L04BF
           BSR    L04F2
           TST    <U0002
           BNE    L0465
           BRA    L04BF
           LBSR   L058A
           BRA    L04BF
           LBSR   L05C1
           BRA    L04BF
           LBSR   L067A
           BRA    L04BF
L04F2      CLR    <U001A
           CLR    <U0002
           LBSR   J14C5
           BNE    L0522
           CMPU   <U002A
           BEQ    L0558
           CMPU   <U0027
           BNE    L050D
           LDD    <U0008
           LBEQ   L067A
           BRA    L0558
L050D      LDY    <U0027
           BEQ    L0518
           LDY    <U002A
           BEQ    L0546
           RTS
L0518      LBSR   L08A5
           STU    <U0027
           STB    <U0029
           LBRA   L09C7
L0522      LBSR   L1AEE
           LBSR   L067A
           LEAX   >L0535,PC
           LEAY   >L053D,PC
           CLR    <U006A
           LBRA   J142E
L0535      FCC    "Tile is"
           FCB    $00
L053D      FCC    "not free"
           FCB    $00
L0546      LDY    <U0027
           LBSR   J1A0D
           BNE    L0579
           LBSR   L08A5
           STU    <U002A
           STB    <U002C
           LBRA   L09C7
L0558      LDU    <U0027
           LDB    <U0029
           LBSR   L09CE
           LDU    <U002A
           LDB    <U002C
           LBSR   L09CE
           LBSR   J136D
           LDU    <U0018
           LBSR   L28B6
           LBSR   L08A5
           LBSR   L19BC
           INC    <U001A
           LBRA   J1587
L0579      LBSR   L1AEE
           LBSR   L067A
           LEAX   >L0666,PC
           LEAY   >L0670,PC
           LBRA   J142E
L058A      LDD    <U0027
           LBNE   L067A
           LDA    <U002D
           CMPA   #144
           BEQ    L059A
           BSR    L059B
           BSR    L059B
L059A      RTS
L059B      LDX    #2162
           LDB    <U002D
           CLRA
           LEAX   D,X
           LDB    ,X
           LDU    #1154
           LDA    #7
           PSHS   B
           DECB
           MUL
           LEAU   D,U
           PULS   B
           COM    ,U
           LBSR   J173E
           INC    <U002D
           LDU    <U0018
           LBSR   L28B6
           LBRA   J136D
L05C1      LBSR   L12BF
           LBSR   L067E
           CLR    <U0006
           LDD    <U0008
           BNE    L0632
L05CD      LDA    <U0008
           CMPA   #142
           BHI    L063A
           LDA    <U0008
           INCA
           STA    <U0009
L05D8      LDA    <U0009
           CMPA   #143
           BHI    L0636
           LDA    <U0008
           INCA
           STA    <U0029
           DECA
           LDB    #7
           MUL
           LDU    #1154
           LEAU   D,U
           STU    <U0027
           LDA    <U0009
           INCA
           STA    <U002C
           DECA
           LDB    #7
           MUL
           LDU    #1154
           LEAU   D,U
           STU    <U002A
           LBSR   J14C5
           BNE    L0632
           LDU    <U0027
           LBSR   J14C5
           BNE    L0632
           LDU    <U0027
           CMPU   <U002A
           BEQ    L0632
           LDY    <U002A
           LBSR   J1A0D
           BNE    L0632
           LDU    <U0027
           LDB    <U0029
           LBSR   J173E
           LDU    <U002A
           LDB    <U002C
           LBSR   J173E
           LBSR   J136D
           LDU    <U0018
           LBSR   L28B6
           LBRA   L115C
L0632      INC    <U0009
           BRA    L05D8
L0636      INC    <U0008
           BRA    L05CD
L063A      INC    <U0006
           CLRA
           CLRB
           STD    <U0008
           LBSR   L1AEE
           LBSR   L19BC
           LEAX   >L0654,PC
           LEAY   >L065E,PC
           LBSR   J142E
           LBRA   L115C
L0654      FCC    " No more "
           FCB    $00
L065E      FCC    "  moves"
           FCB    $00
L0666      FCC    "Tile does"
           FCB    $00
L0670      FCC    "not match"
           FCB    $00
L067A      CLRA
           CLRB
           STD    <U0008
L067E      LDD    <U0027
           BEQ    L06A0
           LDD    <U002A
           BEQ    L0693
           LDU    <U002A
           LDB    <U002C
           CLR    <U002A
           CLR    <U002B
           CLR    <U002C
           LBSR   J173E
L0693      LDU    <U0027
           LDB    <U0029
           CLR    <U0027
           CLR    <U0028
           CLR    <U0029
           LBSR   J173E
L06A0      RTS
L06A1      FCC    "Tournament - Select time limit"
           FCB    $00
           LBSR   L0A7A
           LDD    #1029
           LBSR   L28D5
           LEAU   >L06A1,PC
           LBSR   L0FA2
           LEAU   >L2841,PC
           LBRA   L2AB4
           LDA    #251
           BRA    L06DD
           LDA    #246
L06DD      STA    <U004A
           LBSR   L12BF
           LEAU   >L2841,PC
           LBSR   L28B6
           LBSR   L2ADB
           CLR    <U0017
           LBRA   L0490
L06F1      LEAU   >L2889,PC
           LBSR   L28B6
           LBSR   L19BC
           LDA    <U004A
           NEGA
           STA    <U0025
           CLR    <U0026
           CLR    <U0023
           LBSR   J13C6
           CLR    <U0017
           LDA    #1
           STA    <U001B
           LBSR   L2BEA
L0710      LDD    <U0025
           BEQ    L0767
           LDB    <U001B
           LBSR   L0E2B
           LEAU   >L2889,PC
           LBSR   L2909
           LBSR   L13F7
           TST    <U0005
           BNE    L0734
           LDD    <U0025
           CMPD   #256
           BNE    L0734
           INC    <U0005
           LBSR   L1513
L0734      TST    <U0004
           BNE    L0745
           LDD    <U0025
           CMPD   #10
           BNE    L0745
           INC    <U0004
           LBSR   L1513
L0745      LDB    <U001B
           LBSR   L107E
           BEQ    L0710
           LBSR   L29E2
           LBSR   J10C9
           TSTB
           BEQ    L0710
           LBSR   L04F2
           TST    <U001A
           BEQ    L0710
           INC    <U0017
           TST    <U0002
           BNE    L0767
           LBSR   L2BEA
           BRA    L0710
L0767      LBSR   L067A
           LBSR   L1513
           LBSR   L1513
           LBSR   L2CEB
           LBSR   L2C19
           LBNE   L0495
           CLR    <U0021
           LBRA   L0462
           LBSR   L058A
           TST    <U0017
           BEQ    L0710
           DEC    <U0017
           LBSR   L2BEA
           BRA    L0710
           LBSR   L067A
           LBRA   L0710
L0793      FCC    "Shanghai Main Menu:"
           FCB    $00
L07A7      FCC    "Select a Dragon:"
           FCB    $00
L07B8      LEAU   >L282F,PC
           LBSR   L28B6
           LBSR   L19BC
           CLR    <U0017
           CLR    <U0012
           CLR    <U0013
           CLR    <U0011
           LDA    <U004A
           STA    <U0026
           CLR    <U0025
           CLR    <U0023
           LBSR   J13C6
           LBSR   L2BEA
           LDA    #1
           STA    <U001B
           LEAX   >L087F,PC
           LDY    #0
           LBSR   J142E
           CLR    <U0020
L07E9      LDD    <U0025
           BEQ    L0815
           LDB    <U001B
           LBSR   L0E2B
           LEAU   >L282F,PC
           LBSR   L2909
           LBSR   L13F7
           LDB    <U001B
           LBSR   L107E
           BEQ    L07E9
           LBSR   L29E2
           LBSR   J10C9
           TSTB
           BEQ    L07E9
           LBSR   L04F2
           TST    <U001A
           BEQ    L07E9
           BRA    L0825
L0815      LBSR   L067A
           LBSR   L1513
           INC    <U0011
           LDA    <U0011
           CMPA   #4
           BEQ    L089F
           BRA    L082C
L0825      LBSR   L1513
           CLR    <U0011
           INC    <U0017
L082C      LDX    #17
           LDA    <U001B
           LEAX   A,X
           LDB    <U0017
           STB    ,X
           LBSR   L2BEA
           TST    <U002D
           BEQ    L089F
           LBSR   L12BF
           LBSR   Sleep120
           LBSR   L115C
           LDA    <U001B
           LDB    #1
           LEAX   >L087F,PC
           LDY    #0
           CMPA   #1
           BNE    L085C
           LEAX   >L088A,PC
           INCB
L085C      STB    <U001B
           LBSR   J142E
           CLR    <U0020
           LDX    #17
           LDB    <U001B
           LEAX   B,X
           LDA    ,X
           STA    <U0017
           LBSR   L2BEA
           LDA    <U004A
           STA    <U0026
           CLR    <U0025
           CLR    <U0023
           LBSR   J13C6
           LBRA   L07E9
L087F      FCC    "Player one"
           FCB    $00
L088A      FCC    "Player two"
           FCB    $00
           LBSR   L067A
           LBRA   L07E9
           CLR    <U0021
           CLR    <U002D
L089F      LBSR   J1659
           LBRA   L0462
L08A5      PSHS   D
           LBSR   L1B16
           PULS   PC,D
           LBSR   L0A7A
           LDD    #2306
           LBSR   L28D5
           LEAU   >L07A7,PC
           LBSR   L0FA2
           LEAU   >L272C,PC
           LBRA   L2AB4
           LDB    #1
           BRA    L08E1
           LDB    #2
           BRA    L08E1
           LDB    #3
           BRA    L08E1
           LDB    #4
           BRA    L08E1
           LDB    #5
           BRA    L08E1
           LDB    #6
           BRA    L08E1
           LDB    #7
           BRA    L08E1
           LDB    #8
L08E1      STB    <U0021
           LBSR   L0F8F
           LBRA   L0465
L08E9      FCC    "Peek under tiles and forfeit game?"
           FCB    $00
           LBSR   L0A7A
           TST    <U0006
           BNE    L0927
           LDD    #518
           LBSR   L28D5
           LEAU   >L08E9,PC
           LBSR   L0FA2
           LEAU   >L27D0,PC
           LBRA   L2AB4
L0927      LBSR   L0A7A
           LBSR   L0DFE
           LBSR   J136D
           LEAU   >L28A9,PC
           LBSR   L28B6
           LBSR   L19BC
L093A      LDB    #1
           LBSR   L0E2B
           LEAU   >L28A9,PC
           LBSR   L2909
           LDB    #1
           LBSR   L107E
           BEQ    L093A
           LBSR   L29E2
           LBSR   J10C9
           TSTB
           BEQ    L093A
           BSR    L09CE
           LBSR   J136D
           LBSR   L08A5
           BRA    L093A
           CLR    <U002D
           LBRA   L0465
           LDA    <U002D
           CMPA   #144
           BEQ    L093A
           LBSR   L059B
           BRA    L093A
L0970      FCC    "CHALLENGE MATCH - Select time limit"
           FCB    $00
           LBSR   L0A7A
           LDD    #518
           LBSR   L28D5
           LEAU   >L0970,PC
           LBSR   L0FA2
           LEAU   >L27E4,PC
           LBRA   L2AB4
           LDA    #10
           STA    <U004A
           LBRA   L0490
           LDA    #20
           STA    <U004A
           LBRA   L0490
           LDA    #30
           STA    <U004A
           LBRA   L0490
           LDA    #60
           STA    <U004A
           LBRA   L0490
L09C7      PSHS   U,Y,X,D
           LBSR   J173E
           PULS   PC,U,Y,X,D
L09CE      DEC    <U002D
           PSHS   B
           LDX    #2162
           LDB    <U002D
           CLRA
           LEAX   D,X
           PULS   B
           STB    ,X
           COM    ,U
           LBSR   J173E
           CLRA
           CLRB
           STD    <U0008
           RTS
L09E8      LEAS   -4,S
           LEAX   ,S
           LDD    #6961
           STD    ,X
           CLR    ,-S
L09F3      LDB    ,U+
           LDA    ,S
           STD    U0002,X
           CMPA   #14
           BNE    L0A01
           STB    <U005D
           BRA    L0A07
L0A01      CMPA   #15
           BNE    L0A07
           STB    <U005C
L0A07      CLRA
           LDY    #4
           OS9    I$Write
           INC    ,S
           LDB    ,S
           CMPB   #16
           BNE    L09F3
           LEAS   5,S
           RTS
L0A1A      FCB    $47
           FCB    $16
           FCB    $21
           FCB    $20
           FCB    $1F
           FCB    $1E
           FCB    $1D
           FCB    $1C
           FCB    $1B
           FCB    $1A
           FCB    $19
           FCB    $18
           FCB    $17
           FCB    $16
           FCB    $15
           FCB    $14
           FCB    $13
           FCB    $12
           FCB    $11
           FCB    $10
           FCB    $0F
           FCB    $0E
           FCB    $01
           FCB    $00
           FCB    $CC
           FCB    $CC
           FCB    $CC
           FCB    $CC
           FCB    $CC
           FCB    $CC
           FCB    $CC
           FCB    $CC
           FCB    $CC
           FCB    $CC
           FCB    $B0
           FCB    $00
           FCB    $CC
           FCB    $FF
           FCB    $FF
           FCB    $FF
           FCB    $FF
           FCB    $FF
           FCB    $FF
           FCB    $FF
           FCB    $FF
           FCB    $CC
           FCB    $B0
           FCB    $00
L0A4A      FCB    $17
           FCC    /"! /
           FCB    $1F
           FCB    $1E
           FCB    $1D
           FCB    $1C
           FCB    $1B
           FCB    $1A
           FCB    $19
           FCB    $18
           FCB    $17
           FCB    $16
           FCB    $15
           FCB    $14
           FCB    $13
           FCB    $12
           FCB    $11
           FCB    $10
           FCB    $0F
           FCB    $0E
           FCB    $0D
           FCB    $0C
           FCB    $BB
           FCB    $BB
           FCB    $BB
           FCB    $BB
           FCB    $BB
           FCB    $BB
           FCB    $BB
           FCB    $BB
           FCB    $BB
           FCB    $BB
           FCB    $B0
           FCB    $00
           FCB    $DD
           FCB    $DD
           FCB    $DD
           FCB    $DD
           FCB    $DD
           FCB    $DD
           FCB    $DD
           FCB    $DD
           FCB    $DD
           FCB    $DD
           FCB    $B0
           FCB    $00
L0A7A      CLR    <U0007
           CLR    <U0020
L0A7E      TST    <U0000
           BEQ    L0A86
           CLRA
           CLRB
           BRA    L0A89
L0A86      LDD    #-26215
L0A89      LDY    #32000
           LDX    <U0053
L0A8F      STD    ,X++
           STD    ,X++
           STD    ,X++
           STD    ,X++
           STD    ,X++
           STD    ,X++
           STD    ,X++
           STD    ,X++
           STD    ,X++
           STD    ,X++
           STD    ,X++
           STD    ,X++
           STD    ,X++
           STD    ,X++
           STD    ,X++
           STD    ,X++
           LEAY   <-$20,Y
           BNE    L0A8F
           RTS
SetScrn    LDD    #SS.ScTyp
           OS9    I$GetStt     Get the screen type
           STA    <ScTyp       Store the screen type
           CLRA
           LDB    #SS.ScSiz
           OS9    I$GetStt     Get the screen size
           STX    <ScnWidth    Store the screen width
           STY    <ScnHeight   Store the screen height
           LDB    #SS.FBRgs
           OS9    I$GetStt     Get the foreground, background, and border palette registers
           STA    <Foreground  Store the foreground palette register
           STB    <Background  Store the background palette register
           TFR    X,D          Put the border in D
           STB    <Border      Store the border palette register
           LDD    #SS.Palet
           LDX    #2628
           OS9    I$GetStt     Get the palette information
           LDA    <ScTyp       Get the screen type
           CMPA   #8           Is it 320x192 16 color?
           BEQ    L0B4E        Yes, keep going
L0AE4      LEAX   >L0036,PC
           LDY    #16
           LDA    #1
           OS9    I$Write
           BCC    L0B60        Keep going if successful
           LEAX   >AllocErr,PC
           LDY    #62
           LDA    #2
           OS9    I$Write      Write the error message
           LDD    #SS.Opt
           LDX    #130
           OS9    I$SetStt     Restore the original options
           LBSR   L044A
           CLRB
           OS9    F$Exit       Exit
AllocErr   FCC    "Shanghai: There was an error allocating the graphics screen."
           FCB    $0D
           FCB    $0A
L0B4E      LDX    <ScnWidth
           LDY    <ScnHeight
           CMPX   #40          Is it 40 chars wide
           BNE    L0AE4
           CMPY   #24
           BCC    L0B60
           BRA    L0AE4
L0B60      LDB    #143
           CLRA
           OS9    I$GetStt
           BCS    L0B7D
L0B68      CLRA
           STD    <U0055
           TFR    D,X
           LDB    #4
           OS9    F$MapBlk
           STU    <U0053
           OS9    F$ID
           LDU    #2646
           LBRA   L09E8
L0B7D      LDA    #1
           LDB    #14
           LDX    #194
           OS9    I$GetStt
           LDX    #98
           LDY    #194
           LBSR   L0C66
           LDX    #194
           LDA    #1
           OS9    F$GPrDsc
           LDY    #194
           LEAX   <$40,X
           LDB    #16
L0BA2      LDA    ,X+
           STA    ,Y+
           DECB
           BNE    L0BA2
           LEAS   -2,S
           LDD    #194
           LEAU   ,S
           LDY    #2
           LDX    #128
           OS9    F$CpyMem
           LDD    #194
           LDU    #210
           LDY    #288
           LDX    ,S++
           OS9    F$CpyMem
           CLRB
           PSHS   B
           LDX    #210
           PSHS   X
L0BD1      LDX    ,S
           LDA    U0008,X
           BEQ    L0C0E
           LEAS   -7,S
           LDD    #194
           LEAU   ,S
           LDX    7,S
           LDX    U0004,X
           LEAX   U0004,X
           LDY    #2
           OS9    F$CpyMem
           LDD    ,S
           LDX    7,S
           LDX    U0004,X
           LEAX   D,X
           LDD    #194
           LEAU   ,S
           LDY    #5
           OS9    F$CpyMem
           LEAX   ,S
           LEAY   ,S
           BSR    L0C66
           LDX    #98
           BSR    L0C78
           BCC    L0C24
           LEAS   7,S
L0C0E      LDX    ,S
           LEAX   U0009,X
           STX    ,S
           LDB    2,S
           INCB
           STB    2,S
           CMPB   #32
           BNE    L0BD1
           LEAS   3,S
           LDB    #221
           OS9    F$Exit
L0C24      LEAS   7,S
           LDD    #194
           LDX    ,S++
           LDX    U0002,X
           LEAX   <$35,X
           LDY    #1
           LEAU   ,S
           OS9    F$CpyMem
           LDA    ,S+
           LDB    #64
           MUL
           LDX    #4736
           LEAX   D,X
           LDD    #194
           LDY    #64
           LDU    #210
           OS9    F$CpyMem
           LDD    #194
           LDY    #32
           LDX    >U00D2
           LDU    #210
           OS9    F$CpyMem
           LDB    >U00D3
           LBRA   L0B68
L0C66      PSHS   Y,X
L0C68      LDA    ,Y+
           BMI    L0C70
           STA    ,X+
           BRA    L0C68
L0C70      ANDA   #127
           STA    ,X+
           CLR    ,X
           PULS   PC,Y,X
L0C78      PSHS   Y,X
L0C7A      LDA    ,X+
           BEQ    L0C85
           CMPA   ,Y+
           BEQ    L0C7A
           COMA
           PULS   PC,Y,X
L0C85      CLRA
           PULS   PC,Y,X
L0C88      PSHS   U,X,B
           PSHS   B
           LEAX   -1,X
           LSRB
           LSRB
           LSRB
           LSRB
           ANDB   #15
           DECB
           LEAU   >L0D4C,PC
           ASLB
           LEAU   B,U
           LDD    ,U
           LDU    #2692
           LEAU   D,U
           PULS   B
           ANDB   #15
           DECB
           LDA    #231
           MUL
           LEAU   D,U
           TFR    X,D
           PSHS   B
           LSRA
           RORB
           TFR    D,X
           LBSR   L0E19
           LEAX   >X0140,X
           PULS   B
           ANDB   #1
           LDA    #255
           MUL
           COMB
           INCB
           LDA    #21
           PSHS   A
L0CC9      DEC    ,S
           BLT    L0CEF
           LDA    #10
           PSHS   X,A
           TSTB
           BNE    L0CDD
           LDA    ,U
           LSRA
           LSRA
           LSRA
           LSRA
           BSR    L0D2F
           FCB    $8C
L0CDD      LEAX   U0001,X
L0CDF      BSR    L0CFF
           DEC    ,S
           BNE    L0CDF
           PULS   X,A
           LEAX   >X00A0,X
           LEAU   U0001,U
           BRA    L0CC9
L0CEF      PULS   A
           PULS   PC,U,X,B
L0CF3      LDD    ,U+
           ASLB
           ROLA
           ASLB
           ROLA
           ASLB
           ROLA
           ASLB
           ROLA
           BRA    L0D06
L0CFF      PSHS   D
           TSTB
           BEQ    L0CF3
           LDA    ,U+
L0D06      CMPA   #221
           BNE    L0D0E
           LEAX   U0001,X
           PULS   PC,D
L0D0E      BSR    L0D12
           PULS   PC,D
L0D12      PSHS   A
           LDA    ,X
           ANDA   #240
           PSHS   A
           LDA    1,S
           ANDA   #240
           CMPA   #208
           BNE    L0D23
           FCB    $8C
L0D23      STA    ,S
           LDA    ,X
           ANDA   #15
           ORA    ,S+
           STA    ,X
           PULS   A
L0D2F      PSHS   A
           LDA    ,X
           ANDA   #15
           PSHS   A
           LDA    1,S
           ANDA   #15
           CMPA   #13
           BNE    L0D40
           FCB    $8C
L0D40      STA    ,S
           LDA    ,X
           ANDA   #240
           ORA    ,S+
           STA    ,X+
           PULS   PC,A
L0D4C      FCB    $00
           FCB    $00
           FCB    $02
           FCB    $B5
           FCB    $06
           FCB    $51
           FCB    $09
           FCB    $ED
           FCB    $0D
           FCB    $89
           FCB    $15
           FCB    $A8
           FCB    $1D
           FCB    $C7
L0D5A      PSHS   U,X
           TFR    X,D
           ANDB   #1
           BNE    L0DA3
           TFR    X,D
           LSRA
           RORB
           TFR    D,X
           LBSR   L0E19
           LDA    #24
           PSHS   U,A
L0D6F      DEC    ,S
           BLT    L0D9F
           TFR    X,Y
           LDU    1,S
           LDB    ,U+
           STU    1,S
           LEAU   B,U
           LDD    ,U++
           STD    ,Y++
           LDD    ,U++
           STD    ,Y++
           LDD    ,U++
           STD    ,Y++
           LDD    ,U++
           STD    ,Y++
           LDD    ,U++
           STD    ,Y++
           LDA    ,Y
           ANDA   #15
           ORA    ,U+
           STA    ,Y+
           LEAX   >X00A0,X
           BRA    L0D6F
L0D9F      PULS   U,A
           PULS   PC,U,X
L0DA3      TFR    X,D
           LSRA
           RORB
           TFR    D,X
           BSR    L0E19
           LDA    #24
           PSHS   U,A
L0DAF      DEC    ,S
           BLT    L0DE9
           LDU    1,S
           LDB    ,U+
           STU    1,S
           LEAU   B,U
           TFR    X,Y
           LDA    ,Y
           ANDA   #240
           STA    ,Y
           LDA    ,U
           ANDA   #240
           LSRA
           LSRA
           LSRA
           LSRA
           ORA    ,Y
           STA    ,Y+
           BSR    L0DED
           BSR    L0DED
           BSR    L0DED
           BSR    L0DED
           BSR    L0DED
           BSR    L0DED
           BSR    L0DED
           BSR    L0DED
           BSR    L0DED
           BSR    L0DED
           LEAX   >X00A0,X
           BRA    L0DAF
L0DE9      PULS   U,A
           PULS   PC,U,X
L0DED      LDA    ,U+
           LDB    ,U
           ANDB   #240
           ASLB
           ROLA
           ASLB
           ROLA
           ASLB
           ROLA
           ASLB
           ROLA
           STA    ,Y+
           RTS
L0DFE      LBSR   L19BC
           LEAX   >L1F62,PC
L0E05      LDA    ,X+
           LBEQ   L19C9
           DECA
           LDB    #7
           MUL
           LDU    #1154
           LEAU   D,U
           LBSR   L1830
           BRA    L0E05
L0E19      PSHS   A
           LEAX   >$4002,X
           LDA    <U0021
           CMPA   #9
           BNE    L0E29
           LEAX   >X0280,X
L0E29      PULS   PC,A
L0E2B      PSHS   U,Y,X,B
           LBSR   L115C
L0E30      PSHS   B
           LDX    #2678
           OS9    F$Time
           PULS   B
           CLRA
           CMPB   #1
           BEQ    L0E41
           LDB    #2
L0E41      TFR    D,Y
           LDB    #137
           LDX    #98
           OS9    I$GetStt
           TST    ,X
           BNE    L0E63
           LDX    #2684
           OS9    F$Time
           LDX    #2678
           OS9    F$Time
           LDX    #20
           OS9    F$Sleep
           BRA    L0E30
L0E63      INC    <U0024
           LDA    <U0024
           ANDA   #16
           BEQ    L0E75
           LDA    <U005C
           CMPA   <U0061
           BEQ    L0E80
           STA    <U0061
           BRA    L0E7D
L0E75      LDA    <U005D
           CMPA   <U0061
           BEQ    L0E80
           STA    <U0061
L0E7D      STA    >-67
L0E80      PSHS   X
           LDX    #2682
           LDD    ,X++
           CMPD   U0004,X
           BEQ    L0EB4
           OS9    F$Time
           LDX    #2678
           OS9    F$Time
           DEC    <U0026
           BGE    L0EA7
           LDA    #59
           STA    <U0026
           TST    <U0025
           BEQ    L0EA5
           DEC    <U0025
           BRA    L0EA7
L0EA5      CLR    <U0026
L0EA7      TST    <U0020
           BEQ    L0EB4
           DEC    <U0020
           LDA    <U0020
           BNE    L0EB4
           LBSR   L1461
L0EB4      PULS   X
           LDD    <$18,X
           LSRA
           RORB
           STD    <$18,X
           CMPD   <U0037
           BNE    L0ECA
           LDD    <$1A,X
           CMPB   <U0039
           BEQ    L0EE9
L0ECA      LBSR   L12BF
           LDD    <$18,X
           CMPD   #310
           BLS    L0ED9
           LDD    #310
L0ED9      STD    <U0037
           LDD    <$1A,X
           CMPB   #190
           BLS    L0EE4
           LDB    #190
L0EE4      STB    <U0039
           LBSR   L115C
L0EE9      PULS   PC,U,Y,X,B
L0EEB      PSHS   B
L0EED      LDA    <U0033
           LDB    #5
           MUL
           PSHS   D
           LDA    <U0034
           LDB    #8
           MUL
           ADDD   ,S++
           EXG    A,B
           CLRB
           PSHS   D
           LDA    <U0034
           LDB    #5
           MUL
           ADDD   ,S++
           ADDD   #14449
           STD    <U0033
           CMPA   ,S
           BHI    L0EED
           TSTA
           BEQ    L0EED
           PULS   B
           EXG    A,B
           CLRA
           RTS
L0F19      LEAX   >L1FBA,PC
           LDA    #144
           DECB
           MUL
           LEAX   D,X
           LEAY   >L1C02,PC
           LDU    #1154
           LDA    #144
           STA    <U002D
           PSHS   A
L0F30      DEC    ,S
           LDA    ,S
           CMPA   #255
           BEQ    L0F4A
           LDA    ,X+
           STA    ,U+
           LDD    ,Y++
           STD    ,U++
           LDD    ,Y++
           STD    ,U++
           LDD    ,Y++
           STD    ,U++
           BRA    L0F30
L0F4A      PULS   PC,A
L0F4C      LDA    #144
           PSHS   A
L0F50      DEC    ,S
           LDA    ,S
           CMPA   #255
           BEQ    L0F78
           LDB    #144
           BSR    L0EEB
           DECB
           LDA    #7
           MUL
           LDX    #1154
           TFR    X,Y
           LEAX   D,X
           LDB    ,S
           LDA    #7
           MUL
           LEAY   D,Y
           LDA    ,X
           LDB    ,Y
           STA    ,Y
           STB    ,X
           BRA    L0F50
L0F78      PULS   PC,A

J0F7A      CLR    <U0006
           LDX    #1154
           LDA    #144
           STA    <U002D
L0F83      TST    ,X
           BGT    L0F89
           COM    ,X
L0F89      LEAX   U0007,X
           DECA
           BNE    L0F83
           RTS

L0F8F      LDB    #144
           STB    <U002D
           CLR    <U0006
           LDB    <U0021
           LBNE   L0F19
           LDB    #1
           LBSR   L0F19
           BRA    L0F4C
L0FA2      LDB    ,U+
           BEQ    L0FAA
           BSR    L0FDC
           BRA    L0FA2
L0FAA      CLR    <U0041
           RTS
ASCII      FCC    " ,*?#'-.0123456789:@ABCDEFGHIJKLMNOPQRSTUVWXYZ"
           FCB    $00
L0FDC      PSHS   U,Y,X,D
           CMPB   #97
           BCS    L0FE4
           SUBB   #32
L0FE4      LEAU   >L24CA,PC
           LEAY   >ASCII,PC
L0FEC      TST    ,Y
           BEQ    L0FF8
           CMPB   ,Y+
           BEQ    L0FFC
           LEAU   U0008,U
           BRA    L0FEC
L0FF8      LEAU   >L24CA,PC
L0FFC      LDA    #8
           PSHS   A
L1000      DEC    ,S
           BLT    L100E
           LDA    ,U+
           BSR    L1015
           LEAX   >X00A0,X
           BRA    L1000
L100E      PULS   A
           PULS   U,Y,X,D
           LEAX   U0004,X
           RTS
L1015      PSHS   A
           LDA    #255
           STA    <U0030
           TST    <U000A
           BEQ    L1022
           CLRA
           STA    <U0030
L1022      TST    <U0041
           BEQ    L102A
           LDA    #221
           STA    <U0030
L102A      PULS   A
           LDB    #153
           TST    <U000A
           BEQ    L1034
           LDB    #17
L1034      TST    <U0000
           BEQ    L1039
           CLRB
L1039      STB    ,X
           STB    U0001,X
           STB    U0002,X
           STB    U0003,X
           LDB    #255
           PSHS   A
L1045      LDA    ,S
           BEQ    L107C
           INCB
           ASLA
           STA    ,S
           BCC    L1045
           TFR    X,Y
           TFR    B,A
           LSRA
           LEAY   A,Y
           TFR    B,A
           ANDA   #1
           BEQ    L106C
           LDA    ,Y
           ANDA   #240
           PSHS   A
           LDA    <U0030
           ANDA   #15
           ORA    ,S+
           STA    ,Y
           BRA    L1045
L106C      LDA    ,Y
           ANDA   #15
           PSHS   A
           LDA    <U0030
           ANDA   #240
           ORA    ,S+
           STA    ,Y
           BRA    L1045
L107C      PULS   PC,A
L107E      PSHS   Y,X
           LDU    #53
           CLRA
           CMPB   #1
           BEQ    L108C
           LDB    #2
           LEAU   U0001,U
L108C      TFR    D,Y
           LDX    #98
           LDB    #137
           OS9    I$GetStt
           LDB    ,X
           LDA    U0008,X
           PULS   Y,X
           TSTB
           BEQ    L10AB
           TSTA
           BEQ    L10AB
           TST    ,U
           BNE    L10AB
           INC    ,U
           LDB    #1
           RTS
L10AB      CLR    ,U
           CLRB
           RTS

J10AF      PSHS   Y,D
           TFR    D,Y
           CLR    U0002,U
           LSRA
           RORB
L10B7      SUBD   #160
           BLT    L10C4
           INC    U0002,U
           LEAY   >-320,Y
           BRA    L10B7
L10C4      STY    ,U
           PULS   PC,Y,D

J10C9      LDA    #144
           PSHS   A
L10CD      DEC    ,S
           LDA    ,S
           LDB    #7
           MUL
           LDX    #1154
           LEAX   D,X
           TST    ,X
           BLE    L1152
           TST    U0005,X
           BEQ    L10F0
           LDA    U0005,X
           DECA
           LDB    #7
           LDU    #1154
           MUL
           LEAU   D,U
           TST    ,U
           BGT    L1152
L10F0      CLRA
           LDB    ,S
           INCB
           TFR    D,Y
           LDD    U0001,X
           EXG    D,X
           LBSR   L0E19
           STD    <U0003
           LDA    ,S
           CMPA   #143
           BCS    L1109
           LEAX   >$FEC1,X
L1109      CMPA   #139
           BCS    L1111
           LEAX   >$FEC1,X
L1111      CMPA   #123
           BCS    L1119
           LEAX   >$FEC1,X
L1119      CMPA   #87
           BCS    L1121
           LEAX   >$FEC1,X
L1121      LDD    <U0003
           EXG    D,X
           SUBD   <U0053
           LDU    #58
           LBSR   J10AF
           LDA    <U0039
           CMPA   <U003C
           BCS    L1152
           LDA    <U003C
           ADDA   #23
           CMPA   <U0039
           BCS    L1152
           LDD    <U0037
           CMPD   <U003A
           BCS    L1152
           LDD    <U003A
           ADDD   #20
           CMPD   <U0037
           BCS    L1152
           TFR    X,U
           PULS   B
           INCB
           RTS
L1152      TST    ,S
           LBNE   L10CD
           PULS   B
           CLRB
           RTS
L115C      PSHS   U,Y,X,D
           TST    <U0007
           LBNE   L12BD
           LDA    #1
           STA    <U0007
           LBSR   L12EB
           PSHS   X,B
           LDY    #2566
           STX    ,Y++
           LDA    #10
           PSHS   A
L1177      DEC    ,S
           BLT    L118D
           LDD    ,X++
           STD    ,Y++
           LDD    ,X++
           STD    ,Y++
           LDD    ,X++
           STD    ,Y++
           LEAX   >X009A,X
           BRA    L1177
L118D      PULS   A
           PULS   X,B
           ANDB   #1
           LBEQ   L1231
           LDA    ,X
           ORA    #15
           STA    ,X
           LDD    #-1
           STD    U0001,X
           STA    U0003,X
           LDB    #160
           ABX
           LDA    ,X
           ORA    #15
           STA    ,X
           CLR    U0001,X
           CLR    U0002,X
           LDA    U0003,X
           ORA    #240
           STA    U0003,X
           ABX
           LDA    ,X
           ORA    #15
           STA    ,X
           CLR    U0001,X
           LDA    #15
           STA    U0002,X
           ABX
           LDA    ,X
           ORA    #15
           STA    ,X
           CLR    U0001,X
           CLR    U0002,X
           LDA    U0003,X
           ORA    #240
           STA    U0003,X
           ABX
           LDA    ,X
           ORA    #15
           STA    ,X
           LDA    #15
           STA    U0001,X
           CLR    U0002,X
           STA    U0003,X
           ABX
           LDA    ,X
           ORA    #15
           STA    ,X
           LDA    U0001,X
           ORA    #240
           STA    U0001,X
           LDA    #240
           STA    U0002,X
           CLR    U0003,X
           LDA    U0004,X
           ORA    #240
           STA    U0004,X
           ABX
           LDA    ,X
           ORA    #15
           STA    ,X
           LDA    U0002,X
           ORA    #15
           STA    U0002,X
           CLR    U0003,X
           LDA    #15
           STA    U0004,X
           ABX
           LDA    #240
           STA    U0003,X
           CLR    U0004,X
           LDA    U0005,X
           ORA    #240
           STA    U0005,X
           ABX
           LDA    U0003,X
           ORA    #15
           STA    U0003,X
           LDA    #15
           STA    U0004,X
           ABX
           LDA    U0004,X
           ORA    #240
           STA    U0004,X
           PULS   PC,U,Y,X,D
L1231      LDD    #-1
           STD    ,X
           STA    U0002,X
           LDA    U0003,X
           ORA    #240
           STA    U0003,X
           LEAX   >X00A0,X
           LDD    #-4081
           STA    ,X
           CLR    U0001,X
           STB    U0002,X
           LEAX   >X00A0,X
           STA    ,X
           CLR    U0001,X
           LDA    U0002,X
           ORA    #240
           STA    U0002,X
           LEAX   >X00A0,X
           LDD    #-4081
           STA    ,X
           CLR    U0001,X
           STB    U0002,X
           LEAX   >X00A0,X
           STA    ,X
           STA    U0001,X
           CLR    U0002,X
           LDA    U0003,X
           ORA    #240
           STA    U0003,X
           LEAX   >X00A0,X
           LDD    #-241
           STA    ,X
           CLR    U0002,X
           STB    U0003,X
           LDA    U0001,X
           ORA    #15
           STA    U0001,X
           LDB    #160
           ABX
           LDA    #240
           STA    U0002,X
           LDA    ,X
           ORA    #240
           STA    ,X
           CLR    U0003,X
           LDA    U0004,X
           ORA    #240
           STA    U0004,X
           ABX
           LDA    U0002,X
           ORA    #15
           STA    U0002,X
           CLR    U0003,X
           LDA    #15
           STA    U0004,X
           ABX
           LDA    #240
           STA    U0003,X
           LDA    U0004,X
           ORA    #240
           STA    U0004,X
           ABX
           LDA    U0003,X
           ORA    #15
           STA    U0003,X
L12BD      PULS   PC,U,Y,X,D
L12BF      PSHS   U,Y,X,D
           TST    <U0007
           BEQ    L12E9
           CLR    <U0007
           LDY    #2566
           LDX    ,Y++
           LDA    #10
           PSHS   A
L12D1      DEC    ,S
           BLT    L12E7
           LDD    ,Y++
           STD    ,X++
           LDD    ,Y++
           STD    ,X++
           LDD    ,Y++
           STD    ,X++
           LEAX   >X009A,X
           BRA    L12D1
L12E7      PULS   A
L12E9      PULS   PC,U,Y,X,D
L12EB      LDB    <U0039
           LDX    <U0053
           LDA    #160
           MUL
           LEAX   D,X
           LDD    <U0037
           PSHS   B
           LSRA
           RORB
           LEAX   D,X
           PULS   PC,B

J12FE      PSHS   U,Y,X,D
           BSR    L1304
           PULS   PC,U,Y,X,D
L1304      PSHS   B
           LDY    #0
           LDA    #48
           LDB    ,S
L130E      SUBB   #100
           BCS    L1317
           STB    ,S
           INCA
           BRA    L130E
L1317      CMPA   #48
           BEQ    L1324
           EXG    B,A
           LBSR   L0FDC
           EXG    B,A
           LEAY   1,Y
L1324      LDA    #48
           LDB    ,S
L1328      SUBB   #10
           BLT    L1331
           STB    ,S
           INCA
           BRA    L1328
L1331      LEAY   ,Y
           BNE    L1339
           CMPA   #48
           BEQ    L1342
L1339      EXG    B,A
           LBSR   L0FDC
           EXG    B,A
           LEAY   1,Y
L1342      LDA    #48
           ADDA   ,S
           EXG    B,A
           LBSR   L0FDC
           EXG    B,A
           LEAY   1,Y
           TFR    Y,D
           CMPB   #3
           BEQ    L136B
           PSHS   B
           LDB    #32
           LBSR   L0FDC
           PULS   B
           CMPB   #1
           BNE    L136B
           PSHS   B
           LDB    #32
           LBSR   L0FDC
           PULS   B
L136B      PULS   PC,B

J136D      PSHS   U,Y,X,D
           LDD    #530
           LBSR   L28D5
           LEAX   >X0280,X
           LEAU   >Tiles,PC
           LBSR   L0FA2
           LDD    #787
           LBSR   L28D5
           LEAX   >X0320,X
           LDB    <U002D
           CLRA
           LBSR   J12FE
           PULS   PC,U,Y,X,D
Tiles      FCC    "Tiles"
           FCB    $00

Intercept  STB    <U005B
           RTI

J139B      PSHS   B
           LDA    #48
           LDB    ,S
L13A1      SUBB   #10
           BLT    L13AA
           STB    ,S
           INCA
           BRA    L13A1
L13AA      LEAY   ,Y
           BEQ    L13B2
           CMPA   #48
           BEQ    L13B9
L13B2      EXG    B,A
           LBSR   L0FDC
           EXG    B,A
L13B9      LDA    #48
           ADDA   ,S
           EXG    B,A
           LBSR   L0FDC
           EXG    B,A
           PULS   PC,B

J13C6      PSHS   U,Y,X,D
           LDD    #16
           LBSR   L28D5
           LEAX   >$FD82,X
           TST    <U004A
           BEQ    L13EB
           LEAU   >Secs,PC
           TST    <U004A
           BGT    L13E2
           LEAU   >Mins,PC
L13E2      LBSR   L0FA2
           LDA    #255
           STA    <U0022
           BSR    L13F7
L13EB      PULS   PC,U,Y,X,D
Mins       FCC    "Mins"
           FCB    $00
Secs       FCC    "Secs"
           FCB    $00
L13F7      PSHS   U,Y,X,D
           LDB    <U0026
           CMPB   <U0022
           BEQ    L142C
           STB    <U0022
           LBSR   L12BF
           LDD    #273
           LBSR   L28D5
           LEAX   >$FE22,X
           LDY    #0
           LDB    <U0026
           TST    <U004A
           BGE    L1426
           LDB    <U0025
           LEAX   -6,X
           LBSR   J139B
           LDB    #58
           LBSR   L0FDC
           LDB    <U0026
L1426      LBSR   J139B
           LBSR   L115C
L142C      PULS   PC,U,Y,X,D

J142E      LDA    #4
           STA    <U0020
           PSHS   Y
           PSHS   X
           BSR    L1461
           LDD    #7699
           LBSR   L28D5
           LEAX   >$FD80,X
           LDU    ,S++
           LBSR   L0FA2
           LDD    #7700
           LBSR   L28D5
           LEAX   >$FD80,X
           LDU    ,S++
           PSHS   U
           PULS   D
           BEQ    L145C
           LBSR   L0FA2
L145C      LDA    #4
           STA    <U0020
           RTS
L1461      LDA    <U0007
           PSHS   A
           BEQ    L146A
           LBSR   L12BF
L146A      LDD    #7699
           LBSR   L28D5
           LEAX   >$FD80,X
           BSR    L148B
           LDD    #7700
           LBSR   L28D5
           LEAX   >$FD80,X
           BSR    L148B
           PULS   A
           TSTA
           BEQ    L148A
           LBSR   L115C
L148A      RTS
L148B      LDA    #8
           PSHS   A
           LDD    #-26215
L1492      DEC    ,S
           BLT    L14C3
           STD    ,X++
           STD    ,X++
           STD    ,X++
           STD    ,X++
           STD    ,X++
           STD    ,X++
           STD    ,X++
           STD    ,X++
           STD    ,X++
           STD    ,X++
           STD    ,X++
           STD    ,X++
           STD    ,X++
           STD    ,X++
           STD    ,X++
           STD    ,X++
           STD    ,X++
           STD    ,X++
           STD    ,X++
           STD    ,X++
           LEAX   <$78,X
           BRA    L1492
L14C3      PULS   PC,A

J14C5      PSHS   B
           PSHS   U
           TST    ,U
           BLE    L1504
           LDB    U0005,U
           BEQ    L14DE
           LDA    #7
           DECB
           MUL
           LDU    #1154
           LEAU   D,U
           TST    ,U
           BGT    L1504
L14DE      LDU    ,S
           LDB    U0003,U
           BEQ    L150C
           LDA    #7
           DECB
           MUL
           LDU    #1154
           LEAU   D,U
           TST    ,U
           BLE    L150C
           LDU    ,S
           LDB    U0004,U
           BEQ    L150C
           LDA    #7
           DECB
           MUL
           LDU    #1154
           LEAU   D,U
           TST    ,U
           BLE    L150C
L1504      PULS   U
           PULS   B
           LDA    #1
           TSTA
           RTS
L150C      PULS   U
           PULS   B
           CLRA
           TSTA
           RTS
L1513      PSHS   D,CC
           ORCC   #80
           LDA    >-221
           PSHS   A
           ORA    #8
           STA    >-221
           LDA    >-255
           PSHS   A
           ANDA   #247
           STA    >-255
           LDA    >-253
           PSHS   A
           ANDA   #247
           STA    >-253
           CLRB
L1536      LEAX   >L1568,PC
           LDA    #32
           PSHS   A
L153E      DEC    ,S
           BLT    L1552
           LDA    ,X+
           PSHS   B
           MUL
           ASLA
           ASLA
           ANDA   #252
           STA    >-224
           PULS   B
           BRA    L153E
L1552      PULS   A
           DECB
           BNE    L1536
           PULS   A
           STA    >-253
           PULS   A
           STA    >-255
           PULS   A
           STA    >-221
           PULS   PC,D,CC
L1568      FCB    $20
           FCB    $26
           FCB    $2C
           FCB    $31
           FCB    $36
           FCB    $3A
           FCB    $3F
           FCB    $3F
           FCB    $3F
           FCB    $3D
           FCB    $3A
           FCB    $36
           FCB    $31
           FCB    $2C
           FCB    $26
           FCB    $20
           FCB    $19
           FCB    $13
           FCB    $0E
           FCB    $09
           FCB    $05
           FCB    $02
           FCB    $00
           FCB    $00
           FCB    $00
           FCB    $02
           FCB    $05
           FCB    $09
           FCB    $0E
           FCB    $13
           FCB    $19

* Guessing this is where a code block starts
J1587      CLR    <U0002
           TST    <U002D
           BNE    L15FF
           INC    <U0002
           LBSR   J136D
           LDA    <U0017
           PSHS   A
           INC    <U0017
           LBSR   L2BEA
           LBSR   L12BF
           LBSR   L1513
           BSR    Sleep120
           INC    <U0000
           LEAU   >L30B2,PC
           LBSR   L09E8
           LBSR   L0A7A
           LEAU   >L30D2,PC
           LBSR   L1B86
           LDD    #1294
           LBSR   L28D5
           LEAU   >ConqDrag,PC
           LBSR   L0FA2
           BSR    L1600
           CLR    <U0000
           LBSR   L0A7A
           LBSR   L115C
           PULS   A
           STA    <U0017
           LDU    >U0A54
           LBRA   L09E8
ConqDrag   FCC    "You have conquered the dragon"
           FCB    $00
Sleep120   LDX    #120
Sleep      OS9    F$Sleep
           LEAX   ,X
           BNE    Sleep
L15FF      RTS
L1600      LBSR   L1B3F
           CLRA
           PSHS   A
L1606      BSR    L1640
           DEC    ,S
           BEQ    L1635
           CLRB
           PSHS   B
L160F      DEC    ,S
           BEQ    L1631
           LEAU   >L0465,PC
           LDA    ,S
           BNE    L161C
           INCA
L161C      LDA    A,U
           LDB    1,S
           BNE    L1623
           INCB
L1623      LDB    B,U
           MUL
           ANDA   #15
           LDB    D,U
           ANDB   #252
           STB    >-224
           BRA    L160F
L1631      PULS   A
           BRA    L1606
L1635      PULS   A
L1637      LDA    >-221
           ANDA   #247
           STA    >-221
           RTS
L1640      LBSR   L1A36
           LDX    #-79
           LDB    ,X+
           PSHS   B
           LDD    ,X++
           STD    -3,X
           LDD    ,X++
           STD    -3,X
           LDA    ,X
           PULS   B
           STD    -1,X
           RTS

J1659      LBSR   L0A7A
           LBSR   L29F1
           LDD    #1797
           LBSR   L28D5
           LEAU   >MtchRslt,PC
           LBSR   L0FA2
           LDD    #3080
           LBSR   L28D5
           LEAU   >L087F,PC
           LBSR   L0FA2
           LDD    #6664
           LBSR   L28D5
           LDB    <U0012
           LBSR   J12FE
           LDD    #3082
           LBSR   L28D5
           LEAU   >L088A,PC
           LBSR   L0FA2
           LDD    #6666
           LBSR   L28D5
           LDB    <U0013
           LBSR   J12FE
           LDA    <U0011
           CMPA   #4
           BNE    L16AF
           LDD    #1548
           LBSR   L28D5
           LEAU   >TooMany,PC
           LBSR   L0FA2
L16AF      LDD    #2322
           LBSR   L28D5
           LEAU   >MatchEnd,PC
           LBSR   L0FA2
           LDD    #2068
           LBSR   L28D5
           LEAU   >PresBtn,PC
           LBSR   L0FA2
           BRA    L1728
MtchRslt   FCC    "Challenge match results:"
           FCB    $00
PresBtn    FCC    "Press button to exit"
           FCB    $00
TooMany    FCC    "Too many turns have passed"
           FCB    $00
MatchEnd   FCC    "This match is ended"
           FCB    $00
L1728      LDD    #138
           LDX    #128
           CLR    <U005B
           OS9    I$SetStt
           TST    <U005B
           BMI    L1728
           LDX    #0
           OS9    F$Sleep
           RTS

J173E      PSHS   Y,X,D
           CMPB   #144
           BNE    L1749
           LDB    #141
           LDU    #2134
L1749      PSHS   U
           STB    <U0010
           LBSR   L12BF
           CLR    <U0020
           LBSR   L1461
           LBSR   L1B6F
           LBSR   L0A7E
           LDU    ,S
           LDA    U0004,U
           BEQ    L1772
           LDB    #7
           DECA
           MUL
           LDU    #1154
           LEAU   D,U
           LDU    U0001,U
           LEAU   >$E200,U
           BRA    L1778
L1772      LDU    U0001,U
           LEAU   >$E215,U
L1778      LBSR   L181E
           LDU    ,S
           LDU    U0001,U
           LEAU   >$E200,U
           LBSR   L181E
           LDU    ,S
           LDA    U0003,U
           BEQ    L179D
           DECA
           LDU    #1154
           LDB    #7
           MUL
           LEAU   D,U
           LDU    U0001,U
           LEAU   >$E200,U
           BRA    L17A3
L179D      LDU    U0001,U
           LEAU   >$E1EB,U
L17A3      BSR    L181E
           LBSR   L19C9
           LDX    ,S
           LDX    U0001,X
           LDB    <U0010
           CMPB   #12
           BLS    L17B6
           LEAX   >$F100,X
L17B6      LEAX   -10,X
           TFR    X,D
           LSRA
           RORB
           TFR    D,X
           LBSR   L0E19
           LDA    #36
           LDB    <U0010
           CMPB   #12
           BLS    L17CF
           CMPB   #75
           BLS    L17CD
L17CD      LDA    #48
L17CF      PSHS   X
           TFR    A,B
           PSHS   D
           LDU    #194
L17D8      DEC    ,S
           BLT    L17E7
           TFR    X,Y
           LBSR   L18A5
           LEAX   >X00A0,X
           BRA    L17D8
L17E7      PULS   A
           LBSR   L1B58
           LDX    1,S
           LDY    #194
L17F2      DEC    ,S
           BLT    L1801
           TFR    X,U
           LBSR   L18B6
           LEAX   >X00A0,X
           BRA    L17F2
L1801      LEAS   3,S
           CLRA
           CLRB
           LBSR   L115C
           PULS   U
           LBSR   J136D
           LDU    <U0018
           LBSR   L28B6
           TST    <U004A
           BEQ    L181C
           LBSR   L2BEA
           LBSR   J13C6
L181C      PULS   PC,Y,X,D
L181E      PSHS   U
           BSR    L1834
           LEAU   >U1E00,U
           BSR    L1834
           LEAU   >U1E00,U
           BSR    L1834
           PULS   PC,U
L1830      PSHS   U,Y,X,D
           BRA    L1848
L1834      PSHS   U,Y,X,D
           TFR    U,X
           LDU    #1154
           LDA    #87
L183D      CMPX   U0001,U
           BEQ    L1848
           LEAU   U0007,U
           DECA
           BNE    L183D
           PULS   PC,U,Y,X,D
L1848      LDX    U0001,U
           CLR    <U000B
L184C      TST    ,U
           BLE    L1876
           LDB    ,U
           STB    <U000B
           STX    <U000C
           STU    <U000E
           PSHS   U
           LBSR   L18EF
           PULS   U
           LDA    U0005,U
           BEQ    L1876
           CMPA   #144
           BEQ    L1876
           DECA
           LDB    #7
           MUL
           LDU    #1154
           LEAU   D,U
           LEAX   >$FD82,X
           BRA    L184C
L1876      LDB    <U000B
           BEQ    L18A3
           LDX    <U000C
           LDU    <U000E
           CMPU   <U0027
           BEQ    L1888
           CMPU   <U002A
           BNE    L188E
L1888      LEAU   >L0A4A,PC
           BRA    L1892
L188E      LEAU   >L0A1A,PC
L1892      LBSR   L0D5A
           LDX    <U000C
           LDU    <U000E
           LBSR   L1A40
           LDX    <U000C
           LDB    <U000B
           LBSR   L0C88
L18A3      PULS   PC,U,Y,X,D
L18A5      LDA    <U0010
           CMPA   #31
           BNE    L18AF
           LEAY   4,Y
           BRA    L18B3
L18AF      BSR    L18C0
           BRA    L18B5
L18B3      BSR    L18C8
L18B5      RTS
L18B6      LDA    <U0010
           CMPA   #31
           BNE    L18AF
           LEAU   U0004,U
           BRA    L18B3
L18C0      LDD    ,Y++
           STD    ,U++
           LDD    ,Y++
           STD    ,U++
L18C8      LDD    ,Y++
           STD    ,U++
           LDD    ,Y++
           STD    ,U++
           LDD    ,Y++
           STD    ,U++
           LDD    ,Y++
           STD    ,U++
           LDD    ,Y++
           STD    ,U++
           LDD    ,Y++
           STD    ,U++
           LDA    <U0010
           CMPA   #45
           BEQ    L18EE
           LDD    ,Y++
           STD    ,U++
           LDD    ,Y++
           STD    ,U++
L18EE      RTS
L18EF      PSHS   X,B
           TFR    X,D
           ANDB   #1
           BEQ    L1965
           TFR    X,D
           LSRA
           RORB
           TFR    D,X
           LBSR   L0E19
           LEAX   -1,X
           LEAX   >X00A0,X
           LDA    #186
           STA    U0001,X
           LEAX   >X00A0,X
           LDA    ,X
           ANDA   #240
           ORA    #11
           STA    ,X
           LDA    #170
           STA    U0001,X
           LEAX   >X00A0,X
           LDA    #23
           PSHS   A
L1922      DEC    ,S
           BLT    L193C
           LDA    U0001,X
           ANDA   #15
           ORA    #160
           STA    U0001,X
           LDA    ,X
           ANDA   #240
           ORA    #10
           STA    ,X
           LEAX   >X00A0,X
           BRA    L1922
L193C      PULS   A
           LEAX   >$FEC0,X
           LEAX   U0001,X
           LDA    #10
           LDB    #170
L1948      DECA
           BLT    L1953
           STB    >X00A0,X
           STB    ,X+
           BRA    L1948
L1953      LDA    #171
           STA    ,X
           LEAX   >X00A0,X
           LDA    ,X
           ANDA   #15
           ORA    #176
           STA    ,X
           BRA    L19BA
L1965      TFR    X,D
           LSRA
           RORB
           TFR    D,X
           LBSR   L0E19
           LDA    #170
           LEAX   >X009F,X
           LDA    ,X
           ANDA   #240
           ORA    #11
           STA    ,X
           LEAX   >X00A0,X
           LDA    #186
           STA    ,X
           LEAX   >X00A0,X
           LDA    #170
           LDB    #23
L198C      DECB
           BLT    L1997
           STA    ,X
           LEAX   >X00A0,X
           BRA    L198C
L1997      LEAX   >$FEC0,X
           LDA    #170
           LDB    #10
L199F      DECB
           BLT    L19AA
           STA    >X00A0,X
           STA    ,X+
           BRA    L199F
L19AA      LDA    #171
           STA    ,X
           LEAX   >X00A0,X
           LDA    ,X
           ANDA   #15
           ORA    #176
           STA    ,X
L19BA      PULS   PC,X,B
L19BC      CLR    <U0027
           CLR    <U0028
           CLR    <U0029
           CLR    <U002A
           CLR    <U002B
           CLR    <U002C
           RTS
L19C9      PSHS   U,Y,X,D
           LDU    #1154
           LEAU   >U03E9,U
           LDB    ,U
           BLE    L1A0B
           PSHS   U
           LDX    U0001,U
           LEAX   >$F608,X
           PSHS   X
           LBSR   L18EF
           LDU    2,S
           BSR    L1A40
           LDU    2,S
           CMPU   <U0027
           BEQ    L19F9
           CMPU   <U002A
           BEQ    L19F9
           LEAU   >L0A1A,PC
           BRA    L19FD
L19F9      LEAU   >L0A4A,PC
L19FD      LBSR   L0D5A
           PULS   X
           LDU    ,S
           LDB    ,U
           LBSR   L0C88
           PULS   U
L1A0B      PULS   PC,U,Y,X,D

J1A0D      LDA    ,U
           CMPA   ,Y
           BEQ    L1A2F
           ANDA   #240
           CMPA   #48
           BEQ    L1A27
           CMPA   #64
           BNE    L1A32
           LDA    ,Y
           ANDA   #240
           CMPA   #64
           BEQ    L1A2F
           BRA    L1A32
L1A27      LDA    ,Y
           ANDA   #240
           CMPA   #48
           BNE    L1A32
L1A2F      CLRA
           TSTA
           RTS
L1A32      LDA    #1
           TSTA
           RTS
L1A36      PSHS   X
           LDX    #2
           OS9    F$Sleep
           PULS   PC,X
L1A40      PSHS   X
           PSHS   U
           LDA    U0004,U
           BEQ    L1A55
           DECA
           LDU    #1154
           LDB    #7
           MUL
           LEAU   D,U
           LDA    ,U
           BGT    L1AA8
L1A55      LDU    ,S
           LDD    2,S
           LSRA
           RORB
           TFR    D,X
           LBSR   L0E19
           LDD    2,S
           ANDB   #1
           BEQ    L1A86
           LEAX   U000B,X
           BSR    L1AAC
           LDA    #22
           PSHS   A
L1A6E      DEC    ,S
           BLT    L1A7C
           LEAX   >X00A0,X
           BSR    L1AAC
           BSR    L1AC6
           BRA    L1A6E
L1A7C      PULS   B
           LEAX   >X00A0,X
           BSR    L1AAC
           BRA    L1AA8
L1A86      LEAX   U000A,X
           BSR    L1AC6
           LDA    #22
           PSHS   A
L1A8E      DEC    ,S
           BLT    L1AA0
           LEAX   >X00A0,X
           BSR    L1AC6
           LEAX   U0001,X
           BSR    L1AAC
           LEAX   -1,X
           BRA    L1A8E
L1AA0      PULS   B
           LEAX   >X00A0,X
           BSR    L1AC6
L1AA8      PULS   U
           PULS   PC,X
L1AAC      PSHS   U
           LDB    ,X
           TFR    B,A
           ANDA   #15
           ANDB   #240
           LSRB
           LSRB
           LSRB
           LSRB
           LEAU   >L1ADE,PC
           LDB    B,U
           ASLB
           ASLB
           ASLB
           ASLB
           BRA    L1AD6
L1AC6      PSHS   U
           LDB    ,X
           TFR    B,A
           ANDA   #240
           ANDB   #15
           LEAU   >L1ADE,PC
           LDB    B,U
L1AD6      PSHS   A
           ORB    ,S+
           STB    ,X
           PULS   PC,U
L1ADE      FCB    $00
           FCB    $00
           FCB    $00
           FCB    $00
           FCB    $00
           FCB    $00
           FCB    $00
           FCB    $00
           FCB    $00
           FCB    $09
           FCB    $0A
           FCB    $00
           FCB    $0E
           FCB    $0E
           FCB    $00
           FCB    $0E
L1AEE      BSR    L1B3F
           PSHS   CC
           ORCC   #80
           LDA    #230
L1AF6      BSR    L1B10
           TFR    A,B
           ANDB   #247
           ORB    #2
           STB    >-224
           BSR    L1B10
           LDB    #2
           STB    >-224
           DECA
           DECA
           CMPA   #18
           BCC    L1AF6
           PULS   CC
L1B10      LDB    #180
L1B12      DECB
           BNE    L1B12
           RTS
L1B16      PSHS   X,D,CC
           ORCC   #80
           LEAX   >L0465,PC
           LDA    >-224
           ANDA   #3
           STA    >-224
           BSR    L1B3F
           LDA    #10
L1B2A      TFR    A,B
L1B2C      DECB
           BNE    L1B2C
           LDB    ,X+
           STB    >-224
           INCA
           CMPA   #76
           BCS    L1B2A
           LBSR   L1637
           CLRB
           PULS   PC,X,D,CC
L1B3F      LDA    >-221
           ORA    #8
           STA    >-221
           LDA    >-255
           ANDA   #247
           STA    >-255
           LDA    >-253
           ANDA   #247
           STA    >-253
           RTS
L1B58      PSHS   U,Y,X,D
           LDU    <U0053
           LDB    #4
           OS9    F$ClrBlk
           LDX    <U0055
           LDB    #4
           OS9    F$MapBlk
           STU    <U0053
           OS9    F$ID
           PULS   PC,U,Y,X,D
L1B6F      PSHS   U,Y,X,D
           LDU    <U0053
           LDB    #4
           OS9    F$ClrBlk
           LDX    <U0057
           LDB    #4
           OS9    F$MapBlk
           STU    <U0053
           OS9    F$ID
           PULS   PC,U,Y,X,D
L1B86      LDX    <U0053
           LEAX   >X12F6,X
L1B8C      LDA    ,U+
           CMPA   #255
           BEQ    L1BB2
           PSHS   A
           TSTA
           BGE    L1BA1
           LDB    ,S
           ANDB   #127
           BSR    L1BB3
           STB    ,X+
           BRA    L1BAE
L1BA1      LDB    ,S
           ANDB   #127
           BSR    L1BB3
           LDA    ,U+
L1BA9      STB    ,X+
           DECA
           BNE    L1BA9
L1BAE      PULS   A
           BRA    L1B8C
L1BB2      RTS
L1BB3      PSHS   A
           LEAY   >L1BBE,PC
           CLRA
           LDB    D,Y
           PULS   PC,A
L1BBE      FCB    $00
           FCB    $01
           FCB    $02
           FCB    $03
           FCB    $04
           FCB    $05
           FCB    $06
           FCB    $08
           FCB    $09
           FCB    $0A
           FCB    $10
           FCB    $11
           FCB    $12
           FCB    $16
           FCB    $18
           FCB    $19
           FCC    /!"$&012369@DEFIJRUVY`cdefhijt/
           FCB    $80
           FCB    $84
           FCB    $85
           FCB    $86
           FCB    $88
           FCB    $89
           FCB    $8A
           FCB    $90
           FCB    $91
           FCB    $92
           FCB    $93
           FCB    $94
           FCB    $95
           FCB    $96
           FCB    $98
           FCB    $99
           FCB    $9A
           FCB    $A0
           FCB    $A1
           FCB    $A4
           FCB    $A8
           FCB    $A9
           FCB    $AA
L1C02      FCB    $00
           FCB    $15
           FCB    $00
           FCB    $02
           FCB    $00
           FCB    $00
           FCB    $00
           FCB    $2A
           FCB    $01
           FCB    $03
           FCB    $00
           FCB    $00
           FCB    $00
           FCB    $3F
           FCB    $02
           FCB    $04
           FCB    $00
           FCB    $00
           FCB    $00
           FCB    $54
           FCB    $03
           FCB    $05
           FCB    $00
           FCB    $00
           FCB    $00
           FCB    $69
           FCB    $04
           FCB    $06
           FCB    $00
           FCB    $00
           FCB    $00
           FCB    $7E
           FCB    $05
           FCB    $07
           FCB    $00
           FCB    $00
           FCB    $00
           FCB    $93
           FCB    $06
           FCB    $08
           FCB    $00
           FCB    $00
           FCB    $00
           FCB    $A8
           FCB    $07
           FCB    $09
           FCB    $00
           FCB    $00
           FCB    $00
           FCB    $BD
           FCB    $08
           FCB    $0A
           FCB    $00
           FCB    $00
           FCB    $00
           FCB    $D2
           FCB    $09
           FCB    $0B
           FCB    $00
           FCB    $00
           FCB    $00
           FCB    $E7
           FCB    $0A
           FCB    $0C
           FCB    $00
           FCB    $00
           FCB    $00
           FCB    $FC
           FCB    $0B
           FCB    $00
           FCB    $00
           FCB    $00
           FCB    $1E
           FCB    $3F
           FCB    $00
           FCB    $0E
           FCB    $00
           FCB    $00
           FCB    $1E
           FCB    $54
           FCB    $0D
           FCB    $0F
           FCB    $58
           FCB    $00
           FCB    $1E
           FCB    $69
           FCB    $0E
           FCB    $10
           FCB    $59
           FCB    $00
           FCB    $1E
           FCB    $7E
           FCB    $0F
           FCB    $11
           FCB    $5A
           FCB    $00
           FCB    $1E
           FCB    $93
           FCB    $10
           FCB    $12
           FCB    $5B
           FCB    $00
           FCB    $1E
           FCB    $A8
           FCB    $11
           FCB    $13
           FCB    $5C
           FCB    $00
           FCB    $1E
           FCB    $BD
           FCB    $12
           FCB    $14
           FCB    $5D
           FCB    $00
           FCB    $1E
           FCB    $D2
           FCB    $13
           FCB    $00
           FCB    $00
           FCB    $00
           FCB    $3C
           FCB    $2A
           FCB    $00
           FCB    $16
           FCB    $00
           FCB    $00
           FCB    $3C
           FCB    $3F
           FCB    $15
           FCB    $17
           FCB    $00
           FCB    $00
           FCB    $3C
           FCB    $54
           FCB    $16
           FCB    $18
           FCB    $5E
           FCB    $00
           FCB    $3C
           FCB    $69
           FCB    $17
           FCB    $19
           FCB    $5F
           FCB    $00
           FCB    $3C
           FCB    $7E
           FCB    $18
           FCB    $1A
           FCB    $60
           FCB    $00
           FCB    $3C
           FCB    $93
           FCB    $19
           FCB    $1B
           FCB    $61
           FCB    $00
           FCB    $3C
           FCB    $A8
           FCB    $1A
           FCB    $1C
           FCB    $62
           FCB    $00
           FCB    $3C
           FCB    $BD
           FCB    $1B
           FCB    $1D
           FCB    $63
           FCB    $00
           FCB    $3C
           FCB    $D2
           FCB    $1C
           FCB    $1E
           FCB    $00
           FCB    $00
           FCB    $3C
           FCB    $E7
           FCB    $1D
           FCB    $00
           FCB    $00
           FCB    $00
           FCB    $69
           FCB    $00
           FCB    $00
           FCB    $20
           FCB    $00
           FCB    $00
           FCB    $5A
           FCB    $15
           FCB    $1F
           FCB    $21
           FCB    $00
           FCB    $00
           FCC    /Z* "/
           FCB    $00
           FCB    $00
           FCC    "Z?!#"
           FCB    $00
           FCB    $00
           FCC    /ZT"$d/
           FCB    $00
           FCC    "Zi#%e"
           FCB    $00
           FCB    $5A
           FCB    $7E
           FCC    "$&f"
           FCB    $00
           FCB    $5A
           FCB    $93
           FCC    "%'g"
           FCB    $00
           FCB    $5A
           FCB    $A8
           FCC    "&(h"
           FCB    $00
           FCB    $5A
           FCB    $BD
           FCC    "')i"
           FCB    $00
           FCB    $5A
           FCB    $D2
           FCB    $28
           FCB    $2A
           FCB    $00
           FCB    $00
           FCB    $5A
           FCB    $E7
           FCB    $29
           FCB    $2B
           FCB    $00
           FCB    $00
           FCB    $5A
           FCB    $FC
           FCB    $2A
           FCB    $2C
           FCB    $00
           FCB    $00
           FCB    $6A
           FCB    $11
           FCB    $2B
           FCB    $2D
           FCB    $00
           FCB    $00
           FCC    "j&,"
           FCB    $00
           FCB    $00
           FCB    $00
           FCB    $78
           FCB    $15
           FCB    $1F
           FCB    $2F
           FCB    $00
           FCB    $00
           FCC    "x*.0"
           FCB    $00
           FCB    $00
           FCC    "x?/1"
           FCB    $00
           FCB    $00
           FCC    "xT02j"
           FCB    $00
           FCC    "xi13k"
           FCB    $00
           FCB    $78
           FCB    $7E
           FCC    "24l"
           FCB    $00
           FCB    $78
           FCB    $93
           FCC    "35m"
           FCB    $00
           FCB    $78
           FCB    $A8
           FCC    "46n"
           FCB    $00
           FCB    $78
           FCB    $BD
           FCC    "57o"
           FCB    $00
           FCB    $78
           FCB    $D2
           FCB    $36
           FCB    $38
           FCB    $00
           FCB    $00
           FCB    $78
           FCB    $E7
           FCB    $37
           FCB    $39
           FCB    $00
           FCB    $00
           FCB    $78
           FCB    $FC
           FCB    $38
           FCB    $2C
           FCB    $00
           FCB    $00
           FCB    $96
           FCB    $2A
           FCB    $00
           FCB    $3B
           FCB    $00
           FCB    $00
           FCB    $96
           FCC    "?:<"
           FCB    $00
           FCB    $00
           FCB    $96
           FCC    "T;=p"
           FCB    $00
           FCB    $96
           FCC    "i<>q"
           FCB    $00
           FCB    $96
           FCB    $7E
           FCC    "=?r"
           FCB    $00
           FCB    $96
           FCB    $93
           FCC    ">@s"
           FCB    $00
           FCB    $96
           FCB    $A8
           FCC    "?At"
           FCB    $00
           FCB    $96
           FCB    $BD
           FCC    "@Bu"
           FCB    $00
           FCB    $96
           FCB    $D2
           FCB    $41
           FCB    $43
           FCB    $00
           FCB    $00
           FCB    $96
           FCB    $E7
           FCB    $42
           FCB    $00
           FCB    $00
           FCB    $00
           FCB    $B4
           FCB    $3F
           FCB    $00
           FCB    $45
           FCB    $00
           FCB    $00
           FCB    $B4
           FCC    "TDFv"
           FCB    $00
           FCB    $B4
           FCC    "iEGw"
           FCB    $00
           FCB    $B4
           FCB    $7E
           FCC    "FHx"
           FCB    $00
           FCB    $B4
           FCB    $93
           FCC    "GIy"
           FCB    $00
           FCB    $B4
           FCB    $A8
           FCC    "HJz"
           FCB    $00
           FCB    $B4
           FCB    $BD
           FCC    "IK{"
           FCB    $00
           FCB    $B4
           FCB    $D2
           FCB    $4A
           FCB    $00
           FCB    $00
           FCB    $00
           FCB    $D2
           FCB    $15
           FCB    $00
           FCB    $4D
           FCB    $00
           FCB    $00
           FCB    $D2
           FCC    "*LN"
           FCB    $00
           FCB    $00
           FCB    $D2
           FCC    "?MO"
           FCB    $00
           FCB    $00
           FCB    $D2
           FCC    "TNP"
           FCB    $00
           FCB    $00
           FCB    $D2
           FCC    "iOQ"
           FCB    $00
           FCB    $00
           FCB    $D2
           FCB    $7E
           FCB    $50
           FCB    $52
           FCB    $00
           FCB    $00
           FCB    $D2
           FCB    $93
           FCB    $51
           FCB    $53
           FCB    $00
           FCB    $00
           FCB    $D2
           FCB    $A8
           FCB    $52
           FCB    $54
           FCB    $00
           FCB    $00
           FCB    $D2
           FCB    $BD
           FCB    $53
           FCB    $55
           FCB    $00
           FCB    $00
           FCB    $D2
           FCB    $D2
           FCB    $54
           FCB    $56
           FCB    $00
           FCB    $00
           FCB    $D2
           FCB    $E7
           FCB    $55
           FCB    $57
           FCB    $00
           FCB    $00
           FCB    $D2
           FCB    $FC
           FCB    $56
           FCB    $00
           FCB    $00
           FCB    $00
           FCB    $1E
           FCB    $54
           FCB    $00
           FCB    $59
           FCB    $00
           FCB    $0E
           FCB    $1E
           FCC    "iXZ"
           FCB    $00
           FCB    $0F
           FCB    $1E
           FCB    $7E
           FCB    $59
           FCB    $5B
           FCB    $00
           FCB    $10
           FCB    $1E
           FCB    $93
           FCB    $5A
           FCB    $5C
           FCB    $00
           FCB    $11
           FCB    $1E
           FCB    $A8
           FCB    $5B
           FCB    $5D
           FCB    $00
           FCB    $12
           FCB    $1E
           FCB    $BD
           FCB    $5C
           FCB    $00
           FCB    $00
           FCB    $13
           FCB    $3C
           FCB    $54
           FCB    $00
           FCB    $5F
           FCB    $00
           FCB    $17
           FCC    "<i^`|"
           FCB    $18
           FCB    $3C
           FCB    $7E
           FCC    "_a}"
           FCB    $19
           FCB    $3C
           FCB    $93
           FCB    $60
           FCB    $62
           FCB    $7E
           FCB    $1A
           FCB    $3C
           FCB    $A8
           FCB    $61
           FCB    $63
           FCB    $7F
           FCB    $1B
           FCB    $3C
           FCB    $BD
           FCB    $62
           FCB    $00
           FCB    $00
           FCB    $1C
           FCB    $5A
           FCB    $54
           FCB    $00
           FCB    $65
           FCB    $00
           FCC    "#Zidf"
           FCB    $80
           FCB    $24
           FCB    $5A
           FCB    $7E
           FCB    $65
           FCB    $67
           FCB    $81
           FCB    $25
           FCB    $5A
           FCB    $93
           FCB    $66
           FCB    $68
           FCB    $82
           FCB    $26
           FCB    $5A
           FCB    $A8
           FCB    $67
           FCB    $69
           FCB    $83
           FCB    $27
           FCB    $5A
           FCB    $BD
           FCB    $68
           FCB    $00
           FCB    $00
           FCC    "(xT"
           FCB    $00
           FCB    $6B
           FCB    $00
           FCC    "1xijl"
           FCB    $84
           FCB    $32
           FCB    $78
           FCB    $7E
           FCB    $6B
           FCB    $6D
           FCB    $85
           FCB    $33
           FCB    $78
           FCB    $93
           FCB    $6C
           FCB    $6E
           FCB    $86
           FCB    $34
           FCB    $78
           FCB    $A8
           FCB    $6D
           FCB    $6F
           FCB    $87
           FCB    $35
           FCB    $78
           FCB    $BD
           FCB    $6E
           FCB    $00
           FCB    $00
           FCB    $36
           FCB    $96
           FCB    $54
           FCB    $00
           FCB    $71
           FCB    $00
           FCB    $3C
           FCB    $96
           FCC    "ipr"
           FCB    $88
           FCB    $3D
           FCB    $96
           FCB    $7E
           FCB    $71
           FCB    $73
           FCB    $89
           FCB    $3E
           FCB    $96
           FCB    $93
           FCB    $72
           FCB    $74
           FCB    $8A
           FCB    $3F
           FCB    $96
           FCB    $A8
           FCB    $73
           FCB    $75
           FCB    $8B
           FCB    $40
           FCB    $96
           FCB    $BD
           FCB    $74
           FCB    $00
           FCB    $00
           FCB    $41
           FCB    $B4
           FCB    $54
           FCB    $00
           FCB    $77
           FCB    $00
           FCB    $45
           FCB    $B4
           FCC    "ivx"
           FCB    $00
           FCB    $46
           FCB    $B4
           FCB    $7E
           FCB    $77
           FCB    $79
           FCB    $00
           FCB    $47
           FCB    $B4
           FCB    $93
           FCB    $78
           FCB    $7A
           FCB    $00
           FCB    $48
           FCB    $B4
           FCB    $A8
           FCB    $79
           FCB    $7B
           FCB    $00
           FCB    $49
           FCB    $B4
           FCB    $BD
           FCB    $7A
           FCB    $00
           FCB    $00
           FCC    "J<i"
           FCB    $00
           FCB    $7D
           FCB    $00
           FCB    $5F
           FCB    $3C
           FCB    $7E
           FCB    $7C
           FCB    $7E
           FCB    $00
           FCB    $60
           FCB    $3C
           FCB    $93
           FCB    $7D
           FCB    $7F
           FCB    $00
           FCB    $61
           FCB    $3C
           FCB    $A8
           FCB    $7E
           FCB    $00
           FCB    $00
           FCC    "bZi"
           FCB    $00
           FCB    $81
           FCB    $00
           FCB    $65
           FCB    $5A
           FCB    $7E
           FCB    $80
           FCB    $82
           FCB    $8C
           FCB    $66
           FCB    $5A
           FCB    $93
           FCB    $81
           FCB    $83
           FCB    $8D
           FCB    $67
           FCB    $5A
           FCB    $A8
           FCB    $82
           FCB    $00
           FCB    $00
           FCC    "hxi"
           FCB    $00
           FCB    $85
           FCB    $00
           FCB    $6B
           FCB    $78
           FCB    $7E
           FCB    $84
           FCB    $86
           FCB    $8E
           FCB    $6C
           FCB    $78
           FCB    $93
           FCB    $85
           FCB    $87
           FCB    $8F
           FCB    $6D
           FCB    $78
           FCB    $A8
           FCB    $86
           FCB    $00
           FCB    $00
           FCB    $6E
           FCB    $96
           FCB    $69
           FCB    $00
           FCB    $89
           FCB    $00
           FCB    $71
           FCB    $96
           FCB    $7E
           FCB    $88
           FCB    $8A
           FCB    $00
           FCB    $72
           FCB    $96
           FCB    $93
           FCB    $89
           FCB    $8B
           FCB    $00
           FCB    $73
           FCB    $96
           FCB    $A8
           FCB    $8A
           FCB    $00
           FCB    $00
           FCB    $74
           FCB    $5A
           FCB    $7E
           FCB    $00
           FCB    $8D
           FCB    $90
           FCB    $81
           FCB    $5A
           FCB    $93
           FCB    $8C
           FCB    $00
           FCB    $90
           FCB    $82
           FCB    $78
           FCB    $7E
           FCB    $00
           FCB    $8F
           FCB    $90
           FCB    $85
           FCB    $78
           FCB    $93
           FCB    $8E
           FCB    $00
           FCB    $90
           FCB    $86
           FCB    $69
           FCB    $88
           FCB    $00
           FCB    $00
           FCB    $00
           FCB    $00
L1F62      FCB    $2D
           FCB    $2C
           FCB    $0C
           FCC    "+9W"
           FCB    $0B
           FCB    $1E
           FCC    "*8CV"
           FCB    $0A
           FCB    $14
           FCB    $1D
           FCC    ")7BKU"
           FCB    $09
           FCB    $13
           FCB    $1C
           FCC    "(6AJT"
           FCB    $08
           FCB    $12
           FCB    $1B
           FCC    "'5@IS"
           FCB    $07
           FCB    $11
           FCB    $1A
           FCC    "&4?HR"
           FCB    $06
           FCB    $10
           FCB    $19
           FCC    "%3>GQ"
           FCB    $05
           FCB    $0F
           FCB    $18
           FCC    "$2=FP"
           FCB    $04
           FCB    $0E
           FCB    $17
           FCC    "#1<EO"
           FCB    $03
           FCB    $0D
           FCB    $16
           FCC    /"0;DN/
           FCB    $02
           FCB    $15
           FCC    "!/:M"
           FCB    $01
           FCC    " .L"
           FCB    $1F
           FCB    $00
L1FBA      FCC    /"R!$xy/
           FCB    $13
           FCC    "iUW#cRder#Y#ggqsy"
           FCB    $11
           FCB    $61
           FCB    $11
           FCC    /s"qwqfUxbduu/
           FCB    $12
           FCC    "iTrVV!ud"
           FCB    $11
           FCC    "Wxhre"
           FCB    $11
           FCC    "vXQQxXhsSd"
           FCB    $12
           FCC    "3twYRWy"
           FCB    $12
           FCB    $13
           FCC    "$S1$yX2a!T"
           FCB    $13
           FCB    $61
           FCB    $75
           FCB    $13
           FCC    /"bSaBRscf/
           FCB    $12
           FCC    /wfeW"TqTCbYcthAUtv!whQDScY$girQV#ev4UVgXitvbfw3Uytxr$YSYtxXv4sVSeAUqRhh!xWfidcaUiX/
           FCB    $11
           FCC    /g"SQ/
           FCB    $12
           FCC    "RqRttarqWWwbu"
           FCB    $11
           FCC    "dCDVW"
           FCB    $13
           FCC    "hdQQbqr"
           FCB    $11
           FCC    "yTe"
           FCB    $12
           FCB    $13
           FCC    "sby2xBfcw!d#Yurvibs!"
           FCB    $13
           FCC    "XuTh#v"
           FCB    $12
           FCC    /Qvc$#Rf"""!1fwViauTVeUXa/
           FCB    $12
           FCC    "gTyS"
           FCB    $13
           FCC    "$$c"
           FCB    $11
           FCC    "sYgge#q"
           FCB    $11
           FCB    $73
           FCB    $12
           FCC    /WrYvvhRifSecbixdStUqa"fxeU"rXd$bd!Xuf/
           FCB    $13
           FCC    "u$#Ab$wvuiiTs"
           FCB    $12
           FCB    $71
           FCB    $32
           FCB    $13
           FCC    "Vxga!aWV"
           FCB    $11
           FCC    "t!yVTWwg"
           FCB    $11
           FCB    $31
           FCB    $56
           FCB    $12
           FCC    /Q#"wUhYhtbucRsrSfWBRhQS/
           FCB    $11
           FCC    "yQ$t#Dd"
           FCB    $12
           FCC    /Xcxgg4yr"3RYsT#TeYvQ/
           FCB    $13
           FCC    "!cey"
           FCB    $13
           FCC    "XqUaCwYw"
           FCB    $12
           FCC    "tebdbS"
           FCB    $13
           FCB    $11
           FCC    "RcD"
           FCB    $12
           FCB    $13
           FCC    "rirafVeVxsud"
           FCB    $13
           FCC    /dYX"ssie##fXqSia4/
           FCB    $11
           FCC    "Q#vrRu!!qgT$e"
           FCB    $11
           FCC    "ViTx#VWuhUcv"
           FCB    $12
           FCB    $51
           FCB    $24
           FCB    $13
           FCC    /"TXwQhfxduvvgW/
           FCB    $11
           FCC    /ytUhW$qWC"QqcgUsytgUbwh1at23ycfXSyTS$!aYRbRYB!wr/
           FCB    $12
           FCC    /A"xRVtBStYwqq"ShRs!sUS!r/
           FCB    $12
           FCB    $76
           FCB    $11
           FCC    "bQ3"
           FCB    $12
           FCB    $34
           FCB    $13
           FCC    "w1c2"
           FCB    $11
           FCC    /"eTvrVbf"/
           FCB    $13
           FCC    "dXQRdx$dyqfc$cs"
           FCB    $11
           FCC    "fXdgyaTawYUQ!RbgtWigeU$WU#QTYTx"
           FCB    $11
           FCC    "isW"
           FCB    $13
           FCC    /S!"VxvCXug#qX/
           FCB    $13
           FCC    "Aea$u"
           FCB    $12
           FCC    "uehwuWYyxri#fvVtrhyaD#bhc"
           FCB    $12
           FCC    "ihU"
           FCB    $12
           FCC    /Q"!ReWeaQigqRdbVqtvyfhqSiWfYcg/
           FCB    $12
           FCC    "yU#X!awDgVext#wB"
           FCB    $13
           FCC    "sqcvS$TArSu!"
           FCB    $11
           FCC    /df$"/
           FCB    $11
           FCB    $75
           FCB    $63
           FCB    $13
           FCB    $43
           FCB    $13
           FCC    "iRXrYyV#f"
           FCB    $11
           FCC    /#Qv$"xXssWVaXd31bYtbchs2Tgt/
           FCB    $11
           FCB    $53
           FCB    $13
           FCC    /yQb"Urvuxwu/
           FCB    $12
           FCC    "eTTwYraUW$xi4hd!"
           FCB    $12
           FCC    "RgQxi"
           FCB    $11
           FCC    "TXXRsbXuu#We#"
           FCB    $12
           FCC    "bXq!ticQSYcaURufRistsTqvD#A1STVW"
           FCB    $12
           FCC    "hyVvr"
           FCB    $12
           FCC    /Y!qWvU2fgehYY"$Svdtch/
           FCB    $11
           FCB    $13
           FCC    /!wd"RfU/
           FCB    $13
           FCC    /$B3QaeuCV#yydbrf!bS"e/
           FCB    $11
           FCC    "h$rVy$awrgi4xtgwU"
           FCB    $12
           FCB    $61
           FCB    $54
           FCB    $13
           FCC    /sx"cdWxw/
           FCB    $13
           FCB    $71
           FCB    $51
           FCB    $11
           FCC    /iDsVAx!hixSfa""4er$2ydqv!QrvVwX/
           FCB    $13
           FCC    /C"QXhRcreu#tUdq#/
           FCB    $11
           FCC    "tqg1"
           FCB    $13
           FCC    "fg$$"
           FCB    $13
           FCB    $11
           FCC    "SsWec!wRyUWB!RSvVu3gaxUhusa"
           FCB    $12
           FCC    "fvtrwda#yRTiW"
           FCB    $13
           FCB    $12
           FCB    $59
           FCB    $11
           FCC    "WTibYxhTf#QTc"
           FCB    $12
           FCC    /"cUXuXt$bSY/
           FCB    $12
           FCC    "eQwq"
           FCB    $11
           FCC    "bsbdYyVg"
           FCB    $00
           FCB    $00
           FCB    $00
           FCB    $00
           FCB    $00
           FCB    $00
           FCB    $00
           FCB    $00
           FCB    $00
           FCB    $00
           FCB    $00
           FCB    $00
           FCB    $00
           FCB    $00
           FCB    $00
           FCB    $00
           FCB    $00
           FCB    $00
           FCB    $00
           FCB    $00
           FCB    $00
           FCB    $00
           FCB    $00
           FCB    $00
           FCB    $00
           FCB    $00
           FCB    $00
           FCB    $00
           FCB    $00
           FCB    $00
           FCB    $00
           FCB    $00
           FCB    $00
           FCB    $11
           FCC    "QXhRcre"
           FCB    $00
           FCB    $00
           FCB    $00
           FCB    $00
           FCB    $00
           FCB    $23
           FCB    $33
           FCB    $11
           FCC    "tqg1"
           FCB    $13
           FCB    $22
           FCB    $71
           FCB    $00
           FCB    $00
           FCC    "ABSsWeCA"
           FCB    $00
           FCB    $00
           FCB    $00
           FCB    $00
           FCB    $32
           FCB    $22
           FCB    $00
           FCB    $00
           FCB    $00
           FCB    $00
           FCB    $00
           FCB    $00
           FCB    $00
           FCB    $00
           FCB    $00
           FCB    $00
           FCB    $00
           FCB    $00
           FCB    $00
           FCB    $00
           FCB    $00
           FCB    $12
           FCC    "fvtrwda#yRTiW"
           FCB    $13
           FCB    $12
           FCB    $59
           FCB    $11
           FCC    "WTibYxhTf#QTc"
           FCB    $12
           FCC    /"cUXuXt$/
           FCB    $00
           FCB    $53
           FCB    $59
           FCB    $00
           FCC    "eQwq"
           FCB    $00
           FCB    $62
           FCB    $73
           FCB    $00
           FCB    $64
           FCB    $00
           FCB    $79
           FCB    $56
           FCB    $00
L24CA      FCB    $00
           FCB    $00
           FCB    $00
           FCB    $00
           FCB    $00
           FCB    $00
           FCB    $00
           FCB    $00
           FCB    $00
           FCB    $00
           FCB    $00
           FCB    $00
           FCB    $0C
           FCB    $0C
           FCB    $18
           FCC    " <B"
           FCB    $99
           FCB    $A1
           FCB    $A1
           FCB    $99
           FCC    "B<4fF"
           FCB    $0C
           FCB    $18
           FCB    $00
           FCB    $18
           FCB    $00
           FCB    $88
           FCB    $1D
           FCB    $3E
           FCB    $5C
           FCB    $88
           FCB    $C5
           FCB    $E3
           FCB    $D1
           FCB    $1C
           FCB    $0C
           FCB    $18
           FCB    $10
           FCB    $00
           FCB    $00
           FCB    $00
           FCB    $00
           FCB    $00
           FCB    $00
           FCB    $00
           FCB    $0E
           FCB    $70
           FCB    $00
           FCB    $00
           FCB    $00
           FCB    $00
           FCB    $00
           FCB    $00
           FCB    $00
           FCB    $00
           FCB    $18
           FCB    $18
           FCB    $00
           FCC    "<nFFbr~<"
           FCB    $0C
           FCB    $1C
           FCB    $3C
           FCB    $0C
           FCB    $0C
           FCB    $0C
           FCB    $0C
           FCB    $08
           FCB    $3C
           FCB    $7E
           FCB    $66
           FCB    $0C
           FCB    $18
           FCB    $33
           FCB    $7E
           FCB    $40
           FCB    $3E
           FCB    $06
           FCB    $0C
           FCB    $1E
           FCB    $06
           FCB    $0C
           FCB    $18
           FCB    $60
           FCB    $0E
           FCB    $1E
           FCB    $36
           FCB    $66
           FCB    $7F
           FCB    $06
           FCB    $06
           FCB    $04
           FCB    $7E
           FCB    $60
           FCB    $7C
           FCB    $06
           FCB    $06
           FCB    $0C
           FCB    $18
           FCB    $60
           FCB    $06
           FCB    $18
           FCB    $30
           FCB    $7C
           FCB    $E6
           FCC    "ff<~~F"
           FCB    $0C
           FCB    $18
           FCB    $18
           FCB    $18
           FCB    $10
           FCC    "<ff<ff~<<ffg>"
           FCB    $0C
           FCB    $18
           FCB    $60
           FCB    $00
           FCB    $18
           FCB    $18
           FCB    $00
           FCB    $18
           FCB    $18
           FCB    $00
           FCB    $00
           FCB    $7E
           FCC    "BBBBB~"
           FCB    $00
           FCB    $38
           FCB    $0C
           FCS    "6fvffBlf"
           FCC    "flffl@<Fb``r<"
           FCB    $00
           FCB    $6C
           FCB    $E6
           FCS    "ffffl@vb"
           FCS    "`l`bv@vb"
           FCS    "`l```@<F@"
           FCB    $CC
           FCB    $C6
           FCB    $E6
           FCB    $6C
           FCB    $00
           FCB    $66
           FCB    $EE
           FCC    "ffvffD"
           FCB    $18
           FCB    $00
           FCB    $18
           FCB    $38
           FCB    $18
           FCB    $18
           FCB    $18
           FCB    $10
           FCB    $0C
           FCB    $1C
           FCB    $0C
           FCB    $0C
           FCB    $0C
           FCB    $0C
           FCB    $18
           FCB    $20
           FCB    $62
           FCB    $EC
           FCS    "h`hlfB``"
           FCS    "```bn@cg"
           FCB    $6B
           FCB    $7F
           FCS    "kccBfv"
           FCB    $7E
           FCC    "nfffD<Nfffv<"
           FCB    $00
           FCB    $6C
           FCB    $E6
           FCC    "fl```@<Nfffl6"
           FCB    $02
           FCB    $6C
           FCB    $E6
           FCC    "flhlf@,fp<"
           FCB    $0E
           FCB    $66
           FCB    $34
           FCB    $00
           FCB    $FF
           FCB    $89
           FCB    $18
           FCB    $18
           FCB    $18
           FCB    $18
           FCB    $18
           FCB    $10
           FCC    "Dfffff4"
           FCB    $00
           FCB    $22
           FCB    $66
           FCB    $EE
           FCC    "ff4"
           FCB    $18
           FCB    $00
           FCB    $63
           FCB    $E7
           FCB    $63
           FCB    $6B
           FCB    $7F
           FCC    "wcBBf4"
           FCB    $18
           FCB    $1C
           FCS    ".fBfn"
           FCB    $66
           FCB    $34
           FCB    $18
           FCB    $18
           FCB    $18
           FCB    $10
           FCB    $76
           FCB    $46
           FCB    $0C
           FCB    $18
           FCC    "0bn"
           FCB    $00
L263A      FCB    $1D
           FCB    $01
           FCB    $00
           FCB    $0B
           FCB    $DE
           FCB    $16
L2640      FCB    $12
           FCB    $01
           FCB    $00
           FCB    $11
           FCB    $DE
           FCB    $15
           FCB    $FF
           FCC    "@ ALTERNATE"
           FCB    $00
           FCC    "@ ORIGINAL"
           FCB    $00
L265E      FCB    $0C
           FCB    $07
           FCB    $00
           FCB    $29
           FCB    $DE
           FCB    $2C
           FCB    $0C
           FCB    $09
           FCB    $00
           FCB    $32
           FCB    $DE
           FCB    $14
           FCB    $0C
           FCB    $0B
           FCB    $00
           FCB    $38
           FCB    $E2
           FCB    $3E
           FCB    $0C
           FCB    $0D
           FCB    $00
           FCB    $42
           FCB    $E0
           FCB    $4C
           FCB    $0C
           FCB    $0F
           FCB    $00
           FCB    $4C
           FCB    $E3
           FCB    $1A
           FCB    $0C
           FCB    $11
           FCB    $00
           FCB    $56
           FCB    $DE
           FCB    $05
           FCB    $0C
           FCB    $13
           FCB    $00
           FCB    $5F
           FCB    $DD
           FCB    $5E
           FCB    $FF
           FCC    "Play Solitaire"
           FCB    $00
           FCC    "Begin Again"
           FCB    $00
           FCC    "Select a Dragon"
           FCB    $00
           FCC    "Tournament Play"
           FCB    $00
           FCC    "Challenge Match"
           FCB    $00
           FCC    "Return to Game"
           FCB    $00
           FCC    "Return to OS-9"
           FCB    $00
L26F2      FCB    $00
           FCB    $04
           FCB    $00
           FCB    $1D
           FCB    $DD
           FCB    $6F
           FCB    $00
           FCB    $06
           FCB    $00
           FCB    $1C
           FCB    $DD
           FCB    $E7
           FCB    $23
           FCB    $06
           FCB    $00
           FCB    $1B
           FCB    $DD
           FCB    $E6
           FCB    $22
           FCB    $04
           FCB    $00
           FCB    $1A
           FCB    $DD
           FCB    $E5
           FCB    $23
           FCB    $08
           FCB    $00
           FCB    $1B
           FCB    $E1
           FCB    $FE
           FCB    $FF
           FCC    "Menu"
           FCB    $00
           FCC    "Undo"
           FCB    $00
           FCC    "Find"
           FCB    $00
           FCC    "Cancel"
           FCB    $00
           FCC    "Peek"
           FCB    $00
L272C      FCB    $0C
           FCB    $05
           FCB    $00
           FCB    $35
           FCB    $E1
           FCB    $93
           FCB    $0C
           FCB    $07
           FCB    $00
           FCB    $3D
           FCB    $E1
           FCB    $91
           FCB    $0C
           FCB    $09
           FCB    $00
           FCB    $44
           FCB    $E1
           FCB    $8F
           FCB    $0C
           FCB    $0B
           FCB    $00
           FCB    $49
           FCB    $E1
           FCB    $8D
           FCB    $0C
           FCB    $0D
           FCB    $00
           FCB    $4B
           FCB    $E1
           FCB    $8B
           FCB    $0C
           FCB    $0F
           FCB    $00
           FCB    $4F
           FCB    $E1
           FCB    $89
           FCB    $0C
           FCB    $11
           FCB    $00
           FCB    $55
           FCB    $E1
           FCB    $87
           FCB    $0C
           FCB    $13
           FCB    $00
           FCB    $5C
           FCB    $E1
           FCB    $85
           FCB    $0C
           FCB    $15
           FCB    $00
           FCB    $63
           FCB    $DD
           FCB    $05
           FCB    $FF
           FCC    "Pairs to Kong"
           FCB    $00
           FCC    "Fours Galore"
           FCB    $00
           FCC    "Four Winds"
           FCB    $00
           FCC    "Bam Bam"
           FCB    $00
           FCC    "Crak King"
           FCB    $00
           FCC    "Dots Across"
           FCB    $00
           FCC    "Dragon Rider"
           FCB    $00
           FCC    "Dragons Song"
           FCB    $00
           FCC    "Return to Menu"
           FCB    $00
L27D0      FCB    $11
           FCB    $0C
           FCB    $00
           FCB    $0B
           FCB    $E1
           FCB    $53
           FCB    $11
           FCB    $0E
           FCB    $00
           FCB    $09
           FCB    $DC
           FCB    $BE
           FCB    $FF
           FCC    "Yes"
           FCB    $00
           FCB    $4E
           FCB    $6F
           FCB    $00
L27E4      FCB    $0B
           FCB    $09
           FCB    $00
           FCB    $1D
           FCB    $E1
           FCB    $C3
           FCB    $0B
           FCB    $0B
           FCB    $00
           FCB    $22
           FCB    $E1
           FCB    $C4
           FCB    $0B
           FCB    $0D
           FCB    $00
           FCB    $27
           FCB    $E1
           FCB    $C5
           FCB    $0B
           FCB    $0F
           FCB    $00
           FCB    $2C
           FCB    $E1
           FCB    $C6
           FCB    $0B
           FCB    $11
           FCB    $FF
           FCB    $C3
           FCB    $DC
           FCB    $65
           FCB    $FF
           FCC    "10 Seconds"
           FCB    $00
           FCC    "20 Seconds"
           FCB    $00
           FCC    "30 Seconds"
           FCB    $00
           FCC    "60 Seconds"
           FCB    $00
L282F      FCB    $00
           FCB    $04
           FCB    $00
           FCB    $0B
           FCB    $E0
           FCB    $68
           FCB    $22
           FCB    $04
           FCB    $FE
           FCB    $E9
           FCB    $E0
           FCB    $5C
           FCB    $FF
           FCC    "Quit"
           FCB    $00
L2841      FCB    $06
           FCB    $08
           FCB    $00
           FCB    $11
           FCB    $DE
           FCB    $92
           FCB    $06
           FCB    $0A
           FCB    $00
           FCB    $25
           FCB    $DE
           FCB    $90
           FCB    $06
           FCB    $0C
           FCB    $FF
           FCB    $72
           FCB    $DC
           FCB    $14
           FCB    $FF
           FCC    "Begin 5 minute tournament"
           FCB    $00
           FCC    "Begin 10 minute tournament"
           FCB    $00
L2889      FCB    $00
           FCB    $04
           FCB    $FF
           FCB    $B1
           FCB    $DE
           FCB    $DA
           FCB    $00
           FCB    $06
           FCB    $FE
           FCB    $85
           FCB    $DE
           FCB    $EC
           FCB    $22
           FCB    $04
           FCB    $FE
           FCB    $89
           FCB    $DE
           FCB    $F4
           FCB    $FF
L289C      FCB    $1C
           FCB    $15
           FCB    $FF
           FCB    $3F
           FCB    $04
           FCB    $09
           FCB    $21
           FCB    $15
           FCB    $FF
           FCB    $3D
           FCB    $04
           FCB    $15
           FCB    $FF
L28A9      FCB    $00
           FCB    $04
           FCB    $FF
           FCB    $91
           FCB    $E0
           FCB    $B3
           FCB    $00
           FCB    $06
           FCB    $FE
           FCB    $65
           FCB    $E0
           FCB    $B2
           FCB    $FF
L28B6      PSHS   U
           STU    <U0018
           CLRA
           CLRB
           STD    <U002E
L28BE      LDD    ,U++
           BLT    L28D3
           BSR    L28D5
           LDD    ,U
           PSHS   U
           LEAU   D,U
           LBSR   L0FA2
           PULS   U
           LEAU   U0004,U
           BRA    L28BE
L28D3      PULS   PC,U
L28D5      PSHS   A
           LDX    <U0053
           PSHS   B
L28DB      DEC    ,S
           BLT    L28E5
           LEAX   >X0500,X
           BRA    L28DB
L28E5      LEAS   1,S
           PULS   A
           LDB    #4
           MUL
           LEAX   D,X
           RTS
L28EF      PSHS   A
           LDX    <U0053
           PSHS   B
L28F5      DEC    ,S
           BLT    L28FF
           LEAX   >X05A0,X
           BRA    L28F5
L28FF      LEAS   1,S
           PULS   A
           LDB    #4
           MUL
           LEAX   D,X
           RTS
L2909      LDD    ,U
           LBLT   L29C5
           PSHS   A
           LDA    #8
           MUL
           STD    <U0046
           ADDB   #8
           STD    <U0048
           PULS   A
           LDB    #8
           MUL
           STD    <U0042
           LEAX   U0002,U
           LDD    U0002,U
           LEAX   D,X
           LDA    #255
L2929      INCA
           TST    ,X+
           BNE    L2929
           LDB    #8
           MUL
           ADDD   <U0042
           STD    <U0044
           LDD    <U0037
           CMPD   <U0042
           LBCS   L29C0
           CMPD   <U0044
           BHI    L29C0
           LDB    <U0039
           CLRA
           CMPD   <U0046
           BCS    L29C0
           CMPD   <U0048
           BHI    L29C0
           LDD    <U002E
           BEQ    L298A
           PSHS   U
           CMPD   ,S++
           BNE    L295C
           RTS
L295C      PSHS   U
           LDU    <U002E
           LDD    ,U++
           LBSR   L28D5
           LDD    ,U
           LEAU   D,U
           LBSR   L12BF
           LBSR   L0FA2
           LBSR   L115C
           PULS   U
           STU    <U002E
           LDD    ,U++
           LBSR   L28D5
           LDD    ,U
           LEAU   D,U
           INC    <U0041
           LBSR   L12BF
           LBSR   L0FA2
           LBRA   L115C
L298A      STU    <U002E
           LEAU   >L2640,PC
           CMPU   <U002E
           BNE    L299B
           LDU    #2646
           LBSR   L09E8
L299B      LEAU   >L263A,PC
           CMPU   <U002E
           BNE    L29AA
           LDU    #2662
           LBSR   L09E8
L29AA      LDU    <U002E
           LDD    ,U++
           LBSR   L28D5
           LDD    ,U
           LEAU   D,U
           INC    <U0041
           LBSR   L12BF
           LBSR   L0FA2
           LBRA   L115C
L29C0      LEAU   U0006,U
           LBRA   L2909
L29C5      LDD    <U002E
           BEQ    L29E1
           TFR    D,U
           LDD    ,U++
           LBSR   L28D5
           LDD    ,U
           LEAU   D,U
           LBSR   L12BF
           LBSR   L0FA2
           LBSR   L115C
           CLRA
           CLRB
           STD    <U002E
L29E1      RTS
L29E2      LDD    <U002E
           BEQ    L29F0
           TFR    D,U
           LEAU   U0004,U
           LDD    ,U
           LEAS   2,S
           JMP    D,U
L29F0      RTS
L29F1      INC    <U000A
           LDX    <U0053
           LEAX   >X0281,X
           CLRB
           STB    >$FF5F,X
           STB    >$FEBF,X
           LDA    #39
           PSHS   A
L2A06      DEC    ,S
           BLT    L2A14
           LBSR   L2A91
           LDB    #35
           LBSR   L0FDC
           BRA    L2A06
L2A14      PULS   A
           CLRB
           STB    >$FF60,X
           STB    >$FEC0,X
           LDX    <U0053
           LEAX   >$6FE1,X
           LDA    #39
           PSHS   A
L2A29      DEC    ,S
           BLT    L2A36
           BSR    L2A91
           LDB    #35
           LBSR   L0FDC
           BRA    L2A29
L2A36      PULS   A
           CLR    >X0500,X
           CLR    >X05A0,X
           LDX    <U0053
           LEAX   >X0281,X
           LDA    #23
           PSHS   A
L2A4A      DEC    ,S
           BLT    L2A5B
           BSR    L2A7F
           LDB    #35
           LBSR   L0FDC
           LEAX   >X04FC,X
           BRA    L2A4A
L2A5B      PULS   A
           CLRB
           STB    -1,X
           LDX    <U0053
           LEAX   >X0319,X
           LDA    #23
           PSHS   A
L2A6A      DEC    ,S
           BLT    L2A7B
           BSR    L2A7F
           LDB    #35
           LBSR   L0FDC
           LEAX   >X04FC,X
           BRA    L2A6A
L2A7B      CLR    <U000A
           PULS   PC,A
L2A7F      PSHS   X
           LDD    #8
L2A84      STA    -1,X
           STA    U0004,X
           LEAX   >X00A0,X
           DECB
           BNE    L2A84
           PULS   PC,X
L2A91      CLRA
           CLRB
           STD    >$FEC0,X
           STD    >$FEC2,X
           STD    >$FF60,X
           STD    >$FF62,X
           STD    >X0500,X
           STD    >X0502,X
           STD    >X05A0,X
           STD    >X05A2,X
           RTS
L2AB4      STU    <U0018
           LBSR   L29F1
L2AB9      LDU    <U0018
           LBSR   L28B6
L2ABE      LDD    <U0033
           ADDD   #1
           STD    <U0033
           LDB    #1
           LBSR   L0E2B
           LDU    <U0018
           LBSR   L2909
           LDB    #1
           LBSR   L107E
           BEQ    L2ABE
           LBSR   L29E2
           BRA    L2ABE
L2ADB      LDD    #5120
           LDY    #2546
           STY    <U0014
L2AE5      STB    ,Y+
           DECA
           BNE    L2AE5
           LDD    #2546
           CLR    <U0016
           LDD    #786
           LBSR   L28D5
           LEAU   >L2B75,PC
           LBSR   L0FA2
           LDD    #2067
           LBSR   L28D5
           LEAX   >X0140,X
           LDB    #64
           INC    <U0041
           LBSR   L0FDC
           CLR    <U0041
           LEAX   -4,X
L2B11      LBSR   L2B97
           CMPB   #35
           BEQ    L2B11
           CMPB   #64
           BEQ    L2B11
           CMPB   #42
           BEQ    L2B11
           CMPB   #13
           BEQ    L2B69
           CMPB   #8
           BNE    L2B49
           TST    <U0016
           BEQ    L2B11
           DEC    <U0016
           LDD    <U0014
           SUBD   #1
           STD    <U0014
           LDB    #32
           LBSR   L0FDC
           LEAX   -8,X
           LDB    #64
           INC    <U0041
           LBSR   L0FDC
           CLR    <U0041
           LEAX   -4,X
           BRA    L2B11
L2B49      LDA    <U0016
           CMPA   #19
           BCC    L2B11
           INC    <U0016
           LDY    <U0014
           STB    ,Y+
           STY    <U0014
           LBSR   L0FDC
           INC    <U0041
           LDB    #64
           LBSR   L0FDC
           CLR    <U0041
           LEAX   -4,X
           BRA    L2B11
L2B69      TST    <U0016
           BNE    L2B74
           LDB    #45
           STB    >U09F2
           INC    <U0016
L2B74      RTS
L2B75      FCC    "Type your name, then press enter:"
           FCB    $00
L2B97      PSHS   Y,X,A
           LEAS   -1,S
           LEAX   ,S
           LDY    #1
           CLRA
           OS9    I$Read
           LDB    ,S+
           PULS   PC,Y,X,A
L2BA9      PSHS   X,D
           LEAX   >L2D3B,PC
           LDA    #1
           OS9    I$Open
           BCS    L2BC5
           LDX    #2306
           LDY    #240
           OS9    I$Read
L2BC0      OS9    I$Close
L2BC3      PULS   PC,X,D
L2BC5      LDA    #241
           LDX    #2306
           CLRB
L2BCB      DECA
           BEQ    L2BD2
           STB    ,X+
           BRA    L2BCB
L2BD2      LEAX   >L2D3B,PC
           LDD    #795
           OS9    I$Create
           BCS    L2BC3
           LDX    #2306
           LDY    #240
           OS9    I$Write
           BRA    L2BC0
L2BEA      PSHS   U,Y,X,D
           TST    <U004A
           BEQ    L2C11
           LDD    #8719
           LBSR   L28D5
           LEAX   >X0280,X
           LEAU   >L2C13,PC
           LBSR   L0FA2
           LDD    #8976
           LBSR   L28D5
           LEAX   >X0320,X
           LDB    <U0017
           CLRA
           LBSR   J12FE
L2C11      PULS   PC,U,Y,X,D
L2C13      FCC    "Score"
           FCB    $00
L2C19      LBSR   L0A7A
           LDD    #2307
           LBSR   L28D5
           LEAU   >L2CC0,PC
           LBSR   L0FA2
           LDU    #2306
           LDA    #10
           PSHS   A
L2C30      DEC    ,S
           BLT    L2C93
           TST    ,U
           BEQ    L2C64
           LDD    #1032
           SUBB   ,S
           ADDB   #6
           ADDA   #2
           LBSR   L28EF
           PSHS   U
           LBSR   L0FA2
           LDD    #7688
           SUBB   2,S
           ADDB   #6
           ADDA   #2
           LBSR   L28EF
           LDU    ,S
           LDB    <$14,U
           LBSR   J12FE
           PULS   U
           LEAU   <$18,U
           BRA    L2C30
L2C64      LDD    #1032
           SUBB   ,S
           ADDB   #6
           ADDA   #2
           LBSR   L28EF
           PSHS   U
           LEAU   >L2CBE,PC
           LBSR   L0FA2
           LDD    #7688
           SUBB   2,S
           ADDB   #6
           ADDA   #2
           LBSR   L28EF
           LEAU   >L2CBE,PC
           LBSR   L0FA2
           PULS   U
           LEAU   <$18,U
           BRA    L2C30
L2C93      PULS   A
           LDD    #1045
           LBSR   L28D5
           LEAU   >L2CD6,PC
           LBSR   L0FA2
           LEAU   >L289C,PC
           LBRA   L2AB4
           FCB    $17
           FCB    $E6
           FCB    $13
           FCB    $DE
           FCB    $18
           FCB    $17
           FCB    $FC
           FCB    $05
           FCB    $17
           FCB    $FE
           FCB    $27
           FCB    $17
           FCB    $E4
           FCB    $A5
           FCB    $86
           FCB    $01
           FCC    "M9OM9"
L2CBE      FCB    $2D
           FCB    $00
L2CC0      FCC    "Tournament Scoreboard"
           FCB    $00
L2CD6      FCC    "Continue tournament?"
           FCB    $00
L2CEB      LDU    #2282
           LDA    #10
           PSHS   A
L2CF2      DEC    ,S
           BLT    L2D21
           LEAU   <$18,U
           LDA    <U0017
           CMPA   <$14,U
           BCS    L2CF2
           BNE    L2D1B
           CMPA   #144
           BNE    L2D1B
           LDA    <U0025
           CMPA   <$15,U
           BCS    L2D1B
           LDA    <U0026
           CMPA   <$16,U
           BCS    L2D1B
           LDA    <U0023
           CMPA   <$17,U
           BHI    L2CF2
L2D1B      LDA    ,S
           BSR    L2D53
           BSR    L2D7B
L2D21      LEAX   >L2D3B,PC
           LDA    #3
           OS9    I$Open
           BCS    L2D39
           LDX    #2306
           LDY    #240
           OS9    I$Write
           OS9    I$Close
L2D39      PULS   PC,A
L2D3B      FCC    "/DD/SYS/shanghai.scores"
           FCB    $0D
L2D53      PSHS   U,A
           LDX    #2498
           LDY    #2522
           PSHS   A
L2D5E      DEC    ,S
           BLT    L2D77
           LDA    #24
           PSHS   Y,X
L2D66      LDB    ,X+
           STB    ,Y+
           DECA
           BNE    L2D66
           PULS   Y,X
           LEAX   <-$18,X
           LEAY   <-$18,Y
           BRA    L2D5E
L2D77      PULS   A
           PULS   PC,U,A
L2D7B      PSHS   U
           LDX    #2546
           LDA    <U0016
           CLR    A,X
L2D84      LDA    ,X+
           STA    ,U+
           BNE    L2D84
           PULS   U
           LDA    <U0017
           STA    <$14,U
           LDA    <U0025
           STA    <$15,U
           LDA    <U0026
           STA    <$16,U
           LDA    <U0023
           STA    <$17,U
           RTS
L2DA1      LEAU   >L2DB9,PC
           LDX    <U0053
           LEAX   >X10DC,X
L2DAB      LDA    ,U+
           CMPA   #187
           BEQ    L2DB8
           LBSR   L1015
           LEAX   U0004,X
           BRA    L2DAB
L2DB8      RTS
L2DB9      FCB    $00
           FCB    $00
           FCB    $00
           FCB    $FF
           FCB    $FE
           FCB    $0C
           FCB    $03
           FCB    $FF
           FCB    $C0
           FCB    $03
           FCB    $FF
           FCB    $C0
           FCB    $00
           FCB    $03
           FCB    $C0
           FCB    $00
           FCB    $3F
           FCB    $C0
           FCB    $00
           FCB    $03
           FCB    $FF
           FCB    $00
           FCB    $00
           FCB    $FF
           FCB    $FF
           FCB    $01
           FCB    $87
           FCB    $FF
           FCB    $80
           FCB    $07
           FCB    $FF
           FCB    $80
           FCB    $00
           FCB    $07
           FCB    $80
           FCB    $00
           FCB    $07
           FCB    $FF
           FCB    $87
           FCB    $50
           FCB    $00
           FCB    $00
           FCB    $07
           FCB    $F0
           FCB    $1F
           FCB    $FC
           FCB    $00
           FCB    $3C
           FCB    $00
           FCB    $00
           FCB    $3C
           FCB    $00
           FCB    $00
           FCB    $07
           FCB    $E0
           FCB    $00
           FCB    $03
           FCB    $F0
           FCB    $00
           FCB    $00
           FCB    $30
           FCB    $00
           FCB    $0F
           FCB    $C0
           FCB    $03
           FCB    $FF
           FCB    $80
           FCB    $78
           FCB    $00
           FCB    $00
           FCB    $78
           FCB    $00
           FCB    $00
           FCB    $0F
           FCB    $C0
           FCB    $00
           FCB    $00
           FCB    $78
           FCB    $02
           FCB    $70
           FCB    $00
           FCB    $00
           FCB    $1F
           FCB    $00
           FCB    $00
           FCB    $FC
           FCB    $00
           FCB    $3C
           FCB    $00
           FCB    $00
           FCB    $3C
           FCB    $00
           FCB    $00
           FCB    $0F
           FCB    $F0
           FCB    $00
           FCB    $00
           FCB    $FC
           FCB    $00
           FCB    $00
           FCB    $30
           FCB    $00
           FCB    $3C
           FCB    $00
           FCB    $00
           FCB    $1F
           FCB    $80
           FCB    $78
           FCB    $00
           FCB    $00
           FCB    $78
           FCB    $00
           FCB    $00
           FCB    $1F
           FCB    $E0
           FCB    $00
           FCB    $00
           FCB    $78
           FCB    $02
           FCB    $50
           FCB    $00
           FCB    $00
           FCB    $3C
           FCB    $00
           FCB    $00
           FCB    $0C
           FCB    $00
           FCB    $3C
           FCB    $00
           FCB    $00
           FCB    $3C
           FCB    $00
           FCB    $00
           FCB    $1D
           FCB    $F0
           FCB    $00
           FCB    $00
           FCB    $3F
           FCB    $00
           FCB    $00
           FCB    $30
           FCB    $00
           FCB    $F0
           FCB    $00
           FCB    $00
           FCB    $01
           FCB    $80
           FCB    $78
           FCB    $00
           FCB    $00
           FCB    $78
           FCB    $00
           FCB    $00
           FCB    $3D
           FCB    $E0
           FCB    $00
           FCB    $00
           FCB    $78
           FCB    $00
           FCB    $00
           FCB    $00
           FCB    $00
           FCB    $3C
           FCB    $00
           FCB    $00
           FCB    $0C
           FCB    $00
           FCB    $3C
           FCB    $00
           FCB    $00
           FCB    $3C
           FCB    $00
           FCB    $00
           FCB    $1C
           FCB    $F8
           FCB    $00
           FCB    $00
           FCB    $3F
           FCB    $C0
           FCB    $00
           FCB    $30
           FCB    $01
           FCB    $C0
           FCB    $00
           FCB    $00
           FCB    $01
           FCB    $80
           FCB    $78
           FCB    $00
           FCB    $00
           FCB    $78
           FCB    $00
           FCB    $00
           FCB    $38
           FCB    $F0
           FCB    $00
           FCB    $00
           FCB    $78
           FCB    $00
           FCB    $00
           FCB    $00
           FCB    $00
           FCB    $3E
           FCB    $00
           FCB    $00
           FCB    $00
           FCB    $00
           FCB    $3C
           FCB    $00
           FCB    $00
           FCB    $3C
           FCB    $00
           FCB    $00
           FCB    $38
           FCB    $7C
           FCB    $00
           FCB    $00
           FCB    $3F
           FCB    $F0
           FCB    $00
           FCB    $30
           FCB    $07
           FCB    $80
           FCB    $00
           FCB    $00
           FCB    $00
           FCB    $00
           FCB    $78
           FCB    $00
           FCB    $00
           FCB    $78
           FCB    $00
           FCB    $00
           FCB    $70
           FCB    $78
           FCB    $00
           FCB    $00
           FCB    $78
           FCB    $00
           FCB    $00
           FCB    $00
           FCB    $00
           FCB    $3F
           FCB    $00
           FCB    $00
           FCB    $00
           FCB    $00
           FCB    $3C
           FCB    $00
           FCB    $00
           FCB    $3C
           FCB    $00
           FCB    $00
           FCB    $70
           FCB    $3C
           FCB    $00
           FCB    $00
           FCB    $33
           FCB    $FC
           FCB    $00
           FCB    $30
           FCB    $0F
           FCB    $00
           FCB    $00
           FCB    $00
           FCB    $00
           FCB    $00
           FCB    $78
           FCB    $00
           FCB    $00
           FCB    $78
           FCB    $00
           FCB    $00
           FCB    $E0
           FCB    $38
           FCB    $00
           FCB    $00
           FCB    $78
           FCB    $00
           FCB    $00
           FCB    $00
           FCB    $00
           FCB    $0F
           FCB    $F8
           FCB    $00
           FCB    $00
           FCB    $00
           FCB    $3C
           FCB    $00
           FCB    $00
           FCB    $3C
           FCB    $00
           FCB    $00
           FCB    $70
           FCB    $1E
           FCB    $00
           FCB    $00
           FCB    $30
           FCB    $FF
           FCB    $00
           FCB    $30
           FCB    $1E
           FCB    $00
           FCB    $00
           FCB    $00
           FCB    $00
           FCB    $00
           FCB    $78
           FCB    $00
           FCB    $00
           FCB    $78
           FCB    $00
           FCB    $00
           FCB    $E0
           FCB    $3C
           FCB    $00
           FCB    $00
           FCB    $78
           FCB    $00
           FCB    $00
           FCB    $00
           FCB    $00
           FCB    $03
           FCB    $FF
           FCB    $F0
           FCB    $00
           FCB    $00
           FCB    $3C
           FCB    $00
           FCB    $00
           FCB    $3C
           FCB    $00
           FCB    $00
           FCB    $E0
           FCB    $0F
           FCB    $00
           FCB    $00
           FCB    $30
           FCB    $3F
           FCB    $C0
           FCB    $30
           FCB    $1E
           FCB    $00
           FCB    $00
           FCB    $00
           FCB    $00
           FCB    $00
           FCB    $78
           FCB    $00
           FCB    $00
           FCB    $78
           FCB    $00
           FCB    $01
           FCB    $C0
           FCB    $1E
           FCB    $00
           FCB    $00
           FCB    $78
           FCB    $00
           FCB    $00
           FCB    $00
           FCB    $00
           FCB    $00
           FCB    $7F
           FCB    $FF
           FCB    $80
           FCB    $00
           FCB    $3F
           FCB    $FF
           FCB    $FF
           FCB    $FC
           FCB    $00
           FCB    $01
           FCB    $FF
           FCB    $FF
           FCB    $80
           FCB    $00
           FCB    $30
           FCB    $0F
           FCB    $F0
           FCB    $30
           FCB    $1E
           FCB    $00
           FCB    $00
           FCB    $00
           FCB    $00
           FCB    $00
           FCB    $7F
           FCB    $FF
           FCB    $FF
           FCB    $F8
           FCB    $00
           FCB    $03
           FCB    $FF
           FCB    $FF
           FCB    $00
           FCB    $00
           FCB    $78
           FCB    $00
           FCB    $00
           FCB    $00
           FCB    $00
           FCB    $00
           FCB    $03
           FCB    $FF
           FCB    $F0
           FCB    $00
           FCB    $3C
           FCB    $00
           FCB    $00
           FCB    $3C
           FCB    $00
           FCB    $03
           FCB    $80
           FCB    $07
           FCB    $C0
           FCB    $00
           FCB    $30
           FCB    $03
           FCB    $FC
           FCB    $30
           FCB    $1E
           FCB    $00
           FCB    $00
           FCB    $01
           FCB    $FF
           FCB    $E0
           FCB    $78
           FCB    $00
           FCB    $00
           FCB    $78
           FCB    $00
           FCB    $07
           FCB    $00
           FCB    $0F
           FCB    $80
           FCB    $00
           FCB    $78
           FCB    $00
           FCB    $00
           FCB    $00
           FCB    $00
           FCB    $00
           FCB    $00
           FCB    $1F
           FCB    $F8
           FCB    $00
           FCB    $3C
           FCB    $00
           FCB    $00
           FCB    $3C
           FCB    $00
           FCB    $03
           FCB    $00
           FCB    $03
           FCB    $C0
           FCB    $00
           FCB    $30
           FCB    $00
           FCB    $FF
           FCB    $30
           FCB    $1E
           FCB    $00
           FCB    $00
           FCB    $00
           FCB    $07
           FCB    $80
           FCB    $78
           FCB    $00
           FCB    $00
           FCB    $78
           FCB    $00
           FCB    $06
           FCB    $00
           FCB    $07
           FCB    $80
           FCB    $00
           FCB    $78
           FCB    $00
           FCB    $00
           FCB    $00
           FCB    $00
           FCB    $00
           FCB    $00
           FCB    $01
           FCB    $FC
           FCB    $00
           FCB    $3C
           FCB    $00
           FCB    $00
           FCB    $3C
           FCB    $00
           FCB    $07
           FCB    $00
           FCB    $03
           FCB    $E0
           FCB    $00
           FCB    $30
           FCB    $00
           FCB    $3F
           FCB    $F0
           FCB    $1F
           FCB    $00
           FCB    $00
           FCB    $00
           FCB    $07
           FCB    $80
           FCB    $78
           FCB    $00
           FCB    $00
           FCB    $78
           FCB    $00
           FCB    $0E
           FCB    $00
           FCB    $07
           FCB    $C0
           FCB    $00
           FCB    $78
           FCB    $00
           FCB    $00
           FCB    $00
           FCB    $00
           FCB    $00
           FCB    $00
           FCB    $00
           FCB    $7C
           FCB    $00
           FCB    $3C
           FCB    $00
           FCB    $00
           FCB    $3C
           FCB    $00
           FCB    $0E
           FCB    $00
           FCB    $01
           FCB    $F0
           FCB    $00
           FCB    $30
           FCB    $00
           FCB    $0F
           FCB    $F0
           FCB    $0F
           FCB    $80
           FCB    $00
           FCB    $00
           FCB    $07
           FCB    $80
           FCB    $78
           FCB    $00
           FCB    $00
           FCB    $78
           FCB    $00
           FCB    $1C
           FCB    $00
           FCB    $03
           FCB    $E0
           FCB    $00
           FCB    $78
           FCB    $00
           FCB    $00
           FCB    $00
           FCB    $00
           FCB    $30
           FCB    $00
           FCB    $00
           FCB    $3C
           FCB    $00
           FCB    $3C
           FCB    $00
           FCB    $00
           FCB    $3C
           FCB    $00
           FCB    $0C
           FCB    $00
           FCB    $00
           FCB    $F0
           FCB    $00
           FCB    $30
           FCB    $00
           FCB    $03
           FCB    $F0
           FCB    $07
           FCB    $E0
           FCB    $00
           FCB    $00
           FCB    $07
           FCB    $80
           FCB    $78
           FCB    $00
           FCB    $00
           FCB    $78
           FCB    $00
           FCB    $18
           FCB    $00
           FCB    $01
           FCB    $E0
           FCB    $00
           FCB    $78
           FCB    $00
           FCB    $00
           FCB    $00
           FCB    $00
           FCB    $30
           FCB    $00
           FCB    $00
           FCB    $3C
           FCB    $00
           FCB    $3C
           FCB    $00
           FCB    $00
           FCB    $3C
           FCB    $00
           FCB    $1C
           FCB    $00
           FCB    $00
           FCB    $F8
           FCB    $00
           FCB    $30
           FCB    $00
           FCB    $00
           FCB    $F0
           FCB    $01
           FCB    $F8
           FCB    $00
           FCB    $00
           FCB    $0E
           FCB    $00
           FCB    $78
           FCB    $00
           FCB    $00
           FCB    $78
           FCB    $00
           FCB    $38
           FCB    $00
           FCB    $01
           FCB    $F0
           FCB    $00
           FCB    $78
           FCB    $00
           FCB    $00
           FCB    $00
           FCB    $00
           FCB    $3F
           FCB    $00
           FCB    $00
           FCB    $70
           FCB    $00
           FCB    $3C
           FCB    $00
           FCB    $00
           FCB    $3C
           FCB    $00
           FCB    $38
           FCB    $00
           FCB    $00
           FCB    $7C
           FCB    $00
           FCB    $30
           FCB    $00
           FCB    $00
           FCB    $70
           FCB    $00
           FCB    $7E
           FCB    $00
           FCB    $00
           FCB    $3C
           FCB    $00
           FCB    $78
           FCB    $00
           FCB    $00
           FCB    $78
           FCB    $00
           FCB    $70
           FCB    $00
           FCB    $00
           FCB    $F8
           FCB    $00
           FCB    $78
           FCB    $00
           FCB    $00
           FCB    $00
           FCB    $00
           FCB    $3F
           FCB    $F0
           FCB    $07
           FCB    $E0
           FCB    $00
           FCB    $3C
           FCB    $00
           FCB    $00
           FCB    $3C
           FCB    $00
           FCB    $7C
           FCB    $00
           FCB    $00
           FCB    $3E
           FCB    $00
           FCB    $30
           FCB    $00
           FCB    $00
           FCB    $70
           FCB    $00
           FCB    $1F
           FCB    $E0
           FCB    $03
           FCB    $F0
           FCB    $00
           FCB    $78
           FCB    $00
           FCB    $00
           FCB    $78
           FCB    $00
           FCB    $F8
           FCB    $00
           FCB    $00
           FCB    $7C
           FCB    $00
           FCB    $78
           FCB    $00
           FCB    $00
           FCB    $00
           FCB    $00
           FCB    $30
           FCB    $7F
           FCB    $FF
           FCB    $00
           FCB    $03
           FCB    $FF
           FCB    $C0
           FCB    $03
           FCB    $FF
           FCB    $C3
           FCB    $FF
           FCB    $E0
           FCB    $0F
           FCB    $FF
           FCB    $C3
           FCB    $FF
           FCB    $00
           FCB    $00
           FCB    $30
           FCB    $00
           FCB    $03
           FCB    $FF
           FCB    $FF
           FCB    $00
           FCB    $07
           FCB    $FF
           FCB    $80
           FCB    $07
           FCB    $FF
           FCB    $87
           FCB    $FF
           FCB    $80
           FCB    $1F
           FCB    $FF
           FCB    $87
           FCB    $FF
           FCB    $80
           FCB    $00
           FCB    $BB
L30B2      FCB    $00
           FCC    "$64$ "
           FCB    $00
           FCB    $34
           FCB    $04
           FCB    $20
           FCB    $24
           FCB    $00
           FCB    $00
           FCB    $00
           FCB    $00
           FCB    $3F
           FCB    $00
           FCC    "$3#$"
           FCB    $15
           FCB    $00
           FCB    $23
           FCB    $05
           FCB    $15
           FCB    $24
           FCB    $00
           FCB    $00
           FCB    $00
           FCB    $00
           FCB    $3F
L30D2      FCB    $00
           FCB    $0D
           FCB    $88
           FCB    $C2
           FCB    $00
           FCB    $9F
           FCB    $BD
           FCB    $C2
           FCB    $00
           FCB    $9E
           FCB    $88
           FCB    $BC
           FCB    $C1
           FCB    $00
           FCB    $9E
           FCB    $BE
           FCB    $89
           FCB    $BE
           FCB    $00
           FCB    $9D
           FCB    $89
           FCB    $80
           FCB    $C3
           FCB    $00
           FCB    $9D
           FCB    $87
           FCB    $BE
           FCB    $89
           FCB    $C2
           FCB    $00
           FCB    $96
           FCB    $B2
           FCB    $BD
           FCB    $C3
           FCB    $BC
           FCB    $AD
           FCB    $00
           FCB    $02
           FCB    $BE
           FCB    $80
           FCB    $BD
           FCB    $C1
           FCB    $00
           FCB    $97
           FCB    $BC
           FCB    $80
           FCB    $BD
           FCB    $C2
           FCB    $AD
           FCB    $C2
           FCB    $80
           FCB    $87
           FCB    $B3
           FCB    $C2
           FCB    $B1
           FCB    $87
           FCB    $00
           FCB    $95
           FCB    $B4
           FCB    $00
           FCB    $02
           FCB    $AD
           FCB    $00
           FCB    $03
           FCB    $07
           FCB    $02
           FCB    $3C
           FCB    $03
           FCB    $00
           FCB    $93
           FCB    $87
           FCB    $BE
           FCB    $00
           FCB    $03
           FCB    $87
           FCB    $31
           FCB    $03
           FCB    $B2
           FCB    $43
           FCB    $02
           FCB    $B4
           FCB    $BC
           FCB    $00
           FCB    $96
           FCB    $B2
           FCB    $AD
           FCB    $80
           FCB    $87
           FCB    $BC
           FCB    $43
           FCB    $03
           FCB    $C1
           FCB    $B2
           FCB    $B4
           FCB    $BC
           FCB    $00
           FCB    $88
           FCB    $AD
           FCB    $80
           FCB    $AD
           FCB    $87
           FCB    $80
           FCB    $87
           FCB    $AD
           FCB    $BC
           FCB    $C3
           FCB    $BB
           FCB    $80
           FCB    $AD
           FCB    $80
           FCB    $B2
           FCB    $80
           FCB    $B2
           FCB    $B4
           FCB    $88
           FCB    $B2
           FCB    $43
           FCB    $02
           FCB    $C1
           FCB    $80
           FCB    $BD
           FCB    $00
           FCB    $8A
           FCB    $B2
           FCB    $BD
           FCB    $43
           FCB    $02
           FCB    $BB
           FCB    $87
           FCB    $BC
           FCB    $C3
           FCB    $BB
           FCB    $00
           FCB    $02
           FCB    $87
           FCB    $B4
           FCB    $AD
           FCB    $00
           FCB    $03
           FCB    $BC
           FCB    $BD
           FCB    $C3
           FCB    $C1
           FCB    $BD
           FCB    $BE
           FCB    $00
           FCB    $88
           FCB    $B2
           FCB    $BD
           FCB    $C2
           FCB    $BB
           FCB    $AD
           FCB    $00
           FCB    $02
           FCB    $B2
           FCB    $BB
           FCB    $BD
           FCB    $BC
           FCB    $AD
           FCB    $80
           FCB    $87
           FCB    $80
           FCB    $AD
           FCB    $00
           FCB    $03
           FCB    $89
           FCB    $43
           FCB    $02
           FCB    $B3
           FCB    $C2
           FCB    $B4
           FCB    $00
           FCB    $86
           FCB    $87
           FCB    $BD
           FCB    $C2
           FCB    $00
           FCB    $05
           FCB    $B2
           FCB    $BE
           FCB    $87
           FCB    $B2
           FCB    $C3
           FCB    $B4
           FCB    $88
           FCB    $B4
           FCB    $88
           FCB    $B4
           FCB    $00
           FCB    $04
           FCB    $43
           FCB    $03
           FCB    $B4
           FCB    $00
           FCB    $86
           FCB    $B2
           FCB    $C2
           FCB    $AD
           FCB    $00
           FCB    $05
           FCB    $B2
           FCB    $C2
           FCB    $80
           FCB    $87
           FCB    $BD
           FCB    $C2
           FCB    $88
           FCB    $09
           FCB    $02
           FCB    $AD
           FCB    $00
           FCB    $03
           FCB    $87
           FCB    $80
           FCB    $43
           FCB    $03
           FCB    $AD
           FCB    $00
           FCB    $85
           FCB    $BD
           FCB    $BB
           FCB    $88
           FCB    $00
           FCB    $05
           FCB    $87
           FCB    $BD
           FCB    $B4
           FCB    $80
           FCB    $B2
           FCB    $C3
           FCB    $B4
           FCB    $C3
           FCB    $BD
           FCB    $BE
           FCB    $80
           FCB    $AC
           FCB    $00
           FCB    $02
           FCB    $B4
           FCB    $AD
           FCB    $BD
           FCB    $C3
           FCB    $34
           FCB    $02
           FCB    $00
           FCB    $84
           FCB    $C2
           FCB    $B4
           FCB    $BC
           FCB    $88
           FCB    $B4
           FCB    $00
           FCB    $04
           FCB    $B3
           FCB    $BE
           FCB    $80
           FCB    $B1
           FCB    $C3
           FCB    $C2
           FCB    $43
           FCB    $02
           FCB    $BD
           FCB    $80
           FCB    $84
           FCB    $9A
           FCB    $00
           FCB    $02
           FCB    $C1
           FCB    $80
           FCB    $BD
           FCB    $B1
           FCB    $BE
           FCB    $00
           FCB    $83
           FCB    $89
           FCB    $BC
           FCB    $B1
           FCB    $B4
           FCB    $3C
           FCB    $03
           FCB    $00
           FCB    $03
           FCB    $87
           FCB    $C2
           FCB    $80
           FCB    $AD
           FCB    $BD
           FCB    $43
           FCB    $03
           FCB    $C2
           FCB    $87
           FCB    $80
           FCB    $AC
           FCB    $9E
           FCB    $00
           FCB    $03
           FCB    $B3
           FCB    $C3
           FCB    $C2
           FCB    $00
           FCB    $83
           FCB    $BC
           FCB    $B1
           FCB    $B2
           FCB    $AD
           FCB    $00
           FCB    $06
           FCB    $87
           FCB    $C3
           FCB    $80
           FCB    $B1
           FCB    $B3
           FCB    $C3
           FCB    $C2
           FCB    $C3
           FCB    $C2
           FCB    $C1
           FCB    $BE
           FCB    $80
           FCB    $87
           FCB    $AD
           FCB    $00
           FCB    $02
           FCB    $89
           FCB    $C3
           FCB    $BC
           FCB    $C2
           FCB    $00
           FCB    $82
           FCB    $B4
           FCB    $80
           FCB    $87
           FCB    $00
           FCB    $03
           FCB    $07
           FCB    $02
           FCB    $00
           FCB    $02
           FCB    $87
           FCB    $C2
           FCB    $80
           FCB    $88
           FCB    $BC
           FCB    $43
           FCB    $02
           FCB    $B2
           FCB    $43
           FCB    $02
           FCB    $C2
           FCB    $00
           FCB    $05
           FCB    $88
           FCB    $C3
           FCB    $BE
           FCB    $BD
           FCB    $C3
           FCB    $BB
           FCB    $00
           FCB    $83
           FCB    $AD
           FCB    $89
           FCB    $B4
           FCB    $00
           FCB    $04
           FCB    $87
           FCB    $C1
           FCB    $80
           FCB    $89
           FCB    $C2
           FCB    $43
           FCB    $02
           FCB    $C2
           FCB    $B2
           FCB    $C2
           FCB    $C3
           FCB    $C2
           FCB    $B2
           FCB    $80
           FCB    $88
           FCB    $B4
           FCB    $B2
           FCB    $43
           FCB    $05
           FCB    $B4
           FCB    $00
           FCB    $82
           FCB    $89
           FCB    $80
           FCB    $C3
           FCB    $00
           FCB    $04
           FCB    $87
           FCB    $BD
           FCB    $80
           FCB    $BC
           FCB    $BD
           FCB    $C3
           FCB    $89
           FCB    $C3
           FCB    $C1
           FCB    $B2
           FCB    $C2
           FCB    $BD
           FCB    $BC
           FCB    $B2
           FCB    $3C
           FCB    $02
           FCB    $80
           FCB    $89
           FCB    $43
           FCB    $03
           FCB    $C2
           FCB    $C1
           FCB    $00
           FCB    $04
           FCB    $BC
           FCB    $00
           FCB    $7A
           FCB    $87
           FCB    $00
           FCB    $02
           FCB    $88
           FCB    $BE
           FCB    $C3
           FCB    $80
           FCB    $87
           FCB    $AD
           FCB    $00
           FCB    $02
           FCB    $B2
           FCB    $C3
           FCB    $B4
           FCB    $B2
           FCB    $C3
           FCB    $88
           FCB    $89
           FCB    $C3
           FCB    $BB
           FCB    $BC
           FCB    $43
           FCB    $05
           FCB    $B4
           FCB    $B3
           FCB    $43
           FCB    $03
           FCB    $C1
           FCB    $C3
           FCB    $BB
           FCB    $00
           FCB    $03
           FCB    $BD
           FCB    $00
           FCB    $7D
           FCB    $88
           FCB    $BE
           FCB    $C3
           FCB    $00
           FCB    $03
           FCB    $AD
           FCB    $80
           FCB    $87
           FCB    $B1
           FCB    $87
           FCB    $BD
           FCB    $C2
           FCB    $C3
           FCB    $88
           FCB    $43
           FCB    $02
           FCB    $C2
           FCB    $3C
           FCB    $02
           FCB    $C3
           FCB    $BC
           FCB    $BD
           FCB    $C2
           FCB    $B2
           FCB    $C3
           FCB    $BB
           FCB    $AD
           FCB    $BD
           FCB    $43
           FCB    $02
           FCB    $BC
           FCB    $B4
           FCB    $80
           FCB    $BD
           FCB    $BE
           FCB    $00
           FCB    $7C
           FCB    $87
           FCB    $BE
           FCB    $C3
           FCB    $00
           FCB    $07
           FCB    $B2
           FCB    $C2
           FCB    $C3
           FCB    $89
           FCB    $B4
           FCB    $89
           FCB    $43
           FCB    $02
           FCB    $AD
           FCB    $32
           FCB    $02
           FCB    $80
           FCB    $87
           FCB    $AD
           FCB    $80
           FCB    $BD
           FCB    $C1
           FCB    $80
           FCB    $BD
           FCB    $43
           FCB    $03
           FCB    $C2
           FCB    $BB
           FCB    $B3
           FCB    $C2
           FCB    $B4
           FCB    $00
           FCB    $7C
           FCB    $B4
           FCB    $C3
           FCB    $BB
           FCB    $80
           FCB    $2D
           FCB    $02
           FCB    $80
           FCB    $B1
           FCB    $80
           FCB    $B3
           FCB    $43
           FCB    $02
           FCB    $B4
           FCB    $C2
           FCB    $80
           FCB    $C3
           FCB    $BC
           FCB    $B1
           FCB    $00
           FCB    $02
           FCB    $B2
           FCB    $AD
           FCB    $BC
           FCB    $B4
           FCB    $88
           FCB    $C3
           FCB    $C2
           FCB    $43
           FCB    $05
           FCB    $42
           FCB    $02
           FCB    $C3
           FCB    $B4
           FCB    $87
           FCB    $BC
           FCB    $C2
           FCB    $BB
           FCB    $00
           FCB    $78
           FCB    $88
           FCB    $C3
           FCB    $88
           FCB    $BC
           FCB    $87
           FCB    $BC
           FCB    $00
           FCB    $02
           FCB    $AD
           FCB    $B3
           FCB    $BD
           FCB    $C2
           FCB    $80
           FCB    $BD
           FCB    $C1
           FCB    $BD
           FCB    $BE
           FCB    $80
           FCB    $87
           FCB    $BC
           FCB    $43
           FCB    $04
           FCB    $B4
           FCB    $88
           FCB    $C3
           FCB    $C2
           FCB    $BD
           FCB    $43
           FCB    $02
           FCB    $C2
           FCB    $89
           FCB    $C3
           FCB    $C1
           FCB    $00
           FCB    $03
           FCB    $BD
           FCB    $C2
           FCB    $00
           FCB    $78
           FCB    $89
           FCB    $C2
           FCB    $3C
           FCB    $03
           FCB    $BB
           FCB    $00
           FCB    $03
           FCB    $B2
           FCB    $C1
           FCB    $AD
           FCB    $43
           FCB    $04
           FCB    $BC
           FCB    $87
           FCB    $BD
           FCB    $43
           FCB    $06
           FCB    $B4
           FCB    $00
           FCB    $02
           FCB    $87
           FCB    $B2
           FCB    $B4
           FCB    $BD
           FCB    $43
           FCB    $02
           FCB    $80
           FCB    $BD
           FCB    $C3
           FCB    $C2
           FCB    $80
           FCB    $C2
           FCB    $AD
           FCB    $00
           FCB    $77
           FCB    $C3
           FCB    $BE
           FCB    $88
           FCB    $3C
           FCB    $02
           FCB    $B1
           FCB    $00
           FCB    $03
           FCB    $87
           FCB    $BD
           FCB    $BC
           FCB    $43
           FCB    $03
           FCB    $BD
           FCB    $C1
           FCB    $88
           FCB    $43
           FCB    $02
           FCB    $3C
           FCB    $04
           FCB    $BD
           FCB    $C3
           FCB    $C2
           FCB    $BB
           FCB    $80
           FCB    $88
           FCB    $C2
           FCB    $43
           FCB    $02
           FCB    $B4
           FCB    $BD
           FCB    $C3
           FCB    $BC
           FCB    $C3
           FCB    $87
           FCB    $C2
           FCB    $BB
           FCB    $00
           FCB    $76
           FCB    $88
           FCB    $C3
           FCB    $B4
           FCB    $3C
           FCB    $02
           FCB    $BB
           FCB    $B4
           FCB    $00
           FCB    $04
           FCB    $87
           FCB    $BD
           FCB    $43
           FCB    $03
           FCB    $C2
           FCB    $80
           FCB    $88
           FCB    $C2
           FCB    $BB
           FCB    $AD
           FCB    $00
           FCB    $02
           FCB    $87
           FCB    $B2
           FCB    $BD
           FCB    $43
           FCB    $02
           FCB    $C2
           FCB    $00
           FCB    $02
           FCB    $BC
           FCB    $BD
           FCB    $88
           FCB    $C2
           FCB    $AD
           FCB    $80
           FCB    $89
           FCB    $80
           FCB    $C3
           FCB    $C2
           FCB    $AD
           FCB    $00
           FCB    $75
           FCB    $BD
           FCB    $C1
           FCB    $87
           FCB    $3C
           FCB    $03
           FCB    $B4
           FCB    $00
           FCB    $05
           FCB    $87
           FCB    $B2
           FCB    $BD
           FCB    $C3
           FCB    $BE
           FCB    $87
           FCB    $BD
           FCB    $B4
           FCB    $88
           FCB    $31
           FCB    $03
           FCB    $00
           FCB    $02
           FCB    $87
           FCB    $BD
           FCB    $43
           FCB    $02
           FCB    $C2
           FCB    $00
           FCB    $02
           FCB    $88
           FCB    $C3
           FCB    $AD
           FCB    $B3
           FCB    $BC
           FCB    $BD
           FCB    $BE
           FCB    $BD
           FCB    $C3
           FCB    $B4
           FCB    $00
           FCB    $75
           FCB    $C3
           FCB    $AD
           FCB    $B2
           FCB    $BC
           FCB    $BB
           FCB    $88
           FCB    $AD
           FCB    $00
           FCB    $06
           FCB    $87
           FCB    $BD
           FCB    $89
           FCB    $BB
           FCB    $87
           FCB    $BD
           FCB    $B4
           FCB    $BC
           FCB    $BD
           FCB    $BC
           FCB    $AD
           FCB    $81
           FCB    $00
           FCB    $03
           FCB    $B3
           FCB    $43
           FCB    $02
           FCB    $BC
           FCB    $B4
           FCB    $80
           FCB    $BD
           FCB    $80
           FCB    $BD
           FCB    $43
           FCB    $05
           FCB    $B4
           FCB    $00
           FCB    $74
           FCB    $89
           FCB    $C2
           FCB    $80
           FCB    $B2
           FCB    $BC
           FCB    $B4
           FCB    $00
           FCB    $09
           FCB    $B2
           FCB    $BB
           FCB    $88
           FCB    $AD
           FCB    $BD
           FCB    $C2
           FCB    $C1
           FCB    $33
           FCB    $02
           FCB    $AD
           FCB    $80
           FCB    $A4
           FCB    $00
           FCB    $03
           FCB    $B3
           FCB    $43
           FCB    $03
           FCB    $B4
           FCB    $BD
           FCB    $B4
           FCB    $87
           FCB    $43
           FCB    $03
           FCB    $42
           FCB    $02
           FCB    $AD
           FCB    $00
           FCB    $74
           FCB    $BD
           FCB    $34
           FCB    $02
           FCB    $B2
           FCB    $BC
           FCB    $BB
           FCB    $88
           FCB    $00
           FCB    $0A
           FCB    $88
           FCB    $C2
           FCB    $88
           FCB    $C2
           FCB    $AD
           FCB    $87
           FCB    $C3
           FCB    $BB
           FCB    $81
           FCB    $B0
           FCB    $A4
           FCB    $00
           FCB    $03
           FCB    $B2
           FCB    $43
           FCB    $02
           FCB    $C2
           FCB    $43
           FCB    $06
           FCB    $BC
           FCB    $B4
           FCB    $AD
           FCB    $00
           FCB    $73
           FCB    $87
           FCB    $C3
           FCB    $88
           FCB    $B4
           FCB    $88
           FCB    $BC
           FCB    $BB
           FCB    $88
           FCB    $80
           FCB    $87
           FCB    $00
           FCB    $0A
           FCB    $BD
           FCB    $C3
           FCB    $BB
           FCB    $80
           FCB    $BD
           FCB    $BB
           FCB    $B0
           FCB    $80
           FCB    $AF
           FCB    $A1
           FCB    $00
           FCB    $03
           FCB    $87
           FCB    $3C
           FCB    $04
           FCB    $C3
           FCB    $C2
           FCB    $C3
           FCB    $BB
           FCB    $87
           FCB    $B4
           FCB    $00
           FCB    $74
           FCB    $88
           FCB    $C2
           FCB    $88
           FCB    $AD
           FCB    $B2
           FCB    $3C
           FCB    $02
           FCB    $88
           FCB    $B4
           FCB    $B2
           FCB    $AD
           FCB    $00
           FCB    $09
           FCB    $88
           FCB    $43
           FCB    $02
           FCB    $C2
           FCB    $87
           FCB    $C2
           FCB    $80
           FCB    $29
           FCB    $02
           FCB    $A8
           FCB    $9B
           FCB    $9A
           FCB    $00
           FCB    $02
           FCB    $87
           FCB    $31
           FCB    $03
           FCB    $3C
           FCB    $02
           FCB    $BB
           FCB    $80
           FCB    $AD
           FCB    $87
           FCB    $00
           FCB    $74
           FCB    $B3
           FCB    $BE
           FCB    $B1
           FCB    $80
           FCB    $3C
           FCB    $03
           FCB    $88
           FCB    $B4
           FCB    $BD
           FCB    $BB
           FCB    $00
           FCB    $0B
           FCB    $BD
           FCB    $C3
           FCB    $B1
           FCB    $B3
           FCB    $AD
           FCB    $A1
           FCB    $A5
           FCB    $97
           FCB    $A1
           FCB    $A5
           FCB    $97
           FCB    $00
           FCB    $04
           FCB    $87
           FCB    $AD
           FCB    $80
           FCB    $AD
           FCB    $00
           FCB    $02
           FCB    $AD
           FCB    $00
           FCB    $74
           FCB    $BD
           FCB    $BE
           FCB    $BB
           FCB    $80
           FCB    $3C
           FCB    $03
           FCB    $B2
           FCB    $BB
           FCB    $C3
           FCB    $C2
           FCB    $AD
           FCB    $80
           FCB    $AD
           FCB    $00
           FCB    $09
           FCB    $BD
           FCB    $C1
           FCB    $3B
           FCB    $02
           FCB    $80
           FCB    $A2
           FCB    $A4
           FCB    $91
           FCB    $8D
           FCB    $A4
           FCB    $91
           FCB    $8A
           FCB    $00
           FCB    $03
           FCB    $88
           FCB    $00
           FCB    $03
           FCB    $87
           FCB    $80
           FCB    $87
           FCB    $00
           FCB    $72
           FCB    $87
           FCB    $BD
           FCB    $AD
           FCB    $00
           FCB    $02
           FCB    $3C
           FCB    $04
           FCB    $B4
           FCB    $BD
           FCB    $C3
           FCB    $C2
           FCB    $AD
           FCB    $B2
           FCB    $AD
           FCB    $00
           FCB    $09
           FCB    $BD
           FCB    $BC
           FCB    $B1
           FCB    $80
           FCB    $AE
           FCB    $9C
           FCB    $A1
           FCB    $B5
           FCB    $BC
           FCB    $A1
           FCB    $B5
           FCB    $BC
           FCB    $00
           FCB    $02
           FCB    $88
           FCB    $00
           FCB    $78
           FCB    $87
           FCB    $C3
           FCB    $87
           FCB    $00
           FCB    $02
           FCB    $3C
           FCB    $04
           FCB    $B4
           FCB    $BD
           FCB    $43
           FCB    $02
           FCB    $C2
           FCB    $B1
           FCB    $BC
           FCB    $00
           FCB    $0A
           FCB    $BD
           FCB    $C3
           FCB    $B4
           FCB    $80
           FCB    $C0
           FCB    $9E
           FCB    $9B
           FCB    $9E
           FCB    $BA
           FCB    $B8
           FCB    $9E
           FCB    $BA
           FCB    $B4
           FCB    $A4
           FCB    $00
           FCB    $78
           FCB    $87
           FCB    $C2
           FCB    $00
           FCB    $03
           FCB    $3C
           FCB    $05
           FCB    $89
           FCB    $43
           FCB    $03
           FCB    $C2
           FCB    $B2
           FCB    $AD
           FCB    $00
           FCB    $09
           FCB    $88
           FCB    $BD
           FCB    $C2
           FCB    $80
           FCB    $B2
           FCB    $A5
           FCB    $95
           FCB    $B7
           FCB    $97
           FCB    $B5
           FCB    $B7
           FCB    $97
           FCB    $B4
           FCB    $A8
           FCB    $A4
           FCB    $00
           FCB    $77
           FCB    $87
           FCB    $C2
           FCB    $00
           FCB    $03
           FCB    $B2
           FCB    $3C
           FCB    $04
           FCB    $88
           FCB    $C3
           FCB    $B3
           FCB    $43
           FCB    $02
           FCB    $87
           FCB    $BB
           FCB    $00
           FCB    $0A
           FCB    $BC
           FCB    $C3
           FCB    $B4
           FCB    $80
           FCB    $86
           FCB    $A0
           FCB    $93
           FCB    $AA
           FCB    $91
           FCB    $93
           FCB    $AA
           FCB    $91
           FCB    $8D
           FCB    $A7
           FCB    $A1
           FCB    $A8
           FCB    $00
           FCB    $75
           FCB    $87
           FCB    $BE
           FCB    $00
           FCB    $03
           FCB    $88
           FCB    $3C
           FCB    $04
           FCB    $B4
           FCB    $89
           FCB    $87
           FCB    $43
           FCB    $02
           FCB    $C1
           FCB    $BD
           FCB    $AD
           FCB    $00
           FCB    $09
           FCB    $87
           FCB    $BD
           FCB    $C3
           FCB    $BB
           FCB    $00
           FCB    $02
           FCB    $9A
           FCB    $82
           FCB    $84
           FCB    $9B
           FCB    $8B
           FCB    $BA
           FCB    $BF
           FCB    $9F
           FCB    $9E
           FCB    $9B
           FCB    $00
           FCB    $75
           FCB    $87
           FCB    $BE
           FCB    $00
           FCB    $02
           FCB    $AD
           FCB    $88
           FCB    $3C
           FCB    $04
           FCB    $B4
           FCB    $BD
           FCB    $B4
           FCB    $89
           FCB    $43
           FCB    $03
           FCB    $BB
           FCB    $AD
           FCB    $00
           FCB    $09
           FCB    $88
           FCB    $43
           FCB    $02
           FCB    $AD
           FCB    $00
           FCB    $03
           FCB    $85
           FCB    $A2
           FCB    $97
           FCB    $98
           FCB    $A1
           FCB    $A6
           FCB    $9B
           FCB    $AB
           FCB    $A5
           FCB    $94
           FCB    $00
           FCB    $73
           FCB    $87
           FCB    $BE
           FCB    $80
           FCB    $87
           FCB    $AD
           FCB    $87
           FCB    $3C
           FCB    $06
           FCB    $C2
           FCB    $80
           FCB    $BD
           FCB    $C3
           FCB    $BD
           FCB    $C3
           FCB    $B1
           FCB    $00
           FCB    $09
           FCB    $87
           FCB    $BB
           FCB    $C3
           FCB    $C1
           FCB    $88
           FCB    $80
           FCB    $B4
           FCB    $8C
           FCB    $85
           FCB    $A8
           FCB    $82
           FCB    $90
           FCB    $8B
           FCB    $A8
           FCB    $8D
           FCB    $A8
           FCB    $A4
           FCB    $00
           FCB    $73
           FCB    $87
           FCB    $BE
           FCB    $80
           FCB    $88
           FCB    $00
           FCB    $02
           FCB    $BB
           FCB    $3C
           FCB    $04
           FCB    $87
           FCB    $BC
           FCB    $B4
           FCB    $BC
           FCB    $C1
           FCB    $88
           FCB    $C3
           FCB    $C2
           FCB    $AD
           FCB    $00
           FCB    $09
           FCB    $87
           FCB    $88
           FCB    $C3
           FCB    $34
           FCB    $02
           FCB    $80
           FCB    $86
           FCB    $A9
           FCB    $9B
           FCB    $A1
           FCB    $A3
           FCB    $8F
           FCB    $B9
           FCB    $8B
           FCB    $A4
           FCB    $80
           FCB    $9D
           FCB    $00
           FCB    $72
           FCB    $87
           FCB    $BB
           FCB    $80
           FCB    $B4
           FCB    $00
           FCB    $02
           FCB    $B1
           FCB    $3C
           FCB    $04
           FCB    $B4
           FCB    $80
           FCB    $BD
           FCB    $C2
           FCB    $89
           FCB    $80
           FCB    $BD
           FCB    $C3
           FCB    $C1
           FCB    $00
           FCB    $09
           FCB    $87
           FCB    $B4
           FCB    $BD
           FCB    $C2
           FCB    $AD
           FCB    $00
           FCB    $03
           FCB    $C3
           FCB    $9B
           FCB    $B8
           FCB    $9B
           FCB    $BC
           FCB    $AA
           FCB    $8D
           FCB    $80
           FCB    $83
           FCB    $96
           FCB    $00
           FCB    $72
           FCB    $BB
           FCB    $87
           FCB    $AD
           FCB    $00
           FCB    $02
           FCB    $87
           FCB    $3C
           FCB    $05
           FCB    $88
           FCB    $43
           FCB    $02
           FCB    $B4
           FCB    $BE
           FCB    $88
           FCB    $43
           FCB    $02
           FCB    $AD
           FCB    $00
           FCB    $09
           FCB    $BC
           FCB    $88
           FCB    $43
           FCB    $02
           FCB    $BC
           FCB    $AD
           FCB    $B4
           FCB    $88
           FCB    $87
           FCB    $97
           FCB    $8F
           FCB    $97
           FCB    $99
           FCB    $0B
           FCB    $02
           FCB    $00
           FCB    $74
           FCB    $08
           FCB    $02
           FCB    $00
           FCB    $04
           FCB    $B2
           FCB    $3C
           FCB    $04
           FCB    $88
           FCB    $43
           FCB    $03
           FCB    $B3
           FCB    $AD
           FCB    $C3
           FCB    $B2
           FCB    $C2
           FCB    $00
           FCB    $09
           FCB    $B2
           FCB    $88
           FCB    $C2
           FCB    $88
           FCB    $C3
           FCB    $C1
           FCB    $AD
           FCB    $B4
           FCB    $86
           FCB    $A1
           FCB    $91
           FCB    $86
           FCB    $B6
           FCB    $92
           FCB    $8B
           FCB    $A6
           FCB    $00
           FCB    $73
           FCB    $88
           FCB    $00
           FCB    $04
           FCB    $B4
           FCB    $AD
           FCB    $3C
           FCB    $04
           FCB    $B4
           FCB    $BD
           FCB    $43
           FCB    $02
           FCB    $BD
           FCB    $BE
           FCB    $BD
           FCB    $C2
           FCB    $89
           FCB    $BE
           FCB    $00
           FCB    $08
           FCB    $88
           FCB    $C3
           FCB    $C2
           FCB    $B4
           FCB    $B2
           FCB    $C3
           FCB    $AD
           FCB    $00
           FCB    $05
           FCB    $BA
           FCB    $A4
           FCB    $81
           FCB    $8E
           FCB    $BE
           FCB    $00
           FCB    $72
           FCB    $88
           FCB    $00
           FCB    $04
           FCB    $C2
           FCB    $B4
           FCB    $3C
           FCB    $05
           FCB    $B3
           FCB    $43
           FCB    $02
           FCB    $BE
           FCB    $C3
           FCB    $88
           FCB    $C3
           FCB    $B4
           FCB    $BD
           FCB    $AD
           FCB    $00
           FCB    $07
           FCB    $88
           FCB    $3B
           FCB    $02
           FCB    $80
           FCB    $87
           FCB    $BC
           FCB    $C2
           FCB    $00
           FCB    $06
           FCB    $24
           FCB    $02
           FCB    $A1
           FCB    $9B
           FCB    $00
           FCB    $73
           FCB    $B4
           FCB    $00
           FCB    $03
           FCB    $C2
           FCB    $BC
           FCB    $88
           FCB    $3C
           FCB    $03
           FCB    $BB
           FCB    $BC
           FCB    $43
           FCB    $02
           FCB    $C2
           FCB    $BD
           FCB    $B4
           FCB    $BD
           FCB    $C2
           FCB    $87
           FCB    $C3
           FCB    $AD
           FCB    $00
           FCB    $06
           FCB    $87
           FCB    $C2
           FCB    $B3
           FCB    $BC
           FCB    $AD
           FCB    $B1
           FCB    $BD
           FCB    $B4
           FCB    $00
           FCB    $80
           FCB    $BE
           FCB    $88
           FCB    $B4
           FCB    $3C
           FCB    $04
           FCB    $B4
           FCB    $B3
           FCB    $43
           FCB    $02
           FCB    $89
           FCB    $BE
           FCB    $BD
           FCB    $C3
           FCB    $B4
           FCB    $89
           FCB    $C1
           FCB    $00
           FCB    $06
           FCB    $87
           FCB    $BB
           FCB    $FF

           EMOD
eom        EQU    *
           END
