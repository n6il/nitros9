include rules.mak

dirs	=  lib $(LEVEL1) $(LEVEL2) $(LEVEL3) $(3RDPARTY)
 
# Make all components
all:
	@$(ECHO) "**************************************************"
	@$(ECHO) "*                                                *"
	@$(ECHO) "*              THE NITROS-9 PROJECT              *"
	@$(ECHO) "*                                                *"
	@$(ECHO) "**************************************************"
	$(foreach dir, $(dirs), ($(CD) $(dir); make);)

# Clean all components
clean:
	-$(RM) nitros9project.zip dsks/*.dsk
	$(foreach dir, $(dirs), ($(CD) $(dir); make clean);)

# Do CVS update
hgupdate:
	hg pull
	hg update

# Make DSK images
dsk:	all
	$(foreach dir, $(dirs), ($(CD) $(dir); make dsk);)

# Copy DSK images
dskcopy:	all
	$(foreach dir, $(dirs), ($(CD) $(dir); make dskcopy);)
	$(MKDSKINDEX) $(DSKDIR) > $(DSKDIR)/index.html


# Clean DSK images
dskclean:
	$(foreach dir, $(dirs), ($(CD) $(dir); make dskclean);)

# DriveWire 3 DSK images
dw3dsk = $(LEVEL1)/coco/nos96809l1coco1_dw3.dsk $(LEVEL1)/coco/nos96809l1coco2_dw3.dsk \
	$(LEVEL2)/coco3/nos96809l2_dw3.dsk $(LEVEL2)/coco3_6309/nos96309l2_dw3.dsk

dw3:
	$(ARCHIVE) nitros9_drivewire3.zip $(dw3dsk)

info:
	@$(foreach dir, $(dirs), ($(CD) $(dir); make info);)
	
nightly: clean hgupdate dskcopy
	make info>dsks/ReadMe
	$(ARCHIVE) nitros9project dsks/*
	scp nitros9project.zip boisy,nitros9@web.sourceforge.net:/home/groups/n/ni/nitros9/htdocs
	ssh boisy,nitros9@shell.sourceforge.net create
	ssh boisy,nitros9@shell.sourceforge.net "./burst"
