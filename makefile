include $(NITROS9DIR)/rules.mak

dirs	=  $(NOSLIB) $(LEVEL1) $(LEVEL2) $(LEVEL3) $(3RDPARTY)
 
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
	-$(RM) nitros9project.zip $(DSKDIR)/*.dsk $(DSKDIR)/ReadMe $(DSKDIR)/index.shtml
	$(foreach dir, $(dirs), ($(CD) $(dir); make clean);)
	$(RM) $(DSKDIR)/ReadMe
	$(RM) $(DSKDIR)/index.html

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

beckerdsk	= $(LEVEL1)/coco/nos96809l1coco_becker.dsk \
	$(LEVEL2)/coco3/nos96809l2_becker.dsk $(LEVEL2)/coco3_6309/nos96309l2_becker.dsk

dw3:
	$(ARCHIVE) nitros9_drivewire3.zip $(dw3dsk)

becker:
	$(ARCHIVE) nitros9_becker.zip $(beckerdsk)

info:
	@$(foreach dir, $(dirs), ($(CD) $(dir); make info);)
	
nightly: clean hgupdate dskcopy
	make info>$(DSKDIR)/ReadMe
	$(ARCHIVE) nitros9project $(DSKDIR)/*
	scp nitros9project.zip $(SOURCEUSER),nitros9@web.sourceforge.net:/home/groups/n/ni/nitros9/htdocs
	ssh $(SOURCEUSER),nitros9@shell.sourceforge.net create
	ssh $(SOURCEUSER),nitros9@shell.sourceforge.net "./burst"
