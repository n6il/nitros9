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

         .area    IO (ABS)



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
           .org   0
PD.PD::    .rmb   1          ; Path Number
PD.MOD::   .rmb   1          ; Mode (Read/Write/Update)
PD.CNT::   .rmb   1          ; Number of Open Images
PD.DEV::   .rmb   2          ; Device Table Entry Address
PD.CPR::   .rmb   1          ; Current Process
PD.RGS::   .rmb   2          ; Caller's Register Stack
PD.BUF::   .rmb   2          ; Buffer Address
PD.FST     ==     .          ; File Manager's Storage
           .org   32
PD.OPT     ==     .          ; PD GetSts(0) Options
PD.DTP::   .rmb   1          ; Device Type
                             ; Path options
           .org   64
PDSIZE     ==     .

;
; Pathlist Special Symbols
;
PDELIM      ==     '/         ; Pathlist Name Separator
PDIR        ==     '.         ; Directory
PENTIR      ==     '@         ; Entire Device

;
; File Manager Entry Offsets
;
           .org   0
FMCREA::   .rmb   3          ; Create (Open New) File
FMOPEN::   .rmb   3          ; Open File
FMMDIR::   .rmb   3          ; Make Directory
FMCDIR::   .rmb   3          ; Change Directory
FMDLET::   .rmb   3          ; Delete File
FMSEEK::   .rmb   3          ; Position File
FMREAD::   .rmb   3          ; Read from File
FMWRIT::   .rmb   3          ; Write to File
FMRDLN::   .rmb   3          ; ReadLn
FMWRLN::   .rmb   3          ; WritLn
FMGSTA::   .rmb   3          ; Get File Status
FMSSTA::   .rmb   3          ; Set File Status
FMCLOS::   .rmb   3          ; Close File

;
; Device Driver Entry Offsets
;
           .org   0
D$INIT::   .rmb   3          ; Device Initialization
D$READ::   .rmb   3          ; Read from Device
D$WRIT::   .rmb   3          ; Write to Device
D$GSTA::   .rmb   3          ; Get Device Status
D$PSTA::   .rmb   3          ; Put Device Status
D$TERM::   .rmb   3          ; Device Termination

;
; Device Table Format
;
           .org   0
V$DRIV::   .rmb   2          ; Device Driver module
V$STAT::   .rmb   2          ; Device Driver Static storage
V$DESC::   .rmb   2          ; Device Descriptor module
V$FMGR::   .rmb   2          ; File Manager module
V$USRS::   .rmb   1          ; use count
           .ifgt  Level-1
V$DRIVEX:: .rmb   2          ; Device Driver execution address
V$FMGREX:: .rmb   2          ; File Manager execution address
           .endif
DEVSIZ     ==     .

;
; Device Static Storage Offsets
;
           .org   0
V.PAGE::   .rmb   1          ; Port Extended Address
V.PORT::   .rmb   2          ; Device 'Base' Port Address
V.LPRC::   .rmb   1          ; Last Active Process ID
V.BUSY::   .rmb   1          ; Active Process ID (0=UnBusy)
V.WAKE::   .rmb   1          ; Active PD if Driver MUST Wake-up
V.USER     ==     .          ; Driver Allocation Origin

;
; Interrupt Polling Table Format
;
           .org   0
Q$POLL::   .rmb   2          ; Absolute Polling Address
Q$FLIP::   .rmb   1          ; Flip (EOR) Byte ..normally Zero
Q$MASK::   .rmb   1          ; Polling Mask (after Flip)
Q$SERV::   .rmb   2          ; Absolute Service routine Address
Q$STAT::   .rmb   2          ; Static Storage Address
Q$PRTY::   .rmb   1          ; Priority (Low Numbers=Top Priority)
           .ifgt  Level-1
Q$MAP::    .rmb   2          ; NitrOS-9 Level 2 and above
           .endif
POLSIZ     ==     .

;
; VIRQ packet format
;
           .org   0
Vi.Cnt::   .rmb   2          ; count down counter
Vi.Rst::   .rmb   2          ; reset value for counter
Vi.Stat::  .rmb   1          ; status byte

Vi.IFlag   ==     0b00000001 ; status byte virq flag
