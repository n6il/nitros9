               ifne      F256JR.D-1
F256JR.D       set       1

********************************************************************
* F256JRDefs - NitrOS-9 System Definitions for the Foenix F256 JR.
*
* This is a high level view of the F256 JR. memory map as setup by
* NitrOS-9.
*
*     $0000----> ================================== 
*               |     F256 JR. MMU Registers       |
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
* F256 JR. hardware is documented here:
*   https://github.com/pweingar/C256jrManual/blob/main/tex/f256jr_ref.pdf
*
* $Id$
*
* Edt/Rev  YYYY/MM/DD  Modified by
* Comment
* ------------------------------------------------------------------
*          2012/02/23  Boisy G. Pitre
* Started

               nam       F256JRDefs
               ttl       NitrOS-9 System Definitions for the Foenix F256 JR.



********************************************************************
* Power Line Frequency Definitions
*
Hz50           equ       1                   Assemble clock for 50 hz power
Hz60           equ       2                   Assemble clock for 60 hz power
               IFNDEF    PwrLnFrq
PwrLnFrq       set       Hz60                Set to Appropriate freq
               ENDC


********************************************************************
* Ticks per second
*
               IFNDEF    TkPerSec
               ifeq      PwrLnFrq-Hz50
TkPerSec       set       50
               else      
TkPerSec       set       60
               endc      
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
Bt.Start       set       $8000
Bt.Size        EQU       $1080               Maximum size of bootfile
Bt.Track       EQU       $0000
Bt.Sec         EQU       0
HW.Page        set       $FF                 Device descriptor hardware page


********************************************************************
* NitrOS-9 Memory Definitions for the F256 JR.
*
G.Cols         equ       80
               IF        Hz60-1
G.Rows         equ       60
               ELSE
G.Rows         equ       50
               ENDC
* The screen start address is relative to the I/O area starting at $C000
G.ScrStart     equ       $0000
G.ScrEnd       equ       G.ScrStart+(G.Cols*G.Rows)

********************************************************************
* F256 JR. MMU Definitions
*
MMU_MEM_CTRL   equ       $0000
MMU_IO_CTRL    equ       $0001

* MMU_MEM_CTRL bits
EDIT_EN		   equ       1<<7
EDIT_LUT	   equ       3<<4
ACT_LUT        equ       3<<0

* MMU_IO_CTRL bits
IO_DISABLE     equ       1<<1
IO_PAGE        equ       1<<0

               endc      
