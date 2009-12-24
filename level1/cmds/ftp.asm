*********************************************************************************
*  ftp - ftp client via the DriveWire server
* 
*   using a virtual channel from DriveWire, send commands and write results
*   to stdout.
* 
*	version 0.2 - 12/19/09 - AAW - bare minimum implementation 
*

            nam     ftp
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
filename	rmb		128
filepath	rmb	 	1


size        equ     .

name        fcs     /ftp/
            fcb     edition

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
* dw main
*

* default to port /t0.. and use it no matter what, maybe set on cmdline in future?	
defport  	fcc   '/t0'
         	fcb   C$CR
         	fcb   $00,$00               

         	
wrname		ldy		#0001
			leax	<name,pc
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

			
            * save initial parameters
start      	pshs	d
			pshs	x
			
			* set output to stdout
			lda		#1
			sta		outpath,u
			
			
			* open port
			
			lda   #UPDAT.      get mode for modem path
			leax	<defport,pc    point to modem path
			os9   I$Open       open it
			lbcs  errex1        If error, exit with it
			sta   portpath,u    save path to modem
			
			bsr		wrname			;write our name to server
		
			* write parameters to port - X = start addr, y = # bytes, A = path#
			
			puls 	x
			puls	y
			lda		portpath,u
			
			os9		I$Write
			lbcs	errex2
			
			* response loop
			* read 1 byte, this is how many bytes follow in this set.  0 for end of response
			
rloop		leax	numbyt,u		;put it in our numbyt 
			bsr		read1
			
			* if byte is 0, we're done
			ldb		numbyt,u
			lbeq		done
			
			* if byte is 240, server wants input
			cmpb	#240
			lbeq		getinp
			
			* if byte is 241, start writing to file
			cmpb	#241
			lbeq		wrfile
			
			* if byte is 242, close file
			cmpb 	#242
			beq		clfile
			
			* if byte is 243, start writing to stdout
			cmpb	#243
			lbeq		wrstdo
			
			* if byte is 244, set file name
			cmpb	#244
			beq		setfile
			
			* if byte is 245, create file
			cmpb	#245
			beq		crfile
			
			*otherwise read the number of bytes announced
			clra
			tfr		d,y
			leax	pbuffer,u
			lda		portpath,u
			os9		I$Read
			lbcs	errex2
			
			* did we get the right # of bytes?
			tfr		y,d
			cmpb	numbyt,u
			lbne		errex2		; gives bytes actually read as error #.. wrong but handy
			
			* write out pbuffer
			lbsr		writepb

			* next set
			bra		rloop	

			* read one byte
read1		ldy		#0001			;read one byte
			lda		portpath,u		;read from port path
			os9		I$Read
			lbcs	errex2
			
			* if Y = 1, we got our byte, otherwise bail out
			cmpy	#0001
			bne		errex2			
		
			rts
			
			
			
			* set file name
setfile		leax	filename,u
			bsr		read1
			clra	
			ldb		filename,u
			tfr		d,y
			leax	filename,u
			lda		portpath,u
			os9		I$Read
			lbcs	errex2
			bra		rloop
			
			* create file
crfile		lda		#WRITE.
			ldb		#3			;read write
			leax	filename,u
			os9		I$Create
			lbcs	errex2
			sta		filepath,u
			lbra		rloop

			* close file
clfile		lda		filepath,u
			os9		I$Close
			lbcs	errex2
			lbra		rloop
			
			* start writing to file
wrfile		
			lda		filepath,u
			sta		outpath,u
			lbra		rloop
			
			* set output for stdout 
wrstdo		lda		#1			
			sta		outpath,u
			lbra	rloop
			
			* read a line from stdin
getinp		clra				;stdin			
			leax	pbuffer,u
			ldy		#80
			os9		I$ReadLn
			lbcs	errex2
			
			pshs	y
			
			* send our name to server
			lbsr		wrname
			
			puls	y
			
			* send data server
			lda		portpath,u
			leax	pbuffer,u
			os9		I$Write
			lbcs	errex2
			
			lbra		rloop
			
done        clrb                    ;no errors here			
			* close port
errex2		lda		portpath,u
			os9		I$Close
		
errex1		os9     F$Exit          ;goodbye    
            


            
            
			
*end of mod         
            emod
eom         equ     *
            end

