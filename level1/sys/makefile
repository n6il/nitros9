include ../../Makefile.rules

DEPENDS		= ./Makefile

SYSFILES	= errmsg motd password logbook
HELPFILES	= asm.hp attr.hp backup.hp binex.hp build.hp chd.hp \
		chx.hp cmp.hp cobbler.hp config.hp copy.hp date.hp \
		dcheck.hp debug.hp deiniz.hp del.hp deldir.hp dir.hp \
		display.hp dsave.hp dump.hp echo.hp edit.hp error.hp ex.hp \
		exbin.hp format.hp free.hp help.hp ident.hp iniz.hp \
		inkey.hp kill.hp link.hp list.hp load.hp login.hp makdir.hp \
		mdir.hp merge.hp mfree.hp os9gen.hp \
		park.hp procs.hp pwd.hp pxd.hp rename.hp save.hp setime.hp \
		setpr.hp shell.hp sleep.hp tee.hp tmode.hp touch.hp tsmon.hp \
		tuneport.hp unlink.hp verify.hp xmode.hp
HELPMSG		= helpmsg
ALLOBJS		= $(SYSFILES) $(HELPMSG)

all:	$(ALLOBJS)
	$(CHMOD) 644 $(ALLOBJS)

helpmsg: $(HELPFILES)
	$(MERGE) $(HELPFILES) > $@

clean:
	$(RM) $(HELPMSG)

showobjs:
	@$(ECHO) $(ALLOBJS)
