include ../../../rules.mak

DEPENDS		= ./makefile

CMDS		= witesta
SUBS		= winfo

ALLOBJS		= $(CMDS) $(SUBS)

DSKWINFO	= winfo.dsk

DSKS		= $(DSKWINFO)

all:	banner $(ALLOBJS) $(DEPENDS)	

banner:
	@$(ECHO) "**************************************************"
	@$(ECHO) "*                                                *"
	@$(ECHO) "*                   WInfo Utility                *"
	@$(ECHO) "*                                                *"
	@$(ECHO) "**************************************************"

$(DSKWINFO): $(CMDS)
	$(RM) $@
	$(OS9FORMAT) $@
	$(MAKDIR) $@,CMDS
	$(CP) $(CMDS) $@,CMDS
	$(OS9ATTR_EXEC) $(foreach file,$(CMDS),$@,CMDS/$(file))
	$(CP) $(SUBS) $@,CMDS
	$(OS9ATTR_EXEC) $(foreach file,$(SUBS),$@,CMDS/$(file))

dsk: all $(DSKS)

dskcopy: dsk
	$(CP) $(DSKS) $(DSKDIR)

clean:
	$(RM) $(ALLOBJS) $(DSKS)

info:
	@echo "*** WInfo Utility ***"
	@$(foreach dsk, $(DSKS), $(ECHO) $(dsk);)


