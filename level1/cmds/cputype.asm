********************************************************************
* CPUType - Identify 6809 or 6309
*
* $Id$
*
* Ed.    Comments                                       Who YY/MM/DD
* ------------------------------------------------------------------
*   1    Started                                        ADK ??/??/??

         nam   CPUType
         ttl   Identify 6809 or 6309

         ifp1
         use   defsfile
         endc

tylg     set   Prgrm+Objct
atrv     set   Reent+Rev
rev      set   1
edition  set   1

         org   0
         rmb   $0100      for the stack
size     equ   .

         mod   eom,name,tylg,atrv,start,size

name     fcs   /CPUType/
         fcb   edition

Start    ldd   #$FFFF     make sure it's non-zero
*         clrd             executes as a pseudo-NOP ($10), and a CLRA
         fdb   $104F
         tstb
         bne   is.6809
         leax  c.6309,pc
         bra   save.1

c.6309   fcc   /CPU: 6309, /
c.6809   fcc   /CPU: 6809, /

is.6809  leax  c.6809,pc
save.1   ldy   #11
         lda   #1         to STDOUT
         OS9   I$Write    dump it out

* if it's a 6809, we don't need to do the next part, as we KNOW it's
* running in 6809 emulation mode!

* this is harder.... are we in native mode?
         pshs  cc,dp,x,y,u   save all registers but D
*         pshsw            a NOP on a 6809
         fdb   $1038

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
*         tfr   u,w        a PULSW is an RTS on a 6809
         fdb   $1F36
         puls  cc,dp,x,y,u  restore all of our other registers

         leax  m.6809,pc  default to 6809
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

