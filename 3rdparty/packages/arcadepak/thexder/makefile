ifndef  NITROS9DIR
NITROS9DIR      = $(HOME)/nitros9
endif
include $(NITROS9DIR)/rules.mak

DEPENDS		= ./makefile

CMDS		= thexder thexs

SYSFILES	= ia.fnt

ALLOBJS		= $(CMDS)

all:	$(ALLOBJS)

thexder:	thexder.asm
	$(AS) $(AFLAGS) $< $(ASOUT)$@

clean:
	$(RM) $(ALLOBJS)

showobjs:
	@$(ECHO) $(CMDS)

showsys:
	@$(ECHO) $(SYSFILES)

showroot:
	@$(ECHO) $(ROOTFILES)
