********************************************************************
* Clock2 - Disto 2N1/4N1 clock driver
*
* $Id$
*
* Ed.    Comments                                       Who YY/MM/DD
* ------------------------------------------------------------------
* 1      MPI slot dependent Disto RTC where edition     BRI 89/10/12
*        byte is really MPI slot code.

         nam   Clock2
         ttl   Disto 2N1/4N1 clock driver

         ifp1  
         use   defsfile
         endc  

tylg     set   Systm+Objct
atrv     set   ReEnt+rev
rev      set   1
edition  set   3


RTCMPSlt equ   $33
RTCBase  equ   $FF50      clock base address

         mod   eom,name,tylg,atrv,start,RTCBase

name     fcs   "Clock2"
         fcb   edition
MPISlot  fcb   RTCMPSlt

start    bra   Init
         nop   
         bra   GetTime
         nop   
         lbra  SetTime

Init     pshs  x,a,cc
         ldx   M$Mem,pcr  get hw addr of disto clock
         orcc  #IntMasks  mask IRQ and FIRQ
         sta   >$FFD8     slow down CoCo 3 to .89MHz
         ldb   >MPI.Slct  get current MPI slot
         pshs  b          save it
         lda   >MPISlot,pcr get our slot selection
         sta   >MPI.Slct  select it!
         ldd   #$010F
         stb   1,x
         sta   ,x
         ldd   #$0504
         sta   ,x
         stb   ,x
         puls  b          get original slot
         stb   >MPI.Slct  select it!
         stb   >$FFD9     speed Coco 3 up to 1.78MHz
         ldb   #59        last second in minute
         stb   <D.Sec     force RTC read
         puls  x,a,cc     fall through to RTC read ebelow

GetTime  clrb             return no error
         pshs  u,y,x,b,a,cc save regs to be altered
         ldb   <D.Sec     get current second
         incb             next...
         cmpb  #60        minute done?
         bcc   L005E      yes, go read RTC...
         stb   <D.Sec     set new second
         bra   GTExit     go clean up & return
L005E    ldx   M$Mem,pcr  get clock base addr
         orcc  #IntMasks
         sta   >$FFD8
         ldb   >MPI.Slct
         pshs  b
         lda   >MPISlot,pcr
         sta   >MPI.Slct
         ldy   #D.Time
         ldb   #$0B
         bsr   L0098
         bsr   L0098
         bsr   L0098
         ldb   #$05
         stb   1,x
         decb  
         lda   ,x
         anda  #$03
         bsr   L009F
         bsr   L0098
         bsr   L0098
         puls  b
         stb   >MPI.Slct
         stb   >$FFD9
GTExit   puls  pc,u,y,x,b,a,cc recover regs & return

L0098    stb   $01,x
         decb  
         lda   ,x
         anda  #$0F
L009F    pshs  b
         ldb   #$0A
         mul   
         pshs  b
         ldb   $01,s
         stb   $01,x
         lda   ,x
         anda  #$0F
         adda  ,s+
         puls  b
         decb  
         sta   ,y+
         rts   

SetTime  clrb             no error for return...
         pshs  u,y,x,b,a,cc save regs to be altered
         ldx   M$Mem,pcr  get clock base addres
         orcc  #IntMasks
         sta   >$FFD8
         ldb   >MPI.Slct
         pshs  b
         lda   >MPISlot,pcr
         sta   >MPI.Slct
         ldy   #D.Time
         ldb   #$0B
         bsr   L00EA
         bsr   L00EA
         bsr   L00EA
         bsr   L00EA
         bsr   L00EA
         bsr   L00EA
         puls  b
         stb   >MPI.Slct
         stb   >$FFD9
         puls  pc,u,y,x,b,a,cc restore altered regs & return

L00EA    stb   $01,x
         decb  
         clra  
         pshs  b,a
         ldb   ,y+
         clr   ,-s
L00F4    subb  #$0A
         bcs   L00FC
         inc   ,s
         bra   L00F4
L00FC    addb  #$0A
         puls  a
         ora   ,s+
         sta   ,x
         tfr   b,a
         puls  b
         stb   $01,x
         decb  
         sta   ,x
         rts   

         emod  
eom      equ   *
         end   

