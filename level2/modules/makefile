# Makefile for OS-9 Level Two MODULES/

include ../../Makefile.rules

CLOCKELIM       = -aRTCElim=1 -aRTCDsto2=0 -aRTCDsto4=0 -aRTCBB=0 -aRTCSmart=0 -aRTCHarrs=0 -aRTCTc3=0 -aRTCSoft=0 -aMPIFlag=0
CLOCKDISTO2     = -aRTCElim=0 -aRTCDsto2=1 -aRTCDsto4=0 -aRTCBB=0 -aRTCSmart=0 -aRTCHarrs=0 -aRTCTc3=0 -aRTCSoft=0 -aMPIFlag=0
CLOCKDISTO4     = -aRTCElim=0 -aRTCDsto2=0 -aRTCDsto4=1 -aRTCBB=0 -aRTCSmart=0 -aRTCHarrs=0 -aRTCTc3=0 -aRTCSoft=0 -aMPIFlag=0
CLOCKBNB        = -aRTCElim=0 -aRTCDsto2=0 -aRTCDsto4=0 -aRTCBB=1 -aRTCSmart=0 -aRTCHarrs=0 -aRTCTc3=0 -aRTCSoft=0 -aMPIFlag=0
CLOCKSMART      = -aRTCElim=0 -aRTCDsto2=0 -aRTCDsto4=0 -aRTCBB=0 -aRTCSmart=1 -aRTCHarrs=0 -aRTCTc3=0 -aRTCSoft=0 -aMPIFlag=1
CLOCKHARRIS     = -aRTCElim=0 -aRTCDsto2=0 -aRTCDsto4=0 -aRTCBB=0 -aRTCSmart=0 -aRTCHarrs=1 -aRTCTc3=0 -aRTCSoft=0 -aMPIFlag=0
CLOCKTC3        = -aRTCElim=0 -aRTCDsto2=0 -aRTCDsto4=0 -aRTCBB=0 -aRTCSmart=0 -aRTCHarrs=0 -aRTCTc3=1 -aRTCSoft=0 -aMPIFlag=0
CLOCKSOFT       = -aRTCElim=0 -aRTCDsto2=0 -aRTCDsto4=0 -aRTCBB=0 -aRTCSmart=0 -aRTCHarrs=0 -aRTCTc3=0 -aRTCSoft=1 -aMPIFlag=0

DEPENDS		= ./Makefile
TPB		= ../../3rdparty/booters

BOOTERS		= boot_1773
OS9P1		= os9p1
OS9P2		= os9p2
REL		= rel
SYSMODS		= ioman init cc3go os9p3_perr os9p4_regdump
CLOCKS          = clock_elim clock_disto2 clock_disto4 clock_bnb \
		clock_smart clock_harris clock_tc3 clock_soft
FMGRS		= scf.mn rbf.mn pipeman.mn pipeman_named.mn
DRIVERS		= cc3disk.dr cc3hdisk.dr cc3io.dr modpak.dr \
		vrn.dr piper.dr printer.dr sio.dr rammer.dr sspak.dr \
		sacia.dr dacia.dr
IOSUBS		= windint.io vdgint.io vdgint_small.io \
		keydrv joydrv_joy \
		joydrv_6551L joydrv_6552L joydrv_6551M joydrv_6552M snddrv
DESCS		= d0_35s.dd d1_35s.dd d2_35s.dd d3_35s.dd \
		d0_40d.dd d1_40d.dd d2_40d.dd d0_80d.dd \
		d1_80d.dd d2_80d.dd ddd0_35s.dd ddd0_40d.dd \
		ddd0_80d.dd r0_8k.dd r0_96k.dd r0_128k.dd r0_192k.dd \
		ddr0_8k.dd ddr0_96k.dd ddr0_128k.dd ddr0_192k.dd \
		m1.dd m2.dd nil.dd p.dd pipe.dd t1.dd t2_sacia.dd \
		t3_sacia.dd t2_dacia.dd t3_dacia.dd \
		h0_10.dd h1_10.dd h0_15.dd h1_15.dd h0_35.dd h1_35.dd \
		ftdd.dd vi.dd ssp.dd term_t1.dd
WINDESCS	= term_vdg.dt term_win40.dt term_win80.dt w.dw w1.dw w2.dw \
		w3.dw w4.dw w5.dw w6.dw w7.dw v1.dw v2.dw v3.dw v4.dw v5.dw \
		v6.dw v7.dw

#
# The following macros represent a collection of modules for various
# kernel tracks and bootfile configurations.
#
KERNEL_1773	= rel boot_1773 os9p1
KERNEL_RAMPAK	= rel $(TPB)/boot_rampak os9p1
KERNEL_KENTON	= rel $(TPB)/boot_kenton os9p1
KERNEL_IDE	= rel $(TPB)/boot_ide os9p1

ALLOBJS		=  $(BOOTERS) $(OS9P1) $(OS9P2) $(REL) $(SYSMODS) $(CLOCKS) $(FMGRS) \
		$(DRIVERS) $(IOSUBS) $(DESCS) $(WINDESCS)

all:	$(ALLOBJS)

# Special cases here
SSDD35		= -aCyls=35 -aSides=1 -aSectTrk=18 -aSectTrk0=18 \
		-aInterlv=3 -aSAS=8 -aDensity=1
DSDD40		= -aCyls=40 -aSides=2 -aSectTrk=18 -aSectTrk0=18 \
		-aInterlv=3 -aSAS=8 -aDensity=1
DSDD80		= -aCyls=80 -aSides=2 -aSectTrk=18 -aSectTrk0=18 \
		-aInterlv=3 -aSAS=8 -aDensity=3

# Special cases
cc3hdisk.dr: ../../level1/MODULES/cchdisk.asm
	$(AS) $< $(ASOUT)$@ $(AFLAGS)

# Floppy descriptors
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

sacia.dr: xacia.asm
	$(AS) -aA6551=1 -aA6552=0 -aMPI.Slot=00 $(AFLAGS) $< $(ASOUT)$@
	
dacia.dr: xacia.asm
	$(AS) -aA6551=0 -aA6552=1 -aMPI.Slot=00 $(AFLAGS) $< $(ASOUT)$@

# VDGInt Modules
vdgint.io: vdgint.asm
	$(AS) $(AFLAGS) $(ASOUT)$@ $< -aCOCO2=1

vdgint_small.io: vdgint.asm
	$(AS) $(AFLAGS) $(ASOUT)$@ $<

# Clocks
clock_elim: clock.asm
	$(AS) $(AFLAGS) $(ASOUT)$@ $< $(CLOCKELIM)

clock_disto2: clock.asm
	$(AS) $(AFLAGS) $(ASOUT)$@ $< $(CLOCKDISTO2)

clock_disto4: clock.asm
	$(AS) $(AFLAGS) $(ASOUT)$@ $< $(CLOCKDISTO4)

clock_bnb: clock.asm
	$(AS) $(AFLAGS) $(ASOUT)$@ $< $(CLOCKBNB)

clock_smart: clock.asm
	$(AS) $(AFLAGS) $(ASOUT)$@ $< $(CLOCKSMART)

clock_harris: clock.asm
	$(AS) $(AFLAGS) $(ASOUT)$@ $< $(CLOCKHARRIS)

clock_tc3: clock.asm
	$(AS) $(AFLAGS) $(ASOUT)$@ $< $(CLOCKTC3)

clock_soft: clock.asm
	$(AS) $(AFLAGS) $(ASOUT)$@ $< $(CLOCKSOFT)

clean:
	$(RM) $(ALLOBJS)

showobjs:
	@$(ECHO) $(ALLOBJS)

showcopyobjs:
	@$(ECHO) $(OS9P2) $(SYSMODS) $(CLOCKS) $(FMGRS) \
		$(DRIVERS) $(IOSUBS) $(DESCS) $(WINDESCS) \

identify:
	$(IDENT_SHORT) $(ALLOBJS)
