*****************************************************
*
* Liber809 Boot ROM for the 6809-based Atari XL/XE
* Currently DriveWire based
*
* (C) 2012 Boisy G. Pitre
*

     use  atari.d
     use  drivewire.d
     
RAMDest      EQU  $4000			location of routine copied to RAM

	org  $F000

	

*******************************************************
* ROM CODE
*
* This code is run from ROM
*
* ENTRY POINT!
RESETVct
* mask interrupts, then prepare to copy routine into RAM
     	orcc	#$50
          clr  D.IRQENSHDW		DW routines use this low-mem global, so we clear it
          leax Target,pcr
          ldu  #RAMDest	
          ldy  #TargetL

* copy over the target routine from ROM into RAM
loop@
          lda  ,x+
          sta  ,u+
          leay -1,y
          bne  loop@
* this is our jumping off point into the RAM routine
          jmp  RAMDest
          

*******************************************************
* RAM CODE
*
* This code is copied to lower RAM and executed there.
*
Target
* setup the stack and the Atari hardware
     	lds	#$0100
          lbsr	ClearIO
     	lbsr SetupPIA
          lbsr	SetupPOKEY
          lbsr SetupSerial
          lbsr	SetupANTIC

* Put Atari into All RAM mode
          clr  $D40E
          clr  $D20E
          lda  #%11111110    $8000-$CFFF, $D800-$FFFF RAM!!!
          sta  PORTB
          IFNE  TEST_RAM_MODE
TESTADDR  equ  $5000
          ldx  #$0013
          stx  TESTADDR
          ldx  TESTADDR
          cmpx #$0013
          lbne green
          ENDC

          ldx  #$8000
          ldy  #$0000
ReadLoop
*          bsr  Wait
* Send Read Command
          cmpy #$0050
          bne  keepon
          leax $800,x
          leay 8,y            skip sectors $50-$57 ($D000-$D7FFF)
keepon
          pshs x,y
          pshs y
          ldd  #$0000
          pshs d
          lda  #OP_READEX
          pshs a
          leax ,s
          ldy  #$0005
          lbsr DWWrite
          leas 5,s

* Get Sector Data
          ldy  #$100
          ldx  ,s
          clra
          lbsr DWRead
          bcs  readerr
          
* Send CRC
          pshs y
          leax ,s
          ldy  #$0002
          lbsr DWWrite
          leas 2,s
          
* Get Error Code
          pshs a
          leax ,s
          ldy  #$0001
          clra
          lbsr DWRead          
          puls a,x,y
          bcs  readerr
          tsta
          bne  ReadLoop
          leax $100,x
          leay 1,y
          cmpx #$0000
          bne  ReadLoop
          ldx  -2,x

          jmp  [>$FFFE]

checkerr
* redo transfer
          leax -$100,x
          leay -1,y
          bra  ReadLoop
          
readerr

green     clra
gl@       inca
          sta  COLBK
          lbrn $0000
          cmpx ,s
          bra  gl@

SetupPIA
		  LDA	  #$38		  ;LOOK AT DATA DIRECTION REGISTERS IN PIA
		  STA	  PACTL
		  STA	  PBCTL
		  LDA	  #0			 ;MAKE ALL INPUTS
		  STA	  PORTA
		  LDA	  #$FF		 ;MAKE ALL OUTPUTS
		  STA	  PORTB
		  LDA	  #$3C		  ;BACK TO PORTS
		  STA	  PACTL
		  STA	  PBCTL
          rts
          
* clear the I/O space between $D000-$D3FFF
ClearIO
          clrb
loop
	     ldx		#$D000
     	clr		b,x
     	ldx		#$D200
     	clr		b,x
     	ldx		#$D300
     	clr		b,x
     	ldx		#$D400
     	clr		b,x
     	decb
     	bne		loop
     	rts


* setup POKEY here
SetupPOKEY
     	lda		#3
     	sta		$D20F		; set POKEY to active
     	rts


SetupSerial 
BAUD192K	EQU		$2800
BAUD384K	EQU		$1000
BAUD576K	EQU		$0800
BAUD1152K	EQU		$0400

          ldd		#BAUD576K 	get POKEY baud rate
          std		AUDF3		and store it in HW reg

          lda		#$23
          sta		SKCTL

          lda 		#$28	     clock ch. 3 with 1.79 MHz, ch. 4 with ch. 3
          sta		AUDCTL	set audio control
          rts
          
* setup ANTIC here
SetupANTIC
     	lda		#$46
     	sta		COLBK
     	rts



* DriveWire read/write routines for SIO are here
          use  dwread.asm
          
          use  dwwrite.asm
          
* Unused vectors routed here
SWI3Vct
SWI2Vct
FIRQVct
IRQVct
SWIVct
NMIVct
	rti

* End of our RAM-based routine
TargetL   equ  *-Target



* 6809 Vectors - these go at the very last 16 bytes of ROM
	fill	$FF,$FFF0-*
	fdb		$0000		Reserved
	fdb		SWI3Vct		SWI3
	fdb		SWI2Vct		SWI2
	fdb		FIRQVct		/FIRQ
	fdb		IRQVct		/IRQ
	fdb		SWIVct		SWI
	fdb		NMIVct		/NMI
	fdb		RESETVct	/RESET
