include ../../../Makefile.rules

DEPENDS		= ./Makefile

DISK		= rof.dsk
CMDS		= rescue
MD		= $(LEVEL2)/MODULES

# We make our own bootfile and kernel track
KERNEL		= $(MD)/rel $(MD)/boot_1773 $(MD)/os9p1
OS9BOOT		= $(MD)/os9p2 $(MD)/init $(MD)/ioman $(MD)/cc3disk.dr $(MD)/rbf.mn \
		$(MD)/ddd0_40d.dd $(MD)/d0_40d.dd \
		$(MD)/scf.mn $(MD)/cc3io.dr $(MD)/vdgint.io $(MD)/keydrv \
		$(MD)/joydrv_joy $(MD)/snddrv $(MD)/term_vdg.dt \
		$(MD)/clock_soft $(MD)/cc3go

SUPPORTFILES	= body heads larms legs lips panel1 rofvar rship.c rtitle.c scores

ALLOBJS		= $(CMDS)

all:	$(ALLOBJS)
	$(CHMOD) 755 $(CMDS)

clean:	dskclean
	$(RM) $(ALLOBJS)

dsk:	all
	$(RM) $(DISK)
	$(CD) $(LEVEL2); make
	$(OS9FORMAT) $(DISK)
	$(MERGE) $(OS9BOOT)>os9boot
	$(MERGE) $(KERNEL)>kernel_1773
	$(OS9GEN) $(DISK) os9boot kernel_1773
	$(MAKDIR) $(DISK),CMDS
	$(CP) rescue $(DISK),CMDS/AutoEx
	$(CP) $(SUPPORTFILES) $(DISK),.

dskclean:
	$(RM) $(DISK)
