include ../../../rules.mak

DEPENDS		= ./makefile

CMDS		= supercomm

ALLOBJS		= $(CMDS)

DSKSUPERCOMM	= supercomm.dsk

DSKS		= $(DSKSUPERCOMM)

all:	banner $(ALLOBJS) $(DEPENDS)	

banner:
	@$(ECHO) "**************************************************"
	@$(ECHO) "*                                                *"
	@$(ECHO) "*           Dave Phillipsen's Supercomm          *"
	@$(ECHO) "*                                                *"
	@$(ECHO) "**************************************************"

$(DSKSUPERCOMM): $(CMDS)
	$(RM) $@
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
	@echo "*** Dave Phillipsen's Supercomm ***"
	@$(foreach dsk, $(DSKS), $(ECHO) $(dsk);)


