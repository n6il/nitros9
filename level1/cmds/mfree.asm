********************************************************************
* Mfree - Display Free System RAM
*
* $Id$
*
* Ed.    Comments                                       Who YY/MM/DD
* ------------------------------------------------------------------
*  5     Original Microware distribution version

         nam   Mfree
         ttl   Display Free System RAM

* Disassembled 02/04/03 22:42:18 by Disasm v1.6 (C) 1988 by RML

         ifp1
         use   os9defs
         endc
tylg     set   Prgrm+Objct   
atrv     set   ReEnt+rev
rev      set   $01
         mod   eom,name,tylg,atrv,start,size
u0000    rmb   2
u0002    rmb   2
u0004    rmb   1
u0005    rmb   1
u0006    rmb   2
u0008    rmb   2
u000A    rmb   1
u000B    rmb   2
u000D    rmb   530
size     equ   .
name     equ   *
         fcs   /Mfree/
         fcb   $05 
L0013    fcb   $0A 
         fcb   $20 
         fcb   $41 A
         fcb   $64 d
         fcb   $64 d
         fcb   $72 r
         fcb   $65 e
         fcb   $73 s
         fcb   $73 s
         fcb   $20 
         fcb   $20 
         fcb   $70 p
         fcb   $61 a
         fcb   $67 g
         fcb   $65 e
         fcb   $73 s
         fcb   $0A 
         fcb   $2D -
         fcb   $2D -
         fcb   $2D -
         fcb   $2D -
         fcb   $2D -
         fcb   $2D -
         fcb   $2D -
         fcb   $2D -
         fcb   $2D -
         fcb   $20 
         fcb   $2D -
         fcb   $2D -
         fcb   $2D -
         fcb   $2D -
         fcb   $2D -
         fcb   $8D 
L0034    fcb   $0A 
         fcb   $54 T
         fcb   $6F o
         fcb   $74 t
         fcb   $61 a
         fcb   $6C l
         fcb   $20 
         fcb   $70 p
         fcb   $61 a
         fcb   $67 g
         fcb   $65 e
         fcb   $73 s
         fcb   $20 
         fcb   $66 f
         fcb   $72 r
         fcb   $65 e
         fcb   $65 e
         fcb   $20 
         fcb   $3D =
         fcb   $A0 
L0048    fcb   $47 G
         fcb   $72 r
         fcb   $61 a
         fcb   $70 p
         fcb   $68 h
         fcb   $69 i
         fcb   $63 c
         fcb   $73 s
         fcb   $20 
         fcb   $4D M
         fcb   $65 e
         fcb   $6D m
         fcb   $6F o
         fcb   $72 r
         fcb   $79 y
         fcb   $A0 
L0058    fcb   $4E N
         fcb   $6F o
         fcb   $74 t
         fcb   $20 
         fcb   $41 A
         fcb   $6C l
         fcb   $6C l
         fcb   $6F o
         fcb   $63 c
         fcb   $61 a
         fcb   $74 t
         fcb   $65 e
         fcb   $E4 d
L0065    fcb   $61 a
         fcb   $74 t
         fcb   $3A :
         fcb   $20 
         fcb   $A4 $
start    equ   *
         leay  u000D,u
         sty   <u000B
         leay  <L0013,pcr
         bsr   L00E1
         bsr   L00EC
         ldx   >$0020
         stx   <u0000
         ldx   >$0022
         stx   <u0002
         clra  
         clrb  
         sta   <u0005
         std   <u0006
         std   <u0008
         stb   <u000A
         ldx   <u0000
L008C    lda   ,x+
         bsr   L00A8
         cmpx  <u0002
         bcs   L008C
         bsr   L00B8
         leay  <L0034,pcr
         bsr   L00E1
         ldb   <u0005
         bsr   L0101
         bsr   L00EC
         lbsr  L014A
         clrb  
         os9   F$Exit   
L00A8    bsr   L00AA
L00AA    bsr   L00AC
L00AC    bsr   L00AE
L00AE    lsla  
         bcs   L00B8
         inc   <u0005
         inc   <u000A
         inc   <u0006
         rts   
L00B8    pshs  b,a
         ldb   <u000A
         beq   L00D7
         ldd   <u0008
         bsr   L0136
         lda   #$2D
         bsr   L012C
         ldd   <u0006
         subd  #$0001
         bsr   L0136
         bsr   L0122
         bsr   L0122
         ldb   <u000A
         bsr   L0101
         bsr   L00EC
L00D7    inc   <u0006
         ldd   <u0006
         std   <u0008
         clr   <u000A
         puls  pc,b,a
L00E1    lda   ,y
         anda  #$7F
         bsr   L012C
         lda   ,y+
         bpl   L00E1
         rts   
L00EC    pshs  y,x,a
         lda   #$0D
         bsr   L012C
         leax  u000D,u
         stx   <u000B
         ldy   #$0050
         lda   #$01
         os9   I$WritLn 
         puls  pc,y,x,a
L0101    lda   #$FF
         clr   <u0004
L0105    inca  
         subb  #$64
         bcc   L0105
         bsr   L0119
         lda   #$0A
L010E    deca  
         addb  #$0A
         bcc   L010E
         bsr   L0119
         tfr   b,a
         inc   <u0004
L0119    tsta  
         beq   L011E
         sta   <u0004
L011E    tst   <u0004
         bne   L0124
L0122    lda   #$F0
L0124    adda  #$30
         cmpa  #$3A
         bcs   L012C
         adda  #$07
L012C    pshs  x
         ldx   <u000B
         sta   ,x+
         stx   <u000B
         puls  pc,x
L0136    clr   <u0004
         bsr   L013C
         tfr   b,a
L013C    pshs  a
         lsra  
         lsra  
         lsra  
         lsra  
         bsr   L0146
         puls  a
L0146    anda  #$0F
         bra   L0119
L014A    pshs  y,x
         leay  >L0048,pcr
         bsr   L00E1
         lda   #$01
         ldb   #$12
         os9   I$GetStt 
         bcc   L0163
         leay  >L0058,pcr
         bsr   L00E1
         bra   L016E
L0163    leay  >L0065,pcr
         lbsr  L00E1
         tfr   x,d
         bsr   L0136
L016E    puls  y,x
         lbra  L00EC
         emod
eom      equ   *
