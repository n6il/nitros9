********************************************************************
* IOMan - OS-9 Level Two V3 I/O Manager
*
* $Id$
*
* Ed.    Comments                                       Who YY/MM/DD
* ------------------------------------------------------------------
* ??     Cleaned up some formatting                     KDM 87/05/15
* 14     IOMAN ignores device address high byte now     ??? ??/??/??
*        (FFXXXX vs 07XXXX etc ignored)
* 15     Fixed IOQueue sort bug                         BGP 98/10/08
* 15r2   Made minor optimizations as per Curtis Boyle's BGP 98/10/10
*        optimization document 
*        Added comments from version provided by        BGP 98/10/21
*        Curtis Boyle
* 15r3   Fixed IDetach static storage wipeout bug       BGP 02/05/11

         nam   IOMan
         ttl   OS-9 Level Two V3 I/O Manager

         ifp1  
         use   defsfile
         use   scfdefs
         endc  

tylg     set   Systm+Objct
atrv     set   ReEnt+rev
rev      set   $03
edition  set   15

         mod   eom,name,tylg,atrv,IOManEnt,size

size     equ   .

name     fcs   /IOMan/
         fcb   edition


******************************
*
* IOMan Main entry
*

IOManEnt equ   *
* allocate device table
         ldx   <D.Init        Get pointer to init module
         lda   DevCnt,x       Get number of entrys in device table
         ldb   #DEVSIZ        Get size of each entry
         mul                  Calculate size needed for device table
         pshs  a,b            Preserve it
         lda   PollCnt,x      Get number of entrys in polling table
         ldb   #POLSIZ        Get size of each entry
         mul                  Calculate size needed for polling table
         pshs  a,b            Preserve it
         addd  2,s            Add memory required for device table
         addd  #$0018         Add another 24 bytes
         addd  #$00FF         Add another 256
         clrb                 Drop LSB
         os9   F$SRqMem       Request the memory
         bcs   Crash          Crash system if error
         leax  ,u             Point to the memory
L0033    clr   ,x+            Clear a byte
         subd  #1             Done?
         bhi   L0033          No, keep goin
         stu   <D.DevTbl      Get pointer to device table
         ldd   ,s++           Restore size of polling table
         std   <D.CLTb        Save it as VIRQ table address temporarily
         ldd   ,s++           Restore size of device table
         leax  d,u            Point X to the end of device table
         stx   <D.PolTbl      Initialize polling table address
         ldd   <D.CLTb        Get VIRQ table size
         leax  d,x            Add it to X
         stx   <D.CLTb        Save VIRQ table address
         ldx   <D.PthDBT      Get address of path descriptor table
         os9   F$All64        Split it into 64 byte chunks
         bcs   Crash          Crash system if error
         stx   <D.PthDBT      Save the pointer back
         os9   F$Ret64
         leax  >L05F2,pcr     Point to polling routine
         stx   <D.Poll        Save the vector address
         leay  <L0067,pcr     Point to service vector table
         os9   F$SSvc         Set them up
         rts                  Let the system take over

******************************
*
* Fatal error Crash the system
*

Crash    jmp   <D.Crash

******************************
*
* System service routine vector table
*

L0067    fcb   $7F
         fdb   UsrIO-*-2
         fcb   F$Load
         fdb   FLoad-*-2
         fcb   I$Detach
         fdb   IDetach0-*-2
         fcb   F$PErr
         fdb   FPErr-*-2
         fcb   F$IOQu+$80
         fdb   FIOQu-*-2
         fcb   $FF
         fdb   SysIO-*-2
         fcb   F$IRQ+$80
         fdb   FIRQ-*-2
         fcb   F$IODel+$80
         fdb   FIODel-*-2
         fcb   F$NMLink
         fdb   FNMLink-*-2
         fcb   F$NMLoad
         fdb   FNMLoad-*-2
         fcb   $80

******************************
*
* Check device status service call?
*
* Entry: U = Callers register stack pointer
*

FIODel   ldx   R$X,u          Get address of module
         ldu   <D.Init        Get pointer to init module
L008A    ldb   DevCnt,u       Get device count
         ldu   <D.DevTbl      Get pointer to device table
L008E    ldy   V$DESC,u       Descriptor exist?
         beq   L009F          No, move to next device
         cmpx  V$DESC,u       Device match?
         beq   L00A6          Yes, return Module busy
         cmpx  V$DRIV,u       Match driver?
         beq   L00A6          Yes, return module busy
         cmpx  V$FMGR,u       Match Manager?
         beq   L00A6          Yes, return module busy
L009F    leau  DEVSIZ,u       Move to next device entry
         decb                 Done them all?
         bne   L008E          No, keep goin
         clrb                 Clear carry
         rts                  Return
L00A6    comb                 Set carry
         ldb   #E$ModBsy      Get error code for module busy
         rts                  Return

UsrIODis fdb   IAttach-UsrIODis
         fdb   IDetach-UsrIODis
         fdb   UIDup-UsrIODis
         fdb   IUsrCall-UsrIODis
         fdb   IUsrCall-UsrIODis
         fdb   IMakDir-UsrIODis
         fdb   IChgDir-UsrIODis
         fdb   IDelete-UsrIODis
         fdb   UISeek-UsrIODis
         fdb   UIRead-UsrIODis
         fdb   UIWrite-UsrIODis
         fdb   UIRead-UsrIODis
         fdb   UIWrite-UsrIODis
         fdb   UIGetStt-UsrIODis
         fdb   UISeek-UsrIODis
         fdb   UIClose-UsrIODis
         fdb   IDeletX-UsrIODis

SysIODis fdb   IAttach-SysIODis
         fdb   IDetach-SysIODis
         fdb   SIDup-SysIODis
         fdb   ISysCall-SysIODis
         fdb   ISysCall-SysIODis
         fdb   IMakDir-SysIODis
         fdb   IChgDir-SysIODis
         fdb   IDelete-SysIODis
         fdb   SISeek-SysIODis
         fdb   SIRead-SysIODis
         fdb   SIWrite-SysIODis
         fdb   SIRead-SysIODis
         fdb   SIWrite-SysIODis
         fdb   SIGetStt-SysIODis
         fdb   SISeek-SysIODis
         fdb   SIClose-SysIODis
         fdb   IDeletX-SysIODis

UsrIO    leax  <UsrIODis,pcr
         bra   L0105
SysIO    leax  <SysIODis,pcr
L0105    cmpb  #I$DeletX
         bhi   L0114
         pshs  b
         lslb  
         ldd   b,x
         leax  d,x
         puls  b
         jmp   ,x

******************************
*
* Unknown service code error handler
*

L0114    comb  
         ldb   #E$UnkSvc
         rts   

* Entry: U=Module header pointer

IAttach  ldb   #$17
L010B    clr   ,-s
         decb  
         bpl   L010B
         stu   <$16,s     save caller regs
         lda   R$A,u      access mode
         sta   $09,s      save on stack
         ldx   <D.Proc
         stx   <$14,s     save proc desc
         leay  <P$DATImg,x
         ldx   <D.SysPrc
         stx   <D.Proc
         ldx   R$X,u
         lda   #Devic+0
         os9   F$SLink
         bcs   L0154
         stu   $04,s      save pointer to dev desc
         ldy   <$16,s     get caller regs
         stx   R$X,y
         lda   M$Port,u
         sta   $0B,s      save extended port addr
         ldd   M$Port+1,u
         std   $0C,s      save port addr
         ldd   M$PDev,u
         leax  d,u        point to driver name in desc
         lda   #Drivr+0
         os9   F$Link     link to driver
         bcs   L0154
         stu   ,s         save pointer to driver
         ldu   4,s        get dev desc ptr
         ldd   M$FMgr,u
         leax  d,u        point to fmgr name in desc
         lda   #FlMgr+0
         os9   F$Link
L0154    ldx   <$14,s     get proc desc
         stx   <D.Proc
         bcc   L0169
L015B    stb   <$17,s     save error in B on stack
         leau  ,s         point U at stack
         os9   I$Detach   detach
         leas  <$17,s     clean up stack
         comb  
         puls  pc,b
L0169    stu   $06,s      save pointer to fmgr
         ldx   <D.Init
         ldb   DevCnt,x
         lda   DevCnt,x
         ldu   <D.DevTbl
L0173    ldx   V$DESC,u
         beq   L01B0
         cmpx  4,s        compare to dev desc on stack
*         bne   L018E      --BGP
         bne   L0191      ++BGP
         ldx   V$STAT,u   get static
         bne   L018C
         pshs  a
         lda   V$USRS,u
         beq   L0188
         os9   F$IOQu
L0188    puls  a
         bra   L0173
L018C    stu   $0E,s      save static storage
L018E    ldx   V$DESC,u
L0191    ldy   M$Port+1,x same port?
         cmpy  $0C,s
         bne   L01B0
         ldy   M$Port,x
         cmpy  $0B,s      same port?
         bne   L01B0
         ldx   V$DRIV,u
         cmpx  ,s         same driver?
         bne   L01B0
         ldx   V$STAT,u
         stx   $02,s      save static
         tst   V$USRS,u
         beq   L01B0
         sta   $0A,s
L01B0    leau  DEVSIZ,u
         decb  
         bne   L0173
         ldu   $0E,s      get static storage
         lbne  L020E
         ldu   <D.DevTbl
L01BD    ldx   V$DESC,u
         beq   L01CE
         leau  DEVSIZ,u
         deca  
         bne   L01BD
         ldb   #E$DevOvf
         bra   L015B
L01CA    ldb   #E$BMode
         bra   L015B
L01CE    ldx   $02,s      get driver static in X
         lbne  L0205      if not zero, already alloced
         stu   $0E,s
         ldx   ,s         get ptr to driver
         ldd   M$Mem,x    get driver mem size
         addd  #$00FF     round to next page
         clrb  
         os9   F$SRqMem   allocate driver mem
         lbcs  L015B
         stu   $02,s      save ptr to mem
L01E7    clr   ,u+        clear driver mem
         subd  #$0001
         bhi   L01E7
         ldd   $0C,s      get ???
         ldu   $02,s
         clr   ,u
         std   $01,u
         ldy   $04,s
         ldx   ,s         get ptr to driver
         ldd   $09,x      D holds entry to driver
         jsr   d,x        call init routine
         lbcs  L015B
         ldu   $0E,s
* Copy device table entry here
L0205    ldb   #$08       size of device table
L0207    lda   b,s        get from src
         sta   b,u        save in dest
         decb  
         bpl   L0207
* Here, U points to Device Table
L020E    ldx   $04,u  get desc ptr in X
         ldb   $07,x  get lang byte in desc
         lda   $09,s  get access mode byte passed in A
         anda  $0D,x  AND with mode byte in desc
         ldx   ,u     X points to driver module
         anda  $0D,x  AND with mode byte in driver
         cmpa  $09,s  same as ??
         lbne  L01CA  if not, bad mode error
         inc   $08,u  else inc user count
         bne   L0226  if not zero, continue
         dec   $08,u  else dec to $FF
L0226    ldx   <$16,s
         stu   $08,x
         leas  <$18,s
         clrb  
         rts   

IDetach  ldu   R$U,u      get ptr to dev tbl entry
*         ldx   V$DESC,u
         tst   V$USRS,u
         beq   IDetach2
L0240    lda   #$FF
         cmpa  $08,u
         lbeq  L02B7
         dec   $08,u
         lbne  L0299
IDetach2
         ldx   <D.Init
         ldb   DevCnt,x
         pshs  u,b
         ldx   $02,u
         clr   $02,u
         clr   $03,u
         ldy   <D.DevTbl
L025D    cmpx  $02,y
         beq   L028F
         leay  $09,y
         decb  
         bne   L025D
         ldy   <D.Proc
         ldb   ,y
         stb   $08,u
         ldy   $04,u
         ldu   ,u
         exg   x,u
         ldd   $09,x
         leax  d,x
         pshs  u
         jsr   $0F,x
L027C    puls  u
         ldx   $01,s      get ptr to dev tbl
         ldx   ,x         load X with driver addr
         ldd   M$Mem,x    get static storage size
         addd  #$00FF     round up one page
         clrb  
         os9   F$SRtMem   return mem
         ldx   $01,s      get ptr to dev tbl
         ldx   V$DESC,x
L028F    puls  u,b
         ldx   $04,u
         clr   $04,u
         clr   $05,u
         clr   $08,u
L0299    ldd   <D.Proc
         pshs  b,a
         ldd   <D.SysPrc
         std   <D.Proc
         ldy   ,u
         ldu   $06,u
         os9   F$UnLink
         leau  ,y
         os9   F$UnLink
         leau  ,x
         os9   F$UnLink
         puls  b,a
         std   <D.Proc
L02B7    lbsr  L0556
         clrb  
         rts   

UIDup    bsr   LocFrPth
         bcs   L02DC
         pshs  x,a
         lda   R$A,u
         lda   a,x
         bsr   L02D5
         bcs   L02D1
         puls  x,b
         stb   R$A,u
         sta   b,x
         rts   
L02D1    puls  pc,x,a

SIDup    lda   R$A,u
L02D5    lbsr  GetPDesc
         bcs   L02DC
         inc   PD.CNT,y
L02DC    rts   

* Locate a free path in D.Proc
LocFrPth ldx   <D.Proc
         leax  <P$Path,x
         clra  
L02E3    tst   a,x
         beq   L02F0
         inca  
         cmpa  #Numpaths
         bcs   L02E3
         comb  
         ldb   #E$PthFul
         rts   
L02F0    andcc  #^Carry
         rts   

IUsrCall bsr   LocFrPth
         bcs   L0305
         pshs  u,x,a
         bsr   ISysCall
         puls  u,x,a
         bcs   L0305
         ldb   R$A,u
         stb   a,x
         sta   R$A,u
L0305    rts   

ISysCall pshs  b
         ldb   R$A,u
         bsr   AllcPDsc
         bcs   L031A
         puls  b
         lbsr  CallFMgr
         bcs   L0329
         lda   PD.PD,y
         sta   R$A,u
         rts   
L031A    puls  pc,a

IMakDir  pshs  b
         ldb   #DIR.!WRITE.
L0320    bsr   AllcPDsc
         bcs   L031A
         puls  b
         lbsr  CallFMgr
L0329    pshs  b,cc
         ldu   PD.DEV,y
         os9   I$Detach
         lda   PD.PD,y
         ldx   <D.PthDBT
         os9   F$Ret64
         puls  pc,b,cc

IChgDir  pshs  b
         ldb   R$A,u
         orb   #DIR.
         bsr   AllcPDsc
         bcs   L031A
         puls  b
         lbsr  CallFMgr
         bcs   L0329
         ldu   <D.Proc
         ldb   PD.MOD,y
         bitb  #PWRIT.+PREAD.+WRITE.+READ.
         beq   IChgExec
         ldx   PD.DEV,y
         stx   <P$DIO,u
         inc   V$USRS,x
         bne   IChgExec
         dec   V$USRS,x
IChgExec bitb  #PEXEC.+EXEC.
         beq   IChgRts
         ldx   PD.DEV,y
         stx   <P$DIO+6,u
         inc   V$USRS,x
         bne   IChgRts
         dec   V$USRS,x
IChgRts  clrb  
         bra   L0329

IDelete  pshs  b
         ldb   #WRITE.
         bra   L0320

IDeletX  ldb   #DIR.+EXEC.+UPDAT.
         pshs  b
         ldb   R$A,u
         bra   L0320

* allocate path descriptor
AllcPDsc ldx   <D.Proc
         pshs  u,x
         ldx   <D.PthDBT
         os9   F$All64
         bcs   L03E9
         inc   PD.CNT,y
         stb   PD.MOD,y
         ldx   <D.Proc
         ldb   P$Task,x
         ldx   R$X,u      X points to pathlist
L0392    os9   F$LDABX
         leax  1,x
         cmpa  #C$SPAC    skip over spaces
         beq   L0392
         leax  -$01,x     back up
         stx   R$X,u      save back pointer
*         ldb   PD.MOD,y  moved down --BGP
         cmpa  #PDELIM    leading slash?
         beq   L03BF      yep...
         ldb   PD.MOD,y   ++BGP
         ldx   <D.Proc
         bitb  #EXEC.     exec. dir relative?
         beq   L03B0      nope...
         ldx   <P$DIO+6,x
         bra   L03B3
L03B0    ldx   <P$DIO,x
L03B3    beq   L03EE
         ldd   <D.SysPrc
         std   <D.Proc
         ldx   $04,x
         ldd   $04,x
         leax  d,x
L03BF    pshs  y          save off path desc ptr in Y
         os9   F$PrsNam
         puls  y          restore path desc ptr
         bcs   L03EE
         lda   PD.MOD,y
         os9   I$Attach   attach to device
         stu   PD.DEV,y   save dev tbl entry
         bcs   L03F0
         ldx   V$DESC,u
* copy options from dev desc to path desc
         leax  <M$Opt,x
         ldb   ,x+        get options count
         leau  <PD.OPT,y
         cmpb  #$20
         bls   L03E5
         ldb   #$1F
L03E1    lda   ,x+
         sta   ,u+
L03E5    decb  
         bpl   L03E1
         clrb  
L03E9    puls  u,x
         stx   <D.Proc
         rts   

L03EE    ldb   #E$BPNam
L03F0    pshs  b
         lda   ,y
         ldx   <D.PthDBT
         os9   F$Ret64
         puls  b
         coma  
         bra   L03E9

* System to User Path routine
*
* Returns:
*    A = user path #
*    X = path table in path desc. of current proc.
S2UPth   lda   R$A,u
         cmpa  #NumPaths
         bcc   L040F      illegal path number
         ldx   <D.Proc
         leax  <P$Path,x
         andcc  #^Carry
         lda   a,x
         bne   L0412
L040F    comb  
         ldb   #E$BPNum
L0412    rts   

UISeek   bsr   S2UPth     get user path #
         bcc   GtPDClFM   get PD, call FM
         rts   

SISeek   lda   R$A,u
GtPDClFM bsr   GetPDesc
         lbcc  CallFMgr
         rts   

UIRead   bsr   S2UPth     get user path #
         bcc   L0428
         rts   

SIRead   lda   R$A,u
L0428    pshs  b
         ldb   #EXEC.+READ.
L042C    bsr   GetPDesc
         bcs   L0479
         bitb  PD.MOD,y
         beq   L0477
         ldd   R$Y,u      get count from user
         beq   L0466
         addd  R$X,u      update buffer pointer
         bcs   L046B
         subd  #$0001     subtract 1 from count
         lsra  
         lsra  
         lsra  
         lsra  
         lsra  
         ldb   R$X,u
         lsrb  
         lsrb  
         lsrb  
         lsrb  
         lsrb  
         pshs  b
         suba  ,s+
         ldx   <D.Proc
         leax  <P$DATImg,x
         lslb  
*         leax  b,x      --BGP
         abx         ++BGP
L0457    pshs  a
         ldd   ,x++
         cmpd  #$333E
         puls  a
         beq   L046B
         deca  
         bpl   L0457
L0466    puls  b
         lbra  CallFMgr
L046B    ldb   #E$Read
         lda   ,s
         bita  #READ.
         bne   L0479
         ldb   #E$Write
         bra   L0479
L0477    ldb   #E$BMode
L0479    com   ,s+
         rts   

UIWrite  bsr   S2UPth     get user path #
         bcc   L0483
         rts   

SIWrite  lda   R$A,u
L0483    pshs  b
         ldb   #WRITE.
         bra   L042C

* get path descriptor
* Passed:   A = path number
* Returned: Y = address of path desc for path num
GetPDesc pshs  x
         ldx   <D.PthDBT
         os9   F$Find64
         puls  x
         lbcs  L040F
L0496    rts   

UIGetStt lbsr  S2UPth     get user path #
         ldx   <D.Proc
         bcc   L04A3
         rts   

SIGetStt lda   R$A,u
         ldx   <D.SysPrc
L04A3    pshs  x,b,a
         lda   R$B,u      get func code
         sta   1,s        place func code on stack
         puls  a          get path off stack
         lbsr  GtPDClFM
         puls  x,a
         pshs  u,y,b,cc
         ldb   <$20,y
         cmpb  #$04
         beq   L04C0
         tsta             SS.Opt?
         beq   L04C2
         cmpa  #SS.DevNm
         beq   SSDevNm
L04C0    puls  pc,u,y,b,cc
L04C2    lda   <D.SysTsk
         ldb   P$Task,x
         leax  <PD.OPT,y
SSCopy   ldy   #32
         ldu   R$X,u
         os9   F$Move
         leas  2,s
         clrb  
         puls  pc,u,y

SSDevNm  lda   <D.SysTsk
         ldb   P$Task,x
         pshs  b,a
         ldx   PD.DEV,y
         ldx   V$DESC,x
         ldd   M$Name,x
         leax  d,x
         puls  b,a
         bra   SSCopy

UIClose  lbsr  S2UPth     get user path #
         bcs   L0496
         pshs  b
         ldb   R$A,u
         clr   b,x        zero path entry
         puls  b
         bra   L04FA

SIClose  lda   R$A,u
L04FA    bsr   GetPDesc
         bcs   L0496
         dec   PD.CNT,y
         tst   PD.CPR,y
         bne   L0506
         bsr   CallFMgr
L0506    tst   PD.CNT,y
         bne   L0496
         lbra  L0329
L050D    os9   F$IOQu
         comb  
         ldb   <$19,x
         bne   L0521
L0516    ldx   <D.Proc
         ldb   P$ID,x
         clra  
         lda   PD.CPR,y
         bne   L050D
         stb   PD.CPR,y
L0521    rts   

CallFMgr pshs  u,y,x,b
         bsr   L0516
         bcs   L053E
         stu   PD.RGS,y
         lda   <$20,y
         ldx   PD.DEV,y
         ldx   V$FMGR,x
         ldd   M$Exec,x
         leax  d,x
         ldb   ,s         get B off stack
         subb  #$83
         lda   #$03
         mul   
         jsr   d,x
L053E    pshs  b,cc
         bsr   L0556
         ldy   $05,s      get Y off stack
         lda   <$20,y
         ldx   <D.Proc
         lda   P$ID,x
         cmpa  PD.CPR,y
         bne   L0552
         clr   PD.CPR,y
L0552    puls  b,cc
         puls  pc,u,y,x,a
*L0556    pshs  y,x        --BGP
L0556    pshs  y          ++BGP
         ldy   <D.Proc
         lda   <P$IOQN,y
         beq   L056D
         clr   <P$IOQN,y
         ldb   #S$Wake
         os9   F$Send
         os9   F$GProcP
         clr   P$IOQP,y
L056D    clrb  
*         puls  pc,y,x     --BGP
         puls  pc,y       ++BGP

FIRQ     ldx   R$X,u      get ptr to IRQ packet
         ldb   ,x         get flip byte
         ldx   1,x        get mask/priority byte
         clra  
         pshs  cc
         pshs  x,b
         ldx   <D.Init
         ldb   PollCnt,x
         ldx   <D.PolTbl
         ldy   R$X,u
         beq   L05C1
         tst   $01,s      test mask byte on stack
         beq   L05EC
         decb  
         lda   #POLSIZ
         mul   
         leax  d,x        point to last entry in table
         lda   Q$MASK,x
         bne   L05EC
         orcc  #IntMasks
L0596    ldb   $02,s      get priority byte on stack
         cmpb  -$01,x     compare to priority of prev entry
         bcs   L05A9
         ldb   #$09
L059E    lda   ,-x
         sta   $09,x
         decb  
         bne   L059E
         cmpx  <D.PolTbl
         bhi   L0596
L05A9    ldd   R$D,u
         std   Q$POLL,x
         ldd   ,s++       get flip/byte off stack
         sta   Q$FLIP,x   store flip
         stb   Q$MASK,x   store mask
         ldb   ,s+        get priority off stack
         stb   Q$PRTY,x
         ldd   R$Y,u      get IRQ SVC entry
         std   Q$SERV,x
         ldd   R$U,u      get IRQ static storage ptr
         std   Q$STAT,x
         puls  pc,cc
* Remove the ISR
L05C1    leas  $04,s      clean up stack
         ldy   R$U,u
L05C6    cmpy  Q$STAT,x
         beq   L05D2
         leax  POLSIZ,x
         decb  
         bne   L05C6
         clrb  
         rts   
L05D2    pshs  b,cc
         orcc  #IntMasks
         bra   L05DF
* Move prev poll entry up one
L05D8    ldb   POLSIZ,x
         stb   ,x+
         deca  
         bne   L05D8
L05DF    lda   #POLSIZ
         dec   1,s        dec poll count on stack
         bne   L05D8
L05E5    clr   ,x+
         deca  
         bne   L05E5
         puls  pc,a,cc
L05EC    leas  $04,s
L05EE    comb  
         ldb   #E$Poll
         rts   

******************************
*
* Device polling routine
*
* Entry: None
*

L05F2    ldy   <D.PolTbl      Get pointer to polling table
         ldx   <D.Init        Get pointer to init module
         ldb   PollCnt,x      Get number of entries in table
         bra   L0600          Get check em
L05FB    leay  POLSIZ,y       Move to next entry
         decb                 Done?
         beq   L05EE          Yep, exit with polling table full error
L0600    lda   [Q$POLL,y]     Get device's status register
         eora  2,y            Flip it
         bita  3,y            Origin of IRQ?
         beq   L05FB          No, go to next device
         ldu   Q$STAT,y       Get device static storage
         pshs  y,b            Preserve device # & poll address
         jsr   [Q$SERV,y]     Execute service routine
         puls  y,b            Restore device # & poll address
         bcs   L05FB          Go to next device if error
         rts                  Return

FNMLoad  pshs  u
         ldx   R$X,u
         lbsr  L06B5
         bcs   L066C
         ldy   ,s
         stx   $04,y
         ldy   ,u
         ldx   $04,u
         ldd   #$0006
         os9   F$LDDDXY
* minor optimization
*         puls  y       --BGP
*         exg   y,u     --BGP
         leay  ,u      ++BGP
         puls  u       ++BGP
         bra   L0649

FNMLink  ldx   <D.Proc
         leay  <P$DATImg,x
         pshs  u
         ldx   R$X,u
         lda   R$A,u
         os9   F$FModul
         bcs   L066C
         leay  ,u
         puls  u
         stx   R$X,u
L0649    std   R$D,u
         ldx   $06,y
         beq   L0653
         bitb  #$80
         beq   L0669
L0653    leax  $01,x
         beq   L0659
         stx   $06,y
L0659    ldx   $04,y
         ldy   ,y
         ldd   #$000B
         os9   F$LDDDXY
         bcs   L0668
         std   $06,u
L0668    rts   
L0669    comb  
         ldb   #E$ModBsy
L066C    puls  pc,u

******************************
*
* F$Load Entry point
*
* Entry: U = Callers register stack
*

FLoad    pshs  u              Save register stack pointer
         ldx   R$X,u          Get pointer to pathname
         bsr   L06B5          Aloocate a process descriptor
         bcs   L0699          Exit if error
         puls  y              Restore register stack pointer
L0678    pshs  y              Preserve Y
         stx   R$X,y          Update pathname pointer
         ldy   ,u             Get DAT Image pointer
         ldx   $04,u          Get offset within the DAT image
         ldd   #$0006         Get offset to the offset
         os9   F$LDDDXY       Get language & type
         ldx   ,s             Get register pointer
         std   R$D,x          Update language/type codes
         leax  ,u
         os9   F$ELink
         bcs   L0699
         ldx   ,s
         sty   $06,x
         stu   $08,x
L0699    puls  pc,u

IDetach0 pshs  u
         ldx   R$X,u
         bsr   L06B5
         bcs   L06B3
         puls  y
         ldd   <D.Proc
         pshs  y,b,a
         ldd   $08,y
         std   <D.Proc
         bsr   L0678
         puls  x
         stx   <D.Proc
L06B3    puls  pc,u
L06B5    os9   F$AllPrc
         bcc   L06BB
         rts   

L06BB    leay  ,u
         ldu   #$0000
         pshs  u,y,x,b,a
         leas  <-$11,s
         clr   $07,s
         stu   ,s
         stu   $02,s
         ldu   <D.Proc
         stu   $04,s
         clr   $06,s
         lda   $0A,u
         sta   $0A,y
         sta   $0B,y
         lda   #EXEC.
         os9   I$Open
         lbcs  L0770
         sta   $06,s
         stx   <$13,s
         ldx   <$15,s
         os9   F$AllTsk
         lbcs  L0770
         stx   <D.Proc
L06F1    ldx   <$15,s
         lda   $0A,x
         adda  #$08
         bcc   L06FC
         lda   #$FF
L06FC    sta   $0A,x
         sta   $0B,x
         ldd   #$0009
         ldx   $02,s
         lbsr  L07F7
         bcs   L0770
         ldu   <$15,s
         lda   $06,u
         ldb   <D.SysTsk
         leau  $08,s
         pshs  x
         ldx   $04,s
         os9   F$Move
         puls  x
         ldd   ,u
         cmpd  #M$ID12
         bne   L076E
         ldd   $02,u
         subd  #$0009
         lbsr  L07F7
         bcs   L0770
         ldx   $04,s
         lda   $0A,x
         ldy   <$15,s
         sta   $0A,y
         sta   $0B,y
         leay  <$40,y
         tfr   y,d
         ldx   $02,s
         os9   F$VModul
         bcc   L074C
         cmpb  #$E7
         beq   L0752
         bra   L0770
L074C    ldd   $02,s
         addd  $0A,s
         std   $02,s
L0752    ldd   <$17,s
         bne   L06F1
         ldd   $04,u
         std   <$11,s
*         ldx   ,u  --BGP
*         ldd   ,x  --BGP
         ldd   [,u]  ++BGP
         std   <$17,s
         ldd   $06,u
         addd  #$0001
         beq   L06F1
         std   $06,u
         bra   L06F1
L076E    ldb   #$CD
L0770    stb   $07,s
         ldd   $04,s
         beq   L0778
         std   <D.Proc
L0778    lda   $06,s
         beq   L077F
         os9   I$Close
L077F    ldd   $02,s
         addd  #$1FFF
         lsra  
         lsra  
         lsra  
         lsra  
         lsra  
         sta   $02,s
         ldb   ,s
         beq   L07AE
         lsrb  
         lsrb  
         lsrb  
         lsrb  
         lsrb  
         subb  $02,s
         beq   L07AE
         ldx   <$15,s
         leax  <$40,x
         lsla  
         leax  a,x
         clra  
         tfr   d,y
         ldu   <D.BlkMap
L07A6    ldd   ,x++
         clr   d,u
         leay  -$01,y
         bne   L07A6
L07AE    ldx   <$15,s
         lda   ,x
         os9   F$DelPrc
         ldd   <$17,s
         bne   L07C3
         ldb   $07,s
         stb   <$12,s
         comb  
         bra   L07F2
L07C3    ldu   <D.ModDir
         ldx   <$11,s
         ldd   <$17,s
         leau  -$08,u
L07CD    leau  $08,u
         cmpu  <D.ModEnd
         bcs   L07DC
         comb  
         ldb   #$DD
         stb   <$12,s
         bra   L07F2
L07DC    cmpx  $04,u
         bne   L07CD
         cmpd  [,u]
         bne   L07CD
         ldd   $06,u
         beq   L07EE
         subd  #$0001
         std   $06,u
L07EE    stu   <$17,s
         clrb  
L07F2    leas  <$11,s
         puls  pc,u,y,x,b,a
L07F7    pshs  y,x,b,a
         addd  $02,s
         std   $04,s
         cmpd  $08,s
         bls   L0858
         addd  #$1FFF
         lsra  
         lsra  
         lsra  
         lsra  
         lsra  
         cmpa  #$07
         bhi   L0838
         ldb   $08,s
         lsrb  
         lsrb  
         lsrb  
         lsrb  
         lsrb  
         pshs  b
         exg   b,a
         subb  ,s+
         lsla  
         ldu   <$1D,s
         leau  <$40,u
         leau  a,u
         clra  
         tfr   d,x
         ldy   <D.BlkMap
*         clra  --BGP
         clrb  
L082C    tst   ,y+
         beq   L083D
L0830    addd  #$0001
         cmpy  <D.BlkMap+2
         bne   L082C
L0838    comb  
         ldb   #E$MemFul
         bra   L0862
L083D    inc   -$01,y
         std   ,u++
*         pshs  b,a   --BGP
*         ldd   $0A,s --BGP
*         addd  #$2000  --BGP
*         std   $0A,s  --BGP
*         puls  b,a --BGP
         pshs  a ++BGP
         lda   9,s ++BGP
         adda  #$20 ++BGP
         sta   9,s ++BGP
         puls  a ++BGP
         leax  -1,x
         bne   L0830
         ldx   <$1D,s
         os9   F$SetTsk
         bcs   L0862
L0858    lda   $0E,s
         ldx   $02,s
         ldy   ,s
         os9   I$Read
L0862    leas  $04,s
         puls  pc,x

******************************
*
* F$PErr System call entry point
*
* Entry: U = Register stack pointer
*

ErrMess  fcc   /ERROR #/
         fcb   $2F,$3A,$30
         fcb   C$CR
ErrMessL equ   *-Errmess

FPErr    ldx   <D.Proc        Get current process pointer
         lda   <P$Path+2,x     Get standard error path
         beq   L08B8          Return if not there
         leas  -ErrMessL,s          Make a buffer on the stack
         leax  <ErrMess,pcr       Point to error text
         leay  ,s             Point to buffer
L087F    lda   ,x+            Get a byte
         sta   ,y+            Store it
         cmpa  #C$CR          Done?
         bne   L087F          No, keep goin
         ldb   R$B,u          Get error code

* Convert error code to decimal

L0889    inc   7,s
         subb  #$64
         bcc   L0889
L088F    dec   $08,s
         addb  #$0A
         bcc   L088F
         addb  #$30
         stb   $09,s

         ldx   <D.Proc        Get current process pointer
         ldu   P$SP,x         Get the stack pointer
         leau  -ErrMessL,u          Put a buffer on it
         lda   <D.SysTsk      Get system task number
         ldb   P$Task,x       Get task number of process
         leax  ,s             Point to error text
         ldy   #ErrMessL            Get length of text
L08A9    os9   F$Move         Move it to the process
         leax  ,u             Point to the moved text
         ldu   <D.Proc        Get process pointer
         lda   <P$Path+2,u     Get path number
         os9   I$WritLn       Write the text
         leas  ErrMessL,s           Purge the buffer
L08B8    rts                  Return

FIOQu    ldy   <D.Proc
L08BC    lda   <P$IOQN,y
         beq   L08DF
         cmpa  R$A,u
         bne   L08DA
         clr   <P$IOQN,y
         os9   F$GProcP
         lbcs  L093F
         clr   $0F,y
         ldb   #S$Wake
         os9   F$Send
         ldu   <D.Proc
         bra   L08E8
L08DA    os9   F$GProcP
         bcc   L08BC
L08DF    lda   R$A,u
         ldu   <D.Proc
         os9   F$GProcP
         bcs   L093F
L08E8    leax  ,y
         lda   <P$IOQN,y
         beq   L090A
         os9   F$GProcP
         bcs   L093F
         ldb   P$Age,u
         cmpb  P$Age,y    minor queue sort bug fixed - BGP
         bls   L08E8
         ldb   P$ID,u
         stb   <P$IOQN,x
         ldb   P$ID,x
         stb   P$IOQP,u
         clr   P$IOQP,y
         exg   y,u
         bra   L08E8
L090A    lda   P$ID,u
         sta   <P$IOQN,y
         lda   P$ID,y
         sta   P$IOQP,u
         ldx   #$0000
         os9   F$Sleep
         ldu   <D.Proc
         lda   P$IOQP,u
         beq   L093D
         os9   F$GProcP
         bcs   L093D
         lda   <P$IOQN,y
         beq   L093D
         lda   <P$IOQN,u
         sta   <P$IOQN,y
         beq   L093D
         clr   <P$IOQN,u
         os9   F$GProcP
         bcs   L093D
         lda   P$IOQP,u
         sta   P$IOQP,y
L093D    clr   P$IOQP,u
L093F    rts   

         emod  
eom      equ   *
         end   

