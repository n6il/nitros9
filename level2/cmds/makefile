include ../../Makefile.rules

DEPENDS		= ./Makefile

CMDS		= attr binex build cmp cobbler copy date \
		deiniz del deldir dir display dsave dump echo error exbin format \
		free grfdrv help ident iniz link list load login makdir mdir \
		merge mfree modpatch montype procs pwd pxd rename save \
		setime shell_21 shell_22a sleep tee tmode tsmon unlink \
		verify wcreate xmode
SUBS            = gfx2 gfx inkey

SHELLMODS	= shell_22a deiniz display echo iniz link load save unlink
UTILPAK1	= attr build copy date del deldir dir list makdir mdir \
		merge mfree procs pwd pxd rename sleep tee tmode

LEVEL1FILES	= attr.asm binex.asm build.asm cmp.asm cobbler.asm copy.asm date.asm deiniz.asm del.asm deldir.asm \
		dir.asm display.asm dsave.asm dump.asm echo.asm error.asm exbin.asm format.asm free.asm gfx.asm help.asm ident.asm iniz.asm inkey.asm link.asm \
		list.asm load.asm login.asm makdir.asm merge.asm os9gen.asm pwd.asm pxd.asm rename.asm \
		save.asm setime.asm sleep.asm tee.asm tmode.asm tuneport.asm tsmon.asm verify.asm xmode.asm

ALLOBJS		= $(CMDS) $(SUBS)

# Files not compilable by os9asm: config
all:	$(ALLOBJS) shell utilpak1 $(DEPENDS)
	$(CHMOD) 755 $(ALLOBJS) shell utilpak1

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

$(LEVEL1FILES): $(LEVEL1)/CMDS/$@
	-$(SOFTLINK) $(LEVEL1)/CMDS/$@

clean:
	$(RM) $(ALLOBJS) $(LEVEL1FILES) shell utilpak1

showobjs:
	@$(ECHO) $(ALLOBJS) shell utilpak1

identify:
	$(IDENT_SHORT) $(ALLOBJS)
