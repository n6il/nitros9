include ../../Makefile.rules

DEPENDS		= ./Makefile
BOOTERS		= boot_kenton boot_rampak boot_tc3 boot_ide boot_wd1002 \
		boot_rom boot_rom_l1 boot_tc3_l1 boot_kenton_l1
ALLOBJS		= $(BOOTERS)

all:	$(ALLOBJS) $(DEPENDS)

clean:
	$(RM) $(ALLOBJS)


boot_kenton: boot_scsi.asm
	$(AS) $(AFLAGS) $(ASOUT)$@ $< -aLevel=2 -aKenton=1 -aTC3=0

boot_rampak: boot_rampak.asm
	$(AS) $(AFLAGS) $(ASOUT)$@ $< -aLevel=2

boot_tc3: boot_scsi.asm
	$(AS) -l $(AFLAGS) $(ASOUT)$@ $< -aLevel=2 -aKenton=0 -aTC3=1

boot_ide: boot_ide.asm
	$(AS) $(AFLAGS) $(ASOUT)$@ $< -aLevel=2

boot_wd1002: boot_wd1002.asm
	$(AS) $(AFLAGS) $(ASOUT)$@ $< -aLevel=2

boot_rom: boot_rom.asm
	$(AS) $(AFLAGS) $(ASOUT)$@ $< -aLevel=2

boot_rom_l1: boot_rom_l1.asm
	$(AS) $(AFLAGS) $(ASOUT)$@ $< -aLevel=1

boot_kenton_l1: boot_scsi.asm
	$(AS) $(AFLAGS) $(ASOUT)$@ $< -aLevel=1 -aKenton=1 -aTC3=0

boot_tc3_l1: boot_scsi.asm
	$(AS) $(AFLAGS) $(ASOUT)$@ $< -aLevel=1 -aKenton=1 -aTC3=0

