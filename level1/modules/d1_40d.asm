********************************************************************
* D1_40D - CCDisk device descriptor
*
* $Id$
*
* Ed.    Comments                                       Who YY/MM/DD
* ------------------------------------------------------------------
*        From Tandy OS-9 Level One VR 02.00.00

         nam   D1_40D
         ttl   CCDisk device descriptor

* Disassembled 98/08/23 17:09:41 by Disasm v1.6 (C) 1988 by RML

         ifp1  
         use   defsfile
         use   rbfdefs
         endc  

dnum     set   1
steprate set   0
dtype    set   TYP.CCF+TYP.5
density  set   DNS.MFM
tracks   set   40
sides    set   2
verify   set   1
nsect    set   18
nsect0   set   nsect
ilv      set   2
sas      set   8

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
         fcb   steprate   step rate
         fcb   dtype      drive device type
         fcb   density    media density:0=single,1=double
         fdb   tracks     number of cylinders (tracks)
         fcb   sides      number of sides
         fcb   verify     verify disk writes:0=on
         fdb   nsect      # of sectors per track
         fdb   nsect0     # of sectors per track (track 0)
         fcb   ilv        sector interleave factor
         fcb   sas        minimum size of sector allocation
initsize equ   *

name     fcc   /D/
         fcb   176+dnum
mgrnam   fcs   /RBF/
drvnam   fcs   /CCDisk/

         emod  
eom      equ   *
         end   

