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
	cd rampak; make
	cd s16550; make
	cd scsisys; make
	cd sdisk; make
	cd sdisk3; make

# Clean all components
clean:
	-cd ide; make clean
	-cd flash; make clean
	-cd rampak; make clean
	-cd s16550; make clean
	-cd scsisys; make clean
	-cd sdisk; make clean
	-cd sdisk3; make clean
