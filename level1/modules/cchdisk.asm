********************************************************************
* CCHDisk - Tandy hard disk driver
*
* $Id$
*
* Ed.    Comments                                       Who YY/MM/DD
* ------------------------------------------------------------------
*   4    From Tandy OS-9 Level One VR 02.00.00

         nam   CCHDisk
         ttl   Tandy hard disk driver

* Disassembled 98/08/23 17:28:39 by Disasm v1.6 (C) 1988 by RML

         ifp1
         use   defsfile
         use   rbfdefs
         endc

tylg     set   Drivr+Objct   
atrv     set   ReEnt+rev
rev      set   $01
edition  set   4

         mod   eom,name,tylg,atrv,start,size

u0000    rmb   8
u0008    rmb   7
u000F    rmb   91
u006A    rmb   61
u00A7    rmb   2
u00A9    rmb   1
u00AA    rmb   1
u00AB    rmb   2
u00AD    rmb   2
u00AF    rmb   1
u00B0    rmb   1
u00B1    rmb   1
u00B2    rmb   1
u00B3    rmb   1
u00B4    rmb   1
u00B5    rmb   1
u00B6    rmb   1
u00B7    rmb   1
u00B8    rmb   1
u00B9    rmb   1
u00BA    rmb   1
u00BB    rmb   1
u00BC    rmb   2
u00BE    rmb   1
u00BF    rmb   2
u00C1    rmb   2
size     equ   .

         fcb   DIR.+SHARE.+PREAD.+PWRIT.+PEXEC.+READ.+WRITE.+EXEC.

name     fcs   /CCHDisk/
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
Init     lbsr  L04D4
         lda   >$FF51
         cmpa  #$08
         beq   L0037
         comb
         ldb   #E$NotRdy
         bra   L0083
L0037    lbsr  L04C0
         bcs   L0083
         ldd   #$FFFF
         std   >u00A9,u
         std   >u00A7,u
         leax  <$25,y
         ldd   ,x++
         sta   >u00B3,u
         stb   >u00BE,u
         ldd   ,x++
         std   >u00BF,u
         ldd   ,x++
         std   >u00C1,u
         lda   ,x
         sta   >u00B2,u
         lda   #$04
         leay  u000F,u
         ldb   #$FF
L006C    stb   ,y
         stb   <$15,y
         leay  <$26,y
         deca
         bne   L006C
         ldd   #256
         pshs  u
         os9   F$SRqMem
         tfr   u,x
         puls  u
L0083    bcs   L00C7
         stx   >u00AB,u
         leax  >$0100,x
         stx   >u00AD,u
         bra   L00C6

* Term
*
* Entry:
*    U  = address of device memory area
*
* Exit:
*    CC = carry set on error
*    B  = error code
*
Term     pshs  u
         ldu   >u00AB,u
         ldd   #256
         os9   F$SRtMem 
         puls  u

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
GetStat  clrb
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
Read     lbsr  L04D4
         cmpx  #$0000
         bne   L00CB
         tstb
         bne   L00CB
         bsr   L00D1
         bcs   L00C7
         ldx   $08,y
         pshs  y,x
         ldy   >u00A7,u
         ldb   #$14
L00BD    lda   b,x
         sta   b,y
         decb  
         bpl   L00BD
         puls  y,x
L00C6    clrb  
L00C7    lbsr  L04E1
         rts   
L00CB    bsr   L00D1
         bcs   L00C7
         bra   L00C6
L00D1    lbsr  L033F
         bcs   L00E3
         ldx   $08,y
         lda   #$02
         sta   >u00B9,u
         lda   #$20
         lbsr  L028C
L00E3    rts   

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
Write    lbsr  L04D4
         bsr   L014A
         bcs   L00C7
         pshs  x,b
         bsr   L0100
         puls  x,b
         bcs   L00C7
         tst   <$28,y
         bne   L00C6
         bsr   L0113
         bcc   L00C6
         ldb   <$00F5
         bra   L00C7
L0100    lbsr  L033F
         bcs   L0112
         lda   #$03
         sta   >u00B9,u
         lda   #$30
         ldx   $08,y
         lbsr  L028C
L0112    rts   
L0113    pshs  x,b,a
         ldx   $08,y
         pshs  x
         ldx   >u00AB,u
         stx   $08,y
         ldx   $04,s
         bsr   L00D1
         puls  x
         stx   $08,y
         bcs   L0148
         lda   #$20
         pshs  u,y,a
         ldy   >u00AB,u
         tfr   x,u
L0134    ldx   ,u
         cmpx  ,y
         bne   L0144
         leau  u0008,u
         leay  $08,y
         dec   ,s
         bne   L0134
         bra   L0146
L0144    orcc  #Carry
L0146    puls  u,y,a
L0148    puls  pc,x,b,a
L014A    pshs  b
         ldb   >$FF50
         beq   L0179
         lda   <$21,y
         bne   L015C
         andb  #$80
         bne   L0174
         bra   L0179
L015C    cmpa  #$01
         bne   L0166
         andb  #$40
         bne   L0174
         bra   L0179
L0166    cmpa  #$02
         bne   L0170
         andb  #$20
         bne   L0174
         bra   L0179
L0170    andb  #$10
         beq   L0179
L0174    comb  
         ldb   #E$WP
         stb   ,s
L0179    puls  pc,b

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
SetStat  lbsr  L04D4
         lbsr  L0460
         ldx   PD.RGS,y
         ldb   R$B,x
         cmpb  #SS.Reset
         bne   L018E
         lbsr  L04A5
         bra   L01A1
L018E    cmpb  #SS.WTrk
         bne   L0196
         bsr   L01B5
         bra   L01A1
L0196    cmpb  #SS.SQD
         bne   L019E
         bsr   L01A8
         bra   L01A1
L019E    comb
         ldb   #E$UnkSvc
L01A1    lbcs  L00C7
         lbra  L00C6

L01A8    ldd   <$25,y
         exg   a,b
         std   >u00B6,u
         lbsr  L0496
         rts

L01B5    ldd   $8,x
         cmpd  #$0000
         bne   L01C3
         ldd   $6,x
         cmpa  #$00
         beq   L01C5
L01C3    clrb  
         rts   
L01C5    pshs  u,y,x
         clr   >u00AF,u
         clr   >u00B0,u
         clr   >u00B1,u
         lda   <$2A,y
         bsr   L023D
L01D8    lda   <$2A,y
         sta   >u00B4,u
         lda   >u00B2,u
         sta   >u00B5,u
         lda   >u00B8,u
         anda  #$F8
         sta   >u00B8,u
         lda   >u00B1,u
         ora   >u00B8,u
         sta   >u00B8,u
         ldd   >u00AF,u
         exg   a,b
         std   >u00B6,u
         lda   #$03
         sta   >u00B9,u
         lda   #$50
         ldx   >u00AB,u
         bsr   L028C
         bcs   L023B
         lda   >u00B1,u
         inca
         sta   >u00B1,u
         cmpa  <$27,y
         bcs   L01D8
         clr   >u00B1,u
         ldd   >u00AF,u
         addd  #$0001
         std   >u00AF,u
         cmpd  <$25,y
         bcs   L01D8
         clrb  
L023B    puls  pc,u,y,x
L023D    pshs  y,x,b,a
         ldb   <$2D,y
         stb   >u00BB,u
         sta   >u00BA,u
         lsla  
         ldx   >u00AB,u
         leay  a,x
         nega  
         pshs  y,x,b,a
         clra  
L0255    clr   ,x
         sta   $01,x
         inca  
         cmpa  >u00BA,u
         beq   L0278
         ldb   >u00BB,u
         lslb  
         abx   
         cmpx  $04,s
         bcs   L026E
         ldb   ,s
         leax  b,x
L026E    cmpx  $02,s
         bne   L0255
         leax  $02,x
         stx   $02,s
         bra   L0255
L0278    ldy   $04,s
         lda   #$00
L027D    cmpy  >u00AD,u
         beq   L0288
         sta   ,y+
         bra   L027D
L0288    leas  $06,s
         puls  pc,y,x,b,a
L028C    pshs  y,x,a
         leax  >u00B3,u
         ldy   #$FF59
         ldb   #$06
L0298    lda   ,x+
         sta   ,y+
         decb  
         bne   L0298
         lda   ,s
         sta   ,y
         ldy   $03,s
         ldx   $01,s
         lda   >u00B9,u
         cmpa  #$03
         beq   L02C6
         bsr   L02E1
         cmpa  #$02
         beq   L02BA
L02B6    bsr   L02F2
         puls  pc,y,x,a
L02BA    bsr   L02EB
L02BC    lda   >$FF58
         sta   ,x+
         decb  
         bne   L02BC
         bra   L02B6
L02C6    lda   ,x+
         sta   >$FF58
         decb  
         bne   L02C6
         bsr   L02E1
         bra   L02B6
L02D2    lda   >$FF5F
         pshs  a
         lda   >$FF5F
         cmpa  ,s
         leas  $01,s
         bne   L02D2
         rts   
L02E1    pshs  a
L02E3    bsr   L02D2
         anda  #$80
         bne   L02E3
         puls  pc,a
L02EB    bsr   L02D2
         bita  #$08
         beq   L02EB
         rts   
L02F2    bsr   L02D2
         bita  #$01
         bne   L02FA
         clrb  
         rts   
L02FA    comb  
         bita  #$02
         beq   L0302
         lbsr  L04F1
L0302    lda   >$FF59
         bita  #$80
         bne   L0332
         bita  #$40
         bne   L031F
         bita  #$10
         bne   L0322
         bita  #$04
         bne   L0336
         bita  #$02
         bne   L0322
         bita  #$01
         bne   L0326
         clrb  
         rts   
L031F    ldb   #E$CRC
         rts   
L0322    comb  
         ldb   #E$Seek
         rts   
L0326    comb  
         ldb   #E$Read
         rts   
         comb  
         ldb   #E$Write
         rts   
L032E    comb  
         ldb   #E$NotRdy
         rts   
L0332    comb  
         ldb   #E$Unit
         rts   
L0336    lda   >$FF5F
         bita  #$10
         beq   L0322
         bra   L032E
L033F    lbsr  L0460
         bcs   L0346
         bsr   L0347
L0346    rts   
L0347    pshs  y,x,b
         lbsr  L04C0
         lbcs  L0428
         stx   >u00BC,u
         tstb
         bne   L0380
         cmpx  #$0000
         bne   L0380
         leax  >u00B4,u
         ldd   #$0001
         sta   $01,x
         sta   $02,x
         sta   $03,x
         stb   ,x
         lda   >u00B8,u
         anda  #$F8
         sta   >u00B8,u
         tst   >u00AA,u
         lbne  L040B
         lbra  L0427
L0380    ldy   >u00A7,u
         cmpb  ,y
         lbhi  L042E
         bcs   L0393
         cmpx  $01,y
         lbcc  L042E
L0393    clr   >u00B6,u
         clr   >u00B7,u
         ldb   ,s
         ldx   $01,s
         ldy   $03,s
         tstb  
         bne   L03B4
         pshs  x,b,a
         lda   <$2A,y
         ldb   <$27,y
         mul   
         subd  $02,s
         puls  x,b,a
         bhi   L03D5
L03B4    pshs  u,y,x,b,a
         lda   >u00BE,u
         ldy   >u00BF,u
         ldu   >u00C1,u
         bsr   L0435
         ldu   $06,s
         std   >u00BC,u
         tfr   x,d
         exg   a,b
         std   >u00B6,u
         puls  u,y,x,b,a
L03D5    clra  
         ldb   <$2A,y
         beq   L042E
         pshs  b,a
         pshs  a
         ldd   >u00BC,u
L03E3    subd  $01,s
         bcs   L03EB
         inc   ,s
         bra   L03E3
L03EB    addd  $01,s
         stb   >u00B5,u
         lda   >u00B8,u
         anda  #$F8
         ora   ,s
         sta   >u00B8,u
         leas  $03,s
         lda   #$01
         sta   >u00B4,u
         tst   >u00AA,u
         beq   L0427
L040B    clr   >u00AA,u
         ldy   >u00A7,u
         lda   <$15,y
         ldy   $03,s
         cmpa  #$FF
         bne   L0423
         lbsr  L04A5
         bra   L0428
L0423    bsr   L0496
         bra   L0428
L0427    clrb
L0428    bcc   L042C
         stb   ,s
L042C    puls  pc,y,x,b
L042E    puls  b
         comb  
         ldb   #E$Sect
         puls  pc,y,x
L0435    pshs  u,y,x,b,a
         ldd   $01,s
L0439    subd  $04,s
         bcc   L0443
         addd  $04,s
         andcc #^Carry
         bra   L0445
L0443    orcc  #Carry
L0445    rol   $03,s
         rolb  
         rola  
         dec   ,s
         bne   L0439
         std   ,s
         andb  $06,s
         stb   $02,s
         ldb   $07,s
         beq   L045E
L0457    lsr   ,s
         ror   $01,s
         decb  
         bne   L0457
L045E    puls  pc,u,y,x,b,a
L0460    lda   <$21,y
         cmpa  #$04
         lbcc  L0332
         cmpa  >u00A9,u
         beq   L0495
         sta   >u00A9,u
         dec   >u00AA,u
         lsla
         lsla  
         lsla  
         pshs  a
         lda   >u00B8,u
         anda  #$E7
         ora   ,s
         leas  $01,s
         sta   >u00B8,u
         pshs  x
         ldx   <$1E,y
         stx   >u00A7,u
         puls  x
L0495    rts   
L0496    clr   >u00B9,u
         lda   <$22,y
         anda  #$0F
         ora   #$70
         lbsr  L028C
         rts   
L04A5    clr   >u00B9,u
         lda   <$22,y
         anda  #$0F
         ora   #$10
         lbsr  L028C
         bcs   L04BF
         ldx   >u00A7,u
         clr   <$15,x
         clr   <$16,x
L04BF    rts   

L04C0    pshs  b,a
         clrb
L04C3    lda   >$FF5F
         bita  #$40
         bne   L04D2
         decb
         bne   L04C3
         ldb   #E$NotRdy
         stb   $01,s
         comb
L04D2    puls  pc,b,a

L04D4    dec   <u006A
         lda   #$02
         sta   >MPI.Slct
         lda   #$08
L04DD    sta   >$FF51
         rts

L04E1    pshs  cc
         lda   #$00
         sta   >$FF51
         lda   #$03
         sta   >MPI.Slct
         clr   <u006A
         puls  pc,cc

L04F1    lda   #$10
         bra   L04DD

         emod
eom      equ   *
         end

