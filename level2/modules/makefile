include ../../rules.mak

vpath %.asm krnl:$(6809L1)/modules

CLOCKELIM       = -aRTCElim=1 -aRTCDsto2=0 -aRTCDsto4=0 -aRTCBB=0 -aRTCSmart=0 -aRTCHarrs=0 -aRTCTc3=0 -aRTCSoft=0 -aMPIFlag=0
CLOCKDISTO2     = -aRTCElim=0 -aRTCDsto2=1 -aRTCDsto4=0 -aRTCBB=0 -aRTCSmart=0 -aRTCHarrs=0 -aRTCTc3=0 -aRTCSoft=0 -aMPIFlag=0
CLOCKDISTO4     = -aRTCElim=0 -aRTCDsto2=0 -aRTCDsto4=1 -aRTCBB=0 -aRTCSmart=0 -aRTCHarrs=0 -aRTCTc3=0 -aRTCSoft=0 -aMPIFlag=0
CLOCKBNB        = -aRTCElim=0 -aRTCDsto2=0 -aRTCDsto4=0 -aRTCBB=1 -aRTCSmart=0 -aRTCHarrs=0 -aRTCTc3=0 -aRTCSoft=0 -aMPIFlag=0
CLOCKSMART      = -aRTCElim=0 -aRTCDsto2=0 -aRTCDsto4=0 -aRTCBB=0 -aRTCSmart=1 -aRTCHarrs=0 -aRTCTc3=0 -aRTCSoft=0 -aMPIFlag=1
CLOCKHARRIS     = -aRTCElim=0 -aRTCDsto2=0 -aRTCDsto4=0 -aRTCBB=0 -aRTCSmart=0 -aRTCHarrs=1 -aRTCTc3=0 -aRTCSoft=0 -aMPIFlag=0
CLOCKTC3        = -aRTCElim=0 -aRTCDsto2=0 -aRTCDsto4=0 -aRTCBB=0 -aRTCSmart=0 -aRTCHarrs=0 -aRTCTc3=1 -aRTCSoft=0 -aMPIFlag=0
CLOCKSOFT       = -aRTCElim=0 -aRTCDsto2=0 -aRTCDsto4=0 -aRTCBB=0 -aRTCSmart=0 -aRTCHarrs=0 -aRTCTc3=0 -aRTCSoft=1 -aMPIFlag=0

DEPENDS		= ./makefile
TPB		= ../../3rdparty/booters

BOOTERS		= boot_1773_6ms boot_1773_30ms \
		 boot_burke boot_idelba boot_rampak boot_wd1002
BOOTTRACK	= rel_32 rel_40 rel_80 $(BOOTERS) kernel
KERNEL		= kernelp2 kernelp3_perr kernelp4_regdump
SYSMODS		= ioman init sysgo_h0 sysgo_dd
CLOCKS          = clock_60hz clock_50hz \
		clock2_elim clock2_disto2 clock2_disto4 clock2_bnb \
		clock2_smart clock2_harris clock2_tc3 clock2_soft

RBF		= rbf.mn \
		cc3disk.dr rammer.dr \
		d0_35s.dd d1_35s.dd d2_35s.dd d3_35s.dd \
		d0_40d.dd d1_40d.dd d2_40d.dd d0_80d.dd \
		d1_80d.dd d2_80d.dd ddd0_35s.dd ddd0_40d.dd \
		ddd0_80d.dd r0_8k.dd r0_96k.dd r0_128k.dd r0_192k.dd \
		ddr0_8k.dd ddr0_96k.dd ddr0_128k.dd ddr0_192k.dd md.dd
		

SCF		= scf.mn \
		cc3io.dr modpak.dr vrn.dr printer.dr sio.dr sspak.dr sacia.dr dacia.dr \
		windint.io vdgint.io vdgint_small.io \
		keydrv_cc3.sb snddrv_cc3.sb \
		joydrv_joy.sb joydrv_6551L.sb joydrv_6552L.sb \
		joydrv_6551M.sb joydrv_6552M.sb \
		nil.dd p.dd \
		t1.dd t2_sacia.dd t3_sacia.dd t2_dacia.dd t3_dacia.dd \
		ftdd.dd vi.dd ssp.dd term_t1.dd \
		term_vdg.dt term_win40.dt term_win80.dt w.dw w1.dw w2.dw \
		w3.dw w4.dw w5.dw w6.dw w7.dw v1.dw v2.dw v3.dw v4.dw v5.dw \
		v6.dw v7.dw

PIPE		= pipeman.mn pipeman_named.mn \
		piper.dr \
		pipe.dd

#
# The following macros represent a collection of modules for various
# kernel tracks and bootfile configurations.
#
KERNEL_1773	= rel_32 boot_1773 kernel
KERNEL_RAMPAK	= rel_32 $(TPB)/boot_rampak kernel
KERNEL_KENTON	= rel_32 $(TPB)/boot_kenton kernel
KERNEL_IDE	= rel_32 $(TPB)/boot_ide kernel

ALLOBJS		=  $(BOOTTRACK) $(KERNEL) $(SYSMODS) $(CLOCKS) $(RBF) $(SCF) $(PIPE)

all:	$(ALLOBJS)

# Kernel
kernel kernelp2:
	$(CD) krnl; make $@
	$(CP) krnl/$@ .

# Special cases
rel_32: rel.asm
	$(AS) $< $(ASOUT)$@ $(AFLAGS) -aWidth=32

rel_40: rel.asm
	$(AS) $< $(ASOUT)$@ $(AFLAGS) -aWidth=40

rel_80: rel.asm
	$(AS) $< $(ASOUT)$@ $(AFLAGS) -aWidth=80

boot_1773_6ms: boot_1773.asm
	$(AS) $< $(ASOUT)$@ $(AFLAGS) -aSTEP=0

boot_1773_30ms: boot_1773.asm
	$(AS) $< $(ASOUT)$@ $(AFLAGS) -aSTEP=3

sysgo_dd: sysgo.asm
	$(AS) $< $(ASOUT)$@ $(AFLAGS) -aDD=1
	
sysgo_h0: sysgo.asm
	$(AS) $< $(ASOUT)$@ $(AFLAGS)
	
# Floppy descriptors
SSDD35		= -aCyls=35 -aSides=1 -aSectTrk=18 -aSectTrk0=18 \
		-aInterlv=3 -aSAS=8 -aDensity=1
DSDD40		= -aCyls=40 -aSides=2 -aSectTrk=18 -aSectTrk0=18 \
		-aInterlv=3 -aSAS=8 -aDensity=1
DSDD80		= -aCyls=80 -aSides=2 -aSectTrk=18 -aSectTrk0=18 \
		-aInterlv=3 -aSAS=8 -aDensity=3

ddd0_35s.dd: cc3diskdesc.asm
	$(AS) $< $(ASOUT)$@ $(AFLAGS) $(SSDD35) -aDNum=0 -aDD=1

d0_35s.dd: cc3diskdesc.asm
	$(AS) $< $(ASOUT)$@ $(AFLAGS) $(SSDD35) -aDNum=0

d1_35s.dd: cc3diskdesc.asm
	$(AS) $< $(ASOUT)$@ $(AFLAGS) $(SSDD35) -aDNum=1

d2_35s.dd: cc3diskdesc.asm
	$(AS) $< $(ASOUT)$@ $(AFLAGS) $(SSDD35) -aDNum=2

d3_35s.dd: cc3diskdesc.asm
	$(AS) $< $(ASOUT)$@ $(AFLAGS) $(SSDD35) -aDNum=3

ddd0_40d.dd: cc3diskdesc.asm
	$(AS) $< $(ASOUT)$@ $(AFLAGS) $(DSDD40) -aDNum=0 -aDD=1

d0_40d.dd: cc3diskdesc.asm
	$(AS) $< $(ASOUT)$@ $(AFLAGS) $(DSDD40) -aDNum=0

d1_40d.dd: cc3diskdesc.asm
	$(AS) $< $(ASOUT)$@ $(AFLAGS) $(DSDD40) -aDNum=1

d2_40d.dd: cc3diskdesc.asm
	$(AS) $< $(ASOUT)$@ $(AFLAGS) $(DSDD40) -aDNum=2

ddd0_80d.dd: cc3diskdesc.asm
	$(AS) $< $(ASOUT)$@ $(AFLAGS) $(DSDD80) -aDNum=0 -aDD=1

d0_80d.dd: cc3diskdesc.asm
	$(AS) $< $(ASOUT)$@ $(AFLAGS) $(DSDD80) -aDNum=0

d1_80d.dd: cc3diskdesc.asm
	$(AS) $< $(ASOUT)$@ $(AFLAGS) $(DSDD80) -aDNum=1

d2_80d.dd: cc3diskdesc.asm
	$(AS) $< $(ASOUT)$@ $(AFLAGS) $(DSDD80) -aDNum=2

# RAM Disk descriptors
r0_8k.dd: r0.asm
	$(AS) $< $(ASOUT)$@ $(AFLAGS) -aRAMSize=8

ddr0_8k.dd: r0.asm
	$(AS) $< $(ASOUT)$@ $(AFLAGS) -aRAMSize=8 -aDD=1

r0_96k.dd: r0.asm
	$(AS) $< $(ASOUT)$@ $(AFLAGS) -aRAMSize=96

ddr0_96k.dd: r0.asm
	$(AS) $< $(ASOUT)$@ $(AFLAGS) -aRAMSize=96 -aDD=1

r0_128k.dd: r0.asm
	$(AS) $< $(ASOUT)$@ $(AFLAGS) -aRAMSize=128

ddr0_128k.dd: r0.asm
	$(AS) $< $(ASOUT)$@ $(AFLAGS) -aRAMSize=128 -aDD=1

r0_192k.dd: r0.asm
	$(AS) $< $(ASOUT)$@ $(AFLAGS) -aRAMSize=192

ddr0_192k.dd: r0.asm
	$(AS) $< $(ASOUT)$@ $(AFLAGS) -aRAMSize=192 -aDD=1

sacia.dr: sacia.asm
	$(AS) -aA6551=1 -aA6552=0 -aMPI.Slot=03 $(AFLAGS) $< $(ASOUT)$@
	
dacia.dr: sacia.asm
	$(AS) -aA6551=0 -aA6552=1 -aMPI.Slot=03 $(AFLAGS) $< $(ASOUT)$@

# VDGInt Modules
vdgint.io: vdgint.asm
	$(AS) $(AFLAGS) $(ASOUT)$@ $< -aCOCO2=1

vdgint_small.io: vdgint.asm
	$(AS) $(AFLAGS) $(ASOUT)$@ $<

# Clocks
clock_60hz: clock.asm
	$(AS) $(AFLAGS) $(ASOUT)$@ $< -aPwrLnFrq=60

clock_50hz: clock.asm
	$(AS) $(AFLAGS) $(ASOUT)$@ $< -aPwrLnFrq=50

clock2_elim: clock2.asm
	$(AS) $(AFLAGS) $(ASOUT)$@ $< $(CLOCKELIM)

clock2_disto2: clock2.asm
	$(AS) $(AFLAGS) $(ASOUT)$@ $< $(CLOCKDISTO2)

clock2_disto4: clock2.asm
	$(AS) $(AFLAGS) $(ASOUT)$@ $< $(CLOCKDISTO4)

clock2_bnb: clock2.asm
	$(AS) $(AFLAGS) $(ASOUT)$@ $< $(CLOCKBNB)

clock2_smart: clock2.asm
	$(AS) $(AFLAGS) $(ASOUT)$@ $< $(CLOCKSMART)

clock2_harris: clock2.asm
	$(AS) $(AFLAGS) $(ASOUT)$@ $< $(CLOCKHARRIS)

clock2_tc3: clock2.asm
	$(AS) $(AFLAGS) $(ASOUT)$@ $< $(CLOCKTC3)

clock2_soft: clock2.asm
	$(AS) $(AFLAGS) $(ASOUT)$@ $< $(CLOCKSOFT)

clean:
	$(CD) krnl; make $@
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
