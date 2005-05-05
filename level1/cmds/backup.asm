********************************************************************
* Backup - Make a backup copy of a disk
*
* $Id$
*
* Edt/Rev  YYYY/MM/DD  Modified by
* Comment
* ------------------------------------------------------------------
*   8      ????/??/??
* From Tandy OS-9 Level Two VR 02.00.01.
*
*   9      2005/5/3    Robert Gault
* Folded in a new option F to permit a .dsk image file to be used
* instead of dev1. Full path or local file can be used. There is
* still a comparison of LSN0 to make sure that a disk actually has
* been formatted for the correct number of sides and tracks.

         nam   Backup
         ttl   Make a backup copy of a disk

* Disassembled 02/04/03 23:08:04 by Disasm v1.6 (C) 1988 by RML

         ifp1
         use   defsfile
         endc

DOHELP   set   1

tylg     set   Prgrm+Objct   
atrv     set   ReEnt+rev
rev      set   $00
edition  set   $09

         mod   eom,name,tylg,atrv,start,size

srcpath  rmb   1        path of source disk
dstpath  rmb   1        path of destination disk
u0002    rmb   2
u0004    rmb   5
u0009    rmb   1
errabrt  rmb   1        abort if read error flag (1 = abort, 0 = don't)
pmptsng  rmb   1        single disk copy prompt flag (1 = prompt for single, 0 = don't)
dontvfy  rmb   1        don't verify backup (1 = Don't!, 0 = do)
fileflg  rmb   1        0 = disk, 1 = file (.dsk) to disk; RG
u000D    rmb   1
u000E    rmb   1
u000F    rmb   1
u0010    rmb   1
u0011    rmb   2
u0013    rmb   1
u0014    rmb   1
u0015    rmb   32
u0035    rmb   32
bufptr   rmb   2        buffer pointer
strbuf   rmb   424      buffer
u01FF    rmb   81
u0250    rmb   256
u0350    rmb   3840
size     equ   .

name     fcs   /Backup/
         fcb   edition

L0014    fcc   "/d0 /d1"
         fcb   C$CR
         IFNE  DOHELP
* Added F option; RG
HelpMsg  fcb   C$LF
         fcc   "Use: Backup [e] [f] [s] [-v]"
         fcb   C$LF
         fcc   "            [/dev1 [/dev2]]"
         fcb   C$LF
         fcc   "  e - abort if read error"
         fcb   C$LF
         fcc   "  f - replace dev1 with .dsk image file"
         fcb   C$LF
         fcc   "  s - single drive prompts"
         fcb   C$LF
         fcc   " -v - inhibit verify pass"
         ENDC
L00A0    fcb   $80+C$CR
L00A1    fcc   "Ready to backup from"
L00B5    fcb   $80+C$SPAC
L00B6    fcs   " to "
L00BA    fcc   "Ok"
L00BC    fcs   " ?: "
L00C0    fcs   "Ready Source, hit a key: "
L00D9    fcs   "Ready Destination, hit a key: "
L00F7    fcs   "Sector $"
L00FF    fcs   "Sectors   copied: $"
L0112    fcb   C$LF
         fcc   "Verify pass"
         fcb   $80+C$CR
L011F    fcs   "Sectors verified: $"
L0132    fcb   C$LF
         fcc   " is being scratched"
         fcb   $80+C$CR
NotSame  fcc   "Disks not formatted identically"
         fcb   C$LF
L0167    fcc   "Backup Aborted"
         fcb   $80+C$CR

start    leas  >u01FF,u
         pshs  b,a
         pshs  u
         tfr   y,d
         subd  ,s++
         subd  #$0250
         sta   <u0013
         clr   <pmptsng
         clr   <fileflg
         clr   <errabrt
         clr   <dontvfy
         clr   <u000D
         leay  <strbuf,u      get address of our buffer
         sty   <bufptr        and save its pointer here
         ldd   ,s++
         beq   L01E3
L0199    ldd   ,x+            get two bytes of command line prompt
         cmpa  #C$SPAC        space?
         beq   L0199          continue if so
         cmpa  #C$COMA        comma?
         beq   L0199          continue if so
         eora  #'E            check for "abort if read error" flag
         anda  #$DF           mask it
         bne   Chk4S          branch if not option
         cmpb  #'0
         bcc   Chk4S          branch if char after option is > $30
         inc   <errabrt       else set flag
         bra   L0199          and continue parsing
Chk4S    lda   -$01,x         load A with prev char and backup X one byte
         eora  #'S            check for "single drive prompts" flag
         anda  #$DF           mask it
         bne   Chkimg         branch if not option
         cmpb  #'0
         bcc   L01C1          branch if char after option is > $30
         inc   <pmptsng       else set flag
         bra   L0199          and continue parsing
* New routine to check for new option F; RG
Chkimg   lda   -1,x           get prev char
         eora  #'F            test for disk image to drive
         anda  #$DF
         bne   L01C1
         cmpb  #'0
         bcc   L01C1
         inc   <fileflg        update flag
         bra   L0199           keep reading
* End of new routine
L01C1    ldd   -$01,x         load A with prev char and backup X one byte
         cmpa  #'-            dash?
         bne   L01D7          branch if not
         eorb  #'V
         andb  #$DF
         bne   L01D7
         ldd   ,x+
         cmpb  #'0
         bcc   L01D7
         inc   <dontvfy
         bra   L0199
L01D7    lda   ,-x
         tst   <fileflg       Don't look for / if image file, take anything; RG
         bne   L01E7
         cmpa  #PDELIM        path delimiter?
         beq   L01E7          branch if so
         cmpa  #C$CR          carriage return?
         lbne  ShowHelp       if not, show some help
L01E3    leax  >L0014,pcr
L01E7    leay  >L00A1,pcr     ready to backup
         lbsr  L044B          ready message
         ldy   <bufptr
         sty   <u0002
         tst   <fileflg       don't use F$PrsNam if an image file;RG
         bne   L01F7a
         lbsr  L043A          parse name
         bra   L01F7
L01F7a   lbsr  getnm          look for space or comma if file instead of device; RG
L01F7    lda   ,x+
         cmpa  #C$SPAC
         beq   L01F7
         cmpa  #C$COMA
         beq   L01F7
         cmpa  #C$CR
         bne   L020B
         inc   <pmptsng
         ldx   <u0002
         lda   ,x+
L020B    cmpa  #PDELIM        path delimiter?
         lbne  ShowHelp       if not, show some help
         leax  -$01,x
         leay  >L00B6,pcr     "to"
         lbsr  L044B          print
         ldy   <bufptr
         sty   <u0004
         lbsr  L043A          parse path
         leay  >L00BC,pcr
         lbsr  L0421
         comb  
         eora  #'Y
         anda  #$DF
         lbne  L03BA
         tst   <fileflg
         bne   L0238b         if file instead of device don't add @
         ldx   <u0002
         ldd   #'@*256+C$SPAC
L0238    cmpb  ,x+
         bne   L0238
         std   -$01,x
L0238b   ldx   <u0002
         lda   #READ.
         os9   I$Open         open source device (the one we're backing up)
         bcs   L027C          branch if error
         leax  >u0350,u
         ldy   #256
         os9   I$Read         read LSN 0
         bcs   L027C
         os9   I$Close  
         ldx   <u0002
         lda   #READ.
         os9   I$Open   
         bcs   L027C
         sta   <srcpath      save path to source
         ldx   <u0004
         leay  <u0015,u
L0267    ldb   ,x+
         stb   ,y+
         cmpb  #C$SPAC
         bne   L0267
         ldd   #'@*256+C$SPAC
         std   -$01,y
         leax  <u0015,u
         lda   #READ.+WRITE.
         os9   I$Open        open destination device (the one we're writing to)
L027C    lbcs  L03AF
         sta   <dstpath      save destination path
         clr   <u000E
         clr   <u000F
         clr   <u0010
         lbsr  L0419
         lda   <dstpath      get destination path
         leax  >u0250,u
         ldy   #256
         os9   I$Read        read LSN0
         pshs  u,x
         ldx   #$0000
         leau  ,x
         os9   I$Seek        reseek to start of disk
         puls  u,x
         bcs   L027C         branch if error
         ldd   >256,x        check for source/dest disk having same format
         cmpd  ,x
         bne   DsksNOk       branch if different
         ldb   >$0102,x
         cmpb  $02,x
         beq   DsksOk
DsksNOk  leay  >NotSame,pcr
         lbra  L03B6
DsksOk   leax  >u0250,u
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
         lda   <dstpath     get destination path
         leax  >u0350,u
         ldy   #256
         os9   I$Write  
         lbcs  L03AF
         pshs  u
         ldx   #$0000
         leau  ,x
         os9   I$Seek       seek to LSN0
         puls  u
         leax  >u0350,u
         os9   I$Read   
         lbcs  L03AF
         os9   I$Close      close path
         leax  <u0015,u
         lda   #WRITE.
         os9   I$Open       open destination in write only mode
         lbcs  L03AF
         sta   <dstpath     save new destination path
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
         lda   <dstpath
         os9   I$Write  
         bcs   L03AF
L035C    lda   <u000D
         cmpa  #E$EOF
         bne   L0332
         leay  >L00FF,pcr
         lbsr  L0470
         tst   <dontvfy
         bne   L03BA
* Verification code
         leay  >L0112,pcr
         lbsr  L0456
         lda   <srcpath
         os9   I$Close        close source path
         bcs   L03AF
         lda   <dstpath
         os9   I$Close        close destination path
         bcs   L03AF
         leax  <u0015,u
         lda   #READ.
         os9   I$Open         open source path in READ mode
         bcs   L03AF
         sta   <srcpath       save newly acquired path number
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
L03BF    ldy   #256
         lda   <srcpath
         os9   I$Read   
         bcc   L03DC
         stb   <u000D
         cmpb  #E$EOF
         beq   L040D
         lbsr  L046C
         ldb   <u000D
         tst   <errabrt
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
         lda   <srcpath
         os9   I$Seek   
         puls  u
         clr   <u000D
L03FD    ldx   <u0011
         leax  >256,x
L0403    stx   <u0011
         lda   <u0014
         suba  #$01
         sta   <u0014
         bcc   L03BF
L040D    rts   

ShowHelp equ   *
         IFNE  DOHELP
         leax  <strbuf,u     get address of buffer
         stx   <bufptr       store as current buffer pointer
         leay  >HelpMsg,pcr  point to help message data
         bra   L03B6
         ELSE
         bra   L03BA
         ENDC
L0419    leay  >L00D9,pcr
L041D    tst   <pmptsng
         beq   L0439
L0421    bsr   L0456
         pshs  y,x,b,a
         leax  ,s
         ldy   #$0001
         clra  
         os9   I$Read       read byte from stdin
         leay  >L00A0,pcr
         bsr   L0456
         puls  y,x,b,a
         anda  #$7F         clear hi bit
L0439    rts
* New routine needed as F$PrsNam will stop at the second "/";RG   
getnm    pshs  x            skip to end of file name;RG
         ldb   #-1
gtnm2    lda   ,x+
         incb
         cmpa  #C$SPAC
         beq   gtnm3
         cmpa  #C$COMA
         bne   gtnm2
gtnm3    puls  x
         bra   L0443
* End of new routine;RG
L043A    pshs  x
         os9   F$PrsNam 
         puls  x
         bcs   ShowHelp
L0443    lda   ,x+
         bsr   L04A5
         decb  
         bpl   L0443
         rts   

L044B    lda   ,y          get char at Y
         anda  #$7F        strip off hi bit
         bsr   L04A5
         lda   ,y+
         bpl   L044B
L0455    rts   
L0456    bsr   L044B
         pshs  y,x,a
         ldd   <bufptr
         leax  <strbuf,u
         stx   <bufptr
         subd  <bufptr
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
L04A5    pshs  x            save X on stack
         ldx   <bufptr      load 'next' ptr
         sta   ,x+          save A at location and inc ptr
         stx   <bufptr      save 'next' ptr
         puls  pc,x

         emod
eom      equ   *
         end
