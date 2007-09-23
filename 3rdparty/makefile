include ../rules.mak

dirs	= booters drivers fmgrs libs p2mods subrtns utils packages

# Make all components
all:
	@$(ECHO) "**************************************************"
	@$(ECHO) "*                                                *"
	@$(ECHO) "*               3rd Party Software               *"
	@$(ECHO) "*                                                *"
	@$(ECHO) "**************************************************"
	$(foreach dir, $(dirs), ($(CD) $(dir); make);)

# Clean all components
clean:	dskclean
	$(foreach dir, $(dirs), ($(CD) $(dir); make clean);)

# Make DSK images
dsk:
	$(foreach dir, $(dirs), ($(CD) $(dir); make dsk);)

# Clean DSK images
dskclean:
	$(foreach dir, $(dirs), ($(CD) $(dir); make dskclean);)

# Copy DSK images
dskcopy: dsk
	$(foreach dir, $(dirs), ($(CD) $(dir); make dskcopy);)
