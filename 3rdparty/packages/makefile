include $(NITROS9DIR)/rules.mak

dirs	= arcadepak basic09 deskmate3 cc fsim2 koronis kyumgai mm multivue pacos9 rof sierra subsim uucpbb

# Make all components
all:
	@$(ECHO) "**************************************************"
	@$(ECHO) "*                                                *"
	@$(ECHO) "*               3rd Party Packages               *"
	@$(ECHO) "*                                                *"
	@$(ECHO) "**************************************************"
	$(foreach dir, $(dirs), ($(CD) $(dir); make);)

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
	@$(foreach dir, $(dirs), ($(CD) $(dir); make info; $(ECHO));)
