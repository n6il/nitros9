********************************************************************
* Boot - Disto RAMPak Boot Module
*
* $Id$
*
* Edt/Rev  YYYY/MM/DD  Modified by
* Comment
* ------------------------------------------------------------------
*   5      ????/??/??  Alan DeKok
* Created.
*
*   6      1998/10/20  Boisy G. Pitre
* Fixed small bugs, improved speed.

         nam   Boot
         ttl   Disto RAMPak Boot Module

* Disassembled 94/06/25 11:37:47 by Alan DeKok

         IFP1  
         use   defsfile
         ENDC  

tylg     set   Systm+Objct
atrv     set   ReEnt+rev
rev      set   $00
edition  set   6

         mod   eom,name,tylg,atrv,start,size

* on-stack buffer to use
         org   0
size     equ   .

name     equ   *
         fcs   /Boot/
         fcb   edition

start    orcc  #IntMasks  ensure IRQ's are off.

         pshs  x,d        save 4 bytes of junk
R.D      equ   1
R.X      equ   3

         lda   >MPI.Slct  get current slot
         pshs  a          save off
         lda   >PakSlot,pcr get multipak slot number
         bmi   cont       if >127, invalid slot number
         anda  #$03       force it to be legal
         ldb   #$11
         mul              put it into both nibbles
         stb   >MPI.Slct  go to the desired slot

cont     ldd   #$0001     request one byte (will round up to 1 page)
         os9   F$SRqMem   request the memory
         bcs   L00AE      exit on error
* U is implicitely the buffer address to use

         ldx   #$0000     X=0: got to sector #$0000
         bsr   GetSect    load in LSN0, and point Y to the buffer
         bcs   L00AE

         ldd   <DD.BSZ,u  size of the bootstrap file
         std   R.D,s      save it on the stack (0,s is junk)
         ldx   <DD.BT+1,u get starting sector of the bootstrap file

         pshs  x          save the starting sector number
         ldd   #$0100     one page of memory
         os9   F$SRtMem   return the copy of LSN0 to free memory

         ldd   R.X,s      get size of boot memory to request
         IFGT  Level-1
         os9   F$BtMem    ask for the boot memory
         ELSE
         os9   F$SRqMem   ask for the boot memory
         ENDC
         puls  x          restore the starting sector number
         bcs   L00AE      no memory: exit with error

         stu   R.X,s      save start address of memory allocated
         std   R.D,s      and the size of the boot memory
         beq   L00A7      if no memory allocated, exit

SectLp   pshs  x,d        save sector #, size of boot
         bsr   GetSect    read one sector
         bcs   L00AC      if there's an error, exit
         puls  x,d        restor sector, size of boot

         leau  $0100,u    go up one page in memory
         leax  $01,x      go to the next sector
         subd  #$0100     take out one sector, need value in B, too.
         bhi   SectLp     loop until all sectors are read

L00A7    puls  a
         sta   >MPI.Slct
         clrb             clear carry
         puls  d          return size of boot memory to user
         bra   L00B0      and go exit

L00AC    leas  $04,s      remove X,D off of stack
L00AE    puls  a
         sta   >MPI.Slct
         leas  $02,s      kill D off of the stack

L00B0    puls  x          restore start address of memory allocated
*         leas  size,s     remove the on-stack buffer
         clr   >DPort     stop the disk
L00BA    rts   

* GetSect: read a sector off of the disk
* Entry: X = sector number to read
GetSect  pshs  d,x,y
         ldy   >Address,pcr grab the device address
         tfr   x,d        move 16 bit LSN into 2 8-bit registers
         sta   2,y        save HB LSN
         stb   1,y        save LB LSN
         leax  ,u         get buffer address to write into
         clrb             and start out at byte zero

ReadLp   stb   ,y         save byte number
         lda   3,y        grab the byte
         sta   ,x+        save in the buffer
         incb             go to the enxt byte
         bne   ReadLp
         clrb             no errors
         puls  d,x,y,pc   restore registers and return

         IFGT  Level-1
Pad      fill  $39,$1D0-6-*
         ENDC

Address  fdb   $FF40      address of the device to boot from
PakSlot  fcb   $01        multipak slot number

         emod  
eom      equ   *
         end   
