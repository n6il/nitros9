********************************************************************
* DW3 - DriveWire 3 Low Level Subroutine Module
*
* $Id$
*
* Edt/Rev  YYYY/MM/DD  Modified by
* Comment
* ------------------------------------------------------------------
*   1      2008/01/26  Boisy G. Pitre
* Started as a segregated subroutine module.

         nam   DW3
         ttl   DriveWire 3 Low Level Subroutine Module

         ifp1
         use   defsfile
         use   dwdefs.d
         endc

tylg      set   Sbrtn+Objct   
atrv      set   ReEnt+rev
rev       set   $01

          mod   eom,name,tylg,atrv,start,0

* irq
IRQPckt   fcb     $00,$01,$0A     ;IRQ packet Flip(1),Mask(1),Priority(1) bytes
* Default time packet
DefTime   dtb

name      fcs   /dw3/

* DriveWire subroutine entry table
start     lbra   Init
          bra    Read
          nop
          lbra   Write

* Term
*
* Entry:
*    U  = address of device memory area
*
* Exit:
*    CC = carry set on error
*    B  = error code
*
Term
          clrb				clear Carry
          rts

* Read
*
*  ON ENTRY:
*    X = ADDRESS OF THE RECEIVE BUFFER
*    A = TIMEOUT VALUE (182 = APPROX ONE SECOND @ 0.89 MHz)
*
*  ON EXIT:
*    Y = DATA CHECKSUM
*    D = ACTUAL NUMBER OF BYTES RECEIVED
*    X AND U ARE PRESERVED
*    CC.CARRY IS SET IF A FRAMING ERROR WAS DETECTED
*
Read  
          use  dwread.asm
         
* Write
*
* Entry:
Write    
          use   dwwrite.asm

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
* Initialize the serial device
Init  
          clrb				clear Carry
          pshs  y,x,cc			then push CC on stack
          orcc  #IntMasks
          ldx   #PIA1Base		$FF20
          clr   1,x			clear CD
          lda   #%11111110
          sta   ,x
          lda   #%00110100
          sta   1,x
          lda   ,x

; allocate DW statics page
          pshs    u
          ldd     #$0100
          os9     F$SRqMem
          tfr     u,x
          puls    u
          lbcs    InitEx
          IFGT    Level-1
          stx     <D.DWStat
          ELSE
          stx     >D.DWStat
          ENDC
; clear out 256 byte page at X
          clrb
loop@     clr     ,x+
          decb
          bne     loop@

* install ISR
InstIRQ
          IFGT    Level-1
          ldx     <D.DWStat
          ELSE
          ldx     >D.DWStat
          ENDC
          leax    DW.VIRQPkt,x
          pshs    u
          tfr     x,u
          leax    Vi.Stat,x               ;fake VIRQ status register
          lda     #$80                    ;VIRQ flag clear, repeated VIRQs
          sta     ,x                              ;set it while we're here...
          tfr     x,d                             ;copy fake VIRQ status register address
          leax    IRQPckt,pcr             ;IRQ polling packet
          leay    IRQSvc,pcr      ;IRQ service entry
          os9     F$IRQ                   ;install
          puls    u
          bcs     InitEx                  ;exit with error
          ldd     #$0003                  ;lets try every 6 ticks (0.1 seconds) -- testing 3, gives better response in interactive things
          IFGT    Level-1
          ldx     <D.DWStat
          ELSE
          ldx     >D.DWStat
          ENDC
          leax    DW.VIRQPkt,x
          std     Vi.Rst,x                ; reset count
          tfr     x,y             ; move VIRQ software packet to Y
tryagain
          ldx     #$0001                  ; code to install new VIRQ
          os9     F$VIRQ                  ; install
          bcc     IRQok                   ; no error, continue
          cmpb    #E$UnkSvc
          bne     InitEx
; if we get an E$UnkSvc error, then clock has not been initialized, so do it here
          leax    DefTime,pcr
          os9     F$STime
          bra     tryagain        ; note: this has the slim potential of looping forever
IRQok
          IFGT    Level-1
          ldx     <D.DWStat
          ELSE
          ldx     >D.DWStat
          ENDC
; cheat: we know DW.StatTbl is at offset $00 from D.DWStat, do not bother with leax
          leax    DW.StatTbl,x
          tfr     u,d
          ldb     <V.PORT+1,u             ; get our port #
          sta     b,x                             ; store in table

InitEx
          puls  cc,x,y,pc


; ***********************************************************************
; Interrupt handler  - Much help from Darren Atkinson
			
IRQMulti3 anda    	#$0F		; mask first 4 bits, a is now port #+1
		  deca					; we pass +1 to use 0 for no data
          pshs    	a			; save port #
          cmpb		RxGrab,u	; compare room in buffer to server's byte
          bhs		IRQM06		; room left >= server's bytes, no problem
                    
          stb		RxGrab,u	; else replace with room left in our buffer

          ; also limit to end of buffer
IRQM06    ldd		RxBufEnd,u	; end addr of buffer
          subd	RxBufPut,u	; subtract current write pointer, result is # bytes left going forward in buff.

IRQM05	cmpb	RxGrab,u	; compare b (room left) to grab bytes  
          bhs		IRQM03		; branch if we have room for grab bytes
			
          stb		RxGrab,u	; else set grab to room left
			
          ; send multiread req
IRQM03	puls    a			; port # is on stack
          ldb		RxGrab,u

          pshs	u
                         
          ; setup DWsub command
          pshs	d			; (a port, b bytes)
          lda     #OP_SERREADM ; load command
          pshs   	a      		; command store on stack
          leax    ,s     		; point X to stack 
          ldy     #3          ; 3 bytes to send

          IFGT	Level-1
          ldu   	<D.DWSubAddr
          ELSE
          ldu   	>D.DWSubAddr
          ENDC
          jsr     6,u      	; call DWrite

          leas	3,s			; clean 3 DWsub args from stack 

          ldx		,s			; pointer to this port's area (from U prior), leave it on stack
          ldb		RxGrab,x	; set B to grab bytes
          clra				; 0 in high byte		
          tfr		d,y			; set # bytes for DW

          ldx		RxBufPut,x	; point X to insert position in this port's buffer
          ; receive response
          jsr     3,u    		; call DWRead
          ; handle errors?


          puls	u
          ldb		RxGrab,u	; our grab bytes

          ; set new RxBufPut
          ldx 	RxBufPut,u	; current write pointer
          abx					; add b (# bytes) to RxBufPut
          cmpx  	RxBufEnd,u 	; end of Rx buffer?
          blo   	IRQM04		; no, go keep laydown pointer
          ldx   	RxBufPtr,u 	; get Rx buffer start address
IRQM04   	stx   	RxBufPut,u 	; set new Rx data laydown pointer

          ; set new RxDatLen
          ldb		RxDatLen,u
          addb	RxGrab,u
          stb		RxDatLen,u	; store new value
          
          lbra     CkSuspnd    ; had to lbra
          
IRQMulti			
          ; initial grab bytes
          stb		RxGrab,u	
          
          ; limit server bytes to bufsize - datlen
          ldb		RxBufSiz,u	; size of buffer
          subb	RxDatLen,u	; current bytes in buffer
          bne		IRQMulti3	; continue, we have some space in buffer
          ; no room in buffer
          tstb
          lbne		CkSuspnd   ;had to lbra
          lbra		IRQExit    ;had to lbra
          

; **** IRQ ENTRY POINT
IRQSvc    equ		*
          pshs  	cc,dp 		; save system cc,DP
          orcc	#IntMasks	; mask interrupts

          ; mark VIRQ handled (note U is pointer to our VIRQ packet in DP)
          lda   	Vi.Stat,u	; VIRQ status register
          anda  	#^Vi.IFlag 	; clear flag in VIRQ status register
          sta   	Vi.Stat,u	; save it...

          ; poll server for incoming serial data

          ; send request
          lda     #OP_SERREAD ; load command
          pshs   	a      		; command store on stack
          leax    ,s     		; point X to stack 
          ldy     #1          ; 1 byte to send

          IFGT	Level-1
          ldu   	<D.DWSubAddr
          ELSE
          ldu   	>D.DWSubAddr
          ENDC
          jsr     6,u      	; call DWrite

          ; receive response
          leas	-1,s		; one more byte to fit response
          leax    ,s   		; point X to stack head
          ldy     #2    		; 2 bytes to retrieve
          jsr     3,u    		; call DWRead
          beq     IRQSvc2		; branch if no error
          leas    2,s     	; error, cleanup stack 2
          bra		IRQExit2	; don't reset error count on the way out

          ; process response	
IRQSvc2
          ldd     ,s++     	; pull returned status byte into A,data into B (set Z if zero, N if multiread)
          beq   	IRQExit  	; branch if D = 0 (nothing to do)
          						; future - handle backing off on polling interval

          	          						
; save back D on stack and build our U
          pshs    d
          * mode switch on bits 7+6 of A: 00 = vserial, 01 = system, 10 = wirebug?, 11 = ?							
		  anda		#$C0	; mask last 6 bits
		  beq		mode00	; virtual serial mode
          					; future - handle other modes
		  bra		IRQExit ; for now, bail
		  
mode00	  lda		,s		; restore A		  
          anda    #$0F		; mask first 4 bits, a is now port #+1
          beq	  IRQCont	; if we're here with 0 in the port, its not really a port # (can we jump straight to status?)
          deca				; we pass +1 to use 0 for no data
; here we set U to the static storage area of the device we are working with
          IFGT    Level-1
          ldx   	<D.DWStat
          ELSE
          ldx   	>D.DWStat
          ENDC
; cheat: we know DW.StatTbl is at offset $00 from D.DWStat, do not bother with leax
;			leax    DW.StatTbl,x
          lda     a,x
          bne		IRQCont		; if A is 0, then this device is not active, so exit
          puls    d
          bra     IRQExit
IRQCont
          clrb
          tfr     d,u

          lda     ,s     	; orig status byte into A

          * multiread/status flag is in bit 4 of A
          anda		#$10
          beq		IRQPutch	; branch if multiread not set
 
          * all 0s in port means status, anything else is multiread
          lda		,s		;get original A again
          anda    	#$0F	;mask bit 7-4
          puls		d
          beq		dostat	;port # all 0, this is a status response
          bra		IRQMulti ;its not all 0, this is a multiread

dostat		bra		IRQExit ; not implemented yet
          
; put byte B in port As buffer - optimization help from Darren Atkinson       
IRQPutCh  	puls		d		; get original A and B off the stack
			ldx     RxBufPut,u	; point X to the data buffer
        
; process interrupt/quit characters here
; note we will have to do this in the multiread (ugh)
          tfr		b,a			; put byte in A
          ldb		#S$Intrpt
          cmpa	V.INTR,u
          beq		send@
          ldb		#S$Abort
          cmpa	V.QUIT,u
          bne		store
send@	lda		V.LPRC,u
          beq     IRQExit
          os9		F$Send 
          bra		IRQExit

store
          ; store our data byte
          sta    	,x+     	; store and increment buffer pointer
   
          ; adjust RxBufPut	
          cmpx  	RxBufEnd,u 	; end of Rx buffer?
          blo   	IRQSkip1	; no, go keep laydown pointer
          ldx   	RxBufPtr,u 	; get Rx buffer start address
IRQSkip1  stx   	RxBufPut,u 	; set new Rx data laydown pointer

          ; increment RxDatLen
          inc		RxDatLen,u


          ; check if we have a process waiting for data	
CkSuspnd  lda   	<V.WAKE,u  	; V.WAKE?
          beq   	IRQExit   	; no
          clr 	<V.WAKE,u	; clear V.WAKE
          
          ; wake up waiter for read
          IFEQ  	Level-1
          ldb   	#S$Wake
          os9   	F$Send
          ELSE
          clrb
          tfr   	d,x         ; copy process descriptor pointer
          lda   	P$State,x   ; get state flags
          anda  	#^Suspend   ; clear suspend state
          sta   	P$State,x   ; save state flags
          ENDC

IRQExit
IRQExit2  puls  	cc,dp,pc	; restore interrupts cc,dp, return

         emod
eom      equ   *
         end
