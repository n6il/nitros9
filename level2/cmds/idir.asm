********************************************************************
* IDir - Show interrupt polling table
*
* $Id$
*
* Ed.    Comments                                       Who YY/MM/DD
* ------------------------------------------------------------------
* 1      Created                                        KKD
* 2      Modified                                       GH

         nam   IDir
         ttl   Show interrupt polling table

         ifp1  
         use   defsfile
         endc  

rev      set   $01
edition  set   2

         mod   lenmod,namemd,prgrm+objct,reent+rev,start,endmem

         org   $0000
usaver   rmb   $0002      = $0000
datptr   rmb   $0002      = $0002
notuse   rmb   $0002      = $0004
outptr   rmb   $0002      = $0008
cntr1    rmb   $0001      = $0009
devptr   rmb   $0002      = $000B
tblptr   rmb   $0002      = $000D
dpvars   rmb   $0009
rptbuf   rmb   $0050
Devbuf   rmb   $0104
u016A    rmb   $0002
u016C    rmb   $0102
u026E    rmb   $0104
buffer2  rmb   $02C8
endmem   equ   .
x0004    equ   $0004
Poltbl   equ   $0011
x0012    equ   $0012
DevTbl   equ   $0013
x0015    equ   $0015
x0023    equ   $0023
x0050    equ   $0050
x0080    equ   $0080
x00C8    equ   $00C8
x0100    equ   $0100
z0000    equ   $0000

namemd   fcs   "IDir"
         fcb   edition

z0012    fcc   "Polling Table at: "
z0012L   equ   *-z0012
Device   fcc   " Device Table at: "
DeviceL  equ   *-Device
Topline  fcc   " Device    Driver  IRQ   Flip     "
         fcb   C$CR
ToplineL equ   *-Topline
Line2    fcc   "Port Mem   Name  Vector  &Mask Pty"
         fcb   C$CR
Line2L   equ   *-Line2
Line3    fcc   "---- ----  ------------  ----- ---"
crtn     fcb   C$CR
Line3L   equ   *-Line3

start    lda   #$01
         stu   <usaver    at 0000 in direct page
         leax  >crtn,pcr  start with \n
         ldy   #$0001
         os9   I$WritLn
         bcs   errexit
         leax  >z0012,pcr "Polling Table at: " etc
         ldy   #z0012L     num chars to write
         os9   I$Write
         bcs   errexit
         lda   #$01
         leax  buffer2,u  $0372,u
         os9   F$GPrDsc   get $200 byte copy of process 1
         bcs   errexit
* F$GPrDsc returns $200 bytes, why inc only $40?
         leax  P$DatImg,x 40,x to next ptr area=$03B2,u
         stx   <datptr    at +2 in direct page
         bra   z00C5
okexit   clrb  
errexit  os9   F$Exit
z00C5    leay  rptbuf,u   = $0016,u
         sty   <outptr    at 0006 in direct page
         ldu   <usaver    get u back? was it diddled?
         leau  u016A,u    is now! destination buffer
         ldd   <datptr    get ptr P$datimg
         ldx   #$0080     offset to begin=D.Devtbl
         ldy   #$0004     include D.Poltbl 4 bytes to copy
         os9   F$CpyMem   get it
         bcs   errexit
         ldu   <usaver    restore u
         ldd   u016A,u    get D.Devtbl addr
         std   <DevTbl    put in dp
         ldd   u016C,u    get D.Poltbl addr
         std   <Poltbl    put in dp u016A is re-used below
         lbsr  z023B      cnvrt 4 dgts of poll tbl addr
         lbsr  z01B1      output poll tbl address in ascii
* troubleshooting printout
         pshs  u,x,y,d
         leax  >Device,pcr
         ldy   #DeviceL
         lda   #1
         os9   I$Write
         ldu   <usaver
         leax  rptbuf,u
         stx   <outptr
         ldd   <devtbl
         lbsr  z023B
         lbsr  z01B1
         puls  u,x,y,d
* to here
         lda   #1
         leax  >crtn,pcr  stick another \n on it
         ldy   #$0001
         os9   I$WritLn
         bcs   errexit
         leax  >Topline,pcr " Device    Driver  IRQ   Flip     "
         ldy   #ToplineL
         os9   I$WritLn
         bcs   errexit
         leax  >Line2,pcr "Port Mem   Name  Vector  &Mask Pty"
         ldy   #Line2L
         os9   I$WritLn
         bcs   errexit
         leax  >Line3,pcr "---- ----  ------------  ----- ---"
         ldy   #Line3L
         os9   I$WritLn
         lbcs  errexit
         ldu   <usaver    now get orig u back
         leau  u016A,u
         stu   <devptr
         ldx   <Poltbl    D.Poltbl addr
         ldy   #$006C     256 bytes to get is too many
         ldd   <datptr    s/b only 9*12 entries, $6C
         os9   F$CpyMem
         lbcs  errexit
         ldu   <usaver
         leau  Devbuf,u
         ldd   <datptr
         ldx   <DevTbl    D.Devtbl
         ldy   #x0100     is not all of devtbl, s/b $015F!
         os9   F$CpyMem
         lbcs  errexit
         ldb   #$0C
         stb   <cntr1
         ldx   <devptr
z0165    ldd   Q$STAT,x   06,x checking memory required
* another troubleshooting printout
* pshs u,x,y,d,cc
* ldu <usaver
* leax rptbuf,u
* stx <outptr
* lbsr z023B converet d to ascii
* lbsr z01B1
* puls u,x,y,d,cc
* to here
         beq   z016B
         bsr   z0179
z016B    dec   <cntr1
         lbeq  okexit
         ldx   <devptr
         leax  $09,x
         stx   <devptr    to next irqtbl entry
         bra   z0165
z0179    ldu   <usaver    restore u to dp
         leay  rptbuf,u
         sty   <outptr
         ldx   <devptr
         ldd   ,x
         lbsr  z023B      convert 2 bytes port addr->ascii
         ldd   $06,x
         lbsr  z023B      convert 2 bytes memsiz->ascii
         lbsr  z0243      extra space in line
         bsr   z01CA      now do name
         ldu   <usaver
         ldx   <devptr
         ldd   $04,x      get irq vector
         lbsr  z023B      convert it to ascii
         lbsr  z0243      extra space
         lda   $02,x      get flip
         lbsr  z0241      convert 1 byte + space
         lda   $03,x      get mask
         lbsr  z0241      convert 1 byte + space
         lbsr  z0243      extra space
         lda   $08,x      get priority byte
         lbsr  z0241      convert 1 byte
z01B1    ldx   <outptr
         lda   #C$CR      terminate this line
         sta   ,x
         ldu   <usaver    restore u again
         leax  rptbuf,u   ptr to outbuff
         ldy   #80        max 80 chars
         lda   #$01       stdout
         os9   I$WritLn
         lbcs  errexit
         rts   
z01CA    ldx   <devptr    fnd nam in devtbl if memaddr=
         ldb   #$1C       27 entries max in devtbl
         pshs  b
* now we make an assumption that data
* areas for the same driver will be
* in the same page of memory, so compare
* only the high bytes of the address
         ldb   $06,x      get irq dat addr
         leax  Devbuf,u   devtbl buffer
z01D6    cmpb  $02,x
         beq   z01F3      if match, found device
         leax  $09,x      else inc to next tbl entry
         dec   ,s         that pshs'd b above
         bne   z01D6
         leas  $01,s      get rid of stack data
         ldy   <outptr
* lda #$20
* ldb #$08 trial to space empty over
* z01EA sta ,y+
* decb 
* bne z01EA
         leay  8,y        this leaves name visible
         sty   <outptr    until new one found
         rts   
z01E9    ldy   <outptr
         ldb   #08
         lda   #$20       a space 
z01EA    sta   ,y+
         decb  
         bne   z01EA
         sty   <outptr
         rts   
z01F3    leas  $01,s      get rid of stack dat
         ldx   V$DESC,x   $04,x pointer to dev desc
         beq   z01E9      what, no module name ptr?
         pshs  u
         leau  u026E,u
         ldd   <datptr
         ldy   #x00C8
         os9   F$CpyMem
         puls  u
         lbcs  errexit
         leax  u026E,u
         ldd   $0B,x
         leax  d,x
         lda   #$08
         sta   <x0015
         clrb  
         bra   z0220
z021D    bsr   z025B
z0220    incb  
         cmpb  <x0015
         bcc   z0232
         lda   ,x+
         bpl   z021D
         anda  #$7F
         bsr   z025B
         cmpb  <x0015
         bcc   z023A
z0232    bsr   z0243
         incb  
         cmpb  <x0015
         bcs   z0232
z023A    rts   
z023B    pshs  b          convert to ascii
         bsr   z0247      make 2 digits
         puls  a
z0241    bsr   z0247      make 2 more
z0243    lda   #$20
         bra   z025B
z0247    tfr   a,b
         lsra  
         lsra  
         lsra  
         lsra  
         bsr   z0251
         tfr   b,a
z0251    anda  #$0F
         cmpa  #$0A
         bcs   z0259
         adda  #$07
z0259    adda  #$30
z025B    pshs  x
         ldx   <outptr    get outbuf ptr
         sta   ,x+
         stx   <outptr
         puls  pc,x

         emod  
lenmod   equ   *
         end   
