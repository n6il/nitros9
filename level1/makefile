include ../Makefile.rules

RELEASE		= os9l1v020100cc
BOOTFILE	= bootfile_stock
KERNEL		= kernel_stock

CMDS		= $(shell $(CD) CMDS; make showcocoobjs)
MODULES		= $(shell $(CD) MODULES; make showcopyobjs)
SYS		= $(shell $(CD) SYS; make showobjs)
DEFS		= $(shell $(CD) DEFS; make showobjs)
ROOTFILES	= startup

PACKAGENAME	= $(RELEASE).zip
DSK_DS40	= $(RELEASE)_ds40.dsk

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
	$(CHMOD) 644 $(ROOTFILES)

# Clean all components
clean:	dskclean
	-$(CD) CMDS; make clean
	-$(CD) MODULES; make clean
	-$(CD) DEFS; make clean
	-$(CD) SYS; make clean
	-$(CD) BOOTFILES; make clean

dskclean:
	-$(RM) $(PACKAGENAME) $(DSK_DS40)

dsk: all $(PACKAGENAME)

$(PACKAGENAME): $(DSK_DS40)
	$(ZIP) $(PACKAGENAME) $(DSK_DS40) ReadMe ChangeLog

$(DSK_DS40):
	$(RM) $(DSK_DS40)
	$(OS9FORMAT_DS40) $(DSK_DS40) -n"OS-9 Level One System Disk"
	$(OS9GEN) $(DSK_DS40) BOOTFILES/$(BOOTFILE) BOOTFILES/$(KERNEL)
	$(MAKDIR) $(DSK_DS40),CMDS
	$(MAKDIR) $(DSK_DS40),SYS
	$(MAKDIR) $(DSK_DS40),MODULES
	$(CD) CMDS; $(CP) $(CMDS) ../$(DSK_DS40),CMDS
	$(CD) SYS; $(CPL) $(SYS) ../$(DSK_DS40),SYS
	$(MAKDIR) $(DSK_DS40),DEFS
	$(CD) MODULES; $(CP) $(MODULES) ../$(DSK_DS40),MODULES
	$(CD) DEFS; $(CPL) $(DEFS) ../$(DSK_DS40),DEFS
	$(CPL) $(ROOTFILES) $(DSK_DS40),.

