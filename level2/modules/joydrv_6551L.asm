********************************************************************
* JoyDrv - Joystick Driver for 6551/Logitech Mouse
*
* $Id$
*
* Edt/Rev  YYYY/MM/DD  Modified by
* Comment
* ------------------------------------------------------------------
*   6      1988/??/??
* L2 Upgrade distribution version.
*
*   6r1    2005/04/25  Boisy G. Pitre
* Fixed error where wrong branch was taken.
                         
         nam   JoyDrv    
         ttl   Joystick Driver for 6551/Logitech Mouse
                         
* Disassembled 98/09/09 09:22:44 by Disasm v1.6 (C) 1988 by RML
                         
         ifp1            
         use   defsfile  
         use   l51.defs  
         endc            
                         
tylg     set   Systm+Objct
atrv     set   ReEnt+rev 
rev      set   $01
edition  set   6         
                         
MPISlot  set   $FF
                         
         mod   eom,name,tylg,atrv,start,$FF68
                         
name     fcs   /JoyDrv/  
         fcb   edition   
                         
SlotSlct fcb   MPISlot   
                         
start    lbra  Init      
         lbra  Term      
         lbra  SSMsBtn   
         lbra  SSMsXY    
         lbra  SSJoyBtn  
                         
SSJoyXY  pshs  x,b,a     
         ldx   #PIA0Base 
         lda   <$23,x    
         ldb   <$20,x    
         pshs  b,a       
         anda  #$F7      
         sta   <$23,x    
         lda   $01,x     
         ldb   $03,x     
         pshs  b,a       
         andb  #$F7      
         lsr   $04,s     
         bcs   L0043     
         orb   #$08      
L0043    stb   $03,x     
         lda   ,s        
         ora   #$08      
         bsr   L0065     
         std   $06,s     
         lda   ,s        
         anda  #$F7      
         bsr   L0065     
         std   $04,s     
         puls  b,a       
         sta   $01,x     
         stb   $03,x     
         puls  b,a       
         stb   <$20,x    
         sta   <$23,x    
         puls  pc,y,x    
L0065    sta   $01,x     
         lda   #$7F      
         ldb   #$40      
         bra   L0078     
L006D    lsrb            
         cmpb  #$01      
         bhi   L0078     
         lsra            
         lsra            
         tfr   a,b       
         clra            
         rts             
L0078    pshs  b         
         sta   <$20,x    
         tst   ,x        
         bpl   L0085     
         adda  ,s+       
         bra   L006D     
L0085    suba  ,s+       
         bra   L006D     
                         
IRQPckt  equ   *         
Pkt.Flip fcb   Stat.Flp   D.Poll flip byte
Pkt.Mask fcb   Stat.Msk   D.Poll mask byte
         fcb   $01        priority
                         
***
* JoyDrv Initialization.
*
* INPUT:  U = JoyDrv data area address (8 bytes)
*
* OUTPUT:  IRQ service entry installed
*          D, X, and U registers may be altered
*
* ERROR OUTPUT:  CC = Carry set
*                B = error code
Init     clra            
         clrb            
         sta   Btn.Cntr,u set up Rx data sync, no button(s) pressed
         std   CrntXPos,u set up X position at left screen edge
         ldd   #HResMaxY*2
         std   CrntYPos,u set up Y position at top screen edge
         ldd   M$Mem,pcr  get base hardware address
         addd  #StatReg   status register address
         leax  IRQPckt,pcr
         leay  IRQSvc,pcr
         os9   F$IRQ     
         bcs   TermExit   go report error...
         ldx   M$Mem,pcr  get base hardware address again
         ldd   #(TIC.RTS!Cmd.DTR)*256+(DB.8!Ctl.RClk!BR.01200) [D]=command:control
         pshs  cc        
         orcc  #IntMasks  disable IRQs while setting up hardware
         sta   PRstReg,x  reset 6551
         std   CmdReg,x   set command and control registers
         lda   >PIA1Base+3 get PIA CART* input control register
         anda  #$FC       clear PIA CART* control bits
         sta   >PIA1Base+3 disable PIA CART* FIRQs
         lda   >PIA1Base+2 clear possible pending PIA CART* FIRQ
         lda   #$01       GIME CART* IRQ enable
         ora   <D.IRQER   mask in current GIME IRQ enables
         sta   <D.IRQER   save GIME CART* IRQ enable shadow register
         sta   >IrqEnR    enable GIME CART* IRQs
         ldb   DataReg,x  *ensure old error,
         ldb   StatReg,x  *Rx data, and
         ldb   DataReg,x  *IRQ flags
         ldb   StatReg,x  *are clear
         andb  Pkt.Mask,pcr IRQ bits still set?
         bne   InitErr    yes, go disable ACIA and return...
         lda   SlotSlct,pcr get MPI slot select value
         bmi   InitExit   no MPI slot select, go exit...
         sta   >MPI.Slct  set MPI slot select register
* BUG FIX: InitExit is now here... was TermExit... 
InitExit puls  pc,cc      recover original regs, return...
                         
***
* JoyDrv Termination.
*
* INPUT:  U = JoyDrv data area address (8 bytes)
*
* OUTPUT:  IRQ service entry removed
*          D, X, and U registers may be altered
*
* ERROR OUTPUT:  CC = Carry set
*                B = error code
Term     pshs  cc         save regs we alter
         orcc  #IntMasks  mask IRQs while disabling ACIA
InitErr  ldx   M$Mem,pcr  get base address
         lda   #TIC.RTS!Cmd.RxIE!Cmd.DTR *disable all
         sta   CmdReg,x   *ACIA IRQs
         puls  cc        
         leax  StatReg,x  point to status register
         tfr   x,d        copy status register address
         ldx   #$0000     remove IRQ table entry
         leay  IRQSvc,pcr
         os9   F$IRQ     
TermExit rts             
                         
***
* Joystick button(s) status check.
*
* INPUT:  U = JoyDrv data area address (8 bytes)
*
* OUTPUT:  B = button or "clear" status
*              button(s)     = xxxxLRLR
*          A, X, and U registers may be altered
*
* ERROR OUTPUT:  none
SSJoyBtn ldb   #$FF      
         ldx   #PIA0Base 	check for standard joystick/mouse fire buttons
         stb   $02,x
         ldb   ,x        		
         comb            	set == button pressed
         andb  #$0F      
         rts             
                         
***
* Mouse button(s) status check.
*
* INPUT:  U = JoyDrv data area address (8 bytes)
*
* OUTPUT:  B = button or "clear" status
*              button(s)     = xxxxLRLR
*              clear         = 10000000
*              shift-clear   = 11000000
*          A, X, and U registers may be altered
*
* ERROR OUTPUT:  none
SSMsBtn  pshs  cc        
         orcc  #IntMasks 		mask interrupts
         lda   ,u
         tfr   a,b       
         andb  #%11000000		mask SHIFT-CLEAR
         bne   L0120     
         bita  #%00100000		????
         beq   L011A     
         orb   #%00000011
L011A    bita  #%00010000
         beq   L0120     
         orb   #%00001100
L0120    anda  #%00111111		turn off SHIFT-CLEAR flag
         sta   ,u        
         puls  pc,cc     
                         
***
* Joystick/Mouse XY coordinate read.
* 
* INPUT:  A = side flag (1 = right, 2 = left)
*         Y = resolution (0 = low, 1 = high)
*         U = JoyDrv data area address (8 bytes)
* 
* OUTPUT:  X = horizontal coordinate (left edge = 0)
*              low resolution = 0 to 63
*              high resolution = 0 to HResMaxX 
*          Y = vertical coordinate (top edge = 0)
*              low resolution = 0 to 63
*              high resolution = 0 to HResMaxY
*          D and U registers may be altered
* 
* ERROR OUTPUT:  none
SSMsXY   ldd   #$017E    
         pshs  cc        
         orcc  #IntMasks 
         ldx   CrntXPos,u
         subd  CrntYPos,u
         lsra            
         rorb            
         tfr   d,y       
         puls  pc,cc     
                         
***
* Mouse IRQ service routine.
*
* INPUT:  A = flipped and masked device status byte
*         U = mouse data area address
*
* OUTPUT:  updated serial mouse data
*          CC Carry clear
*          D, X, Y, and U registers may be altered
*
* ERROR OUTPUT:  none
IRQSvc   ldx   M$Mem,pcr 
         bita  #Stat.Err  any error(s)?
         beq   ChkRDRF    no, go check Rx data
         ldb   DataReg,x  read Rx data register to clear error flags
ClrRxCnt lda   Btn.Cntr,u get current button status and Rx data counter
         anda  #^BC.RxCnt clear Rx data counter
ButnExit sta   Btn.Cntr,u reset Rx mouse data counter to wait for sync...
IRQExit  clrb             clear Carry to mark IRQ serviced
         rts             
                         
ChkRDRF  bita  #Stat.RxF  Rx data?
         beq   IRQExit    no, but this branch should never be taken...
         ldb   DataReg,x  get Rx data
         lda   Btn.Cntr,u get button status and Rx counter
         anda  #BC.RxCnt  waiting for sync with mouse data?
         bne   ChkOfst    no, go check Rx offset...
         tfr   b,a        copy Rx data
         anda  #SyncMask  clear button status bits
         cmpa  #SyncData  is it *PROBABLY* the initial (sync) byte?
         bne   IRQExit    no, just ignore it...
         comb             invert button bits to match SS.Mouse format
         lslb             *move button
         lslb             *status into
         lslb             *bits 5-3
         andb  #BC.Butns  clear everything but the button bits
         incb             set Rx counter to first XY position byte
         pshs  b         
         lda   ,u        
         bita  #$08      
         beq   L017A     
         bitb  #$08      
         bne   L017A     
         lda   #$C0      
         ldx   CrntXPos,u
         cmpx  #$0140    
         bcs   L017A     
         lsla            
L017A    anda  #$C0      
         ora   ,s+       
         bra   ButnExit   go save new button status and Rx counter, exit...
ChkOfst  cmpa  #PcktSize-1 last byte in mouse packet?
         bcs   SaveData   no, go save mouse data to Rx buffer...
         ldx   #HResMaxY*2 get maximum Y position
         pshs  x          save it for CalcPos subroutine
         leax  CrntYPos,u point to current Y position
         leay  Buffer+1,u point to primary Y offset
         bsr   CalcPos    go calculate & save mouse's new Y position
         ldb   Buffer+2,u get mouse packet's secondary X offset
         ldx   #HResMaxX  get maximum X position
         stx   ,s         save it for CalcPos subroutine
         leax  CrntXPos,u point to current X position
         leay  Buffer+0,u point to primary X offset
         bsr   CalcPos    go calculate & save mouse's new X position
         leas  2,s        clean up stack
         bra   ClrRxCnt   go save button status and clear Rx counter, exit...
SaveData stb   a,u        save XY position byte to mouse data Rx buffer
         inc   Btn.Cntr,u point to next byte in Rx buffer
         clrb             clear Carry to mark IRQ serviced
         rts             
                         
CalcPos  sex              sign extend mouse packet's 2nd XY offset ([D] = -128 to +127)
         pshs  d          save it temporarily...
         ldb   ,y         get mouse packet's 1st XY offset
         sex              sign extend it ([D] = -128 to +127)
         addd  ,s         add mouse's 2nd XY offset
         std   ,s         save XY offset total temporarily...
         bpl   PosAdjst   go de-sensitize positive "ballistic" XY offset...
         orb   #%00000111 if -8<XYoffset<0, no "ballistic" response
         addd  #1         "fix" negative offset "ballistic" response
         bra   RShiftD    go calculate "ballistic" offset...
PosAdjst andb  #%11111000 if 0<XYoffset<8, no "ballistic" response
RShiftD  asra             *calculate 50% of XY offset
         rorb             *for "ballistic" response
         addd  ,s++       add original XY offset total, clean up stack
         addd  ,x         add mouse's current XY position
         bpl   CheckPos   zero or positive XY position, go check it...
         clra             *set minimum
         clrb             *XY position
CheckPos cmpd  2,s        past maximum XY position?
         bls   SavePos    no, go save it...
         ldd   2,s        get maximum XY position
SavePos  std   ,x         save new XY position
         rts             
                         
         emod            
eom      equ   *         
         end             
