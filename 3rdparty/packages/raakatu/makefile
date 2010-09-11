include ../../../rules.mak

DEPENDS		= ./makefile

DISK		= raakatu.dsk
CMDS		= raaka-tu raakatu
MD		= $(LEVEL2)/coco3/modules

# We make our own bootfile and kernel track
KERNEL		= $(MD)/rel_32 $(MD)/boot_1773_6ms $(MD)/krn
OS9BOOT		= $(MD)/krnp2 $(MD)/ioman $(MD)/init \
		$(MD)/rbf.mn \
		$(MD)/rb1773.dr $(MD)/ddd0_40d.dd \
		$(MD)/scf.mn $(MD)/vtio.dr \
		$(MD)/keydrv_cc3.sb $(MD)/joydrv_joy.sb $(MD)/snddrv_cc3.sb \
		$(MD)/covdg_small.io $(MD)/term_vdg.dt \
		$(MD)/clock_60hz $(MD)/clock2_soft $(MD)/sysgo_dd

SUPPORTFILES	= 

ALLOBJS		= $(CMDS)

all:	$(ALLOBJS)

clean:	dskclean
	$(RM) $(ALLOBJS)

dsk:	all
	$(RM) $(DISK)
	$(CD) $(LEVEL2)/coco3; make
	$(OS9FORMAT_SS35) $(DISK) -n"Raaka-Tu"
	$(MERGE) $(OS9BOOT)>os9boot
	$(MERGE) $(KERNEL)>kernel_1773
	$(OS9GEN) $(DISK) -b=os9boot -t=kernel_1773
	$(RM) os9boot kernel_1773
	$(MAKDIR) $(DISK),CMDS
	$(CP) $(CMDS) $(DISK),CMDS
	$(foreach file, $(CMDS), $(OS9ATTR_EXEC) $(DISK),CMDS/$(file);)
	$(OS9RENAME) $(DISK),CMDS/raakatu AutoEx
	$(CP) $(LEVEL2)/coco3/cmds/shell_21 $(DISK),CMDS/shell
	$(OS9ATTR_EXEC) $(DISK),CMDS/shell
#	$(foreach file, $(SUPPORTFILES), $(OS9ATTR_TEXT) $(DISK),SUB/$(file);)

dskcopy:
	$(CP) $(DISK) $(DSKDIR)

dskclean:
	$(RM) $(DISK)

run: dsk
	mess -inipath ~/Documents/SDLMESS -video opengl -window coco3 -flop1 $(DISK)
