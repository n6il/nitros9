include ../../Makefile.rules

DEPENDS		= ./Makefile

CMDS		= attr binex build cobbler copy date \
		deiniz del deldir ddir dir dirm display dmem dump echo exbin \
		free ident idir iniz link list load login makdir mdir \
		merge mfree mmap montype pmap proc procs pwd pxd rename save \
		setime shell_21 sleep swread swset tee tmode tsmon unlink \
		verify wcreate xmode
SUBS            = gfx inkey
ALLOBJS		= $(CMDS) $(SUBS)

SHELLMODS	= shell_21 build copy date deiniz del dir display echo iniz \
		link list load mdir merge mfree procs tmode unlink
UTILPAK1        = attr deldir dirm dmem free ident mmap proc rename setime tmode
UTILPAK2        = ddir idir pmap xmode

all:	$(ALLOBJS) shell utilpak1 utilpak2 $(DEPENDS)
	$(CHMOD) a+rx $(ALLOBJS) shell utilpak1 utilpak2

shell:  $(SHELLMODS) $(DEPENDS)
	$(MERGE) $(SHELLMODS)>$@
	@$(ECHO) "*** Be sure the size of this file is less than 7681 bytes! ***"
	@ls -l $@
	@$(ECHO)

utilpak1:  $(UTILPAK1) $(DEPENDS)
	$(MERGE) $(UTILPAK1)>$@
	@$(ECHO) "*** Be sure the size of this file is less than 7681 bytes! ***"
	@ls -l $@
	@$(ECHO)

utilpak2:  $(UTILPAK2) $(DEPENDS)
	$(MERGE) $(UTILPAK2)>$@
	@$(ECHO) "*** Be sure the size of this file is less than 7681 bytes! ***"
	@ls -l $@
	@$(ECHO)

clean:
	$(RM) $(ALLOBJS) shell utilpak1 utilpak2

