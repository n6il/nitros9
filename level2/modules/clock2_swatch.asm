********************************************************************
* Clock2 - Dallas Semiconductor 1216E SmartWatch clock driver
*
* $Id$
*
* Ed.    Comments                                       Who YY/MM/DD
* ------------------------------------------------------------------
* 1      Created                                        BGP 98/10/04

         nam   Clock2
         ttl   Dallas Semiconductor 1216E SmartWatch clock driver

         ifp1  
         use   defsfile
         endc  

rev      set   1
edition  set   1

RTC.Base equ   $2000      We map the clock into this addr
RTC.Blok equ   $FFA1      Address corresponding to map RTC ROM block into
RTCMPSlt equ   $33        MPI Slot ($00-$33) where RTC is

         mod   CSize,CNam,Systm+Objct,ReEnt+rev,Entry,RTC.Base

CNam     fcs   "Clock2"
         fcb   edition    edition byte
SlotSlct fcb   RTCMPSlt   slot constant for MPI select code

Entry    bra   Init       clock hardware initialization
         nop              maintain 3 byte entry table spacing
*         bra   GetTime    get hardware time
         bra   ReadSW     get hardware time
         nop              save a couple cycles with short branch a
         bra   SetTime    set hardware time

* SetTime is not implemented yet
SetTime  clrb  
         rts   

GetTime  ldb   <D.Sec     get seconds
         incb  
         cmpb  #60
         beq   ReadSW     if zero, get SmartWatch time
         stb   <D.Sec     else update second
         rts   

Init           
ReadSW   pshs  d,x,y,u save regs which will be altered

         ldx   #$003E
         ldb   #1
         os9   F$MapBlk
*         lbcs  exx

         pshs  cc

*         orcc  #IntMasks  disable interrupts
         lda   MPI.Slct    get MPI slot
         ldb   <D.HINIT    get GIME shadow of $FF90
         pshs  d
         lda   SlotSlct,pcr
         sta   MPI.Slct    and select it
         andb  #$FC
         stb   $FF90      ROM mapping = 16k internal, 16k external
         leay  SWKey,pcr
*ROMRAM   sta   >$FFDE     put CC3 in ROM mode
* Loop to write 64 bit key to SmartWatch
MapSW    lda   $04,u      read ROM block (trigger SW)
LoopTop  ldb   #8         B = bit counter (8)
         lda   ,y+        get byte in key
         beq   ReadTime   if zero, exit
BitLoop  lsra             move bit 0 to Carry
         bcs   Write1     if Carry set, write a 1 to SmartWatch
         tst   ,u         else write 0 to SmartWatch
         bra   LoopCntl
Write1   tst   1,u
LoopCntl decb             dec bit counter
         beq   LoopTop    if more bits, continue 
         bra   BitLoop    else move to top of loop and get next byte in key

* Read Time from SmartWatch
ReadTime lda   #8
L00CF    ldb   #8
         pshs  d
L00D3    ldb   4,u
         lsrb  
         rora  
         dec   1,s        dec count (B) on stack
         bne   L00D3

* Convert BCD to a normal number
BCD2Dec  clrb  
B2DLoop  cmpa  #$10
         bcs   B2DDone
         suba  #$10
         addb  #$0A
         bra   B2DLoop
B2DDone  pshs  a
         addb  ,s+

         stb   1,s
         puls  a
         deca  
         bne   L00CF
*         sta   >$FFDF
* Restore original values and unmask interrupts ASAP
         ldx   #D.Time
         ldd   ,s         get year/Month
         std   ,x         save year/month
         lda   2,s        get day
         sta   2,x        save day
         ldd   4,s        get hour/min
         std   3,x        save hour/min
         lda   6,s        get seconds
         sta   5,x        save seconds
         leas  8,s        clean stack
         puls  d          get DINIT/MPI slot
         sta   >MPI.Slct  restore org MPI slot
         stb   >$FF90     restore org GIME INT0

         puls  cc
       
         ldb   #1
         os9   F$ClrBlk

exx 
         puls  pc,d,x,y,u

SWKey    fcb   %11000101,%00111010,%10100011,%01011100
         fcb   %11000101,%00111010,%10100011,%01011100
         fcb   $00

         ifeq  1


* Read SmartWatch time
* Entry: Y=copy of stack pointer
ReadSW   pshs  cc         Save interrupt status
         orcc  #IntMasks  Disable interupts

         lda   >MPI.Slct  Get current MPak slot
         ldb   <D.HINIT   Get current GIME init register
         pshs  d          Save current MPak slot & GIME init register
         lda   #RTCMPSlt  Set MPak to slot 4 (both ROM & IRQ select)
         sta   >MPI.Slct
         andb  #$FC       Set GIME to use 16K Internal/16K External ROM
         stb   $FF90
         lda   <D.TINIT   Get task side
         bita  #$01       We in task 1? (either GRFDRV or user task)
         bne   L0207      Yes, adjust myself for it
* If we are in system state, map ROM block into block 2 of Task 0
         ldb   RTC.Blok   Get current memory block to swap out
         pshs  d          Save it
         lda   #$3E       Get Disk ROM block #
         sta   RTC.Blok   Swap it in
         bra   ROMRAM     Go find Smart watch
* If we are in user state, map ROM block into block 2 of Task 1
L0207    ldb   RTC.Blok+8 Get block # to save
         pshs  d          Preserve Init1 register & block # currently mapped
         lda   #$3E       Get Disk ROM block #
         sta   RTC.Blok+8 Swap it in

* Now, switch to ROM mode and swap Smartwatch in
ROMRAM   clr   $FFDE      Switch to all ROM mode
*        pshs   dp          Preserve DP
*        lda    #$20        Point DP to ROM/Smartwatch block
*        tfr    a,dp
         lbsr  MapSW      Swap Smarwatch into beginning of ROM block
         ldx   #D.Sec     Point to system seconds
         lda   #8         Get # registers to read
         sta   ,-s        Save it on stack
* Read bits from SmartWatch
ReadSW   ldb   #8         Get # of bits
GetBit   lda   >RTC.Base+4 Get a bit off the smartwatch
         lsra             Shift it to carry
         ror   ,x         Move it location
         decb             Done?
         bne   GetBit     No, keep going
         lda   ,s         Get register #
         cmpa  #$08       Was it the 1/10th second register?
         beq   L023D      Yes skip it and do it again
         cmpa  #$04       Was it day of week register?
         bne   L0239      No, go on to next register
         ldb   ,x         Get the day of week
         stb   <D.Daywk   Save it
         bra   L023D      Move to next register

L0239    leax  -1,x       Move time packet pointer back
         bsr   BCD2Dec    Convert BCD to hex for current register
L023D    dec   ,s         Done all registers?
         bne   ReadSW     No, go back
         leas  1,s        Purge stack
*        puls   dp          Get back real DP
         clr   $FFDF      Swap back to all RAM mode
         puls  d          Restore block #
         bita  #$01       In task 1?
         bne   L0251      Yes, save block to task 1
         stb   RTC.Blok   Save block to task 0
         bra   L0254      Continue on
L0251    stb   RTC.Blok+8 Save block to task 1
L0254    puls  d          Restore MPak slot # & GIME init register
         sta   >MPI.Slct  Switch MPak back
         stb   $FF90      Restore GIME
         puls  cc,pc      Restore interupts & return

* Convert BCD to Hex
BCD2Dec  lda   1,x        Get BCD byte
         clrb             Clear out destination byte
L0261    cmpa  #16        0-15?
         blo   L026B      Yes, it's fine
         suba  #16        Subtract 16 from BCD byte
         addb  #10        Add 10 to destination byte
         bra   L0261      keep doing until we are done
L026B    pshs  a          Push leftover onto stack
         addb  ,s+        Add to current destination byte
         stb   1,x        Store it back
         rts              return
















* Enable SmartWatch
* Entry: S is a new stack ptr for temporary use. ROM has been mapped into
*   block 2, which will have the Smartwatch mapped into the beginning of
*   it after we send out the 'map in Smartwatch' 64 bit sequence
*   Y=original stack pointer, DO NOT MODIFY!
*   DP must be $20, for direct page addressing
*
* 6809 optomization: Preserve DP on the stack, and then set it for $20
* Use for $2000/$2001 ops in direct page mode, saving 50+ cycles
* (especially considering interrupts are disabled this whole time!)
* NOTE: all accesses to smartwatch except the init pattern have to be
*       READS ONLY, not writes
* 6309: do above, and use LDE instead of TST, as well as F as the counter
*  instead of the stack
*

SWBits   fcb   %11000101,%00111010,%10100011,%01011100
         fcb   %11000101,%00111010,%10100011,%01011100

MapSW    leax  SWBits,pc  point to coding table
         lda   >RTC.Base+4 Reset Smarwatch to expect the map in sequence
         lda   #8         byte counter
         sta   ,-s        onto stack

ByteLoop ldb   #8         bit counter
         lda   ,x+        get code byte
BitLoop  lsra             shift LSBit out
         bcs   Write1     if a 1 bit, skip ahead
         tst   >RTC.Base  if 0, test 1st byte of ROM we mapped in
         bra   DecLoop
Write1   tst   >RTC.Base+1 if 1 bit, test 2nd byte of ROM we mapped in
DecLoop  decb             dec bit counter
         bne   BitLoop    keep reading alternate signals until byte is done
         dec   ,s         dec byte counter
         bne   ByteLoop   keep going until entire 64 bit read pattern done
         puls  a,pc       restore regs & return



         endc  

         emod  
CSize    equ   *
         end   


