********************************************************************
* Kernel - NitrOS-9 Level 1 Kernel
*
* $Id$
*
* This is how the memory map looks after the kernel has initialized:
*
*     $0000----> ================================== 
*               |                                  |
*               |                                  |
*  $0020-$0111  |  System Globals (D.FMBM-D.XNMI)  |
*               |                                  |
*               |                                  |
*     $0200---->|==================================|
*               |        Free Memory Bitmap        |
*  $0200-$021F  |     (1 bit = 256 byte page)      |
*               |----------------------------------|
*               |      System Dispatch Table       |
*  $0222-$0291  |     (Room for 56 addresses)      |
*               |----------------------------------|
*  $0292-$02FF  |       User Dispatch Table        |
*               |     (Room for 56 addresses)      |
*     $0300---->|==================================|
*               |                                  |
*               |                                  |
*  $0300-$03FF  |     Module Directory Entries     |
*               |      (Room for 64 entries)       |
*               |                                  |
*     $0400---->|==================================|
*               |                                  |
*  $0400-$04FF  |           System Stack           |
*               |                                  |
*     $0500---->|==================================|
*
* Edt/Rev  YYYY/MM/DD  Modified by
* Comment
* ------------------------------------------------------------------
*  14      1985/??/??
* From Tandy OS-9 Level One VR 02.00.00
*
*  15      2002/07/21  Boisy G. Pitre
* Module validation consists only of module header parity check.
* CRC check is not done unless D.CRC is set to 1, which is NOT the
* default case.  By default, D.CRC is set to 0, thus there is no
* CRC checking.  Speeds up module loads quite a bit. The Init module
* has a bit in a compatibility byte that can turn on/off CRC checking
*
*  15r1    2003/12/09  Boisy G. Pitre
* Kernel no longer scans for modules in I/O space.  Also, F$PrsNam now
* allows _ and 0-9 as first chars of a filename.

         nam   Kernel
         ttl   NitrOS-9 Level 1 Kernel

         ifp1
         use   defsfile
         use   scfdefs
         endc

tylg     set   Systm+Objct
atrv     set   ReEnt+rev
rev      set   $01
edition  set   15

L0000    mod   eom,name,tylg,atrv,OS9Cold,size

size     equ   .

name     fcs   /Kernel/
         fcb   edition

InitNam  fcs   /Init/

P2Nam    fcs   /KernelP2/

VectCode bra   SWI3Jmp		$0100
         nop
         bra   SWI2Jmp		$0103
         nop
         bra   SWIJmp		$0106
         nop
         bra   NMIJmp		$0109
         nop
         bra   IRQJmp		$010C
         nop
         bra   FIRQJmp		$010F

SWI3Jmp  jmp   [>D.SWI3]
SWI2Jmp  jmp   [>D.SWI2]
SWIJmp   jmp   [>D.SWI]
NMIJmp   jmp   [>D.NMI]
IRQJmp   jmp   [>D.IRQ]
FIRQJmp  jmp   [>D.FIRQ]
VectCSz  equ   *-VectCode


SysTbl   fcb   F$Link
         fdb   FLink-*-2

         fcb   F$Fork
         fdb   FFork-*-2

         fcb   F$Chain
         fdb   FChain-*-2

         fcb   F$Chain+$80
         fdb   SFChain-*-2

         fcb   F$PrsNam
         fdb   FPrsNam-*-2

         fcb   F$CmpNam
         fdb   FCmpNam-*-2

         fcb   F$SchBit
         fdb   FSchBit-*-2

         fcb   F$AllBit
         fdb   FAllBit-*-2

         fcb   F$DelBit
         fdb   FDelBit-*-2

         fcb   F$CRC
         fdb   FCRC-*-2

         fcb   F$SRqMem+$80
         fdb   FSRqMem-*-2

         fcb   F$SRtMem+$80
         fdb   FSRtMem-*-2

         fcb   F$AProc+$80
         fdb   FAProc-*-2

         fcb   F$NProc+$80
         fdb   FNProc-*-2

         fcb   F$VModul+$80
         fdb   FVModul-*-2

         fcb   F$SSvc
         fdb   FSSvc-*-2

         fcb   $80

         IFNE  H6309
Zoro     fcb   $00
         ENDC

*
* OS-9 Genesis!

OS9Cold  equ   *
* clear out system globals from $0020-$0400
         ldx   #D.FMBM
         IFNE  H6309
         ldw   #$400-D.FMBM
         leay  Zoro,pc
         tfm   y,x+
         ELSE
         ldy   #$400-D.FMBM
         clra
         clrb
L007F    std   ,x++
         leay  -2,y
         bne   L007F
         ENDC

* set up system globals
         IFNE  H6309
         ldd   #$200
         ELSE
         inca
         inca                          D = $200
         ENDC
         std   <D.FMBM                 $200 = start of free memory bitmap
         addb  #$20
         std   <D.FMBM+2               $220 = end of free memory bitmap
         addb  #$02
         std   <D.SysDis               $222 = addr of sys dispatch tbl
         addb  #$70
         std   <D.UsrDis               $292 = addr of usr dispatch tbl
         clrb
         inca                          D = $300
         std   <D.ModDir               $300 = mod dir start
         stx   <D.ModDir+2             X = $400 = mod dir end
         leas  >$0100,x                S = $500 (system stack?)

* Check for valid RAM starting at $400
ChkRAM   leay  ,x
         ldd   ,y                      store org contents in D
         ldx   #$00FF
         stx   ,y                      write pattern to ,Y
         cmpx  ,y                      same as what we wrote?
         bne   L00C2                   nope, not RAM here!
         ldx   #$FF00                  try different pattern
         stx   ,y                      write it to ,Y
         cmpx  ,y                      same as what we wrote?
         bne   L00C2                   nope, not RAM here!
         std   ,y                      else restore org contents
         leax  >$0100,y                check top of next 256 block
         cmpx  #Bt.Start               stop short of boot track mem
         bcs   ChkRAM
         leay  ,x
* Here, Y = end of RAM
L00C2    leax  ,y                      X = end of RAM
         stx   <D.MLIM                 save off memory limit

* Copy vector code over to address $100
         pshs  y,x
         IFNE  H6309
         leax  >VectCode,pcr
         ldy   #D.XSWI3
         ldw   #VectCSz
         tfm   x+,y+
         ELSE
         leax  >VectCode,pcr
         ldy   #D.XSWI3
         ldb   #VectCSz
L00D2    lda   ,x+
         sta   ,y+
         decb
         bne   L00D2
         ENDC
         puls  y,x

* Validate modules at top of RAM (kernel, etc.)
L00DB    lbsr  ValMod
         bcs   L00E6
         ldd   M$Size,x
         leax  d,x                     go past module
         bra   L00EC
L00E6    cmpb  #E$KwnMod
         beq   L00EE
         leax  1,x
* Modification to stop scan into I/O space -- Added by BGP
L00EC    cmpx  #Bt.Start+Bt.Size
         bcs   L00DB
* Copy vectors to system globals
L00EE    leay  >Vectors,pcr
         leax  >L0000,pcr
         pshs  x
         ldx   #D.SWI3
L00FB    ldd   ,y++
         addd  ,s
         std   ,x++
         cmpx  #$0036
         bls   L00FB
         leas  2,s                     restore stack

* fill in more system globals
         leax  >URtoSs,pcr
         stx   <D.URtoSs
         leax  >UsrIRQ,pcr
         stx   <D.UsrIRQ
         leax  >UsrSvc,pcr
         stx   <D.UsrSvc
         leax  >SysIRQ,pcr
         stx   <D.SysIRQ
         stx   <D.SvcIRQ
         leax  >SysSvc,pcr
         stx   <D.SysSvc
         stx   <D.SWI2
         leax  >Poll,pcr
         stx   <D.Poll
         leax  >Clock,pcr
         stx   <D.Clock
         stx   <D.AltIRQ

* install system calls
         leay  >SysTbl,pcr
         lbsr  InstSSvc

* link to init module
         lda   #Systm+0
         leax  >InitNam,pcr
         os9   F$Link
         lbcs  OS9Cold
         stu   <D.Init
         lda   Feature1,u		get feature byte 1
         bita  #CRCOn			CRC on?
         beq   GetMem			branch if not (already cleared earlier)
         inc   <D.CRC			else turn on CRC checking
GetMem   ldd   MaxMem+1,u
         clrb
         cmpd  <D.MLIM
         bcc   L0158
         std   <D.MLIM
L0158    ldx   <D.FMBM
         ldb   #$F8
         stb   ,x
         clra
         ldb   <D.MLIM
         negb
         tfr   d,y
         negb
         lbsr  L065A

* jump into OS9p2 here
         leax  >P2Nam,pcr
         lda   #Systm+Objct
         os9   F$Link
         lbcs  OS9Cold
         jmp   ,y
SWI3     pshs  pc,x,b
         ldb   #P$SWI3
         bra   L018C
SWI2     pshs  pc,x,b
         ldb   #P$SWI2
         bra   L018C
DUMMY    rti
SVCIRQ   jmp   [>D.SvcIRQ]
SWI      pshs  pc,x,b
         ldb   #P$SWI
L018C    ldx   >D.Proc
         ldx   b,x                     get SWI entry
         stx   3,s                     put in PC on stack
         puls  pc,x,b

UsrIRQ   leay  <L01B1,pcr
* transition from user to system state
URtoSs   clra
         tfr   a,dp                    clear direct page
         ldx   <D.Proc
         ldd   <D.SysSvc
         std   <D.SWI2
         ldd   <D.SysIRQ
         std   <D.SvcIRQ
         leau  ,s
         stu   P$SP,x
         lda   P$State,x
         ora   #SysState
         sta   P$State,x
         jmp   ,y

L01B1    jsr   [>D.Poll]
         bcc   L01BD
         ldb   ,s
         orb   #$10
         stb   ,s
L01BD    lbra  L0255

SysIRQ   clra
         tfr   a,dp
         jsr   [>D.Poll]
         bcc   L01CF
         ldb   ,s
         orb   #$10
         stb   ,s
L01CF    rti
Poll     comb
         rts

Clock    ldx   <D.SProcQ
         beq   L01FD
         lda   P$State,x
         bita  #TimSleep
         beq   L01FD
         ldu   P$SP,x
         ldd   P$SP,u
         subd  #$0001
         std   P$SP,u
         bne   L01FD
L01E7    ldu   P$Queue,x
         bsr   L021A
         leax  ,u
         beq   L01FB
         lda   P$State,x
         bita  #TimSleep
         beq   L01FB
         ldu   P$SP,x
         ldd   P$SP,u
         beq   L01E7
L01FB    stx   <D.SProcQ
L01FD    dec   <D.Slice
         bne   ClockRTI
         lda   <D.TSlice
         sta   <D.Slice
         ldx   <D.Proc
         beq   ClockRTI
         lda   P$State,x
         ora   #TimOut
         sta   P$State,x
         bpl   L0212                   branch if not system state
ClockRTI rti

L0212    leay  >L0255,pcr
         bra   URtoSs

* X = proc desc
FAProc   ldx   R$X,u
L021A    pshs  u,y
         ldu   #$003F
         bra   L0228
L0221    ldb   P$Age,u
         incb
         beq   L0228
         stb   P$Age,u
L0228    ldu   P$Queue,u               U = proc desc
         bne   L0221
         ldu   #$003F
         lda   P$Prior,x
         sta   P$Age,x
         orcc  #IntMasks
L0235    leay  ,u
         ldu   P$Queue,u
         beq   L023F
         cmpa  P$Age,u
         bls   L0235
L023F    stu   P$Queue,x
         stx   P$Queue,y
         clrb
         puls  pc,u,y

UsrSvc   leay  <L024E,pcr
         orcc  #IntMasks
         lbra  URtoSs

L024E    andcc #^IntMasks
         ldy   <D.UsrDis
         bsr   L0278
L0255    ldx   <D.Proc                 get current proc desc
         beq   FNProc                  branch to FNProc if none
         orcc  #IntMasks
         ldb   P$State,x
         andb  #^SysState
         stb   P$State,x
         bitb  #TimOut
         beq   L02D1
         andb  #^TimOut
         stb   P$State,x
         bsr   L021A
         bra   FNProc

* system call entry
SysSvc   clra
         tfr   a,dp                    set direct page to 0
         leau  ,s
         ldy   <D.SysDis
         bsr   L0278
         rti

L0278    pshs  u
         ldx   R$PC,u                  point X to PC
         ldb   ,x+                     get func code at X
         stx   R$PC,u                  restore updated PC
         lslb                          multiply by 2
         bcc   L0288                   branch if user call
         rorb
         ldx   -2,y
         bra   L0290
L0288    cmpb  #$6E
         bcc   L02A7
         ldx   b,y                     X = addr of system call
         beq   L02A7
L0290    jsr   ,x                      jsr into system call
L0292    puls  u
         tfr   cc,a
         bcc   FixCC                   branch if no error
         stb   R$B,u                   store error code
FixCC    ldb   R$CC,u                  get caller's CC
         andb  #^(Negative+Zero+TwosOvfl+Carry)
         stb   R$CC,u
         anda  #Negative+Zero+TwosOvfl+Carry
         ora   R$CC,u
         sta   R$CC,u
         rts
L02A7    comb
         ldb   #E$UnkSvc
         bra   L0292

* no signal handler, exit with signal value as exit code
L02AC    ldb   P$State,x
         orb   #SysState
         stb   P$State,x
         ldb   <P$Signal,x
         andcc #^(IntMasks)
         os9   F$Exit

FNProc   clra
         clrb
         std   <D.Proc
         bra   L02C2
* execution goes here when there are no active processes
L02C0    cwai  #^(IntMasks)
L02C2    orcc  #IntMasks
         ldx   <D.AProcQ               get next active process
         beq   L02C0                   CWAI if none
         ldd   P$Queue,x               get queue ptr
         std   <D.AProcQ               store in Active Q
         stx   <D.Proc                 store in current process
         lds   P$SP,x                  get process' stack ptr
L02D1    ldb   P$State,x               get state
         bmi   L0308                   branch if system state
         bitb  #Condem                 process condemned?
         bne   L02AC                   branch if so...
         ldb   <P$Signal,x             get signal no
         beq   L02FF                   branch if none
         decb                          decrement
         beq   L02FC                   branch if wake up
         ldu   <P$SigVec,x             get signal handler addr
         beq   L02AC                   branch if none
         ldy   <P$SigDat,x             get data addr
         ldd   $06,s
         pshs  u,y,b,a
         ldu   $0A,s
         lda   <P$Signal,x
         ldb   $09,s
         tfr   d,y
         ldd   $06,s
         pshs  u,y,b,a
         clrb
L02FC    stb   <P$Signal,x
L02FF    ldd   <P$SWI2,x
         std   <D.SWI2
         ldd   <D.UsrIRQ
         std   <D.SvcIRQ
L0308    rti

FLink    pshs  u                       save caller regs
         ldd   R$A,u
         ldx   R$X,u
         lbsr  L0443
         bcc   FLinkOK
         ldb   #E$MNF
         bra   L033D
* U = module dir entry
FLinkOK  ldy   ,u                      get module ptr
         ldb   M$Revs,y
         bitb  #ReEnt                  reentrant?
         bne   L032A                   branch if so
         tst   $02,u                   link count zero?
         beq   L032A                   yep, ok to link to nonreent
         comb                          else module is busy
         ldb   #E$ModBsy
         bra   L033D
L032A    inc   $02,u                   increment link count
         ldu   ,s                      get caller regs from stack
         stx   R$X,u
         sty   R$U,u
         ldd   M$Type,y
         std   R$D,u
         ldd   M$IDSize,y
         leax  d,y
         stx   R$Y,u
L033D    puls  pc,u

FVModul  pshs  u
         ldx   R$X,u
         bsr   ValMod
         puls  y
         stu   R$U,y
         rts
* X = address of module to validate
ValMod   bsr   ChkMHCRC
         bcs   L039A
         lda   M$Type,x
         pshs  x,a
         ldd   M$Name,x
         leax  d,x                     X = addr of name in mod
         puls  a
         lbsr  L0443
         puls  x
         bcs   L039B
         ldb   #E$KwnMod
         cmpx  ,u
         beq   L03A1
         lda   M$Revs,x
         anda  #RevsMask
         pshs  a
         ldy   ,u
         lda   M$Revs,y
         anda  #RevsMask
         cmpa  ,s+                     same revision as other mod?
         bcc   L03A1
         pshs  y,x
         ldb   M$Size,u
         bne   L0395
         ldx   ,u
         cmpx  <D.BTLO
         bcc   L0395
         ldd   $02,x
         addd  #$00FF
         tfr   a,b
         clra
         tfr   d,y
         ldb   ,u
         ldx   <D.FMBM
         os9   F$DelBit
         clr   $02,u
L0395    puls  y,x
L0397    stx   ,u
         clrb
L039A    rts
L039B    leay  ,u
         bne   L0397
         ldb   #E$DirFul
L03A1    coma
         rts

* check module header and CRC
* X = address of potential module
ChkMHCRC ldd   ,x
         cmpd  #M$ID12                 sync bytes?
         bne   L03B1                   nope, not a module here
         leay  M$Parity,x
         bsr   ChkMHPar                check header parity
         bcc   L03B5                   branch if ok
L03B1    comb
         ldb   #E$BMID
         rts

L03B5
* Following 4 lines added to support no CRC checks - 2002/07/21
         lda   <D.CRC			is CRC checking on?
         bne   DoCRCCk			branch if so
         clrb
         rts

DoCRCCk  pshs  x
         ldy   M$Size,x
         bsr   ChkMCRC                 checkm module CRC
         puls  pc,x
* check module header parity
* Y = pointer to parity byte
ChkMHPar pshs  y,x
         clra
ChkM010  eora  ,x+
         cmpx  2,s                     compare to addr of M$Parity
         bls   ChkM010
         cmpa  #$FF
         puls  pc,y,x
* X = address of potential module
* Y = size of module
ChkMCRC  ldd   #$FFFF
         pshs  b,a
         pshs  b,a
         leau  1,s
L03D4    lda   ,x+
         bsr   CRCAlgo
         leay  -1,y                    dec Y (size of module)
         bne   L03D4                   continue
         clr   -1,u
         lda   ,u
         cmpa  #CRCCon1
         bne   L03EC
         ldd   1,u
         cmpd  #CRCCon23
         beq   L03EF
L03EC    comb
         ldb   #E$BMCRC
L03EF    puls  pc,y,x

* F$CRC
FCRC     ldx   R$X,u
         ldy   R$Y,u
         beq   L0402
         ldu   R$U,u
L03FA    lda   ,x+
         bsr   CRCAlgo
         leay  -1,y
         bne   L03FA
L0402    clrb
         rts

CRCAlgo  eora  ,u
         pshs  a
         ldd   $01,u
         std   ,u
         clra
         ldb   ,s
         lslb
         rola
         eora  1,u
         std   1,u
         clrb
         lda   ,s
         lsra
         rorb
         lsra
         rorb
         eora  1,u
         eorb  2,u
         std   1,u
         lda   ,s
         lsla
         eora  ,s
         sta   ,s
         lsla
         lsla
         eora  ,s
         sta   ,s
         lsla
         lsla
         lsla
         lsla
         eora  ,s+
         bpl   L0442
         ldd   #$8021
         eora  ,u
         sta   ,u
         eorb  2,u
         stb   2,u
L0442    rts

L0443    ldu   #$0000
         tfr   a,b
         anda  #TypeMask
         andb  #LangMask
         pshs  u,y,x,b,a
         bsr   EatSpace
         cmpa  #PDELIM                 pathlist char?
         beq   L049C                   branch if so
         lbsr  ParseNam                parse name
         bcs   L049D                   return if error
         ldu   <D.ModDir
L045B    pshs  u,y,b
         ldu   ,u
         beq   L048B
         ldd   $04,u
         leay  d,u
         ldb   ,s
         lbsr  L07AB
         bcs   L0493
         lda   $05,s
         beq   L0476
         eora  $06,u
         anda  #$F0
         bne   L0493
L0476    lda   $06,s
         beq   L0480
         eora  $06,u
         anda  #$0F
         bne   L0493
L0480    puls  u,x,b
         stu   $06,s
         bsr   EatSpace
         stx   $02,s
         clra
         bra   L049D
L048B    ldd   $0B,s
         bne   L0493
         ldd   $03,s
         std   $0B,s
L0493    puls  u,y,b
         leau  $04,u
         cmpu  <D.ModDir+2
         bcs   L045B
L049C    comb
L049D    puls  pc,u,y,x,b,a

EatSpace lda   #C$SPAC
EatSpc10 cmpa  ,x+
         beq   EatSpc10
         lda   ,-x
         rts

FFork    ldx   <D.PrcDBT
         os9   F$All64
         bcs   L0517
         ldx   <D.Proc
         pshs  x                       save calling proc desc on stack
         ldd   P$User,x
         std   P$User,y
         lda   P$Prior,x
         clrb
         std   P$Prior,y
         ldb   #SysState
         stb   P$State,y
         sty   <D.Proc
         ldd   <P$NIO,x
         std   <P$NIO,y
         ldd   <P$NIO+2,x
         std   <P$NIO+2,y
         leax  <P$DIO,x
         leay  <P$DIO,y
         ldb   #DefIOSiz
* copy I/O stuff from parent to child
L04D7    lda   ,x+
         sta   ,y+
         decb
         bne   L04D7
* X/Y = address of path table in respective proc desc
* Dup stdin/stdout/stderr
         ldb   #$03
L04E0    lda   ,x+
         os9   I$Dup
         bcc   L04E8
         clra
L04E8    sta   ,y+
         decb
         bne   L04E0
         bsr   L0553
         bcs   L050C
         puls  y                       get parent proc desc
         sty   <D.Proc
         lda   P$ID,x                  get ID of new process
         sta   R$A,u                   store in caller's A
         ldb   P$CID,y                 get child id of parent
         sta   P$CID,y                 store new proc in parent's CID
         lda   P$ID,y                  get ID of parent
         std   P$PID,x                 store in child proc desc
         ldb   P$State,x               update state of child
         andb  #^SysState
         stb   P$State,x
         os9   F$AProc                 insert child in active Q
         rts
L050C    pshs  b
         os9   F$Exit
         comb
         puls  x,b
         stx   <D.Proc
         rts
L0517    comb
         ldb   #E$PrcFul
         rts

FChain   bsr   L0543
         bcs   L0531
         orcc  #IntMasks
         ldb   $0D,x
         andb  #$7F
         stb   $0D,x
L0527    os9   F$AProc
         os9   F$NProc

SFChain  bsr   L0543
         bcc   L0527
L0531    pshs  b
         stb   <P$Signal,x
         ldb   P$State,x
         orb   #Condem
         stb   P$State,x
         ldb   #$FF
         stb   P$Prior,x
         comb
         puls  pc,b
L0543    pshs  u
         ldx   <D.Proc
         ldu   <P$PModul,x
         os9   F$UnLink
         ldu   ,s
         bsr   L0553
         puls  pc,u
L0553    ldx   <D.Proc
         pshs  u,x
         ldd   <D.UsrSvc
         std   <P$SWI,x
         std   <P$SWI2,x
         std   <P$SWI3,x
         clra
         clrb
         sta   <P$Signal,x
         std   <P$SigVec,x
         lda   R$A,u
         ldx   R$X,u
         os9   F$Link
         bcc   L0578
         os9   F$Load
         bcs   L05E7
L0578    ldy   <D.Proc
         stu   <P$PModul,y
         cmpa  #Prgrm+Objct
         beq   L058B
         cmpa  #Systm+Objct
         beq   L058B
         comb
         ldb   #E$NEMod
         bra   L05E7
L058B    leay  ,u                      Y = addr of module
         ldu   2,s                     get U off stack (caller regs)
         stx   R$X,u
         lda   R$B,u
         clrb
         cmpd  M$Mem,y                 compare passed mem to module's
         bcc   L059B                   branch if less than
         ldd   M$Mem,y
L059B    addd  #$0000
         bne   L05A0
L05A0    os9   F$Mem
         bcs   L05E7
         subd  #R$Size                 subtract registers
         subd  R$Y,u                   subtract parameter area
         bcs   L05E5
         ldx   R$U,u                   get parameter area
         ldd   R$Y,u                   get parameter size
         pshs  b,a
         beq   L05BE
         leax  d,x                     point to end of param area
L05B6    lda   ,-x                     get byte, dec X
         sta   ,-y                     save byte in data area, dec X
         cmpx  R$U,u                   at top of param area?
         bhi   L05B6
* set up registers for return of F$Fork/F$Chain
L05BE    ldx   <D.Proc
         sty   -$08,y                  put in X on caller stack
         leay  -R$Size,y               back up register size
         sty   P$SP,x
         lda   P$ADDR,x
         clrb
         std   R$U,y                   lowest address
         sta   R$DP,y                  set direct page
         adda  P$PagCnt,x
         std   R$Y,y
         puls  b,a
         std   R$D,y                   size of param area
         ldb   #Entire
         stb   R$CC,y
         ldu   <P$PModul,x             get addr of prim. mod
         ldd   M$Exec,u
         leau  d,u
         stu   R$PC,y                  put in PC on caller reg
         clrb
L05E5    ldb   #E$IForkP
L05E7    puls  pc,u,x

FSRqMem  ldd   R$D,u
         addd  #$00FF
         clrb
         std   R$D,u
         ldx   <D.FMBM+2
         ldd   #$01FF
         pshs  b,a
         bra   L0604
L05FA    dec   $01,s
         ldb   $01,s
L05FE    lsl   ,s
         bcc   L060A
         rol   ,s
L0604    leax  -1,x
         cmpx  <D.FMBM
         bcs   L0620
L060A    lda   ,x
         anda  ,s
         bne   L05FA
         dec   1,s
         subb  1,s
         cmpb  1,u
         rora
         addb  1,s
         rola
         bcs   L05FE
         ldb   1,s
         clra
         incb
L0620    leas  2,s
         bcs   L0635
         ldx   <D.FMBM
         tfr   d,y
         ldb   1,u
         clra
         exg   d,y
         bsr   L065A
         exg   a,b
         std   8,u
L0633    clra
         rts
L0635    comb
         ldb   #E$MemFul
         rts

FSRtMem  ldd   R$D,u
         addd  #$00FF
         tfr   a,b
         clra
         tfr   d,y
         ldd   R$U,u
         beq   L0633
         tstb
         beq   L064E
         comb
         ldb   #E$BPAddr
         rts
L064E    exg   a,b
         ldx   <D.FMBM
         bra   L06AD

FAllBit  ldd   R$D,u
         leau  R$X,u
         pulu  y,x
L065A    pshs  y,x,b,a
         bsr   L0690
         tsta
         pshs  a
         bmi   L0671
         lda   ,x
L0665    ora   ,s
         leay  -1,y
         beq   L0689
         lsr   ,s
         bcc   L0665
         sta   ,x+
L0671    tfr   y,d
         sta   ,s
         lda   #$FF
         bra   L067B
L0679    sta   ,x+
L067B    subb  #$08
         bcc   L0679
         dec   ,s
         bpl   L0679
L0683    lsla
         incb
         bne   L0683
         ora   ,x
L0689    sta   ,x
         clra
         leas  1,s
         puls  pc,y,x,b,a
L0690    pshs  b
         lsra
         rorb
         lsra
         rorb
         lsra
         rorb
         leax  d,x
         puls  b
         lda   #$80
         andb  #$07
         beq   L06A6
L06A2    lsra
         decb
         bne   L06A2
L06A6    rts

FDelBit  ldd   R$D,u
         leau  R$X,u
         pulu  y,x
L06AD    pshs  y,x,b,a
         bsr   L0690
         coma
         pshs  a
         bpl   L06C4
         lda   ,x
L06B8    anda  ,s
         leay  -1,y
         beq   L06D8
         asr   ,s
         bcs   L06B8
         sta   ,x+
L06C4    tfr   y,d
         bra   L06CA
L06C8    clr   ,x+
L06CA    subd  #$0008
         bhi   L06C8
         beq   L06D8
L06D1    lsla
         incb
         bne   L06D1
         coma
         anda  ,x
L06D8    sta   ,x
         clr   ,s+
         puls  pc,y,x,b,a

FSchBit  pshs  u
         ldd   R$D,u
         ldx   R$X,u
         ldy   R$Y,u
         ldu   R$U,u
         bsr   L06F3
         puls  u
         std   R$D,u
         sty   R$Y,u
         rts
L06F3    pshs  u,y,x,b,a
         pshs  y,b,a
         clr   8,s
         clr   9,s
         tfr   d,y
         bsr   L0690
         pshs  a
         bra   L0710
L0703    leay  $01,y
         sty   $05,s
L0708    lsr   ,s
         bcc   L0714
         ror   ,s
         leax  $01,x
L0710    cmpx  $0B,s
         bcc   L0732
L0714    lda   ,x
         anda  ,s
         bne   L0703
         leay  $01,y
         tfr   y,d
         subd  $05,s
         cmpd  $03,s
         bcc   L0739
         cmpd  $09,s
         bls   L0708
         std   $09,s
         ldd   $05,s
         std   $01,s
         bra   L0708
L0732    ldd   $01,s
         std   $05,s
         coma
         bra   L073B
L0739    std   $09,s
L073B    leas  $05,s
         puls  pc,u,y,x,b,a

         
         use   fprsnam.asm

         use   fcmpnam.asm

*FCmpNam  ldb   R$B,u
*         leau  R$X,u
*         pulu  y,x
*L07AB    pshs  y,x,b,a
*L07AD    lda   ,y+
*         bmi   L07BE
*         decb
*         beq   L07BA
*         eora  ,x+
*         anda  #$DF
*         beq   L07AD
*L07BA    orcc  #Carry
*         puls  pc,y,x,b,a
*L07BE    decb
*         bne   L07BA
*         eora  ,x
*         anda  #$5F
*         bne   L07BA
*         puls  y,x,b,a
*L07C9    andcc #^Carry
*         rts

FSSvc    ldy   R$Y,u
         bra   InstSSvc
SSvcLoop tfr   b,a                     put syscall code in A
         anda  #$7F                    kill hi bit
         cmpa  #$7F                    is code $7F?
         beq   SSvcOK
         cmpa  #$37			compare against highest call allowed
         bcs   SSvcOK                  branch if A less than highest call
         comb
         ldb   #E$ISWI
         rts
SSvcOK   lslb
         ldu   <D.SysDis
         leau  b,u                     U points to entry in table
         ldd   ,y++                    get addr of func
         leax  d,y                     get absolute addr
         stx   ,u                      store in system table
         bcs   InstSSvc                branch if system only
         stx   <$70,u                  else store in user table too
InstSSvc ldb   ,y+                     get system call code in B
         cmpb  #$80                    end of table?
         bne   SSvcLoop                branch if not
         rts

         emod
eom      equ   *

         fdb   Clock
Vectors  fdb   SWI3			SWI3 
         fdb   SWI2 			SWI2
         fdb   DUMMY			FIRQ
         fdb   SVCIRQ			IRQ
         fdb   SWI			SWI
         fdb   DUMMY			NMI

         end

