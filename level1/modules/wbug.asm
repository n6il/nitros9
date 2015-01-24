********************************************************************
* wbug - WireBug for 6809/6309
*
* $Id$
*
* For Level 1, wbug must be run from the command line in order for
* the debugger to be properly setup.
*
* For Level 2, this module is called by the kernel at boot time.
*
* A process can invoke the debugger by executing an os9 F$Debug instruction.
* SWI can also invoke the debugger but should be reserved for breakpoints only.
*
* Edt/Rev  YYYY/MM/DD  Modified by
* Comment
* ------------------------------------------------------------------
*   1      2005/04/03  Boisy G. Pitre
* Started.
*
*   2      2008/02/07  Boisy G. Pitre
* Revamped to use F$Debug for debugger entry and SWI for breakpoints.
* Confirmed working under Level 1, but under Level 2, system calls
* currently crash the CoCo 3.

               NAM       KrnP3     
               TTL       WireBug for 6809/6309

               IFP1      
               USE       defsfile
			   USE       drivewire.d
               ENDC      

               IFEQ      LEVEL-1
tylg           SET       Prgrm+Objct
  	   ELSE
tylg           SET       Systm+Objct
               ENDC
atrv           SET       ReEnt+rev
rev            SET       $00
edition        SET       2

cbsize         EQU       24

* offsets into our on-stack storage
               ORG       0
callregs       RMB       2
               IFEQ      LEVEL-1
l1exitvct      RMB       2
               ENDC
combuff        RMB       cbsize
size           EQU       .


L0000          MOD       eom,name,tylg,atrv,start,size

SvcTbl         equ       *
               fcb       F$Debug
               fdb       dbgent-*-2
			   fcb       $80


name           EQU       *
               IFEQ      LEVEL-1
               FCS       /wbug/
			   ELSE
               FCS       /KrnP3/
               FCB       edition

nextname       FCC       /KrnP4/             next module name to link to
               FCB       C$CR
               ENDC
			   
subname        FCS       /dwio/

start
* attach to low level module
               clra
               leax      subname,pcr
               os9       F$Link
               bcs       ex@
               IFGT      Level-1
			   sty       <D.DWSubAddr
			   ELSE
			   sty       >D.DWSubAddr
               ENDC
* install F$Debug system call
               leay      SvcTbl,pcr
               os9       F$SSvc
               bcs       ex@
               leax      brkent,pcr          get pointer to breakpoint entry
			   IFEQ      LEVEL-1
               stx       >D.SWI              store in D.SWI global
               clrb			                 clear carry
ex@            os9       F$Exit		         and exit
			   ELSE
               stx       <D.XSWI             store in D.XSWI global
* get next KrnP module going
gol2           lda       #tylg               get next module type (same as this one!)
               leax      <nextname,pcr       get address of next module name
               os9       F$Link              attempt to link to it
               bcs       ex@                 no good...skip this
               jsr       ,y                  else go execute it
ex@            rts                           return
               ENDC


* Breakpoint Entry
* 
* We enter here when a process or the system executes an SWI instruction.
brkent         
			   IFEQ      LEVEL-1
* In Level 1, we get called right from the SWI vector, so we need to set U to point to the registers on the stack.
               leau      ,s                  point X to regs on stack
			   leay      rtiexit,pc
			   ENDC
* This is a breakpoint; back up PC to point at SWI
               ldd       R$PC,u
               subd      #$01                length of SWI instruction
               std       R$PC,u
               IFEQ      LEVEL-1
               bra       cmn
			   ENDC

* Code common to both debugger and breakpoint entries
* Debugger Entry
* 
* We enter here when a process or the system executes an os9 F$Debug instruction.
dbgent
               IFEQ      LEVEL-1
			   leay      rtsexit,pc
			   ENDC
cmn         pshs      cc
            orcc      #IntMasks
            leas      -size,s             make room on stack for temp statics
               leax      ,s                  point X to our temp statics
               exg       x,u                 exchange X and U
               stx       callregs,u          save pointer to caller regs
               IFEQ      LEVEL-1
			   sty       l1exitvct,u
			   ENDC
               pshs      u
               IFGT      Level-1
			   ldu       <D.DWSubAddr
			   ELSE
			   ldu       >D.DWSubAddr
               ENDC
			   jsr       ,u					initialize I/O
			   puls      u

               lda       #OP_WIREBUG_MODE
               IFEQ      LEVEL-1
               ldb       #$02				assume CoCo 2
			   ELSE
               ldb       #$03				assume CoCo 3
			   ENDC
               std       combuff,u
               IFNE      H6309
               lda       #$03				6309
               ELSE
               lda       #$08				6809
			   ENDC
               sta       combuff+2,u
			   lbsr      _sendtohost
			   
* mainloop - processes requests from the server
mainloop                 
               leax      combuff,u           point to comm buffer
               pshs      u
               IFGT      Level-1
			   ldu       <D.DWSubAddr
			   ELSE
			   ldu       >D.DWSubAddr
               ENDC
l@
			   ldy       #24
			   ldd       #133
			   jsr       3,u				get packet
               cmpd      #$0000				no data?
			   beq       l@
			   puls      u
* bcs
               tfr       y,d				put checksum in D
               subb      23,x
			   cmpb      combuff+23,u		does it match the checksum from the packet?
               beq       processmsg         if not, send checksum error
	           bsr       _sendcsumerror
			   bra	     mainloop

* Here we have a message with a valid checksum.
* Now we evaluate the command byte.
processmsg               
               lda       combuff,u           get command byte
               cmpa      #OP_WIREBUG_READMEM Read Memory?
               lbeq      _readmem            branch if so
               cmpa      #OP_WIREBUG_READREGS Read Registers?
               lbeq      _readregs           branch if so
               cmpa      #OP_WIREBUG_WRITEMEM Write Memory?
               lbeq      _writemem           branch if so
               cmpa      #OP_WIREBUG_WRITEREGS Write Registers?
               lbeq      _writeregs          branch if so
               cmpa      #OP_WIREBUG_GO      Run Target?
               bne       mainloop

_go               
*               clr       combuff,u
*			   bsr       _sendtohost
               leas      size,s              recover space on stack
               IFEQ      LEVEL-1
			   jmp       [l1exitvct,u]
			   ENDC
rtsexit        puls cc
               clrb      
               rts 
rtiexit        puls cc
               rti


* Destroys A
_sendcsumerror
				lda			#E$CRC
_senderror
                sta         combuff,u
                bra         _sendtohost
				 
* Destroys A
_sendillnumerror
				lda			#16
				bra			_senderror

* This routine reads memory from the calling process' address space
* using F$Move.
_readmem                 
               ldx       combuff+1,u         get source pointer
               ldb       combuff+3,u         get count
               cmpb      #1
			   bge       ok1@
bad1@		   bsr       _sendillnumerror
			   bra       mainloop
ok1@           cmpb      #22
			   bgt       bad1@				if > 22, its illegal count

               IFEQ      LEVEL-1
* Level 1 copy
               leay      combuff+1,u         point U to destination
l@             lda       ,x+                 get byte at Y and inc
               sta       ,y+                 save byte at X and inc
               decb                          done?
			   bne       l@                  branch if not
			   ELSE
* Level 2 copy
			   clra
               tfr       d,y                 put count in Y
               pshs      u,x                 save source pointer
               leau      combuff+1,u         point U to destination
			   ldx       D.Proc             get current process pointer
               lda       P$Task,x            get source task #
               ldb       D.SysTsk           get destination task #
               puls      x                   restore source pointer
               os9       F$Move              move 'em out!
               puls      u                   restore statics pointer
               ENDC
               
               bsr       _sendtohost
               lbra      mainloop


* This routine writes memory from the host to the calling process'
* address space using F$Move.
_writemem                
               leax      combuff+4,u         point X to source
               IFEQ      LEVEL-1
* Level 1 copy
               ldb       combuff+3,u         get count of packet
               ldy       combuff+1,u         get destination pointer
l@             lda       ,x+                 get byte at Y and inc
               sta       ,y+                 save byte at X and inc
               decb                          done?
	   bne       l@                  branch if not
			   ELSE
* Level 2
               clra      
               ldb       combuff+3,u         get count of packet
               tfr       d,y                 put count in Y
               pshs      u,x                 save on stack
               ldu       combuff+1,u         get destination pointer
               ldx       <D.Proc             get current process pointer
               lda       <D.SysTsk           get source task #
               ldb       P$Task,x            get destination task #
               puls      x                   restore source pointer
               os9       F$Move              move 'em out!
               puls      u                   restore our static pointer
			   ENDC
               ldd       #$0100              assume successful write
               bsr       _sendtohost
               lbra      mainloop


* This routine sends the contents of combuff,u to the communications
* hardware.
*
* Also, we compute the checksum as we send the bytes out so that
* we do not have to call a separate routine.
*
* Entry:
*    X = address of packet to send
_sendtohost              
               leax      combuff,u
               ldb       #23				B = count of packet - 1
			   clra							A = checksum
l@             adda      ,x+				add up
               decb							until
			   bne       l@					we've reached the end
			   sta       ,x					save computed checksum
			   leax      -23,x
			   ldy       #24			   
               pshs      u
               IFGT      Level-1
			   ldu       <D.DWSubAddr
			   ELSE
			   ldu       >D.DWSubAddr
               ENDC
			   jsr       6,u				write it out
			   puls      u,pc


*  Target registers:  DO NOT CHANGE!
TASK_REGS
REG_STATE       RMB     1
REG_PAGE        RMB     1
REG_SP          RMB     2
REG_U           RMB     2
REG_Y           RMB     2
REG_X           RMB     2
REG_F           RMB     1               F BEFORE E, SO W IS LEAST SIG. FIRST
REG_E           RMB     1
REG_B           RMB     1               B BEFORE A, SO D IS LEAST SIG. FIRST
REG_A           RMB     1
REG_DP          RMB     1
REG_CC          RMB     1
REG_MD          RMB     1
REG_V           RMB     2
REG_PC          RMB     2
TASK_REG_SZ     EQU     *-TASK_REGS


_readregs                
               ldy       callregs,u          get pointer to caller's regs
			   leax      combuff+1,u
               ldb       R$DP,y
               stb       ,x+				DP
               ldb       R$CC,y
               stb       ,x+				CC
               ldd       R$D,y				D
               std       ,x++
               IFNE      H6309
               ldd       R$W,y				W
               exg       a,b
               std       ,x++
               ELSE
			   leax      2,x
			   ENDC
               ldd       R$X,y				X
               exg       a,b
               std       ,x++
               ldd       R$Y,y				Y
               exg       a,b
               std       ,x++
               ldd       R$U,y				U
               exg       a,b
               std       ,x++

               IFNE      H6309
* construct MD from shadow register in NitrOS-9 globals
               lda       >D.MDREG			MD
	           sta      ,x+
               tfr       v,d
               std       ,x++				V
               ELSE
               leax      3,x
			   ENDC
			   
               ldd       R$PC,y
               std       2,x                  PC
               ldy       >D.Proc			get SP from proc desc
               ldd       P$SP,y
               std       ,x
               bsr       _sendtohost
               lbra      mainloop



_writeregs               
               ldy       callregs,u          get caller's reg ptr
               ldd       combuff+1,u
			   std		R$DP,y
               ldd       combuff+3,u
			   std		R$D,y
			    IFNE	H6309
               ldd       combuff+5,u
			   std		R$W,y
			   ENDC
               ldd       combuff+7,u
			   std		R$X,y
               ldd       combuff+9,u
			   std		R$Y,y
               ldd       combuff+11,u
			   std		R$U,y
			   
               ldd       combuff+17,u
               std       R$PC,y

               ldy       >D.Proc
               std       P$SP,y

               lbra      mainloop

               EMOD      
eom            EQU       *
               END       
