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
Init     lbra  L0035
Write    lbra  L008C
GetStat  lbra  L0246
SetStat  lbra  L0250
Term     pshs  y,x
         pshs  u
         ldd   #$0200
         ldu   <$1D,u
         os9   F$SRtMem 
         puls  u
         ldb   <$70,u
         andb  #$FD
         bra   L0086
* Init
L0035    pshs  y,x
         lda   #$AF
         sta   <$2C,u
         pshs  u
         ldd   #$0300
         os9   F$SRqMem 
         tfr   u,d
         tfr   u,x
         bita  #$01
         beq   L0052
         leax  >$0100,x
         bra   L0056
L0052    leau  >$0200,u
L0056    ldd   #$0100
         os9   F$SRtMem 
         puls  u
         stx   <$1D,u
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
         lbsr  L0187
         ldb   <$70,u
         orb   #$02
L0086    stb   <$70,u
         clrb  
         puls  pc,y,x
* Write
L008C    tsta  
         bmi   L00D0
         cmpa  #$1F
         bls   L0103
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
         bsr   L00E3
L00DF    bsr   L013E
* no operation entry point
L00E1    clrb  
         rts   
L00E3    ldx   <$1D,u
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
L0103    cmpa  #$1B
         bcc   L0113
         cmpa  #$0E
         bhi   L0102
         leax  <L0117,pcr
         lsla  
         ldd   a,x
         jmp   d,x
L0113    comb  
         ldb   #E$Write
         rts   

* display functions dispatch table
L0117    fdb   L00E1-L0117  $ffca  $00:no-op (null)
         fdb   L0194-L0117  $007d  $01:HOME cursor
         fdb   L01E0-L0117  $00c9  $02:CURSOR XY
         fdb   L021E-L0117  $0107  $03:ERASE LINE
         fdb   L0210-L0117  $00f9  $04:CLEAR TO EOL
         fdb   L01A8-L0117  $0091  $05:CURSOR ON/OFF
         fdb   L0175-L0117  $005e  $06:CURSOR RIGHT
         fdb   L00E1-L0117  $ffca  $07:no-op (bel:handled in CCIO)
         fdb   L0167-L0117  $0050  $08:CURSOR LEFT
         fdb   L0230-L0117  $0119  $09:CURSOR UP
         fdb   L014F-L0117  $0038  $0A:CURSOR DOWN
         fdb   L0183-L0117  $006c  $0B:ERASE TO EOS
         fdb   L0187-L0117  $0070  $0C:CLEAR SCREEN
         fdb   L0135-L0117  $001e  $0D:RETURN
         fdb   L0241-L0117  $012a  $0E:DISPLAY ALPHA

* $0D - move cursor to start of line (carriage return)
L0135    bsr   L019E
         tfr   x,d
         andb  #$E0
         stb   <$22,u
L013E    ldx   <$21,u
         lda   ,x
         sta   <$23,u
         lda   <$2C,u
         beq   L014D
L014B    sta   ,x
L014D    clrb  
         rts   

* $0A - cursor down (line feed)
L014F    bsr   L019E
         leax  <$20,x
         cmpx  <$1F,u
         bcs   L0162
         leax  <-$20,x
         pshs  x
         bsr   L00E3
         puls  x
L0162    stx   <$21,u
         bra   L013E

* $08 - cursor left
L0167    bsr   L019E
         cmpx  <$1D,u
         bls   L0173
         leax  -$01,x
         stx   <$21,u
L0173    bra   L013E

* $06 - cursor right
L0175    bsr   L019E
         leax  $01,x
         cmpx  <$1F,u
         bcc   L0181
         stx   <$21,u
L0181    bra   L013E

* $0B - erase to end of screen
L0183    bsr   L019E
         bra   L0189

* $0C - clear screen
L0187    bsr   L0194
L0189    lda   #$60
L018B    sta   ,x+
         cmpx  <$1F,u
         bcs   L018B
         bra   L013E

* $01 - home cursor
L0194    bsr   L019E
         ldx   <$1D,u
         stx   <$21,u
         bra   L013E
L019E    ldx   <$21,u
         lda   <$23,u
         sta   ,x
         clrb  
         rts   

* $05 XX - set cursor off/on/color per XX-32
L01A8    ldb   #$01
         leax  <L01AF,pcr
         bra   L01E5
L01AF    lda   <$29,u
         suba  #$20
         bne   L01BB
         sta   <$2C,u
         bra   L019E
L01BB    cmpa  #$0B
         bge   L014D
         cmpa  #$01
         bgt   L01C7
         lda   #$AF
         bra   L01D7
L01C7    cmpa  #$02
         bgt   L01CF
         lda   #$A0
         bra   L01D7
L01CF    suba  #$03		bugfix (was subb)
         lsla  
         lsla  
         lsla  
         lsla  
         ora   #$8F
L01D7    sta   <$2C,u
         ldx   <$21,u
         lbra  L014B

* $02 XX YY - move cursor to col XX-32, row YY-32
L01E0    ldb   #$02
         leax  <L01ED,pcr
L01E5    stx   <$26,u
         stb   <$25,u
         clrb  
         rts   
L01ED    bsr   L019E
         ldb   <$29,u
         subb  #$20
         lda   #$20
         mul   
         addb  <$28,u
         adca  #$00
         subd  #$0020
         addd  <$1D,u
         cmpd  <$1F,u
         lbcc  L014D
         std   <$21,u
         lbra  L013E

* $04 - erase to end of line
L0210    bsr   L019E
         tfr   x,d
         andb  #$1F
         pshs  b
         ldb   #$20
         subb  ,s+
         bra   L0223

* $03 - erase line
L021E    lbsr  L0135		do a CR
         ldb   #32		line length
L0223    lda   #$60		space char for VDG screen
         ldx   <$21,u
L0228    sta   ,x+		fill screen line with 'space'
         decb  
         bne   L0228
         lbra  L013E

* $09 - cursor up
L0230    lbsr  L019E
         leax  <-$20,x
         cmpx  <$1D,u
         bcs   L023E
         stx   <$21,u
L023E    lbra  L013E

* $0E - switch screen to alphanumeric mode
L0241    clra  
         clrb  
         jmp   [<$5B,u]
* GetStat
L0246    ldx   $06,y
         cmpa  #SS.AlfaS	$1C
         beq   L0254
         cmpa  #SS.Cursr	$25
         beq   L0263
* SetStat
L0250    comb  
         ldb   #E$UnkSvc
         rts   
* SS.AlfaS getstat
L0254    ldd   <$1D,u
         std   $04,x
         ldd   <$21,u
         std   $06,x
         lda   <$50,u
         bra   L02BA
* SS.Cursr getstat
L0263    ldd   <$21,u
         subd  <$1D,u
         pshs  b,a
         clra  
         andb  #$1F
         addb  #$20
         std   $04,x
         puls  b,a
         lsra  
         rolb  
         rolb  
         rolb  
         rolb  
         clra  
         andb  #$0F
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
         bra   L02BA
L029B    cmpa  #$1F
         bne   L02A3
         lda   #$5F
         bra   L02BA
L02A3    ora   #$20
L02A5    eora  #$40
         bra   L02BA
L02A9    tstb  
         bne   L02BA
         cmpa  #$21
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

