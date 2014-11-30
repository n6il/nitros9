********************************************************************
* sdir - Print directory of SDC card
*
* $Id$
*
* Edt/Rev  YYYY/MM/DD  Modified by
* Comment
* ------------------------------------------------------------------
*   1      2014/11/20  tim lindner
* Started writing code.

         nam   sdir
         ttl   Print directory of SDC card

         ifp1
         use   defsfile
         endc

* Here are some tweakable options
DOHELP   set   0	1 = include help info
STACKSZ  set   32	estimated stack size in bytes
PARMSZ   set   256	estimated parameter size in bytes

* Module header definitions
tylg     set   Prgrm+Objct   
atrv     set   ReEnt+rev
rev      set   $00
edition  set   1

*********************************************************************
*** Hardware Addressing
*********************************************************************
CTRLATCH equ $FF40 ; controller latch (write)
CMDREG   equ $FF48 ; command register (write)
STATREG  equ $FF48 ; status register (read)
PREG1    equ $FF49 ; param register 1
PREG2    equ $FF4A ; param register 2
PREG3    equ $FF4B ; param register 3
DATREGA  equ PREG2 ; first data register
DATREGB  equ PREG3 ; second data register
*********************************************************************
*** STATUS BIT MASKS
*********************************************************************
BUSY     equ %00000001
READY    equ %00000010
FAILED   equ %10000000

         mod   eom,name,tylg,atrv,start,size

            org   0
buffer	   rmb  256*5

cleartop equ   .	everything up to here gets cleared at start
* Finally the stack for any PSHS/PULS/BSR/LBSRs that we might do
         rmb   STACKSZ+PARMSZ
size     equ   .

* The utility name and edition goes here
name     fcs   /sdir/
         fcb   edition
* Place constant strings here
header   fcc   /SDC Directory: /
headerL  equ   *-header
basepath fcc	/L:*.*/
			fcb	0
parameterTooLong fcc /Parameter too long./
         fcb C$LF
         fcb C$CR
parameterTooLongL  equ   *-parameterTooLong

timoutError fcc /Timeout./
carrigeReturn fcb C$LF
         fcb C$CR
timoutErrorL  equ   *-timoutError

dirNotFound fcc /Directory not found./
            fcb C$LF
            fcb C$CR
dirNotFoundL  equ   *-dirNotFound

pathNameInvalid fcc /Pathname is invalid./
            fcb C$LF
            fcb C$CR
pathNameInvalidL  equ   *-pathNameInvalid

miscHardwareError fcc /Miscellaneous hardware error./
            fcb C$LF
            fcb C$CR
miscHardwareErrorL  equ   *-miscHardwareError

notInitiated fcc /Listing not initiated./
            fcb C$LF
            fcb C$CR
notInitiatedL  equ   *-notInitiated

truncated fcc /Out of memroy. Listing trucated./
            fcb C$LF
            fcb C$CR
            fcb C$LF
            fcb C$CR
truncatedL  equ   *-truncated

dirString fcc / <DIR>  /
dirStringL  equ   *-dirString

*
* Here's how registers are set when this process is forked:
*
*   +-----------------+  <--  Y          (highest address)
*   !   Parameter     !
*   !     Area        !
*   +-----------------+  <-- X, SP
*   !   Data Area     !
*   +-----------------+
*   !   Direct Page   !
*   +-----------------+  <-- U, DP       (lowest address)
*
*   D = parameter area size
*  PC = module entry point abs. address
*  CC = F=0, I=0, others undefined

* The start of the program is here.
* main program
start
* create path string in buffer area
         cmpd #256-3
         lbhi parameterToLongError
         decb chew CR in parameter area
   	   pshs u,x,d
   	   leax basepath,pc
   	   ldd ,x++ copy 'L:'
   	   std ,u++
   	   puls d
   	   cmpd #$0
   	   bne copyParameterArea
* use '*.*' if user suplied no parameter
   	   ldd ,x++ copy '*.*' and null
   	   std ,u++
   	   ldd ,x++
   	   std ,u++
   	   puls x,u
   	   ldd #$5 Length of buffer
   	   bra printHeader
copyParameterArea
         puls x
         pshs d
cpaLoop  lda ,x+
         sta ,u+
         decb
         beq cpaDone
         bra cpaLoop
cpaDone	clra put null at end of parameter string
			sta ,u+
			puls d
			addd #3
			puls u
			leas	0,y  clobber parameter area, put stack at top, giving us as much RAM as possible
printHeader
			pshs d
         lda #1 Output path (stdout)
         ldy #headerL
         leax header,pc header in x
         os9 I$Write
* print path			
			puls y
         leax buffer,u buffer in x
         os9 I$Write
         ldy #2 length of buffer
         leax >carrigeReturn,pcr buffer in x
         os9 I$Write
* wait until our next tick to communicate with the SDC
         ldx   #$1
         os9   F$Sleep
* setup SDC for directory processing
         orcc #IntMasks  mask interrupts
			lbsr CmdSetup
			bcc sendCommand
			ldb #$f6 Not ready error code
			lbra Exit
sendCommand
			ldb #$e0 load initial directory listing command
			stb CMDREG send to SDC command register
			exg a,a wait
         leax buffer,u point to transfer bufer
         lbsr txData transmit buffer to SDC
         bcc getBuffer
         tstb
         beq timeOut
			bitb #$10
			bne targetDirectoryNotFoundError
			bitb #$08
			bne miscellaneousHardwareError
			bitb #$04
			bne pathNameInvalidError
         lbra Exit
getNextDirectoryPage
			leax 256*2,x
			tfr s,d
			pshs d
			cmpx ,s++
			bhi noteTruncate
			leax -256,x
getBuffer
			ldb #$3e set parameter #1
			stb PREG1
			ldb #$c0 set command code
			stb CMDREG send to SDC command register
			lbsr rxData
			bcc checkBuffer
			tstb
			beq timeOut
			bitb #$8
			bne notInitiatedError
			lbra Exit
timeOut
         leax >timoutError,pcr point to help message
         ldy #timoutErrorL get length
genErr   clr CTRLATCH
         andcc #^IntMasks unmask interrupts
         lda #$02 std error
         os9 I$Write
         clrb clear error
			lbra ExitNow
parameterToLongError
			leax >parameterTooLong,pcr
			ldy #parameterTooLongL
			bra genErr
targetDirectoryNotFoundError
			leax >dirNotFound,pcr
			ldy #dirNotFoundL
			bra genErr
miscellaneousHardwareError
			leax >miscHardwareError,pcr
			ldy #miscHardwareErrorL
			bra genErr
pathNameInvalidError
			leax >pathNameInvalid,pcr
			ldy #pathNameInvalidL
			bra genErr
notInitiatedError
			leax >notInitiated,pcr
			ldy #notInitiatedL
			bra genErr

* Check buffer for nulled entry. This signifies the end
checkBuffer
         lda #16
         leau ,x go back to start of buffer
cbLoop   ldb ,u
         beq printBuffer
         leau 16,u
         deca
         beq getNextDirectoryPage
         bra cbLoop

noteTruncate
         clr CTRLATCH
         andcc #^IntMasks unmask interrupts
         clr -256,x zero out last directory entry
         leax >truncated,pcr point to help message
         ldy #truncatedL get length
         lda #$02 std error
         os9 I$Write
         bra pName
printBuffer
         clr CTRLATCH
         andcc #^IntMasks unmask interrupts
* print filename
pName    
* Get screen width
         lda #1 Output Path (stdout)
         ldb #SS.ScSiz Request screen size
         os9 I$Getstt Make screen size request
         ldd #$0303
         cmpx #75
         bhi ssDone
         ldd #$0202
         cmpx #42
         bhi ssDone
         ldd #$0101
* push column count to stack
ssDone   pshs d
* reset reg u back to the start of the buffer
         clrb
         tfr dp,a
         tfr d,u
         lda #1 Output path (stdout)
pbLoop   ldy #8 length of buffer
			leax ,u
         os9 I$Write
* print file extension
         leax 7,u
         ldb #$20
         stb ,x
         ldy #4
         os9 I$Write
* print flags
         leax 7,u
         ldb 11,u
         lda #'-
         bitb #2
         beq pf1
         lda #'H
pf1      sta 1,x
         lda #'-
         bitb #1
         beq pf2
         lda #'L
pf2      sta 2,x
         lda #1
         ldy #3
         os9 I$Write
         bitb #$10
         beq pfSize
* print directory token
         ldy #dirStringL
         leax >dirString,pcr buffer in x
         os9 I$Write
         bra pfCR

* print size
pfSize
* start with a space
         lda #$20 space character
* store U offset in 11,u
         clrb
         stb 11,u
         sta b,u
         incb
         stb 11,u
         
         lda 12,u
         beq ps1
* Very large number: load offset 12 and 13, shift right 4 bits, print decimal as mega bytes
         ldb 13,u
         lsra
         rorb
         lsra
         rorb
         lsra
         rorb
         lsra
         rorb
         bsr L09BA write ascii value of D to buffer
         lda #'M
         bra psUnit
ps1      lda 13,u
         beq ps2
* Kind of large number: load offsets 13 and 14, shift right 2 bits, print decimal as kilo bytes
         ldb 14,u
         lsra
         rorb
         lsra
         rorb
         bsr L09BA write ascii value of D to buffer
         lda #'K
         bra psUnit
ps2     ldd 14,u
* number: load offsetprint 14 and 15, print decimal as bytes
         bsr L09BA write ascii value of D to buffer
         lda #'B
         bra psUnit
* print unit to buffer
psUnit
			ldb 11,u
			sta b,u
			lda #$20
			incb
			sta b,u
			incb
			sta b,u
			incb
			sta b,u
         
         lda #1
         ldy #8
         leax ,u
         os9 I$Write         
         
* print carrage return and do next directory entry
pfCR     
         dec ,s
         beq pfDoCR
         bra pdCRSkip
pfDoCR   ldy #2 length of buffer
         leax >carrigeReturn,pcr buffer in x
         os9 I$Write
         ldb 1,s
         stb ,s
pdCRSkip 
         leau 16,u
         ldb ,u
         beq ExitOK
         lbra pbLoop

ExitOk   
         ldy #2 length of buffer
         leax >carrigeReturn,pcr buffer in x
         os9 I$Write
         clrb
Exit     clr CTRLATCH
         andcc #^IntMasks unmask interrupts
ExitNow  os9 F$Exit

* Stolen from BASIC09
* Convert # in D to ASCII version (decimal)
L09BA    pshs  y,x,d      Preserve End of data mem ptr,?,Data mem size
         pshs  d          Preserve data mem size again
         leay  <L09ED,pc  Point to decimal table (for integers)
L09C1    ldx   #$2F00    
L09C4    puls  d          Get data mem size
L09C6    leax  >$0100,x   Bump X up to $3000
         subd  ,y         Subtract value from table
         bhs   L09C6      No underflow, keep subtracting current power of 10
         addd  ,y++       Restore to before underflow state
         pshs  d          Preserve remainder of this power
         ldd   ,y         Get next lower power of 10
         tfr   x,d        Promptly overwrite it with X (doesn't chg flags)
         beq   L09E6      If finished table, skip ahead
         cmpd  #$3000     Just went through once?
         beq   L09C1      Yes, reset X & do again
*        lbsr  L1373      Go save A @ [<u0082]
         ldb   11,u       Write A to output buffer
         sta   b,u
         incb
         stb   11,u
         ldx   #$2F01     Reset X differently
         bra   L09C4      Go do again

L09E6
*        lbsr  L1373      Go save A @ [<u0082]
         ldb   11,u       Write A to output buffer
         sta   b,u
         incb
         stb   11,u
         leas  2,s        Eat stack
         puls  pc,y,x,d   Restore regs & return

* Table of decimal values
L09ED    fdb   $2710      10000
         fdb   $03E8      1000
         fdb   $0064      100
         fdb   $000A      10
         fdb   $0001      1
         fdb   $0000      0
        
*********************************************************************
* Setup Controller for Command Mode
*********************************************************************
* EXIT:
*   Carry cleared on success, set on timeout
*   All other registers preserved
*
CmdSetup      pshs x,a                   ; preserve registers
              lda #$43                   ; put controller into..
              sta CTRLATCH               ; Command Mode
              ldx #0                     ; long timeout counter = 65536
busyLp        lda STATREG                ; read status
              lsra                       ; move BUSY bit to Carry
              bcc setupExit              ; branch if not busy
              leax -1,x                  ; decrement timeout counter
              bne busyLp                 ; loop if not timeout
              lda #0                     ; clear A without clearing Carry
              sta CTRLATCH               ; put controller back in emulation
setupExit     puls a,x,pc                ; restore registers and return

*********************************************************************
* Send 256 bytes of Command Data to SDC Controller
*********************************************************************
* ENTRY:
*   X = Data Address
*
* EXIT:
*   B = Status
*   Carry set on failure or timeout
*   All other registers preserved
*
txData      pshs u,y,x                  ; preserve registers
            ldy #DATREGA                ; point Y at the data registers
* Poll for Controller Ready or Failed.
            comb                        ; set carry in anticipation of failure
            ldx #0                      ; max timeout counter = 65536
txPoll      ldb -2,y                    ; read status register
            bmi txExit                  ; branch if FAILED bit is set
            bitb #READY                 ; test the READY bit
            bne txRdy                   ; branch if ready
            leax -1,x                   ; decrement timeout counter
            beq txExit                  ; exit if timeout
            bra txPoll                  ; poll again
* Controller Ready. Send the Data.
txRdy       ldx ,s                      ; re-load data address into X
            ldb #128                    ; 128 words to send (256 bytes)
txWord      ldu ,x++                    ; get data word from source
            stu ,y                      ; send to controller
            decb                        ; decrement word loop counter
            bne txWord                  ; loop until done
* Done sending data, wait for result
            ldx #0                      ; wait for result
            comb                        ; assume error
txWait      ldb -2,y                    ; load status
            bmi txExit                  ; branch if failed
            lsrb                        ; clear carry if not busy
            bcc txExit                  ; test ready bit
            leax -1,x                   ; decrememnt timeout counter
            bne txWait			          ; loop back until timeout
txExit      puls x,y,u,pc               ; restore registers and return

*********************************************************************
* Retrieve 256 bytes of Response Data from SDC Controller
*********************************************************************
* ENTRY:
*    X = Data Storage Address
*
* EXIT:
*    B = Status
*    Carry set on failure or timeout
*    All other registers preserved
*
rxData      pshs u,y,x                  ; preserve registers
            ldy #DATREGA                ; point Y at the data registers
* Poll for Controller Ready or Failed.
            comb                        ; set carry in anticipation of failure
            ldx #0                      ; max timeout counter = 65536
rxPoll      ldb -2,y                    ; read status register
            bmi rxExit                  ; branch if FAILED bit is set
            bitb #READY                 ; test the READY bit
            bne rxRdy                   ; branch if ready
            leax -1,x                   ; decrement timeout counter
            beq rxExit                  ; exit if timeout
            bra rxPoll                  ; poll again
* Controller Ready. Grab the Data.
rxRdy       ldx ,s                      ; re-load data address into X
            ldb #128                    ; 128 words to read (256 bytes)
rxWord      ldu ,y                      ; read data word from controller
            stu ,x++                    ; put into storage
            decb                        ; decrement word loop counter
            bne rxWord                  ; loop until done
            clrb                        ; success! clear the carry flag
rxExit      puls x,y,u,pc               ; restore registers and return

*********************************************************************
* This routine skip over spaces and commas
*********************************************************************
* Entry:
*   X = ptr to data to parse
* Exit:
*   X = ptr to first non-whitespace char
*   A = non-whitespace char
SkipSpcs lda   ,x+
         cmpa  #C$SPAC
         beq   SkipSpcs
         leax  -1,x
         rts

         emod
eom      equ   *
         end
