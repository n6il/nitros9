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
		dw3doscc3.bin dw3doscc2.bin dw3doscc1.bin \
		dw4dos_mb_cc3.rom dw4dos_mb_cc2.rom \
		dw4dos_dsk_cc3.rom dw4dos_dsk_cc2.rom \
		dw4doscc3.bin dw4doscc2.bin

CASSFILES	= hdbdw1.wav hdbdw3.wav hdbdw4.wav dw3doscc1.wav dw3doscc2.wav dw3doscc3.wav \
		dw4doscc2.wav dw4doscc3.wav	

TRACKS		= dw3dos_cc3.trk dw3dos_cc2.trk dw3dos_cc1.trk \
		dw4dos_cc3.trk dw4dos_cc2.trk

ALLOBJS		= $(ROMS) $(CASSFILES) $(TRACKS)

all:	banner $(ALLOBJS) $(DEPENDS) 

banner:
	@$(ECHO) "**************************************************"
	@$(ECHO) "*                                                *"
	@$(ECHO) "*          DriveWire 3/4 DOS Files               *"
	@$(ECHO) "*                                                *"
	@$(ECHO) "**************************************************"

dsk:	objs

# HDB-DOS DW Cassette Files
hdbdw1.wav: hdbdosdw1.bin
	dd if=$< bs=1 skip=5 of=hdbtmp count=8240
	makewav hdbtmp -r -d0x4fd0 -e0x4fd0 -o$@ -nHDBDW3C1
	rm hdbtmp

hdbdw3.wav: hdbdosdw3.bin
	dd if=$< bs=1 skip=5 of=hdbtmp count=8240
	makewav hdbtmp -r -d0x4fd0 -e0x4fd0 -o$@ -nHDBDW3
	rm hdbtmp

hdbdw4.wav: hdbdosdw4.bin
	dd if=$< bs=1 skip=5 of=hdbtmp count=8240
	makewav hdbtmp -r -d0x4fd0 -e0x4fd0 -o$@ -nHDBDW4
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
	makewav $< -r -d0x2400 -e0x2400 -o$@ -nDW3DOSC3

dw3doscc2.wav:	dw3doscc2.bin
	makewav $< -r -d0x2400 -e0x2400 -o$@ -nDW3DOSC2

dw3doscc1.wav:	dw3doscc1.bin
	makewav $< -r -d0x2400 -e0x2400 -o$@ -nDW3DOSC1

# DW4DOS ROMs
dw4dos_mb_cc3.rom:	dw3dos.asm
	$(AS) $(ASOUT)$@ $< $(AFLAGS) -aCoCo=3 -aDW4=1

dw4dos_mb_cc2.rom:	dw3dos.asm
	$(AS) $(ASOUT)$@ $< $(AFLAGS) -aCoCo=2 -aDW4=1

dw4dos_dsk_cc3.rom:	dw3dos.asm
	$(AS) $(ASOUT)$@ $< $(AFLAGS) -aCoCo=3 -aDISKROM=1 -aDW4=1

dw4dos_dsk_cc2.rom:	dw3dos.asm
	$(AS) $(ASOUT)$@ $< $(AFLAGS) -aCoCo=2 -aDISKROM=1 -aDW4=1

dw4doscc3.bin:	dw3dos.asm
	$(AS) $(ASOUT)$@ $< $(AFLAGS) -aCoCo=3 -aBIN=1 -mb -aDW4=1

dw4doscc2.bin:	dw3dos.asm
	$(AS) $(ASOUT)$@ $< $(AFLAGS) -aCoCo=2 -aBIN=1 -mb -aDW4=1

dw4doscc3.wav:	dw3doscc3.bin
	makewav $< -r -d0x2400 -e0x2400 -o$@ -nDW3DOSC3

dw4doscc2.wav:	dw3doscc2.bin
	makewav $< -r -d0x2400 -e0x2400 -o$@ -nDW3DOSC2

# DW3DOS Tracks
dw3dos_cc3.trk:	dw3dos.asm
	$(AS) $(ASOUT)$@ $< $(AFLAGS) -aCoCo=3 -aDOSTRACK

dw3dos_cc2.trk:	dw3dos.asm
	$(AS) $(ASOUT)$@ $< $(AFLAGS) -aCoCo=2 -aDOSTRACK

dw3dos_cc1.trk:	dw3dos.asm
	$(AS) $(ASOUT)$@ $< $(AFLAGS) -aCoCo=1 -aDOSTRACK

# DW4DOS Tracks
dw4dos_cc3.trk:	dw3dos.asm
	$(AS) $(ASOUT)$@ $< $(AFLAGS) -aCoCo=3 -aDOSTRACK -aDW4=1

dw4dos_cc2.trk:	dw3dos.asm
	$(AS) $(ASOUT)$@ $< $(AFLAGS) -aCoCo=2 -aDOSTRACK -aDW4=1

drivewire.zip: $(ALLOBJS)
	zip $@ $(ALLOBJS)

clean:
	$(RM) $(ALLOBJS) drivewire.zip

