include ../../Makefile.rules

dirs	= basic09 cc fsim2 koronis kq3 kyumgai lsl mm multivue rof subsim

# Make all components
all:
	@$(ECHO) "*********************************************"
	@$(ECHO) "*                                           *"
	@$(ECHO) "*            3rd Party Packages             *"
	@$(ECHO) "*                                           *"
	@$(ECHO) "*********************************************"
	$(foreach dir, $(dirs), $(CD) $(dir); make; $(CD) ..;)

# Clean all components
clean:
	$(foreach dir, $(dirs), $(CD) $(dir); make clean; $(CD) ..;)
