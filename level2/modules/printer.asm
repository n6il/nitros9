********************************************************************
* Printer - CoCo 3 Serial Printer Driver
*
* $Id$
*
* Enhanced and re-written by Alan DeKok
*
* Problems with original:
*   returns wrong error on Read/SetStt
*   doesn't block output.  The printer is a single-user device!
*
* Ed.    Comments                                       Who YY/MM/DD
* ------------------------------------------------------------------
*        NitrOS-9 2.00 distribution                         ??/??/??
*  13    Back-ported to OS-9 Level Two                  BGP 03/01/05

         nam   Printer
         ttl   CoCo 3 Serial Printer Driver

         ifp1
         use   defsfile
         endc

tylg     set   Drivr+Objct   
atrv     set   ReEnt+Rev
rev      set   $01
edition  set   13

         mod   eom,name,tylg,atrv,Start,Size

         fcb   READ.+WRITE.

name     fcs   /PRINTER/
         fcb   edition    one more revision level than the stock printer

* Device memory area: offset from U
         org   V.SCF      V.SCF: free memory for driver to use
V.PAR    rmb   1          1=space, 2=mark parity
V.BIT    rmb   1          0=7, 1=8 bits
V.STP    rmb   1          0=1 stop bit, 1=2 stop bits
V.COM    rmb   2          Com Status baud/parity (=Y from SS.Comst Set/GetStt
V.COL    rmb   1          columns
V.ROW    rmb   1          rows
V.WAIT   rmb   2          wait count for baud rate?
V.TRY    rmb   2          number of re-tries if printer is busy
V.RTRY   rmb   1          low nibble of parity=high byte of number of retries
V.BUFF   rmb   $80        room for 128 blocked processes
size     equ   .

* Baud Rate Delay Table
BaudDly  equ   *
         IFEQ  NitrOS9
* OS-9 Level Two delay values (1.89MHz)
         fdb   $090C    110 baud
         fdb   $034C    300 baud
         fdb   $01A2    600 baud
         fdb   $00CE    1200 baud
         fdb   $0062    2400 baud
         fdb   $002E    4800 baud
         fdb   $0012    9600 baud
         fdb   $0003    32000 baud
         ELSE   
* NitrOS-9 Level Two delay values (1.89MHz)
         fdb   $090C    110 baud (Unchanged, unknown)
         fdb   $03D0    300 baud
         fdb   $01A2    600 baud (Unchanged, unknown)
         fdb   $00F0    1200 baud
         fdb   $0073    2400 baud
         fdb   $0036    4800 baud
         fdb   $0017    9600 baud
         fdb   $0003    32000 baud (Unchanged, unknown)
         ENDC


start    equ   *
         lbra  Init
         lbra  Read
         lbra  Write
         lbra  GetStt
         lbra  SetStt
Term     equ   *
         clrb
         rts

Init     orcc  #IntMasks
         ldx   #$FF20
         clr   $01,X
         ldd   <$2C,Y     get number of columns/rows
         std   <V.COL,U
         lda   #$FE
         sta   ,X
         lda   #$36
         sta   $01,X
         lda   ,X
         andcc #^IntMasks
         ldd   <$26,Y     parity and baud rate
         lbsr  L0138      setup parity/baud in device memory
         lbsr  L0104      get low bit of $FF22 into carry
         lbcs  L0100      it's the ready flag
* clear out buffer
         leax  V.BUFF,u   room for 128 blocked processes
         ldb   #$80
I010     clr   ,x+        we're more concerned with room
         decb             than with speed, so we don't use TFM
         bne   I010
         rts

L005F    ldb   <PD.BAU,Y     PD.BAU
         andb  #$0F		keep lower nibble
         cmpb  #$07       get baud rate
         lbhs  Read
         aslb  
         leax  <BaudDly,PCR table of delay times
         ldx   b,X
         stx   <V.WAIT,U
         clrb  
         rts

Bit_2    ldb   #$02
L007D    stb   >$FF20
L0080    pshs  d
         ldd   <V.WAIT,U get wait count for baud rate
L0085    equ   *
         IFNE  H6309
         decd             count down by one
         ELSE
         subd  #$0001
         ENDC
         bne   L0085
         puls  pc,d

Write    equ   *
         leax  V.BUFF,u   point to the buffer
         ldb   V.BUSY,u   get my process number
         tst   ,x         get allowed process number
         bne   W010       if not zero, else
         stb   ,x         I'm the only one allowed to use it

W010     cmpb  ,x         am I allowed to use /p?
         beq   W030       if yes, go write a character

***************************************************************
* WARNING: If more than 128 processes try to use the printer,
* this will CRASH BADLY.  Since Level II on the Coco is limited
* to 32 processes, I don't think it's a problem.
***************************************************************

W020     tst   ,x+        if not, find the first non-zero entry
         bne   W020
         stb   -1,x       and save my process number at the first zero
         pshs  a
         lda   V.BUFF,u   process that's allowed to use /p
         sta   V.BUSY,u   make it the busy one
         ldb   #$01       wake it up
         os9   F$Send     send a signal to wake it
         IFNE  H6309
         tfr   0,x
         ELSE
         ldx   #$0000
         ENDC
         os9   F$Sleep    and go to sleep forever
         puls  a          restore character to be sent, and continue

W030     bsr   L005F      set up baud rate, etc in memory
         bcs   L00CA
         pshs  a
         bsr   L00CB      make sure that the device is ready
         puls  a
         bcs   L00CA      if the device is not ready
         IFNE  H6309
         lde   #$09       9 bits to send out
         ELSE
         pshs b,a
         lda  #$09
         sta  1,s
         puls a
         ENDC
         orcc  #IntMasks  turn off interrupts
         tst   <V.BIT,U   number of bits
         beq   L00AC      if 7 bits, count down by one
         IFNE  H6309
         dece             initially send out start bit
         ELSE
         dec   ,s
         ENDC

L00AC    bsr   L007D      write B to $FF20 and wait
         clrb
         lsra             move A into carry
         rolb
         rolb
         IFNE  H6309
         dece             count down on the number of bits to send
         ELSE
         dec   ,s
         ENDC
         bne   L00AC
         IFEQ  H6309
         puls  b
         ENDC
         ldb   <V.PAR,U   space/mark parity
         beq   L00BC      0=no parity
         andb  #$FE       1=space, 0=mark parity
* should be andb #$FD I think...
         bsr   L007D      dump out a parity byte
L00BC    bsr   Bit_2      and a stop bit
         tst   <V.STP,U   do another one?
         beq   L00C9
         bsr   Bit_2      yes, dump out another stop byte
L00C9    andcc #^IntMasks
L00CA    rts

L0104    pshs  b
         ldb   >$FF22     get a byte
         lsrb  
         puls  pc,b

L00CB    equ   *
         IFNE  H6309
         clrd
         ELSE
         clra
         clrb
         ENDC
         std   <V.TRY,U
L00D0    ldd   #$0303
L00D3    bsr   L0104      get device ready status
         bcs   L00DE      if not ready, wait for a bit
         IFNE  H6309
         bsr   L0080      wait
         ELSE
         lbsr  L0080      wait
         ENDC
         decb  
         bne   L00D3      try again
         clrb  
         rts   

L00DE    lbsr  L0080      wait for a while
         deca             try 3 times,
         bne   L00D3
         pshs  x
         ldx   #$0001
         os9   F$Sleep    sleep for the rest of this tick
         puls  x
         ldd   <V.TRY,U
         IFNE  H6309
         incd             we've tried once more and failed...
         ELSE
         addd  #$0001
         ENDC
         std   <V.TRY,U
         ldb   <V.RTRY,U  number of retries to do
         beq   L00D0      if unspecified, keep retrying
         cmpb  <V.TRY,U   if exceeded number of retries,
         bhi   L00D0      then we crap out

L0100    comb  
         ldb   #E$NotRdy
         rts   

GetStt   cmpa  #SS.EOF    end of file?
         bne   L0112
         clrb             if so, exit with no error
         rts   

L0112    ldx   PD.RGS,Y
         cmpa  #SS.ScSiz
         beq   L0123
         cmpa  #SS.ComSt
         bne   L0173
         ldd   <V.COM,U     get Com status
         std   R$Y,X
         clrb
         rts

* get screen size GetStt
L0123    clra  
         ldb   <V.COL,U
         std   R$X,X
         ldb   <V.ROW,U
         std   R$Y,X
         clrb
         rts

SetStt   cmpa  #SS.ComSt
         bne   Close      if not, check if it's a close
         ldx   PD.RGS,Y
         ldd   R$Y,X
* A = Parity byte
* B = baud rate
L0138    std   <V.COM,U     save parity, baud rate in com status
         IFNE  H6309
         clrd
         ELSE
         clra
         clrb
         ENDC
         std   <V.PAR,U
         sta   <V.STP,U
         ldd   <V.COM,U
         tstb
         bpl   L014C
         inc   <V.STP,U  do 2 stop bits
L014C    bitb  #$40       make sure the bit is zero
         bne   Read
         bitb  #$20       0=8, 1=7 bits
         beq   L0157
         inc   <V.BIT,U
L0157    bita  #$20
         beq   L0169      if=0, no parity
         bita  #$80
         beq   Read       if high bit set (only for ACIA devices), error out
         inc   <V.PAR,U     parity
         bita  #$40
         bne   L0169      1=space,
         inc   <V.PAR,U  2=mark parity
L0169    anda  #$0F
         sta   <V.RTRY,U
         rts   

Read     comb  
         ldb   #E$BMode
         rts

L0173    comb
         ldb   #E$UnkSVc
         rts

Close    cmpa  #SS.Close  close the device?
         bne   L0173
         leax  V.BUFF,u   point to blocked process buffer

C010     lda   1,x        get next process number
         sta   ,x+
         bne   C010       do until we have a zero byte

         lda   V.BUFF,u   get the first process in the queue
         beq   C020       if none left
         ldb   #$01       wake up signal
         os9   F$Send     re-start the blocked process

C020     clrb
         rts

         emod
eom      equ   *
         end
