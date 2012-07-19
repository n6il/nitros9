ifeq ($(PORT),)
        PORT=coco1
endif
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

FLOPPY_40D = $(MD)/rb1773.dr $(MD)/d0_40d.dd $(MD)/d1_40d.dd $(MD)/d2_40d.dd \
          $(MD)/ddd0_40d.dd
FLOPPY_80D = $(MD)/rb1773.dr $(MD)/d0_40d.dd $(MD)/d1_40d.dd $(MD)/d2_40d.dd \
          $(MD)/ddd0_80d.dd
VTIO_32COL = $(MD)/vtio.dr $(MD)/covdg.io $(MD)/term_vdg.dt
VTIO_51COL = $(MD)/vtio.dr $(MD)/cohr.io $(MD)/term_hr.dt
VTIO_80COL = $(MD)/vtio.dr $(MD)/co80.io $(MD)/term_80.dt
PIPE       = $(MD)/pipeman.mn $(MD)/piper.dr $(MD)/pipe.dd
CLOCK60HZ   = $(MD)/clock_60hz $(MD)/clock2_soft
CLOCK60HZDW = $(MD)/clock_60hz $(MD)/clock2_dw3
RBDW3      = $(MD)/rbdw3.dr $(MD)/dw3.sb \
		$(MD)/ddx0.dd $(MD)/x1.dd $(MD)/x2.dd $(MD)/x3.dd
SCDWV_NET  = $(MD)/n_scdwv.dd $(MD)/n1_scdwv.dd $(MD)/n2_scdwv.dd \
		$(MD)/n3_scdwv.dd $(MD)/n4_scdwv.dd $(MD)/n5_scdwv.dd \
		$(MD)/n6_scdwv.dd $(MD)/n7_scdwv.dd $(MD)/n8_scdwv.dd \
		$(MD)/n9_scdwv.dd $(MD)/n10_scdwv.dd $(MD)/n11_scdwv.dd \
		$(MD)/n12_scdwv.dd $(MD)/n13_scdwv.dd $(MD)/midi_scdwv.dd
SCDWV_WIN  = $(MD)/n_scdwv.dd $(MD)/n1_scdwv.dd $(MD)/n2_scdwv.dd \
		$(MD)/n3_scdwv.dd $(MD)/n4_scdwv.dd $(MD)/n5_scdwv.dd \
		$(MD)/n6_scdwv.dd $(MD)/n7_scdwv.dd $(MD)/n8_scdwv.dd \
		$(MD)/n9_scdwv.dd $(MD)/n10_scdwv.dd $(MD)/n11_scdwv.dd \
		$(MD)/n12_scdwv.dd $(MD)/n13_scdwv.dd $(MD)/midi_scdwv.dd
SCDWP     = $(MD)/scdwp.dr $(MD)/p_scdwp.dd
		
BOOTFILE_COVDG	= $(MD)/ioman \
		$(MD)/rbf.mn \
		$(FLOPPY_40D) \
		$(MD)/scf.mn \
		$(VTIO_32COL) \
		$(MD)/scbbp.dr $(MD)/p_scbbp.dd \
		$(MD)/scbbt.dr $(MD)/t1_scbbt.dd \
		$(PIPE) \
		$(CLOCK60HZ) \
		$(MD)/sysgo_dd

BOOTFILE_COHR	= $(MD)/ioman \
		$(MD)/rbf.mn \
		$(FLOPPY_40D) \
		$(MD)/scf.mn \
		$(VTIO_51COL) \
		$(MD)/scbbp.dr $(MD)/p_scbbp.dd \
		$(MD)/scbbt.dr $(MD)/t1_scbbt.dd \
		$(PIPE) \
		$(CLOCK60HZ) \
		$(MD)/sysgo_dd

BOOTFILE_CO80	= $(MD)/ioman \
		$(MD)/rbf.mn \
		$(FLOPPY_40D) \
		$(MD)/scf.mn \
		$(VTIO_80COL) \
		$(MD)/scbbp.dr $(MD)/p_scbbp.dd \
		$(MD)/scbbt.dr $(MD)/t1_scbbt.dd \
		$(PIPE) \
		$(CLOCK60HZ) \
		$(MD)/sysgo_dd

BOOTFILE_HEADLESS_DW3	= $(MD)/ioman \
		$(MD)/rbf.mn \
		$(RBDW3) \
		$(MD)/scf.mn \
		$(MD)/scdwv.dr \
		$(SCDWV_NET) \
		$(MD)/term_z_scdwv.dt \
		$(SCDWV_WIN) \
		$(SCDWP)\
		$(PIPE) \
		$(CLOCK60HZDW) \
		$(MD)/sysgo_dd

BOOTFILE_COVDG_DW3	= $(MD)/ioman \
		$(MD)/rbf.mn \
		$(FLOPPY_40D) \
		$(RBDW3) \
		$(MD)/scf.mn \
		$(VTIO_32COL) \
		$(MD)/scdwv.dr \
		$(SCDWV_NET) \
		$(SCDWV_WIN) \
		$(SCDWP)\
		$(PIPE) \
		$(CLOCK60HZDW) \
		$(MD)/sysgo_dd
		
BOOTFILE_COVDG_DS80	= $(MD)/ioman \
		$(MD)/rbf.mn \
		$(FLOPPY_80D) \
		$(MD)/scf.mn \
		$(VTIO_32COL) \
		$(MD)/scbbp.dr $(MD)/p_scbbp.dd \
		$(MD)/scbbt.dr $(MD)/t1_scbbt.dd \
		$(PIPE) \
		$(CLOCK60HZ) \
		$(MD)/sysgo_dd

BOOTFILE_COHR_DW3	= $(MD)/ioman \
		$(MD)/rbf.mn \
		$(FLOPPY_40D) \
		$(RBDW3) \
		$(MD)/scf.mn \
		$(VTIO_51COL) \
		$(MD)/scdwv.dr \
		$(SCDWV_NET) \
		$(SCDWP)\
		$(PIPE) \
		$(CLOCK60HZDW) \
		$(MD)/sysgo_dd

BOOTFILE_COHR_DS80	= $(MD)/ioman \
		$(MD)/rbf.mn \
		$(FLOPPY_80D) \
		$(MD)/scf.mn \
		$(VTIO_80COL) \
		$(MD)/scbbp.dr $(MD)/p_scbbp.dd \
		$(MD)/scbbt.dr $(MD)/t1_scbbt.dd \
		$(PIPE) \
		$(CLOCK60HZ) \
		$(MD)/sysgo_dd

BOOTFILES	= bootfile_covdg bootfile_cohr bootfile_covdg_dw3 \
		bootfile_headless_dw3 \
		bootfile_cohr_dw3 bootfile_covdg_ds80 bootfile_cohr_ds80
KERNELS		= kernel_1773 kernel_dw3

ALLOBJS		= $(BOOTFILES) $(KERNELS)

all:	$(ALLOBJS)

bootfile_covdg: $(BOOTFILE_COVDG) $(DEPENDS)
	$(MERGE) $(BOOTFILE_COVDG)>$@

bootfile_cohr: $(BOOTFILE_COHR) $(DEPENDS)
	$(MERGE) $(BOOTFILE_COHR)>$@

bootfile_co80: $(BOOTFILE_CO80) $(DEPENDS)
	$(MERGE) $(BOOTFILE_CO80)>$@

bootfile_covdg_ds80: $(BOOTFILE_COVDG_DS80) $(DEPENDS)
	$(MERGE) $(BOOTFILE_COVDG_DS80)>$@

bootfile_headless_dw3: $(BOOTFILE_HEADLESS_DW3) $(DEPENDS)
	$(MERGE) $(BOOTFILE_HEADLESS_DW3)>$@

bootfile_covdg_dw3: $(BOOTFILE_COVDG_DW3) $(DEPENDS)
	$(MERGE) $(BOOTFILE_COVDG_DW3)>$@

bootfile_cohr_ds80: $(BOOTFILE_COHR_DS80) $(DEPENDS)
	$(MERGE) $(BOOTFILE_COHR_DS80)>$@

bootfile_cohr_dw3: $(BOOTFILE_COHR_DW3) $(DEPENDS)
	$(MERGE) $(BOOTFILE_COHR_DW3)>$@

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

