include $(NITROS9DIR)/rules.mak

# Module directory
MD		= ../modules
# Commands directory
CD		= ../cmds

DEPENDS		= ./makefile

BOOTFILE_ROM_P1	= $(MD)/krnp2 $(MD)/init \
				$(MD)/ioman $(MD)/scf.mn $(MD)/vtio.dr $(MD)/term.dt \
				$(MD)/sysgo \
				$(MD)/clock_60hz $(MD)/clock2_soft \
				$(MD)/krn

BOOTFILE_ROM_P2	= $(CD)/shell_21 $(CD)/debug

BOOTROMS	= nos96809l1.rom

ALLROMS		= $(BOOTROMS)

all:	$(ALLROMS)

# Bootfiles
nos96809l1.rom: $(BOOTFILE_ROM) $(DEPENDS)
	$(MERGE) $(BOOTFILE_ROM_P1)>$@_p1
	$(MERGE) $(BOOTFILE_ROM_P2)>$@_p2
	$(PADROM) -b 10240 $@_p1
	$(PADROM) -b 12288 $@_p1
	$(MERGE) $@_p2 $@_p1>$@
	$(PADROM) -b 16384 $@
#	$(RM) $@_p2 $@_p1
	
clean:
	$(RM) $(ALLROMS)