********************************************************************
* OS9Gen - OS-9 bootfile generator
*
* $Id$
*
* Ed.    Comments                                       Who YY/MM/DD
* ------------------------------------------------------------------
*   9    From OS-9 Level Two Vr. 2.00.01

         nam   OS9gen
         ttl   OS-9 bootfile generator

* Disassembled 02/07/06 13:11:11 by Disasm v1.6 (C) 1988 by RML

         IFP1
         use   defsfile
         use   rbfdefs
         ENDC

DOHELP   set   0
BTrack   set   34

tylg     set   Prgrm+Objct   
atrv     set   ReEnt+rev
rev      set   $01
edition  set   9

os9l1start equ $EF00
os9l1size  equ $0F80

         mod   eom,name,tylg,atrv,start,size

         org   0
statptr  rmb   2
bfpath   rmb   1
devpath  rmb   1
parmpath rmb   1
u0005    rmb   1
u0006    rmb   2
u0008    rmb   1
u0009    rmb   2
u000B    rmb   2
u000D    rmb   2
u000F    rmb   2
u0011    rmb   2
u0013    rmb   2
u0015    rmb   2
u0017    rmb   7
devopts  rmb   20
u0032    rmb   2
u0034    rmb   10
u003E    rmb   2
sngldrv  rmb   1
u0041    rmb   32
lsn0     rmb   16
u0071    rmb   10
u007B    rmb   2
u007D    rmb   1
sectbuff rmb   1024
u047E    rmb   16
u048E    rmb   1
u048F    rmb   7
u0496    rmb   7018
size     equ   .

name     fcs   /OS9gen/
         fcb   edition

         IFNE  DOHELP
HelpMsg  fcb   C$LF
         fcc   "Use (CAUTION): OS9GEN </devname> [-s]"
         fcb   C$LF
         fcc   " ..reads (std input) pathnames until EOF,"
         fcb   C$LF
         fcc   "   merging paths into New OS9Boot file."
         fcb   C$LF
         fcc   " -s = single drive operation"
         fcb   C$LF,C$CR
         ENDC
         fcc   "Can't find: "
ErrWrit  fcb   C$LF
         fcc   "Error writing kernel track"
         fcb   C$CR
HDGen    fcb   C$LF
         fcc   "Error - cannot gen to hard disk"
         fcb   C$CR
         IFGT  Level-1
CantRel  fcb   C$LF
         fcc   "Error - can't link to Rel module"
         fcb   C$CR
         ENDC
CarRet   fcb   C$CR
TheBell  fcb   C$BELL
TWarn    fcb   C$LF
         fcc   "Warning - file(s) present"
         fcb   C$LF
         fcc   "on track "
         IFEQ  BTrack-34
         fcc   "34"
         ELSE
         fcc   "??"
         ENDC
         fcc   " - this track"
         fcb   C$LF
         fcc   "not rewritten."
         fcb   C$CR
BootFrag fcb   C$LF
         fcc   "Error - OS9boot file fragmented"
         fcb   C$CR
Source   fcc   "Ready SOURCE,      hit C to continue: "
SourceL  equ   *-Source
Destin   fcc   "Ready DESTINATION, hit C to continue: "
DestinL  equ   *-Destin
Rename   fcc   "RENAME "
TempBoot fcc   "TempBoot "
         fcb   $FF 
OS9Boot  fcc   "OS9Boot"
         fcb   C$CR
         fcb   $FF 
         IFGT  Level-1
TheRel   fcc   "Rel"
         fcb   $FF 
         ENDC

start    clrb  
         stb   <u0005
         stb   <sngldrv		assume multi-drive
         stu   <statptr
         leas  >u047E,u
         pshs  u
         tfr   y,d
         subd  ,s++
         subd  #$047E
         clrb  
         std   <u0011
         lda   #PDELIM
         cmpa  ,x
         lbne  BadName
         os9   F$PrsNam 
         lbcs  ShowHelp
         lda   #PDELIM
         cmpa  ,y
         lbeq  BadName
         pshs  b,a
L0216    lda   ,y+
         cmpa  #'-
         beq   L0222
         cmpa  #C$CR
         beq   L0234
         bra   L0216
L0222    ldd   ,y+
         eora  #'S
         anda  #$DF
         lbne  SoftExit
         cmpb  #$30
         lbcc  SoftExit
         inc   <sngldrv		set single drive flag
L0234    puls  b,a
         leay  <u0041,u
L0239    sta   ,y+
         lda   ,x+
         decb  
         bpl   L0239
         sty   <u003E
         lda   #PENTIR
         ldb   #C$SPAC
         std   ,y++
         lbsr  GetDest
         leax  <u0041,u
         lda   #UPDAT.
         os9   I$Open   
         sta   <devpath
         lbcs  ShowHelp
         leax  <devopts,u
         ldb   #SS.Opt
         os9   I$GetStt 
         lbcs  Bye
         leax  <devopts,u
         lda   <(PD.TYP-PD.OPT)+devopts,u	get type byte
         bpl   L0276			branch if not hard drive
         clrb  
         leax  >HDGen,pcr		else tell user can't do hard drive
         lbra  WritExit
L0276    ldx   <u003E
         leay  >TempBoot,pcr
         lda   #PDELIM
L027E    sta   ,x+
         lda   ,y+
         bpl   L027E
* Copy OS9Boot string to buffer
         leay  >OS9Boot,pcr
L0288    lda   ,y+
         sta   ,x+
         bpl   L0288
         tfr   x,d
         leax  <u0041,u
         pshs  x
         subd  ,s++
         std   <u000D
         lda   #WRITE.
         ldb   #READ.+WRITE.
         os9   I$Create 
         sta   <bfpath
         lbcs  Bye
         ldx   #$0000
         stx   <u0006
         ldu   #$3000
         ldb   #SS.Size
         os9   I$SetStt 
         lbcs  Bye
         ldu   <statptr
         bsr   L032F
L02BB    leax  <sectbuff,u
         ldy   #256
         clra  				standard input
         os9   I$ReadLn 		read line
         bcs   L0312			branch if error
         lda   ,x			else get byte in A
         ldb   #E$EOF			and EOF error in B
         cmpa  #C$CR			CR?
         beq   L0312			branch if so
         cmpa  #'*			comment?
         beq   L02BB			continue reading if so
         lda   #READ.			else use read perms
         os9   I$Open   		open file at X (line we read)
         bcs   L031A			branch if error
         sta   <parmpath		save path
L02DD    ldx   <u0015
         ldd   <u0011
         subd  <u0013
         tfr   d,y
         lda   <parmpath
         os9   I$Read   
         bcc   L02F9
         cmpb  #E$EOF
         lbne  Bye
         os9   I$Close  
         clr   <parmpath
         bra   L02BB
L02F9    tfr   y,d
         leax  d,x
         stx   <u0015
         addd  <u0013
         std   <u0013
         cmpd  <u0011
         bcs   L030C
         bsr   L032B
         bcs   L0328
L030C    tst   <parmpath
         bne   L02DD
         bra   L02BB
L0312    cmpb  #E$EOF			end of file?
         bne   L0328			branch if not
         bsr   L033D
         bra   L0377
L031A    pshs  b
         leax  <sectbuff,u
         ldy   #256
         lda   #$02			standard error
         os9   I$WritLn 		write
L0328    lbra  Bye
L032B    bsr   L033D
         bcs   L033C
L032F    lbsr  GetSrc
         clra  
         clrb  
         std   <u0013
         leax  >u047E,u
         stx   <u0015
L033C    rts   
L033D    lbsr  GetDest
         ldd   <u0013
         beq   L033C
         tst   <sngldrv		single drive?
         beq   L0361		branch if not
         lda   <devpath
         ldx   #$0000
         ldu   #$0000
         os9   I$Seek   	seek to LSN0
         ldu   <statptr		+BGP+ added
         bcs   L033C
         leax  <sectbuff,u
         ldy   #256
         os9   I$Read   	read LSN0
         bcs   L033C
L0361    lda   <bfpath
         leax  >u047E,u
         ldy   <u0013
         os9   I$Write  
         bcs   L033C
         tfr   y,d
         addd  <u0006
         std   <u0006
         clrb  
         rts   
L0377    leax  <devopts,u
         ldb   #SS.Opt
         lda   <bfpath
         os9   I$GetStt 
         lbcs  Bye
         lda   <bfpath
         ldx   #$0000
         ldu   <u0006
         ldb   #SS.Size
         os9   I$SetStt 
         lbcs  Bye
         ldu   <statptr
         os9   I$Close  
         lbcs  ShowHelp
         ldx   <u0032,u
         lda   <u0034,u
         clrb  
         tfr   d,u
         lda   <devpath
         os9   I$Seek   
         ldu   <statptr
         lbcs  Bye
         leax  >u047E,u
         ldy   #256
         os9   I$Read   
         lbcs  Bye
         ldd   >u047E+(FD.SEG+FDSL.S+FDSL.B),u
         lbne  ItsFragd		if not zero, file is fragmented
         lda   <devpath
         ldx   #$0000
         ldu   #DD.BT
         os9   I$Seek   	seek to DD.BT
         ldu   <statptr
         lbcs  Bye
         leax  u0008,u
         ldy   #DD.DAT-DD.BT
         os9   I$Read   	read bootstrap sector and bootfile size
         lbcs  Bye
         ldd   <u000B
         beq   L040D
         ldx   <u003E
         leay  >OS9Boot,pcr
         lda   #PDELIM
L03F3    sta   ,x+
         lda   ,y+
         bpl   L03F3
         leax  <u0041,u
         os9   I$Delete 
         ldx   <u003E
         leay  >TempBoot,pcr
         lda   #PDELIM
L0407    sta   ,x+
         lda   ,y+
         bpl   L0407
L040D    tst   <sngldrv
         beq   L042E
         clra  
         leax  >Rename,pcr
         os9   F$Link   
         bcc   L0428
         lbsr  GetSrc
         os9   F$Load   
         lbcs  Bye
         lbsr  GetDest
L0428    tfr   u,d
         ldu   <statptr
         std   u000F,u
L042E    lda   #$01
         clrb  
         leax  >Rename,pcr
         ldy   <u000D
         leau  <u0041,u
         os9   F$Fork   
         lbcs  Bye
         os9   F$Wait   
         lbcs  Bye
         tstb  
         lbne  Bye
         tst   <sngldrv
         beq   L045F
         ldu   <statptr
         ldd   u000F,u
         tfr   d,u
         os9   F$UnLink 
         lbcs  Bye
L045F    ldu   <statptr
         ldb   >u048E,u
         stb   <u0008
         ldd   >u048F,u
         std   <u0009
         ldd   <u0006
         std   <u000B
         ldx   #$0000
         ldu   #DD.BT
         lda   <devpath
         os9   I$Seek   
         ldu   <statptr
         lbcs  Bye
         leax  u0008,u
         ldy   #DD.DAT-DD.BT
         os9   I$Write  
         lbcs  Bye
         pshs  u
         clra  
         clrb  
         tfr   d,x
         tfr   d,u
         lda   <devpath
         os9   I$Seek   	seek to LSN0
         lbcs  Bye
         puls  u
         leax  <lsn0,u
         ldy   #DD.DAT
         lda   <devpath
         os9   I$Read   	read first part of LSN0
         lbcs  Bye
         lda   #$00
         ldb   #$01
         lbsr  Seek2LSN
         leax  <sectbuff,u
         ldy   <lsn0+DD.MAP,u	get number of bytes in device's bitmap
         lda   <devpath
         os9   I$Read   
         lbcs  Bye
         lda   #BTrack		boot track
         clrb  			sector 1
         ldy   #$0004		four bits
         lbsr  ABMClear
         bcc   L0520
         lda   #BTrack		boot track
         ldb   #$00		sector 1
         lbsr  Seek2LSN		seek to it
         leax  <u0017,u
         ldy   #$0007
         lda   <devpath
         os9   I$Read   	read first seven bytes of boot track
         lbcs  Bye
         leax  <u0017,u
         ldd   ,x
         cmpa  #'O
         lbne  WarnUser
         cmpb  #'S
         lbne  WarnUser
         lda   $04,x
         cmpa  #$12
         beq   L0512
         lda   #BTrack		boot track
         ldb   #15		sector 16
         ldy   #$0003		sectors 16-18
         lbsr  ABMClear
         lbcs  WarnUser
L0512    clra  
         ldb   <lsn0+DD.TKS,u	get number of tracks in D
         tfr   d,y
         lda   #BTrack		boot track
         clrb  			sector 1
         lbsr  ABMSet
         bra   L0531
L0520    lda   #BTrack		boot track
         ldb   #$04		sector 5
         ldy   #$000E		sectors 5-18
         lbsr  ABMClear
         lbcs  WarnUser
         bra   L0512

L0531    clra  
         ldb   #$01
         lbsr  Seek2LSN
         leax  <sectbuff,u
         ldy   <lsn0+DD.MAP,u	get number of bytes in device's bitmap
         lda   <devpath
         os9   I$Write  	write out the bitmap
         lbcs  Bye

         IFGT  Level-1
* OS-9 Level Two: Link to Rel, which brings in boot code
         pshs  u
         lda   #Systm+Objct
         leax  >TheRel,pcr
         os9   F$Link   
         lbcs  L0724
         tfr   u,d
         puls  u
         subd  #$0006
         std   <u007B,u
         lda   #$E0
         anda  <u007B,u
         ora   #$1E
         ldb   #$FF
         subd  <u007B,u
         addd  #$0001
         tfr   d,y
         lda   #BTrack		boot track
         ldb   #$00		sector 1
         lbsr  Seek2LSN
         lda   <devpath
         ldx   <u007B,u

         ELSE

* OS-9 Level One: Write out boot track data
         lda   #BTrack		boot track
         ldb   #$00		sector 1
         lbsr  Seek2LSN
         lda   <devpath
         ldx   #os9l1start
         ldy   #os9l1size

         ENDC

         os9   I$Write  
         lbcs  WriteErr
         os9   I$Close  
         lbcs  Bye
         clrb  
         lbra  Bye

* Convert Track/Sector to absolute LSN
* Entry: A = track, B = sector
* Returns in D
AbsLSN   pshs  b
         ldb   <lsn0+DD.FMT,u	get format byte
         andb  #FMT.SIDE	test sides bit
         beq   L059C		branch if 1
         ldb   #$02		else 2 sides
         bra   L059E
L059C    ldb   #$01		1 side
L059E    mul   			multiply sides times track
         lda   <lsn0+DD.TKS,u	get device tracks
         mul   			multiply by (sides * track)
         addb  ,s		add in sector
         adca  #$00
         leas  $01,s
         rts   

* Bitmap conversion from bit to byte
* Entry: X = pointer to bitmap
*        D = bit
* Exit:  A = bit mask
*        X = pointer to byte represented by bit D
L05AA    pshs  y,b
         lsra  		divide D by 8
         rorb  
         lsra  
         rorb  
         lsra  
         rorb  
         leax  d,x
         puls  b
         leay  <BitMask,pcr
         andb  #$07
         lda   b,y
         puls  pc,y

BitMask  fcb   $80,$40,$20,$10,$08,$04,$02,$01

* Clear bits in the allocation bitmap
* Entry: A = Track, B = Sector, Y = number of bits to clear
ABMClear pshs  x,y,b,a
         bsr   AbsLSN		convert A:B to LSN
         leax  <sectbuff,u
         bsr   L05AA
         sta   ,-s
         bmi   L05EA
L05D3    lda   ,x		get byte in bitmap
         sta   <u007D,u
L05D9    anda  ,s		and with byte on stack
         bne   L0616
         leay  -1,y
         beq   L0612
         lda   <u007D,u
         lsr   ,s
         bcc   L05D9
         leax  $01,x
L05EA    lda   #$FF
         sta   ,s
         bra   L05FA
L05F0    lda   ,x
         anda  ,s
         bne   L0616
         leax  $01,x
         leay  -$08,y
L05FA    cmpy  #$0008
         bhi   L05F0
         beq   L060C
         lda   ,s
L0604    lsra  
         leay  -$01,y
         bne   L0604
         coma  
         sta   ,s
L060C    lda   ,x
         anda  ,s
         bne   L0616
L0612    andcc #^Carry
         bra   L0618
L0616    orcc  #Carry
L0618    leas  $01,s
         puls  pc,y,x,b,a

* Set bits in the allocation bitmap
* Entry: A = Track, B = Sector, Y = number of bits to set
ABMSet   pshs  y,x,b,a
         lbsr  AbsLSN
         leax  <sectbuff,u
         bsr   L05AA
         sta   ,-s
         bmi   L063A
         lda   ,x
L062C    ora   ,s
         leay  -$01,y
         beq   L0658
         lsr   ,s
         bcc   L062C
         sta   ,x
         leax  $01,x
L063A    lda   #$FF
         bra   L0644
L063E    sta   ,x
         leax  $01,x
         leay  -$08,y
L0644    cmpy  #$0008
         bhi   L063E
         beq   L0658
L064C    lsra  
         leay  -$01,y
         bne   L064C
         coma  
         sta   ,s
         lda   ,x
         ora   ,s
L0658    sta   ,x
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
         lda   <devpath
         os9   I$Seek   
         lbcs  WriteErr
         puls  pc,u,y,x,b,a

         clra  
         clrb  
         tfr   d,x
         tfr   d,u
         lda   <devpath
         os9   I$Seek   
         leax  <lsn0,u
         ldy   #DD.DAT
         lda   <devpath
         os9   I$Write  
         bcs   Bye
         rts   

* Routine to write various error messages then exiting
WriteErr leax  >ErrWrit,pcr
         bra   WritExit
BadName  ldb   #E$BPNam
ShowHelp equ   *
         IFNE  DOHELP
         leax  >HelpMsg,pcr
         ELSE
         clrb
         bra   Bye
         ENDC
WritExit pshs  b
         lda   #$02
         ldy   #256
         os9   I$WritLn 
         puls  b
Bye      os9   F$Exit   

* Source/Destination Disk Switch Routine
GetSrc   pshs  u,y,x,b,a
         clra  
         bra   TstSingl
GetDest  pshs  u,y,x,b,a
         lda   #$01
TstSingl tst   <sngldrv
         beq   L06FD
AskUser  pshs  a
         tsta  
         bne   Ask4Dst
Ask4Src  leax  >Source,pcr
         ldy   #SourceL
         bra   L06D4
Ask4Dst  leax  >Destin,pcr
         ldy   #DestinL
L06D4    bsr   DoWrite
         leax  ,-s
         ldy   #$0001
         lda   #$02		read from stderr
         os9   I$Read   	read one char
         lda   ,s+
         eora  #'C
         anda  #$DF
         beq   L06F9		branch if it's a C
         leax  >TheBell,pcr
         ldy   #$0001
         bsr   DoWrite		else ring the error bell
         bsr   WriteCR
         puls  a
         bne   AskUser
L06F9    bsr   WriteCR
         puls  a
L06FD    puls  pc,u,y,x,b,a

DoWrite  lda   #$01
         os9   I$WritLn 
         rts   

WriteCR  pshs  y,x,a
         lda   #$01
         leax  >CarRet,pcr
         ldy   #80
         os9   I$WritLn 
         puls  pc,y,x,a

ItsFragd leax  >BootFrag,pcr
SoftExit ldb   #$01
         bra   WritExit
WarnUser leax  >TWarn,pcr
         bra   SoftExit

         IFGT  Level-1
L0724    leax  >CantRel,pcr
         lbra  WritExit
         ENDC

         emod
eom      equ   *
         end
