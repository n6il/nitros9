include ../../Makefile.rules

DEPENDS		= ./Makefile


all:	
	@$(ECHO) "*********************************************"
	@$(ECHO) "*                                           *"
	@$(ECHO) "*           3rd Software Packages           *"
	@$(ECHO) "*                                           *"
	@$(ECHO) "*********************************************"
	$(CD) basic09; make
	$(CD) rof; make
	$(CD) multivue; make
 
clean:
	-$(CD) basic09; make clean
	-$(CD) rof; make clean
	-$(CD) multivue; make clean

