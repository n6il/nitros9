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
	$(OS9COPY) $(CMDS) $@,CMDS
	$(OS9ATTR_EXEC) $(foreach file,$(CMDS),$@,CMDS/$(file))

dsk: all $(DSKS)

dskcopy: dsk
	$(CP) $(DSKS) $(DSKDIR)

clean:
	$(RM) $(ALLOBJS) $(DSKS)

info:
	@echo "*** Dave Phillipsen's Supercomm ***"
	@$(foreach dsk, $(DSKS), $(ECHO) $(dsk);)


