include ../../../../rules.mak

vpath %.asm ../cmds_6809

AFLAGS		+= -e
DEPENDS		= ./makefile

OSCMDS		= $(6309L2)/cmds/shell $(6309L2)/cmds/utilpak1 \
		$(6309L2)/cmds/grfdrv $(6309L2)/cmds/backup \
		$(6309L2)/cmds/format $(6309L2)/cmds/free $(6309L2)/cmds/help
CMDS		= gshell cocopr control demo fstat \
		gcal gcalc gclock gport gprint gsort

ALLOBJS		= $(OSCMDS) $(CMDS)

all:	cmds $(ALLOBJS)

cmds:
	$(CD) $(6309L2)/cmds; make

gshell: gshell.asm
	$(AS) $(ASOUT)$@ $< $(AFLAGS)

clean:
	$(RM) $(CMDS)

showobjs:
	@$(ECHO) $(ALLOBJS)

identify:
	$(IDENT_SHORT) $(ALLOBJS)
