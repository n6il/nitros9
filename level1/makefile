# Makefile for OS-9 Level One

include ../Makefile.rules

RELEASE		= os9l1v030105
BOOTFILE	= BOOTFILES/bootfile_stock
KERNELFILE	= BOOTFILES/kernel_stock
DIRS		= CMDS MODULES DEFS SYS BOOTFILES

CMDS		= $(shell $(CD) CMDS; make showcocoobjs)
BOOTTRACK	= $(shell $(CD) MODULES; make showboottrack)
KERNEL		= $(shell $(CD) MODULES; make showkernel)
SYSMODS		= $(shell $(CD) MODULES; make showsysmods)
CLOCKS		= $(shell $(CD) MODULES; make showclocks)
RBF		= $(shell $(CD) MODULES; make showrbf)
SCF		= $(shell $(CD) MODULES; make showscf)
PIPE		= $(shell $(CD) MODULES; make showpipe)
MODULECMDS	= shell del echo format makdir merge os9gen prompt

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
	$(OS9GEN) $@ -b=$(BOOTFILE) -t=$(KERNELFILE)
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
	$(MAKDIR) $@,LEVEL1
	$(MAKDIR) $@,LEVEL1/CMDS
	$(CD) CMDS; $(CP) $(MODULECMDS) ../$@,LEVEL1/CMDS
	$(foreach file, $(MODULECMDS), $(OS9ATTR_EXEC) $@,LEVEL1/CMDS/$(file);)
	$(MAKDIR) $@,LEVEL1/MODULES
	$(MAKDIR) $@,LEVEL1/MODULES/BOOTTRACK
	$(CD) MODULES; $(CP) $(BOOTTRACK) ../$@,LEVEL1/MODULES/BOOTTRACK
	$(foreach file, $(BOOTTRACK), $(OS9ATTR_EXEC) $@,LEVEL1/MODULES/BOOTTRACK/$(file);)
	$(MAKDIR) $@,LEVEL1/MODULES/KERNEL
	$(CD) MODULES; $(CP) $(KERNEL) ../$@,LEVEL1/MODULES/KERNEL
	$(foreach file, $(KERNEL), $(OS9ATTR_EXEC) $@,LEVEL1/MODULES/KERNEL/$(file);)
	$(MAKDIR) $@,LEVEL1/MODULES/SYSMODS
	$(CD) MODULES; $(CP) $(SYSMODS) ../$@,LEVEL1/MODULES/SYSMODS
	$(foreach file, $(SYSMODS), $(OS9ATTR_EXEC) $@,LEVEL1/MODULES/SYSMODS/$(file);)
	$(MAKDIR) $@,LEVEL1/MODULES/CLOCKS
	$(CD) MODULES; $(CP) $(CLOCKS) ../$@,LEVEL1/MODULES/CLOCKS
	$(foreach file, $(CLOCKS), $(OS9ATTR_EXEC) $@,LEVEL1/MODULES/CLOCKS/$(file);)
	$(MAKDIR) $@,LEVEL1/MODULES/RBF
	$(CD) MODULES; $(CP) $(RBF) ../$@,LEVEL1/MODULES/RBF
	$(foreach file, $(RBF), $(OS9ATTR_EXEC) $@,LEVEL1/MODULES/RBF/$(file);)
	$(MAKDIR) $@,LEVEL1/MODULES/SCF
	$(CD) MODULES; $(CP) $(SCF) ../$@,LEVEL1/MODULES/SCF
	$(foreach file, $(SCF), $(OS9ATTR_EXEC) $@,LEVEL1/MODULES/SCF/$(file);)
	$(MAKDIR) $@,LEVEL1/MODULES/PIPE
	$(CD) MODULES; $(CP) $(PIPE) ../$@,LEVEL1/MODULES/PIPE
	$(foreach file, $(PIPE), $(OS9ATTR_EXEC) $@,LEVEL1/MODULES/PIPE/$(file);)
	$(MAKDIR) $@,LEVEL1/BOOTLISTS
	$(CD) BOOTLISTS; $(CPL) *.bl ../$@,LEVEL1/BOOTLISTS
	$(MAKDIR) $@,LEVEL1/BOOTSCRIPTS
	$(CD) BOOTSCRIPTS; $(CPL) mb* ../$@,LEVEL1/BOOTSCRIPTS

