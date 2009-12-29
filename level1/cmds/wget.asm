*********************************************************************************
*  wget - a (very!) simple implementation of something sort of like wget
* 
*   using a virtual channel from DriveWire, request a URL and write the response
*   to stdout.
* 
*	version 0.1 - 12/17/09 - AAW - bare minimum implementation 
*

            nam     wget
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
numbyt		rmb		1

size        equ     .

name        fcs     /wget/
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
			lda		#1
			leax	pbuffer,u
			os9		I$Write
wrpb02		rts
            
*************************************           
* wget main
*

* default to port /t0.. and use it no matter what, maybe set on cmdline in future?	

            * initialization/startup?
start      nop
			
			* save parameters for later
			pshs	d
			pshs	x

			* see if we can find a port to use
			
			* first setup pbuffer
			leax 	pbuffer,u
			lda		#47
			sta		,x+
			lda		#85
			sta		,x+
			lda		#48
			sta		,x+
			lda		#13
			sta		,x
						
tryport		lda   #UPDAT.      		get mode for modem path
			leax	pbuffer,u    	point to modem path
			os9   	I$Open      	open it
			bcc		gotport		
			
			cmpb	#250		;in use?
			lbne	errex1		;other error, bail out
			leax	pbuffer,u
			lda		2,x
			inca
			sta		2,x
			bra		tryport
			
gotport		sta		portpath,u
			
			* write our name
			ldy		#0001
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
			
			
			* write parameters to port - X = start addr, y = # bytes, A = path#
			
			puls 	x
			puls	y
			lda		portpath,u
			
			os9		I$Write
			lbcs	errex2
			
			* response loop
			* read 1 byte, this is how many bytes follow in this set.  0 for end of response
			
rloop		ldy		#0001			;read one byte
			leax	numbyt,u		;put it in our numbyt 
			lda		portpath,u		;read from port path
			os9		I$Read
			lbcs	errex2
			
			* if Y = 1, we got our byte, otherwise bail out
			cmpy	#0001
			bne		errex2
			
			* if byte was 0, we're done
			ldb		numbyt,u
			beq		done
			
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
			bne		errex2		; gives bytes actually read as error #.. wrong but handy
			
			* write out pbuffer
			lbsr		writepb

			* next set
			bra		rloop	


			
			
done        clrb                    ;no errors here			
			* close port
errex2		lda		portpath,u
			os9		I$Close
		
errex1		os9     F$Exit          ;goodbye    
            


            
            
			
*end of mod         
            emod
eom         equ     *
            end

