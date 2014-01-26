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

PORT = dalpha
include $(NITROS9DIR)/rules.mak

# Module directory
MD		= ../modules

DEPENDS		= ./makefile

KERNEL		= $(MD)/rel $(MD)/krn $(MD)/krnp2 $(MD)/init \
		  $(MD)/boot_d64

#Dragon Alpha Bootfiles

BOOTFILE_COVDG_SS80 = $(MD)/ioman \
		$(MD)/rbf.mn $(MD)/ddisk.dr \
		$(MD)/ddd0_80s.dd\
		$(MD)/d0_80s.dd $(MD)/d1_80s.dd \
		$(MD)/d2_80s.dd $(MD)/d3_80s.dd \
		$(MD)/scf.mn \
		$(MD)/vtio.dr $(MD)/covdg.io $(MD)/term_vdg.dt \
		$(MD)/scdpp.dr $(MD)/p_dpp.dd \
		$(MD)/pipeman.mn $(MD)/piper.dr $(MD)/pipe.dd \
		$(MD)/clock_50hz $(MD)/clock2_soft \
		$(MD)/sysgo_dd

BOOTFILE_COHR_SS80 = $(MD)/ioman \
		$(MD)/rbf.mn $(MD)/ddisk.dr \
		$(MD)/ddd0_80s.dd\
		$(MD)/d0_80s.dd $(MD)/d1_80s.dd \
		$(MD)/d2_80s.dd $(MD)/d3_80s.dd \
		$(MD)/scf.mn \
		$(MD)/vtio.dr $(MD)/cohr.io $(MD)/term_hr.dt \
		$(MD)/scdpp.dr $(MD)/p_dpp.dd \
		$(MD)/pipeman.mn $(MD)/piper.dr $(MD)/pipe.dd \
		$(MD)/clock_50hz $(MD)/clock2_soft \
		$(MD)/sysgo_dd

BOOTFILE_COVDG_DS80 = $(MD)/ioman \
		$(MD)/rbf.mn $(MD)/ddisk.dr \
		$(MD)/ddd0_80d.dd \
		$(MD)/d0_80d.dd $(MD)/d1_80d.dd \
		$(MD)/d2_80d.dd $(MD)/d3_80d.dd \
		$(MD)/scf.mn \
		$(MD)/vtio.dr $(MD)/covdg.io $(MD)/term_vdg.dt \
		$(MD)/scdpp.dr $(MD)/p_dpp.dd \
		$(MD)/pipeman.mn $(MD)/piper.dr $(MD)/pipe.dd \
		$(MD)/clock_50hz $(MD)/clock2_soft \
		$(MD)/sysgo_dd

BOOTFILE_COHR_DS80 = $(MD)/ioman \
		$(MD)/rbf.mn $(MD)/ddisk.dr \
		$(MD)/ddd0_80d.dd \
		$(MD)/d0_80d.dd $(MD)/d1_80d.dd \
		$(MD)/d2_80d.dd $(MD)/d3_80d.dd \
		$(MD)/scf.mn \
		$(MD)/vtio.dr $(MD)/cohr.io $(MD)/term_hr.dt \
		$(MD)/scdpp.dr $(MD)/p_dpp.dd \
		$(MD)/pipeman.mn $(MD)/piper.dr $(MD)/pipe.dd \
		$(MD)/clock_50hz $(MD)/clock2_soft \
		$(MD)/sysgo_dd

BOOTFILES	= bootfile_covdg_ss80 bootfile_cohr_ss80 \
		  bootfile_covdg_ds80 bootfile_cohr_ds80
		  
KERNELS		= kernel

ALLOBJS		= $(BOOTFILES) $(KERNELS)

all:	$(ALLOBJS)

echo:	
	@$(ECHO) $(BOOTFILE_COVDG_SS80)


# Dragon Alpha Disk boot
bootfile_covdg_ss80: 	$(BOOTFILE_COVDG_SS80) $(DEPENDS)
				$(MERGE) $(BOOTFILE_COVDG_SS80) > $@

bootfile_cohr_ss80: 	$(BOOTFILE_COHR_SS80) $(DEPENDS)
				$(MERGE) $(BOOTFILE_COHR_SS80) > $@

bootfile_covdg_ds80: 	$(BOOTFILE_COVDG_DS80) $(DEPENDS)
				$(MERGE) $(BOOTFILE_COVDG_DS80) > $@

bootfile_cohr_ds80: 	$(BOOTFILE_COHR_DS80) $(DEPENDS)
				$(MERGE) $(BOOTFILE_COHR_DS80) > $@

# Dragon Alpha WD2797 Kernel
kernel: $(KERNEL) $(DEPENDS)
		$(MERGE) $(KERNEL)>$@
		$(PADROM) 4096 $@

clean:
	$(RM) $(ALLOBJS)

