include ../../../Makefile.rules

DISK	= cc.dsk
CMDS	= cc1 c.prep c.pass1 c.pass2 c.opt c.asm c.link

# Make all components
all:	$(CMDS)
	@$(ECHO) "*********************************************"
	@$(ECHO) "*                                           *"
	@$(ECHO) "*                 C Compiler                *"
	@$(ECHO) "*                                           *"
	@$(ECHO) "*********************************************"
	-$(CD) SOURCES; $(UNIX2OS9) *.a *.c
	-$(CD) DEFS; $(UNIX2OS9) *.h

# Clean all components
clean:	dskclean
	-$(CD) SOURCES; $(OS92UNIX) *.a *.c
	-$(CD) DEFS; $(OS92UNIX) *.h

dsk:	all
	$(RM) $(DISK)
	$(OS9FORMAT) $(DISK) -t40 -h2 -n"C Compiler"
	$(MAKDIR) $(DISK),CMDS
	$(MAKDIR) $(DISK),LIB
	$(MAKDIR) $(DISK),DEFS
	$(MAKDIR) $(DISK),SOURCES
	$(MAKDIR) $(DISK),SOURCES/SYS
	$(CP) $(CMDS) $(DISK),CMDS
	$(CP) DEFS/*.h $(DISK),DEFS
	$(CP) LIB/*.l LIB/*.r $(DISK),LIB
	$(CP) SOURCES/*.c $(DISK),SOURCES
	$(CP) SOURCES/*.a $(DISK),SOURCES/SYS

dskclean:
	-$(RM) $(DISK)

