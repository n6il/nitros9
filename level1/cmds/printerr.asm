********************************************************************
* Printerr - OS-9 Level One printerr routine
*
* $Id$
*
* Ed.    Comments                                       Who YY/MM/DD
* ------------------------------------------------------------------
* 6      Original Tandy/Microware version               BGP 02/04/06

         nam   Printerr
         ttl   OS-9 Level One printerr routine

         ifp1
         use   defsfile
         endc

tylg     set   Prgrm+Objct
atrv     set   ReEnt+rev
rev      set   $01

         mod   eom,name,tylg,atrv,start,size

datarea  rmb   86
size     equ   .

name     fcs   /Printerr/
         fcb   $06

ErrFile  fcc   "/D0/SYS/ERRMSG"
         fcb   $0D
         fcc   ",,,,,,,,,,,,"

ErrMsg   fcc   "Error #"
         fcb   $FF

SysSVC   fcb   F$PErr
         fdb   FPErr-*-2
         fcb   $80

start    clra
         leax  <name,pcr
         os9   F$Link                  link one extra time
         bcs   error
         leay  <SysSVC,pcr
         os9   F$SSvc
         clrb
error    os9   F$Exit

FPErr    ldx   <D.Proc
         lda   P$PATH+2,x              get stderr path
         beq   Exit2
         leas  <-$56,s                 make room on stack
         ldb   R$B,u                   get error code
         leau  ,s                      point U to save area
         sta   ,u                      store path
         stb   2,u                     store error code
         bsr   PErrOrg                 print error as originally done
         lda   #READ.
         leax  >ErrFile,pcr
         os9   I$Open
         sta   1,u                     save path to file
         bcs   Exit1
         bsr   L008D
         bcs   L0083
         bne   L0083
L0077    bsr   L00D4
         bsr   ReadLine
         bcs   L0083
         ldb   ,x
         cmpb  #$30
         bcs   L0077
L0083    lda   1,u
         os9   I$Close
Exit1    leas  <$56,s
Exit2    clrb
         rts

L008D    bsr   ReadLine
         bcs   L009B
         bsr   L00DE
         cmpa  #$30
         bcc   L008D
         cmpb  2,u
         bne   L008D
L009B    rts

* read a line from the error file
ReadLine lda   1,u                     get path number of file
         leax  5,u                     point X to buffer
         ldy   #80                     max 80 chars
         os9   I$ReadLn                read line
         rts

PErrOrg  leax  >ErrMsg,pcr
         leay  5,u                     point to buffer area
         lda   ,x+
CopyLoop sta   ,y+
         lda   ,x+
         bpl   CopyLoop                while hi bit not set in A
         ldb   2,u                     get error number
         lda   #$2F
L00BA    inca
         subb  #$64
         bcc   L00BA
         sta   ,y+
         lda   #$3A
L00C3    deca
         addb  #10
         bcc   L00C3
         sta   ,y+
         tfr   b,a
         adda  #$30
         ldb   #$0D
         std   ,y+
         leax  5,u                     point X at buffer
L00D4    ldy   #80                     max string len
         lda   ,u                      get stderr path
         os9   I$WritLn
         rts

L00DE    clrb
L00DF    lda   ,x+
         suba  #$30
         cmpa  #$09
         bhi   L00F0
         pshs  a
         lda   #10
         mul
         addb  ,s+
         bcc   L00DF
L00F0    lda   -1,x
         rts

         emod
eom      equ   *
         end

