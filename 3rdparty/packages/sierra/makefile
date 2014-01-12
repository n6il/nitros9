include $(NITROS9DIR)/rules.mak

dirs	= blackcauldron christmas86 goldrush \
	kingsquest1 kingsquest2 kingsquest3 kingsquest4 \
	leisuresuitlarry manhunter1 manhunter2 \
	policequest1 spacequest0 spacequest1 spacequest2

# Make all components
all:
	@$(ECHO) "**************************************************"
	@$(ECHO) "*                                                *"
	@$(ECHO) "*             Sierra Adventure Games             *"
	@$(ECHO) "*                                                *"
	@$(ECHO) "**************************************************"
	$(foreach dir,$(dirs),$(MAKE) -C $(dir) &&) :

# Clean all components
clean:
	$(foreach dir, $(dirs), ($(CD) $(dir); make clean);)

# Create dsk images
dsk:
	$(foreach dir, $(dirs), ($(CD) $(dir); make dsk);)

# Copy dsk images
dskcopy:
	$(foreach dir, $(dirs), ($(CD) $(dir); make dskcopy);)

# Clean dsk images
dskclean:
	$(foreach dir, $(dirs), ($(CD) $(dir); make dskclean);)

# Info
info:
	@$(foreach dir, $(dirs), $(MAKE) -C $(dir) info; $(ECHO);)

