;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; syscall
;
; $Id$
;
; Edt/Rev  YYYY/MM/DD  Modified by
; Comment
; ------------------------------------------------------------------
;          2004/07/02  Boisy G. Pitre
; Started

           .title   NitrOS-9 System Definitions

           .area    SYS (ABS)

           .ifndef  Level
Level      ==       1
           .endif

; Common definitions
true       ==     1
false      ==     0

           .page
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; System Service Request Code Definitions
;
           .org   0
F$Link::   .rmb   1          ; Link to Module
F$Load::   .rmb   1          ; Load Module from File
F$UnLink:: .rmb   1          ; Unlink Module
F$Fork::   .rmb   1          ; Start New Process
F$Wait::   .rmb   1          ; Wait for Child Process to Die
F$Chain::  .rmb   1          ; Chain Process to New Module
F$Exit::   .rmb   1          ; Terminate Process
F$Mem::    .rmb   1          ; Set Memory Size
F$Send::   .rmb   1          ; Send Signal to Process
F$Icpt::   .rmb   1          ; Set Signal Intercept
F$Sleep::  .rmb   1          ; Suspend Process
F$SSpd::   .rmb   1          ; Suspend Process
F$ID::     .rmb   1          ; Return Process ID
F$SPrior:: .rmb   1          ; Set Process Priority
F$SSWI::   .rmb   1          ; Set Software Interrupt
F$PErr::   .rmb   1          ; Print Error
F$PrsNam:: .rmb   1          ; Parse Pathlist Name
F$CmpNam:: .rmb   1          ; Compare Two Names
F$SchBit:: .rmb   1          ; Search Bit Map
F$AllBit:: .rmb   1          ; Allocate in Bit Map
F$DelBit:: .rmb   1          ; Deallocate in Bit Map
F$Time::   .rmb   1          ; Get Current Time
F$STime::  .rmb   1          ; Set Current Time
F$CRC::    .rmb   1          ; Generate CRC

           .ifgt  Level-1

; NitrOS-9 Level 2 system calls
F$GPrDsc:: .rmb   1          ; Get Process Descriptor copy
F$GBlkMp:: .rmb   1          ; Get System Block Map copy
F$GModDr:: .rmb   1          ; Get Module Directory copy
F$CpyMem:: .rmb   1          ; Copy External Memory
F$SUser::  .rmb   1          ; Set User ID number
F$UnLoad:: .rmb   1          ; Unlink Module by name
F$Alarm::  .rmb   1          ; Color Computer 3 Alarm Call
           .rmb   2          ; Reserved - For overlap of other systems
F$NMLink:: .rmb   1          ; Color Computer 3 Non-Mapping Link
F$NMLoad:: .rmb   1          ; Color Computer 3 Non-Mapping Load
           .org   0h25
F$TPS::    .rmb   1          ; Return System's Ticks Per Second
F$TimAlm:: .rmb   1          ; CoCo individual process alarm call

           .endif

           .org   0h27       ; Beginning of System Reserved Calls
F$VIRQ::   .rmb   1          ; Install/Delete Virtual IRQ
F$SRqMem:: .rmb   1          ; System Memory Request
F$SRtMem:: .rmb   1          ; System Memory Return
F$IRQ::    .rmb   1          ; Enter IRQ Polling Table
F$IOQu::   .rmb   1          ; Enter I/O Queue
F$AProc::  .rmb   1          ; Enter Active Process Queue
F$NProc::  .rmb   1          ; Start Next Process
F$VModul:: .rmb   1          ; Validate Module
F$Find64:: .rmb   1          ; Find Process/Path Descriptor
F$All64::  .rmb   1          ; Allocate Process/Path Descriptor
F$Ret64::  .rmb   1          ; Return Process/Path Descriptor
F$SSvc::   .rmb   1          ; Service Request Table Initialization
F$IODel::  .rmb   1          ; Delete I/O Module

           .ifgt  Level-1

F$SLink::  .rmb   1          ; System Link
F$Boot::   .rmb   1          ; Bootstrap System
F$BtMem::  .rmb   1          ; Bootstrap Memory Request
F$GProcP:: .rmb   1          ; Get Process ptr
F$Move::   .rmb   1          ; Move Data (low bound first)
F$AllRAM:: .rmb   1          ; Allocate RAM blocks
F$AllImg:: .rmb   1          ; Allocate Image RAM blocks
F$DelImg:: .rmb   1          ; Deallocate Image RAM blocks
F$SetImg:: .rmb   1          ; Set Process DAT Image
F$FreeLB:: .rmb   1          ; Get Free Low Block
F$FreeHB:: .rmb   1          ; Get Free High Block
F$AllTsk:: .rmb   1          ; Allocate Process Task number
F$DelTsk:: .rmb   1          ; Deallocate Process Task number
F$SetTsk:: .rmb   1          ; Set Process Task DAT registers
F$ResTsk:: .rmb   1          ; Reserve Task number
F$RelTsk:: .rmb   1          ; Release Task number
F$DATLog:: .rmb   1          ; Convert DAT Block/Offset to Logical
F$DATTmp:: .rmb   1          ; Make temporary DAT image (Obsolete)
F$LDAXY::  .rmb   1          ; Load A [X,[Y]]
F$LDAXYP:: .rmb   1          ; Load A [X+,[Y]]
F$LDDDXY:: .rmb   1          ; Load D [D+X,[Y]]
F$LDABX::  .rmb   1          ; Load A from 0,X in task B
F$STABX::  .rmb   1          ; Store A at 0,X in task B
F$AllPrc:: .rmb   1          ; Allocate Process Descriptor
F$DelPrc:: .rmb   1          ; Deallocate Process Descriptor
F$ELink::  .rmb   1          ; Link using Module Directory Entry
F$FModul:: .rmb   1          ; Find Module Directory Entry
F$MapBlk:: .rmb   1          ; Map Specific Block
F$ClrBlk:: .rmb   1          ; Clear Specific Block
F$DelRAM:: .rmb   1          ; Deallocate RAM blocks
F$GCMDir:: .rmb   1          ; Pack module directory
F$AlHRAM:: .rmb   1          ; Allocate HIGH RAM Blocks

; Alan DeKok additions
; F$ReBoot is unimplemented at this time
F$ReBoot:: .rmb   1          ; Reboot machine (reload OS9Boot) or drop to RSDOS
F$CRCMod:: .rmb   1          ; CRC mode, toggle or report current status
F$XTime::  .rmb   1          ; Get Extended time packet from RTC (fractions of second)
F$VBlock:: .rmb   1          ; Verify modules in a block of memory, add to module directory

           .endif

;
; Numbers $70 through $7F are reserved for user definitions
;
           .org   0h70

	   .iflt  Level-2

	   .rmb   16         ; Reserved for user definition

           .else

F$RegDmp:: .rmb   1          ; Ron Lammardo's debugging register dump
F$NVRAM::  .rmb   1          ; Non Volatile RAM (RTC battery backed static) read/write
                             ; Reserved for user definitions

           .endif

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; I/O Service Request Code Definitions
;
           .org   0h80
I$Attach:: .rmb   1          ; Attach I/O Device
I$Detach:: .rmb   1          ; Detach I/O Device
I$Dup::    .rmb   1          ; Duplicate Path
I$Create:: .rmb   1          ; Create New File
I$Open::   .rmb   1          ; Open Existing File
I$MakDir:: .rmb   1          ; Make Directory File
I$ChgDir:: .rmb   1          ; Change Default Directory
I$Delete:: .rmb   1          ; Delete File
I$Seek::   .rmb   1          ; Change Current Position
I$Read::   .rmb   1          ; Read Data
I$Write::  .rmb   1          ; Write Data
I$ReadLn:: .rmb   1          ; Read Line of ASCII Data
I$WritLn:: .rmb   1          ; Write Line of ASCII Data
I$GetStt:: .rmb   1          ; Get Path Status
I$SetStt:: .rmb   1          ; Set Path Status
I$Close::  .rmb   1          ; Close Path
I$DeletX:: .rmb   1          ; Delete from current exec dir
