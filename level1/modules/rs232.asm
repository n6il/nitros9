********************************************************************
* RS232 - CoCo bit-banger driver
*
* $Id$
*
* Ed.    Comments                                       Who YY/MM/DD
* ------------------------------------------------------------------
*   7    From Tandy OS-9 Level One VR 02.00.00

         nam   RS232
         ttl   CoCo bit-banger driver

* Disassembled 98/08/23 17:32:49 by Disasm v1.6 (C) 1988 by RML

         ifp1
         use   defsfile
         use   scfdefs
         endc

tylg     set   Drivr+Objct   
atrv     set   ReEnt+rev
rev      set   $01
edition  set   7

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

name     fcs   /RS232/
         fcb   edition

L0014    fcb   $04
         fcb   $82 
         fcb   $01
         fcb   $A2 "
         fcb   $00 
         fcb   $CD M
         fcb   $00 
         fcb   $63 c
         fcb   $00 
         fcb   $2D -
         fcb   $00 
         fcb   $13 
         fcb   $00 
         fcb   $05 

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
         ldx   #PIA.U8
         clr   $01,x
         ldd   <IT.COL,y		get col/row bytes
         std   <u0024,u
         lda   #$FE
         sta   ,x
         lda   #$36
         sta   $01,x
         lda   ,x
         ldd   <IT.PAR,y		get parity/baud
         lbsr  L014D
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
Read     bsr   L00B1
         bcs   L00CD
         ldb   #$08
         pshs  b,cc
         tst   <u001E,u
         beq   L0066
         dec   $01,s
L0066    bra   L006E
L0068    ldx   #$0001
         os9   F$Sleep
L006E    lda   >PIA.U8+2
         lsra
         pshs  x,a
         lda   >$FF69
         bpl   L0091
         lda   >PIA.U8+3
         bita  #$01
         beq   L0091
         bita  #$80
         beq   L0091
         orcc  #Entire
         leax  <L0091,pcr
         pshs  x
         pshs  u,y,x,dp,b,a,cc
         jmp   [D.SvcIRQ]
L0091    puls  x,a
         bcs   L0068
         orcc  #IntMasks
         clra
         bsr   L00DA
L009A    bsr   L00D3
         ldb   >PIA.U8+2
         lsrb
         rora
         dec   $01,s
         bne   L009A
         bsr   L00DA
         tst   <u001E,u
         beq   L00AD
         lsra
L00AD    puls  b,cc
         clrb
         rts
L00B1    pshs  a
         lda   <PD.BAU,y
         anda  #$0F
         cmpa  #$07
         bcc   L00C9
         lsla
         leax  >L0014,pcr
         ldd   a,x
         std   <u0020,u
         clrb
         puls  pc,a
L00C9    ldb   #$CB
         puls  a
L00CD    orcc  #Carry
         rts
L00D0    stb   >PIA.U8
L00D3    pshs  b,a
         ldd   <u0020,u
         bra   L00E1
L00DA    pshs  b,a
         ldd   <u0020,u
         lsra
         rorb
L00E1    subd  #$0001
         bne   L00E1
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
Write    bsr   L00B1
         bcs   L00CD
         ldb   #$09
         pshs  b,cc
         orcc  #IntMasks
         tst   <u001E,u
         beq   L00F9
         dec   $01,s
L00F9    andcc #^Carry
L00FB    ldb   #$02
         bcs   L0100
         clrb
L0100    bsr   L00D0
         lsra
         dec   $01,s
         bne   L00FB
         ldb   <u001D,u
         beq   L0110
         andb  #$FE
         bsr   L00D0
L0110    ldb   #$02
         bsr   L00D0
         tst   <u001F,u
         beq   L011D
         ldb   #$02
         bsr   L00D0
L011D    puls  pc,b,cc

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
         bne   L0125
L0123    clrb
         rts
L0125    ldx   PD.RGS,y
         cmpa  #SS.ScSiz
         beq   L0136
         cmpa  #SS.ComSt
         bne   L0183
         ldd   <u0022,u
         std   R$Y,x
         bra   L0123
L0136    ldx   PD.RGS,y
         clra
         ldb   <u0024,u
         std   R$X,x
         ldb   <u0025,u
         std   R$Y,x
         bra   L0123

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
         bne   L0183
         ldx   PD.RGS,y
         ldd   R$Y,x
L014D    std   <u0022,u
         clra
         clrb
         std   <u001D,u
         sta   <u001F,u
         ldd   <u0022,u
         tstb
         bpl   L0161
         inc   <u001F,u
L0161    bitb  #$40
         bne   L017F
         bitb  #$20
         beq   L016C
         inc   <u001E,u
L016C    bita  #$20
         beq   L017E
         bita  #$80
         beq   L017F
         inc   <u001D,u
         bita  #$40
         bne   L017E
         inc   <u001D,u
L017E    rts
L017F    comb
         ldb   <E$BMode
         rts
L0183    comb
         ldb   #E$UnkSvc
         rts

         emod
eom      equ   *
         end

