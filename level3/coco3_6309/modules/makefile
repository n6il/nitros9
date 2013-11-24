PORT = coco3
ifndef  NITROS9DIR
NITROS9DIR      = $(HOME)/nitros9
endif
include $(NITROS9DIR)/rules.mak

vpath %.asm kernel:$(LEVEL2)/modules/kernel:$(LEVEL3)/modules:$(LEVEL2)/modules:$(LEVEL1)/modules

AFLAGS		+= -e -aH6309=1 -I$(LEVEL1)/modules

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
TPB		= ../../3rdparty/booters

BOOTERS		= boot_1773_6ms boot_1773_30ms \
		 boot_burke boot_rampak boot_wd1002 boot_dw
BOOTTRACK	= rel_32 rel_40 rel_80 rel_32_50hz rel_40_50hz rel_80_50hz $(BOOTERS) krn
KERNEL		= krnp2 krnp3_perr krnp4_regdump
SYSMODS		= ioman init sysgo_h0 sysgo_dd nitro end
CLOCKS          = clock_60hz clock_50hz \
		clock2_elim clock2_disto2 clock2_disto4 clock2_bnb \
		clock2_smart clock2_harris clock2_cloud9 clock2_soft \
		clock2_jvemu clock2_messemu clock2_dw

RBF		= rbf.mn \
		rbdw.dr dwio.sb \
		rb1773.dr rb1773_scii_ff74.dr rb1773_scii_ff58.dr \
		d0_35s.dd d1_35s.dd d2_35s.dd d3_35s.dd \
		d0_40d.dd d1_40d.dd d2_40d.dd d0_80d.dd \
		d1_80d.dd d2_80d.dd \
		ddd0_35s.dd ddd0_40d.dd ddd0_80d.dd \
		rammer.dr r0_8k.dd r0_96k.dd r0_128k.dd r0_192k.dd \
		ddr0_8k.dd ddr0_96k.dd ddr0_128k.dd ddr0_192k.dd md.dd \
		ddx0.dd x0.dd x1.dd x2.dd x3.dd
		

SCF		= scf.mn \
		vtio.dr vrn.dr scbbp.dr scbbt.dr scdwp.dr sspak.dr sc6551.dr \
		cowin.io cogrf.io covdg.io covdg_small.io \
		keydrv_cc3.sb snddrv_cc3.sb \
		joydrv_joy.sb joydrv_6551L.sb joydrv_6552L.sb \
		joydrv_6551M.sb joydrv_6552M.sb \
		nil.dd p_scbbp.dd p_scdwp.dd \
		t1_scbbt.dd t2_sc6551.dd t3_sc6551.dd \
		ftdd.dd vi.dd ssp.dd term_scbbt.dt term_sc6551.dt \
		term_vdg.dt term_win40.dt term_win80.dt w.dw w1.dw w2.dw \
		w3.dw w4.dw w5.dw w6.dw w7.dw \
		w8.dw w9.dw w10.dw w11.dw w12.dw w13.dw w14.dw w15.dw \
		v1.dw v2.dw v3.dw v4.dw v5.dw \
		v6.dw v7.dw \
		scdwn.dr term_scdwn.dt n0_scdwn.dd n1_scdwn.dd n2_scdwn.dd n3_scdwn.dd \
                n4_scdwn.dd n5_scdwn.dd n6_scdwn.dd n7_scdwn.dd \
		n8_scdwn.dd n9_scdwn.dd n10_scdwn.dd n11_scdwn.dd \
                n12_scdwn.dd n13_scdwn.dd n14_scdwn.dd

PIPE		= pipeman.mn pipeman_named.mn \
		piper.dr \
		pipe.dd

#
# The following macros represent a collection of modules for various
# kernel tracks and bootfile configurations.
#
KERNEL_1773	= rel_32 boot_1773 krn
KERNEL_RAMPAK	= rel_32 $(TPB)/boot_rampak krn
KERNEL_KENTON	= rel_32 $(TPB)/boot_kenton krn
KERNEL_IDE	= rel_32 $(TPB)/boot_ide krn

ALLOBJS		=  $(BOOTTRACK) $(KERNEL) $(SYSMODS) $(CLOCKS) $(RBF) $(SCF) $(PIPE)

all:	$(ALLOBJS)

# Kernel
krn krnp2:
	$(CD) kernel; make $@
	$(OS9COPY) kernel/$@ .

# Special cases
cogrf.io: cowin.asm
	$(AS) $< $(ASOUT)$@ $(AFLAGS) -aCoGrf=1

rb1773_scii_ff74.dr:    rb1773.asm
	$(AS) $< $(ASOUT)$@ $(AFLAGS) -aSCII=1
                                                                            
rb1773_scii_ff58.dr:    rb1773.asm
	$(AS) $< $(ASOUT)$@ $(AFLAGS) -aSCII=1 -aSCIIALT=1
                                                                            
rel_32: rel.asm
	$(AS) $< $(ASOUT)$@ $(AFLAGS) -aWidth=32

rel_40: rel.asm
	$(AS) $< $(ASOUT)$@ $(AFLAGS) -aWidth=40

rel_80: rel.asm
	$(AS) $< $(ASOUT)$@ $(AFLAGS) -aWidth=80

rel_32_50hz: rel.asm
	$(AS) $< $(ASOUT)$@ $(AFLAGS) -aWidth=32 -aTkPerSec=50

rel_40_50hz: rel.asm
	$(AS) $< $(ASOUT)$@ $(AFLAGS) -aWidth=40 -aTkPerSec=50

rel_80_50hz: rel.asm
	$(AS) $< $(ASOUT)$@ $(AFLAGS) -aWidth=80 -aTkPerSec=50

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
		-aInterlv=3 -aSAS=8 -aDensity=1 -aD35

ddd0_35s.dd: rb1773desc.asm
	$(AS) $< $(ASOUT)$@ $(AFLAGS) $(SSDD35) -aDNum=0 -aDD=1

d0_35s.dd: rb1773desc.asm
	$(AS) $< $(ASOUT)$@ $(AFLAGS) $(SSDD35) -aDNum=0

d1_35s.dd: rb1773desc.asm
	$(AS) $< $(ASOUT)$@ $(AFLAGS) $(SSDD35) -aDNum=1

d2_35s.dd: rb1773desc.asm
	$(AS) $< $(ASOUT)$@ $(AFLAGS) $(SSDD35) -aDNum=2

d3_35s.dd: rb1773desc.asm
	$(AS) $< $(ASOUT)$@ $(AFLAGS) $(SSDD35) -aDNum=3

ddd0_40d.dd: rb1773desc.asm
	$(AS) $< $(ASOUT)$@ $(AFLAGS) $(DSDD40) -aDNum=0 -aDD=1

d0_40d.dd: rb1773desc.asm
	$(AS) $< $(ASOUT)$@ $(AFLAGS) $(DSDD40) -aDNum=0

d1_40d.dd: rb1773desc.asm
	$(AS) $< $(ASOUT)$@ $(AFLAGS) $(DSDD40) -aDNum=1

d2_40d.dd: rb1773desc.asm
	$(AS) $< $(ASOUT)$@ $(AFLAGS) $(DSDD40) -aDNum=2

ddd0_80d.dd: rb1773desc.asm
	$(AS) $< $(ASOUT)$@ $(AFLAGS) $(DSDD80) -aDNum=0 -aDD=1

d0_80d.dd: rb1773desc.asm
	$(AS) $< $(ASOUT)$@ $(AFLAGS) $(DSDD80) -aDNum=0

d1_80d.dd: rb1773desc.asm
	$(AS) $< $(ASOUT)$@ $(AFLAGS) $(DSDD80) -aDNum=1

d2_80d.dd: rb1773desc.asm
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

# DriveWire 3 SCF descriptors
term_scdwn.dt: scdwndesc.asm
	$(AS) $< $(ASOUT)$@ $(AFLAGS) -aTERM=1 -aAddr=0

n0_scdwn.dd: scdwndesc.asm
	$(AS) $< $(ASOUT)$@ $(AFLAGS) -aAddr=0

n1_scdwn.dd: scdwndesc.asm
	$(AS) $< $(ASOUT)$@ $(AFLAGS) -aAddr=1

n2_scdwn.dd: scdwndesc.asm
	$(AS) $< $(ASOUT)$@ $(AFLAGS) -aAddr=2

n3_scdwn.dd: scdwndesc.asm
	$(AS) $< $(ASOUT)$@ $(AFLAGS) -aAddr=3

n4_scdwn.dd: scdwndesc.asm
	$(AS) $< $(ASOUT)$@ $(AFLAGS) -aAddr=4

n5_scdwn.dd: scdwndesc.asm
	$(AS) $< $(ASOUT)$@ $(AFLAGS) -aAddr=5

n6_scdwn.dd: scdwndesc.asm
	$(AS) $< $(ASOUT)$@ $(AFLAGS) -aAddr=6

n7_scdwn.dd: scdwndesc.asm
	$(AS) $< $(ASOUT)$@ $(AFLAGS) -aAddr=7

n8_scdwn.dd: scdwndesc.asm
	$(AS) $< $(ASOUT)$@ $(AFLAGS) -aAddr=8

n9_scdwn.dd: scdwndesc.asm
	$(AS) $< $(ASOUT)$@ $(AFLAGS) -aAddr=9

n10_scdwn.dd: scdwndesc.asm
	$(AS) $< $(ASOUT)$@ $(AFLAGS) -aAddr=10

n11_scdwn.dd: scdwndesc.asm
	$(AS) $< $(ASOUT)$@ $(AFLAGS) -aAddr=11

n12_scdwn.dd: scdwndesc.asm
	$(AS) $< $(ASOUT)$@ $(AFLAGS) -aAddr=12

n13_scdwn.dd: scdwndesc.asm
	$(AS) $< $(ASOUT)$@ $(AFLAGS) -aAddr=13

n14_scdwn.dd: scdwndesc.asm
	$(AS) $< $(ASOUT)$@ $(AFLAGS) -aAddr=14

# DriveWire 3 RBF descriptors
ddx0.dd: dwdesc.asm
	$(AS) $< $(ASOUT)$@ $(AFLAGS) -aDD=1 -aDNum=0

x0.dd: dwdesc.asm
	$(AS) $< $(ASOUT)$@ $(AFLAGS) -aDNum=0

x1.dd: dwdesc.asm
	$(AS) $< $(ASOUT)$@ $(AFLAGS) -aDNum=1

x2.dd: dwdesc.asm
	$(AS) $< $(ASOUT)$@ $(AFLAGS) -aDNum=2

x3.dd: dwdesc.asm
	$(AS) $< $(ASOUT)$@ $(AFLAGS) -aDNum=3

# VDGInt Modules
covdg.io: covdg.asm
	$(AS) $(AFLAGS) $(ASOUT)$@ $< -aCOCO2=1

covdg_small.io: covdg.asm
	$(AS) $(AFLAGS) $(ASOUT)$@ $<

# Clocks
clock_60hz: clock.asm
	$(AS) $(AFLAGS) $(ASOUT)$@ $< -aPwrLnFrq=60

clock_50hz: clock.asm
	$(AS) $(AFLAGS) $(ASOUT)$@ $< -aPwrLnFrq=50

clock2_cloud9: clock2_ds1315.asm
	$(AS) $(AFLAGS) $(ASOUT)$@ $< -aCLOUD9=1

clock2_bnb: clock2_ds1315.asm
	$(AS) $(AFLAGS) $(ASOUT)$@ $< -aBNB=1

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
