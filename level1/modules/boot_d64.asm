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
		nam   Boot
         ttl   os9 system module    

* Disassembled 1900/00/00 00:05:56 by Disasm v1.5 (C) 1988 by RML

         ifp1
		 use 	defsfile
         endc

		IFNE	DragonAlpha

* Dragon Alpha has a third PIA at FF24, this is used for
* Drive select / motor control, and provides FIRQ from the
* disk controler.

DPPIADA		EQU		DPPIA2DA
DPPIACRA	EQU		DPPIA2CRA		
DPPIADB		EQU		DPPIA2DB		
DPPIACRB	EQU		DPPIA2CRB

PIADA		EQU		DPPIADA+IO	; Side A Data/DDR
PIACRA		EQU		DPPIACRA+IO	; Side A Control.
PIADB		EQU		DPPIADB+IO	; Side A Data/DDR
PIACRB		EQU		DPPIACRB+IO	; Side A Control.

;WD2797 Floppy disk controler, used in Alpha Note registers in reverse order !
DPCMDREG	EQU		DPCmdRegA		; command/status			
DPTRKREG	EQU		DPTrkRegA		; Track register
DPSECREG	EQU		DPSecRegA		; Sector register
DPDATAREG	EQU		DPDataRegA		; Data register

CMDREG		EQU		DPCMDREG+IO	; command/status			
TRKREG		EQU		DPTRKREG+IO	; Track register
SECREG		EQU		DPSECREG+IO	; Sector register
DATAREG		EQU		DPDATAREG+IO	; Data register


		ELSE
		
DPPIADA		EQU		DPPIA1DA
DPPIACRA	EQU		DPPIA1CRA		
DPPIADB		EQU		DPPIA1DB		
DPPIACRB	EQU		DPPIA1CRB

PIADA		EQU		DPPIADA+IO	; Side A Data/DDR
PIACRA		EQU		DPPIACRA+IO	; Side A Control.
PIADB		EQU		DPPIADB+IO	; Side A Data/DDR
PIACRB		EQU		DPPIACRB+IO	; Side A Control.

;WD2797 Floppy disk controler, used in DragonDos.
DPCMDREG	EQU		DPCmdRegD		; command/status			
DPTRKREG	EQU		DPTrkRegD		; Track register
DPSECREG	EQU		DPSecRegD		; Sector register
DPDATAREG	EQU		DPDataRegD		; Data register

CMDREG		EQU		DPCMDREG+IO	; command/status			
TRKREG		EQU		DPTRKREG+IO	; Track register
SECREG		EQU		DPSECREG+IO	; Sector register
DATAREG		EQU		DPDATAREG+IO	; Data register

		ENDC

tylg     set   Systm+Objct   
atrv     set   ReEnt+rev
rev      set   $01
         mod   eom,name,tylg,atrv,start,size
u0000    rmb   2
u0002    rmb   1
u0003    rmb   1
u0004    rmb   1
NMIFlag	 rmb   1
size     equ   .
name     equ   *
         fcs   /Boot/
         fcb   $00 



start    equ   *
		 ldx	#CMdReg
         clra  
		 IFNE	DragonAlpha
		 clr	NMIFlag,u
		 ENDC
 		 ldb   #size
L0015    pshs  a
         decb  
         bne   L0015

         tfr   s,u
         ldx   #CMDREG
         lda   #$D0
         sta   ,x
         lbsr  L0175
         lda   ,x
         lda   >piadb
         lda   #$FF
         sta   u0004,u
         leax  >NMIService,pcr
         stx   >$010A
         lda   #$7E
         sta   >$0109
         lda   #$04
		
		 IFNE	DragonAlpha
		 lbsr	AlphaDskCtl
		 ELSE
		 sta   >DSKCTL
		 ENDC
		 
         ldd   #$C350
L0043    nop   
         nop   
         subd  #$0001
         bne   L0043
         pshs  u,x,b,a
         clra  
         clrb  
         ldy   #$0001
         ldx   <D.FMBM	
         ldu   <D.FMBM+2
         os9   F$SchBit 
         bcs   L009C
         exg   a,b
         ldu   $04,s
         std   u0002,u
         clrb  
         ldx   #$0000
         bsr   L00BA
         bcs   L009C
         ldd   <$18,y
         std   ,s
         os9   F$SRqMem 
         bcs   L009C
         stu   $02,s
         ldu   $04,s
         ldx   $02,s
         stx   u0002,u
         ldx   <$16,y
         ldd   <$18,y
         beq   L0095
L0083    pshs  x,b,a
         clrb  
         bsr   L00BA
         bcs   L009A
         puls  x,b,a
         inc   u0002,u
         leax  $01,x
         subd  #$0100
         bhi   L0083
L0095    clrb  
         puls  b,a
         bra   L009E
L009A    leas  $04,s
L009C    leas  $02,s
L009E    puls  u,x
         leas  Size,s
         rts   
L00A3    clr   ,u
         clr   u0004,u
         lda   #$05
L00A9    ldb   #$43
         pshs  a
         lbsr  L0160
         puls  a
         deca  
         bne   L00A9
         ldb   #$03
         lbra  L0160
L00BA    lda   #$91
         cmpx  #$0000
         bne   L00D2
         bsr   L00D2
         bcs   L00C9
         ldy   u0002,u
         clrb  
L00C9    rts   
L00CA    bcc   L00D2
         pshs  x,b,a
         bsr   L00A3
         puls  x,b,a
L00D2    pshs  x,b,a
         bsr   L00DD
         puls  x,b,a
         bcc   L00C9
         lsra  
         bne   L00CA
L00DD    bsr   L011E
         bcs   L00C9
         ldx   u0002,u
         orcc  #$50
         pshs  y,dp,cc
         lda   #$FF
         tfr   a,dp
         lda   #$34
         sta   <u0003
         lda   #$37
         sta   <dppiacrb
         lda   <dppiadb
         ldb   #$88
         stb   <dpcmdreg
         ldb   #$24
		  
		 IFNE	DragonAlpha
		 lbsr	AlphaDskCtlB
		 ELSE
		 stb   <dpdskctl
		 ENDIF
		 
L00FD    sync  
         lda   <dpdatareg
         ldb   <dppiadb
         sta   ,x+
         bra   L00FD

NMIService
		IFNE	DragonAlpha
		pshs	cc
		tst		NMIFlag,u
		bne		DoNMI
		puls	cc
		RTI
		
DoNMI	puls	cc
		ENDC
		
L0106    leas  $0C,s
         lda   #$04

		 IFNE	DragonAlpha
		 bsr	AlphaDskCtl
		 ELSE
		 sta    <dpdskctl
		 ENDIF

		 lda   #$34
         sta   <dppiacrb
         ldb   <dpcmdreg
         puls  y,dp,cc
         bitb  #$04
         lbeq  L015A
L011A    comb  
         ldb   #$F4
         rts   
L011E    clr   ,u
         tfr   x,d
         cmpd  #$0000
         beq   L0137
         clr   ,-s
         bra   L012E
L012C    inc   ,s
L012E    subd  #$0012
         bcc   L012C
         addb  #$12
         puls  a
L0137    incb  
         stb   >SECREG
         ldb   u0004,u
         stb   >TRKREG
         cmpa  u0004,u
         beq   L0158
         sta   u0004,u
         sta   >DATAREG
         ldb   #$13
         bsr   L0160
         pshs  x
         ldx   #$222E
L0152    leax  -$01,x
         bne   L0152
         puls  x
L0158    clrb  
         rts   
L015A    bitb  #$98
         bne   L011A
         clrb  
         rts   
L0160    bsr   L0173
L0162    ldb   >CMDREG
         bitb  #$01
         bne   L0162
         rts   
L016A    lda   #$04

		 IFNE	DragonAlpha
		 bsr	AlphaDskCtl
		 ELSE
		 sta   >DSKCTL
         ENDIF

         stb   >CMDREG
         rts   
L0173    bsr   L016A
L0175    lbsr  L0178
L0178    lbsr  L017B
L017B    rts   

		IFNE	DragonAlpha

; Translate DragonDos Drive select mechinisim to work on Alpha 
; Takes byte that would be output to $FF48, reformats it and 
; outputs to Alpha AY-8912's IO port, which is connected to 
; Drive selects, motor on and enable precomp.
; Also sets NMIFlag.

AlphaDskCtlB	
		pshs	A
		tfr		b,a
		bsr		AlphaDskCtl
		puls	A
		rts

AlphaDskCtl	
		PSHS	A,B,CC

		anda	#~DDenMask	; Dragon Alpha has DDen perminently enabled

		PSHS	A	
		ANDA	#NMIMask	; mak out nmi enable bit
		sta		NMIFlag,u	; Save it for later use
		
		lda		,s
		anda	#EnpMask	; Extract enp mask
		pshs	a			; save it
		
		lda		1,s
		ANDA	#DSMask		; Mask Out drive select bits
		
; Shift a bit in B left, a times, to convert drive number 
; to DS bit.
		
		ldb		#$01
ShiftNext
		cmpa	#$00		; Done all shifts ?
		beq		ShiftDone
		lslb
		deca
		bra		ShiftNext
		
ShiftDone
		lda		1,s
		anda	#MotorMask	; Extract motor bit
		cmpa	#MotorMask	; Motor on ?
		beq		MotorOn		; Yes leave it on.

		clrb				; No zero out DS bits

MotorOn
		ora		,s			; Recombine with ENP bit.
		leas	1,s			; drop off stack
		lsla
		lsla	
		pshs	b
		ora		,s
		leas	1,s
				
		pshs	a			; Save motor/drive select state
		ldb		PIADA		; get BDIR/BC1/Rom select
		andb	#$FC		; Mask out BCDIR/BC1, so we don't change other bits
		pshs	b			; save mask
		
		lda		#AYIOREG	; AY-8912 IO register
		sta		PIADB		; Output to PIA
		orb		#AYREGLatch	; Latch register to modify
		stb		PIADA
		
		clrb
		orb		,s			; Restore saved bits
		stb		PIADA		; Idle AY
		
		lda		1,s			; Fetch saved Drive Selects
		sta		PIADB		; output to PIA
		ldb		#AYWriteReg	; Write value to latched register
		orb		,s			; Restore saved bits
		stb		PIADA		; Set register
		
		clrb
		orb		,s			; Restore saved bits
		stb		PIADA		; Idle AY
		
		leas	3,s			; drop saved bytes
		
		PULS	A,B,CC
		RTS

		ENDC

         emod
eom      equ   *
         end
