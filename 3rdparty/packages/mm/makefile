include ../../../Makefile.rules

DEPENDS		= ./Makefile

DISK		= mm.dsk
CMDS		= mm mod1.dat mod2.dat mod3.dat mod4.dat mod5.dat \
		mod6.sbr mod7.sbr mod8.sbr
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

SUPPORTFILES	= global.dat mm.lib mm.pnl mm.ttl mod7.lib

ALLOBJS		= $(CMDS)

all:	$(ALLOBJS)
	$(CHMOD) 755 $(CMDS)

clean:	dskclean
	$(RM) $(ALLOBJS)

dsk:	all
	$(RM) $(DISK)
	$(CD) $(LEVEL2); make
	$(OS9FORMAT_DS40) $(DISK) -n"Microscopic Mission"
	$(MERGE) $(OS9BOOT)>os9boot
	$(MERGE) $(KERNEL)>kernel_1773
	$(OS9GEN) $(DISK) -b=os9boot -t=kernel_1773
	$(RM) os9boot kernel_1773
	$(MAKDIR) $(DISK),CMDS
	$(CP) $(LEVEL2)/CMDS/shell_21 $(DISK),CMDS/shell
	$(OS9ATTR_EXEC) $(DISK),CMDS/shell
	$(CP) $(CMDS) $(DISK),CMDS
	$(foreach file, $(CMDS), $(OS9ATTR_EXEC) $(DISK),CMDS/$(file);)
	$(OS9RENAME) $(DISK),CMDS/mm AutoEx
	$(CP) $(SUPPORTFILES) $(DISK),.
	$(foreach file, $(SUPPORTFILES), $(OS9ATTR_EXEC) $(DISK),$(file);)

dskcopy: dsk
	$(CP) $(DISK) $(DSKDIR)

dskclean:
	$(RM) $(DISK)
