********************************************************************
* SysGo - Kickstart program module
*
* $Id$
*
* Edt/Rev  YYYY/MM/DD  Modified by
* Comment
* ------------------------------------------------------------------
*   5      1998/10/12  Boisy G. Pitre
* Taken from OS-9 L2 Tandy distribution and modified banner for V3.
*
*   5r2    2003/01/08  Boisy G. Pitre
* Fixed fork behavior so that if 'shell startup' fails, system doesn't
* jmp to Crash, but tries AutoEx instead.  Also changed /DD back to /H0
* for certain boot floppy cases.
*
*          2003/09/04  Boisy G. Pitre
* Back-ported to OS-9 Level One.
*
*   5r3    2003/12/14  Boisy G. Pitre
* Added SHIFT key check to prevent startup/autoex from starting if
* held down.  Gene Heskett, this Bud's for you.

         nam   SysGo
         ttl   Kickstart program module

         IFP1
         use   defsfile
         use   scfdefs
         ENDC

tylg     set   Prgrm+Objct
atrv     set   ReEnt+rev
rev      set   $03
edition  set   $05

         mod   eom,name,tylg,atrv,start,size


         org   0
InitAddr rmb   2
         rmb   250
size     equ   .

name     fcs   /SysGo/
         fcb  edition

* Default process priority
DefPrior set   128         

Banner   equ   *
         fcc   /(C) 2012 The NitrOS-9 Project/
CrRtn    fcb   C$CR,C$LF
         IFNE  NOS9DBG
         fcc   "**   DEVELOPMENT BUILD   **"
         fcb   C$CR,C$LF
         fcc   "** NOT FOR DISTRIBUTION! **"
         fcb   C$CR,C$LF
         ENDC
         dts   
         fcb   C$CR,C$LF
         fcc   !http://www.nitros9.org!
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
         ENDC

Shell    fcc   "Shell"
         fcb   C$CR
AutoEx   fcc   "AutoEx"
         fcb   C$CR
AutoExPr fcc   ""
         fcb   C$CR
AutoExPrL equ  *-AutoExPr

         IFEQ  ROM
Startup  fcc   "startup -p"
         fcb   C$CR
StartupL equ  *-Startup
         ENDC

ShellPrm equ   *
         IFGT  Level-1
         fcc   "i=/1"
         ENDC
CRtn     fcb   C$CR
ShellPL  equ   *-ShellPrm

* Default time packet
DefTime  dtb

Init     fcs   /Init/

* Entry: X = pointer to start of nul terminated string
* Exit:  D = length of string
strlen   pshs  x
         ldd   #-1
go@      addd  #$0001
         tst   ,x+
         bne   go@
         puls  x,pc

WriteCR  pshs  y
         leax  CrRtn,pcr
         ldy   #$0001
         os9   I$WritLn
         puls  y,pc
         
* SysGo Entry Point
start
         leax  >IcptRtn,pcr
         os9   F$Icpt
* Set priority of this process
         os9   F$ID
         ldb   #DefPrior
         os9   F$SPrior

* Write OS name and Machine name strings
         leax  Init,pcr
         clra
         pshs  u
         os9   F$Link
         bcs   SignOn
         stx   <InitAddr
         ldd   OSName,u					point to OS name in INIT module
         leax  d,u						point to install name in INIT module
         bsr   strlen         
         tfr   d,y
         lda   #$01
         os9   I$Write
         bsr   WriteCR
         ldd   InstallName,u
         leax  d,u						point to install name in INIT module
         bsr   strlen         
         tfr   d,y
         lda   #$01
         os9   I$Write
         bsr   WriteCR
         
* Show rest of banner
SignOn
         puls  u
         leax  >Banner,pcr
         ldy   #BannLen
         lda   #$01                    standard output
         os9   I$Write                 write out banner

* Set default time
         leax  >DefTime,pcr
         os9   F$STime                 set time to default
         IFEQ  ROM
* Change EXEC and DATA dirs
         leax  >ExecDir,pcr
         lda   #EXEC.
         os9   I$ChgDir                change exec. dir
         leax  >DefDev,pcr
* Made READ. so that no write occurs at boot (Boisy on Feb 5, 2012)
*         lda   #READ.+WRITE.
         lda   #READ.
         os9   I$ChgDir                change data dir.
         bcs   L0125
         leax  >HDDev,pcr
         lda   #EXEC.
         os9   I$ChgDir                change exec. dir to HD
         ENDC

L0125    equ   *
         pshs  u,y
         IFEQ  ROM
* Fork shell startup here
* Added 12/14/03: If SHIFT is held down, startup is not run
         lda   #$01			standard output
         ldb   #SS.KySns
         os9   I$GetStt
         bcs   DoStartup
         bita  #SHIFTBIT		SHIFT key down?
         bne   L0186			Yes, don't to startup or autoex
DoStartup leax  >Shell,pcr
         leau  >Startup,pcr
         ldd   #256
         ldy   #StartupL
         os9   F$Fork
         bcs   DoAuto
         os9   F$Wait
         ENDC
* Fork AutoEx here
DoAuto   leax  >AutoEx,pcr
         leau  >AutoExPr,pcr
         ldd   #$0100
         ldy   #AutoExPrL
         os9   F$Fork
         bcs   L0186
         os9   F$Wait
*         bra   DoAuto
L0186    equ   *
         puls  u,y
FrkShell leax  >ShellPrm,pcr
         leay  ,u
         ldb   #ShellPL
L0190    lda   ,x+
         sta   ,y+
         decb
         bne   L0190
* Fork final shell here
         leax  >Shell,pcr
         lda   #$01		D = 256 (B already 0 from above)
         ldy   #ShellPL
         os9   F$Fork
         bcs   DeadEnd
         os9   F$Wait
         bcc   FrkShell
DeadEnd  bra   DeadEnd

IcptRtn  rti

         emod
eom      equ   *
         end
