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
	$(OS9COPY) $(CMDS) $@,CMDS
	$(OS9ATTR_EXEC) $(foreach file,$(CMDS),$@,CMDS/$(file))
	$(OS9COPY) $(SUBS) $@,CMDS
	$(OS9ATTR_EXEC) $(foreach file,$(SUBS),$@,CMDS/$(file))

dsk: all $(DSKS)

dskcopy: dsk
	$(CP) $(DSKS) $(DSKDIR)

clean:
	$(RM) $(ALLOBJS) $(DSKS)

info:
	@echo "*** WInfo Utility ***"
	@$(foreach dsk, $(DSKS), $(ECHO) $(dsk);)


