include ../../../../rules.mak

H6309		= $(AFLAGS) -aH6309=1 -e
DEPENDS		= ./makefile

CMDS		= gshell_6309 cocopr control demo fstat gcal gcalc gclock \
		gport gprint

ALLOBJS		= $(CMDS)

all:	$(ALLOBJS)
	$(CD) icons; make

gshell_6309: gshell.asm
	$(AS) $(ASOUT)$@ $< $(H6309)

clean:
	$(RM) $(ALLOBJS)

showobjs:
	@$(ECHO) $(ALLOBJS)

identify:
	$(IDENT_SHORT) $(ALLOBJS)
