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
RTC.Base equ   $4004      We map the clock into this addr
RTC.Zero equ   -4         Send zero bit by writing this offset
RTC.One  equ   -3         Send one bit by writing this offset
RTC.Read equ   0          Read data from this offset
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
         mod   len,name,Systm+Objct,ReEnt+0,JmpTable,RTC.Base

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

*
* Vavasour / Collyer Emulator (ignores MPI slot)
*
         IFNE  RTCJVEmu
         ldx   #RTC.Base
         clr   ,-s
         lda   ,x           get century
         cmpa  #19
         bls   cnt
         lda   #100
         sta   ,s
cnt      lda   4,x
         IFNE  Level-1
         sta   <D.Daywk
         ENDC
         lda   1,x         get decade/year
         adda  ,s+         add in century
         ldb   2,x         get month
         std   <D.Year     tell OS-9
         IFNE  H6309
         ldq   3,x         get all time values
         stq   <D.Day
         ELSE
         lda   3,x         get day
         sta   <D.Day
         ldd   5,x         get hour/minute
         std   <D.Hour
         lda   7,x
         sta   <D.Sec
         ENDC
         rts
         ENDC

*
* MESS time update in Disto mode (ignores MPI)
*   Assumes that PC clock is in AM/PM mode!!!
*
         IFNE  RTCMESSEmu
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
         rts
         ENDC

*
* Eliminator time update  (lacks MPI slot select ability)
*
         IFNE  RTCElim   
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

*
* Disto 2-in-1 RTC time update
*
         IFNE  RTCDsto2  
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

*
* Disto 4-in-1 RTC time update
*
         IFNE  RTCDsto4  
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


*
* Update time from DriveWire
*
         IFNE  RTCDriveWire

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

*
* Update time from B&B RTC
*
         IFNE  RTCBB+RTCCloud9
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


*
* Update time from Smartwatch RTC
*
         IFNE  RTCSmart  
         pshs  cc        
         orcc  #IntMasks  Disable interrupts
         lda   >MPI.Slct  Get MPI slot
         ldb   <$90       Get GIME shadow of $FF90
         pshs  b,a       
         anda  #$F0      
         ora   >SlotSlct,pcr Get new slot to select
         anda  #$03       *** TEST ***
         sta   >MPI.Slct  And select it
         andb  #$FC      
         stb   >$FF90     ROM mapping = 16k internal, 16k external
         ldb   >$FFA2     Read GIME for $4000-$5fff
         pshs  b         
         lda   #$3E      
         sta   >$FFA2     Put block $3E at $4000-$5fff
         clr   >$FFDE     Map RAM/ROM, to map in external ROM
         lbsr  SendMsg    Initialize clock
         ldx   #D.Sec     Start with seconds
         lda   #$08      
         sta   ,-s        Set up loop counter = 8
L021E    ldb   #$08      
L0220    lda   >RTC.Read+RTC.Base Read one bit
         lsra            
         ror   ,x         Put bit into time
         decb             End of bit loop
         bne   L0220     
         lda   ,s         Check loop counter
         cmpa  #$08      
         beq   L023D      Fill "seconds" twice (ignore 1st value)
         cmpa  #$04      
         bne   L0239     
         ldb   ,x         Save 4th value read at $34 (day of week?)
         stb   $0A,x     
         bra   L023D      And overwrite "day" with day
L0239    leax  -$01,x     Go to next time to read
         bsr   BCD2Dec    Convert 1,x from BCD to decimal
L023D    dec   ,s        
         bne   L021E      End of loop for reading time
         leas  $01,s      Done with loop counter
         clr   >$FFDF     Map all RAM
         puls  b         
         stb   >$FFA2     Put back original memory block
         puls  b,a       
         sta   >MPI.Slct 
         stb   >$FF90     Restore original ROM mapping
         puls  cc,pc      Re-enable interrupts

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
         lda   >RTC.Read+RTC.Base Tell clock we're going to start???
         lda   #$08      
         sta   ,-s        Store counter = 8
L006B    ldb   #$08       Start of outer loop, 8 bytes to send
         lda   ,x+        Get byte to send
L006F    lsra             Start of inner loop, 8 bits to send
         bcs   L0077     
         tst   >RTC.Zero+RTC.Base Send a "zero" bit
         bra   L007A     
L0077    tst   >RTC.One+RTC.Base Send a "one" bit
L007A    decb            
         bne   L006F      End of inner loop
         dec   ,s         End of outer loop
         bne   L006B     
         puls  pc,a      

         ENDC            

*
* Update time from Harris RTC 
*
         IFNE  RTCHarrs  
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
*
*
* Software time update
*
*

         IFNE  RTCSoft   
         lda   <D.Min     grab current minute
         inca             minute+1
         cmpa  #60        End of hour?
         blo   UpdMin     no, Set start of minute
         ldd   <D.Day     get day, hour
         incb             hour+1
         cmpb  #24        End of Day?
         blo   UpdHour    ..no
         inca             day+1
         leax  months-1,pcr point to months table with offset-1: Jan = +1
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
         ENDC            

months   fcb   31,28,31,30,31,30,31,31,30,31,30,31 Days in each month


SetTime  equ   *         
*
* Set Eliminator RTC from D.Time
*
         IFNE  RTCElim   
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

*
* Set Disto 2-in-1 RTC from Time variables
*
         IFNE  RTCDsto2  
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

*
* Set Disto 4-in-1 RTC from Time variables
*
         IFNE  RTCDsto4  
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

*
* Set B&B RTC from Time variables
*
         IFNE  RTCBB+RTCCloud9
         pshs  u,y,cc    
         leay  SendBCD,pcr Send bytes of clock
         lbra  TfrTime   
         ENDC            

*
* Set Harris 1770 RTC from Time variables
*
         IFNE  RTCHarrs  
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

         rts             

         emod            
len      equ   *         
         end             
