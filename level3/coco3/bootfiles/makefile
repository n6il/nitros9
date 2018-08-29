include $(NITROS9DIR)/rules.mak

# Module directory
MD		= ../modules

DEPENDS		= ./makefile

KERNEL_1773	= $(MD)/rel_80 $(MD)/boot_1773_6ms $(MD)/krn
KERNEL_1773_50HZ	= $(MD)/rel_80_50hz $(MD)/boot_1773_6ms $(MD)/krn
KERNEL_DW	= $(MD)/rel_80 $(MD)/boot_dw $(MD)/krn

# NitrOS-9 disk bootfile to allow booting from WD1773 disk controller
BOOTFILE_40D	= $(MD)/nitro \
		$(MD)/scf.mn \
		$(MD)/end \
		$(MD)/rbf.mn \
		$(MD)/rb1773.dr \
		$(MD)/end \
		$(MD)/krnp2 $(MD)/ioman $(MD)/init \
		$(MD)/d0_40d.dd $(MD)/d1_40d.dd \
		$(MD)/d2_40d.dd $(MD)/ddd0_40d.dd \
		$(MD)/vtio.dr \
		$(MD)/keydrv_cc3.sb $(MD)/joydrv_joy.sb $(MD)/snddrv_cc3.sb \
		$(MD)/cowin.io $(MD)/covdg.io \
		$(MD)/term_win80.dt \
		$(MD)/w.dw $(MD)/w1.dw $(MD)/w2.dw $(MD)/w3.dw $(MD)/w4.dw \
		$(MD)/w5.dw $(MD)/w6.dw $(MD)/w7.dw \
		$(MD)/pipeman.mn $(MD)/piper.dr $(MD)/pipe.dd \
		$(MD)/clock_60hz $(MD)/clock2_soft

BOOTFILE_80D	= $(MD)/nitro \
		$(MD)/scf.mn \
		$(MD)/end \
		$(MD)/rbf.mn \
		$(MD)/rb1773.dr \
		$(MD)/end \
		$(MD)/krnp2 $(MD)/ioman $(MD)/init \
		$(MD)/d0_80d.dd $(MD)/d1_40d.dd \
		$(MD)/d2_40d.dd $(MD)/ddd0_80d.dd \
		$(MD)/vtio.dr \
		$(MD)/keydrv_cc3.sb $(MD)/joydrv_joy.sb $(MD)/snddrv_cc3.sb \
		$(MD)/cowin.io $(MD)/covdg.io \
		$(MD)/term_win80.dt \
		$(MD)/w.dw $(MD)/w1.dw $(MD)/w2.dw $(MD)/w3.dw $(MD)/w4.dw \
		$(MD)/w5.dw $(MD)/w6.dw $(MD)/w7.dw \
		$(MD)/pipeman.mn $(MD)/piper.dr $(MD)/pipe.dd \
		$(MD)/clock_60hz $(MD)/clock2_soft

BOOTFILE_40D_50HZ	= $(MD)/nitro \
		$(MD)/scf.mn \
		$(MD)/end \
		$(MD)/rbf.mn \
		$(MD)/rb1773.dr \
		$(MD)/end \
		$(MD)/krnp2 $(MD)/ioman $(MD)/init \
		$(MD)/d0_40d.dd $(MD)/d1_40d.dd \
		$(MD)/d2_40d.dd $(MD)/ddd0_40d.dd \
		$(MD)/vtio.dr \
		$(MD)/keydrv_cc3.sb $(MD)/joydrv_joy.sb $(MD)/snddrv_cc3.sb \
		$(MD)/cowin.io $(MD)/covdg.io \
		$(MD)/term_win80.dt \
		$(MD)/w.dw $(MD)/w1.dw $(MD)/w2.dw $(MD)/w3.dw $(MD)/w4.dw \
		$(MD)/w5.dw $(MD)/w6.dw $(MD)/w7.dw \
		$(MD)/pipeman.mn $(MD)/piper.dr $(MD)/pipe.dd \
		$(MD)/clock_50hz $(MD)/clock2_soft

BOOTFILE_80D_50HZ 	= $(MD)/nitro \
		$(MD)/scf.mn \
		$(MD)/end \
		$(MD)/rbf.mn \
		$(MD)/rb1773.dr \
		$(MD)/end \
		$(MD)/krnp2 $(MD)/ioman $(MD)/init \
		$(MD)/d0_80d.dd $(MD)/d1_40d.dd \
		$(MD)/d2_40d.dd $(MD)/ddd0_80d.dd \
		$(MD)/vtio.dr \
		$(MD)/keydrv_cc3.sb $(MD)/joydrv_joy.sb $(MD)/snddrv_cc3.sb \
		$(MD)/cowin.io $(MD)/covdg.io \
		$(MD)/term_win80.dt \
		$(MD)/w.dw $(MD)/w1.dw $(MD)/w2.dw $(MD)/w3.dw $(MD)/w4.dw \
		$(MD)/w5.dw $(MD)/w6.dw $(MD)/w7.dw \
		$(MD)/pipeman.mn $(MD)/piper.dr $(MD)/pipe.dd \
		$(MD)/clock_50hz $(MD)/clock2_soft

BOOTFILE_DW	= $(MD)/nitro \
		$(MD)/scf.mn \
		$(MD)/end \
		$(MD)/rbf.mn \
		$(MD)/rb1773.dr \
		$(MD)/end \
		$(MD)/krnp2 $(MD)/ioman $(MD)/init \
		$(MD)/d0_80d.dd $(MD)/d1_40d.dd \
		$(MD)/d2_40d.dd $(MD)/ddd0_80d.dd \
		$(MD)/vtio.dr \
		$(MD)/keydrv_cc3.sb $(MD)/joydrv_joy.sb $(MD)/snddrv_cc3.sb \
		$(MD)/cowin.io $(MD)/covdg.io \
		$(MD)/term_win80.dt \
		$(MD)/w.dw $(MD)/w1.dw $(MD)/w2.dw $(MD)/w3.dw $(MD)/w4.dw \
		$(MD)/w5.dw $(MD)/w6.dw $(MD)/w7.dw \
		$(MD)/pipeman.mn $(MD)/piper.dr $(MD)/pipe.dd \
		$(MD)/clock_60hz $(MD)/clock2_soft

BOOTFILES	= bootfile_40d bootfile_40d_50hz bootfile_80d bootfile_80d_50hz bootfile_dw
KERNELS		= kernel_1773 kernel_1773_50hz kernel_dw

ALLOBJS		= $(BOOTFILES) $(KERNELS)

all:	$(ALLOBJS)

# Bootfiles
bootfile_40d: $(BOOTFILE_40D) $(DEPENDS)
	$(MERGE) $(BOOTFILE_40D)>$@

bootfile_40d_50hz: $(BOOTFILE_40D_50HZ) $(DEPENDS)
	$(MERGE) $(BOOTFILE_40D_50HZ)>$@

bootfile_80d: $(BOOTFILE_80D) $(DEPENDS)
	$(MERGE) $(BOOTFILE_80D)>$@

bootfile_80d_50hz: $(BOOTFILE_80D_50HZ) $(DEPENDS)
	$(MERGE) $(BOOTFILE_80D_50HZ)>$@

bootfile_dw: $(BOOTFILE_DW) $(DEPENDS)
	$(MERGE) $(BOOTFILE_DW)>$@

# Kernels
kernel_1773: $(KERNEL_1773) $(DEPENDS)
	$(MERGE) $(KERNEL_1773)>$@

kernel_1773_50hz: $(KERNEL_1773_50HZ) $(DEPENDS)
	$(MERGE) $(KERNEL_1773_50HZ)>$@

kernel_dw: $(KERNEL_DW) $(DEPENDS)
	$(MERGE) $(KERNEL_DW)>$@

clean:
	$(RM) $(ALLOBJS)

