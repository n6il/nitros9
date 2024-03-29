*******************************************************************
* VInit - DragonPlus virtual (ram) disk initialiser
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
	nam   	VINIT
        ttl   	program module       

* Disassembled 2005/05/31 16:27:58 by Disasm v1.5 (C) 1988 by RML

        ifp1
        use   	defsfile
	use	dplusdef
        endc
	
tylg    set   	Prgrm+Objct   
atrv    set   	ReEnt+rev
rev     set   	$01
        mod   	eom,name,tylg,atrv,start,size
u0000   rmb   	1
u0001   rmb   	102
size    equ   	.

name    equ   	*
        fcs   	/VINIT/
        fcb   	$01 
 
SignonMess   
	fcc	'VINIT (C) COPYRIGHT COMPUSENSE LIMITED 1985'
        fcb   	$0D 
SignonMessLen	equ	*-SignonMess

L003F	
	fcc	'VINIT - RAM disk formatted - 236 sectors free'
        fcb   	$0D 
         
	fcb   	$56 V
        fcb   	$B0 0
	 
L006F    
	fcc	'VINIT - already formatted - continue (Y/N)?  '

L009C    
	fcc	'VINIT - format canceled'
        fcb   	$0D 

L00B5   fcb   	$00 
        fcb   	$00 
        fcb   	$F0 p
        fcb  	$00 
        fcb   	$00 
        fcb   	$1E 
        fcb   	$00 
        fcb   	$01 
        fcb   	$00 
        fcb   	$00 
        fcb   	$02 
        fcb   	$00 
        fcb   	$00 
        fcb   	$FF 
        fcb   	$52 R
        fcb   	$44 D
        fcb   	$00 
        fcb   	$00 
        fcb   	$1E 
        fcb   	$00 
        fcb   	$00 
        fcb   	$00 
        fcb   	$00 
        fcb   	$00 
        fcb   	$00 
        fcb   	$00 

TimeBuff1   
	fcb   	$00	* year 
        fcb   	$00 	* Month
        fcb   	$00 	* Day
        fcb   	$00 	* Hour
        fcb   	$00 	* minute, second over-writes first byte of message

L00D4   fcc	'RAM DISK (C)COMPUSENSE LTD 1985'

L00F3   fcb   	$F0 p
        fcb   	$00 
        fcb   	$00 
        fcb   	$00 
        fcb   	$00 
        fcb   	$00 
        fcb   	$00 
        fcb   	$00 
        fcb   	$00 
        fcb   	$00 
        fcb   	$00 
        fcb   	$00 
        fcb   	$00 
        fcb   	$00 
        fcb   	$00 
        fcb   	$00 
        fcb   	$00 
        fcb   	$00 
        fcb   	$00 
        fcb   	$00 
        fcb   	$00 
        fcb   	$00 
        fcb   	$00 
        fcb   	$00 
        fcb   	$00 
        fcb   	$00 
        fcb   	$00 
        fcb   	$00 
        fcb   	$00 
        fcb   	$00 

L0111   fcb   $BF ?
        fcb   $00 
        fcb   $00 
	
TimeBuff2    
	fcb   	$00 	* Year
        fcb   	$00 	* Month
        fcb   	$00 	* Day
        fcb   	$00 	* hour
        fcb   	$00 	* minute
L0119   fcb   	$00 	* second (saved and restored in code).
        fcb   	$00 
        fcb   	$00 
        fcb   	$00 
        fcb   	$40 @
        fcb   	$00 
        fcb   	$00 
        fcb   	$00 
        fcb   	$00 
        fcb   	$00 
        fcb   	$03 
        fcb   	$00 
        fcb   	$01 
L0126   fcb   	$2E .
        fcb   	$AE .
        fcb   	$00 
        fcb   	$00 
        fcb   	$00 
        fcb   	$00 
        fcb   $00 
        fcb   $00 
        fcb   $00 
        fcb   $00 
        fcb   $00 
        fcb   $00 
        fcb   $00 
        fcb   $00 
        fcb   $00 
        fcb   $00 
        fcb   $00 
        fcb   $00 
        fcb   $00 
        fcb   $00 
        fcb   $00 
        fcb   $00 
        fcb   $00 
        fcb   $00 
        fcb   $00 
         fcb   $00 
         fcb   $00 
         fcb   $00 
         fcb   $00 
         fcb   $00 
         fcb   $00 
         fcb   $02 
         fcb   $AE .
         fcb   $00 
         fcb   $00 
         fcb   $00 
         fcb   $00 
         fcb   $00 
         fcb   $00 
         fcb   $00 
         fcb   $00 
         fcb   $00 
         fcb   $00 
         fcb   $00 
         fcb   $00 
         fcb   $00 
         fcb   $00 
         fcb   $00 
         fcb   $00 
         fcb   $00 
         fcb   $00 
         fcb   $00 
         fcb   $00 
         fcb   $00 
         fcb   $00 
         fcb   $00 
         fcb   $00 
         fcb   $00 
         fcb   $00 
         fcb   $00 
         fcb   $00 
         fcb   $00 
         fcb   $00 
         fcb   $02 

start   equ   	*

        stx   	u0001,u
        lbsr  	L02A7
        leax  	>SignonMess,pcr
        ldy   	#SignonMessLen
        lda   	#$01
        os9   	I$WritLn 
        lbcs  	L020F
        
	lda   	>L00D4,pcr	* Save last byte
        leax  	>TimeBuff1,pcr	* Point to buffer
        os9   	F$Time   	* Get time/date
        sta   	>L00D4,pcr	* restore last byte, ignore seconds

	lda   	>L0119,pcr	* Save last byte
        leax  	>TimeBuff2,pcr  * Point to buffer
        os9   	F$Time   	* Get time/date
        sta   	>L0119,pcr	* restore last byte, ignore seconds
        
	lda   	#Page1	
	ldx   	#$0200
        lbsr  	L0223
        
	pshs  	x,cc		* save regs
        orcc  	#$50		* disable inturrupts
        sta   	>MemoryPage	* switch pages
        lbsr  	L0212
        ldx   	#$0200
        leay  	>L00B5,pcr
        ldb   	#$3E
L01B5   lda   	,y+
        sta   	,x+
        decb  
        bne   	L01B5
        ldx   	#$0300
        leay  	>L00F3,pcr
        ldb   	#$1E
        lbsr  	L021D
L01C8   lda   	,y+
        sta   	,x+
        decb  
        bne   	L01C8
        ldx   	#$0400
        leay  	>L0111,pcr
        ldb   	#$15
        lbsr  	L0212

L01DB   lda   	,y+
        sta   	,x+
        decb  
        bne   	L01DB
        ldx   	#$0500
        leay  	>L0126,pcr
        ldb   	#$40
        lbsr  	L0212
L01EE   lda   	,y+
        sta   	,x+
        decb  
        bne   	L01EE
        clr   	>MemoryPage
        puls  	x,cc
        leax  	>L003F,pcr
        ldy   	#$002E
        lda   	#$01
        os9   	I$WritLn 
        
	lbcs  	L020F
        lbsr  	L02A7
        clrb  
L020F   os9   	F$Exit   

L0212   pshs  	u,y,x,b,a
        clrb  
L0215   clra  
L0216   stb   	,x+
        deca  
        bne   	L0216
        puls  	pc,u,y,x,b,a
	
L021D   pshs  	u,y,x,b,a
        ldb   	#$FF
        bra   	L0215

L0223   pshs  	u,y,x,a,cc
        orcc  	#$50
        sta   	>MemoryPage
        leau  	>L00D4,pcr
        ldb   	#$1F
        leax  	<$1F,x
L0233   lda   	,x+
        cmpa  	,u+
        bne   	L02A2
        decb  
        bne   	L0233
        clr   	>MemoryPage
L023F   puls  	u,y,x,a,cc
        pshs  	u,y,x,a,cc
        lbsr  	L02A7
        leax  	>L006F,pcr
        ldy   	#$002C
        lda   	#$01
        os9   	I$Write  
	
        lbcs  	L020F
        ldx   	u0001,u
        lda   	,x+
        cmpa  	#$0D
        beq   	L0274
        sta   	,u
        stx   	u0001,u
        leax  	-$01,x
        ldy   	#$0001
        lda   	#$01
        os9   	I$Write  
	
        lbcs  	L020F
        bra   	L0280
L0274   leax  	,u
        ldy   	#$0001
        clra  
        os9   	I$Read   
	
        bcs   	L020F
L0280   lda   	,u
        ora   	#$20
        cmpa  	#$79
        beq   	L029F
        cmpa  	#$6E
        bne   	L023F
        lbsr  	L02A7
        leax  	>L009C,pcr
        ldy   	#$0019
        lda   	#$01
        os9   	I$WritLn 
        
	lbra  	L020F
L029F   lbsr  	L02A7
L02A2   clr   	>MemoryPage
        puls  	pc,u,y,x,a,cc
	
L02A7   pshs  	a
        lda   	#$0D
        bsr   	L02AF
        puls  	pc,a
	
L02AF   pshs  	y,x,b,a
        leax  	,s
        ldy   	#$0001
        lda   	#$01
        os9   	I$WritLn 
        puls  	pc,y,x,b,a
	
        emod
eom     equ   *
        end
