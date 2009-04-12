********************************************************************
* Clock2 - DriveWire 3 RTC Driver
*
* $Id$
*
* Edt/Rev  YYYY/MM/DD  Modified by
* Comment
* ------------------------------------------------------------------
*   1      2004/08/18  Boisy G. Pitre
* Separated clock2 modules for source clarity.

         nam   Clock2
         ttl   DriveWire 3 RTC Driver

         ifp1            
         use   defsfile  
         endc            

tylg     set   Sbrtn+Objct
atrv     set   ReEnt+rev
rev      set   $00
edition  set   1


RTC.Base equ   $0000     

         mod   eom,name,tylg,atrv,JmpTable,RTC.Base

name     fcs   "Clock2"  
         fcb   edition

subname  fcs   "dw3"

* Three Entry Points:
*   - Init
*   - GetTime
*   - SetTIme
JmpTable                 
         bra   Init
         nop
         bra   GetTime   	RTC Get Time
         nop
ex       rts			RTC Set Time

GetTime  pshs  u,y,x
         lda   #'#        Time packet
	 pshs  a
	 leax  ,s
	 ldy   #$0001
         ldu   >D.DWSUB
	 jsr   6,u
         puls  a        
* Consider the following optimization
         ldx   #D.Year
	 ldy   #$0005
         jsr   3,u
UpdLeave puls  x,y,u,pc


Init     
         IFGT    Level-1
         ldx     <D.Proc
         pshs    x
         ldx     <D.SysPrc
         stx     <D.Proc
         ENDC
         leax    subname,pcr
         clra
         os9     F$Link
         IFGT    Level-1
         puls    x
         stx     <D.Proc
         bcs     InitEx
         sty     <D.DWSUB
         ELSE
         bcs     ex
         sty     >D.DWSUB
         ENDC
         jsr     ,y			call initialization routine
InitEx   rts

         emod          
eom      equ   *         
         end             

