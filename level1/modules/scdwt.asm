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
RxGrab     rmb   1              ;bytes to grab in multiread
RxBufPtr   rmb   2              ;pointer to Rx buffer
RxBufDSz   equ   256-.          ;default Rx buffer gets remainder of page...
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
Term     	equ   	*

			lda		<V.PORT+1,u		;get our port #

			pshs 	a				;port # on stack
			* clear statics table entry
			IFGT    Level-1
			ldx   	<D.DWStat
			ELSE
			ldx   	>D.DWStat
			ENDC
* Cheat: we know DW.StatTbl is at offset $00 from D.DWStat, do not bother with leax
*			leax    DW.StatTbl,x
			clr		a,x				;clear out

			* tell server
			lda     #OP_SERTERM ; load command
			pshs   	a      		; command store on stack
			leax    ,s     		; point X to stack 
			ldy     #2          ; 2 bytes to send 
    
            pshs    u

			IFGT  Level-1
			ldu   	<D.DWSubAddr
			ELSE
			ldu   	>D.DWSubAddr
			ENDC
			
    		jsr     6,u      	; call DWrite

            puls    u
			
    		leas	2,s			; clean 3 DWsub args from stack 
			
* Check if we need to clean up IRQ
			bsr     CheckStats
    		beq		DumpVIRQ	;no more ports, lets bail
    		clrb
			rts
			
* no more ports open.. are we the primary instance?
DumpVIRQ   	
			IFGT    Level-1
			ldy   	<D.DWStat
			ELSE
			ldy   	>D.DWStat
			ENDC
			leay    DW.VIRQPkt,y
         	ldx   	#$0000		;code to delete VIRQ entry
         	os9   	F$VIRQ		;remove from VIRQ polling
         	bcs   	ReleaseMem	;go
DumpIRQ
			IFGT    Level-1
			ldx   	<D.DWStat
			ELSE
			ldx   	>D.DWStat
			ENDC
			leax    DW.VIRQPkt,x
			tfr     x,u
         	leax  	Vi.Stat,x	;fake VIRQ status register
         	tfr   	x,d			;copy address...
         	ldx   	#$0000		;code to remove IRQ entry
         	leay  	IRQSvc,pc	;IRQ service routine
         	os9   	F$IRQ

ReleaseMem
			IFGT    Level-1
			ldu     <D.DWStat
			ELSE
			ldu     >D.DWStat
			ENDC
			ldd     #$0100
			os9     F$SRtMem
Term.Err    rts


***********************************************************************
* CheckStats - Check if the D.DWStat table is empty
* Entry: None
* Exit:  B=0, stat table is empty; B!=0, stat table is not empty
CheckStats
         	pshs  	x
			IFGT    Level-1
			ldx     <D.DWStat
			ELSE
			ldx     >D.DWStat
			ENDC
* Cheat: we know DW.StatTbl is at offset $00 from D.DWStat, do not bother with leax
*			leax    DW.StatTbl,x
			ldb     #7
CheckLoop   tst     ,x+
			bne     CheckExit
			decb
			bne     CheckLoop
CheckExit   puls    x,pc
         	
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

* link to subroutine module
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
         	sty   	<D.DWSubAddr
         	ELSE
         	sty   	>D.DWSubAddr
         	ENDC
         	jsr   	,y			call DW init routine
       	
         	puls	u				;restore u
      	
			IFGT    Level-1
			ldx     <D.DWStat
			ELSE
			ldx     >D.DWStat
			ENDC
			bne     IRQok

* allocate DW stat page
			pshs    u
			ldd     #$0100
			os9     F$SRqMem
			tfr     u,d
			puls    u
			bcs     InitEx
			IFGT    Level-1
			std     <D.DWStat
			ELSE
			std     >D.DWStat
			ENDC
         	
* If here, we must install ISR
     

* Install the IRQ/VIRQ entry 
InstIRQ
			IFGT    Level-1
			ldx   	<D.DWStat
			ELSE
			ldx   	>D.DWStat
			ENDC
			leax    DW.VIRQPkt,x
            pshs    u
			tfr     x,u
		    leax  	Vi.Stat,x		;fake VIRQ status register
         	lda   	#$80			;VIRQ flag clear, repeated VIRQs
         	sta   	,x				;set it while we're here...
         	tfr   	x,d				;copy fake VIRQ status register address
         	leax  	IRQPckt,pcr		;IRQ polling packet
         	leay  	IRQSvc,pcr  	;IRQ service entry
         	os9   	F$IRQ			;install
			puls    u
         	bcs   	InitEx   		;exit with error
         	ldd   	#$0003     		;lets try every 6 ticks (0.1 seconds) -- testing 3, gives better response in interactive things
			IFGT    Level-1
			ldx   	<D.DWStat
			ELSE
			ldx   	>D.DWStat
			ENDC
			leax    DW.VIRQPkt,x
         	std   	Vi.Rst,x		;reset count
			tfr     x,y             ;move VIRQ software packet to Y
         	ldx   	#$0001     		;code to install new VIRQ
         	os9   	F$VIRQ			;install
         	bcc   	IRQok1st   		;no error, continue
*         	bsr   	DumpIRQ    		;go remove from IRQ polling - is this necessary? according to OS9 dev ref, if I return an error it calls Term for me?  vrn.asm does this though
         	puls  	cc,pc			;recover error info and exit
         	
IRQok1st	
IRQok
			IFGT    Level-1
			ldx     <D.DWStat
			ELSE
			ldx     >D.DWStat
			ENDC
* Cheat: we know DW.StatTbl is at offset $00 from D.DWStat, do not bother with leax
*			leax    DW.StatTbl,x
			tfr     u,d
	        ldb		<V.PORT+1,u		;get our port #
			sta		b,x				;store in table
	
			* set up local buffer
			ldb   	#RxBufDSz      	;default Rx buffer size
			leax  	RxBuff,u       	;default Rx buffer address
			stb   	RxBufSiz,u      	;save Rx buffer size
			stx   	RxBufPtr,u      	;save Rx buffer address
			stx   	RxBufGet,u      	;set initial Rx buffer input address
			stx   	RxBufPut,u      	;set initial Rx buffer output address
			abx  						;add buffer size to buffer start..
			stx   	RxBufEnd,u      	;save Rx buffer end address

			* tell DW we have a new port opening
			ldb		<V.PORT+1,u		; get our port #			
			lda     #OP_SERSETSTAT 	; command 
			pshs   	d      			; command + port # on stack
			leax    ,s     			; point X to stack 
			ldy     #2          	; 2 bytes to send
			
			IFGT  Level-1
			ldu   	<D.DWSubAddr
			ELSE
			ldu   	>D.DWSubAddr
			ENDC
    		jsr     6,u      		; call DWrite
    		
			*for now setstat doesn't respond    		
    		leas	2,s				;clean dw args off stack
    		
InitEx		equ		*
			puls	cc,pc


* drivewire info
dw3name  	fcs  	/dw3/



***********************************************************************
* Interrupt handler  - Much help from Darren Atkinson

			
IRQMulti3   anda    #$07		;mask first 5 bits, a is now port #+1
  			deca				;we pass +1 to use 0 for no data
            pshs    a			;save port #
         	cmpb	RxGrab,u	;compare room in buffer to server's byte
           	bhs		IRQM06		;room left >= server's bytes, no problem
  					
           	stb		RxGrab,u	;else replace with room left in our buffer
  			
           	* also limit to end of buffer
IRQM06		ldd		RxBufEnd,u	;end addr of buffer
			subd	RxBufPut,u	;subtract current write pointer, result is # bytes left going forward in buff.

IRQM05		cmpb	RxGrab,u	;compare b (room left) to grab bytes  
			bhs		IRQM03		;branch if we have room for grab bytes
			
			stb		RxGrab,u	;else set grab to room left
			
			* send multiread req
IRQM03		puls    a			;port # is on stack
			ldb		RxGrab,u

			pshs	u
						
			* setup DWsub command
			pshs	d			; (a port, b bytes)
			lda     #OP_SERREADM ; load command
			pshs   	a      		; command store on stack
			leax    ,s     		; point X to stack 
			ldy     #3          ; 3 bytes to send
    
			IFGT  Level-1
			ldu   	<D.DWSubAddr
			ELSE
			ldu   	>D.DWSubAddr
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
			
			bra     CkSuspnd
			
IRQMulti			
           	* initial grab bytes
           	stb		RxGrab,u	
           	
  			* limit server bytes to bufsize - datlen
  			ldb		RxBufSiz,u	;size of buffer
           	subb	RxDatLen,u	;current bytes in buffer
           	bne		IRQMulti3	;continue, we have some space in buffer
  			* no room in buffer
  			tstb
  			bne		CkSuspnd
  			bra		IRQExit
  			

**** IRQ ENTRY POINT
IRQSvc		equ		*
			pshs  	cc,dp 		;save system cc,DP
			orcc	#IntMasks	;mask interrupts
			
			* mark VIRQ handled (note U is pointer to our VIRQ packet in DP)
			lda   	Vi.Stat,u	;VIRQ status register
			anda  	#^Vi.IFlag 	;clear flag in VIRQ status register
			sta   	Vi.Stat,u	;save it...
			
			* poll server for incoming serial data
 			
			* send request
			lda     #OP_SERREAD ; load command
			pshs   	a      		; command store on stack
			leax    ,s     		; point X to stack 
			ldy     #1          ; 1 byte to send
    
			IFGT  Level-1
			ldu   	<D.DWSubAddr
			ELSE
			ldu   	>D.DWSubAddr
			ENDC
    		jsr     6,u      	; call DWrite
    		
    		* receive response
    		leas	-1,s		;one more byte to fit response
			leax    ,s   		; point X to stack head
			ldy     #2    		; 2 bytes to retrieve
			jsr     3,u    		; call DWRead
			beq     IRQSvc2		; branch if no error
			leas    2,s     	; error, cleanup stack 2
			bra		IRQExit2	; don't reset error count on the way out
			
			* process response	
IRQSvc2
     		ldd     ,s++     	; pull returned status byte into A,data into B (set Z if zero, N if multiread)
  			beq   	IRQExit  	; branch if D = 0 (nothing to do)

* save back D on stack and build our U
            pshs    d
  			anda    #$07		;mask first 5 bits, a is now port #+1
  			deca				;we pass +1 to use 0 for no data
* here we set U to the static storage area of the device we are working with
			IFGT    Level-1
			ldx   	<D.DWStat
			ELSE
			ldx   	>D.DWStat
			ENDC
* Cheat: we know DW.StatTbl is at offset $00 from D.DWStat, do not bother with leax
*			leax    DW.StatTbl,x
			lda     a,x
			bne		IRQCont		;if A is 0, then this device is not active, so exit
            puls    d
			bra     IRQExit
IRQCont
			clrb
			tfr     d,u

     		ldd     ,s++     	; pull returned status byte into A,data into B (set Z if zero, N if multiread)
  			
  			bmi		IRQMulti	; branch for multiread
  			
* put byte B in port A's buffer - optimization help from Darren Atkinson       
IRQPutCh   	ldx     RxBufPut,u	;point X to the data buffer
        
* process interrupt/quit characters here
* note we will have to do this in the multiread (ugh)                     
*                  lda  #S$Intrpt
*		  cmpb V.INTR,u
*                  bne  test2
test2
*                  lda  #S$Abort
*                  cmpb V.QUIT,u
*                  bne store
*                  ldb  V.LPRC,u
*                  exg  a,b
*                  os9  F$Send 
*                  bra  IRQExit
 
store
			* store our data byte
			stb    	,x+     	; store and increment buffer pointer
        
			* adjust RxBufPut	
			cmpx  	RxBufEnd,u 	;end of Rx buffer?
			blo   	IRQSkip1	;no, go keep laydown pointer
			ldx   	RxBufPtr,u 	;get Rx buffer start address
IRQSkip1   	stx   	RxBufPut,u 	;set new Rx data laydown pointer

			* increment RxDatLen
			inc		RxDatLen,u


  			* check if we have a process waiting for data	
CkSuspnd   	lda   	<V.WAKE,u   	;V.WAKE?
			beq   	IRQExit   	;no
			clr 	<V.WAKE,u		;clear V.WAKE
			
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

IRQExit
IRQExit2  	puls  	cc,dp,pc		;restore interrupts cc,dp, return
         

			
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
         	ldu   	<D.DWSubAddr
         	ELSE
         	ldu   	>D.DWSubAddr
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

           	IFEQ  	Level-1
ReadSlp2   	lda   	<V.BUSY,u
           	sta   	<V.WAKE,u		;store process id in this port's entry in the waiter table
           	lbsr  	Sleep0     	;sleep level 1 style
           	ELSE
ReadSlp2   	lda   	>D.Proc    	;process descriptor address MSB
           	sta   	<V.WAKE,u        	;save MSB in V.WAKE
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
			lda		<V.WAKE,u		;our waiter byte
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
         ldu   <D.DWSubAddr
         ELSE
         ldu   >D.DWSubAddr
         ENDC
         jsr   6,u
         puls  a,pc


L0173    comb
         ldb   #E$UnkSVc
         rts

         
         
         emod
eom      equ   *
         end
