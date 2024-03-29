********************************************************************
* VDisk - DragonPlus virtual (ram) disk driver
*
* $Id$
*
* Edt/Rev  YYYY/MM/DD  Modified by
* Comment
* ------------------------------------------------------------------
*   -      1986/??/??
* Original Compusense distribution version
*
* 2005-09-01, P.Harvey-Smith.
* 	Disassembled and cleaned up.
*

	nam   VDisk
         ttl   Virtual disk device driver for Dragon Plus.

* Disassembled 2005/05/31 16:27:51 by Disasm v1.5 (C) 1988 by RML

         ifp1
         use   defsfile
         endc
tylg     set   Drivr+Objct   
atrv     set   ReEnt+rev
rev      set   $02
         mod   eom,name,tylg,atrv,start,size
u0000    rmb   6
u0006    rmb   9
u000F    rmb   1
u0010    rmb   20
u0024    rmb   219
size     equ   .
         fcb   $FF 
name     equ   *
         fcs   /VDisk/
	 
L0013    fcb   $00 
L0014    fcb   $00 

SignonMess   
	fcc	'VDISK (C) COPYRIGHT COMPUSENSE LIMITED 1985 1986'
	fcb   	$0D 
SignonMessLen	equ	*-SignonMess
	
LoadAddrErrorMess		
	fcc	/CAN'T RUN BELOW $8000/
        fcb   	$0D 
LoadAddrErrorMessLen    equ	*-LoadAddrErrorMess

start
        lbra  	Init
        lbra  	Read
        lbra  	Write
        lbra  	GetStat
        lbra  	GetStat
	lbra  	Term

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

Init    lda   	#$01
        sta   	u0006,u
        lda   	#$FF
        sta   	<u0010,u
        sta   	<u0024,u
        inc   	>L0013,pcr
        lbsr  	L014A
	
        leax  	>SignonMess,pcr	* Point to signon message
        ldy   	#SignonMessLen	* and length
        lda   	#$01
        os9   	I$WritLn 	* display it
	
        leax  	>Read,pcr	* Get address of read routine
        cmpx  	#$8000		* are we loaded lower than $8000 ?
        bcc   	L00AE		* No, exit with no error
	
        leax  	>LoadAddrErrorMess,pcr	* Point to error message
        ldy   	#LoadAddrErrorMessLen		
        lda   	#$01
        os9   	I$WritLn 
        bcs   	Return		* Return error
        ldb   	#$01
        stb   	>L0014,pcr
        bra   	Return
L00AE   clrb  
Return  rts   


* Read
*
* Entry:
*    B  = MSB of the disk's LSN
*    X  = LSB of the disk's LSN
*    Y  = address of path descriptor
*    U  = address of device memory area
*
* Exit:
*    CC = carry set on error
*    B  = error code
*

Read    cmpx  	#$0000		* LSN 0 check
        pshs  	cc		* Save status of LSN0 on stack
        lbsr  	L012A
        bcs   	Return		
        puls  	cc		* Retrieve LSN0 check status
        bne   	L00D5		* Jump ahead if not LSN0
	
* Retrieve LSN0
	
        pshs  	y,x,b,a,cc
        orcc  	#$50		* Disable inturrupts
        sta   	>$FFE2		* Page in ramdisk memory
        leay  	u000F,u		* point to LSN buffer
        ldb   	#$15		* retrieve first $15 bytes
L00C9   lda   	,x+		* Transfer them
        sta   	,y+
        decb  			* Decrement counter
        bne   	L00C9		* If bytes left, loop again
        clr   	>$FFE2		* Page back to normal memory
        puls  	y,x,b,a,cc	* Restore and return
	
* Come straight here if we are not LSN0
	
L00D5   ldy   	PD.BUF,y	* Get address to the data into
        tst   	>L0014,pcr	* Test flag ????
        beq   	L00E2
	
        ldb   	#E$NotRdy	* Return not ready error
        bra   	Return
	
L00E2   pshs  	u,cc		
        leau  	,x		* Get address of data sector (in the ramdisk)
        orcc  	#$50		* disable inturrupts
        ldb   	#$80		* Transfer one sector, $80 words
ReadSectorLoop   
	sta   	>$FFE2		* Page in ramdisk memory
        ldx   	,u++		* Get a word from ramdisk
        clr   	>$FFE2		* Page in normal dragon memory
        stx   	,y++		* save in normal memory
        decb  			* decrement wordcount
        bne   	ReadSectorLoop	* Loop if all not done
        puls  	pc,u,cc		* Restore and return
	
Write   lbsr  	L012A
        bcs   	Return
	
        ldy   	PD.BUF,y	* Get the address of the buffer to write data from
        exg   	x,y
        tst   	>L0014,pcr	* Test flag
        beq   	L010D
	
        ldb   	#E$NotRdy	* Not ready error
        bra   	Return
	
L010D   pshs  	u,cc
        leau  	,x
        orcc  	#$50		* Disable inturrupts
        ldb   	#$80		* Transfer one sector, $80 words
WriteSecLoop   
	ldx   	,u++		* get word to write
        sta   	>$FFE2		* Page in ramdisk memory
        stx   	,y++		* Write word to ramdisk
        clr   	>$FFE2		* Page in normal dragon memory
        decb  			* decrement wordcount
        bne   	WriteSecLoop	* Loop if all not done
        puls  	pc,u,cc		* restore and return

GetStat ldb   	#E$UnkSvc	* Return unknown service error on Get/Set stat		
        rts   
	
Term    ldb   	#$F1		* Bad sector number ?????
        rts   
	
* does some calculations based on LSN
	
L012A   tstb  			* LSN > $FFFF ?
        bne   	Term		* Yes : error
	
        cmpx  	#$00F0		* LSN > $00F0 ?
        bcc   	Term		* Yes : Error
        
	lda   	#$02		
        cmpx  	#$0078		* LSN > $78 ?
        bcs   	L013E		* no : jump ahead	
        lda   	#$06		* Yes fixup for upper 32K 
        leax  	<-$78,x
	
L013E   exg   	d,x
        clra  
        exg   	a,b
        addd  	#$0200
        exg   	d,x
        clrb  
        rts   
	 
L014A   pshs  	a
        lda   	#$0D
        bsr   	L0152
        puls  	pc,a
	
L0152   pshs  	y,x,b,a
        leax  	,s
        ldy   	#$0001
        lda   	#$01
        os9   	I$WritLn 
        puls  	pc,y,x,b,a
	
        emod
eom     equ   *
        end
