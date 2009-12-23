include $(NITROS9DIR)/rules.mak

DEPENDS		= ./makefile
BF68L1		= $(LEVEL1)/coco/bootfiles
MD68L1		= $(LEVEL1)/coco/modules
BF68L2		= $(LEVEL2)/coco3/bootfiles
MD68L2		= $(LEVEL2)/coco3/modules
BF63L2		= $(LEVEL2)/coco3_6309/bootfiles
MD63L2		= $(LEVEL2)/coco3_6309/modules

ROMS		= dw3dos_mb_cc3.rom dw3dos_mb_cc2.rom dw3dos_mb_cc1.rom \
		dw3dos_dsk_cc3.rom dw3dos_dsk_cc2.rom dw3dos_dsk_cc1.rom \
		dw3doscc3.bin dw3doscc2.bin dw3doscc1.bin

CASSFILES	= hdbcc1.wav hdbcc2.wav hdbcc3.wav dw3doscc1.wav dw3doscc2.wav dw3doscc3.wav

TRACKS		= dw3dos_cc3.trk dw3dos_cc2.trk dw3dos_cc1.trk

ALLOBJS		= $(ROMS) $(CASSFILES) $(TRACKS)

all:	banner $(ALLOBJS) $(DEPENDS) 

banner:
	@$(ECHO) "**************************************************"
	@$(ECHO) "*                                                *"
	@$(ECHO) "*           DriveWire 3 DOS Files                *"
	@$(ECHO) "*                                                *"
	@$(ECHO) "**************************************************"

dsk:	objs

# HDB-DOS DW Cassette Files
hdbcc1.wav: hdbdoscc1.bin
	dd if=$< bs=1 skip=5 of=hdbtmp count=8240
	makewav hdbtmp -r -d0x4fd0 -e0x4fd0 -o$@ -nHDBCC1
	rm hdbtmp

hdbcc2.wav: hdbdoscc2.bin
	dd if=$< bs=1 skip=5 of=hdbtmp count=8240
	makewav hdbtmp -r -d0x4fd0 -e0x4fd0 -o$@ -nHDBCC2
	rm hdbtmp

hdbcc3.wav: hdbdoscc3.bin
	dd if=$< bs=1 skip=5 of=hdbtmp count=8240
	makewav hdbtmp -r -d0x4fd0 -e0x4fd0 -o$@ -nHDBCC3
	rm hdbtmp

# DW3DOS ROMs
dw3dos_mb_cc3.rom:	dw3dos.asm
	$(AS) $(ASOUT)$@ $< $(AFLAGS) -aCoCo=3

dw3dos_mb_cc2.rom:	dw3dos.asm
	$(AS) $(ASOUT)$@ $< $(AFLAGS) -aCoCo=2

dw3dos_mb_cc1.rom:	dw3dos.asm
	$(AS) $(ASOUT)$@ $< $(AFLAGS) -aCoCo=1

dw3dos_dsk_cc3.rom:	dw3dos.asm
	$(AS) $(ASOUT)$@ $< $(AFLAGS) -aCoCo=3 -aDISKROM=1

dw3dos_dsk_cc2.rom:	dw3dos.asm
	$(AS) $(ASOUT)$@ $< $(AFLAGS) -aCoCo=2 -aDISKROM=1

dw3dos_dsk_cc1.rom:	dw3dos.asm
	$(AS) $(ASOUT)$@ $< $(AFLAGS) -aCoCo=1 -aDISKROM=1

dw3doscc3.bin:	dw3dos.asm
	$(AS) $(ASOUT)$@ $< $(AFLAGS) -aCoCo=3 -aBIN=1 -mb

dw3doscc2.bin:	dw3dos.asm
	$(AS) $(ASOUT)$@ $< $(AFLAGS) -aCoCo=2 -aBIN=1 -mb

dw3doscc1.bin:	dw3dos.asm
	$(AS) $(ASOUT)$@ $< $(AFLAGS) -aCoCo=1 -aBIN=1 -mb

dw3doscc3.wav:	dw3doscc3.bin
	makewav $< -r -d0x2400 -e0x2400 -o$@ -nDWDOSCC3

dw3doscc2.wav:	dw3doscc2.bin
	makewav $< -r -d0x2400 -e0x2400 -o$@ -nDWDOSCC

dw3doscc1.wav:	dw3doscc1.bin
	makewav $< -r -d0x2400 -e0x2400 -o$@ -nDWDOSCC

# DWDOS Tracks
dw3dos_cc3.trk:	dw3dos.asm
	$(AS) $(ASOUT)$@ $< $(AFLAGS) -aCoCo=3 -aDOSTRACK

dw3dos_cc2.trk:	dw3dos.asm
	$(AS) $(ASOUT)$@ $< $(AFLAGS) -aCoCo=2 -aDOSTRACK

dw3dos_cc1.trk:	dw3dos.asm
	$(AS) $(ASOUT)$@ $< $(AFLAGS) -aCoCo=1 -aDOSTRACK

clean:
	$(RM) $(ALLOBJS)

