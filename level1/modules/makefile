include ../../Makefile.rules

DEPENDS		= ./Makefile
TPB		= $(3RDPARTY)/booters

BOOTERS		= oscode oscode_d64 boot_1773 boot_d64 $(TPB)/boot_rom_l1 rom_vectors
KERNELS		= os9 os9p2
ROMMODS		= rominfo sysgo_rom
SYSMODS		= ioman init sysgo sysgo_d64
CLOCKS		= clock.60hz clock.50hz clock_tc3 clock_bb
CLOCKS_D64	= clock_d64
FMGRS		= scf.mn rbf.mn pipeman.mn
DRIVERS		= aciapak.dr cchdisk.dr ccdisk.dr modpak.dr nildrv.dr \
		piper.dr printer.dr rs232.dr sscpak.dr ccio.dr
DRIVERS_D64	= ddisk.dr kbvdio.dr drvr51.dr
IOSUBS		= co32.io co80.io grfo.io
DESCS		= ddd0_35s.dd d0_35s.dd d1_35s.dd d2_35s.dd d3_35s.dd \
		ddd0_40d.dd d0_40d.dd d1_40d.dd d2_40d.dd \
		ddd0_80d.dd d0_80d.dd d1_80d.dd d2_80d.dd \
		h0_15.dd h1_15.dd h0_35.dd h1_35.dd \
		m1.dd m2.dd nil.dd p.dd pipe.dd ssc.dd \
		term_t1.dd t1.dd t2.dd t3.dd term32.dd term80.dd
DESCS_D64	= p1_d64.dd term_d64.dd t1_d64.dd \
		dd_d64.dd d0_d64.dd d1_d64.dd d2_d64.dd d3_d64.dd
HELP		= co32.hp co80.hp \
		ddd0_35s.hp d0_35s.hp d1_35s.hp d2_35s.hp d3_35s.hp \
		ddd0_40d.hp d0_40d.hp d1_40d.hp d2_40d.hp \
		ddd0_80d.hp d0_80d.hp d1_80d.hp d2_80d.hp \
		grfo.hp h0_15.hp \
		h0_35.hp h1_15.hp h1_35.hp m1.hp m2.hp nil.hp p.hp pipe.hp \
		ssc.hp t1.hp t2.hp t3.hp term32.hp term80.hp config.hp

COPYOBJS	= $(SYSMODS) $(CLOCKS) $(FMGRS) $(DRIVERS) $(IOSUBS) \
		$(DESCS) $(HELP)
ALLOBJS		= $(BOOTERS) $(KERNELS) $(ROMMODS) $(SYSMODS) $(CLOCKS) $(FMGRS) \
		$(DRIVERS) $(IOSUBS) $(DESCS)

all:	$(ALLOBJS) $(HELP)
	$(CHMOD) 755 $(ALLOBJS)
	$(CHMOD) 644 $(HELP)

# Special cases here
SSDD35		= -aCyls=35 -aSides=1 -aSectTrk=18 -aSectTrk0=18 \
		-aInterlv=3 -aSAS=8 -aDensity=1
DSDD40		= -aCyls=40 -aSides=2 -aSectTrk=18 -aSectTrk0=18 \
		-aInterlv=3 -aSAS=8 -aDensity=1
DSDD80		= -aCyls=80 -aSides=2 -aSectTrk=18 -aSectTrk0=18 \
		-aInterlv=3 -aSAS=8 -aDensity=3

# Floppy descriptors
ddd0_35s.dd: dx.asm
	$(AS) $< $(ASOUT)$@ $(AFLAGS) $(SSDD35) -aDNum=0 -aDD=1

d0_35s.dd: dx.asm
	$(AS) $< $(ASOUT)$@ $(AFLAGS) $(SSDD35) -aDNum=0

d1_35s.dd: dx.asm
	$(AS) $< $(ASOUT)$@ $(AFLAGS) $(SSDD35) -aDNum=1

d2_35s.dd: dx.asm
	$(AS) $< $(ASOUT)$@ $(AFLAGS) $(SSDD35) -aDNum=2

d3_35s.dd: dx.asm
	$(AS) $< $(ASOUT)$@ $(AFLAGS) $(SSDD35) -aDNum=3

ddd0_40d.dd: dx.asm
	$(AS) $< $(ASOUT)$@ $(AFLAGS) $(DSDD40) -aDNum=0 -aDD=1

d0_40d.dd: dx.asm
	$(AS) $< $(ASOUT)$@ $(AFLAGS) $(DSDD40) -aDNum=0

d1_40d.dd: dx.asm
	$(AS) $< $(ASOUT)$@ $(AFLAGS) $(DSDD40) -aDNum=1

d2_40d.dd: dx.asm
	$(AS) $< $(ASOUT)$@ $(AFLAGS) $(DSDD40) -aDNum=2

ddd0_80d.dd: dx.asm
	$(AS) $< $(ASOUT)$@ $(AFLAGS) $(DSDD80) -aDNum=0 -aDD=1

d0_80d.dd: dx.asm
	$(AS) $< $(ASOUT)$@ $(AFLAGS) $(DSDD80) -aDNum=0

d1_80d.dd: dx.asm
	$(AS) $< $(ASOUT)$@ $(AFLAGS) $(DSDD80) -aDNum=1

d2_80d.dd: dx.asm
	$(AS) $< $(ASOUT)$@ $(AFLAGS) $(DSDD80) -aDNum=2

oscode: oscode.asm
	$(AS) $(AFLAGS) $(ASOUT)$@ $< -aDragon64=0

oscode_d64: oscode.asm
	$(AS) $(AFLAGS) $(ASOUT)$@ $< -aDragon64=1

sysgo: sysgo.asm
	$(AS) $(AFLAGS) $(ASOUT)$@ $< -aDiskGo=1

sysgo_rom: sysgo.asm
	$(AS) $(AFLAGS) $(ASOUT)$@ $< -aDiskGo=0

clock_tc3: clock.asm
	$(AS) $(AFLAGS) $(ASOUT)$@ $< -aRTCTC3=1 -aTPS=60

clock_bb: clock.asm
	$(AS) $(AFLAGS) $(ASOUT)$@ $< -aRTCBB=1 -aTPS=60

clean:
	$(RM) $(ALLOBJS)

identify:
	$(IDENT_SHORT) $(ALLOBJS)

showallobjs:
	@$(ECHO) $(ALLOBJS)

showcopyobjs:
	@$(ECHO) $(COPYOBJS)
