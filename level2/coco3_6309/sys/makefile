PORT = coco3
include $(NITROS9DIR)/rules.mak

vpath %.hp $(6809L2)/sys:$(6809L1)/sys
vpath %.asm $(6809L2)/sys

DEPENDS		= ./makefile
HD		= $(6809L1)/sys
HDL2		= $(6809L2)/sys

L1TXTFILES	= errmsg password
L2TXTFILES	= motd
BINFILES	= stdfonts stdpats_2 stdpats_4 stdpats_16 stdptrs \
		ibmedcfont isolatin1font
HELPFILES	= $(HD)/asm.hp $(HD)/attr.hp \
		$(HD)/backup.hp $(HDL2)/basic09.hp $(HD)/binex.hp $(HD)/build.hp \
		$(HD)/chd.hp $(HD)/chx.hp $(HD)/cmp.hp $(HD)/cobbler.hp $(HD)/config.hp $(HD)/copy.hp $(HD)/cputype.hp \
		$(HD)/date.hp $(HD)/dcheck.hp $(HD)/debug.hp $(HD)/ded.hp $(HD)/deiniz.hp $(HD)/del.hp $(HD)/deldir.hp $(HD)/devs.hp \
		$(HD)/dir.hp $(HD)/dirsort.hp $(HD)/disasm.hp $(HD)/display.hp $(HDL2)/dmem.hp $(HD)/dmode.hp $(HD)/dsave.hp $(HD)/dump.hp \
		$(HD)/echo.hp $(HD)/edit.hp $(HD)/error.hp $(HD)/ex.hp $(HD)/exbin.hp \
		$(HD)/format.hp $(HD)/free.hp \
		$(HD)/gfx.hp $(HDL2)/gfx2.hp $(HDL2)/grfdrv.hp \
		$(HD)/help.hp \
		$(HD)/ident.hp $(HD)/iniz.hp $(HD)/inkey.hp $(HD)/irqs.hp \
		$(HD)/kill.hp \
		$(HD)/link.hp $(HD)/list.hp $(HD)/load.hp $(HD)/login.hp \
		$(HD)/makdir.hp $(HD)/mdir.hp $(HD)/megaread.hp $(HD)/merge.hp $(HD)/mfree.hp $(HDL2)/mmap.hp $(HDL2)/modpatch.hp \
		$(HDL2)/montype.hp $(HD)/mpi.hp $(HD)/os9gen.hp \
		$(HD)/padrom.hp $(HD)/park.hp $(HDL2)/pmap.hp $(HDL2)/proc.hp $(HD)/procs.hp $(HD)/prompt.hp $(HD)/pwd.hp $(HD)/pxd.hp \
		$(HDL2)/reboot.hp $(HD)/rename.hp $(HDL2)/runb.hp \
		$(HD)/save.hp $(HD)/setime.hp $(HD)/setpr.hp $(HD)/shell.hp $(HD)/sleep.hp $(HDL2)/smap.hp \
		$(HD)/tee.hp $(HD)/tmode.hp $(HD)/touch.hp $(HD)/tsmon.hp $(HD)/tuneport.hp \
		$(HD)/unlink.hp \
		$(HD)/verify.hp \
		$(HDL2)/wcreate.hp \
		$(HD)/xmode.hp

#HELPFILES	= make.hp maketerm.hp rdump.hp rlink.hp rma.hp scred.hp

HELPMSG		= helpmsg

TEXTFILES	= $(L2TXTFILES) $(HELPMSG) $(L1TXTFILES)
ALLOBJS		= $(TEXTFILES) $(BINFILES)

all:	$(ALLOBJS) $(DEPENDS)

$(HELPMSG): $(HELPFILES)
	$(MERGE) $^ > $@

$(L1TXTFILES): $(6809L1)/sys/$@
	-$(SOFTLINK) $(6809L1)/sys/$@

clean:
	$(RM) $(HELPMSG) $(L1TXTFILES) $(BINFILES)

showbinobjs:
	@$(ECHO) $(BINFILES)

showtextobjs:
	@$(ECHO) $(TEXTFILES)

showobjs:
	@$(ECHO) $(ALLOBJS)
