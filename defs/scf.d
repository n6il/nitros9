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

IT.DVC   ==   0h18          ; Device type (DT.SCF)
IT.UPC   ==   0h19         ; Uppercase flag
IT.BSO   ==   0h1A         ; Backspace behavior
IT.DLO   ==   0h1B         ; Delete behavior
IT.EKO   ==   0h1C         ; Echo flag
IT.ALF   ==   0h1D         ; Auto linefeed flag
IT.NUL   ==   0h1E         ; End-of-line null count
IT.PAU   ==   0h1F         ; Page pause flag
IT.PAG   ==   0h20         ; Number of lines per page
IT.BSP   ==   0h21         ; Backspace character
IT.DEL   ==   0h22         ; Delete-line character
IT.EOR   ==   0h23         ; End-of-record character
IT.EOF   ==   0h24         ; End-of-file character
IT.RPR   ==   0h25         ; Reprint-line character
IT.DUP   ==   0h26         ; Duplicate-last-line character
IT.PSC   ==   0h27         ; Pause character
IT.INT   ==   0h28         ; Interrupt character
IT.QUT   ==   0h29         ; Quit character
IT.BSE   ==   0h2A         ; Backspace echo character
IT.OVF   ==   0h2B         ; Bell character
IT.PAR   ==   0h2C         ; Parity
IT.BAU   ==   0h2D         ; Baud rate
IT.D2P   ==   0h2E         ; Attached device name string offset
IT.XON   ==   0h30         ; X-ON character
IT.XOFF  ==   0h31         ; X-OFF character
IT.COL   ==   0h32         ; Number of columns for display
IT.ROW   ==   0h33         ; Number of rows for display
IT.XTYP  ==   0h34         ; Extended type (added by BRI)

           .ifgt  Level-1
; Window Descriptor Additions
; For CoCo window, where IT.PAR = $80
IT.WND   ==   0h33          ; Window number (matches device name) ($2E)
IT.VAL   ==   0h34          ; Use defaults on Init (0=no, 1=yes)
IT.STY   ==   0h35          ; Screen type default
IT.CPX   ==   0h36          ; Column start default
IT.CPY   ==   0h37          ; Row start default
IT.FGC   ==   0h38          ; Foreground color default
IT.BGC   ==   0h39          ; Background color default
IT.BDC   ==   0h3A          ; Border color default
           .endif


           .page
;;;;;;;;;;;;;;;;;;;;
; SCF Static Storage
;
; SCF devices must reserve this space for SCF
;
V.TYPE   ==   0h06          ; Device type or parity
V.LINE   ==   0h07          ; Lines left until end of page
V.PAUS   ==   0h08          ; Immediate Pause request
V.DEV2   ==   0h09          ; Attached device's static
V.INTR   ==   0h0B          ; Interrupt char
V.QUIT   ==   0h0C          ; Quit char
V.PCHR   ==   0h0D          ; Pause char
V.ERR    ==   0h0E          ; Accumulated errors
V.XON    ==   0h0F          ; X-On char
V.XOFF   ==   0h10          ; X-Off char
V.KANJI  ==   0h11          ; Kanji mode flag
V.KBUF   ==   0h12          ; Kana - Kanji convert routine work address
V.MODADR ==   0h14          ; Kana - Kanji convert module address
V.PDLHd  ==   0h16          ; Open path descriptor list head pointer
V.RSV    ==   0h18          ; Reserve bytes for future expansion
V.SCF    ==     0h1D          ; Total SCF manager static overhead

           .page
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Sequential Character Path Descriptor Format
;
; A path descriptor is created for every new path that is open
; via the I$Open system call (processed by IOMan).  Process
; descriptors track state information of a path.
;
PD.DV2   rmb   0h32          ; Output device table pointer
PD.RAW   rmb   0h34          ; Read/Write or ReadLn/WritLn mode
PD.MAX   rmb   0h35          ; ReadLn high byte count
PD.MIN   rmb   0h37          ; Devices are "mine" if clear
PD.STS   rmb   0h38          ; Status routine module addr
PD.STM   rmb   0h3A          ; Reserved for status routine
           .org   PD.OPT
           .rmb   1          ; Device type
PD.UPC   ==   1          ; Case (0=both, 1=upper only)
PD.BSO   ==   1          ; Backspace (0=BSE, 1=BSE,SP,BSE)
PD.DLO   ==   1          ; Delete (0=BSE over line, 1=CRLF)
PD.EKO   ==   1          ; Echo (0=No Echo)
PD.ALF   ==   1          ; Auto linefeed (0=No auto LF)
PD.NUL   ==   1          ; End of Line null count
PD.PAU   ==   1          ; Page pause (0=No end of page pause)
PD.PAG   ==   1          ; Lines per page
PD.BSP   ==   1          ; Backspace character
PD.DEL   ==   1          ; Delete Line character
PD.EOR   ==   1          ; End of Record character (read only)
PD.EOF   ==   1          ; End of File character
PD.RPR   ==   1          ; Reprint Line character
PD.DUP   ==   1          ; Dup Last Line character
PD.PSC   ==   1          ; Pause character
PD.INT   ==   1          ; Keyboard interrupt character (CTRL-C)
PD.QUT   ==   1          ; Keyboard quit character (CTRL-E)
PD.BSE   ==   1          ; Backspace echo character
PD.OVF   ==   1          ; Line overflow character (BELL)
PD.PAR   ==   1          ; Parity code
PD.BAU   ==   1          ; ACIA baud rate (Color Computer)
PD.D2P   ==   2          ; Offset of DEV2 name
PD.XON   ==   1          ; ACIA X-ON character
PD.XOFF  ==   1          ; ACIA X-OFF character
OPTCNT     ==     .-PD.OPT   ; Total user settable options
PD.ERR   .rmb   1          ; Most recent I/O error status
PD.TBL   .rmb   2          ; Device table addr (copy)
PD.PLP   .rmb   2          ; Path Descriptor List Pointer
PD.PST   .rmb   1          ; Current path status


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
