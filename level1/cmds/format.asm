********************************************************************
* Format - Disk format program
*
* $Id$
*
* Edt/Rev  YYYY/MM/DD  Modified by
* Comment
* ------------------------------------------------------------------
*  22      ????/??/??
* From Tandy OS-9 Level Two VR 02.00.01.
*
*  23      2003/01/06  JC
* Format incorrect/clusters summary: now, specifying cluster size works.
* Fixed bug where format showed an improper number of sectors formatted
* at the summary if the number of sectors was a large number.
* This was most notable when formatting large disks, such as hard drives.
*
*  24      2004/07/20  Boisy G. pitre
* Revamped to display summary similar to OS-9/68K. Also, format now
* checks the TYPH.DSQ bit in order to query the drive for its size.
* Also, if a cluster size is not specified on the command line,
* the best one is automatically calculated.

         nam   Format
         ttl   Disk format program

* Disassembled 02/07/17 11:00:13 by Disasm v1.6 (C) 1988 by RML

         ifp1
         use   defsfile
         endc

DOHELP   set   0
DOROLL   set   0

tylg     set   Prgrm+Objct   
atrv     set   ReEnt+rev
rev      set   $00
edition  set   24

         mod   eom,name,tylg,atrv,start,size

********************************************************************
* begin our data area, starts on direct page
********************************************************************

savedu   rmb   2                save the u register
totsects rmb   3
tmpnum   rmb   4
sectmode rmb   1
diskpath rmb   1                disk path number
currtrak rmb   2                current track on
currside rmb   2
currsect rmb   1                current sector on
sectcount rmb   1                counted sectors
u0009    rmb   1
u000A    rmb   2
u000C    rmb   2
u000E    rmb   2
mfm      rmb   1                denisity (double/single)
u0011    rmb   1
tpi      rmb   1
numsides rmb   1
*u0014    rmb   1
ncyls    rmb   2                total number of cylinders
u0017    rmb   1
u0018    rmb   1
sectors  rmb   2                total number of sectors
sectors0 rmb   2                total number of sectors
bps      rmb   1                bytes per sector (returned from SS.DSize)
dtype    rmb   1                disk device type (5", 8", hard disk)
dns      rmb   1                density byte
sas      rmb   1                density byte
ready    rmb   1                ready to proceed, skip warning
dresult  rmb   2                decimal number in binary
interlv  rmb   1                sector interleave value
u0022    rmb   2
clustsiz rmb   1                cluster size
clustspecified rmb   1                cluster size specified on command line
ClustSz  rmb   1                cluster size
u0029    rmb   1
u002A    rmb   1
u002B    rmb   1
u002C    rmb   1
u002D    rmb   1
u002E    rmb   1
u002F    rmb   1
u0030    rmb   1
u0031    rmb   1
u0032    rmb   1
u0033    rmb   1
u0034    rmb   1
u0035    rmb   1
oksects  rmb   3
u0038    rmb   2
u003A    rmb   2
u003C    rmb   1
u003D    rmb   2
u003F    rmb   2
u0041    rmb   2
u0043    rmb   1
u0044    rmb   1
dovfy    rmb   1
dtentry  rmb   2
u0048    rmb   1
stoff    rmb   2
u004B    rmb   1
u004C    rmb   1
u004D    rmb   1
dolog    rmb   1                logical format
prmbuf   rmb   2
u0051    rmb   4
u0055    rmb   15
u0064    rmb   7
u006B    rmb   4
dskname  rmb   32               quoted delimited disk name buffer
u008F    rmb   40
LSN0     rmb   256              LSN0 build buffer
optbuf   rmb   256
numbuf   rmb   32
fdtbuf1  rmb   3
fdtbuf2  rmb   9924
u297E    rmb   451
size     equ   .

name     fcs   /Format/
         fcb   edition

*val1     fdb   $0000
*val2     fdb   $0000
*val3     fdb   $0000
hdsdat   fdb   $80E5,$80E5,$0000
sgtdat   fdb   $0100,$28FF,$0600,$01FC,$0CFF,$0000
sgsdat   fdb   $0600,$01FE,$0400,$01F7,$0AFF,$0600
         fdb   $01FB,$80E5,$80E5,$01F7,$0AFF,$0000
         fcb   $FF
sgfidp   fdb   $0043
sgsize   fdb   $0128

* Double Density Data
dbtdat   fdb   $504E,$0C00,$03F6,$01FC,$204E,$0000
dbsdat   fdb   $0C00,$03F5,$01FE,$0400,$01F7,$164E
         fdb   $0C00,$03F5,$01FB,$80E5,$80E5,$01F7
         fdb   $164E,$0000
         fcb   $4E
dbfidp   fdb   $0090
dbsize   fdb   $0152
dctdat   fdb   $204E,$0000,$0C00,$03F5,$01FE,$0400
         fdb   $01F7,$164E,$0C00,$03F5,$01FB,$80E5
         fdb   $80E5,$01F7,$184E,$0000
         fcb   $4E
dcfidp   fdb   $0030
dcsize   fdb   $0154

********************************************************************
* format module execution start address
********************************************************************

start    stu   <savedu          save our data pointer
         bsr   ClrWork          clear the work area
         bsr   OpenDev          get device name and open it
         bsr   Default          handle all the options
         lbsr  GetDTyp          initialize the device
         lbsr  Proceed
         lbsr  Format           physically format device
         lbsr  InitLSN0         initialize LSN0
         lbsr  ReadLSN0		attempt to read back LSN0
         lbsr  Stamps
         lbsr  MkRootFD         file descriptor
         ldu   <dtentry         device table entry
         os9   I$Detach         detach the device
         clrb                   flag no error
Exit     os9   F$Exit           exit module

********************************************************************
* clear our working memory area
********************************************************************

ClrWork  leay  diskpath,u       point to work area
         pshs  y                save that
         leay  >LSN0,u          get size of area
ClrOne   clr   ,-y              clear it down
         cmpy  ,s               at begin?
         bhi   ClrOne           not yet,
         puls  pc,y             done

********************************************************************
* get rbf device name and open it
********************************************************************

OpenDev  lda   ,x+              get char at X
         cmpa  #PDELIM          pathlist delimiter?
         beq   PrsPrm           branch if so
BadPath  ldb   #E$BPNam         else set bad pathname
         lbra  PrtError         and print error
PrsPrm   os9   F$PrsNam         parse pathname
         lbcs  PrtError         branch if illegal (has additional pathlist element)
         lda   #PDELIM          get pathlist name separator
         cmpa  ,y               another pathlist separator?
         beq   BadPath          yes, set bad pathname
         sty   <u0022           no, save end of pathname
         leay  <prmbuf,u        point to pathname buffer
MovNam   sta   ,y+              save pathname character
         lda   ,x+              get next pathname character
         decb                   decrement pathname size
         bpl   MovNam           got full pathname?
         leax  <prmbuf+1,u      get pathname for I$Attach
         lda   #C$SPAC          space character
         sta   ,y               delimit pathname
         clra                   get access mode
         os9   I$Attach         attach the rbf device
         lbcs  PrtError         if error print error and exit
         stu   <dtentry         save device table entry
         ldu   <savedu          get data pointer
         lda   #PENTIR          delimit pathname
         ldb   #C$SPAC          for os9 I$Open
         std   ,y               do it now
         lda   #WRITE.          get access mode
         leax  <prmbuf,u        get pathname
         os9   I$Open           open the rbf device
         bcs   Exit             exit if could not open it
         sta   <diskpath        save path number
         rts                    return

********************************************************************
* get geometry and options, proceed (Y/N)
********************************************************************

Default  bsr   Geometry
         lbsr  DoOpts
*         lbsr  Proceed
         rts   

********************************************************************
* get rbf device geometry
********************************************************************

ssztbl   fcb   $1,$2,$4,$8

Geometry leax  >optbuf,u        status packet address
         clrb                   SS.OPT function
         os9   I$GetStt         get status packet
         bcs   Exit             exit if error
         ldb   PD.SID-PD.OPT,x  number of surfaces
         stb   <numsides        save it
         stb   <u0014           save it
         ldb   PD.SToff-PD.OPT,x foreign disk format?
         beq   L0143            no,
         tfr   b,a              yes, get copy
         anda  #$0F             foreign low nibble
         sta   <stoff           save it
         lsrb
         lsrb
         lsrb
         lsrb                   foreign high nibble
         stb   <u004B           save it
L0143    ldb   PD.DNS-PD.OPT,x  density capability
         stb   <dns
         pshs  b                save it
         andb  #DNS.MFM         check double-density
         stb   <mfm             save double-density (Yes/No)
         stb   <u0011           save it again
         ldb   ,s               get saved PD.DNS byte
         lsrb                   checking
         pshs  b                save it
         andb  #$01             tpi (0=48, 1=96/135)
         stb   <tpi             save it
         puls  b                get checking
         lsrb                   
         andb  <u0011
         stb   <u004C
         puls  b
         stb   <u004D
         beq   L0169
         stb   <u004B
         clr   <stoff
L0169    ldd   PD.CYL-PD.OPT,x  number of cylinders
         std   <ncyls           save it
         ldb   PD.TYP-PD.OPT,x  disk device type
         stb   <dtype           save it
         andb  #TYPH.SSM	mask out all but sector size
         leay  ssztbl,pcr
         ldb   b,y
         stb   <bps		and save bytes per sector
         ldd   PD.SCT-PD.OPT,x  default sectors/track
         std   <sectors         save it
         ldd   PD.T0S-PD.OPT,x  default sectors/track tr00,s0
         std   <sectors0        save it
         ldb   PD.ILV-PD.OPT,x  sector interleave offset
         stb   <interlv         save it
         ldb   PD.SAS-PD.OPT,x  minimum sector allocation
         stb   <sas             save it
         ldb   #$01             default cluster size
         stb   <clustsiz        save it
         stb   <sectmode        and sector mode
*** ADDED CODE -- BGP.  CHECK FOR PRESENCE OF SS.DSIZE
         lda   PD.TYP-PD.OPT,x	get type byte
         bita  #TYPH.DSQ	drive size query bit set?
         beq   nogo@		no, don't bother querying the drive for its size
         lda   <diskpath        get disk path number
         ldb   #SS.DSize        disk size getstat
         os9   I$GetStt         attempt
         bcs   err@
         sta   <bps		save bytes/sector
         stb   <sectmode
         tstb			LBA mode?
         bne   chs@
         tfr   x,d
         stb   <totsects	save result...
         sty   <totsects+1
         bra   nogo@
chs@
         stx   <ncyls           save cylinders
         stb   <numsides        save sides
         stb   <u0014           ????
         sty   <sectors         save sectors/track
         sty   <sectors0        save sectors/track 0
nogo@
         clrb                   no error
         rts                    return
err@     pshs  b
         leax  CapErr,pcr
         lda   #$02
         ldy   #100
         os9   I$WritLn
         puls  b
         lbra  PrtError

********************************************************************
* find a option and call, until all options are processed
********************************************************************

DoOpts   ldx   <u0022           option buffer
L0185    leay  >OptTbl,pcr      point to table
         bsr   L019C            check for match?
         bcs   L01A5            no, match
         pshs  b,a              save d register
         ldd   $02,y            get offset value
         leay  d,y              make function address
         puls  b,a              restore d register
         jsr   ,y               call function
         bcc   L0185            finished good?
         lbra  Exit             no, exit
L019C    lda   ,x+              get option character
L019E    cmpa  ,y               is it in the table?
         bne   L01A6            no, try the next one
         ldb   $01,y            get return value
         clra                   flag good
L01A5    rts                    return
L01A6    leay  $04,y            get next table location
         tst   ,y               is it the end of the table?
         bne   L019E            no, try next location
         coma                   yes, flag bad
         rts                    return

********************************************************************
* option command table
********************************************************************

OptTbl
opt.1    fcc   /R/
         fcc   /Y/
         fdb   DoReady-opt.1
opt.2    fcc   /r/
         fcc   /Y/
         fdb   DoReady-opt.2
opt.3    fcc   /S/
         fcc   / /
         fdb   DoDsity-opt.3
opt.4    fcc   /s/
         fcc   / /
         fdb   DoDsity-opt.4
opt.5    fcc   /D/
         fcc   /M/
         fdb   DoDsity-opt.5
opt.6    fcc   /d/
         fcc   /M/
         fdb   DoDsity-opt.6
opt.7    fcc   /"/
         fcb   $00
         fdb   DoQuote-opt.7
opt.8    fcc   /:/
         fcb   $00
         fdb   DoColon-opt.8
opt.9    fcc   "/"
         fcb   $00
         fdb   DoClust-opt.9
opt.10   fcc   /1/
         fcb   $01
         fdb   Do1-opt.10
opt.11   fcc   /2/
         fcb   $02
         fdb   Do2-opt.11
opt.12   fcc   /'/
         fcb   0
         fdb   DoSQuote-opt.12
opt.13   fcc   /L/
         fcb   $01
         fdb   DoL-opt.13
opt.14   fcc   /l/
         fcb   01
         fdb   DoL-opt.14
opt.15   fcc   /(/
         fcb   $00
         fdb   DoLParen-opt.15
opt.16   fcc   /)/
         fcb   $00
         fdb   DoRParen-opt.16
opt.17   fcc   /,/
         fcb   $00
         fdb   DoComa-opt.17
opt.18   fcb   C$SPAC
         fcb   00
         fdb   DoSpace-opt.18
         fcb   $00

********************************************************************
* S/D - density; single or double
********************************************************************

DoDsity  cmpb  <u0011
         bgt   OptAbort
         cmpb  <u004C
         blt   OptAbort
         stb   <mfm
         clrb

********************************************************************
* skip white space
********************************************************************

DoComa
DoRParen
DoLParen
DoSpace  rts

********************************************************************
* set ready flag - skip warn messages
********************************************************************

DoReady  stb   <ready           set and save ready
         rts                    return

********************************************************************
* 1/2 - number of sides
********************************************************************

Do2
Do1      cmpb  <numsides
         bgt   OptAbort
         stb   <numsides
         clrb
         rts

********************************************************************
* only do a logical format on the rbf device
********************************************************************

DoL      stb   <dolog           do a logical format
         clrb                   did option
         rts                    return

********************************************************************
* not a option - show abort message and exit
********************************************************************

OptAbort leax  >AbortOp,pcr     Option not allowed message
         lbra  PExit            print message and exit

********************************************************************
* double quoted option "disk name" save name in dskname
********************************************************************

DoQuote  leay  <dskname,u       delimited buffer
         ldb   #C$SPAC          delimited size
koQuote  lda   ,x+              delimited character
         cmpa  #'"              is end quote?
         beq   L0221            must be done
         sta   ,y+              no, save character
         decb                   decrement name size
         bne   KoQuote          get all 32 of them or quote
L0215    ldb   ,x+              next delimited character
         cmpb  #'"              find end quote?
         beq   L0227            yes, back up and mark it
         cmpb  #C$SPAC          skip space character?
         bcc   L0215            yes, get next one
         bra   L0227            no, mark it's end
L0221    lda   #C$SPAC          get space character
         cmpb  #C$SPAC          any delimited characters?
         beq   L022B            no, mark it's end
L0227    leay  -$01,y           yes, back up
         lda   ,y               get saved character
L022B    adda  #$80             make it negative
         sta   ,y               mark it's end
         clrb                   did option
         rts                    return

********************************************************************
* single quoted option 'number of cylinders' save number in ncyls
********************************************************************

DoSQuote lbsr  Decimal          procces number of cylinders
         ldd   <dresult         get it
         std   <ncyls           save it
         rts                    return

********************************************************************
* colon quoted option :interleave value: save value in interlv
********************************************************************

DoColon  lbsr  Decimal          proccess interleave value 
         ldd   <dresult         get it
         tsta                   answer out of bounds?
         beq   L0243            no, save it
         ldb   #$01             yes, default size
L0243    stb   <interlv         save it
         rts                    return

********************************************************************
* quoted option /cluster size/ save size in clustsiz
* cluster size is in decimal. The number of sectors
* in a cluster must be a power of 2 and the number
* should max out at 32 for coco os9
********************************************************************

DoClust  lbsr  Decimal          proccess cluster size
         ldd   <dresult         get it
         tsta                   answer out of bounds?
         beq   L0250            no, save it
         ldb   #$01             yes, default size
L0250    stb   <clustsiz        save it
         stb   <clustspecified  save fact that cluster was specified
         negb                   get two's complement
         decb                   power of 2
         andb  <clustsiz        in range?
         beq   L025C            yes, skip ahead
         ldb   #$01             no, default size
         stb   <clustsiz        save it
L025C    clrb                   did option
L025D    rts                    return

********************************************************************
* print title, format (Y/N), and get response
********************************************************************

Proceed  
*         leax  >Title,pcr       coco formatter message
*         lbsr  PrintLn          print it
         tst   <dtype		disk type...
         bmi   h@
         lbsr  FloppySummary
         bra   n@
h@       lbsr  HDSummary
n@       leay  >optbuf,u        point to option buffer
         ldx   PD.T0S-PD.OPT,y  default sectors/track tr00,s0
         tst   <mfm             double-density?
         beq   L0271            no,
         ldx   PD.SCT-PD.OPT,y  default sectors/track
L0271    stx   <sectors         save it
         lbsr  LineFD
         leax  >FmtMsg,pcr      formatting drive message
         ldy   #FmtMLen         length of message
         lbsr  Print            print it
         leax  <prmbuf,u        input buffer
         tfr   x,y              put it in y
L0283    lda   ,y+              get input
         cmpa  #PENTIR          proceed (y/n)?
         bne   L0283            no, wait for yes
         pshs  y                save input pointer
         lda   #C$CR            carriage return
         sta   -$01,y           store it over input
         lbsr  PrintLn          print line
         puls  y                get pointer
         lda   #PENTIR
         sta   -$01,y
         lda   <ready           ok to proceed? ready
         bne   L02BC            yes, were ready skip ahead
*         tst   <dtype           is this a floppy or hard drive?
*         bpl   L02AB            it is a floppy
*         leax  >HDFmt,pcr       it is a hard drive
*         ldy   #$002A           length of message
*         lbsr  Print            print message
L02AB    leax  >Query,pcr       query message
         ldy   #QueryLen        length of message
         lbsr  Input            show it and get response (Y/N)
         anda  #$DF             make it upper case
         cmpa  #'Y              answered yes?
         bne   L02D5            no, check for no?
L02BC    tst   <dtype           formatting hard drive?
         bpl   L025D            no, return skip hard disk warn message
         leax  >HDFmt,pcr       show hard disk warn message
         ldy   #HDFmtLen        size of the message
         lbsr  Input            show it and get response (Y/N)
         anda  #$DF             make it upper case
         cmpa  #'Y              answered yes?
         beq   L025D            yes, return
         clrb                   clear error
         lbra  Exit             exit
L02D5    clrb                   clear error
         cmpa  #'N              answered no?
         lbeq  Exit             yes, exit
         bra   L02AB            no, get a (Y/N) answer

********************************************************************
* print usage message and return
********************************************************************

LineFD   leax  >CrRtn,pcr       point to line feed
PrintLn  ldy   #80              size of message
Print    lda   #$01             standard output path
         os9   I$WritLn         print line
         rts                    return

********************************************************************
* print message and get response
* entry: x holds data address y holds data size
*  exit: a holds response (ascii character)
********************************************************************

Input    pshs  u,y,x,b,a        save registers
         bsr   Print            print line
         leax  ,s               get data address
         ldy   #$0001           data size
         clra                   standard input
         os9   I$Read           read it
         lbcs  Exit             exit on error
         bsr   LineFD           print line feed
         puls  u,y,x,b,a        restore stack
         anda  #$7F             make it ascii
         rts                    return

********************************************************************
* get capability of the rbf device
********************************************************************

GetDTyp  leax  >hdsdat,pcr      assume hard drive data for now
         stx   <u000A           sector data pointer
         ldb   <dtype           get disk drive type
         bitb  #TYP.HARD+TYP.NSF hard disk or non-standard type?
         bne   L0323            no, check track data
         tst   <u004D           
         beq   L031B
         leax  >dctdat,pcr
         bra   L032D
L031B    leax  >sgtdat,pcr
         tst   <mfm             double-density?
         beq   L032D            no,
L0323    stx   <u000A
         leax  >dbtdat,pcr
         tst   <u004C
         beq   L032F
L032D    stx   <u000A
L032F    stx   <u000C
         tst   <sectmode	LBA values already in place?
         beq   ack@
* Compute total sectors from C/H/S
         clra  
         ldb   <numsides	get number of sides
         tfr   d,y
         clrb  			D = 0
         ldx   <ncyls
         bsr   Mulbxty		multiply B,X*Y
* B,X now is numsides * numcyls
* Subtract one from B,X because t0s will be added later
         exg   d,x
         subd  #$0001
         bcc   L0344
         leax  -$01,x
L0344    exg   d,x
         ldy   <sectors
         bsr   Mulbxty		multiply B,X*Y
* B,X now is numsides * numcyls * sectors
         exg   d,x
* Add in sectors/track0
         addd  <sectors0
         std   <totsects+1
         exg   d,x
         adcb  #$00
         stb   <totsects
ack@
**** We now multiply totsects * the bytes per sector
         dec   <bps		decrement bytes per sector (8=7,4=3,2=1,1=0)
         beq   mlex@		exit out ofloop if zero
ml@      lsl   <totsects+2	else multiply by 2
         rol   <totsects+1
         rol   <totsects
         lsr   <bps		shift out bits
         tst   <bps
         bne   ml@
mlex@
************************************************
         lda   #$08
         pshs  a
         ldx   <totsects+1
         ldb   <totsects
         bsr   Div24by8		divide totsects by 8
         lda   <clustsiz        get cluster size
         pshs  a                save it as divisor
         bsr   Div24by8
         tstb  			B = 0?
         beq   L0374		branch if so
* Too small a cluster size comes here
         tst   <clustspecified  did user specify cluster on command line?
         bne   u@		branch if so (show error message)
         lsl   <clustsiz	multiply by 2
         bcs   u@		if carry set to stop
         leas  2,s		else eat stack
         bra   mlex@		and continue trying
u@       leax  >ClustMsg,pcr    cluster size mismatch message
         lbsr  PrintLn          print mismatch message
         lbra  L05B1            abort message and exit
L0374    leas  $02,s
         stx   <ClustSz
         rts                    return

********************************************************************
* multiply (mlbxty)
********************************************************************

Mulbxty  lda   #$08             make stack space
MulClr   clr   ,-s              clear the space
         deca                   cleared?
         bne   MulClr           no,
         sty   ,s
         stb   $02,s
         stx   $03,s
MulLoop  ldd   ,s               we done?
         beq   MulZer           yes, clean up
         lsra  
         rorb  
         std   ,s
         bcc   MulNoC
         ldd   $03,s
         addd  $06,s
         std   $06,s
         lda   $02,s
         adca  $05,s
         sta   $05,s
MulNoC   ldd   $03,s
         lslb  
         rola  
         std   $03,s
         lda   $02,s
         rola  
         sta   $02,s
         bra   MulLoop          continue rest
MulZer   leas  $05,s            clean up space
         puls  pc,x,b           pop results, return

********************************************************************
* 24 bit divide (2,s = divisor, B/X = dividend)
********************************************************************

L03AE    pshs  x,b		save X,B on stack
         lsr   ,s		divide X,B by 2
         ror   $01,s
         ror   $02,s
         puls  x,b		retrieve X,B
         exg   d,x		exchange bits 15-0 in D,X
         adcb  #$00
         adca  #$00
         exg   d,x
         adcb  #$00
Div24by8 lsr   $02,s
         bne   L03AE
         rts   

********************************************************************
* format rbf device
********************************************************************

Format   tst   <dolog           doing a logical format?
         bne   L03E4            yes, don't do this then
         tst   <dtype           test for hard drive from PD.TYP
         bpl   L03E5		branch if floppy
         leax  >Both,pcr        PHYSICAL and LOGICAL? message
         ldy   #BothLen         length of message
         lbsr  Input            print and get input
         anda  #$DF             make it upper case
         cmpa  #'Y              is it yes?
         beq   L03E5            yes,
         cmpa  #'N              is it no?
         bne   Format           no,
L03E4    rts                    return
L03E5    lda   <diskpath        device path number
         ldb   #SS.Reset        reset device
         os9   I$SetStt         at track zero
         lbcs  Exit             exit if error
         ldd   #$0000           get current track
         std   <currtrak        save it
         inca                   get current sector
         sta   <currsect        save it
L03F8    clr   <currside	clear current side
L03FA    bsr   L045C
         leax  >LSN0,u		point to our LSN0 buffer
         ldd   <currtrak
         addd  <u0048
         tfr   d,u
         clrb  
         tst   <u004D
         bne   L041B
         tst   <mfm		single density?
         beq   L041D		branch if so
         tst   <u004C
         bne   L041B
         tst   <currtrak+1
         bne   L041B
         tst   <currside	side?
         beq   L041D		branch if 0
L041B    orb   #$02		else set side 1
L041D    tst   <tpi   		48 tpi?
         beq   L0423		branch if so
         orb   #$04		else set 96/135 tpi bit
L0423    lda   <currside	get current side
         beq   L0429		branch if 0
         orb   #$01
L0429    tfr   d,y              get side/density bits
         lda   <diskpath        rbf device path number
         ldb   #SS.WTrk         format (write) track
         os9   I$SetStt         do format it
         lbcs  Exit             exit if error
         ldu   <savedu          get u pointer
         ldb   <currside	get current side
         incb  			increment
         stb   <currside	and store
         cmpb  <numsides	compare against number of sides
         bcs   L03FA		branch if greater than
         ldd   <currtrak        get current track
         addd  #$0001           increment it
         std   <currtrak        save it
         cmpd  <ncyls           did all tracks?
         bcs   L03F8            no,
         rts                    yes, return

********************************************************************
*
********************************************************************

L044E    ldy   <u000E
L0451    ldd   ,y++
         beq   L046B
L0455    stb   ,x+
         deca  
         bne   L0455
         bra   L0451
L045C    lda   <dtype			get drive's PD.TYP
         bita  #TYP.HARD+TYP.NSF	hard disk or non-standard format?
         beq   L046C			branch if neither
         ldy   <u000C
         leax  >LSN0,u			point to the LSN0 buffer
         bsr   L0451
L046B    rts   

********************************************************************
*
********************************************************************

L046C    ldy   <u000C
         ldb   <sectors+1
         tst   <currtrak+1
         bne   L047E
         tst   <currside
         bne   L047E
         ldy   <u000A
*         ldb   <u001C
         ldb   <sectors0+1
L047E    sty   <u000E
         stb   <u0009
         stb   <u0018
         bsr   L04EC
         leax  >LSN0,u
         bsr   L0451
         sty   <u000E
L0490    bsr   L044E
         dec   <u0009
         bne   L0490
         lda   ,y+
         sty   <u000E
         stx   <u003D
         leay  >u297E,u
         sty   <dresult
         tfr   a,b
L04A6    std   ,x++
         cmpx  <dresult
         bcs   L04A6
         ldy   <u000E
         ldd   ,y++
         std   <u003F
         ldd   ,y
         std   <u0041
         clr   <u0009
         leax  >LSN0,u
         ldd   <u003F
         leay  >u008F,u
L04C3    leax  d,x
         ldd   <currtrak+1
         adda  <stoff
         std   ,x
         ldb   <u0009
         lda   b,y
         incb  
         stb   <u0009
         ldb   <currsect
         adda  <u004B
         bcs   L04E5
         std   $02,x
         lda   <u0009
         cmpa  <u0018
         bcc   L04E4
         ldd   <u0041
         bra   L04C3
L04E4    rts   

********************************************************************
*
********************************************************************

L04E5    leax  >AbortSct,pcr    sector number out of range message
         lbra  PExit            print message and exit

********************************************************************
*
********************************************************************

L04EC    pshs  y,b
         tfr   b,a
         ldb   <currtrak+1
         cmpb  #$01
         bhi   L0518
         leax  >u008F,u
         leay  a,x
         ldb   <interlv
         bne   L0507
L0500    leax  >AbortIlv,pcr    Interleave out of range message
         lbra  PExit            print message and exit
L0507    cmpb  <u0018
         bhi   L0500
         nega  
         pshs  y,x,b,a
         clra  
L050F    sta   ,x
         inca  
         cmpa  <u0018
         bne   L051A
         leas  $06,s
L0518    puls  pc,y,b
L051A    ldb   <interlv
         abx   
         cmpx  $04,s
         bcs   L0525
         ldb   ,s
         leax  b,x
L0525    cmpx  $02,s
         bne   L050F
         leax  $01,x
         stx   $02,s
         bra   L050F

********************************************************************
* initialize sector 0
********************************************************************

InitLSN0 lbsr  ClrBuf		clear the sector buffer
         ldd   <totsects+1	get total sectors bits 15-0
         std   DD.TOT+1,x	save
         ldb   <totsects	get bits 23-16
         stb   DD.TOT,x		save
         ldd   <sectors		get sectors/track
         std   <DD.SPT,x	save
         stb   DD.TKS,x		save
         lda   <clustsiz        get cluster size
         sta   DD.BIT+1,x       save
         clra  
         ldb   <ClustSz		get cluster size
         tst   <u0029
         beq   L054F
         addd  #$0001
L054F    addd  #$0001
         std   DD.DIR+1,x	save directory sector
         clra  
         tst   <mfm		single density?
         beq   L0561		branch if so
         ora   #FMT.DNS		else set double density bit
         tst   <u004C
         beq   L0561
         ora   #$08
L0561    ldb   <numsides	get number of sides
         cmpb  #$01		just 1?
         beq   L0569		branch if so
         ora   #FMT.SIDE	else set double-sided bit
L0569    tst   <tpi 		48tpi?
         beq   L056F		branch if so
         ora   #FMT.TDNS	else set 96/135 tpi
L056F    sta   <DD.FMT,x	save
         ldd   <ClustSz		get cluster size
         std   DD.MAP,x		save number of bytes in allocation bit map
         lda   #$FF		attributes
         sta   DD.ATT,x		save
         leax  >LSN0+DD.DAT,u	point to time buffer
         os9   F$Time   	get current time
         leax  >LSN0+DD.NAM,u
         leay  <dskname,u       quote delimited disk name buffer
         tst   ,y		name in buffer?
         beq   L0594		branch if not
L058C    lda   ,y+		get character of name
         sta   ,x+		and save in name area of LSN0
         bpl   L058C
         bra   L05C7
* Here we prompt for a disk name
L0594    leax  >DName,pcr
         ldy   #DNameLen
         lbsr  Print		print disk name prompt
         leax  >LSN0+DD.NAM,u	point to new name
         ldy   #33		read up to 33 characters
         clra  
         os9   I$ReadLn 	from standard input
         bcc   L05B8		branch if ok
         cmpa  #E$EOF		end of file?
         bne   L0594		branch if not
L05B1    leax  >Aborted,pcr     format aborted message
         lbra  PExit            print message and exit
L05B8    tfr   y,d		copy number of chars entered into D
         leax  d,x		point to last char + 1
         clr   ,-x
         decb  			decrement chars typed
         beq   L0594		branch if zero (go ask again)
         lda   ,-x		get last character
         ora   #$80		set hi bit
         sta   ,x		and save
L05C7    leax  >LSN0+DD.DAT,u	point to time
         leay  <$40,x
         pshs  y
         ldd   #$0000
L05D3    addd  ,x++
         cmpx  ,s
         bcs   L05D3
         leas  $02,s
         std   >LSN0+DD.DSK,u	save disk ID
* Not sure what this code is for...
*         ldd   >val1,pcr
*         std   >u01A7,u
*         ldd   >val2,pcr
*         std   >u01A9,u
*         ldd   >val3,pcr
*         std   >u01AB,u
         lda   <diskpath
         ldb   #SS.Opt
         leax  >LSN0+DD.OPT,u	point to disk options
         os9   I$GetStt 	get options
         ldb   #SS.Reset	reset head to track 0
         os9   I$SetStt 	do it!
         lbcs  Exit		branch if error
         leax  >LSN0,u		point to LSN0
         lbra  WritSec		and write it!

********************************************************************
* read in sector 0 of device
********************************************************************

ReadLSN0 lda   <diskpath		get disk path
         os9   I$Close  		close it
         leax  <prmbuf,u		point to device name
         lda   #READ.
         os9   I$Open   		open for read
         lbcs  BadSect			branch if problem
         sta   <diskpath		save new disk path
         leax  >LSN0,u
         ldy   #256
         os9   I$Read   		read first sector
         lbcs  BadSect			branch if problem
         lda   <diskpath		get disk path
         os9   I$Close  		close path to device
         leax  <prmbuf,u		re-point to device name
         lda   #UPDAT.
         os9   I$Open   		open in read/write mode
         lbcs  BadSect			branch if error
         sta   <diskpath		else save new disk path
         rts   				and return

********************************************************************
*
********************************************************************

Stamps   lda   <dtype            get device type in A
         clr   <dovfy		clear verify flag
         bita  #TYP.HARD         hard drive?
         beq   nothd             branch if not
* Hard drives are asked for physical verification here
askphys  leax  >Verify,pcr
         ldy   #VerifyL
         lbsr  Input		 prompt for physical verify of hard drive
         anda  #$DF
         cmpa  #'Y		 yes?
         beq   nothd  		 branch if so
         cmpa  #'N		 no?
         bne   askphys	         not not, ask again
         sta   <dovfy	        else flag that we don't want physical verify
nothd    ldd   <sectors0	get sectors/track at track 0
         std   <u0017		save
         clra  			D = 0
         clrb  
         sta   <oksects		clear OK sectors
         std   <oksects+1
         std   <currtrak	clear current rack
         std   <sectcount	clear counted sectors
         std   <u0032
         stb   <u0031
         sta   <u003C
         leax  >optbuf,u
         stx   <u0038
         lbsr  ClrSec
         leax  >$0100,x
         stx   <u003A
         clra  
         ldb   #$01		D = 1
         std   <u0034
         lda   <clustsiz        get cluster size
         sta   <u002B           store in cluster counter
         clr   <u002A
         clra  
         ldb   <ClustSz
         tst   <u0029
         beq   L069D
         addd  #$0001
L069D    addd  #$0009
         std   <u002D
         lda   <clustsiz        get cluster size
L06A4    lsra  
         bcs   L06B5
         lsr   <u002D
         ror   <u002E
         bcc   L06A4
         inc   <u002E
         bne   L06A4
         inc   <u002D
         bra   L06A4
L06B5    ldb   <u002E
         stb   <u002F
         lda   <clustsiz        get cluster size
         mul   
         std   <u002D
         subd  #$0001
         subb  <ClustSz
         sbca  #$00
         tst   <u0029
         beq   L06CC
         subd  #$0001
L06CC    stb   <u002C
L06CE    tst   <dovfy           do we verify?
         bne   OutScrn          no, output screen display
         lda   <diskpath        yes, get rbf device path
         leax  >LSN0,u          get sector buffer
         ldy   #256             sector size
         os9   I$Read           read of sector successful?
         bcc   OutScrn          yes, output screen display
         os9   F$PErr           no, print error message
         lbsr  NextSec          get next sector
         lda   #$FF
         sta   <u002A
         tst   <u0031
         bne   OutScrn          output screen display
         ldx   <u0032
         cmpx  <u002D
         bhi   OutScrn          output screen display
BadSect  leax  >BadSectM,pcr    bad system sector message
PExit    lbsr  PrintLn          print message
         clrb                   clear error
         lbra  Exit             exit no error

********************************************************************
* output screen display scrolling track counter
********************************************************************

OutScrn  ldd   <sectcount       get counted sectors
         addd  #$0001           increment it
         std   <sectcount       save counted sectors
         cmpd  <u0017           good sector count?
         bcs   L0745            next segment
         clr   <sectcount       clear counted sectors
         clr   <u0009           
         tst   <dovfy           are we verifying?
         bne   L073A            no,
         lda   #C$SPAC          yes, get space
         pshs  a                save it
         lda   <currtrak+1      track high byte
         lbsr  HexDigit         make it ascii
L0724    pshs  b,a              save two ascii digits
         lda   <currtrak        track low byte
         lbsr  HexDigit         make it ascii
         pshs  b                save two ascii digits
         tfr   s,x              get output from stack
         ldy   #$0004           length of output
         lbsr  Print            print it
         lda   $02,s
         cmpa  #$46             end of line?
         bne   L0738            skip line feed
         lbsr  LineFD           print linefeed
L0738    leas  $04,s            pop output off stack
L073A    ldd   <currtrak        get current track
         addd  #$0001           increment it
         std   <currtrak        save it back
         ldd   <sectors         get number of sectors
         std   <u0017           save it
L0745    dec   <u002B           decrement cluster counter
         bne   L075B
         bsr   L0784
         tst   <u002A
         bne   L0755
         ldd   <oksects+1       increment good sectors
         addd  #$0001
         std   <oksects+1
         bcc   L0755
         inc   <oksects
L0755    clr   <u002A
         lda   <clustsiz        get cluster size
         sta   <u002B           save in cluster counter
L075B    ldb   <u0031
         ldx   <u0032
         leax  $01,x
         bne   L0764
         incb  
L0764    cmpb  <totsects
         bcs   L076C
         cmpx  <totsects+1
         bcc   L0773
L076C    stb   <u0031
         stx   <u0032
         lbra  L06CE
L0773    lda   #$FF
         sta   <u002A
         leay  >optbuf,u
L077B    cmpy  <u0038
         beq   GoodSect         number of good sectors summary
         bsr   L0784
         bra   L077B
L0784    ldx   <u0038
         lda   <u002A
         rora  
         rol   ,x+
         inc   <u003C
         lda   <u003C
         cmpa  #$08
         bcs   L07A6
         clr   <u003C
         stx   <u0038
         cmpx  <u003A
         bne   L07A6
         bsr   WrtSecs
         leax  >optbuf,u
         stx   <u0038
         lbsr  ClrSec
L07A6    rts                    return

********************************************************************
* convert byte to ascii hexadecimal and return it in d register
********************************************************************

HexDigit tfr   a,b              get byte again
         lsra                   shift upper digit
         lsra
         lsra
         lsra
         andb  #$0F             mask lower digit
         addd  #$3030           make it ascii
         cmpa  #$39             upper digit > 9
         bls   L07B8            no,
         adda  #$07             yes, make hexadecimal
L07B8    cmpb  #$39             lower digit > 9
         bls   L07BE            no,
         addb  #$07             yes, make hexadecimal
L07BE    rts                    return

********************************************************************
* number of good sectors message
********************************************************************

GoodSect lbsr  LineFD           print line feed
         leax  >NumGood,pcr     number of good sectors
         ldy   #NGoodLen        length of message
         lbsr  Print            print it
         ldb   <clustsiz        get cluster size
         lda   <oksects         get  24 bit counter
         ldx   <oksects+1
         pshs  x,a              save 24 bit counter
L07D4    lsrb                   carry set 0xxx xxxx  ->  X ?
         bcs   L07DF            yes,
         lsl   $02,s            <u0036 1  X  <- nnnn nnnn  X  <- xxxx xxx0
         rol   $01,s            <u0036 2  N  <- nnnn nnnX  N  <- xxxx xxx0
         rol   ,s               <u0036 3  N  <- nnnn nnnN
         bra   L07D4            did all sectors?
L07DF    puls  x,a              get counted sectors
         ldb   #C$CR
         pshs  b                save enter
         tfr   d,y              get size
         tfr   x,d              get
         tfr   b,a              get convert byte
         bsr   HexDigit         convert it BYTE 1
         pshs  b,a              save in buffer
         tfr   x,d              get convert byte
         bsr   HexDigit         convert it BYTE 2
         pshs  b,a              save in buffer
         tfr   y,d              get convert byte
         bsr   HexDigit         convert it BYTE 3
         pshs  b,a              save it buffer
         tfr   s,x              get output buffer
         lbsr  PrintLn          print it
         leas  $07,s            fix stack
         rts                    return

********************************************************************
* get allocation bit map and write sectors
********************************************************************

WrtSecs  pshs  y                save register
         clra                   set number
         ldb   #$01             bits to set
         cmpd  <u0034           map sector?
         bne   L081E            yes, write sector
         leax  >optbuf,u        allocation bit map
         clra                   get number
         ldb   <u002F           system sectors
         tfr   d,y              into register
         clrb                   first bit to set
         os9   F$AllBit         set allocation bit map
         lbcs  BadSect          if there a error
L081E    lbsr  GetSec           get sector
         leax  >optbuf,u        allocation bit map
         lbsr  WritSec          write sector
         ldd   <totsects        get total sectors
         cmpd  <u0031           lsn sector count?
         bcs   AdvSec           advance to mapped sectors
         bhi   NxtSec           get next sector
         ldb   <totsects+2      get LSB total sectors
         cmpb  <u0033           good sector count?
         bcc   AdvSec           advance to mapped sectors
NxtSec   lbsr  NextSec          skip to next sector
AdvSec   ldd   <u0034           get mapped sectors
         addd  #$0001           count from one
         std   <u0034           save mapped sectors count
         puls  pc,y             restore and return

********************************************************************
* create root directory file descriptor
********************************************************************

MkRootFD bsr   GetSec           get sector
         leax  >fdtbuf1,u       sector buff
         bsr   ClrSec           clear sector
         leax  >fdtbuf2,u       get date last modified
         os9   F$Time           get system time
         leax  >fdtbuf1,u       get file descriptor
         lda   #DIR.+PEXEC.+PWRIT.+PREAD.+EXEC.+UPDAT.
         sta   FD.ATT,x         save in FD.ATT
         lda   #$02             get link count
         sta   FD.LNK,x         save in FD.LNK
         clra                   directory size
         ldb   #DIR.SZ*2        directory entries (DIR.SZ*2)
         std   FD.SIZ+2,x       save it           (FD.SIZ+2)
         ldb   <u002C
         decb
         stb   <FD.SEG+FDSL.B+1,x save it  (FD.SEG+FDSL.B+1)
         ldd   <u0034
         addd  #$0001
         std   <FD.SEG+FDSL.A+1,x save it  (FD.SEG+FDSL.A+1)
         bsr   WritSec
         bsr   ClrBuf
         ldd   #$2EAE           (#'.*256+'.+128)
         std   DIR.NM,x         (DIR.NM)
         stb   <DIR.SZ+DIR.NM,x (DIR.NM+DIR.SZ)
         ldd   <u0034
         std   <DIR.FD+1,x
         std   <DIR.SZ+DIR.FD+1,x
         bsr   WritSec
         bsr   ClrBuf
         ldb   <u002C
         decb                   make zero offset (0 - 255)
NextCnt  decb                   decrement sector count
         bne   NextWrt          if more to do
         rts                    else return
NextWrt  pshs  b                save sector count
         bsr   WritSec          write the sector
         puls  b                get count back
         bra   NextCnt          do until done

********************************************************************
* clear the 256 byte sector buffer
********************************************************************

ClrBuf   leax  >LSN0,u         sector buffer
ClrSec   clra                   store mask
         clrb                   sector count
ClrLop   sta   d,x              clear the buffer
         decb                   decrement sector count
         bne   ClrLop           clear sector buffer
         rts                    return when done

********************************************************************
* write physical 256 byte sector to the diskette
********************************************************************

WritSec  lda   <diskpath        get path number
         ldy   #256             get sector size
         os9   I$Write          write the sector
         lbcs  Exit             exit on error
         rts                    return

********************************************************************
* get sector file position
********************************************************************

GetSec   clra  
         ldb   <u0034           get map sectors high word
         tfr   d,x              save it
         lda   <u0035
         clrb                   get map sectors low  word
         tfr   d,u              save it

********************************************************************
* seek to physical sector
********************************************************************

SeekSec  lda   <diskpath        get path number
         os9   I$Seek           seek to sector
         ldu   <savedu          get data pointer
         lbcs  Exit             exit if error
         rts                    return

********************************************************************
* skip to the next sector
********************************************************************

NextSec  ldx   <u0031           lsn count
         lda   <u0033           good sector count
         clrb                   add this
         addd  #$0100           sector
         tfr   d,u              lsn count
         bcc   SeekSec          seek it?
         leax  $01,x            next sector
         bra   SeekSec          seek it

********************************************************************
* the format module never gets to this code?
********************************************************************

         ldd   ,y
         leau  >LSN0,u
         leax  >dcnums,pcr      decimal number conversion table
         ldy   #$2F20

********************************************************************
*
********************************************************************

L08E6    leay  >$0100,y
         subd  ,x
         bcc   L08E6
         addd  ,x++
         pshs  b,a
         ldd   ,x
         tfr   y,d
         beq   L090E
         ldy   #$2F30
         cmpd  #$3020
         bne   L0908
         ldy   #$2F20
         tfr   b,a
L0908    sta   ,u+
         puls  b,a
         bra   L08E6
L090E    sta   ,u+
         lda   #C$CR
         sta   ,u
         ldu   <savedu
         leas  $02,s
         leax  >LSN0,u
         lbsr  PrintLn
         rts

dcnums   fdb   10000,1000,100,10,1,0

********************************************************************
*  process decimal number input (65535)
********************************************************************

Decimal  ldd   #$0000           start at zero
L092F    bsr   DecBin           get first digit
         bcs   L0939            if overflow
         bne   L092F            get next digit
         std   <dresult         save decimal as binary
         bne   L093E            if no error return
L0939    ldd   #$0001           flag error
         std   <dresult         save it
L093E    rts                    return

********************************************************************
* process decimal number into it's binary representation
* return with binary in the d register
********************************************************************

DecBin   pshs  y,b,a            save registers
         ldb   ,x+              get digit
         subb  #$30             make it binary
         cmpb  #$0A             bla bla bla!          
         bcc   L095D
         lda   #$00
         ldy   #$000A
L094F    addd  ,s
         bcs   L095B
         leay  -$01,y
         bne   L094F
         std   ,s
         andcc #^Zero
L095B    puls  pc,y,b,a
L095D    orcc  #Zero
         puls  pc,y,b,a

********************************************************************
* print error, usage message, and exit
********************************************************************

PrtError lda   #$02             standard error
         os9   F$PErr           print error
         IFNE  DOHELP
         leax  <HelpMsg,pcr     point to usage
         ldy   #HelpLen         usage size
         lda   #$02             standard error
         os9   I$WritLn         print usage
         ENDC
         clrb                   no error
         os9   F$Exit           exit module

********************************************************************
* messages
********************************************************************

*Title    fcb   C$LF
*         fcc   "COLOR COMPUTER FORMATTER"
*HelpCR   fcb   C$CR
         IFNE  DOHELP
HelpMsg  fcc   "Use: FORMAT /devname <opts>"
         fcb   C$LF
         fcc   "  opts: R   - Ready"
         fcb   C$LF
         fcc   "        S/D - density; single or double"
         fcb   C$LF
         fcc   "        L   - Logical format only"
         fcb   C$LF
         fcc   /        "disk name"/
         fcb   C$LF
         fcc   "        1/2 - number of sides"
         fcb   C$LF
         fcc   "        'No. of cylinders'   (in decimal)"
         fcb   C$LF
         fcc   "        :Interleave value:   (in decimal)"
         fcb   C$LF
         fcc   "        /Cluster size/       (in decimal)"
         fcb   C$CR
HelpLen  equ   *-HelpMsg
         ENDC
FmtMsg   fcc   "Formatting device: "
FmtMLen  equ   *-FmtMsg
Query
*         fcc   "y (yes) or n (no)"
*         fcb   C$LF
         fcc   "proceed?  "
QueryLen equ   *-Query
CapErr   fcc   "ABORT can't get media capacity"
         fcb   C$CR
AbortIlv fcc   "ABORT Interleave value out of range"
         fcb   C$CR
AbortSct fcc   "ABORT Sector number out of range"
         fcb   C$CR
AbortOp  fcc   "ABORT Option not allowed on Device"
         fcb   C$CR
DName    fcc   "Disk name: "
DNameLen equ   *-DName
         fcc   "How many Cylinders (Tracks?) : "
BadSectM fcc   "Bad system sector, "
Aborted  fcc   "FORMAT ABORTED"
         fcb   C$CR
ClustMsg fcc   "Cluster size mismatch"
CrRtn    fcb   C$CR
*         fcc   "Double density? "
*         fcc   "Track 0 Double density? "
*TPIChg   fcc   "Change from 96tpi to 48tpi? "
*DSided   fcc   "Double sided? "
NumGood  fcc   "Number of good sectors: $"
NGoodLen equ *-NumGood
HDFmt    fcc   "this is a HARD disk - are you sure? "
*HDFmt    fcc   "WARNING: You are formatting a HARD Disk.."
*         fcb   C$LF
*         fcc   "Are you sure? "
HDFmtLen equ   *-HDFmt
Both     fcc   "Both PHYSICAL and LOGICAL format? "
BothLen  equ   *-Both
Verify   fcc   "Physical Verify desired? "
VerifyL  equ   *-Verify
SUMH    
         fcb   C$CR,C$LF
         fcc   "      NitrOS-9 RBF Disk Formatter"
         fcb   C$CR,C$LF
         fcc   "------------  Format Data  ------------"
         fcb   C$CR,C$LF
*         fcb   C$CR,C$LF
*         fcc   "Fixed values:"
         fcb   C$CR,C$LF
SUMHL    equ   *-SUMH
PFS      fcc   "    Physical floppy size: "
PFSL     equ   *-PFS
DC       fcc   "           Disk capacity: "
DCL      equ   *-DC
CSZ      fcc   "            Cluster size: "
CSZL     equ   *-CSZ
*SSZ      fcc   "             Sector size: "
*SSZL     equ   *-SSZ
SST      fcc   "           Sectors/track: "
SSTL     equ   *-SST
TZST     fcc   "     Track zero sect/trk: "
TZSTL    equ   *-TZST
*LSNOF    fcc   "              LSN offset: $"
*LSNOFL   equ   *-LSNOF
TPC      fcc   "Total physical cylinders: "
TPCL     equ   *-TPC
MSA      fcc   " Minimum sect allocation: "
MSAL     equ   *-MSA
RF       fcc   "        Recording format: "
RFL      equ   *-RF
TD       fcc   "    Track density in TPI: "
TDL      equ   *-TD
NLC      fcc   "Number of log. cylinders: "
NLCL     equ   *-NLC
NS       fcc   "      Number of surfaces: "
NSL      equ   *-NS
SI       fcc   "Sector interleave offset: "
SIL      equ   *-SI
SCTS     fcc   " sectors"
         fcb   C$CR
SPPR     fcc   "                         ("
SPPRL    equ   *-SPPR
PRSP     fcc   " bytes)"
         fcb   C$CR
PRSPL    equ   *-PRSP
*VAR      fcb   C$CR,C$LF
*         fcc   "Variables:"
*         fcb   C$CR,C$LF
*VARL     equ   *-VAR
Three5   fcc   !3 1/2"!
         fcb   C$CR
FiveQ    fcc   !5 1/4"!
         fcb   C$CR
_MFM     fcc   /M/
FM       fcc   /FM/
         fcb   C$CR
TPI48    fcc   /48/
         fcb   C$CR
TPI96    fcc   !96/135!
         fcb   C$CR


HDSummary
         bsr   ShowHeader
         bsr   ShowDiskCapacity
         ldb   <dtype
         andb  #TYPH.DSQ
         bne   o@
         lbsr  ShowSectorsTrack
         lbsr  ShowSectorsTrackZero
         lbsr  ShowNumberSurfaces
         lbsr  ShowTotalPhysCylinders
o@       lbsr  ShowClusterSize
*         lbsr  ShowSectorSize
*         lbsr  ShowLSNOffset
         lbsr  ShowSAS
         rts

FloppySummary
         bsr   ShowHeader
         bsr   ShowPhysFloppy
         lbsr  ShowSectorsTrack
         lbsr  ShowSectorsTrackZero
         lbsr  ShowTotalPhysCylinders
         lbsr  ShowSAS
*         lbsr  ShowVariables
         lbsr  ShowRecordingFormat
         lbsr  ShowTrackDensity
         lbsr  ShowNumberLogCylinders
         lbsr  ShowNumberSurfaces
         lbsr  ShowSectorInterleaveOffset
         rts

ShowHeader
         lda   #$01
         leax  SUMH,pcr
         ldy   #SUMHL
         os9   I$Write
         rts

ShowPhysFloppy
         leax  PFS,pcr
         ldy   #PFSL
         os9   I$Write
         ldb   <dtype
         leax  FiveQ,pcr
         bitb  #TYP.8
         beq   n@
t@       leax  Three5,pcr
n@       ldy   #80
         os9   I$WritLn 
         rts

ShowDiskCapacity
         leax  DC,pcr
         ldy   #DCL
         os9   I$Write
         clra
         ldb   <totsects
         std   <tmpnum
         ldd   <totsects+1
         std   <tmpnum+2
         leax  <tmpnum,u
         leay  numbuf,u
         lbsr  itoa
* X points to buffer, Y holds size
         pshs  x
         tfr   y,d
         leax  d,x
* X points at character after last member
         leay  SCTS,pcr
go@      lda   ,y+
         sta   ,x+
         cmpa  #C$CR
         bne   go@
         puls  x
         ldy   #80
         lda   #$01
         os9   I$WritLn
* Put out leading spaces and (
         leax  SPPR,pcr
         ldy   #SPPRL
         os9   I$Write
* Copy number from totsects
         clra
         ldd   totsects,u
         std   tmpnum,u
         lda   totsects+2,u
         clrb
         std   tmpnum+2,u
         leax  <tmpnum,u
         leay  numbuf,u
         lbsr  itoa
* X points to the ASCII number
* Y holds length
         lda   #$01
         os9   I$Write
         leax  PRSP,pcr
         ldy   #PRSPL
         os9   I$WritLn
         rts         

*ShowSectorSize
*         leax  SSZ,pcr
*         ldy   #SSZL
*         os9   I$Write
*         lbra  LineFD

ShowSectorsTrack
         leax  SST,pcr
         ldy   #SSTL
         os9   I$Write
         ldd   <sectors
         lbra  PrintNum

ShowSectorsTrackZero
         leax  TZST,pcr
         ldy   #TZSTL
         os9   I$Write
         ldd   <sectors0
         lbra  PrintNum

ShowTotalPhysCylinders
         leax  TPC,pcr
         ldy   #TPCL
         os9   I$Write
         ldd   <ncyls
         lbra  PrintNum

ShowClusterSize
         leax  CSZ,pcr
         ldy   #CSZL
         os9   I$Write
         clra
         ldb   <clustsiz
         lbra  PrintNum

ShowSAS
         leax  MSA,pcr
         ldy   #MSAL
         os9   I$Write
         clra
         ldb   <sas
         lbra  PrintNum

*ShowVariables
*         leax  VAR,pcr
*         ldy   #VARL
*         os9   I$Write
*         rts

ShowRecordingFormat
         leax  RF,pcr
         ldy   #RFL
         os9   I$Write
         leax  _MFM,pcr
         tst   <mfm
         bne   n@
         leax  FM,pcr
n@       ldy   #80
         os9   I$WritLn 
         rts

ShowTrackDensity
         leax  TD,pcr
         ldy   #TDL
         os9   I$Write
         leax  TPI48,pcr
         ldb   <dns
         bitb  #DNS.DTD
         beq   n@
         leax  TPI96,pcr
n@       ldy   #80
         os9   I$WritLn 
         rts

ShowNumberLogCylinders
         leax  NLC,pcr
         ldy   #NLCL
         os9   I$Write
         ldd   <ncyls
         lbra  PrintNum

ShowNumberSurfaces
         leax  NS,pcr
         ldy   #NSL
         os9   I$Write
         clra
         ldb   <numsides
         bra   PrintNum

ShowSectorInterleaveOffset
         leax  SI,pcr
         ldy   #SIL
         os9   I$Write
         clra
         ldb   <interlv
         bra   PrintNum

* Output decimal number to stdout with CR tacked at end
* Entry: B = number
* Leading zeros are NOT printed
PrintNum
         pshs  d
         clr   ,-s 
         clr   ,-s 
         leax  ,s
         leay  numbuf,u
         bsr   itoa
         lda   #$01
         os9   I$Write
         leas  4,s
         lbra  LineFd

Base     fcb   $3B,$9A,$CA,$00       1,000,000,000
         fcb   $05,$F5,$E1,$00         100,000,000
         fcb   $00,$98,$96,$80		10,000,000
         fcb   $00,$0f,$42,$40		 1,000,000
         fcb   $00,$01,$86,$a0		   100,000
         fcb   $00,$00,$27,$10		    10,000
         fcb   $00,$00,$03,$e8		     1,000
         fcb   $00,$00,$00,$64		       100
         fcb   $00,$00,$00,$0a		        10
         fcb   $00,$00,$00,$01		         1

* Entry:
* X = address of 24 bit value
* Y = address of buffer to hold hexadecimal number
* Exit:
* X = address of buffer holding hexadecimal number
* Y = length of number string in bytes (always 6)
*i24toha  pshs  y
*         ldb   #3
*         pshs  b
*a@       lda   ,x
*         anda  #$F0
*         lsra
*         lsra
*         lsra
*         lsra
*         cmpa  #10
*         blt   o@
*         adda  #$41
*o@       sta   ,y+
*         lda   ,x+
*         anda  #$0F
*         cmpa  #10
*         blt   p@
*         adda  #$41
*p@       sta   ,y+
*         dec   ,s
*         bne   a@
*         leas  1,s
*         ldy   #0006
*         puls  x,pc

* Entry:
* X = address of 32 bit value
* Y = address of buffer to hold number
* Exit:
* X = address of buffer holding number
* Y = length of number string in bytes
itoa     pshs  u,y
         tfr   y,u
         ldb   #10		max number of numbers (1^10)
         pshs  b		save count on stack
         leay  Base,pcr		point to base of numbers
s@       lda   #$30		put #'0
         sta   ,u		at U
s1@      bsr   Sub32		,X=,X-,Y
         inc   ,u
         bcc   s1@		if X>0, continue
         bsr   Add32		add back in
         dec   ,u+
         dec   ,s		decrement counter
         beq   done@
         lda   ,s
         cmpa  #$09
         beq   comma@
         cmpa  #$06
         beq   comma@
         cmpa  #$03
         bne   s2@
comma@   ldb   #',
         stb   ,u+
s2@      leay  4,y		point to next
         bra   s@
done@    leas  1,s
* 1,234,567,890
         ldb   #14		length of string with commas + 1
         ldx   ,s++		get pointer to buffer
a@       decb
         lda   ,x+		get byte
         cmpa  #'0
         beq   a@
         cmpa  #',
         beq   a@
         clra
         tfr   d,y		transfer count into Y
         leax  -1,x
         puls  u,pc

* Entry:
* X = address of 32 bit minuend
* Y = address of 32 bit subtrahend
* Exit:
* X = address of 32 bit difference
Sub32    ldd   2,x
         subd  2,y
         std   2,x
         ldd   ,x
         sbcb  1,y
         sbca  ,y
         std   ,x
         rts


* Entry:
* X = address of 32 bit number
* Y = address of 32 bit number
* Exit:
* X = address of 32 bit sum
Add32    ldd   2,x
         addd  2,y
         std   2,x
         ldd   ,x
         adcb  1,y
         adca  ,y
         std   ,x
         rts


         IFNE  DOROLL
RollMsg  fcc   "        Recording Format:  FM/MFM"
         fcb   C$LF
         fcc   "    Track density in TPI:  48/96"
         fcb   C$LF
         fcc   "     Number of Cylinders:  0000"
         fcb   C$LF
         fcc   "      Number of Surfaces:  0000"
         fcb   C$LF
         fcc   "Sector Interleave Offset:  0000"
         fcb   C$LF
         fcc   "               Disk type:  0000"
         fcb   C$LF
         fcc   "         Sectors/Cluster:  0000"
         fcb   C$LF
         fcc   "           Sectors/Track:  0000"
         fdb   $0A0A
         fcc   "Sector: 00  Track: 00  Side: 00"
RollLen  equ   *-RollMsg
         ENDC

         emod
eom      equ   *
         end
