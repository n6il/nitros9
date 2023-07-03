********************************************************************
* Clock2 - Disto 4-N-1 RTC Driver
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
         IFNE  MPIFlag   
         pshs  cc         Save old interrupt status and mask IRQs
         orcc  #IntMasks 
         ldb   >MPI.Slct  Save currently selected MPak slot on stack
         pshs  b         
         andb  #$F0      
         orb   >SlotSlct,pcr Select MPak slot for clock
         stb   >MPI.Slct 
         ENDC            

         ldx   M$Mem,pcr 
         ldy   #D.Time    Start with seconds

         ldb   #11       
         bsr   GetVal     Get Year
         bsr   GetVal     Get Month
         bsr   GetVal     Get Day
         lda   #3         Mask tens digit of hour to remove AM/PM bit
         bsr   GetVal1    Get Hour
         bsr   GetVal     Get Minute
         bsr   GetVal     Get Second

         IFNE  MPIFlag   
         puls  b          Restore saved "currently" selected MPak slot
         stb   >MPI.Slct 
         puls  cc,pc      Restore previous IRQ status
         ELSE            
         rts              No MPI, don't need to mess with slot, CC
         ENDC            

GetVal   lda   #$0f       Mask to apply to tens digit
GetVal1  stb   1,x       
         decb            
         anda  ,x         read ones digit from clock
         pshs  b          save b
         ldb   #10       
         mul              multiply by 10 to get value
         stb   ,y         Add to ones digit
         puls  b         
         stb   1,x       
         decb            
         lda   ,x         read tens digit from clock and mask it
         anda  #$0f      
         adda  ,y        
         sta   ,y+       
         rts             



Clock2_SetTime
         pshs  cc        
         orcc  #IntMasks 

         IFNE  MPIFlag   
         ldb   >MPI.Slct  Save currently selected MPak slot
         pshs  b         
         andb  #$F0      
         orb   >SlotSlct,pcr Get slot to select
         stb   >MPI.Slct  Select MPak slot for clock
         ENDC            

         ldy   #D.Time+6 
         ldx   M$Mem,pcr 
         clrb            
         bsr   SetVal     Set Second
         bsr   SetVal     Set Minute
         bsr   SetVal     Set Hour
         bsr   SetVal     Set Day
         bsr   SetVal     Set Month
         bsr   SetVal     Set Year

         IFNE  MPIFlag   
         puls  b          Restore old MPAK slot
         stb   >MPI.Slct 
         ENDC            

         puls  cc        
         clrb             No error
         rts             

SetVal   clr   ,-s        Create variable for tens digit
         lda   ,-y        Get current value
DvLoop   suba  #10        Get Tens digit on stack, ones digit in A
         bcs   DvDone    
         inc   ,s        
         bra   DvLoop    
DvDone   adda  #10       
         stb   1,x        Set Clock address
         incb            
         sta   ,x         Store ones digit
         stb   1,x       
         incb            
         puls  a         
         sta   ,x         Store tens digit
         rts             


Clock2_Init     
* Disto 4-N-1 RTC specific initialization
         ldx   M$Mem,pcr 
         ldd   #$010F     Set mode for RTC chip
         stb   1,x       
         sta   ,x        
         ldd   #$0504    
         sta   ,x        
         stb   ,x        
         rts
