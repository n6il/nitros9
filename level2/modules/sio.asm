********************************************************************
* SIO - CoCo 3 Serial driver
*
* $Id$
*
* Ed.    Comments                                       Who YY/MM/DD
* ------------------------------------------------------------------
* 9      Original Tandy L2 distribution version

         nam   SIO
         ttl   CoCo 3 Serial driver

* Disassembled 98/08/23 20:58:36 by Disasm v1.6 (C) 1988 by RML

         ifp1
         use   defsfile
         endc

tylg     set   Drivr+Objct   
atrv     set   ReEnt+rev
rev      set   $01
edition  set   9

         mod   eom,name,tylg,atrv,start,size

u0000    rmb   29
u001D    rmb   1
u001E    rmb   1
u001F    rmb   1
u0020    rmb   2
u0022    rmb   2
u0024    rmb   1
u0025    rmb   1
size     equ   .
         fcb   $03 

name     fcs   /SIO/
         fcb   edition

L0012    fcb   $09 
         fcb   $0C 
         fcb   $03 
         fcb   $4C L
         fcb   $01
         fcb   $A2 "
         fcb   $00 
         fcb   $CE N
         fcb   $00 
         fcb   $62 b
         fcb   $00 
         fcb   $2E .
         fcb   $00 
         fcb   $12 
         fcb   $00 
         fcb   $03 

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
Init     pshs  cc
         orcc  #IntMasks
         ldx   #PIA1Base
         clr   $01,x
         ldd   <IT.COL,y		get col/row bytes
         std   <u0024,u
         lda   #$FE
         sta   ,x
         lda   #$36
         sta   $01,x
         lda   ,x
         ldd   <IT.PAR,y		get parity/baud
         lbsr  L0148
         puls  cc
         clrb

* Term
*
* Entry:
*    U  = address of device memory area
*
* Exit:
*    CC = carry set on error
*    B  = error code
*
Term     rts

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
Read     bsr   L00AC
         bcs   L00C8
         ldb   #$08
         pshs  b,cc
         tst   <u001E,u
         beq   L0066
         dec   $01,s
L0066    bra   L0077
L0068    lda   <PD.BAU,y
         anda  #$0F
         cmpa  #$07
         beq   L0077
         ldx   #$0001
         os9   F$Sleep
L0077    pshs  y
         ldy   #$FFFF
L007D    lda   >PIA1Base+2
         leay  -$01,y
         beq   L008B
         lsra
         bcs   L007D
         puls  y
         bra   L0090
L008B    puls  y
         lsra
         bcs   L0068
L0090    orcc  #IntMasks
         clra
         bsr   L00D5
L0095    bsr   L00CE
         ldb   >PIA1Base+2
         lsrb
         rora
         dec   $01,s
         bne   L0095
         bsr   L00D5
         tst   <u001E,u
         beq   L00A8
         lsra
L00A8    puls  b,cc
         clrb
         rts
L00AC    pshs  a
         lda   <PD.BAU,y
         anda  #$0F
         cmpa  #$08
         bcc   L00C4
         lsla
         leax  >L0012,pcr
         ldd   a,x
         std   <u0020,u
         clrb
         puls  pc,a
L00C4    ldb   #E$BMode
         puls  a
L00C8    orcc  #Carry
         rts
L00CB    stb   >PIA1Base
L00CE    pshs  b,a
         ldd   <u0020,u
         bra   L00DC
L00D5    pshs  b,a
         ldd   <u0020,u
         lsra
         rorb
L00DC    subd  #$0001
         bne   L00DC
         puls  pc,b,a

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
Write    bsr   L00AC
         bcs   L00C8
         ldb   #$09
         pshs  b,cc
         orcc  #IntMasks
         tst   <u001E,u
         beq   L00F4
         dec   $01,s
L00F4    andcc #^Carry
L00F6    ldb   #$02
         bcs   L00FB
         clrb
L00FB    bsr   L00CB
         lsra
         dec   $01,s
         bne   L00F6
         ldb   <u001D,u
         beq   L010B
         andb  #$FE
         bsr   L00CB
L010B    ldb   #$02
         bsr   L00CB
         tst   <u001F,u
         beq   L0118
         ldb   #$02
         bsr   L00CB
L0118    puls  pc,b,cc

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
GetStat  cmpa  #SS.EOF
         bne   L0120
L011E    clrb
         rts
L0120    ldx   PD.RGS,y
         cmpa  #SS.ScSiz
         beq   L0131
         cmpa  #SS.ComSt
         bne   L017E
         ldd   <u0022,u
         std   R$Y,x
         bra   L011E
L0131    ldx   PD.RGS,y
         clra
         ldb   <u0024,u
         std   R$X,x
         ldb   <u0025,u
         std   R$Y,x
         bra   L011E

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
SetStat  cmpa  #SS.ComSt
         bne   L017E
         ldx   PD.RGS,y
         ldd   R$Y,x
L0148    std   <u0022,u
         clra
         clrb
         std   <u001D,u
         sta   <u001F,u
         ldd   <u0022,u
         tstb
         bpl   L015C
         inc   <u001F,u
L015C    bitb  #$40
         bne   L017A
         bitb  #$20
         beq   L0167
         inc   <u001E,u
L0167    bita  #$20
         beq   L0179
         bita  #$80
         beq   L017A
         inc   <u001D,u
         bita  #$40
         bne   L0179
         inc   <u001D,u
L0179    rts
L017A    comb
         ldb   #E$BMode
         rts
L017E    comb
         ldb   #E$UnkSvc
         rts

         emod
eom      equ   *
         end
