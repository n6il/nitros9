         nam   AnsiFilt
         ttl   program module       

* Disassembled 2010/01/24 10:52:35 by Disasm v1.5 (C) 1988 by RML

         ifp1
         use   defsfile
         endc
tylg     set   Prgrm+Objct   
atrv     set   ReEnt+rev
rev      set   $01
         mod   eom,name,tylg,atrv,start,size
u0000    rmb   1
u0001    rmb   1
u0002    rmb   1
u0003    rmb   1
u0004    rmb   1
u0005    rmb   1
u0006    rmb   2
u0008    rmb   15
u0017    rmb   25
u0030    rmb   4
u0034    rmb   13
u0041    rmb   1
u0042    rmb   78
u0090    rmb   22
u00A6    rmb   1
u00A7    rmb   341
size     equ   .
name     equ   *
         fcs   /AnsiFilt/
         fcb   $0A 
start    equ   *
         lbsr  L0038
L0019    clra  
         leax  ,u
         ldy   #$0001
         os9   I$Read   
         bcs   L002C
         lda   ,u
         lbsr  L0049
         bra   L0019
L002C    cmpb  #$D3
         lbne  L0035
         bra   L0034
L0034    clrb  
L0035    os9   F$Exit   
L0038    clr   u0005,u
         leax  u0008,u
         stx   u0006,u
         lda   #$01
         sta   u0001,u
         sta   u0002,u
         sta   u0003,u
         sta   u0004,u
         rts   
L0049    cmpa  #$20
         bcs   L007A
         tst   <u0005
         lbne  L00F2
         pshs  a
         leax  ,s
         ldy   #$0001
         lda   #$01
         os9   I$Write  
         inc   u0001,u
         lda   u0001,u
         cmpa  #$80
         bls   L0078
         lda   #$01
         sta   u0001,u
         inc   u0002,u
         lda   u0002,u
         cmpa  #$17
         bls   L0078
         lda   #$17
         sta   u0002,u
L0078    puls  pc,a
L007A    cmpa  #$1B
         beq   L008F
         cmpa  #$07
         beq   L009C
         cmpa  #$08
         beq   L00AB
         cmpa  #$0A
         beq   L00C4
         cmpa  #$0D
         beq   L00DF
         rts   
L008F    lda   #$01
         sta   u0005,u
         leax  u0008,u
         lda   #$1B
         sta   ,x+
         stx   u0006,u
         rts   
L009C    pshs  a
         leax  ,s
         ldy   #$0001
         lda   #$01
         os9   I$Write  
         puls  pc,a
L00AB    pshs  a
         dec   u0001,u
         bne   L00B7
         lda   #$01
         sta   u0001,u
         bra   L00C2
L00B7    leax  ,s
         ldy   #$0001
         lda   #$01
         os9   I$Write  
L00C2    puls  pc,a
L00C4    pshs  a
         leax  ,s
         ldy   #$0001
         lda   #$01
         os9   I$Write  
         inc   u0002,u
         lda   u0002,u
         cmpa  #$17
         bls   L00DD
         lda   #$17
         sta   u0002,u
L00DD    puls  pc,a
L00DF    pshs  a
         leax  ,s
         ldy   #$0001
         lda   #$01
         os9   I$Write  
         lda   #$01
         sta   u0001,u
         puls  pc,a
L00F2    cmpa  #$41
         bcs   L0101
         cmpa  #$5B
         beq   L0101
         cmpa  #$7A
         bhi   L0101
         lbra  L0108
L0101    ldx   u0006,u
         sta   ,x+
         stx   u0006,u
         rts   
L0108    clr   u0005,u
         ldx   u0006,u
         sta   ,x+
         stx   u0006,u
         cmpa  #$48
         lbeq  L0199
         cmpa  #$41
         lbeq  L01D3
         cmpa  #$42
         lbeq  L01FE
         cmpa  #$43
         lbeq  L022B
         cmpa  #$44
         lbeq  L0259
         cmpa  #$66
         lbeq  L0199
         cmpa  #$73
         lbeq  L027D
         cmpa  #$75
         lbeq  L0286
         cmpa  #$4A
         lbeq  L0169
         cmpa  #$6B
         lbeq  L0187
         cmpa  #$6D
         lbeq  L02AF
L0152    leax  u0008,u
         pshs  x
         ldd   u0006,u
         subd  ,s
         leas  $02,s
         tfr   d,y
         leax  u0008,u
         lda   #$01
         os9   I$Write  
         clr   u0005,u
         rts   
         inc   <u0017
         aim   #$2B,<u00A6
         suba  #$81
         leas  $06,y
         subb  -$10,y
         bsr   L0174
         sbcb  >$108E
         neg   <u0001
         lda   #$01
         os9   I$Write  
         lda   #$01
         sta   u0001,u
         sta   u0002,u
         rts   
         lsr   <u0017
         aim   #$0D,<u0030
         bsr   L018C
         eorb  >$108E
         neg   <u0001
         lda   #$01
         os9   I$Write  
         rts   
L0198    aim   #$17,<u0001
         addb  >$1702
         lsl   <u00A7
         fcb   $42 B
         adda  #$1F
         pshs  a
         lda   ,x+
         cmpa  #$3B
         beq   L01B0
         puls  a
         lbra  L0152
L01B0    lbsr  L03A7
         sta   u0001,u
         adda  #$1F
         pshs  a
         leax  >L0198,pcr
         ldy   #$0001
         lda   #$01
         os9   I$Write  
         leax  ,s
         ldy   #$0002
         os9   I$Write  
         leas  $02,s
         rts   
L01D2    rol   <u0017
         oim   #$C1,<u0017
         oim   #$CE,<u0034
         aim   #$A6,<u0042
         suba  ,s
         bgt   L01E3
         lda   #$01
L01E3    sta   u0002,u
         leax  >L01D2,pcr
         ldy   #$0001
         lda   #$01
L01EF    tst   ,s
         beq   L01FA
         os9   I$Write  
         dec   ,s
         bne   L01EF
L01FA    leas  $01,s
         rts   
L01FD    dec   <u0017
         oim   #$96,<u0017
         oim   #$A3,<u0034
         aim   #$A6,<u0042
         adda  ,s
         cmpa  #$17
         bls   L021C
         suba  #$17
         pshs  a
         lda   $01,s
         suba  ,s
         leas  $01,s
         sta   ,s
         lda   #$17
L021C    sta   u0002,u
         leax  >L01FD,pcr
         ldy   #$0001
         lda   #$01
         bra   L01EF
L022A    ror   <u0017
         oim   #$69,<u0017
         oim   #$76,<u0034
         aim   #$A6,<u0041
         adda  ,s
         cmpa  #$50
         bls   L0249
         suba  #$50
         pshs  a
         lda   $01,s
         suba  ,s
         sta   $01,s
         leas  $01,s
         lda   #$50
L0249    sta   u0001,u
         leax  >L022A,pcr
         ldy   #$0001
         lda   #$01
         lbra  L01EF
L0258    lsl   <u0017
         oim   #$3B,<u0017
         oim   #$48,<u0034
         aim   #$A6,<u0041
         suba  ,s
         bgt   L026E
         deca  
         adda  ,s
         sta   ,s
         lda   #$01
L026E    sta   u0001,u
         leax  >L0258,pcr
         ldy   #$0001
         lda   #$01
         lbra  L01EF
L027D    lda   u0001,u
         sta   u0003,u
         lda   u0002,u
         sta   u0004,u
         rts   
L0286    lda   u0004,u
         sta   u0002,u
         adda  #$1F
         pshs  a
         lda   u0003,u
         sta   u0001,u
         adda  #$1F
         pshs  a
         leax  >L0198,pcr
         ldy   #$0001
         lda   #$01
         os9   I$Write  
         leax  ,s
         ldy   #$0002
         os9   I$Write  
         leas  $02,s
         rts   
L02AF    lbsr  L0397
L02B2    lda   ,x
         cmpa  #$6D
         beq   L02C3
         lbsr  L03A7
         bsr   L02C4
         lda   ,x+
         cmpa  #$3B
         beq   L02B2
L02C3    rts   
L02C4    pshs  x
         cmpa  #$00
         beq   L02F2
         cmpa  #$04
         beq   L0303
         cmpa  #$05
         beq   L0314
         cmpa  #$07
         beq   L031C
         cmpa  #$08
         beq   L0328
         cmpa  #$28
         lbge  L0365
         cmpa  #$1E
         bge   L0339
         puls  pc,x
L02E6    fcb   $1B 
         leas  $00,x
         fcb   $1B 
         leau  $02,x
         tfr   y,x
         tfr   y,u
         tfr   y,pc
L02F2    leax  >L02E6,pcr
         ldy   #$000C
         lda   #$01
         os9   I$Write  
         puls  pc,x
L0301    tfr   y,y
L0303    leax  >L0301,pcr
L0307    ldy   #$0002
         lda   #$01
         os9   I$Write  
         puls  pc,x
L0312    tfr   y,s
L0314    leax  >L0312,pcr
         bra   L0307
L031A    tfr   y,d
L031C    leax  >L031A,pcr
         bra   L0307
L0322    fcb   $1B 
         leas  $02,x
         fcb   $1B 
         leau  $02,x
L0328    leax  >L0322,pcr
         ldy   #$0006
         lda   #$01
         os9   I$Write  
         puls  pc,x
L0337    fcb   $1B 
         leas  ,x++
         bcs   L036B
         aim   #$35,<u0090
         suba  #$1E
         pshs  a
         leax  >L0337,pcr
         ldy   #$0002
         lda   #$01
         os9   I$Write  
         puls  a
         leax  >L038F,pcr
         leax  a,x
         ldy   #$0001
         lda   #$01
         os9   I$Write  
         puls  pc,x
L0363    fcb   $1B 
         leau  ,x++
         ble   L0397
         aim   #$35,<u0090
L036B    suba  #$28
         pshs  a
         leax  >L0363,pcr
         ldy   #$0002
         lda   #$01
         os9   I$Write  
         leax  >L038F,pcr
         puls  a
         leax  a,x
         ldy   #$0001
         lda   #$01
         os9   I$Write  
         puls  pc,x
L038F    aim   #$04,<u0003
         eim   #$01,<u0006
         asr   <u0000
L0397    leax  u0008,u
         leax  $01,x
         lda   ,x+
         cmpa  #$5B
         beq   L03A6
         leas  $02,s
         lbra  L0152
L03A6    rts   
L03A7    lda   ,x
         cmpa  #$30
         blt   L03E7
         cmpa  #$39
         bgt   L03E7
L03B1    lda   ,x+
         cmpa  #$30
         blt   L03BD
         cmpa  #$39
         bgt   L03BD
         bra   L03B1
L03BD    leax  -$01,x
         tfr   x,y
         pshs  x
         ldb   #$01
         ldx   #$0000
L03C8    pshs  b
         lda   ,-y
         cmpa  #$30
         blt   L03DF
         cmpa  #$39
         bgt   L03DF
         suba  #$30
         mul   
         abx   
         puls  b
         lda   #$0A
         mul   
         bra   L03C8
L03DF    puls  b
         tfr   x,d
         tfr   b,a
         puls  pc,x
L03E7    lda   #$01
         rts   
         emod
eom      equ   *
         end
