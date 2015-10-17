********************************************************************
* REL - Relocation routine
*
* $Id$
*
* Edt/Rev  YYYY/MM/DD  Modified by
* Comment
* ------------------------------------------------------------------
*   5r5    2003/07/31  Boisy G. Pitre
* Back ported NitrOS-9 REL to OS-9 Level Two.
*
*          2004/11/09  P.Harvey-Smith
* Added code to flip Dragon Alpha into text mode on boot.
* 

         nam   REL
         ttl   Relocation routine

         IFP1
         use   defsfile
         ENDC

XX.Size  equ   6          number of bytes before REL actually starts
Offset   equ   Bt.Start+XX.Size
         IFEQ  Level-1
ScStart  equ   $8000      screen start in memory
         ELSE
ScStart  equ   $8008      screen start in memory
         ENDC

tylg     set   Systm+Objct   
atrv     set   ReEnt+rev
rev      set   $05
edition  set   5

********************************************************************
* Any changes to the next 3 lines requires changes in XX.Size, above
         fcc   /OS/       sync bytes
         bra   Start+XX.Size+*-2  execution start
         fdb   $1205      filler bytes

Begin    mod   eom,name,tylg,atrv,start,size

         org   0
size     equ   .          REL doesn't require any memory

name     fcs   /REL/
         fcb   edition

         IFGT  Level-1

*************************************************************************
* Level2/level3
*************************************************************************

L001F    fcb   $6C      MMU, IRQ, Vector page, SCS
         fcb   $00      map type 0
         fcb   $00      no FIRQ
         fcb   $00      no IRQ
         fdb   $0900    timer
         fcb   $00      unused
         fcb   $00      unused
         IFEQ  TkPerSec-50
         fcb   $0B	50Hz refresh, alphanumeric display, 8 lines/char row
         ELSE
         fcb   $03	60Hz refresh, alphanumeric display, 8 lines/char row
         ENDC

         IFEQ  Width-80
         fcb   $34 200 lines, 80 column mode, no attribute byte (monochrome)
         fcb   $3F        white border
BOOTLINE set   11	80-col start line for BOOT/FAIL messages
         ENDC

         IFEQ  Width-40
         fcb   $24 200 lines, 40-col, no attribute byte
         fcb   $3F        white border
BOOTLINE set   13	40-col start line for BOOT/FAIL messages
         ENDC

         IFEQ  Width-32
         fcb   $20 200 lines, 32-col, no attribute byte
         fcb   $00        black border
BOOTLINE set   13	32-col start line for BOOT/FAIL messages
         ENDC

         fcb   $00 display in lower 512k bank
         fcb   $00 vertical fine scroll set to 0
         fcb   Bt.Block*4  display block where-ever
         fcb   $01 offset 8 bytes
         fcb   $00 no horizontal scroll

crash    lda   #'*        signal a crash error
         jsr   <D.BtBug
         tfr   b,a        save error code
         jsr   <D.BtBug   and dump this out, too
         clrb
         fcb   $8C        skip 2 bytes

*************************************************************************
* Entry point for level2/3
*************************************************************************

reset    equ   *          later on, have reset different from start?
start    ldb   #$FF       negative - do complete boot
         clr   >$FFDF     added for OS-9 ROM Kit boots +BGP+

start1   orcc  #IntMasks  turn off IRQ's
         clr   >PIA0Base+3 turn off SAM IRQ's
         clra             make A=0 for later
         IFNE  H6309
         tfr   0,dp       set direct page to $0000
         ldmd  #3         native mode
         ELSE
         tfr   a,dp
         ENDC
         clr   <D.CBStrt  cold boot start: don't re-boot on reset
         clr   >$FFA0     map in block 0
         lds   #$1FFF     set stack to the end of the block
         stb   ,-s        save status of start, $00=cold, $01=warm
* This is done so I can tell what went on in the direct page if there's
* a crash. 0(crash) 1(reset) -1(startup)
         beq   Cont       --don't clear out direct page if it's a crash
* BGP 12/24/2009: clear out ALL of direct page (even $00-$1F)
*         ldb   #$20       start out at $20
         clrb
         tfr   d,x        here, too
L0072    sta   ,x+        clear out the direct page
         incb             Boot won't be using any of it!
         bne   L0072      BUT RAMMER/MD DOES!!!
         inc   <D.Speed   0+1=1; high speed
Cont     clrb             --make sure B=0
         stb   >$FFD9     set to high speed
         leay  <L001F,pcr point to the video setup data
         ldx   #$0090     set video mapping
         deca             now D=$FF00, versus STU >-$0100,x (saves 1 byte)
L0084    ldu   ,y++       get the bytes
         stu   d,x        save in the hardware
         stu   ,x++       and in the direct page
         cmpx  #$00A0     end of video hardware yet?
         bcs   L0084

         IFEQ  Width-32
         ldd   #$1200     color 0=$12, 1=$00 i.e. black on green
         ELSE
         ldd   #$3F00     color 0=$3F, 1=$00, i.e. black on white
         ENDC
         std   >$FFB0     set only the first two palettes, B=$00 already
         lda   #Bt.Block
         sta   >$FFA4     map in the block

         ldx   #$8000     start of the block
         IFNE  H6309
         ldq   #Bt.Flag*65536+8
         ELSE
         ldd   #Bt.Flag
         ENDC
         tst   ,s         check status : 0(crash) 1(reset) -1(startup)
         bmi   StoreQ     if NOT a crash or reset, start at the start...
         cmpd  ,x         are they the same?
         beq   MoveTxt    don't bother clearing the screen if it's there
StoreQ   
         IFNE  H6309
         stq   ,x         otherwise save the bytes on-screen
         ELSE
         std   ,x
         ldd   #8
         std   2,x
         ENDC

         leax  8,x        point to the start of the screen in memory
         IFNE  H6309
         ldw   #$2000-8   clear out the entire block of memory
         leau  <L00E0,pcr point to $20, a space
         tfm   u,x+       clear out the screen
         ELSE
         ldy   #$2000-8
         ldb   #$20
ClrLoop  stb   ,x+
         leay  -1,y
         bne   ClrLoop
*         ldd   #$2000-8
*         ldu   #$2020
*ClrLoop  stu   ,x++
*         subd  #$0002
*         bne   ClrLoop
         ENDC

MoveTxt  leau  <L0011,pcr point to OS-9 Welcome Message
         bsr   Move1      E=$00 already from TFM above...
* 0  = crash
* 1  = reset
* -1 = startup
         ldb   ,s+        check state of boot
         bne   L00E2      if OK, continue
* U=<L0019 already from TFM above (call to L00FD)
         bsr   Move1      move it on-screen, E=$00 already
         clr   >$FF40     turn off disk drives
L00E0    bra   L00E0      loop forever

Move1    ldy   ,u++       get where to put the text
         IFNE  H6309
Move     ldf   ,u+        get the size of the block to move
L00FD    tfm   u+,y+
         ELSE
Move     clra
         ldb   ,u+
         tfr   d,x
L00FD    lda   ,u+
         sta   ,y+
         leax  -1,x
         bne   L00FD
         ENDC
         rts   

L0011    fdb   ScStart+(BOOTLINE*Width)+((Width-L1)/2)
         fcb   L1         length of the text below
T1       equ   *
         fcc   /NITROS9 BOOT/
L1       equ   *-T1

         fdb   ScStart+((BOOTLINE+2)*Width)+((Width-LFail)/2)
         fcb   LFail      length of the 'FAILED' string
TFail    fcc   /FAILED/
LFail    equ   *-TFail

* saves 2 bytes over leax <L00E2,pc, cmpx #Bt.Start
L00E2    tfr   pc,d       get the address at which we're executing
         cmpa  #$26       the bootfile starts out at $2600
         bne   L0101      if not at $26xx, continue with booting
         ldu   #$2600     else move rel, Boot, OS9p1 over
         IFNE  H6309
         ldw   #$1200     size of track 34 boot file
         ELSE
         ldx   #$1200
         ENDC
         ldy   #Bt.Start  where to put it
         bsr   L00FD      1 byte smaller than tfm in place
         jmp   >Offset+L0101

BtDebug  pshs  cc,d,x     save the register
         orcc  #IntMasks  turn IRQ's off
         ldb   #Bt.Block  block to map in
         stb   >$FFA0     map the boot screen into block 0
         ldx   >$0002     where to put the bytes
         sta   ,x+        put the character on-screen
         stx   >$0002     save updated address
         clr   >$FFA0     map block 0 in again
         puls  cc,d,x,pc  restore X and exit

L0101    
         lda   #$7E       RTS
         sta   <D.BtBug
         leax  <BtDebug,pc point to debug routine
         stx   <D.BtBug+1

         leau  <R.Crash,pcr point to D.Crash, D.CBStart
         ldy   #D.Crash   move it over
         bsr   Move       E=$00 from call to L00FD above.
         IFNE  H6309
         ldmd  #$03       go to native mode, FIRQ saves all registers
         inc   <D.MDREG   0+1=1; set MD shadow register (clr'd from above)
         ENDC

*         leax  <eom,pcr   point to the end of REL
*         ldd   M$Size,x   get size of the next module
*         leax  d,x        skip Boot, point to OS9p1
         ldx   #$F000     we KNOW where OS9p1 starts in memory
         ldd   M$Exec,x   get execution start address
         jmp   d,x        jump to it

* D.Crash
R.Crash  fcb   $10        size of the data to move over
L003F    clr   >$FF91     go to map type 0 - called by CC3Go from map 1
         jmp   >Offset+crash

         fcb   $00        warm start flag
         fdb   $0074      go to $0074, next routine

* reset vector: map ROMs out and go to REL in the default DECB block map,
* which is still block $3F at the top fo memory
         nop              required for the ROMs to believe it's a reset vector
         clr   >$FFDF     go to all RAM mode
         jmp   >Offset+reset and re-start the boot

Pad      fill  $39,$127-*

         ELSE                          match IFGT Level-1

*************************************************************************
* Entry point for level1
*************************************************************************

Start
         IFNE  mc09
* currently we have NO STACK

         leax  <BootMsg,pcr
outbsy   lda   VDUSTA
         bita  #2
         beq   outbsy
         lda   ,x+
         beq   done
         sta   VDUDAT
         bra   outbsy

done
         ELSE                          match IFNE mc09

         clr   PIA0Base+3

         IFNE  (tano+d64+dalpha)
         clr   PIA0Base+1              added for Dragon, works on CoCo
         ENDC
         IFNE  H6309
         ldmd  #3                      native mode
         ENDC

         sta   $FFDF                   turn off ROM
* locate Boot Text Screen at $8000
         ldb   #$06
         ldx   #$FFC6
L262B    sta   ,x++
         decb
         bne   L262B
         sta   1,x

	 IFNE	dalpha
	 clr	$ffc0		* Reset to text mode if Dragon Alpha
	 clr	$ffc2
	 clr	$ffc4
	
	 lda	$ff22
	 anda	#$07
	 sta	$ff22
	 ENDC

* Clear VDG screen
         ldx   #ScStart
         ldy   #512
         lda   #$60
L263B    sta   ,x+
         leay  -1,y
         bne   L263B

* Copy "NITROS9 BOOT" to screen area
         ldx   #ScStart+$10A
         leay  <BootMsg,pcr
         ldb   #BootMLen
L2649    lda   ,y+
         sta   ,x+
         decb
         bne   L2649

         IFNE  (tano+d64+dalpha)
         tst   <$72
         ELSE
         ldd   #$1212
         cmpd  <$0078
         ENDC

         beq   L266E

         ENDC              match IFNE mc09

* Copy boot track from $2600 to $EE00 - not quite all of it though. The whole boot
* track is $1200 bytes and would take us right up to $FFFF. We actually copy up to
* $FE80.
         leau  >Begin-XX.Size,pcr
         ldx   #Bt.Size
         ldy   #Bt.Start
L2663    lda   ,u+
         sta   ,y+
         leax  -1,x
         bne   L2663

* go to L266E but in high memory
         jmp   >Offset+L266E

* now executing in high memory. Compute the absolute address of the entry
* point of the next module (which must be krn) and go there.
L266E    leax  <eom,pcr
         ldd   M$Exec,x
         jmp   d,x

BootMsg
         IFNE  mc09
         fcn   / Boot /
         ELSE
         IFNDEF dalpha		save some bytes on Dragon Alpha
         fcc   /NITROSy/
         fcb   $60
         ENDC
         fcc   /BOOT/
BootMLen equ   *-BootMsg
         ENDC                   match IFNE mc09

         ENDC                   match IFGT Level-1

         emod
eom      equ   *
         end
