* RGB Computer Systems
* OS-9 Level 2 Hard Disk
* Device Descripter Module
* Copyright (C) 1989 by RGB Computer Systems
* All rights reserved

         nam   h0 or h1
         ttl   Hard Disk Device Descripter

         ifp1  
         use   defsfile
         use   rbfdefs
         endc  

* Change the following equates for your hard drive type:

drive    equ   0          set to /h0
numcyl   equ   000        set to your number of cylinders
heads    equ   0          set to your number of r/w heads
numsec   equ   32         number of sectors/track (some may be 33)

* Set the next equate for the type of Hard Disk
* Interface you are using. Use the following values:
* For LR-TECH, OWL, KEN-TON and RGB, use $FF74
* For DISTO SUPER CONTROLLER, use $FF50
* For DISTO 4-IN-1 BOARD, use $FF58

PORT     equ   $ff74      set for LR-TECH

**********  Make no changes below this line  **********

rev      set   1          rev number
type     equ   devic+objct

         mod   end,name,type,reent+rev,mgr,dvr
         fcb   $ff        all modes
         fcb   $7         device extended address
         fdb   PORT       port address
         fcb   name-*-1   option byte count
         fcb   DT.RBF     rbf device type
         fcb   drive      drive number
         fcb   0          step rate (reserved 0)
         fcb   $80        disk type (hard disk)
         fcb   1          density (unused)
         fdb   numcyl     number of cylinders
         fcb   heads      number of surfaces
         fcb   1          verify (unused)
         fdb   numsec     default sectors/track
         fdb   numsec     default sectors/track tk00
         fcb   0          interleave (unused)
         fcb   32         sector allocation size <- 32 is good for a HD


name     fcc   /h/
         fcb   '0+$80+drive
         fcb   1          edition
mgr      fcs   /rbf/
dvr      fcs   /hdisk/
         emod  
end      equ   *
         end   
