********************************************************************
* Clock - NitrOS-9 System Clock
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
*
*   9r7    2004/11/27  Phill Harvey-Smith
* Fixed bug in init routine that was causing DP and CC to
* be pulled off the stack and stored in D.Proc under Level 1
*		
*   9r7    2005/01/17  Boisy G. Pitre
* Fixed incorrect value for PIA initialization.  Robert indicated
* that it should be $3434, not $3435.
*		
*   9r7    2005/04/08  Phill Harvey-Smith
* Made the above level dependent as having PIAs inited with $3434
* will disable the IRQ from them, this is ok for Level 2/CoCo 3 as the
* IRQ is later enabled from the GIME, however the CoCo 1,2 and Dragon
* do not posses a GIME so anything dependent on the clock tick will 
* hang. So changed to conditionaly compile based on level :-
*
*   9r8    2005/12/04  Boisy G. Pitre
* Minor code optimizations, fixed issue in Level 1 where clock ran slow
* due to improper initialization of certain system globals.
 
         nam   Clock     
         ttl   NitrOS-9 System Clock
                         
         ifp1            
         use   defsfile  
         ifgt  Level-1   
         use   cocovtio.d
         endc            
         endc            
                         
tylg     set   Systm+Objct
atrv     set   ReEnt+rev 
rev      set   8
edition  set   9         
                         
                         
*------------------------------------------------------------
*
* Start of module
*
         mod   len,name,tylg,atrv,init,0
                         
name     fcs   "Clock"   
         fcb   edition   
                         
                         
         ifeq  Level-1   
TkPerTS  equ   TkPerSec/10 ticks per time slice
         else            
TkPerTS  equ   2          ticks per time slice
         endc            
                         
*
* Table to set up Service Calls
*
NewSvc   fcb   F$Time    
         fdb   FTime-*-2 
         fcb   F$VIRQ    
         fdb   FVIRQ-*-2 
         ifgt  Level-1   
         fcb   F$Alarm   
         fdb   FALARM-*-2
         endc            
         fcb   F$STime   
         fdb   FSTime-*-2
         fcb   $80        end of service call installation table
                         
                         
*------------------------------------------------------------
*
* Handle F$STime system call
*
* First, copy time packet from user address space to system time
* variables, then fall through to code to update RTC.
*
FSTime   equ   *         
         ifgt  Level-1   
         ldx   <D.Proc    caller's process descriptor
         lda   P$Task,x   source is in user map
         ldx   R$X,u      address of caller's time packet
         ldu   #D.Time    destination address
         ldb   <D.SysTsk  destination is in system map
         lbsr  STime.Mv   get time packet (ignore errors)
         else            
         ldx   R$X,u     
         ldd   ,x        
         std   <D.Year   
         ldd   2,x       
         std   <D.Day    
         ldd   4,x       
         std   <D.Min    
         endc            
         lda   #TkPerSec  reset to start of second
         sta   <D.Tick   
         ldx   <D.Clock2  get entry point to Clock2
         clra             clear carry
         jmp   $06,x      and call SetTime entry point
                         
                         
*--------------------------------------------------
*
* Clock Initialization
*
* This vector is called by the kernel to service the first F$STime
* call.  F$STime is usually called by SysGo (with a dummy argument)
* in order to initialize the clock.  F$STime is re-vectored to the
* service code above to handle future F$STime calls.
*
*
                         
Clock2   fcs   "Clock2"  
                         
init                     
         ifeq  Level-1   
         pshs  dp,cc      save DP and CC
         clra            
         tfr   a,dp       set DP to zero
         else            
         ldx   <D.Proc    save user proc
         pshs  x         
         ldx   <D.SysPrc  make sys for link
         stx   <D.Proc   
         endc            
                         
         leax  <Clock2,pcr
         lda   #Sbrtn+Objct
         os9   F$Link    
                         
         bcc   LinkOk    
                         
         ifeq  Level-1   
         jmp   >$FFFE     level 1: jump to reset vector
         else            
         lda   #E$MNF    
         jmp   <D.Crash   level 2: jump to CRASH vector
         endc            
                         
LinkOk                   
         ifeq  Level-1   
         puls  cc,dp      ; Restore saved dp and cc
         else            
         puls  x         
         stx   <D.Proc    restore user proc
         endc            
                         
         sty   <D.Clock2  save entry point
InitCont                 
         ldx   #PIA0Base  point to PIA0
         clra             no error for return...
         pshs  cc         save IRQ enable status (and Carry clear)
         orcc  #IntMasks  stop interrupts
                         
         ifgt  Level-1   
* Note: this code can go away once we have a rel_50hz
         ifeq  TkPerSec-50
         ldb   <D.VIDMD   get video mode register copy
         orb   #$08       set 50 Hz VSYNC bit
         stb   <D.VIDMD   save video mode register copy
         stb   >$FF98     set 50 Hz VSYNC
         endc            
         endc            
                         
         sta   1,x        enable DDRA
         sta   ,x         set port A all inputs
         sta   3,x        enable DDRB
         coma            
         sta   2,x        set port B all outputs
                         
;	ldd	#$343C		[A]=PIA0 CRA contents, [B]=PIA0 CRB contents
                         
         ifgt  Level-1   
         ldd   #$3434     as per Robert Gault's suggestion
         else            
         ldd   #$3435     IRQ needs to be left enabled for Level1, as no GIME generated IRQ
         endif            
                         
         sta   1,x        CA2 (MUX0) out low, port A, disable HBORD high-to-low IRQs
         stb   3,x        CB2 (MUX1) out low, port B, disable VBORD low-to-high IRQs
                         
         ifgt  Level-1   
         lda   ,x         clear possible pending PIA0 HBORD IRQ
         endc            
         lda   2,x        clear possible pending PIA0 VBORD IRQ
                         
* Don't need to explicitly read RTC during initialization
         ldd   #59*256+$01 last second and last tick
         std   <D.Sec     will prompt RTC read at next time slice
         ifeq  Level-1
         ldb   #TkPerSec
         stb   <D.TSec    set ticks per second
         endc
         ldb   #TkPerTS   get ticks per time slice
         stb   <D.TSlice  set ticks per time slice
         stb   <D.Slice   set first time slice
         leax  SvcIRQ,pcr set IRQ handler
         stx   <D.IRQ    
                         
         ifgt  Level-1   
         leax  SvcVIRQ,pcr set VIRQ handler
         stx   <D.VIRQ   
         endc            
                         
         leay  NewSvc,pcr insert syscalls
         os9   F$SSvc    
                         
         ifgt  Level-1   
         ifne  H6309     
         oim              #$08,<D.IRQER
         else            
         lda   <D.IRQER   get shadow GIME IRQ enable register
         ora   #$08       set VBORD bit
         sta   <D.IRQER   save shadow register
         endc            
         sta   >IRQEnR    enable GIME VBORD IRQs
         endc            
                         
* Call Clock2 init routine
         ldy   <D.Clock2  get entry point to Clock2
         jsr   ,y         call init entry point of Clock2
InitRts  puls  cc,pc      recover IRQ enable status and return
                         
         ifeq  Level-1   
*
* Clock IRQ Entry Point
*
* For CoCo 1/2, called once every 16.667 milliseconds
SvcIRQ                   
         clra            
         tfr   a,dp       set direct page to zero
         tst   PIA0Base+3 get hw byte
         bmi   L0032      branch if sync flag on
         jmp   [>D.SvcIRQ] else service other possible IRQ
L0032    tst   PIA0Base+2 clear interrupt
         dec   <D.Tick    decrement tick counter
         bne   L007F      go around if not zero
         ldb   <D.Sec     get minutes/seconds
* Seconds increment
         incb             increment seconds
         cmpb  #60        full minute?
         bcs   L0079      nope...
*
* Call GetTime entry point in Clock2
*
         ldx   <D.Clock2  get entry point to Clock2
         jsr   $03,x      call GetTime entry point
         fcb   $8C        skip next 2 bytes
L0079    stb   <D.Sec     update sec
L007B    lda   <D.TSec    get ticks per second value
         sta   <D.Tick    and repopulate tick decrement counter
L007F    clra             clear A
         pshs  a          and save it on the stack
         ldy   <D.CLTb    get pointer to VIRQ Polling Entries
         bra   L009E      go to the processing portion of the loop
L0087    ldd   Vi.Cnt,x   get count down counter
         subd  #$0001     subtract tick count
         bne   L009C      branch if not at terminal count ($0000)
         lda   #$01      
         sta   ,s         set flag on stack to 1
         lda   Vi.Stat,x  get status byte
         beq   DelEntry   branch if zero (one shot, so delete)
L0096    ora   #Vi.IFlag  set interrupted flag
         sta   Vi.Stat,x  save in packet
         ldd   Vi.Rst,x   get reset count
L009C    std   Vi.Cnt,x   save tick count back
L009E    ldx   ,y++       get two bytes at Y
         bne   L0087      if not zero, branch
         lda   ,s+        else get byte off stack
         beq   GoAltIRQ   branch if zero
         ldx   <D.Proc    else get pointer to current process descriptor
         beq   L00AE      branch if none
         tst   P$State,x  test process' state
         bpl   UsrPoll    branch if system state not set
L00AE    jsr   [>D.Poll]  poll ISRs
         bcc   L00AE      keep polling until carry set
GoAltIRQ                 
         jmp   [>D.AltIRQ] jump into an alternate IRQ if available
DelEntry                 
         bsr   DelVIRQ    delete the VIRQ entry
         bra   L0096     
                         
UsrPoll  leay  >up@,pcr   point to routine to execute
         jmp   [>D.URtoSs] User to System
up@      jsr   [>D.Poll]  call polling routine
         bcc   up@        keep polling until carry set
         ldx   <D.Proc    get current process descriptor
         ldb   P$State,x  and its state
         andb  #^SysState turn off sysstate bit
         stb   P$State,x  save new state
         ldd   <P$SWI2,x 
         std   <D.SWI2   
         ldd   <D.UsrIRQ 
         std   <D.SvcIRQ 
         bra   GoAltIRQ  
                         
DelVIRQ  pshs  y,x        save off Y,X
dl@      ldx   ,y++       get next entry
         stx   -$04,y     move up
         bne   dl@        continue until all are moved
         puls  y,x        restore
         leay  -2,y       move back 2 from Y (points to last entry)
         rts              return
                         
* Install or Remove VIRQ Entry
FVIRQ    pshs  cc        
         orcc  #IntMasks  mask all interrupts
         ldy   <D.CLTb    get pointer to VIRQ polling table
         ldx   <D.Init    get pointer to init module
         ldb   PollCnt,x  get poll count
         ldx   R$X,u      get pointer to caller's X
         beq   L0118      branch if removing
         tst   ,y         entry available?
         beq   L010C     
         subb  #$02      
         lslb            
         leay  b,y       
         tst   ,y        
         bne   PTblFul    polling table full
L0106    tst   ,--y      
         beq   L0106     
         leay  $02,y     
L010C    ldx   R$Y,u     
         stx   ,y        
         ldy   R$D,u     
         sty   ,x        
         bra   L0124     
L0118    leax  R$Y,u      X = caller's Y
L011A    tst   ,y         end of VIRQ table
         beq   L0124      branch if so
         cmpx  ,y++       else compare to current VIRQ entry and inc Y
         bne   L011A      continue searching if not matched
         bsr   DelVIRQ    else delete entry
L0124    puls  cc        
         clrb            
         rts             
PTblFul  puls  cc        
         comb            
         ldb   #E$Poll   
         rts             
                         
                         
                         
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
                         
                         
                         
                         
         else            
                         
                         
                         
                         
* NitrOS-9 Level 2 Clock
                         
GI.Toggl equ   %00000001  GIME CART* IRQ enable bit, for CC3
                         
* TC9 needs to reset more interrupt sources
*GI.Toggl equ %00000111 GIME SERINT*, KEYINT*, CART* IRQ enable bits
                         
                         
*---------------------------------------------------------
* IRQ Handling starts here.
*
* Caveat: There may not be a stack at this point, so avoid using one.
*         Stack is set up by the kernel between here and SvcVIRQ.
*
SvcIRQ   lda   >IRQEnR    get GIME IRQ Status and save it.
         ora   <D.IRQS   
         sta   <D.IRQS   
         bita  #$08       check for clock interrupt
         beq   NoClock   
         anda  #^$08      drop clock interrupt
         sta   <D.IRQS   
         ldx   <D.VIRQ    set VIRQ routine to be executed
         clr   <D.QIRQ    ---x IS clock IRQ
         bra   ContIRQ   
                         
NoClock  leax  DoPoll,pcr if not clock IRQ, just poll IRQ source
         ifne  H6309     
         oim              #$FF,<D.QIRQ	---x set flag to NOT clock IRQ
         else            
         lda   #$FF      
         sta   <D.QIRQ   
         endc            
ContIRQ  stx   <D.SvcIRQ 
         jmp   [D.XIRQ]   chain through Kernel to continue IRQ handling
                         
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
SvcVIRQ  clra             flag if we find any VIRQs to service
         pshs  a         
         ldy   <D.CLTb    get address of VIRQ table
         bra   virqent   
                         
virqloop                 
         ifgt  Level-2   
         ldd   2,y        get Level 3 extended map type
         orcc  #IntMasks 
         sta   >$0643    
         stb   >$0645    
         std   >$FFA1    
         andcc  #^IntMasks
         endc            
                         
         ldd   Vi.Cnt,x   decrement tick count
         ifne  H6309     
         decd             --- subd #1
         else            
         subd  #$0001    
         endc            
         bne   notzero    is this one done?
         lda   Vi.Stat,x  should we reset?
         bmi   doreset   
         lbsr  DelVIRQ    no, delete this entry
doreset  ora   #$01       mark this VIRQ as triggered.
         sta   Vi.Stat,x 
         lda   #$80       add VIRQ as interrupt source
         sta   ,s        
         ldd   Vi.Rst,x   reset from Reset count.
notzero  std   Vi.Cnt,x  
virqent  ldx   ,y++      
         bne   virqloop  
                         
         ifgt  Level-2   
         puls  d         
         orcc  #Carry    
         stb   >$0643    
         stb   >$FFA1    
         incb            
         stb   >$0645    
         stb   >$FFA1    
         andcc  #^IntMasks
         else            
         puls  a          get VIRQ status flag: high bit set if VIRQ
         endc            
                         
         ora   <D.IRQS    Check to see if other hardware IRQ pending.
         bita  #%10110111 any V/IRQ interrupts pending?
         beq   toggle    
         ifgt  Level-2   
         lbsr  DoPoll     yes, go service them.
         else            
         bsr   DoPoll     yes, go service them.
         endc            
         bra   KbdCheck  
toggle   equ   *         
         ifgt  Level-2   
         lbsr  DoToggle   no, toggle GIME anyway
         else            
         bsr   DoToggle   no, toggle GIME anyway
         endc            
                         
KbdCheck                 
         ifgt  Level-2   
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
         endc            
                         
         jsr   [>D.AltIRQ] go update mouse, gfx cursor, keyboard, etc.
                         
         ifgt  Level-2   
         puls  d          restore original map type ---x
         orcc  #IntMasks 
         sta   >$0643     into system DAT image ---x
         stb   >$0645    
         std   >$FFA1     and into RAM ---x
         andcc  #$AF      
         endc            
                         
         dec   <D.Tick    end of second?
         bne   VIRQend    no, skip time update and alarm check
         lda   #TkPerSec  reset tick count
         sta   <D.Tick   
                         
* ATD: Modified to call real time clocks on every minute ONLY.
         inc   <D.Sec     go up one second
         lda   <D.Sec     grab current second
         cmpa  #60        end of minute?
         blo   VIRQend    no, skip time update and alarm check
         clr   <D.Sec     reset second count to zero
                         
*
* Call GetTime entry point in Clock2
*
         ldx   <D.Clock2  get entry point to Clock2
         jsr   $03,x      call GetTime entry point
                         
NoGet    ldd   >WGlobal+G.AlPID
         ble   VIRQend    Quit if no Alarm set
         ldd   >WGlobal+G.AlPckt+3 does Hour/Minute agree?
         cmpd  <D.Hour   
         bne   VIRQend   
         ldd   >WGlobal+G.AlPckt+1 does Month/Day agree?
         cmpd  <D.Month  
         bne   VIRQend   
         ldb   >WGlobal+G.AlPckt+0 does Year agree?
         cmpb  <D.Year   
         bne   VIRQend   
         ldd   >WGlobal+G.AlPID
         cmpd  #1        
         beq   checkbel  
         os9   F$Send    
         bra   endalarm  
checkbel ldb   <D.Sec     sound bell for 15 seconds
         andb  #$F0      
         beq   dobell    
endalarm ldd   #$FFFF    
         std   >WGlobal+G.AlPID
         bra   VIRQend   
dobell   ldx   >WGlobal+G.BelVec
         beq   VIRQend   
         jsr   ,x        
VIRQend  jmp   [>D.Clock] jump to kernel's timeslice routine
                         
*------------------------------------------------------------
* Interrupt polling and GIME reset code
*
                         
*
* Call [D.Poll] until all interrupts have been handled
*
DoPoll                   
         ifgt  Level-2   
         lda   >$0643     Level 3: get map type
         ldb   >$0645    
         pshs  d          save for later
         endc            
d@       jsr   [>D.Poll]  call poll routine
         bcc   d@         until error (error -> no interrupt found)
                         
         ifgt  Level-2   
         puls  d         
         orcc  #IntMasks 
         sta   >$0643    
         stb   >$0645    
         std   >$FFA1    
         andcc  #^IntMasks
         endc            
                         
*
* Reset GIME to avoid missed IRQs
*
DoToggle                 
         lda   #^GI.Toggl mask off CART* bit
         anda  <D.IRQS   
         sta   <D.IRQS   
         lda   <D.IRQER   get current enable register status
         tfr   a,b       
         anda  #^GI.Toggl mask off CART* bit
         orb   #GI.Toggl  --- ensure that 60Hz IRQ's are always enabled
         sta   >IRQEnR    disable CART
         stb   >IRQEnR    enable CART
         clrb            
         rts             
                         
                         
*------------------------------------------------------------
*
* Handle F$VIRQ system call
*
FVIRQ    pshs  cc        
         orcc  #IntMasks  disable interrupts
         ldy   <D.CLTb    address of VIRQ table
         ldx   <D.Init    address of INIT
         ldb   PollCnt,x  number of polling table entries from INIT
         ldx   R$X,u      zero means delete entry
         beq   RemVIRQ   
         ifgt  Level-2   
         bra   FindVIRQ   ---x
                         
v.loop   leay  4,y        ---x
         endc            
FindVIRQ                 
         ldx   ,y++       is VIRQ entry null?
         beq   AddVIRQ    if yes, add entry here
         decb            
         bne   FindVIRQ  
         puls  cc        
         comb            
         ldb   #E$Poll   
         rts             
                         
AddVIRQ                  
         ifgt  Level-2   
         ldx   R$Y,u     
         stx   ,y        
         lda   >$0643    
         ldb   >$0645    
         std   2,y       
         else            
         leay  -2,y       point to first null VIRQ entry
         ldx   R$Y,u     
         stx   ,y        
         endc            
         ldy   R$D,u     
         sty   ,x        
         bra   virqexit  
                         
         ifgt  Level-2   
v.chk    leay  4,y       
RemVIRQ  ldx   ,y        
         else            
RemVIRQ  ldx   ,y++      
         endc            
         beq   virqexit  
         cmpx  R$Y,u     
         bne   RemVIRQ   
         bsr   DelVIRQ   
virqexit puls  cc        
         clrb            
         rts             
                         
DelVIRQ  pshs  x,y       
DelVLup                  
         IFEQ  H6309-1   
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
FAlarm   ldx   #WGlobal+G.AlPckt
         ldd   R$D,u     
         bne   DoAlarm   
         std   G.AlPID-G.AlPckt,x erase F$Alarm PID, Signal.
         rts             
                         
DoAlarm  tsta             if PID != 0, set alarm for this process
         bne   SetAlarm  
         cmpd  #1         1 -> Set system-wide alarm
         bne   GetAlarm  
SetAlarm                 
         std   G.AlPID-G.AlPckt,x
         ldy   <D.Proc   
         lda   P$Task,y   move from process task
         ldb   <D.SysTsk  to system task
         ldx   R$X,u      from address given in X
         ldu   #WGlobal+G.AlPckt
         ldy   #5         move 5 bytes
         bra   FMove     
                         
GetAlarm                 
         cmpd  #2        
         bne   AlarmErr  
         ldd   G.AlPID-G.AlPckt,x
         std   R$D,u     
         bra   RetTime   
AlarmErr                 
         comb            
         ldb   #E$IllArg 
         rts             
         endc            
                         
*------------------------------------------------------------
*
* Handle F$Time System call
*
FTime    equ   *         
         ifgt  Level-1   
         ldx   #D.Time    address of system time packet
RetTime  ldy   <D.Proc    get pointer to current proc descriptor
         ldb   P$Task,y   process Task number
         lda   <D.SysTsk  from System Task
         ldu   R$X,u     
STime.Mv                 
         ldy   #6         move 6 bytes
FMove    os9   F$Move    
         else            
         ldx   R$X,u      get pointer to caller's space
         ldd   <D.Year    get year and month
         std   ,x        
         ldd   <D.Day     get day and hour
         std   2,x       
         ldd   <D.Min     get minute and second
         std   4,x       
         clrb            
         endc            
         rts             
                         
         endc            
                         
         emod            
len      equ   *         
         end             
