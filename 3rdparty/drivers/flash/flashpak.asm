********************************************************************
* FlashPak - FLASH Pak device driver based on Disto's RAM Pak driver
* Copyright 2001 by Agesino Primatic, Jr.
* Free for any use as long as this copyright message is included.
*
* $Id$
*
* Ed.   Comments                                        Who YY/MM/DD
* ------------------------------------------------------------------
* 1     Original version by A. Primatic                 AP  01/04/05


         nam   FlashPak
         ttl   FLASH Pak device driver

         ifp1  
         use   defsfile
         endc  

tylg     set   Drivr+Objct
atrv     set   ReEnt+rev
rev      set   $01
edition  set   1


         mod   eom,name,tylg,atrv,start,size


* RBF Data Area
         rmb   129


* Free for driver use
ORGSlot  rmb   1
BlkAdr   rmb   2          address of our 16K block of memory
CurPD    rmb   2          our current path descriptor
CurLSN   rmb   2          our current LSN


FOffset  equ   0
FLSNLo   equ   1
FLSNHi   equ   2
FData    equ   3


size     equ   .
         fcb   $FF


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
Init     ldd   #($FF*256)+3 this driver can handle 3 "disks"
         stb   V.NDRV,u
         leax  DRVBEG,u   start at beginning of drive table of disk 0


* For each B, compute total sectors...
InitLp   sta   V.TRAK,x   initialize to 0xff so first seek gets LSN0
         pshs  b,a
         lda   IT.CYL+1,y compute total sectors
         ldb   IT.SCT+1,y
         mul   
         std   DD.TOT+1,x fill in table
         puls  b,a
         leax  DRVMEM,x   move to drive table of next disk
         decb  
         bne   InitLp


* Reserve 16K of memory for sector copies
         ldd   #$4000     request 16K bytes
         pshs  u          save address of device memory area
         os9   F$SRqMem   Request System Memory
         tfr   u,x        X = starting address of memory area
         puls  u          restore address of device memory area
         bcs   InitErr    branch if error


         stx   BlkAdr,u   store starting address
         clrb             no errors here


InitErr  rts              all done with intialization


* Write
*
* Entry:
*    B  = MSB of the disk's LSN
*    X  = LSW of the disk's LSN
*    Y  = address of path descriptor
*    U  = address of device memory area
*
* Exit:
*    CC = carry set on error
*    B  = error code
*
Write    pshs  cc         save carry flags (including interrupt enable)
*       orcc    #IntMasks       mask interrupts
         lbsr  SelSlot    get to the proper MPI slot
         stx   CurLSN,u   save LSN
         tfr   x,d        now, D = LSN
         ldx   PD.BUF,y   get address of path buffer
         sty   CurPD,u    save path descriptor
         ldy   V.PORT,u   get base address of FlashPak
         sta   FLSNHi,y   write LSN hi byte to FlashPak
         stb   FLSNLo,y   write LSN lo byte to FlashPak
         clrb             set up for 256 transfers


* First, we need to see if a write would work
WrLp1    stb   FOffset,y  write offset to FlashPak
         lda   ,x         get what we want to write
         coma             data on flash is stored complemented
*       nop
         anda  FData,y    logical-and with data from FlashPak
         coma             get back uncomplemented version
*       nop
         cmpa  ,x+        does result match with what we want to write?
         bne   WrErase    if no, then we need to erase sector


         incb             go to next word
         bne   WrLp1      branch if not done


* At this point, write can proceed
         ldx   CurPD,u    get back path descriptor
         ldx   PD.BUF,x   get address of the path buffer
         ldy   V.PORT,u   get base address of FlashPak
         bsr   WrBlock    write 256-byte block


WrExit   lbra  RstSlot    restore MPI slot


* WrBlock  -- copies 256 bytes from memory to flash
*
* Entry:
*       B = Offset into flash
*       X = Address of first memory location
*       CurLSN,u = current LSN (for WrByte)
*
* Exit:
*       X = Address of next memory location
*
* Destroys:
*       A, B
WrBlock  clrb             start at offset of 0
         pshs  b          push offset (of 0) on stack


WrLoop   lda   ,x+        get data from buffer
         bsr   WrByte     write that byte
         bcs   WrBlkDn    if there was an error, break out


         inc   ,s         increment offset
         ldb   ,s         get new offset
         bne   WrLoop


WrBlkDn  leas  1,s        remove offset from stack
         rts   


* WrByte
*
* Entry:
*    A  = Byte to write
*    B  = Offset to write
*    Y  = base address of FlashPak
*    U  = address of device memory area
*    CurLSN,u = current LSN
*
* Destroys:
*    B
*
WrByte   pshs  d,x        save d and x for later
         bsr   DoAA55


         ldx   #$55       flash[0x5555] = 0xa0
         ldd   #$a055
         bsr   XfrByte


         puls  d          flash[addr] = ~data
         coma             data on flash is complemented
*       nop
         ldx   CurLSN,u
         bsr   XfrByte


         pshs  a          save byte that was written on stack


* Now, loop until done
WrBWait  ldb   FData,y    get flash data
         cmpb  ,s         does it match?
         beq   WrBDone    if yes, write passed


         bitb  #$20       did we exceed the time limit?
         beq   WrBWait    if no, try again


* We exceed time limit -- try one more time
         ldb   FData,y    get flash data
         cmpb  ,s         does it match?
         beq   WrBDone    whew!  just made it


* Write Failure
         lbsr  RstFlsh    reset flash to read mode
         comb             set carry flag
         ldb   #E$Write   set error code
         bra   WrBExit


WrBDone  clrb             no error here


WrBExit  puls  a,x        restore stack
         rts   


* XfrByte -- transfers one byte to flash
*
* Entry:
*    A  = Byte to transfer
*    B  = Offset
*    X  = LSN
*    Y  = base address of FlashPak
XfrByte  exg   d,x        get LSN into D
         sta   FLSNHi,y   write LSN hi byte to FlashPak
         stb   FLSNLo,y   write LSN lo byte to FlashPak
         exg   d,x        get byte/offset into D
         stb   FOffset,y  write offset to FlashPak
         sta   Fdata,y    write data to FlashPak
         rts              all done


* DoAA55 Sends 0x5555=0xaa, then 0xaaaa=0x55 to flash
DoAA55   ldx   #$55       flash[0x5555] = 0xaa
         ldd   #$aa55
         bsr   XfrByte


         ldx   #$2a       flash[0x2aaa] = 0x55
         ldd   #$55aa
         bra   XfrByte    will also return


* WrErase
*
* Entry:
*    Y  = base address of FlashPak
*    U  = address of device memory area
*    CurLSN,u = current LSN
*
* First, we need to read the entire sector into BlkAdr
WrErase  ldx   BlkAdr,u   Get start of BlkAddr
         ldd   CurLSN,u   Get current LSN
         sta   FLSNHi,y   write LSN hi byte to FlashPak
         andb  #$C0       Get to first LSN of this sector


WrErLp1  stb   FLSNLo,y   write LSN lo byte to FlashPak
         pshs  b          save LSN_lsb on stack
         lbsr  RdBlock    transfer 256 bytes from flash to memory
         puls  b          get back LSN_lsb
         incb             go to next LSN
         bitb  #$3f       are we done?
         bne   WrErLp1    if no, go back for some more


* Now, we have the entire sector copied into memory
* Replace the old LSN with the new one
         ldx   BlkAdr,u   get start of BlkAddr
         ldd   CurLSN,u   get current LSN
         exg   a,b
         anda  #$3f       find offset
         clrb             start at beginning of LSN
         leax  d,x        move to LSN in memory
         ldy   CurPD,u    get back path descriptor
         ldy   PD.BUF,y   get address of path buffer


WrErLp2  lda   ,y+        get byte from path buffer
         sta   ,x+        put byte into BlkMem
         incb             move to next byte
         bne   WrErLp2    branch if not done


* Now, we have the entire sector with the new LSN in memory
* Erase sector
         ldy   V.PORT,u
         bsr   DoAA55


         ldx   #$55       flash[0x5555] = 0x80
         ldd   #$8055
         bsr   XfrByte


         bsr   DoAA55


         ldd   CurLSN,u   flash[SectAddr] = 0x30
         andb  #$C0
         tfr   d,x
         ldd   #$3000
         bsr   XfrByte


* Now, loop until done
WrEWait  ldb   FData,y    get flash data
         bmi   WrEDone    if DQ7 is set, then we're done


         bitb  #$20       did we exceed the time limit?
         bne   WrETime    if yes, go on


* Sleep for 250ms
         ldx   #15        15 * 1/60 = 250ms
         os9   F$Sleep
         bra   WrEWait    go back for more


* We exceeded the time limit -- try one more time
WrETime  ldb   FData,y    get flash data
         bmi   WrEDone    whew! just made it


* Erase Failure
         bsr   RstFlsh    reset flash to read mode
         comb             set carry flag
         ldb   #E$Write   set error code
         bra   WrEExit


* Finally, we need to write the sector back
WrEDone  ldx   BlkAdr,u   get pointer to memory version of sector
         ldy   V.PORT,u   get base address of FlashPak
         ldd   CurLSN,u   get current LSN
         andb  #$C0       get to beginning of sector
         pshs  b          push LSN_lsb on stack


WrErLp3  stb   CurLSN+1,u write new LSN lsb to CurLSN
         lbsr  WrBlock    transfer 256 bytes from memory to flash
         bcs   WrEExit    branch if error


         inc   ,s         go to next LSB_lsb
         ldb   ,s         get back LSN_lsb
         bitb  #$3f       are we done?
         bne   WrErLp3    if no, go back for some more


         clrb             no error here


WrEExit  leas  1,s        remove LSN_lsb from stack
         bra   RstSlot    will also return


* RstFlash -- Resets flash to read mode
*
RstFlsh  lbsr  DoAA55


         ldx   #$55       flash[0x5555] = 0xf0
         ldd   #$f055
         lbra  XfrByte    will also return


* Read
*
* Entry:
*    B  = MSB of the disk's LSN
*    X  = LSW of the disk's LSN
*    Y  = address of path descriptor
*    U  = address of device memory area
*
* Exit:
*    CC = carry set on error
*    B  = error code
*
Read     cmpx  #$0000     check to see if we're reading LSN0
         beq   RdLSN0     if we are, do special read


RdSect   pshs  cc         save flags (including interrupt enable)
*       orcc    #IntMasks       mask interrupts
         bsr   SelSlot    select the proper MPI slot
         tfr   x,d        now, D = LSN_lsw
         ldx   PD.BUF,y   get address of the path buffer
         ldy   V.PORT,u   get base address of FlashPak
         sta   FLSNHi,y   write LSN hi byte to FlashPak
         stb   FLSNLo,y   write LSN lo byte to FlashPak
         bsr   RdBlock    go get the 256-byte block


* Restore the original MPI slot value we saved off
RstSlot  lda   >ORGSlot,u get original slot value
         sta   >MPI.Slct  put it back
         puls  cc         get back flags (including interrupt enable)
         clrb             no errors
         rts              we're done


* RdBlock  -- copies 256 bytes from flash to memory
*
* Entry:
*       B = Offset into flash
*       X = Address of first memory location
*
* Exit:
*       X = Address of next memory location
*
* Destroys:
*       A, B
RdBlock  clrb             will do this 256 times


RdLoop   stb   FOffset,y  write offset to FlashPak
         lda   FData,y    get data from FlashPak
         coma             data on flash is stored complemented
*       nop
         sta   ,x+        write it into buffer
         incb             go to next word
         bne   RdLoop     branch if not done


         rts              all done with RdBlock


* Read LSN0 into our path descriptor
RdLSN0   pshs  y          save address of path descriptor
         bsr   RdSect     go get the sector
         puls  y          restore address of path descriptor
         ldx   PD.BUF,y   get address of the path buffer
         lda   <PD.DRV,y  get drive number
         leay  DRVBEG,u   get address of beginning of drive table
         ldb   #DRVMEM
         mul              now, D = offset into table
         leay  d,y        get address of byte following drive table
         ldb   #DD.SIZ-1  get size of device descriptor


* Copy LSN0 device descriptor to drive table
LSN0Lp   lda   b,x        get byte from path buffer
         sta   b,y        store byte in drive table
         decb             move to previous entry
         bne   LSN0Lp     loop if not done


         rts              all done


* SelSlot - This routine selects the MPI slot
*
* Entry:
*    None
*
* Exit:
*    None
*
* Destroys:
*    A, B
SelSlot  lda   >MPI.Slct  get current selected slot
         sta   >ORGSlot,u save off
         lda   PD.DRV,y   get drive no.
         ldb   #$11
         mul              multiply drive no. times $11
         stb   >MPI.Slct  set new MPI slot no.
         rts              all done


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


SetStat  clrb  
         rts   


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
         ldu   BlkAdr,u   release 16384-byte block
         ldd   #$2000
         os9   F$SRtMem
         bcs   TermErr


         clrb             no errors here


TermErr  rts   


         emod  
eom      equ   *
         end   
