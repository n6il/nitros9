********************************************************************
* PipeMan - OS-9 Level Two Pipe File Manager
*
* $Id$
*
*
* 'show grf.3.a | eat'  (eat is cat, but just does a I$ReadLn, and not I$WritLn)
* April 10, 1996  14:05:15
* April 10, 1996  14:07:47
*          15.2 seconds per iteration
*          i.e. everything but the screen writes
* 
* fast SCF+fast pipe
* 'show grf.3.a | cat', 10 times
* April 10, 1996  13:17:54
* April 10, 1996  13:21:57
*          24.3 seconds per iteration
*          9.1 solely for pipes
* 
* fast SCF+old slow pipe
* April 10, 1996  13:30:24
* April 10, 1996  13:38:04
*          46.0 seconds per iteration
*          30.8 solely for pipes
* 
*          speedup percent is (30.8-9.1)/30.8 = 70%
* 
*          Pipes are more than doubled in speed!
*
* 32 byte read and write buffers
*
* Ed.    Comments                                       Who YY/MM/DD
* ------------------------------------------------------------------
*   4    Enhanced and re-written                        ADK ??/??/??

         nam   PipeMan
         ttl   OS-9 Level Two Pipe File Manager

         ifp1
         use   defsfile
         endc

tylg     set   FlMgr+Objct   
atrv     set   ReEnt+Rev
rev      set   $03
edition  set   4

         mod   eom,name,tylg,atrv,start,size

         rmb   $0000
SIZE     equ   .

         org   PD.FST
PD.READ  rmb   4
PD.WRITE rmb   4
PD.END   rmb   2          end of the buffer
PD.WPTR  rmb   2          write pointer
PD.RPTR  rmb   2          read pointer
PD.BLOCK rmb   1          0=block reads, 1=OK to read block flag

         org   $0000
P.CPR    rmb   1          process ID
P.CNT    rmb   1          count
P.SIG    rmb   1          signal code
P.FLAG   rmb   1          raw/edit flag

name     fcs   /PipeMan/
         fcb   edition

start    lbra  Create
         lbra  Open
         lbra  MakDir
         lbra  ChgDir
         lbra  Delete
Seek     clrb
         rts
         nop
         lbra  Read
         lbra  Write
         lbra  ReadLn
         lbra  WritLn
GetStt   clrb
         rts
         nop
SetStt   clrb
         rts
         nop
Close    lda   PD.CNT,y
         bne   L008E
         LDU   PD.BUF,y   if no one's using it,
         clrb
         inca
         os9   F$SRtMem   return the memory
         clrb
         rts

L008E    leax  PD.READ,y
         cmpa  PD.READ+P.CNT,y is the read count zero?
         Beq   L009C

         cmpa  PD.WRITE+P.CNT,y is the write count zero?
         bne   L00A9
         leax  PD.WRITE,y

L009C    lda   P.CPR,x    get process ID that's reading/writing
         beq   L00A9      if none
         ldb   P.SIG,x    get signal code
         beq   L00A9
         clr   P.SIG,x
         os9   F$Send     send a wake-up signal to the process
L00A9    clrb  
         rts   

MakDir   equ   *
ChgDir   equ   *
Delete   equ   *
         comb  
         ldb   #E$UnkSVC
         rts   

Create   equ   *
Open     equ   *
         ldx   R$X,u        get address of filename to open
         pshs  y            save PD pointer
         os9   F$PrsNam   parse /pipe
         bcs   L007B        exit on error
         ldx   <D.Proc      current process ptr
         ldb   P$Task,x     get task number for call, below
         leax  -$01,y       back up one character
         os9   F$LDABX    get last character of the filename
         tsta               check the character
         bmi   L0060      if high bit set, it's OK
         leax  ,y           point to next bit
         os9   F$PrsNam   else parse name
         bcc   L007B      if no error, it's a sub-dir, and we error out
L0060    sty   R$X,u        save new pathname ptr
         puls  y            restore PD pointer
         ldd   #$0100
         os9   F$SRqMem   request one page for the pipe
         bcs   L007A        exit on error
         stu   PD.BUF,Y     save ptr to the buffer
         stu   <PD.WPTR,Y save write pointer
         stu   <PD.RPTR,Y and read pointer
         leau  d,u          point to the end of the buffer
         stu   <PD.END,Y    save save the ptr
L007A    rts   

L007B    comb  
         ldb   #E$BPNam   bad path name
         puls  pc,y

ReadLn   ldb   #$0D
         fcb   $21	skip one byte

Read     clrb
         stb   PD.READ+P.FLAG,Y  raw read
         leax  PD.READ,Y
         lbsr  L0160      send wakeup signals to process
         bcs   L0100      on error, wake up writing process
         ldx   R$Y,U
         beq   L0100      if no bytes to rwad
         ldd   R$X,U      start address to read from
         leax  d,x        add in number of bytes: end address

* NOTE: PD.RGS,Y will change as the processes read/write the pipe,
* and sleep.
         pshs  u            save current caller's register stack
         leas  -32,s        reserve a 32-byte buffer on the stack
         leau  ,s           point to the start of the buffer
         pshs  d,x        save start, end to read

         clrb               no bytes read to user yet
         puls  x            restore number of data bytes read, read address
L00DB    bsr   L01F2        are we blocked?
         bcs   L00C8        yes, send a signal
         sta   b,u          store the byte in the internal read buffer
         leax  $01,X        go up by one byte
         incb               one more byte in the buffer
         cmpb  #32          reached maximum size of the buffer?
         blo   L00E0        no, continue
         bsr   read.out     read 32 bytes of data to the caller

L00E0    tst   PD.READ+P.FLAG,Y  was it a raw read?
         beq   L00ED      skip ahead if raw
         cmpa  #C$CR      was the character a CR?
         beq   L00F1      yes, we're done: flush and exit
L00ED    cmpx  ,S         or at end of data to read?
         blo   L00DB        no, keep reading

L00F1    bsr   read.out     flush the rest of the pipe buffer to the user
L00F2    tfr   X,D        this is how far we got
         subd  ,S++       take out start of buffer
         leas  32,s         kill our on-stack buffer
         puls  u            restore caller's register stack ptr: NOT PD.RGS,Y
         addd  R$Y,U      add in number of bytes
         std   R$Y,U      save bytes read
         bne   L00FF      if not zero
         ldb   #E$EOF     zero bytes read:EOF error
         fcb   $21          skip one byte

L00FF    clrb               no errors
L0100    leax  PD.READ,Y    read data ptr
         lbra  L01BD      signal other it's OK to go ahead

read.out pshs  a,x,y,u      save registers
         tstb               any data to write?
         beq   read.ex      no, skip ahead
         clra               make 16-bit data length
         tfr   d,y          number of data bytes to read to user
         negb               make it negative
         leax  b,x          back up TO pointer
         pshs  x            save it
         leax  ,u           point to the start of the buffer
         ldu   <D.Proc      current process pointer
         ldb   P$Task,u     A=$00 from above, already
         puls  u            restore TO pointer

         os9   F$Move       move the data over
         clrb               no bytes read to the caller yet
read.ex  puls  a,x,y,u,pc   restore registers and exit

L00C8    pshs  x            save read pointer
         bsr   read.out     dump data out to the user
         pshs  b            save number of bytes read
         leax  PD.READ,Y    read data area ptr
         lbsr  L018B      setup for signal
         puls  x,b          restore registers: note B=$00, but we CANNOT do a
         bcc   L00DB        clrb, because this line needs CC.C!
         bra   L00F2        don't write data out again, but exit

* Check if we're blocked
L01F2    lda   <PD.BLOCK,Y  we blocked?
         bne   L01F9        no, skip ahead
         coma               set flag: blocked
         rts                and return to the caller

L01F9    pshs  x            save read ptr
         ldx   <PD.RPTR,Y   where to read from in the buffer
         lda   ,X+        get a byte
         cmpx  <PD.END,Y  at the end of the buffer?
         blo   L0207        no, skip ahesd
         ldx   PD.BUF,Y   yes, go to start
L0207    stx   <PD.RPTR,Y   save new read ptr
         cmpx  <PD.WPTR,Y caught up to the write pointer yet?
         bne   L0212        no, skeip ahead
         clr   <PD.BLOCK,Y yes, set read is blocked
L0212    andcc #^Carry      no errors
         puls  pc,x         restore regs and exit

L0160    lda   P.CPR,X      get current process
         beq   L0185        none, exit
         cmpa  PD.CPR,Y   current process ID
         beq   L0189        none, exit
         inc   P.CNT,X    one more process using this pipe
         ldb   P.CNT,X
         cmpb  PD.CNT,Y   same as the number for this path?
         bne   L0173        no, skip ahead
         lbsr  L009C      no, send a wake-up signal
L0173    os9   F$IOQu     and insert it in the others IO queue
         dec   P.CNT,X    decrement count
         pshs  x
         ldx   <D.Proc      current process ptr
         ldb   <P$Signal,X  signal code
         puls  x
         beq   L0160      if no signal code sent, do another process
         coma               otherwise return CC.C set, and B=signal code
         rts   

L0185    ldb   PD.CPR,Y     grab current PD process
         stb   P.CPR,X      save as current reading/writing process
L0189    clrb               no errors
         rts                and exit

L01CC    pshs  b,x          save regs
         ldx   <PD.WPTR,Y
         ldb   <PD.BLOCK,Y 0=READ, 1=WRITE
         beq   L01DE      was reading, set to write and continue
         cmpx  <PD.RPTR,Y caught up to the read pointer yet?
         bne   L01E3
         comb  
         puls  pc,x,b

L01DE    inc   <PD.BLOCK,Y set to writing into the pipe
L01E3    sta   ,X+        save the byte
         cmpx  <PD.END,Y  if at the end of the buffer
         blo   L01EC
         ldx   PD.BUF,Y   reset to the beginning
L01EC    stx   <PD.WPTR,Y
         clrb  
         puls  pc,x,b

write.in pshs  a,x,y        save registers
         leau  -32,u      point to the start of the buffer again
         ldx   <D.Proc      current process pointer
         lda   P$Task,x   get FROM task number for this process
         ldx   1,s        get FROM pointer
         ldy   #32        16 bytes to grab
         clrb             TO the system task
         os9   F$Move
         ldb   #32        16 bytes in the buffer
         puls  a,x,y,pc

WritLn   ldb   #$0D
         fcb   $21        skip one byte

Write    clrb
         stb   <PD.WRITE+P.FLAG,Y
         leax  PD.WRITE,Y
         bsr   L0160      make sure it's OK
         bcs   L015C
         ldx   R$Y,U      get number of bytes to write
         beq   L015C
         ldd   R$X,U      start address
         leax  d,x        add in number of bytes
         pshs  u
         leau  ,s           point to the end of the buffer
         leas  -32,s
         pshs  d,x        save start, end

         ldx   ,s           get initial start pointer
         bsr   write.in     fill the write buffer

         puls  x
L0137    lda   ,u
         bsr   L01CC      save it in the buffer
         bcs   L0124      caught up to reading process yet?
         leax  $01,X      up by one byte
         leau  1,u
         decb
         bne   L0138
         bsr   write.in     fill the buffer again

L0138    tst   <PD.WRITE+P.FLAG,Y
         beq   L014B
         cmpa  #C$CR      at the end of a line to output?
         beq   L014F
L014B    cmpx  ,S         at end yet?
         blo   L0137      if not, read more data
L014F    clrb             clear carry and error
L0150    ldu   2+32,s       skip END, 32-byte write buffer, get U
         pshs  b,cc
         tfr   X,D
         subd  $02,S      take out end address
         addd  R$Y,U      add in number of bytes
         std   R$Y,U      save bytes written
         puls  x,b,cc
         leas  32,s         kill write buffer
         puls  u

L015C    leax  PD.WRITE,Y
* can probably lose saving 'U' in next few lines... but only minor difference
* Signal read/write it's OK to go ahead
L01BD    pshs  u,b,cc
         clr   P.CPR,X    NO process currently using this device
         bsr   Other      signal other process to start
         puls  pc,u,b,cc

L0124    pshs  x,b
         leax  PD.WRITE,Y
         bsr   L018B      send signal to other
         tfr   b,a          save error code, if applicable
         puls  x,b          restore pointer, byte count
         bcc   L0137        continue if OK
         tfr   a,b          otherwise restore error code
         bra   L0150        exit, returning the error code to the user

L018B    ldb   P.CNT,X
         incb  
         cmpb  PD.CNT,Y
         beq   L01B9
         stb   P.CNT,X
         ldb   #$01
         stb   P.SIG,X
         clr   PD.CPR,Y
         pshs  x
         bsr   Other
         ldx   #$0000       make X=0
         os9   F$Sleep    sleep forever
         ldx   <D.Proc
         ldb   <P$Signal,X  get signal code
         puls  x
         dec   P.CNT,X
         tstb  
         bne   L01BB      if a signal, we can't wake up
         clrb             the writing process
         rts   

L01B9    ldb   #E$Write   write error
L01BB    coma  
         rts   

Other    exg   X,D
         eorb  #$04       if r/w go to w/r
         exg   D,X
         lbra  L009C

         emod
eom      equ   *
         end
