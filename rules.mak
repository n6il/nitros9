# Rules for making OS-9/6X09 modules

# These macros should change according to where the base directory of the
# OS-9 source tree is located
BASEDIR		= $(HOME)/nitros9
OS9TOOLSDIR	= $(HOME)/bin
DEFDIR		= $(BASEDIR)/defs
DSKDIR		= $(BASEDIR)/dsks


#################### DO NOT CHANGE ANYTHING BELOW THIS LINE ####################


# If we're using the OS-9 emulator and the *real* OS-9 assembler,
# uncomment the following two lines.
#AS		= os9 /mnt2/src/ocem/os9/asm
#ASOUT		= o=

# Use the cross assembler
AS		= $(OS9TOOLSDIR)/os9asm -i=$(DEFDIR)
ASOUT		= -o=
AFLAGS		= -q

# Commands
MAKDIR		= $(OS9TOOLSDIR)/os9 makdir
RM		= rm -f
MERGE		= cat
ECHO		= /bin/echo
CD		= cd
CP		= $(OS9TOOLSDIR)/os9 copy
CPL		= $(OS9TOOLSDIR)/os9 copy -l
TAR		= tar
CHMOD		= chmod
IDENT		= $(OS9TOOLSDIR)/os9 ident
IDENT_SHORT	= $(IDENT) -s
#UNIX2OS9	= $(OS9TOOLSDIR)/u2o
#OS92UNIX	= $(OS9TOOLSDIR)/o2u
OS9FORMAT	= $(OS9TOOLSDIR)/os9 format
OS9FORMAT_SS35	= $(OS9TOOLSDIR)/os9 format -t35 -ss -dd -4
OS9FORMAT_SS40	= $(OS9TOOLSDIR)/os9 format -t40 -ss -dd -4
OS9FORMAT_DS40	= $(OS9TOOLSDIR)/os9 format -t40 -ds -dd -4
OS9FORMAT_DS80	= $(OS9TOOLSDIR)/os9 format -t80 -ds -dd -9
OS9GEN		= $(OS9TOOLSDIR)/os9 gen
OS9RENAME	= $(OS9TOOLSDIR)/os9 rename
OS9ATTR		= $(OS9TOOLSDIR)/os9 attr -q
OS9ATTR_TEXT	= $(OS9ATTR) -npe -npw -pr -ne -w -r
OS9ATTR_EXEC	= $(OS9ATTR) -pe -npw -pr -e -w -r
PADROM		= $(OS9TOOLSDIR)/os9 padrom
MOUNT		= sudo mount
UMOUNT		= sudo umount
LOREMOVE	= sudo /sbin/losetup -d
LOSETUP		= sudo /sbin/losetup
LINK		= ln
SOFTLINK	= $(LINK) -s
ARCHIVE		= zip -D

# Directories
3RDPARTY	= $(BASEDIR)/3rdparty
6809L1		= $(BASEDIR)/6809l1
6809L2		= $(BASEDIR)/6809l2
6309L2		= $(BASEDIR)/6309l2
C9		= $(BASEDIR)/cloud9

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

