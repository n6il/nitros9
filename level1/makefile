include ../Makefile.rules

RELEASE		= os9l1v020100ccbeta2
BOOTFILE	= bootfile_1773
KERNEL		= kernel_1773

CMDS_D1		= $(shell $(CD) CMDS; make showcocoobjs_d1)
CMDS_D2		= $(shell $(CD) CMDS; make showcocoobjs_d2)
MODULES		= $(shell $(CD) MODULES; make showcopyobjs)
SYS		= $(shell $(CD) SYS; make showobjs)
DEFS		= $(shell $(CD) DEFS; make showobjs)
ROOTFILES	= startup

PACKAGENAME	= $(RELEASE).zip
DSK_SS40_1	= $(RELEASE)_ss40_1.dsk
DSK_SS40_2	= $(RELEASE)_ss40_2.dsk
DSK_SS40_3	= $(RELEASE)_ss40_3.dsk
DSK_DS40	= $(RELEASE)_ds40.dsk

# Make all components
all:
	@$(ECHO) "*********************************************"
	@$(ECHO) "*                                           *"
	@$(ECHO) "*        OS-9 Level One Distribution        *"
	@$(ECHO) "*        (C) 1983  Tandy Corporation        *"
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
clean:	dskclean
	-$(CD) CMDS; make clean
	-$(CD) MODULES; make clean
	-$(CD) DEFS; make clean
	-$(CD) SYS; make clean
	-$(CD) BOOTFILES; make clean
	-$(OS92UNIX) $(ROOTFILES)

dskclean:
	-$(RM) $(PACKAGENAME) $(DSK_SS40_1) $(DSK_SS40_2) $(DSK_SS40_3) $(DSK_DS40)

dsk: all $(PACKAGENAME)

$(PACKAGENAME): $(DSK_SS40_1) $(DSK_SS40_2) $(DSK_SS40_3) $(DSK_DS40)
	$(ZIP) $(PACKAGENAME) $(DSK_SS40_1) $(DSK_SS40_2) $(DSK_SS40_3) $(DSK_DS40) ReleaseNotes ChangeLog

$(DSK_SS40_1):
	$(RM) $(DSK_SS40_1)
	$(OS9FORMAT) $(DSK_SS40_1) -t40 -h1 -n"OS-9 Level One System Disk"
	$(OS9GEN) $(DSK_SS40_1) BOOTFILES/$(BOOTFILE) BOOTFILES/$(KERNEL)
	$(MAKDIR) $(DSK_SS40_1):CMDS
	$(MAKDIR) $(DSK_SS40_1):SYS
	$(CD) CMDS; $(CP) $(CMDS_D1) ../$(DSK_SS40_1):CMDS
	$(CD) SYS; $(CP) $(SYS) ../$(DSK_SS40_1):SYS
	$(CP) $(ROOTFILES) $(DSK_SS40_1):.

$(DSK_SS40_2):
	-$(RM) $(DSK_SS40_2)
	$(OS9FORMAT) $(DSK_SS40_2) -t40 -h1 -n"OS-9 Level One Modules Disk"
	$(MAKDIR) $(DSK_SS40_2):CMDS
	$(MAKDIR) $(DSK_SS40_2):MODULES
	$(CD) CMDS; $(CP) $(CMDS_D2) ../$(DSK_SS40_2):CMDS
	$(CD) MODULES; $(CP) $(MODULES) ../$(DSK_SS40_2):MODULES

$(DSK_SS40_3):
	-$(RM) $(DSK_SS40_3)
	$(OS9FORMAT) $(DSK_SS40_3) -t40 -h1 -n"OS-9 Level One Defs Disk"
	$(MAKDIR) $(DSK_SS40_3):DEFS
	$(CD) DEFS; $(CP) $(DEFS) ../$(DSK_SS40_3):DEFS


$(DSK_DS40):
	-$(RM) $(DSK_DS40)
	$(OS9FORMAT) $(DSK_DS40) -t40 -h2 -n"OS-9 Level One"
	$(OS9GEN) $(DSK_DS40) BOOTFILES/$(BOOTFILE) BOOTFILES/$(KERNEL)
	$(MAKDIR) $(DSK_DS40):CMDS
	$(MAKDIR) $(DSK_DS40):SYS
	$(MAKDIR) $(DSK_DS40):MODULES
	$(MAKDIR) $(DSK_DS40):DEFS
	$(CD) CMDS; $(CP) $(CMDS_D1) ../$(DSK_DS40):CMDS
	$(CD) CMDS; $(CP) $(CMDS_D2) ../$(DSK_DS40):CMDS
	$(CD) SYS; $(CP) $(SYS) ../$(DSK_DS40):SYS
	$(CD) MODULES; $(CP) $(MODULES) ../$(DSK_DS40):MODULES
	$(CD) DEFS; $(CP) $(DEFS) ../$(DSK_DS40):DEFS
	$(CP) $(ROOTFILES) $(DSK_DS40):.

