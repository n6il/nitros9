********************************************************************
* progname - program module
*
* $Id$
*
* Ed.    Comments                                       Who YY/MM/DD
* ------------------------------------------------------------------
*  -     Original Dragon Data distribution version
*
*

         nam   TERM
         ttl   Console device descriptor (32 cols, uppercase)

* Disassembled 02/04/21 22:38:40 by Disasm v1.6 (C) 1988 by RML

         ifp1
         use   defsfile
         endc
tylg     set   Devic+Objct   
atrv     set   ReEnt+rev
rev      set   $01
         mod   eom,name,tylg,atrv,mgrnam,drvnam
         fcb   $03 mode byte
         fcb   $FF extended controller address
         fdb   $C000  physical controller address
         fcb   initsize-*-1  initilization table size
         fcb   $00 device type:0=scf,1=rbf,2=pipe,3=scf
         fcb   $01 case:0=up&lower,1=upper only
         fcb   $01 backspace:0=bsp,1=bsp then sp & bsp
         fcb   $00 delete:0=bsp over line,1=return
         fcb   $01 echo:0=no echo
         fcb   $01 auto line feed:0=off
         fcb   $00 end of line null count
         fcb   $01 pause:0=no end of page pause
         fcb   $10 lines per page
         fcb   $08 backspace character
         fcb   $18 delete line character
         fcb   $0D end of record character
         fcb   $1B end of file character
         fcb   $04 reprint line character
         fcb   $01 duplicate last line character
         fcb   $17 pause character
         fcb   $03 interrupt character
         fcb   $05 quit character
         fcb   $08 backspace echo character
         fcb   $07 line overflow character (bell)
         fcb   $00 init value for dev ctl reg
         fcb   $00 baud rate
         fdb   name copy of descriptor name address
         fcb   $00 acia xon char
         fcb   $00 acia xoff char
initsize equ   *
name     equ   *
         fcs   /TERM/
mgrnam   equ   *
         fcs   /SCF/
drvnam   equ   *
         fcs   /KBVDIO/
         emod
eom      equ   *
