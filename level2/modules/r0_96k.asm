         nam   R0
         ttl   os9 device descriptor

* Disassembled 98/08/23 21:10:53 by Disasm v1.6 (C) 1988 by RML

         ifp1
         use   defsfile
         endc
tylg     set   Devic+Objct   
atrv     set   ReEnt+rev
rev      set   $01
         mod   eom,name,tylg,atrv,mgrnam,drvnam
         fcb   $BF mode byte
         fcb   $00 extended controller address
         fdb   $0000  physical controller address
         fcb   initsize-*-1  initilization table size
         fcb   $01 device type:0=scf,1=rbf,2=pipe,3=scf
         fcb   $00 drive number
         fcb   $00 step rate
         fcb   $00 drive device type
         fcb   $00 media density:0=single,1=double
         fdb   $0000 number of cylinders (tracks)
         fcb   $01 number of sides
         fcb   $00 verify disk writes:0=on
         fdb   $0180 # of sectors per track
         fdb   $0000 # of sectors per track (track 0)
         fcb   $00 sector interleave factor
         fcb   $04 minimum size of sector allocation
initsize equ   *
name     equ   *
         fcs   /R0/
mgrnam   equ   *
         fcs   /RBF/
drvnam   equ   *
         fcs   /RAM/
         emod
eom      equ   *
