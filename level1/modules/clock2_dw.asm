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
* Saved some bytes by optimizing.
*
*          2023/07/02  Boisy G. Pitre
* Reintroduced a single clock module and this file is now included in clock.asm.

          use       drivewire.d
          
subname   fcs       "dwio"

Clock2_SetTime   
          IFGT      Level-1
          lda       <D.DWSrvID
          ELSE
          lda       >D.DWSrvID
          ENDC
          cmpa      #128
          bne       leave
          pshs      u,y,x,d
          IFGT      Level-1
          ldu       <D.DWSubAddr
          ELSE
          ldu       >D.DWSubAddr
          ENDC
          beq       UpdLeave      in case we failed to link it, just exit
          lda       #OP_SETTIME
          pshs      a
          ldy       #$0001
          leax      ,s
          jsr       DW$Write,u
          puls      a
          ldx       #D.Year
          ldy       #$0006
          jsr       DW$Write,u
          bra       UpdLeave

Clock2_GetTime 
          lda       #OP_TIME        Time packet
          pshs      u,y,x,d
          IFGT      Level-1
          ldu       <D.DWSubAddr
          ELSE
          ldu       >D.DWSubAddr
          ENDC
          beq       UpdLeave      in case we failed to link it, just exit
          leax      ,s
          ldy       #$0001
          jsr       DW$Write,u
          ldx       #D.Year
          ldy       #$0006
          jsr       DW$Read,u
UpdLeave  puls      d,x,y,u,pc


Clock2_Init     
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
