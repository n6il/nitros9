include ../../Makefile.rules

DEPENDS		= ./Makefile

SYSFILES	= errmsg LogBook password motd
SYSWINFILES	= stdfonts stdpats_2 stdpats_4 stdpats_16 stdptrs
L1HELPFILES	= asm.hp attr.hp backup.hp binex.hp build.hp chd.hp \
		chx.hp cmp.hp cobbler.hp config.hp copy.hp date.hp \
		dcheck.hp debug.hp deiniz.hp del.hp deldir.hp dir.hp \
		display.hp dsave.hp dump.hp echo.hp edit.hp error.hp ex.hp \
		exbin.hp format.hp free.hp help.hp ident.hp iniz.hp \
		inkey.hp kill.hp link.hp list.hp load.hp login.hp makdir.hp \
		mdir.hp merge.hp mfree.hp os9gen.hp \
		park.hp procs.hp pwd.hp pxd.hp rename.hp save.hp setime.hp \
		setpr.hp shell.hp sleep.hp tee.hp tmode.hp touch.hp tsmon.hp \
		tuneport.hp unlink.hp verify.hp xmode.hp
L2HELPFILES	= basic09.hp gfx.hp gfx2.hp grfdrv.hp make.hp maketerm.hp \
		modpatch.hp montype.hp rdump.hp rlink.hp rma.hp runb.hp \
		scred.hp wcreate.hp

HELPMSG		= helpmsg
ALLOBJS		= $(SYSFILES) $(SYSWINFILES) $(HELPMSG)

all:	$(ALLOBJS) $(DEPENDS)
	$(UNIX2OS9) $(SYSFILES)
	$(CHMOD) 644 $(ALLOBJS)

$(HELPMSG): $(L1HELPFILES)
	$(MERGE) $(L1HELPFILES) $(L2HELPFILES) > $@
	$(UNIX2OS9) $@

$(L1HELPFILES): $(LEVEL1)/SYS/$@
	-$(SOFTLINK) $(LEVEL1)/SYS/$@

clean:
	$(OS92UNIX) $(SYSFILES)
	$(RM) $(HELPMSG) $(L1HELPFILES)

showobjs:
	@$(ECHO) $(ALLOBJS)
