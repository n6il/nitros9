********************************************************************
* Boot - OS-9 Level One V2 Boot for WD1773
*
* $Id$
*
* Ed.    Comments                                       Who YY/MM/DD
* ------------------------------------------------------------------
*   1    From Tandy OS-9 Level One VR 02.00.00

         nam   Boot
         ttl   OS-9 Level One V2 Boot for WD1773

         ifp1
         use   defsfile
         use   rbfdefs
         endc

tylg     set   Systm+Objct
atrv     set   ReEnt+rev
rev      set   $01
edition  set   1

         mod   eom,name,tylg,atrv,start,size

u0000    rmb   2
u0002    rmb   2
u0004    rmb   1
size     equ   .

name     fcs   /Boot/
         fcb   edition

* First, we make a stack...
start    clra
         ldb   #size
MakeStak pshs  a
         decb
         bne   MakeStak

         tfr   s,u
         ldx   #DPort
         leax  $08,x
         lda   #$D0
         sta   ,x
         lbsr  Delay
         lda   ,x
         lda   #$FF
         sta   u0004,u
         leax  >L010E,pcr
         stx   >$010A
         lda   #$7E
         sta   >$0109
         lda   #$08
         sta   >DPort
         ldd   #$C350
L0042    nop
         nop
         subd  #$0001
         bne   L0042

* search for a free page (to use as a 256 byte disk buffer)
         pshs  u,x,b,a
         clra
         clrb
         ldy   #$0001
         ldx   <D.FMBM                 start of bitmap
         ldu   <D.FMBM+2               end of bitmap
         os9   F$SchBit
         bcs   L009B
         exg   a,b
         ldu   $04,s                   get statics pointer
         std   u0002,u
         clrb

* go get LSN0
         ldx   #$0000
         bsr   L00B0
         bcs   L009B

* get bootfile size from LSN0 and allocate memory for it
         ldd   <DD.BSZ,y
         std   ,s
         os9   F$SRqMem
         bcs   L009B
         stu   $02,s
         ldu   $04,s
         ldx   $02,s
         stx   u0002,u
         ldx   <DD.BT+1,y              get starting sector
         ldd   <DD.BSZ,y               and bootfile size
         beq   L0094

* this loop reads a sector at a time from the bootfile
RdSctLp  pshs  x,b,a
         clrb
* X = sector #
         bsr   L00B0
         bcs   L0099
         puls  x,b,a
         inc   u0002,u
         leax  $01,x
         subd  #256
         bhi   RdSctLp
L0094    clrb
         puls  b,a
         bra   L009D
L0099    leas  $04,s
L009B    leas  $02,s
L009D    puls  u,x
         leas  5,s                     restore stack
         rts                           return to OS9

L00A2    clr   ,u
         clr   u0004,u
         lda   #$05
         lbsr  L013A
         ldb   #$00			6ms step rate
*         ldb   #$03
         lbra  L015F

L00B0    lda   #$91
         cmpx  #$0000
         bne   L00C8
         bsr   L00C8
         bcs   L00BF
         ldy   u0002,u
         clrb
L00BF    rts

L00C0    bcc   L00C8
         pshs  x,b,a
         bsr   L00A2
         puls  x,b,a

L00C8    pshs  x,b,a
         bsr   L00D3
         puls  x,b,a
         bcc   L00BF
         lsra
         bne   L00C0
L00D3    bsr   L011D
         bcs   L00BF
         ldx   u0002,u
         orcc  #FIRQMask+IRQMask
         pshs  y
         ldy   #$FFFF
         ldb   #$80
         stb   >DPort+8
         ldb   #$39
         stb   >DPort
         lbsr  Delay
         ldb   #$B9
         lda   #$02
L00F2    bita  >DPort+8
         bne   L0104
         leay  -$01,y
         bne   L00F2
         lda   #$09
         sta   >DPort
         puls  y
         bra   L0119

L0104    lda   >DPort+$0B
         sta   ,x+
         stb   >DPort
         bra   L0104
L010E    leas  $0C,s
         puls  y
         ldb   >DPort+8
         bitb  #$04
         beq   L0159
L0119    comb
         ldb   #E$Read                 E$READ error
         rts

L011D    clr   ,u
         tfr   x,d
         cmpd  #$0000
         beq   L0136
         clr   ,-s
         bra   L012D
L012B    inc   ,s
L012D    subd  #$0012
         bcc   L012B
         addb  #$12
         puls  a
L0136    incb
         stb   >DPort+$0A
L013A    ldb   u0004,u
         stb   >DPort+9
         cmpa  u0004,u
         beq   L0157
         sta   u0004,u
         sta   >DPort+$0B
         ldb   #$10		6ms step rate
*         ldb   #$13
         bsr   L015F
         pshs  x
         ldx   #$088B		6ms step rate
*         ldx   #$222E
L0151    leax  -1,x
         bne   L0151
         puls  x
L0157    clrb
         rts

L0159    bitb  #$98
         bne   L0119
         clrb
         rts

L015F    bsr   L0172
L0161    ldb   >DPort+8
         bitb  #$01
         bne   L0161
         rts

L0169    lda   #$09
         sta   >DPort
         stb   >DPort+8
         rts

L0172    bsr   L0169

* Delay routine
Delay    lbsr  Delay2
Delay2   lbsr  Delay3
Delay3   rts

         emod
eom      equ   *
         end

