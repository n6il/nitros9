********************************************************************
* WindInt - CoCo 3 Graphics interface module
*
* $Id$
*
* Ed.    Comments                                       Who YY/MM/DD
* ------------------------------------------------------------------
* 29     Obtained from L2 Upgrade archive               BGP 98/10/21

         nam   WindInt
         ttl   CoCo 3 Graphics interface module

Level    equ   2

         ifp1  
         use   os9defs.l2v3
         use   scfdefs
         use   systype.l2
         endc  

rev      set   $01
edition  set   29

         mod   eom,name,Systm+Objct,ReEnt+rev,WindInt,$60

name     fcs   /WindInt/
         fcb   edition

******************************
*
* Main entry point from CC3IO
*
* Entry: U=Device memory pointer
*        Y=Path descriptor pointer
*

WindInt  lbra  Init       Initialization routine
         lbra  Write      Write routine
         lbra  GetStat      GetStat routine
         lbra  SetStat      SetStat routine
         lbra  Term       Termination routine
         lbra  L0CAC

******************************
*
* Escape code parameter vector table
*
* Format:
*
* Byte 1  : Length of parameters required
* Byte 2-3: Routine entry offset
* Byte 4  : Internal function code for GrfDrv
*

EscTbl   fcb   $07        DWSet
         fdb   DWSet-EscTbl
         fcb   $04
         fcb   $00        Select
         fdb   Select-EscTbl
         fcb   $10
         fcb   $07        OWSet
         fdb   OWSet-EscTbl
         fcb   $0a
         fcb   $00        OWEnd
         fdb   OWEnd-EscTbl
         fcb   $0c
         fcb   $00        DWEnd
         fdb   DWEnd-EscTbl
         fcb   $08
         fcb   $04        CWArea
         fdb   CWArea-EscTbl
         fcb   $0e
         fcb   $ff        Blank
         fdb   $0000
         fcb   $00
         fcb   $ff        Blank
         fdb   $0000
         fcb   $00
         fcb   $ff        Blank
         fdb   $0000
         fcb   $00
         fcb   $04        DefGPB
         fdb   DefGPB-EscTbl
         fcb   $2c
         fcb   $02        KillBuf
         fdb   KillBuf-EscTbl
         fcb   $2e
         fcb   $09        GPLoad
         fdb   GPLoad-EscTbl
         fcb   $30
         fcb   $0a        GetBlk
         fdb   GetBlk-EscTbl
         fcb   $34
         fcb   $06        PutBlk
         fdb   PutBlk-EscTbl
         fcb   $36
         fcb   $02        PSet
         fdb   PSet-EscTbl
         fcb   $12
         fcb   $01        LSet
         fdb   LSet-EscTbl
         fcb   $1e
         fcb   $00        DefPal
         fdb   DefPal-EscTbl
         fcb   $1c
         fcb   $02        Palette
         fdb   Palette-EscTbl
         fcb   $16
         fcb   $01        FColor
         fdb   FColor-EscTbl
         fcb   $20
         fcb   $01        BColor
         fdb   BColor-EscTbl
         fcb   $22
         fcb   $01        Border
         fdb   Border-EscTbl
         fcb   $14
         fcb   $01        Scale
         fdb   ScaleS-EscTbl
         fcb   $28
         fcb   $01        DWProtSw
         fdb   DWProtSw-EscTbl
         fcb   $06
         fcb   $ff        Blank
         fdb   $0000
         fcb   $00
         fcb   $ff        Blank
         fdb   $0000
         fcb   $00
         fcb   $02        GCSet
         fdb   GCSet-EscTbl
         fcb   $1a
         fcb   $02        Font
         fdb   Font-EscTbl
         fcb   $18
         fcb   $ff        Blank
         fdb   $0000
         fcb   $00
         fcb   $01        TCharSw
         fdb   TCharSw-EscTbl
         fcb   $24
         fcb   $01        Bold
         fdb   BoldSw-EscTbl
         fcb   $2a
         fcb   $ff        Blank
         fdb   $0000
         fcb   $00
         fcb   $01        PropSw
         fdb   PropSw-EscTbl
         fcb   $26
         fcb   $04        SetDP
         fdb   SetDP-EscTbl
         fcb   $00
         fcb   $04        RSetDPtr
         fdb   RSetDP-EscTbl
         fcb   $00
         fcb   $04        Point
         fdb   Point-EscTbl
         fcb   $48
         fcb   $04        RPoint
         fdb   RPoint-EscTbl
         fcb   $48
         fcb   $04        Line
         fdb   Line-EscTbl
         fcb   $4a
         fcb   $04        RLine
         fdb   RLine-EscTbl
         fcb   $4a
         fcb   $04        LineM
         fdb   LineM-EscTbl
         fcb   $4a
         fcb   $04        RLineM
         fdb   RLineM-EscTbl
         fcb   $4a
         fcb   $04        Box
         fdb   Box-EscTbl
         fcb   $4c
         fcb   $04        RBox
         fdb   RBox-EscTbl
         fcb   $4c
         fcb   $04        Bar
         fdb   Bar-EscTbl
         fcb   $4e
         fcb   $04        RBar
         fdb   RBar-EscTbl
         fcb   $4e
         fcb   $08        Curved box (new)
         fdb   CBox-EscTbl
         fcb   $58
         fcb   $08        Curved box (new)
         fdb   RCBox-EscTbl
         fcb   $58
         fcb   $04        PutGC
         fdb   PutGC-EscTbl
         fcb   $44
         fcb   $00        FFill
         fdb   FFill-EscTbl
         fcb   $56
         fcb   $02        Circle
         fdb   Circle-EscTbl
         fcb   $50
         fcb   $04        Ellipse
         fdb   Ellipse-EscTbl
         fcb   $52
         fcb   $0c        Arc
         fdb   Arc-EscTbl
         fcb   $54
         fcb   $02        Filled circle (new)
         fdb   FCircle-EscTbl
         fcb   $5a
         fcb   $04        Filled ellipse (new)
         fdb   FEllipse-EscTbl
         fcb   $5c
         fcb   $ff        Blank
         fdb   $0000
         fcb   $00

******************************
*
* Execute grfdrv
*

L00FF    ldu   >WGlobal+G.CurDvM     get device static mem
         ldb   CallCde,u        get Callcode
L0105    ldu   <D.CCMem   get global mem pointer
         ldx   <G.GrfEnt,u   get grfdrv entry address
         orcc  #Entire    make sure we pull all registers
         pshs  cc         save conditions
         orcc  #IntMasks  disable interupts
         leas  1,s        purge stack
         sts   G.GrfStk,u    Save stack pointer for grfdrv
         lds   <D.CCStk   get new stack pointer
         leau  $0100,u    Point to grfdrv memory
         pshs  pc,u,y,x,dp,b,a,cc dump all registers to stack for fake IRQ
         stx   R$PC,s     put grfdrv entry in place of PC
         ldx   >G.GrfStk+WGlobal get grfdrv stack pointer
         lda   -1,x       get it's CC register
         sta   R$CC,s     save it for new CC
         inc   >$1002     flag we're in opposite task
         jmp   [D.Flip1]  swap and execute other task

* Path for GrfDrv

GrfDrvDk fcc   "../CMDS/"
GrfDrv   fcs   "grfdrv"

******************************
*
* Initialization routine
*
* Entry: U=Device memory pointer
*        Y=Path descriptor pointer
*

Init     pshs  u,y        preserve entrys
         ldu   <D.CCMem   get global mem
         ldd   G.GrfEnt,u    grfdrv exist?
         lbne  L0206      yes, don't bother

* Initialize 32 byte ????

         leax  $1C0,u
         clrb  
L014C    stb   b,x
         incb  
         cmpb  #$20
         bne   L014C

* Setup window tables

         leax  G.WUseTb,u    get pointer to window table
         clra             get init value
         ldb   #4         get # bytes
L0159    sta   ,x+        set 8 windows
         decb             done?
         bne   L0159      no, go back

* Get grfdrv going

L015E    leax  <GrfDrvDk,pcr point to full path
         leas  -2,s       make a buffer for process pointer
         lbsr  L023B      swap to system process
         lda   #Systm+Objct get access mode
         os9   F$NMLoad   load it
         lbsr  L0247      swap back to current process
         leas  2,s        purge stack
         lda   #Systm+Objct get acess mode
         leax  <GrfDrv,pcr point to grfdrv name

* Get address of GrfDrv

L0175    ldy   <D.SysPrc  get system process pointer
         leay  P$DatImg,y move to DAT image
         os9   F$FModul   find module in module directory
         bcs   L01C9      error, return
         ldd   MD$MPtr,u  already pointing to something?
         bne   L01C6      yes, return bad page address
         ldy   MD$MPDAT,u get module DAT image pointer
         ldd   #M$Exec    get offset to execution address
         ldx   #0         get offset to start of module
         os9   F$LDDDXY   get execution address
         ldu   <D.CCMem   get pointer to cc mem
         anda  #$1F       make it start at $4xxx
         ora   #$40
         std   G.GrfEnt,u    save it as entry address

* Setup GrfDrv DAT image

         tfr   y,d        move DAT ptr to D
         leax  gr0087+$100,u point to grfdrv DAT map
         ldy   <D.TskIPt  get task image pointer
         stx   2,y        save it as task 1
         tfr   d,y        get DAT pointer back
         ldd   ,y         get first 1st block
         std   4,x        save it for $4000-$5fff
         ldd   2,y        get next block
         std   6,x        save it for $6000-$7fff
         ldd   #$333E     get blank DAT block marker
         std   2,x        save it for $2000-$3fff
         std   8,x        save it for $8000-$9fff
         std   10,x       Save it for $a000-$bfff
         std   12,x       save it for $c000-$dfff
         std   14,x       save it for $e000-$ffff
         clra             get system global block #
         clrb  
         std   ,x         save it for $0000-$1fff
         lbsr  L0105      go execute grfdrv init routine
         ldu   <D.CCMem   get global pointer
         bra   L01CB      mask grfdrv mapped

* process bad page error

L01C6    ldb   #E$BPAddr  get bad page error
L01C8    coma             set carry
L01C9    puls  y,u,pc     restore & return

* Mark GrfDrv initialized

L01CB    ldb   G.BCFFlg,u    get co-module init masks
         orb   #$80       mark grfdrv init'd
         stb   G.BCFFlg,u    save it back

* Get buffer for GFX tables

         ldd   #767       get number of bytes
         os9   F$SRqMem   ask for the memory
         bcs   L01C8      can't get memory error out
         ldx   <D.CCMem   get pointer to global mem
         stu   G.GfxTbl,x    save the pointer to GFX tables
         tfr   d,y        move size recived to Y
         clra             get init value
         clrb  
L01E4    std   ,u++       initialize 2 bytes
         leay  -2,y       done?
         bne   L01E4      no, keep going

* Initialize ??????

         std   G.PrWMPt,x    initilaize ??? and screen change flag
         leay  G.WrkWTb,x
         clra  
         ldb   #$40
L01F3    sta   ,y+
         decb  
         bne   L01F3

* set default palette registers

         ldu   <D.CCMem   get global pointer
         leay  G.DefPls,u    point to palette registers
         sty   G.DefPal+WGlobal save pointer to them
         bsr   L0225      do 8
         bsr   L0225      do another 8

L0206    puls  u,y        restore path & device mem pointers
         leax  CC3Parm,u  point to parameter area
         stx   prmstrt,u  save pointer to start
         stx   nxtprm,u   save pointer to next
         ldb   IT.WND,y   get window number
         stb   DWNum,u    save it as DWNum
         bmi   L021C      window?
         clra             no, start at the front of table
         bsr   L024D      allocate the window
L021C    lda   #$FF       start at the back
         sta   WinNum,u   save it
         lbsr  L0802
         rts              initialization done, return

******************************
*
* Load 8 palette register colors
*
* Entry: Y=Pointer to destination
*

L0225    leax  L0233,pcr  point to default colors
         ldb   #8         get # colors to move
L022B    lda   ,x+        get color
         sta   ,y+        put color
         decb             done?
         bne   L022B      nope, go on
         rts              return

* Default palette colors

L0233    fcb   $3f,$09,$00,$12,$24,$36,$2d,$1b

******************************
*
* Swap to system process descriptor
*
* Entry: 2 byte buffer at current stack (before bsr/lbsr)
*

L023B    pshs  u,b,a      Preserve registers
         ldd   <D.Proc    get current process descriptor
         std   6,s        save it in buffer
         ldd   <D.SysPrc  get system process descriptor
L0243    std   <D.Proc    set it as current
         puls  d,u,pc     restore & return

******************************
*
* Swap to back to current process
*
* Entry: 2 byte buffer at current stack (before bsr/lbsr)
*

L0247    pshs  u,b,a      preserve registers
         ldd   6,s        get process pointer
         bra   L0243      save it and return

******************************
*
* Allocate a window
*
* Entry: D  = Window number
*

L024D    pshs  x,u        make a buffer for current process and preserve U
         bsr   L023B      swap to system process descriptor
         bsr   L0276      point to window allocation table
         os9   F$AllBit   allocate the window
L0256    bsr   L0247      swap back to current descriptor
         leas  2,s        purge stack
         puls  u,pc       restore & return

******************************
*
* Search for a window
*
* Entry: D=Window number
*

L025C    pshs  u,x        preserve registers
         bsr   L023B      swap to system process
         bsr   L0276      get pointer to window allocation table
         leau  4,x        get end pointer to map
         os9   F$SchBit   search for it
         bra   L0256      return

******************************
*
* Deallocate a window
*
* Entry: D=Window number
*

L0269    bmi   L027F      exit if error?
         pshs  u,x        preserve registers
         bsr   L023B      swap to system process
L026F    bsr   L0276      get pointer to allocation map
         os9   F$DelBit   delete the window
         bra   L0256      return

******************************
*
* Point to window allocation table
*

L0276    ldu   <D.CCMem   get global mem pointer
         leax  G.WUseTb,u    get pointer to window allocation table
         ldy   #1         get # bits to set
L027F    rts              return

******************************
*
* Termination routine
*
* Entry: U=Device memory pointer
*        Y=Path descriptor pointer
*

Term           
L0280    clra             get MSB of window #
         ldb   DWNum,u    get LSB of window
         pshs  y,u        preserve pointers
         bsr   L0269      deallocate window
         lbsr  L0706      get window table pointer
         lda   Wt.STbl,y  get screen table pointer MSB
         cmpa  #$FF
         beq   L02AE
         ldu   2,s        get device mem pointer
         lbsr  L1F66
         tfr   x,y
         ldx   Wt.STbl,y
         pshs  u,y,x
         ldy   6,s        get path descriptor pointer
*         ldb   #DWEnd         get callcode
         ldb   #08
         stb   CallCde,u  save it
         lbsr  L04B4
         puls  u,y,x
         lbsr  L1FE3
         lda   #$FF
L02AE    sta   -$0F,y

* Clear parameter & read buffers

         puls  u,y
         leax  <$0035,u
         ldb   #$CB
L02B7    clr   ,x+
         decb  
         bne   L02B7

         clr   <$001E,u
         lbsr  L0722
         ldd   #$FF20
L02C5    cmpa  Wt.STbl,y
         bne   L0301
         cmpa  Wt.STbl+1,y
         bne   L0301
         leay  <$40,y
         decb  
         bne   L02C5
         pshs  u
         ldb   #$02
         lbsr  L0105
         leas  -$02,s
         lbsr  L023B
         leax  >GrfDrv,pcr
         lda   #$C1
         os9   F$UnLoad
         lbsr  L0247
         leas  $02,s
         puls  u
         bcs   L0302
         clra  
         clrb  
         std   <$6E,u
         ldu   <$75,u
         ldd   #$02FF
         os9   F$SRtMem
         bcs   L0302
L0301    clrb  
L0302    rts   

******************************
*
* Suspend process for every escape code except Select & DWEnd
*

L0303    cmpb  #$21       is it Select call?
         beq   L032F      yes, return
         cmpb  #$24       is it DWEnd?
         beq   L032F      yes, return

******************************
*
* Suspend current process
*

L030B    pshs  cc,d,x     preserve registers
         orcc  #IntMasks  disable interupts
         clr   >$100E
L0312    ldx   <D.Proc    get current process pointer
         lda   P$State,x  suspend it
         ora   #Suspend
         sta   P$State,x
         tfr   x,d        get process # to A
         sta   <$7D,u     save it in device parameter area
         ldx   #1         sleep for remainder of my tick
         os9   F$Sleep
         lda   <$7F,u     still processing?
         bne   L0312      yes, go back to sleep
         inc   >$100E
         puls  cc,d,x     restore registers & interupts
L032F    clr   <$7D,u     clear suspended process #
         rts              return

******************************
*
* Device write entry point
*
* Entry: A=Character to write
*

L0333    lbra  L0AC9
Write    cmpa  #$1B       Escape code?
         bne   L0371      no, keep checking
         ldx   prmstrt,u  get pointer to parameter start
         ldb   ,x         get escape call number
         cmpb  #$54       past maximum?
         bhi   L0333      Yes, return error
         subb  #$20       Below minimum?
         bmi   L0333      Yes, return error
         tst   <$7F,u     we already proccesing something?
         beq   L034E      no, process it
         bsr   L0303      go suspend process till were done
L034E    lslb             account for 4 bytes per table entry
         lslb  
         leax  EscTbl,pcr  point to escape table
         clra  
         lda   d,x        get # parameters
         bmi   L0333      blank, exit with error
         sta   parmcnt,u
         pshs  x
         abx   
         lda   3,x        get callcode #
         sta   CallCde,u  save it
         ldd   1,x        get vector
         puls  x          restore table pointer
         leax  d,x        point to routine
         tst   parmcnt,u  still processing parameters?
         bne   L038B      yes, go
         jmp   ,x         execute it

L0371    cmpa  #$1F       $1f codes?
         beq   L03B6      yes, go process
         cmpa  #$02       CurXY code?
         beq   L0385      yes, go process
         cmpa  #$05       CurOn/CurOff?
         beq   L03BA      yes, go process
         cmpa  #$20       above ASCII space?
         bcs   L03C3      no,
         ldb   #$3A       get grfdrv code for Alpha put
         bra   L03C5
L0385    leax  <L0390,pcr
L0388    sta   parmcnt,u  save parameter count
L038B    stx   parmvct,u  save processing vector
         clra             clear carry
         rts              return

* Process a cursor X/Y code

L0390    pshs  u          save device static mem pointer
         lbsr  L06E7      get window table pointer
         puls  u          restore device mem pointer
         ldx   prmstrt,u  get pointer to parameter start
         ldd   ,x++       get co-ordinates
         ldu   <D.CCMem   get pointer to global mem
         sta   $0147,u    save co-ordinates in global mem
         stb   $0149,u
         ldb   #$42       get grfdrv goto x/y code

* Send write parameters to grfdrv

L03A8    ldu   WGlobal+G.CurDvM get device mem pointer
         tst   <$7F,u     still processing?
         beq   L03B3      no, send it to grfdrv
         lbsr  L030B      suspend process til it's done
L03B3    lbra  L0105      execute grfdrv

* Process $1F codes

L03B6    ldb   #$40
         bra   L03BC

* Process CurOn/CurOff code

L03BA    ldb   #$3E       get grfdrv call #
L03BC    ldx   <$002F,u
         lda   ,x
         bra   L03C5

L03C3    ldb   #$3C
L03C5    pshs  b,a
         lbsr  L06E7
         puls  b,a
         bra   L03A8

L03CE    lda   -$0E,y
         bpl   L042E
         clr   $09,y
         pshs  x
         lbsr  L0546
         ldu   4,s
         cmpu  >$1020
         beq   L03E4
         lbsr  L201D
L03E4    ldx   Wt.STbl,y
         lda   $06,x
         sta   $07,y
         lda   #$0C
         ldb   #$3C
         pshs  y,x
         lbsr  L0105
         puls  y,x
         ldu   4,s
         lbsr  L1FE3
         lda   #$FF
         ldu   <D.CCMem
         sta   (GrfMem+Gr.STYMk)-WGlobal+,u save STY marker
*         sta   G.STYMrk-WGlobal,u save STY marker
         puls  x
         lbsr  L046B
         bcs   L042E
         bra   L0454

******************************
*
* DWSet
*

DWSet    pshs  u,y        preserve registers
         lbsr  L0706      point to window table entry
         lda   Wt.STbl,y  window inized?
         cmpa  #$FF
         beq   L041F      no, go set it up
         lda   ,x+        current screen?
         beq   L03CE      yes, go process
         comb             set carry
         ldb   #$B8       get window already defined error code
         puls  y,u,pc     return

L041F    lda   ,x+        get window type
         lbsr  L0845
         bcs   L042E      error, return with illegal window
         stb   >$0160,u
         bsr   L046B      move rest of data to window table
         bcc   L0432      no error, go on
L042E    ldb   #E$IWDef
         bra   L0460
L0432    cmpb  #$FF       current screen?
         beq   L044D      yes, 
         leax  <L0440,pcr
         lda   #$01
         puls  u,y
         lbra  L0388

L0440    pshs  u,y
         lbsr  L0706
         lda   ,x
         sta   >$015A,u
         bra   L0454

L044D    ldx   ,s
         lbsr  L07B0
         bcs   L0460
L0454    lbsr  L1F1D
         bcs   L0462
         puls  u,y
         inc   <$001E,u
         bra   L048E
L0460    puls  pc,u,y
L0462    pshs  b
         ldd   #$FFFF
         std   Wt.STbl,y
         puls  pc,u,y,b

L046B    pshs  b,a
         bsr   L047B
         bcs   L0477
         ldd   ,x++
         std   $06,y
L0475    puls  pc,b,a
L0477    stb   $01,s
         bra   L0475
L047B    ldd   ,x++
         std   -$0B,y
         lda   ,x+
         ble   L0487
         ldb   ,x+
         bgt   L048A
L0487    lbra  L06DE
L048A    std   -$09,y
         clrb  
L048D    rts   

L048E    pshs  u,y
         lbsr  L0706
         ldb   -$08,y
         puls  u,y
         stb   $0007,u
         stb   <$28,y
         clrb  
         rts   

******************************
*
* DWEnd
*

DWEnd    lbsr  L1F66
         tfr   x,y
         ldx   Wt.STbl,y
         pshs  u,y,x
         bsr   L04B4
         puls  u,y,x
         bcs   L048D
         lbsr  L1FE3
         clr   <$001E,u
         rts   

L04B4    pshs  u
         cmpu  >$1020
         beq   L04BF
         lbsr  L201D
L04BF    lbsr  L0706
         lda   Wt.STbl,y
         bpl   L04E2
         comb  
         ldb   #E$WUndef
         puls  pc,u

L04CB    pshs  a
         bsr   L0544
         ldu   $01,s
         bsr   L04FF
         ldb   #$0C
         lbsr  L0105
         puls  a
         ldu   ,s
         sta   WinNum,u
         lbsr  L0706
L04E2    ldu   ,s
         lda   -$0E,y
         bpl   L04CB
         bsr   L0544
         puls  u
         bsr   L04FF
         lda   >$100B
         bmi   L04FC
         clra  
         std   >$012E,u
         std   >$0130,u
L04FC    lbra  L00FF
L04FF    lbsr  L1BAD
         lbsr  L0711
L0505    ldb   #$12
L0507    clr   ,x+
         decb  
         bne   L0507
         rts   

******************************
*
* OWSet
*

OWSet    pshs  u,y
         lbsr  L06EC
         ldu   $02,s
         lbsr  L0802
         bcc   L051B
         puls  pc,u,y
L051B    lda   ,x+
         sta   >$0159,u
         lbsr  L046B
         bcs   L0534
         pshs  y
         lbsr  L00FF
         puls  y
         bcs   L0534
         puls  u,y
         lbra  L048E
L0534    puls  u,x
         pshs  b
         lda   -$0E,y
         sta   <$0035,u
         ldd   #$FFFF
         std   Wt.STbl,y
         puls  pc,b
L0544    ldu   <$00A5
L0546    clra  
         clrb  
         std   -$0B,y
         ldd   <$28,y
         std   -$09,y
         ldb   #$0E
         pshs  u,y
         lbsr  L0105
L0556    puls  pc,u,y

******************************
*
* OWEnd
*

OWEnd    pshs  u,y
         lbsr  L06EC
         lda   -$0E,y
         bpl   L0564
         lbra  L06DC
L0564    lbsr  L1BAD
         ldu   $02,s
         lbsr  L0711
         lda   ,x
         pshs  a
         lda   -$0E,y
         ldx   $03,s
         sta   <$35,x
         bsr   L0546
         ldb   #$0C
         lbsr  L0105
         bcc   L0582
         puls  pc,u,y,a
L0582    ldu   $03,s
         ldy   $01,s
         lbsr  L048E
         lda   ,s+
         beq   L0556
         cmpa  #$02
         bhi   L0556
         puls  u,y
         tst   >$100A
         beq   L05E3
         lbra  L1316

******************************
*
* Select entry point
*

Select   ldx   PD.RGS,y   get register stack pointer
         lda   R$A,x      get callers selected path
         ldx   <D.Proc    get current process pointer
         cmpa  P$SelP,x   was it same as selected path?
         beq   L05E4      yes, return
         ldb   P$SelP,x   get selected path
         sta   P$SelP,x   save new path
         pshs  y          preserve device pointer
         bsr   L05E5      get device table pointer
         ldy   V$STAT,y   get static storage pointer
         ldx   <D.CCMem   get global pointer
         cmpy  G.CurDev,x      same as active device?
         puls  y
         bne   L05E3      no, return
         pshs  b
         leax  ,u
         lbsr  L06F8
         puls  b
         bcc   L05D5
         ldx   <D.Proc
         stb   P$SelP,x
         ldb   #E$WUndef
         rts   
L05D5    inc   <$23,x     flag screen change in new window device mem
         ldy   <$20,u     get old current device mem pointer
         sty   <$22,u     save it old de
         stx   <$20,u
L05E3    clrb  
L05E4    rts   

******************************
*
* Get device table pointer
*
* Entry: X=Process descriptor pointer
*        B=Path #
* Exit : Y=Device table pointer
*

L05E5    leax  P$Path,x
         lda   b,x
         ldx   <D.PthDBT
         os9   F$Find64
         ldy   PD.DEV,y
         rts   

******************************
*
* CWArea
*

CWArea   pshs  u,y
         lbsr  L06EC
         ldd   -$09,y
         pshs  b,a
         ldd   -$0B,y
         pshs  y,b,a
         lbsr  L047B
         bcs   L065B
         ldu   $08,s
         lbsr  L0711
         clra  
         clrb  
         pshs  b,a
         ldd   <$28,y
         pshs  b,a
         lda   ,x
         anda  #$0F
         cmpa  #$01
         bne   L0621
         dec   $01,s
         inc   $03,s
         bra   L0639
L0621    cmpa  #$02
         bne   L0629
         dec   ,s
         bra   L0633
L0629    cmpa  #$00
         beq   L0639
         inc   $02,s
         dec   ,s
         dec   ,s
L0633    inc   $03,s
         dec   $01,s
         dec   $01,s
L0639    ldd   -$09,y
         cmpa  ,s
         bhi   L0659
         cmpb  $01,s
         bhi   L0659
         ldd   -$0B,y
         cmpa  $02,s
         bcs   L0659
         cmpb  $03,s
         bcs   L0659
         lbsr  L00FF
         bcs   L0659
         leas  $0A,s
         puls  u,y
         lbra  L048E
L0659    leas  $04,s
L065B    puls  u,y,b,a
         std   -$0B,y
         stu   -$09,y
         comb  
         ldb   #E$ICoord
         puls  pc,u,y

GCSet    pshs  u
         bsr   L06E7
         ldd   ,x
         lbsr  L0896
         lbsr  L00FF
         puls  u
         lbsr  L0711
         lda   <$18,y
         sta   $0B,x
         ldd   <$19,y
         std   $0C,x
         rts   

LSet     bsr   L06E2
         lda   ,x
         sta   $0A,y
         bra   L069A

Border   pshs  u
         bsr   L06E7
         lda   ,x
         bra   L06AD

BColor         
FColor   bsr   L06E2
         lda   ,x
         sta   >$015A,u
L069A    lbra  L00FF

DefPal   pshs  u
         bsr   L06E7
         bra   L06B1

Palette  pshs  u
         bsr   L06E7
         ldd   ,x
         stb   >$0186,u
L06AD    sta   >$015A,u
L06B1    lbsr  L00FF
         puls  u
         tst   >$100A
         beq   L06BE
         inc   <$0023,u
L06BE    rts   

Font           
PSet     bsr   L06E2
         ldd   ,x
         beq   L06CB
         cmpb  #$00
         lbeq  L086C
L06CB    lbsr  L0896
         bra   L069A

******************************
*
* KillBuf
*

KillBuf  bsr   L06E2
         ldd   ,x
         bra   L06CB

PropSw         
BoldSw         
TCharSw        
DWProtSw       
ScaleS   bsr   L06E2
         lda   ,x
         bra   L069A

L06DC    leas  $04,s
L06DE    comb  
         ldb   #E$IWDef
         rts   

L06E2    bsr   L06F8
         bcs   L06F4
         rts   

L06E7    bsr   L06F8
         bcs   L06F2
L06EB    rts   

L06EC    bsr   L06F8
         bcc   L06EB
         leas  $02,s
L06F2    leas  $02,s
L06F4    ldb   #$C4
         puls  pc,y

L06F8    pshs  x          preserve X
         tfr   y,x
         bsr   L0706      get window number
         pshs  u,y        save device mem pointer & window table pointer
         bsr   L0729
         puls  u,y
         puls  pc,x

******************************
*
* Get pointer to window table entry
*
* Entry: U=Device static storage pointer
* Exit : Y=Window table pointer
*

L0706    ldb   WinNum,u   get entry number from device memory
         lda   #$40       get size of window tables
         mul              find offset
         bsr   L0722      get pointer to window table
         leay  d,y        point to window entry
         rts              return

L0711    pshs  b,a
         lda   WinNum,u
         ldb   #$12
         mul   
         ldu   <D.CCMem
         ldx   G.GfxTbl,u
         leax  d,x
         puls  pc,b,a

L0722    ldu   <D.CCMem
         leay  >$0290,u
         rts   

L0729    ldd   Wt.STbl,y  screen table exist?
         beq   L06DE      no, exit with illegal window defintion error
         cmpa  #$FF
         beq   L0733
         clra  
         rts   

L0733    pshs  x
         ldx   PD.DEV,x
         pshs  x
         ldx   V$DESC,x
         ldb   IT.VAL,x
         bne   L0744
         coma  
L0741    leas  4,s
         rts   

L0744    lda   IT.STY,x   get screen type
         lbsr  L0845
         bcs   L0741
         stb   >$0160,u   save new STY marker
         cmpb  #$FF
         beq   L075D
*         lda   PD.BDC,x       get border color
         fcb   $a6,$88,$35
         sta   >$015A,u   save new PRN
         bra   L0767

L075D    pshs  x
         ldx   4,s        get path descriptor pointer
         bsr   L07B0
         puls  x
         bcs   L0741
L0767    ldd   IT.CPX,x   get CPX from descriptor
         std   -$0B,y     save new CPX/CPY
         ldd   IT.COL,x   get size from descriptor
         std   -$09,y     save new SZX/SZY
         ldd   IT.FGC,x   get Fore/Back colors
         std   $06,y      save new Fore/Back colors
         lbsr  L1F1D
         puls  x
         bcc   L0784
         ldd   #$FFFF
         std   Wt.STbl,y
         puls  pc,x

L0784    ldx   $02,x
         inc   <$1E,x
         leau  ,x
         tfr   y,d
         puls  y
         pshs  b,a
         lbsr  L048E
         puls  y
         tst   >$100A
         beq   L07AF
         ldu   <D.CCMem
         pshs  y
         ldy   <$0020,u
         sty   <$0022,u
         puls  y
         stx   <$0020,u
         lbsr  L0CCA
L07AF    rts   

L07B0    cmpa  #$FF
         bne   L07C1
         ldd   >$0130,u
         bne   L07BE
         comb  
         ldb   #E$WUndef
         rts   

L07BE    std   Wt.STbl,y
         rts   

L07C1    pshs  y,x
         ldx   <D.Proc
         ldb   P$SelP,x
         lbsr  L05E5
         ldx   ,s
         ldx   PD.DEV,x
         ldd   V$DRIV,x
         cmpd  V$DRIV,y
         bne   L07FF
         ldy   V$STAT,y
         lda   V.TYPE,y
         bpl   L07FF
         lda   <$1D,y
         bne   L07FF
         lda   <$1E,y
         beq   L07FF
         leau  ,y
         lbsr  L0706
         lda   Wt.STbl,y
         cmpa  #$FF
         beq   L07FF
         leas  $02,s
         puls  x
         ldd   Wt.STbl,y
         std   Wt.STbl,x
         tfr   x,y
         clra  
         rts   
L07FF    lbra  L06DC

*

L0802    pshs  x,b,a
         leax  ,u
         lbsr  L0722
         clrb  
L080A    lda   Wt.STbl,y
         bpl   L0836
         lda   -$0F,y
         cmpa  #$FF
         bne   L0836
         lda   <$35,x
         sta   -$0E,y
         stb   <$35,x
         dec   -$0F,y
         tfr   x,d
         sta   <$2B,y
         clr   <$7D,x
         clr   <$7E,x
         clr   <$7F,x
         tfr   x,u
         lbsr  L0711
         lbsr  L0505
         puls  pc,x,b,a

L0836    leay  <$40,y
         incb  
         cmpb  #$20
         bls   L080A
         comb  
         ldb   #$C1
         stb   $01,s
         puls  pc,x,b,a

L0845    pshs  y,a
         inca  
         cmpa  #$09
         bhi   L0854
         leay  <L0857,pcr
         ldb   a,y
         clra  
         puls  pc,y,a
L0854    comb  
         puls  pc,y,a

L0857    fcb   $ff,$ff,$86,$85,$96,$95,$01,$02,$03,$04

******************************
*
* DefGPB
*

DefGPB   lbsr  L06E2
         lda   ,x+
         beq   L086C
         cmpa  #$FF
         bne   L0870
L086C    comb  
         ldb   #$C2
         rts   

L0870    ldb   ,x+
         beq   L086C
         bsr   L0896
         ldd   ,x++
         std   >$0180,u
L087C    lbra  L00FF

GetBlk   lbsr  L06E2
         bsr   L089B
         bcs   L086C
         bsr   L08AE
         bcc   L087C
         ldb   #$BF
         rts   

PutBlk   lbsr  L06E2
         bsr   L089B
         bcs   L086C
         bra   L087C
L0896    std   >$0157,u
         rts   

L089B    lda   ,x+
         beq   L08C0
         cmpa  #$FF
         beq   L08C0
         ldb   ,x+
         beq   L08C0
         bsr   L0896
         lbsr  L0A5E
         bra   L08BE
L08AE    ldd   ,x++
         beq   L08C0
         std   >$014F,u
         ldd   ,x++
         beq   L08C0
         std   >$0151,u
L08BE    clra  
         rts   
L08C0    coma  
         rts   

GPLoad   pshs  u,y
         lbsr  L0706
         lda   ,x+
         beq   L08CF
         cmpa  #$FF
         bne   L08D3
L08CF    puls  u,y
         bra   L086C
L08D3    ldb   ,x+
         beq   L08CF
         bsr   L0896
         lda   ,x+
         lbsr  L0845
         bcs   L08E3
         tstb  
         bpl   L08E6
L08E3    lbra  L06DC
L08E6    stb   >$0160,u
         bsr   L08AE
         ldd   ,x++
         std   <$1F,y
         pshs  u,y
         lbsr  L00FF
         puls  u,y
         bcs   L0919
L08FA    ldd   <$1F,y
         cmpd  #$0040
         bhi   L091C
         stb   <$70,u
         tfr   b,a
         leax  <L0910,pcr
L090B    puls  u,y
         lbra  L0388

L0910    pshs  u,y
         lbsr  L0706
         bsr   L0939
         bsr   L094B
L0919    leas  $04,s
         rts   

L091C    subd  #$0040
         std   <$1F,y
         lda   #$40
         sta   <$70,u
         leax  <L092C,pcr
         bra   L090B

L092C    pshs  u,y
         lbsr  L0706
         bsr   L0939
         bsr   L094B
         bcs   L0919
         bra   L08FA

L0939    pshs  y,b,a
         leay  >$0200,u
         ldb   <$70,u
L0942    lda   ,x+
         sta   ,y+
         decb  
         bne   L0942
         puls  pc,y,b,a

L094B    lda   <$70,u
         pshs  u
         ldb   #$32
         lbsr  L0105
         puls  pc,u

L0957    ldd   ,x++
         std   ,y
         ldd   -$08,y
         subd  -$0C,y
         lsra  
         rorb  
         cmpd  ,y++
         bcc   L096B
         leas  $08,s
         comb  
         ldb   #$BD
L096B    rts   

PutGC    lbsr  L06E2
         ldd   ,x++
         std   >$015B,u
         ldd   ,x++
         std   >$015D,u
         bra   L09A5

SetDP    bsr   L09CB
         ldd   ,x++
         std   $01,y
         ldd   ,x++
L0985    stb   $03,y
         puls  y
         leas  $04,s
         clrb  
         rts   

RSetDP   bsr   L09CB
         ldd   ,x++
         addd  $01,y
         std   $01,y
         clra  
         ldb   $03,y
         addd  ,x++
         bra   L0985

Point    bsr   L09CB
         lbsr  L0A5E
L09A1    puls  y
         leas  $04,s
L09A5    lbra  L00FF

RPoint   bsr   L09CB
         lbsr  L0A69
         bra   L09A1

CBox           
Bar            
Box            
Line     bsr   L09CB
         lbsr  L0A7F
L09B4    ldu   $04,s
         ldb   <$0037,u
         ldu   <D.CCMem
         cmpb  #$58
         bne   L09A1
         leay  >$0153,u
         lbsr  L0957
         lbsr  L0957
         bra   L09A1
L09CB    ldd   ,s++
         pshs  u,x,b,a
         pshs  b,a
         lbsr  L06F8
         bcs   L09E3
         sty   $02,s
         ldu   $06,s
         lbsr  L0711
         tfr   x,y
         ldx   $04,s
         rts   

L09E3    leas  $06,s
         lbra  L06F4

RCBox          
RBar           
RBox           
RLine    bsr   L09CB
         lbsr  L0A8C
         bra   L09B4

LineM    bsr   L09CB
         lbsr  L0A7F
L09F4    ldx   >$014B,u
         ldd   >$014D,u
         stx   $01,y
         stb   $03,y
         bra   L09A1

RLineM   bsr   L09CB
         lbsr  L0A8C
         bra   L09F4

Arc            
FEllipse       
FCircle        
Ellipse        
Circle         
FFill    pshs  u,x
         lbsr  L06EC
         pshs  y
         ldu   $04,s
         ldb   <$0037,u
         pshs  b
         lbsr  L0711
         tfr   x,y
         ldx   $03,s
         bsr   L0A76
         ldb   ,s
         cmpb  #$56
         beq   L0A59
         leau  >$0150,u
         ldd   ,x++
         std   $0003,u
         ldb   ,s
         cmpb  #$50
         beq   L0A59
         cmpb  #$5A
         beq   L0A59
         ldd   ,x++
         std   $0005,u
         ldb   ,s
         cmpb  #$52
         beq   L0A59
         cmpb  #$5C
         beq   L0A59
         leau  <-$0030,u
         ldd   ,x++
         std   ,u
         ldd   ,x++
         std   $0002,u
         ldd   ,x++
         std   $0004,u
         ldd   ,x++
         std   $0006,u
L0A59    puls  b
         lbra  L09A1
L0A5E    ldd   ,x++
         bsr   L0A9B
         ldd   ,x++
L0A64    std   >$0149,u
         rts   

L0A69    ldd   ,x++
         addd  $01,y
         bsr   L0A9B
         clra  
         ldb   $03,y
         addd  ,x++
         bra   L0A64
L0A76    ldd   $01,y
         bsr   L0A9B
         clra  
         ldb   $03,y
         bra   L0A64
L0A7F    bsr   L0A76
         ldd   ,x++
         bsr   L0AA0
         ldd   ,x++
L0A87    std   >$014D,u
         rts   

L0A8C    bsr   L0A76
         ldd   ,x++
         addd  $01,y
         bsr   L0AA0
         clra  
         ldb   $03,y
         addd  ,x++
         bra   L0A87
L0A9B    std   >$0147,u
         rts   
L0AA0    std   >$014B,u
         rts   

         bsr   L0A64
         bra   L0A87

******************************
*
* Device GetStt routine
*
* Entry: A=Function code
*

GetStat  cmpa  #SS.Cursr
         lbeq  L0B43
         cmpa  #SS.ScSiz
         beq   L0ACD
         cmpa  #SS.Palet
         beq   L0ADA
         cmpa  #SS.ScTyp
         beq   L0B0A
         cmpa  #SS.FBRgs
         beq   L0B20
         cmpa  #SS.DFPal
         beq   L0AF6
         cmpa  #SS.MnSel
         lbeq  L144C
L0AC9    comb  
         ldb   #E$UnkSvc
         rts   

* Process SS.ScSiz

L0ACD    bsr   L0AFE
         clra  
         ldb   -$09,y
         std   $04,x
         ldb   -$08,y
         std   $06,x
         clrb  
         rts   

* Process SS.Palet

L0ADA    bsr   L0AFE
         ldy   Wt.STbl,y
         leay  <$10,y
L0AE2    ldu   $04,x
         ldx   <$0050
         ldb   $06,x
         ldx   <$004A
         lda   $06,x
         tfr   y,x
L0AEE    ldy   #$0010
         os9   F$Move
         rts   

* Process SS.DFPal

L0AF6    ldx   $06,y
         ldy   >$1019
         bra   L0AE2
L0AFE    ldx   $06,y
         lbsr  L06E7
L0B03    rts   

* Process SS.ScTyp

L0B04    fcb   $05,$06,$07,$08,$02,$01

L0B0A    bsr   L0AFE
         lda   [Wt.STbl,y]
         anda  #$07
         leay  <L0B03,pcr
         ldb   a,y
         stb   $01,x
         clrb  
         rts   

L0B1A    fcb   $01,$03,$03,$0f,$0f,$0f

L0B20    bsr   L0AFE
         bsr   L0B2D
         std   1,x
         ldb   $0005,u
         clra  
         std   $04,x
         clrb  
         rts   

L0B2D    ldu   Wt.STbl,y
         pshs  u
         ldb   ,u
         decb  
         andb  #$07
         leau  <L0B1A,pcr
         leau  b,u
         ldd   $06,y
         anda  ,u
         andb  ,u
         puls  pc,u

L0B43    lbsr  L0AFE
         pshs  u,x
         ldb   #$5E
         lbsr  L0105
         puls  u,x
         leau  >$0147,u
         ldd   ,u++
         sta   $01,x
         clra  
         std   $04,x
         ldb   ,u+
         std   $06,x
         rts   

******************************
*
* Device SetStt entry point
*
* Entry: A  = Function call #
*        Y  = path descriptor
*

SetStat  cmpa  #SS.Open
         beq   SSOpen
         cmpa  #SS.MpGPB
         lbeq  SSMpGPB
         cmpa  #SS.DfPal
         beq   SSDfPal
         cmpa  #SS.WnSet  SS.WnSet call?
         lbeq  SSWnSet      yes, go process
         cmpa  #SS.SBar
         lbeq  SSSBar
         cmpa  #SS.UMBar
         lbeq  SSUMBar
         cmpa  #SS.GIP2
         lbeq  SSGIP2
         lbra  L0AC9

SSDfPal  ldx   PD.RGS,y
         ldx   R$X,x
         ldu   <D.Proc
         lda   P$Task,u
         ldu   <D.SysPrc
         ldb   P$Task,u
         ldu   >WGlobal+G.DefPal
         lbra  L0AEE

L0B9A    fcb   $77

SSOpen   pshs  u,y
         ldx   PD.DEV,y
         ldx   V$DESC,x
         ldb   <IT.WND,x get window number
         bpl   L0C14 branch if not /w (/w's win num == $FF)
         pshs  x
L0BA8    clra  
         clrb  
         lbsr  L025C
         bcc   L0BB3
         ldb   #E$MNF
         puls  pc,u,y,x

L0BB3    pshs  b
         ldu   <D.CCMem
         lbsr  L024D
         leax  <L0B9A,pcr
         leay  >$0200,u
         ldb   ,x
         stb   ,y+
         ldb   ,s
         clra  
L0BC8    subb  #$0A
         bmi   L0BCF
         inca  
         bra   L0BC8
L0BCF    addb  #$0A
         tsta  
         beq   L0BD8
         ora   #$30
         sta   ,y+
L0BD8    orb   #$B0
         stb   ,y+
         leas  -$02,s
         lbsr  L023B
         leax  >$0200,u
         lda   #$F1
         os9   F$Link
         lbsr  L0247
         leas  $02,s
         bcc   L0BF5
L0BF1    leas  $01,s
         bra   L0BA8
L0BF5    lda   <$0026,u
         bpl   L0BF1
         tfr   u,d
         ldy   $03,s
         ldx   $03,y
         std   $04,x
         ldb   ,s
         ldu   $05,s
         stb   <$0036,u
         ldu   $01,s
         os9   F$UnLink
         ldu   $05,s
         leas  $07,s
         rts   
L0C14    puls  u,y
         clrb  
         rts   

SSMpGPB  ldx   $06,y
         pshs  x
         lbsr  L06F8
         ldd   $04,x
         std   >$0157,u
         ldb   #$38
         lbsr  L0105
         puls  x
         bcc   L0C2F
         rts   

L0C2F    ldu   <D.CCMem
         ldb   >$0197,u
         lda   >$0199,u
         tst   $07,x
         beq   L0C65
         pshs  u,x,b,a
         bsr   L0C76
         bcc   L0C53
         clra  
         ldb   $01,s
         tfr   d,x
         ldb   ,s
         os9   F$MapBlk
         stb   $01,s
         bcs   L0C63
         tfr   u,d
L0C53    ldu   <D.CCMem
         ldx   $02,s
         addd  >$019D,u
         std   $04,x
         ldd   >$019B,u
         std   $06,x
L0C63    puls  pc,u,x,b,a

L0C65    pshs  y,x,a
         bsr   L0C76
         bcs   L0C74
         ldd   #$333E
L0C6E    std   ,x++
         dec   ,s
         bne   L0C6E
L0C74    puls  pc,y,x,a

L0C76    pshs  b,a
         lda   #$08
         sta   $01,s
         ldx   <$0050
         leax  <$50,x
         clra  
         addb  ,s
         decb  
L0C85    dec   $01,s
         bmi   L0CA7
         cmpd  ,--x
         bne   L0C85
         dec   ,s
         beq   L0C9E
L0C92    decb  
         cmpd  ,--x
         bne   L0CA7
         dec   $01,s
         dec   ,s
         bne   L0C92
L0C9E    puls  b,a
         lda   #$20
         mul   
         exg   a,b
         clrb  
         rts   
L0CA7    com   ,s++
         ldb   #$D2
L0CAB    rts   

L0CAC    cmpa  #$00
         beq   L0CC3
         cmpa  #$01
         lbeq  L1ADC
         cmpa  #$03
         lbeq  L1990
         cmpa  #$02
         beq   L0D34
         lbra  L0AC9
L0CC3    lbsr  L0706
         ldd   Wt.STbl,y
         bmi   L0CAB
L0CCA    clr   ,-s
         pshs  u,y
         ldb   #$10
         lbsr  L0105
         puls  u,y
         ldx   <$0022,u
         cmpx  <$0020,u
         beq   L0D04
         inc   ,s
         pshs  u,y
         ldx   <D.CCMem
         ldu   <$0022,u
         beq   L0D02
         lbsr  L0D60
         bcs   L0CF4
         bsr   L0D3C
         bcc   L0CF4
         lbsr  L1060
L0CF4    ldx   <D.CCMem
         lda   >$00BE,x
         bmi   L0D02
         ldu   <$22,x
         sta   <$0035,u
L0D02    puls  u,y
L0D04    ldx   <D.CCMem
         ldu   <$20,x
         tst   ,s+
         beq   L0D30
         pshs  u,y,x
         lbsr  L1F4E
         bsr   L0D60
         bcs   L0D19
         lbsr  L1316
L0D19    ldx   <D.CCMem
         ldy   <$20,x
         sty   <$22,x
         ldu   $04,s
         lda   >$00BE,x
         bmi   L0D2E
         sta   <$0035,u
L0D2E    puls  u,y,x
L0D30    jmp   [>$00C4,x]
L0D34    lbsr  L06E2
L0D37    ldb   #$46
         lbra  L0105
L0D3C    pshs  u,y,x
         ldu   Wt.STbl,y
         leax  >$0290,x
         ldd   #$0020
L0D47    cmpu  Wt.STbl,x
         bne   L0D51
         tst   -$0E,x
         bpl   L0D51
         inca  
L0D51    leax  <$40,x
         decb  
         bne   L0D47
         deca  
         bne   L0D5D
         clrb  
         puls  pc,u,y,x
L0D5D    comb  
         puls  pc,u,y,x

L0D60    pshs  u,x
         lda   #$FF
         leax  >$00BE,x
         sta   ,x
L0D6A    lbsr  L0706
         ldu   $02,s
         lbsr  L0EA7
         bcs   L0D76
         puls  pc,u,x

L0D76    lda   -$0E,y
         bmi   L0D8A
         ldu   $02,s
         ldb   <$0035,u
         tst   ,x
         bpl   L0D85
         stb   ,x
L0D85    sta   <$0035,u
         bra   L0D6A
L0D8A    coma  
         puls  pc,u,x

* Process SS.WnSet call

SSWnSet  lbsr  L1292
         ldx   PD.RGS,y   get register stack pointer
         ldb   R$Y+1,x    get window type
         cmpb  #Wt.PBox   within range?
         lbhi  L06DE      no, exit with error
         pshs  d,y,u      preserve registers
         lbsr  L0706      get pointer to window table
         lbsr  L1BAD
         puls  d,y,u      restore registers
         lslb             adjust type for vector table
         leax  <L0DAC,pcr point to vector table
         ldd   b,x        get offset
         jmp   d,x        process type

L0DAC    fdb   L0F97-L0DAC Wt.NBox
         fdb   L0DB8-L0DAC Wt.FWin
         fdb   L0E5F-L0DAC Wt.FSWin
         fdb   $0131      Wt.SBox
         fdb   $01a0      Wt.DBox
         fdb   $0241      Wt.PBox

* Setup a framed window

L0DB8    lbsr  L0E7C
         bcc   L0DC5
         tst   >$100A
         beq   L0DC5
         lbsr  L0E89
L0DC5    lbsr  L10A9
         lda   #$01
         bsr   L0DF0
         bcc   L0DDA
L0DCE    pshs  b,cc
         tst   >$100A
         beq   L0DD8
         lbsr  L0EC0
L0DD8    puls  pc,b,cc

L0DDA    tst   >$100A
         beq   L0DE4
         lbsr  L130E
         bra   L0DE7
L0DE4    lbsr  L1063
L0DE7    bcs   L0DEF
         ldu   <D.CCMem
         lbsr  L1163
         clrb  
L0DEF    rts   

L0DF0    leas  -$24,s
         ldu   $06,y
         pshs  a
         lda   6,u
         lsla  
         lsla  
         lsla  
         lsla  
         ora   ,s+
         sta   ,x
         ldu   4,u
         stu   $05,x
         ldu   <D.Proc
         lda   P$ID,u
         sta   $0E,x
         tfr   u,d
         sta   $0F,x
         leau  ,s
         pshs  x
         ldx   <D.CCMem
         ldx   <$75,x
         leax  >$0240,x
         stx   <$24,s
         bsr   L0E55
         ldu   <D.CCMem
         ldx   ,s
         lbsr  L12AB
         lbsr  L0F46
         leau  ,x
         puls  x
         lda   -$09,y
         cmpa  <$15,u
         bcs   L0E3D
         lda   -$08,y
         cmpa  <$16,u
         bcc   L0E4D
L0E3D    clr   ,x
         leax  ,s
         ldu   <$22,s
         bsr   L0E55      move window descriptor
         comb  
         ldb   #$BD
         leas  <$24,s
         rts   
L0E4D    ldu   <D.CCMem
         leas  <$24,s
         lbra  L2112

* Move window descriptor from caller

L0E55    lda   #WN.SIZ
L0E57    ldb   ,x+
         stb   ,u+
         deca  
         bne   L0E57
         rts   

* Setup a framed window with scroll bars

L0E5F    bsr   L0E7C      window defined?
         bcc   L0E6A      yes, go on
         tst   >$100A
         beq   L0E6A
         bsr   L0E89
L0E6A    lbsr  L10A9
         lda   #$02
         lbsr  L0DF0
         lbcs  L0DCE
         lbsr  L21CB
         lbra  L0DDA

L0E7C    pshs  y,u
         lbsr  L0706      get pointer to window table
         coma             set carry
         lda   -$0E,y     window initialized?
         bpl   L0E87      yes, go on
         clra             clear carry
L0E87    puls  y,u,pc

L0E89    pshs  u,y
         lbsr  L0706
         lda   -$0E,y
         puls  u,y
         ldb   <$0035,u
         pshs  u,y,b
         sta   <$0035,u
         bsr   L0EA7
         bcs   L0EA1
         lbsr  L1060
L0EA1    puls  u,y,b
         stb   <$0035,u
         rts   

L0EA7    pshs  u,x,a
         tst   $0006,u
         bpl   L0EBD
         lbsr  L0711
         lda   ,x
         anda  #$0F
         beq   L0EBD
         cmpa  #$02
         bhi   L0EBD
         clra  
L0EBB    puls  pc,u,x,a
L0EBD    coma  
         bra   L0EBB

L0EC0    ldu   <D.CCMem
         ldu   >$00B7,u
L0EC6    lda   -$0E,y
         ldb   <$0035,u
         pshs  u,b
         sta   <$0035,u
         bsr   L0EA7
         bcs   L0ED7
         lbsr  L1316
L0ED7    puls  u,b
         stb   <$0035,u
         rts   

L0EDD    lbsr  L0FB4
         lbsr  L10A9
         leas  -$04,s
         lda   #$03
         sta   ,x
         bsr   L0F46
         lbsr  L1209
         pshs  x
         bsr   L0F41
         leax  <L0F0B,pcr
         bita  #$01
         beq   L0EFC
         leax  <L0F26,pcr
L0EFC    lbsr  L102B
         lbsr  L1029
         puls  x
L0F04    lbsr  L113B
         clrb  
L0F08    leas  $04,s
         rts   

L0F0B    fdb   $0000
         fdb   $0000
         fdb   $ffff
         fdb   $ffff
         fdb   $4cff
         fdb   $fe00
         fdb   $0280
         fdb   $0080
         fdb   $004e
         fdb   $0002
         fdb   $8000
         fdb   $8000
         fdb   $8000
         fcb   $4a

L0F26    fdb   $0000
         fdb   $0000
         fdb   $fffd
         fdb   $ffff
         fdb   $4cff
         fdb   $fe00
         fdb   $0280
         fdb   $0080
         fdb   $004e
         fdb   $0004
         fdb   $8000
         fdb   $8000
         fdb   $8000
         fcb   $4a

L0F41    lda   >$00BD,u
         rts   
L0F46    ldy   >$00BB,u
         rts   

         bsr   L0FB4
         lbsr  L10A9
         leas  -$04,s
         lda   #$04
         sta   ,x
         lbsr  L0FF6
         bcs   L0F08
         bsr   L0F46
         pshs  x
         leax  <L0F73,pcr
         lbsr  L1029
         bsr   L0F41
         bita  #$01
         beq   L0F6F
         lbsr  L1029
L0F6F    puls  x
         bra   L0F04

L0F73    fdb   $0003
         fdb   $0002
         fdb   $fffd
         fdb   $fffe
         fdb   $4c00
         fdb   $0400
         fdb   $03ff
         fdb   $fcff
         fdb   $fd4c
         fdb   $0005
         fdb   $0003
         fdb   $0006
         fdb   $fffd
         fdb   $4cff
         fdb   $fa00
         fdb   $03ff
         fdb   $fbff
         fdb   $fd4c

L0F97    bsr   L0FB4
         lbsr  L10B6
         clr   ,x
         ldy   >$00B9,u
         clra  
         clrb  
         std   -$0B,y
         ldd   <$28,y
         pshs  u,y
         lbsr  L114C
         puls  u,y
         lbra  L1209
L0FB4    pshs  u,y
         lbsr  L0E7C
         bcc   L0FEB
         lbsr  L0711
         lda   ,x
         anda  #$0F
         beq   L0FEB
         cmpa  #$02
         bhi   L0FEB
         tst   >$100A
         beq   L0FEB
         ldu   $02,s
         lbsr  L0706
         ldu   $02,s
         lda   <$0035,u
         pshs  a
         lda   -$0E,y
         sta   <$0035,u
         lbsr  L0EA7
         puls  a
         sta   <$0035,u
         bcs   L0FEB
         lbsr  L0EC6
L0FEB    puls  pc,u,y

         bsr   L0FB4
         lbsr  L10A9
         lda   #$05
         sta   ,x
L0FF6    lbsr  L0F46
         lbsr  L1209
         lbsr  L1198
         bsr   L100D
         lbsr  L0AA0
         bsr   L1009
         lbra  L1173
L1009    ldb   -$08,y
         bra   L100F
L100D    ldb   -$09,y
L100F    clra  
         tstb  
         beq   L1018
         bsr   L1019
         subd  #$0001
L1018    rts   

L1019    clra  
         lslb  
         rola  
         lslb  
         rola  
         lslb  
         rola  
         rts   

L1021    asra  
         rorb  
         asra  
         rorb  
         asra  
         rorb  
         clra  
         rts   

L1029    bsr   L102B
L102B    bsr   L1048
         lbsr  L0A9B
         bsr   L104C
         lbsr  L0A64
         bsr   L1048
         lbsr  L0AA0
         bsr   L104C
         lbsr  L0A87
         ldb   ,x+
         pshs  u,y,x
         lbsr  L0105
         puls  pc,u,y,x

L1048    bsr   L100D
         bra   L104E
L104C    bsr   L1009
L104E    pshs  b,a
         ldd   ,x++
         bpl   L105D
         cmpd  #$8000
         bne   L105B
         clra  
L105B    addd  ,s
L105D    leas  $02,s
         rts   

L1060    lbsr  L10B6
L1063    lbsr  L2115
         lbsr  L1989
         lbsr  L12AB
         bne   L1096
         lbsr  L1264
         lbsr  L1222
         lbsr  L1289
         lbsr  L11ED
         subb  #$02
         cmpb  -$09,y
         bls   L1084
         ldb   -$09,y
         bra   L1086
L1084    addb  #$02
L1086    pshs  b
         lda   -$09,y
         suba  ,s
         lsra  
         clrb  
         lbsr  L11CF
         puls  b
         lbsr  L11F9
L1096    clra  
         bsr   L109A
         rts   

L109A    pshs  u,y,x
         ldu   <D.CCMem
         ldu   >$00B7,u
         lbsr  L0711
         sta   $04,x
         puls  pc,u,y,x

L10A9    bsr   L10B6
         lbsr  L0F41
         bpl   L10B5
         leas  2,s        purge return address
         comb             set carry
         ldb   #$B7       get illegal window type error
L10B5    rts              return to caller

L10B6    pshs  y
         ldx   <D.CCMem
         stu   >$00B7,x
         sty   >$00C0,x
         lbsr  L06F8      get window table pointer & device mem pointer
         sty   >$00B9,u
         ldx   Wt.STbl,y
         lda   ,x
         sta   >$00BD,u
         ldu   >$00B7,u
         lbsr  L0711
         leay  >$0087,u
         sty   >$00BB,u
         pshs  x
         ldx   >$00B9,u
         ldd   Wt.LStDf,x get screen logical start default
         std   Wt.LStrt,y set it as screen start
         ldd   Wt.DfCPX,x get CPX,CPY defaults
         std   Wt.CPX,y   set it in current
         ldd   Wt.DfSZX,x get SZX,SZY defaults
         std   Wt.SZX,y   set it in current table
         ldd   Wt.STbl,x
         std   Wt.STbl,y
         lda   Wt.BLnk,x  get back window link
         sta   Wt.BLnk,y  set it in current table
         ldd   Wt.Cur,x
         std   Wt.Cur,y
         ldd   -$02,x
         std   -$02,y
         ldd   Wt.XBCnt,x
         std   Wt.XBCnt,y
         ldd   Wt.BRow,x
         std   Wt.BRow,y
         lda   Wt.FBlk,x
         sta   Wt.FBlk,y
         ldd   Wt.FOff,x
         std   Wt.FOff,y
         clr   Wt.BSW,y
         lbsr  L1279      set pattern
         lbsr  L1282      set LSET #
         ldb   Wt.DfSZX,x
         lbsr  L100F
         std   Wt.MaxX,y
         ldb   Wt.DfSZY,x
         lbsr  L100F
         std   Wt.MaxY,y
         puls  x
         ldd   $07,x
         std   $06,y
         puls  y
L113A    rts   

L113B    ldy   >$00B9,u
         ldd   #$0101
         std   -$0B,y
         ldd   <$28,y
L1148    decb  
         decb  
         deca  
         deca  
L114C    std   -$09,y
         ldb   #$0E
         lbsr  L0105
         bcs   L113A
         ldx   <D.CCMem
         ldu   >$00B7,x
         ldy   >$00C0,x
         lbra  L048E
L1163    ldy   >$00B9,u
         ldd   #$0102
         std   -$0B,y
         ldd   <$28,y
         decb  
         bra   L1148
L1173    lbsr  L0A87
         ldb   #$4C
L1178    pshs  u,y,x
         lbsr  L0105
         puls  pc,u,y,x

         ldb   #$4A
         bra   L1178
         lbsr  L0F46
         bsr   L1198
         lbsr  L100D
         lbsr  L0AA0
         ldd   #$0007
         lbsr  L0A87
         ldb   #$4E
         bra   L1178
L1198    clra  
         clrb  
         lbsr  L0A9B
         lbra  L0A64
         lda   #$C1
         bra   L11C6
         lda   #$C2
         bra   L11C6
         lda   #$C3
         bra   L11C6
         lda   #$C4
         bra   L11C6
         lda   #$C9
L11B2    bsr   L120D
         bsr   L11C6
         bra   L1222
         lda   #$CA
         bra   L11B2
L11BC    lda   #$C7
         bra   L11B2
L11C0    lda   #$CB
         bra   L11B2
L11C4    lda   #$20
L11C6    pshs  u,y,x,b,a
         ldb   #$3A
L11CA    lbsr  L0105
         puls  pc,u,y,x,b,a

L11CF    adda  #$20
         addb  #$20
         pshs  u,y,x
         sta   >$0147,u
         stb   >$0149,u
         ldb   #$42
         lbsr  L0105
         puls  pc,u,y,x

L11E4    bsr   L11ED
         cmpb  #$0F
         bls   L11EC
         ldb   #$0F
L11EC    rts   

L11ED    pshs  x,a
         clrb  
L11F0    lda   ,x+
         beq   L11F7
         incb  
         bra   L11F0
L11F7    puls  pc,x,a

L11F9    lda   ,x+
         bsr   L11C6
         decb  
         bne   L11F9
         rts   

L1201    lda   #$04
L1203    pshs  u,y,x,b,a
         ldb   #$3C
         bra   L11CA
L1209    lda   #$0C
         bra   L1203
L120D    pshs  u,y,x,b,a
         ldx   <$75,u
         leax  >$02B9,x
         lda   ,x
         beq   L1234
L121A    sta   $0B,y
         ldd   $01,x
         std   $0C,y
         puls  pc,u,y,x,b,a

L1222    pshs  u,y,x,b,a
         ldx   <$75,u
         leax  >$02B6,x
         lda   ,x
         bne   L121A
         ldd   #$C804
         bra   L1237
L1234    ldd   #$C803
L1237    pshs  u,y,x
         lbsr  L0896
         ldb   #$18
         lbsr  L0105
         puls  u,y,x
         lda   $0B,y
         sta   ,x
         ldd   $0C,y
         std   $01,x
         puls  pc,u,y,x,b,a

L124D    lda   #$01
L124F    pshs  u,y,x,a
         lbsr  L0F41
         bpl   L1258
         puls  pc,u,y,x,a

L1258    lda   ,s+
         ldb   #$2A
L125C    lbsr  L0105
         puls  pc,u,y,x

L1261    clra  
         bra   L124F
L1264    lda   #$01
L1266    ldb   #$24
L1268    pshs  u,y,x
         bra   L125C
L126C    clra  
         bra   L1266
L126F    lda   #$20
L1271    ldb   #$40
         bra   L1268
L1275    lda   #$21
         bra   L1271
L1279    clra  
         clrb  
         lbsr  L0896
         ldb   #$12
         bra   L1268
L1282    clra  
         sta   $0A,y
         ldb   #$1E
         bra   L1268
L1289    lda   #$01
L128B    ldb   #$26
         bra   L1268
L128F    clra  
         bra   L128B
L1292    pshs  u,y,x,b,a
         lbsr  L06F8
         ldu   $06,s
         lbsr  L0711
         ldd   $06,y
         std   $07,x
         lbsr  L0B2D
         std   $09,x
         clra  
         clrb  
         std   $05,x
         puls  pc,u,y,x,b,a

L12AB    pshs  u,y,b,a
         bsr   L12D6
         bcs   L12D1
         ldx   $05,x
         leau  >$0240,u
         ldy   #$0022
L12BB    leas  -$02,s
         lbsr  L023B
         os9   F$CpyMem
         lbsr  L0247
         leas  $02,s
         tfr   u,x
         ldd   <$17,x
         cmpd  #$C0C0
L12D1    puls  pc,u,y,b,a

L12D3    lbsr  L0711
L12D6    ldu   <$75,u
         ldy   <$0048
         ldb   $0E,x
         lda   b,y
         cmpa  $0F,x
         bne   L12E9
         ldb   #$40
         andcc  #^Carry
         rts   
L12E9    orcc  #Carry
         rts   

L12EC    pshs  u,y,b,a
         pshs  x
         bsr   L12D3
         puls  x
         bcs   L12D1
         leau  >$0262,u
         ldy   #$0017
         bra   L12BB
L1300    pshs  u,y,x
         lbsr  L0711
         lda   $04,x
         puls  pc,u,y,x

SSUMBar  clra  
         pshs  a
         bra   L131A
L130E    clra  
         pshs  a
         bra   L1321
L1313    lbra  L140E
L1316    bsr   L1300
         pshs  a
L131A    lbsr  L10B6
         tst   ,s
         bne   L1324
L1321    lbsr  L2115
L1324    puls  a
         leas  -$09,s
         sta   $08,s
         clr   $02,s
         lbsr  L0F46
         tst   $08,s
         bne   L133C
         lbsr  L126F
         lbsr  L1264
         lbsr  L1222
L133C    clra  
         sta   $05,s
         clrb  
         tst   $08,s
         bne   L1347
         lbsr  L11CF
L1347    ldb   -$09,y
         subb  #$02
         stb   ,s
         ldb   #$02
         stb   $01,s
         tst   $08,s
         bne   L135E
         lbsr  L11C4
         lbsr  L1261
         lbsr  L11BC
L135E    ldy   <$75,u
         leay  >$028E,y
         clr   ,y
         lbsr  L12AB
         bne   L1313
         ldd   <$15,x
         std   <$26,y
         lda   <$14,x
         beq   L1313
         cmpa  #$0A
         bhi   L1313
         sta   $04,s
         ldx   <$20,x
L1381    stx   $06,s
         pshs  u
         ldu   <D.CCMem
         ldu   >$00B7,u
         lbsr  L12EC
         puls  u
         lbsr  L0F46
         tst   $08,s
         bne   L13A4
         lda   <$12,x
         beq   L13A1
         lbsr  L124D
         bra   L13A4
L13A1    lbsr  L1261
L13A4    lda   $0F,x
         cmpa  #$14
         bne   L13CC
         lbsr  L0F46
         tst   $08,s
         bne   L13BA
         lbsr  L11C4
         lbsr  L11C0
         lbsr  L11C4
L13BA    ldb   #$01
         stb   $03,s
         pshs  b
         bsr   L1422
         leas  $01,s
         ldb   ,s
         subb  #$03
         stb   ,s
         bra   L1401
L13CC    leax  ,x
         lbsr  L11E4
         stb   $03,s
         cmpb  ,s
         bls   L13DF
         ldb   ,s
         subb  #$01
         bls   L140E
         inc   $02,s
L13DF    pshs  b
         lbsr  L0F46
         tst   $09,s
         bne   L13F5
         lbsr  L11C4
         lbsr  L11F9
         tst   $03,s
         bne   L13F5
         lbsr  L11C4
L13F5    bsr   L1422
         inc   ,s
         inc   ,s
         ldb   $01,s
         subb  ,s+
         stb   ,s
L1401    ldx   $06,s
         leax  <$17,x
         inc   $05,s
         dec   $04,s
         lbne  L1381
L140E    lbsr  L0F46
         tst   $08,s
         bne   L1418
         lbsr  L1275
L1418    lda   #$01
         lbsr  L109A
         ldu   <$00A5
         leas  $09,s
         rts   

L1422    pshs  x,b,a
         ldx   <$75,u
         leax  >$028E,x
         ldb   $0C,s
         pshs  b
         lda   #$03
         mul   
         leax  d,x
         puls  b
         incb  
         stb   ,x
         ldb   $08,s
         stb   $01,x
         addb  $0A,s
         incb  
         stb   $02,x
         incb  
         stb   $08,s
         clr   $03,x
         puls  pc,x,b,a

L1449    lbra  L1559
L144C    leas  <-$25,s
         stu   ,s
         sty   <$18,s
         clr   <$22,s
         tst   >$100A
         beq   L1449
         ldx   <$00A5
         leax  <$3C,x
         lbsr  L06F8
         lbsr  L1B2E
         leax  <$20,x
         lbsr  L1A5C
         bcs   L147E
         lbsr  L156B
         ldd   <$13,s
         lbsr  L1D08
         tsta  
         lbne  L155B
L147E    lda   <$14,s
         beq   L1496
         inca  
         cmpa  <$29,y
         beq   L1496
         ldb   <$13,s
         beq   L1496
         incb  
         cmpb  <$28,y
         lbne  L1559
L1496    ldx   <$00A5
         lda   #$FF
         sta   >$00BF,x
         leax  <$3C,x
         clr   >$100E
L14A4    tst   $08,x
         bne   L14A4
         inc   >$100E
         lbsr  L1B2E
         leax  <$20,x
         lbsr  L1A5C
         bcs   L1449
         lbsr  L156B
         lda   <$14,s
         bne   L14FA
         ldb   <$13,s
         lbeq  L1D64
         cmpb  #$02
         bhi   L14CD
         lda   #$02
         bra   L14F3
L14CD    ldx   <$75,u
         leax  >$028E,x
L14D4    lda   ,x
         lbeq  L1449
         cmpb  $02,x
         bhi   L14F6
         lbsr  L15E2
         pshs  u,a
         ldu   $03,s
         lda   <$24,s
         sta   <$0026,u
         ldu   <$00A5
         clr   >$00C6,u
         puls  u,a
L14F3    lbra  L155B
L14F6    leax  $03,x
         bra   L14D4
L14FA    pshs  u,y,x
         ldu   $06,s
         lbsr  L0711
         ldd   <$10,x
         std   <$29,s
         lda   ,x
         anda  #$07
         cmpa  #$02
         puls  u,y,x
         lbne  L1CFB
         ldd   $0F,s
         subd  #$0007
         cmpd  $07,s
         bhi   L153B
         ldd   $0D,s
         subd  #$0008
         cmpd  $05,s
         lbcs  L1D5F
         lda   #$07
         ldb   <$13,s
         subb  #$01
         bmi   L1539
         cmpb  <$23,s
         bcs   L1539
         lda   #$06
L1539    bra   L155B
L153B    ldd   $0D,s
         subd  #$0007
         cmpd  $05,s
         lbhi  L1CFB
         lda   #$04
         ldb   <$14,s
         subb  #$02
         bmi   L1557
         cmpb  <$24,s
         bcs   L1557
         lda   #$05
L1557    bra   L155B
L1559    clra  
         clrb  
L155B    ldy   <$18,s
         ldx   $06,y
         std   $01,x
         leas  <$25,s
         clr   >$10BF
         clrb  
         rts   

L156B    bsr   L15AD
         std   $0D,s
         ldb   <$26,y
         addb  $0D,s
         lbsr  L100F
         pshs  b,a
         ldd   ,x
         subd  ,s++
         std   $07,s
         lbsr  L1021
         stb   <$15,s
         ldb   <$27,y
         addb  $0E,s
         lbsr  L100F
         pshs  b,a
         ldd   $02,x
         subd  ,s++
         std   $09,s
         lbsr  L1021
         stb   <$16,s
         ldb   <$28,y
         lbsr  L100F
         std   $0F,s
         ldb   <$29,y
         lbsr  L100F
         std   <$11,s
         rts   

L15AD    clra  
         clrb  
         pshs  x,b,a
         lda   -$0E,y
         bmi   L15C3
L15B5    lbsr  L1AD0
         lda   -$0E,x
         bpl   L15B5
         ldd   <$26,x
         addd  -$0B,x
         std   ,s
L15C3    puls  pc,x,b,a

L15C5    pshs  u,x
         bsr   L15AD
         addb  <$27,y
         incb  
         ldx   ,s
         lbsr  L100F
         addd  #$0001
         pshs  b,a
         ldd   $02,x
         subd  ,s++
         lbsr  L1021
         tfr   b,a
         puls  pc,u,x

L15E2    stx   $0B,s
         ldy   <$1A,s
         ldu   $02,s
         ldb   <$0026,u
         stb   <$23,s
         clr   <$0026,u
         lbsr  L18BE
         stx   <$1E,s
         sty   <$13,s
         ldx   <$75,u
         leax  >$0240,x
         ldx   <$20,x
L1607    deca  
         beq   L160F
         leax  <$17,x
         bra   L1607
L160F    pshs  u
         ldu   $04,s
         lbsr  L12EC
         puls  u
         stx   $05,s
         lda   <$12,x
         bne   L1624
         clra  
         clrb  
         lbra  L17F9
L1624    ldu   $0B,s
         ldy   <$13,s
         lda   $0001,u
         clrb  
         ldu   <$00A5
         lbsr  L1222
         lbsr  L11CF
         lbsr  L124D
         lbsr  L126C
         lbsr  L11E4
         lbsr  L190A
         lbsr  L11C4
         lda   $0F,x
         cmpa  #$14
         bne   L164F
         lbsr  L11C0
         bra   L1652
L164F    lbsr  L11F9
L1652    tst   <$19,s
         bne   L165A
         lbsr  L11C4
L165A    lbsr  L1261
         ldx   $05,s
         lda   <$11,x
         bne   L166A
         lda   $0F,x
         clrb  
         lbra  L17F9
L166A    lda   <$10,x
         adda  #$02
         pshs  a
         ldu   $0C,s
         adda  $0001,u
         cmpa  -$09,y
         bcc   L167D
         lda   $0001,u
         bra   L1681
L167D    lda   -$09,y
         suba  ,s
L1681    puls  b
         ldu   $02,s
         lbsr  L0802
         sty   <$1C,s
         stb   -$09,y
         ldb   #$01
         ldy   <$13,s
         tst   -$0E,y
         bmi   L169B
         addd  <$26,y
L169B    ldy   <$1C,s
         std   -$0B,y
         lda   #$01
         sta   >$0159,u
         lda   <$11,x
         adda  #$02
         pshs  x
         ldx   <$15,s
         cmpa  -$08,x
         bcs   L16C3
         lda   -$08,x
         deca  
         sta   -$08,y
         suba  #$02
         puls  x
         sta   <$11,x
         bra   L16C7
L16C3    puls  x
         sta   -$08,y
L16C7    ldx   <$1E,s
         ldd   $09,x
         std   $06,y
         pshs  u,y
         ldb   #$0A
         lbsr  L0105
         puls  u,y
         bcc   L16ED
         lda   -$0E,y
         ldu   $02,s
         sta   <$0035,u
         ldd   #$FFFF
         std   -$10,y
         lbsr  L18AC
         clra  
         clrb  
         lbra  L17F9
L16ED    ldd   #$CA01
         lbsr  L0896
         pshs  y,x
         ldb   #$1A
         lbsr  L0105
         puls  y,x
         ldu   $02,s
         lbsr  L1292
         ldy   <$1A,s
         lbsr  L0EDD
         lbcs  L17F5
         ldu   <$00A5
         ldy   <$1C,s
         pshs  u,y
         lda   #$20
         ldb   #$3E
         lbsr  L0105
         puls  u,y
         ldx   $05,s
         ldb   <$11,x
         stb   <$18,s
         clr   <$17,s
         ldx   <$15,x
         lbsr  L1222
L172E    stx   <$20,s
         lbsr  L1CCD
         tst   $0F,x
         bne   L173D
         lbsr  L1261
         bra   L1740
L173D    lbsr  L124D
L1740    clra  
         ldb   <$17,s
         lbsr  L11CF
         lbsr  L11E4
         lbsr  L11F9
         ldx   <$20,s
         leax  <$15,x
         inc   <$17,s
         dec   <$18,s
         bne   L172E
         lda   #$FF
         sta   $04,s
         ldu   <$00A5
         sta   >$00BF,u
         lda   <$0060,u
         sta   <$22,s
         lda   #$02
         sta   <$0060,u
         sta   <$003B,u
L1773    clr   >$100E
         ldx   #$0001
         os9   F$Sleep
         inc   >$100E
         ldu   <$00A5
         lda   >$00BF,u
         bmi   L1791
         beq   L1802
         clr   >$00BF,u
         lda   #$08
         bra   L17F7
L1791    leax  <$003C,u
         tst   $08,x
         bne   L17D4
         lbsr  L1B2E
         lbsr  L1A65
         bcc   L17BF
         bsr   L1809
         leax  <$003C,u
         leax  <$20,x
         lbsr  L1A5C
         bcs   L17B8
         lda   #$01
         sta   <$24,s
         lda   #$FF
         sta   $04,s
         bra   L1773
L17B8    tst   <$24,s
         bne   L17F5
         bra   L1773
L17BF    lda   #$01
         sta   <$24,s
         lbsr  L15C5
         sta   <$16,s
         cmpa  $04,s
         beq   L1773
         bsr   L1809
         bsr   L182F
         bra   L1773
L17D4    lbsr  L18B5
         lbsr  L1B2E
         lbsr  L1A65
         bcs   L17F5
         lda   $04,s
         leas  -$02,s
         lbsr  L1865
         leas  $02,s
         lda   $0F,x
         beq   L17F5
         ldx   $05,s
         lda   $0F,x
         ldb   $04,s
         incb  
         bra   L17F7
L17F5    clra  
         clrb  
L17F7    bsr   L1876
L17F9    pshs  b,a
         ldu   $04,s
         lbsr  L18E3
         puls  pc,b,a

L1802    clra  
         clrb  
         lbsr  L1887
         bra   L17F9
L1809    lda   $06,s
         bmi   L182E
         lbsr  L1275
         lda   $06,s
         bsr   L1865
         tst   $0F,x
         beq   L182E
         lbsr  L124D
         lbsr  L11E4
         pshs  b
         clra  
         ldb   $07,s
         lbsr  L11CF
         lbsr  L1201
         puls  b
         lbsr  L11F9
L182E    rts   

L182F    lbsr  L126F
         lda   <$18,s
         bsr   L1865
         tst   $0F,x
         beq   L185F
         lbsr  L124D
         lbsr  L11E4
         pshs  b
         clra  
         ldb   <$19,s
         lbsr  L11CF
         ldb   ,s
         lbsr  L11F9
         ldx   $08,s
         ldb   <$10,x
         subb  ,s+
         decb  
L1857    decb  
         bmi   L185F
         lbsr  L11C4
         bra   L1857
L185F    lda   <$18,s
         sta   $06,s
         rts   

L1865    ldx   $09,s
         ldx   <$15,x
L186A    deca  
         bmi   L1872
         leax  <$15,x
         bra   L186A
L1872    lbsr  L1CCD
         rts   

L1876    pshs  b,a
         bsr   L188D
         ldu   <$00A5
         lda   <$26,s
         sta   <$0060,u
         sta   <$003B,u
         bra   L18AE
L1887    pshs  b,a
         bsr   L188D
         bra   L18AE
L188D    ldy   <$22,s
         ldu   $08,s
         lda   -$0E,y
         sta   <$0035,u
         ldd   <$24,y
         std   -$0D,y
         ldd   <$26,y
         std   -$0B,y
         ldd   <$28,y
         std   -$09,y
         ldb   #$0C
         lbra  L0105
L18AC    pshs  b,a
L18AE    ldu   $06,s
         lbsr  SSUMBar
         puls  pc,b,a

L18B5    tst   $08,x
         bne   L18B5
         clr   $0A,x
         clr   $0C,x
         rts   

L18BE    pshs  b,a
         lbsr  L0706
         ldx   <$75,u
         leax  >$02CF,x
         bsr   L18F0
         lbsr  L0546
         ldu   $06,s
         lbsr  L0711
         ldd   $07,x
         std   $06,y
         lbsr  L128F
         lbsr  L1279
         lbsr  L1282
         puls  pc,b,a

L18E3    lbsr  L0706
         tfr   y,x
         ldy   <$75,u
         leay  >$02CF,y
L18F0    pshs  u,y,x,b,a
         leax  -$10,x
         leay  -$10,y
         ldb   #$40
L18F8    pshs  b
         ldd   ,y++
         ldu   ,y++
         std   ,x++
         stu   ,x++
         puls  b
         subb  #$04
         bgt   L18F8
         puls  pc,u,y,x,b,a

L190A    leas  -$02,s
         bsr   L1911
         leas  $02,s
         rts   

L1911    ldu   <$11,s
         lda   $0001,u
         pshs  b
         adda  ,s+
         pshs  a
         inca  
         inca  
         cmpa  -$09,y
         bls   L1932
         lda   ,s
         inca  
         cmpa  -$09,y
         bls   L192E
         ldb   -$09,y
         subb  $0001,u
         decb  
L192E    lda   #$01
         bra   L1933
L1932    clra  
L1933    sta   <$20,s
         ldu   <$00A5
         puls  pc,a

******************************
*
* SS.Bar Entry point
*

SSSBar   pshs  u          Save device mem pointer
         lbsr  L10B6
         ldx   PD.RGS,y
         lbsr  L0F46
         lbsr  L1264
         pshs  u,y,x
         lbsr  L2259
         puls  u,y,x
         bsr   L1989
         lda   $05,x
         adda  #$05
         cmpa  -$09,y
         bls   L195E
         lda   -$09,y
         suba  #$03
         bra   L1960
L195E    suba  #$04
L1960    ldb   -$08,y
         decb  
         lbsr  L22E0
         lda   -$09,y
         deca  
         ldb   $07,x
         addb  #$06
         cmpb  -$08,y
         bls   L1977
         ldb   -$08,y
         subb  #$03
         bra   L1979
L1977    subb  #$04
L1979    lbsr  L22E8
         puls  u
         lda   $05,x
         ldb   $07,x
         lbsr  L0711
         std   <$10,x
         rts   

L1989    ldd   $06,y
         exg   a,b
         std   $06,y
         rts   

L1990    leas  -$05,s
         clr   $04,s
         ldu   <$00A5
         leax  <$0054,u
         ldd   ,x
         std   ,s
         ldd   $02,x
         std   $02,s
         ldu   <$0020,u
         lbsr  L06F8
         ldx   -$10,y
         lda   ,x
         bita  #$01
         bne   L19BA
         lsr   ,s
         ror   $01,s
         lda   <$67,u
         lbeq  L1B46
L19BA    leax  ,s
         lbsr  L1A68
         bcs   L19DA
         ldu   <$00A5
         ldu   <$0020,u
         lbsr  L0711
         lda   <$18,y
         beq   L19D6
         ldd   $0C,x
         cmpd  <$19,y
         beq   L1A1B
L19D6    inc   $04,s
         bra   L1A1B
L19DA    ldx   <$75,u
         leax  >$02BC,x
         ldd   ,x
         bne   L1A00
         ldd   #$CA01
         lbsr  L0896
         pshs  u,y,x
         ldb   #$1A
         lbsr  L0105
         puls  u,y,x
         lda   <$18,y
         sta   ,x
         ldd   <$19,y
         std   $01,x
         bra   L1A14
L1A00    pshs  a
         ldd   <$19,y
         cmpd  $01,x
         puls  a
         beq   L1A1B
         sta   <$18,y
         ldd   $01,x
         std   <$19,y
L1A14    pshs  u,y,x
         lbsr  L0D37
         puls  u,y,x
L1A1B    ldd   ,s
         std   >$015B,u
         ldd   $02,s
         std   >$015D,u
         ldb   #$44
         pshs  u,y
         lbsr  L0105
         puls  u,y
         tst   $04,s
         beq   L1A59
         ldu   <$0020,u
         lbsr  L0711
         lda   $0B,x
         bne   L1A4A
         lda   <$18,y
         sta   $0B,x
         ldd   <$19,y
         std   $0C,x
         bra   L1A52
L1A4A    sta   <$18,y
         ldd   $0C,x
         std   <$19,y
L1A52    pshs  u,y,x
         lbsr  L0D37
         puls  u,y,x
L1A59    lbra  L1B46
L1A5C    pshs  pc,u,y

         leay  <$26,y
         bsr   L1AAF
         bra   L1A6E
L1A65    leax  <$20,x
L1A68    pshs  pc,u,y

         leay  -$0B,y
         bsr   L1AA4
L1A6E    ldb   $02,s
         lbsr  L1019
         cmpd  ,x
         bhi   L1A9D
         ldb   $02,s
         addb  $04,s
         lbsr  L1019
         cmpd  ,x
         bls   L1A9D
         ldb   $03,s
         lbsr  L1019
         cmpd  $02,x
         bhi   L1A9D
         ldb   $03,s
         addb  $05,s
         lbsr  L1019
         cmpd  $02,x
         bls   L1A9D
         clra  
         bra   L1A9E
L1A9D    coma  
L1A9E    ldy   ,s
         leas  $06,s
         rts   

L1AA4    pshs  x
         ldx   $04,s
         ldd   -$0B,x
         addd  <$26,x
         bra   L1AB3
L1AAF    pshs  x
         ldd   ,y
L1AB3    std   $06,s
         ldd   $02,y
         std   $08,s
         ldx   $04,s
         lda   -$0E,x
         bmi   L1ACE
L1ABF    bsr   L1AD0
         lda   -$0E,x
         bpl   L1ABF
         ldd   $06,s
         addd  <$26,x
         addd  -$0B,x
         std   $06,s
L1ACE    puls  pc,x

L1AD0    ldb   #$40
         mul   
         ldu   <$00A5
         leax  >$0290,u
         leax  d,x
         rts   

L1ADC    lbsr  L06F8
         bsr   L1B2E
         pshs  x
         lbsr  L1A65
         bcs   L1AF3
         bsr   L1B07
         lda   #$00
L1AEC    puls  x
         sta   <$16,x
         clrb  
         rts   

L1AF3    bsr   L1B00
         lbsr  L1A5C
         lda   #$01
         bcc   L1AEC
         lda   #$02
         bra   L1AEC
L1B00    clra  
         clrb  
         std   -$04,x
         std   -$02,x
         rts   

L1B07    pshs  pc,u,y
         leay  -$0B,y
         lbsr  L1AA4
         ldb   $02,s
         lbsr  L1019
         pshs  b,a
         ldd   ,x
         subd  ,s++
         std   -$04,x
         ldb   $03,s
         lbsr  L1019
         pshs  b,a
         ldd   $02,x
         subd  ,s++
         std   -$02,x
         ldy   ,s
         leas  $06,s
         rts   

L1B2E    leax  <$003C,u
         lda   [<-$10,y]
         lsra  
         ldd   <$1A,x
         std   <$22,x
         ldd   <$18,x
         bcs   L1B42
         lsra  
         rorb  
L1B42    std   <$20,x
         rts   

L1B46    ldx   -$10,y
         pshs  y,x
         ldu   <$00A5
         lda   >$00BF,u
         bmi   L1B9B
         lda   <$0044,u
         beq   L1B9B
         leax  $04,s
         lbsr  L1A5C
         bcc   L1B9B
         ldb   #$20
         stb   $08,s
         leax  >$01C0,u
L1B66    lda   ,x+
         ldb   #$40
         mul   
         leay  >$0290,u
         leay  d,y
         cmpy  $02,s
         beq   L1B97
         ldd   -$10,y
         cmpd  ,s
         bne   L1B97
         lda   -$0E,y
         bpl   L1B97
         lda   <$2B,y
         beq   L1B97
         lda   $09,y
         bita  #$01
         beq   L1B97
         pshs  x
         leax  $06,s
         lbsr  L1A5C
         puls  x
         bcc   L1B9E
L1B97    dec   $08,s
         bne   L1B66
L1B9B    leas  $09,s
         rts   

L1B9E    lda   <$2B,y
         clrb  
         tfr   d,u
         tfr   u,x
         ldu   <$00A5
         leas  $09,s
         lbra  L05D5
L1BAD    pshs  u,b,a
         ldu   <$2E,y
         beq   L1BBA
         ldd   #$0100
         os9   F$SRtMem
L1BBA    clra  
         clrb  
         std   <$2E,y
         puls  pc,u,b,a

* New SetStt call GIP2 entry point

SSGIP2   ldx   PD.RGS,y   get callers register pointer
         pshs  x          save it
         lbsr  L06F8      get window table pointer
         ldu   <$2E,y  get window number from dev desc
         bne   L1BE1      something there, go on
         ldd   #$0001     get a page of system memory
         os9   F$SRqMem
         bcs   L1BFA
         tfr   u,x        move pointer of mem to X
         stu   <$2E,y     save pointer in window table
         clra             get initialization value
         clrb             get size
L1BDC    sta   ,x+        clear a byte
         decb             done?
         bne   L1BDC      no, keep going

L1BE1    ldx   ,s         get register stack pointer
         ldx   R$X,x      get callers X
         lbsr  L1CC2      move the 32 bytes

         ldb   #$14       get size of table??
L1BEA    lda   1,u        already initialized?
         beq   L1BFC      no, go move ???
         cmpa  1,x        same?
         beq   L1BFC      yes, go move ???
         leau  11,u       move to next entry
         decb             done?
         bne   L1BEA      no, keep going
         comb             set carry for error
         ldb   #$64       get error code (new doesn't exist)
L1BFA    puls  pc,x

* U=Pointer to buffer from window table (offset $2e in table entry)
* X=Pointer to callers data

L1BFC    lda   1,x
         sta   1,u
         lda   8,x
         sta   8,u
         lda   2,x
         sta   2,u
         lda   ,x
         sta   ,u
         ldd   3,x
         std   3,u
         ldd   5,x
         std   5,u
         stx   9,u
         puls  x          restore callers X pointer
         ldd   4,x
         ldx   9,u
         std   9,u
         lda   ,u
         exg   x,u        swap pointers
         bsr   L1C30
         cmpa  #$00
         lbeq  L1C78
         cmpa  #$01
         beq   L1C3D
         clrb  
         rts   

L1C30    pshs  u,x,a      preserve registers
         ldu   >$100C     get device static mem pointer
         lbsr  L10B6
         lbsr  L0F46
         puls  pc,u,x,a   restore & return to caller

L1C3D    clra  
         clrb  
         bsr   L1C54
         ldd   $0009,u
         lbsr  L1CB1
         ldd   <$0011,u
         bsr   L1C54
         ldd   $000B,u
         bsr   L1CB1
         clrb  
         rts   

L1C51    lda   #$08
         mul   
L1C54    pshs  u,b,a
         ldu   <$00A5
         ldb   $04,x
         lda   #$08
         mul   
         tst   $02,x
         bne   L1C63
         addd  ,s
L1C63    std   >$0149,u
         ldb   $03,x
         lda   #$08
         mul   
         tst   $02,x
         beq   L1C72
         addd  ,s
L1C72    std   >$0147,u
         puls  pc,u,b,a

L1C78    ldd   $000F,u
         std   $09,x
         ldb   $000E,u
         beq   L1C8C
         pshs  b
         clrb  
L1C83    bsr   L1C8E
         incb  
         dec   ,s
         bne   L1C83
         leas  $01,s
L1C8C    clrb  
         rts   

L1C8E    pshs  u,y,x,b
         bsr   L1C51
         ldx   $09,x
         lda   #$20
         ldb   ,s
         mul   
         leax  d,x
         bsr   L1CD8
         lda   <$14,x
         tfr   a,b
         beq   L1CA8
         deca  
         beq   L1CA8
         deca  
L1CA8    lslb  
         addb  #$16
         ldd   b,x
         bsr   L1CB1
         puls  pc,u,y,x,b

L1CB1    pshs  u,y,x
         ldu   <$00A5
         std   >$0157,u
         beq   L1CC0
         ldb   #$36       get callcode for PutBlk
         lbsr  L0105      send it to grfdrv
L1CC0    puls  pc,u,y,x   restore & return

* Move 32 bytes of data to offset $0240 in GFX table

L1CC2    pshs  u,y,b,a    preserve registers
         ldd   #$0240     get offset to where it goes
         ldy   #$0020     get # bytes
         bra   L1CE1      go move 'em

L1CCD    pshs  u,y,b,a
         ldd   #$0279
         ldy   #$0015
         bra   L1CE1

L1CD8    pshs  u,y,b,a
         ldd   #$0260
         ldy   #$0020

******************************
*
* Move data to GFX tables
*
* Entry: X=Source pointer
*        D=Offset into table
*        Y=Number of bytes
* Exit : X=Destination pointer
*

L1CE1    ldu   <D.CCMem   get global mem pointer
         ldu   G.GfxTbl,u    get GFX table pointer
         leau  d,u        offset to buffer
         pshs  x          preserve source for a sec
         ldx   <D.Proc    get current process descriptor
         lda   P$Task,x   get it's task #
         ldx   <D.SysPrc  get system process descriptor
         ldb   P$Task,x   get system task #
         puls  x          restore source pointer
         os9   F$Move     move the data
         tfr   u,x        move destination to X
         puls  d,y,u,pc   restore & return

L1CFB    ldu   ,s
         lbsr  L0706
         ldd   <$13,s
         bsr   L1D08
         lbra  L155B
L1D08    ldx   <$2E,y
         pshs  b,a
         beq   L1D45
L1D0F    tst   $01,x
         beq   L1D45
         tst   $08,x
         beq   L1D41
         lda   $03,x
         cmpa  ,s
         bhi   L1D41
         adda  $05,x
         deca  
         cmpa  ,s
         bcs   L1D41
         lda   $04,x
         cmpa  $01,s
         bhi   L1D41
         adda  $06,x
         deca  
         cmpa  $01,s
         bcs   L1D41
         puls  b,a
         subb  $04,x
         tst   $02,x
         beq   L1D3D
         suba  $03,x
         tfr   a,b
L1D3D    incb  
         lda   $01,x
         rts   

L1D41    leax  $0B,x
         bra   L1D0F
L1D45    puls  b,a
         clra  
         clrb  
         rts   

L1D4A    pshs  b,a
         ldd   #$0100
         pshs  b,a
         clra  
         pshs  y,x,a
         leax  ,s
         ldy   $07,s
         lbsr  DWSet
         leas  $09,s
         rts   

L1D5F    ldd   #$0320
         bra   L1D67
L1D64    ldd   #$0110
L1D67    ldu   ,s
         lbsr  L0711
         andb  ,x
         beq   L1D7F
         bsr   L1D82
         beq   L1D7F
         pshs  a
         ldu   $01,s
         ldd   <$19,s
         bsr   L1D4A
         puls  a
L1D7F    lbra  L155B
L1D82    pshs  a
         lbsr  L1ECB
         leas  <-$1A,s
         lda   [<-$10,y]
         anda  #$01
         sta   <$18,s
         ldu   <$00A5
         lda   <$66,u
         sta   <$19,s
         clr   <$66,u
         lda   #$FF
         sta   >$00BF,u
         lda   -$0E,y
         bpl   L1DF2
         ldx   <$75,u
         leax  >$02B4,x
         bsr   L1DD6
         std   <$14,s
         bsr   L1DD6
         std   <$16,s
         ldx   <$75,u
         leax  >$02F5,x
         bsr   L1DD1
         std   $08,s
         bsr   L1DD1
         std   $0A,s
         bsr   L1DD6
         std   $0C,s
         bsr   L1DD6
         std   $0E,s
         bra   L1DDB
L1DD1    ldb   ,x+
         lbra  L1019
L1DD6    ldb   ,x+
         lbra  L100F
L1DDB    clr   >$100E
         ldx   #$0001
         os9   F$Sleep
         inc   >$100E
         ldu   <$00A5
         leax  <$003C,u
         ldb   >$00BF,u
         bne   L1DF7
L1DF2    clr   <$1A,s
         bra   L1DFB
L1DF7    ldb   $08,x
         beq   L1E3B
L1DFB    lbsr  L18B5
         clr   >$00BF,u
         lda   <$19,s
         sta   <$66,u
         ldu   <$1D,s
         lbsr  L18E3
         leax  ,s
         ldd   $04,s
         subd  ,s
         std   $04,s
         ldd   $06,s
         subd  $02,s
         std   $06,s
         pshs  y,x
         leay  ,s
         bsr   L1E31
         bsr   L1E31
         inc   $02,s
         inc   $03,s
         puls  y,x
         lda   <$1A,s
         leas  <$1B,s
         rts   

L1E31    bsr   L1E33
L1E33    ldd   ,x++
         lbsr  L1021
         stb   ,y+
         rts   

L1E3B    ldd   <$18,x
         tst   <$18,s
         bne   L1E45
         lsra  
         rorb  
L1E45    std   <$10,s
         ldd   <$1A,x
         std   <$12,s
         lda   <$1A,s
         deca  
         beq   L1E6C
         ldd   $08,s
         std   ,s
         ldd   $0A,s
         std   $02,s
         ldd   <$10,s
         orb   #$07
         std   $04,s
         ldd   <$12,s
         orb   #$07
         std   $06,s
         bra   L1E94
L1E6C    ldd   <$10,s
         andb  #$F8
         std   ,s
         addd  $0C,s
         cmpd  <$1B,y
         bcs   L1E7E
         ldd   <$1B,y
L1E7E    std   $04,s
         ldd   <$12,s
         andb  #$F8
         std   $02,s
         addd  $0E,s
         cmpd  #$00BF
         bcs   L1E92
         ldd   #$00BF
L1E92    std   $06,s
L1E94    ldd   <$14,s
         addd  ,s
         cmpd  $04,s
         bls   L1EA0
         std   $04,s
L1EA0    ldd   <$16,s
         addd  $02,s
         cmpd  $06,s
         bls   L1EAC
         std   $06,s
L1EAC    bsr   L1EB3
         bsr   L1EB3
         lbra  L1DDB
L1EB3    pshs  u,y,x
         leax  $08,s
         leau  >$0147,u
         ldb   #$08
L1EBD    lda   ,x+
         sta   ,u+
         decb  
         bne   L1EBD
         ldb   #$4C
         lbsr  L0105
         puls  pc,u,y,x

L1ECB    ldu   $05,s
         lbsr  L18BE
         ldx   -$10,y
         ldd   $02,x
         std   -$0D,y
         std   <$24,y
         lda   #$FF
         sta   $06,y
         clra  
         clrb  
         sta   <$18,y
         std   <$19,y
         std   -$0B,y
         std   <$26,y
         clr   $09,y
         ldb   ,x
         rorb  
         bcs   L1EFB
         ldd   #$013F
         std   <$1B,y
         lda   #$28
         bra   L1F03
L1EFB    ldd   #$027F
         std   <$1B,y
         lda   #$50
L1F03    ldb   #$18
         std   -$09,y
         std   <$28,y
         ldd   #$00BF
         std   <$1D,y
         lda   #$03
         sta   $0A,y
         ldb   #$1E
         pshs  u,y,x
         lbsr  L0105
         puls  pc,u,y,x

L1F1D    ldu   <$00A5
         lda   >$0160,u
         ldb   #$04
         cmpa  #$FF
         lbne  L0105
         ldd   -$0B,y
         std   <$26,y
         ldd   -$09,y
         std   <$28,y
         lbsr  L20FF
         lbsr  L201D
         ldd   #$FF04
         sta   >$1160
         lbsr  L0105
         pshs  b,cc
         ldu   >$1020
         lbsr  L20C3
         puls  pc,b,cc

L1F4E    lbsr  L20DB
         lbsr  L201D
         bsr   L1F5A
         lbsr  L1FCA
         rts   

L1F5A    tst   <$7E,u
         beq   L1F65
         ldb   #$36
         pshs  u,y,x,b
         bra   L1F8A
L1F65    rts   

L1F66    ldb   <$0035,u
         tfr   b,a
         pshs  u,b,a
L1F6D    sta   ,s
         lbsr  L1AD0
         lda   -$0E,x
         bpl   L1F6D
         puls  pc,u,b,a

L1F78    ldb   #$34
         pshs  u,y,x,b
         bsr   L1F66
         lda   [<-$10,x]
         bpl   L1F85
         puls  pc,u,y,x,b

L1F85    lda   $05,s
         sta   <$7E,u
L1F8A    bsr   L1F66
         pshs  b
         sta   <$0035,u
         lbsr  L10B6
         ldu   <$00A5
         ldb   $06,s
         lda   #$F0
         std   >$0157,u
         clra  
         clrb  
         std   >$0147,u
         std   >$0149,u
         lbsr  L0F46
         ldd   <$1B,y
         addd  #$0001
         std   >$014F,u
         ldd   <$1D,y
         addd  #$0001
         std   >$0151,u
         ldb   $01,s
         lbsr  L0105
         puls  u,y,x,b,a
         sta   <$0035,u
         rts   

L1FCA    pshs  u,y,x
         clr   <$7E,u
         lbsr  L20C3
         ldb   $04,s
         ldu   <$00A5
         lda   #$F0
         std   >$0157,u
         ldb   #$2E
         lbsr  L0105
         puls  pc,u,y,x

L1FE3    bsr   L1FCA
         ldb   #$20
         pshs  u,y,x,b
         ldu   <$00A5
         leax  >$01E0,u
L1FEF    lda   ,-x
         ldb   #$40
         mul   
         ldu   <$00A5
         leay  >$0290,u
         leay  d,y
         cmpy  $03,s
         beq   L2017
         ldd   -$10,y
         cmpd  $01,s
         bne   L2017
         lda   -$0E,y
         bpl   L2017
         lbsr  L20FF
         bsr   L201D
         lbsr  L1F5A
         lbsr  L1FCA
L2017    dec   ,s
         bne   L1FEF
         puls  pc,u,y,x,b

L201D    pshs  u,y,x
         lbsr  L1F66
         ldb   #$20
         pshs  x,b
         ldu   <$00A5
         leax  >$01C0,u
         pshs  x
L202E    puls  x
         lda   ,x+
         pshs  x
         ldb   #$40
         mul   
         leax  >$0290,u
         leax  d,x
         cmpx  $03,s
         beq   L2053
         ldd   -$10,x
         bmi   L2053
         ldy   $03,s
         cmpd  -$10,y
         bne   L2053
         lda   -$0E,x
         bpl   L2053
         bsr   L205B
L2053    dec   $02,s
         bne   L202E
         leas  $05,s
         puls  pc,u,y,x

L205B    pshs  u,y,x
         lda   <$2B,x
         lbsr  L2102
         bne   L2081
         bsr   L2083
         bcc   L2081
         cmpu  >$1020
         bne   L2079
         lbsr  L2109
         pshs  u
         lbsr  L1060
         puls  u
L2079    lbsr  L1F78
         lda   #$FF
         sta   <$7F,u
L2081    puls  pc,u,y,x

L2083    lda   $09,x
         bita  #$01
         beq   L20BF
         leax  <$26,x
         leay  <$26,y
         lda   ,y
         cmpa  ,x
         bge   L209D
         adda  $02,y
         cmpa  ,x
         bgt   L20A7
         clrb  
         rts   

L209D    ldb   ,x
         addb  $02,x
         pshs  b
         cmpa  ,s+
         bge   L20BF
L20A7    lda   $01,y
         cmpa  $01,x
         bge   L20B5
         adda  $03,y
         cmpa  $01,x
         bgt   L20C1
         clrb  
         rts   

L20B5    ldb   $01,x
         addb  $03,x
         pshs  b
         cmpa  ,s+
         blt   L20C1
L20BF    clrb  
         rts   
L20C1    comb  
         rts   

L20C3    pshs  x,b,a
         lda   <$7D,u
         beq   L20D6
         clrb  
         stb   <$7D,u
         tfr   d,x
         lda   $0C,x
         anda  #$F7
         sta   $0C,x
L20D6    clr   <$7F,u
         puls  pc,x,b,a

L20DB    pshs  u,y,x,b,a
         lbsr  L1F66
         ldu   <$00A5
         leax  >$01E0,u
         ldb   #$20
         pshs  a
L20EA    decb  
         beq   L20F8
         cmpa  ,-x
         bne   L20EA
L20F1    lda   ,-x
         sta   $01,x
         decb  
         bne   L20F1
L20F8    puls  a
         sta   >$11C0
         puls  pc,u,y,x,b,a

L20FF    lda   <$2B,y
L2102    clrb  
         tfr   d,u
         ldb   <$7E,u
         rts   

L2109    pshs  u,x
         lbsr  L0711
         lda   ,x
         puls  pc,u,x

L2112    lbra  L0FF6

L2115    pshs  x
         lbsr  L0F46
         leax  <L213B,pcr
         lbsr  L102B
         lda   $06,y
         pshs  a
         lbsr  L2220
         leax  <L215F,pcr
         bsr   L2138
         lbsr  L2227
         bsr   L2138
         puls  x,a
         sta   $06,y
         rts   
L2136    bsr   L2138
L2138    lbra  L1029

* Data for top bar

L213B    fdb   $0000
         fdb   $0000
         fdb   $8000
         fdb   $0007
         fcb   $4e

* Data for left bar

L2144    fdb   $0000
         fdb   $0008
         fdb   $0006
         fdb   $fff9
         fdb   $4e00
         fdb   $00ff
         fdb   $faff
         fdb   $ffff
         fdb   $ff4e
         fdb   $fffa
         fdb   $0008
         fdb   $ffff
         fdb   $fff9
         fcb   $4e

L215F    fdb   $0000
         fdb   $0000
         fdb   $8000
         fdb   $0000
         fdb   $4a00
         fdb   $0000
         fdb   $0000
         fdb   $0000
         fdb   $074a
         fdb   $0001
         fdb   $0007
         fdb   $8000
         fdb   $0007
         fdb   $4a80
         fdb   $0000
         fdb   $0180
         fdb   $0000
         fdb   $074a

L2183    fdb   $0000
         fdb   $0008
         fdb   $8000
         fdb   $0008
         fdb   $4a00
         fdb   $0000
         fdb   $0800
         fdb   $0080
         fdb   $004a
         fdb   $0006
         fdb   $fff9
         fdb   $fff9
         fdb   $fff9
         fdb   $4aff
         fdb   $f900
         fdb   $09ff
         fdb   $f9ff
         fdb   $f94a

L21A7    fdb   $0001
         fdb   $8000
         fdb   $8000
         fdb   $8000
         fdb   $4a80
         fdb   $0000
         fdb   $0880
         fdb   $0080
         fdb   $004a
         fdb   $0006
         fdb   $0009
         fdb   $fff9
         fdb   $0009
         fdb   $4a00
         fdb   $0600
         fdb   $0900
         fdb   $06ff
         fdb   $f94a

L21CB    lbsr  L0F46
         lda   $06,y
         pshs  x,a
         leax  L2144,pcr
         lbsr  L102B
         lbsr  L1029
         bsr   L2227
         leax  L21A7,pcr
         lbsr  L2136
         bsr   L2220
         leax  L2183,pcr
         lbsr  L2136
         puls  x,a
         sta   $06,y
         rts   

L21F3    fdb   $0008
         fdb   $fffc
         fdb   $fff8
         fdb   $fffc
         fdb   $4aff
         fdb   $fc00
         fdb   $0aff
         fdb   $fcff
         fdb   $f84a
         fdb   $0008
         fdb   $fffd
         fdb   $fff8
         fdb   $fffd
         fdb   $4aff
         fdb   $f8ff
         fdb   $fcff
         fdb   $f8ff
         fdb   $fd4a
         fdb   $fffd
         fdb   $000a
         fdb   $fffd
         fdb   $fff8
         fcb   $4a

L2220    pshs  x
         leax  <L227D,pcr
         bra   L222C
L2227    pshs  x
         leax  <L2281,pcr
L222C    lbsr  L0F41
         lda   a,x
         sta   $06,y
         puls  pc,x

L2235    fdb   $0008
         fdb   $fffb
         fdb   $fff8
         fdb   $fffb
         fdb   $4a00
         fdb   $08ff
         fdb   $feff
         fdb   $f8ff
         fdb   $fe4a
         fdb   $fffb
         fdb   $000a
         fdb   $fffb
         fdb   $fff8
         fdb   $4aff
         fdb   $fe00
         fdb   $0aff
         fdb   $feff
         fdb   $f84a

L2259    lbsr  L0F46
         lda   $06,y
         pshs  x,a
         leax  <L2235,pcr
         lbsr  L2136
         lbsr  L2227
         leax  L21F3,pcr
         lbsr  L1029
         lbsr  L2220
         lbsr  L1029
         lbsr  L102B
         puls  x,a
         sta   $06,y
L227D    rts   

         fcb   $ff,$ff,$ff

L2281    fcb   $33,$00,$aa,$aa,$22

L2286    fcb   $00

L2287    fdb   $0000
         fdb   $0200
         fdb   $0700
         fdb   $054e
         fdb   $0000
         fdb   $0005
         fdb   $0007
         fdb   $0005
         fdb   $4a00
         fdb   $0700
         fdb   $0200
         fdb   $0700
         fdb   $054a
         fdb   $0000
         fdb   $0002
         fdb   $0007
         fdb   $0002
         fdb   $4a00
         fdb   $0000
         fdb   $0200
         fdb   $0000
         fdb   $054a

L22B3    fdb   $0002
         fdb   $0000
         fdb   $0005
         fdb   $0007
         fdb   $4e00
         fdb   $0300
         fdb   $0700
         fdb   $0500
         fdb   $074a
         fdb   $0005
         fdb   $0001
         fdb   $0005
         fdb   $0007
         fdb   $4a00
         fdb   $0200
         fdb   $0000
         fdb   $0200
         fdb   $074a
         fdb   $0002
         fdb   $0000
         fdb   $0005
         fdb   $0000
         fcb   $4a

L22E0    pshs  x
         leax  L2286,pcr
         bra   L22EE
L22E8    pshs  x
         leax  L22B3,pcr
L22EE    leas  -$0D,s
         pshs  a
         lda   #$08
         mul   
         std   $0C,s
         puls  b
         lda   #$08
         mul   
         std   $09,s
         clr   $06,y
         bsr   L2314
         lbsr  L2227
         bsr   L2314
         bsr   L2314
         lbsr  L2220
         bsr   L2314
         bsr   L2314
         leas  $0D,s
         puls  pc,x

L2314    ldd   ,x++
         addd  $0B,s
         std   $02,s
         ldd   ,x++
         addd  $0D,s
         std   $04,s
         ldd   ,x++
         addd  $0B,s
         std   $06,s
         ldd   ,x++
         addd  $0D,s
         std   $08,s
         lda   ,x+
         sta   $0A,s
         pshs  x
         leax  $04,s
         lbsr  L102B
         puls  pc,x

         emod  
eom      equ   *
         end

