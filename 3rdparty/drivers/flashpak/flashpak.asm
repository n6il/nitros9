********************************************************************
* FlashPak - Cloud-9 Flash Pak device driver
*
* $Id$
*
* Ed.    Comments                                       Who YY/MM/DD
* ------------------------------------------------------------------
* 1      Original version                               BGP 02/04/15

         nam   FlashPak
         ttl   Cloud-9 Flash Pak device driver

         ifp1  
         use   defsfile
         endc  

tylg     set   Drivr+Objct
atrv     set   ReEnt+rev
rev      set   $01
edition  set   1

MSB      set   0
LSB      set   1
DATA     set   2

         mod   eom,name,tylg,atrv,start,size

* RBF Data Area
         rmb   129

* Free for driver use
size     equ   .

name     fcs   /FlashPak/
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
Init     ldd   #($FF*256)+1
         stb   V.NDRV,u
         leax  DRVBEG,u
* For each B, compute total sectors...
Init010  sta   V.TRAK,x
         pshs  b,a
         lda   IT.CYL+1,y
         ldb   IT.SCT+1,y
         mul   
         std   DD.TOT+1,x
         puls  b,a
         leax  DRVMEM,x
         decb  
         bne   Init010
         rts   

* Write
*
* Entry:
*    B  = MSB of the disk's LSN
*    X  = LSB of the disk's LSN
*    Y  = address of path descriptor
*    U  = address of device memory area
*
* Exit:
*    CC = carry set on error
*    B  = error code
*
Write    leas  -1,s       make room on the stack 
         ldy   V.PORT,u
         tfr   x,d
         sta   MSB,y
         stb   LSB,y
         ldx   PD.BUF,y   load X with address of path buffer
         clrb  
WritLoop lda   ,x+
         sta   DATA,y
         sta   ,s
WritVfy  lda   DATA,y     verify loop is here
         cmpa  ,s
         bne   WritVfy
         incb  
         bne   WritLoop
         leas  1,s        restore stack
         rts

* Read
*
* Entry:
*    B  = MSB of the disk's LSN
*    X  = LSB of the disk's LSN
*    Y  = address of path descriptor
*    U  = address of device memory area
*
* Exit:
*    CC = carry set on error
*    B  = error code
*
Read     cmpx  #$0000
         beq   ReadLSN0

ReadSect ldy   V.PORT,u
         tfr   x,d
         sta   MSB,y
         stb   LSB,y
         ldx   PD.BUF,y   load X with address of path buffer
         clrb  
ReadLoop lda   DATA,y
         sta   ,x+
         incb  
         bne   ReadLoop
         rts


* Read LSN0 into our path descriptor
ReadLSN0 pshs  y
         bsr   ReadSect
         puls  y
         ldx   PD.BUF,y
         lda   <PD.DRV,y
         leay  DRVBEG,u
         ldb   #DRVMEM
         mul   
         leay  d,y
         ldb   #DD.SIZ-1
LSN0Loop lda   b,x
         sta   b,y
         decb  
         bne   LSN0Loop
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
GetStat  comb  
         ldb   #E$UnkSvc
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

* Term
*
* Entry:
*    U  = address of device memory area
*
* Exit:
*    CC = carry set on error
*    B  = error code
*
Term     clrb  
         rts   

         emod  
eom      equ   *
         end   
