# Curtis Boyle's IDE Driver

include ../../../Makefile.rules

DEPENDS		= ./Makefile
DRVRS		= ccide_l1.dr ccide_l2.dr superide_l1.dr superide_l2.dr
DESCS		= h0_ide_l1.dd h0_ide_l2.dd h1_ide_l1.dd h1_ide_l2.dd dd_ide_l1.dd dd_ide_l2.dd
SUPERDESCS	= h0_superide_l1.dd h0_superide_l2.dd h0_superide_l1.dd h0_superide_l2.dd \
		dd_superide_l1.dd dd_superide_l2.dd
ALLOBJS		= $(DRVRS) $(DESCS) $(SUPERDESCS)
IDEL1FLAGS	= $(AFLAGS) -aLevel=1
IDEL2FLAGS	= $(AFLAGS) -aLevel=2

all:	$(ALLOBJS) $(DEPENDS)

# Drivers
# SuperIDE=1 selects code to work with Cloud-9's SuperIDE product
ccide_l1.dr: ccide.asm
	$(AS) $(ASOUT)$@ $< $(IDEL1FLAGS)

ccide_l2.dr: ccide.asm
	$(AS) $(ASOUT)$@ $< $(IDEL2FLAGS)

superide_l1.dr: ccide.asm
	$(AS) $(ASOUT)$@ $< $(IDEL1FLAGS) -aSuperIDE=1

superide_l2.dr: ccide.asm
	$(AS) $(ASOUT)$@ $< $(IDEL2FLAGS) -aSuperIDE=1

# Descriptors
# ITDRV is the Master(0)/Slave(1) switch for device descriptors
h0_ide_l1.dd: idedesc.asm
	$(AS) $(ASOUT)$@ $< $(IDEL1FLAGS) -aITDRV=0

h0_ide_l2.dd: idedesc.asm
	$(AS) $(ASOUT)$@ $< $(IDEL2FLAGS) -aITDRV=0

h1_ide_l1.dd: idedesc.asm
	$(AS) $(ASOUT)$@ $< $(IDEL1FLAGS) -aITDRV=1

h1_ide_l2.dd: idedesc.asm
	$(AS) $(ASOUT)$@ $< $(IDEL2FLAGS) -aITDRV=1

dd_ide_l1.dd: idedesc.asm
	$(AS) $(ASOUT)$@ $< $(IDEL1FLAGS) -aITDRV=0

dd_ide_l2.dd: idedesc.asm
	$(AS) $(ASOUT)$@ $< $(IDEL2FLAGS) -aITDRV=0

h0_superide_l1.dd: idedesc.asm
	$(AS) $(ASOUT)$@ $< $(IDEL1FLAGS) -aSuperIDE=1 -aITDRV=0

h0_superide_l2.dd: idedesc.asm
	$(AS) $(ASOUT)$@ $< $(IDEL2FLAGS) -aSuperIDE=1 -aITDRV=0

h1_superide_l1.dd: idedesc.asm
	$(AS) $(ASOUT)$@ $< $(IDEL1FLAGS) -aSuperIDE=1 -aITDRV=1

h1_superide_l2.dd: idedesc.asm
	$(AS) $(ASOUT)$@ $< $(IDEL2FLAGS) -aSuperIDE=1 -aITDRV=1

dd_superide_l1.dd: idedesc.asm
	$(AS) $(ASOUT)$@ $< $(IDEL1FLAGS) -aSuperIDE=1 -aITDRV=0

dd_superide_l2.dd: idedesc.asm
	$(AS) $(ASOUT)$@ $< $(IDEL2FLAGS) -aSuperIDE=1 -aITDRV=0

clean:
	$(RM) $(ALLOBJS)

