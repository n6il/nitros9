********************************************************************
* Y0 - Remote file manager test
*

         nam   Y0
         ttl   Remote File Manager Device Descriptor

         ifp1  
         use   defsfile
         endc  


tylg     set   Devic+Objct
atrv     set   ReEnt+rev
rev      set   $00

         mod   eom,name,tylg,atrv,mgrnam,drvnam

         fcb   READ.+WRITE. mode byte
         fcb   $00        extended controller address
         fdb   $0000      physical controller address
         fcb   initsize-*-1 initilization table size
         fcb   DT.RFM    device type:0=scf,1=rbf,2=pipe,3=scf
initsize equ   *

name     fcs   /Y0/
mgrnam   fcs   /RFM/
drvnam   fcs   /RFMDrv/


         emod  
eom      equ   *
         end   

