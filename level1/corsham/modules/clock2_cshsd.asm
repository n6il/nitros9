********************************************************************
* Clock2 - Corsham RTC Driver
*
* $Id$
*
* Edt/Rev  YYYY/MM/DD  Modified by
* Comment
* ------------------------------------------------------------------
*   1      2017/05/11  Boisy G. Pitre
* Created.

          nam       Clock2
          ttl       Corsham RTC Driver

          ifp1
          use       defsfile
          endc

tylg      set       Sbrtn+Objct
atrv      set       ReEnt+rev
rev       set       $00
edition   set       1


RTC.Base  equ       $0000

          mod       eom,name,tylg,atrv,JmpTable,RTC.Base

name      fcs       "Clock2"
          fcb       edition

subname   fcs       "pio"

* Three Entry Points:
*   - Init
*   - GetTime
*   - SetTIme
JmpTable
          lbra       Init
          bra       GetTime	RTC Get Time
          nop

SetTime
          pshs      u,y,x,d
          IFGT      Level-1
          ldu       <D.DWSubAddr
          ELSE
          ldu       >D.DWSubAddr
          ENDC
          lbeq      UpdLeave      in case we failed to link it, just exit
          lda       #PC_SET_CLOCK
          pshs      a
          ldy       #$0001
          leax      ,s
          jsr       PIO$Write,u
          puls      a
          ldy       #$0000
          leas	-8,s
          leax	,s
          lda	D.Year,y		year
          suba	#100
          sta	3,x
          lda	D.Month,y		month
          sta	,x
          lda	D.Day,y		day
          sta	1,x
          lda	D.Hour,y		hour
          sta	4,x
          lda	D.Min,y		minute
          sta	5,x
          lda	D.Sec,y		second
          sta	6,x
          lda	#1
          sta	2,x
          ldy       #$0008
          jsr       PIO$Write,u
* read ack byte
	ldy	#1
	jsr	PIO$Read,u
          leas	8,s
          bra       UpdLeave

GetTime
          lda       #PC_GET_CLOCK        Time packet
          pshs      u,y,x,d
          IFGT      Level-1
          ldu       <D.DWSubAddr
          ELSE
          ldu       >D.DWSubAddr
          ENDC
          beq       UpdLeave      in case we failed to link it, just exit
          leax      ,s
          ldy       #$0001
          jsr       PIO$Write,u
          leas	-9,s
          leax	,s
          ldy       #$0009
          jsr       PIO$Read,u
          ldy       #$0000
          lda	4,x		year
          adda	#100
          sta	D.Year,y
          lda	1,x		month
          sta	D.Month,y
          lda	2,x		day
          sta	D.Day,y
          lda	5,x		hour
          sta	D.Hour,y
          lda	6,x		minute
          sta	D.Min,y
          lda	7,x		second
          sta	D.Sec,y
          leas	9,s
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
