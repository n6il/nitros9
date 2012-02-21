PORT = atari
include $(NITROS9DIR)/rules.mak

CPU		= 6809
LEVEL		= 1

# Level 1 - Specify which shell should be used
#WHICHSHELL	= shellplus
WHICHSHELL	= shell_21

DISTRO		= $(CPU)L$(LEVEL)
DISTRONAME	= nos9$(CPU)l$(LEVEL)
DISTROVER	= $(DISTRONAME)$(NITROS9VER)$(PORT)
BOOTFILE_COVDG	= bootfiles/bootfile_covdg
BOOTFILE_COHR	= bootfiles/bootfile_cohr
BOOTFILE_COVDG_DS80	= bootfiles/bootfile_covdg_ds80
BOOTFILE_HEADLESS_DW3_COCO1	= bootfiles/bootfile_headless_dw3_coco1
BOOTFILE_HEADLESS_DW3_COCO2	= bootfiles/bootfile_headless_dw3_coco2
BOOTFILE_COVDG_DW3_COCO1	= bootfiles/bootfile_covdg_dw3_coco1
BOOTFILE_COVDG_DW3_COCO2	= bootfiles/bootfile_covdg_dw3_coco2
BOOTFILE_COHR_DS80	= bootfiles/bootfile_cohr_ds80
BOOTFILE_COHR_DW3_COCO1	= bootfiles/bootfile_cohr_dw3_coco1
BOOTFILE_COHR_DW3_COCO2	= bootfiles/bootfile_cohr_dw3_coco2
KERNELFILE	= bootfiles/kernel_1773
KERNELFILE_DW3_COCO1	= bootfiles/kernel_dw3_coco1
KERNELFILE_DW3_COCO2	= bootfiles/kernel_dw3_coco2
DIRS		= cmds modules defs sys bootfiles


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
DEFS		= $(shell $(CD) defs; make --no-print-directory showobjs)
STARTUP		= startup
STARTUP_DW	= startup.dw

PACKAGENAME	= $(DISTROVER).zip
DSKDW3COCO1     = $(DISTROVER)1_dw3.dsk
LDSKDW3COCO1    = $(DISTRONAME)coco1_dw3.dsk
DSKDW3COCO2     = $(DISTROVER)2_dw3.dsk
LDSKDW3COCO2    = $(DISTRONAME)coco2_dw3.dsk
DSK360K_1       = $(DISTROVER)_40d_1.dsk
LDSK360K_1      = $(DISTRONAME)_40d_1.dsk
DSK360K_2       = $(DISTROVER)_40d_2.dsk
LDSK360K_2      = $(DISTRONAME)_40d_2.dsk
DSK720K         = $(DISTROVER)_80d.dsk
LDSK720K        = $(DISTRONAME)_80d.dsk


DSKS		= $(DSKDW3COCO1) $(DSKDW3COCO2) $(DSK360K_1) $(DSK360K_2) $(DSK720K)
LDSKS		= $(LDSKDW3COCO1) $(LDSKDW3COCO2) $(LDSK360K_1) $(LDSK360K_2) $(LDSK720K)

# Make all components
all:
	@$(ECHO) "**************************************************"
	@$(ECHO) "*                                                *"
	@$(ECHO) "*         NitrOS-9/$(CPU) Level 1 CoCo Port        *"
	@$(ECHO) "*                                                *"
	@$(ECHO) "**************************************************"
	$(foreach dir, $(DIRS), ($(CD) $(dir); make);)

# Clean all components
clean:	dskclean
	$(foreach dir, $(DIRS), ($(CD) $(dir); make clean);)

dskclean:
	-$(RM) $(PACKAGENAME) $(DSKS) $(LDSKS)

dsk: all $(PACKAGENAME)

dskcopy: dsk
	$(CP) $(DSKS) $(DSKDIR)

scp: dsk
	scp $(PACKAGENAME) boisy@cvs.nitros9.org:/home/nitros9/public_html

$(PACKAGENAME): $(DSKS) ../../ReadMe ../../ChangeLog
	$(ARCHIVE) $@ $^

$(DSKDW3COCO1):
	$(RM) $@
	$(OS9FORMAT_DW3) -q $@ -n"NitrOS-9/$(CPU) Level 1"
	$(OS9GEN) $@ -b=$(BOOTFILE_COVDG_DW3_COCO1) -t=$(KERNELFILE_DW3_COCO1)
	$(MAKDIR) $@,CMDS
	$(MAKDIR) $@,SYS
	$(MAKDIR) $@,DEFS
	$(CD) cmds; $(CP) $(CMDS_DW) ../$@,CMDS
	$(foreach file, $(CMDS_DW), $(OS9ATTR_EXEC) $@,CMDS/$(file);)
	$(CD) cmds; $(CP) $(CMDS_D2) ../$@,CMDS
	$(foreach file, $(CMDS_D2), $(OS9ATTR_EXEC) $@,CMDS/$(file);)
	$(OS9RENAME) $@,CMDS/$(WHICHSHELL) shell
	$(CD) sys; $(CPL) $(SYS) ../$@,SYS
	$(foreach file, $(SYS), $(OS9ATTR_TEXT) $@,SYS/$(file);)
	$(CD) defs; $(CPL) $(DEFS) ../$@,DEFS
	$(foreach file, $(DEFS), $(OS9ATTR_TEXT) $@,DEFS/$(file);)
	$(CPL) $(STARTUP_DW) $@,startup
	$(OS9ATTR_TEXT) $@,startup
	$(MAKDIR) $@,NITROS9
	$(MAKDIR) $@,NITROS9/6809L1
	$(MAKDIR) $@,NITROS9/6809L1/CMDS
	$(CD) cmds; $(CP) $(MODULECMDS) ../$@,NITROS9/6809L1/CMDS
	$(foreach file, $(MODULECMDS), $(OS9ATTR_EXEC) $@,NITROS9/6809L1/CMDS/$(file);)
	$(OS9RENAME) $@,NITROS9/6809L1/CMDS/$(WHICHSHELL) shell
	$(MAKDIR) $@,NITROS9/6809L1/MODULES
	$(MAKDIR) $@,NITROS9/6809L1/MODULES/BOOTTRACK
	$(CD) modules; $(CP) $(BOOTTRACK) ../$@,NITROS9/6809L1/MODULES/BOOTTRACK
	$(foreach file, $(BOOTTRACK), $(OS9ATTR_EXEC) $@,NITROS9/6809L1/MODULES/BOOTTRACK/$(file);)
	$(MAKDIR) $@,NITROS9/6809L1/MODULES/KERNEL
	$(CD) modules; $(CP) $(KERNEL) ../$@,NITROS9/6809L1/MODULES/KERNEL
	$(foreach file, $(KERNEL), $(OS9ATTR_EXEC) $@,NITROS9/6809L1/MODULES/KERNEL/$(file);)
	$(MAKDIR) $@,NITROS9/6809L1/MODULES/SYSMODS
	$(CD) modules; $(CP) $(SYSMODS) ../$@,NITROS9/6809L1/MODULES/SYSMODS
	$(foreach file, $(SYSMODS), $(OS9ATTR_EXEC) $@,NITROS9/6809L1/MODULES/SYSMODS/$(file);)
	$(MAKDIR) $@,NITROS9/6809L1/MODULES/CLOCKS
	$(CD) modules; $(CP) $(CLOCKS) ../$@,NITROS9/6809L1/MODULES/CLOCKS
	$(foreach file, $(CLOCKS), $(OS9ATTR_EXEC) $@,NITROS9/6809L1/MODULES/CLOCKS/$(file);)
	$(MAKDIR) $@,NITROS9/6809L1/MODULES/RBF
	$(CD) modules; $(CP) $(RBF) ../$@,NITROS9/6809L1/MODULES/RBF
	$(foreach file, $(RBF), $(OS9ATTR_EXEC) $@,NITROS9/6809L1/MODULES/RBF/$(file);)
	$(MAKDIR) $@,NITROS9/6809L1/MODULES/SCF
	$(CD) modules; $(CP) $(SCF) ../$@,NITROS9/6809L1/MODULES/SCF
	$(foreach file, $(SCF), $(OS9ATTR_EXEC) $@,NITROS9/6809L1/MODULES/SCF/$(file);)
	$(MAKDIR) $@,NITROS9/6809L1/MODULES/PIPE
	$(CD) modules; $(CP) $(PIPE) ../$@,NITROS9/6809L1/MODULES/PIPE
	$(foreach file, $(PIPE), $(OS9ATTR_EXEC) $@,NITROS9/6809L1/MODULES/PIPE/$(file);)
	$(MAKDIR) $@,NITROS9/6809L1/BOOTLISTS
	$(CD) bootlists; $(CPL) *.bl ../$@,NITROS9/6809L1/BOOTLISTS
	$(MAKDIR) $@,NITROS9/6809L1/SCRIPTS
	$(CD) scripts; $(CPL) mb* ../$@,NITROS9/6809L1/SCRIPTS
	$(RM) $(LDSKDW3COCO1)
	$(SOFTLINK) $@ $(LDSKDW3COCO1)

$(DSKDW3COCO2):
	$(RM) $@
	$(OS9FORMAT_DW3) -q $@ -n"NitrOS-9/6809 Level 1"
	$(OS9GEN) $@ -b=$(BOOTFILE_COVDG_DW3_COCO2) -t=$(KERNELFILE_DW3_COCO2)
	$(MAKDIR) $@,CMDS
	$(MAKDIR) $@,SYS
	$(MAKDIR) $@,DEFS
	$(CD) cmds; $(CP) $(CMDS_DW) ../$@,CMDS
	$(foreach file, $(CMDS_DW), $(OS9ATTR_EXEC) $@,CMDS/$(file);)
	$(CD) cmds; $(CP) $(CMDS_D2) ../$@,CMDS
	$(foreach file, $(CMDS_D2), $(OS9ATTR_EXEC) $@,CMDS/$(file);)
	$(OS9RENAME) $@,CMDS/$(WHICHSHELL) shell
	$(CD) sys; $(CPL) $(SYS) ../$@,SYS
	$(foreach file, $(SYS), $(OS9ATTR_TEXT) $@,SYS/$(file);)
	$(CD) defs; $(CPL) $(DEFS) ../$@,DEFS
	$(foreach file, $(DEFS), $(OS9ATTR_TEXT) $@,DEFS/$(file);)
	$(CPL) $(STARTUP_DW) $@,startup
	$(OS9ATTR_TEXT) $@,startup
	$(MAKDIR) $@,NITROS9
	$(MAKDIR) $@,NITROS9/6809L1
	$(MAKDIR) $@,NITROS9/6809L1/CMDS
	$(CD) cmds; $(CP) $(MODULECMDS) ../$@,NITROS9/6809L1/CMDS
	$(foreach file, $(MODULECMDS), $(OS9ATTR_EXEC) $@,NITROS9/6809L1/CMDS/$(file);)
	$(OS9RENAME) $@,NITROS9/6809L1/CMDS/$(WHICHSHELL) shell
	$(MAKDIR) $@,NITROS9/6809L1/MODULES
	$(MAKDIR) $@,NITROS9/6809L1/MODULES/BOOTTRACK
	$(CD) modules; $(CP) $(BOOTTRACK) ../$@,NITROS9/6809L1/MODULES/BOOTTRACK
	$(foreach file, $(BOOTTRACK), $(OS9ATTR_EXEC) $@,NITROS9/6809L1/MODULES/BOOTTRACK/$(file);)
	$(MAKDIR) $@,NITROS9/6809L1/MODULES/KERNEL
	$(CD) modules; $(CP) $(KERNEL) ../$@,NITROS9/6809L1/MODULES/KERNEL
	$(foreach file, $(KERNEL), $(OS9ATTR_EXEC) $@,NITROS9/6809L1/MODULES/KERNEL/$(file);)
	$(MAKDIR) $@,NITROS9/6809L1/MODULES/SYSMODS
	$(CD) modules; $(CP) $(SYSMODS) ../$@,NITROS9/6809L1/MODULES/SYSMODS
	$(foreach file, $(SYSMODS), $(OS9ATTR_EXEC) $@,NITROS9/6809L1/MODULES/SYSMODS/$(file);)
	$(MAKDIR) $@,NITROS9/6809L1/MODULES/CLOCKS
	$(CD) modules; $(CP) $(CLOCKS) ../$@,NITROS9/6809L1/MODULES/CLOCKS
	$(foreach file, $(CLOCKS), $(OS9ATTR_EXEC) $@,NITROS9/6809L1/MODULES/CLOCKS/$(file);)
	$(MAKDIR) $@,NITROS9/6809L1/MODULES/RBF
	$(CD) modules; $(CP) $(RBF) ../$@,NITROS9/6809L1/MODULES/RBF
	$(foreach file, $(RBF), $(OS9ATTR_EXEC) $@,NITROS9/6809L1/MODULES/RBF/$(file);)
	$(MAKDIR) $@,NITROS9/6809L1/MODULES/SCF
	$(CD) modules; $(CP) $(SCF) ../$@,NITROS9/6809L1/MODULES/SCF
	$(foreach file, $(SCF), $(OS9ATTR_EXEC) $@,NITROS9/6809L1/MODULES/SCF/$(file);)
	$(MAKDIR) $@,NITROS9/6809L1/MODULES/PIPE
	$(CD) modules; $(CP) $(PIPE) ../$@,NITROS9/6809L1/MODULES/PIPE
	$(foreach file, $(PIPE), $(OS9ATTR_EXEC) $@,NITROS9/6809L1/MODULES/PIPE/$(file);)
	$(MAKDIR) $@,NITROS9/6809L1/BOOTLISTS
	$(CD) bootlists; $(CPL) *.bl ../$@,NITROS9/6809L1/BOOTLISTS
	$(MAKDIR) $@,NITROS9/6809L1/SCRIPTS
	$(CD) scripts; $(CPL) mb* ../$@,NITROS9/6809L1/SCRIPTS
	$(RM) $(LDSKDW3COCO2)
	$(SOFTLINK) $@ $(LDSKDW3COCO2)

$(DSK360K_1):
	$(RM) $@
	$(OS9FORMAT_DS40) -q $@ -n"NitrOS-9/6809 Level 1 Disk 1"
	$(OS9GEN) $@ -b=$(BOOTFILE_COVDG) -t=$(KERNELFILE)
	$(MAKDIR) $@,CMDS
	$(MAKDIR) $@,SYS
	$(CD) cmds; $(CP) $(CMDS) ../$@,CMDS
	$(foreach file, $(CMDS), $(OS9ATTR_EXEC) $@,CMDS/$(file);)
	$(OS9RENAME) $@,CMDS/$(WHICHSHELL) shell
	$(CD) sys; $(CPL) $(SYS) ../$@,SYS
	$(foreach file, $(SYS), $(OS9ATTR_TEXT) $@,SYS/$(file);)
	$(MAKDIR) $@,DEFS
	$(CD) defs; $(CPL) $(DEFS) ../$@,DEFS
	$(foreach file, $(DEFS), $(OS9ATTR_TEXT) $@,DEFS/$(file);)
	$(CPL) $(STARTUP) $@,startup
	$(OS9ATTR_TEXT) $@,startup
	$(RM) $(LDSK360K_1)
	$(SOFTLINK) $@ $(LDSK360K_1)

$(DSK360K_2):
	$(RM) $@
	$(OS9FORMAT_DS40) -q $@ -n"NitrOS-9/6809 Level 1 Disk 2"
	$(MAKDIR) $@,CMDS
	$(CD) cmds; $(CP) $(CMDS_D2) ../$@,CMDS
	$(foreach file, $(CMDS_D2), $(OS9ATTR_EXEC) $@,CMDS/$(file);)
	$(MAKDIR) $@,NITROS9
	$(MAKDIR) $@,NITROS9/6809L1
	$(MAKDIR) $@,NITROS9/6809L1/CMDS
	$(CD) cmds; $(CP) $(MODULECMDS) ../$@,NITROS9/6809L1/CMDS
	$(foreach file, $(MODULECMDS), $(OS9ATTR_EXEC) $@,NITROS9/6809L1/CMDS/$(file);)
	$(OS9RENAME) $@,NITROS9/6809L1/CMDS//$(WHICHSHELL) shell
	$(MAKDIR) $@,NITROS9/6809L1/MODULES
	$(MAKDIR) $@,NITROS9/6809L1/MODULES/BOOTTRACK
	$(CD) modules; $(CP) $(BOOTTRACK) ../$@,NITROS9/6809L1/MODULES/BOOTTRACK
	$(foreach file, $(BOOTTRACK), $(OS9ATTR_EXEC) $@,NITROS9/6809L1/MODULES/BOOTTRACK/$(file);)
	$(MAKDIR) $@,NITROS9/6809L1/MODULES/KERNEL
	$(CD) modules; $(CP) $(KERNEL) ../$@,NITROS9/6809L1/MODULES/KERNEL
	$(foreach file, $(KERNEL), $(OS9ATTR_EXEC) $@,NITROS9/6809L1/MODULES/KERNEL/$(file);)
	$(MAKDIR) $@,NITROS9/6809L1/MODULES/SYSMODS
	$(CD) modules; $(CP) $(SYSMODS) ../$@,NITROS9/6809L1/MODULES/SYSMODS
	$(foreach file, $(SYSMODS), $(OS9ATTR_EXEC) $@,NITROS9/6809L1/MODULES/SYSMODS/$(file);)
	$(MAKDIR) $@,NITROS9/6809L1/MODULES/CLOCKS
	$(CD) modules; $(CP) $(CLOCKS) ../$@,NITROS9/6809L1/MODULES/CLOCKS
	$(foreach file, $(CLOCKS), $(OS9ATTR_EXEC) $@,NITROS9/6809L1/MODULES/CLOCKS/$(file);)
	$(MAKDIR) $@,NITROS9/6809L1/MODULES/RBF
	$(CD) modules; $(CP) $(RBF) ../$@,NITROS9/6809L1/MODULES/RBF
	$(foreach file, $(RBF), $(OS9ATTR_EXEC) $@,NITROS9/6809L1/MODULES/RBF/$(file);)
	$(MAKDIR) $@,NITROS9/6809L1/MODULES/SCF
	$(CD) modules; $(CP) $(SCF) ../$@,NITROS9/6809L1/MODULES/SCF
	$(foreach file, $(SCF), $(OS9ATTR_EXEC) $@,NITROS9/6809L1/MODULES/SCF/$(file);)
	$(MAKDIR) $@,NITROS9/6809L1/MODULES/PIPE
	$(CD) modules; $(CP) $(PIPE) ../$@,NITROS9/6809L1/MODULES/PIPE
	$(foreach file, $(PIPE), $(OS9ATTR_EXEC) $@,NITROS9/6809L1/MODULES/PIPE/$(file);)
	$(MAKDIR) $@,NITROS9/6809L1/BOOTLISTS
	$(CD) bootlists; $(CPL) *.bl ../$@,NITROS9/6809L1/BOOTLISTS
	$(MAKDIR) $@,NITROS9/6809L1/SCRIPTS
	$(CD) scripts; $(CPL) mb* ../$@,NITROS9/6809L1/SCRIPTS
	$(RM) $(LDSK360K_2)
	$(SOFTLINK) $@ $(LDSK360K_2)

$(DSK720K):
	$(RM) $@
	$(OS9FORMAT_DS80) -q $@ -n"NitrOS-9/6809 Level 1"
	$(OS9GEN) $@ -b=$(BOOTFILE_COVDG_DS80) -t=$(KERNELFILE)
	$(MAKDIR) $@,CMDS
	$(MAKDIR) $@,SYS
	$(MAKDIR) $@,DEFS
	$(CD) cmds; $(CP) $(CMDS) ../$@,CMDS
	$(foreach file, $(CMDS), $(OS9ATTR_EXEC) $@,CMDS/$(file);)
	$(CD) cmds; $(CP) $(CMDS_D2) ../$@,CMDS
	$(foreach file, $(CMDS_D2), $(OS9ATTR_EXEC) $@,CMDS/$(file);)
	$(OS9RENAME) $@,CMDS/$(WHICHSHELL) shell
	$(CD) sys; $(CPL) $(SYS) ../$@,SYS
	$(foreach file, $(SYS), $(OS9ATTR_TEXT) $@,SYS/$(file);)
	$(CD) defs; $(CPL) $(DEFS) ../$@,DEFS
	$(foreach file, $(DEFS), $(OS9ATTR_TEXT) $@,DEFS/$(file);)
	$(CPL) $(STARTUP) $@,startup
	$(OS9ATTR_TEXT) $@,startup
	$(MAKDIR) $@,NITROS9
	$(MAKDIR) $@,NITROS9/6809L1
	$(MAKDIR) $@,NITROS9/6809L1/CMDS
	$(CD) cmds; $(CP) $(MODULECMDS) ../$@,NITROS9/6809L1/CMDS
	$(foreach file, $(MODULECMDS), $(OS9ATTR_EXEC) $@,NITROS9/6809L1/CMDS/$(file);)
	$(OS9RENAME) $@,NITROS9/6809L1/CMDS/$(WHICHSHELL) shell
	$(MAKDIR) $@,NITROS9/6809L1/MODULES
	$(MAKDIR) $@,NITROS9/6809L1/MODULES/BOOTTRACK
	$(CD) modules; $(CP) $(BOOTTRACK) ../$@,NITROS9/6809L1/MODULES/BOOTTRACK
	$(foreach file, $(BOOTTRACK), $(OS9ATTR_EXEC) $@,NITROS9/6809L1/MODULES/BOOTTRACK/$(file);)
	$(MAKDIR) $@,NITROS9/6809L1/MODULES/KERNEL
	$(CD) modules; $(CP) $(KERNEL) ../$@,NITROS9/6809L1/MODULES/KERNEL
	$(foreach file, $(KERNEL), $(OS9ATTR_EXEC) $@,NITROS9/6809L1/MODULES/KERNEL/$(file);)
	$(MAKDIR) $@,NITROS9/6809L1/MODULES/SYSMODS
	$(CD) modules; $(CP) $(SYSMODS) ../$@,NITROS9/6809L1/MODULES/SYSMODS
	$(foreach file, $(SYSMODS), $(OS9ATTR_EXEC) $@,NITROS9/6809L1/MODULES/SYSMODS/$(file);)
	$(MAKDIR) $@,NITROS9/6809L1/MODULES/CLOCKS
	$(CD) modules; $(CP) $(CLOCKS) ../$@,NITROS9/6809L1/MODULES/CLOCKS
	$(foreach file, $(CLOCKS), $(OS9ATTR_EXEC) $@,NITROS9/6809L1/MODULES/CLOCKS/$(file);)
	$(MAKDIR) $@,NITROS9/6809L1/MODULES/RBF
	$(CD) modules; $(CP) $(RBF) ../$@,NITROS9/6809L1/MODULES/RBF
	$(foreach file, $(RBF), $(OS9ATTR_EXEC) $@,NITROS9/6809L1/MODULES/RBF/$(file);)
	$(MAKDIR) $@,NITROS9/6809L1/MODULES/SCF
	$(CD) modules; $(CP) $(SCF) ../$@,NITROS9/6809L1/MODULES/SCF
	$(foreach file, $(SCF), $(OS9ATTR_EXEC) $@,NITROS9/6809L1/MODULES/SCF/$(file);)
	$(MAKDIR) $@,NITROS9/6809L1/MODULES/PIPE
	$(CD) modules; $(CP) $(PIPE) ../$@,NITROS9/6809L1/MODULES/PIPE
	$(foreach file, $(PIPE), $(OS9ATTR_EXEC) $@,NITROS9/6809L1/MODULES/PIPE/$(file);)
	$(MAKDIR) $@,NITROS9/6809L1/BOOTLISTS
	$(CD) bootlists; $(CPL) *.bl ../$@,NITROS9/6809L1/BOOTLISTS
	$(MAKDIR) $@,NITROS9/6809L1/SCRIPTS
	$(CD) scripts; $(CPL) mb* ../$@,NITROS9/6809L1/SCRIPTS
	$(RM) $(LDSK720K)
	$(SOFTLINK) $@ $(LDSK720K)

info:
	@echo "*** NitrOS-9/6809 Level 1 for the Tandy Color Computer ***" 
	@$(foreach dsk, $(DSKS), $(ECHO) $(dsk);)
	
