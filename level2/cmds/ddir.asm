********************************************************************
* DDir - Show device table entries
*
* $Id$
*
* Ed.    Comments                                       Who YY/MM/DD
* ------------------------------------------------------------------
* 2      Reworked                                       AD

         nam   DDir
         ttl   program module       

* Disassembled 94/11/05 14:18:05 by Alan DeKok
*
* Future revisions:
* Check <D.Init and DevCnt for entries in device polling table
* check 9/D for size of table - go to V$DESC and look for $87CD

         ifp1
         use   defsfile
         endc

tylg     set   Prgrm+Objct   
atrv     set   ReEnt+rev
rev      set   $01
edition  set   2

         mod   eom,name,tylg,atrv,start,size

MemStrt  rmb   2
DATImg   rmb   4
u0006    rmb   2
u0008    rmb   1
u0009    rmb   8
DevTbl   rmb   2
u0013    rmb   1
u0014    rmb   80
u0064    rmb   512
u0264    rmb   512
u0464    rmb   712
size     equ   .

name     fcs   /DDir/
         fcb   edition

L0012    fcc   /Device Table at: /
x12Len   equ   *-L0012
Header   fcc   /Device Desc  Driver Static  File    Usr/
         fcb   $0D 
L004B    fcc   /Name   Port  Name      Mem  Manager Cnt/
         fcb   $0D 
L0073    fcc   /-----------  -------------  ------- ---/
MyCR     fcb   $0D 

start    ldd   ,x         get parameter bytes
         cmpd  #$2D3F     -?
         lbeq  Help

         lda   #$01
         stu   <MemStrt
         leax  >MyCR,pcr
         ldy   #$0001
         os9   I$WritLn   output a CR
         lbcs  Exit 
         leax  >L0012,pcr dump out header
         ldy   #x12Len
         os9   I$Write  
         lbcs  Exit 
         lda   #$01
         leax  >u0464,u
         os9   F$GPrDsc   get system process descriptor
         bcs   Exit 
         leax  <P$DATImg,x
         stx   <DATImg     save address of system's DAT image
         bra   L00D3

ClnExit  clrb  
Exit     os9   F$Exit   

L00D3    ldu   <MemStrt
         leau  >u0064,u
         ldd   <DATImg
         ldx   #D.DevTbl  I/O device table
         ldy   #$0002     size of the pointer
         os9   F$CpyMem 
         lbcs  Exit 

         ldu   <MemStrt
         leay  <u0014,u
         sty   <u0006
         ldd   <u0064,u   get the pointer
         std   <DevTbl     save it
         lbsr  L0222
         lbsr  L01E6

         lda   #$01
         leax  >MyCR,pcr dump out another CR
         ldy   #$0001
         os9   I$WritLn 
         lbcs  Exit 

         leax  >Header,pcr
         ldy   #$0028
         os9   I$WritLn 
         lbcs  Exit 

         leax  >L004B,pcr
         ldy   #$0028
         os9   I$WritLn 
         lbcs  Exit 
         leax  >L0073,pcr
         ldy   #$0028
         os9   I$WritLn 
         lbcs  Exit

         ldu   <MemStrt
         leau  >u0064,u
         ldx   <DevTbl
         ldy   #$0100
         ldd   <DATImg
         os9   F$CpyMem   copy the device table over
         lbcs  Exit 
         ldb   #256/DEVSIZ
         stb   <u0008     total number of entries to get
         stu   <u0009     save pointer to start of DevTbl

L0155    bsr   L0165
         dec   <u0008
         lbeq  ClnExit    if done them all, exit

         ldx   <u0009     get current pointer
         leax  DEVSIZ,x   go to the next one
         stx   <u0009     save the pointer again
         bra   L0155      and loop back

L0165    ldu   <MemStrt
         leay  <u0014,u
         sty   <u0006
         lda   #C$SPAC    space
         ldb   #$05
L0171    sta   ,y+        save 5 spaces
         decb  
         bne   L0171

         ldx   <u0009     get the current pointer
         ldx   V$DESC,x   descriptor?
         bne   L017D      if exists, go do it
         rts              otherwise exit

L017D    pshs  u
         leau  >u0264,u   to another buffer
         ldd   <DATImg    system DAT image
         ldy   #200       get 200 bytes
         os9   F$CpyMem 
         puls  u
         lbcs  Exit 

         leax  >u0264,u   point to the start of the buffer
         ldd   M$Name,x   pointer to the name
         leax  d,x
         lda   #$05
         bsr   L01FF      dump out the first 5 bytes of the name?

         leax  >u0264,u
         lda   M$Port,x   port address of the device
         lbsr  L0228
         ldy   <u0006
         leay  -$01,y
         sty   <u0006
         ldd   M$Port+1,x
         lbsr  L0222
         lbsr  L022A
         leax  >u0264,u
         ldd   M$PDev,x   device driver name offset
         leax  d,x
         lda   #$09
         bsr   L01FF      dump out 9 bytes of the driver name
         ldx   <u0009
         ldd   V$STAT,x
         lbsr  L0222
         lbsr  L022A
         leax  >u0264,u
         ldd   M$FMGr,x   file manager name offset
         leax  d,x        point to it
         lda   #$09
         bsr   L01FF      dump out 9 bytes of the file manager's name
         ldx   <u0009
         lda   V$USRS,x   use count
         lbsr  L0228      print it
         ldx   <u0006
         leax  -$01,x
         bra   L01E8

L01E6    ldx   <u0006

L01E8    lda   #C$CR      save a CR in memory
         sta   ,x
         ldu   <MemStrt
         leax  <u0014,u   to the buffer
         ldy   #$0050     80 characters max.
         lda   #$01
         os9   I$WritLn   dump the buffer out
         lbcs  Exit 
         rts

L01FF    sta   <u0013     dump out A bytes at X
         clrb  
         bra   L0207

L0204    lbsr  L0242
L0207    incb  
         cmpb  <u0013
         bcc   L0219
         lda   ,x+
         bpl   L0204
         anda  #$7F
         lbsr  L0242      dump it out
         cmpb  <u0013
         bcc   L0221

L0219    lbsr  L022A
         incb  
         cmpb  <u0013
         bcs   L0219
L0221    rts   

L0222    pshs  b
         bsr   L022E
         puls  a
L0228    bsr   L022E
L022A    lda   #C$SPAC   output a space
         bra   L0242

L022E    tfr   a,b
         lsra  
         lsra  
         lsra  
         lsra  
         bsr   L0238
         tfr   b,a
L0238    anda  #$0F       get the number
         cmpa  #$0A       >10?
         bcs   L0240      no, make it a number
         adda  #$07       if so, make it A-F
L0240    adda  #$30
L0242    pshs  x
         ldx   <u0006     get buffer pointer
         sta   ,x+
         stx   <u0006
         puls  pc,x

Help     lda   #1         to STDOUT
         leax  HMsg,pcr
         ldy   #HLen
         OS9   I$Write
         clrb
         OS9   F$Exit

HMsg     fcc   /ddir: NitrOS-9 v1.21 or greater only./
         fdb   C$CR,C$LF
HLen     equ   *-HMsg

         emod
eom      equ   *
         end
