********************************************************************
* WCreate - Create a window
*
* $Id$
*
* Ed.    Comments                                       Who YY/MM/DD
* ------------------------------------------------------------------
* 3      Original Tandy/Microware version

         nam   WCreate
         ttl   Create a window

* Disassembled 98/09/11 18:26:55 by Disasm v1.6 (C) 1988 by RML

         ifp1
         use   defsfile
         endc

DOHELP   set   0

tylg     set   Prgrm+Objct   
atrv     set   ReEnt+rev
rev      set   $01
edition  set   3

         mod   eom,name,tylg,atrv,start,size

u0000    rmb   2
u0002    rmb   1
u0003    rmb   7
u000A    rmb   1
u000B    rmb   1
u000C    rmb   1
u000D    rmb   1
u000E    rmb   480
size     equ   .

name     fcs   /WCreate/
         fcb   edition

         IFNE  DOHELP
HelpMsg  fcb   C$CR
         fcb   C$LF
         fcc   "WCreate <windpath> [-s=stype] xpos ypos width height fcol bcol [bord]"
         fcb   C$CR
         fcb   C$LF
         fcc   "Use: Create a new window"
         fcb   C$CR
         fcb   C$LF
         fcc   "Options: -s=stype  place the window on a new screen, must also"
         fcb   C$CR
         fcb   C$LF
         fcc   "                   include the border color."
         fcb   C$CR
         fcb   C$LF
         fcc   "         -z        receive commands from standard input"
         fcb   C$CR
         fcb   C$LF
         fcc   "         -?        receive help message"
         fcb   C$CR
         fcb   C$LF
         ENDC

CurOn    fdb   $1B21

start    clr   <u000D
         clra  
         coma  
         sta   <u000C
         lbsr  L0260
         lda   ,x
         cmpa  #PDELIM
         bne   L015D
         bsr   L01B2
         bra   Exit
L015D    cmpa  #'-
         lbne  ShowHelp
         leax  1,x
         lda   ,x+
         cmpa  #$3F
         lbeq  ShowHelp
         cmpa  #$7A
         beq   L0177
         cmpa  #$5A
         lbne  ShowHelp
L0177    lda   #$01
         sta   <u000D
L017B    clra  
         leax  u000E,u
         ldy   #$0050
         os9   I$ReadLn 
         bcs   L019C
         lda   ,x
         cmpa  #$2A
         beq   L0177
         lbsr  L0260
         lda   ,x
         cmpa  #C$CR
         beq   L01A0
         bsr   L01B5
         bcs   Exit
         bra   L017B
L019C    cmpb  #$D3
         bne   Exit
L01A0    lda   #$01
         lbsr  L0254
         lda   <u000C
         bmi   ExitOk
         os9   I$Close  
         bcs   Exit
ExitOk   clrb  
Exit     os9   F$Exit   

L01B2    lbsr  L0260
L01B5    clr   <u000A
         clr   <u0002
         lda   ,x
         cmpa  #PDELIM
         lbne  L0269
         lda   #$03
         pshs  u,x,a
         leax  $01,x
         os9   I$Attach 
         puls  u,x,a
         lbcs  L0253
         os9   I$Open   
         bcs   L0253
         sta   <u000B
         lbsr  L0260
         lda   ,x+
         cmpa  #'-
         bne   L01FD
         lda   ,x+
         cmpa  #$73
         beq   L01EA
         cmpa  #$53
         bne   L0269
L01EA    lda   ,x+
         cmpa  #$3D
         bne   L0269
         leay  u0002,u
         lbsr  L027B
         bcs   L0269
         inc   <u000A
         ldb   #$07
         bra   L0203
L01FD    leay  u0003,u
         ldb   #$06
         leax  -1,x
L0203    bsr   L027B
         bcs   L0269
         decb  
         bne   L0203
         leax  ,u
         lda   #$1B
         sta   ,x
         lda   #$20
         sta   1,x
         tst   <u000A
         beq   L021E
         ldy   #$000A
         bra   L0222
L021E    ldy   #$0009
L0222    lda   <u000B
         os9   I$Write  
         bcs   L0253
         tst   <u000D
         beq   L024E
         tst   <u000A
         beq   L024E
         tst   <u000C
         bpl   L0239
         lda   #$01
         bsr   L0254
L0239    lda   <u000B
         bsr   L0254
         bcs   L0253
         tst   <u000C
         bmi   L0248
         lda   <u000C
         os9   I$Close  
L0248    lda   <u000B
         sta   <u000C
         bra   L0253
L024E    lda   <u000B
         os9   I$Close  
L0253    rts   
L0254    leax  >CurOn,pcr
         ldy   #$0002
         os9   I$Write  
         rts   
L0260    lda   ,x+
         cmpa  #$20
         beq   L0260
         leax  -1,x
         rts   
L0269    leas  $02,s
ShowHelp equ   *
         IFNE  DOHELP
         lda   #$01
         leax  >HelpMsg,pcr
         ldy   #$0133
         os9   I$Write  
         ENDC
         lbra  ExitOk
L027B    pshs  b
         clrb  
         stb   ,y
L0280    lda   ,x+
         cmpa  #$30
         blt   L029B
         cmpa  #$39
         bhi   L029B
         suba  #$30
         pshs  a
         lda   #$0A
         ldb   ,y
         mul   
         addb  ,s+
         stb   ,y
         bvs   L02A7
         bra   L0280
L029B    cmpa  #C$CR
         beq   L02AA
         cmpa  #C$SPAC
         bsr   L0260
         bra   L02AA
         bne   L02A7
L02A7    comb  
         bra   L02AD
L02AA    clrb  
         leay  $01,y
L02AD    puls  pc,b

         emod
eom      equ   *
         end

