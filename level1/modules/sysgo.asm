********************************************************************
* SysGo - OS-9 Level One 2 SysGo
*
* $Id$
*
* Ed.    Comments                                       Who YY/MM/DD
* ------------------------------------------------------------------
*  12    From Tandy OS-9 Level One VR 02.00.00
*  13    Incremented version number to reflect Y2K      BGP 99/05/11
*        fixes
*  14    Updated to reflect new release, changed /H0    BGP 02/07/19
*        to /DD
*  15    Merged ROM and non-ROM sysgos, removed 'tsmon' BGP 02/07/19
*        and added 'AutoEx' feature ala Level Two

         nam   SysGo
         ttl   OS-9 Level One 2 SysGo

         IFP1
         use   defsfile
         use   scfdefs
         ENDC

tylg     set   Systm+Objct
atrv     set   ReEnt+rev
rev      set   $01
edition  set   15

         mod   eom,name,tylg,atrv,start,size

dataarea rmb   200
size     equ   .

name     fcs   /SysGo/
         fcb   edition

* default OS-9 priority
DefPrior set   128

BootMsg  fcc   !OS-9 LEVEL ONE VR. 0!
         fcb   48+OS9Vrsn
         fcc   !.0!
         fcb   48+OS9Major
         fcc   !.0!
         fcb   48+OS9Minor
         fdb   C$CR,C$LF

* For ROM version, cut down on verbage
         IFNE  DiskGo
         fcc   !Beta1 Release 03/07/2003!
         fcb   C$CR,C$LF
         fcc   !"A CoCo Community Project"!
         fcb   C$CR,C$LF
         fcc   !Visit us on the web:!
         fcb   C$CR,C$LF
         fcc   !http://cocoos9.sourceforge.net!
         fcb   C$CR,C$LF
         ENDC

         fcb   C$LF
MsgEnd   equ   *

         IFNE  DiskGo
ChdDev   fcc   "/DD"
         fcb   C$CR
ChxDev   fcc   "/DD/"
ChxPath  fcc   "CMDS"
         fcb   C$CR
*         fcc   ",,,,,,,,,,"
         ENDC

Shell    fcc   "Shell"
CrRtn    fcb   C$CR

AutoEx   fcc   "AutoEx"
         fcb   C$CR

         IFNE  DiskGo
Startup  fcc   "startup -p"
         fcb   C$CR
         fcc   ",,,,,,,,,,"
StartupL equ   *-Startup
         ENDC

* Default time packet
*               YY MM DD HH MM SS
TimePckt fcb   102,08,01,00,00,59

* BASIC reset code
BasicRst fcb   $55
         neg   <$0074
         nop
         clr   >$FF03
         nop
         nop
         sta   >$FFDF		turn off ROM mode
         jmp   >$EF0E		jump to boot
BasicRL  equ   *-BasicRst

* SysGo entry point
start    leax  >IcptRtn,pcr
         os9   F$Icpt
         leax  >BasicRst,pcr
         ldu   #D.CBStrt
         ldb   #BasicRL
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

         IFNE  DiskGo
         leax  >ChxPath,pcr
         lda   #EXEC.
         os9   I$ChgDir
         leax  >ChdDev,pcr
         lda   #UPDAT.
         os9   I$ChgDir
         bcs   DoStrtup
         leax  >ChxDev,pcr
         lda   #EXEC.
         os9   I$ChgDir
         bcc   DoStrtup
         ENDC

* Set priority and do startup file
DoStrtup os9   F$ID
         ldb   #DefPrior
         os9   F$SPrior

         IFNE  DiskGo
* First, do startup
         leax  >Shell,pcr
         leau  >Startup,pcr
         ldd   #256
         ldy   #StartupL
         os9   F$Fork
         bcs   DeadEnd
         os9   F$Wait
         ENDC

* Second, attempt to find AutoEx
FrkAuto  leax  >AutoEx,pcr
         leau  >CrRtn,pcr
         ldd   #256
         ldy   #1
         os9   F$Fork
         bcs   FrkShell
         os9   F$Wait

* Third, do Shell
FrkShell leax  >Shell,pcr
         ldd   #256
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
