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
F$Link     ==   0h00          ; Link to Module
F$Load     ==   0h01          ; Load Module from File
F$UnLink   ==   0h02          ; Unlink Module
F$Fork     ==   0h03          ; Start New Process
F$Wait     ==   0h04          ; Wait for Child Process to Die
F$Chain    ==   0h05          ; Chain Process to New Module
F$Exit     ==   0h06          ; Terminate Process
F$Mem      ==   0h07          ; Set Memory Size
F$Send     ==   0h08          ; Send Signal to Process
F$Icpt     ==   0h09          ; Set Signal Intercept
F$Sleep    ==   0h0A          ; Suspend Process
F$SSpd     ==   0h0B          ; Suspend Process
F$ID       ==   0h0C          ; Return Process ID
F$SPrior   ==   0h0D          ; Set Process Priority
F$SSWI     ==   0h0E          ; Set Software Interrupt
F$PErr     ==   0h0F          ; Print Error
F$PrsNam   ==   0h10          ; Parse Pathlist Name
F$CmpNam   ==   0h11          ; Compare Two Names
F$SchBit   ==   0h12          ; Search Bit Map
F$AllBit   ==   0h13          ; Allocate in Bit Map
F$DelBit   ==   0h14          ; Deallocate in Bit Map
F$Time     ==   0h15          ; Get Current Time
F$STime    ==   0h16          ; Set Current Time
F$CRC      ==   0h17          ; Generate CRC

           .ifgt  Level-1

; NitrOS-9 Level 2 system calls
F$GPrDsc   ==   0h18          ; Get Process Descriptor copy
F$GBlkMp   ==   0h19          ; Get System Block Map copy
F$GModDr   ==   0h1A          ; Get Module Directory copy
F$CpyMem   ==   0h1B          ; Copy External Memory
F$SUser    ==   0h1C          ; Set User ID number
F$UnLoad   ==   0h1D          ; Unlink Module by name
F$Alarm    ==   0h1E          ; Color Computer 3 Alarm Call

F$NMLink   ==   0h21          ; Color Computer 3 Non-Mapping Link
F$NMLoad   ==   0h22          ; Color Computer 3 Non-Mapping Load

F$TPS      ==   0h25          ; Return System's Ticks Per Second
F$TimAlm   ==   0h26          ; CoCo individual process alarm call

           .endif

; Beginning of System Reserved Calls
F$VIRQ     ==   0h27          ; Install/Delete Virtual IRQ
F$SRqMem   ==   0h28          ; System Memory Request
F$SRtMem   ==   0h29          ; System Memory Return
F$IRQ      ==   0h2A          ; Enter IRQ Polling Table
F$IOQu     ==   0h2B          ; Enter I/O Queue
F$AProc    ==   0h2C          ; Enter Active Process Queue
F$NProc    ==   0h2D          ; Start Next Process
F$VModul   ==   0h2E          ; Validate Module
F$Find64   ==   0h2F          ; Find Process/Path Descriptor
F$All64    ==   0h30          ; Allocate Process/Path Descriptor
F$Ret64    ==   0h31          ; Return Process/Path Descriptor
F$SSvc     ==   0h32          ; Service Request Table Initialization
F$IODel    ==   0h33          ; Delete I/O Module

           .ifgt  Level-1

F$SLink    ==   0h34          ; System Link
F$Boot     ==   0h35          ; Bootstrap System
F$BtMem    ==   0h36          ; Bootstrap Memory Request
F$GProcP   ==   0h37          ; Get Process ptr
F$Move     ==   0h38          ; Move Data (low bound first)
F$AllRAM   ==   0h39          ; Allocate RAM blocks
F$AllImg   ==   0h3A          ; Allocate Image RAM blocks
F$DelImg   ==   0h3B          ; Deallocate Image RAM blocks
F$SetImg   ==   0h3C          ; Set Process DAT Image
F$FreeLB   ==   0h3D          ; Get Free Low Block
F$FreeHB   ==   0h3E          ; Get Free High Block
F$AllTsk   ==   0h3F          ; Allocate Process Task number
F$DelTsk   ==   0h40          ; Deallocate Process Task number
F$SetTsk   ==   0h41          ; Set Process Task DAT registers
F$ResTsk   ==   0h42          ; Reserve Task number
F$RelTsk   ==   0h43          ; Release Task number
F$DATLog   ==   0h44          ; Convert DAT Block/Offset to Logical
F$DATTmp   ==   0h45          ; Make temporary DAT image (Obsolete)
F$LDAXY    ==   0h46          ; Load A [X,[Y]]
F$LDAXYP   ==   0h47          ; Load A [X+,[Y]]
F$LDDDXY   ==   0h48          ; Load D [D+X,[Y]]
F$LDABX    ==   0h49          ; Load A from 0,X in task B
F$STABX    ==   0h4A          ; Store A at 0,X in task B
F$AllPrc   ==   0h4B          ; Allocate Process Descriptor
F$DelPrc   ==   0h4C          ; Deallocate Process Descriptor
F$ELink    ==   0h4D          ; Link using Module Directory Entry
F$FModul   ==   0h4E          ; Find Module Directory Entry
F$MapBlk   ==   0h4F          ; Map Specific Block
F$ClrBlk   ==   0h50          ; Clear Specific Block
F$DelRAM   ==   0h51          ; Deallocate RAM blocks
F$GCMDir   ==   0hh52          ; Pack module directory
F$AlHRAM   ==   0h53          ; Allocate HIGH RAM Blocks

; Alan DeKok additions
; F$ReBoot is unimplemented at this time
F$ReBoot   ==   0h54          ; Reboot machine (reload OS9Boot) or drop to RSDOS
F$CRCMod   ==   0h55          ; CRC mode, toggle or report current status
F$XTime    ==   0h56          ; Get Extended time packet from RTC (fractions of second)
F$VBlock   ==   0h57          ; Verify modules in a block of memory, add to module directory

           .endif

;
; Numbers $70 through $7F are reserved for user definitions
;
;           .org   0h70

	   .iflt  Level-2

;	   .rmb   16         ; Reserved for user definition

           .else

F$RegDmp   ==   0h70		; Ron Lammardo's debugging register dump
F$NVRAM    ==   0h71          ; Non Volatile RAM (RTC battery backed static) read/write
                             ; Reserved for user definitions

           .endif
