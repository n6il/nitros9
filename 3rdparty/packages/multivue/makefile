include ../../../rules.mak

DISK	= multivue.dsk
CMDS	= $(shell $(CD) cmds; make showobjs)
ICONS	= $(shell $(CD) cmds/icons; make showobjs)
SYSBIN	= $(shell $(CD) sys; make showbinobjs)
SYSTEXT	= $(shell $(CD) sys; make showtextobjs)
DEMO	= $(shell $(CD) demo; make showobjs)

# Make all components
all:
	@$(ECHO) "*********************************************"
	@$(ECHO) "*                                           *"
	@$(ECHO) "*                 Multi-Vue                 *"
	@$(ECHO) "*                                           *"
	@$(ECHO) "*********************************************"
	$(CD) cmds; make
	$(CD) sys; make
	$(CD) demo; make

# Clean all components
clean:	dskclean
	-$(CD) cmds; make clean
	-$(CD) sys; make clean
	-$(CD) demo; make clean

dsk:	all
	$(RM) $(DISK)
	$(OS9FORMAT_SS35) $(DISK) -n"Multi-Vue"
	$(MAKDIR) $(DISK),CMDS
	$(MAKDIR) $(DISK),CMDS/ICONS
	$(MAKDIR) $(DISK),SYS
	$(MAKDIR) $(DISK),DEMO
	$(CD) cmds; $(CP) $(CMDS) ../$(DISK),CMDS
	$(foreach file, $(CMDS), $(OS9ATTR_EXEC) $(DISK),CMDS/$(file);)
	$(CD) cmds/icons; $(CP) $(ICONS) ../../$(DISK),CMDS/ICONS
	$(foreach file, $(ICONS), $(OS9ATTR_EXEC) $(DISK),CMDS/ICONS/$(file);)
	$(CD) sys; $(CP) $(SYSBIN) ../$(DISK),SYS
	$(foreach file, $(SYSBIN), $(OS9ATTR_TEXT) $(DISK),SYS/$(file);)
	$(CD) sys; $(CPL) $(SYSTEXT) ../$(DISK),SYS
	$(foreach file, $(SYSTEXT), $(OS9ATTR_TEXT) $(DISK),SYS/$(file);)
	$(CD) demo; $(CPL) $(DEMO) ../$(DISK),DEMO
	$(foreach file, $(DEMO), $(OS9ATTR_TEXT) $(DISK),DEMO/$(file);)

dskcopy: dsk
	$(CP) $(DISK) $(DSKDIR)

dskclean:
	$(RM) $(DISK)

