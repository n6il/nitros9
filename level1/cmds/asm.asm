********************************************************************
* Asm - 6809 Assembler
*
* $Id$
*
* Ed.    Comments                                       Who YY/MM/DD
* ------------------------------------------------------------------
* 6      Made compliant with 1900-2155                  BGP 99/05/11

         nam   Asm
         ttl   6809 Assembler

* Disassembled 99/04/12 09:16:34 by Disasm v1.6 (C) 1988 by RML

         ifp1
         use   defsfile
         endc

tylg     set   Prgrm+Objct   
atrv     set   ReEnt+rev
rev      set   $01
edition  set   6

         mod   eom,name,tylg,atrv,start,size

u0000    rmb   1
u0001    rmb   1
u0002    rmb   1
u0003    rmb   1
u0004    rmb   1
u0005    rmb   1
u0006    rmb   1
u0007    rmb   1
u0008    rmb   1
u0009    rmb   1
u000A    rmb   1
u000B    rmb   1
u000C    rmb   1
u000D    rmb   1
u000E    rmb   1
u000F    rmb   1
u0010    rmb   2
u0012    rmb   2
u0014    rmb   2
u0016    rmb   1
u0017    rmb   1
u0018    rmb   1
u0019    rmb   1
u001A    rmb   1
u001B    rmb   2
u001D    rmb   1
u001E    rmb   1
u001F    rmb   1
u0020    rmb   1
u0021    rmb   1
u0022    rmb   1
u0023    rmb   1
u0024    rmb   1
u0025    rmb   1
u0026    rmb   1
u0027    rmb   1
u0028    rmb   1
u0029    rmb   1
u002A    rmb   1
u002B    rmb   1
u002C    rmb   1
u002D    rmb   1
u002E    rmb   1
u002F    rmb   1
u0030    rmb   1
u0031    rmb   1
u0032    rmb   1
u0033    rmb   1
u0034    rmb   1
u0035    rmb   1
u0036    rmb   1
u0037    rmb   1
u0038    rmb   1
u0039    rmb   1
u003A    rmb   1
u003B    rmb   1
u003C    rmb   1
u003D    rmb   1
u003E    rmb   1
u003F    rmb   1
u0040    rmb   1
u0041    rmb   1
u0042    rmb   1
u0043    rmb   1
u0044    rmb   1
u0045    rmb   1
u0046    rmb   1
u0047    rmb   2
u0049    rmb   1
u004A    rmb   1
u004B    rmb   1
u004C    rmb   1
u004D    rmb   1
u004E    rmb   1
u004F    rmb   1
u0050    rmb   1
u0051    rmb   1
u0052    rmb   1
u0053    rmb   1
u0054    rmb   1
u0055    rmb   1
u0056    rmb   1
u0057    rmb   1
u0058    rmb   1
u0059    rmb   1
u005A    rmb   1
u005B    rmb   1
u005C    rmb   1
u005D    rmb   1
u005E    rmb   1
u005F    rmb   1
u0060    rmb   1
u0061    rmb   1
u0062    rmb   1
u0063    rmb   1
u0064    rmb   1
u0065    rmb   4
u0069    rmb   1
u006A    rmb   3
u006D    rmb   2
u006F    rmb   1
u0070    rmb   1
u0071    rmb   1
u0072    rmb   1
u0073    rmb   2
u0075    rmb   11
u0080    rmb   1
u0081    rmb   2
u0083    rmb   2
u0085    rmb   2
u0087    rmb   1
u0088    rmb   2
u008A    rmb   2
u008C    rmb   1
u008D    rmb   1
u008E    rmb   1
u008F    rmb   8
u0097    rmb   15
u00A6    rmb   1
u00A7    rmb   2
u00A9    rmb   6
u00AF    rmb   7
u00B6    rmb   11
u00C1    rmb   1
u00C2    rmb   1
u00C3    rmb   3
u00C6    rmb   8
u00CE    rmb   1
u00CF    rmb   8
u00D7    rmb   10
u00E1    rmb   7
u00E8    rmb   4
u00EC    rmb   12
u00F8    rmb   3848
size     equ   .

name     fcs   /Asm/
         fcb   edition

start    equ   *
         tfr   u,d
         addd  #$01C0
         std   <u0014
         std   <u0016
         addd  #$0009
         std   <u0000
         addd  #$0051
         std   <u0002
         addd  #$0085
         std   <u0004
         addd  #$0092
         std   <u0006
         std   <u001F
         std   <u0008
         addd  #$0050
         std   <u000A
         addd  #$0028
         std   <u000E
         addd  #$0100
         std   <u0010
         addd  #$0034
         std   <u001D
         leau  -$01,y
         stu   <u0012
         lds   <u0014
         clra  
         ldb   #$01
         sta   <u0059
         sta   <u005B
         sta   <u005E
         sta   <u005D
         stb   <u005C
         sta   <u0058
         sta   <u005A
         stb   <u005F
         sta   <u0060
         sta   <u003E
         sta   <u0018
         sta   <u0019
         stb   <u001A
         ldb   #$FF
         stb   <u0056
         sta   <u0057
         ldb   #$42
         stb   <u0036
         ldb   #$50
         stb   <u0037
         lbsr  L1696
         lda   <u0056
         bmi   L0081
         inc   <u0057
L0081    ldx   <u0008
         clr   ,x
         ldx   <u000A
         clr   ,x
         ldx   <u0010
L008B    clr   ,x+
         cmpx  <u0012
         bls   L008B
         ldb   <u005D
         beq   L0099
         dec   <u003E
         bra   L00A0
L0099    bsr   L00A5
         lbsr  L1607
         inc   <u003E
L00A0    bsr   L00A5
         lbra  L159F
L00A5    bsr   L00B1
L00A7    lbsr  L1537
         bcc   L00AD
         rts   
L00AD    bsr   L00D5
         bra   L00A7
L00B1    clra  
         clrb  
         std   <u0028
         std   <u0022
         std   <u0026
         std   <u0024
         std   <u0040
         std   <u0042
         stb   <u003F
         stb   <u0055
         stb   <u0054
         incb  
         std   <u003A
         std   <u0038
         ldd   <u000E
         std   <u001B
         lbsr  L1360
         lbsr  L141A
         rts   
L00D5    clra  
         clrb  
         std   <u004A
         std   <u0061
         std   <u0063
         sta   <u0065
         sta   <u0046
         sta   <u002A
         sta   <u0021
         sta   <u004C
         sta   <u002C
         sta   <u004F
         sta   <u004E
         sta   <u004D
         lda   #$35
         sta   <u002B
         ldd   <u0040
         std   <u0044
         ldx   <u0000
         lda   ,x
         cmpa  #$0D
         beq   L0136
         cmpa  #$2A
         beq   L0136
         cmpa  #$20
         beq   L0125
         ldb   <u002B
         orb   #$08
         stb   <u002B
         lbsr  L0368
         bcc   L0119
         ldb   #$01
         lbsr  L02FA
         bra   L0125
L0119    tst   <u0054
         bne   L0125
         lbsr  L0F4A
         bcc   L0125
         lbsr  L02FA
L0125    lbsr  L1164
         cmpa  #$0D
         bne   L0141
         lda   <u002B
         bita  #$08
         beq   L0136
         lda   #$09
         bra   L0138
L0136    lda   #$80
L0138    sta   <u002B
         lda   <u0054
         bne   L018E
         lbra  L01F2
L0141    stx   <u002F
L0143    lda   ,x+
         cmpa  #$0D
         beq   L0150
         cmpa  #$20
         bne   L0143
         lbsr  L1164
L0150    stx   <u0031
         ldx   <u002F
         ldb   #$74
         leay  >L03B8,pcr
         lbsr  L0344
         bcc   L0172
L015F    ldb   #$02
         lbsr  L02FA
         ldb   #$03
         stb   <u0046
         lda   <u002B
         anda  #$DF
         sta   <u002B
         ldx   <u0031
         bra   L01C4
L0172    lda   <u0054
         beq   L0195
         ldb   $01,y
         andb  #$0F
         cmpb  #$0D
         bne   L0181
         inca  
         bra   L018C
L0181    cmpb  #$0E
         bne   L018E
         deca  
         beq   L0195
         ldb   ,y
         bne   L018E
L018C    sta   <u0054
L018E    inc   <u0039
         bne   L0194
         inc   <u0038
L0194    rts   
L0195    ldd   ,y
         sta   <u0062
         stb   <u0047
         lda   #$10
         bitb  #$10
         bne   L01A7
         lda   #$11
         bitb  #$20
         beq   L01AB
L01A7    sta   <u0061
         inc   <u0046
L01AB    leay  >L0780,pcr
         andb  #$0F
         lslb  
         ldd   b,y
         jsr   d,y
         lda   <u002B
         bita  #$20
         beq   L01C4
         lda   ,x
         clr   ,x+
         cmpa  #$0D
         beq   L01D3
L01C4    lbsr  L1164
         cmpa  #$0D
         beq   L01D3
         ldb   <u002B
         beq   L01D3
         orb   #$40
         stb   <u002B
L01D3    ldb   <u005D
         beq   L01DB
         ldb   <u0021
         bne   L01F2
L01DB    ldd   <u0040
         addb  <u0046
         adca  #$00
         std   <u0040
         bra   L01F2
L01E5    ldd   #$2084
         ldx   <u0004
L01EA    sta   ,x+
         decb  
         bne   L01EA
L01EF    ldx   <u0004
         rts   
L01F2    ldb   <u003E
         beq   L01EF
         ldb   <u002B
         beq   L01EF
         bsr   L01E5
         tst   <u0060
         bne   L0205
         ldd   <u0038
         lbsr  L1084
L0205    ldb   <u002B
         bitb  #$80
         beq   L0213
         ldb   #$0D
         ldy   <u0000
         lbra  L02AB
L0213    bitb  #$01
         beq   L0240
         lda   #$45
         ldb   <u0021
         bne   L022F
         lda   #$44
         ldb   <u002C
         bne   L022F
         lda   #$57
         ldb   <u004F
         beq   L0236
         inc   <u0023
         bne   L022F
         inc   <u0022
L022F    ldb   #$06
         lbsr  L02E2
         sta   ,x
L0236    ldb   #$08
         lbsr  L02E2
         ldd   <u0044
         lbsr  L1057
L0240    ldb   <u002B
         bitb  #$04
         beq   L0272
         ldb   <u0046
         beq   L0272
         ldb   #$61
         tfr   dp,a
         tfr   d,u
         ldb   ,u+
         bne   L0256
L0254    ldb   ,u+
L0256    pshs  b
         lbsr  L106B
         puls  a
         ldb   <u005D
         beq   L0265
         ldb   <u0021
         bne   L026E
L0265    lbsr  L130D
         inc   <u0025
         bne   L026E
         inc   <u0024
L026E    dec   <u0046
         bne   L0254
L0272    ldy   <u0000
         ldb   <u002B
         bitb  #$08
         beq   L0281
         ldb   #$18
         bsr   L02E2
         bsr   L02C9
L0281    ldb   <u002B
         bitb  #$10
         beq   L028F
         ldb   #$21
         bsr   L02E2
         bsr   L02C9
         leay  $01,y
L028F    ldb   <u002B
         bitb  #$20
         beq   L02A3
         ldb   #$27
         bsr   L02E2
         ldy   <u0031
         lbsr  L11BD
         lda   #$20
         sta   ,x+
L02A3    ldb   <u002B
         bitb  #$40
         beq   L02B7
         ldb   #$32
L02AB    bsr   L02E2
L02AD    lda   ,y+
         cmpa  #$0D
         beq   L02B7
         sta   ,x+
         bra   L02AD
L02B7    ldb   <u002B
         andb  #$BF
         cmpb  #$04
         beq   L02C8
         lbsr  L1370
         inc   <u0039
         bne   L02C8
         inc   <u0038
L02C8    rts   
L02C9    lda   ,y+
         cmpa  #$20
         beq   L02C9
L02CF    cmpa  #$0D
         beq   L02DF
         cmpx  <u001F
         bcc   L02D9
         sta   ,x+
L02D9    lda   ,y+
         cmpa  #$20
         bne   L02CF
L02DF    leay  -$01,y
         rts   
L02E2    pshs  u
         tst   <u0060
         beq   L02EC
         leax  $01,x
         bra   L02F8
L02EC    ldu   <u0004
         leau  b,u
         pshs  u
         cmpx  ,s++
         bcc   L02F8
         tfr   u,x
L02F8    puls  pc,u
L02FA    pshs  u,y,x,b,a
         tst   <u005C
         beq   L0325
         leay  >L061C,pcr
         ldx   <u0004
         lbsr  L11BD
         clra  
         decb  
         lslb  
         leay  >L062A,pcr
         ldd   d,y
         leay  d,y
         lbsr  L11BD
         ldb   $01,s
         cmpb  #$18
         bne   L0322
         ldy   $02,s
         bsr   L033D
L0322    lbsr  L1368
L0325    inc   <u0021
         inc   <u0029
         bne   L032D
         inc   <u0028
L032D    puls  pc,u,y,x,b,a
         lbsr  L01E5
         ldb   #$18
         bsr   L02E2
         ldy   <u0000
         bra   L033D
L033B    sta   ,x+
L033D    lda   ,y+
         cmpa  #$0D
         bne   L033B
         rts   
L0344    pshs  x,b
L0346    lda   ,y+
         bmi   L035E
         eora  ,x+
         anda  #$DF
         beq   L0346
L0350    lda   ,y+
         bpl   L0350
L0354    leay  $02,y
         ldx   $01,s
         decb  
         bne   L0346
         comb  
         puls  pc,x,b
L035E    eora  ,x+
         anda  #$5F
         bne   L0354
         leas  $03,s
         clrb  
         rts   
L0368    lbsr  L1164
         bsr   L03A0
         bcs   L03B7
         pshs  u,y
         ldu   <u0016
         ldb   #$08
         leax  $01,x
         bra   L0393
L0379    lda   ,x+
         bsr   L03A0
         bcc   L0393
         cmpa  #$39
         bhi   L039A
         cmpa  #$30
         bcc   L0393
         cmpa  #$2E
         beq   L0393
         cmpa  #$24
         beq   L0393
         cmpa  #$5F
         bne   L039A
L0393    sta   ,u+
         decb  
         bne   L0379
         bra   L039C
L039A    leax  -$01,x
L039C    clr   ,u+
         puls  pc,u,y
L03A0    cmpa  #$41
         bcs   L03B5
         cmpa  #$5A
         bhi   L03AD
L03A8    anda  #$5F
         andcc #$FE
         rts   
L03AD    cmpa  #$61
         bcs   L03B5
         cmpa  #$7A
         bls   L03A8
L03B5    orcc  #$01
L03B7    rts   
L03B8    fcs   "ORG"
         fdb   $000C
         fcs   "ENDC"
         fdb   $000E
         fcs   "LBRA"
         fdb   $1600
         fcs   "LBSR"
         fdb   $1700
         fcs   "ORCC"
         fdb   $1A01
         fcs   "ANDCC"
         fdb   $1C01
         fcs   "CWAI"
         fdb   $3C01
         fcs   "ADDD"
         fdb   $C302
         fcs   "SUBD"
         fdb   $8302
         fcs   "LDD"
         fdb   $CC02
         fcs   "LDX"
         fdb   $8E02
         fcs   "LDU"
         fdb   $CE02
         fcs   "CMPX"
         fdb   $8C02
         fcs   "JSR"
         fdb   $8D42
         fcs   "STD"
         fdb   $CD42
         fcs   "STX"
         fdb   $8F42
         fcs   "STU"
         fdb   $CF42
         fcs   "CMPU"
         fdb   $8322
         fcs   "CMPS"
         fdb   $8C22
         fcs   "CMPD"
         fdb   $8312
         fcs   "CMPY"
         fdb   $8C12
         fcs   "LDY"
         fdb   $8E12
         fcs   "LDS"
         fdb   $CE12
         fcs   "STY"
         fdb   $8F52
         fcs   "STS"
         fdb   $CF52
         fcs   "ADD"
         fdb   $8B03
         fcs   "CMP"
         fdb   $8103
         fcs   "SUB"
         fdb   $8003
         fcs   "SBC"
         fdb   $8203
         fcs   "AND"
         fdb   $8403
         fcs   "BIT"
         fdb   $8503
         fcs   "LD"
         fdb   $8603
         fcs   "ST"
         fdb   $8743
         fcs   "EOR"
         fdb   $8803
         fcs   "ADC"
         fdb   $8903
         fcs   "OR"
         fdb   $8A03
         fcs   "NEG"
         fdb   $0004
         fcs   "COM"
         fdb   $0304
         fcs   "LSR"
         fdb   $0404
         fcs   "ROR"
         fdb   $0604
         fcs   "ASR"
         fdb   $0704
         fcs   "LSL"
         fdb   $0804
         fcs   "ASL"
         fdb   $0804
         fcs   "ROL"
         fdb   $0904
         fcs   "DEC"
         fdb   $0A04
         fcs   "INC"
         fdb   $0C04
         fcs   "TST"
         fdb   $0D04
         fcs   "JMP"
         fdb   $0E44
         fcs   "CLR"
         fdb   $0F04
         fcs   "RTS"
         fdb   $3905
         fcs   "MUL"
         fdb   $3D05
         fcs   "NOP"
         fdb   $1205
         fcs   "SYNC"
         fdb   $1305
         fcs   "DAA"
         fdb   $1905
         fcs   "SEX"
         fdb   $1D05
         fcs   "ABX"
         fdb   $3A05
         fcs   "RTI"
         fdb   $3B05
         fcs   "SWI2"
         fdb   $3F15
         fcs   "SWI3"
         fdb   $3F25
         fcs   "SWI"
         fdb   $3F05
         fcs   "LEAX"
         fdb   $3006
         fcs   "LEAY"
         fdb   $3106
         fcs   "LEAS"
         fdb   $3206
         fcs   "LEAU"
         fdb   $3306
         fcs   "TFR"
         fdb   $1F07
         fcs   "EXG"
         fdb   $1E07
         fcs   "PSHS"
         fdb   $3408
         fcs   "PULS"
         fdb   $3508
         fcs   "PSHU"
         fdb   $3608
         fcs   "PULU"
         fdb   $3708
         fcs   "LB"
         fdb   $0019
L0530    fcs   "BSR"
         fdb   $8D0A
         fcs   "BRA"
         fdb   $200A
         fcs   "BRN"
         fdb   $210A
         fcs   "BHI"
         fdb   $220A
         fcs   "BLS"
         fdb   $230A
         fcs   "BHS"
         fdb   $240A
         fcs   "BCC"
         fdb   $240A
         fcs   "BLO"
         fdb   $250A
         fcs   "BCS"
         fdb   $250A
         fcs   "BNE"
         fdb   $260A
         fcs   "BEQ"
         fdb   $270A
         fcs   "BVC"
         fdb   $280A
         fcs   "BVS"
         fdb   $290A
         fcs   "BPL"
         fdb   $2A0A
         fcs   "BMI"
         fdb   $2B0A
         fcs   "BGE"
         fdb   $2C0A
         fcs   "BLT"
         fdb   $2D0A
         fcs   "BGT"
         fdb   $2E0A
         fcs   "BLE"
         fdb   $2F0A
         fcs   "RMB"
         fdb   $000B
         fcs   "FCC"
         fdb   $010B
         fcs   "FDB"
         fdb   $020B
         fcs   "FCS"
         fdb   $030B
         fcs   "FCB"
         fdb   $040B
         fcs   "EQU"
         fdb   $050B
         fcs   "MOD"
         fdb   $060B
         fcs   "EMOD"
         fdb   $070B
         fcs   "SETDP"
         fdb   $070C
         fcs   "SET"
         fdb   $080B
         fcs   "OS9"
         fdb   $090B
         fcs   "END"
         fdb   $010C
         fcs   "NAM"
         fdb   $020C
         fcs   "OPT"
         fdb   $030C
         fcs   "TTL"
         fdb   $040C
         fcs   "PAG"
         fdb   $050C
         fcs   "SPC"
         fdb   $060C
         fcs   "USE"
         fdb   $080C
         fcs   "IFEQ"
         fdb   $000D
         fcs   "IFNE"
         fdb   $010D
         fcs   "IFLT"
         fdb   $020D
         fcs   "IFLE"
         fdb   $030D
         fcs   "IFGE"
         fdb   $040D
         fcs   "IFGT"
         fdb   $050D
         fcs   "IFP1"
         fdb   $060D
         fcs   "ELSE"
         fdb   $010E
L061C    fcc   "***** Error: "
         fcb   $00
L062A    fdb   $0035
         fdb   $003F
         fdb   $0049
         fdb   $0053
         fdb   $005C
         fdb   $005E
         fdb   $006A
         fdb   $0071
         fdb   $0080
         fdb   $008f
         fdb   $0097
         fdb   $00A9
         fdb   $00B6
         fdb   $00C3
         fdb   $00CE
         fdb   $00D7
         fdb   $00E1
         fdb   $00EC
         fdb   $00F8
         fdb   $0102
         fdb   $010C
         fdb   $0118
         fdb   $0121
         fdb   $012B
         fdb   $0137
         fdb   $0149
         fcb   $00
L065F    fcc   "bad label"
         fcb   $00
L0667    fcc   "bad instr"
         fcb   $00
L0673    fcc   "in number"
         fcb   $00
L067C    fcc   "div by 0"
         fcb   $00
L0686    fcc   " "
         fcb   $00
L0688    fcc   "expr syntax"
         fcb   $00
L0693    fcc   "parens"
         fcb   $00
L069B    fcc   "redefined name"
         fcb   $00
L06A9    fcc   "undefined name"
         fcb   $00
L06B8    fcc   "phasing"
         fcb   $00
L06C1    fcc   "symbol table full"
         fcb   $00
L06D2    fcc   "address mode"
         fcb   $00
L06E0    fcc   "out of range"
         fcb   $00
L06EC    fcc   "result>255"
         fcb   $00
L06F7    fcc   "reg name"
         fcb   $00
L0701    fcc   "reg sizes"
         fcb   $00
L070A    fcc   "input path"
         fcb   $00
L0715    fcc   "object path"
         fcb   $00
L0722    fcc   "index reg"
         fcb   $00
L072C    fcc   "] missing"
         fcb   $00
L0736    fcc   "needs label"
         fcb   $00
L0742    fcc   "opt list"
         fcb   $00
L074B    fcc   "const def"
         fcb   $00
L0755    fcc   "can't open "
         fcb   $00
L0761    fcc   "label not allowed"
         fcb   $00
L0773    fcc   "cond nesting"
         fcb   $00

L0780    fdb   $001E
         fdb   $0025
         fdb   $0039
         fdb   $004E
         fdb   $0073
         fdb   $00A6
         fdb   $00AF
         fdb   $00C6
         fdb   $0104
         fdb   $011D
         fdb   $013A
         fdb   $015C
         fdb   $0161
         fdb   $0179

L079C    fdb   $07A9
         lda   #$03
         sta   <u0046
         lbra  L0951
         lbsr  L0932
         bcc   L07AF
         ldb   #$0C
         lbsr  L02FA
L07AF    lbsr  L12F7
         stb   <u0063
         lda   #$02
         sta   <u0046
         rts   
         inc   <u0046
         lbsr  L0932
         lbcs  L09C6
         lbsr  L12F1
         std   <u0063
         inc   <u0046
         inc   <u0046
         lbra  L0941
         inc   <u0046
         lda   ,x+
         anda  #$5F
         cmpa  #$41
L07D6    beq   L07E7
         cmpa  #$42
         beq   L07E1
         leas  $02,s
         lbra  L015F
L07E1    ldb   #$40
         orb   <u0062
         stb   <u0062
L07E7    lbsr  L0932
         lbcs  L09C6
         lbsr  L0941
         bra   L07AF
         inc   <u0046
         lda   <u0062
         cmpa  #$0E
         beq   L080B
         lda   ,x
         anda  #$5F
         ldb   #$40
         cmpa  #$41
         beq   L0819
         ldb   #$50
         cmpa  #$42
         beq   L0819
L080B    lbsr  L09C6
         ldb   <u0062
         bitb  #$F0
         beq   L0825
         orb   #$40
         stb   <u0062
         rts   
L0819    orb   <u0062
         stb   <u0062
         leax  $01,x
         ldb   #$DF
         andb  <u002B
         stb   <u002B
L0825    rts   
         inc   <u0046
         ldb   <u002B
         andb  #$DF
         stb   <u002B
         rts   
         inc   <u0046
         lbsr  L09C6
         lda   <u004E
         bne   L0825
         ldd   #$1212
         std   <u0062
         ldb   #$02
         stb   <u0046
         ldb   #$0C
         lbra  L02FA
         ldb   #$02
         stb   <u0046
         lbsr  L1164
         lbsr  L096B
         bcc   L0857
L0852    ldb   #$0F
         lbra  L02FA
L0857    lda   ,x+
         cmpa  #$2C
         bne   L0852
         pshs  b
         lbsr  L096B
         puls  a
         bcs   L0852
         pshs  b,a
         anda  #$08
         andb  #$08
         pshs  b
         eora  ,s+
         beq   L0879
         ldb   #$10
         leas  $02,s
         lbra  L02FA
L0879    puls  a
         lsla  
         lsla  
         lsla  
         lsla  
         ora   ,s+
         sta   <u0063
         rts   
         ldb   #$02
         stb   <u0046
         lbsr  L1164
L088B    lbsr  L096B
         bcs   L0852
         ora   <u0063
         sta   <u0063
         lda   ,x+
         cmpa  #$2C
         beq   L088B
         leax  -$01,x
         rts   
         lda   #$04
         sta   <u0046
         leax  -$01,x
         ldb   #$13
         leay  >L0530,pcr
         lbsr  L0344
         bcc   L08B3
         leas  $02,s
         lbra  L015F
L08B3    lda   ,y
         sta   <u0062
         lbra  L0951
         lda   #$02
         sta   <u0046
         lbsr  L12F1
         subd  <u0040
         subd  #$0002
         cmpd  #$007F
         bgt   L08D2
         cmpd  #$FF80
         bge   L08D9
L08D2    ldb   #$0D
         lbsr  L02FA
         ldb   #$FE
L08D9    stb   <u0063
         rts   
         leau  <L08FE,pcr
         bra   L08EF
         ldb   <u002B
         bitb  #$08
         beq   L08EC
         ldb   #$19
         lbsr  L02FA
L08EC    leau  <L0912,pcr
L08EF    lbsr  L1164
         ldb   <u0062
         lslb  
         ldd   b,u
         jmp   d,u
         leau  <L0924,pcr
         bra   L08EF
L08FE    fdb   $02A8
         fdb   $0349
         fdb   $03C1
         fdb   $036D
         fdb   $03AF
         fdb   $0329
         fdb   $0462
         fdb   $0442
         fdb   $032D
         fdb   $0453
L0912    fdb   $04A7
         fdb   $04AF
         fdb   $04C2
         fdb   $051A
         fdb   $04EB
         fdb   $04F1
         fdb   $04F7
         fdb   $05A1
         fdb   $05B2
L0924    fdb   $05BF
         fdb   $05C4
         fdb   $05C9
         fdb   $05CE
         fdb   $05D3
         fdb   $05D8
         fdb   $05DD
L0932    fcb   $17,$08,$2f,$81,$23,$26,$05,$30,$01
         andcc #$FE
         rts   
L093E    orcc  #$01
         rts   
L0941    ldb   <u0047
         bitb  #$40
         bne   L0948
         rts   
L0948    ldb   #$03
         stb   <u0046
         ldb   #$0C
         lbra  L02FA
L0951    lbsr  L12F1
         subd  <u0040
         subb  <u0046
         sbca  #$00
         std   <u0063
         cmpd  #$007F
         bgt   L096A
         cmpd  #$FF80
         blt   L096A
         inc   <u004F
L096A    rts   
L096B    leay  >L09A2,pcr
         pshs  x
         ldb   #$0C
L0973    lda   ,y
         beq   L098F
         cmpa  ,x+
         beq   L0981
         adda  #$20
         cmpa  -$01,x
         bne   L098F
L0981    lda   $01,y
         beq   L099A
         cmpa  ,x+
         beq   L099A
         adda  #$20
         cmpa  -$01,x
         beq   L099A
L098F    ldx   ,s
         leay  $03,y
         decb  
         bne   L0973
         orcc  #$01
         puls  pc,x
L099A    decb  
         leas  $02,s
         lda   $02,y
         andcc #$FE
         rts   
L09A2    lsra  
         negb  
         lsl   <u0043
         coma  
         oim   #$42,<u0000
         lsr   <u0041
         neg   <u0002
         neg   <u0000
         neg   <u0000
         neg   <u0000
         negb  
         coma  
         suba  #$53
         neg   <u0040
         fcb   $55 U
         neg   <u0040
         rolb  
         neg   <u0020
         lslb  
         neg   <u0010
         lsra  
         neg   <u0006
L09C6    lbsr  L1164
         bsr   L0A14
         cmpa  #$5B
         bne   L09D7
         inc   <u004D
         leax  $01,x
         lda   ,x
         bsr   L0A14
L09D7    cmpa  #$2C
         lbeq  L0A64
         ldb   $01,x
         cmpb  #$2C
         bne   L09F1
         anda  #$DF
         cmpa  #$41
         beq   L0A27
         cmpa  #$42
         beq   L0A2B
         cmpa  #$44
         beq   L0A2F
L09F1    lbsr  L12F1
         bcc   L09F8
         clra  
         clrb  
L09F8    std   <u004A
         lda   ,x
         cmpa  #$2C
         lbeq  L0B18
         ldb   <u004D
         bne   L0A35
         ldb   <u004C
         bmi   L0A35
         bne   L0A53
         lda   <u004A
         cmpa  <u003F
         beq   L0A53
         bra   L0A35
L0A14    ldb   #$FF
         cmpa  #$3E
         beq   L0A20
         cmpa  #$3C
         bne   L0A26
         ldb   #$01
L0A20    stb   <u004C
         leax  $01,x
         lda   ,x
L0A26    rts   
L0A27    ldb   #$86
         bra   L0A31
L0A2B    ldb   #$85
         bra   L0A31
L0A2F    ldb   #$8B
L0A31    leax  $01,x
         bra   L0A97
L0A35    ldd   <u004A
         inc   <u0046
         inc   <u0046
         inc   <u004F
         tst   <u004D
         bne   L0A4A
         std   <u0063
         ldb   #$30
         orb   <u0062
         stb   <u0062
         rts   
L0A4A    std   <u0064
         ldb   #$9F
         stb   <u0063
         lbra  L0AEA
L0A53    inc   <u0046
         ldb   <u004B
         stb   <u0063
         ldb   <u0062
         bitb  #$F0
         beq   L0A63
         orb   #$10
         stb   <u0062
L0A63    rts   
L0A64    leax  $01,x
         clr   <u004A
         clr   <u004B
         ldd   ,x
         cmpd  #$2D2D
         beq   L0A8D
         cmpa  #$2D
         beq   L0A93
         bsr   L0AC7
         lbcs  L0B68
         stb   <u0063
         ldd   ,x
         cmpd  #$2B2B
         beq   L0AAB
         cmpa  #$2B
         beq   L0AB1
         lbra  L0B22
L0A8D    leax  $01,x
         ldb   #$83
         bra   L0A97
L0A93    bsr   L0ABD
         ldb   #$82
L0A97    stb   <u0063
         leax  $01,x
         bsr   L0AC7
         bcc   L0AA5
L0A9F    ldb   #$13
         lbsr  L02FA
         clrb  
L0AA5    orb   <u0063
         stb   <u0063
         bra   L0AEA
L0AAB    ldb   #$81
         leax  $01,x
         bra   L0AB5
L0AB1    bsr   L0ABD
         ldb   #$80
L0AB5    leax  $01,x
         orb   <u0063
         stb   <u0063
         bra   L0AEA
L0ABD    tst   <u004D
         beq   L0AC6
         ldb   #$0C
         lbsr  L02FA
L0AC6    rts   
L0AC7    lda   ,x+
         anda  #$5F
         clrb  
         cmpa  #$58
         beq   L0AE2
         ldb   #$20
         cmpa  #$59
         beq   L0AE2
         ldb   #$40
         cmpa  #$55
         beq   L0AE2
         ldb   #$60
         cmpa  #$53
         bne   L0AE5
L0AE2    andcc #$FE
         rts   
L0AE5    leax  -$01,x
         orcc  #$01
         rts   
L0AEA    ldb   #$20
         orb   <u0062
         stb   <u0062
         inc   <u0046
         inc   <u004E
         tst   <u004D
         beq   L0B08
         ldb   #$10
         orb   <u0063
         stb   <u0063
         lda   ,x+
         cmpa  #$5D
         beq   L0B08
         ldb   #$14
         bra   L0B14
L0B08    lda   ,x
         cmpa  #$20
         beq   L0B17
         cmpa  #$0D
         beq   L0B17
         ldb   #$0C
L0B14    lbsr  L02FA
L0B17    rts   
L0B18    leax  $01,x
         bsr   L0AC7
         bcs   L0B68
         orb   <u0063
         stb   <u0063
L0B22    ldd   <u004A
         tst   <u004C
         bmi   L0B5A
         bne   L0B52
         ldd   <u004A
         bne   L0B32
         ldb   #$84
         bra   L0B62
L0B32    tst   <u004D
         bne   L0B46
         cmpd  #$000F
         bgt   L0B46
         cmpd  #$FFF0
         blt   L0B46
         andb  #$1F
         bra   L0B62
L0B46    cmpd  #$007F
         bgt   L0B5A
         cmpd  #$FF80
         blt   L0B5A
L0B52    stb   <u0064
         inc   <u0046
         ldb   #$88
         bra   L0B62
L0B5A    std   <u0064
         inc   <u0046
         inc   <u0046
         ldb   #$89
L0B62    orb   <u0063
         stb   <u0063
         bra   L0AEA
L0B68    ldd   ,x
         anda  #$5F
         andb  #$5F
         cmpd  #$5043
         lbne  L0A9F
         leax  $02,x
         lda   ,x
         anda  #$5F
         cmpa  #$52
         bne   L0B82
         leax  $01,x
L0B82    inc   <u0046
         ldd   <u004A
         subd  <u0040
         subb  <u0046
         sbca  #$00
         subd  #$0001
         tst   <u004C
         bmi   L0B9B
         beq   L0B9B
         stb   <u0064
         ldb   #$8C
         bra   L0B62
L0B9B    subd  #$0001
         inc   <u0046
         std   <u0064
         ldb   #$8D
         bra   L0B62
         bsr   L0BE4
         pshs  b,a
         addd  <u0026
         std   <u0026
         bsr   L0BEF
         beq   L0BB6
         lda   #$04
         bsr   L0BF7
L0BB6    bsr   L0BD8
         bsr   L0BEF
         beq   L0BBE
         bsr   L0C0A
L0BBE    addd  ,s++
L0BC0    pshs  a
         lda   <u002B
         anda  #$08
         ora   #$31
         sta   <u002B
         puls  a
         tst   <u005A
         beq   L0BD3
         std   <u0040
         rts   
L0BD3    std   <u0042
         inc   <u002C
         rts   
L0BD8    tst   <u005A
         beq   L0BDF
         ldd   <u0040
         rts   
L0BDF    ldd   <u0042
         std   <u0044
         rts   
L0BE4    lbsr  L11C2
         bcc   L0BEE
         lbsr  L02FA
         clra  
         clrb  
L0BEE    rts   
L0BEF    pshs  a
         lda   <u002B
         bita  #$08
         puls  pc,a
L0BF7    ldu   <u002D
         ldb   u0008,u
         bmi   L0C09
         cmpb  #$02
         bne   L0C07
         cmpa  #$02
         beq   L0C07
         ora   #$80
L0C07    sta   u0008,u
L0C09    rts   
L0C0A    tst   <u003E
         ble   L0C24
         cmpd  u0009,u
         beq   L0C26
         pshs  b,a
         lda   u0008,u
         bmi   L0C22
         cmpa  #$02
         beq   L0C22
         ldb   #$0A
         lbsr  L02FA
L0C22    puls  b,a
L0C24    std   u0009,u
L0C26    rts   
         lda   #$03
         bra   L0C2D
         lda   #$02
L0C2D    bsr   L0BEF
         bne   L0C38
         ldb   #$15
         lbsr  L02FA
         bra   L0C46
L0C38    bsr   L0BF7
         bsr   L0BE4
         ldu   <u002D
         bsr   L0C0A
         std   <u0044
         ldb   #$39
         stb   <u002B
L0C46    rts   
         lda   ,x+
         pshs  a
         cmpa  #$0D
         beq   L0C64
         cmpa  #$2F
         bhi   L0C64
         bsr   L0C8D
L0C55    lda   ,x+
         cmpa  ,s
         beq   L0C69
         cmpa  #$0D
         beq   L0C64
         lbsr  L0CEC
         bra   L0C55
L0C64    ldb   #$17
         lbsr  L02FA
L0C69    puls  pc,a
         lda   ,x+
         pshs  a
         cmpa  #$0D
         beq   L0C64
         cmpa  #$2F
         bhi   L0C64
         bsr   L0C8D
L0C79    ldd   ,x+
         cmpa  #$0D
         beq   L0C64
         cmpa  ,s
         beq   L0C69
         cmpb  ,s
         bne   L0C89
         ora   #$80
L0C89    bsr   L0CEC
         bra   L0C79
L0C8D    pshs  x,a
         leax  -$01,x
L0C91    leax  $01,x
         lda   ,x
         cmpa  #$0D
         beq   L0CA1
         cmpa  ,s
         bne   L0C91
         leax  $01,x
         lda   ,x
L0CA1    clr   ,x+
         stx   <u0033
         cmpa  #$0D
         bne   L0CAB
         sta   ,x
L0CAB    puls  pc,x,a
         bsr   L0CD5
L0CAF    lbsr  L12F7
         tfr   b,a
         bsr   L0CEC
         lda   ,x+
         cmpa  #$2C
         beq   L0CAF
         leax  -$01,x
         rts   
         bsr   L0CD5
L0CC1    lbsr  L12F1
         pshs  b
         bsr   L0CEC
         puls  a
         bsr   L0CEC
         lda   ,x+
         cmpa  #$2C
         beq   L0CC1
         leax  -$01,x
         rts   
L0CD5    pshs  x
L0CD7    lbsr  L12F1
         lda   ,x+
         cmpa  #$2C
         beq   L0CD7
         clr   -$01,x
         stx   <u0033
         cmpa  #$0D
         bne   L0CEA
         sta   ,x
L0CEA    puls  pc,x
L0CEC    ldb   <u0046
         cmpb  #$04
         bcs   L0CF4
         bsr   L0D03
L0CF4    pshs  b,a
         tfr   dp,a
         ldb   #$62
         tfr   d,u
         puls  b,a
         sta   b,u
         inc   <u0046
         rts   
L0D03    pshs  x,b,a
         ldb   <u002A
         bne   L0D14
         ldx   <u0033
         lbsr  L01C4
         tst   <u005B
         beq   L0D27
         bra   L0D30
L0D14    tst   <u005B
         bne   L0D2D
         lda   <u0056
         pshs  a
         clr   <u0056
         com   <u0056
         lbsr  L01D3
         puls  a
         sta   <u0056
L0D27    ldb   #$04
         stb   <u002B
         bra   L0D34
L0D2D    lbsr  L01D3
L0D30    ldb   #$05
         stb   <u002B
L0D34    ldd   <u0040
         std   <u0044
         clr   <u0046
         inc   <u002A
         clr   $01,s
         puls  pc,x,b,a
         ldd   <u0051
         coma  
         comb  
         std   <u0062
         ldb   <u0053
         comb  
         lda   <u002B
         anda  #$DF
         sta   <u002B
         bra   L0D59
         ldd   #$103F
         std   <u0062
         lbsr  L12F7
L0D59    stb   <u0064
         ldb   #$03
         stb   <u0046
         rts   
         clra  
         clrb  
         stb   <u0050
         std   <u0040
         std   <u0044
         std   <u0042
         lbsr  L1360
         lbsr  L0CD5
         ldd   #$87CD
         bsr   L0D93
         bsr   L0D90
         bsr   L0D8E
         bsr   L0DA9
         bsr   L0DA4
         bsr   L0DA9
         bsr   L0DA4
         lda   <u0050
         coma  
         bsr   L0DA1
         lda   ,x
         cmpa  #$2C
         bne   L0DB8
         bsr   L0D8E
L0D8E    bsr   L0DA9
L0D90    lbsr  L12F1
L0D93    pshs  b
         tfr   a,b
         bsr   L0D9B
         puls  b
L0D9B    tfr   b,a
         eorb  <u0050
         stb   <u0050
L0DA1    lbra  L0CEC
L0DA4    lbsr  L12F7
         bra   L0D9B
L0DA9    lda   ,x+
         cmpa  #$2C
         beq   L0DB8
         leax  -$01,x
         ldb   #$17
         lbsr  L02FA
         leas  $02,s
L0DB8    rts   
         lbsr  L0BE4
         std   <u0044
         lbra  L0BC0
         ldb   <u002B
         andb  #$08
         orb   #$10
         stb   <u002B
         lbsr  L01F2
         lbsr  L156C
         bcc   L0DD3
         leas  $04,s
L0DD3    rts   
         ldb   #$27
         ldu   <u000A
L0DD8    lbsr  L1164
         lda   <u003E
         bne   L0DE3
         lda   ,u
         bne   L0DFC
L0DE3    lda   ,x+
         cmpa  #$0D
         beq   L0DF4
         sta   ,u+
         decb  
         bne   L0DE3
         lda   #$0D
L0DF0    cmpa  ,x+
         bne   L0DF0
L0DF4    clr   ,u
         leax  -$01,x
         ldb   #$30
         stb   <u002B
L0DFC    rts   
         ldb   #$4F
         ldu   <u0008
         bra   L0DD8
         lbsr  L1408
L0E06    leas  $02,s
         rts   
         bsr   L0E21
         bcc   L0E12
         ldb   #$30
         stb   <u002B
         rts   
L0E12    stb   ,-s
         beq   L0E1D
L0E16    lbsr  L149A
         dec   ,s
         bne   L0E16
L0E1D    leas  $01,s
         bra   L0E06
L0E21    lbsr  L10B4
         bcc   L0E2B
         lbsr  L02FA
         orcc  #$01
L0E2B    rts   
L0E2C    ldb   #$30
         stb   <u002B
         lbsr  L1164
L0E33    clr   ,-s
         lda   ,x+
         cmpa  #$2D
         bne   L0E3F
         com   ,s
         lda   ,x+
L0E3F    leau  <L0EA3,pcr
         ldb   #$08
         cmpa  #$61
         bcs   L0E4A
         suba  #$20
L0E4A    cmpa  ,u++
         beq   L0E68
         decb  
         bne   L0E4A
         puls  b
         cmpa  #$44
         beq   L0E88
         cmpa  #$57
         beq   L0E80
         cmpa  #$4C
         beq   L0E90
         cmpa  #$4E
         beq   L0E9B
L0E63    ldb   #$16
         lbra  L02FA
L0E68    ldb   -u0001,u
         tfr   dp,a
         tfr   d,u
         puls  a
         coma  
         sta   ,u
L0E73    lda   ,x+
         cmpa  #$2C
         beq   L0E33
         cmpa  #$20
         beq   L0E2C
         leax  -$01,x
         rts   
L0E80    bsr   L0E21
         bcs   L0E63
         stb   <u0037
         bra   L0E73
L0E88    bsr   L0E21
         bcs   L0E63
         stb   <u0036
         bra   L0E73
L0E90    tstb  
         beq   L0E97
         dec   <u0056
         bra   L0E73
L0E97    inc   <u0056
         bra   L0E73
L0E9B    inc   <u0060
         lda   #$1F
         sta   <u0037
         bra   L0E97
L0EA3    coma  
         clrb  
         rora  
         rolb  
         tsta  
         decb  
         asra  
         fcb   $5B [
         fcb   $45 E
         incb  
         comb  
         fcb   $5E ^
         rola  
         tstb  
         clra  
         lslb  
         lbsr  L12F7
         bcs   L0EBA
         stb   <u003F
L0EBA    clra  
         std   <u0044
         ldb   #$31
         stb   <u002B
         inc   <u002C
         rts   
         lbsr  L1164
         lbsr  L15FB
         bra   L0ECE
L0ECC    leax  -$01,x
L0ECE    ldb   -$01,x
         cmpb  #$20
         beq   L0ECC
         ldu   <u001F
         ldb   <u0018
         pshu  b
         stu   <u001F
         sta   <u0018
         ldb   #$30
         stb   <u002B
         rts   
         bsr   L0F0F
         bne   L0F0C
         rts   
         bsr   L0F0F
         beq   L0F0C
         rts   
         bsr   L0F0F
         bge   L0F0C
         rts   
         bsr   L0F0F
         bgt   L0F0C
         rts   
         bsr   L0F0F
         blt   L0F0C
         rts   
         bsr   L0F0F
         ble   L0F0C
         rts   
         inc   <u0055
         ldb   #$10
         bsr   L0F21
         lda   <u003E
         bne   L0F0C
         rts   
L0F0C    inc   <u0054
         rts   
L0F0F    inc   <u0055
         ldb   #$30
         bsr   L0F21
         lbsr  L12F1
         bcc   L0F1C
         puls  pc,b,a
L0F1C    cmpd  #$0000
         rts   
L0F21    tst   <u005F
         bne   L0F26
         clrb  
L0F26    stb   <u002B
         rts   
         ldb   #$10
         bsr   L0F21
         lda   <u0055
         beq   L0F42
         lda   <u0062
         bne   L0F3B
         dec   <u0055
         lda   <u0054
         beq   L0F41
L0F3B    lda   <u0054
         beq   L0F0C
         dec   <u0054
L0F41    rts   
L0F42    ldb   #$1A
         lbsr  L02FA
         clr   <u0054
         rts   
L0F4A    pshs  u,y,x
         bsr   L0FC3
         stx   <u002D
         ldb   <u003E
         bgt   L0F7D
         bcc   L0F63
         lda   #$01
         ldu   <u0040
         lbsr  L100B
         stx   <u002D
         bcc   L0F9E
         bra   L0F9A
L0F63    cmpa  #$00
         bne   L0F71
         lda   #$01
         ldu   <u0040
         sta   $08,x
         stu   $09,x
         bra   L0F9E
L0F71    cmpa  #$02
         beq   L0F9E
         ora   #$80
         sta   $08,x
L0F79    ldb   #$08
         bra   L0F9A
L0F7D    bcc   L0F83
L0F7F    ldb   #$09
         bra   L0F9A
L0F83    cmpa  #$00
         beq   L0F7F
         bita  #$80
         bne   L0F79
         cmpa  #$01
         bne   L0F9E
         ldd   <u0040
         cmpd  $09,x
         beq   L0F9E
         std   $09,x
         ldb   #$0A
L0F9A    orcc  #$01
         puls  pc,u,y,x
L0F9E    andcc #$FE
         puls  pc,u,y,x
L0FA2    pshs  u,y,x
         bsr   L0FC3
         ldb   <u003E
         bne   L0FBB
         bcc   L0FB7
         lda   #$00
         ldu   #$0000
         bsr   L100B
         bcs   L0F9A
         bra   L0F9E
L0FB7    ldd   $09,x
         bra   L0F9E
L0FBB    lda   $08,x
         cmpa  #$00
         bne   L0FB7
         bra   L0F7F
L0FC3    bsr   L0FFA
         ldx   ,x
         bne   L0FCD
         leay  ,x
         bra   L0FF7
L0FCD    pshs  x
         ldy   <u0016
         ldb   #$08
L0FD4    lda   ,y+
         beq   L0FE5
         cmpa  ,x+
         bne   L0FE9
         decb  
         bne   L0FD4
L0FDF    puls  x
         lda   $08,x
         clrb  
         rts   
L0FE5    cmpa  ,x+
         beq   L0FDF
L0FE9    puls  y
         bhi   L0FF3
         ldx   $0B,y
         bne   L0FCD
         bra   L0FF7
L0FF3    ldx   $0D,y
         bne   L0FCD
L0FF7    orcc  #$01
         rts   
L0FFA    ldx   <u0016
         ldb   ,x
         ldx   <u0010
         subb  #$41
         cmpb  #$20
         bcs   L1008
         subb  #$06
L1008    lslb  
         abx   
         rts   
L100B    ldx   <u001D
         pshs  x,a
         leax  $0F,x
         cmpx  <u0012
         bcs   L1023
         ldb   #$0B
L1017    clr   <u0056
         lda   #$01
         sta   <u003E
         lbsr  L02FA
         lbra  L15E9
L1023    stx   <u001D
         sty   ,--s
         bne   L1032
         leas  $02,s
         bsr   L0FFA
         leay  -$0B,x
         bra   L1040
L1032    ldx   <u0016
L1034    lda   ,x+
         cmpa  ,y+
         beq   L1034
         puls  y
         bcs   L1040
         leay  $02,y
L1040    ldx   $01,s
         stx   $0B,y
         ldy   <u0016
         lda   ,y+
L1049    sta   ,x+
         lda   ,y+
         bne   L1049
         puls  x,a
         sta   $08,x
         stu   $09,x
         clrb  
         rts   
L1057    bsr   L1065
         bra   L105D
         bsr   L106B
L105D    pshs  a
         lda   #$20
         sta   ,x+
         puls  pc,a
L1065    exg   a,b
         bsr   L106B
         tfr   a,b
L106B    pshs  b
         andb  #$F0
         lsrb  
         lsrb  
         lsrb  
         lsrb  
         bsr   L1079
         puls  b
         andb  #$0F
L1079    cmpb  #$09
         bls   L107F
         addb  #$07
L107F    addb  #$30
         stb   ,x+
         rts   
L1084    pshs  u,y,b
         leau  >L10AA,pcr
         ldy   #$0005
L108E    clr   ,s
L1090    subd  ,u
         bcs   L1098
         inc   ,s
         bra   L1090
L1098    addd  ,u++
         pshs  b
         ldb   $01,s
         addb  #$30
         stb   ,x+
         puls  b
         leay  -$01,y
         bne   L108E
         puls  pc,u,y,b
L10AA    fdb   $2710
         fdb   $03E8
         fdb   $0064
         fdb   $000A
         fdb   $0001
L10B4    lbsr  L1164
         leax  $01,x
         cmpa  #$25
         beq   L111D
         cmpa  #$24
         beq   L10C5
         leax  -$01,x
         bra   L10F7
L10C5    leas  -$04,s
         bsr   L1134
L10C9    bsr   L113B
         bcc   L10DD
         cmpb  #$61
         bcs   L10D3
         subb  #$20
L10D3    cmpb  #$41
         bcs   L114D
         cmpb  #$46
         bhi   L114D
         subb  #$37
L10DD    stb   ,s
         ldd   $02,s
         bita  #$F0
         bne   L1160
         lslb  
         rola  
         lslb  
         rola  
         lslb  
         rola  
         lslb  
         rola  
         addb  ,s
         adca  #$00
         std   $02,s
         inc   $01,s
         bra   L10C9
L10F7    leas  -$04,s
         bsr   L1134
L10FB    bsr   L113B
         bcs   L114D
         stb   ,s
         ldd   $02,s
         lslb  
         rola  
         std   $02,s
         lslb  
         rola  
         lslb  
         rola  
         bcs   L1160
         addd  $02,s
         bcs   L1160
         addb  ,s
         adca  #$00
         bcs   L1160
         std   $02,s
         inc   $01,s
         bra   L10FB
L111D    leas  -$04,s
         bsr   L1134
L1121    ldb   ,x+
         subb  #$30
         bcs   L114D
         lsrb  
         bne   L114D
         rol   $03,s
         rol   $02,s
         bcs   L1160
         inc   $01,s
         bra   L1121
L1134    clra  
         clrb  
         std   $02,s
         std   $04,s
         rts   
L113B    ldb   ,x+
         cmpb  #$30
         bcs   L1145
         cmpb  #$39
         bls   L1148
L1145    orcc  #$01
         rts   
L1148    subb  #$30
         andcc #$FE
         rts   
L114D    leax  -$01,x
         tst   $01,s
         beq   L1159
         ldd   $02,s
         andcc #$FE
         bra   L115D
L1159    orcc  #$04
L115B    orcc  #$01
L115D    leas  $04,s
         rts   
L1160    andcc #$FB
         bra   L115B
L1164    lda   ,x+
         cmpa  #$20
         beq   L1164
         leax  -$01,x
         rts   
L116D    pshs  x,b,a
         lda   $03,s
         mul   
         pshs  b,a
         lda   $02,s
         ldb   $05,s
         mul   
         addb  ,s
         stb   ,s
         lda   $03,s
         ldb   $04,s
         mul   
         addb  ,s
         stb   ,s
         ldd   ,s
         ldx   #$0000
         leas  $06,s
         rts   
L118E    pshs  y,x,b,a
         ldd   ,s
         bne   L1198
         orcc  #$01
         bra   L11B8
L1198    ldd   #$0010
         stb   $04,s
         clrb  
L119E    lsl   $03,s
         rol   $02,s
         rolb  
         rola  
         subd  ,s
         bmi   L11AC
         inc   $03,s
         bra   L11AE
L11AC    addd  ,s
L11AE    dec   $04,s
         bne   L119E
         tfr   d,x
         ldd   $02,s
         andcc #$FE
L11B8    leas  $06,s
         rts   
L11BB    sta   ,x+
L11BD    lda   ,y+
         bne   L11BB
         rts   
L11C2    pshs  u,y
         leau  ,s
         bsr   L1164
         bsr   L11D0
         andcc #$FE
         puls  pc,u,y
L11CE    leax  $01,x
L11D0    bsr   L1211
         pshs  b,a
L11D4    lda   ,x
         cmpa  #$2D
         bne   L11E2
         bsr   L120F
         nega  
         negb  
         sbca  #$00
         bra   L11E8
L11E2    cmpa  #$2B
         bne   L11EE
         bsr   L120F
L11E8    addd  ,s
         std   ,s
         bra   L11D4
L11EE    tsta  
         beq   L120D
         cmpa  #$0D
         beq   L120D
         cmpa  #$20
         beq   L120D
         cmpa  #$2C
         beq   L120D
         cmpa  #$29
         beq   L120D
         cmpa  #$5D
         beq   L120D
L1205    ldb   #$06
L1207    leas  ,u
         orcc  #$01
         puls  pc,u,y
L120D    puls  pc,b,a
L120F    leax  $01,x
L1211    bsr   L123F
         pshs  b,a
L1215    lda   ,x
         cmpa  #$2F
         bne   L122A
         bsr   L123D
         pshs  x
         ldx   $02,s
         lbsr  L118E
         bcc   L1237
         ldb   #$04
         bra   L1207
L122A    cmpa  #$2A
         bne   L120D
         bsr   L123D
         pshs  x
         ldx   $02,s
         lbsr  L116D
L1237    puls  x
         std   ,s
         bra   L1215
L123D    leax  $01,x
L123F    bsr   L126D
         pshs  b,a
L1243    lda   ,x
         cmpa  #$26
         bne   L1251
         bsr   L126B
         andb  $01,s
         anda  ,s
         bra   L1267
L1251    cmpa  #$21
         bne   L125D
         bsr   L126B
         orb   $01,s
         ora   ,s
         bra   L1267
L125D    cmpa  #$3F
         bne   L120D
         bsr   L126B
         eorb  $01,s
         eora  ,s
L1267    std   ,s
         bra   L1243
L126B    leax  $01,x
L126D    lda   ,x
         cmpa  #$5E
         bne   L1279
         bsr   L1284
         comb  
         coma  
         bra   L1283
L1279    cmpa  #$2D
         bne   L1286
         bsr   L1284
         nega  
         negb  
         sbca  #$00
L1283    rts   
L1284    leax  $01,x
L1286    lda   ,x
         cmpa  #$28
         bne   L12A2
         lbsr  L11CE
         pshs  b,a
         lda   ,x
         cmpa  #$29
         puls  b,a
         beq   L12B6
         ldb   <u0007
         bra   L129D
L129D    leas  $02,s
L129F    lbra  L1207
L12A2    cmpa  #$2A
         bne   L12AA
         ldd   <u0040
         bra   L12B6
L12AA    tst   <u005A
         bne   L12B9
         cmpa  #$2E
         bne   L12B9
         ldd   <u0042
         inc   <u002C
L12B6    leax  $01,x
         rts   
L12B9    cmpa  #$27
         bne   L12C5
         ldd   ,x++
         cmpb  #$0D
         beq   L12D6
         clra  
         rts   
L12C5    cmpa  #$22
         bne   L12D9
         leax  $01,x
         ldd   ,x++
         cmpa  #$0D
         beq   L12D6
         cmpb  #$0D
         beq   L12D6
         rts   
L12D6    lbra  L1205
L12D9    lbsr  L10B4
         bcc   L12EE
         beq   L12E4
         ldb   #$03
         bra   L129F
L12E4    lbsr  L0368
         bcs   L12D6
         lbsr  L0FA2
         bcs   L129F
L12EE    andcc #$FE
         rts   
L12F1    lbsr  L11C2
         bcs   L1304
L12F6    rts   
L12F7    lbsr  L11C2
         bcs   L1304
         tsta  
         beq   L12F6
         inca  
         beq   L12F6
         ldb   #$0E
L1304    lbsr  L02FA
         ldd   #$FFFF
         orcc  #$01
         rts   
L130D    bsr   L134D
         pshs  x,b,a
         ldx   <u001B
         sta   ,x+
         stx   <u001B
         cmpx  <u0010
         bcs   L1321
         bsr   L1323
         ldx   <u000E
         stx   <u001B
L1321    puls  pc,x,b,a
L1323    pshs  y,x,b,a
         lda   <u0058
         beq   L1340
         lda   <u003E
         beq   L1340
         ldd   <u001B
         subd  <u000E
         beq   L1340
         tfr   d,y
         ldx   <u000E
         lda   <u0019
         beq   L1340
         os9   I$Write  
         bcs   L1342
L1340    puls  pc,y,x,b,a
L1342    os9   F$PErr   
         ldb   #$12
         lbsr  L02FA
         lbra  L15A2
L134D    pshs  u,y,x,b,a
         leax  ,s
         ldy   #$0001
         tfr   dp,a
         ldb   #$51
         tfr   d,u
         os9   F$CRC    
         puls  pc,u,y,x,b,a
L1360    ldd   #$FFFF
         std   <u0051
         stb   <u0053
         rts   
L1368    lda   <u0057
         beq   L139A
         lda   <u0056
         bmi   L139A
L1370    lda   <u0035
         bne   L137B
         pshs  x
         lbsr  L1408
         puls  x
L137B    bsr   L138A
         lda   <u003E
         beq   L1387
         lda   <u0056
         bmi   L1387
         dec   <u0035
L1387    ldx   <u0004
         rts   
L138A    lda   <u0057
         beq   L1392
         lda   <u0056
         bpl   L139A
L1392    lda   <u005C
         beq   L1387
         lda   <u0021
         beq   L1387
L139A    lda   <u003E
         beq   L1387
         pshs  y,a
         bsr   L13B8
         clra  
         ldb   <u0037
         ldx   <u0004
         leax  d,x
         bsr   L13B8
         ldx   <u0004
         ldy   #$0085
         lda   <u001A
         os9   I$WritLn 
         puls  pc,y,a
L13B8    lda   #$0D
         sta   ,x+
         rts   
L13BD    leas  -$06,s
         pshs  x
         leax  $02,s
         os9   F$Time   
         puls  x
         bcs   L13F0
         lda   $01,s
         bsr   L13F7
         ldb   #$2F
         stb   ,x+
         lda   $02,s
         bsr   L13F7
         stb   ,x+
         lda   ,s
* 1900-2155 fix
         cmpa  #100
         blo   L1900
         suba  #100
         cmpa  #100
         blo   L2000
L2100    suba  #100
         pshs  a
         lda   #21
         bra   PrtCty
L2000    pshs  a
         lda   #20
         bra   PrtCty
L1900    pshs  a
         lda   #19
PrtCty   bsr   L13F7
         puls  a
         bsr   L13F7
         bsr   L13F2
         lda   $03,s
         bsr   L13F7
         ldb   #$3A
         stb   ,x+
         lda   $04,s    minute
         bsr   L13F7
         stb   ,x+
         lda   $05,s
         bsr   L13F7
L13F0    leas  $06,s
L13F2    lda   #$20
         sta   ,x+
         rts   
L13F7    pshs  b
         ldb   #$2F
L13FB    incb  
         suba  #$0A
         bcc   L13FB
         stb   ,x+
         adda  #$3A
         sta   ,x+
         puls  pc,b
L1408    lda   <u0056
         bmi   L1476
         lda   <u0059
         beq   L1414
         bsr   L147D
         bra   L141A
L1414    ldb   <u0035
         addb  #$03
         bsr   L1471
L141A    ldx   <u0004
         pshs  x
         ldx   <u0002
         stx   <u0004
         ldb   <u0036
         subb  #$04
         stb   <u0035
         lbsr  L01E5
         leay  <L14A5,pcr
         lbsr  L11BD
         lbsr  L13BD
         ldx   <u0004
         clra  
         ldb   <u0037
         subb  #$06
         leax  d,x
         ldd   <u003A
         lbsr  L1084
         inc   <u003B
         bne   L1447
         inc   <u003A
L1447    leax  -$08,x
         leay  <L149F,pcr
         lbsr  L11BD
         leax  $03,x
         lbsr  L1370
         ldy   <u000A
         lbsr  L11BD
         bsr   L13F2
         lda   #$2D
         sta   ,x+
         bsr   L13F2
         ldy   <u0008
         lbsr  L11BD
         lbsr  L1370
         puls  x
         stx   <u0004
         ldb   #$01
L1471    bsr   L1479
         decb  
         bne   L1471
L1476    ldx   <u0004
         rts   
L1479    lda   #$0D
         bra   L147F
L147D    lda   #$0C
L147F    pshs  y,x,b,a
         lda   <u003E
         beq   L1498
         lda   <u0057
         beq   L1498
         lda   <u0056
         bmi   L1498
         lda   <u001A
         tfr   s,x
         ldy   #$0001
         os9   I$WritLn 
L1498    puls  pc,y,x,b,a
L149A    ldx   <u0004
         lbra  L1370
L149F    fcc   "Page "
         fcb   $00
L14A5    fcc   "Microware OS-9 Assembler RS Version 01.00.00    "
         fcb   $00
L14D6    fcc   " error(s)"
         fcb   $00
L14E0    fcc   " warning(s)"
         fcb   $00
L14EC    fcc   " program bytes generated"
         fcb   $00
L1505    fcc   " data bytes allocated"
         fcb   $00
L151B    fcc   " bytes used for symbols"
         fcb   $00
L1533    fcc   "ASM:"
L1537    pshs  u,y,x,b,a
         lda   <u005D
         beq   L1549
         leax  <L1533,pcr
         ldy   #$0004
         lda   <u001A
         os9   I$Write  
L1549    ldx   <u0000
         ldy   #$0078
         lda   <u0018
L1551    os9   I$ReadLn 
         bcc   L156A
         cmpb  #$D3
         bne   L1560
         bsr   L156C
         bcc   L1549
L155E    bra   L156A
L1560    os9   F$PErr   
         ldb   #$11
         lbsr  L02FA
         bsr   L156C
L156A    puls  pc,u,y,x,b,a
L156C    ldu   <u001F
L156E    cmpu  <u0006
         bne   L1576
         orcc  #$01
         rts   
L1576    lda   <u0018
         pulu  b
         stu   <u001F
         stb   <u0018
         os9   I$Close  
         bcc   L1586
         os9   F$PErr   
L1586    rts   
L1587    pshs  b,a
         lda   #$24
         sta   ,x+
         ldd   ,s
         lbsr  L1057
         puls  b,a
L1594    lbsr  L1084
         tfr   u,y
         lbsr  L11BD
         lbra  L1368
L159F    lbsr  L1323
L15A2    lbsr  L149A
         ldd   <u0028
         leau  >L14D6,pcr
         bsr   L1594
         ldd   <u0022
         leau  >L14E0,pcr
         bsr   L1594
         ldd   <u0024
         leau  >L14EC,pcr
         bsr   L1587
         ldd   <u0026
         leau  >L1505,pcr
         bsr   L1587
         ldd   <u001D
         subd  <u0010
         leau  >L151B,pcr
         bsr   L1587
         lda   <u005E
         beq   L15D5
         bsr   L1612
L15D5    lda   <u005D
         bne   L15E9
         lda   <u0059
         beq   L15E2
         lbsr  L147D
         bra   L15E9
L15E2    ldb   <u0035
         addb  #$03
         lbsr  L1471
L15E9    ldu   <u001F
L15EB    cmpu  <u0006
         beq   L15F7
         pulu  a
         os9   I$Close  
         bra   L15EB
L15F7    clrb  
         os9   F$Exit   
L15FB    lda   #$01
         os9   I$Open   
         ldb   #$18
         lbcs  L1017
         rts   
L1607    lda   <u0018
         ldu   #$0000
         tfr   u,x
         os9   I$Seek   
         rts   
L1612    ldb   <u0037
         clra  
         tfr   d,x
         ldb   #$10
         lbsr  L118E
         stb   <u003D
         stb   <u003C
         lbsr  L149A
         ldu   <u0010
         ldb   #$1A
         pshs  b
L1629    ldy   ,u++
         beq   L1656
L162E    pshs  u,y
         bra   L1644
L1632    leau  ,y
         tfr   d,y
L1636    ldd   $0B,y
         bne   L1632
         bsr   L165F
         ldy   $0D,y
         sty   u000B,u
         bne   L1636
L1644    ldu   ,s
         ldy   u000B,u
         bne   L1636
         leay  ,u
         bsr   L165F
         puls  u,y
         ldy   $0D,y
         bne   L162E
L1656    dec   ,s
         bne   L1629
         leas  $01,s
         lbra  L1370
L165F    pshs  u,y
         ldd   $09,y
         lbsr  L1057
         lda   $08,y
         leau  <L1691,pcr
         lda   a,u
         ldb   #$20
         std   ,x++
         ldb   #$08
L1673    lda   ,y+
         bne   L1679
         lda   #$20
L1679    sta   ,x+
         decb  
         bne   L1673
         dec   <u003C
         beq   L1688
         lda   #$20
         sta   ,x+
         bra   L168F
L1688    lbsr  L1370
         ldb   <u003D
         stb   <u003C
L168F    puls  pc,u,y
L1691    fcb   $55 U
         inca  
         comb  
         fcb   $45 E
         lsra  
L1696    pshs  y,x
         lbsr  L15FB
         sta   <u0018
L169D    lbsr  L1164
         cmpa  #$0D
         beq   L16CF
         lbsr  L0E33
         lda   <u0058
         beq   L16CF
         lda   -$01,x
         anda  #$5F
         cmpa  #$0D
         beq   L16C7
         ldb   ,x
         cmpd  #$4F3D
         bne   L16C7
         ldb   #$16
         lda   <u0019
         bne   L16D1
         leax  $01,x
         bsr   L16D4
         bra   L169D
L16C7    lda   <u0019
         bne   L16CF
         ldx   ,s
         bsr   L16D4
L16CF    puls  pc,y,x
L16D1    lbra  L1017
L16D4    lda   #$06
         ldb   #$2F
         os9   I$Create 
         ldb   #$18
         bcs   L16D1
         sta   <u0019
         rts   

         emod
eom      equ   *
         end

