include ../../Makefile.rules

DEPENDS		= ./Makefile

DEFS		= errmsg motd password
HELPFILES	= asm.hp attr.hp backup.hp build.hp chd.hp \
		chx.hp cmp.hp cobbler.hp config.hp copy.hp date.hp \
		dcheck.hp deiniz.hp del.hp deldir.hp dir.hp display.hp \
		dsave.hp echo.hp edit.hp error.hp ex.hp format.hp \
		free.hp gfx.hp help.hp ident.hp iniz.hp \
		inkey.hp kill.hp link.hp list.hp load.hp makdir.hp mdir.hp \
		merge.hp mfree.hp modpatch.hp montype.hp os9gen.hp procs.hp \
		pwd.hp pxd.hp rename.hp setime.hp setpr.hp shell.hp \
		tmode.hp tuneport.hp unlink.hp xmode.hp
ALLOBJS		= $(DEFS)
HELPMSG		= helpmsg

all:	$(ALLOBJS) $(HELPMSG)
	$(UNIX2OS9) $(ALLOBJS)

helpmsg: $(HELPFILES)
	$(MERGE) $(HELPFILES) > $@
	$(UNIX2OS9) $@

clean:
	$(OS92UNIX) $(ALLOBJS)
	$(RM) $(HELPMSG)

showobjs:
	@echo $(ALLOBJS)
