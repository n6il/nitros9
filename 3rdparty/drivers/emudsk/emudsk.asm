********************************************************************
* Emudsk - Virtual disk driver for CoCo emulators
*
* $Id$
*
* Ed.    Comments                                       Who YY/MM/DD
* ------------------------------------------------------------------
*  01    Modified to compile under OS9Source            tjl 02/08/28

* EmuDisk floppy disk controller driver
* Edition #1
* 04/18/96 : Written from scratch by Alan DeKok
*                                 aland@sandelman.ocunix.on.ca
*
*  This program is Copyright (C) 1996 by Alan DeKok,
*                  All Rights Reserved.
*  License is given to individuals for personal use only.
*
*
*  Comments: Ensure that device descriptors mark it as a hard drive
*
*
*   $FF80-$FF82: logical record number
LSN      equ  $FF80           where to put the logical sector number

*
*   $FF83: command/status register.
*          Output: 0=read, 1=write, 2=close.  
*          Input: 0=no error, non-zero=error codes (see below).
command  equ  $FF83           where to put the commands

*
*   $FF84-$FF85: 6809's 16-bit buffer address (cannot cross an 8K boundary due
*          to interference from the MMU emulation).
buffer   equ  $FF84           pointer to the buffer

*
* Returns:
*
* 0=successful
* 2=not enabled
* 4=too many MS-DOS files open,
* 5=access denied (virtual HD file locked by another program
*      or MS-DOS read-only status)
* 6/12=internal error
* 254=invalid command byte
* 255=power-on state or closed.
*
*  The "close" command just flushes all the read/write buffers and
* restores the metacontroller to its power-up state.  The hard drive must be
* enabled by the user using the MS-DOS command "ECHO >COCO3.VHD" (another
* crash safeguard), so error code 2 indicates this has not been done.
  

         nam   EmuDsk
         ttl   os9 device driver    

         ifp1
         use   os9defs
         use   rbfdefs
         endc

tylg     set   Drivr+Objct   
atrv     set   ReEnt+rev
rev      set   $01

         mod   eom,name,tylg,atrv,start,size
         fcb   $ff

         org   0
u0000    rmb   $FF            Normal RBF device mem for 4 drives
size     equ   .

         fcb   $FF            This byte is the driver permissions
name     fcs   /EmuDsk/
         fcb   1              edition #1


* Entry: Y=Ptr to device descriptor
*        U=Ptr to device mem
*
* Default to only one drive supported, there's really no need for more.
INIT     lda   #$FF          'Invalid' value & # of drives
         leax  DRVBEG,u       Point to start of drive tables
         sta   ,x             DD.TOT MSB to bogus value
         sta   <V.TRAK,x      Init current track # to bogus value

* for now, TERM routine goes here.  Perhaps it should be pointing to the
* park routine? ... probably not.
TERM
GETSTA   clrb                 no GetStt calls - return, no error, ignore
L0086    rts   

start    lbra   INIT           3 bytes per entry to keep RBF happy
         lbra   READ
         lbra   WRITE
         lbra   GETSTA
         lbra   SETSTA
         lbra   TERM

* Entry: B:X = LSN
*        Y   = path dsc. ptr
*        U   = Device mem ptr
READ     clra                 READ the sector
         bsr   GetSect        Go read the sector, exiting if there's an error
         tstb
         bne   GETSTA         if not sector 0, return
         leax  ,x             sets CC.Z bit
         bne   GETSTA         if not sector zero, return

* LSN0, standard OS-9 format
* Actually, this isn't really necessary for a HD, as the information in
* LSN0 never changes after it's read in once.  But we'll do it anyhow
         ldx   PD.BUF,y       Get ptr to sector buffer
         leau  DRVBEG,u       point to the beginning of the drive tables
         ldb   #DD.SIZ        copy bytes over
copy.0   lda   ,x+            grab from LSN0
         sta   ,u+            save into device static storage 
         decb
         bne   copy.0
         clrb
         rts   

WRITE    lda   #$01           WRITE to emulator disk, and fall thru to GetSect

* Get Sector comes here with:
* Entry: A = read/write command code (0/1)
*        B,X = LSN to read/write
*        Y   = path dsc. ptr
*        U   = Device static storage ptr
* Exit:  A   = error status from command register
GetSect  tst   <PD.DRV,y      get drive number requested
         bne   DrivErr        only one drive allowed, return error

         pshs  x,b            save LSN for later
         stb   >LSN
         stx   >LSN+1

         ldx   PD.BUF,y       where the 256-byte LSN should go
* Note: OS-9 allocates buffers from system memory on page boundaries, so
* the low byte of X should now be $00, ensuring that the sector is not
* falling over an 8K MMU block boundary.

         stx   >buffer        set up the buffer address
         sta   >command       get the emulator to blast over the sector
         lda   >command       restore the error status
         bne   FixErr         if non-zero, go fix the error and exit
         puls  b,x,pc         restore LSN and exit

DrivErr  leas  2,s            kill address of calling routine (Read/Write)
         comb
* FIND ERROR CODE TO USE
*        ldb   #E$            find appropriate error code...
         ldb   #E$NotRdy      not ready
         rts

* Emulator error codes translated to OS-9 error codes.
*
* 2=not enabled
*      E$NotRDy - drive is not ready
*
* 4=too many MS-DOS files open,
*      E$
*
* 5=access denied (virtual HD file locked by another program
*      or MS-DOS read-only status)
*      E$WP  - write protect
*
* 6/12=internal error
*      E$CRC - CRC error
*
* 254=invalid command byte
*      E$
*
* 255=power-on state or closed.
*      E$NotRdy - drive is not ready
*
FixErr   leas  5,s         kill B,X,PC from GetSect routine
         cmpa  #02
         beq   NotRdy
         cmpa  #255
         beq   NotRdy
         cmpa  #5
         beq   WP
         cmpa  #6
         beq   CRC
         cmpa  #12
         beq   CRC

* if it's something we don't recognize, it's a seek error
         comb
         ldb   #E$Seek        seek error
         rts   

NotRdy   comb  
         ldb   #E$NotRdy      not ready
         rts   

WP       comb  
         ldb   #E$WP          write protect
         rts   

CRC      comb  
         ldb   #E$CRC         CRC error
         rts   

L03D4    comb  
         ldb   #E$Write       write error
         rts   


L03E0    comb  
         ldb   #E$Read        Read error
         rts   

SETSTA   ldx   PD.RGS,y       Get caller's register stack ptr
         ldb   R$B,x          Get function code
         cmpb  #SS.WTrk       Write track?
         beq   format         Yes, ignore it
         cmpb  #SS.Reset      Restore head to track 0?
         beq   format         Yes, ignore it
         cmpb  #SS.SQD        sequence down the drive (i.e. park it)?
         beq   park
         comb                 set carry for error
         ldb   #E$UnkSvc      return illegal service request error
         rts   

park     ldb   #$02           close the drive
         stb   >command       save in command register

format   clrb                 ignore physical formats.  They're not
         rts                  necessary

         emod

eom      equ   *
