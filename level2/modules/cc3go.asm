********************************************************************
* CC3Go - Kickstart program module
*
* $Id$ 
*
* Ed.    Comments                                       Who YY/MM/DD
* ------------------------------------------------------------------
* 5      Taken from OS-9 L2 Tandy distribution and      BGP 98/10/12
*        modified banner for V3

         nam   CC3Go
         ttl   Kickstart program module

         ifp1
         use   defsfile
         endc

tylg     set   Prgrm+Objct
atrv     set   ReEnt+rev
rev      set   $01
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
         ifne  NitrOS9
         fcc   /NitrOS-9 Level Two Vr. 0/
         else
         fcc   /  OS-9 Level Two Vr. 0/
         endc
         fcb   48+OS9Vrsn
         fcc   /.0/
         fcb   48+OS9Major
         fcc   /.0/
         fcb   48+OS9Minor
         fcb   C$CR,C$LF
         ifne  NitrOS9
         fcc   " ORION BETA1 Release 09/22/2002"
         else
         fcc   " ARIES BETA2 Release ??/??/2002"
         endc
         fcb   C$CR,C$LF
         fcc   /   "A CoCo Community Project"/
         fcb   C$CR,C$LF
         fcc   /      Visit us on the web:/
         fcb   C$CR,C$LF
         fcc   !http://cocoos9.sourceforge.net/!
         fcb   C$CR,C$LF
         fcb   C$LF
BannLen  equ   *-Banner
         ifeq  ROM
DefDev   fcc   "/H0"
         fcb   C$CR
HDDev    fcc   "/H0/"
ExecDir  fcc   "Cmds"
         fcb   C$CR
         fcc   ",,,,,"
         endc
Shell    fcc   "Shell"
         fcb   C$CR
         fcc   ",,,,,"
AutoEx   fcc   "AutoEx"
         fcb   C$CR
         fcc   ",,,,,"
         ifeq  ROM
Startup  fcc   "STARTUP -P"
         fcb   C$CR
         fcc   ",,,,,"
         endc
ShellPrm fcc   "i=/1"
CRtn     fcb   C$CR
         fcc   ",,,,,"
ShellPL  equ   *-ShellPrm

DefTime  fcb   88,10,01,00,00,00

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
         ifeq  ROM
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
         endc
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
         ifeq  ROM
* Fork shell startup here
         leax  >Shell,pcr
         leau  >Startup,pcr
         ldd   #256
         ldy   #16
         os9   F$Fork
         bcs   L01A5
         os9   F$Wait
         endc
* Fork AutoEx here
         leax  >AutoEx,pcr
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
