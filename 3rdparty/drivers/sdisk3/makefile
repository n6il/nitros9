include ../../../Makefile.rules

DEPENDS		= ./Makefile

DRIVERS		= sdisk3_dpj.dr sdisk3_dmc.dr
DESCS		= d0_40d.dd ddd0_40d.dd
ALLOBJS		= $(DRIVERS) $(DESCS)

all:	$(ALLOBJS) $(DEPENDS)

d0_40d.dd: d0.asm
	$(AS) $(ASOUT)$@ $< $(AFLAGS)

ddd0_40d.dd: d0.asm
	$(AS) $(ASOUT)$@ $< $(AFLAGS) -aDD=1

clean:
	$(RM) $(ALLOBJS)

