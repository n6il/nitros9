include ../../Makefile.rules

# Make all components
all:
	@$(ECHO) "*********************************************"
	@$(ECHO) "*                                           *"
	@$(ECHO) "*          3rd Party Device Drivers         *"
	@$(ECHO) "*                                           *"
	@$(ECHO) "*********************************************"
	cd ide; make
	cd flash; make
	cd flashpak; make
	cd disto; make
	cd s16550; make
	cd scsisys; make
	cd sdisk; make
	cd sdisk3; make
	cd tccc; make

# Clean all components
clean:
	-cd ide; make clean
	-cd flash; make clean
	-cd flashpak; make clean
	-cd disto; make clean
	-cd s16550; make clean
	-cd scsisys; make clean
	-cd sdisk; make clean
	-cd sdisk3; make clean
	-cd tccc; make clean
