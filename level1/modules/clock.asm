********************************************************************
* Clock - OS-9 System Clock
*
* CoCo 3 notes:
* Includes support for several different RTC chips, GIME Toggle
* IRQ fix, numerous minor changes.
*
* $Id$
*
* Edt/Rev  YYYY/MM/DD  Modified by
* Comment
* ------------------------------------------------------------------
*          ????/??/??
* NitrOS-9 2.00 distribution.
*
*   9r4    2003/01/01  Boisy G. Pitre
* Back-ported to OS-9 Level Two.
*
*   9r5    2003/08/18  Boisy G. Pitre
* Separated clock into Clock and Clock2 for modularity.
*
*   9r6    2003/09/04  Boisy G. Pitre
* Combined Level One and Level Two sources

         nam   Clock     
         ttl   OS-9 System Clock

         IFP1            
         use   defsfile  
         ENDC            

Edtn     equ   9
rev      equ   6 


*------------------------------------------------------------
*
* Start of module
*
         mod   len,name,Systm+Objct,ReEnt+rev,Init,0

name     fcs   "Clock"   
         fcb   Edtn      

         IFEQ  Level-1

*TkPerTS  equ   2          ticks per time slice
TkPerTS  equ   TkPerSec/10	ticks per time slice

NewSvc   fcb   F$Time
         fdb   FTime-*-2
         fcb   F$VIRQ
         fdb   FVIRQ-*-2
         fcb   F$STime
         fdb   FSTime-*-2
         fcb   $80

FSTime   ldx   R$X,u
         ldd   ,x
         std   <D.Year
	 ldd   2,x
	 std   <D.Day
	 ldd   4,x
	 std   <D.Min
         andcc #^Carry

*
* Call SetTime entry point in Clock2
*
         ldx   <D.Clock2  get entry point to Clock2
         jsr   $06,x      else call GetTime entry point

         rts

*
* Clock IRQ Entry Point
*
ClockIRQ clra
         tfr   a,dp                    set direct page to zero
         lda   PIA0Base+3              get hw byte
         bmi   L0032                   branch if sync flag on
         jmp   [>D.SvcIRQ]
L0032    lda   PIA0Base+2              clear interrupt?
         dec   <D.Tick                 decrement tick counter
         bne   L007F                   go around if not zero
         ldb   <D.Sec                  get minutes/seconds
* Seconds increment
         incb                          increment seconds
         cmpb  #60                     full minute?
         bcs   L0079                   nope...

*
* Call GetTime entry point in Clock2
*
         ldx   <D.Clock2  get entry point to Clock2
         jsr   $03,x      call GetTime entry point
         fcb   $8C		skip next 2 bytes

L0079    stb   <D.Sec                  update sec
L007B    lda   <D.TSec
         sta   <D.Tick
L007F    clra
         pshs  a
         ldy   <D.CLTb
         bra   L009E
L0087    ldd   ,x
         subd  #$0001
         bne   L009C
         lda   #$01
         sta   ,s
         lda   $04,x
         beq   L00B8
L0096    ora   #$01
         sta   $04,x
         ldd   $02,x
L009C    std   ,x
L009E    ldx   ,y++
         bne   L0087
         lda   ,s+
         beq   L00B4
         ldx   <D.Proc
         beq   L00AE
         tst   P$State,x
         bpl   L00BC                   branch if sysstate not set
L00AE    jsr   [>D.Poll]
         bcc   L00AE
L00B4    jmp   [>D.AltIRQ]
L00B8    bsr   L00DD
         bra   L0096
L00BC    leay  >L00C4,pcr
         jmp   [>D.URtoSs]
L00C4    jsr   [>D.Poll]
         bcc   L00C4
         ldx   <D.Proc
         ldb   P$State,x
         andb  #^SysState              turn off sysstate bit
         stb   P$State,x
         ldd   <P$SWI2,x
         std   <D.SWI2
         ldd   <D.UsrIRQ
         std   <D.SvcIRQ
         bra   L00B4
L00DD    pshs  y,x
L00DF    ldx   ,y++
         stx   -$04,y
         bne   L00DF
         puls  y,x
         leay  -2,y
         rts

FVIRQ    pshs  cc
         orcc  #FIRQMask+IRQMask
         ldy   <D.CLTb
         ldx   <D.Init
         ldb   PollCnt,x
         ldx   R$X,u
         beq   L0118
         tst   ,y
         beq   L010C
         subb  #$02
         lslb
         leay  b,y
         tst   ,y
         bne   L0128
L0106    tst   ,--y
         beq   L0106
         leay  $02,y
L010C    ldx   R$Y,u
         stx   ,y
         ldy   R$D,u
         sty   ,x
         bra   L0124
L0118    leax  R$Y,u
L011A    tst   ,y
         beq   L0124
         cmpx  ,y++
         bne   L011A
         bsr   L00DD
L0124    puls  cc
         clrb
         rts
L0128    puls  cc
         comb
         ldb   #E$Poll
         rts

Init     pshs  dp,cc
         clra
         tfr   a,dp

         leax  <Clock2,pcr
         lda   #Systm+Objct
         os9   F$Link    
         bcc   LinkOk    
         jmp   >$FFFE		reset
LinkOk   sty   <D.Clock2	save entry point
* Call Clock2 init routine
         jsr   ,y         call init entry point of Clock2


         lda   #TkPerSec

         sta   <D.TSec
         sta   <D.Tick

* Don't need to explicitly read RTC during initialization
         ldd   #59*256+TkPerTS last second and time slice in minute
         std   <D.Sec     Will prompt RTC read at next time slice

         stb   <D.TSlice
         stb   <D.Slice
         orcc  #FIRQMask+IRQMask       mask ints
         leax  >ClockIRQ,pcr
         stx   <D.IRQ
* install system calls
         leay  >NewSvc,pcr
         os9   F$SSvc
         ldx   #PIA0Base
         clra
         sta   1,x                     change PIA0Base side A to DDR
         sta   ,x                      clear PIA0Base side A
         sta   3,x                     change PIA0Base side B to DDR
         coma                          complement A side A
         sta   2,x                     write all 1's to PIA0Base side B
         lda   #$34
         sta   1,x                     PIA0Base side A to I/O reg
         lda   #$3F
         sta   3,x                     PIA0Base side B to I/O reg
         lda   2,x

         puls  pc,dp,cc


* F$Time system call code
FTime    ldx   R$X,u
         ldd   <D.Year
         std   ,x
         ldd   <D.Day
         std   2,x
         ldd   <D.Min
         std   4,x
         clrb
         rts




         ELSE




* OS-9 Level Two Clock

TkPerTS  equ   2          ticks per time slice
GI.Toggl equ   %00000001  GIME CART* IRQ enable bit, for CC3

* TC9 needs to reset more interrupt sources
*GI.Toggl equ %00000111 GIME SERINT*, KEYINT*, CART* IRQ enable bits


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
         fcb   $80        end of service call installation table

*---------------------------------------------------------
* IRQ Handling starts here.
*
* Caveat: There may not be a stack at this point, so avoid using one.
*         Stack is set up by the kernel between here and SvcVIRQ.
*
SvcIRQ   lda   >IRQEnR    Get GIME IRQ Status and save it.
         ora   <D.IRQS   
         sta   <D.IRQS   
         bita  #$08       Check for clock interrupt
         beq   NoClock   
         anda  #^$08      Drop clock interrupt
         sta   <D.IRQS   
         ldx   <D.VIRQ    Set VIRQ routine to be executed
         clr   <D.QIRQ    ---x IS clock IRQ
         bra   ContIRQ   

NoClock  leax  DoPoll,pcr If not clock IRQ, just poll IRQ source
         IFNE  H6309     
         oim              #$FF,<D.QIRQ    ---x set flag to NOT clock IRQ
         ELSE            
         lda   #$FF      
         sta   <D.QIRQ   
         ENDC            
ContIRQ  stx   <D.SvcIRQ 
         jmp   [D.XIRQ]   Chain through Kernel to continue IRQ handling

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
SvcVIRQ  clra             Flag if we find any VIRQs to service
         pshs  a         
         ldy   <D.CLTb    Get address of VIRQ table
         bra   virqent   

virqloop equ   *         
         IFGT  Level-2   
         ldd   2,y        Get Level 3 extended map type
         orcc  #IntMasks 
         sta   >$0643    
         stb   >$0645    
         std   >$FFA1    
         andcc  #^IntMasks
         ENDC            

         ldd   Vi.Cnt,x   Decrement tick count
         IFNE  H6309     
         decd             --- subd #1
         ELSE            
         subd  #$0001    
         ENDC            
         bne   notzero    Is this one done?
         lda   Vi.Stat,x  Should we reset?
         bmi   doreset   
         lbsr  DelVIRQ    No, delete this entry
doreset  ora   #$01       Mark this VIRQ as triggered.
         sta   Vi.Stat,x 
         lda   #$80       Add VIRQ as interrupt source
         sta   ,s        
         ldd   Vi.Rst,x   Reset from Reset count.
notzero  std   Vi.Cnt,x  
virqent  ldx   ,y++      
         bne   virqloop  

         IFGT  Level-2   
         puls  d         
         orcc  #Carry    
         stb   >$0643    
         stb   >$FFA1    
         incb            
         stb   >$0645    
         stb   >$FFA1    
         andcc  #^IntMasks
         ELSE            
         puls  a          Get VIRQ status flag: high bit set if VIRQ
         ENDC            

         ora   <D.IRQS    Check to see if other hardware IRQ pending.
         bita  #%10110111 Any V/IRQ interrupts pending?
         beq   toggle    
         IFGT  Level-2   
         lbsr  DoPoll     Yes, go service them.
         ELSE            
         bsr   DoPoll     Yes, go service them.
         ENDC            
         bra   KbdCheck  
toggle   equ   *         
         IFGT  Level-2   
         lbsr  DoToggle   No, toggle GIME anyway
         ELSE            
         bsr   DoToggle   No, toggle GIME anyway
         ENDC            

KbdCheck equ   *         
         IFGT  Level-2   
         lda   >$0643     grab current map type
         ldb   >$0645    
         pshs  d          save it
         orcc  #IntMasks  IRQs off
         lda   >$0660     SCF local memory ---x
         sta   >$0643     into DAT image ---x
         sta   >$FFA1     and into RAM ---x
         inca            
         sta   >$0645    
         sta   >$FFA2     map in SCF, CC3IO, WindInt, etc.
         ENDC            

         jsr   [>D.AltIRQ] go update mouse, gfx cursor, keyboard, etc.

         IFGT  Level-2   
         puls  d          restore original map type ---x
         orcc  #IntMasks 
         sta   >$0643     into system DAT image ---x
         stb   >$0645    
         std   >$FFA1     and into RAM ---x
         andcc  #$AF      
         ENDC            

         dec   <D.Tick    End of second?
         bne   VIRQend    No, skip time update and alarm check
         lda   #TkPerSec  Reset tick count
         sta   <D.Tick   

* ATD: Modified to call real time clocks on every minute ONLY.
         inc   <D.Sec     go up one second
         lda   <D.Sec     grab current second
         cmpa  #60        End of minute?
         blo   VIRQend    No, skip time update and alarm check
         clr   <D.Sec     Reset second count to zero

*
* Call GetTime entry point in Clock2
*
         ldx   <D.Clock2  get entry point to Clock2
         jsr   $03,x      call GetTime entry point

NoGet    ldd   >WGlobal+G.AlPID
         ble   VIRQend    Quit if no Alarm set
         ldd   >WGlobal+G.AlPckt+3 Does Hour/Minute agree?
         cmpd  <D.Hour   
         bne   VIRQend   
         ldd   >WGlobal+G.AlPckt+1 Does Month/Day agree?
         cmpd  <D.Month  
         bne   VIRQend   
         ldb   >WGlobal+G.AlPckt+0 Does Year agree?
         cmpb  <D.Year   
         bne   VIRQend   
         ldd   >WGlobal+G.AlPID
         cmpd  #1        
         beq   checkbel  
         os9   F$Send    
         bra   endalarm  
checkbel ldb   <D.Sec     Sound bell for 15 seconds
         andb  #$F0      
         beq   dobell    
endalarm ldd   #$FFFF    
         std   >WGlobal+G.AlPID
         bra   VIRQend   
dobell   ldx   >WGlobal+G.BelVec
         beq   VIRQend   
         jsr   ,x        
VIRQend  jmp   [>D.Clock] Jump to kernel's timeslice routine

*------------------------------------------------------------
* Interrupt polling and GIME reset code
*

*
* Call [D.Poll] until all interrupts have been handled
*
Dopoll                   
         IFGT  Level-2   
         lda   >$0643     Level 3: get map type
         ldb   >$0645    
         pshs  d          save for later
         ENDC            
Dopoll.i                 
         jsr   [>D.Poll]  Call poll routine
         bcc   DoPoll.i   Until error (error -> no interrupt found)

         IFGT  Level-2   
         puls  d         
         orcc  #IntMasks 
         sta   >$0643    
         stb   >$0645    
         std   >$FFA1    
         andcc  #^IntMasks
         ENDC            

*
* Reset GIME to avoid missed IRQs
*
DoToggle lda   #^GI.Toggl Mask off CART* bit
         anda  <D.IRQS   
         sta   <D.IRQS   
         lda   <D.IRQER   Get current enable register status
         tfr   a,b       
         anda  #^GI.Toggl Mask off CART* bit
         orb   #GI.Toggl  --- ensure that 60Hz IRQ's are always enabled
         sta   >IRQEnR    Disable CART
         stb   >IRQEnR    Enable CART
         clrb            
         rts             


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
         IFGT  Level-2   
         bra   FindVIRQ   ---x

v.loop   leay  4,y        ---x
         ENDC            
FindVIRQ ldx   ,y++       Is VIRQ entry null?
         beq   AddVIRQ    If yes, add entry here
         decb            
         bne   FindVIRQ  
         puls  cc        
         comb            
         ldb   #E$Poll   
         rts             

AddVIRQ                  
         IFGT  Level-2   
         ldx   R$Y,u     
         stx   ,y        
         lda   >$0643    
         ldb   >$0645    
         std   2,y       
         ELSE            
         leay  -2,y       point to first null VIRQ entry
         ldx   R$Y,u     
         stx   ,y        
         ENDC            
         ldy   R$D,u     
         sty   ,x        
         bra   virqexit  

         IFGT  Level-2   
v.chk    leay  4,y       
RemVIRQ  ldx   ,y        
         ELSE            
RemVIRQ  ldx   ,y++      
         ENDC            
         beq   virqexit  
         cmpx  R$Y,u     
         bne   RemVIRQ   
         bsr   DelVIRQ   
virqexit puls  cc        
         clrb            
         rts             

DelVIRQ  pshs  x,y       
DelVLup                  
         IFGT  Level-2   
         ldq              ,y++		move entries up in table
         leay  2,y       
         stq              -8,y
         bne   DelVLup   
         puls  x,y,pc    
         ELSE            
         ldx   ,y++       move entries up in table
         stx   -4,y      
         bne   DelVLup   
         puls  x,y       
         leay  -2,y      
         rts             
         ENDC            

         IFGT  Level-1
*------------------------------------------------------------
*
* Handle F$Alarm call
*
F.Alarm  ldx   #WGlobal+G.AlPckt
         ldd   R$D,u     
         bne   DoAlarm   
         std   G.AlPID-G.AlPckt,x Erase F$Alarm PID, Signal.
         rts             

DoAlarm  tsta             If PID != 0, set alarm for this process
         bne   SetAlarm  
         cmpd  #1         1 -> Set system-wide alarm
         bne   GetAlarm  
SetAlarm std   G.AlPID-G.AlPckt,x
         ldy   <D.Proc   
         lda   P$Task,y   Move from process task
         ldb   <D.SysTsk  To system task
         ldx   R$X,u      From address given in X
         ldu   #WGlobal+G.AlPckt
         ldy   #5         Move 5 bytes
         bra   FMove     

GetAlarm cmpd  #2        
         bne   AlarmErr  
         ldd   G.AlPID-G.AlPckt,x
         std   R$D,u     
         bra   RetTime   
AlarmErr comb            
         ldb   #E$IllArg 
         rts             
         ENDC

*------------------------------------------------------------
*
* Handle F$Time System call
*
F.Time   equ   *
         IFGT  Level-1
         ldx   #D.Time    Address of system time packet
RetTime  ldy   <D.Proc    Get pointer to current proc descriptor
         ldb   P$Task,y   Process Task number
         lda   <D.SysTsk  From System Task
         ldu   R$X,u     
STime.Mv ldy   #6         Move 6 bytes
FMove    os9   F$Move    
         ELSE
         ldx   R$X,u	get pointer to caller's space
         ldd   <D.Year	get year and month
         std   ,x
         ldd   <D.Day	get day and hour
         std   2,x
         ldd   <D.Min	get minute and second
         std   4,x
         clrb
         ENDC
         rts             

*------------------------------------------------------------
*
* Handle F$STime system call
*
* First, copy time packet from user address space to system time
* variables, then fall through to code to update RTC.
*
F.STime  equ  *
         IFGT  Level-1
         ldx   <D.Proc    Caller's process descriptor
         lda   P$Task,x   Source is in user map
         ldx   R$X,u      Address of caller's time packet
         ldu   #D.Time    Destination address
         ldb   <D.SysTsk  Destination is in system map
         bsr   STime.Mv   Get time packet (ignore errors)
         ELSE
         ldx   R$X,u
         ldd   ,x
         std   <D.Year
         ldd   2,x
         std   <D.Day
         ldd   4,x
         std   <D.Min
         ENDC
         lda   #TkPerSec  Reset to start of second
         sta   <D.Tick   

*
* Call SetTime entry point in Clock2
*
         ldx   <D.Clock2  get entry point to Clock2
         jsr   $06,x      else call GetTime entry point

NoSet    rts             

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
Init     ldx   <D.Proc    save user proc
         pshs  x         
         ldx   <D.SysPrc  make sys for link
         stx   <D.Proc   

         leax  <Clock2,pcr
         lda   #Systm+Objct
         os9   F$Link    

* And here, we restore the original D.Proc value
         puls  x         
         stx   <D.Proc    restore user proc

         bcc   LinkOk    
         lda   #E$MNF    
         jmp   <D.Crash  
LinkOk   sty   <D.Clock2  save entry point
InitCont ldx   #PIA0Base  point to PIA0
         clra             no error for return...
         pshs  cc         save IRQ enable status (and Carry clear)
         orcc  #IntMasks  stop interrupts

         IFGT  Level-1
* Note: this code can go away once we have a rel_50hz
         IFEQ  TkPerSec-50
         ldb   <D.VIDMD   get video mode register copy
         orb   #$08       set 50 Hz VSYNC bit
         stb   <D.VIDMD   save video mode register copy
         stb   >$FF98     set 50 Hz VSYNC
         ENDC            
         ENDC

         sta   1,x        enable DDRA
         sta   ,x         set port A all inputs
         sta   3,x        enable DDRB
         coma            
         sta   2,x        set port B all outputs
         ldd   #$343C     [A]=PIA0 CRA contents, [B]=PIA0 CRB contents
         sta   1,x        CA2 (MUX0) out low, port A, disable HBORD high-to-low IRQs
         stb   3,x        CB2 (MUX1) out low, port B, disable VBORD low-to-high IRQs
         lda   ,x         clear possible pending PIA0 HBORD IRQ
         lda   2,x        clear possible pending PIA0 VBORD IRQ

* Don't need to explicitly read RTC during initialization
         ldd   #59*256+TkPerTS last second and time slice in minute
         std   <D.Sec     Will prompt RTC read at next time slice

         stb   <D.TSlice  set ticks per time slice
         stb   <D.Slice   set first time slice
         leax  SvcIRQ,pcr set IRQ handler
         stx   <D.IRQ    
         leax  SvcVIRQ,pcr set VIRQ handler
         stx   <D.VIRQ   
         leay  NewSvc,pcr insert syscalls
         os9   F$SSvc    
         IFGT  Level-1
* H6309 optimization opportunity here using oim
         lda   <D.IRQER   get shadow GIME IRQ enable register
         ora   #$08       set VBORD bit
         sta   <D.IRQER   save shadow register
         sta   >IRQEnR    enable GIME VBORD IRQs
         ENDC

* Call Clock2 init routine
         ldy   <D.Clock2  get entry point to Clock2
         jsr   ,y         call init entry point of Clock2
InitRts  puls  cc,pc      recover IRQ enable status and return

         ENDC


Clock2   fcs   "Clock2"  

         emod            
len      equ   *         
         end             
