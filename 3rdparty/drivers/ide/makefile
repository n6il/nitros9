include ../../../Makefile.rules

DEPENDS		= ./Makefile
DRVRS		= ccide_l1.dr ccide_l2.dr
DESCS		= h0_ide_l1.dd h0_ide_l2.dd dd_ide_l1.dd dd_ide_l2.dd
ALLOBJS		= $(DRVRS) $(DESCS)
IDEL1FLAGS	= $(AFLAGS) -aLevel=1
IDEL2FLAGS	= $(AFLAGS) -aLevel=2

all:	$(ALLOBJS) $(DEPENDS)

ccide_l1.dr: ccide.asm
	$(AS) $(ASOUT)$@ $< $(IDEL1FLAGS)

ccide_l2.dr: ccide.asm
	$(AS) $(ASOUT)$@ $< $(IDEL2FLAGS)

h0_ide_l1.dd: h0_ide.asm
	$(AS) $(ASOUT)$@ $< $(IDEL1FLAGS)

h0_ide_l2.dd: h0_ide.asm
	$(AS) $(ASOUT)$@ $< $(IDEL2FLAGS)

dd_ide_l1.dd: dd_ide.asm
	$(AS) $(ASOUT)$@ $< $(IDEL1FLAGS)

dd_ide_l2.dd: dd_ide.asm
	$(AS) $(ASOUT)$@ $< $(IDEL2FLAGS)

clean:
	$(RM) $(ALLOBJS)

