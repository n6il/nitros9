********************************************************************
* Deldir - Delete a directory
*
* $Id$
*
* Ed.    Comments                                       Who YY/MM/DD
* ------------------------------------------------------------------
* 3      Original Tandy distribution version            BGP

         nam   Deldir
         ttl   Delete a directory

* Disassembled 98/09/10 23:18:11 by Disasm v1.6 (C) 1988 by RML

         ifp1
         use   defsfile
         endc

tylg     set   Prgrm+Objct   
atrv     set   ReEnt+rev
rev      set   $01
edition  set   3

         mod   eom,name,tylg,atrv,start,size

u0000    rmb   2
u0002    rmb   1
u0003    rmb   1
u0004    rmb   24
u001C    rmb   4
u0020    rmb   4
u0024    rmb   10
u002E    rmb   6
u0034    rmb   15
u0043    rmb   1
u0044    rmb   1
u0045    rmb   1
u0046    rmb   2
u0048    rmb   2
u004A    rmb   2
u004C    rmb   334
size     equ   .

name     fcs   /Deldir/
         fcb   edition

start    bsr   L0050
         bcs   L0042
         bsr   L0091
         bcc   L002B
         lbsr  L010C
         bcs   L0042
         lbsr  L01C3
         bcs   L0042
         lbsr  L0242
         bcs   L0042
L002B    lda   <u0002
         os9   I$Close  
         bcs   L004D
         ldx   <u0000
         os9   I$Delete 
         bcs   L004D
         lda   ,x
         cmpa  #C$CR
         bne   start
         clrb  
         bra   L004D
L0042    pshs  b
         lda   <u0002
         os9   I$Close  
         puls  b
         orcc  #Carry
L004D    os9   F$Exit   
L0050    stx   <u0000
         lda   #READ.+WRITE.
         os9   I$Open   
         bcs   L005D
         sta   <u0002
         bra   L0089
L005D    ldx   <u0000
         lda   #DIR.+READ.
         os9   I$Open   
         bcs   L0090
         sta   <u0002
L0068    ldx   <u0000
         os9   F$PrsNam 
         clra  
         incb  
         std   <u0046
         lda   ,y
         cmpa  #PDELIM
         bne   L0089
         lda   #C$CR
         sta   ,y+
         lda   #READ.+WRITE.
         ldx   <u0000
         os9   I$ChgDir 
         bcs   L0090
         sty   <u0000
         bra   L0068
L0089    leax  <-u001C,u
         stx   <u0044
         clr   <u0003
L0090    rts   
L0091    lda   <u0002
         ldb   #SS.OPT
         leax  u0004,u
         os9   I$GetStt 
         bcs   L00AB
         ldx   <u0044
         lda   <$33,x
         anda  #$80
         beq   L00AA
         clrb  
         orcc  #Carry
         bra   L00AB
L00AA    clrb  
L00AB    rts   
L00AC    fcb   C$LF
         fcc   "Deleting directory file. "
         fcb   C$LF
         fcc   "List directory, delete directory, or quit ? (l/d/q) "
L00FB    fcb   C$LF
         fcc   "Continue? (y/n) "
L010C    tstb  
         bne   L013E
         lda   #$01
         leax  <L00AC,pcr
         ldy   #$004F
         os9   I$WritLn 
L011B    bcs   L013E
         bsr   L0179
         bcs   L013E
         ldb   <u0003
         cmpb  #$01
         bne   L012A
         clrb  
         bra   L013E
L012A    bsr   L0145
L012C    bcs   L013E
         leax  <L00FB,pcr
         ldy   #$0011
         lda   #$01
         os9   I$WritLn 
         bcs   L013E
         bsr   L0179
L013E    rts   
L013F    fcc   "DIR"
         fcb   C$CR
L0143    fcc   "E "
L0145    pshs  u
         leau  <u004A,u
         pshs  u
         ldb   #$02
         leax  <L0143,pcr
         lbsr  L0270
         ldx   <u0000
         ldd   <u0046
         decb  
         lbsr  L0270
         lda   #C$CR
L015E    sta   ,u+
         tfr   u,d
         subd  ,s
         tfr   d,y
         puls  u
         leax  <L013F,pcr
         lda   #$11
         clrb  
         os9   F$Fork   
         puls  u
         bcs   L013E
         os9   F$Wait   
L0178    rts   
L0179    leax  <u004A,u
         ldy   #80
         lda   #$00
         os9   I$ReadLn 
         bcs   L01B8
L0187    lda   ,x+
         cmpa  #C$SPAC
         beq   L0187
         eora  #$59
         anda  #$DF
         beq   L01AD
         lda   ,-x
         eora  #$4C
         anda  #$DF
         beq   L01A9
         lda   ,x
         eora  #$44
         anda  #$DF
         beq   L01A5
         bra   L01B4
L01A5    ldb   #$01
         bra   L01AF
L01A9    ldb   #$02
         bra   L01AF
L01AD    ldb   #$04
L01AF    stb   <u0003
         clrb  
         bra   L01B8
L01B4    ldb   #$01
         orcc  #Carry
L01B8    rts   
L01B9    fcc   "DELDIR"
         fcb   C$CR
L01C0    fcc   ".."
         fcb   C$CR
L01C3    ldb   <u0003
         bitb  #$05
         beq   L0210
         lda   <u0002
         pshs  u
         ldu   #$0040
L01D0    ldx   #$0000
         os9   I$Seek   
         puls  u
L01D8    bsr   L0215
         bcs   L0209
         ldx   <u0000
         lda   #READ.+WRITE.
         os9   I$ChgDir 
         bcs   L0214
         ldy   <u0048
         clrb  
         lda   #$11
         pshs  u
         leau  <u0024,u
         leax  <L01B9,pcr
         os9   F$Fork   
         puls  u
         bcs   L0214
         os9   F$Wait   
         bcs   L0214
         leax  <L01C0,pcr
         lda   #READ.+WRITE.
         os9   I$ChgDir 
         bcc   L01D8
L0209    cmpb  #E$EOF
         bne   L0214
         clrb  
         bra   L0214
L0210    ldb   #$01
         orcc  #Carry
L0214    rts   
L0215    lda   <u0002
         leax  <u0024,u
         ldy   #$0020
         os9   I$Read   
         bcs   L0238
         lda   ,x
         beq   L0215
         os9   F$PrsNam 
         lda   -$01,y
         anda  #$7F
         sta   -$01,y
         lda   #C$CR
         sta   ,y
         clra  
         incb  
         std   <u0048
L0238    rts   
L0239    fcc   "ATTR"
         fcb   C$CR
L023E    fcc   " -d"
         fcb   C$CR
L0242    pshs  u
         leau  <u004A,u
         pshs  u
         ldd   <u0046
         decb
         ldx   <u0000
         bsr   L0270
         leax  <L023E,pcr
         ldb   #$04
         bsr   L0270
         tfr   u,d
         subd  ,s
         tfr   d,y
         puls  u
         leax  <L0239,pcr
         clrb  
         lda   #$11
         os9   F$Fork   
         bcs   L026D
         os9   F$Wait   
L026D    puls  u
         rts   
L0270    decb  
         lda   ,x+
         sta   ,u+
         tstb  
         bne   L0270
         rts   

         emod
eom      equ   *
         end

