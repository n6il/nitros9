********************************************************************
* P1 - Serial port used as printer device descriptor
*
* $Id$
*
* Ed.    Comments                                       Who YY/MM/DD
* ------------------------------------------------------------------
*  -     Original Dragon Data distribution version

         nam   P1
         ttl   Serial port used as printer device descriptor

* Disassembled 02/04/21 22:38:15 by Disasm v1.6 (C) 1988 by RML

         ifp1
         use   defsfile
         use   scfdefs
         endc

tylg     set   Devic+Objct   
atrv     set   ReEnt+rev
rev      set   $00

         mod   eom,name,tylg,atrv,mgrnam,drvnam

         fcb   READ.+WRITE. mode byte
         fcb   HW.Page extended controller address
         fdb   $FF04  physical controller address
         fcb   initsize-*-1  initilization table size
         fcb   DT.SCF device type:0=scf,1=rbf,2=pipe,3=scf
         fcb   $00 case:0=up&lower,1=upper only
         fcb   $00 backspace:0=bsp,1=bsp then sp & bsp
         fcb   $00 delete:0=bsp over line,1=return
         fcb   $00 echo:0=no echo
         fcb   $01 auto line feed:0=off
         fcb   $00 end of line null count
         fcb   $00 pause:0=no end of page pause
         fcb   66 lines per page
         fcb   $00 backspace character
         fcb   $00 delete line character
         fcb   $00 end of record character
         fcb   $00 end of file character
         fcb   $00 reprint line character
         fcb   $00 duplicate last line character
         fcb   $00 pause character
         fcb   $00 interrupt character
         fcb   $00 quit character
         fcb   $00 backspace echo character
         fcb   $00 line overflow character (bell)
         fcb   $00 init value for dev ctl reg
         fcb   B1200 baud rate
         fdb   name copy of descriptor name address
         fcb   C$XON acia xon char
         fcb   C$XOFF acia xoff char
initsize equ   *

name     fcs   /P1/
mgrnam   fcs   /scf/
drvnam   fcs   /acia51/

         emod
eom      equ   *
         end
