include ../../../../rules.mak

DEPENDS		= ./makefile

OSCMDS		= $(6809L2)/cmds/shell $(6809L2)/cmds/utilpak1 \
		$(6809L2)/cmds/grfdrv $(6809L2)/cmds/backup \
		$(6809L2)/cmds/format $(6809L2)/cmds/free $(6809L2)/cmds/help
CMDS		= gshell cocopr control demo fstat \
		gcal gcalc gclock gport gprint gsort

ALLOBJS		= $(OSCMDS) $(CMDS)

all:	cmds $(ALLOBJS)

cmds:
	$(CD) $(6809L2)/cmds; make

gshell: gshell.asm
	$(AS) $(ASOUT)$@ $< $(AFLAGS)

clean:
	$(RM) $(CMDS)

showobjs:
	@$(ECHO) $(ALLOBJS)

identify:
	$(IDENT_SHORT) $(ALLOBJS)
