********************************************************************
* H0 - CCHDisk device descriptor
*
* $Id$
*
* Ed.    Comments                                       Who YY/MM/DD
* ------------------------------------------------------------------
*        Tandy/Microware original version

         nam   H0
         ttl   CCHDisk device descriptor

* Disassembled 98/08/23 18:21:46 by Disasm v1.6 (C) 1988 by RML

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
         fdb   $FF51      physical controller address
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
         fcb   1          minimum size of sector allocation
         fcb   $00
         fcb   $00
         fcb   $00
         fcb   $00
         fcb   $20
         fcb   $09
         fcb   $00
         fcb   $C0
         fcb   $01
         fcb   $01
         fcb   $0D
initsize equ   *

name     fcc   /H/
         fcb   176+dnum
mgrnam   fcs   /RBF/
drvnam   fcs   /CCHDisk/

         emod  
eom      equ   *
         end   

