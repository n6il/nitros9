
* Attr - Modify file attributes
*
* $Id$
*
* Edt/Rev  YYYY/MM/DD  Modified by
* Comment
* ------------------------------------------------------------------
*  11      ????/??/??
* From Tandy OS-9 Level Two VR 02.00.01.

         nam   Attr
         ttl   Modify file attributes

* Disassembled 98/09/11 11:44:51 by Disasm v1.6 (C) 1988 by RML

         use   defsfile.d

DOHELP   set   0

tylg     set   Prgrm+Objct
atrv     set   ReEnt+rev
rev      set   $00
edition  set   11


         section data
fpath    rmb   1
rawpath  rmb   1
parmptr  rmb   2
cmdperms rmb   2
u0006    rmb   1
u0007    rmb   1
pathopts rmb   20
u001C    rmb   2
u001E    rmb   1
u001F    rmb   9
u0028    rmb   32
filename rmb   32
fdesc    rmb   16
u0078    rmb   46
         endsect

         section code
*         psect tee_a,Prgrm+Objct,ReEnt+rev,edition,200,start


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

start    stx   parmptr		save param ptr
         clr   u0007
         com   u0007
* Open file at X as file
         clra  
         os9   I$Open		open file on commandline
         bcc   L00D9		branch if ok
* If error, try to open as directory with read permission
         ldx   parmptr		get saved param ptr
         lda   #DIR.+READ.	load perms
         os9   I$Open		open as directory
         bcc   L00D9		branch if ok
* One last time, try open as directory only
         ldx   parmptr		get param ptr
         lda   #DIR.		load different perms
         os9   I$Open		try one more time
         bcs   L0114		branch if error
L00D9    sta   fpath		save off path
         stx   cmdperms	save updated parm ptr
         leax  pathopts		point X to buffer
         ldb   #SS.Opt		load with status code
         os9   I$GetStt		get status
         bcs   L0114		branch if error
         clrb  
         lda   ,x		get path type
         cmpa  #DT.RBF		check if rbf path
         lbne  ShowHelp		branch if not
         ldx   parmptr		else get parm ptr
         leay  filename		 point to buffer
         lda   ,x+		get file name character
         cmpa  #PDELIM		path delimiter?
         bne   L0106		no
L00FA    sta   ,y+		else save char in Y
         lda   ,x+		get next file name char
         cmpa  #C$PERD		period?
         bcs   L0106		branch if not
         cmpa  #PDELIM		path delimiter?
         bne   L00FA		branch if not
L0106    lda   #PENTIR
         ldb   #C$SPAC
         std   ,y++
         leax  filename		point X to filename
         lda   #READ.+WRITE.	load perms
         os9   I$Open		open in raw mode
L0114    lbcs  ShowHelp		branch if error
         sta   rawpath
         lda   fpath
         clr   u001F
         pshs  u
         ldx   u001C		get MS 16 bits
         ldu   u001E		get LS 16 bits
         lda   rawpath		get path
         os9   I$Seek		seek
         puls  u
         bcs   ShowHelp		branch if error
         leax  fdesc		point to buffer
         ldy   #FD.SEG
         os9   I$Read
         bcs   ShowHelp
         os9   F$ID		get ID
         cmpy  #$0000		super user?
         beq   L014B		branch if so
         cmpy  fdesc+FD.OWN	is user same as file's owner?
         bne   L01C1		branch if not
L014B    ldx   cmdperms		point to perms on cmd line
         lbsr  L021D
         bcs   L018B
L0152    lbsr  L021D
         bcc   L0152
         clrb  
         lda   ,x
         cmpa  #C$CR
         bne   ShowHelp
         pshs  u
         ldx   u001C
         ldu   u001E
         lda   rawpath
         os9   I$Seek		seek
         puls  u
         bcs   ShowHelp		branch if error
         leax  fdesc		point to file desc
         ldy   #1		only 1 byte
         os9   I$Write		write out new attributes
         bcs   ShowHelp		branch if error
         os9   I$Close		close file
         bcs   ShowHelp		branch if error
         lda   fpath		get file path
         os9   I$Close		close file
         bcs   ShowHelp		branch if error
         ldb   u0007
         beq   L01BE
L018B    ldb   fdesc		get attribute
         leax  >Attrs,pcr
         leay  u0078
         lda   ,x+
L0197    lslb  
         bcs   L019C
         lda   #'-
L019C    sta   ,y+
         lda   ,x+
         bpl   L0197
         lda   #C$CR
         sta   ,y+
         leax  u0078
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
         lda   fpath
         ldx   #$0000
         ldu   #DIR.SZ*2
         os9   I$Seek
         ldu   $04,s
         bcs   L01BE
L01E0    leax  u0028
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
L021D    clr   u0006
L021F    lda   ,x+
         cmpa  #C$SPAC
         beq   L021F
         cmpa  #C$COMA
         beq   L021F
         cmpa  #'-
         bne   L0231
         com   u0006
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
         tst   u0006
         lbeq  L01C8
         lbsr  L01CF
L0268    puls  y,b,a
         lda   fdesc
         eora  u0006
         ora   -$01,y
         eora  u0006
         sta   fdesc
         clrb  
         rts   
L0278    eorb  u0006
         stb   u0007
         clrb  
         puls  pc,y,b,a
L027F    coma  
         puls  pc,y,x

         endsect
