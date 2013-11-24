PORT = tano
ifndef  NITROS9DIR
NITROS9DIR      = $(HOME)/nitros9
endif
include $(NITROS9DIR)/rules.mak

CPU		= 6809
LEVEL		= 1

# Level 1 - Specify which shell should be used
#WHICHSHELL	= shellplus
WHICHSHELL	= shell_21

DISTRO		= $(CPU)L$(LEVEL)
DISTRONAME	= nos9$(CPU)l$(LEVEL)
DISTROVER	= $(DISTRONAME)$(NITROS9VER)$(PORT)
BOOTFILE_COVDG	= bootfiles/bootfile_covdg_ds40
BOOTFILE_COHR	= bootfiles/bootfile_cohr_ds40
BOOTFILE_COVDG_DS80	= bootfiles/bootfile_covdg_ds80
BOOTFILE_COHR_DS80	= bootfiles/bootfile_cohr_ds80
KERNELFILE	= bootfiles/kernel
DIRS		= cmds modules defs sys bootfiles


CMDS		= $(shell $(CD) cmds; make --no-print-directory showcocoobjs)
BOOTTRACK	= $(shell $(CD) modules; make --no-print-directory showboottrack)
KERNEL		= $(shell $(CD) modules; make --no-print-directory showkernel)
SYSMODS		= $(shell $(CD) modules; make --no-print-directory showsysmods)
CLOCKS		= $(shell $(CD) modules; make --no-print-directory showclocks)
RBF		= $(shell $(CD) modules; make --no-print-directory showrbf)
SCF		= $(shell $(CD) modules; make --no-print-directory showscf)
PIPE		= $(shell $(CD) modules; make --no-print-directory showpipe)
MODULECMDS	= $(WHICHSHELL) del echo format makdir merge os9gen prompt tmode

SYS		= $(shell $(CD) sys; make --no-print-directory showobjs)
DEFS		= $(shell $(CD) defs; make --no-print-directory showobjs)
ROOTFILES	= startup

PACKAGENAME	= $(DISTROVER).zip
DSK360K_1       = $(DISTROVER)_40d_1.dsk
LDSK360K_1      = $(DISTRONAME)_40d_1.dsk
DSK360K_2       = $(DISTROVER)_40d_2.dsk
LDSK360K_2      = $(DISTRONAME)_40d_2.dsk
DSK720K         = $(DISTROVER)_80d.dsk
LDSK720K        = $(DISTRONAME)_80d.dsk

ARCHIVE_DSKS	= $(DSK360K_1) $(DSK360K_2) $(DSK720K)

# Make all components
all:
	@$(ECHO) "**************************************************"
	@$(ECHO) "*                                                *"
	@$(ECHO) "*         NitrOS-9/6809 Level 1 Tano Port        *"
	@$(ECHO) "*                                                *"
	@$(ECHO) "**************************************************"
	$(foreach dir, $(DIRS), ($(CD) $(dir); make);)

# Clean all components
clean:	dskclean
	$(foreach dir, $(DIRS), ($(CD) $(dir); make clean);)

dskclean:
	-$(RM) $(PACKAGENAME) $(DSK360K_1) $(LDSK360K_1) \
	$(DSK360K_2) $(LDSK360K_2) $(DSK720K) $(LDSK720K)


dsk: all $(PACKAGENAME)

dskcopy: dsk
	$(CP) $(ARCHIVE_DSKS) $(DSKDIR)

scp: dsk
	scp $(PACKAGENAME) boisy@cvs.nitros9.org:/home/nitros9/public_html

$(PACKAGENAME): $(ARCHIVE_DSKS) ../../ReadMe ../../ChangeLog
	$(ARCHIVE) $@ $^

$(DSK360K_1):
	$(RM) $@
	$(OS9FORMAT_DS40) -dr -q $@ -n"NitrOS-9/6809 Level 1 Disk 1"
	$(OS9GEN) $@ -d -b=$(BOOTFILE_COVDG) -t=$(KERNELFILE)
	$(MAKDIR) $@,CMDS
	$(MAKDIR) $@,SYS
	$(CD) cmds; $(OS9COPY) $(CMDS) ../$@,CMDS
	$(foreach file, $(CMDS), $(OS9ATTR_EXEC) $@,CMDS/$(file);)
	$(OS9RENAME) $@,CMDS/$(WHICHSHELL) shell
	$(CD) sys; $(CPL) $(SYS) ../$@,SYS
	$(foreach file, $(SYS), $(OS9ATTR_TEXT) $@,SYS/$(file);)
	$(MAKDIR) $@,DEFS
	$(CD) defs; $(CPL) $(DEFS) ../$@,DEFS
	$(foreach file, $(DEFS), $(OS9ATTR_TEXT) $@,DEFS/$(file);)
	$(CPL) $(ROOTFILES) $@,.
	$(foreach file, $(ROOTFILES), $(OS9ATTR_TEXT) $@,$(file);)
	$(RM) $(LDSK360K_1)
	$(SOFTLINK) $@ $(LDSK360K_1)

$(DSK360K_2):
	$(RM) $@
	$(OS9FORMAT_DS40) -dr -q $@ -n"NitrOS-9/6809 Level 1 Disk 2"
	$(MAKDIR) $@,NITROS9
	$(MAKDIR) $@,NITROS9/6809L1
	$(MAKDIR) $@,NITROS9/6809L1/CMDS
	$(CD) cmds; $(OS9COPY) $(MODULECMDS) ../$@,NITROS9/6809L1/CMDS
	$(foreach file, $(MODULECMDS), $(OS9ATTR_EXEC) $@,NITROS9/6809L1/CMDS/$(file);)
	$(OS9RENAME) $@,NITROS9/6809L1/CMDS//$(WHICHSHELL) shell
	$(MAKDIR) $@,NITROS9/6809L1/MODULES
	$(MAKDIR) $@,NITROS9/6809L1/MODULES/BOOTTRACK
	$(CD) modules; $(OS9COPY) $(BOOTTRACK) ../$@,NITROS9/6809L1/MODULES/BOOTTRACK
	$(foreach file, $(BOOTTRACK), $(OS9ATTR_EXEC) $@,NITROS9/6809L1/MODULES/BOOTTRACK/$(file);)
	$(MAKDIR) $@,NITROS9/6809L1/MODULES/KERNEL
	$(CD) modules; $(OS9COPY) $(KERNEL) ../$@,NITROS9/6809L1/MODULES/KERNEL
	$(foreach file, $(KERNEL), $(OS9ATTR_EXEC) $@,NITROS9/6809L1/MODULES/KERNEL/$(file);)
	$(MAKDIR) $@,NITROS9/6809L1/MODULES/SYSMODS
	$(CD) modules; $(OS9COPY) $(SYSMODS) ../$@,NITROS9/6809L1/MODULES/SYSMODS
	$(foreach file, $(SYSMODS), $(OS9ATTR_EXEC) $@,NITROS9/6809L1/MODULES/SYSMODS/$(file);)
	$(MAKDIR) $@,NITROS9/6809L1/MODULES/CLOCKS
	$(CD) modules; $(OS9COPY) $(CLOCKS) ../$@,NITROS9/6809L1/MODULES/CLOCKS
	$(foreach file, $(CLOCKS), $(OS9ATTR_EXEC) $@,NITROS9/6809L1/MODULES/CLOCKS/$(file);)
	$(MAKDIR) $@,NITROS9/6809L1/MODULES/RBF
	$(CD) modules; $(OS9COPY) $(RBF) ../$@,NITROS9/6809L1/MODULES/RBF
	$(foreach file, $(RBF), $(OS9ATTR_EXEC) $@,NITROS9/6809L1/MODULES/RBF/$(file);)
	$(MAKDIR) $@,NITROS9/6809L1/MODULES/SCF
	$(CD) modules; $(OS9COPY) $(SCF) ../$@,NITROS9/6809L1/MODULES/SCF
	$(foreach file, $(SCF), $(OS9ATTR_EXEC) $@,NITROS9/6809L1/MODULES/SCF/$(file);)
	$(MAKDIR) $@,NITROS9/6809L1/MODULES/PIPE
	$(CD) modules; $(OS9COPY) $(PIPE) ../$@,NITROS9/6809L1/MODULES/PIPE
	$(foreach file, $(PIPE), $(OS9ATTR_EXEC) $@,NITROS9/6809L1/MODULES/PIPE/$(file);)
	$(MAKDIR) $@,NITROS9/6809L1/BOOTLISTS
	$(CD) bootlists; $(CPL) *.bl ../$@,NITROS9/6809L1/BOOTLISTS
	$(MAKDIR) $@,NITROS9/6809L1/SCRIPTS
	$(CD) scripts; $(CPL) mb* ../$@,NITROS9/6809L1/SCRIPTS
	$(RM) $(LDSK360K_2)
	$(SOFTLINK) $@ $(LDSK360K_2)

$(DSK720K):
	$(RM) $@
	$(OS9FORMAT_DS80) -dr -q -c2 $@ -n"NitrOS-9/6809 Level 1"
	$(OS9GEN) $@ -d -b=$(BOOTFILE_COVDG_DS80) -t=$(KERNELFILE)
	$(MAKDIR) $@,CMDS
	$(MAKDIR) $@,SYS
	$(MAKDIR) $@,DEFS
	$(CD) cmds; $(OS9COPY) $(CMDS) ../$@,CMDS
	$(foreach file, $(CMDS), $(OS9ATTR_EXEC) $@,CMDS/$(file);)
	$(OS9RENAME) $@,CMDS/$(WHICHSHELL) shell
	$(CD) sys; $(CPL) $(SYS) ../$@,SYS
	$(foreach file, $(SYS), $(OS9ATTR_TEXT) $@,SYS/$(file);)
	$(CD) defs; $(CPL) $(DEFS) ../$@,DEFS
	$(foreach file, $(DEFS), $(OS9ATTR_TEXT) $@,DEFS/$(file);)
	$(CPL) $(ROOTFILES) $@,.
	$(foreach file, $(ROOTFILES), $(OS9ATTR_TEXT) $@,$(file);)
	$(MAKDIR) $@,NITROS9
	$(MAKDIR) $@,NITROS9/6809L1
	$(MAKDIR) $@,NITROS9/6809L1/CMDS
	$(CD) cmds; $(OS9COPY) $(MODULECMDS) ../$@,NITROS9/6809L1/CMDS
	$(foreach file, $(MODULECMDS), $(OS9ATTR_EXEC) $@,NITROS9/6809L1/CMDS/$(file);)
	$(OS9RENAME) $@,NITROS9/6809L1/CMDS/$(WHICHSHELL) shell
	$(MAKDIR) $@,NITROS9/6809L1/MODULES
	$(MAKDIR) $@,NITROS9/6809L1/MODULES/BOOTTRACK
	$(CD) modules; $(OS9COPY) $(BOOTTRACK) ../$@,NITROS9/6809L1/MODULES/BOOTTRACK
	$(foreach file, $(BOOTTRACK), $(OS9ATTR_EXEC) $@,NITROS9/6809L1/MODULES/BOOTTRACK/$(file);)
	$(MAKDIR) $@,NITROS9/6809L1/MODULES/KERNEL
	$(CD) modules; $(OS9COPY) $(KERNEL) ../$@,NITROS9/6809L1/MODULES/KERNEL
	$(foreach file, $(KERNEL), $(OS9ATTR_EXEC) $@,NITROS9/6809L1/MODULES/KERNEL/$(file);)
	$(MAKDIR) $@,NITROS9/6809L1/MODULES/SYSMODS
	$(CD) modules; $(OS9COPY) $(SYSMODS) ../$@,NITROS9/6809L1/MODULES/SYSMODS
	$(foreach file, $(SYSMODS), $(OS9ATTR_EXEC) $@,NITROS9/6809L1/MODULES/SYSMODS/$(file);)
	$(MAKDIR) $@,NITROS9/6809L1/MODULES/CLOCKS
	$(CD) modules; $(OS9COPY) $(CLOCKS) ../$@,NITROS9/6809L1/MODULES/CLOCKS
	$(foreach file, $(CLOCKS), $(OS9ATTR_EXEC) $@,NITROS9/6809L1/MODULES/CLOCKS/$(file);)
	$(MAKDIR) $@,NITROS9/6809L1/MODULES/RBF
	$(CD) modules; $(OS9COPY) $(RBF) ../$@,NITROS9/6809L1/MODULES/RBF
	$(foreach file, $(RBF), $(OS9ATTR_EXEC) $@,NITROS9/6809L1/MODULES/RBF/$(file);)
	$(MAKDIR) $@,NITROS9/6809L1/MODULES/SCF
	$(CD) modules; $(OS9COPY) $(SCF) ../$@,NITROS9/6809L1/MODULES/SCF
	$(foreach file, $(SCF), $(OS9ATTR_EXEC) $@,NITROS9/6809L1/MODULES/SCF/$(file);)
	$(MAKDIR) $@,NITROS9/6809L1/MODULES/PIPE
	$(CD) modules; $(OS9COPY) $(PIPE) ../$@,NITROS9/6809L1/MODULES/PIPE
	$(foreach file, $(PIPE), $(OS9ATTR_EXEC) $@,NITROS9/6809L1/MODULES/PIPE/$(file);)
	$(MAKDIR) $@,NITROS9/6809L1/BOOTLISTS
	$(CD) bootlists; $(CPL) *.bl ../$@,NITROS9/6809L1/BOOTLISTS
	$(MAKDIR) $@,NITROS9/6809L1/SCRIPTS
	$(CD) scripts; $(CPL) mb* ../$@,NITROS9/6809L1/SCRIPTS
	$(RM) $(LDSK720K)
	$(SOFTLINK) $@ $(LDSK720K)

info:
	@$(ECHO) "*** NitrOS-9/6809 Level 1 for the Tano Dragon ***"
	@$(foreach dsk, $(ARCHIVE_DSKS), $(ECHO) $(dsk);)
