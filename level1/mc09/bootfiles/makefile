include ../port.mak

# Module directory
MD		= ../modules
# Commands directory
CMDSDIR		= ../cmds

DEPENDS		= ./makefile

KERNEL_MC09SD	= $(MD)/rel $(MD)/krn $(MD)/krnp2 $(MD)/init \
		$(MD)/boot_sdc

MC09SDC_80D	= $(MD)/mc09sdc.dr $(MD)/s0_80d.dd $(MD)/s1_80d.dd $(MD)/s2_80d.dd $(MD)/s3_80d.dd

TERM_MC09       = $(MD)/mc6850.dr $(MD)/term_mc6850.dt $(MD)/term_mc6850_t0.dt $(MD)/term_mc6850_t1.dt
PIPE		= $(MD)/pipeman.mn $(MD)/piper.dr $(MD)/pipe.dd
CLOCK50HZMC09	= $(MD)/mc09clock_50hz $(MD)/clock2_soft
CLOCK50HZMC09DW	= $(MD)/mc09clock_50hz $(MD)/clock2_dw
RBDW		= $(MD)/rbdw.dr $(MD)/dwio.sb \
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

BOOTFILE_MC09SD	= $(MD)/ioman \
		$(MD)/rbf.mn \
		$(MD)/dds0_80d.dd \
		$(MC09SDC_80D) \
		$(MD)/scf.mn \
		$(TERM_MC09) \
		$(PIPE) \
		$(CLOCK50HZMC09) \
		$(MD)/sysgo_dd

BOOTFILES	= bootfile_mc09sd
KERNELS		= kernel_mc09sd

ALLOBJS		= $(BOOTFILES) $(KERNELS)

all:	$(ALLOBJS)

bootfile_mc09sd: $(BOOTFILE_MC09SD) $(DEPENDS)
	$(MERGE) $(BOOTFILE_MC09SD)>$@

kernel_mc09sd: $(KERNEL_MC09SD) $(DEPENDS)
	$(MERGE) $(KERNEL_MC09SD)>$@
	$(PADROM) 4608 $@

clean:
	$(RM) $(ALLOBJS)
