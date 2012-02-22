********************************************************************
* Krn - NitrOS-9 Level 1 Kernel
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
*  $0220-$0221  |      IOMan I/O Call Pointer      |
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
*               |                                  |
*               |                                  |
*               |                                  |
*  $0500-$08FF  |    Screen Memory (Atari Only)    |
*               |                                  |
*               |                                  |
*               |                                  |
*     $0900---->|==================================|
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
*
*  15r1    2004/05/23  Boisy G. Pitre
* Renamed to 'krn'
*
*  16      2004/05/23  Boisy G. Pitre
* Added changes for Atari port

         nam   krn
         ttl   NitrOS-9 Level 1 Kernel

         ifp1
         use   defsfile
         use   scfdefs
         IFNE	atari
         use   atarivtio.d
         ENDC
         endc

tylg     set   Systm+Objct
atrv     set   ReEnt+rev
rev      set   $00
edition  set   16

ModTop   mod   eom,name,tylg,atrv,OS9Cold,size

size     equ   .

name     fcs   /Krn/
         fcb   edition

InitNam  fcs   /Init/

P2Nam    fcs   /krnp2/

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
         fcb   F$Chain+SysState
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
         fcb   F$SRqMem+SysState
         fdb   FSRqMem-*-2
         fcb   F$SRtMem+SysState
         fdb   FSRtMem-*-2
         fcb   F$AProc+SysState
         fdb   FAProc-*-2
         fcb   F$NProc+SysState
         fdb   FNProc-*-2
         fcb   F$VModul+SysState
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

         IFNE  atari
* Currently NitrOS-9 is in ROM on the Atari.
* Since the Liber809 is coming here directly from reset,
* we will be good and get the hardware initialized properly.
		lbsr	InitAtari
         ENDC
         
* clear out system globals from $0000-$0400
*         ldx   #D.FMBM
         ldx   #$0000
         IFNE  H6309
*         ldw   #$400-D.FMBM
         ldw   #$400
         leay  Zoro,pc
         tfm   y,x+
         ELSE
*         ldy   #$400-D.FMBM
         ldy   #$400
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
         IFNE  atari
         cmpx  #$C000                  stop short of ROM starting at $C000
         ELSE
         cmpx  #Bt.Start               stop short of boot track mem
         ENDC
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

         IFNE  atari
         ldx   #$D800                  skip $C000-$D7FF for now...
         ENDC
         
* Validate modules at top of RAM (kernel, etc.)
L00DB    lbsr  ValMod
         bcs   L00E6
         ldd   M$Size,x
         leax  d,x                     go past module
         bra   L00EC
L00E6    cmpb  #E$KwnMod
         beq   L00EE
         leax  1,x

L00EC
         IFNE  atari
         cmpx  #$FF00
         ELSE
* Modification to stop scan into I/O space -- Added by BGP
         cmpx  #Bt.Start+Bt.Size
         ENDC
         bcs   L00DB

* Copy vectors to system globals
L00EE    leay  >Vectors,pcr
         leax  >ModTop,pcr
         pshs  x
         ldx   #D.SWI3
L00FB    ldd   ,y++
         addd  ,s
         std   ,x++
         cmpx  #D.NMI
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
         leax  >Poll,pcr          point to default poll routine
         stx   <D.Poll            and save it 
         leax  >Clock,pcr         get default clock routine
         stx   <D.Clock           and save it to the vector
         stx   <D.AltIRQ          and in the alternate IRQ vector

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
		IFNE	atari
* In the Atari, memory $0000-$08FF is used by the system
         ldb   #%11111111
         stb   ,x				mark $0000-$07FF as allocated
         stb   $1A,x			mark $D000-$D7FF I/O area as allocated
         ldb   #%10000000		
         stb   1,x				mark $0800-$08FF as allocated
		ELSE
* In the CoCo, memory $0000-$04FF is used by the system
         ldb   #%11111000
         stb   ,x
         	ENDC
         clra
         ldb   <D.MLIM
         negb
         tfr   d,y
         negb
         lbsr  L065A

* jump into krnp2 here
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

UsrIRQ   leay  <DoIRQPoll,pcr
* transition from user to system state
URtoSs   clra
         tfr   a,dp                    clear direct page
         ldx   <D.Proc                 get current process desc
* Note that we are putting the system state service routine address into
* the D.SWI2 vector.  If a system call is made while we are in system state,
* D.SWI2 will be vectored to the system state service routine vector.
         ldd   <D.SysSvc               get system state system call vector
         std   <D.SWI2                 store in D.SWI2
* The same comment above applies to the IRQ service vector.
         ldd   <D.SysIRQ               get system IRQ vector
         std   <D.SvcIRQ               store in D.SvcIRQ
         leau  ,s                      point U to S
         stu   P$SP,x                  and save in process P$SP
         lda   P$State,x               get state field in proc desc
         ora   #SysState               mark process to be in system state
         sta   P$State,x               store it
         jmp   ,y                      jump to ,y

DoIRQPoll
         jsr   [>D.Poll]               call vectored polling routine
         bcc   L01BD                   branch if carry clear
         ldb   ,s                      get the CC on the stack
         orb   #IRQMask                mask IRQs
         stb   ,s                      and save it back
L01BD    lbra  ActivateProc



SysIRQ   clra
         tfr   a,dp                    make DP be 0
         jsr   [>D.Poll]               call the vectored IRQ polling routine
         bcc   L01CF                   branch if carry is clear
         ldb   ,s                      get the CC on the stack
         orb   #IRQMask                mask IRQs
         stb   ,s                      and save it back
L01CF    rti

Poll     comb
         rts

* Default clock routine - executed 60 times/sec
Clock    ldx   <D.SProcQ               get pointer to sleeping proc queue
         beq   L01FD                   branch if no process sleeping
         lda   P$State,x               get state of that process
         bita  #TimSleep               timed sleep?
         beq   L01FD                   branch if clear
         ldu   P$SP,x                  else get process stack pointer
         ldd   R$X,u                   get the value of the process X reg
         subd  #$0001                  subtract one from it
         std   P$SP,u                  and store it
         bne   L01FD                   branch if not zero (still will sleep)
L01E7    ldu   P$Queue,x               get process current queue pointer
         bsr   L021A 
         leax  ,u
         beq   L01FB
         lda   P$State,x               get process state byte
         bita  #TimSleep               bit set?
         beq   L01FB                   branch if not
         ldu   P$SP,x                  get process stack pointer
         ldd   R$X,u                   then get process X register
         beq   L01E7                   branch if zero
L01FB    stx   <D.SProcQ
L01FD    dec   <D.Slice                decrement slice
         bne   ClockRTI                if not 0, exit ISR
         lda   <D.TSlice               else get default time slice
         sta   <D.Slice                and save it as slice
         ldx   <D.Proc                 get proc desc of current proc
         beq   ClockRTI                if none, exit ISR
         lda   P$State,x               get process state
         ora   #TimOut                 set timeout bit
         sta   P$State,x               and store back
         bpl   L0212                   branch if not system state
ClockRTI rti

L0212    leay  >ActivateProc,pcr
         bra   URtoSs


*FAProc   ldx   R$X,u        Get ptr to process to activate
*L0D11    clrb  
*         pshs  cc,b,x,y,u
*         lda   P$Prior,x    Get process priority
*         sta   P$Age,x      Save it as age (How long it's been around)
*         orcc  #IntMasks    Shut down IRQ's
*         ldu   #(D.AProcQ-P$Queue)  Get ptr to active process queue
*         bra   L0D29        Go through the chain
** Update active process queue
**  X=Process to activate
**  U=Current process in queue links
*L0D1F    inc   P$Age,u      update current process age
*         bne   L0D25        wrap?
*         dec   P$Age,u      yes, reset it to max.
*L0D25    cmpa  P$Age,u      match process ages??
*         bhi   L0D2B        no, skip update
*L0D29    leay  ,u           point Y to current process
*L0D2B    ldu   P$Queue,u    get pointer to next process in chain
*         bne   L0D1F        Still more in chain, keep going
*         ldd   P$Queue,y    
*         stx   P$Queue,y    save new process to chain
*         std   P$Queue,x
*         puls  cc,b,x,y,u,pc


         use    faproc.asm
         
* User-State system call entry point
*
* All system calls made from user-state will go through this code.
UsrSvc   leay  <MakeSysCall,pcr
         orcc  #IntMasks
         lbra  URtoSs

MakeSysCall
         andcc #^IntMasks              unmask IRQ/FIRQ
         ldy   <D.UsrDis               get pointer to user syscall dispatch table
         bsr   DoSysCall               go do the system call
ActivateProc
         ldx   <D.Proc                 get current proc desc
         beq   FNProc                  branch to FNProc if none
         orcc  #IntMasks               mask interrupts
         ldb   P$State,x               get state value in proc desc
         andb  #^SysState              turn off system state flag
         stb   P$State,x               save state value
         bitb  #TimOut                 timeout bit set?
         beq   L02D1                   branch if not
         andb  #^TimOut                else turn off bit
         stb   P$State,x               in state value
         bsr   L021A
         bra   FNProc

* System-State system call entry point
SysSvc   clra
         tfr   a,dp                    set direct page to 0
         leau  ,s                      point U to SP
         ldy   <D.SysDis               get system state dispatch table ptr
         bsr   DoSysCall
         rti

* Entry: Y = Dispatch table (user or system)
DoSysCall
         pshs  u
         ldx   R$PC,u                  point X to PC
         ldb   ,x+                     get func code at X
         stx   R$PC,u                  restore updated PC
         lslb                          high bit set?
         bcc   L0288                   branch if not (non I/O call)
         rorb                          else restore B (its an I/O call)
         ldx   -2,y                    grab IOMan vector
* Note: should check if X is zero in case IOMan was not installed.
         bra   L0290
L0288    cmpb  #$37*2
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

         use   fcrc.asm

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

         IFNE	atari-1
         use   fsrqmem.asm
         
         use   fallbit.asm
         
         use   fprsnam.asm

         use   fcmpnam.asm

         use   fssvc.asm
         
         ELSE

* Character Set -- must be aligned on a 1K boundary!
CharSet
		fcb	$00,$00,$00,$00,$00,$00,$00,$00	;$00 - space
		fcb	$00,$18,$18,$18,$18,$00,$18,$00	;$01 - !
		fcb	$00,$66,$66,$66,$00,$00,$00,$00	;$02 - "
		fcb	$00,$66,$FF,$66,$66,$FF,$66,$00	;$03 - #
		fcb	$18,$3E,$60,$3C,$06,$7C,$18,$00	;$04 - $
		fcb	$00,$66,$6C,$18,$30,$66,$46,$00	;$05 - %
		fcb	$1C,$36,$1C,$38,$6F,$66,$3B,$00	;$06 - &
		fcb	$00,$18,$18,$18,$00,$00,$00,$00	;$07 - '
		fcb	$00,$0E,$1C,$18,$18,$1C,$0E,$00	;$08 - (
		fcb	$00,$70,$38,$18,$18,$38,$70,$00	;$09 - )
		fcb	$00,$66,$3C,$FF,$3C,$66,$00,$00	;$0A - asterisk
		fcb	$00,$18,$18,$7E,$18,$18,$00,$00	;$0B - plus
		fcb	$00,$00,$00,$00,$00,$18,$18,$30	;$0C - comma
		fcb	$00,$00,$00,$7E,$00,$00,$00,$00	;$0D - minus
		fcb	$00,$00,$00,$00,$00,$18,$18,$00	;$0E - period
		fcb	$00,$06,$0C,$18,$30,$60,$40,$00	;$0F - /
		
		fcb	$00,$3C,$66,$6E,$76,$66,$3C,$00	;$10 - 0
		fcb	$00,$18,$38,$18,$18,$18,$7E,$00	;$11 - 1
		fcb	$00,$3C,$66,$0C,$18,$30,$7E,$00	;$12 - 2
		fcb	$00,$7E,$0C,$18,$0C,$66,$3C,$00	;$13 - 3
		fcb	$00,$0C,$1C,$3C,$6C,$7E,$0C,$00	;$14 - 4
		fcb	$00,$7E,$60,$7C,$06,$66,$3C,$00	;$15 - 5
		fcb	$00,$3C,$60,$7C,$66,$66,$3C,$00	;$16 - 6
		fcb	$00,$7E,$06,$0C,$18,$30,$30,$00	;$17 - 7
		fcb	$00,$3C,$66,$3C,$66,$66,$3C,$00	;$18 - 8
		fcb	$00,$3C,$66,$3E,$06,$0C,$38,$00	;$19 - 9
		fcb	$00,$00,$18,$18,$00,$18,$18,$00	;$1A - colon
		fcb	$00,$00,$18,$18,$00,$18,$18,$30	;$1B - semicolon
		fcb	$06,$0C,$18,$30,$18,$0C,$06,$00	;$1C - <
		fcb	$00,$00,$7E,$00,$00,$7E,$00,$00	;$1D - =
		fcb	$60,$30,$18,$0C,$18,$30,$60,$00	;$1E - >
		fcb	$00,$3C,$66,$0C,$18,$00,$18,$00	;$1F - ?
		
		fcb	$00,$3C,$66,$6E,$6E,$60,$3E,$00	;$20 - @
		fcb	$00,$18,$3C,$66,$66,$7E,$66,$00	;$21 - A
		fcb	$00,$7C,$66,$7C,$66,$66,$7C,$00	;$22 - B
		fcb	$00,$3C,$66,$60,$60,$66,$3C,$00	;$23 - C
		fcb	$00,$78,$6C,$66,$66,$6C,$78,$00	;$24 - D
		fcb	$00,$7E,$60,$7C,$60,$60,$7E,$00	;$25 - E
		fcb	$00,$7E,$60,$7C,$60,$60,$60,$00	;$26 - F
		fcb	$00,$3E,$60,$60,$6E,$66,$3E,$00	;$27 - G
		fcb	$00,$66,$66,$7E,$66,$66,$66,$00	;$28 - H
		fcb	$00,$7E,$18,$18,$18,$18,$7E,$00	;$29 - I
		fcb	$00,$06,$06,$06,$06,$66,$3C,$00	;$2A - J
		fcb	$00,$66,$6C,$78,$78,$6C,$66,$00	;$2B - K
		fcb	$00,$60,$60,$60,$60,$60,$7E,$00	;$2C - L
		fcb	$00,$63,$77,$7F,$6B,$63,$63,$00	;$2D - M
		fcb	$00,$66,$76,$7E,$7E,$6E,$66,$00	;$2E - N
		fcb	$00,$3C,$66,$66,$66,$66,$3C,$00	;$2F - O
		
		fcb	$00,$7C,$66,$66,$7C,$60,$60,$00	;$30 - P
		fcb	$00,$3C,$66,$66,$66,$6C,$36,$00	;$31 - Q
		fcb	$00,$7C,$66,$66,$7C,$6C,$66,$00	;$32 - R
		fcb	$00,$3C,$60,$3C,$06,$06,$3C,$00	;$33 - S
		fcb	$00,$7E,$18,$18,$18,$18,$18,$00	;$34 - T
		fcb	$00,$66,$66,$66,$66,$66,$7E,$00	;$35 - U
		fcb	$00,$66,$66,$66,$66,$3C,$18,$00	;$36 - V
		fcb	$00,$63,$63,$6B,$7F,$77,$63,$00	;$37 - W
		fcb	$00,$66,$66,$3C,$3C,$66,$66,$00	;$38 - X
		fcb	$00,$66,$66,$3C,$18,$18,$18,$00	;$39 - Y
		fcb	$00,$7E,$0C,$18,$30,$60,$7E,$00	;$3A - Z
		fcb	$00,$1E,$18,$18,$18,$18,$1E,$00	;$3B - [
		fcb	$00,$40,$60,$30,$18,$0C,$06,$00	;$3C - \
		fcb	$00,$78,$18,$18,$18,$18,$78,$00	;$3D - ]
		fcb	$00,$08,$1C,$36,$63,$00,$00,$00	;$3E - ^
		fcb	$00,$00,$00,$00,$00,$00,$FF,$00	;$3F - underline
		
		fcb	$00,$18,$3C,$7E,$7E,$3C,$18,$00	;$60 - diamond card
		fcb	$00,$00,$3C,$06,$3E,$66,$3E,$00	;$61 - a
		fcb	$00,$60,$60,$7C,$66,$66,$7C,$00	;$62 - b
		fcb	$00,$00,$3C,$60,$60,$60,$3C,$00	;$63 - c
		fcb	$00,$06,$06,$3E,$66,$66,$3E,$00	;$64 - d
		fcb	$00,$00,$3C,$66,$7E,$60,$3C,$00	;$65 - e
		fcb	$00,$0E,$18,$3E,$18,$18,$18,$00	;$66 - f
		fcb	$00,$00,$3E,$66,$66,$3E,$06,$7C	;$67 - g
		fcb	$00,$60,$60,$7C,$66,$66,$66,$00	;$68 - h
		fcb	$00,$18,$00,$38,$18,$18,$3C,$00	;$69 - i
		fcb	$00,$06,$00,$06,$06,$06,$06,$3C	;$6A - j
		fcb	$00,$60,$60,$6C,$78,$6C,$66,$00	;$6B - k
		fcb	$00,$38,$18,$18,$18,$18,$3C,$00	;$6C - l
		fcb	$00,$00,$66,$7F,$7F,$6B,$63,$00	;$6D - m
		fcb	$00,$00,$7C,$66,$66,$66,$66,$00	;$6E - n
		fcb	$00,$00,$3C,$66,$66,$66,$3C,$00	;$6F - o
		
		fcb	$00,$00,$7C,$66,$66,$7C,$60,$60	;$70 - p
		fcb	$00,$00,$3E,$66,$66,$3E,$06,$06	;$71 - q
		fcb	$00,$00,$7C,$66,$60,$60,$60,$00	;$72 - r
		fcb	$00,$00,$3E,$60,$3C,$06,$7C,$00	;$73 - s
		fcb	$00,$18,$7E,$18,$18,$18,$0E,$00	;$74 - t
		fcb	$00,$00,$66,$66,$66,$66,$3E,$00	;$75 - u
		fcb	$00,$00,$66,$66,$66,$3C,$18,$00	;$76 - v
		fcb	$00,$00,$63,$6B,$7F,$3E,$36,$00	;$77 - w
		fcb	$00,$00,$66,$3C,$18,$3C,$66,$00	;$78 - x
		fcb	$00,$00,$66,$66,$66,$3E,$0C,$78	;$79 - y
		fcb	$00,$00,$7E,$0C,$18,$30,$7E,$00	;$7A - z
		fcb	$00,$18,$3C,$7E,$7E,$18,$3C,$00	;$7B - spade card
		fcb	$18,$18,$18,$18,$18,$18,$18,$18	;$7C - |
		fcb	$00,$7E,$78,$7C,$6E,$66,$06,$00	;$7D - display clear
		fcb	$08,$18,$38,$78,$38,$18,$08,$00	;$7E - display backspace
		fcb	$10,$18,$1C,$1E,$1C,$18,$10,$00	;$7F - display tab

		fcb	$00,$36,$7F,$7F,$3E,$1C,$08,$00	;$40 - heart card
		fcb	$18,$18,$18,$1F,$1F,$18,$18,$18	;$41 - mid left window
		fcb	$03,$03,$03,$03,$03,$03,$03,$03	;$42 - right box
		fcb	$18,$18,$18,$F8,$F8,$00,$00,$00	;$43 - low right window
		fcb	$18,$18,$18,$F8,$F8,$18,$18,$18	;$44 - mid right window
		fcb	$00,$00,$00,$F8,$F8,$18,$18,$18	;$45 - up right window
		fcb	$03,$07,$0E,$1C,$38,$70,$E0,$C0	;$46 - right slant box
		fcb	$C0,$E0,$70,$38,$1C,$0E,$07,$03	;$47 - left slant box
		fcb	$01,$03,$07,$0F,$1F,$3F,$7F,$FF	;$48 - right slant solid
		fcb	$00,$00,$00,$00,$0F,$0F,$0F,$0F	;$49 - low right solid
		fcb	$80,$C0,$E0,$F0,$F8,$FC,$FE,$FF	;$4A - left slant solid
		fcb	$0F,$0F,$0F,$0F,$00,$00,$00,$00	;$4B - up right solid
		fcb	$F0,$F0,$F0,$F0,$00,$00,$00,$00	;$4C - up left solid
		fcb	$FF,$FF,$00,$00,$00,$00,$00,$00	;$4D - top box
		fcb	$00,$00,$00,$00,$00,$00,$FF,$FF	;$4E - bottom box
		fcb	$00,$00,$00,$00,$F0,$F0,$F0,$F0	;$4F - low left solid
		
		fcb	$00,$1C,$1C,$77,$77,$08,$1C,$00	;$50 - club card
		fcb	$00,$00,$00,$1F,$1F,$18,$18,$18	;$51 - up left window
		fcb	$00,$00,$00,$FF,$FF,$00,$00,$00	;$52 - mid box
		fcb	$18,$18,$18,$FF,$FF,$18,$18,$18	;$53 - mid window
		fcb	$00,$00,$3C,$7E,$7E,$7E,$3C,$00	;$54 - solid circle
		fcb	$00,$00,$00,$00,$FF,$FF,$FF,$FF	;$55 - bottom solid
		fcb	$C0,$C0,$C0,$C0,$C0,$C0,$C0,$C0	;$56 - left box
		fcb	$00,$00,$00,$FF,$FF,$18,$18,$18	;$57 - up mid window
		fcb	$18,$18,$18,$FF,$FF,$00,$00,$00	;$58 - low mid window
		fcb	$F0,$F0,$F0,$F0,$F0,$F0,$F0,$F0	;$59 - left solid
		fcb	$18,$18,$18,$1F,$1F,$00,$00,$00	;$5A - low left window
		fcb	$78,$60,$78,$60,$7E,$18,$1E,$00	;$5B - display escape
		fcb	$00,$18,$3C,$7E,$18,$18,$18,$00	;$5C - up arrow
		fcb	$00,$18,$18,$18,$7E,$3C,$18,$00	;$5D - down arrow
		fcb	$00,$18,$30,$7E,$30,$18,$00,$00	;$5E - left arrow
		fcb	$00,$18,$0C,$7E,$0C,$18,$00,$00	;$5F - right arrow
		
 use atarivtio.d
dump
 pshs d,x
 leax hextable,pcr
 ldb ,s
 andb #$F0
 lsrb
 lsrb
 lsrb
 lsrb
 lda b,x
 sta ScrStart+0
 ldb ,s
 andb #$0F
 lda b,x
 sta ScrStart+1

 ldb 1,s
 andb #$F0
 lsrb
 lsrb
 lsrb
 lsrb
 lda b,x
 sta ScrStart+2
 ldb 1,s
 andb #$0F
 lda b,x
 sta ScrStart+3
m jmp m

hextable	fcb $30-$20,$31-$20,$32-$20,$33-$20,$34-$20,$35-$20,$36-$20,$37-$20
		fcb $38-$20,$39-$20,$41-$20,$42-$20,$43-$20,$44-$20,$45-$20,$46-$20

		use   fsrqmem.asm
         
		use   fallbit.asm
         
		use   fprsnam.asm

		use   fcmpnam.asm

		use   fssvc.asm

          fcb  $39,$39,$39,$39,$39,$39,$39,$39,$39,$39,$39,$39,$39,$39,$39,$39,$39,$39,$39,$39,$39
          fcb  $39,$39
          fcb  $39,$39,$39,$39,$39,$39,$39,$39,$39,$39,$39,$39,$39,$39,$39,$39
          fcb  $39,$39,$39,$39,$39,$39,$39,$39,$39,$39,$39,$39,$39,$39,$39,$39
          fcb  $39,$39,$39,$39,$39,$39,$39,$39,$39,$39,$39,$39,$39,$39,$39,$39
          fcb  $39,$39,$39,$39,$39,$39,$39,$39,$39,$39,$39,$39,$39,$39,$39,$39
          fcb  $39,$39,$39,$39,$39,$39,$39,$39,$39,$39,$39,$39,$39,$39,$39,$39
          fcb  $39,$39,$39,$39,$39,$39,$39,$39,$39,$39,$39,$39,$39,$39,$39,$39
          fcb  $39,$39,$39,$39,$39,$39,$39,$39,$39,$39,$39,$39,$39,$39,$39,$39
          fcb  $39,$39,$39,$39,$39,$39,$39,$39,$39,$39,$39,$39,$39,$39,$39,$39
          fcb  $39,$39,$39,$39,$39,$39,$39,$39,$39,$39,$39,$39,$39,$39,$39,$39
          fcb  $39,$39,$39,$39,$39
* The display list sets up the ANTIC chip to display the main screen. 
* It cannot cross a 1K boundary.
dlist
		fcb	$70,$70,$70	3 * 8 blank scanlines
		fcb	$42			Mode 2 with LMS (Load Memory Scan).  Mode 2 = 40 column hires text, next 2 bytes L/H determine screen origin
		fdbs	ScrStart		screen origin.  Usually put at top of available RAM.  Screen data will wrap around 4K boundary unless another LMS is used
* default with Atari OS in >= 48K system is $9C40 for a 40*24 screen
		fcb	2,2,2,2,2,2,2,2,2,2
		fcb	2,2,2,2,2,2,2,2,2,2
		fcb	2,2,2
* 23 extra mode 2 lines for total of 24.  240 scanlines can be used for display area, but a hires line can't be on scanline 240 due to an Antic bug
		fcb	$41			this is the end of Display List command JVB (Jump and wait for Vertical Blank)
          IFP2
         	fdbs $10000-eomem+dlist
         	ELSE
         	fdb  $0000
         	ENDC

***********************************************************************
* Atari initialization code goes here since we have to pad the area due
* to 1K alignment of character set above
InitAtari
         orcc  #IntMasks
* Clear I/O devices
         clrb
cleario
         ldx   #$D000
         clr   b,x
         ldx   #$D200
         clr   b,x
         ldx   #$D300
         clr   b,x
         ldx   #$D400
         clr   b,x
         decb
         bne   cleario         
* set POKEY to active
         lda   #3
         sta   $D20F
		rts
		
          fcb  $39,$39,$39,$39,$39,$39,$39,$39,$39,$39,$39,$39,$39,$39,$39,$39
          fcb  $39,$39,$39,$39,$39,$39,$39,$39,$39,$39,$39,$39,$39,$39,$39,$39
          fcb  $39,$39,$39,$39,$39,$39,$39,$39,$39,$39,$39,$39,$39,$39,$39,$39
          fcb  $39,$39,$39,$39,$39,$39,$39,$39,$39,$39,$39,$39,$39,$39,$39,$39
          fcb  $39,$39,$39,$39,$39,$39,$39,$39,$39,$39,$39,$39,$39,$39,$39,$39
          fcb  $39,$39,$39,$39,$39,$39,$39,$39,$39,$39,$39,$39,$39,$39,$39,$39
          fcb  $39,$39,$39,$39,$39,$39,$39,$39,$39,$39,$39,$39,$39,$39,$39,$39
          fcb  $39,$39,$39,$39,$39,$39,$39,$39,$39,$39,$39,$39,$39,$39,$39,$39
          fcb  $39,$39,$39,$39,$39,$39,$39,$39,$39,$39,$39,$39,$39,$39,$39,$39
          fcb  $39,$39,$39,$39,$39,$39,$39,$39,$39,$39,$39,$39,$39,$39,$39
*          fcb  $39,$39,$39

		ENDC
		
		emod
eom      	equ	*

         fdb   Clock
Vectors  fdb   SWI3                    SWI3 
         fdb   SWI2                    SWI2
         fdb   DUMMY                   FIRQ
         fdb   SVCIRQ                  IRQ
         fdb   SWI                     SWI
         fdb   DUMMY                   NMI
         IFNE  atari
         fdb   $0000
		 fdb   $0100
		 fdb   $0103
		 fdb   $0106
		 fdb   $0109
		 fdb   $010C
		 fdb   $010F
         IFP2
         fdb   $10000-eomem+OS9Cold                 RESET         
         ELSE
         fdb   $0000
         ENDC
		 ENDC
eomem    equ   *
         end
