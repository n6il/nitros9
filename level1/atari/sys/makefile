PORT = atari
include $(NITROS9DIR)/rules.mak

vpath %.hp	$(LEVEL1)/sys

DEPENDS		= ./makefile

SYSFILES	= ../../sys/errmsg ../../sys/motd ../../sys/password inetd.conf
HELPFILES	= asm.hp attr.hp backup.hp binex.hp build.hp chd.hp \
		chx.hp cmp.hp cobbler.hp config.hp copy.hp cputype.hp date.hp \
		dcheck.hp debug.hp ded.hp deiniz.hp del.hp deldir.hp devs.hp \
		dir.hp dirsort.hp disasm.hp display.hp dmode.hp dsave.hp dump.hp echo.hp \
		edit.hp error.hp ex.hp exbin.hp format.hp free.hp gfx.hp \
		help.hp ident.hp iniz.hp inkey.hp irqs.hp kill.hp link.hp \
		list.hp load.hp login.hp makdir.hp \
		mdir.hp megaread.hp merge.hp mpi.hp mfree.hp os9gen.hp \
		padrom.hp park.hp procs.hp prompt.hp pwd.hp pxd.hp \
	 	rename.hp save.hp setime.hp \
		setpr.hp shell.hp sleep.hp tee.hp tmode.hp touch.hp tsmon.hp \
		tuneport.hp unlink.hp verify.hp xmode.hp
HELPMSG		= helpmsg
ALLOBJS		= $(SYSFILES) $(HELPMSG)


all:	$(ALLOBJS) $(DEPENDS)

alldragon: $(ALLOBJS)

helpmsg: $(HELPFILES)
	$(MERGE) $^ > $@

clean:
	$(RM) $(HELPMSG)

showobjs:
	@$(ECHO) $(ALLOBJS)
