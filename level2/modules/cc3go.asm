********************************************************************
* CC3Go - Kickstart program module
*
* $Id$ 
*
* Ed.    Comments                                       Who YY/MM/DD
* ------------------------------------------------------------------
*   5    Taken from OS-9 L2 Tandy distribution and      BGP 98/10/12
*        modified banner for V3
*   5r2  Fixed fork behavior so that if 'shell startup' BGP 03/01/08
*        fails, system doesn't jmp to Crash, but tries
*        AutoEx instead.  Also changed /DD back to /H0
*        for certain boot floppy cases.


         nam   CC3Go
         ttl   Kickstart program module

         IFP1
         use   defsfile
         ENDC

tylg     set   Prgrm+Objct
atrv     set   ReEnt+rev
rev      set   $02
edition  set   $05

         mod   eom,name,tylg,atrv,start,size

u0000    rmb   32
u0020    rmb   42
u004A    rmb   33
u006B    rmb   6
u0071    rmb   655
size     equ   .

name     fcs   /CC3Go/
         fcb  edition

Banner
         IFNE  NitrOS9
         fcc   /NitrOS-9 Level Two Vr. 0/
         ELSE
         fcc   /  OS-9 Level Two Vr. 0/
         ENDC
         fcb   48+OS9Vrsn
         fcc   /.0/
         fcb   48+OS9Major
         fcc   /.0/
         fcb   48+OS9Minor
         fcb   C$CR,C$LF
         fcc   "    Release Date: 06/01/2003"
         fcb   C$CR,C$LF
         fcc   /   "A CoCo Community Project"/
         fcb   C$CR,C$LF
         fcc   /      Visit us on the web:/
         fcb   C$CR,C$LF
         fcc   !http://cocoos9.sourceforge.net/!
         fcb   C$CR,C$LF
         fcb   C$LF
BannLen  equ   *-Banner
         IFEQ  ROM
DefDev   equ   *
         IFNE  DD
         fcc   "/DD"
         ELSE
         fcc   "/H0"
         ENDC
         fcb   C$CR
HDDev    equ   *
         IFNE  DD
         fcc   "/DD/"
         ELSE
         fcc   "/H0/"
         ENDC
ExecDir  fcc   "CMDS"
         fcb   C$CR
         fcc   ",,,,,"
         ENDC
Shell    fcc   "Shell"
         fcb   C$CR
         fcc   ",,,,,"
AutoEx   fcc   "AutoEx"
         fcb   C$CR
         fcc   ",,,,,"
         IFEQ  ROM
Startup  fcc   "STARTUP -P"
         fcb   C$CR
         fcc   ",,,,,"
         ENDC
ShellPrm fcc   "i=/1"
CRtn     fcb   C$CR
         fcc   ",,,,,"
ShellPL  equ   *-ShellPrm

DefTime  fcb   103,3,07,00,00,59

start    leax  >IcptRtn,pcr
         os9   F$Icpt
         os9   F$ID
         ldb   #$80
         os9   F$SPrior
         leax  >Banner,pcr
         ldy   #BannLen
         lda   #$01                    standard output
         os9   I$Write                 write out banner
         leax  >DefTime,pcr
         os9   F$STime                 set time to default
         IFEQ  ROM
         leax  >ExecDir,pcr
         lda   #EXEC.
         os9   I$ChgDir                change exec. dir
         leax  >DefDev,pcr
         lda   #READ.+WRITE.
         os9   I$ChgDir                change data dir.
         bcs   L0125
         leax  >HDDev,pcr
         lda   #EXEC.
         os9   I$ChgDir                change exec. dir to HD
         ENDC
L0125    pshs  u,y
         os9   F$ID
         bcs   L01A9
         leax  ,u
         os9   F$GPrDsc
         bcs   L01A9
         leay  ,u
         ldx   #$0000
         ldb   #$01
         os9   F$MapBlk
         bcs   L01A9
* Set flag for Color BASIC
         lda   #$55
         sta   <D.CBStrt,u
* Copy our default I/O ptrs to the system process
         ldd   <D.SysPrc,u
         leau  d,u
         leau  <P$DIO,u
         leay  <P$DIO,y
         ldb   #DefIOSiz-1
L0151    lda   b,y
         sta   b,u
         decb
         bpl   L0151
         IFEQ  ROM
* Fork shell startup here
         leax  >Shell,pcr
         leau  >Startup,pcr
         ldd   #256
         ldy   #16
         os9   F$Fork
         bcs   DoAuto
         os9   F$Wait
         ENDC
* Fork AutoEx here
DoAuto   leax  >AutoEx,pcr
         leau  >CRtn,pcr
         ldd   #$0100
         ldy   #$0001
         os9   F$Fork
         bcs   L0186
         os9   F$Wait
L0186    puls  u,y
         leax  >ShellPrm,pcr
         leay  ,u
         ldb   #ShellPL
L0190    lda   ,x+
         sta   ,y+
         decb
         bne   L0190
* Fork final shell here
         leax  >Shell,pcr
         ldd   #$0100
         ldy   #ShellPL
         os9   F$Chain
L01A5    ldb   #$06
         bra   Crash
L01A9    ldb   #$04
Crash    clr   $FFA8                   turn off disk motor
         jmp   <D.Crash

IcptRtn  rti

         emod
eom      equ   *
         end
