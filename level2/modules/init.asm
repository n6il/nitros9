********************************************************************
* Init - OS-9 Level Two V3 Configuration module
*
* $Id$
*
* Ed.    Comments                                       Who YY/MM/DD
* ------------------------------------------------------------------
* 204    Original OS-9 L2 Tandy distribution
* 205    Added CC3IO and Clock sections                 BGP 98/10/12
* 205b   Removed clock information from here            BGP 98/10/20

         nam   Init
         ttl   OS-9 Level Two V3 Configuration module

         ifp1  
         use   defsfile
         endc  

tylg     set   Systm+$00
atrv     set   ReEnt+rev
rev      set   $02
edition  set   $CD

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
         fcb   OS9Vrsn    OS version
         fcb   OS9Major   OS major revision
         fcb   OS9Minor   OS minor revision
         fcb   $00        compatibility flag #1
* CC3IO section
         fcb   Monitor    monitor type
         fcb   $1E        key repeat start constant
         fcb   $03        key repeat delay constant

name     fcs   "Init"
         fcb   edition

DefProg  fcs   "CC3Go"
DefDev   fcs   "/DD"
DefCons  fcs   "/Term"
DefBoot  fcs   "Boot"

         emod  
eom      equ   *
         end   
