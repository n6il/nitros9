include ../Makefile.rules

RELEASE		= os9l2v030002beta2
BOOTFILE	= bootfile_vdg
KERNEL		= kernel_stock

CMDS            = $(shell $(CD) CMDS; make showobjs)
MODULES         = $(shell $(CD) MODULES; make showcopyobjs)
DEFS            = $(shell $(CD) DEFS; make showobjs)
SYS             = $(shell $(CD) SYS; make showobjs)
ROOTFILES	= startup upgrade_song
SYSGO           = MODULES/cc3go

PACKAGENAME     = $(RELEASE).zip
DSK_SS40_1      = $(RELEASE)_ss40_1.dsk
DSK_DS40_1      = $(RELEASE)_ds40_1.dsk
DSK_DS40_2      = $(RELEASE)_ds40_2.dsk
TESTDSK		= test.dsk


# Make all components
all:
	@$(ECHO) "*********************************************"
	@$(ECHO) "*                                           *"
	@$(ECHO) "*      OS-9 Level Two Vr3 Distribution      *"
	@$(ECHO) "*        The Rumored Upgrade Version        *"
	@$(ECHO) "*                                           *"
	@$(ECHO) "*********************************************"
	$(CD) CMDS; make
	$(CD) MODULES; make
	$(CD) DEFS; make
	$(CD) SYS; make
	$(CD) BOOTFILES; make
	$(UNIX2OS9) $(ROOTFILES)
	$(CHMOD) 644 $(ROOTFILES)

# Clean all components
clean: dskclean
	-$(CD) CMDS; make clean
	-$(CD) MODULES; make clean
	-$(CD) DEFS; make clean
	-$(CD) SYS; make clean
	-$(CD) BOOTFILES; make clean
	-$(OS92UNIX) $(ROOTFILES)

dskclean:
	-$(RM) $(PACKAGENAME) $(DSK_SS40_1) $(DSK_DS40_1) $(DSK_DS40_2)

dsk: all $(PACKAGENAME)

$(PACKAGENAME): $(DSK_SS40_1) $(DSK_DS40_1) $(DSK_DS40_2)
	$(ZIP) $(PACKAGENAME) $(DSK_SS40_1) $(DSK_DS40_1) $(DSK_DS40_2) ReleaseNotes ChangeLog

$(DSK_SS40_1):
	-$(RM) $(DSK_SS40_1)
	$(OS9FORMAT) $(DSK_SS40_1) -t40 -h1 -n"OS-9 Level Two System Disk"
	$(OS9GEN) $(DSK_SS40_1) BOOTFILES/$(BOOTFILE) BOOTFILES/$(KERNEL)
	$(MAKDIR) $(DSK_SS40_1),CMDS
	$(CP) $(SYSGO) $(DSK_SS40_1),
	$(CD) CMDS; $(CP) $(CMDS) ../$(DSK_SS40_1),CMDS
	$(CP) $(ROOTFILES) $(DSK_SS40_1),.

$(DSK_DS40_1):
	-$(RM) $(DSK_DS40_1)
	$(OS9FORMAT) $(DSK_DS40_1) -t40 -h2 -n"OS-9 Level Two System Disk"
	$(OS9GEN) $(DSK_DS40_1) BOOTFILES/$(BOOTFILE) BOOTFILES/$(KERNEL)
	$(MAKDIR) $(DSK_DS40_1),CMDS
	$(MAKDIR) $(DSK_DS40_1),SYS
	$(MAKDIR) $(DSK_DS40_1),MODULES
	$(CP) $(SYSGO) $(DSK_DS40_1),
	$(CD) CMDS; $(CP) $(CMDS) ../$(DSK_DS40_1),CMDS
	$(CD) SYS; $(CP) $(SYS) ../$(DSK_DS40_1),SYS
	$(CD) MODULES; $(CP) $(MODULES) ../$(DSK_DS40_1),MODULES
	$(CP) $(ROOTFILES) $(DSK_DS40_1),.

$(DSK_DS40_2):
	-$(RM) $(DSK_DS40_2)
	$(OS9FORMAT) $(DSK_DS40_2) -t40 -h2 -n"OS-9 Level Two Development Disk"
	$(MAKDIR) $(DSK_DS40_2),DEFS
	$(CD) DEFS; $(CP) $(DEFS) ../$(DSK_DS40_2),DEFS
