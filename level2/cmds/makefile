include ../../Makefile.rules

DEPENDS		= ./Makefile

CMDS		= asm attr backup binex build cmp cobbler copy date dcheck debug \
		deiniz del deldir dir display dsave dump echo edit error exbin format \
		free grfdrv help ident iniz link list load login makdir mdir \
		merge mfree modpatch montype os9gen procs pwd pxd rename runb save \
		setime shell_21 shellplus sleep tee tmode tsmon unlink \
		verify wcreate xmode
SUBS            = gfx2 gfx inkey syscall

SHELLMODS	= shellplus build deiniz echo iniz link list load save unlink
UTILPAK1	= attr copy display del deldir dir makdir mdir \
		mfree procs rename sleep tmode

BASIC09FILES	= runb.asm gfx.asm gfx2.asm inkey.asm syscall.asm
LEVEL1FILES	= asm.asm attr.asm backup.asm binex.asm build.asm cmp.asm cobbler.asm copy.asm date.asm dcheck.asm debug.asm deiniz.asm del.asm deldir.asm \
		dir.asm display.asm dsave.asm dump.asm echo.asm edit.asm error.asm exbin.asm format.asm free.asm help.asm ident.asm iniz.asm link.asm \
		list.asm load.asm login.asm makdir.asm merge.asm os9gen.asm pd.asm rename.asm \
		save.asm setime.asm sleep.asm tee.asm tmode.asm tuneport.asm tsmon.asm verify.asm xmode.asm

ALLOBJS		= $(CMDS) $(SUBS)

# Files not compilable by os9asm: config
all:	$(ALLOBJS) shell utilpak1 $(DEPENDS)
	$(CHMOD) 755 $(ALLOBJS) shell utilpak1

pwd:	pd.asm
	$(AS) $(AFLAGS) $< $(ASOUT)$@ -aPWD=1

pxd:	pd.asm
	$(AS) $(AFLAGS) $< $(ASOUT)$@ -aPXD=1

shell:  $(SHELLMODS) $(DEPENDS)
	$(MERGE) $(SHELLMODS)>$@
	@$(ECHO) "*** Be sure the size of this file is less than 7681 bytes! ***"
	@ls -l $@
	@$(ECHO) ""

utilpak1:  $(UTILPAK1) $(DEPENDS)
	$(MERGE) $(UTILPAK1)>$@
	@$(ECHO) "*** Be sure the size of this file is less than 7681 bytes! ***"
	@ls -l $@
	@$(ECHO) ""

$(BASIC09FILES): $(BASEDIR)/3rdparty/packages/basic09/$@
	-$(SOFTLINK) $(BASEDIR)/3rdparty/packages/basic09/$@

$(LEVEL1FILES): $(LEVEL1)/CMDS/$@
	-$(SOFTLINK) $(LEVEL1)/CMDS/$@

clean:
	$(RM) shell utilpak1 $(ALLOBJS) $(BASIC09FILES) $(LEVEL1FILES)

showobjs:
	@$(ECHO) shell utilpak1 $(ALLOBJS)

identify:
	$(IDENT_SHORT) $(ALLOBJS)
