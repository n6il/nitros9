********************************************************************
* Clock2 - Burke & Burke/TC^3 clock driver
*
* $Id$
*
* Ed.    Comments                                       Who YY/MM/DD
* ------------------------------------------------------------------
* 1      Created                                        BGP 02/10/10

         nam   Clock2    
         ttl   Burke & Burke/TC^3 clock driver

         ifp1            
         use   defsfile  
         endc            

rev      set   1         
edition  set   1         

RTC.Zero equ   -4         Send zero bit by writing this offset
RTC.One  equ   -3         Send one bit by writing this offset
RTC.Read equ   0          Read data from this offset

         ifne  TC3       
RTC.Base equ   $FF7C      We map the clock into this addr
         else            
MPIFlag  set   1         
RTCMPSlt equ   $22        MPI Slot ($00-$33) where RTC is
RTC.Base equ   $FF5C      Burke & Burke
         endc            

         mod   CSize,CNam,Systm+Objct,ReEnt+rev,Entry,RTC.Base

CNam     fcs   "Clock2"  
         fcb   edition    edition byte
         ifeq  TC3       
SlotSlct fcb   RTCMPSlt   slot constant for MPI select code
         endc            

Entry    bra   Init       clock hardware initialization
         nop              maintain 3 byte entry table spacing
         bra   ReadRTC    get hardware time
         nop              save a couple cycles with short branch a
         bra   SetTime    set hardware time

* SetTime
SetTime  ldx   R$X,u     
         ldd   ,x        
         std   <D.Year   
         ldd   2,x       
         std   <D.Day    
         ldd   4,x       
         std   <D.Min    
         andcc  #^Carry   
         pshs  d,x,y,u,cc
         leay  SendBCD,pcr
         lbra  TfrTime   
         rts             

GetTime  ldb   <D.Sec     get seconds
         incb            
         cmpb  #60       
         beq   ReadRTC    if zero, get SmartWatch time
         stb   <D.Sec     else update second
         rts             

Init                     
ReadRTC  pshs  d,x,y,u,cc save regs which will be altered
         leay  ReadBCD,pcr Read bytes of clock

TfrTime  orcc  #IntMasks  turn off interrupts
         ldu   M$Mem,pcr  Get base address

         IFNE  MPIFlag   
         ldb   >MPI.Slct  Select slot
         pshs  b         
         andb  #$F0      
         orb   SlotSlct,pcr
         stb   >MPI.Slct 
         ENDC            

         lbsr  SendMsg    Initialize clock
         ldx   #D.Sec    
         ldb   #8         Tfr 8 bytes

tfrloop  jsr   ,y         Tfr 1 byte
         bitb  #$03      
         beq   skipstuf   Skip over day-of-week, etc.
         leax  -1,x      
skipstuf decb            
         bne   tfrloop   

         IFNE  MPIFlag   
         puls  b         
         stb   >MPI.Slct  restore MPAK slot
         ENDC            

         puls  d,x,y,u,cc,pc

ClkMsg   fcb   $C5,$3A,$A3,$5C,$C5,$3A,$A3,$5C

* Enable clock with message $C53AA35CC53AA35C
SendMsg  lda   RTC.Read,u Send Initialization message to clock
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
         ldb   #$80       High bit will rotate out after we read 8 bits
readbit  lda   RTC.Read,u Read a bit
         lsra            
         rorb             Shift it into B
         bcc   readbit    Stop when marker bit appears
         tfr   b,a       
         bra   BCDEnter   Convert BCD number to Binary
BCDLoop  subb  #6         by subtracting 6 for each $10
BCDEnter suba  #$10      
         bhs   BCDLoop   
         stb   ,x        
         puls  b,pc      

         emod            
CSize    equ   *         
         end             
