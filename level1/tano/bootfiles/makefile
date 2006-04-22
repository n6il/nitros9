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

PORT = tano
include $(NITROS9DIR)/rules.mak

# Module directory
MD		= ../modules
# Commands directory
CD		= ../cmds

DEPENDS		= ./makefile

KERNEL_D64TANO	= $(MD)/rel $(MD)/krn $(MD)/krnp2 $(MD)/init \
		  $(MD)/boot_1773_tano

IDE	= $(3PD)/ide
SCSI	= $(3PD)/scsisys


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

BOOTFILES	= bootfile_d64tano_DS40_51 bootfile_d64tano_DS40_32 \
		  bootfile_d64tano_DS80_51 bootfile_d64tano_DS80_32
		  
KERNELS		= kernel_d64tano

ALLOBJS		= $(BOOTFILES) $(KERNELS)

all:	$(ALLOBJS)

echo:	
	@$(ECHO) $(BOOTFILE_D64_DS40_32)

#Tano bootfiles
bootfile_d64tano_DS40_32: 	$(BOOTFILE_D64TANO_DS40_32) $(DEPENDS)
				$(MERGE) $(BOOTFILE_D64TANO_DS40_32)>$@

bootfile_d64tano_DS40_51: 	$(BOOTFILE_D64TANO_DS40_51) $(DEPENDS)
				$(MERGE) $(BOOTFILE_D64TANO_DS40_51)>$@

bootfile_d64tano_DS80_32: 	$(BOOTFILE_D64TANO_DS80_32) $(DEPENDS)
				$(MERGE) $(BOOTFILE_D64TANO_DS80_32)>$@

bootfile_d64tano_DS80_51: 	$(BOOTFILE_D64TANO_DS80_51) $(DEPENDS)
				$(MERGE) $(BOOTFILE_D64TANO_DS80_51)>$@

# Tano Dragon 64 WD1773 Kernel
kernel_d64tano:	$(KERNEL_D64TANO) $(DEPENDS)
		$(MERGE) $(KERNEL_D64TANO)>$@
		$(PADROM) 4096 $@

clean:
	$(RM) $(ALLOBJS)

