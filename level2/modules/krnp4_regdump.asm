********************************************************************
* OS9p4 - User Register Dump System Call for OS9 Level Two
*
* $Id$
*
* Copyright February,1989 by Ron Lammardo
*
* This system call can be used in an application program to dump the
* current contents of all user registers in Hex,Decimal,Binary and Ascii 
* (Registers "A" and "B" Only). This module MUST be present in the
* bootfile. If no OS9P3 module is found,change the "mname" and "nextname"
* as appropriate.
*
* If there is a conflict with the code used for this system called, it can
* be changed by resetting the equate at "F$RegDmp"
*
* NOTE: All registers EXCEPT 'CC' are preserved....OS9 internally resets
*       the condition code register upon service call exit.
*
* Ed.    Comments                                       Who YY/MM/DD
* ------------------------------------------------------------------
*   1    Started                                        RL  89/02/??

         nam   os9p4 
         ttl   User Register Dump System Call for OS9 Level Two

         ifp1  
         use   defsfile
         endc  

tylg     set   systm+objct
atrv     set   reent+revision
revision set   0
edition  set   1

         mod   eom,name,tylg,atrv,start,0

name     fcs   /OS9p4/    name of this module
         fcb   edition

svctabl  fcb   F$RegDmp   F$RegDmp code
         fdb   regdmp-*-2 offset to actual code
         fcb   $80        end of table

start    leay  <svctabl,pcr point to service table
         os9   F$SSvc     insert the new op code in the table
         lda   #tylg      get next module type (same as this one!)
         leax  <nextname,pcr get address of next module name
         os9   F$Link     attempt to link to it
         bcs   endsetup   no good...skip this
         jsr   ,y         else go execute it
endsetup rts              return back to previous module

nextname fcc   /OS9P5/    next module name to link to
         fcb   $0d

regdmp   equ   *
         IFNE  H6309
         pshs  cc,a,b,e,f,dp,x,y,u save all registers
         ELSE
         pshs  cc,a,b,dp,x,y,u save all registers
         ENDC
         tfr   u,y        transfer addresses
         leas  -60,s      back up for some variable storage
         leau  4,s        buffer starts here
         clr   ,u+        set flag to print ascii char
         lda   #$20       get a space
         ldb   #50        number of chars to clear
         tfr   u,x        set register for loop

clrloop  sta   ,x+        initialize a space
         decb             decrement counter
         bne   clrloop    if more..loop back & clear another
         lbsr  reg060     send a <cr>
         leax  reg080,pcr point to start of control table
         clra             clear msb of register
         ldb   R$A,y      get register from stack
         bsr   reg000     dump register A
         ldb   R$B,y      get register from stack
         bsr   reg000     dump register B
         IFNE  H6309
         ldb   R$E,y      get register from stack
         bsr   reg000     dump register E
         ldb   R$F,y      get register from stack
         bsr   reg000     dump register F
         ENDC
         inc   -1,u       turn off ascii char print flag
         ldd   R$X,y      get register from stack
         bsr   reg000     dump register X
         ldd   R$Y,y      get register from stack
         bsr   reg000     dump regisetr Y
         ldd   R$U,y      get register from stack
         bsr   reg000     dump register U
         ldb   R$CC,y     get register from stack
         bsr   reg000     dump register CC
         ldb   R$DP,y     get register from stack
         bsr   reg000     dump register DP
         ldd   R$PC,y     get user Task Number
         bsr   reg000     dump register PC
         ldy   <D.Proc    get address of users process descriptor
         ldd   P$SP,y     get users stack address
         IFNE  H6309
         addd  #14        add on for registers which were saved
         ELSE
         addd  #12        add on for registers which were saved
         ENDC
         bsr   reg000     dump register S
         lbsr  reg060     send a <CR>
         leas  60,s       restore stack pointer
         IFNE  H6309
         puls  cc,a,b,e,f,dp,x,y,u,pc restore all registers and return
         ELSE
         puls  cc,a,b,dp,x,y,u,pc restore all registers and return
         ENDC

* Dump a register in "D"
* X = Control Table Location
* U = Output buffer Location

reg000   pshs  y          save y register
         tfr   d,y        register in y
         lda   ,x         # of bytes
         leax  3,x        point past table entry
         pshs  a,x,y,u    save registers
         ldd   -2,x       get register name
         std   ,u++       move to buffer
         ldd   #"=$       get chars
         std   ,u++       move to buffer
         ldd   3,s        get reg
         lbsr  gethex     convert to hex
         tst   0,s        1 byte ?
         bne   reg010     no...skip this
         ldd   2,u        get 2 lsb's
         std   ,u         store in msb's
         ldd   #$2020     get two blanks
         std   2,u        store in lsb's

reg010   ldd   #$2023     get a space and  "#"
         std   4,u        move in two spaces
         leau  6,u        point to start of decimal output buffer
         ldd   3,s        get register
         lbsr  getdec     convert to decimal
         tst   0,s        is it one byte
         bne   reg020     no..skip this
         ldd   2,u        else get third & fourth chars
         std   ,u         store as first two
         lda   4,u        get fifth char
         sta   2,u        store as third
         ldd   #$2020     get two spaces
         std   3,u        store as 4th & 5th chars

reg020   ldd   #$2025     get a blank & "%"
         std   5,u        move it to buffer
         leau  7,u        point to start of binary output area
         tfr   a,b        space in 'b'
         std   16,u       space out ascii char
         ldd   3,s        get register
         bsr   getbin     convert to binary
         tst   0,s        check byte count
         bne   reg040     skip if two bytes
         ldb   #8         loop counter

reg030   lda   8,u        get two chars from second 8 digits
         sta   ,u+        store in first 8 digits
         lda   #$20       get two blanks
         sta   7,u        store in second 8 digits
         decb             decrement counter
         bne   reg030     loop back if not done
         leau  -8,u       back up to beginning of binary digit output
         ldb   4,s        get lsb of register
         tst   -18,u      check if we want to print ascii char
         bne   reg040     nope..skip this
         cmpb  #$20       compare char with space
         blo   reg040     if lower..skip this
         cmpb  #'z        compare with last alpha char
         bhi   reg040     if higher..skip this
         stb   17,u       else store the char

reg040   lda   #C$CR      get a <cr>
         sta   18,u       and store it
         leax  -17,u      back up to buffer start
         bsr   reg070     send it
         clra             clear msb for next reg
         puls  b,x,y,u    restore registers
         puls  y,pc       restore y & return

reg050   fcb   $0d

reg060   leax  <reg050,pcr point to <cr>

reg070   pshs  x,y,u,a,b  save registers
         ldy   <D.Proc    get process descriptor address
         lda   P$Path+2,y get user error path number
         pshs  a          save it
         ldu   P$SP,y     get user stack address
         leau  -50,u      back off to make room
         lda   <D.SysTsk  get system task number
         ldb   P$Task,y   get users task number
         ldy   #40        chars to move
         os9   F$Move     move from system to user space
         tfr   u,x        restore buffer address
         puls  a          restore user error path number
         os9   I$WritLn   send it
         puls  x,y,u,a,b,pc restore registers & return

* Control  Table - Format is :
*      Byte count    (0=1,1=2)
*      Register name (Two chars)

reg080   fcb   0
         fcc   /a /
         fcb   0
         fcc   /b /
         IFNE  H6309
         fcb   0
         fcc   /e /
         fcb   0
         fcc   /f /
         ENDC
         fcb   1
         fcc   /x /
         fcb   1
         fcc   /y /
         fcb   1
         fcc   /u /
         fcb   0
         fcc   /cc/
         fcb   0
         fcc   /dp/
         fcb   1
         fcc   /pc/
         fcb   1
         fcc   /s /


* Convert "D" to binary digits in buffer "U"

getbin   pshs  u,b        save 'u', second byte of register
         bsr   bin010     convert first byte
         puls  a          get second byte
         bsr   bin010     convert it
         puls  u,pc       restore 'u' and return

bin010   bita  #%10000000 check bit
         bsr   bin020     print result
         bita  #%01000000
         bsr   bin020
         bita  #%00100000
         bsr   bin020
         bita  #%00010000
         bsr   bin020
         bita  #%00001000
         bsr   bin020
         bita  #%00000100
         bsr   bin020
         bita  #%00000010
         bsr   bin020
         bita  #%00000001

bin020   beq   bin030     skip this if bit was set
         ldb   #'1        else get an ascii '1'
         bra   bin040     skip next

bin030   ldb   #'0        bit not set...get an ascii '0'

bin040   stb   ,u+        store the ascii char
         rts   

* Convert "D" to 4 hex digits in buffer "U"

gethex   pshs  u,b        save 'u',second register byte
         bsr   gth010     convert first byte
         puls  a          restore second byte
         bsr   gth010     convert it
         puls  u,pc       restore 'u' and return

gth010   pshs  a          save the byte
         lsra             shift left 4 bits to right
         lsra  
         lsra  
         lsra  
         bsr   gth020     convert to hex digit
         puls  a          restore the byte
         anda  #$0f       strip off high 4 digits

gth020   adda  #'0        make it ascii
         cmpa  #$3a       is it a letter
         blt   gth030     nope..skip this
         adda  #7         else add bias

gth030   sta   ,u+        store the ascii character
         rts              return

* Convert "D" to 5 decimal digits in buffer at "U"
getdec   pshs  x,y,u      save registers
         ldx   #10000     get decimal number for subtraction
         bsr   gtd010     get the decimal digit
         ldx   #01000
         bsr   gtd010
         ldx   #00100
         bsr   gtd010
         ldx   #00010
         bsr   gtd010
         ldx   #00001
         bsr   gtd010
         puls  x,y,u,pc   restore registers & return

gtd010   pshs  x,a        save x register & extra byte
         clr   ,s         clear counter

gtd020   cmpd  1,s        compare 'd' with 'x' on stack
         blo   gtd030     less...skip this
         subd  1,s        else subtract number on stack
         inc   ,s         increment digit counter
         bra   gtd020     and loop back

gtd030   std   1,s        save remainder of number
         ldb   ,s+        get counter
         addb  #$30       make it ascii
         stb   ,u+        and move it as output
         puls  d,pc       restore remainder & return

         emod  
eom      equ   *
         end   
