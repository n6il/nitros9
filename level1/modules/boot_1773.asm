********************************************************************
* Boot - WD1773 Boot for OS-9
*
* $Id$
*
* Ed.    Comments                                       Who YY/MM/DD
* ------------------------------------------------------------------
*   4    From Tandy OS-9 Level Two VR 02.00.01 and 
*        modified to work properly under OS-9 Level One

         nam   Boot
         ttl   os9 system module    

* Disassembled 98/08/23 21:21:26 by Disasm v1.6 (C) 1988 by RML

         ifp1
         use   defsfile
         use   rbfdefs
         endc

* Step Rate:
*      $00  = 6ms
*      $01  =
*      $02  =
*      $03  = 30ms
STEP     set   $00

tylg     set   Systm+Objct   
atrv     set   ReEnt+rev
rev      set   $01
edition  set   4

         mod   eom,name,tylg,atrv,start,size

u0000    rmb   2
u0002    rmb   2
u0004    rmb   1
u0005    rmb   1
u0006    rmb   1
u0007    rmb   1
u0008    rmb   1
u0009    rmb   1
size     equ   .

name     fcs   /Boot/
         fcb   edition

* First, we make a stack...
start    clra  
         ldb   #size
MakeStak pshs  a
         decb  
         bne   MakeStak

         tfr   s,u
         ldx   #DPort+8
         lda   #$D0
         sta   ,x
         lbsr  L01A7
         lda   ,x
         lda   #$FF
         sta   u0004,u
         leax  >NMIRtn,pcr
         IFGT  Level-1
         stx   <D.NMI
         lda   #$09
         ELSE
         stx   >D.XNMI+1
         lda   #$7E
         sta   >D.XNMI
         lda   #$08
         ENDC
         sta   >DPort

* delay loop
         IFGT  Level-1
         ldd   #$C350
         ELSE
         ldd   #$61A8
         ENDC
L003A    nop   
         nop   
         subd  #$0001
         bne   L003A

* search for a free page (to use as a 256 byte disk buffer)
         pshs  u,y,x,b,a
         ldd   #$0001
         os9   F$SRqMem 
         bcs   L00AA
         tfr   u,d
         ldu   $06,s
         std   u0002,u
         clrb  

* go get LSN0
         ldx   #$0000
         bsr   L00C4
         bcs   L00AA

* get bootfile size from LSN0 and allocate memory for it
         ldd   DD.TOT+1,y
         std   u0007,u
         lda   <DD.FMT,y
         sta   u0005,u
         anda  #$01
         sta   u0008,u
         lda   DD.TKS,y
         sta   u0006,u
         ldd   <DD.BSZ,y
         std   ,s
         ldx   <DD.BT+1,y
         pshs  x
         ldd   #256
         ldu   u0002,u
         os9   F$SRtMem 
         ldd   $02,s
         IFGT  Level-1
         os9   F$BtMem  
         ELSE
         os9   F$SRqMem
         ENDC
         puls  x
         bcs   L00AA
         stu   $02,s
         ldu   $06,s
         ldd   $02,s
         std   u0002,u
         ldd   ,s
         beq   L00A3

* this loop reads a sector at a time from the bootfile
L0091    pshs  x,b,a
         clrb  
         bsr   L00C4
         bcs   L00A8
         puls  x,b,a
         inc   u0002,u
         leax  1,x
         subd  #256
         bhi   L0091
L00A3    clrb  
         puls  b,a
         bra   L00AC
L00A8    leas  $04,s
L00AA    leas  $02,s
L00AC
         IFGT  Level-1
         sta   >$FFD9
         ENDC
         puls  u,y,x
         leas  size,s
         rts   

L00B4    lda   #$29
         sta   ,u
         clr   u0004,u
         lda   #$05
         lbsr  L016D
         ldb   #STEP
         lbra  L0192

L00C4    lda   #$91
         cmpx  #$0000
         bne   L00DC
         bsr   L00DC
         bcs   L00D3
         ldy   u0002,u
         clrb  
L00D3    rts   

L00D4    bcc   L00DC
         pshs  x,b,a
         bsr   L00B4
         puls  x,b,a
L00DC    pshs  x,b,a
         bsr   L00E7
         puls  x,b,a
         bcc   L00D3
         lsra  
         bne   L00D4
L00E7    bsr   L0139
         bcs   L00D3
         ldx   u0002,u
         orcc  #IntMasks
         pshs  y
         ldy   #$FFFF
         ldb   #$80
         stb   >DPort+8
         ldb   ,u
         orb   #$30
         tst   u0009,u
         beq   L0104
         orb   #$40
L0104    stb   >DPort
         lbsr  L01A7
         orb   #$80
         lda   #$02
L010E    bita  >DPort+8
         bne   L0120
         leay  -$01,y
         bne   L010E
         lda   ,u
         sta   >DPort
         puls  y
         bra   L0135
L0120    lda   >DPort+$B
         sta   ,x+
         stb   >DPort
         bra   L0120

NMIRtn   leas  size+2,s
         puls  y
         ldb   >DPort+8
         bitb  #$04
         beq   L018C
L0135    comb  
         ldb   #E$Read
         rts   

L0139    lda   #$09
         sta   ,u
         clr   u0009,u
         tfr   x,d
         cmpd  #$0000
         beq   L0169
         clr   ,-s
         tst   u0008,u
         beq   L015F
         bra   L0155
L014F    com   u0009,u
         bne   L0155
         inc   ,s
L0155    subb  u0006,u
         sbca  #$00
         bcc   L014F
         bra   L0165
L015D    inc   ,s
L015F    subb  u0006,u
         sbca  #$00
         bcc   L015D
L0165    addb  #18
         puls  a
L0169    incb  
         stb   >DPort+$A
L016D    ldb   u0004,u
         stb   >DPort+9
         cmpa  u0004,u
         beq   L018A
         sta   u0004,u
         sta   >DPort+$B
         ldb   #$10+STEP
         bsr   L0192
         pshs  x
         ldx   #$222E
L0184    leax  -1,x
         bne   L0184
         puls  x
L018A    clrb  
         rts   
L018C    bitb  #$98
         bne   L0135
         clrb  
         rts   
L0192    bsr   L01A5
L0194    ldb   >DPort+$8
         bitb  #$01
         bne   L0194
         rts   
L019C    lda   ,u
         sta   >DPort
         stb   >DPort+$8
         rts   
L01A5    bsr   L019C
L01A7    lbsr  L01AA
L01AA    lbsr  L01AD
L01AD    rts   

         IFGT  Level-1

         rts   
         rts   
         rts   
         rts   
         rts   
         rts   
         rts   
         rts   
         rts   
         rts   
         rts   
         rts   
         rts   
         rts   
         rts   
         rts   
         rts   
         rts   
         rts   
         rts   
         rts   
         rts   
         rts   
         rts   
         rts   
         rts   
         rts   
         rts   
         rts   
         rts   
         rts   

         ENDC

         emod
eom      equ   *
         end
