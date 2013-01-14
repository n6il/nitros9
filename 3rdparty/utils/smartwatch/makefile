ifndef  NITROS9DIR
NITROS9DIR      = $(HOME)/nitros9
endif
include $(NITROS9DIR)/rules.mak

DEPENDS		= ./makefile

CMDS		= getclk swread swset

ALLOBJS		= $(CMDS)

all:	banner $(ALLOBJS) $(DEPENDS)	

banner:
	@$(ECHO) "**************************************************"
	@$(ECHO) "*                                                *"
	@$(ECHO) "*               SmartWatch Utilities             *"
	@$(ECHO) "*                                                *"
	@$(ECHO) "**************************************************"
 
clean:
	$(RM) $(ALLOBJS)

