include ../../Makefile.rules

# Module directory
MD		= ../MODULES
# Commands directory
CD		= ../CMDS

DEPENDS		= ./Makefile

KERNEL_STOCK	= $(MD)/rel $(MD)/boot_1773 $(MD)/os9p1
KERNEL_DW	= $(MD)/rel $(C9)/drivewire/boot_drivewire_l2 $(MD)/os9p1

# OS-9 disk bootfile to allow booting from DriveWire (uses VDG)
BOOTFILE_DW	= $(MD)/os9p2 $(MD)/ioman $(MD)/init \
		$(MD)/rbf.mn \
		$(C9)/drivewire/drivewire_l2.dr \
		$(C9)/drivewire/ddx0_l2.dd $(C9)/drivewire/x1_l2.dd \
		$(C9)/drivewire/x2_l2.dd $(C9)/drivewire/x3_l2.dd \
		$(MD)/cc3disk.dr $(MD)/d0_40d.dd $(MD)/d1_40d.dd \
		$(MD)/ddd0_40d.dd \
		$(MD)/scf.mn $(MD)/cc3io.dr \
		$(MD)/keydrv $(MD)/joydrv_joy $(MD)/snddrv \
		$(MD)/windint.io $(MD)/vdgint.io \
		$(MD)/term_vdg.dt \
		$(MD)/w.dw $(MD)/w1.dw $(MD)/w2.dw $(MD)/w3.dw $(MD)/w4.dw \
		$(MD)/w5.dw $(MD)/w6.dw $(MD)/w7.dw \
		$(MD)/pipeman.mn $(MD)/piper.dr $(MD)/pipe.dd \
		$(MD)/clock_soft

# OS-9 disk bootfile to allow booting from WD1773 disk controller
BOOTFILE_VDG	= $(MD)/os9p2 $(MD)/ioman $(MD)/init \
		$(MD)/rbf.mn \
		$(MD)/cc3disk.dr $(MD)/d0_40d.dd $(MD)/d1_40d.dd \
		$(MD)/ddd0_40d.dd \
		$(MD)/scf.mn $(MD)/cc3io.dr \
		$(MD)/keydrv $(MD)/joydrv_joy $(MD)/snddrv \
		$(MD)/windint.io $(MD)/vdgint.io \
		$(MD)/term_vdg.dt \
		$(MD)/w.dw $(MD)/w1.dw $(MD)/w2.dw $(MD)/w3.dw $(MD)/w4.dw \
		$(MD)/w5.dw $(MD)/w6.dw $(MD)/w7.dw \
		$(MD)/pipeman.mn $(MD)/piper.dr $(MD)/pipe.dd \
		$(MD)/clock_soft

BOOTFILE_WIN40	= $(MD)/os9p2 $(MD)/ioman $(MD)/init \
		$(MD)/rbf.mn \
		$(MD)/cc3disk.dr $(MD)/d0_40d.dd $(MD)/d1_40d.dd \
		$(MD)/ddd0_40d.dd \
		$(MD)/scf.mn $(MD)/cc3io.dr \
		$(MD)/keydrv $(MD)/joydrv_joy $(MD)/snddrv \
		$(MD)/windint.io $(MD)/vdgint.io \
		$(MD)/term_win40.dt \
		$(MD)/w.dw $(MD)/w1.dw $(MD)/w2.dw $(MD)/w3.dw $(MD)/w4.dw \
		$(MD)/w5.dw $(MD)/w6.dw $(MD)/w7.dw \
		$(MD)/pipeman.mn $(MD)/piper.dr $(MD)/pipe.dd \
		$(MD)/clock_soft

BOOTFILE_WIN80	= $(MD)/os9p2 $(MD)/ioman $(MD)/init \
		$(MD)/rbf.mn \
		$(MD)/cc3disk.dr $(MD)/d0_40d.dd $(MD)/d1_40d.dd \
		$(MD)/ddd0_40d.dd \
		$(MD)/scf.mn $(MD)/cc3io.dr \
		$(MD)/keydrv $(MD)/joydrv_joy $(MD)/snddrv \
		$(MD)/windint.io $(MD)/vdgint.io \
		$(MD)/term_win80.dt \
		$(MD)/w.dw $(MD)/w1.dw $(MD)/w2.dw $(MD)/w3.dw $(MD)/w4.dw \
		$(MD)/w5.dw $(MD)/w6.dw $(MD)/w7.dw \
		$(MD)/pipeman.mn $(MD)/piper.dr $(MD)/pipe.dd \
		$(MD)/clock_soft

BOOTFILES	= bootfile_vdg bootfile_win40 bootfile_win80 \
		bootfile_drivewire
KERNELS		= kernel_stock kernel_drivewire

ALLOBJS		= $(BOOTFILES) $(KERNELS)

all:	$(ALLOBJS)
	$(CHMOD) 600 $(ALLOBJS)

# Bootfiles
bootfile_vdg: $(BOOTFILE_VDG) $(DEPENDS)
	$(MERGE) $(BOOTFILE_VDG)>$@

bootfile_win40: $(BOOTFILE_WIN40) $(DEPENDS)
	$(MERGE) $(BOOTFILE_WIN40)>$@

bootfile_win80: $(BOOTFILE_WIN80) $(DEPENDS)
	$(MERGE) $(BOOTFILE_WIN80)>$@

bootfile_drivewire: $(BOOTFILE_DW) $(DEPENDS)
	$(MERGE) $(BOOTFILE_DW)>$@

# Kernels
kernel_stock: $(KERNEL_STOCK) $(DEPENDS)
	$(MERGE) $(KERNEL_STOCK)>$@

kernel_drivewire: $(KERNEL_DW) $(DEPENDS)
	$(MERGE) $(KERNEL_DW)>$@

clean:
	$(RM) $(ALLOBJS)

