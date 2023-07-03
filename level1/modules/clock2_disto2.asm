********************************************************************
* Clock2 - Disto 2-N-1 RTC Driver
*
* $Id$
*
* Edt/Rev  YYYY/MM/DD  Modified by
* Comment
* ------------------------------------------------------------------
*   1      2004/08/18  Boisy G. Pitre
* Separated clock2 modules for source clarity.
*
*          2023/07/02  Boisy G. Pitre
* Reintroduced a single clock module and this file is now included in clock.asm.

RTC.Base equ   $FF50      Base address of clock

         IFNE  MPIFlag   
SlotSlct fcb   MPI.Slot-1 Slot constant for MPI select code
         ENDC            

Clock2_GetTime
         pshs  a,cc       Save old interrupt status and mask IRQs
         bsr   RTCPre    

         bsr   GetVal     Get Year
         bsr   GetVal     Get Month
         bsr   GetVal     Get Day
         decb             ldb #5
         stb   2,x       
         decb            
         lda   ,x        
         anda  #3        
         bsr   GetVal1    Get Hour
         bsr   GetVal     Get Minute
         bsr   GetVal     Get Second

RTCPost  clr   >$FFD9     2 MHz  (Really should check $A0 first)
         puls  cc,b      

         IFNE  MPIFlag   
         stb   >MPI.Slct  Restore saved "currently" selected MPak slot
         ENDC            

         clrb            
         rts             

RTCPre   orcc  #IntMasks 

         IFNE  MPIFlag   
         ldb   >MPI.Slct  Save currently selected MPak slot on stack
         stb   3,s       
         andb  #$F0      
         orb   >SlotSlct,pcr Get slot to select
         stb   >MPI.Slct  Select MPak slot for clock
         ENDC            

         ldy   #D.Time   
         ldx   M$Mem,pcr 
         clr   1,x       
         ldb   #12       
         clr   >$FFD8     1 MHz
         rts             

GetVal   stb   2,x       
         decb            
         lda   ,x         read tens digit from clock
         anda  #$0f      
GetVal1  pshs  b          save b
         ldb   #10       
         mul              multiply by 10 to get value
         stb   ,y         save 10s value
         puls  b          set up clock for ones digit
         stb   2,x       
         decb            
         lda   ,x         read ones digit from clock
         anda  #$0f      
         adda  ,y         add ones + tens
         sta   ,y+        store clock value into time packet
         rts             


Clock2_SetTime
         pshs  a,cc      
         lbsr  RTCPre     Initialize

         bsr   SetVal     Set Year
         bsr   SetVal     Set Month
         bsr   SetVal     Set Day
         ldd   #$0805     $08 in A, $05 in B
         bsr   SetVal1    Set Hour   (OR value in A ($08) with hour)
         bsr   SetVal     Set Minute
         bsr   SetVal     Set Second

         lbra  RTCPost    Clean up + return

SetVal   clra            
SetVal1  stb   2,x        Set Clock address
         decb            
         pshs  b         
         ldb   ,y+        Get current value
DvLoop   subb  #10        Get Tens digit in A, ones digit in B
         bcs   DvDone    
         inca            
         bra   DvLoop    
DvDone   addb  #10       
         sta   ,x         Store tens digit
         tfr   b,a       
         puls  b          Get back original clock address
         stb   2,x       
         decb            
         sta   ,x         Store ones digit
Clock2_Init
         rts             
