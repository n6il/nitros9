********************************************************************
* SuperDesc - Super Driver Device Descriptor Template
*
* $Id$
*
* RBSuper Defined Offsets
*
* IT.STP (offset $14)
*  Bit Meaning
*  --- ---------------------------------------------------------------
*  7-0 HDB-DOS Drive Number (useful only if HDB-DOS bit set in IT.DNS)
* 
* IT.TYP (offset $15)
*  Bit Meaning
*  --- ---------------------------------------------------------------
*  7   Hard Disk:  1 = hard disk
*  6   Fudge LSN0: 0 = OS-9 disk, 1 = non-OS-9 disk
*  5   Undefined
*  4   Drive Size Query (1 = yes, 0 = no)
*  2-3 Undefined
*  0-1 Sector Size (0 = 256, 1 = 512, 2 = 1024, 3 = 2048)
* 
* IT.DNS (offset $16) for SCSI Low Level Driver
*  Bit Meaning
*  --- ---------------------------------------------------------------
*  5-7 SCSI Logical Unit Number of drive (0-7) (ignored if bit 3 is 1)
*  4   Turbo Mode:  1 = use accelerated handshaking, 0 = standard
*  3   HDB-DOS Partition Flag
*  0-2 SCSI ID of the drive or controller (0-7)
* 
* IT.DNS (offset $16) for IDE Low Level Driver
*  Bit Meaning
*  --- ---------------------------------------------------------------
*  4-7 Undefined
*  3   HDB-DOS Partition Flag
*  1-2 Undefined
*  0   IDE ID (0 = master, 1 = slave)
*
* Edt/Rev  YYYY/MM/DD  Modified by
* Comment
* ------------------------------------------------------------------
*   0      2004/04/08  Boisy G. Pitre
* Created.
*
*   0      2005/11/27  Boisy G. Pitre
* Added IT.MPI value to descriptor.
*
*   0      2005/12/08  Boisy G. Pitre
* Reserved two bits in IT.TYP for llscsi.

               NAM       SuperDesc
               TTL       Super Driver Device Descriptor Template

* Super Driver specific fields
ITDRV          SET       $00
ITSTP          SET       $00
ITTYP          SET       $81
ITDNS          SET       $00

ITSOFS1        SET       $00
ITSOFS2        SET       $00
ITSOFS3        SET       $00

* Geometry for an EZ-135
Sides          SET       $40
Cyls           SET       $007f
SectTrk        SET       $0020
SectTrk0       SET       $0020
Interlv        SET       $01
SAS            SET       $08

               IFP1      
               USE       defsfile
               USE       rbsuper.d
               IFNE      IDE
               USE       ide.d
               ELSE
               USE       scsi.d
               ENDC      
               ENDC      

tylg           SET       Devic+Objct
atrv           SET       ReEnt+rev
rev            SET       $09

               MOD       eom,name,tylg,atrv,mgrnam,drvnam

               IFNE      CDROM
               FCB       DIR.+SHARE.+PEXEC.+PREAD.+EXEC.+READ.
               ELSE      
               FCB       DIR.+SHARE.+PEXEC.+PREAD.+PWRIT.+EXEC.+UPDAT.
               ENDC      
               FCB       HW.PAGE             extended controller address
               FDB       SDAddr              physical controller address
               FCB       initsize-*-1        initilization table size
               FCB       DT.RBF              device type:0=scf,1=rbf,2=pipe,3=scf
               FCB       ITDRV               drive number
               FCB       ITSTP               step rate
               FCB       ITTYP               drive device type
               FCB       ITDNS               media density
               FDB       Cyls                number of cylinders (tracks)
               FCB       Sides               number of sides
               FCB       $01                 verify disk writes:0=on
               FDB       SectTrk             # of sectors per track
               FDB       SectTrk0            # of sectors per track (track 0)
               FCB       Interlv             sector interleave factor
               FCB       SAS                 minimum size of sector allocation
               FCB       0                   IT.TFM
               FDB       0                   IT.Exten
               FCB       0                   IT.STOff
* Super Driver specific additions to the device descriptor go here
* NOTE: These do NOT get copied into the path descriptor; they
*       cannot due to the fact that there is simply NO ROOM in
*       the path descriptor to do so.  The driver must access
*       these values directly from the descriptor.
               FCB       ITSOFS1             (IT.WPC)
               FCB       ITSOFS2             (IT.OFS)
               FCB       ITSOFS3
initsize       EQU       *
               FDB       lldrv               (IT.RWC)
               FCB       SDMPI               (IT.MPI)

               IFNE      NULL
name           FCC       /NULL/
               FCB       ITDRV+$B0
               ELSE      
               IFNE      DD
name           FCS       /DD/
               ELSE      
               IFNE      DRIVEWIRE
name           FCC       /X/
               IFNE      HB
               FCS       /H/
               ELSE      
               FCB       ITDRV+$B0
               ENDC      
               ELSE      
               IFNE      IDE
name           FCC       /I/
               IFNE      HB
               FCS       /H/
               ELSE      
               FCB       ITDRV+$B0
               ENDC      
               ELSE      
               IFNE      SD
name           FCC       /SD/
               IFNE      HB
               FCS       /H/
               ELSE      
               FCB       ITDRV+$B0
               ENDC      
               ELSE      
name           FCC       /S/
               IFNE      HB
               FCS       /H/
               ELSE      
               FCB       ITDRV+$B0
               ENDC      
               ENDC      
               ENDC      
               ENDC      
               ENDC      
               ENDC      

mgrnam         FCS       /RBF/
drvnam         FCS       /rbsuper/
lldrv          EQU       *
               IFNE      NULL
               FCS       /llnull/
               FCB       0
               ELSE      
               IFNE      DRIVEWIRE
               FCS       /lldw/
               FCB       0,0,0
               ELSE      
               IFNE      TC3+SB
               FCS       /lltc3/
               FCB       0,0
               ELSE      
               IFNE      KTLR
               FCS       /llktlr/
               FCB       0
               ELSE      
               IFNE      HDII+D4N1
               FCS       /lldisto/
               ELSE      
               IFNE      IDE
               FCS       /llide/
               FCB       0,0
               ELSE      
               IFNE      SD
               FCS       /llsd/
               FCB       0,0,0
               ENDC      
               ENDC      
               ENDC      
               ENDC      
               ENDC      
               ENDC      
               ENDC      


               EMOD      
eom            EQU       *
               END       