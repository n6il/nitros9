*********************************************************************************
*  chat client via the DriveWire server
*
*	version 0.2 - 12/28/09 - AAW - mostly works
*

           nam     chat
           ttl     program module

           ifp1
           use     defsfile
           endc

tylg        set     Prgrm+Objct
atrv        set     ReEnt+rev
rev         set     $00
edition     set     1

           mod     eom,name,tylg,atrv,start,size
pbuffer     rmb     256
portdev		rmb		10
portpath	rmb		1
outpath		rmb		1
numbyt		rmb		1


size        equ     .

name        fcs     /chat/
           fcb     edition

int			fcs		/int/
	

******************************************			
* writech - write character in A to screen
* In:
*   A = character to write
*

writech     pshs    y,x,a           ;preserve regs + put A on stack for write
           lda     #1              ;path 1
           ldy     #1              ;1 character
           leax    ,s              ;write from stack
           os9     I$Write         ;write it
           puls    a,x,y,pc        ;return

* write out the contents of pbuffer.. length is in numbyt
writepb		clra
			ldb		numbyt,u
			tfr		d,y
			lda		outpath,u
			leax	pbuffer,u
			os9		I$Write
wrpb02		rts

*************************************
* chat main
*



        	
wrname		ldy		#0001
			
wrnlp		lda		,x+
			bmi		wrnout		;this is the last char
			pshs	x
			pshs	a			
			lda		portpath,u
			leax	,s
			os9		I$Write
			leas	1,s
			puls	x
			lbcs	errex2
			bra		wrnlp         	

wrnout		ldb		#C$CR		 	;end with a CR
			anda    #$7F
			pshs	d
			ldy		#0002
			lda		portpath,u
			leax	,s
			os9		I$Write
			leas	2,s
			lbcs	errex2
			rts

			* ask for next open port
getport		leax	<int,pc
			bsr		wrname
			* send it twice for arg
			leax	<int,pc
			bsr		wrname
			* read response
			ldy		#0006
			lda		portpath,u
			leax	pbuffer,u
			os9		I$Read
			lbcs	errex2
			lda		pbuffer,u
			lbeq		errex2			; no ports left
			* close /t0
			lda		portpath,u
			os9		I$Close
			lbcs	errex2
			
			* write port name
			lda	#4
			sta	numbyt,u
			bsr	writepb
			* open given port
			lda   	#UPDAT.      		get mode for modem path
			leax	pbuffer,u    	point to modem path
			os9   	I$Open      	open it
			lbcs  	errex1        	If error, exit with it
			sta		portpath,u		;set our working port
			rts

* use /t0 to get next available util port	
defport  	fcc   '/t0'
        	fcb   C$CR
        	fcb   $00,$00

chat		fcs		'chat'			
        	
			
           * save initial parameters
start      	pshs	d
			pshs	x
			
			* set output to stdout
			lda		#1
			sta		outpath,u
			
			
			* open /t0 first to get working port
			
			lda   #UPDAT.      		get mode for modem path
			leax	<defport,pc    	point to modem path
			os9   	I$Open      	open it
			lbcs  	errex1        	If error, exit with it
			sta		portpath,u
			
			bsr		getport			;find open utility port
			
			* at this point we should have a port
			leax		chat,pc
			lbsr		wrname			;write our name to server
		
			* write parameters to port - X = start addr, y = # bytes, A = path#
			
			puls 	x
			puls	y
			lda		portpath,u
			
			os9		I$Write
			lbcs	errex2
			
			* response loop
			* read 1 byte, this is how many bytes follow in this set.  0 for end of response
			
			* check for typed characters
rloop		ldd   #SS.Ready    Get code to check data ready on Std In
        	os9   I$GetStt     any data from keyboard?
        	bcc   stdinc		read and send the byte
        	
        	* check for incoming serial data
        	lda		portpath,u
        	ldb		#SS.Ready
        	os9		I$GetStt
        	bcc		serinc		read and print the byte
        	
        	* sleep a while
        	ldx		#0001
        	os9		F$Sleep
        	bra		rloop

        	* read one byte from stdin, send to server
stdinc		ldy		#0001
			clra
			leax	numbyt,u
			os9		I$Read
			lbcs	errex2
			
			ldy		#0001
			lda		portpath,u
			leax	numbyt,u
			os9		I$Write
			lbcs	errex2
			
			bra		rloop
			
        	* read one byte from serial, print on screen
serinc		ldy		#0001
			lda		portpath,u
			leax	numbyt,u
			os9		I$Read
			lbcs	errex2
			
			* bail out if 0
			lda		numbyt,u
			beq		done
			
			ldy		#0001
			lda		#1
			leax	numbyt,u
			os9		I$Write
			lbcs	errex2
			
			bra		rloop
			
			
			
done        clrb                    ;no errors here			
			* close port
errex2		lda		portpath,u
			os9		I$Close
		
errex1		os9     F$Exit          ;goodbye



           emod
eom         equ     *
 end
