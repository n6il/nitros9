ifndef  NITROS9DIR
NITROS9DIR      = $(HOME)/nitros9
endif
include $(NITROS9DIR)/rules.mak

DEPENDS		= ./makefile

L2DRIVERS	= sdisk3_dpj.dr sdisk3_dmc.dr
NITROSDRIVERS	= sdisk3_dpj_63.dr sdisk3_dmc_63.dr
DESCS		= ddd0_35s.dd d0_35s.dd d1_35s.dd \
		ddd0_40d.dd d0_40d.dd d1_40d.dd \
		ddd0_80d.dd d0_80d.dd d1_80d.dd
ALLOBJS		= $(L2DRIVERS) $(NITROSDRIVERS) $(DESCS)

# Device Descriptor Macros
SSDD35          = -aCyls=35 -aSides=1 -aSectTrk=18 -aSectTrk0=18 \
                -aInterlv=3 -aSAS=8 -aDensity=1
DSDD40          = -aCyls=40 -aSides=2 -aSectTrk=18 -aSectTrk0=18 \
                -aInterlv=3 -aSAS=8 -aDensity=1
DSDD80          = -aCyls=80 -aSides=2 -aSectTrk=18 -aSectTrk0=18 \
                -aInterlv=3 -aSAS=8 -aDensity=3

all:	$(ALLOBJS) $(DEPENDS)

# Device Drivers
sdisk3_dpj_63.dr: sdisk3_dpj.asm
	$(AS) $(ASOUT)$@ $< $(AFLAGS) -aNitrOS9=1

sdisk3_dmc_63.dr: sdisk3_dmc.asm
	$(AS) $(ASOUT)$@ $< $(AFLAGS) -aNitrOS9=1

# Device Descriptors
# 35 Track Single-Sided
ddd0_35s.dd: sdisk3desc.asm
	$(AS) $(ASOUT)$@ $< $(AFLAGS) $(SSDD35) -aDD=1

d0_35s.dd: sdisk3desc.asm
	$(AS) $(ASOUT)$@ $< $(AFLAGS) $(SSDD35)

d1_35s.dd: sdisk3desc.asm
	$(AS) $(ASOUT)$@ $< $(AFLAGS) $(SSDD35) -aDNum=1

# 40 Track Double-Sided
ddd0_40d.dd: sdisk3desc.asm
	$(AS) $(ASOUT)$@ $< $(AFLAGS) $(DSDD40) -aDD=1

d0_40d.dd: sdisk3desc.asm
	$(AS) $(ASOUT)$@ $< $(AFLAGS) $(DSDD40)

d1_40d.dd: sdisk3desc.asm
	$(AS) $(ASOUT)$@ $< $(AFLAGS) $(DSDD40) -aDNum=1

# 80 Track Double-Sided
ddd0_80d.dd: sdisk3desc.asm
	$(AS) $(ASOUT)$@ $< $(AFLAGS) $(DSDD80) -aDD=1

d0_80d.dd: sdisk3desc.asm
	$(AS) $(ASOUT)$@ $< $(AFLAGS) $(DSDD80)

d1_80d.dd: sdisk3desc.asm
	$(AS) $(ASOUT)$@ $< $(AFLAGS) $(DSDD80) -aDNum=1

clean:
	$(RM) $(ALLOBJS)

