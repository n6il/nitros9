include ../../../../rules.mak

vpath %.asm $(6809L2)/cmds:$(6809L1)/cmds

DEPENDS		= ./makefile

CMDS		= shell utilpak1 grfdrv \
		gshell cocopr control demo fstat \
		gcal gcalc gclock gport gprint \
		backup format free help

SHELLMODS       = shellplus date deiniz echo iniz link load save unlink
UTILPAK1	= attr build copy del deldir dir display list makdir mdir \
		merge mfree procs rename sleep tmode

ALLOBJS		= $(CMDS)

all:	$(ALLOBJS)

gshell: gshell.asm
	$(AS) $(ASOUT)$@ $< $(AFLAGS)

shell:	$(SHELLMODS) $(DEPENDS)
	$(MERGE) $(SHELLMODS)>$@
	@$(ECHO) "*** Be sure the size of this file is less than 7681 bytes! ***"
	@ls -l $@
	@$(ECHO) ""

utilpak1: $(UTILPAK1) $(DEPENDS)
	$(MERGE) $(UTILPAK1)>$@
	@$(ECHO) "*** Be sure the size of this file is less than 7681 bytes! ***"
	@ls -l $@
	@$(ECHO) ""

clean:
	$(RM) $(ALLOBJS)

showobjs:
	@$(ECHO) $(ALLOBJS)

identify:
	$(IDENT_SHORT) $(ALLOBJS)
