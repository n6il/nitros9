********************************************************************
* pwd - Print working directory
*
* $Id$
*
* Ed.    Comments                                       Who YY/MM/DD
* ------------------------------------------------------------------
* 1      Original Tandy/Microware version               BGP 02/04/05

         nam   pwd
         ttl   Print working directory

* Disassembled 98/09/10 23:50:10 by Disasm v1.6 (C) 1988 by RML

         ifp1
         use   defsfile
         endc

tylg     set   Prgrm+Objct   
atrv     set   ReEnt+rev
rev      set   $01
edition  set   1

         mod   eom,name,tylg,atrv,start,size

fildes   rmb   1
bufptr   rmb   2
u0003    rmb   2
u0005    rmb   1
u0006    rmb   2
u0008    rmb   1
u0009    rmb   2
u000B    rmb   3
u000E    rmb   29
u002B    rmb   2
u002D    rmb   129
buffer   rmb   1
sttbuf   rmb   282
size     equ   .

name     fcs   /pwd/
         fcb   edition

badnam   fcc   "pwd: bad name in path"
         fcb   C$CR
dotdot   fcc   "."
dot      fcc   "."
cr       fcb   C$CR
rdmsg    fcc   "read error"
         fcb   C$CR

start    leax  >buffer,u
         lda   #C$CR
         sta   ,x
         stx   <bufptr
         leax  >dot,pcr
         bsr   open
         sta   <fildes
         lbsr  rdtwo
         ldd   <u0003
         std   <u0009
         lda   <u0005
         sta   <u000B
L0052    bsr   L00C6
         beq   L0079
         leax  >dotdot,pcr
         bsr   chdir
         lda   <fildes
         os9   I$Close  
         bcs   L008D
         leax  >dot,pcr
         bsr   open
         bsr   rdtwo
         bsr   L00A8
         bsr   L00E2
         ldd   <u0003
         std   <u0009
         lda   <u0005
         sta   <u000B
         bra   L0052
L0079    lbsr  L00FB
         ldx   <bufptr
         ldy   #$0081
         lda   #$01
         os9   I$WritLn 
         lda   <fildes
         os9   I$Close  
         clrb  
L008D    os9   F$Exit   
chdir    lda   #DIR.+READ.
         os9   I$ChgDir 
         rts   
open     lda   #DIR.+READ.
         os9   I$Open   
         rts   
read32   lda   <fildes
         leax  u000E,u
         ldy   #$0020
         os9   I$Read   
         rts   
L00A8    lda   <fildes
         bsr   read32
         bcs   L010F
         leax  u000E,u
         leax  <$1D,x
         leay  u0009,u
         bsr   attop
         bne   L00A8
         rts   
attop    ldd   ,x++
         cmpd  ,y++
         bne   L00C5
         lda   ,x
         cmpa  ,y
L00C5    rts   
L00C6    leax  u0003,u
         leay  u0006,u
         bsr   attop   * check if we're at the top
         rts   
rdtwo    bsr   read32  * read "." from directory
         ldd   <u002B
         std   <u0006
         lda   <u002D
         sta   <u0008
         bsr   read32  * read ".." from directory
         ldd   <u002B
         std   <u0003
         lda   <u002D
         sta   <u0005
         rts   
L00E2    leax  u000E,u
prsnam   os9   F$PrsNam 
         bcs   L0109
         ldx   <bufptr
L00EB    lda   ,-y
         anda  #$7F
         sta   ,-x
         decb  
         bne   L00EB
         lda   #$2F
         sta   ,-x
         stx   <bufptr
         rts   
L00FB    lda   <fildes
         ldb   #SS.DevNm
         leax  >sttbuf,u
         os9   I$GetStt 
         bsr   prsnam
         rts   
L0109    leax  >badnam,pcr
         bra   wrerr
L010F    leax  >rdmsg,pcr
         bra   wrerr
L0115    lda   #$02
         os9   I$Write  
         bcs   L0128
         rts   
         bsr   L0115
         leax  >cr,pcr
wrerr    lda   #$02
         os9   I$WritLn 
L0128    ldb   #$00
         os9   F$Exit   

         emod
eom      equ   *
         end

