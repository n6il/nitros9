********************************************************************
* progname - program module
*
* $Id$
*
* Ed.    Comments                                       Who YY/MM/DD
* ------------------------------------------------------------------
*  -     Original Dragon Data distribution version
*
*

         nam   ACIA51
         ttl   Serial port device driver    

* Disassembled 02/04/21 22:37:41 by Disasm v1.6 (C) 1988 by RML

         ifp1
         use   defsfile
         endc
tylg     set   Drivr+Objct   
atrv     set   ReEnt+rev
rev      set   $01
         mod   eom,name,tylg,atrv,start,size
u0000    rmb   1
u0001    rmb   2
u0003    rmb   1
u0004    rmb   1
u0005    rmb   1
u0006    rmb   3
u0009    rmb   2
u000B    rmb   1
u000C    rmb   1
u000D    rmb   1
u000E    rmb   1
u000F    rmb   1
u0010    rmb   13
u001D    rmb   1
u001E    rmb   1
u001F    rmb   1
u0020    rmb   1
u0021    rmb   1
u0022    rmb   1
u0023    rmb   1
u0024    rmb   2
u0026    rmb   1
u0027    rmb   36
u004B    rmb   44
u0077    rmb   9
u0080    rmb   46
u00AE    rmb   85
size     equ   .
         fcb   $03 
name     equ   *
         fcs   /ACIA51/
         fcb   $04 
start    equ   *
         lbra  L002A
         lbra  L0086
         lbra  L00FE
         lbra  L012F
         lbra  L0146
         lbra  L0173
L0027    neg   <u0080
         dec   <u00AE
         fcb   $41 A
         stb   $01,x
         ldb   #$02
         stb   <u0022,u
         ldd   <$26,y
         andb  #$0F
         leax  <L007C,pcr
         ldb   b,x
         anda  #$F0
         sta   u0006,u
         ldx   u0001,u
         std   $02,x
         lda   ,x
         lda   ,x
         tst   $01,x
         lbmi  L00D2
         clra  
         clrb  
         std   <u001D,u
         std   <u0020,u
         sta   <u0023,u
         sta   <u001F,u
         std   <u0024,u
         ldd   u0001,u
         addd  #$0001
         leax  >L0027,pcr
         leay  >L0194,pcr
         os9   F$IRQ    
         bcs   L007B
         ldx   u0001,u
         ldb   u0006,u
         orb   #$01
         stb   $02,x
         clrb  
L007B    rts   
L007C    sync  
         lbra  L1798
         orcc  #$1C
         exg   x,f
L0084    bsr   L00D6
L0086    lda   <u0023,u
         ble   L00A1
         ldb   <u001F,u
         cmpb  #$0A
         bhi   L00A1
         ldb   u000F,u
         orb   #$80
         stb   <u0023,u
         ldb   u0006,u
         orb   #$05
         ldx   u0001,u
         stb   $02,x
L00A1    tst   <u0024,u
         bne   L00D2
         ldb   <u001E,u
         leax  <u0027,u
         orcc  #$50
         cmpb  <u001D,u
         beq   L0084
         abx   
         lda   ,x
         dec   <u001F,u
         incb  
         cmpb  #$4F
         bls   L00BF
         clrb  
L00BF    stb   <u001E,u
         clrb  
         ldb   u000E,u
         beq   L00CF
         stb   <$3A,y
         clr   u000E,u
         comb  
         ldb   #$F4
L00CF    andcc #$AF
         rts   
L00D2    comb  
         ldb   #$F6
         rts   
L00D6    pshs  x,b,a
         lda   u0004,u
         sta   u0005,u
         andcc #$AF
         ldx   #$0000
         os9   F$Sleep  
         ldx   <u004B
         ldb   <$36,x
         beq   L00EF
         cmpb  #$03
         bls   L00F8
L00EF    clra  
         lda   $0D,x
         bita  #$02
         bne   L00F8
         puls  pc,x,b,a
L00F8    leas  $06,s
         coma  
         rts   
L00FC    bsr   L00D6
L00FE    leax  <u0077,u
         ldb   <u0020,u
         abx   
         sta   ,x
         incb  
         cmpb  #$8B
         bls   L010D
         clrb  
L010D    orcc  #$50
         cmpb  <u0021,u
         beq   L00FC
         stb   <u0020,u
         lda   <u0022,u
         beq   L012B
         anda  #$FD
         sta   <u0022,u
         bne   L012B
         lda   u0006,u
         ora   #$05
         ldx   u0001,u
         sta   $02,x
L012B    andcc #$AF
L012D    clrb  
         rts   
L012F    cmpa  #$01
         bne   L013E
         ldb   <u001F,u
         beq   L00D2
         ldx   $06,y
         stb   $02,x
L013C    clrb  
         rts   
L013E    cmpa  #$06
         beq   L012D
L0142    comb  
         ldb   #$D0
         rts   
L0146    cmpa  #$1A
         bne   L0161
         lda   $05,y
         ldx   $06,y
         ldb   $05,x
         orcc  #$50
         tst   <u001F,u
         bne   L015C
         std   <u0024,u
         bra   L012B
L015C    andcc #$AF
         lbra  L01F8
L0161    cmpa  #$1B
         bne   L0142
         lda   $05,y
         cmpa  <u0024,u
         bne   L013C
         clr   <u0024,u
         rts   
L0170    lbsr  L00D6
L0173    ldx   <u004B
         lda   ,x
         sta   u0004,u
         sta   u0003,u
         ldb   <u0020,u
         orcc  #$50
         cmpb  <u0021,u
         bne   L0170
         lda   u0006,u
         ldx   u0001,u
         sta   $02,x
         andcc #$AF
         ldx   #$0000
         os9   F$IRQ    
         rts   
L0194    ldx   u0001,u
         tfr   a,b
         andb  #$60
         cmpb  <u0026,u
         beq   L01AB
         stb   <u0026,u
         bitb  #$60
         lbne  L02AE
         lbra  L029C
L01AB    bita  #$08
         bne   L01FD
         lda   <u0023,u
         bpl   L01C4
         anda  #$7F
         sta   ,x
         eora  u000F,u
         sta   <u0023,u
         lda   <u0022,u
         bne   L01EA
         clrb  
         rts   
L01C4    leay  <u0077,u
         ldb   <u0021,u
         cmpb  <u0020,u
         beq   L01E2
         clra  
         lda   d,y
         incb  
         cmpb  #$8B
         bls   L01D8
         clrb  
L01D8    stb   <u0021,u
         sta   ,x
         cmpb  <u0020,u
         bne   L01F0
L01E2    lda   <u0022,u
         ora   #$02
         sta   <u0022,u
L01EA    ldb   u0006,u
         orb   #$01
         stb   $02,x
L01F0    ldb   #$01
         lda   u0005,u
L01F4    beq   L01FB
         clr   u0005,u
L01F8    os9   F$Send   
L01FB    clrb  
         rts   
L01FD    bita  #$07
         beq   L0213
         tfr   a,b
         tst   ,x
         anda  #$07
         ora   u000E,u
         sta   u000E,u
         lda   $02,x
         sta   $01,x
         sta   $02,x
         bra   L01FB
L0213    lda   ,x
         beq   L022E
         cmpa  u000B,u
         beq   L028B
         cmpa  u000C,u
         beq   L028F
         cmpa  u000D,u
         beq   L0283
         cmpa  u000F,u
         beq   L029C
         cmpa  <u0010,u
         lbeq  L02AE
L022E    leax  <u0027,u
         ldb   <u001D,u
         abx   
         sta   ,x
         incb  
         cmpb  #$4F
         bls   L023D
         clrb  
L023D    cmpb  <u001E,u
         bne   L024A
         ldb   #$04
         orb   u000E,u
         stb   u000E,u
         bra   L01F0
L024A    stb   <u001D,u
         inc   <u001F,u
         tst   <u0024,u
         beq   L025D
         ldd   <u0024,u
         clr   <u0024,u
         bra   L01F8
L025D    lda   <u0010,u
         beq   L01F0
         ldb   <u001F,u
         cmpb  #$46
         bcs   L01F0
         ldb   <u0023,u
         bne   L01F0
         anda  #$7F
         sta   <u0010,u
         ora   #$80
         sta   <u0023,u
         ldb   u0006,u
         orb   #$05
         ldx   u0001,u
         stb   $02,x
         lbra  L01F0
L0283    ldx   u0009,u
         beq   L022E
         sta   $08,x
         bra   L022E
L028B    ldb   #$03
         bra   L0291
L028F    ldb   #$02
L0291    pshs  a
         lda   u0003,u
         lbsr  L01F4
         puls  a
         bra   L022E
L029C    lda   <u0022,u
         anda  #$FE
         sta   <u0022,u
         bne   L02AC
         lda   u0006,u
         ora   #$05
         sta   $02,x
L02AC    clrb  
         rts   
L02AE    lda   <u0022,u
         bne   L02B9
         ldb   u0006,u
         orb   #$01
         stb   $02,x
L02B9    ora   #$01
         sta   <u0022,u
         clrb  
         rts   
         emod
eom      equ   *
