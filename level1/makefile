# Makefile for OS-9 Level One

include ../Makefile.rules

RELEASE		= os9l1v030101
BOOTFILE	= BOOTFILES/bootfile_stock
KERNEL		= BOOTFILES/kernel_stock
DIRS		= CMDS MODULES DEFS SYS BOOTFILES

CMDS		= $(shell $(CD) CMDS; make showcocoobjs)
MODULES		= $(shell $(CD) MODULES; make showcopyobjs)
SYS		= $(shell $(CD) SYS; make showobjs)
DEFS		= $(shell $(CD) DEFS; make showobjs)
ROOTFILES	= startup

PACKAGENAME	= $(RELEASE).zip
DSK1		= $(RELEASE)_ds40_1.dsk
DSK2		= $(RELEASE)_ds40_2.dsk

# Make all components
all:
	@$(ECHO) "*********************************************"
	@$(ECHO) "*                                           *"
	@$(ECHO) "*        OS-9 Level One Distribution        *"
	@$(ECHO) "*                                           *"
	@$(ECHO) "*********************************************"
	$(foreach dir, $(DIRS), ($(CD) $(dir); make);)

# Clean all components
clean:	dskclean
	$(foreach dir, $(DIRS), ($(CD) $(dir); make clean);)

dskclean:
	-$(RM) $(PACKAGENAME) $(DSK1) $(DSK2)

dsk: all $(PACKAGENAME)

dskcopy: dsk
	$(CP) $(DSK1) $(DSK2) $(PACKAGENAME) $(DSKDIR)

$(PACKAGENAME): $(DSK1) $(DSK2) ReadMe ChangeLog
	$(ARCHIVE) $@ $^

$(DSK1):
	$(RM) $@
	$(OS9FORMAT_DS40) $@ -n"OS-9 Level One System Disk"
	$(OS9GEN) $@ -b=$(BOOTFILE) -t=$(KERNEL)
	$(MAKDIR) $@,CMDS
	$(MAKDIR) $@,SYS
	$(CD) CMDS; $(CP) $(CMDS) ../$@,CMDS
	$(foreach file, $(CMDS), $(OS9ATTR_EXEC) $@,CMDS/$(file);)
	$(CD) SYS; $(CPL) $(SYS) ../$@,SYS
	$(foreach file, $(SYS), $(OS9ATTR_TEXT) $@,SYS/$(file);)
	$(MAKDIR) $@,DEFS
	$(CD) DEFS; $(CPL) $(DEFS) ../$@,DEFS
	$(foreach file, $(DEFS), $(OS9ATTR_TEXT) $@,DEFS/$(file);)
	$(CPL) $(ROOTFILES) $@,.
	$(foreach file, $(ROOTFILES), $(OS9ATTR_TEXT) $@,$(file);)

$(DSK2):
	$(RM) $@
	$(OS9FORMAT_DS40) $@ -n"OS-9 Level One Modules Disk"
	$(MAKDIR) $@,MODULES
	$(CD) MODULES; $(CP) $(MODULES) ../$@,MODULES
	$(foreach file, $(MODULES), $(OS9ATTR_EXEC) $@,MODULES/$(file);)

