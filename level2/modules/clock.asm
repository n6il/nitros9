********************************************************************
* Clock - OS-9 Level Two V3.00 Clock part 1
*
* $Id$
*
* Ed.    Comments                                       Who YY/MM/DD
* ------------------------------------------------------------------
*        Original version                               KKD 87/01/01
*        Fixed labels                                   KDM 87/05/22
*        Break into 2 modules                           KKD 88/09/29
*        Fixed GIME IRQ toggle                          BRI 88/10/05
*        Changed to TSlice = 3                          BRI 88/11/12
*        Changed to TSlice = 2                          BRI 88/11/16
*        Added F$TPS, chopped size                      BRI 88/12/09
* 14     Added F$TPS, chopped size                      BRI 88/12/09
* 15     Fixed bug where F$Link to Clock2               BRI ??/??/??
*        was being done without switching D.Proc to the
*        system state D.SysPrc first.  This bug caused
*        crashes in certain situations.
* 16     The only change in this edition is that        BRI 90/04/15
*        Simmy's F$TimAlm call has been combined into
*        the standard F$Alarm call, with a few enhancements.
*        The best documentation for this (it would probably
*        be a good start on a manual page) is the comments
*        from the source code.
* 17     Fixed bug where jmp [D.Crash] should instead   BGP 98/10/20
*        jmp D.Crash


         nam   Clock                   
         ttl   OS-9 Level Two V3.00 Clock part 1

         ifp1                          
         use   defsfile                
         endc                          

edition  equ   17

*******************************************************

         mod   len,name,systm+objct,reent+1,Init,0

*******************************************************

name     fcs   "Clock"                 
         fcb   edition

* Svc Calls:

SvcTbl   fcb   F$Time                  
         fdb   FTime-*-2              
         fcb   F$STime                 
         fdb   FSTime-*-2             
         fcb   F$VIRQ
         fdb   FVIRQ-*-2              
         fcb   F$Alarm
         fdb   FAlarm-*-2             
         fcb   F$TPS                    *** new BRI ***
         fdb   FTPS-*-2                 *** new BRI ***
*         fcb   $26                     
*         fdb   FUnk-*-2               
         fcb   $80                     

*---------------------------------
* IRQ Handler:
* Note NO STACK HERE!

IRQChek  lda   >IRQEnR                  get GIME irq status
         ora   <D.IRQS                  save it
         bita  #$08                     was it VBORD irq?
         bne   L0035                    ..yes, increment time
         sta   <D.IRQS                 
         ldd   <D.GPoll                 set D.SvcIRQ to GIME polling
         bra   L0043                    ..and jmp D.XIRQ

* WAS VBORD IRQ so increment Time Vars:
L0035    anda  #^$08                    drop vbord irq
         sta   <D.IRQS                 
         dec   <D.Tick                  ticks-1
         bne   L0041                    ..skip if not yet
         lda   #TkPerSec                reset ticks to start of second
         sta   <D.Tick                  (also F$Alarm check flag!!)
L0041    ldd   <D.VIRQ                  set alternate IRQ
L0043    std   <D.SvcIrq                for system state
         jmp   [D.XIRQ]                 and finish irq handling.

*---------------------------------
* NEW GIME irq register reset:

GPoll    jsr   [>D.Poll]                do regular polling
         bcc   GPoll                   
GFix     lda   #$FE                     get enabled bits
         anda  <D.IRQS
         sta   <D.IRQS
         lda   <D.IRQER                
         tfr   a,b                      copy it for GIME IRQ re-trigger
         anda  #^$01                    select GIME IRQ input(s) to toggle
         sta   >IrqEnR                  disable selected GIME input(s)
         stb   >IrqEnR                  trigger GIME again
         clrb                          
         rts                           

*------------------------------
* VIRQ Handler:

VIRQChek clr   ,-s                      clear found flag
         lda   <D.IRQS                  check for other irqs
         bita  #$37                     any others?
         beq   L006D                    ..no
         inc   ,s                       yes, set flag
L006D    ldy   <D.CLTb                  point to virqtable
         bra   L008A                    ..begin search

* Main Loop:

L0072    ldd   ,x                       get virq counter
         subd  #$0001                   decrement
         bne   L0088                    ..skip if not ready
         inc   ,s                      
         lda   $04,x                    check kill flag
         bne   L0082                    ..nope
         lbsr  L01D9                    ..yep, delete entry
L0082    ora   #$01                     set software irq bit
         sta   $04,x                   
         ldd   $02,x                    reset counter
L0088    std   ,x                      
L008A    ldx   ,y++                     last entry?
         bne   L0072                    ..no
         lda   ,s+                      else any found?
         beq   L0092                    ..no
         bsr   GPoll                   
         bra   L0094
L0092    bsr   GFix
L0094    jsr   [>D.AltIRQ]              poll keyboard
         lda   #TkPerSec               
         cmpa  <D.Tick                  new second starting?
         bne   L011D                    ..not yet
         ldd   #3                       gettime vector
         lbsr  L0125                   
         lda   <$002D
         cmpa  #$10
         bhi   L011D
         beq   L00E5
         ldx   #$1016
         ldb   ,x
         beq   L011D
         leay  -$07,x
         bsr   L00CE
         bne   L011D
         lda   <$002D
         cmpa  #$0F
         bcs   L00C5
         tstb
         bpl   L00C5
         clr   ,x
L00C5    ldx   >$1017
         beq   L011D
         jsr   ,x
         bra   L011D
L00CE    ldb   #$04
         pshs  x,b
         ldx   #$0028
L00D5    lda   b,y
         bmi   L00DF
         dec   ,s
         cmpa  b,x
         bne   L00E3
L00DF    decb
         bpl   L00D5
         clrb
L00E3    puls  pc,x,b
L00E5    ldx   <$0048
         leax  <$21,x
L00EA    lda   ,-x
         beq   L0119
         ldb   #$C3
         tfr   d,y
         lda   $06,y
         beq   L0119
         bsr   L00CE
         bne   L0119
         pshs  b
         ldd   $06,y
         exg   d,y
         clrb
         exg   d,y
         pshs  x
         ldx   <D.Proc
         sty   <D.Proc
         os9   F$Send
         stx   <D.Proc
         puls  x
         tst   ,s+
         bpl   L0119
         clra
         clrb
         std   $06,y
L0119    cmpx  <$0048
         bhi   L00EA
L011D    jmp   [D.Clock]                continue w/multitasking

*--------------------------------- new!
* F$STime

FSTime   ldx   #D.Time                 
         bsr   Copy6                   
         ldd   #06                      do setime in clock2:

*---------------------------------
* CALL CLOCK2: D=offset
L0125    ldx   <D.Clock2                else update time vars
         jmp   d,x                      do it and rts

*---------------------------------
* F$Time
*  Note that time is already here
*  from once/second clock polling!

FTime    ldx   #D.Time                  point to time packet Moved ****
L012C    ldy   <D.Proc                  user process
         lda   <D.SysTsk                from sys map
         ldb   P$Task,y                 to user map
         ldu   R$X,u                    destination=user(X)
         bra   L015B                   

Copy6    ldy   <D.Proc                  calling process *** changed BRI ***
         lda   P$Task,y                 from user map *** changed BRI ***
         ldb   <D.SysTsk               
         ldu   R$X,u                    packet
         exg   x,u                     
L015B    ldy   #6                       number bytes
         os9   F$Move                   get them
         rts                           



*--------------------------------------------
* F$Alarm
*
* Note:  The time packet is standard F$Time format, except seconds are always
*        set to zero and $80 through $FF are wild cards that will match any
*        time constant.  Use of wild cards to replace one or more time
*        constants in a time packet results in a repetitive alarm.  The BELL
*        alarm sounds once per second up to and including the 15th second in
*        the alarm minute.  Signal alarms are sent on the 16th second of the
*        alarm minute to avoid misses when using a real-time Clock2, which may
*        be out of sync with the internal VBORD (60 Hz) tick count.
*        EG1:  X=>$5A0216000000 sets an alarm at midnight on Feb. 22, 1990.
*        EG2:  X=>$5AFFFF0D0000 sets an alarm at 1:00 PM every day in 1990.
*        EG3:  X=>$FFFFFFFFFF00 sets an alarm at every minute.
*
* INPUT:  A = alarm type or process ID
*         B = action or signal code (depending on A)
*         X = pointer to caller's time packet (if alarm set or return)
*
* OUTPUT:  Alarm set, cleared, or returned, as follows:
*
*          - if A=0:
*            - if B=0, clear alarm
*            - if B=1, set "BELL" alarm
*              - D = alarm info
*              - X = pointer to caller's 6 byte time packet
*            - if B=2, return alarm info
*              - D = alarm info
*              - X = pointer to caller's 6 byte time packet
*
*          - if A<>0:
*            - A = process ID to be signalled
*            - B = signal code to be sent
*            - X = pointer to caller's 6 byte time packet
*
* ERROR OUTPUT:  CC = Carry set
*                B  = error code

FAlarm   ldx   <D.Proc
         leax  >$00C3,x
         ldd   $01,u
         beq   L0167
         tsta
         bne   L017C
         cmpb  #$01
         beq   L0179
         cmpb  #$02
         beq   L0170
         comb
         ldb   #$BB
         rts
L0167    tst   $06,x
         bne   L0188
         ldx   #$100F
         bra   L0188
L0170    ldx   #$100F
         ldd   $06,x
         std   $01,u
         bra   L012C
L0179    ldx   #$100F
L017C    pshs  x,b,a
         clra
         clrb
         std   $06,x
         bsr   Copy6
         puls  x,b,a
         clr   $05,x
L0188    std   $06,x
         clrb
         rts

*--------------------------------- *** new ***
* get ticks per second:

FTPS     ldd   #TkPerSec                number of ticks per second
         std   R$D,u                    save it to caller's reg stack
         clrb                           no error...
         rts                           

*---------------------------------
FVIRQ    pshs  cc                       save irq status
         orcc  #IntMasks                stop irq/firqs
         ldy   <D.CLTb                  point to virq table
         ldx   <D.Init                  and Init module
         ldb   PollCnt,x                get max devices
         ldx   R$X,u                    get X parameter
         beq   L01C3                    ..remove entry
         tst   ,y                       first entry empty?
         beq   L01B9                    ..yes
         subb  #$02                     else point to last
         lslb                           entry in table
         leay  b,y                     
         tst   ,y                       empty?
         bne   L01D3                    ..no, error
L01B3    tst   ,--y                     found spot?
         beq   L01B3                    ..no, back up
         leay  $02,y                    yes, reset ptr
L01B9    ldx   R$Y,u                    get packet ptr
         stx   ,y                       set entry
         ldd   R$D,u                    get first count *** changed BRI ***
         std   ,x                       set it *** changed BRI ***
         bra   L01CF                    return okay.
L01C3    ldx   R$Y,u                    get entry
L01C5    tst   ,y                       return if
         beq   L01CF                    no entries
         cmpx  ,y++                     else search for
         bne   L01C5                    this entry
         bsr   L01D9                    then remove it
L01CF    puls  cc                       restore intrpt status
         clrb                           ok
         rts                            .
L01D3    puls  cc                       retrieve CC reg
         comb                           set error bit
         ldb   #E$Poll                  'Polling Table Full'
         rts                            .

*--------------------------
* delete virq entry:

L01D9    pshs  y,x                      save regs
L01DB    ldx   ,y++                     move entries
         stx   -$04,y                   up in table
         bne   L01DB                    until last one (0000)
         puls  y,x                     
         leay  -$02,y                   reset table ptr
         rts                           


*---------------------------------
* Clock Init:

Init     clrb                           necessary???
         pshs  cc                       save intpt status
         ldd   #(TkPerSec*256)+02      
         sta   <D.Tick                 
         stb   <D.TSlice                two ticks/time slice 
         stb   <D.Slice                 and first slice
         orcc  #IntMasks                stop interrupts
         leax  >IRQChek,pcr             set IRQ handler
         stx   <D.IRQ                  
         leax  >VIRQChek,pcr            set VIRQ handler
         stx   <D.VIRQ                 
         leax  >GPoll,pcr               set GIME irq reset
         stx   <D.GPoll                
* install system calls
         leay  >SvcTbl,pcr              insert syscalls
         os9   F$SSvc                  
         clra                          
         ldx   #PIA0Base                point to PIA0
         sta   $01,x                    dir register
         sta   ,x                       side A are inputs
         sta   $03,x                    dir register
         coma                          
         sta   $02,x                    side B outputs
         ldd   #$343C                   reset D
         sta   $01,x                    control reg
         stb   $03,x                    set up irq from VBORD
         lda   $02,x                    dummy reset
         lda   #$08                    
         ora   <D.IRQER                 get GIME IRQ reg/enable VBord irqs
         sta   <D.IRQER                 save shadow reg
         sta   >IRQEnR                  set VBorder irqs

         ldx   <D.Proc                  save user proc
         pshs  x
         ldx   <D.SysPrc                make sys for link
         stx   <D.Proc

         leax  <Clock2,pcr
         lda   #Systm+Objct            
         os9   F$Link                  

* And here, we restore the original D.Proc value
         puls  x
         stx   <D.Proc                  restore user proc

         bcs   err                     
         sty   <D.Clock2                save exec vector
         jsr   ,y                       do init of clock (ignore errs)
         puls  pc,cc                   

err      ldb   #5                       "no clock2" err
         jmp   D.Crash                  tell user the booterr

Clock2   fcs   "Clock2"

         emod                          
len      equ   *                       
         end                           

