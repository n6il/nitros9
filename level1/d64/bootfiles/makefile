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

PORT = d64
include $(NITROS9DIR)/rules.mak

# Module directory
MD		= ../modules
# Commands directory
CD		= ../cmds

DEPENDS		= ./makefile

KERNEL_DRAGON	= $(MD)/rel $(MD)/krn $(MD)/krnp2 $(MD)/init \
		  $(MD)/boot_d64

IDE	= $(3PD)/ide
SCSI	= $(3PD)/scsisys


BOOTFILE_COVDG_DS40 = $(MD)/ioman \
		$(MD)/rbf.mn $(MD)/ddisk.dr \
		$(MD)/ddd0_40d.dd \
		$(MD)/d0_40d.dd $(MD)/d1_40d.dd \
		$(MD)/d2_40d.dd $(MD)/d3_40d.dd\
		$(MD)/scf.mn \
		$(MD)/vtio.dr $(MD)/covdg.io $(MD)/term32.dt \
		$(MD)/scdpp.dr $(MD)/p_dpp.dd \
		$(MD)/pipeman.mn $(MD)/piper.dr $(MD)/pipe.dd \
		$(MD)/clock_60hz $(MD)/clock2_soft \
		$(MD)/sysgo_dd

BOOTFILE_COHR_DS40 = $(MD)/ioman \
		$(MD)/rbf.mn $(MD)/ddisk.dr \
		$(MD)/ddd0_40d.dd \
		$(MD)/d0_40d.dd $(MD)/d1_40d.dd \
		$(MD)/d2_40d.dd $(MD)/d3_40d.dd\
		$(MD)/scf.mn \
		$(MD)/vtio.dr $(MD)/cohr.io $(MD)/term51.dt \
		$(MD)/scdpp.dr $(MD)/p_dpp.dd \
		$(MD)/pipeman.mn $(MD)/piper.dr $(MD)/pipe.dd \
		$(MD)/clock_60hz $(MD)/clock2_soft \
		$(MD)/sysgo_dd

BOOTFILE_COVDG_DS80 = $(MD)/ioman \
		$(MD)/rbf.mn $(MD)/ddisk.dr \
		$(MD)/ddd0_80d.dd \
		$(MD)/d0_80d.dd $(MD)/d1_80d.dd \
		$(MD)/d2_80d.dd $(MD)/d3_80d.dd \
		$(MD)/scf.mn \
		$(MD)/vtio.dr $(MD)/covdg.io $(MD)/term32.dt \
		$(MD)/scdpp.dr $(MD)/p_dpp.dd \
		$(MD)/pipeman.mn $(MD)/piper.dr $(MD)/pipe.dd \
		$(MD)/clock_60hz $(MD)/clock2_soft \
		$(MD)/sysgo_dd

BOOTFILE_COHR_DS80 = $(MD)/ioman \
		$(MD)/rbf.mn $(MD)/ddisk.dr \
		$(MD)/ddd0_80d.dd \
		$(MD)/d0_80d.dd $(MD)/d1_80d.dd \
		$(MD)/d2_80d.dd $(MD)/d3_80d.dd\
		$(MD)/scf.mn \
		$(MD)/vtio.dr $(MD)/cohr.io $(MD)/term51.dt \
		$(MD)/scdpp.dr $(MD)/p_dpp.dd \
		$(MD)/pipeman.mn $(MD)/piper.dr $(MD)/pipe.dd \
		$(MD)/clock_60hz $(MD)/clock2_soft \
		$(MD)/sysgo_dd

BOOTFILE_COVDG_SS40 = $(MD)/ioman \
		$(MD)/rbf.mn $(MD)/ddisk.dr \
		$(MD)/ddd0_40d.dd \
		$(MD)/d0_40s.dd $(MD)/d1_40s.dd \
		$(MD)/d2_40s.dd $(MD)/d3_40s.dd\
		$(MD)/scf.mn \
		$(MD)/vtio.dr $(MD)/covdg.io $(MD)/term32.dt \
		$(MD)/scdpp.dr $(MD)/p_dpp.dd \
		$(MD)/pipeman.mn $(MD)/piper.dr $(MD)/pipe.dd \
		$(MD)/clock_60hz $(MD)/clock2_soft \
		$(MD)/sysgo_dd

BOOTFILE_COHR_SS40 = $(MD)/ioman \
		$(MD)/rbf.mn $(MD)/ddisk.dr \
		$(MD)/ddd0_40d.dd \
		$(MD)/d0_40s.dd $(MD)/d1_40s.dd \
		$(MD)/d2_40s.dd $(MD)/d3_40s.dd\
		$(MD)/scf.mn \
		$(MD)/vtio.dr $(MD)/cohr.io $(MD)/term51.dt \
		$(MD)/scdpp.dr $(MD)/p_dpp.dd \
		$(MD)/pipeman.mn $(MD)/piper.dr $(MD)/pipe.dd \
		$(MD)/clock_60hz $(MD)/clock2_soft \
		$(MD)/sysgo_dd


BOOTFILES	= bootfile_cohr_ds40 bootfile_covdg_ds40 \
		  bootfile_cohr_ds80 bootfile_covdg_ds80 \
		  bootfile_cohr_ss40 bootfile_covdg_ss40
		  
KERNELS		= kernel

ALLOBJS		= $(BOOTFILES) $(KERNELS)

all:	$(ALLOBJS)

echo:	
	@$(ECHO) $(BOOTFILE_COVDG_DS40)

bootfile_covdg_ds40: 	$(BOOTFILE_COVDG_DS40) $(DEPENDS)
				$(MERGE) $(BOOTFILE_COVDG_DS40)>$@

bootfile_cohr_ds40: 	$(BOOTFILE_COHR_DS40) $(DEPENDS)
				$(MERGE) $(BOOTFILE_COHR_DS40)>$@

bootfile_covdg_ds80: 	$(BOOTFILE_COVDG_DS80) $(DEPENDS)
				$(MERGE) $(BOOTFILE_COVDG_DS80)>$@

bootfile_cohr_ds80: 	$(BOOTFILE_COHR_DS80) $(DEPENDS)
				$(MERGE) $(BOOTFILE_COHR_DS80)>$@

bootfile_covdg_ss40: 	$(BOOTFILE_COVDG_SS40) $(DEPENDS)
				$(MERGE) $(BOOTFILE_COVDG_SS40)>$@

bootfile_cohr_ss40: 	$(BOOTFILE_COHR_SS40) $(DEPENDS)
				$(MERGE) $(BOOTFILE_COHR_SS40)>$@

kernel:	$(KERNEL_DRAGON) $(DEPENDS)
		$(MERGE) $(KERNEL_DRAGON)>$@
		$(PADROM) 4096 $@

clean:
	$(RM) $(ALLOBJS)

