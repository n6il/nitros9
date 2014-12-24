********************************************************************
* Boot - CoCo SDC Boot module
*
* $Id$
*
* Edt/Rev  YYYY/MM/DD  Modified by
* Comment
* ------------------------------------------------------------------
*          2014/12/22  Darren Atkinson
* Created.

               nam   Boot
               ttl   SDC Boot module

               IFP1
                use  defsfile
               ENDC

* Default Boot is from drive 0
BootDr  set    0

* Alternate Boot is from drive 1
   IFEQ        DNum-1
BootDr  set    1
   ENDC

* Common booter-required defines
LSN24BIT       equ       1
FLOPPY         equ       0

* DPort offsets
CONTROL        equ       0                  write-only
CMDREG         equ       8+0                write-only
STATREG        equ       CMDREG             read-only
LSNREG         equ       8+1
DATAREG        equ       8+2

* NOTE: these are U-stack offsets, not DP
seglist        rmb       2                  pointer to segment list
blockloc       rmb       2                  pointer to memory requested
blockimg       rmb       2                  duplicate of the above
bootsize       rmb       2                  size in bytes
LSN0Ptr        rmb       2                  In memory LSN0 pointer
size           equ       .


tylg           set       Systm+Objct
atrv           set       ReEnt+rev
rev            set       $00
edition        set       1

               mod  eom,name,tylg,atrv,start,size

name           fcs       /Boot/
               fcb       edition


*--------------------------------------------------------------------------
* HWInit - Initialize the device
*
*    Entry:
*       Y  = hardware address
*
*    Exit:
*       Carry Clear = OK, Set = Error
*       B  = error (Carry Set)
*
HWInit         orcc      #$50               mask interrupts
               lda       #$D0               stop any emulated FDC command
               sta       CMDREG,y
               pshs      d,x,y,u            delay
               puls      d,x,y,u
               lda       STATREG,y          clear INTRQ

               *** Fall Thru ***

*--------------------------------------------------------------------------
* HWTerm - Terminate the device
*
*    Entry:
*       Y  = hardware address
*
*    Exit:
*       Carry Clear = OK, Set = Error
*       B = error (Carry Set)
*
HWTerm         clrb                         no error
               stb       CONTROL,y          disable command mode
               rts


***************************************************************************
     use  boot_common.asm
***************************************************************************

*
* HWRead - Read a 256 byte sector from the device
*
*    Entry:
*       Y  = hardware address
*       B  = bits 23-16 of LSN
*       X  = bits 15-0  of LSN
*       blockloc,u = where to load the 256 byte sector
*
*    Exit:
*       X  = ptr to data (i.e. ptr in blockloc,u)
*
HWRead         lda       #$43               start command mode
               sta       CONTROL,y
               stb       LSNREG,y           put LSN into registers
               stx       LSNREG+1,y
               clra                         A=0 for use at rdExit
               bsr       waitSDC            wait for BUSY to be cleared
               bcs       rdExit             exit on error or timeout
               ldb       WhichDrv,pcr       get drive number
               andb      #1                 limit to 0 or 1
               orb       #$80               combine with Read Sector command
               stb       CMDREG,y           send command to controller
               bsr       waitSDC            wait for data READY
               bcs       rdExit             exit on error or timeout
               ldx       blockloc,u         get address of buffer to fill
               pshs      u,x                preserve U and X
               ldb       #256/2             1/2 sector size
rdLoop         ldu       DATAREG,y          read word data from controller
               stu       ,x++               store to buffer
               decb                         decrement word counter
               bne       rdLoop             loop until done
               puls      x,u                restore X and U
rdExit         sta       CONTROL,y          end command mode
               rts


*--------------------------------------------------------------------------
* Wait for controller status to indicate either "Not Busy" or "Ready".
* Will time out if neither condition satisfied within a suitable period.
*
* Exit:
*    CC.C set on error or time out
*
waitSDC        ldx       #0                 setup timeout counter
waitLp         bsr       waitRet            extra cycles for timeout
               comb                         set carry for timeout/FAILED
               leax      ,-x                decrement timeout counter
               beq       waitRet            return if timed out
               ldb       STATREG,y          read status
               bmi       waitRet            return if FAILED
               lsrb                         BUSY --> Carry
               bcc       waitRet            return if not busy
               rolb                         clear carry
               bitb      #2                 test READY
               beq       waitLp             loop if not ready for transfer
waitRet        rts                          return


*--------------------------------------------------------------------------

     IFGT Level-1
* Filler to get $1D0
Filler         fill      $39,$1D0-3-2-1-*
     ENDC

Address        fdb       DPort
WhichDrv       fcb       BootDr

               emod
eom            equ       *
               end
