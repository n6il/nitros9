include ../../../Makefile.rules

DEPENDS		= ./Makefile

L2DRIVERS	= sdisk3_dpj.dr sdisk3_dmc.dr
NITROSDRIVERS	= sdisk3_dpj_63.dr sdisk3_dmc_63.dr
DESCS		= d0_40d.dd ddd0_40d.dd
ALLOBJS		= $(L2DRIVERS) $(NITROSDRIVERS) $(DESCS)

all:	$(ALLOBJS) $(DEPENDS)

d0_40d.dd: d0.asm
	$(AS) $(ASOUT)$@ $< $(AFLAGS)

ddd0_40d.dd: d0.asm
	$(AS) $(ASOUT)$@ $< $(AFLAGS) -aDD=1

sdisk3_dpj_63.dr: sdisk3_dpj.asm
	$(AS) $(ASOUT)$@ $< $(AFLAGS) -aNitrOS9=1

sdisk3_dmc_63.dr: sdisk3_dmc.asm
	$(AS) $(ASOUT)$@ $< $(AFLAGS) -aNitrOS9=1

clean:
	$(RM) $(ALLOBJS)

