PORT = coco3
ifndef  NITROS9DIR
NITROS9DIR      = $(HOME)/nitros9
endif
include $(NITROS9DIR)/rules.mak

vpath %.hp $(LEVEL1)/sys

DEPENDS		= ./makefile

L1TXTFILES	= errmsg password
L2TXTFILES	= motd
BINFILES	= stdfonts stdpats_2 stdpats_4 stdpats_16 stdptrs \
		ibmedcfont isolatin1font
HELPFILES	= asm.hp attr.hp \
		backup.hp basic09.hp binex.hp build.hp \
		chd.hp chx.hp cmp.hp cobbler.hp config.hp copy.hp cputype.hp \
		date.hp dcheck.hp debug.hp ded.hp deiniz.hp del.hp deldir.hp devs.hp \
		dir.hp dirsort.hp disasm.hp display.hp dmem.hp dmode.hp dsave.hp dump.hp \
		echo.hp edit.hp error.hp ex.hp exbin.hp \
		format.hp free.hp \
		gfx.hp gfx2.hp grfdrv.hp \
		help.hp \
		ident.hp iniz.hp inkey.hp irqs.hp \
		kill.hp \
		link.hp list.hp load.hp login.hp \
		makdir.hp mdir.hp megaread.hp merge.hp mfree.hp mmap.hp modpatch.hp \
		montype.hp mpi.hp os9gen.hp \
		padrom.hp park.hp pmap.hp proc.hp procs.hp prompt.hp pwd.hp pxd.hp \
		reboot.hp rename.hp runb.hp \
		save.hp setime.hp setpr.hp shell.hp sleep.hp smap.hp \
		tee.hp tmode.hp touch.hp tsmon.hp tuneport.hp \
		unlink.hp \
		verify.hp \
		wcreate.hp \
		xmode.hp

#HELPFILES	= make.hp maketerm.hp rdump.hp rlink.hp rma.hp scred.hp

HELPMSG		= helpmsg

TEXTFILES	= $(L2TXTFILES) $(HELPMSG) $(L1TXTFILES)
ALLOBJS		= $(TEXTFILES) $(BINFILES)

all:	$(ALLOBJS) $(DEPENDS)

$(HELPMSG): $(HELPFILES)
	$(MERGE) $^ > $@

$(L1TXTFILES): $(LEVEL1)/sys/$@
	-$(SOFTLINK) $(LEVEL1)/sys/$@

clean:
	$(RM) $(HELPMSG) $(L1TXTFILES) $(BINFILES)

showbinobjs:
	@$(ECHO) $(BINFILES)

showtextobjs:
	@$(ECHO) $(TEXTFILES)

showobjs:
	@$(ECHO) $(ALLOBJS)
