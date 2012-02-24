********************************************************************
* GrfDrv - Graphics module
*
* $Id$
*
* Edt/Rev  YYYY/MM/DD  Modified by
* Comment
* ------------------------------------------------------------------
*   1      ????/??/??
* From Tandy OS-9 Level One VR 02.00.00.

         nam   GrfDrv
         ttl   Graphics module

* Disassembled 02/04/05 23:44:21 by Disasm v1.6 (C) 1988 by RML

         ifp1
         use   defsfile
         use   cocovtio.d
         endc

tylg     set   Systm+Objct   
atrv     set   ReEnt+rev
rev      set   $00
edition  set   1

         mod   eom,name,tylg,atrv,start,size

         org   0
size     equ   .

         fcb   $07 

name     fcs   /GrfDrv/
         fcb   edition

* Dispatch table
start    lbra  Init
         lbra  Write
         lbra  GetStat
         lbra  SetStat
         lbra  Term

* 128x192 4 color pixel table
Mode1Clr fdb   $0055,$aaff

GetStat
SetStat  comb
         ldb   #E$UnkSvc
         rts

Write    suba  #$15
         leax  <Table,pcr
         lsla
         ldd   a,x
         jmp   d,x

Table    fdb   Do15-Table
         fdb   Do16-Table
         fdb   Do17-Table
         fdb   Do18-Table
         fdb   Do19-Table
         fdb   Do1A-Table
         fdb   NoOp-Table
         fdb   Do1C-Table
         fdb   Do1D-Table
         fdb   NoOp-Table
         fdb   NoOp-Table

* Fix X/Y coords:
* - if Y > 191 then cap it at 191
* - adjust X coord if in 128x192 mode
FixXY    ldd   <V.NChar,u	get next 2 charas
         cmpb  #192		Y greater than max?
         bcs   L0053		branch if lower than
         ldb   #191
L0053    tst   <V.Mode,u	which mode?
         bmi   L0059		branch if 256x192
         lsra  			else divide X by 2
L0059    std   <V.NChar,u	and save
         rts   

* $15 - set graphics cursor
Do15     leax  <SetGC,pcr	load X with return address
GChar2   ldb   #$02		need two parameters
         lbra  GChar

SetGC    bsr   FixXY		fix coords
         std   <V.GCrsX,u	and save new gfx cursor pos

NoOp
Init
Term     clrb  
         rts   

* $19 - erase point
Do19     clr   <V.Msk1,u
* $18 - set point
Do18     leax  <DrawPnt,pcr
         bra   GChar2

DrawPnt  bsr   FixXY		fix coords
         std   <V.GCrsX,u	save as new gfx cursor pos
         bsr   DrwPt2
         lbra  L014A
DrwPt2   jsr   [<V.CnvVct,u]
L0081    tfr   a,b
         comb  
         andb  ,x
         stb   ,x
         anda  <V.Msk1,u	and with mask
         ora   ,x
         sta   ,x
         rts   

* $17 - erase line
Do17     clr   <V.Msk1,u	clear mask value

* $16 - draw line
Do16     leax  <DrawLine,pcr	load X with return address
         bra   GChar2		need two params

DrawLine bsr   FixXY		fix up coords
         leas  -$0E,s		make room on stack
         std   $0C,s		save X/Y
         jsr   [<V.CnvVct,u]	get address given X/Y
         stx   $02,s		save on stack
         sta   $01,s		and pixel too
         ldd   <V.GCrsX,u	get current graphics cursor
         jsr   [<V.CnvVct,u]	get address given X/Y
         sta   ,s
         clra  
         clrb  
         std   $04,s
         lda   #$BF
         suba  <V.GCrsY,u
         sta   <V.GCrsY,u
         lda   #$BF
         suba  <V.NChr2,u
         sta   <V.NChr2,u
         lda   #$FF
         sta   $06,s
         clra  
         ldb   <V.GCrsX,u
         subb  <V.NChar,u
         sbca  #$00
         bpl   L00D6
         nega  
         negb  
         sbca  #$00
         neg   $06,s
L00D6    std   $08,s
         bne   L00DF
         ldd   #$FFFF
         std   $04,s
L00DF    lda   #$E0
         sta   $07,s
         clra  
         ldb   <V.GCrsY,u
         subb  <V.NChr2,u
         sbca  #$00
         bpl   L00F4
         nega  
         negb  
         sbca  #$00
         neg   $07,s
L00F4    std   $0A,s
         bra   L0100
L00F8    sta   ,s
         ldd   $04,s
         subd  $0A,s
         std   $04,s
L0100    lda   ,s
         lbsr  L0081
         cmpx  $02,s
         bne   L010F
         lda   ,s
         cmpa  $01,s
         beq   L0143
L010F    ldd   $04,s
         bpl   L011D
         addd  $08,s
         std   $04,s
         lda   $07,s
         leax  a,x
         bra   L0100
L011D    lda   ,s
         ldb   $06,s
         bpl   L0133
         lsla  
         ldb   <V.Mode,u	which mode?
         bmi   L012A		branch if 256x192
         lsla  
L012A    bcc   L00F8
         lda   <V.4A,u
         leax  -$01,x
         bra   L00F8
L0133    lsra  
         ldb   <V.Mode,u	which mode?
         bmi   L013A		branch if 256x196
         lsra  
L013A    bcc   L00F8
         lda   <V.MCol,u
         leax  $01,x
         bra   L00F8
L0143    ldd   $0C,s
         std   <V.GCrsX,u
         leas  $0E,s
L014A    lda   <V.Msk2,u
         sta   <V.Msk1,u
         clrb  
         rts   

* $1C - erase circle
Do1C     clr   <V.Msk1,u	clear mask value
* $1A - draw circle
Do1A     leax  <Circle,pcr
         ldb   #$01		require another param -- radius
GChar    stb   <V.NGChr,u	one more char
         stx   <V.RTAdd,u	return address
         clrb  
         rts   

Circle   leas  -$04,s		make room on stack
         ldb   <V.NChr2,u	get radius
         stb   $01,s		store on stack
         clra  
         sta   ,s
         addb  $01,s
         adca  #$00
         nega  
         negb  
         sbca  #$00
         addd  #$0003
         std   $02,s
L0179    lda   ,s
         cmpa  $01,s
         bcc   L01AB
         ldb   $01,s
         bsr   L01B9
         clra  
         ldb   $02,s
         bpl   L0193
         ldb   ,s
         lslb  
         rola  
         lslb  
         rola  
         addd  #$0006
         bra   L01A3
L0193    dec   $01,s
         clra  
         ldb   ,s
         subb  $01,s
         sbca  #$00
         lslb  
         rola  
         lslb  
         rola  
         addd  #$000A
L01A3    addd  $02,s
         std   $02,s
         inc   ,s
         bra   L0179
L01AB    lda   ,s
         cmpa  $01,s
         bne   L01B5
         ldb   $01,s
         bsr   L01B9
L01B5    leas  $04,s
         bra   L014A
L01B9    leas  -$08,s
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
         bsr   L0202
         ldd   $04,s
         ldx   $02,s
         bsr   L0202
         ldd   ,s
         ldx   $02,s
         bsr   L0202
         ldd   ,s
         ldx   $06,s
         bsr   L0202
         ldd   $02,s
         ldx   ,s
         bsr   L0202
         ldd   $02,s
         ldx   $04,s
         bsr   L0202
         ldd   $06,s
         ldx   $04,s
         bsr   L0202
         ldd   $06,s
         ldx   ,s
         bsr   L0202
         leas  $08,s
         rts   
L0202    pshs  b,a
         ldb   <V.GCrsY,u
         clra  
         leax  d,x
         cmpx  #$0000
         bmi   L0214
         cmpx  #$00BF
         ble   L0216
L0214    puls  pc,b,a
L0216    ldb   <V.GCrsX,u
         clra  
         tst   <V.Mode,u
         bmi   L0221
         lslb  
         rola  
L0221    addd  ,s++
         tsta  
         beq   L0227
         rts   
L0227    pshs  b
         tfr   x,d
         puls  a
         tst   <V.Mode,u	which mode?
         lbmi  DrwPt2		branch if 256x192
         lsra  			else divide A by 2
         lbra  DrwPt2

* $1D - flood fill
Do1D     clr   <V.FFFlag,u
         leas  -$07,s
         lbsr  L03AB
         lbcs  L0346
         lda   #$FF
         sta   <V.4F,u
         ldd   <V.GCrsX,u
         lbsr  L0351
         lda   <V.4C,u
         sta   <V.4D,u
         tst   <V.Mode,u	which mode?
         bpl   L0261		branch if 128x192
         tsta  
         beq   L0267
         lda   #$FF
         bra   L0267
L0261    leax  >Mode1Clr,pcr
         lda   a,x
L0267    sta   <V.4E,u
         cmpa  <V.Msk1,u
         lbeq  L0346
         ldd   <V.GCrsX,u
L0274    suba  #$01
         bcs   L027F
         lbsr  L0351
         bcs   L027F
         beq   L0274
L027F    inca  
         std   $01,s
L0282    lbsr  L0384
         adda  #$01
         bcs   L0290
         lbsr  L0351
         bcs   L0290
         beq   L0282
L0290    deca  
         ldx   $01,s
         lbsr  L03D3
         neg   <V.4F,u
         lbsr  L03D3
L029C    lbsr  L03F9
         lbcs  L0346
         tst   <V.4F,u
         bpl   L02B3
         subb  #$01
         bcs   L029C
         std   $03,s
         tfr   x,d
         decb  
         bra   L02BD
L02B3    incb  
         cmpb  #$BF
         bhi   L029C
         std   $03,s
         tfr   x,d
         incb  
L02BD    std   $01,s
         lbsr  L0351
         bcs   L029C
L02C4    bne   L02D2
         suba  #$01
         bcc   L02CD
         inca  
         bra   L02D6
L02CD    lbsr  L0351
         bcc   L02C4
L02D2    adda  #$01
         bcs   L029C
L02D6    cmpd  $03,s
         bhi   L029C
         bsr   L0351
         bcs   L029C
         bne   L02D2
         std   $05,s
         cmpd  $01,s
         bcc   L02FB
         ldd   $01,s
         decb  
         cmpd  $05,s
         beq   L02FB
         neg   <V.4F,u
         ldx   $05,s
         lbsr  L03D3
         neg   <V.4F,u
L02FB    ldd   $05,s
L02FD    std   $01,s
L02FF    bsr   L0351
         bcs   L030B
         bne   L030B
         bsr   L0384
         adda  #$01
         bcc   L02FF
L030B    deca  
         ldx   $01,s
         lbsr  L03D3
         std   $05,s
         adda  #$01
         bcs   L0326
L0317    cmpd  $03,s
         bcc   L0326
         adda  #$01
         bsr   L0351
         bcs   L0326
         bne   L0317
         bra   L02FD
L0326    inc   $03,s
         inc   $03,s
         ldd   $03,s
         cmpa  #$02
         lbcs  L029C
         ldd   $05,s
         cmpd  $03,s
         lbcs  L029C
         neg   <V.4F,u
         ldx   $03,s
         lbsr  L03D3
         lbra  L029C
L0346    leas  $07,s
         clrb  
         ldb   <V.FFFlag,u
         beq   L0350
L034E    orcc  #Carry
L0350    rts   
L0351    pshs  b,a
         cmpb  #$BF
         bhi   L0380
         tst   <V.Mode,u	which mode?
         bmi   L0360		branch if 256x192
         cmpa  #$7F
         bhi   L0380
L0360    jsr   [<V.CnvVct,u]
         tfr   a,b
         andb  ,x
L0367    bita  #$01
         bne   L0376
         lsra  
         lsrb  
         tst   <V.Mode,u	which mode?
         bmi   L0367		branch if 256x192
         lsra  
         lsrb  
         bra   L0367
L0376    stb   <V.4C,u
         cmpb  <V.4D,u
         andcc #^Carry
         puls  pc,b,a
L0380    orcc  #Carry
         puls  pc,b,a
L0384    pshs  b,a
         jsr   [<V.CnvVct,u]
         bita  #$80
         beq   L03A6
         ldb   <V.4E,u
         cmpb  ,x
         bne   L03A6
         ldb   <V.Msk1,u
         stb   ,x
         puls  b,a
         tst   <V.Mode,u	which mode?
         bmi   L03A3		branch if 256x192
         adda  #$03
         rts   
L03A3    adda  #$07
         rts   
L03A6    lbsr  L0081
         puls  pc,b,a
L03AB    ldx   <V.FFSTp,u	get top of flood fill stack
         beq   L03B5		if zero, we need to allocate stack
         stx   <V.FFSPt,u	else reset flood fill stack ptr
L03B3    clrb  
         rts   

* Allocate Flood Fill Stack
L03B5    pshs  u		save U for now
         ldd   #$0200		get 512 bytes
         os9   F$SRqMem 	from system
         bcc   AllocOk		branch if ok
         puls  pc,u		else pull out with error
AllocOk  tfr   u,d		move pointer to alloced mem to D
         puls  u		get stat pointer we saved earlier
         std   <V.FFMem,u	save pointer to alloc'ed mem
         addd  #512		point D to end of alloc'ed mem
         std   <V.FFSTp,u	and save here as top of fill stack
         std   <V.FFSPt,u	and here
         bra   L03B3		do a clean return

L03D3    pshs  b,a
         ldd   <V.FFSPt,u
         subd  #$0004
         cmpd  <V.FFMem,u
         bcs   L03F2
         std   <V.FFSPt,u
         tfr   d,y
         lda   <V.4F,u
         sta   ,y
         stx   $01,y
         puls  b,a
         sta   $03,y
         rts   
L03F2    ldb   #$F5
         stb   <V.FFFlag,u
         puls  pc,b,a
L03F9    ldd   <V.FFSPt,u
         cmpd  <V.FFSTp,u		top of flood fill stack?
         lbcc  L034E
         tfr   d,y
         addd  #$0004
         std   <V.FFSPt,u
         lda   ,y
         sta   <V.4F,u
         ldd   $01,y
         tfr   d,x
         lda   $03,y
         andcc #^Carry
         rts   

         emod
eom      equ   *
         end

