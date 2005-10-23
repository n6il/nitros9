*
* Boot_d64, bootfile for Dragon 64, Dragon Alpha/Professional.
* 
* First disasembly and porting 2004-11-07, P.Harvey-Smith.
*
* Dragon Alpha code, 2004-11-09, P.Harvey-Smith.
*	I am not sure of how to disable NMI on the Alpha, it is
*	simulated in software using the NMIFlag.
*
* See DDisk.asm for a fuller discription of how Dragon Alpha
* interface works.
*
* Double sided Disk code added 2004-11-25, P.Harvey-Smith.
*
* 2005-05-08, P.Harvey-Smith, added code to force 5/8 line low on
* Alpha so correct clock selected.
*
* 2005-06-16, P.Harvey-Smith.
*	Added NMI enable/disable code, as I know know how to enable/disable
*	NMI on the Alpha, having disasembled the Alpha's OS9's ddisk.
*
*
* 2005-10-22, P.Harvey-Smith.
* 	Removed unused user stack variable (u0000).
*


		nam   Boot
         ttl   os9 system module    

* Disassembled 1900/00/00 00:05:56 by Disasm v1.5 (C) 1988 by RML

         ifp1
		 use 	defsfile.dragon
         endc

		IFNE	DragonAlpha

* Dragon Alpha has a third PIA at FF24, this is used for
* Drive select / motor control, and provides FIRQ from the
* disk controler.

DPPIADA		EQU	DPPIA2DA
DPPIACRA	EQU	DPPIA2CRA		
DPPIADB		EQU	DPPIA2DB		
DPPIACRB	EQU	DPPIA2CRB

PIADA		EQU	DPPIADA+IO	; Side A Data/DDR
PIACRA		EQU	DPPIACRA+IO	; Side A Control.
PIADB		EQU	DPPIADB+IO	; Side A Data/DDR
PIACRB		EQU	DPPIACRB+IO	; Side A Control.

;WD2797 Floppy disk controler, used in Alpha Note registers in reverse order !
DPCMDREG	EQU	DPCmdRegA	; command/status			
DPTRKREG	EQU	DPTrkRegA	; Track register
DPSECREG	EQU	DPSecRegA	; Sector register
DPDATAREG	EQU	DPDataRegA	; Data register

CMDREG		EQU	DPCMDREG+IO	; command/status			
TRKREG		EQU	DPTRKREG+IO	; Track register
SECREG		EQU	DPSECREG+IO	; Sector register
DATAREG		EQU	DPDATAREG+IO	; Data register

; Disk IO bitmasks

NMIEn    	EQU	NMIEnA
WPCEn    	EQU   	WPCEnA
SDensEn  	EQU   	SDensEnA
MotorOn  	EQU   	MotorOnA 

		ELSE
		
DPPIADA		EQU	DPPIA1DA
DPPIACRA	EQU	DPPIA1CRA		
DPPIADB		EQU	DPPIA1DB		
DPPIACRB	EQU	DPPIA1CRB

PIADA		EQU	DPPIADA+IO	; Side A Data/DDR
PIACRA		EQU	DPPIACRA+IO	; Side A Control.
PIADB		EQU	DPPIADB+IO	; Side A Data/DDR
PIACRB		EQU	DPPIACRB+IO	; Side A Control.

;WD2797 Floppy disk controler, used in DragonDos.
DPCMDREG	EQU	DPCmdRegD	; command/status			
DPTRKREG	EQU	DPTrkRegD	; Track register
DPSECREG	EQU	DPSecRegD	; Sector register
DPDATAREG	EQU	DPDataRegD	; Data register

CMDREG		EQU	DPCMDREG+IO	; command/status			
TRKREG		EQU	DPTRKREG+IO	; Track register
SECREG		EQU	DPSECREG+IO	; Sector register
DATAREG		EQU	DPDATAREG+IO	; Data register

; Disk IO bitmasks

NMIEn    	EQU	NMIEnD
WPCEn    	EQU   	WPCEnD
SDensEn  	EQU   	SDensEnD
MotorOn  	EQU   	MotorOnD

		ENDC

StepRate	EQU	%00000011

tylg     	set   Systm+Objct   
atrv     	set   ReEnt+rev
rev      	set   $01

		mod   eom,name,tylg,atrv,start,size
BuffPtr    	rmb   2
SideSel    	rmb   1		; Side select mask
CurrentTrack	rmb   1		; Current track number
size     	equ   .

name     	equ   *
		fcs   /Boot/
		fcb   $00 



start   equ   	*
	
        clra  	 
	 
 	ldb   	#size
L0015   pshs  	a		; Clear size bytes on system stack
        decb  
        bne   	L0015

        tfr   	s,u		; Point u to data area on s stack.
		 
        ldx   	#CMDREG		; Force inturrupt
        lda   	#FrcInt
        sta   	,x
        lbsr  	Delay		; Wait for command to complete
        lda   	,x
        lda   	>piadb		; Clear DRQ from WD.

	IFNE	DragonAlpha
	lda	#NMICA2Dis	; Set PIA2 CA2 as output & disable NMI
	sta	PIA2CRA
	ENDC
 
        lda   	#$FF
        sta   	CurrentTrack,u
        leax  	>NMIService,pcr	; Setup NMI Handler.
        stx   	>D.XNMI+1	
        lda   	#$7E		; $7E=JMP
        sta   	>D.XNMI
		 
        lda   	#MotorOn	; Turn on motor
	IFNE	DragonAlpha
	lbsr	AlphaDskCtl
	ELSE
	sta   	>DSKCTL
	ENDC
		 
        ldd   	#$C350		; Delay while motors spin up
MotorOnDelay    
	nop   
        nop   
        subd  	#$0001
        bne   	MotorOnDelay
		 
        pshs  	u,x,b,a
        clra  
        clrb  
        ldy   	#$0001
        ldx   	<D.FMBM	
        ldu   	<D.FMBM+2
        os9   	F$SchBit 
        bcs   	L009C
	
        exg   	a,b		; Make bitmap into Memory pointer
        ldu   	$04,s
        std   	BuffPtr,u	; Save LSN0 pointer
        clrb  
		 
        ldx   	#$0000		; Read LSN0 from boot disk.
        bsr   	ReadSec
        bcs   	L009C		; Error : give up !
	
        ldd   	<DD.BSZ,y	; Get size of boot data from LSN0
        std   	,s
        os9   	F$SRqMem 	; Request memory
        bcs   	L009C		; Error : give up
	
        stu   	$02,s		; Save load memory pointer
        ldu   	$04,s		; Fetch temp mem pointer off stack
        ldx   	$02,s		; Fetch load memory pointer
        stx   	BuffPtr,u
        ldx   	<DD.BT+1,y	; Get LSN of start of boot
        ldd   	<DD.BSZ,y	; Get size of boot.
        beq   	L0095		; Zero size boot ?, yes : exit
;
; At this point X=start LSN of boot area, D=size of boot
; BuffPtr,u=address to load next sector, Y=pointer to LSN0
;

LoadBootLoop   
	pshs  	x,b,a
        clrb  			; We are only interested in the number of full blocks
        bsr   	ReadSec		; Read a sector of boot
        bcs   	L009A		; Error : exit
        puls  	x,b,a
	
        inc   	BuffPtr,u	; Increment MSB of buffpointer, point to next page to load into
        leax  	$01,x		; Increment sector number
        subd  	#$0100		; Decrement number of bytes left
        bhi   	LoadBootLoop	; Any bytes left to load ?, yes : loop again

L0095   clrb  
        puls  	b,a
        bra   	L009E
		 
L009A   leas  	$04,s
L009C   leas  	$02,s
L009E   puls  	u,x
        leas  	Size,s		; Drop stacked vars.
        rts   

;
; Reset disk heads to track 0
;
		
ResetTrack0   
        clr   	CurrentTrack,u	; Zero current track
        lda   	#$05
L00A9   ldb   	#StpICmnd+StepRate	; Step in
        pshs  	a
        lbsr  	CommandWaitReady
        puls  	a
        deca  
        bne   	L00A9
        ldb   	#RestCmnd	; Restore to track 0
        lbra  	CommandWaitReady

;
; Read a sector off disk.
;

ReadSec    
	lda   	#$91		; Retry count
        cmpx  	#$0000		; Reading LSN0 ?
        bne   	ReadDataWithRetry	; No, just read sector
        bsr   	ReadDataWithRetry	; Yes read sector
        bcs   	ReadDataExit		; And restore Y=LSN0 pointer
        ldy   	BuffPtr,u
        clrb  
ReadDataExit   
	rts   

ReadDataRetry    			
	bcc   	ReadDataWithRetry	; Retry data read if error
        pshs  	x,b,a		
        bsr   	ResetTrack0	; Recal drive
        puls  	x,b,a
		 
ReadDataWithRetry    
	pshs  	x,b,a
        bsr   	DoReadData	; Try reading data
        puls  	x,b,a
        bcc   	ReadDataExit	; No error, return to caller
        lsra  			; decrement retry count
        bne   	ReadDataRetry	; retry read on error
		 
DoReadData    
	bsr   	SeekTrack	; Seek to correct track
        bcs   	ReadDataExit	; Error : exit
        
	ldx   	BuffPtr,u	; Set X=Data load address
        orcc  	#$50		; Enable FIRQ=DRQ from WD
        pshs  	y,dp,cc
        lda   	#$FF		; Make DP=$FF, so access to WD regs faster
        tfr   	a,dp
        
	lda   	#$34
        sta   	<dppia0crb	; Disable out PIA0 IRQ <u0003
        
	lda   	#$37
        sta   	<dppiacrb	; Enable FIRQ
        lda   	<dppiadb	; Clear any pending FIRQ
	
        lda   	#NMIEn+MotorOn	; $24
		  
	IFNE	DragonAlpha
	lbsr	AlphaDskCtl
	ELSE
	sta   	<dpdskctl
	ENDIF

        ldb   	#ReadCmnd	; Issue a read command
        orb	>SideSel,U	; mask in side select
	stb   	<dpcmdreg

	IFNE	DragonAlpha
	lda	#NMICA2En	; Enable NMI
	sta	<DPPIA2CRA	
	ENDIF

;	lda	<dppiadb	; Inturrupt flag set ?
;	bmi	ReadDataNow	; already inturrupt, read data	
	
ReadDataWait    
	sync  			; Read data from controler, save
ReadDataNow
        lda   	<dpdatareg	; in memory at X
        ldb   	<dppiadb	
        sta   	,x+		
        bra   	ReadDataWait	; We break out with an NMI
;
; NMI service routine.
;

NMIService
		
	leas  	R$Size,s	; Drop saved Regs from stack
        lda   	#MotorOn

	IFNE	DragonAlpha
	lbsr	AlphaDskCtl
	lda	#NMICA2Dis	; Disable NMI
	sta	<DPPIA2CRA
	ELSE
	sta    	<dpdskctl
	ENDIF

	lda   	#$34		; Disable FIRQ inturrupt
        sta   	<dppiacrb
        ldb   	<dpcmdreg
        puls  	y,dp,cc
	
        bitb  	#$04		; Check for error
        lbeq  	L015A
L011A   comb  
        ldb   	#$F4
        rts   
		 
;
; Seek to a track, at this point Y still points to 
; in memory copy of LSN0 (if not reading LSN0 !).
;
		 
SeekTrack    
        tfr   	x,d
        cmpd  	#$0000		; LSN0 ?
        beq   	SeekCalcSkip
        clr   	,-s		; Zero track counter
        bra   	L012E
		
L012C   inc   	,s
L012E   subd  	DD.Spt,Y	; Take sectors per track from LSN
        bcc   	L012C		; still +ve ? keep looping
        addd  	DD.Spt,Y	; Compensate for over-loop
        puls  	a		; retrieve track count.

; At this point the A contains the track number, 
; and B contains the sector number on that track.

SeekCalcSkip   
	pshs	b		; Save sector number

        LDB   	DD.Fmt,Y     	; Is the media double sided ?
        LSRB
        BCC   	DiskSide0	; skip if not

	LSRA			; Get bit 0 into CC, and devide track by 2
	BCC	DiskSide0	; Even track no so it's on side 0
	ldb	#Sid2Sel	; Odd track so on side 1, flag it
	bra	SetSide
		
DiskSide0
	clrb
SetSide
	stb   	>SideSel,U	; Single sided, make sure sidesel set correctly
		
	puls	b		; Get sector number
	incb  
        stb   	>SECREG
        ldb   	CurrentTrack,u
        stb   	>TRKREG
        cmpa  	CurrentTrack,u
        beq   	L0158
        sta   	CurrentTrack,u
        sta   	>DATAREG
        ldb   	#SeekCmnd+3	; Seek command+ step rate code $13
        bsr   	CommandWaitReady
        pshs  	x
		
        ldx   	#$222E		; Wait for head to settle.
SettleWait   
	leax  	-$01,x
        bne   	SettleWait
		
        puls  	x
L0158   clrb  
        rts   
		 
L015A    bitb  #$98
         bne   L011A
         clrb  
         rts   
		 
CommandWaitReady   
	bsr   	MotorOnCmdBDelay	; Turn on motor and give command to WD
CommandWait   
	ldb   	>CMDREG		; Get command status
        bitb  	#$01		; finished ?
        bne   	CommandWait	; nope : continue waiting.
        rts   
		 
MotorOnCmdB    
	lda   	#MotorOn	; Turn on motor

	IFNE	DragonAlpha
	bsr	AlphaDskCtl
	ELSE
	sta   	>DSKCTL
        ENDIF

        stb	>CMDREG		; Give command from B
        rts   
		 
MotorOnCmdBDelay    
	bsr   	MotorOnCmdB
Delay   lbsr  	Delay2
Delay2  lbsr  	Delay3
Delay3  rts   

	IFNE	DragonAlpha

; Translate DragonDos Drive select mechinisim to work on Alpha 
; Takes byte that would be output to $FF48, reformats it and 
; outputs to Alpha AY-8912's IO port, which is connected to 
; Drive selects, motor on and enable precomp.
; This code now expects Alpha NMI/DDEN etc codes, as defined
; at top of this file (and dgndefs). The exception to this is
; the drive number is still passed in the bottom 2 bits and
; converted with a lookup table.
; We do not need to preserve the ROM select bit as this code
; operates in RAM only mode.

ADrvTab	FCB		Drive0A,Drive1A,Drive2A,Drive3A

AlphaDskCtl	
	PSHS	x,A,B,CC

;	ldb	PIA2CRA		; Get control reg 
;	bita	#NMIEnA		; NMI enable flag set ?
;	bne	AlphaNMIEnabled	; yes : enable it
	
;	andb	#PIANMIDisA	; Set PIA2 CA2 as output & disable NMI
;	ldb	#NMICA2Dis
;	bra	AlphaSetNMI
AlphaNMIEnabled
;	orb	#PIANMIEnA	; Enable NMI
;	ldb	#NMICA2En
	
AlphaSetNMI
;	stb	PIA2CRA		; Save back in ctrl reg
	
	PSHS	A	
	anda	#DDosDriveMask	; mask out dragondos format drive number
	leax	ADrvTab,pcr	; point at table
	lda	a,x		; get bitmap
	ldb	,s
	andb	#AlphaCtrlMask	; mask out drive number bits
	stb	,s
	ora	,s		; recombine drive no & ctrl bits
;	sta	,s

	bita	#MotorOn	; test motor on ?
	bne	MotorRunning

	clra			; No, turn off other bits.
MotorRunning
	anda	#Mask58		; Mask out 5/8 bit to force the use of 5.25" clock
	sta	,s	

        orcc  #$50		; disable inturrupts
	
	lda	#AYIOREG	; AY-8912 IO register
	sta	PIA2DB		; Output to PIA
	ldb	#AYREGLatch	; Latch register to modify
	stb	PIA2DA
		
	clr	PIA2DA		; Idle AY
		
	lda	,s+		; Fetch saved Drive Selects etc
	sta	PIA2DB		; output to PIA
	ldb	#AYWriteReg	; Write value to latched register
	stb	PIA2DA		; Set register

	clr	PIA2DA		; Idle AY
			
	PULS	x,A,B,CC
	RTS

	ENDC

         emod
eom      equ   *
         end
