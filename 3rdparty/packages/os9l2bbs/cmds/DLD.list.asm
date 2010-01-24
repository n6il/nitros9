         nam   DLD.list
         ttl   program module       

* Disassembled 2010/01/24 10:39:56 by Disasm v1.5 (C) 1988 by RML

         ifp1
         use   /dd/defs/defsfile
         endc
tylg     set   Prgrm+Objct   
atrv     set   ReEnt+rev
rev      set   $01
         mod   eom,name,tylg,atrv,start,size
u0000    rmb   1
u0001    rmb   1
u0002    rmb   1
u0003    rmb   31
u0022    rmb   1
u0023    rmb   464
size     equ   .
name     equ   *
         fcs   /DLD.list/
L0015    fcb   $44 D
         fcb   $4C L
         fcb   $44 D
         fcb   $2E .
         fcb   $6C l
         fcb   $73 s
         fcb   $74 t
         fcb   $0D 
L001D    fcb   $4E N
         fcb   $6F o
         fcb   $20 
         fcb   $66 f
         fcb   $69 i
         fcb   $6C l
         fcb   $65 e
         fcb   $73 s
         fcb   $20 
         fcb   $66 f
         fcb   $6F o
         fcb   $75 u
         fcb   $6E n
         fcb   $64 d
         fcb   $2E .
         fcb   $0D 
L002D    fcb   $20 
         fcb   $20 
         fcb   $20 
         fcb   $20 
         fcb   $20 
         fcb   $20 
         fcb   $20 
         fcb   $20 
         fcb   $20 
         fcb   $20 
         fcb   $20 
         fcb   $20 
         fcb   $20 
         fcb   $20 
         fcb   $20 
         fcb   $20 
         fcb   $20 
         fcb   $20 
         fcb   $20 
         fcb   $20 
         fcb   $20 
         fcb   $20 
         fcb   $20 
         fcb   $20 
         fcb   $20 
         fcb   $20 
         fcb   $20 
         fcb   $20 
         fcb   $20 
         fcb   $20 
         fcb   $20 
         fcb   $20 
         fcb   $20 
         fcb   $20 
         fcb   $20 
         fcb   $20 
         fcb   $20 
         fcb   $20 
         fcb   $20 
         fcb   $20 
         fcb   $20 
         fcb   $20 
         fcb   $20 
         fcb   $20 
         fcb   $20 
         fcb   $20 
         fcb   $20 
         fcb   $20 
         fcb   $20 
         fcb   $20 
         fcb   $20 
         fcb   $20 
         fcb   $20 
         fcb   $20 
         fcb   $20 
         fcb   $20 
         fcb   $20 
         fcb   $20 
         fcb   $20 
         fcb   $20 
         fcb   $20 
         fcb   $20 
         fcb   $20 
         fcb   $20 
         fcb   $20 
         fcb   $20 
         fcb   $20 
         fcb   $20 
         fcb   $20 
         fcb   $20 
         fcb   $20 
         fcb   $20 
         fcb   $20 
         fcb   $20 
         fcb   $20 
         fcb   $20 
         fcb   $20 
         fcb   $20 
         fcb   $20 
         fcb   $0D 
L007D    fcb   $46 F
         fcb   $69 i
         fcb   $6C l
         fcb   $65 e
         fcb   $20 
         fcb   $6E n
         fcb   $61 a
         fcb   $6D m
         fcb   $65 e
         fcb   $20 
         fcb   $20 
         fcb   $20 
         fcb   $20 
         fcb   $20 
         fcb   $20 
         fcb   $44 D
         fcb   $65 e
         fcb   $73 s
         fcb   $63 c
         fcb   $72 r
         fcb   $69 i
         fcb   $70 p
         fcb   $74 t
         fcb   $69 i
         fcb   $6F o
         fcb   $6E n
         fcb   $0D 
L0098    fcb   $2D -
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
         clr   u0002,u
         lda   ,x
         cmpa  #$0D
         beq   L00F4
         lda   #$01
         os9   I$ChgDir 
         lbcs  L0192
L00F4    leax  >L0015,pcr
         lda   #$01
         os9   I$Open   
         lbcs  L0192
         sta   ,u
L0103    clra  
         ldb   #$01
         os9   I$GetStt 
         lbcc  L0191
         lda   ,u
         leax  u0003,u
         ldy   #$0060
         os9   I$Read   
         lbcs  L017C
         lda   <u0022,u
         cmpa  #$FF
         bne   L0103
         tst   u0002,u
         bne   L0143
         leax  >L007D,pcr
         ldy   #$00C8
         lda   #$01
         os9   I$WritLn 
         leax  >L0098,pcr
         ldy   #$00C8
         os9   I$WritLn 
         lda   #$FF
         sta   u0002,u
L0143    clrb  
         leax  u0003,u
L0146    lda   ,x+
         cmpa  #$0D
         beq   L014F
         incb  
         bra   L0146
L014F    stb   u0001,u
         clra  
         tfr   d,y
         leax  u0003,u
         lda   #$01
         os9   I$Write  
         ldb   #$0F
         subb  u0001,u
         blt   L016D
         clra  
         tfr   d,y
         lda   #$01
         leax  >L002D,pcr
         os9   I$Write  
L016D    leax  <u0023,u
         ldy   #$0041
         lda   #$01
         os9   I$WritLn 
         lbra  L0103
L017C    cmpb  #$D3
         bne   L0192
         tst   u0002,u
         bne   L0191
         leax  >L001D,pcr
         ldy   #$00C8
         lda   #$01
         os9   I$WritLn 
L0191    clrb  
L0192    os9   F$Exit   
         emod
eom      equ   *
         end
