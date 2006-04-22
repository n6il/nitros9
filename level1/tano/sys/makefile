include $(NITROS9DIR)/rules.mak

DEPENDS		= ./makefile
HD		= $(6809L1)/sys

SYSFILES	= errmsg motd password
HELPFILES	= $(HD)/asm.hp $(HD)/attr.hp $(HD)/backup.hp $(HD)/binex.hp $(HD)/build.hp $(HD)/chd.hp \
		$(HD)/chx.hp $(HD)/cmp.hp $(HD)/cobbler.hp $(HD)/config.hp $(HD)/copy.hp $(HD)/cputype.hp $(HD)/date.hp \
		$(HD)/dcheck.hp $(HD)/debug.hp $(HD)/ded.hp $(HD)/deiniz.hp $(HD)/del.hp $(HD)/deldir.hp $(HD)/devs.hp \
		$(HD)/dir.hp $(HD)/dirsort.hp $(HD)/disasm.hp $(HD)/display.hp $(HD)/dmode.hp $(HD)/dsave.hp $(HD)/dump.hp $(HD)/echo.hp \
		$(HD)/edit.hp $(HD)/error.hp $(HD)/ex.hp $(HD)/exbin.hp $(HD)/format.hp $(HD)/free.hp $(HD)/gfx.hp \
		$(HD)/help.hp $(HD)/ident.hp $(HD)/iniz.hp $(HD)/inkey.hp $(HD)/irqs.hp $(HD)/kill.hp $(HD)/link.hp \
		$(HD)/list.hp $(HD)/load.hp $(HD)/login.hp $(HD)/makdir.hp \
		$(HD)/mdir.hp $(HD)/megaread.hp $(HD)/merge.hp $(HD)/mpi.hp $(HD)/mfree.hp $(HD)/os9gen.hp \
		$(HD)/padrom.hp $(HD)/park.hp $(HD)/procs.hp $(HD)/prompt.hp $(HD)/pwd.hp $(HD)/pxd.hp \
	 	$(HD)/rename.hp $(HD)/save.hp $(HD)/setime.hp \
		$(HD)/setpr.hp $(HD)/shell.hp $(HD)/sleep.hp $(HD)/tee.hp $(HD)/tmode.hp $(HD)/touch.hp $(HD)/tsmon.hp \
		$(HD)/tuneport.hp $(HD)/unlink.hp $(HD)/verify.hp $(HD)/xmode.hp
HELPMSG		= helpmsg
ALLOBJS		= $(SYSFILES) $(HELPMSG)


all:	$(ALLOBJS) $(DEPENDS)

alldragon: $(ALLOBJS)

helpmsg: $(HELPFILES)
	$(MERGE) $(HELPFILES) > $@

clean:
	$(RM) $(HELPMSG)

showobjs:
	@$(ECHO) $(ALLOBJS)
