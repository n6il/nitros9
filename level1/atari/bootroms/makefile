include $(NITROS9DIR)/rules.mak

# Module directory
MD		= ../modules
# Commands directory
CD		= ../cmds

DEPENDS		= ./makefile

BOOTFILE_ROM	= $(MD)/krnp2 $(MD)/init \
				$(MD)/ioman $(MD)/scf.mn $(MD)/vtio.dr $(MD)/term.dt \
				$(MD)/sysgo_dd \
				$(MD)/krn

BOOTFILE_ROM_OLD	= $(MD)/rominfo $(MD)/ioman \
		$(MD)/scf.mn $(MD)/vtio.dr \
		$(MD)/covdg.io \
		$(MD)/term32.dt \
		$(MD)/clock_60hz $(MD)/clock2_soft

BOOTROMS	= nos96809l1.rom

ALLROMS		= $(BOOTROMS)

all:	$(ALLROMS)

# Bootfiles
nos96809l1.rom: $(BOOTFILE_ROM) $(DEPENDS)
	$(MERGE) $(BOOTFILE_ROM)>$@
	$(PADROM) -b 10240 $@
	
clean:
	$(RM) $(ALLROMS)