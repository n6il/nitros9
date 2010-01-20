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

* GH 08/06/2008 gleaned from a newsgroup msg found by google
*---------------------------------------------
*>   Hmm, let me guess: the terminal used a 6551 ACIA.
*
* Possibly so, but not necessarily. Seems there are terminals out there
* that require DCD/DSR/strange signals for receiving/transmitting. Choose
* any combination you like.
*
* Now, the ACIA 6551 is an especially braindead beast. It requires both
* DCD and DSR, and pulling CTS low for flow control will make it stop
* sending immediately, without finishing the character, resulting in a
* junked character. (Not all versions of the chip have this bug. Most do.)
* The Archimedes people who were struck with the 6551 usually wired DCD
* and CTS to high, DSR to modem CTS, RI to modem DCD.
*----------------------------------------------
* FWIW, the mouse outputs a packet of un-determined length when
* it is enabled, no motion needed to trigger, just turn it on
* Since the mouse is port powered, enabling its power could
* cause this I presume.
* GH 21/06/08 my mouse is fixed at 3 bytes
* GH see comments scattered through the code
* none of which will be precious in final
* version
* GH - 21/12/09 version 11 (B) moving some code to shrink, rechecking
* GH - 18/12/09 version A - trying to fix button locations in packet
* GH - 30/06/2008  version 8
* GH - 08/08/2008 version 7
* Re-wrote to rearrange order of init see
* comments scattered through the code
* GH - 01/07/2008 version 9
* added code to function with a real M$ 3 button mouse
* now defaults to M$ empty packet for Center button down event
* but detects 4th byte from a Logitek mouse & switches modes
* till next reboot.
* Also no 6309 optimizations yet.  Version A maybe? Not yet.
* one problem has been the narrow list format, Boisy advises:
	opt	w132
	nam	JoyDrv
	ttl	Joystick Driver for 6551/Logitech Mouse

* Disassembled 98/09/09 09:22:44 by Disasm v1.6 (C) 1988 by RML

         ifp1
         use   defsfile
         use   l51.defs
         endc
* l51.defs - something else to check against google et all
* l51.defs has been modified, this needs the new version
* set this to get some debugging in the boot trace
DEBUG	= 1
tylg     set   Systm+Objct
atrv     set   ReEnt+rev
rev      set   $02
edition  set   11
* set this to where your rs-232 pack is plugged in
MPISlot  set   $00	front slot for mine

         mod   eom,name,tylg,atrv,start,$FF6C

name     fcs   /JoyDrv/
         fcb   edition

SlotSlct  fcb   MPISlot

start    lbra  Init
         lbra  Term
         lbra  SSMsBtn
         lbra  SSMsXY
         lbra  SSJoyBtn

* This code is not being
* used, but save it so I
* don't have to reinvent
* this wheel later
*SSJoyXY  pshs  x,b,a
*         ldx   #PIA0Base
*         lda   <$23,x
*         ldb   <$20,x
*         pshs  b,a
*         anda  #$F7
*         sta   <$23,x
*         lda   $01,x
*         ldb   $03,x
*         pshs  b,a
*         andb  #$F7
*         lsr   $04,s
*         bcs   L0043
*         orb   #$08
*L0043    stb   $03,x
*         lda   ,s
*         ora   #$08
*         bsr   L0065
*         std   $06,s
*         lda   ,s
*         anda  #$F7
*         bsr   L0065
*         std   $04,s
*         puls  b,a
*         sta   $01,x
*         stb   $03,x
*         puls  b,a
*         stb   <$20,x
*         sta   <$23,x
*         puls  pc,y,x
*L0065    sta   $01,x
*         lda   #$7F
*         ldb   #$40
*         bra   L0078
*L006D    lsrb
*         cmpb  #$01
*         bhi   L0078
*         lsra
*         lsra
*         tfr   a,b
*         clra
*         rts
*L0078    pshs  b
*         sta   <$20,x
*         tst   ,x
*         bpl   L0085
*         adda  ,s+
*         bra   L006D
*L0085    suba  ,s+
*         bra   L006D

IRQPckt  equ   *
Pkt.Flip fcb   Stat.Flp   D.Poll flip byte=$00
Pkt.Mask fcb   Stat.RxF  is correct
         fcb   $01        priority=low

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
* first, suspend all interrupts
Init	pshs	cc         save regs we alter
	orcc	#IntMasks  mask IRQs while disabling ACIA
	bsr	InitPIAs
	bsr	InitGIME
	bsr	ClrACIA reset, gobble up trash data in ACIA
	bcc	ClrBuf  which will also install IRQSvs
	puls	cc else error
	lbsr	Term
	comb
	ldb	#E$PrcAbt
	rts	and return error

*************************************
* Btn.Cntr,u  offset 0 has room for 3 bits of incoming
* byte counter, 3 bits of button status.
* Buffer, offset 2-3 is the combined first 3 bytes
* of the incoming XY data
* CrntXpos, offset 4-5 is current (0-HResMaxX) xpos
* CrntYpos, offset 6-7 is current (0 to HResMaxY*2) ypos

ClrBuf	 ldd   #$0007  clear the buffer
ClrBuf1	 sta   b,u	A=$00
	 decb	decr counter
	 bne   ClrBuf1	was a bpl, so 1st byte wasn't cleared
* Now init the buffer to real data
         clrb  reset to $00, s/b $00 here anyway.
         sta   Btn.Cntr,u set up Rx data sync, no button(s) pressed
         std   CrntXPos,u set up X position at left screen edge
         ldd   #HResMaxY*2 =$017E, 382 decimal?  Odd value, check
         std   CrntYPos,u set up Y position at top screen edge
	 lda   #'M	preset M$ mouse
	 sta   Buffer,u

* Now we should be ready for live IRQ's
InstIRQ  ldd   M$Mem,pcr  get base hardware address
         addd  #StatReg   status register address
         leax  IRQPckt,pcr
         leay  IRQSvc,pcr
         os9   F$IRQ install the IRQSvs routine
         lbcs  InitErr go with cc on stack!
	 puls  cc get rid of the push
	 rts

* BUG FIX: InitExit is now here... was TermExit...
InitExit puls  pc,cc      recover original regs, return...

* clear the PIA's for this
InitPIAs lda   >PIA1Base+3 get PIA CART* input control register
         anda  #$FC        clear PIA CART* control bits
         sta   >PIA1Base+3 disable PIA CART* FIRQs
         lda   >PIA1Base+2 clear possible pending PIA CART* FIRQ
	ifeq DEBUG-1
         pshs  a,b,x,u,y,cc,dp
	 lda   #'P
         jsr   <D.BtBug
         puls  a,b,x,u,y,cc,dp
	endc
	 rts

InitGIME lda   #$01       GIME CART* IRQ enable
         ora   <D.IRQER   mask in current GIME IRQ enables
         sta   <D.IRQER   save GIME CART* IRQ enable shadow register
         sta   >IrqEnR    enable GIME CART* IRQs
	 lda   SlotSlct,pcr mpi slot of mouse
	 bmi   ClrACIA
	 sta   >MPI.Slct
	ifeq DEBUG-1
         pshs  a,b,x,u,y,cc,dp
         lda   #'G
         jsr   <D.BtBug
         puls  a,b,x,u,y,cc,dp
	endc
	 rts

ClrACIA  ldx   M$Mem,pcr  get base hardware address again
	 lda   #$10
	 sta   StatReg,x reset again
* major foobar. These mice are 7n2 mice, not 8n1
* Fixed 25/06/2008 GH
	 ldd   #(TIC.RTS!Cmd.DTR)*256+(DB.7!Ctl.RClk!BR.01200) [D]=command:control
         std   CmdReg,x   set command and control registers
* do instant reads for trash collection
* and clear status of Stat.RxF bits
* read it 16 times so its settled!
	 ldb   #$10
flshinit lda   DataReg,x
	 lda   StatReg,x
	 decb
	 bne   flshinit

* that kills some of the 14 milliseconds
* to the mouses first response byte
* now, lets see what mouse we have
* my mouse does a $7F as it powers up as first byte
	 bsr  GetByte GetByte shows _ char
	 bsr  GetByte GetByte shows M char, but its a logitek
	 bsr  GetByte GetByte shows 3 char, ?number of buttons?
* it will either get the first 3 bytes, or timeout
* and ATM, a timeout will lock the boot to display it
GotByte  rts

*********************************
* Entry  : x pointing at hardware
* Mangles: a,b
* Returns: char in A
* Error  : cc set, err code in B
* scans acia for a byte of data
* Switch this out also

GetByte	 pshs  y
	 ldy   #$01A0 set timeout to fail
GetByte1 leay  -1,y
	 beq   GByteFai
	 clra  kill some time
Dly1	 deca
	 bne   Dly1
	 lda   StatReg,x look for byte
	 anda  Pkt.Mask,pcr
	 tsta  Stat.RxF
	 beq   GetByte1
	 lda   DataReg,x
* show byte on boot screen
	 pshs  a,b,x,u,y,cc,dp
	 jsr   <D.BtBug
	 puls  a,b,x,u,y,cc,dp
	 puls  y
	 clrb in case cc set
	 rts

GByteFai puls  y
	 clrb  clear carry
	ifeq DEBUG-1
* show failure on boot screen a 't'
	 pshs  a,b,x,u,y,cc,dp
	 lda   #'T indicate timeout
	 jsr   <D.BtBug
	 puls  a,b,x,u,y,cc,dp
	endc
GBytFail comb  set carry
	 ldb   #E$PrcAbt
* lock up boot to show failure
lettgsho bra   lettgsho
*	 rts

*** Only used by failed Init routine!
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
         leax  StatReg,x  point to status register
         tfr   x,d        copy status register address
         ldx   #$0000     remove IRQ table entry
         leay  IRQSvc,pcr
         os9   F$IRQ

	 ifeq  DEBUG-1
	 pshs  a,b,x,y,u,cc,dp
         lda   #'j failed
         jsr   <D.BtBug
         puls  a,b,x,y,u,cc,dp
	 endc

TermExit puls  cc clear stack
letssee  bra   letssee  lock it with failed data on screen
*	 comb
*	 ldb   #E$PrcAbt
*	 rts
*************************
* This code only good for tandy
* Joysticks. Why here?
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
         ldx   #PIA0Base	check for standard joystick/mouse fire buttons
         stb   $02,x
         ldb   ,x
         comb			set == button pressed
         andb  #$0F
         rts
* I (GH) don't believe the above code ever runs.

****************************************
* Mouse button(s) status check.
* GH - 21/06/2008 will need center button additions
* GH - 30/06/2008 redefined buttons
* INPUT:  U = JoyDrv data area address (8 bytes)
*
* OUTPUT:  B = button or "clear" status
* ????? GH where did I find this set of bogus defines?
*              button(s)     = xxxxLRLR looks like a 3$ bill
*              clear         = 10000000
*              shift-clear   = 11000000
*          A, X, and U registers may be altered
*
* ERROR OUTPUT:  none
* AND HERE IS WHERE THE BUTTON DATA IS LOST!
SSMsBtn  pshs  cc
         orcc  #IntMasks		mask interrupts
         lda   Btn.Cntr,u
* GH now Q is do we wait till mouse packet is in? Not ATM
         tfr   a,b
         andb  #%11000000		mask SHIFT-CLEAR
         bne   L0120
         bita  #BC.ButnL		Left btn down?
         beq   L011A
         orb   #%00000011		wrong, will need adjustment
L011A    bita  #BC.ButnR		Right btn down?
         beq   L0120
         orb   #%00001100		wrong, will need adjustment
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

*************************************
* Mouse IRQ service routine.
*
* INPUT:  A = flipped and masked device status byte
* NO IT'S NOT MASKED, normally $D8 coming into here
* And the 4 lsb's are all we care about
*         U = mouse data area address
*
* OUTPUT:  updated serial mouse data
*          CC Carry clear
*          D, X, Y, and U registers may be altered
*
* ERROR OUTPUT:  none
* GH 23/06/2008 We can watch the buffer with "dbmouse"
* thanks Robert G.
IRQSvc	 ldx   M$Mem,pcr is hdwe addr
         anda  Stat.Err   any error(o/f/p)?
         beq   ChkRDRF    no, go check Rx data
	 ldb   DataReg,x  read Rx data register to clear error flags
IRQExit	 clrb             clear Carry to mark IRQ serviced
         rts all done

ChkRDRF  ldb   DataReg,x  get Rx data
         lda   Btn.Cntr,u get buttons, byte counter
	 bitb  #MD.Sync   Sync byte?
	 beq   ChkOfst    Not sync, go

* is sync, zero Cntr first
* is only non-err place counter is reset!
* but leave buttons alone
	 anda  #^BC.RxCnt leave buttons
	 inca  to count byte
	 sta   Btn.Cntr,u save btns, cntr=1

* GH 06/21/2008-from here to rts is sync byte only
* ENTER B=%??LRXXYY 1st byte from mouse
* Left button 1st
ChkLBtn  bitb  #MD.ButnL
         beq   BtnLu      not set, go
         ora   #BC.ButnL  down $20
         bra   ChkRBtn
BtnLu    anda  #BU.ButnL  release it
* Right button
ChkRBtn  bitb  #MD.ButnR  $10
         beq   BtnRu
         ora   #BC.ButnR  $10 pushed
         bra   GoDoXY
BtnRu    anda  #BU.ButnR  release it
* That does left/right buttons
* now do MS 2 bits of YYXX also in sync byte
GoDoXY   sta   Btn.Cntr,u save count, buttons
	 lslb           needs 4 shifts
         lslb           to put YY
         lslb           in d7, d6
         lslb
         pshs  b        Save YYXX0000
         andb  #MskYYXX nuke XX leave YY000000
         stb   Buffer+2,u preload YY
         puls  b refresh b
         lslb
         lslb  Now only XX000000
         stb   Buffer+1,u mark in sync, 1st byte done
         clrb  clear errors
         rts   sync byte done
* the above does first byte with 0SBBYYXX
* Putting YY in MS2bits of Buffer+1,u (2,u)
* And XX in MS2bits of Buffer+0,u (1,u)
* And we have now set Btn.Cntr to 1+ buttons
*======================================
* we arrive here in sync, with BT.Cntr,u
* in a, ( s/b 1 or 2) but buttons not masked out
*======================================
ChkOfst  inc   Btn.Cntr,u count byte
	 lda   Btn.Cntr,u
	 anda  #BC.RxCnt  mask out btns
	 cmpa  #PcktSize last byte std pkt?
         bcs   SaveData   no, go save YYXX mouse data to Rx buffer...

* this is a good place to handle the center button in the 4th byte
DoCBtn	 lda   Btn.Cntr,u get old button status
	 bitb  #MD.ButnC  is 4th byte, status of middle button?
	 beq   BtnCUp
	 ora   #BC.ButnC set middle button
	 bra   BtnCfn
BtnCUp   anda  #BU.ButnC unset it
BtnCfn	 sta   Btn.Cntr,u put back new status
* GH - 01/07/2008 switch out the M$ center button
* code till next reboot
SetLgtk  lda   #'L
	 sta   Buffer,u set Lgtk mode
	 clrb
	 rts

* we arrive here with byte #(2 or 3) in a, rx byte in b
* offset a,u is sync bytes %YY000000 or %XX000000
SaveData orb   a,u	incl 2 ms bits
	 stb   a,u      save Y or X position byte to mouse data Rx buffer
* Is last of YYXX data if a=3 here
	 cmpa  #PcktSize-1
	 bne   NotLstXY  not last byte
* GH - 01/07/2008 do till Logitek sends 4th byte
* check to see if a Logitek mouse has been discovered
CkMSMou  lda   Buffer,u
	 cmpa  #'M
	 bne   DoCalcs skip this
* GH - 01/07/2008 else do M$ style center button
	 lda   Btn.Cntr,u
	 anda  #BC.Butns any btns down?
	 adda  Buffer+1,u add motion
	 adda  Buffer+2,u add motion
	 bne   MBtnCup
	 lda   Btn.Cntr,u
	 ora   #BC.ButnC
	 sta   Btn.Cntr,u
	 bra   NotLstXY no use doing calcs
MBtnCup	 lda   Btn.Cntr,u
	 anda  #BU.ButnC
	 sta   Btn.Cntr,u
DoCalcs	 ldx   #HResMaxY*2 get maximum Y position
         pshs  x          save it for CalcPos subroutine
         leax  CrntYPos,u point to current Y position
* arrive here  with regs b=YY
* Y motion is bass ackwards so
	 comb  complement
	 incb  2's complement
         bsr   CalcPos    go calculate & save mouse's new Y position
* now get full XX data
         ldb   Buffer+1,u get X offset
         ldx   #HResMaxX  get maximum X position
         stx   ,s         save it for CalcPos subroutine
         leax  CrntXPos,u point to current X position
         bsr   CalcPos    go calculate & save mouse's new X position
         leas  2,s        clean up stack
NotLstXY clrb             clear Carry to mark IRQ serviced
         rts

* destroys A, also slow, needs 12" square mouse pad!
CalcPos  sex              sign extend mouse packet's 2nd XY offset ([D] = -128 to +127)
         pshs  d          save it temporarily...
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

