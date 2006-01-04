********************************************************************
* Boot Common - Common code for NitrOS-9 booters
*
* $Id$
*
* This common file is not a stand-alone module, but is 'used' by boot module
* source files to bring in support for booting from RBF file systems that have
* either standard or new-style fragmented bootfiles.
*
* This code uses several static variables which are expected to be defined in
* the main boot source code.  See a booter like boot_1773.asm for an example on
* how to write a booter which uses this code.
*
* Important Notes:
* For certain devices, only the lower 16 bits of DD.BT are used.  This special
* case allows us to save some code by ignoring the loading LSN bits 23-16 in
* DD.BT and FDSL.A.  Booters for such devices (floppy, RAMPak) should have the
* following line in their code to take advantage of this optimization:
*
* LSN24BIT equ 0
*
* Floppy booters require the acquistion of DD.TKS and DD.FMT from LSN0 to make
* certain decisions about the boot process.  In most cases, non-floppy booters
* do not need these values.  Hence, floppy booters should have this line in their
* source code file:
*
* FLOPPY equ 1
*
* Edt/Rev  YYYY/MM/DD  Modified by
* Comment
* ------------------------------------------------------------------
*          2005/10/14  Boisy G. Pitre
* Created as a stand-alone file.
*
*          2005/10/16  Boisy G. Pitre
* Further optimizations made
*
*	   2006-01-04  P.Harvey-Smith.
* Added pointer to loaded LSN0 to data passed to hardware dependent section.
*
                         
start    orcc  #IntMasks  ensure IRQs are off (necessary?)
         leas  -size,s   
         tfr   s,u        get pointer to data area
         pshs  u          save pointer to data area
                         
* Request memory for LSN0
         ldd   #256       get sector/fd buffer
         os9   F$SRqMem   get it!
         bcs   error2    
         bsr   getpntr    restore U to point to our statics
                         
* Initialize Hardware
         ldy   Address,pcr				get hardware address
         lbsr  HWInit

* Read LSN0
         IFNE  LSN24BIT
         clrb             MSB sector
         ENDC
         ldx   #0         LSW sector
         lbsr  HWRead     read LSN 0
         bcs   error      branch if error
                         
         IFGT  Level-1   
         lda   #'0        --- loaded in LSN0'
         jsr   <D.BtBug   ---
         ENDC            
        
	 stx	LSN0Ptr,u	Save LSN0 pointer
* Pull relevant values from LSN0
         IFNE  FLOPPY
         lda   DD.TKS,x   number of tracks on this disk
         ldb   DD.FMT,x   disk format byte
         std   ddtks,u    TAKE NOTE!  ASSUMES ADJACENT VARS!
         ENDC
         ldd   DD.BSZ,x   os9boot size in bytes
         beq   FragBoot   if zero, do frag boot
         std   bootsize,u
* Old style boot -- make a fake FD segment right from LSN0!
         leax  DD.BT,x  
         addd  #$00FF     round up to next page
* Important note: We are making an assumption that the upper 8 bits of the
* FDSL.B field will always be zero.  That is a safe assumption, since an
* FDSL.B value of $00FF would mean the file is 65280 bytes.  A bootfile
* under NitrOS-9 cannot be this large, and therefore this assumption
* is safe.
         sta   FDSL.B+1,x save file size
         IFNE  LSN24BIT
         clr   FDSL.S,x   make next segment entry 0
         ENDC
         clr   FDSL.S+1,x
         clr   FDSL.S+2,x
         bra   GrabBootMem
                         
Back2Krn lbsr  HWTerm     call HW termination routine
         ldx   blockimg,u pointer to start of os9boot in memory
         clrb             clear carry
         ldd   bootsize,u
error2   leas  2+size,s   reset the stack    same as PULS U
         rts              return to kernel
                         
* Error point - return allocated memory and then return to kernel
error                 
* Return memory allocated for sector buffers
         pshs  cc
         ldd   #256      
         ldu   blockloc,u
         os9   F$SRtMem  
         puls  cc
         bra   error2    
                         
* Routine to save off alloced mem from F$SRqMem into blockloc,u and restore
* the statics pointer in U
getpntr  tfr   u,d        save pointer to requested memory
         ldu   2,s        recover pointer to data stack
         std   blockloc,u
         rts             
                         
* NEW! Fragmented boot support!
*FragBoot ldb   bootloc,u  MSB fd sector location
*         ldx   bootloc+1,u LSW fd sector location
FragBoot ldb   DD.BT,x    MSB fd sector location
         ldx   DD.BT+1,x  LSW fd sector location
         lbsr  HWRead     get fd sector
         ldd   FD.SIZ+2,x get file size (we skip first two bytes)
         std   bootsize,u
         leax  FD.SEG,x   point to segment table
                         
GrabBootMem                 
         IFGT  Level-1   
         os9   F$BtMem   
         ELSE            
         os9   F$SRqMem  
         ENDC            
         bcs   error     
         bsr   getpntr   
         std   blockimg,u
                         
* Get os9boot into memory
BootLoop stx   seglist,u  update segment list
         IFNE  LSN24BIT
         ldb   FDSL.A,x   MSB sector location
         ENDC
BL2      ldx   FDSL.A+1,x LSW sector location
         IFNE  LSN24BIT
         bne   BL3       
         tstb            
         ENDC
         beq   Back2Krn  
BL3      lbsr  HWRead    
         inc   blockloc,u point to next input sector in mem
                         
         IFGT  Level-1   
         lda   #'.        show .'
         jsr   <D.BtBug  
         ENDC            
                         
         ldx   seglist,u  get pointer to segment list
         dec   FDSL.B+1,x get segment size
         beq   NextSeg    if <=0, get next segment
                         
         ldd   FDSL.A+1,x update sector location by one
         addd  #1        
         std   FDSL.A+1,x
         IFNE  LSN24BIT
         ldb   FDSL.A,x  
         adcb  #0        
         stb   FDSL.A,x  
         ENDC
         bra   BL2       
                         
NextSeg  leax  FDSL.S,x   advance to next segment entry
         bra   BootLoop  
