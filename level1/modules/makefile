# Makefile for OS-9 Level One MODULES/

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
TPB		= $(3RDPARTY)/booters

BOOTERS		= boot_1773_6ms boot_1773_30ms \
		boot_burke boot_idelba boot_rampak boot_wd1002
BOOTTRACK	= rel $(BOOTERS)
KERNEL		= os9 os9p2
SYSMODS		= ioman init sysgo_dd sysgo_h0
CLOCKS          = clock_60hz clock_50hz \
		clock2_elim clock2_disto2 clock2_disto4 clock2_bnb \
                clock2_smart clock2_harris clock2_tc3 clock2_soft

RBF		= rbf.mn \
		ccdisk.dr cchdisk.dr \
		ddd0_35s.dd d0_35s.dd d1_35s.dd d2_35s.dd d3_35s.dd \
		ddd0_40d.dd d0_40d.dd d1_40d.dd d2_40d.dd \
		ddd0_80d.dd d0_80d.dd d1_80d.dd d2_80d.dd \
		h0_15.dd h1_15.dd h0_35.dd h1_35.dd

SCF		= scf.mn \
		aciapak.dr modpak.dr nildrv.dr printer.dr rs232.dr sspak.dr ccio.dr \
		co32.io co80.io grfo.io \
		m1.dd m2.dd nil.dd p.dd pipe.dd ssp.dd \
		term_t1.dd t1.dd t2.dd t3.dd term32.dd term80.dd

PIPE		= pipeman.mn \
		piper.dr \
		pipe.dd

ALLOBJS		= $(BOOTTRACK) $(KERNEL) $(SYSMODS) $(CLOCKS) $(RBF) $(SCF) $(PIPE)

all:	$(ALLOBJS)

# Special cases

boot_1773_6ms:	boot_1773.asm
	$(AS) $< $(ASOUT)$@ $(AFLAGS) -aDNum=0 -aSTEP=0

boot_1773_30ms:	boot_1773.asm
	$(AS) $< $(ASOUT)$@ $(AFLAGS) -aDNum=0 -aSTEP=3

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


# Floppy descriptors
SSDD35		= -aCyls=35 -aSides=1 -aSectTrk=18 -aSectTrk0=18 \
		-aInterlv=3 -aSAS=8 -aDensity=1
DSDD40		= -aCyls=40 -aSides=2 -aSectTrk=18 -aSectTrk0=18 \
		-aInterlv=3 -aSAS=8 -aDensity=1
DSDD80		= -aCyls=80 -aSides=2 -aSectTrk=18 -aSectTrk0=18 \
		-aInterlv=3 -aSAS=8 -aDensity=3

ddd0_35s.dd: ccdiskdesc.asm
	$(AS) $< $(ASOUT)$@ $(AFLAGS) $(SSDD35) -aDNum=0 -aDD=1

d0_35s.dd: ccdiskdesc.asm
	$(AS) $< $(ASOUT)$@ $(AFLAGS) $(SSDD35) -aDNum=0

d1_35s.dd: ccdiskdesc.asm
	$(AS) $< $(ASOUT)$@ $(AFLAGS) $(SSDD35) -aDNum=1

d2_35s.dd: ccdiskdesc.asm
	$(AS) $< $(ASOUT)$@ $(AFLAGS) $(SSDD35) -aDNum=2

d3_35s.dd: ccdiskdesc.asm
	$(AS) $< $(ASOUT)$@ $(AFLAGS) $(SSDD35) -aDNum=3

ddd0_40d.dd: ccdiskdesc.asm
	$(AS) $< $(ASOUT)$@ $(AFLAGS) $(DSDD40) -aDNum=0 -aDD=1

d0_40d.dd: ccdiskdesc.asm
	$(AS) $< $(ASOUT)$@ $(AFLAGS) $(DSDD40) -aDNum=0

d1_40d.dd: ccdiskdesc.asm
	$(AS) $< $(ASOUT)$@ $(AFLAGS) $(DSDD40) -aDNum=1

d2_40d.dd: ccdiskdesc.asm
	$(AS) $< $(ASOUT)$@ $(AFLAGS) $(DSDD40) -aDNum=2

ddd0_80d.dd: ccdiskdesc.asm
	$(AS) $< $(ASOUT)$@ $(AFLAGS) $(DSDD80) -aDNum=0 -aDD=1

d0_80d.dd: ccdiskdesc.asm
	$(AS) $< $(ASOUT)$@ $(AFLAGS) $(DSDD80) -aDNum=0

d1_80d.dd: ccdiskdesc.asm
	$(AS) $< $(ASOUT)$@ $(AFLAGS) $(DSDD80) -aDNum=1

d2_80d.dd: ccdiskdesc.asm
	$(AS) $< $(ASOUT)$@ $(AFLAGS) $(DSDD80) -aDNum=2

rel: rel.asm
	$(AS) $(AFLAGS) $(ASOUT)$@ $< -aDragon64=0

sysgo_dd: sysgo.asm
	$(AS) $(AFLAGS) $(ASOUT)$@ $< -aDD=1

sysgo_h0: sysgo.asm
	$(AS) $(AFLAGS) $(ASOUT)$@ $<

# Clocks
clock_elim: clock.asm
	$(AS) $(AFLAGS) $(ASOUT)$@ $< -aRTCElim=1 -aTPS=60

clock_disto2: clock.asm
	$(AS) $(AFLAGS) $(ASOUT)$@ $< -aRTCDsto2=1 -aTPS=60

clock_disto4: clock.asm
	$(AS) $(AFLAGS) $(ASOUT)$@ $< -aRTCDsto4=1 -aTPS=60

clock_bnb: clock.asm
	$(AS) $(AFLAGS) $(ASOUT)$@ $< -aRTCBB=1 -aTPS=60

clock_smart: clock.asm
	$(AS) $(AFLAGS) $(ASOUT)$@ $< -aRTCSmart=1 -aTPS=60

clock_harris: clock.asm
	$(AS) $(AFLAGS) $(ASOUT)$@ $< -aRTCHarrs=1 -aTPS=60

clock_tc3: clock.asm
	$(AS) $(AFLAGS) $(ASOUT)$@ $< -aRTCTC3=1 -aTPS=60

clock_soft: clock.asm
	$(AS) $(AFLAGS) $(ASOUT)$@ $< -aTPS=60

clock_soft_50hz: clock.asm
	$(AS) $(AFLAGS) $(ASOUT)$@ $< -aTPS=50

clean:
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


