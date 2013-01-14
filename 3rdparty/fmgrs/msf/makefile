# MSF file manager
#

ifndef  NITROS9DIR
NITROS9DIR      = $(HOME)/nitros9
endif
include $(NITROS9DIR)/rules.mak

DEPENDS		= ./makefile

FMGRS		= msf_6309.mn msf_6809.mn
DESCS		= m0_40d.dd
ALLOBJS		= $(FMGRS) $(DESCS)

all:	$(ALLOBJS) $(DEPENDS)

clean:
	$(RM) $(ALLOBJS)

msf_6309.mn: msf.asm
	$(AS) $(AFLAGS) $< $(ASOUT)$@ -e -aH6309=1

msf_6809.mn: msf.asm
	$(AS) $(AFLAGS) $< $(ASOUT)$@

