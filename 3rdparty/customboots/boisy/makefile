include $(NITROS9DIR)/rules.mak

vpath %.asm ..:$(LEVEL2)/cmds:$(LEVEL1)/cmds:$(NITROS9DIR)/3rdparty/packages/basic09

DEPENDS		= ./makefile

DSK 		= test.dsk
DISTDIR		= $(LEVEL2)/coco3
CD		= $(DISTDIR)/cmds
MD		= $(DISTDIR)/modules
DSKS		= $(DSK)

CMDS		= $(CD)/shell
SYSGO		= $(MD)/sysgo_dd

# We make our own bootfile and kernel track
KERNEL		= $(MD)/rel_80 $(MD)/boot_dw3 $(MD)/krn
BOOTFILE	= $(MD)/krnp2 $(MD)/ioman $(MD)/init \
		$(MD)/dw3.sb \
		$(MD)/scf.mn \
		$(MD)/scdwt.dr $(MD)/term_scdwt.dt \
		$(MD)/clock_60hz $(MD)/clock2_dw3 \
		$(SYSGO) $(CD)/shell_21 \
		$(CD)/mdir $(CD)/pmap $(CD)/dmem $(CD)/dump
#		$(MD)/rbf.mn \
#		$(MD)/rbdw3.dr $(MD)/ddx0.dd \

SUPPORTFILES	= startup

ALLOBJS		= $(CMDS)

all:	$(ALLOBJS)

clean:	dskclean

dsk:	all $(DSKS)

$(DSK):
	$(RM) $@
	$(CD) $(DISDIR); make
	$(OS9FORMAT_SS80) -q $@ -n"NitrOS-9 Level 2 DriveWire Server"
	$(MERGE) $(BOOTFILE)>os9boot
	$(MERGE) $(KERNEL)>kernel
	$(OS9GEN) $@ -b=os9boot -t=kernel
	$(RM) os9boot kernel
	$(CP) $(SYSGO) $@,sysgo
	$(OS9ATTR_EXEC) $@,sysgo
	$(MAKDIR) $@,CMDS
	$(CP) $(CMDS) $@,CMDS
	$(foreach file, $(CMDS), $(OS9ATTR_EXEC) $@,CMDS/$(notdir $(file));)
	$(CPL) $(SUPPORTFILES) $@,.
	$(foreach file, $(SUPPORTFILES), $(OS9ATTR_TEXT) $@,$(file);)

dskcopy: dsk
	$(CP) $(DSKS) $(DSKDIR)

dskclean:
	$(RM) $(DSKS)

info:
	@$(ECHO) "*** NitrOS-9 DriveWire Server ***"
	@$(foreach dsk, $(DSKS), $(ECHO) $(dsk);)
