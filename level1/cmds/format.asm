********************************************************************
* Format - Disk format program
*
* $Id$
*
* Ed.    Comments                                       Who YY/MM/DD
* ------------------------------------------------------------------
*  22    From Tandy OS-9 Level Two Vr. 2.00.01

         nam   Format
         ttl   Disk format program

* Disassembled 02/07/17 11:00:13 by Disasm v1.6 (C) 1988 by RML

         ifp1
         use   defsfile
         use   rbfdefs
         endc

tylg     set   Prgrm+Objct   
atrv     set   ReEnt+rev
rev      set   $01
edition  set   $16

         mod   eom,name,tylg,atrv,start,size

SavedU   rmb   2
DiskPath rmb   1
CurrTrak rmb   2
u0005    rmb   2
CurrSct  rmb   1
u0008    rmb   1
u0009    rmb   1
u000A    rmb   2
u000C    rmb   2
u000E    rmb   2
MFM      rmb   1
u0011    rmb   1
T4896    rmb   1
u0013    rmb   1
u0014    rmb   1
NCyls    rmb   2
u0017    rmb   1
u0018    rmb   1
Sectors  rmb   1
u001A    rmb   1
Sectors0 rmb   1
u001C    rmb   1
DType    rmb   1
u001E    rmb   1
u001F    rmb   1
u0020    rmb   1
Interlv  rmb   1
u0022    rmb   2
u0024    rmb   1
u0025    rmb   1
u0026    rmb   1
u0027    rmb   1
u0028    rmb   1
u0029    rmb   1
u002A    rmb   1
u002B    rmb   1
u002C    rmb   1
u002D    rmb   1
u002E    rmb   1
u002F    rmb   1
u0030    rmb   1
u0031    rmb   1
u0032    rmb   1
u0033    rmb   1
u0034    rmb   1
u0035    rmb   1
u0036    rmb   2
u0038    rmb   2
u003A    rmb   2
u003C    rmb   1
u003D    rmb   2
u003F    rmb   2
u0041    rmb   2
u0043    rmb   1
u0044    rmb   1
u0045    rmb   1
DTEntry  rmb   2
u0048    rmb   1
STOff    rmb   2
u004B    rmb   1
u004C    rmb   1
u004D    rmb   1
u004E    rmb   1
u004F    rmb   1
u0050    rmb   5
u0055    rmb   15
u0064    rmb   7
u006B    rmb   4
u006F    rmb   32
u008F    rmb   40
u00B7    rmb   14
u00C5    rmb   12
TimePkt  rmb   5
u00D6    rmb   18
u00E8    rmb   14
u00F6    rmb   177
u01A7    rmb   2
u01A9    rmb   2
u01AB    rmb   12
OptBuf   rmb   256
u02B7    rmb   3
u02BA    rmb   9924
u297E    rmb   451
size     equ   .

name     fcs   /Format/
         fcb   edition

L0014    fdb   $0000
L0016    fdb   $0000
L0018    fdb   $0000
L001A    fdb   $80E5
         fdb   $80E5
         fdb   $0000
L0020    fdb   $0100 
         fdb   $28FF
         fdb   $0600 
         fdb   $01FC 
         fdb   $0CFF 
         fdb   $0000 
         fdb   $0600
         fdb   $01FE 
         fdb   $0400 
         fdb   $01F7
         fdb   $0AFF 
         fdb   $0600
         fdb   $01FB
         fdb   $80E5
         fdb   $80E5
         fdb   $01F7
         fdb   $0AFF
         fdb   $0000
         fcb   $Ff
         fdb   $0043
         fdb   $0128
L0049    fdb   $504E
         fdb   $0C00
         fdb   $03F6
         fdb   $01Fc
         fdb   $204E
         fdb   $0000
         fdb   $0C00
         fdb   $03F5
         fdb   $01FE
         fdb   $0400
         fdb   $01F7
         fdb   $164E
         fdb   $0C00 
         fdb   $03F5
         fdb   $01FB 
         fdb   $80E5
         fdb   $80E5
         fdb   $01F7
         fdb   $164E
         fdb   $0000
         fcb   $4E
         fcb   $00 
         fcb   $90 
         fcb   $01 
         fcb   $52 R
L0076    fcb   $20 
         fcb   $4E N
         fcb   $00 
         fcb   $00 
         fcb   $0C 
         fcb   $00 
         fcb   $03 
         fcb   $F5 u
         fcb   $01 
         fcb   $FE 
         fcb   $04 
         fcb   $00 
         fcb   $01 
         fcb   $F7 w
         fcb   $16 
         fcb   $4E N
         fcb   $0C 
         fcb   $00 
         fcb   $03 
         fcb   $F5 u
         fcb   $01 
         fcb   $FB 
         fcb   $80 
         fcb   $E5 e
         fcb   $80 
         fcb   $E5 e
         fcb   $01 
         fcb   $F7 w
         fcb   $18 
         fcb   $4E N
         fcb   $00 
         fcb   $00 
         fcb   $4E N
         fcb   $00 
         fcb   $30 0
         fcb   $01 
         fcb   $54 T

start    stu   <SavedU
         bsr   ClrWork		cleark work area
         bsr   OpenDev		get device name and open it
         bsr   L011A
         lbsr  GetDTyp
         lbsr  L03C7
         lbsr  L052F
         lbsr  L0612
         lbsr  L0648
         lbsr  L0843
         ldu   <DTEntry
         os9   I$Detach 
         clrb  
L00BB    os9   F$Exit   
ClrWork  leay  DiskPath,u
         pshs  y
         leay  >u00B7,u
L00C6    clr   ,-y
         cmpy  ,s
         bhi   L00C6
         puls  pc,y

OpenDev  lda   ,x+
         cmpa  #PDELIM
         beq   L00DA
L00D5    ldb   #E$BPNam
         lbra  L0961
L00DA    os9   F$PrsNam 
         lbcs  L0961
         lda   #PDELIM
         cmpa  ,y
         beq   L00D5
         sty   <u0022
         leay  <u004F,u
L00ED    sta   ,y+
         lda   ,x+
         decb  
         bpl   L00ED
         leax  <u0050,u
         lda   #C$SPAC
         sta   ,y
         clra  
         os9   I$Attach 
         lbcs  L0961
         stu   <DTEntry
         ldu   <SavedU
         lda   #PENTIR
         ldb   #C$SPAC
         std   ,y
         lda   #WRITE.
         leax  <u004F,u
         os9   I$Open   
         bcs   L00BB
         sta   <DiskPath
         rts   

L011A    bsr   GetOpts
         bsr   L0183
         lbsr  L025E
         rts   

GetOpts  leax  >OptBuf,u
         clrb  
         os9   I$GetStt 
         bcs   L00BB
         ldb   PD.SID-PD.OPT,x
         stb   <u0013
         stb   <u0014
         ldb   PD.SToff-PD.OPT,x
         beq   L0143
         tfr   b,a
         anda  #$0F
         sta   <STOff
         lsrb  
         lsrb  
         lsrb  
         lsrb  
         stb   <u004B
L0143    ldb   PD.DNS-PD.OPT,x
         pshs  b
         andb  #DNS.MFM
         stb   <MFM
         stb   <u0011
         ldb   ,s
         lsrb  
         pshs  b
         andb  #$01     (PD.DTD)
         stb   <T4896
         puls  b
         lsrb  
         andb  <u0011
         stb   <u004C
         puls  b
         ldb   #$01
         stb   <u004D
         beq   L0169
         stb   <u004B
         clr   <STOff
L0169    ldd   PD.CYL-PD.OPT,x
         std   <NCyls
         ldb   PD.TYP-PD.OPT,x
         stb   <DType
         ldd   PD.SCT-PD.OPT,x
         std   <Sectors
         ldd   PD.T0S-PD.OPT,x
         std   <Sectors0
         ldb   PD.ILV-PD.OPT,x
         stb   <Interlv
         ldb   #$01
         stb   <u0027
         clrb  
         rts   
L0183    ldx   <u0022
L0185    leay  >OptTbl,pcr
         bsr   L019C
         bcs   L01A5
         pshs  b,a
         ldd   $02,y
         leay  d,y
         puls  b,a
         jsr   ,y
         bcc   L0185
         lbra  L00BB
L019C    lda   ,x+
L019E    cmpa  ,y
         bne   L01A6
         ldb   $01,y
         clra  
L01A5    rts   
L01A6    leay  $04,y
         tst   ,y
         bne   L019E
         coma  
         rts   

OptTbl
opt.1    fcc   /R/
         fcc   /Y/
         fdb   DoReady-opt.1
opt.2    fcc   /r/
         fcc   /Y/
         fdb   DoReady-opt.2
opt.3    fcc   /"/
         fcb   $00
         fdb   DoQuote-opt.3
opt.4    fcc   /:/
         fcb   $00
         fdb   DoColon-opt.4
opt.5    fcc   /1/
         fcb   $01
         fdb   Do1-opt.5
opt.6    fcc   /2/
         fcb   $02
         fdb   Do2-opt.6
opt.7    fcc   /'/
         fcb   0
         fdb   DoSQuote-opt.7
opt.8    fcc   /L/
         fcb   $01
         fdb   DoL-opt.8
opt.9    fcc   /l/
         fcb   01
         fdb   DoL-opt.9
opt.10   fcc   /(/
         fcb   $00
         fdb   DoLParen-opt.10
opt.11   fcc   /)/
         fcb   $00
         fdb   DoRParen-opt.11
opt.12   fcc   /,/
         fcb   $00
         fdb   DoComa-opt.12
opt.13   fcb   C$SPAC
         fcb   00
         fdb   DoSpace-opt.13

         fcb   $00

         cmpb  <u0011
         bgt   L01FE
         cmpb  <u004C
         blt   L01FE
         stb   <MFM
         clrb

DoComa
DoRParen
DoLParen
DoSpace  rts

DoReady  stb   <u001E
         rts

Do2
Do1      cmpb  <u0013
         bgt   L01FE
         stb   <u0013
         clrb
         rts

DoL      stb   <u004E
         clrb
         rts

L01FE    leax  >AbortOp,pcr
         lbra  L06F9

DoQuote  leay  <u006F,u
         ldb   #C$SPAC
L020A
koQuote  lda   ,x+
         cmpa  #'"
         beq   L0221
         sta   ,y+
         decb  
         bne   L020A
L0215    ldb   ,x+
         cmpb  #'"
         beq   L0227
         cmpb  #C$SPAC
         bcc   L0215
         bra   L0227
L0221    lda   #C$SPAC
         cmpb  #C$SPAC
         beq   L022B
L0227    leay  -$01,y
         lda   ,y
L022B    adda  #$80
         sta   ,y
         clrb  
         rts   

DoSQuote lbsr  L092C
         ldd   <u001F
         std   <NCyls
         rts   

DoColon  lbsr  L092C
         ldd   <u001F
         tsta  
         beq   L0243
         ldb   #$01
L0243    stb   <Interlv
         rts   
         lbsr  L092C
         ldd   <u001F
         tsta  
         beq   L0250
         ldb   #$01
L0250    stb   <u0027
         negb  
         decb  
         andb  <u0027
         beq   L025C
         ldb   #$01
         stb   <u0027
L025C    clrb  
L025D    rts   
L025E    leax  >Title,pcr
         lbsr  L02E2
         leay  >OptBuf,u
         ldx   PD.T0S-PD.OPT,y
         tst   <MFM
         beq   L0271
         ldx   PD.SCT-PD.OPT,y
L0271    stx   <Sectors
         leax  >FmtMsg,pcr
         ldy   #FmtMLen
         lbsr  L02E6
         leax  <u004F,u
         tfr   x,y
L0283    lda   ,y+
         cmpa  #PENTIR
         bne   L0283
         pshs  y
         lda   #C$CR
         sta   -$01,y
         lbsr  L02E2
         puls  y
         lda   #PENTIR
         sta   -$01,y
         lda   <u001E
         bne   L02BC
         tst   <DType
         bpl   L02AB
         leax  >HDFmt,pcr
         ldy   #$002A
         lbsr  L02E6
L02AB    leax  >Query,pcr
         ldy   #QueryLen
         lbsr  L02EC
         anda  #$DF
         cmpa  #'Y
         bne   L02D5
L02BC    tst   <DType
         bpl   L025D
         leax  >HDFmt,pcr
         ldy   #$0038
         lbsr  L02EC
         anda  #$DF
         cmpa  #'Y
         beq   L025D
         clrb  
         lbra  L00BB
L02D5    clrb  
         cmpa  #'N
         lbeq  L00BB
         bra   L02AB
L02DE    leax  >HelpCR,pcr
L02E2    ldy   #80
L02E6    lda   #$01
         os9   I$WritLn 
         rts   
L02EC    pshs  u,y,x,b,a
         bsr   L02E6
         leax  ,s
         ldy   #$0001
         clra  
         os9   I$Read   
         lbcs  L00BB
         bsr   L02DE
         puls  u,y,x,b,a
         anda  #$7F
         rts   

GetDTyp  leax  >L001A,pcr
         stx   <u000A
         ldb   <DType
         bitb  #TYP.HARD+TYP.NSF
         bne   L0323
         tst   <u004D
         beq   L031B
         leax  >L0076,pcr
         bra   L032D
L031B    leax  >L0020,pcr
         tst   <MFM
         beq   L032D
L0323    stx   <u000A
         leax  >L0049,pcr
         tst   <u004C
         beq   L032F
L032D    stx   <u000A
L032F    stx   <u000C
         clra  
         ldb   <u0013
         tfr   d,y
         clrb  
         ldx   <NCyls
         bsr   L0379
         exg   d,x
         subd  #$0001
         bcc   L0344
         leax  -$01,x
L0344    exg   d,x
         ldy   <Sectors
         bsr   L0379
         exg   d,x
         addd  <Sectors0
         std   <u0025
         exg   d,x
         adcb  #$00
         stb   <u0024
         lda   #$08
         pshs  a
         ldx   <u0025
         ldb   <u0024
         bsr   L03C2
         lda   <u0027
         pshs  a
         bsr   L03C2
         tstb  
         beq   L0374
         leax  >ClustMsg,pcr
         lbsr  L02E2
         lbra  L05B1
L0374    leas  $02,s
         stx   <u0028
         rts   
L0379    lda   #$08
L037B    clr   ,-s
         deca  
         bne   L037B
         sty   ,s
         stb   $02,s
         stx   $03,s
L0387    ldd   ,s
         beq   L03AA
         lsra  
         rorb  
         std   ,s
         bcc   L039D
         ldd   $03,s
         addd  $06,s
         std   $06,s
         lda   $02,s
         adca  $05,s
         sta   $05,s
L039D    ldd   $03,s
         lslb  
         rola  
         std   $03,s
         lda   $02,s
         rola  
         sta   $02,s
         bra   L0387
L03AA    leas  $05,s
         puls  pc,x,b
L03AE    pshs  x,b
         lsr   ,s
         ror   $01,s
         ror   $02,s
         puls  x,b
         exg   d,x
         adcb  #$00
         adca  #$00
         exg   d,x
         adcb  #$00
L03C2    lsr   $02,s
         bne   L03AE
         rts   
L03C7    tst   <u004E
         bne   L03E4
         tst   <DType
         bpl   L03E5
         leax  >Both,pcr
         ldy   #BothLen
         lbsr  L02EC
         anda  #$DF
         cmpa  #'Y
         beq   L03E5
         cmpa  #'N
         bne   L03C7
L03E4    rts   
L03E5    lda   <DiskPath
         ldb   #SS.Reset
         os9   I$SetStt 
         lbcs  L00BB
         ldd   #$0000
         std   <CurrTrak
         inca  
         sta   <CurrSct
L03F8    clr   <u0005
L03FA    bsr   L045C
         leax  >u00B7,u
         ldd   <CurrTrak
         addd  <u0048
         tfr   d,u
         clrb  
         tst   <u004D
         bne   L041B
         tst   <MFM
         beq   L041D
         tst   <u004C
         bne   L041B
         tst   <CurrTrak+1
         bne   L041B
         tst   <u0005
         beq   L041D
L041B    orb   #$02
L041D    tst   <T4896
         beq   L0423
         orb   #$04
L0423    lda   <u0005
         beq   L0429
         orb   #$01
L0429    tfr   d,y
         lda   <DiskPath
         ldb   #SS.WTrk
         os9   I$SetStt 
         lbcs  L00BB
         ldu   <SavedU
         ldb   <u0005
         incb  
         stb   <u0005
         cmpb  <u0013
         bcs   L03FA
         ldd   <CurrTrak
         addd  #$0001
         std   <CurrTrak
         cmpd  <NCyls
         bcs   L03F8
         rts   
L044E    ldy   <u000E
L0451    ldd   ,y++
         beq   L046B
L0455    stb   ,x+
         deca  
         bne   L0455
         bra   L0451
L045C    lda   <DType
         bita  #$C0
         beq   L046C
         ldy   <u000C
         leax  >u00B7,u
         bsr   L0451
L046B    rts   
L046C    ldy   <u000C
         ldb   <u001A
         tst   <CurrTrak+1
         bne   L047E
         tst   <u0005
         bne   L047E
         ldy   <u000A
         ldb   <u001C
L047E    sty   <u000E
         stb   <u0009
         stb   <u0018
         bsr   L04EC
         leax  >u00B7,u
         bsr   L0451
         sty   <u000E
L0490    bsr   L044E
         dec   <u0009
         bne   L0490
         lda   ,y+
         sty   <u000E
         stx   <u003D
         leay  >u297E,u
         sty   <u001F
         tfr   a,b
L04A6    std   ,x++
         cmpx  <u001F
         bcs   L04A6
         ldy   <u000E
         ldd   ,y++
         std   <u003F
         ldd   ,y
         std   <u0041
         clr   <u0009
         leax  >u00B7,u
         ldd   <u003F
         leay  >u008F,u
L04C3    leax  d,x
         ldd   <CurrTrak+1
         adda  <STOff
         std   ,x
         ldb   <u0009
         lda   b,y
         incb  
         stb   <u0009
         ldb   <CurrSct
         adda  <u004B
         bcs   L04E5
         std   $02,x
         lda   <u0009
         cmpa  <u0018
         bcc   L04E4
         ldd   <u0041
         bra   L04C3
L04E4    rts   
L04E5    leax  >AbortSct,pcr
         lbra  L06F9
L04EC    pshs  y,b
         tfr   b,a
         ldb   <CurrTrak+1
         cmpb  #$01
         bhi   L0518
         leax  >u008F,u
         leay  a,x
         ldb   <Interlv
         bne   L0507
L0500    leax  >AbortIlv,pcr
         lbra  L06F9
L0507    cmpb  <u0018
         bhi   L0500
         nega  
         pshs  y,x,b,a
         clra  
L050F    sta   ,x
         inca  
         cmpa  <u0018
         bne   L051A
         leas  $06,s
L0518    puls  pc,y,b
L051A    ldb   <Interlv
         abx   
         cmpx  $04,s
         bcs   L0525
         ldb   ,s
         leax  b,x
L0525    cmpx  $02,s
         bne   L050F
         leax  $01,x
         stx   $02,s
         bra   L050F
L052F    lbsr  L0898
         ldd   <u0025
         std   $01,x
         ldb   <u0024
         stb   ,x
         ldd   <Sectors
         std   <$11,x
         stb   $03,x
         lda   <u0027
         sta   $07,x
         clra  
         ldb   <u0028
         tst   <u0029
         beq   L054F
         addd  #$0001
L054F    addd  #$0001
         std   $09,x
         clra  
         tst   <MFM
         beq   L0561
         ora   #$02
         tst   <u004C
         beq   L0561
         ora   #$08
L0561    ldb   <u0013
         cmpb  #$01
         beq   L0569
         ora   #$01
L0569    tst   <T4896
         beq   L056F
         ora   #$04
L056F    sta   <$10,x
         ldd   <u0028
         std   $04,x
         lda   #$FF
         sta   $0D,x
         leax  >TimePkt,u
         os9   F$Time   
         leax  >u00D6,u
         leay  <u006F,u
         tst   ,y
         beq   L0594
L058C    lda   ,y+
         sta   ,x+
         bpl   L058C
         bra   L05C7
L0594    leax  >DName,pcr
         ldy   #DNameLen
         lbsr  L02E6
         leax  >u00D6,u
         ldy   #$0021
         clra  
         os9   I$ReadLn 
         bcc   L05B8
         cmpa  #E$EOF
         bne   L0594
L05B1    leax  >Aborted,pcr
         lbra  L06F9
L05B8    tfr   y,d
         leax  d,x
         clr   ,-x
         decb  
         beq   L0594
         lda   ,-x
         ora   #$80
         sta   ,x
L05C7    leax  >TimePkt,u
         leay  <$40,x
         pshs  y
         ldd   #$0000
L05D3    addd  ,x++
         cmpx  ,s
         bcs   L05D3
         leas  $02,s
         std   >u00C5,u
         ldd   >L0014,pcr
         std   >u01A7,u
         ldd   >L0016,pcr
         std   >u01A9,u
         ldd   >L0018,pcr
         std   >u01AB,u
         lda   <DiskPath
         ldb   #SS.Opt
         leax  >u00F6,u
         os9   I$GetStt 
         ldb   #SS.Reset
         os9   I$SetStt 
         lbcs  L00BB
         leax  >u00B7,u
         lbra  L08A4
L0612    lda   <DiskPath
         os9   I$Close  
         leax  <u004F,u
         lda   #READ.
         os9   I$Open   
         lbcs  L06F5
         sta   <DiskPath
         leax  >u00B7,u
         ldy   #256
         os9   I$Read   
         lbcs  L06F5
         lda   <DiskPath
         os9   I$Close  
         leax  <u004F,u
         lda   #UPDAT.
         os9   I$Open   
         lbcs  L06F5
         sta   <DiskPath
         rts   
L0648    lda   <DType
         clr   <u0045
         bita  #$80
         beq   L0667
L0650    leax  >Verify,pcr
         ldy   #VerifyL
         lbsr  L02EC
         anda  #$DF
         cmpa  #$59
         beq   L0667
         cmpa  #$4E
         bne   L0650
         sta   <u0045
L0667    ldd   <Sectors0
         std   <u0017
         clra  
         clrb  
         std   <u0036
         std   <CurrTrak
         std   <u0008
         std   <u0032
         stb   <u0031
         sta   <u003C
         leax  >OptBuf,u
         stx   <u0038
         lbsr  L089C
         leax  >$0100,x
         stx   <u003A
         clra  
         ldb   #$01
         std   <u0034
         lda   <u0027
         sta   <u002B
         clr   <u002A
         clra  
         ldb   <u0028
         tst   <u0029
         beq   L069D
         addd  #$0001
L069D    addd  #$0009
         std   <u002D
         lda   <u0027
L06A4    lsra  
         bcs   L06B5
         lsr   <u002D
         ror   <u002E
         bcc   L06A4
         inc   <u002E
         bne   L06A4
         inc   <u002D
         bra   L06A4
L06B5    ldb   <u002E
         stb   <u002F
         lda   <u0027
         mul   
         std   <u002D
         subd  #$0001
         subb  <u0028
         sbca  #$00
         tst   <u0029
         beq   L06CC
         subd  #$0001
L06CC    stb   <u002C
L06CE    tst   <u0045
         bne   L0700
         lda   <DiskPath
         leax  >u00B7,u
         ldy   #256
         os9   I$Read   
         bcc   L0700
         os9   F$PErr   
         lbsr  L08C8
         lda   #$FF
         sta   <u002A
         tst   <u0031
         bne   L0700
         ldx   <u0032
         cmpx  <u002D
         bhi   L0700
L06F5    leax  >BadSect,pcr
L06F9    lbsr  L02E2
         clrb  
         lbra  L00BB
L0700    ldd   <u0008
         addd  #$0001
         std   <u0008
         cmpd  <u0017
         bcs   L0745
         clr   <u0008
         clr   <u0009
         tst   <u0045
         bne   L073A
         lda   #$20
         pshs  a
         lda   <CurrTrak+1
         lbsr  L07A7
         pshs  b,a
         lda   <CurrTrak
         lbsr  L07A7
         pshs  b
         tfr   s,x
         ldy   #$0004
         lbsr  L02E6
         lda   $02,s
         cmpa  #$46
         bne   L0738
         lbsr  L02DE
L0738    leas  $04,s
L073A    ldd   <CurrTrak
         addd  #$0001
         std   <CurrTrak
         ldd   <Sectors
         std   <u0017
L0745    dec   <u002B
         bne   L075B
         bsr   L0784
         tst   <u002A
         bne   L0755
         ldx   <u0036
         leax  $01,x
         stx   <u0036
L0755    clr   <u002A
         lda   <u0027
         sta   <u002B
L075B    ldb   <u0031
         ldx   <u0032
         leax  $01,x
         bne   L0764
         incb  
L0764    cmpb  <u0024
         bcs   L076C
         cmpx  <u0025
         bcc   L0773
L076C    stb   <u0031
         stx   <u0032
         lbra  L06CE
L0773    lda   #$FF
         sta   <u002A
         leay  >OptBuf,u
L077B    cmpy  <u0038
         beq   L07BF
         bsr   L0784
         bra   L077B
L0784    ldx   <u0038
         lda   <u002A
         rora  
         rol   ,x+
         inc   <u003C
         lda   <u003C
         cmpa  #$08
         bcs   L07A6
         clr   <u003C
         stx   <u0038
         cmpx  <u003A
         bne   L07A6
         bsr   L0803
         leax  >OptBuf,u
         stx   <u0038
         lbsr  L089C
L07A6    rts   
L07A7    tfr   a,b
         lsra  
         lsra  
         lsra  
         lsra  
         andb  #$0F
         addd  #$3030
         cmpa  #$39
         bls   L07B8
         adda  #$07
L07B8    cmpb  #$39
         bls   L07BE
         addb  #$07
L07BE    rts   
L07BF    lbsr  L02DE
         leax  >NumGood,pcr
         ldy   #NumGoodLen
         lbsr  L02E6
         ldb   <u0027
         clra  
         ldx   <u0036
         pshs  x,a
L07D4    lsrb  
         bcs   L07DF
         lsl   $02,s
         rol   $01,s
         rol   ,s
         bra   L07D4
L07DF    puls  x,a
         ldb   #$0D
         pshs  b
         tfr   d,y
         tfr   x,d
         tfr   b,a
         bsr   L07A7
         pshs  b,a
         tfr   x,d
         bsr   L07A7
         pshs  b,a
         tfr   y,d
         bsr   L07A7
         pshs  b,a
         tfr   s,x
         lbsr  L02E2
         leas  $07,s
         rts   
L0803    pshs  y
         clra  
         ldb   #$01
         cmpd  <u0034
         bne   L081E
         leax  >OptBuf,u
         clra  
         ldb   <u002F
         tfr   d,y
         clrb  
         os9   F$AllBit 
         lbcs  L06F5
L081E    lbsr  L08B2
         leax  >OptBuf,u
         lbsr  L08A4
         ldd   <u0024
         cmpd  <u0031
         bcs   L083A
         bhi   L0837
         ldb   <u0026
         cmpb  <u0033
         bcc   L083A
L0837    lbsr  L08C8
L083A    ldd   <u0034
         addd  #$0001
         std   <u0034
         puls  pc,y
L0843    bsr   L08B2
         leax  >u02B7,u
         bsr   L089C
         leax  >u02BA,u
         os9   F$Time   
         leax  >u02B7,u
         lda   #$BF
         sta   ,x
         lda   #$02
         sta   $08,x
         clra  
         ldb   #$40
         std   $0B,x
         ldb   <u002C
         decb  
         stb   <$14,x
         ldd   <u0034
         addd  #$0001
         std   <$11,x
         bsr   L08A4
         bsr   L0898
         ldd   #$2EAE
         std   ,x
         stb   <$20,x
         ldd   <u0034
         std   <$1E,x
         std   <$3E,x
         bsr   L08A4
         bsr   L0898
         ldb   <u002C
         decb  
L088C    decb  
         bne   L0890
         rts   
L0890    pshs  b
         bsr   L08A4
         puls  b
         bra   L088C
L0898    leax  >u00B7,u
L089C    clra  
         clrb  
L089E    sta   d,x
         decb  
         bne   L089E
         rts   
L08A4    lda   <DiskPath
         ldy   #256
         os9   I$Write  
         lbcs  L00BB
         rts   
L08B2    clra  
         ldb   <u0034
         tfr   d,x
         lda   <u0035
         clrb  
         tfr   d,u
L08BC    lda   <DiskPath
         os9   I$Seek   
         ldu   <SavedU
         lbcs  L00BB
         rts   
L08C8    ldx   <u0031
         lda   <u0033
         clrb  
         addd  #$0100
         tfr   d,u
         bcc   L08BC
         leax  $01,x
         bra   L08BC
         ldd   ,y
         leau  >u00B7,u
         leax  >L0920,pcr
         ldy   #$2F20
L08E6    leay  >$0100,y
         subd  ,x
         bcc   L08E6
         addd  ,x++
         pshs  b,a
         ldd   ,x
         tfr   y,d
         beq   L090E
         ldy   #$2F30
         cmpd  #$3020
         bne   L0908
         ldy   #$2F20
         tfr   b,a
L0908    sta   ,u+
         puls  b,a
         bra   L08E6
L090E    sta   ,u+
         lda   #C$CR
         sta   ,u
         ldu   <SavedU
         leas  $02,s
         leax  >u00B7,u
         lbsr  L02E2
         rts   

L0920    fdb   $2710,$03e8,$0064,$000a,$0001,$0000

L092C    ldd   #$0000
L092F    bsr   L093F
         bcs   L0939
         bne   L092F
         std   <u001F
         bne   L093E
L0939    ldd   #$0001
         std   <u001F
L093E    rts   
L093F    pshs  y,b,a
         ldb   ,x+
         subb  #$30
         cmpb  #$0A
         bcc   L095D
         lda   #$00
         ldy   #$000A
L094F    addd  ,s
         bcs   L095B
         leay  -$01,y
         bne   L094F
         std   ,s
         andcc #^Zero
L095B    puls  pc,y,b,a
L095D    orcc  #Zero
         puls  pc,y,b,a
L0961    lda   #$02
         os9   F$PErr   
         leax  <HelpMsg,pcr
         ldy   #$0154
         lda   #$02
         os9   I$WritLn 
         clrb  
         os9   F$Exit   

Title    fcb   C$LF
         fcc   "COLOR COMPUTER FORMATTER"
HelpCR   fcb   C$CR

HelpMsg  fcc   "Use: FORMAT /devname <opts>"
         fcb   C$LF
         fcc   "  opts: R   - Ready"
         fcb   C$LF
         fcc   "        L   - Logical format only"
         fcb   C$LF
         fcc   /        "disk name"/
         fcb   C$LF
         fcc   "        1/2 - number of sides"
         fcb   C$LF
         fcc   "        'No. of cylinders'   (in decimal)"
         fcb   C$LF
         fcc   "        :Interleave value:   (in decimal)"
         fcb   C$CR
HelpLen  equ   *-HelpMsg

FmtMsg   fcc   "Formatting drive "
FmtMLen  equ   *-FmtMsg

Query    fcc   "y (yes) or n (no)"
         fcb   C$LF
         fcc   "Ready?  "
QueryLen equ   *-Query
AbortIlv fcc   "ABORT Interleave value out of range"
         fcb   C$CR
AbortSct fcc   "ABORT Sector number out of range"
         fcb   C$CR
AbortOp  fcc   "ABORT Option not allowed on Device"
         fcb   C$CR
DName    fcc   "Disk name: "
DNameLen equ   *-DName
         fcc   "How many Cylinders (Tracks?) : "
BadSect  fcc   "Bad system sector, "
Aborted   fcc   "FORMAT ABORTED"
         fcb   C$CR
ClustMsg fcc   "Cluster size mismatch"
         fcb   C$CR
         fcc   "Double density? "
         fcc   "Track 0 Double density? "
TPIChg   fcc   "Change from 96tpi to 48tpi? "
DSided   fcc   "Double sided? "
NumGood  fcc   "Number of good sectors: $"
NumGoodLen equ *-NumGood
HDFmt    fcc   "WARNING: You are formatting a HARD Disk.."
         fcb   C$LF
         fcc   "Are you sure? "
HDFmtLen equ   *-HDFmt
Both     fcc   "Both PHYSICAL and LOGICAL format? "
BothLen  equ   *-Both
Verify   fcc   "Physical Verify desired? "
VerifyL  equ   *-Verify

         emod
eom      equ   *
         end
