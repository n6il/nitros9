********************************************************************
* Rel - OS-9 Level Two relocation module
*
* $Id$
*
* Ed.    Comments                                       Who YY/MM/DD
* ------------------------------------------------------------------
* 5      Original version by Tandy/Microware
* 6      Added instruction to put into ALL-RAM mode     BGP 98/10/10
*        for ROM based kernels.
*        Added more comments from version provided by   BGP 98/10/21
*        Curtis Boyle

         nam   REL
         ttl   OS-9 Level Two relocation module

         ifp1  
         use   defsfile
         endc  

Bt.Start equ   $ED00
ScStart  equ   $8000      screen start in memory
XX.Size  equ   6          number of bytes before REL actually starts
Offset   equ   Bt.Start+XX.Size

tylg     set   Systm+Objct
atrv     set   ReEnt+rev
rev      set   $01
edition  set   6

********************************************************************
* Any changes to the next 3 lines requires changes in XX.Size, above
         fcc   /OS/       sync bytes
         bra   Start+XX.Size execution start
         fdb   $1205      filler bytes

         mod   eom,name,tylg,atrv,start,size

         org   0
size     equ   .          REL doesn't require any memory

name     fcs   /REL/
         fcb   edition

* OS-9 boot message (Setup for a 32 column screen)

BootMsg  fcc   /OS/
         fcb   $79
         fcb   $60
         fcc   /BOOT/

* Fail message

FailMsg  fcc   /FAILED/

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

DefPals  fcb   $12        green
         fcb   $36
         fcb   $09        blue
         fcb   $24        red
         fcb   $3F        white
         fcb   $1B        cyan
         fcb   $2D        magenta
         fcb   $26
         fcb   $00        black
         fcb   $12        green
         fcb   $00        black
         fcb   $3F        white
         fcb   $00        black
         fcb   $12        green
         fcb   $00        black
         fcb   $26

* CC crash routine (This gets moved to direct page)

CrashRtn clr   >Dat.Task  go to map type 0 - called by CC3Go from map 1
         jmp   >Offset+crash

* CC3 warmstart

         fcb   $00        warm start flag
         fdb   $0074      go to $0074, next routine
* reset vector: map ROMs out and go to REL in the default DECB block map,
* which is still block $3F at the top of memory
         nop              required for the ROMs to believe it's a reset vector
         clr   >$FFDF     go to all RAM mode
         jmp   >Offset+reset and re-start the boot

crash          
         fcb   $C6,$01,$20,$07,$4F
         fcb   $53,$20,$5B,$12,$05

******************************
*
* Main entry point
*

reset          
start    clr   $FFDF      ALL RAM MODE (for ROM-based kernels) ++BGP
         clrb  
         orcc  #IntMasks  turn off IRQ's
         clr   >PIA0Base+3  turn off SAM IRQ's
         clra  
         tfr   a,dp       set direct page to $0000
         sta   <D.CbStrt
         sta   DAT.Regs   map in block 0
         lds   #$1FFF     set stack to the end of the block
         pshs  b          set first byte of stack to 0
         ldb   #D.Clock   get length of system direct page to initialize
         ldx   #D.Tasks   get start of system direct page
L0072    sta   ,x+        clear out the direct page
         decb             done?
         bne   L0072      no, keep going till done
         inca  
         sta   <D.Speed   hi speed
         sta   >$FFD9     set to high speed
         leau  CC3Regs,pcr point to the video setup data
         ldx   #D.HINIT   set video mapping
L0084    ldd   ,u++       get the bytes
         std   -256,x     save in the hardware
         std   ,x++       and in the direct page
         cmpx  #D.Speed   end of video hardware yet?
         bcs   L0084

* set up palettes

         leau  >DefPals,pcr point to palette data
         ldy   #PalAdr    point to GIME palette start
         ldb   #16        get length of data
         bsr   CopyRtn    move table

         lda   #$3E
         sta   >$FFA4     map in the block
         ldx   #ScStart   start of the block
         clrb             get length of screen
         ldu   #$6060     clear out screen mem
L00A9    stu   ,x++       save data
         decb             done?
         bne   L00A9      no, keep going

* print 'OS9 BOOT'

         ldy   #ScStart+$010C get screen address for print
         leau  BootMsg,pcr point to boot message
         ldb   #8         get length of data
         bsr   CopyRtn    print it

* setup VDG hardware to point at $4000

         ldb   #5         get length of screen init
         ldx   #$FFC6     get start register to set up screen
L00BF    sta   ,x++       set SAM bits
         decb             done?
         bne   L00BF      no, keep going
         sta   1,x        set last couple of bits
         sta   3,x
         ldb   ,s         can we continue? (first byte should be 0)
         beq   L00DD      yes, continue boot

* boot failed

         ldy   #ScStart+$014D get screen address
         leau  >FailMsg,pcr point to 'Failed' message
         ldb   #$06       get length of data
         bsr   CopyRtn    show failed message
         clr   >$FF40     shut off disk motor
Hang     bra   Hang       dead loop forever

L00DD    leax  >L00DD,pcr get pointer to where we are in memory
         cmpx  #$ED00     warm start?
         bcc   JmpOS9P1   yep...
         ldu   #$2600     else copy at $2600...
         ldx   #$1200     $1200 bytes...
         ldy   #$ED00     ...to $ED00
         bsr   L00F8
         jmp   >Offset+JmpOS9P1 jump to OS9p1!

* Copies B bytes from ,U to ,Y

CopyRtn  clra  
         tfr   d,x
L00F8    ldb   ,u+
         stb   ,y+
         leax  -1,x
         bne   L00F8
         rts   

* Setup Crash routine

JmpOS9P1 leau  >CrashRtn,pcr get pointer to crash routine
         ldb   #16        get length of crash routine
         ldy   #D.Crash   point to crash routine area
         bsr   CopyRtn    move it

* Execute Boot module

         leax  <eom,pcr   point to start of boot
         ldd   M$Size,x   get size of Boot
         leax  d,x        move past it
         ldd   M$Exec,x   get execution offset to OS9p1
         jmp   d,x        execute it

* Fill the rest to put Boot at proper address

Filler   fill  $39,$1C7-*

         emod  
eom      equ   *
         end   
