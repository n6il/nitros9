********************************************************************
* MegaRead - Disk Performance Utility
*
* $Id$
*
* Modified from an original program by Caveh Jalali
*
* Edt/Rev  YYYY/MM/DD  Modified by
* Comment
* ------------------------------------------------------------------
*  01/01   1987/05/30  Bruce Isted (CIS PPN 76625,2273)
* Released to the public domain
*
*  01/00   2004/04/22  Boisy G. Pitre
* Ported to NitrOS-9 style, no error on exit
*
*  01/01   2004/04/22  Rodney V. Hamilton
* Added EOF check for floppy

         nam   MegaRead
         ttl   Disk Performance Utilty

         IFP1
         use   defsfile
         ENDC

tylg     set   Prgrm+Objct   
atrv     set   ReEnt+rev
rev      set   $01
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
         bcs   eofchk    
         puls  x          recover counter
         leax  -1,x       done yet?
         bne   loop       no, go get another 1K
         bra   exitok     yes, exit
eofchk   cmpb  #E$EOF     end of media?
         bne   exit       no, a real error
exitok   clrb            
exit     os9   F$Exit    

         emod            
eom      equ   *         
         end             
