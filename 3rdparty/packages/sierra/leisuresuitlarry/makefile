include ../../../Makefile.rules

DEPENDS		= ./Makefile

DISK		= lsl.dsk
CMDS		= sierra mnln scrn shdw
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

SUPPORTFILES	= logDir object picDir sndDir tOC viewDir vol.0 \
		vol.1 vol.2 vol.3 vol.4 words.tok

SCRIPTS		= install2dd

ALLOBJS		= $(CMDS)

all:	$(ALLOBJS)
	$(CHMOD) 755 $(CMDS)

clean:	dskclean
	$(RM) $(ALLOBJS)
	$(OS92UNIX) $(SCRIPTS)

dsk:	all
	$(RM) $(DISK)
	$(CD) $(LEVEL2); make
	$(OS9FORMAT) $(DISK) -t40 -h2 -n"Leisure Suit Larry"
	$(MERGE) $(OS9BOOT)>os9boot
	$(MERGE) $(KERNEL)>kernel_1773
	$(OS9GEN) $(DISK) os9boot kernel_1773
	$(RM) os9boot kernel_1773
	$(MAKDIR) $(DISK),CMDS
	$(CP) $(CMDS) $(DISK),CMDS
	$(OS9RENAME) $(DISK),CMDS/sierra AutoEx
	$(CP) $(SUPPORTFILES) $(DISK),.
	$(UNIX2OS9) $(SCRIPTS)
	$(CP) $(SCRIPTS) $(DISK),.

dskclean:
	$(RM) $(DISK)
