********************************************************************
* Login - Allow remote shell access
*
* $Id$
*
* Ed.    Comments                                       Who YY/MM/DD
* ------------------------------------------------------------------
* 16     Original Tandy distribution version
* 17     Changed Icpt routine's rts to rti              BGP 98/10/15

         nam   Login
         ttl   Allow remote shell access

* Disassembled 98/09/14 23:54:24 by Disasm v1.6 (C) 1988 by RML

         ifp1
         use   defsfile
         endc

tylg     set   Prgrm+Objct   
atrv     set   ReEnt+rev
rev      set   $01
edition  set   17

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
L002F    fcb   C$LF
         fcb   C$LF
         fcc   "OS-9 Timesharing system"
         fcb   C$LF
         fcc   "Level II  RS VR. 0"
         fcb   48+OS9Vrsn
         fcc   ".0"
         fcb   48+OS9Major
         fcc   ".0"
         fcb   48+OS9Minor
         fcb   C$LF
L0063    fcb   C$LF
         fcb   C$LF
         fcc   "OS-9 Level II  RS Vr0"
         fcb   48+OS9Vrsn
         fcc   ".0"
         fcb   48+OS9Major
         fcc   ".0"
         fcb   48+OS9Minor
         fcb   C$LF
L0082    fcb   C$LF
         fcc   "User name?: "
L008F    fcc   "Who?"
         fcb   C$CR
L0094    fcc   "Password: "
L009E    fcc   "Invalid password."
         fcb   C$CR
L00B0    fcb   C$LF
         fcc   "Process #"
L00BA    fcc   " logged on "
L00C5    fcc   " logged on "
         fcb   C$LF
L00D1    fcc   "Welcome!"
         fcb   C$CR
L00DA    fcc   "Directory not found."
         fcb   C$CR
L00EF    fcb   C$LF
         fcc   "Syntax Error in password file"
L010D    fcb   C$LF
         fcc   "It's been nice communicating with you."
         fcb   C$LF
         fcc   "Better luck next time."
         fcb   C$CR
L014C    fcc   "SYS/MOTD"
         fcb   C$CR
L0155    fcc   "...... "

IcptRtn  rti       changed from rts ++BGP

start    leas  >u010D,u
         pshs  y,x
         leax  <IcptRtn,pcr
         os9   F$Icpt   
         bcs   L0172
         ldy   #$0000
         os9   F$SUser  
L0172    puls  y,x
         lbcs  L02F4
         clr   <u0000
         leay  >u01DD,u
         sty   <u000A
         leay  >u018D,u
         sty   <u0008
         std   ,--s
         beq   L0194
L018C    lda   ,x+
         sta   ,y+
         cmpa  #$0D
         bne   L018C
L0194    lda   #$01
         ldb   #SS.ScSiz
         os9   I$GetStt 
         bcc   L01A4
         cmpb  #$D0
         beq   L01AB
         lbra  L0280
L01A4    cmpx  #$0046
         bcc   L01AB
         inc   <u0000
L01AB    lda   #$01
         leax  >L0155,pcr
         os9   I$ChgDir 
         lda   #$01
         leax  >L0013,pcr
         os9   I$Open   
         lbcs  L02F4
         sta   <u0001
         lda   #$03
         sta   <u0003
         ldd   ,s++
         beq   L01D3
         ldx   <u0008
         lda   ,x
         cmpa  #$0D
         bne   L0209
L01D3    tst   <u0000
         beq   L01E1
         leax  >L0063,pcr
         ldy   #$001F
         bra   L01E9
L01E1    leax  >L002F,pcr
         ldy   #$0034
L01E9    lbsr  L032F
L01EC    dec   <u0003
         leax  >L010D,pcr
         lbmi  L031F
         leax  >u018D,u
         stx   <u0008
         leax  >L0082,pcr
         ldy   #$000D
         lbsr  L0347
         bcs   L020E
L0209    lbsr  L0393
         bcc   L0217
L020E    leax  >L008F,pcr
L0212    lbsr  L0325
         bra   L01EC
L0217    lbsr  L03B9
         bcc   L0253
         ldx   <u0008
         lda   ,x
         cmpa  #$0D
         bne   L0242
         lda   #$2C
         sta   ,x+
         stx   <u0008
         lbsr  L0357
         leax  >L0094,pcr
         ldy   #$000A
         lbsr  L0347
         lbsr  L037F
         bcs   L020E
         lbsr  L03B9
         bcc   L0253
L0242    leax  >u018D,u
         stx   <u0008
         lbsr  L03A1
         bcc   L0217
         leax  >L009E,pcr
         bra   L0212
L0253    lda   <u0001
         os9   I$Close  
         lbsr  L0408
         tfr   d,y
         os9   F$SUser  
         lbsr  L0408
         tsta  
         lbne  L031B
         tstb  
         lbeq  L031B
         stb   <u0005
         os9   F$ID     
         sta   <u0004
         lda   #$01
         leax  >L014C,pcr
         os9   I$Open   
         bcc   L0280
         clra  
L0280    sta   <u0002
         lda   #$04
         bsr   L02F7
         lda   #$03
         bsr   L02F7
         leax  >L00B0,pcr
         ldy   #$000A
         lbsr  L033D
         leax  u0004,u
         lbsr  L0471
         tst   <u0000
         beq   L02A8
         leax  >L00C5,pcr
         ldy   #$000C
         bra   L02B0
L02A8    leax  >L00BA,pcr
         ldy   #$000B
L02B0    bsr   L032F
         leax  >L00D1,pcr
         bsr   L0325
         lbsr  L03F0
         clrb  
         ldx   <u0006
         leau  ,x
L02C0    lda   ,u+
         cmpa  #$30
         bcc   L02C0
         cmpa  #$2C
         beq   L02CC
         leau  -u0001,u
L02CC    lda   ,u+
         cmpa  #$20
         beq   L02CC
         leau  -u0001,u
         pshs  u
         ldy   #$0000
L02DA    lda   ,u+
         leay  $01,y
         cmpa  #$0D
         bne   L02DA
         puls  u
         lda   <u0004
         ldb   <u0005
         os9   F$SPrior 
         ldd   #$0100
         os9   F$Chain  
         os9   F$PErr   
L02F4    os9   F$Exit   
L02F7    ldx   <u0006
         os9   I$ChgDir 
         bcs   L0315
         ldx   <u0006
L0300    lda   ,x+
         cmpa  #$0D
         beq   L031B
         cmpa  #$2C
         bne   L0300
         lda   #$20
L030C    cmpa  ,x+
         beq   L030C
         leax  ,-x
         stx   <u0006
         rts   
L0315    leax  >L00DA,pcr
         bra   L031F
L031B    leax  >L00EF,pcr
L031F    bsr   L0325
         clrb  
         os9   F$Exit   
L0325    ldy   #$0100
         lda   #$01
         os9   I$WritLn 
         rts   
L032F    bsr   L033D
         lbsr  L0498
         lbsr  L0498
         lbsr  L0498
         lbra  L0454
L033D    lda   ,x+
         lbsr  L049A
         leay  -$01,y
         bne   L033D
         rts   
L0347    bsr   L033D
         lbsr  L04AC
         ldx   <u0008
         ldy   #$0050
         clra  
         os9   I$ReadLn 
         rts   
L0357    pshs  x,b,a
         leax  >u022D,u
         ldb   #$00
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
         ldb   #$00
         clra  
         os9   I$SetStt 
L0391    puls  pc,x,b,a,cc
L0393    pshs  u
         lda   <u0001
         ldx   #$0000
         leau  ,x
         os9   I$Seek   
         puls  u
L03A1    lda   <u0001
         leax  >u010D,u
         ldy   #$0080
         os9   I$ReadLn 
         bcs   L03B8
         stx   <u0006
         bsr   L03B9
         bcs   L03A1
         stx   <u0006
L03B8    rts   
L03B9    ldx   <u0006
         ldy   <u0008
L03BE    lda   ,x+
         cmpa  #$2C
         beq   L03D2
         cmpa  #$0D
         beq   L03D0
         eora  ,y+
         anda  #$DF
         beq   L03BE
L03CE    comb  
         rts   
L03D0    leax  -$01,x
L03D2    lda   ,y+
         cmpa  #$2C
         beq   L03DE
         cmpa  #$30
         bcc   L03CE
         leay  -$01,y
L03DE    lda   ,y+
         cmpa  #$20
         beq   L03DE
         leay  -$01,y
         sty   <u0008
         stx   <u0006
         clrb  
         rts   
L03ED    lbsr  L0325
L03F0    lda   <u0002
         beq   L0406
         leax  >u018D,u
         ldy   #$0050
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
         cmpb  #$2E
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
         cmpa  #$2C
         lbne  L031B
         stx   <u0006
         lda   ,s+
         beq   L0452
         tst   ,s
         lbne  L031B
         sta   ,s
L0452    puls  pc,y,x,b,a
L0454    leax  u000D,u
         os9   F$Time   
         bsr   L0469
         bsr   L0498
         bsr   L0461
         bra   L04A4
L0461    bsr   L0471
         bsr   L0465
L0465    lda   #$3A
         bra   L046F
L0469    bsr   L0471
         bsr   L046D
L046D    lda   #$2F
L046F    bsr   L049A
L0471    ldb   ,x+
         lda   #$2F
         clr   <u000C
L0477    inca  
         subb  #$64
         bcc   L0477
         bsr   L048D
         lda   #$3A
L0480    deca  
         addb  #$0A
         bcc   L0480
         bsr   L049A
         tfr   b,a
         adda  #$30
         bra   L049A
L048D    inc   <u000C
         cmpa  #$30
         bne   L049A
         dec   <u000C
         bne   L049A
         rts   
L0498    lda   #$20
L049A    pshs  x
         ldx   <u000A
         sta   ,x+
         stx   <u000A
         puls  pc,x
L04A4    pshs  a
         lda   #$0D
         bsr   L049A
         puls  a
L04AC    pshs  y,x,b,a
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
