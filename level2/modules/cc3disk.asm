********************************************************************
* CC3Disk - CoCo 3 WD1773 disk driver
*
* $Id$
*
* Ed.    Comments                                       Who YY/MM/DD
* ------------------------------------------------------------------
* 9      Original Tandy distribution version
* 12     Obtained from L2 Upgrade archive               BGP 98/10/12

         nam   CC3Disk
         ttl   CoCo 3 WD1773 disk driver

* Disassembled 98/08/24 22:57:22 by Disasm v1.6 (C) 1988 by RML

         ifp1
         use   defsfile
         endc

tylg     set   Drivr+Objct   
atrv     set   ReEnt+rev
rev      set   $01
edition  set   12

         mod   eom,name,tylg,atrv,start,size

u0000    rmb   1
u0001    rmb   3
u0004    rmb   4
u0008    rmb   7
u000F    rmb   35
u0032    rmb   29
u004F    rmb   1
u0050    rmb   58
u008A    rmb   29
u00A7    rmb   2
u00A9    rmb   1
u00AA    rmb   1
u00AB    rmb   2
u00AD    rmb   1
u00AE    rmb   1
u00AF    rmb   2
u00B1    rmb   4
u00B5    rmb   1
u00B6    rmb   2
u00B8    rmb   1
u00B9    rmb   1
size     equ   .
         fcb   $FF 

name     fcs   /CC3Disk/
         fcb   edition

start    lbra  Init
         lbra  Read
         lbra  Write
         lbra  GetStat
         lbra  SetStat
         lbra  Term

L0028    fcb   $00,$f0
L002A    fcb   $00,$01,$0a

Init     clra
         sta   <D.MotOn clear out floppy disk timeout counter
         ldx   u0001,u
         leax  $08,x
         lda   #$D0
         sta   ,x
         lbsr  L0412
         lda   ,x
         lda   #$FF
         sta   >u00B8,u
         sta   >u00B9,u
         ldb   #$04
         leax  u000F,u
L004B    sta   ,x
         sta   <$15,x
         leax  <$26,x
         decb  
         bne   L004B
         leax  >L0256,pcr
         stx   <$00FC
         pshs  y
         leay  >u00B5,u
         tfr   y,d
         leay  >L050B,pcr
         leax  >L002A,pcr
         os9   F$IRQ    
         puls  y
         bcs   L0086
         ldd   #$0200
         pshs  u
         os9   F$SRqMem 
         tfr   u,x
         puls  u
         bcs   L0086
         stx   >u00AB,u
GetStat  clrb  
L0086    rts   

Term     leay  >u00B1,u
         ldx   #$0000
         os9   F$VIRQ   
         ldx   #$0000
         os9   F$IRQ    
         pshs  u
         ldu   >u00AB,u
         ldd   #$0200
         os9   F$SRtMem 
         puls  u
         clra  
         sta   >$FF40
         sta   <u0032
L00AB    rts   
L00AC    pshs  x,b
         stx   >u00B6,u
         lda   <$23,y
         anda  #$04
         bne   L00BB
         bra   L00CA
L00BB    puls  x,b
         clrb  
         tfr   x,d
         rora  
         rorb  
         tfr   d,x
         stx   >u00B8,u
         clrb  
         rts   
L00CA    puls  pc,x,b
Read     bsr   L00AC
         lda   #$91
         pshs  x
         lbsr  L0162
         puls  x
         bcs   L00AB
         pshs  y,x
         cmpx  #$0000
         bne   L012D
         puls  y,x
         lda   <$23,y
         bita  #$40
         beq   L00F0
         lbsr  L0526
         pshs  y,x
         bra   L012D
L00F0    ldx   >u00AB,u
         pshs  y,x
         ldy   >u00A7,u
         ldb   #$14
L00FD    lda   b,x
         sta   b,y
         decb  
         bpl   L00FD
         lda   <$10,y
         ldy   $02,s
         ldb   <$24,y
         bita  #$02
         beq   L0115
         bitb  #$01
         beq   L0154
L0115    bita  #$04
         beq   L011D
         bitb  #$02
         beq   L0154
L011D    bita  #$01
         beq   L0128
         lda   <$27,y
         suba  #$02
         bcs   L0154
L0128    clrb  
         puls  y,x
         pshs  y,x
L012D    ldy   $02,s
         ldx   $08,y
         lda   <$23,y
         ldy   >u00AB,u
         anda  #$04
         beq   L014A
         ldd   >u00B6,u
         andb  #$01
         beq   L014B
         leay  >$0100,y
L014A    clrb  
L014B    lda   ,y+
         sta   ,x+
         decb  
         bne   L014B
         puls  pc,y,x
L0154    comb  
         ldb   #$F9
         puls  pc,y,x
L0159    bcc   L0162
         pshs  x,b,a
         lbsr  SSRESET
         puls  x,b,a
L0162    pshs  x,b,a
         bsr   L016F
         puls  x,b,a
         lbcc  L00AB
         lsra  
         bne   L0159
L016F    lbsr  L02B8
         lbcs  L00AB
L0176    ldx   >u00AB,u
         pshs  y,cc
         ldb   #$80
         bsr   L01A8
L0180    bita  >$FF48
         bne   L019E
         nop   
         nop   
         leay  -$01,y
         bne   L0180
         lda   >u00A9,u
         ora   #$08
         sta   >$FF40
         lda   #$D0
         sta   >$FF48
         puls  y,cc
         lbra  L03D8
L019E    lda   >$FF4B
         sta   ,x+
         stb   >$FF40
         bra   L019E
L01A8    orcc  #IntMasks
         stb   >$FF48
         ldy   #$FFFF
         ldb   #$28
         orb   >u00A9,u
         stb   >$FF40
         ldb   #$A8
         orb   >u00A9,u
         lbsr  L0412
         lda   #$02
         rts   
Write    lbsr  L00AC
         lda   #$91
L01CB    pshs  x,b,a
         bsr   L01EF
         puls  x,b,a
         bcs   L01DF
         tst   <$28,y
         bne   L01DD
         lbsr  L0266
         bcs   L01DF
L01DD    clrb  
L01DE    rts   
L01DF    lsra  
         lbeq  L03BB
         bcc   L01CB
         pshs  x,b,a
         lbsr  SSRESET
         puls  x,b,a
         bra   L01CB
L01EF    lbsr  L02B8
         bcs   L01DE
         pshs  y,b,a
         lda   <$23,y
         anda  #$04
         beq   L0214
         lda   #$91
         lbsr  L0176
         ldd   >u00B6,u
         andb  #$01
         beq   L0214
         ldx   >u00AB,u
         leax  >$0100,x
         bra   L0218
L0214    ldx   >u00AB,u
L0218    ldy   $08,y
         clrb  
L021C    lda   ,y+
         sta   ,x+
         decb  
         bne   L021C
         puls  y,b,a
         ldx   >u00AB,u
         ldb   #$A0
L022B    pshs  y,cc
         lbsr  L01A8
L0230    bita  >$FF48
         bne   L024C
         leay  -$01,y
         bne   L0230
         lda   >u00A9,u
         ora   #$08
         sta   >$FF40
         lda   #$D0
         sta   >$FF48
         puls  y,cc
         lbra  L03BB
L024C    lda   ,x+
         sta   >$FF4B
         stb   >$FF40
         bra   L024C
L0256    leas  $0C,s
         puls  y,cc
         ldb   >$FF48
         bitb  #$04
         lbne  L03EC
         lbra  L03BE
L0266    pshs  x,b,a
         ldx   $08,y
         pshs  x
         ldx   >u00AB,u
         stx   $08,y
         ldx   $04,s
         lbsr  L016F
         puls  x
         stx   $08,y
         bcs   L02AF
         lda   #$20
         pshs  u,y,a
         ldb   <$23,y
         ldy   >u00AB,u
         andb  #$04
         beq   L0299
         ldd   >u00B6,u
         andb  #$01
         beq   L0299
         leay  >$0100,y
L0299    tfr   x,u
L029B    ldx   ,u
         cmpx  ,y
         bne   L02AB
         leau  u0008,u
         leay  $08,y
         dec   ,s
         bne   L029B
         bra   L02AD
L02AB    orcc  #Carry
L02AD    puls  u,y,a
L02AF    puls  pc,x,b,a
L02B1    pshs  a
         ldb   <$15,x
         bra   L02F5
L02B8    lbsr  L0382
         lbsr  L0337
         pshs  a
         lda   >u00AD,u
         beq   L02D0
         lda   >u00A9,u
         ora   #$40
         sta   >u00A9,u
L02D0    lda   <$23,y
         bita  #$02
         bne   L02D8
         incb  
L02D8    stb   >$FF4A
         ldx   >u00A7,u
         ldb   <$15,x
         lda   <$10,x
         lsra  
         eora  <$24,y
         anda  #$02
         pshs  a
         lda   $01,s
         tst   ,s+
         beq   L02F5
         lsla  
         lslb  
L02F5    stb   >$FF49
         ldb   #$15
         pshs  b
         ldb   <$24,y
         andb  #$02
         beq   L0305
         lsl   ,s
L0305    cmpa  ,s+
         bra   L0313
         ldb   >u00A9,u
         orb   #$10
         stb   >u00A9,u
L0313    ldb   >u00AA,u
         bne   L0320
         ldb   ,s
         cmpb  <$15,x
         beq   L032D
L0320    sta   >$FF4B
         ldb   <$22,y
         andb  #$03
         eorb  #$1B
         lbsr  L03F0
L032D    puls  a
         sta   <$15,x
         sta   >$FF49
         clrb  
         rts   
L0337    tstb  
         bne   L034B
         tfr   x,d
         cmpd  #$0000
         beq   L037D
         ldx   >u00A7,u
         cmpd  $01,x
         bcs   L034F
L034B    comb  
         ldb   #$F1
         rts   
L034F    stb   >u00AE,u
         clr   ,-s
         ldb   <$10,x
         lsrb  
         ldb   >u00AE,u
         bcc   L0373
         bra   L0369
L0361    com   >u00AD,u
         bne   L0369
         inc   ,s
L0369    subb  $03,x
         sbca  #$00
         bcc   L0361
         bra   L0379
L0371    inc   ,s
L0373    subb  $03,x
         sbca  #$00
         bcc   L0371
L0379    addb  $03,x
         puls  a
L037D    rts   
L037E    fcb   $01,$02,$04,$40
L0382    clr   >u00AA,u
L0386    lda   <$21,y
         cmpa  #$04
         bcs   L0391
         comb  
         ldb   #$F0
         rts   
L0391    pshs  x,b,a
         leax  >L037E,pcr
         ldb   a,x
         stb   >u00A9,u
         leax  u000F,u
         ldb   #$26
         mul   
         leax  d,x
         cmpx  >u00A7,u
         beq   L03B2
         stx   >u00A7,u
         com   >u00AA,u
L03B2    clr   >u00AD,u
         lbsr  L04BF
         puls  pc,x,b,a
L03BB    ldb   >$FF48
L03BE    bitb  #$F8
         beq   L03D6
         bitb  #$80
         bne   L03D8
         bitb  #$40
         bne   L03DC
         bitb  #$20
         bne   L03E0
         bitb  #$10
         bne   L03E4
         bitb  #$08
         bne   L03E8
L03D6    clrb  
         rts   
L03D8    comb  
         ldb   #$F6
         rts   
L03DC    comb  
         ldb   #$F2
         rts   
L03E0    comb  
         ldb   #$F5
         rts   
L03E4    comb  
         ldb   #$F7
         rts   
L03E8    comb  
         ldb   #$F3
         rts   
L03EC    comb  
         ldb   #$F4
         rts   
L03F0    bsr   L0410
L03F2    ldb   >$FF48
         bitb  #$01
         beq   L041B
         ldd   >L0028,pcr
         std   >u00B1,u
         bra   L03F2
L0403    lda   #$08
         ora   >u00A9,u
         sta   >$FF40
         stb   >$FF48
         rts   
L0410    bsr   L0403
L0412    lbsr  L0415
L0415    lbsr  L0418
L0418    lbsr  L041B
L041B    rts   

SetStat  ldx   PD.RGS,y get caller register ptr
         ldb   R$B,x	get func code
         cmpb  #SS.WTRK
         beq   SSWTRK
         cmpb  #SS.RESET
         lbeq  SSRESET
         comb  
         ldb   #E$UnkSvc
         rts   
SSWTRK   pshs  u,y
         ldd   #$1A00
         os9   F$SRqMem 
         bcs   L0495
         ldx   $02,s
         stu   >$00AF,x
         ldx   <u0050
         lda   $06,x
         ldb   <$00D0
         ldy   ,s
         ldx   $06,y
         ldx   $04,x
         ldy   #$1A00
         os9   F$Move   
         bcs   L0485
         puls  u,y
         pshs  u,y
         lbsr  L0382
         ldx   $06,y
         ldb   $07,x
         bitb  #$01
         beq   L0471
         com   >u00AD,u
         ldb   >u00A9,u
         orb   #$40
         stb   >u00A9,u
L0471    lda   $09,x
         ldx   >u00A7,u
         lbsr  L02B1
         bcs   L0495
         ldb   #$F0
         ldx   >u00AF,u
         lbsr  L022B
L0485    ldu   $02,s
         pshs  b,cc
         ldu   >u00AF,u
         ldd   #$1A00
         os9   F$SRtMem 
         puls  b,cc
L0495    puls  pc,u,y

SSRESET  lbsr  L0386
         ldx   >u00A7,u
         clr   <$15,x
         lda   #$05
L04A3    ldb   <$22,y
         andb  #$03
         eorb  #$4B
         pshs  a
         lbsr  L03F0
         puls  a
         deca  
         bne   L04A3
         ldb   <$22,y
         andb  #$03
         eorb  #$0B
         lbsr  L03F0
         rts   
L04BF    pshs  y,x,b,a
         ldd   >L0028,pcr
         std   >u00B1,u
         lda   >u00A9,u
         ora   #$08
         sta   >$FF40
         lda   <u0032
         bmi   L04EA
         bne   L04EC
         ldx   #$A000
L04DB    nop   
         nop   
         lbrn  L04EA
         lbrn  L04EA
         nop   
         leax  -$01,x
         bne   L04DB
L04EA    bsr   L04EF
L04EC    clrb  
         puls  pc,y,x,b,a
L04EF    lda   #$01
         sta   <u0032
         ldx   #$0001
         leay  >u00B1,u
         clr   $04,y
         ldd   >L0028,pcr
         os9   F$VIRQ   
         bcc   L0509
         lda   #$80
         sta   <u0032
L0509    clra  
         rts   
L050B    pshs  a
         lda   <u008A
         beq   L0515
         bsr   L04EF
         bra   L0524
L0515    sta   >$FF40
         lda   >u00B5,u
         anda  #$FE
         sta   >u00B5,u
         clr   <u0032
L0524    puls  pc,a
L0526    pshs  x
         ldx   >u00A7,u
         ldb   #$14
L052E    clr   b,x
         decb  
         bpl   L052E
         ldd   <$25,y
         lda   <$27,y
         mul   
         subd  #$0001
         lda   <$2A,y
         sta   $03,x
         sta   <$12,x
         mul   
         pshs  x
         tfr   d,x
         lda   <$2C,y
         leax  a,x
         lda   <$23,y
         anda  #$04
         beq   L055C
         tfr   x,d
         rolb  
         rola  
         tfr   d,x
L055C    tfr   x,d
         puls  x
         std   $01,x
         lda   #$07
         sta   $0D,x
         lda   <$24,y
         lsla  
         pshs  a
         lda   <$27,y
         deca  
         ora   ,s+
         sta   <$10,x
         clrb  
         puls  pc,x

         emod
eom      equ   *
         end
