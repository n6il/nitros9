********************************************************************
* ACIAPAK - RS-232 Pak driver
*
* $Id$
*
* Ed.    Comments                                       Who YY/MM/DD
* ------------------------------------------------------------------
*  10    From Tandy OS-9 Level One VR 02.00.00

         nam   ACIAPAK
         ttl   RS-232 Pak driver

* Disassembled 98/08/23 20:25:56 by Disasm v1.6 (C) 1988 by RML

         ifp1
         use   defsfile
         use   scfdefs
         endc

tylg     set   Drivr+Objct   
atrv     set   ReEnt+rev
rev      set   $01
edition  set   10

         mod   eom,name,tylg,atrv,start,size

         rmb   V.SCF		SCF storage requirements
u001D    rmb   1
u001E    rmb   1
u001F    rmb   1
u0020    rmb   1
u0021    rmb   1
u0022    rmb   1
u0023    rmb   1
u0024    rmb   1
u0025    rmb   2
u0027    rmb   1
u0028    rmb   1
u0029    rmb   1
u002A    rmb   1
u002B    rmb   1
orgDFIRQ rmb   2
u002E    rmb   2
u0030    rmb   2
u0032    rmb   25
u004B    rmb   34
u006D    rmb   17
u007E    rmb   2
u0080    rmb   128
size     equ   .

         fcb   UPDAT.

name     fcs   /ACIAPAK/
         fcb   edition

start    lbra  Init
         lbra  Read
         lbra  Write
         lbra  GetStat
         lbra  SetStat
         lbra  Term

IRQPckt  fcb   $00,$80,$0A

* Driver supplied D.FIRQ routine
FIRQRtn  tst   ,s
         bmi   L003B
         leas  -$01,s
         pshs  y,x,dp,b,a
         lda   $08,s
         stu   $07,s
         ora   #$80
         pshs  a
L003B    jmp   [>D.SvcIRQ]

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
Init     ldx   V.PORT,u
         stb   $01,x
         ldd   <IT.COL,y		get column size
         std   <u002A,u
         ldd   <IT.PAR,y		get parity/baud rate
         lbsr  L01CF
         ldd   V.PORT,u
         addd  #$0001
         leax  >IRQPckt,pcr
         leay  >L024E,pcr
         os9   F$IRQ
         bcs   L0085
         pshs  cc
         orcc  #IntMasks
         ldd   <D.FIRQ			get current D.FIRQ vector
         std   <orgDFIRQ,u		save it off locally
         leax  >FIRQRtn,pcr		get our D.FIRQ routine
         stx   <D.FIRQ			and put it in system global vector
         lda   >PIA.U8+3
         anda  #$FC
         ora   #$01
         sta   >PIA.U8+3
         lda   >PIA.U8+2
         puls  cc
         lda   #$03
         sta   >MPI.Slct
         clrb
L0085    rts

L0086    orcc  #IntMasks
         lda   ,x
         lda   ,x
         lda   $01,x
         ldb   $01,x
         ldb   >PIA.U8+2
         ldb   $01,x
         bmi   L00FB
         lda   #$02
         sta   <u0022,u
         clra
         andb  #$60
         std   <u0023,u
         clrb
         std   <u001D,u
         std   <u0020,u
         sta   <u001F,u
         std   <u0025,u
         andcc #^IntMasks
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
L00B2    bsr   L00FF
Read     lda   <u0023,u
         ble   L00CC
         ldb   <u001F,u
         cmpb  #$0A
         bhi   L00CC
         ldb   V.XON,u
         orb   #$80
         stb   <u0023,u
         ldb   #$05
         lbsr  L037D
L00CC    tst   <u0025,u
         bne   L00FB
         ldb   <u001E,u
         leax  <u002E,u
         orcc  #IntMasks
         cmpb  <u001D,u
         beq   L00B2
         abx
         lda   ,x
         dec   <u001F,u
         incb
         cmpb  #$4F
         bls   L00EA
         clrb
L00EA    stb   <u001E,u
         ldb   V.ERR,u
         beq   L015E
         stb   <PD.ERR,y
         clr   V.ERR,u
         comb
         ldb   #E$Read
         bra   L015F
L00FB    comb
         ldb   #E$NotRdy
         rts
L00FF    pshs  x,b,a
         lda   V.BUSY,u
         sta   V.WAKE,u
         andcc #^IntMasks
         ldx   #$0000
         os9   F$Sleep
         ldx   <D.Proc
         ldb   <P$Signal,x
         beq   L0118
         cmpb  #S$Intrpt
         bls   L012E
L0118    clra
         lda   P$State,x
         bita  #Condem
         bne   L012E
         ldb   #E$HangUp
         lda   V.ERR,u
         bita  #$20
         bne   L0129
         puls  pc,x,b,a
L0129    inc   <PD.PST,y
         clr   V.ERR,u
L012E    leas  $06,s
         coma
         rts

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
L0132    bsr   L00FF
Write    leax  <u007E,u
         ldb   <u0020,u
         abx
         sta   ,x
         incb
         cmpb  #$81
         bls   L0143
         clrb
L0143    orcc  #IntMasks
         cmpb  <u0021,u
         beq   L0132
         stb   <u0020,u
         lda   <u0022,u
         beq   L015E
         anda  #$FD
         sta   <u0022,u
         bne   L015E
         ldb   #$05
         lbsr  L037D
L015E    clrb
L015F    andcc #^IntMasks
         rts

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
GetStat  ldx   PD.RGS,y
         cmpa  #SS.Ready
         bne   L0171
         ldb   <u001F,u
         beq   L00FB
         stb   R$B,x
L016F    clrb
         rts
L0171    cmpa  #SS.EOF
         beq   L016F
         cmpa  #SS.ScSiz
         beq   L0184
         cmpa  #SS.ComSt
         bne   L0191
         ldd   <u0028,u
         std   R$Y,x
         bra   L016F
L0184    clra
         ldb   <u002A,u
         std   R$X,x
         ldb   <u002B,u
         std   R$Y,x
         bra   L016F
L0191    comb
         ldb   #E$UnkSvc
         rts   

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
SetStat  ldx   PD.RGS,y
         cmpa  #SS.SSig
         bne   L01B2
         lda   PD.CPR,y
         ldb   R$X+1,x
         orcc  #IntMasks
         tst   <u001F,u
         bne   L01AB
         std   <u0025,u
         bra   L015E
L01AB    andcc #^IntMasks
         os9   F$Send
         clrb
         rts
L01B2    cmpa  #SS.Open
         beq   L01FA
         cmpa  #SS.Close
         beq   L020A
         cmpa  #SS.Relea
         bne   L01C9
         lda   PD.CPR,y
         cmpa  <u0025,u
         bne   L016F
         clr   <u0025,u
         rts
L01C9    cmpa  #SS.ComSt
         bne   L0191
         ldd   R$Y,x
L01CF    std   <u0028,u
         andb  #$E0
         pshs  b
         ldb   <u0029,u
         andb  #$07
         leax  <L01F2,pcr
         ldb   b,x
         orb   ,s+
         anda  #$E0
         sta   V.TYPE,u
         ldx   V.PORT,u
         lda   $02,x
         anda  #$1F
         ora   V.TYPE,u
         std   $02,x
         bra   L0227
L01F2    fdb   $1316,$1718,$1a1c,$1e1f
L01FA    ldb   #$09
         lda   R$Y+1,x
         cmpa  #$01
         bne   L0227
         orcc  #IntMasks
         lbsr  L037D
         lbra  L0086
L020A    lda   R$Y+1,x
         bne   L0227
         ldb   #$0B
         lda   <u0028,u
         bita  #$10
         beq   L0218
L0217    clrb
L0218    pshs  b
         bsr   L022C
         bcs   L0217
         puls  b
         orcc  #IntMasks
         lbsr  L037D
         andcc #^IntMasks
L0227    clrb
         rts

L0229    lbsr  L00FF
L022C    ldb   <u0020,u
         orcc  #IntMasks
         cmpb  <u0021,u
         bne   L0229
         rts

* Term
*
* Entry:
*    U  = address of device memory area
*
* Exit:
*    CC = carry set on error
*    B  = error code
*
Term     ldx   <D.Proc
         lda   P$ID,x
         sta   V.BUSY,u
         sta   V.LPRC,u
         bsr   L0217
         ldd   <orgDFIRQ,u		get saved D.FIRQ vector
         std   <D.FIRQ			and put it back in system global
         ldx   #$0000
         os9   F$IRQ    		deinstall IRQ svc routine
         clrb
         rts

* ISR
L024E    ldb   >PIA.U8+2
         ldx   V.PORT,u
         sta   <u0027,u
         tfr   a,b
         andb  #$60
         cmpb  <u0024,u
         beq   L0299
         tfr   b,a
         eorb  <u0024,u
         sta   <u0024,u
         lda   <u0027,u
         bitb  #$20
         beq   L028C
         bita  #$20
         beq   L028C
         lda   <u0028,u
         bita  #$10
         beq   L02EC
         ldx   <V.PDLHd,u
         beq   L0286
L027E    inc   <PD.PST,x
         ldx   <PD.PLP,x
         bne   L027E
L0286    lda   #$20
         bsr   L02F6
         bra   L02E1
L028C    bitb  #$40
         beq   L02EC
         bita  #$40
         lbne  L03AF
         lbra  L039E
L0299    bita  #$08
         bne   L02FB
         bita  #$10
         beq   L02EC
         lda   <u0023,u
         bpl   L02B6
         anda  #$7F
         sta   ,x
         eora  V.XON,u
         sta   <u0023,u
         lda   <u0022,u
         bne   L02DC
         bra   L02EC
L02B6    leay  <u007E,u
         ldb   <u0021,u
         cmpb  <u0020,u
         beq   L02D4
         clra
         lda   d,y
         incb
         cmpb  #$81
         bls   L02CA
         clrb
L02CA    stb   <u0021,u
         sta   ,x
         cmpb  <u0020,u
         bne   L02E1
L02D4    lda   <u0022,u
         ora   #$02
         sta   <u0022,u
L02DC    ldb   #$09
         lbsr  L037F
L02E1    ldb   #$01
         lda   V.WAKE,u
L02E5    beq   L02EC
         clr   V.WAKE,u
L02E9    os9   F$Send   
L02EC    ldx   V.PORT,u
         lda   $01,x
         lbmi  L024E
         clrb  
         rts   
L02F6    ora   V.ERR,u
         sta   V.ERR,u
         rts   
L02FB    bita  #$07
         beq   L030F
         tfr   a,b
         tst   ,x
         anda  #$07
         bsr   L02F6
         lda   $02,x
         sta   $01,x
         sta   $02,x
         bra   L02EC
L030F    lda   ,x
         beq   L032A
         cmpa  V.INTR,u
         beq   L038D
         cmpa  V.QUIT,u
         beq   L0391
         cmpa  V.PCHR,u
         beq   L0385
         cmpa  V.XON,u
         beq   L039E
         cmpa  <V.XOFF,u
         lbeq  L03AF
L032A    leax  <u002E,u
         ldb   <u001D,u
         abx   
         sta   ,x
         incb  
         cmpb  #$4F
         bls   L0339
         clrb  
L0339    cmpb  <u001E,u
         bne   L0344
         lda   #$04
         bsr   L02F6
         bra   L02E1
L0344    stb   <u001D,u
         inc   <u001F,u
         tst   <u0025,u
         beq   L0357
         ldd   <u0025,u
         clr   <u0025,u
         bra   L02E9
L0357    lda   <V.XOFF,u
         beq   L02E1
         ldb   <u001F,u
         cmpb  #$46
         lbcs  L02E1
         ldb   <u0023,u
         lbne  L02E1
         anda  #$7F
         sta   <V.XOFF,u
         ora   #$80
         sta   <u0023,u
         ldb   #$05
         bsr   L037D
         lbra  L02E1
L037D    ldx   V.PORT,u
L037F    orb   V.TYPE,u
         stb   $02,x
         clrb  
         rts   
L0385    ldx   V.DEV2,u
         beq   L032A
         sta   V.PAUS,x
         bra   L032A
L038D    ldb   #S$Intrpt
         bra   L0393
L0391    ldb   #S$Abort
L0393    pshs  a
         lda   V.LPRC,u
         lbsr  L02E5
         puls  a
         bra   L032A
L039E    lda   <u0022,u
         anda  #$FE
         sta   <u0022,u
         bne   L03AC
         ldb   #$05
         bsr   L037F
L03AC    lbra  L02EC
L03AF    lda   <u0022,u
         bne   L03B8
         ldb   #$09
         bsr   L037F
L03B8    ora   #$01
         sta   <u0022,u
         bra   L03AC

	 emod
eom      equ   *
         end

