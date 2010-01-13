********************************************************************
* scdwn - CoCo DriveWire Network Driver
*
* $Id$
*
* Edt/Rev  YYYY/MM/DD  Modified by
* Comment
* ------------------------------------------------------------------
*   1      2009/11/30  Aaron Wolfe
* Started
*
*          2009/12/28  Boisy G. Pitre
* Modified so that F$STime is called if we get an error on calling
* F$VIRQ (which means the clock module has not be initialized)
*
*          2009/12/31  Boisy G. Pitre
* Fixed crash in Init where F$Link failure would not clean up stack
*
*          2010/01/03  Boisy G. Pitre
* Moved IRQ stuff into DW3 subroutine module

         	nam   	scdwn
         	ttl   	CoCo DriveWire Network Driver

         	ifp1
         	use   	defsfile
         	use   	dwdefs.d
         	endc


tylg     	set   	Drivr+Objct   
atrv     	set   	ReEnt+Rev
rev      	set   	$00
edition  	set   	1

* Note: driver memory defined in dwdefs.d
         	mod   	eom,name,tylg,atrv,start,SCFDrvMemSz

* module info         	
         	fcb   	READ.+WRITE.	;driver access modes
name     	fcs   	/scdwn/		;driver name
         	fcb   	edition   	;driver edition 

* dispatch calls            
start    	equ   	*
         	lbra  	Init
         	lbra  	Read
         	lbra  	Write
         	lbra  	GetStat
         	lbra  	SetStat
	 	
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
          lda       <V.PORT+1,u		;get our port #
          pshs 	a				;port # on stack
          * clear statics table entry
          IFGT      Level-1
          ldx   	<D.DWStat
          ELSE
          ldx   	>D.DWStat
          ENDC
          beq       tell
; cheat: we know DW.StatTbl is at offset $00 from D.DWStat, do not bother with leax
;		leax      DW.StatTbl,x
          clr		a,x				;clear out

          ; tell server
tell
          lda       #OP_SERTERM ; load command
          pshs   	a      		; command store on stack
          leax      ,s     		; point X to stack 
          ldy       #2          ; 2 bytes to send 

          pshs      u

          IFGT      Level-1
          ldu   	<D.DWSubAddr
          ELSE
          ldu   	>D.DWSubAddr
          ENDC
          beq       nosub		
    		jsr       6,u      	; call DWrite

nosub
          puls      u
    		leas      2,s			; clean 3 DWsub args from stack 
    		clrb
          rts

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

          lda	IT.PAR,y
          pshs      a				; save parity byte for later

; link to subroutine module
; has the link already been done?
          IFGT      Level-1
          ldx       <D.DWSubAddr
          ELSE
          ldx       >D.DWSubAddr
          ENDC
          bne       already			; if so, do not bother
			
         	pshs      u				; preserve u since os9 link is coming up

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
         	bcs   	InitEx2
         	IFGT  	Level-1
         	sty   	<D.DWSubAddr
         	ELSE
         	sty   	>D.DWSubAddr
         	ENDC
         	jsr   	,y				; call DW init routine
       	
          puls	u                        ; restore u
      	
already
; tell DW we have a new port opening (port mode already on stack)
          ldb		<V.PORT+1,u		; get our port #			
          lda       #OP_SERINIT         ; command 
          pshs   	d      			; command + port # on stack
          leax      ,s     			; point X to stack 
          ldy       #3                  ; # of bytes to send
			
          pshs u
          IFGT      Level-1
          ldu   	<D.DWSubAddr
          ELSE
          ldu   	>D.DWSubAddr
          ENDC
    		jsr       6,u                 ; call DWrite
          puls      u
    		
; set up local buffer
          ldb   	#RxBufDSz      	; default Rx buffer size
          leax  	RxBuff,u       	; default Rx buffer address
          stb   	RxBufSiz,u     	; save Rx buffer size
          stx   	RxBufPtr,u     	; save Rx buffer address
          stx   	RxBufGet,u          ; set initial Rx buffer input address
          stx   	RxBufPut,u          ; set initial Rx buffer output address
          abx  					; add buffer size to buffer start..
          stx   	RxBufEnd,u     	; save Rx buffer end address

          tfr       u,d                 ; (A = high page of statics)
          puls      b
          puls      b                   ; (B = port number)
          IFGT      Level-1
          ldx       <D.DWStat
          ELSE
          ldx       >D.DWStat
          ENDC
; cheat: we know DW.StatTbl is at offset $00 from D.DWStat, do not bother with leax
;		leax      DW.StatTbl,x
          sta       b,x
InitEx	equ		*
          puls      a,pc
InitEx2
          puls      u
          puls      a,pc

; drivewire info
dw3name  	fcs  	/dw3/


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
Write    	equ   	*
         	pshs      a			; character to send on stack
         	ldb		<V.PORT+1,u	; port number into B
         	lda   	#OP_SERWRITE	; put command into A
         	pshs  	d
         	leax  	,s
         	ldy   	#$0003		; 3 bytes to send.. ugh.  need WRITEM (data mode)
         	IFGT  	Level-1
         	ldu   	<D.DWSubAddr
         	ELSE
         	ldu   	>D.DWSubAddr
         	ENDC
         	jsr   	6,u
WriteOK   clrb
WriteExit puls      a,x,pc		; clean stack, return

	
NotReady  comb
          ldb       #E$NotRdy
          rts

*************************************************************************************
* Read
*
* Entry:
*    Y  = address of path descriptor
*    U  = address of device memory area
*
* Exit:
*    A  = character read
*    CC = carry set on error
*    B  = error code
*
Read      equ           *
* Check to see if there is a signal-on-data-ready set for this path.
* If so, we return a Not Ready error.
          lda           <SSigID,u     data ready signal trap set up?
          bne           NotReady        yes, exit with not ready error
          pshs  	cc,dp       ; save IRQ/Carry status, system DP

ReadChr   orcc          #IntMasks	; mask interrupts
          
          lda   	RxDatLen,u 	; get our Rx buffer count
          beq   	ReadSlp 	; no data, go sleep while waiting for new Rx data...
			
          ; we have data waiting
          deca				; one less byte in buffer
          sta   	RxDatLen,u 	; save new Rx data count
          
          ldx   	RxBufGet,u 	; current Rx buffer pickup position
          lda   	,x+       	; get Rx character, set up next pickup position
          
          cmpx  	RxBufEnd,u 	; end of Rx buffer?
          blo   	ReadChr1   	; no, keep pickup pointer
          ldx   	RxBufPtr,u 	; get Rx buffer start address
ReadChr1 	stx   	RxBufGet,u	; set new Rx data pickup pointer
			
          ; return to caller
          puls  	cc,dp,pc   	; recover IRQ/Carry status, system DP, return with character in A

ReadSlp	equ		*

          IFEQ  	Level-1
ReadSlp2 	lda   	<V.BUSY,u
          sta   	<V.WAKE,u	; store process id in this port's entry in the waiter table
          lbsr  	Sleep0     	; sleep level 1 style
          ELSE
ReadSlp2   lda   	>D.Proc    	; process descriptor address MSB
          sta   	<V.WAKE,u   ; save MSB in V.WAKE
          clrb
          tfr		d,x			; process descriptor address
          IFNE  	H6309
          oim   	#Suspend,P$State,x 	; suspend
          ELSE
          ldb   	P$State,x
          orb   	#Suspend
          stb   	P$State,x 	; suspend
          ENDC
          bsr		Sleep1		; sleep level 2 style
          ENDC
          
          ; we have been awakened..
          
          ; check for signals
          ldx   	>D.Proc		; process descriptor address
          ldb   	P$Signal,x 	; pending signal for this process?
          beq   	ChkState  	; no, go check process state...
          cmpb  	#S$Peer  	; (S$Peer or lower)
          bls  	ErrExit    	; yes, go do it...

ChkState 	equ   	*
          ; have we been condemned to die?
          IFNE  	H6309
          tim   	#Condem,P$State,x
          ELSE
          ldb   	P$State,x
          bitb  	#Condem
          ENDC
          bne   	PrAbtErr 	; yes, go do it...
          
          ; check that our waiter byte was cleared by ISR instance
          tst		<V.WAKE,u	; our waiter byte
          beq		ReadChr		; 0 = its our turn, go get a character 
          bra   	ReadSlp		; false alarm, go back to sleep

PrAbtErr	ldb   	#E$PrcAbt	; set error code

ErrExit  	equ  	*
          IFNE  	H6309
          oim   	#Carry,,s 	; set carry
          ELSE
          lda   	,s
          ora   	#Carry
          sta   	,s
          ENDC
          puls 	cc,dp,pc 	; restore CC, system DP, return

          IFEQ  	Level-1
Sleep0   	ldx   	#$0			; sleep till ISR wakes us
          bra   	TimedSlp
          ENDC

Sleep1    ldx   	#$1			; just sleep till end of slice, we are suspended (level 2)             
TimedSlp	andcc 	#^Intmasks     ; enable IRQs
          os9   	F$Sleep
          clr       <V.WAKE,u
          rts                      ; return


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
GetStat
          clrb                     ; default to no error...
          pshs  	cc,dp  		; save IRQ/Carry status,system DP
           
        	ldx   	PD.RGS,y       ; caller's register stack pointer
        	cmpa  	#SS.EOF		
        	beq   	GSExitOK       ; SCF devices never return EOF
           
        	cmpa  	#SS.Ready
        	bne   	Advertise      ; next check
           	
        	; SS.Ready
        	lda   	RxDatLen,u	; get Rx data length
        	beq   	NRdyErr    	; none, go report error
        	sta   	R$B,x		; set Rx data available in caller's [B]
GSExitOK	puls  	cc,dp,pc       ; restore Carry status, system DP, return         
         
NRdyErr	ldb  	#E$NotRdy         
          bra		ErrExit		; return error code 

UnSvcErr 	ldb   	#E$UnkSvc
          bra   	ErrExit		; return error code			
			
; We advertise all of our SERGETSTAT calls (except SS.Ready) to the server
Advertise
          ldb		#OP_SERGETSTAT
          bsr		SendStat

; Note: Here we could somehow obtain the size of the terminal window from the server
GetScSiz  cmpa  	#SS.ScSiz
          bne   	GetComSt	; next check
          ldu   	PD.DEV,y
          ldu   	V$DESC,u	; device descriptor
          clra
          ldb   	IT.COL,u	; return screen size
          std   	R$X,x
          ldb   	IT.ROW,u
          std   	R$Y,x
          puls  	cc,dp,pc	; restore Carry status, system DP, return

GetComSt  cmpa  	#SS.ComSt
          bne  	UnSvcErr	; no, we have no more answers, report error
          ldd   	#$0000		; not used, return $0000
          std   	R$Y,x
          sta   	R$B,x
          puls  	cc,dp,pc	; restore Carry status, system DP, return			

* Advertise Stat Code to server
* A = Function Code
* B = OP_SERGETSTAT or OP_SERSETSTAT
SendStat
; advertise our GetStt code to the server
          pshs      a,y,x,u
          leas      -3,s
          leax      ,s
          stb		,x
          sta		2,x
          ldb		V.PORT+1,u
          stb		1,x
          ldy		#$0003
          IFGT      LEVEL-1
          ldu		<D.DWSubAddr
          ELSE
          ldu		>D.DWSubAddr
          ENDC
          jsr		6,u                    
          leas      3,s
          puls      a,y,x,u,pc

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
SetStat  
		ldb       #OP_SERSETSTAT
		bsr       SendStat
		cmpa      #SS.Open
                beq       open
		cmpa      #SS.ComSt
                beq       comst
                cmpa      #SS.SSig
		beq       ssig
                cmpa      #SS.Relea
                bne      donebad
relea           lda      PD.CPR,y	get curr proc #
                cmpa     <SSigID,u    same?
                bne      ex
                clr      <SSigID,u    clear process id
ex              rts
ssig            pshs    cc
                orcc    #IntMasks
                lda     PD.CPR,y        ; get curr proc #
                ldx     PD.RGS,y
                ldb     R$X+1,x         ; get user signal code
        	tst     RxDatLen,u	; get Rx data length
                beq     ssigsetup       ; branch if no data in buffer
* if here, we have data so send signal immediately
                os9     F$Send
                puls    cc,pc
ssigsetup       std     <SSigID,u     ; save process ID & signal
                puls    cc,pc

comst		leax      PD.OPT,y
		ldy       #OPTCNT
		IFGT      LEVEL-1
		ldu       <D.DWSubAddr
		ELSE
		ldu       >D.DWSubAddr
		ENDC
		jsr       6,u
          clrb
          rts

open            tst     <V.PORT,u     check if this is 0 (wildcard)
                bne     openex
* wildcard /N device... search for free device
openex          rts

* Search for a free device
getnextdev      

          IFEQ      1
SetPortSig    
          cmpa      #SS.PortSig
          bne       SetPortRel
          lda       PD.CPR,y       current process ID
          ldb       R$X+1,x        LSB of [X] is signal code
          std       <PortSigPID
          clrb
          rts
SetPortRel 
          cmpa      #SS.PortRel
          bne       donebad
          leax      PortSigPID,u
          bsr       ReleaSig
          clrb
          rts
          ENDC
donebad	comb
		ldb       #E$UnkSVc
		rts
          
ReleaSig  pshs    cc             save IRQ enable status
          orcc    #IntMasks      disable IRQs while releasing signal
          lda     PD.CPR,y       get current process ID
          suba    ,x             same as signal process ID?
          bne     NoReleas       no, go return...
          sta     ,x             clear this signal's process ID
NoReleas  puls    cc,pc          restore IRQ enable status, return

		emod
eom		equ		*
		end
