********************************************************************
* CCIDE - IDE device driver for CoCo
*
* $Id$
*
*  Driver originally from Jim Hathaway, originally 8-bit only
*  Converted to 16 bit by Alan DeKok
*  Disassembled (OK, so I didn't have the source version at first!)
*     by Eddie Kuns, ATA specs followed carefully and sector buffering
*     on writes handled more carefully
*
*  This driver uses 16-bit transfers *only*
*
* Ed.    Comments                                       Who YY/MM/DD
* ------------------------------------------------------------------
* 5      Source as distributed by Glenside                  99/05/02
*        Added comments from 8 bit driver               BGP 99/05/07
* 6      Driver now gets address from descriptor, made  BGP 99/05/10
*        minor optimizations, added symbols

* Maximum number of drives to support
NUMDRIVE equ   4

         nam   CCIDE
         ttl   IDE device driver for CoCo

         ifp1
         use   defsfile
         use   rbfdefs
         endc

tylg     set   Drivr+Objct   
atrv     set   ReEnt+rev
rev      set   $01
edition  equ   6

         mod   eom,name,tylg,atrv,start,size

         org   0
         rmb   DRVBEG+(DRVMEM*NUMDRIVE)
* Start of driver-specific statics
OS9LSN   rmb   3           LSN of current OS-9 256-byte sector
Counter  rmb   1
idecmd   rmb   1           1 byte IDE command code
         rmb   20
size     equ   .

         fcb   $FF         mode byte

name     fcs   /CCIDE/     module name
         fcb   edition     module edition

start    lbra  Init
         lbra  FRead
         lbra  FWrite
         lbra  GetStat
         lbra  SetStat
         lbra  Term
*
* INIT
*
* Y = address of path descriptor
* U = address of device memory (ie, of V.PAGE)
*
Init     ldx   #$1500        delay loop value
         ldy   V.PORT,u
RdyIni1  tst   7,y           Wait for drive ready
         bpl   GoInit
         leax  -1,x
         bne   RdyIni1
         lbeq  ENotRdy       Timed out ... give up on drive

GoInit   ldd   #$AF20        Drive is ready -- initialize
* For IDE command $91, DrvHd reg = 101xhhhh binary
         sta   6,y           $10 heads       (x=0-master/1-slave; hhhh=#heads)
         stb   2,y           $20 sectors/track
         lda   #$91 
         sta   7,y           Give drive the Init Drive Parameters IDE command
RdyIni2  tst   7,y
         bmi   RdyIni2       Wait *forever* until drive is ready

* Initialize drive table (only first is inited here)
         leax  DRVBEG,u
         lda   #1
         sta   V.NDRV,u
         lda   #$FF
         sta   DD.TOT+2,x
         sta   V.TRAK,x

GetStat
SetStat
Term     clrb
         rts

SavLSN   stb   OS9LSN,u     Save OS-9 LSN
         stx   OS9LSN+1,u
         rts   
*
* READ
*
* Y = address of path descriptor
* U = address of device memory (ie, of V.PAGE)
* B = MSB of OS-9 disk LSN
* X = LSB of OS-9 disk LSN
*
FRead    bsr   SavLSN
         ldb   #$20
         lbsr  SetIDE
         bcs   Ret
         ldx   PD.BUF,y
         lda   #$20
         sta   Counter,u
         pshs  y
         ldy   V.PORT,u
ReadLp   lda   ,y
         ldb   ,y
         std   ,x++
         lda   ,y
         ldb   ,y
         std   ,x++
         lda   ,y
         ldb   ,y
         std   ,x++
         lda   ,y
         ldb   ,y
         std   ,x++
         dec   Counter,u
         bne   ReadLp
         puls  y

         ldx   OS9LSN+1,u     Is this LSN 0?
         bne   NotLSN0
         ldb   OS9LSN,u
         bne   NotLSN0
         ldx   PD.BUF,y

         pshs  y            Yes, it is LSN 0
         lda   #DD.SIZ      Copy useful information to our LSN 0 buffer
         leay  DRVBEG,u
LSN0Cp   ldb   ,x+
         stb   ,y+
         deca  
         bne   LSN0Cp
         puls  y            Done with LSN 0 stuff

NotLSN0  bsr   WaitOK       Wait for drive to complete command
         bcc   Ret 
         lbra  ReadErr
Ret      rts

*
* WRITE
*
* Y = address of path descriptor
* U = address of device memory (ie, of V.PAGE)
* B = MSB of OS-9 disk LSN
* X = LSB of OS-9 disk LSN
*
FWrite   lbsr  SavLSN       Save LSN info
*
*  *** HACK *** Read the 2 sectors into our buffer first
*
         ldb   #$30         IDE Read w/ Retry command
         lbsr  SetIDE       Setup IDE command registers
         bcs   ReadDone
         pshs  y
         ldx   PD.BUF,y
         lda   #$20
         sta   Counter,u
         ldy   V.PORT,u
HackLp   ldd   ,x++
         sta   ,y
         stb   ,y
         ldd   ,x++
         sta   ,y
         stb   ,y
         ldd   ,x++
         sta   ,y
         stb   ,y
         ldd   ,x++
         sta   ,y
         stb   ,y
         dec   Counter,u
         bne   HackLp
         puls  y
         bsr   WaitOK       Wait for drive to finish command
         bcc   ReadDone      
         lbsr  WriteErr
ReadDone rts
*
* After read or write, check drive status
*   Return value = CC, true=error, false=OK
*
WaitOK   ldy   V.PORT,u     Is DRQ still true?  Just one check necessary
         tst   7,y         If it is, sector isn't fully transferred
         bmi   WaitOK      
         lda   #$01        Wait *forever* for drive ready
         bita  7,y
         bne   CmdErr
         clrb              Nope -- clear CC
         rts   
CmdErr   comb              Yep  -- set CC
         rts   

*
* Setup IDE read or write operation
*
* B  = IDE command code
*
* trashes D and X
*
SetIDE   stb   idecmd,u
         pshs  y
         ldx   #$A000
CmdLp1   ldy   V.PORT,u
         tst   7,y
         bpl   SetRdy       Should go to ChkDRDY ?????
         leax  -1,x
         bne   CmdLp1
         puls  y
         bra   ENotRdy

SetRdy   ldy   V.PORT,u      Drive is ready -- calculate HCS from LSN
         lda   OS9LSN+2,u  Sector first
         anda  #$1F
         adda  #$01
         sta   3,y          Store calculated sector number
         ldd   OS9LSN+1,u  Drive number next
         rolb  
         rola  
         rolb  
         rola  
         rolb  
         rola  
         anda  #$0F
         ora   #$A0
         sta   6,y          Store calculated drive number
         ldd   OS9LSN,u    Last, the cylinder number (2-bytes)
         rora  
         rorb  
         anda  #$7F
         sta   5,y          Store calculated CylHi
         stb   4,y          Store calculated CylLo
         lda   #$01
         sta   2,y          Sector count = 1
         ldb   idecmd,u
         stb   7,y          Lastly, push the command to the drive
         ldb   #$40
         lda   #$08         Wait for Drive ready
CmdLp2   bita  7,y
         bne   CmdDone
         decb  
         bne   CmdLp2
         ldx   #$0001       If we time out, sleep 1 tick, then loop *forever*
         os9   F$Sleep
CmdLp3   bita  7,y
         beq   CmdLp3
CmdDone  puls  y
         clrb               All right, drive ready -- return
         rts   

ENotRdy  comb
         ldb   #E$NotRdy
         rts
WriteErr comb
         ldb   #E$Write
         rts
ReadErr  comb
         ldb   #E$Read
         rts

         emod
eom      equ   *
         end
