********************************************************************
* Procs - Display Processes
*
* $Id$
*
* Ed.    Comments                                       Who YY/MM/DD
* ------------------------------------------------------------------
*  8     Original Microware distribution version

         nam   Procs
         ttl   program module       

* Disassembled 02/04/03 22:40:39 by Disasm v1.6 (C) 1988 by RML

         ifp1
         use   os9defs
         endc
tylg     set   Prgrm+Objct   
atrv     set   ReEnt+rev
rev      set   $01
         mod   eom,name,tylg,atrv,start,size
u0000    rmb   1
u0001    rmb   2
u0003    rmb   2
u0005    rmb   2
u0007    rmb   2
u0009    rmb   1
u000A    rmb   2
u000C    rmb   88
u0064    rmb   132
u00E8    rmb   2155
u0953    rmb   450
size     equ   .
name     equ   *
         fcs   /Procs/
         fcb   $08 
L0013    fcb   $0A 
         fcb   $55 U
         fcb   $73 s
         fcb   $72 r
         fcb   $20 
         fcb   $23 #
         fcb   $20 
         fcb   $20 
         fcb   $69 i
         fcb   $64 d
         fcb   $20 
         fcb   $70 p
         fcb   $74 t
         fcb   $79 y
         fcb   $20 
         fcb   $73 s
         fcb   $74 t
         fcb   $61 a
         fcb   $20 
         fcb   $6D m
         fcb   $65 e
         fcb   $6D m
         fcb   $20 
         fcb   $70 p
         fcb   $72 r
         fcb   $69 i
         fcb   $20 
         fcb   $6D m
         fcb   $6F o
         fcb   $64 d
         fcb   $0D 
L0032    fcb   $2D -
         fcb   $2D -
         fcb   $2D -
         fcb   $2D -
         fcb   $2D -
         fcb   $20 
         fcb   $2D -
         fcb   $2D -
         fcb   $2D -
         fcb   $20 
         fcb   $2D -
         fcb   $2D -
         fcb   $2D -
         fcb   $20 
         fcb   $2D -
         fcb   $2D -
         fcb   $2D -
         fcb   $20 
         fcb   $2D -
         fcb   $2D -
         fcb   $2D -
         fcb   $20 
         fcb   $2D -
         fcb   $2D -
         fcb   $2D -
         fcb   $2D -
         fcb   $2D -
         fcb   $2D -
         fcb   $AD -
L004F    fcb   $20 
         fcb   $61 a
         fcb   $63 c
         fcb   $74 t
         fcb   $A0 
L0054    fcb   $20 
         fcb   $77 w
         fcb   $61 a
         fcb   $69 i
         fcb   $A0 
L0059    fcb   $20 
         fcb   $73 s
         fcb   $6C l
         fcb   $65 e
         fcb   $A0 
start    equ   *
         clr   <u0000
         lda   ,x+
         eora  #$45
         anda  #$DF
         bne   L006A
         inc   <u0000
L006A    leax  u000C,u
         stx   <u000A
         orcc  #$50
         ldx   >$004D
         stx   <u0001
         ldx   >$004F
         stx   <u0003
         ldx   >$0051
         stx   <u0005
         ldx   >$004B
         ldd   $09,x
         std   <u0007
         pshs  u
         leau  >u0953,u
         lda   #$01
         ldx   <u0001
         lbsr  L019D
         lda   #$02
         ldx   <u0003
         lbsr  L019D
         lda   #$03
         ldx   <u0005
         lbsr  L019D
         andcc #$AF
         clra  
         clrb  
         pshu  b,a
         pshu  b,a
         puls  u
         leay  >L0013,pcr
         bsr   L010A
         bsr   L0115
         leay  >L0032,pcr
         bsr   L010A
         bsr   L0115
         leax  >u0953,u
L00BF    leax  -$09,x
         ldd   $05,x
         beq   L0106
         ldd   $07,x
         lbsr  L0166
         lbsr  L014D
         ldb   ,x
         bsr   L012A
         lbsr  L014D
         ldb   $03,x
         bsr   L012A
         lda   $04,x
         leay  >L004F,pcr
         cmpa  #$01
         beq   L00EE
         leay  >L0054,pcr
         cmpa  #$02
         beq   L00EE
         leay  >L0059,pcr
L00EE    bsr   L010A
         ldb   $02,x
         bsr   L012A
         lbsr  L014D
         ldy   $05,x
         ldd   $04,y
         leay  d,y
         bsr   L010A
         bsr   L014D
         bsr   L0115
         bra   L00BF
L0106    clrb  
         os9   F$Exit   
L010A    lda   ,y
         anda  #$7F
         bsr   L0151
         lda   ,y+
         bpl   L010A
         rts   
L0115    pshs  y,x,a
         lda   #$0D
         bsr   L0151
         leax  u000C,u
         stx   <u000A
         ldy   #$0050
         lda   #$01
         os9   I$WritLn 
         puls  pc,y,x,a
L012A    clr   <u0009
         lda   #$FF
L012E    inca  
         subb  #$64
         bcc   L012E
         bsr   L0144
         lda   #$0A
L0137    deca  
         addb  #$0A
         bcc   L0137
         bsr   L0144
         tfr   b,a
         adda  #$30
         bra   L0151
L0144    tsta  
         beq   L0149
         sta   <u0009
L0149    tst   <u0009
         bne   L014F
L014D    lda   #$F0
L014F    adda  #$30
L0151    pshs  x
         ldx   <u000A
         sta   ,x+
         stx   <u000A
         puls  pc,x
L015B    beq   L016D
         com   <u00E8
         neg   <u0064
         neg   <u000A
         neg   <u0001
         stu   >$3436
         leax  <L015B,pcr
         ldy   #$2F20
L016F    leay  >$0100,y
         subd  ,x
         bcc   L016F
         addd  ,x++
         pshs  b,a
         tfr   y,d
         tst   ,x
         bmi   L0197
         ldy   #$2F30
         cmpd  #$3020
         bne   L0191
         ldy   #$2F20
         lda   #$20
L0191    bsr   L0151
         puls  b,a
         bra   L016F
L0197    bsr   L0151
         leas  $02,s
         puls  pc,y,x,b,a
L019D    pshs  y,b,a
         leax  ,x
         beq   L01C9
L01A3    ldd   $09,x
         tst   <u0000
         bne   L01AE
         cmpd  <u0007
         bne   L01C5
L01AE    pshu  b,a
         lda   $0B,x
         ldb   ,s
         ldy   <$12,x
         pshu  y,b,a
         lda   $08,x
         pshu  a
         lda   ,x
         ldb   <$26,x
         pshu  b,a
L01C5    ldx   $0E,x
         bne   L01A3
L01C9    puls  pc,y,b,a
         pshs  x,b,a
         ldx   >$0064
         tsta  
         beq   L01E2
         clrb  
         lsra  
         rorb  
         lsra  
         rorb  
         lda   a,x
         tfr   d,y
         beq   L01E2
         tst   ,y
         bne   L01E3
L01E2    coma  
L01E3    puls  pc,x,b,a
         emod
eom      equ   *
