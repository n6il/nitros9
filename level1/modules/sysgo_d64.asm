********************************************************************
* SysGo - Kickstart module
*
* $Id$
*
* Ed.    Comments                                       Who YY/MM/DD
* ------------------------------------------------------------------
*  -     Original Dragon Data distribution version
*
* $Log$
* Revision 1.3  2003/08/30 20:16:51  boisy
* Made all modules rev 0
*
* Revision 1.2  2002/10/10 14:50:22  boisy
* Added appropriate header
*
* Revision 1.1  2002/07/15 21:34:54  roug
* SysGo is simpler on Dragon 64.
*
* Revision 1.1  2002/04/21 21:27:50  roug
* These are the kernel modules from Dragon 64's OS9Boot.
* OS9 and OS9p2 are older than what's in ../MODULES so I checked them
* in as well.

         nam   SysGo
         ttl   Kickstart module

* Disassembled 02/04/21 22:38:39 by Disasm v1.6 (C) 1988 by RML

         ifp1
         use   defsfile
         use   scfdefs
         endc
tylg     set   Systm+Objct   
atrv     set   ReEnt+rev
rev      set   $00
         mod   eom,name,tylg,atrv,start,size
dataarea rmb   200
size     equ   .
name     equ   *
         fcs   /SysGo/
         fcb   $05 
BootMsg  fcc   "  OS-9 LEVEL ONE   VERSION 1.2"
         fcb   C$CR,C$LF
         fcc   "COPYRIGHT 1980 BY MOTOROLA INC."
         fcb   C$CR,C$LF
	 fcc   "  AND MICROWARE SYSTEMS CORP."
         fcb   C$CR,C$LF
	 fcc   "   REPRODUCED UNDER LICENSE"
         fcb   C$CR,C$LF
	 fcc   "     TO DRAGON DATA LTD."
         fcb   C$CR,C$LF
	 fcc   "     ALL RIGHTS RESERVED."
         fcb   C$CR,C$LF
         fcb   C$LF
MsgEnd   equ   *
ChxPath  fcc   "Cmds"
         fcb   C$CR
	 fcc   ",,,,,,,,,,"
Shell    fcc   "Shell"
         fcb   C$CR
         fcc   ",,,,,,,,,,"
Startup  fcc   "STARTUP -P"
         fcb   C$CR
         fcc   ",,,,,,,,,,"

BasicRst fcb   $55 U
         fcb   $00 
         fcb   $74 t
         fcb   $12 
         fcb   $7F ÿ
         fcb   $FF 
         fcb   $03 
         fcb   $B7 7
         fcb   $FF 
         fcb   $DF _
         fcb   $7E þ
         fcb   $F0 p
         fcb   $02 
start    equ   *
         leax  >IcptRtn,pcr
         os9   F$Icpt   
         leax  >BasicRst,pcr
         ldu   #$0071
         ldb   #$0D
CopyLoop lda   ,x+
         sta   ,u+
         decb  
         bne   CopyLoop

* Print boot message
         leax  >BootMsg,pcr
         ldy   #MsgEnd-BootMsg
         lda   #$01
         os9   I$Write  
         leax  >ChxPath,pcr
         lda   #$04
         os9   I$ChgDir 

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
