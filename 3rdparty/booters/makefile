include ../../Makefile.rules

DEPENDS		= ./Makefile
BOOTERS_NITROS	= boot_ide_nl2
BOOTERS_L2	= boot_ktlr boot_ktlr_id5 boot_rampak \
		boot_tc3 boot_tc3_id5 boot_ide boot_wd1002 \
		boot_burke boot_rom
BOOTERS_L1	= boot_ktlr_l1 boot_ktlr_id5_l1 boot_rampak_l1 \
		boot_tc3_l1 boot_tc3_id5_l1 boot_ide_l1 \
		boot_burke_l1 boot_rom_l1
ALLOBJS		= $(BOOTERS_NITROS) $(BOOTERS_L2) $(BOOTERS_L1)

all:	$(ALLOBJS) $(DEPENDS)

clean:
	$(RM) $(ALLOBJS)


# NitrOS-9 Booters
boot_ide_nl2: boot_ide.asm
	$(AS) $(AFLAGS) $(ASOUT)$@ $< -aLevel=2 -aNitrOS9=1

# OS-9 Level Two Booters
boot_ide: boot_ide.asm
	$(AS) $(AFLAGS) $(ASOUT)$@ $< -aLevel=2

boot_ktlr: boot_scsi.asm
	$(AS) $(AFLAGS) $(ASOUT)$@ $< -aLevel=2 -aKenton=1

boot_ktlr_id5: boot_scsi.asm
	$(AS) $(AFLAGS) $(ASOUT)$@ $< -aLevel=2 -aKenton=1 -ascsiid=32

boot_rampak: boot_rampak.asm
	$(AS) $(AFLAGS) $(ASOUT)$@ $< -aLevel=2

boot_tc3: boot_scsi.asm
	$(AS) $(AFLAGS) $(ASOUT)$@ $< -aLevel=2 -aTC3=1

boot_tc3_id5: boot_scsi.asm
	$(AS) $(AFLAGS) $(ASOUT)$@ $< -aLevel=2 -aTC3=1 -ascsiid=32

boot_wd1002: boot_wd1002.asm
	$(AS) $(AFLAGS) $(ASOUT)$@ $< -aLevel=2

boot_burke: boot_burke.asm
	$(AS) $(AFLAGS) $(ASOUT)$@ $< -aLevel=2

boot_rom: boot_rom.asm
	$(AS) $(AFLAGS) $(ASOUT)$@ $< -aLevel=2

# OS-9 Level One Booters
boot_rom_l1: boot_rom_l1.asm
	$(AS) $(AFLAGS) $(ASOUT)$@ $< -aLevel=1

boot_ktlr_l1: boot_scsi.asm
	$(AS) $(AFLAGS) $(ASOUT)$@ $< -aLevel=1 -aKenton=1

boot_ktlr_id5_l1: boot_scsi.asm
	$(AS) $(AFLAGS) $(ASOUT)$@ $< -aLevel=1 -aKenton=1 -ascsiid=32

boot_tc3_l1: boot_scsi.asm
	$(AS) $(AFLAGS) $(ASOUT)$@ $< -aLevel=1 -aTC3=1

boot_tc3_id5_l1: boot_scsi.asm
	$(AS) $(AFLAGS) $(ASOUT)$@ $< -aLevel=1 -aTC3=1 -ascsiid=32

boot_rampak_l1: boot_rampak.asm
	$(AS) $(AFLAGS) $(ASOUT)$@ $< -aLevel=1

boot_burke_l1: boot_burke.asm
	$(AS) $(AFLAGS) $(ASOUT)$@ $< -aLevel=1

boot_ide_l1: boot_ide.asm
	$(AS) $(AFLAGS) $(ASOUT)$@ $< -aLevel=1

