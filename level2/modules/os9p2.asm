********************************************************************
* OS9p2 - OS-9 Level Two V3 P2 module
*
* $Id$
*
* Ed.    Comments                                       Who YY/MM/DD
* ------------------------------------------------------------------
* 18d    Removed bogus assumptions regarding init       BGP 98/10/05
*        module in order to shrink code size, added
*        check for CRC bit in compabibility byte of
*        init module.
* 18e    Made minor optimizations as per Curtis Boyle's BGP 98/10/10
*        optimization document

         nam   OS9p2
         ttl   OS-9 Level Two V3 P2 module

         ifp1  
         use   defsfile
         endc  

msiz     equ   256

F$IOMan  equ   $7F

rev      set   $05
edition  set   18

         mod   endmod,name,Systm,Reent+rev,entry,msiz

name     fcs   "OS9p2"
         fcb   edition

*------------------------------------------------*
*              OS9p2 Inits Here:
*------------------------------------------------*

entry    leay  SysCalls,pcr insert OS9p2 sys calls
         os9   F$SSvc
         ldu   <D.Init
         ldd   Maxmem,u   D=top of free mem
         lsra             D/16 (16 blocks/map)
         rorb  
         lsra  
         rorb  
         lsra  
         rorb  
         lsra  
         rorb  
         lsra  
         rorb  
         addd  <D.BlkMap  D+block map start
         tfr   d,x        X=D
         ldb   #NotRAM    get flag
         bra   L0036

L0030    lda   ,x+        get block marker
         bne   L0036      ..skip if used
         stb   -1,x       else set as none
L0036    cmpx  <D.BlkMap+2 end of map?
         bcs   L0030      ..no,loop

L003A    ldu   <D.Init    U=init module
         ldd   SysStr,u   point to '/D0' offset
         beq   L004F      ..none
         leax  d,u        X=name ptr
         lda   #READ.+EXEC.
         os9   I$ChgDir   'CHD /D0',CHX /D0
*         bcc   L004F      ..okay
*         os9   F$Boot     else boot
*         bcc   L003A      ..okay

L004F    ldu   <D.Init    init data
         ldd   StdStr,u   point to '/TERM'
         beq   L0077
         leax  d,u
         lda   #READ.+WRITE.
         os9   I$Open     try to open /Term
*         bcc   L0066      ..okay
*         os9   F$Boot     else boot and
*         bcc   L004F      ..try again
         bcs   Crash      crash!

L0066    ldx   <D.Proc    X=proc desc
         sta   P$Path,x   std in
         os9   I$Dup
         sta   P$Path+1,x std out
         os9   I$Dup
         sta   P$Path+2,x std err

L0077    leax  OS9p3Nam,pcr try to find OS9p3
         lbsr  SysLink
         bcs   L0083
         jsr   ,y         do it's init if it exists

L0083    ldu   <D.Init
         ldd   InitStr,u  point to 'Sysgo'
         leax  d,u
         lda   #Objct     mod type
         clrb             mem ok
         ldy   #$0000     no parms
         os9   F$Fork     start up sysgo
         os9   F$NProc    and do it.

OS9p3Nam fcs   "OS9p3"

* NEW CODE FOR BAD BOOT:

Crash    jmp   <D.Crash   reset vector

*------------------------------------------------*
*                  Service Calls:
*------------------------------------------------*

SysCalls fcb   F$Unlink
         fdb   FUnlink-*-2
         fcb   F$Fork
         fdb   FFork-*-2
         fcb   F$Wait
         fdb   FWait-*-2
         fcb   F$Chain
         fdb   FChain-*-2
         fcb   F$Exit
         fdb   FExit-*-2
         fcb   F$Mem
         fdb   FMem-*-2
         fcb   F$Send
         fdb   FSend-*-2
         fcb   F$Icpt
         fdb   FIcpt-*-2
         fcb   F$Sleep
         fdb   FSleep-*-2
         fcb   F$SPrior
         fdb   FSPrior-*-2
         fcb   F$ID
         fdb   FID-*-2
         fcb   F$SSWI
         fdb   FSSWI-*-2
         fcb   F$STime
         fdb   FSTime-*-2
         fcb   F$SchBit
         fdb   FSchBit-*-2
         fcb   F$SchBit+$80 (sys)
         fdb   SSchBit-*-2
         fcb   F$AllBit
         fdb   FAllBit-*-2
         fcb   F$AllBit+$80 (sys)
         fdb   SAllBit-*-2
         fcb   F$DelBit
         fdb   FDelBit-*-2
         fcb   F$DelBit+$80
         fdb   SDelBit-*-2
         fcb   F$GPrDsc
         fdb   FGPrDsc-*-2
         fcb   F$GBlkMp
         fdb   FGBlkMp-*-2
         fcb   F$GModDr
         fdb   FGModDr-*-2
         fcb   F$CpyMem
         fdb   FCpyMem-*-2
         fcb   F$SUser
         fdb   FSUser-*-2
         fcb   F$Unload
         fdb   FUnload-*-2
         fcb   F$Find64+$80
         fdb   FFind64-*-2
         fcb   F$All64+$80
         fdb   FAll64-*-2
         fcb   F$Ret64+$80
         fdb   FRet64-*-2
         fcb   F$GProcP+$80
         fdb   FGProcP-*-2
         fcb   F$DelImg+$80
         fdb   FDelImg-*-2
         fcb   F$AllPrc+$80
         fdb   FAllPrc-*-2
         fcb   F$DelPrc+$80
         fdb   FDelPrc-*-2
         fcb   F$MapBlk
         fdb   FMapBlk-*-2
         fcb   F$ClrBlk
         fdb   FClrBlk-*-2
         fcb   F$DelRam
         fdb   FDelRam-*-2
         fcb   F$GCMDir+$80
         fdb   FGCMdir-*-2
         fcb   F$IOMan
         fdb   IOCall-*-2
         fcb   $80        End of Calls

* Link to a Systm module
SysLink  lda   #Systm
         os9   F$Link
         rts   

*------------------------------------------------*
*      The first I$Call will come here:

IOMgrNam fcs   "IOMan"

IOCall   pshs  a,b,x,y,u
         leax  IOMgrNam,pcr
         bsr   SysLink    try to find IOMan
* The following assumes os9p2 may be in the boot track and
* requires a call to F$Boot to get to IOMan.  This is
* not the case for the CoCo 3.
*         bcc   L0121      ..okay
*         os9   F$Boot     else boot
*         bcs   L012B      ..return err
*         bsr   SysLink      try again
         bcs   L012B
L0121    jsr   ,y         initialize IOMan
         puls  a,b,x,y,u
         ldx   $00FE,y    then do the call
         jmp   ,x

*------------------------------------------------*
* Error, No IOMan:

L012B    stb   1,s        return err code
         puls  a,b,x,y,u,pc

*------------------------------------------------*
*                     F$Unlink
*------------------------------------------------*
FUnlink  pshs  a,b,u
         ldd   R$U,u      D=module address
         ldx   R$U,u      X=module address
         lsra             img block # = A/16
         lsra  
         lsra  
         lsra  
         lsra  
         sta   ,s         save usr map img num
         beq   L0183      ..ignore if zero

         ldu   <D.Proc    proc desc
         leay  P$DATImg,u map images
         asla             index by block#
         ldd   a,y        D= DAT image number
         ldu   <D.BlkMap  look it up
         ldb   d,u        in the block map
         bitb  #ModBlock  module in block?
         beq   L0183      ..no, okay
         leau  P$DATImg,y else see if done
         bra   L0161      with this block...

L015D    dec   ,s         at mod block?
         beq   L0183      ..yes, ignore.
L0161    ldb   ,s         usr block #
         aslb             index
         ldd   b,u        D=real number
         beq   L015D      skip if zero

         lda   ,s         else get usr blk #
         asla             *16 is module start
         asla  
         asla  
         asla  
         asla  
         clrb             B=00
         nega             A=-A
         leax  d,x        X=block begin
         ldb   ,s         usr blk #
         aslb             index
         ldd   b,y        D=img block
         ldu   <D.ModDir  U=mod dir
         bra   L0185      ..check mods in block

*------------------------------------------------*
* Check Block for Mods:

L017C    leau  MD$ESize,u next entry
         cmpu  <D.ModEnd  end of dir?
         bcs   L0185      ..no, try more
L0183    bra   L01D0      ..yes,end.

L0185    cmpx  MD$MPtr,u  is it dir entry?
         bne   L017C      ..no, loop
         cmpd  [MD$MPDAT,u] image block same?
         bne   L017C      ..no, loop
         ldx   MD$Link,u  link count=0?
         beq   L0198      ..yes
         leax  -1,x       else link-1
         stx   MD$Link,u
         bne   L01B5      ..skip if not zero

L0198    ldx   2,s        X=reg stack
         ldx   R$U,x      X=mod ptr
         ldd   #M$Type    D=offset to type byte
         os9   F$LDDDXY   get module type/lang
         cmpa  #FlMgr     is it mgr,driver, or desc?
         bcs   L01B3      ..no
         os9   F$IODel    yes, delete it properly
         bcc   L01B3      ..ok
         ldx   MD$Link,u  else inc link count
         leax  1,x
         stx   MD$Link,u
         bra   L01D1      ..bad end.

L01B3    bsr   L01D5      delete moddir entry
L01B5    ldb   ,s         block dat
         aslb             index
         leay  b,y        Y=image ptr
         ldx   P$Links-P$DATImg,y link count
         leax  -1,x       -1
         stx   P$Links-P$DATImg,y
         bne   L01D0      ..skip if not zero

         ldd   MD$MBSiz,u block size
         bsr   L0226      change to #blocks
         ldx   #DAT.Free  free flag
L01CB    stx   ,y++       mark images free
         deca  
         bne   L01CB

L01D0    clrb             okay
L01D1    leas  2,s        drop
         puls  u,pc       end unlink.

*------------------------------------------------*
* Clear ModDir Entry:

L01D5    ldx   <D.BlkMap  X=ram map
         ldd   [MD$MPDAT,u] D=DAT img blk
         lda   d,x        A=map marker
         bmi   L0225      ..bra if not ram
         ldx   <D.ModDir  point to module dir

L01DF    ldd   [MD$MPDAT,x] get block #
         cmpd  [MD$MPDAT,u] same as this?
         bne   L01EA      ..no

         ldd   MD$Link,x  link cnt zero?
         bne   L0225      ..no
L01EA    leax  MD$ESize,x skip to next entry
         cmpx  <D.ModEnd  last?
         bcs   L01DF      ..no, keep looking

         ldx   <D.BlkMap  block map ptr
         ldd   MD$MBSiz,u module block size
         bsr   L0226      convert to #blocks
         pshs  y          save y
         ldy   MD$MPDAT,u module image ptr
L01FB    pshs  a,x        save #blocks, ptr
         ldd   ,y         get block number
         clr   ,y+        clear the image
         clr   ,y+
         leax  d,x        point to blkmap entry
         ldb   ,x
         andb  #^(RAMinUse+ModBlock) free block
         stb   ,x
         puls  a,x
         deca             last block done?
         bne   L01FB      ..no, loop

         puls  y
         ldx   <D.ModDir  module dir ptr
         ldd   MD$MPDAT,u image ptr

L0216    cmpd  ,x         was module here?
         bne   L021F      ..no
         clr   MD$MPDAT,x clear entry
         clr   MD$MPDAT+1,x
L021F    leax  MD$ESize,x next dir entry
         cmpx  <D.ModEnd  last?
         bcs   L0216      ..no, keep looking

L0225    rts              end clear moddir entry.

*------------------------------------------------*
* Convert BlockSize to #Blocks:

L0226    addd  #$1FFF     round up
         lsra  
         lsra  
         lsra  
         lsra  
         lsra  
         rts   

*------------------------------------------------*
*                     F$Fork
*------------------------------------------------*
FFork    pshs  u
         lbsr  L02EA      get proc desc
         bcc   L0238      ..ok, fork
         puls  u,pc       else err.

*------------------------------------------------*
L0238    pshs  u          save child proc desc ptr
         ldx   <D.Proc    get parent's
         ldd   P$User,x   copy user index
         std   P$User,u
         lda   P$Prior,x  priority & age
         sta   P$Prior,u

         pshs  x,u        save proc. desc. addresses

         leax  P$NIO,x    copy Net IO ptrs <NEW>
         leau  P$NIO,u    <NEW>
         ldb   #NefIOSiz  Net table size <NEW>

L0250    lda   ,x+
         sta   ,u+
         decb  
         bne   L0250

         puls  x,u        recover proc. desc. addresses
         leax  P$DIO,x    copy default data/exec dirs:
         leau  P$DIO,u
         ldb   #DefIOSiz
L0261    lda   ,x+
         sta   ,u+
         decb  
         bne   L0261

         ldy   #3

* dup 1st 3 paths:

L026C    lda   ,x+
         beq   L0276      skip if not open
         os9   I$Dup
         bcc   L0276
         clra  

* as std in/out/err:

L0276    sta   ,u+
         leay  -1,y       count-1
         bne   L026C

         ldx   ,s         X=child proc desc
         ldu   2,s        U=caller regs
         lbsr  L04B1      link/load mod, set proc desc
         bcs   L02CF      ..err
         pshs  a,b        save size
         os9   F$AllTsk   get task# for child
         bcs   L02CF

L028C    lda   P$PagCnt,x D=mem amt
         clrb  
         subd  ,s         D-mod size
         tfr   d,u        U=dest
         ldb   P$Task,x   B=child task# for parm copy
         ldx   <D.Proc    parent's proc desc
         lda   P$Task,x   and task
         leax  ,y         X=parameter ptr
         puls  y          Y=count
         os9   F$Move     X(A)-->U(B) *Y copy over data

         ldx   ,s         copy over child's stack
         lda   <D.SysTsk
         ldu   P$SP,x
         leax  P$Stack-R$Size,x
         ldy   #R$Size
         os9   F$Move     X(A)-->U(B) *Y

         puls  x,u
         os9   F$DelTsk   release child task#
         ldy   <D.Proc    Y=parents proc desc
         lda   P$ID,x     X=childs proc desc
         sta   R$A,u      return it
         ldb   P$CID,y    B=sibling
         sta   P$CID,y    let parent have child
         lda   P$ID,y     parents ID
         std   P$PID,x    set child's parent/sibling
         lda   P$State,x
         anda  #^SysState take child out of sys
         sta   P$State,x  state and
         os9   F$AProc    activate it
         rts              end.

*------------------------------------------------*
* Error - couldn't link/load pgm:

L02CF    puls  x          bad proc desc
         pshs  b          save error
         lbsr  L05A5      close paths & unlink mem
         lda   P$ID,x     get bad id
         lbsr  L0386      delete proc desc & task#
         comb             set err
         puls  b,u,pc     bad end.

*------------------------------------------------*
*                     F$AllPrc
*------------------------------------------------*
FAllPrc  pshs  u          save reg ptr
         bsr   L02EA      allocate process desc
         bcs   L02E8      ..err
         ldx   ,s         get reg ptr
         stu   R$U,x      return proc desc ptr
L02E8    puls  u,pc       end.

*------------------------------------------------*
* Allocate a Proc Desc:

L02EA    ldx   <D.PrcDBT  X=proc table
L02EC    lda   ,x+        search 'til empty
         bne   L02EC      is found

         leax  -1,x       back up to it
         tfr   x,d        D=addrss
         subd  <D.PrcDBT  D=index
         tsta             >256?
         beq   L02FE      ..no, ok
         comb             else
         ldb   #E$PrcFul  'Process Table Full'
         bra   L032F

L02FE    pshs  b          save index
         ldd   #P$Size    get 512 bytes
         os9   F$SRqMem   for proc desc
         puls  a          A=index
         bcs   L032F      ..err
         sta   P$ID,u     set proc ID
         tfr   u,d        D=proc desc addrss
         sta   ,x         set proc desc msb in table

         clra             D=0000
         leax  P$PID,u    start after ID
         ldy   #$80       256 byte count
L0317    std   ,x++       clear proc desc
         leay  -1,y
         bne   L0317

         ldy   <D.Proc    get current proc desc address
         ldx   <D.SysPrc  get system proc desc address
         stx   <D.Proc    make system current proc
         leax  P$DatBeg,u new proc desc creation date/time tag
         os9   F$Time     ignore any error...
         sty   <D.Proc    restore current proc desc address

         lda   #SysState  set system state
         sta   P$State,u
         ldb   #DAT.BlCt  mark all blocks as unused
         ldx   #DAT.Free
         leay  P$DATImg,u in the proc images
L0329    stx   ,y++
         decb  
         bne   L0329
         clrb             okay
L032F    rts   

*------------------------------------------------*
*                     F$DelPrc
*------------------------------------------------*
FDelPrc  lda   R$A,u      get proc id
         bra   L0386      delete it

*------------------------------------------------*
*                     F$Wait
*------------------------------------------------*
FWait    ldx   <D.Proc    proc desc
         lda   P$CID,x    any children?
         beq   L0368      ..no, quick return

L033A    lbsr  L0B2E      find child proc desc
         lda   P$State,y
         bita  #Dead      has it died?
         bne   L036C      ..yes
         lda   P$SID,y    else does it have sibling?
         bne   L033A      ..yes, check it

         sta   R$A,u      return child's id

         sta   R$B,U

         pshs  cc         save CC
         orcc  #IntMasks  stop interrupts

         lda   P$SIGNAL,X
         beq   N035D
         deca  
         bne   N035A
         sta   P$SIGNAL,X
N035A    lbra  L071B

N035D    ldd   <D.WProcQ  insert caller
         std   P$Queue,x  into waiting proc
         stx   <D.WProcQ  queue
         puls  cc         restore CC
         lbra  L0780      and go wait.

L0368    comb  
         ldb   #E$NoChld  'No Child Error'
         rts   

*------------------------------------------------*
L036C    lda   P$ID,y     get child id
         ldb   P$Signal,y and its death signal
         std   R$A,u      return to caller
         leau  ,y         child proc desc
         leay  P$CID-P$SID,x
         bra   L037C      go bury child

*------------------------------------------------*
L0379    lbsr  L0B2E      find proc desc
L037C    lda   P$SID,y    is sibling the link?
         cmpa  P$ID,u
         bne   L0379      ..no, try next
         ldb   P$SID,u    link in other
         stb   P$SID,y    siblings

* Delete Proc Desc & Task#:

L0386    pshs  a,b,x,u

         cmpa  WGlobal+G.AlPID is alarm call for this task?
         bne   NEWLABEL   no ....
         clr   WGlobal+G.AlPID clear task #
         clr   WGlobal+G.AlSig clear signal

NEWLABEL ldb   ,s         <NEW LABEL>
         ldx   <D.PrcDBT  X=proc desc table
         abx              index task
         lda   ,x         get pointer
         beq   L03AC      ..quick ok if none
         clrb             else clear ptr
         stb   ,x
         tfr   d,x        X=proc desc
         os9   F$DelTsk   release task flag
         leau  ,x         U=proc desc
         ldd   #P$Size    return 512 byte
         os9   F$SRtMem   proc desc mem
L03AC    puls  a,b,x,u,pc end.

*------------------------------------------------*
*                     F$Chain
*------------------------------------------------*
FChain   pshs  u          save U
         lbsr  L02EA      allocate proc desc
         bcc   L03B7      ..go chain
         puls  u,pc

*------------------------------------------------*
* Copy Proc Desc Data:

L03B7    ldx   <D.Proc    save proc
         pshs  x,u
         leax  P$SP,x     copy from P$SP-->
         leau  P$SP,u
         ldy   #$007E     252 byte count

L03C3    ldd   ,x++       copy bytes
         std   ,u++
         leay  -1,y
         bne   L03C3

         ldu   2,S        get new proc desc address
         leau  P$DATImg,u point to DAT image
         ldx   ,S         get old proc desc
         lda   P$Task,x   get old task #
         asla             task # x2 is index
         ldx   <D.TskIPt  point to DAT image table
         stu   A,X        put image address into table

         ldx   <D.Proc    proc desc
         clra             D=0000
         clrb  
         stb   P$Task,x   set no task#
         std   P$SWI,x    sys swi's
         std   P$SWI2,x
         std   P$SWI3,x
         sta   P$Signal,x no signal/vecs
         std   P$SigVec,x
         ldu   P$PModul,x unlink primary module
         os9   F$Unlink
         ldb   P$PagCnt,x mem page count
         addb  #$1F       round up
         lsrb             B/16 (pages-->blocks)
         lsrb  
         lsrb  
         lsrb  
         lsrb  
         lda   #DAT.BlCt  max count=16
         pshs  b          -num used
         suba  ,s+        =number to release:
         leay  P$DATImg,x Y=images
         aslb             index
         leay  b,y        first block
         ldu   #DAT.Free  not used flag
L040C    stu   ,y++       clear proc images
         deca  
         bne   L040C

         ldu   2,s        set new proc desc
         stu   <D.Proc
         ldu   P$SP,s
         lbsr  L04B1      link/load module

         bcs   L04A1      ..err

         pshs  a,b        save size
         os9   F$AllTsk   get task# for new proc (if possible)
         bcc   L0425

*------------------------------------------------*
* Chain Error:

         leas  2,s        dump parm size

L04A1          
         puls  x,u
         stx   <D.Proc    reset proc
         pshs  cc,b       save error status/info
         lda   P$ID,u     get temp proc id
         lbsr  L0386      and delete proc desc
         puls  cc,b       recover error status/info
         os9   F$Exit     and exit gracefully

L0425    ldu   <D.Proc    U=new proc
         lda   P$Task,u   A=source tsk#
         ldb   P$Task,x   B=dest tsk#
         leau  P$Stack-R$Size,x ($01F4)
         leax  ,y         source ptr
         ldu   R$X,u      dest ptr
         pshs  u          source ptr >
         cmpx  ,s++       dest ptr?
         puls  y          size
         bhi   L0471      ..yes
         beq   L0474      same place
         leay  ,y         size=zero?
         beq   L0474      ..yes

         pshs  a,b,x
         tfr   y,d        size
         leax  d,x        source end ptr
         pshs  u          save dest
         cmpx  ,s++       source within dest?
         puls  a,b,x
         bls   L0471      ..no

         pshs  a,b,x,y,u
         tfr   y,d        size
         leax  d,x        source end ptr
         leau  d,u        dest end ptr

* Copy Parms:

L0457    ldb   ,s         source task#
         leax  -1,x       back up fm end
         os9   F$LDABX    get byte
         exg   x,u        src <--> dest
         ldb   1,s        task#
         leax  -1,x       back up dest ptr
         os9   F$STABX    store byte
         exg   x,u
         leay  -1,y       cnt-1
         bne   L0457

         puls  a,b,x,y,u
         bra   L0474

*------------------------------------------------*
L0471    os9   F$Move     X(A)-->U(B) *Y
L0474    lda   <D.SysTsk  from sys map
         ldx   ,s         get proc desc
         ldu   P$SP,x     and stack pointer
         leax  P$Stack-R$Size,x point to proc stack
         ldy   #R$Size    stack count
         os9   F$Move     X(A)-->U(B) *Y copy from proc desc
         puls  x,u        stack to user reg stack
         lda   P$ID,u     get id
         lbsr  L0386      delete temp proc desc & free task#
         os9   F$DelTsk   delete task#
         orcc  #IntMasks  halt interrupts
         ldd   <D.SysPrc  set system as proc
         std   <D.Proc
         lda   P$State,x  drop system state
         anda  #^SysState
         sta   P$State,x
         os9   F$AProc    insert in active queue
         os9   F$NProc    and start next process.
* NOTE:  F$NProc will NOT return control to caller.
*        This routine ends here, no error possible.

*------------------------------------------------*
* Init New Proc Desc:
* Link or Load Primary Module:

L04B1    pshs  a,b,x,y,u
         ldd   <D.Proc    proc desc
         pshs  a,b        save it
         stx   <D.Proc    temp proc
         lda   R$A,u      type
         ldx   R$X,u      name
         ldy   ,s         new proc desc
         leay  P$DATImg,y Y=new images
         os9   F$SLink    link in primary mod
         bcc   L04D7      ..ok

         ldd   ,s         else restore old proc
         std   <D.Proc
         ldu   4,s        get new proc desc
         os9   F$Load     use sys f$load
         bcc   L04D7      ..ok
         leas  4,s        else drop junk
         puls  x,y,u,pc   return err.

*------------------------------------------------*
L04D7    stu   2,s        save mod address
         pshs  a,y        save mod type,entry
         ldu   $0B,s      U=usr regs (old P$SP)
         stx   R$X,u      update name ptr
         ldx   7,s        set new process desc
         stx   <D.Proc
         ldd   5,s        set primary module addrss
         std   P$PModul,x
         puls  a          module type
         cmpa  #Prgrm+Objct is it program module?
         beq   L04FB      ..yes
         cmpa  #Systm+Objct is it system module?
         beq   L04FB      ..yes

         ldb   #E$NEMod   'Non-Executable Module'
L04F4    leas  2,s        drop return
         stb   3,s        return err code
         comb             set err
         bra   L053E      restore proc desc & rts.

*------------------------------------------------*
* Allocate data memory and set child regs:

L04FB    ldd   #M$Mem     offset to mem size
         leay  P$DATImg,x image
         ldx   P$PModul,x mod address
         os9   F$LDDDXY   get mem size
         cmpa  R$B,u      greater than user request?
         bcc   L050E      ..yes
         lda   R$B,u      no, use request
         clrb             to page boundary
L050E    os9   F$Mem      get U=data memory
         bcs   L04F4      ..err

         ldx   6,s        parent proc desc
         leay  P$Stack-R$Size,x
         pshs  a,b        save mem size
         subd  R$Y,u      -parm size
         std   R$X,y      is new parm pointer
         subd  #R$Size    memsize-reg stack
         std   P$SP,x     is new stack pointer

         ldd   R$Y,u      get parm size
         std   R$D,y      D is parm size
         std   6,s        return to caller
         puls  a,b,x      mem and entry
         std   R$Y,y      Y is end of data mem
         ldd   R$U,u      parm ptr
         std   6,s        return
         lda   #Entire    CC register is full rti
         sta   R$CC,y     set cc reg
         clra  
         sta   R$DP,y     DP is 00
         clrb  
         std   R$U,y      U is data address
         stx   R$PC,y     PC is module exec address

L053E    puls  a,b        restore proc desc
         std   <D.Proc
         puls  a,b,x,y,u,pc return.

*------------------------------------------------*
*                     F$Exit
*------------------------------------------------*
FExit    ldx   <D.Proc    proc desc
         bsr   L05A5      close paths & return memory
         ldb   R$B,u      get exit signal
         stb   P$Signal,x and save in proc desc
         leay  P$CID-P$SID,x parent id
         bra   L0563      go find kids...

*------------------------------------------------*
L0551    clr   P$SID,y    clear sibling pointer
         lbsr  L0B2E      find its proc desc
         clr   P$PID,y    clear its parent ptr (us)
         lda   P$State,y  get child's state
         bita  #Dead      is it dead?
         beq   L0563      ..no
         lda   P$ID,y     else get its id
         lbsr  L0386      and destroy its proc desc
L0563    lda   P$SID,y    did it have a sibling?
         bne   L0551      ..yes,loop

         leay  ,x         kid's proc desc
         ldx   #D.WProcQ-P$Queue
         lds   <D.SysStk  use system stack
         pshs  cc         save CC
         orcc  #IntMasks  halt interrupts while queuing
         lda   P$PID,y    get our parent id
         bne   L0584      ..and wake him up

         puls  cc         restore CC
         lda   P$ID,y     our id
         lbsr  L0386      give up our proc desc
         bra   L05A2      and start next active process.

*------------------------------------------------*
* Search For Waiting Parent:

L0580    cmpa  P$ID,x     is proc desc our parent's?
         beq   L0592      ..yes!

L0584    leau  ,x         U is base desc
         ldx   P$Queue,x  X is next waiter
         bne   L0580      see if parent
         puls  cc         restore CC
         lda   #SysState+Dead set us to system state
         sta   P$State,y  and mark us as dead
         bra   L05A2      so F$Wait will find us; next proc.

* Found Parent (X):

L0592    ldd   P$Queue,x  take parent out of  wait queue
         std   P$Queue,u
         puls  cc         restore CC
         ldu   P$SP,x     get parents reg stack
         ldu   R$U,u
         lbsr  L036C      get child's death signal to parent
         os9   F$AProc    move parent to active queue
L05A2    os9   F$NProc    start next proc in active queue.

*------------------------------------------------*
* Close Proc I/O Paths & Unlink Mem:

L05A5    pshs  u          save
         ldb   #NumPaths  B=up to 16 paths
         leay  P$Path,x   point to proc desc paths
L05AC    lda   ,y+        get path desc#
         beq   L05B9      ..skip if not used
         clr   -1,y       else clr it
         pshs  b          save cnt
         os9   I$Close    close path
         puls  b
L05B9    decb             count-1
         bne   L05AC      ..loop

         clra             begin block=00
         ldb   P$PagCnt,x any memory used?
         beq   L05CB      ..no
         addb  #$1F       round up mem
         lsrb             mem/16 = blocks used
         lsrb  
         lsrb  
         lsrb  
         lsrb  
         os9   F$DelImg   return mem
L05CB    ldd   <D.Proc    save current proc
         pshs  a,b
         stx   <D.Proc    set bad proc
         ldu   P$PModul,x pgrm ptr
         os9   F$Unlink   unlink aborted pgrm
         puls  a,b,u
         std   <D.Proc    reset parent proc
         os9   F$DelTsk   release X's task#
         rts              .

*------------------------------------------------*
*                     F$Mem
*------------------------------------------------*
FMem     ldx   <D.Proc    proc
         ldd   R$D,u      get mem request
         beq   L0638      ..return current size request
         addd  #$00FF     else round up size
         bcc   L05EE      ..okay if <64K
         ldb   #E$MemFul  'Memory Full'
         bra   L0629      ..err end

L05EE    cmpa  P$PagCnt,x same as current?
         beq   L0638      ..yes
         pshs  a          save amt
         bcc   L0602      ..go for more mem

         deca             go for less mem
         ldb   #$F4       enuf room for SP?
         cmpd  P$SP,x
         bcc   L0602      ..yes
         ldb   #E$DelSP   'Suicide Attempt'
         bra   L0627

L0602    lda   P$PagCnt,x get current size
         adda  #$1F       round up
         lsra             A/16 = block cnt
         lsra  
         lsra  
         lsra  
         lsra  
         ldb   ,s         B=pages wanted
         addb  #$1F       round up
         bcc   L0615      ..ok
         ldb   #E$MemFul  'Memory Full'
         bra   L0627

L0615    lsrb             B/16 = blocks wanted
         lsrb  
         lsrb  
         lsrb  
         lsrb  
         pshs  a          save #blocks now
         subb  ,s+        B=# difference
         beq   L0634      ..same
         bcs   L062C      ..less
         os9   F$AllImg   else get mem
         bcc   L0634      ..err

* Error ends:

L0627    leas  1,s
L0629    orcc  #Carry
         rts   

*------------------------------------------------*
* Need Less Mem:

L062C    pshs  b          save amt less
         adda  ,s+        + amt now
         negb  
         os9   F$DelImg   return mem blocks
L0634    puls  a          get new amt
         sta   P$PagCnt,x set in proc desc

* Return Mem Size to user:

L0638    lda   P$PagCnt,x D=byte count
         clrb  
         std   R$D,u      return size
         std   R$Y,u      and upper bound
         rts   

*------------------------------------------------*
*                     F$Send
*------------------------------------------------*
FSend    ldx   <D.Proc    proc desc
         lda   R$A,u      A=dest proc
         bne   L0652      ..send if <> 00
         inca             else send to all ('cept zero)
L0647    cmpa  ,x         our proc?
         beq   L064D      ..skip if is
         bsr   L0652      else send signal
L064D    inca             ID+1
         bne   L0647      done 255?
         clrb             yep
         rts              end.

*------------------------------------------------*
* Send signal to Proc A:

L0652    lbsr  L0B2E      find proc desc
         pshs  cc,a,y,u
         bcs   L066A      ..not found
         tst   R$B,u      is signal = zero? (Kill)
         bne   L066D      ..no
         ldd   P$User,x   are we superuser?
         beq   L066D      ..yes
         cmpd  P$User,y   else same user?
         beq   L066D      ..yes
         ldb   #E$IPrcID  'Illegal Proc ID'
         inc   ,s         set carry bit
L066A    lbra  L06F4

L066D    orcc  #IntMasks  stop interrupts
         ldb   R$B,u      B=signal
         bne   L067B      skip if not Kill

         ldb   #E$PrcAbt  'Keyboard Abort' (#2)
         lda   P$State,y
         ora   #Condem    condemn process
         sta   P$State,y

* Wake Up Dest Process:

L067B    lda   P$State,y
         anda  #^Suspend  (F7) drop suspend
         sta   P$State,y  state
         lda   P$Signal,y have signal now?
         beq   L068F      ..no
         deca             else was it wake?
         beq   L068F      ..yes
         inc   ,s         set carry
         ldb   #E$USigP   'Signal Error'
         bra   L06F4

L068F    stb   P$Signal,y save signal
         ldx   #D.SProcQ-P$Queue search sleep queue
         clra             ticks left=0000
         clrb  

L0697    leay  ,x         Y is base desc
         ldx   P$Queue,x  X is next qproc
         beq   L06D3      ..last
         ldu   P$SP,x     else get process
         addd  R$X,u      add ticks
         cmpx  2,s        same as dest proc desc?
         bne   L0697      ..no, loop

         pshs  a,b        save tick count
         lda   P$State,x  is process time sleeping?
         bita  #TimSleep
         beq   L06CF      ..no it's not

         ldd   ,s         get tick count
         beq   L06CF      ..bra if none
         ldd   R$X,u      get time left
         pshs  a,b        save it
         ldd   2,s        get ticks left
         std   R$X,u      make it new time left
         puls  a,b        tick count
         ldu   P$Queue,x  qproc after this one?
         beq   L06CF      ..no
         std   ,s
         lda   P$State,u  time sleeping?
         bita  #TimSleep
         beq   L06CF      ..no its not

         ldu   P$SP,u     next proc SP
         ldd   ,s         update tick count
         addd  R$X,u
         std   R$X,u

L06CF    leas  2,s        drop
         bra   L06E0      give signal...

*------------------------------------------------*
L06D3    ldx   #D.WProcQ-P$Queue search wait queue
L06D6    leay  ,x         base proc desc
         ldx   P$Queue,x  get next in queue
         beq   L06F4      ..end if none
         cmpx  2,s        signal dest proc?
         bne   L06D6      ..no

L06E0    ldd   P$Queue,x  take proc out of queue
         std   P$Queue,y
         lda   P$Signal,x has signal
         deca             other than S$Wake?
         bne   L06F1      ..yes
         sta   P$Signal,x no, clear for wakeup
         lda   ,s         restore CC
         tfr   a,cc
L06F1    os9   F$AProc    insert proc in active queue
L06F4    puls  cc,a,y,u,pc return.

*------------------------------------------------*
*                     F$Icpt
*------------------------------------------------*
FIcpt    ldx   <D.Proc    proc desc
         ldd   R$X,u      set signal vector
         std   P$SigVec,x
         ldd   R$U,u      and data area
         std   P$SigDat,x
         clrb             ok
         rts              end.

*------------------------------------------------*
*                     F$Sleep
*------------------------------------------------*
FSleep   pshs  cc         save int masks
         ldx   <D.Proc    proc desc
         orcc  #IntMasks  stop interrupts here
         lda   P$Signal,x have unprocessed signal?
         beq   L0722      ..no
         deca             yes, was it Wake?
         bne   L0715      ..no
         sta   P$Signal,x yes, ignore it

L0715    lda   P$STATE,X
         anda  #^SUSPEND  DROP SUSPEND
         sta   P$STATE,X

L071B    puls  cc         restore CC
         os9   F$AProc    activate immediately
         bra   L0780

* Do the Sleep:

L0722    ldd   R$X,u      sleep forever?
         beq   L076D      ..yes
         subd  #$0001     else -1 already
         std   R$X,u      save tick cnt

         beq   L071B      ..awake if was just 1
         pshs  x,y        save
         ldx   #D.SProcQ-P$Queue

L0732    std   R$X,u      return tick count
         stx   2,s        temp var
         ldx   P$Queue,x  X=next queue proc
         beq   L074F      ..end of line
         lda   P$State,x  is it still
         bita  #TimSleep  asleep?
         beq   L074F      ..no
         ldy   P$SP,x     yes, get its
         ldd   R$X,u      X register and
         subd  R$X,y      compare to ours
         bcc   L0732      ..try next if we're more

         nega             else negate count
         negb  
         sbca  #$00
         std   R$X,y      and update proc sleep ticks
L074F    puls  x,y        queue proc ptrs
         lda   P$State,x  set proc as
         ora   #TimSleep  tick sleeping
         sta   P$State,x
         ldd   P$Queue,y  insert us in queue
         stx   P$Queue,y
         std   P$Queue,x
         ldx   R$X,u      get ticks requested
         bsr   L0780      go wait for wakeup

         stx   R$X,u      return ticks left
         ldx   <D.Proc
         lda   P$State,x  drop sleep flag
         anda  #^TimSleep
         sta   P$State,x
         puls  cc,pc      return to caller.

*------------------------------------------------*
L076D    ldx   #D.SProcQ-P$Queue start at first asleep

L0770    leay  ,x         Y is base proc
         ldx   P$Queue,x  X is next qproc
         bne   L0770      ..not last yet
         ldx   <D.Proc    else get our proc
         clra             D=0000
         clrb  
         stx   P$Queue,y  put us at end of queue
         std   P$Queue,x  and mark none after us now
         puls  cc         restore CC

*------------------------------------------------*
* Wait for Signal/Wakeup:

L0780    pshs  x,y,u,pc   make vars
         leax  <L079C,pcr point to wakeup code
         stx   6,s        put as rts pcr
         ldx   <D.Proc
         ldb   P$Task,x   are we sys proc?
         cmpb  <D.SysTsk
         beq   L0792      ..yes
         os9   F$DelTsk   else release task#
L0792    ldd   P$SP,x     save stack pointer
         pshs  cc,a,b,dp
         sts   P$SP,x     and temp SP
         os9   F$NProc    go do next proc.

*------------------------------------------------*
* Proc Wakes up here:

L079C    pshs  x          save tick count
         ldx   <D.Proc
         std   P$SP,x     restore real SP
         clrb             ok
         puls  x,pc       return from sleep.

*------------------------------------------------*
*                     F$SPrior
*------------------------------------------------*
FSprior  lda   R$A,u      get id
         lbsr  L0B2E      find proc desc
         bcs   L07C0      ..err
         ldx   <D.Proc    get our user index
         ldd   P$User,x
         beq   L07B7      ..zero is ok
         cmpd  P$User,y   same as id?
         bne   L07BD      ..no, err
L07B7    lda   R$B,u      get desired priority
         sta   P$Prior,y  set it in id
         clrb             ok
         rts              end.

L07BD    comb  
         ldb   #E$IPrcID  'Illegal Process ID'
L07C0    rts   

*------------------------------------------------*
*                     F$ID
*------------------------------------------------*
FID      ldx   <D.Proc    proc desc
         lda   P$ID,x     get id
         sta   R$A,u      return it
         ldd   P$User,x   and user
         std   R$Y,u      index to caller
         clrb             ok
         rts              end.

*------------------------------------------------*
*                     F$SSWI
*------------------------------------------------*
FSSWI    ldx   <D.Proc    proc desc
         leay  P$SWI,x    point to SWI vectors
         ldb   R$A,u      B=swi to set
         decb             B-1
         cmpb  #$03       0-2?
         bcc   L07DF      ..no, err
         aslb             else index
         ldx   R$X,u      get new vector
         stx   b,y        and set it
         rts              end.

L07DF    comb  
         ldb   #E$ISWI    'Illegal SWI code'
         rts   

*------------------------------------------------*
*                     F$STime
*------------------------------------------------*
ClockNam fcs   "Clock"

FSTime   ldx   R$X,u      X=time packet
         tfr   dp,a       A=DP
         ldb   #D.Time    B=sys time addrss
         tfr   d,u        U=sys time location
         ldy   <D.Proc
         lda   P$Task,y   A=from tsk#
         ldb   <D.SysTsk  B=to (sys) tsk#
         ldy   #$0006     copy over time data
         os9   F$Move     X(A)-->U(B) *Y
         ldx   <D.Proc    save user proc
         pshs  x
         ldx   <D.SysPrc  make sys for link
         stx   <D.Proc
         leax  ClockNam,pcr link to Clock
         lbsr  SysLink
         puls  x
         stx   <D.Proc    restore user proc
         bcs   L0816      ..err end
         jmp   ,y         else go do Clock init.

L0816    rts   

*------------------------------------------------*
*                     F$AllBit
*------------------------------------------------*
FAllBit  ldd   R$D,u      number of first bit
         ldx   R$X,u      map address
         bsr   L086E      get X=addrss, A=mask
         ldy   <D.Proc    proc desc
         ldb   P$Task,y   use usr map
         bra   L082C

SAllBit  ldd   R$D,u      number of first bit
         ldx   R$X,u      map address
         bsr   L086E      get X=addrss, A=mask
         ldb   <D.SysTsk  use sys map

L082C    ldy   R$Y,u      Y=number of bits
         beq   L086C      ..none
         sta   ,-s        save mask
         bmi   L0847      skip if no bit0
         os9   F$LDABX    get map byte
L0838    ora   ,s         set bit
         leay  -1,y       count-1
         beq   L0867      ..quik end if last
         lsr   ,s         next bit
         bcc   L0838      ..loop if not bit7

         os9   F$STABX    else store map byte
         leax  1,x        map addrss+1

L0847    lda   #$FF       now quik set byte at a time
         bra   L0852

*------------------------------------------------*
* Byte at a Time:

L084B    os9   F$STABX    store map byte
         leax  1,x        map addrss+1
         leay  -8,y       bit count-8/byte

L0852    cmpy  #$0008     under 8 bits to go?
         bhi   L084B      ..no, continue byte at a time
         beq   L0867      ..exactly one byte left

* Last byte:

L085A    lsra             move mask into pos
         leay  -1,y       for last byte
         bne   L085A      ..

         coma             fix mask
         sta   ,s         save it
         os9   F$LDABX    get last map byte
         ora   ,s         set last bits
L0867    os9   F$STABX    update last map byte
         leas  1,s        drop mask
L086C    clrb             okay
         rts              return.

*------------------------------------------------*
L086E    pshs  b,y        save regs & low order 0-7
         lsra  
         rorb             D/8
         lsra  
         rorb  
         lsra  
         rorb  
         leax  d,x        X=byte address
         puls  b          B=low order
         leay  <L0883,pcr table of A shifted
         andb  #$07       B=bit count
         lda   b,y        get mask for A
         puls  y,pc       return.

*------------------------------------------------*
* Mask Table:

L0883    fcb   $80
         fcb   $40
         fcb   $20
         fcb   $10
         fcb   $08
         fcb   $04
         fcb   $02
         fcb   $01

*------------------------------------------------*
*                     F$DelBit
*------------------------------------------------*
FDelBit  ldd   R$A,u
         ldx   R$X,u
         bsr   L086E
         ldy   <D.Proc
         ldb   P$Task,y
         bra   L08A0

SDelBit  ldd   R$A,u
         ldx   R$X,u
         bsr   L086E
         ldb   <D.SysTsk

L08A0    ldy   R$Y,u
         beq   L08E0
         coma  
         sta   ,-s
         bpl   L08BC
         os9   F$LDABX
L08AD    anda  ,s
         leay  -1,y
         beq   L08DB
         asr   ,s
         bcs   L08AD
         os9   F$STABX
         leax  1,x
L08BC    clra  
         bra   L08C6

*------------------------------------------------*
L08BF    os9   F$STABX
         leax  1,x
         leay  -8,y
L08C6    cmpy  #8
         bhi   L08BF
         beq   L08DB
         coma  
L08CF    lsra  
         leay  -1,y
         bne   L08CF
         sta   ,s
         os9   F$LDABX
         anda  ,s
L08DB    os9   F$STABX
         leas  1,s
L08E0    clrb  
         rts   

*------------------------------------------------*
*                     F$SchBit
*------------------------------------------------*
FSchBit  ldd   R$D,u      search start bit #
         ldx   R$X,u      map address
         bsr   L086E      set byte mask
         ldy   <D.Proc    use user map
         ldb   P$Task,y
         bra   L08F8      do it

SSchBit  ldd   R$D,u      search start bit #
         ldx   R$X,u      map address
         lbsr  L086E      set byte mask
         ldb   <D.SysTsk  use sys map

L08F8    pshs  cc,a,b,x,y,u
         clra             D=0000
         clrb  
         std   3,s
         ldy   R$D,u
         sty   7,s
         bra   L0911

*------------------------------------------------*
L0906    sty   7,s
L0909    lsr   1,s
         bcc   L091C
         ror   1,s
         leax  1,x
L0911    cmpx  R$U,u      end of map?
         bcc   L093A      ..yes
         ldb   2,s
         os9   F$LDABX
         sta   ,s
L091C    leay  1,y
         lda   ,s
         anda  1,s
         bne   L0906

         tfr   y,d
         subd  7,s
         cmpd  R$Y,u
         bcc   L0943
         cmpd  3,s
         bls   L0909
         std   3,s
         ldd   7,s
         std   5,s
         bra   L0909

L093A    ldd   3,s
         std   R$Y,u
         comb  
         ldd   5,s
         bra   L0945

L0943    ldd   7,s
L0945    std   R$D,u
         leas  9,s
         rts   

*------------------------------------------------*
*                     F$GPrDsc
*------------------------------------------------*
FGprDsc  ldx   <D.Proc    proc desc
         ldb   P$Task,x   B=dest task#
         lda   R$A,u      A=desired ID
         os9   F$GProcP   get B=ptr to proc desc
         bcs   L0962
         lda   <D.SysTsk  A=from tsk#
         leax  ,y         X=proc desc
         ldy   #P$Size    512 bytes
         ldu   R$X,u      U=dest buffer
         os9   F$Move     X(A)-->U(B) *Y
L0962    rts              end.

*------------------------------------------------*
*                     F$GBlkMp
*------------------------------------------------*
FGblkMp  ldd   #$2000     RETURN 8K BLOCK SIZE
         std   R$D,u
         ldd   <D.BlkMap+2 return blk map size
         subd  <D.BlkMap
         std   R$Y,u
         tfr   d,y        Y=count
         lda   <D.SysTsk  A=from sys
         ldx   <D.Proc
         ldb   P$Task,x   B=to user
         ldx   <D.BlkMap  X=block map
         ldu   R$X,u      U=dest buffer
         os9   F$Move     X(A)-->U(B) *Y
         rts   

*------------------------------------------------*
*                     F$GModDr
*------------------------------------------------*
FGModDr  ldd   <D.ModDir+2 D=end of moddir
         subd  <D.ModDir  -begin
         tfr   d,y        Y=size
         ldd   <D.ModEnd  D=top of dir stack
         subd  <D.ModDir  D=size
         ldx   R$X,u      X=dest buffer
         leax  d,x        plus size
         stx   R$Y,u      return size to user
         ldx   <D.ModDir  and moddir
         stx   R$U,u      address

         lda   <D.SysTsk  A=sys task
         ldx   <D.Proc    B=usr task
         ldb   P$Task,x
         ldx   <D.ModDir  X=moddir
         ldu   R$X,u      U=dest buffer
         os9   F$Move     X(A)-->U(B) *Y
         rts              end.

*------------------------------------------------*
*                     F$SUser
*------------------------------------------------*
FSUser   ldx   <D.Proc    proc desc
         ldd   R$Y,u      D=user num
         std   P$User,x   set it
         clrb             ok
         rts              end.

*------------------------------------------------*
*                     F$CpyMem
*------------------------------------------------*
FCpyMem  ldd   R$Y,u      byte count
         beq   L0A01      ..skip if none
         addd  R$U,u      plus dest buff
         bcs   L0A01
         leas  -$10,s
         leay  ,s
         pshs  a,b,y      save buff end,img ptr
         ldx   <D.Proc
         ldb   P$Task,X
         pshs  b          save caller task#
         leay  P$DATImg,x
         ldx   R$D,u      X=caller DAT img ptr
         ldb   #8
         pshs  b,u
         ldu   P$Task,s   U=tempdat ptr

L09C7    clra             D=0000
         clrb  
         os9   F$LDDDXY   move user DAT image
         std   ,u++       to sys tempDAT img
         leax  2,x
         dec   ,s
         bne   L09C7      ..loop

         puls  b,u
         ldx   R$X,u      X=offset
         ldu   R$U,u      U=dest buffer
         ldy   3,s        Y=tmpDAT

         puls  b
         bra   L09E7

N09D6    leax  $E000,x
         leay  2,y

*------------------------------------------------*
* Copy Loop:

L09E7    cmpx  #$2000
         bcc   N09D6

L09EC    os9   F$LDAXY    get byte
         leax  1,x
         exg   x,u

         os9   F$STABX    store byte
         leax  1,x        plus one
         cmpx  ,s
         exg   x,u
         bcs   L09E7
         leas  $14,s

L0A01    clrb             ok
         rts              end.

*------------------------------------------------*
*                     F$UnLoad
*------------------------------------------------*
FUnload  pshs  u
         lda   R$A,u      A=type
         ldx   <D.Proc    proc desc
         leay  P$DATImg,x images ptr
         ldx   R$X,u      X=name
         os9   F$FModul   find the module
         puls  y          reg stack
         bcs   L0A4F      ..err

         stx   R$X,y      update name ptr
         ldx   MD$Link,u  get module link cnt
         beq   L0A21      ..zero
         leax  -1,x       else decrement it
         stx   MD$Link,u
         bne   L0A4E      ..skip if still in use

L0A21    cmpa  #FlMgr     system module?
         bcs   L0A4B      ..no

         clra  
         ldx   [MD$MPDAT,u] get module block
         ldy   <D.SysDAT  check against sys map
L0A2B    adda  #$02       next offset
         cmpa  #DAT.ImSz  last?
         bcc   L0A4B      ..yes
         cmpx  a,y        else found right img?
         bne   L0A2B      ..no, loop

         asla             A/8 block# -->address
         asla  
         asla  
         asla  
         clrb  
         addd  MD$MPtr,u  point to module
         tfr   d,x
         os9   F$IODel    delete I/O module
         bcc   L0A4B      ..ok

         ldx   MD$Link,u  else if error,
         leax  1,x
         stx   MD$Link,u  increment link cnt
         bra   L0A4F

L0A4B    lbsr  L01D5      clear moddir entry
L0A4E    clrb             ok
L0A4F    rts              end.

*------------------------------------------------*
*                     F$Find64
*------------------------------------------------*
FFind64  lda   R$A,u      get pd block number
         ldx   R$X,u      get block address
         bsr   L0A5C      find it
         bcs   L0A5B      ..err
         sty   R$Y,u      return address
L0A5B    rts              end.

* Find Path/Process Descriptor:

L0A5C    pshs  a,b        save number, make space
         tsta             number=zero?
         beq   L0A70      ..yes,bad
         clrb             else...
         lsra             number/4
         rorb             (point to block ptr)
         lsra  
         rorb  
         lda   a,x        use index to get
         tfr   d,y        block address
         beq   L0A70      ..none
         tst   ,y         is block in use?
         bne   L0A71      ..yes, okay!
L0A70    coma             set error
L0A71    puls  a,b,pc     return.

*------------------------------------------------*
*                     F$All64
*------------------------------------------------*
FAll64   ldx   R$X,u      get base page
         bne   L0A7F      ..okay if have one
         bsr   L0A89      else allocate page
         bcs   L0A88      ..err
         stx   ,x         insert first page flag
         stx   R$X,u      return base page
L0A7F    bsr   L0A9F      get one 64-byte block
         bcs   L0A88      ..err
         sta   R$A,u      return block number
         sty   R$Y,u      return block address
L0A88    rts              end.

*------------------------------------------------*
* Allocate Base Block:

L0A89    pshs  u          save U
         ldd   #$0100     get 256-byte page
         os9   F$SRqMem
         leax  ,u         X=page address
         puls  u
         bcs   L0A9E      ..err
         clra             A=00
         clrb             256 byte count
L0A99    sta   d,x        clear block
         incb  
         bne   L0A99
L0A9E    rts   

*------------------------------------------------*
* Find & Set Block In Use:

L0A9F    pshs  x,u
         clra  
L0AA2    pshs  a
         clrb  
         lda   a,x
         beq   L0AB4
         tfr   d,y
         clra  
L0AAC    tst   d,y
         beq   L0AB6
         addb  #64
         bcc   L0AAC
L0AB4    orcc  #Carry
L0AB6    leay  d,y
         puls  a
         bcc   L0AE1
         inca             try all pages
         cmpa  #64        until 64th page
         bcs   L0AA2

         clra  
L0AC2    tst   a,x
         beq   L0AD0
         inca  
         cmpa  #64
         bcs   L0AC2

         comb  
         ldb   #E$PthFul  'Path Table Full'
         bra   L0AEE

*------------------------------------------------*
L0AD0    pshs  a,x
         bsr   L0A89
         bcs   L0AF0
         leay  ,x
         tfr   x,d
         tfr   a,b
         puls  a,x
         stb   a,x
         clrb  

* D=Block Address:

L0AE1    aslb  
         rola  
         aslb  
         rola  

         ldb   #$3F

* Clear Block:

L0AE7    clr   b,y
         decb  
         bne   L0AE7
         sta   ,y
L0AEE    puls  x,u,pc     okay rts.

L0AF0    leas  3,s        drop vars
         puls  x,u,pc     return.

*------------------------------------------------*
*                     F$Ret64
*------------------------------------------------*
FRet64   lda   R$A,u
         ldx   R$X,u
         pshs  a,b,x,y,u
         clrb  
         tsta  
         beq   L0B22
         lsra  
         rorb  
         lsra  
         rorb  
         pshs  a
         lda   a,x
         beq   L0B20
         tfr   d,y
         clr   ,y
         clrb  
         tfr   d,u
         clra  
L0B10    tst   d,u
         bne   L0B20
         addb  #64
         bne   L0B10
         inca  
         os9   F$SRtMem
         lda   ,s
         clr   a,x
L0B20    clr   ,s+
L0B22    puls  a,b,x,y,u,pc

*------------------------------------------------*
*                     F$GProcP
*------------------------------------------------*
FGProcP  lda   R$A,u      get id
         bsr   L0B2E      find proc esc
         bcs   L0B2D      ..err
         sty   R$Y,u      return pointer
L0B2D    rts              end.

*------------------------------------------------*
*   Find Process Descriptor A, address --> Y:

L0B2E    pshs  a,b,x      save id, etc
         ldb   ,s         B=id
         beq   L0B40      ..can't be zero
         ldx   <D.PrcDBT  proc desc table
         abx              index
         lda   ,x         get pointer
         beq   L0B40      ..err if none by that id
         clrb             else make address
         tfr   d,y        return in Y
         puls  a,b,x,pc   end.

L0B40    puls  a,b,x
         comb  
         ldb   #E$IPrcId
         rts   

*------------------------------------------------*
*                     F$DelImg
*------------------------------------------------*
FDelImg  ldx   R$X,u      X=proc desc
         ldd   R$D,u      A=start, B=count
         leau  P$DATImg,x U=image table
         asla             index first
         leau  a,u        point to it
         clra  
         tfr   d,y        Y=count
         pshs  x          save desc

L0B55    ldd   0,u        D=block number
         addd  <D.BlkMap  plus map begin
         tfr   d,x        X=map address
         lda   ,x         get marker
         anda  #^RAMinUse release mem
         sta   ,x
         ldd   #DAT.Free  flag image
         std   ,u++       as free
         leay  -1,y       count-1
         bne   L0B55      ..loop

         puls  x          proc desc
         lda   P$State,x
         ora   #ImgChg    flag image change
         sta   P$State,x
         clrb             okay
         rts              end.

*------------------------------------------------*
*                     F$MapBlk
*------------------------------------------------*
FMapBlk  lda   R$B,u      get number of blocks

         beq   L0BAA      <NEW>

         cmpa  #DAT.BlCt  over 16? (8 ON COCO)
         bhi   L0BAA      ..err WAS BCC

         leas  -$10,s
         ldx   R$X,u      beginning block# desired
         leay  ,s         point to local vars
         ldb   #1         ++BGP
L0B82    stx   ,y++       put images
*         leax  1,x        desired on
         abx              ++BGP
         deca             the local stack
         bne   L0B82

         ldb   R$B,u      number of blocks
         ldx   <D.Proc    point to process's
         leay  P$DATImg,x image map
         os9   F$FreeHB   find contiguous blocks free
         bcs   L0BA6      ..err
         pshs  a,b        save begin free#,amt
         asla             first free*16 = mem address
         asla  
         asla  
         asla  
         asla  
         clrb  
         std   R$U,u      return addrss of first block
         puls  a,b        drop
         leau  ,s         point to images wanted
         os9   F$SetImg   map them into callers space
L0BA6    leas  $10,S
         rts              return.

L0BAA    comb             set err
         ldb   #E$IBA     'Illegal Block Address'
         rts              return.

*------------------------------------------------*
*                     F$ClrBlk
*------------------------------------------------*
FClrBlk  ldb   R$B,u      B=block count
         beq   L0BE9      ..zero
         ldd   R$U,u      D=first block addrss
         tstb  
         bne   L0BAA      ..must be even page
         bita  #$1F
         bne   L0BAA      ..and on 4k boundary
         ldx   <D.Proc    get proc desc
         lda   P$SP,x     and it's SP
         anda  #$E0
         suba  R$U,u      -mem
         bcs   L0BCE      ..err if sp mem
         lsra             address -> block#
         lsra  
         lsra  
         lsra  
         lsra  
         cmpa  R$B,u      end of mem?
         bcs   L0BAA      ..error
L0BCE    lda   P$State,x  mark image change
         ora   #ImgChg
         sta   P$State,x
         lda   R$U,u      get mem ptr
         lsra             index as image ptr
         lsra  
         lsra  
         lsra  
         leay  P$DATImg,x proc images
         leay  a,y        point to block image
         ldb   R$B,u      get block count
         ldx   #DAT.Free  free flag
L0BE4    stx   ,y++       clear image(s)
         decb  
         bne   L0BE4
L0BE9    clrb             okay
         rts              end.

*------------------------------------------------*
*                     F$DelRam
*------------------------------------------------*
FDelRam  ldb   R$B,u      get block count
         beq   L0C11      ..zero
         ldd   <D.BlkMap+2 end of block map
         subd  <D.BlkMap  D=max block#
         subd  R$X,u      cmp to desired block#
         bls   L0C11      ..bad number

         tsta             close to end of map?
         bne   L0C00      ..no
         cmpb  R$B,u      block cnt easy?
         bcc   L0C00      ..no
         stb   R$B,u      save block cnt lsb
L0C00    ldx   <D.BlkMap  point to block map
         ldd   R$X,u      get start block#
         leax  d,x        index into map
         ldb   R$B,u      get count
L0C08    lda   ,x         get block flag
         anda  #^RAMinUse release for use
         sta   ,x+
         decb             count-1
         bne   L0C08      ..'til done.

L0C11    clrb             okay
         rts              end.

*------------------------------------------------*
*                     F$GCMDir
*------------------------------------------------*
FGCMDir  ldx   <D.ModDir  module dir ptr
         bra   L0C1D      ..do garbage collect

L0C17    ldu   ,x         get DAT entry
         beq   L0C23      ..empty
         leax  MD$ESize,x else point to next

L0C1D    cmpx  <D.ModEnd  end of dir?
         bne   L0C17      ..no, loop
         bra   L0C4B      yes, do it

L0C23    tfr   x,y        Y=entry
         bra   L0C2B      ..do it

L0C27    ldu   ,y         get DAT entry
         bne   L0C34      ..in use
L0C2B    leay  MD$ESize,y point to next entry
         cmpy  <D.ModEnd  last?
         bne   L0C27      ..no
         bra   L0C49      do it.

* Move Entries Up:

L0C34    ldu   ,y++       2
         stu   ,x++
         ldu   ,y++       4
         stu   ,x++
         ldu   ,y++       6
         stu   ,x++
         ldu   ,y++       8 bytes
         stu   ,x++
         cmpy  <D.ModEnd  end of dir?
         bne   L0C27      ..no

L0C49    stx   <D.ModEnd  set new dir end
L0C4B    ldx   <D.ModDir+2 end of dir
         bra   L0C53

L0C4F    ldu   ,x         get entry
         beq   L0C5B      ..not used
L0C53    leax  -2,x       back up in entry
         cmpx  <D.ModDAT  end?
         bne   L0C4F      ..no
         bra   L0C93      else end if all done.

L0C5B    ldu   -2,x
         bne   L0C53
         tfr   x,y
         bra   L0C67

L0C63    ldu   ,y         get entry
         bne   L0C70
L0C67    leay  -2,y
L0C69    cmpy  <D.ModDAT
         bcc   L0C63
         bra   L0C81

L0C70    leay  2,y        go back
         ldu   ,y         do last entry
         stu   ,x
L0C76    ldu   ,--y
         stu   ,--x
         beq   L0C87
         cmpy  <D.ModDAT  end?
         bne   L0C76      ..no
L0C81          
         stx   <D.ModDAT  set new end
         bsr   L0C95      change images
         bra   L0C93      end.

L0C87    leay  2,y
         leax  2,x
         bsr   L0C95
         leay  -4,y
         leax  -2,x
         bra   L0C69
L0C93    clrb             okay
         rts              end.

*------------------------------------------------*
* Update Module Dir Image Ptrs:

L0C95    pshs  u
         ldu   <D.ModDir  module dir start
         bra   L0CA4

L0C9B    cmpy  MD$MPDAT,u same DAT ptrs?
         bne   L0CA2      ..no, skip
         stx   MD$MPDAT,u else update ptr
L0CA2    leau  MD$ESize,u next entry
L0CA4    cmpu  <D.ModEnd  last entry?
         bne   L0C9B      ..no
         puls  u,pc       yes, return.

         emod  
endmod   equ   *
         end   

