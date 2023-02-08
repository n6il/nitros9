********************************************************************
* VTIO - NitrOS-9 Video Terminal I/O driver for F256 Jr.
*
* $Id$
*
* Edt/Rev  YYYY/MM/DD  Modified by
* Comment
* ------------------------------------------------------------------
*  1       2012/02/20  Boisy G. Pitre
* Started from VTIO for the Atari XE/XL
                         
         nam   VTIO      
         ttl   NitrOS-9 Video Terminal I/O driver for F256 Jr.
                         
         ifp1            
         use   defsfile  
         use   f256jrvtio.d
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

		leax	ChkSpc,pcr
		stx	V.EscVect,u
		
* setup static vars
		clra
		clrb
		std	V.CurRow,u

* Clear screen memory
          ldy  #G.ScrEnd
          pshs y
          ldy  #G.ScrStart
          ldd  #$0000
clearLoop@
     	std	,y++
     	cmpy	,s
     	bne	clearLoop@
     	puls	u				G.DList address is aleady in U
     	
* clear carry and return
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
* clear carry and return
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
         cmpb  #KBufSz-1  at end?
         bls   readex     branch if not
* clear carry and return
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
		bsr		hidecursor		
		ldx		V.EscVect,u
		jsr		,x
		bra		drawcursor

ChkSpc    cmpa		#C$SPAC			space or greater?
		bcs		ChkESC			branch if not
		
wchar	suba		#$20
		pshs		a
		lda		V.CurRow,u
		ldb		#G.Cols
		mul
		addb		V.CurCol,u
		adca		#0
		ldx		#G.ScrStart
		leax		d,x
		puls		a
		sta		,x
		ldd		V.CurRow,u
		incb
		cmpb		#G.Cols
		blt		ok
		clrb
incrow
		inca
		cmpa		#G.Rows
		blt		clrline
SCROLL	EQU		1
		IFNE		SCROLL
		deca						set A to G.Rows - 1
		pshs		d				save off Row/Col
		ldx		#G.ScrStart		get start of screen memory
		ldy		#G.Cols*(G.Rows-1)	set Y to size of screen minus last row
scroll_loop
		ldd		G.Cols,x			get two bytes on next row
		std		,x++				store on this row
		leay		-2,y				decrement Y
		bne		scroll_loop		branch if not 0
		puls		d				recover Row/Col
		ELSE
		clra
		ENDC
* clear line
clrline	std		V.CurRow,u
		bsr		DelLine
		rts
ok		std		V.CurRow,u
ret		rts
		
* calculates the cursor location in screen memory
* Exit: X = address of cursor
*       All other regs preserved
calcloc
		pshs		d
		lda		V.CurRow,u
		ldb		#G.Cols
		mul
		addb		V.CurCol,u
		adca		#0
		ldx		#G.ScrStart
		leax		d,x
		puls		d,pc

drawcursor
		bsr		calcloc
		lda		,x
		sta		V.CurChr,u
		lda		#$80
		sta		,x
		rts

hidecursor
		pshs		a
		bsr		calcloc
		lda		V.CurChr,u
		sta		,x
		puls		a,pc

ChkESC
		cmpa	#$1B			ESC?
		lbeq	EscHandler
		cmpa  #$0D		$0D?
		bhi   ret			branch if higher than
		leax  <DCodeTbl,pcr	deal with screen codes
		lsla  			adjust for table entry size
		ldd   a,x		get address in D
		jmp   d,x		and jump to routine

* display functions dispatch table
DCodeTbl	fdb   NoOp-DCodeTbl			$00:no-op (null)
		fdb   CurHome-DCodeTbl		$01:HOME cursor
		fdb   CurXY-DCodeTbl		$02:CURSOR XY
		fdb   DelLine-DCodeTbl		$03:ERASE LINE
		fdb   ErEOLine-DCodeTbl		$04:CLEAR TO EOL
		fdb   Do05-DCodeTbl			$05:CURSOR ON/OFF
		fdb   CurRght-DCodeTbl		$005e  $06:CURSOR RIGHT
		fdb   NoOp-DCodeTbl			$07:no-op (bel:handled in VTIO)
		fdb   CurLeft-DCodeTbl		$08:CURSOR LEFT
		fdb   CurUp-DCodeTbl		$09:CURSOR UP
		fdb   CurDown-DCodeTbl		$0A:CURSOR DOWN
		fdb   ErEOScrn-DCodeTbl		$0B:ERASE TO EOS
		fdb   ClrScrn-DCodeTbl		$0C:CLEAR SCREEN
		fdb   Retrn-DCodeTbl		$0D:RETURN
         
DelLine
		lda		V.CurRow,u
		ldb		#G.Cols
		mul
		ldx		#G.ScrStart
		leax		d,x
		lda		#G.Cols
clrloop@	clr		,x+
		deca
		bne		clrloop@
		rts
		
ClrScrn
          clr       V.CurCol,u
          lda       #G.Rows-1
clrloop@
          sta       V.CurRow,u
          pshs      a
          bsr       DelLine
          puls      a
          deca
          bpl       clrloop@
          clr       V.CurCol,u
          rts
          
ErEOScrn
CurUp
NoOp
CurHome   clr       V.CurCol,u
          clr       V.CurRow,u
          rts
          
CurXY
ErEOLine
Do05
CurRght
		rts

CurLeft
		ldd		V.CurRow,u
		beq		leave
		decb
		bpl		erasechar
		ldb		#G.Cols-1
		deca
		bpl		erasechar
		clra
erasechar
		std		V.CurRow,u
		ldb		#G.Cols
		mul
		addb		V.CurCol,u
		adca		#0
		ldx		#G.ScrStart
		leax		d,x
		clr		1,x
leave	rts

CurDown
		ldd		V.CurRow,u
		lbra		incrow

Retrn
		clr		V.CurCol,u
		rts

EscHandler
		leax		EscHandler2,pcr
eschandlerout
		stx		V.EscVect,u
		rts

EscHandler2
		sta		V.EscCh1,u
		leax		EscHandler3,pcr
		bra		eschandlerout

EscHandler3
		ldb		V.EscCh1,u
		cmpb		#$32
		beq		DoFore
		cmpb		#$33
		beq		DoBack
		cmpb		#$34
		beq		DoBord
eschandler3out
		leax		ChkSpc,pcr
		bra		eschandlerout

DoFore
		bra		eschandler3out
DoBack
		bra		eschandler3out
DoBord
		bra		eschandler3out
		

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
		ldd		#G.Cols
		std		R$X,x
		ldd		#G.Rows
		std		R$Y,x
* clear carry and return
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
* clear carry and return
		clrb
		rts             

	
	
*
* IRQ routine for keyboard
*
IRQSvc
		rts
		
		emod            
eom		equ	*
		end             
