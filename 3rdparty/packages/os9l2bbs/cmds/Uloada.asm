         nam   Uloada
         ttl   program module       

* Disassembled 2010/01/24 10:54:58 by Disasm v1.5 (C) 1988 by RML

         ifp1
         use   defsfile
         endc
tylg     set   Prgrm+Objct   
atrv     set   ReEnt+rev
rev      set   $01
         mod   eom,name,tylg,atrv,start,size
u0000    rmb   1
u0001    rmb   200
u00C9    rmb   600
size     equ   .
name     equ   *
         fcs   /Uloada/
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
         fcb   $75 u
         fcb   $70 p
         fcb   $6C l
         fcb   $6F o
         fcb   $61 a
         fcb   $64 d
L002B    fcb   $50 P
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
         fcb   $54 T
         fcb   $3E >
         fcb   $20 
         fcb   $74 t
         fcb   $6F o
         fcb   $20 
         fcb   $74 t
         fcb   $65 e
         fcb   $72 r
         fcb   $6D m
         fcb   $69 i
         fcb   $6E n
         fcb   $61 a
         fcb   $6C l
         fcb   $20 
         fcb   $75 u
         fcb   $70 p
         fcb   $6C l
         fcb   $6F o
         fcb   $61 a
         fcb   $64 d
         fcb   $0A 
         fcb   $0D 
         fcb   $50 P
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
         fcb   $58 X
         fcb   $3E >
         fcb   $20 
         fcb   $74 t
         fcb   $6F o
         fcb   $20 
         fcb   $63 c
         fcb   $61 a
         fcb   $6E n
         fcb   $63 c
         fcb   $65 e
         fcb   $6C l
         fcb   $0A 
         fcb   $0D 
L006A    fcb   $0A 
         fcb   $3A :
start    equ   *
         lda   ,x
         cmpa  #$0D
         bne   L008B
         leax  >L0013,pcr
         ldy   #$0018
         lda   #$01
         os9   I$Write  
         leax  u0001,u
         ldy   #$00C8
         clra  
         os9   I$ReadLn 
         leax  u0001,u
L008B    lda   #$03
         ldb   #$1B
         os9   I$Create 
         lbcs  L00F0
         sta   ,u
         leax  >L002B,pcr
         ldy   #$003F
         lda   #$01
         os9   I$Write  
         leax  >L006A,pcr
         ldy   #$0002
         lda   #$01
         os9   I$Write  
L00B2    clra  
         ldb   #$01
         os9   I$GetStt 
         bcs   L00B2
         ldy   #$0001
         leax  >u00C9,u
         os9   I$Read   
         lda   ,x
         cmpa  #$14
         beq   L00EF
         cmpa  #$18
         beq   L00EB
         lda   ,u
         os9   I$Write  
         lda   ,x
         cmpa  #$0D
         beq   L00DC
         bra   L00B2
L00DC    leax  >L006A,pcr
         ldy   #$0002
         lda   #$01
         os9   I$Write  
         bra   L00B2
L00EB    lda   #$01
         bra   L00F0
L00EF    clrb  
L00F0    os9   F$Exit   
         emod
eom      equ   *
         end
