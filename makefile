
ifndef NITROS9DIR
NITROS9DIR = $(PWD)
endif

export NITROS9DIR

include rules.mak

dirs	=  $(NOSLIB) $(LEVEL1) $(LEVEL2) $(LEVEL3) $(3RDPARTY)
 
# Make all components
all:
	@$(ECHO) "**************************************************"
	@$(ECHO) "*                                                *"
	@$(ECHO) "*              THE NITROS-9 PROJECT              *"
	@$(ECHO) "*                                                *"
	@$(ECHO) "**************************************************"
	$(foreach dir,$(dirs),$(MAKE) -C $(dir) &&) :

# Clean all components
clean:
	$(RM) nitros9project.zip $(DSKDIR)/*.dsk $(DSKDIR)/ReadMe $(DSKDIR)/index.shtml
	$(foreach dir,$(dirs),$(MAKE) -C $(dir) clean &&) :
	$(RM) $(DSKDIR)/ReadMe
	$(RM) $(DSKDIR)/index.html

# Do CVS update
hgupdate:
	hg pull
	hg update

# Make DSK images
dsk:	all
	$(foreach dir,$(dirs),$(MAKE) -C $(dir) dsk &&) :

# Copy DSK images
dskcopy:	all
	mkdir -p $(DSKDIR)
	$(foreach dir,$(dirs),$(MAKE) -C $(dir) dskcopy &&) :
	$(MKDSKINDEX) $(DSKDIR) > $(DSKDIR)/index.html


# Clean DSK images
dskclean:
	$(foreach dir,$(dirs),$(MAKE) -C $(dir) dskclean &&) :

# DriveWire DSK images
dwdsk = $(LEVEL1)/coco/nos96809l1coco1_dw.dsk $(LEVEL1)/coco/nos96809l1coco2_dw.dsk \
	$(LEVEL2)/coco3/nos96809l2_dw.dsk $(LEVEL2)/coco3_6309/nos96309l2_dw.dsk

dw:	dsk
	$(ARCHIVE) nitros9_drivewire3.zip $(dwdsk)

# DriveWire Becker DSK Images
beckerdsk	= $(LEVEL1)/coco/nos96809l1coco_becker.dsk \
	$(LEVEL2)/coco3/nos96809l2_becker.dsk $(LEVEL2)/coco3_6309/nos96309l2_becker.dsk

becker:	dsk
	$(ARCHIVE) nitros9_becker.zip $(beckerdsk)

info:
	@$(foreach dir,$(dirs), $(MAKE) --no-print-directory -C $(dir) info &&) :
	
# This section is to do the nightly build and upload 
# to sourceforge.net you must set the environment
# variable SOURCEUSER to the userid you have for sourceforge.net
# The "burst" script is found in the scripts folder and must
# on your ssh account at sourceforge.net
ifdef	SOURCEUSER
nightly: clean hgupdate dskcopy
	$(MAKE) info > $(DSKDIR)/ReadMe
	$(ARCHIVE) nitros9project $(DSKDIR)/*
	scp nitros9project.zip $(SOURCEUSER),nitros9@web.sourceforge.net:/home/project-web/nitros9/htdocs/nitros9project-$(shell date +%Y%m%d).zip 
	ssh $(SOURCEUSER),nitros9@shell.sourceforge.net create
	ssh $(SOURCEUSER),nitros9@shell.sourceforge.net "./burst"
else
nightly:
	@echo ""
	@echo ""
	@echo "You need to set the SOURCEUSER variable"
	@echo "You may wish to refer to the nightly"
	@echo "section of the makefile."
endif

# This section is to run a nightly test.
# This requires you to setup a environment variable
# called TESTSSHSERVER.
# example would be: TESTSSHSERVER='testuser@localhost'
# another example: TESTSSHSERVER='testuser@test.testhost.com'
#
# You are also required to setup a target path for your file
# and the environment variable that is being used in this
# section is called TESTSSHDIR
ifdef	TESTSSHSERVER
ifdef	TESTSSHDIR
nightlytest: clean hgupdate dskcopy
	$(MAKE) info > $(DSKDIR)/ReadMe
	$(ARCHIVE) nitros9project $(DSKDIR)/*
	scp nitros9project.zip $(TESTSSHSERVER):$(TESTSSHDIR)/nitros9project-$(shell date +%Y%m%d).zip
	ssh $(TESTSSHSERVER) "./burst"
else
nightlytest:
	@echo ""
	@echo ""
	@echo "You need to set the TESTSSHDIR variable"
	@echo "You may wish to refer to the nightlytest"
	@echo "section of the makefile to see what"
	@echo "needs to be setup first before using"
	@echo "this option"
endif
else
nightlytest:
	@echo ""
	@echo ""
	@echo "You need to set the TESTSSHSERVER variable"
	@echo "You may wish to refer to the nightlytest"
	@echo "section of the makefile to see what"
	@echo "needs to be setup first before using"
	@echo "this option."
endif
