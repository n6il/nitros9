include ../../Makefile.rules

DEPENDS		= ./Makefile

CMDS		= attr binex build cmp cobbler copy date \
		deiniz del deldir dir display dump echo error exbin \
		free grfdrv help ident iniz link list load login makdir mdir \
		merge mfree montype procs pwd pxd rename save \
		setime shell_21 sleep tee tmode tsmon unlink \
		verify wcreate xmode
SUBS            = gfx2 gfx inkey

SHELLMODS	= shell_21 build copy date deiniz del dir display echo iniz \
		link list load makdir mdir merge mfree procs save tee tmode \
		unlink
UTILPAK1        = attr deldir dump free ident pwd pxd rename setime \
		sleep verify wcreate xmode

LEVEL1FILES	= binex.asm attr.asm build.asm cmp.asm cobbler.asm copy.asm date.asm deiniz.asm del.asm deldir.asm \
		dir.asm display.asm dump.asm echo.asm error.asm exbin.asm free.asm gfx.asm help.asm ident.asm iniz.asm inkey.asm link.asm \
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

$(LEVEL1FILES): ../../level1/CMDS/$@
	-$(SOFTLINK) ../../level1/CMDS/$@

clean:
	$(RM) $(ALLOBJS) $(LEVEL1FILES) shell utilpak1

showobjs:
	@$(ECHO) $(ALLOBJS) shell utilpak1

identify:
	$(IDENT_SHORT) $(ALLOBJS)
