         nam   BBS.Form
         ttl   program module       

* Disassembled 2010/01/24 10:54:27 by Disasm v1.5 (C) 1988 by RML

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
u0003    rmb   2
u0005    rmb   402
u0197    rmb   7780
size     equ   .
name     equ   *
         fcs   /BBS.Form/
L0015    fcb   $2D -
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
L0040    fcb   $49 I
         fcb   $73 s
         fcb   $20 
         fcb   $61 a
         fcb   $6C l
         fcb   $6C l
         fcb   $20 
         fcb   $69 i
         fcb   $6E n
         fcb   $66 f
         fcb   $6F o
         fcb   $72 r
         fcb   $6D m
         fcb   $61 a
         fcb   $74 t
         fcb   $69 i
         fcb   $6F o
         fcb   $6E n
         fcb   $20 
         fcb   $63 c
         fcb   $6F o
         fcb   $72 r
         fcb   $72 r
         fcb   $65 e
         fcb   $63 c
         fcb   $74 t
         fcb   $3F ?
L005B    fcb   $0A 
         fcb   $0D 
start    equ   *
         stx   u0003,u
L005F    lda   ,x+
         cmpa  #$20
         bne   L005F
         lda   #$0D
         sta   -$01,x
         lda   #$02
         os9   I$Open   
         lbcs  L0082
         sta   ,u
         ldb   #$02
         pshs  u
         os9   I$GetStt 
         os9   I$Seek   
         puls  u
         bra   L008D
L0082    ldb   #$1B
         os9   I$Create 
         lbcs  L0131
         sta   ,u
L008D    ldx   u0003,u
         lda   #$01
         os9   I$Open   
         lbcs  L0131
         sta   u0001,u
         leax  >u0197,u
         stx   u0005,u
L00A0    lda   u0001,u
         ldx   u0005,u
         ldy   #$00C8
         os9   I$ReadLn 
         lbcs  L00CA
         leay  -$01,y
         lda   #$01
         os9   I$Write  
         tfr   y,d
         leax  d,x
         ldy   #$00C8
         clra  
         os9   I$ReadLn 
         tfr   y,d
         leax  d,x
         stx   u0005,u
         bra   L00A0
L00CA    leax  >L0040,pcr
         ldy   #$001B
         lda   #$01
         os9   I$Write  
         leax  u0002,u
         clra  
         ldy   #$0001
         os9   I$Read   
         leax  >L005B,pcr
         ldy   #$0002
         lda   #$01
         os9   I$WritLn 
         lda   u0002,u
         anda  #$DF
         cmpa  #$59
         beq   L0112
         leax  >u0197,u
         stx   u0005,u
         lda   u0001,u
         pshs  u
         ldu   #$0000
         ldx   #$0000
         os9   I$Seek   
         lbcs  L0131
         puls  u
         lbra  L00A0
L0112    leax  >u0197,u
         pshs  x
         ldd   u0005,u
         subd  ,s
         tfr   d,y
         puls  x
         lda   ,u
         os9   I$Write  
         leax  >L0015,pcr
         ldy   #$00C8
         os9   I$WritLn 
         clrb  
L0131    os9   F$Exit   
         emod
eom      equ   *
         end
