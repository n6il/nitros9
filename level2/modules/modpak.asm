********************************************************************
* ModPak - Tandy RS-232/DCM Modem Pak driver
*
* $Id$
*
* Ed.    Comments                                       Who YY/MM/DD
* ------------------------------------------------------------------
* 12     Original Tandy distribution version
* 14     Obtained from L2 Upgrade archive               BGP 98/10/12

         nam   ModPak
         ttl   Tandy RS-232/DCM Modem Pak driver

* Disassembled 98/08/24 23:06:22 by Disasm v1.6 (C) 1988 by RML

         ifp1
         use   defsfile
         endc

tylg     set   Drivr+Objct   
atrv     set   ReEnt+rev
rev      set   $01
edition  set   14

         mod   eom,name,tylg,atrv,start,size

u0000    rmb   1
u0001    rmb   2
u0003    rmb   1
u0004    rmb   1
u0005    rmb   1
u0006    rmb   3
u0009    rmb   2
u000B    rmb   1
u000C    rmb   1
u000D    rmb   1
u000E    rmb   1
u000F    rmb   1
u0010    rmb   6
u0016    rmb   1
u0017    rmb   6
u001D    rmb   2
u001F    rmb   2
u0021    rmb   2
u0023    rmb   2
u0025    rmb   2
u0027    rmb   2
u0029    rmb   2
u002B    rmb   2
u002D    rmb   1
u002E    rmb   1
u002F    rmb   1
u0030    rmb   1
u0031    rmb   1
u0032    rmb   1
u0033    rmb   1
u0034    rmb   1
u0035    rmb   1
u0036    rmb   1
u0037    rmb   1
u0038    rmb   1
u0039    rmb   1
u003A    rmb   1
u003B    rmb   2
u003D    rmb   1
u003E    rmb   1
u003F    rmb   5
u0044    rmb   60
u0080    rmb   20
u0094    rmb   108
size     equ   .
         fcb   $03

name     fcs   /MODPAK/
         fcb   edition

start    equ   *
         lbra  Init
         lbra  Read
         lbra  Write
         lbra  GetStat
         lbra  SetStat
         lbra  Term
L0027    fcb   $00,$80,$0a

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
Init     pshs  dp
         lbsr  L0330
         ldd   <IT.COL,y
	 std   <u0039
         ldd   <IT.PAR,y
         std   <u0036
         clr   <u0038
         lda   <IT.XTYP,y
         ldb   <M$Opt,y
         cmpb  #$1C
         bls   L005D
         sta   <u0038
         anda  #$0F
         beq   L005D
         ldb   #$BB
         stb   <u002F
         clrb
         pshs  u
         os9   F$SRqMem
         tfr   u,x
         puls  u
         bcs   L00C0
         bra   L0068
L005D    ldb   #$4F
         stb   <u002F
         clra
         ldb   #$6C
         leax  >u0094,u
L0068    std   <u0025
         stx   <u0023
         leax  d,x
         stx   <u0027
         subd  #$0020
         std   <u002B
         clra
         ldb   #$20
         std   <u0029
         ldx   <u0001
         ldb   #$0A
         lda   <u0038
         bita  #$40
         beq   L0086
         orb   #$01
L0086    stb   $01,x
         stb   $02,x
         ldd   #$2040
         tst   <u0038
         bpl   L0093
         exg   a,b
L0093    std   <u003D
         ldd   <u0036
         lbsr  L0271
         ldd   <u0001
         addd  #$0001
         leax  >L0027,pcr
         leay  >L0337,pcr
         os9   F$IRQ
         bcs   L00C0
         leay  <u003F,u
         lda   #$80
         sta   $04,y
         ldd   #$0001
         std   $02,y
         tfr   d,x
         os9   F$VIRQ
         bcs   L00C0
         clrb
L00C0    puls  pc,dp
L00C2    bsr   L0110
         bra   L00CB

* Read
*
* Entry:
*    Y  = address of path descriptor
*    U  = address of device memory area
*
* Exit:
*    A  = character read
*    CC = carry set on error
*    B  = error code
*
Read     pshs  dp
         lbsr  L0330
L00CB    lda   <u0031
         bita  #$10
         beq   L00E0
         ldx   <u0021
         cmpx  <u0029
         bhi   L00E0
         lda   #$A0
         ldb   #$05
         lbsr  L040D
         sta   <u0031
L00E0    tst   <u0033
         bne   L015F
         ldx   <u001F
         orcc  #IntMasks
         cmpx  <u001D
         beq   L00C2
         lda   ,x
         leax  $01,x
         cmpx  <u0027
         bcs   L00F6
         ldx   <u0023
L00F6    stx   <u001F
         ldx   <u0021
         leax  -$01,x
         stx   <u0021
         ldb   <u000E
         lbeq  L020F
         clr   <u000E
         stb   <$3A,y
         andcc #^IntMasks
         comb  
         ldb   #E$Read
         puls  pc,dp

L0110    pshs  x,b,a
         lda   >D.Proc
         sta   <u0005
L0117    ldx   >D.Proc
         lda   P$State,x
         ora   #Suspend
         sta   P$State,x
         andcc #^IntMasks
         ldx   #$0001
         os9   F$Sleep
         orcc  #IntMasks
         ldx   >D.Proc
         lda   <P$Signal,x
         beq   L013C
         cmpa  #C$INTR
         bls   L0158
         lda   P$State,x
         bita  #Condem
         bne   L0158
L013C    lda   <u0005
         bne   L0117
         andcc #^IntMasks
         clra
         lda   P$State,x
         bita  #Condem
         bne   L0158
         ldb   #$DC
         lda   <u000E
         bita  #$20
         bne   L0153
         puls  pc,x,b,a

L0153    inc   <$3F,y
         clr   <u000E
L0158    andcc #^IntMasks
         leas  $06,s
         coma  
         puls  pc,dp
L015F    comb  
         ldb   #$F6
         puls  pc,dp
L0164    bsr   L0110
         bra   L016D

* Write
*
* Entry:
*    A  = character to write
*    Y  = address of path descriptor
*    U  = address of device memory area
*
* Exit:
*    CC = carry set on error
*    B  = error code
*
Write    pshs  dp
         lbsr  L0330
L016D    leax  <u0044,u
         ldb   <u002E
         abx   
         sta   ,x
         incb  
         cmpb  <u002F
         bls   L017B
         clrb  
L017B    orcc  #IntMasks
         cmpb  <u002D
         beq   L0164
         stb   <u002E
         lda   <u0030
         beq   L0192
         anda  #$FD
         sta   <u0030
         bne   L0192
         ldb   #$05
         lbsr  L040D
L0192    bra   L020F

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
GetStat  pshs  dp
         lbsr  L0330
         ldx   PD.RGS,y
         cmpa  #SS.Ready
         bne   L01AD
         ldd   <u0021
         beq   L015F
         tsta
         beq   L01A8
         ldb   #$FF
L01A8    stb   R$B,x
L01AA    clrb
         puls  pc,dp
L01AD    cmpa  #SS.EOF
         beq   L01AA
         cmpa  #SS.ScSiz
         beq   L01D6
         cmpa  #SS.ComSt
         beq   L01D0
         cmpa  #SS.CDSta
         bne   L0214
         lda   <u0032
         clrb
         bita  <u003D
         beq   L01C6
         orb   #$20
L01C6    bita  <u003E
         beq   L01CC
         orb   #$40
L01CC    stb   $02,x
         bra   L01AA
L01D0    ldd   <u0036
         std   R$Y,x
         bra   L01AA
L01D6    clra
         ldb   <u0039
         std   R$X,x
         ldb   <u003A
         std   R$Y,x
         bra   L01AA
L01E1    lda   $05,y
         ldb   $05,x
         orcc  #IntMasks
         std   <u003B
         bra   L020F
L01EB    leax  <u003B,u
L01EE    lda   $05,y
         cmpa  ,x
         bne   L01AA
         clr   ,x
         puls  pc,dp

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
SetStat  pshs  dp
         lbsr  L0330
         ldx   PD.RGS,y
         cmpa  #SS.SSig
         bne   L0220
         lda   PD.CPR,y
         ldb   R$X+1,x
         orcc  #IntMasks
         ldx   <u0021
         bne   L0219
         std   <u0033
L020F    clrb
         andcc #^IntMasks
         puls  pc,dp
L0214    comb
         ldb   #E$UnkSvc
         puls  pc,dp
L0219    andcc #^IntMasks
         os9   F$Send
         bra   L024D
L0220    cmpa  #SS.HngUp
         beq   L025A
         cmpa  #SS.Relea
         bne   L022D
         leax  <u0033,u
         bra   L01EE
L022D    cmpa  #SS.CDSig
         beq   L01E1
         cmpa  #SS.CDRel
         beq   L01EB
         cmpa  #SS.ComSt
         beq   L026B
         cmpa  #SS.Break
         bne   L0250
         ldx   <u0001
         lda   $02,x
         pshs  x,a
         ora   #$0C
         sta   $02,x
         bsr   L0291
         puls  x,a
         sta   $02,x
L024D    clrb
L024E    puls  pc,dp
L0250    cmpa  #SS.Open
         beq   L0298
         cmpa  #SS.Close
         beq   L02CF
         bra   L0214
L025A    lbsr  L02DF
         bcs   L024E
         bsr   L0291
         bra   L029E
L0263    fcb   $13,$16,$17,$18,$1a,$1c,$1e,$1f
L026B    ldd   $06,x
         bsr   L0271
L026F    bra   L024D
L0271    std   <u0036
         andb  #$E0
         pshs  b
         ldb   <u0037
         andb  #$0F
         leax  <L0263,pcr
         ldb   b,x
         orb   ,s+
         anda  #$E0
         sta   <u0006
         ldx   <u0001
         lda   $02,x
         anda  #$1F
         ora   <u0006
         std   $02,x
         rts   
L0291    ldx   #$0010
         os9   F$Sleep  
         rts
L0298    lda   $07,x
         cmpa  #$01
         bne   L024D
L029E    ldb   #$09
         orcc  #IntMasks
         lbsr  L040D
         lda   ,x
         lda   ,x
         lda   $01,x
         ldb   $01,x
         ldb   $01,x
         bmi   L02CA
         lda   #$02
         sta   <u0030
         clra  
         andb  #$60
         std   <u0031
         clrb
         std   <u002D
         std   <u0021
         std   <u0033
         ldx   <u0023
         stx   <u001F
         stx   <u001D
         lbra  L020F
L02CA    andcc #^IntMasks
         lbra  L015F
L02CF    lda   $07,x
         bne   L026F
         bsr   L02D7
         puls  pc,dp
L02D7    ldb   #$0B
         lda   <u0038
         bita  #$40
         bne   L02E0
L02DF    clrb
L02E0    bsr   L02F0
         bcs   L02E0
         bsr   L02E8
         clrb
         rts
L02E8    orcc  #IntMasks
         lbsr  L040D
         andcc #^IntMasks
         rts
L02F0    pshs  dp
         bra   L02F7
L02F4    lbsr  L0110
L02F7    lda   <u002E
         orcc  #IntMasks
         cmpa  <u002D
         bne   L02F4
         puls  pc,dp

* Term
*
* Entry:
*    Y  = address of device descriptor
*    U  = address of device memory area
*
* Exit:
*    CC = carry set on error
*    B  = error code
*
Term     pshs  dp
         bsr   L0330
         ldx   >D.Proc
         lda   P$ID,x
         sta   <u0004
         sta   <u0003
         bsr   L02D7
         ldx   #$0000
         leay  <u003F,u
         os9   F$VIRQ
         ldx   #$0000
         os9   F$IRQ
         ldd   <u0025
         tsta
         beq   L032D
         pshs  u
         ldu   <u0023
         os9   F$SRtMem
         puls  u
L032D    clrb
         puls  pc,dp
L0330    pshs  u
         puls  dp
         leas  $01,s
         rts

L0337    pshs  dp
         bsr   L0330
         ldx   <u0001
         sta   <u0035
         tfr   a,b
         andb  #$60
         cmpb  <u0032
         beq   L0392
         tfr   b,a
         eorb  <u0032
         sta   <u0032
         lda   <u0035
         bitb  <u003D
         beq   L037F
         tst   <u003B
         beq   L0362
         pshs  b,a
         ldd   <u003B
         clr   <u003B
         os9   F$Send
         puls  b,a
L0362    bita  <u003D
         beq   L037F
         lda   <u0036
         bita  #$10
         beq   L03B2
         ldx   <u0016
         beq   L0378
L0370    inc   <$3F,x
         ldx   <$3D,x
         bne   L0370
L0378    lda   #$20
         lbsr  L0415
         bra   L03E8
L037F    bitb  <u003E
         beq   L03DC
         ldb   <u0036
         bitb  #$01
         beq   L03DC
         bita  <u003E
         lbeq  L041A
         lbra  L0428
L0392    bita  #$08
         bne   L03FB
         bita  #$10
         beq   L03DC
         lda   <u0031
         bpl   L03B4
         ldb   <u000F
         bita  #$20
         bne   L03A8
         lda   #$10
         ldb   <u0010
L03A8    stb   ,x
         anda  #$10
         sta   <u0031
         lda   <u0030
         bne   L03D6
L03B2    bra   L03DC
L03B4    ldb   <u002D
         cmpb  <u002E
         beq   L03D0
         leax  <u0044,u
         abx
         lda   ,x
         ldx   <u0001
         incb
         cmpb  <u002F
         bls   L03C8
         clrb
L03C8    stb   <u002D
         sta   ,x
         cmpb  <u002E
         bne   L03E8
L03D0    lda   <u0030
         ora   #$02
         sta   <u0030
L03D6    ldb   #$09
         bsr   L040F
         bra   L03E8
L03DC    ldx   <u0001
         puls  dp
         lda   $01,x
         lbmi  L0337
         clrb
         rts
L03E8    tst   <u0005
         beq   L03DC
         lda   <u0005
         clrb
         stb   <u0005
         tfr   d,x
         lda   $0C,x
         anda  #$F7
         sta   $0C,x
         bra   L03DC
L03FB    bita  #$07
         beq   L0436
         tst   ,x
         anda  #$07
         bsr   L0415
         ldd   $02,x
         sta   $01,x
         std   $02,x
         bra   L03DC
L040D    ldx   <u0001
L040F    orb   <u0006
         stb   $02,x
         clrb
         rts
L0415    ora   <u000E
         sta   <u000E
         rts
L041A    lda   <u0030
         anda  #$FE
         sta   <u0030
         bne   L03DC
         ldb   #$05
         bsr   L040F
         bra   L03DC
L0428    lda   <u0030
         bne   L0430
         ldb   #$09
         bsr   L040F
L0430    ora   #$01
         sta   <u0030
L0434    bra   L03DC
L0436    lda   ,x
         beq   L0454
         cmpa  <u000B
         beq   L04A1
         cmpa  <u000C
         beq   L04A5
         cmpa  <u000D
         beq   L0499
         ldb   <u0036
         bitb  #$08
         beq   L0454
         cmpa  <u000F
         beq   L041A
         cmpa  <u0010
         beq   L0428
L0454    ldx   <u001D
         sta   ,x
         leax  $01,x
         cmpx  <u0027
         bcs   L0460
         ldx   <u0023
L0460    cmpx  <u001F
         bne   L046B
         lda   #$04
         bsr   L0415
L0468    lbra  L03E8
L046B    stx   <u001D
         ldx   <u0021
         leax  $01,x
         stx   <u0021
         cmpx  <u002B
         bcs   L048C
         tst   <u0031
         bne   L048C
         bita  #$04
         beq   L048C
         lda   <u0010
         beq   L048C
         lda   #$C0
         sta   <u0031
         ldb   #$05
         lbsr  L040D
L048C    tst   <u0033
         beq   L0468
         ldd   <u0033
         clr   <u0033
         os9   F$Send
         bra   L0434
L0499    ldx   <u0009
         beq   L0454
         sta   $08,x
         bra   L0454
L04A1    ldb   #$03
         bra   L04A7
L04A5    ldb   #$02
L04A7    pshs  a
         lda   <u0003
         os9   F$Send
         puls  a
         bra   L0454

         emod
eom      equ   *
         end
