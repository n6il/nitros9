include ../../../Makefile.rules

DEPENDS		= ./Makefile

DISK_1		= kq3_d1.dsk
DISK_2		= kq3_d2.dsk
DISK_3		= kq3_d3.dsk
CMDS		= sierra mnln scrn shdw tocgen
MD		= $(LEVEL2)/MODULES

# We make our own bootfile and kernel track
KERNEL		= $(MD)/rel $(MD)/boot_1773 $(MD)/os9p1
OS9BOOT		= $(MD)/os9p2 $(MD)/ioman $(MD)/init \
		$(MD)/rbf.mn \
		$(MD)/cc3disk.dr $(MD)/ddd0_40d.dd \
		$(MD)/scf.mn $(MD)/cc3io.dr \
		$(MD)/keydrv $(MD)/joydrv_joy $(MD)/snddrv \
		$(MD)/vdgint_small.io $(MD)/term_vdg.dt \
		$(MD)/vrn.dr $(MD)/vi.dd \
		$(MD)/clock_soft $(MD)/cc3go

BOOTCMDS	= $(LEVEL2)/CMDS/shell_21 $(LEVEL2)/CMDS/date \
		$(LEVEL2)/CMDS/echo $(LEVEL2)/CMDS/link \
		$(LEVEL2)/CMDS/setime

TEXTFILES_D1	= Startup tOC.txt

SUPPORTFILES_D1	= logDir object picDir sndDir tOC viewDir vol.0 \
		vol.1 vol.2 vol.3 vol.4 vol.12 vol.14 words.tok

SUPPORTFILES_D2	= logDir object picDir sndDir tOC viewDir vol.0 \
		vol.5 vol.6 vol.7 vol.8 vol.11 vol.12 vol.14 words.tok

SUPPORTFILES_D3	= logDir object picDir sndDir tOC viewDir vol.0 \
		vol.5 vol.6 vol.7 vol.9 vol.11 vol.12 vol.14 words.tok

ALLOBJS		= $(CMDS)
TEXTFILES	= tOC.txt Startup

all:	$(ALLOBJS)
	$(CHMOD) 755 $(CMDS)

clean:	dskclean
	$(RM) $(ALLOBJS)

dsk:	all
	$(RM) $(DISK_1) $(DISK_2) $(DISK_3)
	$(CD) $(LEVEL2); make
	$(OS9FORMAT_DS40) $(DISK_1) -n"King's Quest III Disk 1"
	$(MERGE) $(OS9BOOT)>os9boot
	$(MERGE) $(KERNEL)>kernel_1773
	$(OS9GEN) $(DISK_1) -b=os9boot -t=kernel_1773
	$(RM) os9boot kernel_1773
	$(MAKDIR) $(DISK_1),CMDS
	$(CP) $(CMDS) $(DISK_1),CMDS
	$(MERGE) $(BOOTCMDS)>shell
	$(CP) shell $(DISK_1),CMDS
	$(RM) shell
	$(OS9ATTR) $(DISK_1),CMDS/shell -e -pe -pr -e -w -r
	$(OS9RENAME) $(DISK_1),CMDS/sierra AutoEx
	$(CPL) $(TEXTFILES_D1) $(DISK_1),.
	$(CP) $(SUPPORTFILES_D1) $(DISK_1),.
	$(OS9FORMAT_DS40) $(DISK_2) -n"King's Quest III Disk 2"
	$(CP) $(SUPPORTFILES_D2) $(DISK_2),.
	$(OS9FORMAT_DS40) $(DISK_3) -n"King's Quest III Disk 3"
	$(CP) $(SUPPORTFILES_D3) $(DISK_3),.

dskcopy: dsk
	$(CP) $(DISK_1) $(DISK_2) $(DISK_3) $(DSKDIR)

dskclean:
	$(RM) $(DISK_1) $(DISK_2) $(DISK_3)
