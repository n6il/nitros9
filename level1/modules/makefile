include ../../Makefile.rules

DEPENDS		= ./Makefile
TPB		= ../../3rdparty/booters

BOOTERS		= oscode oscode_d64 boot_1773 $(TPB)/boot_rom_l1 rom_vectors
KERNELS		= os9 os9p2
SYSMODS		= rominfo ioman init
CLOCKS		= clock.60hz clock.50hz
FMGRS		= scf.mn rbf.mn pipeman.mn
DRIVERS		= aciapak.dr cchdisk.dr ccdisk.dr modpak.dr nildrv.dr \
		piper.dr printer.dr rs232.dr sscpak.dr ccio.dr
IOSUBS		= co32.io co80.io grfo.io
DESCS		= dd.dd d0.dd d1.dd d2.dd d3.dd h0_15.dd h1_15.dd h0_35.dd \
		h1_35.dd m1.dd m2.dd nil.dd p.dd pipe.dd ssc.dd t1.dd \
		t2.dd t3.dd term32.dd term80.dd
SYSGOS		= sysgo sysgo_rom
HELP		= co32.hp co80.hp dd.hp d0.hp d1.hp d2.hp d3.hp grfo.hp h0_15.hp \
		h0_35.hp h1_15.hp h1_35.hp m1.hp m2.hp nil.hp p.hp pipe.hp \
		ssc.hp t1.hp t2.hp t3.hp term32.hp term80.hp config.hp

KERNEL_1773	= oscode os9 os9p2 init boot_1773
KERNEL_ROM	= oscode os9 os9p2 init $(TPB)/boot_rom_l1

BOOT_TRACKS	= kernel_1773 kernel_rom
ALLOBJS		= $(BOOTERS) $(KERNELS) $(SYSMODS) $(CLOCKS) $(FMGRS) \
		$(DRIVERS) $(IOSUBS) $(DESCS) $(SYSGOS) $(BOOT_TRACKS)

all:	$(ALLOBJS) $(HELP)
	$(UNIX2OS9) $(HELP)

# Kernel track for OS-9 in ROM on a CoCo
kernel_rom: $(KERNEL_ROM) $(DEPENDS)
	$(MERGE) $(KERNEL_ROM)>$@
	$(PADROM) \$$1200 $@ -c=\$$E5

# Kernel track for Tandy/RS controller (WD1773)
kernel_1773: $(KERNEL_1773) $(DEPENDS)
	$(MERGE) $(KERNEL_1773)>$@
	$(PADROM) \$$1200 $@ -c=\$$E5

clean:
	$(RM) $(ALLOBJS)
	$(OS92UNIX) $(HELP)

identify:
	$(IDENT_SHORT) $(ALLOBJS)

showobjs:
	@echo $(ALLOBJS)
