include ../../Makefile.rules

dirs	= burke disto emudsk flash flashpak ide s16550 sdisk sdisk3 tccc

# Make all components
all:
	@$(ECHO) "*********************************************"
	@$(ECHO) "*                                           *"
	@$(ECHO) "*          3rd Party Device Drivers         *"
	@$(ECHO) "*                                           *"
	@$(ECHO) "*********************************************"
	$(foreach dir, $(dirs), $(CD) $(dir); make; $(CD) ..;)

# Clean all components
clean:
	$(foreach dir, $(dirs), $(CD) $(dir); make clean; $(CD) ..;)
