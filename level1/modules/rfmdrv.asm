********************************************************************
* rfmdrv - remote file manager driver
*

         nam   rfmdrv
         ttl   Remote file manager driver

         ifp1
         	use   defsfile
         endc
         
tylg     set   Drivr+Objct   
atrv     set   ReEnt+rev
rev      set   $01
edition  set   $01

         mod   eom,name,tylg,atrv,start,size

        
wtf  rmb   1
size     equ   .

 		fcb   READ.+WRITE.

name     fcs   /rfmdrv/
         fcb   edition

start    nop
		 clrb
		 rts
		 
         emod
eom      equ   *
         end
