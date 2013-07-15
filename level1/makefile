include $(NITROS9DIR)/rules.mak

dirs	= coco1 deluxe coco2 coco2b tano d64 dalpha atari

# Make all components
all:
	@$(ECHO) "**************************************************"
	@$(ECHO) "*                                                *"
	@$(ECHO) "*             NitrOS-9 Level 1 Ports             *"
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

# Clean DSK images
dskclean:
	$(foreach dir, $(dirs), ($(CD) $(dir); make dskclean);)

# Info
info:
	@$(foreach dir, $(dirs), $(MAKE) -C $(dir) info; $(ECHO);)

