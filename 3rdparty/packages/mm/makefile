include ../../../rules.mak

DEPENDS		= ./makefile

DISK		= mm.dsk
CMDS		= mm mod1.dat mod2.dat mod3.dat mod4.dat mod5.dat \
		mod6.sbr mod7.sbr mod8.sbr
MD		= $(6809L2)/modules

# We make our own bootfile and kernel track
KERNEL		= $(MD)/rel_32 $(MD)/boot_1773_6ms $(MD)/kernel
OS9BOOT		= $(MD)/kernelp2 $(MD)/ioman $(MD)/init \
		$(MD)/rbf.mn \
		$(MD)/cc3disk.dr $(MD)/ddd0_40d.dd \
		$(MD)/scf.mn $(MD)/cc3io.dr \
		$(MD)/keydrv_cc3.sb $(MD)/joydrv_joy.sb $(MD)/snddrv_cc3.sb \
		$(MD)/vdgint_small.io $(MD)/term_vdg.dt \
		$(MD)/clock_60hz $(MD)/clock2_soft $(MD)/sysgo_dd

SUPPORTFILES	= global.dat mm.lib mm.pnl mm.ttl mod7.lib

ALLOBJS		= $(CMDS)

all:	$(ALLOBJS)

clean:	dskclean
	$(RM) $(ALLOBJS)

dsk:	all
	$(RM) $(DISK)
	$(CD) $(6809L2); make
	$(OS9FORMAT_DS40) $(DISK) -n"Microscopic Mission"
	$(MERGE) $(OS9BOOT)>os9boot
	$(MERGE) $(KERNEL)>kernel_1773
	$(OS9GEN) $(DISK) -b=os9boot -t=kernel_1773
	$(RM) os9boot kernel_1773
	$(MAKDIR) $(DISK),CMDS
	$(CP) $(6809L2)/cmds/shell_21 $(DISK),CMDS/shell
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
