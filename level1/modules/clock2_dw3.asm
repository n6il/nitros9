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
*
*   2      2010/01/02  Boisy G. Pitre
* Saved some bytes by optimizing

         nam   Clock2
         ttl   DriveWire 3 RTC Driver

         ifp1            
         use   defsfile  
         endc            

tylg     set   Sbrtn+Objct
atrv     set   ReEnt+rev
rev      set   $00
edition  set   2


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

GetTime  pshs  u,y,x,b
         lda   #'#        Time packet
	 sta   ,s
	 leax  ,s
	 ldy   #$0001
         IFGT  Level-1
         ldu   <D.DWSubAddr
         ELSE
         ldu   >D.DWSubAddr
         ENDC
         beq   UpdLeave      in case we failed to link it, just exit
	 jsr   6,u
* Consider the following optimization
         ldx   #D.Year
	 ldy   #$0005
         jsr   3,u
UpdLeave puls  b,x,y,u,pc


Init     
* Check if subroutine already linked
         IFGT    Level-1
         ldx     <D.DWSubAddr
         ELSE
         ldx     >D.DWSubAddr
         ENDC
         bne     leave
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
         bcs     ex
         sty     <D.DWSubAddr
         ELSE
         bcs     ex
         sty     >D.DWSubAddr
         ENDC
         jmp     ,y			call initialization routine
leave    rts

         emod          
eom      equ   *         
         end             

