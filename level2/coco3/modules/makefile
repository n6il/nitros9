PORT = coco3
ifndef  NITROS9DIR
NITROS9DIR      = $(HOME)/nitros9
endif
include $(NITROS9DIR)/rules.mak

vpath %.asm kernel:$(LEVEL2)/modules:$(LEVEL1)/modules

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
TC3FLAGS        = $(AFLAGS) -aTC3=1 $(FLAGS)
IDEFLAGS        = $(AFLAGS) -aIDE=1 $(FLAGS)

DEPENDS		= ./makefile
TPB		= $(3RDPARTY)/booters

BOOTERS		= boot_1773_6ms boot_1773_30ms \
		 boot_burke boot_rampak boot_wd1002 boot_dw boot_dw_becker \
		boot_tc3 boot_ide boot_rom
BOOTTRACK	= rel_32 rel_40 rel_80 rel_32_50hz rel_40_50hz rel_80_50hz $(BOOTERS) krn
KERNEL		= krnp2 krnp3_perr krnp4_regdump
SYSMODS		= ioman init sysgo_h0 sysgo_dd sysgo_rom rominfo vectors
CLOCKS          = clock_60hz clock_50hz \
		clock2_elim clock2_disto2 clock2_disto4 clock2_bnb \
		clock2_smart clock2_harris clock2_cloud9 clock2_soft \
		clock2_jvemu clock2_messemu clock2_dw

RBF		= rbf.mn \
		rbdw.dr dwio.sb dwio_becker.sb \
		rb1773.dr rb1773_scii_ff74.dr rb1773_scii_ff58.dr \
		d0_35s.dd d1_35s.dd d2_35s.dd d3_35s.dd \
		d0_40d.dd d1_40d.dd d2_40d.dd d0_80d.dd \
		d1_80d.dd d2_80d.dd \
		ddd0_35s.dd ddd0_40d.dd ddd0_80d.dd \
		rammer.dr r0_8k.dd r0_96k.dd r0_128k.dd r0_192k.dd \
		ddr0_8k.dd ddr0_96k.dd ddr0_128k.dd ddr0_192k.dd md.dd \
		ddx0.dd x0.dd x1.dd x2.dd x3.dd \
		rbsuper.dr lltc3.dr llide.dr \
		ddi0_ide.dd i0_ide.dd i1_ide.dd ih_ide.dd \
		dds0_tc3.dd s0_tc3.dd s1_tc3.dd s2_tc3.dd s3_tc3.dd s4_tc3.dd \
		s5_tc3.dd s6_tc3.dd sh_tc3.dd

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
		scdwn.dr term_scdwn.dt n_scdwn.dd \
		n1_scdwn.dd n2_scdwn.dd n3_scdwn.dd \
                n4_scdwn.dd n5_scdwn.dd n6_scdwn.dd n7_scdwn.dd \
		n8_scdwn.dd n9_scdwn.dd n10_scdwn.dd n11_scdwn.dd \
                n12_scdwn.dd n13_scdwn.dd midi_scdwn.dd \
		term_z_scdwn.dd \
		z1_scdwn.dd z2_scdwn.dd z3_scdwn.dd z4_scdwn.dd z5_scdwn.dd \
		z6_scdwn.dd z7_scdwn.dd

PIPE		= pipeman.mn pipeman_named.mn \
		piper.dr \
		pipe.dd

RFM		= rfm.mn rfmdrv.dr ddy0.dd y0.dd y1.dd y2.dd y3.dd

#
# The following macros represent a collection of modules for various
# kernel tracks and bootfile configurations.
#
KERNEL_1773	= rel_32 boot_1773 krn
KERNEL_RAMPAK	= rel_32 $(TPB)/boot_rampak krn
KERNEL_KENTON	= rel_32 $(TPB)/boot_kenton krn
KERNEL_IDE	= rel_32 $(TPB)/boot_ide krn

ALLOBJS		=  $(BOOTTRACK) $(KERNEL) $(SYSMODS) $(CLOCKS) $(RBF) $(SCF) $(PIPE) $(RFM)

all:	$(ALLOBJS)

# Kernel
ccbkrn krn krnp2:
	$(CD) kernel; make $@
	$(OS9COPY) kernel/$@ .

# Special cases
# TC^3 SCSI Booter
# Here, ITDNS sets the scsi bus address of the boot drive, where
# ITDNS = 1 = %00000001
# ITDNS = 2 = %00000010
# ITDNS = 3 = %00000100 etc
# This is 4th byte from end of module
# Controller hardware addr is usually $FF74 6th-5th byte from end of module
# MPI = 1 = set MPI slot # from SDMPI in CtrlSlot if 1, Set $FF if zero

boot_tc3: boot_scsi.asm
	$(AS) $(ASOUT)$@ $< $(TC3FLAGS) -aITDNS=0 -aMPI=1 -aITDRV=1

# SuperIDE/Glenside IDE Booter
boot_ide: boot_ide.asm
	$(AS) $(ASOUT)$@ $< $(IDEFLAGS)

# DriveWire 3 Becker Booter
boot_dw_becker: boot_dw.asm
	$(AS) $< $(ASOUT)$@ $(AFLAGS) -aBECKER=1

# DriveWire 3 Becker Submodule
dwio_becker.sb: dwio.asm
	$(AS) $< $(ASOUT)$@ $(AFLAGS) -aBECKER=1

# CoGrf/CoVDG Modules
cogrf.io: cowin.asm
	$(AS) $< $(ASOUT)$@ $(AFLAGS) -aCoGrf=1

covdg.io: covdg.asm
	$(AS) $(AFLAGS) $(ASOUT)$@ $< -aCOCO2=1

covdg_small.io: covdg.asm
	$(AS) $(AFLAGS) $(ASOUT)$@ $<

# Disto SC-II Drivers
rb1773_scii_ff74.dr:    rb1773.asm
	$(AS) $< $(ASOUT)$@ $(AFLAGS) -aSCII=1
                                                                            
rb1773_scii_ff58.dr:    rb1773.asm
	$(AS) $< $(ASOUT)$@ $(AFLAGS) -aSCII=1 -aSCIIALT=1
                                                                            
# REL Modules
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

# Floppy Booters
boot_1773_6ms: boot_1773.asm
	$(AS) $< $(ASOUT)$@ $(AFLAGS) -aSTEP=0

boot_1773_30ms: boot_1773.asm
	$(AS) $< $(ASOUT)$@ $(AFLAGS) -aSTEP=3

# SysGo Modules
sysgo_dd: sysgo.asm
	$(AS) $< $(ASOUT)$@ $(AFLAGS) -aDD=1
	
sysgo_h0: sysgo.asm
	$(AS) $< $(ASOUT)$@ $(AFLAGS)
	
sysgo_rom: sysgo.asm
	$(AS) $< $(ASOUT)$@ $(AFLAGS) -aROM=1
	
# TC^3 SCSI Driver
lltc3.dr: llscsi.asm
	$(AS) $(ASOUT)$@ $< $(TC3FLAGS)

# IDE Driver
llide.dr: llide.asm
	$(AS) $(ASOUT)$@ $< $(IDEFLAGS)

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
	$(AS) $< $(ASOUT)$@ $(AFLAGS) -aAddr=0

n_scdwn.dd: scdwndesc.asm
	$(AS) $< $(ASOUT)$@ $(AFLAGS) -aAddr=255

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

midi_scdwn.dd: scdwndesc.asm
	$(AS) $< $(ASOUT)$@ $(AFLAGS) -aAddr=14

term_z_scdwn.dd: scdwndesc.asm
	$(AS) $< $(ASOUT)$@ $(AFLAGS) -aAddr=16

z1_scdwn.dd: scdwndesc.asm
	$(AS) $< $(ASOUT)$@ $(AFLAGS) -aAddr=17

z2_scdwn.dd: scdwndesc.asm
	$(AS) $< $(ASOUT)$@ $(AFLAGS) -aAddr=18

z3_scdwn.dd: scdwndesc.asm
	$(AS) $< $(ASOUT)$@ $(AFLAGS) -aAddr=19

z4_scdwn.dd: scdwndesc.asm
	$(AS) $< $(ASOUT)$@ $(AFLAGS) -aAddr=20

z5_scdwn.dd: scdwndesc.asm
	$(AS) $< $(ASOUT)$@ $(AFLAGS) -aAddr=21

z6_scdwn.dd: scdwndesc.asm
	$(AS) $< $(ASOUT)$@ $(AFLAGS) -aAddr=22

z7_scdwn.dd: scdwndesc.asm
	$(AS) $< $(ASOUT)$@ $(AFLAGS) -aAddr=23

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

# TC^3 SCSI Descriptors
dds0_tc3.dd: superdesc.asm
	$(AS) $(ASOUT)$@ $< $(TC3FLAGS) $(ID0) -aDD=1 -aDnum=0 -aITDRV=0

s0_tc3.dd: superdesc.asm
	$(AS) $(ASOUT)$@ $< $(TC3FLAGS) $(ID0) $(SCSI_HD) -aDnum=0 -aITDRV=0

s1_tc3.dd: superdesc.asm
	$(AS) $(ASOUT)$@ $< $(TC3FLAGS) $(ID1) $(SCSI_HD) -aDnum=1 -aITDRV=1

s2_tc3.dd: superdesc.asm
	$(AS) $(ASOUT)$@ $< $(TC3FLAGS) $(ID2) $(SCSI_HD) -aDnum=2 -aITDRV=2

s3_tc3.dd: superdesc.asm
	$(AS) $(ASOUT)$@ $< $(TC3FLAGS) $(ID3) $(SCSI_HD) -aDnum=3 -aITDRV=3

s4_tc3.dd: superdesc.asm
	$(AS) $(ASOUT)$@ $< $(TC3FLAGS) $(ID4) $(SCSI_HD) -aDnum=4 -aITDRV=4

s5_tc3.dd: superdesc.asm
	$(AS) $(ASOUT)$@ $< $(TC3FLAGS) $(ID5) $(SCSI_HD) -aDnum=5 -aITDRV=5

s6_tc3.dd: superdesc.asm
	$(AS) $(ASOUT)$@ $< $(TC3FLAGS) $(ID6) $(SCSI_HD) -aDnum=6 -aITDRV=6

sh_tc3.dd: superdesc.asm
	$(AS) $(ASOUT)$@ $< $(TC3FLAGS) $(HDBDOS) $(SSDD35) -aHDBDOS=1 -aHB=1 -aDnum=7 -aITDRV=0

# IDE Descriptors
ddi0_ide.dd: superdesc.asm
	$(AS) $(ASOUT)$@ $< $(IDEFLAGS) $(MASTER) -aDnum=0 -aDD=1 -aITDRV=0

i0_ide.dd: superdesc.asm
	$(AS) $(ASOUT)$@ $< $(IDEFLAGS) $(MASTER) -aDnum=0 -aITDRV=0

i1_ide.dd: superdesc.asm
	$(AS) $(ASOUT)$@ $< $(IDEFLAGS) $(SLAVE) -aDnum=1 -aITDRV=1

ih_ide.dd: superdesc.asm
	$(AS) $(ASOUT)$@ $< $(IDEFLAGS) $(SSDD35) -aHDBDOS=1 -aHD=1 -aDnum=0 -aITDRV=0

# RFM descriptors
ddy0.dd: rfmdesc.asm
	$(AS) $< $(ASOUT)$@ $(AFLAGS) -aDD=1 -aDNum=0

y0.dd: rfmdesc.asm
	$(AS) $< $(ASOUT)$@ $(AFLAGS) -aDNum=0

y1.dd: rfmdesc.asm
	$(AS) $< $(ASOUT)$@ $(AFLAGS) -aDNum=1

y2.dd: rfmdesc.asm
	$(AS) $< $(ASOUT)$@ $(AFLAGS) -aDNum=2

y3.dd: rfmdesc.asm
	$(AS) $< $(ASOUT)$@ $(AFLAGS) -aDNum=3

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
