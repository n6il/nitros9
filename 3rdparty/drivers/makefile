include ../../Makefile.rules

# Make all components
all:
	@$(ECHO) "*********************************************"
	@$(ECHO) "*                                           *"
	@$(ECHO) "*          3rd Party Device Drivers         *"
	@$(ECHO) "*                                           *"
	@$(ECHO) "*********************************************"
	$(CD) burke; make
	$(CD) disto; make
	$(CD) emudsk; make
	$(CD) flash; make
	$(CD) flashpak; make
	$(CD) ide; make
	$(CD) s16550; make
	$(CD) sdisk; make
	$(CD) sdisk3; make
	$(CD) tccc; make

# Clean all components
clean:
	-$(CD) burke; make clean
	-$(CD) disto; make clean
	-$(CD) emudsk; make clean
	-$(CD) flash; make clean
	-$(CD) flashpak; make clean
	-$(CD) ide; make clean
	-$(CD) s16550; make clean
	-$(CD) sdisk; make clean
	-$(CD) sdisk3; make clean
	-$(CD) tccc; make clean
