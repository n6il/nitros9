********************************************************************
* Procs - Show processes
*
* $Id$
*
* Ed.    Comments                                       Who YY/MM/DD
* ------------------------------------------------------------------
*  5     Original Tandy version                         BGP 02/04/05

         nam   Procs
         ttl   program module       

* Disassembled 02/04/05 13:22:14 by Disasm v1.6 (C) 1988 by RML

         ifp1
         use   defsfile
         endc

tylg     set   Prgrm+Objct   
atrv     set   ReEnt+rev
rev      set   $01

         mod   eom,name,tylg,atrv,start,size

u0000    rmb   1
u0001    rmb   1
AProc    rmb   2
WProc    rmb   2
SProc    rmb   2
u0008    rmb   2
u000A    rmb   1
u000B    rmb   2
u000D    rmb   87
u0064    rmb   132
u00E8    rmb   2156
u0954    rmb   450
size     equ   .

name     fcs   /Procs/
         fcb   $09 

L0013    fcb   C$LF
         fcc   "Usr #  id pty sta mem pri mod"
         fcb   C$CR
L0032    fcs   "----- --- --- --- --- -------"
L004F    fcc   " act"
         fcb   $A0 
L0054    fcc   " wai"
         fcb   $A0 
L0059    fcc   " sle"
         fcb   $A0 
L005E    fcb   C$LF
         fcc   "Usr #  id pty  state   mem primary module"
         fcb   C$CR
L0089    fcs   "----- --- --- -------- --- --------------"
L00B2    fcc   "  active "
         fcb   $A0 
L00BC    fcc   "  waiting"
         fcb   $A0 
L00C6    fcc   " sleeping"
         fcb   $A0 

start    clr   <u0001
         clr   <u0000
         pshs  y,x,b,a
         lda   #$01
         ldb   #SS.ScSiz
         os9   I$GetStt 
         bcc   L00E8
         cmpb  #E$UnkSvc
         beq   L00EF
         puls  y,x,b,a
         lbra  L01F1
L00E8    cmpx  #80
         beq   L00EF
         inc   <u0000
L00EF    puls  y,x,b,a
         lda   ,x+
         eora  #'E
         anda  #$DF
         bne   L00FB
         inc   <u0001
L00FB    leax  u000D,u
         stx   <u000B
         orcc  #IntMasks
         ldx   >D.AProcQ
         stx   <AProc
         ldx   >D.WProcQ
         stx   <WProc
         ldx   >D.SProcQ
         stx   <SProc
         ldx   >D.Proc
         ldd   P$User,x
         std   <u0008
         pshs  u
         leau  >u0954,u
         lda   #$01
         ldx   <AProc
         lbsr  L0287
         lda   #$02
         ldx   <WProc
         lbsr  L0287
         lda   #$03
         ldx   <SProc
         lbsr  L0287
         andcc #^IntMasks
         clra  
         clrb  
         pshu  b,a
         pshu  b,a
         puls  u
         tst   <u0000
         beq   L0156
         leay  >L0013,pcr
         lbsr  L01F4
         lbsr  L01FF
         leay  >L0032,pcr
         lbsr  L01F4
         lbsr  L01FF
         bra   L016A
L0156    leay  >L005E,pcr
         lbsr  L01F4
         lbsr  L01FF
         leay  >L0089,pcr
         lbsr  L01F4
         lbsr  L01FF
L016A    leax  >u0954,u
L016E    leax  -$09,x
         ldd   $05,x
         beq   L01F0
         ldd   $07,x
         lbsr  L0250
         lbsr  L0237
         ldb   ,x
         lbsr  L0214
         lbsr  L0237
         ldb   $03,x
         lbsr  L0214
         lda   $04,x
         tst   <u0000
         beq   L0195
         leay  >L004F,pcr
         bra   L0199
L0195    leay  >L00B2,pcr
L0199    cmpa  #$01
         beq   L01BD
         tst   <u0000
         beq   L01A7
         leay  >L0054,pcr
         bra   L01AB
L01A7    leay  >L00BC,pcr
L01AB    cmpa  #$02
         beq   L01BD
         tst   <u0000
         beq   L01B9
         leay  >L0059,pcr
         bra   L01BD
L01B9    leay  >L00C6,pcr
L01BD    bsr   L01F4
         ldb   $02,x
         bsr   L0214
         bsr   L0237
         ldy   $05,x
         ldd   $04,y
         leay  d,y
         bsr   L01F4
         bsr   L0237
         tst   <u0000
         bne   L01EB
         lda   #'<
         bsr   L023B
         lda   $01,x
         lbsr  L02B5
         bcs   L01EB
         ldy   $03,y
         ldy   $04,y
         ldd   $04,y
         leay  d,y
         bsr   L01F4
L01EB    bsr   L01FF
         lbra  L016E
L01F0    clrb  
L01F1    os9   F$Exit   
L01F4    lda   ,y
         anda  #$7F
         bsr   L023B
         lda   ,y+
         bpl   L01F4
         rts   
L01FF    pshs  y,x,a
         lda   #C$CR
         bsr   L023B
         leax  u000D,u
         stx   <u000B
         ldy   #80
         lda   #$01
         os9   I$WritLn 
         puls  pc,y,x,a
L0214    clr   <u000A
         lda   #$FF
L0218    inca  
         subb  #$64
         bcc   L0218
         bsr   L022E
         lda   #$0A
L0221    deca  
         addb  #$0A
         bcc   L0221
         bsr   L022E
         tfr   b,a
         adda  #$30
         bra   L023B
L022E    tsta  
         beq   L0233
         sta   <u000A
L0233    tst   <u000A
         bne   L0239
L0237    lda   #$F0
L0239    adda  #$30
L023B    pshs  x
         ldx   <u000B
         sta   ,x+
         stx   <u000B
         puls  pc,x
L0245    fcb   $27,$10,$03,$e8,$00,$64,$00,$0a,$00,$01,$ff
L0250    pshs  x,y,a,b
         leax  <L0245,pcr
         ldy   #$2F20
L0259    leay  >$0100,y
         subd  ,x
         bcc   L0259
         addd  ,x++
         pshs  b,a
         tfr   y,d
         tst   ,x
         bmi   L0281
         ldy   #$2F30
         cmpd  #$3020
         bne   L027B
         ldy   #$2F20
         lda   #C$SPAC
L027B    bsr   L023B
         puls  b,a
         bra   L0259
L0281    bsr   L023B
         leas  $02,s
         puls  pc,y,x,b,a
L0287    pshs  y,b,a
         leax  ,x		point to first entry in queue
         beq   L02B3
L028D    ldd   P$User,x
         tst   <u0001
         bne   L0298
         cmpd  <u0008
         bne   L02AF
L0298    pshu  b,a
         lda   P$Prior,x
         ldb   ,s
         ldy   <P$PModul,x
         pshu  y,b,a
         lda   P$PagCnt,x
         pshu  a
         lda   P$ID,x
         ldb   <P$PATH,x
         pshu  b,a
L02AF    ldx   P$Queue,x
         bne   L028D
L02B3    puls  pc,y,b,a
L02B5    pshs  x,b,a
         ldx   >D.PthDBT
         tsta  
         beq   L02CC
         clrb  
         lsra  
         rorb  
         lsra  
         rorb  
         lda   a,x
         tfr   d,y
         beq   L02CC
         tst   ,y
         bne   L02CD
L02CC    coma  
L02CD    puls  pc,x,b,a

         emod
eom      equ   *
         end
