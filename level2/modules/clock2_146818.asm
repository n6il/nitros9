********************************************************************
* Clock2 - Motorola 146818 clock driver
*
* $Id$
*
* Ed.    Comments                                       Who YY/MM/DD
* ------------------------------------------------------------------
* 1      Created                                        BRI 88/10/06
* 2      Shift D.Tick & exit if UIP (not wait up to
*        2228 uS for completion), general clean up      BRI 88/11/17
* 3      Re-wrote clock access to eliminate repeated
*        subroutine calls to increase speed             BRI 88/11/26
* 4      Changed clock access to once per minute        BRI 89/03/25
* 5      More changes                                   BRI 90/04/15

         nam   Clock2
         ttl   Motorola 146818 clock driver

edition  equ   5
MPISlot  equ   $33 (MPI Slot $00-$33)

         ifp1                          
         use   defsfile
         endc                          

ClkAddr  equ   $FF72                    clock base address
Vrsn     equ   1                       
SpeedClk equ   $20                      32.768 KHz, rate=0
StartClk equ   $06                      binary, 24 Hour, DST disabled
StopClk  equ   $86                      bit 7 set stops clock to allow setting t

* MC146818/DS1287 clock register map:
         org   $00                     
CRegSec  rmb   $01                      seconds register
CRegSAl  rmb   $01                      seconds alarm register
CRegMin  rmb   $01                      minutes register
CRegMAl  rmb   $01                      minutes alarm register
CRegHour rmb   $01                      hours register
CRegHAl  rmb   $01                      hours alarm register
CRegDayW rmb   $01                      day of week register
CRegDayM rmb   $01                      day of month register
CRegMnth rmb   $01                      months register
CRegYear rmb   $01                      years register
CRegA    rmb   $01                      bits 7-0: UIP (read only); DV2-DV0; RS3-
CRegB    rmb   $01                      bits 7-0: SET; PIE; AIE; UIE; SQWE; DM; 
CRegC    rmb   $01                      bits 7-0: IRQF; PF; AF; UF; Unused3-Unus
CRegD    rmb   $01                      bits 7-0: VRT; Unused6-Unused0
CSRAM    rmb   $40-.                    CMOS static RAM

         mod   CSize,CNam,Systm+Objct,ReEnt+Vrsn,Entry,ClkAddr

CNam     fcs   "Clock2"
         fcb   edition
*RTCSlot  fcb   MPISlot

Entry    bra   Init                     clock hardware initialization gets time
         nop                            maintain 3 byte entry table spacing
         bra   GetTime                  get hardware time
         nop                            save a couple cycles with short branch a
SetTime  clrb                           no error for return...
         pshs  cc,d,x,y,u               save regs which will be altered
         ldx   <M$Mem,pcr               get clock base addr
         leay  <SetTable,pcr            point [Y] to RTC register set table
         ldu   #D.Time                  point [U] to time variables in DP
         ldb   #(SetEnd-SetTable)/2     get loop count
         stb   R$B,s                    save counter to B reg on stack
         orcc  #IntMasks                disable IRQs while setting clock
CSetLoop ldd   ,y++                     get clock set data
         bmi   CRegSet                  [A] Sign bit set, go save [B] to clock requirement
         ldb   b,u                      get system time from D.Time variables
CRegSet  anda  #^Sign                   clear sign bit
         std   ,x                       generate clock address strobe, store dat
         dec   R$B,s                    done all clock regs?
         bne   CSetLoop                 no, go do next...
L003A    ldb   #$01
         stb   <$002E
         puls  cc,d,x,y,u,pc            restore altered regs, return to caller

SetTable equ   *                       
         fcb   Sign+CRegB,StopClk      
         fcb   Sign+CRegA,SpeedClk     
GetTable equ   *                       
         fcb   CRegYear,D.Year-D.Time  
         fcb   CRegMnth,D.Month-D.Time 
         fcb   CRegDayM,D.Day-D.Time   
         fcb   CRegHour,D.Hour-D.Time  
         fcb   CRegMin,D.Min-D.Time    
         fcb   CRegSec,D.Sec-D.Time    
GetEnd   equ   *                       
         fcb   Sign+CRegDayW,$01       
         fcb   Sign+CRegHAl,$00        
         fcb   Sign+CRegMAl,$00
         fcb   Sign+CRegSAl,$00        
         fcb   Sign+CRegB,StartClk     
SetEnd   equ   *                       

Init     ldb   #59                      last second in minute
         stb   <D.Sec                   force RTC read

GetTime  clrb                           no error for return...
         pshs  cc,d,x,y,u               save regs which will be altered
         ldb   <D.Sec                   get current second
         incb                           next...
         cmpb  #60                      done minute?
         bhs   CGetT00                  yes, go read RTC...
         stb   <D.Sec                   set new second
         bra   CGExit                   go clean up & return
CGetT00  ldx   <M$Mem,pcr               get clock base addr
         lda   #CRegA                   RTC Update In Progress status register
         sta   ,x                       generate address strobe
         lda   1,x                      get UIP status
         bmi   L003A                    RTC Update In Progress (1:449 chance), go shft D.Ticki
         leay  <GetTable,pcr             point [Y] to RTC "get" register info table
         ldu   #D.Time                  point [U] to time variables in DP
         ldb   #$06
         stb   R$B,s                    save counter to B reg on stack
CGetLoop ldd   ,y++                     get clock register info from table
         sta   ,x                       generate clock address strobe
         lda   1,x                      get clock data
         sta   b,u                      save data to D.Time variables
         dec   R$B,s                    done all D.Time vars?
         bne   CGetLoop                 no, go do next...
CGExit   puls  cc,d,x,y,u,pc            recover regs, return to caller

         emod
CSize    equ   *                       
         end                           
