********************************************************************
* Boot - Glenside IDE Boot module
*
* $Id$
*
* Ed.    Comments                                       Who YY/MM/DD
* ------------------------------------------------------------------
* 1      Created                                        BGP 99/05/11

         nam   Boot
         ttl   Glenside IDE Boot module

         ifp1
         use   defsfile
         endc

tylg     set   Systm+Objct
atrv     set   ReEnt+rev
rev      set   0
edition  set   1

         mod   eom,name,tylg,atrv,start,size

blockloc rmb   2                       pointer to memory requested
blockimg rmb   2                       duplicate of the above
bootloc  rmb   3                       sector pointer; not byte pointer
bootsize rmb   2                       size in bytes
size     equ   .

name     fcs   /Boot/
         fcb   edition

hwport   fdb   $FF70

start    clra
         ldb   #size
clean    pshs  a
         decb
         bne   clean
         tfr   s,u                     get pointer to data area
         pshs  u                       save pointer to data area

         lda   #$D0                    forced interrupt; kill floppy activity
         sta   $FF48                   command register
         clrb
pause    decb
         bne   pause
         lda   $FF48                   clear controller
         clr   $FF40                   make sure motors are turned off
         sta   $FFD9                   fast clock
         lbsr   Init

* Request memory for LSN0
         ldd   #1
         os9   F$SRqMem                request one page of RAM
         bcs   error
         bsr   getpntr

* Get LSN0 into memory
         clrb                          MSB sector
         ldx   #0                      LSW sector
         bsr   mread
         bcs   error
         ldd   bootsize,u
         beq   error
         pshs  d

* Return memory
         ldd   #$100
         ldu   blockloc,u
         os9   F$SRtMem
         puls  d
         os9   F$BtMem
         bcs   error
         bsr   getpntr
         std   blockimg,u

* Get os9boot into memory
         ldd   bootsize,u
         leas  -2,s                    same as a PSHS D
getboot  std   ,s
         ldb   bootloc,u               MSB sector location
         ldx   bootloc+1,u             LSW sector location
         bsr   mread
         ldd   bootloc+1,u             update sector location by one to 24bit word
         addd  #1
         std   bootloc+1,u
         ldb   bootloc,u
         adcb  #0
         stb   bootloc,u
         inc   blockloc,u              update memory pointer for upload
         ldd   ,s                      update size of file left to read
         subd  #$100                   file read one sector at a time
         bhi   getboot

         leas  4+size,s                reset the stack    same as PULS U,D
         ldd   bootsize,u
         ldx   blockimg,u              pointer to start of os9boot in memory
         andcc #^Carry                 clear carry
         rts                           back to os9p1

error    leas  2+size,s
         ldb   #E$NotRdy               drive not ready
         rts

getpntr  tfr   u,d                     save pointer to requested memory
         ldu   2,s                     recover pointer to data stack
         std   blockloc,u
         rts

mread    tstb
         bne   read10
         cmpx  #0
         bne   read10
         bsr   read10
         bcc   readlsn0
         rts

readlsn0 pshs  a,x,y
         ldy   blockloc,u
         lda   DD.Bt,y                 os9boot pointer
         ldx   DD.Bt+1,y               LSW of 24 bit address
         sta   bootloc,u
         stx   bootloc+1,u
         ldx   DD.BSZ,y                os9boot size in bytes
         stx   bootsize,u
         clrb
         puls  a,x,y,pc

* Initialize IDE interface
Init     ldx   #$1500
         ldy   hwport,pc
RdyIni1  tst   7,y           Wait for drive ready
         bpl   GoInit
         leax  -1,x
         bne   RdyIni1
         lbeq  ENotRdy       Timed out ... give up on drive

GoInit   ldd   #$AF20        Drive is ready -- initialize
* For IDE command $91, DrvHd reg = 101xhhhh binary
         sta   6,y           $10 heads       (x=0-master/1-slave; hhhh=#heads)
         stb   2,y           $20 sectors/track
         lda   #$91 
         sta   7,y           Give drive the Init Drive Parameters IDE command
RdyIni2  tst   7,y
         bmi   RdyIni2       Wait *forever* until drive is ready
         clrb
         rts
ENotRdy  comb
         ldb    #E$NotRdy
         rts

*
* READ
*
* B = MSB of OS-9 disk LSN
* X = LSB of OS-9 disk LSN
*
read10   lbsr  SetIDE
         bcs   Ret
         ldx   blockloc,u
         lda   #$20
         pshs  a
         ldy   hwport,pc
ReadLp   lda   ,y
         ldb   ,y
         std   ,x++
         lda   ,y
         ldb   ,y
         std   ,x++
         lda   ,y
         ldb   ,y
         std   ,x++
         lda   ,y
         ldb   ,y
         std   ,x++
         dec   ,s
         bne   ReadLp
         puls  a

*
* After read or write, check drive status
*   Return value = CC, true=error, false=OK
*
WaitOK   lda   #$80        Is DRQ still true?  Just one check necessary
         ldy   hwport,pc
         bita  7,y         If it is, sector isn't fully transferred
         bne   WaitOK      
         lda   #$01        Wait *forever* for drive ready
         bita  7,y
         bne   CmdErr
Ret      clrb              Nope -- clear CC
         rts   
CmdErr   comb              Yep  -- set CC
         rts   

*
* Setup IDE read or write operation
* trashes D and X
*
SetIDE   pshs  b,x
         ldx   #$A000
CmdLp1   ldy   hwport,pc
         tst   7,y
         bpl   SetRdy       Should go to ChkDRDY ?????
         leax  -1,x
         bne   CmdLp1
         puls  b,x
         bra   ENotRdy

SetRdy   lda   2,s          Sector first
         anda  #$1F
         adda  #$01
         sta   3,y          Store calculated sector number
         ldd   1,s
         rolb  
         rola  
         rolb  
         rola  
         rolb  
         rola  
         anda  #$0F
         ora   #$A0
         sta   6,y          Store calculated drive number
         ldd   ,s           Last, the cylinder number (2-bytes)
         rora  
         rorb  
         anda  #$7F
         sta   5,y          Store calculated CylHi
         stb   4,y          Store calculated CylLo
         lda   #$01
         sta   2,y          Sector count = 1
         ldb   #$20
         stb   7,y          Lastly, push the command to the drive
         ldb   #$40
         lda   #$08         Wait for Drive ready
CmdLp2   bita  7,y
         bne   CmdDone
         decb  
         bne   CmdLp2
         ldx   #$0001       If we time out, sleep 1 tick, then loop *forever*
         os9   F$Sleep
CmdLp3   bita  7,y
         beq   CmdLp3
CmdDone  puls  b,x
         clrb               All right, drive ready -- return
         rts   

* Fillers to get to $1D0
         fcc   /9999999999/
         fcc   /9999999999/
         fcc   /9999999999/
         fcc   /9999999999/
         fcc   /9999999999/
         fcc   /9999999999/
         fcc   /9999999999/
         fcc   /999999999/

         emod

eom      equ   *
