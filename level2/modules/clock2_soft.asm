********************************************************************
* Clock2 - Software clock driver
*
* $Id$
*
* This clock driver is not only Y2K compliant, but also will handle
* leap year calculations correctly for all years from 1900 A.D. to
* 2155 A.D.  Note that this driver is ONLY valid from 1900-2155 and
* will not handle years outside of this range.
*
* Ed.    Comments                                       Who YY/MM/DD
* ------------------------------------------------------------------
* 1      Obtained source and commented/restructured     BGP 98/10/05
* 2      Fixed leap year assumptions about 1900 and     BGP 99/05/02
*        2100 so that they do not have Feb. 29

         nam   Clock2
         ttl   Software clock driver

rev      set   1
edition  set   2

         ifp1  
         use   defsfile
         endc  

         mod   len2,name2,systm+objct,reent+rev,entry,0

name2    fcs   "Clock2"
         fcb   edition

entry    bra   Init       0 init hardware
         nop   
         bra   GetTime    3 get time to D.Time (once a second??)
         nop   
         bra   SetTime    6 set time fm D.Time
         nop   

* Init and SetTime do nothing for the software clock
Init           
SetTime  clrb             setime must clrb if okay
         rts              nothing for this guy

GetTime  ldd   <D.Min     get minutes, seconds
* Second increment
         incb             secs+1
         cmpb  #60        minute yet?
         blo   L0080      ..no
* Minute increment
         inca             minute+1
         cmpa  #60        hour yet?
         blo   L007F      ..no
         ldd   <D.Day     get day, hour
* Hour increment
         incb             hour+1
         cmpb  #24        day yet?
         blo   L007C      ..no
* Day increment
         inca             day+1
         leax  >months,pcr point to months table
         ldb   <D.Month   this month
         cmpa  b,x        end of month?
         bls   L007B      ..no
* Here we are at the case where the incremented day in A is larger
* than the max day in the month.
* Now's our chance to check for leap year case.
         cmpb  #2         yes, is it Feb?
         bne   L006D      ..no, ok
         ldb   <D.Year    else get year
         beq   L006D      1900 has no leap year.. +BGP+ 1999/05/02
         cmpb  #200       is year 2100?           +BGP+ 1999/05/02
         beq   L006D      yep, has no leap year.. +BGP+ 1999/05/02
         andb  #$03       check for leap year
         cmpd  #$1D00     29th on leap year?
         beq   L007B      ..yes, skip it
L006D    ldd   <D.Year    else month+1
* Month increment
         incb  
         cmpb  #13        end of year?
         blo   L0077      ..no
* Year increment
* Note that once A rolls over to 0, it assumes year 1900.
         inca             year+1
         ldb   #$01       set month to jan
L0077    std   <D.Year    save year, month
         lda   #$01       day=1st
L007B    clrb             hour=midnite
L007C    std   <D.Day     save day,hour
         clra             minute=00
L007F    clrb             seconds=00
L0080    std   <D.Min     save min,secs
         rts   

months   fcb   $00
         fcb   31         jan
         fcb   28         feb
         fcb   31         mar
         fcb   30         apr
         fcb   31         may
         fcb   30         jun
         fcb   31         jul
         fcb   31         aug
         fcb   30         sep
         fcb   31         oct
         fcb   30         nov
         fcb   31         dec

         emod  
len2     equ   *
         end   

