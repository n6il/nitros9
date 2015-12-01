               IFNE      MC09.D-1
MC09.D         SET       1

********************************************************************
* mc09.d - NitrOS-9 System Definitions for the Multicomp09
*
* When the primary boot loader passes control to the "track34" code
* the system memory map looks like this:
*
*     $0000----> ==================================
*               |                                  |
*               |                                  |
*               |              RAM                 |
*               |                                  |
*               |                                  |
*     $FFD0---->|==================================|
*               |              I/O                 |
*     $FFE0---->|==================================|
*               |              RAM                 |
*               |==================================|
*     $FFFF---->
*
* The exception vectors at $FFF2 and onwards are initialised to vector to RAM
* as per coco1, just as krn expects. Specifically:
*
* $FFF2 holds vector to $0100 for SWI3
* $FFF4 holds vector to $0103 for SWI2
* $FFF6 holds vector to $010F for FIRQ
* $FFF8 holds vector to $010C for IRQ
* $FFFA holds vector to $0106 for SWI
* $FFFC holds vector to $0109 for NMI
*
* The 16-location I/O space and the interrupt hook-up are described below.
*
* $Id$
*
* Edt/Rev  YYYY/MM/DD  Modified by
* Comment
* ------------------------------------------------------------------
* 0.1      2015/10/17  Neal Crook. Tidy-up for first commit.
*
               NAM       Multicomp09Defs
               IFEQ      Level-1
               TTL       NitrOS-9 System Definitions for the Multicomp09
               ELSE
               IFEQ      Level-2
               TTL       NitrOS-9 Level 2 System Type Definitions
               ELSE
               IFEQ      Level-3
               TTL       NitrOS-9 Level 3 System Type Definitions
               ENDC
               ENDC
               ENDC


**********************
* CPU Type Definitions
*
Color          SET       1
Color3         SET       2
               IFEQ      Level-1
CPUType        SET       Color
               ELSE
CPUType        SET       Color3
               ENDC


******************************
* Clock Speed Type Definitions
*
OneMHz         EQU       1
TwoMHz         EQU       2
               IFEQ      CPUType-Color
CPUSpeed       SET       OneMHz
               ELSE
CPUSpeed       SET       TwoMHz
               ENDC


**********************************
* Power Line Frequency Definitions
* Multicomp09 has no dependency on power line frequency but setting
* it to Hz50 is the simplest way to make TkPerSec 50, which is important
* [NAC HACK 2015Aug31] actually no need to change it - gets applied at
* command line in modules/makefile to generate a 50Hz and 60Hz version.
*
Hz50           EQU       50                  Assemble clock for 50 hz power
Hz60           EQU       60                  Assemble clock for 60 hz power
               IFNDEF    PwrLnFrq
PwrLnFrq       SET       Hz50                Set to Appropriate freq
               ENDC


**********************************
* Ticks per second
*
               IFNDEF    TkPerSec
               IFEQ      PwrLnFrq-Hz50
TkPerSec       SET       50
               ELSE
TkPerSec       SET       60
               ENDC
               ENDC


******************
* ACIA type set up
*
* [NAC HACK 2015Sep06] is this used anywhere?
               ORG       1
ACIA6850       RMB       1                   MC6850 acia.
ACIA6551       RMB       1                   SY6551 acia.
ACIA2661       RMB       1                   SC2661 acia.
ACIATYPE       SET       ACIA6551


****************************************
* Special character Bit position equates
*
SHIFTBIT       EQU       %00000001
CNTRLBIT       EQU       %00000010
ALTERBIT       EQU       %00000100
UPBIT          EQU       %00001000
DOWNBIT        EQU       %00010000
LEFTBIT        EQU       %00100000
RIGHTBIT       EQU       %01000000
SPACEBIT       EQU       %10000000


********************************************************************
* Multicomp09 Interrupts:
*
* NMI - wired to single-step logic
* FIRQ - (currently) unused
* IRQ - wired to timer interrupt, VDU/KBD virtual ACIA and serial
*       ports 1 and 2.

********************************************************************
* Multicomp09 I/O space is $FFD0-$FFDF (16 locations). The equates
* below describe the I/O registers.

********************************************************************
* VDU/KBD (VIRTUAL ACIA)
VDUSTA         EQU $FFD0
VDUDAT         EQU $FFD1

* SERIAL PORT 1
UARTSTA1       EQU $FFD2
UARTDAT1       EQU $FFD3

* SERIAL PORT 2
UARTSTA2       EQU $FFD4
UARTDAT2       EQU $FFD5

********************************************************************
* GPIO device
* SEE VHDL HEADER FOR PROG GUIDE
GPIOADR        EQU $FFD6
GPIODAT        EQU $FFD7

* values supported by GPIOADR register
GPDAT0         EQU 0
GPDDR1         EQU 1
GPDAT2         EQU 2
GPDDR3         EQU 3


********************************************************************
* SDCARD CONTROL REGISTERS
* SEE VHDL HEADER FOR PROG GUIDE
SDDATA         EQU $FFD8
SDCTL          EQU $FFD9
SDLBA0         EQU $FFDA
SDLBA1         EQU $FFDB
SDLBA2         EQU $FFDC

********************************************************************
* 50Hz TIMER INTERRUPT
* TIMER (READ/WRITE)
*
* AT RESET, THE TIMER IS DISABLED AND THE INTERRUPT IS DEASSERTED. TIMER READS AS 0.
* BIT[1] IS READ/WRITE, TIMER ENABLE.
* BIT[7] IS READ/WRITE-1-TO-CLEAR, INTERRUPT.
*
* IN AN ISR THE TIMER CAN BE SERVICED BY PERFORMING AN INC ON ITS ADDRESS
*
* READ  WRITE  COMMENT
*  N/A   $02   ENABLE TIMER
*  $00   $01   TIMER WAS/REMAINS DISABLED. N=0.
*  $02   $03   TIMER WAS/REMAINS ENABLED, NO INTERRUPT. N=0.
*  $80   $81   TIMER WAS/REMAINS DISABLED, OLD PENDING INTERRUPT CLEARED. N=1.
*  $82   $83   TIMER WAS/REMAINS DISABLED, OLD PENDING INTERRUPT CLEARED. N=1.
*
TIMER          EQU $FFDD

********************************************************************
* MEM_MAPPER2 CONTROL REGISTERS
* MMUADR (WRITE-ONLY)
* 7   - ROMDIS (RESET TO 0)
* 6   - TR
* 5   - MMUEN
* 4   - RESERVED
* 3:0 - MAPSEL
* MMUDAT (WRITE-ONLY)
* 7   - WRPROT
* 6:0 - PHYSICAL BLOCK FOR CURRENT MAPSEL

MMUADR         EQU $FFDE
MMUDAT         EQU $FFDF



********************************************************************
********************************************************************
* Coco stuff that's needed to allow other files to compile
* [NAC HACK 2015Oct17] need to get rid of this eventually.

A.AciaP        SET       $FF68               Aciapak Address
A.ModP         SET       $FF6C               ModPak Address
DPort          SET       $FF40               Disk controller base address
MPI.Slct       SET       $FF7F               Multi-Pak slot select
MPI.Slot       SET       $03                 Multi-Pak default slot
PIA0Base       EQU       $FF00
PIA1Base       EQU       $FF20


******************
* VDG Devices
*
A.TermV        SET       $FFC0               VDG Term
A.V1           SET       $FFC1               Possible additional VDG Devices
A.V2           SET       $FFC2
A.V3           SET       $FFC3
A.V4           SET       $FFC4
A.V5           SET       $FFC5
A.V6           SET       $FFC6
A.V7           SET       $FFC7


               IFEQ      Level-1

*************************************************
*
* NitrOS-9 Level 1 Section
*
*************************************************

HW.Page        SET       $FF                 Device descriptor hardware page

               ELSE

*************************************************
*
* NitrOS-9 Level 2 Section
*
*************************************************

****************************************
* Dynamic Address Translator Definitions
*
DAT.BlCt       EQU       8                   D.A.T. blocks/address space
DAT.BlSz       EQU       (256/DAT.BlCt)*256  D.A.T. block size
DAT.ImSz       EQU       DAT.BlCt*2          D.A.T. Image size
DAT.Addr       EQU       -(DAT.BlSz/256)     D.A.T. MSB Address bits
DAT.Task       EQU       $FF91               Task Register address
DAT.TkCt       EQU       32                  Number of DAT Tasks
DAT.Regs       EQU       $FFA0               DAT Block Registers base address
DAT.Free       EQU       $333E               Free Block Number
DAT.BlMx       EQU       $3F                 Maximum Block number
DAT.BMSz       EQU       $40                 Memory Block Map size
DAT.WrPr       EQU       0                   no write protect
DAT.WrEn       EQU       0                   no write enable
SysTask        EQU       0                   Coco System Task number
IOBlock        EQU       $3F
ROMBlock       EQU       $3F
IOAddr         EQU       $7F
ROMCount       EQU       1                   number of blocks of ROM (High RAM Block)
RAMCount       EQU       1                   initial blocks of RAM
MoveBlks       EQU       DAT.BlCt-ROMCount-2 Block numbers used for copies
BlockTyp       EQU       1                   chk only first bytes of RAM block
ByteType       EQU       2                   chk entire block of RAM
Limited        EQU       1                   chk only upper memory for ROM modules
UnLimitd       EQU       2                   chk all NotRAM for modules
* NOTE: this check assumes any NotRAM with a module will
*       always start with $87CD in first two bytes of block
RAMCheck       EQU       BlockTyp            chk only beg bytes of block
ROMCheck       EQU       Limited             chk only upper few blocks for ROM
LastRAM        EQU       IOBlock             maximum RAM block number

***************************
* Color Computer 3 Specific
*
MappedIO       EQU       true                (Actually False but it works better this way)

********************
* Hardware addresses
*
GIMERegs       EQU       $FF00               Base address of GIME registers
IrqEnR         EQU       $FF92               GIME IRQ enable/status register
BordReg        EQU       $FF9A               Border color register
PalAdr         EQU       $FFB0               Palette registers

HW.Page        SET       $07                 Device descriptor hardware page

               ENDC

               ENDC
