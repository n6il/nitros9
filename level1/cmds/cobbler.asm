********************************************************************
* Cobbler - Write OS9Boot to a disk
*
* $Id$
*
* Ed.    Comments                                       Who YY/MM/DD
* ------------------------------------------------------------------
*   7    From Tandy OS-9 Level Two Vr. 2.00.01
*        Modified source to allow for OS-9 Level One    BGP 02/07/20
*        and OS-9 Level Two assembly

         nam   Cobbler
         ttl   Write OS9Boot to a disk

* Disassembled 02/07/06 13:08:41 by Disasm v1.6 (C) 1988 by RML

         ifp1
         use   defsfile
         use   rbfdefs
         endc

tylg     set   Prgrm+Objct   
atrv     set   ReEnt+rev
rev      set   $01
edition  set   7

os9l1start equ $EF00
os9l1size  equ $0F80

         mod   eom,name,tylg,atrv,start,size

LSN0Buff rmb   26
NewBPath rmb   1
DevPath  rmb   3
u001E    rmb   2
FullBName rmb   20	this buffer hodls the entire name (i.e. /D0/OS9Boot)
u0034    rmb   16
u0044    rmb   7
u004B    rmb   2
u004D    rmb   1
u004E    rmb   16
PathOpts rmb   20
u0072    rmb   2
u0074    rmb   10
BFFDBuf  rmb   16
u008E    rmb   1
u008F    rmb   7
u0096    rmb   232
BitMBuf  rmb   1024
         ifgt  Level-1
u057E    rmb   76
u05CA    rmb   8316
         endc
size     equ   .

name     fcs   /Cobbler/
         fcb   edition

L0015    fcb   $00 
         fcb   $00 

Help     fcb   C$LF
         fcc   "Use: COBBLER </devname>"
         fcb   C$LF
         fcc   "     to create a new system disk"
         fcb   C$CR
WritErr    fcb   C$LF
         fcc   "Error writing kernel track"
         fcb   C$CR
         fcb   C$LF
         fcc   "Error - cannot gen to hard disk"
         fcb   C$CR
FileWarn fcb   C$LF
         fcc   "Warning - file(s) present"
         fcb   C$LF
         fcc   "on track 34 - this track"
         fcb   C$LF
         fcc   "not rewritten."
         fcb   C$CR
BootFrag fcb   C$LF
         fcc   "Error - OS9boot file fragmented"
         fcb   C$CR
         ifgt  Level-1
RelMsg   fcb   C$LF
         fcc   "Error - can't link to Rel module"
         fcb   C$CR
         endc
BootName fcc   "OS9Boot "
         fcb   $FF 
RelNam   fcc   "Rel"
         fcb   $FF 

start    clrb  
         lda   #PDELIM
         cmpa  ,x
         lbne  L0473
         os9   F$PrsNam 
         lbcs  L0473
         lda   #PDELIM
         cmpa  ,y
         lbeq  L0473
         leay  <FullBName,u
L013C    sta   ,y+
         lda   ,x+
         decb  
         bpl   L013C
         sty   <u001E
         lda   #PENTIR
         ldb   #C$SPAC
         std   ,y++
         leax  <FullBName,u
         lda   #UPDAT.
         os9   I$Open   
         sta   <DevPath
         lbcs  L0473
         ldx   <u001E
         leay  >BootName,pcr
         lda   #PDELIM
L0162    sta   ,x+
         lda   ,y+
         bpl   L0162
         pshs  u
         clra  
         clrb  
         tfr   d,x
         tfr   d,u
         lda   <DevPath
         os9   I$Seek   	seek to 0
         lbcs  Bye
         puls  u
         leax  LSN0Buff,u
         ldy   #DD.DAT		$1A
         lda   <DevPath
         os9   I$Read   	read LSN0
         lbcs  Bye
         ldd   <DD.BSZ		get size of bootfile currently
         beq   L019F		branch if none
         leax  <FullBName,u
         os9   I$Delete 	delete existing bootfile
         clra  
         clrb  
         sta   <DD.BT
         std   <DD.BT+1
         std   <DD.BSZ
         lbsr  WriteLSN0
L019F    lda   #WRITE.
         ldb   #READ.+WRITE.
         leax  <FullBName,u
         os9   I$Create 	create new bootfile
         sta   <NewBPath
         lbcs  Bye		branch if error

         ifgt  Level-1
* OS-9 Level Two: Copy first 90 bytes of system direct page into our space
* so we can figure out boot location and size, then copy to our space
         leax  >L0015,pcr
         tfr   x,d
         ldx   #$0000
         ldy   #$0090
         pshs  u
         leau  >u057E,u
         os9   F$CpyMem 
         lbcs  Bye
         puls  u
         leax  >L0015,pcr
         tfr   x,d
         ldx   >u05CA,u
         ldy   #$0010
         pshs  u
         leau  <u004E,u
         os9   F$CpyMem 
         puls  u
         lbcs  Bye
         leax  >u057E,u
         ldd   <D.BtPtr,x
         pshs  b,a
         ldd   <D.BtSz,x
         std   <DD.BSZ
         pshs  b,a
L01F7    ldy   #$2000
         cmpy  ,s
         bls   L0203
         ldy   ,s
L0203    pshs  y
         leax  <u004E,u
         tfr   x,d
         ldx   $04,s
         pshs  u
         leau  >u057E,u
         os9   F$CpyMem 
         lbcs  Bye
         puls  u
         ldy   ,s
         leax  >u057E,u
         lda   <NewBPath
         os9   I$Write  
         lbcs  Bye
         puls  b,a
         ldy   $02,s
         leay  d,y
         sty   $02,s
         nega  
         negb  
         sbca  #$00
         ldy   ,s
         leay  d,y
         sty   ,s
         bne   L01F7
         leas  $04,s

         else

* OS-9 Level One: Write out bootfile
         ldd   >D.BTHI          get bootfile size
         subd  >D.BTLO
         tfr   d,y              in D, tfr to Y
         std   <DD.BSZ          save it
         ldx   >D.BTLO          get pointer to boot in mem
         lda   <NewBPath
         os9   I$Write          write out boot to file
         lbcs  Bye

         endc

         leax  <PathOpts,u
         ldb   #SS.Opt
         lda   <NewBPath
         os9   I$GetStt 
         lbcs  Bye
         lda   <NewBPath
         os9   I$Close  
         lbcs  L0473
         pshs  u
         ldx   <PathOpts+(PD.FD-PD.OPT),u
         lda   <PathOpts+(PD.FD+2-PD.OPT),u
* Now X and A hold file descriptor sector LSN of newly created OS9Boot
         clrb  
         tfr   d,u
         lda   <DevPath
         os9   I$Seek   	seek to os9boot file descriptor
         puls  u
         lbcs  Bye
         leax  <BFFDBuf,u
         ldy   #256
         os9   I$Read   	read in filedes sector
         lbcs  Bye
         ldd   >BFFDBuf+(FD.SEG+FDSL.S+FDSL.B),u
         lbne  IsFragd		branch if fragmented
* Get and save bootfile's LSN
         ldb   >BFFDBuf+(FD.SEG),u
         stb   <DD.BT
         ldd   >BFFDBuf+(FD.SEG+1),u
         std   <DD.BT+1
         lbsr  WriteLSN0
         lda   #$00
         ldb   #$01
         lbsr  Seek2LSN
         leax  >BitMBuf,u
         ldy   <DD.MAP
         lda   <DevPath
         os9   I$Read   	read bitmap sector(s)
         lbcs  Bye
         lda   #$22
         clrb  
         ldy   #$0004
         lbsr  L03A7
         bcc   L0304
         lda   #$22
         ldb   #$00
         lbsr  Seek2LSN
         leax  <u0044,u
         ldy   #$0007
         lda   <DevPath
         os9   I$Read   
         lbcs  Bye
         leax  <u0044,u
         ldd   ,x
         cmpa  #'O
         lbne  TrkAlloc
         cmpb  #'S
         lbne  TrkAlloc
         lda   $04,x
         cmpa  #$12
         beq   L02F7
         lda   #$22
         ldb   #$0F
         ldy   #$0003
         lbsr  L03A7
         lbcs  TrkAlloc
L02F7    clra  
         ldb   <DD.TKS
         tfr   d,y
         lda   #$22
         clrb  
         lbsr  L03FD
         bra   L0315
L0304    lda   #$22
         ldb   #$04
         ldy   #$000E
         lbsr  L03A7
         lbcs  TrkAlloc
         bra   L02F7

L0315    clra  
         ldb   #$01
         lbsr  Seek2LSN		Seek to bitmap sector on disk
         leax  >BitMBuf,u
         ldy   <DD.MAP
         lda   <DevPath
         os9   I$Write  	write updated bitmap
         lbcs  Bye

         ifgt  Level-1
* OS-9 Level Two: Link to Rel, which brings in boot code
         pshs  u
         lda   #Systm+Objct
         leax  >RelNam,pcr
         os9   F$Link   
         lbcs  NoRel
         tfr   u,d		tfr module header to D
         puls  u		get statics ptr
         subd  #$0006
         std   <u004B,u		save pointer
         lda   #$E0
         anda  <u004B,u
         ora   #$1E
         ldb   #$FF
         subd  <u004B,u
         addd  #$0001
         tfr   d,y
         lda   #$22
         ldb   #$00
         lbsr  Seek2LSN
         lda   <DevPath
         ldx   <u004B,u

         else

* OS-9 Level One: Write out data at $EF00
         lda   #$22
         ldb   #$00
         lbsr  Seek2LSN 
         lda   <DevPath
         ldx   #os9l1start
         ldy   #os9l1size

         endc

         os9   I$Write  
         lbcs  WriteBad
         os9   I$Close  
         lbcs  Bye
         clrb  
         lbra  Bye

* Get absolute LSN
* Returns in D
AbsLSN   pshs  b
         ldb   <DD.FMT		get format byte
         andb  #$01		check how many sides?
         beq   L037F		branch if 1
         ldb   #$02		else assume 2
         bra   L0381
L037F    ldb   #$01
L0381    mul   
         lda   <DD.TKS
         mul   
         addb  ,s
         adca  #$00
         leas  $01,s
         rts   

* Returns bit in bitmap corresponding to LSN in A
L038C    pshs  y,b
* Divide D by 8
         lsra  
         rorb  
         lsra  
         rorb  
         lsra  
         rorb  
         leax  d,x
         puls  b
         leay  <L03A1,pcr
         andb  #$07
         lda   b,y
         puls  pc,y

L03A1    fcb   $80,$40,$20,$10,$08,$04,$02,$01

L03A7    pshs  y,x,b,a
         bsr   AbsLSN		go get absolute LSN
         leax  >BitMBuf,u	point X to our bitmap buffer
         bsr   L038C
         sta   ,-s		save off
         bmi   L03CB
         lda   ,x
         sta   <u004D
L03BB    anda  ,s
         bne   L03F7
         leay  -$01,y
         beq   L03F3
         lda   <u004D
         lsr   ,s
         bcc   L03BB
         leax  $01,x
L03CB    lda   #$FF
         sta   ,s
         bra   L03DB
L03D1    lda   ,x
         anda  ,s
         bne   L03F7
         leax  $01,x
         leay  -$08,y
L03DB    cmpy  #$0008
         bhi   L03D1
         beq   L03ED
         lda   ,s
L03E5    lsra  
         leay  -$01,y
         bne   L03E5
         coma  
         sta   ,s
L03ED    lda   ,x
         anda  ,s
         bne   L03F7
L03F3    andcc #^Carry
         bra   L03F9
L03F7    orcc  #Carry
L03F9    leas  $01,s
         puls  pc,y,x,b,a
L03FD    pshs  y,x,b,a
         lbsr  AbsLSN		get absolute LSN
         leax  >BitMBuf,u
         bsr   L038C
         sta   ,-s
         bmi   L041C
         lda   ,x
L040E    ora   ,s
         leay  -$01,y
         beq   L043A
         lsr   ,s
         bcc   L040E
         sta   ,x
         leax  $01,x
L041C    lda   #$FF
         bra   L0426
L0420    sta   ,x
         leax  $01,x
         leay  -$08,y
L0426    cmpy  #$0008
         bhi   L0420
         beq   L043A
L042E    lsra  
         leay  -$01,y
         bne   L042E
         coma  
         sta   ,s
         lda   ,x
         ora   ,s
L043A    sta   ,x
         leas  $01,s
         puls  pc,y,x,b,a

Seek2LSN pshs  u,y,x,b,a
         lbsr  AbsLSN
         pshs  a
         tfr   b,a
         clrb  
         tfr   d,u
         puls  b
         clra  
         tfr   d,x
         lda   <DevPath
         os9   I$Seek   
         bcs   WriteBad
         puls  pc,u,y,x,b,a

WriteLSN0
         pshs  u		added for OS-9 Level One +BGP+
         clra  
         clrb  
         tfr   d,x
         tfr   d,u
         lda   <DevPath
         os9   I$Seek   	Seek to LSN0
         puls  u		added for OS-9 Level One +BGP+
         leax  LSN0Buff,u	Point to our LSN buffer
         ldy   #DD.DAT
         lda   <DevPath
         os9   I$Write  	Write to disk
         bcs   Bye		branch if error
         rts

L0473    leax  >Help,pcr
L0477    pshs  b
         lda   #$02
         ldy   #256
         os9   I$WritLn 
         comb  
         puls  b
Bye      os9   F$Exit   

IsFragd  leax  >BootFrag,pcr
         clrb  
         bra   L0477

WriteBad leax  >WritErr,pcr
         clrb  
         bra   L0477

TrkAlloc leax  >FileWarn,pcr
         clrb  
         bra   L0477

         ifgt  Level-1
NoRel    leax  >RelMsg,pcr
         bra   L0477
         endc

         emod
eom      equ   *
         end
