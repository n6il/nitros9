********************************************************************
* DW3DOS - DriveWire 3 DOS Command
*
* $Id$
*
* DW3DOS emulates the RS-DOS 'DOS' command, which obtains 18 256-byte
* sectors from track 34 of a disk and reads them into memory starting
* at $2600.  Once all sectors have been read, control jumps to $2602.
*
* The flexibility that is inherent in the DriveWire design is that it
* allows a CoCo to boot into OS-9 or any other control program that might
* be desirable.
*
* Four ROMS can be made from this source:
*
*   - CoCo 3 motherboard ROM (32K)
*   - CoCo 1/2 motherboard ROM (16K)
*   - CoCo 3 Disk Controller ROM (8K) (define DISKROM)
*   - CoCo 1/2 Disk Controller ROM (8K) (define DISKROM)
*
* Two LOADM files can be made also:
*
*   - CoCo 3 LOADMable BIN (define BIN)
*   - CoCo 1/2 LOADMable BIN (define BIN)
*
* Also, two files can be made from this source:
*
*   - CoCo 3 DOS track (4608 bytes) (define DOSTRACK)
*   - CoCo 1/2 DOS track (4608 bytes) (define DOSTRACK)
*
* Edt/Rev  YYYY/MM/DD  Modified by
* Comment
* ------------------------------------------------------------------
*          2008/02/04  Boisy G. Pitre
* Adapted for DriveWire 3 protocol

         nam   DW3DOS
         ttl   DriveWire 3 DOS Command

         ifp1  
         IFNE  BIN
IntMasks equ   $50
Carry    equ   1
PIA0Base equ   $FF00
PIA1Base equ   $FF20
DAT.Regs equ   $FFA0
E$NotRdy equ   246
         ELSE
         use   defsfile
         ENDC
         use   ../defs/dwdefs.d
         endc  

* Set up Level definition for low level read/write routines
         IFEQ  CoCo-3
Level    equ   2
         ELSE
Level    equ   1
         ENDC

         IFNE  DOSTRACK
Top      equ   $2600
         ELSE
         IFNE  BIN
Top      equ   $2400
         ELSE
         IFNE  DISKROM
Top      equ   $C000
         ELSE
Top      equ   $8000
         ENDC
         ENDC
         ENDC
 
         org   Top
         IFNE  DISKROM
         fcc   "DK"
         lbra  Entry
         fill  $FF,9*256	spaced out to prevent CoCo 3 BASIC ROM patches
         ELSE
         fcc   /OS/
         bra   PreEntry
         fdb   $1205
* For the DOS track, we have to copy the DW3DOS code to another
* address and execute from there, since the boot track we pull
* from DriveWire will need to reside at $2600 (and we are now!)
PreEntry
         leax  Entry,pcr
         ldy   #$2000
         ldd   #csize
PreCopy  ldu   ,x++
         stu   ,y++
         subd  #$0002
         bpl   PreCopy
         jmp   $2000
         ENDC

* Entry point
Entry    orcc  #IntMasks	disable FIRQ, IRQ
         lds   #$1FFF		set up a stack pointer

         IFEQ  CoCo-3

* CoCo 3 Initialization Code
         clr   $FFD9      go into fast mode

* Setup MMU
         ldx   #DAT.Regs
         leay  MMUTbl,pcr
         ldb   #16
MMULoop  lda   ,y+
         sta   ,x+
         decb  
         bne   MMULoop

* Setup video
         leau  CC3Regs,pcr	point to video setup data
         ldx   #$FF90
Loop1    ldd   ,u++		get the bytes
         std   ,x++		save in the hardware
         cmpx  #$FFA0
         bcs   Loop1

* Set palettes up
         leau  PalTbl,pcr
         ldy   #$FFB0		palette register
         ldb   #16
         lbsr  CopyRtn

* Initialize PIAs
         ldx   #PIA1Base  RG - Initialize the PIA 1
         ldd   #$FF34
         clr   1,x	cassette motor off, 0,x is DDR
         clr   3,x	2,x is DDR
         deca  		A = $FE
         sta   ,x	cassette bit 0 input, all others output
         lda   #$F8	bits 7-3 output, bits 2-0 input
         sta   2,x	set DDR
         stb   1,x	0,x not DDR
         stb   3,x	2,x not DDR
         clr   2,x
         lda   #$02	RS-232 bit hi
         sta   ,x	set it

         lda   #$FF	all outputs
         ldx   #PIA0Base
         clr   1,x	0,x is DDR
         clr   3,x	2,x is DDR
         clr   ,x	all inputs
         sta   2,x	all outputs
         stb   1,x	0,x is not DDR
         stb   3,x	2,x is not DDR
         clr   2,x

         ELSE

* CoCo 1/2 Initialization Code
         ldx   #PIA1Base               PIA1
         clr   -3,x                    clear PIA0 Control Register A
         clr   -1,x                    clear PIA0 Control Register B
         clr   -4,x                    set PIA0 side A to input
         ldd   #$FF34
         sta   -2,x                    set PIA0 side B to output
         stb   -3,x                    enable PIA0 peripheral reg, disable PIA0
         stb   -1,x                    MPU interrupts, set CA2, CA1 to outputs
         clr   1,x                     $FF20 = DDR, motoroff
         clr   3,x                     $FF22 = DDR, sound disabled
         deca                          A = $FE after deca
         sta   ,x                      bits 1-7 are outputs, bit 0 is input on PIA1 side A
         lda   #$F8
         sta   2,x                     bits 0-2 are inputs, bits 3-7 are outputs on B side
         stb   1,x                     enable peripheral registers, disable PIA1 MPU
         stb   3,x                     interrupts and set CA2, CB2 as outputs
         clr   2,x                     set 6847 mode to alphanumeric
         ldb   #$02
         stb   ,x                      make RS-232 output marking
         clrb
         tfr   b,dp                    B = 0
         ldb   #$04
         clr   -2,x
         bitb  2,x

         lda   #$37
         sta   PIA1Base+3

         lda   PIA0Base+3
         ora   #$01
         sta   PIA0Base+3

         lda   PIA1Base+2
         anda  #$07
         sta   PIA1Base+2

* 64K DRAM (M0=0, M1=1)
         sta   $FFDA                   RESET M0
         sta   $FFDD                   SET   M1

         ENDC

* Show Boot Message
* VDG Mode
         sta   $FFC0
         sta   $FFC2
         sta   $FFC4

* Locate Boot Text Screen at $0000
         ldx   #$FFC6
         ldb   #$07
ScrLoop  sta   ,x++
         decb
         bne   ScrLoop

* Clear VDG screen
         ldx   #$0000
         ldy   #256
         ldd   #$6060
VDGClr   std   ,x++
         leay  -1,y
         bne   VDGClr

* Copy Booot Message to screen area
         ldy   #$10A
         leau  BootMsg,pcr
         ldb   #BootMLen
         bsr   CopyRtn

* Spin for a while so that the RS-232 bit stays hi for a time
Reset
         ldx   #$A000
Spin     leax  -1,x
         bne    Spin

Counter  equ   $1FFF
         lds   #$1FFE		reset stack pointer

* DriveWire bootstrap code
* Get sectors 612-629 to $2600
DWDOS2   ldx   #612		starting sector number
         ldy   #$2600		memory address
DOSLoop  bsr   DoRead		read sector (into Y)
         bcs   Failed		start all over
         cmpx  #612		our first sector?
         bne   DWDOS3		branch if not
         ldd   $2600		else get two bytes at $2600
         cmpd  #$4F53		OS?
         bne   Failed		if not, bad data... fail
DWDOS3   leax  1,x		else increment X
         leay  256,y
         cmpx  #630		are we at end of 18 sectors?
         blt   DOSLoop		branch if not
         
         jmp   $2602

CopyRtn  clra
         tfr   d,x
Copy1    ldb   ,u+
         stb   ,y+
         leax  -1,x
         bne   Copy1
         rts

* Copy "FAILED" to screen area
Failed   ldy   #$14D
         leau  FailMsg,pcr
         ldb   #FailMLen
         bsr   CopyRtn
Hang     bra   Hang



DoRead   clra			drive #
         clrb			LSN bits 23-16
         pshs  d,x,y
         lda   #OP_READEX
ReRead   pshs  a
         leax  ,s
		 ldy   #$0005
		 lbsr  DWWrite
		 puls  a

		 ldx   4,s			get read buffer pointer
		 ldy   #256			read 256 bytes
		 ldd   #133*1		1 second timeout
		 bsr   DWRead
         bcs   ReadEx
         bne   ReadEx
* Send 2 byte checksum
		 pshs  y
		 leax  ,s
		 ldy   #2
		 lbsr  DWWrite
		 ldy   #1
		 ldd   #133*1
		 bsr   DWRead
		 leas  2,s
		 bcs   ReadEx
                 bne   ReadEx
* Send 2 byte checksum
		 lda   ,s
		 beq   ReadEx
		 cmpa  #E_CRC
		 bne   ReadErr
		 lda   #OP_REREADEX
		 clr   ,s
		 bra   ReRead  
ReadErr  comb
ReadEx	 puls  d,x,y,pc

         IFEQ  DW4-1
         use   ../level1/modules/dw4read.asm 
         use   ../level1/modules/dw4write.asm 
         ELSE
         use   ../level1/modules/dwread.asm 
         use   ../level1/modules/dwwrite.asm 
         ENDC

         IFEQ  CoCo-3
* MMU
MMUTbl         
         fcb   $38,$39,$3A,$3B,$3C,$3D,$3E,$3F
         fcb   $38,$39,$3A,$3B,$3C,$3D,$3E,$3F

* GIME register default values

CC3Regs  fcb   $EC        CC2, MMU, IRQ, Vector page, SCS
         fcb   $00        map type 0
         fcb   $00        no FIRQ
         fcb   $00        no IRQ
         fdb   $0900      timer
         fcb   $00        unused
         fcb   $00        unused
         fcb   $00
         fcb   $00             
         fcb   $00
         fcb   $00             
         fdb   $0FE0
         fcb   $00
         fcb   $00

* Palette register default colors
PalTbl         
         fcb   $12	green
         fcb   $36
         fcb   $09	blue
         fcb   $24	red
         fcb   $3F	white
         fcb   $1B	cyan
         fcb   $2D	magenta
         fcb   $26
         fcb   $00	black
         fcb   $12	green
         fcb   $00	black
         fcb   $3F	white
         fcb   $00	black
         fcb   $12	green
         fcb   $00	black
         fcb   $26

         ENDC

* Boot Message
BootMsg  fcc    /DWs/
         fcb    $60
         fcc    /CC/
         fcb    112+CoCo
         fcb    $60
         fcc    /BOOT/
BootMLen equ    *-BootMsg

* Fail Message
FailMsg  fcc    /FAILED/
FailMLen equ    *-FailMsg

csize    equ   *-Entry
eom      equ   *

* Fill pattern
         IFEQ   BIN
         IFNE   DOSTRACK
         fill   $FF,$1200-eom
         ELSE
         IFNE   DISKROM
         fill   $FF,$1FF0-eom
         ELSE
         IFEQ   CoCo-3
         fill   $FF,$7FF0-eom
         ELSE
         fill   $FF,$3FF0-eom
         ENDC
         ENDC

         IFEQ   CoCo-3

* CoCo 3 ROM vectors
         fdb	$0000
         fdb	$FEEE
         fdb	$FEF1
         fdb	$FEF4
         fdb	$FEF7
         fdb	$FEFA
         fdb	$FEFD
         fdb	Entry+Top

         ELSE

* CoCo 1/2 ROM vectors
         fdb	Entry+Top
         fdb	$0100
         fdb	$0103
         fdb	$010F
         fdb	$010C
         fdb	$0106
         fdb	$0109
         fdb	Entry+Top

         ENDC
         ENDC
         ENDC

         end   PreEntry

