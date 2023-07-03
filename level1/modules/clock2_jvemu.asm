********************************************************************
* Clock2 - Jeff Vavasour CoCo 3 Emulator RTC Driver
*
* $Id$
*
* Edt/Rev  YYYY/MM/DD  Modified by
* Comment
* ------------------------------------------------------------------
*          2004/07/13  Robert Gault
* Added Vavasour/Collyer emulator & MESS (Disto) versions and relocated
* 'GetTime equ'   statement so it is not within a chip heading.
*
*          2004/07/31  Rodney Hamilton
* Improved RTCJVEmu code, conditionalized RTC type comments.
*
*   1      2004/08/18  Boisy G. Pitre
* Separated clock2 modules for source clarity.
*
*          2023/07/02  Boisy G. Pitre
* Reintroduced a single clock module and this file is now included in clock.asm.

RTC.Base equ   $FFC0

Clock2_GetTime
         ldx   #RTC.Base
         ldd   ,x	get year (CCYY)
         suba  #20
         bmi   yr1	19xx, OK as is
yr0      addb  #100	20xx adjustment
         deca		also check for
         bpl   yr0	21xx (optional)
yr1      stb   <D.Year	set year (~YY)
         ldd   2,x	get date
         std   <D.Month	set date (MMDD)
         IFNE  Level-1
         ldd   4,x	get time (wwhh)
         sta   <D.Daywk	set day of week
         ELSE
         ldb   5,x	get hour (hh)
         ENDC
         stb   <D.Hour	set hour (hh)
         ldd   6,x	get time (mmss)
         std   <D.Min	set time (mmss)
Clock2_SetTime
Clock2_Init
         rts
