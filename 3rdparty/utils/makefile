include ../../Makefile.rules

dirs	= boisy dasm smartwatch winfo

# Make all components
all:
	@$(ECHO) "*********************************************"
	@$(ECHO) "*                                           *"
	@$(ECHO) "*                 Utilities                 *"
	@$(ECHO) "*                                           *"
	@$(ECHO) "*********************************************"
	$(foreach dir, $(dirs), $(CD) $(dir); make; $(CD) ..;)

# Clean all components
clean:
	$(foreach dir, $(dirs), $(CD) $(dir); make clean; $(CD) ..;)

# Make DSK images
dsk:
	$(foreach dir, $(dirs), $(CD) $(dir); make dsk; $(CD) ..;)

# Copy DSK images
dskcopy:
	$(foreach dir, $(dirs), $(CD) $(dir); make dskcopy; $(CD) ..;)
