********************************************************************
* Format - Initialize disk media
*
* $Id$
*
* Ed.    Comments                                       Who YY/MM/DD
* ------------------------------------------------------------------
* 18     Original Microware distribution version

         nam   Format
         ttl   Initialize disk media

* Disassembled 02/04/03 22:47:09 by Disasm v1.6 (C) 1988 by RML

         ifp1
         use   /dd/defs/os9defs
         endc
tylg     set   Prgrm+Objct   
atrv     set   ReEnt+rev
rev      set   $01
         mod   eom,name,tylg,atrv,start,size
u0000    rmb   1
u0001    rmb   1
u0002    rmb   1
u0003    rmb   1
u0004    rmb   1
u0005    rmb   2
u0007    rmb   1
u0008    rmb   1
u0009    rmb   1
u000A    rmb   1
u000B    rmb   1
u000C    rmb   2
u000E    rmb   1
u000F    rmb   1
u0010    rmb   1
u0011    rmb   1
u0012    rmb   1
u0013    rmb   2
u0015    rmb   1
u0016    rmb   1
u0017    rmb   1
u0018    rmb   1
u0019    rmb   1
u001A    rmb   1
u001B    rmb   1
u001C    rmb   1
u001D    rmb   2
u001F    rmb   1
u0020    rmb   2
u0022    rmb   1
u0023    rmb   1
u0024    rmb   1
u0025    rmb   1
u0026    rmb   1
u0027    rmb   1
u0028    rmb   1
u0029    rmb   1
u002A    rmb   1
u002B    rmb   1
u002C    rmb   1
u002D    rmb   2
u002F    rmb   1
u0030    rmb   1
u0031    rmb   1
u0032    rmb   1
u0033    rmb   1
u0034    rmb   2
u0036    rmb   2
u0038    rmb   2
u003A    rmb   1
u003B    rmb   2
u003D    rmb   2
u003F    rmb   4
u0043    rmb   1
u0044    rmb   2
u0046    rmb   1
u0047    rmb   1
u0048    rmb   13
u0055    rmb   15
u0064    rmb   3
u0067    rmb   32
u0087    rmb   40
u00AF    rmb   14
u00BD    rmb   12
u00C9    rmb   5
u00CE    rmb   9
u00D7    rmb   17
u00E8    rmb   6
u00EE    rmb   177
u019F    rmb   2
u01A1    rmb   2
u01A3    rmb   12
u01AF    rmb   256
u02AF    rmb   3
u02B2    rmb   9924
u2976    rmb   451
size     equ   .
name     equ   *
         fcs   /Format/
         fcb   $12 
L0014    fcb   $00 
         fcb   $00 
L0016    fcb   $00 
         fcb   $00 
L0018    fcb   $00 
         fcb   $00 
L001A    fcb   $80 
         fcb   $E5 e
         fcb   $80 
         fcb   $E5 e
         fcb   $00 
         fcb   $00 
L0020    fcb   $01 
         fcb   $00 
         fcb   $28 (
         fcb   $FF 
         fcb   $06 
         fcb   $00 
         fcb   $01 
         fcb   $FC 
         fcb   $0C 
         fcb   $FF 
         fcb   $00 
         fcb   $00 
         fcb   $06 
         fcb   $00 
         fcb   $01 
         fcb   $FE 
         fcb   $04 
         fcb   $00 
         fcb   $01 
         fcb   $F7 w
         fcb   $0A 
         fcb   $FF 
         fcb   $06 
         fcb   $00 
         fcb   $01 
         fcb   $FB 
         fcb   $80 
         fcb   $E5 e
         fcb   $80 
         fcb   $E5 e
         fcb   $01 
         fcb   $F7 w
         fcb   $0A 
         fcb   $FF 
         fcb   $00 
         fcb   $00 
         fcb   $FF 
         fcb   $00 
         fcb   $43 C
         fcb   $01 
         fcb   $28 (
L0049    fcb   $50 P
         fcb   $4E N
         fcb   $0C 
         fcb   $00 
         fcb   $03 
         fcb   $F6 v
         fcb   $01 
         fcb   $FC 
         fcb   $20 
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
         fcb   $16 
         fcb   $4E N
         fcb   $00 
         fcb   $00 
         fcb   $4E N
         fcb   $00 
         fcb   $90 
         fcb   $01 
         fcb   $52 R
L0076    fcb   $20 
         fcb   $4E N
         fcb   $00 
         fcb   $00 
         fcb   $08 
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
         fcb   $2C ,
         fcb   $01 
         fcb   $50 P
start    equ   *
         stu   <u0000
         bsr   L00BE
         bsr   L00CF
         bsr   L011A
         lbsr  L0295
         lbsr  L0351
         lbsr  L04A9
         lbsr  L0589
         lbsr  L05BF
         lbsr  L07C0
         ldu   <u0044
         os9   I$Detach 
         clrb  
L00BB    os9   F$Exit   
L00BE    leay  u0002,u
         pshs  y
         leay  >u00AF,u
L00C6    clr   ,-y
         cmpy  ,s
         bhi   L00C6
         puls  pc,y
L00CF    lda   ,x+
         cmpa  #$2F
         beq   L00DA
L00D5    ldb   #$D7
         lbra  L08E4
L00DA    os9   F$PrsNam 
         lbcs  L08E4
         lda   #$2F
         cmpa  ,y
         beq   L00D5
         sty   <u0020
         leay  <u0047,u
L00ED    sta   ,y+
         lda   ,x+
         decb  
         bpl   L00ED
         leax  <u0048,u
         lda   #$20
         sta   ,y
         clra  
         os9   I$Attach 
         lbcs  L08E4
         stu   <u0044
         ldu   <u0000
         lda   #$40
         ldb   #$20
         std   ,y
         lda   #$02
         leax  <u0047,u
         os9   I$Open   
         bcs   L00BB
         sta   <u0002
         rts   
L011A    bsr   L0122
         bsr   L015D
         lbsr  L0216
         rts   
L0122    leax  >u01AF,u
         clrb  
         os9   I$GetStt 
         bcs   L00BB
         ldb   $07,x
         stb   <u0012
         ldb   $04,x
         pshs  b
         andb  #$01
         stb   <u0010
         puls  b
         lsrb  
         andb  #$01
         stb   <u0011
         ldd   $05,x
         std   <u0013
         ldb   $03,x
         stb   <u001B
         andb  #$20
         stb   <u0046
         ldd   $09,x
         std   <u0017
         ldd   $0B,x
         std   <u0019
         ldb   $0D,x
         stb   <u001F
         ldb   #$01
         stb   <u0025
         clrb  
         rts   
L015D    ldx   <u0020
L015F    leay  >L0188,pcr
         bsr   L0176
         bcs   L017F
         pshs  b,a
         ldd   $02,y
         leay  d,y
         puls  b,a
         jsr   ,y
         bcc   L015F
         lbra  L00BB
L0176    lda   ,x+
L0178    cmpa  ,y
         bne   L0180
         ldb   $01,y
         clra  
L017F    rts   
L0180    leay  $04,y
         tst   ,y
         bne   L0178
         coma  
         rts   
L0188    fcb   $52 R
         rolb  
         neg   <u002C
         aim   #$59,>$0028
         bhi   L0192
L0192    neg   <u002D
         abx   
         neg   <u0000
         tstb  
         coma  
         neg   <u0000
         bhi   L0200
         neg   <u0000
         exg   y,a
         neg   <u0000
         sync  
         bvs   L01A6
L01A6    neg   <u000F
         bge   L01AA
L01AA    neg   <u000B
         bra   L01AE
L01AE    neg   <u0007
         neg   <u00D7
         pulsw 
         stb   <u001C
         rts   
         stb   <u0012
         rts   
         inc   <u0046
         rts   
         leay  <u0067,u
         ldb   #$20
L01C2    lda   ,x+
         cmpa  #$22
         beq   L01D9
         sta   ,y+
         decb  
         bne   L01C2
L01CD    ldb   ,x+
         cmpb  #$22
         beq   L01DF
         cmpb  #$20
         bcc   L01CD
         bra   L01DF
L01D9    lda   #$20
         cmpb  #$20
         beq   L01E3
L01DF    leay  -$01,y
         lda   ,y
L01E3    adda  #$80
         sta   ,y
         clrb  
         rts   
         lbsr  L08AF
         ldd   <u001D
         std   <u0013
         rts   
         lbsr  L08AF
         ldd   <u001D
         tsta  
         beq   L01FB
         ldb   #$01
L01FB    stb   <u001F
L01FD    rts   
         lbsr  L08AF
         ldd   <u001D
         tsta  
         beq   L0208
         ldb   #$01
L0208    stb   <u0025
         negb  
         decb  
         andb  <u0025
         beq   L0214
         ldb   #$01
         stb   <u0025
L0214    clrb  
         rts   
L0216    leax  >L08F9,pcr
         lbsr  L0272
         leay  >u01AF,u
         ldx   $0B,y
         tst   <u0010
         beq   L0229
         ldx   $09,y
L0229    stx   <u0017
         leax  >L0954,pcr
         ldy   #$0011
         lbsr  L0276
         leax  <u0047,u
         tfr   x,y
L023B    lda   ,y+
         cmpa  #$40
         bne   L023B
         pshs  y
         lda   #$0D
         sta   -$01,y
         lbsr  L0272
         puls  y
         lda   #$40
         sta   -$01,y
         lda   <u001C
         bne   L01FD
L0254    leax  >L0965,pcr
         ldy   #$001A
         lbsr  L027C
         anda  #$DF
         cmpa  #$59
         beq   L01FD
         clrb  
         cmpa  #$4E
         lbeq  L00BB
         bra   L0254
L026E    leax  >L090F,pcr
L0272    ldy   #$0050
L0276    lda   #$01
         os9   I$WritLn 
         rts   
L027C    pshs  u,y,x,b,a
         bsr   L0276
         leax  ,s
         ldy   #$0001
         clra  
         os9   I$Read   
         lbcs  L00BB
         bsr   L026E
         puls  u,y,x,b,a
         anda  #$7F
         rts   
L0295    leax  >L001A,pcr
         stx   <u000A
         ldb   <u001B
         bitb  #$C0
         bne   L02B9
         ldb   <u0046
         beq   L02AB
         leax  >L0076,pcr
         bra   L02B9
L02AB    leax  >L0020,pcr
         stx   <u000A
         tst   <u0010
         beq   L02B9
         leax  >L0049,pcr
L02B9    stx   <u000C
         clra  
         ldb   <u0012
         tfr   d,y
         clrb  
         ldx   <u0013
         bsr   L0303
         exg   d,x
         subd  #$0001
         bcc   L02CE
         leax  -$01,x
L02CE    exg   d,x
         ldy   <u0017
         bsr   L0303
         exg   d,x
         addd  <u0019
         std   <u0023
         exg   d,x
         adcb  #$00
         stb   <u0022
         lda   #$08
         pshs  a
         ldx   <u0023
         ldb   <u0022
         bsr   L034C
         lda   <u0025
         pshs  a
         bsr   L034C
         tstb  
         beq   L02FE
         leax  >L09EF,pcr
         lbsr  L0272
         lbra  L0528
L02FE    leas  $02,s
         stx   <u0026
         rts   
L0303    lda   #$08
L0305    clr   ,-s
         deca  
         bne   L0305
         sty   ,s
         stb   $02,s
         stx   $03,s
L0311    ldd   ,s
         beq   L0334
         lsra  
         rorb  
         std   ,s
         bcc   L0327
         ldd   $03,s
         addd  $06,s
         std   $06,s
         lda   $02,s
         adca  $05,s
         sta   $05,s
L0327    ldd   $03,s
         lslb  
         rola  
         std   $03,s
         lda   $02,s
         rola  
         sta   $02,s
         bra   L0311
L0334    leas  $05,s
         puls  pc,x,b
L0338    pshs  x,b
         lsr   ,s
         ror   $01,s
         ror   $02,s
         puls  x,b
         exg   d,x
         adcb  #$00
         adca  #$00
         exg   d,x
         adcb  #$00
L034C    lsr   $02,s
         bne   L0338
         rts   
L0351    tst   <u001B
         bpl   L036B
         leax  >L0A58,pcr
         ldy   #$0022
         lbsr  L027C
         anda  #$DF
         cmpa  #$59
         beq   L036B
         cmpa  #$4E
         bne   L0351
         rts   
L036B    lda   <u0002
         ldb   #$03
         os9   I$SetStt 
         lbcs  L00BB
         ldd   #$0000
         std   <u0003
         inca  
         sta   <u0007
L037E    clr   <u0005
L0380    bsr   L03DA
         leax  >u00AF,u
         ldu   <u0003
         clrb  
         tst   <u0010
         beq   L039B
         tst   <u0046
         bne   L0399
         tst   <u0004
         bne   L0399
         tst   <u0005
         beq   L039B
L0399    orb   #$02
L039B    tst   <u0011
         beq   L03A1
         orb   #$04
L03A1    lda   <u0005
         beq   L03A7
         orb   #$01
L03A7    tfr   d,y
         lda   <u0002
         ldb   #$04
         os9   I$SetStt 
         lbcs  L00BB
         ldu   <u0000
         ldb   <u0005
         incb  
         stb   <u0005
         cmpb  <u0012
         bcs   L0380
         ldd   <u0003
         addd  #$0001
         std   <u0003
         cmpd  <u0013
         bcs   L037E
         rts   
L03CC    ldy   <u000E
L03CF    ldd   ,y++
         beq   L03E9
L03D3    stb   ,x+
         deca  
         bne   L03D3
         bra   L03CF
L03DA    lda   <u001B
         bita  #$C0
         beq   L03EA
         ldy   <u000C
         leax  >u00AF,u
         bsr   L03CF
L03E9    rts   
L03EA    ldy   <u000C
         ldb   <u0018
         tst   <u0046
         bne   L0400
         tst   <u0004
         bne   L0400
         tst   <u0005
         bne   L0400
         ldy   <u000A
         ldb   <u001A
L0400    sty   <u000E
         stb   <u0009
         stb   <u0016
         bsr   L0466
         leax  >u00AF,u
         bsr   L03CF
         sty   <u000E
L0412    bsr   L03CC
         dec   <u0009
         bne   L0412
         lda   ,y+
         sty   <u000E
         stx   <u003B
         leay  >u2976,u
         sty   <u001D
         tfr   a,b
L0428    std   ,x++
         cmpx  <u001D
         bcs   L0428
         ldy   <u000E
         ldd   ,y++
         std   <u003D
         ldd   ,y
         std   <u003F
         clr   <u0009
         leax  >u00AF,u
         ldd   <u003D
         leay  >u0087,u
L0445    leax  d,x
         ldd   <u0004
         std   ,x
         ldb   <u0009
         lda   b,y
         incb  
         stb   <u0009
         ldb   <u0007
         tst   <u0046
         beq   L0459
         inca  
L0459    std   $02,x
         lda   <u0009
         cmpa  <u0016
         bcc   L0465
         ldd   <u003F
         bra   L0445
L0465    rts   
L0466    pshs  y,b
         tfr   b,a
         ldb   <u0004
         cmpb  #$01
         bhi   L0492
         leax  >u0087,u
         leay  a,x
         ldb   <u001F
         bne   L0481
L047A    leax  >L097F,pcr
         lbra  L0676
L0481    cmpb  <u0016
         bhi   L047A
         nega  
         pshs  y,x,b,a
         clra  
L0489    sta   ,x
         inca  
         cmpa  <u0016
         bne   L0494
         leas  $06,s
L0492    puls  pc,y,b
L0494    ldb   <u001F
         abx   
         cmpx  $04,s
         bcs   L049F
         ldb   ,s
         leax  b,x
L049F    cmpx  $02,s
         bne   L0489
         leax  $01,x
         stx   $02,s
         bra   L0489
L04A9    lbsr  L081B
         ldd   <u0023
         std   $01,x
         ldb   <u0022
         stb   ,x
         ldd   <u0017
         std   <$11,x
         stb   $03,x
         lda   <u0025
         sta   $07,x
         clra  
         ldb   <u0026
         tst   <u0027
         beq   L04C9
         addd  #$0001
L04C9    addd  #$0001
         addd  #$0010
         std   $09,x
         clra  
         tst   <u0010
         beq   L04D8
         ora   #$02
L04D8    ldb   <u0012
         cmpb  #$01
         beq   L04E0
         ora   #$01
L04E0    tst   <u0011
         beq   L04E6
         ora   #$04
L04E6    sta   <$10,x
         ldd   <u0026
         std   $04,x
         lda   #$FF
         sta   $0D,x
         leax  >u00C9,u
         os9   F$Time   
         leax  >u00CE,u
         leay  <u0067,u
         tst   ,y
         beq   L050B
L0503    lda   ,y+
         sta   ,x+
         bpl   L0503
         bra   L053E
L050B    leax  >L09A3,pcr
         ldy   #$000B
         lbsr  L0276
         leax  >u00CE,u
         ldy   #$0021
         clra  
         os9   I$ReadLn 
         bcc   L052F
         cmpa  #$D3
         bne   L050B
L0528    leax  >L09E0,pcr
         lbra  L0676
L052F    tfr   y,d
         leax  d,x
         clr   ,-x
         decb  
         beq   L050B
         lda   ,-x
         ora   #$80
         sta   ,x
L053E    leax  >u00C9,u
         leay  <$40,x
         pshs  y
         ldd   #$0000
L054A    addd  ,x++
         cmpx  ,s
         bcs   L054A
         leas  $02,s
         std   >u00BD,u
         ldd   >L0014,pcr
         std   >u019F,u
         ldd   >L0016,pcr
         std   >u01A1,u
         ldd   >L0018,pcr
         std   >u01A3,u
         lda   <u0002
         ldb   #$00
         leax  >u00EE,u
         os9   I$GetStt 
         ldb   #$03
         os9   I$SetStt 
         lbcs  L00BB
         leax  >u00AF,u
         lbra  L0827
L0589    lda   <u0002
         os9   I$Close  
         leax  <u0047,u
         lda   #$01
         os9   I$Open   
         lbcs  L0672
         sta   <u0002
         leax  >u00AF,u
         ldy   #$0100
         os9   I$Read   
         lbcs  L0672
         lda   <u0002
         os9   I$Close  
         leax  <u0047,u
         lda   #$03
         os9   I$Open   
         lbcs  L0672
         sta   <u0002
         rts   
L05BF    lda   <u001B
         clr   <u0043
         bita  #$80
         beq   L05DE
L05C7    leax  >L0A7A,pcr
         ldy   #$0019
         lbsr  L027C
         anda  #$DF
         cmpa  #$59
         beq   L05DE
         cmpa  #$4E
         bne   L05C7
         sta   <u0043
L05DE    ldd   <u0019
         std   <u0015
         clra  
         clrb  
         std   <u0034
         std   <u0003
         std   <u0008
         std   <u0030
         stb   <u002F
         sta   <u003A
         leax  >u01AF,u
         stx   <u0036
         lbsr  L081F
         leax  >$0100,x
         stx   <u0038
         clra  
         ldb   #$01
         std   <u0032
         lda   <u0025
         sta   <u0029
         clr   <u0028
         clra  
         ldb   <u0026
         tst   <u0027
         beq   L0614
         addd  #$0001
L0614    addd  #$0009
         addd  #$0010
         std   <u002B
         lda   <u0025
L061E    lsra  
         bcs   L062F
         lsr   <u002B
         ror   <u002C
         bcc   L061E
         inc   <u002C
         bne   L061E
         inc   <u002B
         bra   L061E
L062F    ldb   <u002C
         stb   <u002D
         lda   <u0025
         mul   
         std   <u002B
         subd  #$0001
         subb  <u0026
         sbca  #$00
         subd  #$0010
         tst   <u0027
         beq   L0649
         subd  #$0001
L0649    stb   <u002A
L064B    tst   <u0043
         bne   L067D
         lda   <u0002
         leax  >u00AF,u
         ldy   #$0100
         os9   I$Read   
         bcc   L067D
         os9   F$PErr   
         lbsr  L084B
         lda   #$FF
         sta   <u0028
         tst   <u002F
         bne   L067D
         ldx   <u0030
         cmpx  <u002B
         bhi   L067D
L0672    leax  >L09CD,pcr
L0676    lbsr  L0272
         clrb  
         lbra  L00BB
L067D    ldd   <u0008
         addd  #$0001
         std   <u0008
         cmpd  <u0015
         bcs   L06C2
         clr   <u0008
         clr   <u0009
         tst   <u0043
         bne   L06B7
         lda   #$20
         pshs  a
         lda   <u0004
         lbsr  L0724
         pshs  b,a
         lda   <u0003
         lbsr  L0724
         pshs  b
         tfr   s,x
         ldy   #$0004
         lbsr  L0276
         lda   $02,s
         cmpa  #$46
         bne   L06B5
         lbsr  L026E
L06B5    leas  $04,s
L06B7    ldd   <u0003
         addd  #$0001
         std   <u0003
         ldd   <u0017
         std   <u0015
L06C2    dec   <u0029
         bne   L06D8
         bsr   L0701
         tst   <u0028
         bne   L06D2
         ldx   <u0034
         leax  $01,x
         stx   <u0034
L06D2    clr   <u0028
         lda   <u0025
         sta   <u0029
L06D8    ldb   <u002F
         ldx   <u0030
         leax  $01,x
         bne   L06E1
         incb  
L06E1    cmpb  <u0022
         bcs   L06E9
         cmpx  <u0023
         bcc   L06F0
L06E9    stb   <u002F
         stx   <u0030
         lbra  L064B
L06F0    lda   #$FF
         sta   <u0028
         leay  >u01AF,u
L06F8    cmpy  <u0036
         beq   L073C
         bsr   L0701
         bra   L06F8
L0701    ldx   <u0036
         lda   <u0028
         rora  
         rol   ,x+
         inc   <u003A
         lda   <u003A
         cmpa  #$08
         bcs   L0723
         clr   <u003A
         stx   <u0036
         cmpx  <u0038
         bne   L0723
         bsr   L0780
         leax  >u01AF,u
         stx   <u0036
         lbsr  L081F
L0723    rts   
L0724    tfr   a,b
         lsra  
         lsra  
         lsra  
         lsra  
         andb  #$0F
         addd  #$3030
         cmpa  #$39
         bls   L0735
         adda  #$07
L0735    cmpb  #$39
         bls   L073B
         addb  #$07
L073B    rts   
L073C    lbsr  L026E
         leax  >L0A3F,pcr
         ldy   #$0019
         lbsr  L0276
         ldb   <u0025
         clra  
         ldx   <u0034
         pshs  x,a
L0751    lsrb  
         bcs   L075C
         lsl   $02,s
         rol   $01,s
         rol   ,s
         bra   L0751
L075C    puls  x,a
         ldb   #$0D
         pshs  b
         tfr   d,y
         tfr   x,d
         tfr   b,a
         bsr   L0724
         pshs  b,a
         tfr   x,d
         bsr   L0724
         pshs  b,a
         tfr   y,d
         bsr   L0724
         pshs  b,a
         tfr   s,x
         lbsr  L0272
         leas  $07,s
         rts   
L0780    pshs  y
         clra  
         ldb   #$01
         cmpd  <u0032
         bne   L079B
         leax  >u01AF,u
         clra  
         ldb   <u002D
         tfr   d,y
         clrb  
         os9   F$AllBit 
         lbcs  L0672
L079B    lbsr  L0835
         leax  >u01AF,u
         lbsr  L0827
         ldd   <u0022
         cmpd  <u002F
         bcs   L07B7
         bhi   L07B4
         ldb   <u0024
         cmpb  <u0031
         bcc   L07B7
L07B4    lbsr  L084B
L07B7    ldd   <u0032
         addd  #$0001
         std   <u0032
         puls  pc,y
L07C0    ldd   #$0010
         addd  <u0032
         std   <u0032
         bsr   L0835
         leax  >u02AF,u
         bsr   L081F
         leax  >u02B2,u
         os9   F$Time   
         leax  >u02AF,u
         lda   #$BF
         sta   ,x
         lda   #$02
         sta   $08,x
         clra  
         ldb   #$40
         std   $0B,x
         ldb   <u002A
         decb  
         stb   <$14,x
         ldd   <u0032
         addd  #$0001
         std   <$11,x
         bsr   L0827
         bsr   L081B
         ldd   #$2EAE
         std   ,x
         stb   <$20,x
         ldd   <u0032
         std   <$1E,x
         std   <$3E,x
         bsr   L0827
         bsr   L081B
         ldb   <u002A
L080F    decb  
         bne   L0813
         rts   
L0813    pshs  b
         bsr   L0827
         puls  b
         bra   L080F
L081B    leax  >u00AF,u
L081F    clra  
         clrb  
L0821    sta   d,x
         decb  
         bne   L0821
         rts   
L0827    lda   <u0002
         ldy   #$0100
         os9   I$Write  
         lbcs  L00BB
         rts   
L0835    clra  
         ldb   <u0032
         tfr   d,x
         lda   <u0033
         clrb  
         tfr   d,u
L083F    lda   <u0002
         os9   I$Seek   
         ldu   <u0000
         lbcs  L00BB
         rts   
L084B    ldx   <u002F
         lda   <u0031
         clrb  
         addd  #$0100
         tfr   d,u
         bcc   L083F
         leax  $01,x
         bra   L083F
         ldd   ,y
         leau  >u00AF,u
         leax  >L08A3,pcr
         ldy   #$2F20
L0869    leay  >$0100,y
         subd  ,x
         bcc   L0869
         addd  ,x++
         pshs  b,a
         ldd   ,x
         tfr   y,d
         beq   L0891
         ldy   #$2F30
         cmpd  #$3020
         bne   L088B
         ldy   #$2F20
         tfr   b,a
L088B    sta   ,u+
         puls  b,a
         bra   L0869
L0891    sta   ,u+
         lda   #$0D
         sta   ,u
         ldu   <u0000
         leas  $02,s
         leax  >u00AF,u
         lbsr  L0272
         rts   
L08A3    beq   L08B5
         com   <u00E8
         neg   <u0064
         neg   <u000A
         neg   <u0001
         neg   <u0000
L08AF    ldd   #$0000
L08B2    bsr   L08C2
         bcs   L08BC
         bne   L08B2
         std   <u001D
         bne   L08C1
L08BC    ldd   #$0001
         std   <u001D
L08C1    rts   
L08C2    pshs  y,b,a
         ldb   ,x+
         subb  #$30
         cmpb  #$0A
         bcc   L08E0
         lda   #$00
         ldy   #$000A
L08D2    addd  ,s
         bcs   L08DE
         leay  -$01,y
         bne   L08D2
         std   ,s
         andcc #$FB
L08DE    puls  pc,y,b,a
L08E0    orcc  #$04
         puls  pc,y,b,a
L08E4    lda   #$02
         os9   F$PErr   
         leax  <L0910,pcr
         ldy   #$0154
         lda   #$02
         os9   I$WritLn 
         clrb  
         os9   F$Exit   
L08F9    dec   <u0044
         fcb   $52 R
         fcb   $41 A
         asra  
         clra  
         fcb   $4E N
         bra   L0948
         clra  
         fcb   $52 R
         tsta  
         fcb   $41 A
         lsrb  
         bra   L095E
         lsrb  
         rola  
         inca  
         rola  
         lsrb  
         rolb  
L090F    tst   <u0055
         com   >$653A
         bra   L095C
         clra  
         fcb   $52 R
         tsta  
         fcb   $41 A
         lsrb  
         bra   L094C
         lsr   $05,s
         ror   >$6E61
         tst   $05,s
         bra   L0962
         clr   -$10,s
         lsr   >$733E
         dec   <u0020
         bra   L099E
         neg   >$7473
         abx   
         bra   L0987
         bra   L0957
         blt   L0959
         fcb   $52 R
         eim   #$61,$04,s
         rol   >$0A20
         bra   L0962
         bra   L0964
         bra   L0966
         bra   L096A
L0948    lsr   $09,s
         com   >$6B20
         jmp   $01,s
         tst   $05,s
         bhi   L095D
         tst   <u0046
         clr   -$0E,s
L0957    tst   $01,s
L0959    lsr   >$7469
L095C    jmp   $07,s
L095E    bra   L09C4
         aim   #$69,>$7665
L0964    bra   L09DF
L0966    bra   L0990
         rol   >$6573
         bvs   L098D
         clr   -$0E,s
         bra   L09DF
         bra   L099B
         jmp   $0F,s
         bvs   L0981
         fcb   $52 R
         eim   #$61,$04,s
         rol   >$3F20
         bra   L09C1
         fcb   $42 B
L0981    clra  
         fcb   $52 R
         lsrb  
         bra   L09CF
         jmp   -$0C,s
         eim   #$72,$0C,s
         eim   #$61,-$0A,s
         eim   #$20,-$0A,s
         oim   #$6C,-$0B,s
         eim   #$20,$0F,s
         eim   #$74,>$206F
L099B    ror   $00,y
         aim   #$61,>$6E67
         eim   #u000D,$04,u
         rol   -$0D,s
         tim   #$20,$0E,s
         oim   #$6D,$05,s
         abx   
         bra   L09F7
         clr   -$09,s
         bra   L0A20
         oim   #$6E,-$07,s
         bra   L09FB
         rol   >$6C69
         jmp   $04,s
         eim   #$72,-$0D,s
         bra   L09EA
         lsrb  
         aim   #$61,>$636B
         com   >$3F29
         bra   L0A06
         bra   L0A10
         oim   #$64,$00,y
         com   >$7973
         lsr   >$656D
         bra   L0A4C
         eim   #$63,-$0C,s
         clr   -$0E,s
         bge   L0A00
L09E0    rora  
         clra  
         fcb   $52 R
         tsta  
         fcb   $41 A
         lsrb  
         bra   L0A29
         fcb   $42 B
         clra  
L09EA    fcb   $52 R
         lsrb  
         fcb   $45 E
         lsra  
         tst   <u0043
         inc   -$0B,s
         com   >$7465
         aim   #$20,>$7369
         dec   >$6520
         tst   $09,s
         com   >$6D61
         lsr   >$6368
         tst   <u0044
L0A06    clr   -$0B,s
         aim   #$6C,$05,s
         bra   L0A71
         eim   #$6E,-$0D,s
L0A10    rol   -$0C,s
         rol   >$3F20
         coma  
         lsl   $01,s
         jmp   $07,s
         eim   #$20,$06,s
         aim   #$6F,>$6D20
         rts   
         pshu  u,y,x,b
         neg   >$6920
         lsr   >$6F20
         pshs  y,x,dp
         lsr   >$7069
         swi   
         fcb   $20 
         lsra  
         clr   -$0B,s
         aim   #$6C,$05,s
         bra   L0AAC
         rol   $04,s
         eim   #$64,-$01,y
         bra   L0A8E
         eim   #$6D,>$6265
         aim   #$20,>$6F66
         bra   L0AB1
         clr   $0F,s
L0A4C    lsr   $00,y
         com   >$6563
         lsr   >$6F72
         com   >$3A20
         bcc   L0A9B
         clr   -$0C,s
         lsl   $00,y
         negb  
         lsla  
         rolb  
         comb  
         rola  
         coma  
         fcb   $41 A
         inca  
         bra   L0AC8
         jmp   $04,s
         bra   L0AB7
         clra  
         asra  
         rola  
         coma  
         fcb   $41 A
         inca  
L0A71    bra   L0AD9
         clr   -$0E,s
         tst   $01,s
         lsr   >$3F20
L0A7A    negb  
         lsl   -$07,s
         com   >$6963
         oim   #$6C,$00,y
         rorb  
         eim   #$72,$09,s
         ror   -$07,s
         bra   L0AEF
         eim   #$73,$09,s
L0A8E    aim   #$65,>$643F
         fcb   $20 
         emod
eom      equ   *
