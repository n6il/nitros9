include ../../../Makefile.rules

DISK		= cc.dsk
CMDS		= cc1 c.prep c.pass1 c.pass2 c.opt c.asm c.link

ALLOBJS		= $(CMDS)

# Make all components
all:	$(ALLOBJS)
	@$(ECHO) "*********************************************"
	@$(ECHO) "*                                           *"
	@$(ECHO) "*                 C Compiler                *"
	@$(ECHO) "*                                           *"
	@$(ECHO) "*********************************************"
	$(CHMOD) 755 $(CMDS)

# Clean all components
clean:	dskclean
	$(RM) $(ALLOBJS)

dsk:	all
	$(RM) $(DISK)
	$(OS9FORMAT_DS40) $(DISK) -n"C Compiler"
	$(MAKDIR) $(DISK),CMDS
	$(MAKDIR) $(DISK),LIB
	$(MAKDIR) $(DISK),DEFS
	$(MAKDIR) $(DISK),SOURCES
	$(MAKDIR) $(DISK),SOURCES/SYS
	$(CP) $(CMDS) $(DISK),CMDS
	$(CPL) DEFS/*.h $(DISK),DEFS
	$(CP) LIB/*.l LIB/*.r $(DISK),LIB
	$(CPL) SOURCES/*.c $(DISK),SOURCES
	$(CPL) SOURCES/*.a $(DISK),SOURCES/SYS

dskclean:
	-$(RM) $(DISK)

