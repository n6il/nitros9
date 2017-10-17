include ../port.mak

# Module directory
MD		= ../modules
# Commands directory
CMDSDIR		= ../cmds

DEPENDS		= ./makefile

KERNEL_1773	= $(MD)/rel $(MD)/krn $(MD)/krnp2 $(MD)/init \
		$(MD)/boot_1773_6ms

ifdef DW_BAUD38400
KERNEL_DW	= $(MD)/rel $(MD)/krn $(MD)/krnp2 $(MD)/init \
		$(MD)/boot_dw_38400
else
KERNEL_DW	= $(MD)/rel $(MD)/krn $(MD)/krnp2 $(MD)/init \
		$(MD)/boot_dw
endif

KERNEL_BECKER	= $(MD)/rel $(MD)/krn $(MD)/krnp2 $(MD)/init \
		$(MD)/boot_dw_becker

KERNEL_ARDUINO	= $(MD)/rel $(MD)/krn $(MD)/krnp2 $(MD)/init \
		$(MD)/boot_dw_arduino

KERNEL_COCOSDC	= $(MD)/rel $(MD)/krn $(MD)/krnp2 $(MD)/init \
		$(MD)/boot_sdc

IDE		= $(3PD)/ide
SCSI		= $(3PD)/scsisys

FLOPPY_40D	= $(MD)/rb1773.dr $(MD)/d0_40d.dd $(MD)/d1_40d.dd $(MD)/d2_40d.dd 

FLOPPY_80D	= $(MD)/rb1773.dr $(MD)/d0_40d.dd $(MD)/d1_40d.dd $(MD)/d2_40d.dd 

VTIO_COVDG	= $(MD)/vtio.dr $(MD)/covdg.io $(MD)/term_vdg.dt
VTIO_COHR	= $(MD)/vtio.dr $(MD)/cohr.io $(MD)/term_hr.dt
VTIO_CO80	= $(MD)/vtio.dr $(MD)/co80.io $(MD)/term_80.dt
VTIO_COVGA	= $(MD)/vtio.dr $(MD)/covga.io $(MD)/term_vga.dt
PIPE		= $(MD)/pipeman.mn $(MD)/piper.dr $(MD)/pipe.dd
CLOCK60HZ	= $(MD)/clock_60hz $(MD)/clock2_soft
CLOCK60HZDW	= $(MD)/clock_60hz $(MD)/clock2_dw
ifdef DW_BAUD38400
RBDW		= $(MD)/rbdw.dr $(MD)/dwio_38400.sb \
		$(MD)/x1.dd $(MD)/x2.dd $(MD)/x3.dd
else
RBDW		= $(MD)/rbdw.dr $(MD)/dwio.sb \
		$(MD)/x1.dd $(MD)/x2.dd $(MD)/x3.dd
endif
RBBECKER	= $(MD)/rbdw.dr $(MD)/dwio_becker.sb \
		$(MD)/x1.dd $(MD)/x2.dd $(MD)/x3.dd

RBARDUINO	= $(MD)/rbdw.dr $(MD)/dwio_arduino.sb \
		$(MD)/x1.dd $(MD)/x2.dd $(MD)/x3.dd

RBCOCOSDC	= $(MD)/rbsuper.dr $(MD)/llcocosdc.dr \
		$(MD)/sd0_cocosdc.dd $(MD)/sd1_cocosdc.dd

SCDWV_NET  = $(MD)/n_scdwv.dd $(MD)/n1_scdwv.dd $(MD)/n2_scdwv.dd \
		$(MD)/n3_scdwv.dd $(MD)/n4_scdwv.dd $(MD)/n5_scdwv.dd \
		$(MD)/n6_scdwv.dd $(MD)/n7_scdwv.dd $(MD)/n8_scdwv.dd \
		$(MD)/n9_scdwv.dd $(MD)/n10_scdwv.dd $(MD)/n11_scdwv.dd \
		$(MD)/n12_scdwv.dd $(MD)/n13_scdwv.dd $(MD)/midi_scdwv.dd
SCDWV_WIN  = $(MD)/z1_scdwv.dd $(MD)/z2_scdwv.dd $(MD)/z3_scdwv.dd \
		$(MD)/z4_scdwv.dd $(MD)/z5_scdwv.dd $(MD)/z6_scdwv.dd \
		$(MD)/z7_scdwv.dd 
SCDWP     = $(MD)/scdwp.dr $(MD)/p_scdwp.dd

BOOTFILE_COVDG	= $(MD)/ioman \
		$(MD)/rbf.mn \
		$(FLOPPY_40D) \
		$(MD)/ddd0_40d.dd \
		$(MD)/scf.mn \
		$(VTIO_COVDG) \
		$(MD)/scbbp.dr $(MD)/p_scbbp.dd \
		$(MD)/scbbt.dr $(MD)/t1_scbbt.dd \
		$(PIPE) \
		$(CLOCK60HZ) \
		$(MD)/sysgo_dd

BOOTFILE_COHR	= $(MD)/ioman \
		$(MD)/rbf.mn \
		$(FLOPPY_40D) \
		$(MD)/ddd0_40d.dd \
		$(MD)/scf.mn \
		$(VTIO_COHR) \
		$(MD)/scbbp.dr $(MD)/p_scbbp.dd \
		$(MD)/scbbt.dr $(MD)/t1_scbbt.dd \
		$(PIPE) \
		$(CLOCK60HZ) \
		$(MD)/sysgo_dd

BOOTFILE_CO80	= $(MD)/ioman \
		$(MD)/rbf.mn \
		$(FLOPPY_40D) \
		$(MD)/ddd0_40d.dd \
		$(MD)/scf.mn \
		$(VTIO_CO80) \
		$(MD)/scbbp.dr $(MD)/p_scbbp.dd \
		$(MD)/scbbt.dr $(MD)/t1_scbbt.dd \
		$(PIPE) \
		$(CLOCK60HZ) \
		$(MD)/sysgo_dd

BOOTFILE_COVGA	= $(MD)/ioman \
		$(MD)/rbf.mn \
		$(FLOPPY_40D) \
		$(MD)/ddd0_40d.dd \
		$(MD)/scf.mn \
		$(VTIO_COVGA) \
		$(MD)/scbbp.dr $(MD)/p_scbbp.dd \
		$(MD)/scbbt.dr $(MD)/t1_scbbt.dd \
		$(PIPE) \
		$(CLOCK60HZ) \
		$(MD)/sysgo_dd

BOOTFILE_DW_HEADLESS	= $(MD)/ioman \
		$(MD)/rbf.mn \
		$(RBDW) \
		$(MD)/ddx0.dd \
		$(MD)/scf.mn \
		$(MD)/scdwv.dr \
		$(MD)/term_scdwv.dt \
		$(SCDWV_NET) \
		$(SCDWV_WIN) \
		$(SCDWP) \
		$(CLOCK60HZDW) \
		$(MD)/sysgo_dd

BOOTFILE_BECKER_HEADLESS	= $(MD)/ioman \
		$(MD)/rbf.mn \
		$(RBBECKER) \
		$(MD)/ddx0.dd \
		$(MD)/scf.mn \
		$(MD)/scdwv.dr \
		$(MD)/term_scdwv.dt \
		$(SCDWV_NET) \
		$(SCDWV_WIN) \
		$(SCDWP) \
		$(CLOCK60HZDW) \
		$(MD)/sysgo_dd

BOOTFILE_ARDUINO_HEADLESS	= $(MD)/ioman \
		$(MD)/rbf.mn \
		$(RBARDUINO) \
		$(MD)/ddx0.dd \
		$(MD)/scf.mn \
		$(MD)/scdwv.dr \
		$(MD)/term_scdwv.dt \
		$(SCDWV_NET) \
		$(SCDWV_WIN) \
		$(SCDWP) \
		$(CLOCK60HZDW) \
		$(MD)/sysgo_dd

BOOTFILE_COVDG_DW	= $(MD)/ioman \
		$(MD)/rbf.mn \
		$(FLOPPY_40D) \
		$(RBDW) \
		$(MD)/ddx0.dd \
		$(MD)/scf.mn \
		$(VTIO_COVDG) \
		$(MD)/scdwv.dr \
		$(SCDWV_NET) \
		$(SCDWV_WIN) \
		$(SCDWP) \
		$(PIPE) \
		$(CLOCK60HZDW) \
		$(MD)/sysgo_dd

BOOTFILE_COVGA_DW	= $(MD)/ioman \
		$(MD)/rbf.mn \
		$(FLOPPY_40D) \
		$(RBDW) \
		$(MD)/ddx0.dd \
		$(MD)/scf.mn \
		$(VTIO_COVGA) \
		$(MD)/scdwv.dr \
		$(SCDWV_NET) \
		$(SCDWV_WIN) \
		$(SCDWP) \
		$(PIPE) \
		$(CLOCK60HZDW) \
		$(MD)/sysgo_dd

BOOTFILE_COVDG_DW_GAME	= $(MD)/ioman \
		$(MD)/rbf.mn \
		$(RBDW) \
		$(MD)/ddx0.dd \
		$(MD)/scf.mn \
		$(VTIO_COVDG) \
		$(PIPE) \
		$(CLOCK60HZDW) \
		$(MD)/sysgo_dd \
		$(CMDSDIR)/shell_21

BOOTFILE_COVDG_BECKER	= $(MD)/ioman \
		$(MD)/rbf.mn \
		$(RBBECKER) \
		$(FLOPPY_40D) \
		$(MD)/ddx0.dd \
		$(MD)/scf.mn \
		$(VTIO_COVDG) \
		$(MD)/scdwv.dr \
		$(SCDWV_NET) \
		$(SCDWV_WIN) \
		$(SCDWP) \
		$(PIPE) \
		$(CLOCK60HZDW) \
		$(MD)/sysgo_dd

BOOTFILE_COVDG_BECKER_GAME	= $(MD)/ioman \
		$(MD)/rbf.mn \
		$(RBBECKER) \
		$(MD)/ddx0.dd \
		$(MD)/scf.mn \
		$(VTIO_COVDG) \
		$(PIPE) \
		$(CLOCK60HZDW) \
		$(MD)/sysgo_dd \
		$(CMDSDIR)/shell_21

BOOTFILE_COVDG_ARDUINO	= $(MD)/ioman \
		$(MD)/rbf.mn \
		$(FLOPPY_40D) \
		$(RBARDUINO) \
		$(MD)/ddx0.dd \
		$(MD)/scf.mn \
		$(VTIO_COVDG) \
		$(MD)/scdwv.dr \
		$(SCDWV_NET) \
		$(SCDWV_WIN) \
		$(SCDWP) \
		$(PIPE) \
		$(CLOCK60HZDW) \
		$(MD)/sysgo_dd
		
BOOTFILE_COVDG_ARDUINO_GAME	= $(MD)/ioman \
		$(MD)/rbf.mn \
		$(RBARDUINO) \
		$(MD)/ddx0.dd \
		$(MD)/scf.mn \
		$(VTIO_COVDG) \
		$(PIPE) \
		$(CLOCK60HZDW) \
		$(MD)/sysgo_dd \
		$(CMDSDIR)/shell_21
		
BOOTFILE_COVDG_DS80	= $(MD)/ioman \
		$(MD)/rbf.mn \
		$(FLOPPY_80D) \
		$(MD)/ddd0_80d.dd \
		$(MD)/scf.mn \
		$(VTIO_COVDG) \
		$(MD)/scbbp.dr $(MD)/p_scbbp.dd \
		$(MD)/scbbt.dr $(MD)/t1_scbbt.dd \
		$(PIPE) \
		$(CLOCK60HZ) \
		$(MD)/sysgo_dd

BOOTFILE_COVDG_COCOSDC	= $(MD)/ioman \
		$(MD)/rbf.mn \
		$(RBCOCOSDC) \
		$(MD)/ddsd0_cocosdc.dd \
		$(FLOPPY_40D) \
		$(MD)/scf.mn \
		$(VTIO_COVDG) \
		$(MD)/scbbp.dr $(MD)/p_scbbp.dd \
		$(MD)/scbbt.dr $(MD)/t1_scbbt.dd \
		$(PIPE) \
		$(CLOCK60HZ) \
		$(MD)/sysgo_dd

BOOTFILE_COVDG_COCOSDC_GAME	= $(MD)/ioman \
		$(MD)/rbf.mn \
		$(RBCOCOSDC) \
		$(MD)/ddsd0_cocosdc.dd \
		$(MD)/scf.mn \
		$(VTIO_COVDG) \
		$(PIPE) \
		$(CLOCK60HZ) \
		$(MD)/sysgo_dd \
		$(CMDSDIR)/shell_21

BOOTFILE_COHR_DW	= $(MD)/ioman \
		$(MD)/rbf.mn \
		$(FLOPPY_40D) \
		$(RBDW) \
		$(MD)/ddx0.dd \
		$(MD)/scf.mn \
		$(VTIO_COHR) \
		$(MD)/scdwv.dr \
		$(SCDWV_NET) \
		$(SCDWP)\
		$(PIPE) \
		$(CLOCK60HZDW) \
		$(MD)/sysgo_dd

BOOTFILE_COHR_BECKER	= $(MD)/ioman \
		$(MD)/rbf.mn \
		$(FLOPPY_40D) \
		$(RBBECKER) \
		$(MD)/ddx0.dd \
		$(MD)/scf.mn \
		$(VTIO_COHR) \
		$(MD)/scdwv.dr \
		$(SCDWV_NET) \
		$(SCDWP) \
		$(PIPE) \
		$(CLOCK60HZDW) \
		$(MD)/sysgo_dd

BOOTFILE_COHR_ARDUINO	= $(MD)/ioman \
		$(MD)/rbf.mn \
		$(FLOPPY_40D) \
		$(RBARDUINO) \
		$(MD)/ddx0.dd \
		$(MD)/scf.mn \
		$(VTIO_COHR) \
		$(MD)/scdwv.dr \
		$(SCDWV_NET) \
		$(SCDWP) \
		$(PIPE) \
		$(CLOCK60HZDW) \
		$(MD)/sysgo_dd

BOOTFILE_COHR_DS80	= $(MD)/ioman \
		$(MD)/rbf.mn \
		$(FLOPPY_80D) \
		$(MD)/ddd0_80d.dd \
		$(MD)/scf.mn \
		$(VTIO_CO80) \
		$(MD)/scbbp.dr $(MD)/p_scbbp.dd \
		$(MD)/scbbt.dr $(MD)/t1_scbbt.dd \
		$(PIPE) \
		$(CLOCK60HZ) \
		$(MD)/sysgo_dd

BOOTFILES	= bootfile_covdg bootfile_cohr bootfile_covdg_dw \
		bootfile_covga_dw \
		bootfile_dw_headless bootfile_covdg_becker \
		bootfile_covdg_becker_game bootfile_covdg_dw_game \
		bootfile_covdg_cocosdc bootfile_covdg_cocosdc_game \
		bootfile_cohr_dw bootfile_covdg_ds80 bootfile_cohr_ds80 \
		bootfile_cohr_becker bootfile_becker_headless \
		bootfile_covdg_arduino bootfile_arduino_headless \
		bootfile_cohr_arduino bootfile_covdg_arduino_game 

KERNELS		= kernel_1773 kernel_dw kernel_becker kernel_arduino kernel_cocosdc

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

bootfile_dw_headless: $(BOOTFILE_DW_HEADLESS) $(DEPENDS)
	$(MERGE) $(BOOTFILE_DW_HEADLESS)>$@

bootfile_becker_headless: $(BOOTFILE_BECKER_HEADLESS) $(DEPENDS)
	$(MERGE) $(BOOTFILE_BECKER_HEADLESS)>$@

bootfile_arduino_headless: $(BOOTFILE_ARDUINO_HEADLESS) $(DEPENDS)
	$(MERGE) $(BOOTFILE_ARDUINO_HEADLESS)>$@

bootfile_covdg_dw: $(BOOTFILE_COVDG_DW) $(DEPENDS)
	$(MERGE) $(BOOTFILE_COVDG_DW)>$@

bootfile_covga_dw: $(BOOTFILE_COVGA_DW) $(DEPENDS)
	$(MERGE) $(BOOTFILE_COVGA_DW)>$@

bootfile_covdg_dw_game: $(BOOTFILE_COVDG_DW_GAME) $(DEPENDS)
	$(MERGE) $(BOOTFILE_COVDG_DW_GAME)>$@

bootfile_covdg_becker: $(BOOTFILE_COVDG_BECKER) $(DEPENDS)
	$(MERGE) $(BOOTFILE_COVDG_BECKER)>$@

bootfile_covdg_becker_game: $(BOOTFILE_COVDG_BECKER_GAME) $(DEPENDS)
	$(MERGE) $(BOOTFILE_COVDG_BECKER_GAME)>$@

bootfile_covdg_arduino: $(BOOTFILE_COVDG_ARDUINO) $(DEPENDS)
	$(MERGE) $(BOOTFILE_COVDG_ARDUINO)>$@

bootfile_covdg_arduino_game: $(BOOTFILE_COVDG_ARDUINO_GAME) $(DEPENDS)
	$(MERGE) $(BOOTFILE_COVDG_ARDUINO_GAME)>$@

bootfile_covdg_cocosdc: $(BOOTFILE_COVDG_COCOSDC) $(DEPENDS)
	$(MERGE) $(BOOTFILE_COVDG_COCOSDC)>$@

bootfile_covdg_cocosdc_game: $(BOOTFILE_COVDG_COCOSDC_GAME) $(DEPENDS)
	$(MERGE) $(BOOTFILE_COVDG_COCOSDC_GAME)>$@

bootfile_cohr_ds80: $(BOOTFILE_COHR_DS80) $(DEPENDS)
	$(MERGE) $(BOOTFILE_COHR_DS80)>$@

bootfile_cohr_dw: $(BOOTFILE_COHR_DW) $(DEPENDS)
	$(MERGE) $(BOOTFILE_COHR_DW)>$@

bootfile_cohr_becker: $(BOOTFILE_COHR_BECKER) $(DEPENDS)
	$(MERGE) $(BOOTFILE_COHR_BECKER)>$@

bootfile_cohr_arduino: $(BOOTFILE_COHR_ARDUINO) $(DEPENDS)
	$(MERGE) $(BOOTFILE_COHR_ARDUINO)>$@

# WD1773 Kernel
kernel_1773: $(KERNEL_1773) $(DEPENDS)
	$(MERGE) $(KERNEL_1773)>$@
	$(PADROM) 4608 $@

# DriveWire 3 Kernel
kernel_dw: $(KERNEL_DW) $(DEPENDS)
	$(MERGE) $(KERNEL_DW)>$@
	$(PADROM) 4608 $@

kernel_becker: $(KERNEL_BECKER) $(DEPENDS)
	$(MERGE) $(KERNEL_BECKER)>$@
	$(PADROM) 4608 $@

kernel_arduino: $(KERNEL_ARDUINO) $(DEPENDS)
	$(MERGE) $(KERNEL_ARDUINO)>$@
	$(PADROM) 4608 $@

kernel_cocosdc: $(KERNEL_COCOSDC) $(DEPENDS) 
	$(MERGE) $(KERNEL_COCOSDC)>$@
	$(PADROM) 4608 $@

clean:
	$(RM) $(ALLOBJS)
