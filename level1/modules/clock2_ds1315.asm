********************************************************************
* Clock2 - Dallas Semiconductor DS1315 RTC Driver
*
* $Id$
*
* The Burke & Burke HD Controller as well as Cloud-9's products
* use the DS1315.
*
* Edt/Rev  YYYY/MM/DD  Modified by
* Comment
* ------------------------------------------------------------------
*   1      2004/08/18  Boisy G. Pitre
* Separated clock2 modules for source clarity.
*
*          2023/07/02  Boisy G. Pitre
* Reintroduced a single clock module and this file is now included in clock.asm.

         IFNE  BNB
RTC.Base equ   $FF5C      In SCS* Decode
RTC.Zero equ   -4         Send zero bit by writing this offset
RTC.One  equ   -3         Send one bit by writing this offset
RTC.Read equ   0          Read data from this offset
         ELSE            
         IFNE  SUPERBOARD
RTC.Base equ   SBRTCBase
RTC.Zero equ   0          Send zero bit by writing this offset
RTC.One  equ   1          Send one bit by writing this offset
RTC.Read equ   2          Read data from this offset
         ELSE
RTC.Base equ   $FF7C      Fully decoded RTC
RTC.Zero equ   -4         Send zero bit by writing this offset
RTC.One  equ   -3         Send one bit by writing this offset
RTC.Read equ   0          Read data from this offset
         ENDC            
         ENDC            


         IFNE  MPIFlag   
SlotSlct fcb   MPI.Slot-1 Slot constant for MPI select code
         ENDC            

Clock2_SetTime
         pshs  u,y,cc    
         leay  SendBCD,pcr Send bytes of clock
         bra   TfrTime   

Clock2_GetTime
         pshs  u,y,cc    
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

         puls  u,y,cc,pc 

ClkMsg   fcb   $C5,$3A,$A3,$5C,$C5,$3A,$A3,$5C
* Enable clock with message $C53AA35CC53AA35C
SendMsg  lda   RTC.Read,u Send Initialization message to clock
         leax  <ClkMsg,pcr
         ldb   #8        
msgloop  lda   ,x+       
         bsr   SendByte  
         decb            
         bne   msgloop   
Clock2_Init
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
