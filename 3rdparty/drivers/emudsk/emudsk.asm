********************************************************************
* Emudsk - Virtual disk driver for CoCo emulators
*
* $Id$
*
* Ed.    Comments                                       Who YY/MM/DD
* ------------------------------------------------------------------
*  01    Modified to compile under OS9Source            tjl 02/08/28
*  02    Modified to handle two .vhd drives        R. Gault 11/12/23
*        Conforms to MESS v1.44 or more recent
*        Added and enhanced some comments
*        Note the forced > extended addressing in some cases.
*        That is required as this code is relocatable but the
*        addresses are fixed. Part of original code.
*  03    Corrected minor errors in GetSect.        R. Gault 11/12/26
*  04    Corrected more logic errors.              R. Gault 11/12/29
*                                                & R. Gault 12/02/24

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
*   $FF86: controls .vhd drive 0=drive1 1=drive2
vhdnum   equ  $FF86
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
         use   os9.d
         use   rbf.d
         endc

tylg     set   Drivr+Objct   
atrv     set   ReEnt+rev
rev      set   $02

         mod   eom,name,tylg,atrv,start,size

         org   0
         rmb   DRVBEG+(DRVMEM*2) Normal RBF device mem for 2 drives RG
prevdr   rmb   1               previously used drive RG
         rmb   255-.             residual page RAM for stack etc. RG
size     equ   .

         fcb   $FF            This byte is the driver permissions
name     fcs   /EmuDsk/
         fcb   4               edition #4 RG

start    lbra   INIT           3 bytes per entry to keep RBF happy
         lbra   READ
         lbra   WRITE
         lbra   GETSTA
         lbra   SETSTA
         lbra   TERM

* Entry: Y=Ptr to device descriptor
*        U=Ptr to device mem
*
* Default to only one drive supported, there's really no need for more.
* Since MESS now offers second vhd drive, EmuDsk will support it. RG
INIT     ldd   #$FF02        'Invalid' value & # of drives
         stb   V.NDRV,u      Tell RBF how many drives
         leax  DRVBEG,u      Point to start of drive tables
init2    sta   DD.TOT+2,x      Set media size to bogus value $FF0000
         sta   V.TRAK,x      Init current track # to bogus value
         leax  DRVMEM,x      Move to second drive memory. RG
         decb
         bne   init2
         stb   prevdr,u      preset previous drive to 1st vhd
* for now, TERM routine goes here.  Perhaps it should be pointing to the
* park routine? ... probably not.
TERM
GETSTA   clrb                 no GetStt calls - return, no error, ignore
         rts   

* Entry: B:X = LSN
*        Y   = path dsc. ptr
*        U   = Device mem ptr
READ     clra                 READ command value=0
         bsr   GetSect        Go read the sector, exiting if there's an error
         tstb                 msb of LSN
         bne   GETSTA         if not sector 0, return
         leax  ,x             sets CC.Z bit if lsw of LSN not $0000
         bne   GETSTA         if not sector zero, return

* LSN0, standard OS-9 format
* Actually, this isn't really necessary for a HD, as the information in
* LSN0 never changes after it's read in once.  But we'll do it anyhow
         ldx   PD.BUF,y       Get ptr to sector buffer
         leau  DRVBEG,u       point to the beginning of the drive tables
         ldb   #DD.SIZ        copy bytes over
         lda   PD.DRV,y       Get vhd drive number from descriptor RG
         beq   copy.0         go if first vhd drive
         leau  DRVMEM,u       point to second drive memory
         IFNE  H6309
copy.0   clra
         tfr   d,w
         tfm   x+,u+
         ELSE
copy.0   lda   ,x+            grab from LSN0
         sta   ,u+            save into device static storage 
         decb
         bne   copy.0
         ENDC
         clrb
         rts   

WRITE    lda   #$01           WRITE command = 1

* Get Sector comes here with:
* Entry: A = read/write command code (0/1)
*        B,X = LSN to read/write
*        Y   = path dsc. ptr
*        U   = Device static storage ptr
* Exit:  A   = error status from command register
GetSect  pshs  x,d            Moved up in routine to save command code. RG
         lda   PD.DRV,y       Get drive number requested
         cmpa  #2             Only two drives allowed. RG
         bhs   DrivErr        Return error if "bad" drive#
         cmpa  prevdr,u       did the drive change? RG
         beq   gs.2           no, then don't reset the drive
         sta   >vhdnum         set to new vhd# RG
         sta   prevdr,u       update RG
gs.2     stb   >LSN           Tell MESS which LSN
         stx   >LSN+1
         ldx   PD.BUF,y       Where the 256-byte LSN should go
* Note: OS-9 allocates buffers from system memory on page boundaries, so
* the low byte of X should now be $00, ensuring that the sector is not
* falling over an 8K MMU block boundary.
* This should be the job of RBF not EmuDsk! RG

         stx   >buffer        set up the buffer address
         puls  a              recover command
         sta   >command       get the emulator to blast over the sector
         lda   >command       get the error status
         bne   FixErr         if non-zero, go report the error and exit
         puls  b,x,pc         restore registers and exit

DrivErr  leas  6,s            kill address of calling routine (Read/Write)
         comb
* FIND ERROR CODE TO USE
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

* This next is pointless for a virtual drive but probably does not hurt.
* MESS does not require this if hard drives are swapped in mid-stream. In
* real hardware, this is important as would be closing all open files. RG
park     lda   PD.DRV,y       get drive number RG
         cmpa  #2             test for illegal value RG
         bhs   format         ignore if illegal RG
         sta   >vhdnum        tell which drive to halt RG
         ldb   #$02           close the drive
         stb   >command       save in command register
         clr   >vhdnum        force the drive to first vhd drive although it may not be needed RG

format   clrb                 ignore physical formats.  They're not
         rts                  necessary

         emod

eom      equ   *
