PORT = atari
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
TC3FLAGS        = $(AFLAGS) -aTC3=1 $(FLAGS)
IDEFLAGS        = $(AFLAGS) -aIDE=1 $(FLAGS)

DEPENDS		= ./makefile
TPB		= $(3RDPARTY)/booters

BOOTERS		= 
KERNEL		= krn krnp2
SYSMODS		= ioman init sysgo
CLOCKS      = clock_60hz clock_50hz

RBF		= rbf.mn

SCF		= scf.mn \
		sc6551.dr vrn.dr scbbp.dr scbbt.dr scdwp.dr vtio.dr \
		nil.dd \
		term.dt

PIPE		= pipeman.mn \
		piper.dr \
		pipe.dd

ALLOBJS		= $(BOOTTRACK) $(KERNEL) $(SYSMODS) $(CLOCKS) $(RBF) $(SCF) $(PIPE)

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


