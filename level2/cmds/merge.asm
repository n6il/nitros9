********************************************************************
* Merge - Merge files into one file
*
* $Id$
*
* Ed.    Comments                                       Who YY/MM/DD
* ------------------------------------------------------------------
* 4      Added in '-z' option, which reads filenames to ADK 94/12/11
*        merge from STDIN

         nam   Merge
         ttl   Merge files into one file

         ifp1
         use   defsfile
         endc

tylg     set   Prgrm+Objct   
atrv     set   ReEnt+rev
rev      set   $01
edition  set   4

         mod   eom,name,tylg,atrv,start,size

path     rmb   1
param    rmb   2
d.ptr    rmb   2
d.size   rmb   2
d.buffer rmb   2496       should reserve 7k, leaving some room for parameters
size     equ   .

name     fcs   /Merge/
         fcb   edition    change to 6, as merge 5 has problems?

start    pshs  u          save start address of memory
         stx   <param     and parameter area start
         tfr   x,d
         subd  #$0107     take out 1 bytes in DP, and 1 page for the stack
         subd  ,s++       take out start address of data area
         std   <d.size    save size of data buffer
         leau  d.buffer,u point to some data
         stu   <d.ptr     save another pointer

do.file  ldx   <param     get first filename
space    lda   ,x+        grab a character
         cmpa  #C$SPAC    space?
         beq   space      yes, skip it
         leax  -1,x       otherwise point to last non-space

         clrb  
         cmpa  #C$CR      was the character a CR?
         beq   Exit       yes, exit

         lda   #READ.
         os9   I$Open     open the file for reading
         bcs   Exit       crap out if error
         sta   <path      save path number
         stx   <param     and save new address of parameter area

read.lp  lda   <path      get the current path number
         ldy   <d.size    and size of data to read
         ldx   <d.ptr     and pointer to data buffer
         os9   I$Read     read data into the buffer
         bcs   chk.err    check errors

         lda   #$01       to STDOUT
         os9   I$Write    dump it out in one shot
         bcc   read.lp    loop if no errors
         bra   Exit       otherwise exit ungracefully

chk.err  cmpb  #E$EOF     end of the file?
         bne   Error      no, error out
         lda   <path      otherwise get the current path number
         os9   I$Close    close it
         bcc   do.file    if no error, go get next filename

Error    coma             set carry
Exit     os9   F$Exit     and exit

         emod
eom      equ   *
         end

