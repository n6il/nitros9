# OS-9 Distributions Makefile
#

include Makefile.rules

# Make all components
all:
	$(CD) $(3RDPARTY); make
	$(CD) $(LEVEL1); make
	$(CD) $(LEVEL2); make
	$(CD) $(NLEVEL2); make

# Clean all components
clean:
	-$(CD) $(3RDPARTY); make clean
	-$(CD) $(LEVEL1); make clean
	-$(CD) $(LEVEL2); make clean
	-$(CD) $(NLEVEL2); make clean

# Make DSK images
dsk:
	-$(CD) $(LEVEL1); make dsk
	-$(CD) $(LEVEL2); make dsk
	-$(CD) $(NLEVEL2); make dsk
#	-$(CD) $(3RDPARTY); make clean

# Clean DSK images
dskclean:
	-$(CD) $(LEVEL1); make dskclean
	-$(CD) $(LEVEL2); make dskclean
	-$(CD) $(NLEVEL2); make dskclean
#	-$(CD) $(3RDPARTY); make clean

