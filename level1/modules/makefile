include ../../Makefile.rules

DEPENDS		= ./Makefile
TPB		= ../../3rdparty/booters

BOOTERS		= oscode boot_1773 $(TPB)/boot_rom_l1 rom_vectors
KERNELS		= os9 os9p2
SYSMODS		= rominfo ioman init
CLOCKS		= clock.60hz clock.50hz
FMGRS		= scf.mn rbf.mn pipeman.mn
DRIVERS		= aciapak.dr cchdisk.dr ccdisk.dr modpak.dr nildrv.dr \
		piper.dr printer.dr rs232.dr sscpak.dr ccio.dr
IOSUBS		= co32.io co80.io grfo.io
DESCS		= d0.dd d1.dd d2.dd d3.dd h0_15.dd h1_15.dd h0_35.dd \
		h1_35.dd m1.dd m2.dd nil.dd p.dd pipe.dd ssc.dd t1.dd \
		t2.dd t3.dd term32.dd term80.dd
SYSGOS		= sysgo sysgo_rom
ALLOBJS		= $(BOOTERS) $(KERNELS) $(SYSMODS) $(CLOCKS) $(FMGRS) \
		$(DRIVERS) $(IOSUBS) $(DESCS) $(SYSGOS)

KERNEL_1773	= oscode os9 os9p2 init boot_1773
KERNEL_ROM	= oscode os9 os9p2 init $(TP)/boot_rom_l1

all:	$(ALLOBJS)

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

identify:
	$(IDENT_SHORT) $(ALLOBJS)

showobjs:
	@echo $(ALLOBJS)
