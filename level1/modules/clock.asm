********************************************************************
* Clock - OS-9 Level One V2 Clock module
*
* $Id$
*
* NOTE:  This clock is TOTALLY VALID for ALL DATES between 1900-2155
*
* Ed.    Comments                                       Who YY/MM/DD
* ------------------------------------------------------------------
* 5      Tandy/Microware original version
* 6      Modified to handle leap years properly for     BGP 99/05/03
*        1900 and 2100 A.D.
*        Added TC^3 SCSI/B&B RTC Clock Support          BGP 02/05/14

         nam   Clock
         ttl   OS-9 Level One V2 Clock module

         IFP1
         use   defsfile
         ENDC

tylg     set   Systm+Objct
atrv     set   ReEnt+rev
rev      set   $1
edition  set   6

         mod   eom,name,tylg,atrv,ClkEnt,RTC.Base

size     equ   .

name     fcs   /Clock/
         fcb   edition

* If no RTC defines are set, then this is a software clock
         IFEQ RTCBB+RTCTC3
SOFT     set  1
         ENDC

         IFNE RTCBB
MPIFlag  set  1
SlotSlct set  $22
RTC.Base equ $FF5C
         ENDC
         IFNE RTCTC3
RTC.Base equ $FF7C
         ENDC
         IFNE SOFT
RTC.Base equ size
         ENDC

         IFNE RTCBB+RTCTC3
RTC.Zero equ -4     Send zero bit by writing this offset
RTC.One  equ -3     Send one bit by writing this offset
RTC.Read equ 0      Read data from this offset
         ENDC

SysTbl   fcb   F$Time
         fdb   FTime-*-2
         fcb   F$VIRQ
         fdb   FVIRQ-*-2

         IFEQ  SOFT

         fcb   F$STime
         fdb   FSTime-*-2

         ENDC

         fcb   $80

         IFNE  SOFT
* table of days of the month
MonthChk fcb   00
         fcb   31                      January
         fcb   28                      February
         fcb   31                      March
         fcb   30                      April
         fcb   31                      May
         fcb   30                      June
         fcb   31                      July
         fcb   31                      August
         fcb   30                      September
         fcb   31                      October
         fcb   30                      November
         fcb   31                      December

         ELSE

FSTime   ldx   R$X,u
         ldd   ,x
         std   <D.Year
	 ldd   2,x
	 std   <D.Day
	 ldd   4,x
	 std   <D.Min
         andcc #^Carry
         pshs  u,y,cc

         ENDC

         IFNE  RTCBB+RTCTC3

         leay  SendBCD,pcr   Send bytes of clock
	 lbra  TfrTime
*
* Update time from B&B/TC3 RTC
*
UpdTime  pshs  u,y,cc
         leay  ReadBCD,pcr   Read bytes of clock

TfrTime  orcc  #IntMasks  turn off interrupts
         ldu   M$Mem,pcr  Get base address

         IFNE  MPIFlag
         ldb   >MPI.Slct  Select slot
         pshs  b
         andb  #$F0
         orb   SlotSlct,pcr
         stb   >MPI.Slct
         ENDC

         lbsr  SendMsg   Initialize clock
         ldx   #D.Sec
         ldb   #8        Tfr 8 bytes

tfrloop  jsr   ,y        Tfr 1 byte
         bitb  #$03
         beq   skipstuf  Skip over day-of-week, etc.
         leax  -1,x
skipstuf decb
         bne   tfrloop

         IFNE  MPIFlag
         puls  b
         stb   >MPI.Slct     restore MPAK slot
         ENDC

         puls  u,y,cc,pc

ClkMsg   fcb   $C5,$3A,$A3,$5C,$C5,$3A,$A3,$5C
* Enable clock with message $C53AA35CC53AA35C
SendMsg  lda   RTC.Read,u     Send Initialization message to clock
         leax  <ClkMsg,pcr
         ldb   #8
msgloop  lda   ,x+
         bsr   SendByte
         decb
         bne   msgloop
         rts

SendBCD  pshs  b          Send byte to clock, first converting to BCD
         bitb  #$03
         bne   BCDskip    Send zero for day-of-week, etc.
         lda   #0
         bra   SndBCDGo
BCDskip  lda   ,x
SndBCDGo tfr   a,b
         bra   binenter
binloop  adda  #6
binenter subb  #10
         bhs   binloop
         puls  b
SendByte coma             Send one byte to clock
         rora
         bcc   sendone
sendzero tst   RTC.Zero,u
         lsra
         bcc   sendone
         bne   sendzero
         rts
sendone  tst   RTC.One,u
         lsra
         bcc   sendone
         bne   sendzero
         rts

ReadBCD  pshs  b
         ldb   #$80    High bit will rotate out after we read 8 bits
readbit  lda   RTC.Read,u  Read a bit
         lsra
         rorb          Shift it into B
         bcc   readbit Stop when marker bit appears
         tfr   b,a
         bra   BCDEnter  Convert BCD number to Binary
BCDLoop  subb  #6       by subtracting 6 for each $10
BCDEnter suba  #$10
         bhs   BCDLoop
         stb   ,x
         puls  b,pc
         ENDC

ClockIRQ clra
         tfr   a,dp                    set direct page to zero
         lda   PIA.U4+3                get hw byte
         bmi   L0032                   branch if sync flag on
         jmp   [>D.SvcIRQ]
L0032    lda   PIA.U4+2                clear interrupt?
         dec   <D.Tick                 decrement tick counter
         bne   L007F                   go around if not zero
         ldd   <D.Min                  get minutes/seconds
* Seconds increment
         incb                          increment seconds
         cmpb  #60                     full minute?
         bcs   L0079                   nope...

         IFNE  RTCBB+RTCTC3

         lbsr   UpdTime
	 bra    L007B

         ELSE

* Minutes increment
         inca                          else increment minute
         cmpa  #60                     full hour?
         bcs   L0078                   nope...
	 ldd   <D.Day                  else increment day
* Hour increment
         incb                          increment hour
         cmpb  #24                     past 23rd hour?
         bcs   L0075                   branch if not
* Day increment
         inca                          else increment day
         leax  >MonthChk,pcr
         ldb   <D.Month
*         cmpb  #3                      is this February?
*         bne   L005F
*         ldb   <D.Year                 check year
*         beq   L005F                   if century, it's a leap year
*         andb  #$03                    leap year? (divisible by 4)
*         beq   L0060                   nope
*L005F    inca
*L0060    ldb   <D.Month                get month
         cmpa  b,x                     compare days to max days
         bls   L0074                   branch if ok
         cmpb  #2                      is this February?
         bne   L006X                   if not, go on to year/month
* Leap year cases checked here
         ldb   <D.Year                 else check for leap year cases
         beq   L006X                   branch if year 1900
         cmpb  #200                    is it 1900+200 (2100)?
         beq   L006X                   if so, branch
         andb  #$03                    see if 2^4 bit set (leap year)
         cmpd  #$1D00                  29th on leap year?
         beq   L0074                   it's a leap year...
L006X    ldd   <D.Year                 else get year and month
* Month increment
         incb                          increment month
         cmpb  #13                     past December?
         bcs   L0070                   branch if not
* Year increment
         inca                          else in year
         ldb   #1                      and start month in January
L0070    std   <D.Year                 update year/month
         lda   #1                      new month, first day
L0074    clrb                          hour 0
L0075    std   <D.Day                  update day/hour
         clra                          0 minutes
L0078    clrb                          0 seconds

         ENDC

L0079    std   <D.Min                  update min/sec
L007B    lda   <D.TSec
         sta   <D.Tick
L007F    clra
         pshs  a
         ldy   <D.CLTB
         bra   L009E
L0087    ldd   ,x
         subd  #$0001
         bne   L009C
         lda   #$01
         sta   ,s
         lda   $04,x
         beq   L00B8
L0096    ora   #$01
         sta   $04,x
         ldd   $02,x
L009C    std   ,x
L009E    ldx   ,y++
         bne   L0087
         lda   ,s+
         beq   L00B4
         ldx   <D.Proc
         beq   L00AE
         tst   P$State,x
         bpl   L00BC                   branch if sysstate not set
L00AE    jsr   [>D.Poll]
         bcc   L00AE
L00B4    jmp   [>D.AltIRQ]
L00B8    bsr   L00DD
         bra   L0096
L00BC    leay  >L00C4,pcr
         jmp   [>D.URtoSs]
L00C4    jsr   [>D.Poll]
         bcc   L00C4
         ldx   <D.Proc
         ldb   P$State,x
         andb  #^SysState              turn off sysstate bit
         stb   P$State,x
         ldd   <P$SWI2,x
         std   <D.SWI2
         ldd   <D.UsrIRQ
         std   <D.SvcIRQ
         bra   L00B4
L00DD    pshs  y,x
L00DF    ldx   ,y++
         stx   -$04,y
         bne   L00DF
         puls  y,x
         leay  -2,y
         rts

FVIRQ    pshs  cc
         orcc  #FIRQMask+IRQMask
         ldy   <D.CLTB
         ldx   <D.Init
         ldb   PollCnt,x
         ldx   R$X,u
         beq   L0118
         tst   ,y
         beq   L010C
         subb  #$02
         lslb
         leay  b,y
         tst   ,y
         bne   L0128
L0106    tst   ,--y
         beq   L0106
         leay  $02,y
L010C    ldx   R$Y,u
         stx   ,y
         ldy   R$D,u
         sty   ,x
         bra   L0124
L0118    leax  R$Y,u
L011A    tst   ,y
         beq   L0124
         cmpx  ,y++
         bne   L011A
         bsr   L00DD
L0124    puls  cc
         clrb
         rts
L0128    puls  cc
         comb
         ldb   #E$Poll
         rts

ClkEnt   equ   *
         pshs  dp,cc
         clra
         tfr   a,dp

         lda   #TPS

         sta   <D.TSec
         sta   <D.Tick

         lda   #TPS/10

         sta   <D.TSlice
         sta   <D.Slice
         orcc  #FIRQMask+IRQMask       mask ints
         leax  >ClockIRQ,pcr
         stx   <D.IRQ
* install system calls
         leay  >SysTbl,pcr
         os9   F$SSvc
         ldx   #PIA.U4
         clra
         sta   1,x                     change PIA.U4 side A to DDR
         sta   ,x                      clear PIA.U4 side A
         sta   3,x                     change PIA.U4 side B to DDR
         coma                          complement A side A
         sta   2,x                     write all 1's to PIA.U4 side B
         lda   #$34
         sta   1,x                     PIA.U4 side A to I/O reg
         lda   #$3F
         sta   3,x                     PIA.U4 side B to I/O reg
         lda   2,x

         IFEQ  SOFT

	 lbsr  UpdTime                 Update time from RTC if one

         ENDC

         puls  pc,dp,cc

* F$Time system call code
FTime    ldx   R$X,u
         ldd   <D.Year
         std   ,x
         ldd   <D.Day
         std   2,x
         ldd   <D.Min
         std   4,x
         clrb
         rts

         emod
eom      equ   *
         end
