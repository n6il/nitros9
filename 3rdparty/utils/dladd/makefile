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
	$(RM) $@
	$(OS9FORMAT) $@
	$(MAKDIR) $@,CMDS
	$(OS9COPY) $(CMDS) $@,CMDS
	$(OS9ATTR_EXEC) $(foreach file,$(CMDS),$@,CMDS/$(file))

dsk: all $(DSKS)

dskcopy: dsk
	$(OS9COPY) $(DSKS) $(DSKDIR)

clean:
	$(RM) $(ALLOBJS) $(DSKS)

info:
	@echo "*** David Ladd's Utilities ***"
	@$(foreach dsk, $(DSKS), $(ECHO) $(dsk);)


