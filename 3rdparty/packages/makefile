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
clean:	dskclean
	$(foreach dir, $(dirs), $(CD) $(dir); make clean; $(CD) ..;)

# Create dsk images
dsk:
	$(foreach dir, $(dirs), $(CD) $(dir); make dsk; $(CD) ..;)

# Copy dsk images
dskcopy: dsk
	$(foreach dir, $(dirs), $(CD) $(dir); make dskcopy; $(CD) ..;)

# Clean dsk images
dskclean:
	$(foreach dir, $(dirs), $(CD) $(dir); make dskclean; $(CD) ..;)
