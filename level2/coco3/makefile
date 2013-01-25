ifeq ($(CPU),)
        CPU=6809
endif
PORT = coco3
include $(NITROS9DIR)/rules.mak

LEVEL		= 2

DISTRO		= $(CPU)L$(LEVEL)
DISTRONAME	= nos9$(CPU)l$(LEVEL)
DISTROVER	= $(DISTRONAME)$(NITROS9VER)$(PORT)
BOOTFILE_BECKER	= bootfiles/bootfile_becker
BOOTFILE_ARDUINO	= bootfiles/bootfile_arduino
BOOTFILE_DW 	= bootfiles/bootfile_dw
BOOTFILE_DWHEADLESS	= bootfiles/bootfile_dw_headless
BOOTFILE_40D	= bootfiles/bootfile_40d
BOOTFILE_80D	= bootfiles/bootfile_80d
BOOTFILE_40D_50HZ	= bootfiles/bootfile_40d_50hz
BOOTFILE_80D_50HZ	= bootfiles/bootfile_80d_50hz
KERNELFILE_BECKER	= bootfiles/kernel_becker
KERNELFILE_ARDUINO	= bootfiles/kernel_arduino
KERNELFILE	= bootfiles/kernel_1773
KERNELFILE_50HZ	= bootfiles/kernel_1773_50hz
KERNELFILE_DW 	= bootfiles/kernel_dw
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
MODULECMDS	= shell grfdrv del echo format makdir merge os9gen prompt tmode

DEFS		= $(shell $(CD) defs; make --no-print-directory showobjs)
SYSBIN		= $(shell $(CD) sys; make --no-print-directory showbinobjs)
SYSTEXT		= $(shell $(CD) sys; make --no-print-directory showtextobjs)
STARTUP		= startup
STARTUP_DW	= startup.dw
SYSGO		= sysgo_dd
CCBKRN		= ccbkrn

PACKAGENAME	= $(DISTROVER).zip
DSKDW		= $(DISTROVER)_dw.dsk
LDSKDW		= $(DISTRONAME)_dw.dsk
DSKDWHEADLESS	= $(DISTROVER)_dw_headless.dsk
LDSKDWHEADLESS	= $(DISTRONAME)_dw_headless.dsk
DSK360K_1	= $(DISTROVER)_40d_1.dsk
LDSK360K_1	= $(DISTRONAME)_40d_1.dsk
DSK360K_1_50HZ	= $(DISTROVER)_40d_1_50hz.dsk
LDSK360K_1_50HZ	= $(DISTRONAME)_40d_1_50hz.dsk
DSKBECKER	= $(DISTROVER)_becker.dsk
DSKARDUINO	= $(DISTROVER)_arduino.dsk
DSK360K_2	= $(DISTROVER)_40d_2.dsk
LDSK360K_2	= $(DISTRONAME)_40d_2.dsk
DSK720K		= $(DISTROVER)_80d.dsk
LDSK720K	= $(DISTRONAME)_80d.dsk
DSK720K_50HZ	= $(DISTROVER)_80d_50hz.dsk
LDSK720K_50HZ	= $(DISTRONAME)_80d_50hz.dsk
LDSKBECKER	= $(DISTRONAME)_becker.dsk
LDSKARDUINO	= $(DISTRONAME)_arduino.dsk
TESTDSK		= test.dsk

DSKS		= $(DSKDW) $(DSK360K_1) $(DSK360K_1_50HZ) $(DSK360K_2) $(DSK720K) $(DSK720K_50HZ) $(DSKDW) $(DSKDWHEADLESS) $(DSKBECKER) $(DSKARDUINO)
LDSKS		= $(LDSKDW) $(LDSK360K_1) $(LDSK360K_1_50HZ) $(LDSK360K_2) $(LDSK720K) $(LDSK720K_50HZ) $(LDSKDW) $(LDSKDWHEADLESS) $(LDSKBECKER) $(LDSKARDUINO)

# Make all components
all:
	@$(ECHO) "**************************************************"
	@$(ECHO) "*                                                *"
	@$(ECHO) "*        NitrOS-9/$(CPU) Level 2 Distribution    *"
	@$(ECHO) "*                                                *"
	@$(ECHO) "**************************************************"
	cd $(NITROS9DIR)/lib; make
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

$(DSKBECKER):
	-$(RM) $@
	$(OS9FORMAT_DW) -q $@ -n"NitrOS-9/$(CPU) Level 2"
	$(OS9GEN) $@ -b=$(BOOTFILE_BECKER) -t=$(KERNELFILE_BECKER)
	$(MAKDIR) $@,CMDS
	$(MAKDIR) $@,SYS
	$(MAKDIR) $@,DEFS
	$(CP) modules/$(CCBKRN) $@,$(CCBKRN)
	$(CP) modules/$(SYSGO) $@,sysgo
	$(OS9ATTR_EXEC) $@,sysgo
	$(CD) cmds; $(CP) $(CMDS_DW) ../$@,CMDS
	$(foreach file, $(CMDS_DW), $(OS9ATTR_EXEC) $@,CMDS/$(file);)
	$(CD) sys; $(CP) $(SYSBIN) ../$@,SYS
	$(foreach file, $(SYSBIN), $(OS9ATTR_TEXT) $@,SYS/$(file);)
	$(CD) sys; $(CPL) $(SYSTEXT) ../$@,SYS
	$(foreach file, $(SYSTEXT), $(OS9ATTR_TEXT) $@,SYS/$(file);)
	$(CD) defs; $(CPL) $(DEFS) ../$@,DEFS
	$(foreach file, $(DEFS), $(OS9ATTR_TEXT) $@,DEFS/$(file);)
	$(CPL) $(STARTUP_DW) $@,startup
	$(OS9ATTR_TEXT) $@,startup
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
	$(RM) $(LDSKBECKER)
	$(SOFTLINK) $@ $(LDSKBECKER)

$(DSKARDUINO):
	-$(RM) $@
	$(OS9FORMAT_DW) -q $@ -n"NitrOS-9/$(CPU) Level 2"
	$(OS9GEN) $@ -b=$(BOOTFILE_ARDUINO) -t=$(KERNELFILE_ARDUINO)
	$(MAKDIR) $@,CMDS
	$(MAKDIR) $@,SYS
	$(MAKDIR) $@,DEFS
	$(CP) modules/$(CCBKRN) $@,$(CCBKRN)
	$(CP) modules/$(SYSGO) $@,sysgo
	$(OS9ATTR_EXEC) $@,sysgo
	$(CD) cmds; $(CP) $(CMDS_DW) ../$@,CMDS
	$(foreach file, $(CMDS_DW), $(OS9ATTR_EXEC) $@,CMDS/$(file);)
	$(CD) sys; $(CP) $(SYSBIN) ../$@,SYS
	$(foreach file, $(SYSBIN), $(OS9ATTR_TEXT) $@,SYS/$(file);)
	$(CD) sys; $(CPL) $(SYSTEXT) ../$@,SYS
	$(foreach file, $(SYSTEXT), $(OS9ATTR_TEXT) $@,SYS/$(file);)
	$(CD) defs; $(CPL) $(DEFS) ../$@,DEFS
	$(foreach file, $(DEFS), $(OS9ATTR_TEXT) $@,DEFS/$(file);)
	$(CPL) $(STARTUP_DW) $@,startup
	$(OS9ATTR_TEXT) $@,startup
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
	$(RM) $(LDSKARDUINO)
	$(SOFTLINK) $@ $(LDSKARDUINO)

$(DSKDW):
	-$(RM) $@
	$(OS9FORMAT_DW) -q $@ -n"NitrOS-9/$(CPU) Level 2"
	$(OS9GEN) $@ -b=$(BOOTFILE_DW) -t=$(KERNELFILE_DW)
	$(MAKDIR) $@,CMDS
	$(MAKDIR) $@,SYS
	$(MAKDIR) $@,DEFS
	$(CP) modules/$(CCBKRN) $@,$(CCBKRN)
	$(CP) modules/$(SYSGO) $@,sysgo
	$(OS9ATTR_EXEC) $@,sysgo
	$(CD) cmds; $(CP) $(CMDS_DW) ../$@,CMDS
	$(foreach file, $(CMDS_DW), $(OS9ATTR_EXEC) $@,CMDS/$(file);)
	$(CD) sys; $(CP) $(SYSBIN) ../$@,SYS
	$(foreach file, $(SYSBIN), $(OS9ATTR_TEXT) $@,SYS/$(file);)
	$(CD) sys; $(CPL) $(SYSTEXT) ../$@,SYS
	$(foreach file, $(SYSTEXT), $(OS9ATTR_TEXT) $@,SYS/$(file);)
	$(CD) defs; $(CPL) $(DEFS) ../$@,DEFS
	$(foreach file, $(DEFS), $(OS9ATTR_TEXT) $@,DEFS/$(file);)
	$(CPL) $(STARTUP_DW) $@,startup
	$(OS9ATTR_TEXT) $@,startup
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
	$(RM) $(LDSKDW)
	$(SOFTLINK) $@ $(LDSKDW)

$(DSKDWHEADLESS):
	-$(RM) $@
	$(OS9FORMAT_DW) -q $@ -n"NitrOS-9/$(CPU) Level 2"
	$(OS9GEN) $@ -b=$(BOOTFILE_DWHEADLESS) -t=$(KERNELFILE_DW)
	$(MAKDIR) $@,CMDS
	$(MAKDIR) $@,SYS
	$(MAKDIR) $@,DEFS
	$(CP) modules/$(CCBKRN) $@,$(CCBKRN)
	$(CP) modules/$(SYSGO) $@,sysgo
	$(OS9ATTR_EXEC) $@,sysgo
	$(CD) cmds; $(CP) $(CMDS_DW) ../$@,CMDS
	$(foreach file, $(CMDS_DW), $(OS9ATTR_EXEC) $@,CMDS/$(file);)
	$(CD) sys; $(CP) $(SYSBIN) ../$@,SYS
	$(foreach file, $(SYSBIN), $(OS9ATTR_TEXT) $@,SYS/$(file);)
	$(CD) sys; $(CPL) $(SYSTEXT) ../$@,SYS
	$(foreach file, $(SYSTEXT), $(OS9ATTR_TEXT) $@,SYS/$(file);)
	$(CD) defs; $(CPL) $(DEFS) ../$@,DEFS
	$(foreach file, $(DEFS), $(OS9ATTR_TEXT) $@,DEFS/$(file);)
	$(CPL) $(STARTUP_DW) $@,startup
	$(OS9ATTR_TEXT) $@,startup
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
	$(RM) $(LDSKDWHEADLESS)
	$(SOFTLINK) $@ $(LDSKDWHEADLESS)

$(DSK360K_1):
	-$(RM) $@
	$(OS9FORMAT_DS40) -q $@ -n"NitrOS-9/$(CPU) Level 2 Disk 1"
	$(OS9GEN) $@ -b=$(BOOTFILE_40D) -t=$(KERNELFILE)
	$(MAKDIR) $@,CMDS
	$(MAKDIR) $@,SYS
	$(MAKDIR) $@,DEFS
	$(CP) modules/$(CCBKRN) $@,$(CCBKRN)
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
	$(CPL) $(STARTUP) $@,startup
	$(OS9ATTR_TEXT) $@,startup
	$(RM) $(LDSK360K_1)
	$(SOFTLINK) $@ $(LDSK360K_1)

$(DSK360K_1_50HZ):
	-$(RM) $@
	$(OS9FORMAT_DS40) -q $@ -n"NitrOS-9/$(CPU) Level 2 Disk 1"
	$(OS9GEN) $@ -b=$(BOOTFILE_40D_50HZ) -t=$(KERNELFILE_50HZ)
	$(MAKDIR) $@,CMDS
	$(MAKDIR) $@,SYS
	$(MAKDIR) $@,DEFS
	$(CP) modules/$(CCBKRN) $@,$(CCBKRN)
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
	$(CPL) $(STARTUP) $@,startup
	$(OS9ATTR_TEXT) $@,startup
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
	$(CP) modules/$(CCBKRN) $@,$(CCBKRN)
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
	$(CPL) $(STARTUP) $@,startup
	$(OS9ATTR_TEXT) $@,startup
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
	$(CP) modules/$(CCBKRN) $@,$(CCBKRN)
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
	$(CPL) $(STARTUP) $@,startup
	$(OS9ATTR_TEXT) $@,startup
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
	@$(ECHO) "*** NitrOS-9/$(CPU) Level 2 for the Tandy Color Computer 3 ***"
	@$(foreach dsk, $(DSKS), $(ECHO) $(dsk);)
