         nam   BBS.who
         ttl   program module       

* Disassembled 2010/01/24 10:53:30 by Disasm v1.5 (C) 1988 by RML

         ifp1
         use   defsfile
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
u0007    rmb   2
u0009    rmb   200
u00D1    rmb   200
u0199    rmb   912
size     equ   .
name     equ   *
         fcs   /BBS.who/
L0014    fcb   $55 U
         fcb   $6E n
         fcb   $6B k
         fcb   $6E n
         fcb   $6F o
         fcb   $77 w
         fcb   $6E n
         fcb   $20 
         fcb   $55 U
         fcb   $73 s
         fcb   $65 e
         fcb   $72 r
         fcb   $0D 
L0021    fcb   $2F /
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
L0033    fcb   $54 T
         fcb   $68 h
         fcb   $65 e
         fcb   $20 
         fcb   $66 f
         fcb   $6F o
         fcb   $6C l
         fcb   $6C l
         fcb   $6F o
         fcb   $77 w
         fcb   $69 i
         fcb   $6E n
         fcb   $67 g
         fcb   $20 
         fcb   $75 u
         fcb   $73 s
         fcb   $65 e
         fcb   $72 r
         fcb   $73 s
         fcb   $20 
         fcb   $61 a
         fcb   $72 r
         fcb   $65 e
         fcb   $20 
         fcb   $6F o
         fcb   $6E n
         fcb   $2D -
         fcb   $6C l
         fcb   $69 i
         fcb   $6E n
         fcb   $65 e
         fcb   $0D 
L0053    fcb   $2D -
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
start    equ   *
         clra  
         leax  >u00D1,u
         ldb   #$C8
L007A    sta   ,x+
         decb  
         bne   L007A
         clr   u0001,u
         leax  >L0021,pcr
         lda   #$01
         os9   I$Open   
         lbcs  L012E
         sta   ,u
         leax  >L0033,pcr
         ldy   #$00C8
         lda   #$01
         os9   I$WritLn 
         leax  >L0053,pcr
         ldy   #$00C8
         os9   I$WritLn 
L00A8    leax  >u0199,u
         lda   u0001,u
         os9   F$GPrDsc 
         bcs   L00B7
         ldd   $08,x
         bsr   L00C3
L00B7    lda   u0001,u
         inca  
         sta   u0001,u
         cmpa  #$FF
         bcs   L00A8
         lbra  L012D
L00C3    leax  >u00D1,u
L00C7    cmpd  ,x
         beq   L00D6
         pshs  b,a
         ldd   ,x++
         beq   L00D7
         puls  b,a
         bra   L00C7
L00D6    rts   
L00D7    puls  b,a
         std   -$02,x
         std   u0005,u
         lda   ,u
         pshs  u
         ldu   #$0000
         ldx   #$0000
         os9   I$Seek   
         puls  u
L00EC    lda   ,u
         leax  u0009,u
         ldy   #$00C8
         os9   I$ReadLn 
         bcs   L0113
L00F9    lda   ,x+
         cmpa  #$2C
         beq   L0105
         cmpa  #$0D
         bne   L00F9
         bra   L00EC
L0105    lda   #$0D
         sta   -$01,x
         lbsr  L0131
         cmpd  u0005,u
         beq   L0121
         bra   L00EC
L0113    leax  >L0014,pcr
         ldy   #$00C8
         lda   #$01
         os9   I$WritLn 
         rts   
L0121    leax  u0009,u
         ldy   #$00C8
         lda   #$01
         os9   I$WritLn 
         rts   
L012D    clrb  
L012E    os9   F$Exit   
L0131    pshs  y
L0133    lda   ,x+
         cmpa  #$0D
         lbeq  L01E8
         cmpa  #$30
         bcs   L0133
         cmpa  #$39
         bhi   L0133
         leax  -$01,x
L0145    lda   ,x+
         cmpa  #$30
         bcs   L0151
         cmpa  #$39
         bhi   L0151
         bra   L0145
L0151    pshs  x
         leax  -$01,x
         clr   u0003,u
         clr   u0004,u
         ldd   #$0001
         std   u0007,u
L015E    lda   ,-x
         cmpa  #$30
         bcs   L0192
         cmpa  #$39
         bhi   L0192
         suba  #$30
         sta   u0002,u
         ldd   #$0000
L016F    tst   u0002,u
         beq   L0179
         addd  u0007,u
         dec   u0002,u
         bra   L016F
L0179    addd  u0003,u
         std   u0003,u
         lda   #$0A
         sta   u0002,u
         ldd   #$0000
L0184    tst   u0002,u
         beq   L018E
         addd  u0007,u
         dec   u0002,u
         bra   L0184
L018E    std   u0007,u
         bra   L015E
L0192    ldd   u0003,u
         puls  x
         puls  pc,y
         std   u0003,u
         lda   #$30
         sta   ,x
         sta   $01,x
         sta   $02,x
         sta   $03,x
         sta   $04,x
         ldd   #$2710
         std   u0007,u
         ldd   u0003,u
         lbsr  L01D9
         ldd   #$03E8
         std   u0007,u
         ldd   u0003,u
         bsr   L01D9
         ldd   #$0064
         std   u0007,u
         ldd   u0003,u
         bsr   L01D9
         ldd   #$000A
         std   u0007,u
         ldd   u0003,u
         bsr   L01D9
         ldd   #$0001
         std   u0007,u
         ldd   u0003,u
         bsr   L01D9
         lda   #$0D
         sta   ,x
         rts   
L01D9    subd  u0007,u
         bcs   L01E1
         inc   ,x
         bra   L01D9
L01E1    addd  u0007,u
         std   u0003,u
         leax  $01,x
         rts   
L01E8    ldd   #$0000
         rts   
         emod
eom      equ   *
         end
