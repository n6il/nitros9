include ../../../rules.mak

DEPENDS		= ./makefile

CMDS		= dasm

ALLOBJS		= $(CMDS)

DSKDASM		= dasm.dsk

DSKS		= $(DSKDASM)

all:	banner $(ALLOBJS) $(DEPENDS)	

banner:
	@$(ECHO) "**************************************************"
	@$(ECHO) "*                                                *"
	@$(ECHO) "*              Collyer Disassembler              *"
	@$(ECHO) "*                                                *"
	@$(ECHO) "**************************************************"

$(DSKDASM): $(CMDS)
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
	@echo "*** Collyer Disassembler ***"
	@$(foreach dsk, $(DSKS), $(ECHO) $(dsk);)


