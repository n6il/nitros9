********************************************************************
* Asm - 6809/6309 Assembler
*
* ASM V1.6 - Microware version - 6309 instruction assembly by
*  L. Curtis Boyle
*
* Obtained by Boisy Pitre from L. Curits Boyle on 10/12/2002
*
* $Id$
*
* Ed.    Comments                                       Who YY/MM/DD
* ------------------------------------------------------------------
*   6    Made compliant with 1900-2155                  BGP 99/05/11

         nam   Asm
         ttl   6809/6309 Assembler

         ifp1
         use   defsfile
         endc

tylg     set   Prgrm+Objct   
atrv     set   ReEnt+rev
rev      set   $02
edition  set   $06

         mod   eom,name,tylg,atrv,asm,size

* u002B Bit flag meanings: (Default=00110101)
LitLine  equ   %10000000      Literal line to print
Comment  equ   %01000000      Comment field present in source line
Operand  equ   %00100000      Operand field present in source line
Command  equ   %00010000      Mnemonic command present in source line
Label    equ   %00001000      Label field present in source line
NoObjct  equ   %00000100      No object code to print
PrintPC  equ   %00000001      Print PC flag
DoNothng equ   %00000000      Do nothing (no flags set)

Numop    equ   148            # of opcodes in table (including pseudo-ops)

u0000    rmb   2              Ptr to start of current source line
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
u0018    rmb   1              Path number to source file
u0019    rmb   1
u001A    rmb   1              Some output path number
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
u002B    rmb   1              Bit flags
u002C    rmb   1
u002D    rmb   1
u002E    rmb   1
u002F    rmb   2              Ptr to start of current mnemonic
u0031    rmb   2              Ptr to next field (or operand start)
u0033    rmb   1
u0034    rmb   1
u0035    rmb   1
u0036    rmb   1              Page height (default=66)
u0037    rmb   1              Page width (default=80)
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
u0046    rmb   1              # bytes in current instruction
u0047    rmb   1              Current instructions flags/index handler byte
u0048    rmb   1
u0049    rmb   1
u004A    rmb   1              MSB of 16 bit # (for addresses & offsets)
u004B    rmb   1              LSB of 16 bit #
u004C    rmb   1              Flag for DP($ff), Extended($01) or other($00) modes
u004D    rmb   1              Indirect mode flag (0=no, >0=Yes)
u004E    rmb   1              Indexed mode calc completed flag (0=no)
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
* The currently assembled instruction goes here
u0061    rmb   1              Current instruction's pre-byte (see u0046)
u0062    rmb   1              Current instruction's opcode
u0063    rmb   1              More bytes as needed by instruction
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
u00F8    rmb   3848           Main buffer area
size     equ   .
name     equ   *
         fcs   /Asm/
         fcb   edition
asm      tfr   u,d
         addd  #$01C0
         std   <u0014
         std   <u0016
         addd  #$0009
         std   <u0000         Start of current line in source ($1C9)
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
         adda  #$01
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
         ldb   #66            Default page height
         stb   <u0036
         ldb   #80            Default page width
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
         std   <u0061         Clear prefix opcode & opcode bytes
         std   <u0063
         sta   <u0065
         sta   <u0046         Clear # bytes for current instruction
         sta   <u002A
         sta   <u0021
         sta   <u004C         Default memory addressing mode to indexed
         sta   <u002C
         sta   <u004F
         sta   <u004E
         sta   <u004D
         lda   #Operand+Command+NoObjct+PrintPC
         sta   <u002B         Initialize flags
         ldd   <u0040
         std   <u0044
* Parse for label field
         ldx   <u0000         Get ptr to start of line
         lda   ,x             Get char
         cmpa  #$0D           Blank line?
         beq   L0136          Yes, go ahead
         cmpa  #'*            Comment line?
         beq   L0136          Ditto
         cmpa  #$20           Space? (No label field)
         beq   L0125          Yes, go somewhere else
* Label field found
         ldb   <u002B         Set Label Present flag
         orb   #Label
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
* Check for mnemonic field
L0125    lbsr  L1164          Find start of next field & get first char
         cmpa  #$0D           End of line yet?
         bne   L0141          No, have ptr to mnemonic field
         lda   <u002B         Get flags
         bita  #Label         Was a label present?
         beq   L0136          No, print whole source line as literal comment
         lda   #Label+PrintPC Set Label & Print PC flags (label on line by
         bra   L0138            itself)

L0136    lda   #LitLine       Whole line is comment flag
L0138    sta   <u002B         Save flags
         lda   <u0054
         bne   L018E
         lbra  L01F2
* Process mnemonic field
L0141    stx   <u002F         Save ptr to start of current mnemonic
L0143    lda   ,x+            Get char
         cmpa  #$0D           CR?
         beq   L0150          Yes, done line
         cmpa  #$20           Space?
         bne   L0143          No, continue getting chars
         lbsr  L1164          Find start of next field
L0150    stx   <u0031         Save ptr to possible operand field
         ldx   <u002F         Pointer to start of current op. in source code
         ldb   #Numop         # of instructions in main table
         leay  >L03B8,pc      Point to main opcode/pseudo-op table
         lbsr  L0344          Go point to it's opcode/flag bytes
         bcc   L0172          Legal opcode, go process
* Unknown mnemonic
L015F    ldb   #$02           Internal error #?
         lbsr  L02FA          Print error message
         ldb   #$03           Set # bytes of current instruction to 3???
         stb   <u0046
         lda   <u002B
         anda  #^Operand      Shut off operand present flag
         sta   <u002B
         ldx   <u0031         Get ptr to next field & skip ahead
         bra   L01C4
* Found mnemonic
* Entry: Y=Ptr to opcode/flag bytes
L0172    lda   <u0054         # of nested loop/if constructs???
         beq   L0195          If none, skip ahead???
         ldb   $01,y          Get flag bytes
         andb  #%00001111     Only want index handler #
         cmpb  #$0D           Pseudo op IFxx?
         bne   L0181          No, check next
         inca                 Inc nested loop counter?
         bra   L018C          Go save it & continue
L0181    cmpb  #$0E           Pseudo Op ELSE/ENDC?
         bne   L018E          No, check next
         deca                 Dec nested loop counter?
         beq   L0195          If down to zero, skip ahead
         ldb   ,y             Get opcode byte
         bne   L018E          If ELSE, skip ahead
L018C    sta   <u0054         Save updated nested loop counter?
L018E    inc   <u0039         ???
         bne   L0194
         inc   <u0038
L0194    rts   

* Calculate pre-bytes if needed (or known yet in 6309's case)
L0195    ldd   ,y             Get opcode/flag bytes
         sta   <u0062         Save opcode
         stb   <u0047         Save flags/index handler nibbles
         lda   #$10           Preload $10 prefix
         bitb  #$10           Does this opcode require it?
         bne   L01A7          Yes, go store before normal opcode byte
         lda   #$11           Preload $11 prefix
         bitb  #$20           Does this opcode require it?
         beq   L01AB          No prefix needed, skip ahead
L01A7    sta   <u0061         Save prebyte
         inc   <u0046         Increase byte count of current instruction

* Call proper index handler
L01AB    leay  >L0780,pc      Point to 'opcode type' index
         andb  #%00001111     Mask out non-index information
         lslb                 adjust for 2 bytes per offset entry
         ldd   b,y            Get offset
         jsr   d,y            Execute routine
         lda   <u002B         Operand present flag set?
         bita  #Operand
         beq   L01C4          No, skip ahead
         lda   ,x             Get next char in source code
         clr   ,x+            Clear that char in source line
         cmpa  #$0D           Was it a CR?
         beq   L01D3          Yes, skip ahead
L01C4    lbsr  L1164          Find next field
         cmpa  #$0D           End of line?
         beq   L01D3          Yes, skip ahead
         ldb   <u002B         Get flags
         beq   L01D3          If do nothing, skip ahead
         orb   #Comment       Set Comment field preseent flag
         stb   <u002B
L01D3    ldb   <u005D         One of the command line option flags???
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

* Error printing routine
* Entry: B=Internal error # (table entry #)
L02FA    pshs  u,y,x,d        Preserve regs
         tst   <u005C
         beq   L0325
         leay  >L061C,pc      Point to '***** Error' string
         ldx   <u0004
         lbsr  L11BD          Go print it
         clra                 Table offset is B-1
         decb  
         lslb                 Adjust for 2 byte entries
         leay  >L062A,pc      Point to some table
         ldd   d,y            Get 2 bytes @ offset D
         leay  d,y            Point to Y to offset
         lbsr  L11BD          Go print actual error message
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
L032D    puls  pc,u,y,x,d     Restore regs & return
         lbsr  L01E5
         ldb   #$18
         bsr   L02E2
         ldy   <u0000
         bra   L033D

L033B    sta   ,x+            Copy string up until CR & return
L033D    lda   ,y+
         cmpa  #$0D
         bne   L033B
         rts   
* Find opcode match
* Entry: Y=Table ptr to look in for match
*        X=Ptr to part of source we are currently checking
*        B=# opcodes in current table
* Exit: Carry set if no matching mnemonic found
*       Carry clear & Y is ptr to opcode & flag bytes is match IS found
L0344    pshs  x,b            Preserve source code ptr & # opcodes in table
L0346    lda   ,y+            Get byte from table
         bmi   L035E          If high bit set, skip ahead
         eora  ,x+            ???
         anda  #$DF           Uppercase conversion
         beq   L0346          If matches, keep doing until last character
L0350    lda   ,y+            Doesn't match, search for end of current entry
         bpl   L0350
L0354    leay  $02,y          Skip opcode & flag bytes too
         ldx   $01,s          Reset source code ptr to start of instruction
         decb                 Dec # opcodes counter
         bne   L0346          Check until all are done
         comb                 All done, illegal opcode
         puls  pc,x,b         Exit with error flag set
* Matches so far, on last byte of text mnemonic
L035E    eora  ,x+            ???
         anda  #$5F           Mask to uppercase & get rid of high bit
         bne   L0354          Doesn't match, check next
         leas  $03,s          Eat stack
         clrb                 No error & return
         rts   

L0368    lbsr  L1164
         bsr   L03A0
         bcs   L03B7
         pshs  u,y
         ldu   <u0016
         ldb   #$08           Max # chars in label?
         leax  1,x
         bra   L0393

* Copy label into label table (only use most significiant 8 chars)?
L0379    lda   ,x+            Get char
         bsr   L03A0          Check text chars
         bcc   L0393          Found one, skip special parsing
         cmpa  #'9            Higher than a 9?
         bhi   L039A          Yes, skip ahead
         cmpa  #'0            Is it a number?
         bhs   L0393          Yes, go process
         cmpa  #'.            Is it a period?
         beq   L0393          Yes, go process
         cmpa  #'$            Is it a dollar sign?
         beq   L0393          Yes, go process
         cmpa  #'_            Is it an underscore?
         bne   L039A          No, skip ahead
* A=numeric, period, dollar sign or underscore
L0393    sta   ,u+            Store character in label index
         decb                 Do all 8 chars
         bne   L0379
         bra   L039C          Skip ahead
L039A    leax  -1,x
L039C    clr   ,u+            Append a NUL
         puls  pc,u,y         Restore regs & return

L03A0    cmpa  #'A            Uppercase A?
         blo   L03B5          Lower, return
         cmpa  #'Z            If higher than uppercase Z, check for lower
         bhi   L03AD
L03A8    anda  #$5F           Force to uppercase (redundant if already upper)
         andcc #$FE           Clear carry (found text byte) & return
         rts   
L03AD    cmpa  #'a            If between 'Z' & 'a', we didn't find text char
         blo   L03B5
         cmpa  #'z            If found lowercase text, convert to upper
         bls   L03A8
L03B5    orcc  #$01           Non-alphabetic, set carry & return
L03B7    rts   
* Opcode & Pseudo Opcode Table
* Mnemonic words are high bit terminated
* First numeric byte is the base opcode (before addressing modes considered)
* 2nd is flags:
* Least significiant 4 bits = index into handler table
* 0= LBRA & LBSR (non comparitive long branches/no pre-byte)
* 1= Immediate (no register options) ex. ORCC
* 2= 16 bit register commands
* 3= 8 bit register commands
* 4= CLR, etc. Inherent (A,B,D,E,F,W all supported)
* 5= 'Fixed' (register not negotiable) inherent commands
* 6= LEAx - Indexed only
* 7= Register to register (TFR,EXG) (now patched for dual size 0 register)
* 8=
* 9= 16 bit Relative comparitive branches setup flag
* A= 8 bit Relative comparitive branches
* B=
* C= Pseudo op
* D= Pseudo op conditionals (IFxx)
* E= Pseudo op (ELSE & ENDC)
* F= UNUSED
* Most significiant 4 bits
* %00010000 : $10 prefix byte always needed
* %00100000 : $11 prefix byte always needed
* %01000000 : Immediate mode illegal
* %10000000 : Default to extended mode

L03B8    fcs   "ORG"
         fcb   $00,$0C
         fcs   "ENDC"
         fcb   $00,$0E
* Long branches without prebyte 
         fcs   "LBRA"
         fcb   $16,$00
         fcs   "LBSR"
         fcb   $17,$00
* Immediate with no options for register names 
         fcs   "ORCC"
         fcb   $1A,$01
         fcs   "ANDCC"
         fcb   $1C,$01
         fcs   "CWAI"
         fcb   $3C,$01
         fcs   "LDMD"
         fcb   $3d,$21
         fcs   "BITMD"
         fcb   $3c,$21
* Register to register commands (need to be here since ADD would match too
* early) 
         fcs   "ADDR"
         fcb   $30,$17
         fcs   "ADCR"
         fcb   $31,$17
         fcs   "SUBR"
         fcb   $32,$17
         fcs   "SBCR"
         fcb   $33,$17
         fcs   "ANDR"
         fcb   $34,$17
         fcs   "ORR"
         fcb   $35,$17
         fcs   "EORR"
         fcb   $36,$17
         fcs   "CMPR"
         fcb   $37,$17

* 16 bit register commands
         fcs   "ADDD"
         fcb   $C3,$02
         fcs   "SUBD"
         fcb   $83,$02
         fcs   "LDD"
         fcb   $CC,$02
         fcs   "LDX"
         fcb   $8E,$02
         fcs   "LDU"
         fcb   $CE,$02
         fcs   "CMPX"
         fcb   $8C,$02
         fcs   "JSR"
         fcb   $8D,$40+$02    Immediate mode not allowed
         fcs   "STD"
         fcb   $CD,$42
         fcs   "STX"
         fcb   $8F,$42
         fcs   "STU"
         fcb   $CF,$42
         fcs   "CMPU"
         fcb   $83,$22
         fcs   "CMPS"
         fcb   $8C,$22
         fcs   "CMPD"
         fcb   $83,$12
         fcs   "CMPY"
         fcb   $8C,$12
         fcs   "LDY"
         fcb   $8E,$12
         fcs   "LDS"
         fcb   $CE,$12
         fcs   "STY"
         fcb   $8F,$52
         fcs   "STS"
         fcb   $CF,$52
* 6309 additions here
         fcs   "SUBW"
         fcb   $80,$12
         fcs   "CMPW"
         fcb   $81,$12
         fcs   "SBCD"
         fcb   $82,$12
         fcs   "ANDD"
         fcb   $84,$12
         fcs   "BITD"
         fcb   $85,$12
         fcs   "LDW"
         fcb   $86,$12
         fcs   "STW"
         fcb   $87,$52        Immediate mode illegal
         fcs   "EORD"
         fcb   $88,$12
         fcs   "ADCD"
         fcb   $89,$12
         fcs   "ORD"
         fcb   $8A,$12
         fcs   "ADDW"
         fcb   $8B,$12
         fcs   "DIVQ"
         fcb   $8E,$22
         fcs   "MULD"
         fcb   $8F,$22
         fcs   "STQ"
         fcb   $CD,$52        Immediate mode illegal
         fcs   "LDQ"
         fcb   $CC,$12        Immediate needs new routine
* 8 bit register commands (handles A,B,E,F)
         fcs   "ADD"
         fcb   $8B,$03
         fcs   "CMP"
         fcb   $81,$03
         fcs   "SUB"
         fcb   $80,$03
         fcs   "SBC"
         fcb   $82,$03
         fcs   "AND"
         fcb   $84,$03
         fcs   "BIT"
         fcb   $85,$03
         fcs   "LD"
         fcb   $86,$03
         fcs   "ST"
         fcb   $87,$43        Immediate mode not allowed
         fcs   "EOR"
         fcb   $88,$03
         fcs   "ADC"
         fcb   $89,$03
         fcs   "OR"
         fcb   $8A,$03
         fcs   "DIVD"
         fcb   $8D,$23
* Inherent register commands (now handles A,B,E,F,D & W)
         fcs   "NEG"
         fcb   $00,$04
         fcs   "COM"
         fcb   $03,$04
         fcs   "LSR"
         fcb   $04,$04
         fcs   "ROR"
         fcb   $06,$04
         fcs   "ASR"
         fcb   $07,$04
         fcs   "LSL"
         fcb   $08,$04
         fcs   "ASL"
         fcb   $08,$04
         fcs   "ROL"
         fcb   $09,$04
         fcs   "DEC"
         fcb   $0A,$04
         fcs   "INC"
         fcb   $0C,$04
         fcs   "TST"
         fcb   $0D,$04
         fcs   "JMP"
         fcb   $0E,$40+$04
         fcs   "CLR"
         fcb   $0F,$04
* "Fixed" inherent commands (no options for register names) 
* Single, unique opcode
         fcs   "RTS"
         fcb   $39,$05
         fcs   "MUL"
         fcb   $3D,$05
         fcs   "NOP"
         fcb   $12,$05
         fcs   "SYNC"
         fcb   $13,$05
         fcs   "DAA"
         fcb   $19,$05
         fcs   "SEXW"
         fcb   $14,$05
         fcs   "SEX"
         fcb   $1D,$05
         fcs   "ABX"
         fcb   $3A,$05
         fcs   "RTI"
         fcb   $3B,$05
         fcs   "SWI2"
         fcb   $3F,$15
         fcs   "SWI3"
         fcb   $3F,$25
         fcs   "SWI"
         fcb   $3F,$05
         fcs   "PSHSW"
         fcb   $38,$15
         fcs   "PULSW"
         fcb   $39,$15
         fcs   "PSHUW"
         fcb   $3A,$15
         fcs   "PULUW"
         fcb   $3B,$15
* Load effective address: Indexing mode ONLY         
         fcs   "LEAX"
         fcb   $30,$06
         fcs   "LEAY"
         fcb   $31,$06
         fcs   "LEAS"
         fcb   $32,$06
         fcs   "LEAU"
         fcb   $33,$06
* Register to register 
         fcs   "TFR"
         fcb   $1F,$07
         fcs   "EXG"
         fcb   $1E,$07
         fcs   "TFM"
         fcb   $38,$27        Prebyte of $11
* Stack push/pull 
         fcs   "PSHS"
         fcb   $34,$08
         fcs   "PULS"
         fcb   $35,$08
         fcs   "PSHU"
         fcb   $36,$08
         fcs   "PULU"
         fcb   $37,$08
* Normal long branches (except LBRA & LBSR) - probably sets flag & then
* carries on through short branch table below
         fcs   "LB"            for long branches?
         fcb   $00,$19
 
* Short branches
L0530    fcs   "BSR"
         fcb   $8D,$0A
         fcs   "BRA"
         fcb   $20,$0A
         fcs   "BRN"
         fcb   $21,$0A
         fcs   "BHI"
         fcb   $22,$0A
         fcs   "BLS"
         fcb   $23,$0A
         fcs   "BHS"
         fcb   $24,$0A
         fcs   "BCC"
         fcb   $24,$0A
         fcs   "BLO"
         fcb   $25,$0A
         fcs   "BCS"
         fcb   $25,$0A
         fcs   "BNE"
         fcb   $26,$0A
         fcs   "BEQ"
         fcb   $27,$0A
         fcs   "BVC"
         fcb   $28,$0A
         fcs   "BVS"
         fcb   $29,$0A
         fcs   "BPL"
         fcb   $2A,$0A
         fcs   "BMI"
         fcb   $2B,$0A
         fcs   "BGE"
         fcb   $2C,$0A
         fcs   "BLT"
         fcb   $2D,$0A
         fcs   "BGT"
         fcb   $2E,$0A
         fcs   "BLE"
         fcb   $2F,$0A
 
* Pseudo ops
         fcs   "RMB"
         fcb   $00,$0B
         fcs   "FCC"
         fcb   $01,$0B
         fcs   "FDB"
         fcb   $02,$0B
         fcs   "FCS"
         fcb   $03,$0B
         fcs   "FCB"
         fcb   $04,$0B
         fcs   "EQU"
         fcb   $05,$0B
         fcs   "MOD"
         fcb   $06,$0B
         fcs   "EMOD"
         fcb   $07,$0B
         fcs   "SETDP"
         fcb   $07,$0C
         fcs   "SET"
         fcb   $08,$0B
         fcs   "OS9"
         fcb   $09,$0B
         fcs   "END"
         fcb   $01,$0C
         fcs   "NAM"
         fcb   $02,$0C
         fcs   "OPT"
         fcb   $03,$0C
         fcs   "TTL"
         fcb   $04,$0C
         fcs   "PAG"
         fcb   $05,$0C
         fcs   "SPC"
         fcb   $06,$0C
         fcs   "USE"
         fcb   $08,$0C
* Conditional assembly switches
         fcs   "IFEQ"
         fcb   $00,$0D
         fcs   "IFNE"
         fcb   $01,$0D
         fcs   "IFLT"
         fcb   $02,$0D
         fcs   "IFLE"
         fcb   $03,$0D
         fcs   "IFGE"
         fcb   $04,$0D
         fcs   "IFGT"
         fcb   $05,$0D
         fcs   "IFP1"
         fcb   $06,$0D
         fcs   "ELSE"
         fcb   $01,$0E

L061C    fcc   '***** Error: '
         fcb   $00

* Pointers to error messages table
L062A    fdb   L065F-L062A    Point to 'bad label'
         fdb   L0669-L062A    Point to 'bad instr'
         fdb   L0673-L062A    Point to 'in number'
         fdb   L067D-L062A    Point to 'div by 0'
         fdb   L0686-L062A    Point to ' '
         fdb   L0688-L062A    Point to 'expr syntax'
         fdb   L0694-L062A    Point to 'parens'
         fdb   L069B-L062A    Point to 'redefined name'
         fdb   L06AA-L062A    Point to 'undefined name'
         fdb   L06B9-L062A    Point to 'phasing'
         fdb   L06C1-L062A    Point to 'symbol table full'
         fdb   L06D3-L062A    Point to 'address mode'
         fdb   L06E0-L062A    Point to 'out of range'
         fdb   L06ED-L062A    Point to 'result>255'
         fdb   L06F8-L062A    Point to 'reg name'
         fdb   L0701-L062A    Point to 'reg sizes'
         fdb   L070B-L062A    Point to 'input path'
         fdb   L0716-L062A    Point to 'object path'
         fdb   L0722-L062A    Point to 'index reg'
         fdb   L072C-L062A    Point to '] missing'
         fdb   L0736-L062A    Point to 'needs label'
         fdb   L0742-L062A    Point to 'opt list'
         fdb   L074B-L062A    Point to 'const def'
         fdb   L0755-L062A    Point to 'can't open'
         fdb   L0761-L062A    Point to 'label not allowed'
         fdb   L0773-L062A    Point to 'cond nesting'
L065E    fcb   $00
L065F    fcc   'bad label'
L0668    fcb   $00
L0669    fcc   'bad instr'
L0672    fcb   $00
L0673    fcc   'in number'
L067C    fcb   $00
L067D    fcc   'div by 0'
L0685    fcb   $00
L0686    fcc   ' '
L0687    fcb   $00
L0688    fcc   'expr syntax'
L0693    fcb   $00
L0694    fcc   'parens'
L069A    fcb   $00
L069B    fcc   'redefined name'
L06A9    fcb   $00
L06AA    fcc   'undefined name'
L06B8    fcb   $00
L06B9    fcc   'phasing'
L06C0    fcb   $00
L06C1    fcc   'symbol table full'
L06D2    fcb   $00
L06D3    fcc   'address mode'
L06DF    fcb   $00
L06E0    fcc   'out of range'
L06EC    fcb   $00
L06ED    fcc   'result>255'
L06F7    fcb   $00
L06F8    fcc   'reg name'
L0700    fcb   $00
L0701    fcc   'reg sizes'
L070A    fcb   $00
L070B    fcc   'input path'
L0715    fcb   $00
L0716    fcc   'object path'
L0721    fcb   $00
L0722    fcc   'index reg'
L072B    fcb   $00
L072C    fcc   '] missing'
L0735    fcb   $00
L0736    fcc   'needs label'
L0741    fcb   $00
L0742    fcc   'opt list'
L074A    fcb   $00
L074B    fcc   'const def'
L0754    fcb   $00
L0755    fcc   /can't open /
L0760    fcb   $00
L0761    fcc   'label not allowed'
L0772    fcb   $00
L0773    fcc   'cond nesting'
L077F    fcb   $00

* Index by opcode-type jump table
L0780    fdb   L079E-L0780    $001E  (LBRA/LBSR) (type 0)
         fdb   L07A5-L0780    $0025  (orcc/andcc/cwai) (type 1)
         fdb   L07B9-L0780    $0039  type 2
         fdb   L07CE-L0780    $004E  type 3
         fdb   L07F3-L0780    $0073  (CLR,etc.) (type 4)
         fdb   L0826-L0780    $00A6  type 5
         fdb   L082F-L0780    $00AF  type 6
         fdb   L0846-L0780    $00C6  type 7
         fdb   L0884-L0780    $0104  type 8
         fdb   L089D-L0780    $011D
         fdb   L08BA-L0780    $013A
         fdb   L08DC-L0780    $015C
         fdb   L08E1-L0780    $0161
         fdb   L08F9-L0780    $0179
         fdb   L0F29-L0780    $07A9

* LBRA/LBSR (type 0)
L079E    lda   #$03           # bytes require for instruction
         sta   <u0046         Save it
         lbra  L0951          

* orcc/andcc/cwai 2 byte immediate mode only, forced register name (type 1)
L07A5    lbsr  L0932          Go find '# for immediate mode
         bcc   twobyte        Found it, skip ahead
         ldb   #$0C           Error code $C 'address mode'
         lbsr  L02FA
* Legal 8 bit immediate mode goes here
twobyte  lda   #$01           Force # bytes of instruction to 1
         sta   <u0046
         lda   <u0047         Get flag/index option byte
         bita  #$20           Pre-byte 11 bit flag on?
         beq   L07AF          No, 2 byte instruction
         inc   <u0046         Add 1 to # bytes to compensate for $11
L07AF    lbsr  L12F7          Immediate mode parser
         stb   <u0063         Store immediate value following opcode
         inc   <u0046         Add 1 to # of bytes for immediate value
         rts   

* ADDD, LDX, STU etc. (type 2) (16 bit register commands) (all modes)
L07B9    inc   <u0046         Add 1 to # bytes needed for instruction
         lbsr  L0932          Check if immediate mode requested
         lbcs  L09C6          No, go check memory-based modes
         ldd   <u0061         Get prebyte & opcode
         cmpd  #$10CC         LDQ?
         bne   norm16bt       No, normal immediate mode
         ldd   #$00CD         Get immediate mode opcode
         sta   <u0062         Save it over old opcode
         lda   #$5            # of bytes for LDQ immediate
         clr   <u0061         Clear out pre-byte
* This is here since 32 bit numeric routines aren't here yet
         ldb   #$c            Error code for 'addr mode'
         lbra  L02FA          Exit with it
         
norm16bt lbsr  L12F1          Calculate immediate mode #'s
         std   <u0063         Save 16 bit result after opcode
         inc   <u0046         Add 2 to # bytes needed for instruction
         inc   <u0046
         lbra  L0941          Make sure immediate mode is legal & exit

* 8 bit A & B based instructions (ADD, SUB, CMP, etc.) (type $03)
L07CE    inc   <u0046         Add 1 to # bytes needed for instruction
         ldd   <u0061         Get pre-byte & opcode
         cmpd  #$118d         DIVD instruction?
         beq   L07E7          Yes, skip register name parser
         lda   ,x+            Get next byte from source
         anda  #$5F           Force to uppercase
         cmpa  #'A            Is it an A?
         beq   L07E7          Yes, go process instruction
         cmpa  #'E            Is it an E?
         beq   newreg         Yes, process
         cmpa  #'F            Is it an F?
         bne   notnew         No, try B
* E or F register
newreg   pshs  a              Preserve register name a moment
         lda   <u0062         Get base opcode
         cmpa  #$82
         blo   legalcmd       SUB or CMP are ok
         cmpa  #$86
         blo   illegal3       SBC,AND & BIT are not ok
         cmpa  #$88
         blo   legalcmd       Load & store are ok
         cmpa  #$8b
         blo   illegal3       EOR, ADC & OR are not ok (ADD falls through ok)
* Legal E/F command, setup
legalcmd lda   #$11           Pre-byte for E/F based commands
         sta   <u0061         Place before opcode
         inc   <u0046         Add 1 to # bytes needed for instruction
         puls  a              Get back register name
         cmpa  #'F            Is it F?
         beq   L07E1          Yes, add mask for F
         bra   L07E7          Go process various modes
notnew   cmpa  #'B            Is it a B?
         beq   L07E1          Yes, add B mask & process instruction
         bra   illegal2       Illegal register name

* Illegal register (or illegal command for E or F)
illegal3 leas  1,s            Eat E/F identifier byte
illegal2 leas  2,s            Eat JSR return address
         lbra  L015F          Exit with 'bad instr' error

* Mask for B or F commands
L07E1    ldb   #$40           Add offset for B register to base opcode
         orb   <u0062
         stb   <u0062
* Process various modes (Extended, DP, Indexed, Immediate)         
L07E7    lbsr  L0932          Check for immediate mode
         lbcs  L09C6          Not immediate, try memory modes
         lbsr  L0941          Is this command allowed immediate mode?
         lbra  L07AF          Go do immediate mode (8 bit)

* CLR/LSL,etc.
L07F3    inc   <u0046         Inc # bytes in current instruction
         lda   <u0062         Get base opcode
         cmpa  #$0E           Is it JMP?
         beq   L080B          Yes, special case (no inherent)
* Inherent register name commands
         lda   ,x             Get next char from source line
         anda  #$5F           Uppercase only
* $xx40 commands here
         ldb   #$40           Mask to opcode base for 'xxxA'
         cmpa  #'A            Is char an A?
         beq   L0819          Yes, adjust opcode accordingly
         cmpa  #'D            Is char a D?
         bne   notD           No, check next
Legal10  lda   #$10           Pre-byte for 'D' commands
Legal11  sta   <u0061         Put it before the opcode
         inc   <u0046         Add 1 to # bytes for this instruction
         bra   L0819          Go append the main opcode
notD     cmpa  #'E            Is char an E?
         bne   notE           No, check next
ChkEF    lda   <u0062         Get base opcode
         beq   illegal        NEGE/NEGF not allowed
         cmpa  #$03           COMx?           
         beq   goodE          Yes, legal
         cmpa  #$0A           LSR/ROR/ASR/LSL/ASL/ROL?
         blo   illegal        Not allowed
goodE    lda   #$11           Rest are allowed, set pre-byte to $11
         bra   Legal11

* $xx50 commands here
notE     ldb   #$50           Mask to opcode base for 'xxxB'
         cmpa  #'B            Is char a B?
         beq   L0819          Yes, adjust opcode accordingly
         cmpa  #'W            Is char a W?
         bne   notW           No, check next
         lda   <u0062         Get base opcode
         beq   illegal        There is no NEGW?
         cmpa  #$7            ASRW?
         beq   illegal        Yes, there isn't one
         cmpa  #$8            LSL/ASLW?
         bne   Legal10        Rest are legal, prefix a $10 & append opcode
        
* Illegal instructions go here
illegal  leas  $02,s          Eat JSR return address
         lbra  L015F          Exit with illegal opcode error
notW     cmpa  #'F            is it an F?
         bne   L080B          Definately not a register, try memory modes
         bra   ChkEF          Go to generic E/F handler
         
L080B    lbsr  L09C6          Generic indexed/extended/direct handler???
         ldb   <u0062         Get base opcode
         bitb  #%11110000     Any of the 4 bits of high nibble set?
         beq   L0825          No, return
         orb   #%01000000     Yes, force bit on & return
         stb   <u0062
         rts   
* Mask in adjustment for register inherent
L0819    orb   <u0062         Merge Mask for new inherent mode into opcode
         stb   <u0062         Save new opcode
         leax  1,x            Bump source code ptr up to next char
         ldb   #%11011111     Shut off 'operand field in src line' flag
         andb  <u002B         And save new flag byte
         stb   <u002B
L0825    rts   

* type 5 - 'fixed' inherent commands (no options for registers, etc.)
L0826    inc   <u0046         Add 1 to # bytes this instruction
         ldb   <u002B
         andb  #%11011111     Shut off 'operand present' flag
         stb   <u002B
         rts   

* type 6 - LEA* (indexed mode ONLY)
L082F    inc   <u0046         Add 1 to # bytes this instruction
         lbsr  L09C6          Go set up indexed mode
         lda   <u004E         Get indexed mode flag
         bne   L0825          Is indexed mode, everything went fine, exit
         ldd   #$1212         Otherwise, 2 NOP codes
         std   <u0062         Save as opcodes
         ldb   #$02           Force # bytes this instruction to 2
         stb   <u0046
         ldb   #$0C           'address mode' error
         lbra  L02FA
* type 7 - TFR/EXG & Register to register
L0846    inc   <u0046         at least 2 bytes in this instruction
         inc   <u0046
         lbsr  L1164          Find next text field
         lbsr  L096B          Get 1st register name
         bcc   L0857          If we found them, skip ahead
L0852    ldb   #$0F           If didn't, exit with 'reg name' error
         lbra  L02FA

L0857    lda   ,x+            Get next char
         cmpa  #',            comma?
         bne   L0852          No, exit with 'reg name' error
         pshs  b              Preserve first register mask
         lbsr  L096B          Get 2nd register name
         puls  a              Get back 1st register name
         bcs   L0852          If can't find 2nd, exit with error
         pshs  d              Preserve both
         anda  #%00001000     Keep 8/16 bit size flag on first
         andb  #%00001000     Keep 8/16 bit size flag on 2nd
         pshs  b              Preserve 2nd reg size flag
         eora  ,s+            Check if they are same size
         beq   L0879          Yes, continue
         lda   #%00001100     '0' register mask
         cmpa  ,s             Is source register the 0 register?
         beq   L0879          Yes, destination size doesn't matter
         ldb   #$10           Otherwise, 'reg sizes' error
         leas  $02,s
         lbra  L02FA

L0879    puls  a              Get back source register
         lsla                 Move into most significiant nibble
         lsla  
         lsla  
         lsla  
         ora   ,s+            Merge with destination register
         sta   <u0063         Save after opcode & return
         rts   
* type 8 (Stack push/pull)
L0884    ldb   #$02           Force # bytes for instruction to 2
         stb   <u0046
         lbsr  L1164          Parse to next field
L088B    lbsr  L096B          Get register mask
         bcs   L0852          Illegal one, exit with 'register name' error
         ora   <u0063         Mask in bit for new reg into byte after opcode
         sta   <u0063
         lda   ,x+            Get next char from source
         cmpa  #',            Comma?
         beq   L088B          Yes, more register masks to get
         leax  -1,x           Bump src code ptr back 1 & return
         rts   
* type 9 (long branches except LBRA/LBSR)
L089D    lda   #$04           Force # of bytes of instruction to 4
         sta   <u0046
         leax  -$01,x         Bump ptr back to start of mnemonic
         ldb   #19            # opcodes to check in table
         leay  >L0530,pc      Point to branch opcode tables
         lbsr  L0344          Go find & verify it
         bcc   L08B3          Found it, continue
         leas  $02,s          Eat stack
         lbra  L015F          Exit with error

L08B3    lda   ,y
         sta   <u0062
         lbra  L0951
         
* type 10 (short branches)
L08BA    lda   #$02           Force # of bytes of instruction to 2
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

* type $B (Pseudo ops)
L08DC    leau  <L08FE,pc      Point to table
         bra   L08EF

L08E1    ldb   <u002B
         bitb  #$08
         beq   L08EC
         ldb   #$19
         lbsr  L02FA
L08EC    leau  <L0912,pc      Point to table
L08EF    lbsr  L1164          Hunt down next field in source string
         ldb   <u0062
         lslb                 2 byte entries
         ldd   b,u
         jmp   d,u

L08F9    leau  <L0924,pc      Point to table
         bra   L08EF

* 2 byte jump table

L08FE    fdb   L0BA6-L08FE
         fdb   L0C47-L08FE
         fdb   L0CBF-L08FE
         fdb   L0C6B-L08FE
         fdb   L0CAD-L08FE
         fdb   L0C27-L08FE
         fdb   L0D60-L08FE
         fdb   L0D40-L08FE
         fdb   L0C2B-L08FE
         fdb   L0D51-L08FE
* Another 2 byte jump table
L0912    fdb   L0DB9-L0912
         fdb   L0DC1-L0912
         fdb   L0DD4-L0912
         fdb   L0E2C-L0912
         fdb   L0DFD-L0912
         fdb   L0E03-L0912
         fdb   L0E09-L0912
         fdb   L0EB3-L0912
         fdb   L0EC4-L0912

* Another 2 byte jump table
L0924    fdb   L0EE3-L0924
         fdb   L0EE8-L0924
         fdb   L0EED-L0924
         fdb   L0EF2-L0924
         fdb   L0EF7-L0924
         fdb   L0EFC-L0924
         fdb   L0F01-L0924

L0932    lbsr  L1164          Parse for start of next field
         cmpa  #'#            Immediate mode specifier?
         bne   L093E          No, exit with carry set
         leax  1,x            Bump source ptr up by 1, clear carry & return
         andcc #$FE
         rts   

L093E    orcc  #$01
         rts   

* Immediate mode check
L0941    ldb   <u0047         Get current opcode's flag byte
         bitb  #%01000000     Immediate mode legal?
         bne   L0948          No, do something
         rts                  Yes, return

L0948    ldb   #$03           Set size of illegal instruction to 3 bytes
         stb   <u0046
         ldb   #$0C           Error code $C 'address mode'
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

* Entry: X=ptr to start of reg name from source
* Exit:  A=Bit mask for PSH/PUL
*        B=Bit mask for EXG/TFR
L096B    leay  >L09A2,pc      Point to register names
         pshs  x              Save start of current register we are checking
         ldb   #16            # of register names to check
L0973    lda   ,y             Get byte from reg. name
         beq   L098F          If NUL (empty entry), skip this entry
         cmpa  ,x+            Compare with source
         beq   L0981          Equal, skip ahead
         adda  #$20           Make lowercase
         cmpa  -$01,x         Compare with source
         bne   L098F          Not equal, skip ahead
* Found reg name we want
L0981    lda   $01,y          Get 2nd char of reg name
         beq   L099A          NUL, only 1 char, so we match
         cmpa  ,x+            2nd char match too?
         beq   L099A          Yes, found reg
         adda  #$20           Convert to lowercase
         cmpa  -$01,x         Does that match?
         beq   L099A          Yes, found it
* Not the register name we want, try next one
L098F    ldx   ,s             Get ptr to start of current register
         leay  $03,y          Bump to next one
         decb                 Dec # registers left to check counter
         bne   L0973          Keep doing till done
         orcc  #$01           Set carry flag (illegal register name)
         puls  pc,x           Restore X & return
* Found register name we wanted
L099A    decb                 Adjust B (EXG/TFR mask)
         leas  $02,s          Eat X off the stack
         lda   $02,y          Get PSH/PUL bit mask
         andcc #$FE           No error & return
         rts   
* Stack table: 2 bytes for reg. name, 1 byte for bit mask for PSH/PUL
* Positions (done in reverse from highest to lowest) indicates the bit
* mask for register to register operations (ex. TFR)
L09A2    fcc   'F'            %1111
         fcb   $00,$00
         
         fcc   'E'            %1110
         fcb   $00,$00
         
         fcb   $00,$00,$00    %1101  (2nd zero register won't be used)

         fcc   '0'            %1100  Zero register
         fcb   $00,$00
         
         fcc   'DP'           %1011
         fcb   $08

         fcc   'CC'           %1010
         fcb   $01

         fcc   'B'            %1001
         fcb   $00,$04

         fcc   'A'            %1000
         fcb   $00,$02

         fcc   'V'            %0111
         fcb   $00,00

         fcc   'W'            %0110
         fcb   $00,$00

         fcc   'PC'           %0101
         fcb   $80

         fcc   'S'            %0100
         fcb   $00,$40

         fcc   'U'            %0011
         fcb   $00,$40

         fcc   'Y'            %0010
         fcb   $00,$20

         fcc   'X'            %0001
         fcb   $00,$10

         fcc   'D'            %0000
         fcb   $00,$06        (A & B combined)

* Generic memory mode addressing handler: Indexed, Extended, Direct Page
L09C6    lbsr  L1164          Parse for next field in source
         bsr   L0A14          Check for '<' (DP) & '>' (Extended) modes
         cmpa  #'[            Next char indicate indirect mode?
         bne   L09D7          No, try next
         inc   <u004D         Set flag for indirect mode
         leax  1,x            Bump src code ptr up by 1
         lda   ,x             Get next byte
         bsr   L0A14          Check for '<' or '>' & set flag
L09D7    cmpa  #',            Comma?
         lbeq  L0A64          Yes, skip ahead for ,R/,R auto inc/dec
* comma is not first char
         ldb   1,x            No, get next char into B
         cmpb  #',            Is it a comma? (ie 1st was register name?)
         bne   L09F1          No, try label/number routine ???
         anda  #$DF           Force to uppercase
         cmpa  #'A            Is it an A?
         beq   L0A27          Yes, go process
         cmpa  #'B            Is it a B?
         beq   L0A2B          Yes, go process
         cmpa  #'D            Is it a D?
         beq   L0A2F          Yes, go process
         cmpa  #'E            Is it an E?
         beq   MaskE
         cmpa  #'F            Is it an F?
         beq   MaskF
         cmpa  #'W            Is it a W?
         beq   MaskW
* Not a R0,xx... try for numeric or label
L09F1    lbsr  L12F1          Parse for numeric (returns 16 bit # in D)
         bcc   L09F8          Found one, preserve it
         clra                 Otherwise, default to 0
         clrb
L09F8    std   <u004A         Save 16 bit address
         lda   ,x             Get char from src code
         cmpa  #',            Comma?
         lbeq  L0B18          Yes, skip way ahead
         ldb   <u004D         Get indirect mode flag
         bne   L0A35          If on, skip ahead
         ldb   <u004C         Get Extended/DP/Indexed mode flag
         bmi   L0A35          If Extended, go do it
         bne   L0A53          If Direct Page, go somewhere else
         lda   <u004A
         cmpa  <u003F
         beq   L0A53
         bra   L0A35

* Check for '>' or '<' (Extended or Direct Page addressing)
* Set flag @ <u004C to $FF for >, $01 for <
L0A14    ldb   #$FF           16 bit addressing flag
         cmpa  #'>            16 bit addressing?
         beq   L0A20          Yes, set flag
         cmpa  #'<            8 bit addressing?
         bne   L0A26          No, return
         ldb   #$01           8 bit addressing flag
L0A20    stb   <u004C         Save bit size addressing flag
         leax  1,x            Bump source ptr
         lda   ,x             Get next char & return
L0A26    rts   

* A,R comes here
L0A27    ldb   #%10000110
         bra   L0A31

* B,R comes here
L0A2B    ldb   #%10000101
         bra   L0A31

* D,R comes here
L0A2F    ldb   #%10001011
         bra   L0A31
* E,R comes here
MaskE    ldb   #%10000111
         bra   L0A31
* F,R comes here
MaskF    ldb   #%10001010
         bra   L0A31
* W,R comes here
MaskW    ldb   #%10001110
L0A31    leax  1,x            Bump src ptr up by 1
         bra   L0A97          Skip ahead

* Extended Indirect indexed or Extended modes go here
L0A35    ldd   <u004A         Get 16 bit address
         inc   <u0046         Add 2 to # bytes for instruction
         inc   <u0046
         inc   <u004F         ???
         tst   <u004D         Indirect mode on?
         bne   L0A4A          Yes, Need to add $9F postbyte first
         std   <u0063         Save extended address
         ldb   #%00110000     Mask in bit flags for extended mode & return
         orb   <u0062
         stb   <u0062
         rts   

* Extended indirect (ex. JMP [<$2000])
L0A4A    std   <u0064         Store 16 bit address after post-byte
         ldb   #%10011111     Append $9f post-byte for Extended Indirect
         stb   <u0063
         lbra  L0AEA

* Direct page mode
L0A53    inc   <u0046         Add 1 to # bytes this instruction
         ldb   <u004B         Get 8 bit # (LSB of D from L12F1)
         stb   <u0063         Save it as DP address
         ldb   <u0062         get opcode
         bitb  #%11110000     Is it a $0-$F Direct page command?
         beq   L0A63          Yes, opcode is fine
         orb   #%00010000     No, force DP mode bit on in opcode
         stb   <u0062
L0A63    rts   

* Comes here if first char is ',' (after parsing '[' if needed)
L0A64    leax  1,x            Bump source ptr up by 1
         clr   <u004A         Clear 16 bit offset address
         clr   <u004B
         ldd   ,x             Get 2 chars from source
         cmpd  #$2D2D         '--' ?
         beq   L0A8D          Yes, go merge mask for --
         cmpa  #'-            '-' ?
         beq   L0A93          Yes, go merge mask for -
         bsr   L0AC7          Otherwise, Go find base index register (X,Y,U,S)
         lbcs  L0B68          Couldn't find one, check for 'PC' offset
* Found base register
         stb   <u0063         Save base register bit mask in postbyte
         ldd   ,x             Get next 2 chars from src (after base reg. name)
         cmpd  #$2B2B         '++' ?
         beq   L0AAB          Yes, go process
         cmpa  #'+            '+' ?
         beq   L0AB1          Yes, go process
         lbra  L0B22          

* Mask for double dec. mode
L0A8D    leax  1,x            Bump src ptr up by 1
         ldb   #%10000011     Mask for -- mode
         bra   L0A97          Merge into post byte
* Mask for single dec. mode
L0A93    bsr   L0ABD          Make sure we aren't indirect-it's illegal
         ldb   #%10000010     Mask for - mode
L0A97    stb   <u0063         Save mask in postbyte
         leax  1,x            Bump src ptr up 1 byte
         bsr   L0AC7          Go get base register (X,Y,U,S)
         bcc   L0AA5          Found it, merge in base register mask
L0A9F    ldb   #$13           illegal 'index reg' error
         lbsr  L02FA
         clrb                 So clear postbyte to 0
L0AA5    orb   <u0063         Merge in mask into postbyte
         stb   <u0063
         bra   L0AEA
* Mask for double inc. mode
L0AAB    ldb   #%10000001     Mask for ++ mode
         leax  1,x            Bump up src ptr by 1
         bra   L0AB5          Merge into postbyte
* Mask for single inc. mode
L0AB1    bsr   L0ABD          Make sure we aren't indirect-it's illegal
         ldb   #%10000000     Mask for + mode

L0AB5    leax  1,x            Bump up src ptr by 1
         orb   <u0063         Merge in auto inc. modes
         stb   <u0063
         bra   L0AEA

* Check ,-R or ,R+: only legal in NON-INDIRECT mode
L0ABD    tst   <u004D         Check indirect mode flag
         beq   L0AC6          Normal, exit
         ldb   #$0C           Indirect ,-R is illegal, exit with error
         lbsr  L02FA
L0AC6    rts   

* Exit: B=bit mask for proper index register (X,Y,U,S)
*       carry set=not legal register
L0AC7    lda   ,x+            Get next char from source
         anda  #$5F           Force to uppercase
         clrb                 X register mask
         cmpa  #'X            X register?
         beq   L0AE2          Yes, acceptable
         ldb   #%00100000     Y register mask
         cmpa  #'Y            Y register
         beq   L0AE2
         ldb   #%01000000     U register mask
         cmpa  #'U            U register?
         beq   L0AE2
         ldb   #%01100000     S register mask
         cmpa  #'S            S register?
         bne   L0AE5          No, not a 'x,R' or 'R+/++' situation
L0AE2    andcc #$FE           No error & return
         rts   

L0AE5    leax  -1,x           Bump source ptr back
         orcc  #$01           Set carry (couldn't find index register) & return
         rts   
* Part of indexed mode handler
* This part sets the INDEXED mode bit in the opcode itself, and also sets
* the INDIRECT bit in the postbyte. Both of these are compatible with the new
* W modes (with W being the base register), so this routine does not have to
* be changed.
L0AEA    ldb   #%00100000     Mask bit for indexed instruction opcodes
         orb   <u0062         Force instruction to indexed mode
         stb   <u0062
         inc   <u0046         Add 1 to size of instruction
         inc   <u004E         ???
         tst   <u004D         Indirect mode active?
         beq   L0B08          No, skip ahead
         ldb   #%00010000     Indirect mode bit mask
         orb   <u0063         Mask into Postbyte
         stb   <u0063
         lda   ,x+            Get next char from source
         cmpa  #']            End of indirect mode?
         beq   L0B08          Yes, go check for end of line
         ldb   #$14           '] missing' error
         bra   L0B14

L0B08    lda   ,x             Get char from source
         cmpa  #$20           Space?
         beq   L0B17          Yes, exit
         cmpa  #$0D           CR?
         beq   L0B17          Yes, exit
         ldb   #$0C           'Address mode' error
L0B14    lbsr  L02FA
L0B17    rts                  No error & return

L0B18    leax  1,x            Bump src ptr up by 1
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

L0BA6    bsr   L0BE4
         pshs  d
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
L0C27    lda   #$03
         bra   L0C2D
L0C2B    lda   #$02
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
L0C47    lda   ,x+
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
L0C6B    lda   ,x+
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
L0CAD    bsr   L0CD5
L0CAF    lbsr  L12F7
         tfr   b,a
         bsr   L0CEC
         lda   ,x+
         cmpa  #$2C
         beq   L0CAF
         leax  -$01,x
         rts   
L0CBF    bsr   L0CD5
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
L0D40    ldd   <u0051
         coma  
         comb  
         std   <u0062
         ldb   <u0053
         comb  
         lda   <u002B
         anda  #$DF
         sta   <u002B
         bra   L0D59
L0D51    ldd   #$103F
         std   <u0062
         lbsr  L12F7
L0D59    stb   <u0064
         ldb   #$03
         stb   <u0046
         rts   
L0D60    clra  
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
L0DB9    lbsr  L0BE4
         std   <u0044
         lbra  L0BC0
L0DC1    ldb   <u002B
         andb  #$08
         orb   #$10
         stb   <u002B
         lbsr  L01F2
         lbsr  L156C
         bcc   L0DD3
         leas  $04,s
L0DD3    rts   
L0DD4    ldb   #$27
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
L0DFD    ldb   #$4F
         ldu   <u0008
         bra   L0DD8
L0E03    lbsr  L1408
L0E06    leas  $02,s
         rts   
L0E09    bsr   L0E21
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
L0E33    clr   ,-s            Clear flag?
         lda   ,x+            Get char
         cmpa  #'-            Dash?
         bne   L0E3F          No, leave flag clear
         com   ,s             Set flag
         lda   ,x+            Get next char
L0E3F    leau  <L0EA3,pc      Point to table
         ldb   #08            # of entries
         cmpa  #'a            Is char lowercase?
         blo   L0E4A          No, no conversion needed
         suba  #$20           Bump down to uppercase
L0E4A    cmpa  ,u++           Same as first 1/2 of table entry?
         beq   L0E68          Yes, skip ahead
         decb                 No, decrement # entries left
         bne   L0E4A          Keep checking all 8
         puls  b
         cmpa  #'D
         beq   L0E88
         cmpa  #'W
         beq   L0E80
         cmpa  #'L
         beq   L0E90
         cmpa  #'N
         beq   L0E9B
L0E63    ldb   #$16
         lbra  L02FA
L0E68    ldb   -1,u
         tfr   dp,a
         tfr   d,u
         puls  a
         coma  
         sta   ,u
L0E73    lda   ,x+
         cmpa  #',
         beq   L0E33
         cmpa  #$20           Space?
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

* Table: 2 byte entries
L0EA3    fcb   $43,$5f
         fcb   $46,$59
         fcb   $4d,$5a
         fcb   $47,$5b
         fcb   $45,$5c
         fcb   $53,$5e
         fcb   $49,$5d
         fcb   $4f,$58

L0EB3    lbsr  L12F7
         bcs   L0EBA
         stb   <u003F
L0EBA    clra  
         std   <u0044
         ldb   #$31
         stb   <u002B
         inc   <u002C
         rts   
L0EC4    lbsr  L1164
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
L0EE3    bsr   L0F0F
         bne   L0F0C
         rts   
L0EE8    bsr   L0F0F
         beq   L0F0C
         rts   
L0EED    bsr   L0F0F
         bge   L0F0C
         rts   
L0EF2    bsr   L0F0F
         bgt   L0F0C
         rts   
L0EF7    bsr   L0F0F
         blt   L0F0C
         rts   
L0EFC    bsr   L0F0F
         ble   L0F0C
         rts   
L0F01    inc   <u0055
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
         puls  pc,d
L0F1C    cmpd  #$0000
         rts   

L0F21    tst   <u005F
         bne   L0F26
         clrb  
L0F26    stb   <u002B
         rts   

L0F29    ldb   #$10
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
* Take number in D and convert to 5 digit ASCII string (stored at X)
L1084    pshs  u,y,b
         leau  >L10AA,pc      Point to powers of 10 table
         ldy   #$0005         5 entries (1-10000)
L108E    clr   ,s             Clear flag
L1090    subd  ,u             Repeated subtract
         blo   L1098
         inc   ,s             Set flag to 1
         bra   L1090
L1098    addd  ,u++
         pshs  b
         ldb   $01,s
         addb  #$30           Make into ASCII #
         stb   ,x+
         puls  b
         leay  -$01,y
         bne   L108E
         puls  pc,u,y,b
* Subtraction table for ASCII conversion
L10AA    fdb   10000
         fdb   1000
         fdb   100
         fdb   10
         fdb   1
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

* Find next text field
* Entry: X=Ptr to current location in source line
* Exit:  X=Ptr to start of next field in source line
*        A=First char in new field
L1164    lda   ,x+            Get char.
         cmpa  #$20           Space?
         beq   L1164          Yes, eat it
         leax  -$01,x         Found next field; point to it & return
         rts   

L116D    pshs  x,d
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

L11C2    pshs  u,y            Preserve regs
         leau  ,s             Point U to copy of Y on stack
         bsr   L1164          Parse for next field
         bsr   L11D0          Check for special chars
         andcc #$FE           Error flag off
         puls  pc,u,y         Restore regs & return

L11CE    leax  1,x
L11D0    bsr   L1211
         pshs  d
L11D4    lda   ,x
         cmpa  #'-
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
L120D    puls  pc,d
L120F    leax  1,x

L1211    bsr   L123F
         pshs  d

L1215    lda   ,x
         cmpa  #'/
         bne   L122A
         bsr   L123D
         pshs  x
         ldx   $02,s
         lbsr  L118E
         bcc   L1237
         ldb   #$04
         bra   L1207
L122A    cmpa  #'*
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
         pshs  d
L1243    lda   ,x
         cmpa  #'&            Logical AND?
         bne   L1251          No, check next
         bsr   L126B
         andb  $01,s
         anda  ,s
         bra   L1267
L1251    cmpa  #'!            Logical OR?
         bne   L125D          No, check next
         bsr   L126B
         orb   $01,s
         ora   ,s
         bra   L1267
L125D    cmpa  #'?            ???
         bne   L120D
         bsr   L126B
         eorb  $01,s
         eora  ,s
L1267    std   ,s
         bra   L1243
L126B    leax  1,x            Bump src code ptr up by 1
L126D    lda   ,x             Get char from source code
         cmpa  #'^            Is it a NOT?
         bne   L1279          No, check next
         bsr   L1284
         comb  
         coma  
         bra   L1283
L1279    cmpa  #'-            Is it negative?
         bne   L1288          No, check next
         bsr   L1284
         nega  
         negb  
         sbca  #$00
L1283    rts   
L1284    leax  1,x
L1286    lda   ,x             Get character from source code
L1288    cmpa  #'(            Math grouping start symbol?
         bne   L12A2          No, check next
         lbsr  L11CE
         pshs  d
         lda   ,x
         cmpa  #')            Math grouping end symbol?
         puls  d
         beq   L12B6
         ldb   <u0007
         bra   L129D
L129D    leas  $02,s
L129F    lbra  L1207
L12A2    cmpa  #'*            Multiply?
         bne   L12AA          No, check next
         ldd   <u0040
         bra   L12B6
L12AA    tst   <u005A         If some flag is set, check next
         bne   L12B9
         cmpa  #'.            Period?
         bne   L12B9          No, check next
         ldd   <u0042
         inc   <u002C
L12B6    leax  1,x            Bump src code ptr up & return
         rts   
L12B9    cmpa  #$27           Tilde (') (eorr)?
         bne   L12C5          No, check next
         ldd   ,x++
         cmpb  #$0D
         beq   L12D6
         clra  
         rts   
L12C5    cmpa  #'"            Quotes?
         bne   L12D9          No, check next
         leax  1,x
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
* Called by index mode handler
L12F1    lbsr  L11C2
         bcs   L1304
L12F6    rts   
L12F7    lbsr  L11C2
         bcs   L1304
         tsta  
         beq   L12F6
         inca  
         beq   L12F6
         ldb   #$0E           Result >255 error
L1304    lbsr  L02FA
         ldd   #$FFFF
         orcc  #$01
         rts   
L130D    bsr   L134D
         pshs  x,d
         ldx   <u001B
         sta   ,x+
         stx   <u001B
         cmpx  <u0010
         bcs   L1321
         bsr   L1323
         ldx   <u000E
         stx   <u001B
L1321    puls  pc,x,d
L1323    pshs  y,x,d
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
L1340    puls  pc,y,x,d
L1342    os9   F$PErr   
         ldb   #$12
         lbsr  L02FA
         lbra  L15A2
L134D    pshs  u,y,x,d
         leax  ,s
         ldy   #$0001
         tfr   dp,a
         ldb   #$51
         tfr   d,u
         os9   F$CRC    
         puls  pc,u,y,x,d
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
* ++START++
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
* ++END++
         bsr   L13F7
         bsr   L13F2
         lda   $03,s
         bsr   L13F7
         ldb   #$3A
         stb   ,x+
         lda   $04,s
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
         leay  <L14A5,pc      Point to 'Microware OS-9 Assembler' etc.
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
         leay  <L149F,pc      Point to 'Page'
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
L147F    pshs  y,x,d
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
L1498    puls  pc,y,x,d
L149A    ldx   <u0004
         lbra  L1370

L149F    fcc   'Page '  
         fcb   $00

L14A5    fcc   'Microware OS-9 Assembler RS Version 01.00.00    '
         fcb   $00
L14D6    fcc   ' error(s)'
         fcb   $00
L14E0    fcc   ' warning(s)'
         fcb   $00
L14EC    fcc   ' program bytes generated'
         fcb   $00
L1505    fcc   ' data bytes allocated'
         fcb   $00
L151B    fcc   ' bytes used for symbols'
         fcb   $00
L1533    fcc   'ASM:'

L1537    pshs  u,y,x,d
         lda   <u005D
         beq   L1549
         leax  <L1533,pc      Point to 'ASM:'
         ldy   #$0004         Size of text
         lda   <u001A         Get output path #
         os9   I$Write        Write it out
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
L156A    puls  pc,u,y,x,d
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
         leau  >L14D6,pc
         bsr   L1594
         ldd   <u0022
         leau  >L14E0,pc
         bsr   L1594
         ldd   <u0024
         leau  >L14EC,pc
         bsr   L1587
         ldd   <u0026
         leau  >L1505,pc
         bsr   L1587
         ldd   <u001D
         subd  <u0010
         leau  >L151B,pc
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
         lda   $08,y          Get offset into table
         leau  <L1691,pc      Point to table
         lda   a,u            Get table entry
         ldb   #$20           2nd char is a space
         std   ,x++           Store both of them
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

* Single byte entry table
L1691    fcc   'ULSED'
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
