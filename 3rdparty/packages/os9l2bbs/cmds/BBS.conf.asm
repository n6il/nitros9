         nam   BBS.conf
         ttl   program module       

* Disassembled 2010/01/24 10:30:39 by Disasm v1.5 (C) 1988 by RML

         ifp1
         use   /dd/defs/defsfile
         endc
tylg     set   Prgrm+Objct   
atrv     set   ReEnt+rev
rev      set   $01
         mod   eom,name,tylg,atrv,start,size
u0000    rmb   2
u0002    rmb   2
u0004    rmb   2
u0006    rmb   2
u0008    rmb   2
u000A    rmb   2
u000C    rmb   200
u00D4    rmb   420
size     equ   .
name     equ   *
         fcs   /BBS.conf/
L0015    fcb   $43 C
         fcb   $6F o
         fcb   $6E n
         fcb   $66 f
         fcb   $2E .
         fcb   $64 d
         fcb   $61 a
         fcb   $74 t
L001D    fcb   $0D 
         fcb   $0A 
L001F    fcb   $45 E
         fcb   $6E n
         fcb   $74 t
         fcb   $65 e
         fcb   $72 r
         fcb   $20 
         fcb   $79 y
         fcb   $6F o
         fcb   $75 u
         fcb   $72 r
         fcb   $20 
         fcb   $68 h
         fcb   $61 a
         fcb   $6E n
         fcb   $64 d
         fcb   $6C l
         fcb   $65 e
         fcb   $3A :
L0031    fcb   $50 P
         fcb   $72 r
         fcb   $65 e
         fcb   $73 s
         fcb   $73 s
         fcb   $20 
         fcb   $3C <
         fcb   $43 C
         fcb   $54 T
         fcb   $52 R
         fcb   $4C L
         fcb   $3E >
         fcb   $3C <
         fcb   $5A Z
         fcb   $3E >
         fcb   $20 
         fcb   $74 t
         fcb   $6F o
         fcb   $20 
         fcb   $65 e
         fcb   $78 x
         fcb   $69 i
         fcb   $74 t
         fcb   $20 
         fcb   $20 
         fcb   $20 
         fcb   $20 
         fcb   $20 
         fcb   $20 
         fcb   $20 
         fcb   $20 
         fcb   $20 
         fcb   $3C <
         fcb   $43 C
         fcb   $54 T
         fcb   $52 R
         fcb   $4C L
         fcb   $3E >
         fcb   $3C <
         fcb   $58 X
         fcb   $3E >
         fcb   $20 
         fcb   $77 w
         fcb   $68 h
         fcb   $6F o
         fcb   $27 '
         fcb   $73 s
         fcb   $20 
         fcb   $69 i
         fcb   $6E n
         fcb   $20 
         fcb   $63 c
         fcb   $6F o
         fcb   $6E n
         fcb   $66 f
         fcb   $20 
         fcb   $6D m
         fcb   $6F o
         fcb   $64 d
         fcb   $65 e
         fcb   $0D 
L006E    fcb   $2D -
         fcb   $2D -
         fcb   $2D -
         fcb   $2D -
         fcb   $2D -
         fcb   $2D -
         fcb   $2D -
         fcb   $2D -
         fcb   $2D -
         fcb   $2D -
         fcb   $2D -
         fcb   $2D -
         fcb   $2D -
         fcb   $2D -
         fcb   $2D -
         fcb   $2D -
         fcb   $2D -
         fcb   $2D -
         fcb   $2D -
         fcb   $2D -
         fcb   $2D -
         fcb   $2D -
         fcb   $2D -
         fcb   $2D -
         fcb   $2D -
         fcb   $2D -
         fcb   $2D -
         fcb   $2D -
         fcb   $2D -
         fcb   $2D -
         fcb   $2D -
         fcb   $2D -
         fcb   $2D -
         fcb   $2D -
         fcb   $2D -
         fcb   $2D -
         fcb   $2D -
         fcb   $2D -
         fcb   $2D -
         fcb   $2D -
         fcb   $2D -
         fcb   $2D -
         fcb   $2D -
         fcb   $2D -
         fcb   $2D -
         fcb   $2D -
         fcb   $2D -
         fcb   $2D -
         fcb   $2D -
         fcb   $2D -
         fcb   $2D -
         fcb   $2D -
         fcb   $2D -
         fcb   $2D -
         fcb   $2D -
         fcb   $2D -
         fcb   $2D -
         fcb   $2D -
         fcb   $2D -
         fcb   $2D -
         fcb   $0D 
L00AB    fcb   $42 B
         fcb   $42 B
         fcb   $53 S
         fcb   $2E .
         fcb   $63 c
         fcb   $6F o
         fcb   $6E n
         fcb   $66 f
         fcb   $2E .
         fcb   $77 w
         fcb   $68 h
         fcb   $6F o
         fcb   $0D 
L00B8    fcb   $AE .
         fcb   $46 F
         fcb   $EC l
         fcb   $81 
         fcb   $30 0
         fcb   $01 
         fcb   $10 
         fcb   $A3 #
         fcb   $42 B
         fcb   $26 &
         fcb   $F7 w
         fcb   $30 0
         fcb   $1D 
         fcb   $6F o
         fcb   $84 
         fcb   $6F o
         fcb   $01 
         fcb   $5F _
         fcb   $34 4
         fcb   $40 @
         fcb   $EE n
         fcb   $44 D
         fcb   $10 
         fcb   $3F ?
         fcb   $02 
         fcb   $35 5
         fcb   $40 @
         fcb   $5F _
         fcb   $10 
         fcb   $3F ?
         fcb   $06 
         fcb   $3B ;
start    equ   *
         leax  >L00B8,pcr
         os9   F$Icpt   
         os9   F$ID     
         leay  $01,y
         sty   u0002,u
         leax  >L001F,pcr
         ldy   #$0012
         lda   #$01
         os9   I$Write  
         clra  
         leax  >u00D4,u
         ldy   #$0014
         os9   I$ReadLn 
         leax  >L0031,pcr
         ldy   #$00C8
         lda   #$01
         os9   I$WritLn 
         leax  >L006E,pcr
         ldy   #$00C8
         os9   I$WritLn 
         leax  >L0015,pcr
         lda   #$41
         pshs  u
         os9   F$Link   
         bcc   L0132
         cmpb  #$DD
         lbne  L0263
         os9   F$Load   
         lbcs  L0263
L0132    tfr   u,d
         puls  u
         std   u0004,u
         sty   u0006,u
         leax  u000C,u
         stx   u0008,u
         stx   u000A,u
L0141    ldd   ,y
         beq   L014F
         cmpd  #$FFFF
         beq   L014F
         leay  $03,y
         bra   L0141
L014F    ldd   u0002,u
         std   ,y++
         lda   #$01
         sta   ,y
L0157    lbsr  L015F
         lbsr  L01D3
         bra   L0157
L015F    ldx   u0006,u
L0161    ldd   ,x++
         cmpd  #$FFFF
         lbeq  L01CE
         cmpd  u0002,u
         beq   L0174
         leax  $01,x
         bra   L0161
L0174    lda   ,x+
         beq   L0179
         rts   
L0179    lda   #$01
         sta   -$01,x
         leax  >L001D,pcr
         ldy   #$0001
         lda   #$01
         os9   I$WritLn 
         ldx   u0006,u
         leax  >$0104,x
         clrb  
L0191    lda   ,x+
         incb  
         cmpa  #$3A
         beq   L019C
         cmpa  #$0D
         bne   L0191
L019C    lda   #$3A
         sta   -$01,x
         clra  
         tfr   d,y
         ldx   u0006,u
         leax  >$0104,x
         lda   #$01
         os9   I$Write  
         ldx   u0006,u
         leax  <$3C,x
         lda   #$01
         ldy   #$00C8
         os9   I$WritLn 
         leax  u000C,u
         stx   ,u
         ldd   u0008,u
         subd  ,u
         tfr   d,y
         leax  u000C,u
         lda   #$01
         os9   I$Write  
         rts   
L01CE    ldb   #$01
         lbra  L0263
L01D3    clra  
         ldb   #$01
         os9   I$GetStt 
         bcs   L023D
         ldy   #$0001
         ldx   u0008,u
         os9   I$Read   
         lda   ,x+
         cmpa  #$08
         beq   L023F
         cmpa  #$1A
         lbeq  L0248
         cmpa  #$18
         lbeq  L0266
         cmpa  #$0D
         beq   L020B
         leay  >u00D4,u
         sty   ,u
         cmpx  ,u
         lbeq  L023D
         stx   u0008,u
         bra   L023E
L020B    leax  >L001D,pcr
         ldy   #$0001
         lda   #$01
         os9   I$WritLn 
         ldx   u0006,u
         leax  <$3C,x
         leay  u000C,u
         sty   u0008,u
         ldb   #$FF
L0224    lda   ,y+
         sta   ,x+
         decb  
         bne   L0224
         lda   #$3A
         sta   ,x+
         ldx   u0006,u
L0231    ldd   ,x++
         cmpd  #$FFFF
         beq   L023D
         clr   ,x+
         bra   L0231
L023D    clra  
L023E    rts   
L023F    leax  -$02,x
         cmpx  u000A,u
         bls   L0247
         stx   u0008,u
L0247    rts   
L0248    ldx   u0006,u
L024A    ldd   ,x++
         leax  $01,x
         cmpd  u0002,u
         bne   L024A
         leax  -$03,x
         clr   ,x
         clr   $01,x
         pshs  u
         ldu   u0004,u
         os9   F$UnLink 
         puls  u
         clrb  
L0263    os9   F$Exit   
L0266    lda   #$11
         ldb   #$03
         ldy   #$0001
         leax  >L00AB,pcr
         pshs  u
         leau  >L001D,pcr
         os9   F$Fork   
         os9   F$Wait   
         puls  u
         rts   
         emod
eom      equ   *
         end
