include ../../../../rules.mak

vpath %.asm $(6809L2)/cmds

DEPENDS		= ./makefile

CMDS		= grfdrv \
		gshell cocopr control demo fstat gcal gcalc gclock gport \
		gprint

ALLOBJS		= $(CMDS)

all:	$(ALLOBJS)

gshell: gshell.asm
	$(AS) $(ASOUT)$@ $< $(AFLAGS)

clean:
	$(RM) $(ALLOBJS)

showobjs:
	@$(ECHO) $(ALLOBJS)

identify:
	$(IDENT_SHORT) $(ALLOBJS)
