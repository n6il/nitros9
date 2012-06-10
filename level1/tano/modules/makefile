PORT = tano
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

BOOTERS		= boot_1773_6ms boot_1773_30ms
#		boot_rampak boot_wd1002 boot_burke
BOOTTRACK	= rel $(BOOTERS)
KERNEL		= krn krnp2
SYSMODS		= ioman init sysgo_dd sysgo_h0
CLOCKS          = clock_60hz clock_50hz \
		clock2_elim clock2_disto2 clock2_disto4 clock2_bnb \
                clock2_smart clock2_harris clock2_cloud9 clock2_soft \
		clock2_messemu clock2_jvemu

RBF		= rbf.mn \
		rb1773.dr rb1773_scii_ff74.dr rb1773_scii_ff58.dr \
		ddd0_35s.dd d0_35s.dd d1_35s.dd d2_35s.dd d3_35s.dd \
		ddd0_40d.dd d0_40d.dd d1_40d.dd d2_40d.dd \
		ddd0_80d.dd d0_80d.dd d1_80d.dd d2_80d.dd

SCF		= scf.mn \
		sc6551dragon.dr vrn.dr scdpp.dr sspak.dr vtio.dr \
		covdg.io cohr.io \
		nil.dd p_dpp.dd p1_sc6551dragon.dd pipe.dd ssp.dd \
		term_sc6551.dt t2_sc6551.dd t3_sc6551.dd \
		term32.dt term51.dt

PIPE		= pipeman.mn \
		piper.dr \
		pipe.dd

ALLOBJS		= $(BOOTTRACK) $(KERNEL) $(SYSMODS) $(CLOCKS) $(RBF) $(SCF) $(PIPE)

all:	$(ALLOBJS)

# Special cases

# Kernel
krn krnp2:
	$(CD) kernel; make $@
	$(CP) kernel/$@ .

boot_1773_6ms:	boot_1773.asm
	$(AS) $< $(ASOUT)$@ $(AFLAGS) -DDNum=0 -DSTEP=0

boot_1773_30ms:	boot_1773.asm
	$(AS) $< $(ASOUT)$@ $(AFLAGS) -DDNum=0 -DSTEP=3

rb1773_scii_ff74.dr:	rb1773.asm
	$(AS) $< $(ASOUT)$@ $(AFLAGS) -DSCII=1

rb1773_scii_ff58.dr:	rb1773.asm
	$(AS) $< $(ASOUT)$@ $(AFLAGS) -DSCII=1 -DSCIIALT=1

# Clocks
clock_60hz: clock.asm
	$(AS) $(AFLAGS) $(ASOUT)$@ $< -DPwrLnFrq=60

clock_50hz: clock.asm
	$(AS) $(AFLAGS) $(ASOUT)$@ $< -DPwrLnFrq=50

clock2_bnb: clock2_ds1315.asm
	$(AS) $(AFLAGS) $(ASOUT)$@ $< -DBNB=1

clock2_cloud9: clock2_ds1315.asm
	$(AS) $(AFLAGS) $(ASOUT)$@ $< -DCLOUD9=1

# Floppy descriptors
SSDD35		= -DCyls=35 -DSides=1 -DSectTrk=18 -DSectTrk0=18 \
		-DInterlv=3 -DSAS=8 -DDensity=1
DSDD40		= -DCyls=40 -DSides=2 -DSectTrk=18 -DSectTrk0=18 \
		-DInterlv=3 -DSAS=8 -DDensity=1
DSDD80		= -DCyls=80 -DSides=2 -DSectTrk=18 -DSectTrk0=18 \
		-DInterlv=3 -DSAS=8 -DDensity=1 -DD35

ddd0_35s.dd: rb1773desc.asm
	$(AS) $< $(ASOUT)$@ $(AFLAGS) $(SSDD35) -DDNum=0 -DDD=1

d0_35s.dd: rb1773desc.asm
	$(AS) $< $(ASOUT)$@ $(AFLAGS) $(SSDD35) -DDNum=0

d1_35s.dd: rb1773desc.asm
	$(AS) $< $(ASOUT)$@ $(AFLAGS) $(SSDD35) -DDNum=1

d2_35s.dd: rb1773desc.asm
	$(AS) $< $(ASOUT)$@ $(AFLAGS) $(SSDD35) -DDNum=2

d3_35s.dd: rb1773desc.asm
	$(AS) $< $(ASOUT)$@ $(AFLAGS) $(SSDD35) -DDNum=3

ddd0_40d.dd: rb1773desc.asm
	$(AS) $< $(ASOUT)$@ $(AFLAGS) $(DSDD40) -DDNum=0 -DDD=1

d0_40d.dd: rb1773desc.asm
	$(AS) $< $(ASOUT)$@ $(AFLAGS) $(DSDD40) -DDNum=0

d1_40d.dd: rb1773desc.asm
	$(AS) $< $(ASOUT)$@ $(AFLAGS) $(DSDD40) -DDNum=1

d2_40d.dd: rb1773desc.asm
	$(AS) $< $(ASOUT)$@ $(AFLAGS) $(DSDD40) -DDNum=2

ddd0_80d.dd: rb1773desc.asm
	$(AS) $< $(ASOUT)$@ $(AFLAGS) $(DSDD80) -DDNum=0 -DDD=1

d0_80d.dd: rb1773desc.asm
	$(AS) $< $(ASOUT)$@ $(AFLAGS) $(DSDD80) -DDNum=0

d1_80d.dd: rb1773desc.asm
	$(AS) $< $(ASOUT)$@ $(AFLAGS) $(DSDD80) -DDNum=1

d2_80d.dd: rb1773desc.asm
	$(AS) $< $(ASOUT)$@ $(AFLAGS) $(DSDD80) -DDNum=2

sysgo_dd: sysgo.asm
	$(AS) $(AFLAGS) $(ASOUT)$@ $< -DDD=1

sysgo_h0: sysgo.asm
	$(AS) $(AFLAGS) $(ASOUT)$@ $<

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


