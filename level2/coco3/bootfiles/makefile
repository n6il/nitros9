include ../../Makefile.rules

# Module directory
MD		= ../MODULES
# Commands directory
CD		= ../CMDS
# Third Party directory
3PB		= $(3RDPARTY)/booters
3PD		= $(3RDPARTY)/drivers

DEPENDS		= ./Makefile

KERNEL_1773	= $(MD)/rel $(MD)/boot_1773 $(MD)/os9p1
KERNEL_ROM	= $(MD)/rel $(3PB)/boot_rom $(MD)/os9p1
KERNEL_KENTON	= $(MD)/rel $(3PB)/boot_ktlr_id5 $(MD)/os9p1
KERNEL_TC3	= $(MD)/rel $(3PB)/boot_tc3_id5 $(MD)/os9p1

# OS-9 disk bootfile to allow booting from WD1773 disk controller
BOOTFILE_1773	= $(MD)/os9p2 $(MD)/ioman $(MD)/init \
		$(MD)/rbf.mn \
		$(MD)/cc3disk.dr $(MD)/d0_40d.dd $(MD)/d1_80d.dd \
		$(MD)/ddd0_40d.dd \
		$(MD)/scf.mn $(MD)/cc3io.dr \
		$(MD)/keydrv $(MD)/joydrv_joy $(MD)/snddrv \
		$(MD)/windint.io $(MD)/vdgint.io \
		$(MD)/term_vdg.dt \
		$(MD)/w.dw $(MD)/w1.dw $(MD)/w2.dw $(MD)/w3.dw $(MD)/w4.dw \
		$(MD)/w5.dw $(MD)/w6.dw $(MD)/w7.dw \
		$(MD)/pipeman.mn $(MD)/piper.dr $(MD)/pipe.dd \
		$(MD)/clock $(MD)/clock2_soft

BOOTFILE_1773_ROM = $(MD)/rominfo

# OS-9 ROM image to allow booting from ROM
BOOTFILE_ROM	= $(MD)/rominfo $(MD)/os9p2 $(MD)/init $(MD)/ioman \
		$(MD)/scf.mn $(MD)/sio.dr $(MD)/term_t1.dd \
		$(MD)/sspak.dr $(MD)/ssp.dd \
		$(MD)/clock $(MD)/clock2_soft $(MD)/cc3go_rom \
		$(CD)/shell $(CD)/mdir $(CD)/mfree $(CD)/procs

# OS-9 disk bootfile to allow booting from Ken-Ton SCSI controller
# This is a custom boot for Boisy's system
BOOTFILE_TC3	= $(3PD)/scsisys/scsisys_68_tc3.dr \
		$(MD)/os9p2 $(MD)/ioman $(MD)/init \
		$(MD)/rbf.mn \
		$(3PD)/scsisys/dd_zip100_tc3_l2.dd \
		$(3PD)/scsisys/h5_zip100_tc3_l2.dd \
		$(MD)/scf.mn $(MD)/cc3io.dr \
		$(MD)/keydrv $(MD)/joydrv_6551L $(MD)/snddrv \
		$(3PD)/disto/rampak.dr $(3PD)/disto/r0_256_l2.dd \
		$(MD)/cc3disk.dr $(MD)/d0_40d.dd $(MD)/d1_80d.dd \
		$(MD)/windint.io $(MD)/term_win80.dt \
		$(MD)/w.dw $(MD)/w1.dw $(MD)/w2.dw $(MD)/w3.dw $(MD)/w4.dw \
		$(MD)/w5.dw $(MD)/w6.dw $(MD)/w7.dw \
		$(3PD)/s16550/s16550_large.dr $(3PD)/s16550/t2_s16550.dd \
		$(MD)/pipeman.mn $(MD)/piper.dr $(MD)/pipe.dd \
		$(MD)/clock $(MD)/clock2_soft
		
# OS-9 disk bootfile to allow booting from Ken-Ton SCSI controller
BOOTFILE_KENTON	= $(3PD)/scsisys/scsisys_68_ktlr.dr \
		$(MD)/os9p2 $(MD)/ioman $(MD)/init \
		$(MD)/rbf.mn \
		$(3PD)/scsisys/h5_zip100_ktlr_l2.dd \
		$(MD)/scf.mn $(MD)/cc3io.dr \
		$(MD)/keydrv $(MD)/joydrv_6551L $(MD)/snddrv \
		$(3PD)/disto/rampak.dr $(3PD)/disto/r0_256_l2.dd \
		$(MD)/cc3disk.dr $(MD)/d0_40d.dd $(MD)/d1_80d.dd \
		$(MD)/windint.io $(MD)/term_win80.dt \
		$(MD)/w.dw $(MD)/w1.dw $(MD)/w2.dw $(MD)/w3.dw $(MD)/w4.dw \
		$(MD)/w5.dw $(MD)/w6.dw $(MD)/w7.dw \
		$(3PD)/s16550/s16550_large.dr $(3PD)/s16550/t2_s16550.dd \
		$(MD)/pipeman.mn $(MD)/piper.dr $(MD)/pipe.dd \
		$(MD)/clock $(MD)/clock2_soft
		
BOOTFILES	= bootfile_1773 bootfile_tc3 bootfile_kenton bootfile_rom
KERNELS		= kernel_1773 kernel_tc3 kernel_kenton

ALLOBJS		= $(BOOTFILES) $(KERNELS)

all:	$(ALLOBJS)
	$(CHMOD) 600 $(ALLOBJS)

bootfile_1773: $(BOOTFILE_1773) $(DEPENDS)
	$(MERGE) $(BOOTFILE_1773)>$@

bootfile_tc3: $(BOOTFILE_TC3) $(DEPENDS)
	$(MERGE) $(BOOTFILE_TC3)>$@

bootfile_kenton: $(BOOTFILE_KENTON) $(DEPENDS)
	$(MERGE) $(BOOTFILE_KENTON)>$@

kernel_1773: $(KERNEL_1773) $(DEPENDS)
	$(MERGE) $(KERNEL_1773)>$@

kernel_tc3: $(KERNEL_TC3) $(DEPENDS)
	$(MERGE) $(KERNEL_TC3)>$@

kernel_rom: $(KERNEL_ROM) $(DEPENDS)
	$(MERGE) $(KERNEL_ROM)>$@

kernel_kenton: $(KERNEL_KENTON) $(DEPENDS)
	$(MERGE) $(KERNEL_KENTON)>$@

# ROM image (32,768 bytes long) to burn into ROM on CoCo 3
bootfile_1773_rom: $(BOOTFILE_1773_ROM) $(DEPENDS) kernel_1773
	$(MERGE) $(BOOTFILE_1773_ROM)>$@
	$(PADROM) \$$6C00 $@ -c=\$$FF
	$(MERGE) kernel_1773>>$@
	$(PADROM) \$$7FF0 $@ -c=\$$FF
	$(MERGE) $(MD)/rom_vectors>>$@

# ROM image (32,768 bytes long) to burn into ROM on CoCo 3
bootfile_rom: $(BOOTFILE_ROM) $(DEPENDS) kernel_rom
	$(MERGE) $(BOOTFILE_ROM)>$@
	ls -l $@
	$(PADROM) \$$6C00 $@ -c=\$$FF
	$(MERGE) kernel_rom>>$@
	$(PADROM) \$$7FF0 $@ -c=\$$FF
	$(MERGE) $(MD)/rom_vectors>>$@

clean:
	$(RM) $(ALLOBJS)

