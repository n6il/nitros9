include ../Makefile.rules

RELEASE		= os9l1v020100cc
BOOTFILE	= bootfile_stock
KERNEL		= kernel_stock

CMDS_D1		= $(shell $(CD) CMDS; make showcocoobjs_d1)
CMDS_D2		= $(shell $(CD) CMDS; make showcocoobjs_d2)
MODULES		= $(shell $(CD) MODULES; make showcopyobjs)
SYS		= $(shell $(CD) SYS; make showobjs)
DEFS		= $(shell $(CD) DEFS; make showobjs)
ROOTFILES	= startup

PACKAGENAME	= $(RELEASE).zip
DSK_DS40_1	= $(RELEASE)_ds40_1.dsk
DSK_DS40_2	= $(RELEASE)_ds40_2.dsk

# Make all components
all:
	@$(ECHO) "*********************************************"
	@$(ECHO) "*                                           *"
	@$(ECHO) "*        OS-9 Level One Distribution        *"
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
	-$(RM) $(PACKAGENAME) $(DSK_DS40_1) $(DSK_DS40_2)

dsk: all $(PACKAGENAME)

$(PACKAGENAME): $(DSK_DS40_1) $(DSK_DS40_2)
	$(ZIP) $(PACKAGENAME) $(DSK_DS40_1) $(DSK_DS40_2) ReleaseNotes ChangeLog

$(DSK_DS40_1):
	$(RM) $(DSK_DS40_1)
	$(OS9FORMAT) $(DSK_DS40_1) -t40 -h1 -n"OS-9 Level One System Disk"
	$(OS9GEN) $(DSK_DS40_1) BOOTFILES/$(BOOTFILE) BOOTFILES/$(KERNEL)
	$(MAKDIR) $(DSK_DS40_1),CMDS
	$(MAKDIR) $(DSK_DS40_1),SYS
	$(CD) CMDS; $(CP) $(CMDS_D1) $(CMDS_D2) ../$(DSK_DS40_1),CMDS
	$(CD) SYS; $(CP) $(SYS) ../$(DSK_DS40_1),SYS
	$(CP) $(ROOTFILES) $(DSK_DS40_1),.

$(DSK_DS40_2):
	-$(RM) $(DSK_DS40_2)
	$(OS9FORMAT) $(DSK_DS40_2) -t40 -h1 -n"OS-9 Level One Development Disk"
	$(MAKDIR) $(DSK_DS40_2),DEFS
	$(CD) DEFS; $(CP) $(DEFS) ../$(DSK_DS40_2),DEFS

