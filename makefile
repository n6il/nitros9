include Makefile.rules

dirs	= $(LEVEL1) $(LEVEL2) $(NLEVEL2) $(3RDPARTY)
 
# Make all components
all:
	@$(ECHO) "*********************************************"
	@$(ECHO) "*                                           *"
	@$(ECHO) "*          COCOOS9 SOURCE PROJECT           *"
	@$(ECHO) "*                                           *"
	@$(ECHO) "*********************************************"
	$(foreach dir, $(dirs), $(CD) $(dir); make; $(CD) ..;)

# Clean all components
clean:  dskclean
	$(foreach dir, $(dirs), $(CD) $(dir); make clean; $(CD) ..;)

# Make DSK images
dsk:	all
	$(foreach dir, $(dirs), $(CD) $(dir); make dsk; $(CD) ..;)

# Clean DSK images
dskclean:
	$(foreach dir, $(dirs), $(CD) $(dir); make dskclean; $(CD) ..;)
	rm -f $(DSKDIR)/*

# Copy DSK images
dskcopy: dsk
	$(foreach dir, $(dirs), $(CD) $(dir); make dskcopy; $(CD) ..;)
