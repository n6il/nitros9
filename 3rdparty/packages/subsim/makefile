include ../../../Makefile.rules

DEPENDS		= ./Makefile

DISK		= subsim.dsk
CMDS		= presub sub sub1 sub2 sub3 sub4 sub5 sub6
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

SUPPORTFILES	= control1.cmp convoys.dat diesel.dat fonts.dat germap.cmp \
		hiscore.dat mission.txt missions.dat radar.dat shipmap2.dat \
		sintbl.dat stitle.pic sub.dat usamap.cmp 

ALLOBJS		= $(CMDS)

all:	$(ALLOBJS)

clean:	dskclean
	$(RM) $(ALLOBJS)

dsk:	all
	$(RM) $(DISK)
	$(CD) $(LEVEL2); make
	$(OS9FORMAT_DS40) $(DISK) -n"Sub Battle Simulator"
	$(MERGE) $(OS9BOOT)>os9boot
	$(MERGE) $(KERNEL)>kernel_1773
	$(OS9GEN) $(DISK) -b=os9boot -t=kernel_1773
	$(RM) os9boot kernel_1773
	$(MAKDIR) $(DISK),CMDS
	$(CP) $(CMDS) $(DISK),CMDS
	$(foreach file, $(CMDS), $(OS9ATTR_EXEC) $(DISK),CMDS/$(file);)
	$(CP) $(LEVEL2)/CMDS/shell_21 $(DISK),CMDS/shell
	$(OS9ATTR_EXEC) $(DISK),CMDS/shell
	$(OS9RENAME) $(DISK),CMDS/presub AutoEx
	$(CP) $(SUPPORTFILES) $(DISK),.
	$(foreach file, $(SUPPORTFILES), $(OS9ATTR_TEXT) $(DISK),$(file);)

dskcopy:
	$(CP) $(DISK) $(DSKDIR)

dskclean:
	$(RM) $(DISK)
