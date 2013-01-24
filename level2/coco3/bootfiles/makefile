include $(NITROS9DIR)/rules.mak

# Module directory
MD		= ../modules
# Commands directory
CD		= ../cmds

DEPENDS		= ./makefile

KERNEL_1773	= $(MD)/rel_80 $(MD)/boot_1773_6ms $(MD)/krn
KERNEL_1773_50HZ	= $(MD)/rel_80_50hz $(MD)/boot_1773_6ms $(MD)/krn
KERNEL_DW 	= $(MD)/rel_80 $(MD)/boot_dw $(MD)/krn
KERNEL_ARDUINO 	= $(MD)/rel_80 $(MD)/boot_dw_arduino $(MD)/krn
KERNEL_BECKER	= $(MD)/rel_80 $(MD)/boot_dw_becker $(MD)/krn

FLOPPY_40D = $(MD)/rb1773.dr $(MD)/d0_40d.dd $(MD)/d1_40d.dd $(MD)/d2_40d.dd
FLOPPY_80D = $(MD)/rb1773.dr $(MD)/d0_80d.dd $(MD)/d1_80d.dd $(MD)/d2_80d.dd \
		$(MD)/ddd0_80d.dd
VTIO_COGRF_40 = $(MD)/vtio.dr \
		$(MD)/keydrv_cc3.sb $(MD)/joydrv_joy.sb $(MD)/snddrv_cc3.sb \
		$(MD)/cogrf.io \
		$(MD)/term_win40.dt \
		$(MD)/w.dw $(MD)/w1.dw $(MD)/w2.dw $(MD)/w3.dw $(MD)/w4.dw \
		$(MD)/w5.dw $(MD)/w6.dw $(MD)/w7.dw
VTIO_COGRF_80 = $(MD)/vtio.dr \
		$(MD)/keydrv_cc3.sb $(MD)/joydrv_joy.sb $(MD)/snddrv_cc3.sb \
		$(MD)/cogrf.io \
		$(MD)/term_win80.dt \
		$(MD)/w.dw $(MD)/w1.dw $(MD)/w2.dw $(MD)/w3.dw $(MD)/w4.dw \
		$(MD)/w5.dw $(MD)/w6.dw $(MD)/w7.dw
VTIO_COWIN_40 = $(MD)/vtio.dr \
		$(MD)/keydrv_cc3.sb $(MD)/joydrv_joy.sb $(MD)/snddrv_cc3.sb \
		$(MD)/cowin.io \
		$(MD)/term_win40.dt \
		$(MD)/w.dw $(MD)/w1.dw $(MD)/w2.dw $(MD)/w3.dw $(MD)/w4.dw \
		$(MD)/w5.dw $(MD)/w6.dw $(MD)/w7.dw
VTIO_COWIN_80 = $(MD)/vtio.dr \
		$(MD)/keydrv_cc3.sb $(MD)/joydrv_joy.sb $(MD)/snddrv_cc3.sb \
		$(MD)/cowin.io \
		$(MD)/term_win80.dt \
		$(MD)/w.dw $(MD)/w1.dw $(MD)/w2.dw $(MD)/w3.dw $(MD)/w4.dw \
		$(MD)/w5.dw $(MD)/w6.dw $(MD)/w7.dw
RBDW       = $(MD)/rbdw.dr $(MD)/dwio.sb \
		$(MD)/x1.dd $(MD)/x2.dd $(MD)/x3.dd
RBDWARDUINO = $(MD)/rbdw.dr $(MD)/dwio_arduino.sb \
		$(MD)/x1.dd $(MD)/x2.dd $(MD)/x3.dd
RBDWBECKER = $(MD)/rbdw.dr $(MD)/dwio_becker.sb \
		$(MD)/x1.dd $(MD)/x2.dd $(MD)/x3.dd
SCDWV_NET  = $(MD)/n_scdwv.dd $(MD)/n1_scdwv.dd $(MD)/n2_scdwv.dd \
		$(MD)/n3_scdwv.dd $(MD)/n4_scdwv.dd $(MD)/n5_scdwv.dd \
		$(MD)/n6_scdwv.dd $(MD)/n7_scdwv.dd $(MD)/n8_scdwv.dd \
		$(MD)/n9_scdwv.dd $(MD)/n10_scdwv.dd $(MD)/n11_scdwv.dd \
		$(MD)/n12_scdwv.dd $(MD)/n13_scdwv.dd $(MD)/midi_scdwv.dd
SCDWV_WIN  = $(MD)/z1_scdwv.dd $(MD)/z2_scdwv.dd $(MD)/z3_scdwv.dd \
		$(MD)/z4_scdwv.dd $(MD)/z5_scdwv.dd $(MD)/z6_scdwv.dd \
		$(MD)/z7_scdwv.dd 
SCDWP     = $(MD)/scdwp.dr $(MD)/p_scdwp.dd
PIPE       = $(MD)/pipeman.mn $(MD)/piper.dr $(MD)/pipe.dd
CLOCK50HZ  = $(MD)/clock_50hz $(MD)/clock2_soft
CLOCK60HZ  = $(MD)/clock_60hz $(MD)/clock2_soft
CLOCK60HZDW = $(MD)/clock_60hz $(MD)/clock2_dw

# NitrOS-9 disk bootfile to allow booting from DriveWire server
# on a DE1 or Xilinx using Gary Becker's CoCo 3 FGPA
BOOTFILE_BECKER	= $(MD)/krnp2 $(MD)/ioman $(MD)/init \
		$(MD)/rbf.mn \
		$(RBDWBECKER) \
		$(FLOPPY_40D) \
	            $(MD)/ddd0_40d.dd \
		$(MD)/scf.mn \
		$(VTIO_COGRF_80) \
		$(MD)/scdwv.dr \
		$(SCDWV_NET) \
		$(SCDWP) \
		$(PIPE) \
		$(CLOCK60HZDW)

# NitrOS-9 disk bootfile to allow booting from DriveWire server
# on an Arduino and CoCoPort
BOOTFILE_ARDUINO	= $(MD)/krnp2 $(MD)/ioman $(MD)/init \
		$(MD)/rbf.mn \
		$(RBDWARDUINO) \
		$(FLOPPY_40D) \
                $(MD)/ddx0.dd \
		$(MD)/scf.mn \
		$(VTIO_COGRF_80) \
		$(MD)/scdwv.dr \
		$(SCDWV_NET) \
		$(SCDWP) \
		$(PIPE) \
		$(CLOCK60HZ)

# NitrOS-9 disk bootfile to allow booting from DriveWire 3 server
BOOTFILE_DW	= $(MD)/krnp2 $(MD)/ioman $(MD)/init \
		$(MD)/rbf.mn \
		$(RBDW) \
		$(FLOPPY_40D) \
                        $(MD)/ddx0.dd \
		$(MD)/scf.mn \
		$(VTIO_COGRF_80) \
		$(MD)/scdwv.dr \
		$(SCDWV_NET) \
		$(SCDWV_WIN) \
		$(SCDWP) \
		$(PIPE) \
		$(CLOCK60HZDW)
#		$(MD)/scdwv.dr \
#		$(MD)/n_scdwv.dd $(MD)/n1_scdwv.dd $(MD)/n2_scdwv.dd \
#		$(MD)/n3_scdwv.dd $(MD)/n4_scdwv.dd $(MD)/n5_scdwv.dd \
#		$(MD)/n6_scdwv.dd $(MD)/n7_scdwv.dd $(MD)/n8_scdwv.dd \
#		$(MD)/n9_scdwv.dd $(MD)/n10_scdwv.dd $(MD)/n11_scdwv.dd \
#		$(MD)/n12_scdwv.dd $(MD)/n13_scdwv.dd $(MD)/midi_scdwv.dd \

# NitrOS-9 disk bootfile to allow booting from DriveWire 3 server
# Headless mode
BOOTFILE_DW_HEADLESS	= $(MD)/krnp2 $(MD)/ioman $(MD)/init \
		$(MD)/rbf.mn \
		$(RBDW) \
          $(MD)/ddx0.dd \
		$(FLOPPY_40D) \
		$(MD)/scf.mn \
		$(MD)/scdwv.dr \
		$(MD)/term_scdwv.dt \
		$(SCDWV_NET) \
		$(SCDWP) \
		$(PIPE) \
		$(CLOCK60HZDW)

# NitrOS-9 disk bootfile to allow booting from WD1773 disk controller
BOOTFILE_40D	= $(MD)/krnp2 $(MD)/ioman $(MD)/init \
		$(MD)/rbf.mn \
                $(FLOPPY_40D) \
                $(MD)/ddd0_40d.dd \
		$(MD)/scf.mn \
		$(VTIO_COGRF_80) \
		$(PIPE) \
		$(CLOCK60HZ)

BOOTFILE_80D	= $(MD)/krnp2 $(MD)/ioman $(MD)/init \
		$(MD)/rbf.mn \
                $(FLOPPY_80D) \
                $(MD)/ddd0_80d.dd \
		$(MD)/scf.mn \
		$(VTIO_COGRF_80) \
		$(PIPE) \
		$(CLOCK60HZ)

BOOTFILE_40D_50HZ	= $(MD)/krnp2 $(MD)/ioman $(MD)/init \
		$(MD)/rbf.mn \
                $(FLOPPY_40D) \
                $(MD)/ddd0_40d.dd \
		$(MD)/scf.mn \
		$(VTIO_COGRF_80) \
		$(PIPE) \
		$(CLOCK50HZ)

BOOTFILE_80D_50HZ	= $(MD)/krnp2 $(MD)/ioman $(MD)/init \
		$(MD)/rbf.mn \
                $(FLOPPY_80D) \
                $(MD)/ddd0_80d.dd \
		$(MD)/scf.mn \
		$(VTIO_COGRF_80) \
		$(PIPE) \
		$(CLOCK50HZ)

BOOTFILES	= bootfile_40d bootfile_40d_50hz bootfile_80d bootfile_80d_50hz bootfile_dw bootfile_dw_headless bootfile_becker bootfile_arduino
KERNELS		= kernel_1773 kernel_1773_50hz kernel_dw kernel_becker kernel_arduino

ALLOBJS		= $(BOOTFILES) $(KERNELS)

all:	$(ALLOBJS)

# Bootfiles
bootfile_becker: $(BOOTFILE_BECKER) $(DEPENDS)
	$(MERGE) $(BOOTFILE_BECKER)>$@

bootfile_arduino: $(BOOTFILE_ARDUINO) $(DEPENDS)
	$(MERGE) $(BOOTFILE_ARDUINO)>$@

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

bootfile_dw_headless: $(BOOTFILE_DW_HEADLESS) $(DEPENDS)
	$(MERGE) $(BOOTFILE_DW_HEADLESS)>$@

# Kernels
kernel_becker: $(KERNEL_BECKER) $(DEPENDS)
	$(MERGE) $(KERNEL_BECKER)>$@

kernel_arduino: $(KERNEL_ARDUINO) $(DEPENDS)
	$(MERGE) $(KERNEL_ARDUINO)>$@

kernel_1773: $(KERNEL_1773) $(DEPENDS)
	$(MERGE) $(KERNEL_1773)>$@

kernel_1773_50hz: $(KERNEL_1773_50HZ) $(DEPENDS)
	$(MERGE) $(KERNEL_1773_50HZ)>$@

kernel_dw: $(KERNEL_DW) $(DEPENDS)
	$(MERGE) $(KERNEL_DW)>$@

clean:
	$(RM) $(ALLOBJS)

