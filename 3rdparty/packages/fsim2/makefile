include ../../../Makefile.rules

DEPENDS		= ./Makefile

DISK		= fsim2.dsk
CMDS		= fs f2 f3 f4
MD		= $(LEVEL2)/MODULES

# We make our own bootfile and kernel track
KERNEL		= $(MD)/rel $(MD)/boot_1773 $(MD)/os9p1
OS9BOOT		= $(MD)/os9p2 $(MD)/ioman $(MD)/init \
		$(MD)/rbf.mn \
		$(MD)/cc3disk.dr $(MD)/ddd0_40d.dd \
		$(MD)/scf.mn $(MD)/cc3io.dr \
		$(MD)/keydrv $(MD)/joydrv_joy $(MD)/snddrv \
		$(MD)/vdgint_small.io $(MD)/term_vdg.dt \
		$(MD)/vrn.dr $(MD)/ftdd.dd \
		$(MD)/clock_soft $(MD)/cc3go

SUPPORTFILES	= fa fd fp sf.standard

ALLOBJS		= $(CMDS)

all:	$(ALLOBJS)
	$(CHMOD) 755 $(CMDS)

clean:	dskclean
	$(RM) $(ALLOBJS)

dsk:	all
	$(RM) $(DISK)
	$(CD) $(LEVEL2); make
	$(OS9FORMAT_SS35) $(DISK) -n"Flight Simulator 2"
	$(MERGE) $(OS9BOOT)>os9boot
	$(MERGE) $(KERNEL)>kernel_1773
	$(OS9GEN) $(DISK) -b=os9boot -t=kernel_1773
	$(RM) os9boot kernel_1773
	$(MAKDIR) $(DISK),CMDS
	$(CP) $(LEVEL2)/CMDS/shell_21 $(DISK),CMDS/shell
	$(CP) $(CMDS) $(DISK),CMDS
	$(OS9RENAME) $(DISK),CMDS/fs AutoEx
	$(CP) $(SUPPORTFILES) $(DISK),.

dskcopy: dsk
	$(CP) $(DISK) $(DSKDIR)

dskclean:
	$(RM) $(DISK)
