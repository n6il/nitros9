********************************************************************
* Printer - CoCo 3 serial port printer driver
*
* $Id$
*
* Ed.    Comments                                       Who YY/MM/DD
* ------------------------------------------------------------------
* 12     Original OS-9 L2 Tandy distribution

         nam   PRINTER
         ttl   CoCo 3 serial port printer driver

* Disassembled 98/08/24 23:21:29 by Disasm v1.6 (C) 1988 by RML

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

name     fcs   /PRINTER/
         fcb   edition

start    equ   *
         lbra  L006E
         lbra  L0028
         lbra  L002C
         lbra  L005B
         lbra  L0057
         lbra  L006C
L0028    comb  
         ldb   #$CB
         rts   
L002C    ldb   >MPI.Slct
         andb  #$33
         pshs  b
         ldb   #$33
         stb   >MPI.Slct
         tst   >$FF52
         bmi   L004A
L003D    sta   >$FF52
         sta   >$FF52
         puls  b
         stb   >MPI.Slct
         clrb  
         rts   
L004A    ldx   #$0001
         os9   F$Sleep  
         tst   >$FF52
         bpl   L003D
         bra   L004A
L0057    comb  
         ldb   #$D0
         rts   
L005B    cmpa  #$26
         bne   L0057
         ldx   $06,y
         clra  
         ldb   <u001D,u
         std   $04,x
         ldb   <u001E,u
         std   $06,x
L006C    clrb  
         rts   
L006E    ldd   <$2C,y
         std   <u001D,u
         lda   <$26,y
         sta   <u001F,u
         clrb  
         rts   

         emod
eom      equ   *
         end
