include ../../../Makefile.rules

# NitrOS-9
H6309		= $(AFLAGS) -aH6309=1
# Non-NitrOS-9
M6809		= $(AFLAGS)

DEPENDS		= ./Makefile
ALLOBJS		= basic09_6809 basic09_6309 runb_6809 runb_6309 gfx inkey syscall_6809 syscall_6309

all:	$(ALLOBJS) $(DEPENDS)

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

clean:
	$(RM) $(ALLOBJS)

