         nam   H0        
         ttl   IDE device descriptor

* IDE Defined Offsets
*
* IT.STP (offset $14)
*  Bit Meaning
*  --- ---------------------------------------------------------------
* 
* IT.TYP (offset $15)
*  Bit Meaning
*  --- ---------------------------------------------------------------
*  7   Hard Disk:  1 = hard disk, 0 = floppy disk
*  6   Fudge LSN0: 0 = OS-9 disk, 1 = non-OS-9 disk
* 
* IT.DNS (offset $16)
*  Bit Meaning
*  --- ---------------------------------------------------------------


* Interface Address
         ifne  SuperSCSI 
ADDR     equ   $FF50     
         else            
ADDR     equ   $FF74     
         endc            

* Driver specific fields
ITDRV    set   $00       
ITSTP    set   $00       
ITTYP    set   $80       
ITDNS    set   $00       

ITSOFS1  set   $00       
ITSOFS2  set   $00       
ITSOFS3  set   $00       

* Default Geometry
Sides    set   $20       
Cyls     set   $100      
SectTrk  set   $0020     
SectTrk0 set   $0020     
Interlv  set   $01       
SASiz    set   $08       

         ifp1            
         use   defsfile  
         endc            

tylg     set   Devic+Objct
atrv     set   ReEnt+rev 
rev      set   $0        

         mod   eom,name,tylg,atrv,mgrnam,drvnam

         fcb   $FF        mode byte
         fcb   HW.Page    extended controller address
         fdb   ADDR       physical controller address
         fcb   initsize-*-1 initilization table size
         fcb   DT.RBF     device type:0=scf,1=rbf,2=pipe,3=scf
         fcb   ITDRV      drive number
         fcb   ITSTP      step rate
         fcb   ITTYP      drive device type
         fcb   ITDNS      media density
         fdb   Cyls       number of cylinders (tracks)
         fcb   Sides      number of sides
         fcb   $01        verify disk writes:0=on
         fdb   SectTrk    # of sectors per track
         fdb   SectTrk0   # of sectors per track (track 0)
         fcb   Interlv    sector interleave factor
         fcb   SASiz      minimum size of sector allocation
initsize equ   *         
*IDE Driver specific additions to the device descriptor go here
* NOTE: These do NOT get copied into the path descriptor; they
*       cannot due to the fact that there is simply NO ROOM in
*       the path descriptor to do so.  The driver must access
*       these values directly from the descriptor.
         fcb   0,0,0,0,0,0,0,0,0

         ifne  DD        
name     fcs   /DD/      
         else            
name     fcc   /H/       
         fcb   ITDRV+$B0 
         endc            
mgrnam   fcs   /RBF/     
         ifne  SuperIDE  
drvnam   fcs   /SuperIDE/
         else            
drvnam   fcs   /CCIDE/   
         endc            

         emod            
eom      equ   *         
         end             
