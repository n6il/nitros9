#
#bootfiles/makefile
#
# 2005-04-24, P.Harvey-Smith.
#	Added kernels for both DS40 and DS80 disks for Dragon 64
#	Added kernels for both SS80 and DS80 disks for Dragon Alpha
#
#
# 2005-12-31, P.Harvey-Smith,
#	Fixed up for renamed video drivers.
#
# 2006-01-08, P.Harvey-Smith,
#	Added bootrack for original Dargon Data SS40 drives.
#
# 2006-01-18, P.Harvey-Smith,
#	Added ability to build for the Tano Dragon 64, using an RS-DOS
#	disk controler and a 60Hz clock.
#

include $(NITROS9DIR)/rules.mak

# Module directory
MD		= ../modules
# Commands directory
CD		= ../cmds

DEPENDS		= ./makefile

KERNEL_D64	= $(MD)/rel $(MD)/krn $(MD)/krnp2 $(MD)/init \
		  $(MD)/boot_d64

KERNEL_D64TANO	= $(MD)/rel $(MD)/krn $(MD)/krnp2 $(MD)/init \
		  $(MD)/boot_1773_tano

KERNEL_DALPHA	= $(MD)/rel_dalpha $(MD)/krn $(MD)/krnp2 $(MD)/init \
		  $(MD)/boot_dalpha

IDE	= $(3PD)/ide
SCSI	= $(3PD)/scsisys


#Dragon 32+/64 bootfiles.

BOOTFILE_D64_DS40_32 = $(MD)/ioman \
		$(MD)/vtio.dr $(MD)/covdg.io $(MD)/term32.dt \
		$(MD)/rbf.mn $(MD)/ddisk.dr \
		$(MD)/ddd0_40d_d64.dd \
		$(MD)/d0_40d_d64.dd $(MD)/d1_40d_d64.dd \
		$(MD)/d2_40d_d64.dd $(MD)/d3_40d_d64.dd \
		$(MD)/scf.mn \
		$(MD)/printer_d64.dr $(MD)/p_d64.dd \
		$(MD)/pipeman.mn $(MD)/piper.dr $(MD)/pipe.dd \
		$(MD)/clock_50hz $(MD)/clock2_soft \
		$(MD)/sysgo_dd

BOOTFILE_D64_DS40_51 = $(MD)/ioman \
		$(MD)/vtio.dr $(MD)/cohr.io $(MD)/term51.dt \
		$(MD)/rbf.mn $(MD)/ddisk.dr \
		$(MD)/ddd0_40d_d64.dd \
		$(MD)/d0_40d_d64.dd $(MD)/d1_40d_d64.dd \
		$(MD)/d2_40d_d64.dd $(MD)/d3_40d_d64.dd \
		$(MD)/scf.mn \
		$(MD)/printer_d64.dr $(MD)/p_d64.dd \
		$(MD)/pipeman.mn $(MD)/piper.dr $(MD)/pipe.dd \
		$(MD)/clock_50hz $(MD)/clock2_soft \
		$(MD)/sysgo_dd

BOOTFILE_D64_SS40_32 = $(MD)/ioman \
		$(MD)/vtio.dr $(MD)/covdg.io $(MD)/term32.dt \
		$(MD)/rbf.mn $(MD)/ddisk.dr \
		$(MD)/ddd0_40s_d64.dd \
		$(MD)/d0_40s_d64.dd $(MD)/d1_40s_d64.dd \
		$(MD)/d2_40s_d64.dd $(MD)/d3_40s_d64.dd \
		$(MD)/scf.mn \
		$(MD)/printer_d64.dr $(MD)/p_d64.dd \
		$(MD)/pipeman.mn $(MD)/piper.dr $(MD)/pipe.dd \
		$(MD)/clock_50hz $(MD)/clock2_soft \
		$(MD)/sysgo_dd

BOOTFILE_D64_SS40_51 = $(MD)/ioman \
		$(MD)/vtio.dr $(MD)/cohr.io $(MD)/term51.dt \
		$(MD)/rbf.mn $(MD)/ddisk.dr \
		$(MD)/ddd0_40s_d64.dd \
		$(MD)/d0_40s_d64.dd $(MD)/d1_40s_d64.dd \
		$(MD)/d2_40s_d64.dd $(MD)/d3_40s_d64.dd \
		$(MD)/scf.mn \
		$(MD)/printer_d64.dr $(MD)/p_d64.dd \
		$(MD)/pipeman.mn $(MD)/piper.dr $(MD)/pipe.dd \
		$(MD)/clock_50hz $(MD)/clock2_soft \
		$(MD)/sysgo_dd

BOOTFILE_D64_DS80_32 = $(MD)/ioman \
		$(MD)/vtio.dr $(MD)/covdg.io $(MD)/term32.dt \
		$(MD)/rbf.mn $(MD)/ddisk.dr \
		$(MD)/ddd0_80_d64.dd \
		$(MD)/d0_80_d64.dd $(MD)/d1_80_d64.dd \
		$(MD)/d2_80_d64.dd $(MD)/d3_80_d64.dd \
		$(MD)/scf.mn \
		$(MD)/printer_d64.dr $(MD)/p_d64.dd \
		$(MD)/pipeman.mn $(MD)/piper.dr $(MD)/pipe.dd \
		$(MD)/clock_50hz $(MD)/clock2_soft \
		$(MD)/sysgo_dd

BOOTFILE_D64_DS80_51 = $(MD)/ioman \
		$(MD)/vtio.dr $(MD)/cohr.io $(MD)/term51.dt \
		$(MD)/rbf.mn $(MD)/ddisk.dr \
		$(MD)/ddd0_80_d64.dd \
		$(MD)/d0_80_d64.dd $(MD)/d1_80_d64.dd \
		$(MD)/d2_80_d64.dd $(MD)/d3_80_d64.dd \
		$(MD)/scf.mn \
		$(MD)/printer_d64.dr $(MD)/p_d64.dd \
		$(MD)/pipeman.mn $(MD)/piper.dr $(MD)/pipe.dd \
		$(MD)/clock_50hz $(MD)/clock2_soft \
		$(MD)/sysgo_dd

#Tano Dragon 64, using RS-Dos cartrage and 60Hz clock (NTSC)

BOOTFILE_D64TANO_DS40_32 = $(MD)/ioman \
		$(MD)/vtio.dr $(MD)/covdg.io $(MD)/term32.dt \
		$(MD)/rbf.mn $(MD)/rb1773.dr \
		$(MD)/ddd0_40d_d64tano.dd \
		$(MD)/d0_40d_d64tano.dd $(MD)/d1_40d_d64tano.dd \
		$(MD)/d2_40d_d64tano.dd $(MD)/d3_40d_d64tano.dd \
		$(MD)/scf.mn \
		$(MD)/printer_d64.dr $(MD)/p_d64.dd \
		$(MD)/pipeman.mn $(MD)/piper.dr $(MD)/pipe.dd \
		$(MD)/clock_60hz $(MD)/clock2_soft \
		$(MD)/sysgo_dd

BOOTFILE_D64TANO_DS40_51 = $(MD)/ioman \
		$(MD)/vtio.dr $(MD)/cohr.io $(MD)/term51.dt \
		$(MD)/rbf.mn $(MD)/rb1773.dr \
		$(MD)/ddd0_40d_d64tano.dd \
		$(MD)/d0_40d_d64tano.dd $(MD)/d1_40d_d64tano.dd \
		$(MD)/d2_40d_d64tano.dd $(MD)/d3_40d_d64tano.dd \
		$(MD)/scf.mn \
		$(MD)/printer_d64.dr $(MD)/p_d64.dd \
		$(MD)/pipeman.mn $(MD)/piper.dr $(MD)/pipe.dd \
		$(MD)/clock_60hz $(MD)/clock2_soft \

BOOTFILE_D64TANO_DS80_32 = $(MD)/ioman \
		$(MD)/vtio.dr $(MD)/covdg.io $(MD)/term32.dt \
		$(MD)/rbf.mn $(MD)/rb1773.dr \
		$(MD)/ddd0_80_d64tano.dd \
		$(MD)/d0_80_d64tano.dd $(MD)/d1_80_d64tano.dd \
		$(MD)/d2_80_d64tano.dd $(MD)/d3_80_d64tano.dd \
		$(MD)/scf.mn \
		$(MD)/printer_d64.dr $(MD)/p_d64.dd \
		$(MD)/pipeman.mn $(MD)/piper.dr $(MD)/pipe.dd \
		$(MD)/clock_60hz $(MD)/clock2_soft \
		$(MD)/sysgo_dd

BOOTFILE_D64TANO_DS80_51 = $(MD)/ioman \
		$(MD)/vtio.dr $(MD)/cohr.io $(MD)/term51.dt \
		$(MD)/rbf.mn $(MD)/rb1773.dr \
		$(MD)/ddd0_80_d64tano.dd \
		$(MD)/d0_80_d64tano.dd $(MD)/d1_80_d64tano.dd \
		$(MD)/d2_80_d64tano.dd $(MD)/d3_80_d64tano.dd \
		$(MD)/scf.mn \
		$(MD)/printer_d64.dr $(MD)/p_d64.dd \
		$(MD)/pipeman.mn $(MD)/piper.dr $(MD)/pipe.dd \
		$(MD)/clock_60hz $(MD)/clock2_soft \
		$(MD)/sysgo_dd

#Dragon Alpha Bootfiles

BOOTFILE_DALPHA_SS80_32 = $(MD)/ioman \
		$(MD)/vtio.dr $(MD)/covdg.io $(MD)/term32.dt \
		$(MD)/rbf.mn $(MD)/adisk.dr \
		$(MD)/ddd0_dalpha.dd\
                $(MD)/d0_dalpha.dd $(MD)/d1_dalpha.dd \
                $(MD)/d2_dalpha.dd $(MD)/d3_dalpha.dd \
                $(MD)/scf.mn \
		$(MD)/printer_d64.dr $(MD)/p_d64.dd \
		$(MD)/pipeman.mn $(MD)/piper.dr $(MD)/pipe.dd \
		$(MD)/clock_50hz $(MD)/clock2_soft \
		$(MD)/sysgo_dd

BOOTFILE_DALPHA_SS80_51 = $(MD)/ioman \
		$(MD)/vtio.dr $(MD)/cohr.io $(MD)/term51.dt \
		$(MD)/rbf.mn $(MD)/adisk.dr \
		$(MD)/ddd0_dalpha.dd\
                $(MD)/d0_dalpha.dd $(MD)/d1_dalpha.dd \
                $(MD)/d2_dalpha.dd $(MD)/d3_dalpha.dd \
                $(MD)/scf.mn \
		$(MD)/printer_d64.dr $(MD)/p_d64.dd \
		$(MD)/pipeman.mn $(MD)/piper.dr $(MD)/pipe.dd \
		$(MD)/clock_50hz $(MD)/clock2_soft \
		$(MD)/sysgo_dd

BOOTFILE_DALPHA_DS80_32 = $(MD)/ioman \
		$(MD)/vtio.dr $(MD)/covdg.io $(MD)/term32.dt \
		$(MD)/rbf.mn $(MD)/adisk.dr \
		$(MD)/ddd0_80_d64.dd \
		$(MD)/d0_80_d64.dd $(MD)/d1_80_d64.dd \
		$(MD)/d2_80_d64.dd $(MD)/d3_80_d64.dd \
                $(MD)/scf.mn \
		$(MD)/printer_d64.dr $(MD)/p_d64.dd \
		$(MD)/pipeman.mn $(MD)/piper.dr $(MD)/pipe.dd \
		$(MD)/clock_50hz $(MD)/clock2_soft \
		$(MD)/sysgo_dd

BOOTFILE_DALPHA_DS80_51 = $(MD)/ioman \
		$(MD)/vtio.dr $(MD)/cohr.io $(MD)/term51.dt \
		$(MD)/rbf.mn $(MD)/adisk.dr \
		$(MD)/ddd0_80_d64.dd \
		$(MD)/d0_80_d64.dd $(MD)/d1_80_d64.dd \
		$(MD)/d2_80_d64.dd $(MD)/d3_80_d64.dd \
                $(MD)/scf.mn \
		$(MD)/printer_d64.dr $(MD)/p_d64.dd \
		$(MD)/pipeman.mn $(MD)/piper.dr $(MD)/pipe.dd \
		$(MD)/clock_50hz $(MD)/clock2_soft \
		$(MD)/sysgo_dd

BOOTFILES	= bootfile_d64_DS40_51 bootfile_d64_DS40_32 \
		  bootfile_d64_SS40_51 bootfile_d64_SS40_32 \
		  bootfile_d64_DS80_51 bootfile_d64_DS80_32 \
		  bootfile_d64tano_DS40_51 bootfile_d64tano_DS40_32 \
		  bootfile_d64tano_DS80_51 bootfile_d64tano_DS80_32 \
		  bootfile_dalpha_SS80_32 bootfile_dalpha_SS80_51 \
		  bootfile_dalpha_DS80_32 bootfile_dalpha_DS80_51
		  
KERNELS		= kernel_d64 kernel_d64tano kernel_dalpha

ALLOBJS		= $(BOOTFILES) $(KERNELS)

all:	$(ALLOBJS)

echo:	
	@$(ECHO) $(BOOTFILE_D64_DS40_32)

# Dragon64 Disk boot
bootfile_d64_DS40_32: 	$(BOOTFILE_D64_DS40_32) $(DEPENDS)
			$(MERGE) $(BOOTFILE_D64_DS40_32)>$@

bootfile_d64_DS40_51: 	$(BOOTFILE_D64_DS40_51) $(DEPENDS)
			$(MERGE) $(BOOTFILE_D64_DS40_51)>$@
			
bootfile_d64_SS40_32: 	$(BOOTFILE_D64_DS40_32) $(DEPENDS)
			$(MERGE) $(BOOTFILE_D64_DS40_32)>$@

bootfile_d64_SS40_51: 	$(BOOTFILE_D64_DS40_51) $(DEPENDS)
			$(MERGE) $(BOOTFILE_D64_DS40_51)>$@

bootfile_d64_DS80_32: 	$(BOOTFILE_D64_DS80_32) $(DEPENDS)
			$(MERGE) $(BOOTFILE_D64_DS80_32)>$@

bootfile_d64_DS80_51: 	$(BOOTFILE_D64_DS80_51) $(DEPENDS)
			$(MERGE) $(BOOTFILE_D64_DS80_51)>$@

#Tano bootfiles
bootfile_d64tano_DS40_32: 	$(BOOTFILE_D64TANO_DS40_32) $(DEPENDS)
				$(MERGE) $(BOOTFILE_D64TANO_DS40_32)>$@

bootfile_d64tano_DS40_51: 	$(BOOTFILE_D64TANO_DS40_51) $(DEPENDS)
				$(MERGE) $(BOOTFILE_D64TANO_DS40_51)>$@

bootfile_d64tano_DS80_32: 	$(BOOTFILE_D64TANO_DS80_32) $(DEPENDS)
				$(MERGE) $(BOOTFILE_D64TANO_DS80_32)>$@

bootfile_d64tano_DS80_51: 	$(BOOTFILE_D64TANO_DS80_51) $(DEPENDS)
				$(MERGE) $(BOOTFILE_D64TANO_DS80_51)>$@

# Dragon Alpha Disk boot
bootfile_dalpha_SS80_32: 	$(BOOTFILE_DALPHA_SS80_32) $(DEPENDS)
				$(MERGE) $(BOOTFILE_DALPHA_SS80_32)>$@

bootfile_dalpha_SS80_51: 	$(BOOTFILE_DALPHA_SS80_51) $(DEPENDS)
				$(MERGE) $(BOOTFILE_DALPHA_SS80_51)>$@

bootfile_dalpha_DS80_32: 	$(BOOTFILE_DALPHA_DS80_32) $(DEPENDS)
				$(MERGE) $(BOOTFILE_DALPHA_DS80_32)>$@

bootfile_dalpha_DS80_51: 	$(BOOTFILE_DALPHA_DS80_51) $(DEPENDS)
				$(MERGE) $(BOOTFILE_DALPHA_DS80_51)>$@

# Dragon 64 WD2797 Kernel
kernel_d64: 	$(KERNEL_D64) $(DEPENDS)
		$(MERGE) $(KERNEL_D64)>$@
		$(PADROM) 4096 $@

# Tano Dragon 64 WD1773 Kernel
kernel_d64tano:	$(KERNEL_D64TANO) $(DEPENDS)
		$(MERGE) $(KERNEL_D64TANO)>$@
		$(PADROM) 4096 $@

# Dragon Alpha WD2797 Kernel
kernel_dalpha: 	$(KERNEL_D64) $(DEPENDS)
		$(MERGE) $(KERNEL_DALPHA)>$@
		$(PADROM) 4096 $@

clean:
	$(RM) $(ALLOBJS)

