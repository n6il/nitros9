********************************************************************
* Boot - Cloud-9 TC3 Boot module
*
* $Id$
*
* This module allows booting from a hard drive that uses RGB-DOS
* and is controlled by a Cloud-9 TC3 SCSI controller.
*
* Ed.    Comments                                       Who YY/MM/DD
* ------------------------------------------------------------------
* 1      Original Roger Krupski distribution version
* 1b     Added code to allow booting from any sector    BGP 96/??/??
*        size hard drive


         nam   Boot
         ttl   Cloud-9 TC3 Boot module

         ifp1
         use   defsfile
         endc

tylg     set   Systm+Objct
atrv     set   ReEnt+rev
rev      set   2
edition  set   1

* Hard Disk Interface registers for the TC3
dataport equ   $FF74
status   equ   dataport+1
select   equ   dataport+1

* Status register equates
req      equ   1
busy     equ   2
msg      equ   4
cmd      equ   8
inout    equ   $10
ack      equ   $20
sel      equ   $40
rst      equ   $80

*SCSI common command set
c$rstr   equ   1
c$rdet   equ   3
c$rblk   equ   8
c$wblk   equ   10

* Optional command
c$ststop equ   $1b                     park head

* misc
errsta   equ   2
bsybit   equ   8

****************************************************
bootdrv  equ   0
****************************************************

         mod   eom,name,tylg,atrv,start,size

* Data equates; subroutines must keep data in stack
v$cmd    rmb   1
v$addr0  rmb   1
v$addr1  rmb   2
v$blks   rmb   1
v$opts   rmb   1
v$error  rmb   4

blockloc rmb   2                       pointer to memory requested
blockimg rmb   2                       duplicate of the above
bootloc  rmb   3                       sector pointer; not byte pointer
bootsize rmb   2                       size in bytes
size     equ   .

name     fcs   /Boot/
         fcb   edition

start    clra
         ldb   #size
clean    pshs  a
         decb
         bne   clean
         tfr   s,u                     get pointer to data area
         pshs  u                       save pointer to data area

         lda   #$d0                    forced interrupt; kill floppy activity
         sta   $FF48                   command register
         clrb
pause    decb
         bne   pause
         lda   $FF48                   clear controller
         clr   $FF40                   make sure motors are turned off
         sta   $FFD9                   fast clock

* Recalibrate hard drive
         lbsr  restore

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

* Generic read
read10   lda   #c$rblk
         bsr   setup
         bra   command

setup    pshs  b
         sta   v$cmd,u
         stb   v$addr0,u
         stx   v$addr1,u
         ldb   #1
         stb   v$blks,u
         clr   v$opts,u
         puls  b,pc

wakeup   ldx   #0
wake     lda   status
         bita  #busy+sel
         beq   wake1
         leax  -1,x
         bne   wake
         bra   wake4
wake1    bsr   wake3
         lda   #1			SCSI ID!
         sta   dataport
         bsr   wake3
         sta   select
         ldx   #0
wake2    lda   status
         bita  #busy
         bne   wake3
         leax  -1,x
         bne   wake2
wake4    leas  2,s
         comb
         ldb   #E$NotRdy
wake3    rts

command  bsr   wakeup
         leax  v$cmd,u
         bsr   send
         bsr   waitrq
         bita  #cmd
         bne   getsta
         ldx   blockloc,u
         bsr   read
getsta   bsr   instat
         bita  #bsybit
         bne   command
         bita  #errsta
         beq   done
         comb
done     rts

send     bsr   waitrq
         bita  #cmd
         beq   done
         bita  #inout
         bne   done
         lda   ,x+
         sta   dataport
         bra   send

waitrq   pshs  b,x
wait10   lda   status
         bita  #req
         beq   wait10
         puls  b,x,pc

* Patch to allow booting from sector sizes > 256 bytes - BGP 08/16/97
* We ignore any bytes beyond byte 256, but continue to read them from
* the dataport until the CMD bit is set.
read
* next 2 lines added
         clrb                          +++ use B as counter
read2
         bsr   waitrq
         bita  #cmd
         bne   done
         lda   dataport
         sta   ,x+
* next line commented out and next 8 lines added
* bra read
         incb                          +++
         bne   read2                   +++
read3
         bsr   waitrq                  +++
         bita  #cmd                    +++
         bne   done                    +++
         lda   dataport                +++
         bra   read3                   +++

instat   bsr   waitrq
         lda   dataport
         anda  #%00001111
         pshs  a
         bsr   waitrq
         clra
         sta   dataport
         puls  a,pc

restore  lda   #c$rstr
         clrb
         ldx   #0
         lbsr  setup
         clr   v$blks,u
         bra   command

* Fillers to get to $1D0
         fcc   /9999999999/
         fcc   /9999999999/
         fcc   /9999999999/
         fcc   /9999999999/
         fcc   /9999999999/
         fcc   /9999999999/
         fcc   /9999999999/
         fcc   /9999999999/
         fcc   /99999999/

         emod

eom      equ   *
