********************************************************************
* mc09sdcdesc - Multicomp09 SDCC Device Descriptor Template
*
* $Id$
*
* Edt/Rev  YYYY/MM/DD  Modified by
* Comment
* ------------------------------------------------------------------
*          2015/08/31  ncrook
* Created from 1773 descriptor template

         nam   mc09sddesc
         ttl   Multicomp09 SDCC Device Descriptor Template

         use   defsfile

tylg     set   Devic+Objct
atrv     set   ReEnt+rev
rev      set   $00

* [NAC HACK 2015Sep04] this data structure is described in the TechRef so
* I assume it is Required. The DNum/Type are swapped in the TechRef (Type
* is first) Error here or there?
         IFNDEF DNum
DNum     set   0
         ENDC
* [NAC HACK 2015Sep02] not sure whether the fact I'm emulating a floppy means
* that I need all this stuff, eg for interacting with LSN0? Reconsider later
* and maybe strip it all out
         IFNE  D35
Type     set   TYP.CCF+TYP.3
         ELSE
Type     set   TYP.CCF+TYP.5
         ENDC
         IFNDEF Density
Density  set   DNS.MFM
         ENDC
Step     set   STP.6ms
         IFNDEF Cyls
Cyls     set   35
         ENDC
         IFNDEF Sides
Sides    set   1
         ENDC
Verify   set   1
         IFNDEF SectTrk
SectTrk  set   18
         ENDC
         IFNDEF SectTrk0
SectTrk0 set   18
         ENDC
         IFNDEF Interlv
Interlv  set   3
         ENDC
         IFNDEF SAS
SAS      set   8
         ENDC

         mod   eom,name,tylg,atrv,mgrnam,drvnam

         fcb   DIR.!SHARE.!PEXEC.!PWRIT.!PREAD.!EXEC.!UPDAT. mode byte
         fcb   HW.Page    extended controller address
         fdb   $FFD8      physical controller (base) address
         fcb   initsize-*-1 initialization table size
         fcb   DT.RBF     device type:0=scf,1=rbf,2=pipe,3=scf
         fcb   DNum       drive number
         fcb   Step       step rate
         fcb   Type       drive device type
         fcb   Density    media density:0=single,1=double
         fdb   Cyls       number of cylinders (tracks)
         fcb   Sides      number of sides
         fcb   Verify     verify disk writes:0=on
         fdb   SectTrk    # of sectors per track
         fdb   SectTrk0   # of sectors per track (track 0)
         fdb   OFFSET     high 16 bits of 24-bit block address on
*                         SDcard where this disk image starts.
**nac removed but (for now) keep the entry the same size
**nac         fcb   Interlv    sector interleave factor
**nac         fcb   SAS        minimum size of sector allocation
initsize equ   *

         IFNE  DD
name     fcs   /DD/
         ELSE
name     fcb   'D,'0+DNum+$80
         ENDC
mgrnam   fcs   /RBF/
drvnam   fcs   /mc09sd/

         emod
eom      equ   *
         end
