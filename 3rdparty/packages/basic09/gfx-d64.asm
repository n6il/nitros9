********************************************************************
* progname - program module
*
* $Id$
*
* Ed.    Comments                                       Who YY/MM/DD
* ------------------------------------------------------------------
*  -     Original Basic09 from Dragon Data distribution version
*
* $Log$
* Revision 1.1  2002/04/06 14:47:31  roug
* Prego; The basic09 interpreter.
*
*

         nam   GFX
         ttl   subroutine module    

* Disassembled 02/04/06 16:39:17 by Disasm v1.6 (C) 1988 by RML

         ifp1
         use   /dd/defs/os9defs
         endc
tylg     set   Sbrtn+Objct   
atrv     set   ReEnt+rev
rev      set   $01
         mod   eom,name,tylg,atrv,start,size
u0000    rmb   0
size     equ   .
name     equ   *
         fcs   /GFX/
         fcb   $01 
L0011    fcb   $01 
         fcb   $2B +
         fcb   $41 A
         fcb   $6C l
         fcb   $70 p
         fcb   $68 h
         fcb   $61 a
         fcb   $FF 
         fcb   $01 
         fcb   $02 
         fcb   $43 C
         fcb   $69 i
         fcb   $72 r
         fcb   $63 c
         fcb   $6C l
         fcb   $65 e
         fcb   $FF 
         fcb   $00 
         fcb   $C7 G
         fcb   $43 C
         fcb   $6C l
         fcb   $65 e
         fcb   $61 a
         fcb   $72 r
         fcb   $FF 
         fcb   $00 
         fcb   $AE .
         fcb   $43 C
         fcb   $6F o
         fcb   $6C l
         fcb   $6F o
         fcb   $72 r
         fcb   $FF 
         fcb   $01 
         fcb   $8E 
         fcb   $47 G
         fcb   $43 C
         fcb   $6F o
         fcb   $6C l
         fcb   $72 r
         fcb   $FF 
         fcb   $01 
         fcb   $74 t
         fcb   $47 G
         fcb   $4C L
         fcb   $6F o
         fcb   $63 c
         fcb   $FF 
         fcb   $01 
         fcb   $BF ?
         fcb   $4A J
         fcb   $6F o
         fcb   $79 y
         fcb   $53 S
         fcb   $74 t
         fcb   $6B k
         fcb   $FF 
         fcb   $00 
         fcb   $D7 W
         fcb   $4C L
         fcb   $69 i
         fcb   $6E n
         fcb   $65 e
         fcb   $FF 
         fcb   $00 
         fcb   $A2 "
         fcb   $4D M
         fcb   $6F o
         fcb   $64 d
         fcb   $65 e
         fcb   $FF 
         fcb   $00 
         fcb   $A6 &
         fcb   $4D M
         fcb   $6F o
         fcb   $76 v
         fcb   $65 e
         fcb   $FF 
         fcb   $00 
         fcb   $B2 2
         fcb   $50 P
         fcb   $6F o
         fcb   $69 i
         fcb   $6E n
         fcb   $74 t
         fcb   $FF 
         fcb   $01 
         fcb   $2F /
         fcb   $51 Q
         fcb   $75 u
         fcb   $69 i
         fcb   $74 t
         fcb   $FF 
         fcb   $00 
         fcb   $00 
start    equ   *
         leas  -$09,s
         ldd   $0B,s
         beq   L00AD
         tsta  
         bne   L00AD
         leau  >L0011,pcr
L007D    ldy   ,u++
         beq   L00A9
         ldx   $0D,s
L0084    lda   ,x+
         eora  ,u+
         anda  #$DF
         beq   L0094
         leau  -$01,u
L008E    tst   ,u+
         bpl   L008E
         bra   L007D
L0094    tst   -$01,u
         bpl   L0084
         tfr   y,d
         leay  >L0011,pcr
         leay  d,y
         leax  ,s
         leau  <$11,s
         ldd   $0B,s
         jmp   ,y
L00A9    ldb   #$30
         bra   L00AF
L00AD    ldb   #$38
L00AF    coma  
         leas  $09,s
         rts   
         lda   #$0F
         bra   L00B9
         lda   #$15
L00B9    cmpb  #$03
         bne   L00AD
         bra   L010B
         lda   #$11
         bra   L00DE
         cmpb  #$03
         beq   L00D4
         cmpb  #$04
         bne   L00AD
         leau  <$19,s
         lbsr  L015E
         leau  <$11,s
L00D4    lda   #$18
         bra   L010B
         cmpb  #$01
         beq   L00E4
         lda   #$10
L00DE    cmpb  #$02
         bne   L00AD
         bra   L0136
L00E4    lda   #$13
         bra   L0142
         cmpb  #$06
         bhi   L00AD
         cmpb  #$03
         bcs   L015B
         bitb  #$01
         bne   L0103
         leau  <$19,s
         cmpb  #$04
         beq   L00FE
         leau  <$21,s
L00FE    bsr   L015E
         leau  <$11,s
L0103    cmpb  #$04
         bls   L0109
         bsr   L0164
L0109    lda   #$16
L010B    sta   ,x+
         bsr   L016E
         bsr   L016E
         bra   L0144
         cmpb  #$05
         bhi   L015B
         cmpb  #$02
         bcs   L015B
         bitb  #$01
         beq   L012E
         leau  <$15,s
         cmpb  #$03
         beq   L0129
         leau  <$1D,s
L0129    bsr   L015E
         leau  <$11,s
L012E    cmpb  #$03
         bls   L0134
         bsr   L0164
L0134    lda   #$1A
L0136    sta   ,x+
         bsr   L016E
         bra   L0144
         lda   #$0E
         bra   L0142
         lda   #$12
L0142    sta   ,x+
L0144    bsr   L0149
         leas  $09,s
         rts   
L0149    tfr   x,d
         leax  $02,s
         pshs  x
         subd  ,s++
         tfr   d,y
         lda   #$01
         os9   I$Write  
         rts   
L0159    leas  $06,s
L015B    lbra  L00AD
L015E    lda   #$11
         sta   ,x+
         bra   L016E
L0164    puls  y
         lda   #$15
         sta   ,x+
         bsr   L016E
         pshs  y
L016E    pshs  y,b,a
         ldd   [,u++]
         sta   ,x+
         pulu  y
         leay  -$01,y
         beq   L0183
         leay  -$01,y
         bne   L0159
         tsta  
         bne   L0159
         stb   -$01,x
L0183    puls  pc,y,b,a
         cmpb  #$02
         bne   L015B
         ldx   <$13,s
         leax  -$02,x
         bne   L015B
         lda   #$01
         ldb   #$12
         os9   I$GetStt 
         bcs   L019C
         stx   [<$11,s]
L019C    leas  $09,s
         rts   
         cmpb  #$02
         beq   L01AD
         cmpb  #$04
         bne   L015B
         bsr   L0164
         bsr   L0149
         bcs   L019C
L01AD    lda   #$01
         ldb   #$12
         os9   I$GetStt 
         bcs   L019C
         tfr   a,b
         bra   L01ED
L01BA    leau  $04,u
         pshs  u,x
         ldx   -$02,u
         ldu   -$04,u
         leax  -$01,x
         beq   L01CC
         leax  -$01,x
         bne   L0159
         clr   ,u+
L01CC    stb   ,u+
         puls  pc,u,x
         cmpb  #$05
         bne   L015B
         clr   ,x+
         bsr   L016E
         ldx   -$02,x
         lda   #$01
         ldb   #$13
         os9   I$GetStt 
         bcs   L019C
         tfr   a,b
         bsr   L01BA
         tfr   x,d
         bsr   L01BA
         tfr   y,d
L01ED    bsr   L01BA
         leas  $09,s
         rts   
         emod
eom      equ   *
