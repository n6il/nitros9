         nam   F0
         ttl   Flashpak descriptor

MPISlot  equ   1          (slot 0-3)

         ifp1  
         use  defsfile
         endc  

tylg     set   Devic+Objct
atrv     set   ReEnt+rev
rev      set   $02

         mod   eom,name,tylg,atrv,mgrnam,drvnam

         fcb   DIR.!ISIZ.!SHARE.!PEXEC.!PWRIT.!PREAD.!EXEC.!UPDAT. mode=0xff
         fcb   $07        extended controller address
         fdb   $FF40      physical controller address
         fcb   initsize-*-1 initilization table size
* RBF-specific header starts here
         fcb   DT.RBF     device type:0=scf,1=rbf,2=pipe,3=scf
         fcb   MPISlot    drive number
         fcb   0          step rate
         fcb   TYP.NSF    drive device type (Non-standard format)
         fcb   DNS.MFM    media density (Double-density)
         fdb   8          number of cylinders (tracks)
         fcb   1          number of sides
         fcb   1          Don't verify disk writes
         fdb   64         # of sectors per track
         fdb   64         # of sectors per track (track 0)
         fcb   1          sector interleave factor
         fcb   1          minimum size of sector allocation

initsize equ   *
name     fcs   /F0/
mgrnam   fcs   /RBF/
drvnam   fcs   /FlashPak/

         emod  
eom      equ   *
         end   
