********************************************************************
* Cobbler - Boot generation utility
*
* $Id$
*
* Ed.    Comments                                       Who YY/MM/DD
* ------------------------------------------------------------------
* 7      Reworked                                       AD
* 8      Fixed error where $40+C$CR should have been    BGP 98/10/20
*        $40*256+C$CR

         nam   Cobbler
         ttl   Boot generation utility

* Disassembled 94/10/23 11:19:48 by Alan DeKok

* WARNING: This is a LEVEL II Cobbler only!

         ifp1
         use   os9defs
         use   scfdefs
         use   rbfdefs
         endc

tylg     set   Prgrm+Objct   
atrv     set   ReEnt+rev
rev      set   $01
edition  set   8

         mod   eom,name,tylg,atrv,start,size
u0000    rmb   3
u0003    rmb   1
u0004    rmb   12
u0010    rmb   5

u0015    rmb   1
u0016    rmb   2
u0018    rmb   2
* Everything before here is the DD.foo equivalent
PathO    rmb   1          path output to OS9boot file
Path     rmb   3          path to /DEVICE@
KernelF  rmb   1          0=write kernel track, 1= don't
BootF    rmb   1          0=write boot track, 1=don't
FileNm   rmb   20         /DEVICE/OS9Boot memory
         rmb   16
SysDAT   rmb   16         copy of the system DAT image
FileDesc rmb   $20        room for first bit of file descriptor
AllMap   rmb   1024       allocation map is entirely too large...
Buffer   rmb   $2000      only copy 8k at a time
         rmb   200        room for the stack
size     equ   .

name     fcs   /Cobbler/
         fcb   edition    my version of cobbler

L0015    fdb   $0000      minimal DAT image for checking out the system.

OS9Boot  fcs   '/OS9Boot'
Rel      fcc   /Rel/

start    clr   <KernelF   force a write of the kernel track
         clr   <BootF     force a write of the boot track
skip     ldd   ,x+
         cmpa  #C$SPAC    space?
         beq   skip
         cmpa  #'-        hyphen?
         bne   s.001

         andb  #$DF       make it uppercase
         cmpb  #'K        force no write of kernel track?
         bne   check.b    no, check for the boot track stuff
         stb   <KernelF   save the kernel flag
         bra   s.000

check.b  cmpb  #'B        don't write boot?
         bne   go.help    no, print out help message
         stb   <BootF     save the boot flag

s.000    leax  1,x        skip the character
         lda   ,x++       get the next character, and point to the next one
         cmpa  #$20       space?
         bne   go.help    no, print out a help message

s.001    leax  -1,x
         lda   #'/
         cmpa  ,x         is the first character a slash?
Go.help  lbne  Help       not a device name, error out
         os9   F$PrsNam   parse the name
         lbcs  Exit       exit on error
         lda   #'/        is the next character a slash?
         cmpa  ,y         check it
         lbeq  Help       yes, dump out a help message
         ldy   #FileNm    point to the filename buffer
L013C    sta   ,y+        make first character a slash
         lda   ,x+        copy the name over
         decb  
         bpl   L013C
         ldd   #$40*256+C$CR  '@+CR'
         std   ,y         save in the buffer
         ldx   #FileNm    point to the filename again
         lda   #UPDAT.
         os9   I$Open     open /DEVICE@
         sta   <Path      save the path to the file
         lbcs  Exit       dump out help on an error
         leax  ,y         point to end of '/DEVICE' name
         leay  >OS9Boot,pcr point to the OS9Boot name
L0162    lda   ,y+        get a byte from the name
         sta   ,x+        save in my buffer
         bpl   L0162      copy it over

         leax  ,u         both are zero in a level II system
         lda   <Path
         os9   I$Seek     seek to LSN0
         lbcs  Exit       dump out error if encountered

* X is implicitely zero from the call above
         ldy   #DD.BSZ+2  read everything up to the boot size
         lda   <Path
         os9   I$Read     get it
         lbcs  Exit

         tst   <BootF     replace OS9Boot?
         lbne  no.boot    no, go write the kernel track

         ldd   <DD.BSZ    get the boot size
         lbeq  L019F      if non-existent, don't delete it
         ldx   #FileNm    point to /DEVICE/OS9boot
         os9   I$Delete   delete it, if it exists
         clra  
         clrb  
         sta   <DD.BT     NO OS9boot file on this disk
         std   <DD.BT+1
         std   <DD.BSZ
         lbsr  L045A      dump out LSN0 information again

L019F    ldd   #(UPDAT.*256)+UPDAT.
         ldx   #FileNm    create a /DEVICE/OS9Boot file
         os9   I$Create 
         lbcs  Exit
         sta   <PathO

         leax  >L0015,pcr temporary DAT image
         tfr   x,d
         ldx   #$0000     get copy of direct page
         ldy   #$0090     first $90 bytes
         ldu   #Buffer    to a buffer
         os9   F$CpyMem   copy memory
         lbcs  Exit

         leax  >L0015,pcr
         tfr   x,d        use it as temporary DAT image
         ldx   >Buffer+D.SysDAT get pointer to system DAT image
         ldy   #$0010     get a copy of it
         ldu   #SysDAT    point to room for the system DAT image
         os9   F$CpyMem   get the system DAT image
         lbcs  Exit
         ldx   #Buffer
         ldd   <D.BtPtr,x address of boot in system memory
         pshs  d          save a copy of it
         ldd   <D.BtSz,x  size of the OS9Boot file in system memory
         std   <DD.BSZ    save in the boot size info for LSN0
         pshs  d          save the size
L01F7    ldy   #$2000     only do 8k at a time
         cmpy  ,s         default to one block???
         bls   L0203
         ldy   ,s         get the actual boot size
L0203    pshs  y          save a copy of it
         ldx   #SysDAT    get dat image
         tfr   x,d        save it
         ldx   $04,s      get start of boot in memory
         ldu   #Buffer
         os9   F$CpyMem   copy one block at a time
         lbcs  Exit
         ldy   ,s         get how much we're copying
         ldx   #Buffer    point to the buffer
         lda   <PathO     dump it to /DEVICE/OS9Boot file
         os9   I$Write 
         lbcs  Exit
         puls  d          get size of what we're copying
         ldy   $02,s      get start address of boot file in system memory
         leay  d,y        go to the next group of data
         sty   $02,s      save new start a address
         nega  
         negb  
         sbca  #$00
         ldy   ,s         get size of boot file left
         leay  d,y        take out what we've done
         sty   ,s         save it
         bne   L01F7      if not done, continue
         leas  $04,s      remove start,size from the stack

         lda   <PathO     path to OS9Boot
         ldb   #SS.FD     get FD information
         ldx   #FileDesc  read the file descriptor sector
         ldy   #$0020     only get the first 32 bytes of it
         os9   I$GetStt
         lbcs  Exit

         os9   I$Close    close the path
         lbcs  Exit

         ldd   <FD.SEG+3+2+3,x get size of SECOND segment in file
         lbne  L0488      if not zero, the file is fragmented
         ldb   <FD.SEG,x  get first byte of address
         stb   <DD.BT     save starting sector of the bootstrap file
         ldd   <FD.SEG+1,x
         std   <DD.BT+1   save the rest of the LSN#
         lbsr  L045A      seek to LSN0 and dump out this information, too

         lda   <KernelF   do we do a kernel track?
         bne   ClnExit    no, don't even check for floppy stuff

         lda   <DD.FMT    is it a HD? (Bit 7 set)
         bpl   Floppy     if bit 7 is clear, go do track 34 stuff.

ClnExit  clrb             no error
Exit1    OS9   F$Exit     and exit

no.boot  lda   <DD.FMT    is it a HD? (bit 7 set)
         bpl   Floppy     if OK, go write it
         coma             set carry
         ldb   #E$BTyp    bad media type
         bra   Exit1

Floppy   ldd   #$0001     track 0, sector 1: LSN 1
         lbsr  L0440      seek to it

         ldx   #AllMap    point to the allocation map buffer
         ldy   <DD.MAP    get the size of the map
         lda   <Path
         os9   I$Read     read in the allocation map
         bcs   Exit1

         ldd   <DD.MAP    get number of bytes in the map
         leau  d,x        point to the END of the map
         ldd   #$2200     track 34, sector 0
         lbsr  Tk2LSN     get LSN of this in D
         pshs  d          save it for later
         ldy   #0018      force the boot track to be 18 sectors long
         OS9   F$SchBit   search for 18 free sectors at D,X: ending at U
         cmpd  ,s++       did we find bits at the starting bit number?
         bne   Check      no, check for REL on the disk
         cmpy  #0018      if found at the right spot, did we find 18 bits?
         beq   AllClr     if so, go allocate them

Check    ldd   #$2200     track 34, sector 0
         lbsr  L0440      seek to it

         ldx   #Buffer
         ldy   #$0100     read one sector
         lda   <Path
         os9   I$Read     get the first sector of the boot track
         lbcs  Exit

         ldd   ,x++       get the first 2 bytes
         cmpd  #$4F53     is it 'OS'?
         lbne  L0496      files present on track 34, give error
         ldd   ,x++
         cmpa  #$20       is it a BRA?
         lbne  L0496
         ldd   ,x         get some bytes from the sector
         cmpd  #M$ID12    is it a module header?
         beq   map.blk    yes, go write out the kernel track
         leax  2,x        skip the $1205 sync bytes
         ldd   ,x         grab the header
         cmpd  #M$ID12    is there a module here?
         lbne  L0496      no, error out
         bra   map.blk    don't allocate track 34, REL already exists on it

* We've found 18 bytes at D,X in the allocation bit map
* D,X,Y are set up from above
AllClr   OS9   F$AllBit   allocate the bits in the bitmap

* possible problems here, as the r/w of the allocation bitmap is NOT atomic.
* some other process may come along and grab the sectors we want.
L0315    ldd   #$0001     track 0, sector 1
         bsr   L0440      seek to it
         ldx   #AllMap
         ldy   <DD.MAP
         lda   <Path
         os9   I$Write    dump out the allocation map again
         lbcs  Exit

* Do a F$Link to REL?
map.blk  ldx   #$003F     the boot track is in block 63
         ldb   #1         one block
         OS9   F$MapBlk   map the block in
         lbcs  L049D      error finding boot track in memory

         ldd   #$2200     track 34, sector 0
         bsr   L0440      seek to it
         lda   <Path
         leax  $0D00,u    the boot track starts out at $ED00
         ldy   #$1200     dump out 18 sectors
         os9   I$Write    dump out REL, Boot, OS9p1
         pshs  cc,b
         ldb   #1
         OS9   F$ClrBlk   un-map block $3F
         puls  cc,b       restore possible error code
         bcs   L048F      if there was an error, print it out and exit
         os9   I$Close    close the path
         clrb             no erros
         bra   Exit

******************************
* Convert track,sector to LSN
*
* Entry: A = track number
*        B = sector number
* Exit : D = LSN# of that sector
Tk2LSN   pshs  b
         ldb   <DD.FMT
         andb  #$01
         beq   L037F
         ldb   #$02       disk is 2-sided
         bra   L0381

L037F    ldb   #$01       disk is 1-sided
L0381    mul              multiply sides by tracks
         lda   <DD.TKS    track size in sectors
         mul              get LSN of the track
         addb  ,s         add in the sector
         adca  #$00       make it 16-bit
         leas  $01,s      dumb dumb dumb people...
         rts

L0440    pshs  u,y,x,d
         bsr   Tk2LSN     convert track,sector to LSN
         pshs  a
         tfr   b,a
         clrb             shuffle so 16-bit LSN goes to
         tfr   d,u        32-bit address, with the lower
         puls  b          16 bits all zero
         clra  
         tfr   d,x
         lda   <Path
         os9   I$Seek     seek to it
         bcs   L048F
         puls  pc,u,y,x,d

L045A    clra  
         clrb  
         tfr   d,x
         tfr   d,u        go to LSN0

         lda   <Path
         os9   I$Seek     seek to LSN0

         ldy   #DD.DAT    X=$0000 already...
         lda   <Path
         os9   I$Write    dump it out
         bcs   Exit
         rts   

Help     leax  <HelpMsg,pcr
         clrb

Print    pshs  b,cc
         lda   #$02
         ldy   #$0200
         os9   I$WritLn 
         comb  
         puls  b,cc

Exit     os9   F$Exit   

L0488    leax  >L00D1,pcr
         clrb  
         bra   Print

L048F    leax  >L0051,pcr
         clrb  
         bra   Print

L0496    leax  >L008E,pcr
         clrb  
         bra   Print

L049D    leax  >L00F2,pcr
         bra   Print

HelpMsg  fcb   C$LF
         fcc   'Use: COBBLER [-k] [-b] </devname>'
         fcb   C$LF
         fcc   /     to create a new system disk by writing an OS9Boot file/
         fcb   C$LF
         fcc   /     and a boot (kernel) track to the specified drive./
         fcb   C$LF,C$LF
         fcc   /  -k = don't write the kernel track/
         fcb   C$LF
         fcc   /       Hard disk drives never have the kernel track written./
         fcb   C$LF
         fcc   /  -b = don't write the OS9Boot file/
         fcb   C$CR

L0051    fcb   C$LF
         fcc   /Error writing kernel track or LSN0./
         fcb   C$CR 

L008E    fcb   C$LF
         fcc   /Warning - file(s) present on track 34/
         fcb   C$LF
         fcc   /        - this track not rewritten./
         fcb   C$CR

L00D1    fcb   C$LF
         fcc   /Error - OS9boot file fragmented/
         fcb   C$CR

L00F2    fcb   C$LF
         fcc   /Error - can't find boot track in memory/
         fcb   C$CR

         emod
eom      equ   *
         end
