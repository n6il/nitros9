include ../../../../Makefile.rules

DEPENDS		= ./Makefile

CMDS		= gshell cocopr control demo fstat gcal gcalc gclock \
		gport gprint

ALLOBJS		= $(CMDS)

all:	$(ALLOBJS)
	$(CHMOD) 755 $(ALLOBJS)

clean:
	$(RM) $(ALLOBJS)

showobjs:
	@$(ECHO) $(ALLOBJS)

identify:
	$(IDENT_SHORT) $(ALLOBJS)
