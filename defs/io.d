;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; io
;
; $Id$
;
; Edt/Rev  YYYY/MM/DD  Modified by
; Comment
; ------------------------------------------------------------------
;          2004/05/17  Boisy G. Pitre
; Started.

           .title   I/O Constant Definitions

           .ifndef  Level
Level      ==       1
           .endif

READ.      ==      0b00000001
WRITE.     ==      0b00000010
UPDAT.     ==      READ.+WRITE.
EXEC.      ==      0b00000100
PREAD.     ==      0b00001000
PWRIT.     ==      0b00010000
PEXEC.     ==      0b00100000
SHARE.     ==      0b01000000
DIR.       ==      0b10000000
ISIZ.      ==      0b00100000 


;
; Path Descriptor Offsets
;

PD.PD      ==     0          ; Path Number
PD.MOD     ==     1          ; Mode (Read/Write/Update)
PD.CNT     ==     2          ; Number of Open Images
PD.DEV     ==     3          ; Device Table Entry Address
PD.CPR     ==     5          ; Current Process
PD.RGS     ==     6          ; Caller's Register Stack
PD.BUF     ==     8          ; Buffer Address
PD.FST     ==     32         ; File Manager's Storage

PD.OPT     ==     PD.FST     ; PD GetSts(0) Options
PD.DTP     ==     32         ; Device Type
                             ; Path options are here
PDSIZE     ==     64

;
; Pathlist Special Symbols
;
PDELIM      ==     '/         ; Pathlist Name Separator
PDIR        ==     '.         ; Directory
PENTIR      ==     '@         ; Entire Device

;
; File Manager Entry Offsets
;
FMCREA     ==     0          ; Create (Open New) File
FMOPEN     ==     3          ; Open File
FMMDIR     ==     6          ; Make Directory
FMCDIR     ==     9          ; Change Directory
FMDLET     ==     12         ; Delete File
FMSEEK     ==     15         ; Position File
FMREAD     ==     18         ; Read from File
FMWRIT     ==     21         ; Write to File
FMRDLN     ==     24         ; ReadLn
FMWRLN     ==     27         ; WritLn
FMGSTA     ==     30         ; Get File Status
FMSSTA     ==     33         ; Set File Status
FMCLOS     ==     36         ; Close File

;
; Device Driver Entry Offsets
;
D$INIT     ==     0          ; Device Initialization
D$READ     ==     3          ; Read from Device
D$WRIT     ==     6          ; Write to Device
D$GSTA     ==     9          ; Get Device Status
D$PSTA     ==     12         ; Put Device Status
D$TERM     ==     15         ; Device Termination

;
; Device Table Format
;
V$DRIV     ==     0          ; Device Driver module
V$STAT     ==     2          ; Device Driver Static storage
V$DESC     ==     4          ; Device Descriptor module
V$FMGR     ==     6          ; File Manager module
V$USRS     ==     8          ; use count
           .ifgt  Level-1
V$DRIVEX   ==     9          ; Device Driver execution address
V$FMGREX   ==     11         ; File Manager execution address
DEVSIZ     ==     13
           .else
DEVSIZ     ==     9
           .endif

;
; Device Static Storage Offsets
;
V.PAGE     ==     0          ; Port Extended Address
V.PORT     ==     1          ; Device 'Base' Port Address
V.LPRC     ==     3          ; Last Active Process ID
V.BUSY     ==     4          ; Active Process ID (0=UnBusy)
V.WAKE     ==     5          ; Active PD if Driver MUST Wake-up
V.USER     ==     6          ; Driver Allocation Origin

;
; Interrupt Polling Table Format
;
Q$POLL     ==     0          ; Absolute Polling Address
Q$FLIP     ==     2          ; Flip (EOR) Byte ..normally Zero
Q$MASK     ==     3          ; Polling Mask (after Flip)
Q$SERV     ==     4          ; Absolute Service routine Address
Q$STAT     ==     6          ; Static Storage Address
Q$PRTY     ==     8          ; Priority (Low Numbers=Top Priority)
           .ifgt  Level-1
Q$MAP      ==     9          ; NitrOS-9 Level 2 and above
POLSIZ     ==     11
           .else
POLSIZ     ==     9
           .endif

;
; VIRQ packet format
;
Vi.Cnt     ==     0          ; count down counter
Vi.Rst     ==     2          ; reset value for counter
Vi.Stat    ==     4          ; status byte

Vi.IFlag   ==     0b00000001 ; status byte virq flag
