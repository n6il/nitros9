********************************************************************
* OS9p1 - OS-9 Level Two V3 P1 module
*
* $Id$
*
* Ed.    Comments                                       Who YY/MM/DD
* ------------------------------------------------------------------
* ??     Cleaned up some formatting                     KDM 87/05/15
* ??     Added comments and added new defines           KDM 87/03/31
* 18a    Added time of creation to process descriptor   BRI 88/11/18
* 18b    Added F$AllTsk call error exit to F$Chain      BRI 88/12/05
* 18c    Changed time tag to use F$Time - No ticks      BRI 88/12/08
* 18h    Removed bogus assumptions regarding init       BGP 98/10/05
*        module in order to shrink code size, added
*        check for CRC bit in compabibility byte of
*        init module.
* 18i    Made minor optimizations as per Curtis Boyle's BGP 98/10/10
*        optimization document

         nam   OS9p1
         ttl   OS9 Level Two V3 P1 module

* FastBoot flag turns off module CRC checking during boot
FastBoot equ   1

         ifp1  
         use   defsfile
         endc  

rev      set   $09
edition  set   18

         mod   eom,name,Systm,ReEnt+rev,entry,msiz ++

         org   $0000
msiz     equ   .

name     fcs   "OS9p1"
         fcb   edition

*------------------------------------------------*
*                OS9p1 begins here:
*------------------------------------------------*
entry    ldx   #$100      clear rest of first 8k Block: ++
         ldy   #8192-$100 ++
         clra  
         clrb  
L001C    std   ,x++
         leay  -2,y
         bne   L001C

         inca  
         std   D.Tasks    =$0100 task flags (32)
         addb  #$20       (DAT.TkCt) ++
         std   D.TskIPt   =$0120 temporary images ++

         inca  
         aslb  
         std   D.BlkMap+2 =$0240 end of block map
         clrb  
         std   D.BlkMap   =$0200 mem block map (64)

         inca             ++
         std   D.SysDis   =$0300 sys dispatch table
         inca  
         std   D.UsrDis   =$0400 usr dispatch table
         inca  
         std   D.PrcDBT   =$0500 proc desc pointers
         inca  
         std   D.SysPrc   =$0600 original sys proc
         std   D.Proc     =$0600 original proc
         adda  #P$Size/256 desc
         tfr   d,s        SP=$0800 sys SP within sys desc
         inca  
         std   D.SysStk   =$0900 main sys stack ptr
         std   D.SysMem   =$0900 sys memmap
         inca  
         std   D.ModDir   =$0A00 module dir
         std   D.ModEnd   =$0A00  (grows upward)
         adda  #$06
         std   D.ModDir+2 =$1000 module DAT images
         std   D.ModDAT   =$1000  (grows downward)
         std   D.CCMem    =$1000 CC3IO static memory ++

         asla             d=$2000 GrfDrv stack area ++

         std   D.CCStk    ++

*------------------------------------------------*
         leax  Vectors,pcr put jmp[,x] vectors:
         tfr   x,d
         ldx   #D.SWI3

* used by top 256 to jmp to sys.

L0065    std   ,x++
         cmpx  #D.NMI
         bls   L0065

         leax  >eo,pcr    move secondary vectors
         pshs  x          from end of rom:
         leay  >D.VECTRS,pcr
         ldx   #D.Clock   (Tick-NMI)
L0079    ldd   ,y++       get vector
         addd  ,s         add offset
         std   ,x++       store
         cmpx  #D.XNMI    done?
         bls   L0079      ..no
         leas  2,s        drop offset

         ldx   D.XSWI2    set calls to sys
         stx   D.UsrSvc
         ldx   D.XIRQ     set IRQ to sys
         stx   D.UsrIRQ

         leax  SysCall,pcr set syscall handler
         stx   D.SysSvc
         stx   D.XSWI2

         leax  S.SysIRQ,pcr set sysirq handler
         stx   D.SysIRQ
         stx   D.XIRQ

         leax  >S.SvcIRQ,pcr IRQ svc handler
         stx   D.SvcIRQ
         leax  >S.POLL,pcr default poll 'til IOMan
         stx   D.Poll
         leax  S.AltIRQ,pcr default keyboard till CC3io ++
         stx   D.AltIRQ   ++
         leax  S.Flip0,pcr Grfdrv return vector ++
         stx   D.Flip0    ++
         leax  S.Flip1,pcr GrfDrv exec vector ++
         stx   D.Flip1    ++

         leay  SysCalls,pcr enter os9p1 svc calls:
         lbsr  InstSSvc

*------------------------------------------------*
         ldu   D.PrcDBT   set up first proc desc:
         ldx   D.SysPrc
         stx   0,u        proc table entries
         stx   1,u        zero and one

         lda   #1         sys proc id=01
         sta   P$ID,x
         lda   #SysState  set sys state
         sta   P$State,x
         lda   #SysTask   sys task # ++
         sta   D.SysTsk
         sta   P$Task,x
* optimization below saves one byte
         ldd   #$FFFF     top priority/age
         std   P$Prior,x  store it
*         lda   #$FF
*         sta   P$Prior,x
*         sta   P$Age,x

         leax  P$DATImg,x point sysdat -> sys proc
         stx   D.SysDAT
         clra  
         clrb  
         std   ,x++       first block always sys

* DAT.BlCt-ROMCount-RAMCount:
         ldy   #6         next 6 are unused ++
         ldd   #DAT.Free
L00EF    std   ,x++
         leay  -1,y
         bne   L00EF

         ldd   #IOBlock   last one is Kernel ++
         std   ,x++

         ldx   D.Tasks    first task# is sys's
         inc   0,x
         inc   1,x        Task 1 is GrfDrv ++

*------------------------------------------------*
* set 1st 8K sys mem used
         ldx   D.SysMem
         ldb   D.CCStk    (=$20) ++
L0104    inc   ,x+
         decb  
         bne   L0104

*------------------------------------------------*
* determine size of CoCo's memory (128K/512K)
         clr   D.MemSz    default is 128k ++
         ldd   #$0313     blocks $03 and $13 ++
         std   DAT.Regs+5 map at logical $A000 ++
         ldx   #$A000     point to first block ++
         ldd   #$DC78     get inverted sync bytes ++
         std   ,x         store at start of first block ++
         cmpd  8192,x     in second block too? ++
         beq   L0122      yes, just 128k ++
         inc   D.MemSz    else set 512k flag ++

L0122    ldy   #$2000     point to second block in map ++
         ldx   D.BlkMap   X=$0200

* Check Memory Blocks Loop:

L0128    pshs  x          save current map pointer
         ldd   ,s         D=map ptr
         subd  D.BlkMap   D=block number
         cmpb  #IOBlock   is it sys?
         bne   L0136      ..no, test for 512k ++
         ldb   #RAMinUse  load marker ++
         bra   L015B      go set in map ++

L0136    lda   D.MemSz    512k memory? ++
         bne   L013E      yes, continue ++
         cmpb  #$0F       end of 128k mem? ++
         bhs   L0159      yes, set notram ++

L013E    stb   >DAT.Regs+1 set block at $2000 for test ++
         ldu   ,y         get two bytes
         ldx   #$00FF     store test bytes
         stx   ,y
         cmpx  ,y         same on read
         bne   L0159      ..end if no mem here

         ldx   #$FF00     make sure again
         stx   ,y
         cmpx  ,y
         bne   L0159      ..bad mem
         stu   ,y         restore original bytes
         bra   L015D      do next

* End of Memory:

L0159    ldb   #NotRAM    set non-mem flag

L015B    stb   [,s]       store at ,X in table ++

L015D    puls  x          get current map pointer
         leax  1,x        next block
         cmpx  D.BlkMap+2 end of map?
         blo   L0128      ..no, keep trying

*------------------------------------------------*
* Search For ROM Modules:

         ldx   D.BlkMap   X=map strt (X=$0200)
         inc   ,x         mark as RAMinUse
         ldx   D.BlkMap+2 start at end of map (X=$0240)

         leax  -1,x       back up 1 (X=$023F)

*------------------------------------------------*
         tfr   x,d        else D=block number (D=$023F)
         subd  D.BlkMap   make into block number (D=$003F)

         pshs  d          save block number
         leay  ,s         Y = var pointer for routine below

         ldx   #$0D00     offset in block ++

*------------------------------------------------*
* Check Block for Modules Loop:

L017F    pshs  x,y
         lbsr  L0AF0      set up Y for X offset
         ldb   1,y        B=block# from image
         stb   >DAT.Regs  map into sys zero
         lda   ,x         get byte from block
         clr   >DAT.Regs  back to sys
         puls  x,y
         cmpa  #M$ID1     module?
         bne   L01A7

         lbsr  L0463      do verify
         bcc   L019D
         cmpb  #E$KwnMod  'Known Module'?
         bne   L01A7      ..no, continue
L019D    ldd   #M$Size    else get mod size
         lbsr  lddxy
         leax  d,x        skip over it
         bra   L01A9

* Not Known Module:

L01A7    leax  1,x        byte ptr+1

L01A9    cmpx  #$1E00     don't overrun vector page! ++
         blo   L017F      ok to continue ++
         bsr   L01D2      setup system mem map ++

*------------------------------------------------*
* OS9p1 init finished:

L01B0    os9   F$Boot     boot!
         bcs   Crash      crash if problem
         leax  InitMod,pcr 'Init'
         bsr   LinkSys    link to it
         bcs   Crash      crash if error
L01BF    stu   D.Init     save Init ptr
L01C1    leax  OS9p2Nm,pcr 'OS9p2'
         bsr   LinkSys    link to it
         bcs   Crash      crash if not found...
L01D0    jmp   ,y         ...else do OS9p2...
Crash    jmp   D.Crash    report boot failed

* Setup system memory map.

L01D2    ldx   D.SysMem   point to map ++
         leax  $ED00/256,x kernel offset in map ++
         lda   #NotRam    mark IOPage ++
         sta   18,x       as Not RAM ++
         ldb   #$12       18 pages in kernel ++

L01DF    lda   #RAMinUse  mark kernel ++

L01E1    sta   ,x+        RAM as in use ++
         decb             all done ++
         bne   L01E1      no, continue
         ldx   D.BlkMap+2 end of map++
         sta   -1,x       mark block #3F ++
         rts              exit ++

* Link to Module (X = ptr to mod name):
LinkSys  lda   #Systm     system module
         os9   F$Link     try to find it
         rts   

*------------------------------------------------*
*              System Service Calls
*------------------------------------------------*
SysCalls fcb   F$Link
         fdb   FLink-*-2
         fcb   F$PrsNam
         fdb   FPrsNam-*-2
         fcb   F$CmpNam
         fdb   FCmpNam-*-2
         fcb   F$CmpNam+$80 (sys)
         fdb   SCmpNam-*-2
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
         fcb   F$SLink+$80
         fdb   FSLink-*-2
         fcb   F$Boot+$80
         fdb   FBoot-*-2
         fcb   F$BtMem+$80
         fdb   FBtMem-*-2
         fcb   F$Move+$80
         fdb   FMove-*-2
         fcb   F$AllRam
         fdb   FAllRam-*-2
         fcb   F$AllImg+$80
         fdb   FAllImg-*-2
         fcb   F$SetImg+$80
         fdb   FSetImg-*-2
         fcb   F$FreeLB+$80
         fdb   FFreeLB-*-2
         fcb   F$FreeHB+$80
         fdb   FFreeHB-*-2
         fcb   F$AllTsk+$80
         fdb   FAllTsk-*-2
         fcb   F$DelTsk+$80
         fdb   FDelTsk-*-2
         fcb   F$SetTsk+$80
         fdb   FSetTsk-*-2
         fcb   F$ResTsk+$80
         fdb   FResTsk-*-2
         fcb   F$RelTsk+$80
         fdb   FRelTsk-*-2
         fcb   F$DATLog+$80
         fdb   FDATLog-*-2
         fcb   F$LDAXY+$80
         fdb   FLDAXY-*-2
         fcb   F$LDDDXY+$80
         fdb   FLDDDXY-*-2
         fcb   F$LDABX+$80
         fdb   FLDABX-*-2
         fcb   F$STABX+$80
         fdb   FSTABX-*-2
         fcb   F$ELink+$80
         fdb   FELink-*-2
         fcb   F$FModul+$80
         fdb   FFModul-*-2
         fcb   F$AlHRam+$80 new call ++
         fdb   FAlHRam-*-2 for CoCo3 ++
         fcb   $80        End of Table

*------------------------------------------------*
InitMod  fcs   "Init"
OS9p2Nm  fcs   "OS9p2"
BootMod  fcs   "Boot"

*------------------------------------------------*
Vectors  jmp   [-16,x]    goto irq routine

*------------------------------------------------*
*             User State SWI Vectors:
*------------------------------------------------*

XSWI3    ldx   D.Proc     proc desc
         ldu   P$SWI3,x   diff swi3 vector?
         beq   L028E      ..no, do normal

L027B    lbra  L0E5E      else do usr call.

XSWI2    ldx   D.Proc     X=proc desc
         ldu   P$SWI2,x   swi2 svc ptr
         beq   L028E      ..zero, do normal
         bra   L027B      else do usr map

XSWI     ldx   D.Proc     proc desc
         ldu   P$SWI,x    swi ptr
         bne   L027B      ..do user, else:

*------------------------------------------------*
* System SWI calls: (X=pd, U=svc)

L028E    ldd   D.SysSvc   set system state:
         std   D.XSWI2
         ldd   D.SysIRQ
         std   D.XIRQ
         lda   P$State,x
         ora   #SysState
         sta   P$State,x

         sts   P$SP,x     and save user stack
         leas  P$Stack-R$Size,x get local sys stack
         andcc  #^IntMasks okay interrupts
         leau  ,s         U=sys reg stack
         bsr   L02CB      copy user stack here

         ldb   P$Task,x   B=task#
         ldx   R$PC,u     X=PC ptr
         lbsr  FLDBBX     get call byte from user map ++
         leax  1,x        increment PC
         stx   R$PC,u     past call

         ldy   D.UsrDis   Y=user dispatch table
         lbsr  L033B      do the call
         ldb   R$CC,u     okay interrupts
         andb  #^IntMasks on return
         stb   R$CC,u     to user map

         ldx   D.Proc
         bsr   L02DA      copy back new user stack
         lda   P$State,x  drop sys state
         anda  #^SysState
         lbra  L0D7C      and return to user.

*------------------------------------------------*
* Get Caller's Regs:

L02CB    pshs  cc,x,y,u   ++
         ldb   P$Task,x   A=user tsk# ++
         ldx   P$SP,x     X=from user stack
         lbsr  L0BF5      get offset in 8k space ++
         leax  $A000,x    +$A000 =logical address ++
         bra   L02E9      get regs & rts.

* Return Regs to Caller:

L02DA    pshs  cc,x,y,u   save state ++
         ldb   P$Task,x   B=user tsk#
         ldx   P$SP,x     X=to user stack
         lbsr  L0BF5      get offset in 8k space ++
         leax  $A000,x    +$A000 =logical address ++
         exg   x,u        U=user, X=sys

* move caller stack -->

L02E9    pshs  u          save U ++
         lbsr  L0C09      get DAT image pointer in U ++
         leau  a,u        point to block # in image ++
         leau  1,u        point to LSB ++
*         lda   ,u++       first block # in A ++ --BGP
*         ldb   ,u         second block # in B ++ --BGP
         lda   ,u         first block # in A ++ ++BGP
         ldb   2,u        second block # in B ++ ++BGP
         ldu   #DAT.Regs+5 $A000 logical ++
         orcc  #IntMasks  mask interrupts ++
         std   ,u         set DAT ++
         puls  u          recover U ++
         ldy   #R$SIZE    register stack size ++

L0303    ldd   ,x++       move them ++
         std   ,u++       ++
         leay  -2,y       done yet? ++
         bne   L0303      no, continue ++
         ldx   D.SysDAT   system DAT image ++
         lda   11,x       get real ++
         ldb   13,x       system blocks ++
         std   DAT.Regs+5 and restore system map ++
         puls  cc,x,y,u,pc clean up and rts ++

*------------------------------------------------*
*                Sys State OS Call:
*------------------------------------------------*
SysCall  leau  ,s         U=reg stack
         lda   D.SSTskN   get task image ++
         clr   D.SSTskN   set to system ++
         pshs  a          save old task # ++
         lda   R$CC,u
         tfr   a,cc       set CC=user CC
         ldx   R$PC,u     get call
         ldb   ,s         is task sys? ++
         beq   L032F      yes ++
         lbsr  FLDBBX     get call from user space ++
         leax  1,x        point past it ++
         bra   L0331      set as PC ++

L032F    ldb   ,x+        and increment PC

L0331    stx   R$PC,u     past it
         ldy   D.SysDis   Y=system dispatch table
         bsr   L033B      do the call
         lbra  L0E2B      end

*------------------------------------------------*
* Do Svc Call(B), Y=table:

L033B    aslb             index
         bcc   L0345      ..okay if not I/O

* count I$ calls for current process (D.Proc)
         pshs  b          save index into table
         ldb   #P$ICalls  set up I$ counter
         bsr   IncCount   go do it... (X is altered)
         puls  b          recover index

         rorb             else reset B
         ldx   $00FE,y    else X=IOMan vector
         bra   L034F      and do it.

* count User Ticks, System Ticks, F$ calls, or I$ calls
* for current process (D.Proc)  BRI
IncCount ldx   <D.Proc    get pointer to current proc desc
         beq   IncExit    no current proc, go return
         abx              add offset to appropriate counter
         inc   3,x        4 byte counter LSB
         bne   IncExit    no overflow, go return
         inc   2,x        4 byte counter lower middle byte
         bne   IncExit    no overflow, go return
         inc   1,x        4 byte counter upper middle byte
         bne   IncExit    no overflow, go return
         inc   ,x         4 byte counter MSB (ignore overflow)
IncExit  rts   

* (not I/O call)

L0345    pshs  b          save index into table
         ldb   #P$FCalls  set up F$ counter
         bsr   IncCount   go do it... (X is altered)
         puls  b          recover index

         clra             A=00
         ldx   d,y        X=vector from table
         bne   L034F      ..ok if one
         comb             else
         ldb   #E$UnkSvc  'Unknown Service Call'
         bra   L0355      bad end: return err

*------------------------------------------------*
* Do Call Vector (X)

L034F    pshs  u          save reg ptr
         jsr   ,x         do the call
         puls  u          retrieve reg ptr

L0355    tfr   cc,a       A=svc call CC
         bcc   L035B      ..skip if no err
         stb   R$B,u      else return err in reg.B
L035B    ldb   R$CC,u     drop lsb nibble
         andb  #(Entire!IntMasks)
         stb   R$CC,u
         anda  #^(Entire!IntMasks) put in call's CC lsnibble
         ora   R$CC,u
         sta   R$CC,u
         rts              end service call.


*------------------------------------------------*
*                    F$SSvc
*------------------------------------------------*
FSSvc    ldy   R$Y,u      Y=table address
         bra   InstSSvc   do check first...

* SSvc Loop:

L036D    clra             A=00
         aslb             B=table index (set C if >=$80)
         tfr   d,u        U=index
         ldd   ,y++       D=new call vector offset
         leax  d,y        X=actual vector
         ldd   D.SysDis   D=sys dispatch table
         stx   d,u        store new call vector
         bcs   InstSSvc   ..skip if sys only
         ldd   D.UsrDis   else put in user
         stx   d,u        dispatch table also.

*  End of Table Check:

InstSSvc ldb   ,y+        get next call
         cmpb  #$80       is it end-of-table?
         bne   L036D      ..no
         rts              yes, end.


*------------------------------------------------*
*                    F$SLink
*------------------------------------------------*
* Link modules into map.
* A=type,X=name,Y=DAT image ptr
FSLink   ldy   R$Y,u      get DAT image ptr
         bra   SLink


*------------------------------------------------*
*                    F$ELink
*------------------------------------------------*
FELink   pshs  u
         ldb   R$B,u      type
         ldx   R$X,u      name of module
         bra   L03AF      go link it


*------------------------------------------------*
*                    F$Link
*------------------------------------------------*
FLink    ldx   D.Proc     proc desc
         leay  P$DATImg,x Y=DAT image ptr

*------------------------------------------------*
SLink    pshs  u          save reg ptr
         ldx   R$X,u      X=module name
         lda   R$A,u      A=module type
         lbsr  L068D      search moddir

         bcs   L041E      ..err

         leay  ,u         Y=moddir entry
         ldu   ,s         get back reg ptr
         stx   R$X,u      return X
         std   R$D,u      return type/lang
         leax  ,y         X=moddir entry

L03AF    bitb  #ReEnt     is it shareable?
         bne   L03BB      ..yes
         ldd   MD$Link,x  any links?
         beq   L03BB      ..no:ok, else
         ldb   #E$ModBsy  'Module Busy' err
         bra   L041E      bad end.

L03BB    ldd   MD$MPtr,x  D=module ptr
         pshs  a,b,x      save ptr,entry
         ldy   MD$MPDAT,x Y=DAT img for module
         ldd   MD$MBSiz,x D=mem block size
         addd  #$1FFF     round up A ++
         tfr   a,b        to 8K block ++
         lsrb             B/32
         lsrb  
         lsrb  
         lsrb  
         lsrb             ++
         adda  #2         (A+2)/32 ++
         lsra  
         lsra  
         lsra  
         lsra  
         lsra             ++
         pshs  a          save blocks needed
         leau  ,y         U=moddir entry
         bsr   L0422      find it in callers map?
         bcc   L03EB      ..yes

         lda   ,s         blocks needed
         lbsr  L0A33      room to map in?
         bcc   L03E8      ..okay
         leas  5,s        else drop junk
         bra   L041E      bad end.

L03E8    lbsr  L0A8C      set DAT image
L03EB    leax  P$Links,x  link cnt tble
         sta   ,s         save block #
         asla             index
         leau  a,x        U=link ptr
         ldx   ,u         increment link cnt:
         leax  1,x
         beq   L03FC
         stx   ,u
L03FC    ldu   3,s        U=moddir entry
         ldx   MD$Link,u  increment link cnt:
         leax  1,x
         beq   L0406
         stx   MD$Link,u
L0406    puls  b,x,y,u
         lbsr  L0AB0      dattolog
         stx   R$U,u      return module addrss
         ldx   MD$MPtr,y  mod ptr
         ldy   MD$MPDAT,y DAT image ptr
         ldd   #M$Exec    get exec offset
         lbsr  LDDXY
         addd  R$U,u      plus mod addrss
         std   R$Y,u      = exec address
         clrb             okay
         rts              end.

L041E    orcc  #Carry     set error
         puls  u,pc

*------------------------------------------------*
*    See if moddir image in proc map already:
*------------------------------------------------*

* B=block img #, U=moddir ptr

L0422    ldx   D.Proc     proc desc
         leay  P$DATImg,x Y=DAT image ptr
         clra             A=00
         pshs  a,b,x,y    save #,proc,img
         subb  #DAT.BlCt
         negb  
         aslb             index
         leay  b,y

* Image Compare Loop:

L0430    ldx   ,s         X=block cnt
         pshs  y,u
L0434    ldd   ,y++       does proc img
         cmpd  ,u++       match mod image?
         bne   L0449      ..no
         leax  -1,x       yes, cnt-1
         bne   L0434      ..done?

         puls  a,b,u      D=start ptr
         subd  4,s        -block cnt = offset
         lsrb             B/2 index
         stb   ,s         save block #
         clrb             okay
         puls  a,b,x,y,pc rts.

L0449    puls  y,u        Y=start ptr
         leay  -2,y       back up one img
         cmpy  4,s        too far?
         bcc   L0430      ..no, try again
         puls  a,b,x,y,pc error end.


*------------------------------------------------*
*                    F$VModul
*------------------------------------------------*
FVModul  pshs  u
         ldx   R$X,u      X=mod offset
         ldy   R$D,u      Y=DAT img ptr
         bsr   L0463      do the verify
         ldx   ,s
         stu   R$U,x      return moddir ptr
         puls  u,pc

L0463    pshs  x,y
         lbsr  L0586      check module crc
         bcs   L0493      ..err

         ldd   #M$Type
         lbsr  LDDXY      get type/rev bytes
         andb  #$0F       save rev
         pshs  a,b

         ldd   #M$Name    get name offset
         lbsr  LDDXY
         leax  d,x        X points to mod name
         puls  a
         lbsr  L068D
         puls  a
         bcs   L0497

         pshs  a
         andb  #$0F
         subb  ,s+
         bcs   L0497
         ldb   #E$KwnMod  'Known Module'
         bra   L0493

L0491    ldb   #E$DirFul  'Module Dir Full'
L0493    orcc  #Carry
         puls  x,y,pc

*------------------------------------------------*
L0497    ldx   ,s         X=module addrss
         lbsr  L0524
         bcs   L0491
         sty   MD$MPDAT,u insert DAT image ptr
         stx   MD$MPtr,u  and module ptr
         clra  
         clrb  
         std   MD$Link,u  link count=00
         ldd   #M$Size
         lbsr  LDDXY      get module size
         pshs  x          mod addrss
         addd  ,s++       plus size
         std   MD$MBSiz,u
         ldy   [MD$MPDAT,u] Y=mod images
         ldx   D.ModDir   X=mod dir strt
         pshs  u          save entry
         bra   L04BE

L04BC    leax  MD$ESize,x next moddir entry
L04BE    cmpx  D.ModEnd   last one?
         bcc   L04CD      ..yes, end
         cmpx  ,s         same entry?
         beq   L04BC      ..yes, try again
         cmpy  [,x]       same image ptr?
         bne   L04BC      ..no, try again
         bsr   L04F2

*------------------------------------------------*
* Mark BlockMaps as Modules:

L04CD    puls  u          U=dir entry
         ldx   D.BlkMap   X=mem block map
         ldd   MD$MBSiz,u D=mod block size
         addd  #$1FFF     round up size ++
         lsra             A/32 = number of blocks
         lsra             (8K)
         lsra  
         lsra  
         lsra             ++
         ldy   MD$MPDAT,u Y=mod dat image

L04DE    pshs  a,x        save block size, blkmap
         ldd   ,y++       D=image block#
         leax  d,x        X=blkmap ptr
         ldb   ,x         get block marker
         orb   #ModBlock  set module in block
         stb   ,x         marker
         puls  a,x        ..
         deca             count-1
         bne   L04DE      ..mark all blocks

         clrb             okay
         puls  x,y,pc     end.

*------------------------------------------------*
* Clear entries:

L04F2    pshs  a,b,x,y,u
         ldx   ,x
         pshs  x
         clra             D=0000
         clrb  
L04FA    ldy   ,x         last entry?
         beq   L0503      ..yes
         std   ,x++       no, clear
         bra   L04FA      and loop

L0503    puls  x
         ldy   2,s
         ldu   MD$MPDAT,u U=mod images
         puls  a,b

L050C    cmpx  ,y         same image?
         bne   L051B      ..no, try next
         stu   MD$MPDAT,y yes, set new image
         cmpd  MD$MBSiz,y new size bigger?
         bcc   L0519      ..yes, use it
         ldd   MD$MBSiz,y else use old size
L0519    std   MD$MBSiz,y set modblock size
L051B    leay  MD$ESize,y next entry
         cmpy  D.ModEnd   last?
         bne   L050C      ..no
         puls  x,y,u,pc   end.

*------------------------------------------------*
L0524    pshs  x,y,u      save mod adrs,img,
         ldd   #M$Size    get module size
         lbsr  LDDXY
         addd  ,s         end = begin+size
         addd  #$1FFF     round to block ++
         lsra             A/32
         lsra  
         lsra  
         lsra  
         lsra             ++,
         tfr   a,b        A,B=number of blocks
         pshs  b          save num
         incb  
         aslb  
         negb  
         sex              sign extend into D
         bsr   L054E      make new dir entry
         bcc   L054C      ..okay rts

         os9   F$GCMDir   else get task#
         ldu   #$0000     set flag
         stu   5,s
         bsr   L054E      make new dir entry
L054C    puls  b,x,y,u,pc rts.

*------------------------------------------------*
* Allocate module dir image:

L054E    ldx   D.ModDAT   X+D = mod DAT img pointer
         leax  d,x
         cmpx  D.ModEnd   would it be below last dir?
         bcs   L0583      ..yes, err

         ldu   7,s        get back old U
         bne   L056E      ..
         pshs  x          save new moddat ptr
         ldy   D.ModEnd   Y=end of dir
         leay  MD$ESize,y plus new entry
         cmpy  ,s++       collide with moddat?
         bhi   L0583      ..yes, err

         sty   D.ModEnd   store new dir end
         leay  -MD$ESize,y Y=new dir entry ptr
         sty   7,s        return it to caller
L056E    stx   D.ModDAT   store new moddat ptr
         ldy   5,s
         ldb   2,s        B=block count
         stx   5,s        return dir datimg ptr

L0577    ldu   ,y++       copy images
         stu   ,x++       to new mod dat entry
         decb  
         bne   L0577

         clr   ,x         zero flag
         clr   1,x
         rts              end.

L0583    orcc  #Carry     set err flag
         rts              end.


*------------------------------------------------*
*             Calculate CRC of Module:
*------------------------------------------------*

L0586    pshs  x,y
         clra             D=offset of zero
         clrb  
         lbsr  LDDXY      get 2 bytes
         cmpd  #M$ID12    is it module?
         beq   L0597      ..yes
         ldb   #E$BMID    'Bad Module Header'
         bra   L05F3      ..err end.

* Check Module Header:

L0597    leas  -1,s       make var
         leax  2,x        X=past sync bytes
         lbsr  L0AF0      set Y for X offset
         ldb   #$07       seven bytes
         lda   #$4A       header crc
L05A2    sta   ,s         save crc
         lbsr  LDAXY      get next byte
         eora  ,s         do crc
         decb             more?
         bne   L05A2      ..loop

         leas  1,s        drop var
         inca             $FF+1 = 00
         beq   L05B5      ..okay header
         ldb   #E$BMHP    'Bad Module Header'
         bra   L05F3      err end.

*------------------------------------------------*
* Do CRC across module:
*
* Added code to check init module for CRC check flag
L05B5          
         ldx   D.Init     get Init module addr ++ BGP

* Here the FastBoot definition says that if the INIT module cannot
* be found (as is the case when OS9p1 brings up the rest of the
* system with F$Boot), then don't do CRC checking.  Note that
* module header checking above is still performed in this case.
         ifeq  FastBoot
         beq   L05CX      if none, do CRC checking ++ BGP
         else  
         beq   NOCRC      if none, DON'T DO CRC checking ++ BGP
         endc  

         lda   Feature1,x get compat1 byte ++BGP
         bita  #CRCOn     test CRCOn bit ++BGP
         bne   L05CX      if set, check CRC ++BGP
NOCRC    clra             else clra ++BGP
         clrb             and clrb ++BGP
         bra   L05F5      branch to end of routine ++BGP
L05CX    puls  x,y
         ldd   #$0002
         lbsr  LDDXY
         pshs  a,b,x,y
         ldd   #$FFFF     set temp CRC register
         pshs  a,b
         pshs  b
         lbsr  L0AF0      set up Y for X offset
         leau  ,s
L05CB    tstb  
         bne   L05D8
         pshs  x
         ldx   #$0001
         os9   F$Sleep
         puls  x
L05D8    lbsr  LDAXY      get a byte
         bsr   CRCCalc    pass it through the CRC calculator
         ldd   3,s
         subd  #$0001
         std   3,s
         bne   L05CB
         puls  b,x,y
         cmpb  #$80
         bne   L05F1
         cmpx  #$0FE3
         beq   L05F5
L05F1    ldb   #E$BMCRC   'Bad Module CRC'
L05F3    orcc  #Carry
L05F5    puls  x,y,pc

*------------------------------------------------*
*                  CRC Calculator:
*------------------------------------------------*

* A  = byte to be passed through accumulator
CRCCalc  eora  ,u
         pshs  a
         ldd   1,u
         std   ,u
         clra  
         ldb   ,s
         aslb  
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
         asla  
         eora  ,s
         sta   ,s
         asla  
         asla  
         eora  ,s
         sta   ,s
         asla  
         asla  
         asla  
         asla  
         eora  ,s+
         bpl   L0635
         ldd   #$8021
         eora  ,u
         sta   ,u
         eorb  2,u
         stb   2,u
L0635    rts   

*------------------------------------------------*
*                    F$CRC
*------------------------------------------------*
FCRC     ldd   R$Y,u      get byte count
         beq   L0677      ..zero
         ldx   R$X,u      begin ptr
         pshs  a,b,x
         leas  -3,s
         ldx   D.Proc
         lda   P$Task,x
         ldb   D.SysTsk
         ldx   R$U,u
         ldy   #$0003
         leau  ,s
         pshs  a,b,x,y
         lbsr  L0B2C
         ldx   D.Proc
         leay  P$DATImg,x
         ldx   11,s
         lbsr  L0AF0
L065D    lbsr  LDAXY
         bsr   CRCCalc    pass byte through CRC calculator
         ldd   9,s
         subd  #$0001
         std   9,s
         bne   L065D
         puls  a,b,x,y
         exg   a,b
         exg   x,u
         lbsr  L0B2C
         leas  7,s
L0677    clrb  
         rts   

*------------------------------------------------*
*                    F$FModul
*------------------------------------------------*
* Find the Module named (X) with type (A) in Y
FFModul  pshs  u
         lda   R$A,u      A=type request
         ldx   R$X,u      X=name
         ldy   R$Y,u      Y=DAT image ptr
         bsr   L068D      find it
         puls  y
         std   R$D,y      return type/attr
         stx   R$X,y      updated name ptr
         stu   R$U,y      module offset
         rts   

L068D    ldu   #$0000     address flag
         pshs  a,b,u
         bsr   L0712      get first char
         cmpa  #PDELIM    start with pathlist delimiter?
         beq   L070B      ..bad name error
         lbsr  L0741
         bcs   L070E
         ldu   D.ModEnd   U=mod end ++
         bra   L0700

*------------------------------------------------*
* Main Loop:

L06A1    pshs  a,b,x,y
         pshs  x,y
         ldy   MD$MPDAT,u Y=mod images
         beq   L06F6
         ldx   MD$MPtr,u  X=mod ptr
         pshs  x,y
         ldd   #M$Name    get mod name
         lbsr  LDDXY      offset
         leax  d,x        X=name address
         pshs  x,y        save add,images
         leax  8,s
         ldb   13,s
         leay  ,s
         lbsr  L07DE
         leas  4,s
         puls  x,y
         leas  4,s
         bcs   L06FE
         ldd   #M$Type    get mod type/lang
         lbsr  LDDXY
         sta   ,s
         stb   7,s
         lda   6,s
         beq   L06ED
         anda  #$F0
         beq   L06E1
         eora  ,s
         anda  #$F0
         bne   L06FE
L06E1    lda   6,s
         anda  #$0F
         beq   L06ED
         eora  ,s
         anda  #$0F
         bne   L06FE
L06ED    puls  a,b,x,y
         abx   
         clrb  
         ldb   1,s
         leas  4,s
         rts   

*------------------------------------------------*
L06F6    leas  4,s
         ldd   8,s
         bne   L06FE
         stu   8,s
L06FE    puls  a,b,x,y

* Moved back one ++

L0700    leau  -MD$ESize,u next dir entry ++
         cmpu  D.ModDir   last one? ++
         bcc   L06A1      ..no, loop ++

*------------------------------------------------*
         ldb   #E$MNF     'Module Not Found'
         bra   L070E

L070B    comb  
         ldb   #E$BNam    'Bad Name' error
L070E    stb   1,s        return err code
         puls  a,b,u,pc

*------------------------------------------------*
* Get Module Name:

L0712    pshs  y          save image strt
L0714    lbsr  L0AF0      point X to name in img(Y)
         lbsr  L0AC8      get char
         leax  1,x        ptr+1
         cmpa  #C$SPAC    was char space?
         beq   L0714      ..yes, skip

         leax  -1,x       ptr-1
         pshs  a          save char
         tfr   y,d        D=image ptr
         subd  1,s        -images start
         asrb             block#=image/2
         lbsr  L0AB0      ??
         puls  a,y,pc     rts.


*------------------------------------------------*
*                    F$PrsNam
*------------------------------------------------*
FPrsNam  ldx   D.Proc     proc desc
         leay  P$DATImg,x Y=DAT image ptr
         ldx   R$X,u      X=name string
         bsr   L0741      get it and length
         std   R$D,u      return length in D
         bcs   L073E      ..err
         stx   R$X,u      and X at name begin
         abx              plus len
L073E    stx   R$Y,u      return Y=end of name ptr
         rts              end.

* Parse Name:

L0741    pshs  y          save image ptr
         lbsr  L0AF0      find map block
         pshs  x,y        save X offset within block and Y block pointer
         lbsr  LDAXY      get A=byte(X)
         cmpa  #PDELIM    is it a pathlist delimiter?
         bne   L0756      ..no, go keep X offset and block Y
         leas  4,s
         pshs  x,y
         lbsr  LDAXY      get next char
L0756    bsr   L07A1      go check if valid first character...
         bcs   L076A      not valid, go get next name start offset in X...
         clrb             initialize character counter 
L075B    incb             incb add one character
         tsta             last character in name string?
         bmi   L0766      yes, go return valid...
         lbsr  LDAXY      go get next character...
         bsr   L078A      go check if valid character...
         bcc   L075B      valid, go check if last character...
L0766    andcc  #^Carry
         bra   L077C

*------------------------------------------------*
L076A    cmpa  #C$COMA    comma?
         bne   L0775      no, check for next character
L076E    leas  4,s
         pshs  x,y
         lbsr  LDAXY
L0775    cmpa  #C$SPAC    is it a space?
         beq   L076E      ..yes, go get next character
         comb             error, set Carry
         ldb   #E$BNam    'Bad Name' error
L077C    puls  x,y        recover offset and pointer
         pshs  cc,a,b     save Carry, character and count or error code
         tfr   y,d        copy DAT image block pointer
         subd  3,s        subtract original DAT image pointer
         asrb             convert 2 byte/block count to block number
         lbsr  L0AB0      go get true map offset in X...
         puls  cc,a,b,y,pc recover registers and return...

L078A    pshs  a          save character
         anda  #$7F       drop msbit
         cmpa  #PDIR      period?
         beq   ValidChr   yes, go return valid character...
         cmpa  #'0        is it control?
         bcs   InvalChr   ..yes
         cmpa  #'9        is it number?
         bls   ValidChr   ..yes
         cmpa  #'_        is it '_'?
         bne   L07A5      ..no
ValidChr clra             clear carry
         puls  a,pc       recover original character and return

*----------------------------------------------
L07A1    pshs  a
         anda  #$7F       drop msbit
L07A5    cmpa  #'A        less than "A"?
         bcs   InvalChr   yes, go return invalid character...
         cmpa  #'Z        less than or equal to "Z"?
         bls   ValidChr   yes, go return valid character
         cmpa  #'a        less than "a"?
         bcs   InvalChr   yes, go return invalid character
         cmpa  #'z        less than or equal to "z"?
         bls   ValidChr   yes, go return valid character
InvalChr coma  
         puls  a,pc


*------------------------------------------------*
*                    F$CmpNam
*------------------------------------------------*
FCmpNam  ldx   D.Proc     proc desc
         leay  P$DATImg,x Y=caller DAT image ptr
         ldx   R$X,u      X=first name
         pshs  x,y        save name,img
         bra   L07CF      do it


*------------------------------------------------*
*                 F$CmpNam (sys)
*------------------------------------------------*
SCmpNam  ldx   D.Proc     proc desc
         leay  P$DATImg,x Y=images
         ldx   R$X,u      X=first name
         pshs  x,y        save name,imgs
         ldy   D.SysDAT   Y=system DAT image ptr

L07CF    ldx   R$Y,u      X=second name
         pshs  x,y        save name2,sysimg
         ldd   R$D,u      D=match length
         leax  4,s        [X]=name1
         leay  ,s         [Y]=name2
         bsr   L07DE      compare them
         leas  8,s        drop vars
         rts              end.

* Compare two strings:

L07DE    pshs  a,b,x,y,u  length,name1,name2,regs
         ldu   2,s        U=name1 ptr
         pulu  x,y        get name,images
         lbsr  L0AF0      set X for img(Y)
         pshu  x,y        save name1 offsets
         ldu   4,s
         pulu  x,y
         lbsr  L0AF0
         bra   L07F6

L07F2    ldu   4,s
         pulu  x,y
L07F6    lbsr  LDAXY      get name2 char
         pshu  x,y
         pshs  a          save char
         ldu   3,s
         pulu  x,y
         lbsr  LDAXY      get name1 char
         pshu  x,y
         eora  ,s         compare chars
         tst   ,s+        check result
         bmi   L0816      ..msb diff
         decb             len-1
         beq   L0813      last?
         anda  #$DF
         beq   L07F2      do next char

L0813    comb             err
         puls  a,b,x,y,u,pc end.

L0816    decb             len-1
         bne   L0813      ..err if >0
         anda  #$5F
         bne   L0813
         clrb             okay
         puls  a,b,x,y,u,pc end.


*------------------------------------------------*
*               F$SRqMem / F$BtMem
*------------------------------------------------*
FSRqMem        
FBtMem   ldd   R$D,u      get # bytes wanted
         addd  #$00FF     round up
         clrb             to page
         std   R$D,u      return it
         ldy   D.SysMem   Y=system mem map
         leas  -2,s
         stb   ,s
L082F    ldx   D.SysDAT   X=system DAT image
         aslb             index block
         ldd   b,x        D=DAT marker
         cmpd  #DAT.Free  is it free?
         beq   L0847      ..yes
         ldx   D.BlkMap   else look
         lda   d,x        at block map byte
         cmpa  #RAMinUse  is it in use?
         bne   L0848      ..yes
         leay  32,y       leave map ++
         bra   L084F

* Free Ram:

L0847    clra  

* Ram Not in Use:

L0848    ldb   #32        count=32 pages ++
L084A    sta   ,y+        mark the ram
         decb  
         bne   L084A

L084F    inc   ,s
         ldb   ,s
         cmpb  #DAT.BlCt  all blocks done?
         bcs   L082F
L0857    ldb   R$A,u      page count
L0859    cmpy  D.SysMem   back to map start?
         bhi   L0863      ..not yet
         comb  
         ldb   #E$NoRam   was MemFul ++
         bra   L0894

L0863    lda   ,-y        free page?
         bne   L0857      ..no,try again
         decb             else got page+1
         bne   L0859
         sty   ,s
         lda   1,s
         lsra  
         lsra  
         lsra  
         lsra  
         lsra             ++
         ldb   1,s
         andb  #$1F       ++
         addb  R$A,u
         addb  #$1F       ++
         lsrb  
         lsrb  
         lsrb  
         lsrb  
         lsrb             ++
         ldx   D.SysPrc
         lbsr  L09BE      allocate ram images
         bcs   L0894
         ldb   R$A,u
L088A    inc   ,y+
         decb  
         bne   L088A
         lda   1,s
         std   R$U,u      return ptr to mem
         clrb  
L0894    leas  2,s
         rts   


*------------------------------------------------*
*                    F$SRtMem
*------------------------------------------------*
FSRtMem  ldd   R$D,u
         beq   L08F2
         addd  #$00FF
         ldb   R$U+1,u
         beq   L08A6
         comb  
         ldb   #E$BPAddr  'Boundary Error'
         rts   

L08A6    ldb   R$U,u
         beq   L08F2
         ldx   D.SysMem
         abx   
L08AD    ldb   ,x
         andb  #^RAMinUse
         stb   ,x+
         deca  
         bne   L08AD
         ldx   D.SysDAT
         ldy   #DAT.BlCt  16 blocks/space
L08BC    ldd   ,x
         cmpd  #DAT.Free  free block?
         beq   L08EC      ..yes
         ldu   D.BlkMap
         lda   d,u
         cmpa  #$01
         bne   L08EC
         tfr   x,d
         subd  D.SysDAT
         aslb  
         aslb  
         aslb  
         aslb             ++
         ldu   D.SysMem
         leau  d,u
         ldb   #32        16 blocks in sys space ++
L08DA    lda   ,u+
         bne   L08EC
         decb  
         bne   L08DA
         ldd   ,x
         ldu   D.BlkMap
         clr   d,u
         ldd   #DAT.Free
         std   ,x
L08EC    leax  2,x
         leay  -1,y
         bne   L08BC
L08F2    clrb  
         rts   


*------------------------------------------------*
*                    F$Boot
*------------------------------------------------*
FBoot    comb  
         lda   D.Boot     booted already?
         bne   L0966      ..yes,rts.
         inc   D.Boot     flag it
*         ldx   D.Init     X=init module
*         beq   L0908     ..use default if no Init
*         ldd   BootStr,x  offset to Boot name
*         beq   L0908     ..none
*         leax  d,x       X=Init BootStrap name
*         bra   L090C     use it

L0908    leax  BootMod,pcr default 'Boot' name
L090C    lbsr  LinkSys    link to module
         bcs   L0966      ..err rts
         jsr   ,y         do the boot
         bcs   L0966      ..err
         std   D.BtSz     Bootfile size ++
         stx   D.BtPtr    Boot start address ++
         leau  d,x
         tfr   x,d
         anda  #$E0       ++
         clrb  
         pshs  a,b,u
         lsra  
         lsra  
         lsra  
         lsra             ++
         ldy   D.SysDAT
         leay  a,y
*------------------------------------------------*
* Find & Verify Boot Modules:

L092D    ldd   ,x         get header
         cmpd  #M$ID12    (87CD) is it a module?
         bne   L0954      ..no
         tfr   x,d
         subd  ,s
         tfr   d,x
         tfr   y,d
         os9   F$VModul
         pshs  b
         ldd   1,s
         leax  d,x
         puls  b
         bcc   L094E
         cmpb  #E$KwnMod  'Known Module'?
         bne   L0954      ..no
L094E    ldd   2,x
         leax  d,x
         bra   L0956

L0954    leax  1,x
L0956    cmpx  2,s        end of boot mem?
         bcs   L092D      ..no, try more
         leas  4,s
         ldx   D.SysDAT   ++
         ldb   13,x       ++
         incb             ++
         ldx   D.BlkMap   ++
         lbra  L01DF      ++

L0966    rts   


*------------------------------------------------*
*                    F$AllRam
*------------------------------------------------*
FAllRam  ldb   R$B,u      get # ram blocks desired
         bsr   L0970
         bcs   L096F
         std   R$D,u
L096F    rts   

*------------------------------------------------*
L0970    pshs  a,b,x,y
         ldx   D.BlkMap   X=block map start

* Start at new block begin:

L0974    leay  ,x         Y=start
         ldb   1,s        B=count
L0978    cmpx  D.BlkMap+2 at end of block map?
         bcc   L0995      ..yes,end.
         lda   ,x+        is block free?
         bne   L0974      ..no, try new start
         decb             yes, count-1
         bne   L0978      keep trying

L0983    tfr   y,d        D=begin block ptr ++
         subd  D.BlkMap   D=begin block number
         sta   R$A-1,s    return number on ,S
         lda   R$B-1,s    A=count
         stb   R$B-1,s

* mark off blocks

L098D    inc   ,y+        mark as ram in use
         deca  
         bne   L098D
         clrb  
         puls  a,b,x,y,pc okay end.

L0995    comb  
         ldb   #E$NoRam   'Sys Ram Full'
         stb   1,s        return err
         puls  a,b,x,y,pc bad end.

*------------------------------------------------*
*                    F$AlHRam
*------------------------------------------------*

FALHRAM  ldb   R$B,u      get block count ++
         bsr   L09A5      find blocks ++
         bcs   L09A4      error ++
         std   R$D,u      return count in D ++

L09A4    rts              ++

L09A5    pshs  a,b,x,y    match up stack ++
         ldx   D.BlkMap+2 point to end of map ++

L09A9    ldb   R$B-1,s    get block count ++

L09AB    cmpx  D.BlkMap   at bottom of map? ++
         bls   L0995      yes, error ++
         lda   ,-x        block free? ++
         bne   L09A9      no ++
         decb             found them all? ++
         bne   L09AB      no, continue ++
         tfr   x,y        match up registers ++
         bra   L0983      allocate blocks ++

*------------------------------------------------*
*                    F$AllImg
*------------------------------------------------*
FAllImg  ldd   R$D,u      A=begin blk#, B=# of blocks
         ldx   R$X,u      X=proc desc
L09BE    pshs  a,b,x,y,u
         asla  
         leay  P$DATImg,x Y=DAT image ptr
         leay  a,y        Y=image ptr
         clra  
         tfr   d,x
         ldu   D.BlkMap
         pshs  a,b,x,y,u
L09CD    ldd   ,y++       D=image
         cmpd  #DAT.Free  unused?
         beq   L09E2      ..yes
         lda   d,u        else what is it?
         cmpa  #RAMinUse  ram?
         puls  a,b
         bne   L09F7      ..no

         subd  #$0001
         pshs  a,b
L09E2    leax  -1,x
         bne   L09CD
         ldx   ,s++
         beq   L0A00
L09EA    lda   ,u+
         bne   L09F2
         leax  -1,x
         beq   L0A00
L09F2    cmpu  D.BlkMap+2
         bcs   L09EA

L09F7    ldb   #E$MemFul  'Proc Memory Full' (207)
         leas  6,s
         stb   R$B-1,s
         comb  
         puls  a,b,x,y,u,pc

*------------------------------------------------*
L0A00    puls  x,y,u
L0A02    ldd   ,y++
         cmpd  #DAT.Free
         bne   L0A16
L0A0A    lda   ,u+
         bne   L0A0A
         inc   ,-u
         tfr   u,d
         subd  D.BlkMap
         std   -2,y

L0A16    leax  -1,x
         bne   L0A02
         ldx   2,s
         lda   P$State,x  get proc state &
         ora   #ImgChg    flag image change
         sta   P$State,x  .
         clrb  
         puls  a,b,x,y,u,pc


*------------------------------------------------*
*                    F$FreeHB
*------------------------------------------------*
FFreeHB  ldb   R$B,u      B=block count
         ldy   R$Y,u
         bsr   L0A31
         bcs   L0A30
         sta   R$A,u
L0A30    rts   

L0A31    tfr   b,a
L0A33    suba  #$09
         nega  
         pshs  x,b,a
         ldd   #$FFFF
         pshs  b,a
         bra   L0A58

FFreeLB  ldb   R$B,u
         ldy   R$Y,u
         bsr   L0A4B
         bcs   L0A4A
         sta   R$A,u
L0A4A    rts   

L0A4B    lda   #$FF
         pshs  x,b,a
         lda   #$01
         subb  #$09
         negb  
         pshs  b,a
         bra   L0A58

L0A58    clra  
         ldb   $02,s
         addb  ,s
         stb   $02,s
         cmpb  $01,s
         bne   L0A75
         ldb   #$CF
         cmpy  <D.SysDAT
         bne   L0A6C
         ldb   #$ED
L0A6C    stb   $03,s
         comb  
         bra   L0A82

L0A71    tfr   a,b
         addb  $02,s
L0A75    lslb  
         ldx   b,y
         cmpx  #DAT.Free
         bne   L0A58
         inca  
         cmpa  $03,s
         bne   L0A71
L0A82    leas  $02,s
         puls  pc,x,b,a

FSetImg  ldd   R$A,u
         ldx   R$X,u
         ldu   R$U,u
L0A8C    pshs  u,y,x,b,a
         leay  P$DATImg,x
         lsla  
         leay  a,y
L0A94    ldx   ,u++
         stx   ,y++
         decb  
         bne   L0A94
         ldx   $02,s      get proc desc ptr
         lda   P$State,x
         ora   #ImgChg
         sta   P$State,x
         clrb  
         puls  pc,u,y,x,b,a

FDATLog  ldb   R$B,u
         ldx   R$X,u
         bsr   L0AB0
         stx   R$X,u
         clrb  
         rts   

*L0AB0    pshs  x,b,a --BGP
L0AB0    pshs  x,b        ++BGP
         lslb  
         lslb  
         lslb  
         lslb  
         lslb  
*         addb  $02,s  --BGP
*         stb   $02,s  --BGP
         addb  1,s        ++BGP
         stb   1,s        ++BGP
*         puls  pc,x,b,a --BGP
         puls  pc,x,b     ++BGP

FLDAXY   ldx   R$X,u
         ldy   R$Y,u
         bsr   L0AC8
         sta   R$A,u
         clrb  
         rts   

L0AC8    pshs  cc
         lda   $01,y
         orcc  #IntMasks
         sta   >DAT.Regs
         lda   ,x
         clr   >DAT.Regs
         puls  pc,cc

LDAXY    bsr   L0AC8
         leax  $01,x
         bra   L0AF0

L0AEA    leax  >-$2000,x
         leay  $02,y
L0AF0    cmpx  #$2000
         bcc   L0AEA
         rts   

FLDDDXY  ldd   R$D,u
         leau  R$X,u
         pulu  y,x
         bsr   LDDXY
         std   -$07,u
         clrb  
         rts   
LDDXY    pshs  y,x
         leax  d,x
         bsr   L0AF0
         bsr   LDAXY
         pshs  a
         bsr   L0AC8
         tfr   a,b
         puls  pc,y,x,a

FLDABX   ldb   R$B,u
         ldx   R$X,u
         lbsr  L0C12
         sta   R$A,u
         rts   

FSTABX   ldd   R$D,u
         ldx   R$X,u
         lbra  L0C28

FMove    ldd   R$D,u
         ldx   R$X,u
         ldy   R$Y,u
         ldu   R$U,u
L0B2C    pshs  u,y,x,b,a
         leay  ,y
         lbeq  L0BF2
         pshs  y,b,a
         tfr   a,b
         lbsr  L0C0F
         leay  a,u
         pshs  y,x
         ldb   $09,s
         ldx   $0E,s
         lbsr  L0C0F
         leay  a,u
         pshs  y,x
         ldd   #$2000
         subd  ,s
         pshs  b,a
         ldd   #$2000
         subd  $06,s
         pshs  b,a
         ldx   $08,s
         leax  >-$6000,x
         ldu   $04,s
         leau  >-$4000,u
L0B6A    pshs  cc
         ldd   [<$07,s]
         pshs  b
         ldd   [<$0C,s]
         pshs  b
         ldd   <$11,s
         cmpd  $03,s
         bls   L0B82
         ldd   $03,s
L0B82    cmpd  $05,s
         bls   L0B89
         ldd   $05,s
L0B89    cmpd  #$0040
         bls   L0B84
         ldd   #$0040
L0B84    std   $0F,s
         puls  y
         orcc  #IntMasks
         sty   >$FFA5
         andb  #$07
         beq   L0B99
L0B92    lda   ,x+
         sta   ,u+
         decb  
         bne   L0B92
L0B99    ldb   $0E,s
         lsrb  
         lsrb  
         lsrb  
         beq   L0BBC
         pshs  b
         exg   x,u
L0BA4    pulu  y,b,a
         std   ,x
         sty   $02,x
         pulu  y,b,a
         std   $04,x
         sty   $06,x
         leax  $08,x
         dec   ,s
         bne   L0BA4
         leas  $01,s
         exg   x,u
L0BBC    ldy   <D.SysDAT
         lda   $0B,y
         ldb   $0D,y
         std   >$FFA5
         puls  cc
         ldd   $0E,s
         subd  $0C,s
         beq   L0BEF
         std   $0E,s
         ldd   ,s
         subd  $0C,s
         bne   L0BD7
         ldd   #$2000
         leax  >-$2000,x
         inc   $0B,s
         inc   $0B,s
L0BD7    std   ,s
         ldd   $02,s
         subd  $0C,s
         bne   L0BEA
         ldd   #$2000
         leau  >-$2000,u
         inc   $07,s
         inc   $07,s
L0BEA    std   $02,s
         lbra  L0B6A
L0BEF    leas  <$10,s
L0BF2    clrb  
         puls  pc,u,y,x,b,a

L0BF5    pshs  b
         tfr   x,d
         anda  #$1F
         exg   d,x
         anda  #$E0
         lsra  
         lsra  
         lsra  
         lsra  
L0C07    puls  pc,b
L0C0F    bsr   L0BF5
*L0C09    pshs  b --BGP
L0C09          
         ldu   <D.TskIPt
         lslb  
         ldu   b,u
         rorb             ++BGP
*         puls  pc,b  --BGP
         rts              ++BGP

L0C12    andcc  #^Carry
         pshs  u,x,b,cc
         bsr   L0C0F
         ldd   a,u
         orcc  #IntMasks
         stb   >DAT.Regs
         lda   ,x
         clr   >DAT.Regs
         puls  pc,u,x,b,cc

L0C28    andcc  #^Carry
         pshs  u,x,b,a,cc
         bsr   L0C0F
         ldd   a,u
         lda   $01,s
         orcc  #IntMasks
         stb   >DAT.Regs
         sta   ,x
         clr   >DAT.Regs
         puls  pc,u,x,b,a,cc

FLDBBX   andcc  #^Carry
         pshs  u,x,a,cc
         bsr   L0C0F
         ldd   a,u
         orcc  #IntMasks
         stb   >DAT.Regs
         ldb   ,x
         clr   >DAT.Regs
         puls  pc,u,x,a,cc

FAllTsk  ldx   R$X,u
L0C58    ldb   P$Task,x
         bne   L0C64
         cmpx  <$004A
         beq   L0C64
         bsr   L0CA6
         bcs   L0C65
         stb   P$Task,x
         bsr   L0C79
L0C64    clrb  
L0C65    rts   

FDelTsk  ldx   R$X,u      get proc desc ptr
L0C68    ldb   P$Task,x
         beq   L0C65
         clr   P$Task,x
         bra   L0CC3
L0C70    lda   P$State,x
         bita  #ImgChg
         bne   L0C79
         rts   

FSetTsk  ldx   R$X,u
L0C79    lda   P$State,x
         anda  #^ImgChg
         sta   P$State,x
         andcc  #^Carry
         pshs  u,y,x,b,a,cc
         ldb   P$Task,x
         leax  P$DATImg,x
         ldu   <D.TskIPt
         lslb  
         stx   b,u
         cmpb  #$02
         bgt   L0C9F
         ldu   #DAT.Regs
         leax  1,x
         ldb   #$08
L0C98    lda   ,x++
         sta   ,u+
         decb  
         bne   L0C98
L0C9F    puls  pc,u,y,x,b,a,cc

FResTsk  bsr   L0CA6
         stb   R$B,u
         rts   

L0CA6    pshs  x
         ldb   #$02
         ldx   <D.Tasks
L0CAC    lda   b,x
         beq   L0CBA
         incb  
         cmpb  #$20
         bne   L0CAC
         comb  
         ldb   #$EF
         bra   L0CBF

L0CBA    inc   b,x
         clra  
L0CBF    puls  pc,x

FRelTsk  ldb   R$B,u
L0CC3    pshs  x,b
         tstb  
         beq   L0CD0
         ldx   <D.Tasks
         clr   b,x
L0CD0    puls  pc,x,b

* Control goes here when a tick interrupt comes in
Clock    ldb   #P$STicks  assume system state
         ldx   <D.Proc    get curr process
         lda   P$State,x  get process state
         bmi   L0CDC      branch if SysState
         ldb   #P$UTicks  otherwise user state
L0CDC    lbsr  IncCount   count ticks
         ldx   <D.SProcQ  point to sleep queue
         beq   L0CFD      branch if no process sleeping
* Process sleep queue here!
* Sleep queue is sorted by process closest to wake first, all the way
* to processes that are sleeping forever.
         lda   P$State,x  get process' state
         bita  #TimSleep  sleeping forever?
         beq   L0CFD      yep, finished
         ldu   P$SP,x     else get process' stack pointer
         ldd   R$X,u      and get process' sleep tick counter
         subd  #$0001     subtract 1 from tick counter
         std   R$X,u      save back to process' X
         bne   L0CFD      branch if not ready to wake
L0CE7    ldu   P$Queue,x  else time to wake up! so...
         bsr   L0D11      activate this process
         leax  ,u         point to next process
         beq   L0CFB
         lda   P$State,x
         bita  #TimSleep
         beq   L0CFB
         ldu   P$SP,x
         ldd   R$X,u
         beq   L0CE7
L0CFB    stx   <D.SProcQ  store new process pointer
L0CFD    dec   <D.Slice   decrement slice
         bne   L0D0D      branch if not at end of timeslice
         inc   <D.Slice
         ldx   <D.Proc    get current process
         beq   L0D0D      branch if none
         lda   P$State,x  ...else get state
         ora   #TimOut    and indicate it's out of time
         sta   P$State,x  then restore it
L0D0D    clrb  
         rts   

* X  = address of process descriptor to put in active queue
FAProc   ldx   R$X,u
L0D11    clrb  
         pshs  u,y,x,b,cc
         lda   P$Prior,x  get priority of process
         sta   P$Age,x    reset age to priority
         orcc  #IntMasks  mask interrupts
         ldu   #$0045
         bra   L0D29
L0D1F    inc   $0B,u
         bne   L0D25
         dec   $0B,u
L0D25    cmpa  $0B,u
         bhi   L0D2B
L0D29    leay  ,u
L0D2B    ldu   $0D,u
         bne   L0D1F
         ldd   $0D,y
         stx   $0D,y
         std   $0D,x
         puls  pc,u,y,x,b,cc

* System IRQ service routine

XIRQ     ldx   <D.Proc
         sts   P$SP,x
         lds   <D.SysStk
         ldd   <D.SysSvc
         std   <D.XSWI2
         ldd   <D.SysIRQ
         std   <D.XIRQ
         jsr   [>D.SvcIRQ]
         bcc   L0D5B
         ldx   <D.Proc
         ldb   P$Task,x
         ldx   P$SP,x
         lbsr  L0C12
         ora   #IntMasks
         lbsr  L0C28
L0D5B    orcc  #IntMasks
         ldx   <D.Proc
         lda   P$State,x
         bita  #TimOut
         bne   L0D7C
L0D78    ldu   $04,x
         bra   L0DB9
L0D7C    anda  #$DF
         sta   $0C,x
         lbsr  L0C68
L0D83    bsr   L0D11

FNProc   ldx   <D.SysPrc
         stx   <D.Proc
         lds   <D.SysStk
         andcc  #^(IntMasks)
         bra   L0D93

L0D91    cwai  #^(IntMasks)
L0D93    orcc  #IntMasks
         lda   #Suspend
         ldx   #$0045
L0D9A    leay  ,x
         ldx   $0D,y
         beq   L0D91
         bita  P$State,x
         bne   L0D9A
         ldd   P$Queue,x
         std   $0D,y
         stx   <D.Proc
         lbsr  L0C58
         bcs   L0D83
         lda   <D.TSlice
         sta   <D.Slice
         ldu   P$SP,x
         lda   P$State,x
         bmi   L0E29
L0DB9    bita  #Condem
         bne   L0DFD
         lbsr  L0C70
         ldb   P$Signal,x
         beq   L0DF2
         decb  
         beq   L0DEF
         leas  -$0C,s
         leau  ,s
         lbsr  L02CB
         lda   P$Signal,x
         sta   $02,u
         ldd   P$SigVec,x
         beq   L0DFD
         std   $0A,u
         ldd   P$SigDat,x
         std   $08,u
         ldd   P$SP,x
         subd  #$000C
         std   P$SP,x
         lbsr  L02DA
         leas  $0C,s
         ldu   P$SP,x
         clrb  
L0DEF    stb   P$Signal,x
L0DF2    ldd   <D.UsrSvc
         std   <D.XSWI2
         ldd   <D.UsrIRQ
         std   <D.XIRQ
         bra   L0E4C
L0DFD    lda   P$State,x
         ora   #SysState
         sta   P$State,x
         leas  $0200,x
         andcc  #^(IntMasks)
         ldb   P$Signal,x
         clr   P$Signal,x
         os9   F$Exit

* Interrupts come through here when in system state
S.SysIRQ lda   <D.SSTskN  get system task number
         clr   <D.SSTskN  clear system task number in globs
         pshs  a          save on stack
         jsr   [>D.SvcIRQ]
         puls  a
         bsr   L0E39
         bcc   XFIRQ
         ldb   R$CC,s
         orb   #IntMasks
         stb   R$CC,s
XFIRQ    rti   

L0E29    clr   ,-s
L0E2B    ldx   <D.SysPrc
         lbsr  L0C70
         orcc  #IntMasks
         puls  a
         bsr   L0E39
         leas  ,u
         rti   

* A = task number
L0E39    sta   <D.SSTskN
         beq   S.AltIRQ
         ora   <D.TINIT
         sta   <D.TINIT
         sta   DAT.Task
S.AltIRQ rts   

S.SvcIRQ jmp   [>D.Poll]
S.POLL   orcc  #Carry
         rts   

L0E4C    ldb   $06,x
         orcc  #IntMasks
         bsr   L0E8D
         lda   <D.TINIT
         ora   #$01
         sta   <D.TINIT
         sta   DAT.Task
         leas  ,u
         rti   

L0E5E    ldb   <D.TINIT
         orb   #$01
         stb   <D.TINIT
         stb   DAT.Task
         jmp   ,u

S.Flip0  pshs  b,a
         lda   <D.TINIT
         anda  #$FE
         sta   <D.TINIT
         sta   DAT.Task
         clr   <D.SSTskN
         puls  b,a
         tfr   x,s
         tfr   a,cc
         rts   

S.Flip1  ldb   #$01       get task image entry number
         bsr   L0E8D      copy over the DAT image
         lda   <D.TINIT   get copy of GIME Task side
         ora   #$01       switch it to task one
         sta   <D.TINIT   save it to image
         sta   DAT.Task   save it to GIME register
         inc   <D.SSTskN  increment system tstae task number
         rti              return

L0E8D    pshs  u,x,b,a
         ldx   #$FFA8     get MMU start register for process
         ldu   <D.TskIPt  get task image pointer table
         lslb             account for 2 bytes per entry
         ldu   b,u        get address of MMU entry
         leau  $01,u
         ldb   #$08
L0E9B    lda   ,u++
         sta   ,x+
         decb  
         bne   L0E9B
         puls  pc,u,x,b,a

* SWI3.V - Control comes here upon a SWI3 interrupt
SWI3.V   orcc  #IntMasks  mask interrupts
         ldb   #D.SWI3    get direct page global vector
         bra   IRQCntrl

* SWI2.V - Control comes here upon a SWI2 interrupt
SWI2.V   orcc  #IntMasks  mask interrupts
         ldb   #D.SWI2    get direct page global vector
         bra   IRQCntrl

* FIRQ.V - Control comes here upon a FIRQ interrupt
FIRQ.V   tst   ,s
         bmi   L0EB0
         leas  -$01,s
         pshs  y,x,dp,b,a
         lda   $08,s
         stu   $07,s
         ora   #$80
         pshs  a
L0EB0    ldb   #D.FIRQ
         bra   IRQCntrl

* IRQ.V - Control comes here upon a IRQ interrupt
IRQ.V    orcc  #IntMasks  mask interrupts
         ldb   #D.IRQ     get direct page global vector
* B  = address of vector from direct page
IRQCntrl clra             clear A
         tfr   a,dp       make DP point to 0
         sta   DAT.Task   redundancy???
         lda   <D.TINIT   get task register shadow
         anda  #$FE       clear bit to use $FFA0-$FFA7
         sta   <D.TINIT   save in shadow
         sta   DAT.Task   save in hardware (do it!)
         clra             clear A
         tfr   d,x        D = addr of direct page vector
         jmp   [,x]       transfer control to addr in passed vector

* SWI.V - Control comes here upon a SWI interrupt
SWI.V    ldb   #D.SWI     get direct page global vector
         bra   IRQCntrl

* NMI.V - Control comes here upon a NMI interrupt
NMI.V    ldb   #D.NMI     get direct page global vector
         bra   IRQCntrl

* Filler bytes to get $ED9
Filler   fcb   $39,$39,$39,$39,$39,$39,$39,$39,$39,$39
*         fcb   $39,$39,$39,$39,$39,$39,$39,$39,$39,$39

         emod  
eom      equ   *

* Direct Page vectors
D.VECTRS fdb   $F100+Clock goes in D.Clock
         fdb   $F100+XSWI3 goes in D.XSWI3
         fdb   $F100+XSWI2 goes in D.XSWI2
         fdb   $F100+XFIRQ goes in D.XFIRQ
         fdb   $F100+XIRQ goes in D.XIRQ
         fdb   $F100+XSWI goes in D.XSWI
         fdb   $F100      goes in D.NMI
         fcb   $55
* 6809 vectors
* This table starts at $FEEE.  Each address is pointed to by the 6809
* vectors at $FFF0 (defined in the CoCo 3 ROM).
         lbra  SWI3.V     SWI3
         lbra  SWI2.V     SWI2
         lbra  FIRQ.V     FIRQ
         lbra  IRQ.V      IRQ
         lbra  SWI.V      SWI
         lbra  NMI.V      NMI

eo       equ   *
         end   
