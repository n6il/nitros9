include ../../../Makefile.rules

DISK	= basic09v010100.dsk

# NitrOS-9
H6309		= $(AFLAGS) -aH6309=1
# Non-NitrOS-9
M6809		= $(AFLAGS)

DEPENDS		= ./Makefile

TXTFILES	= ReadMe install6809 install6309
OBJS		= gfx inkey
OBJS6809	= basic09_6809 runb_6809 syscall_6809
OBJS6309	= basic09_6309 runb_6309 syscall_6309
ALLOBJS		= $(OBJS) $(OBJS6809) $(OBJS6309)

all:	$(ALLOBJS) $(DEPENDS)
	$(UNIX2OS9) $(TXTFILES)
	$(CHMOD) 755 $(ALLOBJS)

basic09_6309: basic09.asm
	$(AS) $(ASOUT)$@ $< $(H6309)

basic09_6809: basic09.asm
	$(AS) $(ASOUT)$@ $< $(M6809)

runb_6309: runb.asm
	$(AS) $(ASOUT)$@ $< $(H6309)

runb_6809: runb.asm
	$(AS) $(ASOUT)$@ $< $(M6809)

syscall_6809: syscall.asm
	$(AS) $(ASOUT)$@ $< $(M6809)

syscall_6309: syscall.asm
	$(AS) $(ASOUT)$@ $< $(H6309)

clean: dskclean
	$(RM) $(ALLOBJS)
	$(OS92UNIX) $(TXTFILES)

dsk:	all
	$(RM) $(DISK)
	$(OS9FORMAT) $(DISK) -n"Basic09"
	$(MAKDIR) $(DISK):CMDS
	$(CP) $(ALLOBJS) $(DISK):CMDS
	$(CP) $(TXTFILES) $(DISK):.

dskclean:
	-$(RM) $(DISK)
