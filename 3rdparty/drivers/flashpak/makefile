include ../../../Makefile.rules

L1 = $(AFLAGS) -aLevel=1
L2 = $(AFLAGS) -aLevel=2

DEPENDS		= ./Makefile
DRVRS		= flashpak.dr
DESCS           = f0_l1.dd f0_l2.dd
ALLOBJS		= $(DRVRS) $(DESCS)

all:	$(ALLOBJS) $(DEPENDS)

f0_l1.dd: f0.asm
	$(AS) $(ASOUT)$@ $< $(L1)

f0_l2.dd: f0.asm
	$(AS) $(ASOUT)$@ $< $(L2)

clean:
	$(RM) $(ALLOBJS)

