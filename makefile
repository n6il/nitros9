# OS-9 Distributions Makefile
#

include Makefile.rules

# Make all components
all:
	cd 3rdparty; make
	cd level1; make
	cd level2; make
	cd level2v3; make

# Clean all components
clean:
	-cd 3rdparty; make clean
	-cd level1; make clean
	-cd level2; make clean
	-cd level2v3; make clean

