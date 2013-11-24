include ../../../rules.mak

vpath %.asm $(LEVEL2)/modules:$(LEVEL1)/modules

L1_256 = $(AFLAGS) -aLevel=1 -aRAMSize=1
L2_256 = $(AFLAGS) -aLevel=2 -aRAMSize=1
L1_512 = $(AFLAGS) -aLevel=1 -aRAMSize=2
L2_512 = $(AFLAGS) -aLevel=2 -aRAMSize=2

L2_DNHFC = $(AFLAGS) -aLevel=2

DEPENDS		= ./makefile
DRVRS		= rampak.dr parallel.dr
NHDRVRS		= cc3disk_sc2_irq.dr cc3disk_sc2_slp.dr
FLOPPYDESCS	= ddd0_35s.dd d0_35s.dd d1_35s.dd	\
		ddd0_40d.dd d0_40d.dd d1_40d.dd		\
		ddd0_80d.dd d0_80d.dd d1_80d.dd
RAMDISKDESCS	= r0_256_l1.dd r0_256_l2.dd r0_512_l1.dd r0_512_l2.dd
PRINTERDESCS	= pp.dd
DESCS		= $(FLOPPYDESCS) $(RAMDISKDESCS) $(PRINTERDESCS)
ALLOBJS		= $(DRVRS) $(DESCS) $(NHDRVRS)

# Device Descriptor Macros
SSDD35          = -aCyls=35 -aSides=1 -aSectTrk=18 -aSectTrk0=18 \
                -aInterlv=3 -aSAS=8 -aDensity=1
DSDD40          = -aCyls=40 -aSides=2 -aSectTrk=18 -aSectTrk0=18 \
                -aInterlv=3 -aSAS=8 -aDensity=1
DSDD80          = -aCyls=80 -aSides=2 -aSectTrk=18 -aSectTrk0=18 \
                -aInterlv=3 -aSAS=8 -aDensity=3

all:	$(ALLOBJS) $(DEPENDS)

# Disto Super Controller II Drivers
cc3disk_sc2_irq.dr: cc3disk_sc2_irq.asm
	$(AS) $(ASOUT)$@ $< $(L2_DNHFC)
   
cc3disk_sc2_slp.dr: cc3disk_sc2_slp.asm
	$(AS) $(ASOUT)$@ $< $(L2_DNHFC)
   
# Disto Super Controller II Device Descriptors
# 35 Track Single-Sided
ddd0_35s.dd: rb1773desc.asm
	$(AS) $(ASOUT)$@ $< $(AFLAGS) $(SSDD35) -aDD=1

d0_35s.dd: rb1773desc.asm
	$(AS) $(ASOUT)$@ $< $(AFLAGS) $(SSDD35)

d1_35s.dd: rb1773desc.asm
	$(AS) $(ASOUT)$@ $< $(AFLAGS) $(SSDD35) -aDNum=1

# 40 Track Double-Sided
ddd0_40d.dd: rb1773desc.asm  
	$(AS) $(ASOUT)$@ $< $(AFLAGS) $(DSDD40) -aDD=1

d0_40d.dd: rb1773desc.asm       
	$(AS) $(ASOUT)$@ $< $(AFLAGS) $(DSDD40)

d1_40d.dd: rb1773desc.asm
	$(AS) $(ASOUT)$@ $< $(AFLAGS) $(DSDD40) -aDNum=1

# 80 Track Double-Sided
ddd0_80d.dd: rb1773desc.asm
	$(AS) $(ASOUT)$@ $< $(AFLAGS) $(DSDD80) -aDD=1

d0_80d.dd: rb1773desc.asm
	$(AS) $(ASOUT)$@ $< $(AFLAGS) $(DSDD80)

d1_80d.dd: rb1773desc.asm
	$(AS) $(ASOUT)$@ $< $(AFLAGS) $(DSDD80) -aDNum=1

# RAM Disk Descriptors
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

