********************************************************************
* CPUType - Identify 6809 or 6309
*
* $Id$
*
* Ed.    Comments                                       Who YY/MM/DD
* ------------------------------------------------------------------
*   1    Started                                        ADK ??/??/??
*   2    Fixed a crash bug on 6809, now just reports    BGP 03/04/02
*        6809 message on a 6809

         nam   CPUType
         ttl   Identify 6809 or 6309

         ifp1
         use   defsfile
         endc

tylg     set   Prgrm+Objct
atrv     set   Reent+Rev
rev      set   0
edition  set   2

         org   0
         rmb   $0100      for the stack
size     equ   .

         mod   eom,name,tylg,atrv,start,size

name     fcs   /CPUType/
         fcb   edition

c.6309   fcc   /CPU: 6309, /
L6309    equ   *-c.6309
c.6809   fcc   /CPU: 6809/
         fcb   C$CR
L6809    equ   *-c.6809

is.6809  leax  c.6809,pc
         ldy   #L6809
         lda   #1
         os9   I$WritLn
         os9   F$Exit

* Entry of program
* First, let's determine if we have a 6309 or 6809
Start    ldd   #$FFFF	make sure D is non-zero
         fdb   $104F	(CLRD) execs as pseudo-NOP ($10), and CLRA on 6809
         tstb
         bne   is.6809
         leax  c.6309,pc
save.1   ldy   #L6309
         lda   #1	to STDOUT
         OS9   I$Write	dump it out

* This code is executed only if we have a 6309
* Determine if we are in native mode or not
         pshs  cc,dp,x,y,u   save all registers but D
         fdb   $1038	(PSHSW)
         leay  native,pc   native mode PC
         leax  emulate,pc  emulation mode PC
         pshs  x,y         save them
         pshs  cc,d,dp,x,y,u  and the rest of the registers, too.
         orcc  #Entire     set the entire bit in CC
         rti

emulate  leas  2,s        emulation mode: kill native mode PC
         clrb             we're in emulation mode
         fcb   $8C        skip 2 bytes
native   ldb   #1         in native mode
         puls  u          restore W
         fdb   $1F36	(TFR U,W)
         puls  cc,dp,x,y,u  restore all of our other registers

emumsg   leax  m.6809,pc  default to 6809
         tstb             are we in native mode?
         beq   print      no
         leax  m.6309,pc  get the 6309 message

print    ldy   #$0100     a lot
         lda   #1         to STDOUT
         OS9   I$WritLn
         clrb             no errors
         OS9   F$Exit

m.6809   fcc   /running in 6809 mode./
         fcb   C$CR

m.6309   fcc   /running in 6309 native mode./
         fcb   C$CR

         emod
eom      equ   *
         end

