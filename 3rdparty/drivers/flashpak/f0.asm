         nam   f0
         ttl   Cloud-9 Flash Pak descriptor

         ifp1  
         use   defsfile
         endc  

tylg     set   Devic+Objct
atrv     set   ReEnt+rev
rev      set   $02

         mod   eom,name,tylg,atrv,mgrnam,drvnam

         fcb   DIR.!ISIZ.!SHARE.!PEXEC.!PWRIT.!PREAD.!EXEC.!UPDAT. mode byte
         fcb   HW.Page    extended controller address
         fdb   $FF5C      physical controller address
         fcb   initsize-*-1 initilization table size
         fcb   DT.RBF     device type:0=scf,1=rbf,2=pipe,3=scf
         fcb   0          drive number
         fcb   0          step rate
         fcb   TYP.NSF    drive device type
         fcb   DNS.MFM    media density:0=single,1=double
         fdb   32         number of cylinders (tracks)
         fcb   1          number of sides
         fcb   1          verify disk writes:0=on
         fdb   64         # of sectors per track
         fdb   64         # of sectors per track (track 0)
         fcb   1          sector interleave factor
         fcb   1          minimum size of sector allocation

initsize equ   *
name     fcs   /f0/
mgrnam   fcs   /RBF/
drvnam   fcs   /FlashPak/

         emod  
eom      equ   *
         end   
