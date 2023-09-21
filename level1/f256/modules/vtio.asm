********************************************************************
* VTIO - NitrOS-9 Video Terminal I/O driver for F256
*
* $Id$
*
* Edt/Rev  YYYY/MM/DD  Modified by
* Comment
* ------------------------------------------------------------------
*  1       2013/08/20  Boisy G. Pitre
* Started.
*
* https://wiki.osdev.org/PS2_Keyboard

               nam       VTIO
               ttl       NitrOS-9 Video Terminal I/O driver for F256

               use       defsfile
               use       f256vtio.d

tylg           set       Drivr+Objct
atrv           set       ReEnt+rev
rev            set       $00
edition        set       1

mapaddr        equ       MMU_SLOT_1
mapstart       equ       (mapaddr-MMU_SLOT_0)*$2000
G.ScrStart     equ       mapstart
G.ScrEnd       equ       G.ScrStart+(G.Cols*G.Rows)


               mod       eom,name,tylg,atrv,start,size

size           equ       V.Last

               fcb       UPDAT.+EXEC.

name           fcs       /VTIO/
               fcb       edition

start          lbra      Init
               lbra      Read
               lbra      Write
               lbra      GetStat
               lbra      SetStat
               lbra      Term


* Init
*
* Entry:
*    Y  = address of device descriptor
*    U  = address of device memory area
*
* Exit:
*    CC = carry set on error
*    B  = error code
*
Init
               stu       >D.KbdSta           store devmem ptr
               leax      ChkSpc,pcr
               stx       V.EscVect,u

* setup static vars
               clra
               clrb
               std       V.CurRow,u

               pshs      cc
               orcc      #IntMasks

               lbsr      ClrScrn

* setup keyboard interrupt
setupint       ldd       #INT_PENDING_0
               leax      IRQPckt,pcr
               leay      IRQSvc,pcr
               os9       F$IRQ
               bcs       bye@
               lda       INT_MASK_0
               anda      #^INT_PS2_KBD
               sta       INT_MASK_0
* clear keyboard of any data
loop@          lda       KBD_IN
               lda       PS2_STAT
               bita      #KEMP
               beq       loop@
bye@
               leax      ProcKeyCode,pcr
               stx       V.KeyCodeHandler,u
               puls      cc

* clear carry and return
               clrb
initex         rts

IRQPckt        equ       *
Pkt.Flip       fcb       %00000000
Pkt.Mask       fcb       INT_PS2_KBD
               fcb       $F1

* Term
*
* Entry:
*    U  = address of device memory area
*
* Exit:
*    CC = carry set on error
*    B  = error code
*
Term
               ldx       #$0000              remove IRQ table entry
               leay      IRQSvc,pcr
               os9       F$IRQ
* clear carry and return
               clrb
               rts


* Read
*
* Entry:
*    Y  = address of path descriptor
*    U  = address of device memory area
*
* Exit:
*    A  = character read
*    CC = carry set on error
*    B  = error code
*
Read
               leax      V.InBuf,u           point X to input buffer
               ldb       V.IBufT,u           get tail pointer
               orcc      #IRQMask            mask IRQ
               cmpb      V.IBufH,u           same as head pointer
               beq       Put2Bed             if so, buffer is empty, branch to sleep
               abx                           X now points to curr char
               lda       ,x                  get char
               bsr       IncNCheck           check for tail wrap
               stb       V.IBufT,u           store updated tail
               andcc     #^(IRQMask+Carry)   unmask IRQ
               rts

Put2Bed        lda       V.BUSY,u            get calling process ID
               sta       V.WAKE,u            store in V.WAKE
               andcc     #^IRQMask           clear interrupts
               ldx       #$0000
               os9       F$Sleep             sleep forever
               clr       V.WAKE,u            clear wake
               ldx       <D.Proc             get pointer to current proc desc
               ldb       <P$Signal,x         get signal recvd
               beq       Read                branch if no signal
               cmpb      #S$Window           window signal?
               bcc       Read                branch if so
               coma
               rts
* Check if we need to wrap around tail pointer to zero
IncNCHeck      incb                          increment pointer
               cmpb      #KBufSz-1           at end?
               bls       readex              branch if not
* clear carry and return
               clrb                          else clear pointer (wrap to head)
readex         rts


* Write
*
* Entry:
*    A  = character to write
*    Y  = address of path descriptor
*    U  = address of device memory area
*
* Exit:
*    CC = carry set on error
*    B  = error code
*
Write
               lbsr      hidecursor
               ldx       V.EscVect,u
               jsr       ,x
               lbra       drawcursor

ChkSpc         cmpa      #C$SPAC             space or greater?
               lbcs      ChkESC              branch if not

wchar
               pshs      a
               lda       V.CurRow,u
               ldb       #G.Cols
               mul
               addb      V.CurCol,u
               adca      #0
               ldx       #G.ScrStart
               leax      d,x
               puls      a
               pshs      cc
               ldb       mapaddr
               pshs      b
               orcc      #IntMasks
               ldb       #$C2
               stb       mapaddr
               sta       ,x
               lda       ,s+
               sta       mapaddr
               puls      cc
               ldd       V.CurRow,u
               incb
               cmpb      #G.Cols
               blt       ok
               clrb
incrow
               inca
               cmpa      #G.Rows
               blt       clrline
SCROLL         equ       1
               ifne      SCROLL
               deca                          set A to G.Rows - 1
               ldx       #G.ScrStart         get start of screen memory
               ldy       #G.Cols*(G.Rows-1)  set Y to size of screen minus last row

               pshs      cc,d                save off Row/Col and condition codes
               lda       mapaddr
               pshs      a
               orcc      #IntMasks
               lda       #$C2
               sta       mapaddr
scroll_loop
               ldd       G.Cols,x            get two bytes on next row
               std       ,x++                store on this row
               leay      -2,y                decrement Y
               bne       scroll_loop         branch if not 0
               puls      a
               sta       mapaddr
               puls      cc,d
               else
               clra
               endc
* clear line
clrline        std       V.CurRow,u
               lbsr       DelLine
               rts
ok             std       V.CurRow,u
ret            rts

* calculates the cursor location in screen memory
* Exit: X = address of cursor
*       All other regs preserved
calcloc
               pshs      d
               lda       V.CurRow,u
               ldb       #G.Cols
               mul
               addb      V.CurCol,u
               adca      #0
               ldx       #G.ScrStart
               leax      d,x
               puls      d,pc

drawcursor
               bsr       calcloc
               pshs      cc
               lda       mapaddr
               pshs      a
               orcc      #IntMasks
               ldb       #$C2
               stb       mapaddr
               lda       ,x
               sta       V.CurChr,u
               lda       #$5F
               sta       ,x
               puls      a
               sta       mapaddr
               puls      cc,pc

hidecursor
               pshs      a,cc
               bsr       calcloc
               lda       V.CurChr,u
               orcc      #IntMasks
               ldb       mapaddr
               pshs      b
               ldb       #$C2
               stb       mapaddr
               sta       ,x
               puls      b
               stb       mapaddr
               puls      a,cc,pc

ChkESC
               cmpa      #$1B                ESC?
               lbeq      EscHandler
               cmpa      #$0D                $0D?
               bhi       ret                 branch if higher than
               leax      <DCodeTbl,pcr       deal with screen codes
               lsla                          adjust for table entry size
               ldd       a,x                 get address in D
               jmp       d,x                 and jump to routine

* display functions dispatch table
DCodeTbl       fdb       NoOp-DCodeTbl       $00:no-op (null)
               fdb       CurHome-DCodeTbl    $01:HOME cursor
               fdb       CurXY-DCodeTbl      $02:CURSOR XY
               fdb       DelLine-DCodeTbl    $03:ERASE LINE
               fdb       ErEOLine-DCodeTbl   $04:CLEAR TO EOL
               fdb       Do05-DCodeTbl       $05:CURSOR ON/OFF
               fdb       CurRght-DCodeTbl    $06:CURSOR RIGHT
               fdb       NoOp-DCodeTbl       $07:Bell
               fdb       CurLeft-DCodeTbl    $08:CURSOR LEFT
               fdb       CurUp-DCodeTbl      $09:CURSOR UP
               fdb       CurDown-DCodeTbl    $0A:CURSOR DOWN
               fdb       ErEOScrn-DCodeTbl   $0B:ERASE TO EOS
               fdb       ClrScrn-DCodeTbl    $0C:CLEAR SCREEN
               fdb       Retrn-DCodeTbl      $0D:RETURN

DelLine
               lda       V.CurRow,u
               ldb       #G.Cols
               mul
               ldx       #G.ScrStart
               leax      d,x
               lda       #G.Cols
               pshs      cc
               orcc      #IntMasks
               ldb       mapaddr
               pshs      b
               ldb       #$C2
               stb       mapaddr
clrloop@       clr       ,x+
               deca
               bne       clrloop@
               puls      b
               stb       mapaddr
               puls      cc,pc

ClrScrn
               clr       V.CurCol,u
               lda       #G.Rows-1
clrloop@
               sta       V.CurRow,u
               pshs      a
               bsr       DelLine
               puls      a
               deca
               bpl       clrloop@
               clr       V.CurCol,u
               rts

ErEOScrn
CurUp
NoOp
CurHome        clr       V.CurCol,u
               clr       V.CurRow,u
               rts

CurXY
ErEOLine
Do05
CurRght
               rts

CurLeft
               ldd       V.CurRow,u
               beq       leave
               decb
               bpl       erasechar
               ldb       #G.Cols-1
               deca
               bpl       erasechar
               clra
erasechar
               std       V.CurRow,u
               ldb       #G.Cols
               mul
               addb      V.CurCol,u
               adca      #0
               ldx       #G.ScrStart
               leax      d,x
               clr       1,x
leave          rts

CurDown
               ldd       V.CurRow,u
               lbra      incrow

Retrn
               clr       V.CurCol,u
               rts

EscHandler
               leax      EscHandler2,pcr
eschandlerout
               stx       V.EscVect,u
               rts

EscHandler2
               sta       V.EscCh1,u
               leax      EscHandler3,pcr
               bra       eschandlerout

EscHandler3
               ldb       V.EscCh1,u
               cmpb      #$32
               beq       DoFore
               cmpb      #$33
               beq       DoBack
               cmpb      #$34
               beq       DoBord
eschandler3out
               leax      ChkSpc,pcr
               bra       eschandlerout

DoFore
               bra       eschandler3out
DoBack
               bra       eschandler3out
DoBord
               bra       eschandler3out


* GetStat
*
* Entry:
*    A  = function code
*    Y  = address of path descriptor
*    U  = address of device memory area
*
* Exit:
*    CC = carry set on error
*    B  = error code
*
GetStat
               cmpa      #SS.Ready
               bne       gsrdy
               cmpa      #SS.ScSiz
               bne       gserr
               ldx       PD.RGS,y
               ldd       #G.Cols
               std       R$X,x
               ldd       #G.Rows
               std       R$Y,x
* clear carry and return
               clrb
               rts
gsrdy
gserr
               comb
               ldb       #E$UnkSvc
               rts


* SetStat
*
* Entry:
*    A  = function code
*    Y  = address of path descriptor
*    U  = address of device memory area
*
* Exit:
*    CC = carry set on error
*    B  = error code
*
SetStat
* clear carry and return
               clrb
               rts



***
* IRQ routine for keyboard
*
* INPUT:  A = flipped and masked device status byte
*         U = keyboard data area address
*
* OUTPUT:
*          CC Carry clear
*          D, X, Y, and U registers may be altered
*
* ERROR OUTPUT:  none
*

RAW_KEYBOARD   equ      0

               ifne     RAW_KEYBOARD
* Input: A = byte to convert to hex
* Output: A = ASCII character of first digit
*         B = ASCII character of second digit
cvt2hex        pshs     a
               lsra
               lsra
               lsra
               lsra
               cmpa     #9
               bgt      hex@
               adda     #$30
               bra      afthex@
hex@           adda     #$37
afthex@
               ldb      ,s+
               andb     #$0F
               cmpb     #9
               bgt     hex2@
               addb    #$30
               bra      afterhex2@
hex2@          addb    #$37
afterhex2@     rts
               endc

IRQSvc
*         clr       MMU_IO_CTRL
* clear interrupt
clrint
               ldb       #INT_PS2_KBD
               stb       INT_PENDING_0
               lda       KBD_IN

               ifne      RAW_KEYBOARD
               bsr       cvt2hex
               pshs      b
               bsr       BufferChar
               puls      a
               bsr       BufferChar
               bra       WakeIt
               endc

* A = keycode
* point Y to appropriate key table (Shift vs Non-Shift)
               tst       V.Shift,u           is shift down?
               bne       shift@              branch of so
               leay      ScanMap,pcr         else point to non-shift scan map
               bra       pastshift@          and branch
shift@         leay      ShiftScanMap,pcr    point to shift scan map
pastshift@     ldx       V.KeyCodeHandler,u  get the current keycode handler
               jsr       ,x                  jsr into it
               bcs       IRQExit             if carry set, don't wake process
               ldb       #S$Intrpt           get interrupt signal
               cmpa      V.INTR,u            our char same as intr?
               beq       getlproc@           branch if same
               ldb       #S$Abort            get abort signal
               cmpa      V.QUIT,u            our char same as QUIT?
               bne       WakeIt              branch if not
getlproc@      lda       V.LPRC,u            get ID of last process to get this device
               bra       noproc@
* Wake up process if sleeping
WakeIt         ldb       #S$Wake
               lda       V.WAKE,u            anybody waiting? ([D]=process descriptor address)
noproc@        beq       IRQExit             no, go return...
               clr       V.WAKE,u
               os9       F$Send
IRQExit        lsr       PS2_STAT            shift PS/2 status bit 0 into carry
               bcc       clrint              branch if 0 (more data)
               clrb                          else clear carry
               rts                           and return to the caller


* Entry:  A = PS/2 keycode
*
* Exit:  CC = carry clear: wake up a sleeping process waiting on input
*             carry set: don't wake up a sleeping process waiting on input
ProcKeyCode    cmpa      #$E0                is it $E0 preface byte?
               beq       ProcE0              branch if so
               cmpa      #$F0                is it $F0 preface byte?
               beq       ProcF0              branch if so
               lda       a,y                 else pull key character from scan code table
               bmi       SpecialDown
* Check for CTRL key
               tst       V.Ctrl,u
               beq       CheckCapsLock
               suba      #$60
CheckCapsLock  tst       V.CapsLck,u
               beq       BufferChar
               cmpa      #'a
               blt       BufferChar
               suba      #$20
* Advance the circular buffer one character
BufferChar     ldb       V.IBufH,u           get head pointer in B
               leax      V.InBuf,u           point X to input buffer
               abx                           X now holds address of head
               lbsr      IncNCheck           increment and check for tail wrap
               cmpb      V.IBufT,u           B at tail? (if so, buffer full)
               beq       bye@                branch if full (drop it on the floor)
               stb       V.IBufH,u
               sta       ,x                  place the character in the buffer
bye@           clrb                          clear carry
               rts

SpecialDown    cmpa      #$F0 Caps Lock key?
               blt       next@
               beq       DoCapsDown
               cmpa      #$F1 Shift key?
               beq       DoShiftDown
               cmpa      #$F2  CTRL key?
               beq       DoCtrlDown
DoAltDown      sta       V.Alt,u
               comb
               rts
DoCtrlDown     sta       V.Ctrl,u
               comb
               rts
DoCapsDown     com       V.CapsLck,u
               comb
               rts
DoShiftDown    sta       V.Shift,u
               comb
               rts
next@          anda      #^$80
               bra       BufferChar

ProcE0         leax      E0Handler,pcr
               stx       V.KeyCodeHandler,u
               rts
ProcF0         leax      F0Handler,pcr
               stx       V.KeyCodeHandler,u
               clrb
               rts
* A = keycode
* Y = scan table
E0Handler      cmpa      #$F0
               beq       ProcF0
               leax      ProcKeyCode,pcr
               stx       V.KeyCodeHandler,u
               cmpa      #$11                right alt?
               beq       DoAltDown
               cmpa      #$14                right ctrl?
               beq       DoCtrlDown
               comb
               rts
E0HandlerUp    cmpa      #$11                right alt up?
               beq       DoAltUp
               cmpa      #$14                right ctrl up?
               beq       DoCtrlUp
               bra       SetDefaultHandler
F0Handler      lda       a,y
               bmi       SpecialUp
SetDefaultHandler
               leax      ProcKeyCode,pcr
               stx       V.KeyCodeHandler,u
               comb
               rts
SpecialUp      cmpa      #$F1 Shift key?
               beq            DoShiftUp
               cmpa           #$F2 CTRL key?
               bne SetDefaultHandler
DoCtrlUp clr V.Ctrl,u
                bra SetDefaultHandler
DoShiftUp clr V.Shift,u
                 bra SetDefaultHandler
DoAltUp clr V.Alt,u
 bra SetDefaultHandler


* Special flags:
* $F0 = Caps Lock key pressed
* $F1 = Shift key pressed
* $F2 = CTRL key pressed
* $F3 = ALT key pressed
ScanMap        fcb       0,0,0,0,0,0,0,0,0,0,0,0,0,0,'`,0
               fcb       0,$F3,$F1,0,$F2,'q,'1,0,0,0,'z,'s,'a,'w,'2,0
               fcb       0,'c,'x,'d,'e,'4,'3,0,0,C$SPAC,'v,'f,'t,'r,'5,0
               fcb       0,'n,'b,'h,'g,'y,'6,0,0,0,'m,'j,'u,'7,'8,0
               fcb       0,C$COMA,'k,'i,'o,'0,'9,0,0,'.,'/,'l,';,'p,'-,0
               fcb       0,0,'',0,'[,'=,0,0,$F0,$F1,C$CR,'],0,'\,0,0
               fcb       0,0,0,0,0,0,$88,0,0,'1,0,'4,'7,0,0,0
               fcb       '0,'.,'2,'5,'6,'8,$1B,0,0,'+,'3,'-,'*,'9,0,0

ShiftScanMap   fcb       0,0,0,0,0,0,0,0,0,0,0,0,0,0,'~,0
               fcb       0,$F3,$F1,0,$F2,'Q,'!,0,0,0,'Z,'S,'A,'W,'@,0
               fcb       0,'C,'X,'D,'E,'$,'#,0,0,C$SPAC,'V,'F,'T,'R,'%,0
               fcb       0,'N,'B,'H,'G,'Y,'^,0,0,0,'M,'J,'U,'&,'*,0
               fcb       0,'<,'K,'I,'O,'),'(,0,0,'>,'?,'L,':,'P,'_,0
               fcb       0,0,'",0,'{,'+,0,0,$F0,$F1,C$CR,'},0,'|,0,0
               fcb       0,0,0,0,0,0,$88,0,0,'1,0,'4,'7,0,0,0
               fcb       '0,'.,'2,'5,'6,'8,$1B,0,0,'+,'3,'-,'*,'9,0,0

               emod
eom            equ       *
               end
