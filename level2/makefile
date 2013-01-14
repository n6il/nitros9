ifndef  NITROS9DIR
NITROS9DIR      = $(HOME)/nitros9
endif
include $(NITROS9DIR)/rules.mak

dirs	= coco3 coco3_6309

# Make all components
all:
	@$(ECHO) "**************************************************"
	@$(ECHO) "*                                                *"
	@$(ECHO) "*             NitrOS-9 Level 2 Ports             *"
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
	@$(foreach dir, $(dirs), ($(CD) $(dir); make info; $(ECHO));)
