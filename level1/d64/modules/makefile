#
#modules/makefile
#
# 2005-04-24, P.Harvey-Smith, 
#	made descriptors for both 40 & 80 track drives for Dragon 64.
# 		
#
# 2005-05-31, P.Harvey-Smith,
# 	Steprate now passed in from ../makefile.dragon or ../makefile.dalpha
#
# 2005-12-31, P.Harvey-Smith,
#	Fixed up for renamed video drivers.
#
# 2006-01-08, P.Harvey-Smith.
#	Added descriptors for original Dragon Data single sided 5.25" drives.
#	Pass step rate to boot_d64, so that boot module steprate set correctly.
#
# 2006-01-18, P.Harvey-Smith,
#	Added ability to build for the Tano Dragon 64, using an RS-DOS
#	disk controler and a 60Hz clock.
#

PORT = d64
ifndef  NITROS9DIR
NITROS9DIR      = $(HOME)/nitros9
endif
include $(NITROS9DIR)/rules.mak

vpath %.asm $(LEVEL1)/modules

AFLAGS		+= -I$(LEVEL1)/modules

CLOCKELIM       = -aRTCElim=1
CLOCKDISTO2     = -aRTCDsto2=1
CLOCKDISTO4     = -aRTCDsto4=1
CLOCKBNB        = -aRTCBB=1
CLOCKSMART      = -aRTCSmart=1 -aMPIFlag=1
CLOCKHARRIS     = -aRTCHarrs=1
CLOCKCLOUD9     = -aRTCCloud9=1
CLOCKSOFT       = -aRTCSoft=1
CLOCKMESSEMU    = -aRTCMessEmu=1
CLOCKJVEMU      = -aRTCJVEmu=1

DEPENDS		= ./makefile
TPB		= $(3RDPARTY)/booters

BOOTERS		= boot_d64

BOOTTRACK	= rel $(BOOTERS)
KERNEL		= krn krnp2
SYSMODS		= ioman init sysgo_dd sysgo_h0

CLOCKS          = clock_60hz clock_50hz \
		clock2_elim clock2_disto2 clock2_disto4 clock2_bnb \
                clock2_smart clock2_harris clock2_cloud9 clock2_soft \
		clock2_messemu clock2_jvemu 

RBF		= rbf.mn \
		ddisk.dr \
		ddd0_40d.dd d0_40d.dd d1_40d.dd d2_40d.dd d3_40d.dd \
		ddd0_40s.dd d0_40s.dd d1_40s.dd d2_40s.dd d3_40s.dd \
		ddd0_80d.dd d0_80d.dd d1_80d.dd d2_80d.dd d3_80d.dd
		
SCF		= scf.mn \
		vrn.dr scdpp.dr sspak.dr vtio.dr \
		covdg.io cohr.io\
		nil.dd p_dpp.dd pipe.dd ssp.dd \
		term_sc6551.dt t2_sc6551.dt t3_sc6551.dt \
		term32.dt term51.dt term80.dt p1_sc6551dragon.dd

PIPE		= pipeman.mn \
		piper.dr \
		pipe.dd

ALLOBJS		= $(BOOTTRACK) $(KERNEL) $(SYSMODS) $(CLOCKS) $(RBF) $(SCF) $(PIPE) 

all:	$(ALLOBJS)

# Special cases

# Kernel
krn krnp2:
	$(CD) kernel; make $@
	$(OS9COPY) kernel/$@ .

boot_d64:	boot_d64.asm
	$(AS) $< $(ASOUT)$@ $(AFLAGS) -aDNum=0 -aStep=$(STEP)

# Clocks
clock_60hz: clock.asm
	$(AS) $(AFLAGS) $(ASOUT)$@ $< -aPwrLnFrq=60

clock_50hz: clock.asm
	$(AS) $(AFLAGS) $(ASOUT)$@ $< -aPwrLnFrq=50

clock2_bnb: clock2_ds1315.asm
	$(AS) $(AFLAGS) $(ASOUT)$@ $< -aBNB=1

clock2_cloud9: clock2_ds1315.asm
	$(AS) $(AFLAGS) $(ASOUT)$@ $< -aCLOUD9=1


# Floppy descriptors
SSDD35		= -aCyls=35 -aSides=1 -aSectTrk=18 -aSectTrk0=18 \
		-aInterlv=2 -aSAS=8 -aDensity=1 -aStep=0
SSDD40		= -aCyls=40 -aSides=1 -aSectTrk=18 -aSectTrk0=18 \
		-aInterlv=2 -aSAS=8 -aDensity=1 -aStep=$(STEP)
DSDD40		= -aCyls=40 -aSides=2 -aSectTrk=18 -aSectTrk0=18 \
		-aInterlv=2 -aSAS=8 -aDensity=1 -aStep=$(STEP)
SSDD80		= -aCyls=80 -aSides=1 -aSectTrk=18 -aSectTrk0=18 \
		-aInterlv=2 -aSAS=8 -aDensity=1 -aD35 -aStep=$(STEP)
DSDD80		= -aCyls=80 -aSides=2 -aSectTrk=18 -aSectTrk0=18 \
		-aInterlv=2 -aSAS=8 -aDensity=1 -aD35 -aStep=$(STEP)

#Dragon 64
#Dragon 64 Drives can be double or single sided, but assume 
# that /d0 and /d1 are double sided 40 track.

ddd0_40d.dd: ddiskdesc.asm
	$(AS) $< $(ASOUT)$@ $(AFLAGS) $(DSDD40) -aDNum=0 -aDD=1

d0_40d.dd: ddiskdesc.asm
	$(AS) $< $(ASOUT)$@ $(AFLAGS) $(DSDD40) -aDNum=0

d1_40d.dd: ddiskdesc.asm
	$(AS) $< $(ASOUT)$@ $(AFLAGS) $(DSDD40) -aDNum=1

d2_40d.dd: ddiskdesc.asm
	$(AS) $< $(ASOUT)$@ $(AFLAGS) $(DSDD40) -aDNum=2

d3_40d.dd: ddiskdesc.asm
	$(AS) $< $(ASOUT)$@ $(AFLAGS) $(DSDD40) -aDNum=3

#Single sided 40 track drives.
ddd0_40s.dd: ddiskdesc.asm
	$(AS) $< $(ASOUT)$@ $(AFLAGS) $(SSDD40) -aDNum=0 -aDD=1

d0_40s.dd: ddiskdesc.asm
	$(AS) $< $(ASOUT)$@ $(AFLAGS) $(SSDD40) -aDNum=0

d1_40s.dd: ddiskdesc.asm
	$(AS) $< $(ASOUT)$@ $(AFLAGS) $(SSDD40) -aDNum=1

d2_40s.dd: ddiskdesc.asm
	$(AS) $< $(ASOUT)$@ $(AFLAGS) $(SSDD40) -aDNum=2

d3_40s.dd: ddiskdesc.asm
	$(AS) $< $(ASOUT)$@ $(AFLAGS) $(SSDD40) -aDNum=3


ddd0_80d.dd: ddiskdesc.asm
	$(AS) $< $(ASOUT)$@ $(AFLAGS) $(DSDD80) -aDNum=0 -aDD=1

d0_80d.dd: ddiskdesc.asm
	$(AS) $< $(ASOUT)$@ $(AFLAGS) $(DSDD80) -aDNum=0

d1_80d.dd: ddiskdesc.asm
	$(AS) $< $(ASOUT)$@ $(AFLAGS) $(DSDD80) -aDNum=1

d2_80d.dd: ddiskdesc.asm
	$(AS) $< $(ASOUT)$@ $(AFLAGS) $(DSDD80) -aDNum=2

d3_80d.dd: ddiskdesc.asm
	$(AS) $< $(ASOUT)$@ $(AFLAGS) $(DSDD80) -aDNum=3


sysgo_dd: sysgo.asm
	$(AS) $(AFLAGS) $(ASOUT)$@ $< -aDD=1

sysgo_h0: sysgo.asm
	$(AS) $(AFLAGS) $(ASOUT)$@ $<

ddisk.dr: ddisk.asm
	$(AS) $(AFLAGS) $(ASOUT)$@ -aUPGRADED32=$(UPGRADED32) $< 


clean:
	$(CD) kernel; make $@
	$(RM) $(ALLOBJS)

showobjs:
	@$(ECHO) $(ALLOBJS)

showboottrack:
	@$(ECHO) $(BOOTTRACK)

showkernel:
	@$(ECHO) $(KERNEL)

showsysmods:
	@$(ECHO) $(SYSMODS)

showclocks:
	@$(ECHO) $(CLOCKS)

showrbf:
	@$(ECHO) $(RBF)

showscf:
	@$(ECHO) $(SCF)

showpipe:
	@$(ECHO) $(PIPE)

identify:
	$(IDENT_SHORT) $(ALLOBJS)
