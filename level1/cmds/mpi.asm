********************************************************************
* mpi - Determines if a Multi-Pak Interface is present
*
* $Id$
*
* Edt/Rev  YYYY/MM/DD  Modified by
* Comment
* ------------------------------------------------------------------
*   1      2004/03/16  Rodney Hamilton
* Created.

         nam   mpi
         ttl   Determines if a Multi-Pak is present

         ifp1
         use   defsfile
         endc

tylg     set   Prgrm+Objct   
atrv     set   ReEnt+rev
rev      set   $00
edition  set   1

         mod   eom,name,tylg,atrv,start,size

         org   0
         rmb   200
size     equ   .

name     fcs   /mpi/
         fcb   edition

no	fcc   "No "
mpi	fcc   "MPI found"
	fcb   C$CR

start	equ   *
        tfr   cc,a
        pshs  a
	ldx   #$FF7F
	lda   #$CC
        orcc  #IntMasks
	eora  ,x
	sta   ,x
	cmpa  ,x
        puls  a
        tfr   a,cc
	beq   is_mpi
	leax  <no,pc
	bra   doit
is_mpi	leax  <mpi,pc
doit	equ   *
	ldy   #100
	lda   #$01
	os9   I$WritLn 
	bcs   L001C
	clrb 
L001C	os9   F$Exit 

	emod
eom	equ   *
	end
