********************************************************************
* SSC - Tandy Speech/Sound Pak descriptor
*
* $Id$
*
* Ed.    Comments                                       Who YY/MM/DD
* ------------------------------------------------------------------
*        From Tandy OS-9 Level One VR 02.00.00

         nam   SSC
         ttl   Tandy Speech/Sound Pak descriptor

* Disassembled 98/08/23 17:18:22 by Disasm v1.6 (C) 1988 by RML

         ifp1
         use   defsfile
         use   scfdefs
         endc

tylg     set   Devic+Objct   
atrv     set   ReEnt+rev
rev      set   $00

         mod   eom,name,tylg,atrv,mgrnam,drvnam

         fcb   READ.+WRITE. mode byte
         fcb   HW.Page    extended controller address
         fdb   $0000      physical controller address
         fcb   initsize-*-1  initilization table size
         fcb   DT.SCF     device type:0=scf,1=rbf,2=pipe,3=scf
         fcb   $00        case:0=up&lower,1=upper only
         fcb   $00        backspace:0=bsp,1=bsp then sp & bsp
         fcb   $01        delete:0=bsp over line,1=return
         fcb   $00        echo:0=no echo
         fcb   $00        auto line feed:0=off
         fcb   $00        end of line null count
         fcb   $00        pause:0=no end of page pause
         fcb   $00        lines per page
         fcb   C$BSP      backspace character
         fcb   C$DEL      delete line character
         fcb   C$CR       end of record character
         fcb   $00        end of file character
         fcb   C$RPRT     reprint line character
         fcb   C$RPET     duplicate last line character
         fcb   $00        pause character
         fcb   $00        interrupt character
         fcb   $00        quit character
         fcb   $00        backspace echo character
         fcb   $00        line overflow character (bell)
         fcb   $00        init value for dev ctl reg
         fcb   $00        baud rate
         fdb   name       copy of descriptor name address
         fcb   $00        acia xon char
         fcb   $00        acia xoff char
initsize equ   *

name     fcs   /SSC/
mgrnam   fcs   /SCF/
drvnam   fcs   /SSCPAK/

         emod
eom      equ   *
         end

