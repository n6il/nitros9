********************************************************************
* DX - CC3Disk device descriptor
*
* $Id$
*
* Ed.    Comments                                       Who YY/MM/DD
* ------------------------------------------------------------------

         nam   DX
         ttl   CC3Disk device descriptor

* Disassembled 98/08/23 17:09:41 by Disasm v1.6 (C) 1988 by RML

         ifp1  
         use   defsfile
         use   rbfdefs
         endc  

tylg     set   Devic+Objct
atrv     set   ReEnt+rev
rev      set   $01

DNum     set   0
Type     set   TYP.CCF+TYP.5
Density  set   DNS.MFM
Step     set   STP.6ms
Cyls     set   35
Sides    set   1
Verify   set   1
SectTrk  set   18
SectTrk0 set   18
Interlv  set   3
SAS      set   8

         mod   eom,name,tylg,atrv,mgrnam,drvnam

         fcb   DIR.!ISIZ.!SHARE.!PEXEC.!PWRIT.!PREAD.!EXEC.!UPDAT. mode byte
         fcb   HW.Page    extended controller address
         fdb   $FF40      physical controller address
         fcb   initsize-*-1 initilization table size
         fcb   DT.RBF     device type:0=scf,1=rbf,2=pipe,3=scf
         fcb   dnum       drive number
         fcb   Step       step rate
         fcb   Type       drive device type
         fcb   Density    media density:0=single,1=double
         fdb   Cyls       number of cylinders (tracks)
         fcb   Sides      number of sides
         fcb   Verify     verify disk writes:0=on
         fdb   SectTrk    # of sectors per track
         fdb   SectTrk0   # of sectors per track (track 0)
         fcb   Interlv    sector interleave factor
         fcb   SAS        minimum size of sector allocation
initsize equ   *

         ifne  DD
name     fcs   /DD/
         else
name     fcc   /D/
         fcb   176+dnum
         endc
mgrnam   fcs   /RBF/
drvnam   fcs   /CC3Disk/

         emod  
eom      equ   *
         end   

