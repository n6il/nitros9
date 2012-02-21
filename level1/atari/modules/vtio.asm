********************************************************************
* VTIO - NitrOS-9 Level 1 Video Terminal I/O driver for Atari XE/XL
*
* $Id$
*
* Edt/Rev  YYYY/MM/DD  Modified by
* Comment
* ------------------------------------------------------------------
*  1       2012/02/20  Boisy G. Pitre
* Started from VTIO for the CoCo
                         
         nam   VTIO      
         ttl   OS-9 Level One V2 CoCo I/O driver
                         
         ifp1            
         use   defsfile  
         use   scfdefs   
         use   vtiodefs  
         endc            
                         
tylg     set   Drivr+Objct
atrv     set   ReEnt+rev 
rev      set   $00
edition  set   1
                         
         mod   eom,name,tylg,atrv,start,size
                         
size     equ   V.Last    
                         
         fcb   UPDAT.+EXEC.
                         
name     fcs   /VTIO/    
         fcb   edition   
                         
start    lbra  Init      
         lbra  Read      
         lbra  Write     
         lbra  GetStat   
         lbra  SetStat   
         lbra  Term      
                         
* Init
*
* Entry:
*    Y  = address of device descriptor
*    U  = address of device memory area
*
* Exit:
*    CC = carry set on error
*    B  = error code
*
Init                     
***********************************
 clrb
cleario
 ldx   #$D000
 clr   b,x
 ldx   #$D200
 clr   b,x
 ldx   #$D300
 clr   b,x
 ldx   #$D400
 clr   b,x
 decb
 bne   cleario
 lda   #3
 sta   $D20F ; set Pokey to active

delay
 lda   #$E4
 sta   $D01A  ; set screen color
* lda   #$A0
* sta   $D200
* lda   #$A1
* sta   $D202  ; set audf1 and audf2
* lda   #$A8
* sta   $D201
* sta   $D203  ; set audc1 and audc2
wait
 jmp   wait
***********************************

                         
* Term
*
* Entry:
*    U  = address of device memory area
*
* Exit:
*    CC = carry set on error
*    B  = error code
*
Term     pshs  cc        
         puls  pc,cc     
                         
* Read
*
* Entry:
*    Y  = address of path descriptor
*    U  = address of device memory area
*
* Exit:
*    A  = character read
*    CC = carry set on error
*    B  = error code
*
Read                     
L00A3    rts             
                         

* Write
*
* Entry:
*    A  = character to write
*    Y  = address of path descriptor
*    U  = address of device memory area
*
* Exit:
*    CC = carry set on error
*    B  = error code
*
Write

         rts             
                         
* GetStat
*
* Entry:
*    A  = function code
*    Y  = address of path descriptor
*    U  = address of device memory area
*
* Exit:
*    CC = carry set on error
*    B  = error code
*
GetStat
         clrb            
         rts             
                                                 
* SetStat
*
* Entry:
*    A  = function code
*    Y  = address of path descriptor
*    U  = address of device memory area
*
* Exit:
*    CC = carry set on error
*    B  = error code
*
SetStat
L055C    rts             
                         
         emod            
eom      equ   *         
         end             
