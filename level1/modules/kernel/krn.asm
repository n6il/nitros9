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
         endc

tylg     set   Systm+Objct
atrv     set   ReEnt+rev
rev      set   $00
edition  set   16

ModTop   mod   eom,name,tylg,atrv,OS9Cold,size

size     equ   .

name     fcs   /Krn/
         fcb   edition

*
* OS-9 Genesis!

OS9Cold  equ   *
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

* NOTE: This routine checks for RAM by writing a pattern at an address
* then reading it back for validation.  On the CoCo, we pretty much know
* that we are in all-RAM mode at this point, and the same goes for the
* other supported platforms.  So I am taking this code out for the time being.

         IFNE  CHECK_FOR_VALID_RAM
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
         ELSE
         ldx 	#Bt.Start
         ENDC
         stx   <D.MLIM                 save off memory limit

* Copy vector code over to address $100
         pshs  x
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
         puls  x

* Atari has bootfile already in memory
         IFNE  atari
* flag that we've booted and that Boot Low starts appropriately
         ldy   #$D000           Atari: I/O is at $D000-$D7FF
         inc   <D.Boot
         stx   <D.BTLO
         ldx   #$FFFF
         stx   <D.BTHI
         ELSE
         IFNE	corsham
         ldx	#Bt.Start
         ldy	#Bt.Start+Bt.Size-1
         ELSE
* CoCo
         ldy	#Bt.Start+Bt.Size
         ENDC
         ENDC

         lbsr	ValMods

* Atari: look for more modules at $D800-$F3FF
         IFNE  atari
         ldx   #$D800				
         ldy   #$F400
         lbsr  ValMods
         ENDC
         
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
*GetMem   ldd   MaxMem+1,u		I don't think this exists for Level1 RG
*         clrb
*         cmpd  <D.MLIM			starts as $EE00
*         bcc   L0158
*         std   <D.MLIM
GetMem   equ   *			Initially I tried GetMem clra
*                                       that is redundant. See last line. RG
L0158    ldx   <D.FMBM
* Free-memory bitmap. Bit7 of 0,x corresponds to page 0, bit6 to page 1 etc.
* Bit7 of 1,x corresponds to page 8, bit6 to page 9 etc, etc.

         IFNE  atari
* Atari needs $0000-$08FF and $D000-$D7FF reserved
         ldb   #%11111111
         stb   ,x                       mark $0000-$07FF as allocated
         stb   $1A,x                    mark $D000-$D7FF I/O area as allocated
         ldb   #%10000000
         stb   1,x                      mark $0800-$08FF as allocated
         ELSE
         IFNE  corsham
* Corsham needs $0000-$04FF and $E000-$EFFF reserved
         ldb   #%11111000
         stb   ,x                       mark $0000-$04FF as allocated
         ldb   #%11111111
         stb   $1C,x                    mark $E000-$E7FF I/O area as allocated
         stb   $1D,x                    mark $E800-$EFFF I/O area as allocated
         ELSE
* CoCo needs $0000-$04FF reserved
         ldb   #%11111000
         stb   ,x                       mark $0000-$04FF as allocated
         ENDC
         ENDC

* For all platforms exclude high memory as defined (earlier) by D.MLIM
         clra
         ldb   <D.MLIM
         negb
         tfr   d,y
         negb
         lbsr  L065A                    in included fallbit.asm

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
SVCNMI   jmp	[>D.NMI]
DUMMY	 rti
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
         std   R$X,u                   and store it back
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
         ldd   R$Y,s
* set up new return stack for RTI
         pshs  u,y,d            new PC (sigvec), new U (sigdat), same Y
         ldu   6+R$X,s          old X via U
         lda   <P$Signal,x      signal ...
         ldb   6+R$DP,s         and old DP ...
         IFEQ  H6309
         tfr   d,y              via Y
         ldd   6+R$CC,s         old CC and A via D
         pshs  u,y,d            same X, same DP / new B (signal), same A / CC
         ELSE
         pshs  u,b              same X, same DP
         pshsw                  same W
         pshs  a                new B (signal)
         ldd   6+6+R$CC,s
         pshs  d                same A / CC
         ENDC
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
         bcs   ValModEx
         lda   M$Type,x
         pshs  x,a
         ldd   M$Name,x
         leax  d,x                     X = addr of name in mod
         IFNE  atari
* jsr [>$FFE8]
* lda	#$20
* jsr [>$FFE4]
         ENDC
         puls  a
         lbsr  L0443
         puls  x
         bcs   ValLea
         ldb   #E$KwnMod
         cmpx  ,u
         beq   errex@
         lda   M$Revs,x
         anda  #RevsMask
         pshs  a
         ldy   ,u
         lda   M$Revs,y
         anda  #RevsMask
         cmpa  ,s+                     same revision as other mod?
         bcc   errex@
         pshs  y,x
         ldb   M$Size,u
         bne   ValPul
         ldx   ,u
         cmpx  <D.BTLO
         bcc   ValPul
         ldd   $02,x
         addd  #$00FF
         tfr   a,b
         clra
         tfr   d,y
         ldb   ,u
         ldx   <D.FMBM
         os9   F$DelBit
         clr   $02,u
ValPul   puls  y,x
ValSto   stx   ,u
         clrb
ValModEx rts
ValLea   leay  ,u
         bne   ValSto
         ldb   #E$DirFul
errex@   coma
         rts

* check module header and CRC
* X = address of potential module
ChkMHCRC ldd   ,x
         cmpd  #M$ID12                 sync bytes?
         bne   ChkMHEx                nope, not a module here
         leay  M$Parity,x
         bsr   ChkMHPar                check header parity
         bcc   Chk4CRC                 branch if ok
ChkMHEx  comb
         ldb   #E$BMID
         rts

Chk4CRC
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

L0443
         ldu   #$0000
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

* F$Chain user state
FChain   bsr   DoChain                 do the F$Chain
         bcs   chainErr                branch if error
         orcc  #IntMasks               mask interrupts
         ldb   P$State,x               get process state
         andb  #^SysState              turn off system state
         stb   P$State,x               save new state
reSched
         ldu   <P$PModul,x             get pointer to module for current process
         os9   F$UnLink                unlink the module
         os9   F$AProc                 activate process
         os9   F$NProc

* F$Chain system state
SFChain  bsr   DoChain                 do the F$Chain
         bcc   reSched
chainErr pshs  b
         stb   <P$Signal,x             save off error code
         ldb   P$State,x               get process state
         orb   #Condem                 set the condemn bit
         stb   P$State,x               save new state
         ldb   #$FF                    get highest priority
         stb   P$Prior,x               set priority
         comb                          set carry
         puls  pc,b                    return error
         
DoChain  pshs  u                       save off caller's SP
         ldx   <D.Proc                 get current process descriptor
         ldu   ,s                      get saved caller's SP
         bsr   L0553
         puls  pc,u                    recover U and return
         
L0553    ldx   <D.Proc                 get current process descriptor
         pshs  u,x                     save off
         ldd   <D.UsrSvc               get user service table
         std   <P$SWI,x                save off as process' SWI vector
         std   <P$SWI2,x               ... and SWI2 vector
         std   <P$SWI3,x               ... and SWI3 vector
         clra
         clrb
         sta   <P$Signal,x             clear signal
         std   <P$SigVec,x             clear signal vector
         lda   R$A,u                   get caller's A
         ldx   R$X,u                   ... and X
         os9   F$Link                  link the module to chain to
         bcc   L0578                   branch if OK
         os9   F$Load                  ... else load the module to chain to
         bcs   L05E7                   ... and branch if error
L0578    ldy   <D.Proc                 get current process
         stu   <P$PModul,y             save off module pointer
         cmpa  #Prgrm+Objct            is this a program module?
         beq   L058B                   branch if so
         cmpa  #Systm+Objct            is it a system module?
         beq   L058B                   branch if so
         comb                          else set carry
         ldb   #E$NEMod                set error in B
         bra   L05E7                   and return
L058B    leay  ,u                      Y = addr of module
         ldu   2,s                     get U off stack (caller regs)
         stx   R$X,u                   update X to point past name
         lda   R$B,u                   get caller's requested memory size in 256 byte pages
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
         sty   -R$Size+R$X,y           put in X on caller stack
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

		use   fsrqmem.asm
         
		use   fallbit.asm
         
		use   fprsnam.asm

		use   fcmpnam.asm

		use   fssvc.asm

* Validate modules subroutine
* Entry: X = address to start searching
*	    Y = address to stop (actually stops at Y-1)
ValMods	pshs	y
valloop@	lbsr	ValMod
		bcs	valerr
		ldd	M$Size,x
		leax	d,x                     go past module
		bra	valcheck
valerr	cmpb	#E$KwnMod
		beq	valret
		leax	1,x
valcheck	cmpx	,s
		bcs	valloop@
valret	puls  y,pc

		
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

InitNam  fcs   /Init/

P2Nam    fcs   /krnp2/

         
         
EOMTop		EQU	*

                IFEQ    corsham
		emod
eom      		equ	*
                ENDC

		IFNE 	atari
		fdb	$F3FE-(*-OS9Cold)
		ENDC

Vectors		fdb	SWI3		SWI3
		fdb	SWI2		SWI2
		fdb	DUMMY		FIRQ
		fdb	SVCIRQ		IRQ
		fdb	SWI		SWI
		fdb	SVCNMI		NMI

                IFNE    corsham
		emod
eom      		equ	*
                ENDC
EOMSize		equ	*-EOMTop

		end
