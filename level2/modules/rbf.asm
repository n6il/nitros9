********************************************************************
* RBF - Random Block File Manager
*
* $Id$
*
* Ed.    Comments                                       Who YY/MM/DD
* ------------------------------------------------------------------
*        NitrOS-9 2.00 distribution                         ??/??/??
*  35    Fixed FD.SEG bug                               GH  ??/??/??

         nam   RBF
         ttl   Random Block File Manager

         ifp1  
         use   defsfile
         use   rbfdefs
         endc  

rev      set   $01
ty       set   FlMgr
         IFNE  H6309
lg       set   Obj6309
         ELSE
lg       set   Objct
         ENDC
tylg     set   ty+lg
atrv     set   ReEnt+rev
edition  set   35

         org   $00
size     equ   .

         mod   eom,name,tylg,atrv,start,size

name     fcs   /RBF/
         fcb   edition

L0012    fcb   $26

start    bra   Create
         nop   
         lbra  Open
         lbra  MakDir
         lbra  ChgDir
         lbra  Delete
         lbra  Seek
         lbra  Read
         lbra  Write
         lbra  ReadLn
         lbra  WriteLn
         lbra  GetStat
         lbra  SetStat
         lbra  Close

************
* Create, according to the book, needs
* A=access mode desired
* B=file attributes
* X=address of the pathlist
*  Exits with
*  A=pathnum
*  X=last byte of pathlist address
* if error
*  CC.C set
*  B=errcode
Create   pshs  y          ptr to descriptor
         leas  -$05,s
         IFNE  H6309
         aim   #^DIR.,R$B,u
         ELSE
         lda   R$B,u
         anda  #^DIR.
         sta   R$B,u
         ENDC
         lbsr  FindFile
         bcs   Creat47    carry=not found
         ldb   #E$CEF     else exists error
Creat47  cmpb  #E$PNNF    not found?
         bne   Creat7E
         cmpa  #'/        full path?
         beq   Creat7E    yes, go
         pshs  x
         ldx   PD.RGS,y
         stu   R$X,x
         ldb   PD.SBP,y   these 4 did have < in front
         ldx   PD.SBP+1,y made 3 byte cmnds but some are 2!
         lda   PD.SSZ,y
         ldu   PD.SSZ+1,y
         pshs  u,x,b,a
         ldx   PD.RGS,y
         lda   R$A,x
         clrb  
         anda  #PEXEC.    $20
         beq   Creat6E
         ldd   R$Y,x
Creat6E  addd  #1         bug fix, thanks Gene K.
         bcc   Creat75
         ldd   #$FFFF
Creat75  lbsr  FatScan
         bcc   Creat83
         leas  6,s
Creat7C  leas  2,s
Creat7E  leas  5,s
         lbra  ErMemRtn

Creat83  std   $0B,s      sectors alloc'd
         ldb   PD.SBP,y
         ldx   PD.SBP+1,y starting LSN
         stb   $08,s
         stx   $09,s
         puls  u,x,b,a
         stb   PD.SBP,y
         stx   PD.SBP+1,y
         sta   PD.SSZ,y
         stu   PD.SSZ+1,y
         IFNE  H6309
         ldq   PD.DCP,y
         stq   PD.CP,y
         ELSE
         ldd   PD.DCP,y
         std   PD.CP,y
         ldd   PD.DCP+2,y
         std   PD.CP+2,y
         ENDC
         lbsr  L0957      find start of dir
         bcs   CreatB5
CreatAC  tst   ,x         empty slot?
         beq   CreatC7    empty spot, go
         lbsr  L0942      else get next slot
         bcc   CreatAC
CreatB5  cmpb  #E$EOF
         bne   Creat7C    some other error
         ldd   #DIR.SZ
         lbsr  Writ599    extend dir by $20
         bcs   Creat7C    out of alloc?
         lbsr  MDir263
         lbsr  L0957
CreatC7  leau  ,x
         lbsr  Creat169
         puls  x
         os9   F$PrsNam
         bcs   Creat7E
         cmpb  #29
         bls   CreatD9
         ldb   #29
CreatD9  clra  
         tfr   d,y
         lbsr  Writ5CB
         tfr   y,d
         ldy   $05,s
         decb  
         IFNE  H6309
         oim   #$80,b,u
         ELSE
         lda   b,u
         ora   #$80
         sta   b,u
         ENDC
         ldb   ,s
         ldx   $01,s
         stb   DIR.FD,u
         stx   DIR.FD+1,u
         lbsr  L1205
         bcs   Creat151
         ldu   PD.BUF,y
         bsr   Creat170
         lda   #FDBUF
         sta   PD.SMF,y
         ldx   PD.RGS,y
         lda   R$B,x
         sta   ,u
         ldx   <D.Proc
         ldd   P$User,x
         std   FD.OWN,u
         lbsr  L02D1
         ldd   FD.DAT,u
         std   FD.Creat,u
         ldb   FD.DAT+2,u
         stb   FD.Creat+2,u
         ldb   #$01
         stb   FD.LNK,u
         ldd   3,s
         IFNE  H6309
         decd  
         ELSE
         subd  #$0001
         ENDC
         beq   Creat131
         leax  FD.SEG,u
         std   FDSL.B,x
         ldd   1,s
         addd  #1         bug fix, thanks Gene K.
         std   FDSL.A+1,x
         ldb   ,s
         adcb  #$00       need carry status of addd
         stb   FDSL.A,x
Creat131 ldb   ,s
         ldx   1,s
         lbsr  L1207
         bcs   Creat151
         lbsr  L0A90
         stb   PD.FD,y
         stx   PD.FD+1,y
         lbsr  L0A2A
         leas  $05,s
         ldx   PD.Exten,y
         lda   #EofLock
         sta   PE.Lock,x
         bra   Open1CC
Creat151 puls  u,x,a
         sta   PD.SBP,y
         stx   PD.SBP+1,y
         clr   PD.SSZ,y
         stu   PD.SSZ+1,y
         pshs  b
         lbsr  ClrFBits
         puls  b
RtnMemry lbra  ErMemRtn

* clear a dir entry
Creat169 
         IFNE  H6309
         ldw   #DIR.SZ    zeroing a dir entry before use
         ELSE
         ldb   #DIR.SZ    zeroing a dir entry before use
         ENDC
         bra   Creat174

* clear a sector buffer
Creat170 
         IFNE  H6309
         ldw   #$0100     zeroing a sector before use
         ELSE
         clrb
         ENDC
Creat174 pshs  u,x
         IFNE  H6309
         leax  <Creat170+3,pcr
         tfm   x,u+
         ELSE
l1       clr   ,u+
         decb
         bne   l1 
         ENDC
         puls  pc,u,x

Open     pshs  y
         lbsr  FindFile
         bcs   RtnMemry   and to ErMemRtn
         ldu   PD.RGS,y
         stx   R$X,u
         ldd   PD.FD+1,y
         bne   Open1BB
         lda   PD.FD,y
         bne   Open1BB

* File Descr doesn't exist
         ldb   PD.MOD,y
         andb  #DIR.
         lbne  Clos29D    oops, is dir, go
         std   PD.SBP,y   regs.a zeroed above
         sta   PD.SBP+2,y
         std   PD.SBL,y
         sta   PD.SBL+2,y
         ldx   PD.DTB,y
         lda   DD.TOT+2,x
         std   PD.SIZ+2,y
         sta   PD.SSZ+2,y
         ldd   DD.TOT,x
         std   PD.SIZ,y
         std   PD.SSZ,y
         puls  pc,y

Open1BB  lda   PD.MOD,y
         lbsr  ChkAttrs
         bcs   RtnMemry
         bita  #WRITE.
         beq   Open1CC
         lbsr  L02D1
         lbsr  L11FD
Open1CC  puls  y

Open1CE  
         IFNE  H6309
         clrd  
         ELSE
         clra  
         clrb  
         ENDC
         std   PD.CP+2,y  to orig
         std   PD.CP,y
         std   PD.SBL,y
         sta   PD.SBL+2,y
         sta   PD.SSZ,y
         lda   FD.ATT,u
         sta   PD.ATT,y
         ldd   FD.SEG,u
         std   PD.SBP,y
         lda   FD.SEG+2,u
         sta   PD.SBP+2,y
         ldd   FD.SEG+FDSL.B,u
         std   PD.SSZ+1,y
         ldd   FD.SIZ,u
         ldx   FD.SIZ+2,u
         ldu   PD.Exten,y
         cmpu  PE.Confl,u
         beq   Open209
         ldu   PE.Confl,u
         ldu   PE.PDptr,u
         ldd   PD.SIZ,u
         ldx   PD.SIZ+2,u
Open209  std   PD.SIZ,y
         stx   PD.SIZ+2,y
         clr   PD.SMF,y
         rts   

* Makedir entry point
MakDir   lbsr  Create
         bcs   MDir261
         lda   PD.ATT,y
         ora   #SHARE.
         lbsr  ChkAttrs
         bcs   MDir261
         ldd   #DIR.SZ*2
         std   PD.SIZ+2,y
         bsr   MDir273
         bcs   MDir261
         lbsr  L0C6F
         bcs   MDir261
         lbsr  RdFlDscr
         ldu   PD.BUF,y
         IFNE  H6309
         oim   #DIR.,FD.ATT,u
         ELSE
         lda   FD.ATT,u
         ora   #DIR.
         sta   FD.ATT,u
         ENDC
         bsr   MDir266
         bcs   MDir261
         lbsr  Creat170
         ldd   #$2EAE     ..
         std   ,u
         stb   DIR.SZ,u
         lda   PD.DFD,y
         sta   DIR.FD,u
         ldd   PD.DFD+1,y
         std   DIR.FD+1,u
         lda   PD.FD,y
         sta   DIR.SZ+DIR.FD,u
         ldd   PD.FD+1,y
         std   DIR.SZ+DIR.FD+1,u
         lbsr  L1205
MDir261  bra   Rt100Mem

* set new file size in descriptor
MDir263  lbsr  RdFlDscr
MDir266  ldx   PD.BUF,y
         IFNE  H6309
         ldq   PD.SIZ,y
         stq   FD.SIZ,x
         ELSE
         ldd   PD.SIZ,y
         std   FD.SIZ,x
         ldd   PD.SIZ+2,y
         std   FD.SIZ+2,x
         ENDC
         clr   PD.SMF,y
MDir273  lbra  L11FD

Close    clra  
         tst   PD.CNT,y
         bne   Clos29C
         lbsr  L1237
         bcs   Rt100Mem
         ldb   PD.MOD,y
         bitb  #WRITE.
         beq   Rt100Mem
         ldd   PD.FD,y
         bne   Clos290
         lda   PD.FD+2,y
         beq   Rt100Mem
Clos290  bsr   MDir263
         lbsr  Gst5E5
         bcc   Rt100Mem
         lbsr  L0EFE
         bra   Rt100Mem
Clos29C  rts   


Clos29D  ldb   #E$FNA
ErMemRtn coma  
Clos2A0  puls  y

* generalized return to system
Rt100Mem pshs  b,cc
         ldu   PD.BUF,y
         beq   RtMem2CF
         ldd   #$0100
         os9   F$SRtMem
         ldx   PD.Exten,y
         beq   RtMem2CF
         lbsr  L0A90
         lda   PE.PE,x
         ldx   <D.PthDBT
         os9   F$Ret64
RtMem2CF puls  pc,b,cc


L02D1    lbsr  RdFlDscr
         ldu   PD.BUF,y
         lda   FD.LNK,u
         ldx   <D.Proc
         pshs  x,a
         ldx   <D.SysPrc
         stx   <D.Proc
         leax  FD.DAT,u
         os9   F$Time
         puls  x,a        backar is GONE!
         stx   <D.Proc
         sta   FD.LNK,u
         rts   


ChgDir   pshs  y
         IFNE  H6309
         oim   #$80,PD.MOD,y
         ELSE
         lda   PD.MOD,y
         ora   #$80
         sta   PD.MOD,y
         ENDC
         lbsr  Open
         bcs   Clos2A0
         ldx   <D.Proc
         ldu   PD.FD+1,y
         ldb   PD.MOD,y
         bitb  #UPDAT.
         beq   CD30D

* change current data dir
         ldb   PD.FD,y
         stb   P$DIO+3,x
         stu   P$DIO+4,x
CD30D    ldb   PD.MOD,y
         bitb  #EXEC.
         beq   CD31C

* change current exec dir
         ldb   PD.FD,y
         stb   P$DIO+9,x
         stu   P$DIO+10,x
CD31C    clrb  
         bra   Clos2A0

Delete   pshs  y
         lbsr  FindFile
         bcs   Clos2A0
         ldd   PD.FD+1,y
         bne   Del332
         tst   PD.FD,y
         IFNE  H6309
         beq   Clos29D
         ELSE
         lbeq  Clos29D
         ENDC
Del332   lda   #SHARE.+WRITE.
         lbsr  ChkAttrs
         lbcs  Clos2A0
         ldu   PD.RGS,y
         stx   R$X,u
         lbsr  RdFlDscr
         lbcs  Del3D4
         ldx   PD.BUF,y
         dec   FD.LNK,x
         beq   Del358
         lbsr  L11FD
         pshs  u,x,b
         IFNE  H6309
         clrd  
         ELSE
         clra  
         clrb  
         ENDC
         std   $03,s
         bra   Del39F
Del358   ldb   PD.FD,y
         ldx   PD.FD+1,y
         pshs  u,x,b
         ldd   #$0100
         os9   F$SRqMem
         bcc   Del36C
         IFNE  H6309
         clrd  
         ELSE
         clra  
         clrb  
         ENDC
         bra   Del37A
Del36C   stu   $03,s
         ldx   PD.BUF,y
         IFNE  H6309
         ldw   #$0100
         tfm   x+,u+
         ELSE
         clrb
DelLoop  lda   ,x+
         sta   ,u+
         decb
         bne   DelLoop
         ENDC
         ldd   $03,s
Del37A   std   $03,s
         IFNE  H6309
         clrd  
         ELSE
         clra  
         clrb  
         ENDC
         std   PD.SIZ,y
         std   PD.SIZ+2,y
         lbsr  L0EFE
         bcs   Del3EF
         ldb   PD.FD,y
         ldx   PD.FD+1,y
         stb   PD.SBP,y
         stx   PD.SBP+1,y
         ldx   PD.BUF,y
* my problem with this fix from rbf28 is in proveing to me
* $13,x is the correct location to read! I can't seem to find
* the defines to match the $13,x address -GH
         ldd   <$13,x     this code is REQUIRED for multiple
         IFNE  H6309
         incd             sector/cluster operation, don't remove!
         ELSE
         addd  #$0001 sector cluster operation, DO NOT REMOVE!
         ENDC
         std   PD.SSZ+1,y
         lbsr  ClrFBits
Del39F   bcs   Del3EF
         lbsr  L1237
         lbsr  L0A90
         lda   PD.DFD,y
         sta   PD.FD,y
         ldd   PD.DFD+1,y
         std   PD.FD+1,y
         lbsr  RdFlDscr
         bcs   Del3EF
         lbsr  L0A2A
         ldu   PD.BUF,y
         lbsr  Open1CE
         IFNE  H6309
         ldq   PD.DCP,y
         stq   PD.CP,y
         ELSE
         ldd   PD.DCP,y
         std   PD.CP,y
         ldd   PD.DCP+2,y
         std   PD.CP+2,y
         ENDC
         lbsr  L0957
         bcs   Del3EF
         clr   ,x
         lbsr  L1205
Del3D4   ldu   $03,s
* the patch at Del3EF-3F9 munged the stack for this one - GH
         beq   Del3F9
         ldb   ,s
         ldx   $01,s
         stb   PD.FD,y
         stx   PD.FD+1,y
         ldx   PD.BUF,y
         stx   1,s
         stu   PD.BUF,y
         lbsr  L11FD
         ldu   1,s
         stu   PD.BUF,y
Del3EF   pshs  b,cc       raises stack offsets +2
         ldu   $05,s      this was a 3
         beq   Del3F5     different, new label! no mem to return
         ldd   #$0100
         os9   F$SRtMem
Del3F5   puls  b,cc
Del3F9   leas  5,s
         lbra  Clos2A0

* Seek entry
Seek     ldb   PD.SMF,y
         bitb  #SINBUF
         beq   Seek417
         lda   R$X+1,u
         ldb   R$U,u
         subd  PD.CP+1,y
         bne   Seek412
         lda   R$X,u
         sbca  PD.CP,y
         beq   Seek41B
Seek412  lbsr  L1237
         bcs   Seek41F
Seek417  ldd   R$X,u
         std   PD.CP,y
Seek41B  ldd   R$U,u
         std   PD.CP+2,y
Seek41F  rts   

ReadLn   bsr   RdLn463
         beq   RdLn446
         bsr   RdLn447
         pshs  u,y,x,b,a
         exg   x,u
         IFNE  H6309
         tfr   0,y
         ELSE
         ldy   #$0000
         ENDC
         lda   #$0D
RdLn430  leay  1,y
         cmpa  ,x+
         beq   RdLn439
         decb  
         bne   RdLn430
RdLn439  ldx   6,s
         bsr   RdLn49B
         sty   $0A,s
         puls  u,y,x,b,a
         ldd   $02,s
         leax  d,x
RdLn446  rts   

RdLn447  lbsr  Read4D3
         leax  -1,x
         lbsr  L097F
         cmpa  #$0D
         beq   RdLn459
         ldd   $02,s
         bne   Read4D9
RdLn459  ldu   PD.RGS,y
         ldd   R$Y,u
         subd  $02,s
         std   R$Y,u
         bra   Read4C0

RdLn463  ldd   R$Y,u
         lbsr  L0B0C
         bcs   RdLn497
         ldd   R$Y,u
         bsr   RdLn473
         bcs   RdLn497
         std   R$Y,u
         rts   

RdLn473  pshs  d
         IFNE  H6309
         ldq   PD.SIZ,y   puts 3-4 bytes in w, not x
         subw  PD.CP+2,y
         tfr   w,x        save it in the old register
         sbcd  PD.CP,y
         ELSE
         ldd   PD.SIZ+2,y
         subd  PD.CP+2,y
         tfr   d,x
         ldd   PD.SIZ,y
         sbcb  PD.CP+1,y
         sbca  PD.CP,y
         ENDC
         bcs   RdLn494
         bne   RdLn491
         tstb  
         bne   RdLn491

         cmpx  ,s         we saved in x, use it
         bhs   RdLn491
         stx   ,s         ditto
         beq   RdLn494
RdLn491  clrb  
         puls  pc,b,a
RdLn494  comb  
         ldb   #E$EOF
RdLn497  leas  $02,s
         bra   Read4C5
RdLn49B  pshs  x
         ldx   <D.Proc
         lda   <D.SysTsk
         ldb   P$Task,x
         puls  x
         os9   F$Move
         rts   

Read     bsr   RdLn463
         beq   Read4BB
         bsr   Read4BC
Read4AF  pshs  u,y,x,b,a
         exg   x,u
         tfr   d,y
         bsr   RdLn49B
         puls  u,y,x,b,a
         leax  d,x        back to leax from addr here
Read4BB  rts   

Read4BC  bsr   Read4D3
         bne   Read4D9
Read4C0  clrb  
Read4C1  leas  -2,s
Read4C3  leas  $0A,s

Read4C5  pshs  b,cc
         lda   PD.MOD,y
         bita  #WRITE.
         bne   Read4D0
         lbsr  L0B02
Read4D0  puls  b,cc,pc

Read4D3  ldd   R$X,u
         ldx   R$Y,u
         pshs  x,b,a
Read4D9  lda   PD.SMF,y
         bita  #SINBUF
         bne   Read4F9
         tst   PD.CP+3,y
         bne   Read4F4
         tst   $02,s
         beq   Read4F4
         leax  >Writ571,pcr
         cmpx  $06,s
         bne   Read4F4
         lbsr  L1098
         bra   Read4F7
Read4F4  lbsr  L1256
Read4F7  bcs   Read4C1
Read4F9  ldu   PD.BUF,y
         clra  
         ldb   PD.CP+3,y
         leau  d,u
         negb  
         sbca  #$FF
         ldx   ,s
         cmpd  $02,s
         bls   Read50C
         ldd   $02,s
Read50C  pshs  b,a
         jsr   [$08,s]
         stx   $02,s
         IFNE  H6309
         aim   #^BufBusy,PD.SMF,y
         ELSE
         ldb   PD.SMF,y
         andb  #^BufBusy
         stb   PD.SMF,y
         ENDC
         ldb   $01,s
         addb  PD.CP+3,y
         stb   PD.CP+3,y
         bne   Read530
         lbsr  L1237
         inc   PD.CP+2,y
         bne   Read52E
         inc   PD.CP+1,y
         bne   Read52E
         inc   PD.CP,y
Read52E  bcs   Read4C3
Read530  ldd   $04,s
         subd  ,s++
         std   $02,s
         jmp   [$04,s]

WriteLn  pshs  y
         clrb  
         ldy   R$Y,u
         beq   WtLn55E
         ldx   <D.Proc
         ldb   P$Task,x
         ldx   R$X,u
WtLn547  leay  -$01,y
         beq   WtLn55E
         os9   F$LDABX
         leax  $01,x
         cmpa  #$0D
         bne   WtLn547
         tfr   y,d
         nega             \
* a negd was tried here, but may have caused runaway writes>64k
         negb             /
         sbca  #$00
         addd  R$Y,u
         std   R$Y,u
WtLn55E  puls  y

Write    ldd   R$Y,u
         lbsr  L0B0C
         bcs   Writ598
         ldd   R$Y,u
         beq   Writ597
         bsr   Writ599
         bcs   Writ598
         bsr   Writ582
Writ571  pshs  y,b,a
         tfr   d,y
         bsr   Writ5CB
         puls  y,b,a
         leax  d,x
         IFNE  H6309
         oim   #(BUFMOD!SINBUF),PD.SMF,y
         ELSE
         pshs  a
         lda   PD.SMF,y
         ora   #(BUFMOD!SINBUF)
         sta   PD.SMF,y
         puls  a
         ENDC
         rts   

Writ582  lbsr  Read4D3
         lbne  Read4D9
         leas  $08,s
         ldy   PD.Exten,y
         lda   #$01
         lbsr  L0AD1
         ldy   PE.PDptr,y
Writ597  clrb  
Writ598  rts   

Writ599  addd  PD.CP+2,y
         tfr   d,x
         ldd   PD.CP,y
         IFNE  H6309
         adcd  #0
         ELSE
         adcb  #0
         adca  #0
         ENDC
Writ5A3  cmpd  PD.SIZ,y
         bcs   Writ597
         bhi   Writ5AF
         cmpx  PD.SIZ+2,y
         bls   Writ597
Writ5AF  pshs  u
         ldu   PD.SIZ+2,y
         stx   PD.SIZ+2,y
         ldx   PD.SIZ,y
         std   PD.SIZ,y
         pshs  u,x
         lbsr  L0C6F
         puls  u,x
         bcc   Writ5C9
         stx   PD.SIZ,y
         stu   PD.SIZ+2,y
Writ5C9  puls  pc,u

Writ5CB  pshs  x
         ldx   <D.Proc
         lda   P$Task,x
         ldb   <D.SysTsk
         puls  x
         os9   F$Move
         rts   

* SS.OPT
* Entry A=path number
*       B=$00
*       X=address to put 32 byte packet
GetStat  ldb   R$B,u      $02,u
         beq   Gst5FF
         cmpb  #SS.EOF
         bne   Gst5EB
         clr   R$B,u
Gst5E5   clra  
         ldb   #$01
         lbra  RdLn473

* SS.Ready
* check for data avail on dev
* Entry A=path number
*       B=$01
Gst5EB   cmpb  #SS.Ready
         bne   Gst5F2
         clr   R$B,u
         rts   

* SS.SIZ
* Entry A=path num
*       B=$02
* Exit  X=msw of files size
*       U=lsw of files size
Gst5F2   cmpb  #SS.Size
         bne   Gst600
         IFNE  H6309
         ldq   PD.SIZ,y
Gst5F8   std   R$X,u
         stw   R$U,u
         ELSE
         ldd   PD.SIZ,y
         std   R$X,u
         ldd   PD.SIZ+2,y
         std   R$U,u
         ENDC
Gst5FF   rts   

* SS.POS
* Entry A=path num
*       B=$05
* Exit  X=msw of pos
*       U=lsw of pos
Gst600   cmpb  #SS.POS
         bne   Gst60D
         IFNE  H6309
         ldq   PD.CP,y
         bra   Gst5F8
         ELSE
         ldd   PD.CP,y
         std   R$X,u
         ldd   PD.CP+2,y
         std   R$U,u
         rts
         ENDC

* Getstt(SS.FD)
* Entry: R$A = Path #
*        R$B = SS.FD ($0F)
*        R$X = ptr to 256 byte buffer
*        R$Y = # of bytes of FD required
Gst60D   cmpb  #SS.FD
         bne   Gst627
         lbsr  RdFlDscr
         bcs   Gst5FF
         ldu   PD.RGS,y
         ldd   R$Y,u
         tsta  
         beq   Gst620
         ldd   #$0100
Gst620   ldx   R$X,u
         ldu   PD.BUF,y
         lbra  Read4AF

* Getstt(SS.FDInf)
* Entry: R$A = Path #
*        R$B = SS.FDInf ($20)
*        R$X = ptr to 256 byte buffer
*        R$Y = msb - Length of read
*              lsb - MSB of LSN
*        R$U = LSW of LSN
Gst627   cmpb  #SS.FDInf
         bne   Gst640
         lbsr  L1237
         bcs   Gst5FF
         ldb   R$Y,u
         ldx   R$U,u
         lbsr  L113A
         bcs   Gst5FF
         ldu   PD.RGS,y
         ldd   R$Y,u
         clra  
         bra   Gst620
Gst640   lda   #D$GSTA
         lbra  L113C

SetStat  ldb   R$B,u
         cmpb  #SS.OPT
         bne   Sst659
         ldx   R$X,u
         leax  $02,x
         leau  PD.STP,y
         ldy   #(PD.TFM-PD.STP)
         lbra  Writ5CB
Sst659   cmpb  #SS.Size
         bne   Sst69B
         ldd   PD.FD+1,y
         bne   Sst669
         tst   PD.FD,y
         lbeq  Sst7A8
Sst669   lda   PD.MOD,y
         bita  #WRITE.
         beq   Sst697
         ldd   R$X,u
         ldx   R$U,u
         cmpd  PD.SIZ,y
         bcs   Sst682
         bne   Sst67F
         cmpx  PD.SIZ+2,y
         bcs   Sst682
Sst67F   lbra  Writ5A3
Sst682   std   PD.SIZ,y
         stx   PD.SIZ+2,y
         ldd   PD.CP,y
         ldx   PD.CP+2,y
         pshs  x,b,a
         lbsr  L0EFE
         puls  u,x
         stx   PD.CP,y
         stu   PD.CP+2,y
         rts   
Sst697   comb  
         ldb   #E$BMode
Sst69A   rts   

* SetStt(SS.FD) #$0F - returns FD to disk
* Entry: R$A = Path #
*        R$B = SS.FD ($0F)
*        R$X = ptr to 256 byte buffer
*        R$Y = # bytes to write
Sst69B   cmpb  #SS.FD
         bne   Sst6D9
         lda   PD.MOD,y
         bita  #WRITE.
         beq   Sst697
         lbsr  RdFlDscr
         bcs   Sst69A
         pshs  y
         ldx   R$X,u
         ldu   PD.BUF,y
         ldy   <D.Proc
         ldd   P$User,y
         bne   Sst6BC
         ldd   #$0102
         bsr   Sst6CB
Sst6BC   ldd   #$0305
         bsr   Sst6CB
         ldd   #$0D03
         bsr   Sst6CB
         puls  y
         lbra  L11FD
Sst6CB   pshs  u,x
         leax  a,x
         leau  a,u
         clra  
         tfr   d,y
         lbsr  Writ5CB
         puls  pc,u,x
Sst6D9   cmpb  #SS.Lock
         bne   Sst6F8
         ldd   R$U,u
         ldx   R$X,u
         cmpx  #$FFFF
         bne   Sst6F5
         cmpx  R$U,u
         bne   Sst6F5
         ldu   PD.Exten,y
         IFNE  H6309
         oim   #FileLock,PE.Lock,u
         ELSE
         lda   PE.Lock,u
         ora   #FileLock
         sta   PE.Lock,u
         ENDC
         lda   #$FF
Sst6F5   lbra  L0B1B

* SS.Ticks
Sst6F8   cmpb  #SS.Ticks
         bne   Sst705
         ldd   R$X,u
         ldx   PD.Exten,y
         std   PE.TmOut,x
         rts   

* SS.RsBit 
Sst705   cmpb  #SS.RsBit
         bne   Sst715
         ldx   PD.DTB,y
         lda   R$X+1,u
         sta   V.ResBit,x
         clr   V.MapSct,x
Sst714   rts   

* SS.Attr 
Sst715   cmpb  #SS.Attr
         bne   Sst784
         lbsr  RdFlDscr
         bcs   Sst714
         ldx   <D.Proc
         ldd   P$User,x   lda?, P$User is INT
         beq   Sst72A
         ldx   PD.BUF,y
         cmpd  FD.OWN,x   FD.OWN is INT!
         bne   Sst780
Sst72A   lda   R$X+1,u    ditto
         tfr   a,b
         ldu   PD.BUF,y
         eorb  FD.ATT,u
         bpl   Sst77B
         tsta  
         bmi   Sst764
         ldx   PD.DTB,y
         ldd   DD.DIR,x
         cmpd  PD.FD,y
         bne   Sst749
         ldb   DD.DIR+2,x
         cmpb  PD.FD+2,y
         beq   Sst780
Sst749   ldb   PD.CP,y
         ldx   PD.CP+1,y
         pshs  x,b
         std   PD.CP,y
         ldb   #DIR.SZ
         std   PD.CP+2,y
Sst755   lbsr  L0942
         bcs   Sst768
         tst   ,x
         beq   Sst755
         puls  x,b
         stb   PD.CP,y
         stx   PD.CP+1,y
Sst764   ldb   #E$DNE
         bra   Sst782
Sst768   puls  x,a
         sta   PD.CP,y
         stx   PD.CP+1,y
         cmpb  #E$EOF
         bne   Sst782
         lbsr  RdFlDscr
         ldu   PD.BUF,y
         ldx   PD.RGS,y
         lda   R$X+1,x
Sst77B   sta   FD.ATT,u
         lbra  L11FD
Sst780   ldb   #E$FNA
Sst782   coma  
         rts   

* SetStt(SS.FSig)
Sst784   cmpb  #SS.FSig   this not in v31
         bne   Sst7A3
         lda   PD.ATT,y
         bita  #SHARE.
         lbne  L0A8B
         ldx   PD.Exten,y
         lda   R$X+1,u
         sta   PE.SigSg,x
         ldu   <D.Proc
         lda   P$ID,u     was <P$ID,u
         sta   PE.SigID,x
         clrb  
         rts   

Sst7A3   lda   #$0C
         lbra  L113C
Sst7A8   comb  
         ldb   #E$UnkSvc  #$D0
Sst7AB   rts   
FindFile ldd   #$0100
         stb   PD.FST,y   s/b 0
         os9   F$SRqMem
         bcs   Sst7AB
         stu   PD.BUF,y
         leau  ,y         move PD.ptr to regs.U
         ldx   <D.PthDBT
         os9   F$All64
         exg   y,u        *PD>y; memadd to regs.U
         bcs   Sst7AB
         stu   PD.Exten,y
         clr   PE.SigID,u
         sty   PE.PDptr,u
         stu   PE.Wait,u
         ldx   PD.RGS,y
         ldx   R$X,x
         pshs  u,y,x
         leas  -$04,s
         IFNE  H6309
         clrd             was clra, clrb  
         ELSE
         clra  
         clrb  
         ENDC
         sta   PD.FD,y
         std   PD.FD+1,y
         std   PD.DSK,y
         lbsr  L097F
         sta   ,s
         cmpa  #'/
         bne   Sst7FB
         lbsr  GtDvcNam
         sta   ,s
         lbcs  L090D
         leax  ,y
         ldy   $06,s
         bra   Sst81E
Sst7FB   anda  #$7F
         cmpa  #'@
         beq   Sst81E
         lda   #'/
         sta   ,s
         leax  -$01,x
         lda   PD.MOD,y
         ldu   <D.Proc
         leau  P$DIO,u
         bita  #EXEC.
         beq   Sst814
         leau  $06,u
Sst814   ldb   $03,u
         stb   PD.FD,y
         ldd   $04,u
         std   PD.FD+1,y
Sst81E   ldu   PD.DEV,y
         stu   PD.DVT,y
         lda   PD.DRV,y
         ldb   >L0012,pcr confusion reigns supreme here,
* one source loaction says its number of drive tables,
* and the next says its the size of the table! And a 3rd
* says its D.TYP.
         mul   
         addd  V$STAT,u
         addd  #DRVBEG
         std   PD.DTB,y
         lda   ,s
         anda  #$7F
         cmpa  #'@
         bne   Sst83F
         leax  $01,x
         bra   Sst861
Sst83F   lbsr  L1110
         lbcs  L0915
         ldu   PD.BUF,y
         ldd   DD.DSK,u
         std   PD.DSK,y
         ldd   PD.FD+1,y
         bne   Sst861
         lda   PD.FD,y
         bne   Sst861
         lda   DD.DIR,u
         sta   PD.FD,y
         ldd   DD.DIR+1,u
         std   PD.FD+1,y
Sst861   stx   $04,s
         stx   $08,s
Sst865   lbsr  L1237
         lbcs  L0915
         lda   ,s
         anda  #$7F
         cmpa  #'@
         beq   Sst87B
         lbsr  RdFlDscr
         lbcs  L0915
Sst87B   lbsr  L0A2A
         lda   ,s
         cmpa  #'/
         bne   L08EF
         clr   $02,s
         clr   $03,s
         lda   PD.MOD,y
         ora   #DIR.
         lbsr  ChkAttrs
         bcs   L090D
         lbsr  Open1CE
         ldx   $08,s
         leax  $01,x
         lbsr  GtDvcNam
         std   ,s
         stx   $04,s
         sty   $08,s
         ldy   $06,s
         bcs   L090D
         pshs  u,y
         ldu   PD.Exten,y
         leau  PE.FilNm,u
         clra  
         tfr   d,y
         lbsr  Writ5CB
         puls  u,y
         lbsr  L0957
         bra   L08C1
L08BC    bsr   L0918
         IFNE  H6309
L08BE    bsr   L0942
         ELSE
L08BE    lbsr  L0942
         ENDC
L08C1    bcs   L090D
         tst   ,x
         beq   L08BC
         clra  
         ldb   $01,s
         exg   x,y
         ldx   PD.Exten,x
         leax  PE.FilNm,x
         lbsr  L09BF
         ldx   $06,s
         exg   x,y
         bcs   L08BE
         bsr   L0926
         lda   DIR.FD,x
         sta   PD.FD,y
         ldd   DIR.FD+1,x
         std   PD.FD+1,y
         lbsr  L0A90
         lbra  Sst865

L08EF    ldx   $08,s
         tsta  
         bmi   L08FC
         os9   F$PrsNam
         leax  ,y
         ldy   $06,s
L08FC    stx   $04,s
         clra  
L08FF    lda   ,s
         leas  $04,s
         pshs  b,a,cc
         IFNE  H6309
         aim   #^BufBusy,PD.SMF,y
         ELSE
         lda   PD.SMF,y
         anda  #^BufBusy
         sta   PD.SMF,y
         ENDC
         puls  pc,u,y,x,b,a,cc

L090D    cmpb  #E$EOF
         bne   L0915
         bsr   L0918
         ldb   #E$PNNF
L0915    coma  
         bra   L08FF
L0918    pshs  d
         lda   $04,s
         cmpa  #'/
         beq   L0940
         ldd   $06,s
         bne   L0940
         bra   L0928      fewer clock cycles
L0926    pshs  d
L0928    stx   $06,s
         lda   PD.FD,y
         sta   PD.DFD,y
         ldd   PD.FD+1,y
         std   PD.DFD+1,y
         IFNE  H6309
         ldq   PD.CP,y    was ldd,std here
         stq   PD.DCP,y
         ELSE
         ldd   PD.CP,y
         std   PD.DCP,y
         ldd   PD.CP+2,y
         std   PD.DCP+2,y
         ENDC
L0940    puls  pc,b,a
L0942    ldb   PD.CP+3,y
         addb  #DIR.SZ
         stb   PD.CP+3,y
         bcc   L0957
         lbsr  L1237
         inc   PD.CP+2,y
         bne   L0957
         inc   PD.CP+1,y
         bne   L0957
         inc   PD.CP,y

L0957    ldd   #DIR.SZ
         lbsr  RdLn473
         bcs   L097E
         ldd   #DIR.SZ
         lbsr  L0B0C
         bcs   L097E
         lda   PD.SMF,y
         bita  #SINBUF
         bne   L0977
         lbsr  L1098
         bcs   L097E
         lbsr  L1256
         bcs   L097E
L0977    ldb   PD.CP+3,y
         lda   PD.BUF,y
         tfr   d,x
         clrb  
L097E    rts   

* Get a byte from other task
L097F    pshs  u,x,b
         ldu   <D.Proc
         ldb   P$Task,u
         os9   F$LDABX
         puls  pc,u,x,b

*
GtDvcNam os9   F$PrsNam
         pshs  x
         bcc   L09B7
         clrb  
L0992    pshs  a
         anda  #$7F
         cmpa  #'.
         puls  a
         bne   L09AD
         incb  
         leax  1,x
         tsta  
         bmi   L09AD
         bsr   L097F
         cmpb  #$03
         bcs   L0992
         lda   #'/
         decb  
         leax  -3,x
L09AD    tstb  
         bne   L09B5
L09B0    comb  
         ldb   #E$BPNam
         puls  pc,x
L09B5    leay  ,x

L09B7    cmpb  #DIR.FD-DIR.NM this IS correct, 33 was wrong!
         bhi   L09B0
         andcc  #^Carry
         puls  pc,x

L09BF    pshs  y,x,b,a
L09C1    lda   ,y+
         bmi   L09D1
         decb  
         beq   L09CE
         eora  ,x+
         anda  #$DF
         beq   L09C1
L09CE    comb  
         puls  pc,y,x,b,a

L09D1    decb  
         bne   L09CE
         eora  ,x
         anda  #$5F
         bne   L09CE
         clrb  
         puls  pc,y,x,b,a

*
ChkAttrs tfr   a,b
         anda  #(EXEC.!UPDAT.)
         andb  #(DIR.!SHARE.)
         pshs  x,b,a
         lbsr  RdFlDscr
         bcs   L0A0C
         ldu   PD.BUF,y
         ldx   <D.Proc
         ldd   P$User,x
         beq   L09F5
         cmpd  FD.OWN,u
L09F5    puls  a
         beq   L09FC
         lsla  
         lsla  
         lsla  
L09FC    ora   ,s
         anda  #^SHARE.
         pshs  a
         ora   #DIR.
         anda  FD.ATT,u
         cmpa  ,s
         beq   L0A15
         ldb   #E$FNA
L0A0C    leas  $02,s
         coma  
         puls  pc,x

L0A11    ldb   #E$Share,s
         bra   L0A0C
L0A15    ldb   1,s
         orb   FD.ATT,u
         bitb  #SHARE.
         beq   L0A28
         ldx   PD.Exten,y
         cmpx  PE.Confl,x
         bne   L0A11
         lda   #FileLock
         sta   PE.Lock,x
L0A28    puls  pc,x,b,a


L0A2A    pshs  u,y,x
         IFNE  H6309
         clrd             was clra, clrb  
         ELSE
         clra  
         clrb  
         ENDC
         std   PD.CP,y
         std   PD.CP+2,y
         sta   PD.SSZ,y
         std   PD.SSZ+1,y
         ldb   PD.FD,y
         ldx   PD.FD+1,y
         pshs  x,b
         ldu   PD.DTB,y
         ldy   PD.Exten,y
         sty   PE.Confl,y
         leau  DD.SIZ,u
         bra   L0A51
L0A4F    ldu   V.FileHd-DD.SIZ,u
L0A51    ldx   V.FileHd-DD.SIZ,u
         beq   L0A7F
         ldx   PE.PDptr,x
         ldd   PD.FD,x
         cmpd  ,s
         bcs   L0A4F
         bhi   L0A7F
         ldb   PD.FD+2,x
         cmpb  2,s
         blo   L0A4F
         bhi   L0A7F
         ldx   PD.Exten,x
         IFNE  H6309
         tim   #FileLock,PE.Lock,y
         ELSE
         ldb   PE.Lock,y
         bitb  #FileLock
         ENDC
         bne   L0A8B
         sty   PE.NxFil,y
         ldd   PE.Confl,x
         std   PE.Confl,y
         sty   PE.Confl,x
         bra   L0A86

L0A7F    ldx   PE.NxFil,u
         stx   PE.NxFil,y
         sty   PE.NxFil,u

L0A86    clrb  
L0A87    leas  $03,s
         puls  pc,u,y,x

L0A8B    comb  
         ldb   #E$Share
         bra   L0A87

L0A90    pshs  u,y,x,b,a
         ldu   PD.DTB,y
         leau  DD.SIZ,u
         ldx   PD.Exten,y
         leay  ,x
         bsr   L0ACF
         bra   L0AA5
L0AA1    ldx   PE.Confl,x
         beq   L0ACA
L0AA5    cmpy  PE.Confl,x
         bne   L0AA1
         ldd   PE.Confl,y
         std   PE.Confl,x
         bra   L0AB2
L0AB0    ldu   PE.NxFil,u
L0AB2    ldd   PE.NxFil,u
         beq   L0ACA
         cmpy  PE.NxFil,u
         bne   L0AB0
         ldx   PE.NxFil,y
         cmpy  PE.Confl,y
         beq   L0AC8
         ldx   PE.Confl,y
         ldd   PE.NxFil,y
         std   PE.NxFil,x
L0AC8    stx   PE.NxFil,u
L0ACA    sty   PE.Confl,y
         puls  pc,u,y,x,b,a

L0ACF    lda   #(EofLock!FileLock!RcdLock)
L0AD1    pshs  u,y,x,b,a
         bita  PE.Lock,y
         beq   L0AE0
         coma             an AIM below doesn't update regs.a
         anda  PE.Lock,y
         sta   PE.Lock,y
         bita  #FileLock
         bne   L0AFD
L0AE0    leau  ,y
L0AE2    ldx   PE.Wait,u
         cmpy  PE.Wait,u
         beq   L0AFA
         stu   PE.Wait,u
         leau  ,x
         lda   PE.Owner,u
         ldb   #S$Wake
         os9   F$Send
         bra   L0AE2
L0AFA    stu   PE.Wait,u
L0AFD    puls  pc,u,y,x,b,a

L0AFF    comb  
         ldb   #E$Share
L0B02    pshs  y,b,cc
         ldy   PD.Exten,y
         bsr   L0ACF
         puls  pc,y,b,cc
L0B0C    equ   *
         IFNE  H6309
         tfr   0,x
         ELSE
         ldx   #$0000
         ENDC
         bra   L0B1B

L0B11    ldu   PD.Exten,y
         lda   PE.Req,u
         sta   PE.Lock,u
         bra   L0B1D      was a puls all below
L0B1B    pshs  u,y,x,b,a
L0B1D    ldu   PD.Exten,y
         lda   PE.Lock,u
         sta   PE.Req,u
         lda   ,s
         bsr   L0B9F
         bcc   L0B9D
         ldu   <D.Proc
         lda   PE.Owner,x
L0B30    os9   F$GProcP
         bcs   L0B42
         lda   P$DeadLk,y
         beq   L0B42
         cmpa  P$ID,u     ,u
         bne   L0B30
         ldb   #E$DeadLk
         bra   L0B9A

L0B42    lda   PE.Owner,x
         sta   P$DeadLk,u
         ldy   4,s
         IFNE  H6309
         aim   #^BufBusy,PD.SMF,y
         ELSE
         lda   PD.SMF,y
         anda  #^BufBusy
         sta   PD.SMF,y
         ENDC
         ldu   PD.Exten,y
         ldd   PE.Wait,x
         stu   PE.Wait,x
         std   PE.Wait,u
         lbsr  L0C56
         ldx   PE.TmOut,u
         os9   F$Sleep
         pshs  x
         leax  ,u
         bra   L0B6F
L0B6C    ldx   PE.Wait,x
L0B6F    cmpu  PE.Wait,x
         bne   L0B6C
         ldd   PE.Wait,u
         std   PE.Wait,x
         stu   PE.Wait,u
         puls  x
         ldu   <D.Proc
         clr   P$DeadLk,u
         lbsr  L1053
         bcs   L0B9A
         leax  ,x
         bne   L0B11
         ldu   PD.Exten,y
         ldx   PE.TmOut,u
         lbeq  L0B11
         ldb   #E$Lock
L0B9A    coma  
         stb   $01,s
L0B9D    puls  pc,u,y,x,b,a

L0B9F    
         IFNE  H6309
         tstd             std -$02,s only to set cc.flags? 4 cycles to 1!
         ELSE
         cmpd  #$0000
         ENDC
         bne   L0BAA
         cmpx  #$0000     the leax may be buggy
         lbeq  L0B02
L0BAA    bsr   L0BC2
         lbcs  L0AFF
         pshs  u,y,x
         ldy   PD.Exten,y
         lda   #$01
         lbsr  L0AD1
         ora   PE.Lock,y
         sta   PE.Lock,y
         clrb  
         puls  pc,u,y,x

L0BC2    pshs  u,y,b,a
         leau  ,y
         ldy   PD.Exten,y
         subd  #$0001
         bcc   L0BD1
         leax  -1,x
L0BD1    addd  PD.CP+2,u
         exg   d,x
         IFNE  H6309
         adcd  PD.CP,u    oughta do same - GH
         ELSE
         adcb  PD.CP+1,u
         adca  PD.CP,u
         ENDC
         bcc   L0BE0
         ldx   #$FFFF
         tfr   x,d
L0BE0    std   PE.HiLck,y
         stx   PE.HiLck+2,y
         cmpd  PD.SIZ,u
         bcs   L0BF8
         bhi   L0BF0
         cmpx  PD.SIZ+2,u
         bcs   L0BF8
L0BF0    equ   *
         IFNE  H6309
         oim   #EofLock,PE.Lock,y
         ELSE
         lda   PE.Lock,y
         ora   #EofLock
         sta   PE.Lock,y
         ENDC
         bra   L0C01
L0BF8    lda   #EofLock
         bita  PE.Lock,y
         beq   L0C01
         lbsr  L0AD1
L0C01    equ   *
         IFNE  H6309
         ldq   PD.CP,u
         stq   PE.LoLck,y
         ELSE
         ldd   PD.CP,u
         std   PE.LoLck,y
         ldd   PD.CP+2,u
         std   PE.LoLck+2,y
         ENDC
         lda   PD.CPR,u
         sta   PE.Owner,y
         leax  ,y
L0C10    cmpy  PE.Confl,x
         beq   L0C54
         ldx   PE.Confl,x
         ldb   PE.Owner,y
         cmpb  PE.Owner,x
         beq   L0C10
         lda   PE.Lock,x
         beq   L0C10
         ora   PE.Lock,y
         bita  #FileLock
         bne   L0C53
         lda   PE.Lock,x
         anda  PE.Lock,y
         bita  #EofLock
         bne   L0C53
         ldd   PE.LoLck,x
         cmpd  PE.HiLck,y
         bhi   L0C10
         bcs   L0C43
         ldd   PE.LoLck+2,x
         cmpd  PE.HiLck+2,y
         bhi   L0C10
         beq   L0C53
L0C43    ldd   PE.HiLck,x
         cmpd  PE.LoLck,y
         bcs   L0C10
         bhi   L0C53
         ldd   PE.HiLck+2,x
         cmpd  PE.LoLck+2,y
         bcs   L0C10
L0C53    comb  
L0C54    puls  pc,u,y,b,a
L0C56    pshs  y,x,b,a
         ldx   <D.Proc
         lda   P$IOQN,x
         beq   L0C6C
         clr   P$IOQN,x
         ldb   #S$Wake
         os9   F$Send
         os9   F$GProcP
         clr   P$IOQP,y
L0C6C    clrb  
         puls  pc,y,x,b,a

L0C6F    pshs  u,x
L0C71    bsr   L0CD1
         bne   L0C81
         cmpx  PD.SSZ+1,y
         bcs   L0CC8
         bne   L0C81
         lda   PD.SIZ+3,y
         beq   L0CC8
L0C81    lbsr  RdFlDscr
         bcs   L0CC5
         ldx   PD.CP,y
         ldu   PD.CP+2,y
         pshs  u,x
         IFNE  H6309
         ldq   PD.SIZ,y   these were ldd's too
         stq   PD.CP,y
         ELSE
         ldd   PD.SIZ,y
         std   PD.CP,y
         ldd   PD.SIZ+2,y
         std   PD.CP+2,y
         ENDC
         lbsr  L10B2
         puls  u,x
         stx   PD.CP,y
         stu   PD.CP+2,y
         bcc   L0CC8
         cmpb  #E$NES
         bne   L0CC5
         bsr   L0CD1
         bne   L0CB1
         tst   PD.SIZ+3,y
         beq   L0CB4
         leax  1,x
         bne   L0CB4
L0CB1    ldx   #$FFFF
L0CB4    tfr   x,d
         tsta  
         bne   L0CC1
         cmpb  PD.SAS,y
         bcc   L0CC1
         ldb   PD.SAS,y
L0CC1    bsr   L0D07
         bcc   L0C71
L0CC5    coma  
         puls  pc,u,x

L0CC8    lbsr  L1098
         bcs   L0CC5
         bsr   L0CDF
         puls  pc,u,x
L0CD1    ldd   PD.SIZ+1,y
         subd  PD.SBL+1,y
         tfr   d,x
         ldb   PD.SIZ,y
         sbcb  PD.SBL,y
         rts   

L0CDF    clra  
         ldb   #$02
         pshs  u,x
         ldu   PD.Exten,y
         bra   L0CFD

L0CE9    ldu   PE.PDptr,u
         ldx   PD.SIZ,y
         stx   PD.SIZ,u
         ldx   PD.SIZ+2,y
         stx   PD.SIZ+2,u
         bitb  PD.MOD,y
         beq   L0CFA
         inca  
L0CFA    ldu   PD.Exten,u
L0CFD    ldu   PE.Confl,u
         cmpy  PE.PDptr,u
         bne   L0CE9
         tsta  
         puls  pc,u,x

L0D07    pshs  u,x
         lbsr  FatScan
         bcs   L0D4E
         lbsr  RdFlDscr
         bcs   L0D4E
         ldu   PD.BUF,y
         IFNE  H6309
         clrd  
         tfr   d,w
         stq   FD.SIZ,u
         ELSE
         clra  
         clrb  
         std   FD.SIZ,u
         std   FD.SIZ+2,u
         ENDC
         leax  FD.SEG,u
         ldd   FDSL.B,x
         beq   L0D96
         ldd   PD.BUF,y
         inca  
         pshs  d
         bra   L0D36
L0D29    clrb  
         ldd   -$02,x
         beq   L0D4A
         addd  FD.SIZ+1,u
         std   FD.SIZ+1,u
         bcc   L0D36
         inc   FD.SIZ,u
L0D36    leax  FDSL.S,x
         cmpx  ,s
         bcs   L0D29
         lbsr  ClrFBits
         IFNE  H6309
         clrd  
         ELSE
         clra  
         clrb  
         ENDC
         sta   PD.SSZ,y
         std   PD.SSZ+1,y
         comb  
         ldb   #E$SLF
L0D4A    leas  2,s
         leax  -FDSL.S,x
L0D4E    bcs   L0DB3
         ldd   -4,x
         addd  -2,x
         pshs  b,a
         ldb   -5,x
         adcb  #$00
         cmpb  PD.SBP,y
         puls  d
         bne   L0D96
         cmpd  PD.SBP+1,y
         bne   L0D96
         ldu   PD.DTB,y
         ldd   DD.BIT,u
         ldu   PD.BUF,y
         subd  #1
         coma  
         comb             comd is prolly wrong reg order!
         pshs  d
         ldd   -$05,x
         IFNE  H6309
         eord  PD.SBP,y
         lsrd  
         lsrd  
         lsrd  
         andd  ,s++
         tstd  
         ELSE
         eora  PD.SBP,y
         eorb  PD.SBP+1,y
         lsra
         rorb
         lsra
         rorb
         lsra
         rorb
         anda  ,s+
         andb  ,s+
         cmpd  #$0000
         ENDC
         bne   L0D96
         ldd   -2,x
         addd  PD.SSZ+1,y
         bcs   L0D96
         std   -2,x
         bra   L0DA5
L0D96    ldd   PD.SBP,y
         std   ,x
         lda   PD.SBP+2,y
         sta   2,x
         ldd   PD.SSZ+1,y
         std   3,x
L0DA5    ldd   FD.SIZ+1,u
         addd  PD.SSZ+1,y
         std   FD.SIZ+1,u
         bcc   L0DB0
         inc   FD.SIZ,u
L0DB0    lbsr  L11FD
L0DB3    puls  pc,u,x


FatScan  pshs  u,y,x,b,a
         ldb   #$0C
L0DB9    clr   ,-s
         decb  
         bne   L0DB9
         ldx   PD.DTB,y
         ldd   DD.MAP,x
         std   4,s
         ldd   DD.BIT,x
         std   2,s
         std   10,s
         ldx   PD.DEV,y
         ldx   V$DESC,x
         leax  M$DTyp,x
         subd  #1
         addb  IT.SAS-M$DTyp,x
         adca  #0
         bra   L0DDD
L0DDB    
         IFNE  H6309
         lsrd  
         ELSE
         lsra
         rorb
         ENDC
L0DDD    lsr   $0A,s
         ror   $0B,s
         bcc   L0DDB
         std   ,s
         ldd   2,s
         std   $0A,s
         subd  #$0001
         addd  $0C,s
         bcc   L0DF7
         ldd   #$FFFF
         bra   L0DF7
L0DF5    
         IFNE  H6309
         lsrd  
         ELSE
         lsra
         rorb
         ENDC
L0DF7    lsr   $0A,s
         ror   $0B,s
         bcc   L0DF5
         cmpa  #8
         bcs   L0E04
         ldd   #$0800
L0E04    std   $0C,s
         lbsr  L1036
         lbcs  L0EF2
         ldx   PD.DTB,y
         ldd   V.DiskID,x
         cmpd  DD.DSK,x
         bne   L0E26
         lda   V.BMapSz,x
         cmpa  DD.MAP,x
         bne   L0E26
         ldb   V.MapSct,x
         cmpb  DD.MAP,x
         bcs   L0E34
L0E26    ldd   DD.DSK,x
         std   V.DiskID,x
         lda   DD.MAP,x
         sta   V.BMapSz,x
         clrb  
         stb   V.MapSct,x
L0E34    incb  
         stb   6,s
         ldx   PD.DTB,y
         cmpb  V.ResBit,x
         beq   L0E70
         lbsr  L1091
         lbcs  L0EF2
         ldb   6,s
         cmpb  4,s
         bls   L0E51
         clra  
         ldb   5,s
         bra   L0E54
L0E51    ldd   #$0100
L0E54    ldx   PD.BUF,y
         leau  d,x
         ldy   $0C,s
         IFNE  H6309
         clrd  
         ELSE
         clra  
         clrb  
         ENDC
         os9   F$SchBit
         bcc   L0E9D
         cmpy  8,s
         bls   L0E70
         sty   8,s
         std   $0A,s
         lda   6,s
         sta   7,s
L0E70    ldy   <$10,s
         ldb   6,s
         cmpb  4,s
         bcs   L0E81
         bhi   L0E80
         tst   5,s
         bne   L0E81
L0E80    clrb  
L0E81    ldx   PD.DTB,y
         cmpb  V.MapSct,x
         bne   L0E34
         ldb   7,s
         beq   L0EF0
         cmpb  6,s
         beq   L0E96
         stb   6,s
         lbsr  L1091
L0E96    ldx   PD.BUF,y
         ldd   $0A,s
         ldy   8,s
L0E9D    std   $0A,s
         sty   8,s
         os9   F$AllBit
         ldy   $10,s
         ldb   $06,s
         lbsr  L1069
         bcs   L0EF2
         ldx   PD.DTB,y
         lda   6,s
         deca  
         sta   V.MapSct,x
         clrb  
         lsla             lsb a forced 0,msb->carry
         rolb             but carry out of a to lsb
         lsla             now 2 lsb of a=%00
         rolb             and top 2 bits of a now in b
         lsla             3 cleared bits
         rolb             and 3 roll-ins
         stb   PD.SBP,y   <$16,y
         ora   $0A,s
         ldb   $0B,s
         ldx   8,s
         ldy   $10,s
         std   PD.SBP+1,y
         stx   PD.SSZ+1,y
         ldd   2,s
         bra   L0EE6
L0ED7    lsl   PD.SBP+2,y
         rol   PD.SBP+1,y
         rol   PD.SBP,y
         lsl   PD.SSZ+2,y
         rol   PD.SSZ+1,y
L0EE6   
         IFNE  H6309
         lsrd  
         ELSE
         lsra
         rorb
         ENDC
         bcc   L0ED7
         clrb  
         ldd   PD.SSZ+1,y
         bra   L0EFA
L0EF0    ldb   #E$Full
L0EF2    ldy   $10,s
         lbsr  L1070
         coma  
L0EFA    leas  $0E,s
         puls  pc,u,y,x
L0EFE    clra  
         lda   PD.MOD,y
         bita  #DIR.      #$80
         bne   L0F6F
         IFNE  H6309
         ldq   PD.SIZ,y
         stq   PD.CP,y
         ELSE
         ldd   PD.SIZ,y
         std   PD.CP,y
         ldd   PD.SIZ+2,y
         std   PD.CP+2,y
         ENDC
         ldd   #$FFFF
         tfr   d,x
         lbsr  L0B1B
         bcs   L0F6E
         lbsr  L0CDF
         bne   L0F6F
         lbsr  L10B2
         bcc   L0F26
         cmpb  #E$NES
         bra   L0F67
L0F26    ldd   PD.SBL+1,y
         subd  PD.CP+1,y
         addd  PD.SSZ+1,y
         tst   PD.CP+3,y
         beq   L0F35
         IFNE  H6309
         decd             ok here, carry NOT used below
         ELSE
         subd  #$0001
         ENDC
L0F35    pshs  d
         ldu   PD.DTB,y
         ldd   DD.BIT,u
         IFNE  H6309
         decd  
         comd  
         andd  ,s++
         ELSE
         subd  #$0001
         coma
         comb
         anda  ,s+
         andb  ,s+
         ENDC
         ldu   PD.SSZ+1,y
         std   PD.SSZ+1,y
         beq   L0F69
         tfr   u,d
         subd  PD.SSZ+1,y
         pshs  x,b,a
         addd  PD.SBP+1,y
         std   PD.SBP+1,y
         bcc   L0F5F
         inc   PD.SBP,y
L0F5F    bsr   ClrFBits
         bcc   L0F70
         leas  4,s
         cmpb  #E$IBA
L0F67    bne   L0F6E
L0F69    lbsr  RdFlDscr
         bcc   L0F79
L0F6E    coma  
L0F6F    rts   

L0F70    lbsr  RdFlDscr
         bcs   L0FC9
         puls  x,b,a
         std   FDSL.B,x
L0F79    ldu   PD.BUF,y
         IFNE  H6309
         ldq   PD.SIZ,y   $0F,y
         stq   FD.SIZ,u   $09,u
         ELSE
         ldd   PD.SIZ,y   $0F,y
         std   FD.SIZ,u   $09,u
         ldd   PD.SIZ+2,y   $11,y
         std   FD.SIZ+2,u   $0B,u
         ENDC
         tfr   x,d        fixes d
         clrb  
         inca  
         leax  FDSL.S,x
         pshs  x,b,a
         bra   L0FB4
L0F8E    ldd   -2,x
         beq   L0FC1
         std   PD.SSZ+1,y
         ldd   -FDSL.S,x
         std   PD.SBP,y
         lda   -FDSL.B,x
         sta   PD.SBP+2,y
         bsr   ClrFBits
         bcs   L0FC9
         stx   2,s
         lbsr  RdFlDscr
         bcs   L0FC9
         ldx   2,s
         IFNE  H6309
         clrd  
         ELSE
         clra  
         clrb  
         ENDC
         std   -$05,x     is this "-FDSL.?" stuffs
         sta   -$03,x
         std   -$02,x
L0FB4    lbsr  L11FD
         bcs   L0FC9
         ldx   2,s
         leax  FDSL.S,x
         cmpx  ,s
         bcs   L0F8E
L0FC1
         IFNE  H6309
         clrd  
         ELSE
         clra  
         clrb  
         ENDC
         sta   PD.SSZ,y
         std   PD.SSZ+1,y
L0FC9    leas  4,s
         rts   

ClrFBits pshs  u,y,x,a
         ldx   PD.DTB,y
         ldd   DD.BIT,x
         IFNE  H6309
         decd  
         ELSE
         subd  #$0001
         ENDC
         addd  PD.SBP+1,y
         std   PD.SBP+1,y
         ldd   DD.BIT,x
         bcc   L0FF4
         inc   PD.SBP,y
         bra   L0FF4
L0FE5    lsr   PD.SBP,y
         ror   PD.SBP+1,y
         ror   PD.SBP+2,y
         lsr   PD.SSZ+1,y
         ror   PD.SSZ+2,y
L0FF4    
         IFNE  H6309
         lsrd  
         ELSE
         lsra
         rorb
         ENDC
         bcc   L0FE5
         clrb  
         ldd   PD.SSZ+1,y
         beq   L1034
         ldd   PD.SBP,y
         IFNE  H6309
         lsrd  
         lsrd  
         lsrd  
         ELSE
         lsra
         rorb
         lsra
         rorb
         lsra
         rorb
         ENDC
         tfr   b,a
         ldb   #E$IBA
         cmpa  DD.MAP,x
         bhi   L1033
         inca  
         sta   ,s
L1012    bsr   L1036
         bcs   L1012
         ldb   ,s
         bsr   L1091
         bcs   L1033
         ldx   PD.BUF,y
         ldd   PD.SBP+1,y
         anda  #$07
         ldy   PD.SSZ+1,y
         os9   F$DelBit
         ldy   3,s
         ldb   ,s
         bsr   L1069
         bcc   L1034
L1033    coma  
L1034    puls  pc,u,y,x,a
L1036    lbsr  L1237
         bra   L1043

L103B    lbsr  L0C56
         os9   F$IOQu
         bsr   L1053
L1043    bcs   L1052
         ldx   PD.DTB,y
         lda   V.BMB,x
         bne   L103B
         lda   PD.CPR,y
         sta   V.BMB,x
L1052    rts   


L1053    ldu   <D.Proc
         ldb   P$Signal,u
         cmpb  #S$Wake
         bls   L1060
         cmpb  #S$Intrpt
         bls   L1067
L1060    clra  
         IFNE  H6309
         tim   #Condem,P$State,u
         ELSE
         lda   P$State,u
         bita  #Condem         
         ENDC
         beq   L1068
L1067    coma  
L1068    rts   

* write FAT sector
* Entry B=logical sector #
L1069    clra  
         tfr   d,x
         clrb  
         lbsr  L1207
L1070    pshs  cc
         ldx   PD.DTB,y
         lda   PD.CPR,y
         cmpa  V.BMB,x
         bne   L108F
         clr   V.BMB,x
         ldx   <D.Proc
         lda   P$IOQN,x
         beq   L108F
         lbsr  L0C56
         ldx   #1
         os9   F$Sleep
L108F    puls  pc,cc

* Read a FAT sector
* Entry B=logical sector #
L1091    clra  
         tfr   d,x
         clrb  
         lbra  L113A
* Y=Path descriptor ptr
L1098    ldd   PD.CP+1,y
         subd  PD.SBL+1,y
         tfr   d,x
         ldb   PD.CP,y
         sbcb  PD.SBL,y
         cmpb  PD.SSZ,y
         bcs   L10B0
         bhi   L10B2
         cmpx  PD.SSZ+1,y
         bcc   L10B2
L10B0    clrb  
L10B1    rts   




L10B2    pshs  u
         bsr   RdFlDscr
         bcs   L110E
         IFNE  H6309
         clrd  
         ELSE
         clra  
         clrb  
         ENDC
         std   PD.SBL,y
         stb   PD.SBL+2,y
         ldu   PD.BUF,y
         leax  FD.SEG,u
         lda   PD.BUF,y
         ldb   #$FC
         pshs  b,a

L10CB    ldd   FDSL.B,x
         beq   L10F0
         addd  PD.SBL+1,y
         tfr   d,u
         ldb   PD.SBL,y
         adcb  #0
         cmpb  PD.CP,y
         bhi   L10FD
         bne   L10E4
         cmpu  PD.CP+1,y
         bhi   L10FD
L10E4    stb   PD.SBL,y
         stu   PD.SBL+1,y
         leax  FDSL.S,x
         cmpx  ,s
         bcs   L10CB

L10F0    
         IFNE  H6309
         clrd  
         ELSE
         clra  
         clrb  
         ENDC
         sta   PD.SSZ,y
         std   PD.SSZ+1,y
         comb  
         ldb   #E$NES
         bra   L110C

L10FD    ldd   FDSL.A,x
         std   PD.SBP,y
         lda   FDSL.A+2,x
         sta   PD.SBP+2,y
         ldd   FDSL.B,x
         std   PD.SSZ+1,y
L110C    leas  2,s
L110E    puls  pc,u

* Read LSN0 from disk
* Y=Path descr ptr
L1110    pshs  x,b
         lbsr  L1237
         bcs   L111F
         clrb  
         ldx   #$0000
         bsr   L113A
         bcc   L1121
L111F    stb   ,s
L1121    puls  pc,x,b

* Read file descr
* Y=ptr to bfr
RdFlDscr 
         IFNE  H6309
         tim   #FDBUF,PD.SMF,y
         ELSE
         ldb   PD.SMF,y
         bitb  #FDBUF 
         ENDC
         bne   L10B0
         lbsr  L1237
         bcs   L10B1
         IFNE  H6309
         oim   #FDBUF,PD.SMF,y
         ELSE
         lda   PD.SMF,y
         ora   #FDBUF
         sta   PD.SMF,y
         ENDC
         ldb   PD.FD,y
         ldx   PD.FD+1,y
L113A    lda   #D$READ

* Send cmd to dev dvr
* A=cmd offset
* B=MSB lgcl sct #
* X=LSW lgcl sct #
* Y=Path descr ptr
L113C    pshs  u,y,x,b,a
         IFNE  H6309
         oim   #InDriver,PD.SMF,y
         ELSE
         lda   PD.SMF,y
         ora   #InDriver
         sta   PD.SMF,y
         ENDC
         ldx   <D.Proc
         lda   P$Prior,x
         tfr   a,b
         addb  #3
         bcc   L1150
         ldb   #$FF
L1150    stb   P$Prior,x
         stb   P$Age,x
         ldx   PD.Exten,y
         sta   PE.Prior,x
         ldu   PD.DEV,y
         ldu   V$STAT,u
         bra   L1166
* wait for device
L1160    lbsr  L0C56
         os9   F$IOQu
* dev rdy, send cmnd
L1166    lda   V.BUSY,u
         bne   L1160
         lda   PD.CPR,y
         sta   V.BUSY,u
         ldd   ,s
         ldx   2,s
         pshs  u
         bsr   L11EB
         puls  u
         ldy   4,s
         pshs  cc
         bcc   L1181
         stb   2,s
L1181
         IFNE  H6309
         aim   #^InDriver,PD.SMF,y
         ELSE
         lda   PD.SMF,y
         anda  #^InDriver
         sta   PD.SMF,y
         ENDC
         clr   V.BUSY,u
         ldx   PD.Exten,y
         lda   PE.Prior,x
         ldx   <D.Proc
         sta   P$Prior,x
******
* this code is in v31 only
         lda   ,s
         bita  #Carry
         bne   L11CB
         lda   1,s
         cmpa  #D$WRIT
         bne   L11CB
         pshs  u,y,x
         ldy   PD.Exten,y
         leau  ,y
L11A7    ldx   PE.Confl,u
         cmpy  PE.Confl,u
         beq   L11C9
         leau  ,x

         lda   PE.SigID,u
         beq   L11A7
         ldx   <D.Proc
         cmpa  P$ID,x
         beq   L11A7
         clr   PE.SigID,u
         ldb   PE.SigSg,u
         os9   F$Send
         bra   L11A7

L11C9    puls  u,y,x
L11CB    lda   P$IOQN,x
         beq   L11E9
         lda   $01,y
         bita  #$04
         bne   L11E9
         ldx   PD.DTB,y
         lda   PD.CPR,y
         cmpa  V.BMB,x
         beq   L11E9
         lbsr  L0C56
         ldx   #1
         os9   F$Sleep
L11E9    puls  pc,u,y,x,b,a,cc

* Exec Dev Drvr
* leave this alone till V1.22 is out!
L11EB    pshs  pc,x,b,a
         ldx   $03,y
         ldd   ,x
         ldx   ,x
         addd  $09,x
         addb  ,s
         adca  #$00
         std   $04,s
         puls  pc,x,b,a

* Write fd to disk
L11FD    ldb   PD.FD,y
         ldx   PD.FD+1,y
         bra   L1207


* flsh bfr 2 disk
L1205    bsr   L1220
L1207    lda   #D$WRIT
         pshs  x,b,a
         ldd   PD.DSK,y
         beq   L1216
         ldx   PD.DTB,y
         cmpd  DD.DSK,x
L1216    puls  x,b,a
         lbeq  L113C
         comb  
         ldb   #E$DIDC
         rts   

L1220    ldd   PD.CP+1,y
         subd  PD.SBL+1,y
         tfr   d,x
         ldb   PD.CP,y
         sbcb  PD.SBL,y
         exg   d,x
         addd  PD.SBP+1,y
         exg   d,x
         adcb  PD.SBP,y
         rts   

* chk if sctr bfr needs flshd to disk
L1237    clrb  
         pshs  u,x
         ldb   PD.SMF,y
         andb  #(BufBusy!FDBUF!SINBUF)
         beq   L1254
         tfr   b,a
         eorb  PD.SMF,y
         stb   PD.SMF,y
         andb  #BUFMOD
         beq   L1254
         eorb  PD.SMF,y
         stb   PD.SMF,y
         bita  #SINBUF
         beq   L1254
         bsr   L1205
L1254    puls  pc,u,x

L1256    pshs  u,x
         lbsr  L1098
         bcs   L12C6
         bsr   L1237
         bcs   L12C6
L1261    ldb   PD.CP,y
         ldu   PD.CP+1,y
         leax  ,y
         ldy   PD.Exten,y
L126B    ldx   PD.Exten,x
         cmpy  PE.Confl,x
         beq   L12B5
         ldx   PE.Confl,x
         ldx   PE.PDptr,x
         cmpu  PD.CP+1,x
         bne   L126B
         cmpb  PD.CP,x
         bne   L126B
         lda   PD.SMF,x
         bita  #SINBUF
         beq   L126B
         bita  #InDriver
         bne   L128E
         bita  #BufBusy
         beq   L12A0
L128E    lda   PD.CPR,x
         ldy   PE.PDptr,y
         lbsr  L0C56
         os9   F$IOQu
         lbsr  L1053
         bcc   L1261
         puls  u,x,pc

L12A0    ldy   PE.PDptr,y
         ldd   PD.BUF,x
         ldu   PD.BUF,y
         std   PD.BUF,y
         stu   PD.BUF,x
         lda   PD.SMF,x   \ careful, don't use oim here
         ora   #BufBusy   >takes state from x and
         sta   PD.SMF,y   / stores to y, is infamous "lha" bug
         clr   PD.SMF,x
         puls  pc,u,x

L12B5    ldy   PE.PDptr,y
         lbsr  L1220
         lbsr  L113A
         bcs   L12C6
         IFNE  H6309
         oim   #(BufBusy!SINBUF),PD.SMF,y
         ELSE
         pshs  a
         lda   PD.SMF,y
         ora   #(BufBusy!SINBUF)
         sta   PD.SMF,y
         puls  a
         ENDC
L12C6    puls  pc,u,x

         emod  
eom      equ   *
         end

