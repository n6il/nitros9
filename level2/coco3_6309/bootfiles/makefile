include ../../Makefile.rules

# Module directory
MD		= ../MODULES
# Commands directory
CD		= ../CMDS
# Third Party directory
TP		= ../../3rdparty

DEPENDS		= ./Makefile

KERNEL_1773	= $(MD)/rel $(MD)/boot_1773 $(MD)/os9p1
KERNEL_ROM	= $(MD)/rel $(MD)/boot_rom $(MD)/os9p1
KERNEL_KENTON	= $(MD)/rel $(MD)/boot_kenton $(MD)/os9p1

# OS-9 disk bootfile to allow booting from WD1773 disk controller
BOOTFILE_1773	= $(MD)/os9p2 $(MD)/ioman $(MD)/init $(MD)/rbf.mn $(MD)/cc3disk.dr $(MD)/d0_40d.dd \
		$(MD)/d1_80d.dd $(MD)/ddd0_40d.dd $(MD)/scf.mn $(MD)/cc3io.dr $(MD)/keydrv $(MD)/joydrv_joy \
		$(MD)/snddrv $(MD)/windint.io $(MD)/term_win80.dt $(MD)/w.dw $(MD)/w1.dw $(MD)/w2.dw $(MD)/w3.dw $(MD)/w4.dw \
		$(MD)/w5.dw $(MD)/w6.dw $(MD)/w7.dw $(MD)/pipeman.mn $(MD)/piper.dr $(MD)/pipe.dd $(MD)/clock \
		$(MD)/clock2_soft $(MD)/cc3go

BOOTFILE_1773_ROM = $(MD)/rominfo

# OS-9 ROM image to allow booting from ROM
BOOTFILE_ROM	= $(MD)/rominfo $(MD)/os9p2 $(MD)/init $(MD)/ioman \
		$(MD)/scf.mn $(MD)/sio.dr $(MD)/term_t1.dd \
		$(MD)/sspak.dr $(MD)/ssp.dd \
		$(MD)/clock $(MD)/clock2_soft $(MD)/cc3go_rom \
		$(CD)/shell $(CD)/mdir $(CD)/mfree $(CD)/procs

# OS-9 disk bootfile to allow booting from Ken-Ton SCSI controller
BOOTFILE_KENTON	= $(MD)/os9p2 $(MD)/ioman $(MD)/rbf.mn $(MD)/clock $(MD)/clock2_soft $(MD)/rampak.dr \
		$(MD)/r0_rampak256.dd $(MD)/cc3disk.dr $(MD)/d0_40d.dd $(MD)/d1_80d.dd \
		$(TP)/drivers/scsisys22/scsisys_68_ktlr.dr \
		$(TP)/drivers/scsisys22/h0_ktlr.dd $(MD)/scf.mn $(MD)/cc3io.dr $(MD)/keydrv \
		$(MD)/joydrv_6551L $(MD)/s16550large.dr $(MD)/t2_s16550.dd \
		$(MD)/snddrv $(MD)/windint.io $(MD)/term_win80.dt $(MD)/w.dw $(MD)/w1.dw $(MD)/w2.dw $(MD)/w3.dw $(MD)/w4.dw \
		$(MD)/w5.dw $(MD)/w6.dw $(MD)/w7.dw $(MD)/pipeman.mn $(MD)/piper.dr $(MD)/pipe.dd $(MD)/init
		
BOOTFILES	= bootfile_1773 bootfile_kenton bootfile_rom

all:	$(BOOTFILES)

bootfile_1773: $(BOOTFILE_1773) $(DEPENDS)
	$(MERGE) $(BOOTFILE_1773)>$@

bootfile_kenton: $(BOOTFILE_KENTON) $(DEPENDS)
	$(MERGE) $(BOOTFILE_KENTON)>$@

# ROM image (32,768 bytes long) to burn into ROM on CoCo 3
bootfile_1773_rom: $(BOOTFILE_1773_ROM) $(DEPENDS) $(KERNEL_1773)
	$(MERGE) $(BOOTFILE_1773_ROM)>$@
	$(PADROM) \$$6C00 $@ -c=\$$FF
	$(MERGE) $(KERNEL_1773)>>$@
	$(PADROM) \$$7FF0 $@ -c=\$$FF
	$(MERGE) $(MD)/rom_vectors>>$@

# ROM image (32,768 bytes long) to burn into ROM on CoCo 3
bootfile_rom: $(BOOTFILE_ROM) $(DEPENDS) $(KERNEL_ROM)
	$(MERGE) $(BOOTFILE_ROM)>$@
	ls -l $@
	$(PADROM) \$$6C00 $@ -c=\$$FF
	$(MERGE) $(KERNEL_ROM)>>$@
	$(PADROM) \$$7FF0 $@ -c=\$$FF
	$(MERGE) $(MD)/rom_vectors>>$@

clean:
	$(RM) $(BOOTFILES)

