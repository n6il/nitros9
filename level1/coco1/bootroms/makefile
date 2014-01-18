include ../port.mak

# Module directory
MD		= ../modules
CMDS		= ../cmds

DEPENDS		= ./makefile

KERNEL_ROM	= $(MD)/rel $(MD)/krn $(MD)/krnp2 $(MD)/init $(MD)/boot_rom

BOOTFILE_ROM	= $(MD)/rominfo $(MD)/ioman \
		$(MD)/scf.mn $(MD)/vtio.dr \
		$(MD)/covdg.io \
		$(MD)/term_vdg.dt \
		$(MD)/sysgo_dd \
		$(CMDS)/shell_21 \
		$(MD)/clock_60hz $(MD)/clock2_soft

BOOTFILE_ROMPAK	= $(MD)/rominfo_pak $(MD)/ioman \
		$(MD)/scf.mn $(MD)/vtio.dr \
		$(MD)/covdg.io \
		$(MD)/term_vdg.dt \
		$(MD)/sysgo_dd \
		$(CMDS)/shell_21 \
		$(MD)/clock_60hz $(MD)/clock2_soft

BOOTROMS	= nos96809l1.rom nos96809l1.rompak
KERNELS		= kernel_rom

ALLROMS		= $(BOOTROMS)

all:	$(ALLROMS)

# Bootfiles
nos96809l1.rom: $(BOOTFILE_ROM) $(KERNEL_ROM) $(DEPENDS)
	$(MERGE) $(BOOTFILE_ROM)>$@.tmp
	$(PADROM) 11776 $@.tmp
	$(MERGE) $(KERNEL_ROM)>kernel_rom
	$(PADROM) 4592 kernel_rom
	$(MERGE) $@.tmp kernel_rom>$@.tmp2
	$(MERGE) $@.tmp2 $(MD)/vectors>$@
	$(RM) $@.tmp $@.tmp2
	
nos96809l1.rompak: $(BOOTFILE_ROMPAK) $(KERNEL_ROM) $(DEPENDS)
	$(MERGE) $(BOOTFILE_ROMPAK)>$@.tmp
	$(PADROM) 11776 $@.tmp
	$(MERGE) $(KERNEL_ROM)>kernel_rom
	$(PADROM) 4352 kernel_rom
	$(MERGE) $@.tmp kernel_rom>$@
	$(RM) $@.tmp
	

# Kernels
kernel_rom: $(KERNEL_ROM) $(DEPENDS)
	$(MERGE) $(KERNEL_ROM)>$@

clean:
	$(RM) $(ALLROMS) $(KERNELS)

