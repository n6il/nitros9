         nam   Dloada
         ttl   program module       

* Disassembled 2010/01/24 10:41:51 by Disasm v1.5 (C) 1988 by RML

         ifp1
         use   defsfile
         endc
tylg     set   Prgrm+Objct   
atrv     set   ReEnt+rev
rev      set   $01
         mod   eom,name,tylg,atrv,start,size
u0000    rmb   1
u0001    rmb   32
u0021    rmb   600
size     equ   .
name     equ   *
         fcs   /Dloada/
L0013    fcb   $45 E
         fcb   $6E n
         fcb   $74 t
         fcb   $65 e
         fcb   $72 r
         fcb   $20 
         fcb   $66 f
         fcb   $69 i
         fcb   $6C l
         fcb   $65 e
         fcb   $6E n
         fcb   $61 a
         fcb   $6D m
         fcb   $65 e
         fcb   $20 
         fcb   $74 t
         fcb   $6F o
         fcb   $20 
         fcb   $44 D
         fcb   $6F o
         fcb   $77 w
         fcb   $6E n
         fcb   $6C l
         fcb   $6F o
         fcb   $61 a
         fcb   $64 d
         fcb   $2D -
         fcb   $2D -
         fcb   $3E >
L0030    fcb   $50 P
         fcb   $72 r
         fcb   $65 e
         fcb   $73 s
         fcb   $73 s
         fcb   $20 
         fcb   $3C <
         fcb   $53 S
         fcb   $50 P
         fcb   $41 A
         fcb   $43 C
         fcb   $45 E
         fcb   $3E >
         fcb   $20 
         fcb   $74 t
         fcb   $6F o
         fcb   $20 
         fcb   $61 a
         fcb   $62 b
         fcb   $6F o
         fcb   $72 r
         fcb   $74 t
         fcb   $0D 
L0047    fcb   $50 P
         fcb   $72 r
         fcb   $65 e
         fcb   $73 s
         fcb   $73 s
         fcb   $20 
         fcb   $3C <
         fcb   $45 E
         fcb   $4E N
         fcb   $54 T
         fcb   $45 E
         fcb   $52 R
         fcb   $3E >
         fcb   $20 
         fcb   $74 t
         fcb   $6F o
         fcb   $20 
         fcb   $62 b
         fcb   $65 e
         fcb   $67 g
         fcb   $69 i
         fcb   $6E n
         fcb   $0D 
L005E    fcb   $18 
L005F    fcb   $20 
start    equ   *
         lda   #$01
         os9   I$Open   
         bcs   L0069
         bra   L008B
L0069    leax  >L0013,pcr
         ldy   #$001D
         lda   #$01
         os9   I$Write  
         leax  u0001,u
         ldy   #$0020
         clra  
         os9   I$ReadLn 
         leax  u0001,u
         lda   #$01
         os9   I$Open   
         lbcs  L00F4
L008B    sta   ,u
         leax  >L0030,pcr
         ldy   #$00C8
         lda   #$01
         os9   I$WritLn 
         leax  >L0047,pcr
         ldy   #$00C8
         os9   I$WritLn 
L00A5    leax  <u0021,u
         ldy   #$0001
         clra  
         os9   I$Read   
         lda   <u0021,u
         cmpa  #$20
         lbeq  L00F3
         cmpa  #$0D
         bne   L00A5
         leax  >L005E,pcr
         ldy   #$0001
         os9   I$Write  
L00C8    lda   ,u
         leax  <u0021,u
         ldy   #$00C8
         os9   I$ReadLn 
         bcs   L00F3
         lda   #$01
         os9   I$WritLn 
         clra  
         ldb   #$01
         os9   I$GetStt 
         bcs   L00C8
         ldy   #$0001
         leax  <u0021,u
         os9   I$Read   
         lda   ,x
         cmpa  #$20
         bne   L00C8
L00F3    clrb  
L00F4    pshs  b
         leax  >L005F,pcr
         ldy   #$0001
         lda   #$01
         os9   I$Write  
         puls  b
         os9   F$Exit   
         emod
eom      equ   *
         end
