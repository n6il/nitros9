PORT = coco
include $(NITROS9DIR)/rules.mak

# Module directory
MD		= ../modules
# Commands directory
CD		= ../cmds

DEPENDS		= ./makefile

KERNEL_1773	= $(MD)/rel $(MD)/krn $(MD)/krnp2 $(MD)/init \
		$(MD)/boot_1773_6ms

KERNEL_DW3_COCO1	= $(MD)/rel $(MD)/krn $(MD)/krnp2 $(MD)/init \
		$(MD)/boot_dw3_coco1

KERNEL_DW3_COCO2	= $(MD)/rel $(MD)/krn $(MD)/krnp2 $(MD)/init \
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

BOOTFILE_HEADLESS_DW3_COCO1	= $(MD)/ioman \
		$(MD)/rbf.mn \
		$(MD)/rbdw3.dr $(MD)/dw3_coco1.sb \
		$(MD)/ddx0.dd $(MD)/x1.dd $(MD)/x2.dd $(MD)/x3.dd \
		$(MD)/scf.mn \
		$(MD)/scdwn.dr \
		$(MD)/term_scdwn.dt \
		$(MD)/n_scdwn.dd $(MD)/n1_scdwn.dd $(MD)/n2_scdwn.dd \
		$(MD)/n3_scdwn.dd $(MD)/n4_scdwn.dd $(MD)/n5_scdwn.dd \
		$(MD)/n6_scdwn.dd $(MD)/n7_scdwn.dd $(MD)/n8_scdwn.dd \
		$(MD)/n9_scdwn.dd $(MD)/n10_scdwn.dd $(MD)/n11_scdwn.dd \
		$(MD)/n12_scdwn.dd $(MD)/n13_scdwn.dd $(MD)/midi_scdwn.dd \
		$(MD)/scdwp.dr $(MD)/p_scdwp.dd \
		$(MD)/pipeman.mn $(MD)/piper.dr $(MD)/pipe.dd \
		$(MD)/clock_60hz $(MD)/clock2_dw3 \
		$(MD)/sysgo_dd

BOOTFILE_COVDG_DW3_COCO1	= $(MD)/ioman \
		$(MD)/rbf.mn $(MD)/rb1773.dr \
		$(MD)/d0_80d.dd $(MD)/d1_40d.dd $(MD)/d2_40d.dd \
		$(MD)/rbdw3.dr $(MD)/dw3_coco1.sb \
		$(MD)/ddx0.dd $(MD)/x1.dd $(MD)/x2.dd $(MD)/x3.dd \
		$(MD)/scf.mn \
		$(MD)/vtio.dr $(MD)/covdg.io $(MD)/term32.dt \
		$(MD)/scdwn.dr \
		$(MD)/n_scdwn.dd $(MD)/n1_scdwn.dd $(MD)/n2_scdwn.dd \
		$(MD)/n3_scdwn.dd $(MD)/n4_scdwn.dd $(MD)/n5_scdwn.dd \
		$(MD)/n6_scdwn.dd $(MD)/n7_scdwn.dd $(MD)/n8_scdwn.dd \
		$(MD)/n9_scdwn.dd $(MD)/n10_scdwn.dd $(MD)/n11_scdwn.dd \
		$(MD)/n12_scdwn.dd $(MD)/n13_scdwn.dd $(MD)/midi_scdwn.dd \
		$(MD)/scdwp.dr $(MD)/p_scdwp.dd \
		$(MD)/pipeman.mn $(MD)/piper.dr $(MD)/pipe.dd \
		$(MD)/clock_60hz $(MD)/clock2_dw3 \
		$(MD)/sysgo_dd
		
BOOTFILE_HEADLESS_DW3_COCO2	= $(MD)/ioman \
		$(MD)/rbf.mn \
		$(MD)/rbdw3.dr $(MD)/dw3.sb \
		$(MD)/ddx0.dd $(MD)/x1.dd $(MD)/x2.dd $(MD)/x3.dd \
		$(MD)/scf.mn \
		$(MD)/scdwn.dr \
		$(MD)/term_scdwn.dt \
		$(MD)/n_scdwn.dd $(MD)/n1_scdwn.dd $(MD)/n2_scdwn.dd \
		$(MD)/n3_scdwn.dd $(MD)/n4_scdwn.dd $(MD)/n5_scdwn.dd \
		$(MD)/n6_scdwn.dd $(MD)/n7_scdwn.dd $(MD)/n8_scdwn.dd \
		$(MD)/n9_scdwn.dd $(MD)/n10_scdwn.dd $(MD)/n11_scdwn.dd \
		$(MD)/n12_scdwn.dd $(MD)/n13_scdwn.dd $(MD)/midi_scdwn.dd \
		$(MD)/scdwp.dr $(MD)/p_scdwp.dd \
		$(MD)/pipeman.mn $(MD)/piper.dr $(MD)/pipe.dd \
		$(MD)/clock_60hz $(MD)/clock2_dw3 \
		$(MD)/sysgo_dd

BOOTFILE_COVDG_DW3_COCO2	= $(MD)/ioman \
		$(MD)/rbf.mn $(MD)/rb1773.dr \
		$(MD)/d0_80d.dd $(MD)/d1_40d.dd $(MD)/d2_40d.dd \
		$(MD)/rbdw3.dr $(MD)/dw3.sb \
		$(MD)/ddx0.dd $(MD)/x1.dd $(MD)/x2.dd $(MD)/x3.dd \
		$(MD)/scf.mn \
		$(MD)/vtio.dr $(MD)/covdg.io $(MD)/term32.dt \
		$(MD)/scdwn.dr \
		$(MD)/n_scdwn.dd $(MD)/n1_scdwn.dd $(MD)/n2_scdwn.dd \
		$(MD)/n3_scdwn.dd $(MD)/n4_scdwn.dd $(MD)/n5_scdwn.dd \
		$(MD)/n6_scdwn.dd $(MD)/n7_scdwn.dd $(MD)/n8_scdwn.dd \
		$(MD)/n9_scdwn.dd $(MD)/n10_scdwn.dd $(MD)/n11_scdwn.dd \
		$(MD)/n12_scdwn.dd $(MD)/n13_scdwn.dd $(MD)/midi_scdwn.dd \
		$(MD)/scdwp.dr $(MD)/p_scdwp.dd \
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

BOOTFILE_COHR_DW3_COCO1	= $(MD)/ioman \
		$(MD)/rbf.mn $(MD)/rb1773.dr \
		$(MD)/d0_80d.dd $(MD)/d1_40d.dd $(MD)/d2_40d.dd \
		$(MD)/rbdw3.dr $(MD)/dw3_coco1.sb \
		$(MD)/ddx0.dd $(MD)/x1.dd $(MD)/x2.dd $(MD)/x3.dd \
		$(MD)/scf.mn \
		$(MD)/vtio.dr $(MD)/cohr.io $(MD)/term51.dt \
		$(MD)/scdwn.dr \
		$(MD)/n_scdwn.dd $(MD)/n1_scdwn.dd $(MD)/n2_scdwn.dd \
		$(MD)/n3_scdwn.dd $(MD)/n4_scdwn.dd $(MD)/n5_scdwn.dd \
		$(MD)/n6_scdwn.dd $(MD)/n7_scdwn.dd $(MD)/n8_scdwn.dd \
		$(MD)/n9_scdwn.dd $(MD)/n10_scdwn.dd $(MD)/n11_scdwn.dd \
		$(MD)/n12_scdwn.dd $(MD)/n13_scdwn.dd $(MD)/midi_scdwn.dd \
		$(MD)/scdwp.dr $(MD)/p_scdwp.dd \
		$(MD)/pipeman.mn $(MD)/piper.dr $(MD)/pipe.dd \
		$(MD)/clock_60hz $(MD)/clock2_dw3 \
		$(MD)/sysgo_dd

BOOTFILE_COHR_DW3_COCO2	= $(MD)/ioman \
		$(MD)/rbf.mn $(MD)/rb1773.dr \
		$(MD)/d0_80d.dd $(MD)/d1_40d.dd $(MD)/d2_40d.dd \
		$(MD)/rbdw3.dr $(MD)/dw3.sb \
		$(MD)/ddx0.dd $(MD)/x1.dd $(MD)/x2.dd $(MD)/x3.dd \
		$(MD)/scf.mn \
		$(MD)/vtio.dr $(MD)/cohr.io $(MD)/term51.dt \
		$(MD)/scdwn.dr \
		$(MD)/n_scdwn.dd $(MD)/n1_scdwn.dd $(MD)/n2_scdwn.dd \
		$(MD)/n3_scdwn.dd $(MD)/n4_scdwn.dd $(MD)/n5_scdwn.dd \
		$(MD)/n6_scdwn.dd $(MD)/n7_scdwn.dd $(MD)/n8_scdwn.dd \
		$(MD)/n9_scdwn.dd $(MD)/n10_scdwn.dd $(MD)/n11_scdwn.dd \
		$(MD)/n12_scdwn.dd $(MD)/n13_scdwn.dd $(MD)/midi_scdwn.dd \
		$(MD)/scdwp.dr $(MD)/p_scdwp.dd \
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

BOOTFILES	= bootfile_covdg bootfile_cohr bootfile_covdg_dw3_coco1 bootfile_covdg_dw3_coco2 \
		bootfile_headless_dw3_coco1 bootfile_headless_dw3_coco2 \
		bootfile_cohr_dw3_coco1 bootfile_cohr_dw3_coco2 bootfile_covdg_ds80 bootfile_cohr_ds80
KERNELS		= kernel_1773 kernel_dw3_coco1 kernel_dw3_coco2

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

bootfile_headless_dw3_coco1: $(BOOTFILE_HEADLESS_DW3_COCO1) $(DEPENDS)
	$(MERGE) $(BOOTFILE_HEADLESS_DW3_COCO1)>$@

bootfile_covdg_dw3_coco1: $(BOOTFILE_COVDG_DW3_COCO1) $(DEPENDS)
	$(MERGE) $(BOOTFILE_COVDG_DW3_COCO1)>$@

bootfile_headless_dw3_coco2: $(BOOTFILE_HEADLESS_DW3_COCO2) $(DEPENDS)
	$(MERGE) $(BOOTFILE_HEADLESS_DW3_COCO2)>$@

bootfile_covdg_dw3_coco2: $(BOOTFILE_COVDG_DW3_COCO2) $(DEPENDS)
	$(MERGE) $(BOOTFILE_COVDG_DW3_COCO2)>$@

bootfile_cohr_ds80: $(BOOTFILE_COHR_DS80) $(DEPENDS)
	$(MERGE) $(BOOTFILE_COHR_DS80)>$@

bootfile_cohr_dw3_coco1: $(BOOTFILE_COHR_DW3_COCO1) $(DEPENDS)
	$(MERGE) $(BOOTFILE_COHR_DW3_COCO1)>$@

bootfile_cohr_dw3_coco2: $(BOOTFILE_COHR_DW3_COCO2) $(DEPENDS)
	$(MERGE) $(BOOTFILE_COHR_DW3_COCO2)>$@

# WD1773 Kernel
kernel_1773: $(KERNEL_1773) $(DEPENDS)
	$(MERGE) $(KERNEL_1773)>$@
	$(PADROM) 4608 $@

# DriveWire 3 Kernel
kernel_dw3_coco1: $(KERNEL_DW3_COCO1) $(DEPENDS)
	$(MERGE) $(KERNEL_DW3_COCO1)>$@
	$(PADROM) 4608 $@

kernel_dw3_coco2: $(KERNEL_DW3_COCO2) $(DEPENDS)
	$(MERGE) $(KERNEL_DW3_COCO2)>$@
	$(PADROM) 4608 $@

clean:
	$(RM) $(ALLOBJS)

