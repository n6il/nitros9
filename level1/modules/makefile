# Makefile for OS-9 Level One MODULES/

include ../../Makefile.rules

DEPENDS		= ./Makefile
TPB		= $(3RDPARTY)/booters

BOOTERS		= boot_1773 boot_burke boot_idelba boot_rampak boot_wd1002
BOOTTRACK	= oscode $(BOOTERS) os9 os9p2
KERNEL		=
SYSMODS		= ioman init sysgo
CLOCKS		= clock.60hz clock.50hz clock_tc3 clock_bb

RBF		= rbf.mn \
		ccdisk.dr cchdisk.dr \
		ddd0_35s.dd d0_35s.dd d1_35s.dd d2_35s.dd d3_35s.dd \
		ddd0_40d.dd d0_40d.dd d1_40d.dd d2_40d.dd \
		ddd0_80d.dd d0_80d.dd d1_80d.dd d2_80d.dd \
		h0_15.dd h1_15.dd h0_35.dd h1_35.dd

SCF		= scf.mn \
		aciapak.dr modpak.dr nildrv.dr printer.dr rs232.dr sscpak.dr ccio.dr \
		co32.io co80.io grfo.io \
		m1.dd m2.dd nil.dd p.dd pipe.dd ssc.dd \
		term_t1.dd t1.dd t2.dd t3.dd term32.dd term80.dd

PIPE		= pipeman.mn \
		piper.dr \
		pipe.dd

HELP		= co32.hp co80.hp \
		ddd0_35s.hp d0_35s.hp d1_35s.hp d2_35s.hp d3_35s.hp \
		ddd0_40d.hp d0_40d.hp d1_40d.hp d2_40d.hp \
		ddd0_80d.hp d0_80d.hp d1_80d.hp d2_80d.hp \
		grfo.hp h0_15.hp \
		h0_35.hp h1_15.hp h1_35.hp m1.hp m2.hp nil.hp p.hp pipe.hp \
		ssc.hp t1.hp t2.hp t3.hp term32.hp term80.hp config.hp

ALLOBJS		= $(BOOTTRACK) $(KERNEL) $(SYSMODS) $(CLOCKS) $(RBF) $(SCF) $(PIPE)

all:	$(ALLOBJS) $(HELP)

# Special cases

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

oscode: oscode.asm
	$(AS) $(AFLAGS) $(ASOUT)$@ $< -aDragon64=0

sysgo: sysgo.asm
	$(AS) $(AFLAGS) $(ASOUT)$@ $< -aDiskGo=1

# Clocks
clock_tc3: clock.asm
	$(AS) $(AFLAGS) $(ASOUT)$@ $< -aRTCTC3=1 -aTPS=60

clock_bb: clock.asm
	$(AS) $(AFLAGS) $(ASOUT)$@ $< -aRTCBB=1 -aTPS=60

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


