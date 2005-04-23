include ../../../rules.mak

DISK	= deskmate3.dsk

CD68	= $(6809L2)/cmds
MD68	= $(6809L2)/modules

UTILS	= $(CD68)/shell $(CD68)/format $(CD68)/rename
CMDS	= accdata autoex desk dmalt dmapps dmbackup dmcaln dmcards dmdskini \
	dmhelp dmledger dmload dmmenu dmpaint dmterm dmtext dmtim
HELP	= dmalt.hlp dmcaln.hlp dmcards.hlp dmledger.hlp dmmenu.hlp \
	dmpaint.hlp dmterm.hlp dmtext.hlp
ROOTFILES	= Sample.fil

KERNEL68	= $(MD68)/rel_32 $(MD68)/boot_1773_6ms $(MD68)/krn

OS9BOOT68	= $(MD68)/krnp2 $(MD68)/ioman $(MD68)/init \
		$(MD68)/rbf.mn \
		$(MD68)/rb1773.dr $(MD68)/ddd0_40d.dd \
		$(MD68)/d0_40d.dd $(MD68)/d1_40d.dd $(MD68)/d2_40d.dd \
		$(MD68)/scf.mn $(MD68)/cc3io.dr \
		$(MD68)/keydrv_cc3.sb $(MD68)/joydrv_joy.sb $(MD68)/snddrv_cc3.sb \
		$(MD68)/vdgint.io $(MD68)/term_vdg.dt \
		$(MD68)/sc6551.dr $(MD68)/t2_sc6551.dd \
		$(MD68)/clock_60hz $(MD68)/clock2_soft \
		$(MD68)/sysgo_dd

# Make all components
all:
	@$(ECHO) "**************************************************"
	@$(ECHO) "*                                                *"
	@$(ECHO) "*                   DeskMate 3                   *"
	@$(ECHO) "*                                                *"
	@$(ECHO) "**************************************************"

# Clean all components
clean:	dskclean

dsk:	all
	$(RM) $(DISK)
	$(OS9FORMAT_DS40) $(DISK) -q -n"DeskMate 3"
	$(MERGE) $(OS9BOOT68)>os9boot
	$(MERGE) $(KERNEL68)>kernel
	$(OS9GEN) $(DISK) -b=os9boot -t=kernel
	$(RM) os9boot kernel
	$(MAKDIR) $(DISK),CMDS
	$(CP) $(UTILS) $(DISK),CMDS
	$(foreach file, $(UTILS), $(OS9ATTR_EXEC) $(DISK),CMDS/$(notdir $(file));)
	$(CP) $(CMDS) $(DISK),CMDS
	$(foreach file, $(CMDS), $(OS9ATTR_EXEC) $(DISK),CMDS/$(notdir $(file));)
	$(CPL) $(HELP) $(DISK),CMDS
	$(foreach file, $(HELP), $(OS9ATTR_EXEC) $(DISK),CMDS/$(notdir $(file));)
	$(CPL) $(ROOTFILES) $(DISK),.
	$(foreach file, $(ROOTFILES), $(OS9ATTR_TEXT) $(DISK),$(file);)

dskcopy: dsk
	$(CP) $(DISK) $(DSKDIR)

dskclean:
	$(RM) $(DISK)
