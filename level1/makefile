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

# Clean all components
clean:
	-cd CMDS; make clean
	-cd MODULES; make clean
	-cd BOOTFILES; make clean
