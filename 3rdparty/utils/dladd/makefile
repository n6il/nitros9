include ../../../rules.mak

DEPENDS		:= ./makefile

CMDS		= cls

DEFSDIR		= $(CC68L1)/defs

ALLOBJS		= $(CMDS)

all:	banner $(ALLOBJS) $(DEPENDS)	

banner:
	@$(ECHO) "**************************************************"
	@$(ECHO) "*                                                *"
	@$(ECHO) "*              David Ladd tools                  *"
	@$(ECHO) "*                                                *"
	@$(ECHO) "**************************************************"
 
clean:
	$(RM) $(ALLOBJS)

