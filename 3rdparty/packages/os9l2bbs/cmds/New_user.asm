         nam   New_user
         ttl   program module       

* Disassembled 2010/01/24 10:44:57 by Disasm v1.5 (C) 1988 by RML

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
u0004    rmb   2
u0006    rmb   2
u0008    rmb   1
u0009    rmb   1
u000A    rmb   1
u000B    rmb   2
u000D    rmb   4
u0011    rmb   15
u0020    rmb   5
u0025    rmb   8
u002D    rmb   7
u0034    rmb   17
u0045    rmb   9
u004E    rmb   1
u004F    rmb   1
u0050    rmb   5
u0055    rmb   4
u0059    rmb   11
u0064    rmb   132
u00E8    rmb   119
u015F    rmb   2
u0161    rmb   58
u019B    rmb   1
u019C    rmb   3
u019F    rmb   1420
size     equ   .
name     equ   *
         fcs   /New_user/
         fcb   $01 
L0016    fcb   $A6 &
         fcb   $A0 
         fcb   $A7 '
         fcb   $C0 @
         fcb   $30 0
         fcb   $1F 
         fcb   $26 &
         fcb   $F8 x
         fcb   $39 9
start    equ   *
         pshs  y
         pshs  u
         clra  
         clrb  
L0025    sta   ,u+
         decb  
         bne   L0025
         ldx   ,s
         leau  ,x
         leax  >$03AB,x
         pshs  x
         leay  >L15F9,pcr
         ldx   ,y++
         beq   L0040
         bsr   L0016
         ldu   $02,s
L0040    leau  >u0001,u
         ldx   ,y++
         beq   L004B
         bsr   L0016
         clra  
L004B    cmpu  ,s
         beq   L0054
         sta   ,u+
         bra   L004B
L0054    ldu   $02,s
         ldd   ,y++
         beq   L0061
         leax  >L0000,pcr
         lbsr  L0164
L0061    ldd   ,y++
         beq   L006A
         leax  ,u
         lbsr  L0164
L006A    leas  $04,s
         puls  x
         stx   >u019F,u
         sty   >u015F,u
         ldd   #$0001
         std   >u019B,u
         leay  >u0161,u
         leax  ,s
         lda   ,x+
L0086    ldb   >u019C,u
         cmpb  #$1D
         beq   L00E2
L008E    cmpa  #$0D
         beq   L00E2
         cmpa  #$20
         beq   L009A
         cmpa  #$2C
         bne   L009E
L009A    lda   ,x+
         bra   L008E
L009E    cmpa  #$22
         beq   L00A6
         cmpa  #$27
         bne   L00C4
L00A6    stx   ,y++
         inc   >u019C,u
         pshs  a
L00AE    lda   ,x+
         cmpa  #$0D
         beq   L00B8
         cmpa  ,s
         bne   L00AE
L00B8    puls  b
         clr   -$01,x
         cmpa  #$0D
         beq   L00E2
         lda   ,x+
         bra   L0086
L00C4    leax  -$01,x
         stx   ,y++
         leax  $01,x
         inc   >u019C,u
L00CE    cmpa  #$0D
         beq   L00DE
         cmpa  #$20
         beq   L00DE
         cmpa  #$2C
         beq   L00DE
         lda   ,x+
         bra   L00CE
L00DE    clr   -$01,x
         bra   L0086
L00E2    leax  >u015F,u
         pshs  x
         ldd   >u019B,u
         pshs  b,a
         leay  ,u
         bsr   L00FC
         lbsr  L017E
         clr   ,-s
         clr   ,-s
         lbsr  L15ED
L00FC    leax  >$03AB,y
         stx   >$01A9,y
         sts   >$019D,y
         sts   >$01AB,y
         ldd   #$FF82
L0111    leax  d,s
         cmpx  >$01AB,y
         bcc   L0123
         cmpx  >$01A9,y
         bcs   L013D
         stx   >$01AB,y
L0123    rts   
L0124    bpl   L0150
         bpl   L0152
         bra   L017D
         lsrb  
         fcb   $41 A
         coma  
         fcb   $4B K
         bra   L017F
         rorb  
         fcb   $45 E
         fcb   $52 R
         rora  
         inca  
         clra  
         asrb  
         bra   L0163
         bpl   L0165
         bpl   L014A
L013D    leax  <L0124,pcr
         ldb   #$CF
         pshs  b
         lda   #$02
         ldy   #$0064
L014A    os9   I$WritLn 
         clr   ,-s
         lbsr  L15F3
L0152    ldd   >$019D,y
         subd  >$01AB,y
         rts   
         ldd   >$01AB,y
         subd  >$01A9,y
L0163    rts   
L0164    pshs  x
         leax  d,y
         leax  d,x
         pshs  x
L016C    ldd   ,y++
         leax  d,u
         ldd   ,x
         addd  $02,s
         std   ,x
         cmpy  ,s
         bne   L016C
         leas  $04,s
L017D    rts   
L017E    pshs  u
         ldd   #$FFB3
         lbsr  L0111
         leas  -$03,s
         leax  >L03D2,pcr
         pshs  x
         ldx   $0B,s
         ldd   $02,x
         pshs  b,a
         lbsr  L0884
         leas  $04,s
         std   $01,s
         bne   L01AE
         ldd   >$01AD,y
         pshs  b,a
         leax  >L03D4,pcr
         pshs  x
         lbsr  L03B0
         leas  $04,s
L01AE    ldd   #$004E
         lbra  L02E1
L01B4    leax  >L03E5,pcr
         pshs  x
         lbsr  L095A
         leas  $02,s
         leax  >L042F,pcr
         pshs  x
         lbsr  L095A
         leas  $02,s
         leax  >L0466,pcr
         pshs  x
         lbsr  L095A
         leas  $02,s
         leax  >L04A5,pcr
         pshs  x
         lbsr  L095A
         leas  $02,s
         leax  >L04F0,pcr
         pshs  x
         lbsr  L095A
         leas  $02,s
         leax  >$01AF,y
         pshs  x
         lbsr  L08D6
         leas  $02,s
         leax  >L0510,pcr
         pshs  x
         lbsr  L095A
         leas  $02,s
         leax  >$01FF,y
         pshs  x
         lbsr  L08D6
         leas  $02,s
         leax  >L0530,pcr
         pshs  x
         lbsr  L095A
         leas  $02,s
         leax  >$024F,y
         pshs  x
         lbsr  L08D6
         leas  $02,s
         leax  >L0550,pcr
         pshs  x
         lbsr  L095A
         leas  $02,s
         leax  >$029F,y
         pshs  x
         lbsr  L08D6
         leas  $02,s
         leax  >L0570,pcr
         pshs  x
         lbsr  L095A
         leas  $02,s
         leax  >$02EF,y
         pshs  x
         lbsr  L08D6
         leas  $02,s
         leax  >L0590,pcr
         pshs  x
         lbsr  L095A
         leas  $02,s
         leax  >$033F,y
         pshs  x
         lbsr  L08D6
         leas  $02,s
         leax  >$02EF,y
         pshs  x
         leax  >$01AF,y
         pshs  x
         leax  >L05B0,pcr
         pshs  x
         lbsr  L095A
         leas  $06,s
         leax  >$024F,y
         pshs  x
         leax  >$01FF,y
         pshs  x
         leax  >L05C7,pcr
         pshs  x
         lbsr  L095A
         leas  $06,s
         leax  >$029F,y
         pshs  x
         leax  >L05DC,pcr
         pshs  x
         lbsr  L095A
         leas  $04,s
         leax  >$033F,y
         pshs  x
         leax  >L05E7,pcr
         pshs  x
         lbsr  L095A
         leas  $04,s
         leax  >L05F4,pcr
         pshs  x
         lbsr  L095A
         leas  $02,s
         leax  >$001B,y
         pshs  x
         lbsr  L0F89
         leas  $02,s
         ldd   #$0001
         pshs  b,a
         leax  $02,s
         pshs  x
         clra  
         clrb  
         pshs  b,a
         lbsr  L149A
         leas  $06,s
         ldb   ,s
         clra  
         andb  #$DF
L02E1    stb   ,s
         ldb   ,s
         cmpb  #$59
         lbne  L01B4
         leax  >L0611,pcr
         pshs  x
         lbsr  L095A
         leas  $02,s
         leax  >L0628,pcr
         pshs  x
         ldd   $03,s
         pshs  b,a
         lbsr  L096C
         leas  $04,s
         leax  >L0636,pcr
         pshs  x
         ldd   $03,s
         pshs  b,a
         lbsr  L096C
         leas  $04,s
         leax  >$01AF,y
         pshs  x
         leax  >L066D,pcr
         pshs  x
         ldd   $05,s
         pshs  b,a
         lbsr  L096C
         leas  $06,s
         leax  >$01FF,y
         pshs  x
         leax  >L0682,pcr
         pshs  x
         ldd   $05,s
         pshs  b,a
         lbsr  L096C
         leas  $06,s
         leax  >$024F,y
         pshs  x
         leax  >L0697,pcr
         pshs  x
         ldd   $05,s
         pshs  b,a
         lbsr  L096C
         leas  $06,s
         leax  >$029F,y
         pshs  x
         leax  >L06AC,pcr
         pshs  x
         ldd   $05,s
         pshs  b,a
         lbsr  L096C
         leas  $06,s
         leax  >$02EF,y
         pshs  x
         leax  >L06C1,pcr
         pshs  x
         ldd   $05,s
         pshs  b,a
         lbsr  L096C
         leas  $06,s
         leax  >$033F,y
         pshs  x
         leax  >L06D6,pcr
         pshs  x
         ldd   $05,s
         pshs  b,a
         lbsr  L096C
         leas  $06,s
         leax  >L06EB,pcr
         pshs  x
         ldd   $03,s
         pshs  b,a
         lbsr  L096C
         leas  $04,s
         leax  >L06ED,pcr
         pshs  x
         lbsr  L095A
         leas  $02,s
         leas  $03,s
         puls  pc,u
L03B0    pshs  u
         ldd   #$FFB8
         lbsr  L0111
         ldd   $04,s
         pshs  b,a
         leax  >L072A,pcr
         pshs  x
         lbsr  L095A
         leas  $04,s
         ldd   $06,s
         pshs  b,a
         lbsr  L15ED
         leas  $02,s
         puls  pc,u
L03D2    oim   #u0000,$03,u
         oim   #$6E,$0E,s
         clr   -$0C,s
         bra   L044B
         neg   >$656E
         bra   L0447
         rol   $0C,s
         eim   #$00,$0D,x
         lsrb  
         clr   $00,y
         aim   #$65,$00,y
         ror   >$616C
         rol   $04,s
         oim   #$74,$05,s
         lsr   $00,y
         clr   $0E,s
         bra   L046E
         lsl   $09,s
         com   >$2073
         rol   >$7374
         eim   #$6D,$00,y
         rol   >$6F75
         bra   L0477
         eim   #$73,>$7420
         eim   #$6E,-$0C,s
         eim   #$72,$00,y
         lsr   >$6865
         bra   L047F
         clr   $0C,s
         inc   $0F,s
         asr   >$696E
         asr   $00,y
         rol   $0E,s
         ror   $0F,s
         aim   #$6D,>$6174
         rol   $0F,s
         jmp   $0D,x
         neg   <u0050
         inc   $05,s
         oim   #$73,$05,s
         bra   L049C
         jmp   -$0C,s
         eim   #$72,$00,y
         lsr   >$6865
         bra   L04AA
         jmp   $06,s
         clr   -$0E,s
         tst   $01,s
L0447    lsr   >$696F
         jmp   $00,y
         oim   #$73,$00,y
         com   $0F,s
         aim   #$72,>$6563
         lsr   >$6C79
         bra   L04BB
         com   >$2070
         clr   -$0D,s
         com   >$6962
         inc   $05,s
         tst   <u0000
L0466    oim   #$6E,-$07,s
         bra   L04D1
         oim   #$6C,-$0D,s
L046E    eim   #$20,$09,s
         jmp   $06,s
         clr   -$0E,s
         tst   $01,s
L0477    lsr   >$696F
         jmp   $00,y
         asr   >$696C
L047F    inc   $00,y
         aim   #$65,>$7375
         inc   -$0C,s
         bra   L04F2
         jmp   $00,y
         rol   >$6F75
         aim   #$20,>$6E6F
         lsr   >$2062
         eim   #$69,$0E,s
         asr   $00,y
         ror   >$616C
         rol   $04,s
         oim   #$74,$05,s
         lsr   $0D,x
         neg   <u002D
         blt   L04D5
         blt   L04D7
L04AA    blt   L04D9
         blt   L04DB
         blt   L04DD
         blt   L04DF
         blt   L04E1
         blt   L04E3
         blt   L04E5
         blt   L04E7
         blt   L04E9
         blt   L04EB
         blt   L04ED
         blt   L04EF
         blt   L04F1
         blt   L04F3
         blt   L04F5
         blt   L04F7
         blt   L04F9
         blt   L04FB
         blt   L04FD
         blt   L04FF
         blt   L0501
         blt   L0503
         blt   L0505
         blt   L0507
         blt   L0509
         blt   L050B
         blt   L050D
         blt   L050F
         blt   L0511
         blt   L0513
         blt   L0515
         blt   L0517
         blt   L0519
         blt   L051B
         tst   <u0000
L04F0    fcb   $45 E
L04F1    jmp   -$0C,s
L04F3    eim   #$72,$00,y
         rol   >$6F75
L04F9    aim   #$20,>$6E61
L04FD    tst   $05,s
L04FF    abx   
         mul   
L0501    mul   
         mul   
L0503    mul   
         mul   
L0505    mul   
         mul   
L0507    mul   
         mul   
L0509    mul   
         mul   
L050B    mul   
         mul   
L050D    mul   
         fcb   $3E >
L050F    neg   <u0045
L0511    jmp   -$0C,s
L0513    eim   #$72,$00,y
         rol   >$6F75
L0519    aim   #$20,>$6369
         lsr   >$793A
         mul   
         mul   
         mul   
         mul   
         mul   
         mul   
         mul   
         mul   
         mul   
         mul   
         mul   
         mul   
         mul   
         mul   
         fcb   $3E >
         neg   <u0045
         jmp   -$0C,s
         eim   #$72,$00,y
         rol   >$6F75
         aim   #$20,>$7374
         oim   #$74,$05,s
         abx   
         mul   
         mul   
         mul   
         mul   
         mul   
         mul   
         mul   
         mul   
         mul   
         mul   
         mul   
         mul   
         mul   
         fcb   $3E >
         neg   <u0045
         jmp   -$0C,s
         eim   #$72,$00,y
         rol   >$6F75
         aim   #$20,>$7068
         clr   $0E,s
         eim   #$20,$03,y
         abx   
         mul   
         mul   
         mul   
         mul   
         mul   
         mul   
         mul   
         mul   
         mul   
         mul   
         mul   
         fcb   $3E >
         neg   <u0045
         jmp   -$0C,s
         eim   #$72,$00,y
         rol   >$6F75
         aim   #$20,>$616C
         rol   $01,s
         com   >$2028
         rol   $06,s
         bra   L05E7
         jmp   -$07,s
         bvs   L05C4
         mul   
         mul   
         mul   
         mul   
         fcb   $3E >
         neg   <u0045
         jmp   -$0C,s
         eim   #$72,$00,y
         rol   >$6F75
         aim   #$20,>$6465
         com   >$6972
         eim   #$64,$00,y
         neg   >$6173
         com   >$776F
         aim   #$64,>$3A3D
         mul   
         fcb   $3E >
         neg   <u000D
         tst   <u0059
         clr   -$0B,s
         bra   L0618
         aim   #$65,>$2025
         com   >$2061
         inc   $09,s
         oim   #$73,$00,y
         bcs   L0638
         tst   <u0000
L05C7    coma  
         oim   #$6C,$0C,s
         rol   $0E,s
         asr   $00,y
         ror   -$0E,s
         clr   $0D,s
         bra   L05FA
         com   >$2C20
         bcs   L064D
         tst   <u0000
L05DC    negb  
         lsl   $0F,s
         jmp   $05,s
         bra   L0606
         bcs   L0658
         tst   <u0000
L05E7    negb  
         oim   #$73,-$0D,s
         asr   >$6F72
         lsr   -$06,y
         bcs   L0665
         tst   <u0000
L05F4    rola  
         com   >$2074
         lsl   $09,s
L05FA    com   >$2069
         jmp   $06,s
         clr   -$0E,s
         tst   $01,s
         lsr   >$696F
L0606    jmp   $00,y
         com   $0F,s
         aim   #$72,>$6563
         lsr   >$3F00
L0611    tst   <u004F
         jmp   $05,s
         bra   L0684
         clr   $0D,s
         eim   #$6E,-$0C,s
         bra   L068E
         inc   $05,s
         oim   #$73,$05,s
         bgt   L0653
         bgt   L0634
         neg   <u004E
         eim   #$77,$00,y
         eim   #$73,>$6572
         bra   L069E
         clr   $07,s
L0634    tst   <u0000
L0636    blt   L0665
L0638    blt   L0667
         blt   L0669
         blt   L066B
         blt   L066D
         blt   L066F
         blt   L0671
         blt   L0673
         blt   L0675
         blt   L0677
         blt   L0679
         blt   L067B
         blt   L067D
         blt   L067F
         blt   L0681
         blt   L0683
         blt   L0685
L0658    blt   L0687
         blt   L0689
         blt   L068B
         blt   L068D
         blt   L068F
         blt   L0691
         blt   L0693
         blt   L0695
         blt   L0697
         blt   L0679
         neg   <u0055
         com   >$6572
L0671    bra   L06E1
L0673    oim   #$6D,$05,s
         bra   L0698
         bra   L069A
         bra   L069C
         bra   L06B8
         bcs   L06F3
         tst   <u0000
L0682    coma  
L0683    rol   -$0C,s
L0685    rol   >$2020
         bra   L06AA
         bra   L06AC
         bra   L06AE
L068E    bra   L06B0
         bra   L06B2
         abx   
L0693    bcs   L0708
L0695    tst   <u0000
L0697    comb  
L0698    lsr   >$6174
         eim   #$20,$00,y
L069E    bra   L06C0
         bra   L06C2
         bra   L06C4
         bra   L06C6
         bra   L06E2
         bcs   L071D
L06AA    tst   <u0000
L06AC    negb  
         lsl   $0F,s
         jmp   $05,s
         bra   L06D6
         bra   L06D5
         bra   L06D7
         bra   L06D9
         bra   L06DB
         bra   L06F7
         bcs   L0732
         tst   <u0000
L06C1    lsra  
L06C2    eim   #$73,$09,s
         aim   #$65,>$6420
         oim   #$6C,$09,s
         oim   #$73,$00,y
         bra   L06F1
         abx   
         bcs   L0747
         tst   <u0000
L06D6    lsra  
L06D7    eim   #$73,$09,s
         aim   #$65,>$6420
         neg   >$6173
L06E1    com   >$776F
         aim   #$64,>$3A25
         com   >$0D00
L06EB    tst   <u0000
L06ED    lsrb  
         lsl   $01,s
         jmp   $0B,s
         bra   L076D
         clr   -$0B,s
         bge   L0718
         lsr   >$6865
         bra   L0770
         rol   >$736F
         neg   >$2077
         rol   $0C,s
         inc   $00,y
         ror   >$616C
         rol   $04,s
         oim   #$74,$05,s
         bra   L078A
         clr   -$0B,s
         bra   L0776
         com   >$2073
L0718    clr   $0F,s
         jmp   $00,y
         oim   #$73,$00,y
         neg   >$6F73
         com   >$6962
         inc   $05,s
         bgt   L0736
         neg   <u0025
         com   >$0D00
L072E    pshs  u
         leau  >$000E,y
L0734    ldd   u0006,u
L0736    clra  
         andb  #$03
         lbeq  L07A5
         leau  u000D,u
         pshs  u
         leax  >$00DE,y
         cmpx  ,s++
L0747    bhi   L0734
         ldd   #$00C8
         std   >$01AD,y
         lbra  L07A9
         puls  pc,u
L0755    pshs  u
         ldu   $08,s
         bne   L075F
         bsr   L072E
         tfr   d,u
L075F    stu   -$02,s
         beq   L07A9
         ldd   $04,s
         std   u0008,u
         ldx   $06,s
         ldb   $01,x
         cmpb  #$2B
L076D    beq   L0777
         ldx   $06,s
         ldb   $02,x
         cmpb  #$2B
         bne   L077D
L0777    ldd   u0006,u
         orb   #$03
         bra   L079B
L077D    ldd   u0006,u
         pshs  b,a
         ldb   [<$08,s]
         cmpb  #$72
         beq   L078F
         ldb   [<$08,s]
         cmpb  #$64
         bne   L0794
L078F    ldd   #$0001
         bra   L0797
L0794    ldd   #$0002
L0797    ora   ,s+
         orb   ,s+
L079B    std   u0006,u
         ldd   u0002,u
         addd  u000B,u
         std   u0004,u
         std   ,u
L07A5    tfr   u,d
         puls  pc,u
L07A9    clra  
         clrb  
         puls  pc,u
L07AD    pshs  u
         ldu   $04,s
         leas  -$04,s
         clra  
         clrb  
         std   ,s
         ldx   $0A,s
         ldb   $01,x
         sex   
         tfr   d,x
         bra   L07DE
L07C0    ldx   $0A,s
         ldb   $02,x
         cmpb  #$2B
         bne   L07CD
         ldd   #$0007
         bra   L07D5
L07CD    ldd   #$0004
         bra   L07D5
L07D2    ldd   #$0003
L07D5    std   ,s
         bra   L07EE
L07D9    leax  $04,s
         lbra  L0846
L07DE    stx   -$02,s
         beq   L07EE
         cmpx  #$0078
         beq   L07C0
         cmpx  #$002B
         beq   L07D2
         bra   L07D9
L07EE    ldb   [<$0A,s]
         sex   
         tfr   d,x
         lbra  L0853
L07F7    ldd   ,s
         orb   #$01
         bra   L0839
L07FD    ldd   ,s
         orb   #$02
         pshs  b,a
         pshs  u
         lbsr  L141E
         leas  $04,s
         std   $02,s
         cmpd  #$FFFF
         beq   L0828
         ldd   #$0002
         pshs  b,a
         clra  
         clrb  
         pshs  b,a
         pshs  b,a
         ldd   $08,s
         pshs  b,a
         lbsr  L14F4
         leas  $08,s
         bra   L086D
L0828    ldd   ,s
         orb   #$02
         pshs  b,a
         pshs  u
         lbsr  L143F
         bra   L0840
L0835    ldd   ,s
         orb   #$81
L0839    pshs  b,a
         pshs  u
         lbsr  L141E
L0840    leas  $04,s
         std   $02,s
         bra   L086D
L0846    leas  -$04,x
L0848    ldd   #$00CB
         std   >$01AD,y
         clra  
         clrb  
         bra   L086F
L0853    cmpx  #$0072
         lbeq  L07F7
         cmpx  #$0061
         lbeq  L07FD
         cmpx  #$0077
         beq   L0828
         cmpx  #$0064
         beq   L0835
         bra   L0848
L086D    ldd   $02,s
L086F    leas  $04,s
         puls  pc,u
         pshs  u
         clra  
         clrb  
         pshs  b,a
         ldd   $08,s
         pshs  b,a
         ldd   $08,s
         pshs  b,a
         lbra  L08CF
L0884    pshs  u
         ldd   $06,s
         pshs  b,a
         ldd   $06,s
         pshs  b,a
         lbsr  L07AD
         leas  $04,s
         tfr   d,u
         cmpu  #$FFFF
         bne   L089F
         clra  
         clrb  
         bra   L08D4
L089F    clra  
         clrb  
         bra   L08C7
         pshs  u
         ldd   $08,s
         pshs  b,a
         lbsr  L0F4F
         leas  $02,s
         ldd   $06,s
         pshs  b,a
         ldd   $06,s
         pshs  b,a
         lbsr  L07AD
         leas  $04,s
         tfr   d,u
         stu   -$02,s
         bge   L08C5
         clra  
         clrb  
         bra   L08D4
L08C5    ldd   $08,s
L08C7    pshs  b,a
         ldd   $08,s
         pshs  b,a
         pshs  u
L08CF    lbsr  L0755
         leas  $06,s
L08D4    puls  pc,u
L08D6    pshs  u,b,a
         ldu   $06,s
         bra   L08E0
L08DC    ldd   ,s
         stb   ,u+
L08E0    leax  >$000E,y
         pshs  x
         lbsr  L1079
         leas  $02,s
         std   ,s
         cmpd  #$000D
         beq   L08FB
         ldd   ,s
         cmpd  #$FFFF
         bne   L08DC
L08FB    ldd   ,s
         cmpd  #$FFFF
         bne   L0907
         clra  
         clrb  
         bra   L090D
L0907    clra  
         clrb  
         stb   ,u
         ldd   $06,s
L090D    leas  $02,s
         puls  pc,u
         pshs  u
         ldu   $06,s
         leas  -$04,s
         ldd   $08,s
         std   ,s
         bra   L092B
L091D    ldd   $02,s
         ldx   ,s
         leax  $01,x
         stx   ,s
         stb   -$01,x
         cmpb  #$0D
         beq   L0944
L092B    tfr   u,d
         leau  -u0001,u
         std   -$02,s
         ble   L0944
         ldd   $0C,s
         pshs  b,a
         lbsr  L1079
         leas  $02,s
         std   $02,s
         cmpd  #$FFFF
         bne   L091D
L0944    clra  
         clrb  
         stb   [,s]
         ldd   $02,s
         cmpd  #$FFFF
         bne   L0954
         clra  
         clrb  
         bra   L0956
L0954    ldd   $08,s
L0956    leas  $04,s
         puls  pc,u
L095A    pshs  u
         leax  >$001B,y
         stx   >$038F,y
         leax  $06,s
         pshs  x
         ldd   $06,s
         bra   L097A
L096C    pshs  u
         ldd   $04,s
         std   >$038F,y
         leax  $08,s
         pshs  x
         ldd   $08,s
L097A    pshs  b,a
         leax  >L0E32,pcr
         pshs  x
         bsr   L09AC
         leas  $06,s
         puls  pc,u
         pshs  u
         ldd   $04,s
         std   >$038F,y
         leax  $08,s
         pshs  x
         ldd   $08,s
         pshs  b,a
         leax  >L0E45,pcr
         pshs  x
         bsr   L09AC
         leas  $06,s
         clra  
         clrb  
         stb   [>$038F,y]
         ldd   $04,s
         puls  pc,u
L09AC    pshs  u
         ldu   $06,s
         leas  -$0B,s
         bra   L09C4
L09B4    ldb   $08,s
         lbeq  L0BF5
         ldb   $08,s
         sex   
         pshs  b,a
         jsr   [<$11,s]
         leas  $02,s
L09C4    ldb   ,u+
         stb   $08,s
         cmpb  #$25
         bne   L09B4
         ldb   ,u+
         stb   $08,s
         clra  
         clrb  
         std   $02,s
         std   $06,s
         ldb   $08,s
         cmpb  #$2D
         bne   L09E9
         ldd   #$0001
         std   >$03A5,y
         ldb   ,u+
         stb   $08,s
         bra   L09EF
L09E9    clra  
         clrb  
         std   >$03A5,y
L09EF    ldb   $08,s
         cmpb  #$30
         bne   L09FA
         ldd   #$0030
         bra   L09FD
L09FA    ldd   #$0020
L09FD    std   >$03A7,y
         bra   L0A1D
L0A03    ldd   $06,s
         pshs  b,a
         ldd   #$000A
         lbsr  L132D
         pshs  b,a
         ldb   $0A,s
         sex   
         addd  #$FFD0
         addd  ,s++
         std   $06,s
         ldb   ,u+
         stb   $08,s
L0A1D    ldb   $08,s
         sex   
         leax  >$00DF,y
         leax  d,x
         ldb   ,x
         clra  
         andb  #$08
         bne   L0A03
         ldb   $08,s
         cmpb  #$2E
         bne   L0A66
         ldd   #$0001
         std   $04,s
         bra   L0A50
L0A3A    ldd   $02,s
         pshs  b,a
         ldd   #$000A
         lbsr  L132D
         pshs  b,a
         ldb   $0A,s
         sex   
         addd  #$FFD0
         addd  ,s++
         std   $02,s
L0A50    ldb   ,u+
         stb   $08,s
         ldb   $08,s
         sex   
         leax  >$00DF,y
         leax  d,x
         ldb   ,x
         clra  
         andb  #$08
         bne   L0A3A
         bra   L0A6A
L0A66    clra  
         clrb  
         std   $04,s
L0A6A    ldb   $08,s
         sex   
         tfr   d,x
         lbra  L0B98
L0A72    ldd   $06,s
         pshs  b,a
         ldx   <$15,s
         leax  $02,x
         stx   <$15,s
         ldd   -$02,x
         pshs  b,a
         lbsr  L0BF9
         bra   L0A9A
L0A87    ldd   $06,s
         pshs  b,a
         ldx   <$15,s
         leax  $02,x
         stx   <$15,s
         ldd   -$02,x
         pshs  b,a
         lbsr  L0CB6
L0A9A    std   ,s
         lbra  L0B7E
L0A9F    ldd   $06,s
         pshs  b,a
         ldb   $0A,s
         sex   
         leax  >$00DF,y
         leax  d,x
         ldb   ,x
         clra  
         andb  #$02
         pshs  b,a
         ldx   <$17,s
         leax  $02,x
         stx   <$17,s
         ldd   -$02,x
         pshs  b,a
         lbsr  L0CFE
         lbra  L0B7A
L0AC5    ldd   $06,s
         pshs  b,a
         ldx   <$15,s
         leax  $02,x
         stx   <$15,s
         ldd   -$02,x
         pshs  b,a
         leax  >$0391,y
         pshs  x
         lbsr  L0C3D
         lbra  L0B7A
L0AE1    ldd   $04,s
         bne   L0AEA
         ldd   #$0006
         std   $02,s
L0AEA    ldd   $06,s
         pshs  b,a
         leax  <$15,s
         pshs  x
         ldd   $06,s
         pshs  b,a
         ldb   $0E,s
         sex   
         pshs  b,a
         lbsr  L129B
         leas  $06,s
         lbra  L0B7C
L0B04    ldx   <$13,s
         leax  $02,x
         stx   <$13,s
         ldd   -$02,x
         lbra  L0B8E
L0B11    ldx   <$13,s
         leax  $02,x
         stx   <$13,s
         ldd   -$02,x
         std   $09,s
         ldd   $04,s
         beq   L0B59
         ldd   $09,s
         std   $04,s
         bra   L0B33
L0B27    ldb   [<$09,s]
         beq   L0B3F
         ldd   $09,s
         addd  #$0001
         std   $09,s
L0B33    ldd   $02,s
         addd  #$FFFF
         std   $02,s
         subd  #$FFFF
         bne   L0B27
L0B3F    ldd   $06,s
         pshs  b,a
         ldd   $0B,s
         subd  $06,s
         pshs  b,a
         ldd   $08,s
         pshs  b,a
         ldd   <$15,s
         pshs  b,a
         lbsr  L0D69
         leas  $08,s
         bra   L0B88
L0B59    ldd   $06,s
         pshs  b,a
         ldd   $0B,s
         bra   L0B7C
L0B61    ldb   ,u+
         stb   $08,s
         bra   L0B69
         leas  -$0B,x
L0B69    ldd   $06,s
         pshs  b,a
         leax  <$15,s
         pshs  x
         ldb   $0C,s
         sex   
         pshs  b,a
         lbsr  L125D
L0B7A    leas  $04,s
L0B7C    pshs  b,a
L0B7E    ldd   <$13,s
         pshs  b,a
         lbsr  L0DCB
         leas  $06,s
L0B88    lbra  L09C4
L0B8B    ldb   $08,s
         sex   
L0B8E    pshs  b,a
         jsr   [<$11,s]
         leas  $02,s
         lbra  L09C4
L0B98    cmpx  #$0064
         lbeq  L0A72
         cmpx  #$006F
         lbeq  L0A87
         cmpx  #$0078
         lbeq  L0A9F
         cmpx  #$0058
         lbeq  L0A9F
         cmpx  #$0075
         lbeq  L0AC5
         cmpx  #$0066
         lbeq  L0AE1
         cmpx  #$0065
         lbeq  L0AE1
         cmpx  #$0067
         lbeq  L0AE1
         cmpx  #$0045
         lbeq  L0AE1
         cmpx  #$0047
         lbeq  L0AE1
         cmpx  #$0063
         lbeq  L0B04
         cmpx  #$0073
         lbeq  L0B11
         cmpx  #$006C
         lbeq  L0B61
         bra   L0B8B
L0BF5    leas  $0B,s
         puls  pc,u
L0BF9    pshs  u,b,a
         leax  >$0391,y
         stx   ,s
         ldd   $06,s
         bge   L0C2E
         ldd   $06,s
         nega  
         negb  
         sbca  #$00
         std   $06,s
         bge   L0C23
         leax  >L0E57,pcr
         pshs  x
         leax  >$0391,y
         pshs  x
         lbsr  L12B7
         leas  $04,s
         lbra  L0CFA
L0C23    ldd   #$002D
         ldx   ,s
         leax  $01,x
         stx   ,s
         stb   -$01,x
L0C2E    ldd   $06,s
         pshs  b,a
         ldd   $02,s
         pshs  b,a
         bsr   L0C3D
         leas  $04,s
         lbra  L0CF4
L0C3D    pshs  u,y,x,b,a
         ldu   $0A,s
         clra  
         clrb  
         std   $02,s
         clra  
         clrb  
         std   ,s
         bra   L0C5A
L0C4B    ldd   ,s
         addd  #$0001
         std   ,s
         ldd   $0C,s
         subd  >$0001,y
         std   $0C,s
L0C5A    ldd   $0C,s
         blt   L0C4B
         leax  >$0001,y
         stx   $04,s
         bra   L0C9C
L0C66    ldd   ,s
         addd  #$0001
         std   ,s
L0C6D    ldd   $0C,s
         subd  [<$04,s]
         std   $0C,s
         bge   L0C66
         ldd   $0C,s
         addd  [<$04,s]
         std   $0C,s
         ldd   ,s
         beq   L0C86
         ldd   #$0001
         std   $02,s
L0C86    ldd   $02,s
         beq   L0C91
         ldd   ,s
         addd  #$0030
         stb   ,u+
L0C91    clra  
         clrb  
         std   ,s
         ldd   $04,s
         addd  #$0002
         std   $04,s
L0C9C    ldd   $04,s
         cmpd  >$0009,y
         bne   L0C6D
         ldd   $0C,s
         addd  #$0030
         stb   ,u+
         clra  
         clrb  
         stb   ,u
         ldd   $0A,s
         leas  $06,s
         puls  pc,u
L0CB6    pshs  u,b,a
         leax  >$0391,y
         stx   ,s
         leau  >$039B,y
L0CC2    ldd   $06,s
         clra  
         andb  #$07
         addd  #$0030
         stb   ,u+
         ldd   $06,s
         lsra  
         rorb  
         lsra  
         rorb  
         lsra  
         rorb  
         std   $06,s
         bne   L0CC2
         bra   L0CE4
L0CDA    ldb   ,u
         ldx   ,s
         leax  $01,x
         stx   ,s
         stb   -$01,x
L0CE4    leau  -u0001,u
         pshs  u
         leax  >$039B,y
         cmpx  ,s++
         bls   L0CDA
         clra  
         clrb  
         stb   [,s]
L0CF4    leax  >$0391,y
         tfr   x,d
L0CFA    leas  $02,s
         puls  pc,u
L0CFE    pshs  u,x,b,a
         leax  >$0391,y
         stx   $02,s
         leau  >$039B,y
L0D0A    ldd   $08,s
         clra  
         andb  #$0F
         std   ,s
         pshs  b,a
         ldd   $02,s
         cmpd  #$0009
         ble   L0D2C
         ldd   $0C,s
         beq   L0D24
         ldd   #$0041
         bra   L0D27
L0D24    ldd   #$0061
L0D27    addd  #$FFF6
         bra   L0D2F
L0D2C    ldd   #$0030
L0D2F    addd  ,s++
         stb   ,u+
         ldd   $08,s
         lsra  
         rorb  
         lsra  
         rorb  
         lsra  
         rorb  
         lsra  
         rorb  
         anda  #$0F
         std   $08,s
         bne   L0D0A
         bra   L0D4F
L0D45    ldb   ,u
         ldx   $02,s
         leax  $01,x
         stx   $02,s
         stb   -$01,x
L0D4F    leau  -u0001,u
         pshs  u
         leax  >$039B,y
         cmpx  ,s++
         bls   L0D45
         clra  
         clrb  
         stb   [<$02,s]
         leax  >$0391,y
         tfr   x,d
         lbra  L0E41
L0D69    pshs  u
         ldu   $06,s
         ldd   $0A,s
         subd  $08,s
         std   $0A,s
         ldd   >$03A5,y
         bne   L0D9E
         bra   L0D86
L0D7B    ldd   >$03A7,y
         pshs  b,a
         jsr   [<$06,s]
         leas  $02,s
L0D86    ldd   $0A,s
         addd  #$FFFF
         std   $0A,s
         subd  #$FFFF
         bgt   L0D7B
         bra   L0D9E
L0D94    ldb   ,u+
         sex   
         pshs  b,a
         jsr   [<$06,s]
         leas  $02,s
L0D9E    ldd   $08,s
         addd  #$FFFF
         std   $08,s
         subd  #$FFFF
         bne   L0D94
         ldd   >$03A5,y
         beq   L0DC9
         bra   L0DBD
L0DB2    ldd   >$03A7,y
         pshs  b,a
         jsr   [<$06,s]
         leas  $02,s
L0DBD    ldd   $0A,s
         addd  #$FFFF
         std   $0A,s
         subd  #$FFFF
         bgt   L0DB2
L0DC9    puls  pc,u
L0DCB    pshs  u
         ldu   $06,s
         ldd   $08,s
         pshs  b,a
         pshs  u
         lbsr  L12A6
         leas  $02,s
         nega  
         negb  
         sbca  #$00
         addd  ,s++
         std   $08,s
         ldd   >$03A5,y
         bne   L0E0D
         bra   L0DF5
L0DEA    ldd   >$03A7,y
         pshs  b,a
         jsr   [<$06,s]
         leas  $02,s
L0DF5    ldd   $08,s
         addd  #$FFFF
         std   $08,s
         subd  #$FFFF
         bgt   L0DEA
         bra   L0E0D
L0E03    ldb   ,u+
         sex   
         pshs  b,a
         jsr   [<$06,s]
         leas  $02,s
L0E0D    ldb   ,u
         bne   L0E03
         ldd   >$03A5,y
         beq   L0E30
         bra   L0E24
L0E19    ldd   >$03A7,y
         pshs  b,a
         jsr   [<$06,s]
         leas  $02,s
L0E24    ldd   $08,s
         addd  #$FFFF
         std   $08,s
         subd  #$FFFF
         bgt   L0E19
L0E30    puls  pc,u
L0E32    pshs  u
         ldd   >$038F,y
         pshs  b,a
         ldd   $06,s
         pshs  b,a
         lbsr  L0E5E
L0E41    leas  $04,s
         puls  pc,u
L0E45    pshs  u
         ldd   $04,s
         ldx   >$038F,y
         leax  $01,x
         stx   >$038F,y
         stb   -$01,x
         puls  pc,u
L0E57    blt   L0E8C
         leas  -$09,y
         pshu  y,x,dp
         neg   <u0034
         nega  
         ldu   $06,s
         ldd   u0006,u
         anda  #$80
         andb  #$22
         cmpd  #$8002
         beq   L0E82
         ldd   u0006,u
         clra  
         andb  #$22
         cmpd  #$0002
         lbne  L0F9A
         pshs  u
         lbsr  L11CD
         leas  $02,s
L0E82    ldd   u0006,u
         clra  
         andb  #$04
         beq   L0EBE
         ldd   #$0001
L0E8C    pshs  b,a
         leax  $07,s
         pshs  x
         ldd   u0008,u
         pshs  b,a
         ldd   u0006,u
         clra  
         andb  #$40
         beq   L0EA3
         leax  >L14E4,pcr
         bra   L0EA7
L0EA3    leax  >L14CB,pcr
L0EA7    tfr   x,d
         tfr   d,x
         jsr   ,x
         leas  $06,s
         cmpd  #$FFFF
         bne   L0EFF
         ldd   u0006,u
         orb   #$20
         std   u0006,u
         lbra  L0F9A
L0EBE    ldd   u0006,u
         anda  #$01
         clrb  
         std   -$02,s
         bne   L0ECE
         pshs  u
         lbsr  L0FB7
         leas  $02,s
L0ECE    ldd   ,u
         addd  #$0001
         std   ,u
         subd  #$0001
         tfr   d,x
         ldd   $04,s
         stb   ,x
         ldd   ,u
         cmpd  u0004,u
         bcc   L0EF4
         ldd   u0006,u
         clra  
         andb  #$40
         beq   L0EFF
         ldd   $04,s
         cmpd  #$000D
         bne   L0EFF
L0EF4    pshs  u
         lbsr  L0FB7
         std   ,s++
         lbne  L0F9A
L0EFF    ldd   $04,s
         puls  pc,u
         pshs  u
         ldu   $04,s
         ldd   $06,s
         pshs  b,a
         pshs  u
         ldd   #$0008
         lbsr  L138C
         pshs  b,a
         lbsr  L0E5E
         leas  $04,s
         ldd   $06,s
         pshs  b,a
         pshs  u
         lbsr  L0E5E
         lbra  L1071
L0F26    pshs  u,b,a
         leau  >$000E,y
         clra  
         clrb  
         std   ,s
         bra   L0F3C
L0F32    tfr   u,d
         leau  u000D,u
         pshs  b,a
         bsr   L0F4F
         leas  $02,s
L0F3C    ldd   ,s
         addd  #$0001
         std   ,s
         subd  #$0001
         cmpd  #$0010
         blt   L0F32
         lbra  L0FB3
L0F4F    pshs  u
         ldu   $04,s
         leas  -$02,s
         cmpu  #$0000
         beq   L0F5F
         ldd   u0006,u
         bne   L0F65
L0F5F    ldd   #$FFFF
         lbra  L0FB3
L0F65    ldd   u0006,u
         clra  
         andb  #$02
         beq   L0F74
         pshs  u
         bsr   L0F89
         leas  $02,s
         bra   L0F76
L0F74    clra  
         clrb  
L0F76    std   ,s
         ldd   u0008,u
         pshs  b,a
         lbsr  L142D
         leas  $02,s
         clra  
         clrb  
         std   u0006,u
         ldd   ,s
         bra   L0FB3
L0F89    pshs  u
         ldu   $04,s
         beq   L0F9A
         ldd   u0006,u
         clra  
         andb  #$22
         cmpd  #$0002
         beq   L0F9F
L0F9A    ldd   #$FFFF
         puls  pc,u
L0F9F    ldd   u0006,u
         anda  #$80
         clrb  
         std   -$02,s
         bne   L0FAF
         pshs  u
         lbsr  L11CD
         leas  $02,s
L0FAF    pshs  u
         bsr   L0FB7
L0FB3    leas  $02,s
         puls  pc,u
L0FB7    pshs  u
         ldu   $04,s
         leas  -$04,s
         ldd   u0006,u
         anda  #$01
         clrb  
         std   -$02,s
         bne   L0FE9
         ldd   ,u
         cmpd  u0004,u
         beq   L0FE9
         clra  
         clrb  
         pshs  b,a
         pshs  u
         lbsr  L1075
         leas  $02,s
         ldd   $02,x
         pshs  b,a
         ldd   ,x
         pshs  b,a
         ldd   u0008,u
         pshs  b,a
         lbsr  L14F4
         leas  $08,s
L0FE9    ldd   ,u
         subd  u0002,u
         std   $02,s
         lbeq  L1061
         ldd   u0006,u
         anda  #$01
         clrb  
         std   -$02,s
         lbeq  L1061
         ldd   u0006,u
         clra  
         andb  #$40
         beq   L1038
         ldd   u0002,u
         bra   L1030
L1009    ldd   $02,s
         pshs  b,a
         ldd   ,u
         pshs  b,a
         ldd   u0008,u
         pshs  b,a
         lbsr  L14E4
         leas  $06,s
         std   ,s
         cmpd  #$FFFF
         bne   L1026
         leax  $04,s
         bra   L1050
L1026    ldd   $02,s
         subd  ,s
         std   $02,s
         ldd   ,u
         addd  ,s
L1030    std   ,u
         ldd   $02,s
         bne   L1009
         bra   L1061
L1038    ldd   $02,s
         pshs  b,a
         ldd   u0002,u
         pshs  b,a
         ldd   u0008,u
         pshs  b,a
         lbsr  L14CB
         leas  $06,s
         cmpd  $02,s
         beq   L1061
         bra   L1052
L1050    leas  -$04,x
L1052    ldd   u0006,u
         orb   #$20
         std   u0006,u
         ldd   u0004,u
         std   ,u
         ldd   #$FFFF
         bra   L1071
L1061    ldd   u0006,u
         ora   #$01
         std   u0006,u
         ldd   u0002,u
         std   ,u
         addd  u000B,u
         std   u0004,u
         clra  
         clrb  
L1071    leas  $04,s
         puls  pc,u
L1075    pshs  u
         puls  pc,u
L1079    pshs  u
         ldu   $04,s
         beq   L10C5
         ldd   u0006,u
         anda  #$01
         clrb  
         std   -$02,s
         bne   L10C5
         ldd   ,u
         cmpd  u0004,u
         bcc   L10A1
         ldd   ,u
         addd  #$0001
         std   ,u
         subd  #$0001
         tfr   d,x
         ldb   ,x
         clra  
         lbra  L11CB
L10A1    pshs  u
         lbsr  L1114
         lbra  L11C9
         pshs  u
         ldu   $06,s
         beq   L10C5
         ldd   u0006,u
         clra  
         andb  #$01
         beq   L10C5
         ldd   $04,s
         cmpd  #$FFFF
         beq   L10C5
         ldd   ,u
         cmpd  u0002,u
         bhi   L10CA
L10C5    ldd   #$FFFF
         puls  pc,u
L10CA    ldd   ,u
         addd  #$FFFF
         std   ,u
         tfr   d,x
         ldd   $04,s
         stb   ,x
         ldd   $04,s
         puls  pc,u
         pshs  u
         ldu   $04,s
         leas  -$04,s
         pshs  u
         lbsr  L1079
         leas  $02,s
         std   $02,s
         cmpd  #$FFFF
         beq   L10FF
         pshs  u
         lbsr  L1079
         leas  $02,s
         std   ,s
         cmpd  #$FFFF
         bne   L1104
L10FF    ldd   #$FFFF
         bra   L1110
L1104    ldd   $02,s
         pshs  b,a
         ldd   #$0008
         lbsr  L13A3
         addd  ,s
L1110    leas  $04,s
         puls  pc,u
L1114    pshs  u
         ldu   $04,s
         leas  -$02,s
         ldd   u0006,u
         anda  #$80
         andb  #$31
         cmpd  #$8001
         beq   L113A
         ldd   u0006,u
         clra  
         andb  #$31
         cmpd  #$0001
         lbne  L11B3
         pshs  u
         lbsr  L11CD
         leas  $02,s
L113A    leax  >$000E,y
         pshs  x
         cmpu  ,s++
         bne   L1157
         ldd   u0006,u
         clra  
         andb  #$40
         beq   L1157
         leax  >$001B,y
         pshs  x
         lbsr  L0F89
         leas  $02,s
L1157    ldd   u0006,u
         clra  
         andb  #$08
         beq   L1183
         ldd   u000B,u
         pshs  b,a
         ldd   u0002,u
         pshs  b,a
         ldd   u0008,u
         pshs  b,a
         ldd   u0006,u
         clra  
         andb  #$40
         beq   L1177
         leax  >L14BB,pcr
         bra   L117B
L1177    leax  >L149A,pcr
L117B    tfr   x,d
         tfr   d,x
         jsr   ,x
         bra   L1195
L1183    ldd   #$0001
         pshs  b,a
         leax  u000A,u
         stx   u0002,u
         pshs  x
         ldd   u0008,u
         pshs  b,a
         lbsr  L149A
L1195    leas  $06,s
         std   ,s
         ldd   ,s
         bgt   L11B8
         ldd   u0006,u
         pshs  b,a
         ldd   $02,s
         beq   L11AA
         ldd   #$0020
         bra   L11AD
L11AA    ldd   #$0010
L11AD    ora   ,s+
         orb   ,s+
         std   u0006,u
L11B3    ldd   #$FFFF
         bra   L11C9
L11B8    ldd   u0002,u
         addd  #$0001
         std   ,u
         ldd   u0002,u
         addd  ,s
         std   u0004,u
         ldb   [<u0002,u]
         clra  
L11C9    leas  $02,s
L11CB    puls  pc,u
L11CD    pshs  u
         ldu   $04,s
         ldd   u0006,u
         clra  
         andb  #$C0
         bne   L1205
         leas  <-$20,s
         leax  ,s
         pshs  x
         ldd   u0008,u
         pshs  b,a
         clra  
         clrb  
         pshs  b,a
         lbsr  L13AF
         leas  $06,s
         ldd   u0006,u
         pshs  b,a
         ldb   $02,s
         bne   L11F9
         ldd   #$0040
         bra   L11FC
L11F9    ldd   #$0080
L11FC    ora   ,s+
         orb   ,s+
         std   u0006,u
         leas  <$20,s
L1205    ldd   u0006,u
         ora   #$80
         std   u0006,u
         clra  
         andb  #$0C
         beq   L1212
         puls  pc,u
L1212    ldd   u000B,u
         bne   L1227
         ldd   u0006,u
         clra  
         andb  #$40
         beq   L1222
         ldd   #$0080
         bra   L1225
L1222    ldd   #$0100
L1225    std   u000B,u
L1227    ldd   u0002,u
         bne   L123C
         ldd   u000B,u
         pshs  b,a
         lbsr  L15B2
         leas  $02,s
         std   u0002,u
         cmpd  #$FFFF
         beq   L1244
L123C    ldd   u0006,u
         orb   #$08
         std   u0006,u
         bra   L1253
L1244    ldd   u0006,u
         orb   #$04
         std   u0006,u
         leax  u000A,u
         stx   u0002,u
         ldd   #$0001
         std   u000B,u
L1253    ldd   u0002,u
         addd  u000B,u
         std   u0004,u
         std   ,u
         puls  pc,u
L125D    pshs  u
         ldb   $05,s
         sex   
         tfr   d,x
         bra   L1283
L1266    ldd   [<$06,s]
         addd  #$0004
         std   [<$06,s]
         leax  >L129A,pcr
         bra   L127F
L1275    ldb   $05,s
         stb   >$000C,y
         leax  >$000B,y
L127F    tfr   x,d
         puls  pc,u
L1283    cmpx  #$0064
         beq   L1266
         cmpx  #$006F
         lbeq  L1266
         cmpx  #$0078
         lbeq  L1266
         bra   L1275
         puls  pc,u
L129A    neg   <u0034
         nega  
         leax  >L12A5,pcr
         tfr   x,d
         puls  pc,u
L12A5    neg   <u0034
         nega  
         ldu   $04,s
L12AA    ldb   ,u+
         bne   L12AA
         tfr   u,d
         subd  $04,s
         addd  #$FFFF
         puls  pc,u
L12B7    pshs  u
         ldu   $06,s
         leas  -$02,s
         ldd   $06,s
         std   ,s
L12C1    ldb   ,u+
         ldx   ,s
         leax  $01,x
         stx   ,s
         stb   -$01,x
         bne   L12C1
         bra   L12F6
         pshs  u
         ldu   $06,s
         leas  -$02,s
         ldd   $06,s
         std   ,s
L12D9    ldx   ,s
         leax  $01,x
         stx   ,s
         ldb   -$01,x
         bne   L12D9
         ldd   ,s
         addd  #$FFFF
         std   ,s
L12EA    ldb   ,u+
         ldx   ,s
         leax  $01,x
         stx   ,s
         stb   -$01,x
         bne   L12EA
L12F6    ldd   $06,s
         leas  $02,s
         puls  pc,u
         pshs  u
         ldu   $04,s
         bra   L1312
L1302    ldx   $06,s
         leax  $01,x
         stx   $06,s
         ldb   -$01,x
         bne   L1310
         clra  
         clrb  
         puls  pc,u
L1310    leau  u0001,u
L1312    ldb   ,u
         sex   
         pshs  b,a
         ldb   [<$08,s]
         sex   
         cmpd  ,s++
         beq   L1302
         ldb   [<$06,s]
         sex   
         pshs  b,a
         ldb   ,u
         sex   
         subd  ,s++
         puls  pc,u
L132D    tsta  
         bne   L1342
         tst   $02,s
         bne   L1342
         lda   $03,s
         mul   
         ldx   ,s
         stx   $02,s
         ldx   #$0000
         std   ,s
         puls  pc,b,a
L1342    pshs  b,a
         ldd   #$0000
         pshs  b,a
         pshs  b,a
         lda   $05,s
         ldb   $09,s
         mul   
         std   $02,s
         lda   $05,s
         ldb   $08,s
         mul   
         addd  $01,s
         std   $01,s
         bcc   L135F
         inc   ,s
L135F    lda   $04,s
         ldb   $09,s
         mul   
         addd  $01,s
         std   $01,s
         bcc   L136C
         inc   ,s
L136C    lda   $04,s
         ldb   $08,s
         mul   
         addd  ,s
         std   ,s
         ldx   $06,s
         stx   $08,s
         ldx   ,s
         ldd   $02,s
         leas  $08,s
         rts   
         tstb  
         beq   L1396
L1383    asr   $02,s
         ror   $03,s
         decb  
         bne   L1383
         bra   L1396
L138C    tstb  
         beq   L1396
L138F    lsr   $02,s
         ror   $03,s
         decb  
         bne   L138F
L1396    ldd   $02,s
         pshs  b,a
         ldd   $02,s
         std   $04,s
         ldd   ,s
         leas  $04,s
         rts   
L13A3    tstb  
         beq   L1396
L13A6    lsl   $03,s
         rol   $02,s
         decb  
         bne   L13A6
         bra   L1396
L13AF    lda   $05,s
         ldb   $03,s
         beq   L13E2
         cmpb  #$01
         beq   L13E4
         cmpb  #$06
         beq   L13E4
         cmpb  #$02
         beq   L13CA
         cmpb  #$05
         beq   L13CA
         ldb   #$D0
         lbra  L15DF
L13CA    pshs  u
         os9   I$GetStt 
         bcc   L13D6
         puls  u
         lbra  L15DF
L13D6    stx   [<$08,s]
         ldx   $08,s
         stu   $02,x
         puls  u
         clra  
         clrb  
         rts   
L13E2    ldx   $06,s
L13E4    os9   I$GetStt 
         lbra  L15E8
         lda   $05,s
         ldb   $03,s
         beq   L13F9
         cmpb  #$02
         beq   L1401
         ldb   #$D0
         lbra  L15DF
L13F9    ldx   $06,s
         os9   I$SetStt 
         lbra  L15E8
L1401    pshs  u
         ldx   $08,s
         ldu   $0A,s
         os9   I$SetStt 
         puls  u
         lbra  L15E8
         ldx   $02,s
         lda   $05,s
         os9   I$Open   
         bcs   L141B
         os9   I$Close  
L141B    lbra  L15E8
L141E    ldx   $02,s
         lda   $05,s
         os9   I$Open   
         lbcs  L15DF
         tfr   a,b
         clra  
         rts   
L142D    lda   $03,s
         os9   I$Close  
         lbra  L15E8
         ldx   $02,s
         ldb   $05,s
         os9   I$MakDir 
         lbra  L15E8
L143F    ldx   $02,s
         lda   $05,s
         tfr   a,b
         andb  #$24
         orb   #$0B
         os9   I$Create 
         bcs   L1452
L144E    tfr   a,b
         clra  
         rts   
L1452    cmpb  #$DA
         lbne  L15DF
         lda   $05,s
         bita  #$80
         lbne  L15DF
         anda  #$07
         ldx   $02,s
         os9   I$Open   
         lbcs  L15DF
         pshs  u,a
         ldx   #$0000
         leau  ,x
         ldb   #$02
         os9   I$SetStt 
         puls  u,a
         bcc   L144E
         pshs  b
         os9   I$Close  
         puls  b
         lbra  L15DF
         ldx   $02,s
         os9   I$Delete 
         lbra  L15E8
         lda   $03,s
         os9   I$Dup    
         lbcs  L15DF
         tfr   a,b
         clra  
         rts   
L149A    pshs  y
         ldx   $06,s
         lda   $05,s
         ldy   $08,s
         pshs  y
         os9   I$Read   
L14A8    bcc   L14B7
         cmpb  #$D3
         bne   L14B2
         clra  
         clrb  
         puls  pc,y,x
L14B2    puls  y,x
         lbra  L15DF
L14B7    tfr   y,d
         puls  pc,y,x
L14BB    pshs  y
         lda   $05,s
         ldx   $06,s
         ldy   $08,s
         pshs  y
         os9   I$ReadLn 
         bra   L14A8
L14CB    pshs  y
         ldy   $08,s
         beq   L14E0
         lda   $05,s
         ldx   $06,s
         os9   I$Write  
L14D9    bcc   L14E0
         puls  y
         lbra  L15DF
L14E0    tfr   y,d
         puls  pc,y
L14E4    pshs  y
         ldy   $08,s
         beq   L14E0
         lda   $05,s
         ldx   $06,s
         os9   I$WritLn 
         bra   L14D9
L14F4    pshs  u
         ldd   $0A,s
         bne   L1502
         ldu   #$0000
         ldx   #$0000
         bra   L1536
L1502    cmpd  #$0001
         beq   L152D
         cmpd  #$0002
         beq   L1522
         ldb   #$F7
L1510    clra  
         std   >$01AD,y
         ldd   #$FFFF
         leax  >$01A1,y
         std   ,x
         std   $02,x
         puls  pc,u
L1522    lda   $05,s
         ldb   #$02
         os9   I$GetStt 
         bcs   L1510
         bra   L1536
L152D    lda   $05,s
         ldb   #$05
         os9   I$GetStt 
         bcs   L1510
L1536    tfr   u,d
         addd  $08,s
         std   >$01A3,y
         tfr   d,u
         tfr   x,d
         adcb  $07,s
         adca  $06,s
         bmi   L1510
         tfr   d,x
         std   >$01A1,y
         lda   $05,s
         os9   I$Seek   
         bcs   L1510
         leax  >$01A1,y
         puls  pc,u
         ldd   >$019F,y
         pshs  b,a
         ldd   $04,s
         cmpd  >$03A9,y
         bcs   L158F
         addd  >$019F,y
         pshs  y
         subd  ,s
         os9   F$Mem    
         tfr   y,d
         puls  y
         bcc   L1581
         ldd   #$FFFF
         leas  $02,s
         rts   
L1581    std   >$019F,y
         addd  >$03A9,y
         subd  ,s
         std   >$03A9,y
L158F    leas  $02,s
         ldd   >$03A9,y
         pshs  b,a
         subd  $04,s
         std   >$03A9,y
         ldd   >$019F,y
         subd  ,s++
         pshs  b,a
         clra  
         ldx   ,s
L15A8    sta   ,x+
         cmpx  >$019F,y
         bcs   L15A8
         puls  pc,b,a
L15B2    ldd   $02,s
         addd  >$01A9,y
         bcs   L15DB
         cmpd  >$01AB,y
         bcc   L15DB
         pshs  b,a
         ldx   >$01A9,y
         clra  
L15C8    cmpx  ,s
         bcc   L15D0
         sta   ,x+
         bra   L15C8
L15D0    ldd   >$01A9,y
         puls  x
         stx   >$01A9,y
         rts   
L15DB    ldd   #$FFFF
         rts   
L15DF    clra  
         std   >$01AD,y
         ldd   #$FFFF
         rts   
L15E8    bcs   L15DF
         clra  
         clrb  
         rts   
L15ED    lbsr  L15F8
         lbsr  L0F26
L15F3    ldd   $02,s
         os9   F$Exit   
L15F8    rts   
L15F9    neg   <u0001
         neg   <u0001
         fcb   $5E ^
         beq   L1610
         com   <u00E8
         neg   <u0064
         neg   <u000A
         neg   <u0009
         inc   -$08,s
         neg   <u0000
         neg   <u0000
         neg   <u0000
L1610    neg   <u0000
         oim   #$00,<u0000
         neg   <u0000
         neg   <u0000
         neg   <u0000
         neg   <u0000
         neg   <u0000
         aim   #$00,<u0001
         neg   <u0000
         neg   <u0000
         neg   <u0000
         neg   <u0000
         neg   <u0000
         fcb   $42 B
         neg   <u0002
         neg   <u0000
         neg   <u0000
         neg   <u0000
         neg   <u0000
         neg   <u0000
         neg   <u0000
         neg   <u0000
         neg   <u0000
         neg   <u0000
         neg   <u0000
         neg   <u0000
         neg   <u0000
         neg   <u0000
         neg   <u0000
         neg   <u0000
         neg   <u0000
         neg   <u0000
         neg   <u0000
         neg   <u0000
         neg   <u0000
         neg   <u0000
         neg   <u0000
         neg   <u0000
         neg   <u0000
         neg   <u0000
         neg   <u0000
         neg   <u0000
         neg   <u0000
         neg   <u0000
         neg   <u0000
         neg   <u0000
         neg   <u0000
         neg   <u0000
         neg   <u0000
         neg   <u0000
         neg   <u0000
         neg   <u0000
         neg   <u0000
         neg   <u0000
         neg   <u0000
         neg   <u0000
         neg   <u0000
         neg   <u0000
         neg   <u0000
         neg   <u0000
         neg   <u0000
         neg   <u0000
         neg   <u0000
         neg   <u0000
         neg   <u0000
         neg   <u0000
         neg   <u0000
         neg   <u0000
         neg   <u0000
         neg   <u0000
         neg   <u0000
         neg   <u0000
         neg   <u0000
         neg   <u0000
         neg   <u0000
         neg   <u0000
         neg   <u0000
         neg   <u0000
         neg   <u0000
         neg   <u0000
         neg   <u0000
         neg   <u0000
         neg   <u0000
         neg   <u0000
         neg   <u0000
         neg   <u0000
         neg   <u0000
         neg   <u0000
         neg   <u0000
         neg   <u0000
         neg   <u0000
         neg   <u0000
         neg   <u0000
         neg   <u0000
         neg   <u0000
         neg   <u0000
         neg   <u0000
         neg   <u0000
         neg   <u0000
         neg   <u0000
         neg   <u0000
         neg   <u0001
         oim   #$01,<u0001
         oim   #$01,<u0001
         oim   #$01,<u0011
         fcb   $11 
         oim   #$11,<u0011
         oim   #$01,<u0001
         oim   #$01,<u0001
         oim   #$01,<u0001
         oim   #$01,<u0001
         oim   #$01,<u0001
         oim   #$01,<u0001
         leax  $00,y
         bra   L1720
         bra   L1722
         bra   L1724
         bra   L1726
         bra   L1728
         bra   L172A
         bra   L172C
         lsla  
         lsla  
         lsla  
         lsla  
         lsla  
         lsla  
         lsla  
         lsla  
         lsla  
         lsla  
         bra   L1738
         bra   L173A
         bra   L173C
         bra   L1760
         fcb   $42 B
         fcb   $42 B
L1720    fcb   $42 B
         fcb   $42 B
L1722    fcb   $42 B
         aim   #$02,<u0002
L1726    aim   #$02,<u0002
         aim   #$02,<u0002
L172C    aim   #$02,<u0002
         aim   #$02,<u0002
         aim   #$02,<u0002
         aim   #$02,<u0020
L1738    bra   L175A
L173A    bra   L175C
L173C    bra   L1782
         lsra  
         lsra  
         lsra  
         lsra  
         lsra  
         lsr   <u0004
         lsr   <u0004
         lsr   <u0004
         lsr   <u0004
         lsr   <u0004
         lsr   <u0004
         lsr   <u0004
         lsr   <u0004
         lsr   <u0004
         lsr   <u0004
         bra   L1779
         bra   L177B
         oim   #$00,<u0000
         neg   <u0001
L1760    neg   <u0009
         fcb   $4E N
         eim   #u0077,-$01,u
         eim   #$73,>$6572
         fcb   $00 
         emod
eom      equ   *
         end
