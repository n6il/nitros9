include ../../../rules.mak

DEPENDS		= ./makefile

CMDS		= dasm

ALLOBJS		= $(CMDS)

all:	banner $(ALLOBJS) $(DEPENDS)	

banner:
	@$(ECHO) "**************************************************"
	@$(ECHO) "*                                                *"
	@$(ECHO) "*              Collyer Disassembler              *"
	@$(ECHO) "*                                                *"
	@$(ECHO) "**************************************************"
 
clean:
	$(RM) $(ALLOBJS)

