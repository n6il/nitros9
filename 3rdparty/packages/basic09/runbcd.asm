           NAM   Basic09Runtime

           IFP1
           USE   defsfile
           ENDC

* RunB from BASICBOOST from Chris Dekker - 6309'ized version of RunB
* Created a proper jump table at L204 R.G. 03/05/13

edition    equ   1
membase    equ   $00
memsize    equ   $02
moddir     equ   $04
ResTop     equ   $08            top of reserved space
freemem    equ   $0C
table1     equ   $0E
table2     equ   $10
table3     equ   $12
table4     equ   $14
extnum     equ   $18
Vsys       equ   $20
Vinkey     equ   $22
holdnum    equ   $25
errpath    equ   $2E
PGMaddre   equ   $2F            starting address program
WSbase     equ   $31            base address workspace
errcode    equ   $36
DATApoin   equ   $39            address DATA item
VarAddr    equ   $3C            address of variable
fieldsiz   equ   $3E            it's max. size
ArrBase    equ   $42
SStop      equ   $44            top of string space area
userSP     equ   $46            subroutine stackpointer
exprSP     equ   $48            current expression
exprBase   equ   $4A            expr.stack's base
callex     equ   $5D
callcode   equ   $5F
VarPtrba   equ   $62
vectorba   equ   $66
excoffse   equ   $6A            module exec.offset
excEnd     equ   $6C
expneg     equ   $75
digits     equ   $76
decpoint   equ   $77
negativ    equ   $78
decimals   equ   $79
charcoun   equ   $7D            length output string
IOpath     equ   $7F
Sstack     equ   $80            start of current string
Spointer   equ   $82            end of current string
subrcode   equ   $85
fieldwid   equ   $86
justify    equ   $87
BUPaddr    equ   $FB
BUPsize    equ   $FD

MODMEM     equ   $2000

           mod   MODEND,MODNAM,Prgrm+Objct,$82,ENTRY,MODMEM

MODNAM     fcs   /RunB/
           fcb   edition

* interrupt processing *
L93        lda   5,s            native mode
           bra   L95

L94        LDA   3,S            emulation mode
L95        TFR   A,DP
           STB   <$35
*          oim   #$80,<$34
           fcb   1,$80,$34
           RTI

*  Check for processor type?
procID     pshs  d
           comd             Will only do COMA on 6809
           cmpb  1,s
           beq   L6809
           puls  pc,d

L6809      leax  <L6810,pc
           lbsr  prnterr
           clrb
           os9   F$Exit

L6810      fcc   /  6809 detected: can not proceed/
           fcb   10,10,13

*  adjust parameter format *
chprm      tfr   x,y
           lbsr  skpblank
           leax  -256,x
           ldb   #2
L133       lda   ,y+
           sta   ,x+            copy mod.name
           incb
           cmpa  #32            Space?
           bne   L133
           ldf   #$28           '('
           stf   ,x+
           ldf   #$2C           ,
L136       clre
           lbsr  skpblank
           lbsr  ISnum
           bcc   L135           number
           lde   #$22           "
           ste   ,x+            string
           incb
L135       lda   ,y+
           cmpa  #34            " ??
           beq   L135           skip it
           incb
           cmpa  #13
           beq   L139           end of list
           cmpa  #32            space ??
           bne   L138
           bsr   quote          yes!!
           stf   ,x+
           bra   L136           check if string

L138       sta   ,x+
           bra   L135

L139       bsr   quote
           ldf   #$29           )
           stf   ,x+
           sta   ,x             new string complete
           ldw   -2,x           Get last 2 chars
* NOTE: Was originally CMPW >$2829, changed since seemed wrong
*           cmpw  #'(*256+')     Just ()?
           cmpw  $2829
           bne   L141           No, go process parameters
           leax  -2,x
           sta   ,x             delete empty string
           subb  #2
L141       clre
           tfr   b,f            string length
           leay  -1,y
           tfm   x-,y-          copy -> org. position
           leax  1,y
           rts

quote      tste
           beq   L137
           ste   ,x+
           incb
L137       rts

ENTRY      lbsr  procID         check processor
           tfr   u,d
           ldw   #256
           clr   ,-s
           tfm   s,u+
           LEAU  ,X
           STD   membase
           INCA
           STA   <$D9
           STD   Sstack
           STD   Spointer
           inca
           inca
           STD   userSP
           STD   SStop
           INCA
           TFR   D,S
           STD   moddir
           INCA
           STD   ResTop
           STD   exprBase
           tfr   x,y
           lbsr  skpblank
L90        lda   ,y+
           cmpa  #32
           beq   L89
           cmpa  #13
           beq   L97            no params
           bra   L90            skip modulename

L89        lbsr  skpblank
           cmpa  #40            left par.??
           beq   L97            format OK
           lbsr  L302           check char
           bcc   L99            = letter or number
           cmpa  #45            = -
           beq   L99
           cmpa  #47            = /
           bne   L97            do not adjust format
L99        lbsr  chprm
L97        TFR   X,D
           SUBD  membase
           STD   memsize
           LDB   #1             default errpath
           STB   <$2E
           LDA   #3             Close all paths 4-16
L92        os9   I$Close
           INCA
           CMPA  #$10
           BLO   L92
           CLR   <$35
           PSHS  X,DP
           pshs  x,y            Setup up a stack big enough for 6309 RTI
           pshs  u,y,x,dp,d,cc
           leax  <ckexit,pc     Point to routine below
           stx   10,s           Save as return address from RTI for both 6809
           stx   12,s             & 6309 stacks
           stw   6,s
           rti                  Pull all regs & return

ckexit     leax  ,x             X pointing to where it is supposed to?
           beq   ntive          Yes, we are in native mode
           lda   #7             beep to signal
           pshs  a              emulation mode
           leax  ,s
           ldy   #1
           lda   #1
           os9   I$Write
           leas  3,s            clear stack
           leax  L94,pc
           bra   L96

ntive      LEAX  L93,PC
L96        puls  dp
           os9   F$Icpt
           ldx   moddir
           ldw   ResTop
           subr  x,w
           clr   ,-s
           tfm   s,x+           clear module dir
           leas  1,s
           TFR   DP,A
           LDB   #$50
           LEAX  L1382,PC
           ldw   #17
           tfm   x+,d+          init RND & syscall
           LEAX  L710,PC
           STX   table1
           LEAX  L1386,PC
           STX   table2
           LEAX  L1388,PC
           STX   table3
           LDA   #$7E
           STA   table4
           LEAX  L1390,PC
           STX   <table4+1
           ldx   #$FFFF         init links
           stx   Vsys
           stx   Vinkey
           PULS  Y
           BSR   L102
           LDX   moddir
           LDD   ,X
           STD   PGMaddre
           BSR   L134
L102       LEAX  <L106,PC
           PULS  U
           BSR   L108
           PSHS  U
           CLR   <$34
           LDD   membase
           ADDD  memsize
           SUBD  ResTop
           STD   freemem
           LEAU  2,S
           STU   userSP
           STU   SStop
           LEAS  >-$FE,S
           JMP   [-2,U]

err43      LDB   #$2B
L118       LBSR  PRerror
L116       LDS   <$B7
           PULS  d
           STD   <$B7
ClrSstac   lde   #1
           ste   charcoun
           LDW   Sstack
           STW   Spointer
           rts

L108       LDD   <$B7
           PSHS  d
           STS   <$B7
           LDD   2,S
           STX   2,S
           TFR   D,PC
L106       BSR   L102
           BRA   BYE

* ----------------------- *
L134       LBSR  skpblank
           LBSR  link
           BCS   err43
           LDX   ,X
           STX   PGMaddre
           LDA   6,X
           BEQ   L144
           ANDA  #$0F
           CMPA  #2             B09 program?
           BNE   err51
           BRA   L148

L144       LDA   <$17,X         BASIC09 program has no errors?
           RORA
           BCS   err51          Errors, report it
L148       LBSR  L230           check prmlist
           LDY   exprBase
           LDB   ,Y
           CMPB  #$3D
           BEQ   err51
           STY   excoffse
           LDX   <$AB
           STX   excEnd
           LDX   PGMaddre
           LDA   <$17,X
           RORA
           BCS   err51
           LEAS  >$0102,S
           LDD   membase
           ADDD  memsize
           TFR   D,Y
           STD   userSP
           STD   SStop
           LDU   #0
           STU   WSbase
           STU   <$B3
           INC   <$B4
           CLR   errcode
           LDD   exprBase
           LDX   freemem
           PSHS  X,d
           LEAX  <L154,PCR
           BSR   L108
           LDX   exprBase
           LBSR  L670           set up prm stack
           LBSR  ClrSstac
           LDX   PGMaddre
           LBSR  L676           execute module
           LBRA  L116

L154       PULS  X,d
           STD   exprBase
           STX   freemem
           LBRA  L116

err51      LDB   #$33
           LBRA  L118

* ----------------------- *
BYE        BSR   unlink
           CLRB
           os9   F$Exit

*
KILL       JSR   table4
           LDY   1,Y
           PSHS  X
           LBSR  skpblank
           pshs  y
           LBSR  ISlett
           BCS   L164           invalid string
           LEAY  1,Y
L304       LDA   ,Y+
           LBSR  L302           number/letter?
           BCC   L304
*           oim   #$80,-2,y
           fcb   $61,$80,$3e
           puls  y
           BSR   L166           in moddir?
           BCS   L164
           ldu   ,x++           module address
           os9   F$UnLink
* update module directory *
           leay  -2,x
L176       LDD   ,X++
L178       STD   ,Y++
           BNE   L176
           CMPD  ,Y
           BNE   L178           clear old data
           PULS  PC,X

L164       COMB
           LDB   #$2B           error 43
           puls  pc,x

unlink     LDY   Spointer
           LDA   #$2A           = *
           STA   ,Y
           STA   <$35
           CLR   PGMaddre
           ldx   moddir
L172       LDU   ,X++           module address
           beq   L175
           os9   F$Unlink
           bra   L172           next module

* clear module dir *
L175       tfr   x,w
           ldd   moddir
           subr  d,w            w=length of moddir
           tfm   x,d+
           rts

L166       PSHS  U,Y
           LDX   moddir
L182       LDY   ,S
           LDU   ,X++           module address
           BEQ   L180           end of directory
           LDD   4,U            name offset
           LEAU  D,U            address of name
L184       LDA   ,U+
           EORA  ,Y+
           ANDA  #$DF
           BNE   L182           next module
           TST   -1,U
           BPL   L184           next char
           CLRA  found          it!
L186       LEAX  -2,X
           PULS  PC,U,d

L180       COMA
           BRA   L186

link       BSR   L166
           BCS   L188           not in mod.dir.
           RTS

L188       PSHS  U,Y,X
           LDB   1,S
           CMPB  #$FE
           blo   L190
           ldb   #32            error 32
           lbra  L118

L190       LEAX  ,Y
           clrd
           os9   F$Link
           BCC   L192
           LDX   2,S            module not in mem.
           clrd
           os9   F$Load
           BCS   L194
L192       STX   2,S
           STU   [,S]           add to moddir
L194       PULS  PC,U,Y,X

PRerror    os9   F$PErr
           RTS

L650       PSHS  X,d
L208       LEAX  <L204,PC
           LDA   ,Y+
L206       CMPA  ,X++
           BLO   L206
           LDB   ,-X
           JMP   B,X

*  embedded jumptable
*  do not change until L264
L204       fcb   $F2
           fcb   LA2-*
           fcb   $92
           fcb   LA4-*
           fcb   $91
           fcb   LA2-*
           fcb   $90
           fcb   L210-*
           fcb   $8f
           fcb   LA1-*
           fcb   $8e
           fcb   LA2-*
           fcb   $8d
           fcb   LA3-*
           fcb   $55
           fcb   LA2-*
           fcb   $4b
           fcb   LA4-*
           fcb   $3e
           fcb   L21C-*
           fcb   $00
           fcb   LA4-*
LA1        LEAY  3,Y
LA2        LEAY  1,Y
LA3        LEAY  1,Y
LA4        BRA   L208

L210       TST   ,Y+
           BPL   L210
           BRA   L208
L21C       PULS  PC,X,d

* check param list for:
           fcb   0,7,3
L264       fcb   L272-L270,75,12,172 ,
           fcb   L272-L270,77,12,168 (
           fcb   L272-L270,78,12,169 )
           fcb   L18-L270,137,12,174 "
           fcb   L17-L270,144,6,162 .
           fcb   0,145,6,164    $
           fcb   L272-L270,63,2,141 %

* error: print problem statement
*   and point to error
L236       LDA   #12
L252       PSHS  A
           LDX   <$A7           strip high order bits
           LDA   #$0D
L218       fcb   $62,$7f,$84
*L218       aim   #$7F,,x
           CMPA  ,X+
           BNE   L218
           LDX   <$A7
           BSR   prnterr
           LDD   <$B9
           SUBD  <$A7
           tfr   b,f
           clre
           LDX   <$AF
           STX   <$AB
           LDY   <$A7
           LDA   #$3D
           LBSR  L222
           LDA   #$3F
           LBSR  L222
           LDA   #$20       Bunch of spaces
           pshs  a
           LDX   Sstack
           tfm   s,x+
           LDD   #$5E0D     ^ + CR
           STD   -1,X
           LDX   Sstack
           BSR   prnterr
           PULS  D
           LBSR  PRerror
           LDX   userSP
           STX   SStop
           LBRA  L116

prnterr    LDY   #$0100
           LDA   errpath
           os9   I$WritLn
           RTS

**** decode parameters passed ***
L230       STY   <$A7
           LDX   exprBase
           STX   <$AF
           STX   <$AB
           INC   <$A0
           BSR   L232
           BSR   L234
           CLR   <$A0
           LDA   <$A3
           CMPA  #$3F           % ??
           BNE   L236           error 12
           LBRA  L222

L234       CMPA  #$4D           ( ??
           BNE   L238           no params
L246       LBSR  L222
           LDD   <$AB
           BSR   L242
           LDB   <$A4
           CMPB  #6             . or $ ??
           BNE   L238
           BSR   L232
           BSR   L244
           BEQ   L246
           PSHS  A
           BRA   L248

L238       RTS
L232       BSR   L242
           LDX   <$AD
           STX   <$AB
           LDA   <$A3
           RTS

L244       LDA   <$A3
           CMPA  #$4B           , ??
L250       RTS

L254       LDA   <$A3
           CMPA  #$4E           ) ??
           BEQ   L250           end of list
           LDA   #$25           error 37
L256       LBRA  L252

L248       BSR   L254
           PULS  A
           LBSR  L222
           BRA   L232

err10      LDA   #$0A
           BRA   L256

L242       LDD   <$AB
           STD   <$AD
           LBSR  skpblank
           STY   <$B9
           LDA   ,Y
           LBSR  ISnum
           BCC   L262
           LEAX  L264,PCR
           LDA   #$80
           LBSR  L266           ill. chars in prmlist?
           BEQ   err10          yes!!
           LDB   ,X
           LEAU  <L270,PC
           JMP   B,U

L272       LDD   1,X
           STB   <$A4
           STA   <$A3
           LBRA  L222

L18        LDA   ,Y
           LBSR  ISnum
           BCS   L272           NO!!
           LEAY  -1,Y
L262       BSR   L274
           BNE   L276
           LDD   #$8F05
L282       STA   <$A3
           tfr   d,w
           clre
           pshs  u
           ldu   <$AB
           addr  u,w
           subw  exprBase
           cmpf  #$FF
           bcc   err13
           tfr   d,w
           clre
L280       sta   ,u+
           LDA   ,X+
           DECF
           BPL   L280
           stu   <$AB
           puls  u
           LDA   #6
           STA   <$A4
           RTS

L276       LDD   #$8E02
           TST   ,X
           BNE   L282
           LDD   #$8D01
           LEAX  1,X
           BRA   L282

L270       LEAY  -1,Y
           BSR   L274
           LDD   #$9102
           BRA   L282

L274       BSR   skpblank
           LEAX  ,Y
           LDY   SStop
           LBSR  AtoITR         string -> number
           EXG   X,Y
           BCS   err22
           LDA   ,X+
           CMPA  #2
           RTS

err22      LDA   #$16
           BRA   L288

L17        BSR   L272
           BRA   L290

L294       BSR   L222
L290       LDA   ,Y+
           CMPA  #$0D
           BEQ   err41
           CMPA  #$22           " ??
           BNE   L294
           CMPA  ,Y+
           BEQ   L294
           LEAY  -1,Y
           LDA   #$FF
L278       BRA   L222

err41      LDA   #$29
L288       LBRA  L252

           LDA   #$31           error 49 (HOW DOES IT GET HERE?)
           BRA   L288

L222       PSHS  X,D
           LDX   <$AB
           STA   ,X+
           STX   <$AB
           LDD   <$AB
           SUBD  exprBase
           CMPB  #$FF
           BCC   err13
           CLRA
           PULS  PC,X,D

err13      LDA   #$0D
           LBSR  PRerror
           LBRA  L116

*
skpblank  LDA   ,Y+
           CMPA  #$20
           BEQ   skpblank      skip blanks
           CMPA  #$0A
           BEQ   skpblank      and LF's
           LEAY  -1,Y
           RTS

L302       BSR   ISlett
           BCC   L308
ISnum      CMPA  #$30           0 ??
           BCS   L308
           CMPA  #$39           9 ??
           BLS   L310
           BRA   L312

ISlett     ANDA  #$7F
           CMPA  #$41           A ??
           BCS   L308
           CMPA  #$5A           Z ??
           BLS   L310
           CMPA  #$5F           _ ??
           BEQ   L308
           CMPA  #$61           a ??
           BCS   L308
           CMPA  #$7A           z ??
           BLS   L310
L312       ORCC  #1             NO
           RTS

L310       ANDCC #$FE           YES
L308       RTS

* search prm list for special chars *
L266       PSHS  U,Y,X,A
           LDU   -3,X
           LDB   -1,X
L326       STX   1,S
           CMPU  #0             USE CMPR 0,U (SAME SPEED, 2 BYTES SHORTER)
           BEQ   L320
           LEAU  -1,U
           LDY   3,S
           LEAX  B,X
L328       LDA   ,X+
           EORA  ,Y+
           BEQ   L322
           CMPA  ,S
           BEQ   L322
           LEAX  -1,X
L324       LDA   ,X+
           BPL   L324
           BRA   L326

L322       TST   -1,X
           BPL   L328
           STY   3,S
L320       PULS  PC,U,Y,X,A

L710       fdb   L1900-L710     table @ L204
           fdb   L1900-L710     PARAM
           fdb   L1900-L710     TYPE
           fdb   L1900-L710     DIM
           fdb   L1900-L710     DATA
           fdb   STOP-L710
           fdb   BYE-L710
           fdb   L386-L710      TRON
           fdb   L386-L710      TROFF
           fdb   L386-L710      PAUSE
           fdb   DEG-L710
           fdb   RAD-L710
           fdb   RETURN-L710
           fdb   L370-L710
           fdb   LET-L710
           fdb   POKE-L710
           fdb   IF-L710
           fdb   GOTO-L710      = ELSE
           fdb   ENDIF-L710
           fdb   FOR-L710
           fdb   NEXT-L710      table @ L388
           fdb   UNTIL-L710     = WHILE
           fdb   GOTO-L710      = ENDWHILE
           fdb   L370-L710      = REPEAT
           fdb   UNTIL-L710
           fdb   L370-L710      = LOOP
           fdb   GOTO-L710      = ENDLOOP
           fdb   UNTIL-L710     = EXITIF
           fdb   GOTO-L710      = ENDEXIT
           fdb   ON-L710
           fdb   ERROR-L710
           fdb   errs51-L710
           fdb   GOTO-L710
           fdb   errs51-L710
           fdb   GOSUB-L710
           fdb   RUN-L710
           fdb   KILL-L710
           fdb   INPUT-L710
           fdb   PRINT-L710
           fdb   CHD-L710
           fdb   CHX-L710
           fdb   CREATE-L710
           fdb   OPEN-L710
           fdb   SEEK-L710
           fdb   READ-L710
           fdb   WRITE-L710
           fdb   GET-L710
           fdb   PUT-L710
           fdb   CLOSE-L710
           fdb   RESTORE-L710
           fdb   DELETE-L710
           fdb   CHAIN-L710
           fdb   SHELL-L710
           fdb   BASE0-L710
           fdb   BASE1-L710
           fdb   386-L710       REM
           fdb   386-L710
           fdb   END-L710
* From here on is added from original BASIC09 table @ L1D60
           fdb   L1943-L710     go to next instruction
           fdb   L1943-L710
           fdb   L1944-L710     jump to [regs.x]
           fdb   errs51-L710
           fdb   L386-L710      RTS
           fdb   L386-L710
           fdb   CpMbyte-L710
           fdb   CpMint-L710
           fdb   CpMreal-L710
           fdb   CpMbyte-L710
           fdb   CpMstrin-L710
           fdb   CpMarray-L710
L448       fcc   /STOP Encountered/
           fcb   10,255

*
* setup workspace for module
L676       LDA   $17,X
           BITA  #1
           BEQ   L346
           LBRA  errs51

L346       TFR   S,D
           deca
           CMPD  Sstack
           BCC   L350
           LDB   #$39           error 57 (system stack overflow)
           BRA   L348

L350       LDD   freemem
           SUBD  $0B,X
           BCS   err32
           CMPD  #$0100
           BCC   L354
err32      LDB   #$20
L348       LBRA  L356

L354       STD   freemem
           TFR   Y,D
           SUBD  $0B,X
           EXG   D,U
           STS   5,U
           STD   7,U
           STX   3,U
L344       LDD   #1             default:base 1
           STD   ArrBase
           STA   1,U            default: radians
           STA   <$13,U
           STU   $14,U
           BSR   L358
           LDD   <$13,X
           BEQ   L360
           ADDD  excoffse
L360       STD   DATApoin
           LDW   $0B,X
           LDD   <$11,X
           LEAY  D,U
           subr  d,w
           bls   L362
           clr   ,-s
           tfm   s,y+
           LEAS  1,S
L362       LDX   PGMaddre
           LDD   excoffse
           ADDD  <$15,X
           TFR   D,X
           BRA   L366           start execution

*
L358       STX   PGMaddre
           STU   WSbase
           LDD   $0D,X
           ADDD  PGMaddre
           STD   VarPtrba
           LDD   $0F,X
           ADDD  PGMaddre
           STD   vectorba
           STD   excEnd
           LDD   9,X
           ADDD  PGMaddre
           STD   excoffse
           LDD   $14,U
           STD   userSP
           STD   SStop
           RTS

*** MAIN LOOP
L372       LDA   <$34           Check if signal received
           BPL   L368           No, execute next instruction
           ANDA  #$7F           flag signal received
           STA   <$34
           LDB   <$35
           BNE   L348           process it
L368       BSR   L370
L366       CMPX  excEnd
           BCS   L372
           BRA   L374

*
END        LDB   ,X
           LBSR  nextinst
           BEQ   L374
           LBSR  PRINT
L374       LDU   WSbase
           LDS   5,U
           LDU   7,U
L386       RTS

L1943      LEAX  2,X
L370       LDB   ,X+
           BPL   L382
           ADDB  #$40
L382       ASLB
           CLRA
           LDU   table1         = L710
           LDD   D,U
           JMP   D,U            go to instruction

*
IF         JSR   table4         if....
           TST   2,Y
           BEQ   GOTO           = FALSE
           LEAX  3,X            THEN
           LDB   ,X
           CMPB  #$3B
           BNE   L386
           LEAX  1,X            ELSE
GOTO       LDD   ,X
           ADDD  excoffse
           TFR   D,X
           RTS

ENDIF      LEAX  1,X
           RTS

UNTIL      JSR   table4
           TST   2,Y
           BEQ   GOTO           = FALSE
           LEAX  3,X
           RTS

*
L388       fdb   L70-L388       int. step 1
           fdb   L71-L388       int. step x
           fdb   L72-L388       real step 1
           fdb   L73-L388       real step x

*
NEXT       LEAY  <L388,PC
L414       LDB   ,X+
           ASLB
           LDD   B,Y
           LDU   WSbase
           JMP   D,Y

L75        LDD   ,X
           LEAY  D,U
           BRA   L390

L76        LDD   ,X
           LEAY  D,U
           LDD   4,X
           LDA   D,U
           BPL   L390
           BRA   L392

*  FOR .. NEXT  /integer  *
L70        LDD   ,X             offset counter
           LEAY  D,U            address counter
           LDD   ,Y
           incd                 increment counter
           STD   ,Y
L390       LDD   2,X            offset target
           LEAX  6,X
           LDD   D,U            target value
           CMPD  ,Y
           BGE   GOTO           loop again
           LEAX  3,X
           RTS

*  FOR .. NEXT .. STEP  /integer *
L71        LDD   ,X
           LEAY  D,U
           LDD   4,X
           LDD   D,U
           tfr   a,e
           ADDD  ,Y             update counter
           STD   ,Y
           tste
           BPL   L390           incrementing
L392       LDD   2,X
           LEAX  6,X
           LDD   D,U
           CMPD  ,Y
           BLE   GOTO           loop again
           LEAX  3,X
           RTS

L77        LDY   userSP
           CLRB
           BSR   L394
           BRA   L396

L78        LDY   userSP
           CLRB
           BSR   L394
           LDD   4,X
           ADDD  #4
           LDU   WSbase
           LDA   D,U
           LSRA  examine        sign
           BCC   L396
           BRA   L398

*  FOR .. NEXT   /real  *
L72        LDY   userSP
           CLRB
           BSR   L394
           LEAY  -6,Y
           LDD   #$0180         step 1 (save in temp var)
           STD   1,Y
           clrd
           STD   3,Y
           STA   5,Y
           LBSR  RLADD
           LDQ   1,Y
           STQ   ,U
           LDA   5,Y
           STA   4,U
L396       LDB   #2             incrementing
           BSR   L394
           LEAX  6,X
           LBSR  RLCMP
           LBLE  GOTO           loop again
           LEAX  3,X
           RTS

L394       LDD   B,X            copy number
           ADDD  WSbase
           TFR   D,U
           LEAY  -6,Y
           LDA   #2
           LDB   ,U
           STD   ,Y
           LDQ   1,U
           STQ   2,Y
           RTS

*  FOR .. NEXT .. STEP /real  *
L73        LDY   userSP
           CLRB
           BSR   L394
           STU   <$D2
           LDB   #4
           BSR   L394
           LDA   4,U
           STA   <$D1
           LBSR  RLADD          incr. counter
           LDU   <$D2
           LDQ   1,Y
           STQ   ,U
           LDA   5,Y
           STA   4,U
           LSR   <$D1           check sign
           BCC   L396
L398       LDB   #2             decrementing
           BSR   L394
           LEAX  6,X
           LBSR  RLCMP
           LBGE  GOTO           loop again
           LEAX  3,X
           RTS

******* table for FOR ********
L412       fdb   L75-L412       int. step 1
           fdb   L76-L412       int. step x
           fdb   L77-L412       real step 1
           fdb   L78-L412       real step x

*
FOR        LDB   ,X+
           CMPB  #$82
           BEQ   L405
           BSR   CpMint
           BSR   L410
           LDB   -1,X
           CMPB  #$47
           BNE   L408
           BSR   L410
L408       LBSR  GOTO
           LEAY  <L412,PC
           LBRA  L414
L410       LDD   ,X++
           ADDD  WSbase
           PSHS  d
           JSR   table4
           LDD   1,Y
           STD   [,S++]
           RTS

L405       BSR   CpMreal
           BSR   L418
           LDB   -1,X
           CMPB  #$47
           BNE   L408
           BSR   L418
           BRA   L408

L418       LDD   ,X++
           ADDD  WSbase
           PSHS  d
           JSR   table4
           BRA   L420

LET        JSR   table4         get var. type
L422       CMPA  #4
           BCS   L442
           PSHS  U
           LDU   fieldsiz
L442       PSHS  U,A
           LEAX  1,X
           JSR   table4
L516       PULS  A
           ASLA
           LEAU  <L424,PC
           JMP   A,U            copy

L424       BRA   L426           byte
           BRA   L428           integer
           BRA   L420           real
           BRA   L426           boolean
           BRA   L430           string
           BRA   L432           array

CpMbyte    LDD   ,X
           ADDD  WSbase
           PSHS  D
           LEAX  3,X
           JSR   table4
L426       LDB   2,Y
           STB   [,S++]
           RTS

CpMint     LDD   ,X
           ADDD  WSbase
           PSHS  d
           LEAX  3,X
           JSR   table4
L428       LDD   1,Y
           STD   [,S++]
           RTS

CpMreal    LDD   ,X
           ADDD  WSbase
           PSHS  d
           LEAX  3,X
           JSR   table4
L420       PULS  U
           LDQ   1,Y
           STQ   ,U
           LDA   5,Y
           STA   4,U
           RTS

CpMstrin   LDD   ,X
           ADDD  vectorba
           TFR   D,U
           LDQ   ,U
           ADDD  WSbase
           PSHS  D
           PSHSW
           LEAX  3,X
           JSR   table4
L430       PULS  U,D            D=Max Size of string to copy
           ldw   3,y
           stw   BUPsize
           incw                 Allow for $FF terminator
           cmpr  d,w            Other string big enough?
           bls   L431           Yes, copy
           tfr   d,w            No, only copy smaller size
           stw   BUPsize
L431       ldd   1,y            Get address of string to copy
           STD   exprSP         Save it
           stu   BUPaddr        Save address of destination string
           tfm   d+,u+          Copy (ignore $FF?)
           clra                 clear carry
           RTS

CpMarray   LBSR  L728
           LBRA  L422

L432       PULS  U,D
           ldw   3,y
           cmpr  d,w
           BLS   L444
           tfr   d,w
L444       ldd   1,y
           tfm   d+,u+
           rts

POKE       JSR   table4
           LDD   1,Y
           PSHS  d
           JSR   table4
           LDB   2,Y
           STB   [,S++]
           RTS

STOP       LBSR  PRINT
           LDA   errpath
           STA   IOpath
           LEAX  L448,PC
           LBSR  Sprint
           LBRA  L116           exit

GOSUB      LDD   ,X
           LEAX  3,X
L464       LDY   WSbase
           LDU   $14,Y
           CMPU  exprBase
           BHI   L456
           LDB   #$35           error 53
           LBRA  L356

L456       STX   ,--U           pshs x (pshu x?)
           STU   $14,Y
           STU   userSP
           ADDD  excoffse
           TFR   D,X            address subroutine
           RTS

RETURN     LDY   WSbase
           CMPY  $14,Y
           BHI   L458
           LDB   #$36           error 54
           LBRA  L356

L458       LDU   $14,Y
           LDX   ,U++           puls x  (pulu x)
           STU   $14,Y
           STU   userSP
           RTS

ON         LDD   ,X
           CMPA  #$1E
           BEQ   L460           set trap
           JSR   table4
           LDD   ,X
           asld
           asld
           incd
           incd
           LEAU  D,X
           PSHS  U
           LDD   1,Y
           BLE   L462
           CMPD  ,X++
           BHI   L462
           decd
           asld
           asld
           incd
           LDD   D,X
           PSHS  d
           LDB   ,X
           CMPB  #$22
           PULS  X,d
           BEQ   L464
           ADDD  excoffse
           TFR   D,X
           RTS

L462       PULS  PC,X

L460       LDU   WSbase
           CMPB  #$20
           BNE   L466           clear trap
           LDD   2,X
           ADDD  excoffse
           STD   <$11,U
           LDA   #1
           STA   <$13,U
           LEAX  5,X
           RTS

L466       CLR   <$13,U
           LEAX  2,X
           RTS

CREATE     BSR   L468
           LDB   #$0B           R/W/PR
           os9   I$Create
           BRA   L470

OPEN       BSR   L468
           os9   I$Open
L470       LBCS  L356           error
           PULS  U,B
           CMPB  #1
           BNE   L472           store as byte
           CLR   ,U+            integer
L472       STA   ,U             path number
           PULS  PC,X

L468       LEAX  1,X
           LBSR  getvar
           LEAX  1,X
           JSR   table4
           LDA   #3             default: UPDATE
           CMPB  #$4A
           BNE   L476
           LDA   ,X++           access mode
L476       LDU   3,S
           STX   3,S
           LDX   1,Y
           JMP   ,U             = RTS

SEEK       LBSR  setpath
           JSR   table4
           LBSR  setFP          set filepointer
           LBCS  errman
           RTS

L500       fcc   /? /
           fcb   255

L514       fcc   /** Input error - reenter **/
           fcb   13,255

INPUT      LDA   errpath
           LBSR  setpath
           LDA   #$2C
           STA   <$DD
           PSHS  X
L508       LDX   ,S
           LDB   ,X
           CMPB  #$90
           BNE   L498           use default
           JSR   table4
           PSHS  Y,X
           LDX   1,Y            get prompt
           ldy   3,y
           BRA   L490

L498       PSHS  Y,X
           LEAX  <L500,PC      default prompt
           ldy   #2
L490       lda   IOpath
           os9   I$WritLn
           PULS  Y,X
           LDA   IOpath
           CMPA  errpath
           BNE   L502
           LDA   <$2D
           STA   IOpath
L502       LBSR  READLN
           BCC   L504           NO error
           CMPB  #3
           LBNE  errman
           LBSR  L506           BREAK pressed
           CLR   errcode
           BRA   L508

L504       BSR   L510           check input
           BCC   L512
           LEAX  <L514,PC      input error
           BSR   Sprint
           BRA   L508           try again

L512       LDB   ,X+
           CMPB  #$4B
           BEQ   L504           more items!!
           PULS  PC,d

L510       BSR   getvar
           LDB   ,S
           ADDB  #7
           LDY   userSP
           LBSR  L46
           LBCC  L516
L518       LEAS  3,S            clear stack
           COMA  signal         an error
           RTS

*print a message
Sprint     pshs  y,x
           ldy   Sstack
L473       lda   ,x+
           sta   ,y+
           cmpa  #$FF
           bne   L473
           leay  -1,y
           sty   <$Spointer
           lbsr  WRITLN
           puls  pc,y,x

getvar     LDA   ,X+
           CMPA  #$0E           vectored variable?
           BNE   L520
           JSR   table4
           BRA   L522

L520       SUBA  #$80
           CMPA  #4
           BCS   L524           byte,int,real
           BEQ   L526           string
           LBSR  L728           array
           BRA   L522

L526       LDD   ,X++
           ADDD  vectorba
           TFR   D,U
           LDQ   ,U
           stw   fieldsiz
           BRA   L528

L524       LDD   ,X++
L528       ADDD  WSbase
           TFR   D,U
           LDA   -3,X
           SUBA  #$80
L522       PULS  Y
           CMPA  #4
           BCS   L530
           PSHS  U
           LDU   fieldsiz
L530       PSHS  U,A
           JMP   ,Y             = RTS

* set IO path
* called by #path statement
setpath    LDB   ,X
           CMPB  #$54           path number given?
           BNE   L532
           LEAX  1,X
           JSR   table4
           CMPB  #$4B           string follows?
           BEQ   L534
           LEAX  -1,X
L534       LDA   2,Y
L532       STA   IOpath
           RTS

READ       LDB   ,X
           CMPB  #$54
           BNE   L536           read from DATA statement
           BSR   setpath
           CLR   <$DD
           CMPB  #$4B
           BNE   L538
           LEAX  -1,X
L538       LBSR  READLN
           BCC   L540
           CMPB  #$E4           error 228 ?
           BEQ   L538
L542       LBRA  errman

L544       LBSR  L510           check input
           BCS   L542
L540       LDB   ,X+
           CMPB  #$4B
           BEQ   L544           more items
           RTS

L536       BSR   nextinst
           BEQ   L546           literal data
* process data statements that are expressions
L550       BSR   L548
           LDB   ,X+
           CMPB  #$4B
           BEQ   L550
           RTS

L548       LBSR  getvar
           BSR   L552           get data item
           LDA   ,S
           BNE   L554
           INCA
L554       CMPA  ,Y
           LBEQ  L516
           CMPA  #2
           BCS   L556           byte,integer
           BEQ   L558           real numbers
err71      LDB   #$47
           BRA   L560

L556       LDA   ,Y
           CMPA  #2
           BNE   err71
           LBSR  FIX
           LBRA  L516

L558       CMPA  ,Y
           BCS   err71
           LBSR  FLOAT
           LBRA  L516

*
L546       LEAX  1,X
L552       PSHS  X
           LDX   DATApoin
           BNE   L568
           LDB   #$4F           error 79
L560       LBRA  L356

L568       JSR   table4
           CMPB  #$4B
           BEQ   L570
           LDD   ,X
           ADDD  excoffse
           TFR   D,X
L570       STX   DATApoin
           PULS  PC,X

* instruction delimiters
nextinst   CMPB  #$3F           = end of line
           BEQ   L572
           CMPB  #$3E           = "back slash"
L572       RTS

PRINT      LDA   errpath
           LBSR  setpath
           LDD   Sstack
           STD   Spointer
           LDB   ,X+
           CMPB  #$49           print using
           BEQ   L574
L584       BSR   nextinst
           BEQ   L576
L586       CMPB  #$4B           comma separator?
           BEQ   L578
           CMPB  #$51           semi-colon?
           BEQ   L580
           LEAX  -1,X
           JSR   table4         get variable address
           LDB   ,Y
           incb
           LBSR  L46            copy to Sstack
           LBCS  errman
           LDB   -1,X
           BRA   L584

L578       LBSR  L2012          print spaces
           lbcs  errman
L580       LDB   ,X+
           BSR   nextinst
           BNE   L586
           BRA   L588

L576       lbsr  Strterm
           lbcs  errman
L588       lbsr  WRITLN
           lbcs  errman
           RTS

L574       JSR   table4
           LDD   exprBase
           STD   <$8E
           STD   <$8C
           LDU   userSP
           PSHS  U,d
           LDD   exprSP
           STD   exprBase
L598       LDB   -1,X
           BSR   nextinst
           BEQ   L594
           LDB   ,X+
           BSR   nextinst
           BEQ   L596
           LEAX  -1,X
           LBSR  PRNTUSIN
           BCC   L598
           PULS  U,d          error encountered
           STD   exprBase
           STU   userSP
           LBRA  errman

L596       LEAY  <L588,PC
           BRA   L600

L594       LEAY  <L576,PC
L600       PULS  U,d
           STD   exprBase
           STU   userSP
           JMP   ,Y

WRITE      LDA   errpath
           LBSR  setpath
           LDU   Sstack
           STU   Spointer
           LDB   ,X+
           LBSR  nextinst
           BEQ   L602
           CMPB  #$4B           comma separator?
           BEQ   L604
           LEAX  -1,X
           BRA   L604

L606       CLRA
           LBSR  L1632
           LBCS  errman
L604       JSR   table4
           LDB   ,Y
           incb
           LBSR  L46
           LBCS  errman
           LDB   -1,X
           LBSR  nextinst
           BNE   L606
L602       LBRA  L576

GET        BSR   L608
           stx   BUPaddr
           os9   I$Read
           sty   BUPsize
           BRA   L610

PUT        BSR   L608
           os9   I$Write
L610       LEAX  ,U
           BCC   L612
L620       LBRA  L356

L608       LBSR  setpath
           LBSR  getvar
           LEAU  ,X
           PULS  A
           CMPA  #4
           bcs   L609
           puls  y
           bra   L618

L609       LEAX  L616,PC
           LDB   A,X
           CLRA
           TFR   D,Y
L618       PULS  X
           LDA   IOpath
L612       RTS

CLOSE      LBSR  setpath
           os9   I$Close
           BCS   L620
           CMPB  #$4B
           BEQ   CLOSE          multiple paths
           RTS

RESTORE    LDB   ,X+
           CMPB  #$3B
           BEQ   L624           to line ...
           LDU   PGMaddre
           LDD   <$13,U         rewind
L626       ADDD  excoffse
           STD   DATApoin
           RTS

L624       LDD   ,X
           incd
           LEAX  3,X
           BRA   L626

DELETE     JSR   table4
           PSHS  X
           LDX   1,Y
           os9   I$Delete
L628       BCS   L620
           PULS  PC,X

CHD        JSR   table4
           LDA   #3             read & write
L630       PSHS  X
           LDX   1,Y
           os9   I$ChgDir
           BRA   L628

CHX        JSR   table4
           LDA   #4             execute
           BRA   L630

CHAIN      JSR   table4
           LDY   1,Y
           PSHS  U,Y,X
           LBSR  unlink
           PULS  U,Y,X
           BSR   L634           set up registers
           STS   <$B1           Save stack ptr
           LDS   Sstack
           os9   F$Chain
           LDS   <$B1           If gets this far, chain failed
           BRA   L356

SHELL      JSR   table4
           PSHS  U,X
           LDY   1,Y
           BSR   L634           set up registers
           os9   F$Fork
           BCS   L356
           PSHS  A              Save child's process #
L636       os9   F$Wait         Wait for child to die
           CMPA  ,S             Our child?
           BNE   L636           No, wait for next death
           LEAS  1,S
           TSTB
           BNE   L356
           PULS  PC,U,X

L638       fcc   /SHELL/
           fcb   13

L634       LDX   exprSP
           LDA   #$0D
           STA   -1,X
           leau  ,y
           subr  y,x
           TFR   X,Y
           LEAX  <L638,PC
           clrd
           RTS

ERROR      JSR   table4
           LDB   2,Y
L356       STB   errcode
errman     LDU   WSbase
           BEQ   L640           not running subroutine
           TST   <$13,U
           BEQ   L642           no error trap
           LDS   5,U
           LDX   <$11,U
           LDD   $14,U
           STD   userSP
           LBRA  L372           process error

L642       BSR   L506
           LBRA  L116           exit

L640       LBSR  PRerror
           LBRA  L116           exit

L646       fcb   14,255         Force text mode in VDGINT
L506       LEAX  <L646,PC
           LBSR  Sprint
           LBSR  unlink
           LDB   errcode
           os9   F$Exit
BASE0      CLRB
           BRA   L648

BASE1      LDB   #1
L648       CLRA
           STD   ArrBase
           LEAX  1,X
           RTS

L1944      EXG   X,PC
           RTS

L1900      LEAY  ,X
           LBSR  L650           jumptable @ L204
           LEAX  ,Y
           RTS

errs51     LDB   #$33
           BRA   L356

DEG        LDA   #1
           BRA   L652

RAD        CLRA
L652       LDU   WSbase
           STA   1,U
           LEAX  1,X
           RTS

INKEY      leax  2,x
           ldd   ,x++
           cmpd  #$4D0E         marker
           lbne  err56
           clre  default        path: 0
           jsr   table4
           cmpa  #4             = string
           beq   L383           use default path
           cmpa  #2
           lbhs  err56          invalid type
           ldw   ,u
           tsta
           beq   L383           path = byte
           tfr   f,e
L383       pshsw
           bsr   L391
           cmpa  #4             string ??
           lbne  err56          wrong type
           pulsw
           pshs  x
           leax  ,u
           ldf   #$FF
           stf   ,x             null string
           ldd   fieldsiz
           cmpd  #2
           blo   L385
           stf   1,x            terminate string
L385       tfr   e,a            path number
           ldb   #SS.Ready
           os9   I$GetStt
           bcs   L387           no key
           ldy   #1
           os9   I$Read
           bra   L389           returns error status

L387       cmpb  #$F6           not ready ??
           beq   L389           carry = clear
           coma                 signal an error
L389       puls  pc,x

L391       ldd   ,x++
           cmpd  #$4B0E
           lbne  err56          param missing
           jsr   table4
L393       ldb   ,x+
           cmpb  #$4E
           bne   L393
           leax  1,x            -> next instruction
           rts

SYSCALL    ldd   2,x
           cmpa  #$4D           marker
           lbne  err56
           cmpb  #$0E
           bne   L401
           leax  4,x            callcode = variable
           jsr   table4
           lda   ,u
           sta   callcode
           bra   L403

L401       lda   5,x            callcode = static
           sta   callcode
           leax  6,x
L403       bsr   L391
           ldd   fieldsiz
           cmpd  #10
           lbne  err56          wrong data structure
           pshs  x
           pshs  u
           ldd   1,u            u -> data
           ldx   4,u
           ldy   6,u
           ldu   8,u
           jsr   <callex
           tfr   u,w
           puls  u
           leau  8,u
           pshu  y,x,dp,d,cc    store returns
           stw   8,u
           puls  pc,x

RUN        ldd   ,x
           cmpd  Vsys
           beq   syscall
           cmpd  Vinkey
           lbeq  inkey
           LBSR  L728           get address of name
           PSHS  X
           LDB   <$CF
           CMPB  #$A0           mod. name ?
           BEQ   L658           name found
           LDY   exprSP
           LDW   fieldsiz
L662       LDA   ,U+            copy name
           decw
           BEQ   L660
           STA   ,Y+
           CMPA  #$FF
           BNE   L662
           LDA   ,--Y
L660       ORA   #$80           terminate it
           STA   ,Y
           LDY   exprSP
           LBSR  link
           BCS   errs43
           LEAU  ,X
L658       LDD   ,U
           BNE   L668           mod. in addr.space
           LDY   <$D2
           LEAY  3,Y
           ldd   Vsys
           cmpd  #$FFFF
           bne   L661
           lbsr  ISsyscal
L661       ldd   Vinkey
           cmpd  #$FFFF
           bne   L663
           lbsr  ISinkey
L663       LBSR  link
           BCS   errs43
           LDD   ,X
           STD   ,U
L668       LDX   ,S
           STD   ,S
           LDU   WSbase
           LDA   <$34
           STA   ,U
           LDB   <$43
           STB   2,U
           LDD   exprBase
           LDW   <$40
           STQ   $0D,U
           LDD   DATApoin
           STD   9,U
           LBSR  L670           prm stack
           STX   $0B,U          next instruction
           stw   BUPaddr        clear address
           PULS  X
           LDA   6,X            module type??
           BEQ   B09subr
           CMPA  #$22
           BEQ   B09subr
           CMPA  #$21
           BEQ   MLsubr
errs43     LDB   #$2B
           LBRA  L356

MLsubr     LDD   5,U
           PSHS  B,A
           STS   5,U
           LEAS  ,Y             -> prmstack
           LDD   <$40
           subr  y,d            stacksize
           lsrd
           lsrd
           PSHS  d            number of elements
           LDD   9,X
           LEAY  L676,PC
           JSR   D,X            run ML subroutine
           LDU   WSbase
           LDS   5,U
           PULS  X
           STX   5,U
           BCC   L678           no error on exit
           LBRA  L356

* run Basic09 subroutine *
B09subr    fcb   2,$7f,$34
*          aim   #$7F,<$34
           ldd   #$FFFF
           std   Vsys           clear links
           std   Vinkey
           LBSR  L676
           LDA   ,U
           BITA  #1
           BEQ   L678           no error on exit
           LDA   ,U
           STA   <$34
L678       LDQ   $0D,U          reset DP pointers
           STD   exprBase
           STW   <$40
           LDD   9,U
           STD   DATApoin
           LDB   2,U
           SEX
           STD   ArrBase
           LDX   3,U
           LBSR  L358
           LDX   $0B,U
           LDD   SStop
           SUBD  exprBase
           STD   freemem
           ldd   #$FFFF
           std   Vinkey
           std   Vsys
           RTS

ISinkey    leax  <L613,pc
           bra   L677

ISsyscal   leax  <L615,pc
L677       pshs  y
L679       lda   ,x+
           eora  ,y+
           anda  #$DF
           bne   L681           = RTS
           lda   -1,x
           bpl   L679           next char
           puls  u,y            clear stack
           puls  x
           leax  -2,x
           ldw   ,x
           cmpa  #$EC           l ??
           bne   L683
           stw   Vsys
           lbra  syscall

L683       stw   Vinkey
           lbra  inkey

L681       puls  pc,y           no match

L613       fcs   /inkey/
L615       fcs   /SysCall/

L616       fcb   1,2,5,1

* assemble parameter stack
L670       PSHS  U
           leay  <L616,pc
           LDB   ,X+
           CLRA
           PSHS  Y,X,A
           CMPB  #$4D
           BNE   L684           no params
           LEAY  ,S
L696       PSHS  Y
           LDB   ,X
           CMPB  #$0E
           BEQ   L686           variable: any type
           JSR   table4         variable type ?
           LEAX  -1,X
           CMPA  #2
           BEQ   L688           real
           CMPA  #4
           BEQ   L690           string
           LDD   1,Y
           STD   4,Y            others
           LDA   ,Y
L688       LDB   #6
           LEAU  <L616,PC
           SUBB  A,U
           LEAU  B,Y
           STU   userSP
           BRA   L692

L690       LDU   1,Y
           LDD   3,y
           STD   fieldsiz
           LDD   exprSP
           STD   exprBase
           LDA   #4
           BRA   L692

L686       LEAX  1,X
           JSR   table4         variables
L692       PULS  Y
           INC   ,Y             param count
           CMPA  #4
           BCS   L693
           LDD   fieldsiz
           bra   L694

L693       ldw   3,y            address L616
           tfr   a,b
           clra
           addr  d,w
           ldb   ,w
L694       PSHS  U,D            address + size
           LDB   ,X+
           CMPB  #$4B
           BEQ   L696           get next item
           LEAX  1,X            end of list
           STX   1,Y            = PSHS X
           LDU   userSP
           STU   <$40
           ldf   ,y
           clre
           rolw
L700       PULS  d
           STD   ,--U
           DECW
           BNE   L700
           LEAY  ,U             -> stack
           BRA   L704

L684       LDY   userSP
           STY   <$40
L704       TFR   Y,D
           SUBD  exprBase
           LBCS  err32
           STD   freemem
           puls  x,a
           PULS  PC,U,D

*********************************
           fdb   MID$-L1386
           fdb   LEFT$-L1386
           fdb   RIGHT$-L1386
           fdb   CHR$-L1386
           fdb   STR$int-L1386
           fdb   STR$rl-L1386
           fdb   DATE$-L1386
           fdb   TAB-L1386
           fdb   FIX-L1386
           fdb   fixN1-L1386
           fdb   fixN2-L1386
           fdb   FLOAT-L1386
           fdb   float2-L1386
           fdb   LNOTB-L1386
           fdb   NEGint-L1386
           fdb   NEGrl-L1386
           fdb   LANDB-L1386
           fdb   LORB-L1386
           fdb   LXORB-L1386
           fdb   Igt-L1386
           fdb   Rgt-L1386
           fdb   Sgt-L1386
           fdb   Ilo-L1386
           fdb   Rlo-L1386
           fdb   Slo-L1386
           fdb   Ine-L1386
           fdb   Rne-L1386
           fdb   Sne-L1386
           fdb   Bne-L1386
           fdb   Ieq-L1386
           fdb   Req-L1386
           fdb   Seq-L1386
           fdb   Beq-L1386
           fdb   Ige-L1386
           fdb   Rge-L1386
           fdb   Sge-L1386
           fdb   Ile-L1386
           fdb   Rle-L1386
           fdb   Sle-L1386
           fdb   INTADD-L1386
           fdb   RLADD-L1386
           fdb   STRconc-L1386
           fdb   INTSUB-L1386
           fdb   RLSUB-L1386
           fdb   INTMUL-L1386
           fdb   RLMUL-L1386
           fdb   INTDIV-L1386
           fdb   RLDIV-L1386
           fdb   POWERS-L1386
           fdb   POWERS-L1386
           fdb   DIM-L1386
           fdb   DIM-L1386
           fdb   DIM-L1386
           fdb   DIM-L1386
           fdb   PARAM-L1386
           fdb   PARAM-L1386
           fdb   PARAM-L1386
           fdb   PARAM-L1386
           fcb   0,0,0,0,0,0,0,0,0,0,0,0

*******************************
L1386      fdb   BCPVAR-L1386
           fdb   ICPVAR-L1386
           fdb   L2102-L1386    copy real number
           fdb   BlCPVAR-L1386
           fdb   SCPVAR-L1386
           fdb   L2105-L1386    copy DIM array
           fdb   L2105-L1386
           fdb   L2105-L1386
           fdb   L2105-L1386
           fdb   L2106-L1386    copy PARAM array
           fdb   L2106-L1386
           fdb   L2106-L1386
           fdb   L2106-L1386
           fdb   BCPCNST-L1386
           fdb   ICPCNST-L1386
           fdb   RCPCNST-L1386
           fdb   SCPCNST-L1386
           fdb   ICPCNST-L1386
           fdb   ADDR-L1386
           fdb   ADDR-L1386
           fdb   SIZE-L1386
           fdb   SIZE-L1386
           fdb   POS-L1386
           fdb   ERR-L1386
           fdb   MODint-L1386
           fdb   MODrl-L1386
           fdb   RND-L1386
           fdb   PI-L1386
           fdb   SUBSTR-L1386
           fdb   SGNint-L1386
           fdb   SGNrl-L1386
           fdb   L2122-L1386    transc. functions
           fdb   L2123-L1386
           fdb   L2124-L1386
           fdb   L2125-L1386
           fdb   L2126-L1386
           fdb   L2127-L1386
           fdb   EXP-L1386
           fdb   ABSint-L1386
           fdb   ABSrl-L1386
           fdb   LOG-L1386      ln
           fdb   LOG10-L1386
           fdb   SQRT-L1386
           fdb   SQRT-L1386
           fdb   FLOAT-L1386
           fdb   INTrl-L1386
           fdb   L1058-L1386    RTS
           fdb   FIX-L1386
           fdb   FLOAT-L1386
           fdb   L1058-L1386    RTS
           fdb   SQint-L1386
           fdb   SQrl-L1386
           fdb   PEEK-L1386
           fdb   LNOTI-L1386
           fdb   VAL-L1386
           fdb   LEN-L1386
           fdb   ASC-L1386
           fdb   LANDI-L1386
           fdb   LORI-L1386
           fdb   LXORI-L1386
           fdb   equTRUE-L1386
           fdb   equFALSE-L1386
           fdb   EOF-L1386
           fdb   TRIM$-L1386

*****************************
L1388      fdb   BtoI-L1388
           fdb   INTCPY-L1388
           fdb   RCPVAR-L1388
           fdb   L13-L1388
           fdb   L14-L1388
           fdb   L15-L1388

*****************************
L1390      LDY   userSP         = table4
           LDD   exprBase
           STD   exprSP         clear expr.stack
           BRA   L724

L726       ASLB
           LDU   table2         -> L1386
           LDD   B,U
           JSR   D,U
L724       LDB   ,X+
           BMI   L726           next part
           CLRA  clear          carry
           LDA   ,Y
           RTS                  instruction done

* get size of DIM array
L2105      BSR   L728
L732       PSHS  PC,U
           LDU   table3         -> L1388
           ASLA
           LDD   A,U
           LEAU  D,U
           STU   2,S
           PULS  PC,U

* get size of PARAM array
L2106      BSR   L730
           BRA   L732

DIM        LEAS  2,S
           LDA   #$F2
           BRA   L734

PARAM      LEAS  2,S
           LDA   #$F6
           BRA   L736

L730       LDA   #$89
L736       STA   <$A3
           CLR   <$3B
           BRA   L738

L728       LDA   #$85
L734       STA   <$A3
           STA   <$3B
L738       LDD   ,X++
           ADDD  VarPtrba
           STD   <$D2
           LDU   <$D2           points to var. marker
           LDA   ,U
           ANDA  #$E0
           STA   <$CF
           EORA  #$80
           STA   <$CE
           LDA   ,U
           ANDA  #7
           LDB   -3,X
           SUBB  <$A3
           PSHS  d
           LDA   ,U
           ANDA  #$18
           LBEQ  L740
           LDD   1,U
           ADDD  vectorba
           TFR   D,U
           LDD   ,U
           STD   VarAddr
           LDA   1,S
           BNE   L742           first access
           LDA   #5
           STA   ,S
           LDD   2,U
           STD   fieldsiz
           clrd
           BRA   L744

L742       LEAY  -6,Y
           clrd
           STD   1,Y
           LEAU  4,U
           BRA   L746

L754       LDD   ,U             should be able to change to raw MULD?
           STD   1,Y
           LBSR  INTMUL
L746       LDD   7,Y
           SUBD  ArrBase        adjust to base 0
           CMPD  ,U++
           BLO   L750
           LDB   #$37           error 55
           LBRA  L356

L750       ADDD  1,Y
           STD   7,Y
           DEC   1,S
           BNE   L754           next element
           LDA   ,S
           BEQ   L756           bytes
           CMPA  #2
           BCS   L758           integers
           BEQ   L760           real numbers
           CMPA  #4
           BCS   L756           boolean
           LDD   ,U             string
           STD   fieldsiz
           BRA   L762

L756       LDD   7,Y            number of elements
           BRA   L764

L758       LDD   7,Y
           asld  x              2
L764       LEAY  $0C,Y
           BRA   L744

L760       LDD   #5
L762       STD   1,Y
           LBSR  INTMUL         x 5   (change to internal MULD)
           LDD   1,Y            array size
           LEAY  6,Y            Eat temp var
L744       TST   <$CE
           BNE   L766
           LDW   VarAddr
           ADDW  WSbase
           CMPW  <$40
           BCC   err56          too big!
           TFR   W,U
           CMPD  2,U
           BHI   err56          too big!
           ADDD  ,U
           BRA   L770

L766       ADDD  VarAddr
           TST   <$3B
           BNE   L772
L776       ADDD  1,Y
           LEAY  6,Y
           BRA   L770

L740       LDA   ,S
           CMPA  #4
           LDD   1,U
           BCS   L774
           ADDD  vectorba
           TFR   D,U
           LDQ   ,U
           STW   fieldsiz
L774       TST   <$3B
           BEQ   L776           PARAM
           ADDD  WSbase
           TFR   D,U
           TST   <$CE
           BNE   L778
           CMPD  <$40
           BCC   err56          too big!
           LDD   fieldsiz
           CMPD  2,U
           BLO   L780
           LDD   2,U
           STD   fieldsiz       reset fieldwidth
L780       LDU   ,U
           BRA   L778

L772       ADDD  WSbase
L770       TFR   D,U
L778       CLRA
           PULS  PC,d

err56      LDB   #$38
           LBRA  L356

BCPCNST    LEAU  ,X+
           BRA   BtoI

BCPVAR     LDD   ,X++
           ADDD  WSbase
           TFR   D,U
BtoI       LDB   ,U
           CLRA
           LEAY  -6,Y
           STD   1,Y
           LDA   #1
           STA   ,Y
           RTS

ICPCNST    LEAU  ,X++
           BRA   INTCPY

ICPVAR     LDD   ,X++
           ADDD  WSbase
           TFR   D,U
INTCPY     LDD   ,U
           LEAY  -6,Y
           STD   1,Y
           LDA   #1
           STA   ,Y
           RTS

NEGint     clrd
           SUBD  1,Y
           STD   1,Y
           RTS

INTADD     LDD   7,Y
           ADDD  1,Y
           LEAY  6,Y
           STD   1,Y
           RTS

INTSUB     LDD   7,Y
           SUBD  1,Y
           LEAY  6,Y
           STD   1,Y
           RTS

INTMUL     LDD   7,Y
           BEQ   L786
           muld  1,y
           stw   7,y
L786       LEAY  6,Y
           RTS

INTDIV     clre
           ldd   1,y
           bne   L801
           LDB   #$2D           error 45
           LBRA  L356

L801       cmpd  #1
           beq   L803
           bpl   L800
           come
           negd
           std   1,y
L800       cmpd  #2
           bne   L810
           LDD   7,Y            divide by 2
           BEQ   L803
           bpl   L802
           negd
           come
L802       ste   ,y
           clrw
           asrd
           rolw
           BRA   L806

L810       ldd   7,y
           bne   L812
L803       clrd                 always 0
           STD   9,Y
           LEAY  6,Y
           RTS

L812       bpl   L814
           come
           negd
L814       ste   ,y
           tfr   d,w
           clrd
           divq  1,y
           exg   d,w
L806       tst   ,y
           bpl   L820           answer = pos.
           negd
           comw
           incw
L820       STQ   7,Y
L822       LEAY  6,Y
           RTS

RCPCNST    LEAY  -6,Y
           LDB   ,X+
           LDA   #2
           STD   ,Y
           LDQ   ,X
           STQ   2,Y
           leax  4,x
           RTS

L2102      LDD   ,X++
           ADDD  WSbase
           TFR   D,U
RCPVAR     LEAY  -6,Y
           LDA   #2
           LDB   ,U
           STD   ,Y
           LDQ   1,U
           STQ   2,Y
           RTS

* invert sign of real number
NEGrl      fcb   $62,1,$25
*          eim   #1,5,y
           rts

RLSUB      fcb   $62,1,$25
*          eim   #1,5,y
RLADD      TST   2,Y
           BEQ   L824           = +0
           TST   8,Y
           BNE   L826
L830       LDQ   1,Y            = 0+x
           STQ   7,Y
           LDA   5,Y
           STA   $0B,Y
L824       LEAY  6,Y
           rts

* compare exponents
L826       LDA   7,Y
           SUBA  1,Y
           BVC   L828
           BPL   L830
           BRA   L824

L828       BMI   L832
           CMPA  #$1F
           BLE   L834
           BRA   L824           change insignif.

L832       CMPA  #$E1
           BLT   L830           change insignif.
           LDB   1,Y
           STB   7,Y
* calc. sign of answer
L834       LDB   $0B,Y
           ANDB  #1
           STB   ,Y
           EORB  5,Y
           ANDB  #1
           STB   1,Y            sign of answer
* clear original signs
*          aim   #$FE,11,y
*          aim   #$FE,5,y
           fcb   $62,$fe,$2b
           fcb   $62,$fe,$25
* calc. answer
           TSTA
           BEQ   L836
           tfr   y,w
           BPL   L838
           NEGA
           addw  #6
           BSR   L840
           TST   1,Y
           BEQ   L842
* substract mantissas
L848       SUBW  4,Y
           sbcd  2,Y
           BCC   L844
           comd
           comw
           addw  #1
           adcd  #0
L846       DEC   ,Y
           BRA   L844

L838       BSR   L840
           STQ   2,Y
L836       LDQ   8,Y
           TST   1,Y
           BNE   L848
* add mantissas
L842       ADDW  4,Y
           adcd  2,Y
           BCC   L844
           rord
           rorw
           INC   7,Y
L844       TSTA
           BMI   L850
           andcc #^Carry        clear carry
L854       DEC   7,Y            shift to proper form
           BVS   equ0
           rolw
           rold
           BPL   L854
L850       addw  #1
           adcd  #0
           BCC   L856
           RORA
           INC   7,Y
L856       STD   8,Y
           TFR   W,D
           lsrb
           lslb
           orb   ,y             add sign
L858       STD   $0A,Y
           LEAY  6,Y
           rts

L840       SUBA  #$10
           BCS   L860
           SUBA  #8
           BCS   L862
           PSHS  A
           CLRA
           LDB   2,W
           BRA   L864

L862       ADDA  #8
           PSHS  A
           LDD   2,W
L864       clrw
           TST   ,S
           BEQ   L866
           exg   d,w
           BRA   L872
L860       ADDA  #8
           BCC   L870
           PSHS  A
           CLRA
           LDB   2,W
           LDW   3,W
           TST   ,S
           BNE   L872
           BRA   L866

L870       ADDA  #8
           PSHS  A
           LDQ   2,W
L872       lsrd
           rorw
           DEC   ,S
           BNE   L872
L866       LEAS  1,S
           RTS

RLMUL      LDA   2,Y
           BPL   equ0
           LDA   8,Y
           BMI   L876
equ0       clrd
           clrw
           STQ   7,Y
           STA   $0B,Y
           LEAY  6,Y
           rts

L876       LDA   1,Y
           ADDA  7,Y
           BVC   L878
L916       BPL   equ0
           LDB   #$32           error 50
           lbra  L356

L878       STA   7,Y
           LDB   $0B,Y
           EORB  5,Y
           ANDB  #1
           STB   ,Y
           LDA   $0B,Y
           ANDA  #$FE
           STA   $0B,Y
           LDB   5,Y
           ANDB  #$FE
           STB   5,Y
           MUL
           clrw
           clr   extnum
           tfr   a,f
           LDA   $0B,Y
           LDB   4,Y
           MUL
           addr  d,w
           BCC   L880
           inc   extnum
L880       LDA   $0A,Y
           LDB   5,Y
           MUL
           addr  d,w
           BCC   L882
           inc   extnum
L882       tfr   e,f
           lde   extnum
           clr   extnum
           LDA   $0B,Y
           LDB   3,Y
           MUL
           addr  d,w
           BCC   L884
           inc   extnum
L884       LDA   $0A,Y
           LDB   4,Y
           MUL
           addr  d,w
           BCC   L886
           inc   extnum
L886       LDA   9,Y
           LDB   5,Y
           MUL
           addr  d,w
           BCC   L888
           inc   extnum
L888       tfr   e,f
           lde   extnum
           clr   extnum
           LDA   $0B,Y
           LDB   2,Y
           MUL
           addr  d,w
           BCC   L890
           inc   extnum
L890       LDA   $0A,Y
           LDB   3,Y
           MUL
           addr  d,w
           BCC   L892
           inc   extnum
L892       LDA   9,Y
           LDB   4,Y
           MUL
           addr  d,w
           BCC   L894
           inc   extnum
L894       LDA   8,Y
           LDB   5,Y
           MUL
           addr  d,w
           BCC   L896
           inc   extnum
L896       stf   11,y
           tfr   e,f
           lde   extnum
           clr   extnum
           LDA   $0A,Y
           LDB   2,Y
           MUL
           addr  d,w
           BCC   L898
           inc   extnum
L898       LDA   9,Y
           LDB   3,Y
           MUL
           addr  d,w
           BCC   L900
           inc   extnum
L900       LDA   8,Y
           LDB   4,Y
           MUL
           addr  d,w
           BCC   L902
           inc   extnum
L902       stf   10,y
           tfr   e,f
           lde   extnum
           clr   extnum
           LDA   9,Y
           LDB   2,Y
           MUL
           addr  d,w
           BCC   L904
           inc   extnum
L904       LDA   8,Y
           LDB   3,Y
           MUL
           addr  d,w
           BCC   L906
           inc   extnum
L906       LDA   8,Y
           LDB   2,Y
           MUL
           tfr   w,u
           tfr   e,f
           lde   extnum
           exg   d,u
           addr  u,w
           BMI   L908
           asl   11,y
           rol   10,y
           rolb
           rolw
           DEC   7,Y
           LBVS  L916
L908       tfr   b,a
           LDB   $0A,Y
           exg   d,w
           ADDW  #1
           adcd  #0
           BNE   L914
           rora
           INC   7,Y
L914       exg   d,w
           lsrb
           lslb
           ORB   ,Y
           STD   $0A,Y
           stw   8,y
           LEAY  6,Y
           rts

RLDIV      TST   2,Y
           BNE   L920
           LDB   #$2D           error 45
           lbra  L356

L920       TST   8,Y
           LBEQ  equ0
           LDA   7,Y
           SUBA  1,Y
           LBVS  L916
           STA   7,Y
           LDA   #$21
           LDB   5,Y
           EORB  $0B,Y
           ANDB  #1
           STD   ,Y
           ldq   2,y
           lsrd
           rorw
           stq   2,y
           LDQ   8,Y
           lsrd
           rorw
           CLR   $0B,Y
L932       SUBW  4,Y
           sbcd  2,y
           BEQ   L926
           BMI   L928
L936       ORCC  #1
L938       DEC   ,Y
           BEQ   L930
           ROL   $0B,Y
           ROL   $0A,Y
           ROL   9,Y
           ROL   8,Y
           andcc #^Carry
           rolw
           rold
           BCC   L932
           ADDW  4,Y
           adcd  2,y
           BEQ   L926
           BPL   L936
L928       ANDCC #$FE
           BRA   L938

L926       tstw
           BNE   L936
           LDB   ,Y
           DECB
           SUBB  #$10
           BLT   L940
           SUBB  #8
           BLT   L942
           STB   ,Y
           LDA   $0B,Y
           LDB   #$80
           andcc #^Carry
           BRA   L946

L942       ADDB  #8
           STB   ,Y
           LDW   #$8000
           LDD   $0A,Y
           andcc #^Carry
           BRA   L946

L940       ADDB  #8
           BLT   L948
           STB   ,Y
           LDQ   9,Y
           LDF   #$80
           andcc #^Carry
           BRA   L946

L948       ADDB  #7
           STB   ,Y
           LDQ   8,Y
           ORCC  #1
L950       rolw
           rold
L946       DEC   ,Y
           BPL   L950
           TSTA
           BRA   L952

L930       LDQ   8,Y
L952       BMI   L954
           rolw
           rold
           DEC   7,Y
           LBVS  equ0
L954       addw  #1
           adcd  #0
           BCC   L956
           RORA
           INC   7,Y
           LBVS  equ0
L956       STD   8,Y
           TFR   W,D
           lsrb
           lslb
           ORB   1,Y
           STD   $0A,Y
           INC   7,Y
           LBVS  L916
L958       LEAY  6,Y
           rts

POWERS     LDD   7,Y
           BEQ   L958
           LDW   1,Y
           BNE   L960
           LEAY  6,Y
L1152      LDD   #$0180
           clrw
           STQ   1,Y
           ste   5,y
           rts

L960       STD   1,Y
           STW   7,Y
           LDD   9,Y
           LDW   3,Y
           STD   3,Y
           STW   9,Y
           LDA   $0B,Y
           LDB   5,Y
           STA   5,Y
           STB   $0B,Y
           LBSR  LOG            = ln
           LBSR  RLMUL
           LBRA  EXP

BlCPVAR    LDD   ,X++
           ADDD  WSbase
           TFR   D,U
L13        LDB   ,U
           CLRA
           LEAY  -6,Y
           STD   1,Y
           LDA   #3
           STA   ,Y
           RTS

LANDB      LDB   8,Y
           ANDB  2,Y
           BRA   L968

LORB       LDB   8,Y
           ORB   2,Y
           BRA   L968

LXORB      LDB   8,Y
           EORB  2,Y
L968       LEAY  6,Y
           STD   1,Y
           RTS

LNOTB      COM   2,Y
           RTS

StrCMP     PSHS  Y,X
           LDX   1,Y
           LDY   7,Y
           STY   exprSP
L972       LDA   ,Y+
           CMPA  ,X+
           BNE   L970
           CMPA  #$FF
           BNE   L972
L970       INCA
           INC   -1,X
           CMPA  -1,X
           PULS  PC,Y,X

Slo        BSR   StrCMP
           BLO   L976
           BRA   L978

Sle        BSR   StrCMP
           BLS   L976
           BRA   L978

Seq        BSR   StrCMP
           BEQ   L976
           BRA   L978

Sne        BSR   StrCMP
           BNE   L976
           BRA   L978

Sge        BSR   StrCMP
           BHS   L976
           BRA   L978

Sgt        BSR   StrCMP
           BHI   L976
           BRA   L978

Ilo        LDD   7,Y
           SUBD  1,Y
           BLT   L976
           BRA   L978

Ile        LDD   7,Y
           SUBD  1,Y
           BLE   L976
           BRA   L978

Ine        LDD   7,Y
           SUBD  1,Y
           BNE   L976
           BRA   L978

Ieq        LDD   7,Y
           SUBD  1,Y
           BEQ   L976
           BRA   L978

Ige        LDD   7,Y
           SUBD  1,Y
           BGE   L976
           BRA   L978

Igt        LDD   7,Y
           SUBD  1,Y
           BLE   L978
L976       LDB   #$FF
           BRA   L980

L978       clrb
L980       CLRA
           LEAY  6,Y
           STD   1,Y
           LDA   #3
           STA   ,Y
           RTS

Beq        LDB   8,Y
           CMPB  2,Y
           BEQ   L976
           BRA   L978

Bne        LDB   8,Y
           CMPB  2,Y
           BNE   L976
           BRA   L978

Rlo        BSR   RLCMP
           BLO   L976
           BRA   L978

Rle        BSR   RLCMP
           BLS   L976
           BRA   L978

Rne        BSR   RLCMP
           BNE   L976
           BRA   L978

Req        BSR   RLCMP
           BEQ   L976
           BRA   L978

Rge        BSR   RLCMP
           BHS   L976
           BRA   L978

Rgt        BSR   RLCMP
           BHI   L976
           BRA   L978

RLCMP      PSHS  Y
           LDA   $0B,Y          Get sign of 2nd #
           ANDA  #1
           ldb   5,y            Get sign of 1st #
           andb  #1
           cmpr  a,b            Same sign?
           bne   L996           No, skip ahead
L988       LEAU  6,Y            signs are the same
           tsta
           BEQ   L994           positive numbers
           EXG   U,Y            invert them
L994       LDQ   1,U
           CMPD  1,Y
           bne   L993
           CMPW  3,Y
           BNE   L996
           LDA   5,U
           CMPA  5,Y
L996       PULS  PC,Y

L993       pshs  cc
           eora  1,y
           bpl   L992           no/both fractions
           tstb
           beq   L992           n1 = 0
           tst   2,y
           beq   L992           n2 = 0
*          eim   #1,0,s
           fcb   $65,1,$60
L992       puls  pc,y,cc

* copy string
SCPCNST    CLRB
           LDU   exprSP
           LEAY  -6,Y
           STU   1,Y            starting address
           STY   SStop
L1004      cmpr  y,u
           BCC   err47
           LDA   ,X+
           STA   ,U+
           CMPA  #$FF
           BEQ   L1001
           INCB
           BNE   L1004
           LDA   #$FF
           STA   ,U+
L1001      clra
           std   3,y            size of string
L1002      STU   exprSP
           LDA   #4
           STA   ,Y             type: string
           RTS

err47      LDB   #$2F
           LBRA  L356

L14        tfr   u,d
           ldw   fieldsiz
           bra   L1007
* copy string to expression stack
SCPVAR     LDD   ,X++
           ADDD  vectorba
           TFR   D,U            array vector
           LDQ   ,U             address,size target
           ADDD  WSbase
           stw   fieldsiz
L1007      ldu   exprSP
           leay  -6,y
           stu   1,y            starting address
           sty   SStop
           cmpd  BUPaddr
           beq   L1009
           addr  w,u
           cmpr  y,u
           bhs   err47          too big
           ldu   1,y
           pshs  x
           tfr   d,x            origin
           stx   BUPaddr
L1003      lda   ,x+
           sta   ,u+
           cmpa  #$FF
           beq   L1005
           decw
           bne   L1003
           lda   #$FF
           sta   ,u+
L1005      comw  negate         left-over
           incw
           addw  fieldsiz
           stw   3,y            size of string
           stw   BUPsize
           puls  x
           bra   L1002

L1009      ldw   BUPsize
           stw   3,y
           tfm   d+,u+
           lda   #$FF
           sta   ,u+
           bra   L1002

STRconc    LDU   1,Y
           ldw   3,y
           incw
           tfr   u,d
           decd
           tfm   u+,d+
           STD   exprSP
           ldd   3,y
           leay  6,y
           addd  3,y
           std   3,y            length new string
           RTS

L15        LDD   fieldsiz
           LEAY  -6,Y
           STD   3,Y
           STU   1,Y
           LDA   #5
           STA   ,Y
           RTS

FLOAT      clrd
           STD   4,Y
           LDD   1,Y
           BNE   L1012
           STB   3,Y
           LDA   #2
           STA   ,Y
           RTS

L1012      LDW   #$0210
           TSTA
           BPL   L1014
           negd
           INC   5,Y
L1014      TSTA
           BNE   L1016
           LDW   #$0208
           EXG   A,B
L1016      TSTA
           BMI   L1018
L1020      decw
           asld
           BPL   L1020
L1018      STD   2,Y
           STW   ,Y
           RTS

float2     LEAY  6,Y
           BSR   FLOAT
           LEAY  -6,Y
           RTS

FIX        ldw   1,y
           ldd   4,y
           tste
           BGT   L1024
           BMI   L1026
           tstf
           BPL   L1026
           LDW   #1
           BRA   L1028

L1026      clrw
           BRA   L1030

L1024      SUBE  #$10
           BHI   err52
           BNE   L1034
           LDW   2,Y
           rorb
           BCC   L1030
           CMPW  #$8000
           BNE   err52
           tsta
           BPL   L1030
           BRA   err52

L1034      pshs  b
           tfr   e,b
           ldw   2,y
           cmpb  #$F8
           BHI   L1036
           tfr   f,a
           tfr   e,f
           clre
           ADDB  #8
           BEQ   L1038
L1036      lsrw
           rora
           INCB
           BNE   L1036
L1038      puls  b
           tsta
           BPL   L1028
           incw
           BVC   L1028
err52      LDB   #$34
           LBRA  L356

L1028      RORB
           BCC   L1030
           comw
           incw
L1030      STW   1,Y
           std   4,y
           LDA   #1
           STA   ,Y
           RTS

fixN1      LEAY  6,Y
           BSR   FIX
           LEAY  -6,Y
           RTS

fixN2      LEAY  $0C,Y
           BSR   FIX
           LEAY  -$0C,Y
           RTS

ABSrl      fcb   $62,$fe,$25
*          AIM   #$FE,5,y
           RTS

ABSint     LDD   1,Y
           BPL   L1042
           NEGD
           STD   1,Y
L1042      RTS

PEEK       CLRA
           LDB   [1,Y]
           STD   1,Y
           RTS

SGNrl      LDA   2,Y
           BEQ   L1044
           LDA   5,Y
           ANDA  #1
           BNE   L1046
L1050      LDB   #1
           BRA   L1048

SGNint     LDD   1,Y
           BMI   L1046
           BNE   L1050
L1044      CLRB
           BRA   L1048

L1046      LDB   #$FF
L1048      SEX
           BRA   L1052

ERR        LDB   errcode
           CLR   errcode
L1054      CLRA
           LEAY  -6,Y
L1052      STD   1,Y
           LDA   #1
           STA   ,Y
L1058      RTS

POS        LDB   charcoun
           BRA   L1054

SQRT       LDB   5,Y
           ASRB
           LBCS  err67
           LDB   #$1F
           STB   <$6E
           LDD   1,Y
           BEQ   L1058
           INCA
           ASRA
           STA   1,Y
           LDQ   2,Y
           BCS   L1060
           lsrd
           rorw
L1060      STQ   -4,Y
           clrd
           clrw
           STQ   2,Y
           STQ   -8,Y
           BRA   L1064

L1070      ORCC  #1
           ldq   2,y
           rolw
           rold
           DEC   <$6E
           BEQ   L1066
           stq   2,y
           BSR   L1068
L1064      LDB   -4,Y
           SUBB  #$40
           STB   -4,Y
           LDD   -6,Y
           sbcd  4,Y
           STD   -6,Y
           LDD   -8,Y
           sbcd  2,Y
           STD   -8,Y
           BPL   L1070
L1072      ANDCC #$FE
           ldq   2,y
           rolw
           rold
           DEC   <$6E
           BEQ   L1066
           stq   2,y
           BSR   L1068
           LDB   -4,Y
           ADDB  #$C0
           STB   -4,Y
           LDD   -6,Y
           adcd  4,Y
           STD   -6,Y
           LDD   -8,Y
           adcd  2,Y
           STD   -8,Y
           BMI   L1072
           BRA   L1070

L1066      andcc #^Carry
           BRA   L1074

L1076      DEC   1,Y
           LBVS  equ0
L1074      rolw
           rold
           BPL   L1076
           STQ   2,Y
           RTS

L1068      ldq   -8,y
           ASL   -1,Y
           ROL   -2,Y
           ROL   -3,Y
           ROL   -4,Y
           rolw
           rold
           asl   -1,y
           rol   -2,y
           rol   -3,y
           rol   -4,y
           rolw
           rold
           stq   -8,y
           RTS

MODint     LBSR  INTDIV
           LDD   3,Y
           STD   1,Y
           RTS

MODrl      LEAU  -$0C,Y
           ldw   #12
           tfm   y+,u+
           LEAY  -$0C,U
           LBSR  RLDIV
           BSR   INTrl
           LBSR  RLMUL
           LBRA  RLSUB

INTrl      LDA   1,Y
           BGT   L1090
           clrd
           clrw
           STQ   1,Y
           STB   5,Y
L1092      RTS

L1090      CMPA  #$1F
           BCC   L1092
           LEAU  6,Y
           LDB   -1,U
           ANDB  #1
           PSHS  U,B
           LEAU  1,Y
L1094      LEAU  1,U
           SUBA  #8
           BCC   L1094
           BEQ   L1096
           LDB   #$FF
L1098      ASLB
           INCA
           BNE   L1098
           ANDB  ,U
           STB   ,U+
           BRA   L1100

L1096      LEAU  1,U
L1102      STA   ,U+
L1100      CMPU  1,S
           BNE   L1102
           PULS  U,B
           ORB   5,Y
           STB   5,Y
           RTS

SQint      LEAY  -6,Y       If embedding, skip LEAY -6,y
           LDD   7,Y        Get # to square
           STD   1,Y        Multiply it by itself (could embed MULD)
           LBRA  INTMUL

SQrl       LEAY  -6,Y
           LDQ   8,Y
           STQ   2,Y
           LDD   6,Y
           STD   ,Y
           LBRA  RLMUL

VAL        LDD   Sstack
           LDU   Spointer
           PSHS  U,D
           LDD   1,Y
           STD   Sstack
           STD   Spointer
           STD   exprSP
           LEAY  6,Y
           LBSR  L2008
           PULS  U,D
           STD   Sstack
           STU   Spointer
           LBCS  err67
           RTS

ADDR       LBSR  L724
           LEAY  -6,Y
           STU   1,Y
L1112      LDA   #1
           STA   ,Y
           LEAX  1,X
           RTS

* Table of var type sizes
L1108      fcb   1,2,5,1

SIZE       LBSR  L724
           leay  -6,y
           CMPA  #4
           BCC   L1106
           LEAU  <L1108,PC
           LDB   A,U
           CLRA
           BRA   L1110

L1106      LDD   fieldsiz
L1110      STD   1,Y
           BRA   L1112

equTRUE    LDD   #$FF
           BRA   L1114

equFALSE   clrd
L1114      LEAY  -6,Y
           STD   1,Y
           LDA   #3
           STA   ,Y
           RTS

LNOTI      COM   1,Y
           COM   2,Y
           RTS

LANDI      LDD   1,Y
           ANDD  7,Y
           BRA   L1116

LXORI      LDD   1,Y
           EORD  7,Y
           BRA   L1116

LORI       LDD   1,Y
           ORD   7,Y
L1116      STD   7,Y
           LEAY  6,Y
           RTS

L1118      fcb   255,222,91,216,170
LOG10      BSR   LOG
           LEAU  <L1118,PC
           LBSR  RCPVAR
           LBRA  RLMUL

LOG        PSHS  X
           LDB   5,Y
           ASRB
           LBCS  err67
           LDD   1,Y
           LBEQ  err67
           PSHS  A
           LDB   #1
           STB   1,Y
           LEAY  <-$1A,Y
           LEAX  <$1B,Y
           LEAU  ,Y
           LBSR  cprXU
           LBSR  L1124
           clrd
           clrw
           STQ   <$14,Y
           STA   <$18,Y
           LEAX  L1126,PC
           STX   <$19,Y
           LBSR  L1128
           LEAX  <$14,Y
           LEAU  <$1B,Y
           LBSR  cprXU
           LBSR  L1130
           LEAY  <$1A,Y
           LDB   #2
           STB   ,Y
*          oim   #1,5,y
           fcb   $61,1,$25
           PULS  B
           BSR   L1132
           PULS  X
           LBRA  RLADD

L1138      fcb   0,177,114,23,248

L1132      SEX
           BPL   L1136
           NEGB
L1136      ANDA  #1
           PSHS  D
           LEAU  <L1138,PC
           LBSR  RCPVAR
           LDB   5,Y
           LDA   1,S
           CMPA  #1
           BEQ   L1140
           MUL
           STB   5,Y
           LDB   4,Y
           STA   4,Y
           LDA   1,S
           MUL
           ADDB  4,Y
           ADCA  #0
           STB   4,Y
           LDB   3,Y
           STA   3,Y
           LDA   1,S
           MUL
           ADDB  3,Y
           ADCA  #0
           STB   3,Y
           LDB   2,Y
           STA   2,Y
           LDA   1,S
           MUL
           ADDB  2,Y
           ADCA  #0
           BEQ   L1142
           ldw   3,y
L1144      INC   1,Y
           lsrd
           rorw
           ROR   5,Y
           TSTA
           BNE   L1144
           stw   3,y
L1142      STB   2,Y
           LDB   5,Y
L1140      ANDB  #$FE
           ORB   ,S
           STB   5,Y
           PULS  PC,D

EXP        PSHS  X
           LDB   1,Y
           BEQ   L1146
           CMPB  #7
           BLE   L1148
           LDB   5,Y
           RORB
           RORB
           EORB  #$80
           LBRA  L1150

L1148      CMPB  #$E4
           LBLE  L1152
           TSTB
           BPL   L1154
L1146      CLR   ,-S
           LDB   5,Y
           ANDB  #1
           BEQ   L1156
           BRA   L1158

L1154      LDA   #$71
           MUL
           ADDA  1,Y
           LDB   5,Y
           ANDB  #1
           PSHS  B,A
           EORB  5,Y
           STB   5,Y
           LDB   ,S
L1162      LBSR  L1132
           LBSR  RLSUB
           LDB   1,Y
           BLE   L1160
           ADDB  ,S
           STB   ,S
           LDB   1,Y
           BRA   L1162

L1160      PULS  D
           PSHS  A
           TSTB
           BEQ   L1156
           NEGA
           STA   ,S
           ORB   5,Y
           STB   5,Y
L1158      LEAU  L1138,PC
           LBSR  RCPVAR
           LBSR  RLADD
           DEC   ,S
           LDB   5,Y
           ANDB  #1
           BNE   L1158
L1156      LEAY  <-$1A,Y
           LEAX  <$1B,Y
           LEAU  <$14,Y
           LBSR  cprXU
           LBSR  L1124
           LDD   #$1000
           clrw
           STQ   ,Y
           STB   4,Y
           LEAX  L1164,PC
           STX   <$19,Y
           BSR   L1128
           LEAX  ,Y
           LEAU  <$1B,Y
           LBSR  cprXU
           LBSR  L1130
           LEAY  <$1A,Y
           PULS  B
           ADDB  1,Y
           BVS   L1150
           LDA   #2
           STD   ,Y
           PULS  PC,X

L1128      LDA   #1
           STA   <$9A
           LEAX  L1166,PC
           STX   <$95
           LEAX  <$5F,X
           STX   <$97
           LBRA  L1168

L1150      LEAY  -6,Y
           puls  x
           lbra  L916           0 or ovf

L2125      PSHS  X
           BSR   L1170
           LDD   1,Y
           LBEQ  L1172
           CMPD  #$0180
           BGT   L1174          error 67
           BNE   L1176
           LDD   3,Y
           BNE   L1174          error 67
           LDA   5,Y
           LBEQ  L1178
L1174      LBRA  err67

L1176      LBSR  L1180
           LEAY  <-$14,Y
           LEAX  <$15,Y
           LEAU  ,Y
           LBSR  cprXU
           LBSR  L1124
           LEAX  <$1B,Y
           LBRA  L1182

L1170      LDB   5,Y
           ANDB  #1
           STB   <$6D
           EORB  5,Y
           STB   5,Y
           RTS

L2126      LEAU  <L1184,PC
           PSHS  U,X
           BSR   L1170
           LDD   1,Y
           LBEQ  L1178
           CMPD  #$0180
           BGT   L1174          error 67
           BNE   L1186
           LDD   3,Y
           BNE   L1174          error 67
           LDA   5,Y
           BNE   L1174          error 67
           LDA   <$6D
           BNE   L1188
           CLRB
           STD   1,Y
           PULS  PC,U,X

L1188      LEAY  6,Y
           PULS  U,X
           LBRA  PI

L1186      BSR   L1180
           LEAY  <-$14,Y
           LEAX  <$1B,Y
           LEAU  ,Y
           LBSR  cprXU
           LBSR  L1124
           LEAX  <$15,Y
           LBRA  L1182

L1184      LDA   5,Y
           BITA  #1
           BEQ   L1192
           LDU   WSbase
           TST   1,U
           BEQ   L1194
           LEAU  <L1196,PC
           LBSR  RCPVAR
           BRA   L1198

L1194      LBSR  PI
L1198      LBRA  RLADD

L1192      RTS

L1196      fcb   8,180,0,0,0

L1180      LDA   <$6D
           PSHS  A
           LEAY  -18,Y
           LDD   #$0201
           STD   $0C,Y
           LDA   #$80
           CLRB
           STD   $0E,Y
           CLRA
           STD   $10,Y
           LDQ   <$12,Y
           STQ   ,Y
           STQ   6,Y
           LDD   <$16,Y
           STD   4,Y
           STD   $0A,Y
           LBSR  RLMUL
           LBSR  RLSUB
           LBSR  SQRT
           PULS  A
           STA   <$6D
           RTS

L2127      PSHS  X
           LBSR  L1170
           LDB   1,Y
           CMPB  #$18
           BLT   L1204
L1178      LEAY  6,Y
           LBSR  PI
           DEC   1,Y
           BRA   L1206

L1204      LEAY  <-$1A,Y
           LDD   #$1000
           clrw
           STQ   ,Y
           STB   4,Y
           lda   ,y
           LDB   <$1B,Y
           ldw   1,y
           BRA   L1208

L1210      ASRA
           rorw
           ROR   3,Y
           ROR   4,Y
           DECB
L1208      CMPB  #2
           BGT   L1210
           sta   ,y
           stw   1,y
           STB   <$1B,Y
           LEAX  <$1B,Y
L1182      LEAU  $0A,Y
           LBSR  cprXU
           LBSR  L1124
           clrd
           clrw
           STQ   <$14,Y
           STA   <$18,Y
           LEAX  L1212,PC
           STX   <$19,Y
           LBSR  L1214
           LEAX  <$14,Y
           LEAU  <$1B,Y
           LBSR  cprXU
           LBSR  L1130
           LEAY  <$1A,Y
L1206      LDA   5,Y
           ORA   <$6D
           STA   5,Y
           LDU   WSbase
           TST   1,U
           BEQ   L1172
           LEAU  L1216,PC
           LBSR  RCPVAR
           LBSR  RLMUL
           BRA   L1172

L2122      PSHS  X
           LBSR  L1218
           LEAX  $0A,Y
           BSR   L1220
           LDA   5,Y
L1230      EORA  <$9C
L1224      STA   5,Y
L1172      LDA   #2
           STA   ,Y
           PULS  PC,X

L1220      LEAU  <$1B,Y
           LBSR  cprXU
           LBSR  L1130
           LEAY  <$14,Y
           LEAX  L1222,PC
           LEAU  1,Y
           LBSR  cprXU
           LBRA  RLMUL

L2123      PSHS  X
           BSR   L1218
           LEAX  ,Y
           BSR   L1220
           LDA   5,Y
           EORA  <$9B
           BRA   L1224

L2124      PSHS  X
           BSR   L1218
           LEAX  $0A,Y
           LEAU  <$1B,Y
           LBSR  cprXU
           LBSR  L1130
           LEAX  ,Y
           LEAY  <$14,Y
           LEAU  1,Y
           LBSR  cprXU
           LBSR  L1130
           LDD   1,Y
           BNE   L1226
           LEAY  6,Y
           LDD   #$7FFF
L1232      STD   1,Y
           LDA   #$FF
           STD   3,Y
           DECA
           BRA   L1228

L1226      LBSR  RLDIV
           LDA   5,Y
L1228      EORA  <$9B
           BRA   L1230

L1231      fcb   2,201,15,218,162

L1238      fcb   251,142,250,53,18

L1216      fcb   6,229,46,224,212

PI         LEAU  <L1231,PC
           LBRA  RCPVAR

L1218      LDU   WSbase
           TST   1,U
           BEQ   L1236          radians
           LEAU  <L1238,PC
           LBSR  RCPVAR
           LBSR  RLMUL          -> degrees
L1236      CLR   <$9B
           LDB   5,Y
           ANDB  #1
           STB   <$9C
           EORB  5,Y
           STB   5,Y
           BSR   PI
           INC   1,Y
           LBSR  RLCMP
           BLT   L1240
           LBSR  MODrl
           BSR   PI
           BRA   L1244

L1240      DEC   1,Y
L1244      LBSR  RLCMP
           BLT   L1246
           INC   <$9B
*           eim   #1,$9C
           fcb    5,1,$9c
           LBSR  RLSUB
           BSR   PI
L1246      DEC   1,Y
           LBSR  RLCMP
           BLE   L1248
*           eim   #1,$9B
           fcb    5,1,$9c
           INC   1,Y
*           oim   #1,11,y
           fcb    $61,1,$2b
           LBSR  RLADD
           LEAY  -6,Y
L1248      LEAY  -$14,Y
           LEAX  L1250,PC
           STX   <$19,Y
           LEAX  <$1B,Y
           LEAU  <$14,Y
           BSR   cprXU
           LBSR  L1124
           LDD   #$1000
           clrw
           STQ   ,Y
           CLRA
           STA   4,Y
           STQ   $0A,Y
           STA   $0E,Y
L1214      LEAX  L1252,PC
           STX   <$95
           LEAX  <$41,X
           STX   <$97
           CLR   <$9A
L1168      LDB   #$25
           STB   <$99
           CLR   <$9D
L1264      LEAU  <$1B,Y
           LDX   <$95
           CMPX  <$97
           BCC   L1254
           BSR   cprXU
           LEAX  5,X
           STX   <$95
           BRA   L1256

L1254      ldq   ,u
           asrd
           rorw
           stq   ,u
           ror   4,u
L1256      LEAX  ,Y
           LEAU  5,Y
           BSR   L1260
           TST   <$9A
           BNE   L1262
           LEAX  $0A,Y
           LEAU  $0F,Y
           BSR   L1260
L1262      JSR   [$19,Y]
           INC   <$9D
           DEC   <$99
           BNE   L1264
           RTS

cprXU      LDQ   1,X
           STQ   1,U
           LDA   ,X
           STA   ,U
           rts

L1260      LDB   ,X
           SEX
           LDB   <$9D
           LSRB
           LSRB
           LSRB
           BCC   L1266
           INCB
L1266      PSHS  B
           BEQ   L1268
L1270      STA   ,U+
           DECB
           BNE   L1270
L1268      LDB   #5
           SUBB  ,S+
           BEQ   L1272
L1274      LDA   ,X+
           STA   ,U+
           DECB
           BNE   L1274
L1272      LEAU  -5,U
           LDB   <$9D
           ANDB  #7
           BEQ   L1276
           ldw   1,u
           CMPB  #4
           BCS   L1258
           SUBB  #8
           LDA   ,X
L1278      ASLA
           ROL   4,U
           ROL   3,U
           rolw
           ROL   ,U
           INCB
           BNE   L1278
           stw   1,u
           RTS

L1258      ASR   ,U
           rorw
           ROR   3,U
           ROR   4,U
           DECB
           BNE   L1258
           stw   1,u
L1276      RTS

L1212      LDA   $0A,Y
           EORA  ,Y
           COMA
           BRA   L1280

L1250      LDA   <$14,Y
L1280      TSTA
           BPL   L1282
           LEAX  ,Y
           LEAU  $0F,Y
           BSR   L1284
           LEAX  $0A,Y
           LEAU  5,Y
           BSR   L1286
           LEAX  <$14,Y
           LEAU  <$1B,Y
           BRA   L1284

L1282      LEAX  ,Y
           LEAU  $0F,Y
           BSR   L1286
           LEAX  $0A,Y
           LEAU  5,Y
           BSR   L1284
           LEAX  <$14,Y
           LEAU  <$1B,Y
           BRA   L1286

L1164      LEAX  <$14,Y
           LEAU  <$1B,Y
           BSR   L1286
           BMI   L1284
           BNE   L1288
           LDD   1,X
           BNE   L1288
           LDD   3,X
           BNE   L1288
           LDB   #1
           STB   <$99
L1288      LEAX  ,Y
           LEAU  5,Y
           BRA   L1284

L1126      LEAX  ,Y
           LEAU  5,Y
           BSR   L1284
           CMPA  #$20
           BCC   L1286
           LEAX  <$14,Y
           LEAU  <$1B,Y
L1284      ldq   1,x
           addw  3,u
           adcd  1,u
           STQ   1,X
           LDA   ,X
           ADCA  ,U
           STA   ,X
           RTS

L1286      ldq   1,x
           subw  3,u
           sbcd  1,u
           STQ   1,X
           LDA   ,X
           SBCA  ,U
           STA   ,X
           RTS

L1124      LDB   ,U
           CLR   ,U
           clra
           ldw   1,u
           ADDB  #4
           BGE   L1294
           NEGB
           LBRA  L1258

L1296      ASL   4,U
           ROL   3,U
           rolw
           rola
           DECB
L1294      BNE   L1296
           sta   ,u
           stw   1,u
           RTS

L1130      LDA   ,U
           BPL   L1298
           clrd
           clrw
           STQ   ,U
           STA   4,U
           RTS

L1298      ldq   ,u
           beq   L1304
           pshs  x
           ldx   #4
L1302      leax  -1,x
           asl   4,u
           rolw
           rold
           BPL   L1302
L1300      std   1,u
           exg   d,w
           tfr   x,w
           stf   ,u
           puls  x
           addd  #1
           ANDB  #$FE
           STD   3,U
           BCC   L1304
           INC   2,U
           BNE   L1304
           INC   1,U
           BNE   L1304
           ROR   1,U
           INC   ,U
L1304      RTS

L1252      fcb   12,144,253,170,34
           fcb   7,107,25,193,88
           fcb   3,235,110,191,38
           fcb   1,253,91,169,171
           fcb   0,255,170,221,185
           fcb   0,127,245,86,239
           fcb   0,63,254,170,183
           fcb   0,31,255,213,86
           fcb   0,15,255,250,171
           fcb   0,7,255,255,85
           fcb   0,3,255,255,235
           fcb   0,1,255,255,253
           fcb   0,1,0,0,0
L1222      fcb   0,155,116,237,168
L1166      fcb   11,23,33,127,126
           fcb   6,124,200,251,48
           fcb   3,145,254,248,243
           fcb   1,226,112,118,227
           fcb   0,248,81,134,1
           fcb   0,126,10,108,58
           fcb   0,63,129,81,98
           fcb   0,31,224,42,107
           fcb   0,15,248,5,81
           fcb   0,7,254,0,170
           fcb   0,3,255,128,21
           fcb   0,1,255,224,3
           fcb   0,0,255,248,0
           fcb   0,0,127,254,0
           fcb   0,0,63,255,128
           fcb   0,0,31,255,224
           fcb   0,0,15,255,248
           fcb   0,0,7,255,254
           fcb   0,0,4,0,0
L1382      fcb   14,18,20,162,187,64
           fcb   230,45,54,25,98,233
           fcb   0,16,63,0,57

RND        clrw
           STW   <$4C
           clr   ,-s
           LDA   2,Y
           BEQ   L1312
           LDB   5,Y
           BITB  #1
           BNE   L1314
           COM   ,S
           BRA   L1312

L1314      ADDB  #$FE
           ADDB  1,Y
           LDA   4,Y
           STD   <$52
           LDD   2,Y
           STD   <$50
L1312      LDA   <$53
           LDB   <$57
           MUL
           STD   <$4E
           tfr   a,f
           LDA   <$52
           LDB   <$57
           MUL
           addr  d,w
           BCC   L1316
           INC   <$4C
L1316      LDA   <$53
           LDB   <$56
           MUL
           addr  d,w
           BCC   L1318
           INC   <$4C
L1318      stw   <$4D
           ldw   <$4C
           LDA   <$51
           LDB   <$57
           MUL
           addr  d,w
           LDA   <$52
           LDB   <$56
           MUL
           addr  d,w
           LDA   <$53
           LDB   <$55
           MUL
           addr  d,w
           LDA   <$50
           LDB   <$57
           MUL
           addr  b,e
           LDA   <$51
           LDB   <$56
           MUL
           addr  b,e
           LDA   <$52
           LDB   <$55
           MUL
           addr  b,e
           LDA   <$53
           LDB   <$54
           MUL
           addr  b,e
           LDD   <$4E
           ADDD  <$5A
           exg   d,w
           adcd  <$58
           STQ   <$50
           TST   ,S+
           BNE   L1320
L1326      CLR   1,Y
           sta   2,y
           LDA   #$1F
           PSHS  A
           lda   2,y
           BMI   L1322
           andcc #^Carry
L1324      DEC   ,S
           BEQ   L1322
           DEC   1,Y
           rolw
           rold
           BPL   L1324
L1322      STQ   2,Y
*          aim   #$FE,5,y
           fcb   $62,$fe,$25
           PULS  PC,B

L1320      leay  -6,y
           rorw
           clr   ,y
           rolw  sign           now +
           BSR   L1326
           LBRA  RLMUL

LEN        LDQ   1,Y
           STD   exprSP
L1328      STW   1,Y
           LDA   #1
           STA   ,Y
           RTS

ASC        LDD   1,Y
           STD   exprSP
           LDF   [1,Y]
           CLRE
           BRA   L1328

CHR$       LDD   1,Y
           TSTA
           LBNE  err67
           LDU   exprSP
           STU   1,Y
           STB   ,U+
           LBSR  L1366
           ldd   #1
           std   3,y
           STY   SStop
           cmpr  y,u
           LBCC  err47
           RTS

LEFT$      LDD   1,Y
           BLE   isNull
           ADDD  7,Y
           TFR   D,U            address new end
           CMPD  exprSP
           BCC   L1334
           BSR   L1336          shorten current string
           ldd   1,y
           std   9,y
L1334      LEAY  6,Y
           RTS

isNull     LEAY  6,Y
           LDU   1,Y
           clrd
           std   3,y
           BRA   L1336

RIGHT$     LDW   1,Y
           BLE   isNull
           LDD   exprSP
           subr  w,d
           decd  new            starting address
           CMPD  7,Y            current start address
           BLS   L1338
           stw   9,y
           incw  terminate      also
           LDU   7,Y
           tfm   d+,u+
           STU   exprSP
L1338      LEAY  6,Y
           rts

MID$       LDD   1,Y            size of piece
           BLE   L1342
           LDD   7,Y            it's starting offset
           BGT   L1344
L1342      LDD   1,Y            = LEFT$
           LEAY  6,Y
           STD   1,Y
           BRA   LEFT$

L1344      decd
           BEQ   L1342
           ADDD  $0D,Y          start address piece
           CMPD  exprSP
           BCS   L1348          piece exists
           LEAY  6,Y
           BRA   isNull

L1348      clrw
           ldf   2,y
           LEAY  $0C,Y
           stw   3,y
           ldu   1,Y
           tfm   d+,u+
           bra   L1337

TRIM$      LDU   exprSP
           ldw   3,y
           incw                 adjust for loop struct.
           LEAU  -1,U
L1354      decw
           BEQ   L1336
           LDA   ,-U
           CMPA  #$20
           BEQ   L1354
           LEAU  1,U
L1336      stw   3,y
L1337      LDA   #$FF
           STA   ,U+
           STU   exprSP
           RTS

SUBSTR     PSHS  Y,X
           LDW   exprSP
           SUBW  1,Y
           ADDW  7,Y
           incw
           LDX   7,Y
           LDY   1,Y
           bra   L1356

* compare strings *
L202       PSHS  Y,X
L200       LDA   ,X+
           CMPA  #$FF
           BEQ   L198
           CMPA  ,Y+
           BEQ   L200
           PULS  Y,X
           LEAY  1,Y
L1356      CMPR  W,Y
           BLS   L202
           clrd  no             match
           BRA   L1360

L198       PULS  Y,X
           TFR   Y,D
           LDX   2,S
           SUBD  1,X
           incd                 starting offset
L1360      PULS  Y,X
           LEAY  6,Y
           STD   1,Y
           LDA   #1
           STA   ,Y
           RTS

STR$int    LDB   #2
           BRA   L1362

STR$rl     LDB   #3
L1362      LDA   charcoun
           LDU   Spointer
           PSHS  U,X,A
           LBSR  L46
           BCS   err67
           LDX   3,S
           ldu   exprSP
           leay  -6,y
           stu   1,y
           sty   SStop
           ldw   Spointer
           subr  x,w
           tfr   w,d            string length
           addr  u,d
           cmpr  y,d
           lbcc  err47          string too long
           stw   3,y
           tfm   x+,u+          copy to expression stack
           LDA   #$FF
           STA   ,U+
L1361      stu   exprSP
           lda   #4
           sta   ,y
           PULS  U,X,A          reset pointers
           STA   charcoun
           STU   Spointer
           RTS

err67      LDB   #$43
           LBRA  L356

TAB        LDW   1,Y
           BLT   err67
           STY   SStop
           LDU   exprSP
           STU   1,Y
           ldb   charcoun
           clra
           subr  d,w            W = number spaces
           bhi   L1365
           clrw
L1365      stw   3,y
           beq   L1366
           tfr   u,d
           addr  w,d
           cmpr  y,d
           lbcc  err47          too big
           lda   #$20
           pshs  a
           tfm   s,u+           assemble string
           leas  1,s
L1366      LDA   #$FF
           STA   ,U+
           STU   exprSP
           LDA   #4
           STA   ,Y
           rts

DATE$      PSHS  X
           LEAY  -6,Y
           LEAX  -6,Y
           LDU   exprSP
           STU   1,Y
           ldd   #17
           std   3,y
           os9   F$Time
           BCS   L1371
           BSR   L1370
           LDA   #$2F
           BSR   L1372
           LDA   #$2F
           BSR   L1372
           LDA   #$20
           BSR   L1372
           LDA   #$3A
           BSR   L1372
           LDA   #$3A
           BSR   L1372
L1371      puls  x
           BRA   L1366

L1372      STA   ,U+
* byte to ascii
L1370      LDA   ,X+
           LDB   #$2F
L1374      INCB
           SUBA  #$0A
           BCC   L1374
           STB   ,U+
           LDB   #$3A
L1376      DECB
           INCA
           BNE   L1376
           STB   ,U+
           RTS

EOF        LDA   2,Y
           LDB   #6
           os9   I$GetStt
           BCC   L1378
           CMPB  #$D3
           BNE   L1378
           LDB   #$FF
           BRA   L1380

L1378      LDB   #0
L1380      CLRA
           STD   1,Y
           LDA   #3
           STA   ,Y
           RTS

L46        PSHS  PC,X,D
           ASLB
           LEAX  <L1398,PC
           LDD   B,X
           LEAX  D,X
           STX   4,S
           PULS  PC,X,D

* table
L1398      fdb   WRITLN-L1398
           fdb   PRintg-L1398
           fdb   PRintg-L1398
           fdb   PRreal-L1398
           fdb   PRbool-L1398
           fdb   PRstring-L1398
           fdb   READLN-L1398
           fdb   L2006-L1398
           fdb   L2007-L1398
           fdb   L2008-L1398
           fdb   L2009-L1398
           fdb   L2010-L1398
           fdb   Strterm-L1398
           fdb   L2012-L1398
           fdb   setFP-L1398
           fdb   err48-L1398
           fdb   L2015-L1398
           fdb   PRNTUSIN-L1398
           fdb   L1632-L1398
           fdb   L2018-L1398

*
L1540      fcb   6,2,39,16,3,232,0,100,0,10
L1490      fcb   4,160,0,0,0
           fcb   7,200,0,0,0
           fcb   10,250,0,0,0
           fcb   14,156,64,0,0
           fcb   17,195,80,0,0
           fcb   20,244,36,0,0
           fcb   24,152,150,128,0
           fcb   27,190,188,32,0
           fcb   30,238,107,40,0
           fcb   34,149,2,249,0
           fcb   37,186,67,183,64
           fcb   40,232,212,165,16
           fcb   44,145,132,231,42
           fcb   47,181,230,32,244
           fcb   50,227,95,169,50
           fcb   54,142,27,201,192
           fcb   57,177,162,188,46
           fcb   60,222,11,107,58
L1486      fcb   64,138,199,35,4
L1668      fcc   /True/
           fcb   255
L1672      fcc   /False/
           fcb   255

AtoITR     PSHS  U
           LEAY  -6,Y
* clear negative,decpoint,digits
           clrd
           clrw
           STQ   expneg
           STA   decimals
           STQ   2,Y
           STA   1,Y
           LBSR  L1418          check string
           BCC   L1420
           LEAX  -1,X
           CMPA  #$2C           , ??
           BNE   err59
           BRA   L1424

L1420      CMPA  #$24           hex number?
           LBEQ  L1426
           CMPA  #$2B           + ??
           BEQ   L1428
           CMPA  #$2D           - ??
           BNE   L1430
           INC   negativ
L1428      LDA   ,X+
L1430      CMPA  #$2E           . ??
           BNE   L1432
           TST   decpoint
           BNE   err59          only one allowed
           INC   decpoint
           BRA   L1428

L1432      LBSR  L1434
           BCS   L1436          not a number
           PSHS  A
           INC   digits
           LDQ   2,Y
           bita  #$E0
           bne   L1440
           rolw
           rold
           STQ   2,Y
           rolw
           rold
           rolw
           rold
           ADDW  4,Y
           adcd  2,Y
           BCS   L1440
           ADDF  ,S+
           BCC   L1442
           adde  #1
           BCC   L1442
           incd
           BEQ   err60
L1442      STQ   2,Y
           TST   decpoint
           BEQ   L1428
           INC   decimals
           BRA   L1428

L1440      LEAS  1,S
err60      LDB   #$3C
           BRA   L1448

err59      LDB   #$3B
L1448      STB   errcode
           COMA
           PULS  PC,U

L1436      EORA  #$45           = E
           ANDA  #$DF
           BEQ   L1450          exp. number
           LEAX  -1,X
           TST   digits
           BEQ   err59
           TST   decpoint
           BNE   L1454          real number
           LDD   2,Y
           BNE   L1454          large number
L1424      LDD   4,Y
           BMI   L1454          large number
           TST   negativ
           BEQ   L1456
           negd
L1456      STD   1,Y            integer number
L1504      LDA   #1
           LBRA  L1458

* exponential numbers *
L1450      LDA   ,X
           CMPA  #$2B           + ??
           BEQ   L1460
           CMPA  #$2D           - ??
           BNE   L1462
           INC   expneg
L1460      LEAX  1,X
L1462      LBSR  number
           BCS   err59
           TFR   A,B
           LBSR  number
           BCC   L1466
           LEAX  -1,X
           BRA   L1468
L1466      PSHS  A
           LDA   #$0A
           MUL   D*10
           ADDB  ,S+
L1468      TST   expneg
           BNE   L1470
           NEGB
L1470      ADDB  decimals
           STB   decimals
* real numbers *
L1454      LDB   #$20
           STB   1,Y
           LDQ   2,Y
           BNE   L1472          refers to regs.d
           tstw
           bne   L1472
           STA   1,Y            zero!!
           BRA   L1474
L1472      TSTA
           BMI   L1476
           andcc #^Carry
L1478      DEC   1,Y
           rolw
           rold
           BPL   L1478
           stq   2,y
L1476      CLR   expneg
           LDB   decimals
           BEQ   L1480          whole number
           BPL   L1482
           NEGB
           INC   expneg
L1482      CMPB  #$13
           BLS   L1484
           SUBB  #$13
           PSHS  B
           LEAU  L1486,PCR
           BSR   L1488
           PULS  B
           LBCS  err60
L1484      DECB
           LDA   #5
           MUL
           LEAU  L1490,PCR
           LEAU  B,U
           BSR   L1488
           LBCS  err60
L1480      LDA   5,Y            add sign
           ANDA  #$FE
           ORA   negativ
           STA   5,Y
L1474      LDA   #2             real number
L1458      STA   ,Y
           ANDCC #$FE
           PULS  PC,U
L1488      LEAY  -6,Y
           LDQ   ,U
           STQ   1,Y
           LDB   4,U
           STB   5,Y
           LDA   expneg
           LBEQ  RLDIV
           LBRA  RLMUL
* convert hex to decimal *
L1426      LBSR  number
           BCC   L1496          0-9
           anda  #$DF
           CMPA  #$41           A ??
           BCS   L1500
           CMPA  #$46           F ??
           BHI   L1500
           SUBA  #$37           conversion
L1496      INC   digits
           tfr   a,e
           ldd   1,y
           bita  #$F0
           lbne  err60
           asld
           asld
           asld
           asld
           addr  e,b
           std   1,y
           BRA   L1426
L1500      LEAX  -1,X
           TST   digits
           LBEQ  err59
           LBRA  L1504
* ----------------- *
L2008      PSHS  X
           LDX   Spointer
           LBSR  AtoITR
           BCC   L1508
L1518      PULS  PC,X
L1508      CMPA  #2
           BEQ   L1510
           LBSR  FLOAT
L1510      LBSR  L1514
           BCS   L1516
           LDB   #$3D           error 61
           STB   errcode
           COMA
           PULS  PC,X
L1516      STX   Spointer
           CLRA
           PULS  PC,X
L2006      PSHS  X
           LDX   Spointer
           LBSR  AtoITR
           BCS   L1518
           CMPA  #1
           BNE   err58
           TST   1,Y
           BEQ   L1510
           BRA   err58
L2007      PSHS  X
           LDX   Spointer
           LBSR  AtoITR
           BCS   L1518
           CMPA  #1
           BEQ   L1510
err58      LDB   #$3A
           STB   errcode
           COMA
           PULS  PC,X
*  verify string  *
L2010      PSHS  U,X
           LEAY  -6,Y
           LDU   exprBase
           STU   1,Y
           LDA   #4
           STA   ,Y
           clrb
           LDX   Spointer
L1526      LDA   ,X+
           BSR   L1522
           BCS   L1524
           STA   ,U+
           incb
           BRA   L1526
L1524      STX   Spointer
           LDA   #$FF
           STA   ,U+
           STU   exprSP
           CLRA
           std   3,y
           PULS  PC,U,X
* Boolean -> internal repr. *
L2009      PSHS  X
           LEAY  -6,Y
           LDA   #3
           STA   ,Y
           CLR   2,Y
           LDX   Spointer
           BSR   L1418
           BCS   L1528
           leax  3,x
           anda  #$DF
           CMPA  #$54           = T(rue)
           BEQ   L1530
           leax  1,x
           EORA  #$46           = F(alse)
           BEQ   L1532
           bra   err58
L1530      COM   2,Y
L1532      BSR   L1418
L1528      STX   Spointer
           CLRA
           PULS  PC,X
* validate characters *
L1514      LDA   ,X+
           CMPA  #$20           = space?
           BNE   L1522
           BSR   L1418
           BCC   L1534
           BRA   L1536
L1418      LDA   ,X+
           CMPA  #$20           = space?
           BEQ   L1418          skip them
L1522      CMPA  <$DD
           BEQ   L1536
           CMPA  #$0D           = CR?
           BEQ   L1534
           CMPA  #$FF           = end of string?
           BEQ   L1534
           ANDCC #$FE
           RTS
L1534      LEAX  -1,X
L1536      ORCC  #1
           RTS

* integer to ASCII *
ItoA       PSHS  U,X
           clrw
           STE   digits
           STE   negativ
           LDA   #4
           STA   <$7E
           LDD   1,Y
           BPL   L1538
           negd
           INC   negativ
L1538      LEAU  L1540,PC
L1552      clrf
           LEAU  2,U
L1544      SUBD  ,U
           BCS   L1542
           incf
           BRA   L1544

L1542      ADDD  ,U
           tstw
           BEQ   L1548
L1546      ince
           addf  #$30           convert to ASCII
           stf   ,x+
           inc   digits
L1548      DEC   <$7E
           BNE   L1552
           orb   #$30           convert to ASCII
           stb   ,x
           inc   digits
           LEAY  6,Y
           PULS  PC,U,X

* real to ASCII *
RtoA       PSHS  U,X
           clrw
           stw   expneg         + digits
           stw   negativ        + decimals
           stw   <$7B
           LEAU  ,X
           ldb   #$30           ASCII 0
           pshs  b
           ldw   #10            Fill buffer with 10 of them
           tfm   s,u+
           leas  1,s
           LDD   1,Y
           BNE   L1556
           INCA
           LBRA  L1558

L1556      LDB   5,Y
           BITB  #1
           BEQ   L1560
           STB   negativ
           ANDB  #$FE
           STB   5,Y
L1560      LDD   1,Y
           BPL   L1562
           INC   expneg
           NEGA
L1562      CMPA  #3
           BLS   L1564
           LDB   #$9A
           MUL
           LSRA
           TFR   A,B
           TST   expneg
           BEQ   L1566
           NEGB
L1566      STB   decimals
           CMPA  #$13
           BLS   L1568
           PSHS  A
           LEAU  L1486,PC
           LBSR  L1488
           PULS  A
           SUBA  #$13
L1568      LEAU  L1490,PC
           DECA
           LDB   #5
           MUL
           LEAU  D,U
           LBSR  L1488
L1564      LDQ   2,Y
           TST   1,Y
           BEQ   L1580
           BPL   L1572
L1574      lsrd
           rorw
           ROR   <$7C
           INC   1,Y
           BNE   L1574
           BRA   L1580

L1572      andcc #^Carry
           rolw
           rold
           ROL   <$7B
           DEC   1,Y
           BNE   L1572
           STA   2,Y
           INC   decimals
           LDA   <$7B
           BSR   L1550
           LDA   2,Y
L1580      CLR   <$7B
           rolw
           rold
           rol   <$7B
           STQ   2,Y
           LDA   <$7B
           STA   <$7C
           lda   2,y
           rolw
           rold
           ROL   <$7B
           rolw
           rold
           ROL   <$7B
           ADDW  4,Y
           adcd  2,Y
           PSHS  A
           LDA   <$7B
           ADCA  <$7C
           BSR   L1550
           LDA   digits
           CMPA  #9
           PULS  A
           BEQ   L1578
           tstd
           BNE   L1580
           tstw
           BNE   L1580
L1578      STA   ,Y
           LDA   digits
           CMPA  #9
           BCS   L1582
           LDB   ,Y
           BPL   L1582
L1584      LDA   ,-X
           INCA
           STA   ,X
           CMPA  #$39           = 9?
           BLS   L1582
           LDA   #$30           =0
           STA   ,X
           CMPX  ,S
           BNE   L1584
           INC   ,X
           INC   decimals
L1582      LDA   #9
L1558      STA   digits
           LEAY  6,Y
           PULS  PC,U,X

L1550      ORA   #$30           to ASCII
           STA   ,X+
           INC   digits
           RTS

READLN     PSHS  Y,X
           LDX   Sstack
           STX   Spointer
           LDA   #1
           STA   charcoun
           LDY   #$0100
           LDA   IOpath
           os9   I$ReadLn
           BRA   L1586

WRITLN     PSHS  Y,X
           LDX   Sstack
           LDY   Spointer
           subr  x,y
           beq   L1588
           STX   Spointer
           LDA   IOpath
           os9   I$WritLn
L1586      BCC   L1588
           STB   errcode
L1588      PULS  PC,Y,X

setFP      PSHS  U,X
           LDD   ,Y             type of filepointer
           CMPA  #2
           BEQ   L1590          real
           LDU   1,Y            integer
           BRA   L1592

L1590      tstb                 If exponent is <=0, Seek to 0
           BGT   L1594          Positive value, go calculate longint for SEEK
           LDU   #0             seek #0
L1592      LDX   #0
           BRA   L1596

L1594      SUBB  #$20           Only up to 2^32 allowed
           BCS   L1597          Good, continue
           LDB   #$4E           error 78 (seek error)
           COMA
           BRA   L1600

L1597      lda   #$FF           Force Value to -1 to -32
           tfr   d,x            Move into X for counter
           ldq   2,y            Get mantissa
L1598      lsrd                 Calculate to power of exponent
           rorw
           leax  1,x            Do until done
           BNE   L1598
           tfr   d,x            Move 32 bit result to proper regs for SEEK
           tfr   w,u
L1596      LDA   IOpath         Do the seek
           os9   I$Seek
           BCC   L1602
L1600      STB   errcode
L1602      PULS  PC,U,X

* print real numbers *
PRreal     PSHS  U,X
           LEAS  -10,S
           LEAX  ,S
           LBSR  RtoA
           PSHS  X
           LDA   #9
           LEAX  9,X
L1608      LDB   ,-X
           CMPB  #$30
           BNE   L1606
           DECA
           CMPA  #1
           BNE   L1608          skip 0s
L1606      STA   digits
           PULS  X
           LDB   decimals
           BGT   L1610
           NEGB
           TFR   B,A
           CMPB  #9
           BHI   L1612
           ADDB  digits
           CMPB  #9
           BHI   L1612
*  0 < x < 1  *
           PSHS  A
           LBSR  L1614
           CLRA
           LBSR  L1616
           PULS  B
           TSTB
           BEQ   L1618
           LBSR  L1620
L1618      LDA   digits
           BRA   L1622

*  real number  *
L1610      CMPB  #9
           BHI   L1612
           LBSR  L1614
           TFR   B,A
           BSR   L1624
           LBSR  L1616
           LDA   digits
           SUBA  decimals
           BLS   L1626
L1622      BSR   L1624
L1626      LEAS  10,S
           CLRA
           PULS  PC,U,X

*  exponential number  *
L1612      LBSR  L1614
           LDA   #1
           BSR   L1624
           BSR   L1616
           LDA   digits
           DECA
           BNE   L1628
           INCA
L1628      BSR   L1624
           BSR   L1630
           BRA   L1626

*  exponent  *
L1630      LDE   #$45           = E
           LDA   decimals
           DECA
           PSHS  A
           BPL   L1634
           NEG   ,S
           ldf   #$2D           = -
           BRA   L1638

L1634      ldf   #$2B           = +
L1638      PULS  B
           CLRA
L1644      SUBB  #$0A
           BCS   L1642
           INCA
           BRA   L1644
L1642      ADDB  #$0A           exp. in D
           addd  #$3030         -> ASCII
           pshs  d
           pshsw                exp. on stack
           ldb   #4
           bsr   L1650
           cmpw  #4             space left to print it?
           beq   L1646
           leas  4,s            no, clean up stack
           rts

L1646      tfm   s+,d+
           std   Spointer
           rts

*
L1624      TFR   A,B
L1625      TSTB
           BEQ   L1648
           bsr   L1650
           tfm   x+,d+
L1649      std   Spointer
L1648      RTS

*
L1650      tfr   s,w
           subw  #64
           subw  Spointer       w holds max. length
           clra
           cmpr  w,d
           bhs   L1651          too long: truncate
           tfr   d,w
L1651      ldb   charcoun
           addr  f,b            update counter
           stb   charcoun
           ldd   Spointer       destination
           rts

* ---------------- *
L1660      LDA   #$20           = space
           BRA   L1632

L1616      LDA   #$2E           = .
L1632      PSHS  U,A
           LEAU  <-$40,S
           CMPU  Spointer
           BHI   L1652          space left!!
           CMPA  #$0D           CR ??
           BEQ   L1652
           LDA   #47            error 47
           STA   errcode
           coma
           BRA   L1654

L1652      LDU   Spointer
           STA   ,U+
           STU   Spointer
           INC   charcoun
L1654      PULS  PC,U,A

*
spacing    LDA   #$20           = space
L1662      TSTB                 0 chars?
           BEQ   L1656          Yes, return
           pshs  a
           bsr   L1650
           tfm   s,d+
           leas  1,s
           std   Spointer
L1656      RTS

* NOTE: Should use LDA <negative, faster, and A not required
L1800      TST   negativ
           BEQ   L1660
L1614      TST   negativ
           BEQ   L1656
L1636      LDA   #$2D           = -
           BRA   L1632

L1640      LDA   #$2B           = +
           BRA   L1632

L1620      LDA   #$30           = 0
           BRA   L1662

*  print string  *
PRstring   PSHS  X
           LDX   1,Y
           ldd   3,y
L1670      bsr   L1625
           CLRA
           PULS  PC,X

* value of boolean variable *
PRbool     PSHS  X
           LEAX  L1668,PC       = TRUE
           ldb   #4             # chars to print
           LDA   2,Y
           BNE   L1670
           LEAX  L1672,PC       = FALSE
           incb                 5 chars to print
           BRA   L1670

* print integers *
PRintg     PSHS  X
           ldx   #$26           var.space in DP
           LBSR  ItoA
           tst   negativ        NOTE: USE LDB instead
           beq   L1711
           lda   #$2D           = -
           sta   ,-x
           inc   digits
L1711      LDB   digits
           bra   L1670

* pad with spaces (TAB) *
L2015      TFR   A,B
L1712      SUBB  charcoun
           BLS   L1676
           BSR   spacing
L1676      CLRA
           RTS

* pad field with spaces *
L2012      LDA   charcoun
           ANDA  #$0F
           ldb   #17            16 chars/field
           subr  a,b
           BRA   spacing

* terminate string *
Strterm    LDA   #$0D           /CR/
           CLR   charcoun
           LBSR  L1632
L1680      CLRA
           RTS

* justification of print using
L1744      CLRB
           STB   justify
           CMPA  #$3C           = <
           BEQ   L1688
           CMPA  #$3E           = >
           BNE   L1690
           INCB
           BRA   L1688

L1690      CMPA  #$5E           = ^
           BNE   ckmarker
           DECB
L1688      STB   justify
           LDA   ,X+
ckmarker   CMPA  #$2C           = ,
           BEQ   L1694
           CMPA  #$FF
           BNE   L1696
           LDA   <$94
           BEQ   L1698
           LEAX  -1,X
           BRA   L1700

L1698      LDX   <$8E
           TST   <$DC
           BEQ   L1702
           CLR   <$DC
           BRA   L1694

L1696      CMPA  #$29           = )
           BEQ   L1704
L1702      ORCC  #1
           RTS

L1704      LDA   <$94
           BEQ   L1702
L1700      DEC   <$92
           BNE   L1706
           LDU   userSP
           PULU  Y,A
           STA   <$92
           STY   <$90
           STU   userSP
           LDA   ,X+
           DEC   <$94
           BRA   ckmarker

L1706      LDX   <$90
L1694      STX   <$8C
           ANDCC #$FE
           RTS

* chars recognized by PRINT USING
L1726      fcb   73             Integer
           fdb   L2050-L1726
L2051Bas   equ   *
           fcb   72             Hexadecimal
           fdb   L2051
L2052Bas   equ   *
           fcb   82             Real
           fdb   L2052
L2053Bas   equ   *
           fcb   69             Exponential
           fdb   L2053
L2054Bas   equ   *
           fcb   83             String
           fdb   L2054
L2055Bas   equ   *
           fcb   66             Boolean
           fdb   L2055
L2056Bas   equ   *
           fcb   84             Tab
           fdb   L2056
L2057Bas   equ   *
           fcb   88             X - space
           fdb   L2057
L2058Bas   equ   *
           fcb   39             ' - literal string
           fdb   L2058
           fcb   0              end of table

* Tab function
L2056      equ   *-L2056Bas
           BSR   ckmarker
           BCS   err63
           LDB   fieldwid
           LBSR  L1712
           BRA   L1714

* print spaces (X) *
L2057      equ   *-L2057Bas
           BSR   ckmarker
           BCS   err63
           LDB   fieldwid
           LBSR  spacing
           BRA   L1714

* print literal string *
L2058      equ   *-L2058Bas
           pshs  x
           clrb
L1718      CMPA  #$FF
           BEQ   err63
           CMPA  #$27           = '
           beq   L1716
           incb
           LDA   ,X+
           BRA   L1718
L1716      puls  x
           leax  -1,x
           lbsr  L1625
           leax  1,x
           LDA   ,X+
           LBSR  ckmarker
           BCS   err63
           BRA   L1714

PRNTUSIN   PSHS  Y,X
           CLR   <$DC
           INC   <$DC
L1714      LDX   <$8C
           BSR   L1720
           BCS   L1722
           CMPA  #$28
           BNE   err62
           LDA   <$92
           STB   <$92
           BEQ   err62
           INC   <$94
           LDU   userSP
           LDY   <$90
           PSHU  Y,A
           STU   userSP
           STX   <$90
           LDA   ,X+
L1722      LEAY  <L1726,PC
           CLRB
L1730      PSHS  A
           EORA  ,Y
           ANDA  #$DF
           PULS  A
           BEQ   L1728
           LEAY  3,Y
           INCB
           TST   ,Y
           BNE   L1730
err63      LDB   #$3F
           BRA   L1732

err62      LDB   #$3E
L1732      STB   errcode
           COMA
           PULS  PC,Y,X

L1728      STB   subrcode
           LDD   1,Y
           LEAY  D,Y
           BSR   L1720
           BCC   L1734
           LDB   #1
L1734      STB   fieldwid
           JMP   ,Y

* calculate field width
L1720      BSR   number
           BCS   L1736
           TFR   A,B
           BSR   number
           BCS   L1738
           BSR   L1740
           BSR   number
           BCS   L1738
           BSR   L1740
           TSTA
           BEQ   L1742
           CLRB
L1742      LDA   ,X+
           BRA   L1738

number     LDA   ,X+
L1434      CMPA  #$30           = 0?
           BCS   L1736
           CMPA  #$39           = 9?
           BHI   L1736
           SUBA  #$30           ASCII -> dec.
L1738      ANDCC #$FE
           RTS

L1736      ORCC  #1
           RTS

L1740      PSHS  A
           LDA   #10
           MUL                  10*B+A
           ADDB  ,S+
           ADCA  #0
           RTS

L2052      equ   *-L2052Bas
L2053      equ   *-L2053Bas
           CMPA  #$2E           format as real or exp.
           BNE   err63
           BSR   L1720
           BCS   err63
           STB   <$89

L2051      equ   *-L2051Bas
L2054      equ   *-L2054Bas
L2055      equ   *-L2055Bas
L2050      LBSR  L1744          Int, Hex, String, Boolean
           BCS   err63
           PULS  Y,X
           INC   <$DC
L2018      LDB   subrcode
           LBEQ  FMTint
           DECB
           BEQ   FMThex
           DECB
           LBEQ  FMTreal
           DECB
           LBEQ  FMTexp
           DECB
           LBEQ  FMTstr
           LBRA  FMTbool

FMThex     JSR   table4
           pshs  y
           CMPA  #4
           BCS   L1758
           LDU   1,Y            source: string
           ldd   3,y
           bra   L1686

L1758      LEAU  1,Y
           LDA   ,Y
           CMPA  #2
           BNE   L1764
           LDB   #5             source: real number
           BRA   L1686

L1764      CMPA  #1
           BNE   L1766
           LDB   #2             source: integer
           CMPB  fieldwid
           BCS   L1768
L1766      LDB   #1             byte, boolean
           LEAU  1,U
L1768      TFR   B,A
           ASLA
           CMPA  fieldwid
           BLS   L1686
           ANDA  #$0F
           CMPA  #9
           BLS   L1784
           ADDA  #7
L1784      LBSR  L1646
           DEC   fieldwid
           bra   L1782

L1686      TST   justify
           pshs  b
           BEQ   L1776          left justify
           BMI   L1774          center digits
           ASLB  right          justify
           PSHS  B
           LDB   fieldwid
           SUBB  ,S+
           BCS   L1776
           BRA   L1778

L1774      ASLB
           PSHS  B
           LDB   fieldwid
           SUBB  ,S+
           BCS   L1776
           ASRB
L1778      LDA   fieldwid
           subr  b,a
           STA   fieldwid
           LBSR  spacing
L1776      ldb   fieldwid
           lbsr  L1650
           tfr   d,y
           PULS  B
L1772      LDA   ,U
           LSRA
           LSRA
           LSRA
           LSRA
           cmpa  #9
           bls   L1773
           adda  #7
L1773      adda  #$30
           sta   ,y+
           decw
           BEQ   L1782
L1770      LDA   ,U+
           anda  #15
           cmpa  #9
           bls   L1771
           adda  #7
L1771      adda  #$30
           sta   ,y+
           decw
           BEQ   L1782
           DECB
           BNE   L1772
           lda   #$20       Space
           pshs  a
           tfm   s,y+
           leas  1,s
L1782      sty   Spointer
           puls  y
           CLRA
           sta   fieldwid
           RTS

L1788      COMA
           RTS

FMTint     JSR   table4
           CMPA  #2
           BCS   L1786
           BNE   L1788          wrong var. type
           LBSR  FIX
L1786      PSHS  U,X
           LEAS  -5,S
           LEAX  ,S
           LBSR  ItoA
           LDB   fieldwid
           DECB
           SUBB  digits
           BPL   L1792
           LEAS  5,S
           PULS  U,X
           LBRA  ovflow

L1792      TST   justify
           BEQ   L1796          left justify
           BMI   L1798          leading zeroes
           LBSR  spacing        right justify
           LBSR  L1800
           BRA   L1802

L1796      LBSR  L1800
           PSHS  B
           LDA   digits
           LBSR  L1624
           PULS  B
           LBSR  spacing
           BRA   L1804

L1798      LBSR  L1800
           LBSR  L1620
L1802      LDA   digits
           LBSR  L1624
L1804      LEAS  5,S
           CLRA
           PULS  PC,U,X

FMTbool    JSR   table4
           CMPA  #3
           BNE   L1788          wrong type
           PSHS  U,X
           LEAX  L1668,PC
           LDB   #4
           LDA   2,Y
           BNE   L1806
           LEAX  L1672,PC
           LDB   #5
           BRA   L1806

FMTstr     JSR   table4
           CMPA  #4
           BNE   L1788          wrong type
           PSHS  U,X
           LDX   1,Y
           ldd   3,y
           TSTA
           BNE   L1808
L1806      CMPB  fieldwid
           BLS   L1810
L1808      LDB   fieldwid
L1810      TFR   B,A
           NEGB
           ADDB  fieldwid
           TST   justify
           BEQ   L1812          left justify
           BMI   L1814          center text
           PSHS  A              right justify
           LBSR  spacing
           PULS  A
           LBSR  L1624
           BRA   L1816

L1812      PSHS  B
           BRA   L1818

L1814      LSRB
           BCC   L1820
           INCB
L1820      PSHS  d
           LBSR  spacing
           PULS  A
L1818      LBSR  L1624
           PULS  B
           LBSR  spacing
L1816      CLRA
           PULS  PC,U,X

FMTreal    JSR   table4
           CMPA  #2
           BEQ   L1822
           LBCC  L1788          wrong type
           LBSR  FLOAT
L1822      PSHS  U,X
           LEAS  -$0A,S
           LEAX  ,S
           LBSR  RtoA
           LDA   decimals
           CMPA  #9
           BGT   L1824
           LBSR  L1826
           LDA   fieldwid
           SUBA  #2
           BMI   L1824
           SUBA  <$89
           BMI   L1824
           SUBA  <$8A
           BPL   L1828
L1824      LEAS  $0A,S
           PULS  U,X
           BRA   ovflow

L1828      STA   <$88
           LEAX  ,S
           LDB   justify
           BEQ   L1830          left justify
           BMI   L1832          fin. format
           BSR   L1834          right justify
           BSR   L1836
           BRA   L1838

L1830      BSR   L1836
           BSR   L1834
           BRA   L1838

L1832      BSR   L1834
           BSR   L1840
           LBSR  L1800
L1838      LEAS  $0A,S
           CLRA
           PULS  PC,U,X

L1836      LBSR  L1800
L1840      LDA   <$8A
           LBSR  L1624
           LBSR  L1616
           LDB   decimals
           BPL   L1842
           NEGB
           CMPB  <$89
           BLS   L1844
           LDB   <$89
L1844      PSHS  B
           LBSR  L1620
           LDB   <$89
           SUBB  ,S+
           STB   <$89
           LDA   <$8B
           CMPA  <$89
           BLS   L1846      NOTE: SHOULD BE BLS L1848
           LDA   <$89
L1846      BRA   L1848

L1834      LDB   <$88
           LBRA  spacing
L1862      LBSR  L1800
           LDA   <$8A
           LBSR  L1624
           LBSR  L1616
L1842      LDA   <$8B
L1848      LBSR  L1624
           LDB   <$89
           SUBB  <$8B
           BLE   L1850
           LBRA  L1620

ovflow     LDB   fieldwid
           LDA   #$2A           = *
           LBSR  L1662
           CLRA
L1850      RTS

FMTexp     JSR   table4
           CMPA  #2
           BEQ   L1852
           LBCC  L1788          wrong type
           LBSR  FLOAT
L1852      PSHS  U,X
           LEAS  -$0A,S
           LEAX  ,S
           LBSR  RtoA
           LDA   decimals
           PSHS  A
           LDA   #1
           STA   decimals
           BSR   L1826
           PULS  A
           LDB   decimals
           CMPB  #1
           BEQ   L1854
           INCA
L1854      LDB   #1
           STB   <$8A
           STA   decimals
           LDA   fieldwid
           SUBA  #6
           BMI   L1856
           SUBA  <$89
           BMI   L1856
           SUBA  <$8A
           BPL   L1858
L1856      LEAS  $0A,S
           PULS  U,X
           BRA   ovflow

L1858      STA   <$88
           LDB   justify
           BEQ   L1860          left justify
           BSR   L1834          right justify
           BSR   L1862
           LBSR  L1630
           BRA   L1864

L1860      BSR   L1862
           LBSR  L1630
L1864      LBRA  L1838

L1826      PSHS  X
           LDA   decimals
           ADDA  <$89
           BNE   L1866
           LDA   ,X
           CMPA  #$35
           BCC   L1868
L1866      DECA
           BMI   L1870
           CMPA  #7
           BHI   L1870
           LEAX  A,X
           LDB   1,X
           CMPB  #$35
           BCS   L1870
L1872      INC   ,X
           LDB   ,X
           CMPB  #$39
L1310      BLS   L1870
L1868      LDB   #$30
           STB   ,X
           LEAX  -1,X
           CMPX  ,S
           BCC   L1872
           LDX   ,S
           LEAX  8,X
L1874      LDA   ,-X
           STA   1,X
           CMPX  ,S
           BHI   L1874
           LDA   #$31
           STA   ,X
           INC   decimals
L1870      PULS  X
           LDA   decimals
           BPL   L1876
           CLRA
L1876      STA   <$8A
           NEGA
           ADDA  #9
           BPL   L1878
           CLRA
L1878      CMPA  <$89
           BLS   L1880
           LDA   <$89
L1880      STA   <$8B
           RTS

err48      LDB   #$30
           STB   errcode
           COMA
           RTS

           emod
MODEND     equ   *
           end

