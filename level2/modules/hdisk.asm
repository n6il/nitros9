* OS-9 Level 2 - SCSI Device Driver module.
* Copyright (C) 1989 by RGB Computer Systems
* All Rights Reserved

* Last Revised 11/18/89

         nam   HDisk.dr
         ttl   RGB Computer Systems Hard Disk Device Driver

* Set the following equate for the type of Hard Disk
* Interface you are using. Codes are as follows:
*  0 = LR-TECH and OWL
*  1 = KEN-TON and RGB
*  2 = DISTO SUPER BOARDS

HDI.type equ   1          set for KEN-TON/RGB

* To save system map space we support only 4 drives but
* the driver can support a MAXIMUM of 16. Set NUMDRV to
* the max number of drives you NEED to run.

NUMDRV   equ   4          can support up to 16

**********  MAKE NO CHANGES BELOW THIS LINE  **********

         ifp1  
         use   defsfile
         use   rbfdefs
         endc  

         ifeq  HDI.type

* Hard Disk Interface REGISTER OFFSETS
* For the LR-TECH and OWL HDI

DATAPORT equ   0
STATUS   equ   DATAPORT+1
SELECT   equ   DATAPORT+2
RESET    equ   DATAPORT+3

* Status Register EQUATES

REQ      equ   1          1=data transfer request
BUSY     equ   2          controller busy 1=busy
MSG      equ   4          message for host 1=2nd status byte
CMD      equ   8          command/data 1=command
INOUT    equ   $10        input/output 1=input

ACK      equ   $00        not supported
SEL      equ   $00        not supported
RST      equ   $00        not supported

         endc  

         ifeq  HDI.type-1

* Hard Disk Interface REGISTER OFFSETS
* For the KEN-TON and RGB HDI

DATAPORT equ   0
STATUS   equ   DATAPORT+1
SELECT   equ   DATAPORT+2
RESET    equ   DATAPORT+3

* Status Register EQUATES

REQ      equ   1          1=data transfer request
BUSY     equ   2          controller busy 1=busy
MSG      equ   4          message for host 1=2nd status byte
CMD      equ   8          command/data 1=command
INOUT    equ   $10        input/output 1=input

ACK      equ   $20        1=ack asserted
SEL      equ   $40        1=select asserted
RST      equ   $80        1=reset asserted

         endc  

         ifeq  HDI.type-2

* Hard Disk Interface REGISTER OFFSETS
* For the DISTO SUPER BOARDS

DATAPORT equ   0
STATUS   equ   DATAPORT-2
SELECT   equ   DATAPORT-1
RESET    equ   DATAPORT-2

* Status Register EQUATES

SEL      equ   0          select not supported
BUSY     equ   1          1=busy
ACK      equ   2          1=ack
MSG      equ   4          1=msg
INOUT    equ   $20        1=in, 0=out
CMD      equ   $40        1=cmd, 0=data
REQ      equ   $80        1=req

         endc  

         pag   

* SCSI Class 0 CCS (Common Command Set)

C$RSTR   equ   1          reset to track 00
C$RDET   equ   3          request sense
C$RBLK   equ   8          read from device
C$WBLK   equ   10         write to device

* Optional Class 0 command

C$STSTOP equ   $1B        stop (park) device

* Misc equates

ERRSTA   equ   2          bit 1 of status byte "check sense"
BSYBIT   equ   8          bit 3 of status byte "device busy"

SKIP2    equ   $8C        cmpx # opcode skips 2 bytes

EDITION  equ   2          driver edition number

TYPE     set   Drivr+Objct
REVS     set   ReEnt+EDITION

* Module begins here

         mod   END,NAME,TYPE,REVS,ENTRY,DMEM
         fcb   %11111111  all modes available

NAME     fcs   /HDisk/
         fcb   EDITION

* Data area

         rmb   DRVBEG+(DRVMEM*NUMDRV) RBF memory

V$CMD    rmb   1          command code byte (a)
V$ADDR0  rmb   1          unit hi sector address (b)
V$ADDR1  rmb   2          unit middle & low sector (x)
V$BLKS   rmb   1          sector count/options (1)
V$OPTS   rmb   1          options for drive (0)
V$EXT    rmb   4          room for extended commands
V$RETRY  rmb   1          I/O retry counter
V$ERROR  rmb   27         read error buffer

DMEM     equ   .


* Branch Table for subroutines

ENTRY    lbra  INIT       intialize
         lbra  MREAD      read a sector
         lbra  MWRITE     write a sector
         lbra  GET        get status
         lbra  PUT        put status
         lbra  TERM       terminate

         pag   

* Initalize

INIT           

         ldd   #($ff*256)+NUMDRV fake media size / # of drives
         leax  DRVBEG,u   point to drive table start

         stb   V.NDRV,u   tell RBF how many drives we support

INIT10   sta   2,x        setup fake media size $0000FF sectors
         leax  DRVMEM,x   next table
         decb             count down
         bne   INIT10     next table

         clrb             no errors
         rts              return

         pag   

* Read data
* If LSN zero is read, copy DD.SIZ bytes into the drive table

MREAD    tstb             LSN zero?
         bne   READ10     no, normal read
         cmpx  #0         at LSN zero?
         bne   READ10     no, normal read

         bsr   READ10     read in LSN zero
         bcc   READ30     copy drive table if no error
         rts              error, return with it

READ30   ldb   PD.DRV,y   get drive number
         andb  #%00001111 keep lowest 4 bits
         leax  DRVBEG,u   point x to start of drive tables

READ40   decb             count down
         bmi   READ50     done, go copy drive table
         leax  DRVMEM,x   next table
         bra   READ40     go again

READ50   ldb   #DD.SIZ    size of drive table
         ldy   PD.BUF,y   get sector buffer address

READ60   lda   ,y+        get byte from buffer
         sta   ,x+        store in drive table
         decb             bytes left to store
         bne   READ60     done ?

         clrb             no errors
         rts              return


* Generic Read and Write

MWRITE   lda   #C$WBLK    write command
         fcb   SKIP2      skip 2 bytes
READ10   lda   #C$RBLK    read command
         bsr   SETUP      setup command block
         bra   COMMAND    do it & return

         pag   

* SCSI Device Wakeup Routine (Acquire SCSI bus)

WAKEUP   ldb   #4         Not Ready code
         ldx   #0         bus free timeout counter
         pshs  b,u        save registers
         ldu   V.PORT,u   get data port pointer

WAKE     lda   STATUS,u   get bus status
         bita  #BUSY+SEL  is scsi bus free?
         beq   WAKE2      yes, start selection

WAKE1    leax  -1,x       decrement counter
         bne   WAKE       try again
         bra   WAKE5      exit, BEQ=timeout

WAKE2    clra             a=0
         ldb   PD.DRV,y   get drive number
         lsrb             shift off drive select
         andb  #%00000111 keep SCSI ID number
         orcc  #Carry     set carry

WAKE3    rola             shift bit over
         decb             count down
         bpl   WAKE3      go again

* tst DATAPORT,u port still clear?
* bne WAKE1 no, wait more

         sta   DATAPORT,u assert SCSI device address
         bsr   SETTLE     bus settle delay
         sta   SELECT,u   assert -SELect (-BSY will clear it)

WAKE4    lda   STATUS,u   get status
         bita  #BUSY      did it go busy yet?
         beq   WAKE4      no, check again

WAKE5    puls  b,u,pc     restore regs & return


* Setup Command Descripter Block

SETUP    sta   V$CMD,u    store command opcode

         lda   PD.DRV,y   get drive number
         bita  #1         test drive select bit
         beq   DRIVE0     don't set bit 5

         orb   #%00100000 set bit 5

DRIVE0   stb   V$ADDR0,u  store sector hi byte
         stx   V$ADDR1,u  store sector lo word

         ldb   #1         transfer 1 block
         stb   V$BLKS,u   read/write 1 sector
         ldb   PD.STP,y   get step/options
         stb   V$OPTS,u   store in command packet

SETTLE   rts              return (also bus settle delay)

         pag   

* Execute all SCSI commands
* Command errors are re-tried ten times
* Upon entry:  CDB at V$CMD,u setup with data
* Upon exit :  Command executed
*              If no error, carry clear & B=0
*              If error, carry set & B=ErrCode


COMMAND  lda   #10        I/O retry count
         sta   V$RETRY,u  setup inital count

CMD20    bsr   WAKEUP     get controller on-line
         lbeq  CONVERT    timeout, error
         leax  V$CMD,u    address of command packet
         bsr   SEND       send command out
         pshs  u          save u
         ldu   V.PORT,u   point to data port
         bsr   WAITRQ     wait for -REQuest asserted
         puls  u          restore data pointer
         bita  #CMD       command or data transfer?
         bne   GETSTA     get status

         ldx   PD.BUF,y   get buffer address
         bita  #INOUT     data IN or OUT?
         beq   WRT        data OUT, go write

         bsr   READ       data IN, go read
         fcb   SKIP2      skip over write

WRT      bsr   WRITE      data OUT, go write

GETSTA   lbsr  INSTAT     get completion status

         bita  #BSYBIT    controller busy?
         bne   CMD20      yes, re-send command

         bita  #ERRSTA    any error?
         bne   GET20      yes, re-send if retries left
         rts              no error, return

GET20    dec   V$RETRY,u  any retries left?
         bne   CMD20      yes, re-send command

* Arrive here if there WAS an error

         lbsr  WAKEUP     get controller again
         lbeq  CONVERT    timeout, error
         lda   #C$RDET    request sense info
         clrb             scsi reserved (0)
         ldx   #0         scsi reserved (0)
         bsr   SETUP      setup command
         clr   V$BLKS,u   scsi reserved (setup sets to 1)

         leax  V$CMD,u    point to command
         bsr   SEND       send command
         leax  V$ERROR,u  point to buffer for error
         bsr   READ       read error info
         bsr   INSTAT     get completion status
         ldb   V$ERROR,u  get error code
         andb  #%01111111 strip address valid bit
         bra   CONVERT    convert HD error into OS-9 code

         pag   

* Send out a Command Descripter Block

SEND     pshs  u          save u
         ldu   V.PORT,u   get port address

SEND2    bsr   WAITRQ     wait for -REQuest
         bita  #CMD       command or data?
         beq   DONE       data phase, exit
         bita  #INOUT     status phase?
         bne   DONE       yes, exit

         lda   ,x+        get a command byte
         sta   DATAPORT,u send it out
         bra   SEND2      send another one

DONE     puls  u,pc       restore u & return


* Wait for -REQ asserted, return with status byte in "A"

WAITRQ   pshs  x          save X

WAIT10   lda   STATUS,u   get status byte

         bita  #ACK       -ACK still asserted?
         bne   WAIT20     yes, -REQ not valid yet

         bita  #REQ       -REQ asserted?
         bne   WAIT30     yes, exit now

WAIT20   ldx   D.Proc     get current process pointer
         cmpx  D.SysPrc   are we doing a system process?
         beq   WAIT10     yes, do not F$Sleep!

         ldx   #1         sleep till end of time slice
         os9   F$Sleep    sleep 1 tick
         bra   WAIT10     check status again

WAIT30   puls  x,pc       restore & return

         pag   

* Read SCSI data

READ     pshs  u          save u
         ldu   V.PORT,u   get port address

READ2    bsr   WAITRQ     wait for -REQ
         bita  #CMD       data phase?
         bne   DONE       no, exit
         lda   DATAPORT,u get data byte
         sta   ,x+        store in buffer
         bra   READ2      go again


* Write SCSI data

WRITE    pshs  u          save u
         ldu   V.PORT,u   get port address

WRITE2   bsr   WAITRQ     wait for -REQ
         bita  #CMD       data phase?
         bne   DONE       no, exit
         lda   ,x+        get byte from buffer
         sta   DATAPORT,u send it out
         bra   WRITE2     go again

         pag   

* Get command completion status

INSTAT   pshs  a,u        save registers
         ldu   V.PORT,u   get port address

         bsr   WAITRQ     wait for -REQ
         lda   DATAPORT,u get status byte
         anda  #%00001111 strip unused bits
         sta   ,s         save status in A
         bsr   WAITRQ     wait for -REQ
         clra             null & clear carry
         sta   DATAPORT,u clear bus & ack
         puls  a,u,pc     restore status code & return


* Convert HD error code into OS-9 code

CONVERT  pshs  b          put HD error on stack
         leax  ERRTBL,pcr point to error table

CONV2    ldb   ,x++       get code from table
         bmi   CONV3      code not found, exit
         cmpb  ,s         is this our error?
         bne   CONV2      nope, try again

CONV3    com   ,s+        set carry & reset stack
         ldb   -1,x       get OS-9 error code
         rts              return with error code

ERRTBL         

         fcb   $01,E$NotRdy no index pulse
         fcb   $02,E$Seek no seek complete
         fcb   $03,E$Write write error
         fcb   $04,E$NotRdy drive not ready
         fcb   $06,E$Seek no TK00 found

         fcb   $10,E$CRC  id CRC error
         fcb   $11,E$Read uncorrectable data error
         fcb   $12,E$Seek address mark not found
         fcb   $14,E$Seek record not found
         fcb   $15,E$Seek seek error
         fcb   $18,E$CRC  data check, no retry mode
         fcb   $19,E$CRC  ECC error
         fcb   $1A,E$Unit interleave error
         fcb   $1C,E$Unit bad format or no format

         fcb   $20,E$Unit illegal command opcode
         fcb   $21,E$IBA  illegal sector address
         fcb   $23,E$IBA  overflow after first sector
         fcb   $24,E$Unit bad argument in command
         fcb   $25,E$Unit invalid argument in CDB

         fcb   $70,E$Unit Seagate Extended sense
         fcb   $FF,E$UnkSvc if here, bmi! unknown error!

         pag   

* Get and Term do nothing 

GET            
TERM           
         clrb             clear carry = no error
         rts   


* PutSta can restore or park the drive

PUT      ldx   PD.RGS,y   get register packet
         ldb   R$B,x      get function call

         cmpb  #SS.SQD    sequence down hard disk code?
         beq   PARK       yes, go park drive.

         cmpb  #SS.RESET  recalibrate command?
         beq   RESTORE    yes, do it

         cmpb  #SS.WTRK   write track (format) command?
         beq   PUT2       yes, allow it & exit (drive NOT formatted!)

         comb             set carry = error
         ldb   #E$UnkSvc  no, unknown call

PUT2     rts              return


PARK     bsr   RESTORE    restore drive to tk00
         bcs   PUT2       exit if error

         lda   #C$STSTOP  start/stop (park)
         fcb   SKIP2      skip following LDA

RESTORE  lda   #C$RSTR    restore drive to tk00
         clrb             scsi reserved
         ldx   #0         scsi reserved
         lbsr  SETUP      setup command
         clr   V$BLKS,u   setup sets to 1
         lbra  COMMAND    go do it & return


* T-T-T-That's all folks!

         emod  

END      equ   *

         end   
