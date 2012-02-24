PORT = atari
include $(NITROS9DIR)/rules.mak

vpath %.asm $(LEVEL1)/modules

AFLAGS		+= -I$(LEVEL1)/modules

CLOCKSOFT       = -aRTCSoft=1

DEPENDS		= ./makefile
TPB		= $(3RDPARTY)/booters

BOOTERS		= 
KERNEL		= krn krnp2
SYSMODS		= ioman init sysgo
CLOCKS      = clock_60hz clock_50hz clock2_soft

RBF		= rbf.mn

SCF		= scf.mn \
		vrn.dr vtio.dr \
		nil.dd \
		term.dt

PIPE		= pipeman.mn \
		piper.dr \
		pipe.dd

ALLOBJS		= $(KERNEL) $(SYSMODS) $(CLOCKS) $(RBF) $(SCF) $(PIPE)

all:	$(ALLOBJS)

# Kernel
krn krnp2:
	$(CD) kernel; make $@
	$(CP) kernel/$@ .


sysgo: sysgo.asm
	$(AS) $(AFLAGS) $(ASOUT)$@ $< -aROM=1

# Clocks
clock_60hz: clock.asm
	$(AS) $(AFLAGS) $(ASOUT)$@ $< -aPwrLnFrq=60

clock_50hz: clock.asm
	$(AS) $(AFLAGS) $(ASOUT)$@ $< -aPwrLnFrq=50

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


