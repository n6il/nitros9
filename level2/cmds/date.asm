********************************************************************
* Date - Print Date/Time
*
* $Id$
*
* Greetings;                                     September 25, 1996
* 
* This 'Date' module, date5, has been expanded a wee bit to
* make it smart enough to handle dates to the year 2099.
* 
* In order to have it do it in a math conversion, I would have had to
* make the 8 bit math it does into 16 bit, and there aren't enough
* registers in the 6809 to pull that off in a reasonable code size.
* So it still does 8 bit math, but only has a 1900-2099 year total
* range.  This is more than the recently converted clock for the Disto
* 4n1 I just uploaded, as that clock now has a range from 1980 to 2079.
* A simple subtraction determines if it prints a leading 20, and the
* contents of the register after the subtraction, or it reloads the
* string pointer to point at 19 and reloads the year register to get
* the year 00-99 to print.
* 
* This contains no 6309 specific code, so Nitros9 and a 6309 cpu
* are not required to use it, box stock is fine.
* 
* Gene Heskett, <gene_heskett@wvlink.mpl.com>
*
* Ed.    Comments                                       Who YY/MM/DD
* ------------------------------------------------------------------
* 5      Made Y2K compliant                             GH  96/09/25
* 6      Made compliant with 1900-2155                  BGP 99/05/07

         nam   Date
         ttl   Print Date/Time

         ifp1  
         use   defsfile
         endc  

tylg     set   Prgrm+Objct
atrv     set   ReEnt+rev
rev      set   $01
edition  set   6

         mod   eom,name,tylg,atrv,start,size

SysYear  rmb   1
SysMonth rmb   1
SysDay   rmb   1
SysHour  rmb   1
SysMin   rmb   1
SysSec   rmb   1
u0006    rmb   2
u0008    rmb   440
size     equ   .

name     fcs   /Date/
         fcb   edition

DtComa   fcs   ', '
MonTable fcs   '??? '
         fcs   'January '
         fcs   'February '
         fcs   'March '
         fcs   'April '
         fcs   'May '
         fcs   'June '
         fcs   'July '
         fcs   'August '
         fcs   'September '
         fcs   'October '
         fcs   'November '
         fcs   'December '

start    pshs  x
         leax  ,u
         leau  u0008,u
         stu   <u0006
         os9   F$Time
         bsr   PrntDate   go print the date in buffer
         lda   [,s++]     now, did we have a -t
         eora  #$54       option on the commandline?
         anda  #$DF
         bne   L008C      wasn't a t
         ldd   #C$SPAC*256+C$SPAC  else space it out
         std   ,u++
         bsr   L00A1      and go add the time to the buffer
L008C    lda   #C$CR      terminate the line to print
         sta   ,u+
         lda   #1 standard out
         ldx   <u0006
         ldy   #$0028
         os9   I$WritLn   and go print it
         bcs   L009E
         clrb  
L009E    os9   F$Exit
L00A1    ldb   <SysHour
         bsr   L00D2
         ldb   <SysMin
         bsr   L00AB
         ldb   <SysSec
L00AB    lda   #$3A
         sta   ,u+
         bra   L00D2
PrntDate leay  >MonTable,pcr
         ldb   <SysMonth
         beq   L00C4
         cmpb  #$0C
         bhi   L00C4
L00BD    lda   ,y+
         bpl   L00BD
         decb  
         bne   L00BD
L00C4    bsr   PrtStrng
         ldb   <SysDay
         bsr   L00D2
         leay  >DtComa,pcr
         bsr   PrtStrng
         ldb   <SysYear          get year
         cmpb  #100              compare against 100 (2000)
         blo   is19              if less than, it's 19XX, so branch
         subb  #100              else subtract 100
         cmpb  #100              compare against 100 
         blo   is20              if less than, it's 20XX, so branch
         subb  #100
         pshs   b
         ldb   #21
         bra   pr
is20     pshs  b
         ldb   #20
         bra   pr
is19     pshs  b 
         ldb   #19
pr       bsr   L00D2 
         puls  b
L00D2    lda   #$2F
L00D4    inca  
         subb  #$64
         bcc   L00D4
         sta   ,u+
         cmpa  #$30
         bne   L00E1
         leau  -1,u
L00E1    lda   #$3A
L00E3    deca  
         addb  #$0A
         bcc   L00E3
         sta   ,u+
         addb  #$30
         stb   ,u+
         rts   

*  *  *  *  *  *  *  *  *  *  *
* make fcs strings printable
PrtStrng lda   ,y
         anda  #$7F
         sta   ,u+
         lda   ,y+
         bpl   PrtStrng
         rts   

*  *  *  *  *  *  *  *  *  *  *
* all done here folks
         emod  
eom      equ   *
         end   

