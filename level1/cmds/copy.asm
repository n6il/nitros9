********************************************************************
* Copy - File copy utility
*
* $Id$
*
* Ed.    Comments                                       Who YY/MM/DD
* ------------------------------------------------------------------
* 10     Reworked                                       RML

         nam   Copy
         ttl   File copy utility

* Edition 10 rewrite 10/28/88 - RML

         ifp1  
         use   defsfile
         use   rbfdefs
         endc  

tylg     set   Prgrm+Objct
atrv     set   ReEnt+rev
rev      set   $01
edition  set   10

         mod   eom,name,tylg,atrv,start,size

inpath   rmb   1          input path number
outpath  rmb   1          output path number
indevtyp rmb   1          input device type (1 = RBF)
verify   rmb   1          verify on/off (1=on)
bufsize  rmb   2          read/write buffer size
fsizemsb rmb   2          msb's of file size
fsizelsb rmb   2          lsb's of file size
writemsb rmb   2          msb's of bytes written to output
writelsb rmb   2          lsb's of bytes written to output
single   rmb   1          single drive copy flag (1=yes)
attribs  rmb   1          file attributes
fdbuff   rmb   16         File Descriptor buffer
optbuff  rmb   32         Path Descriptor Options Buffer
stack    rmb   448        stack storage
vfybuff  rmb   256        verify buffer
buffer   rmb   $2000-.    read/write buffer (minimum..will expand with mem mod)
size     equ   .

name     fcs   /Copy/
         fcb   edition

start    leas  vfybuff,u  set stack pointer to 512
         pshs  u          save u reg
         leau  <optbuff,u point u to 20th byte

clearit  clr   ,-u        clear byte
         cmpu  ,s         done ?
         bhi   clearit    loop back
         tfr   y,d        move in top of mem (after param area)
         subd  ,s++       subtract current stack
         subd  #$0300     and back off variable storage
         clrb             round off to page bondary
         std   <bufsize   buffer size
         pshs  x          save x register

getopt   lda   ,x+        get a char
         cmpa  #'-        was it a '-'??
         beq   chkopt     yes..go check opt
         cmpa  #C$CR      was it a <cr>??
         bne   getopt     no..check next char
         bra   openin     else done..go finish processing

chkopt   ldd   ,x+        get next 2 chars
         eora  #'S        check if its an S
         anda  #$DF       make upper case
         lbne  sndinstr   not an s.. send instructions
         cmpb  #$30       else check if next char is number or letter
         lbhs  sndinstr   yup...send instructions
         inc   <single    set s option
         bra   getopt     and check next char

openin   puls  x          restore line pointer
         lda   #READ.     open first file
         os9   I$Open
         lbcs  chkerr     error..go see what it was
         sta   <inpath    save path number
         pshs  x          save second path name start
         leax  <fdbuff,u  point to FD buffer
         ldy   #FD.SEG    bytes to read
         ldb   #SS.FD     get file descriptor
         os9   I$GetStt
         puls  x          restore line pointer
         bcs   getintyp   skip this on eror
         tst   <single    single drive copy ?
         beq   getintyp   no..skip this stuff
         lda   ,x         get first char of path name
         ldb   #E$BPNam   load bad path name error message
         cmpa  #PDELIM    was it a path separaor ?
         bne   errjump    nope..error

getintyp pshs  x          save out path name start
         lda   <inpath    get path number
         bsr   getopts    get option section
         lda   ,x         get device type
         sta   <indevtyp  save it
         ldb   #PREAD.+EXEC.+READ.+WRITE.  default attributes...read,write,execute,public
         cmpa  #DT.RBF    was device type RBF ?
         bne   openout    nope...don't get file size/attributes
         pshs  u,x        save registers
         lda   <inpath    get path number
         ldb   #SS.Size   Get File size
         bsr   getstat    do the GetStt call..exit on error
         stx   <fsizemsb  save 2 msb's of file size
         stu   <fsizelsb  save 2 lsb's of file size
         puls  u,x        restore registers
         ldb   <PD.ATT-PD.OPT,x   get file attributes

openout  stb   <attribs   save attributes
         ldx   ,s         get start of second path name
         lbsr  destsnd    send destination msg
         lda   #UPDAT.    open file for update
         ldb   <attribs   get attributes
         os9   I$Create   create the file
         puls  x          restore x register
         bcc   open010    no error..skip this
         inc   <verify    set verify off
         lda   #WRITE.    open filein write only mode
         ldb   <attribs   get atributes
         os9   I$Create   create the file
         bcs   errjump    exit on error

open010  sta   <outpath   save second path number
         bsr   getopts    get option section
         ldb   ,x         get device type
         cmpb  #DT.RBF    was it RBF
         beq   setvfy     yup...skip this
         inc   <verify    set verify off
         bra   mainloop   and skip all this

errjump  lbra  errexit    nope....error

getopts  leax  <optbuff,u point to buffer
         ldb   #SS.Opt    get option section of path descritor

getstat  os9   I$GetStt
         bcs   errjump    exit on error
         rts   

setvfy   tst   <verify    do we want verify on
         bne   setsiz     nope...dont set driver verify on
         ldb   #1         verify
         stb   PD.VFY-PD.OPT,x        turn verify on
         ldb   #SS.OPT    set options
         os9   I$SetStt
         bcs   errjump    exit on error

setsiz   lda   <indevtyp  get device type
         cmpa  #DT.RBF    is it an RBF file
         bne   mainloop   nope...dont preset file size
         pshs  u          save register
         lda   <outpath   get out path number
         ldb   #SS.Size   set file size
         ldx   <fsizemsb  get 2 msb's of in file size
         ldu   <fsizelsb  get 2 lsb's of in file size
         os9   I$SetStt   set the size
         bcs   errjump    exit on error
         puls  u          restore register
         lda   <outpath   get out path number
         leax  <fdbuff,u  point to FD buffer
         ldy   #FD.SEG    number of bytes to write
         ldb   #SS.FD     write out the FD (for dates,etc.)
         os9   I$SetStt

mainloop leax  buffer,u   point to buffer
         clra             source drive code
         lbsr  chkdrive   send source switch msg
         lda   <inpath    get in path number
         ldy   <bufsize   get buffer size
         os9   I$Read     read a block
         bcs   chkeof2    if error..go check which one
         lbsr  destsnd    send destination switch msg
         lda   <outpath   get out path number
         os9   I$Write    write the block out
         bcs   errjump    exit on error
         tst   <verify    are we verifying ?
         bne   chkeof     skip this
         pshs  u,y        save registers
         ldx   <writemsb  get 2 msb's of last write
         ldu   <writelsb  get 2 lsb's of last write
         lda   <outpath   get out path number
         os9   I$Seek
         bcs   errjump    exit on error
         ldu   2,s        get original u back
         leau  buffer,u   point to buffer start
         ldd   ,s         get bytes written
         addd  <writelsb  add on to current 2 lsb positions
         std   <writelsb  save them
         ldd   ,s         get bytes written
         bcc   vfy000     skip if no carry
         leax  1,x        bump up 2 msb's
         stx   <writemsb  and save them

vfy000   ldy   #$0100     chars to read for verify
         std   ,s         save it
         tsta             did we write more than 255 bytes ?
         bne   vfy010     yes...only read 256
         tfr   d,y        else xfer amount we did write

vfy010   ldx   2,s        get u register
         leax  $200,x     point to start of verify buffer
         lda   <outpath   get output path number
         os9   I$Read     read a block in
         bcs   errexit    exit on error

vfy020   lda   ,u+        get char from in buffer
         cmpa  ,x+        get char from out buffer
         bne   snderr1    not equal...send write verfiy msg
         leay  -1,y       decrement read count
         bne   vfy020     if more..loop back
         ldd   ,s         get write count back
         subd  #$0100     subtract verify buffer size
         bhi   vfy000     if more left...loop back
         puls  u,y        else restore registers

chkeof   lda   <inpath    get in path number
         ldb   #SS.EOF    check for end of file
         os9   I$GetStt
         bcc   mainloop   nope...loop back
         cmpb  #E$EOF     are we at end of file ?
         beq   closeout   yes...close file


chkeof2  cmpb  #E$EOF     check for end of file
         bne   errexit    nope...error exit
         bsr   destsnd    send msg for disk switch

closeout lda   <outpath   get out path number
         os9   I$Close    close the file
         bcc   exitok     exit w/o error if o.k.
         bra   errexit    else error exit

errmsg1  fcb   C$BELL
         fcc   /Error - write verification failed./
         fcb   C$CR

snderr1  leax  errmsg1,pcr address of 'write verify failed' msg
         bsr   sndline    send it
         comb             set carry
         ldb   #$01       set error
         bra   errexit    exit

chkerr   cmpb  #E$BPNam   was it bad path name
         bne   errexit    error exit

sndinstr leax  Help,pcr   get instructions
         bsr   sndline    send them
exitok   clrb  
errexit  os9   F$Exit

sndline  ldy   #256       max chars to send
         lda   #1         std out
         os9   I$WritLn   write the line
         rts   

* Send message and wait for disk switch for single drive copy

destsnd  lda   #1         set flag for destination message

chkdrive tst   <single    are we doing single drive copy
         beq   msgrts     nope..just exit
         pshs  y,x        else save registers

sndsrc   pshs  a          save drive flag
         tsta             do we want source drive ?
         bne   snddst     nope..do destination message
         leax  srcmsg,pcr point to 'source' msg
         ldy   #srcmsgsz  chars to send
         bra   msgsnd     go send it

srcmsg   fcc   /Ready SOURCE/
srcmsgsz equ   *-srcmsg

dstmsg   fcc   /Ready DESTINATION/
dstmsgsz equ   *-dstmsg

cntmsg   fcc   /, hit C to continue: /
cntmsgsz equ   *-cntmsg


snddst   leax  dstmsg,pcr point to 'destination' msg
         ldy   #dstmsgsz  chars to send

msgsnd   lda   #1         std out
         os9   I$Write    write it
         leax  cntmsg,pcr point to 'hit C ...'
         ldy   #cntmsgsz  get size of message
         os9   I$Write    write it
         leax  ,-s        back up for dummy buffer
         ldy   #1         chars to read
         clra             std in
         os9   I$Read     read one char
         lda   ,s+
         pshs  y,x,a      save registers
         leax  crmsg,pcr  point to <cr>
         bsr   sndline    write it
         puls  y,x,a      restore registers
         eora  #'C        check if its a C
         anda  #$DF       make it upper case
         puls  a          restore drive status
         bne   sndsrc     loop back & send message
         puls  y,x        restore registers
msgrts   rts   

Help     fcc   /Use: Copy <Path1> <Path2> [-s]/
         fcb   C$LF
         fcc   /  -s = single drive copy/
         fcc   / (Path2 must be complete pathlist)/
         fcb   C$CR
crmsg    fcb   C$CR

         emod  
eom      equ   *
         end
