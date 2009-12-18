include $(NITROS9DIR)/rules.mak

DEPENDS		= ./makefile
BF68L1		= $(LEVEL1)/coco/bootfiles
MD68L1		= $(LEVEL1)/coco/modules
BF68L2		= $(LEVEL2)/coco3/bootfiles
MD68L2		= $(LEVEL2)/coco3/modules
BF63L2		= $(LEVEL2)/coco3_6309/bootfiles
MD63L2		= $(LEVEL2)/coco3_6309/modules

ROMS		= dw3dos_mb_cc3.rom dw3dos_mb_cc.rom \
		dw3dos_dsk_cc3.rom dw3dos_dsk_cc.rom \
		dw3doscc.bin dw3doscc3.bin

CASSFILES	= dw3doscc.wav dw3doscc3.wav

TRACKS		= dw3dos_cc3.trk dw3dos_cc.trk

ALLOBJS		= $(ROMS) $(CASSFILES) $(TRACKS)

all:	banner $(ALLOBJS) $(DEPENDS) 

banner:
	@$(ECHO) "**************************************************"
	@$(ECHO) "*                                                *"
	@$(ECHO) "*           DriveWire 3 DOS Files                *"
	@$(ECHO) "*                                                *"
	@$(ECHO) "**************************************************"

dsk:	objs

# DWDOS ROMs
dw3dos_mb_cc3.rom:	dw3dos.asm
	$(AS) $(ASOUT)$@ $< $(AFLAGS) -aCoCo=3

dw3dos_mb_cc.rom:	dw3dos.asm
	$(AS) $(ASOUT)$@ $< $(AFLAGS) -aCoCo=2

dw3dos_dsk_cc3.rom:	dw3dos.asm
	$(AS) $(ASOUT)$@ $< $(AFLAGS) -aCoCo=3 -aDISKROM=1

dw3dos_dsk_cc.rom:	dw3dos.asm
	$(AS) $(ASOUT)$@ $< $(AFLAGS) -aCoCo=1 -aDISKROM=1

dw3doscc3.bin:	dw3dos.asm
	$(AS) $(ASOUT)$@ $< $(AFLAGS) -aCoCo=3 -aBIN=1 -mb

dw3doscc.bin:	dw3dos.asm
	$(AS) $(ASOUT)$@ $< $(AFLAGS) -aCoCo=1 -aBIN=1 -mb

dw3doscc3.wav:	dw3doscc3.bin
	makewav $< -r -d0x2400 -e0x2400 -o$@ -nDWDOSCC3

dw3doscc.wav:	dw3doscc.bin
	makewav $< -r -d0x2400 -e0x2400 -o$@ -nDWDOSCC

# DWDOS Tracks
dw3dos_cc3.trk:	dw3dos.asm
	$(AS) $(ASOUT)$@ $< $(AFLAGS) -aCoCo=3 -aDOSTRACK

dw3dos_cc.trk:	dw3dos.asm
	$(AS) $(ASOUT)$@ $< $(AFLAGS) -aCoCo=1 -aDOSTRACK

clean:
	$(RM) $(ALLOBJS)

