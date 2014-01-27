include $(NITROS9DIR)/rules.mak

dirs	= coco3 coco3_6309
ifdef PORTS
dirs	= $(PORTS)
endif

# Make all components
all:
	@$(ECHO) "**************************************************"
	@$(ECHO) "*                                                *"
	@$(ECHO) "*             NitrOS-9 Level 2 Ports             *"
	@$(ECHO) "*                                                *"
	@$(ECHO) "**************************************************"
	$(foreach dir,$(dirs),$(MAKE) -C $(dir) &&) :

# Clean all components
clean:
	$(foreach dir, $(dirs), ($(CD) $(dir); make clean);)

# Make DSK images
dsk:
	$(foreach dir,$(dirs),$(MAKE) -C $(dir) dsk &&) :

# Copy DSK images
dskcopy:
	$(foreach dir,$(dirs),$(MAKE) -C $(dir) dskcopy &&) :

# Clean DSK images
dskclean:
	$(foreach dir, $(dirs), ($(CD) $(dir); make dskclean);)

# Info
info:
	@$(foreach dir, $(dirs), $(MAKE) -C $(dir) info; $(ECHO);)
