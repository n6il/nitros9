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

         nam   drvr51
         ttl   Driver for The 51 column by 24 line video display

* Disassembled 02/07/06 21:17:23 by Disasm v1.6 (C) 1988 by RML

         ifp1
         use   defsfile
         endc

tylg     set   Drivr+Objct   
atrv     set   ReEnt+rev
rev      set   $00
edition  set   1

         mod   eom,name,tylg,atrv,start,size

         org   0
u0000    rmb   1
u0001    rmb   1
u0002    rmb   1
u0003    rmb   1
u0004    rmb   1
u0005    rmb   1
u0006    rmb   1
u0007    rmb   1
u0008    rmb   1
u0009    rmb   1
u000A    rmb   1
u000B    rmb   1
u000C    rmb   1
u000D    rmb   1
u000E    rmb   1
u000F    rmb   8
u0017    rmb   4
u001B    rmb   2
u001D    rmb   1
u001E    rmb   1
u001F    rmb   1
u0020    rmb   2
u0022    rmb   2
u0024    rmb   1
u0025    rmb   1
u0026    rmb   1
u0027    rmb   1
u0028    rmb   1
u0029    rmb   1
u002A    rmb   1
u002B    rmb   1
u002C    rmb   1
u002D    rmb   1		SHIFT flag
u002E    rmb   1		CONTROL flag
u002F    rmb   1		SHIFTLOCK toggle
u0030    rmb   1
u0031    rmb   1
u0032    rmb   1
u0033    rmb   1
u0034    rmb   1
u0035    rmb   1
u0036    rmb   1
u0037    rmb   1
u0038    rmb   1
u0039    rmb   1
u003A    rmb   100
size     equ   .

         fcb   UPDAT.

name     fcs   /drvr51/
         fcb   edition

start    lbra  Init
         lbra  Read
         lbra  Write
         lbra  GetStat
         lbra  SetStat
         lbra  Term

Init     pshs  u,a
         ldu   <u001D,u
         ldd   #$0200
         os9   F$SRtMem
         ldu   $01,s
         tst   <u002C,u
         beq   L0044
         ldu   <u002D,u
         ldd   #$1800
         os9   F$SRtMem 
         ldu   $01,s
L0044    ldb   #$81
         leax  <u001D,u
L0049    clr   ,x+
         decb  
         bne   L0049
         ldd   #$1900
         os9   F$SRqMem 
         bcs   L009C
         tfr   u,d
         ldu   $01,s
         tfr   d,x
         bita  #$01
         beq   L0066
         leax  >$0100,x
         bra   L0068
L0066    adda  #$18
L0068    stx   <u0022,u
         tfr   d,u
         ldd   #$0100
         os9   F$SRtMem 
         ldu   $01,s
         lda   #$10
         sta   <u0037,u
         pshs  cc
         orcc  #IntMasks
         leay  >L00AD,pcr
         sty   >D.IRQ
         ldx   #$FF00
         lda   $03,x
         ora   #$01
         sta   $03,x
         inc   >InitFlag,pcr
         puls  cc
         lbsr  L0475
         lbsr  L02C3
         clrb  
L009C    puls  pc,u,a
InitFlag fcb   $00
Term     pshs  cc
         orcc  #IntMasks
         ldx   >D.AltIRQ
         stx   >D.IRQ
         puls  cc
         clrb  
         rts   
L00AD    ldu   >D.KbdSta
         ldx   #$FF00
         lda   $03,x
         bmi   L00BB
         jmp   [>D.SvcIRQ]
L00BB    lda   $02,x
         lda   >D.DskTmr
         beq   L00CB
         deca  
         sta   >D.DskTmr
         bne   L00CB
         sta   >$FF48
L00CB    lbsr  L04E5
         jmp   [>D.AltIRQ]
L00D2    pshs  x,b
         lda   u0004,u
         sta   u0005,u
         ldx   #$0000
         os9   F$Sleep  
         ldx   <D.Proc
         ldb   <$36,x
         beq   L00EC
         cmpb  #$03
         bhi   L00EC
         coma  
         puls  pc,x,a

L00EC    puls  x,b
Read     tst   >InitFlag,pcr
         bne   L00F9
         lbsr  Init
         bcs   L011C
L00F9    leax  <u003A,u
         orcc  #IRQMask
         ldb   <u001D,u
         cmpb  <u001E,u
         beq   L00D2
         lda   b,x
         incb  
         cmpb  #$64
         bcs   L010E
         clrb  
L010E    stb   <u001D,u
         andcc #^(IRQMask+Carry)
         tst   u000E,u
         beq   L011C
         clr   u000E,u
         comb  
         ldb   #E$Read		READ error
L011C    rts   

Write    tst   >InitFlag,pcr
         bne   L012C
         pshs  a
         lbsr  Init
         puls  a
         bcs   L0139
L012C    ldb   <u001F,u
         bne   L0165
         cmpa  #$1B		escape?
         bne   L013A
         inc   <u001F,u		flag ESC seq
         clrb  
L0139    rts   
L013A    cmpa  #$20
         bcs   L0144
         cmpa  #$7F
         bcc   L0144
         bra   L0173
L0144    leax  >L066E,pcr
L0148    tst   ,x
         bne   L0150
L014C    clr   <u001F,u
         rts   
L0150    cmpa  ,x+
         bne   L0161
         ldd   ,x
         leax  >L066E,pcr
         leax  d,x
         stx   <u0020,u
         jmp   ,x
L0161    leax  $02,x
         bra   L0148
L0165    inc   <u001F,u
         leax  >L0681,pcr
         cmpb  #$01
         beq   L0148
         jmp   [<u0020,u]
L0173    inc   <u0032,u
         bsr   L01B3
         tst   <u0039,u
         beq   L0185
         lda   #$F8
         leay  <-$40,y
         lbsr  L0236
L0185    lda   <u0024,u
         inca  
         cmpa  #$33
         bcs   L01A2
         clr   <u0024,u
         lda   <u0025,u
         inca  
         cmpa  #$18
         bcs   L019D
         lbsr  L033E
         bra   L01A5
L019D    sta   <u0025,u
         bra   L01A5
L01A2    sta   <u0024,u
L01A5    clr   <u0033,u
         ldd   <u0024,u
         std   <u0030,u
         dec   <u0032,u
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
         lda   <u0024,u
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
         sta   <u0026,u
         tst   <u0034,u
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
         std   <u0035,u
L01FF    ldy   <u0022,u
         lda   <u0025,u
         ldb   ,s+
         leay  d,y
         lda   #$04
         pshs  a
         inc   <u0032,u
L0211    lda   ,x
         anda  #$F0
         bsr   L0236
         lda   ,x+
         anda  #$0F
         bsr   L0227
         dec   ,s
         bne   L0211
         dec   <u0032,u
         clrb  
         puls  pc,b
L0227    ldb   <u0026,u
         subb  #$04
         bhi   L023B
         beq   L0250
L0230    lsla  
         incb  
         bne   L0230
         bra   L0250
L0236    ldb   <u0026,u
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
L0250    tst   <u0034,u
         bne   L0273
         tst   <u0038,u
         beq   L0262
         coma  
         comb  
         eora  <u0035,u
         eorb  <u0036,u
L0262    pshs  b,a
         ldd   <u0035,u
         anda  ,y
         andb  $01,y
         addd  ,s++
L026D    std   ,y
         leay  <$20,y
         rts   
L0273    eora  ,y
         eorb  $01,y
         bra   L026D

* $07 - BEL (ding!)
L0279    ldx   #$FF20
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

* $08 - BS (left arrow)
L0291    dec   <u0024,u
         bpl   L02A6
         lda   #$32
         sta   <u0024,u

* $1b44 - (cursor up)
L029B    dec   <u0025,u
         bpl   L02A6
         clr   <u0025,u
         lbsr  L035E
L02A6    lbsr  L0484
         lbra  L014C

* $0a, $1b45 - LF, (cursor down)
L02AC    lda   <u0025,u
         inca  
         cmpa  #$18
         bcs   L02B9
         lbsr  L033E
         bra   L02BC
L02B9    sta   <u0025,u
L02BC    bra   L02A6

* $0d - CR (return)
L02BE    clr   <u0024,u
         bra   L02A6

* $0c - FF (clear screen)
L02C3    ldy   <u0022,u
         leay  >$0080,y
         lda   #$18
         pshs  a
         inc   <u0032,u
L02D2    bsr   L0314
         dec   ,s
         bne   L02D2
         leas  $01,s
         clra  
         clrb  
         sta   <u0033,u
         std   <u0030,u
         std   <u0024,u
         dec   <u0032,u
         ldx   #$FF20
         lda   $02,x
         ora   #$F0
         sta   $02,x
         ldx   #$FFC0
         lda   #$06
         ldb   #$03
         bsr   L0305
         lda   <u0022,u
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
         lda   <u0038,u
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
L033E    ldy   <u0022,u
         inc   <u0032,u
         pshs  u
         leau  >$0100,y
         lda   #$10
         bsr   L037C
         puls  u
         dec   <u0031,u
L0354    leay  >$0080,y
         bsr   L0314
         dec   <u0032,u
         rts   
L035E    ldy   <u0022,u
         leay  >$17F0,y
         inc   <u0032,u
         pshs  u
         leau  >-$0100,y
         lda   #$F0
         bsr   L037C
         leay  ,u
         puls  u
         inc   <u0031,u
         bra   L0354
L037C    ldb   #$17
         pshs  b
L0380    ldb   #$10
L0382    ldx   ,u
         stx   ,y
         ldx   u0002,u
         stx   $02,y
         ldx   u0004,u
         stx   $04,y
         ldx   u0006,u
         stx   $06,y
         ldx   u0008,u
         stx   $08,y
         ldx   u000A,u
         stx   $0A,y
         ldx   u000C,u
         stx   $0C,y
         ldx   u000E,u
         stx   $0E,y
         leay  a,y
         leau  a,u
         decb  
         bne   L0382
         dec   ,s
         bne   L0380
         puls  pc,b

* $1b42 - clear to end of line
L03AF    inc   <u0032,u
         bsr   L03BA
         dec   <u0032,u
         lbra  L014C
L03BA    clr   <u0033,u
         ldb   <u0024,u
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
         lda   <u0024,u
         inca  
         sta   <u0024,u
         cmpa  #$33
         bcs   L03E3
         leas  $01,s
         bra   L040D
L03E3    dec   ,s
         bpl   L03CF
         lda   <u0024,u
         ldb   #$05
         mul   
         bitb  #$08
         bne   L03CF
         leas  $01,s
L03F3    lsrb  
         lsrb  
         lsrb  
         ldy   <u0022,u
         lda   <u0025,u
         leay  d,y
         leay  >$0080,y
         lda   #$20
         pshs  b
         suba  ,s+
         lsra  
         lbsr  L0316
L040D    puls  a
         sta   <u0024,u
         rts   

* $1b4A - clear to end of screen
L0413    inc   <u0032,u
         bsr   L03BA
         lda   #$17
         suba  <u0025,u
         bls   L042A
         pshs  a
L0421    lbsr  L0314
         dec   ,s
         bne   L0421
         leas  $01,s
L042A    dec   <u0032,u
         lbra  L014C

* $0b - (cursor home)
L0430    clr   <u0024,u
         clr   <u0025,u
         lbra  L02A6

* $1b41xxyy - move cursor to col xx (0-50) row yy (0-23)
L0439    ldb   <u001F,u
         subb  #$02
         bne   L0442
         clrb  
         rts   
L0442    decb  
         bne   L0450
         cmpa  #51
         bcs   L044B
         lda   #50
L044B    sta   <u0024,u
L044D    clrb  
         rts   
L0450    cmpa  #24
         bcs   L0456
         lda   #23
L0456    sta   <u0025,u
L0459    lbra  L02A6

* $1b43 - (cursor right)
L045C    inc   <u0024,u
         lda   <u0024,u
         cmpa  #$33
         bcs   L0459
         clr   <u0024,u
         lbra  L02AC

* $1b46 - reverse on
L046C    lda   #$FF
         coma  
L046F    sta   <u0038,u
         lbra  L014C

* $1b47 - reverse off
L0475    lda   #$FF
         bra   L046F

* $1b48 - underline on
L0479    lda   #$FF
L047B    sta   <u0039,u
         lbra  L014C

* $1b49 - underline off
L0481    clra  
         bra   L047B
L0484    ldd   <u0024,u
         inc   <u0032,u
         tst   <u0033,u
         bne   L0494
         std   <u0030,u
         bra   L04B9
L0494    pshs  b,a
         ldd   <u0030,u
         inc   <u0034,u
         tstb  
         bmi   L04AB
         cmpb  #$18
         bcc   L04AB
         std   <u0024,u
         lda   #$7F
         lbsr  L01B3
L04AB    puls  b,a
         std   <u0024,u
         std   <u0030,u
         clr   <u0033,u
         dec   <u0034,u
L04B9    dec   <u0032,u
         clrb  
         rts   

GetStat  cmpa  #$01
         bne   L04D0
         lda   <u001D,u
         cmpa  <u001E,u
         beq   L04CC
L04CA    clrb  
         rts   
L04CC    comb  
         ldb   #E$NotRdy
         rts   
L04D0    cmpa  #$06
         beq   L04CA
         cmpa  #$02
         bne   SetStat
         ldx   $06,y
         ldd   <u0022,u
         std   $04,x
         clrb  
         rts   

SetStat  comb  
         ldb   #E$UnkSvc
         rts   

L04E5    tst   <u0032,u
         bne   L0512
         dec   <u0037,u
         bne   L0512
         lda   #$10
         sta   <u0037,u
         inc   <u0034,u
         ldd   <u0024,u
         pshs  b,a
         ldd   <u0030,u
         std   <u0024,u
         lda   #$7F
         lbsr  L01B3
         puls  b,a
         std   <u0024,u
         com   <u0033,u
         dec   <u0034,u
L0512    ldx   #$FF00
         lda   #$FF
         sta   $02,x
         bsr   L053B
         anda  #$03
         bne   L0526
         clra  
         sta   $02,x		strobe all keys	
         bsr   L053B		any keys pressed?
         bne   L052D		yes, do scan
L0526    clr   <u0027,u
         clr   <u0028,u
         rts   
L052D    tst   <u0028,u
         bne   L0541
         sta   <u0028,u
L0535    clrb  
         rts   
L0537    clrb  
         stb   $02,x
         rts   
L053B    lda   ,x		read keyboard rows
         coma  
         anda  #$7F		mask off joystick row
         rts   
L0541    cmpa  <u0028,u
         bne   L0526
         clr   <u002A,u
         clr   <u002B,u
         clr   <u002C,u
         clr   <u002D,u
         clr   <u002E,u
         ldb   #$01		start kbd scan with column#0
L0557    comb  
         stb   $02,x		strobe keyboard column
         bsr   L053B		read keyboard rows
         beq   L05A1		no keys seen, do next column
         bita  #$40		is this a row 6 key?
         beq   L0583
         cmpb  #$7F		SHIFT key pressed?
         bne   L056B
         inc   <u002D,u		yes, flag SHIFT
         bra   L057F
L056B    cmpb  #$FD		CONTROL pressed? (CLEAR key)
         bne   L0574
         inc   <u002E,u		yes, flag CONTROL
         bra   L057F
L0574    tst   <u002C,u
         bne   L0537
         stb   <u002C,u
         com   <u002C,u
L057F    anda  #$3F
         beq   L05A1
L0583    pshs  b,a
         clrb  
L0586    lsra  
         bcc   L058A
         incb  
L058A    tsta  
         bne   L0586
         cmpb  #$01
         puls  b,a
         bne   L0537
         tst   <u002A,u
         bne   L0537
         sta   <u002A,u
         stb   <u002B,u
         com   <u002B,u
L05A1    comb  
         lslb  
         bne   L0557
         stb   $02,x
         ldb   <u002C,u
         beq   L05B5
         tst   <u002A,u
         bne   L0535
         lda   #$40
         bra   L05BF
L05B5    ldb   <u002B,u
         lda   <u002A,u
         lbeq  L0526
L05BF    pshs  b
         tst   <u0027,u
         beq   L05D0
         dec   <u0027,u
         beq   L05D4
         puls  b
         lbra  L0665
L05D0    ldb   #$32
         bra   L05D6
L05D4    ldb   #$05
L05D6    stb   <u0027,u
         lbsr  L0667
         lslb  
         lslb  
         lslb  
         puls  a
         pshs  b
         lbsr  L0667
         orb   ,s+
         stb   <u0029,u
         leax  >L0820,pcr	NORMAL keys
         lda   b,x
         tst   <u002E,u		CONTROL flag on?
         beq   L05FE
         leax  >L0886,pcr	CONTROL keys
         lda   b,x
         bra   L0609
L05FE    tst   <u002D,u		SHIFT flag on?
         beq   L0612
         leax  >L0853,pcr	SHIFTED keys
         lda   b,x
L0609    cmpa  #$1F		SHIFTLOCK toggle key?
         bne   L0621
         com   <u002F,u
         bra   L0665
L0612    tst   <u002F,u		SHIFTLOCK flag on?
         beq   L0621
         cmpa  #$61		less than 'a ?
         bcs   L0621
         cmpa  #$7A		more than 'z ?
         bhi   L0621
         suba  #$20		only does lower->UPPER
L0621    leax  <u003A,u
         ldb   <u001E,u
         sta   b,x
         incb  
         cmpb  #$64
         bcs   L062F
         clrb  
L062F    cmpb  <u001D,u
         bne   L0638
         inc   u000E,u
         bra   L063B
L0638    stb   <u001E,u
L063B    tsta  
         beq   L065A
         cmpa  u000D,u
L0640    bne   L064A
         ldx   u0009,u
         beq   L065A
L0646    sta   $08,x
         bra   L065A
L064A    ldb   #$03
         cmpa  u000B,u
         beq   L0656
         ldb   #$02
         cmpa  u000C,u
         bne   L065A
L0656    lda   u0003,u
         bra   L065E
L065A    ldb   #S$Wake
         lda   u0005,u
L065E    beq   L0663
         os9   F$Send   
L0663    clr   u0005,u
L0665    clrb  
         rts   
L0667    clrb  
L0668    incb  
         lsra  
         bne   L0668
         decb  
         rts   

* control characters dispatch table
L066E  fcb $07		BEL (beep)
       fdb L0279-L066E	$FC0B
       fcb $08		BS (left arrow)
       fdb L0291-L066E	$FC23
       fcb $0A		LF (down arrow)
       fdb L02AC-L066E	$FC3E
       fcb $0D		CR (return)
       fdb L02BE-L066E	$FC50
       fcb $0C		FF (clear screen)
       fdb L02C3-L066E	$FC55
       fcb $0B		(cursor home)
       fdb L0430-L066E	$FDC2
       fcb $00

* escape sequences dispatch table
L0681  fcb $41		cursor xy
       fdb L0439-L066E	$FDCB
       fcb $42		clear EOL
       fdb L03AF-L066E	$FD41
       fcb $43		cursor right
       fdb L045C-L066E	$FDEE
       fcb $44		cursor up
       fdb L029B-L066E	$FC2D
       fcb $45		cursor down
       fdb L02AC-L066E	$FC3E
       fcb $46		reverse on
       fdb L046C-L066E	$FDFE
       fcb $47		reverse off
       fdb L0475-L066E	$FE07
       fcb $48		underline on
       fdb L0479-L066E	$FE0B
       fcb $49		underline off
       fdb L0481-L066E	$FE13
       fcb $4A		clear EOS
       fdb L0413-L066E	$FDA5
       fcb $00

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

* NOTE: these tables and the keyboard matrix are in DRAGON column order!
* UNSHIFTED keytable
L0820	fcb $30,$31,$32,$33	0 1 2 3
	fcb $34,$35,$36,$37	4 5 6 7
	fcb $38,$39,$3A,$3B	8 9 : ;
	fcb $2C,$2D,$2E,$2F	, - . /
	fcb $40,$61,$62,$63	@ a b c
	fcb $64,$65,$66,$67	d e f g
	fcb $68,$69,$6A,$6B	h i j k
	fcb $6C,$6D,$6E,$6F	l m n o
	fcb $70,$71,$72,$73	p q r s
	fcb $74,$75,$76,$77	t u v w
	fcb $78,$79,$7A,$0C	x y z up
	fcb $0A,$08,$09,$20	down left right space
	fcb $0D,$00,$05		ENTER CLEAR BREAK

* SHIFTED keytable
L0853	fcb $30,$21,$22,$23	0 ! " #
	fcb $24,$25,$26,$27	$ % & '
	fcb $28,$29,$2A,$2B	( ) * +
	fcb $3C,$3D,$3E,$3F	< = > ?
	fcb $7C,$41,$42,$43	| A B C
	fcb $44,$45,$46,$47	D E F G
	fcb $48,$49,$4A,$4B	H I J K
	fcb $4C,$4D,$4E,$4F	L M N O
	fcb $50,$51,$52,$53	P Q R S
	fcb $54,$55,$56,$57	T U V W
	fcb $58,$59,$5A,$1C	X Y Z fs
	fcb $1A,$18,$19,$20	sub can em space
	fcb $0D,$00,$03		ENTER CLEAR shft-BREAK

* CONTROL keytable
L0886	fcb $1F,$7C,$00,$7E	shift-toggle | nul ~
	fcb $00,$00,$00,$5E	nul nul nul ^
	fcb $5B,$5D,$00,$00	[ ] nul nul
	fcb $7B,$5F,$7D,$5C	{ _ } \
	fcb $00,$01,$02,$03	^@ ^A ^B ^C
	fcb $04,$05,$06,$07	^D ^E ^F ^G
	fcb $08,$09,$0A,$0B	^H ^I ^J ^K
	fcb $0C,$0D,$0E,$0F	^L ^M ^N ^O
	fcb $10,$11,$12,$13	^P ^Q ^R ^S
	fcb $14,$15,$16,$17	^T ^U ^V ^W
	fcb $18,$19,$1A,$13	^X ^Y ^Z dc3
	fcb $12,$10,$11,$20	dc2 dle dc1 space
	fcb $0D,$00,$1B		ENTER CLEAR esc

         emod
eom      equ   *
         end
