*****************************************************************
*    NewDisk -- copyright 1985 by Dave Lewis.
*    Released to public domain January, 1986
*    Permission granted to copy and redistribute provided this
*      header is included with all copies.
*
* This program is intended to replace the CCDisk module in the
*   OS9Boot file on the OS-9 system disk. It is far more
*   versatile than the disk driver provided with Color Computer
*   OS-9, and is also slightly smaller (20 bytes or so).
*   Some of its features are:
*
*  -Uses the device descriptor to set head step rate. Original
*     had 30mS hard-coded in.
*  -Handles double-sided disks.
*  -Gets its track and side information from the disk so you
*     can read and write disks in any format the drive can
*     physically handle. You can use 40-track double sided disks
*     and still read/write 35-track single side disks.
*  -Performs some tests before attempting to use the disk.
*     The original CCDisk would hang the system if you tried to
*     access a drive without a disk in it (I know, I know - you
*     don't have to say `DUMMY!' - but it happens). You can
*     hang this one too but not as easily.
*  -An 80-track double sided disk holds 720Kbytes of data.
*     That's four and a half 35-track single siders.
*  -All of this stuff is completely transparent once NewDisk is
*     installed. NewDisk automatically senses the disk format
*     and conforms to it. (within limits -- don't use non-OS9
*     formats)
*
* One problem -- this program is not complete in itself. If you
*   want to boot from a double-sided disk you will need my
*   version of OS9Gen which will generate a double-sided system
*   disk. Don't try it with the stock version; you'll have to
*   reformat the disk to clean it up afterwards.
*****************************************************************
*           Copyright 1985 by Dave Lewis.
*
* UUCP address is loral!dml; in S. Cal. use ihnp4!sdcc3!loral
*
* I'm releasing this program to public domain. Copy it, share
*   it, but don't you DARE sell it! I worked hard on it. Include
*   this header with all copies.
*
* If you like this program, send me 5 bucks to encourage me to
*   write more stuff - or at least to release it. If you send
*   me 10 bucks I'll send you a good (Dysan) double side disk
*   formatted 35 track single side with both sourcecode and
*   executable binary files of the following:
*
*   - NewDisk -- single or double sided disks, any number of
*       tracks within reason, step rate set in device descriptor
*   - OS9Gen -- rewritten version that automatically senses for
*       single/double sided disk and puts all the boot data in
*       the right places. Also enters the kernel file in the
*       root directory, which makes Dcheck happy.
*   - Separate -- breaks up your bootfile into its component
*       modules for modification. Replace or remove any module
*       individually.
*   - Diskdescr -- sourcecode for an OS-9 disk device descriptor
*       with EQUates at the beginning for step rate, #tracks,
*       and single or double sided.
*   - Documentation and procedure files for installing all of
*       the above in most common system configurations.
*   - Other stuff I've written that you may find useful.
*
*   Send to:
*             Dave Lewis
*             4417 Idaho  Apt. 4
*             San Diego CA 92116
*****************************************************************
*
         NAM NewDisk
         TTL Improved OS-9 disk device driver module
*
*  Copyright 1985 by Dave Lewis
*                4417 Idaho apt. 4
*                San Diego, CA 92116
*  Released to public domain January, 1986
*
         USE defsfile
*
REV      EQU 1
TYPE     EQU DRIVR+OBJCT
ATTR     EQU REENT+REV
*
N.DRIVES EQU 3 Number of drives supported
DISKRUN  EQU $70 Disk run time after access
NMIVECT  EQU $109 NMI jump vector in RAM
COMDREG  EQU $FF48 1793 Command register (write)
STATREG  EQU $FF48 1793 Status register (read)
TRAKREG  EQU $FF49 1793 Track register
SECTREG  EQU $FF4A 1793 Sector register
DATAREG  EQU $FF4B 1793 Data register
*
         MOD SIZE,NAME,TYPE,ATTR,EXEC,STORG
         FCB $FF Mode byte -- all modes
NAME     FCS 'CCDisk' Still the same module name
         FCB 4 Version number
*
         RMB DRVBEG Storage common to all drives
TABL.ORG RMB DRVMEM Drive 0 parameter table
         RMB DRVMEM Drive 1 parameter table
         RMB DRVMEM Drive 2 parameter table
DRV.ACT  RMB 2 Active drive's table origin
DPRT.IMG RMB 1 Drive control port image byte
DRVS.RDY RMB 1 Drive ready flags
Q.SEEK   RMB 1 Same drive/track flag
STORG    EQU . Total storage required
*
*  Function dispatch vectors
*
EXEC     LBRA INIT Initialize variables
         LBRA READ Read one sector
         LBRA WRITE Write one sector
         LBRA RETNOERR GETSTA call is not used
         LBRA SETSTA Two oddball calls
         LBRA RETNOERR TERM call is not used
*
INIT     CLR >D.DSKTMR Zero disk rundown timer
         LDA #$D0 `Force interrupt' command
         STA >COMDREG
         LDA #$FF
         LDB #N.DRIVES Number of drives
         STB V.NDRV,U
         LEAX TABL.ORG,U Origin of first drive table
INI.TBL  STA DD.TOT+1,X Make total sectors nonzero
         STA V.TRAK,X Force first seek to track 0
         CLR DD.FMT,X Make it see a 1-sided disk
         LEAX DRVMEM,X Go to next drive table
         DECB Test for last table done
         BNE INI.TBL Loop if not finished
         LEAX NMI.SVC,PCR Get address of NMI routine
         STX >NMIVECT+1 NMI Jump vector operand
         LDA #$7E Jump opcode
         STA >NMIVECT NMI Jump vector opcode
         LDA >STATREG Clear interrupt condition
RETNOERR CLRB
         RTS
*
ERR.WPRT COMB Set carry flag
         LDB #E$WP Set error code
         RTS
ERR.SEEK COMB Set carry flag
         LDB #E$SEEK Set error code
         RTS
ERR.CRC  COMB Set carry flag
         LDB #E$CRC Set error code
         RTS
ERR.READ COMB Set carry flag
         LDB #E$READ Set error code
         RTS
*
* All disk controller commands exit via NMI. The service routine
*   returns control to the address on top of stack after registers
*   have been dumped off.
*
NMI.SVC  LEAS R$SIZE,S Dump registers off stack
         LDA >STATREG Get status condition
STAT.TST LSLA Test status register bit 7
         LBCS ERR.NRDY Status = Not Ready if set
         LSLA Test bit 6
         BCS ERR.WPRT Status = Write Protect if set
         LSLA Test bit 5
         LBCS ERR.WRT Status = Write Fault if set
         LSLA Test bit 4
         BCS ERR.SEEK Status = Record Not Found
         LSLA Test bit 3
         BCS ERR.CRC Status = CRC Error if set
         LSLA Test bit 2
         BCS ERR.READ Status = Lost Data if set
         CLRB No error if all 0
RETURN1  RTS
*
READ     TSTB If LSN is greater than 65,536
         BNE ERR.SECT   return a sector error
         LDA #$A4 Set retry control byte
         CMPX #0 Is it sector 0?
         BNE READ2 If not, just read the data
         BSR READ2 If sector 0, read it and
         BCS RETURN1   update drive table
         PSHS Y,X Save X and Y
         LDX PD.BUF,Y Point to data buffer
         LDY DRV.ACT,U Point to active drive's table
         LDB #DD.RES+1 Counter and offset pointer
SEC0LOOP LDA B,X Get byte from buffer
         STA B,Y Store in drive table
         DECB Decrement loop index
         BPL SEC0LOOP Loop until B < 0
         CLRB No error
         PULS X,Y,PC Pull and return
*
WRITE    TSTB If LSN is greater than 65,536
         BNE ERR.SECT   return a sector error
         LDA #$A4 Set retry control byte
         PSHS X,A,CC Save registers
         LBSR DSKSTART Start and select drive
         BCS EXIT.ERR Exit if error
REWRITE  LDX 2,S Get LSN off stack
         LBSR SEEK Position head at sector
         BCS RETRY.WR Try again if seek error
         BSR WRITE2 Write the sector
         BCS RETRY.WR Try again if write error
         TST PD.VFY,Y Check verify flag
         BNE EXIT.NER Exit without verify if off
         BSR VERIFY Verify sector just written
         BCC EXIT.NER Exit if no error
RETRY.WR LDA 1,S Get retry control byte
         LSRA Indicate another try
         STA 1,S Put updated byte back
         BEQ EXIT.ERR If zero, no more chances
         BCC REWRITE If bit 0 was 0, don't home
         BSR HOME Home and start all over
         BCC REWRITE If it homed OK, try again
EXIT.ERR PULS CC Restore interrupt masks
         COMA Set carry for error
         BRA CCDEXIT Finish exit
*
EXIT.NER PULS CC Restore interrupt masks
         CLRB Clear carry -- no error
CCDEXIT  LDA #8 Spindle motor control bit
         STA >DPORT Deselect disk drive
         PULS A,X,PC Pull and return
*
ERR.SECT COMB Set carry flag for error
         LDB #E$SECT Set error code
         RTS
*
READ2    PSHS X,A,CC CC is on top of stack
         LBSR DSKSTART Start drives and test
         BCS EXIT.ERR Abort if not ready
REREAD   LDX 2,S Recover LSN from stack
         LBSR SEEK Position head at sector
         BCS RETRY.RD Try again if seek error
         BSR READ3 Read the sector
         BCC EXIT.NER Read OK, return data
RETRY.RD LDA 1,S Get retry control byte
         LSRA Indicate another try
         STA 1,S Put updated byte back
         BEQ EXIT.ERR If it was all 0, quit
         BCC REREAD If bit 0 was 0, don't home
         BSR HOME Home and start all over
         BCC REREAD If it won't home, quit now
         BRA EXIT.ERR Exit with an error
*
WRITE2   LDA #$A2 `Write sector' command
         BSR RWCMDX Execute command
WAITWDRQ BITA >STATREG Wait until controller is
         BEQ WAITWDRQ   ready to transfer data
*
WRTLOOP  LDA ,X+ Get byte from data buffer
         STA >DATAREG Put it in data register
         STB >DPORT Activate DRQ halt function
         BRA WRTLOOP Loop until interrupted
*
VERIFY   LDA #$82 `Read sector' command
         BSR RWCMDX Execute command
WAITVDRQ BITA >STATREG Wait until controller is
         BEQ WAITVDRQ   ready to transfer data
*
VFYLOOP  LDA >DATAREG Get read data byte
         STB >DPORT Activate DRQ halt function
         CMPA ,X+ Compare to source data
         BEQ VFYLOOP Loop until interrupt if equal
*
         ANDB #$7F Mask off DRQ halt bit
         STB >DPORT Disable DRQ halt function
         LBSR KILLCOMD Abort read command
ERR.WRT  COMB Set carry flag
         LDB #E$WRITE Set error code
         RTS
*
SS.HOME  PSHS X,A,CC Set up stack for exit
         BSR HOME Home drive
         BRA SS.EXIT Skip to empty-stack exit
SS.EXIT4 LEAS 2,S Exit w/4 bytes on stack
SS.EXIT2 LEAS 2,S Exit w/2 bytes on stack
SS.EXIT  BCS EXIT.ERR Exit with error
         BRA EXIT.NER Exit with no error
*
HOME     LBSR DSKSTART Start and select drive
         BCS RETURN2 Return if error
         LDX DRV.ACT,U Point to active drive's table
         CLR V.TRAK,X Set track number to zero
         LDD #$43C Home, verify, allow 3 seconds
         LBSR STEPEX Execute stepping command
RETURN2  RTS
*
SETSTA   LDX PD.RGS,Y Point to caller's stack
         LDB R$B,X Get stacked B register
         CMPB #SS.RESET `Home' call
         BEQ SS.HOME Execute Home sequence
         CMPB #SS.WTRK `Write track' call, used by
         BEQ WRT.TRAK   the Format utility
         COMB If not one of those, it's an
         LDB #E$UNKSVC   illegal setsta call
         RTS
*
READ3    LDA #$82 Read sector command
         BSR RWCMDX Set up for sector read
WAITRDRQ BITA >STATREG Wait for controller to find
         BEQ WAITRDRQ   sector and start reading
*
READLOOP LDA >DATAREG Get data from controller
         STA ,X+ Store in sector buffer
         STB >DPORT Activate DRQ halt function
         BRA READLOOP Loop until interrupted
*
RWCMDX   LDX PD.BUF,Y Point to sector buffer
         LDB DPRT.IMG,U Do a side verify using the
         BITB #$40   DPORT image byte as a side
         BEQ WTKCMDX   select indicator
         ORA #8 Compare for side 1
WTKCMDX  STA >COMDREG Issue command to controller
         LDB #$A8 Set up DRQ halt function
         ORB DPRT.IMG,U OR in select bits
         LDA #2 DRQ bit in status register
         RTS
*
* Write an entire track -- used by Format
*
WRT.TRAK PSHS X,A,CC Set up stack for exit
         LDA R$U+1,X Get track number
         LDB R$Y+1,X Get side select bit
         LDX R$X,X Get track buffer address
         PSHS X,D Save 'em
         LBSR DSKSTART Start and select drive
         BCS SS.EXIT4 Exit if error
         PULS D Get track number and side
         LDX DRV.ACT,U Get drive table address
         BSR SID.PCMP Get drive ready to go
         TST Q.SEEK,U Different drive/track?
         BNE WRT.TRK2 If not, no need to seek
         LDD #$103C Seek, allow 3 seconds
         LBSR STEPEX Execute stepping command
         BCS SS.EXIT2 Exit if error
WRT.TRK2 PULS X Retrieve track buffer address
         LDA #$F0 `Write track' command
         BSR WTKCMDX Execute write track command
         LBSR WAITWDRQ Just like a Write Sector
         LBRA SS.EXIT Return to caller
*
SID.PCMP LSRB Bit 0 of B is set for
         BCC SIDE.ONE   side 2 of disk
         LDB DPRT.IMG,U Get drive control image byte
         ORB #$40 Side 2 select bit
         STB DPRT.IMG,U Activate side 2 select
SIDE.ONE CMPA PD.CYL+1,Y If track number exceeds #
         LBHI ERR.SECT   of tracks, return error
SD.PCMP2 LDB PD.DNS,Y Check track density of drive
         LSRB Shift bit 1 (TPI bit) into
         LSRB   carry flag (1 = 96 TPI)
         LDB #20 Precomp starts at track 21
         BCC FORTYTKS   on 48 TPI drives, track 41
         LSLB   on 96 TPI drives
FORTYTKS PSHS B Put B where it can be used
         CMPA ,S+ Does it need precomp?
         BLS NOPRECMP No, skip next step
         LDB DPRT.IMG,U Get drive control image byte
         ORB #$10 Write precompensation bit
         STB DPRT.IMG,U Activate precompensation
NOPRECMP LDB V.TRAK,X Get current track number
         STB >TRAKREG Update disk controller
         CMPA V.TRAK,X Same track as last access?
         BEQ SAMETRAK If so, leave flag set
         CLR Q.SEEK,U Clear same drive/track flag
SAMETRAK STA V.TRAK,X Update track number
         STA >DATAREG Set destination track
         LDB DPRT.IMG,U Get disk control byte
         STB >DPORT Update control port
         RTS
*
* Translate logical sector number (LSN) to physical side, track
*   and sector, activate write precompensation if necessary,
*   and execute seek command. If any error occurs, return error
*   number to calling routine.
*
SEEK     LDD PD.SCT,Y Get #sectors per track
         PSHS X,D Put LSN and sec/trk on stack
         LDD 2,S Get LSN off stack
         CLR 2,S Set up track counter
FINDTRAK INC 2,S Increment track counter
         SUBD ,S Subtract sectors in one track
         BPL FINDTRAK Loop if LSN still positive
         ADDD ,S++ Restore sector number
         INCB Sector numbers start at 1
         STB 1,S Save sector number
         PULS A Get track number
         DECA Compensate for extra count
         LDX DRV.ACT,U Get active table address
         LDB DD.FMT,X See if disk is double sided
         BITB #1 Test #sides bit
         BEQ SEEK2 If one-sided, skip next step
         LSRA Divide track number by 2
         ROLB Put remainder in B bit 0
SEEK2    BSR SID.PCMP Set up precomp and side sel
         PULS B Get sector number
         STB >SECTREG Set destination sector
         TST Q.SEEK,U Same drive/track?
         BNE COMDEXIT If so, no need to seek
         LDD #$143C Seek with verify, allow 3 sec
         BRA STEPEX Execute stepping command
*
* Execute command in A and wait for it to finish. If it runs
*   normally or aborts with an error it will exit through NMI;
*   if it takes an unreasonable amount of time this routine
*   will abort it and set the carry flag. If the command
*   involves head movement, use STEPEX to set step rate.
* On entry, A contains command code and B contains time limit
*   in 50-millisecond increments.
*
STEPEX   PSHS A Put raw command on stack
         LDA PD.STP,Y Get step rate code
         EORA #3 Convert to 1793's format
         ORA ,S+ Combine with raw command
COMDEX   STA >COMDREG Execute command in A
         CLRA Clear carry flag
         BSR WAIT50MS Wait while command runs
         BCC COMDEXIT Exit if no error
         CMPB #E$NOTRDY Test for the three valid
         BEQ KCEXIT   error codes for a Type 1
         CMPB #E$SEEK   disk controller command --
         BEQ KCEXIT   home, seek or force int-
         CMPB #E$CRC   errupt -- and return the
         BEQ KCEXIT   errors
COMDEXIT CLRB No error, clear carry
         RTS
*
WAIT50MS LDX #$15D8 Almost exactly 50 mSec delay
WAITIMER LEAX -1,X Wait specified time for disk
         BNE WAITIMER   controller to issue NMI
         DECB   signaling command completed
         BNE WAIT50MS   or aborted with error
KILLCOMD LDA #$D0 Force interrupt, NMI disabled
         STA >COMDREG Abort command in progress
ERR.NRDY LDB #E$NOTRDY Set error code
KCEXIT   COMA Set carry to flag error
         RTS
*
*
* Get selected drive ready to read or write. If spindle motors are
*   stopped, start them and wait until they're up to operating
*   speed. Check drive number and select drive if number is valid.
*   Monitor index pulses to ensure door is closed, disk inserted
*   and turning, etc. Return appropriate error code if any of
*   these conditions can't be met.
*
DSKSTART TST >D.DSKTMR Are drives already running?
         BNE SPINRDY If so, no need to wait
         CLR DRVS.RDY,U No drives are ready
         LDD #$80B Motor on, wait 550 mSec
         STA >DPORT Start spindle motors
         BSR WAIT50MS Wait for motors to start
SPINRDY  LDA PD.DRV,Y Get drive number
         CMPA V.NDRV,U Test for valid drive #
         BHS ERR.UNIT Return error if not
         LEAX TABL.ORG,U Compute address of active
         LDB #DRVMEM   drive's parameter table
         MUL   TABL.ORG + (D# * tablesize)
         LEAX D,X Add computed offset to origin
         LDA PD.DRV,Y Get drive number again
         LSLA Set corresponding drv select
         BNE NOTDRV0   bit -- 1 for D1, 2 for D2
         INCA Set bit 0 for drive 0
NOTDRV0  TFR A,B Copy select bit
         ORB #$28 Enable double density
         ORCC #INTMASKS Disable IRQ and FIRQ
         STB >DPORT Enable drive
         STB DPRT.IMG,U Set image byte
         CLR Q.SEEK,U Clear same drive/track flag
         CMPX DRV.ACT,U Is this the same drive?
         BNE NEWDRIVE If not, leave flag zeroed
         LDB #$FF Indicate successive accesses
         STB Q.SEEK,U   to the same drive.
NEWDRIVE STX DRV.ACT,U Store table address
         BITA DRVS.RDY,U Has this drive been ready
         BNE DRVRDY   since the motors started?
         PSHS A Save drive select bit
         LDD #$D405 Force int, allow 250 mSec
         BSR COMDEX Look for index pulse
         PSHS CC Save carry flag condition
         BSR KILLCOMD Clear index-pulse NMI state
         PULS CC,A Restore carry flag and A
         BCS RETURN3 Error if no index pulse
DRVRDY   ORA DRVS.RDY,U Set corresponding drive
         STA DRVS.RDY,U   ready flag
         LDA #DISKRUN Restart disk rundown timer
         STA >D.DSKTMR
         LDA >STATREG Clear interrupt condition
         CLRB Return no error
RETURN3  RTS
*
ERR.UNIT COMB Set carry flag
         LDB E$UNIT Set error code
         RTS
*
         EMOD CRC bytes
SIZE     EQU *
         END
