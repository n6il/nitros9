include ../../../../Makefile.rules

DEPENDS		= ./Makefile

SYSFILES	= LogBook env.file
HELPFILES	= cocopr.hp control.hp gcal.hp gcalc.hp gclock.hp gport.hp \
		gprint.hp gshell.hp
ASSETFILES	= stdfonts stdpats_2 stdpats_4 stdpats_16 stdptrs \
		ibm_edc.fnt iso_latin1.fnt

HELPMSG		= helpmsg

BINFILES	= $(ASSETFILES)
TEXTFILES	= $(SYSFILES) $(HELPMSG)
ALLOBJS		= $(BINFILES) $(TEXTFILES)

all:	$(ALLOBJS) $(DEPENDS)
	$(CHMOD) 644 $(ALLOBJS)

$(HELPMSG): $(HELPFILES)
	$(MERGE) $(HELPFILES) > $@

clean:
	$(RM) $(HELPMSG)

showbinobjs:
	@$(ECHO) $(BINFILES)

showtextobjs:
	@$(ECHO) $(TEXTFILES)

showobjs:
	@$(ECHO) $(ALLOBJS)
