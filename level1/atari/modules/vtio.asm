********************************************************************
* VTIO - NitrOS-9 Level 1 Video Terminal I/O driver for Atari XE/XL
*
* $Id$
*
* Edt/Rev  YYYY/MM/DD  Modified by
* Comment
* ------------------------------------------------------------------
*  1       2012/02/20  Boisy G. Pitre
* Started from VTIO for the CoCo
                         
         nam   VTIO      
         ttl   OS-9 Level One V2 CoCo I/O driver
                         
         ifp1            
         use   defsfile  
         use   scfdefs   
         use   atarivtio.d
         endc            
                         
tylg     set   Drivr+Objct
atrv     set   ReEnt+rev 
rev      set   $00
edition  set   1
                         
         mod   eom,name,tylg,atrv,start,size
                         
size     equ   V.Last    
                         
         fcb   UPDAT.+EXEC.
                         
name     fcs   /VTIO/    
         fcb   edition   
                         
start    lbra  Init      
         lbra  Read      
         lbra  Write     
         lbra  GetStat   
         lbra  SetStat   
         lbra  Term      
                         


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
Init      
		stu		>D.KbdSta  store devmem ptr
		pshs	u

* setup static vars
		clra
		clrb
		std	V.CurRow,u

* Screen memory starts at $0500
* Clear with As
          ldy  #ScrStart+Cols*Rows
          pshs y
          ldy  #ScrStart
          ldd  #$0000
clearLoop@
     	std	,y++
     	cmpy	,s
     	bne	clearLoop@
     	puls	y
* tell the ANTIC where the dlist is
		ldd	#$00FF		byte swapped (address is $FF00, currently in krn)
		std	DLISTL

* tell the ANTIC where the character set is (page aligned, currently in krn)		
		lda	#$F8
		sta	CHBASE
		
* set background color
		lda	#$00
 		sta	COLBK

* set text color
		lda	#$0F
 		sta	COLPF0
 		sta	COLPF1
 		sta	COLPF3
		lda	#$94
 		sta	COLPF2
 		
* tell ANTIC to start DMA
		lda	#$22
 		sta	DMACTL

* tell ANTIC to enable characters
		lda	#$02
 		sta	CHACTL

* install keyboard ISR
		leay	IRQSvc,pcr
		leax	IRQPkt,pcr
		ldu	,s
		os9	F$IRQ
		bcs	initex
		
* tell POKEY to enale keyboard scanning
		sta	SKCTL

		clrb
initex	puls	u,pc
  
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
		clrb
		rts
                         
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
Read          
         leax  V.InBuf,u  point X to input buffer
         ldb   V.IBufT,u  get tail pointer
         orcc  #IRQMask   mask IRQ
         cmpb  V.IBufH,u  same as head pointer
         beq   Put2Bed    if so, buffer is empty, branch to sleep
         abx              X now points to curr char
         lda   ,x         get char
         bsr   cktail     check for tail wrap
         stb   V.IBufT,u  store updated tail
         andcc  #^(IRQMask+Carry) unmask IRQ
         rts             
                         
Put2Bed  lda   V.BUSY,u   get calling process ID
         sta   V.WAKE,u   store in V.WAKE
         andcc  #^IRQMask  clear interrupts
         ldx   #$0000    
         os9   F$Sleep    sleep forever
         clr   V.WAKE,u   clear wake
         ldx   <D.Proc    get pointer to current proc desc
         ldb   <P$Signal,x get signal recvd
         beq   Read       branch if no signal
         cmpb  #S$Window  window signal?
         bcc   Read       branch if so
         coma            
         rts             
* Check if we need to wrap around tail pointer to zero
cktail   incb             increment pointer
         cmpb  #$7F       at end?
         bls   readex     branch if not
         clrb             else clear pointer (wrap to head)
readex   rts                                      

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
Write
		cmpa		#C$CR
		bne		checklf
		lda		V.CurRow,u
		ldb		#Cols
		mul
		addb		V.CurCol,u
		adca		#0
		ldx		#ScrStart
		leax		d,x
		lda		#C$SPAC-$20
		sta		,x
		clr		V.CurCol,u
		clrb
		rts
		
checklf	cmpa		#C$LF
		bne		wchar
		ldd		V.CurRow,u
		bra		incrow
wchar		
		suba		#$20
		pshs		a
		lda		V.CurRow,u
		ldb		#Cols
		mul
		addb		V.CurCol,u
		adca		#0
		ldx		#ScrStart
		leax		d,x
		puls		a
		sta		,x
		ldd		V.CurRow,u
		incb
		cmpb		#Cols
		blt		ok
		clrb
incrow
		inca
		cmpa		#Rows
		blt		clrrow
SCROLL	equ		1
		IFNE		SCROLL
		deca						set A to Rows - 1
		pshs		d				save off Row/Col
		ldx		#ScrStart			get start of screen memory
		ldy		#Cols*(Rows-1)		set Y to size of screen minus last row
scroll_loop
		ldd		Cols,x			get two bytes on next row
		std		,x++				store on this row
		leay		-2,y				decrement Y
		bne		scroll_loop		branch if not 0
		puls		d				recover Row/Col
		ELSE
		clra
		ENDC
* clear last row
clrrow	std		V.CurRow,u
		ldb		#Cols
		mul
		ldx		#ScrStart
		leax		d,x
		lda		#Cols
clrloop@	clr		,x+
		deca
		bne		clrloop@
		bra		okex
ok		std		V.CurRow,u

		ldb		#Cols
		mul
		addb		V.CurCol,u
		adca		#0
		ldx		#ScrStart
		leax		d,x
		lda		#$80
		sta		,x
		
okex		clrb
		rts             
                         
* GetStat
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
		cmpa		#SS.ScSiz
		bne		gserr
		ldx		PD.RGS,y
		ldd		#Cols
		std		R$X,x
		ldd		#Rows
		std		R$Y,x
		clrb
		rts
gserr
		comb
		ldb		#E$UnkSvc            
		rts             
                                                 
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
		clrb
		rts             

	
IRQPkt	equ	*
Pkt.Flip	fcb	$80		flip byte
Pkt.Mask 	fcb	$81		mask byte
		fcb 	$0A		priority
	
*
* IRQ routine for keyboard
*
IRQSvc                   
		ldb	KBCODE
		leax	ATASCI,pcr
		lda	b,x
		ldb	V.IBufH,u  get head pointer in B
		leax	V.InBuf,u  point X to input buffer
		abx              X now holds address of head
		lbsr	cktail      check for tail wrap
		cmpb	V.IBufT,u  B at tail?
		beq	L012F      branch if so
		stb	V.IBufH,u 
L012F	sta	,x         store our char at ,X
		beq	WakeIt     if nul, do wake-up
		cmpa	V.PCHR,u   pause character?
		bne	L013F      branch if not
		ldx	V.DEV2,u   else get dev2 statics
		beq	WakeIt     branch if none
		sta	V.PAUS,x   else set pause request
		bra	WakeIt    
L013F	ldb	#S$Intrpt  get interrupt signal
		cmpa	V.INTR,u   our char same as intr?
		beq	L014B      branch if same
		ldb	#S$Abort   get abort signal
		cmpa	V.QUIT,u   our char same as QUIT?
		bne	WakeIt     branch if not
L014B	lda	V.LPRC,u   get ID of last process to get this device
		bra	L0153      go for it
WakeIt	ldb	#S$Wake    get wake signal
		lda	V.WAKE,u   get process to wake
L0153	beq	L0158      branch if none
		os9	F$Send     else send wakeup signal
L0158	clr	V.WAKE,u   clear process to wake flag
		rts
		
ATASCI	fcb	$6C,$6A,$3B,$80,$80,$6B,$2B,$2A ;LOWER CASE
		fcb	$6F,$80,$70,$75,$9B,$69,$2D,$3D

		fcb	$76,$80,$63,$80,$80,$62,$78,$7A
		fcb	$34,$80,$33,$36,$1B,$35,$32,$31

		fcb	$2C,$20,$2E,$6E,$80,$6D,$2F,$81
		fcb	$72,$80,$65,$79,$7F,$74,$77,$71

		fcb	$39,$80,$30,$37,$7E,$38,$3C,$3E
		fcb	$66,$68,$64,$80,$82,$67,$73,$61


		fcb	$4C,$4A,$3A,$80,$80,$4B,$5C,$5E ;UPPER CASE
		fcb	$4F,$80,$50,$55,$9B,$49,$5F,$7C

		fcb	$56,$80,$43,$80,$80,$42,$58,$5A
		fcb	$24,$80,$23,$26,$1B,$25,$22,$21

		fcb	$5B,$20,$5D,$4E,$80,$4D,$3F,$81
		fcb	$52,$80,$45,$59,$9F,$54,$57,$51

		fcb	$28,$80,$29,$27,$9C,$40,$7D,$9D
		fcb	$46,$48,$44,$80,$83,$47,$53,$41


		fcb	$0C,$0A,$7B,$80,$80,$0B,$1E,$1F ;CONTROL
		fcb	$0F,$80,$10,$15,$9B,$09,$1C,$1D

		fcb	$16,$80,$03,$80,$80,$02,$18,$1A
		fcb	$80,$80,$85,$80,$1B,$80,$FD,$80

		fcb	$00,$20,$60,$0E,$80,$0D,$80,$81
		fcb	$12,$80,$05,$19,$9E,$14,$17,$11

		fcb	$80,$80,$80,$80,$FE,$80,$7D,$FF
		fcb	$06,$08,$04,$80,$84,$07,$13,$01
        
		emod            
eom		equ	*
		end             
