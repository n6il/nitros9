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
		lda	#$01
 		sta	CHACTL
 		
		clrb
		puls	u,pc
  
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
		clrb
		rts             
                         

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
		cmpa		#24
		blt		clrrow
		clra
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

	
		emod            
eom		equ	*
		end             
