********************************************************************
* RFM - Remote File Manager
*
*
*  1       2010/02/20  AAW
*          first version - just send ops

         nam   RFM
         ttl   Remote File Manager

         IFP1
         use   defsfile
         use   rfmdefs
         use   dwdefs.d
         ENDC

tylg     set   FlMgr+Objct
atrv     set   ReEnt+rev
rev      set   0
edition  equ   1

         mod   eom,RFMName,tylg,atrv,RFMEnt,0

RFMName  fcs   /RFM/
         fcb   edition



******************************
*
* file manager entry point
*
* Entry: Y = Path descriptor pointer
*        U = Callers register stack pointer
*

RFMEnt   lbra  create         Create path
         lbra  open         Open path
         lbra  makdir        Makdir
         lbra  chgdir        Chgdir
         lbra  delete        Delete 
         lbra  seek        Seek
         lbra  read         Read character 
         lbra  write        Write character
         lbra  readln       ReadLn
         lbra  writln       WriteLn
         lbra  getstt       Get Status
         lbra  setstt       Set Status
         lbra  close        Close path

create	lda		#DW.create
		lbra	sendit
open	lda		#DW.open
		lbra	sendit
makdir	lda		#DW.makdir
		lbra	sendit
chgdir	lda		#DW.chgdir
		lbra	sendit
delete	lda		#DW.delete
		lbra	sendit
seek	lda		#DW.seek
		lbra	sendit
read	lda		#DW.read
		lbra	sendit
write	lda		#DW.write
		lbra	sendit
readln	lda		#DW.readln
		lbra	sendit
writln	lda		#DW.writln
		lbra	sendit
getstt	lda		#DW.getstt
		lbra	sendit
setstt	lda		#DW.setstt
		lbra	sendit
close	lda		#DW.close
		lbra	sendit

* just send OP_VMF + vfmop
sendit	 pshs      u

		pshs 	y
		pshs	a
			 
		* put diag info in PD.FST
		
		leay		PD.FST,y
		
		stu		,y++	; U from IOman
		
		ldx		R$X,u	; should be X from caller
		stx		,y++
		
		ldx		1,s		; Y from ioman
		stx		,y++
		
		ldx		R$X+PD.RGS,x   ; should be X from caller
		stx		,y++
		
		* 10 bytes from X?
		clrb
sleep1	lda		,x+
		sta		,y+
		incb
		cmpb	#10
		bne		sleep1
		
		 

         lda       #OP_VFM          ; load command
         pshs      a                ; command store on stack
         leax      ,s                  ; point X to stack 
         ldy       #2                  ; 2 byte to send
         ifgt      Level-1
         ldu       <D.DWSubAddr
         else      
         ldu       >D.DWSubAddr
         endc      
         
         jsr	6,u
         leas	2,s		;clean stack
         
         puls 	x
         ldy	#107
         jsr	6,u
         
         
      
		puls	u
		clrb
		rts

		
         emod
eom      equ   *
         end

