include ../../../../Makefile.rules

DEPENDS		= ./Makefile

SYSFILES	= LogBook
SYSWINFILES	= stdfonts stdpats_2 stdpats_4 stdpats_16 stdptrs
HELPFILES	= cocopr.hp control.hp gcal.hp gcalc.hp gclock.hp gport.hp \
		gprint.hp gshell.hp

HELPMSG		= helpmsg
ALLOBJS		= $(SYSFILES) $(HELPMSG)

all:	$(ALLOBJS) $(DEPENDS)
	$(UNIX2OS9) $(SYSFILES)
	$(CHMOD) 644 $(ALLOBJS)

$(HELPMSG): $(HELPFILES)
	$(MERGE) $(HELPFILES) > $@
	$(UNIX2OS9) $@

clean:
	$(OS92UNIX) $(SYSFILES)
	$(RM) $(HELPMSG) $(LEVEL1FILES)

showobjs:
	@$(ECHO) $(ALLOBJS)
