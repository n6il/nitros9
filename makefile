# OS-9 Distributions Makefile
#

include Makefile.rules

# Make all components
all:
	$(CD) 3rdparty; make
	$(CD) level1; make
#	$(CD) level2; make
	$(CD) level2v3; make

# Clean all components
clean:
	-$(CD) 3rdparty; make clean
	-$(CD) level1; make clean
#	-$(CD) level2; make clean
	-$(CD) level2v3; make clean


