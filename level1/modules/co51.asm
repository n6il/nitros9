********************************************************************
* drvr51 - Driver for The 51 column by 24 line video display
*
* $Id$
*
* Edt/Rev  YYYY/MM/DD  Modified by
* Comment
* ------------------------------------------------------------------
*   1      ????/??/??
* Original Dragon distribution version
*
*          2003/09/22  Rodney Hamilton
* Recoded fcb arrays, added labels & some comments
*
*		   2004/11/15  P.Harvey-Smith.
* Added code to turn off the drives on the Dragon Alpha.
*
*		   2004/12/01  P.Harvey-Smith.
* Began converting drvr51 to co51, removed all keyboard
* related code, added symbolic defines for a lot of things.
*
* 		   2004/12/02  P.Harvey-Smith.
* Finished converting to c051 driver, moved all variable 
* storage into ccio module (defined in cciodefs).
*


         nam   c051
         ttl   co Driver for The 51 column by 24 line video display

* Disassembled 02/07/06 21:17:23 by Disasm v1.6 (C) 1988 by RML

         ifp1
         use   defsfile.dragon
         use   cciodefs
         endc

tylg     set   Systm+Objct   
atrv     set   ReEnt+rev
rev      set   $00
edition  set   1

         mod   eom,name,tylg,atrv,start,size

;V.51EscSeq    rmb   1
;V.51CtrlDispatch    rmb   2
;V.51ScrnA    rmb   2
;V.51XPos    rmb   1		; X position of cursor
;V.51YPos    rmb   1		; Y position of cursor
;V.5126    rmb   1
;V.5130    rmb   1
;V.5131    rmb   1
;V.5132    rmb   1
;V.5133    rmb   1
;V.5134    rmb   1
;V.5135    rmb   1
;V.5136    rmb   1

;V.51ReverseFlag    rmb   1
;V.51UnderlineFlag    rmb   1
size     equ   .

         fcb   UPDAT.


ScreenSize	EQU	$1800	; Screen Size in Bytes

name     fcs   /co51/
         fcb   edition

start    lbra  Init
         lbra  Write
         lbra  GetStat
         lbra  SetStat
         lbra  Term

Init    pshs	y
	ldy	#$aa55
	puls	y
	pshs  u,a

	 ldd   #ScreenSize+$100	; Request a screenful of ram + $100 bytes
         os9   F$SRqMem 
         bcs   InitExit		; Error : exit
         tfr   u,d
         ldu   $01,s		; Restore saved u
         tfr   d,x
         bita  #$01		; Check that memory block starts at even page
         beq   L0066		; Yes base of screen = base of memory block
         leax  >$0100,x		; no Move to next page
         bra   L0068
L0066    adda  #$18
L0068    stx   V.51ScrnA,u
         tfr   d,u
         ldd   #$0100
         os9   F$SRtMem		; Return unneeded page to OS 
         ldu   $01,s
	 lbsr  DoHome		
	 lbsr  DoReverseOff
         lbsr  DoCLS
	 ldb   V.COLoad,u
         orb   #ModCo51		; set to CO51 found (?)
InitSaveExit
	 stb   V.COLoad,u
         clrb  
	 
InitExit    
	puls  pc,u,a

InitFlag fcb   $00

Term     pshs  y,x
         pshs  u		; save U
         ldd   #ScreenSize	; Graphics memory size
         ldu   V.51ScrnA,u 	; get pointer to memory
         os9   F$SRtMem 	; return to system
         puls  u		; restore U
         ldb   V.COLoad,u
         andb  #~ModCo51	; Set co51 unot loaded
         bra   InitSaveExit

* Write
* Entry: A = char to write
*        Y = path desc ptr

Write 
	pshs	y
	ldy	#$aa56
	puls	y
	
L012C    ldb   V.51EscSeq,u
         bne   L0165
         cmpa  #$1B		escape?
         bne   L013A
         inc   V.51EscSeq,u		flag ESC seq
         clrb  
L0139    rts   

L013A    cmpa  #$20
         bcs   DoCtrlChar			; Control charater ?
         cmpa  #$7F			
         bcc   DoCtrlChar			; or upper bit set	
         bra   DoNormalChar

DoCtrlChar    
	leax  >CtrlCharDispatch,pcr
L0148    tst   ,x
         bne   L0150
L014C    clr   V.51EscSeq,u
         rts   

L0150    cmpa  ,x+
         bne   L0161
         ldd   ,x
         leax  >CtrlCharDispatch,pcr
         leax  d,x
         stx   V.51CtrlDispatch,u
         jmp   ,x

L0161    leax  $02,x
         bra   L0148

L0165    inc   V.51EscSeq,u
         leax  >EscCharDispatch,pcr
         cmpb  #$01
         beq   L0148
         jmp   [V.51CtrlDispatch,u]

DoNormalChar    
         inc   V.5132,u
         bsr   L01B3
         tst   V.51UnderlineFlag,u
         beq   L0185
         lda   #$F8
         leay  <-$40,y
         lbsr  L0236

L0185    lda   V.51XPos,u
         inca  
         cmpa  #$33
         bcs   L01A2
         clr   V.51XPos,u
         lda   V.51YPos,u
         inca  
         cmpa  #$18
         bcs   L019D
         lbsr  SoScrollScreen
         bra   L01A5
L019D    sta   V.51YPos,u
         bra   L01A5
	 
L01A2    sta   V.51XPos,u
L01A5    clr   V.5133,u
         ldd   V.51XPos,u
         std   V.5130,u
         dec   V.5132,u
         clrb  
         rts   
L01B3    tfr   a,b
         subb  #$20
         clra  
         leax  >L06A0,pcr
         lslb  
         rola  
         lslb  
         rola  
         leax  d,x
         ldb   #$05
         lda   V.51XPos,u
         mul   
         pshs  b
         lsra  
         rorb  
         lsra  
         rorb  
         lsra  
         rorb  
         puls  a
         anda  #$07
         pshs  b
         sta   V.5126,u
         tst   V.5134,u
         bne   L01FF
         tfr   a,b
         lda   #$F8
         tstb  
         beq   L01FA
L01E5    lsra  
         decb  
         bhi   L01E5
         bne   L01EE
         rorb  
         bra   L01FA
L01EE    pshs  b
         ldb   #$80
L01F2    lsra  
         rorb  
         dec   ,s
         bne   L01F2
         leas  $01,s
L01FA    coma  
         comb  
         std   V.5135,u
L01FF    ldy   V.51ScrnA,u
         lda   V.51YPos,u
         ldb   ,s+
         leay  d,y
         lda   #$04
         pshs  a
         inc   V.5132,u
L0211    lda   ,x
         anda  #$F0
         bsr   L0236
         lda   ,x+
         anda  #$0F
         bsr   L0227
         dec   ,s
         bne   L0211
         dec   V.5132,u
         clrb  
         puls  pc,b

L0227    ldb   V.5126,u
         subb  #$04
         bhi   L023B
         beq   L0250
L0230    lsla  
         incb  
         bne   L0230
         bra   L0250
L0236    ldb   V.5126,u
         beq   L0250
L023B    lsra  
         decb  
         bhi   L023B
         bne   L0244
         rorb  
         bra   L0250
L0244    pshs  b
         ldb   #$80
L0248    lsra  
         rorb  
         dec   ,s
         bne   L0248
         leas  $01,s
L0250    tst   V.5134,u
         bne   L0273
         tst   V.51ReverseFlag,u
         beq   L0262
         coma  
         comb  
         eora  V.5135,u
         eorb  V.5136,u

L0262    pshs  b,a
         ldd   V.5135,u
         anda  ,y
         andb  $01,y
         addd  ,s++
L026D    std   ,y
         leay  <$20,y
         rts   
L0273    eora  ,y
         eorb  $01,y
         bra   L026D

;
; $07 - BEL (ding!)
;

DoBell    
	ldx   #$FF20
         ldb   #$64
L027E    lda   ,x
         eora  #$C0
         sta   ,x
         lda   #$19
L0286    deca  
         nop   
         nop   
         bne   L0286
         decb  
         bne   L027E
         lbra  L014C
;
; $08 - BS (left arrow)
;
DoBackspace    
	dec   V.51XPos,u
         bpl   L02A6
         lda   #$32
         sta   V.51XPos,u
;
; $1b44 - (cursor up)
;
DoCursorUp    
	dec   V.51YPos,u
         bpl   L02A6
         clr   V.51YPos,u
         lbsr  L035E
L02A6    lbsr  L0484
         lbra  L014C

;
; $0a, $1b45 - LF, (cursor down)
;

DoLineFeed    
	 lda   V.51YPos,u
         inca  
         cmpa  #$18
         bcs   L02B9
         lbsr  SoScrollScreen
         bra   L02BC
L02B9    sta   V.51YPos,u
L02BC    bra   L02A6

;
; $0d - CR (return)
;

DoCarrageReturn    
	 clr   V.51XPos,u
         bra   L02A6

;
; $0c - FF (clear screen)
;
DoCLS    ldy   V.51ScrnA,u
         leay  >$0080,y
         lda   #$18
         pshs  a
         inc   V.5132,u
L02D2    bsr   L0314
         dec   ,s
         bne   L02D2
         leas  $01,s
         clra  
         clrb  
         sta   V.5133,u
         std   V.5130,u
         std   V.51XPos,u
         dec   V.5132,u
         ldx   #$FF20
         lda   $02,x
         ora   #$F0
         sta   $02,x
         ldx   #$FFC0
         lda   #$06
         ldb   #$03
         bsr   L0305
         lda   V.51ScrnA,u
         lsra  
         ldb   #$07
         bsr   L0305
         lbra  L014C
L0305    lsra  
         bcc   L030E
         leax  $01,x
         sta   ,x+
         bra   L0310
L030E    sta   ,x++
L0310    decb  
         bne   L0305
         rts   
L0314    lda   #$10
L0316    pshs  a
         lda   V.51ReverseFlag,u
         tfr   a,b
L031D    std   <-$80,y
         std   <-$60,y
         std   <-$40,y
         std   <-$20,y
         std   <$20,y
         std   <$40,y
         std   <$60,y
         std   ,y++
         dec   ,s
         bne   L031D
         leay  >$00E0,y
         puls  pc,b

SoScrollScreen    
	 ldy   V.51ScrnA,u
         inc   V.5132,u
         pshs  u
         leau  >$0100,y
         lda   #$10
         bsr   L037C
         puls  u
         dec   V.5131,u

L0354    leay  >$0080,y
         bsr   L0314
         dec   V.5132,u
         rts   

L035E    ldy   V.51ScrnA,u
         leay  >$17F0,y
         inc   V.5132,u
         pshs  u
         leau  >-$0100,y
         lda   #$F0
         bsr   L037C
         leay  ,u
         puls  u
         inc   V.5131,u
         bra   L0354

L037C    ldb   #$17
         pshs  b
L0380    ldb   #$10

L0382    ldx   ,u
         stx   ,y
         ldx   $02,u
         stx   $02,y
         ldx   $04,u
         stx   $04,y
         ldx   $06,u
         stx   $06,y
         ldx   $08,u
         stx   $08,y
         ldx   $0A,u
         stx   $0A,y
         ldx   $0C,u
         stx   $0C,y
         ldx   $0E,u
         stx   $0E,y
         leay  a,y
         leau  a,u
         decb  
         bne   L0382
         dec   ,s
         bne   L0380
         puls  pc,b

;
; $1b42 - clear to end of line
;

DoClrEOL    
	inc   V.5132,u
         bsr   L03BA
         dec   V.5132,u
         lbra  L014C
L03BA    clr   V.5133,u
         ldb   V.51XPos,u
         pshs  b
         bitb  #$07
         bne   L03CB
         lda   #$05
         mul   
         bra   L03F3
L03CB    lda   #$01
         pshs  a
L03CF    lda   #$20
         lbsr  L01B3
         lda   V.51XPos,u
         inca  
         sta   V.51XPos,u
         cmpa  #$33
         bcs   L03E3
         leas  $01,s
         bra   L040D
L03E3    dec   ,s
         bpl   L03CF
         lda   V.51XPos,u
         ldb   #$05
         mul   
         bitb  #$08
         bne   L03CF
         leas  $01,s
L03F3    lsrb  
         lsrb  
         lsrb  
         ldy   V.51ScrnA,u
         lda   V.51YPos,u
         leay  d,y
         leay  >$0080,y
         lda   #$20
         pshs  b
         suba  ,s+
         lsra  
         lbsr  L0316
L040D    puls  a
         sta   V.51XPos,u
         rts   
;
; $1b4A - clear to end of screen
;
DoClearEOS    
	inc   V.5132,u
         bsr   L03BA
         lda   #$17
         suba  V.51YPos,u
         bls   L042A
         pshs  a
L0421    lbsr  L0314
         dec   ,s
         bne   L0421
         leas  $01,s
L042A    dec   V.5132,u
         lbra  L014C

;
;$0b - (cursor home)
;
DoHome    
	clr   V.51XPos,u
        clr   V.51YPos,u
        lbra  L02A6

;
; $1b41xxyy - move cursor to col xx (0-50) row yy (0-23)
;
DoGotoXY    
	ldb   V.51EscSeq,u
         subb  #$02
         bne   L0442
         clrb  
         rts   
L0442    decb  
         bne   L0450
         cmpa  #51
         bcs   L044B
         lda   #50
L044B    sta   V.51XPos,u
L044D    clrb  
         rts   
L0450    cmpa  #24
         bcs   L0456
         lda   #23
L0456    sta   V.51YPos,u
L0459    lbra  L02A6

;
; $1b43 - (cursor right)
;
DoCursorRight    
	inc   V.51XPos,u
         lda   V.51XPos,u
         cmpa  #$33
         bcs   L0459
         clr   V.51XPos,u
         lbra  DoLineFeed
;
; $1b46 - reverse on
;
DoReverseOn    
	lda   #$FF
         coma  
L046F    sta   V.51ReverseFlag,u
         lbra  L014C

;
; $1b47 - reverse off
;
DoReverseOff    
	lda   #$FF
         bra   L046F

;
; $1b48 - underline on
;
DoUnderlineOn    
	lda   #$FF
L047B    sta   V.51UnderlineFlag,u
         lbra  L014C

;
; $1b49 - underline off
;
DoUnderlineOff    
	clra  
         bra   L047B
	 
L0484    ldd   V.51XPos,u
         inc   V.5132,u
         tst   V.5133,u
         bne   L0494
         std   V.5130,u
         bra   L04B9
	 
L0494    pshs  b,a
         ldd   V.5130,u
         inc   V.5134,u
         tstb  
         bmi   L04AB
         cmpb  #$18
         bcc   L04AB
         std   V.51XPos,u
         lda   #$7F
         lbsr  L01B3

L04AB    puls  b,a
         std   V.51XPos,u
         std   V.5130,u
         clr   V.5133,u
         dec   V.5134,u
L04B9    dec   V.5132,u
         clrb  
         rts   


L04CA    clrb  
         rts   
GetStat  
	 cmpa  #$06
         beq   L04CA
         cmpa  #$02
         bne   SetStat
         ldx   $06,y
         ldd   V.51ScrnA,u
         std   $04,x
         clrb  
         rts   

SetStat  comb  
         ldb   #E$UnkSvc
         rts   


* control characters dispatch table
CtrlCharDispatch  
	fcb 	$07		BEL 		; (beep)
	fdb 	DoBell-CtrlCharDispatch	$FC0B
        fcb 	$08		BS 		; (left arrow)
        fdb 	DoBackspace-CtrlCharDispatch	; $FC23
        fcb 	$0A		LF 		; (down arrow)
        fdb 	DoLineFeed-CtrlCharDispatch	; $FC3E
        fcb 	$0D		CR 		; (return)
        fdb 	DoCarrageReturn-CtrlCharDispatch	;$FC50
        fcb 	$0C		FF 		; (clear screen)
        fdb 	DoCLS-CtrlCharDispatch	$FC55
        fcb 	$0B				; (cursor home)
        fdb 	DoHome-CtrlCharDispatch	$FDC2
        fcb 	$00

* escape sequences dispatch table
EscCharDispatch  
	fcb 	$41				; cursor xy
        fdb 	DoGotoXY-CtrlCharDispatch	; $FDCB
        fcb 	$42				; clear EOL
        fdb 	DoClrEOL-CtrlCharDispatch	; $FD41
        fcb 	$43				; cursor right
        fdb 	DoCursorRight-CtrlCharDispatch	; $FDEE
        fcb 	$44				; cursor up
        fdb 	DoCursorUp-CtrlCharDispatch	; $FC2D
        fcb 	$45				; cursor down
        fdb 	DoLineFeed-CtrlCharDispatch	; $FC3E
        fcb 	$46				; reverse on
        fdb 	DoReverseOn-CtrlCharDispatch	; $FDFE
        fcb 	$47				; reverse off
        fdb 	DoReverseOff-CtrlCharDispatch	; $FE07
        fcb 	$48				; underline on
        fdb 	DoUnderlineOn-CtrlCharDispatch	; $FE0B
        fcb 	$49				; underline off
        fdb 	DoUnderlineOff-CtrlCharDispatch	; $FE13
        fcb 	$4A				; clear EOS
        fdb 	DoClearEOS-CtrlCharDispatch	; $FDA5
        fcb 	$00

L06A0
* 4x8 bitmap table for characters $20-$7f
* each nibble represents a row of 4 dots
* chars 20-27
	fcb $00,$00,$00,$00  ....  .@..  .@.@  .@@.  ..@.  @..@  .@..  .@..
	fcb $44,$40,$40,$00  ....  .@..  .@.@  @@@@  .@@@  ...@  @.@.  .@..
	fcb $55,$00,$00,$00  ....  .@..  ....  .@@.  @...  ..@.  .@..  ....
	fcb $6F,$6F,$60,$00  ....  ....  ....  @@@@  .@@.  .@..  @.@.  ....
	fcb $27,$86,$1E,$20  ....  .@..  ....  .@@.  ...@  @...  @@.@  ....
	fcb $91,$24,$89,$00  ....  ....  ....  ....  @@@.  @..@  ....  ....
	fcb $4A,$4A,$D0,$00  ....  ....  ....  ....  ..@.  ....  ....  ....
	fcb $44,$00,$00,$00  ....  ....  ....  ....  ....  ....  ....  ....
* chars 29-2f
	fcb $24,$44,$20,$00  ..@.  .@..  @..@  .@..  ....  ....  ....  ....
	fcb $42,$22,$40,$00  .@..  ..@.  .@@.  .@..  ....  ....  ....  ...@
	fcb $96,$F6,$90,$00  .@..  ..@.  @@@@  @@@.  ....  @@@@  ....  ..@.
	fcb $44,$E4,$40,$00  .@..  ..@.  .@@.  .@..  ..@.  ....  .@@.  .@..
	fcb $00,$02,$24,$00  ..@.  .@..  @..@  .@..  ..@.  ....  .@@.  @...
	fcb $00,$F0,$00,$00  ....  ....  ....  ....  .@..  ....  ....  ....
	fcb $00,$06,$60,$00  ....  ....  ....  ....  ....  ....  ....  ....
	fcb $01,$24,$80,$00  ....  ....  ....  ....  ....  ....  ....  ....
* chars 30-37
	fcb $69,$BD,$60,$00  .@@.  ..@.  .@@.  @@@.  ..@.  @@@@  .@@@  @@@@
	fcb $26,$22,$70,$00  @..@  .@@.  @..@  ...@  .@@.  @...  @...  ...@
	fcb $69,$2C,$F0,$00  @.@@  ..@.  ..@.  .@@.  @.@.  @@@.  @@@.  ..@.
	fcb $E1,$61,$E0,$00  @@.@  ..@.  @@..  ...@  @@@@  ...@  @..@  .@..
	fcb $26,$AF,$20,$00  .@@.  .@@@  @@@@  @@@.  ..@.  @@@.  .@@.  .@..
	fcb $F8,$E1,$E0,$00  ....  ....  ....  ....  ....  ....  ....  ....
	fcb $78,$E9,$60,$00  ....  ....  ....  ....  ....  ....  ....  ....
	fcb $F1,$24,$40,$00  ....  ....  ....  ....  ....  ....  ....  ....
* chars 38-3f
	fcb $69,$69,$60,$00  .@@.  .@@.  ....  ....  ..@.  ....  .@..  .@@.
	fcb $69,$71,$60,$00  @..@  @..@  ....  ....  .@..  @@@@  ..@.  @..@
	fcb $00,$40,$40,$00  .@@.  .@@@  .@..  ..@.  @...  ....  ...@  ..@.
	fcb $00,$20,$24,$00  @..@  ...@  ....  ....  .@..  @@@@  ..@.  ..@.
	fcb $24,$84,$20,$00  .@@.  .@@.  .@..  ..@.  ..@.  ....  .@..  ....
	fcb $0F,$0F,$00,$00  ....  ....  ....  .@..  ....  ....  ....  ..@.
	fcb $42,$12,$40,$00  ....  ....  ....  ....  ....  ....  ....  ....
	fcb $69,$22,$02,$00  ....  ....  ....  ....  ....  ....  ....  ....
* chars 40-47
	fcb $69,$BB,$87,$00  .@@.  .@@.  @@@.  .@@@  @@@.  @@@@  @@@@  .@@@
	fcb $69,$F9,$90,$00  @..@  @..@  @..@  @...  @..@  @...  @...  @...
	fcb $E9,$E9,$E0,$00  @.@@  @@@@  @@@.  @...  @..@  @@@.  @@@.  @.@@
	fcb $78,$88,$70,$00  @.@@  @..@  @..@  @...  @..@  @...  @...  @..@
	fcb $E9,$99,$E0,$00  @...  @..@  @@@.  .@@@  @@@.  @@@@  @...  .@@@
	fcb $F8,$E8,$F0,$00  .@@@  ....  ....  ....  ....  ....  ....  ....
	fcb $F8,$E8,$80,$00  ....  ....  ....  ....  ....  ....  ....  ....
	fcb $78,$B9,$70,$00  ....  ....  ....  ....  ....  ....  ....  ....
* chars 48-4f
	fcb $99,$F9,$90,$00  @..@  @@@.  @@@@  @..@  @...  @@@@  @..@  .@@.
	fcb $E4,$44,$E0,$00  @..@  .@..  ..@.  @.@.  @...  @@.@  @@.@  @..@
	fcb $F2,$2A,$40,$00  @@@@  .@..  ..@.  @@..  @...  @@.@  @.@@  @..@
	fcb $9A,$CA,$90,$00  @..@  .@..  @.@.  @.@.  @...  @..@  @..@  @..@
	fcb $88,$88,$F0,$00  @..@  @@@.  .@..  @..@  @@@@  @..@  @..@  .@@.
	fcb $FD,$D9,$90,$00  ....  ....  ....  ....  ....  ....  ....  ....
	fcb $9D,$B9,$90,$00  ....  ....  ....  ....  ....  ....  ....  ....
	fcb $69,$99,$60,$00  ....  ....  ....  ....  ....  ....  ....  ....
* chars 50-57
	fcb $E9,$E8,$80,$00  @@@.  .@@.  @@@.  .@@@  @@@.  @..@  @..@  @..@
	fcb $69,$9B,$70,$00  @..@  @..@  @..@  @...  .@..  @..@  @..@  @..@
	fcb $E9,$EA,$90,$00  @@@.  @..@  @@@.  .@@.  .@..  @..@  @..@  @@.@
	fcb $78,$61,$E0,$00  @...  @.@@  @.@.  ...@  .@..  @..@  .@@.  @@.@
	fcb $E4,$44,$40,$00  @...  .@@@  @..@  @@@.  .@..  .@@.  .@@.  @@@@
	fcb $99,$99,$60,$00  ....  ....  ....  ....  ....  ....  ....  ....
	fcb $99,$96,$60,$00  ....  ....  ....  ....  ....  ....  ....  ....
	fcb $99,$DD,$F0,$00  ....  ....  ....  ....  ....  ....  ....  ....
* chars 58-5f
	fcb $99,$69,$90,$00  @..@  @..@  @@@@  @@@.  ....  .@@@  .@@.  ....
	fcb $99,$71,$E0,$00  @..@  @..@  ...@  @...  @...  ...@  @..@  ....
	fcb $F1,$68,$F0,$00  .@@.  .@@@  .@@.  @...  .@..  ...@  ....  ....
	fcb $E8,$88,$E0,$00  @..@  ...@  @...  @...  ..@.  ...@  ....  ....
	fcb $08,$42,$10,$00  @..@  @@@.  @@@@  @@@.  ...@  .@@@  ....  ....
	fcb $71,$11,$70,$00  ....  ....  ....  ....  ....  ....  ....  @@@@
	fcb $69,$00,$00,$00  ....  ....  ....  ....  ....  ....  ....  ....
	fcb $00,$00,$0F,$00  ....  ....  ....  ....  ....  ....  ....  ....
* chars 60-67
	fcb $22,$00,$00,$00  ..@.  ....  @...  ....  ...@  ....  ..@@  ....
	fcb $07,$99,$70,$00  ..@.  .@@@  @@@.  .@@@  .@@@  .@@@  .@..  .@@.
	fcb $8E,$99,$E0,$00  ....  @..@  @..@  @...  @..@  @.@.  @@@@  @..@
	fcb $07,$88,$70,$00  ....  @..@  @..@  @...  @..@  @@..  .@..  @..@
	fcb $17,$99,$70,$00  ....  .@@@  @@@.  .@@@  .@@@  .@@@  .@..  .@@@
	fcb $07,$AC,$70,$00  ....  ....  ....  ....  ....  ....  ....  ...@
	fcb $34,$F4,$40,$00  ....  ....  ....  ....  ....  ....  ....  @@@.
	fcb $06,$99,$71,$E0  ....  ....  ....  ....  ....  ....  ....  ....
* chars 68-6f
	fcb $8E,$99,$90,$00  @...  .@..  ..@.  @...  .@..  ....  ....  ....
	fcb $40,$44,$40,$00  @@@.  ....  ....  @.@.  .@..  .@@@  .@@@  .@@.
	fcb $20,$22,$22,$C0  @..@  .@..  ..@.  @@..  .@..  @@.@  @..@  @..@
	fcb $8A,$CA,$90,$00  @..@  .@..  ..@.  @.@.  .@..  @@.@  @..@  @..@
	fcb $44,$44,$40,$00  @..@  .@..  ..@.  @..@  .@..  @..@  @..@  .@@.
	fcb $0E,$DD,$90,$00  ....  ....  ..@.  ....  ....  ....  ....  ....
	fcb $0E,$99,$90,$00  ....  ....  @@..  ....  ....  ....  ....  ....
	fcb $06,$99,$60,$00  ....  ....  ....  ....  ....  ....  ....  ....
* chars 70-77
	fcb $0E,$99,$E8,$80  ....  ....  ....  ....  .@..  ....  ....  ....
	fcb $07,$99,$71,$10  @@@.  .@@@  .@@@  .@@@  @@@@  @..@  @..@  @..@
	fcb $07,$88,$80,$00  @..@  @..@  @...  @@..  .@..  @..@  @..@  @@.@
	fcb $07,$C3,$E0,$00  @..@  @..@  @...  ..@@  .@..  @..@  .@@.  @@.@
	fcb $4F,$44,$30,$00  @@@.  .@@@  @...  @@@.  ..@@  .@@@  .@@.  .@@.
	fcb $09,$99,$70,$00  @...  ...@  ....  ....  ....  ....  ....  ....
	fcb $09,$96,$60,$00  @...  ...@  ....  ....  ....  ....  ....  ....
	fcb $09,$DD,$60,$00  ....  ....  ....  ....  ....  ....  ....  ....
* chars 78-7f
	fcb $09,$66,$90,$00  ....  ....  ....  ..@@  .@..  @@..  ....  @@@@
	fcb $09,$99,$71,$E0  @..@  @..@  @@@@  .@..  .@..  ..@.  .@.@  @@@@
	fcb $0F,$24,$F0,$00  .@@.  @..@  ..@.  @@..  ....  ..@@  @.@.  @@@@
	fcb $34,$C4,$30,$00  .@@.  @..@  .@..  .@..  .@..  ..@.  ....  @@@@
	fcb $44,$04,$40,$00  @..@  .@@@  @@@@  ..@@  .@..  @@..  ....  @@@@
	fcb $C2,$32,$C0,$00  ....  ...@  ....  ....  ....  ....  ....  @@@@
	fcb $05,$A0,$00,$00  ....  @@@.  ....  ....  ....  ....  ....  @@@@
	fcb $FF,$FF,$FF,$F0  ....  ....  ....  ....  ....  ....  ....  ....

         emod
eom      equ   *
         end
