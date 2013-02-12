include ../../../rules.mak

DEPENDS		:= ./makefile

CMDS		= cls

ALLOBJS		= $(CMDS)

DSKDLADDUTILS	= dladd_utils.dsk

DSKS		= $(DSKDLADDUTILS)

all:	banner $(ALLOBJS) $(DEPENDS)	

banner:
	@$(ECHO) "**************************************************"
	@$(ECHO) "*                                                *"
	@$(ECHO) "*              David Ladd's Utilities            *"
	@$(ECHO) "*                                                *"
	@$(ECHO) "**************************************************"

$(DSKDLADDUTILS): $(CMDS)
	-$(RM) $@
	$(OS9FORMAT) $@
	$(MAKDIR) $@,CMDS
	$(CP) $(CMDS) $@,CMDS
	$(foreach file, $(CMDS), $(OS9ATTR_EXEC) $@,CMDS/$(file);)

dsk: all $(DSKS)

dskcopy: dsk
	$(CP) $(DSKS) $(DSKDIR)

clean:
	$(RM) $(ALLOBJS) $(DSKS)

info:
	@echo "*** David Ladd's Utilities ***"
	@$(foreach dsk, $(DSKS), $(ECHO) $(dsk);)


