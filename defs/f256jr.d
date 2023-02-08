               IFNE      F256JR.D-1
F256JR.D       SET       1

********************************************************************
* F256JRDefs - NitrOS-9 System Definitions for the Foenix F256 Jr.
*
* This is a high level view of the F256 Jr. memory map as setup by
* NitrOS-9.
*
*     $0000----> ================================== 
*               |     F256 Jr. MMU Registers       |
*     $0010----> ================================== 
*               |                                  |
*               |      NitrOS-9 Globals/Stack      |
*               |                                  |
*     $0500---->|==================================|
*               |                                  |
*                 . . . . . . . . . . . . . . . . .
*               |                                  |
*               |   RAM available for allocation   |
*               |       by NitrOS-9 and Apps       |
*               |                                  |
*                 . . . . . . . . . . . . . . . . .
*               |                                  |
*     $C000---->|==================================|
*               |                                  |
*  $C000-$DFFF  |          RAM, but also           |
*               |    I/O for text and color data   |
*               |                                  |
*     $E000---->|==================================|
*               |                                  |
*  $E000-$FFFF  |               RAM                |
*               |                                  |
*                ================================== 
*
* F256 Jr. hardware is documented here:
*   https://github.com/pweingar/C256jrManual/blob/main/tex/f256jr_ref.pdf
*
* $Id$
*
* Edt/Rev  YYYY/MM/DD  Modified by
* Comment
* ------------------------------------------------------------------
*          2023/02/07  Boisy G. Pitre
* Started

               NAM       F256JrDefs
               TTL       NitrOS-9 System Definitions for the Foenix F256 Jr.



********************************************************************
* Power Line Frequency Definitions
*
Hz50           EQU       1                   Assemble clock for 50 hz power
Hz60           EQU       2                   Assemble clock for 60 hz power
               IFNDEF    PwrLnFrq
PwrLnFrq       SET       Hz60                Set to Appropriate freq
               ENDC


********************************************************************
* Ticks per second
*
               IFNDEF    TkPerSec
               IFEQ      PwrLnFrq-Hz50
TkPerSec       SET       50
               ELSE      
TkPerSec       SET       60
               ENDC      
               ENDC


********************************************************************
*
* NitrOS-9 Level 1 Section
*
********************************************************************

********************************************************************
* Boot definitions for NitrOS-9 Level 1
*
* These definitions are not strictly for 'Boot', but are for booting the
* system.
*
Bt.Start       SET       $8000
Bt.Size        EQU       $1080               Maximum size of bootfile
Bt.Track       EQU       $0000
Bt.Sec         EQU       0
HW.Page        SET       $FF                 Device descriptor hardware page


********************************************************************
* NitrOS-9 Screen Definitions for the F256 Jr.
*
G.Cols         EQU       80
G.Rows         EQU       PwrLnFrq

* The screen start address is relative to the I/O area starting at $C000
G.ScrStart     EQU       $0000
G.ScrEnd       EQU       G.ScrStart+(G.Cols*G.Rows)

********************************************************************
* F256 Jr. MMU Definitions
*
MMU_MEM_CTRL   EQU       $0000
MMU_IO_CTRL    EQU       $0001

* MMU_MEM_CTRL bits
EDIT_EN        EQU       %10000000
EDIT_LUT       EQU       %00110000
ACT_LUT        EQU       %00000011

* MMU_IO_CTRL bits
IO_DISABLE     EQU       %00000010
IO_PAGE        EQU       %00000001

********************************************************************
* F256 Jr. Interrupt Definitions
*
* Interrupt Addresses
INT_PENDING_0  EQU       0xD660
INT_POLARITY_0 EQU       0xD664
INT_EDGE_0     EQU       0xD668
INT_MASK_0     EQU       0xD66C

INT_PENDING_1  EQU       0xD661
INT_POLARITY_1 EQU       0xD665
INT_EDGE_1     EQU       0xD669
INT_MASK_1     EQU       0xD66D

INT_PENDING_2  EQU       0xD662
INT_POLARITY_2 EQU       0xD666
INT_EDGE_2     EQU       0xD66A
INT_MASK_2     EQU       0xD66E

* Interrupt Group 0 Flags
INT_VKY_SOF    EQU       %00000001		TinyVicky Start Of Frame Interrupt
INT_VKY_SOL    EQU       %00000010      TinyVicky Start Of Line Interrupt
INT_PS2_KBD    EQU       %00000100      PS/2 keyboard event
INT_PS2_MOUSE  EQU       %00001000      PS/2 mouse event
INT_TIMER_0    EQU       %00010000      TIMER0 has reached its target value
INT_TIMER_1    EQU       %00010000      TIMER1 has reached its target value
INT_CARTRIDGE  EQU       %10000000      Interrupt asserted by the cartridge

* Interrupt Group 1 Flags
INT_UART       EQU       %00000001		The UART is ready to receive or send data
INT_RTC        EQU       %00010000      Event from the real time clock chip
INT_VIA0       EQU       %00100000      Event from the 65C22 VIA chip
INT_VIA1       EQU       %01000000      F256K Only: Local keyboard
INT_SDC_INS    EQU       %01000000      User has inserted an SD card

* Interrupt Group 2 Flags
IEC_DATA_i     EQU       %00000001		IEC Data In
IEC_CLK_i      EQU       %00000010		IEC Clock In
IEC_ATN_i      EQU       %00000100		IEC ATN In
IEC_SREQ_i     EQU       %00001000		IEC SREQ In

********************************************************************
* F256 Jr. Timer Definitions
*
* Timer Addresses
T0_CTR         EQU       $D650          Timer 0 Counter (Write)
T0_STAT        EQU       $D650          Timer 0 Status (Read)
T0_VAL         EQU       $D651          Timer 0 Value (Read/Write)
T0_CMP_CTR     EQU       $D654          Timer 0 Compare Counter (Read/Write)
T0_CMP         EQU       $D655          Timer 0 Compare Value (Read/Write)
T1_CTR         EQU       $D658          Timer 1 Counter (Write)
T1_STAT        EQU       $D658          Timer 1 Status (Read)
T1_VAL         EQU       $D659          Timer 1 Value (Read/Write)
T1_CMP_CTR     EQU       $D65C          Timer 1 Compare Counter (Read/Write)
T1_CMP         EQU       $D65D          Timer 1 Compare Value (Read/Write)

********************************************************************
* F256 Jr. VIA Definitions
*
* VIA Addresses
IORB           EQU       $DC00          Port B Data
IORA           EQU       $DC01          Port A Data
DDRB           EQU       $DC02          Port B Data Direction Register
DDRA           EQU       $DC03          Port A Data Direction Register
T1C_L          EQU       $DC04          Timer 1 Counter Low
T1C_H          EQU       $DC05          Timer 1 Counter High
T1L_L          EQU       $DC06          Timer 1 Latch Low
T1L_H          EQU       $DC07          Timer 1 Latch High
T2C_L          EQU       $DC08          Timer 2 Counter Low
T2C_H          EQU       $DC09          Timer 2 Counter High
SDR            EQU       $DC0A          Serial Data Register
ACR            EQU       $DC0B          Auxiliary Control Register
PCR            EQU       $DC0C          Peripheral Control Register
IFR            EQU       $DC0D          Interrupt Flag Register
IER            EQU       $DC0E          Interrupt Enable Register
IORA2          EQU       $DC0F          Port A Data (no handshake)

* ACR Control Register Values
T1_CTRL        EQU       %11000000
T2_CTRL        EQU       %00100000
SR_CTRL        EQU       %00011100
PBL_EN         EQU       %00000010
PAL_EN         EQU       %00000001

* PCR Control Register Values
CB2_CTRL       EQU       %11100000
CB1_CTRL       EQU       %00010000
CA2_CTRL       EQU       %00001110
CA1_CTRL       EQU       %00000001

* IFR Control Register Values
IRQF           EQU       %10000000
T1F            EQU       %01000000
T2F            EQU       %00100000
CB1F           EQU       %00010000
CB2F           EQU       %00001000
SRF            EQU       %00000100
CA1F           EQU       %00000010
CA2F           EQU       %00000001

* IER Control Register Values
IERSET         EQU       %10000000
T1E            EQU       %01000000
T2E            EQU       %00100000
CB1E           EQU       %00010000
CB2E           EQU       %00001000
SRE            EQU       %00000100
CA1E           EQU       %00000010
CA2E           EQU       %00000001

********************************************************************
* F256 Jr. SD Card Interface Definitions
*
SDC_STAT       EQU       $DD00
SDC_DATA       EQU       $DD01

SPI_BUSY       EQU       %10000000
SPI_CLK        EQU       %00000010
CS_EN          EQU       %00000001

               ENDC      
