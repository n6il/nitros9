# OS-9 Commands/Utilities
#

include ../../../rules.mak

DEPENDS		= ./makefile

CMDS		= bawk del grep mode send timer bigbro font makdir \
		more tee joypoll

ALLOBJS		= $(CMDS)

all:	banner $(ALLOBJS) $(DEPENDS)	

banner:
	@$(ECHO) "**************************************************"
	@$(ECHO) "*                                                *"
	@$(ECHO) "*             Boisy Pitre's Utilities            *"
	@$(ECHO) "*                                                *"
	@$(ECHO) "**************************************************"
 
clean:
	$(RM) $(ALLOBJS)

