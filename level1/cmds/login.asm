********************************************************************
* Login - Timeshare login utility
*
* $Id$
*
* Ed.    Comments                                       Who YY/MM/DD
* ------------------------------------------------------------------
*  16    From Tandy OS-9 Level One VR 02.00.00
*  17    Fixed for years 1900-2155                      BGP 99/05/11
*  18    Changed icpt routine rts to rti, put in        BGP 02/07/20
*        conditionals for Level One not to execute
*        the os9 F$SUser command.

         nam   Login
         ttl   Timeshare login utility

* Disassembled 02/07/13 23:49:05 by Disasm v1.6 (C) 1988 by RML

         IFP1
         use   defsfile
         ENDC

tylg     set   Prgrm+Objct   
atrv     set   ReEnt+rev
rev      set   $01
edition  set   18

         mod   eom,name,tylg,atrv,start,size

         org   0
u0000    rmb   1
PassPath rmb   1
u0002    rmb   1
u0003    rmb   1
DefUID   rmb   1
u0005    rmb   1
u0006    rmb   2
rdbufptr rmb   2
buffnext rmb   2
u000C    rmb   1
timebuff rmb   256
linebuff rmb   128
readbuff rmb   80
u01DD    rmb   80
u022D    rmb   32
size     equ   .

name     fcs   /Login/
         fcb   edition


PassFile fcc   "SYS/PASSWORD"
         fcb   C$CR
WideMsg  fcb   C$LF,C$LF
         IFNE  NitrOS9
         fcc   "Nitr"
         ENDC
         fcc   "OS-9 Timesharing system"
         fcb   C$LF
         fcc   "Level "
         IFEQ  Level-1
         fcc   "One"
         ELSE
         fcc   "Two"
         ENDC
         fcc   " Vr. 0"
         fcb   48+OS9Vrsn
         fcc   ".0"
         fcb   48+OS9Major
         fcc   ".0"
         fcb   48+OS9Minor
         fcb   C$LF
WideMsgL equ   *-WideMsg
NrrwMsg  fcb   C$LF,C$LF
         IFNE  NitrOS9
         fcc   "Nitr"
         ENDC
         fcc   "OS-9 Level "
         IFEQ  Level-1
         fcc   "One"
         ELSE
         fcc   "Two"
         ENDC
         fcc   " Vr. 0"
         fcb   48+OS9Vrsn
         fcc   ".0"
         fcb   48+OS9Major
         fcc   ".0"
         fcb   48+OS9Minor
         fcb   C$LF
NrrwMsgL equ   *-NrrwMsg
UName    fcb   C$LF
         fcc   "User name?: "
UNameLen equ   *-UName

Who      fcc   "Who?"
         fcb   C$CR

Pass     fcc   "Password: "
PassLen  equ   *-Pass
nvPass  fcc   "Invalid password."
         fcb   C$CR

ProcNum  fcb   C$LF
         fcc   "Process #"
ProcNumL equ   *-ProcNum

lo1      fcc   " logged on "
lo1len   equ   *-lo1

lo2      fcc   " logged on "
         fcb   C$LF
lo2len   equ   *-lo2

Welcome  fcc   "Welcome!"
         fcb   C$CR

DirNotFnd fcc   "Directory not found."
         fcb   C$CR

Syntax   fcb   C$LF
         fcc   "Syntax Error in password file"

Sorry    fcb   C$LF
         fcc   "It's been nice communicating with you."
         fcb   C$LF
         fcc   "Better luck next time."
         fcb   C$CR

MOTD     fcc   "SYS/MOTD"
         fcb   C$CR

Root     fcc   "...... "

IcptRtn  rti			note, was rts in original code

start    leas  >linebuff,u
         pshs  y,x
         leax  <IcptRtn,pcr
         os9   F$Icpt   
         IFGT  Level-1
         bcs   L0172
         ldy   #$0000		super user ID
         os9   F$SUser  	set user ID to super user
         ENDC
L0172    puls  y,x
         lbcs  Exit
         clr   <u0000
         leay  >u01DD,u
         sty   <buffnext
         leay  >readbuff,u
         sty   <rdbufptr
         std   ,--s
         beq   L0194
L018C    lda   ,x+
         sta   ,y+
         cmpa  #C$CR
         bne   L018C
L0194    lda   #$01
         ldb   #SS.ScSiz
         os9   I$GetStt 
         bcc   L01A4
         cmpb  #E$UnkSvc
         beq   L01AB
         lbra  L0280
L01A4    cmpx  #$0046
         bcc   L01AB
         inc   <u0000
L01AB    lda   #READ.
         leax  >Root,pcr
         os9   I$ChgDir 
         lda   #READ.
         leax  >PassFile,pcr
         os9   I$Open   
         lbcs  Exit
         sta   <PassPath
         lda   #$03
         sta   <u0003
         ldd   ,s++
         beq   L01D3
         ldx   <rdbufptr
         lda   ,x
         cmpa  #C$CR
         bne   L0209
L01D3    tst   <u0000
         beq   L01E1
         leax  >NrrwMsg,pcr
         ldy   #NrrwMsgL
         bra   L01E9
L01E1    leax  >WideMsg,pcr
         ldy   #WideMsgL
L01E9    lbsr  L032F
L01EC    dec   <u0003
         leax  >Sorry,pcr
         lbmi  L031F
         leax  >readbuff,u
         stx   <rdbufptr
         leax  >UName,pcr
         ldy   #UNameLen
         lbsr  L0347
         bcs   L020E
L0209    lbsr  L0393
         bcc   L0217
L020E    leax  >Who,pcr
L0212    lbsr  L0325
         bra   L01EC
L0217    lbsr  L03B9
         bcc   L0253
         ldx   <rdbufptr
         lda   ,x
         cmpa  #C$CR
         bne   L0242
         lda   #C$COMA
         sta   ,x+
         stx   <rdbufptr
         lbsr  L0357
         leax  >Pass,pcr
         ldy   #PassLen
         lbsr  L0347
         lbsr  L037F
         bcs   L020E
         lbsr  L03B9
         bcc   L0253
L0242    leax  >readbuff,u
         stx   <rdbufptr
         lbsr  L03A1
         bcc   L0217
         leax  >nvPass,pcr
         bra   L0212
L0253    lda   <PassPath
         os9   I$Close  
         lbsr  L0408
         tfr   d,y
         IFGT  Level-1
         os9   F$SUser  
         ENDC
         lbsr  L0408
         tsta  
         lbne  L031B
         tstb  
         lbeq  L031B
         stb   <u0005
         os9   F$ID     		get user id
         sta   <DefUID			save off
         lda   #READ.
         leax  >MOTD,pcr
         os9   I$Open   
         bcc   L0280
         clra  
L0280    sta   <u0002
         lda   #$04
         bsr   L02F7
         lda   #$03
         bsr   L02F7
         leax  >ProcNum,pcr
         ldy   #ProcNumL
         lbsr  L033D
         leax  DefUID,u
         lbsr  L0471
         tst   <u0000
         beq   L02A8
         leax  >lo2,pcr
         ldy   #lo2len
         bra   L02B0
L02A8    leax  >lo1,pcr
         ldy   #lo1len
L02B0    bsr   L032F
         leax  >Welcome,pcr
         bsr   L0325
         lbsr  L03F0
         clrb  
         ldx   <u0006
         leau  ,x
L02C0    lda   ,u+
         cmpa  #'0
         bcc   L02C0
         cmpa  #C$COMA
         beq   L02CC
         leau  -PassPath,u
L02CC    lda   ,u+
         cmpa  #C$SPAC
         beq   L02CC
         leau  -PassPath,u
         pshs  u
         ldy   #$0000
L02DA    lda   ,u+
         leay  $01,y
         cmpa  #C$CR
         bne   L02DA
         puls  u
         lda   <DefUID
         ldb   <u0005
         os9   F$SPrior 	set priority
         ldd   #256
         os9   F$Chain  
         os9   F$PErr   
Exit     os9   F$Exit   
L02F7    ldx   <u0006
         os9   I$ChgDir 
         bcs   L0315
         ldx   <u0006
L0300    lda   ,x+
         cmpa  #C$CR
         beq   L031B
         cmpa  #C$COMA
         bne   L0300
         lda   #C$SPAC
L030C    cmpa  ,x+
         beq   L030C
         leax  ,-x
         stx   <u0006
         rts   
L0315    leax  >DirNotFnd,pcr
         bra   L031F
L031B    leax  >Syntax,pcr
L031F    bsr   L0325
         clrb  
         os9   F$Exit   
L0325    ldy   #256
         lda   #$01
         os9   I$WritLn 
         rts   
L032F    bsr   L033D
         lbsr  SpcInBuf
         lbsr  SpcInBuf
         lbsr  SpcInBuf
         lbra  L0454
L033D    lda   ,x+
         lbsr  AinBuf
         leay  -$01,y
         bne   L033D
         rts   
L0347    bsr   L033D
         lbsr  L04AC
         ldx   <rdbufptr
         ldy   #80
         clra  
         os9   I$ReadLn 
         rts   
L0357    pshs  x,b,a
         leax  >u022D,u
         ldb   #SS.Opt
         clra  
         os9   I$GetStt 
         bcs   L0379
         lda   ,x
         cmpa  #$00
         bne   L0379
         lda   $04,x
         pshs  a
         clr   $04,x
         bsr   L037F
         puls  a
         sta   $04,x
         puls  pc,x,b,a
L0379    lda   #$FF
         sta   ,x
         puls  pc,x,b,a
L037F    pshs  x,b,a,cc
         leax  >u022D,u
         lda   ,x
         cmpa  #$00
         bne   L0391
         ldb   #SS.Opt
         clra  
         os9   I$SetStt 
L0391    puls  pc,x,b,a,cc
L0393    pshs  u
         lda   <PassPath
         ldx   #$0000
         leau  ,x
         os9   I$Seek   
         puls  u
L03A1    lda   <PassPath
         leax  >linebuff,u
         ldy   #128
         os9   I$ReadLn 
         bcs   L03B8
         stx   <u0006
         bsr   L03B9
         bcs   L03A1
         stx   <u0006
L03B8    rts   
L03B9    ldx   <u0006
         ldy   <rdbufptr
L03BE    lda   ,x+
         cmpa  #C$COMA
         beq   L03D2
         cmpa  #C$CR
         beq   L03D0
         eora  ,y+
         anda  #$DF
         beq   L03BE
L03CE    comb  
         rts   
L03D0    leax  -$01,x
L03D2    lda   ,y+
         cmpa  #C$COMA
         beq   L03DE
         cmpa  #'0
         bcc   L03CE
         leay  -$01,y
L03DE    lda   ,y+
         cmpa  #C$SPAC
         beq   L03DE
         leay  -$01,y
         sty   <rdbufptr
         stx   <u0006
         clrb  
         rts   
L03ED    lbsr  L0325
L03F0    lda   <u0002
         beq   L0406
         leax  >readbuff,u
         ldy   #80
         os9   I$ReadLn 
         bcc   L03ED
         lda   <u0002
         os9   I$Close  
L0406    clrb  
         rts   
L0408    ldx   <u0006
         clra  
         clrb  
         pshs  y,x,b,a
         pshs  b
L0410    ldb   ,x+
         cmpb  #C$PERD
         bne   L0423
         tsta  
         lbne  L031B
         ldb   $02,s
         stb   ,s
         clr   $02,s
         bra   L0410
L0423    subb  #$30
         cmpb  #$09
         bhi   L043C
         clra  
         ldy   #$000A
L042E    addd  $01,s
         lbcs  L031B
         leay  -$01,y
         bne   L042E
         std   $01,s
         bra   L0410
L043C    lda   -$01,x
         cmpa  #C$COMA
         lbne  L031B
         stx   <u0006
         lda   ,s+
         beq   L0452
         tst   ,s
         lbne  L031B
         sta   ,s
L0452    puls  pc,y,x,b,a
L0454    leax  timebuff,u
         os9   F$Time   		get current time
         bsr   Y2K
         bsr   SpcInBuf
         bsr   L0461
         bra   L04A4
L0461    bsr   L0471
         bsr   L0465
L0465    lda   #$3A
         bra   L046F

Y2K      lda   #19			start out in 19th century
         ldb   ,x			get year
CntyLp   subb  #100			subtract
         bcs   GotCntry			if carry set, we have century
         inca
         bra   CntyLp			continue
GotCntry addb  #100
         stb   ,x
         tfr   a,b
PrCnty   bsr   Byt2ASC
L0469    bsr   L0471
         bsr   Slash
Slash    lda   #'/
L046F    bsr   AinBuf			add slash to buffer
L0471    ldb   ,x+
Byt2ASC  lda   #$2F
         clr   <u000C
L0477    inca  
         subb  #100
         bcc   L0477
         bsr   L048D
         lda   #$3A
L0480    deca  
         addb  #10
         bcc   L0480
         bsr   AinBuf
         tfr   b,a
         adda  #'0
         bra   AinBuf
L048D    inc   <u000C
         cmpa  #'0
         bne   AinBuf
         dec   <u000C
         bne   AinBuf
         rts   

SpcInBuf lda   #C$SPAC
AinBuf   pshs  x
         ldx   <buffnext
         sta   ,x+
         stx   <buffnext
         puls  pc,x

L04A4    pshs  a
         lda   #C$CR
         bsr   AinBuf
         puls  a
L04AC    pshs  y,x,b,a
         leax  >u01DD,u
         ldd   <buffnext
         stx   <buffnext
         subd  <buffnext
         tfr   d,y
         lda   #$01
         os9   I$WritLn 
         puls  pc,y,x,b,a

         emod
eom      equ   *
         end
