********************************************************************
* DDD0_35S - CCDisk default device descriptor
*
* $Id$
*
* Ed.    Comments                                       Who YY/MM/DD
* ------------------------------------------------------------------
*        From Tandy OS-9 Level One VR 02.00.00

         nam   DDD0_35S
         ttl   CCDisk default device descriptor

* Disassembled 98/08/23 17:09:41 by Disasm v1.6 (C) 1988 by RML

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
         fdb   DPort      physical controller address
         fcb   initsize-*-1 initilization table size
         fcb   DT.RBF     device type:0=scf,1=rbf,2=pipe,3=scf
         fcb   dnum       drive number
         fcb   $00        step rate
         fcb   TYP.CCF+TYP.5 drive device type
         fcb   DNS.MFM    media density:0=single,1=double
         fdb   35         number of cylinders (tracks)
         fcb   1          number of sides
         fcb   0          verify disk writes:0=on
         fdb   18         # of sectors per track
         fdb   18         # of sectors per track (track 0)
         fcb   2          sector interleave factor
         fcb   8          minimum size of sector allocation
initsize equ   *

name     fcs   /DD/
mgrnam   fcs   /RBF/
drvnam   fcs   /CCDisk/

         emod  
eom      equ   *
         end   

