include ../Makefile.rules

# Make all components
all:
	@$(ECHO) "*********************************************"
	@$(ECHO) "*                                           *"
	@$(ECHO) "*        OS-9 Level One Distribution        *"
	@$(ECHO) "*        (C) 1983  Tandy Corporation        *"
	@$(ECHO) "*                                           *"
	@$(ECHO) "*********************************************"
	cd CMDS; make
	cd MODULES; make
	cd BOOTFILES; make
	cd DEFS; make
	cd SYS; make
	$(UNIX2OS9) startup

# Clean all components
clean:
	-cd CMDS; make clean
	-cd MODULES; make clean
	-cd BOOTFILES; make clean
	-cd DEFS; make clean
	-cd SYS; make clean
	-$(OS92UNIX) startup

