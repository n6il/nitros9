include ../Makefile.rules

# Make all components
all:
	@$(ECHO) "*********************************************"
	@$(ECHO) "*                                           *"
	@$(ECHO) "*      OS-9 Level Two Vr3 Distribution      *"
	@$(ECHO) "*        The Rumored Upgrade Version        *"
	@$(ECHO) "*                                           *"
	@$(ECHO) "*********************************************"
	$(CD) CMDS; make
	$(CD) MODULES; make
	$(CD) DEFS; make
	$(CD) BOOTFILES; make

# Clean all components
clean:
	-$(CD) CMDS; make clean
	-$(CD) MODULES; make clean
	-$(CD) DEFS; make clean
	-$(CD) BOOTFILES; make clean
