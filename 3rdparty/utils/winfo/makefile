include ../../../rules.mak

DEPENDS		= ./makefile

CMDS		= witesta
SUBS		= winfo

ALLOBJS		= $(CMDS) $(SUBS)

all:	banner $(ALLOBJS) $(DEPENDS)	

banner:
	@$(ECHO) "**************************************************"
	@$(ECHO) "*                                                *"
	@$(ECHO) "*                   WInfo Utility                *"
	@$(ECHO) "*                                                *"
	@$(ECHO) "**************************************************"
 
clean:
	$(RM) $(ALLOBJS)

