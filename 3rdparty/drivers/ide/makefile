include ../../../Makefile.rules

DEPENDS		= ./Makefile
DRVRS		= ccide_l1.dr ccide_l2.dr superide_l1.dr superide_l2.dr
DESCS		= h0_ide_l1.dd h0_ide_l2.dd dd_ide_l1.dd dd_ide_l2.dd
SUPERDESCS	= h0_superide_l1.dd h0_superide_l2.dd dd_superide_l1.dd \
		dd_superide_l2.dd
ALLOBJS		= $(DRVRS) $(DESCS) $(SUPERDESCS)
IDEL1FLAGS	= $(AFLAGS) -aLevel=1
IDEL2FLAGS	= $(AFLAGS) -aLevel=2

all:	$(ALLOBJS) $(DEPENDS)

ccide_l1.dr: ccide.asm
	$(AS) $(ASOUT)$@ $< $(IDEL1FLAGS)

ccide_l2.dr: ccide.asm
	$(AS) $(ASOUT)$@ $< $(IDEL2FLAGS)

superide_l1.dr: ccide.asm
	$(AS) $(ASOUT)$@ $< $(IDEL1FLAGS) -aSuperIDE=1

superide_l2.dr: ccide.asm
	$(AS) $(ASOUT)$@ $< $(IDEL2FLAGS) -aSuperIDE=1

h0_ide_l1.dd: idedesc.asm
	$(AS) $(ASOUT)$@ $< $(IDEL1FLAGS)

h0_ide_l2.dd: idedesc.asm
	$(AS) $(ASOUT)$@ $< $(IDEL2FLAGS)

dd_ide_l1.dd: idedesc.asm
	$(AS) $(ASOUT)$@ $< $(IDEL1FLAGS)

dd_ide_l2.dd: idedesc.asm
	$(AS) $(ASOUT)$@ $< $(IDEL2FLAGS)

h0_superide_l1.dd: idedesc.asm
	$(AS) $(ASOUT)$@ $< $(IDEL1FLAGS) -aSuperIDE=1

h0_superide_l2.dd: idedesc.asm
	$(AS) $(ASOUT)$@ $< $(IDEL2FLAGS) -aSuperIDE=1

dd_superide_l1.dd: idedesc.asm
	$(AS) $(ASOUT)$@ $< $(IDEL1FLAGS) -aSuperIDE=1

dd_superide_l2.dd: idedesc.asm
	$(AS) $(ASOUT)$@ $< $(IDEL2FLAGS) -aSuperIDE=1

clean:
	$(RM) $(ALLOBJS)

