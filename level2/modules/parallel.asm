********************************************************************
* Parallel - Disto Parallel Printer driver
*
* $Id$
*
* Ed.    Comments                                       Who YY/MM/DD
* ------------------------------------------------------------------
* 12     ???

         nam   Parallel
         ttl   Disto Parallel Printer driver

* Disassembled 98/08/25 13:20:51 by Disasm v1.6 (C) 1988 by RML

         ifp1
         use   defsfile
         endc

tylg     set   Drivr+Objct   
atrv     set   ReEnt+rev
rev      set   $01
edition  set   12

         mod   eom,name,tylg,atrv,start,size

u0000    rmb   29
u001D    rmb   1
u001E    rmb   1
u001F    rmb   1
size     equ   .
         fcb   $03 

name     fcs   /Parallel/
         fcb   edition

start    equ   *
         lbra  L0079
         lbra  L0029
         lbra  L002D
         lbra  L005C
         lbra  L0058
         lbra  L006D
L0029    comb  
         ldb   #$CB
         rts   
L002D    ldb   >MPI.Slct
         andb  #$33
         pshs  b
         ldb   #$33
         stb   >MPI.Slct
         tst   >$FF52
         bmi   L004B
L003E    sta   >$FF52
         sta   >$FF52
         puls  b
         stb   >MPI.Slct
         clrb  
         rts   
L004B    ldx   #$0001
         os9   F$Sleep  
         tst   >$FF52
         bpl   L003E
         bra   L004B
L0058    comb  
         ldb   #$D0
         rts   
L005C    cmpa  #$26
         bne   L0058
         ldx   $06,y
         clra  
         ldb   <u001D,u
         std   $04,x
         ldb   <u001E,u
         std   $06,x
L006D    clra  
         lbra  L002D
         lbra  L002D
         lbra  L002D
         clrb  
         rts   
L0079    ldd   <$2C,y
         std   <u001D,u
         lda   <$26,y
         sta   <u001F,u
         clrb  
         rts   

         emod
eom      equ   *
         end

