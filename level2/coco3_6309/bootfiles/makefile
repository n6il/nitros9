include ../../rules.mak

# Module directory
MD		= ../modules
# Commands directory
CD		= ../cmds

DEPENDS		= ./makefile

KERNEL_1773	= $(MD)/rel_80 $(MD)/boot_1773_6ms $(MD)/krn

# OS-9 disk bootfile to allow booting from WD1773 disk controller
BOOTFILE_VDG	= $(MD)/krnp2 $(MD)/ioman $(MD)/init \
		$(MD)/rbf.mn \
		$(MD)/rb1773.dr $(MD)/d0_40d.dd $(MD)/d1_40d.dd \
		$(MD)/ddd0_40d.dd \
		$(MD)/scf.mn $(MD)/cc3io.dr \
		$(MD)/keydrv_cc3.sb $(MD)/joydrv_joy.sb $(MD)/snddrv_cc3.sb \
		$(MD)/windint.io $(MD)/vdgint.io \
		$(MD)/term_vdg.dt \
		$(MD)/w.dw $(MD)/w1.dw $(MD)/w2.dw $(MD)/w3.dw $(MD)/w4.dw \
		$(MD)/w5.dw $(MD)/w6.dw $(MD)/w7.dw \
		$(MD)/pipeman.mn $(MD)/piper.dr $(MD)/pipe.dd \
		$(MD)/clock_60hz $(MD)/clock2_soft

BOOTFILE_WIN40	= $(MD)/krnp2 $(MD)/ioman $(MD)/init \
		$(MD)/rbf.mn \
		$(MD)/rb1773.dr $(MD)/d0_40d.dd $(MD)/d1_40d.dd \
		$(MD)/ddd0_40d.dd \
		$(MD)/scf.mn $(MD)/cc3io.dr \
		$(MD)/keydrv_cc3.sb $(MD)/joydrv_joy.sb $(MD)/snddrv_cc3.sb \
		$(MD)/windint.io $(MD)/vdgint.io \
		$(MD)/term_win40.dt \
		$(MD)/w.dw $(MD)/w1.dw $(MD)/w2.dw $(MD)/w3.dw $(MD)/w4.dw \
		$(MD)/w5.dw $(MD)/w6.dw $(MD)/w7.dw \
		$(MD)/pipeman.mn $(MD)/piper.dr $(MD)/pipe.dd \
		$(MD)/clock_60hz $(MD)/clock2_soft

BOOTFILE_WIN80	= $(MD)/krnp2 $(MD)/ioman $(MD)/init \
		$(MD)/rbf.mn \
		$(MD)/rb1773.dr $(MD)/d0_40d.dd $(MD)/d1_40d.dd \
		$(MD)/ddd0_40d.dd \
		$(MD)/scf.mn $(MD)/cc3io.dr \
		$(MD)/keydrv_cc3.sb $(MD)/joydrv_joy.sb $(MD)/snddrv_cc3.sb \
		$(MD)/windint.io $(MD)/vdgint.io \
		$(MD)/term_win80.dt \
		$(MD)/w.dw $(MD)/w1.dw $(MD)/w2.dw $(MD)/w3.dw $(MD)/w4.dw \
		$(MD)/w5.dw $(MD)/w6.dw $(MD)/w7.dw \
		$(MD)/pipeman.mn $(MD)/piper.dr $(MD)/pipe.dd \
		$(MD)/clock_60hz $(MD)/clock2_soft

BOOTFILES	= bootfile_vdg bootfile_win40 bootfile_win80 \
		bootfile_vdg_ds80 bootfile_win40_ds80 bootfile_win80_ds80
KERNELS		= kernel_1773

ALLOBJS		= $(BOOTFILES) $(KERNELS)

all:	$(ALLOBJS)

# Bootfiles
bootfile_vdg: $(BOOTFILE_VDG) $(DEPENDS)
	$(MERGE) $(BOOTFILE_VDG)>$@

bootfile_win40: $(BOOTFILE_WIN40) $(DEPENDS)
	$(MERGE) $(BOOTFILE_WIN40)>$@

bootfile_win80: $(BOOTFILE_WIN80) $(DEPENDS)
	$(MERGE) $(BOOTFILE_WIN80)>$@

bootfile_vdg_ds80: $(BOOTFILE_VDG_DS80) $(DEPENDS)
	$(MERGE) $(BOOTFILE_VDG_DS80)>$@

bootfile_win40_ds80: $(BOOTFILE_WIN40_DS80) $(DEPENDS)
	$(MERGE) $(BOOTFILE_WIN40_DS80)>$@

bootfile_win80_ds80: $(BOOTFILE_WIN80_DS80) $(DEPENDS)
	$(MERGE) $(BOOTFILE_WIN80_DS80)>$@

# Kernels
kernel_1773: $(KERNEL_1773) $(DEPENDS)
	$(MERGE) $(KERNEL_1773)>$@

clean:
	$(RM) $(ALLOBJS)

# OS-9 disk bootfile to allow booting from WD1773 disk controller
BOOTFILE_VDG_DS80	= $(MD)/krnp2 $(MD)/ioman $(MD)/init \
		$(MD)/rbf.mn \
		$(MD)/rb1773.dr $(MD)/d0_80d.dd $(MD)/d1_40d.dd \
		$(MD)/ddd0_80d.dd \
		$(MD)/scf.mn $(MD)/cc3io.dr \
		$(MD)/keydrv_cc3.sb $(MD)/joydrv_joy.sb $(MD)/snddrv_cc3.sb \
		$(MD)/windint.io $(MD)/vdgint.io \
		$(MD)/term_vdg.dt \
		$(MD)/w.dw $(MD)/w1.dw $(MD)/w2.dw $(MD)/w3.dw $(MD)/w4.dw \
		$(MD)/w5.dw $(MD)/w6.dw $(MD)/w7.dw \
		$(MD)/pipeman.mn $(MD)/piper.dr $(MD)/pipe.dd \
		$(MD)/clock_60hz $(MD)/clock2_soft

BOOTFILE_WIN40_DS80	= $(MD)/krnp2 $(MD)/ioman $(MD)/init \
		$(MD)/rbf.mn \
		$(MD)/rb1773.dr $(MD)/d0_80d.dd $(MD)/d1_40d.dd \
		$(MD)/ddd0_80d.dd \
		$(MD)/scf.mn $(MD)/cc3io.dr \
		$(MD)/keydrv_cc3.sb $(MD)/joydrv_joy.sb $(MD)/snddrv_cc3.sb \
		$(MD)/windint.io $(MD)/vdgint.io \
		$(MD)/term_win40.dt \
		$(MD)/w.dw $(MD)/w1.dw $(MD)/w2.dw $(MD)/w3.dw $(MD)/w4.dw \
		$(MD)/w5.dw $(MD)/w6.dw $(MD)/w7.dw \
		$(MD)/pipeman.mn $(MD)/piper.dr $(MD)/pipe.dd \
		$(MD)/clock_60hz $(MD)/clock2_soft

BOOTFILE_WIN80_DS80	= $(MD)/krnp2 $(MD)/ioman $(MD)/init \
		$(MD)/rbf.mn \
		$(MD)/rb1773.dr $(MD)/d0_80d.dd $(MD)/d1_40d.dd \
		$(MD)/ddd0_80d.dd \
		$(MD)/scf.mn $(MD)/cc3io.dr \
		$(MD)/keydrv_cc3.sb $(MD)/joydrv_joy.sb $(MD)/snddrv_cc3.sb \
		$(MD)/windint.io $(MD)/vdgint.io \
		$(MD)/term_win80.dt \
		$(MD)/w.dw $(MD)/w1.dw $(MD)/w2.dw $(MD)/w3.dw $(MD)/w4.dw \
		$(MD)/w5.dw $(MD)/w6.dw $(MD)/w7.dw \
		$(MD)/pipeman.mn $(MD)/piper.dr $(MD)/pipe.dd \
		$(MD)/clock_60hz $(MD)/clock2_soft
