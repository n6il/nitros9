include ../../rules.mak

# Module directory
MD		= ../MODULES
# Commands directory
CD		= ../CMDS

DEPENDS		= ./makefile

KERNEL_STOCK	= $(MD)/rel_32 $(MD)/boot_1773_6ms $(MD)/kernel

# OS-9 disk bootfile to allow booting from WD1773 disk controller
BOOTFILE_VDG	= $(MD)/kernelp2 $(MD)/ioman $(MD)/init \
		$(MD)/rbf.mn \
		$(MD)/cc3disk.dr $(MD)/d0_40d.dd $(MD)/d1_40d.dd \
		$(MD)/ddd0_40d.dd \
		$(MD)/rammer.dr $(MD)/r0_128k.dd \
		$(MD)/scf.mn $(MD)/cc3io.dr \
		$(MD)/keydrv_cc3.sb $(MD)/joydrv_joy.sb $(MD)/snddrv_cc3.sb \
		$(MD)/windint.io $(MD)/vdgint.io \
		$(MD)/term_vdg.dt \
		$(MD)/w.dw $(MD)/w1.dw $(MD)/w2.dw $(MD)/w3.dw $(MD)/w4.dw \
		$(MD)/w5.dw $(MD)/w6.dw $(MD)/w7.dw \
		$(MD)/pipeman.mn $(MD)/piper.dr $(MD)/pipe.dd \
		$(MD)/clock_60hz $(MD)/clock2_soft

BOOTFILE_WIN40	= $(MD)/kernelp2 $(MD)/ioman $(MD)/init \
		$(MD)/rbf.mn \
		$(MD)/cc3disk.dr $(MD)/d0_40d.dd $(MD)/d1_40d.dd \
		$(MD)/ddd0_40d.dd \
		$(MD)/scf.mn $(MD)/cc3io.dr \
		$(MD)/keydrv_cc3.sb $(MD)/joydrv_joy.sb $(MD)/snddrv_cc3.sb \
		$(MD)/windint.io $(MD)/vdgint.io \
		$(MD)/term_win40.dt \
		$(MD)/w.dw $(MD)/w1.dw $(MD)/w2.dw $(MD)/w3.dw $(MD)/w4.dw \
		$(MD)/w5.dw $(MD)/w6.dw $(MD)/w7.dw \
		$(MD)/pipeman.mn $(MD)/piper.dr $(MD)/pipe.dd \
		$(MD)/clock_60hz $(MD)/clock2_soft

BOOTFILE_WIN80	= $(MD)/kernelp2 $(MD)/ioman $(MD)/init \
		$(MD)/rbf.mn \
		$(MD)/cc3disk.dr $(MD)/d0_40d.dd $(MD)/d1_40d.dd \
		$(MD)/ddd0_40d.dd \
		$(MD)/scf.mn $(MD)/cc3io.dr \
		$(MD)/keydrv_cc3.sb $(MD)/joydrv_joy.sb $(MD)/snddrv_cc3.sb \
		$(MD)/windint.io $(MD)/vdgint.io \
		$(MD)/term_win80.dt \
		$(MD)/w.dw $(MD)/w1.dw $(MD)/w2.dw $(MD)/w3.dw $(MD)/w4.dw \
		$(MD)/w5.dw $(MD)/w6.dw $(MD)/w7.dw \
		$(MD)/pipeman.mn $(MD)/piper.dr $(MD)/pipe.dd \
		$(MD)/clock_60hz $(MD)/clock2_soft

BOOTFILES	= bootfile_vdg bootfile_win40 bootfile_win80
KERNELS		= kernel_stock

ALLOBJS		= $(BOOTFILES) $(KERNELS)

all:	$(ALLOBJS)

# Bootfiles
bootfile_vdg: $(BOOTFILE_VDG) $(DEPENDS)
	$(MERGE) $(BOOTFILE_VDG)>$@

bootfile_win40: $(BOOTFILE_WIN40) $(DEPENDS)
	$(MERGE) $(BOOTFILE_WIN40)>$@

bootfile_win80: $(BOOTFILE_WIN80) $(DEPENDS)
	$(MERGE) $(BOOTFILE_WIN80)>$@

# Kernels
kernel_stock: $(KERNEL_STOCK) $(DEPENDS)
	$(MERGE) $(KERNEL_STOCK)>$@

clean:
	$(RM) $(ALLOBJS)

