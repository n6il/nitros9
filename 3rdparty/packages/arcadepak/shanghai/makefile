ifndef  NITROS9DIR
NITROS9DIR      = $(HOME)/nitros9
endif
include $(NITROS9DIR)/rules.mak

DEPENDS		= ./makefile

CMDS		= shanghai stile

SYSFILES	= cards.til shanghai.til traffic.til
ROOTFILES	= empty_tiles.vef

ALLOBJS		= $(CMDS)

all:	$(ALLOBJS)

shanghai: shanghai.asm
	$(AS) $(AFLAGS) $< $(ASOUT)$@

clean:
	$(RM) $(ALLOBJS)

showobjs:
	@$(ECHO) $(CMDS)

showroot:
	@$(ECHO) $(ROOTFILES)

showsys:
	@$(ECHO) $(SYSFILES)
