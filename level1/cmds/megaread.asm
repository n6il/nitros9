********************************************************************
* MegaRead - Disk Performance Utility
*
* $Id$
*
* This dir initially started from the dir command that came with
* the OS-9 Level Two package, then incorporated Glenside's Y2K
* fix.
*
* Edt/Rev  YYYY/MM/DD  Modified by
* Comment
* ------------------------------------------------------------------
*  10      1999/05/11  Boisy G. Pitre
* Incorporated Glenside Y2K fixes.
*
*  11      2003/01/14  Boisy G. Pitre
* Made option handling more flexible, now they must be preceeded
* by a dash.

         nam   MegaRead
         ttl   Disk Performance Utilty

         IFP1
         use   defsfile
         ENDC

tylg     set   Prgrm+Objct   
atrv     set   ReEnt+rev
rev      set   $00
edition  set   1

ReadK    equ   1024       1024K is 1 megabyte (modify as desired)
                         
         mod   eom,name,tylg,atrv,start,size

         org   0
KiloBuff rmb   $0400     
         rmb   200        stack space
size     equ   .

name     fcs   /MegaRead/
         fcb   edition

start    ldx   #ReadK    
loop     pshs  x          save counter
         leax  KiloBuff,u point (X) to buffer
         ldy   #$0400     read 1K
         clra             std input
         os9   I$Read    
         bcs   ex     
         puls  x          recover counter
         leax  -1,x       done yet?
         bne   loop       no, go get another 1K
ex       clrb            
         os9   F$Exit    
                         
         emod            
eom      equ   *         
         end             
