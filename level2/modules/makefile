include ../../Makefile.rules

DEPENDS		= ./Makefile
TPB		= ../../3rdparty/booters

BOOTERS		= boot_1773
OS9P1		= os9p1
OS9P2		= os9p2
REL		= rel
ROMMODS         = rominfo rom_vectors cc3go_rom pakrom
SYSMODS		= ioman init cc3go
CLOCKS		= clock clock2_soft clock2_disto clock2_146818
FMGRS		= scf.mn rbf.mn pipeman.mn pipeman_named.mn
DRIVERS		= cc3disk.dr cc3hdisk.dr cc3io.dr modpak.dr \
		vrn.dr piper.dr printer.dr sio.dr ram.dr sspak.dr \
		sacia.dr dacia.dr
IOSUBS		= windint.io vdgint.io keydrv joydrv_joy \
		joydrv_6551L joydrv_6552L joydrv_6551M joydrv_6552M snddrv
DESCS		= d0_35s.dd d1_35s.dd d2_35s.dd d3_35s.dd \
		d0_40d.dd d1_40d.dd d2_40d.dd d0_80d.dd \
		d1_80d.dd d2_80d.dd ddd0_35s.dd ddd0_40d.dd \
		ddd0_80d.dd r0_8k.dd r0_96k.dd r0_128k.dd r0_192k.dd \
		ddr0_8k.dd ddr0_96k.dd ddr0_128k.dd ddr0_192k.dd \
		m1.dd m2.dd nil.dd p.dd pipe.dd t1.dd t2_sacia.dd \
		t3_sacia.dd t2_dacia.dd t3_dacia.dd \
		h0_10.dd h1_10.dd h0_15.dd h1_15.dd h0_35.dd h1_35.dd \
		ftdd.dd vi.dd ssp.dd term_t1.dd
WINDESCS	= term_vdg.dt term_win40.dt term_win80.dt w.dw w1.dw w2.dw \
		w3.dw w4.dw w5.dw w6.dw w7.dw v1.dw v2.dw v3.dw v4.dw v5.dw \
		v6.dw v7.dw

#
# The following macros represent a collection of modules for various
# kernel tracks and bootfile configurations.
#
KERNEL_1773	= rel boot_1773 os9p1
KERNEL_RAMPAK	= rel $(TPB)/boot_rampak os9p1
KERNEL_KENTON	= rel $(TPB)/boot_kenton os9p1
KERNEL_ROM	= rel $(TPB)/boot_rom os9p1
KERNEL_IDE	= rel $(TPB)/boot_ide os9p1
# These kernels are intended to be ROMmed in a disk controller or program pak
KERNEL_PAK_KENTON	= pakrom $(KERNEL_KENTON)

ALLOBJS		=  $(BOOTERS) $(OS9P1) $(OS9P2) $(REL) $(ROMMODS) $(SYSMODS) $(CLOCKS) $(FMGRS) \
		$(DRIVERS) $(IOSUBS) $(DESCS) $(WINDESCS) \
		kernel_1773 kernel_rom kernel_kenton kernel_pak_kenton \
		kernel_rampak kernel_ide

all:	$(ALLOBJS)
	$(CHMOD) 755 $(ALLOBJS)


# Special cases here
sacia.dr: xacia.asm
	$(AS) -aA6551=1 -aA6552=0 -aMPI.Slot=00 $(AFLAGS) $< $(ASOUT)$@
	
dacia.dr: xacia.asm
	$(AS) -aA6551=0 -aA6552=1 -aMPI.Slot=00 $(AFLAGS) $< $(ASOUT)$@



boot_1773: boot_1773.asm
	$(AS) -aNitrOS9=0 $(AFLAGS) $< $(ASOUT)$@

kernel_1773: $(KERNEL_1773) $(DEPENDS)
	$(MERGE) $(KERNEL_1773)>$@

kernel_rampak: $(KERNEL_RAMPAK) $(DEPENDS)
	$(MERGE) $(KERNEL_RAMPAK)>$@

kernel_rom: $(KERNEL_ROM) $(DEPENDS)
	$(MERGE) $(KERNEL_ROM)>$@

kernel_kenton: $(KERNEL_KENTON) $(DEPENDS)
	$(MERGE) $(KERNEL_KENTON)>$@

kernel_ide: $(KERNEL_IDE) $(DEPENDS)
	$(MERGE) $(KERNEL_IDE)>$@

kernel_pak_kenton: $(KERNEL_PAK_KENTON) $(DEPENDS)
	$(MERGE) $(KERNEL_PAK_KENTON)>$@
	$(PADROM) \$$2000 $@ -c=\$$FF

rominfo: rominfo.asm
	$(AS) -aROMPak=0 $(AFLAGS) $< $(ASOUT)$@

clean:
	$(RM) $(ALLOBJS)

showobjs:
	@$(ECHO) $(ALLOBJS)

showcopyobjs:
	@$(ECHO) $(OS9P2) $(SYSMODS) $(CLOCKS) $(FMGRS) \
		$(DRIVERS) $(IOSUBS) $(DESCS) $(WINDESCS) \

identify:
	$(IDENT_SHORT) $(ALLOBJS)
