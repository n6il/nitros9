********************************************************************
* PipeMan - Pipe file manager
*
* $Id$
*
* Ed.    Comments                                       Who YY/MM/DD
* ------------------------------------------------------------------
* 4      Original OS-9 L2 Tandy distribution
*        Added comments from Curtis Boyle's code        BGP 98/10/22

         nam   PipeMan
         ttl   Pipe file manager

         ifp1  
         use   defsfile
         use   pipedefs
         endc  

rev      set   $01
edition  set   4

         mod   eom,Name,FlMgr+Objct,ReEnt+rev,Start,0

Name     fcs   /PipeMan/
         fcb   edition

Start    lbra  Create     Create, same as open
         lbra  Open       Open
         lbra  UnkSvc     MakDir
         lbra  UnkSvc     ChgDir
         lbra  UnkSvc     Delete
         lbra  L0040      Seek
         lbra  PRead      PRead
         lbra  PWrite     PWrite
         lbra  L00AB      PRdLn
         lbra  L0105      PWrLn
         lbra  L0040      GetStat
         lbra  L0040      SetStat
         lbra  Close      Return to system

UnkSvc   comb             Exit with Unknown Service error
         ldb   #E$UnkSvc
         rts   

L0040    clrb             No error & return
         rts   

* Open or create a Pipe
Create         
Open     ldu   PD.RGS,y   get Caller's register stack ptr
         ldx   R$X,u      get pointer to pathname
         pshs  y          preserve descriptor pointer
         os9   F$PrsNam   is it legal?
         bcs   L007B      no, exit with error
         ldx   <D.Proc    get task #
         ldb   P$Task,x
         leax  -1,y       point to last character of pathname
         os9   F$LDABX    get it
         tsta             high bit terminated?
         bmi   L0060      yes, go on
         leax  ,y         point just past it
         os9   F$PrsNam   parse it again
         bcc   L007B      can't accept more data, return error
L0060    sty   R$X,u      save updated path pointer to caller
         puls  y          restore path dsc. ptr
         ldd   #256       grab a page of memory for my buffer
         os9   F$SRqMem
         bcs   L007A      can't get memory, return error
         stu   PD.BUF,y   save pointer to buffer
         stu   <PD.NxtI,y save read pointer?
         stu   <PD.NxtO,y save write pointer?
         leau  d,u        point to end of buffer
         stu   <PD.End,y  save the end pointer
L007A    rts              return
L007B    comb             Exit with Bad Pathname error
         ldb   #E$BPNam
         puls  y,pc

* Close
Close    lda   PD.CNT,y   any open images left?
         bne   L008E      yes, go on
         ldu   PD.BUF,y   No, get buffer pointer
         ldd   #256       return it's memory to system
         os9   F$SRtMem
         bra   L00A9
* Still stuff open to pipe
* Check Read part of pipe
L008E    cmpa  PD.RCT,y   Same as # images open to Read from pipe?
         bne   L0096      No, go check Write images
         leax  PD.RPID,y  Point to Read variables
         bra   L009C      Send signal to reading process
* Check Write part of pipe
L0096    cmpa  PD.WCT,y   Same as # images open to Write to pipe?
         bne   L00A9      No, exit without error
         leax  PD.WPID,y  Point to Write variables

* Send signal
L009C    lda   ,x         Get Process # to send signal to
         beq   L00A9      None, exit without error
         ldb   2,x        get the signal code to send
         beq   L00A9      None, exit without error
         clr   2,x        Clear out signal code
         os9   F$Send     Send to process
L00A9    clrb             No error & exit
         rts   

* ReadLn entry point
* Entry: Y=Path dsc. ptr
L00AB    ldb   #$0D       Flag for ReadLn
         stb   PD.REOR,y  Save as Not raw flag in Read area
         bra   L00B3      Go read

* Read entry point
PRead    clr   PD.REOR,y  Raw mode on
L00B3    leax  PD.RPID,y  point to Pipe Read variables
         lbsr  L0160      Go wait for pipe to be ready for us
         bcs   L0100      Error, shut off our side & signal other end of pipe
         ldd   R$Y,u      get # bytes requested to read
         beq   L0100      None, shut off our side & signal other end of pipe
         ldx   R$X,u      get pointer to callers destination
         addd  R$X,u
         pshs  b,a
         pshs  x          preserve start pointer
         bra   L00D5

* Read Loop for both ReadLn (stops on CR) or Read (stops when size is done)

L00C8    pshs  x          Preserve buffer start ptr
         leax  PD.RPID,y  Point to Read vars
         lbsr  L018B      Go wait for possible data
         bcc   L00D5      May be some, continue
         puls  x          Restore buffer start ptr
         bra   L00F1      None expected, exit with what we have

L00D5    ldx   <D.Proc    Get current process ptr
         ldb   P$Task,x   Get task #
         puls  x          Get Buffer start ptr

* Read from pipe buffer
L00DB    lbsr  L01F2
         bcs   L00C8
         os9   F$STABX    Got byte, save it to caller
         leax  1,x        Bump buffer ptr up
         tst   PD.REOR,y  Check Read/ReadLn flag
         beq   L00ED      Raw, skip ahead
         cmpa  PD.REOR,y  Was the byte received a CR?
         beq   L00F1      Yes, done reading
L00ED    cmpx  ,s         Hit end of buffer read requested yet?
         bcs   L00DB      No, keep reading
L00F1    tfr   x,d        Move ptr to D
         subd  ,s++       Calculate actual size read
         addd  R$Y,u      ??? Add to size previously read???
         std   R$Y,u      Save total # bytes read to caller
         bne   L00FF      If some read, skip ahead
         ldb   #E$EOF     Otherwise, exit with EOF error
         bra   L0100
L00FF    clrb             No error

L0100    leax  PD.RPID,y  Point to pipe Read vars
         lbra  L01BD

L0105    ldb   #$0D       Flag for WritLn (and terminator for lines)
         stb   <PD.WEOR,y
         bra   L010F      Go do the write

PWrite   clr   <PD.WEOR,y Flag for Raw Write
L010F    leax  PD.WPID,y  Point to Write variables
         lbsr  L0160      Go wait for pipe to be ready for us
         bcs   L015C      Error, shut off our side & signal other end of pipe
         ldd   R$Y,u      Get requested size to Write
         beq   L015C      None, shut off our side & signal other end of pipe
         ldx   R$X,u      Get ptr to data to write
         addd  R$X,u      Calculate end of data ptr
         pshs  b,a
         pshs  x          Preserve start ptr
         bra   L0131      Start writing
L0124    pshs  x          Preserve current buffer ptr
         leax  PD.WPID,y  Point to Write vars
         lbsr  L018B      Go wait for data to be ready
         bcc   L0131      Ready, go try writing again
         puls  x          No more data, restore buffer ptr
         bra   L0150      Go write out as much as we got

L0131    ldx   <D.Proc    Get process dsc. ptr
         ldb   P$Task,x   Get task #
         puls  x          Get start ptr back
L0137    os9   F$LDABX    Get byte from caller
         lbsr  L01CC
         bcs   L0124
         leax  1,x
         tst   <PD.WEOR,y
         beq   L014B
         cmpa  <PD.WEOR,y
         beq   L0150
L014B    cmpx  ,s         Hit end of buffer?
         bcs   L0137      No, keep writing
         clrb             Yes, no error
L0150    pshs  b,cc       Preserve error status
         tfr   x,d        Move buffer ptr to D
         subd  2,s        Calculate size actually written
         addd  R$Y,u      Add to size previously written
         std   R$Y,u      Save for caller
         puls  x,b,cc     Restore error status
L015C    leax  PD.WPID,y  Point to Write vars
         bra   L01BD      Shut off Write part, send signal to Read part

* Make current process the process to Read or Write from Pipe, or wait in line
*  until pipe is ready to for our process
* Entry: Y=Path dsc. ptr
*        X=Ptr to either Pipe Read or Pipe Write variables
L0160    lda   ,x         Get process # that is reading or writing to pipe
         beq   L0185      If none, make the current process the one
         cmpa  PD.CPR,y   Same as current process using this path?
         beq   L0189      Yes, no error & exit
* A read or write request from the pipe was made from a process that is not
* listed in the PD.??? pipe vars
         inc   1,x        New process using pipe, update # processes using
         ldb   1,x        Get new # of process reading or writing
         cmpb  PD.CNT,y   Same as total # of processes using pipe? 
         bne   L0173      No, skip ahead
         lbsr  L009C      Yes, send signal from 2,x to process using pipe
* New process is put in line to read/write to/from pipe
L0173    os9   F$IOQu     Stick waiting process (A) into I/O Queue
         dec   1,x        Dec # images in pipe down again
         pshs  x          Preserve ptr
         ldx   <D.Proc    Get current process dsc. ptr
         ldb   <P$Signal,x Get last signal code from current process
         puls  x          Get ptr back
         beq   L0160      If it didn't receive the signal, try again
         coma             Set carry & exit
         rts   

L0185    ldb   PD.CPR,y   Get Current process #
         stb   ,x         Save as process # that is reading/writing to pipe
L0189    clrb             No error & exit
         rts   

L018B    ldb   1,x        Get # images [reading or writing] from pipe?
         incb             Base 1
         cmpb  PD.CNT,y   Same as # of open images?
         beq   L01B9      Yes, Exit with Write Error
         stb   1,x        Save updated # images
         ldb   #$01       Wakeup signal
         stb   2,x        Save as signal to send to process
         clr   PD.CPR,y   Clear out current process # using pipe
         pshs  x          Preserve read/write offset ptr
         tfr   x,d        Move to D
         eorb  #$04       Flip between read/write vars
         tfr   d,x        Move to X
         lbsr  L009C      Go send signal to process on other end of pipe
         ldx   #$0000     Shut off process until signal received
         os9   F$Sleep
         ldx   <D.Proc    Get current process
         ldb   <P$Signal,x Get last signal code received
         puls  x          Restore read/write offset ptr
         dec   1,x        Dec # open images
         tstb             Was there a signal receieved?
         bne   L01BB      Yes, exit with carry set
         clrb             No error & exit
         rts   
L01B9    ldb   #E$Write   Write error
L01BB    coma  
         rts   
* Shut off Read part, send signal to Write part
* Shut down our side of pipe & send signal to other half of pipe
L01BD    pshs  u,b,cc     Preserve U, error code & status
         clr   ,x         Clear out process # using part of pipe
         tfr   x,d        Move ptr to D
         eorb  #$04       Flip between read/write vars
         tfr   d,x        Move to X
         lbsr  L009C      Send Signal to process on other end of pipe
         puls  pc,u,b,cc  Restore error status & return

* Entry: X=Ptr within caller's area we are writing from
* A=Char to write
* B=Task # of caller
L01CC    pshs  x,b        Preserve ptr & Task #
         ldx   <PD.NxtI,y Get ptr to next char in pipe buffer
         ldb   <PD.RFlg,y Get data ready in pipe buffer flag
         beq   L01DE      No data ready, skip ahead
         cmpx  <PD.NxtO,y Meeting write buffer ptr?
         bne   L01E3      No, continue
         comb  
         puls  pc,x,b
* Put char into pipe buffer & Set flag that data is ready
* Entry: Y=Path dsc. ptr
*        A=Char to put in buffer
L01DE    ldb   #1         Set flag
         stb   <PD.RFlg,y Save it
L01E3    sta   ,x+        Save char in pipe buffer
         cmpx  <PD.End,y  Hit end of buffer?
         bcs   L01EC      No, continue
         ldx   PD.BUF,y   Yes, wrap to beginning
L01EC    stx   <PD.NxtI,y Save current position in buffer
         clrb  
         puls  pc,x,b     Restore regs
L01F2    lda   <Pd.RFlg,y
         bne   L01F9
         comb  
         rts   
L01F9    pshs  x
         ldx   <PD.NxtO,y
         lda   ,x+
         cmpx  <PD.END,y
         bcs   L0207
         ldx   PD.BUF,y
L0207    stx   <PD.NxtO,y
         cmpx  <PD.NxtI,y
         bne   L0212
         clr   <Pd.RFlg,y
L0212    andcc  #^Carry
         puls  pc,x

         emod  
eom      equ   *
         end   


