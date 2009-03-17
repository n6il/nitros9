include ../../../rules.mak

DEPENDS		= ./makefile

DSK_FLOPPY	= subsim.dsk
DSK_DW3		= subsim_dw3.dsk
CMDS		= presub sub sub1 sub2 sub3 sub4 sub5 sub6
MD		= $(LEVEL2)/coco3/modules

DSKS		= $(DSK_FLOPPY) $(DSK_DW3)

# We make our own bootfile and kernel track
KERNEL_FLOPPY	= $(MD)/rel_32 $(MD)/boot_1773_6ms $(MD)/krn
KERNEL_DW3	= $(MD)/rel_32 $(MD)/boot_dw3 $(MD)/krn
BOOTFILE_FLOPPY	= $(MD)/krnp2 $(MD)/ioman $(MD)/init \
		$(MD)/rbf.mn \
		$(MD)/rb1773.dr $(MD)/ddd0_40d.dd \
		$(MD)/scf.mn $(MD)/vtio.dr \
		$(MD)/keydrv_cc3.sb $(MD)/joydrv_joy.sb $(MD)/snddrv_cc3.sb \
		$(MD)/covdg_small.io $(MD)/term_vdg.dt \
		$(MD)/clock_60hz $(MD)/clock2_soft $(MD)/sysgo_dd

BOOTFILE_DW3	= $(MD)/krnp2 $(MD)/ioman $(MD)/init \
		$(MD)/rbf.mn \
		$(MD)/rbdw3.dr $(MD)/dw3.sb $(MD)/ddx0.dd \
		$(MD)/scf.mn $(MD)/vtio.dr \
		$(MD)/keydrv_cc3.sb $(MD)/joydrv_joy.sb $(MD)/snddrv_cc3.sb \
		$(MD)/covdg_small.io $(MD)/term_vdg.dt \
		$(MD)/clock_60hz $(MD)/clock2_dw3 $(MD)/sysgo_dd

SUPPORTFILES	= control1.cmp convoys.dat diesel.dat fonts.dat germap.cmp \
		hiscore.dat mission.txt missions.dat radar.dat shipmap2.dat \
		sintbl.dat stitle.pic sub.dat usamap.cmp status.dat substats.dat 

ALLOBJS		= $(CMDS)

all:	$(ALLOBJS)

clean:	dskclean
	$(RM) $(ALLOBJS)

dsk:	all $(DSKS)

$(DSK_FLOPPY):
	$(RM) $@
	$(CD) $(LEVEL2)/coco3; make
	$(OS9FORMAT_DS40) $@ -n"Sub Battle Simulator"
	$(MERGE) $(BOOTFILE_FLOPPY)>os9boot
	$(MERGE) $(KERNEL_FLOPPY)>kernel
	$(OS9GEN) $@ -b=os9boot -t=kernel
	$(RM) os9boot kernel
	$(MAKDIR) $@,CMDS $@,SUB
	$(CP) $(CMDS) $@,CMDS
	$(foreach file, $(CMDS), $(OS9ATTR_EXEC) $@,CMDS/$(file);)
	$(CP) $(LEVEL2)/coco3/cmds/shell_21 $@,CMDS/shell
	$(OS9ATTR_EXEC) $@,CMDS/shell
	$(OS9RENAME) $@,CMDS/presub AutoEx
	$(CP) $(SUPPORTFILES) $@,SUB
	$(CP) sub6 $@,SUB
	$(OS9ATTR_EXEC) $@,SUB/sub6
	$(foreach file, $(SUPPORTFILES), $(OS9ATTR_TEXT) $@,SUB/$(file);)

$(DSK_DW3):
	$(RM) $@
	$(CD) $(LEVEL2)/coco3; make
	$(OS9FORMAT_SS80) $@ -n"Sub Battle Simulator"
	$(MERGE) $(BOOTFILE_DW3)>os9boot
	$(MERGE) $(KERNEL_DW3)>kernel
	$(OS9GEN) $@ -b=os9boot -t=kernel
	$(RM) os9boot kernel
	$(MAKDIR) $@,CMDS $@,SUB
	$(CP) $(CMDS) $@,CMDS
	$(foreach file, $(CMDS), $(OS9ATTR_EXEC) $@,CMDS/$(file);)
	$(CP) $(LEVEL2)/coco3/cmds/shell_21 $@,CMDS/shell
	$(OS9ATTR_EXEC) $@,CMDS/shell
	$(OS9RENAME) $@,CMDS/presub AutoEx
	$(CP) $(SUPPORTFILES) $@,SUB
	$(CP) sub6 $@,SUB
	$(OS9ATTR_EXEC) $@,SUB/sub6
	$(foreach file, $(SUPPORTFILES), $(OS9ATTR_TEXT) $@,SUB/$(file);)

dskcopy:
	$(CP) $(DSKS) $(DSKDIR)

dskclean:
	$(RM) $(DSKS)

info:
	@$(ECHO) "*** Sub Battle Simluator ***"
	@$(foreach dsk, $(DSKS), $(ECHO) $(dsk);)
