           NAM   Basic09Runtime

           IFP1
           USE   defsfile
           ENDC

           IFNE  H6309
* RunB from BASICBOOST from Chris Dekker - 6309'ized version of RunB

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
L204       fcb   242,23,146,25,145,19,144,23
           fcb   143,13,142,13,141,13,85,9,75
           fcb   11,62,17,0,7
           LEAY  3,Y
           LEAY  1,Y
           LEAY  1,Y
           BRA   L208

L210       TST   ,Y+
           BPL   L210
           BRA   L208
           PULS  PC,X,d

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
           andcc #$FE           clear carry
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
           andcc #$FE
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
           andcc #$FE
           BRA   L946

L942       ADDB  #8
           STB   ,Y
           LDW   #$8000
           LDD   $0A,Y
           andcc #$FE
           BRA   L946

L940       ADDB  #8
           BLT   L948
           STB   ,Y
           LDQ   9,Y
           LDF   #$80
           andcc #$FE
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

L1066      andcc #$FE
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
           andcc #$FE
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
           andcc #$FE
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

L1572      andcc #$FE
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
           
           ELSE

* 6809 version
L0000    fcb   $87,$CD,$2F,$99,$00,$1B,$11,$81   .M/.....
L0008    fcb   $88,$01,$95,$20,$00,$00,$D9,$04   ... ..Y.
L0010    fcb   $68,$06,$D8,$06,$EB,$10,$DF,$25   h.X.k._%
L0018    fcb   $51,$00,$00,$52,$75,$6E,$C2,$16   Q..RunB.
L0020    fcb   $06,$0C,$20,$20,$20,$20,$20,$20   ..      
L0028    fcb   $20,$20,$20,$20,$20,$20,$42,$41         BA
L0030    fcb   $53,$49,$43,$30,$39,$0A,$20,$20   SIC09.  
L0038    fcb   $20,$20,$20,$20,$52,$53,$20,$56       RS V
L0040    fcb   $45,$52,$53,$49,$4F,$4E,$20,$30   ERSION 0
L0048    fcb   $31,$2E,$30,$30,$2E,$30,$31,$0A   1.00.01.
L0050    fcb   $43,$4F,$50,$59,$52,$49,$47,$48   COPYRIGH
L0058    fcb   $54,$20,$31,$39,$38,$30,$20,$42   T 1980 B
L0060    fcb   $59,$20,$4D,$4F,$54,$4F,$52,$4F   Y MOTORO
L0068    fcb   $4C,$41,$20,$49,$4E,$43,$2E,$0A   LA INC..
L0070    fcb   $20,$20,$41,$4E,$44,$20,$4D,$49     AND MI
L0078    fcb   $43,$52,$4F,$57,$41,$52,$45,$20   CROWARE 
L0080    fcb   $53,$59,$53,$54,$45,$4D,$53,$20   SYSTEMS 
L0088    fcb   $43,$4F,$52,$50,$2E,$0A,$20,$20   CORP..  
L0090    fcb   $20,$52,$45,$50,$52,$4F,$44,$55    REPRODU
L0098    fcb   $43,$45,$44,$20,$55,$4E,$44,$45   CED UNDE
L00A0    fcb   $52,$20,$4C,$49,$43,$45,$4E,$53   R LICENS
L00A8    fcb   $45,$0A,$20,$20,$20,$20,$20,$20   E.      
L00B0    fcb   $20,$54,$4F,$20,$54,$41,$4E,$44    TO TAND
L00B8    fcb   $59,$20,$43,$4F,$52,$50,$2E,$0A   Y CORP..
L00C0    fcb   $20,$20,$20,$20,$41,$4C,$4C,$20       ALL 
L00C8    fcb   $52,$49,$47,$48,$54,$53,$20,$52   RIGHTS R
L00D0    fcb   $45,$53,$45,$52,$56,$45,$44,$2E   ESERVED.
L00D8    fcb   $8A,$34,$16,$E6,$F8,$04,$30,$8C   .4.fx.0.
L00E0    fcb   $08,$EC,$85,$30,$8B,$AF,$64,$35   .l.0./d5
L00E8    fcb   $96,$03,$00,$03,$25,$01,$65,$01   ....%.e.
L00F0    fcb   $5B,$03,$29,$02,$7C,$02,$76,$02   [.).|.v.
L00F8    fcb   $98,$03,$4A,$9D,$1E,$04,$9D,$1E   ..J.....
L0100    fcb   $02,$9D,$1E,$00,$9D,$21,$00,$9D   .....!..
L0108    fcb   $24,$00,$9D,$24,$04,$9D,$24,$02   $..$..$.
L0110    fcb   $9D,$2A,$02,$0E,$52,$65,$61,$64   .*..Read
L0118    fcb   $F9,$57,$68,$61,$74,$BF,$20,$66   yWhat? f
L0120    fcb   $72,$65,$E5,$50,$72,$6F,$67,$72   reeProgr
L0128    fcb   $61,$ED,$50,$52,$4F,$43,$45,$44   amPROCED
L0130    fcb   $55,$52,$C5,$0D,$0A,$20,$20,$4E   URE..  N
L0138    fcb   $61,$6D,$65,$20,$20,$20,$20,$20   ame     
L0140    fcb   $20,$50,$72,$6F,$63,$2D,$53,$69    Proc-Si
L0148    fcb   $7A,$65,$20,$20,$44,$61,$74,$61   ze  Data
L0150    fcb   $2D,$53,$69,$7A,$E5,$52,$65,$77   -SizeRew
L0158    fcb   $72,$69,$74,$65,$3F,$3A,$20,$52   rite?: R
L0160    fcb   $41,$4E,$47,$45,$87,$0E,$42,$52   ANGE..BR
L0168    fcb   $45,$41,$4B,$3A,$A0,$63,$61,$6C   EAK: cal
L0170    fcb   $6C,$65,$64,$20,$62,$F9,$6F,$EB   led byok
L0178    fcb   $44,$BA,$45,$BA,$42,$BA,$63,$61   D:E:B:ca
L0180    fcb   $6E,$27,$74,$20,$66,$69,$6E,$64   n't find
L0188    fcb   $BA,$A6,$63,$1F,$8B,$D7,$35,$08   :&c..W5.
L0190    fcb   $34,$43,$06,$34,$3B,$34,$40,$33   4C.4;4@3
L0198    fcb   $C9,$01,$00,$4F,$5F,$ED,$C3,$11   I..O_mC.
L01A0    fcb   $A3,$E4,$22,$F9,$35,$06,$33,$84   #d"y5.3.
L01A8    fcb   $DD,$00,$4C,$97,$D9,$DD,$80,$DD   ].L.Y].]
L01B0    fcb   $82,$8B,$02,$DD,$46,$DD,$44,$4C   ...]F]DL
L01B8    fcb   $1F,$04,$DD,$04,$4C,$DD,$08,$DD   ..].L].]
L01C0    fcb   $4A,$1F,$30,$93,$00,$DD,$02,$4F   J.0..].O
L01C8    fcb   $C6,$01,$DD,$2D,$97,$BD,$86,$03   F.]-.=..
L01D0    fcb   $10,$3F,$8F,$4C,$81,$10,$25,$F8   .?.L..%x
L01D8    fcb   $86,$02,$10,$3F,$82,$97,$BE,$0F   ...?..>.
L01E0    fcb   $35,$34,$10,$30,$8C,$A3,$10,$3F   54.0.#.?
L01E8    fcb   $09,$9E,$08,$4F,$5F,$ED,$83,$9C   ...O_m..
L01F0    fcb   $04,$22,$FA,$30,$8D,$FE,$09,$34   ."z0...4
L01F8    fcb   $10,$9E,$00,$30,$88,$1B,$31,$8D   ...0..1.
L0200    fcb   $FE,$0B,$86,$7E,$A7,$80,$EC,$A1   ...~'.l!
L0208    fcb   $E3,$E4,$ED,$81,$EC,$A4,$26,$F2   cdm.l$&r
L0210    fcb   $32,$62,$17,$FE,$F2,$35,$20,$8D   2b..r5 .
L0218    fcb   $09,$9E,$04,$EC,$84,$DD,$2F,$17   ...l.]/.
L0220    fcb   $00,$97,$30,$8C,$36,$35,$40,$8D   ..0.65@.
L0228    fcb   $25,$34,$40,$0F,$34,$DC,$00,$D3   %4@.4\.S
L0230    fcb   $02,$93,$08,$93,$0A,$DD,$0C,$33   .....].3
L0238    fcb   $62,$DF,$46,$DF,$44,$32,$E9,$FF   b_F_D2i.
L0240    fcb   $02,$6E,$D8,$FE,$10,$DE,$B7,$35   .nX..^75
L0248    fcb   $06,$DD,$B7,$16,$00,$5F,$DC,$B7   .]7.._\7
L0250    fcb   $34,$06,$10,$DF,$B7,$EC,$62,$AF   4.._7lb/
L0258    fcb   $62,$1F,$05,$8D,$C5,$16,$00,$FF   b...E...
L0260    fcb   $C6,$2C,$17,$01,$A9,$16,$FF,$DC   F,..)..\
L0268    fcb   $C6,$2B,$20,$F6,$E6,$A0,$C1,$2C   F+ vf A,
L0270    fcb   $27,$06,$C1,$20,$27,$02,$31,$3F   '.A '.1?
L0278    fcb   $39,$17,$FE,$82,$26,$0E,$10,$9E   9...&...
L0280    fcb   $2F,$27,$05,$EC,$24,$31,$AB,$39   /'.l$1+9
L0288    fcb   $31,$8D,$FE,$97,$39,$DE,$46,$DF   1...9^F_
L0290    fcb   $44,$9E,$04,$EC,$84,$27,$04,$1F   D..l.'..
L0298    fcb   $10,$30,$02,$ED,$C3,$26,$F4,$DF   .0.mC&t_
L02A0    fcb   $44,$A6,$A4,$81,$0D,$27,$02,$31   D&$..'.1
L02A8    fcb   $21,$10,$9F,$82,$39,$0F,$7D,$0C   !...9.}.
L02B0    fcb   $7D,$34,$10,$9E,$80,$9F,$82,$35   }4.....5
L02B8    fcb   $90,$17,$FE,$42,$26,$13,$34,$20   ...B&.4 
L02C0    fcb   $17,$FF,$B6,$AE,$E4,$A6,$A0,$A7   ..6.d& '
L02C8    fcb   $80,$2A,$FA,$86,$0D,$A7,$84,$35   .*z..'.5
L02D0    fcb   $20,$17,$01,$15,$10,$25,$FF,$90    ....%..
L02D8    fcb   $AE,$84,$9F,$2F,$A6,$06,$27,$08   .../&.'.
L02E0    fcb   $84,$0F,$81,$02,$26,$74,$20,$06   ....&t .
L02E8    fcb   $A6,$88,$17,$46,$25,$6C,$17,$FE   &..F%l..
L02F0    fcb   $10,$10,$9E,$4A,$E6,$A4,$C1,$3D   ...Jf$A=
L02F8    fcb   $27,$60,$10,$9F,$5E,$10,$9F,$5C   '`..^..\
L0300    fcb   $9E,$AB,$9F,$60,$9F,$4A,$DC,$0C   .+.`.J\.
L0308    fcb   $34,$26,$17,$FD,$F7,$35,$26,$DD   4&..w5&]
L0310    fcb   $0C,$10,$9F,$4A,$9E,$2F,$A6,$88   ...J./&.
L0318    fcb   $17,$46,$25,$3E,$32,$E9,$01,$02   .F%>2i..
L0320    fcb   $DC,$00,$D3,$02,$1F,$02,$DD,$46   \.S...]F
L0328    fcb   $DD,$44,$CE,$00,$00,$DF,$31,$DF   ]DN.._1_
L0330    fcb   $B3,$0C,$B4,$0F,$36,$DC,$4A,$9E   3.4.6\J.
L0338    fcb   $0C,$34,$16,$30,$8D,$00,$12,$17   .4.0....
L0340    fcb   $FF,$0C,$9E,$4A,$17,$FD,$C3,$17   ...J..C.
L0348    fcb   $FF,$63,$9E,$2F,$17,$FD,$BE,$20   .c./..> 
L0350    fcb   $06,$35,$16,$DD,$4A,$9F,$0C,$16   .5.]J...
L0358    fcb   $FE,$EA,$C6,$33,$16,$FF,$03,$8D   .jF3....
L0360    fcb   $20,$5F,$10,$3F,$06,$17,$FD,$96    _.?....
L0368    fcb   $27,$13,$17,$00,$59,$25,$0E,$DE   '...Y%.^
L0370    fcb   $46,$4F,$5F,$36,$16,$4C,$97,$35   FO_6.L.5
L0378    fcb   $8D,$17,$0F,$35,$39,$53,$C6,$2B   ...59SF+
L0380    fcb   $39,$10,$9E,$82,$86,$2A,$A7,$A4   9....*'$
L0388    fcb   $97,$35,$17,$FF,$00,$0F,$2F,$0F   .5..../.
L0390    fcb   $30,$DE,$46,$DF,$44,$20,$10,$AE   0^F_D ..
L0398    fcb   $84,$34,$40,$33,$84,$10,$3F,$02   .4@3..?.
L03A0    fcb   $35,$40,$CC,$FF,$FF,$ED,$D4,$AE   5@L..mT.
L03A8    fcb   $C3,$26,$EC,$9E,$04,$1F,$12,$EC   C&l....l
L03B0    fcb   $81,$10,$83,$FF,$FF,$27,$F8,$ED   .....'xm
L03B8    fcb   $A1,$26,$F4,$10,$A3,$A4,$26,$F7   !&t.#$&w
L03C0    fcb   $39,$C6,$20,$16,$FE,$9C,$34,$60   9F ...4`
L03C8    fcb   $9E,$04,$10,$AE,$E4,$EE,$81,$27   ....dn.'
L03D0    fcb   $15,$EC,$44,$33,$CB,$A6,$A0,$A8   .lD3K& (
L03D8    fcb   $C0,$84,$DF,$26,$ED,$4F,$6D,$5F   @._&mOm_
L03E0    fcb   $2A,$F3,$30,$1E,$35,$C6,$43,$20   *s0.5FC 
L03E8    fcb   $F9,$8D,$DB,$25,$01,$39,$34,$70   y.[%.94p
L03F0    fcb   $E6,$61,$C1,$FE,$27,$CB,$30,$A4   faA.'K0$
L03F8    fcb   $4F,$5F,$10,$3F,$00,$24,$09,$AE   O_.?.$..
L0400    fcb   $62,$4F,$5F,$10,$3F,$01,$25,$04   bO_.?.%.
L0408    fcb   $AF,$62,$EF,$F4,$35,$F0,$10,$3F   /bot5p.?
L0410    fcb   $0F,$39,$34,$06,$20,$10,$34,$30   .94. .40
L0418    fcb   $A6,$80,$81,$FF,$27,$10,$A1,$A0   &...'.! 
L0420    fcb   $27,$F6,$35,$30,$31,$21,$10,$AC   'v501!.,
L0428    fcb   $E4,$23,$EB,$43,$35,$86,$35,$30   d#kC5.50
L0430    fcb   $4F,$35,$86,$34,$16,$30,$8C,$0A   O5.4.0..
L0438    fcb   $A6,$A0,$A1,$81,$25,$FC,$E6,$82   & !.%.f.
L0440    fcb   $6E,$85,$F2,$17,$92,$19,$91,$13   n.r.....
L0448    fcb   $90,$17,$8F,$0D,$8E,$0D,$8D,$0D   ........
L0450    fcb   $55,$09,$4B,$0B,$3E,$11,$00,$07   U.K.>...
L0458    fcb   $31,$23,$31,$21,$31,$21,$20,$D5   1#1!1! U
L0460    fcb   $6D,$A0,$2A,$FC,$20,$CF,$35,$96   m *. O5.
L0468    fcb   $34,$16,$E6,$F8,$04,$30,$8C,$08   4.fx.0..
L0470    fcb   $EC,$85,$30,$8B,$AF,$64,$35,$96   l.0./d5.
L0478    fcb   $00,$95,$01,$AA,$02,$30,$02,$0E   ...*.0..
L0480    fcb   $9D,$1B,$02,$9D,$1B,$04,$9D,$1B   ........
L0488    fcb   $06,$9D,$2A,$00,$00,$07,$03,$CB   ..*....K
L0490    fcb   $4B,$0C,$AC,$CB,$4D,$0C,$A8,$CB   K.,KM.(K
L0498    fcb   $4E,$0C,$A9,$D4,$89,$0C,$AE,$21   N.)T...!
L04A0    fcb   $90,$06,$A2,$00,$91,$06,$A4,$CB   .."...$K
L04A8    fcb   $3F,$02,$8D,$96,$0B,$34,$02,$9E   ?....4..
L04B0    fcb   $A7,$86,$0D,$68,$84,$64,$84,$A1   '..h.d.!
L04B8    fcb   $80,$26,$F8,$9E,$A7,$8D,$36,$DC   .&x.'.6\
L04C0    fcb   $B9,$93,$A7,$34,$04,$9E,$AF,$9F   9.'4../.
L04C8    fcb   $AB,$10,$9E,$A7,$86,$3D,$17,$01   +..'.=..
L04D0    fcb   $36,$86,$3F,$17,$01,$31,$86,$20   6.?..1. 
L04D8    fcb   $9E,$80,$A7,$80,$6A,$E4,$2A,$FA   ..'.jd*z
L04E0    fcb   $CC,$5E,$0D,$ED,$1F,$9E,$80,$8D   L^.m....
L04E8    fcb   $0C,$35,$06,$17,$FF,$92,$9E,$46   .5.....F
L04F0    fcb   $9F,$44,$16,$FF,$91,$10,$8E,$01   .D......
L04F8    fcb   $00,$96,$2E,$10,$3F,$8C,$39,$10   ....?.9.
L0500    fcb   $9F,$A7,$9E,$4A,$9F,$AF,$9F,$AB   .'.J./.+
L0508    fcb   $0F,$BB,$0F,$BC,$39,$8D,$F0,$0C   .;.<9.p.
L0510    fcb   $A0,$17,$00,$2E,$8D,$0D,$0F,$A0    ...... 
L0518    fcb   $96,$A3,$81,$3F,$10,$26,$FF,$8B   .#.?.&..
L0520    fcb   $16,$00,$E4,$81,$4D,$26,$1A,$8D   ..d.M&..
L0528    fcb   $F7,$DC,$AB,$17,$00,$3D,$D6,$A4   w\+..=V$
L0530    fcb   $C1,$06,$26,$0D,$17,$00,$0B,$17   A.&.....
L0538    fcb   $00,$12,$27,$EB,$34,$02,$16,$00   ..'k4...
L0540    fcb   $1C,$39,$17,$00,$26,$9E,$AD,$9F   .9..&.-.
L0548    fcb   $AB,$96,$A3,$39,$96,$A3,$81,$4B   +.#9.#.K
L0550    fcb   $39,$39,$96,$A3,$81,$4E,$27,$F9   99.#.N'y
L0558    fcb   $86,$25,$16,$FF,$50,$8D,$F3,$35   .%..P.s5
L0560    fcb   $02,$17,$00,$A3,$16,$FF,$DB,$86   ...#..[.
L0568    fcb   $0A,$20,$EF,$DC,$AB,$DD,$AD,$17   . o\+]-.
L0570    fcb   $00,$DD,$10,$9F,$B9,$A6,$A4,$17   .]..9&$.
L0578    fcb   $00,$E6,$24,$24,$30,$8D,$FF,$0F   .f$$0...
L0580    fcb   $86,$80,$17,$01,$23,$27,$E0,$E6   ....#'`f
L0588    fcb   $84,$33,$8C,$37,$6E,$C5,$EC,$01   .3.7nEl.
L0590    fcb   $D7,$A4,$97,$A3,$16,$00,$70,$A6   W$.#..p&
L0598    fcb   $A4,$17,$00,$C4,$25,$F0,$31,$3F   $..D%p1?
L05A0    fcb   $8D,$2A,$26,$11,$CC,$8F,$05,$97   .*&.L...
L05A8    fcb   $A3,$8D,$51,$A6,$80,$5A,$2A,$F9   #.Q&.Z*y
L05B0    fcb   $86,$06,$97,$A4,$39,$CC,$8E,$02   ...$9L..
L05B8    fcb   $6D,$84,$26,$EB,$CC,$8D,$01,$30   m.&kL..0
L05C0    fcb   $01,$20,$E4,$31,$3F,$8D,$05,$CC   . d1?..L
L05C8    fcb   $91,$02,$20,$DB,$17,$00,$80,$30   .. [...0
L05D0    fcb   $A4,$10,$9E,$44,$17,$FE,$B2,$1E   $..D..2.
L05D8    fcb   $12,$25,$05,$A6,$80,$81,$02,$39   .%.&...9
L05E0    fcb   $86,$16,$20,$1C,$8D,$A8,$20,$02   .. ..( .
L05E8    fcb   $8D,$1D,$A6,$A0,$81,$0D,$27,$0E   ..& ..'.
L05F0    fcb   $81,$22,$26,$F4,$A1,$A0,$27,$F0   ."&t! 'p
L05F8    fcb   $31,$3F,$86,$FF,$20,$09,$86,$29   1?.. ..)
L0600    fcb   $16,$FE,$AA,$86,$31,$20,$F9,$34   ..*.1 y4
L0608    fcb   $16,$9E,$AB,$A7,$80,$9F,$AB,$DC   ..+'..+\
L0610    fcb   $AB,$93,$4A,$C1,$FF,$24,$03,$4F   +.JA.$.O
L0618    fcb   $35,$96,$86,$0D,$17,$FE,$61,$16   5.....a.
L0620    fcb   $FE,$64,$8D,$2B,$34,$20,$C6,$02   .d.+4 F.
L0628    fcb   $D7,$A5,$5F,$8D,$3D,$25,$1C,$31   W%_.=%.1
L0630    fcb   $21,$5C,$A6,$A0,$8D,$26,$24,$F9   !\& .&$y
L0638    fcb   $81,$24,$26,$07,$5C,$31,$21,$86   .$&.\1!.
L0640    fcb   $04,$97,$A5,$31,$3F,$86,$80,$AA   ..%1?..*
L0648    fcb   $3F,$A7,$3F,$D7,$A6,$35,$A0,$A6   ?'?W&5 &
L0650    fcb   $A0,$81,$20,$27,$FA,$81,$0A,$27    . 'z..'
L0658    fcb   $F6,$31,$3F,$39,$8D,$0C,$24,$25   v1?9..$%
L0660    fcb   $81,$30,$25,$21,$81,$39,$23,$1B   .0%!.9#.
L0668    fcb   $20,$16,$84,$7F,$81,$41,$25,$15    ...A%.
L0670    fcb   $81,$5A,$23,$0F,$81,$5F,$27,$0D   .Z#.._'.
L0678    fcb   $81,$61,$25,$09,$81,$7A,$23,$03   .a%..z#.
L0680    fcb   $1A,$01,$39,$1C,$FE,$39,$34,$16   ..9..94.
L0688    fcb   $30,$CB,$34,$10,$C5,$03,$27,$0D   0K4.E.'.
L0690    fcb   $A6,$C0,$A7,$A0,$5A,$20,$F5,$37   &@' Z u7
L0698    fcb   $16,$ED,$A1,$AF,$A1,$11,$A3,$E4   .m!/!.#d
L06A0    fcb   $25,$F5,$6F,$E1,$35,$96,$86,$20   %uoa5.. 
L06A8    fcb   $34,$72,$EE,$1D,$E6,$1F,$AF,$61   4rn.f./a
L06B0    fcb   $11,$83,$00,$00,$27,$20,$33,$5F   ....' 3_
L06B8    fcb   $10,$AE,$63,$30,$85,$A6,$80,$A8   ..c0.&.(
L06C0    fcb   $A0,$27,$0C,$A1,$E4,$27,$08,$30    '.!d'.0
L06C8    fcb   $1F,$A6,$80,$2A,$FC,$20,$DF,$6D   .&.*. _m
L06D0    fcb   $1F,$2A,$EA,$10,$AF,$63,$35,$F2   .*j./c5r
L06D8    fcb   $34,$16,$E6,$F8,$04,$30,$8C,$08   4.fx.0..
L06E0    fcb   $EC,$85,$30,$8B,$AF,$64,$35,$96   l.0./d5.
L06E8    fcb   $00,$02,$39,$34,$16,$E6,$F8,$04   ..94.fx.
L06F0    fcb   $30,$8C,$08,$EC,$85,$30,$8B,$AF   0..l.0./
L06F8    fcb   $64,$35,$96,$09,$DA,$00,$D9,$09   d5..Z.Y.
L0700    fcb   $3A,$07,$E1,$01,$9C,$08,$44,$08   :.a...D.
L0708    fcb   $4E,$9D,$1B,$06,$9D,$1B,$0C,$9D   N.......
L0710    fcb   $1B,$0E,$9D,$1B,$02,$9D,$1B,$00   ........
L0718    fcb   $9D,$1B,$0A,$9D,$1B,$10,$9D,$1E   ........
L0720    fcb   $06,$9D,$27,$04,$9D,$27,$0A,$9D   ..'..'..
L0728    fcb   $27,$02,$9D,$27,$0C,$9D,$27,$0E   '..'..'.
L0730    fcb   $9D,$27,$00,$9D,$2A,$02,$07,$F1   .'..*..q
L0738    fcb   $07,$F1,$07,$F1,$07,$F1,$07,$F1   .q.q.q.q
L0740    fcb   $03,$8C,$03,$9D,$08,$09,$08,$13   ........
L0748    fcb   $03,$A0,$07,$FD,$08,$01,$03,$C4   . .....D
L0750    fcb   $01,$61,$02,$DA,$03,$7F,$01,$6F   .a.Z..o
L0758    fcb   $01,$7F,$01,$86,$02,$9A,$01,$9A   .......
L0760    fcb   $01,$89,$01,$7F,$01,$61,$01,$89   ....a..
L0768    fcb   $01,$61,$01,$7F,$01,$89,$01,$7F   .a....
L0770    fcb   $03,$DD,$07,$A2,$07,$F9,$01,$7F   .].".y.
L0778    fcb   $07,$F9,$03,$A4,$08,$2A,$09,$93   .y.$.*..
L0780    fcb   $04,$99,$06,$01,$07,$28,$07,$35   .....(.5
L0788    fcb   $04,$33,$04,$3C,$04,$6A,$05,$76   .3.<.j.v
L0790    fcb   $06,$8D,$06,$C2,$06,$C9,$06,$F5   ...B.I.u
L0798    fcb   $07,$02,$07,$1B,$07,$4B,$07,$67   .....K.g
L07A0    fcb   $07,$DD,$07,$E0,$07,$E8,$07,$E8   .].`.h.h
L07A8    fcb   $01,$4A,$01,$5F,$01,$5F,$07,$EE   .J._._.n
L07B0    fcb   $07,$F9,$01,$5E,$01,$5E,$02,$FE   .y.^.^..
L07B8    fcb   $03,$0D,$03,$1C,$02,$FE,$03,$35   .......5
L07C0    fcb   $03,$68,$53,$54,$4F,$50,$20,$45   .hSTOP E
L07C8    fcb   $6E,$63,$6F,$75,$6E,$74,$65,$72   ncounter
L07D0    fcb   $65,$64,$0A,$FF,$A6,$88,$17,$85   ed..&...
L07D8    fcb   $01,$27,$04,$C6,$33,$20,$1C,$1F   .'.F3 ..
L07E0    fcb   $40,$83,$01,$00,$10,$93,$80,$24   @......$
L07E8    fcb   $04,$C6,$39,$20,$0E,$DC,$0C,$A3   .F9 .\.#
L07F0    fcb   $0B,$25,$06,$10,$83,$01,$00,$24   .%.....$
L07F8    fcb   $05,$C6,$20,$16,$06,$DE,$DD,$0C   .F ..^].
L0800    fcb   $1F,$20,$A3,$0B,$1E,$03,$10,$EF   . #....o
L0808    fcb   $45,$ED,$47,$AF,$43,$CC,$00,$01   EmG/CL..
L0810    fcb   $DD,$42,$A7,$41,$A7,$C8,$13,$EF   ]B'A'H.o
L0818    fcb   $C8,$14,$8D,$2C,$EC,$88,$13,$27   H..,l..'
L0820    fcb   $02,$D3,$5E,$DD,$39,$EC,$0B,$31   .S^]9l.1
L0828    fcb   $CB,$34,$20,$EC,$88,$11,$31,$CB   K4 l..1K
L0830    fcb   $4F,$5F,$20,$02,$ED,$A1,$10,$AC   O_ .m!.,
L0838    fcb   $E4,$25,$F9,$32,$62,$9E,$2F,$DC   d%y2b./\
L0840    fcb   $5E,$E3,$88,$15,$1F,$01,$20,$32   ^c.... 2
L0848    fcb   $9F,$2F,$DF,$31,$EC,$0D,$D3,$2F   ./_1l.S/
L0850    fcb   $DD,$62,$EC,$0F,$D3,$2F,$DD,$66   ]bl.S/]f
L0858    fcb   $DD,$60,$EC,$09,$D3,$2F,$DD,$5E   ]`l.S/]^
L0860    fcb   $EC,$C8,$14,$DD,$46,$DD,$44,$39   lH.]F]D9
L0868    fcb   $9F,$5C,$96,$34,$27,$0A,$2A,$08   .\.4'.*.
L0870    fcb   $84,$7F,$97,$34,$D6,$35,$20,$83   ..4V5 .
L0878    fcb   $8D,$1D,$9C,$60,$25,$EA,$20,$0A   ...`%j .
L0880    fcb   $E6,$84,$17,$04,$AB,$27,$03,$17   f...+'..
L0888    fcb   $04,$AD,$17,$06,$BC,$DE,$31,$10   .-..<^1.
L0890    fcb   $EE,$45,$EE,$47,$39,$30,$02,$E6   nEnG90.f
L0898    fcb   $80,$2A,$02,$CB,$40,$58,$4F,$DE   .*.K@XO^
L08A0    fcb   $0E,$EC,$CB,$6E,$CB,$9D,$16,$6D   .lKnK..m
L08A8    fcb   $22,$27,$0A,$30,$03,$E6,$84,$C1   "'.0.f.A
L08B0    fcb   $3B,$26,$E1,$30,$01,$EC,$84,$D3   ;&a0.l.S
L08B8    fcb   $5E,$1F,$01,$39,$30,$01,$39,$9D   ^..90.9.
L08C0    fcb   $16,$6D,$22,$27,$F0,$30,$03,$39   .m"'p0.9
L08C8    fcb   $00,$26,$00,$3F,$00,$7B,$00,$C6   .&.?.{.F
L08D0    fcb   $31,$8C,$F5,$E6,$80,$58,$EC,$A5   1.uf.Xl%
L08D8    fcb   $DE,$31,$6E,$AB,$EC,$84,$31,$CB   ^1n+l.1K
L08E0    fcb   $20,$17,$EC,$84,$31,$CB,$EC,$04    .l.1Kl.
L08E8    fcb   $A6,$CB,$2A,$0D,$20,$2B,$EC,$84   &K*. +l.
L08F0    fcb   $31,$CB,$EC,$A4,$C3,$00,$01,$ED   1Kl$C..m
L08F8    fcb   $A4,$EC,$02,$30,$06,$EC,$CB,$10   $l.0.lK.
L0900    fcb   $A3,$A4,$2C,$B1,$30,$03,$39,$EC   #$,10.9l
L0908    fcb   $84,$31,$CB,$EC,$04,$EC,$CB,$34   .1Kl.lK4
L0910    fcb   $02,$E3,$A4,$ED,$A4,$6D,$E0,$2A   .c$m$m`*
L0918    fcb   $E0,$EC,$02,$30,$06,$EC,$CB,$10   `l.0.lK.
L0920    fcb   $A3,$A4,$2F,$91,$30,$03,$39,$10   #$/.0.9.
L0928    fcb   $9E,$46,$5F,$8D,$4A,$20,$38,$10   .F_.J 8.
L0930    fcb   $9E,$46,$5F,$8D,$42,$EC,$04,$C3   .F_.Bl.C
L0938    fcb   $00,$04,$DE,$31,$A6,$CB,$44,$24   ..^1&KD$
L0940    fcb   $26,$20,$72,$10,$9E,$46,$5F,$8D   & r..F_.
L0948    fcb   $2E,$31,$3A,$CC,$01,$80,$ED,$21   .1:L..m!
L0950    fcb   $4F,$5F,$ED,$23,$A7,$25,$17,$FD   O_m#'%..
L0958    fcb   $C8,$8D,$6A,$EC,$21,$ED,$C4,$EC   H.jl!mDl
L0960    fcb   $23,$ED,$42,$A6,$25,$A7,$44,$C6   #mB&%'DF
L0968    fcb   $02,$8D,$0C,$30,$06,$17,$FD,$B4   ...0...4
L0970    fcb   $10,$2F,$FF,$41,$30,$03,$39,$EC   ./.A0.9l
L0978    fcb   $85,$D3,$31,$1F,$03,$31,$3A,$86   .S1..1:.
L0980    fcb   $02,$E6,$C4,$ED,$A4,$EC,$41,$ED   .fDm$lAm
L0988    fcb   $22,$EC,$43,$ED,$24,$39,$10,$9E   "lCm$9..
L0990    fcb   $46,$5F,$8D,$E3,$DF,$D2,$C6,$04   F_.c_RF.
L0998    fcb   $8D,$DD,$A6,$44,$97,$D1,$17,$FD   .]&D.Q..
L09A0    fcb   $80,$8D,$22,$DE,$D2,$EC,$21,$ED   .."^Rl!m
L09A8    fcb   $C4,$EC,$23,$ED,$42,$A6,$25,$A7   Dl#mB&%'
L09B0    fcb   $44,$04,$D1,$24,$B2,$C6,$02,$8D   D.Q$2F..
L09B8    fcb   $BE,$30,$06,$17,$FD,$66,$10,$2C   >0...f.,
L09C0    fcb   $FE,$F3,$30,$03,$39,$D6,$34,$39   .s0.9V49
L09C8    fcb   $FF,$14,$FF,$1A,$FF,$5F,$FF,$67   ....._.g
L09D0    fcb   $E6,$80,$C1,$82,$27,$22,$8D,$6B   f.A.'".k
L09D8    fcb   $8D,$11,$E6,$1F,$C1,$47,$26,$02   ..f.AG&.
L09E0    fcb   $8D,$09,$17,$FE,$D0,$31,$8C,$E0   ....P1.`
L09E8    fcb   $16,$FE,$E8,$EC,$81,$D3,$31,$34   ..hl.S14
L09F0    fcb   $06,$9D,$16,$EC,$21,$ED,$F1,$39   ...l!mq9
L09F8    fcb   $8D,$58,$8D,$0A,$E6,$1F,$C1,$47   .X..f.AG
L0A00    fcb   $26,$E0,$8D,$02,$20,$DC,$EC,$81   &`.. \l.
L0A08    fcb   $D3,$31,$34,$06,$9D,$16,$20,$4C   S14... L
L0A10    fcb   $9D,$16,$81,$04,$25,$04,$34,$40   ....%.4@
L0A18    fcb   $DE,$3E,$34,$42,$30,$01,$9D,$16   ^>4B0...
L0A20    fcb   $35,$02,$48,$33,$8C,$02,$6E,$C6   5.H3..nF
L0A28    fcb   $20,$14,$20,$21,$20,$2E,$20,$0E    . ! . .
L0A30    fcb   $20,$4D,$20,$70,$EC,$84,$D3,$31    M pl.S1
L0A38    fcb   $34,$06,$30,$03,$9D,$16,$E6,$22   4.0...f"
L0A40    fcb   $E7,$F1,$39,$EC,$84,$D3,$31,$34   gq9l.S14
L0A48    fcb   $06,$30,$03,$9D,$16,$EC,$21,$ED   .0...l!m
L0A50    fcb   $F1,$39,$EC,$84,$D3,$31,$34,$06   q9l.S14.
L0A58    fcb   $30,$03,$9D,$16,$35,$40,$EC,$21   0...5@l!
L0A60    fcb   $ED,$C4,$EC,$23,$ED,$42,$A6,$25   mDl#mB&%
L0A68    fcb   $A7,$44,$39,$EC,$84,$D3,$66,$1F   'D9l.Sf.
L0A70    fcb   $03,$EC,$C4,$D3,$31,$34,$06,$EC   .lDS14.l
L0A78    fcb   $42,$34,$06,$30,$03,$9D,$16,$35   B4.0...5
L0A80    fcb   $46,$5D,$26,$01,$4A,$97,$3E,$10   F]&.J.>.
L0A88    fcb   $AE,$21,$10,$9F,$48,$A6,$A0,$A7   .!..H& '
L0A90    fcb   $C0,$81,$FF,$27,$07,$5A,$26,$F5   @..'.Z&u
L0A98    fcb   $0A,$3E,$2A,$F1,$4F,$39,$17,$FC   .>*qO9..
L0AA0    fcb   $86,$16,$FF,$6E,$35,$46,$10,$A3   ...n5F.#
L0AA8    fcb   $23,$23,$02,$EC,$23,$10,$AE,$21   ##.l#..!
L0AB0    fcb   $1E,$23,$16,$FC,$69,$9D,$16,$EC   .#..i..l
L0AB8    fcb   $21,$34,$06,$9D,$16,$E6,$22,$E7   !4...f"g
L0AC0    fcb   $F1,$39,$17,$02,$72,$96,$2E,$97   q9..r...
L0AC8    fcb   $7F,$30,$8D,$FC,$F5,$17,$01,$70   0..u..p
L0AD0    fcb   $16,$FC,$36,$16,$FC,$36,$17,$02   ..6..6..
L0AD8    fcb   $5E,$39,$EC,$84,$30,$03,$10,$9E   ^9l.0...
L0AE0    fcb   $31,$EE,$A8,$14,$11,$93,$4A,$22   1n(...J"
L0AE8    fcb   $05,$C6,$35,$16,$03,$EE,$AF,$C3   .F5..n/C
L0AF0    fcb   $EF,$A8,$14,$DF,$46,$D3,$5E,$1F   o(._FS^.
L0AF8    fcb   $01,$39,$10,$9E,$31,$10,$AC,$A8   .9..1.,(
L0B00    fcb   $14,$22,$05,$C6,$36,$16,$03,$D4   .".F6..T
L0B08    fcb   $EE,$A8,$14,$AE,$C1,$EF,$A8,$14   n(..Ao(.
L0B10    fcb   $DF,$46,$39,$EC,$84,$81,$1E,$27   _F9l...'
L0B18    fcb   $35,$9D,$16,$EC,$84,$58,$49,$58   5..l.XIX
L0B20    fcb   $49,$C3,$00,$02,$33,$8B,$34,$40   IC..3.4@
L0B28    fcb   $EC,$21,$2F,$20,$10,$A3,$81,$22   l!/ .#."
L0B30    fcb   $1B,$83,$00,$01,$58,$49,$58,$49   ....XIXI
L0B38    fcb   $C3,$00,$01,$EC,$8B,$34,$06,$E6   C..l.4.f
L0B40    fcb   $84,$C1,$22,$35,$16,$27,$97,$D3   .A"5.'.S
L0B48    fcb   $5E,$1F,$01,$39,$35,$90,$DE,$31   ^..95.^1
L0B50    fcb   $C1,$20,$26,$0F,$EC,$02,$D3,$5E   A &.l.S^
L0B58    fcb   $ED,$C8,$11,$86,$01,$A7,$C8,$13   mH...'H.
L0B60    fcb   $30,$05,$39,$6F,$C8,$13,$30,$02   0.9oH.0.
L0B68    fcb   $39,$8D,$1C,$C6,$0B,$10,$3F,$83   9..F..?.
L0B70    fcb   $20,$05,$8D,$13,$10,$3F,$84,$10    ....?..
L0B78    fcb   $25,$03,$61,$35,$44,$C1,$01,$26   %.a5DA.&
L0B80    fcb   $02,$6F,$C0,$A7,$C4,$35,$90,$30   .o@'D5.0
L0B88    fcb   $01,$17,$00,$CE,$30,$01,$9D,$16   ...N0...
L0B90    fcb   $86,$03,$C1,$4A,$26,$02,$A6,$81   ..AJ&.&.
L0B98    fcb   $EE,$63,$AF,$63,$AE,$21,$6E,$C4   nc/c.!nD
L0BA0    fcb   $17,$00,$F4,$9D,$16,$C6,$0E,$17   ..t..F..
L0BA8    fcb   $FB,$89,$10,$25,$03,$30,$39,$3F   ...%.09?
L0BB0    fcb   $20,$FF,$2A,$2A,$20,$49,$6E,$70    .** Inp
L0BB8    fcb   $75,$74,$20,$65,$72,$72,$6F,$72   ut error
L0BC0    fcb   $20,$2D,$20,$72,$65,$65,$6E,$74    - reent
L0BC8    fcb   $65,$72,$20,$2A,$2A,$0D,$FF,$96   er **...
L0BD0    fcb   $2E,$17,$00,$C3,$86,$2C,$97,$DD   ...C.,.]
L0BD8    fcb   $34,$10,$AE,$E4,$E6,$84,$C1,$90   4..df.A.
L0BE0    fcb   $26,$08,$9D,$16,$34,$10,$AE,$21   &...4..!
L0BE8    fcb   $20,$05,$34,$10,$30,$8C,$C0,$8D    .4.0.@.
L0BF0    fcb   $4F,$35,$10,$96,$7F,$91,$2E,$26   O5....&
L0BF8    fcb   $04,$96,$2D,$97,$7F,$C6,$06,$17   ..-.F..
L0C00    fcb   $FB,$31,$24,$0D,$C1,$03,$10,$26   .1$.A..&
L0C08    fcb   $02,$D4,$17,$02,$F7,$0F,$36,$20   .T..w.6 
L0C10    fcb   $C9,$8D,$11,$24,$07,$30,$8C,$9A   I..$.0..
L0C18    fcb   $8D,$26,$20,$BE,$E6,$80,$C1,$4B   .& >f.AK
L0C20    fcb   $27,$EF,$35,$86,$8D,$34,$E6,$E4   'o5..4fd
L0C28    fcb   $CB,$07,$10,$9E,$46,$17,$FB,$03   K...F...
L0C30    fcb   $10,$24,$FD,$EC,$A6,$E4,$81,$04   .$.l&d..
L0C38    fcb   $25,$02,$32,$62,$32,$63,$43,$39   %.2b2cC9
L0C40    fcb   $34,$20,$32,$7A,$31,$E4,$AF,$21   4 2z1d/!
L0C48    fcb   $DC,$80,$DD,$82,$C6,$05,$17,$FA   \.].F..z
L0C50    fcb   $E2,$C6,$00,$17,$FA,$DD,$32,$66   bF..z]2f
L0C58    fcb   $35,$A0,$A6,$80,$81,$0E,$26,$04   5 &...&.
L0C60    fcb   $9D,$16,$20,$25,$80,$80,$81,$04   .. %....
L0C68    fcb   $25,$15,$27,$05,$17,$FA,$B8,$20   %.'..z8 
L0C70    fcb   $18,$EC,$81,$D3,$66,$1F,$03,$EC   .l.Sf..l
L0C78    fcb   $42,$DD,$3E,$EC,$C4,$20,$02,$EC   B]>lD .l
L0C80    fcb   $81,$D3,$31,$1F,$03,$A6,$1D,$80   .S1..&..
L0C88    fcb   $80,$35,$20,$81,$04,$25,$04,$34   .5 ..%.4
L0C90    fcb   $40,$DE,$3E,$34,$42,$6E,$A4,$E6   @^>4Bn$f
L0C98    fcb   $84,$C1,$54,$26,$0C,$30,$01,$9D   .AT&.0..
L0CA0    fcb   $16,$C1,$4B,$27,$02,$30,$1F,$A6   .AK'.0.&
L0CA8    fcb   $22,$97,$7F,$39,$E6,$84,$C1,$54   ".9f.AT
L0CB0    fcb   $26,$24,$8D,$E3,$0F,$DD,$C1,$4B   &$.c.]AK
L0CB8    fcb   $26,$02,$30,$1F,$C6,$06,$17,$FA   &.0.F..z
L0CC0    fcb   $72,$24,$0C,$C1,$E4,$27,$F5,$16   r$.Ad'u.
L0CC8    fcb   $02,$14,$17,$FF,$57,$25,$F8,$E6   ....W%xf
L0CD0    fcb   $80,$C1,$4B,$27,$F5,$39,$8D,$58   .AK'u9.X
L0CD8    fcb   $27,$39,$8D,$07,$E6,$80,$C1,$4B   '9..f.AK
L0CE0    fcb   $27,$F8,$39,$17,$FF,$74,$8D,$2D   'x9..t.-
L0CE8    fcb   $A6,$E4,$26,$01,$4C,$A1,$A4,$10   &d&.L!$.
L0CF0    fcb   $27,$FD,$2D,$81,$02,$25,$06,$27   '.-..%.'
L0CF8    fcb   $10,$C6,$47,$20,$20,$A6,$A4,$81   .FG  &$.
L0D00    fcb   $02,$26,$F6,$17,$FA,$24,$16,$FD   .&v.z$..
L0D08    fcb   $17,$A1,$A4,$25,$EC,$17,$FA,$1D   .!$%l.z.
L0D10    fcb   $16,$FD,$0D,$30,$01,$34,$10,$9E   ...0.4..
L0D18    fcb   $39,$26,$05,$C6,$4F,$16,$01,$BC   9&.FO..<
L0D20    fcb   $9D,$16,$C1,$4B,$27,$06,$EC,$84   ..AK'.l.
L0D28    fcb   $D3,$5E,$1F,$01,$9F,$39,$35,$90   S^...95.
L0D30    fcb   $C1,$3F,$27,$02,$C1,$3E,$39,$96   A?'.A>9.
L0D38    fcb   $2E,$17,$FF,$5B,$DC,$80,$DD,$82   ...[\.].
L0D40    fcb   $E6,$80,$C1,$49,$27,$3E,$8D,$E8   f.AI'>.h
L0D48    fcb   $27,$22,$C1,$4B,$27,$12,$C1,$51   '"AK'.AQ
L0D50    fcb   $27,$12,$30,$1F,$9D,$16,$E6,$A4   '.0...f$
L0D58    fcb   $CB,$01,$8D,$20,$E6,$1F,$20,$E6   K.. f. f
L0D60    fcb   $C6,$0D,$8D,$18,$E6,$80,$8D,$C8   F...f..H
L0D68    fcb   $26,$E0,$20,$04,$C6,$0C,$8D,$0C   &` .F...
L0D70    fcb   $C6,$00,$8D,$08,$96,$DE,$0F,$DE   F....^.^
L0D78    fcb   $4D,$26,$06,$39,$17,$F9,$B4,$24   M&.9.y4$
L0D80    fcb   $FA,$16,$01,$5A,$9D,$16,$DC,$4A   z..Z..\J
L0D88    fcb   $DD,$8E,$DD,$8C,$DE,$46,$34,$46   ].].^F4F
L0D90    fcb   $0F,$94,$DC,$48,$DD,$4A,$E6,$1F   ..\H]Jf.
L0D98    fcb   $8D,$96,$27,$1C,$E6,$80,$8D,$90   ..'.f...
L0DA0    fcb   $27,$11,$30,$1F,$C6,$11,$17,$F9   '.0.F..y
L0DA8    fcb   $8A,$24,$EB,$35,$46,$DD,$4A,$DF   .$k5F]J_
L0DB0    fcb   $46,$20,$CE,$31,$8C,$BA,$20,$03   F N1.: .
L0DB8    fcb   $31,$8C,$B1,$35,$46,$DD,$4A,$DF   1.15F]J_
L0DC0    fcb   $46,$6E,$A4,$96,$2E,$17,$FE,$CF   Fn$....O
L0DC8    fcb   $DE,$80,$DF,$82,$E6,$80,$17,$FF   ^._.f...
L0DD0    fcb   $5F,$27,$22,$C1,$4B,$27,$0C,$30   _'"AK'.0
L0DD8    fcb   $1F,$20,$08,$4F,$C6,$12,$17,$F9   . .OF..y
L0DE0    fcb   $52,$25,$9E,$9D,$16,$E6,$A4,$CB   R%...f$K
L0DE8    fcb   $01,$17,$F9,$47,$25,$93,$E6,$1F   ..yG%.f.
L0DF0    fcb   $17,$FF,$3D,$26,$E6,$16,$FF,$74   ..=&f..t
L0DF8    fcb   $8D,$11,$10,$3F,$89,$20,$05,$8D   ...?. ..
L0E00    fcb   $0A,$10,$3F,$8A,$30,$C4,$24,$22   ..?.0D$"
L0E08    fcb   $16,$00,$D1,$17,$FE,$89,$17,$FE   ..Q.....
L0E10    fcb   $49,$33,$84,$35,$02,$81,$04,$24   I3.5...$
L0E18    fcb   $0B,$30,$8D,$02,$14,$E6,$86,$4F   .0...f.O
L0E20    fcb   $1F,$02,$20,$02,$35,$20,$35,$10   .. .5 5.
L0E28    fcb   $96,$7F,$39,$17,$FE,$69,$10,$3F   .9..i.?
L0E30    fcb   $8F,$25,$D5,$C1,$4B,$27,$F4,$39   .%UAK't9
L0E38    fcb   $E6,$80,$C1,$3B,$27,$0A,$DE,$2F   f.A;'.^/
L0E40    fcb   $EC,$C8,$13,$D3,$5E,$DD,$39,$39   lH.S^]99
L0E48    fcb   $EC,$84,$C3,$00,$01,$30,$03,$20   l.C..0. 
L0E50    fcb   $F2,$9D,$16,$34,$10,$AE,$21,$10   r..4..!.
L0E58    fcb   $3F,$87,$25,$AC,$35,$90,$9D,$16   ?.%,5...
L0E60    fcb   $86,$03,$34,$10,$AE,$21,$10,$3F   ..4..!.?
L0E68    fcb   $86,$20,$EF,$9D,$16,$86,$04,$20   . o.... 
L0E70    fcb   $F1,$17,$FD,$E6,$10,$9E,$46,$31   q..f..F1
L0E78    fcb   $3A,$D6,$7F,$4F,$ED,$21,$16,$FB   :VOm!..
L0E80    fcb   $9F,$9D,$16,$10,$AE,$21,$34,$70   .....!4p
L0E88    fcb   $17,$F8,$84,$35,$70,$8D,$32,$10   .x.5p.2.
L0E90    fcb   $DF,$B1,$10,$DE,$80,$10,$3F,$05   _1.^..?.
L0E98    fcb   $10,$DE,$B1,$20,$3F,$9D,$16,$34   .^1 ?..4
L0EA0    fcb   $50,$10,$AE,$21,$8D,$1B,$10,$3F   P..!...?
L0EA8    fcb   $03,$25,$31,$34,$02,$10,$3F,$04   .%14..?.
L0EB0    fcb   $A1,$E4,$26,$F9,$32,$61,$5D,$26   !d&y2a]&
L0EB8    fcb   $23,$35,$D0,$53,$48,$45,$4C,$4C   #5PSHELL
L0EC0    fcb   $0D,$9E,$48,$86,$0D,$A7,$1F,$1F   ..H..'..
L0EC8    fcb   $10,$30,$8D,$FF,$EE,$33,$A4,$34   .0..n3$4
L0ED0    fcb   $20,$A3,$E1,$1F,$02,$4F,$5F,$39    #a..O_9
L0ED8    fcb   $9D,$16,$E6,$22,$D7,$36,$DE,$31   ..f"W6^1
L0EE0    fcb   $27,$1A,$6D,$C8,$13,$27,$0E,$10   '.mH.'..
L0EE8    fcb   $EE,$45,$AE,$C8,$11,$EC,$C8,$14   nE.H.lH.
L0EF0    fcb   $DD,$46,$16,$F9,$73,$8D,$0D,$8D   ]F.ys...
L0EF8    fcb   $50,$16,$F8,$0D,$17,$F8,$13,$16   P.x..x..
L0F00    fcb   $F8,$07,$0E,$FF,$30,$8C,$FB,$17   x...0...
L0F08    fcb   $FD,$36,$17,$F8,$02,$D6,$36,$10   .6.x.V6.
L0F10    fcb   $3F,$06,$39,$5F,$20,$02,$C6,$01   ?.9_ .F.
L0F18    fcb   $4F,$DD,$42,$30,$01,$39,$E6,$80   O]B0.9f.
L0F20    fcb   $4F,$30,$8B,$39,$1E,$15,$39,$31   O0.9..91
L0F28    fcb   $84,$17,$F7,$EF,$30,$A4,$39,$C6   ..wo0$9F
L0F30    fcb   $33,$20,$A9,$86,$01,$20,$01,$4F   3 ).. .O
L0F38    fcb   $DE,$31,$A7,$41,$30,$01,$39,$96   ^1'A0.9.
L0F40    fcb   $34,$85,$01,$26,$1A,$8A,$01,$20   4..&... 
L0F48    fcb   $08,$96,$34,$85,$01,$27,$10,$84   ..4..'..
L0F50    fcb   $FE,$97,$34,$DC,$17,$34,$06,$DC   ..4\.4.\
L0F58    fcb   $19,$DD,$17,$35,$06,$DD,$19,$39   .].5.].9
L0F60    fcb   $17,$F7,$C4,$34,$10,$D6,$CF,$C1   .wD4.VOA
L0F68    fcb   $A0,$27,$21,$10,$9E,$48,$9E,$3E    '!..H.>
L0F70    fcb   $A6,$C0,$30,$1F,$27,$08,$A7,$A0   &@0.'.' 
L0F78    fcb   $81,$FF,$26,$F4,$A6,$A3,$8A,$80   ..&t&#..
L0F80    fcb   $A7,$A4,$10,$9E,$48,$17,$F7,$8D   '$..H.w.
L0F88    fcb   $25,$40,$33,$84,$EC,$C4,$26,$0E   %@3.lD&.
L0F90    fcb   $10,$9E,$D2,$31,$23,$17,$F7,$7D   ..R1#.w}
L0F98    fcb   $25,$30,$EC,$84,$ED,$C4,$AE,$E4   %0l.mD.d
L0FA0    fcb   $ED,$E4,$DE,$31,$96,$34,$A7,$C4   md^1.4'D
L0FA8    fcb   $D6,$43,$E7,$42,$DC,$4A,$ED,$4D   VCgB\JmM
L0FB0    fcb   $DC,$40,$ED,$4F,$DC,$39,$ED,$49   \@mO\9mI
L0FB8    fcb   $8D,$7B,$AF,$4B,$35,$10,$A6,$06   .{/K5.&.
L0FC0    fcb   $27,$37,$81,$22,$27,$33,$81,$21   '7."'3.!
L0FC8    fcb   $27,$05,$C6,$2B,$16,$FF,$0D,$EC   '.F+...l
L0FD0    fcb   $45,$34,$06,$10,$EF,$45,$32,$A4   E4..oE2$
L0FD8    fcb   $DC,$40,$34,$20,$A3,$E1,$44,$56   \@4 #aDV
L0FE0    fcb   $44,$56,$34,$06,$EC,$09,$31,$8D   DV4.l.1.
L0FE8    fcb   $F7,$EA,$AD,$8B,$DE,$31,$10,$EE   wj-.^1.n
L0FF0    fcb   $45,$35,$10,$AF,$45,$24,$1B,$20   E5./E$. 
L0FF8    fcb   $D3,$17,$FF,$4D,$96,$34,$84,$7F   S..M.4.
L1000    fcb   $97,$34,$17,$F7,$CF,$A6,$C4,$85   .4.wO&D.
L1008    fcb   $01,$27,$07,$17,$FF,$31,$A6,$C4   .'...1&D
L1010    fcb   $97,$34,$EC,$4D,$DD,$4A,$EC,$4F   .4lM]JlO
L1018    fcb   $DD,$40,$EC,$49,$DD,$39,$E6,$42   ]@lI]9fB
L1020    fcb   $1D,$DD,$42,$AE,$43,$17,$F8,$20   .]B.C.x 
L1028    fcb   $AE,$4B,$DC,$44,$93,$4A,$DD,$0C   .K\D.J].
L1030    fcb   $39,$01,$02,$05,$01,$34,$40,$E6   9....4@f
L1038    fcb   $80,$4F,$34,$12,$C1,$4D,$26,$77   .O4.AM&w
L1040    fcb   $31,$E4,$34,$20,$E6,$84,$C1,$0E   1d4 f.A.
L1048    fcb   $27,$2F,$9D,$16,$30,$1F,$81,$02   '/..0...
L1050    fcb   $27,$0A,$81,$04,$27,$13,$EC,$21   '...'.l!
L1058    fcb   $ED,$24,$A6,$A4,$C6,$06,$33,$8C   m$&$F.3.
L1060    fcb   $D0,$E0,$C6,$33,$A5,$DF,$46,$20   P`F3%_F 
L1068    fcb   $14,$EE,$21,$DC,$48,$93,$4A,$DD   .n!\H.J]
L1070    fcb   $3E,$DC,$48,$DD,$4A,$86,$04,$20   >\H]J.. 
L1078    fcb   $04,$30,$01,$9D,$16,$35,$20,$6C   .0...5 l
L1080    fcb   $A4,$81,$04,$25,$04,$34,$40,$DE   $..%.4@^
L1088    fcb   $3E,$34,$42,$E6,$80,$C1,$4B,$27   >4Bf.AK'
L1090    fcb   $B1,$30,$01,$AF,$21,$30,$8C,$99   10./!0..
L1098    fcb   $DE,$46,$DF,$40,$35,$04,$C1,$04   ^F_@5.A.
L10A0    fcb   $25,$04,$35,$06,$20,$03,$E6,$85   %.5. .f.
L10A8    fcb   $4F,$ED,$C3,$35,$06,$ED,$C3,$6A   OmC5.mCj
L10B0    fcb   $A4,$26,$E9,$31,$C4,$20,$06,$10   $&i1D ..
L10B8    fcb   $9E,$46,$10,$9F,$40,$1F,$20,$93   .F..@. .
L10C0    fcb   $4A,$10,$25,$F7,$34,$DD,$0C,$35   J.%w4].5
L10C8    fcb   $D2,$9D,$16,$10,$AE,$21,$34,$10   R....!4.
L10D0    fcb   $17,$F6,$45,$35,$90,$17,$F6,$58   .vE5..vX
L10D8    fcb   $30,$8D,$F6,$5A,$9F,$0E,$39,$34   0.vZ..94
L10E0    fcb   $16,$E6,$F8,$04,$30,$8C,$08,$EC   .fx.0..l
L10E8    fcb   $85,$30,$8B,$AF,$64,$35,$96,$14   .0./d5..
L10F0    fcb   $34,$01,$64,$03,$95,$04,$B7,$06   4.d...7.
L10F8    fcb   $18,$08,$2D,$09,$1F,$08,$E7,$9D   ..-...g.
L1100    fcb   $1B,$08,$9D,$24,$06,$9D,$2A,$02   ...$..*.
L1108    fcb   $12,$69,$12,$2D,$12,$45,$12,$12   .i.-.E..
L1110    fcb   $12,$EF,$12,$F3,$13,$43,$13,$17   .o.s.C..
L1118    fcb   $08,$86,$08,$EB,$08,$F2,$08,$4E   ...k.r.N
L1120    fcb   $08,$7F,$06,$E0,$01,$F3,$02,$EF   ..`.s.o
L1128    fcb   $06,$CB,$06,$D1,$06,$D7,$07,$4A   .K.Q.W.J
L1130    fcb   $07,$8E,$07,$1C,$07,$22,$07,$70   .....".p
L1138    fcb   $06,$FE,$07,$32,$07,$7C,$07,$10   ...2.|..
L1140    fcb   $07,$68,$07,$3A,$07,$82,$07,$0A   .h.:....
L1148    fcb   $07,$60,$07,$42,$07,$88,$07,$16   .`.B....
L1150    fcb   $07,$2A,$07,$76,$07,$04,$01,$FA   .*.v...z
L1158    fcb   $02,$FC,$08,$30,$02,$03,$02,$F6   ...0...v
L1160    fcb   $02,$0C,$04,$17,$02,$67,$05,$78   .....g.x
L1168    fcb   $06,$81,$06,$81,$00,$B7,$00,$B7   .....7.7
L1170    fcb   $00,$B7,$00,$B7,$00,$BD,$00,$BD   .7.7.=.=
L1178    fcb   $00,$BD,$00,$BD,$00,$00,$00,$00   .=.=....
L1180    fcb   $00,$00,$00,$00,$00,$00,$00,$00   ........
L1188    fcb   $01,$CC,$01,$E2,$02,$D8,$06,$B9   .L.b.X.9
L1190    fcb   $08,$12,$00,$A4,$00,$A4,$00,$A4   ...$.$.$
L1198    fcb   $00,$A4,$00,$B3,$00,$B3,$00,$B3   .$.3.3.3
L11A0    fcb   $00,$B3,$01,$C8,$01,$DE,$02,$C7   .3.H.^.G
L11A8    fcb   $07,$E2,$01,$DE,$0A,$8A,$0A,$8A   .b.^....
L11B0    fcb   $0A,$9C,$0A,$9C,$09,$3C,$09,$2E   .....<..
L11B8    fcb   $09,$ED,$09,$F5,$11,$25,$0E,$4E   .m.u.%.N
L11C0    fcb   $12,$C2,$09,$20,$09,$12,$0D,$CD   .B. ...M
L11C8    fcb   $0D,$FA,$0E,$08,$0C,$72,$0C,$B3   .z...r.3
L11D0    fcb   $0D,$4E,$0B,$AF,$09,$00,$08,$F9   .N./...y
L11D8    fcb   $0A,$F6,$0A,$EA,$09,$40,$09,$40   .v.j.@.@
L11E0    fcb   $08,$4E,$0A,$11,$09,$3B,$08,$86   .N...;..
L11E8    fcb   $08,$4E,$09,$3B,$0A,$50,$0A,$59   .N.;.P.Y
L11F0    fcb   $09,$0B,$0A,$C5,$0A,$6A,$11,$F6   ...E.j.v
L11F8    fcb   $12,$08,$0A,$CA,$0A,$DA,$0A,$D2   ...J.Z.R
L1200    fcb   $0A,$B4,$0A,$B9,$13,$80,$12,$AA   .4.9...*
L1208    fcb   $01,$52,$01,$68,$02,$5E,$06,$3F   .R.h.^.?
L1210    fcb   $07,$A2,$07,$C1,$10,$9E,$46,$DC   .".A..F\
L1218    fcb   $4A,$DD,$48,$20,$07,$58,$DE,$10   J]H .X^.
L1220    fcb   $EC,$C5,$AD,$CB,$E6,$80,$2B,$F5   lE-Kf.+u
L1228    fcb   $4F,$A6,$A4,$39,$8D,$25,$34,$C0   O&$9.%4@
L1230    fcb   $DE,$12,$48,$EC,$C6,$33,$CB,$EF   ^.HlF3Ko
L1238    fcb   $62,$35,$C0,$8D,$0E,$20,$EF,$32   b5@.. o2
L1240    fcb   $62,$86,$F2,$20,$10,$32,$62,$86   b.r .2b.
L1248    fcb   $F6,$20,$02,$86,$89,$97,$A3,$0F   v ....#.
L1250    fcb   $3B,$20,$06,$86,$85,$97,$A3,$97   ; ....#.
L1258    fcb   $3B,$EC,$81,$D3,$62,$DD,$D2,$DE   ;l.Sb]R^
L1260    fcb   $D2,$A6,$C4,$84,$E0,$97,$CF,$88   R&D.`.O.
L1268    fcb   $80,$97,$CE,$A6,$C4,$84,$07,$E6   ..N&D..f
L1270    fcb   $1D,$D0,$A3,$34,$06,$A6,$C4,$84   .P#4.&D.
L1278    fcb   $18,$10,$27,$00,$95,$EC,$41,$D3   ..'..lAS
L1280    fcb   $66,$1F,$03,$EC,$C4,$DD,$3C,$A6   f..lD]<&
L1288    fcb   $61,$26,$0C,$86,$05,$A7,$E4,$EC   a&...'dl
L1290    fcb   $42,$DD,$3E,$4F,$5F,$20,$53,$31   B]>O_ S1
L1298    fcb   $3A,$4F,$5F,$ED,$21,$33,$44,$20   :O_m!3D 
L12A0    fcb   $07,$EC,$C4,$ED,$21,$17,$00,$EC   .lDm!..l
L12A8    fcb   $EC,$27,$93,$42,$10,$A3,$C1,$25   l'.B.#A%
L12B0    fcb   $05,$C6,$37,$16,$FE,$4C,$E3,$21   .F7..Lc!
L12B8    fcb   $ED,$27,$6A,$61,$26,$E3,$A6,$E4   m'ja&c&d
L12C0    fcb   $27,$10,$81,$02,$25,$10,$27,$16   '...%.'.
L12C8    fcb   $81,$04,$25,$06,$EC,$C4,$DD,$3E   ..%.lD]>
L12D0    fcb   $20,$0F,$EC,$27,$20,$04,$EC,$27    .l' .l'
L12D8    fcb   $58,$49,$31,$2C,$20,$0C,$CC,$00   XI1, .L.
L12E0    fcb   $05,$ED,$21,$17,$00,$AE,$EC,$21   .m!...l!
L12E8    fcb   $31,$26,$0D,$CE,$26,$18,$34,$06   1&.N&.4.
L12F0    fcb   $DC,$3C,$D3,$31,$10,$93,$40,$24   \<S1..@$
L12F8    fcb   $52,$1F,$03,$35,$06,$10,$A3,$42   R..5..#B
L1300    fcb   $22,$49,$E3,$C4,$20,$40,$D3,$3C   "IcD @S<
L1308    fcb   $0D,$3B,$26,$38,$E3,$21,$31,$26   .;&8c!1&
L1310    fcb   $20,$34,$A6,$E4,$81,$04,$EC,$41    4&d..lA
L1318    fcb   $25,$0A,$D3,$66,$1F,$03,$EC,$42   %.Sf..lB
L1320    fcb   $DD,$3E,$EC,$C4,$0D,$3B,$27,$E4   ]>lD.;'d
L1328    fcb   $D3,$31,$1F,$03,$0D,$CE,$26,$18   S1...N&.
L1330    fcb   $10,$93,$40,$24,$16,$DC,$3E,$10   ..@$.\>.
L1338    fcb   $A3,$42,$25,$04,$EC,$42,$DD,$3E   #B%.lB]>
L1340    fcb   $EE,$C4,$20,$04,$D3,$31,$1F,$03   nD .S1..
L1348    fcb   $4F,$35,$86,$C6,$38,$16,$FD,$B2   O5.F8..2
L1350    fcb   $33,$80,$20,$06,$EC,$81,$D3,$31   3. .l.S1
L1358    fcb   $1F,$03,$E6,$C4,$4F,$31,$3A,$ED   ..fDO1:m
L1360    fcb   $21,$86,$01,$A7,$A4,$39,$33,$81   !..'$93.
L1368    fcb   $20,$06,$EC,$81,$D3,$31,$1F,$03    .l.S1..
L1370    fcb   $EC,$C4,$31,$3A,$ED,$21,$86,$01   lD1:m!..
L1378    fcb   $A7,$A4,$39,$4F,$5F,$A3,$21,$ED   '$9O_#!m
L1380    fcb   $21,$39,$EC,$27,$E3,$21,$31,$26   !9l'c!1&
L1388    fcb   $ED,$21,$39,$EC,$27,$A3,$21,$31   m!9l'#!1
L1390    fcb   $26,$ED,$21,$39,$EC,$27,$27,$35   &m!9l''5
L1398    fcb   $10,$83,$00,$02,$26,$04,$EC,$21   ....&.l!
L13A0    fcb   $20,$0C,$EC,$21,$27,$0A,$10,$83    .l!'...
L13A8    fcb   $00,$02,$26,$08,$EC,$27,$58,$49   ..&.l'XI
L13B0    fcb   $ED,$27,$20,$19,$A6,$28,$3D,$A7   m' .&(='
L13B8    fcb   $23,$A6,$28,$E7,$28,$E6,$21,$3D   #&(g(f!=
L13C0    fcb   $EB,$23,$A6,$27,$E7,$27,$E6,$22   k#&'g'f"
L13C8    fcb   $3D,$EB,$27,$E7,$27,$31,$26,$39   =k'g'1&9
L13D0    fcb   $6F,$A4,$EC,$27,$2A,$08,$40,$50   o$l'*.@P
L13D8    fcb   $82,$00,$ED,$27,$63,$A4,$EC,$21   ..m'c$l!
L13E0    fcb   $2A,$08,$40,$50,$82,$00,$ED,$21   *.@P..m!
L13E8    fcb   $63,$A4,$10,$83,$00,$02,$39,$8D   c$....9.
L13F0    fcb   $DF,$26,$0E,$EC,$27,$27,$17,$47   _&.l''.G
L13F8    fcb   $56,$ED,$27,$CC,$00,$00,$59,$20   Vm'L..Y 
L1400    fcb   $37,$EC,$21,$26,$05,$C6,$2D,$16   7l!&.F-.
L1408    fcb   $FC,$F8,$EC,$27,$26,$05,$31,$26   .xl'&.1&
L1410    fcb   $ED,$23,$39,$4D,$26,$08,$1E,$89   m#9M&...
L1418    fcb   $ED,$27,$C6,$08,$20,$02,$C6,$10   m'F. .F.
L1420    fcb   $E7,$23,$4F,$5F,$68,$28,$69,$27   g#O_h(i'
L1428    fcb   $59,$49,$A3,$21,$2B,$04,$6C,$28   YI#!+.l(
L1430    fcb   $20,$02,$E3,$21,$6A,$23,$26,$EC    .c!j#&l
L1438    fcb   $ED,$29,$6D,$A4,$2A,$0E,$40,$50   m)m$*.@P
L1440    fcb   $82,$00,$ED,$29,$EC,$27,$40,$50   ..m)l'@P
L1448    fcb   $82,$00,$ED,$27,$31,$26,$39,$31   ..m'1&91
L1450    fcb   $3A,$E6,$80,$86,$02,$ED,$A4,$EC   :f...m$l
L1458    fcb   $81,$ED,$22,$EC,$81,$ED,$24,$39   .m"l.m$9
L1460    fcb   $EC,$81,$D3,$31,$1F,$03,$31,$3A   l.S1..1:
L1468    fcb   $86,$02,$E6,$C4,$ED,$A4,$EC,$41   ..fDm$lA
L1470    fcb   $ED,$22,$EC,$43,$ED,$24,$39,$A6   m"lCm$9&
L1478    fcb   $25,$88,$01,$A7,$25,$39,$E6,$25   %..'%9f%
L1480    fcb   $C8,$01,$E7,$25,$34,$10,$6D,$22   H.g%4.m"
L1488    fcb   $27,$10,$6D,$28,$26,$10,$EC,$21   '.m(&.l!
L1490    fcb   $ED,$27,$EC,$23,$ED,$29,$A6,$25   m'l#m)&%
L1498    fcb   $A7,$2B,$31,$26,$35,$90,$A6,$27   '+1&5.&'
L14A0    fcb   $A0,$21,$28,$04,$2A,$E8,$20,$F2    !(.*h r
L14A8    fcb   $2B,$06,$81,$1F,$2F,$0A,$20,$EA   +.../. j
L14B0    fcb   $81,$E1,$2D,$DA,$E6,$21,$E7,$27   .a-Zf!g'
L14B8    fcb   $E6,$2B,$C4,$01,$E7,$A4,$E8,$25   f+D.g$h%
L14C0    fcb   $C4,$01,$E7,$21,$E6,$2B,$C4,$FE   D.g!f+D.
L14C8    fcb   $E7,$2B,$E6,$25,$C4,$FE,$E7,$25   g+f%D.g%
L14D0    fcb   $4D,$27,$31,$2A,$27,$40,$30,$26   M'1*'@0&
L14D8    fcb   $8D,$7B,$6D,$21,$27,$2E,$A3,$24   .{m!'.#$
L14E0    fcb   $1E,$01,$E2,$23,$A2,$22,$24,$38   ..b#""$8
L14E8    fcb   $43,$53,$1E,$01,$43,$53,$C3,$00   CS..CSC.
L14F0    fcb   $01,$1E,$01,$24,$03,$C3,$00,$01   ...$.C..
L14F8    fcb   $6A,$A4,$20,$24,$30,$A4,$8D,$55   j$ $0$.U
L1500    fcb   $AF,$22,$ED,$24,$AE,$28,$EC,$2A   /"m$.(l*
L1508    fcb   $6D,$21,$26,$D2,$E3,$24,$1E,$01   m!&Rc$..
L1510    fcb   $E9,$23,$A9,$22,$24,$0A,$46,$56   i#)"$.FV
L1518    fcb   $1E,$01,$46,$56,$6C,$27,$1E,$01   ..FVl'..
L1520    fcb   $4D,$2B,$10,$6A,$27,$10,$29,$00   M+.j'.).
L1528    fcb   $87,$1E,$01,$58,$49,$1E,$01,$59   ...XI..Y
L1530    fcb   $49,$2A,$F0,$1E,$01,$C3,$00,$01   I*p..C..
L1538    fcb   $1E,$01,$24,$08,$C3,$00,$01,$24   ..$.C..$
L1540    fcb   $03,$46,$6C,$27,$ED,$28,$1F,$10   .Fl'm(..
L1548    fcb   $C4,$FE,$6D,$A4,$27,$01,$5C,$ED   D.m$'.\m
L1550    fcb   $2A,$31,$26,$35,$90,$80,$10,$25   *1&5...%
L1558    fcb   $1A,$80,$08,$25,$07,$34,$02,$4F   ...%.4.O
L1560    fcb   $E6,$02,$20,$06,$8B,$08,$34,$02   f. ...4.
L1568    fcb   $EC,$02,$8E,$00,$00,$6D,$E4,$27   l....md'
L1570    fcb   $2B,$20,$1D,$8B,$08,$24,$0F,$34   + ...$.4
L1578    fcb   $02,$4F,$E6,$02,$AE,$03,$6D,$E4   .Of...md
L1580    fcb   $26,$10,$1E,$01,$20,$16,$8B,$08   &... ...
L1588    fcb   $34,$02,$EC,$02,$AE,$04,$20,$02   4.l... .
L1590    fcb   $1E,$01,$44,$56,$1E,$01,$46,$56   ..DV..FV
L1598    fcb   $6A,$E4,$26,$F4,$32,$61,$39,$8D   jd&t2a9.
L15A0    fcb   $05,$10,$25,$FB,$5D,$39,$34,$10   ..%.]94.
L15A8    fcb   $A6,$22,$2A,$04,$A6,$28,$2B,$0C   &"*.&(+.
L15B0    fcb   $4F,$5F,$ED,$27,$ED,$29,$A7,$2B   O_m'm)'+
L15B8    fcb   $31,$26,$35,$90,$A6,$21,$AB,$27   1&5.&!+'
L15C0    fcb   $28,$07,$2A,$EC,$53,$C6,$32,$35   (.*lSF25
L15C8    fcb   $90,$A7,$27,$E6,$2B,$E8,$25,$C4   .''f+h%D
L15D0    fcb   $01,$E7,$A4,$A6,$2B,$84,$FE,$A7   .g$&+..'
L15D8    fcb   $2B,$E6,$25,$C4,$FE,$E7,$25,$3D   +f%D.g%=
L15E0    fcb   $A7,$E2,$6F,$E2,$6F,$E2,$A6,$2B   'bobob&+
L15E8    fcb   $E6,$24,$3D,$E3,$61,$ED,$61,$24   f$=cama$
L15F0    fcb   $02,$6C,$E4,$A6,$2A,$E6,$25,$3D   .ld&*f%=
L15F8    fcb   $E3,$61,$ED,$61,$24,$02,$6C,$E4   cama$.ld
L1600    fcb   $E6,$62,$AE,$E4,$AF,$61,$6F,$E4   fb.d/aod
L1608    fcb   $A6,$2B,$E6,$23,$3D,$E3,$61,$ED   &+f#=cam
L1610    fcb   $61,$24,$02,$6C,$E4,$A6,$2A,$E6   a$.ld&*f
L1618    fcb   $24,$3D,$E3,$61,$ED,$61,$24,$02   $=cama$.
L1620    fcb   $6C,$E4,$A6,$29,$E6,$25,$3D,$E3   ld&)f%=c
L1628    fcb   $61,$ED,$61,$24,$02,$6C,$E4,$E6   ama$.ldf
L1630    fcb   $62,$AE,$E4,$AF,$61,$6F,$E4,$A6   b.d/aod&
L1638    fcb   $2B,$E6,$22,$3D,$E3,$61,$ED,$61   +f"=cama
L1640    fcb   $24,$02,$6C,$E4,$A6,$2A,$E6,$23   $.ld&*f#
L1648    fcb   $3D,$E3,$61,$ED,$61,$24,$02,$6C   =cama$.l
L1650    fcb   $E4,$A6,$29,$E6,$24,$3D,$E3,$61   d&)f$=ca
L1658    fcb   $ED,$61,$24,$02,$6C,$E4,$A6,$28   ma$.ld&(
L1660    fcb   $E6,$25,$3D,$E3,$61,$ED,$61,$24   f%=cama$
L1668    fcb   $02,$6C,$E4,$E6,$62,$AE,$E4,$AF   .ldfb.d/
L1670    fcb   $61,$6F,$E4,$E7,$2B,$A6,$2A,$E6   aodg+&*f
L1678    fcb   $22,$3D,$E3,$61,$ED,$61,$24,$02   "=cama$.
L1680    fcb   $6C,$E4,$A6,$29,$E6,$23,$3D,$E3   ld&)f#=c
L1688    fcb   $61,$ED,$61,$24,$02,$6C,$E4,$A6   ama$.ld&
L1690    fcb   $28,$E6,$24,$3D,$E3,$61,$ED,$61   (f$=cama
L1698    fcb   $24,$02,$6C,$E4,$E6,$62,$AE,$E4   $.ldfb.d
L16A0    fcb   $AF,$61,$6F,$E4,$E7,$2A,$A6,$29   /aodg*&)
L16A8    fcb   $E6,$22,$3D,$E3,$61,$ED,$61,$24   f"=cama$
L16B0    fcb   $02,$6C,$E4,$A6,$28,$E6,$23,$3D   .ld&(f#=
L16B8    fcb   $E3,$61,$ED,$61,$24,$02,$6C,$E4   cama$.ld
L16C0    fcb   $A6,$28,$E6,$22,$3D,$E3,$E4,$2B   &(f"=cd+
L16C8    fcb   $0C,$68,$2B,$69,$2A,$69,$62,$59   .h+i*ibY
L16D0    fcb   $49,$6A,$27,$29,$19,$ED,$28,$A6   Ij').m(&
L16D8    fcb   $62,$E6,$2A,$C3,$00,$01,$24,$13   bf*C..$.
L16E0    fcb   $6C,$29,$26,$11,$6C,$28,$26,$0D   l)&.l(&.
L16E8    fcb   $66,$28,$6C,$27,$28,$07,$32,$63   f(l'(.2c
L16F0    fcb   $16,$FE,$CF,$C4,$FE,$EA,$A4,$ED   ..OD.j$m
L16F8    fcb   $2A,$31,$26,$32,$63,$5F,$35,$90   *1&2c_5.
L1700    fcb   $8D,$05,$10,$25,$F9,$FC,$39,$53   ...%y.9S
L1708    fcb   $C6,$2D,$6D,$22,$27,$F8,$34,$10   F-m"'x4.
L1710    fcb   $6D,$28,$10,$27,$FE,$9A,$A6,$27   m(.'..&'
L1718    fcb   $A0,$21,$10,$29,$FE,$A4,$A7,$27    !.).$''
L1720    fcb   $86,$21,$E6,$25,$E8,$2B,$C4,$01   .!f%h+D.
L1728    fcb   $ED,$A4,$64,$22,$66,$23,$66,$24   m$d"f#f$
L1730    fcb   $66,$25,$EC,$28,$AE,$2A,$44,$56   f%l(.*DV
L1738    fcb   $1E,$01,$46,$56,$6F,$2B,$20,$02   ..FVo+ .
L1740    fcb   $1E,$01,$A3,$24,$1E,$01,$24,$03   ..#$..$.
L1748    fcb   $83,$00,$01,$A3,$22,$27,$2F,$2B   ...#"'/+
L1750    fcb   $29,$1A,$01,$6A,$A4,$27,$74,$69   )..j$'ti
L1758    fcb   $2B,$69,$2A,$69,$29,$69,$28,$1E   +i*i)i(.
L1760    fcb   $01,$58,$49,$1E,$01,$59,$49,$24   .XI..YI$
L1768    fcb   $D7,$1E,$01,$E3,$24,$1E,$01,$24   W..c$..$
L1770    fcb   $03,$C3,$00,$01,$E3,$22,$27,$06   .C..c"'.
L1778    fcb   $2A,$D7,$1C,$FE,$20,$D5,$30,$84   *W.. U0.
L1780    fcb   $26,$CF,$E6,$A4,$5A,$C0,$10,$2D   &Of$Z@.-
L1788    fcb   $17,$C0,$08,$2D,$08,$E7,$A4,$A6   .@.-.g$&
L1790    fcb   $2B,$C6,$80,$20,$29,$CB,$08,$E7   +F. )K.g
L1798    fcb   $A4,$CC,$80,$00,$AE,$2A,$20,$20   $L...*  
L17A0    fcb   $CB,$08,$2D,$0A,$E7,$A4,$AE,$29   K.-.g$.)
L17A8    fcb   $A6,$2B,$C6,$80,$20,$12,$CB,$07   &+F. .K.
L17B0    fcb   $E7,$A4,$AE,$28,$EC,$2A,$1A,$01   g$.(l*..
L17B8    fcb   $59,$49,$1E,$01,$59,$49,$1E,$01   YI..YI..
L17C0    fcb   $1C,$FE,$6A,$A4,$2A,$F2,$1E,$01   ..j$*r..
L17C8    fcb   $4D,$20,$04,$AE,$2A,$EC,$28,$2B   M ..*l(+
L17D0    fcb   $0E,$1E,$01,$59,$49,$1E,$01,$59   ...YI..Y
L17D8    fcb   $49,$6A,$27,$10,$29,$FD,$D1,$1E   Ij'.).Q.
L17E0    fcb   $01,$C3,$00,$01,$1E,$01,$24,$0C   .C....$.
L17E8    fcb   $C3,$00,$01,$24,$07,$46,$6C,$27   C..$.Fl'
L17F0    fcb   $10,$29,$FD,$CE,$ED,$28,$1F,$10   .).Nm(..
L17F8    fcb   $C4,$FE,$EA,$21,$ED,$2A,$6C,$27   D.j!m*l'
L1800    fcb   $10,$29,$FD,$BE,$31,$26,$5F,$35   .).>1&_5
L1808    fcb   $90,$34,$10,$EC,$27,$27,$F5,$AE   .4.l''u.
L1810    fcb   $21,$26,$0F,$31,$26,$CC,$01,$80   !&.1&L..
L1818    fcb   $ED,$21,$6F,$23,$6F,$24,$6F,$25   m!o#o$o%
L1820    fcb   $35,$90,$ED,$21,$AF,$27,$EC,$29   5.m!/'l)
L1828    fcb   $AE,$23,$ED,$23,$AF,$29,$A6,$2B   .#m#/)&+
L1830    fcb   $E6,$25,$A7,$25,$E7,$2B,$35,$10   f%'%g+5.
L1838    fcb   $17,$04,$43,$17,$FD,$61,$16,$04   ..C..a..
L1840    fcb   $F6,$EC,$81,$D3,$31,$1F,$03,$E6   vl.S1..f
L1848    fcb   $C4,$4F,$31,$3A,$ED,$21,$86,$03   DO1:m!..
L1850    fcb   $A7,$A4,$39,$E6,$28,$E4,$22,$20   '$9f(d" 
L1858    fcb   $0A,$E6,$28,$EA,$22,$20,$04,$E6   .f(j" .f
L1860    fcb   $28,$E8,$22,$31,$26,$ED,$21,$39   (h"1&m!9
L1868    fcb   $63,$22,$39,$34,$30,$AE,$21,$10   c"940.!.
L1870    fcb   $AE,$27,$10,$9F,$48,$A6,$A0,$A1   .'..H& !
L1878    fcb   $80,$26,$04,$81,$FF,$26,$F6,$4C   .&...&vL
L1880    fcb   $6C,$1F,$A1,$1F,$35,$B0,$8D,$E3   l.!.50.c
L1888    fcb   $25,$4E,$20,$50,$8D,$DD,$23,$48   %N P.]#H
L1890    fcb   $20,$4A,$8D,$D7,$27,$42,$20,$44    J.W'B D
L1898    fcb   $8D,$D1,$26,$3C,$20,$3E,$8D,$CB   .Q&< >.K
L18A0    fcb   $24,$36,$20,$38,$8D,$C5,$22,$30   $6 8.E"0
L18A8    fcb   $20,$32,$EC,$27,$A3,$21,$2D,$28    2l'#!-(
L18B0    fcb   $20,$2A,$EC,$27,$A3,$21,$2F,$20    *l'#!/ 
L18B8    fcb   $20,$22,$EC,$27,$A3,$21,$26,$18    "l'#!&.
L18C0    fcb   $20,$1A,$EC,$27,$A3,$21,$27,$10    .l'#!'.
L18C8    fcb   $20,$12,$EC,$27,$A3,$21,$2C,$08    .l'#!,.
L18D0    fcb   $20,$0A,$EC,$27,$A3,$21,$2F,$04    .l'#!/.
L18D8    fcb   $C6,$FF,$20,$02,$C6,$00,$4F,$31   F. .F.O1
L18E0    fcb   $26,$ED,$21,$86,$03,$A7,$A4,$39   &m!..'$9
L18E8    fcb   $E6,$28,$E1,$22,$27,$EA,$20,$EC   f(a"'j l
L18F0    fcb   $E6,$28,$E1,$22,$26,$E2,$20,$E4   f(a"&b d
L18F8    fcb   $8D,$22,$2D,$DC,$20,$DE,$8D,$1C   ."-\ ^..
L1900    fcb   $2F,$D6,$20,$D8,$8D,$16,$26,$D0   /V X..&P
L1908    fcb   $20,$D2,$8D,$10,$27,$CA,$20,$CC    R..'J L
L1910    fcb   $8D,$0A,$2C,$C4,$20,$C6,$8D,$04   ..,D F..
L1918    fcb   $2E,$BE,$20,$C0,$34,$20,$1C,$F0   .> @4 .p
L1920    fcb   $A6,$28,$26,$10,$A6,$22,$27,$0A   &(&.&"'.
L1928    fcb   $A6,$25,$84,$01,$26,$04,$1C,$F0   &%..&..p
L1930    fcb   $1A,$08,$35,$A0,$A6,$22,$26,$06   ..5 &"&.
L1938    fcb   $A6,$2B,$88,$01,$20,$EC,$A6,$2B   &+.. l&+
L1940    fcb   $A8,$25,$84,$01,$26,$E2,$33,$26   (%..&b3&
L1948    fcb   $A6,$25,$84,$01,$27,$02,$1E,$32   &%..'..2
L1950    fcb   $EC,$41,$10,$A3,$21,$26,$DB,$EC   lA.#!&[l
L1958    fcb   $43,$10,$A3,$23,$26,$06,$A6,$45   C.##&.&E
L1960    fcb   $A1,$25,$27,$CE,$25,$C8,$1C,$F0   !%'N%H.p
L1968    fcb   $35,$A0,$5F,$D7,$3E,$DE,$48,$31   5 _W>^H1
L1970    fcb   $3A,$EF,$21,$10,$9F,$44,$11,$93   :o!..D..
L1978    fcb   $44,$24,$1A,$A6,$80,$A7,$C0,$81   D$.&.'@.
L1980    fcb   $FF,$27,$0B,$5A,$26,$F0,$0A,$3E   .'.Z&p.>
L1988    fcb   $2A,$EC,$86,$FF,$A7,$C0,$DF,$48   *l..'@_H
L1990    fcb   $86,$04,$A7,$A4,$39,$C6,$2F,$16   ..'$9F/.
L1998    fcb   $F7,$68,$EC,$81,$D3,$66,$1F,$03   whl.Sf..
L19A0    fcb   $EC,$C4,$D3,$31,$EE,$42,$DF,$3E   lDS1nB_>
L19A8    fcb   $1F,$03,$34,$10,$D6,$3F,$26,$02   ..4.V?&.
L19B0    fcb   $0A,$3E,$30,$C4,$8D,$B7,$35,$90   .>0D.75.
L19B8    fcb   $EE,$21,$31,$26,$A6,$C0,$A7,$5E   n!1&&@'^
L19C0    fcb   $81,$FF,$26,$F8,$33,$5F,$DF,$48   ..&x3__H
L19C8    fcb   $39,$DC,$3E,$31,$3A,$ED,$23,$EF   9\>1:m#o
L19D0    fcb   $21,$86,$05,$A7,$A4,$39,$4F,$5F   !..'$9O_
L19D8    fcb   $ED,$24,$EC,$21,$26,$07,$E7,$23   m$l!&.g#
L19E0    fcb   $86,$02,$A7,$A4,$39,$CE,$02,$10   ..'$9N..
L19E8    fcb   $4D,$2A,$06,$40,$50,$82,$00,$6C   M*.@P..l
L19F0    fcb   $25,$4D,$26,$05,$CE,$02,$08,$1E   %M&.N...
L19F8    fcb   $89,$4D,$2B,$06,$33,$5F,$58,$49   .M+.3_XI
L1A00    fcb   $2A,$FA,$ED,$22,$EF,$A4,$39,$31   *zm"o$91
L1A08    fcb   $26,$8D,$CB,$31,$3A,$39,$E6,$21   &.K1:9f!
L1A10    fcb   $2E,$0F,$2B,$09,$A6,$22,$2A,$05   ..+.&"*.
L1A18    fcb   $CC,$00,$01,$20,$47,$4F,$5F,$20   L.. GO_ 
L1A20    fcb   $4B,$C0,$10,$22,$3A,$26,$12,$EC   K@.":&.l
L1A28    fcb   $22,$66,$25,$24,$3F,$10,$83,$80   "f%$?...
L1A30    fcb   $00,$26,$2C,$6D,$24,$2A,$35,$20   .&,m$*5 
L1A38    fcb   $26,$C1,$F8,$22,$0E,$34,$04,$EC   &Ax".4.l
L1A40    fcb   $22,$ED,$23,$6F,$22,$35,$04,$CB   "m#o"5.K
L1A48    fcb   $08,$27,$09,$64,$22,$66,$23,$66   .'.d"f#f
L1A50    fcb   $24,$5C,$26,$F7,$EC,$22,$6D,$24   $\&wl"m$
L1A58    fcb   $2A,$0A,$C3,$00,$01,$28,$05,$C6   *.C..(.F
L1A60    fcb   $34,$16,$F6,$9E,$66,$25,$24,$04   4.v.f%$.
L1A68    fcb   $40,$50,$82,$00,$ED,$21,$86,$01   @P..m!..
L1A70    fcb   $A7,$A4,$39,$31,$26,$8D,$97,$31   '$91&..1
L1A78    fcb   $3A,$39,$31,$2C,$8D,$90,$31,$34   :91,..14
L1A80    fcb   $39,$A6,$25,$84,$FE,$A7,$25,$39   9&%..'%9
L1A88    fcb   $EC,$21,$2A,$06,$40,$50,$82,$00   l!*.@P..
L1A90    fcb   $ED,$21,$39,$4F,$E6,$B8,$01,$ED   m!9Of8.m
L1A98    fcb   $21,$39,$A6,$22,$27,$10,$A6,$25   !9&"'.&%
L1AA0    fcb   $84,$01,$26,$0D,$C6,$01,$20,$0B   ..&.F. .
L1AA8    fcb   $EC,$21,$2B,$05,$26,$F6,$5F,$20   l!+.&v_ 
L1AB0    fcb   $02,$C6,$FF,$1D,$20,$07,$D6,$36   .F.. .V6
L1AB8    fcb   $0F,$36,$4F,$31,$3A,$ED,$21,$86   .6O1:m!.
L1AC0    fcb   $01,$A7,$A4,$39,$D6,$7D,$20,$F2   .'$9V} r
L1AC8    fcb   $E6,$25,$57,$10,$25,$09,$CB,$C6   f%W.%.KF
L1AD0    fcb   $1F,$D7,$6E,$EC,$21,$27,$EC,$4C   .Wnl!'lL
L1AD8    fcb   $47,$A7,$21,$EC,$22,$25,$0A,$44   G'!l"%.D
L1AE0    fcb   $56,$ED,$3C,$EC,$24,$46,$56,$20   Vm<l$FV 
L1AE8    fcb   $04,$ED,$3C,$EC,$24,$ED,$3E,$4F   .m<l$m>O
L1AF0    fcb   $5F,$ED,$22,$ED,$24,$ED,$3A,$ED   _m"m$m:m
L1AF8    fcb   $38,$20,$10,$1A,$01,$69,$25,$69   8 ...i%i
L1B00    fcb   $24,$69,$23,$69,$22,$0A,$6E,$27   $i#i".n'
L1B08    fcb   $44,$8D,$57,$E6,$3C,$C0,$40,$E7   D.Wf<@@g
L1B10    fcb   $3C,$EC,$3A,$E2,$25,$A2,$24,$ED   <l:b%"$m
L1B18    fcb   $3A,$EC,$38,$E2,$23,$A2,$22,$ED   :l8b#""m
L1B20    fcb   $38,$2A,$D8,$1C,$FE,$69,$25,$69   8*X..i%i
L1B28    fcb   $24,$69,$23,$69,$22,$0A,$6E,$27   $i#i".n'
L1B30    fcb   $1C,$8D,$2F,$E6,$3C,$CB,$C0,$E7   ../f<K@g
L1B38    fcb   $3C,$EC,$3A,$E9,$25,$A9,$24,$ED   <l:i%)$m
L1B40    fcb   $3A,$EC,$38,$E9,$23,$A9,$22,$ED   :l8i#)"m
L1B48    fcb   $38,$2B,$D8,$20,$AE,$EC,$22,$20   8+X .l" 
L1B50    fcb   $06,$6A,$21,$10,$29,$FA,$59,$68   .j!.)zYh
L1B58    fcb   $25,$69,$24,$59,$49,$2A,$F2,$ED   %i$YI*rm
L1B60    fcb   $22,$39,$8D,$00,$68,$3F,$69,$3E   "9..h?i>
L1B68    fcb   $69,$3D,$69,$3C,$69,$3B,$69,$3A   i=i<i;i:
L1B70    fcb   $69,$39,$69,$38,$39,$17,$F8,$77   i9i89.xw
L1B78    fcb   $EC,$23,$ED,$21,$39,$33,$34,$34   l#m!9344
L1B80    fcb   $20,$EC,$A1,$ED,$C1,$11,$A3,$E4    l!mA.#d
L1B88    fcb   $26,$F7,$32,$62,$31,$54,$17,$FB   &w2b1T..
L1B90    fcb   $6F,$8D,$06,$17,$FA,$09,$16,$F8   o...z..x
L1B98    fcb   $E5,$A6,$21,$2E,$09,$4F,$5F,$ED   e&!..O_m
L1BA0    fcb   $21,$ED,$23,$E7,$25,$39,$81,$1F   !m#g%9..
L1BA8    fcb   $24,$FB,$33,$26,$E6,$5F,$C4,$01   $.3&f_D.
L1BB0    fcb   $34,$44,$33,$21,$33,$41,$80,$08   4D3!3A..
L1BB8    fcb   $24,$FA,$27,$0C,$C6,$FF,$58,$4C   $z'.F.XL
L1BC0    fcb   $26,$FC,$E4,$C4,$E7,$C0,$20,$04   &.dDg@ .
L1BC8    fcb   $33,$41,$A7,$C0,$11,$A3,$61,$26   3A'@.#a&
L1BD0    fcb   $F9,$35,$44,$EA,$25,$E7,$25,$39   y5Dj%g%9
L1BD8    fcb   $31,$3A,$EC,$27,$ED,$21,$16,$F7   1:l'm!.w
L1BE0    fcb   $B3,$31,$3A,$EC,$2A,$ED,$24,$EC   31:l*m$l
L1BE8    fcb   $28,$ED,$22,$EC,$26,$ED,$A4,$16   (m"l&m$.
L1BF0    fcb   $F9,$AD,$DC,$80,$DE,$82,$34,$46   y-\.^.4F
L1BF8    fcb   $EC,$21,$DD,$80,$DD,$82,$DD,$48   l!].].]H
L1C00    fcb   $31,$26,$C6,$09,$17,$F4,$FE,$35   1&F..t.5
L1C08    fcb   $46,$DD,$80,$DF,$82,$10,$25,$08   F]._..%.
L1C10    fcb   $89,$39,$17,$F6,$0F,$31,$3A,$EF   .9.v.1:o
L1C18    fcb   $21,$86,$01,$A7,$A4,$30,$01,$39   !..'$0.9
L1C20    fcb   $01,$02,$05,$01,$17,$F5,$FD,$31   .....u.1
L1C28    fcb   $3A,$81,$04,$24,$09,$33,$8D,$FF   :..$.3..
L1C30    fcb   $EF,$E6,$C6,$4F,$20,$02,$DC,$3E   ofFO .\>
L1C38    fcb   $ED,$21,$20,$DD,$CC,$00,$FF,$20   m! ]L.. 
L1C40    fcb   $03,$CC,$00,$00,$31,$3A,$ED,$21   .L..1:m!
L1C48    fcb   $86,$03,$A7,$A4,$39,$63,$21,$63   ..'$9c!c
L1C50    fcb   $22,$39,$EC,$21,$A4,$27,$E4,$28   "9l!$'d(
L1C58    fcb   $20,$0E,$EC,$21,$A8,$27,$E8,$28    .l!('h(
L1C60    fcb   $20,$06,$EC,$21,$AA,$27,$EA,$28    .l!*'j(
L1C68    fcb   $ED,$27,$31,$26,$39,$FF,$DE,$5B   m'1&9.^[
L1C70    fcb   $D8,$AA,$8D,$0A,$33,$8D,$FF,$F5   X*..3..u
L1C78    fcb   $17,$F7,$EB,$16,$F9,$21,$34,$10   .wk.y!4.
L1C80    fcb   $E6,$25,$57,$10,$25,$08,$13,$EC   f%W.%..l
L1C88    fcb   $21,$10,$27,$08,$0D,$34,$02,$C6   !.'..4.F
L1C90    fcb   $01,$E7,$21,$31,$A8,$E6,$30,$A8   .g!1(f0(
L1C98    fcb   $1B,$33,$A4,$17,$04,$01,$17,$04   .3$.....
L1CA0    fcb   $F9,$4F,$5F,$ED,$A8,$14,$ED,$A8   yO_m(.m(
L1CA8    fcb   $16,$A7,$A8,$18,$30,$8D,$04,$A2   .'(.0.."
L1CB0    fcb   $AF,$A8,$19,$17,$01,$26,$30,$A8   /(...&0(
L1CB8    fcb   $14,$33,$A8,$1B,$17,$03,$E0,$17   .3(...`.
L1CC0    fcb   $04,$F2,$31,$A8,$1A,$C6,$02,$E7   .r1(.F.g
L1CC8    fcb   $A4,$E6,$25,$CA,$01,$E7,$25,$35   $f%J.g%5
L1CD0    fcb   $04,$8D,$0A,$35,$10,$16,$F7,$AC   ...5..w,
L1CD8    fcb   $00,$B1,$72,$17,$F8,$1D,$2A,$01   .1r.x.*.
L1CE0    fcb   $50,$84,$01,$34,$06,$33,$8D,$FF   P..4.3..
L1CE8    fcb   $EF,$17,$F7,$7A,$E6,$25,$A6,$61   o.wzf%&a
L1CF0    fcb   $81,$01,$27,$3B,$3D,$E7,$25,$E6   ..';=g%f
L1CF8    fcb   $24,$A7,$24,$A6,$61,$3D,$EB,$24   $'$&a=k$
L1D00    fcb   $89,$00,$E7,$24,$E6,$23,$A7,$23   ..g$f#'#
L1D08    fcb   $A6,$61,$3D,$EB,$23,$89,$00,$E7   &a=k#..g
L1D10    fcb   $23,$E6,$22,$A7,$22,$A6,$61,$3D   #f"'"&a=
L1D18    fcb   $EB,$22,$89,$00,$27,$0D,$6C,$21   k"..'.l!
L1D20    fcb   $44,$56,$66,$23,$66,$24,$66,$25   DVf#f$f%
L1D28    fcb   $4D,$26,$F3,$E7,$22,$E6,$25,$C4   M&sg"f%D
L1D30    fcb   $FE,$EA,$E4,$E7,$25,$35,$86,$34   .jdg%5.4
L1D38    fcb   $10,$E6,$21,$27,$16,$C1,$07,$2F   .f!'.A./
L1D40    fcb   $09,$E6,$25,$56,$56,$C8,$80,$16   .f%VVH..
L1D48    fcb   $00,$A5,$C1,$E4,$10,$2F,$FA,$C5   .%Ad./zE
L1D50    fcb   $5D,$2A,$0A,$6F,$E2,$E6,$25,$C4   ]*.obf%D
L1D58    fcb   $01,$27,$45,$20,$31,$86,$71,$3D   .'E 1.q=
L1D60    fcb   $AB,$21,$E6,$25,$C4,$01,$34,$06   +!f%D.4.
L1D68    fcb   $E8,$25,$E7,$25,$E6,$E4,$17,$FF   h%g%fd..
L1D70    fcb   $6C,$17,$F7,$0A,$E6,$21,$2F,$08   l.w.f!/.
L1D78    fcb   $EB,$E4,$E7,$E4,$E6,$21,$20,$EE   kdgdf! n
L1D80    fcb   $35,$06,$34,$02,$5D,$27,$19,$40   5.4.]'.@
L1D88    fcb   $A7,$E4,$EA,$25,$E7,$25,$33,$8D   'dj%g%3.
L1D90    fcb   $FF,$46,$17,$F6,$D1,$17,$F6,$EC   .F.vQ.vl
L1D98    fcb   $6A,$E4,$E6,$25,$C4,$01,$26,$EE   jdf%D.&n
L1DA0    fcb   $31,$A8,$E6,$30,$A8,$1B,$33,$A8   1(f0(.3(
L1DA8    fcb   $14,$17,$02,$F3,$17,$03,$EB,$CC   ...s..kL
L1DB0    fcb   $10,$00,$ED,$A4,$4F,$ED,$22,$A7   ..m$Om"'
L1DB8    fcb   $24,$30,$8D,$03,$77,$AF,$A8,$19   $0..w/(.
L1DC0    fcb   $8D,$1A,$30,$A4,$33,$A8,$1B,$17   ..0$3(..
L1DC8    fcb   $02,$D5,$17,$03,$E7,$31,$A8,$1A   .U..g1(.
L1DD0    fcb   $35,$04,$EB,$21,$29,$19,$86,$02   5.k!)...
L1DD8    fcb   $ED,$A4,$35,$90,$86,$01,$97,$9A   m$5.....
L1DE0    fcb   $30,$8D,$04,$5E,$9F,$95,$30,$89   0..^..0.
L1DE8    fcb   $00,$5F,$9F,$97,$16,$02,$7B,$31   ._....{1
L1DF0    fcb   $3A,$10,$2A,$F7,$BB,$C6,$32,$16   :.*w;F2.
L1DF8    fcb   $F3,$08,$34,$10,$8D,$32,$EC,$21   s.4..2l!
L1E00    fcb   $10,$27,$01,$60,$10,$83,$01,$80   .'.`....
L1E08    fcb   $2E,$0C,$26,$0D,$EC,$23,$26,$06   ..&.l#&.
L1E10    fcb   $A6,$25,$10,$27,$00,$CB,$16,$06   &%.'.K..
L1E18    fcb   $81,$17,$00,$82,$31,$A8,$EC,$30   ....1(l0
L1E20    fcb   $A8,$15,$33,$A4,$17,$02,$78,$17   (.3$..x.
L1E28    fcb   $03,$70,$30,$A8,$1B,$16,$00,$E1   .p0(...a
L1E30    fcb   $E6,$25,$C4,$01,$D7,$6D,$E8,$25   f%D.Wmh%
L1E38    fcb   $E7,$25,$39,$33,$8C,$40,$34,$50   g%93.@4P
L1E40    fcb   $8D,$EE,$EC,$21,$10,$27,$00,$99   .nl!.'..
L1E48    fcb   $10,$83,$01,$80,$2E,$C8,$26,$18   .....H&.
L1E50    fcb   $EC,$23,$26,$C2,$A6,$25,$26,$BE   l#&B&%&>
L1E58    fcb   $96,$6D,$26,$05,$5F,$ED,$21,$35   .m&._m!5
L1E60    fcb   $D0,$31,$26,$35,$50,$16,$01,$6E   P1&5P..n
L1E68    fcb   $8D,$34,$31,$A8,$EC,$30,$A8,$1B   .41(l0(.
L1E70    fcb   $33,$A4,$17,$02,$2A,$17,$03,$22   3$..*.."
L1E78    fcb   $30,$A8,$15,$16,$00,$93,$A6,$25   0(....&%
L1E80    fcb   $85,$01,$27,$14,$DE,$31,$6D,$41   ..'.^1mA
L1E88    fcb   $27,$08,$33,$8C,$0C,$17,$F5,$D6   '.3...uV
L1E90    fcb   $20,$03,$17,$01,$41,$16,$F5,$EC    ...A.ul
L1E98    fcb   $39,$08,$B4,$00,$00,$00,$96,$6D   9.4....m
L1EA0    fcb   $34,$02,$31,$A8,$EE,$CC,$02,$01   4.1(nL..
L1EA8    fcb   $ED,$2C,$86,$80,$5F,$ED,$2E,$4F   m,.._m.O
L1EB0    fcb   $ED,$A8,$10,$EC,$A8,$12,$ED,$A4   m(.l(.m$
L1EB8    fcb   $ED,$26,$EC,$A8,$14,$ED,$22,$ED   m&l(.m"m
L1EC0    fcb   $28,$EC,$A8,$16,$ED,$24,$ED,$2A   (l(.m$m*
L1EC8    fcb   $17,$F6,$D4,$17,$F5,$B0,$17,$FB   .vT.u0..
L1ED0    fcb   $F7,$35,$02,$97,$6D,$39,$34,$10   w5..m94.
L1ED8    fcb   $17,$FF,$55,$E6,$21,$C1,$18,$2D   ..Uf!A.-
L1EE0    fcb   $09,$31,$26,$17,$00,$F0,$6A,$21   .1&..pj!
L1EE8    fcb   $20,$53,$31,$A8,$E6,$CC,$10,$00    S1(fL..
L1EF0    fcb   $ED,$A4,$4F,$ED,$22,$A7,$24,$E6   m$Om"'$f
L1EF8    fcb   $A8,$1B,$20,$0B,$67,$A4,$66,$21   (. .g$f!
L1F00    fcb   $66,$22,$66,$23,$66,$24,$5A,$C1   f"f#f$ZA
L1F08    fcb   $02,$2E,$F1,$E7,$A8,$1B,$30,$A8   ..qg(.0(
L1F10    fcb   $1B,$33,$2A,$17,$01,$89,$17,$02   .3*.....
L1F18    fcb   $81,$4F,$5F,$ED,$A8,$14,$ED,$A8   .O_m(.m(
L1F20    fcb   $16,$A7,$A8,$18,$30,$8D,$01,$D7   .'(.0..W
L1F28    fcb   $AF,$A8,$19,$17,$01,$2E,$30,$A8   /(....0(
L1F30    fcb   $14,$33,$A8,$1B,$17,$01,$68,$17   .3(...h.
L1F38    fcb   $02,$7A,$31,$A8,$1A,$A6,$25,$9A   .z1(.&%.
L1F40    fcb   $6D,$A7,$25,$DE,$31,$6D,$41,$27   m'%^1mA'
L1F48    fcb   $1B,$33,$8D,$00,$84,$17,$F5,$16   .3....u.
L1F50    fcb   $17,$F6,$4C,$20,$0F,$34,$10,$17   .vL .4..
L1F58    fcb   $00,$83,$30,$2A,$8D,$0C,$A6,$25   ..0*..&%
L1F60    fcb   $98,$9C,$A7,$25,$86,$02,$A7,$A4   ..'%..'$
L1F68    fcb   $35,$90,$33,$A8,$1B,$17,$01,$2F   5.3(.../
L1F70    fcb   $17,$02,$41,$31,$A8,$14,$30,$8D   ..A1(.0.
L1F78    fcb   $02,$C3,$33,$21,$17,$01,$20,$16   .C3!.. .
L1F80    fcb   $F6,$1D,$34,$10,$8D,$57,$30,$A4   v.4..W0$
L1F88    fcb   $8D,$E0,$A6,$25,$98,$9B,$20,$D2   .`&%.. R
L1F90    fcb   $34,$10,$8D,$49,$30,$2A,$33,$A8   4..I0*3(
L1F98    fcb   $1B,$17,$01,$03,$17,$02,$15,$30   .......0
L1FA0    fcb   $A4,$31,$A8,$14,$33,$21,$17,$00   $1(.3!..
L1FA8    fcb   $F6,$17,$02,$08,$EC,$21,$26,$0E   v...l!&.
L1FB0    fcb   $31,$26,$CC,$7F,$FF,$ED,$21,$86   1&L.m!.
L1FB8    fcb   $FF,$ED,$23,$4A,$20,$05,$17,$F7   .m#J ..w
L1FC0    fcb   $3F,$A6,$25,$98,$9B,$20,$99,$02   ?&%.. ..
L1FC8    fcb   $C9,$0F,$DA,$A2,$FB,$8E,$FA,$35   I.Z"..z5
L1FD0    fcb   $12,$06,$E5,$2E,$E0,$D4,$33,$8D   ..e.`T3.
L1FD8    fcb   $FF,$ED,$16,$F4,$89,$DE,$31,$6D   .m.t.^1m
L1FE0    fcb   $41,$27,$0A,$33,$8D,$FF,$E5,$17   A'.3..e.
L1FE8    fcb   $F4,$7C,$17,$F5,$B2,$0F,$9B,$E6   t|.u2..f
L1FF0    fcb   $25,$C4,$01,$D7,$9C,$E8,$25,$E7   %D.W.h%g
L1FF8    fcb   $25,$8D,$DB,$6C,$21,$17,$F9,$1C   %.[l!.y.
L2000    fcb   $2D,$07,$17,$FB,$78,$8D,$CF,$20   -...x.O 
L2008    fcb   $02,$6A,$21,$17,$F9,$0E,$2D,$0D   .j!.y.-.
L2010    fcb   $0C,$9B,$96,$9C,$88,$01,$97,$9C   ........
L2018    fcb   $17,$F4,$63,$8D,$B9,$6A,$21,$17   .tc.9j!.
L2020    fcb   $F8,$FA,$2F,$13,$96,$9B,$88,$01   xz/.....
L2028    fcb   $97,$9B,$6C,$21,$A6,$2B,$8A,$01   ..l!&+..
L2030    fcb   $A7,$2B,$17,$F4,$4F,$31,$3A,$31   '+.tO1:1
L2038    fcb   $A8,$EC,$30,$8D,$00,$C8,$AF,$A8   (l0..H/(
L2040    fcb   $19,$30,$A8,$1B,$33,$A8,$14,$8D   .0(.3(..
L2048    fcb   $56,$17,$01,$4E,$CC,$10,$00,$ED   V..NL..m
L2050    fcb   $A4,$4F,$ED,$22,$A7,$24,$ED,$2A   $Om"'$m*
L2058    fcb   $ED,$2C,$A7,$2E,$30,$8D,$01,$9C   m,'.0...
L2060    fcb   $9F,$95,$30,$89,$00,$41,$9F,$97   ..0..A..
L2068    fcb   $0F,$9A,$C6,$25,$D7,$99,$0F,$9D   ..F%W...
L2070    fcb   $33,$A8,$1B,$9E,$95,$9C,$97,$24   3(.....$
L2078    fcb   $08,$8D,$24,$30,$05,$9F,$95,$20   ..$0... 
L2080    fcb   $04,$C6,$01,$8D,$6C,$30,$A4,$33   .F..l0$3
L2088    fcb   $25,$8D,$26,$0D,$9A,$26,$06,$30   %.&..&.0
L2090    fcb   $2A,$33,$2F,$8D,$1C,$AD,$B8,$19   *3/..-8.
L2098    fcb   $0C,$9D,$0A,$99,$26,$D2,$39,$34   ....&R94
L20A0    fcb   $30,$A6,$84,$10,$AE,$01,$AE,$03   0&......
L20A8    fcb   $A7,$C4,$10,$AF,$41,$AF,$43,$35   'D./A/C5
L20B0    fcb   $B0,$E6,$84,$1D,$D6,$9D,$54,$54   0f..V.TT
L20B8    fcb   $54,$24,$01,$5C,$34,$04,$27,$05   T$.\4.'.
L20C0    fcb   $A7,$C0,$5A,$26,$FB,$C6,$05,$E0   '@Z&.F.`
L20C8    fcb   $E0,$27,$07,$A6,$80,$A7,$C0,$5A   `'.&.'@Z
L20D0    fcb   $26,$F9,$33,$5B,$D6,$9D,$C4,$07   &y3[V.D.
L20D8    fcb   $27,$24,$C1,$04,$25,$13,$C0,$08   '$A.%.@.
L20E0    fcb   $A6,$84,$48,$69,$44,$69,$43,$69   &.HiDiCi
L20E8    fcb   $42,$69,$41,$69,$C4,$5C,$26,$F2   BiAiD\&r
L20F0    fcb   $39,$67,$C4,$66,$41,$66,$42,$66   9gDfAfBf
L20F8    fcb   $43,$66,$44,$5A,$26,$F3,$39,$A6   CfDZ&s9&
L2100    fcb   $2A,$A8,$A4,$43,$20,$03,$A6,$A8   *($C .&(
L2108    fcb   $14,$4D,$2A,$14,$30,$A4,$33,$2F   .M*.0$3/
L2110    fcb   $8D,$50,$30,$2A,$33,$25,$8D,$66   .P0*3%.f
L2118    fcb   $30,$A8,$14,$33,$A8,$1B,$20,$42   0(.3(. B
L2120    fcb   $30,$A4,$33,$2F,$8D,$58,$30,$2A   0$3/.X0*
L2128    fcb   $33,$25,$8D,$36,$30,$A8,$14,$33   3%.60(.3
L2130    fcb   $A8,$1B,$20,$4A,$30,$A8,$14,$33   (. J0(.3
L2138    fcb   $A8,$1B,$8D,$42,$2B,$24,$26,$0C   (..B+$&.
L2140    fcb   $EC,$01,$26,$08,$EC,$03,$26,$04   l.&.l.&.
L2148    fcb   $C6,$01,$D7,$99,$30,$A4,$33,$25   F.W.0$3%
L2150    fcb   $20,$10,$30,$A4,$33,$25,$8D,$0A    .0$3%..
L2158    fcb   $81,$20,$24,$22,$30,$A8,$14,$33   . $"0(.3
L2160    fcb   $A8,$1B,$EC,$03,$E3,$43,$ED,$03   (.l.cCm.
L2168    fcb   $EC,$01,$24,$07,$C3,$00,$01,$24   l.$.C..$
L2170    fcb   $02,$6C,$84,$E3,$41,$ED,$01,$A6   .l.cAm.&
L2178    fcb   $84,$A9,$C4,$A7,$84,$39,$EC,$03   .)D'.9l.
L2180    fcb   $A3,$43,$ED,$03,$EC,$01,$24,$07   #Cm.l.$.
L2188    fcb   $83,$00,$01,$24,$02,$6A,$84,$A3   ...$.j.#
L2190    fcb   $41,$ED,$01,$A6,$84,$A2,$C4,$A7   Am.&."D'
L2198    fcb   $84,$39,$E6,$C4,$6F,$C4,$CB,$04   .9fDoDK.
L21A0    fcb   $2C,$0F,$50,$16,$FF,$4B,$68,$44   ,.P..KhD
L21A8    fcb   $69,$43,$69,$42,$69,$41,$69,$C4   iCiBiAiD
L21B0    fcb   $5A,$26,$F3,$39,$A6,$C4,$2A,$09   Z&s9&D*.
L21B8    fcb   $4F,$5F,$ED,$C4,$ED,$42,$A7,$44   O_mDmB'D
L21C0    fcb   $39,$CC,$20,$04,$5A,$68,$44,$69   9L .ZhDi
L21C8    fcb   $43,$69,$42,$69,$41,$69,$C4,$2B   CiBiAiD+
L21D0    fcb   $07,$4A,$26,$F0,$5F,$ED,$C4,$39   .J&p_mD9
L21D8    fcb   $A6,$C4,$E7,$C4,$E6,$41,$A7,$41   &DgDfA'A
L21E0    fcb   $A6,$42,$E7,$42,$E6,$43,$C3,$00   &BgBfCC.
L21E8    fcb   $01,$C4,$FE,$ED,$43,$24,$0C,$6C   .D.mC$.l
L21F0    fcb   $42,$26,$08,$6C,$41,$26,$04,$66   B&.lA&.f
L21F8    fcb   $41,$6C,$C4,$39,$0C,$90,$FD,$AA   AlD9...*
L2200    fcb   $22,$07,$6B,$19,$C1,$58,$03,$EB   ".k.AX.k
L2208    fcb   $6E,$BF,$26,$01,$FD,$5B,$A9,$AB   n?&..[)+
L2210    fcb   $00,$FF,$AA,$DD,$B9,$00,$7F,$F5   ..*]9.u
L2218    fcb   $56,$EF,$00,$3F,$FE,$AA,$B7,$00   Vo.?.*7.
L2220    fcb   $1F,$FF,$D5,$56,$00,$0F,$FF,$FA   ..UV...z
L2228    fcb   $AB,$00,$07,$FF,$FF,$55,$00,$03   +....U..
L2230    fcb   $FF,$FF,$EB,$00,$01,$FF,$FF,$FD   ..k.....
L2238    fcb   $00,$01,$00,$00,$00,$00,$9B,$74   .......t
L2240    fcb   $ED,$A8,$0B,$17,$21,$7F,$7E,$06   m(..!~.
L2248    fcb   $7C,$C8,$FB,$30,$03,$91,$FE,$F8   |H.0...x
L2250    fcb   $F3,$01,$E2,$70,$76,$E3,$00,$F8   s.bpvc.x
L2258    fcb   $51,$86,$01,$00,$7E,$0A,$6C,$3A   Q...~.l:
L2260    fcb   $00,$3F,$81,$51,$62,$00,$1F,$E0   .?.Qb..`
L2268    fcb   $2A,$6B,$00,$0F,$F8,$05,$51,$00   *k..x.Q.
L2270    fcb   $07,$FE,$00,$AA,$00,$03,$FF,$80   ...*....
L2278    fcb   $15,$00,$01,$FF,$E0,$03,$00,$00   ....`...
L2280    fcb   $FF,$F8,$00,$00,$00,$7F,$FE,$00   .x.....
L2288    fcb   $00,$00,$3F,$FF,$80,$00,$00,$1F   ..?.....
L2290    fcb   $FF,$E0,$00,$00,$0F,$FF,$F8,$00   .`....x.
L2298    fcb   $00,$07,$FF,$FE,$00,$00,$04,$00   ........
L22A0    fcb   $00,$0E,$12,$14,$A2,$BB,$40,$E6   ....";@f
L22A8    fcb   $2D,$36,$19,$62,$E9,$4F,$5F,$DD   -6.biO_]
L22B0    fcb   $4C,$DD,$4E,$34,$02,$A6,$22,$27   L]N4.&"'
L22B8    fcb   $16,$E6,$25,$C5,$01,$26,$04,$63   .f%E.&.c
L22C0    fcb   $E4,$20,$0C,$CB,$FE,$EB,$21,$A6   d .K.k!&
L22C8    fcb   $24,$DD,$52,$EC,$22,$DD,$50,$96   $]Rl"]P.
L22D0    fcb   $53,$D6,$57,$3D,$DD,$4E,$96,$52   SVW=]N.R
L22D8    fcb   $D6,$57,$3D,$D3,$4D,$24,$02,$0C   VW=SM$..
L22E0    fcb   $4C,$DD,$4D,$96,$53,$D6,$56,$3D   L]M.SVV=
L22E8    fcb   $D3,$4D,$24,$02,$0C,$4C,$DD,$4D   SM$..L]M
L22F0    fcb   $96,$51,$D6,$57,$3D,$D3,$4C,$DD   .QVW=SL]
L22F8    fcb   $4C,$96,$52,$D6,$56,$3D,$D3,$4C   L.RVV=SL
L2300    fcb   $DD,$4C,$96,$53,$D6,$55,$3D,$D3   ]L.SVU=S
L2308    fcb   $4C,$DD,$4C,$96,$50,$D6,$57,$3D   L]L.PVW=
L2310    fcb   $DB,$4C,$D7,$4C,$96,$51,$D6,$56   [LWL.QVV
L2318    fcb   $3D,$DB,$4C,$D7,$4C,$96,$52,$D6   =[LWL.RV
L2320    fcb   $55,$3D,$DB,$4C,$D7,$4C,$96,$53   U=[LWL.S
L2328    fcb   $D6,$54,$3D,$DB,$4C,$D7,$4C,$DC   VT=[LWL\
L2330    fcb   $4E,$D3,$5A,$DD,$52,$DC,$4C,$D9   NSZ]R\LY
L2338    fcb   $59,$99,$58,$DD,$50,$6D,$E0,$26   Y.X]Pm`&
L2340    fcb   $2A,$DC,$50,$ED,$22,$DC,$52,$ED   *\Pm"\Rm
L2348    fcb   $24,$6F,$21,$86,$1F,$34,$02,$EC   $o!..4.l
L2350    fcb   $22,$2B,$0E,$6A,$E4,$27,$0A,$6A   "+.jd'.j
L2358    fcb   $21,$68,$25,$69,$24,$59,$49,$2A   !h%i$YI*
L2360    fcb   $F2,$ED,$22,$E6,$25,$C4,$FE,$E7   rm"f%D.g
L2368    fcb   $25,$35,$84,$DC,$52,$C4,$FE,$ED   %5.\RD.m
L2370    fcb   $A3,$DC,$50,$ED,$A3,$4F,$5F,$ED   #\Pm#O_m
L2378    fcb   $A3,$8D,$D0,$16,$F2,$21,$DC,$48   #.P.r!\H
L2380    fcb   $EE,$21,$A3,$21,$83,$00,$01,$DF   n!#!..._
L2388    fcb   $48,$ED,$21,$86,$01,$A7,$A4,$39   Hm!..'$9
L2390    fcb   $EC,$21,$DD,$48,$E6,$B8,$01,$4F   l!]Hf8.O
L2398    fcb   $20,$EF,$EC,$21,$4D,$10,$26,$00    ol!M.&.
L23A0    fcb   $F9,$DE,$48,$EF,$21,$E7,$C0,$17   y^Ho!g@.
L23A8    fcb   $01,$13,$10,$9F,$44,$11,$93,$44   ....D..D
L23B0    fcb   $10,$24,$F5,$E1,$39,$EC,$21,$2F   .$ua9l!/
L23B8    fcb   $0E,$E3,$27,$1F,$03,$10,$93,$48   .c'....H
L23C0    fcb   $24,$02,$8D,$7F,$31,$26,$39,$31   $..1&91
L23C8    fcb   $26,$EE,$21,$20,$76,$EC,$21,$2F   &n! vl!/
L23D0    fcb   $F6,$34,$10,$DC,$48,$A3,$21,$83   v4.\H#!.
L23D8    fcb   $00,$01,$10,$A3,$27,$23,$0E,$1F   ...#'#..
L23E0    fcb   $01,$EE,$27,$A6,$80,$A7,$C0,$81   .n'&.'@.
L23E8    fcb   $FF,$26,$F8,$DF,$48,$31,$26,$35   .&x_H1&5
L23F0    fcb   $90,$EC,$21,$2F,$04,$EC,$27,$2E   .l!/.l'.
L23F8    fcb   $08,$EC,$21,$31,$26,$ED,$21,$20   .l!1&m! 
L2400    fcb   $B4,$83,$00,$01,$27,$F3,$E3,$2D   4...'sc-
L2408    fcb   $10,$93,$48,$25,$04,$31,$26,$20   ..H%.1& 
L2410    fcb   $B6,$34,$10,$1F,$01,$E6,$22,$EE   64...f"n
L2418    fcb   $2D,$A6,$80,$A7,$C0,$81,$FF,$27   -&.'@..'
L2420    fcb   $0B,$5A,$26,$F5,$6A,$21,$2A,$F1   .Z&uj!*q
L2428    fcb   $86,$FF,$A7,$C0,$DF,$48,$31,$2C   ..'@_H1,
L2430    fcb   $35,$90,$DE,$48,$33,$5F,$11,$A3   5.^H3_.#
L2438    fcb   $21,$27,$08,$A6,$C2,$81,$20,$27   !'.&B. '
L2440    fcb   $F5,$33,$41,$86,$FF,$A7,$C0,$DF   u3A..'@_
L2448    fcb   $48,$39,$34,$30,$DC,$48,$A3,$21   H940\H#!
L2450    fcb   $E3,$27,$C3,$00,$01,$AE,$27,$10   c'C...'.
L2458    fcb   $AE,$21,$17,$EC,$A2,$24,$04,$4F   .!.l"$.O
L2460    fcb   $5F,$20,$09,$1F,$20,$AE,$62,$A3   _ .. .b#
L2468    fcb   $01,$C3,$00,$01,$35,$30,$ED,$27   .C..50m'
L2470    fcb   $86,$01,$A7,$26,$31,$26,$39,$C6   ..'&1&9F
L2478    fcb   $02,$20,$02,$C6,$03,$96,$7D,$DE   . .F..}^
L2480    fcb   $82,$34,$52,$17,$EC,$7F,$25,$12   .4R.l%.
L2488    fcb   $9E,$82,$86,$FF,$A7,$84,$AE,$63   ....'..c
L2490    fcb   $17,$F4,$D7,$35,$52,$97,$7D,$DF   .tW5R.}_
L2498    fcb   $82,$39,$C6,$43,$16,$EC,$63,$34   .9FC.lc4
L24A0    fcb   $10,$EC,$21,$2D,$F5,$10,$9F,$44   .l!-u..D
L24A8    fcb   $DE,$48,$EF,$21,$86,$20,$D1,$7D   ^Ho!. Q}
L24B0    fcb   $23,$0D,$A7,$C0,$5A,$11,$93,$44   #.'@Z..D
L24B8    fcb   $25,$F4,$16,$F4,$D8,$34,$10,$86   %t.tX4..
L24C0    fcb   $FF,$A7,$C0,$DF,$48,$86,$04,$A7   .'@_H..'
L24C8    fcb   $A4,$35,$90,$34,$10,$31,$3A,$30   $5.4.1:0
L24D0    fcb   $3A,$DE,$48,$EF,$21,$10,$3F,$15   :^Ho!.?.
L24D8    fcb   $25,$E5,$8D,$18,$86,$2F,$8D,$12   %e.../..
L24E0    fcb   $86,$2F,$8D,$0E,$86,$20,$8D,$0A   ./... ..
L24E8    fcb   $86,$3A,$8D,$06,$86,$3A,$8D,$02   .:...:..
L24F0    fcb   $20,$CD,$A7,$C0,$A6,$80,$C6,$2F    M'@&.F/
L24F8    fcb   $5C,$80,$0A,$24,$FB,$E7,$C0,$C6   \..$.g@F
L2500    fcb   $3A,$5A,$4C,$26,$FC,$E7,$C0,$39   :ZL&.g@9
L2508    fcb   $A6,$22,$C6,$06,$10,$3F,$8D,$24   &"F..?.$
L2510    fcb   $08,$C1,$D3,$26,$04,$C6,$FF,$20   .AS&.F. 
L2518    fcb   $02,$C6,$00,$4F,$ED,$21,$86,$03   .F.Om!..
L2520    fcb   $A7,$A4,$39,$C6,$06,$34,$34,$1F   '$9F.44.
L2528    fcb   $B8,$C6,$50,$1F,$02,$30,$8D,$FD   8FP..0..
L2530    fcb   $70,$EC,$81,$ED,$A1,$6A,$E4,$26   pl.m!jd&
L2538    fcb   $F8,$30,$8D,$EC,$4B,$9F,$10,$30   x0.lK..0
L2540    fcb   $8D,$EC,$C5,$9F,$12,$86,$7E,$97   .lE...~.
L2548    fcb   $16,$30,$8D,$EC,$C7,$9F,$17,$35   .0.lG..5
L2550    fcb   $B4,$34,$16,$E6,$F8,$04,$30,$8C   44.fx.0.
L2558    fcb   $08,$EC,$85,$30,$8B,$AF,$64,$35   .l.0./d5
L2560    fcb   $96,$00,$BA,$00,$10,$9D,$27,$0C   ..:...'.
L2568    fcb   $9D,$27,$0E,$9D,$27,$08,$9D,$27   .'..'..'
L2570    fcb   $06,$34,$96,$58,$30,$8C,$08,$EC   .4.X0..l
L2578    fcb   $85,$30,$8B,$AF,$64,$35,$96,$04   .0./d5..
L2580    fcb   $5F,$05,$C3,$05,$C3,$04,$B7,$05   _.C.C.7.
L2588    fcb   $B3,$05,$AA,$04,$4A,$02,$58,$02   3.*.J.X.
L2590    fcb   $6B,$02,$35,$02,$A2,$02,$7F,$05   k.5."..
L2598    fcb   $F9,$05,$E9,$04,$78,$0A,$11,$05   y.i.x...
L25A0    fcb   $DA,$06,$BA,$05,$62,$07,$59,$06   Z.:.b.Y.
L25A8    fcb   $02,$27,$10,$03,$E8,$00,$64,$00   .'..h.d.
L25B0    fcb   $0A,$04,$A0,$00,$00,$00,$07,$C8   .. ....H
L25B8    fcb   $00,$00,$00,$0A,$FA,$00,$00,$00   ....z...
L25C0    fcb   $0E,$9C,$40,$00,$00,$11,$C3,$50   ..@...CP
L25C8    fcb   $00,$00,$14,$F4,$24,$00,$00,$18   ...t$...
L25D0    fcb   $98,$96,$80,$00,$1B,$BE,$BC,$20   .....>< 
L25D8    fcb   $00,$1E,$EE,$6B,$28,$00,$22,$95   ..nk(.".
L25E0    fcb   $02,$F9,$00,$25,$BA,$43,$B7,$40   .y.%:C7@
L25E8    fcb   $28,$E8,$D4,$A5,$10,$2C,$91,$84   (hT%.,..
L25F0    fcb   $E7,$2A,$2F,$B5,$E6,$20,$F4,$32   g*/5f t2
L25F8    fcb   $E3,$5F,$A9,$32,$36,$8E,$1B,$C9   c_)26..I
L2600    fcb   $C0,$39,$B1,$A2,$BC,$2E,$3C,$DE   @91"<.<^
L2608    fcb   $0B,$6B,$3A,$40,$8A,$C7,$23,$04   .k:@.G#.
L2610    fcb   $54,$72,$75,$65,$FF,$46,$61,$6C   True.Fal
L2618    fcb   $73,$65,$FF,$34,$40,$31,$3A,$4F   se.4@1:O
L2620    fcb   $5F,$97,$75,$97,$76,$97,$77,$97   _.u.v.w.
L2628    fcb   $78,$97,$79,$ED,$24,$ED,$22,$A7   x.ym$m"'
L2630    fcb   $21,$17,$02,$29,$24,$09,$30,$1F   !..)$.0.
L2638    fcb   $81,$2C,$26,$6F,$16,$00,$89,$81   .,&o....
L2640    fcb   $24,$10,$27,$01,$3A,$81,$2B,$27   $.'.:.+'
L2648    fcb   $06,$81,$2D,$26,$04,$0C,$78,$A6   ..-&..x&
L2650    fcb   $80,$81,$2E,$26,$08,$0D,$77,$26   ...&..w&
L2658    fcb   $52,$0C,$77,$20,$F2,$17,$06,$4B   R.w r..K
L2660    fcb   $25,$50,$34,$02,$0C,$76,$EC,$24   %P4..vl$
L2668    fcb   $EE,$22,$8D,$2C,$ED,$24,$EF,$22   n".,m$o"
L2670    fcb   $8D,$26,$8D,$24,$E3,$24,$1E,$03   .&.$c$..
L2678    fcb   $E9,$23,$A9,$22,$25,$27,$1E,$03   i#)"%'..
L2680    fcb   $EB,$E0,$89,$00,$24,$06,$33,$41   k`..$.3A
L2688    fcb   $EF,$22,$27,$1B,$ED,$24,$EF,$22   o"'.m$o"
L2690    fcb   $0D,$77,$27,$BB,$0C,$79,$20,$B7   .w';.y 7
L2698    fcb   $58,$49,$1E,$03,$59,$49,$1E,$03   XI..YI..
L26A0    fcb   $25,$01,$39,$32,$62,$32,$61,$C6   %.92b2aF
L26A8    fcb   $3C,$20,$02,$C6,$3B,$D7,$36,$43   < .F;W6C
L26B0    fcb   $35,$C0,$88,$45,$84,$DF,$27,$23   5@.E._'#
L26B8    fcb   $30,$1F,$0D,$76,$26,$02,$20,$EB   0..v&. k
L26C0    fcb   $0D,$77,$26,$45,$EC,$22,$26,$41   .w&El"&A
L26C8    fcb   $EC,$24,$2B,$3D,$0D,$78,$27,$04   l$+=.x'.
L26D0    fcb   $40,$50,$82,$00,$ED,$21,$86,$01   @P..m!..
L26D8    fcb   $16,$00,$87,$A6,$84,$81,$2B,$27   ...&..+'
L26E0    fcb   $06,$81,$2D,$26,$04,$0C,$75,$30   ..-&..u0
L26E8    fcb   $01,$17,$05,$BD,$25,$BD,$1F,$89   ...=%=..
L26F0    fcb   $17,$05,$B6,$24,$04,$30,$1F,$20   ..6$.0. 
L26F8    fcb   $07,$34,$02,$86,$0A,$3D,$EB,$E0   .4...=k`
L2700    fcb   $0D,$75,$26,$01,$50,$DB,$79,$D7   .u&.P[yW
L2708    fcb   $79,$C6,$20,$E7,$21,$EC,$22,$26   yF g!l"&
L2710    fcb   $09,$10,$A3,$24,$26,$04,$6F,$21   ..#$&.o!
L2718    fcb   $20,$46,$4D,$2B,$0A,$6A,$21,$68    FM+.j!h
L2720    fcb   $25,$69,$24,$59,$49,$2A,$F6,$ED   %i$YI*vm
L2728    fcb   $22,$0F,$75,$D6,$79,$27,$29,$2A   ".uVy')*
L2730    fcb   $03,$50,$0C,$75,$C1,$13,$23,$10   .P.uA.#.
L2738    fcb   $C0,$13,$34,$04,$33,$8D,$FE,$CB   @.4.3..K
L2740    fcb   $8D,$26,$35,$04,$10,$25,$FF,$5F   .&5..%._
L2748    fcb   $5A,$86,$05,$3D,$33,$8D,$FE,$61   Z..=3..a
L2750    fcb   $33,$C5,$8D,$14,$10,$25,$FF,$4F   3E...%.O
L2758    fcb   $A6,$25,$84,$FE,$9A,$78,$A7,$25   &%...x'%
L2760    fcb   $86,$02,$A7,$A4,$1C,$FE,$35,$C0   ..'$..5@
L2768    fcb   $31,$3A,$EC,$C4,$ED,$21,$EC,$42   1:lDm!lB
L2770    fcb   $ED,$23,$E6,$44,$E7,$25,$96,$75   m#fDg%.u
L2778    fcb   $10,$27,$FD,$EF,$16,$FD,$EF,$17   .'.o..o.
L2780    fcb   $05,$27,$24,$10,$81,$61,$25,$02   .'$..a%.
L2788    fcb   $80,$20,$81,$41,$25,$1B,$81,$46   . .A%..F
L2790    fcb   $22,$17,$80,$37,$0C,$76,$C6,$04   "..7.vF.
L2798    fcb   $68,$22,$69,$21,$10,$25,$FF,$07   h"i!.%..
L27A0    fcb   $5A,$26,$F5,$AB,$22,$A7,$22,$20   Z&u+"'" 
L27A8    fcb   $D6,$30,$1F,$0D,$76,$10,$27,$FE   V0..v.'.
L27B0    fcb   $FA,$16,$FF,$22,$34,$10,$9E,$82   z.."4...
L27B8    fcb   $17,$FE,$60,$24,$02,$35,$90,$81   ..`$.5..
L27C0    fcb   $02,$27,$03,$17,$FD,$A2,$17,$00   .'..."..
L27C8    fcb   $88,$25,$07,$C6,$3D,$D7,$36,$43   .%.F=W6C
L27D0    fcb   $35,$90,$9F,$82,$4F,$35,$90,$34   5...O5.4
L27D8    fcb   $10,$9E,$82,$17,$FE,$3D,$25,$DD   .....=%]
L27E0    fcb   $81,$01,$26,$13,$6D,$21,$27,$DE   ..&.m!'^
L27E8    fcb   $20,$0D,$34,$10,$9E,$82,$17,$FE    .4.....
L27F0    fcb   $2A,$25,$CA,$81,$01,$27,$CF,$C6   *%J..'OF
L27F8    fcb   $3A,$D7,$36,$43,$35,$90,$34,$50   :W6C5.4P
L2800    fcb   $31,$3A,$DE,$4A,$EF,$21,$86,$04   1:^Jo!..
L2808    fcb   $A7,$A4,$9E,$82,$A6,$80,$8D,$53   '$..&..S
L2810    fcb   $25,$04,$A7,$C0,$20,$F6,$9F,$82   %.'@ v..
L2818    fcb   $86,$FF,$A7,$C0,$DF,$48,$4F,$35   ..'@_HO5
L2820    fcb   $D0,$34,$10,$31,$3A,$86,$03,$A7   P4.1:..'
L2828    fcb   $A4,$6F,$22,$9E,$82,$8D,$2E,$25   $o"....%
L2830    fcb   $1B,$81,$54,$27,$11,$81,$74,$27   ..T'..t'
L2838    fcb   $0D,$88,$46,$84,$DF,$27,$09,$C6   ..F._'.F
L2840    fcb   $3A,$D7,$36,$43,$35,$90,$63,$22   :W6C5.c"
L2848    fcb   $8D,$07,$24,$FC,$9F,$82,$4F,$35   ..$...O5
L2850    fcb   $90,$A6,$80,$81,$20,$26,$0C,$8D   .&.. &..
L2858    fcb   $04,$24,$17,$20,$17,$A6,$80,$81   .$. .&..
L2860    fcb   $20,$27,$FA,$91,$DD,$27,$0D,$81    'z.]'..
L2868    fcb   $0D,$27,$07,$81,$FF,$27,$03,$1C   .'...'..
L2870    fcb   $FE,$39,$30,$1F,$1A,$01,$39,$34   .90...94
L2878    fcb   $50,$4F,$A7,$23,$97,$76,$97,$78   PO'#.v.x
L2880    fcb   $86,$04,$97,$7E,$EC,$21,$2A,$06   ...~l!*.
L2888    fcb   $40,$50,$82,$00,$0C,$78,$33,$8D   @P...x3.
L2890    fcb   $FD,$15,$0F,$7A,$33,$42,$A3,$C4   ...z3B#D
L2898    fcb   $25,$04,$0C,$7A,$20,$F8,$E3,$C4   %..z xcD
L28A0    fcb   $0D,$7A,$26,$04,$6D,$23,$27,$0B   .z&.m#'.
L28A8    fcb   $6C,$23,$34,$02,$96,$7A,$17,$01   l#4..z..
L28B0    fcb   $06,$35,$02,$0A,$7E,$26,$DB,$1F   .5..~&[.
L28B8    fcb   $98,$17,$00,$FB,$31,$26,$35,$D0   ....1&5P
L28C0    fcb   $34,$50,$0F,$75,$0F,$78,$0F,$7C   4P.u.x.|
L28C8    fcb   $0F,$7B,$0F,$79,$0F,$76,$33,$84   .{.y.v3.
L28D0    fcb   $CC,$0A,$30,$E7,$C0,$4A,$26,$FB   L.0g@J&.
L28D8    fcb   $EC,$21,$26,$04,$4C,$16,$00,$D1   l!&.L..Q
L28E0    fcb   $E6,$25,$C5,$01,$27,$06,$D7,$78   f%E.'.Wx
L28E8    fcb   $C4,$FE,$E7,$25,$EC,$21,$2A,$03   D.g%l!*.
L28F0    fcb   $0C,$75,$40,$81,$03,$23,$2D,$C6   .u@..#-F
L28F8    fcb   $9A,$3D,$44,$12,$12,$1F,$89,$0D   .=D.....
L2900    fcb   $75,$27,$01,$50,$D7,$79,$81,$13   u'.PWy..
L2908    fcb   $23,$0D,$34,$02,$33,$8D,$FC,$FB   #.4.3...
L2910    fcb   $17,$FE,$55,$35,$02,$80,$13,$33   ..U5...3
L2918    fcb   $8D,$FC,$96,$4A,$C6,$05,$3D,$33   ...JF.=3
L2920    fcb   $CB,$17,$FE,$44,$EC,$22,$6D,$21   K..Dl"m!
L2928    fcb   $27,$26,$2A,$10,$44,$56,$66,$24   '&*.DVf$
L2930    fcb   $66,$25,$06,$7C,$6C,$21,$26,$F4   f%.|l!&t
L2938    fcb   $ED,$22,$20,$14,$68,$25,$69,$24   m" .h%i$
L2940    fcb   $59,$49,$09,$7B,$6A,$21,$26,$F4   YI.{j!&t
L2948    fcb   $ED,$22,$0C,$79,$96,$7B,$8D,$67   m".y.{.g
L2950    fcb   $EC,$22,$EE,$24,$0F,$7B,$8D,$66   l"n$.{.f
L2958    fcb   $ED,$22,$EF,$24,$34,$02,$96,$7B   m"o$4..{
L2960    fcb   $97,$7C,$35,$02,$8D,$58,$8D,$56   .|5..X.V
L2968    fcb   $1E,$03,$E3,$24,$1E,$03,$E9,$23   ..c$..i#
L2970    fcb   $A9,$22,$34,$02,$96,$7B,$99,$7C   )"4..{.|
L2978    fcb   $8D,$3D,$96,$76,$81,$09,$35,$02   .=.v..5.
L2980    fcb   $27,$0C,$10,$83,$00,$00,$26,$CC   '.....&L
L2988    fcb   $11,$83,$00,$00,$26,$C6,$A7,$A4   ....&F'$
L2990    fcb   $96,$76,$81,$09,$25,$19,$E6,$A4   .v..%.f$
L2998    fcb   $2A,$15,$A6,$82,$4C,$A7,$84,$81   *.&.L'..
L29A0    fcb   $39,$23,$0C,$86,$30,$A7,$84,$AC   9#..0'.,
L29A8    fcb   $E4,$26,$EF,$6C,$84,$0C,$79,$86   d&ol..y.
L29B0    fcb   $09,$97,$76,$31,$26,$35,$D0,$8A   ..v1&5P.
L29B8    fcb   $30,$A7,$80,$0C,$76,$39,$1E,$03   0'..v9..
L29C0    fcb   $58,$49,$1E,$03,$59,$49,$09,$7B   XI..YI.{
L29C8    fcb   $39,$34,$30,$9E,$80,$9F,$82,$86   940.....
L29D0    fcb   $01,$97,$7D,$10,$8E,$01,$00,$96   ..}.....
L29D8    fcb   $7F,$10,$3F,$8B,$20,$13,$34,$30   .?. .40
L29E0    fcb   $DC,$82,$93,$80,$27,$0F,$1F,$02   \...'...
L29E8    fcb   $9E,$80,$9F,$82,$96,$7F,$10,$3F   ......?
L29F0    fcb   $8C,$24,$02,$D7,$36,$35,$B0,$34   .$.W6504
L29F8    fcb   $50,$A6,$A4,$81,$02,$27,$04,$EE   P&$..'.n
L2A00    fcb   $21,$20,$07,$A6,$21,$2E,$08,$CE   ! .&!..N
L2A08    fcb   $00,$00,$8E,$00,$00,$20,$1C,$AE   ..... ..
L2A10    fcb   $22,$EE,$24,$80,$20,$25,$05,$C6   "n$. %.F
L2A18    fcb   $4E,$43,$20,$16,$1E,$10,$44,$56   NC ...DV
L2A20    fcb   $1E,$03,$46,$56,$1E,$01,$1E,$13   ..FV....
L2A28    fcb   $4C,$26,$F1,$96,$7F,$10,$3F,$88   L&q..?.
L2A30    fcb   $24,$02,$D7,$36,$35,$D0,$34,$50   $.W65P4P
L2A38    fcb   $32,$76,$30,$E4,$17,$FE,$81,$34   2v0d...4
L2A40    fcb   $10,$86,$09,$30,$09,$E6,$82,$C1   ...0.f.A
L2A48    fcb   $30,$26,$05,$4A,$81,$01,$26,$F5   0&.J..&u
L2A50    fcb   $97,$76,$35,$10,$D6,$79,$2E,$21   .v5.Vy.!
L2A58    fcb   $50,$1F,$98,$C1,$09,$22,$34,$DB   P..A."4[
L2A60    fcb   $76,$C1,$09,$22,$2E,$34,$02,$17   vA.".4..
L2A68    fcb   $00,$A6,$4F,$8D,$72,$35,$04,$5D   .&O.r5.]
L2A70    fcb   $27,$03,$17,$00,$8C,$96,$76,$20   '.....v 
L2A78    fcb   $13,$C1,$09,$22,$16,$17,$00,$90   .A."....
L2A80    fcb   $1F,$98,$8D,$4A,$8D,$59,$96,$76   ...J.Y.v
L2A88    fcb   $90,$79,$23,$02,$8D,$40,$32,$6A   .y#..@2j
L2A90    fcb   $4F,$35,$D0,$8D,$7B,$86,$01,$8D   O5P.{...
L2A98    fcb   $35,$8D,$44,$96,$76,$4A,$26,$01   5.D.vJ&.
L2AA0    fcb   $4C,$8D,$2B,$8D,$02,$20,$E7,$86   L.+.. g.
L2AA8    fcb   $45,$8D,$36,$96,$79,$4A,$34,$02   E.6.yJ4.
L2AB0    fcb   $2A,$06,$60,$E4,$8D,$5E,$20,$02   *.`d.^ .
L2AB8    fcb   $8D,$5E,$35,$04,$4F,$C0,$0A,$25   .^5.O@.%
L2AC0    fcb   $03,$4C,$20,$F9,$CB,$0A,$8D,$02   .L yK...
L2AC8    fcb   $1F,$98,$8B,$30,$20,$13,$1F,$89   ...0 ...
L2AD0    fcb   $5D,$27,$07,$A6,$80,$8D,$0A,$5A   ]'.&...Z
L2AD8    fcb   $26,$F9,$39,$86,$20,$20,$02,$86   &y9.  ..
L2AE0    fcb   $2E,$34,$42,$33,$E8,$C0,$11,$93   .4B3h@..
L2AE8    fcb   $82,$22,$0C,$81,$0D,$27,$08,$86   ."...'..
L2AF0    fcb   $50,$97,$36,$97,$DE,$20,$08,$DE   P.6.^ .^
L2AF8    fcb   $82,$A7,$C0,$DF,$82,$0C,$7D,$35   .'@_..}5
L2B00    fcb   $C2,$86,$30,$5D,$27,$05,$8D,$D9   B.0]'..Y
L2B08    fcb   $5A,$26,$FB,$39,$0D,$78,$27,$CB   Z&.9.x'K
L2B10    fcb   $0D,$78,$27,$F7,$86,$2D,$20,$C9   .x'w.- I
L2B18    fcb   $86,$2B,$20,$C5,$86,$20,$20,$E3   .+ E.  c
L2B20    fcb   $8D,$BF,$A6,$80,$81,$FF,$26,$F8   .?&...&x
L2B28    fcb   $39,$34,$10,$AE,$21,$8D,$F3,$4F   94..!.sO
L2B30    fcb   $35,$90,$34,$10,$30,$8D,$FA,$D8   5.4.0.zX
L2B38    fcb   $A6,$22,$26,$F1,$30,$8D,$FA,$D5   &"&q0.zU
L2B40    fcb   $20,$EB,$34,$50,$32,$7B,$30,$E4    k4P2{0d
L2B48    fcb   $17,$FD,$2C,$8D,$C3,$96,$76,$30   ..,.C.v0
L2B50    fcb   $E4,$17,$FF,$7A,$32,$65,$4F,$35   d..z2eO5
L2B58    fcb   $D0,$1F,$89,$34,$40,$DE,$82,$D0   P..4@^.P
L2B60    fcb   $7D,$23,$02,$8D,$B7,$4F,$35,$C0   }#..7O5@
L2B68    fcb   $17,$FF,$70,$96,$7D,$84,$0F,$81   ..p.}...
L2B70    fcb   $01,$27,$0C,$17,$FF,$65,$20,$F3   .'...e s
L2B78    fcb   $86,$0D,$0F,$7D,$17,$FF,$62,$4F   ...}..bO
L2B80    fcb   $39,$34,$40,$86,$04,$33,$A4,$6D   94@..3$m
L2B88    fcb   $C4,$26,$03,$47,$33,$41,$97,$86   D&.G3A..
L2B90    fcb   $1F,$89,$57,$17,$01,$94,$35,$C0   ..W...5@
L2B98    fcb   $5F,$D7,$87,$81,$3C,$27,$0C,$81   _W..<'..
L2BA0    fcb   $3E,$26,$03,$5C,$20,$05,$81,$5E   >&.\ ..^
L2BA8    fcb   $26,$05,$5A,$D7,$87,$A6,$80,$81   &.ZW.&..
L2BB0    fcb   $2C,$27,$38,$81,$FF,$26,$12,$96   ,'8..&..
L2BB8    fcb   $94,$27,$04,$30,$1F,$20,$15,$9E   .'.0. ..
L2BC0    fcb   $8E,$0D,$DC,$27,$08,$0F,$DC,$20   ..\'..\ 
L2BC8    fcb   $22,$81,$29,$27,$03,$1A,$01,$39   ".)'...9
L2BD0    fcb   $96,$94,$27,$F9,$0A,$92,$26,$11   ..'y..&.
L2BD8    fcb   $DE,$46,$37,$22,$97,$92,$10,$9F   ^F7"....
L2BE0    fcb   $90,$DF,$46,$A6,$80,$0A,$94,$20   ._F&... 
L2BE8    fcb   $C6,$9E,$90,$9F,$8C,$1C,$FE,$39   F......9
L2BF0    fcb   $49,$00,$DF,$48,$00,$DC,$52,$00   I._H.\R.
L2BF8    fcb   $CF,$45,$00,$CC,$53,$00,$D3,$42   OE.LS.SB
L2C00    fcb   $00,$D0,$54,$00,$0A,$58,$00,$12   .PT..X..
L2C08    fcb   $27,$00,$1A,$00,$8D,$A1,$25,$64   '....!%d
L2C10    fcb   $D6,$86,$17,$FF,$46,$20,$28,$8D   V...F (.
L2C18    fcb   $96,$25,$59,$D6,$86,$17,$FE,$FC   .%YV....
L2C20    fcb   $20,$1D,$81,$FF,$27,$4E,$81,$27    ...'N.'
L2C28    fcb   $26,$08,$A6,$80,$8D,$81,$25,$44   &.&...%D
L2C30    fcb   $20,$0D,$17,$FE,$AC,$A6,$80,$20    ...,&. 
L2C38    fcb   $E9,$34,$30,$0F,$DC,$0C,$DC,$9E   i40.\.\.
L2C40    fcb   $8C,$8D,$4C,$25,$19,$81,$28,$26   ..L%..(&
L2C48    fcb   $2F,$96,$92,$D7,$92,$27,$29,$0C   /..W.').
L2C50    fcb   $94,$DE,$46,$10,$9E,$90,$36,$22   .^F...6"
L2C58    fcb   $DF,$46,$9F,$90,$A6,$80,$31,$8D   _F..&.1.
L2C60    fcb   $FF,$8E,$5F,$34,$02,$A8,$A4,$84   .._4.($.
L2C68    fcb   $DF,$35,$02,$27,$12,$31,$23,$5C   _5.'.1#\
L2C70    fcb   $6D,$A4,$26,$EF,$C6,$3F,$20,$02   m$&oF? .
L2C78    fcb   $C6,$3E,$D7,$36,$43,$35,$B0,$D7   F>W6C50W
L2C80    fcb   $85,$EC,$21,$31,$AB,$8D,$08,$24   .l!1+..$
L2C88    fcb   $02,$C6,$01,$D7,$86,$6E,$A4,$8D   .F.W.n$.
L2C90    fcb   $18,$25,$25,$1F,$89,$8D,$12,$25   .%%....%
L2C98    fcb   $1C,$8D,$20,$8D,$0C,$25,$16,$8D   .. ..%..
L2CA0    fcb   $1A,$4D,$27,$01,$5F,$A6,$80,$20   .M'._&. 
L2CA8    fcb   $0C,$A6,$80,$81,$30,$25,$09,$81   .&..0%..
L2CB0    fcb   $39,$22,$05,$80,$30,$1C,$FE,$39   9"..0..9
L2CB8    fcb   $1A,$01,$39,$34,$02,$86,$0A,$3D   ..94...=
L2CC0    fcb   $EB,$E0,$89,$00,$39,$81,$2E,$26   k`..9..&
L2CC8    fcb   $AB,$8D,$C4,$25,$A7,$D7,$89,$17   +.D%'W..
L2CD0    fcb   $FE,$C6,$25,$A0,$35,$30,$0C,$DC   .F% 50.\
L2CD8    fcb   $D6,$85,$10,$27,$00,$A2,$5A,$27   V..'."Z'
L2CE0    fcb   $12,$5A,$10,$27,$01,$50,$5A,$10   .Z.'.PZ.
L2CE8    fcb   $27,$01,$F2,$5A,$10,$27,$00,$FB   '.rZ.'..
L2CF0    fcb   $16,$00,$DE,$9D,$16,$81,$04,$25   ..^....%
L2CF8    fcb   $10,$EE,$21,$5F,$A6,$C0,$81,$FF   .n!_&@..
L2D00    fcb   $27,$03,$5C,$26,$F7,$EE,$21,$20   '.\&wn! 
L2D08    fcb   $21,$33,$21,$A6,$A4,$81,$02,$26   !3!&$..&
L2D10    fcb   $04,$C6,$05,$20,$15,$81,$01,$26   .F. ...&
L2D18    fcb   $06,$C6,$02,$D1,$86,$25,$04,$C6   .F.Q.%.F
L2D20    fcb   $01,$33,$41,$1F,$98,$48,$91,$86   .3A..H..
L2D28    fcb   $22,$36,$0D,$87,$27,$28,$2B,$0D   "6..'(+.
L2D30    fcb   $34,$04,$58,$34,$04,$D6,$86,$E0   4.X4.V.`
L2D38    fcb   $E0,$25,$19,$20,$0C,$34,$04,$58   `%. .4.X
L2D40    fcb   $34,$04,$D6,$86,$E0,$E0,$25,$0C   4.V.``%.
L2D48    fcb   $57,$34,$04,$96,$86,$A0,$E0,$97   W4... `.
L2D50    fcb   $86,$17,$FD,$C8,$35,$04,$A6,$C4   ...H5.&D
L2D58    fcb   $44,$44,$44,$44,$8D,$12,$27,$0E   DDDD..'.
L2D60    fcb   $A6,$C0,$8D,$0C,$27,$08,$5A,$26   &@..'.Z&
L2D68    fcb   $ED,$D6,$86,$17,$FD,$AE,$4F,$39   mV....O9
L2D70    fcb   $84,$0F,$81,$09,$23,$02,$8B,$07   ....#...
L2D78    fcb   $17,$FD,$4F,$0A,$86,$39,$43,$39   ..O..9C9
L2D80    fcb   $9D,$16,$81,$02,$25,$05,$26,$F6   ....%.&v
L2D88    fcb   $17,$F7,$DA,$34,$50,$32,$7B,$30   .wZ4P2{0
L2D90    fcb   $E4,$17,$FA,$E3,$D6,$86,$5A,$D0   d.zcV.ZP
L2D98    fcb   $76,$2A,$07,$32,$65,$35,$50,$16   v*.2e5P.
L2DA0    fcb   $01,$32,$0D,$87,$27,$0A,$2B,$19   .2..'.+.
L2DA8    fcb   $17,$FD,$71,$17,$FD,$5E,$20,$17   ..q..^ .
L2DB0    fcb   $17,$FD,$59,$34,$04,$96,$76,$17   ..Y4..v.
L2DB8    fcb   $FD,$14,$35,$04,$17,$FD,$5D,$20   ..5...] 
L2DC0    fcb   $0B,$17,$FD,$48,$17,$FD,$3A,$96   ...H..:.
L2DC8    fcb   $76,$17,$FD,$02,$32,$65,$4F,$35   v...2eO5
L2DD0    fcb   $D0,$9D,$16,$81,$03,$26,$A7,$34   P....&'4
L2DD8    fcb   $50,$30,$8D,$F8,$33,$C6,$04,$A6   P0.x3F.&
L2DE0    fcb   $22,$26,$1C,$30,$8D,$F8,$2E,$C6   "&.0.x.F
L2DE8    fcb   $05,$20,$14,$9D,$16,$81,$04,$26   . .....&
L2DF0    fcb   $8D,$34,$50,$AE,$21,$DC,$48,$A3   .4P.!\H#
L2DF8    fcb   $21,$83,$00,$01,$4D,$26,$04,$D1   !...M&.Q
L2E00    fcb   $86,$23,$02,$D6,$86,$1F,$98,$50   .#.V...P
L2E08    fcb   $DB,$86,$0D,$87,$27,$0E,$2B,$10   [...'.+.
L2E10    fcb   $34,$02,$17,$FD,$07,$35,$02,$17   4....5..
L2E18    fcb   $FC,$B4,$20,$17,$34,$04,$20,$0B   .4 .4. .
L2E20    fcb   $54,$24,$01,$5C,$34,$06,$17,$FC   T$.\4...
L2E28    fcb   $F3,$35,$02,$17,$FC,$A0,$35,$04   s5... 5.
L2E30    fcb   $17,$FC,$E9,$4F,$35,$D0,$9D,$16   ..iO5P..
L2E38    fcb   $81,$02,$27,$07,$10,$24,$FF,$3E   ..'..$.>
L2E40    fcb   $17,$F7,$25,$34,$50,$32,$76,$30   .w%4P2v0
L2E48    fcb   $E4,$17,$FA,$74,$96,$79,$81,$09   d.zt.y..
L2E50    fcb   $2E,$11,$17,$00,$E2,$96,$86,$80   ....b...
L2E58    fcb   $02,$2B,$08,$90,$89,$2B,$04,$90   .+...+..
L2E60    fcb   $8A,$2A,$06,$32,$6A,$35,$50,$20   .*.2j5P 
L2E68    fcb   $6B,$97,$88,$30,$E4,$D6,$87,$27   k..0dV.'
L2E70    fcb   $08,$2B,$0C,$8D,$41,$8D,$14,$20   .+..A.. 
L2E78    fcb   $0D,$8D,$10,$8D,$39,$20,$07,$8D   ....9 ..
L2E80    fcb   $35,$8D,$0B,$17,$FC,$86,$32,$6A   5.....2j
L2E88    fcb   $4F,$35,$D0,$17,$FC,$7E,$96,$8A   O5P..~..
L2E90    fcb   $17,$FC,$3B,$17,$FC,$49,$D6,$79   ..;..IVy
L2E98    fcb   $2A,$2C,$50,$D1,$89,$23,$02,$D6   *,PQ.#.V
L2EA0    fcb   $89,$34,$04,$17,$FC,$5B,$D6,$89   .4...[V.
L2EA8    fcb   $E0,$E0,$D7,$89,$96,$8B,$91,$89   ``W.....
L2EB0    fcb   $23,$02,$96,$89,$20,$12,$D6,$88   #... .V.
L2EB8    fcb   $16,$FC,$61,$17,$FC,$4E,$96,$8A   ..a..N..
L2EC0    fcb   $17,$FC,$0B,$17,$FC,$19,$96,$8B   ........
L2EC8    fcb   $17,$FC,$03,$D6,$89,$D0,$8B,$2F   ...V.P./
L2ED0    fcb   $0B,$16,$FC,$2D,$D6,$86,$86,$2A   ...-V..*
L2ED8    fcb   $17,$FC,$28,$4F,$39,$9D,$16,$81   ..(O9...
L2EE0    fcb   $02,$27,$07,$10,$24,$FE,$97,$17   .'..$...
L2EE8    fcb   $F6,$7E,$34,$50,$32,$76,$30,$E4   v~4P2v0d
L2EF0    fcb   $17,$F9,$CD,$96,$79,$34,$02,$86   .yM.y4..
L2EF8    fcb   $01,$97,$79,$8D,$3A,$35,$02,$D6   ..y.:5.V
L2F00    fcb   $79,$C1,$01,$27,$01,$4C,$C6,$01   yA.'.LF.
L2F08    fcb   $D7,$8A,$97,$79,$96,$86,$80,$06   W..y....
L2F10    fcb   $2B,$08,$90,$89,$2B,$04,$90,$8A   +...+...
L2F18    fcb   $2A,$06,$32,$6A,$35,$50,$20,$B4   *.2j5P 4
L2F20    fcb   $97,$88,$D6,$87,$27,$09,$8D,$8E   ..V.'...
L2F28    fcb   $8D,$91,$17,$FB,$7A,$20,$05,$8D   ....z ..
L2F30    fcb   $8A,$17,$FB,$73,$16,$FF,$4F,$34   ...s..O4
L2F38    fcb   $10,$96,$79,$9B,$89,$26,$06,$A6   ..y..&.&
L2F40    fcb   $84,$81,$35,$24,$17,$4A,$2B,$30   ..5$.J+0
L2F48    fcb   $81,$07,$22,$2C,$30,$86,$E6,$01   ..",0.f.
L2F50    fcb   $C1,$35,$25,$24,$6C,$84,$E6,$84   A5%$l.f.
L2F58    fcb   $C1,$39,$23,$1C,$C6,$30,$E7,$84   A9#.F0g.
L2F60    fcb   $30,$1F,$AC,$E4,$24,$EE,$AE,$E4   0.,d$n.d
L2F68    fcb   $30,$08,$A6,$82,$A7,$01,$AC,$E4   0.&.'.,d
L2F70    fcb   $22,$F8,$86,$31,$A7,$84,$0C,$79   "x.1'..y
L2F78    fcb   $35,$10,$96,$79,$2A,$01,$4F,$97   5..y*.O.
L2F80    fcb   $8A,$40,$8B,$09,$2A,$01,$4F,$91   .@..*.O.
L2F88    fcb   $89,$23,$02,$96,$89,$97,$8B,$39   .#.....9
L2F90    fcb   $C6,$30,$D7,$36,$43,$39,$6F,$4E   F0W6C9oN
L2F98    fcb   $07                                .

         ENDC
