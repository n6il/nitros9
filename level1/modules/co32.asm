********************************************************************
* CO32 - Hardware VDG co-driver for CCIO
*
* $Id$
*
* Edt/Rev  YYYY/MM/DD  Modified by
* Comment
* ------------------------------------------------------------------
*   1      ????/??/??
* From Tandy OS-9 Level One VR 02.00.00
*
*          2003/09/22  Rodney Hamilton
* recoded dispatch table fcbs, fixed cursor color bug

         nam   CO32
         ttl   Hardware VDG co-driver for CCIO

* Disassembled 98/08/23 17:47:40 by Disasm v1.6 (C) 1988 by RML

         ifp1
         use   defsfile
         endc

tylg     set   Systm+Objct   
atrv     set   ReEnt+rev
rev      set   $00
edition  set   1

         mod   eom,name,tylg,atrv,start,size

u0000    rmb   0
size     equ   .
         fcb   $07 

name     fcs   /CO32/
         fcb   edition

start    equ   *
         lbra  Init
         lbra  Write
         lbra  GetStat
         lbra  SetStat
Term     pshs  y,x
         pshs  u		save U
         ldd   #$0200		32x16 VDG memory size
         ldu   <$1D,u		get pointer to memory
         os9   F$SRtMem 	return to system
         puls  u		restore U
         ldb   <$70,u
         andb  #$FD
         bra   L0086
* Init
Init     pshs  y,x		save regs
         lda   #$AF
         sta   <$2C,u		save default color cursor
         pshs  u		save static ptr
         ldd   #$0300		allocate 768 bytes for now
         os9   F$SRqMem 	get it
         tfr   u,d		put ptr in D
         tfr   u,x		and X
         bita  #$01		odd page?
         beq   L0052		branch if not
         leax  >$0100,x		else move X up 256 bytes
         bra   L0056		and return first 256 bytes
L0052    leau  >$0200,u		else move X up 512 bytes
L0056    ldd   #$0100		and return last 256 bytes
         os9   F$SRtMem 	free it!
         puls  u		restore static ptr
         stx   <$1D,u		save VDG screen memory
         pshs  y
         leay  -$0E,y
         clra  
         clrb  
         jsr   [<$5B,u]
         puls  y
         stx   <$21,u
         leax  >$0200,x
         stx   <$1F,u
         lda   #$60
         sta   <$23,u
         sta   <$2B,u
         lbsr  ClrScrn
         ldb   <$70,u
         orb   #$02		set to CO32 found (?)
L0086    stb   <$70,u
         clrb  
         puls  pc,y,x

* Write
* Entry: A = char to write
*        Y = path desc ptr
Write    tsta  
         bmi   L00D0
         cmpa  #$1F			byte $1F?
         bls   Dispatch			branch if lower or same
         ldb   <$71,u
         beq   L00B0
         cmpa  #$5E
         bne   L00A0
         lda   #$00
         bra   L00D0
L00A0    cmpa  #$5F
         bne   L00A8
         lda   #$1F
         bra   L00D0
L00A8    cmpa  #$60
         bne   L00C0
         lda   #$67
         bra   L00D0
L00B0    cmpa  #$7C
         bne   L00B8
         lda   #$21
         bra   L00D0
L00B8    cmpa  #$7E
         bne   L00C0
         lda   #$2D
         bra   L00D0
L00C0    cmpa  #$60
         bcs   L00C8
         suba  #$60
         bra   L00D0
L00C8    cmpa  #$40
         bcs   L00CE
         suba  #$40
L00CE    eora  #$40
L00D0    ldx   <$21,u
         sta   ,x+
         stx   <$21,u
         cmpx  <$1F,u
         bcs   L00DF
         bsr   SScrl
L00DF    bsr   ShowCrsr

* no operation entry point
NoOp     clrb  
         rts   

SScrl    ldx   <$1D,u
         leax  <$20,x
L00E9    ldd   ,x++
         std   <-$22,x
         cmpx  <$1F,u
         bcs   L00E9
         leax  <-$20,x
         stx   <$21,u
         lda   #$20
         ldb   #$60
L00FD    stb   ,x+
         deca  
         bne   L00FD
L0102    rts   

Dispatch cmpa  #$1B
         bcc   L0113
         cmpa  #$0E
         bhi   L0102
         leax  <DCodeTbl,pcr
         lsla  
         ldd   a,x
         jmp   d,x
L0113    comb  
         ldb   #E$Write
         rts   

* display functions dispatch table
DCodeTbl fdb   NoOp-DCodeTbl   $ffca  $00:no-op (null)
         fdb   CurHome-DCodeTbl  $007d  $01:HOME cursor
         fdb   CurXY-DCodeTbl  $00c9  $02:CURSOR XY
         fdb   DelLine-DCodeTbl  $0107  $03:ERASE LINE
         fdb   ErEOLine-DCodeTbl  $00f9  $04:CLEAR TO EOL
         fdb   CrsrSw-DCodeTbl  $0091  $05:CURSOR ON/OFF
         fdb   CurRght-DCodeTbl  $005e  $06:CURSOR RIGHT
         fdb   NoOp-DCodeTbl  $ffca  $07:no-op (bel:handled in CCIO)
         fdb   CurLeft-DCodeTbl  $0050  $08:CURSOR LEFT
         fdb   CurUp-DCodeTbl  $0119  $09:CURSOR UP
         fdb   CurDown-DCodeTbl  $0038  $0A:CURSOR DOWN
         fdb   ErEOScrn-DCodeTbl  $006c  $0B:ERASE TO EOS
         fdb   ClrScrn-DCodeTbl  $0070  $0C:CLEAR SCREEN
         fdb   Retrn-DCodeTbl  $001e  $0D:RETURN
         fdb   DoAlpha-DCodeTbl  $012a  $0E:DISPLAY ALPHA

* $0D - move cursor to start of line (carriage return)
Retrn    bsr   HideCrsr
         tfr   x,d
         andb  #$E0
         stb   <$22,u
ShowCrsr ldx   <$21,u		get cursor address
         lda   ,x		get char at cursor position
         sta   <$23,u		save it
         lda   <$2C,u		get cursor character
         beq   L014D		branch if none
L014B    sta   ,x		else turn on cursor
L014D    clrb  
         rts   

* $0A - cursor down (line feed)
CurDown  bsr   HideCrsr		hide cursor
         leax  <$20,x		move X down one line
         cmpx  <$1F,u		at end of screen?
         bcs   L0162		branch if not
         leax  <-$20,x		else go back up one line
         pshs  x		save X
         bsr   SScrl		and scroll the screen
         puls  x		restore pointer
L0162    stx   <$21,u		save cursor pointer
         bra   ShowCrsr		show cursor

* $08 - cursor left
CurLeft  bsr   HideCrsr		hide cursor
         cmpx  <$1D,u		compare against start of screen
         bls   L0173		ignore it if at the screen start
         leax  -$01,x		else back up one
         stx   <$21,u		save updated pointer
L0173    bra   ShowCrsr		and show cursor

* $06 - cursor right
CurRght  bsr   HideCrsr		hide cursor
         leax  $01,x		move to the right
         cmpx  <$1F,u		compare against end of screen
         bcc   L0181		if past end, ignore it
         stx   <$21,u		else save updated pointer
L0181    bra   ShowCrsr		and show cursor

* $0B - erase to end of screen
ErEOScrn bsr   HideCrsr		kill the cusror
         bra   L0189		and clear rest of the screen

* $0C - clear screen
ClrScrn  bsr   CurHome		home cursor
L0189    lda   #$60		get default char
L018B    sta   ,x+		save at location
         cmpx  <$1F,u		end of screen?
         bcs   L018B		branch if not
         bra   ShowCrsr		now show cursor

* $01 - home cursor
CurHome  bsr   HideCrsr		hide cursor
         ldx   <$1D,u		get pointer to screen
         stx   <$21,u		save as new cursor position
         bra   ShowCrsr		and show it

* Hides the cursor from the screen
* Exit: X = address of cursor
HideCrsr ldx   <$21,u		get address of cursor in X
         lda   <$23,u		get value of char under cursor
         sta   ,x		put char in place of cursor
         clrb  			must be here, in general, for [...] BRA HideCrsr
         rts   

* $05 XX - set cursor off/on/color per XX-32
CrsrSw   ldb   #$01
         leax  <L01AF,pcr	
         bra   L01E5

L01AF    lda   <$29,u		get next char
         suba  #C$SPAC		take out ASCII space
         bne   L01BB		branch if not zero
         sta   <$2C,u		else save cursor color zero (no cursor)
         bra   HideCrsr		and hide cursor
L01BB    cmpa  #$0B		greater than $0B?
         bge   L014D		yep, just ignore byte
         cmpa  #$01		is it one?
         bgt   L01C7		branch if greater
         lda   #$AF		else get default blue cursor color
         bra   L01D7		and save cursor color
L01C7    cmpa  #$02		is it two?
         bgt   L01CF		branch if larger
         lda   #$A0		else get black cursor color
         bra   L01D7		and save it
** BUG ** BUG ** BUG ** BUG
L01CF    suba  #$03		** BUG FIXED! ** !!! Was SUBB
         lsla  			shift into upper nibble
         lsla  
         lsla  
         lsla  
         ora   #$8F
L01D7    sta   <$2C,u		save new cursor
         ldx   <$21,u		get cursor address
         lbra  L014B		branch to save cursor in X

* $02 XX YY - move cursor to col XX-32, row YY-32
CurXY    ldb   #$02		we want to claim next two chars
         leax  <DoCurXY,pcr	point to processing routine
L01E5    stx   <$26,u
         stb   <$25,u
         clrb  
         rts   

DoCurXY  bsr   HideCrsr		hide cursor
         ldb   <$29,u		get ASCII Y-pos
         subb  #C$SPAC		take out ASCII space
         lda   #32		go down
         mul   			multiply it
         addb  <$28,u		add in X-pos
         adca  #$00
         subd  #C$SPAC		take out another ASCII space
         addd  <$1D,u		add top of screen address
         cmpd  <$1F,u		at end of the screen?
         lbcc  L014D		exit if off the screen
         std   <$21,u		otherwise save new cursor address
         lbra  ShowCrsr		and show cursor

* $04 - erase to end of line
ErEOLine bsr   HideCrsr		hide cursor
         tfr   x,d		move current cursor position in D
         andb  #$1F		number of characters put on this line
         pshs  b
         ldb   #32
         subb  ,s+
         bra   L0223		and clear one line

* $03 - erase line
DelLine  lbsr  Retrn		do a CR
         ldb   #32		line length
L0223    lda   #$60		get default character
         ldx   <$21,u		get cursor address
L0228    sta   ,x+		fill screen line with 'space'
         decb  			decrement
         bne   L0228		and branch if not end
         lbra  ShowCrsr		else show cursor

* $09 - cursor up
CurUp    lbsr  HideCrsr		hide cursor
         leax  <-$20,x		move X up one line
         cmpx  <$1D,u		compare against start of screen
         bcs   L023E		branch if we went beyond
         stx   <$21,u		else store updated X
L023E    lbra  ShowCrsr		and show cursor

* $0E - switch screen to alphanumeric mode
DoAlpha  clra  
         clrb  
         jmp   [<$5B,u]

* GetStat
GetStat  ldx   PD.RGS,y
         cmpa  #SS.AlfaS	$1C
         beq   Rt.AlfaS
         cmpa  #SS.Cursr	$25
         beq   Rt.Cursr

* SetStat
SetStat  comb  
         ldb   #E$UnkSvc
         rts   

* SS.AlfaS getstat
Rt.AlfaS ldd   <$1D,u
         std   $04,x
         ldd   <$21,u
         std   $06,x
         lda   <$50,u
         bra   L02BA

* SS.Cursr getstat
Rt.Cursr ldd   <$21,u
         subd  <$1D,u
         pshs  b,a
         clra  
         andb  #$1F
         addb  #$20
         std   R$X,x		save column position in ASCII
         puls  b,a		then divide by 32
         lsra  
         rolb  
         rolb  
         rolb  
         rolb  
         clra  
         andb  #$0F		only 16 line to a screen
         addb  #$20
         std   $06,x
         ldb   <$71,u
         lda   <$23,u
         bmi   L02BA
         cmpa  #$60
         bcc   L02A5
         cmpa  #$20
         bcc   L02A9
         tstb  
         beq   L02A3
         cmpa  #$00
         bne   L029B
         lda   #$5E
         bra   L02BA		save it and exit

L029B    cmpa  #$1F
         bne   L02A3
         lda   #$5F
         bra   L02BA
L02A3    ora   #$20		turn it into ASCII from vDG codes
L02A5    eora  #$40
         bra   L02BA
L02A9    tstb  
         bne   L02BA
         cmpa  #$21		remap specific codes
         bne   L02B4
         lda   #$7C
         bra   L02BA
L02B4    cmpa  #$2D
         bne   L02BA
         lda   #$7E
L02BA    sta   $01,x
         clrb  
         rts   

         emod
eom      equ   *
         end

