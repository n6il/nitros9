********************************************************************
* error - show error messages
*
* $Id$
*
* Ed.    Comments                                       Who YY/MM/DD
* ------------------------------------------------------------------
*   2    From Tandy OS-9 Level Two Vr. 02.00.01

         nam   error
         ttl   show error messages

* Disassembled 02/07/06 13:09:55 by Disasm v1.6 (C) 1988 by RML

         ifp1
         use   defsfile
         endc

tylg     set   Prgrm+Objct   
atrv     set   ReEnt+rev
rev      set   $01
edition  set   2

L0000    mod   eom,name,tylg,atrv,start,size

u0000    rmb   1
u0001    rmb   1
u0002    rmb   1
u0003    rmb   1
u0004    rmb   1
u0005    rmb   12
u0011    rmb   15
u0020    rmb   55
u0057    rmb   2
u0059    rmb   2
u005B    rmb   42
u0085    rmb   13
u0092    rmb   25
u00AB    rmb   49
u00DC    rmb   2
u00DE    rmb   58
u0118    rmb   1
u0119    rmb   3
u011C    rmb   912
size     equ   .

name     fcs   /error/
         fcb   edition

L0013    fcb   $A6 &
         fcb   $A0 
         fcb   $A7 '
         fcb   $C0 @
         fcb   $30 0
         fcb   $1F 
         fcb   $26 &
         fcb   $F8 x
         fcb   $39 9
start    equ   *
         pshs  y
         pshs  u
         clra  
         clrb  
L0022    sta   ,u+
         decb  
         bne   L0022
         ldx   ,s
         leau  ,x
         leax  >$012C,x
         pshs  x
         leay  >L064C,pcr
         ldx   ,y++
         beq   L003D
         bsr   L0013
         ldu   $02,s
L003D    leau  >u0057,u
         ldx   ,y++
         beq   L0048
         bsr   L0013
         clra  
L0048    cmpu  ,s
         beq   L0051
         sta   ,u+
         bra   L0048
L0051    ldu   $02,s
         ldd   ,y++
         beq   L005E
         leax  >L0000,pcr
         lbsr  L0161
L005E    ldd   ,y++
         beq   L0067
         leax  ,u
         lbsr  L0161
L0067    leas  $04,s
         puls  x
         stx   >u011C,u
         sty   >u00DC,u
         ldd   #$0001
         std   >u0118,u
         leay  >u00DE,u
         leax  ,s
         lda   ,x+
L0083    ldb   >u0119,u
         cmpb  #$1D
         beq   L00DF
L008B    cmpa  #$0D
         beq   L00DF
         cmpa  #$20
         beq   L0097
         cmpa  #$2C
         bne   L009B
L0097    lda   ,x+
         bra   L008B
L009B    cmpa  #$22
         beq   L00A3
         cmpa  #$27
         bne   L00C1
L00A3    stx   ,y++
         inc   >u0119,u
         pshs  a
L00AB    lda   ,x+
         cmpa  #$0D
         beq   L00B5
         cmpa  ,s
         bne   L00AB
L00B5    puls  b
         clr   -$01,x
         cmpa  #$0D
         beq   L00DF
         lda   ,x+
         bra   L0083
L00C1    leax  -$01,x
         stx   ,y++
         leax  $01,x
         inc   >u0119,u
L00CB    cmpa  #$0D
         beq   L00DB
         cmpa  #$20
         beq   L00DB
         cmpa  #$2C
         beq   L00DB
         lda   ,x+
         bra   L00CB
L00DB    clr   -$01,x
         bra   L0083
L00DF    leax  >u00DC,u
         pshs  x
         ldd   >u0118,u
         pshs  b,a
         leay  ,u
         bsr   L00F9
         lbsr  L017B
         clr   ,-s
         clr   ,-s
         lbsr  L063F
L00F9    leax  >$012C,y
         stx   >$0126,y
         sts   >$011A,y
         sts   >$0128,y
         ldd   #$FF82
L010E    leax  d,s
         cmpx  >$0128,y
         bcc   L0120
         cmpx  >$0126,y
         bcs   L013A
         stx   >$0128,y
L0120    rts   
L0121    fcc  "**** STACK OVERFLOW ****"
         fcb  C$CR
L013A    leax  <L0121,pcr
         ldb   #$CF
         pshs  b
         lda   #$02
         ldy   #$0064
L0147    os9   I$WritLn 
         clr   ,-s
         lbsr  L0645
L014F    ldd   >$011A,y
         subd  >$0128,y
         rts   
         ldd   >$0128,y
         subd  >$0126,y
L0160    rts   
L0161    pshs  x
         leax  d,y
         leax  d,x
         pshs  x
L0169    ldd   ,y++
         leax  d,u
         ldd   ,x
         addd  $02,s
         std   ,x
         cmpy  ,s
         bne   L0169
         leas  $04,s
L017A    rts   
L017B    pshs  u
         ldd   #$FFB6
         lbsr  L010E
         ldd   $04,s
         cmpd  #$0002
         bge   L01AD
         bra   L01A6
L018D    ldd   #$0050
         pshs  b,a
         ldx   <u0001
         leax  $02,x
         stx   <u0001
         ldd   -$02,x
         pshs  b,a
         ldd   #$0002
         pshs  b,a
         lbsr  L05BA
         leas  $06,s
L01A6    ldd   <u0001
         cmpd  <u0003
         bcs   L018D
L01AD    ldd   #$0001
         pshs  b,a
         leax  >L03E1,pcr
         pshs  x
         lbsr  L04F4
         leas  $04,s
         std   <u0005
         cmpd  #$FFFF
         bne   L01E5
         ldd   #$001C
         pshs  b,a
         leax  >L03F0,pcr
         pshs  x
         lbsr  L0358
         leas  $04,s
         bra   L01E5
L01D7    ldx   $06,s
         leax  $02,x
         stx   $06,s
         ldd   ,x
         pshs  b,a
         bsr   L01F8
         leas  $02,s
L01E5    ldd   $04,s
         addd  #$FFFF
         std   $04,s
         bne   L01D7
         ldd   <u0005
         pshs  b,a
         lbsr  L0503
         lbra  L038E
L01F8    pshs  u
         ldd   #$FFA8
         lbsr  L010E
         leas  -$0C,s
         clra  
         clrb  
         std   ,s
         clra  
         clrb  
         pshs  b,a
         clra  
         clrb  
         pshs  b,a
         pshs  b,a
         ldd   <u0005
         pshs  b,a
         lbsr  L05CA
         leas  $08,s
         lbra  L02E4
L021C    clra  
         clrb  
         std   $04,s
         std   $02,s
         ldu   <$10,s
         bra   L0229
L0227    leau  u0001,u
L0229    ldb   ,u
         cmpb  #$30
         beq   L0227
         stu   $08,s
         leax  >$0007,y
         stx   $0A,s
         bra   L026C
L0239    ldb   ,u
         sex   
         leax  >$005C,y
         leax  d,x
         ldb   ,x
         clra  
         andb  #$08
         beq   L0265
         ldb   ,u+
         sex   
         pshs  b,a
         ldx   $0C,s
         leax  $01,x
         stx   $0C,s
         ldb   -$01,x
         sex   
         cmpd  ,s++
         beq   L026C
         ldd   $04,s
         addd  #$0001
         std   $04,s
         bra   L026C
L0265    ldd   $02,s
         addd  #$0001
         std   $02,s
L026C    ldb   ,u
         beq   L0278
         ldd   $04,s
         bne   L0278
         ldd   $02,s
         beq   L0239
L0278    ldd   $02,s
         beq   L02B6
         ldd   $08,s
         pshs  b,a
         lbsr  L045E
         std   ,s
         ldd   $0A,s
         pshs  b,a
         ldd   #$0002
         pshs  b,a
         lbsr  L05A1
         leas  $06,s
         ldd   #$0019
         pshs  b,a
         leax  >L040B,pcr
         pshs  x
         ldd   #$0002
         pshs  b,a
         lbsr  L05BA
         leas  $06,s
         ldd   $04,s
         addd  #$0001
         std   $04,s
         ldd   ,s
         addd  #$0001
         std   ,s
L02B6    ldb   [<$0A,s]
         cmpb  #$20
         beq   L02C4
         ldd   $04,s
         addd  #$0001
         std   $04,s
L02C4    ldd   $04,s
         bne   L02E4
         ldd   #$0050
         pshs  b,a
         leax  >$0007,y
         pshs  x
         ldd   #$0001
         pshs  b,a
         lbsr  L05BA
         leas  $06,s
         ldd   ,s
         addd  #$0001
         std   ,s
L02E4    ldd   #$0050
         pshs  b,a
         leax  >$0007,y
         pshs  x
         ldd   <u0005
         pshs  b,a
         lbsr  L0591
         leas  $06,s
         std   -$02,s
         ble   L0301
         ldd   #$0001
         bra   L0303
L0301    clra  
         clrb  
L0303    std   $06,s
         beq   L030D
         ldd   ,s
         lbeq  L021C
L030D    ldd   $06,s
         cmpd  #$FFFF
         bne   L0324
         ldd   #$001C
         pshs  b,a
         leax  >L0423,pcr
         pshs  x
         bsr   L0358
         leas  $04,s
L0324    ldd   ,s
         bne   L0354
         ldd   $08,s
         pshs  b,a
         lbsr  L045E
         std   ,s
         ldd   $0A,s
         pshs  b,a
         ldd   #$0001
         pshs  b,a
         lbsr  L05A1
         leas  $06,s
         ldd   #$0019
         pshs  b,a
         leax  >L043E,pcr
         pshs  x
         ldd   #$0001
         pshs  b,a
         lbsr  L05BA
         leas  $06,s
L0354    leas  $0C,s
         puls  pc,u
L0358    pshs  u
         ldd   #$FFB6
         lbsr  L010E
         ldd   #$0007
         pshs  b,a
         leax  >L0456,pcr
         pshs  x
         ldd   #$0002
         pshs  b,a
         lbsr  L05A1
         leas  $06,s
         ldd   $06,s
         pshs  b,a
         ldd   $06,s
         pshs  b,a
         ldd   #$0002
         pshs  b,a
         lbsr  L05BA
         leas  $06,s
         clra  
         clrb  
         pshs  b,a
         lbsr  L063F
L038E    leas  $02,s
         puls  pc,u
         fcc   "Error  errno [errno...]"
         fcb   C$CR
         fcb   $00
         fcc   "Usage: returns error message for given error numbers"
         fcb   C$CR
         fcb   $00
L03E1    fcc   "/dd/sys/errmsg"
         fcb   $00
L03F0    fcc   "can't open /dd/sys/errmsg"
         fcb   C$CR
         fcb   $00
L040B    fcc   " : not an error number"
         fcb   C$CR
         fcb   $00
L0423    fcc   "error reading errmsg file"
         fcb   C$CR
         fcb   $00
L043E    fcc   " : not an error number"
         fcb   C$CR
         fcb   $00
L0456    fcc   "error: "
         fcb   $00
      
L045E    pshs  u
         ldu   $04,s
L0462    ldb   ,u+
         bne   L0462
         tfr   u,d
         subd  $04,s
         addd  #$FFFF
         puls  pc,u
         pshs  u
         ldu   $06,s
L0473    leas  -$02,s
         ldd   $06,s
         std   ,s
L0479    ldb   ,u+
         ldx   ,s
L047D    leax  $01,x
         stx   ,s
         stb   -$01,x
         bne   L0479
         bra   L04AE
         pshs  u
         ldu   $06,s
         leas  -$02,s
         ldd   $06,s
         std   ,s
L0491    ldx   ,s
         leax  $01,x
         stx   ,s
         ldb   -$01,x
         bne   L0491
         ldd   ,s
         addd  #$FFFF
         std   ,s
L04A2    ldb   ,u+
         ldx   ,s
         leax  $01,x
         stx   ,s
         stb   -$01,x
         bne   L04A2
L04AE    ldd   $06,s
L04B0    leas  $02,s
         puls  pc,u
         pshs  u
         ldu   $04,s
         bra   L04CA
L04BA    ldx   $06,s
         leax  $01,x
         stx   $06,s
         ldb   -$01,x
         bne   L04C8
         clra  
         clrb  
         puls  pc,u
L04C8    leau  u0001,u
L04CA    ldb   ,u
         sex   
         pshs  b,a
         ldb   [<$08,s]
         sex   
         cmpd  ,s++
         beq   L04BA
         ldb   [<$06,s]
         sex   
         pshs  b,a
         ldb   ,u
         sex   
         subd  ,s++
         puls  pc,u
         ldx   $02,s
         lda   $05,s
         os9   I$Open   
         bcs   L04F1
         os9   I$Close  
L04F1    lbra  L063A
L04F4    ldx   $02,s
         lda   $05,s
         os9   I$Open   
         lbcs  L0631
         tfr   a,b
         clra  
         rts   
L0503    lda   $03,s
         os9   I$Close  
         lbra  L063A
         ldx   $02,s
         ldb   $05,s
         os9   I$MakDir 
         lbra  L063A
         ldx   $02,s
         lda   $05,s
         tfr   a,b
         andb  #$24
         orb   #$0B
         os9   I$Create 
         bcs   L0528
L0524    tfr   a,b
         clra  
         rts   
L0528    cmpb  #$DA
         lbne  L0631
         lda   $05,s
         bita  #$80
         lbne  L0631
         anda  #$07
         ldx   $02,s
         os9   I$Open   
         lbcs  L0631
         pshs  u,a
         ldx   #$0000
         leau  ,x
         ldb   #$02
         os9   I$SetStt 
         puls  u,a
         bcc   L0524
         pshs  b
         os9   I$Close  
         puls  b
         lbra  L0631
         ldx   $02,s
         os9   I$Delete 
         lbra  L063A
         lda   $03,s
         os9   I$Dup    
         lbcs  L0631
         tfr   a,b
         clra  
         rts   
         pshs  y
         ldx   $06,s
         lda   $05,s
         ldy   $08,s
         pshs  y
         os9   I$Read   
L057E    bcc   L058D
         cmpb  #$D3
         bne   L0588
         clra  
         clrb  
         puls  pc,y,x
L0588    puls  y,x
         lbra  L0631
L058D    tfr   y,d
         puls  pc,y,x
L0591    pshs  y
         lda   $05,s
         ldx   $06,s
         ldy   $08,s
         pshs  y
         os9   I$ReadLn 
         bra   L057E
L05A1    pshs  y
         ldy   $08,s
         beq   L05B6
         lda   $05,s
         ldx   $06,s
         os9   I$Write  
L05AF    bcc   L05B6
         puls  y
         lbra  L0631
L05B6    tfr   y,d
         puls  pc,y
L05BA    pshs  y
         ldy   $08,s
         beq   L05B6
         lda   $05,s
         ldx   $06,s
         os9   I$WritLn 
         bra   L05AF
L05CA    pshs  u
         ldd   $0A,s
         bne   L05D8
         ldu   #$0000
         ldx   #$0000
         bra   L060C
L05D8    cmpd  #$0001
         beq   L0603
         cmpd  #$0002
         beq   L05F8
         ldb   #$F7
L05E6    clra  
         std   >$012A,y
         ldd   #$FFFF
         leax  >$011E,y
         std   ,x
         std   $02,x
         puls  pc,u
L05F8    lda   $05,s
         ldb   #$02
         os9   I$GetStt 
         bcs   L05E6
         bra   L060C
L0603    lda   $05,s
         ldb   #$05
         os9   I$GetStt 
         bcs   L05E6
L060C    tfr   u,d
         addd  $08,s
         std   >$0120,y
         tfr   d,u
         tfr   x,d
         adcb  $07,s
         adca  $06,s
         bmi   L05E6
         tfr   d,x
         std   >$011E,y
         lda   $05,s
         os9   I$Seek   
         bcs   L05E6
         leax  >$011E,y
         puls  pc,u
L0631    clra  
         std   >$012A,y
         ldd   #$FFFF
         rts   
L063A    bcs   L0631
         clra  
         clrb  
         rts   
L063F    lbsr  L064A
         lbsr  L064B
L0645    ldd   $02,s
         os9   F$Exit   
L064A    rts   
L064B    rts   

L064C    fdb   $0005,$0000
         fdb   $5700,$5b00,$8503,$9203,$ab00,$0101,$0101,$0101
         fdb   $0101,$0111,$1101,$1111,$0101,$0101,$0101,$0101
         fdb   $0101,$0101,$0101,$0101,$0101,$3020,$2020,$2020
         fdb   $2020,$2020,$2020,$2020,$2020,$4848,$4848,$4848
         fdb   $4848,$4848,$2020,$2020,$2020,$2042,$4242,$4242
         fdb   $4202,$0202,$0202,$0202,$0202,$0202,$0202,$0202
         fdb   $0202,$0202,$0220,$2020,$2020,$2044,$4444,$4444
         fdb   $4404,$0404,$0404,$0404,$0404,$0404,$0404,$0404
         fdb   $0404,$0404,$0420,$2020,$2001,$0002,$0059,$0057
         fdb   $0002,$0003,$0001

         fcc   "error"
         fcb   $00

         emod
eom      equ   *
         end
