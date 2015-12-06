include port.mak

# Level 1 - Specify which shell should be used
#WHICHSHELL	= shellplus
WHICHSHELL	= shell_21

DISTRO		= $(CPU)L$(LEVEL)
DISTRONAME	= nos9$(CPU)l$(LEVEL)
DISTROVER	= $(DISTRONAME)$(NITROS9VER)$(PORT)
BOOTFILE_COVDG_SD80	= bootfiles/bootfile_covdg_sd80
KERNELFILE_COCOSDC	= bootfiles/kernel_cocosdc
DIRS		= cmds modules defs sys bootfiles wwwroot


CMDS		= $(shell $(CD) cmds; make --no-print-directory showobjs)
CMDS_D2		= $(shell $(CD) cmds; make --no-print-directory showobjs_d2)
CMDS_DW		= $(shell $(CD) cmds; make --no-print-directory showobjs_dw)
BOOTTRACK	= $(shell $(CD) modules; make --no-print-directory showboottrack)
KERNEL		= $(shell $(CD) modules; make --no-print-directory showkernel)
SYSMODS		= $(shell $(CD) modules; make --no-print-directory showsysmods)
CLOCKS		= $(shell $(CD) modules; make --no-print-directory showclocks)
RBF		= $(shell $(CD) modules; make --no-print-directory showrbf)
SCF		= $(shell $(CD) modules; make --no-print-directory showscf)
PIPE		= $(shell $(CD) modules; make --no-print-directory showpipe)
MODULECMDS	= $(WHICHSHELL) del echo format makdir merge os9gen prompt tmode

SYS		= $(shell $(CD) sys; make --no-print-directory showobjs)
WWWROOT		= $(shell $(CD) wwwroot; make --no-print-directory showobjs)
DEFS		= $(shell $(CD) defs; make --no-print-directory showobjs)
STARTUP		= startup
STARTUP_DW	= startup.dw

PACKAGENAME	 = $(DISTROVER).zip
DSK720K         = $(DISTROVER)_80d.dsk
LDSK720K        = $(DISTRONAME)$(PORT)_80d.dsk

DSKS		= $(DSK720K)
LDSKS		= $(LDSK720K)

# Make all components
all:
	@$(ECHO) "************************************************************"
	@$(ECHO) "*"
	@$(ECHO) "*      NitrOS-9/$(CPU) Level $(LEVEL) $(MACHINE) ($(PORT))"
	@$(ECHO) "*"
	@$(ECHO) "************************************************************"
	$(foreach dir,$(DIRS),$(MAKE) -C $(dir) &&) :

# Clean all components
clean:	dskclean
	$(foreach dir, $(DIRS), ($(CD) $(dir); make clean);)

dskclean:
	$(RM) $(PACKAGENAME) $(DSKS) $(LDSKS)

dsk: all $(PACKAGENAME)

dskcopy: dsk
	$(CP) $(DSKS) $(DSKDIR)

scp: dsk
	scp $(PACKAGENAME) boisy@cvs.nitros9.org:/home/nitros9/public_html

$(PACKAGENAME): $(DSKS) ../../ReadMe ../../ChangeLog
	$(ARCHIVE) $@ $^

$(DSK720K):
	$(RM) $@
	$(OS9FORMAT_DS80) -q $@ -n"NitrOS-9/$(CPU) Level $(LEVEL)"
	$(OS9GEN) $@ -b=$(BOOTFILE_COVDG_SD80) -t=$(KERNELFILE_COCOSDC)
	$(MAKDIR) $@,CMDS
	$(MAKDIR) $@,SYS
	$(MAKDIR) $@,DEFS
	$(CD) cmds; $(OS9COPY) $(sort $(CMDS) $(CMDS_D2)) ../$@,CMDS
	$(OS9ATTR_EXEC) $(foreach file,$(sort $(CMDS) $(CMDS_D2)),$@,CMDS/$(file))
	$(OS9RENAME) $@,CMDS/$(WHICHSHELL) shell
	$(CD) sys; $(CPL) $(SYS) ../$@,SYS
	$(OS9ATTR_TEXT) $(foreach file,$(SYS),$@,SYS/$(file))
	$(CD) defs; $(CPL) $(DEFS) ../$@,DEFS
	$(OS9ATTR_TEXT) $(foreach file,$(DEFS),$@,DEFS/$(file))
	$(CPL) $(STARTUP) $@,startup
	$(OS9ATTR_TEXT) $@,startup
	$(MAKDIR) $@,NITROS9
	$(MAKDIR) $@,NITROS9/$(DISTRO)
	$(MAKDIR) $@,NITROS9/$(DISTRO)/CMDS
	$(CD) cmds; $(OS9COPY) $(MODULECMDS) ../$@,NITROS9/$(DISTRO)/CMDS
	$(OS9ATTR_EXEC) $(foreach file,$(MODULECMDS),$@,NITROS9/$(DISTRO)/CMDS/$(file))
	$(OS9RENAME) $@,NITROS9/$(DISTRO)/CMDS/$(WHICHSHELL) shell
	$(MAKDIR) $@,NITROS9/$(DISTRO)/MODULES
	$(MAKDIR) $@,NITROS9/$(DISTRO)/MODULES/BOOTTRACK
	$(CD) modules; $(OS9COPY) $(BOOTTRACK) ../$@,NITROS9/$(DISTRO)/MODULES/BOOTTRACK
	$(OS9ATTR_EXEC) $(foreach file,$(BOOTTRACK),$@,NITROS9/$(DISTRO)/MODULES/BOOTTRACK/$(file))
	$(MAKDIR) $@,NITROS9/$(DISTRO)/MODULES/KERNEL
	$(CD) modules; $(OS9COPY) $(KERNEL) ../$@,NITROS9/$(DISTRO)/MODULES/KERNEL
	$(OS9ATTR_EXEC) $(foreach file,$(KERNEL),$@,NITROS9/$(DISTRO)/MODULES/KERNEL/$(file))
	$(MAKDIR) $@,NITROS9/$(DISTRO)/MODULES/SYSMODS
	$(CD) modules; $(OS9COPY) $(SYSMODS) ../$@,NITROS9/$(DISTRO)/MODULES/SYSMODS
	$(OS9ATTR_EXEC) $(foreach file,$(SYSMODS),$@,NITROS9/$(DISTRO)/MODULES/SYSMODS/$(file))
	$(MAKDIR) $@,NITROS9/$(DISTRO)/MODULES/CLOCKS
	$(CD) modules; $(OS9COPY) $(CLOCKS) ../$@,NITROS9/$(DISTRO)/MODULES/CLOCKS
	$(OS9ATTR_EXEC) $(foreach file,$(CLOCKS),$@,NITROS9/$(DISTRO)/MODULES/CLOCKS/$(file))
	$(MAKDIR) $@,NITROS9/$(DISTRO)/MODULES/RBF
	$(CD) modules; $(OS9COPY) $(RBF) ../$@,NITROS9/$(DISTRO)/MODULES/RBF
	$(OS9ATTR_EXEC) $(foreach file,$(RBF),$@,NITROS9/$(DISTRO)/MODULES/RBF/$(file))
	$(MAKDIR) $@,NITROS9/$(DISTRO)/MODULES/SCF
	$(CD) modules; $(OS9COPY) $(SCF) ../$@,NITROS9/$(DISTRO)/MODULES/SCF
	$(OS9ATTR_EXEC) $(foreach file,$(SCF),$@,NITROS9/$(DISTRO)/MODULES/SCF/$(file))
	$(MAKDIR) $@,NITROS9/$(DISTRO)/MODULES/PIPE
	$(CD) modules; $(OS9COPY) $(PIPE) ../$@,NITROS9/$(DISTRO)/MODULES/PIPE
	$(OS9ATTR_EXEC) $(foreach file,$(PIPE),$@,NITROS9/$(DISTRO)/MODULES/PIPE/$(file))
	$(MAKDIR) $@,NITROS9/$(DISTRO)/BOOTLISTS
	$(CD) bootlists; $(CPL) *.bl ../$@,NITROS9/$(DISTRO)/BOOTLISTS
	$(MAKDIR) $@,NITROS9/$(DISTRO)/SCRIPTS
	$(CD) scripts; $(CPL) mb* ../$@,NITROS9/$(DISTRO)/SCRIPTS
	$(RM) $(LDSK720K)
	$(SOFTLINK) $@ $(LDSK720K)

info:
	@$(ECHO) "*** NitrOS-9/$(CPU) Level $(LEVEL) for the $(MACHINE) ***"
	@$(foreach dsk, $(DSKS), $(ECHO) $(dsk);)

