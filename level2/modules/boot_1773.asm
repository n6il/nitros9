********************************************************************
* Boot - WD1773 Boot module
*
* $Id$
*
* Ed.    Comments                                       Who YY/MM/DD
* ------------------------------------------------------------------
* 4      Original Tandy distribution version
* 6      Obtained from L2 Upgrade archive, has 6ms step BGP 98/10/12
*        rate and disk timeout changes

         nam   Boot
         ttl   WD1773 Boot module

         ifp1
         use   defsfile
         endc

* Step Rate:
*      $00  = 6ms
*      $01  =
*      $02  =
*      $03  = 30ms
STEP     equ   $00

tylg     set   Systm+Objct
atrv     set   ReEnt+rev
rev      set   $01
edition  set   6

         mod   eom,name,tylg,atrv,start,size

u0000    rmb   2
u0002    rmb   2
u0004    rmb   1
u0005    rmb   1
u0006    rmb   1
u0007    rmb   1
u0008    rmb   1
u0009    rmb   1
size     equ   .

name     fcs   /Boot/
         fcb   edition

start    clra
         ldb   #size
L0015    pshs  a
         decb
         bne   L0015
         tfr   s,u
         ldx   #$FF48
         lda   #$D0
         sta   ,x
         lbsr  L01AA
         lda   ,x
         lda   #$FF
         sta   u0004,u
         leax  >NMIRtn,pcr
         stx   <D.NMI
         lda   #$09
         sta   >$FF40
         ldd   #$C350
         ifne  NitrOS9
         nop
         endc
L003A    nop
         nop
         ifne  NitrOS9
         nop
         nop
         nop
         endc
         subd  #$0001
         bne   L003A
         pshs  u,y,x,b,a
         ldd   #$0001
         os9   F$SRqMem
         bcs   L00AA
         tfr   u,d
         ldu   $06,s
         std   u0002,u
         clrb
         ldx   #$0000
         bsr   L00C7
         bcs   L00AA
         ldd   $01,y
         std   u0007,u
         lda   <$10,y
         sta   u0005,u
         anda  #$01
         sta   u0008,u
         lda   $03,y
         sta   u0006,u
         ldd   <$18,y
         std   ,s
         ldx   <$16,y
         pshs  x
         ldd   #256
         ldu   u0002,u
         os9   F$SRtMem
         ldd   $02,s
         os9   F$BtMem
         puls  x
         bcs   L00AA
         stu   $02,s
         ldu   $06,s
         ldd   $02,s
         std   u0002,u
         ldd   ,s
         beq   L00A3
L0091    pshs  x,b,a
         clrb
         bsr   L00C7
         bcs   L00A8
         puls  x,b,a
         inc   u0002,u
         leax  1,x
         subd  #256
         bhi   L0091
L00A3    clrb
         puls  b,a
         bra   L00AC
L00A8    leas  $04,s
L00AA    leas  $02,s
L00AC    sta   >$FFD9
         puls  u,y,x
         leas  $0A,s
         clr   >$FF40
         rts
L00B7    lda   #$29
         sta   ,u
         clr   u0004,u
         lda   #$05
         lbsr  L0170
         ldb   #STEP
         lbra  L0195
L00C7    lda   #$91
         cmpx  #$0000
         bne   L00DF
         bsr   L00DF
         bcs   L00D6
         ldy   u0002,u
         clrb
L00D6    rts
L00D7    bcc   L00DF
         pshs  x,b,a
         bsr   L00B7
         puls  x,b,a
L00DF    pshs  x,b,a
         bsr   L00EA
         puls  x,b,a
         bcc   L00D6
         lsra
         bne   L00D7
L00EA    bsr   L013C
         bcs   L00D6
         ldx   u0002,u
         orcc  #IntMasks
         pshs  y
         ldy   #$FFFF
         ldb   #$80
         stb   >$FF48
         ldb   ,u
         orb   #$30
         tst   u0009,u
         beq   L0107
         orb   #$40
L0107    stb   >$FF40
         lbsr  L01AA
         orb   #$80
         lda   #$02
L0111    bita  >$FF48
         bne   L0123
         leay  -$01,y
         bne   L0111
         lda   ,u
         sta   >$FF40
         puls  y
         bra   L0138
L0123    lda   >$FF4B
         sta   ,x+
         stb   >$FF40
         bra   L0123

NMIRtn   leas  R$Size,s
         puls  y
         ldb   >$FF48
         bitb  #$04
         beq   L018F
L0138    comb
         ldb   #E$Read
         rts
L013C    lda   #$09
         sta   ,u
         clr   u0009,u
         tfr   x,d
         cmpd  #$0000
         beq   L016C
         clr   ,-s
         tst   u0008,u
         beq   L0162
         bra   L0158
L0152    com   u0009,u
         bne   L0158
         inc   ,s
L0158    subb  u0006,u
         sbca  #$00
         bcc   L0152
         bra   L0168
L0160    inc   ,s
L0162    subb  u0006,u
         sbca  #$00
         bcc   L0160
L0168    addb  #$12
         puls  a
L016C    incb
         stb   >$FF4A
L0170    ldb   u0004,u
         stb   >$FF49
         cmpa  u0004,u
         beq   L018D
         sta   u0004,u
         sta   >$FF4B
         ldb   #$10+STEP
         bsr   L0195
         pshs  x
         ldx   #$222E
L0187    leax  -$01,x
         bne   L0187
         puls  x
L018D    clrb
         rts
L018F    bitb  #$98
         bne   L0138
         clrb
         rts
L0195    bsr   L01A8
L0197    ldb   >$FF48
         bitb  #$01
         bne   L0197
         rts
L019F    lda   ,u
         sta   >$FF40
         stb   >$FF48
         rts
L01A8 
         ifne  NitrOS9
         nop
         endc
         bsr   L019F
L01AA  
         ifne  NitrOS9
         nop
         nop
         endc
         lbsr  L01AD
L01AD 
         ifne  NitrOS9
         nop
         nop
         endc
         lbsr  L01B0
L01B0 
         ifne  NitrOS9
         nop
         endc
         rts

* Filler to get $1D0
Filler   fcb   $39,$39,$39,$39,$39,$39,$39,$39,$39,$39,$39,$39,$39,$39,$39,$39
         fcb   $39,$39
         ifeq  NitrOS9
         fcb   $39,$39,$39,$39,$39,$39,$39,$39,$39,$39
         endc

         emod
eom      equ   *
         end
