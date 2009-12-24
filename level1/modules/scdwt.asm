********************************************************************
* scdwt.asm - CoCo DriveWire Virtual Serial Driver
*
* many parts copied or only slightly modified from other nitros-9 modules or the DriveWire project  
*
* serreadm working, finally
* 
* Aaron Wolfe
* v0.8 11/30/09
*

         	nam   	scdwt
         	ttl   	CoCo DriveWire Virtual Serial Driver

         	ifp1
         	use   	defsfile
         	use   	dwdefs.d
         	endc


tylg     	set   	Drivr+Objct   
atrv     	set   	ReEnt+Rev
rev      	set   	$00
edition  	set   	1

* Device memory area: offset from U
         	org   	V.SCF      	;V.SCF: free memory for driver to use

DWTAdr		rmb		2			;pointer to instance with irq handler       

* these are only used in the primary instance
IRQPorts	rmb		1			;# ports active  
Instnces	rmb		14			;pointers to each instance of the driver
RxWaiter	rmb		7			;need to know who to wake per port..
DWErrors	rmb		1			;number of errors talking to DW server

* For ISR
VIRQPckt 	rmb   	5			;VIRQ packet Counter(2),Reset(2),Status(1) bytes

* port status variables...
* none yet
FlowCtrl	rmb		1			;flow control flags

regWbuf    	rmb   	2			;substitute for regW

* input buffer redesign to support multiball, used per instance
* heavily borrowed from sc6551
RxDatLen   rmb   1              ;current length of data in Rx buffer
RxBufSiz   rmb   1              ;Rx buffer size
RxBufEnd   rmb   2              ;end of Rx buffer
RxBufGet   rmb   2              ;Rx buffer output pointer
RxBufPut   rmb   2              ;Rx buffer input pointer
RxGrab		rmb		1			;bytes to grab in multiread
RxBufPtr   rmb   2              ;pointer to Rx buffer
RxBufDSz   equ   256-.          ;default Rx buffer gets remainder of page...
*RxBufDSz	equ		20
RxBuff     rmb   RxBufDSz       ;default Rx buffer

memsize     equ   	.

         	mod   	eom,name,tylg,atrv,start,memsize

* module info         	
         	fcb   	READ.+WRITE.	;driver access modes
name     	fcs   	/scdwt/		;driver name
         	fcb   	edition   	;driver edition 


* irq         	
IRQPckt   	fcb  	$00,$01,$0A 	;IRQ packet Flip(1),Mask(1),Priority(1) bytes

            
* dispatch calls            
start    	equ   	*
         	lbra  	Init
         	lbra  	Read
         	lbra  	Write
         	lbra  	GetStt
         	lbra  	SetStt
	 	
         	
***********************************************************************
* Term
*
* shut down the driver.
* should close only the correct port, tell server to close the port,
* and remove irq handler when no ports are left 
*
* Entry:
*    U  = address of device memory area
*
* Exit:
*    CC = carry set on error
*    B  = error code   
* NEEDS WORK
Term     	equ   	*
			ldy		DWTAdr,u		;main instance base addr
			* decrement port count
			*lda		IRQPorts,y		;# ports open
			*deca	
			*sta		IRQPorts,y
			*pshs	a			; save remaining port #
			pshs	u			; for after dwsub call
			
			* remove any waiter table entry
			lda		<V.PORT+1,u		;get our port #
			leax	RxWaiter,y		;get waiter table base
			clr		a,x				; clear our entry
			* put setstat args on stack for later
			ldb		#255
			pshs 	d				;port #, 255 (term) on stack
			* remove instance table entry
			asla					; a*2 
			leax	Instnces,y		;base of instance table
			clr		a,x+			;clear 1st byte, inc x
			clr		a,x				;clear 2nd byte
			* tell server
			lda     #OP_SERSETSTAT ; load command
			pshs   	a      		; command store on stack
			leax    ,s     		; point X to stack 
			ldy     #3          ; 3 bytes to send 
    
			IFGT  Level-1
			ldu   	<D.DWSUB
			ELSE
			ldu   	>D.DWSUB
			ENDC
			
    		jsr     6,u      	; call DWrite
    		leas	3,s			; clean 3 DWsub args from stack 
			
    		puls 	u
    		*lda		,s+			; remaining ports
    		lda		lportct,pcr
    		deca
    		sta		lportct,pcr
    		beq		DumpVIRQ	;no more ports, lets bail
    		clrb
			rts
			
			* no more ports open.. are we the primary instance?
DumpVIRQ   	cmpu	DWTAdr,u
			bne		Term.Err	;we are not.. hmmm
		 	leay  	VIRQPckt,u	;VIRQ software registers
         	ldx   	#$0000		;code to delete VIRQ entry
         	os9   	F$VIRQ		;remove from VIRQ polling
         	bcs   	Term.Err	;go report error...
DumpIRQ  	leax  	VIRQPckt+Vi.Stat,u	;fake VIRQ status register
         	tfr   	x,d			;copy address...
         	ldx   	#$0000		;code to remove IRQ entry
         	leay  	IRQSvc,pc	;IRQ service routine
         	os9   	F$IRQ
Term.Err    rts


*** byte in code to store port count... is this acceptable?
lportct		fcb		0


***********************************************************************
* Init
*
* Entry:
*    Y  = address of device descriptor
*    U  = address of device memory area
*
* Exit:
*    CC = carry set on error
*    B  = error code
*
            
Init		equ		*
			pshs  cc        save IRQ/Carry status

* Check if D.DWSUB already holds a valid subroutine module pointer
         	IFGT  	Level-1
         	ldx   	<D.DWSUB
         	ELSE
         	ldx   	>D.DWSUB
         	ENDC
         	bne   	DWSetOk

* If here, D.DWSUB is 0, so we must link to subroutine module
         	pshs	u				;preserve u since os9 link is coming up

			IFGT  	Level-1
         	ldx   	<D.Proc
         	pshs  	x
         	ldx   	<D.SysPrc
         	stx   	<D.Proc
         	ENDC
         	clra
         		
         	leax  	dw3name,pcr
         	os9   	F$Link
         	IFGT  	Level-1
         	puls  	x
         	stx   	<D.Proc
         	ENDC
         	lbcs   	InitEx
         	IFGT  	Level-1
         	sty   	<D.DWSUB
         	ELSE
         	sty   	>D.DWSUB
         	ENDC
         	jsr   	,y			call DW init routine
       	
         	puls	u				;restore u
      	
* Setup D.DWTAdr - install IRQ handler if we are the first port
DWSetOk		equ		*
         	* the value seems to remain in memory through a reset, so see if any ports active
         	* should be >0 only if the IRQ is installed
         	* trying local byte..
         	lda		lportct,pcr
         	bne		DWTAdrOk
         	
         	
* If here, ports is 0, so we must install ISR and set D.DWTAdr
     

* Install the IRQ/VIRQ entry 

InstIRQ		leax  	VIRQPckt+Vi.Stat,u 	;fake VIRQ status register
         	lda   	#$80			;VIRQ flag clear, repeated VIRQs
         	sta   	,x				;set it while we're here...
         	tfr   	x,d				;copy fake VIRQ status register address
         	leax  	IRQPckt,pcr		;IRQ polling packet
         	leay  	IRQSvc,pcr  	;IRQ service entry
         	os9   	F$IRQ			;install
         	bcs   	InitEx   		;exit with error
         	ldd   	#$0003     		;lets try every 6 ticks (0.1 seconds) -- testing 3, gives better response in interactive things
         	std   	VIRQPckt+Vi.Rst,u 	;reset count
         	ldx   	#$0001     		;code to install new VIRQ
         	leay  	VIRQPckt,u 		;VIRQ software registers
         	os9   	F$VIRQ			;install
         	bcc   	IRQok1st   		;no error, continue
*         	bsr   	DumpIRQ    		;go remove from IRQ polling - is this necessary? according to OS9 dev ref, if I return an error it calls Term for me?  vrn.asm does this though
         	puls  	cc,pc			;recover error info and exit
         	
IRQok1st	lda		#1				;first port opening
			sta		lportct,pcr		;store
			pshs	a				;for dwsub call
			
			* Set D.DWTAdr
			IFGT  	Level-1
         	stu   	<D.DWTAdr
         	ELSE
         	stu   	>D.DWTAdr
         	ENDC
         	
         	stu		DWTAdr,u		;local DWTAdr pointer
         	tfr		u,x				;x is used below
			bra		IRQok
			
			* value of exisiting DWTAdr in X 
DWTAdrOk	inca					;otherwise, note +1 ports
			sta		lportct,pcr		;store it
			pshs	a				; for dwsub call
			
			* save our pointer to ISR instance
			IFGT  	Level-1
         	ldx   	<D.DWTAdr
         	ELSE
         	ldx   	>D.DWTAdr
         	ENDC
			stx		DWTAdr,u				

			* add our address to main instance's pointer table
IRQok  		lda		<V.PORT+1,u		;get our port #
			asla					; *2 
			leax	Instnces,x		;base of instance table
			stu		a,x				;store in table
	
			* set up local buffer
			ldb   	#RxBufDSz      	;default Rx buffer size
			leax  	RxBuff,u       	;default Rx buffer address
			stb   	RxBufSiz,u      	;save Rx buffer size
			stx   	RxBufPtr,u      	;save Rx buffer address
			stx   	RxBufGet,u      	;set initial Rx buffer input address
			stx   	RxBufPut,u      	;set initial Rx buffer output address
			abx  						;add buffer size to buffer start..
			stx   	RxBufEnd,u      	;save Rx buffer end address

			* tell DW we've got a new port opening
			ldb		<V.PORT+1,u		; get our port #			
			lda     #OP_SERSETSTAT 	; command 
			pshs   	d      			; command + port # on stack
			leax    ,s     			; point X to stack 
			ldy     #3          	; 2 bytes to send
			
			IFGT  Level-1
			ldu   	<D.DWSUB
			ELSE
			ldu   	>D.DWSUB
			ENDC
    		jsr     6,u      		; call DWrite
    		
			*for now setstat doesn't respond    		
    		leas	3,s				;clean dw args off stack
    		
InitEx		equ		*
			puls	cc,pc


* drivewire info
dw3name  	fcs  	/dw3/



***********************************************************************
* Interrupt handler  - Much help from Darren Atkinson

			
IRQMulti3	cmpb	RxGrab,u	;compare room in buffer to server's byte
           	bhs		IRQM06		;room left >= server's bytes, no problem
  					
           	stb		RxGrab,u	;else replace with room left in our buffer
  			
           	* also limit to end of buffer
IRQM06		ldd		RxBufEnd,u	;end addr of buffer
			subd	RxBufPut,u	;subtract current write pointer, result is # bytes left going forward in buff.

IRQM05		cmpb	RxGrab,u	;compare b (room left) to grab bytes  
			bhs		IRQM03		;branch if we have room for grab bytes
			
			stb		RxGrab,u	;else set grab to room left
			
			* send multiread req
IRQM03		lda		4,s			;port # is on stack behind our U and the PC from bsr call in multi2		
			ldb		RxGrab,u

			pshs	u
						
			* setup DWsub command
			pshs	d			; (a port, b bytes)
			lda     #OP_SERREADM ; load command
			pshs   	a      		; command store on stack
			leax    ,s     		; point X to stack 
			ldy     #3          ; 3 bytes to send
    
			IFGT  Level-1
			ldu   	<D.DWSUB
			ELSE
			ldu   	>D.DWSUB
			ENDC
    		jsr     6,u      	; call DWrite
    		
    		leas	3,s			; clean 3 DWsub args from stack 
    		
    		ldx		,s			; pointer to this port's area (from U prior), leave it on stack
    		ldb		RxGrab,x	; set B to grab bytes
    		clra				; 0 in high byte		
    		tfr		d,y			;set # bytes for DW
    		
    		ldx    RxBufPut,x	; point X to insert position in this port's buffer
    		* receive response
    		jsr     3,u    		; call DWRead
			* handle errors?
			
			
			puls	u
			ldb		RxGrab,u	; our grab bytes

			* set new RxBufPut
			ldx 	RxBufPut,u	;current write pointer
			abx					;add b (# bytes) to RxBufPut
			cmpx  	RxBufEnd,u 	;end of Rx buffer?
			blo   	IRQM04		;no, go keep laydown pointer
			ldx   	RxBufPtr,u 	;get Rx buffer start address
IRQM04   	stx   	RxBufPut,u 	;set new Rx data laydown pointer

			* set new RxDatLen
			ldb		RxDatLen,u
			addb	RxGrab,u
			stb		RxDatLen,u	;store new value
			
			puls	u
			rts
			
IRQMulti	pshs	u			;save local u
			
 			leax    Instnces,u	;base of instance pointer table
           	asla           		;a*2 bytes per instance address
           	ldu     a,x     	;U = pointer to instance data from table, now buffervar,u points to this port's buffer, etc	
  			
           	* initial grab bytes
           	stb		RxGrab,u	
           	
  			* limit server bytes to bufsize - datlen
  			ldb		RxBufSiz,u	;size of buffer
           	subb	RxDatLen,u	;current bytes in buffer
           	bne		IRQMulti3	;continue, we have some space in buffer
  			* no room in buffer
  			puls	u
  			rts
           	
IRQMulti2	anda    #$07		;mask first 5 bits, a is now port #+1
  			deca				;we pass +1 to use 0 for no data
  			pshs	a			;save port # for serreadm call and return to cksuspnd
  			bsr		IRQMulti
  			cmpb	#0
  			bne		CkSuspnd
  			leas	1,s
  			bra		IRQExit
  			
IRQSvc		equ		*
			pshs  	cc,dp 		;save system cc,DP
			orcc	#$50		;mask interrupts
			
			* mark VIRQ handled
			lda   	VIRQPckt+Vi.Stat,u	;VIRQ status register
			anda  	#^Vi.IFlag 	;clear flag in VIRQ status register
			sta   	VIRQPckt+Vi.Stat,u	;save it...
			
			* poll server for incoming serial data
			
			* send request
			pshs 	u			;see U later
			
			lda     #OP_SERREAD ; load command
			pshs   	a      		; command store on stack
			leax    ,s     		; point X to stack 
			ldy     #1          ; 1 byte to send
    
			IFGT  Level-1
			ldu   	<D.DWSUB
			ELSE
			ldu   	>D.DWSUB
			ENDC
    		jsr     6,u      	; call DWrite
    		
    		* receive response
    		leas	-1,s		;one more byte to fit response
			leax    ,s   		; point X to stack head
			ldy     #2    		; 2 bytes to retrieve
			jsr     3,u    		; call DWRead
			beq     IRQSvc2		; branch if no error
			leas    2,s     	; error, cleanup stack 2
			puls	u			; get U back
			lda		DWErrors,u	; current error count	 
			inca
			* TODO - At some point, decide to bail out
			sta		DWErrors,u	; store new error count
			bra		IRQExit2	; don't reset error count on the way out
			
			* process response	
IRQSvc2		ldd     ,s++     	; pull returned status byte into A,data into B (set Z if zero, N if multiread)

  			puls	u			; get local u back - stack should be clean except initial save of cc and dp

  			beq   	IRQExit  	; branch if D = 0 (nothing to do)
  			
  			bmi		IRQMulti2	; branch for multiread
  			
  			* get port # (last 3 bits of status byte (a)
  			anda    #$07		;mask first 5 bits, a is now port #+1
  			deca				;we pass +1 to use 0 for no data
  			
  			pshs	a			;save port #
  			bsr		IRQPutCh	;put one character into buffer

  			* check if we have a process waiting for data	
CkSuspnd   	puls	b			;stack has port #
			leax	RxWaiter,u	;waiter table
			lda   	b,x       	;waiter?
			beq   	IRQExit   	;no
			clr 	b,x			;clear waiter
			
			* wake up waiter for read
			IFEQ  	Level-1
			ldb   	#S$Wake
			os9   	F$Send
			ELSE
			clrb
			tfr   	d,x            ;copy process descriptor pointer
			lda   	P$State,x      ;get state flags
			anda  	#^Suspend      ;clear suspend state
			sta   	P$State,x      ;save state flags
			ENDC

IRQExit		clr		DWErrors,u	;reset DW error count	           
IRQExit2  	puls  	cc,dp		;restore interrupts cc,dp
			rts					;return
         

* put byte B in port A's buffer - optimization help from Darren Atkinson       
IRQPutCh    pshs    u,b     	;save u and our data byte
           	leax    Instnces,u	;base of instance pointer table
           	asla           		;a*2 bytes per instance address
           	ldu     a,x     	;U = pointer to instance data from table
           	ldx     RxBufPut,u	;point X to the data buffer
        
			* sc6551 now does lots of things with flow control, we might want some of this
			* but implemented differently.. for now.. skip it
		   
			* store our data byte
			puls	a			;retrieve data byte
			sta    	,x+     	; store and increment buffer pointer
        
			* adjust RxBufPut	
			cmpx  	RxBufEnd,u 	;end of Rx buffer?
			blo   	IRQSkip1	;no, go keep laydown pointer
			ldx   	RxBufPtr,u 	;get Rx buffer start address
IRQSkip1   	stx   	RxBufPut,u 	;set new Rx data laydown pointer

			* increment RxDatLen
			lda		RxDatLen,u
			inca	
			sta		RxDatLen,u

			puls	u,pc		;restore u, rts
	
			
*****************************************************************************
* Write
*
* Entry:
*    A  = character to write
*    Y  = address of path descriptor
*    U  = address of device memory area
*
* Exit:
*    CC = carry set on error
*    B  = error code
*
* 
Write    	equ   	*
         	pshs	a				; character to send on stack
         	ldb		V.PORT+1,u		;port number into B
         	lda   	#OP_SERWRITE	; put command into A
         	pshs  	d
         	leax  	,s
         	ldy   	#$0003			; 3 bytes to send.. ugh.  need WRITEM (data mode)
         	IFGT  	Level-1
         	ldu   	<D.DWSUB
         	ELSE
         	ldu   	>D.DWSUB
         	ENDC
         	jsr   	6,u
WriteOK   	clrb
WriteExit 	puls	a,x,pc		; clean stack, return

	
*************************************************************************************
* Read - my crazy attempt #4

Read    	equ  	*
			pshs  	cc,dp          save IRQ/Carry status, system DP

ReadChr		orcc	#$50		;mask interrupts
			
			lda   	RxDatLen,u 	;get our Rx buffer count
			beq   	ReadSlp 	;no data, go sleep while waiting for new Rx data...
			
			* we have data waiting
			deca				;one less byte in buffer
			sta   	RxDatLen,u 	;save new Rx data count
			
			ldx   	RxBufGet,u 	;current Rx buffer pickup position
			lda   	,x+       	;get Rx character, set up next pickup position
			
			cmpx  	RxBufEnd,u 	;end of Rx buffer?
			blo   	ReadChr1   	;no, keep pickup pointer
			ldx   	RxBufPtr,u 	;get Rx buffer start address
ReadChr1   	stx   	RxBufGet,u	;set new Rx data pickup pointer
			
			* return to caller
			puls  	cc,dp,pc   	;recover IRQ/Carry status, system DP, return with character in A

ReadSlp		equ		*

			ldy		DWTAdr,u	;offset to main instance
			leax	RxWaiter,y	; X = waiter table address
			ldb		V.PORT+1,u	;port number into B
			
           	IFEQ  	Level-1
ReadSlp2   	lda   	<V.BUSY
           	sta   	b,x			;store process id in this port's entry in the waiter table
           	lbsr  	Sleep0     	;sleep level 1 style
           	ELSE
ReadSlp2   	lda   	>D.Proc    	;process descriptor address MSB
           	sta   	b,x        	;save MSB in waiter table
           	clrb
           	tfr		d,x			;process descriptor address
           	IFNE  	H6309
           	oim   	#Suspend,P$State,x 	;suspend
           	ELSE
           	ldb   	P$State,x
           	orb   	#Suspend
           	stb   	P$State,x 	;suspend
           	ENDC
           	lbsr  Sleep1		;sleep level 2 style
           	ENDC
           	
           	* we've been awakened..
           	
           	* check for signals
           	ldx   	>D.Proc		;process descriptor address
           	ldb   	P$Signal,x 	;pending signal for this process?
           	beq   	ChkState  	;no, go check process state...
           	cmpb  	#S$Intrpt  	;(interrupt only)
           	lbls  	ErrExit    	;yes, go do it...

ChkState   	equ   	*
			* have we been condemned to die?
           	IFNE  	H6309
          	tim   	#Condem,P$State,x
          	ELSE
          	ldb   	P$State,x
           	bitb  	#Condem
           	ENDC
           	bne   	PrAbtErr 	;yes, go do it...
           	
           	* check that our waiter byte was cleared by ISR instance
           	ldy		DWTAdr,u	;offset to main instance
			leax	RxWaiter,y	; X = waiter address for this port
			ldb		V.PORT+1,u	;port number into B
			lda		b,x			;our waiter byte
			beq		ReadChr		;0 = its our turn, go get a character 
           	bra   	ReadSlp		;false alarm, go back to sleep

PrAbtErr	ldb   	#E$PrcAbt	;set error code

ErrExit    	equ  	*
           	IFNE  	H6309
           	oim   	#Carry,,s 	;set carry
           	ELSE
           	lda   	,s
           	ora   	#Carry
           	sta   	,s
           	ENDC
           	puls 	cc,dp,pc 	;restore CC, system DP, return

           	IFEQ  	Level-1
Sleep0     	ldx   	#$0			;sleep till ISR wakes us
           	bra   	TimedSlp
           	ENDC

Sleep1     	ldx   	#$1			;just sleep till end of slice, we are suspended (level 2)             
TimedSlp	andcc 	#^Intmasks  ;enable IRQs
			os9   	F$Sleep
           	rts          		;return


**********************************************************************
* GetStat - heavily borrowed from sc6551
*
* Entry:
*    A  = function code
*    Y  = address of path descriptor
*    U  = address of device memory area
*
* Exit:
*    CC = carry set on error
*    B  = error code 
*

GetStt		clrb    			;default to no error...
			pshs  	cc,dp  		;save IRQ/Carry status,system DP
           
        	ldx   	PD.RGS,y	;caller's register stack pointer
        	cmpa  	#SS.EOF		
        	beq   	GSExitOK 	;SCF devices never return EOF
           
        	cmpa  	#SS.Ready
        	bne   	GetScSiz	;next check
           	
        	* SS.Ready
        	lda   	RxDatLen,u	;get Rx data length
        	beq   	NRdyErr    	;none, go report error
        	sta   	R$B,x		;set Rx data available in caller's [B]
GSExitOK	puls  	cc,dp,pc 	;restore Carry status, system DP, return         
         
NRdyErr		ldb  	#E$NotRdy         
			bra		ErrExit		; return error code 

UnSvcErr   	ldb   	#E$UnkSvc
           	bra   	ErrExit		; return error code			
			
GetScSiz   	cmpa  	#SS.ScSiz
           	bne   	GetComSt	; next check
           	ldu   	PD.DEV,y
           	ldu   	V$DESC,u	; device descriptor
           	clra
           	ldb   	IT.COL,u	; return screen size
           	std   	R$X,x
           	ldb   	IT.ROW,u
           	std   	R$Y,x
           	puls  	cc,dp,pc	;restore Carry status, system DP, return

GetComSt   	cmpa  	#SS.ComSt
           	lbne  	UnSvcErr	;no, we have no more answers, report error
           	ldd   	FlowCtrl,u	;flow control info
           	std   	R$Y,x
           	clra                 ;default to DCD and DSR enabled
           	sta   	R$B,x		;set 6551 ACIA style DCD/DSR status in caller's [B]
           	puls  	cc,dp,pc	;restore Carry status, system DP, return			

*************************************************************************         
* SetStat
*
* Entry:
*    A  = function code
*    Y  = address of path descriptor
*    U  = address of device memory area
*
* Exit:
*    CC = carry set on error
*    B  = error code 
*  
* also needs much work
SetStt   
Close    cmpa  #SS.Close	close the device?
         bne   L0173
         lda   #OP_NOP	
         pshs  a
         ldy   #$0001
         leax  ,s
         IFGT  Level-1
         ldu   <D.DWSUB
         ELSE
         ldu   >D.DWSUB
         ENDC
         jsr   6,u
         puls  a,pc


L0173    comb
         ldb   #E$UnkSVc
         rts

         
         
         emod
eom      equ   *
         end
