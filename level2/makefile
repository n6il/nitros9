include ../rules.mak

CPU		= 6809
DISTRO		= $(CPU)L2
RELEASE		= nos9$(CPU)l2v030202
BOOTFILE	= bootfiles/bootfile_win80
BOOTFILE_DS80	= bootfiles/bootfile_win80_ds80
KERNELFILE	= bootfiles/kernel_1773
DIRS		= cmds modules defs sys bootfiles

CMDS		= $(shell $(CD) cmds; make showobjs)
BOOTTRACK	= $(shell $(CD) modules; make showboottrack)
KERNEL		= $(shell $(CD) modules; make showkernel)
SYSMODS		= $(shell $(CD) modules; make showsysmods)
CLOCKS		= $(shell $(CD) modules; make showclocks)
RBF		= $(shell $(CD) modules; make showrbf)
SCF		= $(shell $(CD) modules; make showscf)
PIPE		= $(shell $(CD) modules; make showpipe)
MODULECMDS	= shell grfdrv del echo format makdir merge os9gen prompt

DEFS		= $(shell $(CD) defs; make showobjs)
SYSBIN		= $(shell $(CD) sys; make showbinobjs)
SYSTEXT		= $(shell $(CD) sys; make showtextobjs)
ROOTFILES	= startup
SYSGO		= sysgo_dd

PACKAGENAME	= $(RELEASE).zip
DSK360K_1	= $(RELEASE)_ds40_1.dsk
DSK360K_2	= $(RELEASE)_ds40_2.dsk
DSK720K		= $(RELEASE)_ds80.dsk
TESTDSK		= test.dsk


# Make all components
all:
	@$(ECHO) "**************************************************"
	@$(ECHO) "*                                                *"
	@$(ECHO) "*        NitrOS-9/$(CPU) Level 2 Distribution      *"
	@$(ECHO) "*                                                *"
	@$(ECHO) "**************************************************"
	$(foreach dir, $(DIRS), ($(CD) $(dir); make);)

# Clean all components
clean: dskclean
	$(foreach dir, $(DIRS), ($(CD) $(dir); make clean);)

dskclean:
	-$(RM) $(PACKAGENAME) $(DSK360K_1) $(DSK360K_2) $(DSK720K)

dsk: all $(PACKAGENAME)

dskcopy: dsk
	$(CP) $(DSK360K_1) $(DSK360K_2) $(DSK720K) $(PACKAGENAME) $(DSKDIR)

$(PACKAGENAME): $(DSK360K_1) $(DSK360K_2) $(DSK720K) ReadMe ChangeLog
	$(ARCHIVE) $@ $^

$(DSK360K_1):
	-$(RM) $@
	$(OS9FORMAT_DS40) -q $@ -n"NitrOS-9/$(CPU) Level 2 Disk 1"
	$(OS9GEN) $@ -b=$(BOOTFILE) -t=$(KERNELFILE)
	$(MAKDIR) $@,CMDS
	$(MAKDIR) $@,SYS
	$(MAKDIR) $@,DEFS
	$(CP) modules/$(SYSGO) $@,sysgo
	$(OS9ATTR_EXEC) $@,sysgo
	$(CD) cmds; $(CP) $(CMDS) ../$@,CMDS
	$(foreach file, $(CMDS), $(OS9ATTR_EXEC) $@,CMDS/$(file);)
	$(CD) sys; $(CP) $(SYSBIN) ../$@,SYS
	$(foreach file, $(SYSBIN), $(OS9ATTR_TEXT) $@,SYS/$(file);)
	$(CD) sys; $(CPL) $(SYSTEXT) ../$@,SYS
	$(foreach file, $(SYSTEXT), $(OS9ATTR_TEXT) $@,SYS/$(file);)
	$(CD) defs; $(CPL) $(DEFS) ../$@,DEFS
	$(foreach file, $(DEFS), $(OS9ATTR_TEXT) $@,DEFS/$(file);)
	$(CPL) $(ROOTFILES) $@,.
	$(foreach file, $(ROOTFILES), $(OS9ATTR_TEXT) $@,$(file);)

$(DSK360K_2):
	-$(RM) $@
	$(OS9FORMAT_DS40) -q $@ -n"NitrOS-9/$(CPU) Level 2 Disk 2"
	$(MAKDIR) $@,NITROS9
	$(MAKDIR) $@,NITROS9/$(DISTRO)
	$(MAKDIR) $@,NITROS9/$(DISTRO)/CMDS
	$(CD) cmds; $(CP) $(MODULECMDS) ../$@,NITROS9/$(DISTRO)/CMDS
	$(foreach file, $(MODULECMDS), $(OS9ATTR_EXEC) $@,NITROS9/$(DISTRO)/CMDS/$(file);)
	$(MAKDIR) $@,NITROS9/$(DISTRO)/MODULES
	$(MAKDIR) $@,NITROS9/$(DISTRO)/MODULES/BOOTTRACK
	$(CD) modules; $(CP) $(BOOTTRACK) ../$@,NITROS9/$(DISTRO)/MODULES/BOOTTRACK
	$(foreach file, $(BOOTTRACK), $(OS9ATTR_EXEC) $@,NITROS9/$(DISTRO)/MODULES/BOOTTRACK/$(file);)
	$(MAKDIR) $@,NITROS9/$(DISTRO)/MODULES/KERNEL
	$(CD) modules; $(CP) $(KERNEL) ../$@,NITROS9/$(DISTRO)/MODULES/KERNEL
	$(foreach file, $(KERNEL), $(OS9ATTR_EXEC) $@,NITROS9/$(DISTRO)/MODULES/KERNEL/$(file);)
	$(MAKDIR) $@,NITROS9/$(DISTRO)/MODULES/SYSMODS
	$(CD) modules; $(CP) $(SYSMODS) ../$@,NITROS9/$(DISTRO)/MODULES/SYSMODS
	$(foreach file, $(SYSMODS), $(OS9ATTR_EXEC) $@,NITROS9/$(DISTRO)/MODULES/SYSMODS/$(file);)
	$(MAKDIR) $@,NITROS9/$(DISTRO)/MODULES/CLOCKS
	$(CD) modules; $(CP) $(CLOCKS) ../$@,NITROS9/$(DISTRO)/MODULES/CLOCKS
	$(foreach file, $(CLOCKS), $(OS9ATTR_EXEC) $@,NITROS9/$(DISTRO)/MODULES/CLOCKS/$(file);)
	$(MAKDIR) $@,NITROS9/$(DISTRO)/MODULES/RBF
	$(CD) modules; $(CP) $(RBF) ../$@,NITROS9/$(DISTRO)/MODULES/RBF
	$(foreach file, $(RBF), $(OS9ATTR_EXEC) $@,NITROS9/$(DISTRO)/MODULES/RBF/$(file);)
	$(MAKDIR) $@,NITROS9/$(DISTRO)/MODULES/SCF
	$(CD) modules; $(CP) $(SCF) ../$@,NITROS9/$(DISTRO)/MODULES/SCF
	$(foreach file, $(SCF), $(OS9ATTR_EXEC) $@,NITROS9/$(DISTRO)/MODULES/SCF/$(file);)
	$(MAKDIR) $@,NITROS9/$(DISTRO)/MODULES/PIPE
	$(CD) modules; $(CP) $(PIPE) ../$@,NITROS9/$(DISTRO)/MODULES/PIPE
	$(foreach file, $(PIPE), $(OS9ATTR_EXEC) $@,NITROS9/$(DISTRO)/MODULES/PIPE/$(file);)
	$(MAKDIR) $@,NITROS9/$(DISTRO)/BOOTLISTS
	$(CD) bootlists; $(CPL) *.bl ../$@,NITROS9/$(DISTRO)/BOOTLISTS
	$(MAKDIR) $@,NITROS9/$(DISTRO)/SCRIPTS
	$(CD) scripts; $(CPL) mb* ../$@,NITROS9/$(DISTRO)/SCRIPTS

$(DSK720K):
	-$(RM) $@
	$(OS9FORMAT_DS80) -q $@ -n"NitrOS-9/6809 Level 2"
	$(OS9GEN) $@ -b=$(BOOTFILE_DS80) -t=$(KERNELFILE)
	$(MAKDIR) $@,CMDS
	$(MAKDIR) $@,SYS
	$(MAKDIR) $@,DEFS
	$(CP) modules/$(SYSGO) $@,sysgo
	$(OS9ATTR_EXEC) $@,sysgo
	$(CD) cmds; $(CP) $(CMDS) ../$@,CMDS
	$(foreach file, $(CMDS), $(OS9ATTR_EXEC) $@,CMDS/$(file);)
	$(CD) sys; $(CP) $(SYSBIN) ../$@,SYS
	$(foreach file, $(SYSBIN), $(OS9ATTR_TEXT) $@,SYS/$(file);)
	$(CD) sys; $(CPL) $(SYSTEXT) ../$@,SYS
	$(foreach file, $(SYSTEXT), $(OS9ATTR_TEXT) $@,SYS/$(file);)
	$(CD) defs; $(CPL) $(DEFS) ../$@,DEFS
	$(foreach file, $(DEFS), $(OS9ATTR_TEXT) $@,DEFS/$(file);)
	$(CPL) $(ROOTFILES) $@,.
	$(foreach file, $(ROOTFILES), $(OS9ATTR_TEXT) $@,$(file);)
	$(MAKDIR) $@,NITROS9
	$(MAKDIR) $@,NITROS9/$(DISTRO)
	$(MAKDIR) $@,NITROS9/$(DISTRO)/CMDS
	$(CD) cmds; $(CP) $(MODULECMDS) ../$@,NITROS9/$(DISTRO)/CMDS
	$(foreach file, $(MODULECMDS), $(OS9ATTR_EXEC) $@,NITROS9/$(DISTRO)/CMDS/$(file);)
	$(MAKDIR) $@,NITROS9/$(DISTRO)/MODULES
	$(MAKDIR) $@,NITROS9/$(DISTRO)/MODULES/BOOTTRACK
	$(CD) modules; $(CP) $(BOOTTRACK) ../$@,NITROS9/$(DISTRO)/MODULES/BOOTTRACK
	$(foreach file, $(BOOTTRACK), $(OS9ATTR_EXEC) $@,NITROS9/$(DISTRO)/MODULES/BOOTTRACK/$(file);)
	$(MAKDIR) $@,NITROS9/$(DISTRO)/MODULES/KERNEL
	$(CD) modules; $(CP) $(KERNEL) ../$@,NITROS9/$(DISTRO)/MODULES/KERNEL
	$(foreach file, $(KERNEL), $(OS9ATTR_EXEC) $@,NITROS9/$(DISTRO)/MODULES/KERNEL/$(file);)
	$(MAKDIR) $@,NITROS9/$(DISTRO)/MODULES/SYSMODS
	$(CD) modules; $(CP) $(SYSMODS) ../$@,NITROS9/$(DISTRO)/MODULES/SYSMODS
	$(foreach file, $(SYSMODS), $(OS9ATTR_EXEC) $@,NITROS9/$(DISTRO)/MODULES/SYSMODS/$(file);)
	$(MAKDIR) $@,NITROS9/$(DISTRO)/MODULES/CLOCKS
	$(CD) modules; $(CP) $(CLOCKS) ../$@,NITROS9/$(DISTRO)/MODULES/CLOCKS
	$(foreach file, $(CLOCKS), $(OS9ATTR_EXEC) $@,NITROS9/$(DISTRO)/MODULES/CLOCKS/$(file);)
	$(MAKDIR) $@,NITROS9/$(DISTRO)/MODULES/RBF
	$(CD) modules; $(CP) $(RBF) ../$@,NITROS9/$(DISTRO)/MODULES/RBF
	$(foreach file, $(RBF), $(OS9ATTR_EXEC) $@,NITROS9/$(DISTRO)/MODULES/RBF/$(file);)
	$(MAKDIR) $@,NITROS9/$(DISTRO)/MODULES/SCF
	$(CD) modules; $(CP) $(SCF) ../$@,NITROS9/$(DISTRO)/MODULES/SCF
	$(foreach file, $(SCF), $(OS9ATTR_EXEC) $@,NITROS9/$(DISTRO)/MODULES/SCF/$(file);)
	$(MAKDIR) $@,NITROS9/$(DISTRO)/MODULES/PIPE
	$(CD) modules; $(CP) $(PIPE) ../$@,NITROS9/$(DISTRO)/MODULES/PIPE
	$(foreach file, $(PIPE), $(OS9ATTR_EXEC) $@,NITROS9/$(DISTRO)/MODULES/PIPE/$(file);)
	$(MAKDIR) $@,NITROS9/$(DISTRO)/BOOTLISTS
	$(CD) bootlists; $(CPL) *.bl ../$@,NITROS9/$(DISTRO)/BOOTLISTS
	$(MAKDIR) $@,NITROS9/$(DISTRO)/SCRIPTS
	$(CD) scripts; $(CPL) mb* ../$@,NITROS9/$(DISTRO)/SCRIPTS


