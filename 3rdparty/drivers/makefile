include ../../Makefile.rules

# Make all components
all:
	@$(ECHO) "*********************************************"
	@$(ECHO) "*                                           *"
	@$(ECHO) "*          3rd Party Device Drivers         *"
	@$(ECHO) "*                                           *"
	@$(ECHO) "*********************************************"
	$(CD) ide; make
	$(CD) flash; make
	$(CD) flashpak; make
	$(CD) disto; make
	$(CD) s16550; make
	$(CD) sdisk; make
	$(CD) sdisk3; make
	$(CD) tccc; make
	$(CD) emudsk; make

# Clean all components
clean:
	-$(CD) ide; make clean
	-$(CD) flash; make clean
	-$(CD) flashpak; make clean
	-$(CD) disto; make clean
	-$(CD) s16550; make clean
	-$(CD) sdisk; make clean
	-$(CD) sdisk3; make clean
	-$(CD) tccc; make clean
	-$(CD) emudsk; make clean
