********************************************************************
* PRINTER - CoCo serial port printer driver
*
* $Id$
*
* Ed.    Comments                                       Who YY/MM/DD
* ------------------------------------------------------------------
*  10    From Tandy OS-9 Level One VR 02.00.00

         nam   PRINTER
         ttl   CoCo serial port printer driver

* Disassembled 98/08/23 17:32:06 by Disasm v1.6 (C) 1988 by RML

         ifp1
         use   defsfile
	 use   scfdefs
         endc

tylg     set   Drivr+Objct
atrv     set   ReEnt+rev
rev      set   $01
edition  set   10

         mod   eom,name,tylg,atrv,start,size

u0000    rmb   29
u001D    rmb   1
u001E    rmb   1
u001F    rmb   1
u0020    rmb   2
u0022    rmb   1
u0023    rmb   1
u0024    rmb   2
u0026    rmb   2
u0028    rmb   1
size     equ   .
         fcb   $03

name     fcs   /PRINTER/
         fcb   edition

L0016    fcb   $04
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
         ldd   <IT.COL,y		get column size
         std   <u0022,u
         lda   #$FE
         sta   ,x
         lda   #$36
         sta   $01,x
         lda   ,x
         ldd   <IT.PAR,y		get parity/baud
         lbsr  L0155
         puls  cc
         lbsr  L0104
         lbcs  L0100

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

L005F    pshs  a
         lda   <$35,y
         anda  #$0F
         cmpa  #$07
         bcc   L0076
         lsla
         leax  <L0016,pcr
         ldd   a,x
         std   <u0024,u
         clrb
         puls  pc,a
L0076    ldb   #E$BMode
         puls  a
L007A    orcc  #Carry
         rts
L007D    stb   >PIA.U8
L0080    pshs  b,a
         ldd   <u0024,u
L0085    subd  #$0001
         bne   L0085
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
Write    bsr   L005F
         bcs   L007A
         pshs  b,a
         bsr   L00CB
         puls  b,a
         bcs   L0100
         ldb   #$09
         pshs  b,cc
         orcc  #IntMasks
         tst   <u001E,u
         beq   L00A5
         dec   $01,s
L00A5    andcc #^Carry
L00A7    ldb   #$02
         bcs   L00AC
         clrb
L00AC    bsr   L007D
         lsra
         dec   $01,s
         bne   L00A7
         ldb   <u001D,u
         beq   L00BC
         andb  #$FE
         bsr   L007D
L00BC    ldb   #$02
         bsr   L007D
         tst   <u001F,u
         beq   L00C9
         ldb   #$02
         bsr   L007D
L00C9    puls  pc,b,cc
L00CB    clra
         clrb
         std   <u0026,u
L00D0    ldd   #$0303
L00D3    bsr   L0104
         bcs   L00DE
         bsr   L0080
         decb
         bne   L00D3
         clrb
         rts
L00DE    bsr   L0080
         deca
         bne   L00D3
         pshs  x
         ldx   #$0001
         os9   F$Sleep
         puls  x
         ldd   <u0026,u
         addd  #$0001
         std   <u0026,u
         ldb   <u0028,u
         beq   L00D0
         cmpb  <u0026,u
         bhi   L00D0
L0100    comb
         ldb   #E$NotRdy
         rts
L0104    pshs  x,b,a
         ldb   >PIA.U8+2
         lda   >$FF69
         bpl   L0126
         lda   >PIA.U8+3
         bita  #$01
         beq   L0126
         bita  #$80
         beq   L0126
         orcc  #Entire
         leax  <L0126,pcr
         pshs  x
         pshs  u,y,x,dp,b,a,cc
         jmp   [D.SvcIRQ]
L0126    lsrb
         puls  pc,x,b,a

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
         bne   L012F
L012D    clrb
         rts
L012F    ldx   PD.RGS,y
         cmpa  #SS.ScSiz
         beq   L0140
         cmpa  #SS.ComSt
         bne   L0190
         ldd   <u0020,u
         std   R$Y,x
         bra   L012D
L0140    clra
         ldb   <u0022,u
         std   R$X,x
         ldb   <u0023,u
         std   R$Y,x
         bra   L012D

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
SetStat  cmpa  #SS.ComSt
         bne   L0190
         ldx   PD.RGS,y
         ldd   R$Y,x
L0155    std   <u0020,u
         clra
         clrb
         std   <u001D,u
         sta   <u001F,u
         ldd   <u0020,u
         tstb
         bpl   L0169
         inc   <u001F,u
L0169    bitb  #$40
         bne   Read
         bitb  #$20
         beq   L0174
         inc   <u001E,u
L0174    bita  #$20
         beq   L0186
         bita  #$80
         beq   Read
         inc   <u001D,u
         bita  #$40
         bne   L0186
         inc   <u001D,u
L0186    anda  #$0F
         sta   <u0028,u
         rts

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
Read     comb
         ldb   <E$BMode
         rts

L0190    comb
         ldb   #E$UnkSvc
         rts

         emod
eom      equ   *
         end

