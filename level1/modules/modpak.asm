********************************************************************
* MODPAK - DC Modem Pak device driver
*
* $Id$
*
* Ed.    Comments                                       Who YY/MM/DD
* ------------------------------------------------------------------
* 10     Tandy/Microware original version

         nam   MODPAK
         ttl   DC Modem Pak device driver

* Disassembled 98/08/23 17:41:18 by Disasm v1.6 (C) 1988 by RML

         ifp1
         use   defsfile
         use   scfdefs
         endc

tylg     set   Drivr+Objct   
atrv     set   ReEnt+rev
rev      set   $01
edition  set   $0A

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
u002C    rmb   5
u0031    rmb   26
u004B    rmb   53
u0080    rmb   1
u0081    rmb   45
u00AE    rmb   82
size     equ   .
         fcb   $03 

name     fcs   /MODPAK/
         fcb   edition

start    lbra  Init
         lbra  Read
         lbra  Write
         lbra  GetStat
         lbra  SetStat
         lbra  Term

IRQPckt  fcb   $00,$80,$0a

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
         ldd   <IT.PAR,y		get parity/baud
         lbsr  L01A9
         ldd   V.PORT,u
         addd  #$0001
         leax  >IRQPckt,pcr
         leay  >L022C,pcr
         os9   F$IRQ    
         bcs   L0061
         leay  <u002C,u
         lda   #$80
         sta   $04,y
         ldd   #$0001
         std   $02,y
         ldx   #$0001
         os9   F$VIRQ   
         bcs   L0061
         clrb  
L0061    rts   
L0062    orcc  #IntMasks
         lda   ,x
         lda   ,x
         lda   $01,x
         ldb   $01,x
         ldb   $01,x
         bmi   L00D4
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
L008B    bsr   L00D8
Read     lda   <u0023,u
         ble   L00A5
         ldb   <u001F,u
         cmpb  #$0A
         bhi   L00A5
         ldb   V.XON,u
         orb   #$80
         stb   <u0023,u
         ldb   #$05
         lbsr  L0359
L00A5    tst   <u0025,u
         bne   L00D4
         ldb   <u001E,u
         leax  <u0031,u
         orcc  #IntMasks
         cmpb  <u001D,u
         beq   L008B
         abx   
         lda   ,x
         dec   <u001F,u
         incb  
         cmpb  #$4F
         bls   L00C3
         clrb  
L00C3    stb   <u001E,u
         ldb   V.ERR,u
         beq   L0138
         stb   <$3A,y
         clr   V.ERR,u
         comb  
         ldb   #E$Read
         bra   L0139
L00D4    comb  
         ldb   #E$NotRdy
         rts   
L00D8    pshs  x,b,a
         lda   V.BUSY,u
         sta   V.WAKE,u
         andcc #^IntMasks
         ldx   #$0000
         os9   F$Sleep  
         ldx   <D.Proc
         ldb   <P$Signal,x
         beq   L00F1
         cmpb  #S$Intrpt
         bls   L0107
L00F1    clra  
         lda   P$State,x
         bita  #Condem
         bne   L0107
         ldb   #$DC
         lda   V.ERR,u
         bita  #TimOut
         bne   L0102
         puls  pc,x,b,a
L0102    inc   <$3F,y
         clr   V.ERR,u
L0107    leas  $06,s
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
L010B    bsr   L00D8
Write    leax  >u0081,u
         ldb   <u0020,u
         abx   
         sta   ,x
         incb  
         cmpb  #$7E
         bls   L011D
         clrb  
L011D    orcc  #IntMasks
         cmpb  <u0021,u
         beq   L010B
         stb   <u0020,u
         lda   <u0022,u
         beq   L0138
         anda  #$FD
         sta   <u0022,u
         bne   L0138
         ldb   #$05
         lbsr  L0359
L0138    clrb  
L0139    andcc #^IntMasks
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
GetStat  ldx   $06,y
         cmpa  #$01
         bne   L014B
         ldb   <u001F,u
         beq   L00D4
         stb   $02,x
L0149    clrb  
         rts   
L014B    cmpa  #$06
         beq   L0149
         cmpa  #$26
         beq   L015E
         cmpa  #$28
         bne   L016B
         ldd   <u0028,u
         std   $06,x
         bra   L0149
L015E    clra  
         ldb   <u002A,u
         std   $04,x
         ldb   <u002B,u
         std   $06,x
         bra   L0149
L016B    comb  
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
SetStat  ldx   $06,y
         cmpa  #$1A
         bne   L018C
         lda   $05,y
         ldb   $05,x
         orcc  #IntMasks
         tst   <u001F,u
         bne   L0185
         std   <u0025,u
         bra   L0138
L0185    andcc #^IntMasks
         os9   F$Send   
         clrb  
         rts   
L018C    cmpa  #$29
         beq   L01D4
         cmpa  #$2A
         beq   L01E4
         cmpa  #$1B
         bne   L01A3
         lda   $05,y
         cmpa  <u0025,u
         bne   L0149
         clr   <u0025,u
         rts   
L01A3    cmpa  #$28
         bne   L016B
         ldd   $06,x
L01A9    std   <u0028,u
         andb  #$E0
         pshs  b
         ldb   <u0029,u
         andb  #$07
         leax  <L01CC,pcr
         ldb   b,x
         orb   ,s+
         anda  #$E0
         sta   V.TYPE,u
         ldx   V.PORT,u
         lda   $02,x
         anda  #$1F
         ora   V.TYPE,u
         std   $02,x
         bra   L0201
L01CC    fcb   $13,$16,$17,$18,$1a,$1c,$1e,$1f
L01D4    ldb   #$09
         lda   $07,x
         cmpa  #$01
         bne   L0201
         orcc  #IntMasks
         lbsr  L0359
         lbra  L0062
L01E4    lda   $07,x
         bne   L0201
         ldb   #$0B
         lda   <u0028,u
         bita  #$10
         beq   L01F2
L01F1    clrb  
L01F2    pshs  b
         bsr   L0206
         bcs   L01F1
         puls  b
         orcc  #IntMasks
         lbsr  L0359
         andcc #^IntMasks
L0201    clrb  
         rts   
L0203    lbsr  L00D8
L0206    ldb   <u0020,u
         orcc  #IntMasks
         cmpb  <u0021,u
         bne   L0203
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
         bsr   L01F1
         ldx   #$0000
         leay  <u002C,u
         os9   F$VIRQ   
         ldx   #$0000
         os9   F$IRQ    
         clrb  
         rts   
L022C    ldx   V.PORT,u
         sta   <u0027,u
         tfr   a,b
         andb  #$60
         cmpb  <u0024,u
         beq   L0274
         tfr   b,a
         eorb  <u0024,u
         sta   <u0024,u
         lda   <u0027,u
         bitb  #$20
         beq   L0267
         bita  #$20
         beq   L0267
         lda   <u0028,u
         bita  #$10
         beq   L02C8
         ldx   <V.PDLHd,u
         beq   L0261
L0259    inc   <$3F,x
         ldx   <$3D,x
         bne   L0259
L0261    lda   #$20
         bsr   L02D2
         bra   L02BD
L0267    bitb  #$40
         beq   L02C8
         bita  #$40
         lbne  L038B
         lbra  L037A
L0274    bita  #$08
         bne   L02D7
         bita  #$10
         beq   L02C8
         lda   <u0023,u
         bpl   L0291
         anda  #$7F
         sta   ,x
         eora  V.XON,u
         sta   <u0023,u
         lda   <u0022,u
         bne   L02B8
         bra   L02C8
L0291    leay  >u0081,u
         ldb   <u0021,u
         cmpb  <u0020,u
         beq   L02B0
         clra  
         lda   d,y
         incb  
         cmpb  #$7E
         bls   L02A6
         clrb  
L02A6    stb   <u0021,u
         sta   ,x
         cmpb  <u0020,u
         bne   L02BD
L02B0    lda   <u0022,u
         ora   #$02
         sta   <u0022,u
L02B8    ldb   #$09
         lbsr  L035B
L02BD    ldb   #$01
         lda   V.WAKE,u
L02C1    beq   L02C8
         clr   V.WAKE,u
L02C5    os9   F$Send   
L02C8    ldx   V.PORT,u
         lda   $01,x
         lbmi  L022C
         clrb  
         rts   
L02D2    ora   V.ERR,u
         sta   V.ERR,u
         rts   
L02D7    bita  #$07
         beq   L02EB
         tfr   a,b
         tst   ,x
         anda  #$07
         bsr   L02D2
         lda   $02,x
         sta   $01,x
         sta   $02,x
         bra   L02C8
L02EB    lda   ,x
         beq   L0306
         cmpa  V.INTR,u
         beq   L0369
         cmpa  V.QUIT,u
         beq   L036D
         cmpa  V.PCHR,u
         beq   L0361
         cmpa  V.XON,u
         beq   L037A
         cmpa  <V.XOFF,u
         lbeq  L038B
L0306    leax  <u0031,u
         ldb   <u001D,u
         abx   
         sta   ,x
         incb  
         cmpb  #$4F
         bls   L0315
         clrb  
L0315    cmpb  <u001E,u
         bne   L0320
         lda   #$04
         bsr   L02D2
         bra   L02BD
L0320    stb   <u001D,u
         inc   <u001F,u
         tst   <u0025,u
         beq   L0333
         ldd   <u0025,u
         clr   <u0025,u
         bra   L02C5
L0333    lda   <V.XOFF,u
         beq   L02BD
         ldb   <u001F,u
         cmpb  #$46
         lbcs  L02BD
         ldb   <u0023,u
         lbne  L02BD
         anda  #$7F
         sta   <V.XOFF,u
         ora   #$80
         sta   <u0023,u
         ldb   #$05
         bsr   L0359
         lbra  L02BD
L0359    ldx   V.PORT,u
L035B    orb   V.TYPE,u
         stb   $02,x
         clrb  
         rts   
L0361    ldx   V.DEV2,u
         beq   L0306
         sta   $08,x
         bra   L0306
L0369    ldb   #$03
         bra   L036F
L036D    ldb   #$02
L036F    pshs  a
         lda   V.LPRC,u
         lbsr  L02C1
         puls  a
         bra   L0306
L037A    lda   <u0022,u
         anda  #$FE
         sta   <u0022,u
         bne   L0388
         ldb   #$05
         bsr   L035B
L0388    lbra  L02C8
L038B    lda   <u0022,u
         bne   L0394
         ldb   #$09
         bsr   L035B
L0394    ora   #$01
         sta   <u0022,u
         bra   L0388

         emod
eom      equ   *
         end

