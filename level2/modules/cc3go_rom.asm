********************************************************************
* CC3Go - Kickstart program module for ROM systems
*
* $Id$
*
* Ed.    Comments                                       Who YY/MM/DD
* ------------------------------------------------------------------
* 5      Taken from OS-9 L2 Tandy distribution and      BGP 98/10/12
*        modified banner for V3

         nam   CC3Go
         ttl   Kickstart program module for ROM systems

         ifp1
         use   defsfile
         use   scfdefs
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

Banner   fcc   / OS-9 LEVEL TWO VR. 0/
         fcb   48+OS9Vrsn
         fcc   /.0/
         fcb   48+OS9Major
         fcc   /.0/
         fcb   48+OS9Minor
         fcb   C$CR,C$LF
         fcc   /     COPYRIGHT 1988 BY/
         fcb   C$CR,C$LF
         fcc   /   MICROWARE SYSTEMS CORP./
         fcb   C$CR,C$LF
         fcc   /   LICENSED TO TANDY CORP./
         fcb   C$CR,C$LF
         fcc   /    ALL RIGHTS RESERVED./
         fcb   C$CR,C$LF
         fcb   C$LF
BannLen  equ   *-Banner
AutoEx   fcc   "AutoEx"
         fcb   C$CR
Shell    fcc   "Shell"
         fcb   C$CR
ShellPrm fcc   "i=/1"
CRtn     fcb   C$CR
ShellPL  equ   *-ShellPrm

DefTime  fcb   88,10,01,00,00,00

start    leax  >IcptRtn,pcr
         os9   F$Icpt
         os9   F$ID
         ldb   #128
         os9   F$SPrior
         leax  >Banner,pcr
         ldy   #BannLen
         lda   #$01                    standard output
         os9   I$Write                 write out banner
         leax  >DefTime,pcr
         os9   F$STime                 set time to default

* Fork AutoEx here
         pshs  u
         leax  >AutoEx,pcr
         leau  >CRtn,pcr
         ldd   #$0100
         ldy   #$0001
         os9   F$Fork
         bcs   L0186
         os9   F$Wait
L0186    puls  u
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
