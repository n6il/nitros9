# Makefile for OS-9 Level Two

include ../Makefile.rules

RELEASE		= os9l2v030104
BOOTFILE	= BOOTFILES/bootfile_vdg
KERNELFILE	= BOOTFILES/kernel_stock
DIRS		= CMDS MODULES DEFS SYS BOOTFILES

CMDS		= $(shell $(CD) CMDS; make showobjs)
BOOTTRACK	= $(shell $(CD) MODULES; make showboottrack)
KERNEL		= $(shell $(CD) MODULES; make showkernel)
SYSMODS		= $(shell $(CD) MODULES; make showsysmods)
CLOCKS		= $(shell $(CD) MODULES; make showclocks)
RBF		= $(shell $(CD) MODULES; make showrbf)
SCF		= $(shell $(CD) MODULES; make showscf)
PIPE		= $(shell $(CD) MODULES; make showpipe)
MODULECMDS	= shell grfdrv del echo format makdir merge os9gen prompt

DEFS		= $(shell $(CD) DEFS; make showobjs)
SYSBIN		= $(shell $(CD) SYS; make showbinobjs)
SYSTEXT		= $(shell $(CD) SYS; make showtextobjs)
ROOTFILES	= startup
SYSGO		= sysgo_dd

PACKAGENAME	= $(RELEASE).zip
DSK1		= $(RELEASE)_ds40_1.dsk
DSK2		= $(RELEASE)_ds40_2.dsk
TESTDSK		= test.dsk


# Make all components
all:
	@$(ECHO) "*********************************************"
	@$(ECHO) "*                                           *"
	@$(ECHO) "*        OS-9 Level Two Distribution        *"
	@$(ECHO) "*                                           *"
	@$(ECHO) "*********************************************"
	$(foreach dir, $(DIRS), ($(CD) $(dir); make);)

# Clean all components
clean: dskclean
	$(foreach dir, $(DIRS), ($(CD) $(dir); make clean);)

dskclean:
	-$(RM) $(PACKAGENAME) $(DSK1) $(DSK2)

dsk: all $(PACKAGENAME)

dskcopy: dsk
	$(CP) $(DSK1) $(DSK2) $(PACKAGENAME) $(DSKDIR)

$(PACKAGENAME): $(DSK1) $(DSK2) ReadMe ChangeLog
	$(ARCHIVE) $@ $^

$(DSK1):
	-$(RM) $@
	$(OS9FORMAT_DS40) $@ -n"OS-9 Level Two System Disk"
	$(OS9GEN) $@ -b=$(BOOTFILE) -t=$(KERNELFILE)
	$(MAKDIR) $@,CMDS
	$(MAKDIR) $@,SYS
	$(MAKDIR) $@,DEFS
	$(CP) MODULES/$(SYSGO) $@,sysgo
	$(OS9ATTR_EXEC) $@,sysgo
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
	-$(RM) $@
	$(OS9FORMAT_DS40) $@ -n"OS-9 Level Two Modules Disk"
	$(MAKDIR) $@,LEVEL2
	$(MAKDIR) $@,LEVEL2/CMDS
	$(CD) CMDS; $(CP) $(MODULECMDS) ../$@,LEVEL2/CMDS
	$(foreach file, $(MODULECMDS), $(OS9ATTR_EXEC) $@,LEVEL2/CMDS/$(file);)
	$(MAKDIR) $@,LEVEL2/MODULES
	$(MAKDIR) $@,LEVEL2/MODULES/BOOTTRACK
	$(CD) MODULES; $(CP) $(BOOTTRACK) ../$@,LEVEL2/MODULES/BOOTTRACK
	$(foreach file, $(BOOTTRACK), $(OS9ATTR_EXEC) $@,LEVEL2/MODULES/BOOTTRACK/$(file);)
	$(MAKDIR) $@,LEVEL2/MODULES/KERNEL
	$(CD) MODULES; $(CP) $(KERNEL) ../$@,LEVEL2/MODULES/KERNEL
	$(foreach file, $(KERNEL), $(OS9ATTR_EXEC) $@,LEVEL2/MODULES/KERNEL/$(file);)
	$(MAKDIR) $@,LEVEL2/MODULES/SYSMODS
	$(CD) MODULES; $(CP) $(SYSMODS) ../$@,LEVEL2/MODULES/SYSMODS
	$(foreach file, $(SYSMODS), $(OS9ATTR_EXEC) $@,LEVEL2/MODULES/SYSMODS/$(file);)
	$(MAKDIR) $@,LEVEL2/MODULES/CLOCKS
	$(CD) MODULES; $(CP) $(CLOCKS) ../$@,LEVEL2/MODULES/CLOCKS
	$(foreach file, $(CLOCKS), $(OS9ATTR_EXEC) $@,LEVEL2/MODULES/CLOCKS/$(file);)
	$(MAKDIR) $@,LEVEL2/MODULES/RBF
	$(CD) MODULES; $(CP) $(RBF) ../$@,LEVEL2/MODULES/RBF
	$(foreach file, $(RBF), $(OS9ATTR_EXEC) $@,LEVEL2/MODULES/RBF/$(file);)
	$(MAKDIR) $@,LEVEL2/MODULES/SCF
	$(CD) MODULES; $(CP) $(SCF) ../$@,LEVEL2/MODULES/SCF
	$(foreach file, $(SCF), $(OS9ATTR_EXEC) $@,LEVEL2/MODULES/SCF/$(file);)
	$(MAKDIR) $@,LEVEL2/MODULES/PIPE
	$(CD) MODULES; $(CP) $(PIPE) ../$@,LEVEL2/MODULES/PIPE
	$(foreach file, $(PIPE), $(OS9ATTR_EXEC) $@,LEVEL2/MODULES/PIPE/$(file);)
	$(MAKDIR) $@,LEVEL2/BOOTLISTS
	$(CD) BOOTLISTS; $(CPL) *.bl ../$@,LEVEL2/BOOTLISTS
	$(MAKDIR) $@,LEVEL2/BOOTSCRIPTS
	$(CD) BOOTSCRIPTS; $(CPL) mb* ../$@,LEVEL2/BOOTSCRIPTS

