include ../../../Makefile.rules

L1_256 = $(AFLAGS) -aLevel=1 -aRAMSize=1
L2_256 = $(AFLAGS) -aLevel=2 -aRAMSize=1
L1_512 = $(AFLAGS) -aLevel=1 -aRAMSize=2
L2_512 = $(AFLAGS) -aLevel=2 -aRAMSize=2

DEPENDS		= ./Makefile
DRVRS		= rampak.dr parallel.dr
DESCS           = r0_256_l1.dd r0_256_l2.dd r0_512_l1.dd r0_512_l2.dd pp.dd
ALLOBJS		= $(DRVRS) $(DESCS)

all:	$(ALLOBJS) $(DEPENDS)

r0_256_l1.dd: r0.asm
	$(AS) $(ASOUT)$@ $< $(L1_256)

r0_512_l1.dd: r0.asm
	$(AS) $(ASOUT)$@ $< $(L1_512)

r0_256_l2.dd: r0.asm
	$(AS) $(ASOUT)$@ $< $(L2_256)

r0_512_l2.dd: r0.asm
	$(AS) $(ASOUT)$@ $< $(L2_512)

clean:
	$(RM) $(ALLOBJS)

