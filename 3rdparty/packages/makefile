include ../../Makefile.rules

DEPENDS		= ./Makefile

all:
	@$(ECHO) "*********************************************"
	@$(ECHO) "*                                           *"
	@$(ECHO) "*           3rd Software Packages           *"
	@$(ECHO) "*                                           *"
	@$(ECHO) "*********************************************"
	$(CD) basic09; make
	$(CD) cc-1.1; make
	$(CD) fsim2; make
	$(CD) koronis; make
	$(CD) kyumgai; make
	$(CD) lsl; make
	$(CD) mm; make
	$(CD) multivue; make
	$(CD) rof; make
	$(CD) subsim; make

clean:
	-$(CD) basic09; make clean
	$(CD) cc-1.1; make clean
	-$(CD) fsim2; make clean
	-$(CD) koronis; make clean
	-$(CD) kyumgai; make clean
	-$(CD) lsl; make clean
	-$(CD) mm; make clean
	-$(CD) multivue; make clean
	-$(CD) rof; make clean
	-$(CD) subsim; make clean
