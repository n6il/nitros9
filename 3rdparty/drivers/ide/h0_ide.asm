********************************************************************
* H0 - CCIDE device descriptor
*
* $Id$
*
* Ed.    Comments                                       Who YY/MM/DD
* ------------------------------------------------------------------

         nam   H0
         ttl   IDE device descriptor

         ifp1  
         use   defsfile
         use   rbfdefs
         endc  

dnum     equ   0

tylg     set   Devic+Objct
atrv     set   ReEnt+rev
rev      set   $01

         mod   eom,name,tylg,atrv,mgrnam,drvnam

         fcb   DIR.!ISIZ.!SHARE.!PEXEC.!PWRIT.!PREAD.!EXEC.!UPDAT. mode byte
         fcb   HW.Page    extended controller address
         fdb   $FF70      physical controller address
         fcb   initsize-*-1 initilization table size
         fcb   DT.RBF     device type:0=scf,1=rbf,2=pipe,3=scf
         fcb   dnum       drive number
         fcb   $00        step rate
         fcb   TYP.HARD   drive device type
         fcb   DNS.FM     media density:0=single,1=double
         fdb   306        number of cylinders (tracks)
         fcb   6          number of sides
         fcb   0          verify disk writes:0=on
         fdb   32         # of sectors per track
         fdb   32         # of sectors per track (track 0)
         fcb   26         sector interleave factor
         fcb   8          minimum size of sector allocation
initsize equ   *

name     fcc   /H/
         fcb   176+dnum
mgrnam   fcs   /RBF/
drvnam   fcs   /CCIDE/

         emod  
eom      equ   *
         end   
