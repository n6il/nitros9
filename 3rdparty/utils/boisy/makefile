# OS-9 Commands/Utilities
#

include ../../../rules.mak

DEPENDS		= ./makefile

CMDS		= bawk del grep mode send timer bigbro font makdir \
		more tee joypoll

ALLOBJS		= $(CMDS)

DSKBOISYUTILS	= boisy_utils.dsk

DSKS		= $(DSKBOISYUTILS)

all:	banner $(ALLOBJS) $(DEPENDS)	

banner:
	@$(ECHO) "**************************************************"
	@$(ECHO) "*                                                *"
	@$(ECHO) "*             Boisy Pitre's Utilities            *"
	@$(ECHO) "*                                                *"
	@$(ECHO) "**************************************************"

$(DSKBOISYUTILS): $(CMDS)
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
	@echo "*** Boisy Pitre's Utilities ***"
	@$(foreach dsk, $(DSKS), $(ECHO) $(dsk);)

