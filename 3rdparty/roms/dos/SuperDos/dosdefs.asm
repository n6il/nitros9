;
; SuperDos E6, Copyright (C) 1986 ???, Grosvenor.
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

SectorsPerTrack	EQU		$12		; Sectors per track

MaxDriveNo	EQU		$04		; Maximum valid drive no
MaxFilenameLen	EQU		$0E		; Max filename length, DriveNo:Filename.EXT

;
; Boot command related.
;

BootFirstSector	EQU		$03		; Boot sector is track 0 sector 3
BootLastSector	EQU		$12		; Last sector of boot
BootSignature	EQU		$4F53		; Boot signature 'OS'
BootLoadAddr	EQU		$2600		; Boot area load address.
BootEntryAddr	EQU		$2602		; Boot entry address

;
; Dir track related
;

DirPrimary	EQU		$14		; Primary dir track is track 20
DirBackup	EQU		$10		; Backup on track 16

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
DosBytesInDTA	EQU		$00F2		; Number of bytes in DTA (also used for tracks in DSKINIT).
DosNoBytesMove	EQU		$00F3		; Number of bytes to transfer to/from buffer
DosRecLenFlag	EQU		$00F4		; Record length flag, 00 don'r care $FF=do care
DosIRQTimeFlag	EQU		$00F5		; Dos IRQ timeout flag, 00=check for timeout
DosIOInProgress	EQU		$00f6		; I/O currently in progress flag 0x00 check for time out, Non-0x00 skip timeout check
DosSectorSeek	EQU		$00F8		; Sector currently seeking {SuperDos Rom}

DosAreaStart	EQU		$0600		; Start of RAM used by DOS
DosErrorCode	EQU		$0603		; Error code from DOS
DosTimeout	EQU		$0605		; Timeout count, timeout occurs when this location is decremented from 0x01 to 0x00 
DosHWMaskFF40	EQU		$0606		; Hardware command byte mask for FF40
DosHWMaskFF48	EQU		$0607		; hardware control mask for $ff48
DosVerifyFlag	EQU		$0608		; Verify flag, 00=no verify $FF=verify
DosErrorMask	EQU		$0609		; Error mask, ANDed with error code from WD
DosDefDriveNo	EQU		$060A		; Default drive number
DosAutoCurrent	EQU		$060D		; AUTO current line no
DosAutoInc	EQU		$060F		; AUTO line increment
DosRunLoadFlag	EQU		$0611		; Run/load flag $00=LOAD
DosFlFreadFlag	EQU		$0612		; Fread/FLread flag 00=fread, $FF=FLread
DosAutoFlag	EQU		$0613		; Auto flag, $FF=auto, $00=no auto
DosErrGotoFlag	EQU		$0614		; ERROR GOTO flag, 0x00 Off Non-0x00 On	
DosErrDestLine	EQU		$0615		; Error destination line
DosErrLineNo	EQU		$0617		; ERR line no
DosErrLast	EQU		$0619		; Last ERR error

Drv0Details	EQU		$061C		; Drive 0 details (6 bytes)
Drv1Details	EQU		$0622		; Drive 1 details (6 bytes)
Drv2Details	EQU		$0628		; Drive 2 details (6 bytes)
Drv3Details	EQU		$062E		; Drive 3 details (6 bytes)
DrvDeatailLen	EQU		$06		; Entries are 6 bytes long

; Offsets into drive details
DrvDetUseCnt	EQU		$05		; Usage/open file count ?

BuffCount	EQU		$04		; 4 disk buffers
BuffDetailSize	EQU		$07		; Buffer detail entries ar 7 bytes long
Buff1Details	EQU		$0634		; Disk buffer 1 details
Buff2Details	EQU		$063B		; Disk buffer 2 details
Buff3Details	EQU		$0642		; Disk buffer 3 details
Buff4Details	EQU		$0649		; Disk buffer 4 details


; Disk buffer details offsets for above table
BuffLSN		EQU		$00		; LSN number 
BuffFlag	EQU		$02		; Flag, tested for $55 and $FF (also set to $01)
BuffDrive	EQU		$03		; Drive no 1..4
BuffAge		EQU		$04		; Age of buffer since last use, 1=oldest..4=youngest
BuffAddr	EQU		$05		; Buffer address

;BuffFlag values

BuffFree	EQU		$00		; Disk buffer is free
BuffUnknown	EQU		$01		; Unknown flag set by SuperDosFindAndRead
BuffInUse	EQU		$55		; Buffer in use
BuffDirty	EQU		$FF		; Buffer has been modified, but not written to disk

DosCurDriveInfo EQU		$0650		; Dos current drive info
DosCurExtension	EQU		$0658		; Current extension, used in validation
DosCurDriveNo	EQU		$065B		; Current drive no


DosCurCount	EQU		$0660		; Current count, used in various places
DosCurLSN	EQU		$066F		; Current LSN, of current DIR sector being processed
DosCurDirBuff	EQU		$067F		; Pointer to the current Dire sector, Buffer def block
DosCurFileNo	EQU		$0682		; Current file number on disk, to get dir entry for


DosNewUSRTable	EQU		$0683		; New USR table, relocated from low ram

;Drive descriptor table
DosD0Online	EQU		$0697		; Drive 0 online flag
DosD1Online	EQU		$0698		; Drive 1 online flag
DosD2Online	EQU		$0699		; Drive 2 online flag
DosD3Online	EQU		$069A		; Drive 3 online flag

DosD0Track	EQU		$069B		; Drive 0 current track
DosD1Track	EQU		$069C		; Drive 1 current track
DosD2Track	EQU		$069D		; Drive 2 current track
DosD3Track	EQU		$069E		; Drive 3 current track

DosD0StepRate	EQU		$069F		; Drive 0 step rate
DosD1StepRate	EQU		$06A0		; Drive 1 step rate
DosD2StepRate	EQU		$06A1		; Drive 2 step rate
DosD3StepRate	EQU		$06A2		; Drive 3 step rate

DosD0Tracks	EQU		$06A3		; Tracks on disk in drive 0
DosD1Tracks	EQU		$06A4		; Tracks on disk in drive 1
DosD2Tracks	EQU		$06A5		; Tracks on disk in drive 2
DosD3Tracks	EQU		$06A6		; Tracks on disk in drive 3

DosD0SecTrack	EQU		$06A7		; Sectors per track drive 0
DosD1SecTrack	EQU		$06A8		; Sectors per track drive 1
DosD2SecTrack	EQU		$06A9		; Sectors per track drive 2
DosD3SecTrack	EQU		$06AA		; Sectors per track drive 3


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
DosFCB9Addr	EQU		$07D4		; File Control Block 9 Address 
DosFCBEnd	EQU		$07F3		; First byte beyond last FCB

DosDiskBuffBase EQU		$0800		; Base of Disk buffers

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
; $1D		1	File Number ? (used by DIR).

FCBFileName	EQU	$00	; Filename 
FCBExtension	EQU	$08	; Extension
FCBDrive	EQU	$0B	; Drive no
FCBFilePointer	EQU	$0C	; File Pointer 
FCBFileLen	EQU	$0F	; File Length
FCBDiskFileNo	EQU	$1D	; File number on disk, (dir entry no).

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
; Sync dir stack frame offsets
;
; These are offset from U on stack
;

SyncDrive	EQU	1	; Drive we are syncing
SyncSecNo	EQU	3	; Sector we are syncing

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

*******************************************
***** Directory Track realted defines *****
*******************************************

;
; Dir entry format(s).
;
; Dragon/Super dos directory entries can take one of 2 formats, they can be either a
; filename block, containing filename, attributes & 4 allocation entries, or they can
; be a continuation block, containing just allocation entries. 
; This is controled by the byte at offset $18, and the attributes.
;
; if AttrContinued = 0 then 
; 	the byte at offset $18, contains the number of number of bytes in the last sector (256 bytes = 0).
;
; if AttrContinued = 0 then 
; 	the byte at offset $18 controls the format of the entry :
;		if 0 then 
;			Entry is a filename entry
;		else
;			Entry is a continuation block.

; Filename block format 

DirEntAttr	EQU	$00		; Attributes (see above)
DirEntFilename	EQU	$01		; Filename, zero padded
DirEntExtension	EQU	$09		; Extension, zero padded
DirEntFnBlock1	EQU	$0C		; Allocation block #1
DirEntFnBlock2	EQU	$0F		; Allocation block #2
DirEntFnBlock3	EQU	$12		; Allocation block #3
DirEntFnBlock4	EQU	$15		; Allocation block #4
DirEntFlag	EQU	$18		; Filename/Continuation flag 0/nonzero

; Continuation block, DirEntAttr, and DirEntFlag, as above.

DirEntCntBlock1	EQU	$01		; Allocation block #1
DirEntCntBlock2	EQU	$04		; Allocation block #2
DirEntCntBlock3	EQU	$07		; Allocation block #3
DirEntCntBlock4	EQU	$0A		; Allocation block #4
DirEntCntBlock5	EQU	$0D		; Allocation block #5
DirEntCntBlock6	EQU	$10		; Allocation block #6
DirEntCntBlock7	EQU	$13		; Allocation block #7

;
; Allocation block format.
;

AllocLSN	EQU	$00		; Logical sector number of start of allocation
AllocCount	EQU	$02		; Count of number of sectors allocated.

;
; File Attributes
;

AttrDeleted	EQU	%10000000	; Deleted, may be reused
AttrContinued	EQU	%00100000	; Continuation entry, byte at $18 giver next entry no
AttrEndOfDir	EQU	%00001000	; End of directory, no more entries need to be scanned
AttrWriteProt	EQU	%00000010	; Write protect flag
AttrIsCont	EQU	%00000001	; This is a continuation entry.

DirEntPerSec	EQU	$0A		; Directory entries per sector

;
; Sector 0 on Dir track
;

BitmapPart1	EQU	$00		; Bitmap uses bytes $00..$FB on first sector
DirTracks	EQU	$FC		; Tracks on disk
DirSecPerTrk	EQU	$FD		; Sectors/track 18=Single sided, 36=Double sided
DirTracks1s	EQU	$FE		; complement of DirTracks (used to validate)
DirSecPerTrk1s	EQU	$FF		; Complement of DirSecPerTrk (used to validate)