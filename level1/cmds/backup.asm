********************************************************************
* Backup - Make a backup copy of a disk
*
* $Id$
*
* Ed.    Comments                                       Who YY/MM/DD
* ------------------------------------------------------------------
*   8    From Tandy OS-9 Level One VR 02.00.00

         nam   Backup
         ttl   Make a backup copy of a disk

* Disassembled 02/04/03 23:08:04 by Disasm v1.6 (C) 1988 by RML

         ifp1
         use   defsfile
         endc

DOHELP   set   0

tylg     set   Prgrm+Objct   
atrv     set   ReEnt+rev
rev      set   $01
edition  set   $08

         mod   eom,name,tylg,atrv,start,size

u0000    rmb   1
u0001    rmb   1
u0002    rmb   2
u0004    rmb   5
u0009    rmb   1
u000A    rmb   1
u000B    rmb   1
u000C    rmb   1
u000D    rmb   1
u000E    rmb   1
u000F    rmb   1
u0010    rmb   1
u0011    rmb   2
u0013    rmb   1
u0014    rmb   1
u0015    rmb   32
u0035    rmb   32
u0055    rmb   2
u0057    rmb   424
u01FF    rmb   81
u0250    rmb   256
u0350    rmb   3840
size     equ   .

name     fcs   /Backup/
         fcb   edition

L0014    fcc   "/d0 /d1"
         fcb   C$CR
         IFNE  DOHELP
HelpMsg  fcb   C$LF
         fcc   "Use: Backup [e] [s] [-v]"
         fcb   C$LF
         fcc   "            [/dev1 [/dev2]]"
         fcb   C$LF
         fcc   "  e - abort if read error"
         fcb   C$LF
         fcc   "  s - single drive prompts"
         fcb   C$LF
         fcc   " -v - inhibit verify pass"
         ENDC
L00A0    fcb   $8D 
L00A1    fcc   "Ready to backup from"
L00B5    fcb   $A0 
L00B6    fcc   " to"
         fcb   $A0 
L00BA    fcc   "Ok"
L00BC    fcc   " ?:"
         fcb   $A0 
L00C0    fcc   "Ready Source, hit a key:"
         fcb   $A0 
L00D9    fcc   "Ready Destination, hit a key:"
         fcb   $A0 
L00F7    fcs   "Sector $"
L00FF    fcs   "Sectors   copied: $"
L0112    fcb   C$LF
         fcc   "Verify pass"
         fcb   $8D 
L011F    fcs   "Sectors verified: $"
L0132    fcb   C$LF
         fcc   " is being scratched"
         fcb   $8D 
L0147    fcc   "Disks not formatted identically"
         fcb   C$LF
L0167    fcc   "Backup Aborted"
         fcb   $8D 

start    leas  >u01FF,u
         pshs  b,a
         pshs  u
         tfr   y,d
         subd  ,s++
         subd  #$0250
         sta   <u0013
         clr   <u000B
         clr   <u000A
         clr   <u000C
         clr   <u000D
         leay  <u0057,u
         sty   <u0055
         ldd   ,s++
         beq   L01E3
L0199    ldd   ,x+
         cmpa  #C$SPAC
         beq   L0199
         cmpa  #C$COMA
         beq   L0199
         eora  #'E
         anda  #$DF
         bne   L01B1
         cmpb  #$30
         bcc   L01B1
         inc   <u000A
         bra   L0199
L01B1    lda   -$01,x
         eora  #'S
         anda  #$DF
         bne   L01C1
         cmpb  #$30
         bcc   L01C1
         inc   <u000B
         bra   L0199
L01C1    ldd   -$01,x
         cmpa  #'-
         bne   L01D7
         eorb  #'V
         andb  #$DF
         bne   L01D7
         ldd   ,x+
         cmpb  #$30
         bcc   L01D7
         inc   <u000C
         bra   L0199
L01D7    lda   ,-x
         cmpa  #PDELIM
         beq   L01E7
         cmpa  #C$CR
         lbne  ShowHelp
L01E3    leax  >L0014,pcr
L01E7    leay  >L00A1,pcr
         lbsr  L044B
         ldy   <u0055
         sty   <u0002
         lbsr  L043A
L01F7    lda   ,x+
         cmpa  #C$SPAC
         beq   L01F7
         cmpa  #C$COMA
         beq   L01F7
         cmpa  #C$CR
         bne   L020B
         inc   <u000B
         ldx   <u0002
         lda   ,x+
L020B    cmpa  #PDELIM
         lbne  ShowHelp
         leax  -$01,x
         leay  >L00B6,pcr
         lbsr  L044B
         ldy   <u0055
         sty   <u0004
         lbsr  L043A
         leay  >L00BC,pcr
         lbsr  L0421
         comb  
         eora  #'Y
         anda  #$DF
         lbne  L03BA
         ldx   <u0002
         ldd   #$4020
L0238    cmpb  ,x+
         bne   L0238
         std   -$01,x
         ldx   <u0002
         lda   #READ.
         os9   I$Open   
         bcs   L027C
         leax  >u0350,u
         ldy   #$0100
         os9   I$Read   
         bcs   L027C
         os9   I$Close  
         ldx   <u0002
         lda   #READ.
         os9   I$Open   
         bcs   L027C
         sta   <u0000
         ldx   <u0004
         leay  <u0015,u
L0267    ldb   ,x+
         stb   ,y+
         cmpb  #C$SPAC
         bne   L0267
         ldd   #$4020
         std   -$01,y
         leax  <u0015,u
         lda   #READ.+WRITE.
         os9   I$Open   
L027C    lbcs  L03AF
         sta   <u0001
         clr   <u000E
         clr   <u000F
         clr   <u0010
         lbsr  L0419
         lda   <u0001
         leax  >u0250,u
         ldy   #$0100
         os9   I$Read   
         pshs  u,x
         ldx   #$0000
         leau  ,x
         os9   I$Seek   
         puls  u,x
         bcs   L027C
         ldd   >$0100,x
         cmpd  ,x
         bne   L02B7
         ldb   >$0102,x
         cmpb  $02,x
         beq   L02BE
L02B7    leay  >L0147,pcr
         lbra  L03B6
L02BE    leax  >u0250,u
         lda   #$BF
         sta   <$3F,x
         leay  <$1F,x
         lbsr  L044B
         leay  >L0132,pcr
         lbsr  L0456
         leay  >L00BA,pcr
         lbsr  L0421
         comb  
         eora  #'Y
         anda  #$DF
         lbne  L03BA
         lda   <u0001
         leax  >u0350,u
         ldy   #$0100
         os9   I$Write  
         lbcs  L03AF
         pshs  u
         ldx   #$0000
         leau  ,x
         os9   I$Seek   
         puls  u
         leax  >u0350,u
         os9   I$Read   
         lbcs  L03AF
         os9   I$Close  
         leax  <u0015,u
         lda   #$02
         os9   I$Open   
         lbcs  L03AF
         sta   <u0001
         leax  <u0035,u
         ldb   #SS.OPT
         os9   I$GetStt 
         ldb   #$01
         stb   $08,x
         ldb   #SS.OPT
         os9   I$SetStt 
         lbcs  L03AF
L0332    leay  >L00C0,pcr
         lbsr  L041D
         lda   <u0013
         sta   <u0014
         leax  >u0250,u
         lbsr  L0403
         lbsr  L0419
         ldd   <u0011
         leax  >u0250,u
         stx   <u0011
         subd  <u0011
         beq   L035C
         tfr   d,y
         lda   <u0001
         os9   I$Write  
         bcs   L03AF
L035C    lda   <u000D
         cmpa  #E$EOF
         bne   L0332
         leay  >L00FF,pcr
         lbsr  L0470
         tst   <u000C
         bne   L03BA
         leay  >L0112,pcr
         lbsr  L0456
         lda   <u0000
         os9   I$Close  
         bcs   L03AF
         lda   <u0001
         os9   I$Close  
         bcs   L03AF
         leax  <u0015,u
         lda   #READ.
         os9   I$Open   
         bcs   L03AF
         sta   <u0000
         clr   <u000E
         clr   <u000F
         clr   <u0010
         clr   <u000D
L0396    lda   <u0013
         sta   <u0014
         leax  >u0250,u
         bsr   L0403
         lda   <u000D
         cmpa  #E$EOF
         bne   L0396
         leay  >L011F,pcr
         lbsr  L0470
         bra   L03BA
L03AF    os9   F$PErr   
         leay  >L0167,pcr
L03B6    lbsr  L0456
         comb  
L03BA    ldb   #$00
         os9   F$Exit   
L03BF    ldy   #$0100
         lda   <u0000
         os9   I$Read   
         bcc   L03DC
         stb   <u000D
         cmpb  #E$EOF
         beq   L040D
         lbsr  L046C
         ldb   <u000D
         tst   <u000A
         bne   L03AF
         os9   F$PErr   
L03DC    ldd   <u000F
         addd  #$0001
         std   <u000F
         bcc   L03E7
         inc   <u000E
L03E7    tst   <u000D
         beq   L03FD
         pshs  u
         ldx   <u000E
         tfr   b,a
         clrb  
         tfr   d,u
         lda   <u0000
         os9   I$Seek   
         puls  u
         clr   <u000D
L03FD    ldx   <u0011
         leax  >$0100,x
L0403    stx   <u0011
         lda   <u0014
         suba  #$01
         sta   <u0014
         bcc   L03BF
L040D    rts   
ShowHelp equ   *
         IFNE  DOHELP
         leax  <u0057,u
         stx   <u0055
         leay  >HelpMsg,pcr
         bra   L03B6
         ELSE
         bra   L03BA
         ENDC
L0419    leay  >L00D9,pcr
L041D    tst   <u000B
         beq   L0439
L0421    bsr   L0456
         pshs  y,x,b,a
         leax  ,s
         ldy   #$0001
         clra  
         os9   I$Read   
         leay  >L00A0,pcr
         bsr   L0456
         puls  y,x,b,a
         anda  #$7F
L0439    rts   
L043A    pshs  x
         os9   F$PrsNam 
         puls  x
         bcs   ShowHelp
L0443    lda   ,x+
         bsr   L04A5
         decb  
         bpl   L0443
         rts   
L044B    lda   ,y
         anda  #$7F
         bsr   L04A5
         lda   ,y+
         bpl   L044B
L0455    rts   
L0456    bsr   L044B
         pshs  y,x,a
         ldd   <u0055
         leax  <u0057,u
         stx   <u0055
         subd  <u0055
         tfr   d,y
         lda   #$02
         os9   I$WritLn 
         puls  pc,y,x,a
L046C    leay  >L00F7,pcr
L0470    bsr   L044B
         lda   <u000E
         bsr   L0486
         inc   <u0009
         lda   <u000F
         bsr   L0488
         lda   <u0010
         bsr   L0488
         leay  >L00B5,pcr
         bra   L0456
L0486    clr   <u0009
L0488    pshs  a
         lsra  
         lsra  
         lsra  
         lsra  
         bsr   L0494
         puls  a
         anda  #$0F
L0494    tsta  
         beq   L0499
         sta   <u0009
L0499    tst   <u0009
         beq   L0455
         adda  #$30
         cmpa  #$39
         bls   L04A5
         adda  #$07
L04A5    pshs  x
         ldx   <u0055
         sta   ,x+
         stx   <u0055
         puls  pc,x

         emod
eom      equ   *
         end
