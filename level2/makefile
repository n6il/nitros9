include ../Makefile.rules

# Make all components
all:
	@$(ECHO) "*********************************************"
	@$(ECHO) "*                                           *"
	@$(ECHO) "*      OS-9 Level Two Vr3 Distribution      *"
	@$(ECHO) "*        The Rumored Upgrade Version        *"
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
