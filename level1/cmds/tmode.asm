********************************************************************
* Tmode - Change terminal parameters
*
* $Id$
*
* Ed.    Comments                                       Who YY/MM/DD
* ------------------------------------------------------------------
*  12    From Tandy OS-9 Level Two VR 02.00.01

         nam   Tmode
         ttl   Change terminal parameters

* Disassembled 98/09/11 18:35:13 by Disasm v1.6 (C) 1988 by RML

         ifp1
         use   defsfile
         endc

tylg     set   Prgrm+Objct   
atrv     set   ReEnt+rev
rev      set   $01
edition  set   12

         mod   eom,name,tylg,atrv,start,size

u0000    rmb   1
u0001    rmb   1
u0002    rmb   1
u0003    rmb   2
u0005    rmb   1
u0006    rmb   1
u0007    rmb   32
u0027    rmb   10
u0031    rmb   526
size     equ   .

name     fcs   /Tmode/
         fcb   edition

         fcb   $00 
         fcb   $17 
L0015    fcb   $FF 
         fcb   $01 
         fcb   $01 
         fcb   $01 
         fcs   "upc"
         fcb   $FF 
         fcb   $01 
         fcb   $02 
         fcb   $01 
         fcs   "bsb"
         fcb   $FF 
         fcb   $00 
         fcb   $03 
         fcb   $00 
         fcs   "bsl"
         fcb   $FF 
         fcb   $01 
         fcb   $04 
         fcb   $01 
         fcs   "echo"
         fcb   $FF 
         fcb   $01 
         fcb   $05 
         fcb   $01 
         fcs   "lf"
         fcb   $00 
         fcb   $00 
         fcb   $06 
         fcb   $00 
         fcs   "null"
         fcb   $FF 
         fcb   $01 
         fcb   $07 
         fcb   $01 
         fcs   "pause"
         fcb   $00 
         fcb   $18 
         fcb   $08 
         fcb   $00 
         fcs   "pag"
         fcb   $01 
         fcb   $08 
         fcb   $09 
         fcb   $00 
         fcs   "bsp"
         fcb   $01 
         fcb   $18 
         fcb   $0A 
         fcb   $00 
         fcs   "del"
         fcb   $01 
         fcb   $0D 
         fcb   $0B 
         fcb   $00 
         fcs   "eor"
         fcb   $01 
         fcb   $1B 
         fcb   $0C 
         fcb   $00 
         fcs   "eof"
         fcb   $01 
         fcb   $04 
         fcb   $0D 
         fcb   $00 
         fcs   "reprint"
         fcb   $01 
         fcb   $01 
         fcb   $0E 
         fcb   $00 
         fcs   "dup"
         fcb   $01 
         fcb   $17 
         fcb   $0F 
         fcb   $00 
         fcs   "psc"
         fcb   $01 
         fcb   $03 
         fcb   $10 
         fcb   $00 
         fcs   "abort"
         fcb   $01 
         fcb   $05 
         fcb   $11 
         fcb   $00 
         fcs   "quit"
         fcb   $01 
         fcb   $08 
         fcb   $12 
         fcb   $00 
         fcs   "bse"
         fcb   $01 
         fcb   $07 
         fcb   $13 
         fcb   $00 
         fcs   "bell"
         fcb   $01 
         fcb   $15 
         fcb   $14 
         fcb   $00 
         fcs   "type"
         fcb   $01 
         fcb   $02 
         fcb   $15 
         fcb   $00 
         fcs   "baud"
         fcb   $01 
         fcb   $11 
         fcb   $18 
         fcb   $00 
         fcs   "xon"
         fcb   $01 
         fcb   $13 
         fcb   $19 
         fcb   $00 
         fcs   "xoff"

start    lda   #$32
         sta   <u0002
         pshs  y,x,b,a
         lda   #$01
         ldb   #SS.ScSiz
         os9   I$GetStt 
         bcc   L00DB
         cmpb  #E$UnkSvc
         beq   L00E4
         puls  y,x,b,a
         bra   L0120
L00DB    cmpx  #55
         bge   L00E4
         lda   #$16
         sta   <u0002
L00E4    puls  y,x,b,a
         leay  ,x
         bsr   L0123
         clra  
         cmpb  #C$PERD
         bne   L00FB
         leay  1,y
         lda   ,y+
         suba  #$30
         cmpa  #$10
         lbcc  L0181
L00FB    sta   <u0000
         ldb   #SS.Opt
         leax  u0007,u
         os9   I$GetStt 
         bcs   L0120
         bsr   L0123
         cmpb  #C$CR
         lbeq  L01F0
L010E    bsr   L0134
         bcs   L0181
         cmpb  #C$CR
         bne   L010E
         lda   <u0000
         ldb   #SS.Opt
         os9   I$SetStt 
         bcs   L0120
         clrb  
L0120    os9   F$Exit   
L0123    ldb   ,y+
         cmpb  #C$COMA
         bne   L012B
L0129    ldb   ,y+
L012B    cmpb  #C$SPAC
         beq   L0129
         leay  -$01,y
         andcc #^Carry
         rts   
L0134    clr   <u0001
         lda   ,y
         cmpa  #'-
         bne   L0140
         inc   <u0001
         leay  $01,y
L0140    sty   <u0003
         leax  >L0015,pcr
         lbsr  L02D1
         bcs   L0181
         lda   ,x
         bpl   L015C
L0150    ldb   $01,x
L0152    lda   $02,x
         eorb  <u0001
         leax  u0007,u
         stb   a,x
         bra   L0123
L015C    tst   <u0001
         bne   L0181
         ldb   ,y
         cmpb  #'=
         bne   L0150
         leay  $01,y
         tsta  
         bne   L01AA
         clrb  
L016C    lda   ,y
         suba  #$30
         cmpa  #$09
         bhi   L01C1
         pshs  a
         leay  $01,y
         lda   #$0A
         mul   
         addb  ,s+
         adca  #$00
         beq   L016C
L0181    leax  <L0192,pcr
         ldy   #$000E
         bsr   L01A4
         ldx   <u0003
         bsr   L01A0
         clrb  
         os9   F$Exit   

L0192    fcc   "SYNTAX Error: "

L01A0    ldy   #80
L01A4    lda   #$01
         os9   I$WritLn 
         rts   
L01AA    bsr   L01D1
         bcs   L0181
         pshs  b
         bsr   L01D1
         puls  a
         bcc   L01B9
         clrb  
         exg   a,b
L01B9    lsla  
         lsla  
         lsla  
         lsla  
         pshs  a
         addb  ,s+
L01C1    lda   ,y
         cmpa  #C$SPAC
         beq   L0152
         cmpa  #C$CR
         beq   L0152
         cmpa  #C$COMA
         beq   L0152
         bra   L0181
L01D1    ldb   ,y
         subb  #$30
         cmpb  #$09
         bls   L01E9
         cmpb  #$31
         bcs   L01DF
         subb  #$20
L01DF    subb  #$07
         cmpb  #$0F
         bhi   L01EE
         cmpb  #$0A
         bcs   L01EE
L01E9    andcc #^Carry
         leay  $01,y
         rts   
L01EE    comb  
         rts   
L01F0    clr   <u0005
         lda   #'/
         lbsr  L02AF
         leax  <u0031,u
         lda   <u0000
         ldb   #SS.DevNm
         os9   I$GetStt 
         bsr   L024A
         lda   #C$CR
         lbsr  L02AF
         leax  >L0015,pcr
         leay  u0007,u
         clrb  
L020F    lda   b,y
         bsr   L0221
         incb  
         cmpb  #C$SPAC
         bcs   L020F
         lda   #C$CR
         lbsr  L02AF
         clrb  
         os9   F$Exit   
L0221    pshs  u,y,x,b,a
         ldy   -$02,x
L0226    cmpb  $02,x
         beq   L0236
         leax  $04,x
L022C    lda   ,x+
         bpl   L022C
         leay  -$01,y
         bne   L0226
         puls  pc,u,y,x,b,a
L0236    bsr   L02AD
         tst   ,x
         bpl   L025E
         lda   ,s
         cmpa  $03,x
         beq   L0246
         lda   #'-
         bsr   L02AF
L0246    bsr   L024E
         puls  pc,u,y,x,b,a
L024A    pshs  x
         bra   L0252
L024E    pshs  x
         leax  $04,x
L0252    lda   ,x
         anda  #$7F
         bsr   L02AF
         lda   ,x+
         bpl   L0252
         puls  pc,x
L025E    bsr   L024E
         lda   #'=
         bsr   L02AF
         tst   ,x
         bne   L0291
         ldb   ,s
         lda   #'/
         clr   <u0006
L026E    inca  
         subb  #$64
         bcc   L026E
         bsr   L0286
         lda   #$3A
L0277    deca  
         addb  #$0A
         bcc   L0277
         bsr   L0286
         tfr   b,a
         adda  #$30
         bsr   L02AF
         puls  pc,u,y,x,b,a
L0286    inc   <u0006
         cmpa  #$30
         bne   L02AF
         dec   <u0006
         bne   L02AF
         rts   
L0291    lda   ,s
         anda  #$F0
         lsra  
         lsra  
         lsra  
         lsra  
         bsr   L02A3
         lda   ,s
         anda  #$0F
         bsr   L02A3
         puls  pc,u,y,x,b,a
L02A3    adda  #$30
         cmpa  #$39
         bls   L02AF
         adda  #$07
         bra   L02AF
L02AD    lda   #C$SPAC
L02AF    pshs  y,x,b,a
         leax  <u0027,u
         ldb   <u0005
         sta   b,x
         cmpa  #C$CR
         beq   L02C9
         incb  
         cmpb  <u0002
         bcs   L02CD
         cmpa  #C$SPAC
         bne   L02CD
         lda   #C$CR
         sta   b,x
L02C9    lbsr  L01A0
         clrb  
L02CD    stb   <u0005
         puls  pc,y,x,b,a
L02D1    pshs  u,y,x
         ldu   -$02,x
L02D5    ldy   $02,s
         stx   ,s
         leax  $04,x
L02DC    lda   ,x+
         eora  ,y+
         anda  #$DF
         lsla  
         bne   L02ED
         bcc   L02DC
         sty   $02,s
         clra  
         puls  pc,u,y,x
L02ED    leax  -$01,x
L02EF    lda   ,x+
         bpl   L02EF
         leau  -u0001,u
         cmpu  #$0000
         bne   L02D5
         coma  
         puls  pc,u,y,x

         emod
eom      equ   *
         end
