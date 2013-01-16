ifndef  NITROS9DIR
NITROS9DIR      = $(HOME)/nitros9
endif
include $(NITROS9DIR)/rules.mak

DEPENDS		= ./makefile

CMDS		= smash custom

SYSFILES	= flags.dat ia.fnt smash.dat smash.hsc
ROOTFILES	= 

ALLOBJS		= $(CMDS)

all:	$(ALLOBJS)

clean:
	$(RM) $(ALLOBJS)

showobjs:
	@$(ECHO) $(CMDS)

showroot:
	@$(ECHO) $(ROOTFILES)

showsys:
	@$(ECHO) $(SYSFILES)
