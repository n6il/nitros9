include ../../../rules.mak

DEPENDS		= ./makefile

DISK		= subsim.dsk
CMDS		= presub sub sub1 sub2 sub3 sub4 sub5 sub6
MD		= $(6809L2)/modules

# We make our own bootfile and kernel track
KERNEL		= $(MD)/rel_32 $(MD)/boot_1773_6ms $(MD)/krn
OS9BOOT		= $(MD)/krnp2 $(MD)/ioman $(MD)/init \
		$(MD)/rbf.mn \
		$(MD)/rb1773.dr $(MD)/ddd0_40d.dd \
		$(MD)/scf.mn $(MD)/cc3io.dr \
		$(MD)/keydrv_cc3.sb $(MD)/joydrv_joy.sb $(MD)/snddrv_cc3.sb \
		$(MD)/vdgint_small.io $(MD)/term_vdg.dt \
		$(MD)/clock_60hz $(MD)/clock2_soft $(MD)/sysgo_dd

SUPPORTFILES	= control1.cmp convoys.dat diesel.dat fonts.dat germap.cmp \
		hiscore.dat mission.txt missions.dat radar.dat shipmap2.dat \
		sintbl.dat stitle.pic sub.dat usamap.cmp status.dat substats.dat 

ALLOBJS		= $(CMDS)

all:	$(ALLOBJS)

clean:	dskclean
	$(RM) $(ALLOBJS)

dsk:	all
	$(RM) $(DISK)
	$(CD) $(6809L2); make
	$(OS9FORMAT_DS40) $(DISK) -n"Sub Battle Simulator"
	$(MERGE) $(OS9BOOT)>os9boot
	$(MERGE) $(KERNEL)>kernel_1773
	$(OS9GEN) $(DISK) -b=os9boot -t=kernel_1773
	$(RM) os9boot kernel_1773
	$(MAKDIR) $(DISK),CMDS $(DISK),SUB
	$(CP) $(CMDS) $(DISK),CMDS
	$(foreach file, $(CMDS), $(OS9ATTR_EXEC) $(DISK),CMDS/$(file);)
	$(CP) $(6809L2)/cmds/shell_21 $(DISK),CMDS/shell
	$(OS9ATTR_EXEC) $(DISK),CMDS/shell
	$(OS9RENAME) $(DISK),CMDS/presub AutoEx
	$(CP) $(SUPPORTFILES) $(DISK),SUB
	$(CP) sub6 $(DISK),SUB
	$(OS9ATTR_EXEC) $(DISK),SUB/sub6
	$(foreach file, $(SUPPORTFILES), $(OS9ATTR_TEXT) $(DISK),SUB/$(file);)

dskcopy:
	$(CP) $(DISK) $(DSKDIR)

dskclean:
	$(RM) $(DISK)
