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

      
         rmb   $0000
size     equ   .


         org   $0000
 
pathlen  rmb   1
pathnum	 rmb   1
origu	 rmb   2
xfersz	 rmb   2        
bufptr	 rmb   2

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

create	stu		origu,pc
			
		* put path # on stack
		lda		,y
		sta		pathnum,pc
		pshs	a
		
		* put rfm op on stack
		ldb		#DW.create
		bra		create1

		
open	stu		origu,pc
		
		* put path # on stack
		lda		,y
		sta		pathnum,pc
		pshs	a
		
		* put rfm op and DW op on stack
		ldb		#DW.open

create1	lda		#OP_VFM
		pshs	d
		
     	* get system mem
        ldd		#256
       	os9		F$SRqMem	; ask for D bytes (# bytes server said is coming)
       	stu		bufptr,pc	; store pointer to our memory
       	
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

        clr		pathlen,pc
        
		
       	ldx   <D.Proc   	get curr proc desc
        ldb   P$Task,x  	get task #
       
        ldx		origu,pc
        ldx		R$X,x	; should be X from caller
        	
       	ldy		bufptr,pc
       	
open1  	os9		f$ldabx
		sta		,y+
        leax	1,x
        inc		pathlen,pc
        cmpa	#$0D
        bne		open1
        
        * store advanced X in calling process (SCF does this.. ?)
        leax	-1,x
        ldy		origu,pc
        stx		R$X,y
                
        * send to server
        clra 
        ldb		pathlen,pc	
        tfr		d,y		; set Y to pathlen
        ldx		bufptr,pc	
        jsr		6,u
        
		* read response from server -> B
		leas 	-1,s	;room for response byte
        leax	,s
        ldy		#1
        jsr		3,u
        
        * free system mem
        ldd		#256
		ldu		bufptr,pc
		os9		F$SRtMem
        
		* pull server's response into B
        puls 	b
        tstb
        beq		open2
        
        orcc	#1			;set error
open2	ldu		origu,pc
		rts

makdir	lda		#DW.makdir
		lbra	sendit
chgdir	lda		#DW.chgdir
		lbra	sendit
delete	lda		#DW.delete
		lbra	sendit
seek	lda		#DW.seek
		lbra	sendit
		
read	stu		origu,pc
		
		* put path # on stack
		lda		,y
		sta		pathnum,pc
		pshs	a
		
		* put rfm op on stack
		ldb		#DW.read
		bra		read1		; join readln routine
		
		
		
write	lda		#DW.write
		lbra	sendit
		
		
	
readln	stu		origu,pc    	; store pointer to caller's register stack
		
		* put path # on stack
		lda		,y
		sta		pathnum,pc		;also store, not really needed (yet?)
		pshs	a
		
		* put rfm op and DW op on stack
		ldb		#DW.readln
read1  	lda		#OP_VFM
		pshs	d
		
		leax      ,s                  ; point X to stack 
        ldy       #3                  ; 3 bytes to send
        
        * set U to dwsub
        ifgt      Level-1
        ldu       <D.DWSubAddr
        else      
        ldu       >D.DWSubAddr
        endc      
         
        * send dw op, rfm op, path #
        jsr		6,u
        leas	3,s		;clean stack
       
        * put caller's Y on stack (maximum allowed bytes)
        ldx		origu,pc
        ldx		R$Y,x
        pshs	x
        
        * send 2 bytes from stack
        leax	,s
        ldy		#2
        jsr		6,u
        
        leas 1,s    ; leave 1 byte for server response in next section
        
        * read # bytes coming (0 = eof) from server
        leax	,s
        ldy		#1
        jsr		3,u
        
        * store size
        clra
        puls	b
        std		xfersz,pc
        
        * check for 0
        tstb
        beq		readln1		; 0 bytes = EOF
        
       	* read the data from server if > 0
       
       	* get system mem
       	pshs	u			; save U for later (ptr to dwsub)
       	os9		F$SRqMem	; ask for D bytes (# bytes server said is coming)
       	stu		bufptr,pc	; store pointer to our memory
       	puls	u			; get dwsub ptr back into U
       	
       	* load data from server into mem block
       	ldx		bufptr,pc
       	ldy		xfersz,pc
       	jsr		3,u
       	
       	* F$Move
       	* a = my task #
       	* b = caller's task #
       	* X = source ptr
       	* Y = byte count
       	* U = dest ptr
       	
       	* move from our mem to caller
       	
       	ldy		xfersz,pc		;Y = byte count (already set?)
       	
       	ldx		origu,pc
       	ldu		R$X,x	; U = caller's X = dest ptr
       
	   	lda		<D.SysTsk ; A = system task # 
       
       	ldx   <D.Proc   	get calling proc desc
        ldb   P$Task,x  	; B = callers task #
       	       	
       	ldx		bufptr,pc		; x = src ptr
       	
       *  F$Move the bytes (seems to work)
       os9	F$Move
       	
       * return system mem
       
       	ldd		xfersz,pc
		ldu		bufptr,pc
		os9		F$SRtMem
		
		* assume everything worked (not good)
		clrb
		ldy		xfersz,pc	; Y is supposed to be set to bytes read.. do we need to set this in the caller's regs?
		bra		readln2
       	
readln1	ldb		#E$EOF
		ldy		#0			; Y should be 0 if we didnt read any?  in callers regs?
		orcc	#1			; set error bit
       	
readln2	ldu		origu,pc	; put U back to the entry value.. needed?
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
        leas	2,s		;clean stack (leave 1 byte)
		
        * read server response
        leax	,s
        ldy		#1
        jsr		3,u
        
        ldb		,s ; server sends result code
        beq		close1
        orcc	#1	; set error flag if != 0
close1	leas	1,s
		puls	u
		rts
		
		
* just send OP_VMF + vfmop
sendit	 pshs	a
		
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
         
		clrb
		rts

		
         emod
eom      equ   *
         end

