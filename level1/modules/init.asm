********************************************************************
* Init - NitrOS-9 Configuration module
*
* $Id$
*
* Edt/Rev  YYYY/MM/DD  Modified by
* Comment
* ------------------------------------------------------------------
* 204      1998/10/12  Boisy G. Pitre
* Original OS-9 L2 Tandy distribution.
*
* 205      1998/10/20  Boisy G. Pitre
* Added CC3IO and Clock sections.
*
* 205r2    1998/10/20  Boisy G. Pitre
* Removed clock information from here.
*
*   1      2003/01/08  Boisy G. Pitre
* Restarted edition number back to 1, removed CMDS/cc3go reference and
* just have cc3go so that in certain cases, cc3go can be in the bootfile,
* and so that ROMmed systems don't have to have a special init module.
*
*          2003/11/05  Robert Gault
* Corrected CC3IO info regards mouse. Changed from fcb to fdb low res/ right
* Corrected OS9Defs to match.
*
*	   2006/07/06	P.Harvey-Smith.
* Conditionally excluded port messages on Dragon Alpha, due to insufficient
* space !
*

         nam   Init
         ttl   NitrOS-9 Configuration module

         ifp1  
         use   defsfile
         IFGT  Level-1
         use	cocovtio.d
         ENDC
         endc  

tylg     set   Systm+$00
atrv     set   ReEnt+rev
rev      set   $00
edition  set   1

         mod   eom,name,tylg,atrv,$0FE0,$0015

***** USER MODIFIABLE DEFINITIONS HERE *****

* Init table
start    equ   *
         fcb   $27        number of IRQ polling entires
         fdb   DefProg    offset to program to fork
         fdb   DefDev     offset to default disk device
         fdb   DefCons    offset to default console device
         fdb   DefBoot    offset to boot module name
         fcb   $01        write protect flag (?)
         fcb   Level      OS level
         fcb   NOS9VER    OS version
         fcb   NOS9MAJ    OS major revision
         fcb   NOS9MIN    OS minor revision
         IFNE  H6309
         fcb   Proc6309+CRCOff     feature byte #1
         ELSE
         fcb   CRCOff     feature byte #1
         ENDC
         fcb   $00        feature byte #2
         fdb   OSStr
         fdb   InstStr
         fcb   0,0,0,0  reserved

         IFGT  Level-1
* CC3IO section
         fcb   Monitor    monitor type
         fcb   0,1        mouse info, low res right mouse
         fcb   $1E        key repeat start constant
         fcb   $03        key repeat delay constant
         ENDC

name     fcs   "Init"
         fcb   edition

DefProg  fcs   "SysGo"
DefDev   fcs   "/DD"
DefCons  fcs   "/Term"
DefBoot  fcs   "Boot"

*
* The DragonAlpha is so pushed for boot track space, that we have to exclude these
* messages !
*

	     IFEQ	dalpha
OSStr    equ   *
         fcc   "NitrOS-9/"
         IFNE  H6309
         fcc   /6309 /
         ELSE
         fcc   /6809 /
         ENDC
         fcc   /Level /
         fcb   '0+Level
         fcc   / V/
         fcb   '0+NOS9VER
         fcc   /./
         fcb   '0+NOS9MAJ
         fcc   /./
         fcb   '0+NOS9MIN
         fcb   0

InstStr  equ   *
         IFNE   coco
         fcc    "Radio Shack Color Computer"
         ELSE
         IFNE   coco3
         fcc    "Tandy Color Computer 3"
         ELSE
         IFNE   tano
         fcc    "Tano Dragon (US)"
         ELSE
         IFNE   d64
         fcc    "Dragon 64 (UK)"
         ELSE
         IFNE   dalpha
         fcc    "Dragon Alpha"
         ELSE
         IFNE   atari
         fcc    "Atari XL/XE"
         ELSE
         fcc    "Unknown Machine"
         ENDC
         ENDC
         ENDC
         ENDC
         ENDC
         ENDC
         fcb   0
		 ELSE
OSStr    equ   *
InstStr  equ   *
		 fcb	0
		 ENDC

         emod  
eom      equ   *
         end   
