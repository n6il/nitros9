;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; module - Module Definitions
;
; $Id$
;
; Edt/Rev  YYYY/MM/DD  Modified by
; Comment
; ------------------------------------------------------------------
;          2004/05/17  Boisy G. Pitre
; Created.

           .title   Module Definitions

           .ifndef  Level
Level      ==       1
           .endif

           .ifgt    Level-1
MD$MPDAT   ==       0          ; Module DAT Image ptr
MD$MBSiz   ==       2          ; Memory Block size
MD$MPtr    ==       4          ; Module ptr
MD$Link    ==       6          ; Module Link count
MD$ESize   ==       8          ; Module Directory Entry size
           .else
MD$MPtr    ==       0          ; Module ptr
MD$Link    ==       2          ; Module Link count
MD$ESize   ==       4          ; Module Directory Entry size
           .endif

;
; Universal Module Offsets
;

M$ID       ==       0          ; ID Code
M$Size     ==       2          ; Module Size
M$Name     ==       4          ; Module Name
M$Type     ==       6          ; Type / Language
M$Revs     ==       7          ; Attributes / Revision Level
M$Parity   ==       8          ; Header Parity
M$IDSize   ==       9          ; Module ID Size
;
; Type-Dependent Module Offsets
;
; System, File Manager, Device Driver, Program Module
;
M$Exec     ==       9         ; Execution Entry Offset
;
; Device Driver, Program Module
;
M$Mem      ==       11         ; Stack Requirement
;
; Device Driver, Device Descriptor Module
;
M$Mode     ==       14         ; Device Driver Mode Capabilities

;
; Device Descriptor Module
;

M$FMgr     ==       9          ; File Manager Name Offset
M$PDev     ==       11         ; Device Driver Name Offset
;           ==       13         ; M$Mode (defined above)
M$Port     ==       14         ; Port Address
M$Opt      ==       17         ; Device Default Options
M$DTyp     ==       18         ; Device Type
IT.DTP     ==       M$DTyp     ; Descriptor type offset
;
; Configuration Module Entry Offsets
;

MaxMem     ==       9          ; Maximum Free Memory
PollCnt    ==       12         ; Entries in Interrupt Polling Table
DevCnt     ==       13         ; Entries in Device Table
InitStr    ==       14         ; Initial Module Name
SysStr     ==       16         ; System Device Name
StdStr     ==       18         ; Standard I/O Pathlist
BootStr    ==       20         ; Bootstrap Module name
ProtFlag   ==       22         ; Write protect enable flag

OSLevel    ==       23         ; OS level
OSVer      ==       24         ; OS version
OSMajor    ==       25         ; OS major
OSMinor    ==       26         ; OS minor
Feature1   ==       27         ; feature byte 1
Feature2   ==       28         ; feature byte 2
                               ; reserved for future use
           .ifgt  Level-1
; -- CC3IO area -- (NitrOS-9 Level 2 and above)
MonType    ==       36         ; Monitor type (0=CMP,1=RGB,2=MONO)
MouseInf   ==       37         ; Mouse resolution/Mouse port; was 1, major error RG.
KeyRptS    ==       39         ; Key repeat start constant
KeyRptD    ==       40         ; Key repeat delay constant
           .endif

; Feature1 byte definitions
CRCOn      ==       0b00000001  ; CRC checking on
CRCOff     ==       0b00000000  ; CRC checking off

; Module Field Definitions
;
; ID Field - First two bytes of a NitrOS-9 module
;
M$ID1      ==       0h87        ; Module ID code byte one
M$ID2      ==       0hCD        ; Module ID code byte two
M$ID12     ==       M$ID1*256+M$ID2

;
; Module Type/Language Field Masks
;
TypeMask   ==       0b11110000  ; Type Field
LangMask   ==       0b00001111  ; Language Field

;
; Module Type Values
;
Devic      ==       0hF0       ; Device Descriptor Module
Drivr      ==       0hE0       ; Physical Device Driver
FlMgr      ==       0hD0       ; File Manager
Systm      ==       0hC0       ; System Module
ShellSub   ==       0h50       ; Shell+ shell sub module
Data       ==       0h40       ; Data Module
Multi      ==       0h30       ; Multi-Module
Sbrtn      ==       0h20       ; Subroutine Module
Prgrm      ==       0h10       ; Program Module

;
; Module Language Values
;
Objct      ==       1          ; 6809 Object Code Module
ICode      ==       2          ; Basic09 I-code
PCode      ==       3          ; Pascal P-code
CCode      ==       4          ; C I-code
CblCode    ==       5          ; Cobol I-code
FrtnCode   ==       6          ; Fortran I-code
Obj6309    ==       7          ; 6309 object code

;
; Module Attributes / Revision byte
;
; Field Masks
;
AttrMask   ==       0b11110000  ; Attributes Field
RevsMask   ==       0b00001111  ; Revision Level Field

;
; Attribute Flags
;
ReEnt      ==       0b10000000  ; Re-Entrant Module
ModProt    ==       0b01000000  ; Gimix Module protect bit (0=protected, 1=write enable)
ModNat     ==       0b00100000  ; 6309 native mode attribute

;
; Device Type Values
;
; These values define various classes of devices, which are
; managed by a file manager module.  The Device Type is embedded
; in a device's device descriptor.
;
DT.SCF     ==       0          ; Sequential Character File Manager
DT.RBF     ==       1          ; Random Block File Manager
DT.Pipe    ==       2          ; Pipe File Manager
DT.SBF     ==       3          ; Sequential Block File Manager
DT.NFM     ==       4          ; Network File Manager
DT.CDFM    ==       5          ; CD-ROM File Manager


;
; CRC Result Constant
;
CRCCon1    ==       0h80
CRCCon23   ==       0h0FE3
