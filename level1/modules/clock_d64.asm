;
; Dragon 64 clock module, Disassembled Nov 2004, 
;	P.Harvey-Smith.
;

		nam   Clock
         ttl   os9 system module    

* Disassembled 1900/00/00 00:12:38 by Disasm v1.5 (C) 1988 by RML

         ifp1
		 use   defsfile
         endc
tylg     set   Systm+Objct   
atrv     set   ReEnt+rev
rev      set   $01
         mod   eom,name,tylg,atrv,start,size
u0000    rmb   0
size     equ   .
name     equ   *
         fcs   /Clock/
         fcb   $02 

L0013    fcb   	F$Time 
		 FDB	GetTimeHandler-*-2
;         fcb   $00 
;         fcb   $82 
         fcb   $80 	; Terminator
         fcb   $00 
		 
DaysInMonths
         fcb   $1F 
         fcb   $1C 
         fcb   $1F 
         fcb   $1E 
         fcb   $1F 
         fcb   $1E 
         fcb   $1F 
         fcb   $1F 
         fcb   $1E 
         fcb   $1F 
         fcb   $1E 
         fcb   $1F 
AltIRQ    
		CLRA
		TFR		A,DP
		DEC		<D.Tick
		BNE		ALTIRQExit
		LDD		<D.Min
		INCB	
		CMPB	#$3C	; 60 
		BCS		LabA
		INCA
		CMPA	#$3C	; 60 
		BCS		Labb
		LDD		<D.Day
		INCB
		CMPB	#$18	; 24 Hours
		BCS		LabD
		INCA
		LEAX	DaysInMonths,PCR
		LDB		<D.Month
		CMPB	#2		; Febuary ?
		BNE		NotLeap
		LDB		<D.Year	; Test for leap year
		BEQ		NotLeap
		ANDB	#$03
		BNE		NotLeap
		DECA
		
NotLeap	LDB		<D.Month
		CMPA	B,X		; Lookup number of days
		BLS		LabE
		LDD		<D.Year
		INCB			
		CMPB	#$0D	; End of year ?
		BCS	    LabF
		
		INCA			; Happy new year !
		LDB		#$1		; Back to January
		
LabF	STD		<D.Year

		LDA		#$01
LabE	CLRB		
LabD	STD		<D.Day
		CLRA
LabB	CLRB
LabA	STD		<D.Min
		LDA		<D.TSec
		STA		<D.Tick
AltIRQExit
		JMP		[D.Clock]
;		 fcb   $4F O
;         fcb   $1F 
;         fcb   $8B 
;         fcb   $0A 
;         fcb   $59 Y
;         fcb   $26 &
;         fcb   $46 F
;         fcb   $DC \
;         fcb   $57 W
;         fcb   $5C \
;         fcb   $C1 A
;         fcb   $3C <
;         fcb   $25 %
;         fcb   $39 9
;         fcb   $4C L
;         fcb   $81 
;         fcb   $3C <
;         fcb   $25 %
;         fcb   $33 3
;         fcb   $DC \
;         fcb   $55 U
;         fcb   $5C \
;         fcb   $C1 A
;         fcb   $18 
;         fcb   $25 %
;         fcb   $29 )
;         fcb   $4C L
;         fcb   $30 0
;         fcb   $8D 
;         fcb   $FF 
;         fcb   $D4 T
;         fcb   $D6 V
;         fcb   $54 T
;         fcb   $C1 A
;         fcb   $02 
;         fcb   $26 &
;         fcb   $09 
;         fcb   $D6 V
;         fcb   $53 S
;         fcb   $27 '
;         fcb   $05 
;         fcb   $C4 D
;         fcb   $03 
;         fcb   $26 &
;         fcb   $01 
;         fcb   $4A J
;         fcb   $D6 V
;         fcb   $54 T
;         fcb   $A1 !
;         fcb   $85 
;         fcb   $23 #
;         fcb   $0E 
;         fcb   $DC \
;         fcb   $53 S
;         fcb   $5C \
;         fcb   $C1 A
;         fcb   $0D 
;         fcb   $25 %
;         fcb   $03 
;         fcb   $4C L
;         fcb   $C6 F
;         fcb   $01 
;         fcb   $DD ]
;         fcb   $53 S
;         fcb   $86 
;         fcb   $01 
;         fcb   $5F _
;         fcb   $DD ]
;         fcb   $55 U
;         fcb   $4F O
;         fcb   $5F _
;         fcb   $DD ]
;         fcb   $57 W
;         fcb   $96 
;         fcb   $5A Z
;         fcb   $97 
;         fcb   $59 Y
;         fcb   $6E n
;         fcb   $9F 
;         fcb   $00 
;         fcb   $81 
start    equ   *
		pshs	x
		ldx		#$0666
		puls	x
         pshs  dp,cc
         clra  
         tfr   a,dp
         lda   #$32
         sta   <D.TSec		; Ticks/Second
         sta   <D.Tick
         lda   #$05
         sta   <D.TSlice	; Ticks/Timeslice
         sta   <D.Slice
         orcc  #$50
         leax  >AltIRQ,pcr
         stx   >D.AltIRQ
         leay  >L0013,pcr
         os9   F$SSvc   
         puls  pc,dp,cc

GetTimeHandler
         ldx   $04,u
         ldd   <D.Year
         std   ,x
         ldd   <D.Day
         std   $02,x
         ldd   <D.Min
         std   $04,x
         clrb  
         rts   

emod
eom      equ   *
         end
