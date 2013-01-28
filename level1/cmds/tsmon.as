*******************************************************************
* Tsmon - Timesharing monitor
*
* $Id$
*
* Edt/Rev  YYYY/MM/DD  Modified by
* Comment
* ------------------------------------------------------------------
*   6      ????/??/??
* From Tandy OS-9 Level Two VR 02.00.01.

         nam   Tsmon
         ttl   Timesharing monitor

         use   defsfile.d

rev      set   $00
edition  set   2

         section .bss
childid  rmb   1
parmptr  rmb   2
parmlen  rmb   2
inbuff   rmb   128
         endsect

*         psect tsmon_a,Prgrm+Objct,ReEnt+rev,edition,200,start
         section code

Login    fcc   "LOGIN"
LoginPrm fcb   C$CR

IcptRtn  rti

__start  stx   parmptr			save parameter pointer
         std   parmlen			save parameter length
         leax  IcptRtn,pcr		point to intercept routine
         os9   F$Icpt   		and set it
L0024    ldx   parmptr			get pointer to parameter
         ldd   parmlen			and length
         cmpd  #$0002			
         bcs   L0052
         lda   ,x			get byte at command line
         cmpa  #C$CR			cr?
         beq   L0052			if so, branch
         clra  				stdin
         os9   I$Close  		close it
         lda   #UPDAT.
         os9   I$Open   		open device on command line
         bcs   Exit			branch if error
         inca  				A = 1
         os9   I$Close  		close stdout
         inca  				A = 2
         os9   I$Close  		close stderr
         clra  				stdin path
         os9   I$Dup    		dup to stdout
         bcs   Exit			branch if error
         os9   I$Dup    		dup to stderr
         bcs   Exit			branch if error
L0052    clra  				stdin
         leax  inbuff			point to buffer
         ldy   #$0001			read 1 byte
         os9   I$ReadLn 		read line
         bcs   L0024			branch if error
         lda   #Objct			object
         clrb  				no additional mem
         leax  <Login,pcr		point to login
         leau  <LoginPrm,pcr		and to parameters
         ldy   #$0000			parameter size
         os9   F$Fork   		fork program
         bcs   L0024			branch if error
         sta   childid			else save process ID of child
L0072    os9   F$Wait   		wait for it to finish
         cmpa  childid			same as PID we forked?
         bne   L0072			if not, wait more
         bra   L0024			else go back
Exit     os9   F$Exit   		exit

         endsect
