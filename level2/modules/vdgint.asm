********************************************************************
* VDGInt - CoCo 3 VDG I/O module
*
* $Id$
*
* Ed.    Comments                                       Who YY/MM/DD
* ------------------------------------------------------------------

         nam   VDGInt
         ttl   CoCo 3 VDG I/O module

* Disassembled 98/09/31 12:15:57 by Disasm v1.6 (C) 1988 by RML

         ifp1
         use   defsfile
         use   vdgdefs
         endc

tylg     set   Systm+Objct   
atrv     set   ReEnt+rev
rev      set   $01
edition  set   3

         mod   eom,name,tylg,atrv,start,size

u0000    rmb   0
size     equ   .

         fcb   $07 

name     fcs   /VDGInt/
         fcb   edition

start    lbra  Read		actually more like INIZ...
         lbra  Write
         lbra  GetStat
         lbra  SetStat
         lbra  Term 

         cmpa  #$00
         bne   L0035
         ldb   <VD.DGBuf,u	get number of currently displayed bufs
         lbne  ShowS
         ldd   <VD.TFlg1,u
         lbra  DAlfa2

L0035    cmpa  #$01		set x,y size of window?
         beq   L003B
         clrb  			no errors
         rts   

L003B    ldx   <D.CCMem		pointer to start of CC memory
         leax  <$54,x		to X,Y coor, X,Y window
         IFNE  H6309
         ldq   ,x
         stq   $04,x		get X,Y coordinate
         ELSE
         ldd   ,x
         std   $04,x
         ldd   $02,x
         std   $06,x
         ENDC
         clrb  
         rts   

* Terminate device
Term     pshs  u,y,x
         ldb   #$03
L004E    pshs  b
         lbsr  GetScrn
         lbsr  L065B
         puls  b
         decb  
         bne   L004E
         clr   <VD.Start,u
         ldd   #$0200
         ldu   <VD.SCrnA,u	return VDG text screen memory
         beq   L0069
         os9   F$SRtMem 
L0069    ldb   #$E1		size of 1 page -$1D (SCF memory requirements)
         leax  <VD.Strt1,u
         clra  
L006F    sta   ,x+		set stored byte to zero
         decb  
         bne   L006F
         bra   L00D5

* Read bytes from IN
* Actually, this is more like an INIZ of the device.
Read     pshs  u,y,x
         bsr   L00D8		set up palettes
         lda   #$AF
         sta   <VD.CColr,u	default color cursor
         pshs  u
         ldd   #768		gets 1 page on an odd page boundary
         os9   F$SRqMem 	request from top of sys ram
         tfr   u,d
         tfr   u,x
         bita  #$01
         beq   L0095
         leax  >$0100,x
         bra   L0099
L0095    leau  >$0200,u		we only need 2 pages for the screen memory
L0099    ldd   #256		1 page return
         os9   F$SRtMem 	return system memory
         puls  u
         stx   <VD.ScrnA,u	save start address of the screen
         stx   <VD.CrsrA,u	and start cursor position
         leax  >$0200,x
         stx   <VD.ScrnE,u	point to the end of the screen
         lda   #$60
         sta   <VD.CChar,u	character under the cursor
         sta   <VD.Chr1,u
         lbsr  ClrScn
         inc   <VD.Start,u
         ldd   <VD.Strt1,u
         lbsr  L054C		set to true lowercase, screen size
         leax  <VD.NChar,u
         stx   <VD.EPlt1,u	where to get next character from
         stx   <VD.EPlt2,u
         ldu   <D.CCMem
         ldb   <$24,u
         orb   #$02		set to VDGINT found
         stb   <$24,u
L00D5    clrb  
         puls  pc,u,y,x

L00D8    pshs  u,y,x,b,a
         lda   #$08
         sta   <VD.PlFlg,u
         leax  >L011A,pcr	default palette
         leay  <VD.Palet,u
L00E6    leau  >L00F8,pcr	CMP to RGB conversion
L00EA    pshs  u
         leau  >L012A,pcr
         ldb   #16
L00F2    lda   ,x+
         jmp   [,s]
L00F6    lda   a,u		remap to CMP values
L00F8    sta   ,y+		and save RGB data
         decb  
         bne   L00F2
         leas  $02,s
L00FF    puls  pc,u,y,x,b,a

L0101    pshs  u,y,x,b,a	puts palette data in.
         lda   >WGlobal+G.CrDvFl		is this screen active?
         beq   L00FF		0 = not active
         leax  <VD.Palet,u
         ldy   #$FFB0
         lda   >WGlobal+G.MonTyp		universal RGB/CMP 0 = CMP, 1 = RGB, 2 = MONO
         bne   L00E6		if not 0 (CMP) don't re-map colors
         leau  >L00F6,pcr	else do re-map colors
         bra   L00EA

L011A    fcb   $12,$36,$09,$24	default palette data
         fcb   $3f,$1b,$2d,$26
         fcb   $00,$12,$00,$3f
         fcb   $00,$12,$00,$26

* converts CMP to RGB
L012A    fdb   $000c,$020e,$0709,$0510
         fdb   $1c2c,$0d1d,$0b1b,$0a2b
         fdb   $2211,$1221,$0301,$1332
         fdb   $1e2d,$1f2e,$0f3c,$2f3d
         fdb   $1708,$1506,$2716,$2636
         fdb   $192a,$1a3a,$1829,$2838
         fdb   $1404,$2333,$2535,$2434
         fdb   $203B,$313E,$3739,$3F30

* Entry: A = char to write
*        Y = path desc ptr
Write    cmpa  #$0E
         bls   L01CF
         cmpa  #$1B		escape code?
         lbeq  Escpe		yes, do escape immediately
         cmpa  #$1F
         lbls  L01CD		ignore gfx codes if not CoCo 2 compatible

         tsta  
         bmi   L01BA
         ldb   <VD.CFlag,u
         beq   L019A
         cmpa  #$5E
         bne   L018A		re-map characters from ASCII-VDG
         lda   #$00
         bra   L01BA
L018A    cmpa  #$5F
         bne   L0192
         lda   #$1F
         bra   L01BA
L0192    cmpa  #$60
         bne   L01AA
         lda   #$67
         bra   L01BA

L019A    cmpa  #$7C		true lowercase
         bne   L01A2
         lda   #$21
         bra   L01BA
L01A2    cmpa  #$7E
         bne   L01AA
         lda   #$2D
         bra   L01BA
L01AA    cmpa  #$60
         bcs   L01B2		re-map ASCII
         suba  #$60
         bra   L01BA
L01B2    cmpa  #$40
         bcs   L01B8
         suba  #$40
L01B8    eora  #$40
L01BA    ldx   <VD.CrsrA,u
         sta   ,x+
         stx   <VD.CrsrA,u
         cmpx  <VD.ScrnE,u
         bcs   L01CA
         lbsr  SScrl		if at end of screen, scroll it
L01CA    lbsr  PCrsr		ends with a CLRB/RTS anyhow
L01CD    clrb  
         rts   

L01CF    leax  >L01D8,pcr
         lsla  
         ldd   a,x
         jmp   d,x

L01D8    fdb   L01CD-L01D8
         fdb   CHome-L01D8
         fdb   CrsrXY-L01D8
         fdb   TELin-L01D8
         fdb   CELin-L01D8
         fdb   COnOf-L01D8
         fdb   CRght-L01D8
         fdb   L01CD-L01D8
         fdb   CLeft-L01D8
         fdb   L036A-L01D8
         fdb   CDown-L01D8
         fdb   TEScn-L01D8
         fdb   ClrScn-L01D8
         fdb   Retrn-L01D8
         fdb   DAlfa-L01D8
         fdb   $53c6
         fdb   $F539

* $1B does palette changes
Escpe    ldx   <VD.EPlt1,u	now X points to VD.NChar
         lda   ,x
         cmpa  #$30		default color
         bne   L0209
         lbsr  L00D8		do default palette
         lbra  L026E		put palette and exit

L0209    cmpa  #$31		change palette
         lbeq  L0258
         cmpa  #$21
         lbne  L01CD		return without error
         ldx   PD.RGS,y
         lda   R$A,x
         ldx   <D.Proc
         cmpa  >P$SelP,x
         beq   L0249
         ldb   >P$SelP,x
         sta   >P$SelP,x
         pshs  y		save our path desc ptr
         bsr   L024A
         ldy   V$STAT,y
         ldx   <D.CCMem
         cmpy  <$20,x
         puls  y		restore our path desc ptr
         bne   L0248
         inc   <VD.DFlag,u
         ldy   <$20,x
         sty   <$22,x
         stu   <$20,x
L0248    clrb  
L0249    rts   

L024A    leax  <P$Path,x
         lda   b,x
         ldx   <D.PthDBT
         os9   F$Find64 	put found path descriptor in Y
         ldy   PD.DEV,y		load Y with device table entry
         rts   

L0258    leax  <L0260,pcr
         ldb   #$02
         lbra  GChar
L0260    ldx   <VD.EPlt1,u
         ldd   ,x
         anda  #$0F
         andb  #$3F
         leax  <VD.Palet,u
         stb   a,x
L026E    inc   <VD.DFlag,u
         clrb  
         rts   

* Screen scroll
SScrl    ldx   <VD.SCrnA,u
         leax  <32,x
L0279    ldd   ,x++
         std   <-34,x
         cmpx  <VD.ScrnE,u
         bcs   L0279
         leax  <-32,x
         stx   <VD.CrsrA,u
         lda   #32
         ldb   #$60
L028D    stb   ,x+
         deca  
         bne   L028D
         rts   

* $0D carriage return
Retrn    bsr   KCrsr
         tfr   x,d
         andb  #$E0
         stb   <VD.CrsAL,u
PCrsr    ldx   <VD.CrsrA,u
         lda   ,x
         sta   <VD.CChar,u
         lda   <VD.CColr,u
         beq   L02AB
L02A9    sta   ,x
L02AB    clrb  
         rts   

* $0A moves cursor down
CDown    bsr   KCrsr
         leax  <32,x		go down one line
         cmpx  <VD.SCrnE,u	at the end of the screen?
         bcs   L02C1
         leax  <-32,x		if so, go back up one line
         pshs  x
         lbsr  SScrl		and scroll the screen
         puls  x
L02C1    stx   <VD.CRsrA,u
         bra   PCrsr

* $08 moves cursor left one
CLeft    bsr   KCrsr
         cmpx  <VD.SCrnA,u
         bls   L02D2		ignore it if at the screen start
         leax  -$01,x
         stx   <VD.CRsrA,u
L02D2    bra   PCrsr

* $06 moves cursor right one
CRght    bsr   KCrsr
         leax  $01,x		to right one
         cmpx  <VD.SCrnE,u
         bcc   L02E0		if past end, ignore it
         stx   <VD.CRsrA,u
L02E0    bra   PCrsr

* $0B erase from current char to end of screen
TEScn    bsr   KCrsr		kill the cursor
         bra   L02E8		and clear the rest of the screen

* $0C clear screen & home cursor
ClrScn   bsr   CHome		home cursor
L02E8    lda   #$60
L02EA    sta   ,x+
         cmpx  <VD.SCrnE,u
         bcs   L02EA
         bra   PCrsr

* $01 Homes the cursor
CHome    bsr   KCrsr
         ldx   <VD.SCrnA,u
         stx   <VD.CRsrA,u
         bra   PCrsr

* Kill the cursor from the screen
KCrsr    ldx   <VD.CRsrA,u
         lda   <VD.CChar,u
         sta   ,x
         clrb  			must be here, in general, for [...] BRA KCrsr
         rts   

* $05 turns cursor on/off, color
COnOf    lda   <VD.NChar,u
         suba  #C$SPAC		take out ASCII space
         bne   L0313
         sta   <VD.CColr,u
         bra   KCrsr
L0313    cmpa  #$0B		sets up cursor color
         bge   L02AB
         cmpa  #$01
         bgt   L031F
         lda   #$AF
         bra   L032F
L031F    cmpa  #$02
         bgt   L0327
         lda   #$A0
         bra   L032F
** BUG ** BUG ** BUG ** BUG
L0327    subb  #$03		** BUG **  !!! Should be SUBA
         lsla  			left in for backwards compatibility
         lsla  
         lsla  
         lsla  
         ora   #$8F
L032F    sta   <VD.CColr,u
         ldx   <VD.CrsrA,u
         lbra  L02A9

* $02 moves cursor to X,Y
CrsrXY   ldb   #$02
         leax  <L0340,pcr	goto there after
         lbra  GChar		get two chars
L0340    bsr   KCrsr
         ldb   <VD.NChr2,u	get ASCII Y-pos
         subb  #C$SPAC		take out ASCII space
         lda   #32		go down
         mul   
         addb  <VD.NChar,u	add in X-pos
         adca  #$00
         subd  #C$SPAC		take out another ASCII space
         addd  <VD.ScrnA,u
         cmpd  <VD.ScrnE,u	at end of the screen?
         lbcc  L02AB		exit if off the screen
         std   <VD.CRsrA,u	otherwise save new cursor address
         lbra  PCrsr

* $04 clear characters to end of line
CELin    bsr   KCrsr
         tfr   x,d
         andb  #$1F		number of characters put on this line
         pshs  b
         ldb   #32
         subb  ,s+
         bra   L0376		and clear one line

* $03 erase line cursor is on
TELin    lbsr  Retrn		do a carriage return
         ldb   #32		B = $00 from Retrn
L0376    lda   #$60
         ldx   <VD.CRsrA,u
L037B    sta   ,x+
         decb  
         bne   L037B
         lbra  PCrsr

* $09 moves cursor up one line
L036A    lbsr  KCrsr
         leax  <-32,x
         cmpx  <VD.SCrnA,u
         bcs   L0391
         stx   <VD.CRsrA,u
L0391    lbra  PCrsr

* $0E switches from graphics to alpha mode
DAlfa    clra  
         clrb  
DAlfa2   pshs  x,a
         stb   <VD.Alpha,u
         clr   <VD.DGBuf,u
         lda   >PIA1Base+2
         anda  #$07
         ora   ,s+
         tstb  
         bne   L03AD
         anda  #$EF
         ora   <VD.CFlag,u	lowercase flag
L03AD    sta   <VD.TFlg1,u	save VDG info
         tst   >WGlobal+G.CrDvFl		is this screen currently showing?
         lbeq  L0440
         sta   >PIA1Base+2
         tstb  
         bne   L03CB
         stb   >$FFC0
         stb   >$FFC2
         stb   >$FFC4
         lda   <VD.ScrnA,u
         bra   L03D7
L03CB    stb   >$FFC0
         stb   >$FFC3
         stb   >$FFC5
         lda   <VD.SBAdd,u
L03D7    lbsr  L0101
         ldb   <D.HINIT
         orb   #$80		set CoCo 2 compatible mode
         stb   <D.HINIT
         stb   >$FF90
         ldb   <D.VIDMD
         andb  #$78
         stb   >$FF98
         stb   <D.VIDMD
         clrb  
         stb   >$FF99
         stb   <D.VIDRS
         stb   >BordReg
         stb   <D.BORDR
         tfr   a,b
         andb  #$1F
         pshs  b
         anda  #$E0
         lsra  
         lsra  
         lsra  
         lsra  
         ldx   <D.SysDAT
         leax  a,x
         ldb   $01,x
         pshs  b
         andb  #$38
         lslb  
         lslb  
         stb   <D.VOFF1
         stb   >$FF9D
         clrb  
         stb   <D.VOFF0
         stb   >$FF9E
         ldb   #$0F
         stb   <D.VOFF2
         stb   >$FF9C
         puls  a
         lsla  
         lsla  
         lsla  
         lsla  
         lsla  
         ora   ,s+
         ldb   #$07
         ldx   #$FFC6		Ok, now set up via old coco2 mode
         lsra  
L0430    lsra  
         bcs   L0439
         sta   ,x+
         leax  $01,x
         bra   L043D
L0439    leax  $01,x
         sta   ,x+
L043D    decb  
         bne   L0430
L0440    clrb  
         puls  pc,x

         pshs  x,b,a
         clra  
         ldb   $02,s
         ldx   <D.SysMem
         leax  d,x
         puls  b,a
L044E    sta   ,x+
         decb  
         bne   L044E
         puls  pc,x

         ldb   #$01
GChar    stb   <VD.NGChr,u
         stx   <VD.RTAdd,u
         clrb  
         rts   

GetStat  ldx   PD.RGS,y
         cmpa  #SS.AlfaS
         beq   RT.AlfaS
         cmpa  #SS.ScSiz
         beq   Rt.ScSiz
         cmpa  #SS.Cursr
         beq   Rt.Cursr
         cmpa  #SS.Palet
         lbeq  Rt.Palet
         comb  
         ldb   #E$UnkSvc
         rts   

* Returns window or screen size
Rt.ScSiz clra  
         ldb   <$42,u
         std   R$X,x
         ldb   <$43,u
         std   R$Y,x
         clrb  
         rts   

* Get palette information
Rt.Palet pshs  u,y,x
         leay  <VD.Palet,u	point to palette data in proc desc
         ldu   R$X,x		pointer to 16 byte palette buffer
         ldx   <D.Proc		current proc desc
         ldb   P$Task,x		destination task number
         clra 			from task 0 
         tfr   y,x
         ldy   #16		move 16 bytes
         os9   F$Move   
         puls  pc,u,y,x

* Return VDG alpha screen memory info
RT.AlfaS ldd   <VD.ScrnA,u
         anda  #$E0		keep bits 4-6
         lsra  
         lsra  
         lsra  
         lsra  			move to bits 0-2
         ldy   <D.SysDAT
         ldd   a,y
         lbsr  L06E1		map it in the process' memory area
         bcs   L0521
         pshs  b,a		offset to block address
         ldd   <VD.ScrnA,u
         anda  #$1F		make sure it's within the block
         addd  ,s
         std   R$X,x		memory address of the buffer
         ldd   <VD.CrsrA,u
         anda  #$1F
         addd  ,s++
         std   R$Y,x		memory address of the cursor
         lda   <VD.Caps,u	save caps lock status in A and exit
         bra   L051E

* Returns VDG alpha screen cursor info
Rt.Cursr ldd   <VD.CrsrA,u
         subd  <VD.ScrnA,u
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
         andb  #$0F		only 16 lines to a screen
         addb  #$20
         std   R$Y,x
         ldb   <VD.CFlag,u
         lda   <VD.CChar,u
         bmi   L051E
         cmpa  #$60
         bcc   L0509
         cmpa  #$20
         bcc   L050D
         tstb  
         beq   L0507
         cmpa  #$00
         bne   L04FF
         lda   #$5E
         bra   L051E		save it and exit

L04FF    cmpa  #$1F
         bne   L0507
         lda   #$5F
         bra   L051E
L0507    ora   #$20		turn it into ASCII from VDG codes
L0509    eora  #$40
         bra   L051E
L050D    tstb  
         bne   L051E
         cmpa  #$21		remap specific codes
         bne   L0518
         lda   #$7C
         bra   L051E
L0518    cmpa  #$2D
         bne   L051E
         lda   #$7E
L051E    sta   R$A,x
         clrb  
L0521    rts   

SetStat  ldx   PD.RGS,y
         cmpa  #SS.ComSt
         beq   Rt.ComSt
         cmpa  #$8F
         lbeq  RT.XScrn
         cmpa  #SS.DScrn
         lbeq  Rt.DScrn
         cmpa  #SS.PScrn
         lbeq  Rt.PScrn
         cmpa  #SS.AScrn
         lbeq  RT.AScrn
         cmpa  #SS.FScrn
         lbeq  Rt.FScrn
         comb  
         ldb   #$D0
         rts   

* Allow switch between true/fake lowercase
Rt.ComSt ldd   R$Y,x
L054C    ldb   #$10		sets screen to lowercase
         bita  #$01		Y = 0 = true lowercase, Y = 1 = fake lower
         bne   L0553
         clrb  
L0553    stb   <$35,u
         ldd   #$2010		32x16
         inc   <$23,u
         std   <$42,u
         rts   

DTabl    fcb   $14	0: 640x192, 2 color
         fcb   $02
         fcb   $15	1: 320x192, 4 color
         fcb   $02
         fcb   $16	2: 160x192, 16 color
         fcb   $02
         fcb   $1D	3: 640x192, 4 color
         fcb   $04
         fcb   $1E	4: 320x192, 16 color
         fcb   $04

* Allocates and maps a hires screen into process address
RT.AScrn ldb   R$X+1,x
         cmpb  #$04		screen type
         bhi   IllArg
         lda   #$03
         pshs  y,x,b,a
         lda   #$03
         ldb   #$03
         leay  <VD.HiRes,u	pointer to screen descriptor
         lbsr  L06C7		gets next free S.D.
         bcs   L05AF
         sta   ,s
         ldb   $01,s		screen type
         stb   $02,y		VD.SType
         leax  >DTabl,pcr
         lslb  
         leax  b,x		point to display code, #blocks
         ldb   $01,x		get number of blocks
         stb   $01,y		VD.NBlk
         lbsr  L06DD
         bcs   L05AF		deallocate ALL alloced blocks on error
         stb   ,y
         lda   $01,x		number of blocks
         ldy   $02,s
         tst   $04,y
         bne   L05A6
         lbsr  L06E3
         bcs   L05AF
L05A6    ldx   $02,s
         std   R$X,x
         ldb   ,s
         clra  
         std   R$Y,x
L05AF    leas  $02,s
         puls  pc,y,x
L05B3    leas  $02,s

IllArg   comb  
         ldb   #E$IllArg
         rts   

RT.XScrn pshs  x
         ldb   R$Y,x
         bmi   L05C8
         bsr   L05DE
         bcs   L05DC
         lbsr  L06FF
         bcs   L05DC
L05C8    ldx   ,s
         ldb   R$Y+1,x
         bmi   L05DB
         bsr   L05DE
         bcs   L05DC
         lbsr  L06E3
         bcs   L05DC
         ldx   ,s
         std   R$X,x
L05DB    clrb  
L05DC    puls  pc,x
L05DE    beq   L05F1
         cmpb  #$03
         bhi   L05F1
         bsr   GetScrn
         beq   L05F1
         ldb   ,x
         beq   L05F1
         lda   $01,x
         andcc #^Carry
         rts   
L05F1    bra   IllArg

* Convert screen to a different type
Rt.PScrn ldd   R$X,x
         pshs  b,a
         cmpd  #$0004
         bhi   L05B3
         leax  >DTabl,pcr
         lslb  
         incb  
         lda   b,x
         sta   ,s
         ldx   R$Y,y
         bsr   L061B
         bcs   L05B3
         lda   ,s
         cmpa  $01,x
         bhi   L05B3		if new one takes more blocks than old
         lda   $01,s
         sta   $02,x
         leas  $02,s
         bra   L0633
L061B    ldd   R$Y,x
         bmi   IllArg
         beq   L0633
         cmpd  #$0003
         bgt   IllArg
         bsr   GetScrn		point X to 3 byte screen descriptor
         lda   ,x		start block #, # of blocks, screen type
         beq   IllArg
         clra  
         rts   

* Displays screen
Rt.DScrn bsr   L061B
         bcs   L063A
L0633    stb   <VD.DGBuf,u
         inc   <VD.DFlag,u
         clrb  
L063A    rts   

* Entry: D = screen 1-3
* Exit:  X = ptr to screen buffer
GetScrn  pshs  b,a
         leax  <VD.GBuff,u
         lda   #$03
         mul   
         leax  b,x
         puls  pc,b,a

* Frees memory of screen allocated by SS.AScrn
Rt.FScrn tst   R$Y,x
         bne   L05F1
         ldb   R$Y+1,x
         cmpb  <VD.DGBuf,u
         beq   L05F1
         tstb  
         lbsr  L05DE
         bcs   L05F1
         lbsr  L06FF
L065B    lda   $01,x
         ldb   ,x
         beq   L066D
         pshs  a
         clra  
         sta   ,x
         tfr   d,x
         puls  b
         os9   F$DelRAM 
L066D    rts   

ShowS    cmpb  #$03		no more than 3 graphics buffers
         bhi   L06C6
         bsr   GetScrn		point X to appropriate screen descriptor
         ldb   ,x		VD.HiRes - start block of screen
         beq   L06C6		if not allocated
         ldb   $02,x		VD.SType - screen type 0-4
         cmpb  #$04
         bhi   L06C6
         lslb  
         pshs  x
         leax  >DTabl,pcr
         ldb   b,x		get proper display code
         puls  x
         stb   >$FF99
         stb   >D.VIDRS
         lda   >D.HINIT
         anda  #$7F		make coco 3 only mode
         sta   >D.HINIT
         sta   >$FF90
         lda   >D.VIDMD
         ora   #$80		graphics mode
         anda  #$F8		1 line/character row
         sta   >D.VIDMD
         sta   >$FF98
         clr   >D.BORDR
         clr   >BordReg
         lda   ,x		get block #
         lsla  
         lsla  
         sta   >D.VOFF1
         sta   >$FF9D
         clr   >D.VOFF0
         clr   >$FF9E
         clr   >D.VOFF2
         clr   >$FF9C
         lbsr  L0101
L06C6    rts   

L06C7    clr   ,-s
         inc   ,s
L06CB    tst   ,y		check block #
         beq   L06D9		if not used yet
         leay  b,y		go to next screen descriptor
         inc   ,s
         deca  
         bne   L06CB
         comb  
         ldb   #E$BMode
L06D9    puls  pc,a

         ldb   #$01
L06DD    os9   F$AlHRAM 	allocate a screen
         rts

L06E1    lda   #$01		map screen into memory
L06E3    pshs  u,x,b,a
         bsr   L0710
         bcc   L06F9
         clra  
         ldb   $01,s
         tfr   d,x
         ldb   ,s
         os9   F$MapBlk 
         stb   $01,s		save error code if any
         tfr   u,d
         bcs   L06FD
L06F9    leas  $02,s		destroy D on no error
         puls  pc,u,x

L06FD    puls  pc,u,x,b,a	if error, then restore D

L06FF    pshs  y,x,a		deallocate screen
         bsr   L0710
         bcs   L070E
         ldd   #DAT.Free	set memory to unused
L0708    std   ,x++
         dec   ,s
         bne   L0708
L070E    puls  pc,y,x,a

L0710    pshs  b,a
         lda   #$08		number of blocks to check
         sta   $01,s
         ldx   <D.Proc
         leax  <P$DATImg+$10,x	to end of CoCo's DAT image map
         clra  
         addb  ,s
         decb  
L071F    cmpd  ,--x
         beq   L072A
         dec   $01,s
         bne   L071F
         bra   L0743
L072A    dec   $01,s
         dec   ,s
         beq   L0738
         decb  
         cmpd  ,--x
         beq   L072A
         bra   L0743
L0738    lda   $01,s		get lowest block number found
         lsla  
         lsla  
         lsla  
         lsla  
         lsla  			multiply by 32 (convert to address)
         clrb  			clear carry
         leas  $02,s
         rts   

L0743    puls  b,a
         comb  
         ldb   #E$BPAddr	bad page address
         rts   

         emod
eom      equ   *
         end
