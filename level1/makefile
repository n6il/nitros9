include ../Makefile.rules

ROOTOBJS	= startup

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
	$(CD) BOOTFILES; make
	$(CD) DEFS; make
	$(CD) SYS; make
	$(UNIX2OS9) $(ROOTOBJS)
	$(CHMOD) 644 $(ROOTOBJS)

# Clean all components
clean:
	-$(CD) CMDS; make clean
	-$(CD) MODULES; make clean
	-$(CD) BOOTFILES; make clean
	-$(CD) DEFS; make clean
	-$(CD) SYS; make clean
	-$(OS92UNIX) $(ROOTOBJS)

