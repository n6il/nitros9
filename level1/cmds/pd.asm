********************************************************************
* p[wx]d - Print work/execution directory
*
* $Id$
*
* Ed.    Comments                                       Who YY/MM/DD
* ------------------------------------------------------------------
*   1    From Tandy OS-9 Level One VR 02.00.00

         nam   p[wx]d
         ttl   Print work/execution directory

* Disassembled 98/09/10 23:50:10 by Disasm v1.6 (C) 1988 by RML

         ifp1
         use   defsfile
         use   rbfdefs
         endc

tylg     set   Prgrm+Objct   
atrv     set   ReEnt+rev
rev      set   $01
edition  set   1

         mod   eom,name,tylg,atrv,start,size

         org   0
fildes   rmb   1
bufptr   rmb   2
dotdotfd rmb   3		LSN of ..
dotfd    rmb   3		LSN of .
ddcopy   rmb   5
dentry   rmb   160
buffer   rmb   1
sttbuf   rmb   282
size     equ   .

         IFNE   PXD
name     fcs   /pxd/
         ELSE
         IFNE  PWD
name     fcs   /pwd/
         ENDC
         ENDC
         fcb   edition

         IFNE   PXD
badnam   fcc   "pxd"
         ELSE
         IFNE  PWD
badnam   fcc   "pwd"
         ENDC
         ENDC
         fcc   ": bad name in path"
         fcb   C$CR
dotdot   fcc   "."
dot      fcc   "."
cr       fcb   C$CR
rdmsg    fcc   "read error"
         fcb   C$CR

start    leax  >buffer,u		point X to buffer
         lda   #C$CR			get CR
         sta   ,x			store at start of buffer
         stx   <bufptr			store buffer pointer
         leax  >dot,pcr			point to '.'
         bsr   open			open directory
         sta   <fildes			save path
         lbsr  rdtwo			read '.' and '..' entries
         ldd   <dotdotfd		get 24 bit LSN of ..
         std   <ddcopy
         lda   <dotdotfd+2
         sta   <ddcopy+2		and save copy
L0052    bsr   AtRoot			are we at root?
         beq   L0079			branch if so
         leax  >dotdot,pcr		else point to '..'
         bsr   chdir			change directory
         lda   <fildes			get path to previous dir
         os9   I$Close  		close it
         bcs   Exit			branch if error
         leax  >dot,pcr			point X to new current dir
         bsr   open			open it
         bsr   rdtwo			read . and .. entires of this dir
         bsr   FindMtch			search for match
         bsr   L00E2
         ldd   <dotdotfd
         std   <ddcopy
         lda   <dotdotfd+2
         sta   <ddcopy+2
         bra   L0052
L0079    lbsr  GetDevNm			get device name
         ldx   <bufptr			point to buffer
         ldy   #$0081			get bytes to write
         lda   #$01			to stdout
         os9   I$WritLn 		write
         lda   <fildes			get path
         os9   I$Close  		close
         clrb  
Exit     os9   F$Exit   		and exit

         IFNE  PXD
chdir    lda   #DIR.+EXEC.+READ.
         ELSE
         IFNE  PWD
chdir    lda   #DIR.+READ.
         ENDC
         ENDC
         os9   I$ChgDir 
         rts   

         IFNE  PXD
open     lda   #DIR.+EXEC.+READ.
         ELSE
         IFNE  PWD
open     lda   #DIR.+READ.
         ENDC
         ENDC
         os9   I$Open   
         rts   

* Read directory entry
read32   lda   <fildes
         leax  dentry,u
         ldy   #DIR.SZ
         os9   I$Read   
         rts   

FindMtch lda   <fildes		get path to current dir
         bsr   read32		read entry
         bcs   CantRead		branch if error
         leax  dentry,u		point to entry buffer
         leax  <DIR.FD,x	point X to FD LSN
         leay  ddcopy,u		point Y to copy of LSN
         bsr   attop		compare the two
         bne   FindMtch		keep reading until we find match
         rts   

* Compare 3 bytes at X and Y
attop    ldd   ,x++
         cmpd  ,y++
         bne   L00C5
         lda   ,x
         cmpa  ,y
L00C5    rts   

AtRoot   leax  dotdotfd,u	point X at .. entry
         leay  dotfd,u		point Y at . entry
         bsr   attop		check if we're at the top
         rts   

rdtwo    bsr   read32  * read "." from directory
         ldd   <dentry+DIR.FD
         std   <dotfd
         lda   <dentry+DIR.FD+2
         sta   <dotfd+2
         bsr   read32  * read ".." from directory
         ldd   <dentry+DIR.FD
         std   <dotdotfd
         lda   <dentry+DIR.FD+2
         sta   <dotdotfd+2
         rts   

* Get name from directory entry
L00E2    leax  dentry,u
prsnam   os9   F$PrsNam 
         bcs   IlglName
         ldx   <bufptr
L00EB    lda   ,-y
         anda  #$7F			mask hi bit
         sta   ,-x			save
         decb  
         bne   L00EB
         lda   #PDELIM
         sta   ,-x
         stx   <bufptr
         rts   

GetDevNm lda   <fildes
         ldb   #SS.DevNm
         leax  >sttbuf,u
         os9   I$GetStt 
         bsr   prsnam
         rts   

IlglName leax  >badnam,pcr
         bra   wrerr

CantRead leax  >rdmsg,pcr
wrerr    lda   #$02
         os9   I$WritLn 
         os9   F$Exit

         emod
eom      equ   *
         end

