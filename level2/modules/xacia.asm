********************************************************************
* XACIA - Enhanced 6551 driver
*
* $Id$
*
* Ed.    Comments                                       Who YY/MM/DD
* ------------------------------------------------------------------
* 10     Bruce Isted distribution version               BRI

         nam   XACIA
         ttl   Enhanced 6551 driver

         ifp1  
         use   defsfile
         endc  

* miscellaneous definitions
DCDStBit equ   %00100000  DCD status bit for SS.CDSta call
DSRStBit equ   %01000000  DSR status bit for SS.CDSta call
Edtn     equ   10
Vrsn     equ   1

* conditional assembly flags
*A6551    set   true       6551 SACIA version
*A6552    set   false      65C52 DACIA version
SlpBreak set   TkPerSec/2+1 line Break duration
SlpHngUp set   TkPerSec/4+1 hang up (drop DTR) duration

         ifeq  A6552-true
         nam   DACIA
         ttl   65C52 Dual ACIA driver
         else  

         ifeq  A6551-true
         nam   SACIA
         ttl   6551 Single ACIA driver
         endc  
         endc  

         ifeq  A6552-true
* 65C52 register definitions
         org   0
ISReg    rmb   1          IRQ Status (read only)
IEReg    equ   ISReg      IRQ Enable (write only)
CSReg    rmb   1          Control Status (read only)
CFReg    equ   CSReg      Control/Format (write only)
CDReg    rmb   1          Compare Data (write only, unused in this driver)
TBReg    equ   CDReg      Transmit Break (write only)
DataReg  rmb   1          receive/transmit Data (read Rx / write Tx)

* IRQ Status/Enable bit definitions
ISE.IRQ  equ   %10000000  IRQ occurred/enable
ISE.TxE  equ   %01000000  Tx data register Empty
ISE.CTS  equ   %00100000  CTS transition
ISE.DCD  equ   %00010000  DCD transition
ISE.DSR  equ   %00001000  DSR transition
ISE.FOB  equ   %00000100  Rx data Framing or Overrun error, or Break
ISE.Par  equ   %00000010  Rx data Parity error
ISE.RxF  equ   %00000001  Rx data register Full

ISE.Errs equ   ISE.FOB!ISE.Par IRQ Status error bits
ISE.Flip equ   $00        all ISR bits active when set
ISE.Mask equ   ISE.CTS!ISE.DCD!ISE.DSR!ISE.FOB!ISE.Par!ISE.RxF active IRQs

* Control Status bit definitions
CS.Frame equ   %10000000  framing error (set=error)
CS.TxE   equ   %01000000  Tx data empty (set=empty)
CS.CTS   equ   %00100000  CTS input (set=disabled)
CS.DCD   equ   %00010000  DCD input (set=disabled)
CS.DSR   equ   %00001000  DSR input (set=disabled)
CS.Break equ   %00000100  Rx line break (set=received break)
CS.DTR   equ   %00000010  DTR output (set=disabled)
CS.RTS   equ   %00000001  RTS output (set=disabled)

* Control bit definitions
C.TBRCDR equ   %01000000  Tx Break/Compare Data register access (set=Tx Break)
C.StpBit equ   %00100000  stop bits (set=two, clear=one)
C.Echo   equ   %00010000  local echo (set=activated)
C.Baud   equ   %00001111  see baud rate table below

* baud rate table
         org   0
BR.00050 rmb   1          50 baud (not supported)
BR.00110 rmb   1          109.92 baud
BR.00135 rmb   1          134.58 baud (not supported)
BR.00150 rmb   1          150 baud (not supported)
BR.00300 rmb   1          300 baud
BR.00600 rmb   1          600 baud
BR.01200 rmb   1          1200 baud
BR.01800 rmb   1          1800 baud (not supported)
BR.02400 rmb   1          2400 baud
BR.03600 rmb   1          3600 baud (not supported)
BR.04800 rmb   1          4800 baud
BR.07200 rmb   1          7200 baud (not supported)
BR.09600 rmb   1          9600 baud
BR.19200 rmb   1          19200 baud
BR.38400 rmb   1          38400 baud
BR.ExClk rmb   1          external Rx and Tx clocks (not supported)

* Format bit definitions
F.Slct   equ   %10000000  register select (set=Format, clear=Control)
F.DatBit equ   %01100000  see data bit table below
F.Par    equ   %00011100  see parity table below
F.DTR    equ   %00000010  DTR output (set=disabled)
F.RTS    equ   %00000001  RTS output (set=disabled)

* data bit table
DB.5     equ   %00000000  five data bits per character
DB.6     equ   %00100000  six data bits per character
DB.7     equ   %01000000  seven data bits per character
DB.8     equ   %01100000  eight data bits per character

* parity table
Par.None equ   %00000000
Par.Odd  equ   %00000100
Par.Even equ   %00001100
Par.Mark equ   %00010100
Par.Spac equ   %00011100

* Transmit Break bit definitions
TB.Brk   equ   %00000010  Tx break control (set=transmit continuous line Break)
TB.Par   equ   %00000001  parity check (set=parity bit to ISE.Par, clear=normal)
         else  

         ifeq  A6551-true
* 6551 register definitions
         org   0
DataReg  rmb   1          receive/transmit Data (read Rx / write Tx)
StatReg  rmb   1          status (read only)
PRstReg  equ   StatReg    programmed reset (write only)
CmdReg   rmb   1          command (read/write)
CtlReg   rmb   1          control (read/write)

* Status bit definitions
Stat.IRQ equ   %10000000  IRQ occurred
Stat.DSR equ   %01000000  DSR level (clear = active)
Stat.DCD equ   %00100000  DCD level (clear = active)
Stat.TxE equ   %00010000  Tx data register Empty
Stat.RxF equ   %00001000  Rx data register Full
Stat.Ovr equ   %00000100  Rx data Overrun error
Stat.Frm equ   %00000010  Rx data Framing error
Stat.Par equ   %00000001  Rx data Parity error

Stat.Err equ   Stat.Ovr!Stat.Frm!Stat.Par Status error bits
Stat.Flp equ   $00        all Status bits active when set
Stat.Msk equ   Stat.IRQ!Stat.RxF active IRQs

* Control bit definitions
Ctl.Stop equ   %10000000  stop bits (set=two, clear=one)
Ctl.DBit equ   %01100000  see data bit table below
Ctl.RxCS equ   %00010000  Rx clock source (set=baud rate, clear=external)
Ctl.Baud equ   %00001111  see baud rate table below

* data bit table
DB.8     equ   %00000000  eight data bits per character
DB.7     equ   %00100000  seven data bits per character
DB.6     equ   %01000000  six data bits per character
DB.5     equ   %01100000  five data bits per character

* baud rate table
         org   $00
BR.ExClk rmb   1          16x external clock (not supported)
         org   $11
BR.00050 rmb   1          50 baud (not supported)
BR.00075 rmb   1          75 baud (not supported)
BR.00110 rmb   1          109.92 baud
BR.00135 rmb   1          134.58 baud (not supported)
BR.00150 rmb   1          150 baud (not supported)
BR.00300 rmb   1          300 baud
BR.00600 rmb   1          600 baud
BR.01200 rmb   1          1200 baud
BR.01800 rmb   1          1800 baud (not supported)
BR.02400 rmb   1          2400 baud
BR.03600 rmb   1          3600 baud (not supported)
BR.04800 rmb   1          4800 baud
BR.07200 rmb   1          7200 baud (not supported)
BR.09600 rmb   1          9600 baud
BR.19200 rmb   1          19200 baud

* Command bit definitions
Cmd.Par  equ   %11100000  see parity table below
Cmd.Echo equ   %00010000  local echo (set=activated)
Cmd.TIRB equ   %00001100  see Tx IRQ/RTS/Break table below
Cmd.RxI  equ   %00000010  Rx IRQ (set=disabled)
Cmd.DTR  equ   %00000001  DTR output (set=enabled)

* parity table
Par.None equ   %00000000
Par.Odd  equ   %00100000
Par.Even equ   %01100000
Par.Mark equ   %10100000
Par.Spac equ   %11100000

* Tx IRQ/RTS/Break table
TIRB.Off equ   %00000000  RTS & Tx IRQs disabled
TIRB.On  equ   %00000100  RTS & Tx IRQs enabled
TIRB.RTS equ   %00001000  RTS enabled, Tx IRQs disabled
TIRB.Brk equ   %00001100  RTS enabled, Tx IRQs disabled, Tx line Break
         endc  
         endc  

* V.ERR bit definitions
DCDLstEr equ   %00100000  DCD lost error
OvrFloEr equ   %00000100  Rx data overrun or Rx buffer overflow error
FrmingEr equ   %00000010  Rx data framing error
ParityEr equ   %00000001  Rx data parity error

* FloCtlRx bit definitions
FCRxSend equ   %10000000  send flow control character
FCRxSent equ   %00010000  Rx disabled due to XOFF sent
FCRxDTR  equ   %00000010  Rx disabled due to DTR
FCRxRTS  equ   %00000001  Rx disabled due to RTS

* FloCtlTx bit definitions
FCTxXOff equ   %10000000  due to XOFF received
FCTxBrk  equ   %00000010  due to currently transmitting Break

* Wrk.Type bit definitions
Parity   equ   %11100000  parity bits
MdmKill  equ   %00010000  modem kill option
RxSwFlow equ   %00001000  Rx data software (XON/XOFF) flow control
TxSwFlow equ   %00000100  Tx data software (XON/XOFF) flow control
RTSFlow  equ   %00000010  CTS/RTS hardware flow control
DSRFlow  equ   %00000001  DSR/DTR hardware flow control

* Wrk.Baud bit definitions
StopBits equ   %10000000  number of stop bits code
WordLen  equ   %01100000  word length code
BaudRate equ   %00001111  baud rate code

* Wrk.XTyp bit definitions
SwpDCDSR equ   %10000000  swap DCD+DSR bits (valid for 6551 only)
ForceDTR equ   %01000000  don't drop DTR in term routine
RxBufPag equ   %00001111  input buffer page count

* static data area definitions
         org   V.SCF      allow for SCF manager data area

         ifeq  A6552-true
Cpy.CR   rmb   1          Control register copy (MUST immediately precede Cpy.FR)
Cpy.FR   rmb   1          Format register copy (MUST immediately follow Cpy.CR)
Cpy.ISR  rmb   1          IRQ Status register copy (MUST immediately precede Cpy.CSR)
Cpy.CSR  rmb   1          Control Status register copy (MUST immediately follow Cpy.ISR)
         else  

         ifeq  A6551-true
Cpy.Stat rmb   1          Status register copy
CpyDCDSR rmb   1          DSR+DCD status copy
Mask.DCD rmb   1          DCD status bit mask (MUST immediately precede Mask.DSR)
Mask.DSR rmb   1          DSR status bit mask (MUST immediately follow Mask.DCD)
         endc  
         endc  

CDSigPID rmb   1          process ID for CD signal
CDSigSig rmb   1          CD signal code
FloCtlRx rmb   1          Rx flow control flags
FloCtlTx rmb   1          Tx flow control flags
RxBufEnd rmb   2          end of Rx buffer
RxBufGet rmb   2          Rx buffer output pointer
RxBufMax rmb   2          Send XOFF (if enabled) at this point
RxBufMin rmb   2          Send XON (if XOFF sent) at this point
RxBufPtr rmb   2          pointer to Rx buffer
RxBufPut rmb   2          Rx buffer input pointer
RxBufSiz rmb   2          Rx buffer size
RxDatLen rmb   2          current length of data in Rx buffer
SigSent  rmb   1          keyboard abort/interrupt signal already sent
SSigPID  rmb   1          SS.SSig process ID
SSigSig  rmb   1          SS.SSig signal code
WritFlag rmb   1          initial write attempt flag
Wrk.Type rmb   1          type work byte (MUST immediately precede Wrk.Baud)
Wrk.Baud rmb   1          baud work byte (MUST immediately follow Wrk.Type)
Wrk.XTyp rmb   1          extended type work byte
RxBufDSz equ   256-.      default Rx buffer gets remainder of page...
RxBuff   rmb   RxBufDSz   default Rx buffer
MemSize  equ   .

         mod   ModSize,ModName,Drivr+Objct,ReEnt+Vrsn,ModEntry,MemSize

         fcb   UPDAT.     access mode(s)

         ifeq  A6552-true
ModName  fcs   "DACIA"
         else  

         ifeq  A6551-true
ModName  fcs   "SACIA"
         endc  
         endc  

         fcb   Edtn

SlotSlct fcb   MPI.Slot   selected MPI slot

ModEntry equ   *
         lbra  Init
         lbra  Read
         lbra  Writ
         lbra  GStt
         lbra  SStt
         lbra  Term

IRQPckt  equ   *

         ifeq  A6552-true
Pkt.Flip fcb   ISE.Flip   D.Poll flip byte
Pkt.Mask fcb   ISE.Mask   D.Poll mask byte
         else  

         ifeq  A6551-true
Pkt.Flip fcb   Stat.Flp   flip byte
Pkt.Mask fcb   Stat.Msk   mask byte
         endc  
         endc  

         fcb   $0A        priority

BaudTabl equ   *

         ifeq  A6552-true
         fcb   BR.00110,BR.00300,BR.00600
         fcb   BR.01200,BR.02400,BR.04800
         fcb   BR.09600,BR.19200,BR.38400
         else  

         ifeq  A6551-true
         fcb   BR.00110,BR.00300,BR.00600
         fcb   BR.01200,BR.02400,BR.04800
         fcb   BR.09600,BR.19200
         endc  
         endc  


* NOTE:  SCFMan has already cleared all device memory except for V.PAGE and
*        V.PORT.  Zero-default variables are:  CDSigPID, CDSigSig, Wrk.XTyp.
Init     equ   *
         clrb             default to no error...
         pshs  cc,b,dp    save IRQ/Carry status, dummy B, system DP
         lbsr  SetDP      go set our DP
         pshs  y          save descriptor pointer
         ldd   <V.PORT    base hardware address

         ifeq  A6552-true
         else  

         ifeq  A6551-true
         addd  #1         point to 6551 status address
         endc  
         endc  

         leax  IRQPckt,pcr
         leay  IRQSvc,pcr
         os9   F$IRQ
         puls  y          recover descriptor pointer
         lbcs  ErrExit    go report error...
         ldb   M$Opt,y    get option size
         cmpb  #IT.XTYP-IT.DTP room for extended type byte?
         bls   DfltInfo   no, go use defaults...

         ifeq  A6552-true
         else  

         ifeq  A6551-true
         ldd   #Stat.DCD*256+Stat.DSR default (unswapped) DCD+DSR masks
         tst   IT.XTYP,y  check extended type byte for swapped DCD & DSR bits
         bpl   NoSwap     no, go skip swapping them...
         exg   a,b        swap to DSR+DCD masks
NoSwap   std   <Mask.DCD  save DCD+DSR (or DSR+DCD) masks
         endc  
         endc  

         lda   IT.XTYP,y  get extended type byte
         sta   <Wrk.XTyp  save it
         anda  #RxBufPag  clear all but Rx buffer page count bits
         beq   DfltInfo   none, go use defaults...
         clrb             make data size an even number of pages
         pshs  u          save data pointer
         os9   F$SRqMem   get extended buffer
         tfr   u,x        copy address
         puls  u          recover data pointer
         lbcs  TermExit   error, go remove IRQ entry and exit...
         bra   SetRxBuf

DfltInfo ldd   #RxBufDSz  default Rx buffer size
         leax  RxBuff,u   default Rx buffer address
SetRxBuf std   <RxBufSiz  save Rx buffer size
         stx   <RxBufPtr  save Rx buffer address
         stx   <RxBufGet  set initial Rx buffer input address
         stx   <RxBufPut  set initial Rx buffer output address
         leax  d,x        point to end of Rx buffer
         stx   <RxBufEnd  save Rx buffer end address
         subd  #80        characters available in Rx buffer
         std   <RxBufMax  set auto-XOFF threshold
         ldd   #10        characters remaining in Rx buffer
         std   <RxBufMin  set auto-XON threshold after auto-XOFF

         ifeq  A6552-true
         ldd   #C.TBRCDR*256+(F.Slct!F.DTR!F.RTS) [A]=control, [B]=format register
         sta   <Cpy.CR    save control register copy
         lda   <Wrk.XTyp
         anda  #ForceDTR  forced DTR?
         beq   NoDTR      no, don't enable DTR yet
         andb  #^F.DTR    clear (enable) DTR bit
NoDTR    stb   <Cpy.FR    save format register copy
         else  

         ifeq  A6551-true
         ldb   #TIRB.RTS  default command register
         lda   <Wrk.XTyp
         anda  #ForceDTR  forced DTR?
         beq   NoDTR      no, don't enable DTR yet
         orb   #Cmd.DTR   set (enable) DTR bit
NoDTR    ldx   <V.PORT    get port address
         stb   CmdReg,x   set new command register
         endc  
         endc  

         ldd   IT.PAR,y   [A] = IT.PAR, [B] = IT.BAU from descriptor
         lbsr  SetPort    go save it and set up control/format registers
         orcc  #IntMasks  disable IRQs while setting up hardware
         lda   >PIA1Base+3 get PIA CART* input control register
         anda  #$FC       clear PIA CART* control bits
         sta   >PIA1Base+3 disable PIA CART* FIRQs
         lda   >PIA1Base+2 clear possible pending PIA CART* FIRQ
         lda   #$01       GIME CART* IRQ bit
         ora   >D.IRQER   mask in current GIME IRQ enables
         sta   >D.IRQER   save GIME CART* IRQ enable shadow register
         sta   >IrqEnR    enable GIME CART* IRQs

         ifeq  A6552-true
         lda   #ISE.IRQ!ISE.Mask DACIA IRQ enables
         sta   IEReg,x    enable DACIA IRQs for this port ([X]=V.PORT from SetPort)
         ldb   ISReg,x    ensure old CTS, DCD, and DSR transition IRQ flags are clear
         ldb   DataReg,x  ensure old error and Rx data IRQ flags are clear
         ldb   ISReg,x    ... again
         ldb   DataReg,x  ... and again
         ldd   ISReg,x    get new IRQ and Control status registers
         eora  Pkt.Flip,pcr flip bits per D.Poll
         anda  Pkt.Mask,pcr any IRQ(s) still pending?
         lbne  NRdyErr    yes, go report error... (device not plugged in?)
         std   <Cpy.ISR   save new IRQ and Control status register copies
         else  

         ifeq  A6551-true
         lda   StatReg,x  ensure old IRQ flags are clear
         lda   DataReg,x  ensure old error and Rx data IRQ flags are clear
         lda   StatReg,x  ... again
         lda   DataReg,x  ... and again
         lda   StatReg,x  get new Status register contents
         sta   <Cpy.Stat  save Status copy
         tfr   a,b        copy it...
         eora  Pkt.Flip,pcr flip bits per D.Poll
         anda  Pkt.Mask,pcr any IRQ(s) still pending?
         lbne  NRdyErr    yes, go report error... (device not plugged in?)
         andb  #Stat.DSR!Stat.DCD clear all but DSR+DCD status
         stb   <CpyDCDSR  save new DCD+DSR status copy
         endc  
         endc  

         lda   SlotSlct,pcr get MPI slot select value
         bmi   NoSelect   no MPI slot select, go on...
         sta   >MPI.Slct  set MPI slot select register
NoSelect puls  cc,b,dp,pc recover IRQ/Carry status, dummy B, system DP, return


Term     equ   *
         clrb             default to no error...
         pshs  cc,b,dp    save IRQ/Carry status, dummy B, system DP
         lbsr  SetDP      go set our DP

         ifeq  A6552-true
         lda   #^ISE.IRQ  disable all DACIA IRQs
         ldx   <V.PORT
         sta   IEReg,x    disable DACIA IRQs for this port
         lda   <Cpy.FR    get format register copy
         ora   #F.DTR!F.RTS set (disable) DTR and RTS bits
         ldb   <Wrk.XTyp  get extended type byte
         andb  #ForceDTR  forced DTR?
         beq   KeepDTR    no, go leave DTR disabled...
         anda  #^F.DTR    clear (enable) DTR bit
KeepDTR  sta   CFReg,x    set DTR and RTS enable/disable
         else  

         ifeq  A6551-true
         ldx   <V.PORT
         lda   CmdReg,x   get current Command register contents
         anda  #^(Cmd.TIRB!Cmd.DTR) disable Tx IRQs, RTS, and DTR
         ora   #Cmd.RxI   disable Rx IRQs
         ldb   <Wrk.XTyp  get extended type byte
         andb  #ForceDTR  forced DTR?
         beq   KeepDTR    no, go leave DTR disabled...
         ora   #Cmd.DTR   set (enable) DTR bit
KeepDTR  sta   CmdReg,x   set DTR and RTS enable/disable
         endc  
         endc  

         ldd   <RxBufSiz  get Rx buffer size
         tsta             less than 256 bytes?
         beq   TermExit   yes, no system memory to return...
         pshs  u          save data pointer
         ldu   <RxBufPtr  get address of system memory
         os9   F$SRtMem
         puls  u          recover data pointer
TermExit ldd   <V.PORT    base hardware address is status register

         ifeq  A6552-true
         else  

         ifeq  A6551-true
         addd  #1         point to 6551 status register
         endc  
         endc  

         ldx   #$0000     remove IRQ table entry
         leay  IRQSvc,pcr
         puls  cc         recover IRQ/Carry status
         os9   F$IRQ
         puls  a,dp,pc    restore dummy A, system DP, return


ReadSlp  ldd   >D.Proc    process descriptor address
         sta   <V.WAKE    save MSB for IRQ service routine
         tfr   d,x        copy process descriptor address
         ldb   P$State,x  get process state flag
         orb   #Suspend   set suspend flag
         stb   P$State,x  put process in suspend state
         lbsr  Sleep1     go suspend process...
         ldx   >D.Proc    process descriptor address
         ldb   P$Signal,x pending signal for this process?
         beq   ChkState   no, go check process state...
         cmpb  #S$Intrpt  do we honor signal?
         bls   ErrExit    yes, go do it...
ChkState ldb   P$State,x  get process state
         bitb  #Condem    we be dead?
         bne   PrAbtErr   yes, go do it...
         ldb   <V.WAKE    true interrupt?
         bne   ReadSlp    no, go suspend again...
ReadLoop puls  cc,b,dp    recover IRQ/Carry status, dummy B, system DP

Read     equ   *
         clrb             default to no errors...
         pshs  cc,b,dp    save IRQ/Carry status, dummy B, system DP
         lbsr  SetDP      go set our DP
         orcc  #IntMasks  disable IRQs while checking Rx flow control
         lda   <FloCtlRx  get Rx flow control flags
         beq   ReadChar   none, go get Rx character...
         ldx   <RxDatLen  get Rx data count again
         cmpx  <RxBufMin  at or below XON level?
         bhi   ReadChar   no, go get Rx character...
         ldx   <V.PORT
         bita  #FCRxSent  Rx disabled due to XOFF sent?
         beq   ChkHWHS    no, go check hardware handshake(s)...
         ldb   <FloCtlTx  get Tx flow control flags
         bitb  #FCTxBrk   currently transmitting line Break?
         bne   ReadLoop   yes, go skip XON this time...

         ifeq  A6552-true
         ldb   CSReg,x    get new Control Status register
         bitb  #CS.TxE    Tx data register empty?
         beq   ReadLoop   no, go skip XON this time...
         ldb   <V.XON
         stb   DataReg,x  write XON character
ChkHWHS  bita  #FCRxDTR!FCRxRTS Rx disabled due to DTR or RTS?
         beq   RxFloClr   no, go clear Rx flow control flag(s)...
         ldb   <Cpy.FR    get Format register copy
         andb  #^(F.DTR!F.RTS) clear (enable) DTR and RTS bits
         stb   <Cpy.FR    save Format register copy
         stb   CFReg,x    set Format register
         else  

         ifeq  A6551-true
         ldb   StatReg,x  get new Status register
         bitb  #Stat.TxE  Tx data register empty?
         beq   ReadLoop   no, go skip XON this time...
         ldb   <V.XON
         stb   DataReg,x  write XON character
ChkHWHS  bita  #FCRxDTR!FCRxRTS Rx disabled due to DTR or RTS?
         beq   RxFloClr   no, go clear Rx flow control flag(s)...
         ldb   CmdReg,x   get current Command register contents
         andb  #^Cmd.TIRB clear Tx IRQ/RTS/Break control bits
         orb   #TIRB.RTS!Cmd.DTR enable RTS and DTR, disable Tx IRQs
         stb   CmdReg,x   set Command register
         endc  
         endc  

RxFloClr clr   <FloCtlRx  clear Rx flow control flags
ReadChar ldb   <V.ERR     get accumulated errors, if any
         stb   PD.ERR,y   set/clear error(s) in path descriptor
         bne   ReprtErr   error(s), go report it/them...
         ldx   <RxDatLen  get Rx buffer count
         beq   ReadSlp    none, go sleep while waiting for new Rx data...
         leax  -1,x       less character we're about to grab
         stx   <RxDatLen  save new Rx data count
         ldx   <RxBufGet  current Rx buffer pickup position
         lda   ,x+        get Rx character, set up next pickup position
         cmpx  <RxBufEnd  end of Rx buffer?
         blo   SetPckUp   no, go keep pickup pointer
         ldx   <RxBufPtr  get Rx buffer start address
SetPckUp stx   <RxBufGet  set new Rx data pickup pointer
         puls  cc,b,dp,pc recover IRQ/Carry status, dummy B, system DP, return


PrAbtErr ldb   #E$PrcAbt
         bra   ErrExit

ReprtErr clr   <V.ERR     clear error status
         bitb  #DCDLstEr  DCD lost error?
         bne   HngUpErr   yes, go report it...
         ldb   #E$Read
ErrExit  puls  cc         restore IRQ enable and Carry status
         coma             error, set Carry
         puls  a,dp,pc    restore dummy A (or Tx character), system DP, return

HngUpErr ldb   #E$HangUp
         lda   #PST.DCD   DCD lost flag
         sta   PD.PST,y   set path status flag
         bra   ErrExit

NRdyErr  ldb   #E$NotRdy
         bra   ErrExit

UnSvcErr ldb   #E$UnkSvc
         bra   ErrExit


WritLoop lda   <WritFlag  first pass through for this Tx character?
         beq   WritFast   yes, don't sleep yet...
         lbsr  Sleep1     go sleep for balance of tick...
WritFast inc   <WritFlag  set "initial write attempt" flag
         puls  cc,a,dp    recover IRQ/Carry status, Tx character, system DP

Writ     equ   *
         clrb             default to no error...
         pshs  cc,a,dp    save IRQ/Carry status, Tx character, system DP
         lbsr  SetDP      go set our DP
         ldx   <V.PORT
         orcc  #IntMasks  disable IRQs during error and Tx disable checks
         ldb   <V.ERR     get accumulated errors, if any
         andb  #DCDLstEr  DCD lost error? (ignore other errors, if any)
         stb   PD.ERR,y   set/clear error(s) in path descriptor
         bne   ReprtErr   DCD lost error, go report it...

         ifeq  A6552-true
         ldb   <Cpy.CSR   get copy of control status register
         bitb  #CS.CTS    Tx disabled due to CTS?
         bne   WritLoop   yes, go sleep a while...
         lda   <Wrk.Type  get software/hardware handshake enables
         bita  #DSRFlow   DSR/DTR handshake enabled?
         beq   ChkTxFlo   no, go check Tx flow control
         bitb  #CS.DSR    Tx disabled due to DSR?
         bne   WritLoop   yes, go sleep a while...
         else  

         ifeq  A6551-true
         lda   <Wrk.Type  get software/hardware handshake enables
         bita  #DSRFlow   DSR/DTR handshake enabled?
         beq   ChkTxFlo   no, go check Tx flow control
         ldb   <Cpy.Stat  get copy of status register
         bitb  <Mask.DSR  Tx disabled due to DSR?
         bne   WritLoop   yes, go sleep a while...
         endc  
         endc  

ChkTxFlo ldb   <FloCtlTx  get Tx flow control flags
         bitb  #FCTxBrk   currently transmitting line Break?
         bne   WritLoop   yes, go sleep a while...
         bita  #TxSwFlow  Tx software flow control enabled?
         beq   ChkRxFlo   no, go check pending Rx flow control
         bitb  #FCTxXOff  Tx disabled due to received XOFF?
         bne   WritLoop   yes, go sleep a while...
ChkRxFlo bita  #RxSwFlow  Rx software flow control enabled?
         beq   ChkTxE     no, go check Tx register empty
         ldb   <FloCtlRx  get Rx flow control flags
         bitb  #FCRxSend  XON/XOFF Rx flow control pending?
         bne   WritLoop   yes, go sleep a while...
ChkTxE   lda   1,s        get Tx character

         ifeq  A6552-true
         ldb   CSReg,x    get new control status register
         bitb  #CS.TxE    Tx register empty?
         beq   WritLoop   no, go sleep a while...
         sta   DataReg,x  write Tx character
         else  

         ifeq  A6551-true
         ldb   StatReg,x  get new status register
         bitb  #Stat.TxE  Tx register empty?
         beq   WritLoop   no, go sleep a while...
         sta   DataReg,x  write Tx character
         endc  
         endc  

         clr   <WritFlag  clear "initial write attempt" flag
         puls  cc,a,dp,pc recover IRQ/Carry status, Tx character, system DP, return


GStt     equ   *
         clrb             default to no error...
         pshs  cc,b,dp    save IRQ/Carry status, dummy B, system DP
         lbsr  SetDP      go set our DP
         ldx   PD.RGS,y   caller's register stack pointer
         cmpa  #SS.EOF
         beq   GSExitOK   yes, SCF devices never return EOF
         cmpa  #SS.Ready
         bne   GetScSiz
         ldd   <RxDatLen  get Rx data length
         beq   NRdyErr    none, go report error
         tsta             more than 255 bytes?
         beq   SaveLen    no, keep Rx data available
         ldb   #255       yes, just use 255
SaveLen  stb   R$B,x      set Rx data available in caller's [B]
GSExitOK puls  cc,b,dp,pc restore Carry status, dummy B, system DP, return

GetScSiz cmpa  #SS.ScSiz
         bne   GetComSt
         ldu   PD.DEV,y
         ldu   V$DESC,u
         clra  
         ldb   IT.COL,u
         std   R$X,x
         ldb   IT.ROW,u
         std   R$Y,x
         puls  cc,b,dp,pc restore Carry status, dummy B, system DP, return

GetComSt cmpa  #SS.ComSt
         lbne  UnSvcErr   no, go report error
         ldd   <Wrk.Type
         std   R$Y,x
         clra             default to DCD and DSR enabled

         ifeq  A6552-true
         ldb   <Cpy.CSR   get current status
         bitb  #CS.DCD    DCD bit set (disabled)?
         else  

         ifeq  A6551-true
         ldb   <CpyDCDSR  get current DSR+DCD status
         bitb  <Mask.DCD  DCD bit set (disabled)?
         endc  
         endc  

         beq   CheckDSR   no, go check DSR status
         ora   #DCDStBit

         ifeq  A6552-true
CheckDSR bitb  #CS.DSR    DSR bit set (disabled)?
         else  

         ifeq  A6551-true
CheckDSR bitb  <Mask.DSR  DSR bit set (disabled)?
         endc  
         endc  

         beq   SaveCDSt   no, go set DCD/DSR status
         ora   #DSRStBit
SaveCDSt sta   R$B,x      set 6551 ACIA style DCD/DSR status in caller's [B]
         puls  cc,b,dp,pc restore Carry status, dummy B, system DP, return


BreakSlp ldx   #SlpBreak  SS.Break duration
         bra   TimedSlp
HngUpSlp ldx   #SlpHngUp  SS.HngUp duration
         bra   TimedSlp
Sleep1   ldx   #1         give up balance of tick
TimedSlp pshs  cc         save IRQ enable status
         andcc  #Intmasks  enable IRQs
         os9   F$Sleep
         puls  cc,pc      restore IRQ enable status, return


SStt     equ   *
         clrb             default to no error...
         pshs  cc,b,dp    save IRQ/Carry status, dummy B, system DP
         lbsr  SetDP      go set our DP
         ldx   PD.RGS,y
         cmpa  #SS.HngUp
         bne   SetBreak

         ifeq  A6552-true
         lda   #F.DTR     set (disable) DTR bit
         ldx   <V.PORT
         orcc  #IntMasks  disable IRQs while setting Format register
         ora   <Cpy.FR    mask in Format register copy
         sta   <Cpy.FR    save Format register copy
         sta   CFReg,x    set new Format register
         bsr   HngUpSlp   go sleep for a while...
         lda   #^(F.DTR!F.RTS) clear (enable) DTR and RTS bits
FRegClr  ldx   <V.PORT
         anda  <Cpy.FR    mask in Format register copy
         ldb   <FloCtlRx  get Rx flow control flags
         bitb  #FCRxDTR   Rx disabled due to DTR?
         beq   LeaveDTR   no, go leave DTR enabled
         ora   #F.DTR     set (disable) DTR bit
LeaveDTR bitb  #FCRxRTS   Rx disabled due to RTS?
         beq   LeaveRTS   no, go leave RTS enabled
         ora   #F.RTS     set (disable) RTS bit
LeaveRTS sta   <Cpy.FR    save Format register copy
         sta   CFReg,x    set new Format register
         else  

         ifeq  A6551-true
         lda   #^Cmd.DTR  cleared (disabled) DTR bit
         ldx   <V.PORT
         orcc  #IntMasks  disable IRQs while setting Command register
         anda  CmdReg,x   mask in current Command register contents
         sta   CmdReg,x   set new Command register
         bsr   HngUpSlp   go sleep for a while...
BreakClr lda   #^(Cmd.TIRB!Cmd.DTR) clear (disable) DTR and RTS control bits
FRegClr  ldx   <V.PORT
         anda  CmdReg,x   mask in current Command register
         ldb   <FloCtlRx  get Rx flow control flags
         bitb  #FCRxDTR   Rx disabled due to DTR?
         bne   LeaveDTR   yes, go leave DTR disabled
         ora   #Cmd.DTR   set (enable) DTR bit
LeaveDTR bitb  #FCRxRTS   Rx disabled due to RTS?
         bne   LeaveRTS   yes, go leave RTS disabled
         ora   #TIRB.RTS  enable RTS output
LeaveRTS ldb   <FloCtlTx  get Tx flow control flags
         bitb  #FCTxBrk   currently transmitting line Break?
         beq   NotTxBrk   no, go leave RTS alone...
         ora   #TIRB.Brk  set Tx Break bits
NotTxBrk sta   CmdReg,x   set new Command register
         endc  
         endc  

         puls  cc,b,dp,pc restore IRQ/Carry status, dummy B, system DP, return

SetBreak cmpa  #SS.Break  Tx line break?
         bne   SetSSig

         ifeq  A6552-true
         ldy   <V.PORT
         ldd   #FCTxBrk*256+TB.Brk [A]=flow control flag, [B]=Tx break enable
         orcc  #Intmasks  disable IRQs while messing with flow control flags
         ora   <FloCtlTx  set Tx break flag bit
         sta   <FloCtlTx  save Tx flow control flags
         stb   TBReg,y    start Tx line break
         bsr   BreakSlp   go sleep for a while...
         anda  #^FCTxBrk  clear Tx break flag bit
         sta   <FloCtlTx  save Tx flow control flags
         clr   TBReg,y    end Tx line break
         puls  cc,b,dp,pc restore IRQ/Carry status, dummy B, system DP, return
         else  

         ifeq  A6551-true
         ldy   <V.PORT
         ldd   #FCTxBrk*256+TIRB.Brk [A]=flow control flag, [B]=Tx break enable
         orcc  #Intmasks  disable IRQs while messing with flow control flags
         ora   <FloCtlTx  set Tx break flag bit
         sta   <FloCtlTx  save Tx flow control flags
         orb   CmdReg,y   set Tx line break bits
         stb   CmdReg,y   start Tx line break
         bsr   BreakSlp   go sleep for a while...
         anda  #^FCTxBrk  clear Tx break flag bit
         sta   <FloCtlTx  save Tx flow control flags
         bra   BreakClr   go restore RTS output to previous...
         endc  
         endc  

SetSSig  cmpa  #SS.SSig
         bne   SetRelea
         lda   PD.CPR,y   current process ID
         ldb   R$X+1,x    LSB of [X] is signal code
         orcc  #IntMasks  disable IRQs while checking Rx data length
         ldx   <RxDatLen
         bne   RSendSig
         std   <SSigPID
         puls  cc,b,dp,pc restore IRQ/Carry status, dummy B, system DP, return
RSendSig puls  cc         restore IRQ/Carry status
         os9   F$Send
         puls  a,dp,pc    restore dummy A, system DP, return

SetRelea cmpa  #SS.Relea
         bne   SetCDSig
         leax  SSigPID,u  point to Rx data signal process ID
         bsr   ReleaSig   go release signal...
         puls  cc,b,dp,pc restore Carry status, dummy B, system DP, return

SetCDSig cmpa  #SS.CDSig  set DCD signal?
         bne   SetCDRel
         lda   PD.CPR,y   current process ID
         ldb   R$X+1,x    LSB of [X] is signal code
         std   <CDSigPID
         puls  cc,b,dp,pc restore Carry status, dummy B, system DP, return

SetCDRel cmpa  #SS.CDRel  release DCD signal?
         bne   SetComSt
CDRelSig leax  CDSigPID,u point to DCD signal process ID
         bsr   ReleaSig   go release signal...
         puls  cc,b,dp,pc restore Carry status, dummy B, system DP, return

SetComSt cmpa  #SS.ComSt
         bne   SetOpen
         ldd   R$Y,x      caller's [Y] contains ACIAPAK format type/baud info
         bsr   SetPort    go save it and set up control/format registers
ReturnOK puls  cc,b,dp,pc restore Carry status, dummy B, system DP, return

SetOpen  cmpa  #SS.Open
         bne   SetClose
         lda   R$Y+1,x    get LSB of caller's [Y]
         deca             real SS.Open from SCF? (SCF sets LSB of [Y] = 1)
         bne   ReturnOK   no, go do nothing but return OK...

         ifeq  A6552-true
         lda   #^(F.DTR!F.RTS) clear (enable) DTR and RTS bits
         else  

         ifeq  A6551-true
         lda   #TIRB.RTS  enabled DTR and RTS outputs
         endc  
         endc  

         orcc  #IntMasks  disable IRQs while setting Format register
         lbra  FRegClr    go enable DTR and RTS (if not disabled due to Rx flow control)

SetClose cmpa  #SS.Close
         lbne  UnSvcErr   no, go report error...
         lda   R$Y+1,x    real SS.Close from SCF? (SCF sets LSB of [Y] = 0)
         bne   ReturnOK   no, go do nothing but return OK...
         leax  SSigPID,u  point to Rx data signal process ID
         bsr   ReleaSig   go release signal...
         bra   CDRelSig   go release DCD signal, return from there...

ReleaSig pshs  cc         save IRQ enable status
         orcc  #IntMasks  disable IRQs while releasing signal
         lda   PD.CPR,y   get current process ID
         suba  ,x         same as signal process ID?
         bne   NoReleas   no, go return...
         sta   ,x         clear this signal's process ID
NoReleas puls  cc,pc      restore IRQ enable status, return

         ifeq  A6552-true
SetPort  pshs  cc         save IRQ enable and Carry status
         orcc  #IntMasks  disable IRQs while setting up DACIA registers
         std   <Wrk.Type  save type/baud in data area
         lsra             *shift parity bits into
         lsra             *position for 65C52's
         lsra             *format register
         anda  #F.Par     clear all except parity bits
         pshs  a          save parity temporarily
         comb             translate word length bits to 65C52's word length code
         andb  #F.DatBit  clear all except word length bits
         orb   ,s+        mask in parity and clean up stack
         lda   <Wrk.Baud  get baud information
         anda  #BaudRate  clear all but baud rate bits
         leax  BaudTabl,pcr
         lda   a,x        get baud rate setting
         pshs  a          save it temporarily
         lda   <Wrk.Baud  get stop bit(s) information
         lsra             *shift stop bit into position
         lsra             *for 65C52's control register
         anda  #C.StpBit  clear all except stop bit code
         ora   ,s+        mask in baud rate and clean up stack
         pshs  d          save stopbits/baudrate and wordlength/parity temporarily
         ldd   <Cpy.CR    get old control/format register copies
         anda  #^(C.StpBit!C.Baud) clear stop bit and baud rate code bits
         ora   ,s+        mask in stop bit(s) and baud rate
         andb  #^(F.DatBit!F.Par) clear word length and parity code bits
         orb   ,s+        mask in word length and parity
         ldx   <V.PORT    get port address
         std   <Cpy.CR    save control/format register copies
         sta   CFReg,x    set control register
         stb   CFReg,x    set format register
         puls  cc,pc      recover IRQ enable and Carry status, return...
         else  

         ifeq  A6551-true
SetPort  pshs  cc         save IRQ enable and Carry status
         orcc  #IntMasks  disable IRQs while setting up ACIA registers
         std   <Wrk.Type  save type/baud in data area
         leax  BaudTabl,pcr
         andb  #BaudRate  clear all but baud rate bits
         ldb   b,x        get baud rate setting
         pshs  b          save it temporarily
         ldb   <Wrk.Baud  get baud info again
         andb  #^(Ctl.RxCS!Ctl.Baud) clear clock source + baud rate code bits
         orb   ,s+        mask in clock source + baud rate and clean up stack
         ldx   <V.PORT    get port address
         anda  #Cmd.Par   clear all except parity bits
         pshs  a          save new command register contents temporarily
         lda   CmdReg,x   get current command register contents
         anda  #^Cmd.Par  clear parity control bits
         ora   ,s+        mask in new parity
         std   CmdReg,x   set command+control registers
         puls  cc,pc      recover IRQ enable and Carry status, return...
         endc  
         endc  

SetDP    pshs  u          save our data pointer
         puls  dp         set our DP
         leas  1,s        clean up stack
         rts   

AccumErr ora   <V.ERR
         sta   <V.ERR
         rts   


         ifeq  A6552-true
IRQSvc   equ   *
         pshs  dp         save system DP
         bsr   SetDP      go set our DP
         ldx   <V.PORT
         ldb   CSReg,x    get current Control/Status register
         std   <Cpy.ISR   save ISR (from D.Poll check) and CSR copies
         bita  #ISE.FOB!ISE.Par FRM/OVR/BRK or Parity error?
         beq   ChkRDRF    no, go check Rx data
         tst   DataReg,x  read Rx data register to clear DACIA error flags
         bitb  #CS.Break  Rx line break?
         beq   ChkParty   no, go check if parity error...
         lda   <V.QUIT    default to keyboard quit ("Break") code
         bra   RxBreak    go pretend we've received V.QUIT character...

ChkParty anda  #ISE.Par   parity error?
         beq   ChkFrame   no, go check framing error
         lda   #ParityEr  mark parity error
ChkFrame bitb  #CS.Frame  framing error?
         beq   ChkOvRun   no, go check overrun error...
         ora   #FrmingEr  mark Framing error
ChkOvRun tsta             any other error flag(s) set?
         bne   SaveErrs   yes, go save them...
         ora   #OvrFloEr  must be overrun error, mark it
SaveErrs bsr   AccumErr   go save accumulated errors...
         lbra  ChkTrDCD   go check if DCD transition...

ChkRDRF  bita  #ISE.RxF   Rx data?
         lbeq  ChkTrDCD   no, go check DCD transition
         lda   DataReg,x  get Rx data
RxBreak  beq   SavRxDat   its a null, go save it...
         clr   <SigSent   clear signal sent flag
         cmpa  <V.INTR    interrupt?
         bne   Chk.Quit   no, go on...
         ldb   #S$Intrpt
         bra   SendSig
Chk.Quit cmpa  <V.QUIT    abort?
         bne   Chk.PChr   no, go on...
         ldb   #S$Abort
SendSig  pshs  a          save Rx data
         lda   <V.LPRC    get last process' ID
         os9   F$Send
         puls  a          recover Rx data
         stb   <SigSent   set signal sent flag
         bra   SavRxDat   go save Rx data...
Chk.PChr cmpa  <V.PCHR    pause?
         bne   Chk.Flow   no, go on...
         ldx   <V.DEV2    attached device defined?
         beq   SavRxDat   no, go save Rx data...
         sta   V.PAUS,x   yes, pause attached device
         bra   SavRxDat   go save Rx data...
Chk.Flow ldb   <Wrk.Type
         bitb  #TxSwFlow  Tx data software flow control enabled?
         beq   SavRxDat   no, go save Rx data...
         cmpa  <V.XON     XON?
         bne   Chk.XOff   no, go on...
         ldb   #^FCTxXOff clear XOFF received bit
         andb  <FloCtlTx  clear software Tx flow control flag
         bra   SetTxFlo   go save new Tx flow control flags...
Chk.XOff cmpa  <V.XOFF    XOFF?
         bne   SavRxDat   no, go save Rx data...
         ldb   #FCTxXOff  set XOFF received bit
         orb   <FloCtlTx  set software Tx flow control flag
SetTxFlo stb   <FloCtlTx  save new Tx flow control flags
         lbra  ChkTrDCD   go check DCD transition...
SavRxDat ldb   <FloCtlRx  get Rx flow control flags
         andb  #^FCRxSend clear possible pending XOFF flag
         stb   <FloCtlRx  save Rx flow control flags
         ldy   <RxBufPut  get Rx buffer input pointer
         ldx   <RxDatLen  Rx get Rx buffer data length
         cmpx  <RxBufSiz  Rx buffer already full?
         blo   NotOvFlo   no, go skip overflow error...
         lda   #OvrFloEr  mark Rx buffer overflow
         lbsr  AccumErr   go save accumulated errors...
         bra   DisRxFlo   go ensure Rx is disabled (if possible)
NotOvFlo sta   ,y+        save Rx data
         cmpy  <RxBufEnd  end of Rx buffer?
         blo   SetLayDn   no, go keep laydown pointer
         ldy   <RxBufPtr  get Rx buffer start address
SetLayDn sty   <RxBufPut  set new Rx data laydown pointer
         leax  1,x        one more byte in Rx buffer
         stx   <RxDatLen  save new Rx data length
         cmpx  <RxBufMax  at or past maximum (XOFF) fill point?
         blo   SgnlRxD    no, go check Rx data signal...
DisRxFlo lda   <Wrk.XTyp
         ldb   <Cpy.FR    get Format register copy
         bita  #ForceDTR  forced DTR?
         bne   DisRxRTS   yes, go check RTS disable...
         lda   <Wrk.Type
         bita  #DSRFlow   DSR/DTR flow control enabled?
         beq   DisRxRTS   no, go check RTS disable
         lda   <FloCtlRx  get Rx flow control flags
         ora   #FCRxDTR   mark Rx disabled by DTR
         sta   <FloCtlRx  save new Rx flow control flags
         orb   #F.DTR     set (disable) DTR bit
DisRxRTS lda   <Wrk.Type
         bita  #RTSFlow   CTS/RTS flow control enabled?
         beq   NewRxFlo   no, go set new Rx flow control...
         lda   <FloCtlRx  get Rx flow control flags
         ora   #FCRxRTS   mark Rx disabled by RTS
         sta   <FloCtlRx  save new Rx flow control flags
         orb   #F.RTS     set (disable) RTS bit
NewRxFlo ldx   <V.PORT
         stb   <Cpy.FR    save Format register copy
         stb   CFReg,x    set/clear DTR and RTS in Format register
         lda   <Wrk.Type
         bita  #RxSwFlow  Rx data software flow control enabled?
         beq   SgnlRxD    no, go check Rx data signal...
         lda   <V.XOFF    XOFF character defined?
         beq   SgnlRxD    no, go check Rx data signal...
         ldb   <FloCtlRx  get Rx flow control flags
         bitb  #FCRxSent  XOFF already sent?
         bne   SgnlRxD    yes, go check Rx data signal...
         orb   #FCRxSend  set send XOFF flag
         stb   <FloCtlRx  set new Rx flow control flags
         ldb   <Cpy.CSR   get Control status register copy
         bitb  #CS.TxE    Tx data register empty?
         beq   SgnlRxD    no, go skip XOFF this time...
         sta   DataReg,x  write XOFF character
         ldb   #FCRxSent  set XOFF sent flag
         orb   <FloCtlRx  mask in current Rx flow control flags
         andb  #^FCRxSend clear send XOFF flag
         stb   <FloCtlRx  save new flow control flags
SgnlRxD  ldb   <SigSent   already sent abort/interrupt signal?
         bne   ChkTrDCD   yes, go check DCD transition...
         lda   <SSigPID   Rx data signal process ID?
         beq   ChkTrDCD   none, go check DCD transition...
         ldb   <SSigSig   Rx data signal code
         clr   <SSigPID   clear Rx data signal
         os9   F$Send

ChkTrDCD ldd   <Cpy.ISR   get IRQ and Control Status copies
         bita  #ISE.DCD   DCD transition?
         beq   CkSuspnd   no, go check for suspended process...
         bitb  #CS.DCD    DCD disabled now?
         beq   SgnlDCD    no, go check DCD signal...
         lda   <Wrk.Type
         bita  #MdmKill   modem kill enabled?
         beq   SgnlDCD    no, go on...
         ldx   <V.PDLHd   path descriptor list header
         beq   StCDLost   no list, go set DCD lost error...
         lda   #PST.DCD   DCD lost flag
PDListLp sta   PD.PST,x   set path status flag
         ldx   PD.PLP,x   get next path descriptor in list
         bne   PDListLp   not end of list, go do another...
StCDLost lda   #DCDLstEr  DCD lost error flag
         lbsr  AccumErr   go save accumulated errors...
SgnlDCD  lda   <CDSigPID  get process ID, send a DCD signal?
         beq   CkSuspnd   no, go check for suspended process...
         ldb   <CDSigSig  get DCD signal code
         clr   <CDSigPID  clear DCD signal
         os9   F$Send

CkSuspnd clrb             clear Carry (for exit) and LSB of process descriptor address
         lda   <V.WAKE    anybody waiting? ([D]=process descriptor address)
         beq   IRQExit    no, go return...
         stb   <V.WAKE    mark I/O done
         tfr   d,x        copy process descriptor pointer
         lda   P$State,x  get state flags
         anda  #^Suspend  clear suspend state
         sta   P$State,x  save state flags
IRQExit  puls  dp,pc      recover system DP, return...
         else  

         ifeq  A6551-true
IRQSvc   equ   *
         pshs  dp         save system DP
         bsr   SetDP      go set our DP
         ldx   <V.PORT
         ldb   StatReg,x  get current Status register contents
         stb   <Cpy.Stat  save Status register copy
         bitb  #Stat.Err  error(s)?
         beq   ChkRDRF    no, go check Rx data
         tst   DataReg,x  read Rx data register to clear ACIA error flags
         bitb  #Stat.Frm  framing error (assume Rx line Break)?
         beq   ChkParty   no, go check if parity error...
         lda   <V.QUIT    default to keyboard quit ("Break") code
         bra   RxBreak    go pretend we've received V.QUIT character...

ChkParty clra             clear old IRQ status
         bitb  #Stat.Par  parity error?
         beq   ChkOvRun   no, go check overrun error...
         ora   #ParityEr  mark parity error
ChkOvRun bita  #Stat.Ovr  overrun error?
         beq   SaveErrs   no, go save errors...
         ora   #OvrFloEr  mark overrun error
SaveErrs bsr   AccumErr   go save accumulated errors...
         lbra  ChkTrDCD   go check if DCD transition...

ChkRDRF  bitb  #Stat.RxF  Rx data?
         lbeq  ChkTrDCD   no, go check DCD transition
         lda   DataReg,x  get Rx data
RxBreak  beq   SavRxDat   its a null, go save it...
         clr   <SigSent   clear signal sent flag
         cmpa  <V.INTR    interrupt?
         bne   Chk.Quit   no, go on...
         ldb   #S$Intrpt
         bra   SendSig
Chk.Quit cmpa  <V.QUIT    abort?
         bne   Chk.PChr   no, go on...
         ldb   #S$Abort
SendSig  pshs  a          save Rx data
         lda   <V.LPRC    get last process' ID
         os9   F$Send
         puls  a          recover Rx data
         stb   <SigSent   set signal sent flag
         bra   SavRxDat   go save Rx data...
Chk.PChr cmpa  <V.PCHR    pause?
         bne   Chk.Flow   no, go on...
         ldx   <V.DEV2    attached device defined?
         beq   SavRxDat   no, go save Rx data...
         sta   V.PAUS,x   yes, pause attached device
         bra   SavRxDat   go save Rx data...
Chk.Flow ldb   <Wrk.Type
         bitb  #TxSwFlow  Tx data software flow control enabled?
         beq   SavRxDat   no, go save Rx data...
         cmpa  <V.XON     XON?
         bne   Chk.XOff   no, go on...
         ldb   #^FCTxXOff clear XOFF received bit
         andb  <FloCtlTx  clear software Tx flow control flag
         bra   SetTxFlo   go save new Tx flow control flags...
Chk.XOff cmpa  <V.XOFF    XOFF?
         bne   SavRxDat   no, go save Rx data...
         ldb   #FCTxXOff  set XOFF received bit
         orb   <FloCtlTx  set software Tx flow control flag
SetTxFlo stb   <FloCtlTx  save new Tx flow control flags
         lbra  ChkTrDCD   go check DCD transition...
SavRxDat ldb   <FloCtlRx  get Rx flow control flags
         andb  #^FCRxSend clear possible pending XOFF flag
         stb   <FloCtlRx  save Rx flow control flags
         ldy   <RxBufPut  get Rx buffer input pointer
         ldx   <RxDatLen  Rx get Rx buffer data length
         cmpx  <RxBufSiz  Rx buffer already full?
         blo   NotOvFlo   no, go skip overflow error...
         lda   #OvrFloEr  mark Rx buffer overflow
         lbsr  AccumErr   go save accumulated errors...
         bra   DisRxFlo   go ensure Rx is disabled (if possible)
NotOvFlo sta   ,y+        save Rx data
         cmpy  <RxBufEnd  end of Rx buffer?
         blo   SetLayDn   no, go keep laydown pointer
         ldy   <RxBufPtr  get Rx buffer start address
SetLayDn sty   <RxBufPut  set new Rx data laydown pointer
         leax  1,x        one more byte in Rx buffer
         stx   <RxDatLen  save new Rx data length
         cmpx  <RxBufMax  at or past maximum fill point?
         blo   SgnlRxD    no, go check Rx data signal...
DisRxFlo ldx   <V.PORT
         lda   <Wrk.XTyp
         ldb   CmdReg,x   get current Command register contents
         bita  #ForceDTR  forced DTR?
         bne   DisRxRTS   yes, go check RTS disable...
         lda   <Wrk.Type
         bita  #DSRFlow   DSR/DTR flow control enabled?
         beq   DisRxRTS   no, go check RTS disable
         lda   <FloCtlRx  get Rx flow control flags
         ora   #FCRxDTR   mark Rx disabled by DTR
         sta   <FloCtlRx  save new Rx flow control flags
         andb  #^Cmd.DTR  clear (disable) DTR bit
DisRxRTS lda   <Wrk.Type
         bita  #RTSFlow   CTS/RTS flow control enabled?
         beq   NewRxFlo   no, go set new Rx flow control...
         lda   <FloCtlTx  get Tx flow control flags
         bita  #FCTxBrk   currently transmitting line Break?
         bne   NewRxFlo   yes, go set new Rx flow control...
         lda   <FloCtlRx  get Rx flow control flags
         ora   #FCRxRTS   mark Rx disabled by RTS
         sta   <FloCtlRx  save new Rx flow control flags
         andb  #^Cmd.TIRB clear Tx IRQ/RTS/Break control bits (disable RTS)
NewRxFlo stb   CmdReg,x   set/clear DTR and RTS in Command register
         lda   <Wrk.Type
         bita  #RxSwFlow  Rx software flow control enabled?
         beq   SgnlRxD    no, go check Rx data signal...
         lda   <V.XOFF    XOFF character defined?
         beq   SgnlRxD    no, go check Rx data signal...
         ldb   <FloCtlRx  get Rx flow control flags
         bitb  #FCRxSent  XOFF already sent?
         bne   SgnlRxD    yes, go check Rx data signal...
         orb   #FCRxSend  set send XOFF flag
         stb   <FloCtlRx  set new Rx flow control flags
         ldb   StatReg,x  get new Status register
         bitb  #Stat.TxE  Tx data register empty?
         beq   SgnlRxD    no, go skip XOFF this time...
         sta   DataReg,x  write XOFF character
         ldb   #FCRxSent  set XOFF sent flag
         orb   <FloCtlRx  mask in current Rx flow control flags
         andb  #^FCRxSend clear send XOFF flag
         stb   <FloCtlRx  save new flow control flags
SgnlRxD  ldb   <SigSent   already sent abort/interrupt signal?
         bne   ChkTrDCD   yes, go check DCD transition...
         lda   <SSigPID   Rx data signal process ID?
         beq   ChkTrDCD   none, go check DCD transition...
         ldb   <SSigSig   Rx data signal code
         clr   <SSigPID   clear Rx data signal
         os9   F$Send

ChkTrDCD ldx   <V.PORT
         lda   <Cpy.Stat  get Status register copy
         tfr   a,b        copy it...
         eora  <CpyDCDSR  mark changes from old DSR+DCD status copy
         andb  #Stat.DSR!Stat.DCD clear all but DSR+DCD status
         stb   <CpyDCDSR  save new DSR+DCD status copy
         bita  <Mask.DCD  DCD transition?
         beq   CkSuspnd   no, go check for suspended process...
         bitb  <Mask.DCD  DCD disabled now?
         beq   SgnlDCD    no, go check DCD signal...
         lda   <Wrk.Type
         bita  #MdmKill   modem kill enabled?
         beq   SgnlDCD    no, go on...
         ldx   <V.PDLHd   path descriptor list header
         beq   StCDLost   no list, go set DCD lost error...
         lda   #PST.DCD   DCD lost flag
PDListLp sta   PD.PST,x   set path status flag
         ldx   PD.PLP,x   get next path descriptor in list
         bne   PDListLp   not end of list, go do another...
StCDLost lda   #DCDLstEr  DCD lost error flag
         lbsr  AccumErr   go save accumulated errors...
SgnlDCD  lda   <CDSigPID  get process ID, send a DCD signal?
         beq   CkSuspnd   no, go check for suspended process...
         ldb   <CDSigSig  get DCD signal code
         clr   <CDSigPID  clear DCD signal
         os9   F$Send

CkSuspnd clrb             clear Carry (for exit) and LSB of process descriptor address
         lda   <V.WAKE    anybody waiting? ([D]=process descriptor address)
         beq   IRQExit    no, go return...
         stb   <V.WAKE    mark I/O done
         tfr   d,x        copy process descriptor pointer
         lda   P$State,x  get state flags
         anda  #^Suspend  clear suspend state
         sta   P$State,x  save state flags
IRQExit  puls  dp,pc      recover system DP, return...
         endc  
         endc  


         emod  
ModSize  equ   *
         end   

