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
*        ldx   #D.Year
	 leax  D.Year,y	Note: Y = 0 after returning from XMT56K
	 lda   #255
         jsr   3,u
UpdLeave puls  x,y,u,pc


Init     leax    subname,pcr
         clra
         os9     F$Link
         bcs     ex
         sty     >D.DWSUB
         jmp     ,y			call initialization routine

         emod            
eom      equ   *         
         end             

