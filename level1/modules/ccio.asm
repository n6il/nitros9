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
         leax  V.SCF,u			point to memory after V.SCF
*         leax  <u001D,u
         ldb   #$5D			get counter
L002E    sta   ,x+			clear mem
         decb
         bne   L002E
         coma                          A = $FF
         comb                          B = $FF
         stb   <u0050,u
         std   <u005F,u
         std   <u0061,u
         lda   #$3C
         sta   <u0051,u
         leax  >AltIRQ,pcr		get IRQ routine ptr
         stx   >D.AltIRQ		store in AltIRQ
         leax  >L03CC,pcr
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
Read     leax  <u007A,u
         ldb   <IBufTail,u	get tail pointer
         orcc  #IRQMask		mask IRQ
         cmpb  <IBufHead,u	same as head pointer
         beq   Put2Bed		if so, buffer is empty, branch to sleep
         abx			X now points to curr char
         lda   ,x		get char
         bsr   L009D		check for tail wrap
         stb   <IBufTail,u	store updated tail
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
L009D    incb
         cmpb  #$7F
         bls   L00A3
         clrb
L00A3    rts

* IRQ routine for keyboard
AltIRQ   ldu   >D.KbdSta	get keyboard static
         ldb   <u0032,u
         beq   L00B7
         ldb   <u002F,u
         beq   L00B7
         lda   <u0030,u
         lbsr  L03CC
L00B7    ldx   #PIA0Base
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
L00E4    jmp   [>D.Clock]
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
         ldb   #$3C
L011A    stb   <u0051,u
         ldb   <IBufHead,u
         leax  <u007A,u
         abx
         lbsr  L009D		check for tail wrap
         cmpb  <IBufTail,u
         beq   L012F
         stb   <IBufHead,u
L012F    sta   ,x
         beq   L014F
         cmpa  V.PCHR,u
         bne   L013F
         ldx   V.DEV2,u
         beq   L014F
         sta   $08,x
         bra   L014F
L013F    ldb   #S$Intrpt
         cmpa  V.INTR,u
         beq   L014B
         ldb   #S$Abort
         cmpa  V.QUIT,u
         bne   L014F
L014B    lda   V.LPRC,u
         bra   L0153
L014F    ldb   #S$Wake
         lda   V.WAKE,u
L0153    beq   L0158
         os9   F$Send
L0158    clr   V.WAKE,u
         bra   L00E4
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
         eorb  <u0050,u
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
         leax  >L0321,pcr
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
         com   <u0050,u
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

L0321    fcb   $00,$40,$60	ALT @ `
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
Write    ldb   <u0025,u		are we in the process of getting parameters?
         bne   L03A3		yes, go process
         sta   <WrChar,u	save character to write
         cmpa  #C$SPAC		space or higher?
         bcc   GoCo		yes, normal write
         cmpa  #$1E		escape sequence $1E or $1F?
         bcc   L03B8		yes, go process
         cmpa  #$0F		??
         lbcc  L063B		branch if higher or same
         cmpa  #C$BELL		bell?
         lbeq  Ding		if so, ring bell
* Here we call the Co-module to write the character
GoCo     lda   <CoInUse,u	get CO32/CO80 flag
CoWrite  ldb   #$03		we want to write
CallCo   leax  <CoEnt,u		get base pointer to CO-entries
         ldx   a,x		get pointer to CO32/CO80
         beq   NoIOMod		branch if no module
         lda   <WrChar,u	get character to write
L039D    jmp   b,x		call i/o subroutine
NoIOMod  comb  
         ldb   #E$MNF
         rts 

* Parameter handler
L03A3    cmpb  #$02		two parameters left?
         beq   L03B0		branch if so
         sta   <u0029,u		else store in VD.NChar
         clr   <u0025,u		clear parameter counter (?)
         jmp   [<u0026,u]
L03B0    sta   <u0028,u		store in VD.NChr2
         dec   <u0025,u		decrement parameter counter (?)
         clrb
         rts

L03B8    beq   L03C5
         leax  <L03C7,pcr
L03BD    ldb   #$01
L03BF    stx   <u0026,u
         stb   <u0025,u
L03C5    clrb
         rts

L03C7    ldb   #$03
         lbra  L055F

L03CC    pshs  x,a
         stb   <u002F,u
         lda   >PIA1Base+2
         anda  #$07
         ora   ,s+
         tstb
         bne   L03DE
         ora   <trulocas,u
L03DE    sta   >PIA1Base+2
         sta   <u0030,u
         tstb
         bne   L03F5
         stb   >$FFC0
         stb   >$FFC2
         stb   >$FFC4
         lda   <u001D,u
         bra   L0401
L03F5    stb   >$FFC0
         stb   >$FFC3
         stb   >$FFC5
         lda   <u0033,u
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
GetStat  sta   <WrChar,u
         cmpa  #SS.Ready
         bne   L0439
         lda   <IBufTail,u		get buff tail ptr
         suba  <IBufHead,u		Num of chars ready in A
         lbeq  L0660			branch if empty
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
         ldb   #$06
         lbra  L055F

SSKYSNS  ldb   <u006A,u		get key sense info
         stb   R$A,x		put in caller's A
         clrb
         rts

SSSCSIZ  clra
         ldb   <ScreenX,u
         std   R$X,x
         ldb   <ScreenY,u
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
         ldd   <u0033,u
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
         ldy   <u0033,u
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
SetStat  sta   <WrChar,u
         ldx   PD.RGS,y
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

CoGetStt ldb   #$09			co-module setstat
L055F    pshs  b
         lda   <CoInUse,u		get Co-module in use
         lbsr  CallCo
         puls  a
         bcc   L055B
         tst   <GRFOEnt,u		GRFO linked?
         beq   L055C
         tfr   a,b
         clra				GRFO address offset in statics
         lbra  CallCo			call it

* Reserve an additional graphics buffer (up to 2)
SSAAGBF  ldb   <u0031,u
         lbeq  L0660
         pshs  b		get buffer number
         leay  <u0037,u
         ldd   ,y
         beq   L058E
         leay  $02,y
         inc   ,s
         ldd   ,y
         bne   L059E
L058E    lbsr  L0685
         bcs   L05A1
         std   ,y
         std   R$X,x
         puls  b		get buffer number off stack
         clra			clear hi byte of D
         std   R$Y,x		and put in caller's Y
         clrb			call is ok
         rts			and return
L059E    ldb   #E$BMode
         coma
L05A1    puls  pc,a

* Select a graphics buffer
SSSLGBF  ldb   <u0031,u
         lbeq  L0660
         ldd   R$Y,x		get buffer number from caller
         cmpd  #$0002		compare against high
         bhi   BadMode		branch if error
         leay  <u0035,u
         lslb			multiply by 2
         ldd   b,y		get pointer
         beq   BadMode		branch if error
         std   <u0033,u		else save in current
         ldd   R$X,x		get select flag
         beq   L05C3		if zero, do nothing
         ldb   #$01		else set display flag
L05C3    stb   <u0032,u		save display flag
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
GoCO32   stb   <trulocas,u	save flag for later
         lda   #$02		CO32 is loaded bit
         ldx   #$2010		32x16
         pshs  u,y,x,a
         leax  >CO32,pcr
         bra   L05F4
GoCO80   lda   #$04		'CO80 is loaded' bit
         ldx   #$5018		80x24
         pshs  u,y,x,a
         leax  >CO80,pcr
L05F4    bsr   L0601		load co-module if not already loaded
         puls  u,y,x,a
         bcs   L0600
         stx   <ScreenX,u	save screen size
         sta   <CoInUse,u	current module in use? ($02=CO32, $04=C080)
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
         ldb   #$00		co-module init offset
         lbra  CallCo		call it

* Link to subroutine
LinkSub  pshs  u
         lda   #Systm+Objct
         os9   F$Link
         puls  pc,u

L0637    fdb   $0055,$aaff

L063B    cmpa  #$15		GRFO-handled code?
         bcc   GoGrfo		branch if so
         cmpa  #$0F		display graphics code?
         beq   Do0F		branch if so
         suba  #$10
         bsr   L065B
         bcs   L0663
         leax  <L0651,pcr
         lsla
         ldd   a,x
         jmp   d,x

L0651    fdb   $0140,$00fd,$0111,$0160,$016f

L065B    ldb   <u0031,u
         bne   L0606
L0660    comb
         ldb   #E$NotRdy
L0663    rts

GoGrfo   bsr   L065B
         bcs   L0663
         ldx   <GRFOEnt,u		get GRFO entry point
         bne   L0681			branch if not zero
         pshs  y,a			else preserve regs
         bne   L067F
         leax  >GRFO,pcr		get pointer to name string
         bsr   LinkSub			link to GRFO
         bcc   L067B			branch if ok
         puls  pc,y,a			else exit with error
L067B    sty   <GRFOEnt,u		save module entry pointer
L067F    puls  y,a			restore regs
L0681    clra				A = GRFO address offset in statics
         lbra  CoWrite

L0685    pshs  u
         ldd   #6144+256
         os9   F$SRqMem
         bcc   L0691
         puls  pc,u
L0691    tfr   u,d
         puls  u
         tfr   a,b
         bita  #$01
         beq   L069F
         adda  #$01
         bra   L06A1
L069F    addb  #$18
L06A1    pshs  u,a
         tfr   b,a
         clrb
         tfr   d,u
         ldd   #256
         os9   F$SRtMem
         puls  u,a
         bcs   L06B3
         clrb
L06B3    rts

Do0F     leax  <DispGfx,pcr
         ldb   #$02
         lbra  L03BF

DispGfx  ldb   <u0031,u
         bne   L06D1
         bsr   L0685
         bcs   L06EF
         std   <u0033,u
         std   <u0035,u
         inc   <u0031,u
         lbsr  L07B1
L06D1    lda   <u0029,u
         sta   <u004B,u
         anda  #$03
         leax  >L0637,pcr
         lda   a,x
         sta   <u0047,u
         sta   <u0048,u
         lda   <u0028,u
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
         ldb   <u0029,u
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
         ldb   <u0029,u
         andb  #$04
         lslb  
         pshs  b
         ora   ,s+
         ldb   #$01
         lbra  L03CC

L0742    fcb   $c0,$30,$0c,$03
L0746    fcb   $80,$40,$20,$10,$08,$04,$02,$01

* I Think this is code
         fcb   $30,$8C,$03,$16,$fC,$69,$6f,$C8,$28
         fcb   $A6,$C8,$24,$2B,$03,$6C,$C8,$28,$16
         fcb   $FF,$6F,$30,$C8,$35,$10,$8E,$00,$00
         fcb   $C6,$03,$34,$44

L076D    ldd   #6144		size of graphics screen
         ldu   ,x++
         beq   L077A
         sty   -$02,x
         os9   F$SRtMem
L077A    dec   ,s
         bgt   L076D
         ldu   ,x
         beq   L0788
         ldd   #512
         os9   F$SRtMem
L0788    puls  u,b
         clra
         sta   <u0031,u
         lbra  L03CC
         leax  <L0797,pcr
         lbra  L03BD
L0797    lda   <u0029,u
         tst   <u0024,u
         bpl   L07A7
         ldb   #$FF
         anda  #$01
         beq   L07B1
         bra   L07B2
L07A7    anda  #$03
         leax  >L0637,pcr
         ldb   a,x
         bra   L07B2
L07B1    clrb
L07B2    ldx   <u0033,u
         leax  >6144+1,x
L07B9    stb   ,-x
         cmpx  <u0033,u
         bhi   L07B9
         clra
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
