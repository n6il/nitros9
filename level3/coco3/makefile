PORT = coco3
include $(NITROS9DIR)/rules.mak

CPU		= 6809
LEVEL		= 3

DISTRO		= $(CPU)L$(LEVEL)
DISTRONAME	= nos9$(CPU)l$(LEVEL)
DISTROVER	= $(DISTRONAME)$(NITROS9VER)$(PORT)
BOOTFILE_DW3	= bootfiles/bootfile_dw3
BOOTFILE_40D	= bootfiles/bootfile_40d
BOOTFILE_80D	= bootfiles/bootfile_80d
BOOTFILE_40D_50HZ	= bootfiles/bootfile_40d_50hz
BOOTFILE_80D_50HZ	= bootfiles/bootfile_80d_50hz
KERNELFILE	= bootfiles/kernel_1773
KERNELFILE_50HZ	= bootfiles/kernel_1773_50hz
KERNELFILE_DW3	= bootfiles/kernel_dw3
DIRS		= cmds modules defs sys bootfiles

CMDS		= $(shell $(CD) cmds; make showobjs)
CMDS_D2		= $(shell $(CD) cmds; make showobjs_d2)
BOOTTRACK	= $(shell $(CD) modules; make showboottrack)
KERNEL		= $(shell $(CD) modules; make showkernel)
SYSMODS		= $(shell $(CD) modules; make showsysmods)
CLOCKS		= $(shell $(CD) modules; make showclocks)
RBF		= $(shell $(CD) modules; make showrbf)
SCF		= $(shell $(CD) modules; make showscf)
PIPE		= $(shell $(CD) modules; make showpipe)
MODULECMDS	= shell grfdrv del echo format makdir merge os9gen prompt tmode

DEFS		= $(shell $(CD) defs; make showobjs)
SYSBIN		= $(shell $(CD) sys; make showbinobjs)
SYSTEXT		= $(shell $(CD) sys; make showtextobjs)
STARTUP		= startup
SYSGO		= sysgo_dd

PACKAGENAME	= $(DISTROVER).zip
DSKDW3		= $(DISTROVER)_dw3.dsk
LDSKDW3		= $(DISTRONAME)_dw3.dsk
DSK360K_1	= $(DISTROVER)_40d_1.dsk
LDSK360K_1	= $(DISTRONAME)_40d_1.dsk
DSK360K_1_50HZ	= $(DISTROVER)_40d_1_50hz.dsk
LDSK360K_1_50HZ	= $(DISTRONAME)_40d_1_50hz.dsk
DSK360K_2	= $(DISTROVER)_40d_2.dsk
LDSK360K_2	= $(DISTRONAME)_40d_2.dsk
DSK720K		= $(DISTROVER)_80d.dsk
LDSK720K	= $(DISTRONAME)_80d.dsk
DSK720K_50HZ	= $(DISTROVER)_80d_50hz.dsk
LDSK720K_50HZ	= $(DISTRONAME)_80d_50hz.dsk
TESTDSK		= test.dsk

DSKS		= $(DSKDW3) $(DSK360K_1) $(DSK360K_1_50HZ) $(DSK360K_2) $(DSK720K) $(DSK720K_50HZ)
LDSKS		= $(LDSKDW3) $(LDSK360K_1) $(LDSK360K_1_50HZ) $(LDSK360K_2) $(LDSK720K) $(LDSK720K_50HZ)

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
	-$(RM) $(PACKAGENAME) $(DSKS) $(LDSKS)

dsk: all $(PACKAGENAME)

dskcopy: dsk
	$(CP) $(DSKS) $(DSKDIR)

scp: dsk
	scp $(PACKAGENAME) boisy@cvs.nitros9.org:/home/nitros9/public_html

$(PACKAGENAME): $(DSKS) ../../ReadMe ../../ChangeLog
	$(ARCHIVE) $@ $^

$(DSKDW3):
	-$(RM) $@
	$(OS9FORMAT_DW3) -q $@ -n"NitrOS-9/$(CPU) Level 2"
	$(OS9GEN) $@ -b=$(BOOTFILE_DW3) -t=$(KERNELFILE_DW3)
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
	$(CPL) $(STARTUP) $@,.
	$(foreach file, $(STARTUP), $(OS9ATTR_TEXT) $@,$(file);)
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
	$(RM) $(LDSKDW3)
	$(SOFTLINK) $@ $(LDSKDW3)

$(DSK360K_1):
	-$(RM) $@
	$(OS9FORMAT_DS40) -q $@ -n"NitrOS-9/$(CPU) Level 2 Disk 1"
	$(OS9GEN) $@ -b=$(BOOTFILE_40D) -t=$(KERNELFILE)
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
	$(CPL) $(STARTUP) $@,.
	$(foreach file, $(STARTUP), $(OS9ATTR_TEXT) $@,$(file);)
	$(RM) $(LDSK360K_1)
	$(SOFTLINK) $@ $(LDSK360K_1)

$(DSK360K_1_50HZ):
	-$(RM) $@
	$(OS9FORMAT_DS40) -q $@ -n"NitrOS-9/$(CPU) Level 2 Disk 1"
	$(OS9GEN) $@ -b=$(BOOTFILE_40D_50HZ) -t=$(KERNELFILE_50HZ)
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
	$(CPL) $(STARTUP) $@,.
	$(foreach file, $(STARTUP), $(OS9ATTR_TEXT) $@,$(file);)
	$(RM) $(LDSK360K_1_50HZ)
	$(SOFTLINK) $@ $(LDSK360K_1_50HZ)

$(DSK360K_2):
	-$(RM) $@
	$(OS9FORMAT_DS40) -q $@ -n"NitrOS-9/$(CPU) Level 2 Disk 2"
	$(MAKDIR) $@,CMDS
	$(CD) cmds; $(CP) $(CMDS_D2) ../$@,CMDS
	$(foreach file, $(CMDS_D2), $(OS9ATTR_EXEC) $@,CMDS/$(file);)
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
	$(RM) $(LDSK360K_2)
	$(SOFTLINK) $@ $(LDSK360K_2)

$(DSK720K):
	-$(RM) $@
	$(OS9FORMAT_DS80) -q $@ -n"NitrOS-9/$(CPU) Level 2"
	$(OS9GEN) $@ -b=$(BOOTFILE_80D) -t=$(KERNELFILE)
	$(MAKDIR) $@,CMDS
	$(MAKDIR) $@,SYS
	$(MAKDIR) $@,DEFS
	$(CP) modules/$(SYSGO) $@,sysgo
	$(OS9ATTR_EXEC) $@,sysgo
	$(CD) cmds; $(CP) $(CMDS) ../$@,CMDS
	$(foreach file, $(CMDS), $(OS9ATTR_EXEC) $@,CMDS/$(file);)
	$(CD) cmds; $(CP) $(CMDS_D2) ../$@,CMDS
	$(foreach file, $(CMDS_D2), $(OS9ATTR_EXEC) $@,CMDS/$(file);)
	$(CD) sys; $(CP) $(SYSBIN) ../$@,SYS
	$(foreach file, $(SYSBIN), $(OS9ATTR_TEXT) $@,SYS/$(file);)
	$(CD) sys; $(CPL) $(SYSTEXT) ../$@,SYS
	$(foreach file, $(SYSTEXT), $(OS9ATTR_TEXT) $@,SYS/$(file);)
	$(CD) defs; $(CPL) $(DEFS) ../$@,DEFS
	$(foreach file, $(DEFS), $(OS9ATTR_TEXT) $@,DEFS/$(file);)
	$(CPL) $(STARTUP) $@,.
	$(foreach file, $(STARTUP), $(OS9ATTR_TEXT) $@,$(file);)
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
	$(RM) $(LDSK720K)
	$(SOFTLINK) $@ $(LDSK720K)

$(DSK720K_50HZ):
	-$(RM) $@
	$(OS9FORMAT_DS80) -q $@ -n"NitrOS-9/$(CPU) Level 2"
	$(OS9GEN) $@ -b=$(BOOTFILE_80D_50HZ) -t=$(KERNELFILE_50HZ)
	$(MAKDIR) $@,CMDS
	$(MAKDIR) $@,SYS
	$(MAKDIR) $@,DEFS
	$(CP) modules/$(SYSGO) $@,sysgo
	$(OS9ATTR_EXEC) $@,sysgo
	$(CD) cmds; $(CP) $(CMDS) ../$@,CMDS
	$(foreach file, $(CMDS), $(OS9ATTR_EXEC) $@,CMDS/$(file);)
	$(CD) cmds; $(CP) $(CMDS_D2) ../$@,CMDS
	$(foreach file, $(CMDS_D2), $(OS9ATTR_EXEC) $@,CMDS/$(file);)
	$(CD) sys; $(CP) $(SYSBIN) ../$@,SYS
	$(foreach file, $(SYSBIN), $(OS9ATTR_TEXT) $@,SYS/$(file);)
	$(CD) sys; $(CPL) $(SYSTEXT) ../$@,SYS
	$(foreach file, $(SYSTEXT), $(OS9ATTR_TEXT) $@,SYS/$(file);)
	$(CD) defs; $(CPL) $(DEFS) ../$@,DEFS
	$(foreach file, $(DEFS), $(OS9ATTR_TEXT) $@,DEFS/$(file);)
	$(CPL) $(STARTUP) $@,.
	$(foreach file, $(STARTUP), $(OS9ATTR_TEXT) $@,$(file);)
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
	$(RM) $(LDSK720K_50HZ)
	$(SOFTLINK) $@ $(LDSK720K_50HZ)

info:
	@$(ECHO) "*** NitrOS-9/6809 Level 2 for the Tandy Color Computer 3 ***"
	@$(foreach dsk, $(DSKS), $(ECHO) $(dsk);)
