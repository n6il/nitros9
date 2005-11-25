********************************************************************
* Attr - Modify file attributes
*
* $Id$
*
* Edt/Rev  YYYY/MM/DD  Modified by
* Comment
* ------------------------------------------------------------------
*  11      ????/??/??
* From Tandy OS-9 Level Two VR 02.00.01.
*
*  12      2005/11/23	CRH
* Now uses SS.FD to read and write the FD sector

         nam   Attr
         ttl   Modify file attributes

* Disassembled 98/09/11 11:44:51 by Disasm v1.6 (C) 1988 by RML

         ifp1  
         use   defsfile
         endc  

DOHELP   set   0

tylg     set   Prgrm+Objct
atrv     set   ReEnt+rev
rev      set   $00
edition  set   12

         mod   eom,name,tylg,atrv,start,size

fpath    rmb   1
parmptr  rmb   2
cmdperms rmb   2
u0006    rmb   1
u0007    rmb   1
pathopts rmb   32
dirent   rmb   32
filename rmb   32
fdesc    rmb   16
u0078    rmb   46
u00A6    rmb   414
size     equ   .

name     fcs   /Attr/
         fcb   edition

         IFNE  DOHELP
HelpMsg  fcb   C$LF
         fcc   "Use: Attr <pathname> {[-]<opts>}"
         fcb   C$LF
         fcc   " opts: -d s r w e pr pw pe -a"
         fcb   C$CR
         ENDC
NotOwner fcb   C$LF
         fcc   "You do not own that file."
         fcb   C$CR
UseMkDir fcb   C$LF
         fcc   "Use Makdir to create a directory"
         fcb   C$CR
DirNtEmt fcb   C$LF
         fcc   "ERROR; the directory is not empty"
         fcb   C$CR
Attrs    fcc   "dsewrewr"
         fcb   $FF

start    stx   <parmptr		save param ptr
         clr   <u0007
         com   <u0007
* Open file at X as file
         clra  
         lda   #WRITE.		need write to change attrs
         os9   I$Open		open file on commandline
         bcc   L00D9		branch if ok
* If error, try to open without write permissions
         ldx   <parmptr		get saved param ptr
         clra  
         os9   I$Open
         bcc   L00D9		branch if ok
* If error, try to open as directory with read/write permissions
         ldx   <parmptr		get saved param ptr
         lda   #DIR.+UPDAT.	load perms
         os9   I$Open		open as directory
         bcc   L00D9		branch if ok
* One last time, try open as directory only
         ldx   <parmptr		get param ptr
         lda   #DIR.		load different perms
         os9   I$Open		try one more time
         bcs   L0114		branch if error
L00D9    sta   <fpath		save off path
         stx   <cmdperms	save updated parm ptr
         leax  pathopts,u	point X to buffer
         ldb   #SS.Opt		load with status code
         os9   I$GetStt		get status
         bcs   L0114		branch if error
         clrb  
         lda   ,x			get path type
         cmpa  #DT.RBF		check if rbf path
         lbne  ShowHelp		branch if not
         lda   <fpath
         ldb   #SS.FD		Get my file descriptor
         leax  fdesc,u		point to buffer
         ldy   #FD.SEG
         os9   I$GetStt
L0114    bcs   ShowHelp
         os9   F$ID		get ID
         cmpy  #$0000		super user?
         beq   L014B		branch if so
         cmpy  <fdesc+FD.OWN,u	is user same as file's owner?
         bne   L01C1		branch if not
L014B    ldx   <cmdperms	point to perms on cmd line
         lbsr  L021D
         bcs   L018B
L0152    lbsr  L021D
         bcc   L0152
         clrb  
         lda   ,x
         cmpa  #C$CR
         bne   ShowHelp
         lda   <fpath
         ldb   #SS.FD           Set my file descriptor
         leax  fdesc,u		point to file desc
         ldy   #1		only 1 byte
         os9   I$SetStt		write out new attributes
         bcs   ShowHelp		branch if error
         lda   <fpath		get file path
         os9   I$Close		close file
         bcs   ShowHelp		branch if error
         ldb   <u0007
         beq   L01BE
L018B    ldb   <fdesc,u		get attribute
         leax  >Attrs,pcr
         leay  <u0078,u
         lda   ,x+
L0197    lslb  
         bcs   L019C
         lda   #'-
L019C    sta   ,y+
         lda   ,x+
         bpl   L0197
         lda   #C$CR
         sta   ,y+
         leax  <u0078,u
         clrb  
         bra   L01B0
ShowHelp equ   *
         IFNE  DOHELP
         leax  >HelpMsg,pcr
         ELSE
         clrb
         bra  L01BE
         ENDC
L01B0    pshs  b
         lda   #2
         ldy   #256
         os9   I$WritLn
         comb  
         puls  b
L01BE    os9   F$Exit
L01C1    clrb  
         leax  >NotOwner,pcr
         bra   L01B0
L01C8    leax  >UseMkDir,pcr
         clrb  
         bra   L01B0
L01CF    pshs  u,y,x
         lda   <fpath
         ldx   #$0000
         ldu   #DIR.SZ*2
         os9   I$Seek
         ldu   $04,s
         bcs   L01BE
L01E0    leax  <dirent,u
         ldy   #DIR.SZ
         os9   I$Read
         bcs   L01F7
         tst   ,x
         beq   L01E0
         leax  >DirNtEmt,pcr
         clrb  
         bra   L01B0
L01F7    puls  u,y,x
         cmpb  #E$EOF
         bne   ShowHelp
         rts   
L01FE    fdb   $ff41
         fdb   $ff80,$44ff,$4053,$ff01,$52ff,$0257,$ff04,$45ff
         fdb   $0850,$52ff,$1050,$57ff,$2050,$45ff
         fcb   $00
L021D    clr   <u0006
L021F    lda   ,x+
         cmpa  #C$SPAC
         beq   L021F
         cmpa  #C$COMA
         beq   L021F
         cmpa  #'-
         bne   L0231
         com   <u0006
         lda   ,x+
L0231    leax  -1,x
         leay  >L01FE,pcr
L0237    ldb   ,y+
         pshs  y,x
         beq   L027F
L023D    lda   ,x+
         eora  ,y+
         anda  #$DF
         beq   L023D
         lda   -1,y
         bmi   L0251
         puls  y,x
L024B    lda   ,y+
         bpl   L024B
         bra   L0237
L0251    lda   ,-x
         cmpa  #$30
         bcc   L027F
         cmpb  #$FF
         beq   L0278
         bitb  #$80
         beq   L0268
         tst   <u0006
         lbeq  L01C8
         lbsr  L01CF
L0268    puls  y,b,a
         lda   <fdesc,u
         eora  <u0006
         ora   -$01,y
         eora  <u0006
         sta   <fdesc,u
         clrb  
         rts   
L0278    eorb  <u0006
         stb   <u0007
         clrb  
         puls  pc,y,b,a
L027F    coma  
         puls  pc,y,x

         emod  
eom      equ   *
         end   
