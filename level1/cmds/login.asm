********************************************************************
* Login - Timeshare login utility
*
* $Id$
*
* Ed.    Comments                                       Who YY/MM/DD
* ------------------------------------------------------------------
* 12     Original Tandy version
* 13     Fixed for years 1900-2155                      BGP 99/05/11

         nam   Login
         ttl   Timeshare login utility

         ifp1
         use   defsfile
         endc

tylg     set   Prgrm+Objct   
atrv     set   ReEnt+rev
rev      set   $01
edition  set   13

         mod   eom,name,tylg,atrv,start,size

u0000    rmb   1
u0001    rmb   1
u0002    rmb   1
u0003    rmb   1
u0004    rmb   1
u0005    rmb   1
u0006    rmb   2
u0008    rmb   2
u000A    rmb   2
u000C    rmb   1
u000D    rmb   256
u010D    rmb   128
u018D    rmb   80
u01DD    rmb   80
u022D    rmb   32
size     equ   .

name     fcs   /Login/
         fcb   edition

L0013    fcc   "SYS/PASSWORD"
         fcb   C$CR
         fcc   ",,,,,,,,,,,,,,,"
WideMsg  fcb   C$LF,C$LF
         fcc   "OS-9 Timesharing system   Level I 0"
         fcb   48+OS9Vrsn
         fcc   ".0"
         fcb   48+OS9Major
         fcc   ".0"
         fcb   48+OS9Minor
WideMsgL equ   *-WideMsg
NrrwMsg  fcb   C$LF,C$LF
         fcc   "OS-9 Level I 0"
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

InvPass  fcc   "Invalid password."
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

start    leas  >u010D,u
         clr   <u0000
         leay  >u01DD,u
         sty   <u000A
         leay  >u018D,u
         sty   <u0008
         std   ,--s
         beq   L016D
L0165    lda   ,x+
         sta   ,y+
         cmpa  #C$CR
         bne   L0165
L016D    lda   #$01
         ldb   #SS.ScSiz
         os9   I$GetStt 
         bcc   L017D
         cmpb  #E$UnkSvc
         beq   L0184
         lbra  L025A
L017D    cmpx  #80
         beq   L0184
         inc   <u0000
L0184    lda   #READ.
         leax  >Root,pcr
         os9   I$ChgDir 
         lda   #READ.
         leax  >L0013,pcr
         os9   I$Open   
         lbcs  L02CE
         sta   <u0001
         lda   #$03
         sta   <u0003
         ldd   ,s++
         beq   L01AC
         ldx   <u0008
         lda   ,x
         cmpa  #C$CR
         bne   L01E2
L01AC    tst   <u0000
         beq   L01BA
         leax  >NrrwMsg,pcr
         ldy   #NrrwMsgL
         bra   L01C2
L01BA    leax  >WideMsg,pcr
         ldy   #WideMsgL
L01C2    lbsr  L0309
L01C5    dec   <u0003
         leax  >Sorry,pcr
         lbmi  L02F9
         leax  >u018D,u
         stx   <u0008
         leax  >UName,pcr
         ldy   #UNameLen
         lbsr  L0321
         bcs   L01E7
L01E2    lbsr  L036D
         bcc   L01F0
L01E7    leax  >Who,pcr
L01EB    lbsr  L02FF
         bra   L01C5
L01F0    lbsr  L0393
         bcc   L022C
         ldx   <u0008
         lda   ,x
         cmpa  #C$CR
         bne   L021B
         lda   #C$COMA
         sta   ,x+
         stx   <u0008
         lbsr  L0331
         leax  >Pass,pcr
         ldy   #PassLen
         lbsr  L0321
         lbsr  L0359
         bcs   L01E7
         lbsr  L0393
         bcc   L022C
L021B    leax  >u018D,u
         stx   <u0008
         lbsr  L037B
         bcc   L01F0
         leax  >InvPass,pcr
         bra   L01EB
L022C    lda   <u0001
         os9   I$Close  
         lbsr  L03E2
         ldy   >$004B
         std   $09,y
         lbsr  L03E2
         tsta  
         lbne  L02F5
         tstb  
         lbeq  L02F5
         stb   <u0005
         os9   F$ID     
         sta   <u0004
         lda   #READ.
         leax  >MOTD,pcr
         os9   I$Open   
         bcc   L025A
         clra  
L025A    sta   <u0002
         lda   #$04
         bsr   L02D1
         lda   #$03
         bsr   L02D1
         leax  >ProcNum,pcr
         ldy   #ProcNumL
         lbsr  L0317
         leax  u0004,u
         lbsr  L044B
         tst   <u0000
         beq   L0282
         leax  >lo2,pcr
         ldy   #lo2len
         bra   L028A
L0282    leax  >lo1,pcr
         ldy   #lo1len
L028A    bsr   L0309
         leax  >Welcome,pcr
         bsr   L02FF
         lbsr  L03CA
         clrb  
         ldx   <u0006
         leau  ,x
L029A    lda   ,u+
         cmpa  #'0
         bcc   L029A
         cmpa  #C$COMA
         beq   L02A6
         leau  -u0001,u
L02A6    lda   ,u+
         cmpa  #C$SPAC
         beq   L02A6
         leau  -u0001,u
         pshs  u
         ldy   #$0000
L02B4    lda   ,u+
         leay  $01,y
         cmpa  #C$CR
         bne   L02B4
         puls  u
         lda   <u0004
         ldb   <u0005
         os9   F$SPrior 
         ldd   #$0100
         os9   F$Chain  
         os9   F$PErr   
L02CE    os9   F$Exit   
L02D1    ldx   <u0006
         os9   I$ChgDir 
         bcs   L02EF
         ldx   <u0006
L02DA    lda   ,x+
         cmpa  #C$CR
         beq   L02F5
         cmpa  #C$COMA
         bne   L02DA
         lda   #C$SPAC
L02E6    cmpa  ,x+
         beq   L02E6
         leax  ,-x
         stx   <u0006
         rts   
L02EF    leax  >DirNotFnd,pcr
         bra   L02F9
L02F5    leax  >Syntax,pcr
L02F9    bsr   L02FF
         clrb  
         os9   F$Exit   
L02FF    ldy   #$0100
         lda   #$01
         os9   I$WritLn 
         rts   
L0309    bsr   L0317
         lbsr  L0472
         lbsr  L0472
         lbsr  L0472
         lbra  L042E
L0317    lda   ,x+
         lbsr  L0474
         leay  -$01,y
         bne   L0317
         rts   
L0321    bsr   L0317
         lbsr  L0486
         ldx   <u0008
         ldy   #80
         clra  
         os9   I$ReadLn 
         rts   
L0331    pshs  x,b,a
         leax  >u022D,u
         ldb   #SS.Opt
         clra  
         os9   I$GetStt 
         bcs   L0353
         lda   ,x
         cmpa  #$00
         bne   L0353
         lda   $04,x
         pshs  a
         clr   $04,x
         bsr   L0359
         puls  a
         sta   $04,x
         puls  pc,x,b,a
L0353    lda   #$FF
         sta   ,x
         puls  pc,x,b,a
L0359    pshs  x,b,a,cc
         leax  >u022D,u
         lda   ,x
         cmpa  #$00
         bne   L036B
         ldb   #SS.Opt
         clra  
         os9   I$SetStt 
L036B    puls  pc,x,b,a,cc
L036D    pshs  u
         lda   <u0001
         ldx   #$0000
         leau  ,x
         os9   I$Seek   
         puls  u
L037B    lda   <u0001
         leax  >u010D,u
         ldy   #$0080
         os9   I$ReadLn 
         bcs   L0392
         stx   <u0006
         bsr   L0393
         bcs   L037B
         stx   <u0006
L0392    rts   
L0393    ldx   <u0006
         ldy   <u0008
L0398    lda   ,x+
         cmpa  #C$COMA
         beq   L03AC
         cmpa  #C$CR
         beq   L03AA
         eora  ,y+
         anda  #$DF
         beq   L0398
L03A8    comb  
         rts   
L03AA    leax  -$01,x
L03AC    lda   ,y+
         cmpa  #C$COMA
         beq   L03B8
         cmpa  #'0
         bcc   L03A8
         leay  -$01,y
L03B8    lda   ,y+
         cmpa  #C$SPAC
         beq   L03B8
         leay  -$01,y
         sty   <u0008
         stx   <u0006
         clrb  
         rts   
L03C7    lbsr  L02FF
L03CA    lda   <u0002
         beq   L03E0
         leax  >u018D,u
         ldy   #80
         os9   I$ReadLn 
         bcc   L03C7
         lda   <u0002
         os9   I$Close  
L03E0    clrb  
         rts   
L03E2    ldx   <u0006
         clra  
         clrb  
         pshs  y,x,b,a
         pshs  b
L03EA    ldb   ,x+
         cmpb  #C$PERD
         bne   L03FD
         tsta  
         lbne  L02F5
         ldb   $02,s
         stb   ,s
         clr   $02,s
         bra   L03EA
L03FD    subb  #$30
         cmpb  #$09
         bhi   L0416
         clra  
         ldy   #$000A
L0408    addd  $01,s
         lbcs  L02F5
         leay  -$01,y
         bne   L0408
         std   $01,s
         bra   L03EA
L0416    lda   -$01,x
         cmpa  #C$COMA
         lbne  L02F5
         stx   <u0006
         lda   ,s+
         beq   L042C
         tst   ,s
         lbne  L02F5
         sta   ,s
L042C    puls  pc,y,x,b,a
L042E    leax  u000D,u
         os9   F$Time   
         bsr   L0443
         bsr   L0472
         bsr   L043B
         bra   L047E
L043B    bsr   L044B
         bsr   L043F
L043F    lda   #$3A
         bra   L0449
L0443    ldb   ,x
         cmpb  #100
         blo   L1900
         subb  #100
         cmpb  #100
         blo   L2000
L2100    subb  #100
         stb   ,x
         ldb   #21
         bra   PrCnty
L1900    stb   ,x
         ldb   #19
         bra   PrCnty
L2000    stb   ,x
         ldb   #20
PrCnty   bsr   L044D
         bsr   L044B
         bsr   L0447
L0447    lda   #$2F
L0449    bsr   L0474
L044B    ldb   ,x+
L044D    lda   #$2F
         clr   <u000C
L0451    inca  
         subb  #$64
         bcc   L0451
         bsr   L0467
         lda   #$3A
L045A    deca  
         addb  #$0A
         bcc   L045A
         bsr   L0474
         tfr   b,a
         adda  #$30
         bra   L0474
L0467    inc   <u000C
         cmpa  #$30
         bne   L0474
         dec   <u000C
         bne   L0474
         rts   
L0472    lda   #C$SPAC
L0474    pshs  x
         ldx   <u000A
         sta   ,x+
         stx   <u000A
         puls  pc,x
L047E    pshs  a
         lda   #C$CR
         bsr   L0474
         puls  a
L0486    pshs  y,x,b,a
         leax  >u01DD,u
         ldd   <u000A
         stx   <u000A
         subd  <u000A
         tfr   d,y
         lda   #$01
         os9   I$WritLn 
         puls  pc,y,x,b,a

         emod
eom      equ   *
         end
