include rules.mak

dirs	= $(LEVEL1) $(LEVEL2) $(3RDPARTY)
 
# Make all components
all:
	@$(ECHO) "**************************************************"
	@$(ECHO) "*                                                *"
	@$(ECHO) "*              THE NITROS-9 PROJECT              *"
	@$(ECHO) "*                                                *"
	@$(ECHO) "**************************************************"
	$(foreach dir, $(dirs), ($(CD) $(dir); make);)

# Clean all components
clean:  dskclean
	$(foreach dir, $(dirs), ($(CD) $(dir); make clean);)

# Make DSK images
dsk:	all
	$(foreach dir, $(dirs), ($(CD) $(dir); make dsk);)

# Clean DSK images
dskclean:
	$(foreach dir, $(dirs), ($(CD) $(dir); make dskclean);)

# DriveWire 3 DSK images
dw3:	dsk
	$(CP) level1/coco/nos96809l1coco1_dw3.dsk .
	$(CP) level1/coco/nos96809l1coco2_dw3.dsk .
	$(CP) level2/coco3/nos96809l2_dw3.dsk .
	$(CP) level2/coco3_6309/nos96309l2_dw3.dsk .
	zip -C nitros9.zip nos96809l1coco1_dw3.dsk nos96809l1coco2_dw3.dsk \
	nos96809l2_dw3.dsk nos96309l2_dw3.dsk
