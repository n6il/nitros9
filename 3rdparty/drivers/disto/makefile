include ../../../Makefile.rules

L1_256 = $(AFLAGS) -aLevel=1 -aRAMSize=1
L2_256 = $(AFLAGS) -aLevel=2 -aRAMSize=1
L1_512 = $(AFLAGS) -aLevel=1 -aRAMSize=2
L2_512 = $(AFLAGS) -aLevel=2 -aRAMSize=2

L2_DNHFC = $(AFLAGS) -aLevel=2

DEPENDS		= ./Makefile
DRVRS		= rampak.dr parallel.dr
NHDRVRS     = cc3disk_sc2_irq.dr cc3disk_sc2_slp.dr
DESCS       = r0_256_l1.dd r0_256_l2.dd r0_512_l1.dd r0_512_l2.dd pp.dd
ALLOBJS		= $(DRVRS) $(DESCS) $(NHDRVRS)

all:	$(ALLOBJS) $(DEPENDS)

r0_256_l1.dd: r0.asm
	$(AS) $(ASOUT)$@ $< $(L1_256)

r0_512_l1.dd: r0.asm
	$(AS) $(ASOUT)$@ $< $(L1_512)

r0_256_l2.dd: r0.asm
	$(AS) $(ASOUT)$@ $< $(L2_256)

r0_512_l2.dd: r0.asm
	$(AS) $(ASOUT)$@ $< $(L2_512)

cc3disk_sc2_irq.dr: cc3disk_sc2_irq.asm
	$(AS) $(ASOUT)$@ $< $(L2_DNHFC)
   
cc3disk_sc2_slp.dr: cc3disk_sc2_slp.asm
	$(AS) $(ASOUT)$@ $< $(L2_DNHFC)
   
clean:
	$(RM) $(ALLOBJS)

