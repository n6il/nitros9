include $(NITROS9DIR)/rules.mak

# Module and cmds directories
MD		= ../modules
CM		= ../cmds

DEPENDS		= ./makefile

# The _80 in rel_80 refers to 80-column screen
KERNEL_MC09SD	= $(MD)/rel_80 $(MD)/boot_sdc $(MD)/mc09krn

MC09SDC_80D	= $(MD)/mc09sdc.dr $(MD)/dds0_80d.dd $(MD)/s0_80d.dd $(MD)/s1_80d.dd $(MD)/s2_80d.dd $(MD)/s3_80d.dd

TERM_MC09       = $(MD)/mc6850.dr $(MD)/term_mc6850.dt $(MD)/term_mc6850_t0.dt $(MD)/term_mc6850_t1.dt

CLOCK50HZMC09	= $(MD)/mc09clock_50hz $(MD)/clock2_soft

# [NAC HACK 2016Nov30] find out what's actually needed for DW support.
# [NAC HACK 2016Nov30] currently I'm pulling in DW but not using SCDWV_NET or SCDWP or CLOCK50HZDW
DW              = $(MD)/rbdw.dr $(MD)/dwio.sb \
		$(MD)/x1.dd $(MD)/x2.dd $(MD)/x3.dd
SCDWV_NET  = $(MD)/n_scdwv.dd $(MD)/n1_scdwv.dd $(MD)/n2_scdwv.dd \
		$(MD)/n3_scdwv.dd $(MD)/n4_scdwv.dd $(MD)/n5_scdwv.dd \
		$(MD)/n6_scdwv.dd $(MD)/n7_scdwv.dd $(MD)/n8_scdwv.dd \
		$(MD)/n9_scdwv.dd $(MD)/n10_scdwv.dd $(MD)/n11_scdwv.dd \
		$(MD)/n12_scdwv.dd $(MD)/n13_scdwv.dd $(MD)/midi_scdwv.dd
SCDWP     = $(MD)/scdwp.dr $(MD)/p_scdwp.dd
PIPE       = $(MD)/pipeman.mn $(MD)/piper.dr $(MD)/pipe.dd
CLOCK50HZMC09DW = $(MD)/mc09clock_50hz $(MD)/clock2_dw

BOOTFILE_MC09SD	= $(MD)/krnp2 $(MD)/ioman $(MD)/init \
		$(MD)/rbf.mn \
		$(MC09SDC_80D) \
		$(MD)/scf.mn \
		$(TERM_MC09) \
		$(PIPE) \
		$(CLOCK50HZMC09)

BOOTFILE_MC09SDXL = $(MD)/krnp2 $(MD)/ioman $(MD)/init \
		$(MD)/rbf.mn \
		$(MC09SDC_80D) \
		$(MD)/scf.mn \
		$(TERM_MC09) \
		$(PIPE) \
		$(CLOCK50HZMC09) $(CM)/shell


BOOTFILES	= bootfile_mc09sd bootfile_mc09sdxl
KERNELS		= kernel_mc09sd

ALLOBJS		= $(BOOTFILES) $(KERNELS)

all:	$(ALLOBJS)

bootfile_mc09sd: $(BOOTFILE_MC09SD) $(DEPENDS)
	$(MERGE) $(BOOTFILE_MC09SD)>$@

bootfile_mc09sdxl: $(BOOTFILE_MC09SDXL) $(DEPENDS)
	$(MERGE) $(BOOTFILE_MC09SDXL)>$@

kernel_mc09sd: $(KERNEL_MC09SD) $(DEPENDS)
	$(MERGE) $(KERNEL_MC09SD)>$@

clean:
	$(RM) $(ALLOBJS)
