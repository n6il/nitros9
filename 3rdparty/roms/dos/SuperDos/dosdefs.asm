;
; SuperDos E6, Copyright (C) 1986 ???, Compusense.
;
; Disassembled 2004-11-05, P.Harvey-Smith.
;
; 2005-10-10, forked ram vars into seperate include file.
;


		ifne		RSDos
; Disk command codes WD1793, WD1773, RSDos FDC carts.
WDCmdRestore	EQU		$00		; Restore to track 0
WDCmdSeek	EQU		$10		; Seek to track command
WDCmdReadSec	EQU		$80		; Read sector command
WDCmdWriteSec	EQU		$A0		; Write sector command
WDCmdReadAddr	EQU		$C0		; Read address mark
WDCmdForceInt	EQU		$D0		; Force inturrupt
WDCmdWriteTrack	EQU		$F4		; Write (format) track	
		else
; Disk command codes WD2797, Dragon Dos, Cumana Dos, Dragon Alpha/Professional, Dragon Beta
WDCmdRestore	EQU		$00		; Restore to track 0
WDCmdSeek	EQU		$10		; Seek to track command
WDCmdReadSec	EQU		$88		; Read sector command
WDCmdWriteSec	EQU		$A8		; Write sector command
WDCmdReadAddr	EQU		$C0		; Read address mark
WDCmdForceInt	EQU		$D0		; Force inturrupt
WDCmdWriteTrack	EQU		$F4		; Write (format) track
		endc
;
; Step rates.
;

StepRate6ms	EQU		$00		;  6ms step rate
StepRate12ms	EQU		$01		; 12ms step rate
StepRate20ms	EQU		$02		; 20ms step rate
StepRate30ms	EQU		$03		; 30ms step rate

SeepRateDefault	EQU		StepRate20ms	; Default

TrackPrecomp	EQU		$10		; Track to enable precomp if greater

;
; Boot command related.
;

BootFirstSector	EQU		$03		; Boot sector is track 0 sector 3
BootLastSector	EQU		$12		; Last sector of boot
BootSignature	EQU		$4F53		; Boot signature 'OS'
BootLoadAddr	EQU		$2600		; Boot area load address.
BootEntryAddr	EQU		$2602		; Boot entry address

;
; DOS Low memory variables
;

AutoFlag	EQU		$FF		; Auto re-number flag, if $613=this then auto enter basic lines

DosHWByte	EQU		$00EA		; Location of hardware IO byte
LastActiveDrv	EQU		$00EB		; Last active drive number
DskTrackNo	EQU		$00EC		; Disk track no
DskSectorNo	EQU		$00ED		; Disk sectror no
DiskBuffPtr	EQU		$00EE		; Disk buffer pointer

DosLastDrive	EQU		$00EB		; Active/last used drive number (1-4)
DosDiskError	EQU		$00F0		; Disk error status byte
DosCurrCtrlBlk	EQU		$00F1		; Current file control block (0..9) $FF=no files open
DosIOInProgress	EQU		$00f6		; I/O currently in progress flag 0x00 check for time out, Non-0x00 skip timeout check
DosSectorSeek	EQU		$00F8		; Sector currently seeking {SuperDos Rom}

DosAreaStart	EQU		$0600		; Start of RAM used by DOS
DosTimeout	EQU		$0605		; Timeout count, timeout occurs when this location is decremented from 0x01 to 0x00 
DosHWMaskFF40	EQU		$0606		; Hardware command byte mask for FF40
DosHWMaskFF48	EQU		$0607		; hardware control mask for $ff48
DosErrorMask	EQU		$0609		; Error mask, ANDed with error code from WD
DosDefDriveNo	EQU		$060A		; Default drive number
DosAutoCurrent	EQU		$060D		; AUTO current line no
DosAutoInc	EQU		$060F		; AUTO line increment
DosAutoFlag	EQU		$0613		; Auto flag, $FF=auto, $00=no auto
DosErrGotoFlag	EQU		$0614		; ERROR GOTO flag, 0x00 Off Non-0x00 On	
DosErrLineNo	EQU		$0617		; ERR line no
DosErrLast	EQU		$0619		; Last ERR error

Drv0Details	EQU		$061C		; Drive 0 details (6 bytes)
Drv1Details	EQU		$0622		; Drive 1 details (6 bytes)
Drv2Details	EQU		$0628		; Drive 2 details (6 bytes)
Drv3Details	EQU		$062E		; Drive 3 details (6 bytes)

Buff1Details	EQU		$0634		; Disk buffer 1 details
Buff2Details	EQU		$063B		; Disk buffer 2 details
Buff3Details	EQU		$0642		; Disk buffer 3 details
Buff4Details	EQU		$0649		; Disk buffer 4 details

DosD0Online	EQU		$0697		; Drive 0 online flag
DosD1Online	EQU		$0698		; Drive 1 online flag
DosD2Online	EQU		$0699		; Drive 2 online flag
DosD3Online	EQU		$069A		; Drive 3 online flag

DosD0Track	EQU		$069B		; Drive 0 current track
DosD1Track	EQU		$069C		; Drive 1 current track
DosD2Track	EQU		$069D		; Drive 2 current track
DosD3Track	EQU		$069E		; Drive 3 current track

DosD0StepRate	EQU		$069F		; Drive 0 step rate
DosD1StepRate	EQU		$0670		; Drive 1 step rate
DosD2StepRate	EQU		$0671		; Drive 2 step rate
DosD3StepRate	EQU		$0672		; Drive 3 step rate

DosDirSecStatus	EQU		$06AB		; Directory sector status $06ab-$06bc

DosFCB0Addr	EQU		$06BD		; File Control Block 0 Address 
DosFCB1Addr	EQU		$06DC		; File Control Block 1 Address
DosFCB2Addr	EQU		$06FB		; File Control Block 2 Address 
DosFCB3Addr	EQU		$071A		; File Control Block 3 Address 
DosFCB4Addr	EQU		$0739		; File Control Block 4 Address 
DosFCB5Addr	EQU		$0758		; File Control Block 5 Address 
DosFCB6Addr	EQU		$0777		; File Control Block 6 Address 
DosFCB7Addr	EQU		$0796		; File Control Block 7 Address 
DosFCB8Addr	EQU		$07B5		; File Control Block 8 Address 
DosFCB9Addr	EQU		$07C4		; File Control Block 9 Address 

DosFCBLength	EQU		$1F		; 31 bytes per FCB

;
; FCB structure may be :
;
; offset	len	purpose
; $00		8	Filename (zero padded)
; $08		3	Extension
; $0B		1	Drive number (1..4)
; $0C		3	File pointer
; $10		3	File len ?


;
; Backup command stack frame offsets
;
; These are offset from U on stack
;

BupSrcDrive	EQU	0	; Drive number of source 
BupSrcTrk	EQU	1	; $0001 Source track and sector ?
BupSrcSec	EQU	2	; Source sector no
;	3,U	$DF5A Error masks ???
BupSrcBuff	EQU	5	; Source sector buffer addr ?
BupDestDrive	EQU	7	; Drive number of dest ?
BupDestTrk	EQU	8	; $0001 Dest track and sector ?
BupDestSec	EQU	9	; Dest sector no
;	10,U	$DF6D Error masks ???
BupDestBuff	EQU	12	; Dest sector buffer addr ?
BupSecTrk	EQU	14	; Sector count per track to copy ?
BupAvailPages	EQU	15	; Pages available to buffer sectors

;
; Offset from X, which will point to BupSrcDrive, or BupDestDrive
; 

BupDrive	EQU	0	; Drive number  
BupTrk		EQU	1	; $00 track 
BupSec		EQU	2	; $01 sector
;		3,X	$DF5A ???
BupBuff		EQU	5	; Source sector buffer addr ?

SpinUpDelay	EQU	$D800	; Value for timeout loop


;
; Dos function codes used by hardware routine.
; 

DosFnRestore	EQU	$00	; Restore to track 0
DosFnSeek	EQU	$01	; Seek to a track
DosFnReadSec	EQU	$02	; Read a sector
DosFnWriteSec	EQU	$03	; Write a sector
DosFnWriteSec2	EQU	$04     ; not sure what difference is
DosFnWriteTrack	EQU	$05	; Write (format) track
DosFnReadAddr	EQU	$06	; Read address mark
DosFnReadSec2	EQU	$07	; Read first two bytes of a sector
