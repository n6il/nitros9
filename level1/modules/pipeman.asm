********************************************************************
* PipeMan - Pipe file manager
*
* $Id$
*
* Ed.    Comments                                       Who YY/MM/DD
* ------------------------------------------------------------------
*   4    From Tandy OS-9 Level One VR 02.00.00

         nam   PipeMan
         ttl   Pipe file manager

* Disassembled 98/08/23 18:26:04 by Disasm v1.6 (C) 1988 by RML

         ifp1
         use   defsfile
         endc

tylg     set   FlMgr+Objct   
atrv     set   ReEnt+rev
rev      set   $01
edition  set   4

         mod   eom,name,tylg,atrv,start,size

u0000    rmb   0
size     equ   .

name     fcs   /PipeMan/
         fcb   edition

start    lbra  Create
         lbra  Open
         lbra  MakDir
         lbra  ChgDir
         lbra  Delete
         lbra  Seek
         lbra  Read
         lbra  Write
         lbra  ReadLn
         lbra  WritLn
         lbra  GetStt
         lbra  SetStt
         lbra  Close
MakDir
ChgDir
Delete
         comb  
         ldb   #E$UnkSvc
         rts   
Seek 
GetStt
SetStt
         clrb  
         rts   
Create
Open
         ldu   $06,y
         ldx   $04,u
         pshs  y
         os9   F$PrsNam 
         bcs   L0073
         lda   -$01,y
         bmi   L0058
         leax  ,y
         os9   F$PrsNam 
         bcc   L0073
L0058    sty   $04,u
         puls  y
         ldd   #$0100
         os9   F$SRqMem 
         bcs   L0072
         stu   $08,y
         stu   <$14,y
         stu   <$16,y
         leau  d,u
         stu   <$12,y
L0072    rts   
L0073    comb  
         ldb   #$D7
         puls  pc,y
Close    lda   $02,y
         bne   L0086
         ldu   $08,y
         ldd   #$0100
         os9   F$SRtMem 
         bra   L00A1
L0086    cmpa  $0B,y
         bne   L008E
         leax  $0A,y
         bra   L0094
L008E    cmpa  $0F,y
         bne   L00A1
         leax  $0E,y
L0094    lda   ,x
         beq   L00A1
         ldb   $02,x
         beq   L00A1
         clr   $02,x
         os9   F$Send   
L00A1    clrb  
         rts   
ReadLn   ldb   #$0D
         stb   $0D,y
         bra   L00AB
Read     clr   $0D,y
L00AB    leax  $0A,y
         lbsr  L0140
         bcs   L00EB
         ldd   $06,u
         beq   L00EB
         ldx   $04,u
         addd  $04,u
         pshs  b,a
         bra   L00C9
L00BE    pshs  x
         leax  $0A,y
         lbsr  L016B
         puls  x
         bcs   L00DC
L00C9    lbsr  L01D2
         bcs   L00BE
         sta   ,x+
         tst   $0D,y
         beq   L00D8
         cmpa  $0D,y
         beq   L00DC
L00D8    cmpx  ,s
         bcs   L00C9
L00DC    tfr   x,d
         subd  ,s++
         addd  $06,u
         std   $06,u
         bne   L00EA
         ldb   #$D3
         bra   L00EB
L00EA    clrb  
L00EB    leax  $0A,y
         lbra  L019D
WritLn   ldb   #$0D
         stb   <$11,y
         bra   L00FA
Write    clr   <$11,y
L00FA    leax  $0E,y
         lbsr  L0140
         bcs   L013C
         ldd   $06,u
         beq   L013C
         ldx   $04,u
         addd  $04,u
         pshs  b,a
         bra   L0118
L010D    pshs  x
         leax  $0E,y
         lbsr  L016B
         puls  x
         bcs   L0130
L0118    lda   ,x
         lbsr  L01AC
         bcs   L010D
         leax  $01,x
         tst   <$11,y
         beq   L012B
         cmpa  <$11,y
         beq   L0130
L012B    cmpx  ,s
         bcs   L0118
         clrb  
L0130    pshs  b,cc
         tfr   x,d
         subd  $02,s
         addd  $06,u
         std   $06,u
         puls  x,b,cc
L013C    leax  $0E,y
         bra   L019D
L0140    lda   ,x
         beq   L0165
         cmpa  $05,y
         beq   L0169
         inc   $01,x
         ldb   $01,x
         cmpb  $02,y
         bne   L0153
         lbsr  L0094
L0153    os9   F$IOQu   
         dec   $01,x
         pshs  x
         ldx   <$004B
         ldb   <$36,x
         puls  x
         beq   L0140
         coma  
         rts   
L0165    ldb   $05,y
         stb   ,x
L0169    clrb  
         rts   
L016B    ldb   $01,x
         incb  
         cmpb  $02,y
         beq   L0199
         stb   $01,x
         ldb   #$01
         stb   $02,x
         clr   $05,y
         pshs  x
         tfr   x,d
         eorb  #$04
         tfr   d,x
         lbsr  L0094
         ldx   #$0000
         os9   F$Sleep  
         ldx   <$004B
         ldb   <$36,x
         puls  x
         dec   $01,x
         tstb  
         bne   L019B
         clrb  
         rts   
L0199    ldb   #$F5
L019B    coma  
         rts   
L019D    pshs  u,b,cc
         clr   ,x
         tfr   x,d
         eorb  #$04
         tfr   d,x
         lbsr  L0094
         puls  pc,u,b,cc
L01AC    pshs  x,b
         ldx   <$14,y
         ldb   <$18,y
         beq   L01BE
         cmpx  <$16,y
         bne   L01C3
         comb  
         puls  pc,x,b
L01BE    ldb   #$01
         stb   <$18,y
L01C3    sta   ,x+
         cmpx  <$12,y
         bcs   L01CC
         ldx   $08,y
L01CC    stx   <$14,y
         clrb  
         puls  pc,x,b
L01D2    lda   <$18,y
         bne   L01D9
         comb  
         rts   
L01D9    pshs  x
         ldx   <$16,y
         lda   ,x+
         cmpx  <$12,y
         bcs   L01E7
         ldx   $08,y
L01E7    stx   <$16,y
         cmpx  <$14,y
         bne   L01F2
         clr   <$18,y
L01F2    andcc #^Carry
         puls  pc,x

         emod
eom      equ   *
         end

