include ../Makefile.rules

RELEASE		= os9l2v030101
BOOTFILE	= bootfile_vdg
KERNEL		= kernel_stock

CMDS		= $(shell $(CD) CMDS; make showobjs)
MODULES		= $(shell $(CD) MODULES; make showcopyobjs)
DEFS		= $(shell $(CD) DEFS; make showobjs)
SYSBIN		= $(shell $(CD) SYS; make showbinobjs)
SYSTEXT		= $(shell $(CD) SYS; make showtextobjs)
ROOTFILES	= startup upgrade_song
SYSGO		= cc3go

PACKAGENAME	= $(RELEASE).zip
DSK1		= $(RELEASE)_ds40_1.dsk
DSK2		= $(RELEASE)_ds40_2.dsk
TESTDSK		= test.dsk


# Make all components
all:
	@$(ECHO) "*********************************************"
	@$(ECHO) "*                                           *"
	@$(ECHO) "*      OS-9 Level Two Vr3 Distribution      *"
	@$(ECHO) "*        The Rumored Upgrade Version        *"
	@$(ECHO) "*                                           *"
	@$(ECHO) "*********************************************"
	$(CD) CMDS; make
	$(CD) MODULES; make
	$(CD) DEFS; make
	$(CD) SYS; make
	$(CD) BOOTFILES; make

# Clean all components
clean: dskclean
	-$(CD) CMDS; make clean
	-$(CD) MODULES; make clean
	-$(CD) DEFS; make clean
	-$(CD) SYS; make clean
	-$(CD) BOOTFILES; make clean

dskclean:
	-$(RM) $(PACKAGENAME) $(DSK1) $(DSK2)

dsk: all $(PACKAGENAME)

dskcopy: dsk
	$(CP) $(DSK1) $(DSK2) $(PACKAGENAME) $(DSKDIR)

$(PACKAGENAME): $(DSK1) $(DSK2)
	$(ARCHIVE) $(PACKAGENAME) $(DSK1) $(DSK2) ReadMe ChangeLog

$(DSK1):
	-$(RM) $(DSK1)
	$(OS9FORMAT_DS40) -e $@ -n"OS-9 Level Two System Disk"
	$(OS9GEN) $@ -b=BOOTFILES/$(BOOTFILE) -t=BOOTFILES/$(KERNEL)
	$(MAKDIR) $@,CMDS
	$(MAKDIR) $@,SYS
	$(MAKDIR) $@,DEFS
	$(CP) MODULES/$(SYSGO) $@,
	$(OS9ATTR_EXEC) $@,$(SYSGO)
	$(CD) CMDS; $(CP) $(CMDS) ../$@,CMDS
	$(foreach file, $(CMDS), $(OS9ATTR_EXEC) $@,CMDS/$(file);)
	$(CD) SYS; $(CP) $(SYSBIN) ../$@,SYS
	$(foreach file, $(SYSBIN), $(OS9ATTR_TEXT) $@,SYS/$(file);)
	$(CD) SYS; $(CPL) $(SYSTEXT) ../$@,SYS
	$(foreach file, $(SYSTEXT), $(OS9ATTR_TEXT) $@,SYS/$(file);)
	$(CD) DEFS; $(CPL) $(DEFS) ../$@,DEFS
	$(foreach file, $(DEFS), $(OS9ATTR_TEXT) $@,DEFS/$(file);)
	$(CPL) $(ROOTFILES) $@,.
	$(foreach file, $(ROOTFILES), $(OS9ATTR_TEXT) $@,$(file);)

$(DSK2):
	-$(RM) $(DSK2)
	$(OS9FORMAT_DS40) -e $(DSK2) -n"OS-9 Level Two Modules Disk"
	$(MAKDIR) $(DSK2),MODULES
	$(CD) MODULES; $(CP) $(MODULES) ../$(DSK2),MODULES
	$(foreach file, $(MODULES), $(OS9ATTR_EXEC) $@,MODULES/$(file);)

