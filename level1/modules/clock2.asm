********************************************************************
* Clock2 - Real-Time Clock Subroutines
*
* $Id$
*
* Edt/Rev  YYYY/MM/DD  Modified by
* Comment
* ------------------------------------------------------------------
*   1      2003/08/18  Boisy G. Pitre
* Stripped from clock.asm in order to modularize clocks.
*
*          2004/7/13   Robert Gault
* Added Vavasour/Collyer emulator & MESS (Disto) versions and relocated
* 'GetTime equ'   statement so it is not within a chip heading.
*
*          2004/7/28   Robert Gault
* Complete rewrite of SmartWatch segment which would never have worked.
* See previous versions for old code if desired. Routine now will search
* through all MPI slots to find clock and accept either AM/PM or military
* time. User notified if clock not found or data memory not available.
*
* Initialization routine contains code that bypasses OS-9 system calls to
* acquire needed low RAM that can't become ROM. This type of code is not
* recommended in most cases but nothing else was usable.
*          2004/7/31   Robert Gault
* Added a settime routine and changed "no clock found" routine. If the
* clock is not found, the D.Time entries are cleared but no message is sent.
* Date -t will never get passed one minute.
*          2004/7/31   Rodney Hamilton
* Improved RTCJVEmu code, conditionalized RTC type comments.

         nam   Clock2    
         ttl   Real-Time Clock Subroutines

         ifp1            
         use   defsfile  
         endc            

*
* Setup for specific RTC chip
*
         IFNE  RTCJVEmu
RTC.Base equ   $FFC0
         ENDC

         IFNE  RTCMESSEmu
RTC.Base equ   $FF50
         ENDC

         IFNE  RTCDriveWire
RTC.Base equ   $0000     
         ENDC            

         IFNE  RTCElim   
RTC.Sped equ   $20        32.768 KHz, rate=0
RTC.Strt equ   $06        binary, 24 Hour, DST disabled
RTC.Stop equ   $86        bit 7 set stops clock to allow setting time
RTC.Base equ   $FF72      I don't know base for this chip.
         ENDC            

         IFNE  RTCDsto2+RTCDsto4
RTC.Base equ   $FF50      Base address of clock
         ENDC            

         IFNE  RTCBB+RTCCloud9
         IFNE  RTCBB     
RTC.Base equ   $FF5C      In SCS* Decode
         ELSE            
RTC.Base equ   $FF7C      Fully decoded RTC
         ENDC            
RTC.Zero equ   -4         Send zero bit by writing this offset
RTC.One  equ   -3         Send one bit by writing this offset
RTC.Read equ   0          Read data from this offset
         ENDC            

         IFNE  RTCSmart  
RTC.Base equ   $C000      clock mapped to $C000-$DFFF; $FFA6 MMU slot
RTC.Zero equ   0          Send zero bit
RTC.One  equ   1          Send ones bit
RTC.Read equ   4
*D.SWPage equ   $1F        on system DP
D.RTCSlt equ   0          on SmartWatch ?data? page
D.RTCFlg equ   1          on SW page
D.RTCMod equ   2
D.Temp   equ   3          on SW page, holds "clock" data
D.Start  equ   4          on SW page, code starts here
         ENDC            

         IFNE  RTCHarrs  
RTC.Base equ   $FF60      Base address for clock
         ENDC            

         IFNE  RTCSoft   
RTC.Base equ   0          Have to have one defined.
         ENDC            

*------------------------------------------------------------
*
* Start of module
*
         mod   len,name,Sbrtn+Objct,ReEnt+0,JmpTable,RTC.Base

name     fcs   "Clock2"  
         fcb   1         

         IFNE  MPIFlag   
SlotSlct fcb   MPI.Slot-1 Slot constant for MPI select code
         ENDC            

* Jump table for RTC
*
* Entry points:
*  - Init
*  - SetTime
*  - GetTime
JmpTable                 
         lbra  Init      
         bra   GetTime   
         nop             
         lbra  SetTime   

*
* GetTime Subroutine
*
* This subroutine is called by the main clock module.
*

GetTime  equ   *

         IFNE  RTCJVEmu
*
* Vavasour / Collyer Emulator (ignores MPI slot)
*
         ldx   #RTC.Base
         ldd   ,x	get year (CCYY)
         suba  #20
         bmi   yr1	19xx, OK as is
yr0      addb  #100	20xx adjustment
         deca		also check for
         bpl   yr0	21xx (optional)
yr1      stb   <D.Year	set year (~YY)
         ldd   2,x	get date
         std   <D.Month	set date (MMDD)
         IFNE  Level-1
         ldd   4,x	get time (wwhh)
         sta   <D.Daywk	set day of week
         ELSE
         ldb   5,x	get hour (hh)
         ENDC
         stb   <D.Hour	set hour (hh)
         ldd   6,x	get time (mmss)
         std   <D.Min	set time (mmss)
*        rts		fall thru to Setime/Init rts
         ENDC

         IFNE  RTCMESSEmu
*
* MESS time update in Disto mode (ignores MPI)
*   Assumes that PC clock is in AM/PM mode!!!
*
         ldx   #RTC.Base
         ldy   #D.Time
         ldb   #12           counter for data
         stb   1,x
         lda   ,x
         anda  #7
         IFNE  Level-1
         sta   <D.Daywk
         ENDC
         decb
         bsr   getval
         lda   -1,y
         cmpa  #70          if >xx70 then its 19xx
         bhi   not20
         adda  #100
         sta   -1,y
not20    bsr   getval       month
         bsr   getval       day
         lda   #7           AM/PM mask
         stb   1,x
         anda  ,x
         bitb  #4
         pshs  cc
         anda  #3
         bsr   getval1
         puls  cc
         beq   AM
         lda   #12         convert to 24hr time as it is PM
         adda  -1,y
         sta   -1,y
AM       bsr   getval      minute
* and now fall through into get second
getval   lda   #$0f
         stb   1,x
         anda  ,x
getval1  decb
         pshs  b
         ldb   #10
         mul
         stb   ,y
         puls  b
         stb   1,x
         decb
         lda   ,x
         anda  #$0f
         adda  ,y
         sta   ,y+
*        rts		fall thru to Setime/Init rts
         ENDC

         IFNE  RTCElim   
*
* Eliminator time update  (lacks MPI slot select ability)
*
         ldx   M$Mem,pcr  get RTC base address from fake memory requirement
         ldb   #$0A       UIP status register address
         stb   ,x         generate address strobe
         lda   1,x        get UIP status
         bpl   NoUIP      Update In Progress, go shift next RTC read
         lda   #TkPerSec/2 set up next RTC read attempt in 1/2 second
         sta   <D.Tick    save tick
         bra   UpdTExit   and return

NoUIP    decb             year register address
         stb   ,x         generate address strobe
         lda   1,x        get year
         sta   <D.Year   
         decb             month register address
         stb   ,x        
         lda   1,x       
         sta   <D.Month  
         decb             day of month register address
         stb   ,x        
         lda   1,x       
         sta   <D.Day    
         ldb   #4         hour register address
         stb   ,x        
         lda   1,x       
         sta   <D.Hour   
         ldb   #2         minute register address
         stb   ,x        
         lda   1,x       
         sta   <D.Min    
         clrb             second register address
         stb   ,x        
         lda   1,x       
SaveSec  sta   <D.Sec    
UpdTExit rts             
         ENDC            

         IFNE  RTCDsto2  
*
* Disto 2-in-1 RTC time update
*
         pshs  a,cc       Save old interrupt status and mask IRQs
         bsr   RTCPre    

         bsr   GetVal     Get Year
         bsr   GetVal     Get Month
         bsr   GetVal     Get Day
         decb             ldb #5
         stb   2,x       
         decb            
         lda   ,x        
         anda  #3        
         bsr   GetVal1    Get Hour
         bsr   GetVal     Get Minute
         bsr   GetVal     Get Second

RTCPost  clr   >$FFD9     2 MHz  (Really should check $A0 first)
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
         stb   >MPI.Slct  Select MPak slot for clock
         ENDC            

         ldy   #D.Time   
         ldx   M$Mem,pcr 
         clr   1,x       
         ldb   #12       
         clr   >$FFD8     1 MHz
         rts             

GetVal   stb   2,x       
         decb            
         lda   ,x         read tens digit from clock
         anda  #$0f      
GetVal1  pshs  b          save b
         ldb   #10       
         mul              multiply by 10 to get value
         stb   ,y         save 10s value
         puls  b          set up clock for ones digit
         stb   2,x       
         decb            
         lda   ,x         read ones digit from clock
         anda  #$0f      
         adda  ,y         add ones + tens
         sta   ,y+        store clock value into time packet
         rts             

         ENDC            

         IFNE  RTCDsto4  
*
* Disto 4-in-1 RTC time update
*
         IFNE  MPIFlag   
         pshs  cc         Save old interrupt status and mask IRQs
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
         bsr   GetVal     Get Year
         bsr   GetVal     Get Month
         bsr   GetVal     Get Day
         lda   #3         Mask tens digit of hour to remove AM/PM bit
         bsr   GetVal1    Get Hour
         bsr   GetVal     Get Minute
         bsr   GetVal     Get Second

         IFNE  MPIFlag   
         puls  b          Restore saved "currently" selected MPak slot
         stb   >MPI.Slct 
         puls  cc,pc      Restore previous IRQ status
         ELSE            
         rts              No MPI, don't need to mess with slot, CC
         ENDC            

GetVal   lda   #$0f       Mask to apply to tens digit
GetVal1  stb   1,x       
         decb            
         anda  ,x         read ones digit from clock
         pshs  b          save b
         ldb   #10       
         mul              multiply by 10 to get value
         stb   ,y         Add to ones digit
         puls  b         
         stb   1,x       
         decb            
         lda   ,x         read tens digit from clock and mask it
         anda  #$0f      
         adda  ,y        
         sta   ,y+       
         rts             

         ENDC            

         IFNE  RTCDriveWire
*
* Update time from DriveWire
*
         lbra  DoDW      

         use   bbwrite.asm

DoDW     pshs  y,x,cc    
         lda   #'#        Time packet
         orcc  #IntMasks  Disable interrupts
         lbsr  SerWrite  
         bsr   SerRead    Read year byte
         bcs   UpdLeave  
         sta   <D.Year   
         bsr   SerRead    Read month byte
         bcs   UpdLeave  
         sta   <D.Month  
         bsr   SerRead    Read day byte
         bcs   UpdLeave  
         sta   <D.Day    
         bsr   SerRead    Read hour byte
         bcs   UpdLeave  
         sta   <D.Hour   
         bsr   SerRead    Read minute byte
         bcs   UpdLeave  
         sta   <D.Min    
         bsr   SerRead    Read second byte
         bcs   UpdLeave  
         sta   <D.Sec    
         bsr   SerRead    Read day of week (0-6) byte
UpdLeave puls  cc,x,y,pc 

         use   bbread.asm

         ENDC            

         IFNE  RTCBB+RTCCloud9
*
* Update time from B&B RTC
*
         pshs  u,y,cc    
         leay  ReadBCD,pcr Read bytes of clock

TfrTime  orcc  #IntMasks  turn off interrupts
         ldu   M$Mem,pcr  Get base address

         IFNE  MPIFlag   
         ldb   >MPI.Slct  Select slot
         pshs  b         
         andb  #$F0      
         orb   SlotSlct,pcr
         stb   >MPI.Slct 
         ENDC            

         lbsr  SendMsg    Initialize clock
         ldx   #D.Sec    
         ldb   #8         Tfr 8 bytes

tfrloop  jsr   ,y         Tfr 1 byte

         bitb  #$03      
         beq   skipstuf   Skip over day-of-week, etc.
         leax  -1,x      
skipstuf decb            
         bne   tfrloop   

         IFNE  MPIFlag   
         puls  b         
         stb   >MPI.Slct  restore MPAK slot
         ENDC            

         puls  u,y,cc,pc 

ClkMsg   fcb   $C5,$3A,$A3,$5C,$C5,$3A,$A3,$5C
* Enable clock with message $C53AA35CC53AA35C
SendMsg  lda   RTC.Read,u Send Initialization message to clock
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
         ldb   #$80       High bit will rotate out after we read 8 bits
readbit  lda   RTC.Read,u Read a bit
         lsra            
         rorb             Shift it into B
         bcc   readbit    Stop when marker bit appears
         tfr   b,a       
         bra   BCDEnter   Convert BCD number to Binary
BCDLoop  subb  #6         by subtracting 6 for each $10
BCDEnter suba  #$10      
         bhs   BCDLoop   
         stb   ,x        
         puls  b,pc      

         ENDC            

SetTime  equ   *
         IFNE  RTCSmart
*
* Update time from Smartwatch RTC
*
* This set time routine forces military time. It can't turn off clock but can
* be used as a timer if time set to 0:0:0  hr:min:sec
         pshs  cc,d,x,y,u
         orcc  #$50
         lda   D.SWPage
         clrb
         tfr   d,u         point to working space
         lda   $FF7F
         pshs  a
         lda   D.RTCSlt,u  info for MPI slot
         sta   $FF7F
         lda   #-1
         sta   D.RTCMod,u  indicate set time rather than read
         IFGT  Level-1
         ldx   #D.Slice
         ELSE
         ldx   #D.TSec
         ENDC
         tfr   u,y                          get location of safe region
         leay  >D.Start+alrtend-reloc,y     point to end of wakeup code
         lda   ,-x                          get D.Time data and store it
         ldb   #4                           convert tenths sec, sec, min, hours
         lbsr  binbcd                       to binary coded decimal
         IFGT  Level-1
         lda   D.Daywk
         ELSE
         clra
         ENDC
         sta  ,y+                           set day of week if present
         lda  ,x
         ldb  #3                            convert day of month, month, year
         bsr  binbcd                        to BCD
         jsr   >D.Start,u                   send data to clock
         lbra  exit
         
mem_mes  fcc   /There is no system memory for/
         fcb   $0a
         fcc   /the SmartWatch. Please reduce/
         fcb   $0a
         fcc   /os9boot size or use soft clock./
         fcb   $0d

Read     pshs  cc,d,x,y,u
         orcc  #$50
         lda   D.SWPage
         clrb
         tfr   d,u         point to working space
         lda   $FF7F
         pshs  a
         lda   D.RTCSlt,u  info for MPI slot
         sta   $FF7F
         clr   D.RTCMod,u  set for read time
         jsr   D.Start,u   jsr to it
         lbra  exit

binbcd   pshs b
bcd3     clrb
bcd1     cmpa #10
         bcs  bcd2
         addd #$f610      decrease bin regA by 10 add bcd $10 to regB
         bra  bcd1
bcd2     pshs a
         addb ,s+         add in remainder; BCD = binary when less than 10
         stb  ,y+         place in message to clock
         lda  ,-x         get next byte of D.Time
         dec  ,s          decrease counter
         bne  bcd3
         puls b,pc
         
* This becomes D.Start
reloc    equ   *
         IFGT  Level-1
         lda   D.HINIT
         anda  #$CC
         sta   $FF90
         ENDC
         ldb   $FFA6       choose to use normal location
         pshs  b
         ldb   #$3E
         stb   $FFA6       reset MMU for clock
         sta   $FFDE
         ldd   #RTC.Base
         tfr   a,dp        DP now points to clock
         tst   D.RTCMod,u  are we reading the clock or setting it?
         beq   findclk     go if reading
         lbsr  wakeup      we are setting a found clock
         lbra  found
findclk  lbsr  wakeup      wakeup the clock
*         IFGT  Level-1
         ldx   #D.Sec      one incoming byte dropped
*         ELSE
*         ldx   #$58        Level1 D.Sec
*         ENDC
         lda   #8          bytes to get
         pshs  a
L0050    ldb   #8
L0052    lsr   <RTC.Read   get a bit
         rora
         decb  
         bne   L0052
         tst   D.RTCFlg,u
         bne   maybe
         cmpa  D.Temp,u
         beq   maybe       clock might look like ROM
         inc   D.RTCFlg,u  found the clock
maybe    sta   ,x          transfer it to time
         lda   ,s          check loop counter
         cmpa  #8
         beq   L006F       skip if 0.1 sec
         cmpa  #4
         bne   L006B       skip if not day of week
         IFGT  Level-1
         lda   ,x          move to correct location
         anda  #7
         sta   D.Daywk-D.Day,x
         ENDC
         bra   L006F
L006B    cmpa  #5          hour byte
         bne   wd
         lda   ,x
         bita  #%10000000  12/24hr
         beq   wd
         bita  #%00100000  AM/PM
         pshs  cc
         anda  #%00011111  keep only time
         puls  cc
         bne   pm
         cmpa  #$12        these are BCD tests
         bne   am
         clr   ,x          12AM=0hr military
         bra   wd
pm       cmpa  #$12        12PM=12hr military
         beq   wd
         adda  #$12        1-11PM add 12 for military
am       sta   ,x
wd       leax  -1,x        update time slot
         bsr   L0087       convert from BCD to binary
L006F    dec   ,s
         bne   L0050       get the next byte from clock
         lda   1,x         get year
         cmpa  #50         half assed test for century
         bhs   c19
         adda  #100        make it 20th
c19      sta   1,x
         leas  1,s
         tst   D.RTCFlg,u
         bne   found
         ldb   D.RTCSlt,u
         bitb  #$30
         beq   found
         subb  #$10        not found so move to next slot
         stb   D.RTCSlt,u
         stb   $FF7F
         bra   findclk
found    clra              system DP is always 0
         tfr   a,dp
         IFGT  Level-1
         lda   D.HINIT     reset system before rts
         sta   $FF90
         ENDC
         sta   $FFDF
         puls  a
         sta   $FFA6
         rts               go back to normal code location
         
* Convert BCD to binary
L0087    lda   1,x
         clrb  
L008A    cmpa  #$10        BCD 10
         bcs   L0094
         addd  #$F00A      decrease BCD by $10 and add binary 10
         bra   L008A
L0094    pshs  a
         addb  ,s+
         stb   1,x
term     rts   

wakeup   lda   <RTC.Read   clear the clock for input
* When getting time data, bit0 is rotated into a full byte. This
* means the result is $00 or $FF for ROM. Any other value used for a test
* will give a false positive for the clock.
         clrb
         bita  #1
         beq   w1
         comb
w1       stb   D.Temp,u
         leax  alert,pcr   point to message
nxtbyte  ldb   #8          8 bytes to send
         lda   ,x+
         cmpa  #-1         changed from 0 terminator to -1 to accomodate
         beq   term        settime
nxtbit   lsra              bits sent to clock by toggling
         bcs   high        Zero and One
         cmpa  <RTC.Zero   faster than tst
         bra   nxtbit2
high     cmpa  <RTC.One
nxtbit2  decb  
         bne   nxtbit
         bra   nxtbyte

* SmartWatch wakeup sequence
alert    fcb   $c5,$3a,$a3,$5c,$c5,$3a,$a3,$5c
* The next 8 bytes become time data when setting the clock. Terminator is
* now $FF instead of $00 to permit $00 as data.
alrtend  fcb   $FF
alrtime  rmb   7
         fcb   $FF

exit     equ   *
         puls  a
         sta   $FF7F       restore MPI
         tst   D.RTCFlg,u  was clock found?
         beq   noclock
         puls  cc,d,x,y,u,pc

noclock  equ   *
         ldd   #7          seven time bytes to clear
         ldx   #D.Time
         IFGT  Level-1
         sta   D.Daywk
         ENDC
nc       sta   ,x+
         decb
         bne   nc
         puls  cc,d,x,y,u,pc
         ENDC

         IFNE  RTCHarrs  
*
* Update time from Harris RTC 
*
         pshs  cc        
         orcc  #IntMasks  Disable interrupts

         ldu   M$Mem,pcr  Get base address
         ldy   #D.Time    Pointer to time in system map

         lda   #%00001100 Init command register (Normal,Int. Disabled,
         sta   $11,u      Run,24-hour mode, 32kHz)

         lda   ,u         Read base address to set-up clock regs for read
         lda   6,u        Get year
         sta   ,y+       
         lda   4,u        Get month
         sta   ,y+       
         lda   5,u        Get day
         sta   ,y+       
         lda   1,u        Get hour
         sta   ,y+       
         lda   2,u        Get minute
         sta   ,y+       
         lda   3,u        Get second
         sta   ,y+       

         puls  cc,pc      Re-enable interrupts
         ENDC            

         IFNE  RTCSoft   
*
*
* Software time update
*
*
         lda   <D.Min     grab current minute
         inca             minute+1
         cmpa  #60        End of hour?
         blo   UpdMin     no, Set start of minute
         ldd   <D.Day     get day, hour
         incb             hour+1
         cmpb  #24        End of Day?
         blo   UpdHour    ..no
         inca             day+1
         leax  <months-1,pcr point to months table with offset-1: Jan = +1
         ldb   <D.Month   this month
         cmpa  b,x        end of month?
         bls   UpdDay     ..no, update the day
         cmpb  #2         yes, is it Feb?
         bne   NoLeap     ..no, ok
         ldb   <D.Year    else get year
         andb  #$03       check for leap year: good until 2099
         cmpd  #$1D00     29th on leap year?
         beq   UpdDay     ..yes, skip it
NoLeap   ldd   <D.Year    else month+1
         incb             month+1
         cmpb  #13        end of year?
         blo   UpdMonth   ..no
         inca             year+1
         ldb   #$01       set month to jan
UpdMonth std   <D.Year    save year, month
         lda   #$01       day=1st
UpdDay   clrb             hour=midnite
UpdHour  std   <D.Day     save day,hour
         clra             minute=00
UpdMin   clrb             seconds=00
         std   <D.Min     save min,secs
UpdTExit rts             

months   fcb   31,28,31,30,31,30,31,31,30,31,30,31 Days in each month
         ENDC            

         IFNE  RTCElim   
*
* Set Eliminator RTC from D.Time
*
         pshs  cc         save interrupt status
         orcc  #IntMasks  disable IRQs
         ldx   M$Mem,pcr  get RTC base address from fake memory requirement
         ldy   #D.Time    point [Y] to time variables in DP
         ldd   #$0B*256+RTC.Stop
         bsr   UpdatCk0   stop clock before setting it
         ldb   #RTC.Sped 
         bsr   UpdatCk0   set crystal speed, output rate
         bsr   UpdatClk   go set year
         bsr   UpdatClk   go set month
         bsr   UpdatClk   go set day of month
         bsr   UpdatCk0   go set day of week (value doesn't matter)
         bsr   UpdatCk0   go set hours alarm (value doesn't matter)
         bsr   UpdatClk   go set hour
         bsr   UpdatCk0   go set minutes alarm (value doesn't matter)
         bsr   UpdatClk   go set minute
         bsr   UpdatCk0   go set seconds alarm (value doesn't matter)
         bsr   UpdatClk   go set second
         ldd   #$0B*256+RTC.Strt
         bsr   UpdatCk0   go start clock
         puls  cc         Recover IRQ status
         clrb            
         rts             

UpdatClk ldb   ,y+        get data from D.Time variables in DP
UpdatCk0 std   ,x         generate address strobe, save data
         deca             set [A] to next register down
         rts             

         IFGT  Level-1
* OS-9 Level Two code only (for now)
NewSvc   fcb   F$NVRAM    Eliminator adds one new service call
         fdb   F.NVRAM-*-2
         fcb   $80        end of service call installation table

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
F.NVRAM  tfr   u,y        copy caller's register stack pointer
         ldd   #$0100     ask for one page
         os9   F$SRqMem  
         bcs   NVR.Exit   go report error...
         pshs  y,u        save caller's stack and data buffer pointers
         ldx   R$Y,y      get NVRAM start address
         cmpx  #50        too high?
         bhs   Arg.Err    yes, go return error...
         ldb   R$B,y      get NVRAM byte count
         beq   Arg.Err   
         abx              check end address
         cmpx  #50        too high?
         bhi   Arg.Err    yes, go return error...
         lda   R$A,y      get direction flag
         cmpa  #WRITE.    put caller's data into NVRAM?
         bne   ChkRead    no, go check if read...
         clra             [D]=byte count
         pshs  d          save it...
         ldx   <D.Proc    get caller's process descriptor address
         lda   P$Task,x   caller is source task
         ldb   <D.SysTsk  system is destination task
         ldx   R$X,y      get caller's source pointer
         puls  y          recover byte count
         os9   F$Move     go MOVE data
         bcs   NVR.Err   
         ldy   ,s         get caller's register stack pointer from stack
         lda   R$Y+1,y    get NVRAM start address
         adda  #$0E       add offset to first RTC NVRAM address
         ldb   R$B,y      get byte count
         ldx   M$Mem,pcr  get clock base address from fake memory requirement
         pshs  cc,b       save IRQ enable status and byte counter
         orcc  #IntMasks  disable IRQs
WrNVR.Lp ldb   ,u+        get caller's data
         std   ,x         generate RTC address strobe and save data to NVRAM
         inca             next NVRAM address
         dec   1,s        done yet?
         bne   WrNVR.Lp   no, go save another byte
         puls  cc,b       recover IRQ enable status and clean up stack
NVR.RtM  puls  y,u        recover register stack & data buffer pointers
         ldd   #$0100     return one page
         os9   F$SRtMem  
NVR.Exit rts             

Arg.Err  ldb   #E$IllArg  Illegal Argument error
         bra   NVR.Err   

ChkRead  cmpa  #READ.     return NVRAM data to caller?
         bne   Arg.Err    illegal access mode, go return error...
         lda   R$Y+1,y    get NVRAM start address
         adda  #$0E       add offset to first RTC NVRAM address
         ldx   M$Mem,pcr  get clock base address from fake memory requirement
         pshs  cc,b       save IRQ enable status and byte counter
         orcc  #IntMasks  disable IRQs
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
         ldb   P$Task,x   caller is source task
         lda   <D.SysTsk  system is destination task
         ldu   R$X,y      get caller's source pointer
         puls  y          recover byte count
         ldx   2,s        get data buffer (source) pointer
         os9   F$Move     go MOVE data
         bcc   NVR.RtM   
NVR.Err  puls  y,u        recover caller's stack and data pointers       
         pshs  b          save error code
         ldd   #$0100     return one page
         os9   F$SRtMem  
         comb             set       Carry for error
         puls  b,pc       recover error code, return...

         ENDC
         ENDC            

         IFNE  RTCDsto2  
*
* Set Disto 2-in-1 RTC from Time variables
*
         pshs  a,cc      
         lbsr  RTCPre     Initialize

         bsr   SetVal     Set Year
         bsr   SetVal     Set Month
         bsr   SetVal     Set Day
         ldd   #$0805     $08 in A, $05 in B
         bsr   SetVal1    Set Hour   (OR value in A ($08) with hour)
         bsr   SetVal     Set Minute
         bsr   SetVal     Set Second

         lbra  RTCPost    Clean up + return

SetVal   clra            
SetVal1  stb   2,x        Set Clock address
         decb            
         pshs  b         
         ldb   ,y+        Get current value
DvLoop   subb  #10        Get Tens digit in A, ones digit in B
         bcs   DvDone    
         inca            
         bra   DvLoop    
DvDone   addb  #10       
         sta   ,x         Store tens digit
         tfr   b,a       
         puls  b          Get back original clock address
         stb   2,x       
         decb            
         sta   ,x         Store ones digit
         rts             
         ENDC            

         IFNE  RTCDsto4  
*
* Set Disto 4-in-1 RTC from Time variables
*
         pshs  cc        
         orcc  #IntMasks 

         IFNE  MPIFlag   
         ldb   >MPI.Slct  Save currently selected MPak slot
         pshs  b         
         andb  #$F0      
         orb   >SlotSlct,pcr Get slot to select
         stb   >MPI.Slct  Select MPak slot for clock
         ENDC            

         ldy   #D.Time+6 
         ldx   M$Mem,pcr 
         clrb            
         bsr   SetVal     Set Second
         bsr   SetVal     Set Minute
         bsr   SetVal     Set Hour
         bsr   SetVal     Set Day
         bsr   SetVal     Set Month
         bsr   SetVal     Set Year

         IFNE  MPIFlag   
         puls  b          Restore old MPAK slot
         stb   >MPI.Slct 
         ENDC            

         puls  cc        
         clrb             No error
         rts             

SetVal   clr   ,-s        Create variable for tens digit
         lda   ,-y        Get current value
DvLoop   suba  #10        Get Tens digit on stack, ones digit in A
         bcs   DvDone    
         inc   ,s        
         bra   DvLoop    
DvDone   adda  #10       
         stb   1,x        Set Clock address
         incb            
         sta   ,x         Store ones digit
         stb   1,x       
         incb            
         puls  a         
         sta   ,x         Store tens digit
         rts             
         ENDC            

         IFNE  RTCBB+RTCCloud9
*
* Set B&B RTC from Time variables
*
         pshs  u,y,cc    
         leay  SendBCD,pcr Send bytes of clock
         lbra  TfrTime   
         ENDC            

         IFNE  RTCHarrs  
*
* Set Harris 1770 RTC from Time variables
*
         pshs  cc        
         orcc  #IntMasks  Disable interrupts

         ldu   M$Mem,pcr  Get base address
         ldy   #D.Time    Pointer to time in system map

         lda   #%00000100 Init command register (Normal,Int. Disabled,
         sta   $11,u      STOP clock,24-hour mode, 32kHz)

         lda   ,y+        Get year
         sta   6,u       
         lda   ,y+        Get month
         sta   4,u       
         lda   ,y+        Get day
         sta   5,u       
         lda   ,y+        Get hour
         sta   1,u       
         lda   ,y+        Get minute
         sta   2,u       
         lda   ,y         Get second
         sta   3,u       

         lda   #%00001100 Init command register (Normal,Int. Disabled,
         sta   $11,u      START clock,24-hour mode, 32kHz)

         puls  cc,pc      Re-enable interrupts
         ENDC            


*
* RTC-specific initializations here
*
Init     equ   *         
         IFNE  RTCDsto4  
* Disto 4-N-1 RTC specific initialization
         ldx   M$Mem,pcr 
         ldd   #$010F     Set mode for RTC chip
         stb   1,x       
         sta   ,x        
         ldd   #$0504    
         sta   ,x        
         stb   ,x        
         ENDC            

         IFNE  RTCElim   
         IFGT  Level-1
* Eliminator will install specific system calls
         leay  NewSvc,pcr insert syscalls
         os9   F$SSvc    
         ENDC
         ENDC            

         IFNE  RTCSmart
         clr   <D.SWPage        safe location for Read
         pshs  d,x,y,u
         IFGT  Level-1
         ldx   <D.SysMem        get memory map
         ldy   <D.SysDAT        get MMU map
         ldb   #$20             first 20 pages always in use
         abx                    point to page
A1       tst  ,x+
         beq   A2               found free page so go
         incb                   update page counter
         bpl   A1               still in RAM only, then go
A4       lda   #2               can't find RAM only memory
         leax  mem_mes,pcr
         ldy   #40
         os9   I$WritLn
         puls  d,x,y,u,pc
A2       pshs  b                save page #
         andb  #%11100000       modulo MMU blocks
         lsrb                   convert to DAT byte value
         lsrb                   page# * $100 / $2000 = MMU #
         lsrb                   $2000/$100=$20 at 2 bytes per MMU
         lsrb                   then page#/$10 gives answer
         ldd   b,y              get the MMU value
         cmpd  #$333E           is DAT unused
         pshs  cc               save answer
         inc   1,s              update page # for a used page
         puls  cc,b             get back answer and page #
         beq   A1               if unused keep going
         lda   #RAMinUse
         sta   ,-x              flag the memory in use
         ELSE
         ldx   <$20        D.FMBM     free memory bit map
         ldy   <$22        top of memory bit map
         ldb   #-1         preset counter
A1       lda   ,x+         get bits
         incb              update $800 counter
         pshs  y           test for end of map
         cmpx  ,s+
         bhi   A4          send error message
         clr   -1,s        preset bit counter
A2       inc   ,s
         lsra              read left to right
         bcs   A2
         lda   ,s+
         deca              convert to number of shifts
         cmpa  #8          overflow value
         beq   A1          get more map on ov
         pshs  a           save the number of shifts
         lda   #8          bytes*8
         mul
         addb  ,s          add modulo $800
         cmpb  #$7E        need RAM not ROM for clock data
         bhs   A4
         lda   #%10000000  need to create mask to map the
A5       lsra              unused bit, so reverse the process
         dec   ,s          decrease shift counter
         bne   A5
         leas  1,s         yank counter
         ora   -1,x        mark bit used and
         sta   -1,x        tell the system
         bra   A3          
A4       leas  1,s            yank bit info
         lda   #2             error path #
         leax  mem_mes,pcr    good memory not found
         ldy   #200
         os9   I$WritLn
         puls  d,x,y,u,pc
A3       equ   *
         ENDC
         stb   <D.SWPage      keep the info for Read
         tfr   b,a
         clrb
         tfr   d,x            regX now points to SW data page
         ldb   $FF7F          get MPI values
         andb  #3             keep IRQ info
         orb   #$30           force slot #4 to start search
         stb   D.RTCSlt,x     save the info
         clr   D.RTCFlg,x     set to no clock found
         clr   D.RTCMod,x     set to read time
         leax  D.Start,x      safe location for moved code
         IFNE  H6309
         leay  reloc,pcr
         ldw   #exit-reloc
         tfm   y+,x+
         ELSE
         leau  reloc,pcr       relocation routine to move code
         ldy   #exit-reloc     to a RAM only location
B3       lda   ,u+
         sta   ,x+
         leay -1,y
         bne   B3
         ENDC
         puls  d,x,y,u,pc
         ELSE
         rts             
         ENDC

         emod            
len      equ   *         
         end             
