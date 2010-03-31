include ../../rules.mak

dirs	= boisy dasm smartwatch supercomm winfo

# Make all components
all:
	@$(ECHO) "**************************************************"
	@$(ECHO) "*                                                *"
	@$(ECHO) "*                    Utilities                   *"
	@$(ECHO) "*                                                *"
	@$(ECHO) "**************************************************"
	$(foreach dir, $(dirs), ($(CD) $(dir); make);)

# Clean all components
clean:
	$(foreach dir, $(dirs), ($(CD) $(dir); make clean);)

# Make DSK images
dsk:
	$(foreach dir, $(dirs), ($(CD) $(dir); make dsk);)

# Copy DSK images
dskcopy:
	$(foreach dir, $(dirs), ($(CD) $(dir); make dskcopy);)
