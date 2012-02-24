********************************************************************
* CC3Disk - Disto No Halt Super Controller II disk driver
*
* This driver their interrupt driven driver. It is a no halt
* (multitasking) disk driver that uses interrupts. Care must be
* taken that no other hardware will conflict.
*
* $Id$
*
* Ed.    Comments                                       Who YY/MM/DD
* ------------------------------------------------------------------
*  02    Fist disassembled                              tjl 02/08/27

         nam   CC3Disk
         ttl   os9 device driver    

* Disassembled 02/08/27 11:42:37 by Disasm v1.6 (C) 1988 by RML

* Disto's Super Controller II supports two locations for its
* registers: $FF74 and $FF58

nh_base  equ   $FF74
nh_stat  equ   nh_base
nh_data  equ   nh_base+2

         ifp1
         use   defsfile
         endc

tylg     set   Drivr+Objct   
atrv     set   ReEnt+rev
rev      set   $02
         mod   eom,name,tylg,atrv,start,size
u0000    rmb   1
u0001    rmb   1
u0002    rmb   1
u0003    rmb   1
u0004    rmb   1
u0005    rmb   2
u0007    rmb   1
u0008    rmb   2
u000A    rmb   4
u000E    rmb   1
u000F    rmb   1
u0010    rmb   2
u0012    rmb   1
u0013    rmb   31
u0032    rmb   24
u004A    rmb   6
u0050    rmb   48
u0080    rmb   10
u008A    rmb   8
u0092    rmb   16
u00A2    rmb   5
u00A7    rmb   8
u00AF    rmb   2
u00B1    rmb   11
u00BC    rmb   1
u00BD    rmb   1
size     equ   .
         fcb   $FF 
name     equ   *
         fcs   /CC3Disk/
         fcb   $A3 #
start    equ   *
         lbra  L0046
         lbra  L00BF
         lbra  L013B
         lbra  L00BC
         lbra  L0370
         leay  >u00B1,u
         ldx   #$0000
         os9   F$VIRQ   
         os9   F$IRQ    
         ldy   #nh_data
         os9   F$IRQ    
         clrb  
         stb   >$FF40
         stb   <u0032
         rts   
L0040    fcb   $00
         fcb   $01
         fcb   $09
L0043    fcb   $80     suba #$80  This doesn't make sense.
         fcb   $80
         fcb   $10     fcb $10
L0046    clr   >nh_data
         clr   <u0032
         ldx   #$FF48
         lda   #$D0
         sta   ,x
         lbsr  L033A
         lda   ,x
         lda   #$FF
         sta   >u00A7,u
         ldb   #$04
         leax  u000F,u
L0061    sta   ,x
         sta   <$15,x
         leax  <$26,x
         decb  
         bne   L0061
         leax  >L023C,pcr
         stx   $FC
         pshs  u
         leau  >u00A7,u
         leay  u000E,u
         tfr   y,d
         leay  >L0489,pcr
         leax  >L0040,pcr
         os9   F$IRQ    
         puls  u
         bcs   L00BD
         lda   >$FF7F
         sta   >u00BC,u
         ldd   #nh_data
         leay  >L01F7,pcr
         leax  >L0043,pcr
         os9   F$IRQ    
         bcs   L00BD
         pshs  cc
         orcc  #$50
         lda   >$FF23
         anda  #$FC
         sta   >$FF23
         lda   >$FF22
         lda   <u0092
         ora   #$01
         sta   <u0092
         sta   >$FF92
         puls  cc
L00BC    clrb  
L00BD    rts   
L00BE    rts   
L00BF    lbsr  L0263
         clr   u0003,u
         ldd   <u0010,u
         bne   L0113
         bsr   L0113
         bcs   L00BE
         lda   <$23,y
         bita  #$40
         lbne  L04B0
         ldx   $08,y
         pshs  y,x
         ldy   <$1E,y
         ldb   #$14
L00E0    lda   b,x
         sta   b,y
         decb  
         bpl   L00E0
         lda   <$10,y
         ldy   $02,s
         ldb   <$24,y
         bita  #$02
         beq   L00F8
         bitb  #$01
         beq   L010E
L00F8    bita  #$04
         beq   L0100
         bitb  #$02
         beq   L010E
L0100    bita  #$01
         beq   L010B
         lda   <$27,y
         suba  #$02
         bcs   L010E
L010B    clrb  
         puls  pc,y,x
L010E    comb  
         ldb   #$F9
         puls  pc,y,x
L0113    lbsr  L02D3
         bcs   L00BE
         ldb   #$80
         lda   #$07
         lbsr  L0199
         lbcs  L025F
         ldx   $08,y
         ldb   #$80
         tst   u0003,u
         bne   L0138
         pshs  b
L012D    ldd   >nh_stat
         std   ,x++
         dec   ,s
         bne   L012D
         puls  b
L0138    andcc #$FE
         rts   
L013B    lbsr  L0263
L013E    bsr   L014D
         bcs   L014C
         tst   <$28,y
         bne   L014B
         bsr   L0171
         bcs   L013E
L014B    clrb  
L014C    rts   
L014D    lbsr  L02D3
         bcs   L014C
         ldx   $08,y
         lda   #$04
         sta   >nh_data
         ldb   #$80
         pshs  b
L015D    ldd   ,x++
         std   >nh_stat
         dec   ,s
         bne   L015D
         puls  b
         ldb   #$A0
         lda   #$06
         bsr   L0199
         lbra  L0240
L0171    lda   u0004,u
         pshs  a
         clr   u0004,u
         lda   #$FF
         sta   u0003,u
         lbsr  L0113
         bcs   L0194
         pshs  b
L0182    ldd   >nh_stat
         cmpd  ,x++
         bne   L0190
         dec   ,s
         bne   L0182
         bra   L0192
L0190    orcc  #$01
L0192    puls  b
L0194    puls  a
         sta   u0004,u
         rts   
L0199    std   u0008,u
L019B    ldd   u0008,u
         bsr   L01B8
         lbsr  L0240
         bcc   L01B7
         lda   >$FF48
         bita  #$40
         bne   L01B6
         lsr   u0004,u
         beq   L01B6
         bcc   L019B
         lbsr  L0346
         bra   L019B
L01B6    coma  
L01B7    rts   
L01B8    pshs  a
         lda   <u0050
         sta   >-u00A2,u
         puls  a
         stb   >$FF48
         ora   #$08
         sta   >nh_data
         ldb   #$28
         orb   u0001,u
         stb   >$FF40
         pshs  x
         bra   L01E5
L01D5    ldx   <u0050
         lda   $0C,x
         ora   #$08
         sta   $0C,x
         andcc #$AF
         ldx   #$0001
         lbsr  L0424
L01E5    orcc  #$50
         lda   >-u00A2,u
         bne   L01D5
         clrb  
         ldb   #$04
         stb   >nh_data
         andcc #$AF
         puls  pc,x
L01F7    lda   u0005,u
         beq   L0233
         ldb   >$FF7F
         stb   >u00BD,u
         ldb   >u00BC,u
         stb   >$FF7F
         ldb   #$D0
         stb   >$FF48
         ldb   #$04
         stb   >nh_data
         ldb   <u00AF
         andb  #$FE
         stb   <u00AF
         ldb   <u0092
         andb  #$FE
         stb   >$FF92
         orb   #$01
         stb   >$FF92
         clrb  
         stb   u0005,u
         tfr   d,x
         lda   $0C,x
         anda  #$F7
         sta   $0C,x
         clrb  
         bra   L0234
L0233    comb  
L0234    lda   >u00BD,u
         sta   >$FF7F
         rts   
L023C    leas  $0C,s
         puls  y,cc
L0240    ldb   >$FF48
         clr   >nh_data
         andb  #$F8
         beq   L0258
         pshs  x
         leax  <L0259,pcr
L024F    leax  $01,x
         rolb  
         bcc   L024F
         ldb   ,x
         puls  pc,x
L0258    clrb  
L0259    rts   
         fcb   $F6
         fcb   $F2
         fcb   $F5
         fcb   $F7
         fcb   $F3
L025F    comb  
         ldb   #$F4
         rts   
L0263    leau  >u00A7,u
         clr   u0007,u
         lda   #$91
         sta   u0004,u
         tstb  
         bne   L027F
         tfr   x,d
         std   <u0010,u
         beq   L02A1
         ldx   <$1E,y
         cmpd  $01,x
         bcs   L0285
L027F    comb  
         ldb   #$F1
         leas  $02,s
         rts   
L0285    clr   ,-s
         bra   L028B
L0289    inc   ,s
L028B    subd  <$11,x
         bcc   L0289
         addd  <$11,x
         lda   <$10,x
         lsra  
         bcc   L029F
         lsr   ,s
         bcc   L029F
         inc   u0007,u
L029F    puls  a
L02A1    std   u0005,u
         clrb  
         rts   
L02A5    clr   u0002,u
         lda   <$21,y
         cmpa  #$04
         bcs   L02B2
         comb  
         ldb   #$F0
         rts   
L02B2    pshs  x,b,a
         cmpa  ,u
         beq   L02BA
         com   u0002,u
L02BA    sta   ,u
         leax  <L02C8,pcr
         ldb   a,x
         stb   u0001,u
         lbsr  L043E
         puls  pc,x,b,a
L02C8    fcb   $01,$02,$04,$40
L02CC    pshs  a
         ldb   <$15,x
         bra   L030A
L02D3    lbsr  L02A5
         bcs   L032D
         ldd   u0005,u
         pshs  a
         lda   u0007,u
         beq   L02E6
         lda   u0001,u
         ora   #$40
         sta   u0001,u
L02E6    lda   <$23,y
         bita  #$02
         bne   L02EE
         incb  
L02EE    stb   >$FF4A
         ldx   <$1E,y
         ldb   <$15,x
         lda   <$10,x
         lsra  
         eora  <$24,y
         anda  #$02
         pshs  a
         lda   $01,s
         tst   ,s+
         beq   L030A
         lsla  
         lslb  
L030A    stb   >$FF49
         tst   u0002,u
         bne   L0318
         ldb   ,s
         cmpb  <$15,x
         beq   L0324
L0318    sta   >$FF4B
         ldb   <$22,y
         andb  #$03
         eorb  #$1B
         bsr   L032E
L0324    puls  a
         sta   <$15,x
         sta   >$FF49
         clrb  
L032D    rts   
L032E    lda   #$04
         lbsr  L01B8
         lda   >$FF48
         clr   >nh_data
         rts   
L033A    clr   <u0012,u
         inc   <u0012,u
L0340    rol   <u0012,u
         bpl   L0340
         rts   
L0346    pshs  x,b
         lbsr  L02A5
         bcs   L036E
         ldx   <$1E,y
         clr   <$15,x
         lda   #$04
L0355    ldb   <$22,y
         andb  #$03
         eorb  #$4B
         pshs  a
         bsr   L032E
         puls  a
         deca  
         bne   L0355
         ldb   <$22,y
         andb  #$03
         eorb  #$0B
         bsr   L032E
L036E    puls  pc,x,b
L0370    leau  >u00A7,u
         ldx   $06,y
         ldb   $02,x
         cmpb  #$04
         beq   L0384
         cmpb  #$03
         beq   L0346
         comb  
         ldb   #$D0
         rts   
L0384    pshs  u,y
         ldd   #$1A00
         os9   F$SRqMem 
         lbcs  L03E2
         ldx   $02,s
         stu   <$13,x
         ldx   <u0050
         lda   $06,x
         ldb   $D0
         ldy   ,s
         ldx   $06,y
         ldx   $04,x
         ldy   #$1A00
         os9   F$Move   
         bcs   L03D3
         puls  u,y
         pshs  u,y
         lbsr  L02A5
         bcs   L03D3
         ldx   $06,y
         ldb   $07,x
         bitb  #$01
         beq   L03C4
         lda   u0001,u
         ora   #$40
         sta   u0001,u
         sta   u0007,u
L03C4    lda   $09,x
         ldx   <$1E,y
         lbsr  L02CC
         bcs   L03D3
         ldx   <u0013,u
         bsr   L03E4
L03D3    ldu   $02,s
         pshs  b,cc
         ldu   <u0013,u
         ldd   #$1A00
         os9   F$SRtMem 
         puls  b,cc
L03E2    puls  pc,u,y
L03E4    pshs  y,cc
         orcc  #$50
         ldb   #$F0
         stb   >$FF48
         ldy   #$FFFF
         ldb   #$28
         orb   u0001,u
         stb   >$FF40
         orb   #$A8
         lda   #$02
         lbsr  L033A
L03FF    bita  >$FF48
         bne   L041A
         leay  -$01,y
         bne   L03FF
         lda   u0001,u
         ora   #$08
         sta   >$FF40
         lda   #$D0
         sta   >$FF48
         puls  y,cc
         comb  
         ldb   #$F5
         rts   
L041A    lda   ,x+
         sta   >$FF4B
         stb   >$FF40
         bra   L041A
L0424    pshs  b,a
         ldd   <u0050
         cmpd  <u004A
         puls  b,a
         beq   L0433
         os9   F$Sleep  
         rts   
L0433    ldx   #$A000
L0436    nop   
         nop   
         nop   
         leax  -$01,x
         bne   L0436
         rts   
L043E    pshs  y,x,b,a
         ldd   #$00F0
         std   u000A,u
         lda   u0001,u
         ora   #$08
         sta   >$FF40
         ldx   #$0028
         lda   <u0032
         bmi   L046B
         beq   L0469
         tst   u0002,u
         beq   L046D
         lda   <$23,y
         bita  #$10
         beq   L046D
         bsr   L0424
         ldd   #$00F0
         std   u000A,u
         bra   L046D
L0469    bsr   L0424
L046B    bsr   L0470
L046D    clrb  
         puls  pc,y,x,b,a
L0470    lda   #$01
         sta   <u0032
         ldx   #$0001
         leay  u000A,u
         clr   $04,y
         ldd   #$00F0
         os9   F$VIRQ   
         bcc   L0487
         lda   #$80
         sta   <u0032
L0487    clra  
         rts   
L0489    pshs  a
         lda   >-u00A2,u
         beq   L049F
         ldb   #$0C
         stb   >nh_data
         lda   #$D8
         sta   >$FF48
         clr   u0004,u
         bra   L04A3
L049F    lda   <u008A
         beq   L04A7
L04A3    bsr   L0470
         bra   L04AE
L04A7    sta   >$FF40
         clr   u000E,u
         clr   <u0032
L04AE    puls  pc,a
L04B0    ldx   <$1E,y
         ldb   #$14
L04B5    clr   b,x
         decb  
         bpl   L04B5
         ldb   <$26,y
         lda   <$27,y
         mul   
         subd  #$0001
         lda   <$2A,y
         sta   $03,x
         sta   <$12,x
         mul   
         addd  <$2B,y
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
         rts   
         emod
eom      equ   *
