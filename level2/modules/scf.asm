********************************************************************
* SCF - Sequential Character file manager
*
* $Id$
*
* This contains an added SetStat call to allow placing prearranged
* data into the keyboard buffer of ANY SCF related device.
*
* This also includes Kevin Darlings SCF Editor patches.
* This means windows, VDG screens, terminals, etc.
*
* Remember to have a Carriage Return ($0D) at the end of the buffer
* to terminate it without having trailing garbage (this will be fixed
* to be automatic in a future version).
*
* ENTRY PARAMETERS:
*   x = Address of string to place in buffer
*   y = Length of the string to place in buffer
*   a = Path number (usually 0)
*   b = $A0 (syscall SETSTAT function call number)
*
* Ed.    Comments                                       Who YY/MM/DD
* ------------------------------------------------------------------
* 13     Obtained from L2 Upgrade archive
* 16     Updated to Curtis Boyle's version, contains    BGP 98/10/20
*        several optimizations and new SetStat to
*        stuff any string in the input buffer.

         nam   SCF
         ttl   Sequential Character file manager     

* Disassembled 98/08/24 22:11:42 by Disasm v1.6 (C) 1988 by RML

         ifp1  
         use   defsfile
         endc  

tylg     set   FlMgr+Objct
atrv     set   ReEnt+rev
rev      set   $00
edition  set   16

         mod   eom,name,tylg,atrv,start,size

u0000    rmb   0
size     equ   .

name     fcs   /SCF/
         fcb   edition

start    lbra  Create
         lbra  Open
         lbra  MakDir
         lbra  ChgDir
         lbra  Delete
         lbra  Seek
         lbra  Read
         lbra  Write
         lbra  ReadLn
         lbra  WriteLn
         lbra  GetStat
         lbra  SetStat
         lbra  Term

L0038    puls  y

* ChgDir/Makdir entry
ChgDir         
MakDir   comb  
         ldb   #E$BPNam
L003D    rts   


******************************
*
* Create or open a path to device
*
* Entry: Y = Path descriptor pointer
*        U = Callers register stack pointer

* Check for pathname legality
Open           
Create   ldx   PD.DEV,y   get device table entry pointer
         stx   <PD.TBL,y  save copy of pointer in path desc
         ldu   PD.RGS,y   get caller's regs
         pshs  y          save pointer to path desc
         ldx   R$X,u      get caller's X (device name)
         os9   F$PrsNam   parse name
         bcs   L0038      branch if error
         tsta             end of pathname?
         bmi   L0058      yes, go on

* We're not at the end of the pathname parse it again

         leax  ,y         point to actual device name
         os9   F$PrsNam   get next pathlist element
         bcc   L0038      if valid, branch to error

* Legal pathname detected let's keep going

L0058    sty   R$X,u      save updated pathlist pointer
         puls  y          retrieve path desc pointer

* Allocate input buffer

         ldd   #256       get size of input buffer in bytes
         os9   F$SRqMem   allocate path desc buffer
         bcs   L003D      can't allocate it, return with error
         stu   PD.BUF,y   save off in path desc

* Preload buffer with string & CR's

         clrb  
         bsr   FillBuf

* cute message
         fcc   /by K.Kaplan, L.Crane, R.Doggett/
         fcb   C$CR

* put cute message into our newly allocated PD buffer
FillBuf  puls  x          get PC into X (points to cute message)
L008D    lda   ,x+        get byte of string, XOR it
         sta   ,u+        store it in buffer
         decb             dec count
         cmpa  #C$CR      carriage return?
         bne   L008D      nope, continue
putcr    sta   ,u+        continue putting C$CRs...
         decb             in buffer
         bne   putcr      until we've reached end

* Set up lines per page

         ldu   PD.DEV,y   get device table entry ptr
         beq   MakDir     if none, branch to error
         ldx   V$STAT,u   X = static storage ptr
         lda   <PD.PAG,y  get page len from dev desc
         sta   V.LINE,x   store in static

* Attach to device by name

         ldx   V$DESC,u   get pointer to dev desc
         ldd   <PD.D2P,y  get pointer to dev2 name
         beq   L00CF      branch if none
         leax  d,x        else X = addr of name
         lda   PD.MOD,y   get dev mode
         lsra  
         rorb  
         lsra  
         rolb  
         rola  
         rorb  
         rola  
         pshs  y          save path desc
         ldy   <D.Proc    get current proc desc
         ldu   <D.SysPrc  get system proc desc
         stu   <D.Proc    make system current process
         os9   I$Attach   attach to dev2 on behalf of system
         sty   <D.Proc    restore old current proc desc
         puls  y          restore path desc ptr
         bcs   L0111      branch if error

* Device attached update pointers

         stu   PD.DV2,y   else save dev tbl ptr to dev2 in path desc
         ldu   PD.DEV,y   get our dev's dev table addr
L00CF    ldu   V$STAT,u   get static storage pointer
         clra  
         clrb  
         std   <PD.PLP,y  clear path desc list ptr
         sta   <PD.PST,y  and path status
         pshs  b,a
         ldx   <V.PDLHd,u get pointer to path desc head ptr
         bne   L00E8      branch if not zero
         sty   <V.PDLHd,u else save our path desc ptr
         bra   L00F8      and branch

L00E6    tfr   d,x
L00E8    ldb   <PD.PST,x  get path status
         bne   L00EF      branch if not zero
         inc   1,s        else inc b on stack
L00EF    ldd   <PD.PLP,x  get path desc list ptr
         bne   L00E6      branch if not zero
         sty   <PD.PLP,x
L00F8    lda   #$29
         pshs  a
         inc   $02,s      inc B on stack
         lbsr  L025B
         lda   $02,s
         leas  $03,s      clean up stack
         deca  
         bcs   L010F
         bne   L010D
         lbra  L0250

L010D    clrb  
         rts   

L010F    bsr   L0149
L0111    pshs  b,cc
         bsr   L0136
         puls  pc,b,cc

Term     pshs  cc
         orcc  #IntMasks
         ldx   PD.DEV,y   get dev table entry addr
         bsr   L0182
         ldx   $0A,y
         bsr   L0182
         puls  cc
         tst   $02,y
         beq   L012B

Delete         
Seek     clra  
         rts   

L012B    bsr   L0149
         lda   #$2A
         pshs  x,a
         lbsr  L025B
         leas  $03,s
L0136    ldu   $0A,y
         beq   L013D
         os9   I$Detach
L013D    ldu   $08,y
         beq   L0147
         ldd   #$0100
         os9   F$SRtMem
L0147    clra  
         rts   

L0149    ldx   #$0001
         pshs  u,y,x,b,a,cc
         ldu   $03,y
         beq   L017B
         ldu   $02,u
         beq   L017B
         ldx   <$16,u
         beq   L017B
         ldd   <$3D,y
         cmpy  <$16,u
         bne   L0172
         std   <$16,u
         bne   L017B
         clr   $04,s
         bra   L017B
L016D    ldx   <$3D,x
         beq   L0180
L0172    cmpy  <$3D,x
         bne   L016D
         std   <$3D,x
L017B    clra  
         clrb  
         std   <$3D,y
L0180    puls  pc,u,y,x,b,a,cc

L0182    leax  V$DRIV,x
         beq   Delete
         ldx   $02,x
         ldb   PD.PD,y
         lda   PD.CPR,y
         pshs  y,x,b,a
         cmpa  $03,x
         bne   L01CA
         ldx   <D.Proc
         leax  <P$Path,x
         clra  
L0198    cmpb  a,x
         beq   L01CA
         inca  
         cmpa  #$10
         bcs   L0198
         pshs  y
         ldd   #$1B0C
         bsr   L01FA
         puls  y
         ldx   <D.Proc
         lda   P$PID,x
         sta   ,s
         os9   F$GProcP
         leax  <$30,y
         ldb   $01,s
         clra  
L01B9    cmpb  a,x
         beq   L01C4
         inca  
         cmpa  #$10
         bcs   L01B9
         clr   ,s
L01C4    lda   ,s
         ldx   $02,s
         sta   $03,x
L01CA    puls  pc,y,x,b,a

GetStat  lda   <$3F,y
         lbne  L04C6
         ldx   PD.RGS,y
         lda   R$B,x
         bne   L01F8
         pshs  y,x,a
         lda   #$28
         sta   R$B,x
         ldu   R$Y,x
         pshs  u
         bsr   L01F8
         puls  u
         puls  y,x,a
         sta   R$B,x
         ldd   R$Y,x
         stu   R$Y,x
         bcs   L01F6
         std   <$34,y
L01F6    clrb  
L01F7    rts   

L01F8    ldb   #$09
L01FA    pshs  a
         clra  
         ldx   PD.DEV,y
         ldu   V$STAT,x
         ldx   V$DRIV,x
         addd  $09,x
         leax  d,x
         puls  a
         pshs  u,y,x
         jsr   ,x
         puls  pc,u,y,x

SetStat  lbsr  L04A2
L0212    bsr   L021B
         pshs  b,cc
         lbsr  L0453
         puls  pc,b,cc

* Place data in keyboard buffer

putkey   cmpa  #$A0
         bne   L01FA
         pshs  x,y,u
         ldx   <D.Proc
         lda   P$Task,x
         ldb   <D.SysTsk
         ldx   R$X,u
         pshs  x
         ldx   R$Y,u
         ldu   PD.BUF,y
         tfr   x,y
         puls  x
         os9   F$Move
         tfr   y,d
         leau  d,u
         lda   #C$CR
         sta   ,u
         puls  x,y,u
         bcs   L01F7
         rts   

L021B    ldb   #$0C
         lda   $02,u
         bne   putkey
         ldx   <$27,y
         pshs  y,x
         ldx   <D.Proc
         lda   P$Task,x
         ldb   <D.SysTsk
         ldx   $04,u
         leau  <$20,y
         ldy   #$001A
         os9   F$Move
         puls  y,x
         bcs   L01F7
         pshs  x
         ldd   <$27,y
         cmpd  ,s++
         beq   L0250
         ldu   $03,y
         ldu   $02,u
         beq   L0250
         stb   $07,u
L0250    ldx   <$34,y
         lda   #$28
         pshs  x,a
         bsr   L025B
         puls  pc,x,a

L025B    pshs  u,y,x
         ldx   PD.RGS,y
         ldu   R$Y,x
         lda   R$B,x
         pshs  u,y,x,a
         ldd   <$10,s
         std   R$Y,x
         lda   $0F,s
         sta   R$B,x
         ldb   #$0C
         lbsr  L04A7
         lbsr  L0212
         puls  u,y,x,a
         stu   $06,x
         sta   $02,x
         bcc   L0282
         cmpb  #$D0
         beq   L0282
         coma  
L0282    puls  pc,u,y,x

* Device Read routine

Read     lbsr  L04A2
         bcc   L028A
L0289    rts   

L028A    inc   PD.RAW,y
         ldx   R$Y,u      get character count from callers Y register
         beq   L02DC
         pshs  x
         lbsr  L03B5      get buffer address
         lbsr  L03E2
         bcs   L02A4
         tsta  
         beq   L02C4
         cmpa  <PD.EOF,y  end of file character?
         bne   L02BC
L02A2    ldb   #E$EOF
L02A4    leas  2,s
         pshs  b
         bsr   L02D5
         comb  
         puls  pc,b

L02AD    tfr   x,d
         tstb  
         bne   L02B7
         lbsr  L042B
         ldu   $08,y
L02B7    lbsr  L03E2
         bcs   L02A4
L02BC    tst   <PD.EKO,y  echo turned on?
         beq   L02C4
         lbsr  L0565
L02C4    leax  $01,x
         sta   ,u+
         beq   L02CF
         cmpa  <PD.EOR,y  end of record character?
         beq   L02D3
L02CF    cmpx  ,s
         bcs   L02AD
L02D3    leas  $02,s
L02D5    lbsr  L042B
         ldu   $06,y
         stx   $06,u
L02DC    lbra  L0453

ReadLn   lbsr  L04A2
         bcs   L0289
         ldx   $06,u
         beq   L02D5
         tst   $06,u
         beq   L02EF
         ldx   #$0100
L02EF    pshs  x
         ldd   #$FFFF
         std   $0D,y
         lbsr  L03B5
L02F9    lbra  L05F8
         bcs   L0370
L02FE    tsta  
         beq   L030C
         ldb   #$29
L0303    cmpa  b,y
         beq   L032C
         incb  
         cmpb  #$31
         bls   L0303
L030C    cmpx  $0D,y
         bls   L0312
         stx   $0D,y
L0312    leax  $01,x
         cmpx  ,s
         bcs   L0322
         lda   <$33,y
         lbsr  L0565
         leax  -$01,x
         bra   L02F9
L0322    lbsr  L0403
         sta   ,u+
         lbsr  L0413
         bra   L02F9
L032C    pshs  pc,x
         leax  >L033F,pcr
         subb  #$29
         lslb  
         leax  b,x
         stx   $02,s
         puls  x
         jsr   [,s++]
         bra   L02F9
L033F    bra   L03BB
         bra   L03A5
         bra   L0351
         bra   L0366
         bra   L0381
         bra   L038B
         puls  pc
         bra   L03A5
         bra   L03A5
L0351    leas  $02,s
         sta   ,u
         lbsr  L0413
         ldu   $06,y
         leax  $01,x
         stx   $06,u
         lbsr  L042B
         leas  $02,s
         lbra  L0453
L0366    leas  $02,s
         leax  ,x
         lbeq  L02A2
         bra   L030C
L0370    pshs  b
         lda   #$0D
         sta   ,u
         bsr   L037D
         puls  b
         lbra  L02A4
L037D    lda   #$0D
         bra   L03D7
L0381    lda   <$2B,y
         sta   ,u
         bsr   L03B5
L0388    lbsr  L0418
L038B    cmpx  $0D,y
         beq   L03A2
         leax  $01,x
         cmpx  $02,s
         bcc   L03A0
         lda   ,u+
         beq   L0388
         cmpa  <$2B,y
         bne   L0388
         leau  -$01,u
L03A0    leax  -$01,x
L03A2    rts   

L03A3    bsr   L03BF
L03A5    leax  ,x
         beq   L03B5
         tst   <$23,y
         beq   L03A3
         tst   <$24,y
         beq   L03B5
         bsr   L037D
L03B5    ldx   #$0000
         ldu   $08,y
L03BA    rts   
L03BB    leax  ,x
         beq   L03A2
L03BF    leau  -$01,u
         leax  -$01,x
         tst   <$24,y
         beq   L03BA
         tst   <$22,y
         beq   L03D4
         bsr   L03D4
         lda   #$20
         lbsr  L0565
L03D4    lda   <$32,y
L03D7    lbra  L0565
L03DA    pshs  u,y,x
         ldx   $0A,y
         ldu   $03,y
         bra   L03EA

L03E2    pshs  u,y,x
         ldx   PD.DEV,y
         ldu   PD.DV2,y
         beq   L03F1
L03EA    ldu   V$STAT,u
         ldb   <PD.PAG,y
         stb   V.LINE,u
L03F1    leax  ,x
         beq   L0401
         tfr   u,d
         ldu   V$STAT,x
         std   V.DEV2,u
         ldu   #$0003
         lbsr  L05CC
L0401    puls  pc,u,y,x

L0403    tst   <$21,y
         beq   L0412
         cmpa  #$61
         bcs   L0412
         cmpa  #$7A
         bhi   L0412
         suba  #$20
L0412    rts   

L0413    tst   <$24,y
         beq   L0412
L0418    cmpa  #$20
         bcc   L0420
         cmpa  #$0D
         bne   L0423
L0420    lbra  L0565
L0423    pshs  a
         lda   #$2E
         bsr   L0420
         puls  pc,a

L042B    pshs  y,x
         ldd   ,s
         beq   L0451
         tstb  
         bne   L0435
         deca  
L0435    clrb  
         ldu   $06,y
         ldu   $04,u
         leau  d,u
         clra  
         ldb   $01,s
         bne   L0442
         inca  
L0442    pshs  b,a
         lda   <D.SysTsk
         ldx   <D.Proc
         ldb   P$Task,x
         ldx   P$User,y
         puls  y
         os9   F$Move
L0451    puls  pc,y,x

L0453    ldx   <D.Proc
         lda   P$ID,x
         ldx   PD.DEV,y
         bsr   L045D
         ldx   PD.FST,y
L045D    beq   L0467
         ldx   V$STAT,x
         cmpa  V.BUSY,x
         bne   L0467
         clr   V.BUSY,x
L0467    rts   

L0468    pshs  x,a
         ldx   V$STAT,x   get dev static storage addr
         lda   V.BUSY,x   get active proc ID
         beq   L048A      it's not busy, go on
         cmpa  ,s         same process?
         beq   L049F      yes...
         pshs  a
         bsr   L0453
         puls  a
         os9   F$IOQu
         inc   PD.MIN,y
         ldx   <D.Proc
         ldb   <P$Signal,x
         puls  x,a
         beq   L0468
         coma  
         rts   

L048A    lda   ,s
         sta   V.BUSY,x
         sta   V.LPRC,x
         lda   <PD.PSC,y
         sta   V.PCHR,x
         ldd   <PD.INT,y
         std   V.INTR,x
         ldd   <PD.XON,y
         std   V.XON,x
L049F    clra  
         puls  pc,x,a

L04A2    lda   <PD.PST,y  get path status
         bne   L04C4      exit if anything there
L04A7    ldx   <D.Proc    get process ID
         lda   P$ID,x
         clr   PD.MIN,y
         ldx   PD.DEV,y
         bsr   L0468
         bcs   L04C1
         ldx   PD.DV2,y
         beq   L04BB
         bsr   L0468
         bcs   L04C1
L04BB    tst   PD.MIN,y
         bne   L04A2
         clr   PD.RAW,y
L04C1    ldu   PD.RGS,y
         rts   

L04C4    leas  $02,s      purge return address
L04C6    ldb   #E$HangUp
         cmpa  #S$Abort
         bcs   L04D3
         lda   PD.CPR,y
         ldb   #S$Kill
         os9   F$Send
L04D3    inc   <PD.PST,y
         orcc  #Carry
         rts   

WriteLn  bsr   L04A2
         bra   L04E1
Write    bsr   L04A2
         inc   $0C,y
L04E1    ldx   $06,u
         beq   L055A
         pshs  x
         ldx   #$0000
         bra   L04F1
L04EC    tfr   u,d
         tstb  
         bne   L0523
L04F1    pshs  y,x
         ldd   ,s
         ldu   $06,y
         ldx   $04,u
         leax  d,x
         ldd   $06,u
         subd  ,s
         cmpd  #$0020
         bls   L0508
         ldd   #$0020
L0508    pshs  b,a
         ldd   $08,y
         inca  
         subd  ,s
         tfr   d,u
         lda   #$0D
         sta   -$01,u
         ldy   <D.Proc
         lda   P$Task,y
         ldb   <D.SysTsk
         puls  y
         os9   F$Move
         puls  y,x
L0523    lda   ,u+
         tst   $0C,y
         bne   L053D
         lbsr  L0403
         cmpa  #$0A
         bne   L053D
         lda   #$0D
         tst   <$25,y
         bne   L053D
         bsr   L0573
         bcs   L055D
         lda   #$0A
L053D    bsr   L0573
         bcs   L055D
         leax  $01,x
         cmpx  ,s
         bcc   L0554
         lda   -$01,u
         beq   L04EC
         cmpa  <$2B,y
         bne   L04EC
         tst   $0C,y
         bne   L04EC
L0554    leas  $02,s
L0556    ldu   $06,y
         stx   $06,u
L055A    lbra  L0453
L055D    leas  $02,s
         pshs  b,cc
         bsr   L0556
         puls  pc,b,cc

L0565    pshs  u,x,a
         ldx   $0A,y
         beq   L0571
         cmpa  #$0D
         beq   L05A2
L056F    bsr   L05C9
L0571    puls  pc,u,x,a

L0573    pshs  u,x,a
         ldx   $03,y
         cmpa  #$0D
         bne   L056F
         ldu   $02,x
         tst   $08,u
         bne   L0590
         tst   $0C,y
         bne   L05A2
         tst   <$27,y
         beq   L05A2
         dec   $07,u
         bne   L05A2
         bra   L059A
L0590    lbsr  L03DA
         bcs   L059A
         cmpa  <$2F,y
         bne   L0590
L059A    lbsr  L03DA
         cmpa  <$2F,y
         beq   L059A
L05A2    ldu   $02,x
         clr   $08,u
         lda   #$0D
         bsr   L05C9
         tst   $0C,y
         bne   L05C7
         ldb   <$26,y
         pshs  b
         tst   <$25,y
         beq   L05BE
         lda   #$0A
L05BA    bsr   L05C9
         bcs   L05C5
L05BE    lda   #$00
         dec   ,s
         bpl   L05BA
         clra  
L05C5    leas  $01,s
L05C7    puls  pc,u,x,a

L05C9    ldu   #$0006
L05CC    pshs  u,y,x,a
         ldu   $02,x
         clr   $05,u
         ldx   ,x
         ldd   $09,x
         addd  $05,s
         leax  d,x
         lda   ,s+
         jsr   ,x
         puls  pc,u,y,x
         nop   
         nop   
         nop   

L05E3    lbra  L02FE
L05E6    lbra  L03E2
L05E9    lbra  L0370
L05EC    lbra  L038B
L05EF    lbra  L0565
L05F2    lbra  L0418
         lbra  L030C

L05F8    bsr   L05E6
         bcs   L05E9
         tsta  
         beq   L05E3
         ldb   <$2D,y
         cmpb  #$04
         beq   L05E3
         cmpa  <$2D,y
         bne   L0629
         cmpx  $0D,y
         beq   L0622
         leax  $01,x
         cmpx  ,s
         bcc   L0620
         lda   ,u+
         beq   L0624
         cmpa  <$2B,y
         bne   L0624
         leau  -$01,u
L0620    leax  -$01,x
L0622    bra   L05F8
L0624    lbsr  L05F2
         bra   L05F8

* Line editor functions

L0629    cmpa  #$13       cntrl-up arrow? (print rest of line)
         bne   L0647
L062D    pshs  u
         bsr   L05EC
         lda   <$32,y
L0634    cmpu  ,s
         beq   L0642
         leau  -$01,u
         leax  -$01,x
         lbsr  L05EF
         bra   L0634
L0642    leas  $02,s
         lbra  L05F8

L0647    cmpa  #$11       cntrl-right arrow? (insert character)
         bne   L0664
         pshs  u
         tfr   u,d
         ldb   #$FF
         tfr   d,u
L0653    lda   ,-u
         sta   $01,u
         cmpu  ,s
         bne   L0653
         lda   #$20
         sta   ,u
         leas  $02,s
         bra   L062D

L0664    cmpa  #$10       cntrl-left arrow? (Delete character)
         bne   L068B
         pshs  u
         lda   ,u
         cmpa  <$2B,y
         beq   L0687
L0671    lda   $01,u
         cmpa  <$2B,y
         beq   L067C
         sta   ,u+
         bra   L0671
L067C    lda   #$20
         cmpa  ,u
         bne   L0685
         lda   <$2B,y
L0685    sta   ,u
L0687    puls  u
         bra   L062D
L068B    cmpa  <$2B,y
         lbne  L05E3
         pshs  u
         bra   L069F
L0696    pshs  a
         lda   #$20
         lbsr  L05EF
         puls  a
L069F    cmpa  ,u+
         bne   L0696
         puls  u
         lbra  L05E3

         emod  
eom      equ   *
         end   
