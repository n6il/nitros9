********************************************************************
* Init - OS-9 Level Two Configuration module
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
*          2003/11/5   Robert Gault
* Corrected CC3IO info regards mouse. Changed from fcb to fdb low res/ right
* Corrected OS9Defs to match.

         nam   Init
         ttl   OS-9 Level Two Configuration module

         ifp1  
         use   defsfile
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
         fcb   NOS9Vrsn   OS version
         fcb   NOS9Major  OS major revision
         fcb   NOS9Minor  OS minor revision
         fcb   $00        feature byte #1
         fcb   $00        feature byte #2
         fcb   0,0,0,0,0,0,0,0  reserved

* CC3IO section
         fcb   Monitor    monitor type
         fcb   0,1        mouse info, low res right mouse
         fcb   $1E        key repeat start constant
         fcb   $03        key repeat delay constant

name     fcs   "Init"
         fcb   edition

DefProg  fcs   "SysGo"
DefDev   fcs   "/DD"
DefCons  fcs   "/Term"
DefBoot  fcs   "Boot"

         emod  
eom      equ   *
         end   
