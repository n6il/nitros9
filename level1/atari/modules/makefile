PORT = atari
include $(NITROS9DIR)/rules.mak

vpath %.asm $(LEVEL1)/modules

AFLAGS		+= -I$(LEVEL1)/modules

CLOCKSOFT       = -DRTCSoft=1

DEPENDS		= ./makefile
TPB		= $(3RDPARTY)/booters

BOOTERS		= 
KERNEL		= krn krnp2
SYSMODS		= ioman init sysgo sysgo_rom
CLOCKS      = clock_60hz clock_50hz clock2_soft clock2_dw3

RBF		= rbf.mn rbdw3.dr dw3.sb ddx0.dd x0.dd x1.dd x2.dd x3.dd

SCF		= scf.mn \
		vrn.dr vtio.dr \
		nil.dd \
		term.dt \
		scdwp.dr p_scdwp.dd \
		scdwn.dr term_scdwn.dt n_scdwn.dd n1_scdwn.dd n2_scdwn.dd \
		n3_scdwn.dd n4_scdwn.dd n5_scdwn.dd n6_scdwn.dd n7_scdwn.dd \
		n8_scdwn.dd n9_scdwn.dd n10_scdwn.dd n11_scdwn.dd n12_scdwn.dd \
		n13_scdwn.dd midi_scdwn.dd

PIPE		= pipeman.mn \
		piper.dr \
		pipe.dd


ALLOBJS		= $(KERNEL) $(SYSMODS) $(CLOCKS) $(RBF) $(SCF) $(PIPE) $(DW)

all:	$(ALLOBJS)

# Kernel
krn krnp2:
	$(CD) kernel; make $@
	$(CP) kernel/$@ .


sysgo_rom: sysgo.asm
	$(AS) $(AFLAGS) $(ASOUT)$@ $< -DROM=1

# DriveWire 3 RBF descriptors
ddx0.dd: dwdesc.asm
	$(AS) $< $(ASOUT)$@ $(AFLAGS) -DDD=1 -DDNum=0

x0.dd: dwdesc.asm
	$(AS) $< $(ASOUT)$@ $(AFLAGS) -DDNum=0

x1.dd: dwdesc.asm
	$(AS) $< $(ASOUT)$@ $(AFLAGS) -DDNum=1

x2.dd: dwdesc.asm
	$(AS) $< $(ASOUT)$@ $(AFLAGS) -DDNum=2

x3.dd: dwdesc.asm
	$(AS) $< $(ASOUT)$@ $(AFLAGS) -DDNum=3

# DriveWire 3 SCF descriptors
term_scdwn.dt: scdwndesc.asm
	$(AS) $< $(ASOUT)$@ $(AFLAGS) -DAddr=0

n_scdwn.dd: scdwndesc.asm
	$(AS) $< $(ASOUT)$@ $(AFLAGS) -DAddr=255

n1_scdwn.dd: scdwndesc.asm
	$(AS) $< $(ASOUT)$@ $(AFLAGS) -DAddr=1

n2_scdwn.dd: scdwndesc.asm
	$(AS) $< $(ASOUT)$@ $(AFLAGS) -DAddr=2

n3_scdwn.dd: scdwndesc.asm
	$(AS) $< $(ASOUT)$@ $(AFLAGS) -DAddr=3

n4_scdwn.dd: scdwndesc.asm
	$(AS) $< $(ASOUT)$@ $(AFLAGS) -DAddr=4

n5_scdwn.dd: scdwndesc.asm
	$(AS) $< $(ASOUT)$@ $(AFLAGS) -DAddr=5

n6_scdwn.dd: scdwndesc.asm
	$(AS) $< $(ASOUT)$@ $(AFLAGS) -DAddr=6

n7_scdwn.dd: scdwndesc.asm
	$(AS) $< $(ASOUT)$@ $(AFLAGS) -DAddr=7

n8_scdwn.dd: scdwndesc.asm
	$(AS) $< $(ASOUT)$@ $(AFLAGS) -DAddr=8

n9_scdwn.dd: scdwndesc.asm
	$(AS) $< $(ASOUT)$@ $(AFLAGS) -DAddr=9

n10_scdwn.dd: scdwndesc.asm
	$(AS) $< $(ASOUT)$@ $(AFLAGS) -DAddr=10

n11_scdwn.dd: scdwndesc.asm
	$(AS) $< $(ASOUT)$@ $(AFLAGS) -DAddr=11

n12_scdwn.dd: scdwndesc.asm
	$(AS) $< $(ASOUT)$@ $(AFLAGS) -DAddr=12

n13_scdwn.dd: scdwndesc.asm
	$(AS) $< $(ASOUT)$@ $(AFLAGS) -DAddr=13

midi_scdwn.dd: scdwndesc.asm
	$(AS) $< $(ASOUT)$@ $(AFLAGS) -DAddr=14

# Clocks
clock_60hz: clock.asm
	$(AS) $(AFLAGS) $(ASOUT)$@ $< -DPwrLnFrq=60

clock_50hz: clock.asm
	$(AS) $(AFLAGS) $(ASOUT)$@ $< -DPwrLnFrq=50

clean:
	$(CD) kernel; make $@
	$(RM) $(ALLOBJS)

showobjs:
	@$(ECHO) $(ALLOBJS)

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


