********************************************************************
* progname - program module
*
* $Id$
*
* Ed.    Comments                                       Who YY/MM/DD
* ------------------------------------------------------------------
*  -     Original Dragon Data distribution version
*
*

         nam   DDisk
         ttl   os9 device driver    

* Disassembled 02/04/21 22:37:46 by Disasm v1.6 (C) 1988 by RML

         ifp1
         use   defsfile
         use   rbfdefs
         endc

tylg     set   Drivr+Objct   
atrv     set   ReEnt+rev
rev      set   $01
edition  set   3

MaxDrv   set   4

         mod   eom,name,tylg,atrv,start,size
u0000    rmb   3
u0003    rmb   2
u0005    rmb   1
u0006    rmb   2
u0008    rmb   7
u000F    rmb   19
u0022    rmb   1
u0023    rmb   29
u0040    rmb   3
u0043    rmb   5
u0048    rmb   95
u00A7    rmb   2
DrivSel  rmb   1
u00AA    rmb   1
u00AB    rmb   1
u00AC    rmb   1
u00AD    rmb   2
size     equ   .
         fcb   $FF 
name     equ   *
         fcs   /DDisk/
         fcb   edition

start    lbra  Init
         lbra  Read
         lbra  Write
         lbra  GetStat
         lbra  SetStat
         lbra  Term

* Init
*
* Entry:
*    Y  = address of device descriptor
*    U  = address of device memory area
*
* Exit:
*    CC = carry set on error
*    B  = error code
*
Init     clra  
         sta   >$006F
         sta   >DPort+8
         ldx   #DPort
         lda   #$D0
         sta   ,x
         lbsr  L02AB
         lda   ,x
         lda   #$FF
         ldb   #MaxDrv
         leax  u000F,u
L003F    sta   ,x
         sta   <$15,x
         leax  <$26,x
         decb  
         bne   L003F
         leax  >L0172,pcr
         stx   >$010A
         lda   #$7E
         sta   >$0109
         ldd   #$0100
         pshs  u
         os9   F$SRqMem 
         tfr   u,x
         puls  u
         bcs   Return
         stx   >u00AD,u
         clrb  
Return   rts   

* GetStat
*
* Entry:
*    A  = function code
*    Y  = address of path descriptor
*    U  = address of device memory area
*
* Exit:
*    CC = carry set on error
*    B  = error code
*
GetStat

* Term
*
* Entry:
*    U  = address of device memory area
*
* Exit:
*    CC = carry set on error
*    B  = error code
*
Term     clrb  
         rts   

* Read
*
* Entry:
*    B  = MSB of the disk's LSN
*    X  = LSB of the disk's LSN
*    Y  = address of path descriptor
*    U  = address of device memory area
*
* Exit:
*    CC = carry set on error
*    B  = error code
*
Read     lda   #$91
         cmpx  #$0000
         bne   L0096
         bsr   L0096
         bcs   L008C
         ldx   $08,y
         pshs  y,x
         ldy   >u00A7,u
         ldb   #$14
L0082    lda   b,x
         sta   b,y
         decb  
         bpl   L0082
         clrb  
         puls  pc,y,x
L008C    rts   
L008D    bcc   L0096
         pshs  x,b,a
         lbsr  L02E9
         puls  x,b,a

L0096    pshs  x,b,a
         bsr   L00A1
         puls  x,b,a
         bcc   L008C
         lsra  
         bne   L008D
L00A1    lbsr  L01BC
         bcs   L008C
         ldx   $08,y
         pshs  y,dp,cc
         ldb   #$88
         bsr   L00C6
L00AE    lda   <u0023
         bmi   L00BE
         leay  -$01,y
         bne   L00AE
         bsr   L0107
         puls  y,dp,cc
         lbra  L0288
L00BD    sync  
L00BE    lda   <u0043
         ldb   <u0022
         sta   ,x+
         bra   L00BD
L00C6    lda   #$FF
         tfr   a,dp
         lda   <u0006
         sta   >u00AC,u
         anda  #$FE
         sta   <u0006
         bita  #$40
         beq   L00DE
L00D8    lda   <u0005
         bita  #$10
         beq   L00D8
L00DE    orcc  #$50
         lda   <u0003
         sta   >u00AB,u
         lda   #$34
         sta   <u0003
         lda   <u0006
         anda  #$FE
         sta   <u0006
         lda   <u0023
         ora   #$03
         sta   <u0023
         lda   <u0022
         ldy   #$FFFF
         lda   #$24
         ora   >DrivSel,u
         stb   <u0040
         sta   <u0048
         rts   
L0107    lda   >DrivSel,u
         ora   #$04
         sta   <u0048
         lda   >u00AB,u
         sta   <u0003
         lda   <u0023
         anda  #$FC
         sta   <u0023
         lda   >u00AC,u
         sta   <u0006
         rts   

* Write
*
* Entry:
*    B  = MSB of the disk's LSN
*    X  = LSB of the disk's LSN
*    Y  = address of path descriptor
*    U  = address of device memory area
*
* Exit:
*    CC = carry set on error
*    B  = error code
*
Write    lda   #$91
L0124    pshs  x,b,a
         bsr   L0148
         puls  x,b,a
         bcs   L0138
         tst   <$28,y
         bne   L0136
         lbsr  L0184
         bcs   L0138
L0136    clrb  
         rts   
L0138    lsra  
         lbeq  L027C
         bcc   L0124
         pshs  x,b,a
         lbsr  L02E9
         puls  x,b,a
         bra   L0124
L0148    lbsr  L01BC
         lbcs  L008C
         ldx   $08,y
         pshs  y,dp,cc
         ldb   #$A8
L0155    lbsr  L00C6
         lda   ,x+
L015A    ldb   <u0023
         bmi   L016C
         leay  -$01,y
         bne   L015A
         bsr   L0107
         puls  y,dp,cc
         lbra  L027C
L0169    lda   ,x+
         sync  
L016C    sta   <u0043
         ldb   <u0022
         bra   L0169
L0172    leas  $0C,s
         bsr   L0107
         puls  y,dp,cc
         ldb   >DPort
         bitb  #$04
         lbne  L0288
         lbra  L025A
L0184    pshs  x,b,a
         ldx   $08,y
         pshs  x
         ldx   >u00AD,u
         stx   $08,y
         ldx   $04,s
         lbsr  L00A1
         puls  x
         stx   $08,y
         bcs   L01BA
         lda   #$20
         pshs  u,y,a
         ldy   >u00AD,u
         tfr   x,u
L01A6    ldx   ,u
         cmpx  ,y
         bne   L01B6
         leau  u0008,u
         leay  $08,y
         dec   ,s
         bne   L01A6
         bra   L01B8
L01B6    orcc  #$01
L01B8    puls  u,y,a
L01BA    puls  pc,x,b,a
L01BC    clr   >u00AA,u
         bsr   L022F
         tstb  
         bne   L01D6
         tfr   x,d
         ldx   >u00A7,u
         cmpd  #$0000
         beq   L01FB
         cmpd  $01,x
         bcs   L01DA
L01D6    comb  
         ldb   #$F1
         rts   
L01DA    clr   ,-s
         bra   L01E0
L01DE    inc   ,s
L01E0    subd  #$0012
         bcc   L01DE
         addb  #$12
         puls  a
         cmpa  #$10
         bls   L01FB
         pshs  a
         lda   >DrivSel,u
         ora   #$10
         sta   >DrivSel,u
         puls  a
L01FB    incb  
L01FC    stb   >DPort+2
         lbsr  L02AB
         cmpb  >DPort+2
         bne   L01FC
L0207    ldb   <$15,x
         stb   >DPort+1
         tst   >u00AA,u
         bne   L0218
         cmpa  <$15,x
         beq   L022D
L0218    sta   <$15,x
         sta   >DPort+3
         ldb   #$12
         bsr   L028C
         pshs  x
         ldx   #$222E
L0227    leax  -$01,x
         bne   L0227
         puls  x
L022D    clrb  
         rts   

L022F    lbsr  L0305
         lda   <$21,y
         cmpa  #MaxDrv
         bcs   L023D
         comb  
         ldb   #E$Unit
         rts   

L023D    pshs  x,b,a
         sta   >DrivSel,u
         leax  u000F,u
         ldb   #$26
         mul   
         leax  d,x
         cmpx  >u00A7,u
         beq   L0258
         stx   >u00A7,u
         com   >u00AA,u
L0258    puls  pc,x,b,a
L025A    bitb  #$F8
         beq   L0272
         bitb  #$80
         bne   L0274
         bitb  #$40
         bne   L0278
         bitb  #$20
         bne   L027C
         bitb  #$10
         bne   L0280
         bitb  #$08
         bne   L0284
L0272    clrb  
         rts   
L0274    comb  
         ldb   #E$NotRdy
         rts   
L0278    comb  
         ldb   #E$WP
         rts   
L027C    comb  
         ldb   #E$Write
         rts   
L0280    comb  
         ldb   #E$Seek
         rts   
L0284    comb  
         ldb   #E$CRC
         rts   
L0288    comb  
         ldb   #E$Read
         rts   
L028C    bsr   L02A9
L028E    ldb   >DPort
         bitb  #$01
         beq   L02B1
         lda   #$F0
         sta   >$006F
         bra   L028E
L029C    lda   #$04
         ora   >DrivSel,u
         sta   >DPort+8
         stb   >DPort
         rts   
L02A9    bsr   L029C
L02AB    lbsr  L02AE
L02AE    lbsr  L02B1
L02B1    rts   

* SetStat
*
* Entry:
*    A  = function code
*    Y  = address of path descriptor
*    U  = address of device memory area
*
* Exit:
*    CC = carry set on error
*    B  = error code
*
SetStat  ldx   $06,y
         ldb   $02,x
         cmpb  #$03
         beq   L02E9
         cmpb  #$04
         beq   L02C2
         comb  
         ldb   #$D0
L02C1    rts   
L02C2    lbsr  L022F
         lda   $09,x
         cmpa  #$10
         bls   L02D5
         ldb   >DrivSel,u
         orb   #$10
         stb   >DrivSel,u
L02D5    ldx   >u00A7,u
         lbsr  L0207
         bcs   L02C1
         ldx   $06,y
         ldx   $04,x
         ldb   #$F0
         pshs  y,dp,cc
         lbra  L0155
L02E9    lbsr  L022F
         ldx   >u00A7,u
         clr   <$15,x
         lda   #$05
L02F5    ldb   #$42
         pshs  a
         lbsr  L028C
         puls  a
         deca  
         bne   L02F5
         ldb   #$02
         bra   L028C
L0305    pshs  x,b,a
         lda   >$006F
         bne   L031A
         lda   #$04
         sta   >DPort+8
         ldx   #$A000
L0314    nop   
         nop   
         leax  -$01,x
         bne   L0314
L031A    lda   #$F0
         sta   >$006F
         puls  pc,x,b,a

         emod
eom      equ   *
         end
