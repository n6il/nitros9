********************************************************************
* KrnP3 - NoICE Serial Debugger for 6809/6309
*
* $Id$
*
* This module is called by the kernel at boot time and initializes itself
* by creating a new system call: os9 F$Debug
*
* The process that called the F$Debug system call is the one that will
* be debugged.
*
* Using the NoICE serial protocol, the debugger can talk to a host, and can be
* driven by simple commands to read/write registers and memory, and continue
* execution.
*
* Notes:
*  o The NoICE protocol specifies a 'page' byte in addition to the
*    16-bit memory address when reading/writing memory.  We currently
*    ignore this page, and I cannot think of a need for this.
*
*  o The 6309 is now a supported processor under the Windows version
*    of NoICE.  Its processor ID is 17.
*
* Edt/Rev  YYYY/MM/DD  Modified by
* Comment
* ------------------------------------------------------------------
*   1      2005/04/03  Boisy G. Pitre
* Started
*
*   2      2006/02/02  Boisy G. Pitre
* Added USERSTATE flag to allow module to debug current process or
* system.
*
*   3      2006/03/02  Boisy G. Pitre
* NoICE now displays user or system information in Level 2 with the
* addition of a system state system call and the ssflag variable.
*
*   4      2006/03/04  Boisy G. Pitre
* Memory now allocated upon first encounter of system call.
*
*   5      2006/03/05  Boisy G. Pitre
* User and system call entry points for F$Debug now part of both
* NitrOS-9 Level 1 and Level 2.

               NAM       KrnP3     
               TTL       NoICE Serial Debugger for 6809/6309

               IFP1      
               USE       defsfile
               ENDC      

               IFGT      Level-1
tylg           SET       Systm+Objct
               ELSE      
tylg           SET       Prgrm+Objct
               ENDC      
atrv           SET       ReEnt+rev
rev            SET       $00
edition        SET       5

* If an MPI is being used, set DEVICESLOT to slot value - 1 and set MPI to 1
DEVICESLOT     EQU       1            slot 2

*MPI            EQU       1

FN_ERROR       EQU       $F0
FN_SET_BYTES   EQU       $F9
FN_RUN_TARGET  EQU       $FA
FN_WRITE_REGS  EQU       $FB
FN_READ_REGS   EQU       $FC
FN_WRITE_MEM   EQU       $FD
FN_READ_MEM    EQU       $FE
FN_GET_STATUS  EQU       $FF


cbsize         EQU       200

* this location is in lo-System RAM.  We clear the low bit upon
* initialization from the kernel, then on subsequent breakpoints,
* we set the low bit

* offsets into our on stack storage
               ORG       0
callregs       RMB       2
firsttime      RMB       1
syssp          RMB       2
ssflag         RMB       1
               IFNE      MPI
slot           RMB       1
               ENDC
combuff        RMB       cbsize
size           EQU       .


L0000          MOD       eom,name,tylg,atrv,start,size

name           EQU       *
               IFGT      Level-1
               FCS       /KrnP3/
               ELSE      
               FCS       /noice/
               ENDC      
               FCB       edition

               IFGT      Level-1
nextname       FCC       /KrnP4/             next module name to link to
               FCB       C$CR
               ENDC

svctabl        FCB       F$Debug
               FDB       dbgent-*-2
               FCB       F$Debug+$80
               FDB       dbgentss-*-2
               FCB       $80

start                    
               IFEQ      Level-1
               leax      name,pcr
               clra
               os9       F$Link              link module into memory (Level 1)
               ENDC
               leay      svctabl,pcr
               os9       F$SSvc              install F$Debug service
               bcs       ex@
               clra
               clrb
               std       >D.DbgMem           set pointer to $0000 so it will be allocated later
               IFEQ      Level-1
ex@            os9       F$Exit
               ELSE
               lda       #tylg               get next module type (same as this one!)
               leax      nextname,pcr       get address of next module name
               os9       F$Link              attempt to link to it
               bcs       ex@                 no good...skip this
               jsr       ,y                  else go execute it
ex@            rts                           return
               ENDC



* Called to get debugger memory
getmem         tfr       u,x                 put regs ptr in X
               ldu       <D.DbgMem           get pointer to our statics in X
               bne       retok
               ldd       #$0100
               os9       F$SRqMem            allocate memory
               bcs       ret
               stu       <D.DbgMem           save our allocated memory
* Set the firsttime flag so that the first time we get
* called at dbgent, we DON'T subtract the SWI from the PC.
               sta       firsttime,u        A > $00
retok          stx       callregs,u         save pointer to caller's regs
               clrb
ret            rts


* User State Debugger Entry Point
* 
* We enter here when a process or the system makes an os9 F$Debug call from
* user state.
dbgent         bsr       getmem
               bcs       ret
               clra
               bra       usernext

* System State Debugger Entry Point
* 
* We enter here when a process or the system makes an os9 F$Debug call from
* system state.
dbgentss       bsr       getmem
               bcs       ret
               lda       #$01
* Interesting trick here... I cannot see where the kernel stores the stack
* register when processing a system call in system state.  I observed that
* the actual value of S was some constant from where S is when entering the
* system call.  We'll see how this holds up during system state debugging,
* and whether changes to the kernel will affect this offset.
               IFEQ      Level-1
stackoff       equ       $12
               ELSE
stackoff       equ       $15
               ENDC
               leas      stackoff,s
               sts       syssp,u
               leas      -stackoff,s
               
usernext       sta       ssflag,u
* If this is a breakpoint (state = 1) then back up PC to point at SWI2
               tst       firsttime,u
               bne       notbp
               ldd       R$PC,x
               subd      #$03
               std       R$PC,x
* set bit so next time we do the sub on the $PC
notbp          clr       firsttime,u
               lbsr      ioinit              initialize I/O
               lda       #FN_RUN_TARGET
               sta       combuff,u
               lbra      _readregs

* mainloop - processes requests from the server
mainloop                 

* ADDITION: We insist on having a "Pre-Opcode" OP_XBUG if we are using
* this client in conjunction with DriveWire on the same serial line.
* This is because DriveWire's Opcodes conflict with NoICE's.
*               lbsr      ioread              get command byte
*               cmpa      #OP_XBUG            X-Bug Op-Code?
*               bne       mainloop            if not, continue waiting
               
               clrb                          clear B (for checksum)
               leax      combuff,u           point to comm buffer
               lbsr      ioread              get command byte
               sta       ,x+                 save in comm buffer and inc X
               addb      -1,x                compute checksum
               lbsr      ioread              get byte count of incoming message
               sta       ,x+                 save in comm buffer and inc X
               addb      -1,x                compute checksum
               pshs      a                   save count on stack
               tsta                          count zero?
               beq       csum@               branch if so
n@             lbsr      ioread              read data byte (count on stack)
               sta       ,x+                 save in our local buffer
               addb      -1,x                compute checksum
               dec       ,s                  decrement count
               bne       n@                  if not zero, get next byte
csum@          lbsr      ioread              read checksum byte from host
               sta       ,s                  save on stack (where count was)
               negb                          make 2's complement
               cmpa      ,s+                 same as host's?
               bne       mainloop            if not, ignore message

* Here we have a message with a valid checksum.
* Now we evaluate the command byte.
processmsg               
               lda       combuff,u           get command byte
               bpl       _sendstatus         command byte hi bit not set
               cmpa      #FN_READ_MEM        Read Memory?
               lbeq      _readmem            branch if so
               cmpa      #FN_READ_REGS       Read Registers?
               lbeq      _readregs           branch if so
               cmpa      #FN_WRITE_MEM       Write Memory?
               lbeq      _writemem           branch if so
               cmpa      #FN_WRITE_REGS      Write Registers?
               lbeq      _writeregs          branch if so
               cmpa      #FN_GET_STATUS      Get Status?
               lbeq      _getstatus          branch if so
               cmpa      #FN_SET_BYTES       Set Bytes?
               beq       _setbytes           branch if so
               cmpa      #FN_RUN_TARGET      Run Target?
               lbeq      _runtarget

* Here we send an error status
_senderror               
               lda       #FN_ERROR
               sta       combuff,u
               lda       #1
_sendstatus              
               sta       combuff+2,u
               lda       #1
               sta       combuff+1,u
               lbsr      _sendtohost
               bra       mainloop

_runtarget               
               clrb      
               rts       

* This routine is given a list of bytes to change.  It must read the current
* byte at that location and return it in a packet to the host so that
* the host can restore the contents at a later time.
_setbytes                
               ldb       combuff+1,u         get count byte
               clr       combuff+1,u         set return count as zero
               lsrb                          divide number of bytes by 4
               lsrb      
               beq       sb9
               pshs      u                   save our statics pointer
               leau      combuff+2,u         point U to write outgoing data
               tfr       u,y                 point Y to first 4 bytes
sb1            pshs      b                   save loop counter
               ldd       1,y                 get address to write to
               exg       a,b                 swap!
               tfr       d,x                 memory address is now in X
* Here, X = memory address to read
*       Y = 4 byte component in input packet
*       U = next place in com buffer to write "previous" byte
* Read current data at byte location in process' space
               pshs      u,a                 save byte spot for later and "next" ptr
               IFGT      Level-1
               ldu       4,s                 get original U
               tst       ssflag,u
               bne       ss@
               ldu       <D.Proc
               ldb       P$Task,u
               os9       F$LDABX
               sta       ,s                  save original ,X value on stack for now
               lda       3,y                 get byte to store
               os9       F$STABX
* Re-read current data at byte location in process' space
               os9       F$LDABX
               bra       p@
               ENDC
ss@            lda       ,x
               sta       ,s                  save original ,X value on stack for now
* A now holds the data byte -- insert new data at byte location
               lda       3,y                 get byte to store
               sta       ,x
               lda       ,x
p@             cmpa      3,y                 compare what we read from what we wrote
               puls      a,u                 get "original" value and next ptr
               puls      b                   restore loop count
               bne       sb8@                carry affected by last cmpa
* Save target byte in return buffer
               sta       ,u+
               ldx       ,s                  get original statics ptr in X for now
               inc       combuff+1,x         count one return byte
* Loop for next byte
               leay      4,y                 step to next byte in specifier
               cmpb      combuff+1,x         done?
               bne       sb1
* Return buffer with data from byte locations
sb8@           puls      u                   restore our original statics ptr
sb9            lbsr      _sendtohost
               lbra      mainloop
sbe@           puls      u                   restore what's on the stack
               bra       _senderror

* This routine reads memory from the calling process' address space
* using F$Move.
_readmem                 
               ldd       combuff+3,u         get source pointer
               exg       a,b                 byte swap!
               tfr       d,x                 and put in X
               clra                          clear A
               ldb       combuff+5,u         get count
               stb       combuff+1,u         and store count back in our header
               tfr       d,y                 put count in Y
               pshs      u,x                 save source pointer
               leau      combuff+2,u         point U to destination
               IFGT      Level-1
               tst       ssflag-combuff-2,u
               bne       ss@
* User state
               ldx       <D.Proc             get current process pointer
               lda       P$Task,x            get source task #
               ldb       <D.SysTsk           get destination task #
               puls      x                   restore source pointer
               os9       F$Move              move 'em out!
               bra       p@
               ENDC
* System state
ss@            puls      x
l@             lda       ,x+                 get byte at source and inc
               sta       ,u+                 save byte at dest and inc
               leay      -1,y                done?
               bne       l@                  branch if not
p@             puls      u                   restore statics pointer
               bsr       _sendtohost
               lbra      mainloop

* This routine writes memory from the host to the calling process'
* address space using F$Move.
_writemem                
               leax      combuff+5,u         point X to source
               clra      
               ldb       combuff+1,u         get count of packet
               subb      #3                  subtract 3 -- now we have our write count
               tfr       d,y                 put count in Y
               ldd       combuff+3,u         get destination pointer
               exg       a,b                 byte swap!
               pshs      u,x                 save on stack
               IFGT      Level-1
               tst       ssflag,u
               bne       ss@
* User state
               tfr       d,u                 and put source in U
               ldx       <D.Proc             get current process pointer
               lda       <D.SysTsk           get source task #
               ldb       P$Task,x            get destination task #
               puls      x                   restore source pointer
               os9       F$Move              move 'em out!
               bra       p@
               ENDC
* System state
ss@            
               tfr       d,u                 and put source in U
               puls      x
l@             lda       ,x+                 get byte at source and inc
               sta       ,u+                 save byte at dest and inc
               leay      -1,y                done?
               bne       l@                  branch if not
p@             puls      u                   restore our static pointer
               ldd       #$0100              assume successful write
               std       combuff+1,u
               bsr       _sendtohost
               lbra      mainloop


* This data is provided to the NoICE server upon receipt of FN_GET_STATUS.
statdata                 
               FCB       33					number of bytes to send
               IFNE      H6309
               FCB       17					processor type: 6309
               ELSE
               FCB       5					processor type: 6809
               ENDC
               FCB       cbsize				size of communications buffer
               FCB       %00000000			options flags
               FDB       $0000				target mapped memory low bound
               FDB       $FFFF				target mapped memory high bound
               FCB       3					length of breakpoint instruction
               FCB       $10,$3F,F$Debug	breakpoint instruction
* target description
               FCC       "NitrOS-9/6"
               IFNE      H6309
               FCC       "3"
               ELSE
               FCC       "8"
               ENDC
               FCC       "09 Level "
               IFEQ      Level-1
               FCC       "1"
               ELSE
               FCC       "2"
               ENDC
               FCB       0

_getstatus               
* copy status to our buffer
               leax      statdata,pcr
               leay      combuff+1,u
               ldb       statdata,pcr
l@             lda       ,x+
               sta       ,y+
               decb      
               bpl       l@
               bsr       _sendtohost
               lbra      mainloop


* This routine sends the contents of combuff,u to the communications
* hardware.  Note that the count that is stored at combuff+1,u is
* set by the caller, and reflects the number of data bytes to be sent.
*
* Also, we compute the checksum as we send the bytes out so that
* we don't have to call a separate routine.
_sendtohost              
               leax      combuff,u           point X to communications buffer
               ldb       1,x                 get count from header into B
               addb      #2                  add header bytes to count var B
               pshs      b                   save on stack (this is our counter)
               clrb                          B is now used for checksum
n@             addb      ,x                  compute checksum
               lda       ,x+                 get byte from buffer and inc X
               lbsr      iowrite             write it out
               dec       ,s                  decrement count on stack
               bne       n@                  if not zero, branch
               negb                          make 2's complement
*	comb			make 2's complement
*	incb			
               tfr       b,a                 put in A
               lbsr      iowrite             write it
               puls      b,pc                return


_readregs                
               ldy       callregs,u          get pointer to caller's regs
               leax      combuff+1,u
               IFNE      H6309
               ldb       #21                 get number of bytes to send
               ELSE
               ldb       #16                 get number of bytes to send
               ENDC
               stb       ,x+                 save number of bytes
               lda       firsttime,u         get first time called flag
               sta       ,x+                 write it
               clr       ,x+                 clear page reg
               leax      2,x                 skip PC for now
               ldd       R$U,y
               exg       a,b
               std       ,x++
               ldd       R$Y,y
               exg       a,b
               std       ,x++
               ldd       R$X,y
               exg       a,b
               std       ,x++
               IFNE      H6309
               ldd       R$E,y
               exg       a,b
               std       ,x++
               ENDC
               ldd       R$A,y
               exg       a,b
               std       ,x++
               ldb       R$DP,y
               stb       ,x+                 DP
               ldb       R$CC,y
               stb       ,x+                 CC

               IFNE      H6309
* All this code is necessary to get the value of MD
* Note: bits 2-5 are unused
               ldb        <D.MDREG           get shadow register from sysglobs
*               bitmd     #%00000001
*               beq       md1
*               incb                         set bit 0
*md1            bitmd     #%00000010
*               beq       md6
*               orb       #%00000010         set bit 1
md6            bitmd     #%01000000
               beq       md7
               orb       #%01000000
md7            bitmd     #%10000000
               beq       tfrmd
               orb       #%10000000
tfrmd          stb       ,x+                 MD


* V register
               tfr       v,d
               exg       a,b
               std       ,x++                V
               ENDC

               ldd       R$PC,y
               exg       a,b
               std       ,x                  PC
               tst       ssflag,u           system state?
               beq       us@
               ldd       syssp,u
               bra       cmn@
us@            ldy       <D.Proc             get SP from proc desc
               ldd       P$SP,y
cmn@           exg       a,b
               std       combuff+4,u
               lbsr      _sendtohost
               lbra      mainloop


_writeregs               
               ldy       callregs,u          get caller's reg ptr
               leax      combuff+6,u
*	lda	D.Debug
*	anda	#D_BRKPT
*	sta	<D.Debug
               ldd       ,x++
               exg       a,b
               std       R$U,y
               ldd       ,x++
               exg       a,b
               std       R$Y,y
               ldd       ,x++
               exg       a,b
               std       R$X,y
               IFNE      H6309
               ldd       ,x++
               exg       a,b
               std       R$E,y
               ENDC
               ldd       ,x++
               exg       a,b
               std       R$A,y
               ldb       ,x+
               stb       R$DP,y
               ldb       ,x+
               stb       R$CC,y

               IFNE      H6309
* Note: because the only way to write to the MD register is via immediate mode,
* we must build a "ldmd #XX; rts" instruction on the stack then execute it in order
* to avoid "self modifying" code.
*               ldd       #$113D           "ldmd" instruction
*               std       -6,s
               lda       ,x+              MD register
*               ldb       #$39             "rts" instruction
*               std       -4,s
*               jsr       -6,s             call code on stack to modify MD

               ldd       ,x++
               exg       a,b
               tfr       d,v              V register
               ENDC

               ldd       ,x++
               exg       a,b
               std       R$PC,y
               ldd       combuff+4,u
               exg       a,b
               tst       ssflag,u
               beq       us@
               std       syssp,u
               bra       cmn@
us@            ldy       <D.Proc
               std       P$SP,y
cmn@           ldd       #$0100
               std       combuff+1,u
               lbsr      _sendtohost
               lbra      mainloop



********** I/O ROUTINES ********** 

* 6551 Parameters
ADDR           EQU       $FF68

A_RXD          EQU       ADDR+$00
A_TXD          EQU       ADDR+$00
A_STATUS       EQU       ADDR+$01
A_RESET        EQU       ADDR+$01
A_CMD          EQU       ADDR+$02
A_CTRL         EQU       ADDR+$03

* Baud rates
_B2400         EQU       $1A                 2400 bps, 8-N-1
_B4800         EQU       $1C                 4800 bps, 8-N-1
_B9600         EQU       $1E                 9600 bps, 8-N-1
_B19200        EQU       $1F                 19200 bps, 8-N-1

BAUD           EQU       _B9600

* ioinit - Initialize the low-level I/O
* Exit: Carry = 0: Init success; Carry = 1; Init failed
ioinit                   
               IFNE      MPI
               pshs      a
               lda       MPI.Slct
               sta       slot,u
               lda       #DEVICESLOT
               sta       MPI.Slct
               puls      a
               ENDC
               sta       A_RESET             soft reset (value not important)
* Set specific modes and functions:
* - no parity, no echo, no Tx interrupt
* - no Rx interrupt, enable Tx/Rx
               lda       #$0B
               sta       A_CMD               save to command register
               lda       #BAUD
               sta       A_CTRL              select proper baud rate
* Read any junk rx byte that may be in the register
               lda       A_RXD
               IFNE      MPI
               pshs      a
               lda       slot,u
               sta       MPI.Slct
               puls      a
               ENDC
               rts       


* ioread - Read one character from 6551
*
* Entry: None
* Exit:  A = character that was read
*
* Note, this routine currently doesn't timeout
ioread                   
               IFNE      MPI
               lda       MPI.Slct
               sta       slot,u
               lda       #DEVICESLOT
               sta       $FF7F
               ENDC
r@             lda       A_STATUS            get status byte
               anda      #$08                mask rx buffer status flag
               beq       r@                  loop if rx buffer empty
               lda       A_RXD               get byte from ACIA data port
               IFNE      MPI
               pshs      b
               ldb       slot,u
               stb       MPI.Slct
               puls      b,pc
               ELSE
               rts       
               ENDC

* iowrite - Write one character to 6551
*
* Entry: A = character to write
* Exit:  None
iowrite                  
               IFNE      MPI
               pshs      d
               ldb       MPI.Slct
               stb       slot,u
               ldb       #DEVICESLOT
               stb       MPI.Slct
               ELSE
               pshs      a                   save byte to write
               ENDC
w@             lda       A_STATUS            get status byte
               anda      #$10                mask tx buffer status flag
               beq       w@                  loop if tx buffer full
               IFNE      MPI
               puls      d                   get byte
               sta       A_TXD               save to ACIA data port
               lda       slot,u
               sta       MPI.Slct
               ELSE
               puls      a                   get byte
               sta       A_TXD               save to ACIA data port
               ENDC
               rts       

* ioterm - Terminate
*ioterm		
*	rts	


               IFNE      0
* iowout - Write an entire string
* iowerr - Write an entire string
iowerr                   
iowout                   
               pshs      a
l@             lda       ,x+
               cmpa      #C$CR
               beq       e@
               leay      -1,y
               beq       f@
               bsr       Write
               bra       l@
e@             bsr       Write
               lda       #C$LF
               bsr       Write
f@             ldx       <buffptr
               clrb      
               puls      a,pc

* ReadLine - Read an entire string, up to CR
* Entry: X = address to place string being read (CR terminated)
*        Y = maximum number of bytes to read (including nul byte)
ReadLine                 
               ldx       <buffptr
               pshs      y,x,a
               ldy       #80
l@             bsr       Read                read 1 character
               cmpa      #C$CR               carriage return?
               beq       e@                  branch if so...
               cmpa      #$08                backspace?
               beq       bs@
               cmpy      #$0000              anymore room?
               beq       l@
               leay      -1,y                back up one char
               sta       ,x+                 and save in input buffer
m@             bsr       Write               echo back out
               bra       l@
e@             sta       ,x
               bsr       Write
               lda       #C$LF
               bsr       Write
               clrb      
               puls      a,x,y,pc
bs@            cmpx      1,s                 are we at start
               beq       l@                  if so, do nothing
               clr       ,-x                 else erase last byte
               lbsr      Write               write backspace
               lda       #C$SPAC             a space...
               lbsr      Write               write it
               leay      1,y                 count back up free char
               lda       #$08                another backspace
               bra       m@
               ENDC      

               EMOD      
eom            EQU       *
               END       
