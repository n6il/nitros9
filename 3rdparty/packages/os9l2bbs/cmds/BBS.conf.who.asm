         nam   BBS.conf.who
         ttl   program module       

* Disassembled 2010/01/24 10:30:49 by Disasm v1.5 (C) 1988 by RML

         ifp1
         use   /dd/defs/defsfile
         endc
tylg     set   Prgrm+Objct   
atrv     set   ReEnt+rev
rev      set   $01
         mod   eom,name,tylg,atrv,start,size
u0000    rmb   1
u0001    rmb   1
u0002    rmb   2
u0004    rmb   1
u0005    rmb   1
u0006    rmb   2
u0008    rmb   2
u000A    rmb   2
u000C    rmb   200
u00D4    rmb   600
size     equ   .
name     equ   *
         fcs   /BBS.conf.who/
L0019    fcb   $43 C
         fcb   $6F o
         fcb   $6E n
         fcb   $66 f
         fcb   $2E .
         fcb   $64 d
         fcb   $61 a
         fcb   $74 t
         fcb   $0D 
L0022    fcb   $2F /
         fcb   $64 d
         fcb   $64 d
         fcb   $2F /
         fcb   $62 b
         fcb   $62 b
         fcb   $73 s
         fcb   $2F /
         fcb   $42 B
         fcb   $42 B
         fcb   $53 S
         fcb   $2E .
         fcb   $61 a
         fcb   $6C l
         fcb   $69 i
         fcb   $61 a
         fcb   $73 s
         fcb   $0D 
L0034    fcb   $4E N
         fcb   $6F o
         fcb   $20 
         fcb   $6F o
         fcb   $6E n
         fcb   $65 e
         fcb   $20 
         fcb   $69 i
         fcb   $73 s
         fcb   $20 
         fcb   $69 i
         fcb   $6E n
         fcb   $20 
         fcb   $63 c
         fcb   $6F o
         fcb   $6E n
         fcb   $66 f
         fcb   $65 e
         fcb   $72 r
         fcb   $65 e
         fcb   $6E n
         fcb   $63 c
         fcb   $65 e
         fcb   $0D 
L004C    fcb   $54 T
         fcb   $68 h
         fcb   $65 e
         fcb   $73 s
         fcb   $65 e
         fcb   $20 
         fcb   $70 p
         fcb   $65 e
         fcb   $6F o
         fcb   $70 p
         fcb   $6C l
         fcb   $65 e
         fcb   $20 
         fcb   $61 a
         fcb   $72 r
         fcb   $65 e
         fcb   $20 
         fcb   $69 i
         fcb   $6E n
         fcb   $20 
         fcb   $63 c
         fcb   $6F o
         fcb   $6E n
         fcb   $66 f
         fcb   $65 e
         fcb   $72 r
         fcb   $65 e
         fcb   $6E n
         fcb   $63 c
         fcb   $65 e
         fcb   $0D 
L006B    fcb   $2D -
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
start    equ   *
         leax  >L0019,pcr
         lda   #$41
         pshs  u
         os9   F$Link   
         lbcs  L00E6
         tfr   u,d
         puls  u
         std   u0008,u
         sty   u000A,u
         leax  >L004C,pcr
         ldy   #$00C8
         lda   #$01
         os9   I$WritLn 
         leax  >L006B,pcr
         ldy   #$00C8
         os9   I$WritLn 
         ldx   u000A,u
L00BC    ldd   ,x++
         cmpd  #$FFFF
         beq   L00D8
         leax  $01,x
         cmpd  #$0000
         beq   L00BC
         pshs  x
         subd  #$0001
         lbsr  L00F7
         puls  x
         bra   L00BC
L00D8    clrb  
         pshs  u
         ldu   u0008,u
         os9   F$UnLink 
         puls  u
         clrb  
         os9   F$Exit   
L00E6    leax  >L0034,pcr
         lda   #$01
         ldy   #$00C8
         os9   I$WritLn 
         clrb  
         os9   F$Exit   
L00F7    std   u0002,u
         leax  >L0022,pcr
         lda   #$01
         os9   I$Open   
         lbcs  L0203
         sta   ,u
L0108    leax  u000C,u
         ldy   #$00C8
         lda   ,u
         os9   I$ReadLn 
         lbcs  L0203
L0117    lda   ,x+
         cmpa  #$2C
         bne   L0117
         lbsr  L0147
         cmpd  u0002,u
         bne   L0108
         leax  u000C,u
         leay  >u00D4,u
L012B    lda   ,x+
         cmpa  #$2C
         beq   L0135
         sta   ,y+
         bra   L012B
L0135    lda   #$0D
         sta   ,y
         leax  >u00D4,u
         ldy   #$00C8
         lda   #$01
         os9   I$WritLn 
         rts   
L0147    pshs  y
L0149    lda   ,x+
         cmpa  #$0D
         lbeq  L01FE
         cmpa  #$30
         bcs   L0149
         cmpa  #$39
         bhi   L0149
         leax  -$01,x
L015B    lda   ,x+
         cmpa  #$30
         bcs   L0167
         cmpa  #$39
         bhi   L0167
         bra   L015B
L0167    pshs  x
         leax  -$01,x
         clr   u0004,u
         clr   u0005,u
         ldd   #$0001
         std   u0006,u
L0174    lda   ,-x
         cmpa  #$30
         bcs   L01A8
         cmpa  #$39
         bhi   L01A8
         suba  #$30
         sta   u0001,u
         ldd   #$0000
L0185    tst   u0001,u
         beq   L018F
         addd  u0006,u
         dec   u0001,u
         bra   L0185
L018F    addd  u0004,u
         std   u0004,u
         lda   #$0A
         sta   u0001,u
         ldd   #$0000
L019A    tst   u0001,u
         beq   L01A4
         addd  u0006,u
         dec   u0001,u
         bra   L019A
L01A4    std   u0006,u
         bra   L0174
L01A8    ldd   u0004,u
         puls  x
         puls  pc,y
         std   u0004,u
         lda   #$30
         sta   ,x
         sta   $01,x
         sta   $02,x
         sta   $03,x
         sta   $04,x
         ldd   #$2710
         std   u0006,u
         ldd   u0004,u
         lbsr  L01EF
         ldd   #$03E8
         std   u0006,u
         ldd   u0004,u
         bsr   L01EF
         ldd   #$0064
         std   u0006,u
         ldd   u0004,u
         bsr   L01EF
         ldd   #$000A
         std   u0006,u
         ldd   u0004,u
         bsr   L01EF
         ldd   #$0001
         std   u0006,u
         ldd   u0004,u
         bsr   L01EF
         lda   #$0D
         sta   ,x
         rts   
L01EF    subd  u0006,u
         bcs   L01F7
         inc   ,x
         bra   L01EF
L01F7    addd  u0006,u
         std   u0004,u
         leax  $01,x
         rts   
L01FE    lda   #$01
         bra   L0203
         clrb  
L0203    os9   F$Exit   
         emod
eom      equ   *
         end
