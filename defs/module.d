;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; module
;
; $Id$
;
; Edt/Rev  YYYY/MM/DD  Modified by
; Comment
; ------------------------------------------------------------------
;          2004/05/17  Boisy G. Pitre
; Started.

           .title   Module Definitions

           .area    MODULE (ABS)

           .org     0

           .ifgt    Level-1
MD$MPDAT:: .rmb     2          ; Module DAT Image ptr
MD$MBSiz:: .rmb     2          ; Memory Block size
           .endif
MD$MPtr::  .rmb     2          ; Module ptr
MD$Link::  .rmb     2          ; Module Link count
MD$ESize   ==       .          ; Module Directory Entry size

;
; Universal Module Offsets
;

           .org     0
M$ID::     .rmb     2          ; ID Code
M$Size::   .rmb     2          ; Module Size
M$Name::   .rmb     2          ; Module Name
M$Type::   .rmb     1          ; Type / Language
M$Revs::   .rmb     1          ; Attributes / Revision Level
M$Parity:: .rmb     1          ; Header Parity
M$IDSize   ==       .          ; Module ID Size
;
; Type-Dependent Module Offsets
;
; System, File Manager, Device Driver, Program Module
;
M$Exec::   .rmb     2          ; Execution Entry Offset
;
; Device Driver, Program Module
;
M$Mem::    .rmb     2          ; Stack Requirement
;
; Device Driver, Device Descriptor Module
;
M$Mode::   .rmb     1          ; Device Driver Mode Capabilities

;
; Device Descriptor Module
;

           .org     M$IDSize

M$FMgr::   .rmb     2          ; File Manager Name Offset
M$PDev::   .rmb     2          ; Device Driver Name Offset
           .rmb     1          ; M$Mode (defined above)
M$Port::   .rmb     3          ; Port Address
M$Opt::    .rmb     1          ; Device Default Options
M$DTyp::   .rmb     1          ; Device Type
IT.DTP     ==       M$DTyp     ; Descriptor type offset
;
; Configuration Module Entry Offsets
;

           .org     M$IDSize

MaxMem::   .rmb     3          ; Maximum Free Memory
PollCnt::  .rmb     1          ; Entries in Interrupt Polling Table
DevCnt::   .rmb     1          ; Entries in Device Table
InitStr::  .rmb     2          ; Initial Module Name
SysStr::   .rmb     2          ; System Device Name
StdStr::   .rmb     2          ; Standard I/O Pathlist
BootStr::  .rmb     2          ; Bootstrap Module name
ProtFlag:: .rmb     1          ; Write protect enable flag

OSLevel::  .rmb     1          ; OS level
OSVer::    .rmb     1          ; OS version
OSMajor::  .rmb     1          ; OS major
OSMinor::  .rmb     1          ; OS minor
Feature1:: .rmb     1          ; feature byte 1
Feature2:: .rmb     1          ; feature byte 2
           .rmb     8          ; reserved for future use
           .ifgt  Level-1
; -- CC3IO area -- (NitrOS-9 Level 2 and above)
MonType::  .rmb     1          ; Monitor type (0=CMP,1=RGB,2=MONO)
MouseInf:: .rmb     2          ; Mouse resolution/Mouse port; was 1, major error RG.
KeyRptS::  .rmb     1          ; Key repeat start constant
KeyRptD::  .rmb     1          ; Key repeat delay constant
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
CRCCon1    ==       $80
CRCCon23   ==       $0FE3
