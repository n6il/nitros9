********************************************************************
* CCIO - OS-9 Level One V2 CoCo I/O driver
*
* $Id$
*
* Edt/Rev  YYYY/MM/DD  Modified by
* Comment
* ------------------------------------------------------------------
*  12      ????/??/??  ???
* From Tandy OS-9 Level One VR 02.00.00.
*
*  12r1    2003/09/11  Rodney V. Hamilton
* Modified key table to include $7F, $1D, $1E and $1F codes.

         nam   CCIO
         ttl   OS-9 Level One V2 CoCo I/O driver

         ifp1
         use   defsfile
	 use   scfdefs
	 use   cciodefs
         endc

tylg     set   Drivr+Objct
atrv     set   ReEnt+rev
rev      set   $01
edition  set   12

         mod   eom,name,tylg,atrv,start,size

         rmb   V.SCF
u001D    rmb   7
u0024    rmb   1
u0025    rmb   1
u0026    rmb   2
u0028    rmb   1
u0029    rmb   4
ScreenX  rmb   1
ScreenY  rmb   1
u002F    rmb   1
u0030    rmb   1
u0031    rmb   1
u0032    rmb   1
u0033    rmb   2
u0035    rmb   2
u0037    rmb   9
u0040    rmb   2
u0042    rmb   2
u0044    rmb   1
u0045    rmb   2
u0047    rmb   1
u0048    rmb   1
u0049    rmb   2
u004B    rmb   5
u0050    rmb   1
u0051    rmb   1
WrChar   rmb   1
CoInUse  rmb   2
u0055    rmb   6
u005B    rmb   2
u005D    rmb   2
u005F    rmb   1
u0060    rmb   1
u0061    rmb   2
u0063    rmb   2
u0065    rmb   1
u0066    rmb   1
u0067    rmb   1
u0068    rmb   1
u0069    rmb   1
u006A    rmb   1
u006B    rmb   1
u006C    rmb   1
u006D    rmb   1
u006E    rmb   1
u006F    rmb   1
u0070    rmb   1
trulocas rmb   1
CoEnt    equ   .
GRFOEnt  rmb   6
IBufHead rmb   1
IBufTail rmb   1
u007A    rmb   128
size     equ   .

         fcb   UPDAT.+EXEC.

name     fcs   /CCIO/
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
Init     stu   >D.KbdSta		store devmem ptr
         clra				clear A
         leax  <V.SCF,u			point to memory after V.SCF
         ldb   #$5D			get counter
L002E    sta   ,x+			clear mem
         decb				decrement counter
         bne   L002E			continue if more
         coma				A = $FF
         comb				B = $FF
         stb   <VD.Caps,u
         std   <u005F,u
         std   <u0061,u
         lda   #60
         sta   <u0051,u
         leax  >AltIRQ,pcr		get IRQ routine ptr
         stx   >D.AltIRQ		store in AltIRQ
         leax  >SetDsply,pcr
         stx   <u005B,u
         leax  >L050F,pcr
         stx   <u005D,u
         ldd   <IT.PAR,y		get parity and baud
         lbra  L05CE			process them

* Term
*
* Entry:
*    U  = address of device memory area
*
* Exit:
*    CC = carry set on error
*    B  = error code
*
Term     pshs  cc
         orcc  #IRQMask		mask interrupts
         ldx   >D.Clock		get clock vector
         stx   >D.AltIRQ	and put back in AltIRQ
         puls  pc,cc

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
Read     leax  <VD.InBuf,u	point X to input buffer
         ldb   <VD.IBufT,u	get tail pointer
         orcc  #IRQMask		mask IRQ
         cmpb  <VD.IBufH,u	same as head pointer
         beq   Put2Bed		if so, buffer is empty, branch to sleep
         abx			X now points to curr char
         lda   ,x		get char
         bsr   L009D		check for tail wrap
         stb   <VD.IBufT,u	store updated tail
         andcc #^(IRQMask+Carry)	unmask IRQ
         rts

Put2Bed  lda   V.BUSY,u		get calling process ID
         sta   V.WAKE,u		store in V.WAKE
         andcc #^IRQMask	clear interrupts
         ldx   #$0000
         os9   F$Sleep		sleep forever
         clr   V.WAKE,u		clear wake
         ldx   <D.Proc		get pointer to current proc desc
         ldb   <P$Signal,x	get signal recvd
         beq   Read		branch if no signal
         cmpb  #S$Window	window signal?
         bcc   Read		branch if so
         coma
         rts
* Check if we need to wrap around tail pointer to zero
L009D    incb			increment pointer
         cmpb  #$7F		at end?
         bls   L00A3		branch if not
         clrb			else clear pointer (wrap to head)
L00A3    rts

*
* IRQ routine for keyboard
*
AltIRQ   ldu   >D.KbdSta	get keyboard static
         ldb   <VD.CFlg1,u	graphics screen currently being displayed?
         beq   L00B7		branch if not
         ldb   <VD.Alpha,u	alpha mode?
         beq   L00B7		branch if so
         lda   <u0030,u
         lbsr  SetDsply		set up display
L00B7    ldx   #PIA0Base	point to PIA base
         clra
         clrb
         std   <u006A,u		clear
         bsr   L00E8
         bne   L00CC
         clr   $02,x
         lda   ,x		get byte from PIA
         coma			complement
         anda  #$7F		strip off hi bit
         bne   L00F1		branch if any bit set
L00CC    clra
         clrb
         std   <u006E,u		clear
         coma			A = $FF
         tst   <u006D,u
         bne   L00DA
         sta   <u005F,u
L00DA    stb   <u006D,u
         comb  
         sta   <u0060,u
         std   <u0061,u
L00E4    jmp   [>D.Clock]	jump into clock module
L00E8    comb
         stb   $02,x
         ldb   ,x
         comb
         andb  #$03
         rts

L00F1    bsr   L015C
         bmi   L00CC
         clrb
         bsr   L00E8
         bne   L00CC
         cmpa  <u006F,u
         bne   L010E
         ldb   <u0051,u
         beq   L010A
         decb
L0105    stb   <u0051,u
         bra   L00E4
L010A    ldb   #$05
         bra   L011A
L010E    sta   <u006F,u
         ldb   #$05
         tst   <u006B,u
         bne   L0105
         ldb   #60
L011A    stb   <u0051,u
         ldb   <VD.IBufH,u	get head pointer in B
         leax  <VD.InBuf,u	point X to input buffer
         abx			X now holds address of head
         lbsr  L009D		check for tail wrap
         cmpb  <VD.IBufT,u	B at tail?
         beq   L012F		branch if so
         stb   <VD.IBufH,u
L012F    sta   ,x		store our char at ,X
         beq   WakeIt		if nul, do wake-up
         cmpa  V.PCHR,u		pause character?
         bne   L013F		branch if not
         ldx   V.DEV2,u		else get dev2 statics
         beq   WakeIt		branch if none
         sta   V.PAUS,x		else set pause request
         bra   WakeIt
L013F    ldb   #S$Intrpt	get interrupt signal
         cmpa  V.INTR,u		our char same as intr?
         beq   L014B		branch if same
         ldb   #S$Abort		get abort signal
         cmpa  V.QUIT,u		our char same as QUIT?
         bne   WakeIt		branch if not
L014B    lda   V.LPRC,u		get ID of last process to get this device
         bra   L0153		go for it
WakeIt   ldb   #S$Wake		get wake signal
         lda   V.WAKE,u		get process to wake
L0153    beq   L0158		branch if none
         os9   F$Send		else send wakeup signal
L0158    clr   V.WAKE,u		clear process to wake flag
         bra   L00E4		and move along

L015C    clra
         clrb
         std   <u0066,u
         std   <u0068,u
         coma
         comb
         std   <u0063,u
         sta   <u0065,u
         deca
         sta   $02,x
L016F    lda   ,x
         coma
         anda  #$7F
         beq   L0183
         ldb   #$FF
L0178    incb
         lsra
         bcc   L017F
         lbsr  L0221
L017F    cmpb  #$06
         bcs   L0178
L0183    inc   <u0068,u
         orcc  #Carry
         rol   $02,x
         bcs   L016F
         lbsr  L0289
         bmi   L020A
         cmpa  <u005F,u
         bne   L0199
         inc   <u006B,u
L0199    sta   <u005F,u
         beq   L01B9
         suba  #$1A
         bhi   L01B9
         adda  #$1A
         ldb   <u0067,u
         bne   L01E9
         adda  #$40
         ldb   <u0066,u
         eorb  <VD.Caps,u
         andb  #$01
         bne   L01E9
         adda  #$20
         bra   L01E9
L01B9    ldb   #$03
         mul
         lda   <u0066,u
         beq   L01C4
         incb
         bra   L01CB
L01C4    lda   <u0067,u
         beq   L01CB
         addb  #$02
L01CB    lda   <u006C,u
         beq   L01D4
         cmpb  #$11
         ble   L0208
L01D4    cmpb  #$4C
         blt   L01DD
         inc   <u0069,u
         subb  #$06
L01DD    pshs  x
         leax  >KeyTbl,pcr		point to keyboard table
         lda   b,x
         puls  x
         bmi   L01FD
L01E9    ldb   <u0069,u
         beq   L01FA
         cmpa  #$3F
         bls   L01F8
         cmpa  #$5B
         bcc   L01F8
         ora   #$20
L01F8    ora   #$80
L01FA    andcc #^Negative
         rts

L01FD    inc   <u006D,u
         ldb   <u006B,u
         bne   L0208
         com   <VD.Caps,u
L0208    orcc  #Negative
L020A    rts

L020B    pshs  b,a
         clrb
         orcc  #Carry
         inca
L0211    rolb
         deca
         bne   L0211
         bra   L0219
L0217    pshs  b,a
L0219    orb   <u006A,u
         stb   <u006A,u
         puls  pc,b,a
L0221    pshs  b,a
         cmpb  #$03
         bne   L0230
         lda   <u0068,u
         cmpa  #$03
         blt   L0230
         bsr   L020B
L0230    lslb
         lslb
         lslb
         addb  <u0068,u
         beq   L025D
         cmpb  #$33
         bne   L0243
         inc   <u0069,u
         ldb   #$04
         bra   L0219
L0243    cmpb  #$31
         beq   L024B
         cmpb  #$34
         bne   L0252
L024B    inc   <u0067,u
         ldb   #$02
         bra   L0219
L0252    cmpb  #$37
         bne   L0262
         com   <u0066,u
         ldb   #$01
         bra   L0219
L025D    ldb   #$04
         bsr   L0217
         clrb
L0262    pshs  x
         leax  <u0063,u
         bsr   L026D
         puls  x
         puls  pc,b,a
L026D    pshs  a
         lda   ,x
         bpl   L0279
         stb   ,x
         ldb   #$01
         puls  pc,a
L0279    lda   $01,x
         bpl   L0283
         stb   $01,x
         ldb   #$02
         puls  pc,a
L0283    stb   $02,x
         ldb   #$03
         puls  pc,a
L0289    pshs  y,x,b
         bsr   L02EE
         ldb   <u006E,u
         beq   L02C5
         leax  <u0060,u
         pshs  b
L0297    leay  <u0063,u
         ldb   #$03
         lda   ,x
         bmi   L02B6
L02A0    cmpa  ,y
         bne   L02AA
         clr   ,y
         com   ,y
         bra   L02B6
L02AA    leay  $01,y
         decb
         bne   L02A0
         lda   #$FF
         sta   ,x
         dec   <u006E,u
L02B6    leax  $01,x
         dec   ,s
         bne   L0297
         leas  $01,s
         ldb   <u006E,u
         beq   L02C5
         bsr   L0309
L02C5    leax  <u0063,u
         lda   #$03
L02CA    ldb   ,x+
         bpl   L02DE
         deca
         bne   L02CA
         ldb   <u006E,u
         beq   L02EA
         decb
         leax  <u0060,u
         lda   b,x
         bra   L02E8
L02DE    tfr   b,a
         leax  <u0060,u
         bsr   L026D
         stb   <u006E,u
L02E8    puls  pc,y,x,b
L02EA    orcc  #Negative
         puls  pc,y,x,b
L02EE    ldd   <u0066,u
         bne   L0301
         lda   #$03
         leax  <u0063,u
L02F8    ldb   ,x
         beq   L0302
         leax  $01,x
         deca
         bne   L02F8
L0301    rts
L0302    comb
         stb   ,x
         inc   <u0069,u
         rts
L0309    leax  <u0060,u
         bsr   L0314
         leax  $01,x
         bsr   L0314
         leax  -$01,x
L0314    lda   ,x
         bpl   L0320
         ldb   $01,x
         bmi   L0320
         sta   $01,x
         stb   ,x
L0320    rts

* Key Table
* 1st column = key (no modifier)
* 2nd column = SHIFT+key
* 3rd column = CTRL+key 
KeyTbl   fcb   $00,$40,$60	ALT @ `
         fcb   $0c,$1c,$13	UP
         fcb   $0a,$1a,$12	DOWN
         fcb   $08,$18,$10	LEFT
         fcb   $09,$19,$11	RIGHT
         fcb   $20,$20,$20	SPACEBAR
         fcb   $30,$30,$81	0 0 capslock
         fcb   $31,$21,$7c	1 ! |
         fcb   $32,$22,$00	2 " null
         fcb   $33,$23,$7e	3 # ~
         fcb   $34,$24,$1d	4 $ RS  (was null)
         fcb   $35,$25,$1e	5 % GS  (was null)
         fcb   $36,$26,$1f	6 & US  (was null)
         fcb   $37,$27,$5e	7 ' ^
         fcb   $38,$28,$5b	8 ( [
         fcb   $39,$29,$5d	9 ) ]
         fcb   $3a,$2a,$00	: * null
         fcb   $3b,$2b,$7f	; + del (was null)
         fcb   $2c,$3c,$7b	, < {
         fcb   $2d,$3d,$5f	- = _
         fcb   $2e,$3e,$7d	. > }
         fcb   $2f,$3f,$5c	/ ? \
         fcb   $0d,$0d,$0d	ENTER key
         fcb   $00,$00,$00	CLEAR key
         fcb   $05,$03,$1b	BREAK key
         fcb   $31,$33,$35	F1 key
         fcb   $32,$34,$36	F2 key

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
Write    ldb   <VD.NGChr,u	are we in the process of getting parameters?
         bne   PrmHandl		yes, go process
         sta   <VD.WrChr,u	save character to write
         cmpa  #C$SPAC		space or higher?
         bcc   GoCo		yes, normal write
         cmpa  #$1E		escape sequence $1E or $1F?
         bcc   Escape		yes, go process
         cmpa  #$0F		GFX codes?
         lbcc  GfxDispatch	branch if so
         cmpa  #C$BELL		bell?
         lbeq  Ding		if so, ring bell
* Here we call the CO-module to write the character
GoCo     lda   <VD.CurCo,u	get CO32/CO80 flag
CoWrite  ldb   #$03		we want to write
CallCO   leax  <CoEnt,u		get base pointer to CO-entries
         ldx   a,x		get pointer to CO32/CO80
         beq   NoIOMod		branch if no module
         lda   <VD.WrChr,u	get character to write
L039D    jmp   b,x		call i/o subroutine
NoIOMod  comb  
         ldb   #E$MNF
         rts 

* Parameter handler
PrmHandl cmpb  #$02		two parameters left?
         beq   L03B0		branch if so
         sta   <VD.NChar,u	else store in VD.NChar
         clr   <VD.NGChr,u	clear parameter counter
         jmp   [<VD.RTAdd,u]	jump to return address
L03B0    sta   <VD.NChr2,u	store in VD.NChr2
         dec   <VD.NGChr,u	decrement parameter counter
         clrb
         rts

Escape   beq   L03C5		if $1E, we conveniently ignore it
         leax  <COEscape,pcr	else it's $1F... set up to get next char
L03BD    ldb   #$01
L03BF    stx   <VD.RTAdd,u
         stb   <VD.NGChr,u
L03C5    clrb
         rts

COEscape ldb   #$03		write offset into CO-module
         lbra  JmpCO

* Show VDG or Graphics screen
* Entry: B = 0 for VDG, 1 for Graphics
SetDsply pshs  x,a
         stb   <VD.Alpha,u	save passed flag in B
         lda   >PIA1Base+2
         anda  #$07		mask out all but lower 3 bits
         ora   ,s+		OR in passed A
         tstb			display graphics?
         bne   L03DE		branch if so
         ora   <VD.CFlag,u
L03DE    sta   >PIA1Base+2
         sta   <u0030,u
         tstb			display graphics?
         bne   DoGfx		branch if so
* Set up VDG screen for text
DoVDG
         stb   >$FFC0
         stb   >$FFC2
         stb   >$FFC4
         lda   <VD.ScrnA,u		get pointer to alpha screen
         bra   L0401

* Set up VDG screen for graphics
DoGfx    stb   >$FFC0
         stb   >$FFC3
         stb   >$FFC5
         lda   <VD.CurBf,u		get pointer to graphics screen

L0401    ldb   #$07
         ldx   #$FFC6
         lsra
L0407    lsra
         bcs   L0410
         sta   ,x+
         leax  $01,x
         bra   L0414
L0410    leax  $01,x
         sta   ,x+
L0414    decb
         bne   L0407
         clrb
         puls  pc,x

GRFO     fcs   /GRFO/
CO32     fcs   /CO32/
CO80     fcs   /CO80/

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
GetStat  sta   <VD.WrChr,u
         cmpa  #SS.Ready
         bne   L0439
         lda   <VD.IBufT,u		get buff tail ptr
         suba  <VD.IBufH,u		Num of chars ready in A
         lbeq  NotReady			branch if empty
SSEOF    clrb	
         rts
L0439    cmpa  #SS.EOF
         beq   SSEOF
         ldx   PD.RGS,y
         cmpa  #SS.Joy
         beq   SSJOY
         cmpa  #SS.ScSiz
         beq   SSSCSIZ
         cmpa  #SS.KySns
         beq   SSKYSNS
         cmpa  #SS.DStat
         lbeq  SSDSTAT
         ldb   #$06		getstat entry into CO-module
         lbra  JmpCO

SSKYSNS  ldb   <u006A,u		get key sense info
         stb   R$A,x		put in caller's A
         clrb
         rts

SSSCSIZ  clra
         ldb   <VD.Col,u
         std   R$X,x
         ldb   <VD.Row,u
         std   R$Y,x
         clrb
         rts

* Get joytsick values
SSJOY    pshs  y,cc
         orcc  #IRQMask		mask interrupts
         lda   #$FF
         sta   >PIA0Base+2
         ldb   >PIA0Base
         ldy   R$X,x		get joystick number to poll
         bne   L0481
         andb  #$01
         bne   L0485
         bra   L0486
L0481    andb  #$02
         beq   L0486
L0485    clra
L0486    sta   R$A,x
         lda   >PIA0Base+3
         ora   #$08
         ldy   R$X,x
         bne   L0494
         anda  #$F7
L0494    sta   >PIA0Base+3
         lda   >PIA0Base+1
         anda  #$F7
         bsr   L04B3
         std   R$X,x
         lda   >PIA0Base+1
         ora   #$08
         bsr   L04B3
         pshs  b,a
         ldd   #$003F
         subd  ,s++
         std   R$Y,x
         clrb
         puls  pc,y,cc

L04B3    sta   >PIA0Base+1
         lda   #$7F
         ldb   #$40
         bra   L04C7
L04BC    lsrb
         cmpb  #$01
         bhi   L04C7
         lsra
         lsra
         tfr   a,b
         clra
         rts
L04C7    pshs  b
         sta   >PIA1Base
         tst   >PIA0Base
         bpl   L04D5
         adda  ,s+
         bra   L04BC
L04D5    suba  ,s+
         bra   L04BC

SSDSTAT  lbsr  L065B
         bcs   L050E
         ldd   <u0045,u
         bsr   L050F
         tfr   a,b
         andb  ,x
L04E7    bita  #$01
         bne   L04F6
         lsra
         lsrb
         tst   <u0024,u
         bmi   L04E7
         lsra
         lsrb
         bra   L04E7
L04F6    pshs  b
         ldb   <u004B,u
         andb  #$FC
         orb   ,s+
         ldx   $06,y
         stb   $01,x
         ldd   <u0045,u
         std   $06,x
         ldd   <VD.CurBf,u
         std   $04,x
         clrb
L050E    rts
L050F    pshs  y,b,a
         ldb   <u0024,u
         bpl   L0517
         lsra
L0517    lsra
         lsra
         pshs  a
         ldb   #$BF
         subb  $02,s
         lda   #$20
         mul
         addb  ,s+
         adca  #$00
         ldy   <VD.CurBf,u
         leay  d,y
         lda   ,s
         sty   ,s
         anda  <u0044,u
         ldx   <u0042,u
         lda   a,x
         puls  pc,y,x

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
SetStat  sta   <VD.WrChr,u		save function code
         ldx   PD.RGS,y			get caller's regs
         cmpa  #SS.ComSt
         lbeq  SSCOMST
         cmpa  #SS.AAGBf
         beq   SSAAGBF
         cmpa  #SS.SLGBf
         beq   SSSLGBF
         cmpa  #SS.KySns
         bne   CoGetStt
         ldd   R$X,x
         beq   L0558
         ldb   #$FF
L0558    stb   <u006C,u
L055B    clrb
L055C    rts

CoGetStt ldb   #$09			CO-module setstat
JmpCO    pshs  b
         lda   <VD.CurCo,u		get CO-module in use
         lbsr  CallCO
         puls  a
         bcc   L055B
         tst   <VD.GRFOE,u		GRFO linked?
         beq   L055C
         tfr   a,b
         clra				GRFO address offset in statics
         lbra  CallCO			call it

* Reserve an additional graphics buffer (up to 2)
SSAAGBF  ldb   <VD.Rdy,u	was initial buffer allocated with $0F?
         lbeq  NotReady		branch if not
         pshs  b		save buffer number
         leay  <VD.AGBuf,u	point to additional graphics buffers
         ldd   ,y		first entry empty?
         beq   L058E		branch if so
         leay  $02,y		else move to next entry
         inc   ,s		increment B on stack
         ldd   ,y		second entry empty?
         bne   L059E		if not, no room for more... error out
L058E    lbsr  GetMem		allocate graphics buffer memory
         bcs   L05A1		branch if error
         std   ,y		save new buffer pointer at ,Y
         std   R$X,x		and in caller's X
         puls  b		get buffer number off stack
         clra			clear hi byte of D
         std   R$Y,x		and put in caller's Y (buffer number)
         clrb			call is ok
         rts			and return
L059E    ldb   #E$BMode
         coma
L05A1    puls  pc,a

* Select a graphics buffer
SSSLGBF  ldb   <VD.Rdy,u	was initial buffer allocated with $0F?
         lbeq  NotReady		branch if not
         ldd   R$Y,x		else get buffer number from caller
         cmpd  #$0002		compare against high
         bhi   BadMode		branch if error
         leay  <VD.GBuff,u	point to base graphics buffer address
         lslb			multiply by 2
         ldd   b,y		get pointer
         beq   BadMode		branch if error
         std   <VD.CurBf,u	else save in current
         ldd   R$X,x		get select flag
         beq   L05C3		if zero, do nothing
         ldb   #$01		else set display flag
L05C3    stb   <VD.CFlg1,u	save display flag
         clrb
         rts
BadMode  comb
         ldb   #E$BMode
         rts

SSCOMST  ldd   R$Y,x		Get caller's Y
L05CE    bita  #$02		CO80?
         bne   GoCO80		branch if so
         ldb   #$10		assume true lower case TRUE
         bita  #$01		true lowercase bit set?
         bne   GoCO32		branch if so
         clrb			true lower case FALSE
GoCO32   stb   <VD.CFlag,u	save flag for later
         lda   #$02		CO32 is loaded bit
         ldx   #$2010		32x16
         pshs  u,y,x,a
         leax  >CO32,pcr
         bra   L05F4
GoCO80   lda   #$04		'CO80 is loaded' bit
         ldx   #$5018		80x24
         pshs  u,y,x,a
         leax  >CO80,pcr
L05F4    bsr   L0601		load CO-module if not already loaded
         puls  u,y,x,a
         bcs   L0600
         stx   <VD.Col,u	save screen size
         sta   <VD.CurCo,u	current module in use? ($02=CO32, $04=C080)
L0600    rts
L0601    bita  <u0070,u		module loaded?
         beq   L0608		branch if not
L0606    clrb			else clear carry
         rts			and return
L0608    pshs  y,x,a
         lbsr  LinkSub
         bcc   L061F		branch if link was successful
         ldx   $01,s		get pointer to name on stack
         pshs  u
         os9   F$Load		try to load subroutine I/O module
         puls  u
         bcc   L061F
         puls  y,x,a
         lbra  NoIOMod
L061F    leax  <CoEnt,u		get base pointer to CO-entries
         lda   ,s		get A off stack
         sty   a,x		save off CO32/CO80 entry point
         puls  y,x,a
         ldb   #$00		CO-module init offset
         lbra  CallCO		call it

* Link to subroutine
LinkSub  pshs  u
         lda   #Systm+Objct
         os9   F$Link
         puls  pc,u

L0637    fdb   $0055,$aaff

GfxDispatch
         cmpa  #$15		GRFO-handled code?
         bcc   GoGrfo		branch if so
         cmpa  #$0F		display graphics code?
         beq   Do0F		branch if so
         suba  #$10
         bsr   L065B		check if first gfx screen was alloc'ed
         bcs   L0663		if not, return with error
         leax  <gfxtbl,pcr	else point to jump table
         lsla			multiply by two
         ldd   a,x		get address of routine
         jmp   d,x		jump to it

* Jump table for graphics codes $10-$14
gfxtbl   fdb   Do10-gfxtbl	$10 - Preset Screen
         fdb   Do11-gfxtbl	$11 - Set Color
         fdb   Do12-gfxtbl	$12 - End Graphics
         fdb   Do13-gfxtbl	$13 - Erase Graphics
         fdb   Do14-gfxtbl	$14 - Home Graphics Cursor

L065B    ldb   <VD.Rdy,u		ready?
         bne   L0606
NotReady comb
         ldb   #E$NotRdy
L0663    rts

GoGrfo   bsr   L065B
         bcs   L0663
         ldx   <VD.GRFOE,u		get GRFO entry point
         bne   L0681			branch if not zero
         pshs  y,a			else preserve regs
         bne   L067F
         leax  >GRFO,pcr		get pointer to name string
         bsr   LinkSub			link to GRFO
         bcc   L067B			branch if ok
         puls  pc,y,a			else exit with error
L067B    sty   <VD.GRFOE,u		save module entry pointer
L067F    puls  y,a			restore regs
L0681    clra				A = GRFO address offset in statics
         lbra  CoWrite

* Allocate GFX mem -- we must allocate on a 512 byte page boundary
GetMem   pshs  u			save static pointer
         ldd   #6144+256		allocate graphics memory + 1 page
         os9   F$SRqMem			do it
         bcc   L0691			branch if ok
         puls  pc,u			else return with error
L0691    tfr   u,d			move mem ptr to D
         puls  u			restore statics
         tfr   a,b			move high 8 bits to lower
         bita  #$01			odd page?
         beq   L069F			branch if not
         adda  #$01
         bra   L06A1
L069F    addb  #$18
L06A1    pshs  u,a
         tfr   b,a
         clrb
         tfr   d,u
         ldd   #256
         os9   F$SRtMem			return page
         puls  u,a
         bcs   L06B3			branch if error
         clrb
L06B3    rts

* $0F - display graphics
Do0F     leax  <DispGfx,pcr
         ldb   #$02
         lbra  L03BF

DispGfx  ldb   <VD.Rdy,u		already allocated initial buffer?
         bne   L06D1			branch if so
         bsr   GetMem			else get graphics memory
         bcs   L06EF			branch if error
         std   <VD.CurBf,u		save memory
         std   <VD.GBuff,u		and GBuff
         inc   <VD.Rdy,u		ok, we're ready
         lbsr  EraseGfx			clear gfx mem
L06D1    lda   <VD.NChar,u
         sta   <u004B,u
         anda  #$03
         leax  >L0637,pcr
         lda   a,x
         sta   <u0047,u
         sta   <u0048,u
         lda   <VD.NChr2,u
         cmpa  #$01
         bls   L06F0
         comb
         ldb   #E$BMode
L06EF    rts

L06F0    tsta
         beq   L0710
         ldd   #$C003
         std   <u0049,u
         lda   #$01
         sta   <u0024,u
         lda   #$E0
         ldb   <VD.NChar,u
         andb  #$08
         beq   L0709
         lda   #$F0
L0709    ldb   #$03
         leax  <L0742,pcr
         bra   L072D
L0710    ldd   #$8001
         std   <u0049,u
         lda   #$FF
         tst   <u0047,u
         beq   L0723
         sta   <u0047,u
         sta   <u0048,u
L0723    sta   <u0024,u
         lda   #$F0
         ldb   #$07
         leax  <L0746,pcr
L072D    stb   <u0044,u
         stx   <u0042,u
         ldb   <VD.NChar,u
         andb  #$04
         lslb  
         pshs  b
         ora   ,s+
         ldb   #$01
         lbra  SetDsply

L0742    fcb   $c0,$30,$0c,$03
L0746    fcb   $80,$40,$20,$10,$08,$04,$02,$01

* $11 - Set Color
Do11     leax  <SetColor,pcr	set up return address
         lbra  L03BD

SetColor clr   <VD.NChr2,u
         lda   <u0024,u
         bmi   L075F
         inc   <VD.NChr2,u
L075F    lbra  L06D1

* End graphics
Do12     leax  <VD.GBuff,u	point to first buffer
         ldy   #$0000		Y = 0
         ldb   #$03		free 3 gfx screens max
         pshs  u,b
L076D    ldd   #6144		size of graphics screen
         ldu   ,x++		get address of graphics screen
         beq   L077A		branch if zero
         sty   -$02,x		else clear entry
         os9   F$SRtMem		and return memory
L077A    dec   ,s		decrement counter
         bgt   L076D		keep going if not end
         ldu   ,x		flood fill buffer?
         beq   L0788		branch if not allocated
         ldd   #512		else get size
         os9   F$SRtMem		and free memory
L0788    puls  u,b		restore regs
         clra
         sta   <VD.Rdy,u	gfx mem no longer alloced
         lbra  SetDsply

Do10     leax  <Preset,pcr	set up return address
         lbra  L03BD

Preset   lda   <VD.NChar,u
         tst   <u0024,u
         bpl   L07A7
         ldb   #$FF
         anda  #$01
         beq   EraseGfx
         bra   L07B2

L07A7    anda  #$03
         leax  >L0637,pcr
         ldb   a,x
         bra   L07B2

* Erase graphics screen
Do13
EraseGfx clrb				value to clear screen with
L07B2    ldx   <VD.CurBf,u
         leax  >6144+1,x		point to end of gfx mem + 1
L07B9    stb   ,-x			clear
         cmpx  <VD.CurBf,u		X = to start?
         bhi   L07B9			if not, continue
* Home Graphics cursor
Do14     clra
         clrb
         std   <u0045,u
         rts

*
* Ding - tickle CoCo's PIA to emit a sound
*
Ding     pshs  b,a
         lda   >PIA0Base+1
         ldb   >PIA0Base+3
         pshs  b,a
         anda  #$F7
         andb  #$F7
         sta   >PIA0Base+1
         stb   >PIA0Base+3
         lda   >PIA1Base+3
         pshs  a
         ora   #$08
         sta   >PIA1Base+3
         ldb   #$0A
L07E6    lda   #$FE
         bsr   DingDuration
         lda   #$02
         bsr   DingDuration
         decb
         bne   L07E6
         puls  a
         sta   >PIA1Base+3
         puls  b,a
         sta   >PIA0Base+1
         stb   >PIA0Base+3
         puls  pc,b,a

DingDuration
         sta   >PIA1Base
         lda   #128
L0805    inca
         bne   L0805
         rts

         emod
eom      equ   *
         end
