include ../../../rules.mak

DISK68	= multivue_6809.dsk
DISK63	= multivue_6309.dsk
CMDS68	= $(shell $(CD) cmds_6809; make showobjs)
CMDS63	= $(shell $(CD) cmds_6309; make showobjs)
ICONS	= icon.demo
SYSBIN	= $(shell $(CD) sys; make showbinobjs)
SYSTEXT	= $(shell $(CD) sys; make showtextobjs)
DEMO	= aif.dmo
ROOTFILES = startup

MD68	= $(6809L2)/modules
MD63	= $(6309L2)/modules

KERNEL68	= $(MD68)/rel_40 $(MD68)/boot_1773_6ms $(MD68)/kernel
KERNEL63	= $(MD63)/rel_40 $(MD63)/boot_1773_6ms $(MD63)/kernel

OS9BOOT68	= $(MD68)/kernelp2 $(MD68)/ioman $(MD68)/init \
		$(MD68)/rbf.mn \
		$(MD68)/cc3disk.dr $(MD68)/ddd0_40d.dd \
		$(MD68)/d0_40d.dd $(MD68)/d1_40d.dd \
		$(MD68)/scf.mn $(MD68)/cc3io.dr \
		$(MD68)/keydrv_cc3.sb $(MD68)/joydrv_joy.sb $(MD68)/snddrv_cc3.sb \
		$(MD68)/windint.io $(MD68)/term_win40.dt \
		$(MD68)/w.dw $(MD68)/w1.dw $(MD68)/w2.dw $(MD68)/w3.dw \
		$(MD68)/w4.dw $(MD68)/w5.dw $(MD68)/w6.dw $(MD68)/w7.dw \
		$(MD68)/clock_60hz $(MD68)/clock2_soft \
		$(MD68)/sysgo_dd

OS9BOOT63	= $(MD63)/kernelp2 $(MD63)/ioman $(MD63)/init \
		$(MD63)/rbf.mn \
		$(MD63)/cc3disk.dr $(MD63)/ddd0_40d.dd \
		$(MD63)/d0_40d.dd $(MD63)/d1_40d.dd \
		$(MD63)/scf.mn $(MD63)/cc3io.dr \
		$(MD63)/keydrv_cc3.sb $(MD63)/joydrv_joy.sb $(MD63)/snddrv_cc3.sb \
		$(MD63)/windint.io $(MD63)/term_win40.dt \
		$(MD63)/w.dw $(MD63)/w1.dw $(MD63)/w2.dw $(MD63)/w3.dw \
		$(MD63)/w4.dw $(MD63)/w5.dw $(MD63)/w6.dw $(MD63)/w7.dw \
		$(MD63)/clock_60hz $(MD63)/clock2_soft \
		$(MD63)/sysgo_dd


# Make all components
all:
	@$(ECHO) "**************************************************"
	@$(ECHO) "*                                                *"
	@$(ECHO) "*                    Multi-Vue                   *"
	@$(ECHO) "*                                                *"
	@$(ECHO) "**************************************************"
	$(CD) cmds_6809; make
	$(CD) cmds_6309; make
	$(CD) sys; make

# Clean all components
clean:	dskclean
	-$(CD) cmds_6809; make clean
	-$(CD) cmds_6309; make clean
	-$(CD) sys; make clean

dsk:	all
	$(RM) $(DISK68)
	$(OS9FORMAT_DS40) $(DISK68) -q -n"Multi-Vue"
	$(MERGE) $(OS9BOOT68)>os9boot
	$(MERGE) $(KERNEL68)>kernel
	$(OS9GEN) $(DISK68) -b=os9boot -t=kernel
	$(RM) os9boot kernel
	$(MAKDIR) $(DISK68),CMDS
	$(MAKDIR) $(DISK68),CMDS/ICONS
	$(MAKDIR) $(DISK68),SYS
	$(MAKDIR) $(DISK68),DEMO
	$(CD) cmds_6809; $(CP) $(CMDS68) ../$(DISK68),CMDS
	$(foreach file, $(CMDS68), $(OS9ATTR_EXEC) $(DISK68),CMDS/$(notdir $(file));)
	$(OS9RENAME) $(DISK68),CMDS/gshell AutoEx
	$(CD) icons; $(CP) $(ICONS) ../$(DISK68),CMDS/ICONS
	$(foreach file, $(ICONS), $(OS9ATTR_EXEC) $(DISK68),CMDS/ICONS/$(file);)
	$(CD) sys; $(CP) $(SYSBIN) ../$(DISK68),SYS
	$(foreach file, $(SYSBIN), $(OS9ATTR_TEXT) $(DISK68),SYS/$(file);)
	$(CD) sys; $(CPL) $(SYSTEXT) ../$(DISK68),SYS
	$(foreach file, $(SYSTEXT), $(OS9ATTR_TEXT) $(DISK68),SYS/$(file);)
	$(CD) demo; $(CPL) $(DEMO) ../$(DISK68),DEMO
	$(foreach file, $(DEMO), $(OS9ATTR_TEXT) $(DISK68),DEMO/$(file);)
	$(CPL) $(ROOTFILES) $(DISK68),.
	$(foreach file, $(ROOTFILES), $(OS9ATTR_TEXT) $(DISK68),$(file);)
	$(RM) $(DISK63)
	$(OS9FORMAT_DS40) $(DISK63) -q -n"Multi-Vue"
	$(MERGE) $(OS9BOOT63)>os9boot
	$(MERGE) $(KERNEL63)>kernel
	$(OS9GEN) $(DISK63) -b=os9boot -t=kernel
	$(RM) os9boot kernel
	$(MAKDIR) $(DISK63),CMDS
	$(MAKDIR) $(DISK63),CMDS/ICONS
	$(MAKDIR) $(DISK63),SYS
	$(MAKDIR) $(DISK63),DEMO
	$(CD) cmds_6309; $(CP) $(CMDS63) ../$(DISK63),CMDS
	$(foreach file, $(CMDS63), $(OS9ATTR_EXEC) $(DISK63),CMDS/$(notdir $(file));)
	$(OS9RENAME) $(DISK63),CMDS/gshell AutoEx
	$(CD) icons; $(CP) $(ICONS) ../$(DISK63),CMDS/ICONS
	$(foreach file, $(ICONS), $(OS9ATTR_EXEC) $(DISK63),CMDS/ICONS/$(file);)
	$(CD) sys; $(CP) $(SYSBIN) ../$(DISK63),SYS
	$(foreach file, $(SYSBIN), $(OS9ATTR_TEXT) $(DISK63),SYS/$(file);)
	$(CD) sys; $(CPL) $(SYSTEXT) ../$(DISK63),SYS
	$(foreach file, $(SYSTEXT), $(OS9ATTR_TEXT) $(DISK63),SYS/$(file);)
	$(CD) demo; $(CPL) $(DEMO) ../$(DISK63),DEMO
	$(foreach file, $(DEMO), $(OS9ATTR_TEXT) $(DISK63),DEMO/$(file);)
	$(CPL) $(ROOTFILES) $(DISK63),.
	$(foreach file, $(ROOTFILES), $(OS9ATTR_TEXT) $(DISK63),$(file);)

dskcopy: dsk
	$(CP) $(DISK68) $(DSKDIR)
	$(CP) $(DISK63) $(DSKDIR)

dskclean:
	$(RM) $(DISK68) $(DISK63)

