include $(NITROS9DIR)/rules.mak

6809L2		= $(NITROS9DIR)/level2/coco3
DEPENDS		= ./makefile

CMD		= $(6809L2)/cmds
DISK_40D	= arcadepack_40d.dsk
DISK_80D	= arcadepack_80d.dsk
CMDS		= grfdrv runb
SHELLMODS	= $(CMD)/shell_21 $(CMD)/dir $(CMD)/echo $(CMD)/link $(CMD)/load $(CMD)/mdir
		
SMASHCMDS	= $(shell $(CD) smash; make showobjs)
SMASHSYS	= $(shell $(CD) smash; make showsys)
SMASHROOT	= $(shell $(CD) smash; make showroot)
THEXCMDS	= $(shell $(CD) thexder; make showobjs)
THEXSYS		= $(shell $(CD) thexder; make showsys)
THEXROOT	= $(shell $(CD) thexder; make showroot)
SHANGCMDS	= $(shell $(CD) shanghai; make showobjs)
SHANGSYS	= $(shell $(CD) shanghai; make showsys)
SHANGROOT	= $(shell $(CD) shanghai; make showroot)
MD		= $(6809L2)/modules

# We make our own bootfile and kernel track
KERNEL		= $(MD)/rel_40 $(MD)/boot_1773_6ms $(MD)/krn
OS9BOOT_40D	= $(MD)/krnp2 $(MD)/ioman $(MD)/init \
		$(MD)/rbf.mn \
		$(MD)/rb1773.dr $(MD)/ddd0_40d.dd \
		$(MD)/scf.mn $(MD)/vtio.dr \
		$(MD)/keydrv_cc3.sb $(MD)/joydrv_joy.sb $(MD)/snddrv_cc3.sb \
		$(MD)/cogrf.io $(MD)/term_win40.dt $(MD)/w.dw $(MD)/w1.dw \
		$(MD)/w2.dw $(MD)/w3.dw $(MD)/w4.dw $(MD)/w5.dw \
		$(MD)/w6.dw $(MD)/w7.dw \
		$(MD)/clock_60hz $(MD)/clock2_soft $(MD)/sysgo_dd

OS9BOOT_80D	= $(MD)/krnp2 $(MD)/ioman $(MD)/init \
		$(MD)/rbf.mn \
		$(MD)/rb1773.dr $(MD)/ddd0_80d.dd \
		$(MD)/scf.mn $(MD)/vtio.dr \
		$(MD)/keydrv_cc3.sb $(MD)/joydrv_joy.sb $(MD)/snddrv_cc3.sb \
		$(MD)/cogrf.io $(MD)/term_win40.dt $(MD)/w.dw $(MD)/w1.dw \
		$(MD)/w2.dw $(MD)/w3.dw $(MD)/w4.dw $(MD)/w5.dw \
		$(MD)/w6.dw $(MD)/w7.dw \
		$(MD)/clock_60hz $(MD)/clock2_soft $(MD)/sysgo_dd

ALLOBJS		= $(CMDS)

all: shell
	$(CD) smash; make
	$(CD) thexder; make
	$(CD) shanghai; make

dsk:	$(DISK_40D) $(DISK_80D)

shell:	$(DEPENDS)
	$(MERGE) $(SHELLMODS)>$@
	@$(ECHO) "*** Be sure the size of this file is less than 7681 bytes! ***"
	@ls -l $@
	@$(ECHO) ""

$(DISK_40D): all
	$(CD) $(6809L2); make
	$(OS9FORMAT_DS40) $@ -n"NitrOS-9 Arcade Pack"
	$(MERGE) $(OS9BOOT_40D)>os9boot
	$(MERGE) $(KERNEL)>kernel_1773
	$(OS9GEN) $@ -b=os9boot -t=kernel_1773
	$(RM) os9boot kernel_1773
	$(MAKDIR) $@,CMDS
	$(CP) shell $@,CMDS
	$(RM) shell
	$(OS9ATTR_EXEC) $@,CMDS/shell
	$(foreach file, $(CMDS), $(CP) $(6809L2)/cmds/$(file) $@,CMDS/$(file);)
	$(foreach file, $(CMDS), $(OS9ATTR_EXEC) $@,CMDS/$(file);)
	$(foreach file, $(SMASHCMDS), $(CP) smash/$(file) $@,CMDS/$(file);)
	$(foreach file, $(SMASHCMDS), $(OS9ATTR_EXEC) $@,CMDS/$(file);)
	$(foreach file, $(THEXCMDS), $(CP) thexder/$(file) $@,CMDS/$(file);)
	$(foreach file, $(THEXCMDS), $(OS9ATTR_EXEC) $@,CMDS/$(file);)
	$(foreach file, $(SHANGCMDS), $(CP) shanghai/$(file) $@,CMDS/$(file);)
	$(foreach file, $(SHANGCMDS), $(OS9ATTR_EXEC) $@,CMDS/$(file);)
	$(foreach file, $(CMDS), $(OS9ATTR_EXEC) $@,CMDS/$(file);)
	$(MAKDIR) $@,SYS
	$(foreach file, $(SMASHSYS), $(CP) smash/$(file) $@,SYS/$(file);)
	$(foreach file, $(THEXSYS), $(CP) thexder/$(file) $@,SYS/$(file);)
	$(foreach file, $(SHANGSYS), $(CP) shanghai/$(file) $@,SYS/$(file);)
	$(foreach file, $(SMASHROOT), $(CP) smash/$(file) $@,$(file);)
	$(foreach file, $(THEXROOT), $(CP) thexder/$(file) $@,$(file);)
	$(foreach file, $(SHANGROOT), $(CP) shanghai/$(file) $@,$(file);)
	$(CPL) startup $@,

$(DISK_80D): all
	$(CD) $(6809L2); make
	$(OS9FORMAT_DS80) $@ -n"NitrOS-9 Arcade Pack"
	$(MERGE) $(OS9BOOT_80D)>os9boot
	$(MERGE) $(KERNEL)>kernel_1773
	$(OS9GEN) $@ -b=os9boot -t=kernel_1773
	$(RM) os9boot kernel_1773
	$(MAKDIR) $@,CMDS
	$(CP) shell $@,CMDS/shell
	$(RM) shell
	$(OS9ATTR_EXEC) $@,CMDS/shell
	$(foreach file, $(CMDS), $(CP) $(6809L2)/cmds/$(file) $@,CMDS/$(file);)
	$(foreach file, $(CMDS), $(OS9ATTR_EXEC) $@,CMDS/$(file);)
	$(foreach file, $(SMASHCMDS), $(CP) smash/$(file) $@,CMDS/$(file);)
	$(foreach file, $(SMASHCMDS), $(OS9ATTR_EXEC) $@,CMDS/$(file);)
	$(foreach file, $(THEXCMDS), $(CP) thexder/$(file) $@,CMDS/$(file);)
	$(foreach file, $(THEXCMDS), $(OS9ATTR_EXEC) $@,CMDS/$(file);)
	$(foreach file, $(SHANGCMDS), $(CP) shanghai/$(file) $@,CMDS/$(file);)
	$(foreach file, $(SHANGCMDS), $(OS9ATTR_EXEC) $@,CMDS/$(file);)
	$(foreach file, $(CMDS), $(OS9ATTR_EXEC) $@,CMDS/$(file);)
	$(MAKDIR) $@,SYS
	$(foreach file, $(SMASHSYS), $(CP) smash/$(file) $@,SYS/$(file);)
	$(foreach file, $(THEXSYS), $(CP) thexder/$(file) $@,SYS/$(file);)
	$(foreach file, $(SHANGSYS), $(CP) shanghai/$(file) $@,SYS/$(file);)
	$(foreach file, $(SMASHROOT), $(CP) smash/$(file) $@,$(file);)
	$(foreach file, $(THEXROOT), $(CP) thexder/$(file) $@,$(file);)
	$(foreach file, $(SHANGROOT), $(CP) shanghai/$(file) $@,$(file);)
	$(CPL) startup $@,

clean:	dskclean
	$(CD) smash; make clean
	$(CD) thexder; make clean
	$(CD) shanghai; make clean

dskclean:
	$(RM) $(DISK_40D) $(DISK_80D)

info:
	@$(ECHO) "*** NitrOS-9 Arcade Pak ***"
	@$(ECHO) $(DISK_40D) $(DISK_80D)

