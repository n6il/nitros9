********************************************************************
* TSMon - Time sharing monitor
*
* $Id$
*
* Ed.    Comments                                       Who YY/MM/DD
* ------------------------------------------------------------------
* 8      Original Tandy distribution version

         nam   Tsmon
         ttl   Time sharing monitor

* Disassembled 98/09/14 23:52:10 by Disasm v1.6 (C) 1988 by RML

         ifp1  
         use   defsfile
         endc  

tylg     set   Prgrm+Objct
atrv     set   ReEnt+rev
rev      set   $01
edition  set   8

         mod   eom,name,tylg,atrv,start,size

ChildPID rmb   1
DevName  rmb   2
ParmArea rmb   2
u0005    rmb   451
size     equ   .

name     fcs   /Tsmon/
         fcb   edition

Login    fcc   "LOGIN"
Param    fcb   C$CR

* Intercept routine
IcptRtn  rti   

start    stx   <DevName   store pointer to device name
         std   <ParmArea  save parameter area size
         leax  <IcptRtn,pcr
         os9   F$Icpt     install interrupt svc rtn
L0024    ldx   <DevName   get device name pointer
         ldd   <ParmArea  get parameter area size
         cmpd  #$0002     size is 2?
         bcs   L0052      if less than, just use stdin
         lda   ,x         else get char at X
         cmpa  #C$CR      carriage return?
         beq   L0052      yep, just use stdin
         clra             else set A to 0
         os9   I$Close    close stdin
         lda   #READ.!WRITE.
         os9   I$Open     open path to device (path 0 is used)
         bcs   Error      branch if error
         inca             A = 1 (stdout)
         os9   I$Close    close stdout path
         inca             A = 2 (stderr)
         os9   I$Close    close stderr path
         clra             A = 0 (stdin)
         os9   I$Dup      duplicate to standard out
         bcs   Error      branch if error
         os9   I$Dup      duplicate to standard error
         bcs   Error      branch if error
L0052    clra             A = 0 (stdin)
         leax  u0005,u    X = buffer
         ldy   #$0001     character count
         os9   I$ReadLn   read
         bcs   L0024
         lda   #Objct
         clrb             size of data area
         leax  <Login,pcr point to Login name
         leau  <Param,pcr and parameter area
         ldy   #$0000     size of parameter area
         os9   F$Fork     fork it!
         bcs   L0024      branch if error
         sta   <ChildPID  save PID of Login process
L0072    os9   F$Wait     wait for it to die
         cmpa  <ChildPID  A = PID of dead process.. same as our child?
         bne   L0072      if not, continue waiting
         bra   L0024      else restart procedure
Error    os9   F$Exit

         emod  
eom      equ   *
         end   
