********************************************************************
* DW3 - DriveWire 3 Low Level Subroutine Module
*
* $Id$
*
* Edt/Rev  YYYY/MM/DD  Modified by
* Comment
* ------------------------------------------------------------------
*   1      2008/01/26  Boisy G. Pitre
* Started as a segregated subroutine module.

         nam   DW3
         ttl   DriveWire 3 Low Level Subroutine Module

         ifp1
         use   defsfile
         use   dwdefs.d
         endc

tylg     set   Sbrtn+Objct   
atrv     set   ReEnt+rev
rev      set   $01

         mod   eom,name,tylg,atrv,start,0

name     fcs   /dw3/

* DriveWire subroutine entry table
start    lbra   Init
         bra    Read
	 nop
         lbra   Write

* Term
*
* Entry:
*    U  = address of device memory area
*
* Exit:
*    CC = carry set on error
*    B  = error code
*
Term
         clrb				clear Carry
         rts

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
* Initialize the serial device
Init  
         clrb				clear Carry
         pshs  cc,x			then push CC on stack
         orcc  #IntMasks
         ldx   #PIA1Base		$FF20
         clr   1,x			clear CD
         lda   #%11111110
         sta   ,x
         lda   #%00110100
         sta   1,x
         lda   ,x
         puls  cc,x,pc

* Read
*
*  ON ENTRY:
*    X = ADDRESS OF THE RECEIVE BUFFER
*    A = TIMEOUT VALUE (182 = APPROX ONE SECOND @ 0.89 MHz)
*
*  ON EXIT:
*    Y = DATA CHECKSUM
*    D = ACTUAL NUMBER OF BYTES RECEIVED
*    X AND U ARE PRESERVED
*    CC.CARRY IS SET IF A FRAMING ERROR WAS DETECTED
*
Read  
       use  dwread.asm
         
* Write
*
* Entry:
Write    
         use   dwwrite.asm

         emod
eom      equ   *
         end
