********************************************************************
* Boot - DriveWire 3 Boot Module
*
* $Id$
*
* Edt/Rev  YYYY/MM/DD  Modified by
* Comment
* ------------------------------------------------------------------
*   1      2008/02/09  Boisy G. Pitre
* Created.

               NAM       Boot
               TTL       DriveWire Boot Module

               IFP1      
               USE       defsfile
               USE       drivewire.d
               ENDC      

tylg           SET       Systm+Objct
atrv           SET       ReEnt+rev
rev            SET       0
edition        SET       1

               MOD       eom,name,tylg,atrv,start,size

* on-stack buffer to use
               ORG       0
seglist        RMB       2                   pointer to segment list
blockloc       RMB       2                   pointer to memory requested
blockimg       RMB       2                   duplicate of the above
bootloc        RMB       3                   sector pointer; not byte pointer
bootsize       RMB       2                   size in bytes
LSN0Ptr        RMB       2                   LSN0 pointer
size           EQU       .

name           EQU       *
               FCS       /Boot/
               FCB       edition


* Common booter-required defines
LSN24BIT       EQU       1
FLOPPY         EQU       0


               USE       boot_common.asm


************************************************************
************************************************************
*              Hardware-Specific Booter Area               *
************************************************************
************************************************************                   

* HWInit - Initialize the device
*   Entry: Y = hardware address
*   Exit:  Carry Clear = OK, Set = Error
*          B = error (Carry Set)
HWInit                   
* Set up DDR for side B
*               ldx       #PIA1Base           get base address of PIA
*               ldb       3,x
*               andb      #%11111011
*               stb       3,x
*               lda       #%11111010
*               sta       2,x
*               orb       #%00000100
*               stb       3,x

* Set up DDR for side A
*               ldb       1,x
*               andb      #%11111011
*               stb       1,x                 $FF20 is now Data Direction Register
*               lda       #%11111110          data direction bits (1=out, 0=in)
*               sta       ,x                  tell HW
*               orb       #%00000100          reset $FF20 to I/O register
*               stb       1,x                 $FF20 is now Data Direction Register
HWTerm         clrb      
               rts       


* HWRead - Read a 256 byte sector from the device
*   Entry: Y = hardware address
*          B = bits 23-16 of LSN
*          X = bits 15-0  of LSN
* 		   blockloc,u = ptr to 256 byte sector
*   Exit:  X = ptr to data (i.e. ptr in blockloc,u)
HWRead         
               pshs      cc,d,x
* Send out op code and 3 byte LSN
               lda       #OP_READEX           load A with READ opcode
Read2          ldb       WhichDrv,pcr
               std       ,s
               leax      ,s
               ldy       #5
               lbsr      DWWrite              send it to server
* Get 256 bytes of sector data
               ldx       blockloc,u
               ldy       #256
               bsr       DWRead               read bytes from server
               bcs       ReadEr               branch if framing error
               bne       ReadEr2
               
* Send two byte checksum
               pshs      y
	 		      leax      ,s
			      ldy       #2
			      lbsr      DWWrite 
                              ldy       #1
			      bsr       DWRead 
			      leas      2,s
     			   bcs       ReadEx
                           bne      ReadEr2
			      ldb       ,s
			      beq       ReadEx
			      cmpb      #E_CRC
			      bne       ReadEr
               lda       #OP_REREADEX
               bra       Read2
ReadEx         EQU       *
               leas      5,s                 eat stack
               ldx       blockloc,u
               clrb      
               rts
ReadEr2        ldb       #E$Read
ReadEr
               leas      5,s                 eat stack
               orcc      #Carry
               rts

               USE       dwread.asm
               USE       dwwrite.asm

               IFGT      Level-1
Pad            FILL      $39,$1D0-3-2-1-*
               ENDC      

Address        FDB       $0000
WhichDrv       FCB       $00
               EMOD      
eom            EQU       *
               END       
