include ../../../Makefile.rules

DISK	= multivue.dsk
CMDS	= $(shell $(CD) CMDS; make showobjs)
ICONS	= $(shell $(CD) CMDS/ICONS; make showobjs)
SYSBIN	= $(shell $(CD) SYS; make showbinobjs)
SYSTEXT	= $(shell $(CD) SYS; make showtextobjs)
DEMO	= $(shell $(CD) DEMO; make showobjs)

# Make all components
all:
	@$(ECHO) "*********************************************"
	@$(ECHO) "*                                           *"
	@$(ECHO) "*                 Multi-Vue                 *"
	@$(ECHO) "*                                           *"
	@$(ECHO) "*********************************************"
	$(CD) CMDS; make
	$(CD) SYS; make
	$(CD) DEMO; make

# Clean all components
clean:	dskclean
	-$(CD) CMDS; make clean
	-$(CD) SYS; make clean
	-$(CD) DEMO; make clean

dsk:	all
	$(RM) $(DISK)
	$(OS9FORMAT) $(DISK) -n"Multi-Vue"
	$(MAKDIR) $(DISK),CMDS
	$(MAKDIR) $(DISK),CMDS/ICONS
	$(MAKDIR) $(DISK),SYS
	$(MAKDIR) $(DISK),DEMO
	$(CD) CMDS; $(CP) $(CMDS) ../$(DISK),CMDS
	$(CD) CMDS/ICONS; $(CP) $(ICONS) ../../$(DISK),CMDS/ICONS
	$(CD) SYS; $(CP) $(SYSBIN) ../$(DISK),SYS
	$(CD) SYS; $(CPL) $(SYSTEXT) ../$(DISK),SYS
	$(CD) DEMO; $(CPL) $(DEMO) ../$(DISK),DEMO

dskclean:
	-$(RM) $(DISK)

