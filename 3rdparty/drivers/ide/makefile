# Curtis Boyle's IDE Driver

include ../../../rules.mak

DEPENDS		= ./makefile
DRVRS		= ccide_l1.dr ccide_l2.dr
DESCS		= h0_ide_l1.dd h0_ide_l2.dd h1_ide_l1.dd h1_ide_l2.dd dd_ide_l1.dd dd_ide_l2.dd
ALLOBJS		= $(DRVRS) $(DESCS)
IDEL1FLAGS	= $(AFLAGS) -aLevel=1
IDEL2FLAGS	= $(AFLAGS) -aLevel=2

all:	$(ALLOBJS) $(DEPENDS)

# Drivers
ccide_l1.dr: ccide.asm
	$(AS) $(ASOUT)$@ $< $(IDEL1FLAGS)

ccide_l2.dr: ccide.asm
	$(AS) $(ASOUT)$@ $< $(IDEL2FLAGS)

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
	$(AS) $(ASOUT)$@ $< $(IDEL1FLAGS) -aITDRV=0 -aDD=1

dd_ide_l2.dd: idedesc.asm
	$(AS) $(ASOUT)$@ $< $(IDEL2FLAGS) -aITDRV=0 -aDD=1

clean:
	$(RM) $(ALLOBJS)

