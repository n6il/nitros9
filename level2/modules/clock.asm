********************************************************************
* Clock - Clocks for OS-9 Level Two/NitrOS-9
*
* Clock module for CoCo 3 and TC9 OS9 Level 2 Version 02.00.01
*
* Includes support for several different RTC chips, GIME Toggle
* IRQ fix, numerous minor changes.
*
* Based on Microware/Tandy Clock Module for CC3/L2
*
* $Id$
*
* Ed.    Comments                                       Who YY/MM/DD
* ------------------------------------------------------------------
*        NitrOS-9 2.00 distribution                         ??/??/??
*        Back-ported to OS-9 Level Two                  BGP 03/01/01

         nam   Clock
         ttl   Clocks for OS-9 Level Two/NitrOS-9

TkPerTS  equ 2 ticks per time slice
GI.Toggl equ %00000001 GIME CART* IRQ enable bit, for CC3

* TC9 needs to reset more interrupt sources
*GI.Toggl equ %00000111 GIME SERINT*, KEYINT*, CART* IRQ enable bits

         IFP1
         use defsfile
         ENDC

Edtn     equ 9
Vrsn     equ 4              NitrOS-9 version

*
* Setup for specific RTC chip
*
         IFNE RTCElim
RTC.Sped equ $20 32.768 KHz, rate=0
RTC.Strt equ $06 binary, 24 Hour, DST disabled
RTC.Stop equ $86 bit 7 set stops clock to allow setting time
RTC.Base equ $FF72  I don't know base for this chip.
         ENDC

         IFNE RTCDsto2+RTCDsto4
RTC.Base equ $FF50  Base address of clock
         ENDC

         IFNE RTCBB+RTCTc3
         IFNE RTCBB
RTC.Base equ $FF5C	In SCS* Decode
         ELSE
RTC.Base equ $FF7C	Fully decoded RTC
         ENDC
RTC.Zero equ -4     Send zero bit by writing this offset
RTC.One  equ -3     Send one bit by writing this offset
RTC.Read equ 0      Read data from this offset
         ENDC

         IFNE RTCSmart
RTC.Base equ $4004  We map the clock into this addr
RTC.Zero equ -4     Send zero bit by writing this offset
RTC.One  equ -3     Send one bit by writing this offset
RTC.Read equ 0      Read data from this offset
         ENDC

         IFNE RTCHarrs
RTC.Base equ $FF60  Base address for clock
         ENDC

         IFNE RTCSoft
RTC.Base equ 0      Have to have one defined.
         ENDC

*------------------------------------------------------------
*
* Start of module
*
         mod len,name,Systm+Objct,ReEnt+Vrsn,Init,RTC.Base

name     fcs "Clock"
         fcb Edtn

         IFNE MPIFlag
SlotSlct fcb MPI.Slot-1   Slot constant for MPI select code
         ENDC

*
* Table to set up Service Calls:
*
NewSvc   fcb   F$Time
         fdb   F.Time-*-2
         fcb   F$VIRQ
         fdb   F.VIRQ-*-2
         fcb   F$Alarm
         fdb   F.ALARM-*-2
         fcb   F$STime
         fdb   F.STime-*-2

         IFNE  RTCElim
         fcb   F$NVRAM    Eliminator adds one new service call
         fdb   F.NVRAM-*-2
         ENDC

         fcb   $80 end of service call installation table

*---------------------------------------------------------
* IRQ Handling starts here.
*
* Caveat: There may not be a stack at this point, so avoid using one.
*         Stack is set up by the kernel between here and SvcVIRQ.
*
SvcIRQ   lda   >IRQEnR       Get GIME IRQ Status and save it.
         ora   <D.IRQS
         sta   <D.IRQS
         bita  #$08          Check for clock interrupt
         beq   NoClock
         anda  #^$08         Drop clock interrupt
         sta   <D.IRQS
         ldx   <D.VIRQ       Set VIRQ routine to be executed
         clr   <D.QIRQ      ---x IS clock IRQ
         bra   ContIRQ

NoClock  leax DoPoll,pcr       If not clock IRQ, just poll IRQ source
         IFNE  H6309
         oim   #$FF,<D.QIRQ    ---x set flag to NOT clock IRQ
         ELSE
         lda   #$FF
         sta   <D.QIRQ
         ENDC
ContIRQ  stx  <D.SvcIRQ
         jmp  [D.XIRQ]         Chain through Kernel to continue IRQ handling

*------------------------------------------------------------
*
* IRQ handling re-enters here on VSYNC IRQ.
*
* - Count down VIRQ timers, mark ones that are done
* - Call DoPoll/DoToggle to service VIRQs and IRQs and reset GIME
* - Call Keyboard scan
* - Update time variables
* - At end of minute, check alarm
*
SvcVIRQ  clra               Flag if we find any VIRQs to service
         pshs  a
         ldy   <D.CLTb      Get address of VIRQ table
         bra   virqent

virqloop ldd   Vi.Cnt,x     Decrement tick count
         IFNE  H6309
         decd               --- subd #1
         ELSE
         subd  #$0001
         ENDC
         bne   notzero      Is this one done?
         lda   Vi.Stat,x    Should we reset?
         bmi   doreset
         lbsr  DelVIRQ      No, delete this entry
doreset  ora   #$01         Mark this VIRQ as triggered.
         sta   Vi.Stat,x
         lda   #$80         Add VIRQ as interrupt source
         sta   ,s
         ldd   Vi.Rst,x     Reset from Reset count.
notzero  std   Vi.Cnt,x
virqent  ldx   ,y++
         bne   virqloop

         puls  a            Get VIRQ status flag: high bit set if VIRQ
         ora   <D.IRQS      Check to see if other hardware IRQ pending.
         bita  #%10110111   Any V/IRQ interrupts pending?
         beq   toggle
         bsr   DoPoll       Yes, go service them.
         bra   KbdCheck
toggle   bsr   DoToggle     No, toggle GIME anyway
KbdCheck jsr   [>D.AltIRQ]  go update mouse, gfx cursor, keyboard, etc.

         dec   <D.Tick      End of second?
         bne   VIRQend      No, skip time update and alarm check
         lda   #TkPerSec    Reset tick count
         sta   <D.Tick

* ATD: Modified to call real time clocks on every minute ONLY.
         inc   <D.Sec       go up one second
         lda   <D.Sec       grab current second
         cmpa  #60          End of minute?
         blo   VIRQend      No, skip time update and alarm check
         clr   <D.Sec       Reset second count to zero

         lbsr  UpdTime

         ldd   >WGlobal+G.AlPID
         ble   VIRQend      Quit if no Alarm set
         ldd   >WGlobal+G.AlPckt+3   Does Hour/Minute agree?
         cmpd  <D.Hour
         bne   VIRQend
         ldd   >WGlobal+G.AlPckt+1  Does Month/Day agree?
         cmpd  <D.Month
         bne   VIRQend
         ldb   >WGlobal+G.AlPckt+0     Does Year agree?
         cmpb  <D.Year
         bne   VIRQend
         ldd   >WGlobal+G.AlPID
         cmpd  #1
         beq   checkbel
         os9   F$Send   
         bra   endalarm
checkbel ldb   <D.Sec       Sound bell for 15 seconds
         andb  #$F0
         beq   dobell
endalarm ldd   #$FFFF
         std   >WGlobal+G.AlPID
         bra   VIRQend
dobell   ldx   >WGlobal+G.BelVec
         beq   VIRQend
         jsr   ,x
VIRQend  jmp   [>D.Clock]   Jump to kernel's timeslice routine

*------------------------------------------------------------
* Interrupt polling and GIME reset code
*

*
* Call [D.Poll] until all interrupts have been handled
*
Dopoll   jsr   [>D.Poll]    Call poll routine
         bcc   DoPoll       Until error (error -> no interrupt found)
*
* Reset GIME to avoid missed IRQs
*
DoToggle lda   #^GI.Toggl   Mask off CART* bit
         anda  <D.IRQS
         sta   <D.IRQS
         lda   <D.IRQER     Get current enable register status
         tfr   a,b
         anda  #^GI.Toggl   Mask off CART* bit
         orb   #GI.Toggl    --- ensure that 60Hz IRQ's are always enabled
         sta   >IRQEnR      Disable CART
         stb   >IRQEnR      Enable CART
         clrb
         rts

*------------------------------------------------------------
*
* Update time subroutines
*
*   The subroutine UpdTime is called once per minute.  On systems
* with an RTC, UpdTime reads the RTC and sets the D.Time variables.
*

*
* Eliminator time update  (lacks MPI slot select ability)
*
         IFNE RTCElim
UpdTime  ldx   M$Mem,pcr get RTC base address from fake memory requirement
         ldb   #$0A UIP status register address
         stb   ,x generate address strobe
         lda   1,x get UIP status
         bpl   NoUIP   Update In Progress, go shift next RTC read
         lda   #TkPerSec/2 set up next RTC read attempt in 1/2 second
         sta   <D.Tick save tick
         bra   UpdTExit and return

NoUIP    decb      year register address
         stb   ,x generate address strobe
         lda   1,x get year
         sta   <D.Year
         decb       month register address
         stb   ,x
         lda   1,x
         sta   <D.Month
         decb     day of month register address
         stb   ,x
         lda   1,x
         sta   <D.Day
         ldb   #4 hour register address
         stb   ,x
         lda   1,x
         sta   <D.Hour
         ldb   #2 minute register address
         stb   ,x
         lda   1,x
         sta   <D.Min
         clrb   second register address
         stb   ,x
         lda   1,x
SaveSec  sta   <D.Sec
UpdTExit rts
         ENDC

*
* Disto 2-in-1 RTC time update
*
         IFNE  RTCDsto2
UpdTime  pshs  a,cc       Save old interrupt status and mask IRQs
         bsr   RTCPre

         bsr   GetVal   Get Year
         bsr   GetVal   Get Month
         bsr   GetVal   Get Day
         decb          ldb #5
         stb   2,x
         decb
         lda   ,x
         anda  #3
         bsr   GetVal1  Get Hour
         bsr   GetVal   Get Minute
         bsr   GetVal   Get Second

RTCPost  clr   >$FFD9   2 MHz  (Really should check $A0 first)
         puls  cc,b

         IFNE  MPIFlag
         stb   >MPI.Slct  Restore saved "currently" selected MPak slot
         ENDC

         clrb
         rts

RTCPre   orcc  #IntMasks

         IFNE  MPIFlag
         ldb   >MPI.Slct  Save currently selected MPak slot on stack
         stb   3,s
         andb  #$F0
         orb   >SlotSlct,pcr Get slot to select
         stb   >MPI.Slct     Select MPak slot for clock
         ENDC

         ldy   #D.Time
         ldx   M$Mem,pcr
         clr   1,x
         ldb   #12
         clr   >$FFD8   1 MHz
         rts

GetVal   stb   2,x
         decb
         lda   ,x      read tens digit from clock
         anda  #$0f
GetVal1  pshs  b       save b
         ldb   #10
         mul           multiply by 10 to get value
         stb   ,y      save 10s value
         puls  b       set up clock for ones digit
         stb   2,x
         decb
         lda   ,x      read ones digit from clock
         anda  #$0f
         adda  ,y      add ones + tens
         sta   ,y+     store clock value into time packet
         rts

         ENDC

*
* Disto 4-in-1 RTC time update
*
         IFNE  RTCDsto4
UpdTime  equ   *
         IFNE  MPIFlag
         pshs  cc    Save old interrupt status and mask IRQs
         orcc  #IntMasks
         ldb   >MPI.Slct  Save currently selected MPak slot on stack
         pshs  b
         andb  #$F0
         orb   >SlotSlct,pcr Select MPak slot for clock
         stb   >MPI.Slct
         ENDC

         ldx   M$Mem,pcr
         ldy   #D.Time    Start with seconds
         
         ldb   #11
         bsr   GetVal   Get Year
         bsr   GetVal   Get Month
         bsr   GetVal   Get Day
         lda   #3       Mask tens digit of hour to remove AM/PM bit
         bsr   GetVal1  Get Hour
         bsr   GetVal   Get Minute
         bsr   GetVal   Get Second

         IFNE  MPIFlag
         puls  b       Restore saved "currently" selected MPak slot
         stb   >MPI.Slct
         puls  cc,pc   Restore previous IRQ status
         ELSE
         rts          No MPI, don't need to mess with slot, CC
         ENDC

GetVal   lda   #$0f     Mask to apply to tens digit
GetVal1  stb   1,x
         decb
         anda  ,x       read ones digit from clock
         pshs  b        save b
         ldb   #10
         mul           multiply by 10 to get value
         stb   ,y       Add to ones digit
         puls  b
         stb   1,x
         decb
         lda   ,x       read tens digit from clock and mask it
         anda  #$0f
         adda  ,y
         sta   ,y+
         rts

         ENDC


*
* Update time from B&B RTC
*
         IFNE  RTCBB+RTCTc3
UpdTime  pshs  u,y,cc
         leay  ReadBCD,pcr   Read bytes of clock

TfrTime  orcc  #IntMasks  turn off interrupts
         ldu   M$Mem,pcr  Get base address

         IFNE  MPIFlag
         ldb   >MPI.Slct  Select slot
         pshs  b
         andb  #$F0
         orb   SlotSlct,pcr
         stb   >MPI.Slct
         ENDC

         lbsr  SendMsg   Initialize clock
         ldx   #D.Sec
         ldb   #8        Tfr 8 bytes

tfrloop  jsr   ,y        Tfr 1 byte

         bitb  #$03
         beq   skipstuf  Skip over day-of-week, etc.
         leax  -1,x
skipstuf decb
         bne   tfrloop

         IFNE  MPIFlag
         puls  b
         stb   >MPI.Slct     restore MPAK slot
         ENDC

         puls  u,y,cc,pc

ClkMsg   fcb   $C5,$3A,$A3,$5C,$C5,$3A,$A3,$5C
* Enable clock with message $C53AA35CC53AA35C
SendMsg  lda   RTC.Read,u     Send Initialization message to clock
         leax  <ClkMsg,pcr
         ldb   #8
msgloop  lda   ,x+
         bsr   SendByte
         decb
         bne   msgloop
         rts

SendBCD  pshs  b          Send byte to clock, first converting to BCD
         bitb  #$03
         bne   BCDskip    Send zero for day-of-week, etc.
         lda   #0
         bra   SndBCDGo
BCDskip  lda   ,x
SndBCDGo tfr   a,b
         bra   binenter
binloop  adda  #6
binenter subb  #10
         bhs   binloop
         puls  b
SendByte coma             Send one byte to clock
         rora
         bcc   sendone
sendzero tst   RTC.Zero,u
         lsra
         bcc   sendone
         bne   sendzero
         rts
sendone  tst   RTC.One,u
         lsra
         bcc   sendone
         bne   sendzero
         rts


ReadBCD  pshs  b
         ldb   #$80    High bit will rotate out after we read 8 bits
readbit  lda   RTC.Read,u  Read a bit
         lsra  
         rorb          Shift it into B
         bcc   readbit Stop when marker bit appears
         tfr   b,a
         bra   BCDEnter  Convert BCD number to Binary
BCDLoop  subb  #6       by subtracting 6 for each $10
BCDEnter suba  #$10
         bhs   BCDLoop
         stb   ,x
         puls  b,pc

         ENDC


*
* Update time from Smartwatch RTC
*
         IFNE  RTCSmart
UpdTime  pshs  cc
         orcc  #IntMasks     Disable interrupts
         lda   >MPI.Slct     Get MPI slot
         ldb   <$90          Get GIME shadow of $FF90
         pshs  b,a
         anda  #$F0
         ora   >SlotSlct,pcr Get new slot to select
         anda  #$03          *** TEST ***
         sta   >MPI.Slct     And select it
         andb  #$FC
         stb   >$FF90        ROM mapping = 16k internal, 16k external
         ldb   >$FFA2        Read GIME for $4000-$5fff
         pshs  b
         lda   #$3E
         sta   >$FFA2        Put block $3E at $4000-$5fff
         clr   >$FFDE        Map RAM/ROM, to map in external ROM
         lbsr  SendMsg       Initialize clock
         ldx   #D.Sec        Start with seconds
         lda   #$08
         sta   ,-s           Set up loop counter = 8
L021E    ldb   #$08
L0220    lda   >RTC.Read+RTC.Base     Read one bit
         lsra  
         ror   ,x            Put bit into time
         decb                End of bit loop
         bne   L0220
         lda   ,s            Check loop counter
         cmpa  #$08
         beq   L023D         Fill "seconds" twice (ignore 1st value)
         cmpa  #$04
         bne   L0239
         ldb   ,x            Save 4th value read at $34 (day of week?)
         stb   $0A,x
         bra   L023D         And overwrite "day" with day
L0239    leax  -$01,x        Go to next time to read
         bsr   BCD2Dec       Convert 1,x from BCD to decimal
L023D    dec   ,s
         bne   L021E         End of loop for reading time
         leas  $01,s         Done with loop counter
         clr   >$FFDF        Map all RAM
         puls  b
         stb   >$FFA2        Put back original memory block
         puls  b,a
         sta   >MPI.Slct
         stb   >$FF90        Restore original ROM mapping
         puls  cc,pc         Re-enable interrupts

* Convert BCD to a normal number

BCD2Dec  lda   $01,x
         clrb  
B2DLoop  cmpa  #$10
         bcs   B2DDone
         suba  #$10
         addb  #$0A
         bra   B2DLoop
B2DDone  pshs  a
         addb  ,s+
         stb   $01,x
         rts   

ClkMsg   fcb   $C5,$3A,$A3,$5C,$C5,$3A,$A3,$5C

* Send above "string" to smartwatch, one bit at a time

SendMsg  leax  <ClkMsg,pcr
         lda   >RTC.Read+RTC.Base  Tell clock we're going to start???
         lda   #$08
         sta   ,-s         Store counter = 8
L006B    ldb   #$08        Start of outer loop, 8 bytes to send
         lda   ,x+           Get byte to send
L006F    lsra              Start of inner loop, 8 bits to send
         bcs   L0077
         tst   >RTC.Zero+RTC.Base   Send a "zero" bit
         bra   L007A
L0077    tst   >RTC.One+RTC.Base    Send a "one" bit
L007A    decb  
         bne   L006F       End of inner loop
         dec   ,s          End of outer loop
         bne   L006B
         puls  pc,a

         ENDC

*
* Update time from Harris RTC 
*
         IFNE  RTCHarrs
UpdTime  pshs  cc
         orcc  #IntMasks     Disable interrupts

         ldu   M$Mem,pcr     Get base address
         ldy   #D.Time       Pointer to time in system map

         lda   #%00001100    Init command register (Normal,Int. Disabled,
         sta   $11,u            Run,24-hour mode, 32kHz)

         lda   ,u            Read base address to set-up clock regs for read
         lda   6,u           Get year
         sta   ,y+
         lda   4,u           Get month
         sta   ,y+
         lda   5,u           Get day
         sta   ,y+
         lda   1,u           Get hour
         sta   ,y+
         lda   2,u           Get minute
         sta   ,y+
         lda   3,u           Get second
         sta   ,y+

         puls  cc,pc         Re-enable interrupts
         ENDC
*
*
* Software time update
*
*

         IFNE  RTCSoft
UpdTime  lda   <D.Min       grab current minute
         inca               minute+1
         cmpa  #60          End of hour?
         blo   UpdMin       no, Set start of minute
         ldd   <D.Day       get day, hour
         incb               hour+1
         cmpb  #24          End of Day?
         blo   UpdHour      ..no
         inca               day+1
         leax  months-1,pcr point to months table with offset-1: Jan = +1
         ldb   <D.Month     this month
         cmpa  b,x          end of month?
         bls   UpdDay       ..no, update the day
         cmpb  #2           yes, is it Feb?
         bne   NoLeap       ..no, ok
         ldb   <D.Year      else get year
         andb  #$03         check for leap year: good until 2099
         cmpd  #$1D00       29th on leap year?
         beq   UpdDay       ..yes, skip it
NoLeap   ldd   <D.Year      else month+1
         incb               month+1
         cmpb  #13          end of year?
         blo   UpdMonth     ..no
         inca               year+1
         ldb   #$01         set month to jan
UpdMonth std   <D.Year      save year, month
         lda   #$01         day=1st
UpdDay   clrb               hour=midnite
UpdHour  std   <D.Day       save day,hour
         clra               minute=00
UpdMin   clrb               seconds=00
         std   <D.Min       save min,secs
UpdTExit rts
         ENDC

months   fcb  31,28,31,30,31,30,31,31,30,31,30,31 Days in each month


*------------------------------------------------------------
*
* Handle F$VIRQ system call
*
F.VIRQ   pshs  cc
         orcc  #IntMasks  Disable interrupts
         ldy   <D.CLTb    Address of VIRQ table
         ldx   <D.Init    Address of INIT
         ldb   PollCnt,x  Number of polling table entries from INIT
         ldx   R$X,u      Zero means delete entry
         beq   RemVIRQ

FindVIRQ ldx   ,y++       Is VIRQ entry null?
         beq   AddVIRQ    If yes, add entry here
         decb
         bne   FindVIRQ
         puls  cc
         comb  
         ldb   #E$Poll
         rts   

AddVIRQ  leay  -2,y         point to first null VIRQ entry
         ldx   R$Y,u
         stx   ,y
         ldy   R$D,u
         sty   ,x
         bra   virqexit

RemVIRQ  ldx   ,y++
         beq   virqexit
         cmpx  R$Y,u
         bne   RemVIRQ
         bsr   DelVIRQ
virqexit puls  cc
         clrb  
         rts   

DelVIRQ  pshs  x,y
DelVLup  ldx  ,y++ move entries up in table
         stx  -4,y
         bne  DelVLup
         puls  x,y
         leay  -2,y
         rts

*------------------------------------------------------------
*
* Handle F$Alarm call
*
F.Alarm  ldx   #WGlobal+G.AlPckt
         ldd   R$D,u
         bne   DoAlarm
         std   G.AlPID-G.AlPckt,x  Erase F$Alarm PID, Signal.
         rts   

DoAlarm  tsta               If PID != 0, set alarm for this process
         bne   SetAlarm
         cmpd  #1           1 -> Set system-wide alarm
         bne   GetAlarm
SetAlarm std   G.AlPID-G.AlPckt,x
         ldy   <D.Proc
         lda   P$Task,y     Move from process task
         ldb   <D.SysTsk    To system task
         ldx   R$X,u        From address given in X
         ldu   #WGlobal+G.AlPckt
         ldy   #5           Move 5 bytes
         bra   FMove

GetAlarm cmpd  #2
         bne   AlarmErr
         ldd   G.AlPID-G.AlPckt,x
         std   R$D,u
         bra   RetTime
AlarmErr comb
         ldb   #E$IllArg
         rts   

*------------------------------------------------------------
*
* Handle F$Time System call
*
F.Time   ldx   #D.Time    Address of system time packet
RetTime  ldy   <D.Proc    Get pointer to current proc descriptor
         ldb   P$Task,y      Process Task number
         lda   <D.SysTsk  From System Task
         ldu   R$X,u
STime.Mv ldy   #6         Move 6 bytes
FMove    os9   F$Move   
         rts   

*------------------------------------------------------------
*
* Handle F$STime system call
*
* First, copy time packet from user address space to system time
* variables, then fall through to code to update RTC.
*
F.STime  ldx   <D.Proc   Caller's process descriptor
         lda   P$Task,x  Source is in user map
         ldx   R$X,u     Address of caller's time packet
         ldu   #D.Time   Destination address
         ldb   <D.SysTsk Destination is in system map
         bsr   STime.Mv  Get time packet (ignore errors)
         lda   #TkPerSec Reset to start of second
         sta   <D.Tick

*
* No RTC, just end  (Also for SmartWatch, temporarily)
*
         IFNE  RTCSoft+RTCSmart
         rts
         ENDC

*
* Set Eliminator RTC from D.Time
*
         IFNE  RTCElim
         pshs  cc save interrupt status
         orcc  #IntMasks disable IRQs
         ldx   M$Mem,pcr get RTC base address from fake memory requirement
         ldy   #D.Time point [Y] to time variables in DP
         ldd   #$0B*256+RTC.Stop
         bsr   UpdatCk0 stop clock before setting it
         ldb   #RTC.Sped
         bsr   UpdatCk0 set crystal speed, output rate
         bsr   UpdatClk go set year
         bsr   UpdatClk go set month
         bsr   UpdatClk go set day of month
         bsr   UpdatCk0 go set day of week (value doesn't matter)
         bsr   UpdatCk0 go set hours alarm (value doesn't matter)
         bsr   UpdatClk go set hour
         bsr   UpdatCk0 go set minutes alarm (value doesn't matter)
         bsr   UpdatClk go set minute
         bsr   UpdatCk0 go set seconds alarm (value doesn't matter)
         bsr   UpdatClk go set second
         ldd   #$0B*256+RTC.Strt
         bsr   UpdatCk0 go start clock
         puls  cc Recover IRQ status
         clrb
         rts

UpdatClk ldb  ,y+ get data from D.Time variables in DP
UpdatCk0 std  ,x generate address strobe, save data
         deca  set [A] to next register down
         rts
         ENDC

*
* Set Disto 2-in-1 RTC from Time variables
*
         IFNE  RTCDsto2
         pshs  a,cc
         lbsr  RTCPre    Initialize

         bsr   SetVal  Set Year
         bsr   SetVal  Set Month
         bsr   SetVal  Set Day
         ldd   #$0805  $08 in A, $05 in B
         bsr   SetVal1 Set Hour   (OR value in A ($08) with hour)
         bsr   SetVal  Set Minute
         bsr   SetVal  Set Second

         lbra  RTCPost   Clean up + return

SetVal   clra
SetVal1  stb   2,x    Set Clock address
         decb
         pshs  b
         ldb   ,y+    Get current value
DvLoop   subb  #10    Get Tens digit in A, ones digit in B
         bcs   DvDone
         inca
         bra   DvLoop
DvDone   addb  #10
         sta   ,x     Store tens digit
         tfr   b,a
         puls  b      Get back original clock address
         stb   2,x
         decb
         sta   ,x     Store ones digit
         rts
         ENDC

*
* Set Disto 4-in-1 RTC from Time variables
*
         IFNE  RTCDsto4
         pshs  cc
         orcc  #IntMasks

         IFNE  MPIFlag
         ldb   >MPI.Slct   Save currently selected MPak slot
         pshs  b
         andb  #$F0
         orb   >SlotSlct,pcr Get slot to select
         stb   >MPI.Slct     Select MPak slot for clock
         ENDC

         ldy   #D.Time+6
         ldx   M$Mem,pcr
         clrb
         bsr   SetVal  Set Second
         bsr   SetVal  Set Minute
         bsr   SetVal  Set Hour
         bsr   SetVal  Set Day
         bsr   SetVal  Set Month
         bsr   SetVal  Set Year

         IFNE  MPIFlag
         puls  b       Restore old MPAK slot
         stb   >MPI.Slct
         ENDC

         puls  cc
         clrb          No error
         rts

SetVal   clr   ,-s    Create variable for tens digit
         lda   ,-y     Get current value
DvLoop   suba  #10    Get Tens digit on stack, ones digit in A
         bcs   DvDone
         inc   ,s
         bra   DvLoop
DvDone   adda  #10
         stb   1,x     Set Clock address
         incb
         sta   ,x      Store ones digit
         stb   1,x
         incb
         puls  a
         sta   ,x      Store tens digit
         rts
         ENDC

*
* Set B&B RTC from Time variables
*
         IFNE  RTCBB+RTCTc3
         pshs  u,y,cc
         leay  SendBCD,pcr   Send bytes of clock
         lbra  TfrTime
         ENDC
 
*------------------------------------------------------------
* read/write RTC Non Volatile RAM (NVRAM)
*
* INPUT:  [U] = pointer to caller's register stack
*         R$A = access mode (1 = read, 2 = write, other = error)
*         R$B = byte count (1 through 50 here, but in other implementations
*               may be 1 through 256 where 0 implies 256)
*         R$X = address of buffer in user map
*         R$Y = start address in NVRAM
*
* OUTPUT:  RTC NVRAM read/written
*
* ERROR OUTPUT:  [CC] = Carry set
*                [B] = error code
         IFNE  RTCElim
F.NVRAM  tfr   u,y        copy caller's register stack pointer
         ldd   #$0100     ask for one page
         os9   F$SRqMem
         bcs   NVR.Exit   go report error...
         pshs  y,u       save caller's stack and data buffer pointers
         ldx   R$Y,y      get NVRAM start address
         cmpx  #50       too high?
         bhs   Arg.Err    yes, go return error...
         ldb   R$B,y      get NVRAM byte count
         beq   Arg.Err
         abx            check end address
         cmpx  #50       too high?
         bhi   Arg.Err    yes, go return error...
         lda   R$A,y      get direction flag
         cmpa  #WRITE.   put caller's data into NVRAM?
         bne   ChkRead    no, go check if read...
         clra           [D]=byte count
         pshs  d         save it...
         ldx   <D.Proc    get caller's process descriptor address
         lda   P$Task,x   caller is source task
         ldb   <D.SysTsk  system is destination task
         ldx   R$X,y      get caller's source pointer
         puls  y         recover byte count
         os9   F$Move     go MOVE data
         bcs   NVR.Err
         ldy   ,s         get caller's register stack pointer from stack
         lda   R$Y+1,y    get NVRAM start address
         adda  #$0E      add offset to first RTC NVRAM address
         ldb   R$B,y      get byte count
         ldx   M$Mem,pcr  get clock base address from fake memory requirement
         pshs  cc,b      save IRQ enable status and byte counter
         orcc  #IntMasks disable IRQs
WrNVR.Lp ldb   ,u+        get caller's data
         std   ,x         generate RTC address strobe and save data to NVRAM
         inca             next NVRAM address
         dec   1,s        done yet?
         bne   WrNVR.Lp   no, go save another byte
         puls  cc,b      recover IRQ enable status and clean up stack
NVR.RtM  puls  y,u       recover register stack & data buffer pointers
         ldd   #$0100     return one page
         os9   F$SRtMem
NVR.Exit rts

Arg.Err  ldb   #E$IllArg Illegal Argument error
         bra   NVR.Err

ChkRead  cmpa  #READ.    return NVRAM data to caller?
         bne   Arg.Err    illegal access mode, go return error...
         lda   R$Y+1,y    get NVRAM start address
         adda  #$0E      add offset to first RTC NVRAM address
         ldx   M$Mem,pcr  get clock base address from fake memory requirement
         pshs  cc,b      save IRQ enable status and byte counter
         orcc  #IntMasks disable IRQs
RdNVR.Lp sta   ,x         generate RTC address strobe
         ldb   1,x        get NVRAM data
         stb   ,u+        save it to buffer
         inca             next NVRAM address
         dec   1,s        done yet?
         bne   RdNVR.Lp   no, go get another byte
         puls  cc,a       recover IRQ enable status, clean up stack ([A]=0)
         ldb   R$B,y      [D]=byte count
         pshs  d          save it...
         ldx   <D.Proc    get caller's process descriptor address
         ldb  P$Task,x    caller is source task
         lda   <D.SysTsk  system is destination task
         ldu   R$X,y      get caller's source pointer
         puls  y          recover byte count
         ldx   2,s        get data buffer (source) pointer
         os9   F$Move     go MOVE data
         bcc   NVR.RtM
NVR.Err  puls  y,u       recover caller's stack and data pointers
         pshs  b         save error code
         ldd   #$0100     return one page
         os9   F$SRtMem
         comb   set       Carry for error
         puls  b,pc      recover error code, return...
         ENDC
*
* Set Harris 1770 RTC from Time variables
*
         IFNE  RTCHarrs
         pshs  cc
         orcc  #IntMasks     Disable interrupts

         ldu   M$Mem,pcr     Get base address
         ldy   #D.Time       Pointer to time in system map

         lda   #%00000100    Init command register (Normal,Int. Disabled,
         sta   $11,u            STOP clock,24-hour mode, 32kHz)

         lda   ,y+           Get year
         sta   6,u
         lda   ,y+           Get month
         sta   4,u
         lda   ,y+           Get day
         sta   5,u
         lda   ,y+           Get hour
         sta   1,u
         lda   ,y+           Get minute
         sta   2,u
         lda   ,y            Get second
         sta   3,u

         lda   #%00001100    Init command register (Normal,Int. Disabled,
         sta   $11,u            START clock,24-hour mode, 32kHz)

         puls  cc,pc         Re-enable interrupts
         ENDC

*--------------------------------------------------
*
* Clock Initialization
*
* This vector is called by the kernel to service the first F$STime
* call.  F$STime is usually called by CC3Go (with a dummy argument)
* in order to initialize the clock.  F$STime is re-vectored to the
* service code above to handle future F$STime calls.
*
*
Init     ldx   #PIA0Base point to PIA0
         clra          no error for return...
         pshs  cc       save IRQ enable status (and Carry clear)
         orcc  #IntMasks stop interrupts

         IFEQ  TkPerSec-50
         ldb   <D.VIDMD    get video mode register copy
         orb   #$08        set 50 Hz VSYNC bit
         stb   <D.VIDMD    save video mode register copy
         stb   >$FF98      set 50 Hz VSYNC
         ENDC

         sta   1,x enable DDRA
         sta   ,x set port A all inputs
         sta   3,x enable DDRB
         coma
         sta   2,x set port B all outputs
         ldd   #$343C [A]=PIA0 CRA contents, [B]=PIA0 CRB contents
         sta   1,x CA2 (MUX0) out low, port A, disable HBORD high-to-low IRQs
         stb   3,x CB2 (MUX1) out low, port B, disable VBORD low-to-high IRQs
         lda   ,x clear possible pending PIA0 HBORD IRQ
         lda   2,x clear possible pending PIA0 VBORD IRQ

* Don't need to explicitly read RTC during initialization
         ldd   #59*256+TkPerTS last second and time slice in minute
         std   <D.Sec      Will prompt RTC read at next time slice

         stb   <D.TSlice set ticks per time slice
         stb   <D.Slice set first time slice
         leax  SvcIRQ,pcr set IRQ handler
         stx   <D.IRQ
         leax  SvcVIRQ,pcr set VIRQ handler
         stx   <D.VIRQ
         leay  NewSvc,pcr insert syscalls
         os9   F$SSvc
         lda   <D.IRQER get shadow GIME IRQ enable register
         ora   #$08 set VBORD bit
         sta   <D.IRQER save shadow register
         sta   >IRQEnR enable GIME VBORD IRQs

*
* RTC-specific initializations here
*
         IFNE  RTCDsto4
         ldx   M$Mem,pcr
         ldd   #$010F    Set mode for RTC chip
         stb   1,x
         sta   ,x
         ldd   #$0504
         sta   ,x
         stb   ,x
         ENDC

         puls  cc,pc recover IRQ enable status and return

         emod
len      equ *
         end
