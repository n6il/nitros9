include ../../../Makefile.rules

# NitrOS-9
NITROSFLAGS	= $(AFLAGS) -aH6309=1
# Non-NitrOS-9
OS9FLAGS	= $(AFLAGS)

DEPENDS		= ./Makefile
ALLOBJS		= basic09_6809 basic09_6309 runb_6309

all:	$(ALLOBJS) $(DEPENDS)

basic09_6309: basic09.asm
	$(AS) $(ASOUT)$@ $< $(NITROSFLAGS)

basic09_6809: basic09.asm
	$(AS) $(ASOUT)$@ $< $(OS9FLAGS)

runb_6309: runb.6309.asm
	$(AS) $(ASOUT)$@ $< $(NITROSFLAGS)

clean:
	$(RM) $(ALLOBJS)

