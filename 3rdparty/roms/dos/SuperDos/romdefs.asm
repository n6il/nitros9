*
* Deinitions for ROM entry points and low memory variables on Dragon 
* 32/64/Alpha.
*
* 2005-11-10. P.Harvey-Smith.
*

;
; Low memory vars in page 0 and 1
;

BasTextPtr	EQU		$19		; Basic text pointer
BasVarsPtr	EQU		$1B		; Pointer to start of vars
BasArrayPtr	EQU		$1D		; Pointer to start of arrays
BasEndInUse	EQU		$1F		; End of storage in use

BasFACExponent	EQU		$4F		; Floating point accumulator exponent
BasFACMantissa	EQU		$50		; FAC mantissa (4 bytes)
BasStrAddr	EQU		$52		; Address of string argument 
BasFACManSgn	EQU		$54		; Sign of mantissa
BasFACManSTemp	EQU		$55		; Tempory sign of mantissa

BasCurrentLine	EQU		$68		; Current line number
BasDeviceNo	EQU		$6F		; Current device number
ResetVecAddr	EQU		$72		; Reset vector address, points to a NOP
Zero16Bit	EQU		$8A		; 16 bit zero
BasChrGet	EQU		$9F		; Get next character from basic program
BasChrGetCurr	EQU		$A5		; Get current character from basic program
BasUsrBasePtr	EQU		$B0		; Pointer to base of usr vectors
GrfTopPtr	EQU		$B7		; Pointer to top of graphics screen
GrfBasePtr	EQU		$BA		; Graphics area base pointer

BasJoyRX	EQU		$15A		; Basic, Right Joystick X
BasJoyRY	EQU		$15B		; Basic, Right Joystick Y
BasJoyLX	EQU		$15C		; Basic, Left Joystick X
BasJoyLY	EQU		$15D		; Basic, Left Joystick Y
RamHooks	EQU		$15E		; Begining of ram hooks (see below)

;
; Ram hooks
;
;
; Some hooks share the same address, the only way to determine which is
; in use is to check the return address -- Source : "Inside the Dragon".
;

HookOpenDev	EQU		$15E		; Open device or file
HookCheckIONum	EQU		$161		; Check I/O device number
HookRetDevParam	EQU		$164		; Return device parameters
HookCharOut	EQU		$167		; Character output
HookCharIn	EQU		$16A		; Character input
HookCheckInput	EQU		$16D		; Deech dev open for input
HookCheckOutput	EQU		$170		; Deech dev open for output
HookCloseAll	EQU		$173		; Close all devices & files
HookCloseSingle	EQU		$176		; Close a single device or file
HookNewStat	EQU		$179		; About to dela with first char of new satement
HookDiskItem	EQU		$17C		; Disk file item scanner
HookPollBreak	EQU		$17F		; Poll for break key
HookReadInput	EQU		$182		; Read a line of input
HookFinishASCII	EQU		$185		; Finish loading ascii program
HookEOF		EQU		$188		; End of file function
HookEval	EQU		$18B		; Evaluate expression
HookUsrError	EQU		$18E		; User error trap
HookSysError	EQU		$191		; System error trap
HookRun		EQU		$194		; Run statement
HookStrCopy	EQU		$197		; String copy check
HookClear	EQU		$197		; Clear statement
HookFetchNext	EQU		$19A		; Fetch next statement
HookLet		EQU		$19D		; LET statement
HookCLS		EQU		$1A0		; CLS statement
HookRENUM	EQU		$1A0		; RENUM statment
HookPUTGET	EQU		$1A0		; PUT or GET statement
HookFunction	EQU		$1A0		; Function assignment
HookCompress	EQU		$1A3		; Compress basic line
HookExpand	EQU		$1A6		; Expand basic line for listing.


;
; Basic rom related stuff.
;

BasicHWInit	EQU		$8000		; Hardware initialisation
BasicSWInit	EQU		$8003		; Software initialisation
BasicKbdIn	EQU		$8006		; Keyboard input
BasicCursorB	EQU		$8009		; Cursor blink
BasicScreenOut	EQU		$800C		; Screen output
BasicPrintOut	EQU		$800F		; Printer output
BasicJoyIn	EQU		$8012		; Joystick input
BasicCassOn	EQU		$8015		; Cassette player motor on
BasicCassOff	EQU		$8018		; Cassette player motor off
BasicWriteLead	EQU		$801B		; Cassette write leader
BasicCassByOut	EQU		$801E		; Cassette byte output
BasicCassOnRd	EQU		$8021		; Cassette on for reading
BasicCassByIn	EQU		$8024		; Cassette byte input
BasicCassBitIn	EQU		$8027		; Cassette bit input
BasicSerIn	EQU		$802A		; Read a byte from serial
BasicSerOut	EQU		$802D		; Write a byte to serial port
BasicSetBaud	EQU		$8030		; Set baud rate

BasOMError	EQU		$8342		; ?OM error
CmdMode		EQU		$8371		; Go to basic command mode
BasResetStack	EQU		$8434		; Reset basic stack

VarGetExpr	EQU		$8877		; Get (and evaluate?) espression, addrss of expresion in $52
VarGetStr	EQU		$8887		; Get string variable from basic, and store it
VarCKComma	EQU		$89AA		; Check for comma 
BasSNError	EQU		$89B4		; ?SN ERROR basic routine
BasFCError	EQU		$8B8D		; ?FC Error basic routine
VarDelVar	EQU		$8D9F		; Delate a (tempory) var
VarGet8Bit	EQU		$8E51		; Get 8bit value
VarGet16Bit	EQU		$8E83		; Get 16 bit var from basic

TextOutCRLF	EQU		$90A1		; Output CRLF
BasPrintStr	EQU		$90E5		; Basic, print string.
TextOutQuestion	EQU		$90F8		; output a ?

BasicEntry	EQU		$B39B		; Basic entry point
BasicEntry2	EQU		$B3CE
BasicResetVec	EQU		$B3B4		; Basic rom reset vetcor

BasSignonMess	EQU		$B4B2		; Address of basic signon message

TextWaitKey	EQU		$B505		; Display cursor and await keypress

UtilCopyBXtoU	EQU		$B7CC		; copy B bytes from X to U

TextCls		EQU		$BA77		; Clear screen
SndDisable	EQU		$BAC3		; Disable (cassette) sound
SndDTOAOn	EQU		$BAED		; Turn on D to A sound
CasMotorOff	EQU		$BDDC		; Turn off casette motor
CasByteOut	EQU		$BE12		; Byte output to cassette