include ../../../rules.mak

DEPENDS		= ./makefile

CMDS		= getclk swread swset

ALLOBJS		= $(CMDS)

DSKSMARTWATCH	= smartwatch.dsk

DSKS		= $(DSKSMARTWATCH)

all:	banner $(ALLOBJS) $(DEPENDS)	

banner:
	@$(ECHO) "**************************************************"
	@$(ECHO) "*                                                *"
	@$(ECHO) "*               SmartWatch Utilities             *"
	@$(ECHO) "*                                                *"
	@$(ECHO) "**************************************************"

$(DSKSMARTWATCH): $(CMDS)
	$(RM) $@
	$(OS9FORMAT) $@
	$(MAKDIR) $@,CMDS
	$(CP) $(CMDS) $@,CMDS
	$(OS9ATTR_EXEC) $(foreach file,$(CMDS),$@,CMDS/$(file))

dsk: all $(DSKS)

dskcopy: dsk
	$(CP) $(DSKS) $(DSKDIR)

clean:
	$(RM) $(ALLOBJS) $(DSKS)

info:
	@echo "*** SmartWatch Utilities ***"
	@$(foreach dsk, $(DSKS), $(ECHO) $(dsk);)


