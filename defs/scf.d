;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; scf - Sequential File Manager Definitions
;
; $Id$
;
; SCF stands for 'Sequential Character Filemanager' and is a package of
; subroutines that define the logical structure of a serial device.
;
; The data structures in this file give SCF its 'personality' and are used
; by SCF itself, as well as applications that will require disk I/O.
;
; Edt/Rev  YYYY/MM/DD  Modified by
; Comment
; ------------------------------------------------------------------
;          2004/07/02  Boisy G. Pitre
; Created

           .title   Sequential File Manager Definitions

           .area    SCF (ABS)

           .ifndef  Level
Level      ==       1
           .endif

           .page
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; SCF Device Descriptor Offsets
;
; These definitions are for SCF device descriptors.

           .org   M$DTyp
IT.DVC::   .rmb   1          ; Device type (DT.SCF)
IT.UPC::   .rmb   1          ; Uppercase flag
IT.BSO::   .rmb   1          ; Backspace behavior
IT.DLO::   .rmb   1          ; Delete behavior
IT.EKO::   .rmb   1          ; Echo flag
IT.ALF::   .rmb   1          ; Auto linefeed flag
IT.NUL::   .rmb   1          ; End-of-line null count
IT.PAU::   .rmb   1          ; Page pause flag
IT.PAG::   .rmb   1          ; Number of lines per page
IT.BSP::   .rmb   1          ; Backspace character
IT.DEL::   .rmb   1          ; Delete-line character
IT.EOR::   .rmb   1          ; End-of-record character
IT.EOF::   .rmb   1          ; End-of-file character
IT.RPR::   .rmb   1          ; Reprint-line character
IT.DUP::   .rmb   1          ; Duplicate-last-line character
IT.PSC::   .rmb   1          ; Pause character
IT.INT::   .rmb   1          ; Interrupt character
IT.QUT::   .rmb   1          ; Quit character
IT.BSE::   .rmb   1          ; Backspace echo character
IT.OVF::   .rmb   1          ; Bell character
IT.PAR::   .rmb   1          ; Parity
IT.BAU::   .rmb   1          ; Baud rate
IT.D2P::   .rmb   2          ; Attached device name string offset
IT.XON::   .rmb   1          ; X-ON character
IT.XOFF::  .rmb   1          ; X-OFF character
IT.COL::   .rmb   1          ; Number of columns for display
IT.ROW::   .rmb   1          ; Number of rows for display
IT.XTYP::  .rmb   1          ; Extended type (added by BRI)

           .ifgt  Level-1
; Window Descriptor Additions
; For CoCo window, where IT.PAR = $80
           .org   IT.ROW+1
IT.WND::   .rmb   1          ; Window number (matches device name) ($2E)
IT.VAL::   .rmb   1          ; Use defaults on Init (0=no, 1=yes)
IT.STY::   .rmb   1          ; Screen type default
IT.CPX::   .rmb   1          ; Column start default
IT.CPY::   .rmb   1          ; Row start default
IT.FGC::   .rmb   1          ; Foreground color default
IT.BGC::   .rmb   1          ; Background color default
IT.BDC::   .rmb   1          ; Border color default
           .endif


           .page
;;;;;;;;;;;;;;;;;;;;
; SCF Static Storage
;
; SCF devices must reserve this space for SCF
;
           .org   V.USER
V.TYPE::   .rmb   1          ; Device type or parity
V.LINE::   .rmb   1          ; Lines left until end of page
V.PAUS::   .rmb   1          ; Immediate Pause request
V.DEV2::   .rmb   2          ; Attached device's static
V.INTR::   .rmb   1          ; Interrupt char
V.QUIT::   .rmb   1          ; Quit char
V.PCHR::   .rmb   1          ; Pause char
V.ERR::    .rmb   1          ; Accumulated errors
V.XON::    .rmb   1          ; X-On char
V.XOFF::   .rmb   1          ; X-Off char
V.KANJI::  .rmb   1          ; Kanji mode flag
V.KBUF::   .rmb   2          ; Kana - Kanji convert routine work address
V.MODADR:: .rmb   2          ; Kana - Kanji convert module address
V.PDLHd::  .rmb   2          ; Open path descriptor list head pointer
V.RSV::    .rmb   5          ; Reserve bytes for future expansion
V.SCF      ==     .          ; Total SCF manager static overhead

           .page
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Sequential Character Path Descriptor Format
;
; A path descriptor is created for every new path that is open
; via the I$Open system call (processed by IOMan).  Process
; descriptors track state information of a path.
;
           .org   PD.FST
PD.DV2::   .rmb   2          ; Output device table pointer
PD.RAW::   .rmb   1          ; Read/Write or ReadLn/WritLn mode
PD.MAX::   .rmb   2          ; ReadLn high byte count
PD.MIN::   .rmb   1          ; Devices are "mine" if clear
PD.STS::   .rmb   2          ; Status routine module addr
PD.STM::   .rmb   2          ; Reserved for status routine
           .org   PD.OPT
           .rmb   1          ; Device type
PD.UPC::   .rmb   1          ; Case (0=both, 1=upper only)
PD.BSO::   .rmb   1          ; Backspace (0=BSE, 1=BSE,SP,BSE)
PD.DLO::   .rmb   1          ; Delete (0=BSE over line, 1=CRLF)
PD.EKO::   .rmb   1          ; Echo (0=No Echo)
PD.ALF::   .rmb   1          ; Auto linefeed (0=No auto LF)
PD.NUL::   .rmb   1          ; End of Line null count
PD.PAU::   .rmb   1          ; Page pause (0=No end of page pause)
PD.PAG::   .rmb   1          ; Lines per page
PD.BSP::   .rmb   1          ; Backspace character
PD.DEL::   .rmb   1          ; Delete Line character
PD.EOR::   .rmb   1          ; End of Record character (read only)
PD.EOF::   .rmb   1          ; End of File character
PD.RPR::   .rmb   1          ; Reprint Line character
PD.DUP::   .rmb   1          ; Dup Last Line character
PD.PSC::   .rmb   1          ; Pause character
PD.INT::   .rmb   1          ; Keyboard interrupt character (CTRL-C)
PD.QUT::   .rmb   1          ; Keyboard quit character (CTRL-E)
PD.BSE::   .rmb   1          ; Backspace echo character
PD.OVF::   .rmb   1          ; Line overflow character (BELL)
PD.PAR::   .rmb   1          ; Parity code
PD.BAU::   .rmb   1          ; ACIA baud rate (Color Computer)
PD.D2P::   .rmb   2          ; Offset of DEV2 name
PD.XON::   .rmb   1          ; ACIA X-ON character
PD.XOFF::  .rmb   1          ; ACIA X-OFF character
OPTCNT     ==     .-PD.OPT   ; Total user settable options
PD.ERR::   .rmb   1          ; Most recent I/O error status
PD.TBL::   .rmb   2          ; Device table addr (copy)
PD.PLP::   .rmb   2          ; Path Descriptor List Pointer
PD.PST::   .rmb   1          ; Current path status


; PD.PST values Path Descriptor Status byte
;
PST.DCD    ==     0b00000001 ; Set if DCD is lost on Serial port


; PD.PAR definitions
;
; Parity
PARNONE    ==     0b00000000
PARODD     ==     0b00100000
PAREVEN    ==     0b01100000
PARMARK    ==     0b10100000
PARSPACE   ==     0b11100000

; PD.BAU definitions
;
; Baud rate
B110       ==     0b00000000
B300       ==     0b00000001
B600       ==     0b00000010
B1200      ==     0b00000011
B2400      ==     0b00000100
B4800      ==     0b00000101
B9600      ==     0b00000110
B19200     ==     0b00000111
B38400     ==     0b00001000
B57600     ==     0b00001001
B115200    ==     0b00001010
; Word size
WORD8      ==     0b00000000
WORD7      ==     0b00100000
; Stop bits
STOP1      ==     0b00000000
STOP2      ==     0b00010000
