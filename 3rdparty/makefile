include ../Makefile.rules

# Make all components
all:
	@$(ECHO) "*********************************************"
	@$(ECHO) "*                                           *"
	@$(ECHO) "*             3rd Party Software            *"
	@$(ECHO) "*                                           *"
	@$(ECHO) "*********************************************"
	cd drivers; make
	cd fmgrs; make
	cd p2mods; make
	cd subrtns; make
	cd utils; make
	cd packages; make

# Clean all components
clean:
	-cd drivers; make clean
	-cd fmgrs; make clean
	-cd p2mods; make clean
	-cd subrtns; make clean
	-cd utils; make clean
	-cd packages; make clean
