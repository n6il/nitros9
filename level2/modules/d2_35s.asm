         nam   D2
         ttl   CC3Disk device descriptor

* Disassembled 98/08/23 17:09:41 by Disasm v1.6 (C) 1988 by RML

         ifp1  
         use   defsfile
         use   rbfdefs
         endc  

dnum     equ   2

tylg     set   Devic+Objct
atrv     set   ReEnt+rev
rev      set   $01

         mod   eom,name,tylg,atrv,mgrnam,drvnam

         fcb   DIR.!ISIZ.!SHARE.!PEXEC.!PWRIT.!PREAD.!EXEC.!UPDAT. mode byte
         fcb   $07        extended controller address
         fdb   $FF40      physical controller address
         fcb   initsize-*-1 initilization table size
         fcb   DT.RBF     device type:0=scf,1=rbf,2=pipe,3=scf
         fcb   dnum       drive number
         fcb   STP.6ms    step rate
         fcb   TYP.CCF+TYP.5 drive device type
         fcb   DNS.MFM    media density:0=single,1=double
         fdb   35         number of cylinders (tracks)
         fcb   1          number of sides
         fcb   1          verify disk writes:0=on
         fdb   18         # of sectors per track
         fdb   18         # of sectors per track (track 0)
         fcb   3          sector interleave factor
         fcb   8          minimum size of sector allocation
initsize equ   *

name     fcc   /D/
         fcb   176+dnum
mgrnam   fcs   /RBF/
drvnam   fcs   /CC3Disk/

         emod  
eom      equ   *
         end   

