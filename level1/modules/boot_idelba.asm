********************************************************************
* Boot - IDE Boot Module (LBA Mode)
*
* $Id$
*
* Ed.    Comments                                       Who YY/MM/DD
* ------------------------------------------------------------------
* ?      Disassembled                                   AD  94/06/25
* 6      Redone for IDE                                 PTB 99/08/17
* 7      Added use of LSN bits 23-16                    BGP 02/06/27

         nam   Boot
         ttl   IDE Boot Module (LBA Mode)

         ifp1
         use   defsfile
         use   rbfdefs
         endc

tylg     set   Systm+Objct
atrv     set   ReEnt+rev
rev      set   2
edition  set   7

* Disassembled 94/06/25 11:37:47 by Alan DeKok 
* ReDone by Paul T. Barton 99/08/17, for IDE 
* 
Port     equ   $FF70      still leaves room for SSPak & SSP & MPI 
RData    equ   0          data 0..7 
WData    equ   0          data 0..7 
ErrReg   equ   1          Has the errors 
SecCnt   equ   2          always =1 
SecNum   equ   3
CylLow   equ   4
CylHigh  equ   5
DevHead  equ   6          0,1,0,DEV,0,0,0,0 
Status   equ   7          Results of read/write 
CmdIde   equ   7          Commands 
Latch    equ   8          Latch

ReadCmd  equ   $20
Diagnos  equ   $90

BusyBit  equ   %10000000  BUSY=1 
DrdyBit  equ   %01000000  drive ready=1 
DscBit   equ   %00010000  seek finished=1 
DrqBit   equ   %00001000  data requested=1 
ErrBit   equ   %00000001  error_reg has it 
RdyTrk   equ   %01010000  ready & over track 
RdyDrq   equ   %01011000  ready w/ data 
Master   equ   %11100000  LBA MODE 
Slave    equ   %11110000  LBA MODE 


WhchDriv equ   Master     Drive to use (Master or Slave)

         mod   eom,name,tylg,atrv,start,size

* on-stack buffer to use 
         org   0
btmem    rmb   2
btsiz    rmb   2
btloc    rmb   3
size     equ   .

name     fcs   /Boot/
         fcb   edition

start          
         orcc  #IntMasks  ensure IRQ's are off. 
         leas  -size,s

         clr   >$FF40     stop the disk 
         lbsr  Init 

         ldd   #$0001     request one byte (will round up to 1 page) 
         os9   F$SRqMem   request the memory 
         bcs   L00B0      exit on error 

* U is implicitely the buffer address to use 

         clrb  
         ldx   #$0000     X=0: got to sector #$0000 
         bsr   GetSect    load in LSN0, U = buffer start 
         bcs   L00B0

         IFGT  Level-1
         lda   #'0        --- loaded in LSN0 
         jsr   <D.BtBug   --- 
         ENDC  

         ldd   <DD.BSZ,u  size of the bootstrap file 
         std   btsiz,s    save it on the stack (0,s is junk) 
         lda   <DD.BT,u   get starting sector bits 23-16
         ldx   <DD.BT+1,u get starting sector of the bootstrap file 
         sta   btloc,s
         stx   btloc+1,s

         ldd   #256       one page of memory 
         os9   F$SRtMem   return the copy of LSN0 to free memory 

         ldd   btsiz,s    get size of boot memory to request 
         IFEQ  Level-2
         os9   F$BtMem    ask for the boot memory 
         ELSE  
         os9   F$SRqMem   ask for the boot memory 
         ENDC  
         bcs   L00AE      no memory: exit with error 

         std   btsiz,s
         stu   btmem,s    save start address of memory allocated 
         ldd   btsiz,s    and the size of the boot memory 
         beq   L00B0      if no memory allocated, exit 
         pshs  d          save off temp size
SectLp         
         ldb   btloc+2,s
         bsr   GetSect    read one sector 
         bcs   L00AE      if there's an error, exit 

         IFGT  Level-1
         lda   #'.        dump out a period for boot debugging 
         jsr   <D.BtBug   do the debug stuff 
         ENDC  

         leau  256,u
         leax  1,x        go to the next sector 
         bne   Sect2
         incb  
         stb   btloc+2,s
Sect2          
         ldd   ,s
         subd  #256       take out one sector, need value in B, too. 
         std   ,s
         bhi   SectLp     loop until all sectors are read 

L00A7    clrb             clear carry 
         ldd   btsiz+2,s

L00AE    leas  $02,s      kill D off of the stack 
         ldx   btmem,s
L00B0    leas  size,s     remove the on-stack buffer 
L00BA    rts   

Address  fdb   Port

* GetSect: read a sector off of the disk 
* Entry: B,X = sector number to read 
* Memory: U = where to put it 

GetSect        
         pshs  b,x,y
         ldy   <Address,pcr grab the device address 
         bsr   ChkBusy

RdyHuh1        
         lda   Status,y   is IDE ready for commands? 
         anda  #DrdyBit   ready ? 
         beq   RdyHuh1    loop until Drdy =1 

         lda   #WhchDriv
         sta   DevHead,y  0L0d/0hhh device=LBA 
         lda   #$01       only one at a time 
         sta   SecCnt,y   only one at a time 
         stb   CylHigh,y  bits 23-16 
         tfr   x,d        sector number to read 
         sta   CylLow,y   hi-byte 
         stb   SecNum,y
         leax  ,u         where to put the sector 
         lda   #ReadCmd   read one sector 
         sta   CmdIde,y   finish process 

Blk2           
         lda   Status,y   is IDE ready to send? 
         anda  #DrqBit    DRQ, data request 
         beq   Blk2       loop while DRQ =0 

         clr   ,-s
BlkLp          
         lda   RData,y    A <- IDE 
         ldb   Latch,y
         std   ,x++       into RAM 
         inc   ,s
         bpl   BlkLp      go get the rest 
         puls  b

         lda   Status,y   check for error-bit 
         clrb  
         puls  b,x,y,pc
* ------------------------------------------ 

ChkBusy        
         lda   Status,y
         anda  #BusyBit   1xxx-xxxx 
         bne   ChkBusy    if =1 then loop 
         rts              exit when BUSY =0 

Init           
         pshs  d,y
         ldy   <Address,pcr
         bsr   ChkBusy    could be spinning up... 
         lda   #Diagnos   hits all drives 
         sta   CmdIde,y   ./ 
         bsr   ChkBusy    wait 'til both done 
         clrb             no errors 
         puls  d,y,pc

         IFEQ  Level-2
Pad      fill  $39,$1D0-3-*
         ENDC


         emod  
eom      equ   *
         end
