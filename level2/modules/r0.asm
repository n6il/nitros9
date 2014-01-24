********************************************************************
* R0 - RAMMER Device Descriptor
*
* $Id$
*
* Edt/Rev  YYYY/MM/DD  Modified by
* Comment
* ------------------------------------------------------------------

         nam   R0
         ttl   RAMMER Device Descriptor

         ifp1  
         use   defsfile
         endc  

tylg     set   Devic+Objct
atrv     set   ReEnt+rev
rev      set   $00

         IFNDEF RAMSize
RAMSize  set   128
         ENDC
         IFNDEF SAS
SAS      set   4
         ENDC

         mod   eom,name,tylg,atrv,mgrnam,drvnam

         fcb   DIR.+SHARE.+PREAD.+PWRIT.+PEXEC.+READ.+WRITE.+EXEC. mode byte
         fcb   HW.Page    extended controller address
         fdb   $FFE0      physical controller address
         fcb   initsize-*-1 initilization table size
         fcb   DT.RBF     device type:0=scf,1=rbf,2=pipe,3=scf
         fcb   $00        drive number
         fcb   $00        step rate
         fcb   $20        drive device type
         fcb   $01        media density:0=single,1=double
         fdb   RAMSize
         fcb   $01        number of sides
         fcb   $01        verify disk writes:0=on
         fdb   4          # of sectors per track
         fdb   4          # of sectors per track (track 0)
         fcb   $01        sector interleave factor
         fcb   SAS        minimum size of sector allocation
initsize equ   *

         IFNE  DD
name     fcs   /DD/
         ELSE
name     fcs   /R0/
         ENDC
mgrnam   fcs   /RBF/
drvnam   fcs   /Rammer/

         emod  
eom      equ   *
         end   
