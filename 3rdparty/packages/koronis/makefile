include ../../../Makefile.rules

DEPENDS		= ./Makefile

DISK		= koronis.dsk
CMDS		= koronis
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
	$(CD) $(LEVEL2); make
	$(OS9FORMAT_SS35) $(DISK) -n"Koronis Rift"
	$(MERGE) $(OS9BOOT)>os9boot
	$(MERGE) $(KERNEL)>kernel_1773
	$(OS9GEN) $(DISK) -b=os9boot -t=kernel_1773
	$(RM) os9boot kernel_1773
	$(MAKDIR) $(DISK),CMDS
	$(CP) $(LEVEL2)/CMDS/shell_21 $(DISK),CMDS/shell
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
