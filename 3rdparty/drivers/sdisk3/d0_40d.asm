 NAM D3
 TTL Disk Device Descriptor for SDISK3
*********************************
*
* Device Descriptor for D3 for SDISK3
*
*********************************

 IFP1
 use defsfile
 ENDC

Type SET Devic+Objct
Revs SET Reent+3

Step30 EQU 0
Step20 EQU 1
Step12 EQU 2
Step06 EQU 3

* MODULE HEADER AND FIXED INFORMATION
 MOD DescEnd,DescName,Type,Revs,DscMgr,DscDrv
 FCB DIR.+SHARE.+PREAD.+PWRIT.+UPDAT.+EXEC.+PEXEC.

 FCB $07 port bank
 FDB $FF40 port address

* USER CHANGEABLE SETTINGS
Drive SET 0 drive number (0-3)
DrvTyp SET $20 5" floppy drive (double density on track 0)
StpRat SET Step06 drive stepping rate code
Cyls SET 40 number of cylinders (tracks per side)
SecTrk SET 18 number of sectors per track
SecTr0 SET 18 number of sectors per track (track 0, side 0)
Density SET 0 48 tpi, MFM
Sides SET 2 number of sides (1 or 2)

* OPTION TABLE
 FCB OptEnd-*-1 number of bytes in option section below
 FCB DT.RBF device type = RBF
 FCB Drive drive number
 FCB StpRat step rate code
 FCB DrvTyp
 FCB Density
 FDB Cyls number of cylinders
 FCB Sides
 FCB 0 verify turned on
 FDB SecTrk
 FDB SecTr0
 FCB 3 sector interleave offset factor
 FCB 8 minimum sector allocation size
 FCB 0 (reserved)
 FDB 0 (reserved)
 FCB $10 sector/track offset (CoCo OS-9 disk format)
OptEnd EQU *

* NAME STRINGS
DescName FCB 'D,'0+Drive+$80
DscMgr FCS 'RBF'
DscDrv FCS 'SDisk3'

 EMOD

DescEnd EQU *

 END
