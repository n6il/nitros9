PORT = coco
include $(NITROS9DIR)/rules.mak

# Module directory
MD		= ../modules
# Commands directory
CD		= ../cmds

DEPENDS		= ./makefile

KERNEL_1773	= $(MD)/rel $(MD)/krn $(MD)/krnp2 $(MD)/init \
		$(MD)/boot_1773_6ms

KERNEL_DW3	= $(MD)/rel $(MD)/krn $(MD)/krnp2 $(MD)/init \
		$(MD)/boot_dw3

IDE		= $(3PD)/ide
SCSI		= $(3PD)/scsisys

BOOTFILE_COVDG	= $(MD)/ioman \
		$(MD)/rbf.mn $(MD)/rb1773.dr \
		$(MD)/d0_40d.dd $(MD)/d1_40d.dd $(MD)/d2_40d.dd \
		$(MD)/ddd0_40d.dd \
		$(MD)/scf.mn \
		$(MD)/vtio.dr $(MD)/covdg.io $(MD)/term32.dt \
		$(MD)/scbbp.dr $(MD)/p_scbbp.dd \
		$(MD)/scbbt.dr $(MD)/t1_scbbt.dd \
		$(MD)/pipeman.mn $(MD)/piper.dr $(MD)/pipe.dd \
		$(MD)/clock_60hz $(MD)/clock2_soft \
		$(MD)/sysgo_dd

BOOTFILE_COHR	= $(MD)/ioman \
		$(MD)/rbf.mn $(MD)/rb1773.dr \
		$(MD)/d0_40d.dd $(MD)/d1_40d.dd $(MD)/d2_40d.dd \
		$(MD)/ddd0_40d.dd \
		$(MD)/scf.mn \
		$(MD)/vtio.dr $(MD)/cohr.io $(MD)/term51.dt \
		$(MD)/scbbp.dr $(MD)/p_scbbp.dd \
		$(MD)/scbbt.dr $(MD)/t1_scbbt.dd \
		$(MD)/pipeman.mn $(MD)/piper.dr $(MD)/pipe.dd \
		$(MD)/clock_60hz $(MD)/clock2_soft \
		$(MD)/sysgo_dd

BOOTFILE_COWP	= $(MD)/ioman \
		$(MD)/rbf.mn $(MD)/rb1773.dr \
		$(MD)/d0_40d.dd $(MD)/d1_40d.dd $(MD)/d2_40d.dd \
		$(MD)/ddd0_40d.dd \
		$(MD)/scf.mn \
		$(MD)/vtio.dr $(MD)/cowp.io $(MD)/term80.dt \
		$(MD)/scbbp.dr $(MD)/p_scbbp.dd \
		$(MD)/scbbt.dr $(MD)/t1_scbbt.dd \
		$(MD)/pipeman.mn $(MD)/piper.dr $(MD)/pipe.dd \
		$(MD)/clock_60hz $(MD)/clock2_soft \
		$(MD)/sysgo_dd

BOOTFILE_COVDG_DW3	= $(MD)/ioman \
		$(MD)/rbdw3.dr $(MD)/dw3.sb \
		$(MD)/ddx0.dd $(MD)/x1.dd $(MD)/x2.dd $(MD)/x3.dd \
		$(MD)/rbf.mn $(MD)/rb1773.dr \
		$(MD)/d0_80d.dd $(MD)/d1_40d.dd $(MD)/d2_40d.dd \
		$(MD)/scf.mn \
		$(MD)/vtio.dr $(MD)/covdg.io $(MD)/term32.dt \
		$(MD)/scdwp.dr $(MD)/p_scdwp.dd \
		$(MD)/scbbt.dr $(MD)/t1_scbbt.dd \
		$(MD)/pipeman.mn $(MD)/piper.dr $(MD)/pipe.dd \
		$(MD)/clock_60hz $(MD)/clock2_dw3 \
		$(MD)/sysgo_dd

BOOTFILE_COVDG_DS80	= $(MD)/ioman \
		$(MD)/rbf.mn $(MD)/rb1773.dr \
		$(MD)/d0_80d.dd $(MD)/d1_40d.dd $(MD)/d2_40d.dd \
		$(MD)/ddd0_80d.dd \
		$(MD)/scf.mn \
		$(MD)/vtio.dr $(MD)/covdg.io $(MD)/term32.dt \
		$(MD)/scbbp.dr $(MD)/p_scbbp.dd \
		$(MD)/scbbt.dr $(MD)/t1_scbbt.dd \
		$(MD)/pipeman.mn $(MD)/piper.dr $(MD)/pipe.dd \
		$(MD)/clock_60hz $(MD)/clock2_soft \
		$(MD)/sysgo_dd

BOOTFILE_COHR_DW3	= $(MD)/ioman \
		$(MD)/rbdw3.dr $(MD)/dw3.sb \
		$(MD)/ddx0.dd $(MD)/x1.dd $(MD)/x2.dd $(MD)/x3.dd \
		$(MD)/rbf.mn $(MD)/rb1773.dr \
		$(MD)/d0_80d.dd $(MD)/d1_40d.dd $(MD)/d2_40d.dd \
		$(MD)/ddd0_80d.dd \
		$(MD)/scf.mn \
		$(MD)/vtio.dr $(MD)/cohr.io $(MD)/term51.dt \
		$(MD)/scdwp.dr $(MD)/p_scdwp.dd \
		$(MD)/scbbt.dr $(MD)/t1_scbbt.dd \
		$(MD)/pipeman.mn $(MD)/piper.dr $(MD)/pipe.dd \
		$(MD)/clock_60hz $(MD)/clock2_dw3 \
		$(MD)/sysgo_dd

BOOTFILE_COHR_DS80	= $(MD)/ioman \
		$(MD)/rbf.mn $(MD)/rb1773.dr \
		$(MD)/d0_80d.dd $(MD)/d1_40d.dd $(MD)/d2_40d.dd \
		$(MD)/ddd0_80d.dd \
		$(MD)/scf.mn \
		$(MD)/vtio.dr $(MD)/cohr.io $(MD)/term51.dt \
		$(MD)/scbbp.dr $(MD)/p_scbbp.dd \
		$(MD)/scbbt.dr $(MD)/t1_scbbt.dd \
		$(MD)/pipeman.mn $(MD)/piper.dr $(MD)/pipe.dd \
		$(MD)/clock_60hz $(MD)/clock2_soft \
		$(MD)/sysgo_dd

BOOTFILES	= bootfile_covdg bootfile_cohr bootfile_covdg_dw3 bootfile_cohr_dw3 bootfile_covdg_ds80 bootfile_cohr_ds80
KERNELS		= kernel_1773 kernel_dw3

ALLOBJS		= $(BOOTFILES) $(KERNELS)

all:	$(ALLOBJS)

bootfile_covdg: $(BOOTFILE_COVDG) $(DEPENDS)
	$(MERGE) $(BOOTFILE_COVDG)>$@

bootfile_cohr: $(BOOTFILE_COHR) $(DEPENDS)
	$(MERGE) $(BOOTFILE_COHR)>$@

bootfile_cowp: $(BOOTFILE_COWP) $(DEPENDS)
	$(MERGE) $(BOOTFILE_COWP)>$@

bootfile_covdg_ds80: $(BOOTFILE_COVDG_DS80) $(DEPENDS)
	$(MERGE) $(BOOTFILE_COVDG_DS80)>$@

bootfile_covdg_dw3: $(BOOTFILE_COVDG_DW3) $(DEPENDS)
	$(MERGE) $(BOOTFILE_COVDG_DW3)>$@

bootfile_cohr_ds80: $(BOOTFILE_COHR_DS80) $(DEPENDS)
	$(MERGE) $(BOOTFILE_COHR_DS80)>$@

bootfile_cohr_dw3: $(BOOTFILE_COHR_DW3) $(DEPENDS)
	$(MERGE) $(BOOTFILE_COHR_DW3)>$@

# Dragon64 Disk boot
bootfile_d64: $(BOOTFILE_D64) $(DEPENDS)
	$(MERGE) $(BOOTFILE_D64)>$@

# WD1773 Kernel
kernel_1773: $(KERNEL_1773) $(DEPENDS)
	$(MERGE) $(KERNEL_1773)>$@
	$(PADROM) 4608 $@

# DriveWire 3 Kernel
kernel_dw3: $(KERNEL_DW3) $(DEPENDS)
	$(MERGE) $(KERNEL_DW3)>$@
	$(PADROM) 4608 $@

clean:
	$(RM) $(ALLOBJS)

