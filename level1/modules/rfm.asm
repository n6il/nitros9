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

         mod   eom,RFMName,tylg,atrv,RFMEnt,size

pathtmp	 rmb	256		         
size	 equ	*         
         
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

open	pshs u
				
		* put path # on stack
		lda		,y
		pshs	a
		
		* put rfm op and DW op on stack
		ldb		#DW.open
		lda		#OP_VFM
		pshs	d
		
		leax      ,s                  ; point X to stack 
        ldy       #3                  ; 3 bytes to send
        ifgt      Level-1
        ldu       <D.DWSubAddr
        else      
        ldu       >D.DWSubAddr
        endc      
         
        jsr		6,u
        leas	3,s		;clean stack
       
        * now send path string
        
        * copy path string 

		ldx   <D.Proc   	get curr proc desc
        ldb   P$Task,x  	get task #
       
        ldx		,s		; orig U is on stack
        ldx		R$X,x	; should be X from caller
		leay		pathtmp,pcr
		
		clra	
		pshs 	a
		
open1  os9	f$ldabx
		sta		,y+
        leax	1,x
        inc		,s
        cmpa	#$0D
        bne		open1

        * send to server
        clra 
        ldb		,s		; leave a byte on stack for response
        tfr		d,y
        leax 	pathtmp,pcr	
        jsr		6,u
        
		* read response from server -> B
        leax	,s
        ldy		#1
        jsr		3,u
        puls 	b
        
		puls 	u
		rts

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
		
readln	pshs u
				
		* put path # on stack
		lda		,y
		pshs	a
		
		* put rfm op and DW op on stack
		ldb		#DW.readln
		lda		#OP_VFM
		pshs	d
		
		leax      ,s                  ; point X to stack 
        ldy       #3                  ; 3 bytes to send
        ifgt      Level-1
        ldu       <D.DWSubAddr
        else      
        ldu       >D.DWSubAddr
        endc      
         
        jsr		6,u
        leas	3,s		;clean stack
       
        * send max bytes
        ldx		,s
        ldx		R$Y,x
        pshs	x
        leax	,s
        ldy		#2
        jsr		6,u
        
        leas 1,s
        
        * read # bytes (0 = eof)
        leax	,s
        ldy		#1
        jsr		3,u
        
        puls	b
        bne		readln1
        
        * eof
        ldb		#211
        orcc	#1
        puls	u
        rts
        
        * read B chars into mem at addr in caller's X
        * first into our buffer INCOMPLETE/FUBAR
readln1	pshs 	b
		leax	pathtmp,pcr
		clra
		tfr		d,y
		jsr		3,u
		
		puls	u		; done with dwsub
		
		
		
		clrb
		rts

        
writln	lda		#DW.writln
		lbra	sendit
getstt	lda		#DW.getstt
		lbra	sendit
setstt	lda		#DW.setstt
		lbra	sendit
		
close	pshs u
				
		* put path # on stack
		lda		,y
		pshs	a
		
		* put rfm op and DW op on stack
		ldb		#DW.close
		lda		#OP_VFM
		pshs	d
		
		leax      ,s                  ; point X to stack 
        ldy       #3                  ; 3 bytes to send
        ifgt      Level-1
        ldu       <D.DWSubAddr
        else      
        ldu       >D.DWSubAddr
        endc      
         
        jsr		6,u
        leas	3,s		;clean stack
		
		clrb
		puls	u
		rts
		
		
* just send OP_VMF + vfmop
sendit	 pshs      u

		pshs 	y
		pshs	a
		
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


        * copy path string 

		ldx   <D.Proc   	get curr proc desc
        ldb   P$Task,x  	get task #
       
        ldx		,s
        ldx		R$X,x	; should be X from caller
		leay		pathtmp,pcr
		
		clra	
		pshs 	a
		
send1  os9	f$ldabx
		sta		,y+
        leax	1,x
        inc		,s
        cmpa	#$0D
        bne		send1

        * send to server
        clra 
        puls	b
        tfr		d,y
        leax 	pathtmp,pcr	
        jsr		6,u
        
		puls	u
		clrb
		rts

		
         emod
eom      equ   *
         end
