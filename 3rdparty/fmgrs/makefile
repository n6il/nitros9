include ../../rules.mak

dirs	= msf

# Make all components
all:
	@$(ECHO) "**************************************************"
	@$(ECHO) "*                                                *"
	@$(ECHO) "*                  File Managers                 *"
	@$(ECHO) "*                                                *"
	@$(ECHO) "**************************************************"
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
