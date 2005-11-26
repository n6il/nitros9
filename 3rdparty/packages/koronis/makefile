include ../../../rules.mak

DEPENDS		= ./makefile

DISK		= koronis.dsk
CMDS		= koronis
MD		= $(6809L2)/modules

# We make our own bootfile and kernel track
KERNEL		= $(MD)/rel_32 $(MD)/boot_1773_6ms $(MD)/krn
OS9BOOT		= $(MD)/krnp2 $(MD)/ioman $(MD)/init \
		$(MD)/rbf.mn \
		$(MD)/rb1773.dr $(MD)/ddd0_40d.dd \
		$(MD)/scf.mn $(MD)/vtio.dr \
		$(MD)/keydrv_cc3.sb $(MD)/joydrv_joy.sb $(MD)/snddrv_cc3.sb \
		$(MD)/covdg_small.io $(MD)/term_vdg.dt \
		$(MD)/clock_60hz $(MD)/clock2_soft $(MD)/sysgo_dd

SUPPORTFILES	= SAVE1 SAVE2 crobot2.c ctitle.c korvar \
		level01 level02 level03 level04 level05 level06 level07 \
		level08 level09 level10 level11 level12 level13 level14 \
		level15 level16 level17 level18 level19 level20 \
		robotbuff sinwave ultek

ALLOBJS		= $(CMDS)

all:	$(ALLOBJS)

clean:	dskclean
	$(RM) $(ALLOBJS)

dsk:	all
	$(RM) $(DISK)
	$(CD) $(6809L2); make
	$(OS9FORMAT_SS35) $(DISK) -n"Koronis Rift"
	$(MERGE) $(OS9BOOT)>os9boot
	$(MERGE) $(KERNEL)>kernel_1773
	$(OS9GEN) $(DISK) -b=os9boot -t=kernel_1773
	$(RM) os9boot kernel_1773
	$(MAKDIR) $(DISK),CMDS
	$(CP) $(6809L2)/cmds/shell_21 $(DISK),CMDS/shell
	$(OS9ATTR_EXEC) $(DISK),CMDS/shell
	$(CP) $(CMDS) $(DISK),CMDS
	$(foreach file, $(CMDS), $(OS9ATTR_EXEC) $(DISK),CMDS/$(file);)
	$(OS9RENAME) $(DISK),CMDS/koronis AutoEx
	$(CP) $(SUPPORTFILES) $(DISK),.
	$(foreach file, $(SUPPORTFILES), $(OS9ATTR_TEXT) $(DISK),$(file);)

dskcopy: dsk
	$(CP) $(DISK) $(DSKDIR)

dskclean:
	$(RM) $(DISK)
