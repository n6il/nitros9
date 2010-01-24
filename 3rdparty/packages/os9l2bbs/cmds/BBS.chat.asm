         nam   BBS.chat
         ttl   program module       

* Disassembled 2010/01/24 10:30:31 by Disasm v1.5 (C) 1988 by RML

         ifp1
         use   /dd/defs/defsfile
         endc
tylg     set   Prgrm+Objct   
atrv     set   ReEnt+rev
rev      set   $01
         mod   eom,name,tylg,atrv,start,size
u0000    rmb   1
u0001    rmb   1
u0002    rmb   3
u0005    rmb   1
u0006    rmb   1
u0007    rmb   402
size     equ   .
name     equ   *
         fcs   /BBS.chat/
L0015    fcb   $50 P
         fcb   $61 a
         fcb   $67 g
         fcb   $69 i
         fcb   $6E n
         fcb   $67 g
         fcb   $20 
         fcb   $53 S
         fcb   $79 y
         fcb   $73 s
         fcb   $6F o
         fcb   $70 p
         fcb   $2E .
         fcb   $2E .
         fcb   $2E .
         fcb   $50 P
         fcb   $6C l
         fcb   $65 e
         fcb   $61 a
         fcb   $73 s
         fcb   $65 e
         fcb   $20 
         fcb   $77 w
         fcb   $61 a
         fcb   $69 i
         fcb   $74 t
         fcb   $0D 
L0030    fcb   $53 S
         fcb   $6F o
         fcb   $72 r
         fcb   $72 r
         fcb   $79 y
         fcb   $2C ,
         fcb   $20 
         fcb   $62 b
         fcb   $75 u
         fcb   $74 t
         fcb   $20 
         fcb   $74 t
         fcb   $68 h
         fcb   $65 e
         fcb   $20 
         fcb   $73 s
         fcb   $79 y
         fcb   $73 s
         fcb   $6F o
         fcb   $70 p
         fcb   $20 
         fcb   $64 d
         fcb   $6F o
         fcb   $65 e
         fcb   $73 s
         fcb   $20 
         fcb   $6E n
         fcb   $6F o
         fcb   $74 t
         fcb   $20 
         fcb   $73 s
         fcb   $65 e
         fcb   $65 e
         fcb   $6D m
         fcb   $20 
         fcb   $74 t
         fcb   $6F o
         fcb   $20 
         fcb   $62 b
         fcb   $65 e
         fcb   $20 
         fcb   $68 h
         fcb   $6F o
         fcb   $6D m
         fcb   $65 e
         fcb   $21 !
         fcb   $0D 
L005F    fcb   $0A 
         fcb   $0D 
L0061    fcb   $2F /
         fcb   $77 w
         fcb   $0D 
L0064    fcb   $2E .
         fcb   $0D 
L0066    fcb   $07 
start    equ   *
         bra   L006B
L0069    neg   <u0000
L006B    stx   u0007,u
         lda   #$0A
         sta   ,u
         leax  >L0170,pcr
         os9   F$Icpt   
         lda   #$FF
         sta   u0002,u
         lda   #$0A
         sta   u0005,u
         leax  >L0061,pcr
         lda   #$03
         os9   I$Open   
         lbcs  L016D
         sta   u0006,u
         leax  >L0015,pcr
         ldy   #$00C8
         lda   #$01
         os9   I$WritLn 
L009C    lda   ,u
         sta   u0001,u
L00A0    leax  >L0066,pcr
         lda   u0006,u
         ldy   #$0001
         os9   I$Write  
         lbcs  L016D
         ldx   #$0004
         os9   F$Sleep  
         dec   u0001,u
         bne   L00A0
         ldx   #$005A
         os9   F$Sleep  
         tst   u0002,u
         beq   L00E6
         leax  >L0064,pcr
         ldy   #$0001
         lda   #$01
         os9   I$Write  
         dec   u0005,u
         bne   L009C
         leax  >L0030,pcr
         ldy   #$00C8
         lda   #$01
         os9   I$WritLn 
         lbra  L016C
L00E6    clr   >L0069,pcr
L00EA    clra  
         ldb   #$01
         os9   I$GetStt 
         bcc   L0120
         tst   >L0069,pcr
         beq   L00EA
L00F8    leax  >L006A,pcr
         ldy   #$0001
         lda   #$01
         os9   I$Write  
         lda   >L006A,pcr
         cmpa  #$0D
         bne   L011A
         leax  >L005F,pcr
         ldy   #$0001
         lda   #$01
         os9   I$Write  
L011A    clr   >L0069,pcr
         bra   L00EA
L0120    tst   >L0069,pcr
         bne   L00F8
         leax  >L006A,pcr
         ldy   #$0001
         clra  
         os9   I$Read   
         lda   ,x
         cmpa  #$0D
         bne   L0145
         leax  >L005F,pcr
         ldy   #$0001
         lda   #$01
         os9   I$Write  
L0145    pshs  cc
         orcc  #$50
         tst   >L0069,pcr
         bne   L0167
         lda   #$01
         sta   >L0069,pcr
         puls  cc
L0157    lda   >L0069,pcr
         lbeq  L00EA
         ldx   #$0001
         os9   F$Sleep  
         bra   L0157
L0167    puls  cc
         lbra  L00F8
L016C    clrb  
L016D    os9   F$Exit   
L0170    cmpb  #$02
         beq   L017B
         cmpb  #$03
         beq   L017A
         clr   u0002,u
L017A    rti   
L017B    clrb  
         os9   F$Exit   
         emod
eom      equ   *
         end
