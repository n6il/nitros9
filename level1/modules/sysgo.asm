********************************************************************
* SysGo - OS-9 Level One 2 SysGo
*
* $Id$
*
* Ed.    Comments                                       Who YY/MM/DD
* ------------------------------------------------------------------
* 12     Tandy/Microware original version
* 13     Incremented version number to reflect Y2K      BGP 99/05/11
*        fixes

         nam   SysGo
         ttl   OS-9 Level One 2 SysGo

         ifp1
         use   defsfile
         use   scfdefs
         endc

tylg     set   Systm+Objct
atrv     set   ReEnt+rev
rev      set   $01
edition  set   13

         mod   eom,name,tylg,atrv,start,size

dataarea rmb   200
size     equ   .

name     fcs   /SysGo/
         fcb   edition

* default OS-9 priority
DefPrior set   128

BootMsg  fcc   "OS-9 LEVEL ONE VR. 0"
         fcb   48+OS9Vrsn
         fcc   ".0"
         fcb   48+OS9Major
         fcc   ".0"
         fcb   48+OS9Minor
         fdb   C$CR,C$LF
         fcc   "COPR. 1980 BY MOTOROLA INC. AND"
         fdb   C$CR,C$LF
         fcc   "MICROWARE SYSTEMS CORP."
         fdb   C$CR,C$LF
         fcc   "LICENSED TO TANDY CORP."
         fdb   C$CR,C$LF
         fcc   "ALL RIGHTS RESERVED."
         fdb   C$CR,C$LF
         fcb   C$LF
MsgEnd   equ   *

ChdDev   fcc   "/H0"
         fcb   C$CR
ChxDev   fcc   "/H0/"
ChxPath  fcc   "Cmds"
         fcb   C$CR
         fcc   ",,,,,,,,,,"

Shell    fcc   "Shell"
         fcb   C$CR

         fcc   "TSMON"
         fcb   C$CR
Startup  fcc   "STARTUP -P"
         fcb   C$CR
         fcc   ",,,,,,,,,,"

* Default time packet
*              YY MM DD HH MM SS
TimePckt fcb   85,06,01,00,00,00

BasicRst fcb   $55
         fcb   $00
         fcb   $74
         fcb   $12
         fcb   $7F
         fcb   $FF
         fcb   $03
         fcb   $12
         fcb   $12
         fcb   $B7
         fcb   $FF
         fcb   $DF
         fcb   $7E
         fcb   $EF
         fcb   $0E

* SysGo entry point
start    leax  >IcptRtn,pcr
         os9   F$Icpt
         leax  >BasicRst,pcr
         ldu   #$0071
         ldb   #$0F
CopyLoop lda   ,x+
         sta   ,u+
         decb
         bne   CopyLoop

* Print boot message
         leax  >BootMsg,pcr
         ldy   #MsgEnd-BootMsg
         lda   #$01
         os9   I$Write
         leax  >TimePckt,pcr
         os9   F$STime
         leax  >ChxPath,pcr
         lda   #$04
         os9   I$ChgDir
         leax  >ChdDev,pcr
         lda   #$03
         os9   I$ChgDir
         bcs   DoStrtup
         leax  >ChxDev,pcr
         lda   #$04
         os9   I$ChgDir
         bcc   DoStrtup

* Set priority and do startup file
DoStrtup os9   F$ID
         ldb   #DefPrior
         os9   F$SPrior
         leax  >Shell,pcr
         leau  >Startup,pcr
         ldd   #$0100
         ldy   #$0015
         os9   F$Fork
         bcs   DeadEnd
         os9   F$Wait

FrkShell leax  >Shell,pcr
         ldd   #$0100
         ldy   #$0000
         os9   F$Fork
         bcs   DeadEnd
         os9   F$Wait
         bcc   FrkShell
DeadEnd  bra   DeadEnd

* Intercept routine
IcptRtn  rti

         emod
eom      equ   *
         end
