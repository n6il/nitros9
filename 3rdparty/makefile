include ../Makefile.rules

# Make all components
all:
	@$(ECHO) "*********************************************"
	@$(ECHO) "*                                           *"
	@$(ECHO) "*             3rd Party Software            *"
	@$(ECHO) "*                                           *"
	@$(ECHO) "*********************************************"
	$(CD) booters; make
	$(CD) clocks; make
	$(CD) drivers; make
	$(CD) fmgrs; make
	$(CD) p2mods; make
	$(CD) subrtns; make
	$(CD) utils; make
	$(CD) packages; make

# Clean all components
clean:
	-$(CD) booters; make clean
	-$(CD) clocks; make clean
	-$(CD) drivers; make clean
	-$(CD) fmgrs; make clean
	-$(CD) p2mods; make clean
	-$(CD) subrtns; make clean
	-$(CD) utils; make clean
	-$(CD) packages; make clean
