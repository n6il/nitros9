********************************************************************
* CC3IO - CoCo 3 I/O driver
* 
* $Id$
* 
* Ed.    Comments                                       Who YY/MM/DD
* ------------------------------------------------------------------
* 16     Original OS-9 L2 Tandy distribution
* 26c    Added support for obtaining monitor type from  BGP 98/10/12
*        the init module
* 26d    Added support for obtaining key repeat info    BGP 98/10/23
*        from the init module
* 26e    Added support for obtaining mouse info         BGP 02/07/24
*        from the init module

         nam   CC3IO
         ttl   CoCo 3 I/O driver

* Disassembled 98/09/09 08:29:24 by Disasm v1.6 (C) 1988 by RML

         ifp1  
         use   defsfile
         endc  

tylg     set   Drivr+Objct
atrv     set   ReEnt+rev
rev      set   5
edition  set   26

         mod   eom,name,tylg,atrv,start,size

u0000    rmb   1
u0001    rmb   1
u0002    rmb   1
u0003    rmb   1
u0004    rmb   1
u0005    rmb   1
u0006    rmb   3
u0009    rmb   2
u000B    rmb   1
u000C    rmb   1
u000D    rmb   1
u000E    rmb   2
u0010    rmb   6
u0016    rmb   5
u001B    rmb   2
u001D    rmb   1
u001E    rmb   1
u001F    rmb   1
u0020    rmb   2
u0022    rmb   1
u0023    rmb   1
u0024    rmb   1
u0025    rmb   1
u0026    rmb   1
u0027    rmb   1
u0028    rmb   1
u0029    rmb   1
u002A    rmb   1
u002B    rmb   1
u002C    rmb   1
u002D    rmb   2
u002F    rmb   1
u0030    rmb   1
u0031    rmb   2
u0033    rmb   1
u0034    rmb   1
u0035    rmb   6
u003B    rmb   1
u003C    rmb   8
u0044    rmb   4
u0048    rmb   2
u004A    rmb   6
u0050    rmb   6
u0056    rmb   10
u0060    rmb   1
u0061    rmb   1
u0062    rmb   1
u0063    rmb   1
u0064    rmb   1
u0065    rmb   1
u0066    rmb   1
u0067    rmb   25
u0080    rmb   24
u0098    rmb   13
u00A5    rmb   13
u00B2    rmb   13
u00BF    rmb   7
u00C6    rmb   26
KeyEnt   rmb   2
KeyStat  rmb   8
JoyEnt   rmb   2
JoyStat  rmb   8
SndEnt   rmb   2
SndStat  rmb   2
u00F8    rmb   8
size     equ   .
         fcb   $07

name     fcs   /CC3IO/
         fcb   edition

start    lbra  Init
         lbra  Read
         lbra  Write
         lbra  GetStat
         lbra  SetStat

Term     ldx   <D.CCMem
         cmpu  <G.CurDev,x
         bne   L0056
         lbsr  L0495
         cmpu  <G.CurDev,x
         bne   L0056
         pshs  u,x
         ldx   #$10EA
         bsr   TermSub
         ldx   #$10F4
         bsr   TermSub
         ldx   #$10E0
         bsr   TermSub
         puls  u,x
         pshs  cc
         orcc  #IRQMask
         clra  
         clrb  
         std   <G.CurDev,x
         ldx   <D.Clock
         stx   <D.AltIRQ
         puls  cc
L0056    ldb   #$0C
         lbra  L0590

* Call terminate routine in subroutine module (KeyDrv/JoyDrv/SndDrv)
* X  = addr in statics of entry
TermSub  leau  2,x point U to static area for sub module
         ldx   ,x get entry pointer at ,X
         jmp   $03,x call term routine in sub module

Init     ldx   <D.CCMem
         ldd   <G.CurDev,x
         lbne  L00EF
         leax  >CC3Irq,pcr Set up AltIRQ vector in DP
         stx   <D.AltIRQ
         leax  >L0495,pcr
         pshs  x
         leax  >L054C,pcr
         tfr   x,d
         ldx   <D.CCMem
         std   >G.MsInit,x
         puls  b,a
         std   >G.WindBk,x
         stu   <G.CurDev,x
         lbsr  L054C

         lda   #$02
         sta   G.CurTik,x
         inc   <G.Mouse+Pt.Valid,x
         ldd   #$0178  right mouse/time out value
         std   <G.Mouse+Pt.Actv,x

         ldd   #$FFFF
         std   <G.LKeyCd,x
         std   <G.2Key2,x
         ldd   <D.Proc
         pshs  u,y,x,b,a

* Added to allow patching for RGB/CMP/Mono and Key info - BGP
* Uses new init module format to get monitor type and key info

         ldy   <D.Init    get init module ptr
         lda   MonType,y  get monitor type byte
         sta   <G.MonTyp,x save off
         ldd   MouseInf,y get mouse information
         sta   <G.Mouse+Pt.Res,x	save off hi-res/lo-res flag
         stb   <G.Mouse+Pt.Actv,x	save off left/right

* Set key repeat rate/delay
         ldd   KeyRptS,y  get key repeat start/delay constant
         std   <G.KyDly,x

         ldd   <D.SysPrc
         std   <D.Proc
         leax  >KeyDrv,pcr
         bsr   LinkSys
         sty   >KeyEnt,u
         leau  >KeyStat,u
         jsr   ,y call init routine of sub module
         leax  >JoyDrv,pcr
         bsr   LinkSys
         sty   >JoyEnt,u
         leau  >JoyStat,u
         jsr   ,y call init routine of sub module
         leax  >SndDrv,pcr
         bsr   LinkSys
         sty   >SndEnt,u
         leau  >SndStat,u
         jsr   ,y call init routine of sub module
         puls  u,y,x,b,a
         std   <D.Proc
L00EF    ldd   #$0078
         std   <u0028,u
         ldd   <IT.PAR,y get parity/baud bytes from dev desc
         std   <u001F,u save it off in our static
         lbra  L08AA

KeyDrv   fcs   /KeyDrv/
JoyDrv   fcs   /JoyDrv/
SndDrv   fcs   /SndDrv/

LinkSys  lda   #Systm+Objct
         os9   F$Link
         ldu   <D.CCMem
         rts   

Read     lda   <u0024,u
         lbne  L0667
         leax  >u0080,u
         ldb   <u0034,u
         orcc  #IRQMask
         cmpb  <u0033,u
         beq   L0138
         abx   
         lda   ,x
         bsr   L0159
         stb   <u0034,u
         andcc  #^(IRQMask!Carry)
         rts   
L0138    lda   V.BUSY,u
         sta   V.WAKE,u
         andcc  #^IRQMask
         ldx   #$0000
         os9   F$Sleep
         clr   V.WAKE,u
         ldx   <D.Proc
         ldb   <P$Signal,x
         beq   Read
         lda   P$State,x
         bita  #Condem
         bne   L0157
         cmpb  #S$Window
         bcc   Read
L0157    coma  
         rts   

L0159    incb  
         cmpb  #$7F
         bls   L015F
         clrb  
L015F    rts   

L0160    fdb   $0801,$027f,$f8ff,$0000,$0801,$00bf,$f8ff,$0000

L0170    cmpd  ,y
         blt   L017B
         ldd   ,y
         bpl   L017D
         clra
         clrb
L017B    std   ,y
L017D    rts   
L017E    ldb   #$01
         pshs  u,y,x,b,a
         ldb   <u0063,u
         beq   L01E6
         lda   <u0034,u
         bita  #$78
         beq   L01DF
         clr   $01,s
         lda   #$01
         sta   <u0067,u
         lda   #$08
         ldb   #$03
         pshs  b,a
         leax  >L0160,pcr
         leay  <u0056,u
L01A2    bita  <u0034,u
         beq   L01C5
         lslb  
         lslb  
         tst   <u0030,u
         beq   L01B1
         incb  
         bra   L01BC
L01B1    tst   <u0031,u
         beq   L01BC
         addb  #$02
         ldd   b,x
         bra   L01C1
L01BC    ldb   b,x
         sex   
         addd  ,y
L01C1    std   ,y
         ldd   ,s
L01C5    lsla  
         decb  
         cmpb  #$01
         bne   L01CD
         leay  -$02,y
L01CD    std   ,s
         bpl   L01A2
         puls  b,a
         ldd   #$027F
         bsr   L0170
         leay  $02,y
         ldd   #$00BF
         bsr   L0170
L01DF    lda   <u0065,u
         bne   L0223
         lda   ,s
L01E6    tst   <u0064,u
         beq   L0225
         clr   <u0064,u
         cmpa  #$81
         bne   L01FF
         ldb   <u0035,u
         bne   L0223
         ldx   <u0020,u
         com   <$21,x
         bra   L0223
L01FF    cmpa  #$82
         bne   L0208
         lbsr  L0485
         bra   L0223
L0208    cmpa  #$83
         bne   L0211
         lbsr  L0495
         bra   L0223
L0211    cmpa  #$84
         bne   L0225
         ldb   <u0035,u
         bne   L0223
         com   <u0063,u
         ldx   <u0020,u
         com   <$2A,x
L0223    clr   $01,s
L0225    ldb   $01,s
         puls  pc,u,y,x,b,a
L0229    pshs  x,b
         leax  <u003C,u
         tst   $02,x
         lbeq  L02C8
         leas  -$05,s
         tfr   a,b
         tst   <u0063,u
         bne   L024E
         ldb   #$05
         lda   $01,x
         anda  #$02
         sta   ,s
         beq   L0248
         lslb  
L0248    andb  $05,s
         tsta  
         beq   L024E
         lsrb  
L024E    clra  
         lsrb  
         rola  
         lsrb  
         std   $01,s
         bne   L0276
         lda   $05,x
         beq   L02C6
         bsr   L02CA
         beq   L0262
         bsr   L02D3
         beq   L02AB
L0262    dec   $05,x
         bne   L02AB
         clra  
         clrb  
         sta   >u00C6,u
         std   $06,x
         std   $0A,x
         std   $0C,x
         std   $0E,x
         bra   L02C6
L0276    lda   $02,x
         sta   $05,x
         bsr   L02CA
         beq   L02AB
         bsr   L02D3
         inc   >$008A,x
         ldd   <$18,x
         std   <$12,x
         ldd   <$1A,x
         std   <$14,x
         pshs  u
         ldu   <u0020,u
         lda   <u0026,u
         beq   L02A9
         ldb   <u0027,u
         os9   F$Send
         bcs   L02A5
         clr   <u0026,u
L02A5    clr   >$008A,x
L02A9    puls  u
L02AB    ldd   $0C,x
         cmpa  #$FF
         beq   L02B2
         inca  
L02B2    cmpb  #$FF
         beq   L02B7
         incb  
L02B7    std   $0C,x
         ldd   $06,x
         cmpd  #$FFFF
         beq   L02C4
         addd  #$0001
L02C4    std   $06,x
L02C6    leas  $05,s
L02C8    puls  pc,x,b
L02CA    ldd   $08,x
         eora  $03,s
         eorb  $04,s
         std   $05,s
         rts   
L02D3    ldd   $0C,x
         tst   $05,s
         beq   L02E9
         sta   $0E,x
         lda   $03,s
         bne   L02E8
         lda   $0A,x
         cmpa  #$FF
         beq   L02E6
         inca  
L02E6    sta   $0A,x
L02E8    clra  
L02E9    tst   $06,s
         beq   L02FD
         stb   $0F,x
         ldb   $04,s
         bne   L02FC
         ldb   $0B,x
         cmpb  #$FF
         beq   L02FA
         incb  
L02FA    stb   $0B,x
L02FC    clrb  
L02FD    std   $0C,x
         ldd   $03,s
         std   $08,x
         ldd   $05,s
L0305    rts   


CC3Irq   ldu   <D.CCMem
         ldy   <G.CurDev,u
         lbeq  L044E
         lda   <G.TnCnt,u get tone counter
         beq   L0319 branch if zero
         deca  else decrement
         sta   <G.TnCnt,u and save back
L0319    leax  <L0305,pcr
         stx   <D.AltIRQ
         andcc  #^(IntMasks)
         ldb   <$23,y
         beq   L0337
         lda   $06,y
         bpl   L032F
         lda   G.GfBusy,u
         ora   G.WIBusy,u
         bne   L034F
L032F    lda   #$00
         lbsr  L05DA
         clr   <$23,y
L0337    ldb   G.CntTik,u
         beq   L034F
         decb  
         stb   G.CntTik,u
         bne   L034F
         lda   G.GfBusy,u
         ora   G.WIBusy,u
         beq   L034A
         inc   G.CntTik,u
         bra   L034F
L034A    lda   #$02
         lbsr  L05DA
L034F    lda   <G.KyMse,u keyboard mouse?
         bne   L0369 branch if so
         lda   <G.MSmpRt,u
         beq   L0369
         deca  
         bne   L0366
         pshs  u,y,x
         lbsr  L0739
         puls  u,y,x
         lda   <G.MSmpRV,u
L0366    sta   <G.MSmpRt,u
L0369    clra  
         clrb  
         std   <G.KySns,u
         tst   <G.KyMse,u
         beq   L0381
         ldx   >$10E0
         leau  >$00E2,u
         jsr   $06,x
         ldu   <D.CCMem
         sta   <G.KyButt,u
L0381    ldx   >$10EA
         leau  >$00EC,u
         jsr   $06,x
         ldu   <D.CCMem
         lda   #$82
         cmpb  #$80
         beq   L0397
         inca  
         cmpb  #$C0
         bne   L039C
L0397    inc   <G.Clear,u
         bra   L03C8
L039C    tst   $08,y
         bpl   L03A8
         bitb  #$03
         beq   L03A8
         lda   #$0D
         bra   L03C8
L03A8    lda   <G.KyButt,u
         lbsr  L0229
         tstb  
         lbne  L044E
         pshs  u,y,x
         ldx   >$10E0
         leau  >$00E2,u
         jsr   $09,x
         puls  u,y,x
         bpl   L03C8
         clr   <G.LastCh,u
         lbra  L044E
L03C8    cmpa  <G.LastCh,u
         bne   L03DF
         ldb   <G.KyRept,u
         beq   L044E
         decb  
         beq   L03DA
L03D5    stb   <G.KyRept,u
         bra   L044E
L03DA    ldb   <u0062,u
         bra   L03ED
L03DF    sta   <u0027,u
         ldb   <u0061,u
         tst   <u0035,u
         bne   L03D5
         ldb   <u0061,u
L03ED    stb   <u0029,u
         lbsr  L017E
         beq   L044E
         ldb   #$01
         stb   >u00BF,u
         ldu   <u0020,u
         ldb   <u0033,u
         leax  >u0080,u
         abx   
         lbsr  L0159
         cmpb  <u0034,u
         beq   L0411
         stb   <u0033,u
L0411    sta   ,x
         beq   L0431
         cmpa  u000D,u
         bne   L0421
         ldx   u0009,u
         beq   L0443
         sta   $08,x
         bra   L0443
L0421    ldb   #$03
         cmpa  u000B,u
         beq   L042D
         ldb   #$02
         cmpa  u000C,u
         bne   L0431
L042D    lda   u0003,u
         bra   L0447
L0431    lda   <u0024,u
         beq   L0443
         ldb   <u0025,u
         os9   F$Send
         bcs   L044E
         clr   <u0024,u
         bra   L044E
L0443    ldb   #$01
         lda   u0005,u
L0447    beq   L044E
         clr   u0005,u
         os9   F$Send
L044E    ldu   <D.CCMem
         lda   <G.AutoMs,u
         beq   L046B
         lda   <G.MseMv,u
         ora   <G.Mouse+Pt.CBSA,u
         beq   L046B
         lda   G.GfBusy,u
         ora   G.WIBusy,u
         bne   L046B
         lda   #$03
         lbsr  L05DA
         clr   <G.MseMv,u
L046B    orcc  #IntMasks
         leax  >CC3Irq,pcr
         stx   <D.AltIRQ
         rts   

L0474    stb   $06,s
         ldx   <u0024
         lda   $0D,x
         ldb   #$09
         mul   
         ldy   <u0080
         leax  d,y
         stx   $07,s
         rts   
L0485    pshs  u,y,x,b,a
         leas  <-$11,s
         ldb   #$09
         bsr   L0474
         stx   $09,s
         sty   $07,s
         bra   L04A7
L0495    pshs  u,y,x,b,a
         leas  <-$11,s
         ldb   #$F7
         bsr   L0474
         leay  -$09,y
         sty   $09,s
         leax  -$09,x
         stx   $07,s
L04A7    ldx   <D.CCMem
         ldu   <$20,x
         lbeq  L0546
         ldx   u0001,u
         stx   $0B,s
         stx   $0F,s
         ldd   ,x
         std   $0D,s
L04BA    ldx   $0F,s
L04BC    ldb   $04,s
         leax  b,x
         cmpx  $09,s
         bne   L04C6
         ldx   $07,s
L04C6    stx   $0F,s
         ldd   ,x
         cmpd  $0D,s
         bne   L04BC
         ldu   $02,x
         beq   L04BC
         cmpx  $0B,s
         beq   L0541
         lda   <u001E,u
         beq   L04BA
         ldx   <u0016,u
         beq   L0536
         lda   u0003,u
         beq   L0536
         ldy   <u0048
         lda   a,y
         beq   L0536
         clrb  
         tfr   d,y
         lda   >$00AC,y
         leay  <$30,y
         sta   ,s
         pshs  x
L04FA    ldb   #$10
         lda   ,x
L04FE    decb  
         cmpa  b,y
         beq   L050F
         tstb  
         bne   L04FE
         ldx   <$3D,x
         bne   L04FA
         puls  x
         bra   L0536
L050F    puls  x
         lda   ,s
L0513    sta   ,s
         cmpa  #$02
         bhi   L051F
         ldb   #$02
         lda   b,y
         bra   L0522
L051F    lda   a,y
         clrb  
L0522    cmpa  ,x
         beq   L0536
         decb  
         bmi   L052D
         lda   b,y
         bra   L0522
L052D    lda   ,s
         ldx   <$3D,x
         bne   L0513
         bra   L04BA
L0536    ldx   <D.CCMem
         stu   <$20,x
         clr   $0A,x
         clr   >$00BF,x
L0541    inc   <u0023,u
         bsr   L054C
L0546    leas  <$11,s
         clrb  
         puls  pc,u,y,x,b,a
L054C    pshs  x
         ldd   <u0028,u
         ldx   <D.CCMem
         sta   <$3B,x
         sta   <$60,x
         stb   <$3E,x
         ldd   <u002A,u
         sta   <$63,x
         stb   <$66,x
         lda   u0006,u
         sta   $0B,x
         clra  
         puls  pc,x

Write    ldb   <u002C,u
         lbne  L0600
         sta   <u001F,u
         cmpa  #C$SPAC space or higher?
         bcc   L058E
         cmpa  #$1E   $1E escape code?
         bcc   L05EF
         cmpa  #$1B   $1B escape code?
         beq   L05F3
         cmpa  #$05   $05 escape code?
         beq   L05F3
         cmpa  #C$BELL Bell?
         bne   L058E
         jmp   [>WGlobal+G.BelVec]

L058E    ldb   #$03      1st entry point in co-module
L0590    lda   <u001F,u
L0593    ldx   <D.CCMem
         stu   G.CurDvM,x
L0597    pshs  a
         leax  <G.CoTble,x
         lda   <u001D,u
         ldx   a,x
         puls  a
         beq   L05EB
         leax  b,x
         bsr   L05C0
         ldb   <u001D,u
         beq   L05B4
         jsr   ,x

L05B0    pshs  cc
         bra   L05BB
L05B4    jsr   ,x
L05B6    pshs  cc
         clr   >WGlobal+G.WIBusy
L05BB    clr   >WGlobal+G.CrDvFl
         puls  pc,cc

L05C0    pshs  x,b
         ldx   <D.CCMem
         clr   G.WIBusy,x
         ldb   <u001D,u
         bne   L05CE
         incb  
         stb   G.WIBusy,x
L05CE    clr   G.CrDvFl,x
         cmpu  <G.CurDev,x
         bne   L05D8
         inc   g000A,x
L05D8    puls  pc,x,b

L05DA    pshs  u,y,x
         ldu   <u0020,u
L05DF    ldb   #$0F
         ldx   <D.CCMem
         bsr   L0597
         puls  pc,u,y,x
L05E7    pshs  u,y,x
         bra   L05DF
L05EB    comb  
         ldb   #E$MNF
         rts   

L05EF    cmpa  #$1E
         beq   L05FE
L05F3    leax  <L058E,pcr
         ldb   #$01
         stx   <u002D,u
         stb   <u002C,u
L05FE    clrb  
         rts   

L0600    ldx   <u0031,u
         sta   ,x+
         stx   <u0031,u
         decb  
         stb   <u002C,u
         bne   L05FE
         ldx   <D.CCMem
         bsr   L05C0
         stu   G.CurDvM,x
         ldx   <u002F,u
         stx   <u0031,u
         ldb   <u001D,u
         beq   L0624
         jsr   [<u002D,u]
         bra   L05B0
L0624    jsr   [<u002D,u]
         bra   L05B6

GetStat  cmpa  #SS.EOF
         beq   SSEOF
         ldx   PD.RGS,y
         cmpa  #SS.ComSt
         beq   GSComSt
         cmpa  #SS.Joy
         beq   GSJoy
         cmpa  #SS.Mouse
         lbeq  GSMouse
         cmpa  #SS.Ready
         beq   GSReady
         cmpa  #SS.KySns
         beq   GSKySns
         cmpa  #SS.Montr
         beq   GSMontr
         ldb   #$06   2nd entry point in co-module
         lbra  L0593

* SS.ComSt - get baud/parity info
GSComSt  lda   V.TYPE,u
         clrb  
         std   R$Y,x
         rts   

GSReady  ldb   <u0033,u
         cmpb  <u0034,u
         beq   L0667
         bhi   L0660
         addb  #$80
L0660    subb  <u0034,u
         stb   $02,x
SSEOF    clrb  
         rts   
L0667    comb  
         ldb   #E$NotRdy
         rts   

GSKySns  ldy   <D.CCMem
         clrb  
         cmpu  <G.CurDev,y
         bne   L0678
         ldb   <G.KySns,y
L0678    stb   R$A,x
         clrb  
         rts   

* GetStat: SS.Montr (get Monitor type)
GSMontr  ldb   >WGlobal+G.MonTyp get monitor type
         tfr   b,a        put in A
         std   $04,x      save in caller's X
         rts   

* GetStat: SS.JOY (get joystick X/Y/button values)
GSJoy    clrb  
         tfr   x,y
         ldx   <D.CCMem
         cmpu  <$20,x     is this win device same as current?
         beq   L0697      branch if so
         clra             else D = 0
         std   $04,y
         std   $06,y
         sta   $01,y
         rts   
L0697    ldx   >$10EA
         pshs  u
         ldu   <D.CCMem
         leau  >$00EC,u
         jsr   $0C,x
         puls  u
         lda   $05,y
         beq   L06AB
         lsrb  
L06AB    andb  #$05
         lsrb  
         bcc   L06B2
         orb   #$01
L06B2    stb   $01,y
         pshs  y
         lda   $05,y
         inca  
         ldy   #$0000
         pshs  u
         ldu   <D.CCMem
         ldx   >$10EA
         leau  >$00EC,u
         jsr   $0F,x
         puls  u
         pshs  y
         ldy   $02,s
         stx   $04,y
         ldd   #$003F
         subd  ,s++
         std   $06,y
         clrb  
         puls  pc,y

* GetStat: SS.Mouse (get mouse info)
GSMouse  pshs  u,y,x
         ldx   <D.CCMem
         cmpu  <$20,x     is caller in current window?
         beq   L06FA      branch i so
         ldy   ,s
         ldb   #$20       size of packet
L06EC    clr   ,-s
         decb  
         bne   L06EC
         leax  ,s
         bsr   L0729
         leas  <$20,s
         puls  pc,u,y,x
* here the caller is in the current window
L06FA    tst   <$63,x
         bne   L071A
         lda   <$60,x
         bne   L071A
         pshs  u,y,x
         bsr   L073B
         puls  u,y,x
         lda   <$66,x
         anda  <$67,x
         beq   L071A
         lda   #$03
         lbsr  L05E7
         clr   <$67,x
L071A    lda   #$01
         lbsr  L05E7
         leax  <$3C,x
         ldy   ,s
         bsr   L0729
         puls  pc,u,y,x
L0729    ldu   $04,y
         ldy   <D.Proc
         ldb   P$Task,y
         clra  
         ldy   #32
         os9   F$Move
         rts   
L0739    ldx   <D.CCMem
L073B    leax  <$3C,x
         clra  
         ldb   <$17,x
         tfr   d,y
         lda   $01,x
         pshs  u,y,x,b,a
         ldx   >$10EA
         ldu   <D.CCMem
         leau  >$00EC,u
         jsr   $09,x
         pshs  y,x
         ldx   $06,s
         puls  b,a
         leay  <$18,x
         bsr   L0764
         puls  b,a
         bsr   L0764
         puls  pc,u,y,x,b,a
L0764    cmpd  ,y++
         beq   L0770
         std   -$02,y
         lda   #$01
         sta   <$2B,x
L0770    rts   

SSTone   ldx   >$10F4
         jmp   $06,x

SSAnPal  ldx   >$10F4
         jmp   $09,x

* Y  = addr of path desc
SetStat  ldx   PD.RGS,y
         cmpa  #SS.ComSt
         lbeq  SSComSt
         cmpa  #SS.Montr
         lbeq  SSMontr
         cmpa  #SS.KySns
         lbeq  SSKySns
         cmpa  #SS.Tone
         beq   SSTone
         cmpa  #SS.AnPal
         beq   SSAnPal
         cmpa  #SS.SSig
         beq   SSSig
         cmpa  #SS.MsSig
         beq   SSMsSig
         cmpa  #SS.Relea
         beq   SSRelea
         cmpa  #SS.Mouse
         beq   SSMouse
         cmpa  #SS.GIP
         lbeq  SSGIP
         cmpa  #SS.Open
         bne   L07B5
SSOpen   ldx   PD.DEV,y
         stx   u0001,u
L07B5    ldb   #$09  3rd entry point in co-module
         lbra  L0593

* SS.SSig - send signal on data ready
SSSig    pshs  cc
         clr   <u0024,u
         lda   <u0034,u
         suba  <u0033,u
         pshs  a
         bsr   L07EC
         tst   ,s+
         bne   L07F7
         std   <u0024,u
         puls  pc,cc

* SS.MsSig - send signal on mouse button
SSMsSig  pshs  cc
         clr   <u0026,u
         bsr   L07EC
         ldx   <D.CCMem
         cmpu  <G.CurDev,x
         bne   L07E7
         tst   >G.MsSig,x
         bne   L07F3
L07E7    std   <u0026,u
         puls  pc,cc
L07EC    orcc  #IntMasks
         lda   PD.CPR,y get curr proc #
         ldb   R$X+1,x get user signal code
         rts   
L07F3    clr   >G.MsSig,x
L07F7    puls  cc
         os9   F$Send
         rts   

* SS.Relea - release a path from SS.SSig
SSRelea  lda   PD.CPR,y get curr proc #
         cmpa  <u0024,u same as keyboard?
         bne   L0807 branch if not
         clr   <u0024,u
L0807    cmpa  <u0026,u same as mouse?
         bne   L0871
         clr   <u0026,u
         rts   

* SS.Mouse - set mouse sample rate and button timeout
SSMouse  ldd   R$X,x
         cmpa  #$FF
         beq   L0819
         sta   <u0028,u
L0819    cmpb  #$FF
         beq   L0820
         stb   <u0029,u
L0820    ldb   R$Y+1,x
         stb   <u002B,u
         ldy   <D.CCMem
         cmpu  <G.CurDev,y
         bne   L083D
         stb   <G.AutoMs,y
         ldd   <u0028,u
         sta   <G.MSmpRV,y
         sta   <G.MSmpRt,y
         stb   <G.Mouse+Pt.ToTm,y
L083D    clrb  
         rts   

* SS.GIP
SSGIP    ldy   <D.CCMem
         cmpu  <G.CurDev,y current window?
         bne   L0866 branch if not
         ldd   R$Y,x get caller's Y (key repeat info)
         cmpd  #$FFFF unchanged?
         beq   L0853 yes, don't change current key info
         std   <G.KyDly,y else save key delay and speed info
L0853    ldd   R$X,x get mouse info
         cmpa  #$01 set for hi res adapter?
         bgt   L088F  branch to error if greater
         sta   <G.Mouse+Pt.Res,y
* B  = mouse port (1 = right, 2 = left)
         tstb
         beq   L088F
         cmpb  #$02
         bgt   L088F
         stb   <G.Mouse+Pt.Actv,y
L0866    clrb  
         rts   

* SS.KySns - setstat???
SSKySns  ldd   R$X,x
         beq   L086E
         ldb   #$FF
L086E    stb   <u0022,u
L0871    clrb  
         rts   

* SS.Montr - change monitor type
SSMontr  ldd   R$X,x
         cmpd  #$0002
         bhi   L088F
         lda   <D.VIDMD
         anda  #$EF
         bitb  #$02
         beq   L0885
         ora   #$10
L0885    sta   <D.VIDMD
         stb   >WGlobal+G.MonTyp
         inc   <u0023,u
         clrb  
         rts   
L088F    comb  
         ldb   #E$IllArg
         rts   

* SS.ComSt - set baud/parity params
SSComSt  ldd   R$Y,x
         eora  u0006,u
         anda  #$80
         bne   L088F
         lda   R$Y,x
         bsr   L08AA
         lbcc  L07B5
         rts   

VDGInt   fcs   /VDGInt/

L08AA    sta   u0006,u
         bmi   L08C3  if hi-bit if A is set, we're a window
         pshs  u,y,a ..else VDG
         lda   #$02
         sta   <u001D,u
         leax  <VDGInt,pcr
         bsr   L08D4
         puls  pc,u,y,a

WindInt  fcs   /WindInt/

L08C3    pshs  u,y
         clra  
         sta   <u001D,u
         leax  <WindInt,pcr
         lda   #$80
         bsr   L08D4
         puls  pc,u,y
L08D2    clrb  
         rts   
L08D4    ldb   <u002F,u
         bne   L08D2
         pshs  u
         ldu   <D.CCMem
         bita  <G.BCFFlg,u
         puls  u
         bne   L0900
         tsta  
         bpl   L08E8
         clra  
L08E8    pshs  y,a
         bsr   L0905
         bcc   L08F0
         puls  pc,y,a
L08F0    puls  a
         ldx   <D.CCMem
         leax  <G.CoTble,x
         sty   a,x
         puls  y
         cmpa  #$02
         bgt   L08D2
L0900    ldb   #$00
         lbra  L0590
L0905    ldd   <D.Proc
         pshs  u,x,b,a
         ldd   <D.SysPrc
         std   <D.Proc
         lda   #Systm+Objct
         os9   F$Link
         ldx   $02,s
         bcc   L091B
         ldu   <D.SysPrc
         os9   F$Load
L091B    puls  u,x,b,a
         std   <D.Proc
         lbcs  L05EB
         rts   

         emod  
eom      equ   *
         end

