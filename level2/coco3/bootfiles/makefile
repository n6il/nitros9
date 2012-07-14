include $(NITROS9DIR)/rules.mak

# Module directory
MD		= ../modules
# Commands directory
CD		= ../cmds

DEPENDS		= ./makefile

KERNEL_1773	= $(MD)/rel_80 $(MD)/boot_1773_6ms $(MD)/krn
KERNEL_1773_50HZ	= $(MD)/rel_80_50hz $(MD)/boot_1773_6ms $(MD)/krn
KERNEL_DW3	= $(MD)/rel_80 $(MD)/boot_dw3 $(MD)/krn
KERNEL_BECKER	= $(MD)/rel_80 $(MD)/boot_dw3_becker $(MD)/krn

# NitrOS-9 disk bootfile to allow booting from DriveWire server
# on a DE1 or Xilinx using Gary Becker's CoCo 3 FGPA
BOOTFILE_BECKER	= $(MD)/krnp2 $(MD)/ioman $(MD)/init \
		$(MD)/rbf.mn \
		$(MD)/rbdw3.dr $(MD)/dw3_becker.sb \
		$(MD)/ddx0.dd $(MD)/x1.dd $(MD)/x2.dd $(MD)/x3.dd \
		$(MD)/rb1773.dr $(MD)/d0_40d.dd $(MD)/d1_40d.dd \
		$(MD)/d2_40d.dd $(MD)/ddd0_40d.dd \
		$(MD)/scf.mn $(MD)/vtio.dr \
		$(MD)/keydrv_cc3.sb $(MD)/joydrv_joy.sb $(MD)/snddrv_cc3.sb \
		$(MD)/cowin.io \
		$(MD)/term_win80.dt \
		$(MD)/w.dw $(MD)/w1.dw $(MD)/w2.dw $(MD)/w3.dw $(MD)/w4.dw \
		$(MD)/w5.dw $(MD)/w6.dw $(MD)/w7.dw \
		$(MD)/scdwn.dr \
		$(MD)/n_scdwn.dd $(MD)/n1_scdwn.dd $(MD)/n2_scdwn.dd \
		$(MD)/n3_scdwn.dd $(MD)/n4_scdwn.dd $(MD)/n5_scdwn.dd \
		$(MD)/n6_scdwn.dd $(MD)/n7_scdwn.dd $(MD)/n8_scdwn.dd \
		$(MD)/n9_scdwn.dd $(MD)/n10_scdwn.dd $(MD)/n11_scdwn.dd \
		$(MD)/n12_scdwn.dd $(MD)/n13_scdwn.dd $(MD)/midi_scdwn.dd \
		$(MD)/z1_scdwn.dd $(MD)/z2_scdwn.dd $(MD)/z3_scdwn.dd \
		$(MD)/z4_scdwn.dd $(MD)/z5_scdwn.dd $(MD)/z6_scdwn.dd \
		$(MD)/z7_scdwn.dd \
		$(MD)/scdwp.dr $(MD)/p_scdwp.dd \
		$(MD)/pipeman.mn $(MD)/piper.dr $(MD)/pipe.dd \
		$(MD)/clock_60hz $(MD)/clock2_dw3_becker

# NitrOS-9 disk bootfile to allow booting from DriveWire 3 server
BOOTFILE_DW3	= $(MD)/krnp2 $(MD)/ioman $(MD)/init \
		$(MD)/rbf.mn \
		$(MD)/rbdw3.dr $(MD)/dw3.sb \
		$(MD)/ddx0.dd $(MD)/x1.dd $(MD)/x2.dd $(MD)/x3.dd \
		$(MD)/scf.mn $(MD)/vtio.dr \
		$(MD)/keydrv_cc3.sb $(MD)/joydrv_joy.sb $(MD)/snddrv_cc3.sb \
		$(MD)/cowin.io \
		$(MD)/term_win80.dt \
		$(MD)/w.dw $(MD)/w1.dw $(MD)/w2.dw $(MD)/w3.dw $(MD)/w4.dw \
		$(MD)/w5.dw $(MD)/w6.dw $(MD)/w7.dw \
		$(MD)/scdwn.dr \
		$(MD)/n_scdwn.dd $(MD)/n1_scdwn.dd $(MD)/n2_scdwn.dd \
		$(MD)/n3_scdwn.dd $(MD)/n4_scdwn.dd $(MD)/n5_scdwn.dd \
		$(MD)/n6_scdwn.dd $(MD)/n7_scdwn.dd $(MD)/n8_scdwn.dd \
		$(MD)/n9_scdwn.dd $(MD)/n10_scdwn.dd $(MD)/n11_scdwn.dd \
		$(MD)/n12_scdwn.dd $(MD)/n13_scdwn.dd $(MD)/midi_scdwn.dd \
		$(MD)/z1_scdwn.dd $(MD)/z2_scdwn.dd $(MD)/z3_scdwn.dd \
		$(MD)/z4_scdwn.dd $(MD)/z5_scdwn.dd $(MD)/z6_scdwn.dd \
		$(MD)/z7_scdwn.dd \
		$(MD)/scdwp.dr $(MD)/p_scdwp.dd \
		$(MD)/pipeman.mn $(MD)/piper.dr $(MD)/pipe.dd \
		$(MD)/clock_60hz $(MD)/clock2_dw3

# NitrOS-9 disk bootfile to allow booting from DriveWire 3 server
# Headless mode
BOOTFILE_DW3_HEADLESS	= $(MD)/krnp2 $(MD)/ioman $(MD)/init \
		$(MD)/rbf.mn \
		$(MD)/rbdw3.dr $(MD)/dw3.sb \
		$(MD)/ddx0.dd $(MD)/x1.dd $(MD)/x2.dd $(MD)/x3.dd \
		$(MD)/rb1773.dr $(MD)/d0_40d.dd $(MD)/d1_40d.dd \
		$(MD)/d2_40d.dd $(MD)/ddd0_40d.dd \
		$(MD)/scf.mn $(MD)/vtio.dr \
		$(MD)/scdwn.dr \
		$(MD)/n_scdwn.dd $(MD)/n1_scdwn.dd $(MD)/n2_scdwn.dd \
		$(MD)/n3_scdwn.dd $(MD)/n4_scdwn.dd $(MD)/n5_scdwn.dd \
		$(MD)/n6_scdwn.dd $(MD)/n7_scdwn.dd $(MD)/n8_scdwn.dd \
		$(MD)/n9_scdwn.dd $(MD)/n10_scdwn.dd $(MD)/n11_scdwn.dd \
		$(MD)/n12_scdwn.dd $(MD)/n13_scdwn.dd $(MD)/midi_scdwn.dd \
		$(MD)/scdwp.dr $(MD)/p_scdwp.dd \
		$(MD)/term_z_scdwn.dd \
		$(MD)/z1_scdwn.dd $(MD)/z2_scdwn.dd $(MD)/z3_scdwn.dd \
		$(MD)/z4_scdwn.dd $(MD)/z5_scdwn.dd $(MD)/z6_scdwn.dd \
		$(MD)/z7_scdwn.dd \
		$(MD)/pipeman.mn $(MD)/piper.dr $(MD)/pipe.dd \
		$(MD)/clock_60hz $(MD)/clock2_dw3

# NitrOS-9 disk bootfile to allow booting from WD1773 disk controller
BOOTFILE_40D	= $(MD)/krnp2 $(MD)/ioman $(MD)/init \
		$(MD)/rbf.mn \
		$(MD)/rb1773.dr $(MD)/d0_40d.dd $(MD)/d1_40d.dd \
		$(MD)/d2_40d.dd $(MD)/ddd0_40d.dd \
		$(MD)/scf.mn $(MD)/vtio.dr \
		$(MD)/keydrv_cc3.sb $(MD)/joydrv_joy.sb $(MD)/snddrv_cc3.sb \
		$(MD)/cowin.io $(MD)/covdg.io \
		$(MD)/term_win80.dt \
		$(MD)/w.dw $(MD)/w1.dw $(MD)/w2.dw $(MD)/w3.dw $(MD)/w4.dw \
		$(MD)/w5.dw $(MD)/w6.dw $(MD)/w7.dw \
		$(MD)/pipeman.mn $(MD)/piper.dr $(MD)/pipe.dd \
		$(MD)/clock_60hz $(MD)/clock2_soft

BOOTFILE_80D	= $(MD)/krnp2 $(MD)/ioman $(MD)/init \
		$(MD)/rbf.mn \
		$(MD)/rb1773.dr $(MD)/d0_80d.dd $(MD)/d1_40d.dd \
		$(MD)/d2_40d.dd $(MD)/ddd0_80d.dd \
		$(MD)/scf.mn $(MD)/vtio.dr \
		$(MD)/keydrv_cc3.sb $(MD)/joydrv_joy.sb $(MD)/snddrv_cc3.sb \
		$(MD)/cowin.io $(MD)/covdg.io \
		$(MD)/term_win80.dt \
		$(MD)/w.dw $(MD)/w1.dw $(MD)/w2.dw $(MD)/w3.dw $(MD)/w4.dw \
		$(MD)/w5.dw $(MD)/w6.dw $(MD)/w7.dw \
		$(MD)/pipeman.mn $(MD)/piper.dr $(MD)/pipe.dd \
		$(MD)/clock_60hz $(MD)/clock2_soft

BOOTFILE_40D_50HZ	= $(MD)/krnp2 $(MD)/ioman $(MD)/init \
		$(MD)/rbf.mn \
		$(MD)/rb1773.dr $(MD)/d0_40d.dd $(MD)/d1_40d.dd \
		$(MD)/d2_40d.dd $(MD)/ddd0_40d.dd \
		$(MD)/scf.mn $(MD)/vtio.dr \
		$(MD)/keydrv_cc3.sb $(MD)/joydrv_joy.sb $(MD)/snddrv_cc3.sb \
		$(MD)/cowin.io $(MD)/covdg.io \
		$(MD)/term_win80.dt \
		$(MD)/w.dw $(MD)/w1.dw $(MD)/w2.dw $(MD)/w3.dw $(MD)/w4.dw \
		$(MD)/w5.dw $(MD)/w6.dw $(MD)/w7.dw \
		$(MD)/pipeman.mn $(MD)/piper.dr $(MD)/pipe.dd \
		$(MD)/clock_50hz $(MD)/clock2_soft

BOOTFILE_80D_50HZ	= $(MD)/krnp2 $(MD)/ioman $(MD)/init \
		$(MD)/rbf.mn \
		$(MD)/rb1773.dr $(MD)/d0_80d.dd $(MD)/d1_40d.dd \
		$(MD)/d2_40d.dd $(MD)/ddd0_80d.dd \
		$(MD)/scf.mn $(MD)/vtio.dr \
		$(MD)/keydrv_cc3.sb $(MD)/joydrv_joy.sb $(MD)/snddrv_cc3.sb \
		$(MD)/cowin.io $(MD)/covdg.io \
		$(MD)/term_win80.dt \
		$(MD)/w.dw $(MD)/w1.dw $(MD)/w2.dw $(MD)/w3.dw $(MD)/w4.dw \
		$(MD)/w5.dw $(MD)/w6.dw $(MD)/w7.dw \
		$(MD)/pipeman.mn $(MD)/piper.dr $(MD)/pipe.dd \
		$(MD)/clock_50hz $(MD)/clock2_soft

BOOTFILES	= bootfile_40d bootfile_40d_50hz bootfile_80d bootfile_80d_50hz bootfile_dw3 bootfile_dw3_headless bootfile_becker
KERNELS		= kernel_1773 kernel_1773_50hz kernel_dw3 kernel_becker

ALLOBJS		= $(BOOTFILES) $(KERNELS)

all:	$(ALLOBJS)

# Bootfiles
bootfile_becker: $(BOOTFILE_BECKER) $(DEPENDS)
	$(MERGE) $(BOOTFILE_BECKER)>$@

bootfile_40d: $(BOOTFILE_40D) $(DEPENDS)
	$(MERGE) $(BOOTFILE_40D)>$@

bootfile_40d_50hz: $(BOOTFILE_40D_50HZ) $(DEPENDS)
	$(MERGE) $(BOOTFILE_40D_50HZ)>$@

bootfile_80d: $(BOOTFILE_80D) $(DEPENDS)
	$(MERGE) $(BOOTFILE_80D)>$@

bootfile_80d_50hz: $(BOOTFILE_80D_50HZ) $(DEPENDS)
	$(MERGE) $(BOOTFILE_80D_50HZ)>$@

bootfile_dw3: $(BOOTFILE_DW3) $(DEPENDS)
	$(MERGE) $(BOOTFILE_DW3)>$@

bootfile_dw3_headless: $(BOOTFILE_DW3_HEADLESS) $(DEPENDS)
	$(MERGE) $(BOOTFILE_DW3_HEADLESS)>$@

# Kernels
kernel_becker: $(KERNEL_BECKER) $(DEPENDS)
	$(MERGE) $(KERNEL_BECKER)>$@

kernel_1773: $(KERNEL_1773) $(DEPENDS)
	$(MERGE) $(KERNEL_1773)>$@

kernel_1773_50hz: $(KERNEL_1773_50HZ) $(DEPENDS)
	$(MERGE) $(KERNEL_1773_50HZ)>$@

kernel_dw3: $(KERNEL_DW3) $(DEPENDS)
	$(MERGE) $(KERNEL_DW3)>$@

clean:
	$(RM) $(ALLOBJS)

