include ../../../Makefile.rules

DEPENDS		= ./Makefile

DISK		= rof.dsk
CMDS		= rescue
MD		= $(LEVEL2)/MODULES

# We make our own bootfile and kernel track
KERNEL		= $(MD)/rel $(MD)/boot_1773 $(MD)/os9p1
OS9BOOT		= $(MD)/os9p2 $(MD)/ioman $(MD)/init \
		$(MD)/rbf.mn \
		$(MD)/cc3disk.dr $(MD)/ddd0_40d.dd \
		$(MD)/scf.mn $(MD)/cc3io.dr \
		$(MD)/keydrv $(MD)/joydrv_joy $(MD)/snddrv \
		$(MD)/vdgint_small.io $(MD)/term_vdg.dt \
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
	$(OS9FORMAT_SS35) $(DISK) -n"Rescue on Fractalus"
	$(MERGE) $(OS9BOOT)>os9boot
	$(MERGE) $(KERNEL)>kernel_1773
	$(OS9GEN) $(DISK) -t=os9boot -b=kernel_1773
	$(RM) os9boot kernel_1773
	$(MAKDIR) $(DISK),CMDS
	$(CP) $(LEVEL2)/CMDS/shell_21 $(DISK),CMDS/shell
	$(CP) $(CMDS) $(DISK),CMDS
	$(OS9RENAME) $(DISK),CMDS/rescue AutoEx
	$(CP) $(SUPPORTFILES) $(DISK),.

dskcopy: dsk
	$(CP) $(DISK) $(DSKDIR)

dskclean:
	$(RM) $(DISK)
