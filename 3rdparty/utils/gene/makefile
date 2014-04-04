# OS-9 Commands/Utilities

include ../../../rules.mak

AFLAGS = -DLevel=1

DEPENDS		= ./makefile

CMDS		= bootlink vfy

ALLOBJS		= $(CMDS)

DSKGENEUTILS	= gene_utils.dsk

DSKS		= $(DSKGENEUTILS)

all:	banner $(ALLOBJS) $(DEPENDS)	

banner:
	@$(ECHO) "**************************************************"
	@$(ECHO) "*                                                *"
	@$(ECHO) "*             Gene Heskett's Utilities           *"
	@$(ECHO) "*                                                *"
	@$(ECHO) "**************************************************"

$(DSKGENEUTILS): $(CMDS)
	$(RM) $@
	$(OS9FORMAT) $@
	$(MAKDIR) $@,CMDS
	$(OS9COPY) $(CMDS) $@,CMDS
	$(OS9ATTR_EXEC) $(foreach file,$(CMDS),$@,CMDS/$(file))

dsk: all $(DSKS)

dskcopy: dsk
	$(CP) $(DSKS) $(DSKDIR)

dskclean:
	$(RM) $(DSKS)

clean: dskclean
	$(RM) $(ALLOBJS)

info:
	@echo "*** Gene Heskett's Utilities ***"
	@$(foreach dsk, $(DSKS), $(ECHO) $(dsk);)

