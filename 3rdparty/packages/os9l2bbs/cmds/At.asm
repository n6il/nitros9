         nam   At
         ttl   program module       

* Disassembled 2010/01/24 10:29:31 by Disasm v1.5 (C) 1988 by RML

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
u0004    rmb   2
u0006    rmb   2
u0008    rmb   5
u000D    rmb   406
size     equ   .
name     equ   *
         fcs   /At/
L000F    fcb   $55 U
         fcb   $73 s
         fcb   $61 a
         fcb   $67 g
         fcb   $65 e
         fcb   $20 
         fcb   $69 i
         fcb   $73 s
         fcb   $3A :
         fcb   $20 
         fcb   $41 A
         fcb   $74 t
         fcb   $20 
         fcb   $59 Y
         fcb   $59 Y
         fcb   $2F /
         fcb   $4D M
         fcb   $4D M
         fcb   $2F /
         fcb   $44 D
         fcb   $44 D
         fcb   $20 
         fcb   $48 H
         fcb   $48 H
         fcb   $3A :
         fcb   $4D M
         fcb   $4D M
         fcb   $20 
         fcb   $3C <
         fcb   $63 c
         fcb   $6F o
         fcb   $6D m
         fcb   $6D m
         fcb   $61 a
         fcb   $6E n
         fcb   $64 d
         fcb   $6C l
         fcb   $69 i
         fcb   $6E n
         fcb   $65 e
         fcb   $3E >
         fcb   $0D 
L0039    fcb   $45 E
         fcb   $76 v
         fcb   $65 e
         fcb   $6E n
         fcb   $74 t
         fcb   $20 
         fcb   $73 s
         fcb   $63 c
         fcb   $68 h
         fcb   $65 e
         fcb   $64 d
         fcb   $75 u
         fcb   $6C l
         fcb   $65 e
         fcb   $64 d
         fcb   $0D 
L0049    fcb   $53 S
         fcb   $68 h
         fcb   $65 e
         fcb   $6C l
         fcb   $6C l
         fcb   $0D 
L004F    fcb   $C1 A
         fcb   $02 
         fcb   $10 
         fcb   $27 '
         fcb   $00 
         fcb   $B3 3
         fcb   $C1 A
         fcb   $03 
         fcb   $10 
         fcb   $27 '
         fcb   $00 
         fcb   $AD -
         fcb   $3B ;
start    equ   *
         pshs  x
         leax  >L004F,pcr
         os9   F$Icpt   
         puls  x
         leay  u0008,u
         lda   #$05
         sta   ,u
L006D    lbsr  L010B
         stb   ,y+
         dec   ,u
         bne   L006D
         stx   u0006,u
         leax  >L0039,pcr
         ldy   #$00C8
         lda   #$01
         os9   I$WritLn 
L0085    leax  u000D,u
         os9   F$Time   
         ldb   #$05
         leay  u0008,u
         lda   ,y
         bne   L00A0
         lda   $01,y
         bne   L00A0
         lda   $02,y
         bne   L00A0
         leay  $03,y
         leax  $03,x
         ldb   #$02
L00A0    lda   ,x+
         cmpa  ,y+
         bne   L00AB
         decb  
         bne   L00A0
         bra   L00B3
L00AB    ldx   #$003C
         os9   F$Sleep  
         bra   L0085
L00B3    ldx   u0006,u
         clrb  
L00B6    incb  
         lda   ,x+
         cmpa  #$0D
         bne   L00B6
         clra  
         tfr   d,y
         leax  >L0049,pcr
         pshs  u
         ldu   u0006,u
         lda   #$11
         ldb   #$03
         os9   F$Fork   
         puls  u
         lbcs  L0108
         os9   F$Wait   
         lbcs  L0108
         leay  u0008,u
         lda   ,y
         bne   L0107
         lda   $01,y
         bne   L0107
         lda   $02,y
         bne   L0107
         leax  u000D,u
         os9   F$Time   
         lda   $04,x
         sta   u0002,u
L00F3    ldx   #$003C
         os9   F$Sleep  
         leax  u000D,u
         os9   F$Time   
         lda   $04,x
         cmpa  u0002,u
         beq   L00F3
         lbra  L0085
L0107    clrb  
L0108    os9   F$Exit   
L010B    pshs  y
L010D    lda   ,x+
         cmpa  #$0D
         lbeq  L01C2
         cmpa  #$30
         bcs   L010D
         cmpa  #$39
         bhi   L010D
         leax  -$01,x
L011F    lda   ,x+
         cmpa  #$30
         bcs   L012B
         cmpa  #$39
         bhi   L012B
         bra   L011F
L012B    pshs  x
         leax  -$01,x
         clr   u0002,u
         clr   u0003,u
         ldd   #$0001
         std   u0004,u
L0138    lda   ,-x
         cmpa  #$30
         bcs   L016C
         cmpa  #$39
         bhi   L016C
         suba  #$30
         sta   u0001,u
         ldd   #$0000
L0149    tst   u0001,u
         beq   L0153
         addd  u0004,u
         dec   u0001,u
         bra   L0149
L0153    addd  u0002,u
         std   u0002,u
         lda   #$0A
         sta   u0001,u
         ldd   #$0000
L015E    tst   u0001,u
         beq   L0168
         addd  u0004,u
         dec   u0001,u
         bra   L015E
L0168    std   u0004,u
         bra   L0138
L016C    ldd   u0002,u
         puls  x
         puls  pc,y
         std   u0002,u
         lda   #$30
         sta   ,x
         sta   $01,x
         sta   $02,x
         sta   $03,x
         sta   $04,x
         ldd   #$2710
         std   u0004,u
         ldd   u0002,u
         lbsr  L01B3
         ldd   #$03E8
         std   u0004,u
         ldd   u0002,u
         bsr   L01B3
         ldd   #$0064
         std   u0004,u
         ldd   u0002,u
         bsr   L01B3
         ldd   #$000A
         std   u0004,u
         ldd   u0002,u
         bsr   L01B3
         ldd   #$0001
         std   u0004,u
         ldd   u0002,u
         bsr   L01B3
         lda   #$0D
         sta   ,x
         rts   
L01B3    subd  u0004,u
         bcs   L01BB
         inc   ,x
         bra   L01B3
L01BB    addd  u0004,u
         std   u0002,u
         leax  $01,x
         rts   
L01C2    leax  >L000F,pcr
         ldy   #$00C8
         lda   #$01
         os9   I$WritLn 
         clrb  
         os9   F$Exit   
         emod
eom      equ   *
         end
