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

          nam       Clock2
          ttl       DriveWire 3 RTC Driver

          ifp1            
          use       defsfile  
          use       drivewire.d  
          endc            

tylg      set       Sbrtn+Objct
atrv      set       ReEnt+rev
rev       set       $00
edition   set       2


RTC.Base  equ       $0000     

          mod       eom,name,tylg,atrv,JmpTable,RTC.Base

name      fcs       "Clock2"  
          fcb       edition

subname   fcs       "dw3"

* Three Entry Points:
*   - Init
*   - GetTime
*   - SetTIme
JmpTable                 
          bra       Init
          nop
          bra       GetTime   	RTC Get Time


SetTime   pshs      u,y,x,d
          IFGT      Level-1
          ldu       <D.DWSubAddr
          ELSE
          ldu       >D.DWSubAddr
          ENDC
          beq       UpdLeave      in case we failed to link it, just exit
          ldx       #D.Year
          ldd       4,x
          pshs      d
          ldd       2,x
          pshs      d
          ldd       ,x
          pshs      d
          lda       #OP_SETTIME
          pshs      a
          leax      ,s
          ldy       #$0007
          jsr       DW$Write,u
          leas      7,s
          bra       UpdLeave


GetTime   pshs      u,y,x,d
          IFGT      Level-1
          ldu       <D.DWSubAddr
          ELSE
          ldu       >D.DWSubAddr
          ENDC
          beq       UpdLeave      in case we failed to link it, just exit
          lda       #OP_TIME        Time packet
          sta       ,s
          leax      ,s
          ldy       #$0001
          beq       UpdLeave      in case we failed to link it, just exit
          jsr       DW$Write,u
          ldx       #D.Year
          ldy       #$0006
          jsr       DW$Read,u
UpdLeave  puls      d,x,y,u,pc


Init     
* Check if subroutine already linked
          IFGT      Level-1
          ldx       <D.DWSubAddr
          ELSE
          ldx       >D.DWSubAddr
          ENDC
          bne       leave
          IFGT      Level-1
          ldx       <D.Proc
          pshs      x
          ldx       <D.SysPrc
          stx       <D.Proc
          ENDC
          leax      subname,pcr
          clra
          os9       F$Link
          IFGT      Level-1
          puls      x
          stx       <D.Proc
          bcs       leave
          sty       <D.DWSubAddr
          ELSE
          bcs       leave
          sty       >D.DWSubAddr
          ENDC
          jmp       ,y			call initialization routine
leave     rts

          emod          
eom       equ   *         
          end             
