********************************************************************
* OS9Gen - OS-9 bootfile generator
*
* $Id$
*
* Ed.    Comments                                       Who YY/MM/DD
* ------------------------------------------------------------------
*   9    From OS-9 Level Two Vr. 2.00.01

         nam   OS9gen
         ttl   OS-9 bootfile generator

* Disassembled 02/07/06 13:11:11 by Disasm v1.6 (C) 1988 by RML

         ifp1
         use   defsfile
         endc

tylg     set   Prgrm+Objct   
atrv     set   ReEnt+rev
rev      set   $01
edition  set   9

os9l1start equ $EF00
os9l1size  equ $0F80

         mod   eom,name,tylg,atrv,start,size

u0000    rmb   2
u0002    rmb   1
u0003    rmb   1
u0004    rmb   1
u0005    rmb   1
u0006    rmb   2
u0008    rmb   1
u0009    rmb   2
u000B    rmb   2
u000D    rmb   2
u000F    rmb   2
u0011    rmb   2
u0013    rmb   2
u0015    rmb   2
u0017    rmb   7
u001E    rmb   3
u0021    rmb   17
u0032    rmb   2
u0034    rmb   10
u003E    rmb   2
u0040    rmb   1
u0041    rmb   32
u0061    rmb   3
u0064    rmb   1
u0065    rmb   12
u0071    rmb   10
u007B    rmb   2
u007D    rmb   1
u007E    rmb   1024
u047E    rmb   16
u048E    rmb   1
u048F    rmb   7
u0496    rmb   7018
size     equ   .

name     fcs   /OS9gen/
         fcb   edition

Help     fcb   C$LF
         fcc   "Use (CAUTION): OS9GEN </devname> [-s]"
         fcb   C$LF
         fcc   " ..reads (std input) pathnames until EOF,"
         fcb   C$LF
         fcc   "   merging paths into New OS9Boot file."
         fcb   C$LF
         fcc   " -s = single drive operation"
         fcb   C$LF,C$CR
         fcc   "Can't find: "
ErrWrit  fcb   C$LF
         fcc   "Error writing kernel track"
         fcb   C$CR
HDGen    fcb   C$LF
         fcc   "Error - cannot gen to hard disk"
         fcb   C$CR
         ifgt  Level-1
CantRel  fcb   C$LF
         fcc   "Error - can't link to Rel module"
         fcb   C$CR
         endc
CarRet   fcb   C$CR
TheBell  fcb   C$BELL
TWarn    fcb   C$LF
         fcc   "Warning - file(s) present"
         fcb   C$LF
         fcc   "on track 34 - this track"
         fcb   C$LF
         fcc   "not rewritten."
         fcb   C$CR
BootFrag fcb   C$LF
         fcc   "Error - OS9boot file fragmented"
         fcb   C$CR
Source   fcc   "Ready SOURCE,      hit C to continue: "
Destin   fcc   "Ready DESTINATION, hit C to continue: "
Rename   fcc   "RENAME "
TempBoot fcc   "TempBoot "
         fcb   $FF 
OS9Boot  fcc   "OS9Boot"
         fcb   C$CR
         fcb   $FF 
TheRel   fcc   "Rel"
         fcb   $FF 

start    clrb  
         stb   <u0005
         stb   <u0040
         stu   <u0000
         leas  >u047E,u
         pshs  u
         tfr   y,d
         subd  ,s++
         subd  #$047E
         clrb  
         std   <u0011
         lda   #PDELIM
         cmpa  ,x
         lbne  L069A
         os9   F$PrsNam 
         lbcs  L069C
         lda   #PDELIM
         cmpa  ,y
         lbeq  L069A
         pshs  b,a
L0216    lda   ,y+
         cmpa  #'-
         beq   L0222
         cmpa  #C$CR
         beq   L0234
         bra   L0216
L0222    ldd   ,y+
         eora  #'S
         anda  #$DF
         lbne  L071A
         cmpb  #$30
         lbcc  L071A
         inc   <u0040
L0234    puls  b,a
         leay  <u0041,u
L0239    sta   ,y+
         lda   ,x+
         decb  
         bpl   L0239
         sty   <u003E
         lda   #PENTIR
         ldb   #C$SPAC
         std   ,y++
         lbsr  L06B5
         leax  <u0041,u
         lda   #UPDAT.
         os9   I$Open   
         sta   <u0003
         lbcs  L069C
         leax  <u001E,u
         ldb   #SS.Opt
         os9   I$GetStt 
         lbcs  Bye
         leax  <u001E,u
         lda   <u0021,u
         bpl   L0276
         clrb  
         leax  >HDGen,pcr
         lbra  L06A0
L0276    ldx   <u003E
         leay  >TempBoot,pcr
         lda   #PDELIM
L027E    sta   ,x+
         lda   ,y+
         bpl   L027E
         leay  >OS9Boot,pcr
L0288    lda   ,y+
         sta   ,x+
         bpl   L0288
         tfr   x,d
         leax  <u0041,u
         pshs  x
         subd  ,s++
         std   <u000D
         lda   #WRITE.
         ldb   #READ.+WRITE.
         os9   I$Create 
         sta   <u0002
         lbcs  Bye
         ldx   #$0000
         stx   <u0006
         ldu   #$3000
         ldb   #SS.Size
         os9   I$SetStt 
         lbcs  Bye
         ldu   <u0000
         bsr   L032F
L02BB    leax  <u007E,u
         ldy   #256
         clra  
         os9   I$ReadLn 
         bcs   L0312
         lda   ,x
         ldb   #E$EOF
         cmpa  #C$CR
         beq   L0312
         cmpa  #'*
         beq   L02BB
         lda   #READ.
         os9   I$Open   
         bcs   L031A
         sta   <u0004
L02DD    ldx   <u0015
         ldd   <u0011
         subd  <u0013
         tfr   d,y
         lda   <u0004
         os9   I$Read   
         bcc   L02F9
         cmpb  #E$EOF
         lbne  Bye
         os9   I$Close  
         clr   <u0004
         bra   L02BB
L02F9    tfr   y,d
         leax  d,x
         stx   <u0015
         addd  <u0013
         std   <u0013
         cmpd  <u0011
         bcs   L030C
         bsr   L032B
         bcs   L0328
L030C    tst   <u0004
         bne   L02DD
         bra   L02BB
L0312    cmpb  #E$EOF
         bne   L0328
         bsr   L033D
         bra   L0377
L031A    pshs  b
         leax  <u007E,u
         ldy   #256
         lda   #$02
         os9   I$WritLn 
L0328    lbra  Bye
L032B    bsr   L033D
         bcs   L033C
L032F    lbsr  L06B0
         clra  
         clrb  
         std   <u0013
         leax  >u047E,u
         stx   <u0015
L033C    rts   
L033D    lbsr  L06B5
         ldd   <u0013
         beq   L033C
         tst   <u0040
         beq   L0361
         lda   <u0003
         ldx   #$0000
         ldu   #$0000
         os9   I$Seek   	seek to LSN0
         bcs   L033C
         leax  <u007E,u
         ldy   #256
         os9   I$Read   	read LSN0
         bcs   L033C
L0361    lda   <u0002
         leax  >u047E,u
         ldy   <u0013
         os9   I$Write  
         bcs   L033C
         tfr   y,d
         addd  <u0006
         std   <u0006
         clrb  
         rts   
L0377    leax  <u001E,u
         ldb   #SS.Opt
         lda   <u0002
         os9   I$GetStt 
         lbcs  Bye
         lda   <u0002
         ldx   #$0000
         ldu   <u0006
         ldb   #SS.Size
         os9   I$SetStt 
         lbcs  Bye
         ldu   <u0000
         os9   I$Close  
         lbcs  L069C
         ldx   <u0032,u
         lda   <u0034,u
         clrb  
         tfr   d,u
         lda   <u0003
         os9   I$Seek   
         ldu   <u0000
         lbcs  Bye
         leax  >u047E,u
         ldy   #256
         os9   I$Read   
         lbcs  Bye
         ldd   >u0496,u
         lbne  L0716
         lda   <u0003
         ldx   #$0000
         ldu   #$0015
         os9   I$Seek   
         ldu   <u0000
         lbcs  Bye
         leax  u0008,u
         ldy   #$0005
         os9   I$Read   
         lbcs  Bye
         ldd   <u000B
         beq   L040D
         ldx   <u003E
         leay  >OS9Boot,pcr
         lda   #PDELIM
L03F3    sta   ,x+
         lda   ,y+
         bpl   L03F3
         leax  <u0041,u
         os9   I$Delete 
         ldx   <u003E
         leay  >TempBoot,pcr
         lda   #PDELIM
L0407    sta   ,x+
         lda   ,y+
         bpl   L0407
L040D    tst   <u0040
         beq   L042E
         clra  
         leax  >Rename,pcr
         os9   F$Link   
         bcc   L0428
         lbsr  L06B0
         os9   F$Load   
         lbcs  Bye
         lbsr  L06B5
L0428    tfr   u,d
         ldu   <u0000
         std   u000F,u
L042E    lda   #$01
         clrb  
         leax  >Rename,pcr
         ldy   <u000D
         leau  <u0041,u
         os9   F$Fork   
         lbcs  Bye
         os9   F$Wait   
         lbcs  Bye
         tstb  
         lbne  Bye
         tst   <u0040
         beq   L045F
         ldu   <u0000
         ldd   u000F,u
         tfr   d,u
         os9   F$UnLink 
         lbcs  Bye
L045F    ldu   <u0000
         ldb   >u048E,u
         stb   <u0008
         ldd   >u048F,u
         std   <u0009
         ldd   <u0006
         std   <u000B
         ldx   #$0000
         ldu   #$0015
         lda   <u0003
         os9   I$Seek   
         ldu   <u0000
         lbcs  Bye
         leax  u0008,u
         ldy   #$0005
         os9   I$Write  
         lbcs  Bye
         pshs  u
         clra  
         clrb  
         tfr   d,x
         tfr   d,u
         lda   <u0003
         os9   I$Seek   
         lbcs  Bye
         puls  u
         leax  <u0061,u
         ldy   #$001A
         lda   <u0003
         os9   I$Read   
         lbcs  Bye
         lda   #$00
         ldb   #$01
         lbsr  L065E
         leax  <u007E,u
         ldy   <u0065,u
         lda   <u0003
         os9   I$Read   
         lbcs  Bye
         lda   #$22
         clrb  
         ldy   #$0004
         lbsr  L05C7
         bcc   L0520
         lda   #$22
         ldb   #$00
         lbsr  L065E
         leax  <u0017,u
         ldy   #$0007
         lda   <u0003
         os9   I$Read   
         lbcs  Bye
         leax  <u0017,u
         ldd   ,x
         cmpa  #'O
         lbne  L071E
         cmpb  #'S
         lbne  L071E
         lda   $04,x
         cmpa  #$12
         beq   L0512
         lda   #$22
         ldb   #$0F
         ldy   #$0003
         lbsr  L05C7
         lbcs  L071E
L0512    clra  
         ldb   <u0064,u
         tfr   d,y
         lda   #$22
         clrb  
         lbsr  L061C
         bra   L0531
L0520    lda   #$22
         ldb   #$04
         ldy   #$000E
         lbsr  L05C7
         lbcs  L071E
         bra   L0512
L0531    clra  
         ldb   #$01
         lbsr  L065E
         leax  <u007E,u
         ldy   <u0065,u
         lda   <u0003
         os9   I$Write  
         lbcs  Bye

         ifgt  Level-1
* OS-9 Level Two: Link to Rel, which brings in boot code
         pshs  u
         lda   #Systm+Objct
         leax  >TheRel,pcr
         os9   F$Link   
         lbcs  L0724
         tfr   u,d
         puls  u
         subd  #$0006
         std   <u007B,u
         lda   #$E0
         anda  <u007B,u
         ora   #$1E
         ldb   #$FF
         subd  <u007B,u
         addd  #$0001
         tfr   d,y
         lda   #$22
         ldb   #$00
         lbsr  L065E
         lda   <u0003
         ldx   <u007B,u

         else

* OS-9 Level One: Write out boot track data
         lda   #$22
         ldb   #$00
         lbsr  L065E
         lda   <u0003
         ldx   #os9l1start
         ldy   #os9l1size

         endc

         os9   I$Write  
         lbcs  L0694
         os9   I$Close  
         lbcs  Bye
         clrb  
         lbra  Bye
L058F    pshs  b
         ldb   <u0071,u
         andb  #$01
         beq   L059C
         ldb   #$02
         bra   L059E
L059C    ldb   #$01
L059E    mul   
         lda   <u0064,u
         mul   
         addb  ,s
         adca  #$00
         leas  $01,s
         rts   
L05AA    pshs  y,b
         lsra  
         rorb  
         lsra  
         rorb  
         lsra  
         rorb  
         leax  d,x
         puls  b
         leay  <L05BF,pcr
         andb  #$07
         lda   b,y
         puls  pc,y

L05BF    fcb   $80,$40,$20,$10,$08,$04,$02,$01

L05C7    pshs  x,y,b,a
         bsr   L058F
         leax  <u007E,u
         bsr   L05AA
         sta   ,-s
         bmi   L05EA
L05D3    lda   ,x
         sta   <u007D,u
L05D9    anda  ,s
         bne   L0616
         leay  -$01,y
         beq   L0612
         lda   <u007D,u
         lsr   ,s
         bcc   L05D9
         leax  $01,x
L05EA    lda   #$FF
         sta   ,s
         bra   L05FA
L05F0    lda   ,x
         anda  ,s
         bne   L0616
         leax  $01,x
         leay  -$08,y
L05FA    cmpy  #$0008
         bhi   L05F0
         beq   L060C
         lda   ,s
L0604    lsra  
         leay  -$01,y
         bne   L0604
         coma  
         sta   ,s
L060C    lda   ,x
         anda  ,s
         bne   L0616
L0612    andcc #$FE
         bra   L0618
L0616    orcc  #$01
L0618    leas  $01,s
         puls  pc,y,x,b,a
L061C    pshs  y,x,b,a
         lbsr  L058F
         leax  <u007E,u
         bsr   L05AA
         sta   ,-s
         bmi   L063A
         lda   ,x
L062C    ora   ,s
         leay  -$01,y
         beq   L0658
         lsr   ,s
         bcc   L062C
         sta   ,x
         leax  $01,x
L063A    lda   #$FF
         bra   L0644
L063E    sta   ,x
         leax  $01,x
         leay  -$08,y
L0644    cmpy  #$0008
         bhi   L063E
         beq   L0658
L064C    lsra  
         leay  -$01,y
         bne   L064C
         coma  
         sta   ,s
         lda   ,x
         ora   ,s
L0658    sta   ,x
         leas  $01,s
         puls  pc,y,x,b,a

L065E    pshs  u,y,x,b,a
         lbsr  L058F
         pshs  a
         tfr   b,a
         clrb  
         tfr   d,u
         puls  b
         clra  
         tfr   d,x
         lda   <u0003
         os9   I$Seek   
         lbcs  L0694
         puls  pc,u,y,x,b,a

         clra  
         clrb  
         tfr   d,x
         tfr   d,u
         lda   <u0003
         os9   I$Seek   
         leax  <u0061,u
         ldy   #$001A
         lda   <u0003
         os9   I$Write  
         bcs   Bye
         rts   
L0694    leax  >ErrWrit,pcr
         bra   L06A0
L069A    ldb   #$D7
L069C    leax  >Help,pcr
L06A0    pshs  b
         lda   #$02
         ldy   #256
         os9   I$WritLn 
         puls  b
Bye      os9   F$Exit   
L06B0    pshs  u,y,x,b,a
         clra  
         bra   L06B9
L06B5    pshs  u,y,x,b,a
         lda   #$01
L06B9    tst   <u0040
         beq   L06FD
L06BD    pshs  a
         tsta  
         bne   L06CC
         leax  >Source,pcr
         ldy   #$0026
         bra   L06D4
L06CC    leax  >Destin,pcr
         ldy   #$0026
L06D4    bsr   L06FF
         leax  ,-s
         ldy   #$0001
         lda   #$02
         os9   I$Read   
         lda   ,s+
         eora  #'C
         anda  #$DF
         beq   L06F9
         leax  >TheBell,pcr
         ldy   #$0001
         bsr   L06FF
         bsr   L0705
         puls  a
         bne   L06BD
L06F9    bsr   L0705
         puls  a
L06FD    puls  pc,u,y,x,b,a
L06FF    lda   #$01
         os9   I$WritLn 
         rts   
L0705    pshs  y,x,a
         lda   #$01
         leax  >CarRet,pcr
         ldy   #80
         os9   I$WritLn 
         puls  pc,y,x,a
L0716    leax  >BootFrag,pcr
L071A    ldb   #$01
         bra   L06A0
L071E    leax  >TWarn,pcr
         bra   L071A

         ifgt  Level-1
L0724    leax  >CantRel,pcr
         lbra  L06A0
         endc

         emod
eom      equ   *
         end
