include ../../../Makefile.rules

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
clean:
	-$(CD) CMDS; make clean
	-$(CD) SYS; make clean
	-$(CD) DEMO; make clean
