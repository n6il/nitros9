include ../../Makefile.rules

DEPENDS		= ./Makefile
BOOTERS		= boot_kenton boot_rampak boot_tc3 boot_ide boot_wd1002 \
		boot_rom boot_rom_l1 boot_tc3_l1 boot_kenton_l1
ALLOBJS		= $(BOOTERS)

all:	$(ALLOBJS) $(DEPENDS)

clean:
	$(RM) $(ALLOBJS)


boot_kenton: boot_kenton.asm
	$(AS) $(AFLAGS) $(ASOUT)$@ $< -aLevel=2

boot_rampak: boot_rampak.asm
	$(AS) $(AFLAGS) $(ASOUT)$@ $< -aLevel=2

boot_tc3: boot_tc3.asm
	$(AS) $(AFLAGS) $(ASOUT)$@ $< -aLevel=2

boot_ide: boot_ide.asm
	$(AS) $(AFLAGS) $(ASOUT)$@ $< -aLevel=2

boot_wd1002: boot_wd1002.asm
	$(AS) $(AFLAGS) $(ASOUT)$@ $< -aLevel=2

boot_rom: boot_rom.asm
	$(AS) $(AFLAGS) $(ASOUT)$@ $< -aLevel=2

boot_rom_l1: boot_rom_l1.asm
	$(AS) $(AFLAGS) $(ASOUT)$@ $< -aLevel=1

boot_kenton_l1: boot_kenton.asm
	$(AS) $(AFLAGS) $(ASOUT)$@ $< -aLevel=1

boot_tc3_l1: boot_tc3.asm
	$(AS) $(AFLAGS) $(ASOUT)$@ $< -aLevel=1

boot_tc3_l2: boot_tc3.asm
	$(AS) $(AFLAGS) $(ASOUT)$@ $< -aLevel=2

