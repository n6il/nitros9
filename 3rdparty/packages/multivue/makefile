include $(NITROS9DIR)/rules.mak

DSK68_FLOPPY	= multivue_6809.dsk
DSK63_FLOPPY	= multivue_6309.dsk
DSK68_DW3	= multivue_6809_dw3.dsk
DSK63_DW3	= multivue_6309_dw3.dsk
DSK68_DW3_BECKER	= multivue_6809_becker.dsk
DSK63_DW3_BECKER	= multivue_6309_becker.dsk

CMDS68	= $(shell $(CD) cmds_6809; make --no-print-directory showobjs)
CMDS63	= $(shell $(CD) cmds_6309; make --no-print-directory showobjs)
ICONS	= icon.demo
SYSBIN	= $(shell $(CD) sys; make --no-print-directory showbinobjs)
SYSTEXT	= $(shell $(CD) sys; make --no-print-directory showtextobjs)
DEMO	= aif.dmo
ROOTFILES = startup

DSKS	= $(DSK68_FLOPPY) $(DSK63_FLOPPY) $(DSK68_DW3) $(DSK63_DW3) $(DSK68_DW3_BECKER) $(DSK63_DW3_BECKER)

MD68	= $(LEVEL2)/coco3/modules
MD63	= $(LEVEL2)/coco3_6309/modules

KERNEL68_FLOPPY	= $(MD68)/rel_40 $(MD68)/boot_1773_6ms $(MD68)/krn
KERNEL63_FLOPPY	= $(MD63)/rel_40 $(MD63)/boot_1773_6ms $(MD63)/krn
KERNEL68_DW3	= $(MD68)/rel_40 $(MD68)/boot_dw3 $(MD68)/krn
KERNEL63_DW3	= $(MD63)/rel_40 $(MD63)/boot_dw3 $(MD63)/krn
KERNEL68_DW3_BECKER	= $(MD68)/rel_40 $(MD68)/boot_dw3_becker $(MD68)/krn
KERNEL63_DW3_BECKER	= $(MD63)/rel_40 $(MD63)/boot_dw3_becker $(MD63)/krn

BOOTFILE68_FLOPPY	= $(MD68)/krnp2 $(MD68)/ioman $(MD68)/init \
		$(MD68)/rbf.mn \
		$(MD68)/rb1773.dr $(MD68)/ddd0_40d.dd \
		$(MD68)/d0_40d.dd $(MD68)/d1_40d.dd \
		$(MD68)/scf.mn $(MD68)/vtio.dr \
		$(MD68)/keydrv_cc3.sb $(MD68)/joydrv_joy.sb $(MD68)/snddrv_cc3.sb \
		$(MD68)/cowin.io $(MD68)/term_win40.dt \
		$(MD68)/w.dw $(MD68)/w1.dw $(MD68)/w2.dw $(MD68)/w3.dw \
		$(MD68)/w4.dw $(MD68)/w5.dw $(MD68)/w6.dw $(MD68)/w7.dw \
		$(MD68)/clock_60hz $(MD68)/clock2_soft \
		$(MD68)/sysgo_dd

BOOTFILE63_FLOPPY	= $(MD63)/krnp2 $(MD63)/ioman $(MD63)/init \
		$(MD63)/rbf.mn \
		$(MD63)/rb1773.dr $(MD63)/ddd0_40d.dd \
		$(MD63)/d0_40d.dd $(MD63)/d1_40d.dd \
		$(MD63)/scf.mn $(MD63)/vtio.dr \
		$(MD63)/keydrv_cc3.sb $(MD63)/joydrv_joy.sb $(MD63)/snddrv_cc3.sb \
		$(MD63)/cowin.io $(MD63)/term_win40.dt \
		$(MD63)/w.dw $(MD63)/w1.dw $(MD63)/w2.dw $(MD63)/w3.dw \
		$(MD63)/w4.dw $(MD63)/w5.dw $(MD63)/w6.dw $(MD63)/w7.dw \
		$(MD63)/clock_60hz $(MD63)/clock2_soft \
		$(MD63)/sysgo_dd

BOOTFILE68_DW3	= $(MD68)/krnp2 $(MD68)/ioman $(MD68)/init \
		$(MD68)/rbf.mn \
		$(MD68)/rbdw3.dr $(MD68)/dw3.sb $(MD68)/ddx0.dd \
		$(MD68)/rb1773.dr $(MD68)/d0_40d.dd $(MD68)/d1_40d.dd \
		$(MD68)/scf.mn $(MD68)/vtio.dr \
		$(MD68)/keydrv_cc3.sb $(MD68)/joydrv_joy.sb $(MD68)/snddrv_cc3.sb \
		$(MD68)/cowin.io $(MD68)/term_win40.dt \
		$(MD68)/w.dw $(MD68)/w1.dw $(MD68)/w2.dw $(MD68)/w3.dw \
		$(MD68)/w4.dw $(MD68)/w5.dw $(MD68)/w6.dw $(MD68)/w7.dw \
		$(MD68)/clock_60hz $(MD68)/clock2_dw3 \
		$(MD68)/sysgo_dd

BOOTFILE68_DW3_BECKER	= $(MD68)/krnp2 $(MD68)/ioman $(MD68)/init \
		$(MD68)/rbf.mn \
		$(MD68)/rbdw3.dr $(MD68)/dw3_becker.sb $(MD68)/ddx0.dd \
		$(MD68)/rb1773.dr $(MD68)/d0_40d.dd $(MD68)/d1_40d.dd \
		$(MD68)/scf.mn $(MD68)/vtio.dr \
		$(MD68)/keydrv_cc3.sb $(MD68)/joydrv_joy.sb $(MD68)/snddrv_cc3.sb \
		$(MD68)/cowin.io $(MD68)/term_win40.dt \
		$(MD68)/w.dw $(MD68)/w1.dw $(MD68)/w2.dw $(MD68)/w3.dw \
		$(MD68)/w4.dw $(MD68)/w5.dw $(MD68)/w6.dw $(MD68)/w7.dw \
		$(MD68)/clock_60hz $(MD68)/clock2_dw3 \
		$(MD68)/sysgo_dd

BOOTFILE63_DW3	= $(MD63)/krnp2 $(MD63)/ioman $(MD63)/init \
		$(MD63)/rbf.mn \
		$(MD63)/rbdw3.dr $(MD63)/dw3.sb $(MD63)/ddx0.dd \
		$(MD68)/rb1773.dr $(MD68)/d0_40d.dd $(MD68)/d1_40d.dd \
		$(MD63)/scf.mn $(MD63)/vtio.dr \
		$(MD63)/keydrv_cc3.sb $(MD63)/joydrv_joy.sb $(MD63)/snddrv_cc3.sb \
		$(MD63)/cowin.io $(MD63)/term_win40.dt \
		$(MD63)/w.dw $(MD63)/w1.dw $(MD63)/w2.dw $(MD63)/w3.dw \
		$(MD63)/w4.dw $(MD63)/w5.dw $(MD63)/w6.dw $(MD63)/w7.dw \
		$(MD63)/clock_60hz $(MD63)/clock2_dw3 \
		$(MD63)/sysgo_dd

BOOTFILE63_DW3_BECKER	= $(MD63)/krnp2 $(MD63)/ioman $(MD63)/init \
		$(MD63)/rbf.mn \
		$(MD63)/rbdw3.dr $(MD63)/dw3_becker.sb $(MD63)/ddx0.dd \
		$(MD68)/rb1773.dr $(MD68)/d0_40d.dd $(MD68)/d1_40d.dd \
		$(MD63)/scf.mn $(MD63)/vtio.dr \
		$(MD63)/keydrv_cc3.sb $(MD63)/joydrv_joy.sb $(MD63)/snddrv_cc3.sb \
		$(MD63)/cowin.io $(MD63)/term_win40.dt \
		$(MD63)/w.dw $(MD63)/w1.dw $(MD63)/w2.dw $(MD63)/w3.dw \
		$(MD63)/w4.dw $(MD63)/w5.dw $(MD63)/w6.dw $(MD63)/w7.dw \
		$(MD63)/clock_60hz $(MD63)/clock2_dw3 \
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

dsk:	all $(DSKS)

$(DSK68_FLOPPY):
	$(RM) $@
	$(OS9FORMAT_DS40) $@ -q -n"Multi-Vue"
	$(MERGE) $(BOOTFILE68_FLOPPY)>os9boot
	$(MERGE) $(KERNEL68_FLOPPY)>kernel
	$(OS9GEN) $@ -b=os9boot -t=kernel
	$(RM) os9boot kernel
	$(MAKDIR) $@,CMDS
	$(MAKDIR) $@,CMDS/ICONS
	$(MAKDIR) $@,SYS
	$(MAKDIR) $@,DEMO
	$(CD) cmds_6809; $(CP) $(CMDS68) ../$@,CMDS
	$(foreach file, $(CMDS68), $(OS9ATTR_EXEC) $@,CMDS/$(notdir $(file));)
	$(OS9RENAME) $@,CMDS/gshell AutoEx
	$(CD) icons; $(CP) $(ICONS) ../$@,CMDS/ICONS
	$(foreach file, $(ICONS), $(OS9ATTR_EXEC) $@,CMDS/ICONS/$(file);)
	$(CD) sys; $(CP) $(SYSBIN) ../$@,SYS
	$(foreach file, $(SYSBIN), $(OS9ATTR_TEXT) $@,SYS/$(file);)
	$(CD) sys; $(CPL) $(SYSTEXT) ../$@,SYS
	$(foreach file, $(SYSTEXT), $(OS9ATTR_TEXT) $@,SYS/$(file);)
	$(CD) demo; $(CPL) $(DEMO) ../$@,DEMO
	$(foreach file, $(DEMO), $(OS9ATTR_TEXT) $@,DEMO/$(file);)
	$(CPL) $(ROOTFILES) $@,.
	$(foreach file, $(ROOTFILES), $(OS9ATTR_TEXT) $@,$(file);)

$(DSK63_FLOPPY):
	$(RM) $@
	$(OS9FORMAT_DS40) $@ -q -n"Multi-Vue"
	$(MERGE) $(BOOTFILE63_FLOPPY)>os9boot
	$(MERGE) $(KERNEL63_FLOPPY)>kernel
	$(OS9GEN) $@ -b=os9boot -t=kernel
	$(RM) os9boot kernel
	$(MAKDIR) $@,CMDS
	$(MAKDIR) $@,CMDS/ICONS
	$(MAKDIR) $@,SYS
	$(MAKDIR) $@,DEMO
	$(CD) cmds_6309; $(CP) $(CMDS63) ../$@,CMDS
	$(foreach file, $(CMDS63), $(OS9ATTR_EXEC) $@,CMDS/$(notdir $(file));)
	$(OS9RENAME) $@,CMDS/gshell AutoEx
	$(CD) icons; $(CP) $(ICONS) ../$@,CMDS/ICONS
	$(foreach file, $(ICONS), $(OS9ATTR_EXEC) $@,CMDS/ICONS/$(file);)
	$(CD) sys; $(CP) $(SYSBIN) ../$@,SYS
	$(foreach file, $(SYSBIN), $(OS9ATTR_TEXT) $@,SYS/$(file);)
	$(CD) sys; $(CPL) $(SYSTEXT) ../$@,SYS
	$(foreach file, $(SYSTEXT), $(OS9ATTR_TEXT) $@,SYS/$(file);)
	$(CD) demo; $(CPL) $(DEMO) ../$@,DEMO
	$(foreach file, $(DEMO), $(OS9ATTR_TEXT) $@,DEMO/$(file);)
	$(CPL) $(ROOTFILES) $@,.
	$(foreach file, $(ROOTFILES), $(OS9ATTR_TEXT) $@,$(file);)

$(DSK68_DW3):
	$(RM) $@
	$(OS9FORMAT_SS80) $@ -q -n"Multi-Vue"
	$(MERGE) $(BOOTFILE68_DW3)>os9boot
	$(MERGE) $(KERNEL68_DW3)>kernel
	$(OS9GEN) $@ -b=os9boot -t=kernel
	$(RM) os9boot kernel
	$(MAKDIR) $@,CMDS
	$(MAKDIR) $@,CMDS/ICONS
	$(MAKDIR) $@,SYS
	$(MAKDIR) $@,DEMO
	$(CD) cmds_6809; $(CP) $(CMDS68) ../$@,CMDS
	$(foreach file, $(CMDS68), $(OS9ATTR_EXEC) $@,CMDS/$(notdir $(file));)
	$(OS9RENAME) $@,CMDS/gshell AutoEx
	$(CD) icons; $(CP) $(ICONS) ../$@,CMDS/ICONS
	$(foreach file, $(ICONS), $(OS9ATTR_EXEC) $@,CMDS/ICONS/$(file);)
	$(CD) sys; $(CP) $(SYSBIN) ../$@,SYS
	$(foreach file, $(SYSBIN), $(OS9ATTR_TEXT) $@,SYS/$(file);)
	$(CD) sys; $(CPL) $(SYSTEXT) ../$@,SYS
	$(foreach file, $(SYSTEXT), $(OS9ATTR_TEXT) $@,SYS/$(file);)
	$(CD) demo; $(CPL) $(DEMO) ../$@,DEMO
	$(foreach file, $(DEMO), $(OS9ATTR_TEXT) $@,DEMO/$(file);)
	$(CPL) $(ROOTFILES) $@,.
	$(foreach file, $(ROOTFILES), $(OS9ATTR_TEXT) $@,$(file);)

$(DSK68_DW3_BECKER):
	$(RM) $@
	$(OS9FORMAT_SS80) $@ -q -n"Multi-Vue"
	$(MERGE) $(BOOTFILE68_DW3_BECKER)>os9boot
	$(MERGE) $(KERNEL68_DW3_BECKER)>kernel
	$(OS9GEN) $@ -b=os9boot -t=kernel
	$(RM) os9boot kernel
	$(MAKDIR) $@,CMDS
	$(MAKDIR) $@,CMDS/ICONS
	$(MAKDIR) $@,SYS
	$(MAKDIR) $@,DEMO
	$(CD) cmds_6809; $(CP) $(CMDS68) ../$@,CMDS
	$(foreach file, $(CMDS68), $(OS9ATTR_EXEC) $@,CMDS/$(notdir $(file));)
	$(OS9RENAME) $@,CMDS/gshell AutoEx
	$(CD) icons; $(CP) $(ICONS) ../$@,CMDS/ICONS
	$(foreach file, $(ICONS), $(OS9ATTR_EXEC) $@,CMDS/ICONS/$(file);)
	$(CD) sys; $(CP) $(SYSBIN) ../$@,SYS
	$(foreach file, $(SYSBIN), $(OS9ATTR_TEXT) $@,SYS/$(file);)
	$(CD) sys; $(CPL) $(SYSTEXT) ../$@,SYS
	$(foreach file, $(SYSTEXT), $(OS9ATTR_TEXT) $@,SYS/$(file);)
	$(CD) demo; $(CPL) $(DEMO) ../$@,DEMO
	$(foreach file, $(DEMO), $(OS9ATTR_TEXT) $@,DEMO/$(file);)
	$(CPL) $(ROOTFILES) $@,.
	$(foreach file, $(ROOTFILES), $(OS9ATTR_TEXT) $@,$(file);)

$(DSK63_DW3):
	$(RM) $@
	$(OS9FORMAT_SS80) $@ -q -n"Multi-Vue"
	$(MERGE) $(BOOTFILE63_DW3)>os9boot
	$(MERGE) $(KERNEL63_DW3)>kernel
	$(OS9GEN) $@ -b=os9boot -t=kernel
	$(RM) os9boot kernel
	$(MAKDIR) $@,CMDS
	$(MAKDIR) $@,CMDS/ICONS
	$(MAKDIR) $@,SYS
	$(MAKDIR) $@,DEMO
	$(CD) cmds_6309; $(CP) $(CMDS63) ../$@,CMDS
	$(foreach file, $(CMDS63), $(OS9ATTR_EXEC) $@,CMDS/$(notdir $(file));)
	$(OS9RENAME) $@,CMDS/gshell AutoEx
	$(CD) icons; $(CP) $(ICONS) ../$@,CMDS/ICONS
	$(foreach file, $(ICONS), $(OS9ATTR_EXEC) $@,CMDS/ICONS/$(file);)
	$(CD) sys; $(CP) $(SYSBIN) ../$@,SYS
	$(foreach file, $(SYSBIN), $(OS9ATTR_TEXT) $@,SYS/$(file);)
	$(CD) sys; $(CPL) $(SYSTEXT) ../$@,SYS
	$(foreach file, $(SYSTEXT), $(OS9ATTR_TEXT) $@,SYS/$(file);)
	$(CD) demo; $(CPL) $(DEMO) ../$@,DEMO
	$(foreach file, $(DEMO), $(OS9ATTR_TEXT) $@,DEMO/$(file);)
	$(CPL) $(ROOTFILES) $@,.
	$(foreach file, $(ROOTFILES), $(OS9ATTR_TEXT) $@,$(file);)

$(DSK63_DW3_BECKER):
	$(RM) $@
	$(OS9FORMAT_SS80) $@ -q -n"Multi-Vue"
	$(MERGE) $(BOOTFILE63_DW3_BECKER)>os9boot
	$(MERGE) $(KERNEL63_DW3_BECKER)>kernel
	$(OS9GEN) $@ -b=os9boot -t=kernel
	$(RM) os9boot kernel
	$(MAKDIR) $@,CMDS
	$(MAKDIR) $@,CMDS/ICONS
	$(MAKDIR) $@,SYS
	$(MAKDIR) $@,DEMO
	$(CD) cmds_6309; $(CP) $(CMDS63) ../$@,CMDS
	$(foreach file, $(CMDS63), $(OS9ATTR_EXEC) $@,CMDS/$(notdir $(file));)
	$(OS9RENAME) $@,CMDS/gshell AutoEx
	$(CD) icons; $(CP) $(ICONS) ../$@,CMDS/ICONS
	$(foreach file, $(ICONS), $(OS9ATTR_EXEC) $@,CMDS/ICONS/$(file);)
	$(CD) sys; $(CP) $(SYSBIN) ../$@,SYS
	$(foreach file, $(SYSBIN), $(OS9ATTR_TEXT) $@,SYS/$(file);)
	$(CD) sys; $(CPL) $(SYSTEXT) ../$@,SYS
	$(foreach file, $(SYSTEXT), $(OS9ATTR_TEXT) $@,SYS/$(file);)
	$(CD) demo; $(CPL) $(DEMO) ../$@,DEMO
	$(foreach file, $(DEMO), $(OS9ATTR_TEXT) $@,DEMO/$(file);)
	$(CPL) $(ROOTFILES) $@,.
	$(foreach file, $(ROOTFILES), $(OS9ATTR_TEXT) $@,$(file);)

dskcopy: dsk
	$(CP) $(DSKS) $(DSKDIR)

dskclean:
	$(RM) $(DSKS)

info:
	@$(ECHO) "*** Multi-Vue ***"
	@$(foreach dsk, $(DSKS), $(ECHO) $(dsk);)

