# The NitrOS-9 Project
# Project-Wide Rules

# NOTE: THERE IS NO NEED TO MODIFY THIS FILE ANYMORE!
# Environment variables are now used to specify any directories other
# than the defaults below:
#
#   NITROS9DIR   - base directory of the NitrOS-9 project on your system
#   COCOTOOLSBIN - directory where CoCoTools binaries are (assembler, etc)
#
# If the defaults below are fine, then there is no need to set any
# environment variables.

#################### DO NOT CHANGE ANYTHING BELOW THIS LINE ####################

ifndef	NITROS9DIR
NITROS9DIR	= $(HOME)/nitros9
endif
ifndef	COCOTOOLSBIN
COCOTOOLSBIN	= $(HOME)/bin
endif
DEFDIR		= $(NITROS9DIR)/defs
DSKDIR		= $(NITROS9DIR)/dsks


# If we're using the OS-9 emulator and the *real* OS-9 assembler,
# uncomment the following two lines.
#AS		= os9 /mnt2/src/ocem/os9/asm
#ASOUT		= o=

# Use the cross assembler
AS		= $(COCOTOOLSBIN)/mamou -i=$(DEFDIR)
#AS		= $(COCOTOOLSBIN)/os9asm -i=$(DEFDIR)
ASOUT		= -o
AFLAGS		= -q

# Commands
MAKDIR		= $(COCOTOOLSBIN)/os9 makdir
RM		= rm -f
MERGE		= cat
MOVE		= mv
ECHO		= /bin/echo
CD		= cd
CP		= $(COCOTOOLSBIN)/os9 copy -o=0
CPL		= $(CP) -l
TAR		= tar
CHMOD		= chmod
IDENT		= $(COCOTOOLSBIN)/os9 ident
IDENT_SHORT	= $(IDENT) -s
#UNIX2OS9	= $(COCOTOOLSBIN)/u2o
#OS92UNIX	= $(COCOTOOLSBIN)/o2u
OS9FORMAT	= $(COCOTOOLSBIN)/os9 format
OS9FORMAT_SS35	= $(COCOTOOLSBIN)/os9 format -t35 -ss -dd
OS9FORMAT_SS40	= $(COCOTOOLSBIN)/os9 format -t40 -ss -dd
OS9FORMAT_SS80	= $(COCOTOOLSBIN)/os9 format -t80 -ss -dd
OS9FORMAT_DS40	= $(COCOTOOLSBIN)/os9 format -t40 -ds -dd
OS9FORMAT_DS80	= $(COCOTOOLSBIN)/os9 format -t80 -ds -dd
OS9GEN		= $(COCOTOOLSBIN)/os9 gen
OS9RENAME	= $(COCOTOOLSBIN)/os9 rename
OS9ATTR		= $(COCOTOOLSBIN)/os9 attr -q
OS9ATTR_TEXT	= $(OS9ATTR) -npe -npw -pr -ne -w -r
OS9ATTR_EXEC	= $(OS9ATTR) -pe -npw -pr -e -w -r
PADROM		= $(COCOTOOLSBIN)/os9 padrom
MOUNT		= sudo mount
UMOUNT		= sudo umount
LOREMOVE	= sudo /sbin/losetup -d
LOSETUP		= sudo /sbin/losetup
LINK		= ln
SOFTLINK	= $(LINK) -s
ARCHIVE		= zip -D

# Directories
3RDPARTY	= $(NITROS9DIR)/3rdparty
6809L1		= $(NITROS9DIR)/6809l1
6809L2		= $(NITROS9DIR)/6809l2
6309L2		= $(NITROS9DIR)/6309l2
C9		= $(HOME)/cloud9

# File managers
%.mn: %.asm
	$(AS) $(AFLAGS) $< $(ASOUT)$@

# Device drivers
%.dr: %.asm
	$(AS) $(AFLAGS) $< $(ASOUT)$@

# Device descriptors
%.dd: %.asm
	$(AS) $(AFLAGS) $< $(ASOUT)$@

# Subroutine modules
%.sb: %.asm
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

# All other modules
%: %.asm
	$(AS) $(AFLAGS) $< $(ASOUT)$@

