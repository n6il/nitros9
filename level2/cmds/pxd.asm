********************************************************************
* pxd - Print execution directory
*
* $Id$
*
* Ed.    Comments                                       Who YY/MM/DD
* ------------------------------------------------------------------
* 1      Original Tandy/Microware version

         nam   pxd
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

u0000    rmb   1
u0001    rmb   2
u0003    rmb   2
u0005    rmb   1
u0006    rmb   2
u0008    rmb   1
u0009    rmb   2
u000B    rmb   3
u000E    rmb   29
u002B    rmb   2
u002D    rmb   129
u00AE    rmb   1
u00AF    rmb   282
size     equ   .

name     fcs   /pxd/
         fcb   edition

L0011    fcc   "pxd: bad name in path"
         fcb   C$CR
L0027    fcc   "."
L0028    fcc   "."
L0029    fcb   C$CR
L002A    fcc   "read error"
         fcb   C$CR

start    leax  >u00AE,u
         lda   #$0D
         sta   ,x
         stx   <u0001
         leax  >L0028,pcr
         bsr   L0096
         sta   <u0000
         lbsr  L00CD
         ldd   <u0003
         std   <u0009
         lda   <u0005
         sta   <u000B
L0052    bsr   L00C6
         beq   L0079
         leax  >L0027,pcr
         bsr   L0090
         lda   <u0000
         os9   I$Close  
         bcs   L008D
         leax  >L0028,pcr
         bsr   L0096
         bsr   L00CD
         bsr   L00A8
         bsr   L00E2
         ldd   <u0003
         std   <u0009
         lda   <u0005
         sta   <u000B
         bra   L0052
L0079    lbsr  L00FB
         ldx   <u0001
         ldy   #$0081
         lda   #$01
         os9   I$WritLn 
         lda   <u0000
         os9   I$Close  
         clrb  
L008D    os9   F$Exit   
L0090    lda   #$85
         os9   I$ChgDir 
         rts   
L0096    lda   #$85
         os9   I$Open   
         rts   
L009C    lda   <u0000
         leax  u000E,u
         ldy   #$0020
         os9   I$Read   
         rts   
L00A8    lda   <u0000
         bsr   L009C
         bcs   L010F
         leax  u000E,u
         leax  <$1D,x
         leay  u0009,u
         bsr   L00BA
         bne   L00A8
         rts   
L00BA    ldd   ,x++
         cmpd  ,y++
         bne   L00C5
         lda   ,x
         cmpa  ,y
L00C5    rts   
L00C6    leax  u0003,u
         leay  u0006,u
         bsr   L00BA
         rts   
L00CD    bsr   L009C
         ldd   <u002B
         std   <u0006
         lda   <u002D
         sta   <u0008
         bsr   L009C
         ldd   <u002B
         std   <u0003
         lda   <u002D
         sta   <u0005
         rts   
L00E2    leax  u000E,u
L00E4    os9   F$PrsNam 
         bcs   L0109
         ldx   <u0001
L00EB    lda   ,-y
         anda  #$7F
         sta   ,-x
         decb  
         bne   L00EB
         lda   #$2F
         sta   ,-x
         stx   <u0001
         rts   
L00FB    lda   <u0000
         ldb   #$0E
         leax  >u00AF,u
         os9   I$GetStt 
         bsr   L00E4
         rts   
L0109    leax  >L0011,pcr
         bra   L0123
L010F    leax  >L002A,pcr
         bra   L0123
L0115    lda   #$02
         os9   I$Write  
         bcs   L0128
         rts   
         bsr   L0115
         leax  >L0029,pcr
L0123    lda   #$02
         os9   I$WritLn 
L0128    ldb   #$00
         os9   F$Exit   

         emod
eom      equ   *
         end

