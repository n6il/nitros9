# Rules for making OS-9/6X09 modules

# This macro should change according to where the base directory of the
# OS-9 source tree is located
BASEDIR		= /home/boisy/os9

# If we're using the OS-9 emulator and the *real* OS-9 assembler,
# uncomment the following two lines.
#AS		= os9 /mnt2/src/ocem/os9/asm
#ASOUT		= o=

# Use the cross assembler
AS		= os9asm
ASOUT		= -o=
AFLAGS		= -q

# Commands
RM		= rm -f
MERGE		= cat
PADROM		= os9padrom
ECHO		= echo
CHMOD		= chmod
IDENT		= os9ident
IDENT_SHORT	= os9ident -s
UNIX2OS9	= $(BASEDIR)/hosttools/u2o
OS92UNIX	= $(BASEDIR)/hosttools/o2u

# File managers
%.mn: %.asm
	$(AS) $(AFLAGS) $< $(ASOUT)$@

# Device drivers
%.dr: %.asm
	$(AS) $(AFLAGS) $< $(ASOUT)$@

# Device descriptors
%.dd: %.asm
	$(AS) $(AFLAGS) $< $(ASOUT)$@

# Window device descriptors
%.dw: %.asm
	$(AS) $(AFLAGS) $< $(ASOUT)$@

# Terminal device descriptors
%.dt: %.asm
	$(AS) $(AFLAGS) $< $(ASOUT)$@

# I/O subroutines
%.io: %.asm
	$(AS) $(AFLAGS) $< $(ASOUT)$@

# 60Hz clocks
%.60hz: %.asm
	$(AS) -aTPS=60 $(AFLAGS) $< $(ASOUT)$@

# 50Hz clocks
%.50hz: %.asm
	$(AS) -aTPS=50 $(AFLAGS) $< $(ASOUT)$@

# All other modules
%: %.asm
	$(AS) $(AFLAGS) $< $(ASOUT)$@

