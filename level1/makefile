include ../rules.mak

RELEASE		= nos96809l1v030200
BOOTFILE	= BOOTFILES/bootfile_stock
KERNELFILE	= BOOTFILES/kernel_stock
DIRS		= cmds modules defs sys bootfiles

CMDS		= $(shell $(CD) cmds; make showcocoobjs)
BOOTTRACK	= $(shell $(CD) modules; make showboottrack)
KERNEL		= $(shell $(CD) modules; make showkernel)
SYSMODS		= $(shell $(CD) modules; make showsysmods)
CLOCKS		= $(shell $(CD) modules; make showclocks)
RBF		= $(shell $(CD) modules; make showrbf)
SCF		= $(shell $(CD) modules; make showscf)
PIPE		= $(shell $(CD) modules; make showpipe)
MODULECMDS	= shell del echo format makdir merge os9gen prompt

SYS		= $(shell $(CD) sys; make showobjs)
DEFS		= $(shell $(CD) defs; make showobjs)
ROOTFILES	= startup

PACKAGENAME	= $(RELEASE).zip
DSK1		= $(RELEASE)_ds40_1.dsk
DSK2		= $(RELEASE)_ds40_2.dsk


# Make all components
all:
	@$(ECHO) "**************************************************"
	@$(ECHO) "*                                                *"
	@$(ECHO) "*        NitrOS-9/6809 Level 1 Distribution      *"
	@$(ECHO) "*                                                *"
	@$(ECHO) "**************************************************"
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
	$(OS9FORMAT_DS40) $@ -n"NitrOS-9/6809 Level 1 System Disk"
	$(OS9GEN) $@ -b=$(BOOTFILE) -t=$(KERNELFILE)
	$(MAKDIR) $@,CMDS
	$(MAKDIR) $@,SYS
	$(CD) cmds; $(CP) $(CMDS) ../$@,CMDS
	$(foreach file, $(CMDS), $(OS9ATTR_EXEC) $@,CMDS/$(file);)
	$(CD) sys; $(CPL) $(SYS) ../$@,SYS
	$(foreach file, $(SYS), $(OS9ATTR_TEXT) $@,SYS/$(file);)
	$(MAKDIR) $@,DEFS
	$(CD) defs; $(CPL) $(DEFS) ../$@,DEFS
	$(foreach file, $(DEFS), $(OS9ATTR_TEXT) $@,DEFS/$(file);)
	$(CPL) $(ROOTFILES) $@,.
	$(foreach file, $(ROOTFILES), $(OS9ATTR_TEXT) $@,$(file);)

$(DSK2):
	$(RM) $@
	$(OS9FORMAT_DS40) $@ -n"NitrOS-9/6809 Level 1 Modules Disk"
	$(MAKDIR) $@,6809L1
	$(MAKDIR) $@,6809L1/CMDS
	$(CD) cmds; $(CP) $(MODULECMDS) ../$@,6809L1/CMDS
	$(foreach file, $(MODULECMDS), $(OS9ATTR_EXEC) $@,6809L1/CMDS/$(file);)
	$(MAKDIR) $@,6809L1/MODULES
	$(MAKDIR) $@,6809L1/MODULES/BOOTTRACK
	$(CD) modules; $(CP) $(BOOTTRACK) ../$@,6809L1/MODULES/BOOTTRACK
	$(foreach file, $(BOOTTRACK), $(OS9ATTR_EXEC) $@,6809L1/MODULES/BOOTTRACK/$(file);)
	$(MAKDIR) $@,6809L1/MODULES/KERNEL
	$(CD) modules; $(CP) $(KERNEL) ../$@,6809L1/MODULES/KERNEL
	$(foreach file, $(KERNEL), $(OS9ATTR_EXEC) $@,6809L1/MODULES/KERNEL/$(file);)
	$(MAKDIR) $@,6809L1/MODULES/SYSMODS
	$(CD) modules; $(CP) $(SYSMODS) ../$@,6809L1/MODULES/SYSMODS
	$(foreach file, $(SYSMODS), $(OS9ATTR_EXEC) $@,6809L1/MODULES/SYSMODS/$(file);)
	$(MAKDIR) $@,6809L1/MODULES/CLOCKS
	$(CD) modules; $(CP) $(CLOCKS) ../$@,6809L1/MODULES/CLOCKS
	$(foreach file, $(CLOCKS), $(OS9ATTR_EXEC) $@,6809L1/MODULES/CLOCKS/$(file);)
	$(MAKDIR) $@,6809L1/MODULES/RBF
	$(CD) modules; $(CP) $(RBF) ../$@,6809L1/MODULES/RBF
	$(foreach file, $(RBF), $(OS9ATTR_EXEC) $@,6809L1/MODULES/RBF/$(file);)
	$(MAKDIR) $@,6809L1/MODULES/SCF
	$(CD) modules; $(CP) $(SCF) ../$@,6809L1/MODULES/SCF
	$(foreach file, $(SCF), $(OS9ATTR_EXEC) $@,6809L1/MODULES/SCF/$(file);)
	$(MAKDIR) $@,6809L1/MODULES/PIPE
	$(CD) modules; $(CP) $(PIPE) ../$@,6809L1/MODULES/PIPE
	$(foreach file, $(PIPE), $(OS9ATTR_EXEC) $@,6809L1/MODULES/PIPE/$(file);)
	$(MAKDIR) $@,6809L1/BOOTLISTS
	$(CD) bootlists; $(CPL) *.bl ../$@,6809L1/BOOTLISTS
	$(MAKDIR) $@,6809L1/BOOTSCRIPTS
	$(CD) bootscripts; $(CPL) mb* ../$@,6809L1/BOOTSCRIPTS

