# OS-9 Distributions Makefile
#

include Makefile.rules

# Make all components
all:
	$(CD) $(3RDPARTY); make
	$(CD) $(LEVEL1); make
#	$(CD) level2; make
	$(CD) $(LEVEL2); make

# Clean all components
clean:
	-$(CD) $(3RDPARTY); make clean
	-$(CD) $(LEVEL1); make clean
#	-$(CD) level2; make clean
	-$(CD) $(LEVEL2); make clean


