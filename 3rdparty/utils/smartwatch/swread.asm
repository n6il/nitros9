********************************************************************
* SWRead - Read SmartWatch clock
*
* $Id$
*
* Copyright May, 1990 by Robert Gault

* SWREAD will read smartwatch compensating for 12hr mode if active
* time will be sent to OS-9 in 24hr mode for compatability
*
* The routine does grab a large uninterruptible block of time from
* the system, but no other way seems possible.
*
* syntax  swread [n&]      n=1-60 minutes
* D.Daywk stored for possible use
*
* Ed.    Comments                                       Who YY/MM/DD
* ------------------------------------------------------------------
* 1      Created                                        RG  91/03/01
* 1      Changed irq handling; MPI handling;            RG  91/10/29
*        error handling
* 1      Removed relocation routine. Removal could be   RG  92/12/26
*        dangerous if OS-9 did not grab block from the
*        low addresses first. Code must not be in a
*        RAM/ROM block when ROMs activated.
* 2      Relocated part of clock read routine to        RG  94/12/19
*        shorten the time spent with irqs off.

         nam   SWRead
         ttl   Read SmartWatch clock

         ifp1  
         use   defsfile
         use   systype
         endc  

cartI    equ   $FF22      cartridge IRQ report
rom      equ   $FFDE
ram      equ   $FFDF
IEN      equ   %00100000
FEN      equ   %00010000
SCS      equ   %00000100
ROM1     equ   %00000010
ROM0     equ   %00000001
*D.Cntury	set	$6A century byte

type     set   prgrm+objct
revs     set   reent+1
edition  set   2

         mod   pgrmend,name,type,revs,start,size

name     fcs   /SWRead/
         fcb   edition

locblk0  rmb   2          pointer to block 0
locblk3E rmb   2          pointer to block $3E ie. disk ROM
dpsave   rmb   1
sleep    rmb   1          sleep interval time in minutes
byte1    rmb   1          temp storage of clock read data; if never changes - no clock
clkflag  rmb   1          set when clock is found
mpiimage rmb   1
sleepflg rmb   1          indicates multiple reads requested
timer    rmb   1          count down for sleep interval; per minute
century  rmb   1          century flag
rawdata  rmb   8          direct readout from clock chip

stack    rmb   200
size     equ   .

message1 fcc   /no clock found/
         fcb   C$CR
setime   fcc   /setime/   forced chain to setime routine
         fcb   C$CR

errmes   fcb   C$LF
         fcc   /Swread syntax:/
         fcb   C$LF,C$LF
         fcc   /swread [n&]/
         fcb   C$LF
         fcc   /           The parameter string is optional; n = 1 to 60 min/
         fcb   C$LF
         fcc   /           permitting the watch to be poled in background every/
         fcb   C$LF
         fcc   /           n minutes. Use decimal time values./
         fcb   C$CR
allert   fcb   $C5,$3A,$A3,$5C,$C5,$3A,$A3,$5C,0

start    clr   <sleepflg
         cmpd  #2
         blo   noparams
         ldd   ,x
         cmpa  #'?
         lbeq  syntax
         cmpa  #'-
         lbeq  syntax

         cmpb  #'0        if second byte is CR then only one number
         blo   onebyte
         subd  #$3030     convert from ascii to bcd

         cmpd  #$600      one hour skip is max
         lbhi  syntax
         cmpb  #9         must be a number from 0-9
         lbhi  syntax

         pshs  b          convert reg.D to hexidecimal
         ldb   #10
         mul   
         addb  ,s+
         bra   storeit

onebyte  suba  #'0
         cmpa  #9
         lbhi  syntax

storeit  stb   <timer
         stb   <sleep     used to reset timer on count down
         com   <sleepflg

noparams equ   *
         lda   MPI.Slct
         anda  #3         retain IRQ settings
         ora   #$30       start at slot 4; ROM setting
         sta   <mpiimage

doit     pshs  u
         ldb   #1         single block
         ldx   #$3E       disk rom; $07C000-$07DFFF
         os9   F$MapBlk   map into user space clock ROM
         bcs   exit2
         stu   locblk3E   save pointer
         ldx   #0         system direct page
         os9   F$MapBlk   system direct page
         bcs   exit2
         leax  ,u         faster but = to TFR; get pointer for system DP
         stu   locblk0    save pointer
         tfr   dp,b       get our own DP
         stb   dpsave

         bsr   readclk

         ldb   #1         unmap blocks from user space
         ldu   locblk3E   get pointer
         os9   F$ClrBlk
         ldb   #1
         ldu   locblk0    get pointer
         os9   F$ClrBlk
         puls  u

         tst   <clkflag   was clock found?
         beq   error2
         tst   <sleepflg  are we in repeat mode?
         beq   exit

snooze   ldx   #3540      = one minute of ticks minus one second for overhead
         os9   F$Sleep
         cmpx  #0
         bne   exit       received signal so quit

         dec   timer
         bne   snooze

         lda   sleep      reset timer
         sta   timer
         bra   doit       go and read the clock

exit2    leas  2,s        puls u
         coma             set cc
         os9   F$Exit
error    ldb   #E$IllArg
         os9   F$Exit

error2   lda   #2         error path
         leax  message1,pcr
         ldy   #40
         os9   I$WritLn
* force a normal Setime as SmartWatch was not detected
         lda   #Prgrm+Objct  modul type
         ldb   #2         size of data area
         leax  setime,pcr
         ldy   #0         parameter size
         leas  stack,u
         leau  size,u
         os9   F$Chain
exit     clrb  
         os9   F$exit

* this is the heart of the clock reading routine
* regX regU point to system direct page
readclk  pshs  cc
         lda   d.hinit,x  get $FF90 image
         ldb   MPI.Slct   get current setting
         pshs  d          save them
         anda  #^(IEN+FEN+ROM1+ROM0) no GIME IRQ/FIRQ; external access
         orcc  #IntMasks  stop interrupts
         sta   $FF90
         sta   rom        go to ROM mode
         ldx   <locblk3E  point to clock ROM
         ldb   <mpiimage  get new value for MPI
         clr   <clkflag   start with clock not found
         lda   locblk3E
         tfr   a,dp       point to clock

findclk  stb   MPI.Slct   set new slot
         leay  allert,pcr point to clock wakeup code
         lda   <4         clear clock at $C004
         clrb  
         bita  #1         1bit serial I/O port; if no clock, all bits should be 0 or 1
         beq   low
         comb  
low      stb   >byte1     save as flag for found clock

nxtbyte  ldb   #8         bits/byte
         lda   ,y+
         beq   gettime
nxtbit   lsra             do a serial generation
         bcs   high
         cmpa  <0         talk to clock at $C000; cmp faster than tst
         bra   high2
high     cmpa  <1         talk to clock at $C001
high2    decb  
         bne   nxtbit
         bra   nxtbyte

gettime  lda   #8         8 bytes to read from clock
         pshs  a
         ldy   #rawdata
* read serial bit stream from clock
timebyte lsr   <4
         rora  
         lsr   <4
         rora  
         lsr   <4
         rora  
         lsr   <4
         rora  
         lsr   <4
         rora  
         lsr   <4
         rora  
         lsr   <4
         rora  
         lsr   <4
         rora  
         sta   ,y+        store in raw data	
         cmpa  >byte1     if reg.A never changes then no clock
         beq   maybe      always possible that a clock byte might look like ROM
         inc   >clkflag   indicate a found clock
maybe    dec   ,s
         bne   timebyte
         leas  1,s        yank counter
         tst   >clkflag   did we find the clock?
         bne   found
         ldb   >mpiimage  try another MPI slot
         bitb  #$30       did we get to slot 0?
         beq   found
         subb  #$10       next slot
         stb   >mpiimage  save image so that we don't hunt the next time.
         bra   findclk

found    lda   >dpsave
         tfr   a,dp       back to program DP
         sta   ram        go back to RAM mode
         puls  d
         stb   MPI.Slct   restore to original setting
         tst   cartI      clear CART flag incase autostart ROM pack was present in MPI
         sta   $FF90      restore GIME mode
         puls  cc         restore IRQs
         tst   <clkflag
         beq   noclk
         ldx   #rawdata
         leay  D.Slice,u
         ldb   #8
         pshs  b
trans    lda   ,x+        translate serial data into OS-9 format
         ldb   ,s
         cmpb  #1         year
         bne   notyr
         cmpa  #$80       binary coded decimal number
         bhi   nintn
*	ldb	#20
*	stb	D.Cntury,u
         sta   <century
         bra   notyr
nintn          
*	ldb	#19
*	stb	D.Cntury,u
         clr   <century
*notyr	ldb	,s
notyr    cmpb  #4         day of the week
         bne   notdywk
         anda  #7
         sta   D.Daywk,u
         bra   nxtdata
notdywk  cmpb  #5         special 12/24, AM/PM indicator
         bne   cnvrt      convert any number
         bita  #%10000000 12/24 hour bit
         beq   cnvrt      24 hour time
         bita  #%00100000 AM/PM bit since 12 hour time, check AM/PM
         pshs  cc
         anda  #%00011111 keep only time
         puls  cc
         bne   PMhr
         cmpa  #$12       bcd value
         bne   cnvrt
         clra             12 AM = 0 hrs 24hr time
         bra   cnvrt
Pmhr     cmpa  #$12       bcd value
         beq   cnvrt      12PM = 1200 24 hr time
         adda  #$12       all other times (1-11) add 12; ie. 1300-2300
cnvrt    tfr   a,b        return result in reg.B
         anda  #%11110000 get MSN
         lsra  
         lsra  
         sta   ,-s        save #4a
         lsra  
         sta   ,-s        save #2a
         subb  ,s+        16a+b-4a
         subb  ,s+        12a+b-2a=10a+b
         stb   ,-y        decrease pointer and then store
nxtdata  dec   ,s
         bne   trans
         tst   <century
         beq   not20
         lda   #100
         adda  ,y
         sta   ,y
not20    puls  b,pc

noclk    clr   D.Daywk,u  clear garbage as new date routine reads D.Daywk
         leay  D.Time,u
         ldd   #7
noclklp  sta   ,y+        clear clock packet; faster than a clr ,y+
         decb  
         bne   noclklp
*	clr	D.Cntury,u
         clr   <century
         clr   <clkflag
         rts   

syntax   lda   #2
         leax  errmes,pcr
         ldy   #300
         os9   I$Writln
         clrb  
         os9   F$Exit

         emod  
pgrmend  equ   *
         end

