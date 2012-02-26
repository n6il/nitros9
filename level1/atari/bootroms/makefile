include $(NITROS9DIR)/rules.mak

%.rom:
# Module directory
MD		= ../modules
# Commands directory
CD		= ../cmds

DEPENDS		= ./makefile

BOOTROMS	= liber809.rom

ALLROMS		= $(BOOTROMS)

all:	$(ALLROMS)

# Boot ROMs
liber809.rom: liber809.asm
	$(AS) $(AFLAGS) -mr -I../modules $< $(ASOUT)$@

clean:
	$(RM) $(ALLROMS)
