include ../../Makefile.rules

DEPENDS		= ./Makefile

CMDS		= asm attr backup binex build cmp cobbler copy cputype \
		date dcheck debug deiniz del deldir devs dir dirm disasm \
		display dmem dmode dsave dump echo edit error exbin exmode \
		format free grfdrv help ident iniz irqs link list load login \
		makdir mdir merge mfree mmap modpatch montype os9gen proc \
		procs pwd pxd reboot rename runb save setime shell_21 \
		shellplus sleep smap tee tmode touch \
		tsmon unlink verify wcreate xmode
SUBS            = gfx2 gfx inkey syscall

SHELLMODS	= shellplus date deiniz echo iniz link load save unlink
UTILPAK1	= attr copy del deldir dir display list makdir mdir \
		mfree procs rename tmode

BASIC09FILES	= runb.asm gfx.asm gfx2.asm inkey.asm syscall.asm
LEVEL1FILES	= asm.asm attr.asm backup.asm binex.asm build.asm cmp.asm \
		cobbler.asm copy.asm cputype.asm date.asm dcheck.asm \
		debug.asm deiniz.asm del.asm deldir.asm devs.asm dir.asm \
		disasm.asm display.asm dmode.asm dsave.asm dump.asm echo.asm \
		edit.asm error.asm exbin.asm exmode.asm format.asm free.asm \
		help.asm ident.asm iniz.asm irqs.asm link.asm \
		list.asm load.asm login.asm makdir.asm merge.asm os9gen.asm pd.asm rename.asm \
		save.asm setime.asm sleep.asm tee.asm tmode.asm touch.asm tuneport.asm tsmon.asm verify.asm xmode.asm

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
