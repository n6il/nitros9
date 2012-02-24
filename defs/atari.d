          IFNE      ATARI.D-1
ATARI.D   SET       1

********************************************************************
* AtariDefs - NitrOS-9 System Definitions for the Atari XE/XL
*
* $Id$
*
* Edt/Rev  YYYY/MM/DD  Modified by
* Comment
* ------------------------------------------------------------------
*          2012/02/23  Boisy G. Pitre
* Started

               NAM       AtariDefs
               TTL       NitrOS-9 System Definitions for the Atari XE/XL



**********************************
* Power Line Frequency Definitions
*
Hz50           EQU       1                   Assemble clock for 50 hz power
Hz60           EQU       2                   Assemble clock for 60 hz power
PwrLnFrq       SET       Hz60                Set to Appropriate freq


**********************************
* Ticks per second
*
               IFEQ      PwrLnFrq-Hz50
TkPerSec       SET       50
               ELSE      
TkPerSec       SET       60
               ENDC      


*************************************************
*
* NitrOS-9 Level 1 Section
*
*************************************************

HW.Page        SET       $FF                 Device descriptor hardware page


********************************************************************
* NitrOS-9 Memory Definitions for the Atari XE/XL
*
* The Atari's support chips have certain alignment restrictions for
* things like screen memory, display lists and character maps.  For this
* reason, we reserve some low memory for the screen.
*
* Screen memory range is $0500-$08FF (1K).  Of that, 40*24 (960) bytes
* are for the screen buffer and the remaining 64 bytes are for the
* ANTIC's Display List
G.Cols         EQU       40
G.Rows         EQU       24
G.ScrStart     EQU       $0500
G.DList        EQU       G.ScrStart+(G.Cols*G.Rows)
G.DListSize    EQU       64

* The Character Set must be aligned to a 4K address.  We can really only
* guarnatee that in the Krn module, which is always at the end of RAM.  So
* for now, the character set is located at $F800
G.CharSetAddr  EQU       $F800

* POKEY requires shadow registers.  We allocate them in the kernel's DP
* (Yes, we are stealing an existing variable that is so old it should be
*  removed from os9defs)
D.IRQENShdw    EQU       D.WDBtDr


********************************************************************
* Atari XE/XL Hardware Definitions
*
* These were lifted from the Atari OS disassembly, and represents all
* of the hardware registers available on the Atari XE/XL
*
**	CTIA/GTIA Address Equates
CTIA	EQU	$D000	;CTIA/GTIA area

*	Read/Write Addresses
CONSOL	EQU	$D01F	;console switches and speaker control

*	Read Addresses
M0PF	EQU	$D000	;missle 0 and playfield collision
M1PF	EQU	$D001	;missle 1 and playfield collision
M2PF	EQU	$D002	;missle 2 and playfield collision
M3PF	EQU	$D003	;missle 3 and playfield collision

P0PF	EQU	$D004	;player 0 and playfield collision
P1PF	EQU	$D005	;player 1 and playfield collision
P2PF	EQU	$D006	;player 2 and playfield collision
P3PF	EQU	$D007	;player 3 and playfield collision

M0PL	EQU	$D008	;missle 0 and player collision
M1PL	EQU	$D009	;missle 1 and player collision
M2PL	EQU	$D00A	;missle 2 and player collision
M3PL	EQU	$D00B	;missle 3 and player collision

P0PL	EQU	$D00C	;player 0 and player collision
P1PL	EQU	$D00D	;player 1 and player collision
P2PL	EQU	$D00E	;player 2 and player collision
P3PL	EQU	$D00F	;player 3 and player collision

TRIG0	EQU	$D010	;joystick trigger 0
TRIG1	EQU	$D011	;joystick trigger 1

TRIG2	EQU	$D012	;cartridge interlock
TRIG3	EQU	$D013	;ACMI module interlock

PAL	EQU	$D014	;PAL/NTSC indicator

*	Write Addresses
HPOSP0	EQU	$D000	;player 0 horizontal position
HPOSP1	EQU	$D001	;player 1 horizontal position
HPOSP2	EQU	$D002	;player 2 horizontal position
HPOSP3	EQU	$D003	;player 3 horizontal position

HPOSM0	EQU	$D004	;missle 0 horizontal position
HPOSM1	EQU	$D005	;missle 1 horizontal position
HPOSM2	EQU	$D006	;missle 2 horizontal position
HPOSM3	EQU	$D007	;missle 3 horizontal position

SIZEP0	EQU	$D008	;player 0 size
SIZEP1	EQU	$D009	;player 1 size
SIZEP2	EQU	$D00A	;player 2 size
SIZEP3	EQU	$D00B	;player 3 size

SIZEM	EQU	$D00C	;missle sizes

GRAFP0	EQU	$D00D	;player 0 graphics
GRAFP1	EQU	$D00E	;player 1 graphics
GRAFP2	EQU	$D00F	;player 2 graphics
GRAFP3	EQU	$D010	;player 3 graphics

GRAFM	EQU	$D011	;missle graphics

COLPM0	EQU	$D012	;player-missle 0 color/luminance
COLPM1	EQU	$D013	;player-missle 1 color/luminance
COLPM2	EQU	$D014	;player-missle 2 color/luminance
COLPM3	EQU	$D015	;player-missle 3 color/luminance

COLPF0	EQU	$D016	;playfield 0 color/luminance
COLPF1	EQU	$D017	;playfield 1 color/luminance
COLPF2	EQU	$D018	;playfield 2 color/luminance
COLPF3	EQU	$D019	;playfield 3 color/luminance

COLBK	EQU	$D01A	;background color/luminance

PRIOR	EQU	$D01B	;priority select
VDELAY	EQU	$D01C	;vertical delay
GRACTL	EQU	$D01D	;graphic control
HITCLR	EQU	$D01E	;collision clear


**	POKEY Address Equates
POKEY	EQU	$D200	;POKEY area

*	Read Addresses
POT0	EQU	$D200	;potentiometer 0
POT1	EQU	$D201	;potentiometer 1
POT2	EQU	$D202	;potentiometer 2
POT3	EQU	$D203	;potentiometer 3
POT4	EQU	$D204	;potentiometer 4
POT5	EQU	$D205	;potentiometer 5
POT6	EQU	$D206	;potentiometer 6
POT7	EQU	$D207	;potentiometer 7

ALLPOT	EQU	$D208	;potentiometer port state
KBCODE	EQU	$D209	;keyboard code
RANDOM	EQU	$D20A	;random number generator
SERIN	EQU	$D20D	;serial port input
IRQST	EQU	$D20E	;IRQ interrupt status
SKSTAT	EQU	$D20F	;serial port and keyboard status

*	Write Addresses
AUDF1	EQU	$D200	;channel 1 audio frequency
AUDC1	EQU	$D201	;channel 1 audio control

AUDF2	EQU	$D202	;channel 2 audio frequency
AUDC2	EQU	$D203	;channel 2 audio control

AUDF3	EQU	$D204	;channel 3 audio frequency
AUDC3	EQU	$D205	;channel 3 audio control

AUDF4	EQU	$D206	;channel 4 audio frequency
AUDC4	EQU	$D207	;channel 4 audio control

AUDCTL	EQU	$D208	;audio control
STIMER	EQU	$D209	;start timers
SKRES	EQU	$D20A	;reset SKSTAT status
POTGO	EQU	$D20B	;start potentiometer scan sequence
SEROUT	EQU	$D20D	;serial port output
IRQEN	EQU	$D20E	;IRQ interrupt enable
SKCTL	EQU	$D20F	;serial port and keyboard control


**	PIA Address Equates
PIA	EQU	$D300	;PIA area

*	Read/Write Addresses
PORTA	EQU	$D300	;port A direction register or jacks 0 and 1
PORTB	EQU	$D301	;port B direction register or memory control

PACTL	EQU	$D302	;port A control
PBCTL	EQU	$D303	;port B control


**	ANTIC Address Equates
ANTIC	EQU	$D400	;ANTIC area

*	Read Addresses
VCOUNT	EQU	$D40B	;vertical line counter
PENH	EQU	$D40C	;light pen horizontal position
PENV	EQU	$D40D	;light pen vertical position
NMIST	EQU	$D40F	;NMI interrupt status

*	Write Addresses
DMACTL	EQU	$D400	;DMA control
CHACTL	EQU	$D401	;character control
DLISTL	EQU	$D402	;low display list address
DLISTH	EQU	$D403	;high disply list address
HSCROL	EQU	$D404	;horizontal scroll
VSCROL	EQU	$D405	;vertical scroll
PMBASE	EQU	$D407	;player-missle base address
CHBASE	EQU	$D409	;character base address
WSYNC	EQU	$D40A	;wait for HBLANK synchronization
NMIEN	EQU	$D40E	;NMI enable
NMIRES	EQU	$D40F	;NMI interrupt status reset


          ENDC
