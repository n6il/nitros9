********************************************************************
* krnp2 - NitrOS-9 Level 1 Kernel Part 2
*
* $Id$
*
* Edt/Rev  YYYY/MM/DD  Modified by
* Comment
* ------------------------------------------------------------------
*  11      2013/05/29  Boisy G. Pitre                                                                                                                  
* F$Debug now incorporated, allows for reboot.   

         nam   krnp2
         ttl   NitrOS-9 Level 1 Kernel Part 2

         ifp1
         use   defsfile
         endc

tylg     set   Systm+Objct
atrv     set   ReEnt+rev
rev      set   $00
edition  set   11

         mod   eom,name,tylg,atrv,start,size

size     equ   .

name     fcs   /KrnP2/
         fcb   edition

SvcTbl   fcb   $7F
         fdb   IOCall-*-2

         fcb   F$Unlink
         fdb   FUnlink-*-2

         fcb   F$Wait
         fdb   FWait-*-2

         fcb   F$Exit
         fdb   FExit-*-2

         fcb   F$Mem
         fdb   FMem-*-2

         fcb   F$Send
         fdb   FSend-*-2

         fcb   F$Sleep
         fdb   FSleep-*-2

         fcb   F$Icpt
         fdb   FIcpt-*-2

         fcb   F$ID
         fdb   FID-*-2

         fcb   F$SPrior
         fdb   FSPrior-*-2

         fcb   F$SSwi
         fdb   FSSwi-*-2

         fcb   F$STime
         fdb   FSTime-*-2

         fcb   F$Find64+$80
         fdb   FFind64-*-2

         fcb   F$All64+$80
         fdb   FAll64-*-2

         fcb   F$Ret64+$80
         fdb   FRet64-*-2

	IFNE UseFDebug
         fcb   F$Debug
         fdb   FDebug-*-2
	ENDC

         fcb   $80

start    equ   *
* install system calls
         leay  SvcTbl,pcr
         os9   F$SSvc
         ldx   <D.PrcDBT
         os9   F$All64
         bcs   fatalerr                 failed to allocate
         stx   <D.PrcDBT
         sty   <D.Proc
         tfr   s,d
         deca
         ldb   #$01
         std   P$ADDR,y
         lda   #SysState
         sta   P$State,y
         ldu   <D.Init

* ChdDir should identify system device, result in a call to IOCall which links and
* initialises IOMan then calls JmpBoot to load and validate the boot file
         bsr   ChdDir                   U = address of init module
         bcc   L006A                    success

* Maybe we failed because we didn't have all the modules we needed? Load and
* validate the boot file and then try again.
         lbsr  JmpBoot
         bsr   ChdDir

L006A    bsr   OpenCons                 U = address of init module, still
         bcc   L0073                    success

* Maybe we were able to get this far without needing anything from the boot file, but now
* we need it for the console device
         lbsr  JmpBoot
         bsr   OpenCons

* Hmm. No check for success. Probably should "bcs fatalerr" here?

L0073    ldd   InitStr,u
         leax  d,u
         lda   #$01
         clrb
         ldy   #$0000
         os9   F$Chain
fatalerr jmp   [$FFFE]

* change directory
* U = address of init module
ChdDir   clrb                           clear carry
         ldd   <SysStr,u		get system device
         beq   ChdDir10			branch if none - carry still clear
         leax  d,u                      address of the path list
         lda   #READ.+EXEC.             access mode
         os9   I$ChgDir			change directory to it
ChdDir10 rts                            carry set -> error

* open console device
* U = address of init module
OpenCons clrb
         ldd   <StdStr,u
         leax  d,u
         lda   #UPDAT.
         os9   I$Open
         bcs   OpenCn10
         ldx   <D.Proc			get process descriptor
         sta   P$Path+0,x		save path to console to stdin...
         os9   I$Dup
         sta   P$Path+1,x		...stdout
         os9   I$Dup
         sta   P$Path+2,x		...and stderr
OpenCn10 rts

FUnlink  ldd   R$U,u			D = ptr to module to unlink
         beq   L00F9
         ldx   <D.ModDir		X = ptr to 1st module dir entry
L00B8    cmpd  MD$MPtr,x	 	module match?
         beq   L00C5			branch if so
         leax  MD$ESize,x		go to next entry
         cmpx  <D.ModDir+2		is this end?
         bcs   L00B8			if not, go check next entry for match
         bra   L00F9			else exit
L00C5    lda   MD$Link,x		get link count
         beq   L00CE			branch if zero
         deca				else decrement by one
         sta   MD$Link,x		and save count
         bne   L00F9			branch if post-dec wasn't zero
* If here, deallocate module
L00CE    ldy   MD$MPtr,x		get module pointer
         cmpy  <D.BTLO			compare against boot lo mem
         bcc   L00F9
         ldb   M$Type,y			get type of module
         cmpb  #FlMgr			is it a file manager?
         bcs   L00E5			branch if not
         os9   F$IODel			determine if I/O module is in use
         bcc   L00E5			branch if not
         inc   MD$Link,x		else cancel out prior dec
         bra   L00FA			and exit call
L00E5    clra
         clrb
         std   MD$MPtr,x		clear out moddir entry's module address
         std   M$ID,y			and destroy module's first 2 bytes
         ldd   M$Size,y			get size of module in D
         lbsr  L0236
         exg   d,y
         exg   a,b
         ldx   <D.FMBM			get free mem bitmap ptr
         os9   F$DelBit			delete the corresponding bits
L00F9    clra
L00FA    rts

FWait    ldy   <D.Proc
         ldx   <D.PrcDBT
         lda   P$CID,y
         bne   L0108
         comb
         ldb   #E$NoChld
         rts
L0108    os9   F$Find64
         lda   P$State,y
         bita  #Dead                   dead?
         bne   L0124                   branch if so
         lda   P$SID,y                 siblings?
         bne   L0108                   branch if so
         clr   R$A,u
         ldx   <D.Proc
         orcc  #FIRQMask+IRQMask
         ldd   <D.WProcQ
         std   P$Queue,x
         stx   <D.WProcQ
         lbra  L034D
L0124    ldx   <D.Proc
L0126    lda   P$ID,y
         ldb   <P$Signal,y
         std   R$A,u
         pshs  u,y,x,a
         leay  P$PID,x
         ldx   <D.PrcDBT
         bra   L0138
L0135    os9   F$Find64
L0138    lda   P$SID,y
         cmpa  ,s
         bne   L0135
         ldu   $03,s
         ldb   R$B,u
         stb   P$SID,y
         os9   F$Ret64
         puls  pc,u,y,x,a

FExit    ldx   <D.Proc
         ldb   R$B,u
         stb   P$Signal,x
         ldb   #NumPaths
         leay  P$PATH,x
L0155    lda   ,y+
         beq   L0160
         pshs  b
         os9   I$Close
         puls  b
L0160    decb
         bne   L0155
         lda   P$ADDR,x
         tfr   d,u
         lda   P$PagCnt,x
         os9   F$SRtMem
         ldu   P$PModul,x
         os9   F$UnLink
         ldu   <D.Proc
         leay  P$PID,u
         ldx   <D.PrcDBT
         bra   L018C
L017A    clr   $02,y
         os9   F$Find64
         lda   P$State,y
         bita  #Dead                   dead?
         beq   L018A                   branch if not
         lda   ,y
         os9   F$Ret64
L018A    clr   P$PID,y
L018C    lda   P$SID,y
         bne   L017A
         ldx   #$0041
         lda   P$PID,u
         bne   L01A4
         ldx   <D.PrcDBT
         lda   P$ID,u
         os9   F$Ret64
         bra   L01C2
L01A0    cmpa  ,x
         beq   L01B2
L01A4    leay  ,x                      Y = proc desc ptr
         ldx   P$Queue,x
         bne   L01A0
         lda   P$State,u
         ora   #Dead
         sta   P$State,u
         bra   L01C2
L01B2    ldd   P$Queue,x
         std   P$Queue,y
         os9   F$AProc
         leay  ,u
         ldu   P$SP,x
         ldu   R$D,u
         lbsr  L0126
L01C2    clra
         clrb
         std   <D.Proc
         rts

FMem     ldx   <D.Proc
         ldd   R$A,u
         beq   L0227
         bsr   L0236
         subb  P$PagCnt,x
         beq   L0227
         bcs   L0207
         tfr   d,y
         ldx   P$ADDR,x
         pshs  u,y,x
         ldb   ,s
         beq   L01E1
         addb  $01,s
L01E1    ldx   <D.FMBM
         ldu   <D.FMBM+2
         os9   F$SchBit
         bcs   L0231
         stb   $02,s
         ldb   ,s
         beq   L01F6
         addb  $01,s
         cmpb  $02,s
         bne   L0231
L01F6    ldb   $02,s
         os9   F$AllBit
         ldd   $02,s
         suba  $01,s
         addb  $01,s
         puls  u,y,x
         ldx   <D.Proc
         bra   L0225

L0207    negb
         tfr   d,y
         negb
         addb  $08,x
         addb  $07,x
         cmpb  $04,x
         bhi   L0217
         comb
         ldb   #E$DelSP
         rts

L0217    ldx   <D.FMBM
         os9   F$DelBit
         tfr   y,d
         negb
         ldx   <D.Proc
         addb  P$PagCnt,x
         lda   P$ADDR,x
L0225    std   P$ADDR,x
L0227    lda   P$PagCnt,x
         clrb
         std   R$D,u
         adda  P$ADDR,x
         std   R$Y,u
         rts
L0231    comb
         ldb   #E$MemFul
         puls  pc,u,y,x

L0236    addd  #$00FF
         clrb
         exg   a,b
         rts

FSend    lda   R$A,u		get process ID of recipient
         bne   L024F		branch if > 0
         inca
L0242    ldx   <D.Proc
         cmpa  P$ID,x
         beq   L024A
         bsr   L024F
L024A    inca
         bne   L0242
         clrb
         rts

L024F    ldx   <D.PrcDBT
         os9   F$Find64
         bcc   L025E
         ldb   #E$IPrcID
         rts

L0259    comb
         ldb   #E$IPrcID
         puls  pc,y,a

* Entry: A = recipient PID
L025E    pshs  y,a
         ldb   R$B,u			get caller regB (signal)
         bne   L0275			branch if not 0
         ldx   <D.Proc			get active process desc
         ldd   P$User,x			get user id
         beq   L026F			branch if super user ID
         cmpd  P$User,y			same as user of recipient process?
         bne   L0259            no, cannot send signal to another users process
L026F    lda   P$State,y		get state of recipient
         ora   #Condem			set condemn bit
         sta   P$State,y		and set it back
L0275    orcc  #FIRQMask+IRQMask
         lda   <P$Signal,y		get recipient pending signal
         beq   L0284			branch if none
         deca					is the pending signal the wake signal?
         beq   L0284			branch if so
         comb					else indicate signal already pending
         ldb   #E$USigP
         puls  pc,y,a

L0284    ldb   R$B,u			get caller regB (signal)
         stb   <P$Signal,y
         ldx   #(D.SProcQ-P$Queue) get pointer to sleeping process queue
         bra   L02B4
L028E    cmpx  $01,s			same as process descriptor of recipient?
         bne   L02B4            branch if not
         lda   P$State,x        else get state of recipient
         bita  #TimSleep        timed sleep?
         beq   L02C7            branch if not
         ldu   P$SP,x           else get recipient stack pointer
         ldd   R$X,u            and X
         beq   L02C7            if X == 0 (sleep forever), then branch
         ldu   P$Queue,x        get queue pointer of recipient
         beq   L02C7            branch if empty
         pshs  b,a
         lda   P$State,u
         bita  #TimSleep
         puls  b,a
         beq   L02C7
         ldu   P$SP,u
         addd  P$SP,u
         std   P$SP,u
         bra   L02C7
L02B4    leay  ,x
         ldx   P$Queue,y
         bne   L028E
         ldx   #(D.WProcQ-P$Queue)
L02BD    leay  ,x
         ldx   P$Queue,y
         beq   L02D7
         cmpx  $01,s
         bne   L02BD
L02C7    ldd   P$Queue,x
         std   P$Queue,y
         lda   <P$Signal,x
         deca
         bne   L02D4
         sta   <P$Signal,x
L02D4    os9   F$AProc
L02D7    clrb
         puls  pc,y,a

* F$Sleep
FSleep   ldx   <D.Proc                 get pdesc
         orcc  #FIRQMask+IRQMask       mask ints
         lda   P$Signal,x              get proc signal
         beq   L02EE                   branch if none
         deca                          dec signal
         bne   L02E9                   branch if not S$Wake
         sta   P$Signal,x              clear signal
L02E9    os9   F$AProc                 insert into activeq
         bra   L034D
L02EE    ldd   R$X,u                   get timeout
         beq   L033A                   branch if forever
         subd  #$0001                  subtract 1
         std   R$X,u                   save back to caller
         beq   L02E9                   branch if give up tslice
         pshs  u,x
         ldx   #(D.SProcQ-P$Queue)
L02FE    leay  ,x
         ldx   P$Queue,x
         beq   L0316
         pshs  b,a
         lda   P$State,x
         bita  #TimSleep
         puls  b,a
         beq   L0316
         ldu   P$SP,x
         subd  R$X,u
         bcc   L02FE
         addd  R$X,u
L0316    puls  u,x
         std   R$X,u
         ldd   P$Queue,y
         stx   P$Queue,y
         std   P$Queue,x
         lda   P$State,x
         ora   #TimSleep
         sta   P$State,x
         ldx   P$Queue,x
         beq   L034D
         lda   P$State,x
         bita  #TimSleep
         beq   L034D
         ldx   P$SP,x
         ldd   P$SP,x
         subd  R$X,u
         std   P$SP,x
         bra   L034D
L033A    lda   P$State,x
         anda  #^TimSleep
         sta   P$State,x
         ldd   #(D.SProcQ-P$Queue)
L0343    tfr   d,y
         ldd   P$Queue,y
         bne   L0343
         stx   P$Queue,y
         std   P$Queue,x
L034D    leay  <L0361,pcr
         pshs  y
         ldy   <D.Proc
         ldd   P$SP,y
         ldx   R$X,u
         IFNE  H6309
         pshs  u,y,x,dp
         pshsw
         pshs  b,a,cc
         ELSE
         pshs  u,y,x,dp,b,a,cc
         ENDC
         sts   P$SP,y
         os9   F$NProc
L0361    std   P$SP,y
         stx   R$X,u
         clrb
         rts

* F$Icpt
FIcpt    ldx   <D.Proc                 get pdesc
         ldd   R$X,u                   get addr of icpt rtn
         std   <P$SigVec,x             store in pdesc
         ldd   R$U,u                   get data ptr
         std   <P$SigDat,x             store in pdesc
         clrb
         rts

* F$SPrior
FSPrior  lda   R$A,u                   get ID
         ldx   <D.PrcDBT               find pdesc
         os9   F$Find64
         bcs   FSPrEx                  branch if can't find
         ldx   <D.Proc                 get pdesc
         ldd   P$User,x                get user ID
         cmpd  P$User,y                same as dest pdesc
         bne   FSPrEx                  branch if not, must be owner
         lda   R$B,u                   else get prior
         sta   P$Prior,y               and store it in dest pdesc
         rts
FSPrEx   comb
         ldb   #E$IPrcID
         rts

* F$ID
FID      ldx   <D.Proc                 get proc desc
         lda   P$ID,x                  get id
         sta   R$A,u                   put in A
         ldd   P$User,x                get user ID
         std   R$Y,u                   store in Y
         clrb
         rts

* F$SSwi
FSSwi    ldx   <D.Proc
         leay  P$SWI,x
         ldb   R$A,u
         decb
         cmpb  #$03
         bcc   FSSwiEx
         lslb
         ldx   R$X,u
         stx   b,y
         rts
FSSwiEx  comb
         ldb   #E$ISWI
         rts

ClkName  fcs   /Clock/

* F$STime
FSTime   ldx   R$X,u
         ldd   ,x
         std   <D.Year
         ldd   2,x
         std   <D.Day
         ldd   4,x
         std   <D.Min
         lda   #Systm+Objct
         leax  <ClkName,pcr
         os9   F$Link
         bcs   L03D2
         jmp   ,y
         clrb
L03D2    rts

* F$Find64
FFind64  lda   R$A,u
         ldx   R$X,u
         bsr   L03DF
         bcs   L03DE
         sty   R$Y,u
L03DE    rts

L03DF    pshs  b,a
         tsta
         beq   L03F3
         clrb
         lsra
         rorb
         lsra
         rorb
         lda   a,x
         tfr   d,y
         beq   L03F3
         tst   ,y
         bne   L03F4
L03F3    coma
L03F4    puls  pc,b,a

* F$All64
FAll64   ldx   R$X,u
         bne   L0402
         bsr   L040C
         bcs   L040B
         stx   ,x
         stx   R$X,u
L0402    bsr   L0422
         bcs   L040B
         sta   R$A,u
         sty   R$Y,u
L040B    rts

L040C    pshs  u
         ldd   #$0100
         os9   F$SRqMem
         leax  ,u
         puls  u
         bcs   L0421
         clra
         clrb
L041C    sta   d,x
         incb
         bne   L041C
L0421    rts

L0422    pshs  u,x
         clra
L0425    pshs  a
         clrb
         lda   a,x
         beq   L0437
         tfr   d,y
         clra
L042F    tst   d,y
         beq   L0439
         addb  #$40
         bcc   L042F
L0437    orcc  #Carry
L0439    leay  d,y
         puls  a
         bcc   L0464
         inca
         cmpa  #$40
         bcs   L0425
         clra
L0445    tst   a,x
         beq   L0453
         inca
         cmpa  #$40
         bcs   L0445
         ldb   #E$PthFul
         coma
         bra   L0471
L0453    pshs  x,a
         bsr   L040C
         bcs   L0473
         leay  ,x
         tfr   x,d
         tfr   a,b
         puls  x,a
         stb   a,x
         clrb
L0464    lslb
         rola
         lslb
         rola
         ldb   #$3F
L046A    clr   b,y
         decb
         bne   L046A
         sta   ,y
L0471    puls  pc,u,x
L0473    leas  3,s
         puls  pc,u,x

* F$Ret64
FRet64   lda   R$A,u
         ldx   R$X,u
         pshs  u,y,x,b,a
         clrb
         lsra
         rorb
         lsra
         rorb
         pshs  a
         lda   a,x
         beq   L04A0
         tfr   d,y
         clr   ,y
         clrb
         tfr   d,u
         clra
Ret64Lp  tst   d,u
         bne   Ret64Ex
         addb  #64
         bne   Ret64Lp
         inca
         os9   F$SRtMem
         lda   ,s
         clr   a,x
L04A0
Ret64Ex  clr   ,s+
         puls  pc,u,y,x,b,a

IOMgr    fcs   /IOMAN/

IOCall   pshs  u,y,x,b,a
         ldu   <D.Init                 get ptr to init
         bsr   LinkIOM                 link to IOMan
         bcc   JmpIOM                  jump into him if ok
         bsr   JmpBoot                 try boot
         bcs   IOCallRt                problem booting... return w/ error
         bsr   LinkIOM                 ok, NOW link to IOMan
         bcs   IOCallRt                still a problem...
JmpIOM   jsr   ,y
         puls  u,y,x,b,a
         ldx   -2,y
         jmp   ,x
IOCAllRt puls  pc,u,y,x,b,a

LinkIOM  leax  IOMgr,pcr
         lda   #Systm+Objct
         os9   F$Link
         rts

* Attempt to load bootfile and validate the modules it contains
*
* Entry:
* U = address of init module
* Exit:
* CC Carry set on Error
JmpBoot  pshs  u
         comb
         tst   <D.Boot                 already booted?
         bne   JmpBtEr                 yep, return to caller...
         inc   <D.Boot                 else set boot flag
         ldd   <BootStr,u              get pointer to boot str
         beq   JmpBtEr                 if none, return to caller
         leax  d,u                     X = ptr to boot mod name
         lda   #Systm+Objct
         os9   F$Link                  link
         bcs   JmpBtEr                 return if error
         jsr   ,y                      ...else jsr into boot module
* D = size of bootfile
* X = address of bootfile
         bcs   JmpBtEr                 return if error
         stx   <D.MLIM
         stx   <D.BTLO
         leau  d,x
         stu   <D.BTHI
* search through bootfile and validate modules
ValBoot  ldd   ,x
         cmpd  #M$ID12
         bne   ValBoot1
         os9   F$VModul
         bcs   ValBoot1
         ldd   M$Size,x
         leax  d,x                     move X to next module
         bra   ValBoot2
ValBoot1 leax  1,x                     advance one byte
ValBoot2 cmpx  <D.BTHI
         bcs   ValBoot
JmpBtEr  puls  pc,u

	IFNE UseFDebug
         use   fdebug.asm
	ENDC

         emod
eom      equ   *
