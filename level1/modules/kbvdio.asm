********************************************************************
* KBVDIO - keyboard/video driver
*
* $Id$
*
* Edt/Rev  YYYY/MM/DD  Modified by
* Comment
* ------------------------------------------------------------------
*          ????/??/??
* Original Dragon Data distribution version
*
*          2004/01/04  Rodney Hamilton
* Recoded anonymous fcb arrays, added some comments

         nam   KBVDIO
         ttl   keyboard/video driver

* Disassembled 02/04/21 22:37:57 by Disasm v1.6 (C) 1988 by RML

         ifp1
         use   defsfile
         endc

tylg     set   Drivr+Objct   
atrv     set   ReEnt+rev
rev      set   $00
edition  set   4

         mod   eom,name,tylg,atrv,start,size

u0000    rmb   2
u0002    rmb   1
u0003    rmb   1
u0004    rmb   1
u0005    rmb   4
u0009    rmb   2
u000B    rmb   1
u000C    rmb   1
u000D    rmb   11
u0018    rmb   1
u0019    rmb   1
u001A    rmb   1
u001B    rmb   1
u001C    rmb   1
u001D    rmb   2
u001F    rmb   2
u0021    rmb   1
u0022    rmb   1
u0023    rmb   1
u0024    rmb   1
u0025    rmb   1
u0026    rmb   2
u0028    rmb   1
u0029    rmb   2
u002B    rmb   1
u002C    rmb   1
u002D    rmb   2
u002F    rmb   1
u0030    rmb   1
u0031    rmb   2
u0033    rmb   1
u0034    rmb   1
u0035    rmb   1
u0036    rmb   1
u0037    rmb   1
u0038    rmb   1
u0039    rmb   1
u003A    rmb   1
vhwaddr  rmb   2		address of keyboard hardware
u003D    rmb   1		SHIFTLOCK toggle
u003E    rmb   1
u003F    rmb   1
u0040    rmb   1
u0041    rmb   1
u0042    rmb   1
u0043    rmb   1
u0044    rmb   1
u0045    rmb   1		SHIFT key flag
u0046    rmb   1		CONTROL key flag
u0047    rmb   1
u0048    rmb   1
u0049    rmb   1
u004A    rmb   1
u004B    rmb   10
u0055    rmb   26
u006F    rmb   91
size     equ   .
         fcb   $07 

name     fcs   /KBVDIO/
         fcb   edition

start    lbra  Init
         lbra  Read
         lbra  Write
         lbra  GetStat
         lbra  SetStat
         lbra  Term

Init     lbsr  AllocMem		allocate video memory
         lbra  L002D		unsure why this is here.. timing?
L002D    pshs  cc		save CC
         orcc  #IRQMask		mask IRQs
         stu   >D.KbdSta	save our static mem
         ldd   >D.IRQ		get current IRQ vector address
         std   >D.AltIRQ	store in Alt. IRQ vector
         leax  >OurIRQ,pcr	point to our IRQ address
         stx   >D.IRQ		store in D.IRQ
         ldx   #$FF00		get address of PIA
         stx   <vhwaddr,u	store in statics for IRQ routine
         clra  
         clrb  
         std   <u0048,u
         sta   $01,x		clear $FF01
         sta   ,x		clear $FF00
         sta   $03,x		clear $FF03
         comb  			B = $FF now
         stb   <u003D,u
         stb   $02,x		put $FF in $FF02
         stb   <u003F,u
         stb   <u0040,u
         stb   <u0041,u
         lda   #$34
         sta   $01,x		put $34 in $FF01
         lda   #$3F
         sta   $03,x		put $3F in $FF03
         lda   $02,x		get byte at $FF02
         puls  pc,cc		get CC and return
         ldb   #E$Write
         orcc  #Carry		set carry
         rts   			and return

GetStat  cmpa  #SS.Ready	SS.Ready call?
         bne   L0082		branch if not
         lda   <u0049,u
         suba  <u0048,u
         bne   GSOk
         ldb   #E$NotRdy
         bra   L009A
L0082    cmpa  #SS.EOF		End of file?
         beq   GSOk		branch if so
         cmpa  #SS.DStat
         lbeq  L04E4
         cmpa  #SS.Joy		joystick value acquisition?
         lbeq  L085F
         cmpa  #SS.AlfaS	Alfa display status?
         lbeq  L04CD		branch if so

SetStat  ldb   #E$UnkSvc
L009A    orcc  #Carry
         rts   

Term     pshs  cc		save CC
         orcc  #IRQMask		mask IRQs
         ldx   >D.AltIRQ	get Alt. IRQ address
         stx   >D.IRQ		and restore it to D.IRQ
         puls  pc,cc		get CC and return

L00A9    incb  
         cmpb  #$7F
         bls   L00AF
GSOk     clrb  
L00AF    rts   

* Driver's IRQ Routine
OurIRQ   ldu   >D.KbdSta	get pointer to driver's statics
         ldx   <vhwaddr,u	get keyboard hardware address
         lda   $03,x		get byte
         bmi   L00BE		branch if hi bit set
         jmp   [>D.SvcIRQ]	else jump on
L00BE    lda   $02,x
         lda   #$FF
         sta   $02,x
         lda   ,x
         coma  
         anda  #$03
         bne   L00D4
         clr   $02,x
         lda   ,x
         coma  
         anda  #$7F
         bne   L00F1
L00D4    clra  
         coma  
         sta   <u003F,u
         sta   <u0040,u
         sta   <u0041,u
L00DF    lda   >D.DskTmr
         beq   L00ED
         deca  
         sta   >D.DskTmr
         bne   L00ED
         sta   >$FF48
L00ED    jmp   [>D.AltIRQ]
L00F1    bsr   L013F
         bmi   L00DF
         sta   <u0047,u
         cmpa  #$1F		control-zero?
         bne   L0101
         com   <u003D,u		yes, toggle SHIFTLOCK
         bra   L00DF
L0101    ldb   <u0048,u
         leax  <u004A,u
         abx   
         bsr   L00A9
         cmpb  <u0049,u
         beq   L0112
         stb   <u0048,u
L0112    sta   ,x
         beq   L0132
         cmpa  u000D,u
         bne   L0122
         ldx   u0009,u
         beq   L0132
         sta   $08,x
         bra   L0132
L0122    ldb   #$03
         cmpa  u000B,u
         beq   L012E
         ldb   #$02
         cmpa  u000C,u
         bne   L0132
L012E    lda   u0003,u
         bra   L0136
L0132    ldb   #S$Wake
         lda   V.WAKE,u
L0136    beq   L013B
         os9   F$Send   	send signal to process
L013B    clr   V.WAKE,u
         bra   L00DF

L013F    clra  
         sta   <u003E,u
         sta   <u0045,u
         sta   <u0046,u
         coma  
         sta   <u0042,u
         sta   <u0043,u
         sta   <u0044,u
         deca  
         sta   $02,x		strobe column #0 ($FF02)
L0156    lda   ,x		read row register ($FF00)
         coma  			flip bits to active-high
         anda  #$7F		mask off joystick row
         beq   L0169		no keypress in this column
         ldb   #$FF
L015F    incb  
         lsra  
         bcc   L0165		no key in this row, move along
         bsr   L01AF		keypress detected, process row & col
L0165    cmpb  #$06		final row checked?
         bcs   L015F
L0169    inc   <u003E,u		bump column counter
         orcc  #Carry
         rol   $02,x		strobe next column
         bcs   L0156
         lbsr  L01F8
         bmi   L01AE
         suba  #$1B
         bcc   L0191		not an alpha key
         adda  #$1B
         ldb   <u0046,u		control key pressed?
         bne   L0190		yes, return CTRL code
         adda  #$40		no, convert to ASCII
         ldb   <u0045,u		shift key pressed?
         eorb  <u003D,u
         andb  #$01
         bne   L0190
         adda  #$20
L0190    rts   
L0191    ldb   #3		three values per key
         mul   
         lda   <u0045,u		shift key pressed?
         beq   L019C
         incb  			yes, use 2nd value
         bra   L01A3
L019C    lda   <u0046,u		control key pressed?
         beq   L01A3
         addb  #$02		yes, use 3rd value
L01A3    pshs  x
         leax  >L023E,pcr
         clra  
         lda   d,x
         puls  x
L01AE    rts   

* convert row number in B.reg from DRAGON to COCO order
L01AF    pshs  b
         cmpb  #$06
         beq   L01BF
         cmpb  #$01
         bhi   L01BD
         addb  #$04
         bra   L01BF
L01BD    subb  #$02
L01BF    lslb  			multiply row * 8
         lslb  
         lslb  
         addb  <u003E,u		add column.  B.reg now = keycode ($00-$37)
         cmpb  #$31		is this the CLEAR key?
         bne   L01CE
         inc   <u0046,u		yes, set control pressed flag
         puls  pc,b
L01CE    cmpb  #$37		is this a SHIFT key?
         bne   L01D7
         com   <u0045,u		yes, set shift pressed flag
         puls  pc,b
L01D7    pshs  x
         leax  <u0042,u
         bsr   L01E2
         puls  x
         puls  pc,b
L01E2    pshs  a
         lda   ,x
         bpl   L01EC
         stb   ,x
         puls  pc,a
L01EC    lda   $01,x
         bpl   L01F4
         stb   $01,x
         puls  pc,a
L01F4    stb   $02,x
         puls  pc,a
L01F8    pshs  y,x,b
         leax  <u003F,u
         ldb   #$03
         pshs  b
L0201    leay  <u0042,u
         ldb   #$03
         lda   ,x
         bmi   L021D
L020A    cmpa  ,y
         bne   L0214
         clr   ,y
         com   ,y
         bra   L021D
L0214    leay  $01,y
         decb  
         bne   L020A
         lda   #$FF
         sta   ,x
L021D    leax  $01,x
         dec   ,s
         bne   L0201
         leas  $01,s
         leax  <u0042,u
         lda   #$03
L022A    ldb   ,x+
         bpl   L0235
         deca  
         bne   L022A
         orcc  #Negative
         puls  pc,y,x,b

L0235    leax  <u003F,u
         bsr   L01E2
         tfr   b,a
         puls  pc,y,x,b

*RVH: the following is a non-alpha key lookup table with
*normal/shift/control codes for each key (1D,1E,7F missing)
L023E    fcb   $0C,$1C,$13	UP-ARROW (FF| FS|DC3)
L0241    fcb   $0A,$1A,$12	DN-ARROW (LF|SUB|DC2)
L0244    fcb   $08,$18,$10	LF-ARROW (BS|CAN|DLE)
L0247    fcb   $09,$19,$11	RT-ARROW (HT| EM|DC1)
L024A    fcb   $20,$20,$20	SPACEBAR
L024D    fcb   $30,$30,$1F	0 0 . (1F=shiftlock toggle)
L0250    fcb   $31,$21,$7C	1 ! |
L0253    fcb   $32,$22,$00	2 " null
L0256    fcb   $33,$23,$7E	3 # ~
L0259    fcb   $34,$24,$00	4 $ null
L025C    fcb   $35,$25,$00	5 % null
L025F    fcb   $36,$26,$00	6 & null
L0262    fcb   $37,$27,$5E	7 ' ^
L0265    fcb   $38,$28,$5B	8 ( [
L0268    fcb   $39,$29,$5D	9 ) ]
L026B    fcb   $3A,$2A,$00	: * null
L026E    fcb   $3B,$2B,$00	; + null
L0271    fcb   $2C,$3C,$7B	, < {
L0274    fcb   $2D,$3D,$5F	- = _
L0277    fcb   $2E,$3E,$7D	. > }
L027A    fcb   $2F,$3F,$5C	/ ? \
L027D    fcb   $0D,$0D,$0D	ENTER
L0280    fcb   $00,$00,$00	CLEAR?
L0283    fcb   $05,$03,$1B	BREAK  (ENQ|ETX|ESC)

Read     leax  <u004A,u
         ldb   <u0049,u
         orcc  #IRQMask
         cmpb  <u0048,u
         beq   L029F
         abx   
         lda   ,x
         lbsr  L00A9
         stb   <u0049,u
         andcc #^(IRQMask+Carry)
         rts   

L029F    lda   V.BUSY,u
         sta   V.WAKE,u
         andcc #^IRQMask
         ldx   #$0000
         os9   F$Sleep  
         clr   V.WAKE,u
         ldx   <u004B
L02AF    ldb   <$36,x
         beq   Read
         cmpb  #$04
L02B6    bcc   Read
         coma  
         rts   

* Allocate video memory on a 512 byte boundary
AllocMem pshs  y,x
         clr   <u0025,u
         clr   <u002C,u
L02C2    pshs  u		save static mem pointer
         ldd   #768
L02C7    os9   F$SRqMem		get 768 bytes
         tfr   u,d		put pointer into D
         tfr   u,x		and X
         bita  #$01		odd or even page?
         beq   L02D8		branch if even
         leax  >256,x		else memory not on 512 byte boundary
L02D6    bra   L02DC
L02D8    leau  >512,u		free last page
L02DC    ldd   #256		get page amount
         os9   F$SRtMem 	and return page to system
         puls  u		get static mem pointer
         stx   <u001D,u		save pointer to page
         clra  
         clrb  
         bsr   L0303
         stx   <u0021,u
         leax  >512,x
         stx   <u001F,u
         lbsr  L0459		clear screen
         lda   #$60
         sta   <u0023,u
         sta   <u002B,u
         clrb  
         puls  pc,y,x

L0303    pshs  x,a
         lda   >$FF22
         anda  #$07
         ora   ,s+
         sta   >$FF22
         tstb  
         bne   L0320
         stb   >$FFC0
         stb   >$FFC2
         stb   >$FFC4
         lda   <u001D,u
         bra   L032C
L0320    stb   >$FFC0
         stb   >$FFC3
         stb   >$FFC5
         lda   <u002D,u
L032C    ldb   #$07
         ldx   #$FFC6
         lsra  
L0332    lsra  
         bcs   L033B
         sta   ,x+
         leax  $01,x
         bra   L033F
L033B    leax  $01,x
         sta   ,x+
L033F    decb  
         bne   L0332
         clrb  
         puls  pc,x

Write    ldb   <u0025,u
         bne   L0387
         tsta  
         bmi   L0371
         cmpa  #$1F
         bls   L03BC
         cmpa  #$7C
         bne   L0359
         lda   #$61
         bra   L0371
L0359    cmpa  #$7E
         bne   L0361
         lda   #$6D
         bra   L0371
L0361    cmpa  #$60
         bcs   L036B
         suba  #$20
         ora   #$40
         bra   L0371
L036B    cmpa  #$40
         bcs   L0371
         suba  #$40
L0371    ldx   <u0021,u
         eora  #$40
         sta   ,x+
         stx   <u0021,u
         cmpx  <u001F,u
         bcs   L0382
         bsr   L039C
L0382    lbsr  L0415
         clrb  
         rts   
L0387    cmpb  #$01
         beq   L0394
         clr   <u0025,u
         sta   <u0029,u
         jmp   [<u0026,u]
L0394    sta   <u0028,u
         inc   <u0025,u
* no operation entry point
L039A    clrb  
         rts   
L039C    ldx   <u001D,u
         leax  <$20,x
L03A2    ldd   ,x++
         std   <-$22,x
         cmpx  <u001F,u
         bcs   L03A2
         leax  <-$20,x
         stx   <u0021,u
         lda   #$20
         ldb   #$60
L03B6    stb   ,x+
         deca  
         bne   L03B6
L03BB    rts   
L03BC    cmpa  #27
         bcc   L03BB
         cmpa  #$10
         bcs   L03CE
         ldb   <u002C,u
         bne   L03CE
         ldb   #E$NotRdy
         orcc  #Carry
         rts   

L03CE    leax  <L03D6,pcr
         lsla  
         ldd   a,x
         jmp   d,x

* dispatch table for display function codes
L03D6    fdb   L039A-L03D6	$FFC4	00: no-op
         fdb   L0467-L03D6	$0091	01: home cursor
         fdb   L047B-L03D6	$00A5	02: cursor xy
         fdb   L04A6-L03D6	$00D0	03: erase line
         fdb   L039A-L03D6	$FFC4	04: no-op
         fdb   L039A-L03D6	$FFC4	05: no-op
         fdb   L044B-L03D6	$0075	06: cursor right
         fdb   L039A-L03D6	$FFC4	07: no-op
         fdb   L043D-L03D6	$0067	08: cursor left
         fdb   L04B8-L03D6	$00E2	09: cursor up
         fdb   L0424-L03D6	$004E	0A: cursor down
         fdb   L039A-L03D6	$FFC4	0B: no-op
         fdb   L0459-L03D6	$0083	0C: clear screen
         fdb   L040C-L03D6	$0036	0D: return cursor to start of line
         fdb   L04C8-L03D6	$00F2	0E: display alpha
         fdb   L0520-L03D6	$014A	0F: display graphics
         fdb   L0604-L03D6	$022E	10: preset screen to specific color
         fdb   L05DF-L03D6	$0209	11: set color
         fdb   L05F3-L03D6	$021D	12: end graphics
         fdb   L0624-L03D6	$024E	13: erase graphics
         fdb   L062F-L03D6	$0259	14: home graphics cursor
         fdb   L0648-L03D6	$0272	15: Set Graphics Cursor 
         fdb   L06B5-L03D6	$02DF	16: Draw Line 
         fdb   L06B0-L03D6	$02DA	17: Erase Line 
         fdb   L065F-L03D6	$0289	18: Set Point 
         fdb   L065A-L03D6	$0284	19: Erase Point 
         fdb   L077E-L03D6	$03A8	1A: Draw Circle 

* $0D - return cursor to start of line (carriage return)
L040C    bsr   L0472
         tfr   x,d
         andb  #$E0
         stb   <u0022,u
L0415    ldx   <u0021,u
         lda   ,x
         sta   <u0023,u
         lda   #$20
         sta   ,x
         andcc #^Carry
         rts   

* $0A - cursor down
L0424    bsr   L0472
         leax  <$20,x
         cmpx  <u001F,u
         bcs   L0438
         leax  <-$20,x
         pshs  x
         lbsr  L039C
         puls  x
L0438    stx   <u0021,u
         bra   L0415

* $08 - cursor left
L043D    bsr   L0472
         cmpx  <u001D,u
         bls   L0449
         leax  -$01,x
         stx   <u0021,u
L0449    bra   L0415

* $06 - cursor right
L044B    bsr   L0472
         leax  $01,x
         cmpx  <u001F,u
         bcc   L0457
         stx   <u0021,u
L0457    bra   L0415

* $0C - clear screen
L0459    bsr   L0467
         lda   #$60
L045D    sta   ,x+
         cmpx  <u001F,u
         bcs   L045D
         lbra  L0415

* $01 - home cursor
L0467    bsr   L0472
         ldx   <u001D,u
         stx   <u0021,u
         lbra  L0415
L0472    ldx   <u0021,u
         lda   <u0023,u
         sta   ,x
         rts   

* $02 XX YY - cursor xy (move cursor to XX-32,YY-32)
L047B    leax  <L0481,pcr
         lbra  L064B
L0481    bsr   L0472
         ldb   <u0029,u
         subb  #$20
         lda   #$20
         mul   
         addb  <u0028,u
         adca  #$00
         subd  #$0020
         addd  <u001D,u
         cmpd  <u001F,u
         bcc   L04A3
         std   <u0021,u
         lbsr  L0415
         clrb  
L04A3    lbra  L0415

* $03 - erase line
L04A6    lbsr  L040C		do a CR
         ldb   #$20		32 chars per line
         lda   #$60		space char for VDG screen
         ldx   <u0021,u
L04B0    sta   ,x+		fill screen line with 'space'
         decb  
         bne   L04B0
         lbra  L0415

* $09 - cursor up
L04B8    bsr   L0472
         leax  <-$20,x
         cmpx  <u001D,u
         bcs   L04C5
         stx   <u0021,u
L04C5    lbra  L0415

* $0E - display alpha
L04C8    clra  
         clrb  
         lbra  L0303
L04CD    ldx   $06,y
         ldd   <u001D,u
         std   $04,x
         ldd   <u0021,u
         std   $06,x
         ldb   <u003D,u
         stb   $01,x
         clrb  
         rts   

* 4-color mode color table
L04E0    fcb   $00,$55,$AA,$FF

L04E4    lda   <u002C,u	
         bne   L04EE	
L04E9    ldb   #E$NotRdy
         orcc  #Carry
         rts   

L04EE    ldd   <u0034,u
         lbsr  L0684
         tfr   a,b
         andb  ,x
L04F8    bita  #$01
         bne   L0507
         lsra  
         lsrb  
         tst   <u0024,u
         bmi   L04F8
         lsra  
         lsrb  
         bra   L04F8
L0507    pshs  b
         ldb   <u003A,u
         andb  #$FC
L050E    orb   ,s+
         ldx   $06,y
         stb   $01,x
         ldd   <u0034,u
         std   $06,x
         ldd   <u002D,u
         std   $04,x
         clrb  
         rts   

* $0F - display graphics
L0520    leax  <L0526,pcr
         lbra  L064B
L0526    ldb   <u002C,u
         bne   L0566
         pshs  u
         ldd   #$1900
         os9   F$SRqMem 
         tfr   u,d
         puls  u
         bcs   L0585
         tfr   a,b
         bita  #$01
         beq   L0543
         adda  #$01
         bra   L0545
L0543    addb  #$18
L0545    pshs  u,a
         tfr   b,a
         clrb  
         tfr   d,u
         ldd   #$0100
         os9   F$SRtMem 
         puls  u,a
         bcs   L0585
         clrb  
         std   <u002D,u
         addd  #$1800
         std   <u002F,u
         inc   <u002C,u
         lbsr  L0624
L0566    lda   <u0029,u
         sta   <u003A,u
         anda  #$03
         leax  >L04E0,pcr
         lda   a,x
         sta   <u0036,u
         sta   <u0037,u
         lda   <u0028,u
         cmpa  #$01
         bls   L0586
         ldb   #E$BMode		illegal mode
         orcc  #Carry
L0585    rts   

L0586    tsta  
         beq   L05A6
         ldd   #$C003
         std   <u0038,u
         lda   #$01
         sta   <u0024,u
         lda   #$E0
         ldb   <u0029,u
         andb  #$08
         beq   L059F
         lda   #$F0
L059F    ldb   #$03
         leax  <L05D3,pcr
         bra   L05BE
L05A6    ldd   #$8001
         std   <u0038,u
         lda   #$FF
         sta   <u0036,u
         sta   <u0037,u
         sta   <u0024,u
         lda   #$F0
         ldb   #$07
         leax  <L05D7,pcr
L05BE    stb   <u0033,u
         stx   <u0031,u
         ldb   <u0029,u
         andb  #$04
         lslb  
         pshs  b
         ora   ,s+
         ldb   #$01
         lbra  L0303

* 4-color mode pixel masks
L05D3    fcb   $C0,$30,$0C,$03

* 2-color mode pixel masks
L05D7    fcb   $80,$40,$20,$10,$08,$04,$02,$01

* $11 - set color
L05DF    leax  <L05E5,pcr
         lbra  L0781
L05E5    clr   <u0028,u
         lda   <u0024,u
         bmi   L05F0
         inc   <u0028,u
L05F0    lbra  L0566

* $12 - end graphics
L05F3    pshs  u
         ldu   <u002D,u
         ldd   #6144		size of graphics screen
         os9   F$SRtMem 
         puls  u
         clr   <u002C,u
         rts   

* $10 - preset screen to specified color
L0604    leax  <L060A,pcr
         lbra  L0781
L060A    lda   <u0029,u
         tst   <u0024,u
         bpl   L061A
         ldb   #$FF
         anda  #$01
         beq   L0624
         bra   L0625
L061A    anda  #$03
         leax  >L04E0,pcr
         ldb   a,x
         bra   L0625

* $13 - erase graphics
L0624    clrb  
L0625    ldx   <u002D,u
L0628    stb   ,x+
         cmpx  <u002F,u
         bcs   L0628

* $14 - home graphics cursor
L062F    clra  
         clrb  
         std   <u0034,u
         rts   
L0635    ldd   <u0028,u
         cmpb  #192
         bcs   L063E
         ldb   #192-1
L063E    tst   <u0024,u
         bmi   L0644
         lsra  
L0644    std   <u0028,u
         rts   

* $15 - set graphics cursor
L0648    leax  <L0653,pcr
L064B    stx   <u0026,u
         inc   <u0025,u
         clrb  
         rts   
L0653    bsr   L0635
         std   <u0034,u
         clrb  
         rts   

* $19 - erase point
L065A    clr   <u0036,u
         bra   L065F

* $18 - set point
L065F    leax  <L0664,pcr
         bra   L064B
L0664    bsr   L0635
         std   <u0034,u
         bsr   L0673
         lda   <u0037,u
         sta   <u0036,u
         clrb  
         rts   
L0673    bsr   L0684
         tfr   a,b
         comb  
         andb  ,x
         stb   ,x
         anda  <u0036,u
         ora   ,x
         sta   ,x
         rts   
L0684    pshs  y,b,a
         ldb   <u0024,u
         bpl   L068C
         lsra  
L068C    lsra  
         lsra  
         pshs  a
         ldb   #$BF
         subb  $02,s
         lda   #$20
         mul   
         addb  ,s+
         adca  #$00
         ldy   <u002D,u
         leay  d,y
         lda   ,s
         sty   ,s
         anda  <u0033,u
         ldx   <u0031,u
         lda   a,x
         puls  pc,y,x

* $17 - erase line
L06B0    clr   <u0036,u
         bra   L06B5

* $16 - draw line
L06B5    leax  <L06BA,pcr
         bra   L064B
L06BA    lbsr  L0635
         leas  -$0E,s
         std   $0C,s
         bsr   L0684
         stx   $02,s
         sta   $01,s
         ldd   <u0034,u
         bsr   L0684
         sta   ,s
         clra  
         clrb  
         std   $04,s
         lda   #$BF
         suba  <u0035,u
         sta   <u0035,u
         lda   #$BF
         suba  <u0029,u
         sta   <u0029,u
         lda   #$FF
         sta   $06,s
         clra  
         ldb   <u0034,u
         subb  <u0028,u
         sbca  #$00
         bpl   L06F7
         nega  
         negb  
         sbca  #$00
         neg   $06,s
L06F7    std   $08,s
         bne   L0700
         ldd   #$FFFF
         std   $04,s
L0700    lda   #$E0
         sta   $07,s
         clra  
         ldb   <u0035,u
         subb  <u0029,u
         sbca  #$00
         bpl   L0715
         nega  
         negb  
         sbca  #$00
         neg   $07,s
L0715    std   $0A,s
         bra   L0721
L0719    sta   ,s
         ldd   $04,s
         subd  $0A,s
         std   $04,s
L0721    lda   ,s
         tfr   a,b
         anda  <u0036,u
         comb  
         andb  ,x
         pshs  b
         ora   ,s+
         sta   ,x
         cmpx  $02,s
         bne   L073B
         lda   ,s
         cmpa  $01,s
         beq   L076F
L073B    ldd   $04,s
         bpl   L0749
         addd  $08,s
         std   $04,s
         lda   $07,s
         leax  a,x
         bra   L0721
L0749    lda   ,s
         ldb   $06,s
         bpl   L075F
         lsla  
         ldb   <u0024,u
         bmi   L0756
         lsla  
L0756    bcc   L0719
         lda   <u0039,u
         leax  -$01,x
         bra   L0719
L075F    lsra  
         ldb   <u0024,u
         bmi   L0766
         lsra  
L0766    bcc   L0719
         lda   <u0038,u
         leax  $01,x
         bra   L0719
L076F    ldd   $0C,s
         std   <u0034,u
         leas  $0E,s
         lda   <u0037,u
         sta   <u0036,u
         clrb  
         rts   

* $1A - draw circle
L077E    leax  <L0789,pcr
L0781    stx   <u0026,u
         com   <u0025,u
         clrb  
         rts   
L0789    leas  -$04,s
         ldb   <u0029,u		get radius
         stb   $01,s		stack it
         clra  
         sta   ,s
         addb  $01,s
         adca  #$00
         nega  
         negb  
         sbca  #$00
         addd  #$0003
         std   $02,s
L07A0    lda   ,s
         cmpa  $01,s
         bcc   L07D2
         ldb   $01,s
         bsr   L07E0
         clra  
         ldb   $02,s
         bpl   L07BA
         ldb   ,s
         lslb  
         rola  
         lslb  
         rola  
         addd  #$0006
         bra   L07CA
L07BA    dec   $01,s
         clra  
         ldb   ,s
         subb  $01,s
         sbca  #$00
         lslb  
         rola  
         lslb  
         rola  
         addd  #$000A
L07CA    addd  $02,s
         std   $02,s
         inc   ,s
         bra   L07A0
L07D2    lda   ,s
         cmpa  $01,s
         bne   L07DC
         ldb   $01,s
         bsr   L07E0
L07DC    leas  $04,s
         clrb  
         rts   
L07E0    leas  -$08,s
         sta   ,s
         clra  
         std   $02,s
         nega  
         negb  
         sbca  #$00
         std   $06,s
         ldb   ,s
         clra  
         std   ,s
         nega  
         negb  
         sbca  #$00
         std   $04,s
         ldx   $06,s
         bsr   L0829
         ldd   $04,s
         ldx   $02,s
         bsr   L0829
         ldd   ,s
         ldx   $02,s
         bsr   L0829
         ldd   ,s
         ldx   $06,s
         bsr   L0829
         ldd   $02,s
         ldx   ,s
         bsr   L0829
         ldd   $02,s
         ldx   $04,s
         bsr   L0829
         ldd   $06,s
         ldx   $04,s
         bsr   L0829
         ldd   $06,s
         ldx   ,s
         bsr   L0829
         leas  $08,s
         rts   
L0829    pshs  b,a
         ldb   <u0035,u
         clra  
         leax  d,x
         cmpx  #$0000
         bmi   L083B
         cmpx  #$00BF
         ble   L083D
L083B    puls  pc,b,a
L083D    ldb   <u0034,u
         clra  
         tst   <u0024,u
         bmi   L0848
         lslb  
         rola  
L0848    addd  ,s++
         tsta  
         beq   L084E
         rts   
L084E    pshs  b
         tfr   x,d
         puls  a
         tst   <u0024,u
         lbmi  L0673
         lsra  
         lbra  L0673
L085F    ldx   $06,y
         pshs  y,cc
         orcc  #IRQMask
         lda   #$FF
         clr   >$FF02
         ldb   >$FF00
         ldy   $04,x
         bne   L0878
         andb  #$01
         bne   L087C
         bra   L087D
L0878    andb  #$02
         beq   L087D
L087C    clra  
L087D    sta   $01,x
         lda   >$FF03
         ora   #$08
         ldy   $04,x
         bne   L088B
         anda  #$F7
L088B    sta   >$FF03
         lda   >$FF01
         anda  #$F7
         bsr   L08AA
         std   $04,x
         lda   >$FF01
         ora   #$08
         bsr   L08AA
         pshs  b,a
         ldd   #$003F
         subd  ,s++
         std   $06,x
         clrb  
         puls  pc,y,cc
L08AA    sta   >$FF01
         clrb  
         bsr   L08BA
         bsr   L08BA
         bsr   L08BA
         bsr   L08BA
         lsrb  
         lsrb  
         clra  
         rts   
L08BA    pshs  b
         lda   #$7F
         tfr   a,b
L08C0    lsrb  
         cmpb  #$03
         bhi   L08CC
         lsra  
         lsra  
         tfr   a,b
         addb  ,s+
         rts   
L08CC    addb  #$02
         andb  #$FC
         pshs  b
         anda  #$FC
         sta   >$FF20
         tst   >$FF00
         bpl   L08E0
         adda  ,s+
         bra   L08C0
L08E0    suba  ,s+
         bra   L08C0

         emod
eom      equ   *
         end

