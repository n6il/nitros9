*******************************************************
*
* DWRead  -  6809 Turbo Edition  115k / 230k
*    Receive a response from the DriveWire server.
*    Times out if no data received within 1.3 (0.66) seconds.
*
*    THIS VERSION REQUIRES ONE OR MORE SYNC BYTES 
*    WHERE THE THE FINAL SYNC BYTE IS $C0 AND ANY
*    PRECEDING SYNC BYTES ARE $FF.
*
*    THE DATA BYTES MUST BE TRANSMITTED IN REVERSE
*    BIT ORDER (MOST-SIGNIFICANT FIRST).
*
*    Serial data format:  8-N-2    (TWO STOP BITS MANDATORY)
*
* Entry:
*    X  = storage address for incoming data
*    Y  = number of bytes required
*
* Exit:
*    CC = Z set on success, cleared on timeout
*    Y  = checksum
*    U is preserved
*    All others clobbered
*
*BBIN	equ	$FF22		; bit banger input port
        SETDP   $FF
DWRead	pshs	y,x,dp,a,cc		; save registers (A allocates space for status)
	orcc	#$50		; mask interrupts
	lda	#$FF		; select hardware page..
	tfr	a,dp		; ..as the direct page
	ldx	#0		; initialize timeout counter
	stx	<$FF92		; disable GIME interrupts
	ldd	<$FF92		; clear spurious interrupts

* Turn off PIA interrupt sources except for the bit banger's CD input pin.
* Also enable sound output from the DAC to stabilize the single-bit sound line.
	lda	<$FF01		; save PIA 0 controls on the stack
	ldb	<$FF03
	pshs	d
	anda	#$F6		; clear IRQ enables and audio mux selects
	andb	#$F6
	sta	<$FF01		; set new control state for PIA 0
	stb	<$FF03
	lda	<$FF00		; ensure the IRQ outputs are cleared
	ldb	<$FF02
	lda	<$FF21		; save PIA 1 controls on the stack
	ldb	<$FF23
	pshs	d,cc		; CC allocates space for byte adjustment value
	anda	#$FC		; clear FIRQ enables and sound enable
	andb	#$F6
	addd	#$0108		; set CD FIRQ enable and sound enable
	sta	<$FF21		; set new control state for PIA 1
	stb	<$FF23

* Setup byte adjustment value
	ldd	#$01FE		; ACCA = serial in mask;  ACCB = byte adjust mask
	andb	<BBIN		; ACCB = byte adjust value
	stb	,s		; save in pre-allocated stack space

* Wait for Sync Byte(s) or Timeout
sync1	ldb	#2		; set counter to wait for 2 low samples
sync2	bita	<BBIN		; sample input
	beq	sync3		; branch if low
	leax	,-x		; decrement timeout counter
	bne	sync1		; loop if timeout has not expired
	bra	rxDone		; exit due to timeout
sync3	lsrb			; have there been 2 consecutive low samples?
	bcc	sync2		; keep waiting if no
	ldx	8,s		; point X to storage buffer and..
	leax	-1,x		; ..adjust for pre-increment
sync4	bita	<BBIN		; sample input
	bne	rxStart		; branch if input has returned hi
	rorb			; bump secondary timeout counter
	bcc	sync4		; branch if not timeout
	bra	rxDone		; exit due to timeout
rxStart	lda	<$FF20		; reset FIRQ
	sync			; wait for the first byte's start bit
	jmp	<rxFirst,pcr	; 4-cycle equivalent of:  bra  rxFirst

* Byte receiver loop
rxNext	sync			; wait for start bit
	sta	,x		; store previous data byte
rxFirst	lda	<BBIN		; bit 0
	asla
	nop
	adda	<BBIN		; bit 1
	asla
	adda	>BBIN		; bit 2
	asla
	nop
	adda	<BBIN		; bit 3
	asla
	clrb			; ACCB = 0
	adda	<BBIN		; bit 4
	asla
	incb			; ACCB = 1
	adda	<BBIN		; bit 5
	asla
	adda	>BBIN		; bit 6
	asla
	abx			; increment storage ptr
	adda	<BBIN		; bit 7
	adda	,s		; adjust byte value
	bita	<$FF20		; reset FIRQ
	leay	-1,y		; decrement counter
	bne	rxNext		; loop if more bytes to read
	sta	,x		; store final byte
	clra			; status = SUCCESS
rxDone	sta	6,s		; store status on stack
	leas	1,s		; pop byte adjustment value

* Restore previous PIA control settings
	puls	d		; restore original PIA 1 controls
	sta	<$FF21
	stb	<$FF23
	puls	d		; restore original PIA 0 controls
	sta	<$FF01
	stb	<$FF03
	lda	<$FF20		; make sure the CD FIRQ has been cleared

   IF NITROS
* Restoration of GIME interrupts in NitrOS9
	ldd	>D.IRQER		; retrieve shadow copy of IRQ/FIRQ enable regs
	std	<$FF92		; restore GIME
	ldd	<$FF92		; clear spurious interrupts
   ENDIF

* Checksum computation
	clrb			; initialize checksum LSB
	puls	cc,a,dp,x,y		; restore IRQ masks, DP and the caller params
	tsta			; timeout error?
	bne	rxExit		; branch if yes
sumLoop	addb	,x+		; get one byte and add to..
	adca	#0		; ..the 16-bit checksum in ACCD
	leay	-1,y		; decrement counter
	bne	sumLoop		; loop until all data summed
	andcc	#$FE		; clear carry (no framing error)
rxExit	tfr	d,y		; move checksum into Y without affecting CC.Z
	rts			; return
