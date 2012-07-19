include $(NITROS9DIR)/rules.mak

# Module directory
MD		= ../modules
# Commands directory
CD		= ../cmds

DEPENDS		= ./makefile

KERNEL_ROM	= $(MD)/rel $(MD)/krn $(MD)/krnp2 $(MD)/init $(MD)/boot_rom

BOOTFILE_ROM	= $(MD)/rominfo $(MD)/ioman \
		$(MD)/scf.mn $(MD)/vtio.dr \
		$(MD)/covdg.io \
		$(MD)/term_vdg.dt \
		$(MD)/clock_60hz $(MD)/clock2_soft

BOOTROMS	= nos96809l1.rom
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
	

# Kernels
kernel_rom: $(KERNEL_ROM) $(DEPENDS)
	$(MERGE) $(KERNEL_ROM)>$@

clean:
	$(RM) $(ALLROMS) $(KERNELS)

