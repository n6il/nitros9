********************************************************************
* SuperDesc - Super Driver Device Descriptor Template
*
*	edited 12/10/2013 Gene Heskett
*	see as noted within
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
*	The above IT.TYP has been superceded, see rbf.d for
*	currently used definitions for BOTH IT.TYP and IT.DNS
*	(should be removed eventually to prevent confusion)

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
* Again, for final reference, see rbf.d, the above is obsolete.
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
*
*  1/1 	2013/12/10 Gene heskett
* 	Notes to reference rbf.d for IT.TYP, IT.DNS above
*	Raise SAS default to 10, shortens FD.SEG usage
*--------------------------------------------------------------------
               NAM       SuperDesc
               TTL       Super Driver Device Descriptor Template

* Super Driver specific fields
*               IFEQ      ITDRV
		IFNDEF	ITDRV
ITDRV          SET       $00
               ENDC
*               IFEQ      ITSTP
		IFNDEF	ITSTP
ITSTP          SET       $00
               ENDC
*               IFEQ      ITTYP
		IFNDEF	ITTYP
ITTYP          SET       $81
               ENDC
*               IFEQ      ITDNS
		IFNDEF	ITDNS
ITDNS          SET       $00
               ENDC

*               IFEQ      ITSOFS1
		IFNDEF	ITSOFS1
ITSOFS1        SET       $00
               ENDC
*               IFEQ      ITSOFS2
		IFNDEF	ITSOFS2
ITSOFS2        SET       $00
               ENDC
*               IFEQ      ITSOFS3
		IFNDEF	ITSOFS3
ITSOFS3        SET       $00
               ENDC

		IFNE	CC3FPGA
Sides		SET	$01
Cyls		SET	$7100
SectTrk	SET	$0012
SectTrk0	SET	$0012
Interlv		SET	$01
SAS		SET	$08
		ELSE
* Geometry for an EZ-135
*               IFEQ      Sides
		IFNDEF	Sides
Sides          SET       $40
               ENDC
*               IFEQ      Cyls
		IFNDEF	Cyls
Cyls           SET       $007f
               ENDC
*               IFEQ      SectTrk
		IFNDEF	SectTrk
SectTrk        SET       $0020
               ENDC
*               IFEQ      SectTrk0
		IFNDEF	SectTrk0
SectTrk0       SET       $0020
               ENDC
*               IFEQ      Interlv
		IFNDEF	Interlv
Interlv        SET       $01
               ENDC
*               IFEQ      SAS
		IFNDEF	SAS
SAS            SET       $10
               ENDC
			   ENDC

               IFP1
               USE       defsfile
               USE       rbsuper.d
               IFNE      IDE
               USE       ide.d
               ELSE
               IFNE      TC3+KTLR+D4N1+HDII
               USE       scsi.d
               ELSE
               USE       cocosdc.d
               ENDC
               ENDC
               ENDC

		IFNE	CC3FPGA
SDAddr	SET	$FF64
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
	IFNE	CC3FPGA
	IFNE	ITDRV
	FCB	$03	(IT.WPC)
	FCB	$F9	(IT.OFS)
	ELSE
	FCB	ITSOFS1	(IT.WPC)
	FCB	ITSOFS2	(IT.OFS)
	ENDC
	ELSE
               FCB       ITSOFS1             (IT.WPC)
               FCB       ITSOFS2             (IT.OFS)
               ENDC
               FCB       ITSOFS3
initsize       EQU       *
               FDB       lldrv               (IT.RWC)
               FCB       SDMPI               (IT.MPI)

               IFNE      NULL
name           FCC       /NULL/
               FCB       '0+ITDRV+$80
               ELSE
               IFNE      DD
name           FCS       /DD/
               ELSE
               IFNE      DRIVEWIRE
name           FCC       /X/
               IFNE      HB
               FCS       /H/
               ELSE
               FCB       '0+ITDRV+$80
               ENDC
               ELSE
               IFNE      IDE
name           FCC       /I/
               IFNE      HB
               FCS       /H/
               ELSE
               FCB       '0+ITDNS+$80
               ENDC
               ELSE
               IFNE	COCOSDC+CC3FPGA
name           FCC       /SD/
               IFNE      HB
               FCS       /H/
               ELSE
               FCB       '0+ITDRV+$80
               ENDC
               ELSE
name           FCC       /S/
               IFNE      HB
               FCS       /H/
               ELSE
               FCB       '0+ITDRV+$80
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
               IFNE      COCOSDC
               FCS       /llcocosdc/
               FCB       0,0,0
               ELSE
               IFNE      CC3FPGA
               FCS       /llcoco3fpga/
               FCB       0,0,0
               ENDC
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
