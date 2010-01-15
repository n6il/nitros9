********************************************************************
* scdwdesc - Drivewire Network Device Descriptor
*
* $Id$
*
* Edt/Rev  YYYY/MM/DD  Modified by
* Comment
* ------------------------------------------------------------------
*   0.3    2009/12/??  Aaron Wolfe
* Added SHARE. bit to mode.
*
*   0.4    2009/12/27  Boisy G. Pitre
* Removed SHARE. bit from mode because of tsmon issues.
*
*   0.5    2009/12/29  Boisy G. Pitre
* Made U and T descriptor templates. Backspace is now $7F for
* telnet clients which are likely to access the T ports.
*
* This descriptor has slightly different defaults, intended to be used as 
* the channel for the DriveWire utilities
*
*   0.6    2010/01/12  Boisy G. Pitre
* Renamed.

         nam   scdwdesc
         ttl   DriveWire network Device Descriptor

         ifp1  
         use   defsfile
         endc  

tylg     set   Devic+Objct
atrv     set   ReEnt+rev
rev      set   $05

         mod   eom,name,tylg,atrv,mgrnam,drvnam

         fcb   SHARE.+UPDAT.   	mode byte
         fcb   HW.Page    extended controller address
         fdb   $FF00+Addr      physical controller address
         fcb   initsize-*-1 initilization table size
         fcb   DT.SCF     device type:0=scf,1=rbf,2=pipe,3=scf
         fcb   $00        case:0=up&lower,1=upper only
         fcb   $01        backspace:0=bsp,1=bsp then sp & bsp
         fcb   $00        delete:0=bsp over line,1=return
         fcb   $01        echo:0=no echo
         fcb   $01        auto line feed:0=off
         fcb   $00        end of line null count
         fcb   $00        pause:0=no end of page pause
         fcb   24         lines per page (not a safe assumption anymore!)
         fcb   $7F        backspace character (on most telnet clients)
         fcb   C$DEL      delete line character
         fcb   C$CR       end of record character
         fcb   C$EOF      end of file character
         fcb   C$RPRT     reprint line character
         fcb   C$RPET     duplicate last line character
         fcb   C$PAUS     pause character
         fcb   C$INTR     interrupt character
         fcb   C$QUIT     quit character
         fcb   C$BSP      backspace echo character
         fcb   C$BELL     line overflow character (bell)
         fcb   $00        mode byte for terminal descriptor
         fcb   B600       baud rate (not used, maybe future assignment?)
         fdb   name       copy of descriptor name address
         fcb   $00        acia xon char (not used, maybe future assignment?)
         fcb   $00        acia xoff char (not used, maybe future assignment?)
         fcb   80         (szx) number of columns for display
         fcb   24         (szy) number of rows for display
initsize equ   *

         IFNE  TERM
name     fcs   /Term/
         ELSE
name     fcc   /N/
         IFGT  Addr-9
         fcc   '1'
         fcb   176+Addr-10
         ELSE
         fcb   176+Addr
         ENDC
         ENDC
mgrnam   fcs   /SCF/
drvnam   fcs   /scdwn/

         emod  
eom      equ   *
         end   

