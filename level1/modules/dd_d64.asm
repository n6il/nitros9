********************************************************************
* DD - 40-track floppy disk device descriptor
*
* $Id$
*
* Ed.    Comments                                       Who YY/MM/DD
* ------------------------------------------------------------------
*  -     Original Dragon Data distribution version
*
* $Log$
* Revision 1.3  2003/08/30 20:16:51  boisy
* Made all modules rev 0
*
* Revision 1.2  2002/10/10 14:50:21  boisy
* Added appropriate header
*
* Revision 1.1  2002/07/18 19:53:53  roug
* Checking in the floppy disk device descriptors for Dragon 64
*
* Revision 1.2  2002/04/21 21:46:22  roug
* Better titles in source files
*
* Revision 1.1  2002/04/21 21:27:50  roug
* These are the kernel modules from Dragon 64's OS9Boot.
* OS9 and OS9p2 are older than what's in ../MODULES so I checked them
* in as well.

         nam   DD
         ttl   40-track floppy disk device descriptor

* Disassembled 02/04/21 22:37:45 by Disasm v1.6 (C) 1988 by RML

         ifp1
         use   defsfile
         endc
tylg     set   Devic+Objct   
atrv     set   ReEnt+rev
rev      set   $00

         mod   eom,name,tylg,atrv,mgrnam,drvnam

         fcb   $FF mode byte
         fcb   $FF extended controller address
         fdb   $FF40  physical controller address
         fcb   initsize-*-1  initilization table size
         fcb   $01 device type:0=scf,1=rbf,2=pipe,3=scf
         fcb   $00 drive number
         fcb   $00 step rate
         fcb   $20 drive device type
         fcb   $01 media density:0=single,1=double
         fdb   $0028 number of cylinders (tracks)
         fcb   $02 number of sides
         fcb   $00 verify disk writes:0=on
         fdb   $0012 # of sectors per track
         fdb   $0012 # of sectors per track (track 0)
         fcb   $02 sector interleave factor
         fcb   $08 minimum size of sector allocation
initsize equ   *
name     equ   *
         fcs   /DD/
mgrnam   equ   *
         fcs   /RBF/
drvnam   equ   *
         fcs   /DDisk/
         emod
eom      equ   *
