********************************************************************
* Init - OS-9 Level One V2 Configuration module
*
* $Id$
*
* Ed.    Comments                                       Who YY/MM/DD
* ------------------------------------------------------------------
*        From Tandy OS-9 Level One VR 02.00.00

         nam   Init
         ttl   OS-9 Level One V2 Configuration module

         ifp1
         use   defsfile
         endc

tylg     set   Systm+$00
atrv     set   ReEnt+rev
rev      set   $00

         mod   eom,name,tylg,atrv,$00f8,size

         rmb   12
size     equ   .

* Init table
start    equ   *
         fcb   12         number of IRQ polling entires
         fdb   DefProg    offset to program to fork
         fdb   DefDev     offset to default disk device
         fdb   DefCons    offset to default console device
         fdb   DefBoot    offset to boot module name
         fcb   $01        write protect flag (?)
         fcb   Level      OS level
         fcb   NOS9Vrsn   OS version
         fcb   NOS9Major  OS major revision
         fcb   NOS9Minor  OS minor revision
         fcb   CRCOn      feature byte #1
         fcb   $00        feature byte #2

name     fcs   "Init"

DefProg  fcs   "SysGo"
DefDev   fcs   "/DD"
DefCons  fcs   "/Term"
DefBoot  fcs   "Boot"

         emod
eom      equ   *
         end
